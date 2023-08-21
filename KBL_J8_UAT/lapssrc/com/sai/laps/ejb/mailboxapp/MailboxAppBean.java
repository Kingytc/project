package com.sai.laps.ejb.mailboxapp;

import java.sql.ResultSet;
import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "MailboxAppBean", mappedName = "MailboxAppHome")
@Remote (MailboxAppRemote.class)
public class MailboxAppBean extends BeanAdapter {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(MailboxAppBean.class);

@SuppressWarnings("unchecked")
public HashMap getData(HashMap hshRequestValues)  
{
	ResultSet rs = null,rs1 = null,rs3=null,rs5=null;
	ArrayList vecVal = new ArrayList();
	ArrayList vecRec = null;
	HashMap hshRecord = new HashMap();
	ArrayList vecData2 = new ArrayList();
	String strQuery = "",strQuery1= "";
	String strLoanType = "",desc="";
	String strSolLoanTypeSelect="";
	String strUser = ""	,strqueryparam="";
	String strMailBoxCom = "0";
	String strMailBoxPer = "0";
	String strMailBoxAgr = "0";
	String strMailBoxNPA="0";
	String strMailBoxMON="0";
	String strMailBoxTL="0";
	String strMailBoxTer="0";
	String strFromlink="";
	String strMailBoxBST="0";
	String strMailBoxmst="0";
	String strMailBoxsre="0";
	String strMailBoxStl="0";
	String strMailBoxadc="0";
	String strMailBoxINS="0";
	String strMailBoxSol="0";
	String strMailBoxKpow="0";
	String strMailBoxFin="0";
	String strMailBoxPerOL="0",strMailBoxAgrOL="0",strMailBoxComOL="0",strMailBoxGoldOL="0";
	String strMailBoxSOC="0";
	String strMailBoxSCM="0";
	String strMailBoxDEV="0";
	String strMailBoxGold="0";
	String strMailBoxDigi="0";
	String strMailBoxReval="0";
	String strMBSentQuery="0";
	String strMBRepliedQuery="0";
	String strMailBoxCORPDigi="0",strMailBoxGoldDigi="0";
	String strMailBoxMSME="0";
	String strMailBoxBANKER="0";
	String strMailBoxAgriDigi="0";
	int noCol = 0;
	String strmsmeusr="",strmsmepropuser="";
	String strOrgscode=correctNull((String) hshRequestValues.get("strOrgShortCode"));
	String strOrgLevel=correctNull((String) hshRequestValues.get("strOrgLevel"));
	String strUserClass=correctNull((String) hshRequestValues.get("strUserClass"));
	String strUserDepartment=correctNull((String) hshRequestValues.get("strUserDepartment"));
	String strOrgCode=correctNull((String) hshRequestValues.get("strOrgCode"));
	try {
		hshRecord = new HashMap();
		strLoanType = correctNull((String) hshRequestValues.get("optformtype"));
		strUser = correctNull((String) hshRequestValues.get("strUserId"));
		strFromlink=correctNull((String)hshRequestValues.get("fromlink"));
		if(strFromlink.equalsIgnoreCase("mailbox"))
		{
			if(rs!=null) 
				rs.close();
			
			strQuery=SQLParser.getSqlQuery("mailboxcountCCandnormal^" + strUser+"^"+strUser+"^"+strUser+"^"+strUser+"^"+strUser+"^"+strUser+"^"+strUser+"^"+strUser);
			rs = DBUtils.executeQuery(strQuery);
			
			while (rs.next())
			{
				String strLoanTypeselect=Helper.correctNull(rs.getString("app_loantype"));
				
				if(strLoanTypeselect.equalsIgnoreCase("P"))
					strMailBoxPer = correctNull(rs.getString("appno"));
				else if(strLoanTypeselect.equalsIgnoreCase("A"))
					strMailBoxAgr = correctNull(rs.getString("appno"));
				else if(strLoanTypeselect.equalsIgnoreCase("C"))
					strMailBoxCom = correctNull(rs.getString("appno"));
				else if(strLoanTypeselect.equalsIgnoreCase("T"))
					strMailBoxTer = correctNull(rs.getString("appno"));
				else if(strLoanTypeselect.equalsIgnoreCase("E"))
					strMailBoxsre = correctNull(rs.getString("appno"));
				else if(strLoanTypeselect.equalsIgnoreCase("U"))
					strMailBoxStl = correctNull(rs.getString("appno"));
				else if(strLoanTypeselect.equalsIgnoreCase("H"))
					strMailBoxadc = correctNull(rs.getString("appno"));
				else if(strLoanTypeselect.equalsIgnoreCase("J"))
					strMailBoxGold = correctNull(rs.getString("appno"));
				else if(strLoanTypeselect.equalsIgnoreCase("D"))
					strMailBoxDigi = correctNull(rs.getString("appno"));
				else if(strLoanTypeselect.equalsIgnoreCase("MD"))
					strMailBoxCORPDigi = correctNull(rs.getString("appno"));
				else if(strLoanTypeselect.equalsIgnoreCase("AG"))				
					strMailBoxAgriDigi = correctNull(rs.getString("appno"));
				else if(strLoanTypeselect.equalsIgnoreCase("JD"))
					strMailBoxGoldDigi = correctNull(rs.getString("appno"));
				
				
			}
			if(rs!=null) 
				rs.close();
			
			strQuery=SQLParser.getSqlQuery("mailboxcountsolsel^" + strUser);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				 strSolLoanTypeSelect=Helper.correctNull(rs.getString("sol_loantype"));
				 if(strSolLoanTypeSelect.equalsIgnoreCase("SOL"))
				 strMailBoxSol = correctNull(rs.getString("appno"));
			}
			if(rs!=null) 
				rs.close();
			
			strQuery=SQLParser.getSqlQuery("mailboxcountkpowsel^" + strUser);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				 strSolLoanTypeSelect="KPOW";
				 strMailBoxKpow = correctNull(rs.getString("appno"));
			}
			
			strQuery=SQLParser.getSqlQuery("mailboxcountFIN^" + strUser);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				 strSolLoanTypeSelect="FIN";
				 strMailBoxFin = correctNull(rs.getString("appno"));
			}
			if(rs!=null) 
				rs.close();
			strQuery=SQLParser.getSqlQuery("mailboxcountbankersel^" + strUser);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				 strSolLoanTypeSelect=Helper.correctNull(rs.getString("BANKER_LOANTYPE"));
				 if(strSolLoanTypeSelect.equalsIgnoreCase("BANKER"))
					 strMailBoxBANKER = correctNull(rs.getString("appno"));
			}
			if(rs!=null) 
				rs.close();
			
			strQuery=SQLParser.getSqlQuery("mailboxcountOLPROPOSAL^" + strUser+"^"+strUser+"^"+strUser);
			rs = DBUtils.executeQuery(strQuery);
			
			while (rs.next())
			{
				String strLoanTypeselect=Helper.correctNull(rs.getString("app_loantype"));
				
				if(strLoanTypeselect.equalsIgnoreCase("P"))
					strMailBoxPerOL = correctNull(rs.getString("appno"));
				else if(strLoanTypeselect.equalsIgnoreCase("A"))
					strMailBoxAgrOL = correctNull(rs.getString("appno"));
				else if(strLoanTypeselect.equalsIgnoreCase("C"))
					strMailBoxComOL = correctNull(rs.getString("appno"));
				else if(strLoanTypeselect.equalsIgnoreCase("J"))
					strMailBoxGoldOL = correctNull(rs.getString("appno"));
				else if(strLoanTypeselect.equalsIgnoreCase("PA"))
					strMailBoxGoldOL = correctNull(rs.getString("appno"));
				else if(strLoanTypeselect.equalsIgnoreCase("AG"))
					strMailBoxAgriDigi = correctNull(rs.getString("appno"));
			}
			
			strQuery=SQLParser.getSqlQuery("mailboxcountSOC^" + strUser+"^"+strOrgscode);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				 strSolLoanTypeSelect="SOC";
				 strMailBoxSOC = correctNull(rs.getString("appno"));
			}
			if(rs!=null) 
				rs.close();
			if(Helper.correctNull((String)hshRequestValues.get("strOrgLevel")).equalsIgnoreCase("C"))
				strQuery=SQLParser.getSqlQuery("mailboxcountSCM^" + strUser+"^"+strOrgscode+"^ and (secorgdept='"+Helper.correctNull((String)hshRequestValues.get("strUserDepartment"))+"' or secorgdept is null)");
			else
				strQuery=SQLParser.getSqlQuery("mailboxcountSCM^" + strUser+"^"+strOrgscode+"^ ");
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				 strSolLoanTypeSelect="SCM";
				 strMailBoxSCM = correctNull(rs.getString("appno"));
			}
			
			
			if(rs!=null) 
				rs.close();
			strQuery=SQLParser.getSqlQuery("mailboxcountDEV^" + strUser);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				 strSolLoanTypeSelect="DEV";
				 strMailBoxDEV = correctNull(rs.getString("appno"));
			}
			if(rs!=null) 
				rs.close();
			strQuery=SQLParser.getSqlQuery("sel_revalidate_app^" + strUser+"^"+strUser);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				 strSolLoanTypeSelect="REVAL";
				 strMailBoxReval = correctNull(rs.getString("appno"));
			}
			
			//ADDED FOR MSME PROPOSAL COUNT//
			/*if(rs!=null) 
				rs.close();
			if(Helper.correctNull((String)hshRequestValues.get("strOrgLevel")).equalsIgnoreCase("C"))
				strQuery=SQLParser.getSqlQuery("sel_msmemailbox^" + strUser+"^"+strOrgscode+"^ and (secorgdept='"+Helper.correctNull((String)hshRequestValues.get("strUserDepartment"))+"' or secorgdept is null)");
			else*/
		
			if(Helper.correctNull((String)hshRequestValues.get("strOrgLevel")).equalsIgnoreCase("C"))
				strQuery = SQLParser.getSqlQuery("selotherparam_ratexpos^M"+Helper.correctNull((String)hshRequestValues.get("strUserDepartment")));
			else if(Helper.correctNull((String)hshRequestValues.get("strOrgLevel")).equalsIgnoreCase("R"))
				strQuery = SQLParser.getSqlQuery("selotherparam_ratexpos^"+"M006");
			else if(Helper.correctNull((String)hshRequestValues.get("strOrgLevel")).equalsIgnoreCase("D"))
				strQuery = SQLParser.getSqlQuery("selotherparam_ratexpos^"+"M005");
			else 
				strQuery = SQLParser.getSqlQuery("selotherparam_ratexpos^"+"M004");
		 	if(rs!=null)
		 		rs.close();
		 	String strparamval="0";
		 	
		 	rs = DBUtils.executeQuery(strQuery);
		 	if(rs.next())
		 	{
		 		hshRecord.put("strMSMEMinpower", Helper.correctNull(rs.getString("LOAN_PARAMVAL1")));
		 		strparamval=Helper.correctInt(rs.getString("LOAN_PARAMVAL1"));
		 	}
		 	
		 		if(Integer.parseInt(strUserClass)>=Integer.parseInt(strparamval)){
					strqueryparam=" and MSME_APPSTATUS in('op') ";
					//strmsmepropuser=" ";
				}
		 		
				else{
					
					strqueryparam=" or ( MSME_CREATED_BY IN('"+strUser+"')" +" and MSME_APPSTATUS in('OP','rb','sb'))" ;				
					//strqueryparam=" ";

				}
		 	
			
			strQuery=SQLParser.getSqlQuery("sel_msmemailbox^"+strOrgscode+"^"+strOrgCode+"^" +strqueryparam);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{	strSolLoanTypeSelect="MSME";

				 strMailBoxMSME = correctNull(rs.getString("appno"));
			}
			//END//
//			if(rs!=null) 
//				rs.close();
//			strQuery=SQLParser.getSqlQuery("cnt_sentQuery^" + strUser);
//			rs = DBUtils.executeQuery(strQuery);
//			if(rs.next())
//			{
//				strSolLoanTypeSelect="REQ";
//				strMBSentQuery = correctNull(rs.getString("cnt"));
//			}
//			if(rs!=null) 
//				rs.close();
//			strQuery=SQLParser.getSqlQuery("cnt_repliedQuery^" + strUser);
//			rs = DBUtils.executeQuery(strQuery);
//			if(rs.next())
//			{
//				strSolLoanTypeSelect="RES";
//				strMBRepliedQuery = correctNull(rs.getString("cnt"));
//			}
			
			if(rs!=null) 
				rs.close();
			hshRecord.put("strMailBoxPer", strMailBoxPer);
			hshRecord.put("strMailBoxCom", strMailBoxCom);
			hshRecord.put("strMailBoxAgr", strMailBoxAgr);
			hshRecord.put("strMailBoxTer", strMailBoxTer);
			hshRecord.put("strMailBoxNPA", strMailBoxNPA);
			hshRecord.put("strMailBoxMON", strMailBoxMON);
			hshRecord.put("strMailBoxTL", strMailBoxTL);
			hshRecord.put("strMailBoxBST", strMailBoxBST);
			hshRecord.put("strMailBoxmst", strMailBoxmst);
			hshRecord.put("strMailBoxsre", strMailBoxsre);
			hshRecord.put("strMailBoxStl", strMailBoxStl);
			hshRecord.put("strMailBoxadc", strMailBoxadc);
			hshRecord.put("strMailBoxINS", strMailBoxINS);
			hshRecord.put("strMailBoxSol", strMailBoxSol);
			hshRecord.put("strMailBoxKpow", strMailBoxKpow);
			hshRecord.put("strMailBoxFin", strMailBoxFin);
			hshRecord.put("strMailBoxPerOL", strMailBoxPerOL);
			hshRecord.put("strMailBoxAgrOL", strMailBoxAgrOL);
			hshRecord.put("strMailBoxComOL", strMailBoxComOL);
			hshRecord.put("strMailBoxSOC", strMailBoxSOC);
			hshRecord.put("strMailBoxGold", strMailBoxGold);
			hshRecord.put("strMailBoxGoldOL", strMailBoxGoldOL);
			hshRecord.put("strMailBoxSCM", strMailBoxSCM);
			hshRecord.put("strMailBoxDEV", strMailBoxDEV);
//			hshRecord.put("strMBSentQuery", strMBSentQuery);
//			hshRecord.put("strMBRepliedQuery", strMBRepliedQuery);
			hshRecord.put("strMailBoxDigi", strMailBoxDigi);
			hshRecord.put("strMailBoxReval", strMailBoxReval);
			hshRecord.put("strMailBoxCORPDigi", strMailBoxCORPDigi);
			hshRecord.put("strMailBoxMSME", strMailBoxMSME);
			hshRecord.put("strMailBoxBANKER", strMailBoxBANKER);
			hshRecord.put("strMailBoxGoldDigi", strMailBoxGoldDigi);
			hshRecord.put("strMailBoxAgriDigi", strMailBoxAgriDigi);
			if(rs!=null)
				rs.close();
			strQuery=SQLParser.getSqlQuery("selotherparam_ratexpos^"+strOrgLevel+strUserDepartment);
			String strRights="0";
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strRights = Helper.correctInt(rs.getString("loan_paramval"));
				if(Integer.parseInt(strRights)<=Integer.parseInt(strUserClass))
				{
					hshRecord.put("strSOCFlag", "Y");
				}
			}
		}
		
		
		if (!strLoanType.equals("")) 
		{
			if (strLoanType.equals("E") || strLoanType.equals("U") || strLoanType.equals("H")) 
			{
				strQuery = SQLParser.getSqlQuery("mailboxcomwithCC^"+strUser+"^"+ strLoanType );
				noCol = 15;
			} 
			else if (strLoanType.equals("P")) 
			{
				strQuery = SQLParser.getSqlQuery("mailboxperwithCC^" + strUser+"^pH','pA','pP','pM','pU','pK','pE','pL','pI','pC','pN','pJ','pV','pS','pB");
				noCol = 16;
			}
			else if (strLoanType.equals("A")||strLoanType.equals("C")) 
			{
				strQuery = SQLParser.getSqlQuery("mailboxcomwithCCnew^" +strUser+"^"+ strLoanType);
				noCol = 16;
			}
			
			else if (strLoanType.equals("SOL")) 
			{
				strQuery = SQLParser.getSqlQuery("mailboxsolwithCC^" +strUser+"^"+ strLoanType);
				noCol = 8;
			}

			else if (strLoanType.equals("KPOW")) 
			{
				strQuery = SQLParser.getSqlQuery("mailboxkpowwithCC^" +strUser+"^"+ strLoanType);
				noCol = 8;
			}
			
			
			else if (strLoanType.equals("FIN")) 
			{
				strQuery = SQLParser.getSqlQuery("mailboxfinwithCC^" +strUser+"^"+ strLoanType);
				noCol = 9;
			}
			else if (strLoanType.equals("COM_OL")) 
			{
				strQuery = SQLParser.getSqlQuery("mailboxcomwithOL^"+strUser+"^C" );
				noCol = 14;
			} 
			else if (strLoanType.equals("PER_OL")) 
			{
				strQuery = SQLParser.getSqlQuery("mailboxperwithOL^" + strUser+"^pH','pA','pP','pM','pU','pK','pE','pL','pI','pC','pN','pJ','pV");
				noCol = 14;
			}
			else if (strLoanType.equals("AGR_OL")) 
			{
				strQuery = SQLParser.getSqlQuery("mailboxcomwithOL^" +strUser+"^A");
				noCol = 14;
			}
			else if (strLoanType.equals("JL_OL")) 
			{
				strQuery = SQLParser.getSqlQuery("mailboxperwithOL^" + strUser+"^pG','pR");
				noCol = 13;
			}
			else if (strLoanType.equals("SOC")) 
			{
				noCol = 8;
			}
			else if (strLoanType.equals("SCM")) 
			{
				noCol = 8;
			}
			else if (strLoanType.equals("DEV")) 
			{
				noCol = 6;
			}
			else if (strLoanType.equals("REQ")) 
			{
				noCol = 6;
			}
			else if (strLoanType.equals("RES")) 
			{
				noCol = 6;
			}
			else if (strLoanType.equals("J")) 
			{
				strQuery = SQLParser.getSqlQuery("mailboxperwithCC^" + strUser+"^pG','pR");
				noCol = 14;
			}
			else if (strLoanType.equals("DIGI")) 
			{
				strQuery = SQLParser.getSqlQuery("mailboxperwithCC_digiappl^" + strUser+"^pH','pA','pP','pM','pU','pK','pE','pL','pI','pC','pN','pJ','pV','pS','pB");
				noCol = 14;
			}
			else if (strLoanType.equals("DIGICORP")) 
			{
				strLoanType="C";
				strQuery = SQLParser.getSqlQuery("mailboxcomwithCC_digi^"+strUser+"^"+ strLoanType );
				noCol = 14;
			}
			else if (strLoanType.equals("DIGIAGRI"))
			{
				strLoanType="A";
				strQuery = SQLParser.getSqlQuery("mailboxcomwithCC_digi_agri^"+strUser+"^"+strLoanType);
				noCol = 14;
			}
			else if (strLoanType.equals("REVAL")) 
			{
				strQuery = SQLParser.getSqlQuery("revalmailbox^" + strUser+"^"+strUser);
				noCol = 8;
			}
			else if (strLoanType.equals("BANKER")) 
			{
				strQuery = SQLParser.getSqlQuery("mailboxbankerwithCC^" +strUser+"^"+ strLoanType);
				noCol = 8;
			}
			else if (strLoanType.equals("DIGIGOLD")) 
			{
				strQuery = SQLParser.getSqlQuery("mailboxperwithCCdigigold^" + strUser+"^pG','pR");
				noCol = 14;
			}
			if(rs!=null) 
				rs.close();
			if (!strLoanType.equalsIgnoreCase("PI")&&!strLoanType.equalsIgnoreCase("N")&&!strLoanType.equalsIgnoreCase("M") && !strLoanType.equalsIgnoreCase("TL") &&!strLoanType.equalsIgnoreCase("S") &&!strLoanType.equalsIgnoreCase("B") &&!strLoanType.equalsIgnoreCase("D")&&!strLoanType.equalsIgnoreCase("SOC")&&!strLoanType.equalsIgnoreCase("SCM")&&!strLoanType.equalsIgnoreCase("DEV")&&!strLoanType.equalsIgnoreCase("REQ")&&!strLoanType.equalsIgnoreCase("RES")&&!strLoanType.equalsIgnoreCase("MSME"))
			{
				rs = DBUtils.executeQuery(strQuery);
					while (rs.next()) 
					{
						vecRec = new ArrayList();
						for (int i = 0; i < noCol; i++) 
						{
							String strValue = correctNull(rs.getString(i + 1));
							if ((strLoanType.equalsIgnoreCase("T") && i==3) || (i == 4 && !strLoanType.equalsIgnoreCase("T")) || (strLoanType.equalsIgnoreCase("SOL") && i==6) || (strLoanType.equalsIgnoreCase("KPOW") && i==6)  || (strLoanType.equalsIgnoreCase("FIN") && i==3)|| (strLoanType.equalsIgnoreCase("REVAL") && i==3)) 
							{
								if (strValue.equalsIgnoreCase("CA")) 
								{
									strValue = "Closed/Approved";
								}
								else if (strValue.equalsIgnoreCase("OP")) 
								{
									strValue = "Open/Pending";
								}
								else if (strValue.equalsIgnoreCase("PA")) 
								{
									strValue = "Processed/Approved";
								}
								else if (strValue.equalsIgnoreCase("PR")) 
								{
									strValue = "Processed/Rejected";
								}
								else if (strValue.equalsIgnoreCase("CR")) 
								{
									strValue = "Closed/Rejected";
								}
								else if (strValue.equalsIgnoreCase("OL")) 
								{
									strValue = "Open/Lodged";
								}
							}
							if((strLoanType.equalsIgnoreCase("P")&& i==11)||((strLoanType.equalsIgnoreCase("A")||strLoanType.equalsIgnoreCase("C"))&& i==12)||(strLoanType.equalsIgnoreCase("J")&& i==11) ||(strLoanType.equalsIgnoreCase("DIGIGOLD")&& i==11)  || (strLoanType.equalsIgnoreCase("DIGI")&& i==11)||(strLoanType.equalsIgnoreCase("REVAL")&& i==11) )
							{
								if (strValue.equalsIgnoreCase("R")) 
								{
									vecRec.add("Renewal");
								}
								else if (strValue.equalsIgnoreCase("S")) 
								{
									vecRec.add("Restructured");
								}
								else if (strValue.equalsIgnoreCase("P")) 
								{
									vecRec.add("Post Sanction");
								}
								else
								{
									vecRec.add("Fresh");
								}
							}
							
							if(strLoanType.equalsIgnoreCase("REVAL")&& i==6)
							{
								if (strValue.equalsIgnoreCase("P")) 
								{
									vecRec.add("Retail");
								}
								else if (strValue.equalsIgnoreCase("A")) 
								{
									vecRec.add("Agriculture");
								}
								else if (strValue.equalsIgnoreCase("C")) 
								{
									vecRec.add("Corporate");
								}
								else
								{
									vecRec.add("");
								}
							}
							vecRec.add(strValue);
							
							
							// added newly for take over and total proposed amount
							if(i==13){
								if(strLoanType.equalsIgnoreCase("P") || strLoanType.equalsIgnoreCase("J")){
									strQuery1 = SQLParser.getSqlQuery("selecttakeover"+"^"+vecRec.get(0));
						 			 rs1 = DBUtils.executeQuery(strQuery1);
									 if (rs1.next()) 
						 			 {
										 String takeover=correctNull(rs1.getString("loan_takeover"));
										 if(!takeover.equalsIgnoreCase("")){
											 if(takeover.equalsIgnoreCase("Y")){
												 takeover="Yes"; 
											 }
                                        if(takeover.equalsIgnoreCase("N")){
                                        	takeover="No"; 
											 }
										 }
										 vecRec.add(takeover);  // 15
										 vecRec.add(correctNull(rs1.getString("loan_amtreqd"))); // 16
						 			 }else{
						 				vecRec.add(""); // 15
						 				vecRec.add(""); // 16
						 			 }
								}
								if(strLoanType.equalsIgnoreCase("C") || strLoanType.equalsIgnoreCase("A")){
									strQuery1 = SQLParser.getSqlQuery("selectfacilitysancamt"+"^"+vecRec.get(0));
						 			 rs1 = DBUtils.executeQuery(strQuery1);
									 if (rs1.next()) 
						 			 {
										 vecRec.add(correctNull(rs1.getString("facility_proposed"))); // 15
						 			 }else{
						 				vecRec.add(""); // 15
						 			 }
									 
									 strQuery1 = SQLParser.getSqlQuery("sel_takeover_details"+"^"+vecRec.get(0));
						 			 rs1 = DBUtils.executeQuery(strQuery1);
									 if (rs1.next()) 
						 			 {
										 String takeover=correctNull(rs1.getString("comtak_istakeover"));
										 if(!takeover.equalsIgnoreCase("")){
											 if(takeover.equalsIgnoreCase("1")){
												 takeover="Yes"; 
											 }
                                        if(takeover.equalsIgnoreCase("2")){
                                        	takeover="No"; 
											 }
										 } 
										 vecRec.add(takeover);  // 16
						 			 }else{
						 				vecRec.add(""); // 16
						 			 }
								}
							}
							 // ends
						}
						vecVal.add(vecRec);
						
						
					}	
					//Removal of CC
						if(rs != null)
							rs.close();
				
					hshRecord.put("vecVal", vecVal);
			 }
		 	 else if(strLoanType.equalsIgnoreCase("N"))
		 	 {
	 			 strQuery = SQLParser.getSqlQuery("npamailappno"+"^"+ strUser);
	 			 if(rs!=null)
	 				 rs.close();
	 			 rs = DBUtils.executeQuery(strQuery);
	 
				 while (rs.next()) 
	 			 {
	 				 vecRec = new ArrayList();
					 for (int i = 0; i < noCol; i++) 
	 				 {
	 					 String strValue = correctNull(rs.getString(i + 1));
	 					 if (i == 4) 
	 					 {
	 						 if (strValue.equalsIgnoreCase("CA")) 
	 						 {
								strValue = "Closed/Approved";
	 						 } 
	 						 else if ((strValue.equalsIgnoreCase("OP")) || (strValue.equalsIgnoreCase("PP"))) 
	 						 {
								strValue = "Open/Pending";
	 						 } 
	 						 else if (strValue.equalsIgnoreCase("PA")) 
	 						 {
								strValue = "Processed/Approved";
	 						 } 
	 						 else if (strValue.equalsIgnoreCase("PR")) 
	 						 {
								strValue = "Processed/Rejected";
	 						 }
	 						 else if (strValue.equalsIgnoreCase("CR")) 
	 						 {
								strValue = "Closed/Rejected";
	 						 }
	 						 else if (strValue.equalsIgnoreCase("OL")) 
	 						 {
								strValue = "Open/Lodged";
	 						 }
	 					 }
	 					 vecRec.add(strValue);
	 				 }
	 				 vecVal.add(vecRec);
	 			 }
			 hshRecord.put("vecVal", vecVal);
		 	}
		 	else if(strLoanType.equalsIgnoreCase("M"))
		 	 {
		 		 strQuery = SQLParser.getSqlQuery("monmailappno^"+ strUser);
		 		 if(rs!=null)
		 			 rs.close();
				 rs = DBUtils.executeQuery(strQuery);
					
				 while (rs.next()) 
				 {
					 vecRec = new ArrayList();
					 for (int i = 0; i < noCol; i++) 
					 {
						 String strValue = correctNull(rs.getString(i + 1));
						 vecRec.add(strValue);
					 }
					 vecVal.add(vecRec);
				}
				hshRecord.put("vecVal", vecVal);
			}
			//added by Mercy for Term Loan Review
		 	else if(strLoanType.equalsIgnoreCase("TL"))
		 	{
		 		strQuery = SQLParser.getSqlQuery("mon_TLReviewMail^"+ strUser);
		 		rs = DBUtils.executeQuery(strQuery);
		 		while (rs.next())
			 	{
		 			vecRec = new ArrayList();
			 		vecRec.add(correctNull((String)rs.getString("tlr_appno")));
			 		vecRec.add(correctNull((String)rs.getString("tlr_cbsid")));
					if (correctNull((String)rs.getString("tlr_status")).equalsIgnoreCase("CA")) 
					{
						vecRec.add("CLOSED");
					} 
					else if (correctNull((String)rs.getString("tlr_status")).equalsIgnoreCase("OP")) 
					{
						vecRec.add("PENDING");
					} 
					else if (correctNull((String)rs.getString("tlr_status")).equalsIgnoreCase("PA")) 
					{
						vecRec.add("APPROVED");
					} 
					
			 		vecRec.add(correctNull((String)rs.getString("mon_termloanreview_fromusrid")));
			 		vecRec.add(correctNull((String)rs.getString("mon_termloanreview_maildate")));
			 		vecRec.add(correctNull((String)rs.getString("tlr_year")));
			 		vecRec.add(correctNull((String)rs.getString("tlr_year")));
			 		vecRec.add(correctNull((String)rs.getString("tlr_year")));
			 		vecRec.add(correctNull((String)rs.getString("mon_termloanreview_tousrid")));
			 		vecRec.add(correctNull((String)rs.getString("personal_custname")));
			 		vecRec.add(correctNull((String)rs.getString("org_name")));
			 		vecRec.add(correctNull((String)rs.getString("tlr_status")));
			 		vecVal.add(vecRec);
			 	}
			 	hshRecord.put("vecVal", vecVal);
			}
		 	else if(strLoanType.equalsIgnoreCase("S"))
		 	 {
		 		String strapp_processat="";
		 		String IsSaralhead="N";
		 		String ISorghead="N";
		 		String strorgcode=Helper.correctNull((String)hshRequestValues.get("strOrgCode"));
		 		
		 		if(correctNull((String)hshRequestValues.get("strOrgLevel")).equalsIgnoreCase("D"))
		 		{
		 			strorgcode=strorgcode.substring(0,9);
		 			strapp_processat="2";
		 		}
		 		else if(correctNull((String)hshRequestValues.get("strOrgLevel")).equalsIgnoreCase("A"))
		 		{
		 			strorgcode=strorgcode.substring(0,12);
		 			strapp_processat="2";
		 		}
		 		if(correctNull((String)hshRequestValues.get("strOrgLevel")).equals("A"))
		 		{
		 			strQuery=SQLParser.getSqlQuery("setorgselect^"+
		 					correctNull((String)hshRequestValues.get("strOrgCode")));
		 			
		 			if(rs!=null)
			 			 rs.close();
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						if(correctNull(rs.getString("org_head")).equals(strUser))
						{
							ISorghead="Y";
						}
					}
		 			strQuery = SQLParser.getSqlQuery("saralmailackno^"+ strapp_processat+"^"+strorgcode+"^ ='O'");
		 		}
		 		else if(correctNull((String)hshRequestValues.get("strOrgLevel")).equals("D"))
		 		{
		 			
		 			strQuery=SQLParser.getSqlQuery("setorgselect^"+
		 					correctNull((String)hshRequestValues.get("strOrgCode")));
		 			
		 			if(rs!=null)
			 			 rs.close();
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{ 
						if(correctNull(rs.getString("org_saralhead")).equals(strUser))
						{
							strQuery = SQLParser.getSqlQuery("saralmailackno^"+ strapp_processat+"^"+strorgcode +
								"^ ='P'");
							IsSaralhead="Y";
						}
						else
						{
							strQuery = SQLParser.getSqlQuery("saralmailackno^"+ strapp_processat+
									"^"+strorgcode +"^ ='P' and inward_assignusrid='"+strUser+"'");
						}
					}
		 		}
		 		 if(rs!=null)
		 			 rs.close();
		 		 if(strQuery!="")
		 			 rs = DBUtils.executeQuery(strQuery);
					
				 while (rs.next()) 
				 {
					 vecRec = new ArrayList();
					 for (int i = 0; i < noCol; i++) 
					 {
						 String strValue = correctNull(rs.getString(i + 1));
						 vecRec.add(strValue);
					 }
					 vecRec.add(IsSaralhead);
					 vecRec.add(ISorghead);
					 vecVal.add(vecRec);
				}
				hshRecord.put("vecVal", vecVal);
				hshRecord.put("Orglevel",correctNull((String)hshRequestValues.get("strOrgLevel")));
				
			}
		 	else if(strLoanType.equalsIgnoreCase("B"))
		 	{
	 			 strQuery = SQLParser.getSqlQuery("bstmailappno"+"^"+ strUser);
	 			 if(rs!=null)
	 				 rs.close();
	 			 rs = DBUtils.executeQuery(strQuery);
	 
				 while (rs.next()) 
	 			 {
	 				 vecRec = new ArrayList();
					 for (int i = 0; i < noCol; i++) 
	 				 {
	 					 String strValue = correctNull(rs.getString(i + 1));
	 					 if (i == 4) 
	 					 {
	 						 if (strValue.equalsIgnoreCase("CA")) 
	 						 {
	 							vecRec.add("Closed/Approved");
	 						 } 
	 						 else if (strValue.equalsIgnoreCase("OP")) 
	 						 {
	 							vecRec.add("Open/Pending");
	 						 } 
	 						 else if (strValue.equalsIgnoreCase("PA")) 
	 						 {
	 							vecRec.add("Processed/Approved");
	 						 } 
	 						 else if (strValue.equalsIgnoreCase("PR")) 
	 						 {
	 							vecRec.add("Processed/Rejected");
	 						 }
	 						 else if (strValue.equalsIgnoreCase("CR")) 
	 						 {
	 							vecRec.add("Closed/Rejected");
	 						 }
	 					 }
	 					 vecRec.add(strValue);
	 				 }
	 				 vecVal.add(vecRec);
	 			 }
				 hshRecord.put("vecVal", vecVal);
		 	} 
			else if(strLoanType.equalsIgnoreCase("D"))
			{
				strQuery = SQLParser.getSqlQuery("mstmailbox"+"^"+ strUser);
			 	if(rs!=null)
			 		rs.close();
			 	rs = DBUtils.executeQuery(strQuery);
			 
				while (rs.next()) 
			 	{
					vecRec = new ArrayList();
					for (int i = 0; i < noCol; i++) 
			 		{
						String strValue = correctNull(rs.getString(i + 1));
			 			if (i == 3) 
			 			{
			 				if (strValue.equalsIgnoreCase("CA")) 
			 				{
			 					vecRec.add("Closed/Approved");
			 				} 
			 				else if (strValue.equalsIgnoreCase("OP")) 
			 				{
			 					vecRec.add("Open/Pending");
			 				} 
			 				else if (strValue.equalsIgnoreCase("PA")) 
			 				{
			 					vecRec.add("Processed/Approved");
			 				} 
			 				else if (strValue.equalsIgnoreCase("PR")) 
			 				{
			 					vecRec.add("Processed/Rejected");
			 				}
			 				else if (strValue.equalsIgnoreCase("CR")) 
			 				{
			 					vecRec.add("Closed/Rejected");
			 				}
			 			}
			 		vecRec.add(strValue);
			 		}
			 	vecVal.add(vecRec);
			 	}
				
			hshRecord.put("vecVal", vecVal);
			}
			else if(strLoanType.equalsIgnoreCase("PI"))
			{
				strQuery = SQLParser.getSqlQuery("inspectionmailbox"+"^"+ strUser);
			 	if(rs!=null)
			 		rs.close();
			 	rs = DBUtils.executeQuery(strQuery);
			 
				while (rs.next()) 
			 	{
					vecRec = new ArrayList();
					for (int i = 0; i < noCol; i++) 
			 		{
						String strValue = correctNull(rs.getString(i + 1));
			 			if (i == 3) 
			 			{
			 				if (strValue.equalsIgnoreCase("P")) 
			 				{
			 					vecRec.add("Pending");
			 				} 
			 			}
			 		vecRec.add(strValue);
			 		}
			 	vecVal.add(vecRec);
			 	}
				hshRecord.put("vecVal", vecVal);
			}
			else if(strLoanType.equalsIgnoreCase("SOC"))
			{
				strQuery = SQLParser.getSqlQuery("mailboxSOC^"+ strUser+"^"+strOrgscode);
			 	if(rs!=null)
			 		rs.close();
			 	rs = DBUtils.executeQuery(strQuery);
			 
				while (rs.next()) 
			 	{
					vecRec = new ArrayList();
					for (int i = 0; i < noCol; i++) 
			 		{
						vecRec.add(correctNull(rs.getString(i + 1)));
			 		}
					vecVal.add(vecRec);
			 	}
				hshRecord.put("vecVal", vecVal);
			}
			else if(strLoanType.equalsIgnoreCase("SCM"))
			{
				if(Helper.correctNull((String)hshRequestValues.get("strOrgLevel")).equalsIgnoreCase("C"))
					strQuery = SQLParser.getSqlQuery("mailboxSCM^"+ strUser+"^"+strOrgscode+"^ and (secorgdept='"+Helper.correctNull((String)hshRequestValues.get("strUserDepartment"))+"' or secorgdept is null)");
				else
					strQuery = SQLParser.getSqlQuery("mailboxSCM^"+ strUser+"^"+strOrgscode+"^ ");
			 	if(rs!=null)
			 		rs.close();
			 	rs = DBUtils.executeQuery(strQuery);
			 
				while (rs.next()) 
			 	{
					vecRec = new ArrayList();
					for (int i = 0; i < noCol; i++) 
			 		{
						vecRec.add(correctNull(rs.getString(i + 1)));
			 		}
					vecVal.add(vecRec);
			 	}
				hshRecord.put("vecVal", vecVal);
			}	
			else if(strLoanType.equalsIgnoreCase("DEV"))
			{
				
			 	if(rs!=null)
			 		rs.close();
			 	strQuery = SQLParser.getSqlQuery("mailboxDEV^"+ strUser);
			 	rs = DBUtils.executeQuery(strQuery);
			 	String strname="";
				while (rs.next()) 
			 	{
					vecRec = new ArrayList();
					for (int i = 0; i < noCol; i++) 
			 		{
						strname=rs.getString(2);
						if(i==1 && strname==null)
						{
							 vecRec.add(correctNull(rs.getString("PG_EMPLOYERNAME")));
						}
						else if(i==5){
							String Org_Scode=(correctNull(rs.getString(i + 1)));
							if(rs1!=null)rs1.close();
							strQuery = SQLParser.getSqlQuery("selectorgappl^"+ Org_Scode);
						 	rs1 = DBUtils.executeQuery(strQuery);
						 	if(rs1.next()){
						 		vecRec.add(correctNull(rs1.getString("ORG_NAME")));
						 	}
						}
						else
						{
							vecRec.add(correctNull(rs.getString(i + 1)));
						}	
			 		}
					vecVal.add(vecRec);
			 	}
				hshRecord.put("vecVal", vecVal);
			}	
			else if(strLoanType.equalsIgnoreCase("REQ"))
			{
				
				if(rs!=null)
					rs.close();
				strQuery = SQLParser.getSqlQuery("sel_sentQueryDet^"+ strUser);
				rs = DBUtils.executeQuery(strQuery);
				
				while (rs.next()) 
				{
					vecRec = new ArrayList();
					for (int i = 0; i < noCol; i++) 
					{
						vecRec.add(correctNull(rs.getString(i + 1)));
					}
					vecVal.add(vecRec);
				}
				hshRecord.put("vecVal", vecVal);
			}	
			else if(strLoanType.equalsIgnoreCase("RES"))
			{
				
				if(rs!=null)
					rs.close();
				strQuery = SQLParser.getSqlQuery("sel_RepliedQueryDet^"+ strUser);
				rs = DBUtils.executeQuery(strQuery);
				
				while (rs.next()) 
				{
					vecRec = new ArrayList();
					for (int i = 0; i < noCol; i++) 
					{
						vecRec.add(correctNull(rs.getString(i + 1)));
					}
					vecVal.add(vecRec);
				}
				hshRecord.put("vecVal", vecVal);
			}	
			
			else if(strLoanType.equalsIgnoreCase("MSME"))
		 	{
		 		strQuery = SQLParser.getSqlQuery("sel_msmelist^"+strOrgscode+"^"+strOrgCode+"^" +strqueryparam);
		 		rs = DBUtils.executeQuery(strQuery);
		 		String strcbsd="",strappid="",strmsmeorgname="",strmsmeusername="",strverorglevel="",strverificationflag="";
		 		ArrayList vecvef = new ArrayList();
		 		while (rs.next())
			 	{
		 			vecRec = new ArrayList();
			 		vecRec.add(correctNull((String)rs.getString("MSME_APPNO")));//0
			 		strcbsd=correctNull((String)rs.getString("MSME_CBSID"));
			 		vecRec.add(strcbsd);//1
			 		vecRec.add(correctNull((String)rs.getString("MSME_CREATED_BY")));//2
			 		vecRec.add(correctNull((String)rs.getString("MSME_CREATED_ON")));//3
			 		vecRec.add(correctNull((String)rs.getString("MSME_INITIATED_USER")));//4
			 		strQuery = SQLParser.getSqlQuery("sel_msmesearchbycbsid^"+ strcbsd);
			 		rs1 = DBUtils.executeQuery(strQuery);
			 		if(rs1.next()){
				 		vecRec.add(correctNull((String)rs1.getString("perappname")));//5
				 		strappid=correctNull((String)rs1.getString("perapp_oldid"));
				 		

			 		}
			 		else
			 			vecRec.add("");
			 		vecRec.add(correctNull((String)rs.getString("MSME_APPROVEDBY")));//6
			 		vecRec.add(correctNull((String)rs.getString("MSME_INITIATEDON")));//7
			 		vecRec.add(correctNull((String)rs.getString("MSME_APPSTATUS")));//8
			 		
			 		if(rs3!=null){
			 			rs3.close();
			 		}
			 		strQuery = SQLParser.getSqlQuery("sel_msmeorgval^"+Helper.correctNull((String)rs.getString("MSME_ApprovedOrg")));
					rs3 = DBUtils.executeQuery(strQuery);
					if(rs3.next()){
						strmsmeorgname=Helper.correctNull((String)rs3.getString("ORG_NAME"));
					}
					strQuery = SQLParser.getSqlQuery("selectusername^"+Helper.correctNull((String)rs.getString("MSME_APPROVEDBY")));
					rs5 = DBUtils.executeQuery(strQuery);
					if(rs5.next()){
						strmsmeusername=Helper.correctNull((String)rs5.getString("name"));
					}
					if(correctNull((String)rs.getString("MSME_APPSTATUS")).equalsIgnoreCase("op") && (correctNull((String)rs.getString("MSME_INITIATE_FLAG")).equalsIgnoreCase("Y")&&(Helper.correctNull((String)rs.getString("MSME_APPROVEDBY")).equalsIgnoreCase(""))))
						vecRec.add("Sent for Verification"+"-( " +strmsmeorgname+")");
			 		else if(correctNull((String)rs.getString("MSME_APPSTATUS")).equalsIgnoreCase("rb") && correctNull((String)rs.getString("MSME_DELETED_FLAG")).equalsIgnoreCase(""))
			 			vecRec.add("Revert Back");
			 		else if(correctNull((String)rs.getString("MSME_APPSTATUS")).equalsIgnoreCase("sb") && correctNull((String)rs.getString("MSME_DELETED_FLAG")).equalsIgnoreCase(""))
			 			vecRec.add("Roll Back");
			 		else if(correctNull((String)rs.getString("MSME_APPSTATUS")).equalsIgnoreCase("op") && (!Helper.correctNull((String)rs.getString("MSME_APPROVEDBY")).equalsIgnoreCase("")))
			 			vecRec.add("Verification Pending with "+"-"+Helper.correctNull((String)rs.getString("MSME_APPROVEDBY"))+"-"+strmsmeusername);
			 		else if(correctNull((String)rs.getString("MSME_DELETED_FLAG")).equalsIgnoreCase("Y"))
			 			vecRec.add("Deleted");
			 		else
			 			vecRec.add("Open/Pending");//9
			 		vecRec.add(correctNull((String)rs.getString("MSME_RECEIVEDON")));//10
			 		vecRec.add(correctNull((String)rs.getString("MSME_INITIATE_FLAG")));//11
			 		
			 		strQuery = SQLParser.getSqlQuery("sel_msmeverification^"+correctNull((String)rs.getString("MSME_APPNO")));
			 		rs1 = DBUtils.executeQuery(strQuery);
			 		if(rs1.next()){
				 		if(Helper.correctNull((String)rs1.getString("msme_orglevel")).equalsIgnoreCase("C"))
							strQuery = SQLParser.getSqlQuery("selotherparam_ratexpos^M"+Helper.correctNull((String)rs1.getString("msme_orgdept")));
						else if(Helper.correctNull((String)rs1.getString("msme_orglevel")).equalsIgnoreCase("R"))
							strQuery = SQLParser.getSqlQuery("selotherparam_ratexpos^"+"M006");
						else if(Helper.correctNull((String)rs1.getString("msme_orglevel")).equalsIgnoreCase("D"))
							strQuery = SQLParser.getSqlQuery("selotherparam_ratexpos^"+"M005");
						else 
							strQuery = SQLParser.getSqlQuery("selotherparam_ratexpos^"+"M004");
					 	
					 	rs3 = DBUtils.executeQuery(strQuery);
					 	if(rs3.next())
					 	{
					 		vecRec.add(correctNull((String)rs3.getString("LOAN_PARAMVAL1")));//12
					 		strverorglevel=correctNull((String)rs3.getString("LOAN_PARAMVAL2"));
					 		if(strverorglevel.contains(Helper.correctNull((String)hshRequestValues.get("strOrgLevel")))){
					 			strverificationflag="Y";
					 		}
					 	}
					 	else{
					 		vecRec.add("");
					 	}
			 		}
			 		vecRec.add(strappid);//13
			 		vecRec.add(strverificationflag);//14
			 		vecVal.add(vecRec);
			 		log.info("<<<<<<====vecVal================>>>>>>>"+vecVal);

			 	}
			 	hshRecord.put("vecVal", vecVal);
			}
		}
		if(rs!=null)
			rs.close();if(rs!=null)
				rs.close();
		if(!strFromlink.equalsIgnoreCase("mailbox"))
		{
			if(rs!=null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("Selhomeannouncement");
			while (rs.next()) 
			{
				vecVal = new ArrayList();
				vecVal.add(correctNull(rs.getString("bull_id")));
				vecVal.add(correctNull(rs.getString("bull_desc")));
				vecVal.add(correctNull(rs.getString("bull_cdate")));
				vecVal.add(correctNull(rs.getString("bull_createdby")));
				vecData2.add(vecVal);
				hshRecord.put("new", "1");
			}
			hshRecord.put("vecData2", vecData2);
			
			if(rs!=null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("selectorgappl^"+strOrgscode);
			if (rs.next()) 
			{
				hshRecord.put("strExcelUploadFlag", Helper.correctNull(rs.getString("org_excelupload_flag")));
			}
			
		}
		
		if(rs!=null)
			rs.close();
		rs = DBUtils.executeLAPSQuery("selotherparam_ratexpos^111");
		if(rs.next()) 
		{
			hshRecord.put("strMinClassSCM", Helper.correctNull(rs.getString("LOAN_PARAMVAL")));
		}
			
 		String strorgcode=Helper.correctNull((String)hshRequestValues.get("strOrgCode"));
		if(rs!=null) 
			rs.close();
		strQuery=SQLParser.getSqlQuery("sel_cnt_querySend^"+strorgcode+"^"+strorgcode);
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strMBSentQuery = correctNull(rs.getString("cnt"));
		}
		
		if(rs!=null) 
			rs.close();
		strQuery=SQLParser.getSqlQuery("sel_cnt_querySend_RETCORP_copy^"+strorgcode+"^"+strorgcode);
		rs = DBUtils.executeQuery(strQuery);
		while(rs.next())
		{
			String strLOANTYPE= Helper.correctInt((String)rs.getString("APP_LOANTYPE"));
			if(strLOANTYPE.equals("C"))
				hshRecord.put("strMBSentQuery_CORP",Helper.correctInt((String)rs.getString("cnt")));
			else if(strLOANTYPE.equals("A"))
				hshRecord.put("strMBSentQuery_AGR",Helper.correctInt((String)rs.getString("cnt")));
		}
		/*if(strLoanType.equals("P")){
			desc="pH','pA','pP','pM','pU','pK','pE','pL','pI','pC','pN','pJ','pV','pS";
		}else if(strLoanType.equals("J")){
			desc="pG','pR";
		}*/
		if(rs!=null) 
			rs.close();
		strQuery=SQLParser.getSqlQuery("sel_cnt_querySend_RETCORP_Ret^"+strorgcode+"^"+strorgcode);
		rs = DBUtils.executeQuery(strQuery);
		while(rs.next())
		{
				hshRecord.put("strMBSentQuery_RET",Helper.correctInt((String)rs.getString("cnt")));
		}
		if(rs!=null) 
			rs.close();
		strQuery=SQLParser.getSqlQuery("sel_cnt_querySend_RETCORP_LAD^"+strorgcode+"^"+strorgcode);
		rs = DBUtils.executeQuery(strQuery);
		while(rs.next())
		{
				hshRecord.put("strMBSentQuery_LAD",Helper.correctInt((String)rs.getString("cnt")));
		}
		
		if(rs!=null)
			rs.close();
		rs = DBUtils.executeLAPSQuery("selURLDetails");
		while(rs.next())
		{
			hshRecord.put("StrURL"+correctNull(rs.getString("stat_data_desc")),correctNull((String)rs.getString("stat_data_desc1")));
		}
//		if(rs!=null) 
//			rs.close();
//		strQuery=SQLParser.getSqlQuery("sel_cnt_queryReply^"+strorgcode);
//		rs = DBUtils.executeQuery(strQuery);
//		if(rs.next())
//		{
//			strMBRepliedQuery = correctNull(rs.getString("cnt"));
//		}

		hshRecord.put("strMBSentQuery", strMBSentQuery);
		hshRecord.put("strMBRepliedQuery", strMBRepliedQuery);
		
		
		hshRecord.put("server", "one");

		if(Helper.correctNull((String)hshRequestValues.get("strOrgLevel")).equalsIgnoreCase("C"))
			strQuery = SQLParser.getSqlQuery("selotherparam_ratexpos^M"+Helper.correctNull((String)hshRequestValues.get("strUserDepartment")));
		else if(Helper.correctNull((String)hshRequestValues.get("strOrgLevel")).equalsIgnoreCase("R"))
			strQuery = SQLParser.getSqlQuery("selotherparam_ratexpos^"+"M006");
		else if(Helper.correctNull((String)hshRequestValues.get("strOrgLevel")).equalsIgnoreCase("D"))
			strQuery = SQLParser.getSqlQuery("selotherparam_ratexpos^"+"M005");
		else 
			strQuery = SQLParser.getSqlQuery("selotherparam_ratexpos^"+"M004");
	 	if(rs!=null)
	 		rs.close();
	 	rs = DBUtils.executeQuery(strQuery);
	 	if(rs.next())
	 	{
	 		hshRecord.put("strMSMEMinpower", Helper.correctNull(rs.getString("LOAN_PARAMVAL1")));
	 	}
	}
	catch (Exception ce) 
	{
		throw new EJBException("Error in getData login  " + ce.toString());
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
	return hshRecord;
}



public HashMap getMonData(HashMap hshRequestValues)  
{
	ResultSet rs = null;
	ArrayList vecVal = new ArrayList();
	ArrayList vecRec = null;
	HashMap hshRecord = new HashMap();
	ArrayList vecData2 = new ArrayList();
	String strQuery = "";
	String strLoanType = "";
	String strUser = "";
	String strMailBoxCom = "0";
	String strMailBoxPer = "0";
	String strMailBoxAgr = "0";
	String strMailBoxNPA="0";
	String strMailBoxMON="0";
	String strMailBoxTL="0";
	String strMailBoxTer="0";
	String strFromlink="";
	String strMailBoxBST="0";
	String strMailBoxmst="0";
	String strMailBoxsre="0";
	String strMailBoxStl="0";
	String strMailBoxadc="0";
	String strMailBoxINS="0";
	int noCol = 0;
	try {
		hshRecord = new HashMap();
		strLoanType = correctNull((String) hshRequestValues.get("optformtype"));
		strUser = correctNull((String) hshRequestValues.get("strUserId"));
		strFromlink=correctNull((String)hshRequestValues.get("fromlink"));
		if(strFromlink.equalsIgnoreCase("mailbox"))
		{
			if(rs!=null) 
				rs.close();
			
			/*strQuery=SQLParser.getSqlQuery("mailboxappcount^" + strUser);
			rs = DBUtils.executeQuery(strQuery);
			
			while (rs.next())
			{
				if(rs.getString("app_loantype").equalsIgnoreCase("P"))
					strMailBoxPer = correctNull(rs.getString("appno"));
				else if(rs.getString("app_loantype").equalsIgnoreCase("A"))
					strMailBoxAgr = correctNull(rs.getString("appno"));
				else if(rs.getString("app_loantype").equalsIgnoreCase("C"))
					strMailBoxCom = correctNull(rs.getString("appno"));
				else if(rs.getString("app_loantype").equalsIgnoreCase("T"))
					strMailBoxTer = correctNull(rs.getString("appno"));
				else if(rs.getString("app_loantype").equalsIgnoreCase("E"))
					strMailBoxsre = correctNull(rs.getString("appno"));
				else if(rs.getString("app_loantype").equalsIgnoreCase("U"))
					strMailBoxStl = correctNull(rs.getString("appno"));
				else if(rs.getString("app_loantype").equalsIgnoreCase("H"))
					strMailBoxadc = correctNull(rs.getString("appno"));
			}*/
			if(rs!=null) 
				rs.close(); 
			rs = DBUtils.executeLAPSQuery("npamailboxcount^" + strUser);
				
			while (rs.next())
				strMailBoxNPA = rs.getString(1);
				
			if(rs!=null) 
				rs.close();
			rs = DBUtils.executeLAPSQuery("monmailboxcount^" + strUser);
				
			while (rs.next())
				strMailBoxMON = rs.getString(1);
				
			if(rs!=null) 
				rs.close();
			rs = DBUtils.executeLAPSQuery("mon_TLreviewcount^" + strUser);
				
			while (rs.next())
				strMailBoxTL = rs.getString(1);
			
			/*if(rs!=null) 
				rs.close();
			rs = DBUtils.executeLAPSQuery("bstmailboxcount^" + strUser);
				
			while (rs.next())
				strMailBoxBST = rs.getString(1);
			*/
			/*if(rs!=null) 
				rs.close();
			rs = DBUtils.executeLAPSQuery("mstmailboxcount^" + strUser);
				
			while (rs.next())
				strMailBoxmst = rs.getString(1);
			if(rs!=null)
				rs.close();*/
			
			rs = DBUtils.executeLAPSQuery("insmailcount^" + strUser);
			while (rs.next())
				strMailBoxINS = rs.getString(1);
				
		/************for CC mail ********* */	
			if(rs!=null) 
				rs.close();
			
			/*strQuery=SQLParser.getSqlQuery("mailboxperCCcount^" + strUser);
			rs = DBUtils.executeQuery(strQuery);
			
			while (rs.next())
			{
				if(rs.getString("app_loantype").equalsIgnoreCase("P"))
					strMailBoxPer = Integer.toString(Integer.parseInt(strMailBoxPer) + Integer.parseInt(rs.getString(1)));
				else if(rs.getString("app_loantype").equalsIgnoreCase("A"))
					strMailBoxAgr = Integer.toString(Integer.parseInt(strMailBoxAgr) + Integer.parseInt(rs.getString(1)));
				else if(rs.getString("app_loantype").equalsIgnoreCase("C"))
					strMailBoxCom = Integer.toString(Integer.parseInt(strMailBoxCom) + Integer.parseInt(rs.getString(1)));
				else if(rs.getString("app_loantype").equalsIgnoreCase("T"))
					strMailBoxTer = Integer.toString(Integer.parseInt(strMailBoxTer) + Integer.parseInt(rs.getString(1)));
				else if(rs.getString("app_loantype").equalsIgnoreCase("E"))
					strMailBoxsre = Integer.toString(Integer.parseInt(strMailBoxsre) + Integer.parseInt(rs.getString(1)));
				else if(rs.getString("app_loantype").equalsIgnoreCase("U"))
					strMailBoxStl = Integer.toString(Integer.parseInt(strMailBoxStl) + Integer.parseInt(rs.getString(1)));
				else if(rs.getString("app_loantype").equalsIgnoreCase("H"))
					strMailBoxadc = Integer.toString(Integer.parseInt(strMailBoxadc) + Integer.parseInt(rs.getString(1)));
			}
			if(rs!=null) 
				rs.close();*/
		/************ for CC mail ************ */	
		//	hshRecord.put("strMailBoxPer", strMailBoxPer);
		//	hshRecord.put("strMailBoxCom", strMailBoxCom);
		//	hshRecord.put("strMailBoxAgr", strMailBoxAgr);
		//	hshRecord.put("strMailBoxTer", strMailBoxTer);
			hshRecord.put("strMailBoxNPA", strMailBoxNPA);
			hshRecord.put("strMailBoxMON", strMailBoxMON);
			hshRecord.put("strMailBoxTL", strMailBoxTL);
		//	hshRecord.put("strMailBoxBST", strMailBoxBST);
		//	hshRecord.put("strMailBoxmst", strMailBoxmst);
		//	hshRecord.put("strMailBoxsre", strMailBoxsre);
		//	hshRecord.put("strMailBoxStl", strMailBoxStl);
		//	hshRecord.put("strMailBoxadc", strMailBoxadc);
			hshRecord.put("strMailBoxINS", strMailBoxINS);
		
			
		}
		if (!strLoanType.equals("")) 
		{
			if (strLoanType.equals("C") || strLoanType.equals("E") || strLoanType.equals("U") || strLoanType.equals("H")) 
			{
				strQuery = SQLParser.getSqlQuery("mailboxcom^" + strLoanType  +"^"+strUser);
				noCol = 11;
			} 
			else if (strLoanType.equals("P")) 
			{
				strQuery = SQLParser.getSqlQuery("mailboxper^" + strUser);
				noCol = 9;
			}
			else if (strLoanType.equals("A")) 
			{
				strQuery = SQLParser.getSqlQuery("mailboxagr^" + strUser);
				noCol = 9;
			}
			else if (strLoanType.equals("T")) 
			{
				strQuery = SQLParser.getSqlQuery("mailboxter^" + strUser);
				noCol = 8;
			}
			else if (strLoanType.equals("N")) 
			{
				noCol = 10;
			}
			else if (strLoanType.equals("M")) 
			{
				noCol = 10;
			}
			else if (strLoanType.equals("S")) 
			{
				noCol = 10;
			}
			else if (strLoanType.equals("B")) 
			{
				noCol = 7;
			}
			else if (strLoanType.equals("D")) 
			{
				noCol = 6;
			}
			else if (strLoanType.equals("PI")) 
			{
				noCol = 7;
			}
			if(rs!=null) 
				rs.close();
			if (!strLoanType.equalsIgnoreCase("PI")&&!strLoanType.equalsIgnoreCase("N")&&!strLoanType.equalsIgnoreCase("M") && !strLoanType.equalsIgnoreCase("TL") &&!strLoanType.equalsIgnoreCase("S") &&!strLoanType.equalsIgnoreCase("B") &&!strLoanType.equalsIgnoreCase("D"))
			{
				rs = DBUtils.executeQuery(strQuery);
					while (rs.next()) 
					{
						vecRec = new ArrayList();
						for (int i = 0; i < noCol; i++) 
						{
							String strValue = correctNull(rs.getString(i + 1));
							if ((strLoanType.equalsIgnoreCase("T") && i==3) || (i == 4 && !strLoanType.equalsIgnoreCase("T"))) 
							{
								if (strValue.equalsIgnoreCase("CA")) 
								{
									strValue = "Closed/Approved";
								}
								else if (strValue.equalsIgnoreCase("OP")) 
								{
									strValue = "Open/Pending";
								}
								else if (strValue.equalsIgnoreCase("PA")) 
								{
									strValue = "Processed/Approved";
								}
								else if (strValue.equalsIgnoreCase("PR")) 
								{
									strValue = "Processed/Rejected";
								}
								else if (strValue.equalsIgnoreCase("CR")) 
								{
									strValue = "Closed/Rejected";
								}
							}
							vecRec.add(strValue);
						}
						vecVal.add(vecRec);
					}	
					/* *************for CC mail **** */
					if (strLoanType.equals("C") || strLoanType.equals("E") || strLoanType.equals("U") || strLoanType.equals("H")) 
					{
						strQuery = SQLParser.getSqlQuery("mailboxcomCC^" +strUser+"^"+strLoanType);
						noCol = 11;
					} 
					else if (strLoanType.equals("P")) 
					{
						strQuery = SQLParser.getSqlQuery("mailboxperCC^" + strUser);
						noCol = 9;
					}
					else if (strLoanType.equals("A")) 
					{
						strQuery = SQLParser.getSqlQuery("mailboxagrCC^" + strUser);
						noCol = 9;
					}
					else if (strLoanType.equals("T")) 
					{
						strQuery = SQLParser.getSqlQuery("mailboxterCC^" + strUser);
						noCol = 8;
					}
				
						if(rs != null)
							rs.close();
						rs = DBUtils.executeQuery(strQuery);
						while (rs.next()) 
						{
							vecRec = new ArrayList();
							for (int i = 0; i < noCol; i++) 
							{
								String strValue = correctNull(rs.getString(i + 1));
								if ((strLoanType.equalsIgnoreCase("T") && i==3) || (i == 4 && !strLoanType.equalsIgnoreCase("T"))) 
								{
									if (strValue.equalsIgnoreCase("CA")) 
									{
										strValue = "Closed/Approved";
									}
									else if (strValue.equalsIgnoreCase("OP")) 
									{
										strValue = "Open/Pending";
									}
									else if (strValue.equalsIgnoreCase("PA")) 
									{
										strValue = "Processed/Approved";
									}
									else if (strValue.equalsIgnoreCase("PR")) 
									{
										strValue = "Processed/Rejected";
									}
									else if (strValue.equalsIgnoreCase("CR")) 
									{
										strValue = "Closed/Rejected";
									}
								}
								vecRec.add(strValue);
							}
							vecVal.add(vecRec);
						}
				
						if(rs != null)
							rs.close();
					
						/********************/
						
				
					hshRecord.put("vecVal", vecVal);
			 }
		 	 else if(strLoanType.equalsIgnoreCase("N"))
		 	 {
	 			 strQuery = SQLParser.getSqlQuery("npamailappno"+"^"+ strUser);
	 			 if(rs!=null)
	 				 rs.close();
	 			 rs = DBUtils.executeQuery(strQuery);
	 
				 while (rs.next()) 
	 			 {
	 				 vecRec = new ArrayList();
					 for (int i = 0; i < noCol; i++) 
	 				 {
	 					 String strValue = correctNull(rs.getString(i + 1));
	 					 if (i == 4) 
	 					 {
	 						 if (strValue.equalsIgnoreCase("CA")) 
	 						 {
								strValue = "Closed/Approved";
	 						 } 
	 						 else if ((strValue.equalsIgnoreCase("OP")) || (strValue.equalsIgnoreCase("PP"))) 
	 						 {
								strValue = "Open/Pending";
	 						 } 
	 						 else if (strValue.equalsIgnoreCase("PA")) 
	 						 {
								strValue = "Processed/Approved";
	 						 } 
	 						 else if (strValue.equalsIgnoreCase("PR")) 
	 						 {
								strValue = "Processed/Rejected";
	 						 }
	 						 else if (strValue.equalsIgnoreCase("CR")) 
	 						 {
								strValue = "Closed/Rejected";
	 						 }
	 					 }
	 					 vecRec.add(strValue);
	 				 }
	 				 vecVal.add(vecRec);
	 			 }
			 hshRecord.put("vecVal", vecVal);
		 	}
		 	else if(strLoanType.equalsIgnoreCase("M"))
		 	 {
		 		 strQuery = SQLParser.getSqlQuery("monmailappno^"+ strUser);
		 		 if(rs!=null)
		 			 rs.close();
				 rs = DBUtils.executeQuery(strQuery);
					
				 while (rs.next()) 
				 {
					 vecRec = new ArrayList();
					 for (int i = 0; i < noCol; i++) 
					 {
						 String strValue = correctNull(rs.getString(i + 1));
						 vecRec.add(strValue);
					 }
					 vecVal.add(vecRec);
				}
				hshRecord.put("vecVal", vecVal);
			}
			//added by Mercy for Term Loan Review
		 	else if(strLoanType.equalsIgnoreCase("TL"))
		 	{
		 		strQuery = SQLParser.getSqlQuery("mon_TLReviewMail^"+ strUser);
		 		rs = DBUtils.executeQuery(strQuery);
		 		while (rs.next())
			 	{
		 			vecRec = new ArrayList();
			 		vecRec.add(correctNull((String)rs.getString("tlr_appno")));
			 		vecRec.add(correctNull((String)rs.getString("tlr_cbsid")));
					if (correctNull((String)rs.getString("tlr_status")).equalsIgnoreCase("CA")) 
					{
						vecRec.add("CLOSED");
					} 
					else if (correctNull((String)rs.getString("tlr_status")).equalsIgnoreCase("OP")) 
					{
						vecRec.add("PENDING");
					} 
					else if (correctNull((String)rs.getString("tlr_status")).equalsIgnoreCase("PA")) 
					{
						vecRec.add("APPROVED");
					} 
					
			 		vecRec.add(correctNull((String)rs.getString("mon_termloanreview_fromusrid")));
			 		vecRec.add(correctNull((String)rs.getString("mon_termloanreview_maildate")));
			 		vecRec.add(correctNull((String)rs.getString("tlr_year")));
			 		vecRec.add(correctNull((String)rs.getString("tlr_year")));
			 		vecRec.add(correctNull((String)rs.getString("tlr_year")));
			 		vecRec.add(correctNull((String)rs.getString("mon_termloanreview_tousrid")));
			 		vecRec.add(correctNull((String)rs.getString("personal_custname")));
			 		vecRec.add(correctNull((String)rs.getString("org_name")));
			 		vecRec.add(correctNull((String)rs.getString("tlr_status")));
			 		vecVal.add(vecRec);
			 	}
			 	hshRecord.put("vecVal", vecVal);
			}
		 	else if(strLoanType.equalsIgnoreCase("S"))
		 	 {
		 		String strapp_processat="";
		 		String IsSaralhead="N";
		 		String ISorghead="N";
		 		String strorgcode=Helper.correctNull((String)hshRequestValues.get("strOrgCode"));
		 		
		 		if(correctNull((String)hshRequestValues.get("strOrgLevel")).equalsIgnoreCase("D"))
		 		{
		 			strorgcode=strorgcode.substring(0,9);
		 			strapp_processat="2";
		 		}
		 		else if(correctNull((String)hshRequestValues.get("strOrgLevel")).equalsIgnoreCase("A"))
		 		{
		 			strorgcode=strorgcode.substring(0,12);
		 			strapp_processat="2";
		 		}
		 		if(correctNull((String)hshRequestValues.get("strOrgLevel")).equals("A"))
		 		{
		 			strQuery=SQLParser.getSqlQuery("setorgselect^"+
		 					correctNull((String)hshRequestValues.get("strOrgCode")));
		 			
		 			if(rs!=null)
			 			 rs.close();
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						if(correctNull(rs.getString("org_head")).equals(strUser))
						{
							ISorghead="Y";
						}
					}
		 			strQuery = SQLParser.getSqlQuery("saralmailackno^"+ strapp_processat+"^"+strorgcode+"^ ='O'");
		 		}
		 		else if(correctNull((String)hshRequestValues.get("strOrgLevel")).equals("D"))
		 		{
		 			
		 			strQuery=SQLParser.getSqlQuery("setorgselect^"+
		 					correctNull((String)hshRequestValues.get("strOrgCode")));
		 			
		 			if(rs!=null)
			 			 rs.close();
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{ 
						if(correctNull(rs.getString("org_saralhead")).equals(strUser))
						{
							strQuery = SQLParser.getSqlQuery("saralmailackno^"+ strapp_processat+"^"+strorgcode +
								"^ ='P'");
							IsSaralhead="Y";
						}
						else
						{
							strQuery = SQLParser.getSqlQuery("saralmailackno^"+ strapp_processat+
									"^"+strorgcode +"^ ='P' and inward_assignusrid='"+strUser+"'");
						}
					}
		 		}
		 		 if(rs!=null)
		 			 rs.close();
		 		 if(strQuery!="")
		 			 rs = DBUtils.executeQuery(strQuery);
					
				 while (rs.next()) 
				 {
					 vecRec = new ArrayList();
					 for (int i = 0; i < noCol; i++) 
					 {
						 String strValue = correctNull(rs.getString(i + 1));
						 vecRec.add(strValue);
					 }
					 vecRec.add(IsSaralhead);
					 vecRec.add(ISorghead);
					 vecVal.add(vecRec);
				}
				hshRecord.put("vecVal", vecVal);
				hshRecord.put("Orglevel",correctNull((String)hshRequestValues.get("strOrgLevel")));
				
			}
		 	else if(strLoanType.equalsIgnoreCase("B"))
		 	{

	 			 strQuery = SQLParser.getSqlQuery("bstmailappno"+"^"+ strUser);
	 			 if(rs!=null)
	 				 rs.close();
	 			 rs = DBUtils.executeQuery(strQuery);
	 
				 while (rs.next()) 
	 			 {
	 				 vecRec = new ArrayList();
					 for (int i = 0; i < noCol; i++) 
	 				 {
	 					 String strValue = correctNull(rs.getString(i + 1));
	 					 if (i == 4) 
	 					 {
	 						 if (strValue.equalsIgnoreCase("CA")) 
	 						 {
	 							vecRec.add("Closed/Approved");
	 						 } 
	 						 else if (strValue.equalsIgnoreCase("OP")) 
	 						 {
	 							vecRec.add("Open/Pending");
	 						 } 
	 						 else if (strValue.equalsIgnoreCase("PA")) 
	 						 {
	 							vecRec.add("Processed/Approved");
	 						 } 
	 						 else if (strValue.equalsIgnoreCase("PR")) 
	 						 {
	 							vecRec.add("Processed/Rejected");
	 						 }
	 						 else if (strValue.equalsIgnoreCase("CR")) 
	 						 {
	 							vecRec.add("Closed/Rejected");
	 						 }
	 					 }
	 					 vecRec.add(strValue);
	 				 }
	 				 vecVal.add(vecRec);
	 			 }
				 hshRecord.put("vecVal", vecVal);
		 	} 
			else if(strLoanType.equalsIgnoreCase("D"))
			{
				strQuery = SQLParser.getSqlQuery("mstmailbox"+"^"+ strUser);
			 	if(rs!=null)
			 		rs.close();
			 	rs = DBUtils.executeQuery(strQuery);
			 
				while (rs.next()) 
			 	{
					vecRec = new ArrayList();
					for (int i = 0; i < noCol; i++) 
			 		{
						String strValue = correctNull(rs.getString(i + 1));
			 			if (i == 3) 
			 			{
			 				if (strValue.equalsIgnoreCase("CA")) 
			 				{
			 					vecRec.add("Closed/Approved");
			 				} 
			 				else if (strValue.equalsIgnoreCase("OP")) 
			 				{
			 					vecRec.add("Open/Pending");
			 				} 
			 				else if (strValue.equalsIgnoreCase("PA")) 
			 				{
			 					vecRec.add("Processed/Approved");
			 				} 
			 				else if (strValue.equalsIgnoreCase("PR")) 
			 				{
			 					vecRec.add("Processed/Rejected");
			 				}
			 				else if (strValue.equalsIgnoreCase("CR")) 
			 				{
			 					vecRec.add("Closed/Rejected");
			 				}
			 			}
			 		vecRec.add(strValue);
			 		}
			 	vecVal.add(vecRec);
			 	}
				
			hshRecord.put("vecVal", vecVal);
			}
			else if(strLoanType.equalsIgnoreCase("PI"))
			{
				strQuery = SQLParser.getSqlQuery("inspectionmailbox"+"^"+ strUser);
			 	if(rs!=null)
			 		rs.close();
			 	rs = DBUtils.executeQuery(strQuery);
			 
				while (rs.next()) 
			 	{
					vecRec = new ArrayList();
					for (int i = 0; i < noCol; i++) 
			 		{
						String strValue = correctNull(rs.getString(i + 1));
			 			if (i == 3) 
			 			{
			 				if (strValue.equalsIgnoreCase("P")) 
			 				{
			 					vecRec.add("Pending");
			 				} 
			 			}
			 		vecRec.add(strValue);
			 		}
			 	vecVal.add(vecRec);
			 	}
				hshRecord.put("vecVal", vecVal);
			}
		}
		
		if(!strFromlink.equalsIgnoreCase("mailbox"))
		{
			if(rs!=null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("Selhomeannouncement");
			while (rs.next()) 
			{
				vecVal = new ArrayList();
				vecVal.add(correctNull(rs.getString("bull_id")));
				vecVal.add(correctNull(rs.getString("bull_desc")));
				vecVal.add(correctNull(rs.getString("bull_cdate")));
				vecVal.add(correctNull(rs.getString("bull_createdby")));
				vecData2.add(vecVal);
				hshRecord.put("new", "1");
			}
			hshRecord.put("vecData2", vecData2);
		}
		hshRecord.put("server", "two");
	}
	catch (Exception ce) 
	{
		throw new EJBException("Error in getData login  " + ce.toString());
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
	return hshRecord;
}


	/*public HashMap getOutBox(HashMap hshRequestValues)  {
		// log.info("outbox==============================");

		ResultSet rs = null;
		ArrayList vecVal = new ArrayList();
		ArrayList vecRec = null;
		HashMap hshRecord = new HashMap();
		String strQuery = "";
		String strLoanType = "";
		String strSearchType = "";
		String strSearchText = "";
		String strUser = "";
		try {

			hshRecord = new HashMap();
			strLoanType = correctNull((String) hshRequestValues
					.get("optformtype"));
			strSearchType = correctNull((String) hshRequestValues
					.get("optstype"));
			strSearchText = correctNull((String) hshRequestValues
					.get("txtsearch"));
			strUser = correctNull((String) hshRequestValues.get("strUserId"));
			// log.info("strLoanType======" + strLoanType);

			if (strLoanType.equals("C")) {
				if (strSearchType.equals("A") && !strSearchText.equals("")) {
					strQuery = SQLParser.getSqlQuery("seloutboxcomapp^"
							+ strUser + "^" + strSearchText);
				} else if (strSearchType.equals("N")
						&& !strSearchText.equals("")) {
					strQuery = SQLParser.getSqlQuery("seloutboxcomname^"
							+ strUser + "^" + strSearchText);
				} else if (strSearchType.equals("S")
						&& !strSearchText.equals("")) {
					strQuery = SQLParser.getSqlQuery("seloutboxcomid^"
							+ strUser + "^" + strSearchText);
				} else if ((!strSearchType.equals("") && strSearchText
						.equals(""))
						|| (strSearchType.equals("") && strSearchText
								.equals(""))) {
					strQuery = SQLParser.getSqlQuery("seloutboxcom^" + strUser);
				}
			} else if (strLoanType.equals("P")) {
				if (strSearchType.equals("A") && !strSearchText.equals("")) {
					strQuery = SQLParser.getSqlQuery("seloutboxperapp^"
							+ strUser + "^" + strSearchText);
				} else if (strSearchType.equals("N")
						&& !strSearchText.equals("")) {
					strQuery = SQLParser.getSqlQuery("seloutboxpername^"
							+ strUser + "^" + strSearchText);
				} else if (strSearchType.equals("S")
						&& !strSearchText.equals("")) {
					strQuery = SQLParser.getSqlQuery("seloutboxperpan^"
							+ strUser + "^" + strSearchText);
				} else if ((!strSearchType.equals("") && strSearchText
						.equals(""))
						|| (strSearchType.equals("") && strSearchText
								.equals(""))) {
					strQuery = SQLParser.getSqlQuery("seloutboxper^" + strUser);
				}
				// log.info("strQueryOut======"+strQuery);
			}

			// log.info("strQuery======"+strQuery);

			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				vecRec = new ArrayList();
				for (int i = 0; i < 7; i++) {
					String strValue = rs.getString(i + 1);
					if (i == 4) {
						if (strValue.equalsIgnoreCase("CA")) {
							strValue = "Closed/Approved";
						} else if (strValue.equalsIgnoreCase("OP")) {
							strValue = "Open/Pending";
						} else if (strValue.equalsIgnoreCase("PA")) {
							strValue = "Processed/Approved";
						} else if (strValue.equalsIgnoreCase("PR")) {
							strValue = "Processed/Rejected";
						}else if (strValue.equalsIgnoreCase("CR")) {
							strValue = "Closed/Rejected";
						}
					}

					vecRec.add(strValue);
				}
				vecVal.add(vecRec);
			}
			hshRecord.put("vecVal", vecVal);
		} catch (Exception ce) {
			throw new EJBException("Error in getData login  " + ce.toString());
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
	}*/
public HashMap getBranchMailBox(HashMap hshRequestValues)  
{
	ResultSet rs = null,rs1=null;
	ArrayList vecVal = new ArrayList();
	ArrayList vecRec = null;
	HashMap hshRecord = new HashMap();
	ArrayList vecData2 = new ArrayList();
	String strQuery = "";
	String strLoanType = "";
	String strFromlink="";
	String strUser="";
	int noCol = 0;
	String strOrgCode=correctNull((String) hshRequestValues.get("strOrgCode"));
	try {
		hshRecord = new HashMap();
		strLoanType = correctNull((String) hshRequestValues.get("optformtype"));
		strFromlink=correctNull((String)hshRequestValues.get("fromlink"));
		
		strUser="BR"+Helper.correctNull((String)hshRequestValues.get("strOrgShortCode"));
		
		if (!strLoanType.equals("")) 
		{
			if (strLoanType.equals("C") || strLoanType.equals("A")) 
			{
				strQuery = SQLParser.getSqlQuery("mailboxcom_branch^"+strUser+"^"+ strLoanType );
				noCol = 14;
			} 
			else if (strLoanType.equals("P")) 
			{
				strQuery = SQLParser.getSqlQuery("mailboxper_branch^" + strUser+"^pH','pA','pP','pM','pU','pK','pE','pL','pI','pC','pN','pJ','pV','pS");
				noCol = 14;
			}
			else if (strLoanType.equals("S")) 
			{
				strQuery = SQLParser.getSqlQuery("mailboxsolwithCC_branch^" +strUser+"^"+ strLoanType);
				noCol = 8;
			}

			else if (strLoanType.equals("K")) 
			{
				strQuery = SQLParser.getSqlQuery("mailboxkpowwithCC_branch^" +strUser+"^"+ strLoanType);
				noCol = 8;
			}
			
			
			else if (strLoanType.equals("F")) 
			{
				strQuery = SQLParser.getSqlQuery("mailboxfinwithCC_branch^" +strUser+"^"+ strLoanType);
				noCol = 9;
			}
			else if (strLoanType.equals("D")) 
			{
				noCol = 6;
			}
			else if (strLoanType.equals("J")) 
			{
				strQuery = SQLParser.getSqlQuery("mailboxper_branch^" + strUser+"^pG','pR");
				noCol = 14;
			}
			if(rs!=null) 
				rs.close();
			if (!strLoanType.equalsIgnoreCase("D"))
			{
				rs = DBUtils.executeQuery(strQuery);
					while (rs.next()) 
					{
						vecRec = new ArrayList();
						for (int i = 0; i < noCol; i++) 
						{
							String strValue = correctNull(rs.getString(i + 1));
							if ((i == 4 && !strLoanType.equalsIgnoreCase("T")) || (strLoanType.equalsIgnoreCase("S") && i==6) || (strLoanType.equalsIgnoreCase("K") && i==6) || (strLoanType.equalsIgnoreCase("P") && i==3)
									||(strLoanType.equalsIgnoreCase("F") && i==3)) 
							{
								if (strValue.equalsIgnoreCase("CA")) 
								{
									strValue = "Closed/Approved";
								}
								else if (strValue.equalsIgnoreCase("OP")) 
								{
									strValue = "Open/Pending";
								}
								else if (strValue.equalsIgnoreCase("PA")) 
								{
									strValue = "Processed/Approved";
								}
								else if (strValue.equalsIgnoreCase("PR")) 
								{
									strValue = "Processed/Rejected";
								}
								else if (strValue.equalsIgnoreCase("CR")) 
								{
									strValue = "Closed/Rejected";
								}
								else if (strValue.equalsIgnoreCase("OL")) 
								{
									strValue = "Open/Lodged";
								}
							}
							if((strLoanType.equalsIgnoreCase("P")&& i==11)||((strLoanType.equalsIgnoreCase("A")||strLoanType.equalsIgnoreCase("C"))&& i==12)||(strLoanType.equalsIgnoreCase("J")&& i==11))
							{
								if (strValue.equalsIgnoreCase("R")) 
								{
									vecRec.add("Renewal");
								}
								else if (strValue.equalsIgnoreCase("S")) 
								{
									vecRec.add("Restructured");
								}
								else if (strValue.equalsIgnoreCase("P")) 
								{
									vecRec.add("Post Sanction");
								}
								else
								{
									vecRec.add("Fresh");
								}
							}
							vecRec.add(strValue);
						}
						vecVal.add(vecRec);
					}	
						if(rs != null)
							rs.close();
				
					hshRecord.put("vecVal", vecVal);
			 }
			else if(strLoanType.equalsIgnoreCase("D"))
			{
				
			 	if(rs!=null)
			 		rs.close();
			 	strQuery = SQLParser.getSqlQuery("mailboxDEV_branch^"+ strUser);
			 	rs = DBUtils.executeQuery(strQuery);
			 	String strname="";
				while (rs.next()) 
			 	{
					vecRec = new ArrayList();
					for (int i = 0; i < noCol; i++) 
			 		{
						strname=rs.getString(2);
						if(i==1 && strname==null)
						{
							 vecRec.add(correctNull(rs.getString("PG_EMPLOYERNAME")));
						}
						else if(i==5){
							String Org_Scode=(correctNull(rs.getString(i + 1)));
							if(rs1!=null)rs1.close();
							strQuery = SQLParser.getSqlQuery("selectorgappl^"+ Org_Scode);
						 	rs1 = DBUtils.executeQuery(strQuery);
						 	if(rs1.next()){
						 		vecRec.add(correctNull(rs1.getString("ORG_NAME")));
						 	}
						}
						else
						{
							vecRec.add(correctNull(rs.getString(i + 1)));
						}	
			 		}
					vecVal.add(vecRec);
			 	}
				hshRecord.put("vecVal", vecVal);
			}	
		}
		
		hshRecord.put("server", "one");
		hshRecord.put("strFromlink", strFromlink);
	}
	catch (Exception ce) 
	{
		throw new EJBException("Error in getBranchMailBox login  " + ce.toString());
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
	return hshRecord;
}

}