package com.sai.laps.ejb.bankappfi;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.ArrayList;
import java.util.concurrent.TimeUnit;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.fw.management.utils.FwHelper;
import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.ConnectionFactory;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
@Stateless(name = "BankAppFIBean", mappedName = "BankAppFIHome")
@Remote (BankAppFIRemote.class)

public class BankAppFIBean extends BeanAdapter
{
	static Logger log=Logger.getLogger(BankAppFIBean.class);	
	private static final long serialVersionUID = 1L;

	public  HashMap getData(HashMap hshValues) 
	{
		String strQuery="";
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2	= null;
		HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();
		ArrayList vecVal=new ArrayList();
		boolean recordflag=false;
		String strQuery1="";
		String strcombk_modtype="";
		try
		{
			String appno=correctNull((String)hshValues.get("appno"));
			String strAction = correctNull((String)hshValues.get("hidAction"));
			String strGradeNo= correctNull((String)hshValues.get("selsno1"));
			String strcomappid= correctNull((String)hshValues.get("hidapplicantid"));
			
			if(rs!=null)
			{
				rs.close();
			}
			if(strcomappid.equalsIgnoreCase(""))
			{
				strcomappid=Helper.correctNull((String)hshValues.get("hidAppId"));
			}
			rs = DBUtils.executeLAPSQuery("select_perappoldid^" + strcomappid);
			if(rs.next())
			{
				strcomappid=Helper.correctNull((String)rs.getString("perapp_oldid"));
			}
			strQuery = SQLParser.getSqlQuery("combankingselectNEWforba^"+appno);
			if(rs!=null){rs.close();}
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				vecVal=new ArrayList();
				vecVal.add(Helper.correctInt((String)rs.getString("combk_id")));//0
				vecVal.add(Helper.correctNull((String)rs.getString("combk_facility")));//1
				vecVal.add(Helper.correctNull((String)rs.getString("combk_osasondate")));//2
				vecVal.add(Helper.correctNull((String)rs.getString("combk_bnktype")));//3
				vecVal.add(Helper.correctNull((String)rs.getString("combk_inttype")));//4
				vecVal.add(Helper.correctNull((String)rs.getString("combk_credittype")));//5
				vecVal.add(Helper.correctNull((String)rs.getString("combk_sancrefno")));//6
				vecVal.add(Helper.correctNull((String)rs.getString("combk_sancdate")));//7
				vecVal.add(Helper.correctNull((String)rs.getString("combk_duedate")));//8
				vecVal.add(Helper.replaceForJavaScriptString((String)rs.getString("combk_arrears")));//9
				vecVal.add(Helper.correctNull((String)rs.getString("combk_companyname")));//10
				String strBank	= correctNull((String)rs.getString("combk_bnk"));			
				vecVal.add(strBank);//11
				if(Helper.correctNull((String)rs.getString("combk_bnk")).equalsIgnoreCase("Our"))
				{
					vecVal.add("Karnataka Bank");//12
				}
				else
				{
					vecVal.add(Helper.correctNull((String)rs.getString("combk_bnkname")));//12
				}
				
				vecVal.add(Helper.correctNull((String)rs.getString("combk_fundtype")));//13
				vecVal.add(Helper.correctDouble((String)rs.getString("combk_limit")));//14
				vecVal.add(Helper.correctDouble((String)rs.getString("combk_os")));//15
				vecVal.add(Helper.correctDouble((String)rs.getString("combk_spread")));//16
				vecVal.add(Helper.replaceForJavaScriptString((String)rs.getString("combk_remarks")));//17
				
				if(strBank.equalsIgnoreCase("Our"))
				{
				    strcombk_modtype		= correctNull((String)rs.getString("combk_modtype"));
					String strFacility		= correctNull((String)rs.getString("combk_facility"));
					String[] strFacilityArr	= strFacility.split("~");
					
					if(strFacilityArr.length>0)
					{
						if(strcombk_modtype.equalsIgnoreCase("r") || strcombk_modtype.equalsIgnoreCase("p"))
						{
							strQuery1	= SQLParser.getSqlQuery("sel_retProductDesc^"+strFacilityArr[0]);
							rs1 		= DBUtils.executeQuery(strQuery1);
							if(rs1.next())
							{
								vecVal.add(Helper.correctNull(rs1.getString("com_facdesc")));//18
							}
							else
							{
								vecVal.add("");//18
							}
						}
						else if(strcombk_modtype.equalsIgnoreCase("c"))
						{
							strQuery1	= SQLParser.getSqlQuery("sel_FacilityCorpDesc^"+strFacilityArr[0]+"^c");
							rs1 		= DBUtils.executeQuery(strQuery1);
							if(rs1.next())
							{
								vecVal.add(Helper.correctNull(rs1.getString("com_facdesc")));//18
							}
							else
							{
								vecVal.add("");//18
							}
						}
						else if(strcombk_modtype.equalsIgnoreCase("a"))
						{
							strQuery1	= SQLParser.getSqlQuery("sel_FacilityCorpDesc^"+strFacilityArr[0]+"^a");
							rs1 		= DBUtils.executeQuery(strQuery1);
							if(rs1.next())
							{
								vecVal.add(Helper.correctNull(rs1.getString("com_facdesc")));//18
							}else
							{
								vecVal.add("");//18
							}
						}
						else
						{
							vecVal.add("");//18
						}
					}
					else
					{
						vecVal.add("");//18
					}
				}
				else
				{
					vecVal.add("");//18
				}
				
				vecVal.add(Helper.correctNull((String)rs.getString("combk_facility_sno")));//19
				if(strcombk_modtype.equalsIgnoreCase("p"))
				{
					strcombk_modtype="r";
				}
				vecVal.add(strcombk_modtype);//20
				vecVal.add(Helper.correctNull((String)rs.getString("combk_monthly_ins")));//21
				vecVal.add(Helper.correctNull((String)rs.getString("combk_type")));//22
				vecVal.add(Helper.correctNull((String)rs.getString("COMBK_CBSAPPNO")));//23 added by ganesan for cbsAppno
				vecVal.add(Helper.correctNull((String)rs.getString("combk_bnkname")));//24
				vecVal.add(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_interestrate")))));//25
				vecVal.add(Helper.correctNull((String)rs.getString("combk_repaymenttype")));//26
				vecVal.add(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_drawingpower")))));//27			
				vecVal.add(Helper.replaceForJavaScriptString((String)rs.getString("combk_purpose")));//28
				vecVal.add(Helper.correctNull((String)rs.getString("combk_prestatus")));//29 added by rajesh on 02/03/2014
				vecVal.add(Helper.correctInt((String)rs.getString("combk_factype")));//30
				vecVal.add(Helper.correctInt((String)rs.getString("combk_fac_grp")));//31
				
				//Mani Facility Des
				if(!Helper.correctInt((String)rs.getString("combk_fac_grp")).equals("0"))
				{
						strQuery = SQLParser.getSqlQuery("combankingselectNEWforba_desc^"+appno+"^"+Helper.correctInt((String)rs.getString("combk_fac_grp")));
						if(rs2!=null){rs2.close();}
						rs2 	= DBUtils.executeQuery(strQuery);
						if(rs2.next())
						{
							strBank	= correctNull((String)rs2.getString("combk_bnk"));
							
							if(strBank.equalsIgnoreCase("Our"))
							{
							    strcombk_modtype		= correctNull((String)rs2.getString("combk_modtype"));
								String strFacility		= correctNull((String)rs2.getString("combk_facility"));
								String[] strFacilityArr	= strFacility.split("~");
								
								if(strFacilityArr.length>0)
								{
									if(rs1!=null){rs1.close();}
									if(strcombk_modtype.equalsIgnoreCase("r") || strcombk_modtype.equalsIgnoreCase("p"))
									{
										strQuery1	= SQLParser.getSqlQuery("sel_retProductDesc^"+Helper.correctInt(strFacilityArr[0]));
										rs1 		= DBUtils.executeQuery(strQuery1);
										if(rs1.next())
										{
											vecVal.add(Helper.correctNull(rs1.getString("com_facdesc")));//32
										}
										else
										{
											vecVal.add("");//32
										}
									}
									else if(strcombk_modtype.equalsIgnoreCase("c"))
									{
										strQuery1	= SQLParser.getSqlQuery("sel_FacilityCorpDesc^"+Helper.correctInt(strFacilityArr[0])+"^c");
										rs1 		= DBUtils.executeQuery(strQuery1);
										if(rs1.next())
										{
											vecVal.add(Helper.correctNull(rs1.getString("com_facdesc")));//32
										}
										else
										{
											vecVal.add("");//32
										}
									}
									else if(strcombk_modtype.equalsIgnoreCase("a"))
									{
										strQuery1	= SQLParser.getSqlQuery("sel_FacilityCorpDesc^"+Helper.correctInt(strFacilityArr[0])+"^a");
										rs1 		= DBUtils.executeQuery(strQuery1);
										if(rs1.next())
										{
											vecVal.add(Helper.correctNull(rs1.getString("com_facdesc")));//32
										}else
										{
											vecVal.add("");//32
										}
									}
									else
									{
										vecVal.add("");//32
									}
								}
								else
								{
									vecVal.add("");//32
								}
							}
							else
							{
								vecVal.add("");//32
							}
					}
					else
					{
						vecVal.add("");//32
					}
					//End
				}
				else
				{
					vecVal.add("");//32
				}
				vecVal.add(Helper.correctInt((String)rs.getString("com_exposure")));//33
				vecVal.add(Helper.replaceForJavaScriptString((String)rs.getString("combk_repaymentcmt")));//34
				vecVal.add(Helper.correctNull(rs.getString("COMBK_FACTYPE1")));//35
				vecVal.add(Helper.correctNull(rs.getString("COMBK_FACCATEGORY")));//36
				vecData.add(vecVal);
				recordflag=true;
			}
			hshRecord.put("vecData",vecData);
			hshRecord.put("hidAppId",strcomappid);
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
			
			//Added by Amaravathi for Consortium Tab
			if(rs!=null){rs.close();}
			rs = DBUtils.executeLAPSQuery("sel_BAConsVal^"+appno);
			if(rs.next())
			{
				hshRecord.put("com_tl_bnkarg",correctNull(rs.getString("com_tl_bnkarg")));
				hshRecord.put("com_tl_type",correctNull(rs.getString("com_tl_type")));
				hshRecord.put("com_wc_bnkarg",correctNull(rs.getString("com_wc_bnkarg")));
				hshRecord.put("com_wc_type",correctNull(rs.getString("com_wc_type")));
			}
			//End
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


	private int getMaxGradeId(String appno)
	{
		ResultSet rs = null;
		int termId = 0;

		try
		{
			rs=DBUtils.executeLAPSQuery("combankingmaxFI^"+appno);
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

	public void updateData(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String strGradeId = Helper.correctNull((String)hshValues.get("idno"));
		String appno=correctNull((String)hshValues.get("appno"));
		ResultSet rs=null;
		int intUpdatesize=0;
		StringBuilder sbolddata=new StringBuilder();
		
		try
		{
			String strBank=Helper.correctNull((String)hshValues.get("sel_Bank"));
			String strFacility="";
			if(strBank.equalsIgnoreCase("Our"))
			{
				strFacility=Helper.correctNull((String)hshValues.get("sel_Facility"));
			}
			else
			{
				strFacility=Helper.correctNull((String)hshValues.get("txt_Facility"));
			}
			String strOSAsOnDate=Helper.correctNull((String)hshValues.get("txt_OSAsOnDate"));
			String strBnkType=Helper.correctNull((String)hshValues.get("sel_BnkType"));
			String strIntType=Helper.correctNull((String)hshValues.get("sel_IntType"));
			String strCreditType=Helper.correctNull((String)hshValues.get("sel_CreditType"));
			String strSancRefNo=Helper.correctNull((String)hshValues.get("txt_SancRefNo"));
			String strSancDate=Helper.correctNull((String)hshValues.get("txt_SancDate"));
			String strDueDate=Helper.correctNull((String)hshValues.get("txt_DueDate"));
			String strArrears=Helper.correctNull((String)hshValues.get("txtArea_Arrears"));
			String strCompName=Helper.correctNull((String)hshValues.get("sel_CompName"));
			String strBankName="Karnataka Bank";
			String strType=Helper.correctNull((String)hshValues.get("facility_type"));
			String strLimit=Helper.correctNull((String)hshValues.get("txt_Limit"));
			String strOS=Helper.correctNull((String)hshValues.get("txt_OS"));
			String strSpreadVal=Helper.correctNull((String)hshValues.get("txt_SpreadVal"));
			String strRemarks=Helper.correctNull((String)hshValues.get("txtarea_Remarks"));
			String strFacSNo=Helper.correctNull((String)hshValues.get("hidFacSNo"));
			//String strFacType="T";
			String strFacType=Helper.correctNull((String)hshValues.get("sel_FacilityType"));
			String strModuleType=Helper.correctNull((String)hshValues.get("sel_Module"));
			String strMonthlyIns=Helper.correctNull((String)hshValues.get("txt_monthlyins"));
			String strcbsappno=Helper.correctNull((String)hshValues.get("txt_cbsappno"));			
			String strIntrate=Helper.correctNull((String)hshValues.get("txt_bank_intrate"));
			String strRepayType=Helper.correctNull((String)hshValues.get("com_banksel_repaytype"));
			String strDrwPower=Helper.correctNull((String)hshValues.get("txt_bank_drwpower"));
			String strPurpose=Helper.correctNull((String)hshValues.get("txtArea_purpose"));
			String strprestatus=Helper.correctNull((String)hshValues.get("txt_prestatus"));
			
			String strFacilityType	= correctNull((String)hshValues.get("sel_factype"));
			String strFacilityOf	= correctNull((String)hshValues.get("txt_facof"));
			
			if(strAction.equalsIgnoreCase("insert"))
			{
				strGradeId = Integer.toString(getMaxGradeId(appno));
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","combankinginsertNEW");
				arrValues.add(appno);
				arrValues.add(strGradeId);
				arrValues.add(strFacType);
				arrValues.add(strFacility);
				//arrValues.add(strOSAsOnDate);
				arrValues.add(strBnkType);
				arrValues.add(strIntType);
				arrValues.add(strCreditType);
				arrValues.add(strSancRefNo);
				arrValues.add(strSancDate);
				arrValues.add(strDueDate);
				arrValues.add(strArrears);
				arrValues.add(strCompName);
				arrValues.add(strBank);
				arrValues.add(strBankName);
				arrValues.add(strType);
				arrValues.add(strLimit);
				arrValues.add(strOS);
				arrValues.add(strSpreadVal);
				arrValues.add(strRemarks);
				arrValues.add(strFacSNo);
				arrValues.add(strModuleType);
				arrValues.add("0");
				arrValues.add(strcbsappno);//Added by ganesan for cbsAppno field
				//added by bhaskar for new columns
				arrValues.add(strIntrate);
				arrValues.add(strRepayType);
				arrValues.add(strDrwPower);
				arrValues.add(strPurpose);
				arrValues.add(strprestatus);
				arrValues.add(strFacilityType);
				arrValues.add(strFacilityOf);
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("update"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","combankingupdateNEW");
				arrValues.add(strFacility);
				//arrValues.add(strOSAsOnDate);
				arrValues.add(strBnkType);
				arrValues.add(strIntType);
				arrValues.add(strCreditType);
				arrValues.add(strSancRefNo);
				arrValues.add(strSancDate);
				arrValues.add(strDueDate);
				arrValues.add(strArrears);
				arrValues.add(strCompName);
				arrValues.add(strBank);
				arrValues.add(strBankName);
				//arrValues.add(strType);
				arrValues.add(strLimit);
				arrValues.add(strOS);
				arrValues.add(strSpreadVal);
				arrValues.add(strRemarks);
				arrValues.add(strFacSNo);
				arrValues.add(strModuleType);
				arrValues.add(strMonthlyIns);
				arrValues.add(strcbsappno);//Added by ganesan for cbsAppno field
				//added by bhaskar for new columns
				arrValues.add(strIntrate);
				arrValues.add(strRepayType);
				arrValues.add(strDrwPower);
				arrValues.add(strPurpose);
				arrValues.add(strprestatus);
				arrValues.add(strFacilityType);
				arrValues.add(strFacilityOf);
				arrValues.add(Helper.correctNull((String)hshValues.get("txtArea_repayment")));
				
				arrValues.add(appno);
				arrValues.add(strGradeId);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				String strExp ="$";
				String strQuery=SQLParser.getSqlQuery("sel_appSecdetailsfaccoll^"+appno+"^E^ and app_sec_facsno='"+strFacSNo+"'");
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strExp = strExp+"Cannot delete since this Facility is attached to securities.";					
					throw new Exception(strExp);	
				}
				else
				{
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","combankingdeleteNEW");
					arrValues.add(appno);
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
	
	/** Modified by Dinesh on 17/02/2014 for Security Values Details ***/
	
    public HashMap getSecurityRetailDetails(HashMap hshValues) 
    {
    	HashMap hshResult=new HashMap();
    	ArrayList arrSecCol=new ArrayList();
    	ArrayList arrSecRow=new ArrayList();
    	
    	ArrayList arrAttachCol=new ArrayList();
    	ArrayList arrAttachRow=new ArrayList();
    	ResultSet rs=null;
    	ResultSet rs1=null;
    	ResultSet rs2=null;
    	ResultSet rs3=null;
    	String strQuery="";
    	String strAppno="",newLapsId="",oldLapsId="0",strappId="",strExisting="",strShowFlag="";
    	String strSecurityId="";
    	String strSecClassType="";
    	String strLoanType="";
    	String strSecurityType="";
    	String strProductType="";
    	int count =0;
    	try
    	{
    		StringBuilder strName=new StringBuilder();
    		strappId = Helper.correctNull((String)hshValues.get("hidapplicantid"));
    		strAppno=Helper.correctNull((String)hshValues.get("appno"));
    		newLapsId=Helper.correctNull((String)hshValues.get("sel_applicants"));
    		if(newLapsId.equalsIgnoreCase("") || newLapsId.equalsIgnoreCase("0"))
    		{
    			newLapsId=Helper.correctNull((String)hshValues.get("hidapplicantid"));
    		}
    		strQuery = SQLParser.getSqlQuery("selcustomerdetails^"+newLapsId);
    		rs = DBUtils.executeQuery(strQuery);
    		if(rs.next())
    		{
    			oldLapsId = Helper.correctNull((String) rs.getString("perapp_oldid"));
    		}
    		strProductType = Helper.correctNull((String)hshValues.get("strProductType"));
    		
    		if(strProductType.equalsIgnoreCase("pC"))
    		{
    			strQuery = SQLParser.getSqlQuery("sel_securityvalues_clean^"+oldLapsId);
    		}
    		else if(strProductType.equalsIgnoreCase("pS"))
    		{
    			
    			String strShareType="0";
    			if(rs!=null)
    				rs.close();
    			strQuery = SQLParser.getSqlQuery("findapptype^"+strAppno);
        		rs = DBUtils.executeQuery(strQuery);
        		if(rs.next())
        		{
        			strShareType = Helper.correctNull((String) rs.getString("prd_sharetype"));
        		}
    			strQuery = SQLParser.getSqlQuery("sel_securityvalues_shares^"+oldLapsId+"^"+strShareType);
    		}
    		else
    		{
    			strQuery = SQLParser.getSqlQuery("sel_securityvalues^"+oldLapsId);
    		}
    		
    		rs1 = DBUtils.executeQuery(strQuery);
    		while(rs1.next())
    		{
    			strName=new StringBuilder();
	    		arrSecCol = new ArrayList();
	    		strSecurityId=Helper.correctNull((String) rs1.getString("CUS_SEC_ID"));
	    		arrSecCol.add(Helper.correctNull((String) rs1.getString("CUS_SEC_ID")));//0
	    		arrSecCol.add(Helper.correctNull((String) rs1.getString("CUS_SEC_TYPE")));//1
	    		strSecClassType = Helper.correctNull((String) rs1.getString("CUS_SEC_TYPE"));
	    		arrSecCol.add(Helper.correctNull((String) rs1.getString("CUS_SEC_CLASSIFICATION")));//2
	    		// for taking customer name 
	    		strQuery = SQLParser.getSqlQuery("sel_secowners^"+Helper.correctNull((String) rs1.getString("CUS_SEC_ID")));
		    	rs2 = DBUtils.executeQuery(strQuery);
		    	while(rs2.next())
		    	{
	    			strName.append(Helper.correctNull((String) rs2.getString("cus_name"))+" , ");
		    	}		    		
	    		if(strName.length()>0)
	    		{
	    			arrSecCol.add(strName.substring(0, strName.length()-2).toString());
	    		}
	    		else
	    		{
	    			arrSecCol.add(strName.toString());//3
	    		}
	    		arrSecCol.add(Helper.correctDouble((String) rs1.getString("CUS_SEC_NETSECURITY")));//4
	    		arrSecCol.add(Helper.correctDouble((String) rs1.getString("CUS_SEC_REIDUALVAL")));//5
	    		arrSecCol.add(Helper.correctNull((String) rs1.getString("SEC_NAME")));//6
	    		arrSecCol.add(Helper.correctNull((String) rs1.getString("SEC_CLASSIFICATION")));//7
	    		arrSecCol.add(Helper.correctNull((String) rs1.getString("CUS_SEC_JOINT_HOLDER")));//8
	    		arrSecCol.add(Helper.correctNull((String) rs1.getString("SEC_COLLATFLAG")));//9
	    		if(rs2 !=null)
	    		{
	    			rs2.close();
	    		}
	    		strQuery = SQLParser.getSqlQuery("sel_appSecdetails^"+strSecurityId+"^"+strAppno);
	    		rs2 = DBUtils.executeQuery(strQuery);
	    		if(rs2.next())
	    		{
	    			strLoanType=Helper.correctNull((String) rs2.getString("app_sec_loantype"));
	    			strSecurityType=Helper.correctNull((String) rs2.getString("app_sec_securitytype"));
	    			strExisting=Helper.correctNull((String) rs2.getString("app_sec_existing"));
	    			strShowFlag=Helper.correctNull((String) rs2.getString("app_sec_show"));
	    		}
	    		else
	    		{
	    			strLoanType="S";
	    			strSecurityType="0";
	    			strExisting="";
	    			strShowFlag="";
	    		}
	    		arrSecCol.add(strLoanType);//10
	    		arrSecCol.add(strSecurityType);//11
	    		arrSecCol.add(strExisting);//12
	    		arrSecCol.add(strShowFlag);//13
	    		arrSecCol.add(Helper.correctNull(rs1.getString("CUS_COMPANYSHARE_CNT")));//14
	    		arrSecRow.add(arrSecCol);
	    		if(rs2 != null)
				{
					rs2.close();
				}
	    		
	    		/*******************************************************
	    		 * fetching all the values of attached securities in   *
	    		 * app_securities table for present application        *
	    		 *******************************************************/
	    		String facid="",facsno="",factype="",margin="",facnature="",loanamt="",outstandamt="",loantype="",sectype="",PARENTAPPNO="",PARENTSNO="",strBowid="",strSectype="",strSecCattype="";
	    		boolean boolEntryflag=true;
	    		strQuery = SQLParser.getSqlQuery("sel_attachSecdetails^" + strAppno+"^"+strSecurityId+"^"+ strAppno+"^"+strSecurityId);
				rs2 = DBUtils.executeQuery(strQuery);
				String strFacID="";
				while(rs2.next())
				{
	    			count = Integer.parseInt(Helper.correctInt(rs2.getString("count")));
	    			if(count==1)
	    			{
	    				arrAttachCol = new ArrayList();
		    			arrAttachCol.add(Helper.correctNull(rs2.getString("app_sec_facid")));//0
		    			arrAttachCol.add(Helper.correctNull(rs2.getString("app_sec_facsno")));
		    			arrAttachCol.add(Helper.correctNull(rs2.getString("app_sec_factype")));
		    			arrAttachCol.add(Helper.correctNull(rs2.getString("app_sec_margin")));//3
		    			arrAttachCol.add(Helper.correctNull(rs2.getString("app_sec_facnature")));
		    			arrAttachCol.add(Helper.correctNull(rs2.getString("app_sec_loanamt")));
		    			arrAttachCol.add(Helper.correctNull(rs2.getString("app_sec_outstandamt")));//6
		    			arrAttachCol.add(Helper.correctNull(rs2.getString("app_sec_loantype")));
		    			arrAttachCol.add(Helper.correctNull(rs2.getString("app_sec_securitytype")));
		    			arrAttachCol.add(Helper.correctNull(rs2.getString("APP_SEC_PARENTAPPNO")));
		    			arrAttachCol.add(Helper.correctNull(rs2.getString("APP_SEC_PARENT_FACSNO")));
		    			arrAttachCol.add(Helper.correctNull(rs2.getString("APP_SEC_BORROWER_ID")));//11
		    			arrAttachCol.add(Helper.correctNull(rs2.getString("APP_SEC_SECUTYPE")));//12
		    			arrAttachCol.add(strSecClassType);//13
		    			arrAttachRow.add(arrAttachCol);
		    			boolEntryflag = false;
	    			}
	    			else if (count >1)
	    			{
	    				if(facid.equalsIgnoreCase(""))
	    				{
	    					facid = correctNull((String)rs2.getString("app_sec_facid"));
	    				}
	    				else
	    				{
	    					facid = facid +"~"+correctNull((String)rs2.getString("app_sec_facid"));
	    				}
	    				if(facsno.equalsIgnoreCase(""))
	    				{
	    					facsno = correctNull((String)rs2.getString("app_sec_facsno"));
	    				}
	    				else
	    				{
	    					facsno = facsno +"~"+correctNull((String)rs2.getString("app_sec_facsno"));
	    				}
	    				if(factype.equalsIgnoreCase(""))
	    				{
	    					factype = correctNull((String)rs2.getString("app_sec_factype"));
	    				}
	    				else
	    				{
	    					factype = factype +"~"+correctNull((String)rs2.getString("app_sec_factype"));
	    				}
	    				
	    				if(margin.equalsIgnoreCase(""))
	    				{
	    					margin = correctNull((String)rs2.getString("app_sec_margin"));
	    				}
	    				else
	    				{
	    					margin = margin +"~"+correctNull((String)rs2.getString("app_sec_margin"));
	    				}
	    				
	    				if(facnature.equalsIgnoreCase(""))
	    				{
	    					facnature = correctNull((String)rs2.getString("app_sec_facnature"));
	    				}
	    				else
	    				{
	    					facnature = facnature +"~"+correctNull((String)rs2.getString("app_sec_facnature"));
	    				}
	    				
	    				if(loanamt.equalsIgnoreCase(""))
	    				{
	    					loanamt = correctNull((String)rs2.getString("app_sec_loanamt"));
	    				}
	    				else
	    				{
	    					loanamt = loanamt +"~"+correctNull((String)rs2.getString("app_sec_loanamt"));
	    				}
	    				
	    				if(outstandamt.equalsIgnoreCase(""))
	    				{
	    					outstandamt = correctNull((String)rs2.getString("app_sec_outstandamt"));
	    				}
	    				else
	    				{
	    					outstandamt = outstandamt +"~"+correctNull((String)rs2.getString("app_sec_outstandamt"));
	    				}
	    				if(loantype.equalsIgnoreCase(""))
	    				{
	    					loantype = correctNull((String)rs2.getString("APP_SEC_LOANTYPE"));
	    				}
	    				else
	    				{
	    					loantype = loantype +"~"+correctNull((String)rs2.getString("APP_SEC_LOANTYPE"));
	    				}
	    				if(sectype.equalsIgnoreCase(""))
	    				{
	    					sectype = correctNull((String)rs2.getString("app_sec_securitytype"));
	    				}
	    				else
	    				{
	    					sectype = sectype +"~"+correctNull((String)rs2.getString("app_sec_securitytype"));
	    				}
	    				if(PARENTAPPNO.equalsIgnoreCase(""))
	    				{
	    					PARENTAPPNO = Helper.correctNull(rs2.getString("APP_SEC_PARENTAPPNO"));
	    				}
	    				else
	    				{
	    					PARENTAPPNO = PARENTAPPNO +"~"+Helper.correctNull(rs2.getString("APP_SEC_PARENTAPPNO"));
	    				}
	    				if(PARENTSNO.equalsIgnoreCase(""))
	    				{
	    					PARENTSNO = Helper.correctNull(rs2.getString("APP_SEC_PARENT_FACSNO"));
	    				}
	    				else
	    				{
	    					PARENTSNO = PARENTSNO +"~"+Helper.correctNull(rs2.getString("APP_SEC_PARENT_FACSNO"));
	    				}
	    				if(strBowid.equalsIgnoreCase(""))
	    				{
	    					strBowid = Helper.correctNull(rs2.getString("APP_SEC_BORROWER_ID"));
	    				}
	    				else
	    				{
	    					if(!strBowid.contains(correctNull((String)rs2.getString("APP_SEC_BORROWER_ID"))))
	    					strBowid = strBowid +"~"+Helper.correctNull(rs2.getString("APP_SEC_BORROWER_ID"));
	    				}
	    				
	    				if(strSectype.equalsIgnoreCase(""))
	    				{
	    					strSectype = Helper.correctNull(rs2.getString("APP_SEC_SECUTYPE"));
	    				}
	    				else
	    				{
	    					strSectype = strSectype +"~"+Helper.correctNull(rs2.getString("APP_SEC_SECUTYPE"));
	    				}
	    				if(strSecCattype.equalsIgnoreCase(""))
	    				{
	    					strSecCattype = strSecClassType;
	    				}
	    				else
	    				{
	    					strSecCattype = strSecCattype +"~"+strSecClassType;
	    				}
	    				
	    				
	    			}
				}
	    		if(count >1)
	    		{
	    			arrAttachCol = new ArrayList();
	    			arrAttachCol.add(facid);//0
	    			arrAttachCol.add(facsno);
	    			arrAttachCol.add(factype);
	    			arrAttachCol.add(margin);
	    			arrAttachCol.add(facnature);
	    			arrAttachCol.add(loanamt);
	    			arrAttachCol.add(outstandamt);
	    			arrAttachCol.add(loantype);
	    			arrAttachCol.add(sectype);
	    			arrAttachCol.add(PARENTAPPNO);
	    			arrAttachCol.add(PARENTSNO);
	    			arrAttachCol.add(strBowid);//11
	    			arrAttachCol.add(strSectype);//12
	    			arrAttachCol.add(strSecCattype);//13
	    			arrAttachRow.add(arrAttachCol);
	    		}
	    		else if(boolEntryflag)
	    		{
	    			arrAttachCol = new ArrayList();
	    			arrAttachCol.add("");
	    			arrAttachCol.add("");
	    			arrAttachCol.add("");
	    			arrAttachCol.add("");
	    			arrAttachCol.add("");
	    			arrAttachCol.add("");
	    			arrAttachCol.add("");
	    			arrAttachCol.add("");
	    			arrAttachCol.add("");
	    			arrAttachCol.add("");
	    			arrAttachCol.add("");
	    			arrAttachCol.add("");
	    			arrAttachCol.add("");
	    			arrAttachCol.add(strSecClassType);
	    			arrAttachRow.add(arrAttachCol);
	    			boolEntryflag = true;
	    		}
	    		/******/
    		}
    		//for checking freeze count
		   	int strFreezecount=0;
		   	String strFreezeflag="N";
		   	strQuery = SQLParser.getSqlQuery("sel_freezecount^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{	
				strFreezecount=Integer.parseInt(Helper.correctInt(rs.getString("freezecount")));
				if(strFreezecount!=0 )
				{
					strFreezeflag="Y";
				}
			}
			
			//property type securities attached
			if(rs!=null)
    			rs.close();
		 	String propsecFlag="N";
			strQuery = SQLParser.getSqlQuery("sel_propSecAttachedtoprop^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshResult.put("propsecFlag", "Y");
			}		
			hshResult.put("strFreezeflag",strFreezeflag);
    		hshResult.put("arrSecRow",arrSecRow);
    		hshResult.put("strAppno",strAppno);
    		hshResult.put("strcmpId",oldLapsId);
    		hshResult.put("strappId",strappId);
    		hshResult.put("arrAttachRow",arrAttachRow);
    		hshResult.put("strPrdType",Helper.correctNull((String)hshValues.get("strProductType")));
    		hshResult.put("strProductType",correctNull((String)hshValues.get("strProductType")));
    		
    		//To select the post sanction parameters
			String strQueryPS = SQLParser.getSqlQuery("sel_PS_oldaccnum^"+strAppno+"^ ");
			ResultSet rsPS = DBUtils.executeQuery(strQueryPS);
			if(rsPS.next())
			{
				hshResult.put("strPostSancParam",Helper.correctNull(rsPS.getString("PS_MODIFY_TERMS")));
			}
			
			//Entry for Security release in case of post sanction modification
			if(Helper.correctNull((String)hshValues.get("strAppType")).equalsIgnoreCase("P"))
			{
				String strPrdCode="";
				strQuery = SQLParser.getSqlQuery("comfunsel1^"+strAppno);
				if(rs2 != null)
				{
					rs2.close();
				}
				rs2 = DBUtils.executeQuery(strQuery);
				if(rs2.next())
				{
					strPrdCode=Helper.correctNull(rs2.getString("app_prdcode"));
				}
				
				if(rsPS!=null)
					rsPS.close();
				strQueryPS = SQLParser.getSqlQuery("seldistinctappno^"+strAppno);
				rsPS = DBUtils.executeQuery(strQueryPS);
				while(rsPS.next())
				{
					if(rs!=null)
		    			rs.close();
					strQuery=SQLParser.getSqlQuery("selparentfacattachedsec^"+strPrdCode+"^"+Helper.correctNull(rsPS.getString("appno")));
					rs = DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						if(rs1!=null)
			    			rs1.close();
						strQuery=SQLParser.getSqlQuery("chk_attachedsecurities^"+Helper.correctNull(rs.getString("app_sec_secid"))+"^"+strPrdCode+"^"+strAppno);
						rs1 = DBUtils.executeQuery(strQuery);
						if(!rs1.next())
						{
							HashMap hshQueryValues=new HashMap();
							HashMap hshQuery=new HashMap();
							ArrayList arrValues=new ArrayList();
							hshQueryValues.put("size","1");
							hshQuery.put("strQueryId", "insappsecuritydetailspostsanc_corp");
							arrValues.add(strAppno);
							arrValues.add(strPrdCode);
							arrValues.add(Helper.correctNull(rs.getString("app_sec_secid")));
							arrValues.add(strPrdCode);
							arrValues.add(Helper.correctNull(rsPS.getString("appno")));
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("1", hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}
					}
				}
			}
			
			if(rs!=null)
    			rs.close();
			rs=DBUtils.executeLAPSQuery("sel_prdDesc^"+strAppno);
			if(rs.next())
			{
				hshResult.put("prd_applicablefor", Helper.correctNull((String)rs.getString("PRD_APPLICABLEFOR")));
			}	
			//for proposed assets check 
			if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("sel_editApply_valuation^"+ strAppno);
    		rs = DBUtils.executeQuery(strQuery);
			while(rs.next()) 
			{
				if(Helper.correctNull((String)rs.getString("EDIT_APPLY_FLAG")).equalsIgnoreCase("N")){
					hshResult.put("valuationFlag","N");
				}
			}
    			
			if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("sel_editApply_house^"+ strAppno);
    		rs = DBUtils.executeQuery(strQuery);
			while(rs.next()) 
			{
				if(Helper.correctNull((String)rs.getString("PHPA_EDIT_APPLYFLAG")).equalsIgnoreCase("N")){
					hshResult.put("HouseEdit_Flag","N");
				}
			}
			
			if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("sel_editApply_vehicle^"+ strAppno);
    		rs = DBUtils.executeQuery(strQuery);
			while(rs.next()) 
			{
				if(Helper.correctNull((String)rs.getString("AUTO_EDIT_APPLYFLAG")).equalsIgnoreCase("N")){
					hshResult.put("VehicleEdit_Flag","N");
				}
			}
			//To update the security description as per the sanction time
//			if(Helper.correctNull((String)hshValues.get("strappstatus")).equalsIgnoreCase("op"))
//			{
//				HashMap hshQueryValues=new HashMap();
//				HashMap hshQuery=new HashMap();
//				ArrayList arrValues=new ArrayList();
//				hshQueryValues.put("size","1");
//				hshQuery.put("strQueryId", "upd_sec_desc_pending");
//				arrValues.add(strAppno);
//				hshQuery.put("arrValues", arrValues);
//				hshQueryValues.put("1", hshQuery);
//				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
//			}
			
    		
    	}
    	catch(Exception e)
		{
			throw new EJBException("Error in getSecurityRetailDetails "+e.toString());
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
    			throw new EJBException("Error in getSecurityRetailDetails "+e.toString());
    		} 
    	}
    	return hshResult;
    }
    
    
 /** Modified by Dinesh on 17/02/2014 for Security Values Details ***/
    
    public void updateSecurityRetailDetails (HashMap hshValues) 
    {
    	ResultSet rs = null;
    	ResultSet rs1 = null;
    	ResultSet rs2 = null;
		try
		{
			String strQuery=null;
			HashMap hshQueryValues=new HashMap();
			HashMap hshQuery = new HashMap();
			HashMap hshQueryValueslov=new HashMap();
			HashMap hshQuerylov = new HashMap();
			ArrayList arrVallov=new ArrayList();
			HashMap hshRecord=new HashMap();
			ArrayList arrRow=new ArrayList();
			ArrayList arrCol=new ArrayList();
			ArrayList arrVal=new ArrayList();
			String hidSecurityId=Helper.correctNull((String)hshValues.get("hidSecurityId"));
			String strAppno=Helper.correctNull((String)hshValues.get("appno"));
			int arrSize=Integer.parseInt((String)hshValues.get("hidsize"));
			String[] SecID = new String[arrSize];
			String[] CustID = new String[arrSize];
			String[] SecValue = new String[arrSize];
			String[] ResiValue = new String[arrSize];
			String[] Facsno = new String[arrSize];
			String[] FacType = new String[arrSize];
			String[] Margin = new String[arrSize];
			String[] FacNature = new String[arrSize];
			String[] FacID = new String[arrSize];
			String[] SecType = new String[arrSize];
			String[] LoanAmt = new String[arrSize];
			String[] OutstandAmt = new String[arrSize];
			String[] Unsec = new String[arrSize];
			String[] LoanType=new String[arrSize];
			String[] IsCollateral=new String[arrSize];
			String[] str_type=new String[arrSize];
			String[] hidSecExisting=new String[arrSize];
			String[] strSelect=new String[arrSize];
			String[] strparentappno=new String[arrSize];
			String[] strparentsno=new String[arrSize];
			String[] strBowID=new String[arrSize];
			String[] strSecuritytype=new String[arrSize];
			String[] strShareCnt=new String[arrSize];
			String[] hidSecClass=new String[arrSize];
			
			String strAction = correctNull((String)hshValues.get("hidAction"));
			String Applicant = correctNull((String)hshValues.get("hid_applicant"));
			String strPrdType="",streditFlag_hou="N",streditFlag_val="N",streditFlag_veh="N";
			double totalArea=0,extBuild=0;
			int srlnmbr=0,snmbr=0;
			if(hshValues.get("hidSecID") instanceof String)
			{
			SecID[0]=((String) hshValues.get("hidSecID"));
			SecValue[0]= ((String) hshValues.get("hid_securityVal"));
			ResiValue[0]= ((String) hshValues.get("hid_residualVal"));
			SecType[0]= ((String) hshValues.get("sel_sectype"));
			Facsno[0]= ((String) hshValues.get("hidFacSno"));
			FacType[0]= ((String) hshValues.get("hidFacType"));
			Margin[0]= ((String) hshValues.get("hidSecMargin"));
			FacNature[0]= ((String) hshValues.get("hidFacNature"));
			LoanAmt[0]= ((String) hshValues.get("hidFacLimit"));
			OutstandAmt[0]= ((String) hshValues.get("hidFacOutstand"));
			Unsec[0]= ((String) hshValues.get("sel_sectype"));
			CustID[0]= ((String) hshValues.get("sel_sectype"));
			FacID[0]= ((String) hshValues.get("hidFacID"));
			LoanType[0]= ((String) hshValues.get("sel_exisprop"));
			IsCollateral[0]= ((String)hshValues.get("hidCollFlag"));
			str_type[0]=((String)hshValues.get("hidType"));
			hidSecExisting[0]= ((String) hshValues.get("hidSecExisting"));
			strSelect[0]= ((String) hshValues.get("hidSelect"));
			strparentappno[0]= ((String) hshValues.get("hid_parentappno"));
			strparentsno[0]= ((String) hshValues.get("hid_parentsno"));
			strBowID[0] = (String)hshValues.get("hidBowID");
			strSecuritytype[0] = (String)hshValues.get("hidsecuritytype");
			strShareCnt[0] = (String)hshValues.get("hidsharecount");
			hidSecClass[0] = (String)hshValues.get("hidSecClass");

			}
			else
			{
				SecID = (String[]) hshValues.get("hidSecID");
				SecValue = (String[]) hshValues.get("hid_securityVal");
				ResiValue = (String[]) hshValues.get("hid_residualVal");
				SecType = (String[]) hshValues.get("sel_sectype");
				Facsno = (String[]) hshValues.get("hidFacSno");
				FacType = (String[]) hshValues.get("hidFacType");
				Margin = (String[]) hshValues.get("hidSecMargin");
				FacNature = (String[]) hshValues.get("hidFacNature");
				LoanAmt = (String[]) hshValues.get("hidFacLimit");
				OutstandAmt = (String[]) hshValues.get("hidFacOutstand");
				Unsec = (String[]) hshValues.get("sel_sectype");
				CustID = (String[]) hshValues.get("sel_sectype");
				FacID = (String[]) hshValues.get("hidFacID");
				LoanType = (String[]) hshValues.get("sel_exisprop");
				IsCollateral = (String[])hshValues.get("hidCollFlag");
				str_type=(String[])hshValues.get("hidType");
				hidSecExisting = (String[]) hshValues.get("hidSecExisting");
				strSelect = (String[]) hshValues.get("hidSelect");
				strparentappno = (String[]) hshValues.get("hid_parentappno");
				strparentsno = (String[]) hshValues.get("hid_parentsno");
				strBowID = (String[])hshValues.get("hidBowID");
				strSecuritytype = (String[])hshValues.get("hidsecuritytype");
				strShareCnt = (String[])hshValues.get("hidsharecount");
				hidSecClass = (String[])hshValues.get("hidSecClass");
			}
			strPrdType=Helper.correctNull((String)hshValues.get("strProductType"));
			int intLen=0;
			strQuery = SQLParser.getSqlQuery("selcustomerdetails^"+Applicant);
    		rs = DBUtils.executeQuery(strQuery);
    		if(rs.next())
    		{
    			Applicant = Helper.correctNull((String) rs.getString("perapp_oldid"));
    		}
    		if(rs2!=null)
				  rs2.close();
			rs2 = DBUtils.executeLAPSQuery("sel_per_house_proposed_asset_check^"+strAppno);
			while(rs2.next())
			{
				arrCol.add(Helper.correctNull((String)rs2.getString("PHPA_SEC_SECURITYID")));
			}
			if(rs2!=null)
				  rs2.close();
			rs2 = DBUtils.executeLAPSQuery("sel_valuation_check^"+strAppno);
			while(rs2.next())
			{
				arrRow.add(Helper.correctNull((String)rs2.getString("SEC_SECURITYID")));
			}
			if(rs2!=null)
				  rs2.close();
			rs2 = DBUtils.executeLAPSQuery("sel_per_vehicle_check^"+strAppno);
			while(rs2.next())
			{
				arrVal.add(Helper.correctNull((String)rs2.getString("AUTO_SEC_SECID")));
			}
    		 if(rs1!=null)
				  rs1.close();
			 String Purpose_Loan="",strCat_id="",strApplicable_for="",strPrd_type="";
			strQuery = SQLParser.getSqlQuery("sel_cat_house^"+strAppno);
   		rs1 = DBUtils.executeQuery(strQuery);
   		if(rs1.next())
   		{
   			Purpose_Loan = Helper.correctNull((String) rs1.getString("PRD_PURPOSE"));
   			strCat_id = Helper.correctNull((String) rs1.getString("CAT_ID"));
   			strApplicable_for = Helper.correctNull((String) rs1.getString("PRD_APPLICABLEFOR"));
   			strPrd_type = Helper.correctNull((String) rs1.getString("PRD_TYPE"));
   		}
   	
   		//digi-module purpose of loan changes
   		/*String sessionModuleType=Helper.correctNull((String)hshValues.get("sessionModuleType"));
   		String strPremisesAge="";
   		if(sessionModuleType.equalsIgnoreCase("DIGI"))
   		{
   			if(rs1!=null)
				  rs1.close();
   			strQuery = SQLParser.getSqlQuery("selLoanAmt^"+strAppno);
   	   		rs1 = DBUtils.executeQuery(strQuery);
   	   		if(rs1.next())
   	   		{
   	   			Purpose_Loan = Helper.correctNull((String) rs1.getString("LOAN_CATLOANPURPOSE"));
   	   		}
   		}*/
   		
   		if(strPrdType.equalsIgnoreCase("pH"))
   		{
   			if(rs!=null)
   				rs.close();
   	   		rs1 = DBUtils.executeLAPSQuery("sel_housemaxsno^"+strAppno);
   	   		if(rs1.next())
   	   		{
   	   			srlnmbr=Integer.parseInt(Helper.correctInt(rs1.getString("sno")));
   	   		}
   		}
   		else if(strPrdType.equalsIgnoreCase("pA"))
   		{
   			if(rs!=null)
   				rs.close();
   	   		rs1 = DBUtils.executeLAPSQuery("sel_vehiclemaxsno^"+strAppno);
   	   		if(rs1.next())
   	   		{
   	   			srlnmbr=Integer.parseInt(Helper.correctInt(rs1.getString("sno")));
   	   		}
   		}
   		
   		if(strPrdType.equalsIgnoreCase("pH")||strPrdType.equalsIgnoreCase("pA"))
   		{
   			if(rs!=null)
   				rs.close();
   	   		rs1 = DBUtils.executeLAPSQuery("sel_valuationmaxsno^"+strAppno);
   	   		if(rs1.next())
   	   		{
   	   			snmbr=Integer.parseInt(Helper.correctInt(rs1.getString("sno")));
   	   		}
   		}
    		ArrayList arrValues = new ArrayList();
			if(strAction.equalsIgnoreCase("update"))
			{
				for (int i = 0 ; i < arrSize; i++)
				{
					hshQueryValues = new HashMap();
					int intQsize=0;
					String strFacsno=Facsno[i];
					String strFacsnoArr[]=strFacsno.split("~");
					String strFacType=FacType[i];
					String strFacTypeArr[]=strFacType.split("~");
					String strFacNature=FacNature[i];
					String strFacNatureArr[]=strFacNature.split("~");
					String strFacID=FacID[i];
					String strFacIDArr[]=strFacID.split("~");
					String strMargin=Margin[i];
					String[] strMarginArr=strMargin.split("~");
					String strtype=str_type[i];
					String strTypeArr[]=strtype.split("~");
					String strLoanamt=LoanAmt[i];
					String strLoanamtArr[]=strLoanamt.split("~");
					String strOS=OutstandAmt[i];
					String strOSArr[]=strOS.split("~");
					String strUnsec=Unsec[i];
					String strUnsecArr[]=strUnsec.split("~");
					String strType=SecType[i];
					String strsecType[]=strType.split("~");
					String strResi=ResiValue[i];
					String strResiArr[]=strResi.split("~");
					String strParentAppno=strparentappno[i];
					String strParentappnoarr[]=strParentAppno.split("~");
					String strParentSno=strparentsno[i];
					String strParentsnoarr[]=strParentSno.split("~");
					String strborrowerid=strBowID[i];
					String strborrowerArr[]=strborrowerid.split("~");
					String strSecurtype=strSecuritytype[i];
					String strSecuritytypeArr[]=strSecurtype.split("~");
					String strSecClass=hidSecClass[i];
					
					if(strSelect[i].equalsIgnoreCase("Y"))
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						arrValues.add("P");
						arrValues.add(SecID[i]);
						arrValues.add(strAppno);
						intQsize=intQsize+1;
						hshQuery.put("strQueryId","delsecuritydetails_fac");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(String.valueOf(intQsize),hshQuery);
						
						for(int k=0;k<strFacIDArr.length;k++)
						{
							if(strTypeArr[k].equalsIgnoreCase("P"))
							{
								hshQuery = new HashMap();
								arrValues = new ArrayList();
								arrValues.add(strAppno);
								arrValues.add(SecID[i]);
								arrValues.add("1");
								arrValues.add(Applicant);
								arrValues.add(SecValue[i]);
								arrValues.add(ResiValue[i]);
								arrValues.add(strFacTypeArr[k]);
								arrValues.add(strFacNatureArr[k]);
								arrValues.add(strsecType[k]);
								arrValues.add(strLoanamtArr[k]);
								arrValues.add(strOSArr[k]);
								arrValues.add(strUnsecArr[k]);
								arrValues.add(Applicant);
								arrValues.add(Helper.correctDouble(strMarginArr[k]));
								arrValues.add(strFacIDArr[k]);
								arrValues.add(strTypeArr[k]);
								arrValues.add(IsCollateral[i]);
								arrValues.add(hidSecExisting[i]);
								arrValues.add("A");
								arrValues.add("Y");
								arrValues.add("");
								arrValues.add(strborrowerArr[k]);
								arrValues.add(strSecuritytypeArr[k]);
								arrValues.add(strShareCnt[i]);
								arrValues.add("M");
								hshQuery.put("strQueryId","ins_securitydetails");
								intQsize=intQsize+1;
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put(String.valueOf(intQsize),hshQuery);	
							}
						}
						hshQueryValues.put("size",String.valueOf(intQsize));				
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						
						for(int k=0;k<strFacIDArr.length;k++)
						{
						if(strTypeArr[k].equalsIgnoreCase("P"))
						{
						 
						 if(strPrdType.trim().equalsIgnoreCase("pH") && !(Purpose_Loan.equalsIgnoreCase("F")&&Purpose_Loan.equalsIgnoreCase("T")&&Purpose_Loan.equalsIgnoreCase("HC")))
						  {
							 if(strSecClass.equals("10")||strSecClass.equals("11")||strSecClass.equals("12")||strSecClass.equals("13")||strSecClass.equals("15")||strSecClass.equals("16")||strSecClass.equals("17"))	
							 {
								 String srlno="",strmeas="",strbuildmeas="";
								 totalArea=0 ;extBuild=0;
								 int intSize=0;
								 double totalArea1=0.00 ,extBuild1=0.00;
								 if(rs!=null)
									  rs.close();
									rs = DBUtils.executeLAPSQuery("sel_proposedasset_sec^"+strAppno+"^"+SecID[i]);
									if(rs.next())
									{
										streditFlag_hou="N";
										streditFlag_val="N";
										if(arrCol.contains(SecID[i])){
											streditFlag_hou="Y";
										}
										if(arrRow.contains(SecID[i])){
											streditFlag_val="Y";
										}
										hshQueryValues=new HashMap();
										if(!streditFlag_hou.equalsIgnoreCase("Y")){
					    					hshQuery=new HashMap();
					    					arrValues=new ArrayList();   
					    					arrValues.add(strAppno);	
					    					arrValues.add(SecID[i]);	    					
					    					hshQuery.put("arrValues",arrValues);
					    					hshQuery.put("strQueryId","del_proposedasset_house_sec");
					    					hshQueryValues.put("size",String.valueOf(++intSize));
					    					hshQueryValues.put(String.valueOf(intSize),hshQuery);
										}
										if(!streditFlag_val.equalsIgnoreCase("Y")){
					    					hshQuery=new HashMap();
					    					arrValues=new ArrayList();   
					    					arrValues.add(strAppno);	
					    					arrValues.add(SecID[i]);	    					
					    					hshQuery.put("arrValues",arrValues);
					    					hshQuery.put("strQueryId","del_proposedasset_valuationEntry_sec");
					    					hshQueryValues.put("size",String.valueOf(++intSize));
					    					hshQueryValues.put(String.valueOf(intSize),hshQuery);
										}	
					    					hshQuery=new HashMap();
					    					arrValues=new ArrayList();   
					    					if(!streditFlag_hou.equalsIgnoreCase("Y")){
						    					arrValues.add(strAppno);	
						    					arrValues.add(SecID[i]);
						    					arrValues.add(String.valueOf(++srlnmbr));
						    				}    					
					    					//arrValues.add(srlno);	
					    					arrValues.add(Helper.correctNull((String)rs.getString("LOAN_TAKEOVER")));	    					
					    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_PROPERTYTYPE")));	
					    					arrValues.add(Helper.correctNull((String)rs.getString("CUS_SEC_TYPE")));	    
					    					arrValues.add(Helper.correctNull((String)rs.getString("CUS_SEC_CLASSIFICATION")));	    					
					    					arrValues.add(Helper.correctNull((String)rs.getString("CUS_SEC_NATUREOFCHARGE")));	    					
					    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_SURVEYNO")));	    					
					    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_PLOTNO")));	    					
					    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_STREETNO")));	    					
					    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_CITY")));	    					
					    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_DISTRICT")));	    					
					    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_STATE")));	    					
					    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_ZIP")));	
					    					totalArea=Double.parseDouble(Helper.correctDouble((String)rs.getString("SEC_TOTALAREA")));
					    					strmeas=Helper.correctNull((String)rs.getString("sec_measurement"));
					    					if(totalArea!=0){
					    						if(strmeas.equalsIgnoreCase("1"))
					    								totalArea1=(totalArea*43560);
					    						else if(strmeas.equalsIgnoreCase("2"))
					    								totalArea1=(totalArea*107639);
					    						else if(strmeas.equalsIgnoreCase("3"))
				    								totalArea1=totalArea;
					    						else if(strmeas.equalsIgnoreCase("4"))
				    								totalArea1=totalArea*10.76;
					    						else if(strmeas.equalsIgnoreCase("5"))
				    								totalArea1=totalArea*9;
					    						else if(strmeas.equalsIgnoreCase("6"))
				    								totalArea1=totalArea*1088.98;
					    						else if(strmeas.equalsIgnoreCase("7"))
				    								totalArea1=totalArea*435.9;
					    						else if(strmeas.equalsIgnoreCase("8"))
				    								totalArea1=totalArea*5404.89;
					    					}
					    					arrValues.add(String.valueOf(totalArea1));
					    					
					    					extBuild=Double.parseDouble(Helper.correctDouble((String)rs.getString("SEC_EXTENTOFBUILDING")));
					    					strbuildmeas=Helper.correctNull((String)rs.getString("sec_extofbuildmeas"));
					    					if(extBuild!=0){
					    						if(strbuildmeas.equalsIgnoreCase("1"))
					    								extBuild1=(extBuild*43560);
					    						else if(strbuildmeas.equalsIgnoreCase("2"))
					    								extBuild1=(extBuild*107639);
					    						else if(strbuildmeas.equalsIgnoreCase("3"))
				    								extBuild1=extBuild;
					    						else if(strbuildmeas.equalsIgnoreCase("4"))
				    								extBuild1=extBuild*10.76;
					    						else if(strbuildmeas.equalsIgnoreCase("5"))
				    								extBuild1=extBuild*9;
					    						else if(strbuildmeas.equalsIgnoreCase("6"))
				    								extBuild1=extBuild*1088.98;
					    						else if(strbuildmeas.equalsIgnoreCase("7"))
				    								extBuild1=extBuild*435.9;
					    						else if(strbuildmeas.equalsIgnoreCase("8"))
				    								extBuild1=extBuild*5404.89;
					    					}
					    					arrValues.add(String.valueOf(extBuild1));
					    					
					    					arrValues.add("N");
					    					if(!Purpose_Loan.equalsIgnoreCase("")){arrValues.add(Purpose_Loan);}
					    					else {arrValues.add("");}
					    					if(!(Purpose_Loan.equalsIgnoreCase("G")||Purpose_Loan.equalsIgnoreCase("S"))){ 
					    						arrValues.add(Helper.correctNull((String)rs.getString("SEC_SALEVALUE")));
					    					}
					    					else{
					    						arrValues.add("0.00");
					    					}
					    					arrValues.add(Helper.correctNull((String)rs.getString("sec_valuervalue")));
					    					if(strPrd_type.equalsIgnoreCase("pC") ||strPrd_type.equalsIgnoreCase("pR") )
					    						arrValues.add(Helper.correctNull((String)rs.getString("loan_metlifepremiumamt")));
					    					else
					    						arrValues.add("0.00");
					    					if(streditFlag_hou.equalsIgnoreCase("Y")){
						    					arrValues.add(strAppno);	
						    					arrValues.add(SecID[i]);
						    					}
					    					arrValues.add(Helper.correctNull((String)rs.getString("LOAN_AGEOFVEH")));
					    					hshQuery.put("arrValues",arrValues);
					    				if(!streditFlag_hou.equalsIgnoreCase("Y")){
					    					hshQuery.put("strQueryId","ins_proposedasset_house");
					    				}else{
					    					hshQuery.put("strQueryId","upd_propasset_house");
					    				}
					    				hshQueryValues.put("size",String.valueOf(++intSize));
				    					hshQueryValues.put(String.valueOf(intSize),hshQuery);
										
					    					 /*if(rs2!=null)
												  rs2.close();
					    					rs2 = DBUtils.executeLAPSQuery("Sel_MaxId_evaluate^"+strAppno);
											if(rs2.next())
											{
												srlno= Helper.correctInt((String)rs2.getString("maxid"));
											}*/
					    					hshQuery=new HashMap();
					    					arrValues=new ArrayList();   
					    					if(!streditFlag_val.equalsIgnoreCase("Y")){
						    					arrValues.add(strAppno);	
						    					arrValues.add(SecID[i]);
						    					arrValues.add(String.valueOf(++snmbr));	
						    					}	    					
					    					//arrValues.add(String.valueOf(srlno));	
					    					arrValues.add(Helper.correctNull((String)rs.getString("CUS_VALSUBMITTEDDATE")));	    					
					    					arrValues.add(Helper.correctNull((String)rs.getString("CUS_VALRECVDATE")));	    					
											arrValues.add(Helper.correctNull((String)rs.getString("CUS_SEC_VALUATION_DATE")));	    					
											arrValues.add(Helper.correctNull((String)rs.getString("CUS_SEC_VALUER_NAME")));
											arrValues.add(Helper.correctNull((String)rs.getString("SEC_SALEVALUE")));	
					    					arrValues.add("N");	
											arrValues.add(Helper.correctNull((String)rs.getString("CUS_SEC_VALUERCODE")));
											if(streditFlag_val.equalsIgnoreCase("Y")){
						    					arrValues.add(strAppno);	
						    					arrValues.add(SecID[i]);
						    					}
											hshQuery.put("arrValues",arrValues);
											if(!streditFlag_val.equalsIgnoreCase("Y")){
												hshQuery.put("strQueryId","ins_proposedasset_valuationEntry");
											}else{
												hshQuery.put("strQueryId","upd_valuationEntry_house");
											}
					    					hshQueryValues.put("size",String.valueOf(++intSize));
					    					hshQueryValues.put(String.valueOf(intSize),hshQuery);
					    					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");	
									
								  }
							 	}
						  }
						 else if(strPrdType.trim().equalsIgnoreCase("pA") ||strPrdType.trim().equalsIgnoreCase("pU") ){
							 if(strSecClass.equals("18")){

								// String srlno="";
								 int intSize=0;
								 if(rs!=null)
									  rs.close();
									rs = DBUtils.executeLAPSQuery("sel_proposedasset_sec_veh^"+strAppno+"^"+SecID[i]);
									if(rs.next())
									{
										streditFlag_veh="N";
										streditFlag_val="N";
										if(arrVal.contains(SecID[i])){
											streditFlag_veh="Y";
										}
										if(arrRow.contains(SecID[i])){
											streditFlag_val="Y";
										}
										hshQueryValues=new HashMap();
										if(!streditFlag_veh.equalsIgnoreCase("Y")){
					    					hshQuery=new HashMap();
					    					arrValues=new ArrayList();   
					    					arrValues.add(strAppno);	
					    					arrValues.add(SecID[i]);	    					
					    					hshQuery.put("arrValues",arrValues);
					    					hshQuery.put("strQueryId","del_proposedasset_vehicle_sec");
					    					hshQueryValues.put("size",String.valueOf(++intSize));
					    					hshQueryValues.put(String.valueOf(intSize),hshQuery);
										}
				    				//if(!(strPrd_type.equalsIgnoreCase("pU")&& strApplicable_for.equalsIgnoreCase("V"))){
				    					if(!streditFlag_val.equalsIgnoreCase("Y")){
					    					hshQuery=new HashMap();
					    					arrValues=new ArrayList();   
					    					arrValues.add(strAppno);	
					    					arrValues.add(SecID[i]);	    					
					    					hshQuery.put("arrValues",arrValues);
					    					hshQuery.put("strQueryId","del_proposedasset_valuationEntry_sec");
					    					hshQueryValues.put("size",String.valueOf(++intSize));
					    					hshQueryValues.put(String.valueOf(intSize),hshQuery);
				    					}
				    				//}
				    				//EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				    				
										/*rs2 = DBUtils.executeLAPSQuery("Sel_MaxId_vehicle^"+strAppno);
										if(rs2.next())
										{
											srlno= Helper.correctInt((String)rs2.getString("maxid"));
										}*/
					    					hshQuery=new HashMap();
					    					arrValues=new ArrayList();  
					    				if(!streditFlag_veh.equalsIgnoreCase("Y")){
					    					arrValues.add(strAppno);	    					
					    					arrValues.add(SecID[i]);
					    					arrValues.add(String.valueOf(++srlnmbr));	
					    				}
					    					arrValues.add(Helper.correctNull((String)rs.getString("LOAN_TAKEOVER")));	    					
					    					arrValues.add(Helper.correctNull((String)rs.getString("CUS_SEC_NATUREOFCHARGE")));
					    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_VEHICLETYPE")));	    					
					    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_COMPANY")));	    					
					    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_VEHICLECAT")));	    
					    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_MAKE")));	
					    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_MODEL")));	    					
					    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_REGNO")));	    					
					    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_HPNO")));	    					
					    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_CHASSISNO")));
					    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_DEALERNAME")));
					    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_DEALERADDRESS1")));	    					
					    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_DEALERADDRESS2")));	    					
					    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_DEALERCITY")));	    					
					    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_DEALERSTATE")));	    					
					    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_DEALERPIN")));	    					
					    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_DEALERCONT")));
					    					arrValues.add("N");	
					    					arrValues.add("A");	
					    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_PURCHASEVALUE")));
					    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_AGE")));
					    					arrValues.add(Helper.correctNull((String)rs.getString("SEC_BOOKVALUE")));
					    					if(streditFlag_veh.equalsIgnoreCase("Y")){
						    					arrValues.add(strAppno);	    					
						    					arrValues.add(SecID[i]);
						    				}
					    					hshQuery.put("arrValues",arrValues);
					    				if(!streditFlag_veh.equalsIgnoreCase("Y")){
					    					hshQuery.put("strQueryId","ins_proposedasset_vehicle");
					    				}else{
					    					hshQuery.put("strQueryId","upd_veh_prop");
					    				}
					    					hshQueryValues.put("size",String.valueOf(++intSize));
					    					hshQueryValues.put(String.valueOf(intSize),hshQuery);
					    					
					    					//if(!(strPrd_type.equalsIgnoreCase("pU")&& strApplicable_for.equalsIgnoreCase("V"))){
					    					/* if(rs2!=null)
												  rs2.close();
					    					rs2 = DBUtils.executeLAPSQuery("Sel_MaxId_evaluate^"+strAppno);
											if(rs2.next())
											{
												srlno= Helper.correctInt((String)rs2.getString("maxid"));
											}*/
					    					if(Helper.correctNull((String)rs.getString("SEC_VEHICLETYPE")).equalsIgnoreCase("2")){
					    					hshQuery=new HashMap();
					    					arrValues=new ArrayList();   
					    					if(!streditFlag_val.equalsIgnoreCase("Y")){
						    					arrValues.add(strAppno);	
						    					arrValues.add(SecID[i]);
						    					arrValues.add(String.valueOf(++snmbr));	
						    				}	    					
					    					//arrValues.add(snmbr++);	
					    					arrValues.add(Helper.correctNull((String)rs.getString("CUS_VALSUBMITTEDDATE")));	    					
											arrValues.add(Helper.correctNull((String)rs.getString("CUS_VALRECVDATE")));	    					
											arrValues.add(Helper.correctNull((String)rs.getString("CUS_SEC_VALUATION_DATE")));	    					
											arrValues.add(Helper.correctNull((String)rs.getString("CUS_SEC_VALUER_NAME")));
											arrValues.add(Helper.correctNull((String)rs.getString("cus_sec_totalsecvalue")));
											arrValues.add("Y");
					    					arrValues.add("N");	
											arrValues.add(Helper.correctNull((String)rs.getString("CUS_SEC_VALUERCODE")));
											if(streditFlag_val.equalsIgnoreCase("Y")){
						    					arrValues.add(strAppno);	
						    					arrValues.add(SecID[i]);
						    					}
											hshQuery.put("arrValues",arrValues);
											if(!streditFlag_val.equalsIgnoreCase("Y")){
						    					hshQuery.put("strQueryId","ins_proposedasset_valuationEntry_veh");
						    				}else{
						    					hshQuery.put("strQueryId","upd_valuationEntry_veh");
						    				}
					    					hshQueryValues.put("size",String.valueOf(++intSize));
					    					hshQueryValues.put(String.valueOf(intSize),hshQuery);
					    					}
					    					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");	
									}
							 	
							 }
						 }
						 
						}
						}
						 
					}
					else if(strSelect[i].equalsIgnoreCase("N"))
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						arrValues.add("P");
						arrValues.add(SecID[i]);
						arrValues.add(strAppno);
						intQsize=intQsize+1;
						hshQuery.put("strQueryId","delsecuritydetails_fac");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(String.valueOf(intQsize),hshQuery);
						
						arrValues = new ArrayList();
						hshQuery = new HashMap();					
						hshQuery.put("strQueryId","del_sec_MDTDcomments");
						arrValues.add(strAppno);
						arrValues.add(SecID[i]);
						intQsize=intQsize+1;
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(String.valueOf(intQsize),hshQuery);
						
						hshQuery=new HashMap();
    					arrValues=new ArrayList();   
    					arrValues.add(strAppno);	
    					arrValues.add(SecID[i]);	    					
    					hshQuery.put("arrValues",arrValues);
    					hshQuery.put("strQueryId","del_proposedasset_house_sec");
						intQsize=intQsize+1;
						hshQueryValues.put(String.valueOf(intQsize),hshQuery);
					 
    					hshQuery=new HashMap();
    					arrValues=new ArrayList();   
    					arrValues.add(strAppno);	
    					arrValues.add(SecID[i]);	    					
    					hshQuery.put("arrValues",arrValues);
    					hshQuery.put("strQueryId","del_proposedasset_vehicle_sec");
						intQsize=intQsize+1;
						hshQueryValues.put(String.valueOf(intQsize),hshQuery);
						
    					hshQuery=new HashMap();
    					arrValues=new ArrayList();   
    					arrValues.add(strAppno);	
    					arrValues.add(SecID[i]);	    					
    					hshQuery.put("arrValues",arrValues);
    					hshQuery.put("strQueryId","del_proposedasset_valuationEntry_sec");
    					intQsize=intQsize+1;
						hshQueryValues.put(String.valueOf(intQsize),hshQuery);
    					
						hshQueryValues.put("size",String.valueOf(intQsize));				
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
				}
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_securitydetails");
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				arrValues=new ArrayList();
				hshQuery = new HashMap();					
				hshQuery.put("strQueryId","del_sec_MDTDcomments_all");
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);
				hshQueryValues.put("size","2");
				
				arrValues=new ArrayList();
				hshQuery = new HashMap();					
				hshQuery.put("strQueryId","dellopverif");
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("3",hshQuery);
				hshQueryValues.put("size","3");
				
			if(strPrdType.trim().equalsIgnoreCase("pH"))
			 {
				arrValues=new ArrayList();
				hshQuery = new HashMap();					
				arrValues.add(strAppno);
				hshQuery.put("strQueryId","del_proposedasset_house_all");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("4",hshQuery);
				hshQueryValues.put("size","4");
			 }else{
				 arrValues=new ArrayList();
					hshQuery = new HashMap();					
					arrValues.add(strAppno);
					hshQuery.put("strQueryId","del_proposedasset_vehicle_all");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("4",hshQuery);
					hshQueryValues.put("size","4");
			 }
			if(strPrdType.trim().equalsIgnoreCase("pH") || strPrdType.trim().equalsIgnoreCase("pA") )
			 {
				arrValues=new ArrayList();
				hshQuery = new HashMap();					
				arrValues.add(strAppno);
				hshQuery.put("strQueryId","del_proposedasset_valuation_all");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("5",hshQuery);
				hshQueryValues.put("size","5");
			 }
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(!Helper.correctNull((String)hshValues.get("strAppType")).equalsIgnoreCase("P"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId", "setcbsdetailsdel");
				arrValues.add(strAppno);
				arrValues.add("1");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				
				if(strPrdType.equalsIgnoreCase("pV"))
				{
					String strAmtsum="";
					strQuery = SQLParser.getSqlQuery("sel_residentialpropertysum1^11','12','5','7^"+ strAppno);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						
						strAmtsum=Helper.correctDouble(rs.getString("secvalue"));
					}
					
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","2");
					hshQuery.put("strQueryId", "upd_costofloan_loandetails_pI");
					arrValues.add(strAmtsum);
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("2", hshQuery);
				}
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			hshQueryValues=new HashMap();
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQueryValues.put("size","1");
			hshQuery.put("strQueryId", "upd_sec_desc_pending");
			arrValues.add(strAppno);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		
			if(rs!=null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("legal_opinion_verificationforExist^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshQueryValueslov = new HashMap();
				hshQuerylov = new HashMap();
				arrVallov=new ArrayList();
				hshQueryValueslov.put("size","1");
				hshQuerylov.put("strQueryId","dellopverifforExist");
				arrVallov.add(strAppno);
				arrVallov.add(Helper.correctNull((String)rs.getString("SEC_ID")));
				hshQuerylov.put("arrValues",arrVallov);
				hshQueryValueslov.put("1",hshQuerylov);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValueslov,"updateData");
			}
		
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in updateSecurityRetailDetails : "+ce.toString());
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
			catch(Exception ce)
			{
				throw new EJBException("Error in Connection : "+ce.toString());
			}
		}
    }
    
    public HashMap getAttachedRetailSecurityDetails(HashMap hshValues) 
    {
    	HashMap hshResult=new HashMap();
    	ResultSet rs=null;
    	ResultSet rs1=null;
    	ResultSet rs2=null;
    	ResultSet rs3=null;
    	ResultSet rs4=null;
    	ResultSet rs5=null;
    	String strQuery="",strQuery1="",strQuery2="",strQuery3="";
    	String strAppno="",newLapsId="",oldLapsId="",strappId="",strattachavail="N";
    	String strName="",str_facsno="";
    	ArrayList arrCol=new ArrayList();
    	ArrayList arrRow=new ArrayList();
    	ArrayList arrFacCol=new ArrayList();
    	ArrayList arrFacRow=new ArrayList();
    	ArrayList arrMainRow=new ArrayList();
    	String strSecid="",strPrioirycheck="",strFac="",strProductno="",strFacCode="",strcolSec="";
    	int i=0,j=0,Prioitycount=0,totalcount=0;
    	java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
    	try
    	{
    		strappId = Helper.correctNull((String)hshValues.get("hidapplicantnewid"));
    		strQuery = SQLParser.getSqlQuery("selcustomerdetails^"+strappId);
    		rs = DBUtils.executeQuery(strQuery);
    		if(rs.next())
    		{
    			strappId = Helper.correctNull((String) rs.getString("perapp_oldid"));
    		}
    		strAppno=Helper.correctNull((String)hshValues.get("appno"));
    		if(rs !=null){
    			rs.close();
    		}
    		strQuery2 = SQLParser.getSqlQuery("sel_securityvalues_primary^APP_SEC_FACSNO^"+strAppno+"^P");
    		rs2 = DBUtils.executeQuery(strQuery2);
    		while(rs2.next())
    		{
    			int k=1;
    			i++;j++;
    			arrRow = new ArrayList();
    			strProductno=Helper.correctNull((String)rs2.getString("APP_SEC_FACSNO"));
    			strQuery1 = SQLParser.getSqlQuery("sel_prdDesc^"+strAppno);
					rs1 = DBUtils.executeQuery(strQuery1);
					if(rs1.next())
					{
						arrFacCol = new ArrayList();
						arrFacCol.add(Helper.correctNull((String)rs1.getString("prd_desc")));//0
						strFac=Helper.correctNull((String)rs1.getString("prd_desc"));
						strFacCode=Helper.correctNull((String)rs1.getString("prd_code"));
					}
				arrCol = new ArrayList();
				
				strQuery = SQLParser.getSqlQuery("select_securityid_primary^" + strAppno+"^APP_SEC_FACSNO ='"+Helper.correctNull((String) rs2.getString("APP_SEC_FACSNO"))+"'"+"^P");
				rs3 = DBUtils.executeQuery(strQuery);
				if(rs3.next())
				{
					if(Helper.correctNull((String) rs3.getString("APP_SEC_SECURITYTYPE")).equalsIgnoreCase("2"))
					{
					arrFacCol.add("Collateral");
					strattachavail="Y";
					if(!str_facsno.equalsIgnoreCase(Helper.correctNull((String) rs2.getString("APP_SEC_FACSNO"))))
					{
						arrRow.add(arrFacCol);
						str_facsno=Helper.correctNull((String) rs2.getString("APP_SEC_FACSNO"));
					}
					}
					else
					{arrFacCol.add("Primary");
						arrRow.add(arrFacCol);	
					}
				}
				else
				{
					arrRow.add(arrFacCol);	
				}
    			
    			
    			strQuery = SQLParser.getSqlQuery("select_securityid_primary^" + strAppno+"^APP_SEC_FACSNO ='"+Helper.correctNull((String) rs2.getString("APP_SEC_FACSNO"))+"'"+"^P");
				rs3 = DBUtils.executeQuery(strQuery);
				while(rs3.next())
				{	
					totalcount++;
					arrCol= new ArrayList();
					strSecid=Helper.correctNull((String)rs3.getString("app_sec_secid"));
					arrCol.add(Helper.correctNull((String)rs3.getString("app_sec_secid")));//0
					if(!Helper.correctNull((String)rs3.getString("app_sec_margin")).equalsIgnoreCase("")){
					arrCol.add(Helper.correctNull((String)rs3.getString("app_sec_margin")));//1
					}else{
						arrCol.add("0.00");	
					}
					
					strQuery = SQLParser.getSqlQuery("select_security_calssification^" + Helper.correctInt((String)rs3.getString("app_sec_secid")));
					rs4 = DBUtils.executeQuery(strQuery);
					if(rs4.next())
					{
						arrCol.add(Helper.correctNull((String)rs4.getString("SEC_NAME")));//2
						arrCol.add(Helper.correctNull((String)rs4.getString("SEC_CLASSIFICATION")));//3
					}else{
						arrCol.add("");//2
						arrCol.add("");//3
					}
					arrCol.add(Helper.correctNull((String) rs2.getString("APP_SEC_FACSNO")));
					if(!Helper.correctNull((String) rs3.getString("app_sec_priority")).equalsIgnoreCase("") && !Helper.correctNull((String) rs3.getString("app_sec_priority")).equalsIgnoreCase("null"))
					{
						if(!(Helper.correctNull((String) rs3.getString("app_sec_priority")).equalsIgnoreCase("0")))
						{
							Prioitycount++;
							if(strPrioirycheck.equalsIgnoreCase(""))
							{
								strPrioirycheck=strFacCode+"@"+Helper.correctNull((String) rs3.getString("app_sec_priority"));	
							}else
							{
								strPrioirycheck=strPrioirycheck+"-"+strFacCode+"@"+Helper.correctNull((String) rs3.getString("app_sec_priority"));
							}
						}
						arrCol.add(Helper.correctNull((String) rs3.getString("app_sec_priority")));
					}else{
						arrCol.add("0");
					}
					arrCol.add(strFac);
					arrCol.add(Helper.correctNull((String)rs3.getString("APP_SEC_SECURITYTYPE")));
					// for removal of collateral sec when CGTMSE is NO
					if(Helper.correctNull((String)rs3.getString("APP_SEC_SECURITYTYPE")).equalsIgnoreCase("2"))
					{
						strcolSec+=","+strSecid;
					}
					arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs3.getString("APP_SEC_SECURITYVALUE")))));
					
					if(rs5 !=null)
		    			rs5.close();
					//current security value
					strQuery = SQLParser.getSqlQuery("select_sec_totalsecValue^" + Helper.correctInt((String)rs3.getString("app_sec_secid")));
					rs5 = DBUtils.executeQuery(strQuery);
					if(rs5.next())
					{
						String CUS_RELEASEFLAG= Helper.correctNull((String)rs5.getString("CUS_RELEASEFLAG"));
						if(CUS_RELEASEFLAG.equals("V"))
						{
							if(rs4 !=null)
				    			rs4.close();
							strQuery = SQLParser.getSqlQuery("sel_secVerMailbox_secval^" + Helper.correctInt((String)rs3.getString("app_sec_secid")));
							rs4 = DBUtils.executeQuery(strQuery);
							if(rs4.next())
							{
								if(Helper.correctNull((String)rs4.getString("SEC_SECURITYVALUE_OLD")).equalsIgnoreCase(""))
									arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs5.getString("CUS_SEC_NETSECURITY")))));
								else
									arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs4.getString("SEC_SECURITYVALUE_OLD")))));
							}
						}
						else
						{
							arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs5.getString("CUS_SEC_NETSECURITY")))));
						}
					}
					else
						arrCol.add("0.00");
					
					arrRow.add(arrCol);
				}					
				
				hshResult.put("arrRow1"+j,arrRow);
    		}
    		hshResult.put("strcolSec",strcolSec.replaceFirst(",", ""));
    		hshResult.put("str_CGTMSEFlag",Helper.correctNull((String) hshValues.get("PRD_CGTMSE")));
    		//for parent appno
    		hshResult.put("count1",""+j);
    		if(rs2 !=null){
    			rs2.close();
    		}
    		String appno="";j=0;
    		String strSecurityType = "",strParentFacSno="0",strProductcode="",strModtype="",strSecurityCustomerId="",strParentappno="";
    		String strProductCodeSno[]=new String[2];
    		strQuery2 = SQLParser.getSqlQuery("selparentappnoapp_sec^"+strAppno);
    		rs = DBUtils.executeQuery(strQuery2);
    		while(rs.next())
    		{
    			appno=Helper.correctNull((String)rs.getString(1));
    			if(!appno.equalsIgnoreCase("")){
    		strQuery2 = SQLParser.getSqlQuery("sel_securityvalues_Exis^APP_SEC_FACSNO^"+strAppno+"^"+appno+"^E");
    		rs2 = DBUtils.executeQuery(strQuery2);
    		while(rs2.next())
    		{
    			int k=1;
    			i++;j++;
    			arrRow = new ArrayList();
    			strProductno=Helper.correctNull((String)rs2.getString(1));
			
				strQuery = SQLParser.getSqlQuery("select_securityid_Exis^" + strAppno+"^App_sec_parentappno='"+appno+"'"+"^APP_SEC_PArent_FACSNO ='"+strProductno+"'"+"^E");
				rs3 = DBUtils.executeQuery(strQuery);
				while(rs3.next())
				{
					strParentFacSno="0";
					totalcount++;
					arrCol = new ArrayList();
					strSecurityType=Helper.correctNull((String)rs3.getString("app_sec_securitytype"));
					if(strSecurityType.equalsIgnoreCase("1"))
					{
						strSecurityType="Primary";
					}
					else
					{
						strSecurityType="";
					}
					strSecid=Helper.correctNull((String)rs3.getString("app_sec_secid"));
					arrCol.add(Helper.correctNull((String)rs3.getString("app_sec_secid")));//0
					if(!Helper.correctNull((String)rs3.getString("app_sec_margin")).equalsIgnoreCase("")){
					arrCol.add(Helper.correctNull((String)rs3.getString("app_sec_margin")));//1
					}else{
						arrCol.add("0.00");	
					}
					
					strQuery = SQLParser.getSqlQuery("select_security_calssification^" + Helper.correctInt((String)rs3.getString("app_sec_secid")));
					rs4 = DBUtils.executeQuery(strQuery);
					if(rs4.next())
					{
						arrCol.add(Helper.correctNull((String)rs4.getString("SEC_NAME")));//2
						arrCol.add(Helper.correctNull((String)rs4.getString("SEC_CLASSIFICATION")));//3
					}else{
						arrCol.add("");//2
						arrCol.add("");//3
					}
					arrCol.add(Helper.correctNull((String) rs2.getString("APP_SEC_FACSNO")));
					if(!Helper.correctNull((String) rs3.getString("app_sec_priority")).equalsIgnoreCase("") && !Helper.correctNull((String) rs3.getString("app_sec_priority")).equalsIgnoreCase("null"))
					{
						if(!(Helper.correctNull((String) rs3.getString("app_sec_priority")).equalsIgnoreCase("0")))
						{
							Prioitycount++;
							if(strPrioirycheck.equalsIgnoreCase(""))
							{
								strPrioirycheck=strFacCode+"@"+Helper.correctNull((String) rs3.getString("app_sec_priority"));	
							}else
							{
								strPrioirycheck=strPrioirycheck+"-"+strFacCode+"@"+Helper.correctNull((String) rs3.getString("app_sec_priority"));
							}
						}
						arrCol.add(Helper.correctNull((String) rs3.getString("app_sec_priority")));
					}else{
						arrCol.add("0");
					}
					
					if(strParentFacSno.equalsIgnoreCase("0"))
					{
						strSecurityCustomerId=Helper.correctNull((String)rs3.getString("App_Sec_Borrower_Id"));
						strParentFacSno=Helper.correctNull((String)rs3.getString("app_sec_parent_facsno"));
						strParentappno=Helper.correctNull((String)rs3.getString("app_sec_parentappno"));
						strFac="";strProductcode="0";strModtype="";			
						if(strappId.equalsIgnoreCase(strSecurityCustomerId))
						{
							strQuery = SQLParser.getSqlQuery("sel_bankingfaccode^"+strAppno+"^"+strParentFacSno+"^"+strParentappno);
							rs4 = DBUtils.executeQuery(strQuery);
							if(rs4.next())
							{
								strProductcode=Helper.correctNull((String)rs4.getString("combk_facility"));
								strModtype=Helper.correctNull((String)rs4.getString("combk_modtype"));
								strProductCodeSno=strProductcode.split("~");
								strProductcode=strProductCodeSno[0];
							}
						}
						else
						{
							strQuery = SQLParser.getSqlQuery("sel_groupfaccode^"+strAppno+"^"+strParentFacSno+"^"+strParentappno);		
							rs4 = DBUtils.executeQuery(strQuery);
							if(rs4.next())
							{
								strProductcode=Helper.correctNull((String)rs4.getString("comgc_facility"));
								strModtype=Helper.correctNull((String)rs4.getString("comgc_modtype"));
							}
						}
						if(rs4 !=null)
						{
							rs4.close();
						}
						
						if(strModtype.equalsIgnoreCase("a") || strModtype.equalsIgnoreCase("c"))
						{
							strQuery = SQLParser.getSqlQuery("selectFacilityHeadFacandSubFac_facilitycorp^" + strProductcode);
							rs4 = DBUtils.executeQuery(strQuery);
							if(rs4.next())
							{
								strFac=Helper.correctNull((String)rs4.getString("com_facdesc"));
							}
						}
						else
						{
							strQuery=SQLParser.getSqlQuery("sel_retProductDesc^"+strProductcode);
    						rs4 = DBUtils.executeQuery(strQuery);
    						if(rs4.next())
    						{
    							strFac=Helper.correctNull(rs4.getString("com_facdesc"));
    						}
						}
						if(rs4 !=null)
						{
							rs4.close();
						}
						
						
					}
					
					arrCol.add(strFac);
					arrCol.add(strSecurityType);//0

					arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs3.getString("APP_SEC_SECURITYVALUE")))));
										
					//current security value
					strQuery = SQLParser.getSqlQuery("select_sec_totalsecValue^" + Helper.correctInt((String)rs3.getString("app_sec_secid")));
					rs5 = DBUtils.executeQuery(strQuery);
					if(rs5.next())
					{
						String CUS_RELEASEFLAG= Helper.correctNull((String)rs5.getString("CUS_RELEASEFLAG"));
						if(CUS_RELEASEFLAG.equals("V"))
						{
							if(rs4 !=null)
				    			rs4.close();
							strQuery = SQLParser.getSqlQuery("sel_secVerMailbox_secval^" + Helper.correctInt((String)rs3.getString("app_sec_secid")));
							rs4 = DBUtils.executeQuery(strQuery);
							if(rs4.next())
							{
								if(Helper.correctNull((String)rs4.getString("SEC_SECURITYVALUE_OLD")).equalsIgnoreCase(""))
									arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs5.getString("CUS_SEC_NETSECURITY")))));
								else
									arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs4.getString("SEC_SECURITYVALUE_OLD")))));
							}
						}
						else
						{
							arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs5.getString("CUS_SEC_NETSECURITY")))));
						}
					}
					else
						arrCol.add("0.00");
										
					arrRow.add(arrCol);
				}					
				
				hshResult.put("arrRow2"+j,arrRow);
    		}
    		}
    		}
    		//selparentappnoapp_sec
    		
    		//for checking freeze count
    		int strFreezecount=0;
    		String strFreezeflag="N",strPrioityflag="N";
    		strQuery = SQLParser.getSqlQuery("sel_freezecount^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{	
				strFreezecount=Integer.parseInt(Helper.correctInt((String)rs.getString("freezecount")));
				if(strFreezecount!=0 )
				{
					strFreezeflag="Y";
				}
			}
			if( Helper.correctNull((String)hshValues.get("hidAction")).equalsIgnoreCase("undo"))
			{
				strFreezeflag="N";
			}
			
			int strTotcount=0;
			strQuery = SQLParser.getSqlQuery("sel_attachedsecuritycount^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{	
				strTotcount=Integer.parseInt(Helper.correctInt((String)rs.getString("totalcount")));
			}
			
    		hshResult.put("count2",""+j);
    		hshResult.put("strFreezeflag",strFreezeflag);
    		hshResult.put("strPrioirycheck",strPrioirycheck);
    		hshResult.put("strPrioityflag",strPrioityflag);
    		hshResult.put("arrFacRow",arrFacRow);
    		hshResult.put("strAppno",strAppno);
    		hshResult.put("strTotcount",""+strTotcount);
    		
    		if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("sel_applications_freeze_flag^"+strAppno);
    		rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshResult.put("strCoAppFreezeflag",Helper.correctNull((String)rs.getString("app_freeze_flag")));
			}
			
			double dblprjcost=0.00,dblsecvalue=0.00;
			if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("sel_attachedsec_sum^"+strAppno);
    		rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				dblsecvalue=Double.parseDouble(Helper.correctDouble(rs.getString("secamt")));
			}
			if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("sel_costofloan_loandetails_pI^"+strAppno);
    		rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				dblprjcost=Double.parseDouble(Helper.correctDouble(rs.getString("loan_costloanprd")));
			}
			if(dblsecvalue<dblprjcost)
			{
				hshResult.put("strSecChkforpI","Y");
			}
			
			if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("select_securityvalue^"+ strAppno+"^2");
    		rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				dblsecvalue=Double.parseDouble(Helper.correctDouble(rs.getString("secvalue")));
			}
			if(dblsecvalue<dblprjcost)
			{
				hshResult.put("strSecFlag","Y");
			}
			
			if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("findapptype^"+ strAppno);
    		rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshResult.put("strPrdpurpose",Helper.correctDouble(rs.getString("prd_purpose")));
				hshResult.put("prd_applicablefor", Helper.correctNull((String)rs.getString("PRD_APPLICABLEFOR")));
			}
			//for proposed assets check 
			if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("sel_editApply_valuation^"+ strAppno);
    		rs = DBUtils.executeQuery(strQuery);
			while(rs.next()) 
			{
				if(Helper.correctNull((String)rs.getString("EDIT_APPLY_FLAG")).equalsIgnoreCase("N")){
					hshResult.put("valuationFlag","N");
				}
			}
    			
			if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("sel_editApply_house^"+ strAppno);
    		rs = DBUtils.executeQuery(strQuery);
			while(rs.next()) 
			{
				if(Helper.correctNull((String)rs.getString("PHPA_EDIT_APPLYFLAG")).equalsIgnoreCase("N")){
					hshResult.put("HouseEdit_Flag","N");
				}
			}
			
			if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("sel_editApply_vehicle^"+ strAppno);
    		rs = DBUtils.executeQuery(strQuery);
			while(rs.next()) 
			{
				if(Helper.correctNull((String)rs.getString("AUTO_EDIT_APPLYFLAG")).equalsIgnoreCase("N")){
					hshResult.put("VehicleEdit_Flag","N");
				}
			}
			
			
			String strBorrID="",strID="";
			if(rs!=null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("sel_unknownsec_retail^"+strAppno);
			while (rs.next()) 
			{
				{
					if(!strID.contains(Helper.correctNull(rs.getString("cbsid"))))
					{
						if(strBorrID.equalsIgnoreCase(""))
						{
							strID=Helper.correctNull(rs.getString("cbsid"));
							strBorrID=Helper.correctNull(rs.getString("cbsid"))+" - "+Helper.correctNull(rs.getString("name"));
						}
						else
						{
							strID+=","+Helper.correctNull(rs.getString("cbsid"));
							strBorrID+=","+Helper.correctNull(rs.getString("cbsid"))+" - "+Helper.correctNull(rs.getString("name"));
						}
					}
				}
			}
			
			hshResult.put("strBorrID",strBorrID);
			
			String strReleasedSec="",strSecVerification="",strSecValuation="";
			if(rs!=null)
				rs.close();
			strQuery=SQLParser.getSqlQuery("sel_releasedsec^"+strAppno+"^Y");
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) 
			{
				if(strReleasedSec.equalsIgnoreCase(""))
					strReleasedSec=Helper.correctNull(rs.getString("cus_sec_id"));
				else
					strReleasedSec+=","+Helper.correctNull(rs.getString("cus_sec_id"));
			}
			if(rs!=null)
				rs.close();
			strQuery=SQLParser.getSqlQuery("sel_releasedsec^"+strAppno+"^W");
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) 
			{
				if(strSecVerification.equalsIgnoreCase(""))
					strSecVerification=Helper.correctNull(rs.getString("cus_sec_id"));
				else
					strSecVerification+=","+Helper.correctNull(rs.getString("cus_sec_id"));
			}
			if(rs!=null)
				rs.close();
			strQuery=SQLParser.getSqlQuery("sel_releasedsec^"+strAppno+"^V");
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) 
			{
				if(strSecValuation.equalsIgnoreCase(""))
					strSecValuation=Helper.correctNull(rs.getString("cus_sec_id"));
				else
					strSecValuation+=","+Helper.correctNull(rs.getString("cus_sec_id"));
			}
			if(rs!=null)
				rs.close();
			hshResult.put("strSecValuation",strSecValuation);
			hshResult.put("strSecVerification",strSecVerification);
			hshResult.put("strReleasedSec",strReleasedSec);
			
			String strcgtmseavail="N";
			strQuery1=SQLParser.getSqlQuery("getlreq^"+strAppno);
			rs = DBUtils.executeQuery(strQuery1);
			while(rs.next())
			{
				if(Helper.correctNull(rs.getString("LOAN_CGTMSE_APPLICABLE")).equalsIgnoreCase("Y") && strattachavail.equalsIgnoreCase("Y"))
				{
					strcgtmseavail="Y";
					break;
				}
			}
			if(rs!=null)
				rs.close();
			hshResult.put("strcgtmseavail",strcgtmseavail);
    	}
    	catch(Exception e)
		{
			throw new EJBException("Error in getAttachedSecurityDetails "+e.toString());
		} 
    	finally{
    		try{
    			if(rs !=null){
    				rs.close();
    			}
    			if(rs1 !=null){
        			rs1.close();
        		}
    			
    			if(rs2 !=null){
        			rs2.close();
        		}
    			if(rs3 !=null){
        			rs3.close();
        		}
    			if(rs4 !=null){
        			rs4.close();
        		}
    			
    		}catch (Exception e){
    			throw new EJBException("Error in getAttachedSecurityDetails "+e.toString());
    		}
    	}
    	return hshResult;
    }
    
  /** Modified by Dinesh on 17/02/2014 for Attached Security Values Details ***/
    
    public void updateAttachedRetailSecurityDetails(HashMap hshValues) 
    {
    	ResultSet rs = null,rs1=null;
    	String strQuery=null;
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshRecord=new HashMap();
		ArrayList arrValues = new ArrayList();
		String hidSecurityId=Helper.correctNull((String)hshValues.get("hidSecurityId"));	
		
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		int arrSize=Integer.parseInt(Helper.correctInt((String)hshValues.get("hidsize_priority")));
		try
		{
			String[] SecID = new String [arrSize];
			String[] Facsno = new String [arrSize];		
			String[] strPriority=new String [arrSize];		
			String strAction = correctNull((String)hshValues.get("hidAction"));
			String Applicant = correctNull((String)hshValues.get("hid_applicant"));			
			int intLen=0,intQsize=0;
			if(arrSize>1)
			{
				strPriority = (String[])hshValues.get("sel_priority");
				SecID = (String[]) hshValues.get("hidSecID");					
				Facsno = (String[]) hshValues.get("hidFacSno");		
			}
			else if(arrSize==1)
			{
			strPriority [0]= (String)hshValues.get("sel_priority");
			SecID [0]= (String) hshValues.get("hidSecID");					
			Facsno[0] = (String) hshValues.get("hidFacSno");		
			}
			if(strAction.equalsIgnoreCase("update"))
			{					
					for(int k=0;k<strPriority.length;k++)
					{
						
						hshQuery = new HashMap();
						arrValues = new ArrayList();					
						arrValues.add(strPriority[k]);
						arrValues.add(strAppno);
						arrValues.add(SecID[k]);
						arrValues.add(Facsno[k]);	
						intQsize=intQsize+1;
						hshQuery.put("strQueryId","update_securitydetails");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(String.valueOf(intQsize),hshQuery);		
					}
			
					hshQueryValues.put("size",String.valueOf(intQsize));				
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
			else if(strAction.equalsIgnoreCase("undo"))
			{
				hshQuery = new HashMap();
				arrValues = new ArrayList();					
				arrValues.add("");
				arrValues.add("");
				arrValues.add(strAppno);
				intQsize=intQsize+1;
				hshQuery.put("strQueryId","upd_priorityundo");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(String.valueOf(intQsize),hshQuery);	
				hshQueryValues.put("size",String.valueOf(intQsize));
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in updateAttachedRetailSecurityDetails "+ce.toString());
		}
    }
    
    
    public HashMap getattachRetailSecurity(HashMap hshValues) 
    {
    	java.text.NumberFormat jtn= java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);		
		
    	String strQuery="",strSno="",strAppno="",strFacCode="";
		ResultSet rs = null,rs1 = null,rs2 = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();
		ArrayList vecVal=null;
		ArrayList arrFacID = new ArrayList();
		ArrayList arrColFacID = new ArrayList();
		String hidposition= correctNull((String)hshValues.get("hidposition"));
		String hidFacID= correctNull((String)hshValues.get("hidFacIDlist"));
		double dblExist=0.00,dblProposed=0.00,dblMargin=0.00;
		String selSecType=Helper.correctNull((String)hshValues.get("secType"));
		String secID= Helper.correctNull((String)hshValues.get("hidSecID"));
		String strbowid=Helper.correctNull((String)hshValues.get("applicantid"));
		String secclassification=Helper.correctNull((String)hshValues.get("secclassifi"));
		String strLimit="",strOutstand="",strMargin="",strApplicantid="";
		ArrayList arrSubGrp = new ArrayList();
		String strborrowerid[]=null;
    	try
    	{
    			int	intGroup =0;
    			strAppno=Helper.correctNull((String)hshValues.get("appno"));
    			int lngGrpSize = 0;
    			
    			strborrowerid=strbowid.split("~");
				strQuery = SQLParser.getSqlQuery("sel_applicantiddemo_retail^"+strAppno);
				rs1 = DBUtils.executeQuery(strQuery);
	    		if(rs1.next())
				{
	    			strApplicantid=Helper.correctNull((String)rs1.getString("demo_oldappid"));
				}
	    		if(rs1 != null)
				{
					rs1.close();
				}
	    				
	    		strQuery = SQLParser.getSqlQuery("sel_loandetails^"+strAppno);
				rs1 = DBUtils.executeQuery(strQuery);
	    		if(rs1.next())
				{
	    			hshRecord.put("strPrd_cgstatus",Helper.correctNull((String)rs1.getString("LOAN_CGTMSE_APPLICABLE")));
				}
	    		if(rs1 != null)
				{
					rs1.close();
				}
	    		
	    		String strProdPurpose="",strProdType="",srtParentfacsno="",strVehicleType="",strPrdLoantype="";
				strQuery = SQLParser.getSqlQuery("selprodpurpose^" + strAppno);
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next()){
					strProdPurpose=Helper.correctNull((String)rs1.getString("prd_purpose"));
					strProdType=Helper.correctNull((String)rs1.getString("prd_type"));
					strVehicleType=Helper.correctNull(rs1.getString("prd_vehitype"));
					strPrdLoantype=Helper.correctNull(rs1.getString("prd_loantype"));
					}
				
	    		
				strQuery = SQLParser.getSqlQuery("sel_productcode_banking^" + strAppno);
				rs1 = DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{
					vecVal = new ArrayList();
					if(strProdPurpose.equalsIgnoreCase("H") || strProdPurpose.equalsIgnoreCase("U")||strVehicleType.equalsIgnoreCase("2")) 
					{
						strQuery = SQLParser.getSqlQuery("pergetloanProductbymargin^" + strAppno);
					}
					else
					{
						if(strProdType.equalsIgnoreCase("pI"))
						{
							strQuery = SQLParser.getSqlQuery("pergetloanProductInstaCash^" + strAppno);	
						}
						else
						{
							strQuery = SQLParser.getSqlQuery("pergetloanProduct^" + strAppno);
						}						
					}
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strFacCode=rs.getString("category")+" "+rs.getString("subcategory");
					}
					vecVal.add(strFacCode);//0
					dblProposed =rs1.getDouble("loan_recmdamt");
					strOutstand = jtn.format(dblProposed);
					strSno =correctNull(rs1.getString("app_prdcode"));
					vecVal.add(strOutstand);//1
					strMargin="0.00";
					vecVal.add(strMargin);//2
					vecVal.add(strSno);//3
					strQuery = SQLParser.getSqlQuery("pergetloanProducttypecode^" + strAppno);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						vecVal.add(correctNull((String)rs1.getString("app_prdcode"))); //4
					}
					else
					{
						vecVal.add("");//4
					}
					vecVal.add("F");//5
					vecVal.add(strPrdLoantype);//6
					vecVal.add(Helper.correctNull(rs1.getString("loan_recmdamt")));//7 For Proposed Facility - Limit & OS amount are same
					vecVal.add("P");//8
					vecVal.add("");//9
					vecVal.add("");//10
					vecVal.add("");//11
					vecVal.add(strApplicantid);//12
					
					//To select the post sanction parameters
					String strQueryPS = SQLParser.getSqlQuery("sel_PS_oldaccnum^"+strAppno+"^ ");
					ResultSet rsPS = DBUtils.executeQuery(strQueryPS);
					if(rsPS.next())
					{
						vecVal.add("@"+Helper.correctNull(rsPS.getString("PS_MODIFY_TERMS")));//13
					}
					else
					{
						vecVal.add("");//13
					}
					
					if(secclassification.equalsIgnoreCase("40"))
					{
						boolean bflag=false;
						if(rs2 !=null)
						{rs2.close();}
						strQuery = SQLParser.getSqlQuery("chk_attachedtoproposal^"+secID);
						rs2 = DBUtils.executeQuery(strQuery);
						while(rs2.next())
						{
							if(!(Helper.correctNull(rs2.getString("app_sec_appno")).equalsIgnoreCase(strAppno) && Helper.correctNull(rs2.getString("app_sec_facsno")).equalsIgnoreCase("1")))
							{
								if((!Helper.correctNull(rs2.getString("status")).equalsIgnoreCase("ca")&&(Helper.correctNull(rs2.getString("loantype")).equalsIgnoreCase("pS")||Helper.correctNull(rs2.getString("loantype")).equalsIgnoreCase("Y")))||(strProdType.equalsIgnoreCase("pS")))
									bflag=true;
							}
						}
						if(bflag)
							vecVal.add("Y");//14
						else
							vecVal.add("N");//14
						
						if(rs2 !=null)
						{rs2.close();}
						strQuery = SQLParser.getSqlQuery("chk_approvedsharedet^"+secID);
						rs2 = DBUtils.executeQuery(strQuery);
						if(rs2.next())
						{
							if(Helper.correctNull(rs2.getString("svm_companyapproveflag")).equalsIgnoreCase("U")||Helper.correctNull(rs2.getString("svm_companyactiveflag")).equalsIgnoreCase("n"))
								vecVal.add("N");
							else
								vecVal.add("");
						}
						else
							vecVal.add("");//15
						
					}
					else
					{
						vecVal.add("N");//14
						vecVal.add("");//15
					}
					vecData.add(vecVal);			
					hshRecord.put("Proposed","Y");
				}
	    	
    		if(rs1 != null)
			{
				rs1.close();
			}
    		if(strborrowerid.length>1)
    		{
    			for(int a=0;a<strborrowerid.length;a++)
	    		{
    				strbowid=strborrowerid[a];
    				if(!strbowid.equalsIgnoreCase(""))
	    			{
    		if(strbowid.equalsIgnoreCase(strApplicantid))
    		{
			strLimit="";strOutstand="";strMargin="";
			String strbnkFac="",str_modtype="",strNature="",strFacType="";
			strQuery = SQLParser.getSqlQuery("sel_banking^" + strAppno);
			rs1 = DBUtils.executeQuery(strQuery);
			while(rs1.next())
			{
					strFacCode="";strNature="";strFacType="";
					vecVal = new ArrayList();
					strbnkFac = Helper.correctNull((String)rs1.getString("combk_facility"));
					str_modtype=Helper.correctNull((String)rs1.getString("combk_modtype"));
					String[] bankFac = strbnkFac.split("~");
					if(str_modtype.equalsIgnoreCase("c") || str_modtype.equalsIgnoreCase("a"))
					{
						strQuery = SQLParser.getSqlQuery("sel_facilityCorp^" + bankFac[0]);
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							strFacCode=rs.getString("com_facdesc");
							strNature=rs.getString("com_facnature");
							strFacType=rs.getString("com_factype");
						}
					}
					else if(str_modtype.equalsIgnoreCase("r") || str_modtype.equalsIgnoreCase("p"))
					{
							strQuery=SQLParser.getSqlQuery("sel_retProductDesc^"+bankFac[0]);
							rs = DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								strFacCode=Helper.correctNull(rs.getString("com_facdesc"));
								strFacType="F";
								strNature=rs.getString("prd_loantype");
							}	
					}
					vecVal.add(strFacCode);//0
					dblProposed =rs1.getDouble("combk_limit");
					strOutstand = jtn.format(dblProposed);
					vecVal.add(strOutstand);//1
					vecVal.add("");//2
					if(Helper.correctNull((String)rs1.getString("combk_facility_sno")).equalsIgnoreCase(""))
					{
						vecVal.add("1");//6
					}
					else
					{
						vecVal.add(Helper.correctInt((String)rs1.getString("combk_facility_sno")));//3
					}
					vecVal.add(bankFac[0]);//4
					vecVal.add(strFacType);//5
					vecVal.add(strNature);//6
					dblExist =rs1.getDouble("combk_os");
					strLimit = jtn.format(dblExist);
					vecVal.add(strLimit);//7
					vecVal.add("E");//8
					hshRecord.put("Existing","Y");
					srtParentfacsno=Helper.correctInt((String)rs1.getString("combk_parentfacsno"));
					strQuery = SQLParser.getSqlQuery("sel_facid_appSecdetails_attached^" + Helper.correctInt((String)rs1.getString("COMBK_PARENTAPPNO")) + "^"+secID+"^"+srtParentfacsno);
					rs2 = DBUtils.executeQuery(strQuery);
		    		if(rs2.next())
					{
		    			vecVal.add("Y");//9
					}
		    		else
		    		{
		    			vecVal.add("N");//9
		    		}
		    		vecVal.add(Helper.correctNull((String)rs1.getString("COMBK_PARENTAPPNO")));//10
		    		vecVal.add(Helper.correctNull((String)rs1.getString("COMBK_PARENTFACSNO")));//11
		    		vecVal.add(strbowid);//12
		    		vecVal.add("");//13
		    		vecVal.add("N");//14
		    		vecVal.add("");
		    		vecData.add(vecVal);		
				}
	    	}
    		else
    		{	

    			strLimit="";
				strOutstand="";
				strMargin="";
				String strbnkFac="",str_modtype="",strNature="",strFacType="";
				strQuery = SQLParser.getSqlQuery("sel_groupconcerns^" + strAppno);
				rs1 = DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{
					strNature="";strFacType="";
					vecVal = new ArrayList();
					strbnkFac = Helper.correctNull((String)rs1.getString("comgc_facility"));
					str_modtype=Helper.correctNull((String)rs1.getString("comgc_modtype"));
					String[] bankFac = strbnkFac.split("~");
					String strFlag="";
					if(str_modtype.equalsIgnoreCase("c") || str_modtype.equalsIgnoreCase("a"))
					{
						strQuery = SQLParser.getSqlQuery("sel_facilitycorp_desc^" + bankFac[0]);
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							strFacCode=rs.getString("com_facdesc");
							strFlag="C";
							strNature=rs.getString("com_facnature");
							strFacType=rs.getString("com_factype");
						}
					}
					else if(str_modtype.equalsIgnoreCase("r") || str_modtype.equalsIgnoreCase("p"))
					{
							strQuery=SQLParser.getSqlQuery("sel_retProductDesc^"+bankFac[0]);
							rs = DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								strFacCode=Helper.correctNull(rs.getString("com_facdesc"));
								strFlag="R";
								strFacType="F";
								strNature=rs.getString("prd_loantype");
							}
					}
					vecVal.add(strFacCode);//0
					dblProposed =rs1.getDouble("comgc_limit");
					strOutstand = jtn.format(dblProposed);
					vecVal.add(strOutstand);//1
					vecVal.add("");//2
					vecVal.add(Helper.correctNull((String)rs1.getString("comgc_facility_sno")));//3
					vecVal.add(bankFac[0]);//4
					vecVal.add(strFacType);//5
					vecVal.add(strNature);//6
					dblExist =rs1.getDouble("comgc_os");
					strLimit = jtn.format(dblExist);
					vecVal.add(strLimit);//7
					vecVal.add("E");//8
					hshRecord.put("Existing","Y");
					if(rs2 != null)
					{
						rs2.close();
					}
					srtParentfacsno=Helper.correctInt((String)rs1.getString("comgc_parentfacsno"));
					strQuery = SQLParser.getSqlQuery("sel_facid_appSecdetails_attached^" + Helper.correctInt((String)rs1.getString("COMgc_PARENTAPPNO")) + "^"+secID+"^"+srtParentfacsno);
					rs2 = DBUtils.executeQuery(strQuery);
		    		if(rs2.next())
					{
		    			vecVal.add("Y");//9
					}
		    		else
		    		{
		    			vecVal.add("N");//9
		    		}
		    		vecVal.add(Helper.correctNull((String)rs1.getString("COMgc_PARENTAPPNO")));//10
		    		vecVal.add(Helper.correctNull((String)rs1.getString("COMgc_PARENTFACSNO")));//11
		    		vecVal.add(Helper.correctNull((String)rs1.getString("comgc_companyname")));//12
		    		vecVal.add("");//13
		    		vecVal.add("N");//14
		    		vecVal.add("");
		    		vecData.add(vecVal);
				}
    		}
	    			}
	    		}
    		}
    		else
    		{
    			if(!strbowid.equalsIgnoreCase(""))
    			{
    			if(strbowid.equalsIgnoreCase(strApplicantid))
        		{
    			strLimit="";strOutstand="";strMargin="";
    			String strbnkFac="",str_modtype="",strNature="",strFacType="";
    			strQuery = SQLParser.getSqlQuery("sel_banking^" + strAppno);
    			rs1 = DBUtils.executeQuery(strQuery);
    			while(rs1.next())
    			{
    					strNature="";strFacType="";
    					vecVal = new ArrayList();
    					strbnkFac = Helper.correctNull((String)rs1.getString("combk_facility"));
    					str_modtype=Helper.correctNull((String)rs1.getString("combk_modtype"));
    					String[] bankFac = strbnkFac.split("~");
    					if(str_modtype.equalsIgnoreCase("c") || str_modtype.equalsIgnoreCase("a"))
    					{
    						strQuery = SQLParser.getSqlQuery("sel_facilityCorp^" + bankFac[0]);
    						rs = DBUtils.executeQuery(strQuery);
    						if(rs.next())
    						{
    							strFacCode=rs.getString("com_facdesc");
    							strNature=rs.getString("com_facnature");
    							strFacType=rs.getString("com_factype");
    						}
    					}
    					else if(str_modtype.equalsIgnoreCase("r") || str_modtype.equalsIgnoreCase("p"))
    					{
    							strQuery=SQLParser.getSqlQuery("sel_retProductDesc^"+bankFac[0]);
    							rs = DBUtils.executeQuery(strQuery);
    							if(rs.next())
    							{
    								strFacCode=Helper.correctNull(rs.getString("com_facdesc"));
    								strFacType="F";
    								strNature=rs.getString("prd_loantype");
    							}	
    					}
    					vecVal.add(strFacCode);//0
    					dblProposed =rs1.getDouble("combk_limit");
    					strOutstand = jtn.format(dblProposed);
    					vecVal.add(strOutstand);//1
    					vecVal.add("");//2
    					if(Helper.correctNull((String)rs1.getString("combk_facility_sno")).equalsIgnoreCase(""))
    					{
    						vecVal.add("1");//6
    					}
    					else
    					{
    						vecVal.add(Helper.correctInt((String)rs1.getString("combk_facility_sno")));//3
    					}
    					vecVal.add(bankFac[0]);//4
    					vecVal.add(strFacType);//5
    					vecVal.add(strNature);//6
    					dblExist =rs1.getDouble("combk_os");
    					strLimit = jtn.format(dblExist);
    					vecVal.add(strLimit);//7
    					vecVal.add("E");//8
    					hshRecord.put("Existing","Y");
    					srtParentfacsno=Helper.correctInt((String)rs1.getString("combk_parentfacsno"));
    					strQuery = SQLParser.getSqlQuery("sel_facid_appSecdetails_attached^" + Helper.correctInt((String)rs1.getString("COMBK_PARENTAPPNO")) + "^"+secID+"^"+srtParentfacsno);
    					rs2 = DBUtils.executeQuery(strQuery);
    		    		if(rs2.next())
    					{
    		    			vecVal.add("Y");//9
    					}
    		    		else
    		    		{
    		    			vecVal.add("N");//9
    		    		}
    		    		vecVal.add(Helper.correctNull((String)rs1.getString("COMBK_PARENTAPPNO")));//10
    		    		vecVal.add(Helper.correctNull((String)rs1.getString("COMBK_PARENTFACSNO")));//11
    		    		vecVal.add(strbowid);//12
    		    		vecVal.add("");//13
    		    		vecVal.add("N");//14
    		    		vecVal.add("");
    		    		vecData.add(vecVal);		
    				}
    	    	}
        		else
        		{	

        			strLimit="";
    				strOutstand="";
    				strMargin="";
    				String strbnkFac="",str_modtype="",strNature="",strFacType="";
    				strQuery = SQLParser.getSqlQuery("sel_groupconcerns^" + strAppno);
    				rs1 = DBUtils.executeQuery(strQuery);
    				while(rs1.next())
    				{
    					vecVal = new ArrayList();
    					strNature="";strFacType="";
    					strbnkFac = Helper.correctNull((String)rs1.getString("comgc_facility"));
    					str_modtype=Helper.correctNull((String)rs1.getString("comgc_modtype"));
    					String[] bankFac = strbnkFac.split("~");
    					String strFlag="";
    					if(str_modtype.equalsIgnoreCase("c") || str_modtype.equalsIgnoreCase("a"))
    					{
    						strQuery = SQLParser.getSqlQuery("sel_facilitycorp_desc^" + bankFac[0]);
    						rs = DBUtils.executeQuery(strQuery);
    						if(rs.next())
    						{
    							strFacCode=rs.getString("com_facdesc");
    							strFlag="C";
    							strNature=rs.getString("com_facnature");
    							strFacType=rs.getString("com_factype");
    						}
    					}
    					else if(str_modtype.equalsIgnoreCase("r") || str_modtype.equalsIgnoreCase("p"))
    					{
    							strQuery=SQLParser.getSqlQuery("sel_retProductDesc^"+bankFac[0]);
    							rs = DBUtils.executeQuery(strQuery);
    							if(rs.next())
    							{
    								strFacCode=Helper.correctNull(rs.getString("com_facdesc"));
    								strFlag="R";
    								strFacType="F";
    								strNature=rs.getString("prd_loantype");
    							}
    					}
    					vecVal.add(strFacCode);//0
    					dblProposed =rs1.getDouble("comgc_limit");
    					strOutstand = jtn.format(dblProposed);
    					vecVal.add(strOutstand);//1
    					vecVal.add("");//2
    					vecVal.add(Helper.correctNull((String)rs1.getString("comgc_facility_sno")));//3
    					vecVal.add(bankFac[0]);//4
						vecVal.add(strFacType);//5
						vecVal.add(strNature);//6
    					dblExist =rs1.getDouble("comgc_os");
    					strLimit = jtn.format(dblExist);
    					vecVal.add(strLimit);//7
    					vecVal.add("E");//8
    					hshRecord.put("Existing","Y");
    					if(rs2 != null)
    					{
    						rs2.close();
    					}
    					srtParentfacsno=Helper.correctInt((String)rs1.getString("comgc_parentfacsno"));
    					strQuery = SQLParser.getSqlQuery("sel_facid_appSecdetails_attached^" + Helper.correctInt((String)rs1.getString("COMgc_PARENTAPPNO")) + "^"+secID+"^"+srtParentfacsno);
    					rs2 = DBUtils.executeQuery(strQuery);
    		    		if(rs2.next())
    					{
    		    			vecVal.add("Y");//9
    					}
    		    		else
    		    		{
    		    			vecVal.add("N");//9
    		    		}
    		    		vecVal.add(Helper.correctNull((String)rs1.getString("COMgc_PARENTAPPNO")));//10
    		    		vecVal.add(Helper.correctNull((String)rs1.getString("COMgc_PARENTFACSNO")));//11
    		    		vecVal.add(Helper.correctNull((String)rs1.getString("comgc_companyname")));//12
    		    		vecVal.add("");//13
    		    		vecVal.add("N");//14
    		    		vecVal.add("");
    		    		vecData.add(vecVal);
    				}
        		}
    			}
    		}
    		if(rs1 != null)
			{
				rs1.close();
			}
    		if(rs2 != null)
			{
				rs2.close();
			}
    		strQuery = SQLParser.getSqlQuery("sel_appSecdetails_attached^" + strAppno + "^"+secID);
			rs2 = DBUtils.executeQuery(strQuery);
			String strFacID="";
			while(rs2.next())
			{
    			
	    			arrFacID = new ArrayList();
	    			arrFacID.add(correctNull((String)rs2.getString("app_sec_facid")));
	    			arrFacID.add(correctNull((String)rs2.getString("APP_SEC_MARGIN")));
	    			arrFacID.add(correctNull((String)rs2.getString("app_sec_securitytype")));
	    			arrFacID.add(correctNull((String)rs2.getString("app_sec_loantype")));
	    			arrFacID.add(correctNull((String)rs2.getString("app_sec_parentappno")));
	    			arrFacID.add(correctNull((String)rs2.getString("app_sec_parent_facsno")));
	    			arrFacID.add(correctNull((String)rs2.getString("APP_SEC_SECUTYPE")));
	    			arrColFacID.add(arrFacID);
    		
			}
			if(rs2 != null)
			{
				rs2.close();
			}
			strQuery = SQLParser.getSqlQuery("selsecpropdet_cersai^"+secID);
			rs2 = DBUtils.executeQuery(strQuery);
			if(rs2.next())
			{
				
				hshRecord.put("SEC_CERSAIREFNO",correctNull(rs2 .getString("SEC_CERSAIREFNO")));
				hshRecord.put("SEC_ALREADY_MORTG",correctNull(rs2 .getString("SEC_ALREADY_MORTG")));
				hshRecord.put("SEC_SEARCHPERFORM_DATE",correctNull(rs2.getString("SEC_SEARCHPERFORM_DATE")));
				hshRecord.put("sec_croptype",correctNull(rs2.getString("sec_croptype")));
				hshRecord.put("cus_sec_type",correctNull(rs2.getString("cus_sec_type")));
				String cus_sec_type = correctNull(rs2.getString("cus_sec_type"));
				if(cus_sec_type.equalsIgnoreCase("10")||cus_sec_type.equalsIgnoreCase("11")||cus_sec_type.equalsIgnoreCase("12")
						||cus_sec_type.equalsIgnoreCase("13")||cus_sec_type.equalsIgnoreCase("15")||cus_sec_type.equalsIgnoreCase("16")
						||cus_sec_type.equalsIgnoreCase("17"))
				{
					if(rs1 != null)
					{
						rs1.close();
					}
					strQuery = SQLParser.getSqlQuery("selsecpropdet_cersai_statdata");
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
							int intdatadesc = Integer.parseInt(Helper.correctInt(rs1.getString("stat_data_desc1")));
	
							if(rs != null)
							{
								rs.close();
							}
							
							String strcersiDate = correctNull(rs2.getString("SEC_SEARCHPERFORM_DATE"));
							String currdate = Helper.getCurrentDateTime();
							
							if(!strcersiDate.equalsIgnoreCase(""))
							{
								String strArr1[]=strcersiDate.split("@");
								for(int i=0;i<strArr1.length;i++)
								{
									strcersiDate = strArr1[i]; 
									SimpleDateFormat cersaiDate = new SimpleDateFormat("dd/MM/yyyy");//"yyyy-MM-dd""16/4/2021"
									java.util.Date date1;
									java.util.Date date2;
									date1 = cersaiDate.parse(strcersiDate);
									date2 = cersaiDate.parse(currdate);
									long diffInMillies = Math.abs(date2.getTime() - date1.getTime());
								    long diff = TimeUnit.DAYS.convert(diffInMillies, TimeUnit.MILLISECONDS);
									if(diff > intdatadesc)
									{
										hshRecord.put("cersaidate", "Y");
									}
								}
							}
					}
					
				}
			}
			if(rs1 != null)
			{
				rs1.close();
			}
    				
    		strQuery = SQLParser.getSqlQuery("sel_appstatus^"+strAppno);
			rs1 = DBUtils.executeQuery(strQuery);
    		if(rs1.next())
			{
    			hshRecord.put("strAppType",Helper.correctNull((String)rs1.getString("app_renew_flag")));
			}
			hshRecord.put("vecData",vecData);
    		hshRecord.put("hidposition",hidposition);
    		hshRecord.put("hidFacID",hidFacID);
    		hshRecord.put("arrColFacID",arrColFacID);
    		
    		//***********************************************
    		
    	}
    	catch(Exception e)
		{
			throw new EJBException("Error in getattachRetailSecurity "+e.toString());
		} 
    	return hshRecord;
    }
    
    
    public HashMap getRetailSecuritiesbySecId(HashMap hshRequestValues)  
	{
		HashMap hshRecord = new HashMap();
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		String strQuery = "";
		String strSecId="";
		String strJointOwnDetails="";
		
		try {
				strSecId = Helper.correctNull((String)hshRequestValues.get("hidsecid"));
				strQuery = SQLParser.getSqlQuery("securities_sel^" + strSecId);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next()) 
				{
					hshRecord.put("cus_sec_id",correctNull((String) rs.getString("cus_sec_id")));//0
					hshRecord.put("cus_sec_type",correctNull((String) rs.getString("cus_sec_type")));//1
					hshRecord.put("cus_sec_classification",correctNull((String) rs.getString("cus_sec_classification")));//2
					hshRecord.put("cus_sec_security_description",Helper.correctNull(Helper.CLOBToString(rs.getClob("cus_sec_security_description"))));//3
					hshRecord.put("cus_sec_netsecurity",correctNull((String) rs.getString("cus_sec_netsecurity")));//4
					hshRecord.put("CUS_SEC_TYPE_SPECIFY",correctNull((String) rs.getString("CUS_SEC_TYPE_SPECIFY")));//5
					hshRecord.put("CUS_SEC_CLASSIFICATION_SPECIFY",correctNull((String) rs.getString("CUS_SEC_CLASSIFICATION_SPECIFY")));//6
					hshRecord.put("CUS_SEC_COLLATERAL_START_DATE",correctNull((String) rs.getString("CUS_SEC_COLLATERAL_START_DATE")));//7
					hshRecord.put("CUS_SEC_COLLATERAL_END_DATE",correctNull((String) rs.getString("CUS_SEC_COLLATERAL_END_DATE")));//8
					hshRecord.put("CUS_SEC_Already_Charged",correctNull((String) rs.getString("CUS_SEC_Already_Charged")));//9
					
					hshRecord.put("CUS_SEC_Amount_Charged",correctNull((String) rs.getString("CUS_SEC_Amount_Charged")));//9
					hshRecord.put("CUS_SEC_NAME_institution",correctNull((String) rs.getString("CUS_SEC_NAME_institution")));//10
					hshRecord.put("CUS_SEC_Residual_RiskFlag",correctNull((String) rs.getString("CUS_SEC_Residual_RiskFlag")));//11
					hshRecord.put("CUS_SEC_Valuer_Name",correctNull((String) rs.getString("CUS_SEC_Valuer_Name")));//12
					hshRecord.put("CUS_SEC_VALUATION_DATE",correctNull((String) rs.getString("CUS_SEC_VALUATION_DATE")));//13
					
					hshRecord.put("CUS_SEC_INSURENCE_COMPANY",correctNull((String) rs.getString("CUS_SEC_INSURENCE_COMPANY")));//14
					hshRecord.put("CUS_SEC_Insured_Amount",correctNull((String) rs.getString("CUS_SEC_Insured_Amount")));//15
					hshRecord.put("CUS_SEC_DUE_DATE",correctNull((String) rs.getString("CUS_SEC_DUE_DATE")));//16
					hshRecord.put("CUS_SEC_Joint_Holder",correctNull((String) rs.getString("CUS_SEC_Joint_Holder")));//17
					hshRecord.put("CUS_SEC_Createdby",correctNull((String) rs.getString("CUS_SEC_Createdby")));//18
					
					hshRecord.put("CUS_SEC_Created_branch",correctNull((String) rs.getString("CUS_SEC_Created_branch")));//19
					hshRecord.put("CUS_SEC_Created_ON",correctNull((String) rs.getString("CUS_SEC_Created_ON")));//20					
					//Getting Security Type Description for Grid..
					if(rs1 !=null)
						rs1.close();
					rs1 = DBUtils.executeLAPSQuery("selstaticdata_securitytype_sel^"+correctNull((String) rs.getString("cus_sec_type")));
					if(rs1.next())
					{
						hshRecord.put("sec_name",correctNull((String) rs1.getString("sec_name")));//21
					}
					if(rs1 !=null)
						rs1.close();
					rs1 = DBUtils.executeLAPSQuery("selstaticdata_securitytype_sel^"+correctNull((String) rs.getString("cus_sec_classification")));
					if(rs1.next())
					{
						hshRecord.put("sec_name",correctNull((String) rs1.getString("sec_name")));//22
					}else{
						
						hshRecord.put("sec_name","");//22
					}
					
					strJointOwnDetails="";
					strQuery = SQLParser.getSqlQuery("securities_owner_sel^" + strSecId);
					rs1 = DBUtils.executeQuery(strQuery);
					while (rs1.next()) 
					{
						String strSeperator="@";
	
						String strId=Helper.correctNull((String)rs1.getString("cus_owner_laps_id"));
						String strName="";
						String strCBSID="";
						String strOldID="";
						strQuery = SQLParser.getSqlQuery("selcustomerdetails^"+strId);
						rs2 = DBUtils.executeQuery(strQuery);
						if(rs2.next())
						{
							
							 strName=Helper.correctNull((String)rs2.getString("perapp_fname"));
							 strOldID=Helper.correctNull((String)rs2.getString("perapp_oldid"));
							 strCBSID=Helper.correctNull((String)rs2.getString("perapp_cbsid"));
						}
						strJointOwnDetails+=strName;
						strJointOwnDetails+=strSeperator;
						strJointOwnDetails+=strOldID;
						strJointOwnDetails+=strSeperator;
						strJointOwnDetails+=strCBSID;
						strJointOwnDetails+=strSeperator;
					}
					strJointOwnDetails+=strSecId;
					hshRecord.put("strJointOwnDetails",strJointOwnDetails);//23					
					hshRecord.put("CUS_SEC_REIDUALVAL",correctNull((String) rs.getString("CUS_SEC_REIDUALVAL")));//24
					hshRecord.put("CUS_VALSUBMITTEDDATE",correctNull((String) rs.getString("CUS_VALSUBMITTEDDATE")));//25
					hshRecord.put("CUS_VALRECVDATE",correctNull((String) rs.getString("CUS_VALRECVDATE")));//26
					hshRecord.put("CUS_SEC_NATUREOFCHARGE",correctNull((String) rs.getString("CUS_SEC_NATUREOFCHARGE")));//27
					hshRecord.put("CUS_SEC_CHARGEID_ROC",correctNull((String) rs.getString("CUS_SEC_CHARGEID_ROC")));//27
					hshRecord.put("CUS_SEC_INTID_ROC",correctNull((String) rs.getString("CUS_SEC_INTID_ROC")));//27
					hshRecord.put("CUS_COMPANYCODE",correctNull((String) rs.getString("CUS_COMPANYCODE")));//27
					hshRecord.put("CUS_COMPANYSHARE_CNT",correctNull((String) rs.getString("CUS_COMPANYSHARE_CNT")));//27
					hshRecord.put("CUS_COMPANYSHAREVAL",correctNull((String) rs.getString("CUS_COMPANYSHAREVAL")));//27
					if(!Helper.correctNull(rs.getString("cus_companycode")).equalsIgnoreCase(""))
					{
						if(rs1!=null)
							rs1.close();
						strQuery = SQLParser.getSqlQuery("selcompanymaster_comname^"+correctNull(rs.getString("cus_companycode")));
						rs1 = DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							hshRecord.put("svm_companycinno",correctNull(rs1.getString("svm_companycinno"))); 
							hshRecord.put("svm_companyname",correctNull(rs1.getString("svm_companyname"))); 
						}
					}
					hshRecord.put("CUS_SEC_VALUERCODE",correctNull((String) rs.getString("CUS_SEC_VALUERCODE")));
					hshRecord.put("CUS_SEC_GOVT_VALUER",correctNull((String) rs.getString("CUS_SEC_GOVT_VALUER")));
					
				}
			
			if (rs != null) 
			{rs.close();}
		} 
		catch (Exception e1) {
			log.error(e1.toString());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			}

			catch (Exception e) {
				log.error(e.toString());
			}
		}
		return hshRecord;
	
	}
    
    public HashMap getFreezeData(HashMap hshValues) 
    {
    	java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
    	ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		Connection connectDB= null;
		CallableStatement callableStmt = null;
		String strExp="",strQuery="";
		HashMap hshResult=new HashMap();
    	ArrayList arrSecCol=new ArrayList();
    	ArrayList arrSecRow=new ArrayList();
    	
    	ArrayList arrAttachCol=new ArrayList();
    	ArrayList arrAttachRow=new ArrayList();
    	ResultSet rs1=null;
    	ResultSet rs2=null;
    	ResultSet rs3=null,rs4=null;
    	String strQuery1="",strQuery2="",strQuery3="";
    	String strAppno="",newLapsId="",oldLapsId="",strappId="",str_facsno="";
    	String strName="";
    	String strSecurityId="";
    	String strLoanType="";
    	String strSecurityType="",appno="";
    	String strFlag="";
    	int count =0;
    	HashMap hshQueryValues=new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		
		String strWhetherACOpening="",strPrefix="",strSuffix="",strCbsACno="",strDrawingpower="",strDueDate="",strValuesin="";
		String strOutstanding="",strFacilitycode[]=null,strModuletype="",strRatingcheck="",strSchnonsche="";
		double dblTLExposure=0.00,dblOutstanding=0.00,dbl_Sancamount=0.00,dbl_disbamount=0.00;
		//For 100% cash margin products should not include for Rating based exposure 
	    ArrayList arrCashmargincode= new ArrayList();
	    arrCashmargincode.add("153");
	    arrCashmargincode.add("154");
	    arrCashmargincode.add("156");
	    arrCashmargincode.add("158");
    	try
    	{
    		strAppno=Helper.correctNull((String)hshValues.get("appno"));
    		strValuesin=Helper.correctNull((String)hshValues.get("valuesin"));
        		strQuery=SQLParser.getSqlQuery("comfunsel3^"+strAppno);
        		rs=DBUtils.executeQuery(strQuery);
        		if(rs.next())
        		{
        			oldLapsId=Helper.correctNull((String)rs.getString("demo_appid"));
        		}
        		
        		if(rs!=null)
        		{rs.close();}
			
        		log.info("**************************Execute procedure*********************************");
        	
        		log.info("Old laps id... " + oldLapsId);
        		log.info("Appno.... " + strAppno);
    	
    		connectDB= ConnectionFactory.getConnection();
			callableStmt=connectDB.prepareCall("call BORROWER_EXPOSURE(?,?)");
			callableStmt.setString(1,Helper.correctNull(oldLapsId));
			callableStmt.setString(2,Helper.correctNull(strAppno));
			callableStmt.execute();
			callableStmt.clearParameters();
			callableStmt.close();
			connectDB.close();
			
			log.info("**************************End procedure*********************************");
			
			int size=0;
			if(rs4!=null) rs4.close();
			strQuery2 = SQLParser.getSqlQuery("sel_banking^"+strAppno);
			rs4 = DBUtils.executeQuery(strQuery2);
    		while(rs4.next())
    		{
    			if(rs!=null)
    				rs.close();
    			
    			strQuery=SQLParser.getSqlQuery("sel_adhocfacilitydetails^"+Helper.correctNull(rs4.getString("combk_parentappno"))+"^"+Helper.correctNull(rs4.getString("combk_parentfacsno")));
        		rs=DBUtils.executeQuery(strQuery);
        		while(rs.next())
        		{
        			size = size+1;
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","ins_comfacility_details");								
					arrValues.add(strAppno);
					arrValues.add("");
					arrValues.add(Helper.correctNull(rs.getString("facility_appno")));
					arrValues.add(Helper.correctNull(rs.getString("facility_sno")));
					arrValues.add(Helper.correctNull(rs4.getString("combk_parentappno")));
					arrValues.add(Helper.correctNull(rs4.getString("combk_parentfacsno")));
					arrValues.add("E");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(size));
					hshQueryValues.put(Integer.toString(size),hshQuery);
        		}
    			
    		}
    		
    		if(size>0)
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			size=0;
			hshQueryValues=new HashMap();
			if(rs4!=null) rs4.close();
			strQuery2 = SQLParser.getSqlQuery("sel_combanking_existingfac_updliab^"+strAppno);
			rs4 = DBUtils.executeQuery(strQuery2);
    		while(rs4.next())
    		{
    			strWhetherACOpening="";strCbsACno="";strPrefix="";strSuffix="";strRatingcheck="";strSchnonsche="";
    			strDrawingpower="";strDueDate="";strOutstanding="";strFlag="";strModuletype="";
				dbl_Sancamount=0.0;dbl_disbamount=0.0;dblOutstanding=0.0;dblTLExposure=0.0;
    			strWhetherACOpening=Helper.correctNull((String)rs4.getString("combk_accountopen"));
    			strCbsACno=Helper.correctNull((String)rs4.getString("combk_cbsappno"));
    			strPrefix=Helper.correctNull((String)rs4.getString("combk_prefix"));
    			strSuffix=Helper.correctNull((String)rs4.getString("combk_suffix"));
    			strModuletype=Helper.correctNull((String)rs4.getString("combk_modtype"));
    			strFacilitycode=Helper.correctNull((String)rs4.getString("combk_facility")).split("~");
    			    			
    			if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
				{
	    			if(strWhetherACOpening.equalsIgnoreCase("Y"))
	    			{
	    				strQuery = SQLParser.getCBSSqlQuery("selliabpullingdirectacopening^"+strCbsACno);
	    			}
	    			else
	    			{
	    				if(!strPrefix.equalsIgnoreCase("")&& !strSuffix.equalsIgnoreCase(""))
	    					strQuery = SQLParser.getCBSSqlQuery("selliabpullingindirectacopening^"+strPrefix+"^"+strSuffix);
	    				else
	    					strQuery = SQLParser.getCBSSqlQuery("selliabpullingindirectacopeningbg^"+strCbsACno);	
	    			}
				}
    			else
    			{
    				if(strWhetherACOpening.equalsIgnoreCase("Y"))
	    			{
	    				strQuery = SQLParser.getCBSSqlQuery("selliabpullingdirectacopening1^"+strCbsACno);
	    			}
	    			else
	    			{
	    				if(!strPrefix.equalsIgnoreCase("")&& !strSuffix.equalsIgnoreCase(""))
	    					strQuery = SQLParser.getCBSSqlQuery("selliabpullingindirectacopening1^"+strPrefix+"^"+strSuffix);
	    				else
	    					strQuery = SQLParser.getCBSSqlQuery("selliabpullingindirectacopeningbg1^"+strCbsACno);	
	    			}
    			}
    			if(rs!=null) rs.close();
    			rs = DBUtils.executeQueryCBSConnection(strQuery);
    			if(rs.next())
    			{
    				strDrawingpower =jtn.format(Double.parseDouble((String)Helper.correctDouble(rs.getString("drawingpower"))));    
    				strDueDate =Helper.correctNull((String)rs.getString("duedate"));
    				strOutstanding = jtn.format(Double.parseDouble((String)Helper.correctDouble(rs.getString("outstanding"))));
    				dbl_Sancamount=Double.parseDouble((String)Helper.correctDouble(rs.getString("SANCT_LIMIT")));
    				dbl_disbamount=Double.parseDouble((String)Helper.correctDouble(rs.getString("Disb_amt")));
    				dblOutstanding=Double.parseDouble((String)Helper.correctDouble(rs.getString("outstanding")));
    				    				
    				if(dblOutstanding<0)
    				{
    					dblOutstanding=Double.parseDouble(strOutstanding.substring(1));//for converting negative value to positive
    					strFlag="DR";
    				}	
        			else
        			{
        				strFlag="CR";
        			}
        			
					if(Helper.correctNull((String)rs4.getString("combk_type")).equalsIgnoreCase("1")||strWhetherACOpening.equalsIgnoreCase("N"))
					{
						if(strFlag.equalsIgnoreCase("CR"))
						{
							dblTLExposure=dbl_Sancamount;
						}
						else
						{
							if(dbl_Sancamount < dblOutstanding)
							{
								dblTLExposure=dblOutstanding;
							}
							else
							{
								dblTLExposure=dbl_Sancamount;
							}
						}
					}
					else
					{
						dblTLExposure=dblOutstanding+(dbl_Sancamount-dbl_disbamount);						
					}
    			}
    			if(strModuletype.equalsIgnoreCase("P") || strModuletype.equalsIgnoreCase("r"))
    			{
	    			strQuery = SQLParser.getSqlQuery("sel_retailBankschemetype^1"+"^"+strFacilitycode[0]);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strSchnonsche=Helper.correctNull((String)rs.getString("MIS_SCHEMATIC"));
					}
    			}else
    			{
    				strQuery = SQLParser.getSqlQuery("sel_corpBankschemetype^1"+"^"+strFacilitycode[0]);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strSchnonsche=Helper.correctNull((String)rs.getString("MIS_SCHEMATIC"));
					}
    			}
    			if(strSchnonsche.equalsIgnoreCase("Y"))
    			{
    				strRatingcheck="N";
    			}else if(strSchnonsche.equalsIgnoreCase("N"))
    			{
    				strRatingcheck="Y";
    			}
    			if(strDrawingpower.equalsIgnoreCase(""))
    			{
    				strDrawingpower="0";
    			}
    			//For 100% cash margin products should not include for Rating based exposure 
    			if(arrCashmargincode.contains(strFacilitycode[0]))
    			{
    				strRatingcheck="N";
    			}
    				hshQuery = new HashMap();
       			 	arrValues = new ArrayList();
       			 	arrValues.add(Helper.convertSetupToApplicationValues(strValuesin,Double.parseDouble(strDrawingpower)));
       			    arrValues.add(strDueDate);
       			 	arrValues.add(Helper.convertSetupToApplicationValues(strValuesin,dblOutstanding));
       			 	arrValues.add(Helper.correctDouble(String.valueOf(dblTLExposure)));
       			 	arrValues.add(strFlag);
       			 	arrValues.add(strRatingcheck);
       			    arrValues.add(strAppno);
       			 	size+=1;
       			 	hshQueryValues.put("size",""+(size));
       			    if(strWhetherACOpening.equalsIgnoreCase("Y"))
       			    {
       			    	arrValues.add(strCbsACno);
       			    	hshQuery.put("strQueryId","updcombankdirliab"); 
       			    }
       			    else
       			    {
       			    	arrValues.add(strPrefix);
       			    	arrValues.add(strSuffix);
       			    	hshQuery.put("strQueryId","updcombankindirliab"); 
       			    }
       			 	hshQuery.put("arrValues",arrValues);
       			 	hshQueryValues.put(""+(size),hshQuery);	
    			
    		}
    		if(size>0){
    			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
    		}
    		
    		size=0;
    		if(rs4!=null) rs4.close();
			strQuery2 = SQLParser.getSqlQuery("sel_comgroupconcerns_existingfac^"+strAppno);
			rs4 = DBUtils.executeQuery(strQuery2);
    		while(rs4.next())
    		{
    			strWhetherACOpening="";strCbsACno="";strPrefix="";strSuffix="";strRatingcheck="";strSchnonsche="";
    			strDrawingpower="";strDueDate="";strOutstanding="";strFlag="";strModuletype="";
				dbl_Sancamount=0.0;dbl_disbamount=0.0;dblOutstanding=0.0;dblTLExposure=0.0;
    			strWhetherACOpening=Helper.correctNull((String)rs4.getString("comgc_accountopen"));
    			strCbsACno=Helper.correctNull((String)rs4.getString("comgc_cbsappno"));
    			strPrefix=Helper.correctNull((String)rs4.getString("comgc_prefix"));
    			strSuffix=Helper.correctNull((String)rs4.getString("comgc_suffix"));
    			strModuletype=Helper.correctNull((String)rs4.getString("comgc_modtype"));
    			strFacilitycode=Helper.correctNull((String)rs4.getString("comgc_facility")).split("~");
    			if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
				{
    				if(strWhetherACOpening.equalsIgnoreCase("Y"))
    				{
    					strQuery = SQLParser.getCBSSqlQuery("selliabpullingdirectacopening^"+strCbsACno);
    				}
    				else
    				{
    					if(!strPrefix.equalsIgnoreCase("")&& !strSuffix.equalsIgnoreCase(""))
	    					strQuery = SQLParser.getCBSSqlQuery("selliabpullingindirectacopening^"+strPrefix+"^"+strSuffix);
	    				else
	    					strQuery = SQLParser.getCBSSqlQuery("selliabpullingindirectacopeningbg^"+strCbsACno);
    				}
				}
    			else
    			{
    				if(strWhetherACOpening.equalsIgnoreCase("Y"))
	    			{
	    				strQuery = SQLParser.getCBSSqlQuery("selliabpullingdirectacopening1^"+strCbsACno);
	    			}
	    			else
	    			{
	    				if(!strPrefix.equalsIgnoreCase("")&& !strSuffix.equalsIgnoreCase(""))
	    					strQuery = SQLParser.getCBSSqlQuery("selliabpullingindirectacopening1^"+strPrefix+"^"+strSuffix);
	    				else
	    					strQuery = SQLParser.getCBSSqlQuery("selliabpullingindirectacopeningbg1^"+strCbsACno);
	    			}
    			}
    			if(rs!=null) rs.close();
    			rs = DBUtils.executeQueryCBSConnection(strQuery);
    			if(rs.next())
    			{
    				strFlag="";
    				strDrawingpower =jtn.format((Double.parseDouble((String)Helper.correctDouble(rs.getString("drawingpower")))));    
    				strDueDate =Helper.correctNull((String)rs.getString("duedate"));
    				strOutstanding = jtn.format(Double.parseDouble((String)Helper.correctDouble(rs.getString("outstanding"))));
    				
    				dbl_Sancamount=Double.parseDouble((String)Helper.correctDouble(rs.getString("SANCT_LIMIT")));
    				dbl_disbamount=Double.parseDouble((String)Helper.correctDouble(rs.getString("Disb_amt")));
    				dblOutstanding=Double.parseDouble((String)Helper.correctDouble(rs.getString("outstanding")));
        			
        			if(dblOutstanding<0)
    				{
    					dblOutstanding=Double.parseDouble(strOutstanding.substring(1));//for converting negative value to positive
    					strFlag="DR";
    				}	
        			else
        			{
        				strFlag="CR";
        			}
        			
					if(Helper.correctNull((String)rs4.getString("comgc_type")).equalsIgnoreCase("1")||strWhetherACOpening.equalsIgnoreCase("N"))
					{
						if(strFlag.equalsIgnoreCase("CR"))
						{
							dblTLExposure=dbl_Sancamount;
						}
						else
						{
							if(dbl_Sancamount < dblOutstanding)
							{
								dblTLExposure=dblOutstanding;
							}
							else
							{
								dblTLExposure=dbl_Sancamount;
							}
						}
					}
					else
					{
						dblTLExposure=dblOutstanding+(dbl_Sancamount-dbl_disbamount);						
					}
        		}
    			if(rs!=null) rs.close();
    			if(strModuletype.equalsIgnoreCase("P") || strModuletype.equalsIgnoreCase("r"))
    			{
	    			strQuery = SQLParser.getSqlQuery("sel_retailBankschemetype^1"+"^"+strFacilitycode[0]);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strSchnonsche=Helper.correctNull((String)rs.getString("MIS_SCHEMATIC"));
					}
    			}else
    			{
    				strQuery = SQLParser.getSqlQuery("sel_corpBankschemetype^1"+"^"+strFacilitycode[0]);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strSchnonsche=Helper.correctNull((String)rs.getString("MIS_SCHEMATIC"));
					}
    			}
    			if(strSchnonsche.equalsIgnoreCase("Y"))
    			{
    				strRatingcheck="N";
    			}else if(strSchnonsche.equalsIgnoreCase("N"))
    			{
    				strRatingcheck="Y";
    			}
    			//For 100% cash margin products should not include for Rating based exposure 
    			if(arrCashmargincode.contains(strFacilitycode[0]))
    			{
    				strRatingcheck="N";
    			}
				hshQuery = new HashMap();
   			 	arrValues = new ArrayList();
   			 	arrValues.add(Helper.convertSetupToApplicationValues(strValuesin,Double.parseDouble(Helper.correctDouble(strDrawingpower))));
   			    arrValues.add(strDueDate);
   			    arrValues.add(Helper.convertSetupToApplicationValues(strValuesin,dblOutstanding));
   			    arrValues.add(Helper.correctDouble(String.valueOf(dblTLExposure)));
   			 	arrValues.add(strFlag);
   			 	arrValues.add(strRatingcheck);
   			    arrValues.add(strAppno);
   			 	size+=1;
   			 	hshQueryValues.put("size",""+(size));
   			    if(strWhetherACOpening.equalsIgnoreCase("Y"))
   			    {
   			    	arrValues.add(strCbsACno);
   			    	hshQuery.put("strQueryId","updcomgcbankdirliab"); 
   			    }
   			    else
   			    {
   			    	if(!strPrefix.equalsIgnoreCase("")&& !strSuffix.equalsIgnoreCase(""))
   			    	{
   			    		arrValues.add(strPrefix);
   			    		arrValues.add(strSuffix);
   			    		hshQuery.put("strQueryId","updcomgcbankindirliab"); 
   			    	}
   			    	else
   			    	{
   			    		arrValues.add(strCbsACno);
   	   			    	hshQuery.put("strQueryId","updcomgcbankdirliab"); 
   			    	}
   			    }
   			 	hshQuery.put("arrValues",arrValues);
   			 	hshQueryValues.put(""+(size),hshQuery);	
    		}
    		if(size>0){
    			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
    		}
			
			size=0;
			if(rs4 !=null) rs4.close();
			strQuery2 = SQLParser.getSqlQuery("sel_combanking_existingfac_sec^"+strAppno);
			rs4 = DBUtils.executeQuery(strQuery2);
    		while(rs4.next())
    		{
    			appno=Helper.correctNull((String) rs4.getString("combk_parentappno"));
    			str_facsno=Helper.correctNull((String) rs4.getString("combk_parentfacsno"));
    			if(!appno.equalsIgnoreCase(""))
    			{
    		strQuery2 = SQLParser.getSqlQuery("sel_appSecdetailsfacexisting^"+appno+"^"+str_facsno+"^P");
    		if(rs!=null) rs.close();
    		rs = DBUtils.executeQuery(strQuery2);
    		while(rs.next())
    		{
    			hshQuery = new HashMap();
    			 arrValues = new ArrayList();
    			size+=1;
    			hshQueryValues.put("size",""+(size));
				hshQuery.put("strQueryId","ins_securitydetailsrenew"); 
				arrValues.add(strAppno);
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_SECID")));
				arrValues.add(str_facsno);
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_CUSTOMERID")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_SECURITYVALUE")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_RESIDUALVALUE")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_FACTYPE")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_FACNATURE")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_SECURITYTYPE")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_LOANAMT")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_OUTSTANDAMT")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_UNSECPORTION")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_APPLICANT")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_MARGIN")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_FACID")));
				arrValues.add("E");
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_ISCOLLATERAL")));
				arrValues.add("");
				arrValues.add("A");
				arrValues.add("Y");
				arrValues.add("");
				//arrValues.add(Helper.correctNull((String)rs.getString("app_sec_borrower_id")));
				arrValues.add(oldLapsId);//In the case of gurantor's loan main borrower id will be stored to avoid that Applican't id is stored here.
				arrValues.add("E");
				arrValues.add(Helper.correctNull((String) rs4.getString("combk_parentappno")));
				arrValues.add(Helper.correctNull((String) rs4.getString("combk_parentfacsno")));
				arrValues.add(Helper.CLOBToString(rs.getClob("APP_SEC_DESCRIPTION")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_SHARECNT")));
				arrValues.add(Helper.correctNull(rs4.getString("combk_factype")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+(size),hshQuery);	
    		
    		}
    			}
    		}
    		strQuery2 = SQLParser.getSqlQuery("sel_comgroupconcerns_existingfac_sec^"+strAppno);
			rs4 = DBUtils.executeQuery(strQuery2);
    		while(rs4.next())
    		{
    			appno=Helper.correctNull((String) rs4.getString("comgc_parentappno"));
    			str_facsno=Helper.correctNull((String) rs4.getString("comgc_parentfacsno"));
    			if(!appno.equalsIgnoreCase(""))
    			{
    			if(rs!=null) rs.close();
    		strQuery2 = SQLParser.getSqlQuery("sel_appSecdetailsfacexisting^"+appno+"^"+str_facsno+"^P");
    		rs = DBUtils.executeQuery(strQuery2);
    		while(rs.next())
    		{
    			hshQuery = new HashMap();
    			 arrValues = new ArrayList();
    			size+=1;
    			hshQueryValues.put("size",""+(size));
				hshQuery.put("strQueryId","ins_securitydetailsrenew"); 
				arrValues.add(strAppno);
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_SECID")));
				arrValues.add(str_facsno);
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_CUSTOMERID")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_SECURITYVALUE")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_RESIDUALVALUE")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_FACTYPE")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_FACNATURE")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_SECURITYTYPE")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_LOANAMT")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_OUTSTANDAMT")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_UNSECPORTION")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_APPLICANT")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_MARGIN")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_FACID")));
				arrValues.add("E");
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_ISCOLLATERAL")));
				arrValues.add("");
				arrValues.add("A");
				arrValues.add("Y");
				arrValues.add("");
				arrValues.add(Helper.correctNull((String)rs.getString("app_sec_borrower_id")));
				arrValues.add("E");
				arrValues.add(Helper.correctNull((String) rs4.getString("comgc_parentappno")));
				arrValues.add(Helper.correctNull((String) rs4.getString("comgc_parentfacsno")));
				arrValues.add(Helper.CLOBToString(rs.getClob("APP_SEC_DESCRIPTION")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_SHARECNT")));
				arrValues.add(Helper.correctNull(rs4.getString("comgc_factype")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+(size),hshQuery);	
    		
    		}
    		}
    		}
    		if(size>0){
    		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");}
    		//strExp =strExp+"Existing Liabilities Has been Successfully pulled.";
		//	throw new Exception(strExp);
    		hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQueryValues=new HashMap();
			arrValues.add("Y");
			arrValues.add(strAppno);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","upd_PERAPPLICANT_freeze");//added by ganesan
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);
	  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
	  		
	  		String strFreeze="";
	  		if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("sel_applications_freeze_flag^"+strAppno);
    		rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				strFreeze = Helper.correctNull((String)rs.getString("app_freeze_flag"));
			}
			hshQuery.put("strFreeze",strFreeze);
			//exposure limit check for PAN check Except Gold Loan, Deposit Loan, Agriculture, SHG/JLG Borrowers begin 
			//checking limit amount 
			String sessionModuleType = correctNull((String) hshValues.get("sessionModuleType"));
			 double dblchecklimit = 0.0;
			 double dblchecklimit3 = 0.0;
			 String strQuery11="";
			 String strQuery12="";
			 
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
				hshQuery.put("strPanCheck", strPanCheck);
			}
			double dblExplimit = 0.0;
			if (!sessionModuleType.equalsIgnoreCase("AGR")) {
				
				dblExplimit = getExposureTotalLimit(strAppno, "R",sessionModuleType);

				hshQuery.put("strdblExplimit", jtn.format(dblExplimit));				
				if (dblExplimit>= dblchecklimit)
					hshQuery.put("strExplimitchk", "F");
				else
					hshQuery.put("strExplimitchk", "S");			
				
			}
			double dblExplimitagr = 0.0;
			if (sessionModuleType.equalsIgnoreCase("AGR")) {
				String strmainactcheck="";
				
				if (rs1 != null)
					rs1.close();

				strQuery2 = SQLParser
						.getSqlQuery("getmis_appdetailsagr^"+strAppno);
				rs1 = DBUtils.executeQuery(strQuery2);
				if (rs1.next()) {
					strmainactcheck = Helper.correctNull(rs1.getString("reccount"));					
					hshQuery.put("strmainactcheck", strmainactcheck);
				}
				if(strmainactcheck.equals("0"))
				{
					//08052023begin
					strQuery2 = SQLParser
							.getSqlQuery("getmis_appdetailsagrall^"+strAppno);
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
					/*strQuery12 = SQLParser.getSqlQuery("sel_lapsapplicationparameters^136");
					rs = DBUtils.executeQuery(strQuery12);
					if (rs.next()) {
						dblchecklimit = Double.parseDouble((String) Helper.correctDouble(rs.getString("LOAN_PARAMVAL")));
					}*/
				}
				
				dblExplimitagr = getExposureTotalLimitagri(strAppno, "R",strmainactcheck);

				hshQuery.put("strdblExplimitagr", jtn.format(dblExplimitagr));
				if (dblExplimitagr >= dblchecklimit)
					hshQuery.put("strExplimitagrchk", "F");
				else
					hshQuery.put("strExplimitagrchk", "S");
			}
			hshQuery.put("strChecklimit", jtn.format(dblchecklimit));
			if (rs != null)
				rs.close();
			int pancount=0;
			strQuery = SQLParser.getSqlQuery("sel_for_pandetails^" + strAppno+ "^" + strAppno+ "^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				if ((correctNull(rs.getString("PERAPP_PANNO")).equalsIgnoreCase("") || correctNull(rs.getString("PERAPP_PANNO")).equalsIgnoreCase("NOPAN")))
						{
							pancount++;
						}
				if(pancount>0)
				{
					hshQuery.put("Pancount", "N");
				}
				else
					hshQuery.put("Pancount", "Y");
				
			}
			
			//exposure limit check for PAN check Except Gold Loan, Depoist Loan, Agriculture, SHG/JLG Borrowers 
    	}
    	catch(final Exception ce)
		{
			throw new EJBException("Error in getFreezeData : "+ce.getMessage());
		}
		finally
		{
			try
			{
				if(rs!=null) rs.close();
				if(connectDB!=null) connectDB.close();
			}
			catch(Exception ce)
			{
				throw new EJBException("Error in closing connection : "+ce.getMessage());
						
			}
		}
		return hshQuery;
    
    }
	public void updateAgriProgramme(HashMap hshValues) 
	{

		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String appno=correctNull((String)hshValues.get("appno"));
		ResultSet rs=null;
		int intUpdatesize=0,maxsno=0,maxsno1=0;
		StringBuilder sbolddata=new StringBuilder();
		
		int intselyear = Integer.parseInt(Helper.correctInt((String)hshValues.get("sel_year")));
		double dblmaxYears=0;
		int intmaxyears=0;
		String strConsbl = Helper.correctDouble((String)hshValues.get("txt_consbankloan"));
		double totarea=0.00;
		double bankloan=0.00;
		double margin=0.00;
		String strScheme="",strfacsno="";
		
		java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
		nf.setGroupingUsed(false);
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
		try
		{
			strScheme = correctNull((String)hshValues.get("schemetype"));
			
			HashMap hshScheme = new HashMap();
			hshScheme = Helper.splitScheme(strScheme);
			
			if(hshScheme!=null)
			{
				strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
				strScheme = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
			}
			
			if(strAction.equalsIgnoreCase("insert"))
			{
				rs = DBUtils.executeLAPSQuery("selinterestamtforisub^"+appno+"^"+strScheme+"^"+strfacsno);
				if(rs.next())
				{
					dblmaxYears=Double.parseDouble((String)Helper.correctDouble(rs.getString("facility_months")));
					dblmaxYears=dblmaxYears/12;
					dblmaxYears=Math.ceil(dblmaxYears);
					intmaxyears=(int)dblmaxYears;
				}
				String str_yearcount=Helper.correctInt((String)hshValues.get("hidcount"));
				int j=Integer.parseInt(str_yearcount);
				String str_desc2=correctNull((String)hshValues.get("hiddesc2"));
				double amt2=Double.parseDouble(Helper.correctDouble((String)hshValues.get("hidamt2")));
				String str_avail=correctNull((String)hshValues.get("hidavail2"));
				
				rs = DBUtils.executeLAPSQuery("sel_max_agr_finprogramme^"+appno);
				if(rs.next()){
					maxsno = rs.getInt("afp_sno");
				}
				intUpdatesize+=1;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size",""+intUpdatesize);
				hshQuery.put("strQueryId","ins_agr_finprogramme");
				arrValues.add(appno);
				arrValues.add(String.valueOf(maxsno));   
				arrValues.add(correctNull((String)hshValues.get("sel_year"))); 
				arrValues.add(correctNull((String)hshValues.get("txt_activitycode"))); 
				arrValues.add(correctNull((String)hshValues.get("txt_unitcost"))); 
				arrValues.add(correctNull((String)hshValues.get("txt_area"))); 
				arrValues.add(correctNull((String)hshValues.get("txt_totalcost"))); 
				arrValues.add(correctNull((String)hshValues.get("txt_margin"))); 
				arrValues.add(correctNull((String)hshValues.get("txt_bankloan"))); 
				arrValues.add("0"); 
				arrValues.add(correctNull((String)hshValues.get("txt_unitadptcost"))); 
				arrValues.add(correctNull((String)hshValues.get("sel_units")));
				arrValues.add(correctNull((String)hshValues.get("txt_unitcostto")));
				arrValues.add(strScheme); //Scheme Type
				arrValues.add(""); //Page ID
				arrValues.add("");	//Plant sno
				arrValues.add(strfacsno);	// added Facility sno by subha
				arrValues.add(correctNull((String)hshValues.get("txt_spec")));
				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
				
				if(str_avail.equalsIgnoreCase("Y"))
				{ 
					int yrdiff = 0;
					intmaxyears=intmaxyears - intselyear;
					yrdiff=Math.min(intmaxyears, j);
					yrdiff++;
					//yrdiff=(j -  intselyear)+1;
					for(int h=1;h<yrdiff;h++)
					{
						/*rs = DBUtils.executeLAPSQuery("sel_max_agr_finprogramme^"+appno);
						if(rs.next()){
							maxsno1 = rs.getInt("afp_sno");
						}*/
						int c=Integer.parseInt(Helper.correctInt((String)hshValues.get("sel_year")))+(h);
						double adpcost=Double.parseDouble(Helper.correctDouble((String)hshValues.get("hidamt2")));
						margin=Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_margin")));
						
						double minamt=Math.min(amt2, adpcost);
						double area=Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_area")));
						totarea=minamt*area;
						bankloan=totarea-(totarea*margin)/100;
						intUpdatesize+=1;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size",""+intUpdatesize);
				hshQuery.put("strQueryId","ins_agr_finprogramme");
				arrValues.add(appno);
				arrValues.add(String.valueOf(c));   
				arrValues.add(""+c); 
				arrValues.add(str_desc2); 
				arrValues.add(""+amt2); 
				arrValues.add(correctNull((String)hshValues.get("txt_area"))); 
				arrValues.add(""+totarea); 
				arrValues.add(correctNull((String)hshValues.get("txt_margin"))); 
				arrValues.add(""+bankloan); 
				arrValues.add(String.valueOf(maxsno)); 
				arrValues.add(""+minamt); 
				arrValues.add(correctNull((String)hshValues.get("sel_units")));
				arrValues.add(""+minamt); 
				arrValues.add(strScheme); //Scheme Type
				arrValues.add(""); //Page ID
				arrValues.add("");	//Plant sno
				arrValues.add(strfacsno);	// added Facility sno by subha
				arrValues.add(correctNull((String)hshValues.get("txt_spec")));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
					}
				}
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("update"))
			{
				intUpdatesize+=1;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size",""+intUpdatesize);
				hshQuery.put("strQueryId","upd_agr_finprogramme");
				arrValues.add(correctNull((String)hshValues.get("sel_year"))); 
				arrValues.add(correctNull((String)hshValues.get("txt_activitycode"))); 
				arrValues.add(correctNull((String)hshValues.get("txt_unitcost"))); 
				arrValues.add(correctNull((String)hshValues.get("txt_area"))); 
				arrValues.add(correctNull((String)hshValues.get("txt_totalcost"))); 
				arrValues.add(correctNull((String)hshValues.get("txt_margin"))); 
				arrValues.add(correctNull((String)hshValues.get("txt_bankloan"))); 
				arrValues.add("0"); 
				arrValues.add(correctNull((String)hshValues.get("txt_unitadptcost"))); 
				arrValues.add(correctNull((String)hshValues.get("sel_units")));
				arrValues.add(correctNull((String)hshValues.get("txt_unitcostto"))); 
				arrValues.add(appno);
				arrValues.add(correctNull((String)hshValues.get("hidsno")));   
				arrValues.add(strScheme);  // added by Subha
				arrValues.add(strfacsno);  // addedd by Subha
				arrValues.add(correctNull((String)hshValues.get("txt_spec")));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				if(Helper.correctNull((String)hshValues.get("hidavail2")).equalsIgnoreCase("Y"))
				{
					totarea = 0.00;
					bankloan = 0.00;
					margin = 0.00;
					double totcost = 0.00;
					double unitcost = 0.00;
					
					String strhidsno = Helper.correctNull((String)hshValues.get("hidsno"));
					margin = Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_margin")));
					totarea = Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_area")));
					if(rs!=null)
					{
						rs.close();
					}
					rs = DBUtils.executeLAPSQuery("sel_staticfinprog^"+appno+"^"+strhidsno);
					if(rs.next())
					{
						unitcost = Double.parseDouble(Helper.correctDouble((String)rs.getString("afp_adpcost")));
					}
					totcost = (totarea * unitcost);
					bankloan=totcost-(totcost*margin)/100;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","upd_agr_finprogstaticdata");
					arrValues.add(correctNull((String)hshValues.get("txt_margin"))); 
					arrValues.add(nf.format(totcost));
					arrValues.add(nf.format(bankloan)); 
					arrValues.add(nf.format(totarea)); 
					arrValues.add(appno);
					arrValues.add(correctNull((String)hshValues.get("hidsno"))); 
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				
			
				if((!strConsbl.equalsIgnoreCase("")) ||(!strConsbl.equalsIgnoreCase("0.00")))
				{
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","del_agr_finprogbankloan");
					arrValues.add(strfacsno);
					arrValues.add(appno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1",hshQuery);
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","2");
					hshQuery.put("strQueryId","ins_agr_finprogbankloan");
					arrValues.add(appno);
					arrValues.add(Helper.correctDouble((String)hshValues.get("txt_consbankloan"))); 
					arrValues.add(strfacsno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("2",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_agr_finprogramme");
				arrValues.add(appno);
				arrValues.add(correctNull((String)hshValues.get("hidsno")));   
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1",hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","del_agr_finprogramme1");
				arrValues.add(appno);
				arrValues.add(correctNull((String)hshValues.get("hidsno")));   
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				if((!strConsbl.equalsIgnoreCase("")) ||(!strConsbl.equalsIgnoreCase("0.00")))
				{
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","del_agr_finprogbankloan");
					arrValues.add(strfacsno);
					arrValues.add(appno);
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
public HashMap getFinProgramme (HashMap hshValues)  {
		
		String strQuery="";
		ResultSet rs = null,rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rsbl=null;
		HashMap hshRecord = new HashMap();
		ArrayList arrVal = new ArrayList();
		ArrayList arrRow = new ArrayList();
		String str_parent="";
		String str_Sno="";
		String secid="",secname="",seccbssecurity="",seccollatflag="";
		String appno=correctNull((String)hshValues.get("appno"));
		double dblTotalBankLoan=0.00;
		double dblTotalProjectCost=0.00,dblTotalMargin=0.00;
		double dblconsbl=0.00;
		double dblconsmargin=0.00;
		String strYear="";
		String strFirstYearAvail="";
		String strSchemetype="";
		String strFacSno="";

		java.text.NumberFormat nf=java.text.NumberFormat.getNumberInstance();
		nf.setMaximumFractionDigits(2);
		nf.setGroupingUsed(false);
		try
		{	
			
			String schemetype = correctNull((String)hshValues.get("schemetype"));	
			strSchemetype=Helper.getfacilitySchemetype(schemetype);
			strFacSno=Helper.getfacilitySno(schemetype);
			
				int g=0;
				arrRow = new ArrayList();
				str_parent = "0";
				if(rs2!=null)
				{
					rs2.close();
				}
				strQuery = SQLParser.getSqlQuery("sel_distinctpfyears_facno^"+appno+"^"+strFacSno);
				rs5 = DBUtils.executeQuery(strQuery);
				while (rs5.next())
				{
				strYear=Helper.correctNull((String)rs5.getString("afp_year"));
				strQuery = SQLParser.getSqlQuery("sel_agr_finprogrammeyears_facno^"+appno+"^"+strYear+"^"+strSchemetype+"^"+strFacSno);
				rs2 = DBUtils.executeQuery(strQuery);
				while(rs2.next())
				{
					arrVal = new ArrayList();
					arrVal.add(correctNull(rs2.getString("afp_sno")));
					str_Sno = Helper.correctNull(rs2.getString("afp_sno"));
					arrVal.add(correctNull(rs2.getString("afp_year")));
					arrVal.add(correctNull(rs2.getString("afp_activityid")));
					arrVal.add(correctNull(rs2.getString("afp_costunit")));
					arrVal.add(correctNull(rs2.getString("afp_area")));
					arrVal.add(correctNull(rs2.getString("afp_totcost")));
					arrVal.add(correctNull(rs2.getString("afp_margin")));
					arrVal.add(correctNull(rs2.getString("afp_bankloan")));
					arrVal.add(correctNull(rs2.getString("afp_parent")));
					arrVal.add(correctNull(rs2.getString("afp_adpcost")));
					if((Helper.correctNull(rs2.getString("afp_parent")).equalsIgnoreCase("0")) && (!Helper.correctNull(rs2.getString("afp_activityid")).equalsIgnoreCase("")))
					{
					strQuery = SQLParser.getSqlQuery("sel_activitymasterdata_sno^"+correctNull(rs2.getString("afp_activityid")));
					rs3 = DBUtils.executeQuery(strQuery);
					if(rs3.next())
					{
						arrVal.add(correctNull(rs3.getString("ACT_DESC")));
						strFirstYearAvail=Helper.correctNull((String)rs3.getString("act_available"));
					}
					}
					else
					{
						arrVal.add(Helper.correctNull(rs2.getString("afp_activityid")));
					}
					arrVal.add("Year ");
					
					String strAreaId = Helper.correctNull(rs2.getString("afp_areaunit"));
					if(!strAreaId.equalsIgnoreCase(""))
					{
						if(rs!=null)
						{
							rs.close();
						}
						strQuery = SQLParser.getSqlQuery("sel_areadescbyid^"+"121"+"^"+strAreaId);
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							arrVal.add(Helper.correctNull(rs.getString("stat_data_desc1")));
						}
						else
						{
							arrVal.add("");
						}
					}
					arrVal.add(correctNull(rs2.getString("afp_areaunit")));
					arrVal.add(correctNull(rs2.getString("afp_costunitto")));
					arrVal.add(strFirstYearAvail);
					arrVal.add(correctNull(rs2.getString("agr_specifications")));
					arrRow.add(arrVal);
					
					dblTotalBankLoan=dblTotalBankLoan+Double.parseDouble((String)Helper.correctDouble((String)rs2.getString("afp_bankloan")));
					dblTotalProjectCost=dblTotalProjectCost+Double.parseDouble((String)Helper.correctDouble((String)rs2.getString("afp_totcost")));
					if(dblTotalBankLoan!=0.00)
					{
						dblTotalMargin= ((dblTotalBankLoan/dblTotalProjectCost)*100);
					}else{
						dblTotalMargin=0.00;
					}
					
				/*	if(rs4!=null)
					{
						rs4.close();
					}
					strQuery = SQLParser.getSqlQuery("sel_agr_finprogramme^"+appno+"^"+str_Sno);
					rs4 = DBUtils.executeQuery(strQuery);
					while(rs4.next())
					{
						arrVal = new ArrayList();
						arrVal.add(correctNull(rs4.getString("afp_sno")));
						arrVal.add(correctNull(rs4.getString("afp_year")));
						arrVal.add(correctNull(rs4.getString("afp_activityid")));
						arrVal.add(correctNull(rs4.getString("afp_costunit")));
						arrVal.add(correctNull(rs4.getString("afp_area")));
						arrVal.add(correctNull(rs4.getString("afp_totcost")));
						arrVal.add(correctNull(rs4.getString("afp_margin")));
						arrVal.add(correctNull(rs4.getString("afp_bankloan")));
						arrVal.add(correctNull(rs4.getString("afp_parent")));
						arrVal.add(correctNull(rs4.getString("afp_adpcost")));
						arrVal.add(Helper.correctNull(rs4.getString("afp_activityid")));
						arrVal.add("Year");
						String strAreaId1 = Helper.correctNull(rs2.getString("afp_areaunit"));
						if(!strAreaId1.equalsIgnoreCase(""))
						{
							if(rs!=null)
							{
								rs.close();
							}
							strQuery = SQLParser.getSqlQuery("sel_areadescbyid^"+"121"+"^"+strAreaId1);
							rs = DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								arrVal.add(Helper.correctNull(rs.getString("stat_data_desc1")));
							}
							else
							{
								arrVal.add("");
							}
						}
						arrVal.add(correctNull(rs2.getString("afp_areaunit")));
						arrVal.add(correctNull(rs4.getString("afp_costunit")));
						arrRow.add(arrVal);
						dblTotalBankLoan=dblTotalBankLoan+Double.parseDouble((String)Helper.correctDouble((String)rs4.getString("afp_bankloan")));
						dblTotalProjectCost=dblTotalProjectCost+Double.parseDouble((String)Helper.correctDouble((String)rs4.getString("afp_totcost")));
						if(dblTotalProjectCost!=0||dblTotalProjectCost!=0.00)
						dblTotalMargin= ((dblTotalBankLoan/dblTotalProjectCost)*100);
					}*/
				
					
				}
		}
				hshRecord.put("arrRow",arrRow);
					
				
			dblTotalMargin=100-dblTotalMargin;
			hshRecord.put("count","1");
			hshRecord.put("totalbankloan",nf.format(dblTotalBankLoan));
			hshRecord.put("totalprojectcost",nf.format(dblTotalProjectCost));
			hshRecord.put("totalmarg",nf.format(dblTotalMargin));
			
			
			if(rsbl!=null)
			{
				rsbl.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_agr_finprogbankloan^"+strFacSno+"^"+appno);
			rsbl = DBUtils.executeQuery(strQuery);
			if(rsbl.next())
			{
				dblconsbl = Double.parseDouble(Helper.checkDecimal(Helper.correctDouble((String)rsbl.getString("afp_consbankloan"))));
			}
			if(dblconsbl!=0.00 && dblTotalProjectCost!=0.00)
			{
				dblconsbl=dblconsbl;
				dblTotalProjectCost = dblTotalProjectCost;
			}
			else
			{
				dblconsbl=0.00;
				dblTotalProjectCost = 1;
			}
			dblconsmargin= ((dblconsbl/dblTotalProjectCost)*100); 
			dblconsmargin = (100-dblconsmargin);
			hshRecord.put("consbl",nf.format(dblconsbl));
			hshRecord.put("consmargin",nf.format(dblconsmargin));
			
			// Commented By Arsath as per the New Requirements
				
	/*		{
				if(rs!=null){
					rs.close();
				}
				g+=1;
				arrRow = new ArrayList();
				str_parent=correctNull(rs1.getString("afp_parent"));
		
			if(rs3!=null)
			{
				rs3.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_agr_finprogramme^"+appno+"^"+str_parent);
			rs3 = DBUtils.executeQuery(strQuery);
			while(rs3.next())
			{
				
		strQuery = SQLParser.getSqlQuery("sel_agr_finprogramme^"+appno+"^"+str_parent);
			rs = DBUtils.executeQuery(strQuery);
		while(rs.next())
			{
				arrVal = new ArrayList();
				arrVal.add(correctNull(rs.getString("afp_sno")));
				arrVal.add(correctNull(rs.getString("afp_year")));
				arrVal.add(correctNull(rs.getString("afp_activityid")));
				arrVal.add(correctNull(rs.getString("afp_costunit")));
				arrVal.add(correctNull(rs.getString("afp_area")));
			arrVal.add(correctNull(rs.getString("afp_totcost")));
				arrVal.add(correctNull(rs.getString("afp_margin")));
				arrVal.add(correctNull(rs.getString("afp_bankloan")));
				arrVal.add(correctNull(rs.getString("afp_parent")));
				arrVal.add(correctNull(rs.getString("afp_adpcost")));
				
				if(Helper.correctNull(rs.getString("afp_parent")).equalsIgnoreCase("0"))
				{
				strQuery = SQLParser.getSqlQuery("sel_activitymasterdata_sno^"+correctNull(rs.getString("afp_activityid")));
				rs2 = DBUtils.executeQuery(strQuery);
				if(rs2.next())
				{
					arrVal.add(correctNull(rs2.getString("ACT_DESC")));
				}
			}
				else
				{
					arrVal.add(Helper.correctNull(rs.getString("afp_activityid")));
				}
				if(rs2!=null){
					rs2.close();
				}
				arrVal.add("Year ");
				arrRow.add(arrVal);
				dblTotalBankLoan=dblTotalBankLoan+Double.parseDouble((String)Helper.correctDouble((String)rs.getString("afp_bankloan")));
				dblTotalProjectCost=dblTotalProjectCost+Double.parseDouble((String)Helper.correctDouble((String)rs.getString("afp_totcost")));
				dblTotalMargin=dblTotalMargin+Double.parseDouble((String)Helper.correctDouble((String)rs.getString("afp_margin")));
			}
			hshRecord.put("arrRow"+(g),arrRow);
			hshRecord.put("count",""+(g));
			hshRecord.put("totalbankloan",nf.format(dblTotalBankLoan));
			hshRecord.put("totalprojectcost",nf.format(dblTotalProjectCost));
			hshRecord.put("totalmarg",nf.format(dblTotalMargin));
			
			}
			if(rs!=null){
				rs.close();
			}
			if(rs1!=null){
				rs1.close();
			}
			if(rs2!=null){
				rs2.close();
			}
			}	*/	
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getFinProgramme "+ce.toString());
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
				if(rs2!=null)
				{
					rs2.close();
				}
				if(rs3!=null)
				{
					rs3.close();
				}
				if(rs4!=null)
				{
					rs4.close();
				}
				if(rsbl!=null)
				{
					rsbl.close();
				}
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		
		return hshRecord;
	}



	/**
	 * Author : M. Arsath Ayub
	 * Date : 12/02/2014
	 * @param hshValues
	 * @return
	 * @
	 */
	private int getMaxIncExpId(String appno,String strGrid)
	{
		ResultSet rs = null;
		int termId = 0;
	
		try
		{
			
			rs=DBUtils.executeLAPSQuery("sel_maxIncExp^"+appno);
			if(rs.next())
			{
			    if(strGrid.equalsIgnoreCase("GET"))
			    {
			    	termId = Integer.parseInt(Helper.correctInt((String)rs.getString("agr_gridsno")));
				}
			    else
			    {
			    	termId = Integer.parseInt(Helper.correctInt((String)rs.getString("agr_gridsno")))+1;
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
	


	public void updateExsincotherthancrop(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String appno=correctNull((String)hshValues.get("appno"));
		ResultSet rs=null;
		int intUpdatesize=0;
		int arrSize = Integer.parseInt(Helper.correctInt((String)hshValues.get("hidtenor")));
		String[] Incdet = new String [arrSize];
		String[] Expdet = new String [arrSize];
		String[] Totdet = new String [arrSize];
		
		if(hshValues.get("txt_inc") instanceof java.lang.String)
		{
			Incdet=new String[1];
			Incdet[0]=Helper.correctNull((String)hshValues.get("txt_inc"));	
		}
		else
		{
		Incdet = (String[]) hshValues.get("txt_inc");
		}
		
		if(hshValues.get("txt_exp") instanceof java.lang.String)
		{
			Expdet=new String[1];
			Expdet[0]=Helper.correctNull((String)hshValues.get("txt_exp"));	
		}
		else
		{
			Expdet=(String[]) hshValues.get("txt_exp");
		}
		
		if(hshValues.get("txt_tot") instanceof java.lang.String)
		{
			Totdet=new String[1];
			Totdet[0]=Helper.correctNull((String)hshValues.get("txt_tot"));	
		}
		else
		{
			Totdet=(String[]) hshValues.get("txt_tot");
		}	
		
		String strIncPart = Helper.correctNull((String)hshValues.get("txt_income"));
		String strExpPart = Helper.correctNull((String)hshValues.get("txt_expense"));
		int intGridMaxid = 0,intDataMaxid=0,intDataSno=0;
		String strGrid = "UPD";
		try
		{
		
			if(strAction.equalsIgnoreCase("insert"))
			{
			intGridMaxid = getMaxIncExpId(appno,strGrid);
			for(int i=0;i<Incdet.length;i++)
			{
			intDataMaxid++;
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQueryValues.put("size","1");
			hshQuery.put("strQueryId","ins_exisincexp");
			arrValues.add(appno);
			arrValues.add(String.valueOf(intGridMaxid));
			arrValues.add(String.valueOf(intDataMaxid));
			arrValues.add(strIncPart);
			arrValues.add(strExpPart);
			arrValues.add(Incdet[i]);
			arrValues.add(Expdet[i]);
			arrValues.add(Totdet[i]);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			}
				
			else if(strAction.equalsIgnoreCase("update"))
			{
				for(int i=0;i<Incdet.length;i++)
				{
				intDataSno++;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","upd_exisincexp");
				arrValues.add(strIncPart);
				arrValues.add(strExpPart);
				arrValues.add(Incdet[i]);
				arrValues.add(Expdet[i]);
				arrValues.add(Totdet[i]);
				arrValues.add(appno);
				arrValues.add(Helper.correctNull((String)hshValues.get("hidgridno")));
				arrValues.add(String.valueOf(intDataSno));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_exisincexp");
				arrValues.add(appno);
				arrValues.add(Helper.correctNull((String)hshValues.get("hidgridno")));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1",hshQuery);
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
	public HashMap getExsincotherthancrop(HashMap hshValues) 
	{
		ResultSet rs = null,rs1=null,rs2=null,rs3=null;
		HashMap hshRecord = new HashMap();
		String strAppno="",strQuery="";
		HashMap hshResult=new HashMap();
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol = new ArrayList();
		ArrayList arrValues = new ArrayList();
		int intTenor = Integer.parseInt(Helper.correctInt((String)hshValues.get("hidtenor")));
		int intGridMaxid = 0;
		String strGrid = "GET";
		String strPage = Helper.correctNull((String)hshValues.get("varpage"));
		String strGridid = Helper.correctNull((String)hshValues.get("gridid"));
		try
		{
			strAppno=Helper.correctNull((String)hshValues.get("appno"));
			if(strPage.equalsIgnoreCase("iframe"))
			{
				if(rs2!=null)
	    		{
	    			rs2.close();
	    		}
	    		strQuery=SQLParser.getSqlQuery("sel_exisincexp^"+strAppno+"^"+strGridid);
	    		rs2=DBUtils.executeQuery(strQuery);
	    		//arrCol = new ArrayList();
	    		while(rs2.next())
	    		{
	    			arrCol = new ArrayList();
	    			arrCol.add(Helper.correctNull((String)rs2.getString("agr_gridsno")));
	    			arrCol.add(Helper.correctNull((String)rs2.getString("agr_datasno")));
	    			arrCol.add(Helper.correctNull((String)rs2.getString("agr_incpart")));
	    			arrCol.add(Helper.correctNull((String)rs2.getString("agr_exppart")));
	    			arrCol.add(Helper.correctNull((String)rs2.getString("agr_inc")));
	    			arrCol.add(Helper.correctNull((String)rs2.getString("agr_exp")));
	    			arrCol.add(Helper.correctNull((String)rs2.getString("agr_incexptot")));
	    			arrRow.add(arrCol);
	    		}
	    		hshRecord.put("arrRow",arrRow);
			}
			else
			{
			if(rs!=null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("sel_tenorforfinyear^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				double dblTenor = Double.parseDouble(Helper.correctDouble((String)rs.getString("facility_months")));
				double dblTenortot = dblTenor/12;
				int Tonar = 0;
				dblTenortot = dblTenor/12;
				dblTenortot = Math.ceil(dblTenortot);
				Tonar = (int)dblTenortot;
				hshRecord.put("Tenor",String.valueOf(Tonar));
			}
			intGridMaxid = getMaxIncExpId(strAppno,strGrid);
			
			
			
			for(int i=1;i<=intGridMaxid;i++)
			{
			
			if(rs1!=null)
			{
				rs1.close();
			}
			strQuery=SQLParser.getSqlQuery("sel_exisincexp^"+strAppno+"^"+String.valueOf(i));
			rs1=DBUtils.executeQuery(strQuery);
			//arrCol = new ArrayList();
			while(rs1.next())
			{
				arrCol = new ArrayList();
				arrCol.add(Helper.correctNull((String)rs1.getString("agr_gridsno")));
				arrCol.add(Helper.correctNull((String)rs1.getString("agr_datasno")));
				arrCol.add(Helper.correctNull((String)rs1.getString("agr_incpart")));
				arrCol.add(Helper.correctNull((String)rs1.getString("agr_exppart")));
				arrCol.add(Helper.correctNull((String)rs1.getString("agr_inc")));
				arrCol.add(Helper.correctNull((String)rs1.getString("agr_exp")));
				arrCol.add(Helper.correctNull((String)rs1.getString("agr_incexptot")));
				arrRow.add(arrCol);
			}
			arrValues.add(arrRow);
			arrRow = new ArrayList();
			hshRecord.put("totvalues",arrValues);
			}
			}
			
			if(rs3!=null)
			{
				rs3.close();
			}
			strQuery=SQLParser.getSqlQuery("sel_retailcomments^"+strAppno+"^"+"EXISINCOTRTHANCROP");
			rs3=DBUtils.executeQuery(strQuery);
			if(rs3.next())
			{
				hshRecord.put("comments", Helper.correctNull(Helper.CLOBToString(rs3.getClob("cmt_comments"))));
			}
		
			
			
		}
		catch(final Exception ce)
		{
			throw new EJBException("Error in getFreezeData : "+ce.getMessage());
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
				if(rs2!=null) 
				{
					rs2.close();
				}
				if(rs3!=null) 
				{
					rs3.close();
				}
			}
			catch(Exception ce)
			{
				throw new EJBException("Error in closing connection : "+ce.getMessage());
						
			}
		}
	   
		return hshRecord;
	}   
	/**
	 * End of M. Arsath Ayub
	 */
	
	/*** Added by DINESH for Securities Attach Freeze on 17/02/2014 ***/
	
    public HashMap getSecCollateralCoverageRetail(HashMap hshValues) 
    {
    	HashMap hshResult =new HashMap();
    	HashMap hshRecord =new HashMap();
    	String strQuery1="",str_sec_id="",strsecid="",str_sec_temp_id="",strfacsno="";
    	ResultSet rs1=null,rs=null,rs2=null;
    	ArrayList arrCol=new ArrayList();
    	ArrayList arrRow=new ArrayList();
    	ArrayList arrSecrow=new ArrayList();
    	ArrayList arrSeccol=new ArrayList();
    	ArrayList arrGrpexpRow=new ArrayList();
    	ArrayList arrGrpexpCol=new ArrayList();
    	ArrayList arrGrpSecrow=new ArrayList();
    	ArrayList arrGrpSeccol=new ArrayList();
    	ArrayList arrExprow=new ArrayList();
    	ArrayList arrExpcol=new ArrayList();
    	double dbl_outstanding[]=new double[10];
    	double dbl_residual[]=new double[10];
    	double dbl_residualfac=0,dbl_outstandingamt=0,dbl_outstandingtemp=0,dbl_outstandingtemp1=0,dbl_residualfinal=0,dblmargin=0,dbl_outstandingamtwithmargin=0;
    	int y=0;
    	boolean flag=false;
    	HashMap hshQuery=new HashMap();
    	ArrayList arrValues=new ArrayList();
    	HashMap hshQueryValues=new HashMap();
    	String strPrcode="",strprdPurpose="",strprdType="";
		String strDob="",strSysDate="";
		double dbstrSecValue=0.00,dbstrMarginAmount=0.00,dbstrcostofproject=0.00;
		String strSecType="";
		int agYearNsckvp=0,agYearNsckvpother=0;
		String strLesser = ">=";
		String strGreater = "<=";
		String strQuery="",strMargNscKvp="",strOthersmargin="";
		double dbNewOutstandingAmount=0.00,dbNewCollateralAmount=0.00;  
		double dbnsckvpmarg=0.00,dbothermargin=0.00;
    	String strValuesIn=Helper.correctNull((String)hshValues.get("valuesin"));
    	java.text.NumberFormat nft= java.text.NumberFormat.getInstance();
    	if(strValuesIn.equalsIgnoreCase("L"))
		{
    		nft= java.text.NumberFormat.getInstance();
    		nft.setMaximumFractionDigits(2);
    		nft.setMinimumFractionDigits(2);
		}
		if(strValuesIn.equalsIgnoreCase("C"))
		{
			nft= java.text.NumberFormat.getInstance();
			nft.setMaximumFractionDigits(2);
			nft.setMinimumFractionDigits(2);
		}
		if(strValuesIn.equalsIgnoreCase("R"))
		{
			nft= java.text.NumberFormat.getInstance();
			nft.setMaximumFractionDigits(2);
			nft.setMinimumFractionDigits(2);
		}
		try
    	{
    		String appno=Helper.correctNull((String)hshValues.get("appno"));
    		String strappId = Helper.correctNull((String)hshValues.get("hidapplicantid"));
    		String strAction = Helper.correctNull((String)hshValues.get("hidAction"));
    		strSysDate=Helper.getCurrentDateTime();
    		
    		
    		strQuery1 = SQLParser.getSqlQuery("sel_appSecdetailsfacsno^"+appno+"^P");
    		rs = DBUtils.executeQuery(strQuery1);
    		while(rs.next())
	    		{
	    			strsecid=Helper.correctNull(rs.getString("app_sec_secid"));
		    		strQuery1 = SQLParser.getSqlQuery("sel_appSecdetailsfac^"+appno+"^"+strsecid+"^P^ and app_sec_facsno!=0 ");
		    		rs1 = DBUtils.executeQuery(strQuery1);
		    		while(rs1.next())
		    		{
		    			if(strfacsno.equalsIgnoreCase(Helper.correctNull(rs1.getString("APP_SEC_FACSNO"))))
		    			{
		    				dbl_outstandingamt=dbl_outstandingtemp1;
		       			 
		    			}
		    			else
		    			{
		    				dbl_outstandingamt=Double.parseDouble(Helper.correctDouble(rs1.getString("app_sec_outstandamt")));
		       			 
		    			}
		    			strfacsno=Helper.correctNull(rs1.getString("APP_SEC_FACSNO"));
		    			
		    			 str_sec_id = Helper.correctNull(rs1.getString("app_sec_secid"));
		    			 if(str_sec_temp_id.equalsIgnoreCase(str_sec_id))
		    			 {
		    				 dbl_residualfac=dbl_outstandingtemp;
		    			 }
		    			 else
		    			 {
		    			 dbl_residualfac=Double.parseDouble(Helper.correctDouble(rs1.getString("app_sec_securityvalue")));
		    			 }
		    			 dblmargin=Double.parseDouble(Helper.correctDouble(rs1.getString("app_sec_margin")));
		    			 
		    			 dbl_outstandingamtwithmargin=(dbl_outstandingamt*dblmargin)/100;
		    				 
		    			 dbl_outstandingtemp=dbl_residualfac-(dbl_outstandingamt +dbl_outstandingamtwithmargin);
		    			 dbl_outstandingtemp1=dbl_residualfac- (dbl_outstandingamt+dbl_outstandingamtwithmargin);
		    			
		    			 if(dbl_outstandingtemp<=0)
		    			 {
		    				 dbl_outstandingtemp1*=-1D;
		    				 dbl_outstandingtemp=0;
		    			 }
		    			// if(!str_sec_temp_id.equalsIgnoreCase(str_sec_id)|| rs1.isLast())
		    			 {
		    				 	/*hshQueryValues=new HashMap();
		    				 	hshQuery=new HashMap();
		    					arrValues=new ArrayList();
		    					arrValues.add(""+dbl_outstandingtemp);
		    					arrValues.add(appno);
		    					arrValues.add(str_sec_id);
		    					arrValues.add(strfacsno);
		    					hshQuery.put("arrValues",arrValues);
		    					hshQuery.put("strQueryId","upd_app_securitydetailsfac");
		    					hshQueryValues.put("size","1");
		    					hshQueryValues.put("1",hshQuery);
		    					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");*/
		    				    hshQueryValues=new HashMap();
		    					hshQuery=new HashMap();
		    					arrValues=new ArrayList();
		    					arrValues.add(""+dbl_outstandingtemp);
		    					arrValues.add(str_sec_id);
		    					hshQuery.put("arrValues",arrValues);
		    					hshQuery.put("strQueryId","upd_cus_securitiessec");
		    					hshQueryValues.put("size","1");
		    					hshQueryValues.put("1",hshQuery);
		    					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
		    					str_sec_temp_id=str_sec_id;
		    			 	}
		    			}
	    			}
    		if(rs!=null)
    		{
    			rs.close();
    		}
    		strQuery1 = SQLParser.getSqlQuery("sel_appSecdetailsdistfac^"+appno+"^P^> ^ ");
    		rs = DBUtils.executeQuery(strQuery1);
    		while(rs.next())
	    		{
    			arrValues=new ArrayList();
    			arrValues.add(Helper.correctNull(rs.getString("cus_sec_netsecurity")));
    			arrValues.add(Helper.correctNull(rs.getString("app_sec_secid")));
				arrRow.add(arrValues);
	    		}
    		strfacsno="";dbl_outstandingamt=0;dbl_outstandingtemp=0;dbl_residualfac=0;
    		arrValues=new ArrayList();
    		if(arrRow!=null && arrRow.size()>0)
    		{
    			strQuery1 = SQLParser.getSqlQuery("sel_appSecdetailsfacsno^"+appno+"^E");
        		rs = DBUtils.executeQuery(strQuery1);
        		while(rs.next())
        		{
        			strsecid=Helper.correctNull(rs.getString("app_sec_secid"));
        		strQuery1 = SQLParser.getSqlQuery("sel_appSecdetailsfac^"+appno+"^"+strsecid+"^E^ and app_sec_facsno!=0 ");
        		rs1 = DBUtils.executeQuery(strQuery1);
        		while(rs1.next())
        		{
        			if(strfacsno.equalsIgnoreCase(Helper.correctNull(rs1.getString("APP_SEC_FACSNO"))))
        			{
        				dbl_outstandingamt=dbl_outstandingtemp1;
           			}
        			else
        			{
        				dbl_outstandingamt=Double.parseDouble(Helper.correctDouble(rs1.getString("app_sec_outstandamt")));
           			 
        			}
        			strfacsno=Helper.correctNull(rs1.getString("APP_SEC_FACSNO"));
        			
        			 str_sec_id = Helper.correctNull(rs1.getString("app_sec_secid"));
        			 if(str_sec_temp_id.equalsIgnoreCase(str_sec_id))
        			 {
        				 dbl_residualfac=dbl_outstandingtemp;
        			 }
        			 else
        			 {
        			 dbl_residualfac=Double.parseDouble(Helper.correctDouble(rs1.getString("app_sec_securityvalue")));
        			 }
        			 dblmargin=Double.parseDouble(Helper.correctDouble(rs1.getString("app_sec_margin")));
	    			 
	    			 dbl_outstandingamtwithmargin=(dbl_outstandingamt*dblmargin)/100;
	    				 
	    			 dbl_outstandingtemp=dbl_residualfac-(dbl_outstandingamt +dbl_outstandingamtwithmargin);
	    			 dbl_outstandingtemp1=dbl_residualfac- (dbl_outstandingamt+dbl_outstandingamtwithmargin);
	    			
        			
        			 if(dbl_outstandingtemp<0)
        			 {
        				 dbl_outstandingtemp1*=-1D;
        				 dbl_outstandingtemp=0;
        				
        			 }
        			 hshQueryValues=new HashMap();
  					hshQuery=new HashMap();
  					arrValues=new ArrayList();
  					arrValues.add(""+dbl_outstandingtemp);
  					arrValues.add(appno);
  					arrValues.add(strfacsno);
  					arrValues.add(str_sec_id);
  					hshQuery.put("arrValues",arrValues);
  					hshQuery.put("strQueryId","upd_app_securitydetailsexisting");
  					hshQueryValues.put("size","1");
  					hshQueryValues.put("1",hshQuery);
  					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
  					
        			hshQueryValues=new HashMap();
 					hshQuery=new HashMap();
 					arrValues=new ArrayList();
 					arrValues.add(""+dbl_outstandingtemp);
 					arrValues.add(str_sec_id);
 					hshQuery.put("arrValues",arrValues);
 					hshQuery.put("strQueryId","upd_cus_securitiessec");
 					hshQueryValues.put("size","1");
 					hshQueryValues.put("1",hshQuery);
 					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
 					str_sec_temp_id=str_sec_id;
        		}
        		}
        		if(rs!=null)
        		{
        			rs.close();
        		}
        		strfacsno=""; //Doubt in the following query 
        		strQuery1 = SQLParser.getSqlQuery("sel_appSecdetailsdistfac^"+appno+"^E^<= ^ and app_sec_iscollateral='Y'");
        		rs = DBUtils.executeQuery(strQuery1);
        		while(rs.next())
    	    		{
        			if(!strfacsno.equalsIgnoreCase(Helper.correctNull(rs.getString("app_sec_facsno"))))
        			{
        			arrValues=new ArrayList();
        			arrValues.add(Helper.correctNull(rs.getString("APP_SEC_OUTSTANDAMT")));
        			arrValues.add(Helper.correctNull(rs.getString("app_sec_secid")));
        			arrCol.add(arrValues);
        			strfacsno=Helper.correctNull(rs.getString("app_sec_facsno"));
        			}
    	    		}
        		arrValues=new ArrayList();
        		flag=false;
        		if(arrCol!=null && arrCol.size()>0)
        		{
        			if(arrRow!=null && arrRow.size()>0)
            		{
        				for(int j=0;j<arrRow.size();j++)
            			{
	        					ArrayList arr=(ArrayList)arrRow.get(j);
	            				double dbl_outstandingvalue =Double.parseDouble(Helper.correctDouble((String)arr.get(0)));
			        			for(int i=0;i<arrCol.size();i++)
			        			{
				        				ArrayList arrVal=(ArrayList)arrCol.get(i);
				        				double dbl_outstandingval=Double.parseDouble(Helper.correctDouble((String)arrVal.get(0)));
				        				if(dbl_outstandingval>=0)
				        				{
					        					flag=true;
					        					dbl_residualfinal=dbl_outstandingval-dbl_outstandingvalue;
					        					if(dbl_residualfinal<0)dbl_residualfinal*=-1D;
				        				}
			        			}
			        			if(flag)
			        			{
			        				 hshQueryValues=new HashMap();
			       					hshQuery=new HashMap();
			       					arrValues=new ArrayList();
			       					arrValues.add(""+dbl_residualfinal);
			       					arrValues.add(appno);
			       					arrValues.add(strfacsno);
			       					arrValues.add(str_sec_id);
			       					hshQuery.put("arrValues",arrValues);
			       					hshQuery.put("strQueryId","upd_app_securitydetailsexisting");
			       					hshQueryValues.put("size","1");
			       					hshQueryValues.put("1",hshQuery);
			       					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			       					
				        			 hshQueryValues=new HashMap();
				 					hshQuery=new HashMap();
				 					arrValues=new ArrayList();
				 					arrValues.add(""+dbl_residualfinal);
				 					arrValues.add(Helper.correctDouble((String)arr.get(1)));
				 					hshQuery.put("arrValues",arrValues);
				 					hshQuery.put("strQueryId","upd_cus_securitiessec");
				 					hshQueryValues.put("size","1");
				 					hshQueryValues.put("1",hshQuery);
				 					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				 					flag=false;
			            		}
			            	}
            			}
        			}
    			} 
    		/*
    		 * 
    		 *  In the below query remove the condition "P". Because all the collateral to be taken and to be adjusted to the existing / proposed loans
    		 *  First existing collateral to be adjusted, then proposed. The order of taking collateral of existing should be based on priority given in that loan.
    		 *  So while liabilities pulling itself need to put the priority by pulling from the existing loans. Also need to put a entry that
    		 */
    		
    		double dbl_collateralsum=0,dbl_facsumamt=0,dbl_collateralsumtmp=0;
    		strQuery1 = SQLParser.getSqlQuery("sel_appSecdetailsfaccoll^"+appno+"^P^ and app_sec_facsno=0 ");
    		rs1 = DBUtils.executeQuery(strQuery1);
    		while(rs1.next())
    		{
    			str_sec_id=Helper.correctNull(rs1.getString("app_sec_secid"));
    			dbl_collateralsum=Double.parseDouble(Helper.correctDouble(rs1.getString("cus_sec_netsecurity")));
    			dbl_collateralsumtmp=Double.parseDouble(Helper.correctDouble(rs1.getString("cus_sec_netsecurity")));
    			dbNewCollateralAmount=dbNewCollateralAmount+dbl_collateralsum;
    			strQuery1 = SQLParser.getSqlQuery("sel_appSecdetailsfacsumcol^"+appno+"^E^ and app_sec_facsno!=0 ");
        		rs = DBUtils.executeQuery(strQuery1);
        		while(rs.next())
        		{
        			dbl_facsumamt=Double.parseDouble(Helper.correctDouble(rs.getString("app_sec_outstandamt")));
        			
        			dbNewOutstandingAmount=dbNewOutstandingAmount+dbl_facsumamt;        			
        			 dbl_collateralsum=dbl_facsumamt-dbl_collateralsum;
        			if((dbl_collateralsum)>0)
            		{
        					hshQueryValues=new HashMap();
		 					hshQuery=new HashMap();
		 					arrValues=new ArrayList();
		 					arrValues.add("0");
		 					arrValues.add(str_sec_id);
		 					hshQuery.put("arrValues",arrValues);
		 					hshQuery.put("strQueryId","upd_cus_securitiessec");
		 					hshQueryValues.put("size","1");
		 					hshQueryValues.put("1",hshQuery);
		 					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
            		}
        			if(dbl_collateralsum<0)
        			{
        				dbl_collateralsum*=-1D;
        				hshQueryValues=new HashMap();
	 					hshQuery=new HashMap();
	 					arrValues=new ArrayList();
	 					arrValues.add(""+dbl_collateralsum);
	 					arrValues.add(str_sec_id);
	 					hshQuery.put("arrValues",arrValues);
	 					hshQuery.put("strQueryId","upd_cus_securitiessec");
	 					hshQueryValues.put("size","1");
	 					hshQueryValues.put("1",hshQuery);
	 					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
        			} 
        			
        		}
    		}    		      			
    		double dbl_collvalue=0;
    		rs = DBUtils.executeLAPSQuery("pergetloanProduct^" + appno);
    		if(rs.next())
    		{
    			dbl_collvalue=Double.parseDouble(Helper.correctDouble(rs.getString("LOAN_SECURITYCOLLATERAL")));
    		}
    		if(rs!=null)
    		{
    			rs.close();
    		}
    		dbl_collateralsum=0;dbl_facsumamt=0;dbl_collateralsumtmp=0;
    		strQuery1 = SQLParser.getSqlQuery("sel_appSecdetailsfaccoll^"+appno+"^P^ and app_sec_facsno=0 ");
    		rs1 = DBUtils.executeQuery(strQuery1);
    		while(rs1.next())
    		{
    			str_sec_id=Helper.correctNull(rs1.getString("app_sec_secid"));
    			dbl_collateralsum=Double.parseDouble(Helper.correctDouble(rs1.getString("cus_sec_netsecurity")));
    			dbl_collateralsumtmp=Double.parseDouble(Helper.correctDouble(rs1.getString("cus_sec_netsecurity")));
    			strQuery1 = SQLParser.getSqlQuery("sel_appSecdetailsfacsumcol^"+appno+"^P^ and app_sec_facsno!=0 ");
        		rs = DBUtils.executeQuery(strQuery1);
        		while(rs.next())
        		{
        			dbl_facsumamt=Double.parseDouble(Helper.correctDouble(rs.getString("app_sec_outstandamt")));
        			dbl_facsumamt=(dbl_facsumamt*dbl_collvalue)/100;
        			dbl_collateralsum=dbl_facsumamt-dbl_collateralsum;
        			dbNewOutstandingAmount=dbl_collateralsum;
        			if((dbl_collateralsum)>0)
            		{
        					hshQueryValues=new HashMap();
		 					hshQuery=new HashMap();
		 					arrValues=new ArrayList();
		 					arrValues.add("0");
		 					arrValues.add(str_sec_id);
		 					hshQuery.put("arrValues",arrValues);
		 					hshQuery.put("strQueryId","upd_cus_securitiessec");
		 					hshQueryValues.put("size","1");
		 					hshQueryValues.put("1",hshQuery);
		 					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
            		}
        			if(dbl_collateralsum<0)
        			{
        				dbl_collateralsum*=-1D;
        				hshQueryValues=new HashMap();
	 					hshQuery=new HashMap();
	 					arrValues=new ArrayList();
	 					arrValues.add(""+dbl_collateralsum);
	 					arrValues.add(str_sec_id);
	 					hshQuery.put("arrValues",arrValues);
	 					hshQuery.put("strQueryId","upd_cus_securitiessec");
	 					hshQueryValues.put("size","1");
	 					hshQueryValues.put("1",hshQuery);
	 					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
        			}
        		}
    		}
    		
	    		
    			getcollValueSecurityfreeze(hshValues);

	    		  //Added by bhaskar to calculate sec ratio and to adjust to existing loans
				if(dbNewOutstandingAmount>dbNewCollateralAmount)
				{
					   hshQueryValues=new HashMap();
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						arrValues.add("0.00");
						arrValues.add(appno);
						hshQuery.put("arrValues",arrValues);
						hshQuery.put("strQueryId","upd_apploanamtsec_ratio");
						hshQueryValues.put("size","1");
						hshQueryValues.put("1",hshQuery);
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");        				
					
				}
				else if(dbNewOutstandingAmount<dbNewCollateralAmount)
				{
					double dbl_collateralsum1=dbNewCollateralAmount-dbNewOutstandingAmount;
					double dbLoanAmntReq=0.00;
					rs2=DBUtils.executeLAPSQuery("selloanrecmtamntloanddet^"+appno);
					if(rs2.next())
					{
						dbLoanAmntReq=Double.parseDouble(Helper.correctDouble(rs2.getString("loan_recmdamt")));
						
					}
					double dbSecratio=(dbl_collateralsum1/dbLoanAmntReq)*100;
					hshQueryValues=new HashMap();
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						arrValues.add(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(String.valueOf(dbSecratio)))));
						arrValues.add(appno);
						hshQuery.put("arrValues",arrValues);
						hshQuery.put("strQueryId","upd_apploanamtsec_ratio");
						hshQueryValues.put("size","1");
						hshQueryValues.put("1",hshQuery);
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");  
				}
				//ended by bhaskar    		
	    		
	    						
				  //Added by bhaskar for update recomended amount based on security
				  rs1=DBUtils.executeLAPSQuery("selprdpurposeVehicle^"+appno);
				  if(rs1.next())
				  {
					  strprdType=Helper.correctNull((String)rs1.getString("PRD_TYPE"));
					  strprdPurpose=Helper.correctNull((String)rs1.getString("PRD_PURPOSE"));
					  strPrcode=Helper.correctNull((String)rs1.getString("PRD_CODE"));
					  dbstrMarginAmount=Double.parseDouble(Helper.correctDouble(rs1.getString("LOAN_DOWNPAY")));
					  dbstrcostofproject=Double.parseDouble(Helper.correctDouble(rs1.getString("loan_costloanprd")));
				  }
				  if(rs1!=null)
				  {
					  rs1.close();
				  }
				  
				  String strsessionModuleType=Helper.correctDate((String)hshValues.get("sessionModuleType"));
				  
				  if(strprdType.trim().equalsIgnoreCase("pA") && !strsessionModuleType.equals("DIGI"))
				  {
				 		 int agYear=0;			  
						 rs1=DBUtils.executeLAPSQuery("selmaturdatedetails^"+appno+"^"+"2");
						 while(rs1.next())
						 {
							  strDob=Helper.correctNull((String)rs1.getString("maturdate"));
							  String strSecid=Helper.correctNull((String)rs1.getString("CUS_SEC_CLASSIFICATION"));
							  if(!strDob.equalsIgnoreCase(""))
							  {
			    			  String s1=strDob.substring(6, 10);
			    			  String s2=strSysDate.substring(6, 10);
			    			  int doby=Integer.parseInt(s1);
			    			  int cury=Integer.parseInt(s2);
			    			  //String agYear=String.valueOf((cury-doby));
			    			  agYear=doby-cury;
			    			  String s3=strDob.substring(3,5);
			    			  String s4=strSysDate.substring(3,5);
			    			  int dobm=Integer.parseInt(s3);
			    			  int curm=Integer.parseInt(s4);
			    			  String s5=strDob.substring(0,2);
			    			  String s6=strSysDate.substring(0,2);
			    			  int dobd=Integer.parseInt(s5);
			    			  int curd=Integer.parseInt(s6);
			    			  
			    			  if(dobm<curm)
			    			  {
			    				  agYear=agYear-1; 
			    			  }
			    			  else if(curm==dobm)
			    			  {
			    				  if(dobd<curd)
			    				  {
			    					  agYear=agYear-1;  
			    				  }
			    			  }
							  }
							  
							  if(strSecid.equalsIgnoreCase("29") || strSecid.equalsIgnoreCase("32"))
			    			  {
			    			  if(agYear<=3)
			    			  {
			    				  dbstrSecValue=dbstrSecValue+Double.parseDouble(Helper.correctDouble(rs1.getString("cus_sec_netsecurity")));    				  
			    			  }
			    			  }
			    			  else
			    			  {
			    				  dbstrSecValue=dbstrSecValue+Double.parseDouble(Helper.correctDouble(rs1.getString("cus_sec_netsecurity")));
			    			  }
							
						 }
						 
						 if(dbstrSecValue>=dbstrMarginAmount)
						 { 						 
							    hshQueryValues=new HashMap();
		    					hshQuery=new HashMap();
		    					arrValues=new ArrayList();	    				
		    					//arrValues.add(String.valueOf(dbstrcostofproject));
		    					arrValues.add("0.00");
		    					arrValues.add("0.00");
		    					arrValues.add(appno);	    					
		    					hshQuery.put("arrValues",arrValues);
		    					hshQuery.put("strQueryId","update_recamt_marginapp");
		    					hshQueryValues.put("size","1");
		    					hshQueryValues.put("1",hshQuery);
		    					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData"); 			 
							 
						 }
						 
						 
						 
					 }	
				  //ende
				  
				  //added by bhaskar for margin insta cash
				  if(rs1!=null)
				  {
					  rs1.close();
				  }
				  if(strprdType.trim().equalsIgnoreCase("pI"))
				  {
					  rs1=DBUtils.executeLAPSQuery("selproposedcollnsckvp^"+appno+"^"+appno); 
					  if(rs1.next())
					  {						  
						  strDob=Helper.correctNull((String)rs1.getString("maturdate"));
						  if(!strDob.equalsIgnoreCase(""))
						  {
		    			  String s1=strDob.substring(6, 10);
		    			  String s2=strSysDate.substring(6, 10);
		    			  int doby=Integer.parseInt(s1);
		    			  int cury=Integer.parseInt(s2);
		    			  //String agYear=String.valueOf((cury-doby));
		    			  agYearNsckvp=doby-cury;
		    			  String s3=strDob.substring(3,5);
		    			  String s4=strSysDate.substring(3,5);
		    			  int dobm=Integer.parseInt(s3);
		    			  int curm=Integer.parseInt(s4);
		    			  String s5=strDob.substring(0,2);
		    			  String s6=strSysDate.substring(0,2);
		    			  int dobd=Integer.parseInt(s5);
		    			  int curd=Integer.parseInt(s6);
		    			  
		    			  if(dobm<curm)
		    			  {
		    				  agYearNsckvp=agYearNsckvp-1; 
		    			  }
		    			  else if(curm==dobm)
		    			  {
		    				  if(dobd<curd)
		    				  {
		    					  agYearNsckvp=agYearNsckvp-1;  
		    				  }
		    			  }	
						  }						 
					  
						 strQuery = SQLParser.getSqlQuery("selmarginrate^" + strPrcode + "^" + strGreater + "^" + agYearNsckvp + "^"
								+ strLesser + "^" + agYearNsckvp);
						rs = DBUtils.executeQuery(strQuery);
						
						if(rs.next())
						{
							strMargNscKvp=Helper.correctNull(rs.getString("margin_perct"));
						}
					  }
						
					  if(rs1!=null)
					  {
						  rs1.close();
					  }
					  rs1=DBUtils.executeLAPSQuery("selproposedcollnsckvp_others^"+appno+"^"+appno); 
					  if(rs1.next())
					  {
						  
						  strDob=Helper.correctNull((String)rs1.getString("maturdate"));
						  if(!strDob.equalsIgnoreCase(""))
						  {
		    			  String s1=strDob.substring(6, 10);
		    			  String s2=strSysDate.substring(6, 10);
		    			  int doby=Integer.parseInt(s1);
		    			  int cury=Integer.parseInt(s2);
		    			  //String agYear=String.valueOf((cury-doby));
		    			  agYearNsckvpother=doby-cury;
		    			  String s3=strDob.substring(3,5);
		    			  String s4=strSysDate.substring(3,5);
		    			  int dobm=Integer.parseInt(s3);
		    			  int curm=Integer.parseInt(s4);
		    			  String s5=strDob.substring(0,2);
		    			  String s6=strSysDate.substring(0,2);
		    			  int dobd=Integer.parseInt(s5);
		    			  int curd=Integer.parseInt(s6);
		    			  
		    			  if(dobm<curm)
		    			  {
		    				  agYearNsckvpother=agYearNsckvpother-1; 
		    			  }
		    			  else if(curm==dobm)
		    			  {
		    				  if(dobd<curd)
		    				  {
		    					  agYearNsckvpother=agYearNsckvpother-1;  
		    				  }
		    			  }	
						  }
					  
					  if(rs!=null)
					  {
						  rs.close();
					  }
					  strQuery = SQLParser.getSqlQuery("selmarginrate^" + strPrcode + "^" + strGreater + "^" + agYearNsckvpother + "^"
								+ strLesser + "^" + agYearNsckvpother);
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							strOthersmargin=Helper.correctNull(rs.getString("margin_perct_othersec"));
						}
					  }
						
						String strmargFinal="0";
						
						if(!strMargNscKvp.trim().equals("") && !strOthersmargin.trim().equals(""))
						{
							dbnsckvpmarg=Double.parseDouble(Helper.correctDouble(strMargNscKvp));
							dbothermargin=Double.parseDouble(Helper.correctDouble(strOthersmargin));
							double dbavgmargin=(dbnsckvpmarg+dbothermargin)/2;
							strmargFinal=Helper.formatDoubleValue(dbavgmargin);					
						}
						else if(!strMargNscKvp.trim().equals("") && strOthersmargin.trim().equals(""))
						{
							strmargFinal=strMargNscKvp;
						}
						else if(strMargNscKvp.trim().equals("") && !strOthersmargin.trim().equals(""))
						{
							strmargFinal=strOthersmargin;
						}
						double dbmargin=Double.parseDouble(Helper.correctDouble(strmargFinal));
						double dbDownPaymet=0.00;
						dbDownPaymet=((dbmargin/100)*dbstrcostofproject);
					    hshQueryValues=new HashMap();
    					hshQuery=new HashMap();
    					arrValues=new ArrayList();    					
    					arrValues.add(strmargFinal); 
    					arrValues.add(String.valueOf(dbDownPaymet)); 
    					arrValues.add(appno);	    					
    					hshQuery.put("arrValues",arrValues);
    					hshQuery.put("strQueryId","update_recamt_marginapp");
    					hshQueryValues.put("size","1");
    					hshQueryValues.put("1",hshQuery);
    					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");						
											  
				     }	
				  //end		
				  
				  //Updating security description
				  	hshQueryValues=new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId", "upd_sec_desc_pending");
					arrValues.add(appno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
	    		
	    		
    		}
	    	catch(Exception e)
	    	{
	    		throw new EJBException("Error in getCollateralSecurityDisplay "+e.toString());
	    	}
	    	return hshResult;
    }
    
    public HashMap getCollateralSecurityRetailDisplay(HashMap hshValues) 
    {
    	HashMap hshRecord=  new HashMap();
    	ResultSet rs = null,rs1=null,rs2=null,rs3=null;
    	String strQuery="",strAppno="",str_sec_id="",strAction="",strApplicantid="",strQuery1="",strQuery2="",strApplnid="",strApplicanttype="",strQuery3="",strHeadfac="";
    	double dbl_exifundostot=0,dbl_exinonfundostot=0,dbl_propfundostot=0,dbl_propnonfundostot=0,
    	dbl_secexitot=0,dbl_secproptot=0,dbl_secpropcoverage=0,dbl_secexicoverage=0,dbl_grpexifundostot=0,dbl_grpexinonfundostot=0,dbl_GrpExpExiSubtotal=0,
    	dbl_secexiSubtot=0,dbl_secpropSubtot=0,dbl_Proposedexptot=0,dbl_Existingexptot=0;
    	ArrayList arrcol=new ArrayList();
    	ArrayList arrRow=new ArrayList();
    	ArrayList arrGrpcol=new ArrayList();
    	ArrayList arrGrpRow=new ArrayList();
    	ArrayList arrGrpexpcol=new ArrayList();
    	ArrayList arrGrpexpRow=new ArrayList();
    	ArrayList arrNewcol=new ArrayList();
    	ArrayList arrNewRow=new ArrayList();
    	String strValuesin=Helper.correctNull((String)hshValues.get("valuesin"));
    	java.text.NumberFormat nft= java.text.NumberFormat.getInstance();
    	if(strValuesin.equalsIgnoreCase("L"))
		{
    		nft= java.text.NumberFormat.getInstance();
    		nft.setMaximumFractionDigits(3);
    		nft.setMinimumFractionDigits(3);
		}
		if(strValuesin.equalsIgnoreCase("C"))
		{
			nft= java.text.NumberFormat.getInstance();
			nft.setMaximumFractionDigits(4);
			nft.setMinimumFractionDigits(4);
		}
		if(strValuesin.equalsIgnoreCase("R"))
		{
			nft= java.text.NumberFormat.getInstance();
			nft.setMaximumFractionDigits(2);
			nft.setMinimumFractionDigits(2);
		}
    	try
    	{	
    		int i=0,Count=0,strsecCount=0;
    		strAction=Helper.correctNull((String)hshValues.get("hidAction"));
    		strAppno=Helper.correctNull((String)hshValues.get("appno"));
    		strApplicantid=Helper.correctNull((String)hshValues.get("hidapplicantid"));
    		
    		strQuery=SQLParser.getSqlQuery("SEL_COUNTAPPLI^"+strAppno);
    		rs=DBUtils.executeQuery(strQuery);
    		while(rs.next())
    		{
    			Count++;
    		}
    		if(rs!=null)
    		{
    			rs.close();
    		}
    		
    		strQuery3=SQLParser.getSqlQuery("SEL_GRPCONCCUSTOMER^"+strAppno);
    		rs3=DBUtils.executeQuery(strQuery3);
    		while(rs3.next())
    		{
    			strApplnid=Helper.correctNull((String)rs3.getString("APP_SEC_CUSTOMERID"));
    			if(strApplnid.equalsIgnoreCase(strApplicantid))
    			{
    				strApplicanttype="A";
    			}
    			else
    			{
    				strApplicanttype="O";
    			}
    			strQuery=SQLParser.getSqlQuery("sel_appSecdetailsfacsno_applicant1^"+strAppno+"^"+strApplnid);
    			rs=DBUtils.executeQuery(strQuery);
    			while(rs.next())
    			{    
		    			str_sec_id=Helper.correctInt((String)rs.getString("app_sec_secid"));
		    			strQuery1=SQLParser.getSqlQuery("SEL_ATTACHSECCOUNT^"+strAppno+"^"+"^"+strApplnid);
	    	    		rs1=DBUtils.executeQuery(strQuery1);
	    	    		if(rs1.next())
	    	    		{
	    	    			strsecCount=Integer.parseInt(Helper.correctInt((String)rs1.getString("SecCount")));
	    	    		} 
	    	    		if(rs1!=null)
	    	    		{
	    	    			rs1.close();
	    	    		}
		    			arrNewcol=new ArrayList();
		    			if(i==0)
		        		{
			    				arrNewcol.add("Fund Based");
			    			if(strApplicanttype.equalsIgnoreCase("A"))
			    			{
			    				strQuery1=SQLParser.getSqlQuery("sel_com_bankingsum^"+strAppno+"^F");
			    	    		rs1=DBUtils.executeQuery(strQuery1);
			    	    		if(rs1.next())
			    	    		{
			    	    			dbl_exifundostot=Double.parseDouble(Helper.correctDouble((String)rs1.getString(1)));
			    	    		} 
			    	    		if(rs1!=null)
			    	    		{
			    	    			rs1.close();
			    	    		}
			    	    		arrNewcol.add(nft.format(dbl_exifundostot).toString());
			    	    		
			    	    		strQuery1=SQLParser.getSqlQuery("selfacilitylistnew^"+strAppno+"^0^F");
			    	    		rs1=DBUtils.executeQuery(strQuery1);
			    	    		while(rs1.next())
			    	    		{
			    	    			dbl_propfundostot+=Double.parseDouble(Helper.correctDouble((String)rs1.getString("facility_proposed")));
			    	    		}
			    	    		if(rs1!=null)
			    	    		{
			    	    			rs1.close();
			    	    		}
			    	    		arrNewcol.add(nft.format(dbl_propfundostot).toString());
		    				}
			    			else if(strApplicanttype.equalsIgnoreCase("O"))
		    				{
			    				
			    				strQuery1=SQLParser.getSqlQuery("SEL_GRPCONCCUSTOMERSUM^"+strAppno+"^"+strApplnid+"^F");
			            		rs1=DBUtils.executeQuery(strQuery1);
			            		if(rs1.next())
			            		{
			            			dbl_grpexifundostot=Double.parseDouble(Helper.correctDouble((String)rs1.getString(1)));
			            		}
			            		if(rs1!=null)
			            		{
			            			rs1.close();
			            		}
			            		
			            		arrNewcol.add(nft.format(dbl_grpexifundostot).toString());
			            		arrNewcol.add("0.00");
			            	}
		    	    		
		        		}
		    			if(i==1)
		        		{
		    				arrNewcol.add("Non Fund Based");
		    				if(strApplicanttype.equalsIgnoreCase("A"))
			    			{	
			    				strQuery1=SQLParser.getSqlQuery("sel_com_bankingsum^"+strAppno+"^N");
			    	    		rs1=DBUtils.executeQuery(strQuery1);
			    	    		if(rs1.next())
			    	    		{
			    	    			dbl_exinonfundostot=Double.parseDouble(Helper.correctDouble((String)rs1.getString(1)));
			    	    		}
			    	    		if(rs1!=null)
			    	    		{
			    	    			rs1.close();
			    	    		}
			    	    		arrNewcol.add(nft.format(dbl_exinonfundostot).toString());
			    	    		strQuery1=SQLParser.getSqlQuery("selfacilitylistnew^"+strAppno+"^0^NF");
			    	    		rs1=DBUtils.executeQuery(strQuery1);
			    	    		while(rs1.next())
			    	    		{
			    	    			dbl_propnonfundostot+=Double.parseDouble(Helper.correctDouble((String)rs1.getString("facility_proposed")));
			    	    		}
			    	    		if(rs1!=null)
			    	    		{
			    	    			rs1.close();
			    	    		}
			    	    		arrNewcol.add(nft.format(dbl_propnonfundostot).toString());
			    			}
		    				else if(strApplicanttype.equalsIgnoreCase("O"))
		    				{
		    					
		    					strQuery1=SQLParser.getSqlQuery("SEL_GRPCONCCUSTOMERSUM^"+strAppno+"^"+strApplnid+"^N");
			            		rs1=DBUtils.executeQuery(strQuery1);
			            		if(rs1.next())
			            		{
			            			dbl_grpexinonfundostot=Double.parseDouble(Helper.correctDouble((String)rs1.getString(1)));
			            		}
			            		if(rs1!=null)
			            		{
			            			rs1.close();
			            		}
			            		arrNewcol.add(nft.format(dbl_grpexinonfundostot).toString());
			            		arrNewcol.add("0.00");
		    					
		    				}
		        		}
		    			if(i>1)
		        		{
		    				arrNewcol.add("");
		    				arrNewcol.add("");
		    				arrNewcol.add("");
		        		}
		    			int j=0;
		    			strQuery1=SQLParser.getSqlQuery("sel_appSecdetailsfacsno_applicant^"+strAppno+"^"+strApplnid+"^"+str_sec_id+"^E");
		        		rs1=DBUtils.executeQuery(strQuery1);
		        		if(rs1.next())
		        		{
		    	    		strQuery2=SQLParser.getSqlQuery("select_security_calssification^"+str_sec_id);
		    	    		rs2=DBUtils.executeQuery(strQuery2);
		    	    		if(rs2.next())
		    	    		{
		    	    			j++;
		    	    			arrNewcol.add(Helper.correctNull((String)rs2.getString("SEC_NAME")));
		    	    			arrNewcol.add(nft.format(Double.parseDouble(Helper.convertSetupToApplicationValues(strValuesin,Double.parseDouble(Helper.correctDouble((String)rs2.getString("CUS_SEC_NETSECURITY")))))));
		    	    			arrNewcol.add(nft.format(Double.parseDouble(Helper.convertSetupToApplicationValues(strValuesin,Double.parseDouble(Helper.correctDouble((String)rs2.getString("CUS_SEC_NETSECURITY")))))));
		    	    			dbl_secexitot+=Double.parseDouble(Helper.checkDecimal(Helper.correctDouble((String)rs2.getString("CUS_SEC_NETSECURITY"))));
		    	    			dbl_secproptot+=Double.parseDouble(Helper.checkDecimal(Helper.correctDouble((String)rs2.getString("CUS_SEC_NETSECURITY"))));
		    	    			dbl_secexiSubtot+=Double.parseDouble(Helper.checkDecimal(Helper.correctDouble((String)rs2.getString("CUS_SEC_NETSECURITY"))));
		    	    			dbl_secpropSubtot+=Double.parseDouble(Helper.checkDecimal(Helper.correctDouble((String)rs2.getString("CUS_SEC_NETSECURITY"))));
		    	    		}
		        		}
		        		if(rs1!=null)
			    		{
			    			rs1.close();
			    		}
		        		if(rs2!=null)
			    		{
			    			rs2.close();
			    		}
		        		strQuery1=SQLParser.getSqlQuery("sel_appSecdetailsfacsno_applicant^"+strAppno+"^"+strApplnid+"^"+str_sec_id+"^P");
		        		rs1=DBUtils.executeQuery(strQuery1);
		        		if(rs1.next())
		        		{
		    	    		strQuery2=SQLParser.getSqlQuery("select_security_calssification^"+str_sec_id);
		    	    		rs2=DBUtils.executeQuery(strQuery2);
		    	    		if(rs2.next())
		    	    		{
		    	    			j++;
		    	    			arrNewcol.add(Helper.correctNull((String)rs2.getString("SEC_NAME")));
		    	    			arrNewcol.add(nft.format(Double.parseDouble(Helper.convertSetupToApplicationValues(strValuesin,Double.parseDouble(Helper.correctDouble((String)rs2.getString("CUS_SEC_NETSECURITY")))))));
		    	    			arrNewcol.add(nft.format(Double.parseDouble(Helper.convertSetupToApplicationValues(strValuesin,Double.parseDouble(Helper.correctDouble((String)rs2.getString("CUS_SEC_NETSECURITY")))))));
		    	    			dbl_secexitot+=Double.parseDouble(Helper.checkDecimal(Helper.correctDouble((String)rs2.getString("CUS_SEC_NETSECURITY"))));
		    	    			dbl_secproptot+=Double.parseDouble(Helper.checkDecimal(Helper.correctDouble((String)rs2.getString("CUS_SEC_NETSECURITY"))));
		    	    			dbl_secpropSubtot+=Double.parseDouble(Helper.checkDecimal(Helper.correctDouble((String)rs2.getString("CUS_SEC_NETSECURITY"))));
		    	    		}
		        		}
		        		if(rs1!=null)
			    		{
			    			rs1.close();
			    		}
		        		if(rs2!=null)
			    		{
			    			rs2.close();
			    		}
		        		if(j==0)
		        		{
		        			arrNewcol.add("");
	    	    			arrNewcol.add("");
	    	    			arrNewcol.add("");
		        		}
		        		arrNewcol.add(strApplicanttype);
		        		arrNewcol.add(strApplnid);
		        		arrNewcol.add(str_sec_id);
		        		arrNewRow.add(arrNewcol);
		        		i++;
		        		if(strsecCount==1)
		        		{
		        			arrNewcol=new ArrayList();
		    				arrNewcol.add("Non Fund Based");
		    				if(strApplicanttype.equalsIgnoreCase("A"))
			    			{	
			    				strQuery1=SQLParser.getSqlQuery("sel_com_bankingsum^"+strAppno+"^N");
			    	    		rs1=DBUtils.executeQuery(strQuery1);
			    	    		if(rs1.next())
			    	    		{
			    	    			dbl_exinonfundostot=Double.parseDouble(Helper.correctDouble((String)rs1.getString(1)));
			    	    		}
			    	    		if(rs1!=null)
			    	    		{
			    	    			rs1.close();
			    	    		}
			    	    		arrNewcol.add(nft.format(dbl_exinonfundostot).toString());
			    	    		strQuery1=SQLParser.getSqlQuery("selfacilitylistnew^"+strAppno+"^0^NF");
			    	    		rs1=DBUtils.executeQuery(strQuery1);
			    	    		while(rs1.next())
			    	    		{
			    	    			dbl_propnonfundostot+=Double.parseDouble(Helper.correctDouble((String)rs1.getString("facility_proposed")));
			    	    		}
			    	    		if(rs1!=null)
			    	    		{
			    	    			rs1.close();
			    	    		}
			    	    		arrNewcol.add(nft.format(dbl_propnonfundostot).toString());
			    			}
		    				else if(strApplicanttype.equalsIgnoreCase("O"))
		    				{
		    					
		    					strQuery1=SQLParser.getSqlQuery("SEL_GRPCONCCUSTOMERSUM^"+strAppno+"^"+strApplnid+"^N");
			            		rs1=DBUtils.executeQuery(strQuery1);
			            		if(rs1.next())
			            		{
			            			dbl_grpexinonfundostot=Double.parseDouble(Helper.correctDouble((String)rs1.getString(1)));
			            		}
			            		if(rs1!=null)
			            		{
			            			rs1.close();
			            		}
			            		arrNewcol.add(nft.format(dbl_grpexinonfundostot).toString());
			            		arrNewcol.add("0.00");
		    					
		    				}
		    				arrNewcol.add("");
	    	    			arrNewcol.add("");
	    	    			arrNewcol.add("");
	    	    			arrNewcol.add(strApplicanttype);
			        		arrNewcol.add(strApplnid);
			        		arrNewcol.add(str_sec_id);
			        		arrNewRow.add(arrNewcol);
		        		}
		        	}
    			dbl_GrpExpExiSubtotal=dbl_grpexinonfundostot+dbl_grpexifundostot;
        		dbl_Proposedexptot=dbl_Proposedexptot+dbl_propnonfundostot+dbl_propfundostot;
        		dbl_Existingexptot=dbl_Existingexptot+dbl_exifundostot+dbl_exinonfundostot+dbl_GrpExpExiSubtotal;
        		if(Count>1)
        		{
	        		arrNewcol=new ArrayList();
	    			arrNewcol.add("SUB TOTAL");
	    			arrNewcol.add(nft.format(dbl_exifundostot+dbl_exinonfundostot+dbl_GrpExpExiSubtotal).toString());
	    			arrNewcol.add(nft.format(dbl_propfundostot+dbl_propnonfundostot).toString());
	    			arrNewcol.add("SUB TOTAL");
	    			//arrNewcol.add(nft.format(Double.parseDouble(Helper.convertSetupToApplicationValues(strValuesin,dbl_secexiSubtot))).toString()); Existing subtotal
	    			arrNewcol.add(nft.format(dbl_secpropSubtot).toString());
	    			arrNewcol.add(nft.format(dbl_secpropSubtot).toString());
	    			arrNewcol.add(strApplicanttype);
	    			arrNewcol.add(strApplnid);
	        		arrNewcol.add("");
	    			arrNewRow.add(arrNewcol);
        		}
    			dbl_exifundostot=0;
    			dbl_exinonfundostot=0;
    			dbl_propfundostot=0;
    			dbl_propnonfundostot=0;
    			dbl_GrpExpExiSubtotal=0;
    			dbl_secpropSubtot=0;
    			dbl_secexiSubtot=0;
    			i=0;
    		}
    		hshRecord.put("arrNewRow",arrNewRow);
    		if(rs!=null)
    		{
    			rs.close();
    		}
    		//hshRecord.put("dbl_exifundostot", nft.format(dbl_exifundostot));
    		//hshRecord.put("dbl_exinonfundostot",nft.format(dbl_exinonfundostot));
    		//hshRecord.put("dbl_propfundostot", nft.format(dbl_propfundostot));
    		//hshRecord.put("dbl_propnonfundostot",nft.format(dbl_propnonfundostot));
    		//hshRecord.put("dbl_subtotvalexis", nft.format(dbl_exifundostot+dbl_exinonfundostot));
    		hshRecord.put("Count", Count);
    		hshRecord.put("dbl_totvalexis", nft.format(dbl_Existingexptot));
    		hshRecord.put("dbl_totvalproposed",nft.format(dbl_Proposedexptot));
    		hshRecord.put("dbl_secexitot", nft.format(dbl_secexitot));
    		hshRecord.put("dbl_secproptot", nft.format(dbl_secproptot));
    		//hshRecord.put("dbl_secexiSubtot", nft.format(dbl_secexiSubtot));
    		//hshRecord.put("dbl_secpropSubtot", nft.format(dbl_secpropSubtot));
    		
    		if((dbl_Existingexptot)!=0 && dbl_secexitot!=0)
    		{
    			dbl_secexicoverage=(dbl_secexitot/(dbl_Existingexptot))*100;
    		}
    		hshRecord.put("dbl_secexicoverage", nft.format(dbl_secexicoverage));
    		if((dbl_Proposedexptot)!=0 && dbl_secproptot!=0)
    		{
    			dbl_secpropcoverage=(dbl_secproptot/(dbl_Proposedexptot))*100;
    		}
    		hshRecord.put("dbl_secpropcoverage", nft.format(dbl_secpropcoverage));
    	}
    	catch(Exception exception)
    	{
    		throw new EJBException("Error in getCollateralSecurityDisplaynew "+exception.toString());
    		
    	}
    	return hshRecord;
    	
    }
    public void getcollValueSecurityfreeze(HashMap hshValues)  
    {
    	String appno=Helper.correctNull((String)hshValues.get("appno"));
		String strappId = Helper.correctNull((String)hshValues.get("hidapplicantid"));
		String strAction = Helper.correctNull((String)hshValues.get("hidAction"));
		HashMap hshResult =new HashMap();
		HashMap hshQuery=new HashMap();
    	ArrayList arrValues=new ArrayList();
    	HashMap hshQueryValues=new HashMap();
    	HashMap hshRecord =new HashMap();
    	ResultSet rs1=null,rs=null,rs2=null;
    	ArrayList arrCol=new ArrayList();
    	ArrayList arrRow=new ArrayList();
    	ArrayList arrSecrow=new ArrayList();
    	ArrayList arrSeccol=new ArrayList();
    	ArrayList arrGrpexpRow=new ArrayList();
    	ArrayList arrGrpexpCol=new ArrayList();
    	ArrayList arrGrpSecrow=new ArrayList();
    	ArrayList arrGrpSeccol=new ArrayList();
    	ArrayList arrExprow=new ArrayList();
    	ArrayList arrExpcol=new ArrayList();
    	String strQuery="";
    	
    	java.text.NumberFormat nft= java.text.NumberFormat.getInstance();
    	nft= java.text.NumberFormat.getInstance();
    	nft.setMaximumFractionDigits(2);
    	nft.setMinimumFractionDigits(2);
    	nft.setGroupingUsed(false);
    	try
    	{

    			int intUpdatesize=0;
    			hshQueryValues=new HashMap();
    			hshQuery=new HashMap();
    			arrValues=new ArrayList();
    			arrValues.add("Y");
    			arrValues.add(appno);
    			hshQuery.put("arrValues",arrValues);
    			hshQuery.put("strQueryId","upd_app_securitydetailsfreeze");
    			hshQueryValues.put("size","1");
    			hshQueryValues.put("1",hshQuery);
    			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
        	
    			hshRecord = (HashMap)EJBInvoker.executeStateLess("securitymaster", hshValues, "getCollateralSecurityDisplayretail");
        		
        		double dblexitotal=0.00,dblprototal=0.00,dblsubexitotal=0.00,dblsubproptotal=0.00,dblSecpoposed=0.00,dblSecexisting=0.00,
        		dblsubtotal=0.00,dbltotal=0.00,dblRestrValFund=0.0,dblRestrValNF=0.0,dblTotalSec=0.0;
    			arrExprow=(ArrayList)hshRecord.get("arrExposureRow");
    			dblRestrValFund=Double.parseDouble(Helper.correctDouble((String)hshRecord.get("dblRestrValFund")));
    			dblRestrValNF=Double.parseDouble(Helper.correctDouble((String)hshRecord.get("dblRestrValNF")));
    			if(arrExprow!=null && arrExprow.size()>0)
    			{
	    			intUpdatesize = intUpdatesize+1;
	    			arrValues=new ArrayList();
	    			hshQueryValues=new HashMap();
	    			//Deleting Exposure details
	    			hshQuery=new HashMap();
					hshQuery.put("strQueryId","DEL_BORROWEREXP");
					arrValues.add(appno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
					intUpdatesize=0;
					hshQueryValues=new HashMap();
					for(int j=0;j<arrExprow.size();j++)
					{
						dblsubexitotal=0.00;dblsubproptotal=0.00;dblsubtotal=0.00;
						arrExpcol=(ArrayList)arrExprow.get(j);
						{
							if(!(Helper.correctNull((String)arrExpcol.get(6)).equalsIgnoreCase("N")))
							{
								//Inserting Exposure details
								intUpdatesize = intUpdatesize+1;
								hshQuery=new HashMap();
				    			arrValues=new ArrayList();
								hshQuery.put("strQueryId","INS_BORROWEREXP");
								arrValues.add(appno);
								if(Helper.correctNull((String)arrExpcol.get(4)).equalsIgnoreCase("A"))
								{
									dblexitotal +=Double.parseDouble(Helper.correctDouble((String)arrExpcol.get(0)))-dblRestrValFund;
									dblsubexitotal+=Double.parseDouble(Helper.correctDouble((String)arrExpcol.get(0)))-dblRestrValFund;
								}
								else
								{
									dblexitotal +=Double.parseDouble(Helper.correctDouble((String)arrExpcol.get(0)));
									dblsubexitotal+=Double.parseDouble(Helper.correctDouble((String)arrExpcol.get(0)));
								}
								dblprototal +=Double.parseDouble(Helper.correctDouble((String)arrExpcol.get(1)));
								dblsubproptotal+=Double.parseDouble(Helper.correctDouble((String)arrExpcol.get(1)));
								dblsubtotal+=Double.parseDouble(Helper.correctDouble((String)arrExpcol.get(8)));
								dbltotal+=Double.parseDouble(Helper.correctDouble((String)arrExpcol.get(8)));
								arrValues.add(Helper.correctNull((String)arrExpcol.get(7)));
								arrValues.add("F");
								if(Helper.correctNull((String)arrExpcol.get(4)).equalsIgnoreCase("A"))
									arrValues.add(String.valueOf(Double.parseDouble(Helper.correctDouble((String)arrExpcol.get(0)))-dblRestrValFund));
								else
									arrValues.add(Helper.correctDouble((String)arrExpcol.get(0)));
								arrValues.add(Helper.correctDouble((String)arrExpcol.get(1)));
								arrValues.add(Helper.correctNull((String)arrExpcol.get(4)));
								arrValues.add(Helper.correctNull((String)arrExpcol.get(8)));
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							
							
								intUpdatesize = intUpdatesize+1;
								hshQuery=new HashMap();
				    			arrValues=new ArrayList();
								hshQuery.put("strQueryId","INS_BORROWEREXP");
								arrValues.add(appno);
								arrValues.add(Helper.correctNull((String)arrExpcol.get(7)));
								arrValues.add("NF");
								if(Helper.correctNull((String)arrExpcol.get(4)).equalsIgnoreCase("A"))
								{
									dblexitotal+=Double.parseDouble(Helper.correctDouble((String)arrExpcol.get(2)))-dblRestrValNF;
									dblsubexitotal+=Double.parseDouble(Helper.correctDouble((String)arrExpcol.get(2)))-dblRestrValNF;
								}
								else
								{
									dblexitotal+=Double.parseDouble(Helper.correctDouble((String)arrExpcol.get(2)));
									dblsubexitotal+=Double.parseDouble(Helper.correctDouble((String)arrExpcol.get(2)));
								}
									
								dblprototal+=Double.parseDouble(Helper.correctDouble((String)arrExpcol.get(3)));
								dblsubproptotal+=Double.parseDouble(Helper.correctDouble((String)arrExpcol.get(3)));
								dblsubtotal+=Double.parseDouble(Helper.correctDouble((String)arrExpcol.get(9)));
								dbltotal+=Double.parseDouble(Helper.correctDouble((String)arrExpcol.get(9)));
								if(Helper.correctNull((String)arrExpcol.get(4)).equalsIgnoreCase("A"))
								arrValues.add(String.valueOf(Double.parseDouble(Helper.correctDouble((String)arrExpcol.get(2)))-dblRestrValNF));
								else
								arrValues.add(Helper.correctDouble((String)arrExpcol.get(2)));
								arrValues.add(Helper.correctDouble((String)arrExpcol.get(3)));
								arrValues.add(Helper.correctNull((String)arrExpcol.get(4)));
								arrValues.add(Helper.correctNull((String)arrExpcol.get(9)));
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							
								intUpdatesize = intUpdatesize+1;
								hshQuery=new HashMap();
				    			arrValues=new ArrayList();
								hshQuery.put("strQueryId","INS_BORROWEREXP");
								arrValues.add(appno);
								arrValues.add(Helper.correctNull((String)arrExpcol.get(7)));
								arrValues.add("SUBTOT");
								arrValues.add(String.valueOf(dblsubexitotal));
								arrValues.add(String.valueOf(dblsubproptotal));
								arrValues.add(Helper.correctNull((String)arrExpcol.get(4)));
								arrValues.add(String.valueOf(dblsubtotal));
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
								

								if(j==0)
								{
									arrSecrow=(ArrayList)hshRecord.get("Securities");
								}
								else
								{
									arrSecrow=(ArrayList)hshRecord.get("Securities"+j);
								}
								
								if(arrSecrow.size()>0 && arrSecrow !=null)
								{
									for(int k=0;k<arrSecrow.size();k++)
									{
										arrSeccol=(ArrayList)arrSecrow.get(k);
										dblSecpoposed+=Double.parseDouble(Helper.correctDouble((String)arrSeccol.get(2)));
										dblSecexisting+=Double.parseDouble(Helper.correctDouble((String)arrSeccol.get(1)));
										dblTotalSec+=Double.parseDouble(Helper.correctDouble((String)arrSeccol.get(3)));
										
									}
								}
							}
						}	
					}
					//double dblTotalSecValue=dblSecpoposed+dblSecexisting;
					double dblSecCoverage=0.00;
					if(dbltotal!=0.00)
					dblSecCoverage=(dblTotalSec/dbltotal)*100;
					intUpdatesize = intUpdatesize+1;
					hshQuery=new HashMap();
	    			arrValues=new ArrayList();
					hshQuery.put("strQueryId","INS_BORROWEREXP");
					arrValues.add(appno);
					arrValues.add(strappId);
					arrValues.add("TOT");
					arrValues.add(String.valueOf(dblexitotal));
					arrValues.add(String.valueOf(dblprototal));
					arrValues.add("A");
					arrValues.add(String.valueOf(dbltotal));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
								
					
					//Security coverage
					intUpdatesize = intUpdatesize+1;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","DEL_SECURITYCOVERAGE");
					arrValues.add(appno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					
					double dbl_secexicoverage=0,dbl_secpropcoverage=0,dbl_colletralSec=0,dbl_Collcoverage=0,dbl_Ratingexp=0.00,dbl_RatingexpNonFund=0.00;
					dbl_Ratingexp=Double.parseDouble(Helper.correctDouble((String)hshRecord.get("RatingExposureFund")));
					dbl_RatingexpNonFund=Double.parseDouble(Helper.correctDouble((String)hshRecord.get("RatingExposureNonFund")));
					/*Calculating Colletral coverage exposure*/
					strQuery=SQLParser.getSqlQuery("sel_Colletralsecurity"+"^"+appno+"^"+appno);
					rs = DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						dbl_colletralSec+=Double.parseDouble(Helper.correctDouble(rs.getString("CUS_SEC_NETSECURITY")));
					}
					dbl_Collcoverage=(dbl_colletralSec/dblprototal)/100;
					
					if(dbl_colletralSec==0.0 || dblprototal==0.0)
					{
						dbl_Collcoverage=0.00;
					}
					
					intUpdatesize = intUpdatesize+1;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","INS_SECURITYCOVERAGE");
					arrValues.add(appno);	
					arrValues.add(strappId);
					if(dblSecexisting<=0 || dblexitotal<=0)
					{
						dbl_secexicoverage=0;
					}
					else
					{
						dbl_secexicoverage=(dblSecexisting/dblexitotal)*100;
					}
					if(dblSecpoposed<=0 || dblprototal<=0)
					{
						dbl_secpropcoverage=0;
					}
					else
					{
						dbl_secpropcoverage=(dblSecpoposed/dblprototal)*100;
					}
					
					arrValues.add(String.valueOf(dbl_secexicoverage));
					arrValues.add(String.valueOf(dbl_secpropcoverage));
					arrValues.add(String.valueOf(dbl_Collcoverage));
					arrValues.add(String.valueOf(dbl_Ratingexp));/*Rating Exposure*/
					arrValues.add(nft.format(dblSecCoverage));
					arrValues.add(String.valueOf(dbl_RatingexpNonFund));/*Rating Exposure*/
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
    			}
			
    	}
    	catch (Exception e)
    	{
    		
    	}
    }
   
    public void updateReleaseofSecurity(HashMap hshValues) 
    {
    	java.text.NumberFormat jtn= java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);		
		
    	String strQuery="",strSno="",strAppno="",strFacCode="";
		ResultSet rs = null,rs1 = null,rs2 = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();
		ArrayList vecVal=null;
		ArrayList arrFacID = new ArrayList();
		ArrayList arrColFacID = new ArrayList();
		String hidposition= correctNull((String)hshValues.get("hidposition"));
		String hidFacID= correctNull((String)hshValues.get("hidFacIDlist"));
		double dblExist=0.00,dblProposed=0.00,dblMargin=0.00;
		
		String selSecType=Helper.correctNull((String)hshValues.get("secType"));
		
		String secID= Helper.correctNull((String)hshValues.get("hidSecID"));
		
    	try
    	{
    		int	intGroup =0;
    		strAppno=Helper.correctNull((String)hshValues.get("appno"));
    		

			strQuery = SQLParser.getSqlQuery("sel_faclist_sec^" + strAppno +"^"+intGroup);
				
			if(rs1 != null)
			{
				rs1.close();
			}
			rs1 = DBUtils.executeQuery(strQuery);
			int lngGrpSize = 0;
			ArrayList arrSubGrp = new ArrayList();
			String strLimit="",strOutstand="",strMargin="";			
			    		
    		while(rs1.next())
			{
				vecVal = new ArrayList();
				
				strQuery = SQLParser.getSqlQuery("sel_facilitycorp_desc^" + correctNull((String)rs1.getString("facility_code")));
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strFacCode=rs.getString("com_facdesc");
				}
				
								
				vecVal.add(strFacCode);//0
				
				dblProposed =rs1.getDouble("facility_proposed");
				strOutstand = jtn.format(dblProposed);
				strSno =correctNull(rs1.getString("facility_sno"));
				
				vecVal.add(strOutstand);//1
				
				//dblMargin=rs1.getDouble("facility_margin");
				//strMargin= jtn.format(dblMargin);
				strMargin="0.00";
				vecVal.add(strMargin);//2
				vecVal.add(strSno);//3
				vecVal.add(correctNull((String)rs1.getString("facility_code")));//4
				vecVal.add(correctNull((String)rs1.getString("COM_FACTYPE")));//5
				vecVal.add(correctNull((String)rs1.getString("facility_nature")));//6
				vecVal.add(strOutstand);//7 For Proposed Facility - Limit & OS amount are same
				vecVal.add("P");//7
				vecVal.add("");//7
				vecVal.add("");//7
				vecVal.add("");//7
				hshRecord.put("Proposed","Y");
				vecData.add(vecVal);			
				
			}
			strQuery = SQLParser.getSqlQuery("sel_banking^" + strAppno);
			
			if(rs1 != null)
			{
				rs1.close();
			}
			rs1 = DBUtils.executeQuery(strQuery);
			strLimit="";strOutstand="";strMargin="";String strbnkFac="";			
			    		
    		while(rs1.next())
			{
				vecVal = new ArrayList();
				strbnkFac = Helper.correctNull((String)rs1.getString("combk_facility"));
				
				String[] bankFac = strbnkFac.split("~");
				String strFlag="C";
				
				strQuery = SQLParser.getSqlQuery("sel_facilitycorp_desc^" + bankFac[0]);
				
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strFacCode=rs.getString("com_facdesc");
					}
					else
					{
						strQuery=SQLParser.getSqlQuery("sel_retProductDesc^"+bankFac[0]);
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							strFacCode=Helper.correctNull(rs.getString("com_facdesc"));
							strFlag="R";
						}
					}
								
				vecVal.add(strFacCode);//0
				
				dblProposed =rs1.getDouble("combk_limit");
				strOutstand = jtn.format(dblProposed);
				vecVal.add(strOutstand);//1
				vecVal.add("");//2
				vecVal.add(correctNull((String)rs1.getString("combk_facility_sno")));//3
				vecVal.add(bankFac[0]);//4
				if(strFlag.equals("C"))
				{
					vecVal.add(correctNull((String)rs.getString("com_factype")));//5
					vecVal.add(correctNull((String)rs.getString("com_facnature")));//6
				}
				else
				{
					vecVal.add(correctNull((String)rs.getString("PRD_LOANTYPE")));//5
					vecVal.add(correctNull((String)rs.getString("PRD_TYPE")));//6
				}
				 
				
				dblExist =rs1.getDouble("combk_os");
				strLimit = jtn.format(dblExist);
				vecVal.add(strLimit);//7
				vecVal.add("E");//8
				
				hshRecord.put("Existing","Y");
				
				strQuery = SQLParser.getSqlQuery("sel_facid_appSecdetails^" + Helper.correctInt((String)rs1.getString("COMBK_PARENTAPPNO")) + "^"+secID);
				if(rs2 != null)
				{
					rs2.close();
				}
				rs2 = DBUtils.executeQuery(strQuery);
	    		if(rs2.next())
				{
	    			vecVal.add("Y");//9
				}
	    		else
	    		{
	    			vecVal.add("N");//9
	    		}
	    		vecVal.add(Helper.correctNull((String)rs1.getString("COMBK_PARENTAPPNO")));//10
	    		vecVal.add(Helper.correctNull((String)rs1.getString("COMBK_PARENTFACSNO")));//11
	    		vecData.add(vecVal);			
				
			}
    		
    		strQuery = SQLParser.getSqlQuery("sel_facid_appSecdetails^" + strAppno + "^"+secID);
			if(rs2 != null)
			{
				rs2.close();
			}
			rs2 = DBUtils.executeQuery(strQuery);
			String strFacID="";
			    		
    		while(rs2.next())
			{
    			arrFacID = new ArrayList();
    			arrFacID.add(correctNull((String)rs2.getString("app_sec_facid")));
    			arrFacID.add(correctNull((String)rs2.getString("APP_SEC_MARGIN")));
    			arrFacID.add(correctNull((String)rs2.getString("app_sec_securitytype")));
    			arrFacID.add(correctNull((String)rs2.getString("app_sec_loantype")));
    			arrFacID.add(correctNull((String)rs2.getString("app_sec_parentappno")));
    			arrFacID.add(correctNull((String)rs2.getString("app_sec_parent_facsno")));
    			arrColFacID.add(arrFacID);
			}
		
    		hshRecord.put("vecData",vecData);
    		hshRecord.put("hidposition",hidposition);
    		hshRecord.put("hidFacID",hidFacID);
    		hshRecord.put("arrColFacID",arrColFacID);
    		
    		//***********************************************
    		
    	}
    	catch(Exception e)
		{
			throw new EJBException("Error in getattachSecurity "+e.toString());
		} 
    }
    
    /** END **/
    
    public void updateBAConsData(HashMap hshValues) 
	{
		HashMap hshQueryValues 	= new HashMap();
		HashMap hshQuery 	= null;
		ResultSet rs		= null;
		ArrayList arrValues	= new ArrayList();
		String strAction	= correctNull((String)hshValues.get("hidAction"));
		String appno		= correctNull((String)hshValues.get("appno"));
		
		int intUpdatesize=0, intSno	= 0;
		String strBAConsType	= "";
		try
		{
			//Consortium Value from Banking Arrangement
			if(rs!=null){rs.close();}
			rs = DBUtils.executeLAPSQuery("sel_BAConsVal^"+appno);
			if(rs.next())
			{
				strBAConsType	= correctNull((String)rs.getString("com_wc_bnkarg"));
			}
			
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQuery	= new HashMap();
				arrValues	= new ArrayList();
				intUpdatesize	= 0;
				
				if(rs!=null){rs.close();}
				rs = DBUtils.executeLAPSQuery("sel_Max_BAConsortium^"+appno);
				if(rs.next())
				{
					intSno	= Integer.parseInt(Helper.correctInt((String)rs.getString("maxsno")));
				}
				
				arrValues.add(appno);
				arrValues.add(String.valueOf(intSno));
				arrValues.add(correctNull((String)hshValues.get("txt_LeadBankName")));
				arrValues.add(correctNull((String)hshValues.get("sel_Natureloan")));
				arrValues.add(correctNull((String)hshValues.get("sel_factype")));
				arrValues.add(correctNull((String)hshValues.get("sel_limiof")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_Limit")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_OS")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_intrate")));
				arrValues.add(correctNull((String)hshValues.get("txta_remarks")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_perbranch")));
				arrValues.add(correctNull((String)hshValues.get("txt_email")));
				arrValues.add(correctNull((String)hshValues.get("txt_ECSifsccode")));
				if(correctNull((String)hshValues.get("sel_ConsType")).equals(""))
				{
					arrValues.add("1");
				}
				else
				{
					arrValues.add(correctNull((String)hshValues.get("sel_ConsType")));
				}
				arrValues.add(correctNull((String)hshValues.get("sel_Asset_Classfication")));
				hshQuery.put("strQueryId","ins_BAConsortium");
				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(String.valueOf(++intUpdatesize),hshQuery);
				
				if(strBAConsType.equalsIgnoreCase("C"))
				{
					//Consortium Details Insertion
					hshQuery	= new HashMap();
					arrValues	= new ArrayList();
					
					arrValues.add(appno);
					if(correctNull((String)hshValues.get("sel_ConsType")).equals(""))
					{
						arrValues.add("1");
					}
					else
					{
						arrValues.add(correctNull((String)hshValues.get("sel_ConsType")));
					}
					
					hshQuery.put("strQueryId","del_BAConsortiumLead");
					
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(String.valueOf(++intUpdatesize),hshQuery);
					
					hshQuery	= new HashMap();
					arrValues	= new ArrayList();
					
					arrValues.add(appno);
					if(correctNull((String)hshValues.get("sel_ConsType")).equals(""))
					{
						arrValues.add("1");
					}
					else
					{
						arrValues.add(correctNull((String)hshValues.get("sel_ConsType")));
					}
					arrValues.add(correctNull((String)hshValues.get("hid_LeadBankcodeCons")));
					arrValues.add(correctNull((String)hshValues.get("txt_consDesc")));
					arrValues.add(correctNull((String)hshValues.get("txt_AsonDate")));
					
					hshQuery.put("strQueryId","ins_BAConsortiumLead");
					
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(String.valueOf(++intUpdatesize),hshQuery);
				}
				
				hshQueryValues.put("size",String.valueOf(intUpdatesize));
			}
			else if(strAction.equalsIgnoreCase("update"))
			{
				intSno	= Integer.parseInt(Helper.correctInt((String)hshValues.get("hidsno")));
				
				hshQuery	= new HashMap();
				arrValues	= new ArrayList();
				intUpdatesize	= 0;
				
				arrValues.add(appno);
				arrValues.add(String.valueOf(intSno));
				
				hshQuery.put("strQueryId","del_BAConsortium");
				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(String.valueOf(++intUpdatesize),hshQuery);
				
				hshQuery	= new HashMap();
				arrValues	= new ArrayList();
				
				arrValues.add(appno);
				arrValues.add(String.valueOf(intSno));
				arrValues.add(correctNull((String)hshValues.get("txt_LeadBankName")));
				arrValues.add(correctNull((String)hshValues.get("sel_Natureloan")));
				arrValues.add(correctNull((String)hshValues.get("sel_factype")));
				arrValues.add(correctNull((String)hshValues.get("sel_limiof")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_Limit")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_OS")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_intrate")));
				arrValues.add(correctNull((String)hshValues.get("txta_remarks")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_perbranch")));
				arrValues.add(correctNull((String)hshValues.get("txt_email")));
				arrValues.add(correctNull((String)hshValues.get("txt_ECSifsccode")));
				if(correctNull((String)hshValues.get("sel_ConsType")).equals(""))
				{
					arrValues.add("1");
				}
				else
				{
					arrValues.add(correctNull((String)hshValues.get("sel_ConsType")));
				}
				arrValues.add(correctNull((String)hshValues.get("sel_Asset_Classfication")));
				hshQuery.put("strQueryId","ins_BAConsortium");
				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(String.valueOf(++intUpdatesize),hshQuery);
				
				if(strBAConsType.equalsIgnoreCase("C"))
				{
					//Consortium Details Insertion
					hshQuery	= new HashMap();
					arrValues	= new ArrayList();
					
					arrValues.add(appno);
					if(correctNull((String)hshValues.get("sel_ConsType")).equals(""))
					{
						arrValues.add("1");
					}
					else
					{
						arrValues.add(correctNull((String)hshValues.get("sel_ConsType")));
					}
					
					hshQuery.put("strQueryId","del_BAConsortiumLead");
					
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(String.valueOf(++intUpdatesize),hshQuery);
					
					hshQuery	= new HashMap();
					arrValues	= new ArrayList();
					
					arrValues.add(appno);
					if(correctNull((String)hshValues.get("sel_ConsType")).equals(""))
					{
						arrValues.add("1");
					}
					else
					{
						arrValues.add(correctNull((String)hshValues.get("sel_ConsType")));
					}
					arrValues.add(correctNull((String)hshValues.get("hid_LeadBankcodeCons")));
					arrValues.add(correctNull((String)hshValues.get("txt_consDesc")));
					arrValues.add(correctNull((String)hshValues.get("txt_AsonDate")));
					
					hshQuery.put("strQueryId","ins_BAConsortiumLead");
					
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(String.valueOf(++intUpdatesize),hshQuery);
				}
				
				hshQueryValues.put("size",String.valueOf(intUpdatesize));
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				intUpdatesize++;
				intSno	= Integer.parseInt(Helper.correctInt((String)hshValues.get("hidsno")));
				hshQuery	= new HashMap();
				arrValues	= new ArrayList();
				arrValues.add(appno);
				arrValues.add(String.valueOf(intSno));
				hshQuery.put("strQueryId","del_BAConsortium");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				intUpdatesize++;
				hshQuery	= new HashMap();
				arrValues	= new ArrayList();
				arrValues.add(appno);
				arrValues.add(String.valueOf(intSno));
				hshQuery.put("strQueryId","del_BAConsortiumLead");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
			}
			
			/*intUpdatesize++;
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId", "del_com_proposalNoteCheck");
			arrValues.add(appno);
			arrValues.add("WC");//page name-  multiple banking
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("size", ""+intUpdatesize);
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
			intUpdatesize++;
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId", "ins_com_proposalNoteCheck");
			arrValues.add(appno);
			arrValues.add("WC");//page name-  multiple banking
			String proposalNoteCheck=Helper.correctNull((String)hshValues.get("proposalNote"));
			if(proposalNoteCheck.equalsIgnoreCase("on")){proposalNoteCheck="Y";}
			else{proposalNoteCheck="N";}
			arrValues.add(proposalNoteCheck);
			String AnnexureCheck=Helper.correctNull((String)hshValues.get("Annexure3"));
			if(AnnexureCheck.equalsIgnoreCase("on")){AnnexureCheck="Y";}
			else{AnnexureCheck="N";}
			arrValues.add(AnnexureCheck);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("size", ""+intUpdatesize);
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			*/
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		catch(Exception ce)
		{
			throw new EJBException("inside updateBAConsData"+ce.toString());
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
    
    public  HashMap getBAConsData(HashMap hshValues) 
	{
		String strQuery="", strBAConsType	= "",appcreatedate="",applicationStatus="";
		ResultSet rs = null, rs1 = null,rs5=null,rs6=null,rs7=null;
		HashMap hshRecord 	= new HashMap();
		ArrayList arrRow	= new ArrayList();
		ArrayList arrCol	= new ArrayList();
		boolean recordflag	= false;
		try
		{
			String appno	= correctNull((String)hshValues.get("appno"));
			String livedate=ApplicationParams.getStrCLPHdate();
			
			
			strQuery = SQLParser.getSqlQuery("getcreatedate^"+appno);
			rs5= DBUtils.executeQuery(strQuery);
			if (rs5.next()){
				
				appcreatedate= rs5.getString("createddate");
				applicationStatus= rs5.getString("APP_STATUS");
			}
			System.out.println("Application created date-->"+appcreatedate);
			System.out.println("Sanction  Live Date-->"+livedate);
			//Consortium Value from Banking Arrangement
			if(rs!=null){rs.close();}
			rs = DBUtils.executeLAPSQuery("sel_BAConsVal^"+appno);
			if(rs.next())
			{
				hshRecord.put("com_wc_bnkarg",correctNull((String)rs.getString("com_wc_bnkarg")));
				hshRecord.put("com_wc_type",correctNull((String)rs.getString("com_wc_type")));
				
				strBAConsType	= correctNull((String)rs.getString("com_wc_type"));
			}
			
			if(correctNull((String)hshValues.get("hidGetFLAG")).equalsIgnoreCase("Yes") || !strBAConsType.equals("M"))
			{
				String strConSno	= "";
				strConSno	= Helper.correctInt((String)hshValues.get("sel_ConsType"));
				
				if(strConSno.equals("0"))
				{
					strConSno	= "1";
				}
				
				strQuery = SQLParser.getSqlQuery("sel_BAConsortium^"+appno+"^"+strConSno);
				if(rs!=null){rs.close();}
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrCol	= new ArrayList();
					
					arrCol.add(Helper.correctInt((String)rs.getString("com_con_sno")));//0
					if(rs6!=null){rs6.close();}
					if(!livedate.equalsIgnoreCase("") && !appcreatedate.equalsIgnoreCase("")){
						 String Pattern="dd/MM/yyyy";
							DateFormat df=new SimpleDateFormat(Pattern);
							Date appcreationdate=df.parse(appcreatedate);
							Date postsanclivedate=df.parse(livedate);
							if(appcreationdate.before(postsanclivedate) && applicationStatus.equalsIgnoreCase("pa"))
							{
					rs6 = DBUtils.executeLAPSQuery("getstaticdescription^147^"+correctNull((String)rs.getString("com_con_bank_code")));
					if(rs6.next())
					{
						arrCol.add(Helper.correctNull(rs6.getString("stat_data_desc1")));//1
					}
					
					}else{
						arrCol.add(correctNull((String)rs.getString("com_con_bank_code")));//1
					}
					}
					arrCol.add(correctNull((String)rs.getString("com_con_fac_nature")));//2
					arrCol.add(correctNull((String)rs.getString("com_con_fac_type")));//3
					arrCol.add(correctNull((String)rs.getString("com_con_fac_limitof")));//4
					arrCol.add(Helper.correctInt((String)rs.getString("com_con_limit")));//5
					arrCol.add(Helper.correctInt((String)rs.getString("com_con_outstanding")));//6
					arrCol.add(Helper.correctInt((String)rs.getString("com_con_int_rate")));//7
					arrCol.add(correctNull(Helper.CLOBToString(rs.getClob("com_con_remarks"))));//8
					
					if(rs1!=null){rs1.close();}
					rs1 = DBUtils.executeLAPSQuery("getstaticdescription^147^"+correctNull((String)rs.getString("com_con_bank_code")));
					if(!rs1.next())
					{
						arrCol.add("");
					}
					rs1.beforeFirst();
					while(rs1.next())
					{
						arrCol.add(Helper.correctNull(rs1.getString("stat_data_desc1")));//9
						break;
					}
					
					if(rs1!=null){rs1.close();}
					rs1 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^144^"+correctNull((String)rs.getString("com_con_fac_nature")));
					if(!rs1.next())
					{
						arrCol.add("");
					}
					rs1.beforeFirst();
					while(rs1.next())
					{
						arrCol.add(Helper.correctNull(rs1.getString("stat_data_desc1")));//10
						break;
					}
					arrCol.add(correctNull((String)rs.getString("COM_CONS_ASSET_CLASSFICATION")));//11
					if(rs1!=null){rs1.close();}
					rs1 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^31^"+correctNull(rs.getString("COM_CONS_ASSET_CLASSFICATION")));
					if(rs1.next())
					{
						arrCol.add(Helper.correctNull(rs1.getString("stat_data_desc1")));//12
					}
					else
					{
						arrCol.add("");
					}
					if(rs7!=null){rs7.close();}
					if(!livedate.equalsIgnoreCase("") && !appcreatedate.equalsIgnoreCase("")){
						 String Pattern="dd/MM/yyyy";
							DateFormat df=new SimpleDateFormat(Pattern);
							Date appcreationdate=df.parse(appcreatedate);
							Date postsanclivedate=df.parse(livedate);
							if(appcreationdate.before(postsanclivedate) && applicationStatus.equalsIgnoreCase("pa"))
							{
					rs7 = DBUtils.executeLAPSQuery("getstaticdescription^259^"+correctNull((String)rs.getString("COM_CON_BRANCH_NAME")));
					if(rs7.next())
					{
						arrCol.add(Helper.correctNull(rs7.getString("stat_data_desc1")));//9
					}
					
					}else{
						arrCol.add(Helper.correctNull((String)rs.getString("COM_CON_BRANCH_NAME")));//13
					}
					}
				
					arrCol.add(Helper.correctNull((String)rs.getString("COM_CON_EMAIL_ID")));//14
					if(rs1!=null){rs1.close();}
					rs1 = DBUtils.executeLAPSQuery("getstaticdescription^259^"+correctNull((String)rs.getString("COM_CON_BRANCH_NAME")));
					if(rs1.next())
					{
						arrCol.add(Helper.correctNull(rs1.getString("stat_data_desc1")));//15
					}else
					{
						arrCol.add("");
					}
					arrCol.add(Helper.correctNull((String)rs.getString("COM_CON_IFSC_CODE")));//14
					if(rs1!=null){rs1.close();}
					arrRow.add(arrCol);
					
					recordflag=true;
				}
				
				//Consortium Details
				
				strQuery = SQLParser.getSqlQuery("sel_BAConsortiumLead^"+appno+"^"+strConSno);
				if(rs!=null){rs.close();}
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("com_cons_sno", Helper.correctInt((String)rs.getString("com_cons_sno")));
					hshRecord.put("com_cons_bank_code",correctNull((String)rs.getString("com_cons_bank_code")));
					hshRecord.put("com_cons_desc",correctNull((String)rs.getString("com_cons_desc")));
					hshRecord.put("com_cons_asondate",correctNull((String)rs.getString("com_cons_asondate")));
					
					if(rs1!=null){rs1.close();}
					rs1 = DBUtils.executeLAPSQuery("getstaticdescription^147^"+correctNull((String)rs.getString("com_cons_bank_code")));
					while(rs1.next())
					{
						hshRecord.put("com_cons_bank_name",correctNull((String)rs1.getString("stat_data_desc1")));
						break;
					}
				}
	
				hshRecord.put("arrRow", arrRow);
				hshRecord.put("recordflag", String.valueOf(recordflag));
				
				hshRecord.put("sel_ConsType", correctNull((String)hshValues.get("sel_ConsType")));
				hshRecord.put("hidGetFLAG", "Yes");
			}
			
			//Added by Amaravathi for Consortium Tab
			if(rs!=null){rs.close();}
			rs = DBUtils.executeLAPSQuery("sel_BAConsVal^"+appno);
			if(rs.next())
			{
				hshRecord.put("com_tl_bnkarg",correctNull(rs.getString("com_tl_bnkarg")));
				hshRecord.put("com_tl_type",correctNull(rs.getString("com_tl_type")));
				hshRecord.put("com_wc_bnkarg",correctNull(rs.getString("com_wc_bnkarg")));
				hshRecord.put("com_wc_type",correctNull(rs.getString("com_wc_type")));
			}
			//End
			//added by Hemavathi for Check Box
			/*
			if(rs!=null){rs.close();}
			strQuery = SQLParser.getSqlQuery("sel_com_proposalNoteCheck^"+appno+"^"+"WC");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("com_proposalnote",Helper.correctNull(rs.getString("com_proposalnote")));
				hshRecord.put("com_annexure",Helper.correctNull(rs.getString("com_annexure")));
			}
			*/
		}
		catch(Exception ce)
		{		
			throw new EJBException("Error in getBAConsData "+ce.toString());
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
	
    public void updateBAConsDataTL(HashMap hshValues) 
	{
		HashMap hshQueryValues 	= new HashMap();
		HashMap hshQuery 	= null;
		ResultSet rs		= null;
		ArrayList arrValues	= new ArrayList();
		String strAction	= correctNull((String)hshValues.get("hidAction"));
		String appno		= correctNull((String)hshValues.get("appno"));
		
		int intUpdatesize=0, intSno	= 0;
		String strBAConsType	= "";
		try
		{
			//Consortium Value from Banking Arrangement
			if(rs!=null){rs.close();}
			rs = DBUtils.executeLAPSQuery("sel_BAConsVal^"+appno);
			if(rs.next())
			{
				strBAConsType	= correctNull((String)rs.getString("com_tl_bnkarg"));
			}
			
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQuery	= new HashMap();
				arrValues	= new ArrayList();
				intUpdatesize	= 0;
				
				if(rs!=null){rs.close();}
				rs = DBUtils.executeLAPSQuery("sel_Max_BAConsortium_tl^"+appno);
				if(rs.next())
				{
					intSno	= Integer.parseInt(Helper.correctInt((String)rs.getString("maxsno")));
				}
				
				arrValues.add(appno);
				arrValues.add(String.valueOf(intSno));
				arrValues.add(correctNull((String)hshValues.get("txt_LeadBankName")));
				arrValues.add(correctNull((String)hshValues.get("sel_Natureloan")));
				arrValues.add(correctNull((String)hshValues.get("sel_factype")));
				arrValues.add(correctNull((String)hshValues.get("sel_limiof")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_Limit")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_OS")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_OS_AS_ON")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_Unrel_Por")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_intrate")));
				arrValues.add(correctNull((String)hshValues.get("txta_remarks")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_perbranch")));
				arrValues.add(correctNull((String)hshValues.get("txt_email")));
				arrValues.add(correctNull((String)hshValues.get("txt_ECSifsccode")));
				if(correctNull((String)hshValues.get("sel_ConsType_tl")).equals(""))
				{
					arrValues.add("1");
				}
				else
				{
					arrValues.add(correctNull((String)hshValues.get("sel_ConsType_tl")));
				}
				
				hshQuery.put("strQueryId","ins_BAConsortium_tl");
				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(String.valueOf(++intUpdatesize),hshQuery);
				
				if(strBAConsType.equalsIgnoreCase("C"))
				{
					//Consortium Details Insertion
					hshQuery	= new HashMap();
					arrValues	= new ArrayList();
					
					arrValues.add(appno);
					if(correctNull((String)hshValues.get("sel_ConsType_tl")).equals(""))
					{
						arrValues.add("1");
					}
					else
					{
						arrValues.add(correctNull((String)hshValues.get("sel_ConsType_tl")));
					}
					
					hshQuery.put("strQueryId","del_BAConsortiumLead_tl");
					
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(String.valueOf(++intUpdatesize),hshQuery);
					
					hshQuery	= new HashMap();
					arrValues	= new ArrayList();
					
					arrValues.add(appno);
					if(correctNull((String)hshValues.get("sel_ConsType_tl")).equals(""))
					{
						arrValues.add("1");
					}
					else
					{
						arrValues.add(correctNull((String)hshValues.get("sel_ConsType_tl")));
					}
					arrValues.add(correctNull((String)hshValues.get("hid_LeadBankcodeCons")));
					arrValues.add(correctNull((String)hshValues.get("txt_consDesc")));
					arrValues.add(correctNull((String)hshValues.get("txt_AsonDate")));
					
					hshQuery.put("strQueryId","ins_BAConsortiumLead_tl");
					
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(String.valueOf(++intUpdatesize),hshQuery);
				}
				
				hshQueryValues.put("size",String.valueOf(intUpdatesize));
			}
			else if(strAction.equalsIgnoreCase("update"))
			{
				intSno	= Integer.parseInt(Helper.correctInt((String)hshValues.get("hidsno")));
				
				hshQuery	= new HashMap();
				arrValues	= new ArrayList();
				intUpdatesize	= 0;
				
				arrValues.add(appno);
				arrValues.add(String.valueOf(intSno));
				
				hshQuery.put("strQueryId","del_BAConsortium_tl");
				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(String.valueOf(++intUpdatesize),hshQuery);
				
				hshQuery	= new HashMap();
				arrValues	= new ArrayList();
				
				arrValues.add(appno);
				arrValues.add(String.valueOf(intSno));
				arrValues.add(correctNull((String)hshValues.get("txt_LeadBankName")));
				arrValues.add(correctNull((String)hshValues.get("sel_Natureloan")));
				arrValues.add(correctNull((String)hshValues.get("sel_factype")));
				arrValues.add(correctNull((String)hshValues.get("sel_limiof")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_Limit")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_OS")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_OS_AS_ON")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_Unrel_Por")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_intrate")));
				arrValues.add(correctNull((String)hshValues.get("txta_remarks")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_perbranch")));
				arrValues.add(correctNull((String)hshValues.get("txt_email")));
				arrValues.add(correctNull((String)hshValues.get("txt_ECSifsccode")));
				if(correctNull((String)hshValues.get("sel_ConsType_tl")).equals(""))
				{
					arrValues.add("1");
				}
				else
				{
					arrValues.add(correctNull((String)hshValues.get("sel_ConsType_tl")));
				}
				
				hshQuery.put("strQueryId","ins_BAConsortium_tl");
				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(String.valueOf(++intUpdatesize),hshQuery);
				
				if(strBAConsType.equalsIgnoreCase("C"))
				{
					//Consortium Details Insertion
					hshQuery	= new HashMap();
					arrValues	= new ArrayList();
					
					arrValues.add(appno);
					if(correctNull((String)hshValues.get("sel_ConsType_tl")).equals(""))
					{
						arrValues.add("1");
					}
					else
					{
						arrValues.add(correctNull((String)hshValues.get("sel_ConsType_tl")));
					}
					
					hshQuery.put("strQueryId","del_BAConsortiumLead_tl");
					
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(String.valueOf(++intUpdatesize),hshQuery);
					
					hshQuery	= new HashMap();
					arrValues	= new ArrayList();
					
					arrValues.add(appno);
					if(correctNull((String)hshValues.get("sel_ConsType_tl")).equals(""))
					{
						arrValues.add("1");
					}
					else
					{
						arrValues.add(correctNull((String)hshValues.get("sel_ConsType_tl")));
					}
					arrValues.add(correctNull((String)hshValues.get("hid_LeadBankcodeCons")));
					arrValues.add(correctNull((String)hshValues.get("txt_consDesc")));
					arrValues.add(correctNull((String)hshValues.get("txt_AsonDate")));
					
					hshQuery.put("strQueryId","ins_BAConsortiumLead_tl");
					
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(String.valueOf(++intUpdatesize),hshQuery);
				}
				
				hshQueryValues.put("size",String.valueOf(intUpdatesize));
			}
			
			else if(strAction.equalsIgnoreCase("delete"))
			{
				intUpdatesize++;
				intSno	= Integer.parseInt(Helper.correctInt((String)hshValues.get("hidsno")));
				hshQuery	= new HashMap();
				arrValues	= new ArrayList();
				arrValues.add(appno);
				arrValues.add(String.valueOf(intSno));
				hshQuery.put("strQueryId","del_BAConsortium_tl");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				intUpdatesize++;
				hshQuery	= new HashMap();
				arrValues	= new ArrayList();
				arrValues.add(appno);
				arrValues.add(String.valueOf(intSno));
				hshQuery.put("strQueryId","del_BAConsortiumLead_tl");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);

				
			}
			
			/*intUpdatesize++;
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId", "del_com_proposalNoteCheck");
			arrValues.add(appno);
			arrValues.add("TL");//page name-  multiple banking
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("size", ""+intUpdatesize);
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			
			intUpdatesize++;
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId", "ins_com_proposalNoteCheck");
			arrValues.add(appno);
			arrValues.add("TL");//page name-  multiple banking
			String proposalNoteCheck=Helper.correctNull((String)hshValues.get("proposalNote"));
			if(proposalNoteCheck.equalsIgnoreCase("on")){proposalNoteCheck="Y";}
			else{proposalNoteCheck="N";}
			arrValues.add(proposalNoteCheck);
			String AnnexureCheck=Helper.correctNull((String)hshValues.get("Annexure3"));
			if(AnnexureCheck.equalsIgnoreCase("on")){AnnexureCheck="Y";}
			else{AnnexureCheck="N";}
			arrValues.add(AnnexureCheck);
			hshQuery.put("arrValues", arrValues);
			
			hshQueryValues.put("size", ""+intUpdatesize);
			hshQueryValues.put(""+intUpdatesize, hshQuery);
			*/
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		catch(Exception ce)
		{
			throw new EJBException("inside updateBAConsDataTL"+ce.toString());
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
    
    public  HashMap getBAConsDataTL(HashMap hshValues) 
	{
		String strQuery="", strBAConsType	= "";
		ResultSet rs = null, rs1 = null,rs5=null,rs6=null,rs7=null;
		HashMap hshRecord 	= new HashMap();
		ArrayList arrRow	= new ArrayList();
		ArrayList arrCol	= new ArrayList();
		boolean recordflag	= false;
		String strcountchk="N";

		String strWCbnkarg="",strTLbnkarg="",strWCtype="",strTLtype="",appcreatedate="",applicationStatus="";
		int strconswcCount=0,strconsTLCount=0;
		try
		{
			String appno	= correctNull((String)hshValues.get("appno"));
String livedate=ApplicationParams.getStrCLPHdate();
			
			
			strQuery = SQLParser.getSqlQuery("getcreatedate^"+appno);
			rs5= DBUtils.executeQuery(strQuery);
			if (rs5.next()){
				
				appcreatedate= rs5.getString("createddate");
				applicationStatus= rs5.getString("APP_STATUS");
			}
			System.out.println("Application created date-->"+appcreatedate);
			System.out.println("Sanction  Live Date-->"+livedate);
			//Consortium Value from Banking Arrangement
			if(rs!=null){rs.close();}
			rs = DBUtils.executeLAPSQuery("sel_BAConsVal^"+appno);
			if(rs.next())
			{
				hshRecord.put("com_tl_bnkarg",correctNull((String)rs.getString("com_tl_bnkarg")));
				hshRecord.put("com_tl_type",correctNull((String)rs.getString("com_tl_type")));
				
				strBAConsType	= correctNull((String)rs.getString("com_tl_type"));
			}
			
			if(correctNull((String)hshValues.get("hidGetFLAG_tl")).equalsIgnoreCase("Yes") || !strBAConsType.equals("M"))
			{
				String strConSno	= "";
				strConSno	= Helper.correctInt((String)hshValues.get("sel_ConsType_tl"));
				
				if(strConSno.equals("0"))
				{
					strConSno	= "1";
				}
				
				strQuery = SQLParser.getSqlQuery("sel_BAConsortium_tl^"+appno+"^"+strConSno);
				if(rs!=null){rs.close();}
				rs = DBUtils.executeQuery(strQuery);
				
				while(rs.next())
				{
					arrCol	= new ArrayList();
					
					arrCol.add(Helper.correctInt((String)rs.getString("com_con_sno")));//0
					if(rs6!=null){rs6.close();}
					if(!livedate.equalsIgnoreCase("") && !appcreatedate.equalsIgnoreCase("")){
						 String Pattern="dd/MM/yyyy";
							DateFormat df=new SimpleDateFormat(Pattern);
							Date appcreationdate=df.parse(appcreatedate);
							Date postsanclivedate=df.parse(livedate);
							if(appcreationdate.before(postsanclivedate) && applicationStatus.equalsIgnoreCase("pa"))
							{
					rs6 = DBUtils.executeLAPSQuery("getstaticdescription^147^"+correctNull((String)rs.getString("com_con_bank_code")));
					if(rs6.next())
					{
						arrCol.add(Helper.correctNull(rs6.getString("stat_data_desc1")));//1
					}
					
					}else{
						arrCol.add(correctNull((String)rs.getString("com_con_bank_code")));//1
					}
					}
					arrCol.add(correctNull((String)rs.getString("com_con_fac_nature")));//2
					arrCol.add(correctNull((String)rs.getString("com_con_fac_type")));//3
					arrCol.add(correctNull((String)rs.getString("com_con_fac_limitof")));//4
					arrCol.add(Helper.correctInt((String)rs.getString("com_con_limit")));//5
					arrCol.add(Helper.correctInt((String)rs.getString("com_con_outstanding")));//6
					arrCol.add(Helper.correctInt((String)rs.getString("com_con_int_rate")));//7
					arrCol.add(correctNull(Helper.CLOBToString(rs.getClob("com_con_remarks"))));//8
					
					if(rs1!=null){rs1.close();}
					rs1 = DBUtils.executeLAPSQuery("getstaticdescription^147^"+correctNull((String)rs.getString("com_con_bank_code")));
					if(!rs1.next())
					{
						arrCol.add("");
					}
					rs1.beforeFirst();
					while(rs1.next())
					{
						arrCol.add(Helper.correctNull(rs1.getString("stat_data_desc1")));//9
						break;
					}
					
					if(rs1!=null){rs1.close();}
					rs1 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^144^"+correctNull((String)rs.getString("com_con_fac_nature")));
					if(!rs1.next())
					{
						arrCol.add("");
					}
					rs1.beforeFirst();
					while(rs1.next())
					{
						arrCol.add(Helper.correctNull(rs1.getString("stat_data_desc1")));//10
						break;
					}
					arrCol.add(Helper.correctNull((String)rs.getString("COM_CON_OUTSTANDING_AS_ON")));//11
					arrCol.add(Helper.correctInt((String)rs.getString("COM_CON_UNRELEASED_PORTION")));//12
					if(rs7!=null){rs7.close();}
					if(!livedate.equalsIgnoreCase("") && !appcreatedate.equalsIgnoreCase("")){
						 String Pattern="dd/MM/yyyy";
							DateFormat df=new SimpleDateFormat(Pattern);
							Date appcreationdate=df.parse(appcreatedate);
							Date postsanclivedate=df.parse(livedate);
							if(appcreationdate.before(postsanclivedate) && applicationStatus.equalsIgnoreCase("pa"))
							{
					rs7 = DBUtils.executeLAPSQuery("getstaticdescription^259^"+correctNull((String)rs.getString("COM_CON_BRANCH_NAME")));
					if(rs7.next())
					{
						arrCol.add(Helper.correctNull(rs7.getString("stat_data_desc1")));//9
					}
					
					}else{
						arrCol.add(Helper.correctNull((String)rs.getString("COM_CON_BRANCH_NAME")));//13
					}
					}
					arrCol.add(Helper.correctNull(rs.getString("COM_CON_EMAIL_ID")));//14
					if(rs1!=null){rs1.close();}
					rs1 = DBUtils.executeLAPSQuery("getstaticdescription^259^"+correctNull((String)rs.getString("COM_CON_BRANCH_NAME")));
					if(rs1.next())
					{
						arrCol.add(Helper.correctNull(rs1.getString("stat_data_desc1")));//15
					}else
					{
						arrCol.add("");
					}
					arrCol.add(Helper.correctNull(rs.getString("COM_CON_IFSC_CODE")));//16
					arrRow.add(arrCol);
					
					recordflag=true;
				}
				
				//Consortium Details
				strQuery = SQLParser.getSqlQuery("sel_BAConsortiumLead_tl^"+appno+"^"+strConSno);
				if(rs!=null){rs.close();}
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("com_cons_sno", Helper.correctInt((String)rs.getString("com_cons_sno")));
					hshRecord.put("com_cons_bank_code",correctNull((String)rs.getString("com_cons_bank_code")));
					hshRecord.put("com_cons_desc",correctNull((String)rs.getString("com_cons_desc")));
					hshRecord.put("com_cons_asondate",correctNull((String)rs.getString("com_cons_asondate")));
					
					if(rs1!=null){rs1.close();}
					rs1 = DBUtils.executeLAPSQuery("getstaticdescription^147^"+correctNull((String)rs.getString("com_cons_bank_code")));
					while(rs1.next())
					{
						hshRecord.put("com_cons_bank_name",correctNull((String)rs1.getString("stat_data_desc1")));
						break;
					}
				}
	
				hshRecord.put("arrRow", arrRow);
				hshRecord.put("recordflag", String.valueOf(recordflag));
				
				hshRecord.put("sel_ConsType", correctNull((String)hshValues.get("sel_ConsType_tl")));
				hshRecord.put("hidGetFLAG", "Yes");
			}
			
			//Added by  for Consortium Tab
			if(rs!=null){rs.close();}
			rs = DBUtils.executeLAPSQuery("sel_BAConsVal^"+appno);
			if(rs.next())
			{
				hshRecord.put("com_tl_bnkarg",correctNull(rs.getString("com_tl_bnkarg")));
				hshRecord.put("com_tl_type",correctNull(rs.getString("com_tl_type")));
				hshRecord.put("com_wc_bnkarg",correctNull(rs.getString("com_wc_bnkarg")));
				hshRecord.put("com_wc_type",correctNull(rs.getString("com_wc_type")));
			}
			//End
			if(rs!=null){rs.close();}
			/*
			strQuery = SQLParser.getSqlQuery("sel_com_proposalNoteCheck^"+appno+"^"+"TL");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("com_proposalnote",Helper.correctNull(rs.getString("com_proposalnote")));
				hshRecord.put("com_annexure",Helper.correctNull(rs.getString("com_annexure")));
			}
			*/
			if(rs!=null){rs.close();}
			
			rs = DBUtils.executeLAPSQuery("sel_BAConsVal^"+appno);
						if(rs.next())
						{
							strWCbnkarg = Helper.correctNull(rs.getString("com_wc_bnkarg"));
							strTLbnkarg = Helper.correctNull(rs.getString("com_tl_bnkarg"));
							
							strWCtype = Helper.correctNull(rs.getString("com_wc_type"));
							strTLtype = Helper.correctNull(rs.getString("com_tl_type"));
							
							strconswcCount = Integer.parseInt(rs.getString("COM_WC_NO"));
							strconsTLCount = Integer.parseInt(rs.getString("COM_TL_NO"));
							
						}
						if(rs!=null){
						rs.close();
						}
			    rs = DBUtils.executeLAPSQuery("sel_consprtiummultiplechk^"+appno);
						if(rs.next())
						{
							if(strWCbnkarg.equalsIgnoreCase("C")&& (strWCtype.equalsIgnoreCase("M"))){
							if(strconswcCount !=Integer.parseInt(Helper.correctInt(rs.getString("count")))){
							strcountchk="Y";
							}
							}
							if(strTLbnkarg.equalsIgnoreCase("C")&& strTLtype.equalsIgnoreCase("M")){
							if(strconsTLCount !=Integer.parseInt(Helper.correctInt(rs.getString("count")))){
							strcountchk="Y";
							}
							}
						}
						log.info("strcountchk=================>>>>>"+strcountchk);
						hshRecord.put("strcountchk",strcountchk);
		}
		catch(Exception ce)
		{		
			throw new EJBException("Error in getBAConsData "+ce.toString());
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
    public void updateFreezeData(HashMap hshValues) 
	{
    	java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
    	HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String strAppno=correctNull((String)hshValues.get("appno"));
		ResultSet rs=null,rs4=null;
		int intUpdatesize=0;
		String strQuery2="",strQuery="";
		String strWhetherACOpening="",strPrefix="",strSuffix="",strCbsACno="",strDrawingpower="",strDueDate="",strValuesin="";
		String strOutstanding="",strFacilitycode[]=null,strModuletype="",strRatingcheck="",strSchnonsche="";
		double dblTLExposure=0.00,dblOutstanding=0.00,dbl_Sancamount=0.00,dbl_disbamount=0.00;
		String strFlag="";
		try
		{
			int size=0;
			ArrayList arrCashmargincode= new ArrayList();
		    arrCashmargincode.add("153");
		    arrCashmargincode.add("154");
		    arrCashmargincode.add("156");
		    arrCashmargincode.add("158");
			if(rs4!=null) rs4.close();
			strQuery2 = SQLParser.getSqlQuery("sel_combanking_existingfac_updliab^"+strAppno);
			rs4 = DBUtils.executeQuery(strQuery2);
    		while(rs4.next())
    		{
    			strDrawingpower="";strDueDate="";strOutstanding="";
    			dblTLExposure=0.00;dblOutstanding=0.00;dbl_Sancamount=0.00;dbl_disbamount=0.00;
    			
    			strCbsACno="";strPrefix="";strSuffix="";strFacilitycode=null;strModuletype="";
    			strWhetherACOpening=Helper.correctNull((String)rs4.getString("combk_accountopen"));
    			strCbsACno=Helper.correctNull((String)rs4.getString("combk_cbsappno"));
    			strPrefix=Helper.correctNull((String)rs4.getString("combk_prefix"));
    			strSuffix=Helper.correctNull((String)rs4.getString("combk_suffix"));
    			strModuletype=Helper.correctNull((String)rs4.getString("combk_modtype"));
    			strFacilitycode=Helper.correctNull((String)rs4.getString("combk_facility")).split("~");
    			    			
    			if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
				{
	    			if(strWhetherACOpening.equalsIgnoreCase("Y"))
	    			{
	    				strQuery = SQLParser.getCBSSqlQuery("selliabpullingdirectacopening^"+strCbsACno);
	    			}
	    			else
	    			{
	    				if(!strPrefix.equalsIgnoreCase("")&& !strSuffix.equalsIgnoreCase(""))
	    					strQuery = SQLParser.getCBSSqlQuery("selliabpullingindirectacopening^"+strPrefix+"^"+strSuffix);
	    				else
	    					strQuery = SQLParser.getCBSSqlQuery("selliabpullingindirectacopeningbg^"+strCbsACno);
	    			}
				}
    			else
    			{
    				if(strWhetherACOpening.equalsIgnoreCase("Y"))
	    			{
	    				strQuery = SQLParser.getCBSSqlQuery("selliabpullingdirectacopening1^"+strCbsACno);
	    			}
	    			else
	    			{
	    				if(!strPrefix.equalsIgnoreCase("")&& !strSuffix.equalsIgnoreCase(""))
	    					strQuery = SQLParser.getCBSSqlQuery("selliabpullingindirectacopening1^"+strPrefix+"^"+strSuffix);
	    				else
	    					strQuery = SQLParser.getCBSSqlQuery("selliabpullingindirectacopeningbg1^"+strCbsACno);
	    			}
    			}
    			if(rs!=null) rs.close();
    			rs = DBUtils.executeQueryCBSConnection(strQuery);
    			if(rs.next())
    			{
    				strDrawingpower =jtn.format(Double.parseDouble((String)Helper.correctDouble(rs.getString("drawingpower"))));    
    				strDueDate =Helper.correctNull((String)rs.getString("duedate"));
    				strOutstanding = jtn.format(Double.parseDouble((String)Helper.correctDouble(rs.getString("outstanding"))));
    				dbl_Sancamount=Double.parseDouble((String)Helper.correctDouble(rs.getString("SANCT_LIMIT")));
    				dbl_disbamount=Double.parseDouble((String)Helper.correctDouble(rs.getString("Disb_amt")));
    				dblOutstanding=Double.parseDouble((String)Helper.correctDouble(rs.getString("outstanding")));
    				if(dblOutstanding<0)
    				{
    					dblOutstanding=Double.parseDouble(strOutstanding.substring(1));//for converting negative value to positive
    					strFlag="DR";
    				}	
        			else
        			{
        				strFlag="CR";
        			}
        			
					if(Helper.correctNull((String)rs4.getString("combk_type")).equalsIgnoreCase("1")||strWhetherACOpening.equalsIgnoreCase("N"))
					{
						if(strFlag.equalsIgnoreCase("CR"))
						{
							dblTLExposure=dbl_Sancamount;
						}
						else
						{
							if(dbl_Sancamount < dblOutstanding)
							{
								dblTLExposure=dblOutstanding;
							}
							else
							{
								dblTLExposure=dbl_Sancamount;
							}	
						}
					}
					else
					{
						dblTLExposure=dblOutstanding+(dbl_Sancamount-dbl_disbamount);						
					}
    			}
    			if(strModuletype.equalsIgnoreCase("P") || strModuletype.equalsIgnoreCase("r"))
    			{
	    			strQuery = SQLParser.getSqlQuery("sel_retailBankschemetype^1"+"^"+strFacilitycode[0]);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strSchnonsche=Helper.correctNull((String)rs.getString("MIS_SCHEMATIC"));
					}
    			}else
    			{
    				strQuery = SQLParser.getSqlQuery("sel_corpBankschemetype^1"+"^"+strFacilitycode[0]);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strSchnonsche=Helper.correctNull((String)rs.getString("MIS_SCHEMATIC"));
					}
    			}
    			if(strSchnonsche.equalsIgnoreCase("Y"))
    			{
    				strRatingcheck="N";
    			}else if(strSchnonsche.equalsIgnoreCase("N"))
    			{
    				strRatingcheck="Y";
    			}
    			if(strDrawingpower.equalsIgnoreCase(""))
    			{
    				strDrawingpower="0";
    			}
    			//For 100% cash margin products should not include for Rating based exposure 
    			if(arrCashmargincode.contains(strFacilitycode[0]))
    			{
    				strRatingcheck="N";
    			}
    				hshQuery = new HashMap();
       			 	arrValues = new ArrayList();
       			 	arrValues.add(Helper.convertSetupToApplicationValues(strValuesin,Double.parseDouble(strDrawingpower)));
       			    arrValues.add(strDueDate);
       			 	arrValues.add(Helper.convertSetupToApplicationValues(strValuesin,dblOutstanding));
       			 	arrValues.add(Helper.correctDouble(String.valueOf(dblTLExposure)));
       			 	arrValues.add(strFlag);
       			 	arrValues.add(strRatingcheck);
       			    arrValues.add(strAppno);
       			 	size+=1;
       			 	hshQueryValues.put("size",""+(size));
       			    if(strWhetherACOpening.equalsIgnoreCase("Y"))
       			    {
       			    	arrValues.add(strCbsACno);
       			    	hshQuery.put("strQueryId","updcombankdirliab"); 
       			    }
       			    else
       			    {
       			    	if(!strPrefix.equalsIgnoreCase("")&& !strSuffix.equalsIgnoreCase(""))
       			    	{
       			    		arrValues.add(strPrefix);
       			    		arrValues.add(strSuffix);
       			    		hshQuery.put("strQueryId","updcombankindirliab"); 
       			    	}else{
       			    		arrValues.add(strCbsACno);
           			    	hshQuery.put("strQueryId","updcombankdirliab"); 
       			    	}
       			    }
       			 	hshQuery.put("arrValues",arrValues);
       			 	hshQueryValues.put(""+(size),hshQuery);	
    			
    		}
    		if(size>0){
    			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
    		}
    		
    		size=0;
    		if(rs4!=null) rs4.close();
			strQuery2 = SQLParser.getSqlQuery("sel_comgroupconcerns_existingfac^"+strAppno);
			rs4 = DBUtils.executeQuery(strQuery2);
    		while(rs4.next())
    		{
    			strDrawingpower="";strDueDate="";strOutstanding="";
    			dblTLExposure=0.00;dblOutstanding=0.00;dbl_Sancamount=0.00;dbl_disbamount=0.00;
    			
    			strCbsACno="";strPrefix="";strSuffix="";
    			strWhetherACOpening=Helper.correctNull((String)rs4.getString("comgc_accountopen"));
    			strCbsACno=Helper.correctNull((String)rs4.getString("comgc_cbsappno"));
    			strPrefix=Helper.correctNull((String)rs4.getString("comgc_prefix"));
    			strSuffix=Helper.correctNull((String)rs4.getString("comgc_suffix"));
    			strModuletype=Helper.correctNull((String)rs4.getString("comgc_modtype"));
    			strFacilitycode=Helper.correctNull((String)rs4.getString("comgc_facility")).split("~");
    			
    			if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
				{
    				if(strWhetherACOpening.equalsIgnoreCase("Y"))
    				{
    					strQuery = SQLParser.getCBSSqlQuery("selliabpullingdirectacopening^"+strCbsACno);
    				}
    				else
    				{
    					if(!strPrefix.equalsIgnoreCase("")&& !strSuffix.equalsIgnoreCase(""))
    						strQuery = SQLParser.getCBSSqlQuery("selliabpullingindirectacopening^"+strPrefix+"^"+strSuffix);
    					else
    						strQuery = SQLParser.getCBSSqlQuery("selliabpullingindirectacopeningbg^"+strCbsACno);
    				}
				}
    			else
    			{
    				if(strWhetherACOpening.equalsIgnoreCase("Y"))
	    			{
	    				strQuery = SQLParser.getCBSSqlQuery("selliabpullingdirectacopening1^"+strCbsACno);
	    			}
	    			else
	    			{
	    				if(!strPrefix.equalsIgnoreCase("")&& !strSuffix.equalsIgnoreCase(""))
	    					strQuery = SQLParser.getCBSSqlQuery("selliabpullingindirectacopening1^"+strPrefix+"^"+strSuffix);
	    				else
	    					strQuery = SQLParser.getCBSSqlQuery("selliabpullingindirectacopeningbg1^"+strCbsACno);
	    			}
    			}
    			if(rs!=null) rs.close();
    			rs = DBUtils.executeQueryCBSConnection(strQuery);
    			if(rs.next())
    			{
    				strFlag="";
    				strDrawingpower =jtn.format((Double.parseDouble((String)Helper.correctDouble(rs.getString("drawingpower")))));    
    				strDueDate =Helper.correctNull((String)rs.getString("duedate"));
    				strOutstanding = jtn.format(Double.parseDouble((String)Helper.correctDouble(rs.getString("outstanding"))));
    				
    				dbl_Sancamount=Double.parseDouble((String)Helper.correctDouble(rs.getString("SANCT_LIMIT")));
    				dbl_disbamount=Double.parseDouble((String)Helper.correctDouble(rs.getString("Disb_amt")));
    				dblOutstanding=Double.parseDouble((String)Helper.correctDouble(rs.getString("outstanding")));
    				if(dblOutstanding<0)
    				{
    					dblOutstanding=Double.parseDouble(strOutstanding.substring(1));//for converting negative value to positive
    					strFlag="DR";
    				}	
        			else
        			{
        				strFlag="CR";
        			}
        			
					if(Helper.correctNull((String)rs4.getString("comgc_type")).equalsIgnoreCase("1")||strWhetherACOpening.equalsIgnoreCase("N"))
					{
						if(strFlag.equalsIgnoreCase("CR"))
						{
							dblTLExposure=dbl_Sancamount;
						}
						else
						{
							if(dbl_Sancamount < dblOutstanding)
							{
								dblTLExposure=dblOutstanding;
							}
							else
							{
								dblTLExposure=dbl_Sancamount;
							}
						}
					}
					else
					{
						dblTLExposure=dblOutstanding+(dbl_Sancamount-dbl_disbamount);						
					}
        		}
    			if(rs!=null) rs.close();
    			if(strModuletype.equalsIgnoreCase("P") || strModuletype.equalsIgnoreCase("r"))
    			{
	    			strQuery = SQLParser.getSqlQuery("sel_retailBankschemetype^1"+"^"+strFacilitycode[0]);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strSchnonsche=Helper.correctNull((String)rs.getString("MIS_SCHEMATIC"));
					}
    			}else
    			{
    				strQuery = SQLParser.getSqlQuery("sel_corpBankschemetype^1"+"^"+strFacilitycode[0]);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strSchnonsche=Helper.correctNull((String)rs.getString("MIS_SCHEMATIC"));
					}
    			}
    			if(strSchnonsche.equalsIgnoreCase("Y"))
    			{
    				strRatingcheck="N";
    			}else if(strSchnonsche.equalsIgnoreCase("N"))
    			{
    				strRatingcheck="Y";
    			}
    			//For 100% cash margin products should not include for Rating based exposure 
    			if(arrCashmargincode.contains(strFacilitycode[0]))
    			{
    				strRatingcheck="N";
    			}
				hshQuery = new HashMap();
   			 	arrValues = new ArrayList();
   			 	arrValues.add(Helper.convertSetupToApplicationValues(strValuesin,Double.parseDouble(Helper.correctDouble(strDrawingpower))));
   			    arrValues.add(strDueDate);
   			    arrValues.add(Helper.convertSetupToApplicationValues(strValuesin,dblOutstanding));
   			    arrValues.add(Helper.correctDouble(String.valueOf(dblTLExposure)));
   			 	arrValues.add(strFlag);
   			 	arrValues.add(strRatingcheck);
   			    arrValues.add(strAppno);
   			 	size+=1;
   			 	hshQueryValues.put("size",""+(size));
   			    if(strWhetherACOpening.equalsIgnoreCase("Y"))
   			    {
   			    	arrValues.add(strCbsACno);
   			    	hshQuery.put("strQueryId","updcomgcbankdirliab"); 
   			    }
   			    else
   			    {
   			    	if(!strPrefix.equalsIgnoreCase("")&& !strSuffix.equalsIgnoreCase(""))
   			    	{
   			    		arrValues.add(strPrefix);
   			    		arrValues.add(strSuffix);
   			    		hshQuery.put("strQueryId","updcomgcbankindirliab"); 
   			    	}
   			    	else
   			    	{
   			    		arrValues.add(strCbsACno);
   	   			    	hshQuery.put("strQueryId","updcomgcbankdirliab"); 
   			    	}
   			    }
   			 	hshQuery.put("arrValues",arrValues);
   			 	hshQueryValues.put(""+(size),hshQuery);	
   			 	
    		}
    		if(size>0){
    			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
    		}
    		
    		hshQueryValues=new HashMap();
    		hshQuery = new HashMap();
			arrValues = new ArrayList();
			arrValues.add("");
			arrValues.add(strAppno);
			hshQuery.put("strQueryId","update_secfreezeflag"); 
			hshQueryValues.put("size","1");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		catch(Exception ce)
		{
			throw new EJBException("inside updateFreezeData=="+ce.toString());
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
    public HashMap getlegalopinionverification(HashMap hshValues) 
    {
    	String strQuery ="";
    	String strQueryforstaff ="";
    	String strQueryforgetclassfication ="";
    	String lovdate="";
    	ResultSet rs= null;
    	ResultSet rs1= null;
    	ArrayList arrRow=new ArrayList();
    	ArrayList arrCol= null;
    	ArrayList arrColformain=new ArrayList() ;
    	
    	String appno=Helper.correctNull((String)hshValues.get("appno"));
    	java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
    	  try {
    		  
    			strQuery=SQLParser.getSqlQuery("legal_opinion_verification^"+appno);
    			rs=DBUtils.executeQuery(strQuery);
    			while(rs.next())
    			{
    				arrCol=new ArrayList();
    				arrCol.add(Helper.correctNull((String)rs.getString("SEC_ID")));//0
    				
    				strQueryforgetclassfication=SQLParser.getSqlQuery("getclassification^"+Helper.correctNull((String)rs.getString("CUS_SEC_CLASSIFICATION")));
    				rs1=DBUtils.executeQuery(strQueryforgetclassfication);
    				if(rs1.next())
    				{
    					arrCol.add(Helper.correctNull((String)rs1.getString("SEC_NAME")));//1	
    				}
    				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("APP_SEC_SECURITYVALUE")))));//2
    				//arrCol.add(Helper.correctNull((String)rs.getString("APP_SEC_SECURITYVALUE")));
    				if(rs1!=null)
						rs1.close();
    				strQueryforstaff =SQLParser.getSqlQuery("lopverification^"+appno+"^"+Helper.correctNull((String)rs.getString("SEC_ID")));
    				rs1=DBUtils.executeQuery(strQueryforstaff);
    				if(rs1.next())
    				{
    					String staffname="";
    					arrCol.add(Helper.correctNull((String)rs1.getString("LEGAL_OPINION_DATE")));//3
    					arrCol.add(Helper.correctNull((String)rs1.getString("LO_VERIFIED_BY")));//4
    					arrCol.add(Helper.correctNull((String)rs1.getString("LO_VERIFIED_DES")));//5
    					staffname=Helper.correctNull((String)rs1.getString("LO_VERIFIED_BY"));
    					if(!Helper.correctNull(rs1.getString("LO_VERIFIED_BY")).equalsIgnoreCase(""))
    					{
    						if(rs1!=null)
    							rs1.close();
    						rs1=DBUtils.executeLAPSQuery("selectusername^"+staffname);
    						if(rs1.next())
    						{
    							arrCol.add(Helper.correctNull(rs1.getString("name")));//6
    						}
    					}
    					
    				}
    				
    				else
    				{
    					arrCol.add("");	
    					arrCol.add("");	
    					arrCol.add("");	
    					arrCol.add("");	
    				}
    				if(rs1!=null)
						rs1.close();
    				lovdate=SQLParser.getSqlQuery("selseclegalopinion^"+Helper.correctNull((String)rs.getString("SEC_ID")));
    				rs1=DBUtils.executeQuery(lovdate);
    				if(rs1.next())
    				{
    					arrCol.add(Helper.correctNull((String)rs1.getString("SEC_PL_LEGOPDATE")));	//7
    				}
    				else 
    				{
    					arrCol.add("");
    				}
    				
    				arrRow.add(arrCol);
    			}
    			hshValues.put("arrRow", arrRow);
    			
    			if(rs!=null)
    			{
    				rs.close();
    			}
    			int strFreezecount=0;
        		String strFreezeflag="N",strPrioityflag="N";
        		strQuery = SQLParser.getSqlQuery("sel_freezecount^" + appno);
    			rs = DBUtils.executeQuery(strQuery);
    			while(rs.next())
    			{	
    				strFreezecount=Integer.parseInt(Helper.correctInt((String)rs.getString("freezecount")));
    				if(strFreezecount!=0 )
    				{
    					strFreezeflag="Y";
    				}
    			}
    			if( Helper.correctNull((String)hshValues.get("hidAction")).equalsIgnoreCase("undo"))
    			{
    				strFreezeflag="N";
    			}
    			
        		
    			hshValues.put("strFreezeflag",strFreezeflag);
         }
         catch(Exception m) {
             System.out.println("Error in getlegalopinionverification Method : "+m);
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
 			catch(Exception e1)
 			{
 				throw new EJBException(e1.getMessage());
 			}
 		}
    	return hshValues;
    }
    public void DetachSecurities(HashMap hshValues)
    {
    	HashMap hshQueryValues= new HashMap();
    	HashMap hshQuery= new HashMap();
    	ArrayList arrValues=new ArrayList();
    	String strAppno=Helper.correctNull((String)hshValues.get("appno"));
    	ResultSet rs=null;
    	try
    	{
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			arrValues.add(strAppno);
			arrValues.add(strAppno);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","del_releasedsec");
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");
			
			int intsize=1;
			rs=DBUtils.executeLAPSQuery("sel_unknownsec_retail^"+strAppno);
			while(rs.next())
			{
				{
					intsize++;
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					arrValues.add("P");
					arrValues.add(Helper.correctNull(rs.getString("app_sec_secid")));
					arrValues.add(strAppno);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","delsecuritydetails_fac");
					hshQueryValues.put(String.valueOf(intsize),hshQuery);
					hshQueryValues.put("size",String.valueOf(intsize));
				}
			}
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
    		
    	}
    	catch(Exception e)
		{
			throw new EJBException("Error in DetachSecurities "+e.toString());
		}
    	
    }
    public void updatelegalopinionverification(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		ArrayList arrValues = new ArrayList();
		String strsno = "";
		String strAppno = "";
		StringBuilder sbolddata=new StringBuilder();
		HashMap hshQuery = new HashMap();
		HashMap hshRecord = new HashMap();
		String remarks="";
		String strQuery="";
		String cbsid="";
		boolean boolStatus=false;	
		ResultSet rs = null;
		String appraisal="";
		ResultSet rs1= null;
		String user_dep="";
		String user_org="";
		String strAction="";
		try
		{
			String[] secID=null;
			String[] classification=null;
			String[] secval=null;
			String[] staffid=null;
			String[] staffiddesig=null;
			//String[] legalDate=null;
			
			if(hshValues.get("securityid") instanceof String[])
			{
				secID= ((String[]) hshValues.get("securityid"));		
			}else
			{
				secID=new String[1];
				secID[0]= ((String) hshValues.get("securityid"));
			}
			if(hshValues.get("classification") instanceof String[])
			{
				classification= ((String[]) hshValues.get("classification"));		
			}else
			{
				classification=new String[1];
				classification[0]= ((String) hshValues.get("classification"));
			}
			if(hshValues.get("securityval") instanceof String[])
			{
				secval= ((String[]) hshValues.get("securityval"));		
			}else
			{
				secval=new String[1];
				secval[0]= ((String) hshValues.get("securityval"));
			}
			if(hshValues.get("txt_convertedid") instanceof String[])
			{
				staffid= ((String[]) hshValues.get("txt_convertedid"));		
			}else
			{
				staffid=new String[1];
				staffid[0]= ((String) hshValues.get("txt_convertedid"));
			}
			if(hshValues.get("txtdesignation") instanceof String[])
			{
				staffiddesig= ((String[]) hshValues.get("txtdesignation"));		
			}else
			{
				staffiddesig=new String[1];
				staffiddesig[0]= ((String) hshValues.get("txtdesignation"));
			}
			if(Helper.correctNull((String) hshValues.get("sessionModuleType")).equalsIgnoreCase("RET"))
			{
		         strAction = Helper.correctNull((String) hshValues.get("hidAction"));
			}
			else
			{
			      strAction = Helper.correctNull((String) hshValues.get("hidActionforlov"));
			}
			strAppno = Helper.correctNull((String) hshValues.get("appno"));
			String strUserId = Helper.correctNull((String) hshValues.get("strUserId"));
			String strOrgShortCode = Helper.correctNull((String) hshValues.get("strOrgShortCode"));
			if(rs1!=null)
				rs1.close();
			rs1=DBUtils.executeLAPSQuery("selectusername^"+strUserId);
			if(rs1.next())
			{
				if(Helper.correctNull((String)rs1.getString("USR_ORGCODE")).equalsIgnoreCase("001000000000000"))
				{
				user_dep=Helper.correctNull((String)rs1.getString("USR_DEPARTMENT"));
				}
				else
				{
				user_dep="";	
				}
				user_org=Helper.correctNull((String)rs1.getString("USR_ORGCODE"));
			}
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno = Helper.correctNull((String) hshValues.get("strappno"));
			}	
			
			if (strAction.equals("insert"))
			{
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "dellopverif");
				arrValues = new ArrayList();
				arrValues.add(strAppno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				
				int TotalNo = secID.length;
				for(int j=0;j<TotalNo;j++)
				{
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQueryValues.put("size", "1");
					hshQuery.put("strQueryId", "inslopverif");
					arrValues.add(strAppno);
					arrValues.add(secID[j]);
					String classificat=classification[j];
					if(rs1!=null)
						rs1.close();
					rs1=DBUtils.executeLAPSQuery("securitydecode^"+classificat);
					if(rs1.next())
					{
						arrValues.add(Helper.correctNull((String)rs1.getString("SEC_ID")));
						
					}
					arrValues.add(secval[j]);
					arrValues.add(staffid[j]);
					
					arrValues.add(strUserId);
					
					arrValues.add(user_dep);
					arrValues.add(user_org);
					arrValues.add(staffiddesig[j]);
					arrValues.add(FwHelper.correctNull((String) hshValues.get("txtToDate"+j)));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);			
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				}
			}		
			else if (strAction.equalsIgnoreCase("Delete"))
			{
				//hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "dellopverif");
				arrValues = new ArrayList();
				arrValues.add(strAppno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			}
			
		}
		catch (Exception e)
		{
			throw new EJBException("Error in updatelegalopinionverification " + e.getMessage());
		}
		finally
		{
			try
			{
				if(rs1!=null)
					rs1.close();
				if(rs!=null)
					rs.close();
			}
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection " + e.getMessage());
			}
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
		String strQuery = "";
		ResultSet rs1 = null;
		String strQuery2 = "";
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
}