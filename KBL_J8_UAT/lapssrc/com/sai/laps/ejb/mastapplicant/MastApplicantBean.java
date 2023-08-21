package com.sai.laps.ejb.mastapplicant;
import java.sql.Blob;
import java.rmi.RemoteException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.ArrayList;
import com.sai.laps.ejb.attachphoto.AttachPhotoBean;
import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Statement;
import java.text.SimpleDateFormat;

import com.sai.laps.helper.ApplicantParams;
import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.ConnectionFactory;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.MISLogger;
import com.sai.laps.helper.SAILogger;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "MastApplicantBean", mappedName = "MastApplicantHome")
@Remote (MastApplicantRemote.class)
public class MastApplicantBean extends BeanAdapter
{
	static Logger log=Logger.getLogger(MastApplicantBean.class);	
	private static final long serialVersionUID = 1L;

	/**
	*	Function  getMasterSearch This Method is used to  get all the
	*	demographics details of the personal application form
	*	satisfing the search condition
	*	@param hshValues     
	*   @return HashMap		 
	*	@exception java.lang.Exception
	*/

	public HashMap getMasterSearch(HashMap hshValues) 
	{
		String strQuery="",strQuery1= "";
		String absPosition="";
		ResultSet rs=null;
		ResultSet rs1=null;
		ResultSet rs2=null;
		ResultSet rs3=null;
		ResultSet rs4=null;
		HashMap hshResult=new HashMap();
		ArrayList arryRow=new ArrayList();
		ArrayList arryCol=null;
		String strradioValues=null;
		String strSearchText=null;
		String strCheckCBS=null;
		String cbsdata="FALSE";
		String strOrgname="";
		String strOrgNameFromSolID="";
		String strLAPSIDFromCBSID="";
		String strText="";
		String strOwnerList= correctNull((String)hshValues.get("ownerList"));
		String strJointSecurity= correctNull((String)hshValues.get("jointSecurity"));
		String strStatus="",strPage="",strPerFlag="",strActivityCode="",strCBS="",strBlock="";
		try
		{			
			String strOrgSelect=correctNull((String)hshValues.get("strOrgSelect"));
			if(strOrgSelect.equalsIgnoreCase("001001"))
			{
				strOrgSelect="001";
			}
			absPosition = correctNull((String)hshValues.get("hid_rowcount"));	
			/*
			 * By default value for the field checkcbs is coming as "Y". 
			 * Bcoz they are passing the value Y
			 */
			
			strCheckCBS = correctNull((String)hshValues.get("checkcbs"));
			strOrgname=correctNull((String)hshValues.get("strOrgName"));
			String strAppid=correctNull((String)hshValues.get("hidDemoId"));
			strPage=correctNull((String)hshValues.get("pageType"));
			
			strSearchText=Helper.correctSingleQuote(correctNull((String)hshValues.get("txtsearch")));						
		if(strJointSecurity.equals("JointSecurity")&&(!strOwnerList.equals("")&&!strOwnerList.equals("@")))
		{
			strOwnerList=strOwnerList.substring(1, strOwnerList.length());
			strOwnerList=strOwnerList.replaceAll("@","','");
			if(strSearchText.equals(""))
			{
				strSearchText="%";
			}
			strradioValues=correctNull((String)hshValues.get("radiobutton"));
			if(strradioValues.equalsIgnoreCase("first"))
			{
				strText= "and perapp_oldid not in ('"+strOwnerList+"') and upper(perapp_fname) like upper('%"+strSearchText+"%') Order by perapp_fname";	
			}
			else if(strradioValues.equalsIgnoreCase("CBSID"))
			{
				strText=  "and perapp_oldid not in ('"+strOwnerList+"') and perapp_cbsid = '"+strSearchText+"' Order by perapp_fname";
			}
			else if(strradioValues.equalsIgnoreCase("LAPSID"))
			{
				strText="and perapp_oldid not in ('"+strOwnerList+"') and perapp_oldid = '"+strSearchText+"' Order by perapp_fname";
			}
			else if(strradioValues.equalsIgnoreCase("PANNO"))
			{
				strText= "and perapp_oldid not in ('"+strOwnerList+"') and perapp_panno = '"+strSearchText+"' Order by perapp_fname";
			}
			else 
			{
				strText=  " Order by perapp_fname";	
			}
		}
		else if(strPage.equalsIgnoreCase("security"))
		{

			if(strSearchText.equals(""))
			{
				strSearchText="%";
			}
			strradioValues=correctNull((String)hshValues.get("radiobutton"));
			if(strradioValues.equalsIgnoreCase("first"))
			{
				strText= " and upper(perapp_fname) like upper('%"+strSearchText+"%') and perapp_oldid not in ('"+strAppid+"') Order by perapp_fname";	
			}
			else if(strradioValues.equalsIgnoreCase("CBSID"))
			{
				strText=  " and perapp_cbsid = '"+strSearchText+"' and perapp_oldid not in ('"+strAppid+"') Order by perapp_fname";
			}
			else if(strradioValues.equalsIgnoreCase("LAPSID"))
			{
				strText=" and perapp_oldid = '"+strSearchText+"' and perapp_oldid not in ('"+strAppid+"')Order by perapp_fname";
			}
			else if(strradioValues.equalsIgnoreCase("PANNO"))
			{
				strText= " and perapp_panno = '"+strSearchText+"' Order by perapp_fname";
			}
			else if(strradioValues.equalsIgnoreCase("SECID"))
			{
				strText= "and perapp_oldid in (select cus_owner_laps_id from CUS_SECURITY_OWNERSHIP where CUS_OWNER_SECURITY_ID='"+strSearchText+"' and cus_owner_sno='1')";
			}
			else 
			{
				strText=  " Order by perapp_fname";	
			}
		
		}
		else
		{
			if(strSearchText.equals(""))
			{
				strSearchText="%";
			}
			strradioValues=correctNull((String)hshValues.get("radiobutton"));
			if(strradioValues.equalsIgnoreCase("first"))
			{
				strText= " and upper(perapp_fname) like upper('%"+strSearchText+"%')  Order by perapp_fname";	
			}
			else if(strradioValues.equalsIgnoreCase("CBSID"))
			{
				strText=  " and perapp_cbsid = '"+strSearchText+"' Order by perapp_fname";
			}
			else if(strradioValues.equalsIgnoreCase("LAPSID"))
			{
				strText=" and perapp_oldid = '"+strSearchText+"' Order by perapp_fname";
			}
			else if(strradioValues.equalsIgnoreCase("PANNO"))
			{
				strText= " and perapp_panno = '"+strSearchText+"' Order by perapp_fname";
			}
			else if(strradioValues.equalsIgnoreCase("SECID"))
			{
				strText= "and perapp_oldid in (select cus_owner_laps_id from CUS_SECURITY_OWNERSHIP where CUS_OWNER_SECURITY_ID='"+strSearchText+"' and cus_owner_sno='1')";
			}
			
			/*else if(strradioValues.equalsIgnoreCase("DIGIAPP"))
			{
				strText= "";
			}*/
			
			else 
			{
				strText=  " Order by perapp_fname";	
			}
		}
			/*
			 * Other than Name search all other search options are global
			 */
			
			if(strradioValues.equalsIgnoreCase("first"))
			{
				strOrgSelect=strOrgSelect;
			}
			else
			{
				strOrgSelect="001";
			}
			if(strJointSecurity.equals("JointSecurity")&&(!strOwnerList.equals("")&&!strOwnerList.equals("@")))
			{
				strQuery= SQLParser.getSqlQuery("reailmastsearch^"+strOrgSelect+"%"+"^"+strText);
				rs=DBUtils.executeQuery(strQuery);
			}else if(strradioValues.equalsIgnoreCase("CBSID") && strCheckCBS.equalsIgnoreCase("Y"))
			{
				boolean exbool=false;
				
				if(strPage.equalsIgnoreCase("sec"))
				{
					strQuery= SQLParser.getSqlQuery("corpmastsearch^"+strOrgSelect+"%"+"^"+strText);
					rs=DBUtils.executeQuery(strQuery);
				}else{
				/*
				 * Added by prakash. The customer search should always hit CBS DataBase
				 */
				if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
				{
					strQuery=SQLParser.getCBSSqlQuery("cbscusmastersearch_newconnection^"+strSearchText);
					rs=DBUtils.executeQueryCBSConnection(strQuery);
				}
				else
				{
					strQuery= SQLParser.getSqlQuery("cbscusmastersearch^"+strSearchText);
					rs=DBUtils.executeQuery(strQuery); 
				}
				}
				cbsdata="TRUE";
			}
			else if(strradioValues.equalsIgnoreCase("APPNO"))
			{
				if(rs1!=null)
				{
					rs1.close();
				}
				strQuery= SQLParser.getSqlQuery("sel_perm_check^"+strSearchText);
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next()){
					strPerFlag = "Y";
					strQuery= SQLParser.getSqlQuery("sel_per_details^"+"^"+strSearchText);
					rs=DBUtils.executeQuery(strQuery);
				}else{
				strQuery= SQLParser.getSqlQuery("sel_facclosure_appno^"+strSearchText+"^"+strSearchText);
				rs=DBUtils.executeQuery(strQuery);
				}
			}
			
			else if(strradioValues.equalsIgnoreCase("DIGIAPP"))
			{
			
				strQuery= SQLParser.getSqlQuery("sel_by_digiApp^"+strSearchText);
				rs=DBUtils.executeQuery(strQuery);
			}
			
			else
			{
				strQuery= SQLParser.getSqlQuery("reailmastsearch^"+strOrgSelect+"%"+"^"+strText);
				rs=DBUtils.executeQuery(strQuery);
			}
			rs.last();
			int RowCount = rs.getRow();		
			/*if(RowCount==0 && strradioValues.equalsIgnoreCase("LAPSID"))
			{
				rs=DBUtils.executeQuery(strQuery);
			}
			rs.last();
			RowCount = rs.getRow();
			if(RowCount==0 && strradioValues.equalsIgnoreCase("PANNO"))
			{
				rs=DBUtils.executeQuery(strQuery);
			}*/
			rs.beforeFirst();				
			if(RowCount != 0)
			{					
				if (!absPosition.equals("0"))
				{
					if(Integer.parseInt(absPosition) > RowCount)
					{
						rs.absolute(RowCount);
					}
					else
					{
						rs.absolute(Integer.parseInt(absPosition));
					}				
				}			
			}
			while(rs.next())
			{
				arryCol=new ArrayList();
				if(strradioValues.equalsIgnoreCase("CBSID")&&!(strJointSecurity.equals("JointSecurity") || strPage.equalsIgnoreCase("sec")))
				{
					arryCol.add(correctNull((String)rs.getString("cust_id")));//0
					arryCol.add(correctNull((String)rs.getString("cust_name")).toUpperCase());//1
					arryCol.add(correctNull((String)rs.getString("pan_gir_num")));//2
					String strSolID=Helper.correctNull((String)rs.getString("solid"));
					String strDigipanno=Helper.correctNull((String)rs.getString("pan_gir_num"));
					String strDigiID=Helper.correctNull((String)rs.getString("ID_DOC"));
					String strDigiIDNO=Helper.correctNull((String)rs.getString("ID_NUMBER"));
					if(!strSolID.equalsIgnoreCase(""))
					{
						if(rs1!=null)
						{
							rs1.close();
						}
						String strQuery2=SQLParser.getSqlQuery("selectorgappl^"+strSolID);
						rs1=DBUtils.executeQuery(strQuery2);
						if(rs1.next())
						{
							strOrgNameFromSolID=Helper.correctNull((String)rs1.getString("org_name"));
						}
					}
					arryCol.add(strOrgNameFromSolID);//3
					String strCBSID=Helper.correctNull((String)rs.getString("cust_id"));
					String strDigiAddressFlag="",strDigiPANflag="", strDigiCBScustFlag="",strDigiperappid="",strDigiucicperappid="",strdigidesc="";
					if(!strCBSID.equalsIgnoreCase(""))
					{
						if(rs1!=null)
						{
							rs1.close();
						}
						strQuery=SQLParser.getSqlQuery("sel_lapsidfromcbsid^"+strCBSID);
						rs1=DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							strLAPSIDFromCBSID=Helper.correctNull((String)rs1.getString("perapp_oldid"));
							strStatus=Helper.correctNull((String)rs1.getString("perapp_profilestatus"));
							if(strStatus.equalsIgnoreCase(""))
								strStatus="N";
							
							strDigiAddressFlag=Helper.correctNull((String)rs1.getString("PERAPP_ADDRESSCHANGE_FLAG"));
							strDigiPANflag=Helper.correctNull((String)rs1.getString("PERAPP_PAN_FLAG"));
							strDigiCBScustFlag=Helper.correctNull((String)rs1.getString("PERAPP_CBSCUSTFLAG"));
							strDigiperappid=Helper.correctNull((String)rs1.getString("perapp_id"));
							
						}
						
						if(rs1!=null)
						{
							rs1.close();
						}
						/*strQuery=SQLParser.getCBSSqlQuery("sel_lapsidfromcbsiducic^"+strCBSID);
						rs1=DBUtils.executeQueryCBSConnection(strQuery);
						if(rs1.next())
						{
							strDigipanno=Helper.correctNull((String)rs1.getString("pan_gir_num"));
							strDigiID=Helper.correctNull((String)rs1.getString("ID_DOC"));
							
							
							strDigiIDNO=Helper.correctNull((String)rs1.getString("ID_NUMBER"));*/
							if(!strDigiIDNO.equalsIgnoreCase(""))
								{
								if(strDigiID.equalsIgnoreCase("GSTAX"))
								{
									strdigidesc ="perapp_panno='"+strDigipanno+"' or COMINFO_GSTIN='"+strDigiIDNO+"'";
								}else if(strDigiID.equalsIgnoreCase("ADHAAR")){
									strdigidesc="perapp_panno='"+strDigipanno+"' or perapp_aadhaar='"+strDigiIDNO+"'";
								}else{
									strdigidesc="perapp_panno='"+strDigipanno+"'";
								}
									if(rs2!=null)
									{
										rs2.close();
									}
									strQuery=SQLParser.getSqlQuery("sel_lapsucic^"+strdigidesc);
									rs2=DBUtils.executeQuery(strQuery);
									if(rs2.next())
									{
										strDigiucicperappid=Helper.correctNull((String)rs2.getString("perapp_id"));
			
										if(rs3!=null)
										{
											rs3.close();
										}
										strQuery=SQLParser.getSqlQuery("sel_lapsucicpropo^"+strDigiucicperappid+"^"+strDigiucicperappid+"^"+strDigiucicperappid);
										rs3=DBUtils.executeQuery(strQuery);
										if(rs3.next())
										{
											hshResult.put("ucicFlag","Y");
										}
									}
								}
						//}
					}
					arryCol.add(strLAPSIDFromCBSID);//4
					arryCol.add(correctNull((String)rs.getString("cust_id")));//5
					arryCol.add(cbsdata);//6
					arryCol.add(strStatus);//7
					arryCol.add(correctNull((String)rs.getString("CUST_WITH_DUP_ID_CNT")));//8
					arryCol.add("");//9
					
					if( (strDigiAddressFlag.equals("Y") || strDigiPANflag.equals("Y")) && strDigiCBScustFlag.equals("N") )
					{
						arryCol.add(strDigiperappid);//10
					}
					else
					{
						arryCol.add("");//10
					}
					//arryCol.add("");
					
					String panNo="",strMob="",strRefNo="";
					
					if(rs1!=null)
					{
						rs1.close();
					}
					/*strQuery=SQLParser.getSqlQuery("cbscusmastersearch^"+strCBSID);
					rs1=DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						panNo=Helper.correctNull(rs1.getString("pan_gir_num"));
						//strAadhar=Helper.correctNull(rs1.getString("perapp_aadhaar"));
						strMob=Helper.correctNull(rs1.getString("cust_comu_phone_num_1"));
						strRefNo=Helper.correctNull(rs1.getString("id_number"));
										
						strQuery=SQLParser.getSqlQuery("sel_existing_cust^"+panNo+"^"+strMob+"^"+strRefNo+"^"+panNo+"^"+strMob+"^"+strRefNo+"^"+panNo+"^"+strMob+"^"+strRefNo);
						rs2=DBUtils.executeQuery(strQuery);
						if(rs2.next())
						{
							
							
							arryCol.add("block");//11
							
						}
						
						else{
						
						arryCol.add("");//11
						}
					}*/
					arryCol.add("");

				}
				else
				{
					if(strPerFlag.equalsIgnoreCase("Y")){
					arryCol.add(correctNull((String)rs.getString("perapp_id")));//0
					arryCol.add(correctNull((String)rs.getString("PG_APPLIANTNAME")));//1
					arryCol.add(correctNull((String)rs.getString("perapp_panno")));//2
					arryCol.add(correctNull((String)rs.getString("org_name")));//3
					arryCol.add(correctNull((String)rs.getString("perapp_oldid"))); //Shahul//4
					arryCol.add(correctNull((String)rs.getString("dev_cbsid")));//5
					strStatus=Helper.correctNull((String)rs.getString("perapp_profilestatus"));
					if(strStatus.equalsIgnoreCase(""))
						strStatus="N";
					arryCol.add(cbsdata);//6
					arryCol.add(strStatus);//7
					arryCol.add("0");//8
					strActivityCode="";
					}else{
						arryCol.add(correctNull((String)rs.getString("perapp_id")));//0
						arryCol.add(correctNull((String)rs.getString("perapp_fname")).toUpperCase());//1
						arryCol.add(correctNull((String)rs.getString("perapp_panno")));//2
						arryCol.add(correctNull((String)rs.getString("org_name")));//3
						arryCol.add(correctNull((String)rs.getString("perapp_oldid"))); //Shahul//4
						arryCol.add(correctNull((String)rs.getString("perapp_cbsid")));//5
						strStatus=Helper.correctNull((String)rs.getString("perapp_profilestatus"));
						if(strStatus.equalsIgnoreCase(""))
							strStatus="N";
						arryCol.add(cbsdata);//6
						arryCol.add(strStatus);//7
						arryCol.add("0");//8
						strActivityCode="";
					}
					if(rs1!=null)
						rs1.close();
					if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
					{
						if(strPerFlag.equalsIgnoreCase("Y")){
						strQuery=SQLParser.getCBSSqlQuery("cbscusmastersearch_newconnection^"+Helper.correctNull(rs.getString("dev_cbsid")));
						}else{
						strQuery=SQLParser.getCBSSqlQuery("cbscusmastersearch_newconnection^"+Helper.correctNull(rs.getString("perapp_cbsid")));
						}
						rs1=DBUtils.executeQueryCBSConnection(strQuery);
					}
					else
					{
						if(strPerFlag.equalsIgnoreCase("Y")){
							strQuery=SQLParser.getCBSSqlQuery("cbscusmastersearch^"+Helper.correctNull(rs.getString("dev_cbsid")));
							}else{
						strQuery= SQLParser.getSqlQuery("cbscusmastersearch^"+Helper.correctNull(rs.getString("perapp_cbsid")));}
						rs1=DBUtils.executeQuery(strQuery); 
					}
					if(rs1.next())
					{
						strActivityCode=Helper.correctNull(rs1.getString("cust_occp_code"));
					}
					
					if(rs1!=null)
					{
						rs1.close();
					}
					strQuery=SQLParser.getSqlQuery("sel_applKYCNorms^"+Helper.correctNull(rs.getString("perapp_id")));
					rs1=DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						if(!strActivityCode.equalsIgnoreCase("MIGR"))
						strActivityCode=Helper.correctNull(rs1.getString("kyc_occupationcode"));
					}
					arryCol.add(strActivityCode);//9
					
					arryCol.add("");//10
					if (strPerFlag.equalsIgnoreCase("Y")) {
						strCBS = correctNull((String) rs.getString("dev_cbsid"));
					} else {
						strCBS = correctNull((String) rs.getString("perapp_cbsid"));
					}
					String panNo="",strMob="",strRefNo="";
					
					if(rs1!=null)
					{
						rs1.close();
					}
					if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
					{
						if(strPerFlag.equalsIgnoreCase("Y")){
						strQuery=SQLParser.getCBSSqlQuery("cbscusmastersearch_newconnection^"+Helper.correctNull(rs.getString("dev_cbsid")));
						}else{
						strQuery=SQLParser.getCBSSqlQuery("cbscusmastersearch_newconnection^"+Helper.correctNull(rs.getString("perapp_cbsid")));
						}
						rs1=DBUtils.executeQueryCBSConnection(strQuery);
					}
					else
					{
						if(strPerFlag.equalsIgnoreCase("Y")){
							strQuery=SQLParser.getCBSSqlQuery("cbscusmastersearch^"+Helper.correctNull(rs.getString("dev_cbsid")));
							}else{
						strQuery= SQLParser.getSqlQuery("cbscusmastersearch^"+Helper.correctNull(rs.getString("perapp_cbsid")));}
						rs1=DBUtils.executeQuery(strQuery); 
					}
					if(rs1.next())
					{
						panNo=Helper.correctNull(rs1.getString("pan_gir_num"));
						//strAadhar=Helper.correctNull(rs1.getString("perapp_aadhaar"));
						strMob=Helper.correctNull(rs1.getString("cust_comu_phone_num_1"));
						strRefNo=Helper.correctNull(rs1.getString("id_number"));
										
						strQuery=SQLParser.getSqlQuery("sel_existing_cust^"+panNo+"^"+strMob+"^"+strRefNo+"^"+panNo+"^"+strMob+"^"+strRefNo+"^"+panNo+"^"+strMob+"^"+strRefNo);
						rs2=DBUtils.executeQuery(strQuery);
						if(rs2.next())
						{
							//String strAppId= Helper.correctNull(rs2.getString("CON_APPID"));
							
							arryCol.add("block");//11
							/*strBlock="block";
							break;*/
						}
						
						else{
						
						arryCol.add("");//11
						}
					//
					}
					else{
						
						arryCol.add("");//11
					}/*if(!rs1.next())
						arryCol.add("");*/
				}
				arryRow.add(arryCol);
			}
			hshResult.put("arryRow",arryRow);
			
			if(rs!=null)
			{
				rs.close();
			}
			String appno=correctNull((String)hshValues.get("strappno"));
			
			strQuery= SQLParser.getSqlQuery("sel_perapp_oldid^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshResult.put("PERAPP_OLDID",correctNull(rs.getString("PERAPP_OLDID")));
			}
			if(rs!=null)
			{
				rs.close();
			}
			
			
			
			
		
		
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getMasterSearch "+e.getMessage());
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
			catch(Exception e)
			{
				throw new EJBException("Error in closing Connection "+e.getMessage());
			}
		}
		return hshResult;
	}
	
	/**
	*	Function  getDemographics This Method is used to  get  the
	*	demographics details of the personal application form
	*	@param hshValues     
	*   @return HashMap		 
	*	@exception java.lang.Exception
	*/

	public HashMap getDemographics(HashMap hshValues) throws EJBException
	{
		ResultSet rs=null;
		HashMap hshResult=new HashMap();
		HashMap hshResult1=new HashMap();
		ResultSet rs2=null;
		String strApplicationNo = null;		
		String strProfilestatus="";
		String strQuery="";
		String strhidApptype=correctNull((String)hshValues.get("hidAppType"));
		strApplicationNo=correctNull((String)hshValues.get("hidDemoId"));
		String strDelete=correctNull((String)hshValues.get("nodelete"));
		String strCBSdata=correctNull((String)hshValues.get("cbsdata"));
		String strborrowertype=correctNull((String)hshValues.get("hidapplicantnewid"));
		ResultSet rs1=null;
		//String strCBSId=correctNull((String)hshValues.get("cbsid"));
		String cbsidforcus=correctNull((String)hshValues.get("cbsid"));
		String strCusType=Helper.correctNull((String)hshValues.get("cust_type"));//This value is taken from updatedemographics method
		String strCBSIDSearch=Helper.correctNull((String)hshValues.get("cbsdata"));//This value is taken from searchresults.jsp
		String strUserId=correctNull((String)hshValues.get("strUserId"));
		String strUserGrpId = Helper.correctNull((String)hshValues.get("strUserGrpId"));

		String strLapsCustId="",strLapsOldId="",PERAPP_INVOCDATE="";
		String strCBSId="";
		String strCustomer="",strFacname=""; 
		HashMap hshCBSData=new HashMap();
		boolean boolMandatoryCBSFieldsFilled=true;
		HashMap hshCBSMandatoryList=null;
		strCBSId=Helper.correctNull((String)hshValues.get("hidDemoId"));
		String strRenewal=correctNull((String)hshValues.get("cbsdata"));
		
		ArrayList arrValues=new ArrayList();
		HashMap hshQuery =new HashMap();
		HashMap hshQueryValues=new HashMap();
		String splitat="";
		String PanC="";
		String CINc="";
		ArrayList arrRow1=new ArrayList();
		ArrayList arrCol1= null;
		String[] valArray=null;

		try
		{	
		/*	if(strRenewal.equalsIgnoreCase("Y"))
			{
				strQuery= SQLParser.getSqlQuery("selcustomerdetails^"+strApplicationNo);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strApplicationNo=Helper.correctNull(rs.getString("perapp_cbsid")); 
				}
			}*/
			if(!strCusType.equalsIgnoreCase("existing"))
			{
				if(strCBSIDSearch.equalsIgnoreCase("true"))
				{
					strQuery= SQLParser.getSqlQuery("perapplicant_selcbsid^"+strApplicationNo);	//search by demo id
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						rs1 = DBUtils.executeLAPSQuery("perapplicant_selMaxAppId^"+strApplicationNo);
						if(rs1.next())
						{
							strLapsCustId	=	correctNull(rs1.getString("perapp_maxid")); //Applicant id
							strCBSId= 	Helper.correctNull(rs.getString("perapp_cbsid")); //CBS customer ID	
							
							hshCBSMandatoryList=(HashMap)EJBInvoker.executeStateLess("cbsinterface",hshValues,"checkMandatoryFieldsFromCBS");
							if(hshCBSMandatoryList.size()>0)
							{
								boolMandatoryCBSFieldsFilled=((Boolean)hshCBSMandatoryList.get("keyBoolMandatoryCBSFieldsFilled")).booleanValue();
								if(!boolMandatoryCBSFieldsFilled)
								{
									/*
									 * This is to identify whether all the mandatory fields required for laps is filled in finacle.
									 */
									arrValues=new ArrayList();
									arrValues.add("N");
									arrValues.add(strLapsCustId);
									hshQueryValues.put("size","1");
									hshQuery.put("arrValues",arrValues);
									hshQuery.put("strQueryId", "perapplicant_updcbsdataflag");
									hshQueryValues.put("1",hshQuery);			
									EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
									return hshCBSMandatoryList;
								}
							}
							arrValues=new ArrayList();
							arrValues.add("Y");
							arrValues.add(strLapsCustId);
							hshQueryValues.put("size","1");
							hshQuery.put("arrValues",arrValues);
							hshQuery.put("strQueryId", "perapplicant_updcbsdataflag");
							hshQueryValues.put("1",hshQuery);			
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
						}
						strCustomer="existing";					
					}
					else
					{
//						hshCBSMandatoryList=(HashMap)EJBInvoker.executeStateLess("cbsinterface",hshValues,"checkMandatoryFieldsFromCBS");
//						if(hshCBSMandatoryList.size()>0)
//						{
//							boolMandatoryCBSFieldsFilled=((Boolean)hshCBSMandatoryList.get("keyBoolMandatoryCBSFieldsFilled")).booleanValue();
//							if(!boolMandatoryCBSFieldsFilled)
//							{
//								return hshCBSMandatoryList;
//							}
//						}
						strLapsCustId = getApplicantCode();	
						strCustomer="new";
					}
					hshCBSData.put("custid",strCBSId);
					hshCBSData.put("pagetype","Customer");
					hshCBSData.put("strLapscustid",strLapsCustId);
					hshCBSData.put("module","Retail");
					hshCBSData.put("strCustomer",strCustomer);
					hshResult=(HashMap)EJBInvoker.executeStateLess("cbsinterface",hshCBSData,"getCbsApplicantData");
				}
			}
			if(!strhidApptype.equalsIgnoreCase("new"))
	 		{	
				if(strLapsCustId.equalsIgnoreCase(""))
				{
					strLapsCustId=strApplicationNo;
				}
				if(strLapsCustId.equalsIgnoreCase("") || strLapsCustId.equalsIgnoreCase("null"))
				{
					strLapsCustId=strborrowertype;
					strApplicationNo=strborrowertype;
				}
				/*if(!strLapsCustId.equalsIgnoreCase(""))
				{
					strQuery= SQLParser.getSqlQuery("seloldrefidforapp^"+strLapsCustId);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strLapsOldId=Helper.correctNull(rs.getString("perapp_oldid")); 
					}
					strQuery= SQLParser.getSqlQuery("selrenewappid^"+strLapsOldId);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strLapsCustId=Helper.correctNull(rs.getString("perapp_id")); 
					}
				}*/
				
				if(!strLapsCustId.equalsIgnoreCase(""))
				{
				rs=DBUtils.executeLAPSQuery("sel_common_customer^"+strLapsCustId);				 
				if(rs.next())
				{
					hshResult.put("perapp_oldid",correctNull(rs.getString("perapp_oldid")));
					hshResult.put("perapp_id",correctNull(rs.getString("perapp_id")));
					hshResult.put("perapp_cbsid",correctNull(rs.getString("perapp_cbsid")));
					hshResult.put("perapp_title",correctNull(rs.getString("perapp_title")));
					hshResult.put("perapp_fname",correctNull(rs.getString("perapp_fname")));
					hshResult.put("perapp_lname",correctNull(rs.getString("perapp_lname")));
					hshResult.put("perapp_fatname",correctNull(rs.getString("perapp_fatname")));
					hshResult.put("perapp_constitution",correctNull(rs.getString("perapp_constitution")));
					PanC=correctNull(rs.getString("perapp_panno"));
					hshResult.put("perapp_panno",correctNull(rs.getString("perapp_panno")));
					hshResult.put("perapp_sex",correctNull(rs.getString("perapp_sex")));
					hshResult.put("perapp_dob",correctNull(rs.getString("perapp_dob")));
					hshResult.put("perapp_marstat",correctNull(rs.getString("perapp_marstat")));
					hshResult.put("perapp_status",correctNull(rs.getString("perapp_status")));
					hshResult.put("perapp_istatus",correctNull(rs.getString("perapp_istatus")));
					hshResult.put("perapp_branchcode",correctNull(rs.getString("perapp_branchcode")));
					hshResult.put("perapp_regno",correctNull(rs.getString("perapp_regno")));
					hshResult.put("perapp_taxslab",correctNull(rs.getString("perapp_taxslab")));
					hshResult.put("perapp_employment",correctNull(rs.getString("perapp_employment")));
					hshResult.put("perapp_occupation",correctNull(rs.getString("perapp_occupation")));
					hshResult.put("perapp_borrower_since",correctNull(rs.getString("perapp_loa_since")));
					hshResult.put("perapp_bank",correctNull(rs.getString("perapp_bank")));
					hshResult.put("perapp_banksince",correctNull(rs.getString("perapp_banksince")));
					hshResult.put("perapp_salaryrouted",correctNull(rs.getString("perapp_salaryrouted")));
					hshResult.put("perapp_relation_bankstaff",correctNull(rs.getString("perapp_relation_bankstaff")));
					hshResult.put("perapp_relation_staffname",correctNull(rs.getString("perapp_relation_staffname")));
					hshResult.put("perapp_blood_relation",correctNull(rs.getString("perapp_blood_relation")));
					hshResult.put("perapp_introname",correctNull(rs.getString("perapp_introname")));
					hshResult.put("perapp_introstatus",correctNull(rs.getString("perapp_introstatus")));
					hshResult.put("perapp_tradefinance",correctNull(rs.getString("perapp_tradefinance")));
					hshResult.put("perapp_inlandtrade",correctNull(rs.getString("perapp_inlandtrade")));
					hshResult.put("perapp_indcode",correctNull(rs.getString("perapp_indcode")));
					hshResult.put("perapp_companyname",correctNull(rs.getString("perapp_companyname")));
					hshResult.put("perapp_religion",correctNull(rs.getString("perapp_religion")));
					hshResult.put("PERAPP_NETWORTH",Helper.correctDouble(rs.getString("PERAPP_NETWORTH")));
					hshResult.put("PERAPP_NETWORTHASON",correctNull(rs.getString("PERAPP_NETWORTHASON")));
					hshResult.put("PERAPP_INTROTYPE",correctNull(rs.getString("PERAPP_INTROTYPE")));
					hshResult.put("PERAPP_INTROSTAFFID",correctNull(rs.getString("PERAPP_INTROSTAFFID")));
					hshResult.put("PERAPP_INTROCBSID",correctNull(rs.getString("PERAPP_INTROCBSID")));					
					hshResult.put("cust_branch_name",correctNull(rs.getString("org_name")));
					hshResult.put("indinfo_resident_status",correctNull(rs.getString("indinfo_resident_status")));
					hshResult.put("indinfo_resident_country",correctNull(rs.getString("indinfo_resident_country")));
					hshResult.put("indinfo_is_staff",correctNull(rs.getString("indinfo_is_staff")));
					hshResult.put("indinfo_dateof_joining",correctNull(rs.getString("indinfo_dateof_joining")));
					hshResult.put("indinfo_staff_id",correctNull(rs.getString("indinfo_staff_id")));
					hshResult.put("indinfo_caste",correctNull(rs.getString("indinfo_caste")));
					hshResult.put("indinfo_minority",correctNull(rs.getString("indinfo_minority")));
					hshResult.put("indinfo_religion",correctNull(rs.getString("indinfo_religion")));
					hshResult.put("indinfo_dependents_child",correctNull(rs.getString("indinfo_dependents_child")));
					hshResult.put("indinfo_dependents_others",correctNull(rs.getString("indinfo_dependents_others")));
					hshResult.put("indinfo_earning_member",correctNull(rs.getString("indinfo_earning_member")));
					hshResult.put("indinfo_edu_qual",correctNull(rs.getString("indinfo_edu_qual")));
					hshResult.put("indinfo_area_specialized",correctNull(rs.getString("indinfo_area_specialized")));
					hshResult.put("indinfo_senior_citizen",correctNull(rs.getString("indinfo_senior_citizen")));
					hshResult.put("indinfo_physically_challanged",correctNull(rs.getString("indinfo_physically_challanged")));
					hshResult.put("indinfo_exservice_man",correctNull(rs.getString("indinfo_exservice_man")));
					hshResult.put("indinfo_service_years",correctNull(rs.getString("indinfo_service_years")));
					hshResult.put("indinfo_is_minor",correctNull(rs.getString("indinfo_is_minor")));
					hshResult.put("indinfo_guardian_appid",correctNull(rs.getString("indinfo_guardian_appid")));
					hshResult.put("indinfo_guardian_name",correctNull(rs.getString("indinfo_guardian_name")));
					hshResult.put("indinfo_guardian_relation",correctNull(rs.getString("indinfo_guardian_relation")));
					hshResult.put("indinfo_guardian_address",correctNull(rs.getString("indinfo_guardian_address")));
					hshResult.put("indinfo_spouse_title",correctNull(rs.getString("indinfo_spouse_title")));
					hshResult.put("indinfo_spouse_name",correctNull(rs.getString("indinfo_spouse_name")));
					hshResult.put("indinfo_spouse_dob",correctNull(rs.getString("indinfo_spouse_dob")));
					hshResult.put("indinfo_spouse_occupation",correctNull(rs.getString("indinfo_spouse_occupation")));
					hshResult.put("indinfo_spouse_qualification",correctNull(rs.getString("indinfo_spouse_qualification")));
					hshResult.put("indinfo_spouse_panno",correctNull(rs.getString("indinfo_spouse_panno")));
					hshResult.put("indinfo_spouse_employer",correctNull(rs.getString("indinfo_spouse_employer")));
					hshResult.put("indinfo_spouse_income",correctNull(rs.getString("indinfo_spouse_income")));
					hshResult.put("indinfo_spouse_address",correctNull(rs.getString("indinfo_spouse_address")));
					hshResult.put("INDINFO_BLIND",correctNull(rs.getString("INDINFO_BLIND")));
					hshResult.put("cominfo_commencement_date",correctNull(rs.getString("cominfo_commencement_date")));
					hshResult.put("cominfo_incorporation_date",correctNull(rs.getString("cominfo_incorporation_date")));
					hshResult.put("cominfo_ownership_type",correctNull(rs.getString("cominfo_ownership_type")));
					hshResult.put("cominfo_roc_number",correctNull(rs.getString("cominfo_roc_number")));
					//hshResult.put("cominfo_cin",correctNull(rs.getString("cominfo_cin")));
					hshResult.put("cominfo_tin",correctNull(rs.getString("cominfo_tin")));
					hshResult.put("cominfo_groupid",correctNull(rs.getString("cominfo_groupid")));
					hshResult.put("cominfo_groupname",correctNull(rs.getString("cominfo_groupname")));
					hshResult.put("cominfo_industry_type",correctNull(rs.getString("cominfo_industry_type")));
					hshResult.put("cominfo_total_employees",correctNull(rs.getString("cominfo_total_employees")));
					hshResult.put("cominfo_loa_nbfc",correctNull(rs.getString("cominfo_loa_nbfc")));
					hshResult.put("cominfo_nbfc_deposit",correctNull(rs.getString("cominfo_nbfc_deposit")));
					hshResult.put("cominfo_nbfc_infra",correctNull(rs.getString("cominfo_nbfc_infra")));
					hshResult.put("cominfo_nbfc_asset",correctNull(rs.getString("cominfo_nbfc_asset")));
					hshResult.put("cominfo_micro_fin_inst",correctNull(rs.getString("cominfo_micro_fin_inst")));
					hshResult.put("cominfo_minority_community",correctNull(rs.getString("cominfo_minority_community")));
					hshResult.put("cominfo_shg_location",correctNull(rs.getString("cominfo_shg_location")));
					hshResult.put("cominfo_shg_members",correctNull(rs.getString("cominfo_shg_members")));
					hshResult.put("cominfo_shg_beneficiaries",correctNull(rs.getString("cominfo_shg_beneficiaries")));
					hshResult.put("cominfo_shg_scheme",correctNull(rs.getString("cominfo_shg_scheme")));
					hshResult.put("cominfo_shg_ngo",correctNull(rs.getString("cominfo_shg_ngo")));
					hshResult.put("cominfo_shg_acctno",correctNull(rs.getString("cominfo_shg_acctno")));
					hshResult.put("COMINFO_MAJORITYMEMBER",correctNull(rs.getString("COMINFO_MAJORITYMEMBER")));
					hshResult.put("perapp_satisfactory",correctNull(rs.getString("perapp_satisfactory")));
					hshResult.put("perapp_just_details",Helper.CLOBToString(rs.getClob("perapp_just_details")));
					hshResult.put("indinfo_family_income",Helper.correctDouble((String)rs.getString("indinfo_family_income")));
					hshResult.put("perapp_relat_staffid",Helper.correctNull((String)rs.getString("perapp_relat_staffid")));
					hshResult.put("perapp_constitutionnew",Helper.correctNull((String)rs.getString("perapp_constitutionnew")));
					hshResult.put("perapp_lending",Helper.correctNull((String)rs.getString("perapp_lending")));
					hshResult.put("indinfo_bankarrangement",Helper.correctInt((String)rs.getString("indinfo_bankarrangement")));
					hshResult.put("indinfo_banksector",Helper.correctInt((String)rs.getString("indinfo_banksector")));
					hshResult.put("companyinfo_typeofliability",Helper.CLOBToString(rs.getClob("companyinfo_typeofliability")));
					hshResult.put("com_groupname",Helper.correctNull(rs.getString("com_groupname")));
					hshResult.put("com_groupid",Helper.correctNull(rs.getString("cominfo_comgroupid")));
					hshResult.put("perapp_stakeheld_women",Helper.correctNull(rs.getString("perapp_stakeheld_women")));
					hshResult.put("perapp_aadhaar",Helper.correctNull(rs.getString("perapp_aadhaar")));
					hshResult.put("PERAPP_PARTNERSHIP_DET",Helper.correctNull(rs.getString("PERAPP_PARTNERSHIP_DET")));
					hshResult.put("PERAPP_PARTNERSHIP_DEEDDATE",Helper.correctNull(rs.getString("PERAPP_PARTNERSHIP_DEEDDATE")));
					hshResult.put("PERAPP_PARTNERSHIP_REGNO",Helper.correctNull(rs.getString("PERAPP_PARTNERSHIP_REGNO")));
					hshResult.put("PERAPP_COM_SEARCHREPDATE",Helper.correctNull(rs.getString("PERAPP_COM_SEARCHREPDATE")));
					hshResult.put("PERAPP_COM_AUTHCAPTAL",Helper.correctNull(rs.getString("PERAPP_COM_AUTHCAPTAL")));
					hshResult.put("PERAPP_COM_PAIDUPCAP",Helper.correctNull(rs.getString("PERAPP_COM_PAIDUPCAP")));
					hshResult.put("PERAPP_COM_MOAVERIFIED",Helper.correctNull(rs.getString("PERAPP_COM_MOAVERIFIED")));
					hshResult.put("PERAPP_COM_AMENDEDMOA",Helper.correctNull(rs.getString("PERAPP_COM_AMENDEDMOA")));
					hshResult.put("PERAPP_TRUST_DEEDDATE",Helper.correctNull(rs.getString("PERAPP_TRUST_DEEDDATE")));
					hshResult.put("PERAPP_TRUST_REGTYPE",Helper.correctNull(rs.getString("PERAPP_TRUST_REGTYPE")));
					hshResult.put("PERAPP_TRUST_PERMREFNO",Helper.correctNull(rs.getString("PERAPP_TRUST_PERMREFNO")));
					hshResult.put("PERAPP_UDYOG_AADHAR",Helper.correctNull(rs.getString("PERAPP_UDYOG_AADHAR")));
					hshResult.put("PERAPP_MSE_REGNO",Helper.correctNull(rs.getString("PERAPP_MSE_REGNO")));
					//hshResult.put("PERAPP_LEGAL_ENTITYID",Helper.correctNull(rs.getString("PERAPP_LEGAL_ENTITYID")));
					//hshResult.put("PERAPP_LEGAL_EXPIRYDATE",Helper.correctNull(rs.getString("PERAPP_LEGAL_EXPIRYDATE")));
					hshResult.put("COMINFO_IEC",Helper.correctNull(rs.getString("COMINFO_IEC")));
					hshResult.put("COMINFO_GSTIN",Helper.correctNull(rs.getString("COMINFO_GSTIN")));
					hshResult.put("COMINFO_GSTINREG",Helper.correctNull(rs.getString("COMINFO_GSTINREG")));
					hshResult.put("cominfo_employees_asondate",Helper.correctNull(rs.getString("cominfo_employees_asondate")));
					hshResult.put("COMINFO_GST_EXEMPTED",Helper.correctNull(rs.getString("COMINFO_GST_EXEMPTED")));
					hshResult.put("PERAPP_UDYAM_REGNO",Helper.correctNull((String)rs.getString("PERAPP_UDYAM_REGNO")));
					hshResult.put("PERAPP_SALES_TURNOVER",Helper.correctDouble((String)rs.getString("PERAPP_SALES_TURNOVER")));
					hshResult.put("PERAPP_SALES_TURNOVER_DATE",Helper.correctNull((String)rs.getString("PERAPP_SALES_TURNOVER_DATE")));
					hshResult.put("PERAPP_CRITERIA_SALES_TURNOVER",Helper.correctNull((String)rs.getString("PERAPP_CRITERIA_SALES_TURNOVER")));
					hshResult.put("PERAPP_CERTIFICATION_DATE",Helper.correctNull((String)rs.getString("PERAPP_CERTIFICATION_DATE")));
					hshResult.put("PERAPP_MSME_CLASSIFICATION",Helper.correctNull((String)rs.getString("PERAPP_MSME_CLASSIFICATION")));
					if(!strCBSIDSearch.equalsIgnoreCase("true"))
					{
						hshResult.put("cominfo_cin",correctNull(rs.getString("cominfo_cin")));
						hshResult.put("PERAPP_LEGAL_ENTITYID",Helper.correctNull(rs.getString("PERAPP_LEGAL_ENTITYID")));
						hshResult.put("PERAPP_LEGAL_EXPIRYDATE",Helper.correctNull(rs.getString("PERAPP_LEGAL_EXPIRYDATE")));
						hshResult.put("PERAPP_LEGAL_ISSUEDATE",correctNull(rs.getString("LEI_ISSUE_DATE")));
					}
					//hshResult.put("PERAPP_MINORITYINDUSTRY",Helper.correctNull((String)rs.getString("PERAPP_MINORITYINDUSTRY")));
					PERAPP_INVOCDATE = Helper.correctNull((String)rs.getString("PERAPP_INVOCDATE"));
					hshResult.put("PERAPP_INVOCDATE",PERAPP_INVOCDATE);
					
					//hshResult.put("perapp_facility_othbank",Helper.correctNull((String)rs.getString("perapp_facility_othbank")));
					
				}
				hshValues.put("strApplicationNo",strApplicationNo);
				hshValues.put("hidAppType","A");
				boolean boolappstatus=false;
				if(rs!=null)
					rs.close();
				rs=DBUtils.executeLAPSQuery("checkapplicantstatusper^"+strLapsCustId);				 
				if(rs.next())
				{
					boolappstatus=true;
				}
				
				if(!boolappstatus)
				{
					if(rs!=null)
						rs.close();
					rs=DBUtils.executeLAPSQuery("checkapplicantstatuster_corp^"+strLapsCustId);				 
					if(rs.next())
					{
						boolappstatus=true;
					}
				}
				if(!boolappstatus)
				{
					if(rs!=null)
						rs.close();
					rs=DBUtils.executeLAPSQuery("checkapplicantstatuster_corp_cooapp^"+strLapsCustId);				 
					if(rs.next())
					{
						boolappstatus=true;
					}
				}
				if(!boolappstatus)
				{
					if(rs!=null)
						rs.close();
					rs=DBUtils.executeLAPSQuery("sel_processAppl_solvency_newid^"+strLapsCustId);				 
					if(rs.next())
					{
						boolappstatus=true;
					}
				}
				
				if(!boolappstatus)
				{
					if(rs!=null)
						rs.close();
					rs=DBUtils.executeLAPSQuery("sel_processAppl_bankers_newid^"+strLapsCustId);				 
					if(rs.next())
					{
						boolappstatus=true;
					}
				}
				
				if(!boolappstatus)
				{
					if(rs!=null)
						rs.close();
					rs=DBUtils.executeLAPSQuery("sel_processAppl_kpower_newid^"+strLapsCustId);				 
					if(rs.next())
					{
						boolappstatus=true;
					}
				}
				if(!boolappstatus)
				{
					if(rs!=null)
						rs.close();
					rs=DBUtils.executeLAPSQuery("sel_processApplmsmenewid^"+strLapsCustId);				 
					if(rs.next())
					{
						boolappstatus=true;
					}
				}
				
				
				
				hshResult.put("appstatus",""+boolappstatus);


				
				hshResult.put("applicantId",strLapsCustId);
				
				HashMap prof=new HashMap();
				HashMap profile=new HashMap();
				prof.put("profile_id",strLapsCustId);
				profile=(HashMap)getCustomerProfileStatus(prof);
				hshResult.put("strIncompletepage", Helper.correctNull((String)profile.get("strIncompletepage")));
				
				if(rs!=null)
				{
					rs.close();
				}
				rs=DBUtils.executeLAPSQuery("getprofilestatusfromdemographic^"+strLapsCustId);
				if(rs.next())
				{
					strProfilestatus=Helper.correctNull((String)rs.getString("perapp_profilestatus"));
				}
				hshResult.put("strProfilestatus",strProfilestatus);
				}
				} else {
				hshResult.put("perapp_id","New");
			}
				if(rs!=null)
				{
					rs.close();
				}
				if(!strLapsCustId.equalsIgnoreCase(""))
				{
					rs=DBUtils.executeLAPSQuery("perconstbankingsel^"+strLapsCustId);
					if(rs.next())
					{
						strFacname=Helper.correctNull((String)rs.getString("cus_facname"));
					}
					hshResult.put("strFacname",strFacname);
				}
			
				if(rs!=null)
				{
					rs.close();
				}
				rs=DBUtils.executeLAPSQuery("sel_CBSStaticDataPassingCode^02^"+Helper.correctInt((String)hshResult.get("perapp_constitutionnew")));
				if(rs.next())
				{
						hshResult.put("Staticdata_constitution",Helper.correctNull((String)rs.getString("cbs_static_sanc_refno")));
				}	
								
			hshResult.put("nodelete",strDelete);
			hshResult.put("keyBoolMandatoryCBSFieldsFilled",Boolean.valueOf(boolMandatoryCBSFieldsFilled));
		
			//The charge on assets of the company observed 
			
			strQuery= SQLParser.getSqlQuery("sel_com_assetcharg^"+strLapsCustId);
			ArrayList arrAssetDet = new ArrayList();
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				ArrayList arrcol4 = new ArrayList();
				arrcol4.add(correctNull(rs.getString("COM_SEC_ID")));//0
				arrcol4.add(correctNull(rs.getString("COM_ASSET_NAME")));//1
				arrcol4.add(correctNull(rs.getString("COM_CHARG_HOLDER")));//2
				arrcol4.add(correctNull(rs.getString("COM_CHARG_DATE")));//3
				arrAssetDet.add(arrcol4);			
			}
			
			if(rs!=null){
				rs.close();
			}
			strQuery= SQLParser.getSqlQuery("sel_minority_validation^"+strLapsCustId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshResult.put("CON_COMSTATE",Helper.correctNull((String)rs.getString("CON_COMSTATE")));

			}
			String strCityCode="",strDistCode="",strStateCode="";
			strQuery=SQLParser.getSqlQuery("sel_customerdetail^"+strLapsCustId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				if(Helper.correctNull(rs.getString("INDINFO_RESIDENT_STATUS")).equalsIgnoreCase("N"))
				{
					strCityCode=Helper.correctNull(rs.getString("CON_COMCITY"));
					strDistCode=Helper.correctNull(rs.getString("CON_COMDIST"));
					strStateCode=Helper.correctNull(rs.getString("CON_COMSTATE"));
				}
				else
				{
					strCityCode=Helper.correctNull(rs.getString("CON_PERMCITY"));
					strDistCode=Helper.correctNull(rs.getString("CON_PERMDIST"));
					strStateCode=Helper.correctNull(rs.getString("CON_PERMSTATE"));
				}
				hshResult.put("app_city",strCityCode);
				hshResult.put("app_district",strDistCode);
				hshResult.put("app_stateminority",strStateCode);
			}
			hshResult.put("arrAssetDet", arrAssetDet);
			
			
			if(rs !=null){
				rs.close();
			}
			String strpredateofrest="",strEligtoEdit="Y",strRCBSId="",strappstatus="",strpredateofrest1="";
			strQuery = SQLParser.getSqlQuery("restrct_admin^"+strUserId);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				strUserGrpId=Helper.correctNull((String)rs.getString("GRP_ID"));
			}
			
			if(rs !=null){
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("select_perappoldid^"+strLapsCustId);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				strRCBSId=Helper.correctNull((String)rs.getString("perapp_cbsid"));
			}
			//Retail
			if(rs !=null){
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_retail_op^"+strLapsCustId);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				strappstatus=Helper.correctNull((String)rs.getString("APP_STATUS"));
			}
			if(rs !=null){
				rs.close();
			}
			
			//msme
			strQuery = SQLParser.getSqlQuery("sel_msme_op^"+strLapsCustId);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				strappstatus=Helper.correctNull((String)rs.getString("APP_STATUS"));
			}
			
			strQuery = SQLParser.getSqlQuery("app_restrctdate^"+strRCBSId+"^"+strLapsCustId);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				strpredateofrest=Helper.correctNull((String)rs.getString("PERAPP_INVOCDATE"));
				
				if(!strpredateofrest.equalsIgnoreCase(""))
				{
					strpredateofrest1 = "Y";
				}
			}
			
			if(rs !=null){
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_restrctdate^"+strLapsCustId);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				if(!strpredateofrest1.equalsIgnoreCase("Y") && strUserGrpId.equalsIgnoreCase("1") && strappstatus.equalsIgnoreCase("op"))
				{
					strEligtoEdit="N";
				}
				hshResult.put("invocblockusers","N");

			}else{
				if(strUserGrpId.equalsIgnoreCase("1") && strappstatus.equalsIgnoreCase("op"))
				{
					strEligtoEdit="N";
				}
				hshResult.put("invocblockusers","Y");

			}
			
			hshResult.put("EligtoinvocdateEdit",strEligtoEdit);
			
			if(strCBSIDSearch.equalsIgnoreCase("true"))
			{
				String newConcode="";
				String cbsBen="";
				
				if(rs != null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("selCONSTITUTIONNEW^"+strLapsCustId);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					newConcode=Helper.correctNull((rs.getString("PERAPP_CONSTITUTIONNEW")));
					
				}
				if(rs != null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("selcbsstaticid^"+newConcode);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					cbsBen=Helper.correctNull((rs.getString("CBS_BEN")));
				}
				if(rs != null)
				{
					rs.close();
				}
				if(cbsBen.equalsIgnoreCase("Y"))
				{	
					if(rs2!=null)
					{
						rs2.close();
					}
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();
			hshQueryValues.put("size", "1");
			hshQuery.put("strQueryId", "del_applKYCNormsBENEFICIAL");
			arrValues = new ArrayList();
			arrValues.add(strLapsCustId);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1", hshQuery);

		EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
		
		if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
		{
			strQuery=SQLParser.getCBSSqlQuery("beneficialownerid_new_con^"+cbsidforcus);
			rs2=DBUtils.executeQueryCBSConnection(strQuery);
		}
		else
		{
			strQuery= SQLParser.getSqlQuery("beneficialownerid^"+cbsidforcus);
			rs2=DBUtils.executeQuery(strQuery); 
		}
		
		if(rs2.next())
		{
			//splitat="A~B~07~D~E~002~G~H@I~J~99~L~M~001~O~P";
				splitat=correctNull(rs2.getString("BENF_DET"));
				
				if(splitat.length()>15)
				{
				valArray=splitat.split("\\@");
				for(int k=0;k<valArray.length;k++)
				{
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					hshQueryValues.put("size", "1");
				   String getstringat=valArray[k];
				   String[] getattilt=getstringat.split("\\~");
				   arrValues = new ArrayList();
				   hshQuery.put("strQueryId", "insintoBENEFICALOWN");
				   for(int j=0;j<getattilt.length;j++)
				   {
					    
					  arrValues.add(getattilt[j]);
					   
				   }
				   arrValues.add(strLapsCustId); 
				   arrValues.add(correctNull((String)hshValues.get("cbsid")));
				    hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);			
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				}
				}
			}
			}
				if(rs2!=null)
				{
					rs2.close();
				}
				
			}
			if(strCBSIDSearch.equalsIgnoreCase("true"))
			{
			if(!PanC.equalsIgnoreCase(""))
			{
				char ch = PanC.charAt(3);
				String checkc=Character.toString(ch);
				if(checkc.equalsIgnoreCase("C"))
				{
					if(rs2!=null)
					{
						rs2.close();
					}
					
					if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
					{
						strQuery=SQLParser.getCBSSqlQuery("beneficialownerid_new_con^"+cbsidforcus);
						rs2=DBUtils.executeQueryCBSConnection(strQuery);
					}
					else
					{
						strQuery= SQLParser.getSqlQuery("beneficialownerid^"+cbsidforcus);
						rs2=DBUtils.executeQuery(strQuery); 
					}
					if(rs2.next())
				{
						CINc=correctNull(rs2.getString("CIN_NUM"));
						if(!("").equalsIgnoreCase(CINc)){
							CINc=CINc.toUpperCase();
						}
						hshResult.put("cominfo_cin",CINc);
					}
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					hshQueryValues.put("size", "1");
					arrValues = new ArrayList();
					arrValues.add(CINc);
					arrValues.add(strLapsCustId);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					hshQuery.put("strQueryId", "updateCINinperapplicantfromfinacal");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
					
					
					
					
				}
				
				
			}
			if(rs2!=null)
			{
				rs2.close();
			}
			if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
			{
				strQuery=SQLParser.getCBSSqlQuery("beneficialownerid_new_con^"+cbsidforcus);
				rs2=DBUtils.executeQueryCBSConnection(strQuery);
			}
			else
			{
				strQuery= SQLParser.getSqlQuery("beneficialownerid^"+cbsidforcus);
				rs2=DBUtils.executeQuery(strQuery); 
			}
			if(rs2.next())
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				arrValues = new ArrayList();
				arrValues.add(correctNull(rs2.getString("LEI_NUM")));
				arrValues.add(correctNull(rs2.getString("LEI_EXP_DATE")));
				arrValues.add(correctNull(rs2.getString("LEI_ISSUE_DATE")));
				arrValues.add(strLapsCustId);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQuery.put("strQueryId", "updateLEIinperapplicantfromfinacal");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				hshResult.put("PERAPP_LEGAL_ENTITYID",correctNull(rs2.getString("LEI_NUM")));
				hshResult.put("PERAPP_LEGAL_EXPIRYDATE",correctNull(rs2.getString("LEI_EXP_DATE")));
				hshResult.put("PERAPP_LEGAL_ISSUEDATE",correctNull(rs2.getString("LEI_ISSUE_DATE")));
			}
			
			
		}
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
			throw new EJBException("Error in getDemographics "+e.getMessage());	
			
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
				e.printStackTrace();
				throw new EJBException("Error in closing Connection "+e.getMessage());
			}
		}
		return hshResult;
	} 

	/**
	*	Function  updateDemographics This Method is used for updating or
	*	inserting values in the personal application form
	*	@param hshValues     
	*   @return HashMap		 
	*	@exception java.lang.Exception	
	*/
	
	public HashMap updateDemographics(HashMap hshValues) 
	{ 
		java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		ResultSet rs=null;
		String strQuery="";
		String strapplnt="",flag="",strUserId="";
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		HashMap hshResult=new HashMap();
		HashMap hshGetValues=new HashMap();
		String strmoduletype = correctNull((String)hshValues.get("hidModuleName"));
		String strApplicationNo=correctNull((String)hshValues.get("txt_perappid"));
		String custtmpid="",txt_flag="",tmp="Y",strCostRes="",strDate="";	
		String strCusType="";
		StringBuilder sbActionData = new StringBuilder();
		StringBuilder sbOldAudit = new StringBuilder();
		ResultSet rs2 =null,rs1=null;
		String strminorityflag="";

		try
		{ 
			String strCBSID="",strTitle="",strFullName="",strShortName="",strFatherName="",strConstitution="",strPANNo="",strSex="";
			String strDOB="01/01/1900",strMartialStatus="",strStatus="",strBorrStatus="",strOrgScode="",strRegNo="",strTaxSlab="";
			String strEmployment="",strLineofActivity="",strLoASince="",strBanking="",strBorrowerSince="",strSalaryRouted="";
			String strStaffRelation="",strRelationName="",strBloodRelation="",strIntroducerName="",strIntroStatus="",strTradeFinance="";
			String strInlandTrade="",strCorpReligion="",strIndustryCode="",strIndustryName="",strSatisfactory="",strJustificationDetails="";
			String strRelativeStaffID="",strNetworthAsonDate="";
			String strNetworth="",strConstitutionNew="",strsel_lending="",strBankArrange="",strBankSector="",strsel_Blind;
			String strHeldWomen="",strAadharNo="",strpartnership="",strpartDeedDate="",strpartRegno="",strLegalentityid="",strExpirydate="";
			strCBSID=Helper.correctNull((String)hshValues.get("txt_cbs_id"));
			strTitle=Helper.correctNull((String)hshValues.get("txt_applt_title"));
			strFullName=Helper.correctNull((String)hshValues.get("txt_applt_fullname"));
			strShortName=Helper.correctNull((String)hshValues.get("txt_applt_shortname"));
			strFatherName=Helper.correctNull((String)hshValues.get("txt_applt_fatname"));
			strConstitution=Helper.correctNull((String)hshValues.get("sel_applt_constitution"));
			strPANNo=Helper.correctNull((String)hshValues.get("txt_applt_panno"));
			strSex=Helper.correctNull((String)hshValues.get("sel_applt_sex"));
			strDOB=Helper.correctNull((String)hshValues.get("txt_applt_dob"));
			strMartialStatus=Helper.correctNull((String)hshValues.get("sel_applt_martial_status"));
			strStatus=Helper.correctNull((String)hshValues.get("sel_istatus"));
			strBorrStatus=Helper.correctNull((String)hshValues.get("sel_borr_status"));
			strOrgScode=Helper.correctNull((String)hshValues.get("select_loc"));
			strRegNo=Helper.correctNull((String)hshValues.get("txt_applt_regno"));
			strTaxSlab=Helper.correctNull((String)hshValues.get("sel_tax_slab"));
			strEmployment=Helper.correctNull((String)hshValues.get("sel_applt_occupation"));
			strLineofActivity=Helper.correctNull((String)hshValues.get("sel_applt_loa"));
			strLoASince=Helper.correctNull((String)hshValues.get("txt_loa_since"));
			strBanking=Helper.correctNull((String)hshValues.get("sel_banking_with"));
			strBorrowerSince=Helper.correctNull((String)hshValues.get("txt_borr_since"));
			strSalaryRouted=Helper.correctNull((String)hshValues.get("sel_salary_routed"));
			strStaffRelation=Helper.correctNull((String)hshValues.get("sel_relative_bank"));
			if(strStaffRelation.equalsIgnoreCase("005") || strStaffRelation.equalsIgnoreCase("006"))
			{
				strRelationName=Helper.correctNull((String)hshValues.get("txt_staff_name"));
			}
			else
			{
				strRelationName=Helper.correctNull((String)hshValues.get("txt_staff_name1"));
			}
			strBloodRelation=Helper.correctNull((String)hshValues.get("sel_blood_relation"));
			String strIntroducertype=Helper.correctNull((String)hshValues.get("sel_introducer_type"));
			String strIntroStaffId=Helper.correctNull((String)hshValues.get("txt_introstaff_id"));
			String strIntroCBSId=Helper.correctNull((String)hshValues.get("txt_introcbs_id"));
			strIntroducerName=Helper.correctNull((String)hshValues.get("txt_introducer_name"));
			strIntroStatus=Helper.correctNull((String)hshValues.get("sel_introducer_status"));
			strTradeFinance=Helper.correctNull((String)hshValues.get("sel_trade"));
			strInlandTrade=Helper.correctNull((String)hshValues.get("sel_inland"));
			strIndustryCode=Helper.correctNull((String)hshValues.get("hid_industry_code"));
			strIndustryName=Helper.correctNull((String)hshValues.get("txt_industry_bsr_code"));
			strCorpReligion=Helper.correctNull((String)hshValues.get("sel_corp_religion"));
			strSatisfactory=Helper.correctNull((String)hshValues.get("sel_satisfactory_dealing"));
			strJustificationDetails=Helper.correctNull((String)hshValues.get("txt_justComment"));
			strRelativeStaffID=Helper.correctNull((String)hshValues.get("txt_relat_staff_id"));
			strNetworth=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_networth"))));
			strNetworthAsonDate=Helper.correctNull((String)hshValues.get("txt_networthdate"));
			strConstitutionNew=Helper.correctNull((String)hshValues.get("sel_applt_constitutionnew"));
			strsel_lending=Helper.correctNull((String)hshValues.get("sel_lending"));
			strsel_Blind=Helper.correctNull((String)hshValues.get("sel_blind"));
			strHeldWomen=Helper.correctNull((String)hshValues.get("sel_heldwomen"));
			strAadharNo=Helper.correctNull((String)hshValues.get("txt_aadhar"));
			strpartnership=Helper.correctNull((String)hshValues.get("sel_partnership"));
			strpartDeedDate=Helper.correctNull((String)hshValues.get("txt_part_deeddate"));
			strpartRegno=Helper.correctNull((String)hshValues.get("txt_regno"));
			
			String txt_comp_repDate=Helper.correctNull((String)hshValues.get("txt_comp_repDate"));
			String txt_com_authCapital = Helper.correctNull((String)hshValues.get("txt_com_authCapital"));
			String txt_com_PaidupCapital=Helper.correctNull((String)hshValues.get("txt_com_PaidupCapital"));
			String sel_MOA_verified=Helper.correctNull((String)hshValues.get("sel_MOA_verified"));
			String amendedMOA_comments=Helper.correctNull((String)hshValues.get("amendedMOA_comments"));
			String txt_trust_deeddate=Helper.correctNull((String)hshValues.get("txt_trust_deeddate"));
			String sel_trustType=Helper.correctNull((String)hshValues.get("sel_trustType"));
			String txt_trust_refno_openacc=Helper.correctNull((String)hshValues.get("txt_trust_refno_openacc"));
			String txt_udyog_aadhar=Helper.correctNull((String)hshValues.get("txt_udyog_aadhar"));
			String txt_mse_regno=Helper.correctNull((String)hshValues.get("txt_mse_regno"));
			strLegalentityid=Helper.correctNull((String)hshValues.get("txt_entity_id"));
			strExpirydate=Helper.correctNull((String)hshValues.get("txt_expirey_date"));
            
			String strudyamregno=Helper.correctNull((String)hshValues.get("txt_udyam_regno"));
			strudyamregno=strudyamregno.toUpperCase();
			String strturnover=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_sales_turnover"))));
			String strturnoverdate=Helper.correctNull((String)hshValues.get("txt_turnover_asondate"));
			String strcatgeorysales=Helper.correctNull((String)hshValues.get("sel_sales_turnover"));
			String strCertificationdate=Helper.correctNull((String)hshValues.get("txt_certificate_date"));
			String strmsmeclassfication=Helper.correctNull((String)hshValues.get("sel_msme_classification"));
			String strDay="",txt_restructdate="",strinvocdat="";
			txt_restructdate=Helper.correctNull((String)hshValues.get("txt_restructdate"));
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("sel_perapp_dob^"+strApplicationNo);				 
			if(rs.next())
			{
				strinvocdat = Helper.correctNull(rs.getString("perapp_invocdate"));
			}
			if(!txt_restructdate.equalsIgnoreCase("") ){
				if(!strinvocdat.equalsIgnoreCase("")){
						if(rs!=null)
						{
							rs.close();
						}
						rs=DBUtils.executeLAPSQuery("sel_perapp_dob^"+strApplicationNo);				 
						if(rs.next())
						{
							strUserId = Helper.correctNull(rs.getString("PERAPP_INVOCUSRID"));
							strDay = Helper.correctNull(rs.getString("PERAPP_INVOCREATDATE"));
						}
				}else{
					strUserId=correctNull((String)hshValues.get("strUserId"));
					SimpleDateFormat dateFormat= new SimpleDateFormat("dd-MM-yyyy hh:mm:ss"); 
					Calendar calendar = Calendar.getInstance();
					strDay = dateFormat.format(calendar.getTime());
				}
			}
			//String strminorityindustry=Helper.correctNull((String)hshValues.get("sel_minIndustry"));
			if(strApplicationNo.equalsIgnoreCase("New"))
			{
				strCusType="New";
				strApplicationNo = getApplicantCode();
				hshQuery.put("strQueryId","ins_perapplicant_common_customer");
				hshValues.put("hidAction","insert");
				hshValues.put("hidapptype","R");
				hshValues.put("strApplicationNo",strApplicationNo);
				arrValues.add(strApplicationNo);
			} else {
				/***
				 * For Audit Trial Old Data - By Karthikeyan.S on 12/09/2013
				 */
				sbOldAudit=getOldAuditDemographics(strApplicationNo);
				/***
				 * End - Audit Trial Old Data
				 */
				if(!strConstitutionNew.equalsIgnoreCase("01"))
					
				{
				
					if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("sel_stakeholderdet^"+strApplicationNo);				 
					if(rs.next())
					{
							if(!Helper.correctNull(rs.getString("COMINFO_MAJORITYMEMBER")).equalsIgnoreCase(Helper.correctNull((String)hshValues.get("sel_majoritymem")))||!Helper.correctNull(rs.getString("perapp_stakeheld_women")).equalsIgnoreCase(strHeldWomen))
							{
								hshQuery = new HashMap();
								arrValues=new ArrayList();
								arrValues.add(strApplicationNo);
								arrValues.add(strApplicationNo);
								hshQuery.put("strQueryId","upd_misreselectflag"); 
								hshQuery.put("arrValues",arrValues); 
								hshQueryValues.put("1",hshQuery);
								hshQueryValues.put("size","1");
								EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData"); 
								
								
								hshQueryValues = new HashMap();
								hshQuery = new HashMap();
								arrValues = new ArrayList();
							}
					}
				}
				hshQuery.put("strQueryId","upd_perapplicant_common_customer");
				txt_flag = "N";
				hshValues.put("hidAction","update");
				hshValues.put("hidapptype","R");
				hshValues.put("strApplicationNo",strApplicationNo);
			}
				arrValues.add(strCBSID);
				arrValues.add(strTitle);
				arrValues.add(strFullName);
				arrValues.add(strShortName);
				arrValues.add(strFatherName);
				arrValues.add(strConstitution);
				arrValues.add(strPANNo);
				arrValues.add(strSex);
				arrValues.add(strDOB);
				arrValues.add(strMartialStatus);
				arrValues.add(strStatus);
				arrValues.add(strBorrStatus);
				arrValues.add(strOrgScode);
				arrValues.add(strRegNo);
				arrValues.add(strTaxSlab);
				arrValues.add(strEmployment);
				arrValues.add(strLineofActivity);
				arrValues.add(strLoASince);
				arrValues.add(strBanking);
				arrValues.add(strBorrowerSince);
				arrValues.add(strSalaryRouted);
				arrValues.add(strStaffRelation);
				arrValues.add(strRelationName);
				arrValues.add(strBloodRelation);
				arrValues.add(strIntroducerName);
				arrValues.add(strIntroStatus);
				arrValues.add(strTradeFinance);
				arrValues.add(strInlandTrade);
				arrValues.add(strIndustryCode);
				arrValues.add(strCorpReligion);
				arrValues.add(strIndustryName);
				arrValues.add(strSatisfactory);
				if(strCusType.equalsIgnoreCase("New"))
				{
					arrValues.add(strApplicationNo);
					arrValues.add("Y");
				}
				arrValues.add(strJustificationDetails);
				arrValues.add(strRelativeStaffID);
				arrValues.add(strNetworth);
				arrValues.add(strNetworthAsonDate);
				arrValues.add(strIntroducertype);
				arrValues.add(strIntroStaffId);
				arrValues.add(strIntroCBSId);				
				arrValues.add(strConstitutionNew);
				arrValues.add(strsel_lending);
				arrValues.add(strHeldWomen);
				arrValues.add(strAadharNo);
				arrValues.add(strpartnership);
				arrValues.add(strpartDeedDate);
				arrValues.add(strpartRegno);
				arrValues.add(txt_comp_repDate);
				arrValues.add(txt_com_authCapital);
				arrValues.add(txt_com_PaidupCapital);
				arrValues.add(sel_MOA_verified);
				arrValues.add(amendedMOA_comments);
				arrValues.add(txt_trust_deeddate);
				arrValues.add(sel_trustType);
				arrValues.add(txt_trust_refno_openacc);
				arrValues.add(txt_udyog_aadhar);
				arrValues.add(txt_mse_regno);
				arrValues.add(strLegalentityid);
				arrValues.add(strExpirydate);
				arrValues.add(strudyamregno);
				arrValues.add(strturnover);
				arrValues.add(strturnoverdate);
				arrValues.add(strcatgeorysales);
				arrValues.add(strCertificationdate);
				arrValues.add(strmsmeclassfication);
				//arrValues.add(strminorityindustry);
				arrValues.add(txt_restructdate);
				arrValues.add(strUserId);
				arrValues.add(strDay);	
				//arrValues.add(Helper.correctNull((String)hshValues.get("sel_fac_otherbank")));
				if(!strCusType.equalsIgnoreCase("New"))
				{
					arrValues.add("Y");
					arrValues.add(strApplicationNo);
				}
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
			
			
			String strResidentStatus="",strCountry="",strisStaff="",strStaffID="",strStaffDOJ="",strReligion="",strCaste="";
			String strMinority="",strChildDep="",strOtherDep="",strEarningMem="",strEduQual="",strAreaSpecial="",strSeniorCitizen="";
			String strPhysicalChgd="",strExService="",strYearsofService="",strisMinor="",strGaurdianCBSID="",strGaurdianName="",strGaurdianReln="";
			String strGaurdianAddr="",strSpouseTitle="",strSpouseName="",strSpouseDOB="01/0/1900",strSpouseOcc="",strSpouseQual="";
			String strSpousePANNo="",strSpouseEmployer,strSpouseIncome="0.00",strSpouseAddr="",strFamilyIncome="";
			
			strResidentStatus=Helper.correctNull((String)hshValues.get("sel_resident_status"));
			strCountry=Helper.correctNull((String)hshValues.get("txt_country"));
			strisStaff=Helper.correctNull((String)hshValues.get("sel_istaff"));
			strStaffID=Helper.correctNull((String)hshValues.get("txt_staff_id"));
			strStaffDOJ=Helper.correctNull((String)hshValues.get("txt_dateofjoining"));
			strReligion=Helper.correctNull((String)hshValues.get("sel_religion"));
			strCaste=Helper.correctNull((String)hshValues.get("sel_caste"));
			strMinority=Helper.correctNull((String)hshValues.get("sel_minority"));
			strChildDep=Helper.correctNull((String)hshValues.get("txt_dep_children"));
			strOtherDep=Helper.correctNull((String)hshValues.get("txt_dep_others"));
			strEarningMem=Helper.correctNull((String)hshValues.get("txt_earning_member"));
			strEduQual=Helper.correctNull((String)hshValues.get("sel_edu_qual"));
			strAreaSpecial=Helper.correctNull((String)hshValues.get("txt_area_spec"));
			//strSeniorCitizen=Helper.correctNull((String)hshValues.get("sel_senior_citizen"));
			strDate=Helper.getCurrentDateTime();
			long longApplntAge=Helper.dateDiff(strDOB, strDate)/365;//Age calculation in years from days
			if(longApplntAge>=60)
			{
				strSeniorCitizen="Y";
			}
			else
			{
				strSeniorCitizen="N";
			}
			strPhysicalChgd=Helper.correctNull((String)hshValues.get("sel_phy_hycpd"));
			strExService=Helper.correctNull((String)hshValues.get("sel_ex_servicemen"));
			strYearsofService=Helper.correctNull((String)hshValues.get("txt_yrs_service"));
			strisMinor=Helper.correctNull((String)hshValues.get("sel_minor"));
			strGaurdianCBSID=Helper.correctNull((String)hshValues.get("txt_guardian_cbsid"));
			strGaurdianName=Helper.correctNull((String)hshValues.get("txt_guardian_name"));
			strGaurdianReln=Helper.correctNull((String)hshValues.get("sel_gaurdian_relationship"));
			strGaurdianAddr=Helper.correctNull((String)hshValues.get("txt_gaurdian_addr"));
			strSpouseTitle=Helper.correctNull((String)hshValues.get("sel_spouse_title"));
			strSpouseName=Helper.correctNull((String)hshValues.get("txt_spouse_name"));
			strSpouseDOB=Helper.correctNull((String)hshValues.get("txt_spouse_dob"));
			strSpouseOcc=Helper.correctNull((String)hshValues.get("txt_spouse_occupation"));
			strSpouseQual=Helper.correctNull((String)hshValues.get("sel_spouse_qualification"));
			strSpousePANNo=Helper.correctNull((String)hshValues.get("txt_spouse_panno"));
			strSpouseEmployer=Helper.correctNull((String)hshValues.get("txt_spouse_employer"));
			strSpouseIncome=Helper.correctNull((String)hshValues.get("txt_spouse_netmonthly_income"));
			strSpouseAddr=Helper.correctNull((String)hshValues.get("txtar_spouse_addr"));
			strFamilyIncome=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_familyincome"))));
			strBankArrange=Helper.correctNull((String)hshValues.get("sel_bankarrange"));
			strBankSector=Helper.correctNull((String)hshValues.get("sel_sector"));
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","del_individual_info_common_customer");
			arrValues.add(strApplicationNo);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("2",hshQuery);
			
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId","ins_individual_info_common_customer");
			arrValues.add(strResidentStatus);
			arrValues.add(strCountry);
			arrValues.add(strisStaff);
			arrValues.add(strStaffDOJ);
			arrValues.add(strStaffID);
			arrValues.add(strCaste);
			arrValues.add(strMinority);
			arrValues.add(strReligion);
			arrValues.add(strChildDep);
			arrValues.add(strOtherDep);
			arrValues.add(strEarningMem);
			arrValues.add(strEduQual);
			arrValues.add(strAreaSpecial);
			arrValues.add(strSeniorCitizen);
			arrValues.add(strPhysicalChgd);
			arrValues.add(strExService);
			arrValues.add(strYearsofService);
			arrValues.add(strisMinor);
			arrValues.add(strGaurdianCBSID);
			arrValues.add(strGaurdianName);
			arrValues.add(strGaurdianReln);
			arrValues.add(strGaurdianAddr);
			arrValues.add(strSpouseTitle);
			arrValues.add(strSpouseName);
			arrValues.add(strSpouseDOB);
			arrValues.add(strSpouseOcc);
			arrValues.add(strSpouseQual);
			arrValues.add(strSpousePANNo);
			arrValues.add(strSpouseEmployer);
			arrValues.add(strSpouseIncome);
			arrValues.add(strSpouseAddr);
			arrValues.add(strApplicationNo);
			arrValues.add(strFamilyIncome);
			arrValues.add(strBankArrange);
			arrValues.add(strBankSector);
			arrValues.add(strsel_Blind);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("3",hshQuery);
			
			
				
				String strOwnershipType="",strROCNumber="",strCIN="",strTIN="",strGSTIN="",strIEC="",strGroup="",strGroupName="",strIndustryType="",strTotalEmployees="";
				String strNBFCLoA="",strNBFCDeposit="",strNBFCInfra="",strNBFCAsset="",strMFI="",strMajority="",strSHGLoc="";
				String strMembers="",strBeneficiaries="",strSHGScheme="",strNGOFinance="",strSavingsAcct="",strCommencementDate="",
				strIncorporationDate="",strMajoritymem="",strTypeofLiability="",strCompanygroupid="";strGSTIN="";
				
				strCommencementDate=Helper.correctNull((String)hshValues.get("txt_buss_commencement_date"));
				strIncorporationDate=Helper.correctNull((String)hshValues.get("txt_incorporation_date"));
				strOwnershipType=Helper.correctNull((String)hshValues.get("sel_ownership_type"));
				strROCNumber=Helper.correctNull((String)hshValues.get("txt_roc_number"));
				strCIN=Helper.correctNull((String)hshValues.get("txt_cin_number"));
				if(!("").equalsIgnoreCase(strCIN)){
					strCIN=strCIN.toUpperCase();
				}
				strTIN=Helper.correctNull((String)hshValues.get("txt_tin_number"));
				strGroup=Helper.correctNull((String)hshValues.get("hid_groupid"));
				strGroupName=Helper.correctNull((String)hshValues.get("txt_group"));
				strIndustryType=Helper.correctNull((String)hshValues.get("sel_industry_type"));
				strTotalEmployees=Helper.correctNull((String)hshValues.get("txt_total_employees"));
				strNBFCLoA=Helper.correctNull((String)hshValues.get("sel_loa_nbfc"));
				strNBFCDeposit=Helper.correctNull((String)hshValues.get("sel_nbfc_deposit"));
				strNBFCInfra=Helper.correctNull((String)hshValues.get("sel_nbfc_infrastructure"));
				strNBFCAsset=Helper.correctNull((String)hshValues.get("sel_nbfc_asset"));
				strMFI=Helper.correctNull((String)hshValues.get("sel_mfi"));
				strMajority=Helper.correctNull((String)hshValues.get("sel_firm_minority"));
				strSHGLoc=Helper.correctNull((String)hshValues.get("sel_shg_location"));
				strMembers=Helper.correctNull((String)hshValues.get("txt_shg_members"));
				strBeneficiaries=Helper.correctNull((String)hshValues.get("txt_shg_beneficiaries"));
				strSHGScheme=Helper.correctNull((String)hshValues.get("sel_shg_promoting_agency"));
				strNGOFinance=Helper.correctNull((String)hshValues.get("sel_ngo_finance"));
				strSavingsAcct=Helper.correctNull((String)hshValues.get("txt_shg_savings_acctno"));
				strMajoritymem=Helper.correctNull((String)hshValues.get("sel_majoritymem"));
				strTypeofLiability=Helper.correctNull((String)hshValues.get("txt_typeofliab"));
				strCompanygroupid=Helper.correctNull((String)hshValues.get("hidcomgroupid"));
				strGSTIN=Helper.correctNull((String)hshValues.get("txt_GSTIN_reg"));
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","del_company_info_common_customer");
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("4",hshQuery);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","ins_company_info_common_customer");
				arrValues.add(strApplicationNo);
				arrValues.add(strCommencementDate);
				arrValues.add(strIncorporationDate);
				arrValues.add(strOwnershipType);
				arrValues.add(strROCNumber);
				arrValues.add(strCIN);
				arrValues.add(strTIN);
				arrValues.add(strGroup);
				arrValues.add(strGroupName);
				arrValues.add(strIndustryType);
				arrValues.add(strTotalEmployees);
				arrValues.add(strNBFCLoA);
				arrValues.add(strNBFCDeposit);
				arrValues.add(strNBFCInfra);
				arrValues.add(strNBFCAsset);
				arrValues.add(strMFI);
				arrValues.add(strMajority);
				arrValues.add(strSHGLoc);
				arrValues.add(strMembers);
				arrValues.add(strBeneficiaries);
				arrValues.add(strSHGScheme);
				arrValues.add(strNGOFinance);
				arrValues.add(strSavingsAcct);
				arrValues.add(strMajoritymem);
				arrValues.add(strTypeofLiability);
				arrValues.add(strCompanygroupid);
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_iec")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_GSTINNO")));
				arrValues.add(strGSTIN);
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_GSTIN_Exempted")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_employee_asondate")));
				/*arrValues.add(strudyamregno);
				arrValues.add(strturnover);
				arrValues.add(strturnoverdate);
				arrValues.add(strcatgeorysales);*/
				hshQueryValues.put("size","5");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("5",hshQuery);	
			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			hshValues.put("cust_type","existing");

			/***
			 * For Audit Trial New Data - By Karthikeyan.S on 12/09/2013
			 */
			
			String strTitleDesc=getMasterDesc("CBSMast","1",strTitle);
			String strConstitutionDesc=getMasterDesc("CBSMast","2",strConstitutionNew);
			String strMartialStatusDesc=getMasterDesc("CBSMast","3",strMartialStatus);
			String strStatusDesc=getMasterDesc("CBSMast","4",strStatus);
			String strTaxSlabDesc=getMasterDesc("CBSMast","5",strTaxSlab);
			String strIntroStatusDesc=getMasterDesc("CBSMast","6",strIntroStatus);
			String strCasteDesc=getMasterDesc("CBSMast","7",strCaste);
			String strEduQualDesc=getMasterDesc("CBSMast","8",strEduQual);
			String strSpouseOccDesc=getMasterDesc("CBSMast","9",strSpouseOcc);
			String strCorpReligionDesc=getMasterDesc("CBSMast","11",strCorpReligion);
			String strReligionDesc=getMasterDesc("CBSMast","11",strReligion);
			String strResidentStatusDesc=getMasterDesc("CBSMast","18",strResidentStatus);
			String strGaurdianRelnDesc=getMasterDesc("CBSMast","19",strGaurdianReln);
			String strSpouseQualDesc=getMasterDesc("StatMast","105",strSpouseQual);
			String strBorrStatusDesc=getMasterDesc("StatMast","109",strBorrStatus);
			String strLineofActivityDesc=getMasterDesc("StatMast","113",strLineofActivity);
			String strStaffRelationDesc=getMasterDesc("StatMast","110",strStaffRelation);
			String strBloodRelationDesc=getMasterDesc("StatMast","111",strBloodRelation);
			String strSHGLocDesc=getMasterDesc("StatMast","114",strSHGLoc);
			String strSHGSchemeDesc=getMasterDesc("StatMast","115",strSHGScheme);
			String strSexDesc="";
			
			
			strQuery=SQLParser.getSqlQuery("selincexpense^"+strApplicationNo);
			rs=DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				hshQueryValues=new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","upd_peracctualincome");
				if(strEmployment.equalsIgnoreCase("1") || strEmployment.equalsIgnoreCase("9"))
					arrValues.add(Helper.correctNull(rs.getString("perinc_yearsalary")));
				else
                    arrValues.add(Helper.correctNull(rs.getString("perinc_year1_income")));
				
				arrValues.add(strApplicationNo);
				hshQueryValues.put("size","1");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1",hshQuery);
				
				
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}	
			////////	
			
	
				String[] tempcount=null;
				int countsize=0;
				hshQueryValues = new HashMap();
				if(hshValues.get("txt_assetname") instanceof String[])
				{
					countsize++;
					arrValues = new ArrayList();
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					hshQueryValues.put("size", String.valueOf(countsize));
					hshQuery.put("strQueryId", "del_com_assetcharg");
					arrValues.add(strApplicationNo);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(String.valueOf(countsize),hshQuery);
					
					
					String[] txt_assetname = (String[])hshValues.get("txt_assetname");
					String[] txt_charholder = (String[])hshValues.get("txt_charholder");
					String[] txt_assetsdate = (String[])hshValues.get("txt_assetsdate");
					
					tempcount = (String[])hshValues.get("txt_assetname");
					 for(int i=0;i<tempcount.length;i++)
					 {
						 if(!txt_assetname[i].equalsIgnoreCase("") || !txt_charholder[i].equalsIgnoreCase("")||!txt_assetsdate[i].equalsIgnoreCase(""))
						 {
						 	countsize++;
						 	hshQuery = new HashMap();
							arrValues = new ArrayList();
							hshQueryValues.put("size", String.valueOf(countsize));
							hshQuery.put("strQueryId", "ins_com_assetcharg");
							arrValues.add(strApplicationNo);
							arrValues.add(String.valueOf(i+1));
							arrValues.add(txt_assetname[i]);
							arrValues.add(txt_charholder[i]);
							arrValues.add(txt_assetsdate[i]);
							
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put(String.valueOf(countsize),hshQuery);
						 }
					 }
					 EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
				else 
				{
					String txt_assetname = Helper.correctNull((String)hshValues.get("txt_assetname"));
					String txt_charholder = Helper.correctNull((String)hshValues.get("txt_charholder"));
					String txt_assetsdate = Helper.correctNull((String)hshValues.get("txt_assetsdate"));
					
					 if(!txt_assetname.equalsIgnoreCase("") || !txt_charholder.equalsIgnoreCase("")||!txt_assetsdate.equalsIgnoreCase(""))
					 {
						 	hshQuery = new HashMap();
							arrValues = new ArrayList();
							hshQueryValues.put("size","1");
							hshQuery.put("strQueryId", "del_com_assetcharg");
							arrValues.add(strApplicationNo);
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("1",hshQuery);
							
						 	hshQuery = new HashMap();
							arrValues = new ArrayList();
							hshQueryValues.put("size","2");
							hshQuery.put("strQueryId", "ins_com_assetcharg");
							arrValues.add(strApplicationNo);
							arrValues.add("1");
							arrValues.add(txt_assetname);
							arrValues.add(txt_charholder);
							arrValues.add(txt_assetsdate);
							
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("2",hshQuery);
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					 }
				}
				
			
	////////////
			if(strSex.equalsIgnoreCase("M"))
			{
				strSexDesc="Male";
			}
			else if(strSex.equalsIgnoreCase("F"))
			{
				strSexDesc="Female";
			}
			else if(strSex.equalsIgnoreCase("O"))
			{
				strSexDesc="Others";
			}
			String strEmploymentDesc="";
			if(strEmployment.equalsIgnoreCase("1"))
			{
				strEmploymentDesc="Employee";
			}
			else if(strEmployment.equalsIgnoreCase("2"))
			{
				strEmploymentDesc="Business Man";
			}
			else if(strEmployment.equalsIgnoreCase("3"))
			{
				strEmploymentDesc="Professionals";
			}
			else if(strEmployment.equalsIgnoreCase("4"))
			{
				strEmploymentDesc="Agriculture and allied activities";
			}
			else if(strEmployment.equalsIgnoreCase("6"))
			{
				strEmploymentDesc="Retail Trade";
			}
			else if(strEmployment.equalsIgnoreCase("7"))
			{
				strEmploymentDesc="SME (Services)";
			}
			else if(strEmployment.equalsIgnoreCase("8"))
			{
				strEmploymentDesc="SME (Manufacturing)";
			}
			else if(strEmployment.equalsIgnoreCase("9"))
			{
				strEmploymentDesc="Pensioner";
			}
			else if(strEmployment.equalsIgnoreCase("10"))
			{
				strEmploymentDesc="Student";
			}
			else if(strEmployment.equalsIgnoreCase("11"))
			{
				strEmploymentDesc="Others";
			}
			String strBankingDesc="";
			if(strBanking.equalsIgnoreCase("1"))
			{
				strBankingDesc="Yes";
			}
			else if(strBanking.equalsIgnoreCase("2"))
			{
				strBankingDesc="No";
			}
			String strSalaryRoutedDesc="";
			if(strSalaryRouted.equalsIgnoreCase("1"))
			{
				strSalaryRoutedDesc="Yes";
			}
			else if(strSalaryRouted.equalsIgnoreCase("2"))
			{
				strSalaryRoutedDesc="No";
			}
			String strTradeFinanceDesc="";
			if(strTradeFinance.equalsIgnoreCase("Y"))
			{
				strTradeFinanceDesc="Yes";
			}
			else if(strTradeFinance.equalsIgnoreCase("N"))
			{
				strTradeFinanceDesc="No";
			}
			String strInlandTradeDesc="";
			if(strInlandTrade.equalsIgnoreCase("1"))
			{
				strInlandTradeDesc="Yes";
			}
			else if(strInlandTrade.equalsIgnoreCase("2"))
			{
				strInlandTradeDesc="No";
			}
			String strSatisfactoryDesc="";
			if(strSatisfactory.equalsIgnoreCase("Y"))
			{
				strSatisfactoryDesc="Yes";
			}
			else if(strSatisfactory.equalsIgnoreCase("N"))
			{
				strSatisfactoryDesc="No";
			}
			String strisStaffDesc="";
			if(strisStaff.equalsIgnoreCase("02"))
			{
				strisStaffDesc="Yes";
			}
			else if(strisStaff.equalsIgnoreCase("01"))
			{
				strisStaffDesc="No";
			}
			String strMinorityDesc="";
			if(strMinority.equalsIgnoreCase("Y"))
			{
				strMinorityDesc="Yes";
			}
			else if(strMinority.equalsIgnoreCase("N"))
			{
				strMinorityDesc="No";
			}
			String strPhysicalChgdDesc="";
			if(strPhysicalChgd.equalsIgnoreCase("Y"))
			{
				strPhysicalChgdDesc="Yes";
			}
			else if(strPhysicalChgd.equalsIgnoreCase("N"))
			{
				strPhysicalChgdDesc="No";
			}
			String strExServiceDesc="";
			if(strExService.equalsIgnoreCase("Y"))
			{
				strExServiceDesc="Yes";
			}
			else if(strExService.equalsIgnoreCase("N"))
			{
				strExServiceDesc="No";
			}
			String strisMinorDesc="";
			if(strisMinor.equalsIgnoreCase("Y"))
			{
				strisMinorDesc="Yes";
			}
			else if(strisMinor.equalsIgnoreCase("N"))
			{
				strisMinorDesc="No";
			}
			String strSpouseTitleDesc="";
			if(strSpouseTitle.equalsIgnoreCase("MR"))
			{
				strSpouseTitleDesc="MR.";
			}
			else if(strSpouseTitle.equalsIgnoreCase("MRS"))
			{
				strSpouseTitleDesc="MRS.";
			}
			String strOwnershipTypeDesc="";
			if(strOwnershipType.equalsIgnoreCase("099"))
			{
				strOwnershipTypeDesc="Others";
			}
			else if(strOwnershipType.equalsIgnoreCase("001"))
			{
				strOwnershipTypeDesc="Individual";
			}
			else if(strOwnershipType.equalsIgnoreCase("002"))
			{
				strOwnershipTypeDesc="Private Limited Company";
			}
			else if(strOwnershipType.equalsIgnoreCase("003"))
			{
				strOwnershipTypeDesc="Public Limited Company";
			}
			else if(strOwnershipType.equalsIgnoreCase("004"))
			{
				strOwnershipTypeDesc="Partnership";
			}
			else if(strOwnershipType.equalsIgnoreCase("005"))
			{
				strOwnershipTypeDesc="Joint Borrowers";
			}
			else if(strOwnershipType.equalsIgnoreCase("006"))
			{
				strOwnershipTypeDesc="Sole Proprietor";
			}
			else if(strOwnershipType.equalsIgnoreCase("007"))
			{
				strOwnershipTypeDesc="Joint Venture";
			}
			else if(strOwnershipType.equalsIgnoreCase("008"))
			{
				strOwnershipTypeDesc="Wholly owned subsidiary";
			}
			else if(strOwnershipType.equalsIgnoreCase("009"))
			{
				strOwnershipTypeDesc="Trusts";
			}
			else if(strOwnershipType.equalsIgnoreCase("010"))
			{
				strOwnershipTypeDesc="NBFC";
			}
			else if(strOwnershipType.equalsIgnoreCase("011"))
			{
				strOwnershipTypeDesc="H.U.F";
			}
			String strIndustryTypeDesc="";
			if(strIndustryType.equalsIgnoreCase("001"))
			{
				strIndustryTypeDesc="Services";
			}
			else if(strIndustryType.equalsIgnoreCase("002"))
			{
				strIndustryTypeDesc="Exports";
			}
			else if(strIndustryType.equalsIgnoreCase("003"))
			{
				strIndustryTypeDesc="Agriculture";
			}
			else if(strIndustryType.equalsIgnoreCase("004"))
			{
				strIndustryTypeDesc="Infrastructure";
			}
			else if(strIndustryType.equalsIgnoreCase("005"))
			{
				strIndustryTypeDesc="Trading";
			}
			else if(strIndustryType.equalsIgnoreCase("006"))
			{
				strIndustryTypeDesc="Manufacturing";
			}
			String strNBFCLoADesc="";
			if(strNBFCLoA.equalsIgnoreCase("Y"))
			{
				strNBFCLoADesc="Yes";
			}
			else if(strNBFCLoA.equalsIgnoreCase("N"))
			{
				strNBFCLoADesc="No";
			}
			String strNBFCDepositDesc="";
			if(strNBFCDeposit.equalsIgnoreCase("Y"))
			{
				strNBFCDepositDesc="Yes";
			}
			else if(strNBFCDeposit.equalsIgnoreCase("N"))
			{
				strNBFCDepositDesc="No";
			}
			String strNBFCInfraDesc="";
			if(strNBFCInfra.equalsIgnoreCase("Y"))
			{
				strNBFCInfraDesc="Yes";
			}
			else if(strNBFCInfra.equalsIgnoreCase("N"))
			{
				strNBFCInfraDesc="No";
			}
			String strNBFCAssetDesc="";
			if(strNBFCAsset.equalsIgnoreCase("Y"))
			{
				strNBFCAssetDesc="Yes";
			}
			else if(strNBFCAsset.equalsIgnoreCase("N"))
			{
				strNBFCAssetDesc="No";
			}
			String strMFIDesc="";
			if(strMFI.equalsIgnoreCase("Y"))
			{
				strMFIDesc="Yes";
			}
			else if(strMFI.equalsIgnoreCase("N"))
			{
				strMFIDesc="No";
			}
			String strMajorityDesc="";
			if(strMajority.equalsIgnoreCase("Y"))
			{
				strMajorityDesc="Yes";
			}
			else if(strMajority.equalsIgnoreCase("N"))
			{
				strMajorityDesc="No";
			}
			String strNGOFinanceDesc="";
			if(strNGOFinance.equalsIgnoreCase("Y"))
			{
				strNGOFinanceDesc="Yes";
			}
			else if(strNGOFinance.equalsIgnoreCase("N"))
			{
				strNGOFinanceDesc="No";
			}
			
			sbActionData.append("CBS Customer ID=").append(strCBSID).append("~Title=").append(strTitleDesc)
			.append("~Full Name=").append(strFullName).append("~Short Name=").append(strShortName)
			.append("~Father Name=").append(strFatherName).append("~Constitution=").append(strConstitutionDesc)
			.append("~PAN No=").append(strPANNo).append("~Gender=").append(strSexDesc).append("~DOB=").append(strDOB)
			.append("~Marital Status=").append(strMartialStatusDesc).append("~Status=").append(strStatusDesc)
			.append("~Borrower Status=").append(strBorrStatusDesc).append("~Tax Slab=").append(strTaxSlabDesc)
			.append("~Employment Status=").append(strEmploymentDesc)
			//.append("~Line of Activity=").append(strLineofActivityDesc)
			//.append("~Since=").append(strLoASince)
			.append("~Banking with us=").append(strBankingDesc)
			.append("~Borrower Since=").append(strBorrowerSince)
			.append("~Is salary routed through our bank=").append(strSalaryRoutedDesc)
			.append("~Any relation to bank staff or relatives=").append(strStaffRelationDesc)
			.append("~Staff ID=").append(strRelativeStaffID)
			.append("~Name=").append(strRelationName).append("~Blood relation=").append(strBloodRelationDesc)
			.append("~Introducer Name=").append(strIntroducerName).append("~Introducer Status=").append(strIntroStatusDesc)
			.append("~Trade Finance=").append(strTradeFinanceDesc).append("~Inland Trade Allowed=").append(strInlandTradeDesc)
			.append("~Religion=").append(strCorpReligionDesc).append("~Satisfactory Dealing=").append(strSatisfactoryDesc);
			//.append("~Justification Details=").append(strJustificationDetails);
			
			sbActionData.append("~Resident Status=").append(strResidentStatusDesc).append("~Country=").append(strCountry)
			.append("~Whether Staff?=").append(strisStaffDesc).append("~Date of Joining=").append(strStaffDOJ)
			.append("~Staff ID=").append(strStaffID).append("~Caste/Tribe=").append(strCasteDesc)
			.append("~Minority=").append(strMinorityDesc).append("~Religion=").append(strReligionDesc)
			.append("~No. of Children Dependents=").append(strChildDep)
			.append("~No. of Other Dependents=").append(strOtherDep)
			.append("~Earning Member in family=").append(strEarningMem)
			.append("~Educational Qualification=").append(strEduQualDesc).append("~Area Specialized=").append(strAreaSpecial)
			.append("~Physically Challenged=").append(strPhysicalChgdDesc).append("~Ex-Serviceman=").append(strExServiceDesc)
			.append("~Years of Service=").append(strYearsofService).append("~Whether Minor=").append(strisMinorDesc)
			.append("~Guardian CBSID=").append(strGaurdianCBSID).append("~Guardian Name=").append(strGaurdianName)
			.append("~Guardian Relationship=").append(strGaurdianRelnDesc)
			//.append("~Guardian Address=").append(strGaurdianAddr)
			.append("~Spouse Title=").append(strSpouseTitleDesc).append("~Spouse Name=").append(strSpouseName)
			.append("~Spouse DOB=").append(strSpouseDOB).append("~Spouse Occupation=").append(strSpouseOccDesc)
			.append("~Spouse Qualification=").append(strSpouseQualDesc).append("~Spouse PAN No=").append(strSpousePANNo)
			.append("~Spouse Employer=").append(strSpouseEmployer)
			.append("~Spuse Income=").append(strSpouseIncome)
			//.append("~Spouse Address=").append(strSpouseAddr)
			.append("~Family Income=").append(strFamilyIncome);
			
			sbActionData.append("~Date of Commencement of business=").append(strCommencementDate)
			.append("~Date of Incorporation=").append(strIncorporationDate)
			.append("~Type of Ownership=").append(strOwnershipTypeDesc).append("~ROC Number=").append(strROCNumber)
			.append("~CIN=").append(strCIN).append("~TIN=").append(strTIN).append("~IEC=").append(strIEC)
			.append("~GSTIN=").append(strGSTIN)
			.append("~Group=").append(strGroupName)
			.append("~Industry Type=").append(strIndustryTypeDesc)
			.append("~Total Employees=").append(strTotalEmployees)
			.append("~Whether Line of Activity undertaken is NBFC=").append(strNBFCLoADesc)
			.append("~Deposit Taking NBFC=").append(strNBFCDepositDesc)
			.append("~Infrastructure Financing NBFC=").append(strNBFCInfraDesc)
			.append("~Asset Financing NBFC=").append(strNBFCAssetDesc).append("~Whether MFI=").append(strMFIDesc)
			.append("~Whether majority of members/owners belong to minority community=").append(strMajorityDesc)
			.append("~SHG Formed/Located at=").append(strSHGLocDesc).append("~No. of members=").append(strMembers)
			.append("~No. of Beneficiaries=").append(strBeneficiaries)
			.append("~Promoting Agency/Scheme (if any)=").append(strSHGSchemeDesc)
			.append("~Whether financed through any NGOs=").append(strNGOFinanceDesc)
			.append("~Savings Banks account maintained by SHG=").append(strSavingsAcct);
			
		    AuditTrial.auditNewLog(hshValues, "201", strApplicationNo, sbActionData.toString(), sbOldAudit.toString());
		    /***
		     * End - Audit Trial New Data
		     */
		    if(rs!=null)
				rs.close();
		    int strnoofpartners=0;
		    strQuery = SQLParser.getSqlQuery("sel_partnerscount^" + strApplicationNo);
			rs1 = DBUtils.executeQuery(strQuery);
				if (rs1.next()) {
					strnoofpartners=Integer.parseInt((Helper.correctInt((String)(rs1.getString("COMAPP_CBSID")))));
					strnoofpartners=strnoofpartners/2;
					strnoofpartners=Math.round(strnoofpartners);
					log.info("<<<<<<<<<<<<<<<<===============strnoofpartners==========>>>>>>>>>>>>>>>>>"+strnoofpartners);
				}
		    int intminoritycount= 0;
			if(rs1!=null)
				rs1.close();
			strQuery = SQLParser.getSqlQuery("sel_grpmangminoritychk^" + strApplicationNo);
			rs1 = DBUtils.executeQuery(strQuery);
				while (rs1.next()) {
			strQuery = SQLParser.getSqlQuery("sel_partnerschk^" + Helper.correctNull((String) rs1.getString("COMAPP_CBSID")));
			rs2 = DBUtils.executeQuery(strQuery);
			if (rs2.next()) {
				
						if (Helper.correctNull((String) rs2.getString("COMINFO_MINORITY_COMMUNITY")).equalsIgnoreCase("Y")) {

							intminoritycount++;
						}
				
				}
			log.info("<<<<<<==============count of miority===============>>>>>>>>"+intminoritycount);
				}
				if(strnoofpartners>=intminoritycount){
					strminorityflag="Y";
				}
				if(rs1!=null)
					rs1.close();
				String strconstitution="";
				strQuery = SQLParser.getSqlQuery("sel_perapp_memberslist^" + strApplicationNo);
				rs1 = DBUtils.executeQuery(strQuery);
					if (rs1.next()) {
						strconstitution=Helper.correctNull((String) rs1.getString("PERAPP_CONSTITUTIONNEW"));
					
					if(!(correctNull((String)rs1.getString("PERAPP_CONSTITUTIONNEW")).equalsIgnoreCase(Helper.correctNull((String)hshValues.get("sel_applt_constitutionnew"))))){
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						arrValues.add(strApplicationNo);
						arrValues.add(strApplicationNo);
						hshQuery.put("strQueryId","upd_misreselectflag"); 
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size","1");
						hshQueryValues.put("1",hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
					}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in updateDemographics "+e.getMessage());	
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
		hshGetValues.put("hidAppType","");	
		hshGetValues.put("radiobutton","id");
		hshGetValues.put("hidDemoId",strApplicationNo);
		hshGetValues.put("applnt",strapplnt);
		hshGetValues.put("strUserId",strUserId);

		//hshGetValues.put("strminorityflag",strminorityflag);	

		if(!(txt_flag.trim().equals("Y")) && (tmp.trim().equals("Y")))
		{
			hshResult = getDemographics(hshGetValues);
			hshResult.put("custtmpid",custtmpid);
			hshResult.put("txt_flag",txt_flag);	
			return hshResult;
		}
		else
		{
			hshValues.put("perapp_id","new");
			hshValues.put("custtmpid",custtmpid);
			hshValues.put("txt_flag",txt_flag);
			hshValues.put("strminorityflag",strminorityflag);

			return hshValues;
		}
		
		
		
	}

	/**
	*	Function  deleteDemographics This Method is used to get 
	*	Income detail of  personal application form
	*	@param hshValues     
	*   @return HashMap		 
	*	@exception java.lang.Exception
	*/

	public void deleteDemographics(HashMap hshValues) 
	{		 
		ResultSet rs=null;
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		HashMap hshResult=new HashMap();
		HashMap hshResult1=new HashMap();
		HashMap hshGetValues=new HashMap();
		String strExp ="$"; 
		int count=0;
		String strApplicationNo=correctNull((String)hshValues.get("hidDemoId"));
				
		try
		{
			hshQueryValues.put("size","5"); 
			 rs=DBUtils.executeLAPSQuery("mastchkdemo^"+strApplicationNo);
			 
			while (rs.next())
			{				
				if(!((correctNull((String)rs.getString("app_delflag"))).equals("Y")))
				{
					count++;
					hshValues.put("hidAction","delete");
					hshResult1=(HashMap)EJBInvoker.executeStateLess("additionalParameter",hshValues,"updateadditionalParameter");
					hshResult.put("hshValues1",hshResult1);
					log.info("Inside LOOP");
					break;
				}				
			}	
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("mastchkdemo_com^"+strApplicationNo);
			while (rs.next())
			{				
					if(!((correctNull((String)rs.getString("app_delflag"))).equals("Y")))
					{
						count++;
						hshValues.put("hidAction","delete");
						hshResult1=(HashMap)EJBInvoker.executeStateLess("additionalParameter",hshValues,"updateadditionalParameter");
						hshResult.put("hshValues1",hshResult1);
						log.info("Inside LOOP");
						break;
					}				
			}	
			if(count>0)
			{
				hshGetValues.put("nodelete","nodelete");
				hshGetValues.put("hidAppType","");	
				hshGetValues.put("hidDemoId",strApplicationNo);		
	
				strExp =strExp +  "Cannot delete this applicant master,it is used by applications";
				//Logger.log("strExp11111111111111111111111= "+strExp);
				throw new Exception(strExp);
			}
			else
			{
				hshResult.put("nodelete","delete");
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","deldemographics");
				hshQueryValues.put("1",hshQuery);
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","mastdelper");
				hshQueryValues.put("2",hshQuery);
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","del_individual_info_common_customer");
				hshQueryValues.put("3",hshQuery);
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","del_company_info_common_customer");
				hshQueryValues.put("4",hshQuery);

				//Start of Audit Trial
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				//for Entering the values into auditrial
				String strActionData = "Title="+correctNull((String)hshValues.get("txtperapp_apptitle"))+
				"~First Name="+correctNull((String)hshValues.get("txtperapp_fname"))+
				"~Short Name="+correctNull((String)hshValues.get("txtperapp_lname"))+
				"~CBS Customer ID="+correctNull((String)hshValues.get("txtcbs_id"))+
				"~Constitution="+correctNull((String)hshValues.get("txt_perappconstitution"))+
				"~PAN / GIR No="+correctNull((String)hshValues.get("txtperapp_panno"))+
				"~Date of Birth="+correctNull((String)hshValues.get("txtperapp_dob"))+
				"~Sex="+correctNull((String)hshValues.get("choperapp_sex"))+
				"~Marital Status="+correctNull((String)hshValues.get("choperapp_marstat"))+
				"~Status="+correctNull((String)hshValues.get("sel_istatus"))+
				"~E-mail="+correctNull((String)hshValues.get("txtperapp_email"))+
				"~Application Recd. From="+correctNull((String)hshValues.get("txt_perapporg"))+
				"~Type of Profession="+correctNull((String)hshValues.get("txtprofessional"))+
				"~Reg No="+correctNull((String)hshValues.get("txt_regno"))+
				"~Voter Id="+correctNull((String)hshValues.get("txt_voterId"))+
				"~Driving License No="+correctNull((String)hshValues.get("txt_DrivingNo"))+
				"~Other Identification Document="+correctNull((String)hshValues.get("txt_other_doc"))+
				"~Address1="+correctNull((String)hshValues.get("txtperapp_address1"))+
				"~Address2="+correctNull((String)hshValues.get("txtperapp_address2"))+
				"~Address3="+correctNull((String)hshValues.get("txtperapp_address3"))+
				"~City="+correctNull((String)hshValues.get("txtperapp_city"))+
				"~State="+correctNull((String)hshValues.get("txtperapp_state"))+
				"~Pin Code="+correctNull((String)hshValues.get("txtperapp_zip"))+
				"~Phone No.="+correctNull((String)hshValues.get("txtperapp_phone"))+
				"~Mobile No. ="+correctNull((String)hshValues.get("txtperapp_mobile"))+
				"~Country ="+correctNull((String)hshValues.get("txtperapp_country"))+
				"~Permanent Address1="+correctNull((String)hshValues.get("txtperapp_permadd1"))+
				"~Permanent Address2="+correctNull((String)hshValues.get("txtperapp_permadd2"))+
				"~Permanent Address3="+correctNull((String)hshValues.get("txtperapp_permadd3"))+
				"~Permanent City="+correctNull((String)hshValues.get("txtperapp_permcity"))+
				"~Permanent State="+correctNull((String)hshValues.get("txtperapp_permstate"))+
				"~Permanent Pin="+correctNull((String)hshValues.get("txtperapp_permzip"))+
				"~Permanent Phone No.="+correctNull((String)hshValues.get("txtperapp_permphone"))+
				"~Permanent Country="+correctNull((String)hshValues.get("txtperapp_permcountry"))+
				"~Mobility="+correctNull((String)hshValues.get("txtperapp_yrsinpresadd"))+
				"~Is the Residence="+correctNull((String)hshValues.get("sel_residence"))+
				"~Place of Domicile="+correctNull((String)hshValues.get("txt_placeofdomicile"))+
				"~Value of the Residence="+correctNull((String)hshValues.get("txt_cost_res"))+
				"~Date of Purchase="+correctNull((String)hshValues.get("txt_purchasedate"))+
				"~Resident Status="+correctNull((String)hshValues.get("selstatus"))+
				"~NRI Domicile="+correctNull((String)hshValues.get("txt_country"))+
				"~Date of becoming NRI="+correctNull((String)hshValues.get("txt_dateofNRI"))+
				"~Passport Number="+correctNull((String)hshValues.get("txtperapp_passport"))+
				"~Passport Issued by="+correctNull((String)hshValues.get("txtperapp_passissue"))+
				"~Passport Issue Date="+correctNull((String)hshValues.get("txtperapp_passportissuedate"))+
				"~Passport Expiry Date="+correctNull((String)hshValues.get("txtperapp_passportexpirydate"))+
				"~Employment Status="+correctNull((String)hshValues.get("select_Occupation"))+
				"~Line of Activity="+correctNull((String)hshValues.get("select_OccupationSub"))+
				"~Pension Payment Order Number ="+correctNull((String)hshValues.get("txtperapp_pension"))+
				"~Is the job transferrable="+correctNull((String)hshValues.get("sel_transferrable"))+
				"~Job transferable Location="+correctNull((String)hshValues.get("sel_jobloacation"))+
				"~Whether Staff="+correctNull((String)hshValues.get("sel_istaff"))+
				"~Date of joining="+correctNull((String)hshValues.get("txt_dateofjoining"))+
				"~PF No.="+correctNull((String)hshValues.get("txt_Userid"))+
				"~Confirmation Date="+correctNull((String)hshValues.get("txt_confirmationdate"))+
				"~Name of the Nominee - P.F="+correctNull((String)hshValues.get("txt_nomineepf"))+
				"~Relationship="+correctNull((String)hshValues.get("txt_pfrelation"))+
//	textarea			"~Service Record="+correctNull((String)hshValues.get(""))+
				"~Name of Nominee - Gratuity="+correctNull((String)hshValues.get("txt_nomineegratuity"))+
				"~Relationship(Gratuity)="+correctNull((String)hshValues.get("txt_gratuityrelation"))+
				
				
				"~Banking with us="+correctNull((String)hshValues.get("selbank"))+
				"~Since (Year)="+correctNull((String)hshValues.get("txtperapp_since"))+
				"~Account Type ="+correctNull((String)hshValues.get("txtperapp_acctype"))+
				"~Account No="+correctNull((String)hshValues.get("txtperapp_accno"))+
				"~Is salary routed through our bank="+correctNull((String)hshValues.get("sel_salaryrooted"))+
				"~Category="+correctNull((String)hshValues.get("selcat"))+
				"~Caste="+correctNull((String)hshValues.get("txt_caste"))+
				"~Religion="+correctNull((String)hshValues.get("selreligion"))+
				"~No. of Dependents(Children)="+correctNull((String)hshValues.get("txtperapp_childnum"))+
				"~No. of Dependents(Others)="+correctNull((String)hshValues.get("txtperapp_depend"))+
				"~Earning Member in family="+correctNull((String)hshValues.get("txtperapp_earn"))+
//	textarea			"~Others Earning Member in family="+correctNull((String)hshValues.get("txtperapp_otherearn"))+"
				"~Educational Qualification="+correctNull((String)hshValues.get("seledu"))+
				"~Area Specialized="+correctNull((String)hshValues.get("txt_area_spec"))+
				"~Physically Handicapped="+correctNull((String)hshValues.get("selPhyHand"))+
				"~Minority="+correctNull((String)hshValues.get("selMinority"))+
				"~Ex-Serviceman="+correctNull((String)hshValues.get("selExService"))+
				"~Years of Service="+correctNull((String)hshValues.get("txt_yrs_service"))+
				"~Any relative is working in the bank="+correctNull((String)hshValues.get("selbuss"))+
				"~Which Branch="+correctNull((String)hshValues.get("txtperapp_branch"))+
				"~Whether Minor="+correctNull((String)hshValues.get("sel_minor"))+
				"~Guardian Name="+correctNull((String)hshValues.get("txt_guardianame"))+
				"~Guardian Relationship="+correctNull((String)hshValues.get("txt_guardian"))+
//	textarea			"~Guardian Address="+correctNull((String)hshValues.get("txt_relation"))+			
				"~Trade Finance="+correctNull((String)hshValues.get("sel_trade"))+
				"~Inland Trade Allowed="+correctNull((String)hshValues.get("sel_inland"))+
				"~Introducer Title="+correctNull((String)hshValues.get("txt_ititle"))+

				"~Introducer Name="+correctNull((String)hshValues.get("txt_iname"))+
				"~Title of Spouse="+correctNull((String)hshValues.get("sel_spouse"))+
				"~Spouse Name="+correctNull((String)hshValues.get("txtperapp_husname"))+
				"~Spouse Occupation="+correctNull((String)hshValues.get("txtperapp_occupation"))+
				"~Spouse Email="+correctNull((String)hshValues.get("txtperapp_spemail"))+
				"~Spouse PAN No./GIR="+correctNull((String)hshValues.get("txtperapp_sppan"))+
				"~Spouse Income="+correctNull((String)hshValues.get("txtperapp_spincome"));
			
				hshQuery.put("strQueryId","audittrial");
				arrValues.add("30");
				arrValues.add(correctNull((String)hshValues.get("strUserId")));
				arrValues.add(correctNull((String)hshValues.get("strClientIP")));
				arrValues.add(strApplicationNo);
				arrValues.add(strActionData);
				arrValues.add("Delete");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("5",hshQuery);	
				//End of Audit trial		
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","del_company_info_ncgtc");
				hshQueryValues.put("6",hshQuery);
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
			catch(Exception e)
			{
				log.error("Error in finally deleteDemographics "+e.getMessage());
			}
		}		
		//return hshResult;
	}

	/**
	*	Function  getIncome This Method is used to get 
	*	Income detail of  personal application form
	*	@param hshValues     
	*   @return HashMap		 
	*	@exception java.lang.Exception
	*/

	public HashMap getIncome(HashMap hshValues) 
	{		 
		ResultSet rs=null;
		HashMap hshResult=new HashMap();
		String strApplicationNo="", strQuery="";
		String strAppStatus="";
		String peremploymentstatus = correctNull((String)hshValues.get("peremployment"));
		String strAppID="";
		if(peremploymentstatus.equalsIgnoreCase(""))
		{
			peremploymentstatus=Helper.correctNull((String)hshValues.get("strEmployment"));
		}
		
		String appno = correctNull((String) hshValues.get("appno"));
		
		if(appno.equalsIgnoreCase("null") ||  appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("strappno"));
		}
		if(appno.equalsIgnoreCase("null") ||  appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("comappid"));
		}
		
		strApplicationNo=correctNull((String)hshValues.get("hidDemoId"));
		
		if(strApplicationNo.equalsIgnoreCase("") || strApplicationNo.equalsIgnoreCase("null")){
		strApplicationNo=correctNull((String)hshValues.get("hidapplicantnewid"));
		}
		
		boolean bState=false;
		/*String strtakehome="";
		double dbltakehome=0.0;
		double dblgross=0.0;
		double dbltotal=0.0;
		double dblother=0.0;*/
		String recordflag = "N";
		try
		{
			strAppStatus=Helper.correctNull((String)hshValues.get("hidappstatus"));

			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				hshResult.put("appname", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshResult.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshResult.put("applicantid", rs.getString("demo_appid"));
				strAppID=Helper.correctNull((String)rs.getString("demo_appid"));
			}
			if(peremploymentstatus.equalsIgnoreCase(""))
			{
				if(!strAppID.equalsIgnoreCase(""))
				{
					if(rs!=null)
					{
						rs.close();
					}
					strQuery = SQLParser.getSqlQuery("sel_employmentstatus^" + strAppID);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						peremploymentstatus=Helper.correctNull((String)rs.getString("perapp_employment"));
					}
					hshResult.put("peremployment",peremploymentstatus);
				}
			}
			if(rs!=null)
			{
				rs.close();
			}
			if(!strApplicationNo.equals(""))
			{				 
				rs=DBUtils.executeLAPSQuery("pergetIncome1^"+strApplicationNo);				 
				bState=rs.next();
				if(!bState)
				{
					hshResult.put("perinc_id",correctNull((String)hshValues.get("hidDemoId")));
				}
				while(bState)
				{	
					hshResult.put("perinc_id",correctNull(rs.getString("perinc_id")));
					hshResult.put("perinc_monsalary",correctNull(rs.getString("perinc_monsalary")));
					//dblgross=Double.parseDouble(Helper.correctDouble(correctNull(rs.getString("perinc_monsalary"))));
					hshResult.put("perinc_takehome",correctNull(rs.getString("perinc_takehome")));
					//dbltakehome=Double.parseDouble(Helper.correctDouble(rs.getString("perinc_takehome")));
					hshResult.put("perinc_otherincome",correctNull(rs.getString("perinc_otherincome")));
					//dblother=Double.parseDouble(Helper.correctDouble(rs.getString("perinc_otherincome")));
					hshResult.put("perinc_rent",correctNull(rs.getString("perinc_rent")));
					hshResult.put("perinc_agriculture",correctNull(rs.getString("perinc_agriculture")));
					hshResult.put("perinc_secincome",correctNull(rs.getString("perinc_secincome")));
					hshResult.put("perinc_autoloanexp",correctNull(rs.getString("perinc_autoloanexp")));
					hshResult.put("perinc_domesticexp",correctNull(rs.getString("perinc_domesticexp")));
					hshResult.put("perinc_rentexp",correctNull(rs.getString("perinc_rentexp")));
					hshResult.put("perinc_otherexp",correctNull(rs.getString("perinc_otherexp")));
					hshResult.put("perinc_secdesc",correctNull(rs.getString("perinc_secdesc")));			
					//hshResult.put("perinc_selfincometype",correctNull(rs.getString("perinc_selfincometype")));
					hshResult.put("perinc_selfyrsprof",correctNull(rs.getString("perinc_selfyrsprof")));
					hshResult.put("perinc_others",correctNull(rs.getString("perinc_others")));
					hshResult.put("perinc_deduction",correctNull(rs.getString("perinc_deduction")));
					hshResult.put("txa_desc",correctNull(rs.getString("perinc_desc")));
					hshResult.put("perinc_otherdeduction",correctNull(rs.getString("perinc_otherdeduction")));
					hshResult.put("perinc_yearsalary",correctNull(rs.getString("perinc_yearsalary")));
					hshResult.put("perinc_yeardeduction",correctNull(rs.getString("perinc_yeardeduction")));
					hshResult.put("perinc_yearotherdeduc",correctNull(rs.getString("perinc_yearotherdeduc")));
					hshResult.put("txt_employment",peremploymentstatus);	
					hshResult.put("perinc_itreturn",correctNull(rs.getString("perinc_itreturn")));
					hshResult.put("perinc_assetandliab",correctNull(rs.getString("perinc_assetandliab")));
					hshResult.put("perinc_year1",correctNull(rs.getString("perinc_year1")));
					hshResult.put("perinc_year2",correctNull(rs.getString("perinc_year2")));
					hshResult.put("perinc_year3",correctNull(rs.getString("perinc_year3")));
					hshResult.put("perinc_year1_income",correctNull(rs.getString("perinc_year1_income")));
					hshResult.put("perinc_year2_income",correctNull(rs.getString("perinc_year2_income")));
					hshResult.put("perinc_year3_income",correctNull(rs.getString("perinc_year3_income")));
					hshResult.put("perinc_pattern",correctNull(rs.getString("perinc_pattern")));
					hshResult.put("perinc_proof",correctNull(rs.getString("perinc_proof")));
					hshResult.put("perinc_loyalty",correctNull(rs.getString("perinc_loyalty")));
					hshResult.put("perinc_history",correctNull(rs.getString("perinc_history")));
					hshResult.put("PERAPPACTUALINCOME",correctNull(rs.getString("PERAPPACTUALINCOME")));
					
					if(!Helper.correctNull((String)rs.getString("perinctype")).equalsIgnoreCase(""))
					{
						recordflag="Y";
					}
					hshResult.put("perinctype",correctNull(rs.getString("perinctype")));
					hshResult.put("perinc_it",correctNull(rs.getString("perinc_it")));
					hshResult.put("perinc_depreciation_year1",correctNull(rs.getString("perinc_depreciation_year1")));
					hshResult.put("perinc_depreciation_year2",correctNull(rs.getString("perinc_depreciation_year2")));
					hshResult.put("perinc_intonliab_year1",correctNull(rs.getString("perinc_intonliab_year1")));
					hshResult.put("perinc_intonliab_year2",correctNull(rs.getString("perinc_intonliab_year2")));
					hshResult.put("perinc_itrdate1",correctNull(rs.getString("perinc_itrdate1")));
					hshResult.put("perinc_itrdate2",correctNull(rs.getString("perinc_itrdate2")));
					hshResult.put("perinc_yearend1",correctNull(rs.getString("perinc_yearend1")));
					hshResult.put("perinc_yearend2",correctNull(rs.getString("perinc_yearend2")));
					hshResult.put("perinc_capitalgain",correctNull(rs.getString("perinc_capitalgain")));
					hshResult.put("perinc_profit_year1",correctNull(rs.getString("PERINC_PROFITBUSINESS1")));
					hshResult.put("perinc_profit_year2",correctNull(rs.getString("PERINC_PROFITBUSINESS2")));
					hshResult.put("perinc_inc_supportdoc",correctNull(rs.getString("perinc_inc_supportdoc")));
					bState=rs.next();
					
				}
				if(rs!=null)
					rs.close();
			
			}
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("getPanNo^"+strApplicationNo);
			if(rs.next())
			{
				hshResult.put("Panno",Helper.correctNull((String)rs.getString("perapp_panno")));
			}
			
			HashMap prof=new HashMap();
			HashMap profile=new HashMap();
			prof.put("profile_id",strApplicationNo);
			profile=(HashMap)getCustomerProfileStatus(prof);
			hshResult.put("strIncompletepage", Helper.correctNull((String)profile.get("strIncompletepage")));
			
			String strProfilestatus="";
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("getprofilestatusfromdemographic^"+strApplicationNo);
			if(rs.next())
			{
				strProfilestatus=Helper.correctNull((String)rs.getString("perapp_profilestatus"));
			}
			hshResult.put("strProfilestatus",strProfilestatus);
			rs=DBUtils.executeLAPSQuery("pergetemploy^"+strApplicationNo);
			 
			while(rs.next())
			{
				hshResult.put("empstatus",correctNull(rs.getString("perapp_employment")));
				//hshResult.put("peremploy",correctNull(rs.getString("perapp_eduothers")));
			}
			if(rs!=null){
				rs.close();}
			
			hshResult.put("recordflag",recordflag);
			hshResult.put("appstatus",strAppStatus);

		}
		catch(Exception e)
		{
			throw new EJBException("Error in getIncome "+e.getMessage());	
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
		return hshResult;
	}	

	/**
	*	Function  updateIncome This Method is used for inserting or updating  
	*	or inserting Income detail of  personal application form
	*	@param hshValues     
	*   @return HashMap		 
	*	@exception java.lang.Exception
	*/
	
	public HashMap updateIncome(HashMap hshValues) 
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		HashMap hshResult=new HashMap();
		String strApplicationNo=correctNull((String)hshValues.get("hidDemoId"));
		String peremploymentstatus = correctNull((String)hshValues.get("peremployment"));
		String strapplnt="";
		HashMap hshPasValues=new HashMap();
		ResultSet rs=null;
		String strConstitution="";
		String strQuery="";
		String strActionFlag="N";
		StringBuilder sbOldAudit = new StringBuilder();
		try
		{	
			rs=DBUtils.executeLAPSQuery("getconstitutionfromdemographic^"+strApplicationNo);
			if(rs.next())
			{
				strConstitution=Helper.correctNull((String)rs.getString("perapp_constitution"));
			}
			strapplnt = correctNull((String)hshValues.get("applnt"));
/** By gokul - for the purpose of 'Audit trial' */
			if(rs!=null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("pergetIncome1^"+strApplicationNo);
			if(rs.next())
			{
				strActionFlag="Y";
				
				/***
				 * For Audit Trial Old Data - By Karthikeyan.S on 14/09/2013
				 */
				String strIncDet=Helper.correctNull((String)rs.getString("perinctype"));
				String strIncDetDesc="";
				if(strIncDet.equalsIgnoreCase("1"))
				{
					strIncDetDesc="Monthly";
				}
				else if(strIncDet.equalsIgnoreCase("2"))
				{
					strIncDetDesc="Yearly";
				}
				String strAnnualIncPat=Helper.correctNull((String)rs.getString("perinc_pattern"));
				String strAnnualIncPatDesc="";
				if(strAnnualIncPat.equalsIgnoreCase("1"))
				{
					strAnnualIncPatDesc="Steady Growth";
				}
				else if(strAnnualIncPat.equalsIgnoreCase("2"))
				{
					strAnnualIncPatDesc="No Change";
				}
				else if(strAnnualIncPat.equalsIgnoreCase("3"))
				{
					strAnnualIncPatDesc="Decline";
				}
				else if(strAnnualIncPat.equalsIgnoreCase("4"))
				{
					strAnnualIncPatDesc="Irregular / Haphazard";
				}
				String strTaxDet=Helper.correctNull((String)rs.getString("perinc_proof"));
				String strTaxDetDesc="";
				if(strTaxDet.equalsIgnoreCase("1"))
				{
					strTaxDetDesc="IT Assesse";
				}
				else if(strTaxDet.equalsIgnoreCase("2"))
				{
					strTaxDetDesc="Non-Assesse";
				}
				String strLatestIT=Helper.correctNull((String)rs.getString("perinc_itreturn"));
				String strLatestITDesc="";
				if(strLatestIT.equalsIgnoreCase("Y"))
				{
					strLatestITDesc="Yes";
				}
				else if(strLatestIT.equalsIgnoreCase("N"))
				{
					strLatestITDesc="No";
				}
				String strAssetLiab=Helper.correctNull((String)rs.getString("perinc_assetandliab"));
				String strAssetLiabDesc="";
				if(strAssetLiab.equalsIgnoreCase("Y"))
				{
					strAssetLiabDesc="Yes";
				}
				else if(strAssetLiab.equalsIgnoreCase("N"))
				{
					strAssetLiabDesc="No";
				}
					
				sbOldAudit.append("~Primary Income Details =").append(strIncDetDesc)
				.append(" ~Gross Income (Salary/Pension) Monthly Rs.=").append(Helper.correctNull((String)rs.getString("perinc_monsalary")))
				.append(" ~Gross Income (Salary/Pension) Yearly Rs.=").append(Helper.correctNull((String)rs.getString("perinc_yearsalary")))
				.append(" ~Income Tax Monthly Rs.=").append(Helper.correctNull((String)rs.getString("perinc_deduction")))
				.append(" ~Income Tax Yearly Rs.=").append(Helper.correctNull((String)rs.getString("perinc_yeardeduction")))
				.append(" ~Other Deductions Monthly Rs.=").append(Helper.correctNull((String)rs.getString("perinc_otherdeduction")))
				.append(" ~Other Deductions Yearly Rs.=").append(Helper.correctNull((String)rs.getString("perinc_yearotherdeduc")))
				.append(" ~Other Income Monthly Rs.=").append(Helper.correctNull((String)rs.getString("perinc_otherincome")))
				.append(" ~Total Net Income Yearly Rs.=").append(Helper.correctNull((String)rs.getString("perinc_takehome")))
				.append(" ~Breakup for Other deductions(Only for Information)^")
				.append(" ~Total Loan Repayment Rs.=").append(Helper.correctNull((String)rs.getString("perinc_autoloanexp")))
				.append(" ~Insurance Rs.=").append(Helper.correctNull((String)rs.getString("perinc_domesticexp")))
				.append(" ~Other Deductions 1 Rs.=").append(Helper.correctNull((String)rs.getString("perinc_rentexp")))
				.append(" ~Other Deductions 2 Rs.=").append(Helper.correctNull((String)rs.getString("perinc_otherexp")))
				.append(" ~Other Income Details^")
				.append(" ~Rent Rs.=").append(Helper.correctNull((String)rs.getString("perinc_rent")))
				.append(" ~Agriculture Rs.=").append(Helper.correctNull((String)rs.getString("perinc_agriculture")))
				.append(" ~Others Rs.=").append(Helper.correctNull((String)rs.getString("perinc_others")))
				.append(" ~Annual Income Pattern=").append(strAnnualIncPatDesc)
				.append(" ~Income Tax Details=").append(strTaxDetDesc)
				.append(" ~Other Details^")
				.append(" ~Latest I.T. Return verified ? =").append(strLatestITDesc)
				.append(" ~Statement of Assets & Liabilities verfied ? =").append(strAssetLiabDesc)
				.append(" ~Annual Income^")
				.append(" ~Year 1 Income as per ITR/FS/Declaration = ").append(Helper.correctNull((String)rs.getString("perinc_year1_income")))
				.append(" ~Year 2 Income as per ITR/FS/Declaration = ").append(Helper.correctNull((String)rs.getString("perinc_year2_income")))
				.append(" ~Year 1 Add:Depreciation = ").append(Helper.correctNull((String)rs.getString("perinc_depreciation_year1")))
				.append(" ~Year 2 Add:Depreciation = ").append(Helper.correctNull((String)rs.getString("perinc_depreciation_year2")))
				.append(" ~Year 1 Add:Interest of Existing liabilites = ").append(Helper.correctNull((String)rs.getString("perinc_intonliab_year1")))
				.append(" ~Year 2 Add:Interest of Existing liabilites = ").append(Helper.correctNull((String)rs.getString("perinc_intonliab_year2")));
				
				/***
				 * End - Audit Trial Old Data
				 */
			}
			if(rs!=null)
				rs.close();
/** end */			
			
			arrValues.add(strApplicationNo);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","perdelIncome");
			hshQueryValues.put("1",hshQuery);
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			arrValues.add(correctNull(strApplicationNo));
			if(correctNull((String)hshValues.get("txtperinc_monsalary")).equals(""))
			{
				arrValues.add("0.0");
				
			}
			else
			{
				arrValues.add(correctNull((String)hshValues.get("txtperinc_monsalary")));
			}
			if(correctNull((String)hshValues.get("txtperinc_yeartotalincome")).equals(""))
			{
				arrValues.add("0.0");
			}
			else
			{
				arrValues.add(correctNull((String)hshValues.get("txtperinc_yeartotalincome")));
			}
			if(correctNull((String)hshValues.get("txtperinc_otherincome")).equals(""))
			{
				arrValues.add("0.0");
			}
			else
			{
				arrValues.add(correctNull((String)hshValues.get("txtperinc_otherincome")));
			}
			if(correctNull((String)hshValues.get("txtperinc_rent")).equals(""))
			{
				arrValues.add("0.0");
			}
			else
			{
				arrValues.add(correctNull((String)hshValues.get("txtperinc_rent")));
			}
			if(correctNull((String)hshValues.get("txtperinc_agriculture")).equals(""))
			{
				arrValues.add("0.0");
			}
			else
			{
				arrValues.add(correctNull((String)hshValues.get("txtperinc_agriculture")));
			}
			if(correctNull((String)hshValues.get("txtperinc_yearotherincome")).equals(""))
			{
				arrValues.add("0.0");
			}
			else
			{	
				arrValues.add(correctNull((String)hshValues.get("txtperinc_yearotherincome")));
			}
			if(correctNull((String)hshValues.get("txtperinc_autoloanexp")).equals(""))
			{
				arrValues.add("0.0");
			}
			else
			{
				arrValues.add(correctNull((String)hshValues.get("txtperinc_autoloanexp")));
			}
			if(correctNull((String)hshValues.get("txtperinc_domexp")).equals(""))
			{
				arrValues.add("0.0");
			}
			else
			{
				arrValues.add(correctNull((String)hshValues.get("txtperinc_domexp")));
			}	
			if(correctNull((String)hshValues.get("txtperinc_rentexp")).equals(""))
			{
				arrValues.add("0.0");
			}
			else
			{
				arrValues.add(correctNull((String)hshValues.get("txtperinc_rentexp")));
			}
			if(correctNull((String)hshValues.get("txtperinc_otherexp")).equals(""))
			{
				arrValues.add("0.0");
			}
			else
			{
				arrValues.add(correctNull((String)hshValues.get("txtperinc_otherexp")));
			}
			arrValues.add(correctNull((String)hshValues.get("txtperinc_secdesc")));	
			
			arrValues.add(correctNull((String)hshValues.get("hidApp_type")));
			if(correctNull((String)hshValues.get("txtperinc_others")).equals(""))
			{
				arrValues.add("0");
			}
			else
			{
				arrValues.add(correctNull((String)hshValues.get("txtperinc_others")));
			}			
			arrValues.add(correctNull((String)hshValues.get("textfield")));

			if(correctNull((String)hshValues.get("txtperinc_deduction1")).equals(""))
			{
				arrValues.add("0.0");
			}
			else
			{
				arrValues.add(correctNull((String)hshValues.get("txtperinc_deduction1")));
			}
			arrValues.add(correctNull((String)hshValues.get("txa_desc")));
			if(correctNull((String)hshValues.get("txt_otherdeduction")).equals(""))
			{
				arrValues.add("0.0");
			}
			else
			{		
				arrValues.add(correctNull((String)hshValues.get("txt_otherdeduction")));
			}
			if(correctNull((String)hshValues.get("txtperinc_Yearlysalary")).equals(""))
			{
				arrValues.add("0.0");
			}
			else
			{		
				arrValues.add(correctNull((String)hshValues.get("txtperinc_Yearlysalary")));
			}
			if(correctNull((String)hshValues.get("txtperinc_yeardeduction")).equals(""))
			{
				arrValues.add("0.0");
			}
			else
			{		
				arrValues.add(correctNull((String)hshValues.get("txtperinc_yeardeduction")));
			}
			if(correctNull((String)hshValues.get("txtperinc_yearotherdedec")).equals(""))
			{
				arrValues.add("0.0");
			}
			else
			{		
				arrValues.add(correctNull((String)hshValues.get("txtperinc_yearotherdedec")));
			}
			arrValues.add(correctNull((String)hshValues.get("cboitreturn")));
			arrValues.add(correctNull((String)hshValues.get("cboassetliability")));
			arrValues.add(correctNull((String)hshValues.get("txt_year1")));
			arrValues.add(correctNull((String)hshValues.get("txt_year2")));
			arrValues.add(correctNull((String)hshValues.get("txt_year3")));
			if(correctNull((String)hshValues.get("txt_yearincome1")).equalsIgnoreCase(""))
			{
				arrValues.add("0.0");
			}
			else
			{
				arrValues.add(correctNull((String)hshValues.get("txt_yearincome1")));
			}
			if(correctNull((String)hshValues.get("txt_yearincome2")).equalsIgnoreCase(""))
			{
				arrValues.add("0.0");
			}
			else
			{
				arrValues.add(correctNull((String)hshValues.get("txt_yearincome2")));
			}
			if(correctNull((String)hshValues.get("txt_yearincome3")).equalsIgnoreCase(""))
			{
				arrValues.add("0.0");
			}
			else
			{
				arrValues.add(correctNull((String)hshValues.get("txt_yearincome3")));
			}
			if(strConstitution.equals(""))
			{
				arrValues.add("0");
			}
			else
			{
				arrValues.add(strConstitution);
			}	
			arrValues.add(correctNull((String)hshValues.get("incpattern")));
			arrValues.add(correctNull((String)hshValues.get("incproof")));
			arrValues.add(correctNull((String)hshValues.get("cbo_loyalty")));
			arrValues.add(correctNull((String)hshValues.get("cbo_history")));
			arrValues.add(correctNull((String)hshValues.get("incometype")));
			arrValues.add(correctNull((String)hshValues.get("textarea_it")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_year1_depreciation")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_year2_depreciation")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_year1_intonliab")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_year2_intonliab")));
			arrValues.add("Y");
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_date1")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_date2")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_incyeardate1")));
			arrValues.add(Helper.correctNull((String)hshValues.get("txt_incyeardate2")));
			arrValues.add(Helper.correctNull((String)hshValues.get("hidPerappIncome")));
			if(correctNull((String)hshValues.get("txtperinc_capitalgain")).equals(""))
			{
				arrValues.add("0.0");
			}
			else
			{
				arrValues.add(correctNull((String)hshValues.get("txtperinc_capitalgain")));
			}
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_year1_profit")));
			arrValues.add(Helper.correctDouble((String)hshValues.get("txt_year2_profit")));
			arrValues.add(correctNull((String)hshValues.get("sel_documents")));
			hshQueryValues.put("size","2");
			hshQuery.put("arrValues",arrValues);	
			hshQuery.put("strQueryId","perInsIncome1");
			hshQueryValues.put("2",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			/** Start of Audit Trial */
			String strLenRel = "";
			String strRecRepay = "";
			String strAnnualInc="";
			String strIncTax = "";
			String strITVer="";
			String strAssetLiab="";
			//Length of Relationship
			if(correctNull((String)hshValues.get("cbo_loyalty")).trim().equalsIgnoreCase("1"))
				strLenRel = "3 years & above";
			else if(correctNull((String)hshValues.get("cbo_loyalty")).trim().equalsIgnoreCase("2"))
				strLenRel = "2 years to less than 3 years";
			else if(correctNull((String)hshValues.get("cbo_loyalty")).trim().equalsIgnoreCase("3"))
				strLenRel = "6 months to less than 2 years";
			else if(correctNull((String)hshValues.get("cbo_loyalty")).trim().equalsIgnoreCase("4"))
				strLenRel = "Less than 6 months";
			else if(correctNull((String)hshValues.get("cbo_loyalty")).trim().equalsIgnoreCase("5"))
				strLenRel = "New Customer";
			else if(correctNull((String)hshValues.get("cbo_loyalty")).trim().equalsIgnoreCase("6"))
				strLenRel = "Not Applicable";
			//Record of Repayment			
			if(correctNull((String)hshValues.get("cbo_history")).trim().equalsIgnoreCase("1"))
				strRecRepay = "Regular/Advance Payment during the year";
			else if(correctNull((String)hshValues.get("cbo_history")).trim().equalsIgnoreCase("2"))
				strRecRepay = "Account is regular but occasional default during the year";
			else if(correctNull((String)hshValues.get("cbo_history")).trim().equalsIgnoreCase("3"))
				strRecRepay = "One Installment / EMI due for the latest month only";
			else if(correctNull((String)hshValues.get("cbo_history")).trim().equalsIgnoreCase("4"))
				strRecRepay = "One EMI/Installments continuously in arrears";
			else if(correctNull((String)hshValues.get("cbo_history")).trim().equalsIgnoreCase("5"))
				strRecRepay = "Two EMI/Installments continuously in arrears";
			else if(correctNull((String)hshValues.get("cbo_history")).trim().equalsIgnoreCase("6"))
				strRecRepay = "Installment/Instant OD for > 3 months";
			else if(correctNull((String)hshValues.get("cbo_history")).trim().equalsIgnoreCase("7"))
				strRecRepay = "Account Closed by way of W/O compromise settlement";
			else if(correctNull((String)hshValues.get("cbo_history")).trim().equalsIgnoreCase("8"))
				strRecRepay = "No Borrowings";
			//Annual Income Pattern
			if(correctNull((String)hshValues.get("incpattern")).trim().equalsIgnoreCase("1"))
				strAnnualInc = "Steady Growth";
			else if(correctNull((String)hshValues.get("incpattern")).trim().equalsIgnoreCase("2"))
				strAnnualInc = "No Change ";
			else if(correctNull((String)hshValues.get("incpattern")).trim().equalsIgnoreCase("3"))
				strAnnualInc = "Decline";
			else if(correctNull((String)hshValues.get("incpattern")).trim().equalsIgnoreCase("4"))
				strAnnualInc = "Irregular / Haphazard";
			//Income Tax Details			
			if(correctNull((String)hshValues.get("incproof")).trim().equalsIgnoreCase("1"))
				strIncTax = "IT Assesse";
			else if(correctNull((String)hshValues.get("incproof")).trim().equalsIgnoreCase("2"))
				strIncTax = "Non-Assesse";
			//Latest IT Return Verified
			if(correctNull((String)hshValues.get("cboitreturn")).trim().equalsIgnoreCase("Y"))
				strITVer = "Yes";
			else
				strITVer = "No";
			//Statement of Assets & Liabilities
			if(correctNull((String)hshValues.get("cboassetliability")).trim().equalsIgnoreCase("Y"))
				strAssetLiab = "Yes";
			else
				strAssetLiab = "No";
			/**  ----------------------------------------  */		
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				String strActionData;
				StringBuilder sbAt = new StringBuilder();
				//For Entering the values into auditrial
				 sbAt.append("~Primary Income Details =");
				if(correctNull((String) hshValues.get("incometype")).equals("1"))
				{
					sbAt.append("Monthly");
				}
				else if(correctNull((String) hshValues.get("sel_CustType")).equals("2"))
				{
					sbAt.append("Yearly");
				}
				else
				{
					sbAt.append("");
				}
			//sbAt.append(strActionData);
			
			sbAt.append(" ~Gross Income (Salary/Pension) Monthly Rs.=").append(correctNull((String) hshValues.get("txtperinc_monsalary")));
			sbAt.append(" ~Gross Income (Salary/Pension) Yearly Rs.=").append(correctNull((String) hshValues.get("txtperinc_Yearlysalary")));
			
			sbAt.append(" ~Income Tax Monthly Rs.=").append(correctNull((String) hshValues.get("txtperinc_deduction1")));
			sbAt.append(" ~Income Tax Yearly Rs.=").append(correctNull((String) hshValues.get("txtperinc_yeardeduction")));
			
			sbAt.append(" ~Net Income Monthly Rs.=").append(correctNull((String) hshValues.get("txtperinc_deduc")));
			sbAt.append(" ~Net Income Yearly Rs.=").append(correctNull((String) hshValues.get("txtperinc_yearnetincome")));
			
			sbAt.append(" ~Other Deductions Monthly Rs.=").append(correctNull((String) hshValues.get("txt_otherdeduction")));
			sbAt.append(" ~Other Deductions Yearly Rs.=").append(correctNull((String) hshValues.get("txtperinc_yearotherdedec")));
			
			sbAt.append(" ~Other Income Monthly Rs.=").append(correctNull((String) hshValues.get("txtperinc_otherincome")));
			sbAt.append(" ~Other Income Yearly Rs.=").append(correctNull((String) hshValues.get("txtperinc_yearotherincome")));
			
			sbAt.append(" ~Total Net Income Monthly Rs.=").append(correctNull((String) hshValues.get("txtperinc_totincome")));
			sbAt.append(" ~Total Net Income Yearly Rs.=").append(correctNull((String) hshValues.get("txtperinc_yeartotalincome")));
			
			strActionData="~Rent ="+correctNull((String)hshValues.get("txtperinc_rent"))+
				"~Agriculture="+correctNull((String)hshValues.get("txtperinc_agriculture"))+
				"~Others="+correctNull((String)hshValues.get("txtperinc_others"))+
	//T.A			"~Description="+correctNull((String)hshValues.get("txtperinc_secdesc"))+
				"~Total(Other Details)="+correctNull((String)hshValues.get("txtperinc_othertotal"))+
				"~Total Loan Repayment="+correctNull((String)hshValues.get("txtperinc_autoloanexp"))+
				"~Insurance="+correctNull((String)hshValues.get("txtperinc_domexp"))+
				"~Other Deductions 1="+correctNull((String)hshValues.get("txtperinc_rentexp"))+
				"~Other Deductions 2="+correctNull((String)hshValues.get("txtperinc_otherexp"))+
				"~Total(Other Deductions)="+correctNull((String)hshValues.get("txtperinc_total"))+
	//T.A			"~Description(Other Deductions)="+correctNull((String)hshValues.get("txa_desc"))+			
				"~Length of Relationship with the Bank="+strLenRel+
				"~Record of Repayment="+strRecRepay+
				"~Annual Income Pattern="+strAnnualInc+
				"~Income Tax Details="+strIncTax+
				//"~Latest IT Return Verified="+strITVer+
				//"~Asset and Liability Verified="+strAssetLiab+
				"~Annual Income("+correctNull((String)hshValues.get("txt_year1"))+") ="+correctNull((String)hshValues.get("txt_yearincome1"))+
				"~Annual Income("+correctNull((String)hshValues.get("txt_year2"))+") ="+correctNull((String)hshValues.get("txt_yearincome2"))+
				"~Annual Income("+correctNull((String)hshValues.get("txt_year3"))+") ="+correctNull((String)hshValues.get("txt_yearincome3"));
				
			
			///StringBuilder sbAt = new StringBuilder();
				
			
			
			sbAt.append(" ~Breakup for Other deductions(Only for Information)^");
			sbAt.append(" ~Total Loan Repayment Rs.=").append(correctNull((String) hshValues.get("txtperinc_autoloanexp")));
			sbAt.append(" ~Insurance Rs.=").append(correctNull((String) hshValues.get("txtperinc_domexp")));
			sbAt.append(" ~Other Deductions 1 Rs.=").append(correctNull((String) hshValues.get("txtperinc_rentexp")));
			sbAt.append(" ~Other Deductions 2 Rs.=").append(correctNull((String) hshValues.get("txtperinc_otherexp")));
			sbAt.append(" ~Total Rs.=").append(correctNull((String)hshValues.get("txtperinc_total")));
			//sbAt.append(" ~Description=").append(correctNull((String)hshValues.get("txa_desc")));
			
			sbAt.append(" ~Other Income Details^");
			
			sbAt.append(" ~Rent Rs.=").append((String)hshValues.get("txtperinc_rent"));
			sbAt.append(" ~Agriculture Rs.=").append((String)hshValues.get("txtperinc_agriculture"));
			sbAt.append(" ~Others Rs.=").append(correctNull((String) hshValues.get("txtperinc_others")));
			sbAt.append(" ~Total Rs.=").append(correctNull((String) hshValues.get("txtperinc_othertotal")));
			//sbAt.append(" ~Length of Relationship with the Bank=").append(strLenRel);
			//sbAt.append(" ~Record of Repayment=").append(strRecRepay);
			sbAt.append(" ~Annual Income Pattern=").append(strAnnualInc);
			sbAt.append(" ~Income Tax Details=").append(strIncTax);
			
			sbAt.append(" ~Other Details^");
			sbAt.append(" ~Latest I.T. Return verified ? =").append(strITVer);
			sbAt.append(" ~Statement of Assets & Liabilities verfied ? =").append(strAssetLiab);
			
			sbAt.append(" ~Annual Income^");
			//sbAt.append(" ~Year (Ex. 2005-2006) = ").append(correctNull((String)hshValues.get("txt_year1"))).append(", ").append(correctNull((String)hshValues.get("txt_year2"))).append(", ").append(correctNull((String)hshValues.get("txt_year3")));
			sbAt.append(" ~Year 1 Income as per ITR/FS/Declaration = ").append(correctNull((String)hshValues.get("txt_yearincome1")))
			.append(" ~Year 2 Income as per ITR/FS/Declaration = ").append(correctNull((String)hshValues.get("txt_yearincome2")))//.append(", ").append(correctNull((String)hshValues.get("txt_yearincome3")));
			.append(" ~Year 1 Add:Depreciation = ").append(Helper.correctDouble((String)hshValues.get("txt_year1_depreciation")))
			.append(" ~Year 2 Add:Depreciation = ").append(Helper.correctDouble((String)hshValues.get("txt_year2_depreciation")))
			.append(" ~Year 1 Add:Interest of Existing liabilites = ").append(Helper.correctDouble((String)hshValues.get("txt_year1_intonliab")))
			.append(" ~Year 2 Add:Interest of Existing liabilites = ").append(Helper.correctDouble((String)hshValues.get("txt_year2_intonliab")));
			
			//sbAt.append(" ~Particulars of income tax & sales tax assesment =").append(correctNull((String) hshValues.get("textarea_it")));
			
			if(Helper.correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("Y"))
			{
				hshValues.put("hidAction", "update");			
			}else if(Helper.correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("N"))
			{
				hshValues.put("hidAction", "Insert");
			}
			AuditTrial.auditNewLog(hshValues, "209", strApplicationNo, sbAt.toString(), sbOldAudit.toString());
			
			String strAction=correctNull((String)hshValues.get("hidAction"));
			
			hshPasValues.put("hidDemoId",strApplicationNo);
			hshPasValues.put("applnt",strapplnt);
			hshPasValues.put("peremployment",peremploymentstatus);
			hshResult=getIncome(hshPasValues);
		}
		catch(Exception e)
		{
			throw new EJBException("Error in updateLoanProducts "+e.getMessage());	
		}
		return hshResult;
	}

	/**
	*	Function getEmployer This Method is used to get 
	*	Income detail of  personal application form
	*	@param hshValues     
	*   @return HashMap		 
	*	@exception java.lang.Exception
	**/

	public HashMap getEmployer(HashMap hshValues) 
	{
		ResultSet rs=null;ResultSet rs1=null;
		HashMap hshResult=new HashMap();		
		String strApplicationNo="";		
		strApplicationNo=correctNull((String)hshValues.get("hidDemoId"));
		boolean bState=false;
		String citycodeval="",statecode_val="",city_code_val="",state_code_val="";
		String permcity="",permstate="",strQuery="";
		String recordflag = "N";
		String strAppStatus="";
		try
		{ 
			strAppStatus=Helper.correctNull((String)hshValues.get("hidappstatus"));

			if(strApplicationNo.equalsIgnoreCase("") || strApplicationNo.equalsIgnoreCase("null"))
			{
				strApplicationNo=correctNull((String)hshValues.get("hidapplicantnewid"));
			}
			if(!strApplicationNo.equals(""))
			{				
				rs=DBUtils.executeLAPSQuery("pergetEmployer^"+strApplicationNo);				 
				bState=rs.next();
				
				if(!bState)
				{
					hshResult.put("peremp_id",correctNull((String)hshValues.get("hidDemoId")));
				}
				if(bState)
				{
					hshResult.put("peremp_id",correctNull(rs.getString("peremp_id")));
					hshResult.put("peremp_name",correctNull(rs.getString("peremp_name")));
					hshResult.put("peremp_address1",correctNull(rs.getString("peremp_address1")));
					hshResult.put("peremp_address2",correctNull(rs.getString("peremp_address2")));
					hshResult.put("peremp_address3",correctNull(rs.getString("peremp_address3")));
					hshResult.put("peremp_city",correctNull(rs.getString("peremp_city")));
					hshResult.put("perapp_empcity_code",correctNull(rs.getString("peremp_city")));
					citycodeval=correctNull(rs.getString("peremp_city"));
					hshResult.put("peremp_state",correctNull(rs.getString("peremp_state")));
					hshResult.put("peremp_zip",correctNull(rs.getString("peremp_zip")));
					hshResult.put("peremp_phone",correctNull(rs.getString("peremp_phone")));
					hshResult.put("peremp_fax",correctNull(rs.getString("peremp_fax")));
					hshResult.put("peremp_email",correctNull(rs.getString("peremp_email")));
					hshResult.put("peremp_design",correctNull(rs.getString("peremp_design")));						
					hshResult.put("peremp_contperson",correctNull(rs.getString("peremp_contperson")));
					hshResult.put("peremp_yresemp",correctNull(rs.getString("peremp_yresemp")));
					hshResult.put("peremp_prevempname",correctNull(rs.getString("peremp_prevempname")));
					hshResult.put("peremp_prevempcity",correctNull(rs.getString("peremp_prevempcity")));
					hshResult.put("perapp_emp1city_code",correctNull(rs.getString("peremp_prevempcity")));
					permcity=correctNull(rs.getString("peremp_prevempcity"));
					hshResult.put("peremp_applnt",correctNull(rs.getString("peremp_applnt")));
					hshResult.put("peremp_retage",correctNull(rs.getString("peremp_retage")));
					hshResult.put("peremp_department",correctNull(rs.getString("peremp_department")));					
					hshResult.put("peremp_servleft",correctNull(rs.getString("peremp_servleft")));					
					hshResult.put("peremp_retdate",correctNull(rs.getString("peremp_retdate")));					
					hshResult.put("peremp_empno",correctNull(rs.getString("peremp_empno")));
					hshResult.put("peremp_occupation",correctNull(rs.getString("peremp_occupation")));
					hshResult.put("peremp_phexten",correctNull(rs.getString("peremp_phexten")));
					hshResult.put("peremp_servleftmon",correctNull(rs.getString("peremp_servleftmon")));
					hshResult.put("peremp_category", correctNull((String)rs.getString("peremp_category")));
					hshResult.put("peremp_yearsinbuss", correctNull((String)rs.getString("peremp_yearsinbuss")));
					hshResult.put("peremp_establish", correctNull((String)rs.getString("peremp_establish")));
					hshResult.put("peremp_experience", correctNull((String)rs.getString("peremp_experience")));
					hshResult.put("peremp_lease", correctNull((String)rs.getString("peremp_lease")));
					hshResult.put("peremp_receipt", correctNull((String)rs.getString("peremp_receipt")));
					hshResult.put("peremp_country", correctNull((String)rs.getString("peremp_country")));
					hshResult.put("peremp_busowned", Helper.correctNull((String)rs.getString("PEREMP_BUSOWNED")));
					hshResult.put("peremp_licenseno", Helper.correctNull((String)rs.getString("peremp_licenseno")));
					hshResult.put("peremp_licensedate", Helper.correctNull((String)rs.getString("peremp_licensedate")));
					hshResult.put("peremp_expinyrs", Helper.correctNull((String)rs.getString("peremp_expinyrs")));
					hshResult.put("peremp_noofyrs", Helper.correctNull((String)rs.getString("peremp_noofyrs")));
					hshResult.put("peremp_confemp", Helper.correctNull((String)rs.getString("peremp_confemp")));
					hshResult.put("peremp_listcomp", Helper.correctNull((String)rs.getString("peremp_listcomp")));
					hshResult.put("peremp_dealing", Helper.correctNull((String)rs.getString("peremp_dealing")));
					hshResult.put("perapp_dob", Helper.correctNull((String)rs.getString("perapp_dob")));
					hshResult.put("PEREMP_SALARYROUTED", Helper.correctNull((String)rs.getString("PEREMP_SALARYROUTED")));
					hshResult.put("PEREMP_INCSOURCE", Helper.correctNull((String)rs.getString("PEREMP_INCSOURCE")));
					if(!citycodeval.equalsIgnoreCase(""))
					{
						strQuery = SQLParser.getSqlQuery("selcitycode^"+citycodeval);
						rs1 = DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							city_code_val = Helper.correctNull((String)rs1.getString(1));
							state_code_val = Helper.correctNull((String)rs1.getString(2));
							if(!state_code_val.equalsIgnoreCase(""))
							{
								strQuery = SQLParser.getSqlQuery("selstatecode^"+state_code_val);
								rs1 = DBUtils.executeQuery(strQuery);
								if(rs1.next())
								{
									statecode_val = Helper.correctNull((String)rs1.getString(1));
									
								}
							}
						}
					}
					hshResult.put("city_code_val",city_code_val);
					hshResult.put("statecode_val",statecode_val);
					String permcity_code_val="",permstate_code_val="",permstatecode_val="";
					if(!permcity.equalsIgnoreCase(""))
					{
						strQuery = SQLParser.getSqlQuery("selcitycode^"+ permcity);
						rs1 = DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							permcity_code_val = Helper.correctNull((String)rs1.getString(1));
							permstate_code_val = Helper.correctNull((String)rs1.getString(2));
							if(!permstate_code_val.equalsIgnoreCase(""))
							{
								strQuery = SQLParser.getSqlQuery("selstatecode^"+permstate_code_val);
								rs1 = DBUtils.executeQuery(strQuery);
								if(rs1.next())
								{
									permstatecode_val = Helper.correctNull((String)rs1.getString(1));
									
								}
							}
						}
					}
					hshResult.put("permcity_code_val",permcity_code_val);
					hshResult.put("permstatecode_val",permstatecode_val);
					bState=rs.next();
					if(citycodeval.equalsIgnoreCase(""))
							recordflag = "N";
					else
						recordflag = "Y";

				}
				if(rs!=null)
				{
					rs.close();
				}				 
				rs=DBUtils.executeLAPSQuery("per_employment_type^"+strApplicationNo);	
				if(rs.next())
				{
					hshResult.put("peremploy",correctNull(rs.getString(1)));
					//hshResult.put("perapp_istaff",correctNull(rs.getString("indinfo_is_staff")));
				}
			}
			HashMap prof=new HashMap();
			HashMap profile=new HashMap();
			prof.put("profile_id",strApplicationNo);
			profile=(HashMap)getCustomerProfileStatus(prof);
			hshResult.put("strIncompletepage", Helper.correctNull((String)profile.get("strIncompletepage")));
			String strProfilestatus="";
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("getprofilestatusfromdemographic^"+strApplicationNo);
			if(rs.next())
			{
				strProfilestatus=Helper.correctNull((String)rs.getString("perapp_profilestatus"));
			}
			hshResult.put("strProfilestatus",strProfilestatus);
			hshResult.put("recordflag",recordflag);
			hshResult.put("appstatus",strAppStatus);

		}
		catch(Exception e)
		{
			throw new EJBException("Error in getEmployer "+e.getMessage());	
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
		return hshResult;
	}

	/*	Function  updateEmployer This Method is used for inserting or updating  
	*	or inserting Employer details of  personal application form
	*	@param hshValues     
	*   @return HashMap		 
	*	@exception java.lang.Exception
	*/

	public HashMap updateEmployer(HashMap hshValues) 
	{
		HashMap hshQueryValues=new HashMap();		
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		HashMap hshResult=new HashMap();
		HashMap hshPasValues=new HashMap();
		String strApplicationNo=correctNull((String)hshValues.get("hidDemoId"));
		String EmpCheck=correctNull((String)hshValues.get("txtperemp_Designation"));
		String strapplnt="";
 		ResultSet rs = null;
 		String EmpCheck1="No";
 		String stroccup_code=""; 
 		String stroccup_code1="";
 		String strActionFlag = "N";
 		StringBuilder strActionData=new StringBuilder();
 		StringBuilder sbOldAudit = new StringBuilder();
		try
		{ 
			rs=DBUtils.executeLAPSQuery("sel_designationmasterDesc^"+EmpCheck);		 
			if(rs.next())
			{
				EmpCheck1="Yes";
				stroccup_code1=correctNull(rs.getString("DESIGN_CODE"));
			}
			if (!EmpCheck.equalsIgnoreCase(""))
			{
				if(EmpCheck1.equalsIgnoreCase("No"))
				{	
					rs=DBUtils.executeLAPSQuery("max_designationmaster");				 
					while(rs.next())
					{	
						stroccup_code = rs.getString("MAXID");
					}
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					arrValues.add(stroccup_code);
					arrValues.add(EmpCheck);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","ins_designationmaster");
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
			  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
			}
/**	by gokul - for the purpose of "Audit Trial" */
			if(rs!=null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("pergetEmployer^"+strApplicationNo);
			if(rs.next())
			{
				strActionFlag= "Y";
				
				String strConfEmpOldAudit=Helper.correctNull((String)hshValues.get("sel_confemp"));
				String strConfEmpDescOldAudit="";
				if(strConfEmpOldAudit.equalsIgnoreCase("1"))
				{
					strConfEmpDescOldAudit="Yes";
				}
				else if(strConfEmpOldAudit.equalsIgnoreCase("2"))
				{
					strConfEmpDescOldAudit="No";
				}
				String strListedEntityOldAudit=Helper.correctNull((String)hshValues.get("sel_listcom"));
				String strListedEntityDescOldAudit="";
				if(strListedEntityOldAudit.equalsIgnoreCase("1"))
				{
					strListedEntityDescOldAudit="Yes";
				}
				else if(strListedEntityOldAudit.equalsIgnoreCase("2"))
				{
					strListedEntityDescOldAudit="No";
				}
				String strDealWithUsOldAudit=Helper.correctNull((String)hshValues.get("sel_empdeal"));
				String strDealWithUsDescOldAudit="";
				if(strDealWithUsOldAudit.equalsIgnoreCase("1"))
				{
					strDealWithUsDescOldAudit="Yes";
				}
				else if(strDealWithUsOldAudit.equalsIgnoreCase("2"))
				{
					strDealWithUsDescOldAudit="No";
				}
				String strRegularSource=Helper.correctNull((String)hshValues.get("sel_empsource"));
				String strRegularSourceofInc="";
				if(strRegularSource.equalsIgnoreCase("1"))
				{
					strRegularSourceofInc="Yes";
				}
				else if(strRegularSource.equalsIgnoreCase("2"))
				{
					strRegularSourceofInc="No";
				}
				
				
				sbOldAudit.append("~Employer Name=").append(Helper.correctNull((String)rs.getString("peremp_name")))
				.append("~Address=").append(Helper.correctNull((String)rs.getString("peremp_address1"))).append(" ")
				.append(Helper.correctNull((String)rs.getString("peremp_address2")))
				.append("~Village / Taluk=").append(Helper.correctNull((String)rs.getString("peremp_address3")))
				.append("~City=").append(Helper.correctNull((String)rs.getString("peremp_city")))
				.append("~State=").append(Helper.correctNull((String)rs.getString("peremp_state")))
				.append("~Pin Code=").append(Helper.correctNull((String)rs.getString("peremp_zip")))
				.append("~Phone No.=").append(Helper.correctNull((String)rs.getString("peremp_phone")))
				.append("~FAX No.=").append(Helper.correctNull((String)rs.getString("peremp_fax")))
				.append("~Company E-mail=").append(Helper.correctNull((String)rs.getString("peremp_email")))
				.append("~Employee Id=").append(Helper.correctNull((String)rs.getString("peremp_empno")))
				.append("~Experience in years=").append(Helper.correctNull((String)rs.getString("peremp_expinyrs")))
				.append("~Designation=").append(Helper.correctNull((String)rs.getString("peremp_design")))
				.append("~Salary Receipt Date=").append(Helper.correctNull((String)rs.getString("peremp_receipt")))
				.append("~Department Name=").append(Helper.correctNull((String)rs.getString("peremp_department")))
				.append("~Date of Commencement=").append(Helper.correctNull((String)rs.getString("peremp_establish")))
				.append("~Retirement Date=").append(Helper.correctNull((String)rs.getString("peremp_retdate")))
				.append("~Years of service=").append(Helper.correctInt((String)rs.getString("peremp_servleft"))).append(" Years, ")
				.append(Helper.correctInt((String)rs.getString("peremp_servleftmon"))).append(" Months")
				.append("~Contact Person=").append(Helper.correctNull((String)rs.getString("peremp_contperson")))
				.append("~Whether a confirmed employee=").append(strConfEmpDescOldAudit)
				.append("~Whether an employee of listed entity=").append(strListedEntityDescOldAudit)
				.append("~Whether an employer is dealing with our bank=").append(strDealWithUsDescOldAudit)
				.append("~No of Years=").append(Helper.correctNull((String)rs.getString("peremp_noofyrs")))
				.append("~Whether Regular Source of Income=").append(strRegularSourceofInc);

			}
			if(rs!=null)
				rs.close();
/** end*/	String strAction=correctNull((String)hshValues.get("hidAction"));
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues=new HashMap();
				strapplnt = correctNull((String)hshValues.get("applnt"));
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","perdelEmployer");
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("update"))
			{
				hshQueryValues=new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();	
				strapplnt = correctNull((String)hshValues.get("applnt"));
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","perdelEmployer");
				hshQueryValues.put("1",hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(strApplicationNo);//1
				arrValues.add(correctNull((String)hshValues.get("txtperemp_name")));//2
				arrValues.add(correctNull((String)hshValues.get("txtperemp_address1")));//3
				arrValues.add(correctNull((String)hshValues.get("txtperemp_address2")));//4
				arrValues.add(correctNull((String)hshValues.get("txtperemp_address3")));//5
				arrValues.add(correctNull((String)hshValues.get("txtperemp_city")));//6
				arrValues.add(correctNull((String)hshValues.get("txtperemp_state")));//7
				arrValues.add(correctNull((String)hshValues.get("txtperemp_zip")));//8
				arrValues.add(correctNull((String)hshValues.get("txtperemp_phone")));//9
				arrValues.add(correctNull((String)hshValues.get("txtperemp_fax")));//10
				arrValues.add(correctNull((String)hshValues.get("txtperemp_email")));//11
				arrValues.add(Helper.correctNull((String)hshValues.get("txtperemp_Designation")));//12		
				arrValues.add(correctNull((String)hshValues.get("peremp_contperson")));//13
				if(correctNull((String)hshValues.get("txtperemp_yresemp")).equals(""))
				{
					arrValues.add("0.0");//14
				}
				else
				{
					arrValues.add(correctNull((String)hshValues.get("txtperemp_yresemp")));//14
				}
				arrValues.add(correctNull((String)hshValues.get("txtperemp_prevempname")));//15
				arrValues.add(correctNull((String)hshValues.get("hidsecCity")));//16
				arrValues.add(correctNull((String)hshValues.get("hidApp_type")));//17
				arrValues.add(correctNull((String)hshValues.get("txtperemp_retage")));//18
				arrValues.add(correctNull((String)hshValues.get("txtperemp_department")));//19
				
				arrValues.add(correctNull((String)hshValues.get("txtserviceleft")));//20
				arrValues.add(correctNull((String)hshValues.get("txtperemp_retdate")));//21
				arrValues.add(correctNull((String)hshValues.get("txt_empphoneextn")));//22
				arrValues.add(correctNull((String)hshValues.get("txtperemp_empno")));//23
				String occupationcode=correctNull((String)hshValues.get("selperemp_occupation"));
				arrValues.add(occupationcode);//24
				arrValues.add(correctNull((String)hshValues.get("txt_servicemonths")));//25
				arrValues.add(correctNull((String)hshValues.get("sel_category")));//26
				arrValues.add(correctNull((String)hshValues.get("txtperemp_noofemp")));//27
	//			added by Naresh
				arrValues.add(correctNull((String)hshValues.get("txtperemp_establish")));//28
				arrValues.add(correctNull((String)hshValues.get("txtperemp_experience")));//29
				arrValues.add(correctNull((String)hshValues.get("txtperemp_lease")));//30
				arrValues.add(correctNull((String)hshValues.get("txtperemp_receipt")));//31
				arrValues.add(correctNull((String)hshValues.get("txtperemp_country")));//32
				//added by s.sathya moorthy for business owned combo box
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_pre")));//33
				arrValues.add(Helper.correctNull((String)hshValues.get("txtperemp_licenseno")));//34
				arrValues.add(Helper.correctNull((String)hshValues.get("txtperemp_licensedate")));//35
				//end by Naresh
				//Added by prakash for KBL Functionality
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_expinyrs")));//36
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_confemp")));//37
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_listcom")));//38
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_empdeal")));//39
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_noofyears")));//40
				arrValues.add("Y");//41 To check whether the page is filled or not.
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_salrouted")));//40
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_empsource")));//41
				//End by prakash
				hshQueryValues.put("size","2");
				hshQuery.put("arrValues",arrValues);				
				hshQuery.put("strQueryId","perinsEmployer");
				hshQueryValues.put("2",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}


			
/** Start of Audit Trial */	
			String strCategory = "";
			String strOccupation = "";
			String strBusPrem = "";
			//Category
			if(correctNull((String)hshValues.get("sel_category")).trim().equalsIgnoreCase("1"))
				strCategory = "Executive /Senior Managerial";
			else if(correctNull((String)hshValues.get("sel_category")).trim().equalsIgnoreCase("2"))
				strCategory = "Managerial/ Officer(>2years) / Clerical";
			else if(correctNull((String)hshValues.get("sel_category")).trim().equalsIgnoreCase("3"))
				strCategory = "Junior(Officers > 2 years) / Clerical";
			else if(correctNull((String)hshValues.get("sel_category")).trim().equalsIgnoreCase("4"))
				strCategory = "Self Employed";
			else if(correctNull((String)hshValues.get("sel_category")).trim().equalsIgnoreCase("5"))
				strCategory = "Others";
			//Occupation	
			rs = DBUtils.executeLAPSQuery("sel_static_desc^"+"13^"+correctNull((String)hshValues.get("selperemp_occupation")));
			if(rs.next())
				strOccupation = correctNull((String)rs.getString("stat_data_desc1"));
			if(rs!=null)
				rs.close();
			//Business Premises
			if(correctNull((String)hshValues.get("sel_pre")).trim().equalsIgnoreCase("0"))
				strBusPrem = "Owned";
			else if(correctNull((String)hshValues.get("sel_pre")).trim().equalsIgnoreCase("1"))
				strBusPrem = "Rented";
			else if(correctNull((String)hshValues.get("sel_pre")).trim().equalsIgnoreCase("2"))
				strBusPrem = "Leased";
			else if(correctNull((String)hshValues.get("sel_pre")).trim().equalsIgnoreCase("3"))
				strBusPrem = "Not Applicable";
						
	/**  -----------------------------------  */

				

			hshQuery=new HashMap();
			arrValues=new ArrayList();
			//for Entering the values into auditrial
			/*String strActionData = "Company Name   ="+correctNull((String)hshValues.get("txtperemp_name"))+
			"~Address ="+correctNull((String)hshValues.get("txtperemp_address1"))+
						correctNull((String)hshValues.get("txtperemp_address2"))+
						correctNull((String)hshValues.get("txtperemp_address3"))+
			"~City ="+correctNull((String)hshValues.get("txtperemp_city"))+
			"~State="+correctNull((String)hshValues.get("txtperemp_state"))+
			"~Country ="+correctNull((String)hshValues.get("txtperemp_country"))+
			"~Phone No. ="+correctNull((String)hshValues.get("txtperemp_phone"))+
			"~Fax No. ="+correctNull((String)hshValues.get("txtperemp_fax"))+
			"~Company Email="+correctNull((String)hshValues.get("txtperemp_email"))+
			"~Pin Code="+correctNull((String)hshValues.get("txtperemp_zip"))+
			"~Employee Id="+correctNull((String)hshValues.get("txtperemp_empno"))+
			"~Category="+strCategory+
			//"~Occupation="+strOccupation+
			"~Designation ="+correctNull((String)hshValues.get("txtperemp_Designation"))+
			"~Department="+correctNull((String)hshValues.get("txtperemp_department"))+
			"~License No="+correctNull((String)hshValues.get("txtperemp_licenseno"))+
			"~License Date="+correctNull((String)hshValues.get("txtperemp_licensedate"))+
			"~Phone Extension="+correctNull((String)hshValues.get("txt_empphoneextn"))+
			"~Establishment Date="+correctNull((String)hshValues.get("txtperemp_establish"));
			if(Helper.correctNull((String)hshValues.get("hidempdet")).equals("9"))
			{
				strActionData=strActionData+"~Pension Receipt Date="+correctNull((String)hshValues.get("txtperemp_receipt"));
			}
			else
			{
				strActionData=strActionData+"~Salary Receipt Date="+correctNull((String)hshValues.get("txtperemp_receipt"));
			}
			strActionData=strActionData+"~Years in Business="+correctNull((String)hshValues.get("txtperemp_noofemp"))+
			"~Business premises="+strBusPrem+
			"~Lease period="+correctNull((String)hshValues.get("txtperemp_lease"))+
			"~Retirement Date="+correctNull((String)hshValues.get("txtperemp_retdate"))+
			"~Contact person="+correctNull((String)hshValues.get("peremp_contperson"))+
			"~Years of service left ="+correctNull((String)hshValues.get("txtserviceleft"))+"(years)"+
										correctNull((String)hshValues.get("txt_servicemonths"))+"(months)";*/
			//"~Name of previous employer="+correctNull((String)hshValues.get("txtperemp_prevempname"))+
			//"~City="+correctNull((String)hshValues.get("txtperemp_prevempcity"))
										
//T.A				"~Knowledge & Experience="+correctNull((String)hshValues.get("txtperemp_experience"))+			
			
			
			if(Helper.correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("Y"))
			{
				hshValues.put("hidAction","Update");
			}else if(Helper.correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("N")){
				hshValues.put("hidAction","Insert");
			}
			
			String strConfEmp=Helper.correctNull((String)hshValues.get("sel_confemp"));
			String strConfEmpDesc="";
			if(strConfEmp.equalsIgnoreCase("1"))
			{
				strConfEmpDesc="Yes";
			}
			else if(strConfEmp.equalsIgnoreCase("2"))
			{
				strConfEmpDesc="No";
			}
			String strListedEntity=Helper.correctNull((String)hshValues.get("sel_listcom"));
			String strListedEntityDesc="";
			if(strListedEntity.equalsIgnoreCase("1"))
			{
				strListedEntityDesc="Yes";
			}
			else if(strListedEntity.equalsIgnoreCase("2"))
			{
				strListedEntityDesc="No";
			}
			String strDealWithUs=Helper.correctNull((String)hshValues.get("sel_empdeal"));
			String strDealWithUsDesc="";
			if(strDealWithUs.equalsIgnoreCase("1"))
			{
				strDealWithUsDesc="Yes";
			}
			else if(strDealWithUs.equalsIgnoreCase("2"))
			{
				strDealWithUsDesc="No";
			}
			String strRegularSource1=Helper.correctNull((String)hshValues.get("sel_empsource"));
			String strRegularSourceofInc1="";
			if(strRegularSource1.equalsIgnoreCase("1"))
			{
				strRegularSourceofInc1="Yes";
			}
			else if(strRegularSource1.equalsIgnoreCase("2"))
			{
				strRegularSourceofInc1="No";
			}
			
			strActionData.append("~Employer Name=").append(Helper.correctNull((String)hshValues.get("txtperemp_name")))
			.append("~Address=").append(Helper.correctNull((String)hshValues.get("txtperemp_address1"))).append(" ")
			.append(Helper.correctNull((String)hshValues.get("txtperemp_address2")))
			.append("~Village / Taluk=").append(Helper.correctNull((String)hshValues.get("txtperemp_address3")))
			.append("~City=").append(Helper.correctNull((String)hshValues.get("txtperemp_city")))
			.append("~State=").append(Helper.correctNull((String)hshValues.get("txtperemp_state")))
			.append("~Pin Code=").append(Helper.correctNull((String)hshValues.get("txtperemp_zip")))
			.append("~Phone No.=").append(Helper.correctNull((String)hshValues.get("txtperemp_phone")))
			.append("~FAX No.=").append(Helper.correctNull((String)hshValues.get("txtperemp_fax")))
			.append("~Company E-mail=").append(Helper.correctNull((String)hshValues.get("txtperemp_email")))
			.append("~Employee Id=").append(Helper.correctNull((String)hshValues.get("txtperemp_empno")))
			.append("~Experience in years=").append(Helper.correctNull((String)hshValues.get("txt_expinyrs")))
			.append("~Designation=").append(Helper.correctNull((String)hshValues.get("txtperemp_Designation")))
			.append("~Salary Receipt Date=").append(Helper.correctNull((String)hshValues.get("txtperemp_receipt")))
			.append("~Department Name=").append(Helper.correctNull((String)hshValues.get("txtperemp_department")))
			.append("~Date of Commencement=").append(Helper.correctNull((String)hshValues.get("txtperemp_establish")))
			.append("~Retirement Date=").append(Helper.correctNull((String)hshValues.get("txtperemp_retdate")))
			.append("~Years of service=").append(Helper.correctInt((String)hshValues.get("txtserviceleft"))).append(" Years, ")
			.append(Helper.correctInt((String)hshValues.get("txt_servicemonths"))).append(" Months")
			.append("~Contact Person=").append(Helper.correctNull((String)hshValues.get("peremp_contperson")))
			.append("~Whether a confirmed employee=").append(strConfEmpDesc)
			.append("~Whether an employee of listed entity=").append(strListedEntityDesc)
			.append("~Whether an employer is dealing with our bank=").append(strDealWithUsDesc)
			.append("~No of Years=").append(Helper.correctNull((String)hshValues.get("txt_noofyears")))
			.append("~Whether Regular Source of Income=").append(strRegularSourceofInc1);

			
			AuditTrial.auditNewLog(hshValues, "208", strApplicationNo, strActionData.toString(), sbOldAudit.toString());
			/*hshQuery.put("strQueryId","audittrial");
			arrValues.add("32");
			arrValues.add(correctNull((String)hshValues.get("strUserId")));
			arrValues.add(correctNull((String)hshValues.get("strClientIP")));
			arrValues.add(strApplicationNo);
			arrValues.add(strActionData);
			

			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("3",hshQuery);
/** End of Audit trial */
			
			

			hshPasValues.put("hidDemoId",strApplicationNo);
			hshPasValues.put("applnt",strapplnt);
			
			if(EmpCheck1.equalsIgnoreCase("No"))
			{
				hshResult.put("txtperemp_Desigcode",stroccup_code);
				hshResult.put("txtperemp_Designation",EmpCheck);
			}
			else
			{
				hshResult.put("txtperemp_Desigcode",stroccup_code);
				hshResult.put("txtperemp_Designation",EmpCheck);
			}	
			hshResult=getEmployer(hshPasValues);
		}
		catch(Exception e)
		{
			throw new EJBException("Error in updateLoanProducts "+e.getMessage());	
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
		return hshResult;
	}

	public HashMap renewApplicantData(HashMap hshValues)
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		String strAppCode = "";
		HashMap hshRecord = new HashMap();
		ResultSet rs1=null;
		String strcbsid="0";
		HashMap hshval=new HashMap();
		String strQuery="";
		ResultSet rs=null;
		Connection connectDB	= null;
		CallableStatement callableStmt = null;
		String strNewFinID="";
		String strOldFinID="";
		try
		{
			strAppCode = getApplicantCode();
			String strOldAppId = Helper.correctNull((String)hshValues.get("hidOldAppId"));
			String OldAppId = Helper.correctNull((String)hshValues.get("OldAppId"));
			String strSno=Helper.correctNull((String)hshValues.get("selsno1"));
			String renewflag="";
			if(rs1!=null)
			{ rs1.close();}
			strQuery=SQLParser.getSqlQuery("Renewalflag^"+strOldAppId);//add query here
			rs1=DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				renewflag=Helper.correctNull((String)rs1.getString("perapp_renew"));
			}
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			arrValues.add(strAppCode);
			
			/*
			 * The following code is hided by prakash. Because KBL required that the customer should have the 
			 * same perapp_oldid though the customer is renewed n number of times.
			 */
			/*if(OldAppId.equalsIgnoreCase(""))
			{
				arrValues.add(strOldAppId);	
			}
			else
			{
				arrValues.add(OldAppId);	
			}*/
			arrValues.add("n");
			arrValues.add(Helper.correctNull((String)hshValues.get("strOrgShortCode")));
			arrValues.add(strOldAppId);		
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","perapplicantrenew");
			hshQueryValues.put("1",hshQuery);
			
			// update renew column in perapplicant table
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			arrValues.add("y");
			arrValues.add(strOldAppId);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","perapplicantupdaterenew");
			hshQueryValues.put("2",hshQuery);
			
			// update renew column in perapplicant table
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			arrValues.add(renewflag);
			arrValues.add(strAppCode);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","perapplicantupdaterenew");
			hshQueryValues.put("3",hshQuery);
						
						
			
			// insert data in to individual_info table
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			arrValues.add(strAppCode);
			arrValues.add(strOldAppId);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","individual_info_renew");
			hshQueryValues.put("4",hshQuery);
			
			// insert data in to company_info table
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			arrValues.add(strAppCode);
			arrValues.add(strOldAppId);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","company_info_renew");
			hshQueryValues.put("5",hshQuery);
			
			// insert data in to perincexpences table
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			arrValues.add(strAppCode);
			arrValues.add(strOldAppId);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","perincomerenew");
			hshQueryValues.put("6",hshQuery);
			
			// insert data in to peremployer table
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			arrValues.add(strAppCode);
			arrValues.add(strOldAppId);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","peremployerrenew");
			hshQueryValues.put("7",hshQuery);
			
			arrValues=new ArrayList();
			hshQuery=new HashMap();			
			arrValues.add(strOldAppId);
			arrValues.add(strAppCode);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","ins_perapplicant_idmap");
			hshQueryValues.put("8",hshQuery);
			
			// insert data in to KYC norms table
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			arrValues.add(strAppCode);
			arrValues.add(strOldAppId);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","kycnormsrenew");
			hshQueryValues.put("9",hshQuery);
			
			// insert data in to Communication Details table
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			arrValues.add(strAppCode);
			arrValues.add(strOldAppId);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","percomaddressrenew");
			hshQueryValues.put("10",hshQuery);
			
			// insert data in to Customer Rating table
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			arrValues.add(strAppCode);
			arrValues.add(strOldAppId);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","percusratingrenew");
			hshQueryValues.put("11",hshQuery);
			
			// insert data in to Customer Cibil Details Details table
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			arrValues.add(strAppCode);
			arrValues.add(strOldAppId);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","percuscibilrenew");
			hshQueryValues.put("12",hshQuery);
			
			// insert data in to Customer Defaulter Details table
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			arrValues.add(strAppCode);
			arrValues.add(strOldAppId);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","percusdefaultrenew");
			hshQueryValues.put("13",hshQuery);
			
			//insert for Other bank details by rajesh on 07/02/2014
			/*arrValues=new ArrayList();
			hshQuery=new HashMap();
			arrValues.add(strAppCode);
			arrValues.add(strOldAppId);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","perotherbankrenew");
			hshQueryValues.put("13",hshQuery);*/
			
			
			// Applicant New id updated to per_demographics table
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			arrValues.add(strAppCode);
			arrValues.add(strOldAppId);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","perdemographicsrenew");
			hshQueryValues.put("14",hshQuery);
			
			
			// Applicant New id updated to com_demographics table
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			arrValues.add(strAppCode);
			arrValues.add(strOldAppId);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","comdemographicsrenew");
			hshQueryValues.put("15",hshQuery);
			
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			arrValues.add(strAppCode);
			arrValues.add(strOldAppId);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","agrlandholdingsrenew");
			hshQueryValues.put("16",hshQuery);
			
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			arrValues.add(strAppCode);
			arrValues.add(strOldAppId);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","comcompanydetailsrenew");
			hshQueryValues.put("17",hshQuery);
			
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			arrValues.add(strAppCode);
			arrValues.add(strOldAppId);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","updatecusgroupsmembersrenew");
			hshQueryValues.put("18",hshQuery);
			
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			arrValues.add(strAppCode);
			arrValues.add(strOldAppId);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","divisiondetailsrenew");
			hshQueryValues.put("19",hshQuery);
			
//			arrValues=new ArrayList();
//			hshQuery=new HashMap();
//			arrValues.add(strAppCode);
//			arrValues.add(strOldAppId);
//			hshQuery.put("arrValues",arrValues);
//			hshQuery.put("strQueryId","comapp_division_id_update");
//			hshQueryValues.put("19",hshQuery);
			
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			arrValues.add(strAppCode);
			arrValues.add(strOldAppId);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","renew_agrappshg");
			hshQueryValues.put("20",hshQuery);
			
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			arrValues.add(strAppCode);
			arrValues.add(strOldAppId);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","renew_agrappshg_member");
			hshQueryValues.put("21",hshQuery);
			
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			arrValues.add(strAppCode);
			arrValues.add(strOldAppId);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","renew_agrappshg_addtnlinfo");
			hshQueryValues.put("22",hshQuery);
			
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			arrValues.add(strAppCode);
			arrValues.add(strOldAppId);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","percusratingnewrenew");
			hshQueryValues.put("23",hshQuery);
			
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			arrValues.add(strAppCode);
			arrValues.add(strOldAppId);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","upd_solvency_idrenew");
			hshQueryValues.put("24",hshQuery);
			
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			arrValues.add(strAppCode);
			arrValues.add(strOldAppId);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","upd_kpower_idrenew");
			hshQueryValues.put("25",hshQuery);
			
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			arrValues.add(strAppCode);
			arrValues.add(strOldAppId);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","renew_com_Financialparticulars");
			hshQueryValues.put("26",hshQuery);
			
			
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			arrValues.add(strAppCode);//0
			hshQuery.put("strQueryId","comapp_division_id_update");
			
			if(rs1!=null)
			{ rs1.close();}
			strQuery=SQLParser.getSqlQuery("sel_customerdetail^"+strOldAppId);//add query here
			rs1=DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				arrValues.add(correctNull(rs1.getString("PERAPP_FNAME")));//1
				if(Helper.correctNull(rs1.getString("INDINFO_RESIDENT_STATUS")).equalsIgnoreCase("Y"))
				{
					arrValues.add(correctNull(rs1.getString("CON_PERMADDR1"))+ " "+correctNull(rs1.getString("CON_PERMADDR2"))+ " "+correctNull(rs1.getString("CON_PERMVILLAGE")));//2
					arrValues.add(correctNull(rs1.getString("CON_PERMCITY")));//3
					arrValues.add(correctNull(rs1.getString("CON_PERMDIST")));//4
					arrValues.add(correctNull(rs1.getString("CON_PERMSTATE")));//5
					arrValues.add(correctNull(rs1.getString("CON_PERMZIP")));//6
					arrValues.add(correctNull(rs1.getString("CON_PERMPHONE")));//7
					arrValues.add(correctNull(rs1.getString("CON_PERMFAX")));//8
				}
				else
				{
					arrValues.add(correctNull(rs1.getString("CON_COMADDR1"))+ " "+correctNull(rs1.getString("CON_COMADDR2"))+ " "+correctNull(rs1.getString("CON_COMVILLAGE")));//2
					arrValues.add(correctNull(rs1.getString("CON_COMCITY")));//3
					arrValues.add(correctNull(rs1.getString("CON_COMDIST")));//4
					arrValues.add(correctNull(rs1.getString("CON_COMSTATE")));//5
					arrValues.add(correctNull(rs1.getString("CON_COMZIP")));//6
					arrValues.add(correctNull(rs1.getString("CON_COMPHONE")));//7
					arrValues.add(correctNull(rs1.getString("CON_COMFAX")));//8
				}
			}
			else
			{
				arrValues.add("");//1
				arrValues.add("");//2
				arrValues.add("");//3
				arrValues.add("");//4
				arrValues.add("");//5
				arrValues.add("");//6
				arrValues.add("");//7
				arrValues.add("");//8
			}
			arrValues.add(strOldAppId);//9
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("27",hshQuery);
			
			
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			arrValues.add(strAppCode);
			arrValues.add(strOldAppId);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","renew_com_charge_assets");
			hshQueryValues.put("28",hshQuery);
			
			//svandidhi tab
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			arrValues.add(strAppCode);
			arrValues.add(strOldAppId);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","ins_svanidhidetails_renew");
			hshQueryValues.put("29",hshQuery);
			
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			arrValues.add(strAppCode);
			arrValues.add(strOldAppId);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","ins_per_familyDetails_renew");
			hshQueryValues.put("30",hshQuery);
						
			hshQueryValues.put("size","30");
			
			
			
			arrValues=new ArrayList();
			hshQuery=new HashMap();
			arrValues.add(strAppCode);
			arrValues.add(strOldAppId);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","upd_bankercertificate_idrenew");
			hshQueryValues.put("31",hshQuery);
			
			hshQueryValues.put("size","31");
						
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
			
			//For inserting in Finacial(corp_fin_year table,com_finance,COM_FINAPPVALUES)
			
			strQuery=SQLParser.getSqlQuery("selfinancerenew^"+strOldAppId);
			if(rs != null)rs.close();
			rs=DBUtils.executeQuery(strQuery);
		    while(rs.next())
			{
				strOldFinID=(Helper.correctNull(rs.getString("fin_financeid")));
			if(!strOldFinID.equals(""))
			{
			
				strQuery=SQLParser.getSqlQuery("maxfinanceid");
				if(rs1 != null)rs1.close();
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					strNewFinID=(Helper.correctNull(rs1.getString("fin_financeid")));
				}
				
				
			connectDB = ConnectionFactory.getConnection();
			callableStmt=connectDB.prepareCall("call PROC_FIN_CUSTRENEW(?,?,?)");
			callableStmt.setString(1,correctNull(strNewFinID));
			callableStmt.setString(2,correctNull(strOldFinID));
			callableStmt.setString(3,correctNull(strAppCode));
			callableStmt.execute();
			callableStmt.clearParameters();
			
			connectDB.close();
			
			}
			}
			/*rs1=DBUtils.executeLAPSQuery("getprofilestatusfromdemographic^"+strOldAppId);
			if(rs1.next())
			{
				strcbsid=Helper.correctNull((String)rs1.getString("perapp_cbsid"));
			}
			hshval.put("custid",strcbsid);
			hshval.put("strLapscustid",strAppCode);
			hshval.put("strCustomer","existing");
			hshRecord=(HashMap)EJBInvoker.executeStateLess("cbsinterface",hshval,"getCbsApplicantData");*/
			
 //========================================= Branch Counting================================================ 
		 rs = null;
			String OldAppidBrCode = "";
			String maxBranchCount = "";
			
		strQuery=SQLParser.getSqlQuery("sel_branchcode^"+strOldAppId);
			rs=DBUtils.executeQuery(strQuery);	
			if(rs.next())
			{
				OldAppidBrCode = Helper.correctNull((String)rs.getString("perapp_branchcode")); 
			}
			
			if(OldAppidBrCode.equalsIgnoreCase(Helper.correctNull((String)hshValues.get("strOrgShortCode"))))
			{
		
				strQuery=SQLParser.getSqlQuery("sel_branchcount^"+strOldAppId+"^"+Helper.correctNull((String)hshValues.get("strOrgShortCode")));
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					maxBranchCount = Helper.correctNull((String)rs.getString(1)); 
				}
				
			
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				hshQueryValues = new HashMap();
				arrValues.add(maxBranchCount);
				arrValues.add(strAppCode);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","updBranchCount");
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				
			}
			else
			{
				
				strQuery=SQLParser.getSqlQuery("sel_exiBranchcount^"+strOldAppId+"^"+Helper.correctNull((String)hshValues.get("strOrgShortCode")));
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					maxBranchCount = Helper.correctNull((String)rs.getString(1)); 
				}
				
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				hshQueryValues = new HashMap();
				arrValues.add(maxBranchCount);
				arrValues.add(strAppCode);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","updBranchCount");
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
			}
			
			
			
			hshRecord.put("hidDemoId",strAppCode);
			hshRecord.put("hidAppType","");
			//hshRecord = getDemographics(hshRecord);
			
			//added to update profile status flag
			HashMap prof=new HashMap();
			HashMap profile=new HashMap();
			prof.put("profile_id",strAppCode);
			profile=(HashMap)getCustomerProfileStatus(prof);
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in updateData "+ce.toString());
		}
		return hshRecord;
	}

	public String getApplicantCode() throws Exception
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
	
	public HashMap getCodeList(HashMap hshRequestValues) 
	{ 
		String scode="";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();		
		ArrayList vecRec = new ArrayList();

		try
		{ 
			scode=Helper.correctNull((String)hshRequestValues.get("scode"));
			if(scode.equals(""))
			{
				rs=DBUtils.executeLAPSQuery("setcodelist");
			}
			hshRecord = new HashMap();
			while(rs.next())
			{
				vecRec = new ArrayList();
				vecRec.add(correctNull(rs.getString(1)));
				vecRec.add(correctNull(rs.getString(2)));
				vecData.add(vecRec);
			}
			hshRecord.put("vecData",vecData);	
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getCodeList "+ce.toString());
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
		HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();		
		ArrayList vecRec = new ArrayList();

		try
		{ 
			scode=Helper.correctNull((String)hshRequestValues.get("scode"));
			if(scode.equals(""))
			{
				rs=DBUtils.executeLAPSQuery("setorglist");
			}
			else
			{
				rs=DBUtils.executeLAPSQuery("setorglistcode");
			}
			hshRecord = new HashMap();
			while(rs.next())
			{
				vecRec = new ArrayList();
				vecRec.add(correctNull(rs.getString(1)));
				vecRec.add(correctNull(rs.getString(2)));
				vecData.add(vecRec);
			}
			hshRecord.put("vecData",vecData);	
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
	
	public HashMap getAppList(HashMap hshRequestValues) 
	{ 
		String scode="";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();		
		ArrayList vecRec = new ArrayList();

		try
		{ 
			scode = Helper.correctNull((String)hshRequestValues.get("org_code"));
			String orgcode =scode.substring(0,6);
			rs=DBUtils.executeLAPSQuery("setapplist^"+orgcode);
			 
			hshRecord = new HashMap();
			while(rs.next())
			{
				vecRec = new ArrayList();
				vecRec.add(correctNull(rs.getString(1)));
				vecRec.add(correctNull(rs.getString(2)));
				vecRec.add(correctNull(rs.getString(3)));
				vecData.add(vecRec);
			}
			hshRecord.put("vecData",vecData);	
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getAppList "+ce.toString());
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
	
//	public HashMap getReports(HashMap hshValues) 
//	{
//		String strQuery="";
//		ResultSet rs=null; 
//		String strhidApptype=correctNull((String)hshValues.get("hidAppType"));
//		ArrayList vecRec=new ArrayList();
//		ArrayList vecData=new ArrayList();
//		HashMap hshRecord = new HashMap();
//		String desc1 = "", desc2 = "";
//		String org_code="";
//		long a=0;
//		try
//		{	
//			String branchorg_code = Helper.correctNull((String)hshValues.get("txtperapp_appcode"));
//			String org_code1=Helper.correctNull((String)hshValues.get("txtperapp_branchcode"));
//			String rhname=Helper.correctNull((String)hshValues.get("hidtxtperapp_branch")); 
//			String brname=Helper.correctNull((String)hshValues.get("hidtxtperapp_app"));
//			if(!org_code1.equalsIgnoreCase(""))
//			{
//				org_code=org_code1.substring(0,6);
//			}			
//			String fromdate=Helper.correctNull((String)hshValues.get("fromdate"));
//			String todate=Helper.correctNull((String)hshValues.get("todate"));
//			if(strhidApptype.equalsIgnoreCase(""))
//			{ 
//				if(!org_code1.equalsIgnoreCase("") && branchorg_code.equalsIgnoreCase(""))
//				{
//					//desc1 =" and app_history.org_code like '"+org_code+"%'";
//					strQuery= SQLParser.getSqlQuery("mastgetreports1^"+fromdate+"^"+todate+"^"+desc1);
//					rs=DBUtils.executeQuery(strQuery);
//				}
//				else 
//				{
//					//desc2 =" and app_history.org_code = '"+branchorg_code+"' ";
//					strQuery= SQLParser.getSqlQuery("mastgetreports1^"+fromdate+"^"+todate+"^"+desc2);
//					rs=DBUtils.executeQuery(strQuery);
//				}
//				while(rs.next())
//				{
//					vecRec = new ArrayList();
//					vecRec.add(correctNull(rs.getString(1))); 
//					vecRec.add(correctNull(rs.getString(2)));
//					vecRec.add(correctNull(rs.getString(3)));
//					vecRec.add(correctNull(rs.getString(4)));
//					vecRec.add(correctNull(rs.getString(5)));
//					vecRec.add(correctNull(rs.getString(6)));
//					vecRec.add(correctNull(rs.getString(7)));
//					vecRec.add(correctNull(rs.getString(8)));
//					vecRec.add(correctNull(rs.getString(9)));
//					vecRec.add(correctNull(rs.getString(10)));
//					vecRec.add(correctNull(rs.getString(11)));
//					vecRec.add(correctNull(rs.getString(12)));
//					vecRec.add(correctNull(rs.getString(13)));
//					vecRec.add(correctNull(rs.getString(14)));
//					vecRec.add(correctNull(rs.getString(15)));
//					vecRec.add(correctNull(rs.getString(16)));
//					vecRec.add(correctNull(rs.getString(17)));
//					vecRec.add(correctNull(rs.getString(18)));					
//					vecRec.add(correctNull(rs.getString(19)));
//					vecRec.add(correctNull(rs.getString(20)));
//					vecRec.add(correctNull(rs.getString(21)));
//					vecRec.add(correctNull(rs.getString(22)));
//					vecData.add(vecRec);
//					a++;
//				}
//				if(a==0)
//				{
//					hshRecord.put("nodatafound","nodatafound");
//				}
//				hshRecord.put("vecData",vecData);	
//				hshRecord.put("rhname",rhname);
//				hshRecord.put("brname",brname);
//				hshRecord.put("fromdate",fromdate);
//				hshRecord.put("todate",todate);
//			}			    
//		}
//		catch(Exception e)
//		{
//			throw new EJBException("Error in getReports "+e.getMessage());		
//		}
//		finally
//		{
//			try
//			{
//				if(rs!=null)
//				{
//					rs.close();
//				} 
//			}
//			catch(Exception e)
//			{
//				throw new EJBException("Error in closing Connection "+e.getMessage());
//			}
//		}
//		return hshRecord;
//	}

	/*public HashMap getglobalparametersdata(HashMap hshValues)  
	{ 
		ResultSet rs = null;	
		HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();	
		ArrayList vecRec  = new ArrayList();	
		try 
		{ 
			rs=DBUtils.executeLAPSQuery("Sel_Globalparameters");			 
			while (rs.next()) 
			{
				vecRec = new ArrayList();
				vecRec.add(correctNull(rs.getString("app_no")));
				vecRec.add(correctNull(rs.getString("serialNo")));
				vecRec.add(correctNull(rs.getString("ques_flag")));
				vecRec.add(correctNull(rs.getString("remarks")));
				vecData.add(vecRec);
			}
			hshRecord.put("vecData", vecData);			
		} 
		catch (Exception e) 
		{
			throw new EJBException(e.getMessage());
		} 
		finally 
		{
			try 
			{
				if (rs != null) 
				{
					rs.close();
					 
				}
			} 
			catch (Exception cf) 
			{
				throw new EJBException("Error closing the connection"+ cf.getMessage());
			}
		}
		return hshRecord;
	}*/
	
	/*public HashMap updateglobalparameters(HashMap hshValues)  
	{
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues=new HashMap();
		ArrayList arrValues = new ArrayList();		 
		ResultSet rs = null;
		String strApplicationNo=correctNull((String)hshValues.get("hidDemoId"));
		String strQuest=correctNull((String)hshValues.get("hidDemoId1"));
		try 
		{ 
			arrValues.add(strApplicationNo);
			arrValues.add(strQuest);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","Upd_glopalparameters");
			hshQueryValues.put("1",hshQuery);			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");			
			hshQueryValues = getglobalparametersdata(hshQueryValues);
		} 
		catch (Exception e) 
		{
			Logger.log("in bean" + e);
		}
		finally 
		{
			try 
			{
				if (rs != null) 
				{
					rs.close();
				} 
			} 
			catch (Exception cf) 
			{
				throw new EJBException("Error closing the connection "+ cf.getMessage());
			}
		}
		return  hshQueryValues;
	}*/

	/*public HashMap getEmployerMedic(HashMap hshValues)  
	{ 
		ResultSet rs = null;
		HashMap hshRecord = null;
		
		try
		{ 
			String appno=correctNull((String)hshValues.get("hidDemoId"));			
			rs=DBUtils.executeLAPSQuery("selincexpmedic^"+appno);			 
			hshRecord = new HashMap();
			while (rs.next())
			{
				if(correctNull(rs.getString("col_no")).trim().equals("1"))
				{
					hshRecord.put("appno",correctNull(rs.getString("app_no")));
					hshRecord.put("pincome1",correctNull(rs.getString("sales_turnover")));
					hshRecord.put("pexpen1",correctNull(rs.getString("exports_any")));
					hshRecord.put("paidup1",correctNull(rs.getString("purchase_price")));
					hshRecord.put("netw1",correctNull(rs.getString("gross_profit")));
					hshRecord.put("curr1",correctNull(rs.getString("net_profit")));
					hshRecord.put("tol1",correctNull(rs.getString("capital")));
					hshRecord.put("cov1",correctNull(rs.getString("reserves")));
					hshRecord.put("pyear1",correctNull(rs.getString("projection_year")));
				}
				if(correctNull(rs.getString("col_no")).trim().equals("2"))
				{
					hshRecord.put("appno",correctNull(rs.getString("app_no")));
					hshRecord.put("pincome2",correctNull(rs.getString("sales_turnover")));
					hshRecord.put("pexpen2",correctNull(rs.getString("exports_any")));
					hshRecord.put("paidup2",correctNull(rs.getString("purchase_price")));
					hshRecord.put("netw2",correctNull(rs.getString("gross_profit")));
					hshRecord.put("curr2",correctNull(rs.getString("net_profit")));
					hshRecord.put("tol2",correctNull(rs.getString("capital")));
					hshRecord.put("cov2",correctNull(rs.getString("reserves")));
					hshRecord.put("pyear2",correctNull(rs.getString("projection_year")));
				}			
				if(correctNull(rs.getString("col_no")).trim().equals("3"))
				{
					hshRecord.put("appno",correctNull(rs.getString("app_no")));
					hshRecord.put("pincome3",correctNull(rs.getString("sales_turnover")));
					hshRecord.put("pexpen3",correctNull(rs.getString("exports_any")));
					hshRecord.put("paidup3",correctNull(rs.getString("purchase_price")));
					hshRecord.put("netw3",correctNull(rs.getString("gross_profit")));
					hshRecord.put("curr3",correctNull(rs.getString("net_profit")));
					hshRecord.put("tol3",correctNull(rs.getString("capital")));
					hshRecord.put("cov3",correctNull(rs.getString("reserves")));
					hshRecord.put("pyear3",correctNull(rs.getString("projection_year")));
				}
				if(correctNull(rs.getString("col_no")).trim().equals("4"))
				{
					hshRecord.put("appno",correctNull(rs.getString("app_no")));
					hshRecord.put("pincome4",correctNull(rs.getString("sales_turnover")));
					hshRecord.put("pexpen4",correctNull(rs.getString("exports_any")));
					hshRecord.put("paidup4",correctNull(rs.getString("purchase_price")));
					hshRecord.put("netw4",correctNull(rs.getString("gross_profit")));
					hshRecord.put("curr4",correctNull(rs.getString("net_profit")));
					hshRecord.put("tol4",correctNull(rs.getString("capital")));
					hshRecord.put("cov4",correctNull(rs.getString("reserves")));
					hshRecord.put("pyear4",correctNull(rs.getString("projection_year")));
				}
				if(correctNull(rs.getString("col_no")).trim().equals("5"))
				{
					hshRecord.put("appno",correctNull(rs.getString("app_no")));
					hshRecord.put("pincome5",correctNull(rs.getString("sales_turnover")));
					hshRecord.put("pexpen5",correctNull(rs.getString("exports_any")));
					hshRecord.put("paidup5",correctNull(rs.getString("purchase_price")));
					hshRecord.put("netw5",correctNull(rs.getString("gross_profit")));
					hshRecord.put("curr5",correctNull(rs.getString("net_profit")));
					hshRecord.put("tol5",correctNull(rs.getString("capital")));
					hshRecord.put("cov5",correctNull(rs.getString("reserves")));
					hshRecord.put("pyear5",correctNull(rs.getString("projection_year")));
				}
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getDataeduparticulars "+ce.toString());
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
	}*/

	/*public HashMap updateEmployerMedic(HashMap hshValues) 	
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery ;
		ArrayList arrValues= new ArrayList();
		ResultSet rs=null;
		String val="";
		String appno="";
		String strCurrentDate1="";
		String strCurrentYear="";
				
		try
		{
			strCurrentDate1=Helper.getCurrentDateTime();
			strCurrentYear=strCurrentDate1.substring(6,10);
			int strNextYear=0;
			int strPreviousYear=0;
			int strNextPreviousYear=0;
			int strNNextPreviousYear=0;
			strNextYear=Integer.parseInt(strCurrentYear)+1;
			strPreviousYear=Integer.parseInt(strCurrentYear)-1;
			strNextPreviousYear=Integer.parseInt(strCurrentYear)-2;
			strNNextPreviousYear=Integer.parseInt(strCurrentYear)-3;
			 
			val=(String)hshValues.get("hidAction");
			appno=correctNull((String)hshValues.get("hidDemoId"));
			if (val.equals("delete"))	
			{					
				hshQueryValues.put("size","1");
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","delincexpmedic");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
			}
			if (val.equals("update"))
			{
				hshQueryValues.put("size","6");
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","delincexpmedic");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQuery=new HashMap();									
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","insincexpmedic");
				arrValues.add(appno);
				arrValues.add("1");
				arrValues.add(correctNull((String)hshValues.get("pincome1")));
				arrValues.add(correctNull((String)hshValues.get("pexpen1")));
				arrValues.add(correctNull((String)hshValues.get("paidup1")));
				arrValues.add(correctNull((String)hshValues.get("netw1")));
				arrValues.add(correctNull((String)hshValues.get("curr1")));
				arrValues.add(correctNull((String)hshValues.get("tol1")));
				arrValues.add(correctNull((String)hshValues.get("cov1")));
				arrValues.add(String.valueOf(strNNextPreviousYear));						
						
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);
				hshQuery=new HashMap();
				arrValues=new ArrayList();	
				hshQuery.put("strQueryId","insincexpmedic");
				arrValues.add(appno);
				arrValues.add("2");
				arrValues.add(correctNull((String)hshValues.get("pincome2")));
				arrValues.add(correctNull((String)hshValues.get("pexpen2")));
				arrValues.add(correctNull((String)hshValues.get("paidup2")));
				arrValues.add(correctNull((String)hshValues.get("netw2")));
				arrValues.add(correctNull((String)hshValues.get("curr2")));
				arrValues.add(correctNull((String)hshValues.get("tol2")));
				arrValues.add(correctNull((String)hshValues.get("cov2")));
				arrValues.add(String.valueOf(strNextPreviousYear));
						
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("3",hshQuery);				
				hshQuery=new HashMap();
				arrValues=new ArrayList();	
				hshQuery.put("strQueryId","insincexpmedic");
				arrValues.add(appno);
				arrValues.add("3");
				arrValues.add(correctNull((String)hshValues.get("pincome3")));
				arrValues.add(correctNull((String)hshValues.get("pexpen3")));
				arrValues.add(correctNull((String)hshValues.get("paidup3")));
				arrValues.add(correctNull((String)hshValues.get("netw3")));
				arrValues.add(correctNull((String)hshValues.get("curr3")));
				arrValues.add(correctNull((String)hshValues.get("tol3")));
				arrValues.add(correctNull((String)hshValues.get("cov3")));
				arrValues.add(String.valueOf(strPreviousYear));				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("4",hshQuery);
			
				hshQuery=new HashMap();
				arrValues=new ArrayList();	
				hshQuery.put("strQueryId","insincexpmedic");
				arrValues.add(appno);
				arrValues.add("4");
				arrValues.add(correctNull((String)hshValues.get("pincome4")));
				arrValues.add(correctNull((String)hshValues.get("pexpen4")));
				arrValues.add(correctNull((String)hshValues.get("paidup4")));
				arrValues.add(correctNull((String)hshValues.get("netw4")));
				arrValues.add(correctNull((String)hshValues.get("curr4")));
				arrValues.add(correctNull((String)hshValues.get("tol4")));
				arrValues.add(correctNull((String)hshValues.get("cov4")));
				arrValues.add(String.valueOf(strCurrentYear));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("5",hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();	
				hshQuery.put("strQueryId","insincexpmedic");
				arrValues.add(appno);
				arrValues.add("5");
				arrValues.add(correctNull((String)hshValues.get("pincome5")));
				arrValues.add(correctNull((String)hshValues.get("pexpen5")));
				arrValues.add(correctNull((String)hshValues.get("paidup5")));
				arrValues.add(correctNull((String)hshValues.get("netw5")));
				arrValues.add(correctNull((String)hshValues.get("curr5")));
				arrValues.add(correctNull((String)hshValues.get("tol5")));
				arrValues.add(correctNull((String)hshValues.get("cov5")));
				arrValues.add(String.valueOf(strNextYear));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("6",hshQuery);
			}
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		catch (Exception e)
		{
			Logger.log("in bean"+e);
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
		return hshQueryValues;	
	}*/
	
	/*public  HashMap getFinProfitData(HashMap hshValues) 
	{ 
		ResultSet rs=null;		
		try
		{ 
			String strid="";
			strid="";
			String strAppno = Helper.correctNull((String)hshValues.get("appno1"));
			if(strid.equalsIgnoreCase(""))
			{
				strid = Helper.correctNull((String)hshValues.get("comappid"));
			}
			rs=DBUtils.executeLAPSQuery("sel_finProfitdet^"+strid);
			 
			ArrayList vecRow = new ArrayList();
			ArrayList vecCol = new ArrayList();
			while(rs.next())
			{
				vecRow = new ArrayList();
				vecRow.add(Helper.correctNull((String)rs.getString("year1")));
				vecRow.add(Helper.correctNull((String)rs.getString("year2")));
				vecRow.add(Helper.correctNull((String)rs.getString("year3")));
				vecRow.add(Helper.correctNull((String)rs.getString("year4")));
				vecRow.add(Helper.correctNull((String)rs.getString("year5")));
				vecRow.add(Helper.correctNull((String)rs.getString("year6")));
				vecCol.add(vecRow);
			}
			hshValues.put("vecCol",vecCol);
			hshValues.put("appno", strAppno);
		}
		catch (Exception e)
		{
			Logger.log("in bean"+e);
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
		return hshValues;			
	}*/
	
	/*public  HashMap getFinData(HashMap hshValues) 
	{ 
		ResultSet rs=null;	
		try
		{ 
			String strid="";
			strid=Helper.correctNull((String)hshValues.get("hidDemoId"));			
			 rs=DBUtils.executeLAPSQuery("sel_findet^"+strid);			 
			ArrayList vecRow = new ArrayList();
			ArrayList vecCol = new ArrayList();
			while(rs.next())
			{
				vecRow = new ArrayList();
				vecRow.add(Helper.correctNull((String)rs.getString("year1")));
				vecRow.add(Helper.correctNull((String)rs.getString("year2")));
				vecRow.add(Helper.correctNull((String)rs.getString("year3")));
				vecRow.add(Helper.correctNull((String)rs.getString("Sno")));
				vecCol.add(vecRow);
			}
			hshValues.put("vecCol",vecCol);
			strid=Helper.correctNull((String)hshValues.get("hidDemoId"));
			rs=DBUtils.executeLAPSQuery("sel_fin^"+strid);
			 
			ArrayList vecRow1 = new ArrayList();
			ArrayList vecCol1 = new ArrayList();
			while(rs.next())
			{
				vecRow1 = new ArrayList();
				vecRow1.add(Helper.correctNull((String)rs.getString("fin_year")));
				vecRow1.add(Helper.correctNull((String)rs.getString("fin_type")));
				vecCol1.add(vecRow1);
			}
			hshValues.put("vecCol1",vecCol1);
			hshValues.put("strid",strid);
		}
		catch (Exception e)
		{
			Logger.log("in bean"+e);
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
		return hshValues;			
	}*/
	
	/*public void updateFinProfitData(HashMap hshRequestValues) 
	{
		HashMap hshQuery = new HashMap();
		ArrayList arr = new ArrayList();
		HashMap hshqueryval = new HashMap();		 
		ResultSet rs = null;
		String appid="";
		
		try
		{
			appid="";
			if(appid.equalsIgnoreCase(""))
			{
				appid = Helper.correctNull((String)hshRequestValues.get("comappid"));
			} 
			String year1[];
			String year2[];
			String year3[];
			String year4[];
			String year5[];
			String year6[];
			year1= (String [])hshRequestValues.get("txt_year1");
			year2= (String [])hshRequestValues.get("txt_year2");
			year3 = (String [])hshRequestValues.get("txt_year3");
			year4= (String [])hshRequestValues.get("txt_year4");
			year5= (String [])hshRequestValues.get("txt_year5");
			year6= (String [])hshRequestValues.get("txt_year6");
						
			if(!appid.equalsIgnoreCase(""))
			{
				arr = new ArrayList();
				hshQuery.put("strQueryId","del_finprofitdet");
				arr.add(appid);
				hshQuery.put("arrValues",arr);
				hshqueryval.put("size","1");	
				hshqueryval.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			if(!appid.equalsIgnoreCase(""))
			{
				int count =0;
				String Sno;
				for(int k=0;k<11;k++)
				{	
					arr=new ArrayList();
					count = k;					
					hshQuery.put("strQueryId","ins_finprofitdet");
					arr.add(appid);
					Sno = String.valueOf(count);
					arr.add(Sno);
					if(year1[k]=="")
					{
						arr.add("0");
					}
					else
					{
						arr.add(Helper.correctNull(year1[k]));
					}
					if(year2[k]=="")
					{
						arr.add("0");
					}
					else
					{
						arr.add(Helper.correctNull(year2[k]));
					}
					if(year3[k]=="")
					{
						arr.add("0");
					}
					else
					{
						arr.add(Helper.correctNull(year3[k]));
					}
					if(year4[k]=="")
					{
						arr.add("0");
					}
					else
					{
						arr.add(Helper.correctNull(year4[k]));
					}
					if(year5[k]=="")
					{
						arr.add("0");
					}
					else
					{
						arr.add(Helper.correctNull(year5[k]));
					}
					if(year6[k]=="")
					{
						arr.add("0");
					}
					else
					{
						arr.add(Helper.correctNull(year6[k]));
					}				
					hshQuery.put("arrValues",arr);
					hshqueryval.put("size","1");
					hshqueryval.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
				}
			}
		}			
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
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
	}*/
	
	/*public void updateFinData(HashMap hshRequestValues) 
	{
		HashMap hshQuery = new HashMap();
		ArrayList arr = new ArrayList();
		HashMap hshqueryval = new HashMap();		 
		ResultSet rs = null;
		String appid="";		
		try
		{
			appid=Helper.correctNull((String)hshRequestValues.get("hidDemoId"));
			 
			String year1[];
			String year2[];
			String year3[];
			String year[];
			String type[];
			year1= (String [])hshRequestValues.get("txt_Iyear");
			year2= (String [])hshRequestValues.get("txt_2year");
			year3 = (String [])hshRequestValues.get("txt_3year");
			year = (String [])hshRequestValues.get("year");
			type = (String [])hshRequestValues.get("cbdfintype");
			String hidaction = Helper.correctNull((String)hshRequestValues.get("hidAction"));
			if(!appid.equalsIgnoreCase(""))
			{
				arr = new ArrayList();
				hshQuery.put("strQueryId","del_findet");
				arr.add(appid);
				hshQuery.put("arrValues",arr);
				hshqueryval.put("size","1");	
				hshqueryval.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			if(!appid.equalsIgnoreCase(""))
			{	
				if(!hidaction.equalsIgnoreCase("delete"))
				{					
					int count =0;
					String Sno;
					for(int k=0;k<16;k++)
					{	
						arr=new ArrayList();
						count = k;						
						hshQuery.put("strQueryId","ins_findet");
						arr.add(appid);
						Sno = String.valueOf(count);
						arr.add(Sno);
						if(year1[k]=="")
						{
							arr.add("0");
						}
						else
						{
							arr.add(Helper.correctNull(year1[k]));
						}
						if(year2[k]=="")
						{
							arr.add("0");
						}
						else
						{
							arr.add(Helper.correctNull(year2[k]));
						}
						if(year3[k]=="")
						{
							arr.add("0");
						}
						else
						{
							arr.add(Helper.correctNull(year3[k]));
						}				
						hshQuery.put("arrValues",arr);
						hshqueryval.put("size","1");
						hshqueryval.put("1",hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
					}
				}
			}				
			if(!appid.equalsIgnoreCase(""))
			{
				arr = new ArrayList();
				hshQuery.put("strQueryId","del_fin");
				arr.add(appid);
				hshQuery.put("arrValues",arr);
				hshqueryval.put("size","1");	
				hshqueryval.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			if(!appid.equalsIgnoreCase(""))
			{
				if(!hidaction.equalsIgnoreCase("delete"))
				{			
					int count =0;
					String Sno;
					for(int k=0;k<3;k++)
					{	
						arr=new ArrayList();
						count = k;
						hshQuery.put("strQueryId","ins_fin");
						arr.add(appid);
						Sno = String.valueOf(count);
						if(year[k]=="")
						{
							arr.add("0");
						}
						else
						{
							arr.add(Helper.correctNull(year[k]));
						}
						if(type[k]=="")
						{
							arr.add("0");
						}
						else
						{
							arr.add(Helper.correctNull(type[k]));
						}
						arr.add(Sno);				
						hshQuery.put("arrValues",arr);
						hshqueryval.put("size","1");
						hshqueryval.put("1",hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
					}
				}	
			}
		}			
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
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
	}*/
	
	public HashMap getOpeViability(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();		 
		ResultSet rs = null;
		String recordflag = "N";
		try
		{	 
			String appno=Helper.correctNull((String)hshValues.get("appno"));
			rs=DBUtils.executeLAPSQuery("sel_ope_viability^"+appno);
			 
			while(rs.next())
			{
				hshRecord.put("days_rd_mon",(String)correctNull(rs.getString("days_rd_mon")));
				hshRecord.put("no_km_day",(String)correctNull(rs.getString("no_km_day")));
				hshRecord.put("fare_perkm",(String)correctNull(rs.getString("fare_perkm")));
				hshRecord.put("ave_incom",(String)correctNull(rs.getString("ave_incom")));
				hshRecord.put("other_incom",(String)correctNull(rs.getString("other_incom")));
				hshRecord.put("tot_incom",(String)correctNull(rs.getString("tot_incom")));
				hshRecord.put("fuel_perlitre",(String)correctNull(rs.getString("fuel_perlitre")));
				hshRecord.put("motor_tax",(String)correctNull(rs.getString("motor_tax")));
				hshRecord.put("insu_premium",(String)correctNull(rs.getString("insu_premium")));
				hshRecord.put("garage_rent",(String)correctNull(rs.getString("garage_rent")));
				hshRecord.put("depreciation",(String)correctNull(rs.getString("depreciation")));
				hshRecord.put("int_borrowings",(String)correctNull(rs.getString("int_borrowings")));
				hshRecord.put("maintain_exp",(String)correctNull(rs.getString("maintain_exp")));
				hshRecord.put("cost_oil_spares",(String)correctNull(rs.getString("cost_oil_spares")));
				hshRecord.put("draw_oper",(String)correctNull(rs.getString("draw_oper")));
				hshRecord.put("others",(String)correctNull(rs.getString("others")));
				hshRecord.put("tot_exp",(String)correctNull(rs.getString("tot_exp")));
				hshRecord.put("incom_tax",(String)correctNull(rs.getString("incom_tax")));
				hshRecord.put("Net_surplus",(String)correctNull(rs.getString("Net_surplus")));
				hshRecord.put("depreciation_add",(String)correctNull(rs.getString("depreciation_add")));
				hshRecord.put("Net_cash_accruals",(String)correctNull(rs.getString("net_cash_accruals")));
				hshRecord.put("fuel_perlitre_km",(String)correctNull(rs.getString("fuel_perlitre_km")));
				hshRecord.put("fuel_cost_month",(String)correctNull(rs.getString("fuel_cost_month")));
				hshRecord.put("staff_salary",(String)correctNull(rs.getString("staff_salary")));
				hshRecord.put("surplus",(String)correctNull(rs.getString("surplus")));
				hshRecord.put("instalments_termloan",(String)correctNull(rs.getString("instalments_termloan")));
			
				recordflag = "Y";
			}		
			hshRecord.put("recordflag",recordflag);
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
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
	
	public void updateOpeViability(HashMap hshRequestValues) 
	{		
		HashMap hshQuery=new HashMap();
		HashMap hshQueryValues=new HashMap();
		ArrayList arrValues;
		ResultSet rs=null;
		 
		try
		{
			String hidAction=Helper.correctNull((String)hshRequestValues.get("hidAction"));
			String appno=Helper.correctNull((String)hshRequestValues.get("appno"));
			String days_rd_mon=Helper.correctNull((String)hshRequestValues.get("txtdays_rd_mon"));
			String strmodule = Helper.correctNull((String)hshRequestValues.get("apploantype"));
			if( days_rd_mon.equalsIgnoreCase(""))
			{
				days_rd_mon="0.00"; 
			}				
			String no_km_day=Helper.correctNull((String)hshRequestValues.get("txtno_km_day"));
			if( no_km_day.equalsIgnoreCase(""))
			{
				no_km_day="0.00"; 
			}
			String fare_perkm=Helper.correctNull((String)hshRequestValues.get("txtfare_perkm"));
			if( fare_perkm.equalsIgnoreCase(""))
			{
				fare_perkm="0.00"; 
			}			
			String ave_incom=Helper.correctNull((String)hshRequestValues.get("txtave_incom"));
			if( ave_incom.equalsIgnoreCase(""))
			{
				ave_incom="0.00"; 
			}
			String other_incom=Helper.correctNull((String)hshRequestValues.get("txtother_incom"));
			if( other_incom.equalsIgnoreCase(""))
			{
				other_incom="0.00"; 
			}
			String tot_incom=Helper.correctNull((String)hshRequestValues.get("txttot_incom"));
			if( tot_incom.equalsIgnoreCase(""))
			{
				tot_incom="0.00"; 
			}
			String fuel_perlitre=Helper.correctNull((String)hshRequestValues.get("txtfuel_perlitre"));
			if( fuel_perlitre.equalsIgnoreCase(""))
			{
				fuel_perlitre="0.00"; 
			}
			String motor_tax=Helper.correctNull((String)hshRequestValues.get("txtmotor_tax"));
			if( motor_tax.equalsIgnoreCase(""))
			{
				motor_tax="0.00"; 
			}
			String insu_premium=Helper.correctNull((String)hshRequestValues.get("txtinsu_premium"));
			if( insu_premium.equalsIgnoreCase(""))
			{
				insu_premium="0.00"; 
			}
			String garage_rent=Helper.correctNull((String)hshRequestValues.get("txtgarage_rent"));
			if( garage_rent.equalsIgnoreCase(""))
			{
				garage_rent="0.00"; 
			}
			String depreciation=Helper.correctNull((String)hshRequestValues.get("txtdepreciation"));
			if( depreciation.equalsIgnoreCase(""))
			{
				depreciation="0.00"; 
			}
			String int_borrowings=Helper.correctNull((String)hshRequestValues.get("txtint_borrowings"));
			if( int_borrowings.equalsIgnoreCase(""))
			{
				int_borrowings="0.00"; 
			}
			String maintain_exp=Helper.correctNull((String)hshRequestValues.get("txtmaintain_exp"));
			if( maintain_exp.equalsIgnoreCase(""))
			{
				maintain_exp="0.00"; 
			}
			String cost_oil_spares=Helper.correctNull((String)hshRequestValues.get("txtcost_oil_spares"));
			if( cost_oil_spares.equalsIgnoreCase(""))
			{
				cost_oil_spares="0.00"; 
			}
			String draw_oper=Helper.correctNull((String)hshRequestValues.get("txtdraw_oper"));
			if( draw_oper.equalsIgnoreCase(""))
			{
				draw_oper="0.00"; 
			}
			String others=Helper.correctNull((String)hshRequestValues.get("txtothers"));
			if( others.equalsIgnoreCase(""))
			{
				others="0.00"; 
			}
			String tot_exp=Helper.correctNull((String)hshRequestValues.get("txttot_exp"));
			if( tot_exp.equalsIgnoreCase(""))
			{
				tot_exp="0.00"; 
			}
			String incom_tax=Helper.correctNull((String)hshRequestValues.get("txtincom_tax"));
			if( incom_tax.equalsIgnoreCase(""))
			{
				incom_tax="0.00"; 
			}
			String Net_surplus=Helper.correctNull((String)hshRequestValues.get("txtNet_surplus"));
			if( Net_surplus.equalsIgnoreCase(""))
			{
				Net_surplus="0.00"; 
			}
			String depreciation_add=Helper.correctNull((String)hshRequestValues.get("txtdepreciation_add"));
			if( depreciation_add.equalsIgnoreCase(""))
			{
				depreciation_add="0.00"; 
			}
			String Net_cash_accruals=Helper.correctNull((String)hshRequestValues.get("txtNet_cash_accruals"));
			if( Net_cash_accruals.equalsIgnoreCase(""))
			{
				Net_cash_accruals="0.00"; 
			}
			String fuel_perlitre_km=Helper.correctNull((String)hshRequestValues.get("txtfuel_perlitre_km"));
			if( fuel_perlitre_km.equalsIgnoreCase(""))
			{
				fuel_perlitre_km="0.00"; 
			}			
			String fuel_cost_month=Helper.correctNull((String)hshRequestValues.get("txtfuel_cost_month"));
			if( fuel_cost_month.equalsIgnoreCase(""))
			{
				fuel_cost_month="0.00"; 
			}
			String staff_salary=Helper.correctNull((String)hshRequestValues.get("txtstaff_salary"));
			if( staff_salary.equalsIgnoreCase(""))
			{
				staff_salary="0.00"; 
			}		 	
			String surplus=Helper.correctNull((String)hshRequestValues.get("txtsurplus"));
			if( surplus.equalsIgnoreCase(""))
			{
				surplus="0.00"; 
			}
			//Added by raja for Instalments of Term Loan
			String Instalments_TermLoan=Helper.correctNull((String)hshRequestValues.get("txtInstalment_TermLoan"));
			if( Instalments_TermLoan.equalsIgnoreCase(""))
			{
				Instalments_TermLoan="0.00"; 
			}
			
			
			if(hidAction.equalsIgnoreCase("update"))
			{
				hshQuery.put("strQueryId","del_ope_viability");	
				arrValues=new ArrayList();
				hshQueryValues=new HashMap();
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("size","1");
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQueryValues=new HashMap();
				arrValues.add(appno);
				arrValues.add(days_rd_mon);
				arrValues.add(no_km_day);
				arrValues.add(fare_perkm);
				arrValues.add(ave_incom);
				arrValues.add(other_incom);
				arrValues.add(tot_incom);
				arrValues.add(fuel_perlitre);
				arrValues.add( motor_tax);
				arrValues.add(insu_premium);
				arrValues.add(garage_rent);
				arrValues.add(depreciation);
				arrValues.add(int_borrowings);
				arrValues.add(maintain_exp);
				arrValues.add(cost_oil_spares);
				arrValues.add(draw_oper);
				arrValues.add(others);
				arrValues.add(tot_exp);
				arrValues.add(incom_tax);
				arrValues.add(Net_surplus);
				arrValues.add(depreciation_add);
				arrValues.add(Net_cash_accruals);
				arrValues.add(fuel_perlitre_km);
				arrValues.add(fuel_cost_month);
				arrValues.add(staff_salary);
				arrValues.add(surplus);
				arrValues.add(Instalments_TermLoan);
				hshQuery.put("strQueryId","ins_ope_viability");
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("size","1");
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}	
			
			
			if(Helper.correctNull((String)hshRequestValues.get("hidRecordflag")).equalsIgnoreCase("N"))
			{
				hshRequestValues.put("hidAction","Insert");
			}
			StringBuilder sbAuditTrial=new StringBuilder();
			sbAuditTrial.append("Income per month(All values should be taken on Monthly basis) ^").append("~ Number of days in a month the vehicle will be on road = ").append(correctNull((String )hshRequestValues.get("txtdays_rd_mon")))
			.append("~Number of Kilometers it will run per day = ").append(correctNull((String )hshRequestValues.get("txtno_km_day")))
			.append("~Fare / rate per Kilometer = ").append(correctNull((String )hshRequestValues.get("txtfare_perkm")))
			.append("~Average income per month = ").append(correctNull((String )hshRequestValues.get("txtave_incom")))
			.append("~Any other (out side) income = ").append(correctNull((String )hshRequestValues.get("txtother_incom")))
			.append("~Total income = ").append(correctNull((String )hshRequestValues.get("txttot_incom")))
			.append("~Expenses per month(All values should be taken on Monthly basis)^")
			.append("~Cost of fuel per litre = ").append(correctNull((String )hshRequestValues.get("txtfuel_perlitre")))
			.append("~No of kilometers the vehicle will run per litre = ").append(correctNull((String )hshRequestValues.get("txtfuel_perlitre_km")))
			.append("~Fuel cost per month  = ").append(correctNull((String )hshRequestValues.get("txtfuel_cost_month")))
			.append("~Motor and other municipal taxes = ").append(correctNull((String )hshRequestValues.get("txtmotor_tax")))
			.append("~Insurance premium = ").append(correctNull((String )hshRequestValues.get("txtinsu_premium")))
			.append("~Garage rent = ").append(correctNull((String )hshRequestValues.get("txtgarage_rent")))
			.append("~Depreciation = ").append(correctNull((String )hshRequestValues.get("txtdepreciation")))
			.append("~Interest on borrowings = ").append(correctNull((String )hshRequestValues.get("txtint_borrowings")))
			.append("~Maintenance expenses = ").append(correctNull((String )hshRequestValues.get("txtmaintain_exp")))
			.append("~Cost of oil, spares, etc  = ").append(correctNull((String )hshRequestValues.get("txtcost_oil_spares")))
			.append("~Staff salary  = ").append(correctNull((String )hshRequestValues.get("txtstaff_salary")))
			.append("~Drawings of the operator = ").append(correctNull((String )hshRequestValues.get("txtdraw_oper")))
			.append("~Others = ").append(correctNull((String )hshRequestValues.get("txtothers")))
			.append("~Total expenses  = ").append(correctNull((String )hshRequestValues.get("txttot_exp")))
			.append("~Surplus :  = ").append(correctNull((String )hshRequestValues.get("txtsurplus")))
			.append("~Income tax, if any   = ").append(correctNull((String )hshRequestValues.get("txtincom_tax")))
			.append("~Interest on borrowings   = ").append(correctNull((String )hshRequestValues.get("intborrowings21")))
			.append("~Net surplus   = ").append(correctNull((String )hshRequestValues.get("txtNet_surplus")))
			.append("~Depreciation added back  = ").append(correctNull((String )hshRequestValues.get("txtdepreciation_add")))
			.append("~Net cash accruals   = ").append(correctNull((String )hshRequestValues.get("txtNet_cash_accruals")))
			.append("~Instalments of Term Loan = ").append(correctNull((String )hshRequestValues.get("txtInstalment_TermLoan")))
			.append("~DSCR = ").append(correctNull((String )hshRequestValues.get("txtDSCR")));
			
			if(strmodule.equalsIgnoreCase("P")){
				AuditTrial.auditLog(hshRequestValues,"86",appno,sbAuditTrial.toString());
			}else{
				AuditTrial.auditLog(hshRequestValues,"183",appno,sbAuditTrial.toString());	
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
				if(rs != null)
				{
					rs.close();
				} 
			}
			catch(Exception e1)
			{
				throw new EJBException(e1.getMessage());
			}
		}
	}	

	public HashMap getCitySearch(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		String strCityName="";
		ArrayList arrCol = new ArrayList();
		ArrayList arrValue = new ArrayList();
		ResultSet rs = null;
		String strType="";
		//strType=Helper.correctNull((String)hshValues.get("hidCustType"));
		strCityName=Helper.correctNull((String)hshValues.get("txt_city_name"));
		if(strCityName.trim().equalsIgnoreCase(""))
		{
			strCityName="%";
		}
		try
		{
		
			rs=DBUtils.executeLAPSQuery("sel_city^"+24+"^"+strCityName);
		
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull((String)rs.getString(1)));
				arrCol.add(correctNull((String)rs.getString(2)));
				arrValue.add(arrCol);
			}			
			hshRecord.put("arrCust",arrValue);
		}
		catch(Exception e1)
		{
			throw new EJBException(e1.getMessage());
		}
		
		return hshRecord;
	}

	public HashMap  getCitySearchList(HashMap hshValues) 
	{			
		String strQuery="";
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord =new HashMap();
		ArrayList arrCol = new ArrayList();
		ArrayList arrValue = new ArrayList();
		String statepinmin="",statepinmax="";
		
		try
		{
			String strStatId = "";
			strStatId = correctNull((String)hshValues.get("strStatId1"));
			String cityname = correctNull((String)hshValues.get("txt_city_name"));
			
			if(strStatId.trim().equalsIgnoreCase(""))
			{
				strStatId = "0";
				
			}
			if(!strStatId.trim().equalsIgnoreCase("")&&(cityname.trim().equalsIgnoreCase("")))
			{	
				rs = DBUtils.executeLAPSQuery("sel_cityflex_master^"+strStatId);
			
				while(rs.next())
				{
					arrCol = new ArrayList();
					arrCol.add(correctNull(rs.getString(1)));//0
					String statename = "",statecode="",stateAction="";
					if(!strStatId.equalsIgnoreCase(""))
					{
						strQuery = SQLParser.getSqlQuery("sel_stateflex_name^"+strStatId);
						rs1 = DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							statename = Helper.correctNull((String)rs1.getString("state_name"));
							statecode= Helper.correctNull((String)rs1.getString("state_code"));
							statepinmin = Helper.correctNull((String)rs1.getString("state_pinmin"));
							statepinmax = Helper.correctNull((String)rs1.getString("state_pinmax"));
							stateAction = Helper.correctNull((String)rs1.getString("STATE_ACTION"));
						}
					}
					if(rs1!=null)
						rs1.close();
					arrCol.add(correctNull(rs.getString(2)));//1
					arrCol.add(correctNull(rs.getString(3)));//2
					arrCol.add(statename);//3
					arrCol.add(statecode);//4
					arrCol.add(strStatId);//5
					arrCol.add(statepinmin);//6
					arrCol.add(statepinmax);//7
					arrCol.add(stateAction);//8
					arrValue.add(arrCol);							
				}	
			}
			if(!cityname.trim().equalsIgnoreCase(""))
			{	
				rs = DBUtils.executeLAPSQuery("sel_cityflex_masterpar^"+strStatId+"^"+cityname);
				while(rs.next())
				{
					arrCol = new ArrayList();
					arrCol.add(correctNull(rs.getString(1)));//0
					String statename = "",statecode="",stateAction="";
					if(!strStatId.equalsIgnoreCase(""))
					{
						strQuery = SQLParser.getSqlQuery("sel_stateflex_name^"+strStatId);
						rs1 = DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							statename = Helper.correctNull((String)rs1.getString("state_name"));
							statecode= Helper.correctNull((String)rs1.getString("state_code"));
							
							statepinmin = Helper.correctNull((String)rs1.getString("state_pinmin"));
							statepinmax = Helper.correctNull((String)rs1.getString("state_pinmax"));
							stateAction = Helper.correctNull((String)rs1.getString("STATE_ACTION"));
						}
					}
					if(rs1!=null)
						rs1.close();
					arrCol.add(correctNull(rs.getString(2)));//1
					arrCol.add(correctNull(rs.getString(3)));//2
					arrCol.add(statename);//3
					arrCol.add(statecode);//4
					arrCol.add(strStatId);//5
					arrCol.add(statepinmin);//6
					arrCol.add(statepinmax);//7
					arrCol.add(stateAction);//8
					arrValue.add(arrCol);	
			    }
			}
			hshRecord.put("arrCust",arrValue);
			hshRecord.put("strStatId",strStatId);
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
	
	public HashMap  getCityDetails(HashMap hshValues) 
	{			
		ResultSet rs = null;
		HashMap hshRecord =new HashMap();
		ArrayList VecCityCol = new ArrayList();
		ArrayList VecCityRow = new ArrayList();
		String StrStateCode=Helper.correctNull((String)hshValues.get("strstate"));
		boolean recordflag=false;
		try
		{
			rs = DBUtils.executeLAPSQuery("getCityDetails^"+StrStateCode);
			while(rs.next())
			{
				recordflag=true;
				VecCityCol = new ArrayList();
				VecCityCol.add(Helper.correctNull(rs.getString(1)));
				VecCityCol.add(Helper.correctNull(rs.getString(2)));
				VecCityCol.add(Helper.correctNull(rs.getString(3)));
				VecCityCol.add(Helper.correctNull(rs.getString("active_flag")));
				VecCityRow.add(VecCityCol);
			}
			hshRecord.put("VecCityRow",VecCityRow);
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
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
		return hshRecord;
	}		

	public HashMap  updateCityDetails(HashMap hshValues) 
	{			
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		HashMap hshRecord =new HashMap();
		HashMap hshQuery =new HashMap();		
		HashMap hshQueryValues =new HashMap();	
		HashMap hshQueryValOnl=new HashMap();
		HashMap hshQueryOnl=new HashMap();
		ArrayList arrValuesOnl=new ArrayList();
		ArrayList arrValues = new ArrayList();
		String StrMaxcityCode="",strCityCode="",strExcep="$",strNewCityCode="";
		String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
		strCityCode=correctNull((String)hshValues.get("txt_citycode"));
		strNewCityCode=correctNull((String)hshValues.get("txt_citycode"));
		int count=0;
		StringBuilder sbolddata = new StringBuilder();
		String strKeyId = "";
		try
		{
			strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			if(strAction.equalsIgnoreCase("delete") || strAction.equalsIgnoreCase("Update"))
			{
				rs = DBUtils.executeLAPSQuery("sel_citydetails_audit^"+Helper.correctNull((String)hshValues.get("sel_state"))
						+"^"+Helper.correctNull((String)hshValues.get("hidcityID")));
				if(rs.next())
				{
					sbolddata.append("~ State Name = "+Helper.correctNull((String)hshValues.get("sel_state1")));
					sbolddata.append("~ City Name = "+Helper.correctNull((String)rs.getString("city_name")));
					sbolddata.append("~ City Code = "+Helper.correctNull((String)rs.getString("city_code")));
					sbolddata.append("~ Active Flag = "+Helper.correctNull((String)rs.getString("active_flag")));
				}
				if(rs!=null)
					rs.close();
			}
			if(strAction.equalsIgnoreCase("delete"))
			{			
				hshQuery.put("strQueryId","delCityDetails");	
				arrValues=new ArrayList();
				hshQueryValues=new HashMap();
				arrValues.add(Helper.correctNull((String)hshValues.get("hidcityID")));
				hshQueryValues.put("size","1");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				
				hshQueryValOnl.put("size","1");
				hshQueryOnl.put("strQueryId","del_citydetails_online");
				arrValuesOnl.add("2"+Helper.correctNull((String)hshValues.get("hidcityID")));
				hshQueryOnl.put("arrValues",arrValuesOnl);
				hshQueryValOnl.put("1", hshQueryOnl);
			}
			else
			{
				
				if(strAction.equalsIgnoreCase("insert"))
				{
					rs1=DBUtils.executeLAPSQuery("selCityCodeCheckDuplication^"+strNewCityCode);
					if(rs1.next())
					{
						if(!rs1.getString(1).equalsIgnoreCase(""))
						{
							strExcep=strExcep+"Already the City Code Exist";
							throw new Exception(strExcep);
						}
					}
				}
				rs2=DBUtils.executeLAPSQuery("checkretail_corporatecity^"+strCityCode+"^"
						+strCityCode+"^"+strCityCode+"^"+strCityCode);
				if(rs2.next())	
				{
					count=rs2.getInt(1);
				}
				if(count>0)
				{
					strExcep=strExcep+"Already the City Code Used In Application Can't Change";
					throw new Exception(strExcep);	
				}
				else
				{
					arrValues=new ArrayList();
					hshQueryValues=new HashMap();
					hshQuery.put("strQueryId","delCityDetails");	
					arrValues.add(Helper.correctNull((String)hshValues.get("hidcityID")));
					hshQueryValues.put("size","2");
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					
					arrValuesOnl=new ArrayList();
					hshQueryValOnl=new HashMap();
					hshQueryOnl.put("strQueryId","del_citydetails_online");	
					arrValuesOnl.add("2"+Helper.correctNull((String)hshValues.get("hidcityID")));
					hshQueryValOnl.put("size","2");
					hshQueryOnl.put("arrValues", arrValuesOnl);
					hshQueryValOnl.put("1", hshQueryOnl);
					
					rs = DBUtils.executeLAPSQuery("getMaxCityId");
					while(rs.next())
					{
						StrMaxcityCode = Helper.correctNull((String)rs.getString(1));
					}
					
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					hshQuery.put("strQueryId","insCityDetails");	
					arrValues.add(StrMaxcityCode);
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_citycode")).toUpperCase());
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_cityname")).toUpperCase());
					arrValues.add(Helper.correctNull((String)hshValues.get("sel_state")));
					arrValues.add(Helper.correctNull((String)hshValues.get("sel_active")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("2", hshQuery);
					
					arrValuesOnl=new ArrayList();
					hshQueryOnl=new HashMap();
					hshQueryOnl.put("strQueryId","ins_statecitydetails_onl");	
					arrValuesOnl.add("2"+StrMaxcityCode);
					arrValuesOnl.add("C");
					arrValuesOnl.add(Helper.correctNull((String)hshValues.get("txt_citycode")).toUpperCase());
					arrValuesOnl.add(Helper.correctNull((String)hshValues.get("txt_cityname")).toUpperCase());
					arrValuesOnl.add("1"+Helper.correctNull((String)hshValues.get("sel_state")));
					arrValuesOnl.add("N");
					hshQueryOnl.put("arrValues", arrValuesOnl);
					hshQueryValOnl.put("2", hshQueryOnl);
				}
			}
			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			//COMMENTED AS THERE IS NO NEED TO INSERT  FOR ONLINE DATABASE
		/*	EJBInvoker.executeStateLess("dataaccess",hshQueryValOnl,"updateInternetData");*/
			
			StringBuilder sbAuditTrial=new StringBuilder();
			if(!strAction.equalsIgnoreCase("delete"))
			{
				sbAuditTrial.append("State Name =").append(correctNull((String )hshValues.get("sel_state1"))).append("~City Name =").append(correctNull((String )hshValues.get("txt_cityname")))
				.append("~City Code =").append(correctNull((String )hshValues.get("txt_citycode")).toUpperCase()).append("~Active Flag =").append(correctNull((String )hshValues.get("sel_active")));
			}
			if(correctNull((String)hshValues.get("hidRecordflag")).equals("Y"))
				hshValues.put("hidAction", "update");			
			
			AuditTrial.auditNewLog(hshValues,"76",strKeyId,sbAuditTrial.toString(),sbolddata.toString());
		}
		catch(Exception ce)
		{
			throw new EJBException(ce.getMessage());
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
				if(rs2 != null)
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

	public boolean updateDemographicsApplicantPhoto(HashMap hshValues) 
	{ 
		ResultSet rs=null;
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		String strApplicationNo=correctNull((String)hshValues.get("lngApplicantId"));
		try
		{ 			
			long filelength=0;
			byte bytimg[]=new byte[(int)filelength];
			bytimg=(byte[])hshValues.get("byteimg");
			hshQueryValues=new HashMap();
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			arrValues.add(bytimg);
			arrValues.add(Helper.correctNull((String)hshValues.get("filename")));
			arrValues.add(strApplicationNo);
			hshQueryValues.put("size","1");
			hshQuery.put("strQueryId","mastdemographicsupdphoto");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		catch(Exception e)
		{
			throw new EJBException("Error in updateDemographics "+e.getMessage());	
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
		return true;
	}
	
	public HashMap getdemographicsphoto(HashMap hshValues) 
	{
		ResultSet rs=null;
		HashMap hshResult=new HashMap();
		String strApplicationNo = null;			
		strApplicationNo=correctNull((String)hshValues.get("hidDemoId"));
		Connection conn=null;
		Statement stmt=null;
		String strQuery="";
		
		try
		{			
			if((!strApplicationNo.equals("")) && (!strApplicationNo.equalsIgnoreCase("New")))
			{
				conn=getConnection();
				stmt=conn.createStatement();
				strQuery=SQLParser.getSqlQuery("mastgetdemographicsphoto^"+strApplicationNo);
				StringTokenizer st=new StringTokenizer(strQuery,"#");
				if(st.hasMoreElements()){
					st.nextElement();
					strQuery=(String)st.nextElement();
				}
				rs=stmt.executeQuery(strQuery);
				String strFileExt="",mimeType="";
				
				if(rs.next())
				{
					Blob Blobdata =rs.getBlob("perapp_photo");
					String strDocName = Helper.correctNull(rs.getString("perapp_docname"));
					if(!strDocName.equals(""))
					{
						if(strDocName.length()>=4)
						{
							strFileExt = strDocName.substring(strDocName.length() - 3, strDocName.length());
							AttachPhotoBean attatchPhotoBean = new AttachPhotoBean();
							mimeType =attatchPhotoBean.getMimeType(strFileExt.trim());
						}
						else
						{
							mimeType = "application/stream";
						}
					}
						
					if(Blobdata!=null && Blobdata.length()!=0)
					{
		                byte[] byteDocData = Blobdata.getBytes(1, (int) Blobdata.length());
						if(byteDocData!=null)
						{
							hshResult.put("FILE_STREAM_NAME",strDocName);
							hshResult.put("FILE_STREAM_DISPOSITION_TYPE","inline");
							hshResult.put("FILE_STREAM", byteDocData);
							hshResult.put("FILE_STREAM_TYPE",mimeType);
						}
					}
					else
					{
						hshResult.put("Message","No Image Attached To View");
					}
				}
			}		
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getdemographicsphoto "+e.getMessage());		
		}
		finally
		{
			try
			{
				if(rs!=null)
				{
					rs.close();
				}
				if(conn!=null)
				{
					stmt.close();
					conn.close();
				}
			}
			catch(Exception e)
			{
				throw new EJBException("Error in closing Connection "+e.getMessage());
			}
		}
		return hshResult;
	}

	public HashMap getexapplicantcheck(HashMap hshValues) 
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		String strQuery="",custtmpid="",txt_flag="",tmp="";
		String newname=Helper.correctNull((String)hshValues.get("newname"));
		String newdob=Helper.correctNull((String)hshValues.get("newdob"));
		
		try
		{
			strQuery= SQLParser.getSqlQuery("selperappdup^"+newname+"^"+newdob);
			rs=DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				custtmpid = custtmpid + " " + correctNull((String)rs.getString("perapp_id")) + "( "+ correctNull((String)rs.getString("perapp_branchcode")) + " )" ;
				txt_flag = "Y";
				tmp ="N";
			}
			hshResult.put("txt_flag",txt_flag);
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getexapplicantcheck"+e.getMessage());
		}
				
		return hshResult;
	}
	
	public HashMap getbpldetails(HashMap hshValues)
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		String strQuery="";
		String strstate="";
		try
		{
			strstate=Helper.correctNull((String)hshValues.get("sel_state"));
			strQuery=SQLParser.getSqlQuery("selbplmaster^"+strstate);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshResult.put("statename",correctNull(rs.getString("bplstate_name")));
				hshResult.put("stateamt",correctNull(rs.getString("bplstate_amt")));
			}
			hshResult.put("statename",strstate);
		}
		catch(Exception ae)
		{
			throw new EJBException("Error in getBplDetails"+ae.getMessage());
		}
		return hshResult;
	}
	
	public void updatebpldetails(HashMap hshValues)
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
		String strKeyId = "";
		StringBuilder sbolddata = new StringBuilder();
		ResultSet rs = null;
		try
		{
			strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			
			rs = DBUtils.executeLAPSQuery("selbplmaster^"+Helper.correctNull((String)hshValues.get("sel_state")));
			if(rs.next())
			{
				sbolddata.append("State Name = "+correctNull((String )hshValues.get("sel_state1")));
				sbolddata.append("~ Amount per year = "+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("bplstate_amt")))));
			}
			if(rs!=null)
			rs.close();
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","del_bplmaster");
				arrValues.add(correctNull((String)hshValues.get("sel_state")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId","ins_bplmaster");
				arrValues.add(correctNull((String)hshValues.get("sel_state")));
				arrValues.add(correctNull((String)hshValues.get("txt_amount")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				
				hshQuery.put("strQueryId","del_bplmaster");
				arrValues.add(correctNull((String)hshValues.get("sel_state")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			StringBuilder sbAuditTrial=new StringBuilder();
			if(!strAction.equalsIgnoreCase("delete"))
			{
				sbAuditTrial.append("State Name =").append(correctNull((String )hshValues.get("sel_state1")))
				.append("~Amount per year =").append(correctNull((String )hshValues.get("txt_amount")));
			}
			if(correctNull((String)hshValues.get("hidRecordflag")).equals("Y"))
				hshValues.put("hidAction", "update");
			
			AuditTrial.auditNewLog(hshValues,"77",strKeyId,sbAuditTrial.toString(),sbolddata.toString());
			
		}
		catch(Exception ae)
		{
			throw new EJBException("Error in UpdateBplDetails"+ae.getMessage());
		}
	}
	
	public HashMap getBranchSearchList(HashMap hshValues) throws  EJBException
	{
		HashMap hshRecord=new HashMap();
		String strQuery="";
		String strBranchName="",strcat="",strorglevel="";
		ArrayList arrCol = new ArrayList();
		ArrayList arrValue = new ArrayList();
		ResultSet rs = null;
		String strType="";
		strBranchName=Helper.correctNull((String)hshValues.get("txt_branchname"));
		strcat=Helper.correctNull((String)hshValues.get("cat"));
		strorglevel="A";
		if(strBranchName.trim().equalsIgnoreCase(""))
		{
			strBranchName="%";
		}
		try
		{
			if(strcat.equals("1"))
			{
				strQuery=SQLParser.getSqlQuery("sel_branchbycode^"+strBranchName);
			}
			else if(strcat.equals("2"))
			{
				strQuery=SQLParser.getSqlQuery("sel_branchbyname^"+strBranchName);
			}
			rs =DBUtils.executeQuery(strQuery);

			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull((String)rs.getString(1)));
				arrCol.add(correctNull((String)rs.getString(2)));
				arrCol.add(correctNull(rs.getString("org_code")));
				arrCol.add(correctNull(rs.getString("org_branchType")));
				arrValue.add(arrCol);
			}			
			hshRecord.put("arrBranch",arrValue);
		}
		catch(Exception e1)
		{
			throw new EJBException(e1.getMessage());
		}
		
		return hshRecord;
	}
	
	public HashMap getKYCNormsdetails(HashMap hshValues)
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		ResultSet rs1=null;
		ResultSet rs2=null;
		String strQuery="";
		String strQueryfornew="";
		String strcustid="";
		String strProfilestatus="";
		String strcorpid="";
		String strLoantype="";
		boolean recordflag=false;
		String strAppStatus="";
		String strCBSID="",strFacname="";
		String strtxtCBSID="";
		String splitat="";
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol= null;
		String[] valArray=null;
		int count=0;

		try
		{
			strtxtCBSID=Helper.correctNull((String)hshValues.get("txt_cbs_id"));
			strLoantype=Helper.correctNull((String)hshValues.get("loantype"));			
			strcustid=Helper.correctNull((String)hshValues.get("hidDemoId"));	
			
			strAppStatus=Helper.correctNull((String)hshValues.get("hidappstatus"));
			//strcorpid=Helper.correctNull((String)hshValues.get("hidapplicantnewid"));
			if(strcustid.equalsIgnoreCase(""))
			{
				strcustid=Helper.correctNull((String)hshValues.get("hidapplicantnewid"));
			}
			if(strcustid.equalsIgnoreCase(""))
			{
				strcustid=Helper.correctNull((String)hshValues.get("comapp_id"));
			}
			if(strcustid.equalsIgnoreCase("") || strcustid.equalsIgnoreCase("null"))
			{
				strcustid=strcorpid;
			}
			strQuery=SQLParser.getSqlQuery("selbeneficial^"+strcustid);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull((String)rs.getString("BEN_OWN_ID")));
				arrCol.add(Helper.correctNull((String)rs.getString("BEN_OWN")));
				String identidoc=Helper.correctNull((String)rs.getString("ID_DOC"));
				strQuery=SQLParser.getSqlQuery("selectidentificationdoc^"+identidoc);
				rs2=DBUtils.executeQuery(strQuery);
				if(rs2.next())
				{
				arrCol.add(Helper.correctNull((String)rs2.getString("STAT_DATA_DESC1")));
				}
				if(rs2!=null)
				{
					rs2.close();
				}
				arrCol.add(Helper.correctNull((String)rs.getString("ID_DOC_NUM")));
				arrCol.add(Helper.correctNull((String)rs.getString("PERC_SHARES_HELD")));
				String relatborr=Helper.correctNull((String)rs.getString("RELA_BORR"));
				strQuery=SQLParser.getSqlQuery("selectrelationshipwithborrower^"+relatborr);
				rs2=DBUtils.executeQuery(strQuery);
				if(rs2.next())
				{
				arrCol.add(Helper.correctNull((String)rs2.getString("CBS_STATIC_DATA_DESC")));
				}
				if(rs2!=null)
				{
					rs2.close();
				}
				arrCol.add(Helper.correctNull((String)rs.getString("NO_SHARES_HELD")));
				arrCol.add(Helper.correctNull((String)rs.getString("GUART_AVB")));
				arrRow.add(arrCol);
			}
			hshResult.put("arrRow", arrRow);
			
			strQuery=SQLParser.getSqlQuery("sel_applKYCNorms^"+strcustid);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshResult.put("custid",correctNull(rs.getString("kyc_custid")));
				hshResult.put("custtype",correctNull(rs.getString("kyc_custtype")));
				hshResult.put("occupation",correctNull(rs.getString("kyc_occupation")));				
				hshResult.put("annualincomecode",correctNull(rs.getString("kyc_annualincome")));
				hshResult.put("annualincomedesc",correctNull(rs.getString("annualincomedesc")));				
				hshResult.put("countryresicode",correctNull(rs.getString("kyc_countryresi")));
				hshResult.put("countryresidesc",correctNull(rs.getString("countryresidesc")));				
				hshResult.put("form",correctNull(rs.getString("kyc_form")));
				hshResult.put("formrefno",correctNull(rs.getString("kyc_formrefno")));				
				hshResult.put("idprooftypecode",correctNull(rs.getString("kyc_idprooftype")));
				hshResult.put("idprooftypedesc",correctNull(rs.getString("idprooftypedesc")));				
				hshResult.put("idproofref",correctNull(rs.getString("kyc_idproofref")));				
				hshResult.put("resiprooftypecode",correctNull(rs.getString("kyc_resiprooftype")));
				hshResult.put("resiprooftypedesc",correctNull(rs.getString("resiprooftypedesc")));				
				hshResult.put("resiidrefno",correctNull(rs.getString("kyc_resiidrefno")));
				hshResult.put("sourceincomecode",correctNull(rs.getString("kyc_sourceincome")));
				hshResult.put("sourceincomedesc",correctNull(rs.getString("sourceincomedesc")));				
				hshResult.put("networthcode",correctNull(rs.getString("kyc_networth")));
				hshResult.put("networthdesc",correctNull(rs.getString("networthdesc")));				
				hshResult.put("turnovercode",correctNull(rs.getString("kyc_turnover")));
				hshResult.put("turnoverdesc",correctNull(rs.getString("turnoverdesc")));				
				hshResult.put("estiturnovercode",correctNull(rs.getString("kyc_estiturnover")));
				hshResult.put("estiturnoverdesc",correctNull(rs.getString("estiturnoverdesc")));				
				hshResult.put("account",correctNull(rs.getString("kyc_account")));		
				hshResult.put("activitycode",correctNull(rs.getString("kyc_activity")));
				hshResult.put("activitydesc",correctNull(rs.getString("activitydesc")));				
				hshResult.put("ofac",correctNull(rs.getString("kyc_ofac")));				
				hshResult.put("remittance",correctNull(rs.getString("kyc_remittance")));				
				hshResult.put("remitcountrycode",correctNull(rs.getString("kyc_remitcountry")));
				hshResult.put("remitcountrydesc",correctNull(rs.getString("remitcountrydesc")));				
				hshResult.put("clientname_1",correctNull(rs.getString("kyc_clientname_1")));
				hshResult.put("clientlocation_1",correctNull(rs.getString("kyc_clientlocation_1")));				
				hshResult.put("client1citycode",correctNull(rs.getString("kyc_clientcitycode_1")));
				hshResult.put("client1citydesc",correctNull(rs.getString("client1citydesc")));				
				hshResult.put("client1statecode",correctNull(rs.getString("kyc_clientstatecode_1")));
				hshResult.put("client1statedesc",correctNull(rs.getString("client1statedesc")));				
				hshResult.put("client1cntrycode",correctNull(rs.getString("kyc_clientcntrycode_1")));
				hshResult.put("client1cntrydesc",correctNull(rs.getString("client1cntrydesc")));				
				hshResult.put("clientname_2",correctNull(rs.getString("kyc_clientname_2")));
				hshResult.put("clientlocation_2",correctNull(rs.getString("kyc_clientlocation_2")));				
				hshResult.put("client2citycode",correctNull(rs.getString("kyc_clientcitycode_2")));
				hshResult.put("client2citydesc",correctNull(rs.getString("client2citydesc")));				
				hshResult.put("client2statecode",correctNull(rs.getString("kyc_clientstatecode_2")));
				hshResult.put("client2statedesc",correctNull(rs.getString("client2statedesc")));				
				hshResult.put("client2cntrycode",correctNull(rs.getString("kyc_clientcntrycode_2")));
				hshResult.put("client2cntrydesc",correctNull(rs.getString("client2cntrydesc")));				
				hshResult.put("clientname_3",correctNull(rs.getString("kyc_clientname_3")));
				hshResult.put("clientlocation_3",correctNull(rs.getString("kyc_clientlocation_3")));				
				hshResult.put("client3citycode",correctNull(rs.getString("kyc_clientcitycode_3")));
				hshResult.put("client3citydesc",correctNull(rs.getString("client3citydesc")));				
				hshResult.put("client3statecode",correctNull(rs.getString("kyc_clientstatecode_3")));
				hshResult.put("client3statedesc",correctNull(rs.getString("client3statedesc")));				
				hshResult.put("client3cntrycode",correctNull(rs.getString("kyc_clientcntrycode_3")));
				hshResult.put("client3cntrydesc",correctNull(rs.getString("client3cntrydesc")));				
				hshResult.put("riskcode",correctNull(rs.getString("kyc_risk")));
				hshResult.put("riskdesc",correctNull(rs.getString("riskdesc")));				
				hshResult.put("custoccupcode",correctNull(rs.getString("kyc_occupationcode")));
				hshResult.put("custoccupdesc",correctNull(rs.getString("occupationcodedesc")));
				hshResult.put("kyc_sleeppartner",correctNull(rs.getString("kyc_sleeppartner")));
				hshResult.put("kyc_politicalexposed",correctNull(rs.getString("kyc_politicalexposed")));
				hshResult.put("kyc_familyshare",correctNull(rs.getString("kyc_familyshare")));
				//ADDED BY VENKATA PRASAD CHOWDARY FOR KYCNORMS ON 18-04-2013
				hshResult.put("kyc_sinceoccupation",correctNull(rs.getString("kyc_sinceoccupation")));
				hshResult.put("kyc_id_valid",correctNull(rs.getString("kyc_id_valid")));
				hshResult.put("kyc_residence_valid",correctNull(rs.getString("kyc_residence_valid")));
				hshResult.put("kyc_kycActivity",Helper.correctNull(rs.getString("kyc_kycActivity")));
				hshResult.put("KYC_DOC_DATE",Helper.correctNull(rs.getString("kyc_doc_date")));
				recordflag=true;
			}
			
			HashMap prof=new HashMap();
			HashMap profile=new HashMap();
			prof.put("profile_id",strcustid);
			profile=(HashMap)getCustomerProfileStatus(prof);
			hshResult.put("strIncompletepage", Helper.correctNull((String)profile.get("strIncompletepage")));
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("getprofilestatusfromdemographic^"+strcustid);
			if(rs.next())
			{
				strProfilestatus=Helper.correctNull((String)rs.getString("perapp_profilestatus"));
				hshResult.put("perapp_constitution",correctNull(rs.getString("perapp_constitution")));
				hshResult.put("PERAPP_CONSTITUTIONNEW",correctNull(rs.getString("PERAPP_CONSTITUTIONNEW")));
				hshResult.put("perapp_status",correctNull(rs.getString("perapp_status")));		
				strCBSID=Helper.correctNull((String)rs.getString("perapp_cbsid"));
			}
			hshResult.put("strCBSID", strCBSID);
			if(rs!=null)
				rs.close();
			
			rs=DBUtils.executeLAPSQuery("comowner^"+strcustid);
			if(rs.next())
			{
	    		hshResult.put("comapp_ownership",correctNull(rs.getString("PERAPP_CONSTITUTIONNEW")));			
			}
			if(rs!=null)
				rs.close();
			
			hshResult.put("strProfilestatus",strProfilestatus);			
			hshResult.put("cust_id",strcustid);
			if(recordflag)
			  hshResult.put("recordflag","Y");
			else
			  hshResult.put("recordflag","N");	
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("perconstbankingsel^"+strcustid);
			if(rs.next())
			{
				strFacname=Helper.correctNull((String)rs.getString("cus_facname"));
			}
			hshResult.put("strFacname",strFacname);
		
			hshResult.put("appstatus", strAppStatus);
		}
		catch(Exception ae)
		{
			throw new EJBException("Error in getKYCNormsdetails"+ae.getMessage());
		}
		
		return hshResult;
	}
	
	public void updateKYCNormsdetails(HashMap hshValues)
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
		String strApplicationNo="";
		ResultSet rs=null;
		String strQuery="";
		String status="Y";
		
		StringBuilder sbOldAudit = new StringBuilder();
		try
		{
			strApplicationNo=correctNull((String)hshValues.get("hidDemoId"));
			
			/***
			 * For Audit Trial Old Data - By Karthikeyan.S on 13/09/2013
			 */
			
			strQuery=SQLParser.getSqlQuery("sel_applKYCNorms^"+strApplicationNo);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				sbOldAudit.append("~Customer Occupation=").append(Helper.correctNull((String)rs.getString("occupationcodedesc")))
				.append("~Since=").append(Helper.correctNull((String)rs.getString("kyc_sinceoccupation")))
				.append("~ID Proof Type=").append(Helper.correctNull((String)rs.getString("idprooftypedesc")))
				.append("~Residence Proof Type=").append(Helper.correctNull((String)rs.getString("resiprooftypedesc")))
				.append("~ID Reference=").append(Helper.correctNull((String)rs.getString("kyc_idproofref")))
				.append("~Residence ID Reference=").append(Helper.correctNull((String)rs.getString("kyc_resiidrefno")))
				.append("~ID Valid Upto=").append(Helper.correctNull((String)rs.getString("kyc_id_valid")))
				.append("~Residence Valid Upto=").append(Helper.correctNull((String)rs.getString("kyc_residence_valid")))
				.append("~Risk Categorization=").append(Helper.correctNull((String)rs.getString("riskdesc")))
				.append("~Nature of Activity=").append(Helper.correctNull((String)rs.getString("activitydesc")));
			}
			
			/***
			 * End - Audit Trial Old Data
			 */
			
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","del_applKYCNorms");
				arrValues.add(correctNull((String)hshValues.get("hidDemoId")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId","ins_applKYCNorms");				
				arrValues.add(correctNull((String)hshValues.get("hidDemoId")));//kyc_custid
				arrValues.add(correctNull((String)hshValues.get("sel_CustType")));//kyc_custtype
				arrValues.add(correctNull((String)hshValues.get("txt_Occupation")));//kyc_occupation
				arrValues.add(correctNull((String)hshValues.get("hid_AnnualIncome")));//kyc_annualincome
				arrValues.add(correctNull((String)hshValues.get("hid_CountryResi")));//kyc_countryresi
				arrValues.add(correctNull((String)hshValues.get("sel_Form")));//kyc_form
				arrValues.add(correctNull((String)hshValues.get("txt_FormRefNo")));//kyc_formrefno
				arrValues.add(correctNull((String)hshValues.get("hid_IdProofType")));//kyc_idprooftype
				arrValues.add(correctNull((String)hshValues.get("txt_IDProofRef")));//kyc_idproofref
				arrValues.add(correctNull((String)hshValues.get("hid_ResiProofType")));//kyc_resiprooftype
				arrValues.add(correctNull((String)hshValues.get("txt_ResiIDRefNo")));//kyc_resiidrefno
				arrValues.add(correctNull((String)hshValues.get("hid_SourceIncome")));//kyc_sourceincome
				arrValues.add(correctNull((String)hshValues.get("hid_Networth")));//kyc_networth
				arrValues.add(correctNull((String)hshValues.get("hid_TurnOver")));//kyc_turnover
				arrValues.add(correctNull((String)hshValues.get("hid_EstiTurnOver")));//kyc_estiturnover
				arrValues.add(correctNull((String)hshValues.get("sel_Account")));//kyc_account
				arrValues.add(correctNull((String)hshValues.get("hid_Activity")));//kyc_activity
				arrValues.add(correctNull((String)hshValues.get("sel_OFAC")));//kyc_ofac
				arrValues.add(correctNull((String)hshValues.get("sel_Remittance")));//kyc_remittance
				arrValues.add(correctNull((String)hshValues.get("hid_RemitCountry")));//kyc_remitcountry				
				arrValues.add(correctNull((String)hshValues.get("txt_clientname1")));//kyc_clientname_1
				arrValues.add(correctNull((String)hshValues.get("txt_location1")));//kyc_clientlocation_1
				arrValues.add(correctNull((String)hshValues.get("hid_city1")));//kyc_clientcitycode_1
				arrValues.add(correctNull((String)hshValues.get("hid_state1")));//kyc_clientstatecode_1
				arrValues.add(correctNull((String)hshValues.get("hid_cntry1")));//kyc_clientcntrycode_1				
				arrValues.add(correctNull((String)hshValues.get("txt_clientname2")));//kyc_clientname_2
				arrValues.add(correctNull((String)hshValues.get("txt_location2")));//kyc_clientlocation_2
				arrValues.add(correctNull((String)hshValues.get("hid_city2")));//kyc_clientcitycode_2
				arrValues.add(correctNull((String)hshValues.get("hid_state2")));//kyc_clientstatecode_2
				arrValues.add(correctNull((String)hshValues.get("hid_cntry2")));//kyc_clientcntrycode_2				
				arrValues.add(correctNull((String)hshValues.get("txt_clientname3")));//kyc_clientname_3
				arrValues.add(correctNull((String)hshValues.get("txt_location3")));//kyc_clientlocation_3
				arrValues.add(correctNull((String)hshValues.get("hid_city3")));//kyc_clientcitycode_3
				arrValues.add(correctNull((String)hshValues.get("hid_state3")));//kyc_clientstatecode_3
				arrValues.add(correctNull((String)hshValues.get("hid_cntry3")));//kyc_clientcntrycode_3				
				arrValues.add(correctNull((String)hshValues.get("hid_Risk")));//kyc_risk				
				arrValues.add(correctNull((String)hshValues.get("hid_custoccup")));//kyc_risk
				arrValues.add(correctNull((String)hshValues.get("sel_sleeppartner")));//kyc_sleeppartner
				arrValues.add(correctNull((String)hshValues.get("sel_politicalexposed")));//kyc_politicalexposed
				arrValues.add(correctNull((String)hshValues.get("sel_familyshare")));//kyc_familyshare
				//Added by Venkat Prasad Chowdary.
				arrValues.add(correctNull((String)hshValues.get("txt_sinceoccupation")));//kyc_familyshare
				arrValues.add(correctNull((String)hshValues.get("txt_id_valid")));//kyc_familyshare
				arrValues.add(correctNull((String)hshValues.get("txt_residence_valid")));//kyc_familyshare
				arrValues.add(status);//To check the completed status of the customer profile
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Activitykyc")));//kyc_Activitykyc
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_doc_date")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				
				hshQuery.put("strQueryId","del_applKYCNorms");
				arrValues.add(correctNull((String)hshValues.get("hidDemoId")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			StringBuilder sbAt = new StringBuilder();
			if(strAction.equalsIgnoreCase("insert"))
			{
				/*sbAt.append("Corporate Customer=");
				if(correctNull((String) hshValues.get("sel_CustType")).equals("Y"))
				{
					sbAt.append("Yes");
				}
				else if(correctNull((String) hshValues.get("sel_CustType")).equals("N"))
				{
					sbAt.append("No");
				}
				else
				{
					sbAt.append("");
				}
				sbAt.append(" ~Annual Income=").append(correctNull((String) hshValues.get("hid_AnnualIncome"))).append(", ").append(correctNull((String) hshValues.get("txt_AnnualIncome")));
				sbAt.append(" ~Customer Occupation=").append(correctNull((String) hshValues.get("hid_custoccup"))).append(", ").append(correctNull((String) hshValues.get("txt_custoccup")));
				sbAt.append(" ~Occupation=").append(correctNull((String) hshValues.get("txt_Occupation")));
				sbAt.append(" ~Form 60/61=").append(correctNull((String) hshValues.get("sel_Form")));
				sbAt.append(" ~Country of residence=").append(correctNull((String) hshValues.get("txt_CountryResi")));
				sbAt.append(" ~Ref No=").append(correctNull((String) hshValues.get("txt_FormRefNo")));
				sbAt.append(" ~Residence Proof Type=").append(correctNull((String)hshValues.get("hid_ResiProofType"))).append(", ").append(correctNull((String)hshValues.get("txt_ResiProofType")));
				sbAt.append(" ~ID Proof Type=").append((String)hshValues.get("hid_IdProofType")).append(", ").append(correctNull((String)hshValues.get("txt_IdProofType")));
				sbAt.append(" ~Residence ID Reference=").append((String)hshValues.get("txt_ResiIDRefNo"));
				sbAt.append(" ~ID Reference =").append(correctNull((String) hshValues.get("txt_IDProofRef")));
				sbAt.append(" ~Source of Income=").append(correctNull((String) hshValues.get("hid_SourceIncome"))).append(", ").append(correctNull((String)hshValues.get("txt_SourceIncome")));
				sbAt.append(" ~Networth (in Rs)=").append(correctNull((String) hshValues.get("hid_Networth"))).append(", ").append(correctNull((String)hshValues.get("txt_Networth")));
				if(correctNull((String) hshValues.get("sel_Account")).equals("Y"))
				{
					sbAt.append(" ~Pooled Account=").append("Yes");
				}
				else if(correctNull((String) hshValues.get("sel_Account")).equals("N"))
				{
					sbAt.append(" ~Pooled Account=").append("No");
				}
				else
				{
					sbAt.append(" ~Pooled Account=").append("");
				}
				sbAt.append(" ~Annual Turn Over=").append(correctNull((String) hshValues.get("hid_TurnOver"))).append(", ").append(correctNull((String)hshValues.get("txt_TurnOver")));
				sbAt.append(" ~Nature of Activity=").append(correctNull((String) hshValues.get("hid_Activity"))).append(", ").append(correctNull((String)hshValues.get("txt_Activity")));
				sbAt.append(" ~Annual Turn Over (Estimated)=").append(correctNull((String)hshValues.get("hid_EstiTurnOver"))).append(", ").append(correctNull((String)hshValues.get("txt_EstiTurnOver")));
				if(correctNull((String) hshValues.get("sel_OFAC")).equals("Y"))
				{
					sbAt.append(" ~OFAC/UNSCAN=").append("Yes");
				}
				else if(correctNull((String) hshValues.get("sel_OFAC")).equals("N"))
				{
					sbAt.append(" ~OFAC/UNSCAN=").append("No");
				}
				else
				{
					sbAt.append(" ~OFAC/UNSCAN=").append("");
				}
				if(correctNull((String) hshValues.get("sel_Remittance")).equals("Y"))
				{
					sbAt.append(" ~Foreign Inward Remittance=").append("Yes");
				}
				else if(correctNull((String) hshValues.get("sel_Remittance")).equals("N"))
				{
					sbAt.append(" ~Foreign Inward Remittance=").append("No");
				}
				else
				{
					sbAt.append(" ~Foreign Inward Remittance=").append("");
				}
				sbAt.append(" ~Risk Categorization=").append(correctNull((String) hshValues.get("hid_Risk"))).append(", ").append(correctNull((String)hshValues.get("txt_Risk")));
				if(correctNull((String) hshValues.get("sel_sleeppartner")).equals("Y"))
				{
					sbAt.append(" ~Sleeping Partners=").append("Yes");
				}
				else if(correctNull((String) hshValues.get("sel_sleeppartner")).equals("N"))
				{
					sbAt.append(" ~Sleeping Partners=").append("No");
				}
				else
				{
					sbAt.append(" ~Sleeping Partners=").append("");
				}
				
				if(correctNull((String) hshValues.get("sel_politicalexposed")).equals("Y"))
				{
					sbAt.append(" ~Political Exposed=").append("Yes");
				}
				else if(correctNull((String) hshValues.get("sel_politicalexposed")).equals("N"))
				{
					sbAt.append(" ~Political Exposed=").append("No");
				}
				else
				{
					sbAt.append(" ~Political Exposed=").append("");
				}
				
				if(correctNull((String) hshValues.get("sel_familyshare")).equals("Y"))
				{
					sbAt.append(" ~Family Share=").append("Yes");
				}
				else if(correctNull((String) hshValues.get("sel_familyshare")).equals("N"))
				{
					sbAt.append(" ~Family Share=").append("No");
				}
				else
				{
					sbAt.append(" ~Family Share=").append("");
				}
				sbAt.append(" ~Client 1 Name=").append(correctNull((String) hshValues.get("txt_clientname1")));
				sbAt.append(" ~Address=").append(correctNull((String)hshValues.get("txt_location1")));
				sbAt.append(" ~City=").append((String)hshValues.get("txt_city1"));
				sbAt.append(" ~Country=").append((String)hshValues.get("txt_cntry1"));
				sbAt.append(" ~Client 2 Name =").append(correctNull((String) hshValues.get("txt_clientname2")));
				sbAt.append(" ~Address=").append(correctNull((String) hshValues.get("txt_location2")));
				sbAt.append(" ~City=").append(correctNull((String) hshValues.get("txt_city2")));
				sbAt.append(" ~Country=").append(correctNull((String) hshValues.get("txt_cntry2")));
				sbAt.append(" ~Client 3 Name=").append(correctNull((String) hshValues.get("txt_clientname3")));
				sbAt.append(" ~Address=").append(correctNull((String) hshValues.get("txt_location3")));
				sbAt.append(" ~City=").append(correctNull((String)hshValues.get("txt_city3")));
				sbAt.append(" ~Country=").append((String)hshValues.get("txt_cntry3"));*/
				if(correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("Y"))
				{
					hshValues.put("hidAction", "update");
				}
			}
			
			/***
			 * For Audit Trial New Data - By Karthikeyan.S on 13/09/2013
			 */
			
			sbAt.append("~Customer Occupation=").append(Helper.correctNull((String)hshValues.get("txt_custoccup")))
					.append("~Since=").append(Helper.correctNull((String)hshValues.get("txt_sinceoccupation")))
					.append("~ID Proof Type=").append(Helper.correctNull((String)hshValues.get("txt_IdProofType")))
					.append("~Residence Proof Type=").append(Helper.correctNull((String)hshValues.get("txt_ResiProofType")))
					.append("~ID Reference=").append(Helper.correctNull((String)hshValues.get("txt_IDProofRef")))
					.append("~Residence ID Reference=").append(Helper.correctNull((String)hshValues.get("txt_ResiIDRefNo")))
					.append("~ID Valid Upto=").append(Helper.correctNull((String)hshValues.get("txt_id_valid")))
					.append("~Residence Valid Upto=").append(Helper.correctNull((String)hshValues.get("txt_residence_valid")))
					.append("~Risk Categorization=").append(Helper.correctNull((String)hshValues.get("txt_Risk")))
					.append("~Nature of Activity=").append(Helper.correctNull((String)hshValues.get("txt_Activity")));

			/***
			 * End - Audit Trial New Data
			 */
			
			AuditTrial.auditNewLog(hshValues, "206", strApplicationNo, sbAt.toString(), sbOldAudit.toString());
			
		}
		catch(Exception ae)
		{
			throw new EJBException("Error in updateKYCNormsdetails"+ae.getMessage());
		}
	}
	
	public HashMap  getCountrySearchList(HashMap hshValues) 
	{			
		String strQuery="";
		ResultSet rs = null;
		HashMap hshRecord =new HashMap();
		ArrayList arrCol = new ArrayList();
		ArrayList arrValue = new ArrayList();
		String strAppend=" ";
		try
		{
			String cntryname = correctNull((String)hshValues.get("txt_codename"));
			if(cntryname.trim().equalsIgnoreCase(""))
			{	
				strQuery=SQLParser.getSqlQuery("sel_countryList^"+strAppend);
				rs=DBUtils.executeQuery(strQuery);
				
				while(rs.next())
				{
					arrCol = new ArrayList();
					arrCol.add(correctNull(rs.getString("CON_COUNTRY")));
					arrCol.add(correctNull(rs.getString("CON_COUNTRYCODE")));
					arrValue.add(arrCol);							
				}	
			}
			if(!cntryname.trim().equalsIgnoreCase(""))
			{	
				strAppend= "where CON_COUNTRY like '" + cntryname.toUpperCase() +"%'";
				strQuery=SQLParser.getSqlQuery("sel_countryList^"+strAppend);
				rs=DBUtils.executeQuery(strQuery);
				
				while(rs.next())
				{
					arrCol = new ArrayList();
					arrCol.add(correctNull(rs.getString("CON_COUNTRY")));
					arrCol.add(correctNull(rs.getString("CON_COUNTRYCODE")));
					arrValue.add(arrCol);	
				}
			}
			hshRecord.put("arrCntry",arrValue);
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
		return hshRecord;
	}
	
	public HashMap getCustomerProfileStatus(HashMap hshValues)
	{
		HashMap hshResult=new HashMap();
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		ResultSet rs=null,rs1=null;
		String status="";
		String strPerapplicant="";
		String strIndividualnfo="";
		String strEmploymentDet="";
		String strIncExpenses="";
		String strKYCNorms="";
		String strEmployment="";
		String strContactInfo="";
		String strEmploymentStatus="",strQuery="";
		String strRating="",strConstitution="",strIncompletepage="",strSHGstatus="",strDefaulter="",strGroupManagement="Y";
		try
		{
			String strNewAppId=Helper.correctInt((String)hshValues.get("profile_id"));
			rs=DBUtils.executeLAPSQuery("get_perapplicant_details^"+strNewAppId);
			if(rs.next())
			{
				strConstitution=Helper.correctNull((String)rs.getString("perapp_constitutionnew"));
			}	
			if(rs !=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("getcustomerprofilestatus^"+strNewAppId);
			if(rs.next())
			{
				strPerapplicant=Helper.correctNull((String)rs.getString("perapp_pagestatus"));
				strKYCNorms=Helper.correctNull((String)rs.getString("kyc_pagestatus"));
				strContactInfo=Helper.correctNull((String)rs.getString("con_status"));
				strEmployment=Helper.correctNull((String)rs.getString("perapp_employment"));
			}
			else{
				strIncompletepage="Demographics";
			}
			
			if(rs !=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("sel_company_info^"+strNewAppId);
			if(rs.next())
			{
				if(Helper.correctNull((String)rs.getString("cominfo_gstinreg")).equalsIgnoreCase(""))
				{
					strPerapplicant="N";
					strIncompletepage="Demographics";
				}
				else if(Helper.correctNull((String)rs.getString("cominfo_gstinreg")).equalsIgnoreCase("Y")&&
						Helper.correctNull((String)rs.getString("COMINFO_GSTIN")).equalsIgnoreCase(""))
				{
					strPerapplicant="N";
					strIncompletepage="Demographics";
				}
			}
			
			
			if(rs !=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("getcustomerprofileincomestatus^"+strNewAppId);
			if(rs.next())
			{
				strIncExpenses=Helper.correctNull((String)rs.getString("perinc_pagestatus"));
			}
			if(rs !=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("getcustomerprofileemploymentstatus^"+strNewAppId);
			if(rs.next())
			{
				strEmploymentStatus=Helper.correctNull((String)rs.getString("peremp_pagestatus"));
			}
			if(rs !=null)
			{
				rs.close();
			}
			int intcnt=0;
			rs=DBUtils.executeLAPSQuery("chk_comappcompany_div^"+strNewAppId);
			while(rs.next())
			{
				intcnt++;
				String COMAPP_DOCEXECUTANT=Helper.correctNull((String)rs.getString("COMAPP_DOCEXECUTANT"));
				String COMAPP_ACCOUNTOPERTED=Helper.correctNull((String)rs.getString("COMAPP_ACCOUNTOPERTED"));
				String COMAPP_DIVISIONTYPE=Helper.correctNull((String)rs.getString("COMAPP_DIVISIONTYPE")); 

			if(COMAPP_DOCEXECUTANT.equals("") || COMAPP_ACCOUNTOPERTED.equals("")||
			((Helper.correctNull((String)rs.getString("COMAPP_CHF_PROMOTER")).equalsIgnoreCase(""))&&
					(!(COMAPP_DIVISIONTYPE.equalsIgnoreCase("Group concern") || COMAPP_DIVISIONTYPE.equalsIgnoreCase("Sister concern")))))
				{
					strGroupManagement="N";
				}
			if (strConstitution.equalsIgnoreCase("09")&&(COMAPP_DIVISIONTYPE.equalsIgnoreCase("PT"))){

					strQuery = SQLParser.getSqlQuery("sel_partnerschk^"+ Helper.correctNull((String) rs.getString("COMAPP_CBSID")));
					rs1 = DBUtils.executeQuery(strQuery);
					if (rs1.next()) {
						
						if (Helper.correctNull((String) rs1.getString("COMINFO_MINORITY_COMMUNITY")).equalsIgnoreCase("")) {

							strGroupManagement="N";
						}
					}
				}
			}
			if(intcnt==0)
				strGroupManagement="N";
			if(rs !=null)
			{
				rs.close();
			}
			
			/*rs=DBUtils.executeLAPSQuery("getcustomerprofileemploymentstatus^"+id);
			if(rs.next())
			{
				strEmploymentDet=Helper.correctNull((String)rs.getString("peremp_pagestatus"));
			}*/
			
			/** Added by Dinesh for External Rating Page should be Mandatory on 20/02/2014 **/
			if(rs !=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("cusrating_sel^"+strNewAppId);	
			if(rs.next())
			{
				strRating=Helper.correctNull((String)rs.getString("rat_status"));
			}
			if(rs !=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("select_cusdefaulter^"+strNewAppId);	
			if(rs.next())
			{
				strDefaulter="Y";
			}
			int intSHGConstitution = Integer.parseInt(Helper.correctInt(strConstitution));
			int SHGMembers = 0,SHGMembersAvail=0;
			rs=DBUtils.executeLAPSQuery("getcustomerprofileshgstatus^"+strNewAppId);
			if(rs.next())
			{
				strSHGstatus="Y";
				SHGMembers = Integer.parseInt(Helper.correctInt((String)rs.getString("PERAPP_SHGMEMBER")));
				SHGMembersAvail = Integer.parseInt(Helper.correctInt((String)rs.getString("memb_count")));
			}
			if(rs !=null)
			{
				rs.close();
			}
			String strComDist="",strPermDist=""; 
			rs=DBUtils.executeLAPSQuery("sel_contactinfoProfilechk^"+strNewAppId);
			if(rs.next())
			{
				strComDist=Helper.correctNull((String)rs.getString("CON_COMDIST"));
				strPermDist=Helper.correctNull((String)rs.getString("CON_PERMDIST"));
				
				if(Helper.correctNull(rs.getString("CON_COMCITY")).equalsIgnoreCase("")||Helper.correctNull(rs.getString("CON_COMSTATE")).equalsIgnoreCase("")
						||Helper.correctNull(rs.getString("CON_PERMCITY")).equalsIgnoreCase("")||Helper.correctNull(rs.getString("CON_PERMSTATE")).equalsIgnoreCase(""))
				{
					strPermDist= "";
				}
			}
			
			
			if(strPerapplicant.equalsIgnoreCase("Y"))
			{
			if((strRating.equalsIgnoreCase("Y")))
			{
				if(strDefaulter.equalsIgnoreCase("Y"))
				{
					if((strContactInfo.equalsIgnoreCase("Y")))
					{
						if(!strComDist.equalsIgnoreCase("") && !strPermDist.equalsIgnoreCase(""))
						{
							if((strKYCNorms.equalsIgnoreCase("Y")))
							{
								if(!strEmployment.equalsIgnoreCase("10"))
								{
									if(strIncExpenses.equalsIgnoreCase("Y"))
									{
										/*
										 * For Employer Employment Page is mandatory for making customer profile to completed status
										 */
										if(strEmployment.equalsIgnoreCase("1") || strEmployment.equalsIgnoreCase("8"))
										{
											if(strEmploymentStatus.equalsIgnoreCase("Y"))
											{
												status="Y";
											}
											else
											{
												status="N";
												//strIncompletepage="Employment Details";
											}
										}
										else
										{
											status="Y";
										}
										/* if(!strEmployment.equalsIgnoreCase("10"))
										{
											if(strIncExpenses.equalsIgnoreCase("Y"))
											{
												status="Y";
											} else {
												status="N";
											}
										} else {
											status="Y";
										}*/
										if(strEmployment.equalsIgnoreCase("1") ||
											strEmployment.equalsIgnoreCase("9"))
										{
											if(strEmploymentStatus.equalsIgnoreCase("Y"))
											{
												status="Y";
											} else {
												status="N";
												strIncompletepage="Employment Details";
											}
										} else {
											status="Y";
										}
										
										if(strEmployment.equalsIgnoreCase("4"))
											{
												rs=DBUtils.executeLAPSQuery("agrlandholdingsselection^"+strNewAppId);
												if(rs.next())
												{
													status="Y";
												}
												else {
														status="N";
														strIncompletepage="Land Holdings";
													}
											} 
										if(intSHGConstitution>=183 && intSHGConstitution<=191)
										{
											if(!strSHGstatus.equalsIgnoreCase("Y"))
											{	
												status="N";
												strIncompletepage="SHG Details";
											}
											else
											{
												if(SHGMembers == SHGMembersAvail)
												{
													status="Y";
												}
												else
												{
													status="N";
													strIncompletepage="No. of SHG members Not tally";
												}
											}
										}
										else
										{
											if(intSHGConstitution!=01)
											{
												if(strGroupManagement.equalsIgnoreCase("N"))
												{
													status="N";
													strIncompletepage="Groups / Management Peoples";
												}
											}
										}
									}
									else{
										strIncompletepage="Income / Expenses";
									}
								}
								else
								{
									status="Y";
									
									if(intSHGConstitution>=183 && intSHGConstitution<=191)
									{
										if(!strSHGstatus.equalsIgnoreCase("Y"))
										{
											status="N";
											strIncompletepage="SHG Details";
										}
										else
										{
											if(SHGMembers == SHGMembersAvail)
											{
												status="Y";
											}
											else
											{
												status="N";
												strIncompletepage="No. of SHG members Not tally";
											}
										}
									}
								}
							}
							else{
								status="N";
								strIncompletepage="KYC Norms";
							}
						}
						else{
							status="N";
							strIncompletepage="Communication Details";
						}
					}
					else
					{
						status="N";
						strIncompletepage="Communication Details";
					}	
				}
				else
				{
					status="N";
					strIncompletepage="Defaulter";
				}	
			}
			else
			{
				status="N";
				strIncompletepage="Rating";
			}	
			}else
			{
				status="N";
				strIncompletepage="Demographics";
			}
			
			if(rs!=null)
			{
				rs.close();
			}
			if(!status.equals(""))
			{
				hshQuery.put("strQueryId","updcustomerprofilestatus");
				arrValues.add(status);	
				arrValues.add(strNewAppId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			hshResult.put("strIncompletepage", strIncompletepage);
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getCustomerProfileStatus:--"+e.getMessage());
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
				throw new EJBException("Error while Closing Connection in getCustomerProfileStatus:--"+e.getMessage());
			}
		}
		return hshResult;
	}
	
	private String custprofilegeneration(HashMap hshValues)
	{
		String strLapsId="";
		String strCBSId="";
		String strQuery="";
		String strMinorflag="N";
		String strTadefinance="";
		String strOccupation="";
		
		ArrayList arrValues=new ArrayList();
		
		ResultSet rs=null;
		
		HashMap hshQuery=new HashMap();
		HashMap hshQueryValues=new HashMap();
		
		int intUpdateSize=0;
		boolean boolflag=false;
		
		try{
			strCBSId=correctNull((String)hshValues.get("cbsid"));
			
			if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
			{
				strQuery=SQLParser.getCBSSqlQuery("getCBScustDetails^"+strCBSId);
				rs=DBUtils.executeQueryCBSConnection(strQuery);
			}
			else
			{
				strQuery=SQLParser.getSqlQuery("getCBScustDetails^"+strCBSId);
				rs=DBUtils.executeQuery(strQuery);
			}
		
			if(rs.next())
			{
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				intUpdateSize++;
				
				strMinorflag=correctNull(rs.getString("cust_minor_flg"));
				strTadefinance=correctNull(rs.getString("party_flg"));
				strOccupation=correctNull(rs.getString("cust_occp_code"));
				
				strLapsId=getApplicantCode();
				
				arrValues.add(strLapsId);
				arrValues.add(strLapsId);
				arrValues.add("N");
				arrValues.add(correctNull(rs.getString("cust_title_code")));
				arrValues.add(correctNull(rs.getString("cust_name")));
				arrValues.add(correctNull(rs.getString("cust_short_name")));
				arrValues.add(correctNull(rs.getString("pan_gir_num")));
				if(correctNull(rs.getString("address_type")).equalsIgnoreCase("C"))
				{
					arrValues.add(correctNull(rs.getString("cust_comu_addr1")));
					arrValues.add(correctNull(rs.getString("cust_comu_addr2")));
					arrValues.add("");
					arrValues.add(correctNull(rs.getString("cust_comu_city_code")));
					arrValues.add(correctNull(rs.getString("cust_comu_state_code")));
					arrValues.add(correctNull(rs.getString("cust_comu_pin_code")));
					arrValues.add(correctNull(rs.getString("cust_comu_cntry_code")));
					
				}
				else if(correctNull(rs.getString("address_type")).equalsIgnoreCase("P"))
				{
					arrValues.add(correctNull(rs.getString("cust_perm_addr1")));
					arrValues.add(correctNull(rs.getString("cust_perm_addr2")));
					arrValues.add("");
					arrValues.add(correctNull(rs.getString("cust_perm_city_code")));
					arrValues.add(correctNull(rs.getString("cust_perm_state_code")));
					arrValues.add(correctNull(rs.getString("cust_perm_pin_code")));
					arrValues.add(correctNull(rs.getString("cust_perm_cntry_code")));
				}
				else if(correctNull(rs.getString("address_type")).equalsIgnoreCase("E"))
				{
					arrValues.add(correctNull(rs.getString("cust_emp_addr1")));
					arrValues.add(correctNull(rs.getString("cust_emp_addr2")));
					arrValues.add("");
					arrValues.add(correctNull(rs.getString("cust_emp_city_code")));
					arrValues.add(correctNull(rs.getString("cust_emp_state_code")));
					arrValues.add(correctNull(rs.getString("cust_emp_pin_code")));
					arrValues.add(correctNull(rs.getString("cust_emp_cntry_code")));
				}
				arrValues.add(correctNull(rs.getString("cust_pager_no")));
				arrValues.add("");
				arrValues.add("");
				arrValues.add(correctNull(rs.getString("date_of_birth")));
				arrValues.add(correctNull(rs.getString("cust_marital_status")));
				arrValues.add(correctNull(rs.getString("cust_sex")));
				arrValues.add("0");
				arrValues.add("0");
				arrValues.add("0");
				arrValues.add("Y");
				arrValues.add("1");
				arrValues.add(correctNull(rs.getString("cust_perm_addr1")));
				arrValues.add(correctNull(rs.getString("cust_perm_addr2")));
				arrValues.add("");
				arrValues.add(correctNull(rs.getString("cust_perm_city_code")));
				arrValues.add(correctNull(rs.getString("cust_perm_state_code")));
				arrValues.add(correctNull(rs.getString("cust_perm_pin_code")));
				arrValues.add(correctNull(rs.getString("cust_perm_cntry_code")));
				arrValues.add(correctNull(rs.getString("cust_pager_no")));
				arrValues.add("");
				arrValues.add(correctNull(rs.getString("cust_commu_code")));
				arrValues.add("0");
				arrValues.add(correctNull(rs.getString("cust_first_acct_date")));
				arrValues.add("");
				arrValues.add("");
				arrValues.add("0");
				arrValues.add("");
				arrValues.add(correctNull(rs.getString("psprt_num")));
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("0");
				arrValues.add("1");

				arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
				arrValues.add("0");
				arrValues.add("");
				arrValues.add(correctNull(rs.getString("cust_nre_flg")));
				arrValues.add(correctNull(rs.getString("cust_caste_code")));
				//arrValues.add("");
				arrValues.add(correctNull(rs.getString("psprt_det")));
				arrValues.add(correctNull(rs.getString("psprt_exp_date")));
				arrValues.add(correctNull(rs.getString("psprt_issu_date")));
				arrValues.add("");
				arrValues.add("0");
				arrValues.add("2");
				arrValues.add("1");
				arrValues.add("2");
				arrValues.add("");
				//arrValues.add("");
				//arrValues.add("");
				//arrValues.add("");
				//arrValues.add("");
				//arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("0");
				arrValues.add(correctNull(rs.getString("cust_id")));
				arrValues.add("N");
				arrValues.add("N");
				arrValues.add("N");
				arrValues.add("N");
				arrValues.add(correctNull(rs.getString("cust_stat_code")));
				arrValues.add("N");
				arrValues.add("0");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("0");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add(correctNull(rs.getString("cust_const")));
				arrValues.add("");
				arrValues.add("");
				arrValues.add("0");
				arrValues.add("");//cin no
				arrValues.add("");
				boolflag=true;
				
				hshQuery.put("strQueryId","mastdemographicsins");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdateSize,hshQuery);
				hshQueryValues.put("size",""+intUpdateSize);
				
			}
			if(boolflag)
			{
				if(strMinorflag.equalsIgnoreCase("Y"))
				{
					strQuery=SQLParser.getSqlQuery("getCBSminorDetails^"+strCBSId);
					rs=DBUtils.executeQuery(strQuery);
					
					if(rs.next())
					{
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						intUpdateSize++;
						
						arrValues.add(strCBSId);
						arrValues.add("");
						arrValues.add("1");
						arrValues.add(strTadefinance.equals("Y")?"1":"2");
						arrValues.add("2");
						arrValues.add("MR");
						arrValues.add("");
						arrValues.add(correctNull(rs.getString("minor_guard_addr1"))+correctNull(rs.getString("minor_guard_addr2")));
						arrValues.add("A");
						arrValues.add(strLapsId);
						arrValues.add(correctNull(rs.getString("minor_guard_name")));
						
						hshQuery.put("strQueryId","addparameterinsval");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(""+intUpdateSize,hshQuery);
					}
					else
					{
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						intUpdateSize++;
						
						arrValues.add(strCBSId);
						arrValues.add("");
						arrValues.add("1");
						arrValues.add(strTadefinance.equals("Y")?"1":"2");
						arrValues.add("2");
						arrValues.add("MR");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("A");
						arrValues.add(strLapsId);
						arrValues.add("");
						
						hshQuery.put("strQueryId","addparameterinsval");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(""+intUpdateSize,hshQuery);
					}
					
				}
				else
				{
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					intUpdateSize++;
					
					arrValues.add(strCBSId);
					arrValues.add("");
					arrValues.add("2");
					arrValues.add(strTadefinance.equals("Y")?"1":"2");
					arrValues.add("2");
					arrValues.add("MR");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("A");
					arrValues.add(strLapsId);
					arrValues.add("");
					
					hshQuery.put("strQueryId","addparameterinsval");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdateSize,hshQuery);
				}
				strQuery=null;
				if(rs!=null)rs.close();
				
				strQuery=SQLParser.getSqlQuery("getCBSKYCDetails^"+strCBSId);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					intUpdateSize++;
					
					arrValues.add(strLapsId);//kyc_custid
					arrValues.add(correctNull(rs.getString("is_corporate")));//kyc_custtype
					arrValues.add(correctNull(rs.getString("cust_occp_code")));//kyc_occupation
					arrValues.add(correctNull(rs.getString("annual_income")));//kyc_annualincome
					arrValues.add(correctNull(rs.getString("cntry_of_residence")));//kyc_countryresi
					arrValues.add(correctNull(rs.getString("form_60_61")));//kyc_form
					arrValues.add(correctNull(rs.getString("form_60_61_ref_num")));//kyc_formrefno
					arrValues.add(correctNull(rs.getString("id_proof_type")));//kyc_idprooftype
					arrValues.add(correctNull(rs.getString("id_reference")));//kyc_idproofref
					arrValues.add(correctNull(rs.getString("res_proof_type")));//kyc_resiprooftype
					arrValues.add(correctNull(rs.getString("res_id_reference")));//kyc_resiidrefno
					arrValues.add(correctNull(rs.getString("src_of_income")));//kyc_sourceincome
					arrValues.add(correctNull(rs.getString("networth")));//kyc_networth
					arrValues.add(correctNull(rs.getString("annual_turnover")));//kyc_turnover
					arrValues.add(correctNull(rs.getString("annual_turnover_est")));//kyc_estiturnover
					arrValues.add(correctNull(rs.getString("pooled_acct")));//kyc_account
					arrValues.add(correctNull(rs.getString("acivity_type")));//kyc_activity
					arrValues.add(correctNull(rs.getString("ofac_unsan")));//kyc_ofac
					arrValues.add(correctNull(rs.getString("foreign_iw_remittance")));//kyc_remittance
					arrValues.add(correctNull(rs.getString("remit_cntry_code")));//kyc_remitcountry
					
					arrValues.add(correctNull(rs.getString("client_name_1")));//kyc_clientname_1
					arrValues.add(correctNull(rs.getString("client_location_1")));//kyc_clientlocation_1
					arrValues.add(correctNull(rs.getString("client_city_code_1")));//kyc_clientcitycode_1
					arrValues.add("");//kyc_clientstatecode_1
					arrValues.add(correctNull(rs.getString("client_cntry_code_1")));//kyc_clientcntrycode_1
					
					arrValues.add(correctNull(rs.getString("client_name_2")));//kyc_clientname_2
					arrValues.add(correctNull(rs.getString("client_location_2")));//kyc_clientlocation_2
					arrValues.add(correctNull(rs.getString("client_city_code_2")));//kyc_clientcitycode_2
					arrValues.add("");//kyc_clientstatecode_2
					arrValues.add(correctNull(rs.getString("client_cntry_code_2")));//kyc_clientcntrycode_2
					
					arrValues.add(correctNull(rs.getString("client_name_3")));//kyc_clientname_3
					arrValues.add(correctNull(rs.getString("client_location_3")));//kyc_clientlocation_3
					arrValues.add(correctNull(rs.getString("client_city_code_3")));//kyc_clientcitycode_3
					arrValues.add("");//kyc_clientstatecode_3
					arrValues.add(correctNull(rs.getString("client_cntry_code_3")));//kyc_clientcntrycode_3
					
					arrValues.add(correctNull(rs.getString("risk_categorization")));//kyc_risk
										
					arrValues.add(strOccupation);//kyc_risk

					arrValues.add(correctNull(rs.getString("sleeping_partner")));//kyc_sleeppartner
					arrValues.add(correctNull(rs.getString("political_exposed")));//kyc_politicalexposed
					arrValues.add(correctNull(rs.getString("family_share")));//kyc_familyshare
					
					hshQuery.put("strQueryId","ins_applKYCNorms");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdateSize,hshQuery);
				}
				if(intUpdateSize>0)
				{
					hshQueryValues.put("size",""+intUpdateSize);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
			
			}
		}
		catch(Exception ex)
		{
			throw new EJBException("Error in custprofilegeneration :: "+ex.toString());
		}
		return strLapsId;
	}

	
	public HashMap updateAddressDetails(HashMap hshValues) 
	{

		ResultSet rs = null;
		String strQuery=null;
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshRecord=new HashMap();
		ArrayList arrValues = new ArrayList();
		//String appno="1000";
		String hidDemoId=correctNull((String)hshValues.get("hidDemoId"));
		String  status="";
		
		if(!Helper.correctNull((String)hshValues.get("txtperapp_address1")).equalsIgnoreCase("")&&
				!Helper.correctNull((String)hshValues.get("txtperapp_address2")).equalsIgnoreCase("")&&
				!Helper.correctNull((String)hshValues.get("txtperapp_city")).equalsIgnoreCase("")&&
				!Helper.correctNull((String)hshValues.get("txtperapp_district")).equalsIgnoreCase("")&&
				!Helper.correctNull((String)hshValues.get("txtperapp_zip")).equalsIgnoreCase("")&&
				!Helper.correctNull((String)hshValues.get("hidperapp_country")).equalsIgnoreCase("")&&
				!Helper.correctNull((String)hshValues.get("sel_residence")).equalsIgnoreCase("")&&
				!Helper.correctNull((String)hshValues.get("txtperapp_noyears")).equalsIgnoreCase(""))
		{
			status="Y";
		}
		else
		{
			status="N";
		}
		StringBuilder strActionData=new StringBuilder();
		StringBuilder sbOldAudit = new StringBuilder();
		try
		{
			String strAction = correctNull((String)hshValues.get("hidAction"));
			
			String txtperapp_address1=Helper.correctNull((String)hshValues.get("txtperapp_address1"));
			String txtperapp_permadd1 =Helper.correctNull((String)hshValues.get("txtperapp_permadd1"));
			String txtperapp_adminadd1=Helper.correctNull((String)hshValues.get("txtperapp_adminadd1"));
			
			String txtperapp_address2=Helper.correctNull((String)hshValues.get("txtperapp_address2"));
			String txtperapp_permadd2 =Helper.correctNull((String)hshValues.get("txtperapp_permadd2"));
			String txtperapp_adminadd2=Helper.correctNull((String)hshValues.get("txtperapp_adminadd2"));
			
			String txtperapp_address3=Helper.correctNull((String)hshValues.get("txtperapp_address3"));
			String txtperapp_permadd3 =Helper.correctNull((String)hshValues.get("txtperapp_permadd3"));
			String txtperapp_adminadd3=Helper.correctNull((String)hshValues.get("txtperapp_adminadd3"));
			
			String txtperapp_city=Helper.correctNull((String)hshValues.get("txtperapp_city"));
			String txtperapp_permcity =Helper.correctNull((String)hshValues.get("txtperapp_permcity"));
			String txtperapp_admincity=Helper.correctNull((String)hshValues.get("txtperapp_admincity"));
			
			String txtperapp_district=Helper.correctNull((String)hshValues.get("txtperapp_district"));
			String txtperapp_permdistrict =Helper.correctNull((String)hshValues.get("txtperapp_permdistrict"));
			String txtperapp_noyears=Helper.correctNull((String)hshValues.get("txtperapp_noyears"));
			String txtperapp_admindistrict=Helper.correctNull((String)hshValues.get("txtperapp_admindistrict"));
			
			String txtperapp_state=Helper.correctNull((String)hshValues.get("txtperapp_state"));
			String txtperapp_permstate =Helper.correctNull((String)hshValues.get("txtperapp_permstate"));
			String txtperapp_adminstate=Helper.correctNull((String)hshValues.get("txtperapp_adminstate"));
			
			String txtperapp_zip=Helper.correctNull((String)hshValues.get("txtperapp_zip"));
			String txtperapp_permzip =Helper.correctNull((String)hshValues.get("txtperapp_permzip"));
			String txtperapp_adminzip=Helper.correctNull((String)hshValues.get("txtperapp_adminzip"));
			
			String txtperapp_country=Helper.correctNull((String)hshValues.get("hidperapp_country"));
			String txtperapp_permcountry =Helper.correctNull((String)hshValues.get("hidperapp_permcountry"));
			String txtperapp_admincountry=Helper.correctNull((String)hshValues.get("hidperapp_admincountry"));
			
			String txtperapp_phone=Helper.correctNull((String)hshValues.get("txtperapp_phone"));
			String txtperapp_permphone =Helper.correctNull((String)hshValues.get("txtperapp_permphone"));
			String txtperapp_adminphone=Helper.correctNull((String)hshValues.get("txtperapp_adminphone"));
			
			String txtperapp_fax=Helper.correctNull((String)hshValues.get("txtperapp_fax"));
			String txtperapp_permfax =Helper.correctNull((String)hshValues.get("txtperapp_permfax"));
			String txtperapp_adminfax=Helper.correctNull((String)hshValues.get("txtperapp_adminfax"));
			
			String txtperapp_mobile=Helper.correctNull((String)hshValues.get("txtperapp_mobile"));
			String txtperapp_email =Helper.correctNull((String)hshValues.get("txtperapp_email"));
			String txtperapp_website=Helper.correctNull((String)hshValues.get("txtperapp_website"));
			String sel_residence=Helper.correctNull((String)hshValues.get("sel_residence"));
			String chk_commaddress=Helper.correctNull((String)hshValues.get("chk_commaddress"));
			String chk_offaddress=Helper.correctNull((String)hshValues.get("chk_offaddress"));
			String txtperapp_peremail =Helper.correctNull((String)hshValues.get("txtperapp_peremail"));
			String txtperapp_phoneoff =Helper.correctNull((String)hshValues.get("txtperapp_phoneoff"));
			
			/***
			 * For Audit Trial Old Data - By Karthikeyan.S on 13/09/2013
			 */
			
			strQuery=SQLParser.getSqlQuery("sel_customerdetail^"+hidDemoId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				String strCityCode=Helper.correctNull((String)rs.getString("con_comcity"));
				String strDistCode=Helper.correctNull((String)rs.getString("con_comdist"));
				String strStateCode=Helper.correctNull((String)rs.getString("con_comstate"));
				String strPermCityCode=Helper.correctNull((String)rs.getString("con_permcity"));
				String strPermDistCode=Helper.correctNull((String)rs.getString("con_permdist"));
				String strPermStateCode=Helper.correctNull((String)rs.getString("con_permstate"));
				String strRegCityCode=Helper.correctNull((String)rs.getString("con_admcity"));
				String strRegDistCode=Helper.correctNull((String)rs.getString("con_admdist"));
				String strRegStateCode=Helper.correctNull((String)rs.getString("con_admstate"));
				String strCityDesc=getCityDistrictStateDesc("city",strCityCode);
				String strDistDesc=getCityDistrictStateDesc("district",strDistCode);
				String strStateDesc=getCityDistrictStateDesc("state",strStateCode);
				String strPermCityDesc=getCityDistrictStateDesc("city",strPermCityCode);
				String strPermDistDesc=getCityDistrictStateDesc("district",strPermDistCode);
				String strPermStateDesc=getCityDistrictStateDesc("state",strPermStateCode);
				String strRegCityDesc=getCityDistrictStateDesc("city",strRegCityCode);
				String strRegDistDesc=getCityDistrictStateDesc("district",strRegDistCode);
				String strRegStateDesc=getCityDistrictStateDesc("state",strRegStateCode);
				String strResidenceOldAudit=Helper.correctNull((String)rs.getString("con_restype"));
				String strResidenceDescOldAudit="";
				if(strResidenceOldAudit.equalsIgnoreCase("1"))
				{
					strResidenceDescOldAudit="Rented";
				}
				else if(strResidenceOldAudit.equalsIgnoreCase("2"))
				{
					strResidenceDescOldAudit="Owned";
				}
				else if(strResidenceOldAudit.equalsIgnoreCase("3"))
				{
					strResidenceDescOldAudit="Leased";
				}
				else if(strResidenceOldAudit.equalsIgnoreCase("4"))
				{
					strResidenceDescOldAudit="Family";
				}
				else if(strResidenceOldAudit.equalsIgnoreCase("5"))
				{
					strResidenceDescOldAudit="Employer";
				}
				
				sbOldAudit.append("~Address=").append(Helper.correctNull((String)rs.getString("con_comaddr1")))
				.append(",").append(Helper.correctNull((String)rs.getString("con_comaddr2")))
				.append("~Village/Taluk=").append(Helper.correctNull((String)rs.getString("con_comvillage")))
				.append("~City=").append(strCityDesc)
				.append("~District=").append(strDistDesc)
				.append("~State=").append(strStateDesc)
				.append("~Pin Code=").append(Helper.correctNull((String)rs.getString("con_comzip")))
				.append("~Country=").append(Helper.correctNull((String)rs.getString("con_comcountry")))
				.append("~Phone No (Res)=").append(Helper.correctNull((String)rs.getString("con_comphone")))
				.append("~Phone No (Off)=").append(Helper.correctNull((String)rs.getString("con_comphone1")))
				.append("~Fax No=").append(Helper.correctNull((String)rs.getString("con_comfax")))
				.append("~Mobile No=").append(Helper.correctNull((String)rs.getString("con_mobile")))
				.append("~Resident Type=").append(strResidenceDescOldAudit)
				.append("~No of years in Present Address=").append(Helper.correctNull((String)rs.getString("con_years")))
				.append("~E-Mail=").append(Helper.correctNull((String)rs.getString("con_email")))
				.append("~Permanent Address=").append(Helper.correctNull((String)rs.getString("con_permaddr1")))
				.append(",").append(Helper.correctNull((String)rs.getString("con_permaddr2")))
				.append("~Perm. Village/Taluk=").append(Helper.correctNull((String)rs.getString("con_permvillage")))
				.append("~Perm. City=").append(strPermCityDesc)
				.append("~Perm. District=").append(strPermDistDesc)
				.append("~Perm. State=").append(strPermStateDesc)
				.append("~Perm. Pin Code=").append(Helper.correctNull((String)rs.getString("con_permzip")))
				.append("~Perm. Country=").append(Helper.correctNull((String)rs.getString("con_permcountry")))
				.append("~Perm. Phone=").append(Helper.correctNull((String)rs.getString("con_permphone")))
				.append("~Perm. Fax No=").append(Helper.correctNull((String)rs.getString("con_permfax")))
				.append("~Website=").append(Helper.correctNull((String)rs.getString("con_website")))
				.append("~Perm. E-Mail=").append(Helper.correctNull((String)rs.getString("con_peremail")))
				.append("~Registered Address=").append(Helper.correctNull((String)rs.getString("con_admaddr1")))
				.append(",").append(Helper.correctNull((String)rs.getString("con_admaddr2")))
				.append("~Reg. Village/Taluk/Town=").append(Helper.correctNull((String)rs.getString("con_admvillage")))
				.append("~Reg. City=").append(strRegCityDesc)
				.append("~Reg. District=").append(strRegDistDesc)
				.append("~Reg. State=").append(strRegStateDesc)
				.append("~Reg. Pin Code=").append(Helper.correctNull((String)rs.getString("con_admzip")))
				.append("~Reg. Country=").append(Helper.correctNull((String)rs.getString("con_admcountry")))
				.append("~Reg. Phone No=").append(Helper.correctNull((String)rs.getString("con_admphone")))
				.append("~Reg. Fax No=").append(Helper.correctNull((String)rs.getString("con_admfax")));

			}
			if(rs!=null)
			{
				rs.close();
			}
			/***
			 * End - Audit Trial Old Data
			 */
			
			if(strAction.equalsIgnoreCase("update"))
			{
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(correctNull((String)hshValues.get("hidDemoId")));
				hshQuery.put("arrValues", arrValues);				
				hshQuery.put("strQueryId", "del_customerdetail");
				hshQuery.put("size","1");
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				
				
				hshQuery.put("strQueryId","ins_customerdetail");
			
				arrValues = new ArrayList();
				
				arrValues.add(correctNull((String)hshValues.get("hidDemoId")));//0
				arrValues.add(Helper.correctNull((String)hshValues.get("txtperapp_address1")));//1
				arrValues.add(Helper.correctNull((String)hshValues.get("txtperapp_address2")));//2
				arrValues.add(Helper.correctNull((String)hshValues.get("txtperapp_address3")));//3
				
				arrValues.add(Helper.correctNull((String)hshValues.get("hidperapp_city")));//4
				arrValues.add(Helper.correctNull((String)hshValues.get("hidperapp_dist")));//5
				arrValues.add(Helper.correctNull((String)hshValues.get("hidperapp_state")));//6
				
				arrValues.add(Helper.correctNull((String)hshValues.get("txtperapp_zip")));//7
				arrValues.add(Helper.correctNull((String)hshValues.get("hidperapp_country")));//8
				arrValues.add(Helper.correctNull((String)hshValues.get("txtperapp_phone")));//9
				
				arrValues.add(Helper.correctNull((String)hshValues.get("txtperapp_fax")));//10
				arrValues.add(Helper.correctNull((String)hshValues.get("txtperapp_mobile")));//11
				arrValues.add(Helper.correctNull((String)hshValues.get("txtperapp_website")));//12
				
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_residence")));//13
				arrValues.add(Helper.correctInt((String)hshValues.get("txtperapp_noyears"))+"~"+Helper.correctInt((String)hshValues.get("txtperapp_nomonth")));//15
				arrValues.add(Helper.correctNull((String)hshValues.get("txtperapp_email")));//14
			
				arrValues.add(Helper.correctNull((String)hshValues.get("txtperapp_permadd1")));//16
				
				arrValues.add(Helper.correctNull((String)hshValues.get("txtperapp_permadd2")));//17
				arrValues.add(Helper.correctNull((String)hshValues.get("txtperapp_permadd3")));//18
				arrValues.add(Helper.correctNull((String)hshValues.get("hidperapp_permcity")));//19
				
				arrValues.add(Helper.correctNull((String)hshValues.get("hidperapp_permdist")));//20
				arrValues.add(Helper.correctNull((String)hshValues.get("hidperapp_permstate")));//21
				arrValues.add(Helper.correctNull((String)hshValues.get("txtperapp_permzip")));//22
				
				arrValues.add(Helper.correctNull((String)hshValues.get("hidperapp_permcountry")));//23
				arrValues.add(Helper.correctNull((String)hshValues.get("txtperapp_permphone")));//24
				arrValues.add(Helper.correctNull((String)hshValues.get("txtperapp_permfax")));//25
				
				arrValues.add(Helper.correctNull((String)hshValues.get("txtperapp_adminadd1")));//26
				arrValues.add(Helper.correctNull((String)hshValues.get("txtperapp_adminadd2")));//27
				arrValues.add(Helper.correctNull((String)hshValues.get("txtperapp_adminadd3")));//28
				
				arrValues.add(Helper.correctNull((String)hshValues.get("hidperapp_admincity")));//29
				arrValues.add(Helper.correctNull((String)hshValues.get("hidperapp_admindist")));//30
				arrValues.add(Helper.correctNull((String)hshValues.get("hidperapp_adminstate")));//31
				
				arrValues.add(Helper.correctNull((String)hshValues.get("txtperapp_adminzip")));//32
				arrValues.add(Helper.correctNull((String)hshValues.get("hidperapp_admincountry")));//33
				arrValues.add(Helper.correctNull((String)hshValues.get("txtperapp_adminphone")));//34
				
				arrValues.add(Helper.correctNull((String)hshValues.get("txtperapp_adminfax")));//35
				arrValues.add(Helper.correctNull((String)hshValues.get("chk_offaddress")));//36
				arrValues.add(Helper.correctNull((String)hshValues.get("chk_offaddress1")));//37
				arrValues.add(status);//38
				arrValues.add(Helper.correctNull((String)hshValues.get("txtperapp_peremail")));//39
				arrValues.add(Helper.correctNull((String)hshValues.get("txtperapp_phoneoff")));//40
				
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("size","1");
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			}
			
			/***
			 * For Audit Trial New Data - By Karthikeyan.S on 13/09/2013
			 */
			String strResidence=Helper.correctNull((String)hshValues.get("sel_residence"));
			String strResidenceDesc="";
			if(strResidence.equalsIgnoreCase("1"))
			{
				strResidenceDesc="Rented";
			}
			else if(strResidence.equalsIgnoreCase("2"))
			{
				strResidenceDesc="Owned";
			}
			else if(strResidence.equalsIgnoreCase("3"))
			{
				strResidenceDesc="Leased";
			}
			else if(strResidence.equalsIgnoreCase("4"))
			{
				strResidenceDesc="Family";
			}
			else if(strResidence.equalsIgnoreCase("5"))
			{
				strResidenceDesc="Employer";
			}
			
			strActionData.append("~Address=").append(Helper.correctNull((String)hshValues.get("txtperapp_address1")))
			.append(",").append(Helper.correctNull((String)hshValues.get("txtperapp_address2")))
			.append("~Village/Taluk=").append(Helper.correctNull((String)hshValues.get("txtperapp_address3")))
			.append("~City=").append(txtperapp_city)
			.append("~District=").append(txtperapp_district)
			.append("~State=").append(txtperapp_state)
			.append("~Pin Code=").append(Helper.correctNull((String)hshValues.get("txtperapp_zip")))
			.append("~Country=").append(Helper.correctNull((String)hshValues.get("txtperapp_country")))
			.append("~Phone No (Res)=").append(Helper.correctNull((String)hshValues.get("txtperapp_phone")))
			.append("~Phone No (Off)=").append(Helper.correctNull((String)hshValues.get("txtperapp_phoneoff")))
			.append("~Fax No=").append(Helper.correctNull((String)hshValues.get("txtperapp_fax")))
			.append("~Mobile No=").append(Helper.correctNull((String)hshValues.get("txtperapp_mobile")))
			.append("~Resident Type=").append(strResidenceDesc)
			.append("~No of years in Present Address=").append(Helper.correctInt((String)hshValues.get("txtperapp_noyears")))
			.append("~E-Mail=").append(Helper.correctNull((String)hshValues.get("txtperapp_email")))
			.append("~Permanent Address=").append(Helper.correctNull((String)hshValues.get("txtperapp_permadd1")))
			.append(",").append(Helper.correctNull((String)hshValues.get("txtperapp_permadd2")))
			.append("~Perm. Village/Taluk=").append(Helper.correctNull((String)hshValues.get("txtperapp_permadd3")))
			.append("~perm. City=").append(txtperapp_permcity)
			.append("~Perm. District=").append(txtperapp_permdistrict)
			.append("~Perm. State=").append(txtperapp_permstate)
			.append("~Perm. Pin Code=").append(Helper.correctNull((String)hshValues.get("txtperapp_permzip")))
			.append("~Perm. Country=").append(Helper.correctNull((String)hshValues.get("txtperapp_permcountry")))
			.append("~Perm. Phone=").append(Helper.correctNull((String)hshValues.get("txtperapp_permphone")))
			.append("~Perm. Fax No=").append(Helper.correctNull((String)hshValues.get("txtperapp_permfax")))
			.append("~Website=").append(Helper.correctNull((String)hshValues.get("txtperapp_website")))
			.append("~Perm. E-Mail=").append(Helper.correctNull((String)hshValues.get("txtperapp_peremail")))
			.append("~Registered Address=").append(Helper.correctNull((String)hshValues.get("txtperapp_adminadd1")))
			.append(",").append(Helper.correctNull((String)hshValues.get("txtperapp_adminadd2")))
			.append("~Reg. Village/Taluk/Town=").append(Helper.correctNull((String)hshValues.get("txtperapp_adminadd3")))
			.append("~Reg. City=").append(txtperapp_admincity)
			.append("~Reg. District=").append(txtperapp_admindistrict)
			.append("~Reg. State=").append(txtperapp_adminstate)
			.append("~Reg. Pin Code=").append(Helper.correctNull((String)hshValues.get("txtperapp_adminzip")))
			.append("~Reg. Country=").append(Helper.correctNull((String)hshValues.get("txtperapp_admincountry")))
			.append("~Reg. Phone No=").append(Helper.correctNull((String)hshValues.get("txtperapp_adminphone")))
			.append("~Reg. Fax No=").append(Helper.correctNull((String)hshValues.get("txtperapp_adminfax")));

			
			AuditTrial.auditNewLog(hshValues, "205", hidDemoId, strActionData.toString(), sbOldAudit.toString());
			
			/***
			 * End - Audit Trial New Data
			 */
			
			hshRecord=getAddressDetails(hshValues);
		}
		
				catch(Exception ce)
				{
					throw new EJBException("Error in updateData "+ce.toString());
				}
				
		return hshRecord;
	}
	
	public HashMap getAddressDetails(HashMap hshValues)
	{
		ResultSet rs = null;
		String strQuery=null;
		String strQuery1=null;
		ResultSet rs1=null;
		String strcustid=null;
		String strAppStatus="";
		String strCBSID="";
		HashMap hshResult = new HashMap();
		strcustid=Helper.correctNull((String)hshValues.get("hidDemoId"));
		String strCitycode = "";
		String strDistcode = "";
		String strStatecode = "";		
		String strPermcitycode = "";	
		String strPermDistcode = "";
		String strPermstatecode = "";		
		String strAdmcitycode = "";
		String strAdmDistcode = "";
		String strAdmstatecode = "";
		String strCountryCode="";
		String strPermCountryCode="";
		String strAdmCountryCode="";
		String strFacname="";
		
		strAppStatus=Helper.correctNull((String)hshValues.get("hidappstatus"));
		
		if(strcustid.equalsIgnoreCase("") || strcustid.equalsIgnoreCase("null")){
			strcustid=Helper.correctNull((String)hshValues.get("hidapplicantnewid"));
		}
		try{
			
			strQuery1=SQLParser.getSqlQuery("getconstitutionfromdemographic^"+strcustid);
			rs1=DBUtils.executeQuery(strQuery1);
			if(rs1.next())
			{
				hshResult.put("app_constitution",correctNull(rs1.getString("PERAPP_CONSTITUTION")));
				hshResult.put("app_constitutiondesc",correctNull(rs1.getString("description")));
			}
		
			//appno=Helper.correctNull((String)hshValues.get("appno"));
			
		strQuery=SQLParser.getSqlQuery("sel_customerdetail^"+strcustid);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{  	
		//hshValues.put("appno",correctNull(rs.getString("app_no")));//
		hshResult.put("custid",correctNull(rs.getString("CON_APPID")));
		hshResult.put("txtperapp_address1",correctNull(rs.getString("CON_COMADDR1")));
		hshResult.put("txtperapp_address2",correctNull(rs.getString("CON_COMADDR2")));
		hshResult.put("txtperapp_address3",correctNull(rs.getString("CON_COMVILLAGE")));
		hshResult.put("txtperapp_district_code",correctNull(rs.getString("CON_COMDIST")));
		strDistcode = Helper.correctNull(rs.getString("CON_COMDIST"));
		strCitycode = Helper.correctNull(rs.getString("CON_COMCITY"));
		strStatecode = Helper.correctNull(rs.getString("CON_COMSTATE"));
		hshResult.put("perapp_city",correctNull(rs.getString("CON_COMCITY")));
		hshResult.put("perapp_state",correctNull(rs.getString("CON_COMSTATE")));		
		hshResult.put("txtperapp_zip",correctNull(rs.getString("CON_COMZIP")));
		strCountryCode=Helper.correctNull(rs.getString("CON_COMCOUNTRY"));
		//hshResult.put("txtperapp_country",correctNull(rs.getString("CON_COMCOUNTRY")));				
		hshResult.put("txtperapp_phone",correctNull(rs.getString("CON_COMPHONE")));//
		hshResult.put("txtperapp_fax",correctNull(rs.getString("CON_COMFAX")));
		hshResult.put("txtperapp_mobile",correctNull(rs.getString("CON_MOBILE")));
		hshResult.put("txtperapp_website",correctNull(rs.getString("CON_WEBSITE")));
		hshResult.put("sel_residence",correctNull(rs.getString("CON_RESTYPE")));
		hshResult.put("txtperapp_noyears",correctNull(rs.getString("CON_YEARS")));
		hshResult.put("txtperapp_email",correctNull(rs.getString("CON_EMAIL")));		
		hshResult.put("txtperapp_permadd1",correctNull(rs.getString("CON_PERMADDR1")));
		hshResult.put("txtperapp_permadd2",correctNull(rs.getString("CON_PERMADDR2")));
		hshResult.put("txtperapp_permadd3",correctNull(rs.getString("CON_PERMVILLAGE")));
		hshResult.put("txtperapp_permdistrict_code",correctNull(rs.getString("CON_PERMDIST")));	
		hshResult.put("perapp_permcity",correctNull(rs.getString("CON_PERMCITY")));
		hshResult.put("perapp_permstate",correctNull(rs.getString("CON_PERMSTATE")));
		strPermDistcode = Helper.correctNull(rs.getString("CON_PERMDIST"));
		strPermcitycode = Helper.correctNull(rs.getString("CON_PERMCITY"));
		strPermstatecode = Helper.correctNull(rs.getString("CON_PERMSTATE"));
		hshResult.put("txtperapp_permzip",correctNull(rs.getString("CON_PERMZIP")));
		strPermCountryCode=Helper.correctNull(rs.getString("CON_PERMCOUNTRY"));
		//hshResult.put("txtperapp_permcountry",correctNull(rs.getString("CON_PERMCOUNTRY")));
		hshResult.put("txtperapp_permphone",correctNull(rs.getString("CON_PERMPHONE")));
		hshResult.put("txtperapp_permfax",correctNull(rs.getString("CON_PERMFAX")));		
		hshResult.put("txtperapp_adminadd1",correctNull(rs.getString("CON_ADMADDR1")));
		hshResult.put("txtperapp_adminadd2",correctNull(rs.getString("CON_ADMADDR2")));//
		hshResult.put("txtperapp_adminadd3",correctNull(rs.getString("CON_ADMVILLAGE")));
		hshResult.put("txtperapp_admindistrict_code",correctNull(rs.getString("CON_ADMDIST")));
		hshResult.put("perapp_admincity",correctNull(rs.getString("CON_ADMCITY")));
		hshResult.put("perapp_adminstate",correctNull(rs.getString("CON_ADMSTATE")));	
		strAdmDistcode = Helper.correctNull(rs.getString("CON_ADMDIST"));
		strAdmcitycode = Helper.correctNull(rs.getString("CON_ADMCITY"));
		strAdmstatecode = Helper.correctNull(rs.getString("CON_ADMSTATE"));		
		hshResult.put("txtperapp_adminzip",correctNull(rs.getString("CON_ADMZIP")));
		strAdmCountryCode=Helper.correctNull(rs.getString("CON_ADMCOUNTRY"));
		//hshResult.put("txtperapp_admincountry",correctNull(rs.getString("CON_ADMCOUNTRY")));
		hshResult.put("txtperapp_adminphone",correctNull(rs.getString("CON_ADMPHONE")));
		hshResult.put("txtperapp_adminfax",correctNull(rs.getString("CON_ADMFAX")));
		hshResult.put("chk_offaddress",correctNull(rs.getString("CON_PERMIS")));
		hshResult.put("chk_offaddress1",correctNull(rs.getString("CON_ADMIS")));
		hshResult.put("txtperapp_phoneoff",correctNull(rs.getString("con_comphone1")));
		hshResult.put("txtperapp_peremail",correctNull(rs.getString("con_peremail")));	
		hshResult.put("strResidentstatus",correctNull(rs.getString("indinfo_resident_status")));
		}
		
		if(!Helper.correctNull((String)hshValues.get("strPageType")).equalsIgnoreCase("annexure"))
		{
			HashMap prof=new HashMap();
			HashMap profile=new HashMap();
			prof.put("profile_id",strcustid);
			profile=(HashMap)getCustomerProfileStatus(prof);
			hshResult.put("strIncompletepage", Helper.correctNull((String)profile.get("strIncompletepage")));
		}

		String strProfilestatus="";
		if(rs!=null)
		{
			rs.close();
		}
		rs=DBUtils.executeLAPSQuery("getprofilestatusfromdemographic^"+strcustid);
		if(rs.next())
		{
			strProfilestatus=Helper.correctNull((String)rs.getString("perapp_profilestatus"));
			strCBSID=Helper.correctNull((String)rs.getString("perapp_cbsid"));
		}
		
		//Added by Arsath for getting Registered City,District & State Name
		if(!strStatecode.equals(""))
		{
		if(rs!=null)
		{
			rs.close();
		}
		rs=DBUtils.executeLAPSQuery("sel_statenamebycode^"+strStatecode);
		if(rs.next())
		{
			hshResult.put("txtperapp_state",correctNull(rs.getString("state_name")));
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
			hshResult.put("txtperapp_district",correctNull(rs.getString("district_desc")));
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
			hshResult.put("txtperapp_city",correctNull(rs.getString("city_name")));
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
			hshResult.put("txtperapp_country",correctNull(rs.getString("con_country")));
			hshResult.put("txtperapp_countrycode",strCountryCode);	
		}
		}
		
		//Added by Arsath for getting Corporate City & State Name
		if(!strPermstatecode.equals(""))
		{
		if(rs!=null)
		{
			rs.close();
		}
		rs=DBUtils.executeLAPSQuery("sel_statenamebycode^"+strPermstatecode);
		if(rs.next())
		{
			hshResult.put("txtperapp_permstate",correctNull(rs.getString("state_name")));
		}
		}		
		
		if(!strPermDistcode.equals(""))
		{
		if(rs!=null)
		{
			rs.close();
		}
		rs=DBUtils.executeLAPSQuery("sel_distnamebycode^"+strPermDistcode);
		if(rs.next())
		{
			hshResult.put("txtperapp_permdistrict",correctNull(rs.getString("district_desc")));
		}
		}		
		if(!strPermcitycode.equals(""))
		{
		if(rs!=null)
		{
			rs.close();
		}
		rs=DBUtils.executeLAPSQuery("sel_citynamebycode^"+strPermcitycode);
		if(rs.next())
		{
			hshResult.put("txtperapp_permcity",correctNull(rs.getString("city_name")));
		}	
		}
		if(!strPermCountryCode.equals(""))
		{
		if(rs!=null)
		{
			rs.close();
		}
		rs=DBUtils.executeLAPSQuery("sel_countrynamebycode^"+strPermCountryCode);
		if(rs.next())
		{
			hshResult.put("txtperapp_permcountry",correctNull(rs.getString("con_country")));
			hshResult.put("txtperapp_permcountrycode",strPermCountryCode);
		}	
		}
		
		//Added by Arsath for getting Administrative City & State Name
		if(!strAdmstatecode.equals(""))
		{
		if(rs!=null)
		{
			rs.close();
		}
		rs=DBUtils.executeLAPSQuery("sel_statenamebycode^"+strAdmstatecode);
		if(rs.next())
		{
			hshResult.put("txtperapp_adminstate",correctNull(rs.getString("state_name")));
		}
		}		
		if(!strAdmDistcode.equals(""))
		{
		if(rs!=null)
		{
			rs.close();
		}
		rs=DBUtils.executeLAPSQuery("sel_distnamebycode^"+strAdmDistcode);
		if(rs.next())
		{
			hshResult.put("txtperapp_admindistrict",correctNull(rs.getString("district_desc")));
		}
		}		
		
		if(!strAdmcitycode.equals(""))
		{
		if(rs!=null)
		{
			rs.close();
		}
		rs=DBUtils.executeLAPSQuery("sel_citynamebycode^"+strAdmcitycode);
		if(rs.next())
		{
			hshResult.put("txtperapp_admincity",correctNull(rs.getString("city_name")));
		}	
		}
		if(!strAdmCountryCode.equals(""))
		{
		if(rs!=null)
		{
			rs.close();
		}
		rs=DBUtils.executeLAPSQuery("sel_countrynamebycode^"+strAdmCountryCode);
		if(rs.next())
		{
			hshResult.put("txtperapp_admincountry",correctNull(rs.getString("con_country")));
			hshResult.put("txtperapp_admincode",strAdmCountryCode);
		}	
		}
		if(rs!=null)
		{
			rs.close();
		}
		rs=DBUtils.executeLAPSQuery("perconstbankingsel^"+strcustid);
		if(rs.next())
		{
			strFacname=Helper.correctNull((String)rs.getString("cus_facname"));
		}
		hshResult.put("strFacname",strFacname);
		hshResult.put("strProfilestatus",strProfilestatus);
		hshResult.put("appstatus", strAppStatus);
		hshResult.put("strCBSID", strCBSID);
		
		}
	catch(Exception e){
		throw new EJBException("Error in updateData "+e.toString());
	}
		
		return hshResult;

	}	
	

	
	public HashMap updateRating(HashMap hshValues) 
	{
		HashMap hshRec=new HashMap();		
		ArrayList arrValues = new ArrayList();
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		String strApplntid=correctNull((String)hshValues.get("txtperapp_appid"));
		//String strApplntid="100";
		
		String strhidAction=correctNull((String)hshValues.get("hidAction"));

		StringBuilder sbAuditTrial=new StringBuilder();
		String strFromPage=correctNull((String)hshValues.get("hidFromPage"));
		ResultSet rs=null;
		String strQuery="";
		StringBuilder strActionData=new StringBuilder();
		StringBuilder sbOldAudit = new StringBuilder();
		String strRatingType =Helper.correctNull((String) hshValues.get("sel_RatingType"));
		try
		{
			if(strRatingType.equalsIgnoreCase("2"))
			{
				if(strhidAction.equalsIgnoreCase("delete"))
				{
					hshQueryValues = new HashMap();
					hshQueryValues.put("size","1");
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					arrValues.add(strApplntid);				
					hshQuery.put("arrValues", arrValues);				
					hshQuery.put("strQueryId", "cusrating_del");
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					hshQueryValues = new HashMap();
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId", "cusratingnew_delall");
					arrValues.add(strApplntid);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				
				if(strhidAction.trim().equalsIgnoreCase("update") || strhidAction.trim().equalsIgnoreCase("insert"))
				{
					hshQueryValues = new HashMap();
					hshQueryValues.put("size","1");
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					arrValues.add(strApplntid);				
					hshQuery.put("arrValues", arrValues);				
					hshQuery.put("strQueryId", "cusrating_del");
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					hshQueryValues = new HashMap();
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId", "cusratingnew_delall");
					arrValues.add(strApplntid);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					hshQueryValues = new HashMap();
					hshQueryValues.put("size","1");
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					arrValues.add(strApplntid);
					arrValues.add(strRatingType);
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("Y");				
					hshQuery.put("arrValues", arrValues);				
					hshQuery.put("strQueryId", "cusrating_ins");
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
			}
			else if(strRatingType.equalsIgnoreCase("1"))
			{
				if(strhidAction.equalsIgnoreCase("delete"))
				{
					hshQueryValues = new HashMap();
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId", "cusratingnew_del");
					arrValues.add(strApplntid);
					arrValues.add(Helper.correctNull((String)hshValues.get("hidSno")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				if(strhidAction.equalsIgnoreCase("insert"))
				{
					String strMaxno = "";
					String strQuery12 = SQLParser.getSqlQuery("sel_maxratingsno^"+strApplntid);
					ResultSet rs12 = DBUtils.executeQuery(strQuery12);
					if(rs12.next())
					{
						strMaxno = Helper.correctNull((String)rs12.getString("maxsno"));
					}
					hshQueryValues = new HashMap();
					hshQueryValues.put("size","1");
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					arrValues.add(strApplntid);
					arrValues.add(strMaxno);
					arrValues.add(correctNull((String) hshValues.get("txt_pre_agency")));
					arrValues.add(correctNull((String) hshValues.get("txt_ratinddate")));
					arrValues.add(correctNull((String) hshValues.get("txt_facrated_parti")));
					arrValues.add(correctNull((String) hshValues.get("txt_amt_rated")));
					arrValues.add(correctNull((String) hshValues.get("txt_pre_longsymbol")));
					arrValues.add(correctNull((String) hshValues.get("txtar_desc")));
					arrValues.add(correctNull((String) hshValues.get("txt_duedate")));
					arrValues.add(correctNull((String) hshValues.get("txt_rat_weight")));
					arrValues.add(correctNull((String) hshValues.get("seltype")));
					hshQuery.put("arrValues", arrValues);				
					hshQuery.put("strQueryId", "cusratingnew_ins");
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				if(strhidAction.equalsIgnoreCase("update"))
				{
					hshQueryValues = new HashMap();
					hshQueryValues.put("size","1");
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					arrValues.add(correctNull((String) hshValues.get("txt_pre_agency")));
					arrValues.add(correctNull((String) hshValues.get("txt_ratinddate")));
					arrValues.add(correctNull((String) hshValues.get("txt_facrated_parti")));
					arrValues.add(correctNull((String) hshValues.get("txt_amt_rated")));
					arrValues.add(correctNull((String) hshValues.get("txt_pre_longsymbol")));
					arrValues.add(correctNull((String) hshValues.get("txtar_desc")));
					arrValues.add(correctNull((String) hshValues.get("txt_duedate")));
					arrValues.add(correctNull((String) hshValues.get("txt_rat_weight")));
					arrValues.add(correctNull((String) hshValues.get("seltype")));	
					arrValues.add(strApplntid);
					arrValues.add(correctNull((String) hshValues.get("hidSno")));
					hshQuery.put("arrValues", arrValues);				
					hshQuery.put("strQueryId", "cusratingnew_upd");
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				/*added by ganesan for Rating Type
				if((strhidAction.equalsIgnoreCase("insert"))||(strhidAction.equalsIgnoreCase("update")))
				{	
				
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId", "del_CUS_RATINGNEWType");
				arrValues.add(strApplntid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshQueryValues = new HashMap();
				hshQueryValues.put("size","1");
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(strApplntid);
				arrValues.add(Helper.correctNull((String) hshValues.get("sel_RatingType")));				
				hshQuery.put("arrValues", arrValues);				
				hshQuery.put("strQueryId", "ins_CUS_RATINGNEWType");
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				}*/
				
				String strRated = "N";
				String strQuery13 = SQLParser.getSqlQuery("cusratingnew_sel^"+strApplntid);
				ResultSet rs13 = DBUtils.executeQuery(strQuery13);
				if(rs13.next())
				{
					strRated = "Y";
				}
				if(strRated.equalsIgnoreCase("Y"))
				{
					hshQueryValues = new HashMap();
					hshQueryValues.put("size","1");
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					arrValues.add(strApplntid);				
					hshQuery.put("arrValues", arrValues);				
					hshQuery.put("strQueryId", "cusrating_del");
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					hshQueryValues = new HashMap();
					hshQueryValues.put("size","1");
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					arrValues.add(strApplntid);
					arrValues.add(strRatingType);
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("Y");				
					hshQuery.put("arrValues", arrValues);				
					hshQuery.put("strQueryId", "cusrating_ins");
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				else if(strRated.equalsIgnoreCase("N"))
				{
					hshQueryValues = new HashMap();
					hshQueryValues.put("size","1");
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					arrValues.add(strApplntid);				
					hshQuery.put("arrValues", arrValues);				
					hshQuery.put("strQueryId", "cusrating_del");
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				
				
			}
		}
		catch(Exception e)
		{
			log.error("Exception"+ e);
		}
		return hshRec;	
	}
	
	public HashMap updateDefaulter(HashMap hshValues) 
	{
		HashMap hshRec=new HashMap();		
		ArrayList arrValues = new ArrayList();
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		String strApplntid=correctNull((String)hshValues.get("txtperapp_appid"));
		//String strApplntid="100";
		
		String strhidAction=correctNull((String)hshValues.get("hidAction"));
		String strFromPage=correctNull((String)hshValues.get("hidFromPage"));
		StringBuffer sbAuditTrial = new StringBuffer();
		ResultSet rs=null;
		String strQuery="";
		StringBuffer strActionData=new StringBuffer();
		StringBuffer sbOldAudit=new StringBuffer();
		try
		{
			/***
			 * For Audit Trial Old Data - By Karthikeyan.S on 13/09/2013
			 */
			
			
			strQuery=SQLParser.getSqlQuery("cusdefaulter_sel^"+strApplntid+"^"+strApplntid);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				String strRBIDefOldAudit=Helper.correctNull((String) hshValues.get("sel_RBIDefaulter"));
				String strRBIDefDescOldAudit="";
				if(strRBIDefOldAudit.equalsIgnoreCase("Y"))
				{
					strRBIDefDescOldAudit="Yes";
				}
				else if(strRBIDefOldAudit.equalsIgnoreCase("N"))
				{
					strRBIDefDescOldAudit="No";
				}
				String strECGCIDefOldAudit=Helper.correctNull((String) hshValues.get("sel_ECGCIList"));
				String strECGCIDefDescOldAudit="";
				if(strECGCIDefOldAudit.equalsIgnoreCase("Y"))
				{
					strECGCIDefDescOldAudit="Yes";
				}
				else if(strECGCIDefOldAudit.equalsIgnoreCase("N"))
				{
					strECGCIDefDescOldAudit="No";
				}
				String strWillfulDefOldAudit=Helper.correctNull((String) hshValues.get("sel_Willful"));
				String strWillfulDefDescOldAudit="";
				if(strWillfulDefOldAudit.equalsIgnoreCase("Y"))
				{
					strWillfulDefDescOldAudit="Yes";
				}
				else if(strWillfulDefOldAudit.equalsIgnoreCase("N"))
				{
					strWillfulDefDescOldAudit="No";
				}
				String strIdentDefOldAudit=Helper.correctNull((String) hshValues.get("sel_Identified"));
				String strIdentDefDescOldAudit="";
				if(strIdentDefOldAudit.equalsIgnoreCase("Y"))
				{
					strIdentDefDescOldAudit="Yes";
				}
				else if(strIdentDefOldAudit.equalsIgnoreCase("N"))
				{
					strIdentDefDescOldAudit="No";
				}
				
				String strSuitfiledAudit=Helper.correctNull((String) hshValues.get("sel_Suitfiled"));
				if(strSuitfiledAudit.equalsIgnoreCase("Y"))
				{
					strSuitfiledAudit="Yes";
				}
				else if(strSuitfiledAudit.equalsIgnoreCase("N"))
				{
					strSuitfiledAudit="No";
				}
				
				String stProbeAudit=Helper.correctNull(rs.getString("DEF_PROBE"));
				if(stProbeAudit.equalsIgnoreCase("Y"))
				{
					stProbeAudit="Yes";
				}
				else if(stProbeAudit.equalsIgnoreCase("N"))
				{
					stProbeAudit="No";
				}
				
				sbOldAudit.append("~Whether RBI Defaulter=").append(strRBIDefDescOldAudit)
						.append("~From Date=").append(Helper.correctNull(rs.getString("def_rbifrmdat")))
						.append("~Deleted on Date=").append(Helper.correctNull(rs.getString("def_rbideldat")))
						.append("~Whether ECGCI Specific list=").append(strECGCIDefDescOldAudit)
						.append("~From Date=").append(Helper.correctNull(rs.getString("def_ecgfrmdat")))
						.append("~Deleted on Date=").append(Helper.correctNull(rs.getString("def_ecgdeldat")))
						.append("~Whether Willful Defaulter=").append(strWillfulDefDescOldAudit)
						.append("~From Date=").append(Helper.correctNull(rs.getString("def_wilfrmdat")))
						.append("~Deleted on Date=").append(Helper.correctNull(rs.getString("def_wildeldat")))
						.append("~Whether Identified under EXIT policy=").append(strIdentDefDescOldAudit)
						.append("~From Date=").append(Helper.correctNull(rs.getString("def_exitfrmdat")))
						.append("~Deleted on Date=").append(Helper.correctNull(rs.getString("def_exitdeldat")))
						.append("~Whether Suit filed=").append(strSuitfiledAudit).append("~Action initiated=")
						.append(Helper.correctNull(rs.getString("DEF_SUITFILEDCOMM"))).append("~ Whether referred to Probe 42=").append(stProbeAudit);
				
			}
			if(rs!=null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("cuscibildetails_sel^"+strApplntid+"^"+strApplntid);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				sbOldAudit.append("~CIBIL Score=").append(Helper.correctNull(rs.getString("cibil_score")));
			}
			if(rs!=null)
			{
				rs.close();
			}
			
			/***
			 * End - Audit Trial Old Data
			 */
			
			if(strhidAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId", "cusdefaulter_del");
				arrValues.add(strApplntid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId", "cuscibildetails_del");
				arrValues.add(strApplntid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else
			{
				hshQueryValues = new HashMap();
				hshQueryValues.put("size","1");
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "cusdefaulter_del");
				arrValues.add(strApplntid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshQueryValues = new HashMap();
				hshQueryValues.put("size","1");
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "cuscibildetails_del");
				arrValues.add(strApplntid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
				hshQueryValues = new HashMap();
				hshQueryValues.put("size","1");
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(strApplntid);
				arrValues.add(correctNull((String) hshValues.get("sel_RBIDefaulter")));
				arrValues.add(correctNull((String) hshValues.get("txt_fromdate1")));
				arrValues.add(correctNull((String) hshValues.get("txt_deleteondate1")));
				arrValues.add(correctNull((String) hshValues.get("sel_ECGCIList")));
				arrValues.add(correctNull((String) hshValues.get("txt_fromdate2")));
				arrValues.add(correctNull((String) hshValues.get("txt_deleteondate2")));
				arrValues.add(correctNull((String) hshValues.get("sel_Willful")));
				arrValues.add(correctNull((String) hshValues.get("txt_fromdate3")));
				arrValues.add(correctNull((String) hshValues.get("txt_deleteondate3")));
				arrValues.add(correctNull((String) hshValues.get("sel_Identified")));
				arrValues.add(correctNull((String) hshValues.get("txt_fromdate4")));
				arrValues.add(correctNull((String) hshValues.get("txt_deleteondate4")));
				arrValues.add("Y");
				arrValues.add(correctNull((String) hshValues.get("txt_RBIDefaulter")));
				arrValues.add(correctNull((String) hshValues.get("txt_ECGCIList")));
				arrValues.add(correctNull((String) hshValues.get("txt_Willful")));
				arrValues.add(correctNull((String) hshValues.get("txt_Identified")));
				arrValues.add(correctNull((String) hshValues.get("txt_asonRBIdate")));
				arrValues.add(correctNull((String) hshValues.get("txt_asonECGCIdate")));
				arrValues.add(correctNull((String) hshValues.get("txt_asonWillfuldate")));
				arrValues.add(correctNull((String) hshValues.get("sel_Suitfiled")));
				arrValues.add(correctNull((String) hshValues.get("txt_Suitfiled")));
				arrValues.add(correctNull((String) hshValues.get("sel_probe")));
				arrValues.add(correctNull((String) hshValues.get("txt_probecmts")));
				hshQuery.put("arrValues", arrValues);				
				hshQuery.put("strQueryId", "cusdefaulter_ins");
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshQueryValues = new HashMap();
				hshQueryValues.put("size","1");
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(strApplntid);
				arrValues.add(correctNull((String) hshValues.get("txt_cibilscore")));
				arrValues.add(correctNull((String) hshValues.get("txt_cibilComment")));
				arrValues.add(correctNull((String) hshValues.get("sel_refercibil")));
				arrValues.add(correctNull((String) hshValues.get("txt_datecibil")));
				arrValues.add(correctNull((String) hshValues.get("txt_smaComment")));
				arrValues.add(correctNull((String) hshValues.get("txt_crilcdate")));
				arrValues.add(correctNull((String) hshValues.get("sel_SMAcategory")));
				arrValues.add(correctNull((String) hshValues.get("sel_referredCRIF")));
				arrValues.add(correctNull((String) hshValues.get("crifscore")));
				arrValues.add(correctNull((String) hshValues.get("crifdetails")));
				arrValues.add(correctNull((String) hshValues.get("crif_date"))); 
				arrValues.add(correctNull((String) hshValues.get("sel_referredExperian")));
				arrValues.add(correctNull((String) hshValues.get("experianscore"))); 
				arrValues.add(correctNull((String) hshValues.get("experiandetails")));
				arrValues.add(correctNull((String) hshValues.get("experian_date"))); 
				hshQuery.put("arrValues", arrValues);				
				hshQuery.put("strQueryId", "cuscibildetails_ins");
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			/** For the purpose of 'Audit Trial' */
			/*if((strhidAction.equalsIgnoreCase("update"))||(strhidAction.equalsIgnoreCase("insert"))) {
			sbAuditTrial.append("Whether the house/flat be self occupied after construction=");
			if(correctNull((String)hshValues.get("sel1")).trim().equalsIgnoreCase("1"))
				sbAuditTrial.append("~Yes");
			else if(correctNull((String)hshValues.get("sel1")).trim().equalsIgnoreCase("2"))
				sbAuditTrial.append("~No");
			
			sbAuditTrial.append("~Do you / your spouse / children own any house/flat=");
			if(correctNull((String)hshValues.get("sel2")).trim().equalsIgnoreCase("1"))
				sbAuditTrial.append("~Yes");
			else if(correctNull((String)hshValues.get("sel2")).trim().equalsIgnoreCase("2"))
				sbAuditTrial.append("~No");
			
			sbAuditTrial.append("~Is the legal title clear=");
			if(correctNull((String)hshValues.get("sel3")).trim().equalsIgnoreCase("1"))
				sbAuditTrial.append("~Yes");
			else if(correctNull((String)hshValues.get("sel3")).trim().equalsIgnoreCase("2"))
				sbAuditTrial.append("~No");
			
			sbAuditTrial.append("~Do you have any collateral security to offer=");
			if(correctNull((String)hshValues.get("sel4")).trim().equalsIgnoreCase("1"))
				sbAuditTrial.append("~Yes");
			else if(correctNull((String)hshValues.get("sel4")).trim().equalsIgnoreCase("2"))
				sbAuditTrial.append("~No");
			
			sbAuditTrial.append("~Whether your employer has any housing loan schemes=");
			if(correctNull((String)hshValues.get("sel5")).trim().equalsIgnoreCase("1"))
				sbAuditTrial.append("~Yes");
			else if(correctNull((String)hshValues.get("sel5")).trim().equalsIgnoreCase("2"))
				sbAuditTrial.append("~No");
			
			sbAuditTrial.append("~Are you ready to meet escalation in cost=");
			if(correctNull((String)hshValues.get("sel6")).trim().equalsIgnoreCase("1"))
				sbAuditTrial.append("~Yes");
			else if(correctNull((String)hshValues.get("sel6")).trim().equalsIgnoreCase("2"))
				sbAuditTrial.append("~No");
			
			sbAuditTrial.append("~Have you stood as a guarantor for any loan=");
			if(correctNull((String)hshValues.get("sel7")).trim().equalsIgnoreCase("1"))
				sbAuditTrial.append("~Yes");
			else if(correctNull((String)hshValues.get("sel7")).trim().equalsIgnoreCase("2"))
				sbAuditTrial.append("~No");
				if(correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("N"))
				{
					hshValues.put("hidAction", "insert");
				}	
			}
			AuditTrial.auditLog(hshValues,"84",strAppno,sbAuditTrial.toString());*/
			/** End */
			
			String strRBIDef=Helper.correctNull((String) hshValues.get("sel_RBIDefaulter"));
			String strRBIDefDesc="";
			if(strRBIDef.equalsIgnoreCase("Y"))
			{
				strRBIDefDesc="Yes";
			}
			else if(strRBIDef.equalsIgnoreCase("N"))
			{
				strRBIDefDesc="No";
			}
			String strECGCIDef=Helper.correctNull((String) hshValues.get("sel_ECGCIList"));
			String strECGCIDefDesc="";
			if(strECGCIDef.equalsIgnoreCase("Y"))
			{
				strECGCIDefDesc="Yes";
			}
			else if(strECGCIDef.equalsIgnoreCase("N"))
			{
				strECGCIDefDesc="No";
			}
			String strWillfulDef=Helper.correctNull((String) hshValues.get("sel_Willful"));
			String strWillfulDefDesc="";
			if(strWillfulDef.equalsIgnoreCase("Y"))
			{
				strWillfulDefDesc="Yes";
			}
			else if(strWillfulDef.equalsIgnoreCase("N"))
			{
				strWillfulDefDesc="No";
			}
			String strIdentDef=Helper.correctNull((String) hshValues.get("sel_Identified"));
			String strIdentDefDesc="";
			if(strIdentDef.equalsIgnoreCase("Y"))
			{
				strIdentDefDesc="Yes";
			}
			else if(strIdentDef.equalsIgnoreCase("N"))
			{
				strIdentDefDesc="No";
			}
			
			if(!strhidAction.equalsIgnoreCase("delete"))
			{
				strActionData.append("~Whether RBI Defaulter=").append(strRBIDefDesc)
				.append("~From Date=").append(Helper.correctNull((String) hshValues.get("txt_fromdate1")))
				.append("~Deleted on Date=").append(Helper.correctNull((String) hshValues.get("txt_deleteondate1")))
				.append("~Whether ECGCI Specific list=").append(strECGCIDefDesc)
				.append("~From Date=").append(Helper.correctNull((String) hshValues.get("txt_fromdate2")))
				.append("~Deleted on Date=").append(Helper.correctNull((String) hshValues.get("txt_deleteondate2")))
				.append("~Whether Willful Defaulter=").append(strWillfulDefDesc)
				.append("~From Date=").append(Helper.correctNull((String) hshValues.get("txt_fromdate3")))
				.append("~Deleted on Date=").append(Helper.correctNull((String) hshValues.get("txt_deleteondate3")))
				.append("~Whether Identified under EXIT policy=").append(strIdentDefDesc)
				.append("~From Date=").append(Helper.correctNull((String) hshValues.get("txt_fromdate4")))
				.append("~Deleted on Date=").append(Helper.correctNull((String) hshValues.get("txt_deleteondate4")))
				.append("~CIBIL Score=").append(Helper.correctNull((String) hshValues.get("txt_cibilscore")))
				.append("~ Whether referred to Probe 42 = ").append(Helper.correctNull((String) hshValues.get("sel_probe")));
			}
			
			AuditTrial.auditNewLog(hshValues, "207", strApplntid, strActionData.toString(), sbOldAudit.toString());
			
		}				
		catch(Exception e)
		{
			log.error("Exception"+ e);
		}
		return hshRec;	
	}
	
	public HashMap getRating(HashMap hshValues) 
	{
		HashMap hshRec=new HashMap();
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol = new ArrayList();
		ResultSet rs = null;		
		String applicantId   = "";
		String strAppStatus="",strFacname="";
		applicantId = Helper.correctNull((String)hshValues.get("hidDemoId"));
		if(applicantId.equalsIgnoreCase(""))
		{
			applicantId = correctNull((String) hshValues.get("txtperapp_appid"));
		}
		if(applicantId.equalsIgnoreCase("") || applicantId.equalsIgnoreCase("null"))
		{
			applicantId = correctNull((String) hshValues.get("hidapplicantnewid"));
		}
		//String strRatingType = Helper.correctNull((String)hshValues.get("sel_RatingType"));	
		String strRatingType = "";	

		
		
		try
		{ 
			strAppStatus=Helper.correctNull((String)hshValues.get("hidappstatus"));
			if(rs!=null)
			{	rs.close();	}
			
			if(strRatingType.equalsIgnoreCase(""))
			{
				rs=DBUtils.executeLAPSQuery("cusrating_sel^"+applicantId);			
				if(rs.next())
				{
					strRatingType = Helper.correctNull((String)rs.getString("rat_type"));				
				}
			}
			
			if(strRatingType.equalsIgnoreCase("1"))
			{
				if(rs!=null)
				{	rs.close();	}
				rs=DBUtils.executeLAPSQuery("cusratingnew_sel^"+applicantId);	
				while(rs.next())
				{
					arrCol = new ArrayList();
					arrCol.add(Helper.correctNull(rs.getString("RAT_ID")));//0
					arrCol.add(Helper.correctNull(rs.getString("RAT_SNO")));//1
					arrCol.add(Helper.correctNull(rs.getString("RAT_AGENCY")));//2
					arrCol.add(Helper.correctNull(rs.getString("RATE_DATE")));//3
					arrCol.add(Helper.correctNull(rs.getString("RAT_PARTICULARS")));//4
					arrCol.add(Helper.correctNull(rs.getString("RAT_AMOUNT")));//5
					arrCol.add(Helper.correctNull(rs.getString("RAT_SYMBOL")));//6
					arrCol.add(Helper.CLOBToString(rs.getClob("RAT_DESC")));//7
					arrCol.add(Helper.correctNull(rs.getString("RAT_DUEDATE")));//8
					arrCol.add(Helper.correctNull(rs.getString("RAT_RISK_WEIGHT")));//9
					arrCol.add(Helper.correctNull(rs.getString("RAT_TERMTYPE")));//10
					arrRow.add(arrCol);
				}
			}
			if(rs!=null)
				rs.close();
			
			
			
			hshRec.put("arrRow",arrRow);
			hshRec.put("applicantId",applicantId);
			hshRec.put("RAT_TYPE",strRatingType);
			
			HashMap prof=new HashMap();
			HashMap profile=new HashMap();
			prof.put("profile_id",applicantId);
			profile=(HashMap)getCustomerProfileStatus(prof);
			hshRec.put("strIncompletepage", Helper.correctNull((String)profile.get("strIncompletepage")));
			String strProfilestatus="";
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("getprofilestatusfromdemographic^"+applicantId);
			if(rs.next())
			{
				strProfilestatus=Helper.correctNull((String)rs.getString("perapp_profilestatus"));
			}
			hshRec.put("strProfilestatus",strProfilestatus);
			hshRec.put("appstatus",strAppStatus);
			
			/*if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("sel_CUS_RATINGNEWType^"+applicantId);
			
			if(rs.next())
			{
				hshRec.put("Rat_Rating",Helper.correctNull((String)rs.getString("Rat_Rating")));
				
			}*/
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("perconstbankingsel^"+applicantId);
			if(rs.next())
			{
				strFacname=Helper.correctNull((String)rs.getString("cus_facname"));
			}
			hshRec.put("strFacname",strFacname);
			
		
		}
		catch(Exception e)
		{
			log.error("Exception"+ e);
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
		return hshRec;		
	}
	public HashMap getDefaulter(HashMap hshValues) 
	{
		HashMap hshRec=new HashMap();			 
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		String applicantId   = "", strappname="";
		String strAppStatus="";
		applicantId = Helper.correctNull((String)hshValues.get("hidDemoId"));
		if(applicantId.equalsIgnoreCase(""))
		{
			applicantId = correctNull((String) hshValues.get("txtperapp_appid"));
		}
		if(applicantId.equalsIgnoreCase("") || applicantId.equalsIgnoreCase("null"))
		{
			applicantId = correctNull((String) hshValues.get("hidapplicantnewid"));
		}
		strappname = correctNull((String) hshValues.get("appname"));
		if(strappname.equals(""))
		{
			strappname=correctNull((String)hshValues.get("app_name"));
		}
		boolean recordflag=false;  
	
		try
		{ 
			strAppStatus=Helper.correctNull((String)hshValues.get("hidappstatus"));

			rs1=DBUtils.executeLAPSQuery("cusdefaulter_sel^"+ applicantId+"^"+applicantId);			 
			if (rs1.next()) 
			{

				hshRec.put("DEF_ID",correctNull(rs1.getString("DEF_ID")));
				hshRec.put("DEF_RBIDEFIS",correctNull(rs1.getString("DEF_RBIDEFIS")));
				hshRec.put("DEF_RBIFRMDAT",correctNull(rs1.getString("DEF_RBIFRMDAT")));
				hshRec.put("DEF_RBIDELDAT",correctNull(rs1.getString("DEF_RBIDELDAT")));
				hshRec.put("DEF_ECGSEPIS",correctNull(rs1.getString("DEF_ECGSEPIS")));
				hshRec.put("DEF_ECGFRMDAT",correctNull(rs1.getString("DEF_ECGFRMDAT")));
				hshRec.put("DEF_ECGDELDAT",correctNull(rs1.getString("DEF_ECGDELDAT")));
				hshRec.put("DEF_WILDEFIS",correctNull(rs1.getString("DEF_WILDEFIS")));
				hshRec.put("DEF_WILFRMDAT",correctNull(rs1.getString("DEF_WILFRMDAT")));
				hshRec.put("DEF_WILDELDAT",correctNull(rs1.getString("DEF_WILDELDAT")));
				hshRec.put("DEF_EXITPOLIS",correctNull(rs1.getString("DEF_EXITPOLIS")));
				hshRec.put("DEF_EXITFRMDAT",correctNull(rs1.getString("DEF_EXITFRMDAT")));
				hshRec.put("DEF_EXITDELDAT",correctNull(rs1.getString("DEF_EXITDELDAT")));
				hshRec.put("rat_status",correctNull(rs1.getString("rat_status")));
				hshRec.put("DEF_RBIDEFCOMM",Helper.CLOBToString(rs1.getClob("DEF_RBIDEFCOMM")));
				hshRec.put("DEF_ECGSEPCOMM",Helper.CLOBToString(rs1.getClob("DEF_ECGSEPCOMM")));
				hshRec.put("DEF_WILDDEFCOMM",Helper.CLOBToString(rs1.getClob("DEF_WILDDEFCOMM")));
				hshRec.put("DEF_EXITPOLCOMM",Helper.CLOBToString(rs1.getClob("DEF_EXITPOLCOMM")));
				hshRec.put("asonRBIdate",Helper.correctNull(rs1.getString("asonRBIdate")));  //added by ganesan for As on date RBI
				hshRec.put("asonECGCIdate",Helper.correctNull(rs1.getString("asonECGCIdate")));
				hshRec.put("asonWillfuldate",Helper.correctNull(rs1.getString("asonWillfuldate")));
				hshRec.put("DEF_SUITFILED",correctNull(rs1.getString("DEF_SUITFILED")));
				hshRec.put("DEF_SUITFILEDCOMM",Helper.CLOBToString(rs1.getClob("DEF_SUITFILEDCOMM")));
				hshRec.put("DEF_PROBE",correctNull(rs1.getString("DEF_PROBE")));
				hshRec.put("DEF_PROBECMT",Helper.CLOBToString(rs1.getClob("DEF_PROBECMT")));
				recordflag=true;
			}
			if(rs2 !=null)
				rs2.close();
			rs2=DBUtils.executeLAPSQuery("cuscibildetails_sel^"+applicantId+"^"+applicantId);	
			while(rs2.next())
			{
				hshRec.put("cibil_appid",correctNull(rs2.getString("cibil_appid")));
				hshRec.put("cibil_score",correctNull(rs2.getString("cibil_score")));
				hshRec.put("cibil_details",correctNull(rs2.getString("cibil_details")));
				hshRec.put("cibil_rat_status",correctNull(rs2.getString("cibil_rat_status")));
				hshRec.put("cibil_reporteddate",correctNull(rs2.getString("cibil_reporteddate")));
				hshRec.put("cibil_smadetails",correctNull(rs2.getString("cibil_smadetails")));
				hshRec.put("cibil_CRILC",correctNull(rs2.getString("cibil_CRILC")));
				hshRec.put("cibil_SMACategory",correctNull(rs2.getString("cibil_smacategory")));
				hshRec.put("CRIF_REFERED",correctNull(rs2.getString("CRIF_REFERED")));
				hshRec.put("CRIF_SCORE",correctNull(rs2.getString("CRIF_SCORE")));
				hshRec.put("CRIF_DETAILS",correctNull(rs2.getString("CRIF_DETAILS")));
				hshRec.put("CRIF_DATE",correctNull(rs2.getString("CRIF_DATE")));
				hshRec.put("crif_auto_update",correctNull(rs2.getString("crif_auto_update")));
				hshRec.put("cibil_auto_update",correctNull(rs2.getString("cibil_auto_update")));
				hshRec.put("EXPERIAN_REFERED",correctNull(rs2.getString("EXPERIAN_REFERED")));
				hshRec.put("EXPERIAN_SCORE",correctNull(rs2.getString("EXPERIAN_SCORE")));
				hshRec.put("EXPERIAN_DETAILS",correctNull(rs2.getString("EXPERIAN_DETAILS")));
				hshRec.put("EXPERIAN_DATE",correctNull(rs2.getString("EXPERIAN_DATE")));
				recordflag=true;
			}
			/** For the purpose of 'Audit Trial' */
			if(recordflag)
				hshRec.put("recordflag","Y");
			else
				hshRec.put("recordflag","N");
			
			hshRec.put("app_name",strappname);
			hshRec.put("applicantId",applicantId);
			
			HashMap prof=new HashMap();
			HashMap profile=new HashMap();
			prof.put("profile_id",applicantId);
			profile=(HashMap)getCustomerProfileStatus(prof);
			hshRec.put("strIncompletepage", Helper.correctNull((String)profile.get("strIncompletepage")));

			String strProfilestatus="",strDigiFlag="";
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("getprofilestatusfromdemographic^"+applicantId);
			if(rs.next())
			{
				strProfilestatus=Helper.correctNull((String)rs.getString("perapp_profilestatus"));
				strDigiFlag=Helper.correctNull((String)rs.getString("PERAPP_EXTNAPPL"));
			}
			hshRec.put("strProfilestatus",strProfilestatus);
			hshRec.put("appstatus",strAppStatus);
			hshRec.put("digiFlag",strDigiFlag);
			
		}
		catch(Exception e)
		{
			log.error("Exception"+ e);
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
		return hshRec;		
	}
	
	
	
	//Added by Arsath on 22/07/2013 for District Search	
	public HashMap getDistrictSearch(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		String strStateCode="";
		String strDistdesc = "";
		ArrayList arrCol = new ArrayList();
		ArrayList arrValue = new ArrayList();
		ResultSet rs = null;
		strStateCode=Helper.correctNull((String)hshValues.get("statecode"));
		strDistdesc=Helper.correctNull((String)hshValues.get("distdesc"));
		String strDistdesc1="";
		String pagefrom=Helper.correctNull((String)hshValues.get("code"));
		String rowCount=Helper.correctInt((String)hshValues.get("rowCount"));
		String rowindex=Helper.correctInt((String)hshValues.get("rowindex"));

		try
		{
			if(!strDistdesc.equalsIgnoreCase("") && !strStateCode.equalsIgnoreCase(""))
			{
				if(rs!=null)
				{
					rs.close();
				}
				strDistdesc1 = strDistdesc.toUpperCase();
				rs=DBUtils.executeLAPSQuery("sel_sortbydistname^"+strStateCode+"^"+strDistdesc1);		
				while(rs.next())
				{
					arrCol = new ArrayList();
					arrCol.add(correctNull((String)rs.getString("district_code")));
					arrCol.add(correctNull((String)rs.getString("district_desc")));
					arrCol.add(correctNull((String)rs.getString("district_active")));
					arrValue.add(arrCol);
				}			
				hshRecord.put("arrCust",arrValue);
			}
			else if(!strStateCode.equalsIgnoreCase(""))
			{
				if(rs!=null)
				{
					rs.close();
				}
				rs=DBUtils.executeLAPSQuery("sel_distnamebystatecode^"+strStateCode);			
				while(rs.next())
				{
					arrCol = new ArrayList();
					arrCol.add(correctNull((String)rs.getString("district_code")));
					arrCol.add(correctNull((String)rs.getString("district_desc")));
					arrCol.add(correctNull((String)rs.getString("district_active")));
					arrValue.add(arrCol);
				}			
				hshRecord.put("arrCust",arrValue);
			}
			else if(!strDistdesc.equalsIgnoreCase(""))
			{
				if(rs!=null)
				{
					rs.close();
				}
				strDistdesc1 = strDistdesc.toUpperCase();
				rs=DBUtils.executeLAPSQuery("sel_sortbydistname1^"+strDistdesc1);		
				while(rs.next())
				{
					arrCol = new ArrayList();
					arrCol.add(correctNull((String)rs.getString("district_code")));
					arrCol.add(correctNull((String)rs.getString("district_desc")));
					arrCol.add(correctNull((String)rs.getString("district_active")));
					arrValue.add(arrCol);
				}			
				hshRecord.put("arrCust",arrValue);
			}
			hshRecord.put("distflag",Helper.correctNull((String)hshValues.get("code")));
			hshRecord.put("statecode",strStateCode);
			hshRecord.put("rowCount",rowCount);
			hshRecord.put("rowindex",rowindex);

		}
		catch(Exception e1)
		{
			throw new EJBException(e1.getMessage());
		}
		
		return hshRecord;
	}
	/**
	 * @author:Karthikeyan.S
	 * @date:September 12, 2013-04:20:00 PM
	 * @category Data Description for corresponding codes in Masters
	 * @return String
	 * @
	 */
	public static String getMasterDesc(String strType, String strID, String strCode) 
	{
		ResultSet rs=null;
		String strDesc="";
		String strQuery="";
		try
		{
			if(strType.equalsIgnoreCase("CBSMast"))
			{
				strQuery=SQLParser.getSqlQuery("sel_cbsstaticdescbycode^"+strID+"^"+strCode);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strDesc=Helper.correctNull((String)rs.getString("cbs_static_data_desc"));
				}
			}
			else if(strType.equalsIgnoreCase("StatMast"))
			{
				strQuery=SQLParser.getSqlQuery("getstaticdesc^"+strID+"^"+strCode);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strDesc=Helper.correctNull((String)rs.getString("stat_data_desc1"));
				}
			}
			else if(strType.equalsIgnoreCase("MISMast"))
			{
				strQuery=SQLParser.getSqlQuery("sel_misstaticdatadesc^"+strID+"^"+strCode);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strDesc=Helper.correctNull((String)rs.getString("mis_static_data_desc"));
				}
			}
		}
		catch(Exception e)
		{
			log.error("Exception"+ e);
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
		return strDesc;
	}
	/**
	 * @author:Karthikeyan.S
	 * @date:September 12, 2013-12:00:00 PM
	 * @category to get Customer Demographics Old Audit Trial Data
	 * @return StringBuilder
	 * @
	 */
	private static StringBuilder getOldAuditDemographics(String strID) 
	{
		ResultSet rs=null;
		String strQuery="";
		StringBuilder sbOldAudit = new StringBuilder();
		String strCBSIDOldAudit="";
		String strTitleDescOldAudit="";
		String strFullNameOldAudit="";
		String strShortNameOldAudit="";
		String strFatherNameOldAudit="";
		String strConstitutionDescOldAudit="";
		String strPANNoOldAudit="";
		String strSexDescOldAudit="";
		String strDOBOldAudit="";
		String strMartialStatusDescOldAudit="";
		String strStatusDescOldAudit="";
		String strBorrStatusDescOldAudit="";
		String strTaxSlabDescOldAudit="";
		String strEmploymentDescOldAudit="";
		String strLineofActivityDescOldAudit="";
		String strLoASinceOldAudit="";
		String strBankingDescOldAudit="";
		String strBorrowerSinceOldAudit="";
		String strSalaryRoutedDescOldAudit="";
		String strStaffRelationDescOldAudit="";
		String strRelationNameOldAudit="";
		String strBloodRelationDescOldAudit="";
		String strIntroducerNameOldAudit="";
		String strIntroStatusDescOldAudit="";
		String strTradeFinanceDescOldAudit="";
		String strInlandTradeDescOldAudit="";
		String strCorpReligionDescOldAudit="";
		String strSatisfactoryDescOldAudit="";
		String strJustificationDetailsOldAudit="";
		String strRelativeStaffIDOldAudit="";
		String strResidentStatusDescOldAudit="";
		String strCountryOldAudit="";
		String strisStaffDescOldAudit="";
		String strStaffDOJOldAudit="";
		String strStaffIDOldAudit="";
		String strCasteDescOldAudit="";
		String strMinorityDescOldAudit="";
		String strReligionDescOldAudit="";
		String strChildDepOldAudit="";
		String strOtherDepOldAudit="";
		String strEarningMemOldAudit="";
		String strEduQualDescOldAudit="";
		String strAreaSpecialOldAudit="";
		String strPhysicalChgdDescOldAudit="";
		String strExServiceDescOldAudit="";
		String strYearsofServiceOldAudit="";
		String strisMinorDescOldAudit="";
		String strGaurdianCBSIDOldAudit="";
		String strGaurdianNameOldAudit="";
		String strGaurdianRelnDescOldAudit="";
		String strGaurdianAddrOldAudit="";
		String strSpouseTitleDescOldAudit="";
		String strSpouseNameOldAudit="";
		String strSpouseDOBOldAudit="";
		String strSpouseOccDescOldAudit="";
		String strSpouseQualDescOldAudit="";
		String strSpousePANNoOldAudit="";
		String strSpouseEmployerOldAudit="";
		String strSpouseIncomeOldAudit="";
		String strSpouseAddrOldAudit="";
		String strFamilyIncomeOldAudit="";
		String strCommencementDateOldAudit="";
		String strIncorporationDateOldAudit="";
		String strOwnershipTypeDescOldAudit="";
		String strROCNumberOldAudit="";
		String strCINOldAudit="";
		String strTINOldAudit="";
		String strGroupNameOldAudit="";
		String strIndustryTypeDescOldAudit="";
		String strTotalEmployeesOldAudit="";
		String strNBFCLoADescOldAudit="";
		String strNBFCDepositDescOldAudit="";
		String strNBFCInfraDescOldAudit="";
		String strNBFCAssetDescOldAudit="";
		String strMFIDescOldAudit="";
		String strMajorityDescOldAudit="";
		String strSHGLocDescOldAudit="";
		String strMembersOldAudit="";
		String strBeneficiariesOldAudit="";
		String strSHGSchemeDescOldAudit="";
		String strNGOFinanceDescOldAudit="";
		String strSavingsAcctOldAudit="";
		String strTitleOldAudit="";
		String strConstitutionOldAudit="";
		String strSexOldAudit="";
		String strMartialStatusOldAudit="";
		String strStatusOldAudit="";
		String strBorrStatusOldAudit="";
		String strTaxSlabOldAudit="";
		String strEmploymentOldAudit="";
		String strLineofActivityOldAudit="";
		String strBankingOldAudit="";
		String strStaffRelationOldAudit="";
		String strBloodRelationOldAudit="";
		String strIntroStatusOldAudit="";
		String strNetworth="";
		String strNetworthAson="";
		String strTradeFinanceOldAudit="";
		String strInlandTradeOldAudit="";
		String strCorpReligionOldAudit="";
		String strSatisfactoryOldAudit="";
		String strResidentStatusOldAudit="";
		String strisStaffOldAudit="";
		String strCasteOldAudit="";
		String strMinorityOldAudit="";
		String strReligionOldAudit="";
		String strEduQualOldAudit="";
		String strPhysicalChgdOldAudit="";
		String strExServiceOldAudit="";
		String strisMinorOldAudit="";
		String strGaurdianRelnOldAudit="";
		String strSpouseTitleOldAudit="";
		String strSpouseOccOldAudit="";
		String strSpouseQualOldAudit="";
		String strOwnershipTypeOldAudit="";
		String strIndustryTypeOldAudit="";
		String strNBFCLoAOldAudit="";
		String strNBFCDepositOldAudit="";
		String strNBFCInfraOldAudit="";
		String strNBFCAssetOldAudit="";
		String strMFIOldAudit="";
		String strMajorityOldAudit="";
		String strSHGLocOldAudit="";
		String strSHGSchemeOldAudit="";
		String strNGOFinanceOldAudit="";
		String strSalaryRoutedOldAudit="";
		try
		{
			strQuery=SQLParser.getSqlQuery("sel_common_customer^"+strID);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strCBSIDOldAudit=Helper.correctNull((String)rs.getString("perapp_cbsid"));
				strTitleOldAudit=Helper.correctNull((String)rs.getString("perapp_title"));
				strFullNameOldAudit=Helper.correctNull((String)rs.getString("perapp_fname"));
				strShortNameOldAudit=Helper.correctNull((String)rs.getString("perapp_lname"));
				strFatherNameOldAudit=Helper.correctNull((String)rs.getString("perapp_fatname"));
				strConstitutionOldAudit=Helper.correctNull((String)rs.getString("perapp_constitutionnew"));
				strPANNoOldAudit=Helper.correctNull((String)rs.getString("perapp_panno"));
				strSexOldAudit=Helper.correctNull((String)rs.getString("perapp_sex"));
				strDOBOldAudit=Helper.correctNull((String)rs.getString("perapp_dob"));
				strMartialStatusOldAudit=Helper.correctNull((String)rs.getString("perapp_marstat"));
				strStatusOldAudit=Helper.correctNull((String)rs.getString("perapp_status"));
				strBorrStatusOldAudit=Helper.correctNull((String)rs.getString("perapp_istatus"));
				strTaxSlabOldAudit=Helper.correctNull((String)rs.getString("perapp_taxslab"));
				strEmploymentOldAudit=Helper.correctNull((String)rs.getString("perapp_employment"));
				strLineofActivityOldAudit=Helper.correctNull((String)rs.getString("perapp_occupation"));
				strLoASinceOldAudit=Helper.correctNull((String)rs.getString("perapp_loa_since"));
				strBankingOldAudit=Helper.correctNull((String)rs.getString("perapp_bank"));
				strBorrowerSinceOldAudit=Helper.correctNull((String)rs.getString("perapp_banksince"));
				strSalaryRoutedOldAudit=Helper.correctNull((String)rs.getString("perapp_salaryrouted"));
				strStaffRelationOldAudit=Helper.correctNull((String)rs.getString("perapp_relation_bankstaff"));
				strRelationNameOldAudit=Helper.correctNull((String)rs.getString("perapp_relation_staffname"));
				strBloodRelationOldAudit=Helper.correctNull((String)rs.getString("perapp_blood_relation"));
				strIntroducerNameOldAudit=Helper.correctNull((String)rs.getString("perapp_introname"));
				strIntroStatusOldAudit=Helper.correctNull((String)rs.getString("perapp_introstatus"));
				strNetworth=Helper.correctDouble((String)rs.getString("PERAPP_NETWORTH"));
				strNetworthAson=Helper.correctNull((String)rs.getString("PERAPP_NETWORTHASON"));
				strTradeFinanceOldAudit=Helper.correctNull((String)rs.getString("perapp_tradefinance"));
				strInlandTradeOldAudit=Helper.correctNull((String)rs.getString("perapp_inlandtrade"));
				strCorpReligionOldAudit=Helper.correctNull((String)rs.getString("perapp_religion"));
				strSatisfactoryOldAudit=Helper.correctNull((String)rs.getString("perapp_satisfactory"));
				strJustificationDetailsOldAudit=Helper.correctNull((String)rs.getString("perapp_just_details"));
				strRelativeStaffIDOldAudit=Helper.correctNull((String)rs.getString("perapp_relat_staffid"));
				strResidentStatusOldAudit=Helper.correctNull((String)rs.getString("indinfo_resident_status"));
				strCountryOldAudit=Helper.correctNull((String)rs.getString("indinfo_resident_country"));
				strisStaffOldAudit=Helper.correctNull((String)rs.getString("indinfo_is_staff"));
				strStaffDOJOldAudit=Helper.correctNull((String)rs.getString("indinfo_dateof_joining"));
				strStaffIDOldAudit=Helper.correctNull((String)rs.getString("indinfo_staff_id"));
				strCasteOldAudit=Helper.correctNull((String)rs.getString("indinfo_caste"));
				strMinorityOldAudit=Helper.correctNull((String)rs.getString("indinfo_minority"));
				strReligionOldAudit=Helper.correctNull((String)rs.getString("indinfo_religion"));
				strChildDepOldAudit=Helper.correctNull((String)rs.getString("indinfo_dependents_child"));
				strOtherDepOldAudit=Helper.correctNull((String)rs.getString("indinfo_dependents_others"));
				strEarningMemOldAudit=Helper.correctNull((String)rs.getString("indinfo_earning_member"));
				strEduQualOldAudit=Helper.correctNull((String)rs.getString("indinfo_edu_qual"));
				strAreaSpecialOldAudit=Helper.correctNull((String)rs.getString("indinfo_area_specialized"));
				strPhysicalChgdOldAudit=Helper.correctNull((String)rs.getString("indinfo_physically_challanged"));
				strExServiceOldAudit=Helper.correctNull((String)rs.getString("indinfo_exservice_man"));
				strYearsofServiceOldAudit=Helper.correctNull((String)rs.getString("indinfo_service_years"));
				strisMinorOldAudit=Helper.correctNull((String)rs.getString("indinfo_is_minor"));
				strGaurdianCBSIDOldAudit=Helper.correctNull((String)rs.getString("indinfo_guardian_appid"));
				strGaurdianNameOldAudit=Helper.correctNull((String)rs.getString("indinfo_guardian_name"));
				strGaurdianRelnOldAudit=Helper.correctNull((String)rs.getString("indinfo_guardian_relation"));
				strGaurdianAddrOldAudit=Helper.correctNull((String)rs.getString("indinfo_guardian_address"));
				strSpouseTitleOldAudit=Helper.correctNull((String)rs.getString("indinfo_spouse_title"));
				strSpouseNameOldAudit=Helper.correctNull((String)rs.getString("indinfo_spouse_name"));
				strSpouseDOBOldAudit=Helper.correctNull((String)rs.getString("indinfo_spouse_dob"));
				strSpouseOccOldAudit=Helper.correctNull((String)rs.getString("indinfo_spouse_occupation"));
				strSpouseQualOldAudit=Helper.correctNull((String)rs.getString("indinfo_spouse_qualification"));
				strSpousePANNoOldAudit=Helper.correctNull((String)rs.getString("indinfo_spouse_panno"));
				strSpouseEmployerOldAudit=Helper.correctNull((String)rs.getString("indinfo_spouse_employer"));
				strSpouseIncomeOldAudit=Helper.correctNull((String)rs.getString("indinfo_spouse_income"));
				strSpouseAddrOldAudit=Helper.correctNull((String)rs.getString("indinfo_spouse_address"));
				strFamilyIncomeOldAudit=Helper.correctDouble((String)rs.getString("indinfo_family_income"));
				strCommencementDateOldAudit=Helper.correctNull((String)rs.getString("cominfo_commencement_date"));
				strIncorporationDateOldAudit=Helper.correctNull((String)rs.getString("cominfo_incorporation_date"));
				strOwnershipTypeOldAudit=Helper.correctNull((String)rs.getString("cominfo_ownership_type"));
				strROCNumberOldAudit=Helper.correctNull((String)rs.getString("cominfo_roc_number"));
				strCINOldAudit=Helper.correctNull((String)rs.getString("cominfo_cin"));
				strTINOldAudit=Helper.correctNull((String)rs.getString("cominfo_tin"));
				strGroupNameOldAudit=Helper.correctNull((String)rs.getString("cominfo_groupname"));
				strIndustryTypeOldAudit=Helper.correctNull((String)rs.getString("cominfo_industry_type"));
				strTotalEmployeesOldAudit=Helper.correctNull((String)rs.getString("cominfo_total_employees"));
				strNBFCLoAOldAudit=Helper.correctNull((String)rs.getString("cominfo_loa_nbfc"));
				strNBFCDepositOldAudit=Helper.correctNull((String)rs.getString("cominfo_nbfc_deposit"));
				strNBFCInfraOldAudit=Helper.correctNull((String)rs.getString("cominfo_nbfc_infra"));
				strNBFCAssetOldAudit=Helper.correctNull((String)rs.getString("cominfo_nbfc_asset"));
				strMFIOldAudit=Helper.correctNull((String)rs.getString("cominfo_micro_fin_inst"));
				strMajorityOldAudit=Helper.correctNull((String)rs.getString("cominfo_minority_community"));
				strSHGLocOldAudit=Helper.correctNull((String)rs.getString("cominfo_shg_location"));
				strMembersOldAudit=Helper.correctNull((String)rs.getString("cominfo_shg_members"));
				strBeneficiariesOldAudit=Helper.correctNull((String)rs.getString("cominfo_shg_beneficiaries"));
				strSHGSchemeOldAudit=Helper.correctNull((String)rs.getString("cominfo_shg_scheme"));
				strNGOFinanceOldAudit=Helper.correctNull((String)rs.getString("cominfo_shg_ngo"));
				strSavingsAcctOldAudit=Helper.correctNull((String)rs.getString("cominfo_shg_acctno"));
			}
			
			/*
			 * Description from codes
			 */
			
			strTitleDescOldAudit=getMasterDesc("CBSMast","1",strTitleOldAudit);
			strConstitutionDescOldAudit=getMasterDesc("CBSMast","2",strConstitutionOldAudit);
			strMartialStatusDescOldAudit=getMasterDesc("CBSMast","3",strMartialStatusOldAudit);
			strStatusDescOldAudit=getMasterDesc("CBSMast","4",strStatusOldAudit);
			strTaxSlabDescOldAudit=getMasterDesc("CBSMast","5",strTaxSlabOldAudit);
			strIntroStatusDescOldAudit=getMasterDesc("CBSMast","6",strIntroStatusOldAudit);
			strCasteDescOldAudit=getMasterDesc("CBSMast","7",strCasteOldAudit);
			strEduQualDescOldAudit=getMasterDesc("CBSMast","8",strEduQualOldAudit);
			strSpouseOccDescOldAudit=getMasterDesc("CBSMast","9",strSpouseOccOldAudit);
			strCorpReligionDescOldAudit=getMasterDesc("CBSMast","11",strCorpReligionOldAudit);
			strReligionDescOldAudit=getMasterDesc("CBSMast","11",strReligionOldAudit);
			strResidentStatusDescOldAudit=getMasterDesc("CBSMast","18",strResidentStatusOldAudit);
			strGaurdianRelnDescOldAudit=getMasterDesc("CBSMast","19",strGaurdianRelnOldAudit);
			strSpouseQualDescOldAudit=getMasterDesc("StatMast","105",strSpouseQualOldAudit);
			strBorrStatusDescOldAudit=getMasterDesc("StatMast","109",strBorrStatusOldAudit);
			strLineofActivityDescOldAudit=getMasterDesc("StatMast","113",strLineofActivityOldAudit);
			strStaffRelationDescOldAudit=getMasterDesc("StatMast","110",strStaffRelationOldAudit);
			strBloodRelationDescOldAudit=getMasterDesc("StatMast","111",strBloodRelationOldAudit);
			strSHGLocDescOldAudit=getMasterDesc("StatMast","114",strSHGLocOldAudit);
			strSHGSchemeDescOldAudit=getMasterDesc("StatMast","115",strSHGSchemeOldAudit);
			strSexDescOldAudit="";
			if(strSexOldAudit.equalsIgnoreCase("M"))
			{
				strSexDescOldAudit="Male";
			}
			else if(strSexOldAudit.equalsIgnoreCase("F"))
			{
				strSexDescOldAudit="Female";
			}
			else if(strSexOldAudit.equalsIgnoreCase("O"))
			{
				strSexDescOldAudit="Others";
			}
			strEmploymentDescOldAudit="";
			if(strEmploymentOldAudit.equalsIgnoreCase("1"))
			{
				strEmploymentDescOldAudit="Employee";
			}
			else if(strEmploymentOldAudit.equalsIgnoreCase("2"))
			{
				strEmploymentDescOldAudit="Business Man";
			}
			else if(strEmploymentOldAudit.equalsIgnoreCase("3"))
			{
				strEmploymentDescOldAudit="Professionals";
			}
			else if(strEmploymentOldAudit.equalsIgnoreCase("4"))
			{
				strEmploymentDescOldAudit="Agriculture and allied activities";
			}
			else if(strEmploymentOldAudit.equalsIgnoreCase("6"))
			{
				strEmploymentDescOldAudit="Retail Trade";
			}
			else if(strEmploymentOldAudit.equalsIgnoreCase("7"))
			{
				strEmploymentDescOldAudit="SME (Services)";
			}
			else if(strEmploymentOldAudit.equalsIgnoreCase("8"))
			{
				strEmploymentDescOldAudit="SME (Manufacturing)";
			}
			else if(strEmploymentOldAudit.equalsIgnoreCase("9"))
			{
				strEmploymentDescOldAudit="Pensioner";
			}
			else if(strEmploymentOldAudit.equalsIgnoreCase("10"))
			{
				strEmploymentDescOldAudit="Student";
			}
			else if(strEmploymentOldAudit.equalsIgnoreCase("11"))
			{
				strEmploymentDescOldAudit="Others";
			}
			strBankingDescOldAudit="";
			if(strBankingOldAudit.equalsIgnoreCase("1"))
			{
				strBankingDescOldAudit="Yes";
			}
			else if(strBankingOldAudit.equalsIgnoreCase("2"))
			{
				strBankingDescOldAudit="No";
			}
			strSalaryRoutedDescOldAudit="";
			if(strSalaryRoutedOldAudit.equalsIgnoreCase("1"))
			{
				strSalaryRoutedDescOldAudit="Yes";
			}
			else if(strSalaryRoutedOldAudit.equalsIgnoreCase("2"))
			{
				strSalaryRoutedDescOldAudit="No";
			}
			strTradeFinanceDescOldAudit="";
			if(strTradeFinanceOldAudit.equalsIgnoreCase("Y"))
			{
				strTradeFinanceDescOldAudit="Yes";
			}
			else if(strTradeFinanceOldAudit.equalsIgnoreCase("N"))
			{
				strTradeFinanceDescOldAudit="No";
			}
			strInlandTradeDescOldAudit="";
			if(strInlandTradeOldAudit.equalsIgnoreCase("1"))
			{
				strInlandTradeDescOldAudit="Yes";
			}
			else if(strInlandTradeOldAudit.equalsIgnoreCase("2"))
			{
				strInlandTradeDescOldAudit="No";
			}
			strSatisfactoryDescOldAudit="";
			if(strSatisfactoryOldAudit.equalsIgnoreCase("Y"))
			{
				strSatisfactoryDescOldAudit="Yes";
			}
			else if(strSatisfactoryOldAudit.equalsIgnoreCase("N"))
			{
				strSatisfactoryDescOldAudit="No";
			}
			strisStaffDescOldAudit="";
			if(strisStaffOldAudit.equalsIgnoreCase("02"))
			{
				strisStaffDescOldAudit="Yes";
			}
			else if(strisStaffOldAudit.equalsIgnoreCase("01"))
			{
				strisStaffDescOldAudit="No";
			}
			strMinorityDescOldAudit="";
			if(strMinorityOldAudit.equalsIgnoreCase("Y"))
			{
				strMinorityDescOldAudit="Yes";
			}
			else if(strMinorityOldAudit.equalsIgnoreCase("N"))
			{
				strMinorityDescOldAudit="No";
			}
			strPhysicalChgdDescOldAudit="";
			if(strPhysicalChgdOldAudit.equalsIgnoreCase("Y"))
			{
				strPhysicalChgdDescOldAudit="Yes";
			}
			else if(strPhysicalChgdOldAudit.equalsIgnoreCase("N"))
			{
				strPhysicalChgdDescOldAudit="No";
			}
			strExServiceDescOldAudit="";
			if(strExServiceOldAudit.equalsIgnoreCase("Y"))
			{
				strExServiceDescOldAudit="Yes";
			}
			else if(strExServiceOldAudit.equalsIgnoreCase("N"))
			{
				strExServiceDescOldAudit="No";
			}
			strisMinorDescOldAudit="";
			if(strisMinorOldAudit.equalsIgnoreCase("Y"))
			{
				strisMinorDescOldAudit="Yes";
			}
			else if(strisMinorOldAudit.equalsIgnoreCase("N"))
			{
				strisMinorDescOldAudit="No";
			}
			strSpouseTitleDescOldAudit="";
			if(strSpouseTitleOldAudit.equalsIgnoreCase("MR"))
			{
				strSpouseTitleDescOldAudit="MR.";
			}
			else if(strSpouseTitleOldAudit.equalsIgnoreCase("MRS"))
			{
				strSpouseTitleDescOldAudit="MRS.";
			}
			strOwnershipTypeDescOldAudit="";
			if(strOwnershipTypeOldAudit.equalsIgnoreCase("099"))
			{
				strOwnershipTypeDescOldAudit="Others";
			}
			else if(strOwnershipTypeOldAudit.equalsIgnoreCase("001"))
			{
				strOwnershipTypeDescOldAudit="Individual";
			}
			else if(strOwnershipTypeOldAudit.equalsIgnoreCase("002"))
			{
				strOwnershipTypeDescOldAudit="Private Limited Company";
			}
			else if(strOwnershipTypeOldAudit.equalsIgnoreCase("003"))
			{
				strOwnershipTypeDescOldAudit="Public Limited Company";
			}
			else if(strOwnershipTypeOldAudit.equalsIgnoreCase("004"))
			{
				strOwnershipTypeDescOldAudit="Partnership";
			}
			else if(strOwnershipTypeOldAudit.equalsIgnoreCase("005"))
			{
				strOwnershipTypeDescOldAudit="Joint Borrowers";
			}
			else if(strOwnershipTypeOldAudit.equalsIgnoreCase("006"))
			{
				strOwnershipTypeDescOldAudit="Sole Proprietor";
			}
			else if(strOwnershipTypeOldAudit.equalsIgnoreCase("007"))
			{
				strOwnershipTypeDescOldAudit="Joint Venture";
			}
			else if(strOwnershipTypeOldAudit.equalsIgnoreCase("008"))
			{
				strOwnershipTypeDescOldAudit="Wholly owned subsidiary";
			}
			else if(strOwnershipTypeOldAudit.equalsIgnoreCase("009"))
			{
				strOwnershipTypeDescOldAudit="Trusts";
			}
			else if(strOwnershipTypeOldAudit.equalsIgnoreCase("010"))
			{
				strOwnershipTypeDescOldAudit="NBFC";
			}
			else if(strOwnershipTypeOldAudit.equalsIgnoreCase("011"))
			{
				strOwnershipTypeDescOldAudit="H.U.F";
			}
			strIndustryTypeDescOldAudit="";
			if(strIndustryTypeOldAudit.equalsIgnoreCase("001"))
			{
				strIndustryTypeDescOldAudit="Services";
			}
			else if(strIndustryTypeOldAudit.equalsIgnoreCase("002"))
			{
				strIndustryTypeDescOldAudit="Exports";
			}
			else if(strIndustryTypeOldAudit.equalsIgnoreCase("003"))
			{
				strIndustryTypeDescOldAudit="Agriculture";
			}
			else if(strIndustryTypeOldAudit.equalsIgnoreCase("004"))
			{
				strIndustryTypeDescOldAudit="Infrastructure";
			}
			else if(strIndustryTypeOldAudit.equalsIgnoreCase("005"))
			{
				strIndustryTypeDescOldAudit="Trading";
			}
			else if(strIndustryTypeOldAudit.equalsIgnoreCase("006"))
			{
				strIndustryTypeDescOldAudit="Manufacturing";
			}
			strNBFCLoADescOldAudit="";
			if(strNBFCLoAOldAudit.equalsIgnoreCase("Y"))
			{
				strNBFCLoADescOldAudit="Yes";
			}
			else if(strNBFCLoAOldAudit.equalsIgnoreCase("N"))
			{
				strNBFCLoADescOldAudit="No";
			}
			strNBFCDepositDescOldAudit="";
			if(strNBFCDepositOldAudit.equalsIgnoreCase("Y"))
			{
				strNBFCDepositDescOldAudit="Yes";
			}
			else if(strNBFCDepositOldAudit.equalsIgnoreCase("N"))
			{
				strNBFCDepositDescOldAudit="No";
			}
			strNBFCInfraDescOldAudit="";
			if(strNBFCInfraOldAudit.equalsIgnoreCase("Y"))
			{
				strNBFCInfraDescOldAudit="Yes";
			}
			else if(strNBFCInfraOldAudit.equalsIgnoreCase("N"))
			{
				strNBFCInfraDescOldAudit="No";
			}
			strNBFCAssetDescOldAudit="";
			if(strNBFCAssetOldAudit.equalsIgnoreCase("Y"))
			{
				strNBFCAssetDescOldAudit="Yes";
			}
			else if(strNBFCAssetOldAudit.equalsIgnoreCase("N"))
			{
				strNBFCAssetDescOldAudit="No";
			}
			strMFIDescOldAudit="";
			if(strMFIOldAudit.equalsIgnoreCase("Y"))
			{
				strMFIDescOldAudit="Yes";
			}
			else if(strMFIOldAudit.equalsIgnoreCase("N"))
			{
				strMFIDescOldAudit="No";
			}
			strMajorityDescOldAudit="";
			if(strMajorityOldAudit.equalsIgnoreCase("Y"))
			{
				strMajorityDescOldAudit="Yes";
			}
			else if(strMajorityOldAudit.equalsIgnoreCase("N"))
			{
				strMajorityDescOldAudit="No";
			}
			strNGOFinanceDescOldAudit="";
			if(strNGOFinanceOldAudit.equalsIgnoreCase("Y"))
			{
				strNGOFinanceDescOldAudit="Yes";
			}
			else if(strNGOFinanceOldAudit.equalsIgnoreCase("N"))
			{
				strNGOFinanceDescOldAudit="No";
			}
			
			/*
			 * End - Description from codes
			 */
			
			sbOldAudit.append("CBS Customer ID=").append(strCBSIDOldAudit).append("~Title=").append(strTitleDescOldAudit)
			.append("~Full Name=").append(strFullNameOldAudit).append("~Short Name=").append(strShortNameOldAudit)
			.append("~Father Name=").append(strFatherNameOldAudit).append("~Constitution=").append(strConstitutionDescOldAudit)
			.append("~PAN No=").append(strPANNoOldAudit).append("~Gender=").append(strSexDescOldAudit).append("~DOB=").append(strDOBOldAudit)
			.append("~Marital Status=").append(strMartialStatusDescOldAudit).append("~Status=").append(strStatusDescOldAudit)
			.append("~Borrower Status=").append(strBorrStatusDescOldAudit).append("~Tax Slab=").append(strTaxSlabDescOldAudit)
			.append("~Employment Status=").append(strEmploymentDescOldAudit)
			//.append("~Line of Activity=").append(strLineofActivityDescOldAudit)
			//.append("~Since=").append(strLoASinceOldAudit)
			.append("~Banking with us=").append(strBankingDescOldAudit)
			.append("~Borrower Since=").append(strBorrowerSinceOldAudit)
			.append("~Is salary routed through our bank=").append(strSalaryRoutedOldAudit)
			.append("~Any relation to bank staff or relatives=").append(strStaffRelationDescOldAudit)
			.append("~Staff ID=").append(strRelativeStaffIDOldAudit)
			.append("~Name=").append(strRelationNameOldAudit).append("~Blood relation=").append(strBloodRelationDescOldAudit)
			.append("~Introducer Name=").append(strIntroducerNameOldAudit).append("~Introducer Status=").append(strIntroStatusDescOldAudit)
			.append("~Networth of the Borrower=").append(strNetworth).append("~Networth As on Date=").append(strNetworthAson)
			.append("~Trade Finance=").append(strTradeFinanceDescOldAudit).append("~Inland Trade Allowed=").append(strInlandTradeDescOldAudit)
			.append("~Religion=").append(strCorpReligionDescOldAudit).append("~Satisfactory Dealing=").append(strSatisfactoryDescOldAudit);
			//.append("~Justification Details=").append(strJustificationDetailsOldAudit);

			sbOldAudit.append("~Resident Status=").append(strResidentStatusDescOldAudit).append("~Country=").append(strCountryOldAudit)
			.append("~Whether Staff?=").append(strisStaffDescOldAudit).append("~Date of Joining=").append(strStaffDOJOldAudit)
			.append("~Staff ID=").append(strStaffIDOldAudit).append("~Caste/Tribe=").append(strCasteDescOldAudit)
			.append("~Minority=").append(strMinorityDescOldAudit).append("~Religion=").append(strReligionDescOldAudit)
			.append("~No. of Children Dependents=").append(strChildDepOldAudit)
			.append("~No. of Other Dependents=").append(strOtherDepOldAudit)
			.append("~Earning Member in family=").append(strEarningMemOldAudit)
			.append("~Educational Qualification=").append(strEduQualDescOldAudit).append("~Area Specialized=").append(strAreaSpecialOldAudit)
			.append("~Physically Challenged=").append(strPhysicalChgdDescOldAudit).append("~Ex-Serviceman=").append(strExServiceDescOldAudit)
			.append("~Years of Service=").append(strYearsofServiceOldAudit).append("~Whether Minor=").append(strisMinorDescOldAudit)
			.append("~Guardian CBSID=").append(strGaurdianCBSIDOldAudit).append("~Guardian Name=").append(strGaurdianNameOldAudit)
			.append("~Guardian Relationship=").append(strGaurdianRelnDescOldAudit)
			//.append("~Guardian Address=").append(strGaurdianAddrOldAudit)
			.append("~Spouse Title=").append(strSpouseTitleDescOldAudit).append("~Spouse Name=").append(strSpouseNameOldAudit)
			.append("~Spouse DOB=").append(strSpouseDOBOldAudit).append("~Spouse Occupation=").append(strSpouseOccDescOldAudit)
			.append("~Spouse Qualification=").append(strSpouseQualDescOldAudit).append("~Spouse PAN No=").append(strSpousePANNoOldAudit)
			.append("~Spouse Employer=").append(strSpouseEmployerOldAudit)
			.append("~Spuse Income=").append(strSpouseIncomeOldAudit)
			//.append("~Spouse Address=").append(strSpouseAddrOldAudit)
			.append("~Family Income=").append(strFamilyIncomeOldAudit);

			sbOldAudit.append("~Date of Commencement of business=").append(strCommencementDateOldAudit)
			.append("~Date of Incorporation=").append(strIncorporationDateOldAudit)
			.append("~Type of Ownership=").append(strOwnershipTypeDescOldAudit).append("~ROC Number=").append(strROCNumberOldAudit)
			.append("~CIN=").append(strCINOldAudit).append("~TIN=").append(strTINOldAudit).append("~Group=").append(strGroupNameOldAudit)
			.append("~Industry Type=").append(strIndustryTypeDescOldAudit)
			.append("~Total Employees=").append(strTotalEmployeesOldAudit)
			.append("~Whether Line of Activity undertaken is NBFC=").append(strNBFCLoADescOldAudit)
			.append("~Deposit Taking NBFC=").append(strNBFCDepositDescOldAudit)
			.append("~Infrastructure Financing NBFC=").append(strNBFCInfraDescOldAudit)
			.append("~Asset Financing NBFC=").append(strNBFCAssetDescOldAudit).append("~Whether MFI=").append(strMFIDescOldAudit)
			.append("~Whether majority of members/owners belong to minority community=").append(strMajorityDescOldAudit)
			.append("~SHG Formed/Located at=").append(strSHGLocDescOldAudit).append("~No. of members=").append(strMembersOldAudit)
			.append("~No. of Beneficiaries=").append(strBeneficiariesOldAudit)
			.append("~Promoting Agency/Scheme (if any)=").append(strSHGSchemeDescOldAudit)
			.append("~Whether financed through any NGOs=").append(strNGOFinanceDescOldAudit)
			.append("~Savings Banks account maintained by SHG=").append(strSavingsAcctOldAudit);
			
		}
		catch(Exception e)
		{
			log.error("Exception occured in getOldAuditDemographics"+ e);
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
		return sbOldAudit;
	}
	public static String getCityDistrictStateDesc(String strType, String strCode) 
	{
		ResultSet rs=null;
		String strQuery="";
		String strDesc="";
		try
		{
			if(!strCode.equals(""))
			{
				if(strType.equalsIgnoreCase("city"))
				{
					rs=DBUtils.executeLAPSQuery("sel_citynamebycode^"+strCode);
					if(rs.next())
					{
						strDesc=Helper.correctNull((String)rs.getString("city_name"));
					}
				}
				else if(strType.equalsIgnoreCase("district"))
				{
					rs=DBUtils.executeLAPSQuery("sel_distnamebycode^"+strCode);
					if(rs.next())
					{
						strDesc=Helper.correctNull((String)rs.getString("district_desc"));
					}
				}
				else if(strType.equalsIgnoreCase("state"))
				{
					rs=DBUtils.executeLAPSQuery("sel_statenamebycode^"+strCode);
					if(rs.next())
					{
						strDesc=Helper.correctNull((String)rs.getString("state_name"));
					}
				}
			}
		}
		catch(Exception e)
		{
			log.error("Exception occured in getCityDesc"+ e);
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
		return strDesc;
	}
	
	//Added by Guhan.T to validate Introducer CBS ID
	public HashMap getValidCBSId(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		String strQuery="";
		ResultSet rs=null;
		String strCBSIdavail="";
		String strCBSId=Helper.correctNullCBS((String)hshValues.get("cbsId"));
		String strAPPId=Helper.correctNullCBS((String)hshValues.get("appID"));
		try
		{
			
			if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
			{
				strQuery=SQLParser.getCBSSqlQuery("validate_CBS_ID_newconnection^"+strCBSId);
				rs=DBUtils.executeQueryCBSConnection(strQuery);
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("validate_CBS_ID^"+strCBSId);
				rs = DBUtils.executeQuery(strQuery);
			}
			
				if(rs.next())
				{
					hshRecord.put("cust_id",rs.getString("cust_id"));
					hshRecord.put("cust_name",rs.getString("cust_name"));
					hshRecord.put("app_id",strAPPId);
					strCBSIdavail="Y";
				}
				else
				{
					strCBSIdavail="N";
				}
				hshRecord.put("CBSIdavailflag",strCBSIdavail);
		}
		catch(Exception cf)
		{
			throw new EJBException("Error in getValidCBSId  "+cf.toString());
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
	
	
	
	public void updateBankdetail(HashMap hshValues) 
	{

		//Added by rajesh for other bank details
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;		
		ArrayList arrValues=new ArrayList();
		ResultSet rs = null,rs1=null;
		String strQuery="",strOldid="",strMis_appdata="";
		String strAction=correctNull((String)hshValues.get("hidAction"));
		String strGradeId = Helper.correctNull((String)hshValues.get("idno"));
		String hidDemoId=correctNull((String)hshValues.get("hidDemoId"));
		String hidsno=correctNull((String)hshValues.get("hid_sno"));
		String strUserID=correctNull((String)hshValues.get("strUserId"));
      	
		try
		{
			
			String strFacType=Helper.correctNull((String)hshValues.get("sel_FacilityType"));
			String strBankName=Helper.correctNull((String)hshValues.get("hid_LeadBankcode"));
			String strType=Helper.correctNull((String)hshValues.get("sel_Type"));
			String strFacility=Helper.correctNull((String)hshValues.get("txt_Facility"));
			String strLoanPurpose=Helper.correctNull((String)hshValues.get("sel_loanpurpose"));
			String strLimit=Helper.correctNull((String)hshValues.get("txt_Limit"));
			String strOS=Helper.correctNull((String)hshValues.get("txt_OS"));
			String strOSAsOnDate=Helper.correctNull((String)hshValues.get("txt_OSAsOnDate"));
			String strMonthlyIns=Helper.correctNull((String)hshValues.get("txt_monthlyins"));
			String strBnkType=Helper.correctNull((String)hshValues.get("sel_BnkType"));
			String strIntType=Helper.correctNull((String)hshValues.get("sel_IntType"));
			String strSpreadVal=Helper.correctNull((String)hshValues.get("txt_SpreadVal"));
			String strDueDate=Helper.correctNull((String)hshValues.get("txt_DueDate"));
			String strArrears=Helper.correctNull((String)hshValues.get("txtArea_Arrears"));
			String strRemarks=Helper.correctNull((String)hshValues.get("txtarea_Remarks"));
			String strInterestRate=Helper.correctNull((String)hshValues.get("txt_InterestRate"));
			String strRepayType=Helper.correctNull((String)hshValues.get("com_banksel_repaytype"));
			String strDrawPower=Helper.correctNull((String)hshValues.get("txt_bank_drwpower"));
			String strLeadBankName=Helper.correctNull((String)hshValues.get("hid_Bankcode"));
			String strsecDesc=Helper.correctNull((String)hshValues.get("txt_secDesc"));
			String strsecValue=Helper.correctNull((String)hshValues.get("txt_secValue"));

			String strNatureLitig=Helper.correctNull((String)hshValues.get("txt_NatureLitig"));
			String strDateLitig=Helper.correctNull((String)hshValues.get("txt_DateLitig"));
			String strclaimAmount=Helper.correctNull((String)hshValues.get("txt_claimAmount"));
			String strotherClaim=Helper.correctNull((String)hshValues.get("txt_otherClaim"));
			String strpresentpos=Helper.correctNull((String)hshValues.get("txt_presentpos"));
			String strlitigation=Helper.correctNull((String)hshValues.get("sel_litigation"));

			int intUpdatesize=0;
			
			rs=DBUtils.executeLAPSQuery("per_selectoldidbank^"+hidDemoId);				 
			if(rs.next())
			{
				 strOldid=correctNull(rs.getString("perapp_oldid"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			if(!strAction.equalsIgnoreCase("insert"))
			{
				hidDemoId=Helper.correctInt((String)hshValues.get("hidAppid"));
				rs=DBUtils.executeLAPSQuery("perbankingselectNewOldId^"+hidDemoId);				 
				if(rs.next())
				{
					strMis_appdata=Helper.correctNull(rs.getString("PERBANK_LOANPURPOSE"));
				}

			}
			if(strAction.equalsIgnoreCase("insert"))
			{
				intUpdatesize	= intUpdatesize+1;
				strGradeId = Integer.toString(getMaxGradeId(hidDemoId));
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","perbankinginsertNEW");
				arrValues.add(hidDemoId);//1
				arrValues.add(strOldid);//2
				arrValues.add(strGradeId);//3
				arrValues.add(strFacType);//4
				arrValues.add(strFacility);//5
				arrValues.add(strOSAsOnDate);//6
				arrValues.add(strIntType);//7
				arrValues.add(strBnkType);//8
				arrValues.add(strDueDate);//9
				arrValues.add(strArrears);//10
				arrValues.add(strBankName);//11
				arrValues.add(strType);//12
				arrValues.add(strLimit);//13
				arrValues.add(strOS);//14
				arrValues.add(strSpreadVal);//15
				arrValues.add(strRemarks);//16
				arrValues.add(strMonthlyIns);//17
				arrValues.add(strInterestRate);//18
				arrValues.add(strRepayType);//19
				arrValues.add(strDrawPower);//20
				arrValues.add(strLeadBankName);//21
				arrValues.add(strLoanPurpose);//22
				arrValues.add(strsecDesc);//22
				arrValues.add(strsecValue);//22
				arrValues.add(strNatureLitig);//23
				arrValues.add(strDateLitig);//24
				arrValues.add(strclaimAmount);//25
				arrValues.add(strotherClaim);//26
				arrValues.add(strpresentpos);//27
				arrValues.add(strlitigation);//28
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_StartDate")));//29
				//arrValues.add(Helper.correctNull((String)hshValues.get("sel_fac_otherbank")));//29//perapp_facility_othbank
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);

				if(strBnkType.equalsIgnoreCase("C") ||strBnkType.equalsIgnoreCase("M"))
				{
					intUpdatesize	= intUpdatesize+1;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","2");
					hshQuery.put("strQueryId","perconstbankingins");
					arrValues.add(strFacType);//1
					arrValues.add(strFacility);//2
					arrValues.add(strType);//3
					arrValues.add(strBankName);//4
					arrValues.add(strBnkType);//5
					arrValues.add(strLeadBankName);//6
					arrValues.add("0");//7
					arrValues.add("0");//8
					arrValues.add(hidDemoId);//9
					arrValues.add(strGradeId);//10
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				}
				//if(strLoanPurpose.equals("6")){
				intUpdatesize	= intUpdatesize+1;
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					arrValues.add(hidDemoId);
					arrValues.add(hidDemoId);
					hshQuery.put("strQueryId","upd_misreselectflag"); 
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				//}
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			else if(strAction.equalsIgnoreCase("update"))
			{
				intUpdatesize	= intUpdatesize+1;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","perbankingupdateNEW");
				arrValues.add(strFacType);//1
				arrValues.add(strFacility);//2
				arrValues.add(strOSAsOnDate);//3
				arrValues.add(strIntType);//4
				arrValues.add(strBnkType);//5
				arrValues.add(strDueDate);//6
				arrValues.add(strArrears);//7
				arrValues.add(strBankName);//8
				arrValues.add(strType);//9
				arrValues.add(strLimit);//10
				arrValues.add(strOS);//11
				arrValues.add(strSpreadVal);//12
				arrValues.add(strRemarks);//13
				arrValues.add(strMonthlyIns);//14
				arrValues.add(strInterestRate);//15
				arrValues.add(strRepayType);//16	
				arrValues.add(strDrawPower);//17
				arrValues.add(strLeadBankName);//18
				arrValues.add(strLoanPurpose);//19
				arrValues.add(strsecDesc);//20
				arrValues.add(strsecValue);//21
				arrValues.add(strNatureLitig);// 
				arrValues.add(strDateLitig);// 
				arrValues.add(strclaimAmount);// 
				arrValues.add(strotherClaim);// 
				arrValues.add(strpresentpos);// 
				arrValues.add(strlitigation);// 
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_StartDate")));
				//arrValues.add(Helper.correctNull((String)hshValues.get("sel_fac_otherbank")));//29//perapp_facility_othbank
				arrValues.add(hidDemoId);// 
				arrValues.add(strGradeId);// 
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				if(rs!=null)
				{
					rs.close();
				}
				rs=DBUtils.executeLAPSQuery("perconstbankingselsno^"+hidDemoId+"^"+strGradeId);				 
				if(rs.next())
				{
					if(strBnkType.equalsIgnoreCase("C") ||strBnkType.equalsIgnoreCase("M"))
					{
						intUpdatesize	= intUpdatesize+1;
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQueryValues.put("size","2");
						hshQuery.put("strQueryId","perconstbankingupd");
						arrValues.add(strFacType);//1
						arrValues.add(strFacility);//2
						arrValues.add(strType);//3
						arrValues.add(strBankName);//4
						arrValues.add(strBnkType);//5
						arrValues.add(hidDemoId);//9
						arrValues.add(strGradeId);//10
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					}
					else
					{
						intUpdatesize	= intUpdatesize+1;
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQueryValues.put("size","2");
						hshQuery.put("strQueryId","perconstbankingdel1");
						arrValues.add(hidDemoId);
						arrValues.add(strGradeId);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					}
				}
				else
				{
					intUpdatesize	= intUpdatesize+1;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","perconstbankingins");
					arrValues.add(strFacType);//1
					arrValues.add(strFacility);//2
					arrValues.add(strType);//3
					arrValues.add(strBankName);//4
					arrValues.add(strBnkType);//5
					arrValues.add(strLeadBankName);//6
					arrValues.add("0");//7
					arrValues.add("0");//8
					arrValues.add(hidDemoId);//9
					arrValues.add(strGradeId);//10
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					
				}
				if((!strLoanPurpose.equals(strMis_appdata)) && (strLoanPurpose.equals("6") || strMis_appdata.equals("6"))){
				intUpdatesize	= intUpdatesize+1;
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				arrValues.add(hidDemoId);
				arrValues.add(hidDemoId);
				hshQuery.put("strQueryId","upd_misreselectflag"); 
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				}
				
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
			}
			
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","perbankingdeleteNEW");
				arrValues.add("Y");
				arrValues.add(strUserID);
				arrValues.add(hidDemoId);
				arrValues.add(strGradeId);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strBnkType.equalsIgnoreCase("C") ||strBnkType.equalsIgnoreCase("M"))
			{
				if(strAction.equalsIgnoreCase("delete"))
				{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","perconstbankingdel");
				arrValues.add("Y");
				arrValues.add(hidDemoId);
				arrValues.add(strGradeId);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
			}	
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
	
	public HashMap getBankdetail(HashMap hshValues) 
	{
		
		HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();
		ArrayList vecVal=new ArrayList();
		ResultSet rs = null,rs1 = null;
		String strprd_type=correctNull((String)hshValues.get("strProductType"));
		String hidDemoId=correctNull((String)hshValues.get("hidDemoId"));
		String strcomappid= correctNull((String)hshValues.get("hidapplicantid"));
		String strProfilestatus="",strQuery="",strQuery1="",strFacname="",strBankingcode="";
		String strAppStatus=Helper.correctNull((String)hshValues.get("hidappstatus"));
		try
		{
		
		if(strcomappid.equalsIgnoreCase(""))
		{
			strcomappid=Helper.correctNull((String)hshValues.get("hidAppId"));
		}
		if(hidDemoId.equals(""))
		{
			hidDemoId= correctNull((String)hshValues.get("hidapplicantnewid"));
		}
		rs=DBUtils.executeLAPSQuery("per_selectoldidbank^"+hidDemoId);				 
		if(rs.next())
		{
			strcomappid=correctNull(rs.getString("perapp_oldid"));
		}
		if(rs!=null)
		{rs.close();}
		strQuery = SQLParser.getSqlQuery("perbankingselectNewOldId^"+strcomappid);
		rs = DBUtils.executeQuery(strQuery);
		while(rs.next())
		{
			vecVal=new ArrayList();
			vecVal.add(Helper.correctInt((String)rs.getString("perbank_sno")));//0
			vecVal.add(Helper.correctInt((String)rs.getString("perbank_type")));//1
			vecVal.add(Helper.correctNull((String)rs.getString("perbank_facility")));//2
			vecVal.add(Helper.correctNull((String)rs.getString("perbank_osasondate")));//3
			vecVal.add(Helper.correctNull((String)rs.getString("perbank_inttype")));//4
			vecVal.add(Helper.correctNull((String)rs.getString("perbank_bnktype")));//5
			vecVal.add(Helper.correctNull((String)rs.getString("perbank_duedate")));//6
			vecVal.add(Helper.CLOBToString(rs.getClob("perbank_arrears")));//7
			strBankingcode=Helper.correctNull((String)rs.getString("perbank_bnkname"));
			rs1 = DBUtils.executeLAPSQuery("getstaticdescription^"+"147"+"^"+strBankingcode);
			if(rs1.next())
			{
				vecVal.add(Helper.correctNull(rs1.getString("STAT_DATA_DESC1")));//8
			}
			else
			{
				vecVal.add("");//8
				
			}
			vecVal.add(Helper.correctNull((String)rs.getString("perbank_fundtype")));//9
			vecVal.add(Helper.correctNull((String)rs.getString("perbank_limit")));//10
			vecVal.add(Helper.correctNull((String)rs.getString("perbank_os")));//11
			vecVal.add(Helper.correctNull((String)rs.getString("perbank_spread")));//12
			vecVal.add(Helper.CLOBToString(rs.getClob("perbank_remarks")));//13
			vecVal.add(Helper.correctNull((String)rs.getString("perbank_monthly_ins")));//14
			vecVal.add(Helper.correctNull((String)rs.getString("perbank_intrate")));//15			
			vecVal.add(Helper.correctNull((String)rs.getString("per_repaymenttype")));//16
			vecVal.add(Helper.correctNull((String)rs.getString("per_drawingpower")));//17
			vecVal.add(strBankingcode);//18
			strBankingcode=Helper.correctNull(rs.getString("perbank_leaderbank"));
			if(rs1!=null)
			{
				rs1.close();
			}
			rs1=DBUtils.executeLAPSQuery("getstaticdescription^"+"147"+"^"+strBankingcode);
			if(rs1.next())
			{
				vecVal.add(Helper.correctNull(rs1.getString("STAT_DATA_DESC1")));//19
			}
			else
			{
				vecVal.add("");//19
				
			}
			vecVal.add(strBankingcode);//20
			vecVal.add(Helper.correctNull((String)rs.getString("perbank_id")));//21
			vecVal.add(Helper.correctNull((String)rs.getString("PERBANK_LOANPURPOSE")));//22
			vecVal.add(Helper.correctNull((String)rs.getString("PERBANK_SECDESCRIP")));//23
			vecVal.add(Helper.correctNull((String)rs.getString("PERBANK_SECVALUE")));//24
			
			vecVal.add(Helper.correctNull((String)rs.getString("PERBANK_NATURELITIGATION")));//25
			vecVal.add(Helper.correctNull((String)rs.getString("PERBANK_DATELITIGATION")));//26
			vecVal.add(Helper.correctNull((String)rs.getString("PERBANK_CLAIMAMOUNT")));//27
			vecVal.add(Helper.correctNull((String)rs.getString("PERBANK_OTHERCLAIMS")));//28
			vecVal.add(Helper.correctNull((String)rs.getString("PERBANK_PRESENTPOS")));//29
			vecVal.add(Helper.correctNull((String)rs.getString("PERBANK_LITIGATIONS")));//30
			vecVal.add(Helper.correctNull(rs.getString("perbank_startdate")));//31
			//vecVal.add(Helper.correctNull(rs.getString("perapp_facility_othbank")));//29//perapp_facility_othbank
			vecData.add(vecVal);
		
		}
		
		HashMap prof=new HashMap();
		HashMap profile=new HashMap();
		prof.put("profile_id",hidDemoId);
		profile=(HashMap)getCustomerProfileStatus(prof);
		hshRecord.put("strIncompletepage", Helper.correctNull((String)profile.get("strIncompletepage")));
		if(rs!=null)
		{
			rs.close();
		}
		rs=DBUtils.executeLAPSQuery("getprofilestatusfromdemographic^"+hidDemoId);
		if(rs.next())
		{
			strProfilestatus=Helper.correctNull((String)rs.getString("perapp_profilestatus"));
			
		}	
		else
		{
			strProfilestatus="";
		}
		rs=DBUtils.executeLAPSQuery("perconstbankingsel^"+hidDemoId);
		if(rs.next())
		{
			strFacname=Helper.correctNull((String)rs.getString("cus_facname"));
		}
		hshRecord.put("strFacname",strFacname);
		hshRecord.put("vecData",vecData);
		hshRecord.put("hidAppId",strcomappid);
		hshRecord.put("strProfilestatus",strProfilestatus);
		hshRecord.put("appstatus",strAppStatus);
		
	}
	catch(Exception ce)
	{		
		throw new EJBException("Error in getBankDetails "+ce.toString());
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
	public void updateLandbuild(HashMap hshValues) 
	{

		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;		
		ArrayList arrValues=new ArrayList();
		int flag=0;
		String strQuery="";
	//	String chobank_apptype = Helper.correctNull((String)hshValues.get("chobank_apptype"));
		String strAction=correctNull((String)hshValues.get("hidAction"));
		String strGradeId = "";
		//String appno=correctNull((String)hshValues.get("strappno"));
		String hidDemoId=correctNull((String)hshValues.get("hidDemoId"));
		String measurementtype = Helper.correctNull((String)hshValues.get("land_measurement"));
      	String measurementval="";
    	if(measurementtype.equalsIgnoreCase("c"))
  		{
    		 measurementval = "Cents";
 		}
 		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		StringBuilder sbAuditTrialOld = null;
		try
		{
			sbAuditTrialOld = new StringBuilder();
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete")){
			strGradeId =  correctNull((String)hshValues.get("selsno"));
			strQuery = SQLParser.getSqlQuery("agrlandholdingssel_audit^"+hidDemoId+"^"+strGradeId);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				String strAppType1="",strAppName="";
				/*String strAppType = Helper.correctNull(rs.getString("land_apptype"));
				String strAppType1 = "";
				if(strAppType.substring(0,1).equalsIgnoreCase("a")){
					strAppType1 = "Applicant";
				}else if(strAppType.substring(0,1).equalsIgnoreCase("c")){
					strAppType1 = "Co-Applicant";
				}else if(strAppType.substring(0,1).equalsIgnoreCase("g")){
					strAppType1 = "Guarantor";
				}
				int len = strAppType.length();
				String strAppValue = strAppType.substring(1,len);
				strQuery = SQLParser.getSqlQuery("getAppName^"+strAppValue);
				rs1 = DBUtils.executeQuery(strQuery);
				String strAppName = "";
				if(rs1.next()){
					strAppName = correctNull(rs1.getString("perapp_name"));
				}*/
				sbAuditTrialOld
				.append("~Village = ").append(correctNull(rs.getString("land_village")))
				.append("~Taluk = ").append(correctNull(rs.getString("land_taluk")))
				.append("~District = ").append(correctNull(rs.getString("land_district")))
				.append("~Survey No = ").append(correctNull(rs.getString("land_survey")))
				.append("~Land revenue (Rs) = ").append(correctNull(rs.getString("land_revenue")))
				.append("~Value (Rs in Lakh) = ").append(correctNull(rs.getString("land_value")))
				.append("~Extent (Inclusive of Encroached Land) Acre = ").append(correctNull(rs.getString("land_acreage"))+"Acre"+correctNull(rs.getString("land_acreage1"))+"Cents");
				if(correctNull(rs.getString("land_owned_leased")).equalsIgnoreCase("1")){
				sbAuditTrialOld.append("~Whether Owned/Leased = ").append("Owned");
				}
				else if(correctNull(rs.getString("land_owned_leased")).equalsIgnoreCase("2")){
				sbAuditTrialOld.append("~Whether Owned/Leased = ").append("Leased");
				sbAuditTrialOld
				.append("~Unexpired Lease / Rent period = ").append(correctNull(rs.getString("land_leaseperiod")))
				.append("~Annual rent payable = ").append(correctNull(rs.getString("land_rent_repay")));
				}
				else if(correctNull(rs.getString("land_owned_leased")).equalsIgnoreCase("3")){
				sbAuditTrialOld.append("~Whether Owned/Leased = ").append("Share Cropper");
				}else if(correctNull(rs.getString("land_owned_leased")).equalsIgnoreCase("4")){
				sbAuditTrialOld.append("~Whether Owned/Leased = ").append("Others");
				}
				sbAuditTrialOld
				.append("~Security = ").append(ApplicantParams.getApplicantParams("LandHoldingsSecutrity",correctNull(rs.getString("land_security"))));
				if(correctNull(rs.getString("land_security")).equalsIgnoreCase("1"))
				{
				sbAuditTrialOld	
				.append("~Mortgage = ").append(ApplicantParams.getApplicantParams("LandHoldingsMortgage",correctNull(rs.getString("land_mortgage"))))
				.append("~Date of charge/mortgage = ").append(correctNull(rs.getString("land_datemortgage")));
				}
				sbAuditTrialOld
				.append("~Particulars of land = ").append(ApplicantParams.getApplicantParams("LandHoldingsParticulars",correctNull(rs.getString("land_irrigated"))))
				.append("~Farm Distance From Our Branch = ").append(correctNull(rs.getString("land_farmdistance")))
				.append("~House Distance From Our Branch = ").append(correctNull(rs.getString("land_housedistance")));
			   }
			 if(rs!=null){
				 rs.close();
			 }
			/* strQuery = SQLParser.getSqlQuery("agr_grossdatasel^"+hidDemoId+"^"+chobank_apptype);
			 rs = DBUtils.executeQuery(strQuery);
			 if(rs.next()){
				 sbAuditTrialOld
				.append("~   Last Three Years Production Data(Grross) ")
				.append("~Year1 =").append(correctNull(rs.getString("year1"))).append(" Gross Income (Rs.) =").append(correctNull(rs.getString("grossinc1")))
				.append("~Year2 =").append(correctNull(rs.getString("year2"))).append(" Gross Income (Rs.) =").append(correctNull(rs.getString("grossinc2")))
				.append("~Year3 =").append(correctNull(rs.getString("year3"))).append(" Gross Income (Rs.) =").append(correctNull(rs.getString("grossinc3")));
			 }*/
			
			}
			if(strAction.equals("update"))
			{
				strGradeId =  correctNull((String)hshValues.get("selsno"));	
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","agrlandholdingsupdate");			
				arrValues.add("a");//0
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_acreage")));//1
				arrValues.add(Helper.correctNull((String)hshValues.get("village")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_taluk")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_district")));
				arrValues.add(Helper.correctNull((String)hshValues.get("survey")));
				String val4=Helper.correctNull((String)hshValues.get("txt_landrevenue"));//6
				if(val4.equalsIgnoreCase(""))
				{
					val4="0.00";
				}
				arrValues.add(val4);//7
				String val=Helper.correctNull((String)hshValues.get("txt_value"));
				if(val.equalsIgnoreCase(""))
				{
					val="0.00";
				}
				arrValues.add(val);//8
				arrValues.add(Helper.correctNull((String)hshValues.get("sellease")));//9
				String val1=Helper.correctNull((String)hshValues.get("leaseperiod"));
				if(val1.equalsIgnoreCase(""))
				{
					val1="0";
				}
				arrValues.add(val1);//10
				String val2=Helper.correctNull((String)hshValues.get("txt_amtrent"));
				if(val2.equalsIgnoreCase(""))
				{
					val2="0.00";
				}
				arrValues.add(val2);//11
				arrValues.add(Helper.correctNull((String)hshValues.get("selirrigation")));
				arrValues.add(Helper.correctNull((String)hshValues.get("irrigated")));
				arrValues.add(Helper.correctNull((String)hshValues.get("source")));//14
				arrValues.add(Helper.correctNull((String)hshValues.get("encumbrance")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txr_encroached")));
				arrValues.add(Helper.correctNull((String)hshValues.get("farmdistance")));
				arrValues.add(Helper.correctNull((String)hshValues.get("housedistance")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txr_address")));//18
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_acreage1")));
				arrValues.add("");
				arrValues.add("");
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_fruit")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_nonfruit")));//24
				arrValues.add("");
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Irrigated")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_nonIrrigated")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_nonCultivable")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Cultivable")));//29
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_FarmerCategory")));//30
				if(Helper.correctNull((String)hshValues.get("sel_FarmerCategory")).equalsIgnoreCase("021"))
					arrValues.add(Helper.correctNull((String)hshValues.get("sel_landless_options")));
				else
					arrValues.add("");
				arrValues.add(hidDemoId);
				arrValues.add(strGradeId);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			if(strAction.trim().equals("insert"))
			{
				int termId = 0;
				strQuery = SQLParser.getSqlQuery("agrlandholdingsmax^"+hidDemoId);
				rs = DBUtils.executeQuery(strQuery);
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
				if(rs!=null)rs.close();	
				strGradeId = Integer.toString(termId);
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");	
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","agrlandholdingsinsert");
				arrValues.add(hidDemoId);
				arrValues.add(strGradeId);
				arrValues.add("a");
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_acreage")));
				arrValues.add(Helper.correctNull((String)hshValues.get("village")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_taluk")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_district")));
				arrValues.add(Helper.correctNull((String)hshValues.get("survey")));
				String val4=Helper.correctNull((String)hshValues.get("txt_landrevenue"));
				if(val4.equalsIgnoreCase(""))
				{
					val4="0.00";
				}
				arrValues.add(val4);
				String val=Helper.correctNull((String)hshValues.get("txt_value"));
				if(val.equalsIgnoreCase(""))
				{
					val="0.00";
				}
				arrValues.add(val);
				arrValues.add(Helper.correctNull((String)hshValues.get("sellease")));
				String val1=Helper.correctNull((String)hshValues.get("leaseperiod"));
				if(val1.equalsIgnoreCase(""))
				{
					val1="0";
				}
				arrValues.add(val1);
				String val2=Helper.correctNull((String)hshValues.get("txt_amtrent"));
				if(val2.equalsIgnoreCase(""))
				{
					val2="0.00";
				}
				arrValues.add(val2);
				arrValues.add(Helper.correctNull((String)hshValues.get("selirrigation")));
				arrValues.add(Helper.correctNull((String)hshValues.get("irrigated")));
				arrValues.add(Helper.correctNull((String)hshValues.get("source")));
				arrValues.add(Helper.correctNull((String)hshValues.get("encumbrance")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txr_encroached")));
				arrValues.add(Helper.correctNull((String)hshValues.get("farmdistance")));
				arrValues.add(Helper.correctNull((String)hshValues.get("housedistance")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txr_address")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_acreage1")));
				arrValues.add(Helper.correctNull((String)hshValues.get("Mortgage")));
				arrValues.add(Helper.correctNull((String)hshValues.get("security")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_fruit")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_nonfruit")));
				arrValues.add("");
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Irrigated")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_nonIrrigated")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_nonCultivable")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Cultivable")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_FarmerCategory")));
				if(Helper.correctNull((String)hshValues.get("sel_FarmerCategory")).equalsIgnoreCase("021"))
					arrValues.add(Helper.correctNull((String)hshValues.get("sel_landless_options")));
				else
					arrValues.add("");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equals("delete"))
			{
				strGradeId =  correctNull((String)hshValues.get("selsno"));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","agrlandholdingsdelete");
				arrValues.add(hidDemoId);
				arrValues.add(strGradeId);				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
								
				//commented by Archunan for Last three years production removed 
				/*strQuery = SQLParser.getSqlQuery("agrlandholdingssel_apptype^"+hidDemoId+"^"+strGradeId);
				rs2 =DBUtils.executeQuery(strQuery);				
				if(rs2.next())
				{
					flag=1;
				}
				else
				{
					flag=0;
				}
				
				if(flag==0)
				{
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();					
					hshQueryValues.put("size","1");
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","agr_grossdatadel");
					arrValues.add(hidDemoId);
					arrValues.add(Helper.correctNull((String)hshValues.get("chobank_apptype")));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}*/
			}
			
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();	
			hshQueryValues.put("size","1");
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","update_farmercategory");
			arrValues.add(Helper.correctNull((String)hshValues.get("sel_FarmerCategory")));
			arrValues.add(hidDemoId);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();	
			hshQueryValues.put("size","1");
			arrValues=new ArrayList();
			arrValues.add(hidDemoId);
			arrValues.add(hidDemoId);
			hshQuery.put("strQueryId","upd_misreselectflag"); 
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			//commented by Archunan for Last three years production removed 
			/*if(strAction.equals("insert") || strAction.equals("update"))
			{
				arrValues = new ArrayList();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","agr_grossdatadel");
				arrValues.add(hidDemoId);
				arrValues.add(Helper.correctNull((String)hshValues.get("chobank_apptype")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
	            hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(hidDemoId);
				arrValues.add(Helper.correctNull((String)hshValues.get("chobank_apptype")));
				arrValues.add(strGradeId);
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_year1")));
				
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_year2")));
				
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_year3")));
				
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_grossinc1")));
				
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_grossinc2")));
				
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_grossinc3")));
				
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "agr_grossdatains");
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}*/
			StringBuilder sbAuditTrial=new StringBuilder();
			if(strAction.equals("insert") || strAction.equals("update"))
			{
			sbAuditTrial
			.append("~Village = ").append(correctNull((String)hshValues.get("village")))
			.append("~Taluk = ").append(correctNull((String)hshValues.get("txt_taluk")))
			.append("~District = ").append(correctNull((String)hshValues.get("txt_district")))
			.append("~Survey No = ").append(correctNull((String)hshValues.get("survey")))
			.append("~Land revenue (Rs) = ").append(correctNull((String)hshValues.get("txt_landrevenue")))
			.append("~Value (Rs in Lakh) = ").append(correctNull((String)hshValues.get("txt_value")))
			.append("~Extent (Inclusive of Encroached Land) Acre = ").append(correctNull((String)hshValues.get("txt_acreage")))
			.append("~"+measurementval+" = ").append(correctNull((String)hshValues.get("txt_acreage1")));
			
			if(correctNull((String)hshValues.get("sellease")).equalsIgnoreCase("1"))
			{
				sbAuditTrial.append("~Whether Owned/Leased = ").append("Owned");
			}else if(correctNull((String)hshValues.get("sellease")).equals("2"))
			{	
				sbAuditTrial
				.append("~Whether Owned/Leased = ").append("Leased")
				.append("~Unexpired Lease / Rent period = ").append(correctNull((String)hshValues.get("leaseperiod")))
				.append("~Annual rent payable = ").append(correctNull((String)hshValues.get("txt_amtrent")));
			}else if(correctNull((String)hshValues.get("sellease")).equalsIgnoreCase("3"))
			{
				sbAuditTrial.append("~Whether Owned/Leased = ").append("Share Cropper");
			}else if(correctNull((String)hshValues.get("sellease")).equalsIgnoreCase("4"))
			{
				sbAuditTrial.append("~Whether Owned/Leased = ").append("Others");
			}
			
			sbAuditTrial.append(
			"~Security = ").append(ApplicantParams.getApplicantParams("LandHoldingsSecutrity",correctNull((String)hshValues.get("security"))));
			if(correctNull((String)hshValues.get("security")).equalsIgnoreCase("1")){
			sbAuditTrial
			.append("~Mortgage = ").append(ApplicantParams.getApplicantParams("LandHoldingsMortgage",correctNull((String)hshValues.get("Mortgage"))))
			.append("~Date of charge/mortgage = ").append(correctNull((String)hshValues.get("txt_dateofmortgage")));
			}
			sbAuditTrial
			.append("~Particulars of land = ").append(ApplicantParams.getApplicantParams("LandHoldingsParticulars",correctNull((String)hshValues.get("selirrigation")))).append(
			"~Farm Distance From Our Branch = ").append(correctNull((String)hshValues.get("farmdistance"))).append(
			"~House Distance From Our Branch = ").append(correctNull((String)hshValues.get("housedistance")));
			
			/*sbAuditTrial
			.append("~   Last Three Years Production Data(Gross) ")
			.append("~Year1 =").append(correctNull((String)hshValues.get("txt_year1"))).append(" Gross Income (Rs.) =").append(correctNull((String)hshValues.get("txt_grossinc1")))
			.append("~Year2 =").append(correctNull((String)hshValues.get("txt_year2"))).append(" Gross Income (Rs.) =").append(correctNull((String)hshValues.get("txt_grossinc2")))
			.append("~Year3 =").append(correctNull((String)hshValues.get("txt_year3"))).append(" Gross Income (Rs.) =").append(correctNull((String)hshValues.get("txt_grossinc3")));*/
			}
			if(!strAction.equalsIgnoreCase("get"))
			{
			AuditTrial.auditNewLog(hshValues, "217", hidDemoId, sbAuditTrial.toString(), sbAuditTrialOld.toString());
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
		}
		finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				}
				if(rs2 != null)
				{
					rs2.close();
				}
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
	}
	
	public HashMap getLandbuild(HashMap hshValues) 
	{
		String strQuery="";
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		ResultSet rs3  = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();
		ArrayList vecVal=new ArrayList();
		String strprd_type=correctNull((String)hshValues.get("strProductType"));
		String prd_type="";
		if(!strprd_type.equalsIgnoreCase(""))
		{
			prd_type=strprd_type.substring(0,1);
		}
		//String chobank_apptype=Helper.correctNull((String)hshValues.get("chobank_apptype"));
		String  strAppType="",strAppID="",appType="",strAppName="";
		String strProfilestatus="",strAppStatus="",strCBSID="",strFarmcategory="";
		try
		{
			strAppStatus=Helper.correctNull((String)hshValues.get("hidappstatus"));
			String hidDemoId=correctNull((String)hshValues.get("hidDemoId"));
			//String appno=correctNull((String)hshValues.get("strappno"));
			//if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
			//{
				//	appno = Helper.correctNull((String)hshValues.get("appno"));
	//		}
			String strAction = correctNull((String)hshValues.get("hidAction"));
			String strGradeNo= correctNull((String)hshValues.get("selsno"));
			/*strQuery = SQLParser.getSqlQuery("agrcomfunsel2^"+hidDemoId);
			rs1 = DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				hshRecord.put("app_name",Helper.correctDoubleQuote(correctNull(rs1.getString("app_name"))) );
				hshRecord.put("app_status",Helper.correctDoubleQuote(correctNull(rs1.getString("app_status"))) );
				hshRecord.put("applicantid",rs1.getString("demo_appid"));
			}*/
			if(strAction.trim().equals("get"))
			{
				/*strQuery = SQLParser.getSqlQuery("agr_grossdatasel^"+hidDemoId);
				rs2 =DBUtils.executeQuery(strQuery);
				while(rs2.next())
				{
					hshRecord.put("year1",correctNull(rs2.getString("year1")));
					hshRecord.put("year2",correctNull(rs2.getString("year2")));
					hshRecord.put("year3",correctNull(rs2.getString("year3")));
					hshRecord.put("grossinc1",correctNull(rs2.getString("grossinc1")));
					hshRecord.put("grossinc2",correctNull(rs2.getString("grossinc2")));
					hshRecord.put("grossinc3",correctNull(rs2.getString("grossinc3")));
				}*/
			}
				strQuery = SQLParser.getSqlQuery("agrlandholdingsselection^"+hidDemoId);
				rs2 =DBUtils.executeQuery(strQuery);
				while(rs2.next())
				{
					vecVal = new ArrayList();
					vecVal.add(correctNull(rs2.getString("LAND_APPID")));
					vecVal.add(correctNull(rs2.getString("land_apptype")));
					/*strAppType=correctNull(rs2.getString("land_apptype"));
					strAppID=strAppType.substring(1);
					appType=strAppType.substring(0,1);
					if(prd_type.equalsIgnoreCase("a")){
						strQuery = SQLParser.getSqlQuery("cr_getcoappguarantor^"+hidDemoId+"^"+appType.toUpperCase()+"^"+strAppID);
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							strAppName=correctNull(rs.getString("appname"));
						}
					}*/
					vecVal.add(correctNull(rs2.getString("land_id")));
					vecVal.add(correctNull(rs2.getString("land_acreage")));
					vecVal.add(correctNull(rs2.getString("land_village")));
					vecVal.add(correctNull(rs2.getString("land_taluk")));
					vecVal.add(correctNull(rs2.getString("land_district")));
					vecVal.add(correctNull(rs2.getString("land_survey")));
					vecVal.add(correctNull(rs2.getString("land_revenue")));
					vecVal.add(correctNull(rs2.getString("land_value")));
					vecVal.add(correctNull(rs2.getString("land_owned_leased")));
					vecVal.add(correctNull(rs2.getString("land_leaseperiod")));
					vecVal.add(correctNull(rs2.getString("land_rent_repay")));
					vecVal.add(correctNull(rs2.getString("land_irrigated")));
					vecVal.add(correctNull(rs2.getString("land_which_irrigated")));
					vecVal.add(Helper.correctNull(Helper.CLOBToString((rs2.getClob("land_source")))));
					vecVal.add(Helper.correctNull(Helper.CLOBToString((rs2.getClob("land_encumbrance")))));
					vecVal.add(Helper.correctNull(Helper.CLOBToString((rs2.getClob("land_Encroached_Land")))));
					vecVal.add(correctNull(rs2.getString("land_farmdistance")));
					vecVal.add(correctNull(rs2.getString("land_housedistance")));
					vecVal.add(Helper.correctNull(Helper.CLOBToString((rs2.getClob("land_landlorddetails")))));//20
					vecVal.add(correctNull(rs2.getString("land_acreage1")));
					vecVal.add(correctNull(rs2.getString("land_mortgage")));
					vecVal.add(correctNull(rs2.getString("land_security")));
					vecVal.add("");
					vecVal.add(Helper.correctNull(Helper.CLOBToString((rs2.getClob("LAND_FRUIT")))));
					vecVal.add(Helper.correctNull(Helper.CLOBToString((rs2.getClob("land_nonfruit")))));
					vecVal.add(correctNull(rs2.getString("land_datemortgage")));
					vecVal.add(correctNull(rs2.getString("LAND_IRRIGSIZE")));
					vecVal.add(correctNull(rs2.getString("LAND_NONIRRIGA")));
					vecVal.add(correctNull(rs2.getString("LAND_NONCULTIVATABLE")));
					vecVal.add(correctNull(rs2.getString("LAND_CULTIVATABLE")));
					vecVal.add(correctNull(rs2.getString("LAND_FARMERCATEGORY")));
					vecVal.add(correctNull(rs2.getString("LAND_LLF_TYPE")));
					strFarmcategory=Helper.correctNull(rs2.getString("LAND_FARMERCATEGORY"));
					if(!strFarmcategory.equalsIgnoreCase(""))
					{
						hshRecord.put("strFarmcategory",strFarmcategory);
					}
					/*strQuery = SQLParser.getSqlQuery("agr_grossdatasel^"+hidDemoId+"^"+strAppType);
					rs1 =DBUtils.executeQuery(strQuery);
					while(rs1.next())
					{
						vecVal.add(correctNull(rs1.getString("year1")));
						vecVal.add(correctNull(rs1.getString("year2")));
						vecVal.add(correctNull(rs1.getString("year3")));
						vecVal.add(correctNull(rs1.getString("grossinc1")));
						vecVal.add(correctNull(rs1.getString("grossinc2")));
						vecVal.add(correctNull(rs1.getString("grossinc3")));
					}*/
					vecData.add(vecVal);		
				}
			hshRecord.put("vecData",vecData);
	    	/*strQuery = SQLParser.getSqlQuery("agrlandmeasurement^"+hidDemoId);
			rs3 = DBUtils.executeQuery(strQuery);
			if(rs3.next())
			{
				hshRecord.put("land_measurement",Helper.correctNull(rs3.getString("land_measurement")));
			}*/
			rs = DBUtils.executeLAPSQuery("selLandAcreage^" + hidDemoId);
			if(rs.next())
			{
				hshRecord.put("strAcress", correctNull((String) rs.getString(1)));
			}
			if(rs!=null)
			{
				rs.close();
			}
			
			
			hshRecord.put("applicantId",hidDemoId);
			
			HashMap prof=new HashMap();
			HashMap profile=new HashMap();
			prof.put("profile_id",hidDemoId);
			profile=(HashMap)getCustomerProfileStatus(prof);
			hshRecord.put("strIncompletepage", Helper.correctNull((String)profile.get("strIncompletepage")));
		
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("getprofilestatusfromdemographic^"+hidDemoId);
			if(rs.next())
			{
				strProfilestatus=Helper.correctNull((String)rs.getString("perapp_profilestatus"));
				strCBSID=Helper.correctNull((String)rs.getString("perapp_cbsid"));
			}
			
			
			//hshRecord.put("chobank_apptype",chobank_apptype);
			hshRecord.put("hidAction",strAction);
			hshRecord.put("strProfilestatus",strProfilestatus);
			hshRecord.put("appstatus", strAppStatus);
			hshRecord.put("strCBSID", strCBSID);
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
				if(rs2 != null)
				{
					rs2.close();
				}
				if(rs3 != null)
				{
					rs3.close();
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
	private int getMaxGradeId(String hidDemoId)
	{
		ResultSet rs = null;
		int termId = 0;

		try
		{
			rs=DBUtils.executeLAPSQuery("perbankingmaxFI^"+hidDemoId);
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
	public HashMap getConsBankdetail(HashMap hshValues) 
	{
		
		HashMap hshRecord = new HashMap();
		ArrayList arrCol	= new ArrayList();
		ArrayList arrRow	= new ArrayList();
		ResultSet rs = null,rs1=null;
		String strprd_type=correctNull((String)hshValues.get("strProductType"));
		String hidDemoId=correctNull((String)hshValues.get("hidDemoId"));
		String strcomappid= correctNull((String)hshValues.get("hidapplicantid"));
		String strProfilestatus="",strQuery="",strQuery1="",strFacType="",strBankingArrangement="";
		String strsno="",strno="",strBankcode="";
		try
		{
		
		
		strQuery = SQLParser.getSqlQuery("perconstbankingsel^"+hidDemoId);
		rs = DBUtils.executeQuery(strQuery);
		while(rs.next())
		{
			arrCol	= new ArrayList();
			arrCol.add(Helper.correctNull((String)rs.getString("cus_sno")));//0
			if(correctNull(rs.getString("cus_factype")).equals("1"))
			{
				arrCol.add("Working Capital");//0
			}
			else if(correctNull(rs.getString("cus_factype")).equals("2"))
			{
				arrCol.add("Term Loan");
			}
			else
			{
				arrCol.add(Helper.correctInt((String)rs.getString("cus_factype")));//1
			}
			
			arrCol.add(Helper.correctInt((String)rs.getString("cus_facname")));//2
			if(correctNull(rs.getString("cus_typecredit")).equals("F"))
			{
				arrCol.add("Funded");//2
			}
			else if(correctNull(rs.getString("cus_typecredit")).equals("N"))
			{
				arrCol.add("Non Funded");
			}
			else if(correctNull(rs.getString("cus_typecredit")).equals("0"))
			{
				arrCol.add("Funded");
			}
			else
			{
				arrCol.add(Helper.correctInt((String)rs.getString("cus_typecredit")));//3
			}
			strBankcode=Helper.correctNull((String)rs.getString("cus_bank"));
			rs1 = DBUtils.executeLAPSQuery("getstaticdescription^"+"147"+"^"+strBankcode);
			if(rs1.next())
			{
				arrCol.add(Helper.correctNull(rs1.getString("STAT_DATA_DESC1")));//4
			}
			if(correctNull(rs.getString("cus_bnkarrn")).equals("C"))
			{
				arrCol.add("Consortium");//2
			}
			else if(correctNull(rs.getString("cus_bnkarrn")).equals("M"))
			{
				arrCol.add("Multiple");
			}
			else
			{
				arrCol.add(Helper.correctInt((String)rs.getString("cus_bnkarrn")));//5
			}
			arrCol.add(Helper.correctNull((String)rs.getString("cus_leadbank")));//6
			arrCol.add(Helper.correctNull((String)rs.getString("cus_existing")));//7
			arrCol.add(Helper.correctNull((String)rs.getString("cus_proposed")));//8
			arrCol.add(strBankcode);//9
			hshRecord.put("existing",Helper.correctNull((String)rs.getString("cus_existing")));
			hshRecord.put("proposed",Helper.correctNull((String)rs.getString("cus_proposed")));
			hshRecord.put("facname",Helper.correctNull((String)rs.getString("cus_facname")));
			arrRow.add(arrCol);
			
		}
		
		if(rs!=null)
		{
			rs.close();
		}
		HashMap prof=new HashMap();
		HashMap profile=new HashMap();
		prof.put("profile_id",hidDemoId);
		profile=(HashMap)getCustomerProfileStatus(prof);
		hshRecord.put("strIncompletepage", Helper.correctNull((String)profile.get("strIncompletepage")));

		rs=DBUtils.executeLAPSQuery("getprofilestatusfromdemographic^"+hidDemoId);
		if(rs.next())
		{
			strProfilestatus=Helper.correctNull((String)rs.getString("perapp_profilestatus"));
		}
		hshRecord.put("strProfilestatus",strProfilestatus);
		if(rs!=null)
		{
			rs.close();
		}
		hshRecord.put("arrRow",arrRow);
		hshRecord.put("hidAppId",strcomappid);
		
		
	}
	catch(Exception ce)
	{		
		throw new EJBException("Error in getBankDetails "+ce.toString());
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
	public void updateConsBankdetail(HashMap hshValues) 
	{

		//Added by rajesh for other bank details
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;		
		ArrayList arrValues=new ArrayList();
		ResultSet rs = null;
		String strQuery="",strOldid="";
		String strAction=correctNull((String)hshValues.get("hidAction"));
		String strGradeId = Helper.correctNull((String)hshValues.get("idno"));
		String hidDemoId=correctNull((String)hshValues.get("hidDemoId"));
		String hidsno=correctNull((String)hshValues.get("hid_sno"));
      	
		try
		{
			
			String strFacType=Helper.correctNull((String)hshValues.get("txt_FacilityType"));
			String strFacDesc=Helper.correctNull((String)hshValues.get("txt_Facilitydesc"));
			String strfaccredit=Helper.correctNull((String)hshValues.get("txt_FacilityCreditType"));
			String strbankname=Helper.correctNull((String)hshValues.get("hid_Bankcode"));
			String strbankingarra=Helper.correctNull((String)hshValues.get("txt_BankingArrangement"));
			String strleadbank=Helper.correctNull((String)hshValues.get("txt_LeadBankName"));
			String strwhether1=Helper.correctNull((String)hshValues.get("sel_Exewhetherconmul"));
			String strwhether2=Helper.correctNull((String)hshValues.get("sel_Exewhetherconmu2"));
			
			int intUpdatesize=0;
			
			
			
			
			if(strAction.equalsIgnoreCase("update"))
			{
					intUpdatesize	= intUpdatesize+1;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","perconstbankingdel1");
					arrValues.add(hidDemoId);
					arrValues.add(hidsno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					
					intUpdatesize	= intUpdatesize+1;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","perconstbankingins");
					arrValues.add(strFacType);//1
					arrValues.add(strFacDesc);//2
					arrValues.add(strfaccredit);//3
					arrValues.add(strbankname);//4
					arrValues.add(strbankingarra);//5
					arrValues.add(strleadbank);//6
					arrValues.add(strwhether1);//7
					arrValues.add(strwhether2);//8
					arrValues.add(hidDemoId);//9
					arrValues.add(hidsno);//10
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}		
				
			
			else if(strAction.equalsIgnoreCase("delete"))
			{
				intUpdatesize	= intUpdatesize+1;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","perconstbankingdel");
				arrValues.add("Y");
				arrValues.add(hidDemoId);
				arrValues.add(hidsno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);

				intUpdatesize	= intUpdatesize+1;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","del_otherbankcredits");
				arrValues.add(hidDemoId);
				arrValues.add(hidsno);
				arrValues.add("cust");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
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
	public HashMap getfinancialSearch(HashMap hshValues) 
	{
		String strQuery="",strQuery1= "";
		String absPosition="";
		ResultSet rs=null;
		ResultSet rs1=null;
		HashMap hshResult=new HashMap();
		ArrayList arryRow=new ArrayList();
		ArrayList arryCol=null;
		String strradioValues=null;
		String strSearchText=null;
		String strCheckCBS=null;
		String cbsdata="FALSE";
		String strOrgname="";
		String strOrgNameFromSolID="";
		String strLAPSIDFromCBSID="",strfindigiflag="";
		String strText="",str_statuscust="N";
		
		try
		{			
			String strOrgSelect=correctNull((String)hshValues.get("strOrgSelect"));
			if(strOrgSelect.equalsIgnoreCase("001001"))
			{
				strOrgSelect="001";
			}
			absPosition = correctNull((String)hshValues.get("hid_rowcount"));	
			/*
			 * By default value for the field checkcbs is coming as "Y". 
			 * Bcoz they are passing the value Y
			 */
			
			strCheckCBS = correctNull((String)hshValues.get("checkcbs"));
			strOrgname=correctNull((String)hshValues.get("strOrgName"));
			
			strSearchText=Helper.correctSingleQuote(correctNull((String)hshValues.get("txtsearch")));
			if(strSearchText.equals(""))
			{
				strSearchText="%";
			}
			strradioValues=correctNull((String)hshValues.get("radiobutton"));
			if(strradioValues.equalsIgnoreCase("first"))
			{
				strText= " and upper(perapp_fname) like upper('%"+strSearchText+"%') Order by perapp_fname";	
			}
			else if(strradioValues.equalsIgnoreCase("CBSID"))
			{
				strText=  " and perapp_cbsid = '"+strSearchText+"' Order by perapp_fname";
			}
			else if(strradioValues.equalsIgnoreCase("LAPSID"))
			{
				strText=" and perapp_oldid = '"+strSearchText+"' Order by perapp_fname";
			}
			else if(strradioValues.equalsIgnoreCase("PANNO"))
			{
				strText= " and perapp_panno = '"+strSearchText+"' Order by perapp_fname";
			}
			else 
			{
				strText=  " Order by perapp_fname";	
			}
			/*
			 * Other than Name search all other search options are global
			 */
			
			if(strradioValues.equalsIgnoreCase("first"))
			{
				strOrgSelect=strOrgSelect;
			}
			else
			{
				strOrgSelect="001";
			}
			if(strradioValues.equalsIgnoreCase("CBSID") && strCheckCBS.equalsIgnoreCase("Y"))
			{
				boolean exbool=false;
				/*
				 * Added by prakash. The customer search should always hit CBS DataBase
				 */
				if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
				{
					strQuery=SQLParser.getCBSSqlQuery("cbscusmastersearch_newconnection^"+strSearchText);
					rs=DBUtils.executeQueryCBSConnection(strQuery);
				}
				else
				{
					strQuery= SQLParser.getSqlQuery("cbscusmastersearch^"+strSearchText);
					rs=DBUtils.executeQuery(strQuery); 
				}
				cbsdata="TRUE";
			}
			else if(strradioValues.equalsIgnoreCase("PROPOSALNO"))
			{
				strQuery= SQLParser.getSqlQuery("selOnlyForRatingProposal^"+strSearchText);
				rs=DBUtils.executeQuery(strQuery); 
			}
			else
			{

				strQuery= SQLParser.getSqlQuery("corpmastsearch^"+strOrgSelect+"%"+"^"+strText);
				rs=DBUtils.executeQuery(strQuery);
			}
			rs.last();
			int RowCount = rs.getRow();		
			
			
			
			rs.beforeFirst();				
			if(RowCount != 0)
			{					
				if (!absPosition.equals("0"))
				{
					if(Integer.parseInt(absPosition) > RowCount)
					{
						rs.absolute(RowCount);
					}
					else
					{
						rs.absolute(Integer.parseInt(absPosition));
					}				
				}			
			}
			String perapp_id="";
			while(rs.next())
			{
				arryCol=new ArrayList();
				if(strradioValues.equalsIgnoreCase("CBSID") && strCheckCBS.equalsIgnoreCase("Y"))
				{
				
					String strCBSID=Helper.correctNull(rs.getString("cust_id"));
					if(!strCBSID.equalsIgnoreCase(""))
					{
						if(rs1!=null)
						{
							rs1.close();
						}
						strQuery=SQLParser.getSqlQuery("sel_lapsidfromcbsid^"+strCBSID);
						rs1=DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							perapp_id=Helper.correctNull(rs1.getString("perapp_id"));
							str_statuscust=Helper.correctNull(rs1.getString("perapp_profilestatus"));
							if(str_statuscust.equalsIgnoreCase(""))
								str_statuscust="N";
						}
					}
					arryCol.add(perapp_id);
					arryCol.add(correctNull(rs.getString("cust_name")).toUpperCase());
					arryCol.add(correctNull(rs.getString("pan_gir_num")));
					String strSolID=Helper.correctNull(rs.getString("solid"));
					if(!strSolID.equalsIgnoreCase(""))
					{
						if(rs1!=null)
						{
							rs1.close();
						}
						String strQuery2=SQLParser.getSqlQuery("selectorgappl^"+strSolID);
						rs1=DBUtils.executeQuery(strQuery2);
						if(rs1.next())
						{
							strOrgNameFromSolID=Helper.correctNull(rs1.getString("org_name"));
						}
					}
					arryCol.add(strOrgNameFromSolID);
					
					if(!strCBSID.equalsIgnoreCase(""))
					{
						if(rs1!=null)
						{
							rs1.close();
						}
						strQuery=SQLParser.getSqlQuery("sel_lapsidfromcbsid^"+strCBSID);
						rs1=DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							strLAPSIDFromCBSID=Helper.correctNull(rs1.getString("perapp_oldid"));
						}
					}
					arryCol.add(strLAPSIDFromCBSID);
					arryCol.add(correctNull(rs.getString("cust_id")));
					arryCol.add(cbsdata);
					arryCol.add(str_statuscust);
					arryCol.add("0");
					arryCol.add(correctNull(rs.getString("cust_occp_code")));
					if(!strCBSID.equalsIgnoreCase(""))
					{
						if(rs1!=null)
						{
							rs1.close();
						}
						strQuery=SQLParser.getSqlQuery("selOnlyForRatingProposal^"+strCBSID);
						rs1=DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							strfindigiflag=Helper.correctNull(rs1.getString("FIN_DIGI_FLAG"));
						}
					}
					arryCol.add(strfindigiflag);
				}
				else if(strradioValues.equalsIgnoreCase("PROPOSALNO"))
				{
					arryCol.add(correctNull(rs.getString("fin_ratappno")));//0
					arryCol.add(correctNull(rs.getString("fin_appname")));//1
					arryCol.add(correctNull(rs.getString("org_name")));//2
					if(correctNull(rs.getString("fin_status")).equalsIgnoreCase("OP"))
					{
						arryCol.add("Open / Pending");	//3
					}
					else if(correctNull(rs.getString("fin_status")).equalsIgnoreCase("PA"))
					{
						arryCol.add("Processed/Approved");	//3
					}
					else if(correctNull(rs.getString("fin_status")).equalsIgnoreCase("PR"))
					{
						arryCol.add("Processed/Rejected");	//3
					}
					else if(correctNull(rs.getString("fin_status")).equalsIgnoreCase("CA"))
					{
						arryCol.add("Closed/Approved");	//3
					}
					else if(correctNull(rs.getString("fin_status")).equalsIgnoreCase("CR"))
					{
						arryCol.add("Closed/Rejected");	//3
					}else{
						arryCol.add(" ");	//3
					}
					arryCol.add(correctNull(rs.getString("fin_finid")));//4
					arryCol.add(correctNull(rs.getString("fin_bussid")));//5
					arryCol.add(correctNull(rs.getString("fin_cbsid")));//6
					arryCol.add(correctNull(rs.getString("fin_appid")));//7
					arryCol.add("0");
					
					String strActivityCode="";
					if(rs1!=null)
						rs1.close();
					if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
					{
						strQuery=SQLParser.getCBSSqlQuery("cbscusmastersearch_newconnection^"+Helper.correctNull(rs.getString("fin_cbsid")));
						rs1=DBUtils.executeQueryCBSConnection(strQuery);
					}
					else
					{
						strQuery= SQLParser.getSqlQuery("cbscusmastersearch^"+Helper.correctNull(rs.getString("fin_cbsid")));
						rs1=DBUtils.executeQuery(strQuery); 
					}
					if(rs1.next())
					{
						strActivityCode=Helper.correctNull(rs1.getString("cust_occp_code"));
					}
					
					if(rs1!=null)
					{
						rs1.close();
					}
					strQuery=SQLParser.getSqlQuery("sel_applKYCNorms^"+Helper.correctNull(rs.getString("fin_appid")));
					rs1=DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						if(!strActivityCode.equalsIgnoreCase("MIGR"))
						strActivityCode=Helper.correctNull(rs1.getString("kyc_occupationcode"));
					}
					
					arryCol.add(strActivityCode);
					arryCol.add(correctNull(rs.getString("FIN_DIGI_FLAG")));
				}
				else
				{
					arryCol.add(correctNull(rs.getString("perapp_id")));
					arryCol.add(correctNull(rs.getString("perapp_fname")).toUpperCase());
					arryCol.add(correctNull(rs.getString("perapp_panno")));
					arryCol.add(correctNull(rs.getString("org_name")));
					arryCol.add(correctNull(rs.getString("perapp_oldid"))); //Shahul
					arryCol.add(correctNull(rs.getString("perapp_cbsid")));
					arryCol.add(cbsdata);
					str_statuscust=Helper.correctNull(rs.getString("perapp_profilestatus"));
					if(str_statuscust.equalsIgnoreCase(""))
						str_statuscust="N";
					arryCol.add(str_statuscust);
					arryCol.add("0");
					String strActivityCode="";
					if(rs1!=null)
						rs1.close();
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
						strActivityCode=Helper.correctNull(rs1.getString("cust_occp_code"));
					}
					
					if(rs1!=null)
					{
						rs1.close();
					}
					strQuery=SQLParser.getSqlQuery("sel_applKYCNorms^"+Helper.correctNull(rs.getString("perapp_id")));
					rs1=DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						if(!strActivityCode.equalsIgnoreCase("MIGR"))
						strActivityCode=Helper.correctNull(rs1.getString("kyc_occupationcode"));
					}
					
					arryCol.add(strActivityCode);
					if(!correctNull(rs.getString("perapp_cbsid")).equalsIgnoreCase(""))
					{
						if(rs1!=null)
						{
							rs1.close();
						}
						strQuery=SQLParser.getSqlQuery("selOnlyForRatingProposal^"+correctNull(rs.getString("perapp_cbsid")));
						rs1=DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							strfindigiflag=Helper.correctNull(rs1.getString("FIN_DIGI_FLAG"));
						}
					}
					arryCol.add(strfindigiflag);
				}
				arryRow.add(arryCol);
			}
			hshResult.put("arryRow",arryRow);
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getMasterSearch "+e.getMessage());
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
			catch(Exception e)
			{
				throw new EJBException("Error in closing Connection "+e.getMessage());
			}
		}
		return hshResult;
	}

	public HashMap getSolvencySearch(HashMap hshValues) 
	{
		String strQuery="",strQuery1= "";
		String absPosition="";
		ResultSet rs=null;
		ResultSet rs1=null;
		HashMap hshResult=new HashMap();
		ArrayList arryRow=new ArrayList();
		ArrayList arryCol=null;
		String strradioValues=null;
		String strSearchText=null;
		String strCheckCBS=null;
		String cbsdata="FALSE";
		String strOrgname="";
		String strOrgNameFromSolID="";
		String strLAPSIDFromCBSID="";
		String strLAPSIDNewFromCBSID="";
		String strText="";
		try
		{			
			String strOrgSelect=correctNull((String)hshValues.get("strOrgSelect"));
			if(strOrgSelect.equalsIgnoreCase("001001"))
			{
				strOrgSelect="001";
			}
			absPosition = correctNull((String)hshValues.get("hid_rowcount"));	
			/*
			 * By default value for the field checkcbs is coming as "Y". 
			 * Bcoz they are passing the value Y
			 */
			
			strCheckCBS = correctNull((String)hshValues.get("checkcbs"));
			strOrgname=correctNull((String)hshValues.get("strOrgName"));
			
			strSearchText=Helper.correctSingleQuote(correctNull((String)hshValues.get("txtsearch")));						
	 
			if(strSearchText.equals(""))
			{
				strSearchText="%";
			}
			strradioValues=correctNull((String)hshValues.get("radiobutton"));
			if(strradioValues.equalsIgnoreCase("first"))
			{
				strText= " and upper(perapp_fname) like upper('%"+strSearchText+"%') Order by perapp_fname";	
			}
			else if(strradioValues.equalsIgnoreCase("CBSID"))
			{
				strText=  " and perapp_cbsid = '"+strSearchText+"' Order by perapp_fname";
			}
			else if(strradioValues.equalsIgnoreCase("LAPSID"))
			{
				strText=" and perapp_oldid = '"+strSearchText+"' Order by perapp_fname";
			}
			else if(strradioValues.equalsIgnoreCase("PANNO"))
			{
				strText= " and perapp_panno = '"+strSearchText+"' Order by perapp_fname";
			}
			else if(strradioValues.equalsIgnoreCase("APPNO"))
			{
				strText= " and perapp_panno = '"+strSearchText+"' Order by perapp_fname";
			}
			else 
			{
				strText=  " Order by perapp_fname";	
			}
		
			/*
			 * Other than Name search all other search options are global
			 */
			
			if(strradioValues.equalsIgnoreCase("first"))
			{
				strOrgSelect=strOrgSelect;
			}
			else
			{
				strOrgSelect="001";
			}
			if(strradioValues.equalsIgnoreCase("APPNO"))
			{
				strQuery= SQLParser.getSqlQuery("sel_Kpower_Sol_appno^"+strSearchText+"^"+strSearchText);
				rs=DBUtils.executeQuery(strQuery);
			}
			else if(strradioValues.equalsIgnoreCase("CBSID") && strCheckCBS.equalsIgnoreCase("Y"))
			{
				/*boolean exbool=false;
				
				 * Added by prakash. The customer search should always hit CBS DataBase
				 
				if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
				{
					strQuery=SQLParser.getCBSSqlQuery("cbscusmastersearch_newconnection^"+strSearchText);
					rs=DBUtils.executeQueryCBSConnection(strQuery);
				}
				else
				{
					strQuery= SQLParser.getSqlQuery("cbscusmastersearch^"+strSearchText);
					rs=DBUtils.executeQuery(strQuery); 
				}*/
				
				strQuery= SQLParser.getSqlQuery("corpmastsearch^"+strOrgSelect+"%"+"^"+strText);
				rs=DBUtils.executeQuery(strQuery);
				
				cbsdata="TRUE";
			}
			else
			{
				strQuery= SQLParser.getSqlQuery("reailmastsearch^"+strOrgSelect+"%"+"^"+strText);
				rs=DBUtils.executeQuery(strQuery);
			}
			rs.last();
			int RowCount = rs.getRow();		
			rs.beforeFirst();				
			if(RowCount != 0)
			{					
				if (!absPosition.equals("0"))
				{
					if(Integer.parseInt(absPosition) > RowCount)
					{
						rs.absolute(RowCount);
					}
					else
					{
						rs.absolute(Integer.parseInt(absPosition));
					}				
				}			
			}
			while(rs.next())
			{
				arryCol=new ArrayList();
				/*if(strradioValues.equalsIgnoreCase("CBSID"))
				{
					arryCol.add(correctNull((String)rs.getString("cust_id")));
					arryCol.add(correctNull((String)rs.getString("cust_name")).toUpperCase());
					arryCol.add(correctNull((String)rs.getString("pan_gir_num")));
					String strSolID=Helper.correctNull((String)rs.getString("solid"));
					if(!strSolID.equalsIgnoreCase(""))
					{
						if(rs1!=null)
						{
							rs1.close();
						}
						String strQuery2=SQLParser.getSqlQuery("selectorgappl^"+strSolID);
						rs1=DBUtils.executeQuery(strQuery2);
						if(rs1.next())
						{
							strOrgNameFromSolID=Helper.correctNull((String)rs1.getString("org_name"));
						}
					}
					arryCol.add(strOrgNameFromSolID);
					String strCBSID=Helper.correctNull((String)rs.getString("cust_id"));
					if(!strCBSID.equalsIgnoreCase(""))
					{
						if(rs1!=null)
						{
							rs1.close();
						}
						strQuery=SQLParser.getSqlQuery("sel_lapsidfromcbsid^"+strCBSID);
						rs1=DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							strLAPSIDFromCBSID=Helper.correctNull((String)rs1.getString("perapp_id"));
							strLAPSIDNewFromCBSID=Helper.correctNull((String)rs1.getString("perapp_oldid"));
						}
					}
					arryCol.add(strLAPSIDFromCBSID);
					arryCol.add(correctNull((String)rs.getString("cust_id")));
					arryCol.add("C");
					arryCol.add(cbsdata);
					arryCol.add(strLAPSIDNewFromCBSID);
				}
				else
				{*/
					arryCol.add(correctNull((String)rs.getString("perapp_oldid")));
					arryCol.add(correctNull((String)rs.getString("perapp_fname")).toUpperCase());
					arryCol.add(correctNull((String)rs.getString("perapp_panno")));
					arryCol.add(correctNull((String)rs.getString("org_name")));
					arryCol.add(correctNull((String)rs.getString("perapp_id"))); 
					arryCol.add(correctNull((String)rs.getString("perapp_cbsid")));
					arryCol.add("L");
					arryCol.add(cbsdata);
					arryCol.add(correctNull((String)rs.getString("perapp_oldid")));
				//}
				arryRow.add(arryCol);
			}
			hshResult.put("arryRow",arryRow);
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getSolvencySearch "+e.getMessage());
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
			catch(Exception e)
			{
				throw new EJBException("Error in closing Connection "+e.getMessage());
			}
		}
		return hshResult;
	}
	
	//=====================added by reddemma for Banker certificate module=======================//
	public HashMap getBankerSearch(HashMap hshValues) 
	{
		String strQuery="",strQuery1= "";
		String absPosition="";
		ResultSet rs=null;
		ResultSet rs1=null;
		HashMap hshResult=new HashMap();
		ArrayList arryRow=new ArrayList();
		ArrayList arryCol=null;
		String strradioValues=null;
		String strSearchText=null;
		String strCheckCBS=null;
		String cbsdata="FALSE";
		String strOrgname="";
		String strOrgNameFromSolID="";
		String strLAPSIDFromCBSID="";
		String strLAPSIDNewFromCBSID="";
		String strText="";
		try
		{			
			String strOrgSelect=correctNull((String)hshValues.get("strOrgSelect"));
			if(strOrgSelect.equalsIgnoreCase("001001"))
			{
				strOrgSelect="001";
			}
			absPosition = correctNull((String)hshValues.get("hid_rowcount"));	
			/*
			 * By default value for the field checkcbs is coming as "Y". 
			 * Bcoz they are passing the value Y
			 */
			
			strCheckCBS = correctNull((String)hshValues.get("checkcbs"));
			strOrgname=correctNull((String)hshValues.get("strOrgName"));
			
			strSearchText=Helper.correctSingleQuote(correctNull((String)hshValues.get("txtsearch")));						
	 
			if(strSearchText.equals(""))
			{
				strSearchText="%";
			}
			strradioValues=correctNull((String)hshValues.get("radiobutton"));
			if(strradioValues.equalsIgnoreCase("first"))
			{
				strText= " and upper(perapp_fname) like upper('%"+strSearchText+"%') Order by perapp_fname";	
			}
			else if(strradioValues.equalsIgnoreCase("CBSID"))
			{
				strText=  " and perapp_cbsid = '"+strSearchText+"' Order by perapp_fname";
			}
			else if(strradioValues.equalsIgnoreCase("LAPSID"))
			{
				strText=" and perapp_oldid = '"+strSearchText+"' Order by perapp_fname";
			}
			else if(strradioValues.equalsIgnoreCase("PANNO"))
			{
				strText= " and perapp_panno = '"+strSearchText+"' Order by perapp_fname";
			}
			else if(strradioValues.equalsIgnoreCase("APPNO"))
			{
				strText= " and perapp_panno = '"+strSearchText+"' Order by perapp_fname";
			}
			else 
			{
				strText=  " Order by perapp_fname";	
			}
		
			/*
			 * Other than Name search all other search options are global
			 */
			
			if(strradioValues.equalsIgnoreCase("first"))
			{
				strOrgSelect=strOrgSelect;
			}
			else
			{
				strOrgSelect="001";
			}
			if(strradioValues.equalsIgnoreCase("APPNO"))
			{
				strQuery= SQLParser.getSqlQuery("sel_Kpower_Sol_appno^"+strSearchText+"^"+strSearchText);
				rs=DBUtils.executeQuery(strQuery);
			}
			else if(strradioValues.equalsIgnoreCase("CBSID") && strCheckCBS.equalsIgnoreCase("Y"))
			{
				strQuery= SQLParser.getSqlQuery("corpmastsearch^"+strOrgSelect+"%"+"^"+strText);
				rs=DBUtils.executeQuery(strQuery);
				
				cbsdata="TRUE";
			}
			else
			{
				strQuery= SQLParser.getSqlQuery("reailmastsearch^"+strOrgSelect+"%"+"^"+strText);
				rs=DBUtils.executeQuery(strQuery);
			}
			rs.last();
			int RowCount = rs.getRow();		
			rs.beforeFirst();				
			if(RowCount != 0)
			{					
				if (!absPosition.equals("0"))
				{
					if(Integer.parseInt(absPosition) > RowCount)
					{
						rs.absolute(RowCount);
					}
					else
					{
						rs.absolute(Integer.parseInt(absPosition));
					}				
				}			
			}
			while(rs.next())
			{
				    arryCol=new ArrayList();
					arryCol.add(correctNull((String)rs.getString("perapp_oldid")));
					arryCol.add(correctNull((String)rs.getString("perapp_fname")).toUpperCase());
					arryCol.add(correctNull((String)rs.getString("perapp_panno")));
					arryCol.add(correctNull((String)rs.getString("org_name")));
					arryCol.add(correctNull((String)rs.getString("perapp_id"))); 
					arryCol.add(correctNull((String)rs.getString("perapp_cbsid")));
					arryCol.add("L");
					arryCol.add(cbsdata);
					arryCol.add(correctNull((String)rs.getString("perapp_oldid")));
				    arryRow.add(arryCol);
			}
			hshResult.put("arryRow",arryRow);
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getBankerSearch "+e.getMessage());
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
			catch(Exception e)
			{
				throw new EJBException("Error in closing Connection "+e.getMessage());
			}
		}
		return hshResult;
	}
	public HashMap updateCusGroupMgmt(HashMap hshValues) 
	{

		HashMap hshQueryValues = new HashMap();
		HashMap hshAppNew = new HashMap();
		HashMap hshQuery = null;		
		ArrayList arrValues=new ArrayList();
		ResultSet rs = null;
		String strQuery="",strCusGroupid="";
		String strAction=correctNull((String)hshValues.get("hidAction"));
      	
		try
		{
			
			String strSolid=correctNull((String)hshValues.get("strSolid")); 
			int intUpdatesize=0;
			strCusGroupid=Helper.correctNull((String)hshValues.get("hidgroupID"));
			
			if(strAction.equalsIgnoreCase("insert"))
			{
				if(strCusGroupid.equalsIgnoreCase(""))
				{
					hshAppNew.put("strSolid",strSolid);
					strCusGroupid=(String)getGroupID(hshAppNew);
					hshValues.put("strCusGroupID",strCusGroupid);
				}
				
					intUpdatesize	= intUpdatesize+1;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","inscusgroups");
					arrValues.add(strCusGroupid);
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_groupname")));
					arrValues.add(strSolid);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					
			}
			else if(strAction.equalsIgnoreCase("update"))
			{
				intUpdatesize	= intUpdatesize+1;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","updcusgroups");
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_groupname")));
				arrValues.add(strCusGroupid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				intUpdatesize	= intUpdatesize+1;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","upd_cus_groupsmembers");
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_groupname")));
				arrValues.add(strCusGroupid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				intUpdatesize	= intUpdatesize+1;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","delcusgroups");
				arrValues.add(strCusGroupid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
			}
			if(intUpdatesize>0)
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			
			hshValues=getCusGroupMgmt(hshValues);
			return hshValues;
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in updating updateCusGroupMgmt"+ce.toString());
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
	public HashMap getCusGroupMgmt(HashMap hshValues) 
	{
		String strQuery="";
		ResultSet rs=null,rs1=null;
		HashMap hshResult=new HashMap();
		ArrayList arryRow=new ArrayList();
		ArrayList arryCol=null;
		
		try
		{	
			 String strTemp=" ",strAction="",strSearch="",strSearchBy="";
			 strAction=Helper.correctNull((String)hshValues.get("hidAction"));
			 strSearch=Helper.correctNull((String)hshValues.get("txtsearch"));
			 strSearchBy=Helper.correctNull((String)hshValues.get("sel_search"));
			 hshResult.put("strSearch",strSearch);
			 hshResult.put("strSearchBy",strSearchBy);
			 
			if(rs!=null)
				rs.close();
			if(strAction.equalsIgnoreCase("search"))
			{
				if(strSearchBy.equalsIgnoreCase("N"))
					strTemp=" and  group_name like'%%"+strSearch+"%%'";
				else if(strSearchBy.equalsIgnoreCase("I"))
					strTemp=" and group_id='"+strSearch+"'";
				else if(strSearchBy.equalsIgnoreCase("S"))
					strTemp="and  group_solid='"+strSearch+"'";
			}
			strQuery=SQLParser.getSqlQuery("selcusgroups^"+strTemp);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				 arryCol=new ArrayList();
				 arryCol.add(Helper.correctNull(rs.getString("group_id")));
				 arryCol.add(Helper.correctNull(rs.getString("group_name")));
				 
				strTemp="";
				strQuery=SQLParser.getSqlQuery("selgroupmembersapprovedappcount^"+Helper.correctNull(rs.getString("group_id"))+"^"+Helper.correctNull(rs.getString("group_id")));
				rs1=DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{
					if(strTemp.equalsIgnoreCase(""))
						strTemp=Helper.correctNull(rs1.getString("perapp_cbsid"));
					else
						strTemp=strTemp+","+Helper.correctNull(rs1.getString("perapp_cbsid"));
				}
				arryCol.add(strTemp);
				arryCol.add(Helper.correctNull(rs.getString("grp_updflag")));
				strQuery=SQLParser.getSqlQuery("selgroupmemberscount^"+Helper.correctNull(rs.getString("group_id")));
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					arryCol.add(Helper.correctNull(rs1.getString("memcount")));
				}
				else
				{
					arryCol.add("0");
				}
				arryRow.add(arryCol);
			}
			
			
			hshResult.put("arryRow",arryRow);
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getMasterSearch "+e.getMessage());
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
		return hshResult;
	}
	private String getGroupID(HashMap hshValues) 
	{
		String strOrgShortCode="",strBorrowerId="";
		ResultSet rs=null;
		String strAppno="";
		long longAppno=0;
		String strQuery="",strExp="$";
		int intLen=0;
		String strSolid=Helper.correctNull((String)hshValues.get("strSolid"));
		java.text.NumberFormat nf=java.text.NumberFormat.getNumberInstance();
		nf.setMinimumIntegerDigits(3);
		nf.setGroupingUsed(false);
		try
		{
			String strCurrentDate=Helper.getCurrentDateTime();
			String strYear = strCurrentDate.substring(8, 10);
			strOrgShortCode=strSolid;
			strOrgShortCode = strOrgShortCode.trim();
			int scodeLength=strOrgShortCode.length();
			if(scodeLength==1){
				strOrgShortCode="00"+strOrgShortCode;
			}
			if(scodeLength==2){
				strOrgShortCode="0"+strOrgShortCode;
			}
			intLen=strOrgShortCode.length();
			strQuery=SQLParser.getSqlQuery("selgroupID^"+strYear);
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
			strAppno=strOrgShortCode+strYear+nf.format(longAppno);
		}
		catch(Exception e)
		{
 			throw new EJBException(e.toString());
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
				throw new EJBException("Error closing connection.. "+e1);
			}
		}
		return strAppno;
	}
	
	public void updateCusGroupMembersMgmt(HashMap hshValues) 
	{

		HashMap hshQueryValues = new HashMap();
		HashMap hshAppNew = new HashMap();
		HashMap hshQuery = null;		
		ArrayList arrValues=new ArrayList();
		ResultSet rs = null;
		String strQuery="",strCusGroupid="";
		String strAction=correctNull((String)hshValues.get("hidAction"));
		int intsno=0;
      	
		try
		{
			
			String strSolid=correctNull((String)hshValues.get("strSolid"));
			strCusGroupid=correctNull((String)hshValues.get("hidgroupID"));
			int intUpdatesize=0;
			
			if(strAction.equalsIgnoreCase("add"))
			{
				rs=DBUtils.executeLAPSQuery("selcusgroupmaxsno^"+strCusGroupid);
				if(rs.next())
				{
					intsno=Integer.parseInt(Helper.correctInt(rs.getString("sno")));
				}
				intsno=intsno+1;
				
					intUpdatesize	= intUpdatesize+1;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","inscusgroupmembers");
					arrValues.add(correctNull((String)hshValues.get("hidgroupID")));//0
					arrValues.add(String.valueOf(intsno));//1
					arrValues.add(correctNull((String)hshValues.get("txt_groupname")));//2
					arrValues.add(correctNull((String)hshValues.get("hidAppID")));//3
					arrValues.add(correctNull((String)hshValues.get("hidAppCBSID")));//4
					arrValues.add(correctNull((String)hshValues.get("hidAppName")));//5
					arrValues.add(correctNull((String)hshValues.get("hidAppOLDID")));//6
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					
			}
			else if(strAction.equalsIgnoreCase("remove"))
			{
				String strLAPSID=correctNull((String)hshValues.get("hidLAPSID"));
				intUpdatesize	= intUpdatesize+1;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","delcusgroupmembers");
				arrValues.add(strCusGroupid);
				arrValues.add(strLAPSID);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				intUpdatesize	= intUpdatesize+1;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","delcustomergroupmembersID");
				arrValues.add(strCusGroupid);
				arrValues.add(strLAPSID);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
			}
			
			
			intUpdatesize	= intUpdatesize+1;
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","updcusgroupsupdflag");
			arrValues.add("Y");//0
			arrValues.add(correctNull((String)hshValues.get("hidgroupID")));//1
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("size",Integer.toString(intUpdatesize));
			hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
			if(intUpdatesize>0)
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in updating updateCusGroupMgmt"+ce.toString());
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
	public HashMap getCusGroupMembersMgmt(HashMap hshValues) 
	{
		String strQuery="",strGroupName="";
		ResultSet rs=null;
		ArrayList arryRow=new ArrayList();
		ArrayList arryCol=null;
		
		try
		{	
			String strGroupID=correctNull((String)hshValues.get("hidgroupID"));
			strGroupName=correctNull((String)hshValues.get("txt_groupname"));
			strQuery=SQLParser.getSqlQuery("selcusgroupmembers^"+strGroupID);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				if(strGroupName.equalsIgnoreCase(""))
				strGroupName=correctNull(rs.getString("cgm_groupname"));
				arryCol=new ArrayList();
				arryCol.add(correctNull(rs.getString("cgm_sno")));//0
				arryCol.add(correctNull(rs.getString("cgm_memberid")));//1
				arryCol.add(correctNull(rs.getString("cgm_membercbsid")));//2
				arryCol.add(correctNull(rs.getString("cgm_membername")));//3
				arryCol.add(correctNull(rs.getString("cgm_memberoldid")));//4
				arryRow.add(arryCol);
			}
			if(rs!=null)
				rs.close();
			String strTemp="";
			strQuery=SQLParser.getSqlQuery("selgroupmembersapprovedappcount^"+strGroupID+"^"+strGroupID);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				if(strTemp.equalsIgnoreCase(""))
					strTemp=Helper.correctNull(rs.getString("perapp_cbsid"));
				else
					strTemp=strTemp+","+Helper.correctNull(rs.getString("perapp_cbsid"));
			}
			hshValues.put("strProcessedAppID", strTemp);
			hshValues.put("arrRow", arryRow);
			hshValues.put("strGroupID", strGroupID);
			hshValues.put("strGroupName", strGroupName);
			if(Helper.correctNull((String)hshValues.get("hidAction")).equalsIgnoreCase("profileupdate"))
				hshValues.put("updateprofile", "SUCCESS");
			
			
			if(rs!=null)
				rs.close();
			strQuery=SQLParser.getSqlQuery("selcusgroupsID^"+strGroupID);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshValues.put("updatecusprofile",Helper.correctNull(rs.getString("grp_updflag")));
			}
			
			
			
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getMasterSearch "+e.getMessage());
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
	
	public HashMap updateCustomerProfileGroupMembers(HashMap hshValues) 
	{

		HashMap hshQueryValues = new HashMap();
		HashMap hshAppNew = new HashMap();
		HashMap hshQuery = null;		
		ArrayList arrValues=new ArrayList();
		ResultSet rs = null,rs1=null;
		String strQuery="",strCusGroupid="";
		String strAction=correctNull((String)hshValues.get("hidAction"));
		int intsno=0;
      	
		try
		{
			
			strCusGroupid=correctNull((String)hshValues.get("hidgroupID"));
			int intUpdatesize=0;
			rs=DBUtils.executeLAPSQuery("selcusgroupmembers^"+strCusGroupid);
			while(rs.next())
			{
				
				intUpdatesize	= intUpdatesize+1;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","delcustomergroupmembers");
				arrValues.add(strCusGroupid);//0
				arrValues.add(Helper.correctNull(rs.getString("cgm_memberoldid")));//1
				arrValues.add(strCusGroupid);//2
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				
				intUpdatesize	= intUpdatesize+1;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","inscustomergroupmembersID");
				arrValues.add(Helper.correctNull(rs.getString("cgm_memberoldid")));//0
				arrValues.add(Helper.correctNull(rs.getString("cgm_memberoldid")));//1
				arrValues.add(Helper.correctNull(rs.getString("cgm_memberid")));//1
				arrValues.add(strCusGroupid);//2
				arrValues.add(strCusGroupid);//3
				arrValues.add(Helper.correctNull(rs.getString("cgm_memberoldid")));//4
				arrValues.add(Helper.correctNull(rs.getString("cgm_memberid")));//5
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
			}
				
				
			
			intUpdatesize	= intUpdatesize+1;
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","updcusgroupsupdflag");
			arrValues.add("N");//0
			arrValues.add(strCusGroupid);//1
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("size",Integer.toString(intUpdatesize));
			hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
			
			if(intUpdatesize>0)
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			hshValues=getCusGroupMembersMgmt(hshValues);
			
			return hshValues;
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in updating updateCusGroupMgmt"+ce.toString());
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
	
	public HashMap getCGTMSEConstitution(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		String strQuery="";
		ResultSet rs=null;
		String strcgId=correctNull((String)hshValues.get("varcgt"));
		try
		{
		
				strQuery = SQLParser.getSqlQuery("sel_cg_app_constitution^"+strcgId);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("cbs_static_cgtmse",rs.getString("cbs_static_cgtmse"));
				}
				if(rs!=null)
				{
					rs.close();
				}
			
		}
		catch(Exception cf)
		{
			throw new EJBException("Error in getCGTMSEConstitution  "+cf.toString());
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
	
	
	public HashMap getsecuritydet(HashMap hshValues) 
	{
		String strQuery="";
		ResultSet rs=null;
		ArrayList arryRow=new ArrayList();
		ArrayList arryCol=new ArrayList();
		String strold_id="";
		String strcategory=correctNull((String)hshValues.get("category"));
		String strsecur_name=correctNull((String)hshValues.get("sec_name"));
		try
		{	
			if(strcategory.equalsIgnoreCase("LAPSID"))
			{
				strQuery = SQLParser.getSqlQuery("sel_security_perappid^"+strsecur_name);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strold_id=Helper.correctNull(rs.getString("perapp_oldid"));
				}
			}
			else if(strcategory.equalsIgnoreCase("CBSID"))
			{
				strQuery = SQLParser.getSqlQuery("sel_appnosearchbycbsid_perm^"+strsecur_name);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strold_id=Helper.correctNull(rs.getString("perapp_oldid"));
				}
			}	
			if(!strold_id.equalsIgnoreCase(""))
			{
				if(rs != null)
				{
					rs.close();
				}
				strQuery = SQLParser.getSqlQuery("sel_security_deviation^"+strold_id+"^"+strold_id);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arryCol=new ArrayList();
					arryCol.add(Helper.correctNull(rs.getString("CUS_SEC_ID")));//0
					arryCol.add(Helper.correctNull(rs.getString("appname")));//1
					arryCol.add(Helper.CLOBToString(rs.getClob("cus_sec_security_description")));//2
					arryCol.add(Helper.correctNull(rs.getString("CUS_SEC_NETSECURITY")));//3
					arryRow.add(arryCol);
				}
				hshValues.put("arryRow1", arryRow);
			}
			
		}
		catch(Exception cf)
		{
			throw new EJBException("Error in getsecuritydet  "+cf.toString());
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
		return hshValues;
		
	}
	
	public HashMap getdepositdet(HashMap hshValues) 
	{
		String strQuery="";
		ResultSet rs=null;
		ArrayList arryRow1=new ArrayList();
		ArrayList arryCol1=new ArrayList();
	try{
		String strcbs_id=correctNull((String)hshValues.get("txtsearch"));
		
		if(!strcbs_id.equalsIgnoreCase(""))
		{
			if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
			{
					strQuery=SQLParser.getCBSSqlQuery("sel_deposit_det^"+strcbs_id);
					rs=DBUtils.executeQueryCBSConnection(strQuery);
			}
			else
			{
				strQuery=SQLParser.getCBSSqlQuery("sel_deposit_val^"+strcbs_id);
				rs=DBUtils.executeQueryCBSConnection(strQuery);
			}
			while(rs.next())
			{
				arryCol1=new ArrayList();
				arryCol1.add(Helper.correctNull(rs.getString("loan_standname")));//0
				arryCol1.add(Helper.correctNull(rs.getString("loan_accno")));//1
				arryCol1.add(Helper.correctNull(rs.getString("loan_faceval")));//2
				arryCol1.add(Helper.correctNull(rs.getString("loan_presentos")));//3
				arryCol1.add(Helper.correctNull(rs.getString("loan_matdate")));//4
				arryCol1.add(Helper.correctNull(rs.getString("loan_rateofint")));//5
				arryRow1.add(arryCol1);
			}
			hshValues.put("arryRow2", arryRow1);
		}
			
		}
		catch(Exception cf)
		{
			throw new EJBException("Error in getdepositdet  "+cf.toString());
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
		return hshValues;
	}
	
	public HashMap getExistingFacDet(HashMap hshValues) 
	{
		String strQuery="";
		ResultSet rs=null;
		ArrayList arryRow=new ArrayList();
		ArrayList arryCol=new ArrayList();
		String strold_id="";
		String strcategory=correctNull((String)hshValues.get("category"));
		String strsecur_name=correctNull((String)hshValues.get("sec_name"));
		String appname="";
		String hid_existingBowid=correctNull((String)hshValues.get("hid_existingBowid"));
		try
		{	
			if(strcategory.equalsIgnoreCase("LAPSID"))
			{
				strQuery = SQLParser.getSqlQuery("sel_security_perappid^"+strsecur_name);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strold_id=Helper.correctNull(rs.getString("perapp_oldid"));
					appname=Helper.correctNull(rs.getString("perappname"));
				}
			}
			else if(strcategory.equalsIgnoreCase("CBSID"))
			{
				strQuery = SQLParser.getSqlQuery("sel_appnosearchbycbsid_perm^"+strsecur_name);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strold_id=Helper.correctNull(rs.getString("perapp_oldid"));
					appname=Helper.correctNull(rs.getString("perappname"));
				}
			}	
			String tempdata="";
			String secappno="";
			String existsecurity="";
			if(!strold_id.equalsIgnoreCase(""))
			{
				if(rs != null)
				{
					rs.close();
				}
				strQuery = SQLParser.getSqlQuery("sel_permgist_ExistingFacility_corp_CG^"+strold_id+"^"+strold_id);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arryCol=new ArrayList();
					arryCol.add(Helper.correctNull(rs.getString("FACILITY_APPNO")));//0
					arryCol.add(Helper.correctNull(rs.getString("FACILITY_SNO")));//1
					arryCol.add(appname);//2
					arryCol.add(Helper.correctNull(rs.getString("FAC_PROCESSDATE")));//3
					arryRow.add(arryCol);
					
					if(tempdata.equals(""))
					{
						if(Helper.correctNull((String)hshValues.get("sel_devSubType")).equals("5"))
						{
							tempdata = Helper.correctNull(rs.getString("FACILITY_APPNO"))+" ~ "+Helper.correctNull(rs.getString("FACILITY_SNO"))+" ~ "+
										Helper.correctNull(rs.getString("MODULETYPE"))+" ~ "+appname+" ~ "+
										Helper.correctNull(rs.getString("FACILITY_CATDESC"))+" ~ "+Helper.correctNull(rs.getString("FAC_PROCESSDATE"))+" ~ "+
										Helper.correctNull(rs.getString("FACILITY_SANCAMT"))+" ~ "+Helper.correctNull(rs.getString("FACILITY_OUTSTANDING"))+" ~ "+
										Helper.correctNull(rs.getString("FACILITY_INTEREST"))+" ~ "+Helper.correctNull(rs.getString("FACILITY_DUEDATE"))+" ~ "+
										Helper.correctNull(rs.getString("ARREARS"))+" ~ ";
						}
						else 
						{
							tempdata = Helper.correctNull(rs.getString("FACILITY_APPNO"))+" ~ "+Helper.correctNull(rs.getString("FACILITY_SNO"))+" ~ "+
									Helper.correctNull(rs.getString("FACILITY_CATDESC"))+" ~ "+Helper.correctNull(rs.getString("MODULETYPE"))+" ~ "+
									Helper.correctNull(rs.getString("CBS_ACCOUNTNO"))+" ~ "+Helper.correctNull(rs.getString("FACILITY_SANCAMT"))+" ~ "+
									Helper.correctNull(rs.getString("PURPOSE"))+" ~ "+Helper.correctNull(rs.getString("SANCTIONREFNO"))+" ~ "+
									Helper.correctNull(rs.getString("FAC_PROCESSDATE"))+" ~ "+Helper.correctNull(rs.getString("FACILITY_INTEREST"))+" ~ "+
									Helper.correctNull(rs.getString("PRESENTROI"))+" ~ "+Helper.correctNull(rs.getString("FACILITY_OUTSTANDING"))+" ~ "+
									Helper.correctNull(rs.getString("FACILITY_DUEDATE"))+" ~ "+Helper.correctNull(rs.getString("ARREARS"))+" ~ ";
						}
						secappno=Helper.correctNull(rs.getString("FACILITY_APPNO"));						
					}
					else
					{
						if(Helper.correctNull((String)hshValues.get("sel_devSubType")).equals("5"))
						{
							tempdata = tempdata+"@"+Helper.correctNull(rs.getString("FACILITY_APPNO"))+" ~ "+Helper.correctNull(rs.getString("FACILITY_SNO"))+" ~ "+
										Helper.correctNull(rs.getString("MODULETYPE"))+" ~ "+appname+" ~ "+
										Helper.correctNull(rs.getString("FACILITY_CATDESC"))+" ~ "+Helper.correctNull(rs.getString("FAC_PROCESSDATE"))+" ~ "+
										Helper.correctNull(rs.getString("FACILITY_SANCAMT"))+" ~ "+Helper.correctNull(rs.getString("FACILITY_OUTSTANDING"))+" ~ "+
										Helper.correctNull(rs.getString("FACILITY_INTEREST"))+" ~ "+Helper.correctNull(rs.getString("FACILITY_DUEDATE"))+" ~ "+
										Helper.correctNull(rs.getString("ARREARS"))+" ~ ";
						}
						else
						{
							tempdata = tempdata+"@"+Helper.correctNull(rs.getString("FACILITY_APPNO"))+" ~ "+Helper.correctNull(rs.getString("FACILITY_SNO"))+" ~ "+
									Helper.correctNull(rs.getString("FACILITY_CATDESC"))+" ~ "+Helper.correctNull(rs.getString("MODULETYPE"))+" ~ "+
									Helper.correctNull(rs.getString("CBS_ACCOUNTNO"))+" ~ "+Helper.correctNull(rs.getString("FACILITY_SANCAMT"))+" ~ "+
									Helper.correctNull(rs.getString("PURPOSE"))+" ~ "+Helper.correctNull(rs.getString("SANCTIONREFNO"))+" ~ "+
									Helper.correctNull(rs.getString("FAC_PROCESSDATE"))+" ~ "+Helper.correctNull(rs.getString("FACILITY_INTEREST"))+" ~ "+
									Helper.correctNull(rs.getString("PRESENTROI"))+" ~ "+Helper.correctNull(rs.getString("FACILITY_OUTSTANDING"))+" ~ "+
									Helper.correctNull(rs.getString("FACILITY_DUEDATE"))+" ~ "+Helper.correctNull(rs.getString("ARREARS"))+" ~ ";
						}
						secappno= secappno+"','"+ Helper.correctNull(rs.getString("FACILITY_APPNO"));
					}
				}
				
				if(rs != null)
				{
					rs.close();
				}
				strQuery = SQLParser.getSqlQuery("sel_permgist_ExistingFacility_ret_CG^"+strold_id+"^"+strold_id);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arryCol=new ArrayList();
					arryCol.add(Helper.correctNull(rs.getString("APPLICATIONNO")));//0
					arryCol.add(Helper.correctNull(rs.getString("FACILITY_SNO")));//1
					arryCol.add(appname);//2
					arryCol.add(Helper.correctNull(rs.getString("APP_PROCESSDATE")));//3
					arryRow.add(arryCol);
					
					if(tempdata.equals(""))
					{
						if(Helper.correctNull((String)hshValues.get("sel_devSubType")).equals("5"))
						{
							tempdata = Helper.correctNull(rs.getString("APPLICATIONNO"))+" ~ "+Helper.correctNull(rs.getString("FACILITY_SNO"))+" ~ "+
									Helper.correctNull(rs.getString("MODULETYPE"))+" ~ "+appname+" ~ "+Helper.correctNull(rs.getString("CAT_NAME"))+" ~ "+
									Helper.correctNull(rs.getString("APP_PROCESSDATE"))+" ~ "+Helper.correctNull(rs.getString("LOAN_RECMDAMT"))+" ~ "+
									""+" ~ "+Helper.correctNull(rs.getString("LOAN_MODINTRATE"))+" ~ "+Helper.correctNull(rs.getString("LOAN_DUEDATE"))+" ~ "+
									Helper.correctNull(rs.getString("arrears"))+" ~ ";
						}
						else
						{
							tempdata = Helper.correctNull(rs.getString("APPLICATIONNO"))+" ~ "+Helper.correctNull(rs.getString("FACILITY_SNO"))+" ~ "+
							Helper.correctNull(rs.getString("CAT_NAME"))+" ~ "+Helper.correctNull(rs.getString("MODULETYPE"))+" ~ "+
							Helper.correctNull(rs.getString("CBS_ACCOUNTNO"))+" ~ "+Helper.correctNull(rs.getString("LOAN_RECMDAMT"))+" ~ "+
							Helper.correctNull(rs.getString("PURPOSE"))+" ~ "+Helper.correctNull(rs.getString("SANCTIONREFNO"))+" ~ "+
							Helper.correctNull(rs.getString("APP_PROCESSDATE"))+" ~ "+Helper.correctNull(rs.getString("LOAN_MODINTRATE"))+" ~ "+
							Helper.correctNull(rs.getString("PRESENTROI"))+" ~ "+" "+" ~ "+
							Helper.correctNull(rs.getString("LOAN_DUEDATE"))+" ~ "+Helper.correctNull(rs.getString("ARREARS"))+" ~ ";
						}
						secappno=Helper.correctNull(rs.getString("APPLICATIONNO"));
					}
					else
					{
						if(Helper.correctNull((String)hshValues.get("sel_devSubType")).equals("5"))
						{
							tempdata = tempdata+"@"+Helper.correctNull(rs.getString("APPLICATIONNO"))+" ~ "+Helper.correctNull(rs.getString("FACILITY_SNO"))+" ~ "+
										Helper.correctNull(rs.getString("MODULETYPE"))+" ~ "+appname+" ~ "+Helper.correctNull(rs.getString("CAT_NAME"))+" ~ "+
										Helper.correctNull(rs.getString("APP_PROCESSDATE"))+" ~ "+Helper.correctNull(rs.getString("LOAN_RECMDAMT"))+" ~ "+
										""+" ~ "+Helper.correctNull(rs.getString("LOAN_MODINTRATE"))+" ~ "+Helper.correctNull(rs.getString("LOAN_DUEDATE"))+" ~ "+
										Helper.correctNull(rs.getString("arrears"))+" ~ ";
						}
						else 
						{
							tempdata = tempdata+"@"+Helper.correctNull(rs.getString("APPLICATIONNO"))+" ~ "+Helper.correctNull(rs.getString("FACILITY_SNO"))+" ~ "+
							Helper.correctNull(rs.getString("CAT_NAME"))+" ~ "+Helper.correctNull(rs.getString("MODULETYPE"))+" ~ "+
							Helper.correctNull(rs.getString("CBS_ACCOUNTNO"))+" ~ "+Helper.correctNull(rs.getString("LOAN_RECMDAMT"))+" ~ "+
							Helper.correctNull(rs.getString("PURPOSE"))+" ~ "+Helper.correctNull(rs.getString("SANCTIONREFNO"))+" ~ "+
							Helper.correctNull(rs.getString("APP_PROCESSDATE"))+" ~ "+Helper.correctNull(rs.getString("LOAN_MODINTRATE"))+" ~ "+
							Helper.correctNull(rs.getString("PRESENTROI"))+" ~ "+" "+" ~ "+
							Helper.correctNull(rs.getString("LOAN_DUEDATE"))+" ~ "+Helper.correctNull(rs.getString("ARREARS"))+" ~ ";
						}
						secappno=secappno+"','"+Helper.correctNull(rs.getString("APPLICATIONNO"));
					}
				}
				
				if(!secappno.equals(""))
				{	
					strQuery=SQLParser.getSqlQuery("sel_secappno_permgist^"+secappno.replaceFirst("','", ""));
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						if(existsecurity.equals(""))
						{
							existsecurity = Helper.correctNull(rs.getString("APP_SEC_APPNO"))+" ~ "+Helper.correctNull(rs.getString("APP_SEC_FACSNO"))+" ~ "+
											Helper.correctNull(rs.getString("APP_SEC_SECID"))+" ~ "+appname+" ~ "+ Helper.correctNull(rs.getString("APP_SEC_DESCRIPTION"))+" ~ "+
											Helper.correctNull(rs.getString("APP_SEC_SECURITYVALUE"))+" ~ "+Helper.correctNull(rs.getString("APP_SEC_SECURITYTYPE"))+" ~ "+
											Helper.correctNull(rs.getString("APP_SEC_MARGIN"))+" ~ ";
						}
						else
						{
							existsecurity = existsecurity+"@"+Helper.correctNull(rs.getString("APP_SEC_APPNO"))+" ~ "+Helper.correctNull(rs.getString("APP_SEC_FACSNO"))+" ~ "+
											Helper.correctNull(rs.getString("APP_SEC_SECID"))+" ~ "+appname+" ~ "+ Helper.correctNull(rs.getString("APP_SEC_DESCRIPTION"))+" ~ "+
											Helper.correctNull(rs.getString("APP_SEC_SECURITYVALUE"))+" ~ "+Helper.correctNull(rs.getString("APP_SEC_SECURITYTYPE"))+" ~ "+
											Helper.correctNull(rs.getString("APP_SEC_MARGIN"))+" ~ ";
						}
					}
				}
			}
			
			hshValues.put("tempdata", tempdata);
			hshValues.put("existsecurity", existsecurity);
			
			hshValues.put("arryRow1", arryRow);
			
			if(hid_existingBowid.contains(strold_id))
			{
				hshValues.put("strold_id", hid_existingBowid);
				hshValues.put("exstfac_attachFlag","N");
			}
			else
			{
				hshValues.put("strold_id", hid_existingBowid+"@"+strold_id);
				hshValues.put("exstfac_attachFlag","Y");
			}
			
			if(tempdata.equals(""))
			{
				hshValues.put("btnenable","N");
			}
			else
			{
				hshValues.put("btnenable","Y");
			}
		}
		catch(Exception cf)
		{
			throw new EJBException("Error in getExistingFacDet  "+cf.toString());
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
		return hshValues;
		
	}
	public HashMap getSvanidhiDetails(HashMap hshValues) 
	{
		HashMap hshRecord = new HashMap();
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol=new ArrayList();
		ResultSet rs = null;
		ResultSet rs1 = null;
		String hidDemoId=correctNull((String)hshValues.get("hidDemoId"));
		String strQuery="",strAppStatus="";
		
		try
		{
		
			strAppStatus=Helper.correctNull((String)hshValues.get("hidappstatus"));
			if(hidDemoId.equalsIgnoreCase(""))
				hidDemoId=Helper.correctNull((String)hshValues.get("hidapplicantnewid"));
			
			strQuery = SQLParser.getSqlQuery("sel_svanidhidetails^"+hidDemoId);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("PERAPP_CIG", Helper.correctNull(rs.getString("PERAPP_CIG")));
				hshRecord.put("PERAPP_CIGNAME", Helper.correctNull(rs.getString("PERAPP_CIGNAME")));
				hshRecord.put("PERAPP_CIGCODE", Helper.correctNull(rs.getString("PERAPP_CIGCODE")));
				hshRecord.put("PERAPP_JLG", Helper.correctNull(rs.getString("PERAPP_JLG")));
				hshRecord.put("PERAPP_JLGNAME", Helper.correctNull(rs.getString("PERAPP_JLGNAME")));
				hshRecord.put("PERAPP_JLGCODE", Helper.correctNull(rs.getString("PERAPP_JLGCODE")));
				hshRecord.put("PERAPP_NATIVITY", Helper.correctNull(rs.getString("PERAPP_NATIVITY")));
				hshRecord.put("PERAPP_FAMILYAVAILABLE", Helper.correctNull(rs.getString("PERAPP_FAMILYAVAILABLE")));
				hshRecord.put("PERAPP_VENDERIDCARDNO", Helper.correctNull(rs.getString("PERAPP_VENDERIDCARDNO")));
				hshRecord.put("PERAPP_CARTVENDINGNO", Helper.correctNull(rs.getString("PERAPP_CARTVENDINGNO")));
				hshRecord.put("PERAPP_LETTEROFRECOMMD", Helper.correctNull(rs.getString("PERAPP_LETTEROFRECOMMD")));
				hshRecord.put("PERAPP_NATIVEOFACTIVITY", Helper.correctNull(rs.getString("PERAPP_NATIVEOFACTIVITY")));
				hshRecord.put("PERAPP_PLACEOFVENDING", Helper.correctNull(rs.getString("PERAPP_PLACEOFVENDING")));
				hshRecord.put("PERAPP_DUROFVENDINGYRS", Helper.correctNull(rs.getString("PERAPP_DUROFVENDINGYRS")));
				hshRecord.put("PERAPP_DUROFVENDINGMONTH", Helper.correctNull(rs.getString("PERAPP_DUROFVENDINGMONTH")));
				hshRecord.put("PERAPP_STATIONARYVEYNDOR", Helper.correctNull(rs.getString("PERAPP_STATIONARYVEYNDOR")));
				hshRecord.put("PERAPP_NEARESTLANDMARK", Helper.correctNull(rs.getString("PERAPP_NEARESTLANDMARK")));
				hshRecord.put("PERAPP_MOBILEVEYNDOR", Helper.correctNull(rs.getString("PERAPP_MOBILEVEYNDOR")));
				hshRecord.put("PERAPP_MOBILENEARESTLANDMARK", Helper.correctNull(rs.getString("PERAPP_MOBILENEARESTLANDMARK")));
				hshRecord.put("PERAPP_WARDNO", Helper.correctNull(rs.getString("PERAPP_WARDNO")));
				hshRecord.put("PERAPP_DISTRICT", Helper.correctNull(rs.getString("PERAPP_DISTRICT")));
				hshRecord.put("PERAPP_PINCODE", Helper.correctNull(rs.getString("PERAPP_PINCODE")));
				hshRecord.put("PERAPP_AVERAGEMONTHLY", Helper.correctNull(rs.getString("PERAPP_AVERAGEMONTHLY")));
				hshRecord.put("PERAPP_BANKCode", Helper.correctNull(rs.getString("PERAPP_BANKNAME")));
				hshRecord.put("PERAPP_BRANCHNAME", Helper.correctNull(rs.getString("PERAPP_BRANCHNAME")));
				hshRecord.put("PERAPP_IFSCCODE", Helper.correctNull(rs.getString("PERAPP_IFSCCODE")));
				hshRecord.put("PERAPP_ACCOUNTNO", Helper.correctNull(rs.getString("PERAPP_ACCOUNTNO")));
				hshRecord.put("PERAPP_PAYMENTAGGREGATOR", Helper.correctNull(rs.getString("PERAPP_PAYMENTAGGREGATOR")));
				hshRecord.put("PERAPP_UPIID", Helper.correctNull(rs.getString("PERAPP_UPIID")));
				hshRecord.put("PERAPP_QRCODE", Helper.correctNull(rs.getString("PERAPP_QRCODE")));
				hshRecord.put("PERAPP_TERM1CERTIFIED", Helper.correctNull(rs.getString("PERAPP_TERM1CERTIFIED")));
				hshRecord.put("PERAPP_TERM1CERTIFIEDBY", Helper.correctNull(rs.getString("PERAPP_TERM1CERTIFIEDBY")));
				hshRecord.put("PERAPP_TERMCERTIFIED2", Helper.correctNull(rs.getString("PERAPP_TERMCERTIFIED2")));
				hshRecord.put("PERAPP_TERM2CERTIFIEDBY", Helper.correctNull(rs.getString("PERAPP_TERM2CERTIFIEDBY")));
				hshRecord.put("perapp_pwd", Helper.correctNull(rs.getString("perapp_pwd")));
				hshRecord.put("perapp_whtapplundertaken", Helper.correctNull(rs.getString("perapp_whtapplundertaken")));
				hshRecord.put("perapp_localref1_name", Helper.correctNull(rs.getString("perapp_localref1_name")));
				hshRecord.put("perapp_localref2_name", Helper.correctNull(rs.getString("perapp_localref2_name")));
				hshRecord.put("perapp_localref1_mobile", Helper.correctNull(rs.getString("perapp_localref1_mobile")));
				hshRecord.put("perapp_localref2_mobile", Helper.correctNull(rs.getString("perapp_localref2_mobile")));
				hshRecord.put("perapp_localref1_address", Helper.correctNull(rs.getString("perapp_localref1_address")));
				hshRecord.put("perapp_localref2_address", Helper.correctNull(rs.getString("perapp_localref2_address")));
				hshRecord.put("perapp_govtschemes", Helper.correctNull(rs.getString("perapp_govtschemes")));
				hshRecord.put("PER_SVANIDHIAPPNO", Helper.correctNull(rs.getString("per_svanidhiappno")));

				
				
				if(!Helper.correctNull(rs.getString("PERAPP_DISTRICT")).equals(""))
				{
					if(rs1!=null)
					{
						rs1.close();
					}
					rs1=DBUtils.executeLAPSQuery("sel_distnamebycode^"+Helper.correctNull(rs.getString("PERAPP_DISTRICT")));
					if(rs1.next())
					{
						hshRecord.put("PERAPP_DISTRICTDesc",correctNull(rs1.getString("district_desc")));
					}
				}
				if(!Helper.correctNull(rs.getString("PERAPP_BANKNAME")).equals(""))
				{
					if(rs1!=null)
					{
						rs1.close();
					}
					rs1=DBUtils.executeLAPSQuery("getstaticdescription^"+"147"+"^"+Helper.correctNull(rs.getString("PERAPP_BANKNAME")));
					if(rs1.next())
					{
						hshRecord.put("PERAPP_BANKNAMEDesc",Helper.correctNull(rs1.getString("STAT_DATA_DESC1")));
					}
				}
				
			}
			
			if(rs!=null)
				rs.close();
			
			rs=DBUtils.executeLAPSQuery("sel_per_familyDetails^"+hidDemoId);
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull(rs.getString("perapp_relationname")));
				arrCol.add(Helper.correctNull(rs.getString("perapp_relationtype")));
				arrCol.add(Helper.correctNull(rs.getString("perapp_relationage")));
				arrRow.add(arrCol);
			}
			
				
			
				ArrayList arrnewRow = new ArrayList();
				ArrayList arrnewCol=new ArrayList();
				String perapp_govtschemes=Helper.correctNull((String)hshRecord.get("perapp_govtschemes"));
				rs=DBUtils.executeLAPSQuery("selstaticdata^239");
				while(rs.next())
	    		{
					if(Helper.correctNull(rs.getString("stat_data_active")).equals("Y"))
					{
						arrnewCol=new ArrayList();
						arrnewCol.add(Helper.correctNull(rs.getString("stat_data_desc")));
						arrnewCol.add(Helper.correctNull(rs.getString("stat_data_desc1")));
	 	 				arrnewRow.add(arrnewCol);
					}
					else
					{
						if(perapp_govtschemes.contains(Helper.correctNull(rs.getString("stat_data_desc"))))
						{
							arrnewCol=new ArrayList();
							arrnewCol.add(Helper.correctNull(rs.getString("stat_data_desc")));
							arrnewCol.add(Helper.correctNull(rs.getString("stat_data_desc1")));
							arrnewRow.add(arrnewCol);
						}
					}					
	 			}
			
			
				hshRecord.put("arrRow",arrRow);
				hshRecord.put("arrRowSchemes",arrnewRow);
							
				String strProfilestatus="";
				if(rs!=null)
				{
					rs.close();
				}
				rs=DBUtils.executeLAPSQuery("getprofilestatusfromdemographic^"+hidDemoId);
				if(rs.next())
				{
					strProfilestatus=Helper.correctNull((String)rs.getString("perapp_profilestatus"));
				}
				hshRecord.put("strProfilestatus",strProfilestatus);
				
			
			hshRecord.put("appstatus", strAppStatus);
			
		
		}
		catch(Exception ce)
		{		
			throw new EJBException("Error in getSvanidhiDetails "+ce.toString());
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
	
	public void updSvanidhiDetails(HashMap hshValues) 
	{


		HashMap hshQueryValues = new HashMap();
		HashMap hshAppNew = new HashMap();
		HashMap hshQuery = null;		
		ArrayList arrValues=new ArrayList();
		ResultSet rs = null;
		String strAction=correctNull((String)hshValues.get("hidAction"));
		String hidDemoId=correctNull((String)hshValues.get("hidDemoId"));
      	
		try
		{
			
			
			String[] strSchemeSelect;
			if(hshValues.get("chk_schemes") instanceof String[])
			{
				strSchemeSelect=(String[])hshValues.get("chk_schemes");
			}
			else
			{
				strSchemeSelect=new String[1];
				strSchemeSelect[0]=correctNull((String)hshValues.get("chk_schemes"));
			}
			 
			String strschemes="";
			for(int i=0;i<strSchemeSelect.length;i++)
			{
				strschemes+=strSchemeSelect[i].trim()+"@";
			}
			
			
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_svanidhidetails");
				arrValues.add(hidDemoId);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1",hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","ins_svanidhidetails");
				arrValues.add(hidDemoId);//1
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_cig")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_cigname")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_cigcode")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_jlg")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_jigname")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_jigcode")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_nativity")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_familyavailable")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_venderidno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_vendercertno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_lorno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_nameofactivity")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_placeofvending")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_vendingyears")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_vendingmonths")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_fixedlocation")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_nearestlandmark")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_mobilelocation")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_mobilenearestlandmark")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_wardno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_District")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_pincode")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_monthlysales")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_bankcode")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_branch")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_ifsccode")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_accountno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_payment")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_upiid")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_durableqr")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hidcert")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hidTermcheckedby")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hidcert1")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hidTerm1checkedby")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_pwd")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_whtapplUndertaken")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_localref1_name")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_localref2_name")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_localref1_mobile")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_localref2_mobile")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_localref1_address")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_localref2_address")));
				arrValues.add(strschemes);
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_svanidhino")));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2",hshQuery);
				
				
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","3");
				hshQuery.put("strQueryId","del_per_familyDetails");
				arrValues.add(hidDemoId);
				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("3",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				
				{

					String [] strRelativeName=null;
					String [] strRelationType=null;
					String [] strRelationAge=null; 

					hshQueryValues=new HashMap();	
					int intSize=0;
					if(hshValues.get("txt_name") instanceof java.lang.String)
					{
						if(!Helper.correctNull((String)hshValues.get("txt_name")).equalsIgnoreCase(""))
						{
							hshQuery = new HashMap();
							++intSize;
							arrValues = new ArrayList();
							hshQuery.put("strQueryId", "ins_per_familyDetails");
							arrValues.add(hidDemoId);
							arrValues.add(String.valueOf(intSize));
							
							arrValues.add(Helper.correctNull((String)hshValues.get("txt_name")));
							arrValues.add(Helper.correctNull((String)hshValues.get("sel_relationship")));
							arrValues.add(Helper.correctNull((String)hshValues.get("txt_age")));
						
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", String.valueOf(intSize));
							hshQueryValues.put(String.valueOf(intSize), hshQuery);
						}
					}
					else
					{
						strRelativeName=(String [])hshValues.get("txt_name");
						strRelationType=(String [])hshValues.get("sel_relationship");
						strRelationAge=(String [])hshValues.get("txt_age");
						
						for(int i=0;i<strRelativeName.length;i++)
						{
							if(!strRelativeName[i].equalsIgnoreCase(""))
							{
								hshQuery = new HashMap();
								++intSize;
								arrValues = new ArrayList();
								hshQuery.put("strQueryId", "ins_per_familyDetails");
								arrValues.add(hidDemoId);
								arrValues.add(String.valueOf(intSize));
								
								arrValues.add(Helper.correctNull(strRelativeName[i]));
								arrValues.add(Helper.correctNull(strRelationType[i]));
								arrValues.add(Helper.correctNull(strRelationAge[i]));
							
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", String.valueOf(intSize));
								hshQueryValues.put(String.valueOf(intSize), hshQuery);
							}
						}
					}

					if(intSize>0)
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				}
				
				
				
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_svanidhidetails");
				arrValues.add(hidDemoId);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1",hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","del_per_familyDetails");
				arrValues.add(hidDemoId);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in updating updateCusGroupMgmt"+ce.toString());
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
	
	public String getMimeType(String fileExtension) throws EJBException
	{
		if (fileExtension.equalsIgnoreCase("a"))
            // type
            return "text/a";
        else if (fileExtension.equalsIgnoreCase("ucc"))
            return "text/ucc";
        else if (fileExtension.equalsIgnoreCase("exe"))
            return "application/octet-stream";
        else if (fileExtension.equalsIgnoreCase("jpg"))
            return "image/gif";
        else if (fileExtension.equalsIgnoreCase("gif"))
            return "image/gif";
        else if (fileExtension.equalsIgnoreCase("png"))
            return "image/gif";
        else if (fileExtension.equalsIgnoreCase("bmp"))
            return "image/bmp";
        else if (fileExtension.equalsIgnoreCase("xls"))
            return "application/vnd.ms-excel";
        else if (fileExtension.equalsIgnoreCase("ppt"))
            return "application/x-msdownload";
        else if (fileExtension.equalsIgnoreCase("doc"))
            return "application/msword";
        else if (fileExtension.equalsIgnoreCase("rtf"))
            return "application/rtf";
        else if (fileExtension.equalsIgnoreCase("txt"))
            return "text/plain";
        else if (fileExtension.equalsIgnoreCase("pdf"))
            return "application/pdf";
        else if (fileExtension.equalsIgnoreCase("audio_basic"))
            return "audio/basic";
        else if (fileExtension.equalsIgnoreCase("audio_wav"))
            return "audio/wav";
        else if (fileExtension.equalsIgnoreCase("image_gif"))
            return "image/gif";
        else if (fileExtension.equalsIgnoreCase("image_jpeg"))
            return "image/jpeg";
        else if (fileExtension.equalsIgnoreCase("image_bmp"))
            return "image/bmp";
        else if (fileExtension.equalsIgnoreCase("image_x-png"))
            return "image/x-png";
        else if (fileExtension.equalsIgnoreCase("msdownload"))
            return "application/x-msdownload";
        else if (fileExtension.equalsIgnoreCase("video_avi"))
            return "video/avi";
        else if (fileExtension.equalsIgnoreCase("video_mpeg"))
            return "video/mpeg";
        else if (fileExtension.equalsIgnoreCase("html") || fileExtension.equalsIgnoreCase("htm"))
            return "text/html";
        else if (fileExtension.equalsIgnoreCase("xml"))
            return "text/xml";
        else if (fileExtension.equalsIgnoreCase("zip"))
            return "application/zip";
        else
            return "application/stream";
	}

	
	
	
	
}