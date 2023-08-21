package com.sai.laps.ejb.FinacleBean;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.sql.DataSource;

import oracle.jdbc.pool.OracleDataSource;

import org.apache.log4j.Logger;

import com.sai.fw.data.ConnectionFactory;
import com.sai.laps.ejb.mastapplicant.MastApplicantBean;
import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.CLOBInvoker;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "FinacleInterfaceBean", mappedName = "FinacleHome")
@Remote (FinacleRemote.class)
public class FinacleInterfaceBean extends BeanAdapter {
	static Logger log=Logger.getLogger(FinacleInterfaceBean.class);
	private static final long serialVersionUID = 1L;

	SimpleDateFormat sd = null;

	SimpleDateFormat sdt = null;

	// Done by: Muralidharan

//	public HashMap CustomerProfile(HashMap hashmap)  {
//		HashMap hshcustomer = new HashMap();
//		String strException = "false";
//		String strQuery = "";
//
//		String minor = "";
//		String guardian = "";
//		String relation_address = "";
//		String trade_finance = "";
//		String trade_inland = "";
//		String intr_title = "";
//		String intr_name = "";
//		String strminor = "";
//		String TradeFinance = "";
//		String TradeInland = "";
//		String occ = "";
//		String consi = "";
//		String Status = "";
//		String Wheatherstaff = "";
//		String Wheather_staff = "";
//
//		String CustomerProfile = "";
//
//		ResultSet rs1 = null;
//		ResultSet rs2 = null;
//		ResultSet rs3 = null;
//
//		try {
//			String strAppno = Helper.correctNull((String) hashmap
//					.get("strappno"));
//			if (strAppno.equals(""))
//				strAppno = Helper.correctNull((String) hashmap.get("appno"));
//
//			if (strAppno.equalsIgnoreCase("")) {
//				strException = "Error Occured While Generating Customer Profile File";
//			}
//
//			rs1 = null;
//
//			// for getting the customer id using application number
//			String strCustomerId = "";
//			strQuery = SQLParser.getSqlQuery("interface_getcustId^" + strAppno);
//			rs1 = DBUtils.executeQuery(strQuery);
//			if (rs1.next()) {
//				strCustomerId = rs1.getString("demo_appid");
//			}
//			rs1 = null;
//
//			if (strException.equalsIgnoreCase("false")) {
//				strQuery = SQLParser.getSqlQuery("interface_retcustomerdetail^"
//						+ strAppno);
//				rs1 = DBUtils.executeQuery(strQuery);
//				if (rs1.next()) {
//					// Gender
//					String PERAPP_SEX = Helper.correctNull(Helper
//							.correctNull(rs1.getString("PERAPP_SEX")));
//					if (PERAPP_SEX.equals("M")) {
//						PERAPP_SEX = "M";
//					} else if (PERAPP_SEX.equals("F")) {
//						PERAPP_SEX = "F";
//					} else if (PERAPP_SEX.equals("N")) {
//						PERAPP_SEX = "O";
//					}
//
//					// Communication Address Line 2
//					String PERAPP_ADDRESS2 = Helper.correctNull(rs1
//							.getString("PERAPP_ADDRESS2"));
//					String PERAPP_ADDRESS3 = Helper.correctNull(rs1
//							.getString("PERAPP_ADDRESS3"));
//					String PERAPP_ADDRESS4 = (PERAPP_ADDRESS2 + PERAPP_ADDRESS3);
//
//					// Permanent Address Line 2
//					String PERAPP_PERMADD2 = Helper.correctNull(rs1
//							.getString("PERAPP_PERMADD2"));
//					String PERAPP_PERMADD3 = Helper.correctNull(rs1
//							.getString("PERAPP_PERMADD3"));
//					String PERAPP_PERMADD4 = (PERAPP_PERMADD2 + PERAPP_PERMADD3);
//
//					// Employer Address Line 2
//					String PEREMP_ADDRESS2 = Helper.correctNull(rs1
//							.getString("PEREMP_ADDRESS2"));
//					String PEREMP_ADDRESS3 = Helper.correctNull(rs1
//							.getString("PEREMP_ADDRESS3"));
//					String PEREMP_ADDRESS4 = (PEREMP_ADDRESS2 + PEREMP_ADDRESS3);
//
//					// Non-Resident
//					String PERAPP_STATUS = Helper.correctNull(Helper
//							.correctNull(rs1.getString("PERAPP_STATUS")));
//					if (PERAPP_STATUS.equals("2")) {
//						PERAPP_STATUS = "Y";
//					} else if (PERAPP_STATUS.equals("1")
//							|| PERAPP_STATUS.equals("")) {
//						PERAPP_STATUS = "N";
//					}
//
//					// Occupation & Constitution
//
//					occ = Helper
//							.correctNull(rs1.getString("peremp_occupation"));
//					consi = Helper.correctNull(rs1
//							.getString("perinc_selfincometype"));
//
//					if (occ.equalsIgnoreCase("") && consi.equalsIgnoreCase("")) {
//						strException = "Error: Constitution & Occupation is not Seleted for the Customer in Income & Expenses /Employment Details";
//					} else if (occ.equalsIgnoreCase("")) {
//						strException = "Error: Occupation is not Seleted for the Customer in Employment Details";
//					} else if (consi.equalsIgnoreCase("")) {
//						strException = "Error: Constitution is not Seleted for the Customer in Income & Expenses";
//					}
//
//					if (strException.equalsIgnoreCase("false")) {
//						strQuery = SQLParser
//								.getSqlQuery("interface_retcustomerdetail33^"
//										+ strCustomerId);
//						rs3 = DBUtils.executeQuery(strQuery);
//						if (rs3.next()) {
//							Status = Helper.correctNull(rs3.getString(1));
//							Wheatherstaff = Helper
//									.correctNull(rs3.getString(2));
//						}
//
//						// wheatherstaff
//						if (Wheatherstaff.equalsIgnoreCase("1")) {
//							Wheather_staff = "Y";
//						}
//						if (Wheatherstaff.equalsIgnoreCase("2")
//								|| Wheatherstaff.equalsIgnoreCase("")) {
//							Wheather_staff = "N";
//						}
//
//						rs3 = null;
//						strQuery = SQLParser.getSqlQuery("CBS_Rcustomerdetail^"
//								+ strCustomerId);
//						rs3 = DBUtils.executeQuery(strQuery);
//						if (rs3.next()) {
//							minor = Helper.correctNull(rs3.getString(1));
//							guardian = Helper.correctNull(rs3.getString(2));
//							relation_address = Helper.correctNull(rs3
//									.getString(3));
//							trade_finance = Helper
//									.correctNull(rs3.getString(4));
//							trade_inland = Helper.correctNull(rs3.getString(5));
//							intr_title = Helper.correctNull(rs3.getString(6));
//							intr_name = Helper.correctNull(rs3.getString(7));
//						} else {
//							strException = "Error: CBS Customer Details is not Entered";
//						}
//					}
//
//					if (strException.equalsIgnoreCase("false")) {
//						if (minor.equals("1")) {
//							strminor = "Y";
//						}
//						if (minor.equals("2") || minor.equals("")) {
//							strminor = "N";
//						}
//
//						if (trade_finance.equals("1")) {
//							TradeFinance = "Y";
//						}
//						if (trade_finance.equals("2")
//								|| trade_finance.equals("")) {
//							TradeFinance = "N";
//						}
//
//						if (trade_inland.equals("1")) {
//							TradeInland = "Y";
//						}
//						if (trade_inland.equals("2") || trade_inland.equals("")) {
//							TradeInland = "N";
//						}
//					}
//
//					if (strException.equalsIgnoreCase("false")) {
//						CustomerProfile = Helper.correctNull(rs1
//								.getString("PERAPP_CBSID"))
//								+ "|"
//								+ Helper
//										.correctNull(rs1.getString("PERAPP_ID"))
//								+ "|"
//								+ Helper.correctNull(rs1
//										.getString("PERAPP_TITLE"))
//								+ "|"
//								+ Helper.correctNull(rs1
//										.getString("PERAPP_FNAME"))
//								+ "|"
//								+ Helper.correctNull(rs1
//										.getString("PERAPP_LNAME"))
//								+ "|"
//								+ PERAPP_SEX
//								+ "|"
//								+ Helper.correctNull(rs1
//										.getString("PERAPP_PANNO"))
//								+ "|"
//								+ Helper.correctNull(rs1
//										.getString("PERAPP_DOB"))
//								+ "|"
//								+ Helper.correctNull(rs1
//										.getString("PERAPP_ADDRESS1"))
//								+ "|"
//								+ PERAPP_ADDRESS4
//								+ "|"
//								+ Helper.correctNull(rs1
//										.getString("PERAPP_STATE"))
//								+ "|"
//								+ Helper.correctNull(rs1
//										.getString("PERAPP_ZIP"))
//								+ "|"
//								+ Helper.correctNull(rs1
//										.getString("perapp_country"))
//								+ "|"
//								+ Helper.correctNull(rs1
//										.getString("PERAPP_PERMADD1"))
//								+ "|"
//								+ PERAPP_PERMADD4
//								+ "|"
//								+ Helper.correctNull(rs1
//										.getString("PERAPP_PERMSTATE"))
//								+ "|"
//								+ Helper.correctNull(rs1
//										.getString("PERAPP_PERMZIP"))
//								+ "|"
//								+ Helper.correctNull(rs1
//										.getString("perapp_permcountry"))
//								+ "|"
//								+ Helper.correctNull(rs1
//										.getString("PEREMP_ADDRESS1"))
//								+ "|"
//								+ PEREMP_ADDRESS4
//								+ "|"
//								+ Helper.correctNull(rs1
//										.getString("PEREMP_STATE"))
//								+ "|"
//								+ Helper.correctNull(rs1
//										.getString("PEREMP_ZIP"))
//								+ "|"
//								+ Helper.correctNull(rs1
//										.getString("PEREMP_COUNTRY"))
//								+ "|"
//								+ PERAPP_STATUS
//								+ "|"
//								+ Helper.correctNull(rs1
//										.getString("PERAPP_PASSPORT"))
//								+ "|"
//								+ Helper.correctNull(rs1
//										.getString("PERAPP_PASSISSUE"))
//								+ "|"
//								+ occ
//								+ "|"
//								+ consi
//								+ "|"
//								+ Status
//								+ "|"
//								+ Wheather_staff
//								+ "|"
//								+ strminor
//								+ "|"
//								+ guardian
//								+ "|"
//								+ relation_address
//								+ "|"
//								+ Helper.correctNull(rs1
//										.getString("PER_DATEOFNRI"))
//								+ "|"
//								+ TradeFinance
//								+ "|"
//								+ TradeInland
//								+ "|"
//								+ Helper.correctNull(intr_title)
//								+ "|"
//								+ Helper.correctNull(intr_name);
//					} else {
//						CustomerProfile = strException;
//					}
//				} else {
//					strException = "Error Occured While Generating Customer Profile File";
//					CustomerProfile = strException;
//				}
//			}
//		} catch (Exception e) {
//			throw new EJBException("Error Occured  " + e.getMessage());
//
//		} finally {
//			try {
//				if (rs1 != null)
//					rs1.close();
//				if (rs2 != null)
//					rs2.close();
//				if (rs3 != null)
//					rs3.close();
//			} catch (Exception e) {
//				throw new EJBException("Error Occured  " + e.getMessage());
//			}
//		}
//
//		hshcustomer.put("FinacleFileValues", CustomerProfile);
//		return hshcustomer;
//	}

	// Done by: Muralidharan

	public HashMap SanctionDetails(HashMap hashmap)  {
		String strQuery = "";
		String strException = "false";

		String strapplicationno = "";
		String SolID = "";
		String CustomerCBSID = "";
		String Scheme_Code = "";
		String CustomerTitle = "";
		String CustomerName = "";
		String CustomerStatus = "";
		String CustomerOccupation = "";
		String CBS_Constitution = "";
		String CustomerSex = "";
		String Address1 = "";
		String Address2 = "";
		String City = "";
		String State = "";
		String Pincode = "";
		String CustomerCommunity = "";
		String CustomerCaste = "";
		String TAXSLAB = "";
		String OPERATION_MODE = "";
		String LOAN_AMT = "";
		String LOAN_FREQ = "";
		String LOAN_PERIOD = "";
		String PAYMENT_METHOD = "";
		String OPERATING_ACCOUNT = "";
		String NO_OF_FLOWS = "";
		String LOAN_START_DATE = "";
		String SECTOR_CODE = "";
		String PURPOSE_ADVANCE = "";
		String NATURE_ADVANCE = "";
		String SUB_SECTOR_CODE = "";
		String Customer_Handicap_Service = "";
		String FREETEXT7 = "";
		String SANCTION_LEVEL = "";
		String SANCTION_AUTH = "";
		String SANCTION_REF_NO = "";
		String SANCTIONED_DATE = "";
		String LIMIT_EXPIRY_DATE = "";
		String DOCUMENT_DATE = "";
		String ROI = "";
		String CBS_Accountno = "";
		String strBorrowercat = "";
		String Stradvmode = "";
		String stradvtype = "";
		String strindtype = "";
		String strPANno = "";
		String strDOB = "";
		String strMaritalstatus = "";
		String strEmpId = "";
		// String strOccAccntcode="";
		String strLabel="";
		ResultSet rs = null;
		ResultSet rs1 = null;

		StringBuffer SanctionDetails = new StringBuffer();
		StringBuffer KYCNorms = new StringBuffer();
		// Document document=null;

		String strCropCust="";
		String strOccupation="";
		String strAnnual_Income="";
		String strResiCntry="";
		String strForm60_61="";
		String strFormRef="";
		String strIDProofType="";
		String strIDRef="";
		String strResiProofType="";
		String strResiIDRef="";
		String strIncome_Source="";
		String strNetworth="";
		String strTurnOver="";
		String strTurnOverEsti="";
		String strPooled_Act="";
		String strAcivity_type="";
		String strOFAC_UNSAN="";
		String strRemittance="";
		String strremit_cntry="";
		String strclient_name1="";
		String strclient_location1="";
		String strclient_city1="";
		String strclient_cntry1="";
		String strclient_name2="";
		String strclient_location2 ="";
		String strclient_city2="";
		String strclient_cntry2="";
		String strclient_name3="";
		String strclient_location3="";
		String strclient_city3="";
		String strclient_cntry3="";
		String strrisk_cat="";
		String CustomerCountry="";
		String Strcusttype = "";
		String strhealthcode = "";
		String strfreecode7 = "";
		String strSleepPartner = "";
		String strPoliticalExposed = "";
		String strFamilyShare = "";
		StringBuffer strHashin2=new StringBuffer();
		String strHashOut="";
		try {
			// document=RTFFILEGENERATOR.getInstance();

			strapplicationno = correctNull((String) hashmap.get("strappno"));
			if (strapplicationno.equals(""))
				strapplicationno = correctNull((String) hashmap.get("appno"));
			if (strapplicationno.equalsIgnoreCase("")) {
				strException = "Error Occured While Generating the File";
			}
			
			/*boolean boolappstatus=false;
			if(strapplicationno.equalsIgnoreCase(""))
			{
				boolappstatus=false;
			}
			else
			{
				boolappstatus=updateappstatus(strapplicationno);
			}
			if(boolappstatus)
			{*/
				if (strException.equalsIgnoreCase("false")) {
					strQuery = SQLParser.getSqlQuery("Finacle_sanction1_retail^"
							+ strapplicationno);
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) {
						CustomerTitle = correctNull(rs.getString("perapp_title"));
						CustomerTitle=CustomerTitle.equals("MRS")?"MS":CustomerTitle;
						CustomerName = correctNull(rs.getString("perapp_fname"));
						CustomerStatus = correctNull(rs.getString("perapp_istatus"));
						Address1 = correctNull(rs.getString("ADDRESS1"));
						Address2 = correctNull(rs.getString("address2"));
						State = correctNull(rs.getString("con_comstate"));
						City = correctNull(rs.getString("con_comcity"));
						Pincode = correctNull(rs.getString("con_comzip"));
						CustomerSex = correctNull(rs.getString("PERAPP_SEX"));
						CustomerCommunity = correctNull(rs
								.getString("perapp_religion"));
						CustomerCaste = correctNull(rs.getString("indinfo_caste"));
						Customer_Handicap_Service = correctNull(rs
								.getString("handiservice"));
						CustomerCBSID = correctNull(rs.getString("perapp_cbsid"));
						SolID = correctNull(rs.getString("solid"));
						CBS_Constitution = correctNull(rs
								.getString("perapp_constitution"));
						strDOB = correctNull(rs.getString("perapp_dob"));
						strPANno=correctNull(rs.getString("perapp_panno"));
						
						if(strPANno.equals("NOPAN"))
							strPANno="";
						if (correctNull(rs.getString("perapp_marstat"))
								.equalsIgnoreCase("1")) {
							strMaritalstatus = "MARID";
						} else if (correctNull(rs.getString("perapp_marstat"))
								.equalsIgnoreCase("5")) {
							strMaritalstatus = "";
						} else {
							strMaritalstatus = "SINGL";
						}
						CustomerCountry = correctNull(rs.getString("con_comcountry"));
					}
	
					if (SolID.equalsIgnoreCase("")) {
						strException = "Error: SOLID is not defined for the Organisation";
					}
				}

				/*if (strException.equalsIgnoreCase("false")) {
					strQuery = SQLParser.getSqlQuery("Finacle_sanction2_retail^"
							+ strapplicationno);
					rs.close();
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) {
						CustomerOccupation = correctNull(rs
								.getString("peremp_occupation"));
						strEmpId = correctNull(rs.getString("peremp_empno"));
					}
					if (CustomerOccupation.equalsIgnoreCase("")) {
	
						strException = "Error : Employment Details of the Applicant is not entered";
	
					}
				}*/

				/*
				 * if(strException.equalsIgnoreCase("false")) { strQuery =
				 * SQLParser.getSqlQuery("Finacle_sanction3_retail^"+
				 * strapplicationno); rs.close(); rs =
				 * DBUtils.executeQuery(strQuery); if(rs.next()) {
				 * CBS_Constitution=correctNull(rs.getString("perinc_selfincometype")); }
				 * if(CBS_Constitution.equalsIgnoreCase("")) { strException = "Error :
				 * Income & Expenses of the Applicant is not entered"; } }
				 */

				if (strException.equalsIgnoreCase("false")) {
					strQuery = SQLParser.getSqlQuery("Finacle_sanction4_retail^"
							+ strapplicationno);
					rs.close();
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) {
						TAXSLAB = correctNull(rs.getString("tax_slab"));
						OPERATION_MODE = correctNull(rs.getString("operation_mode"));
						SECTOR_CODE = correctNull(rs.getString("sector_code"));
						PURPOSE_ADVANCE = correctNull(rs
								.getString("purpose_advance"));
						SUB_SECTOR_CODE = correctNull(rs.getString("subsector"));
						SANCTION_LEVEL = correctNull(rs.getString("sanction_level"));
						SANCTION_AUTH = correctNull(rs
								.getString("sanction_authority"));
						FREETEXT7 = correctNull(rs.getString("FreeText7"));
						Stradvmode = correctNull(rs.getString("advmode"));
						stradvtype = correctNull(rs.getString("advtype"));
						strBorrowercat = correctNull(rs.getString("borrowcat"));
						strindtype = correctNull(rs.getString("indtype"));
						// strOccAccntcode=correctNull(rs.getString("accntoccupation"));
						strLabel = correctNull(rs.getString("label"));
						/*Three New Parameter Added - CBS CUSTOMER TYPE,CBS HEALTH CODE and CBS FREE CODE7(DISTRICT)*/
						Strcusttype = correctNull(rs.getString("cbs_cust_type"));
						strhealthcode = correctNull(rs.getString("cbs_health_code"));
						strfreecode7 = correctNull(rs.getString("cbs_freecode7"));
						
						/*-------------------------By Kamal-----------------------------------*/
					}
					if (TAXSLAB.equalsIgnoreCase("")
							|| OPERATION_MODE.equalsIgnoreCase("")) {
						strException = "Error Ocurred While Generating Sanction Details File";
					}
				}

				if (strException.equalsIgnoreCase("false")) {
					strQuery = SQLParser.getSqlQuery("Finacle_sanction5_retail^"
							+ strapplicationno);
					rs.close();
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) {
						LOAN_AMT = correctNull(rs.getString("LOAN_RECMDAMT"));
						LOAN_FREQ = correctNull(rs.getString("loan_periodicity"));
						LOAN_PERIOD = correctNull(rs.getString("loan_reqterms"));
						PAYMENT_METHOD = correctNull(rs.getString("loan_modeofpay"));
						OPERATING_ACCOUNT = correctNull(rs
								.getString("operativeaccno"));
						NO_OF_FLOWS = correctNull(rs.getString("instalments"));
						LOAN_START_DATE = correctNull(rs
								.getString("loan_startdate"));
						SANCTION_REF_NO = correctNull(strapplicationno);
						ROI = correctNull(rs.getString("LOAN_MODINTRATE"));
						SANCTIONED_DATE = correctNull(rs.getString("processdate"));
						NATURE_ADVANCE = correctNull(rs.getString("loan_secure"));
						LIMIT_EXPIRY_DATE = correctNull(rs
								.getString("limitexpirydate"));
						Scheme_Code = correctNull(rs.getString("scheme_code"));
						DOCUMENT_DATE = correctNull(rs.getString("loan_startdate"));// document
																					// date
																					// should
																					// be
																					// system
																					// date
																					// as
																					// per
																					// discussion
																					// with
																					// pankaj
																					// as
																					// on
																					// 28.01.2008
						CBS_Accountno = correctNull(rs.getString("cbsaccount"));
	
						if (NATURE_ADVANCE.equalsIgnoreCase("s")) {
							NATURE_ADVANCE = "001";
						} else if (NATURE_ADVANCE.equalsIgnoreCase("u")) {
							NATURE_ADVANCE = "003";
						} else if (NATURE_ADVANCE.equalsIgnoreCase("p")) {
							NATURE_ADVANCE = "002";
						}
	
						if (Scheme_Code.equalsIgnoreCase("")) {
							strException = "Error: Scheme Code is not defined for the selected Loan Product";
						}
					} else {
						strException = "Error Ocurred While Generating Sanction Details File";
					}
				}

				if (strException.equalsIgnoreCase("false")) 
				{
					
					String strCustid=correctNull((String) hashmap.get("comappid"));
					strQuery = SQLParser.getSqlQuery("Finacle_KYCNorms_retail^"+ strapplicationno);
					rs.close();
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) 
					{
					
						strCropCust=correctNull(rs.getString("kyc_custtype"));
						strOccupation=correctNull(rs.getString("kyc_occupation"));
						CustomerOccupation=correctNull(rs.getString("kyc_occupationcode"));
						strAnnual_Income=correctNull(rs.getString("kyc_annualincome"));
						strResiCntry=correctNull(rs.getString("kyc_countryresi"));
						strForm60_61=correctNull(rs.getString("kyc_form"));
						strFormRef=correctNull(rs.getString("kyc_formrefno"));
						strIDProofType=correctNull(rs.getString("kyc_idprooftype"));
						strIDRef=correctNull(rs.getString("kyc_idproofref"));
						strResiProofType=correctNull(rs.getString("kyc_resiprooftype"));
						strResiIDRef=correctNull(rs.getString("kyc_resiidrefno"));
						strIncome_Source=correctNull(rs.getString("kyc_sourceincome"));
						strNetworth=correctNull(rs.getString("kyc_networth"));
						strTurnOver=correctNull(rs.getString("kyc_turnover"));
						strTurnOverEsti=correctNull(rs.getString("kyc_estiturnover"));
						strPooled_Act=correctNull(rs.getString("kyc_account"));
						strAcivity_type=correctNull(rs.getString("kyc_activity"));
						strOFAC_UNSAN=correctNull(rs.getString("kyc_ofac"));
						strRemittance=correctNull(rs.getString("kyc_remittance"));
						strremit_cntry=correctNull(rs.getString("kyc_remitcountry"));
						strclient_name1=correctNull(rs.getString("kyc_clientname_1"));
						strclient_location1=correctNull(rs.getString("kyc_clientlocation_1"));
						strclient_city1=correctNull(rs.getString("kyc_clientcitycode_1"));
						strclient_cntry1=correctNull(rs.getString("kyc_clientcntrycode_1"));
						strclient_name2=correctNull(rs.getString("kyc_clientname_2"));
						strclient_location2=correctNull(rs.getString("kyc_clientlocation_2"));
						strclient_city2=correctNull(rs.getString("kyc_clientcitycode_2"));
						strclient_cntry2=correctNull(rs.getString("kyc_clientcntrycode_2"));
						strclient_name3=correctNull(rs.getString("kyc_clientname_3"));
						strclient_location3=correctNull(rs.getString("kyc_clientlocation_3"));
						strclient_city3=correctNull(rs.getString("kyc_clientcitycode_3"));
						strclient_cntry3=correctNull(rs.getString("kyc_clientcntrycode_3"));
						strrisk_cat=correctNull(rs.getString("kyc_risk"));
						strSleepPartner=correctNull(rs.getString("kyc_sleeppartner"));
						strPoliticalExposed=correctNull(rs.getString("kyc_politicalexposed"));
						strFamilyShare=correctNull(rs.getString("kyc_familyshare"));
					}
				}
				
				
				if (strException.equalsIgnoreCase("false")) {
					if (CustomerStatus.equalsIgnoreCase("0")) {
						CustomerStatus = "999";
					}
	
					if (PAYMENT_METHOD.equalsIgnoreCase("S"))
						PAYMENT_METHOD = "E";
					String fieldSeperator="|";
					if(strLabel.equalsIgnoreCase("NA"))
					{
						strLabel="";
					}
					
					strHashin2=strHashin2.append(strapplicationno).append(LOAN_AMT).append(ROI).append(Scheme_Code);
					
					strQuery = SQLParser.getSqlQuery("cbshashcode^"+strHashin2);
					rs.close();
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) 
					{
						strHashOut=rs.getString(1);
					}
					if(!strHashOut.equalsIgnoreCase(""))
					{
							SanctionDetails = SanctionDetails.append(strapplicationno)
												.append(fieldSeperator).append(SolID)
												.append(fieldSeperator).append(CustomerCBSID)
												.append( "| |" ).append(Scheme_Code)
												.append(fieldSeperator).append(CustomerTitle)
												.append(fieldSeperator).append(CustomerName)
												.append(fieldSeperator).append(CustomerStatus)
												.append(fieldSeperator).append(CustomerOccupation)
												.append(fieldSeperator).append(CBS_Constitution)
												.append(fieldSeperator).append(CustomerSex)
												.append( "|C|").append(Address1)
												.append(fieldSeperator).append(City)
												.append(fieldSeperator).append(State)
												.append(fieldSeperator).append(Pincode)
												.append(fieldSeperator).append(CustomerCommunity)
												.append(fieldSeperator).append(CustomerCaste)
												.append(fieldSeperator).append(TAXSLAB)
												.append(fieldSeperator).append(OPERATION_MODE)
												.append(fieldSeperator).append(LOAN_AMT)
												.append(fieldSeperator).append(LOAN_FREQ.toUpperCase())
												.append(fieldSeperator).append(LOAN_PERIOD)
												.append(fieldSeperator).append(PAYMENT_METHOD)
												.append(fieldSeperator).append(OPERATING_ACCOUNT)
												.append(fieldSeperator).append(NO_OF_FLOWS)
												.append(fieldSeperator).append(LOAN_START_DATE)
												.append(fieldSeperator).append(SECTOR_CODE)
												.append(fieldSeperator).append(PURPOSE_ADVANCE)
												.append(fieldSeperator).append(NATURE_ADVANCE.toUpperCase())
												.append(fieldSeperator).append(SUB_SECTOR_CODE)
												.append(fieldSeperator).append(Customer_Handicap_Service)
												.append(fieldSeperator).append(FREETEXT7)
												.append(fieldSeperator).append(SANCTION_LEVEL)
												.append(fieldSeperator).append(SANCTION_AUTH)
												.append(fieldSeperator).append(SANCTION_REF_NO)
												.append(fieldSeperator).append(SANCTIONED_DATE)
												.append(fieldSeperator).append(LIMIT_EXPIRY_DATE)
												.append(fieldSeperator).append(DOCUMENT_DATE)
												.append("|M|").append(ROI)
												.append(fieldSeperator).append(CBS_Accountno)
												.append("|99|").append(Address2)
												.append(fieldSeperator).append(strBorrowercat)
												.append(fieldSeperator).append(Stradvmode)
												.append(fieldSeperator).append(stradvtype)
												.append(fieldSeperator).append(strindtype)
												.append(fieldSeperator).append(CustomerOccupation)
												.append(fieldSeperator).append(strPANno)
												.append(fieldSeperator).append(strDOB)
												.append(fieldSeperator).append(strEmpId)
												.append(fieldSeperator).append(strMaritalstatus);

							KYCNorms=KYCNorms.append(fieldSeperator).append(CustomerCountry)
											 .append(fieldSeperator).append(strLabel)
											 .append(fieldSeperator).append(strCropCust)
											 .append(fieldSeperator).append(strOccupation)
											 .append(fieldSeperator).append(strAnnual_Income)
											 .append(fieldSeperator).append(strResiCntry)
											 .append(fieldSeperator).append(strForm60_61)
											 .append(fieldSeperator).append(strFormRef)
											 .append(fieldSeperator).append(strIDProofType)
											 .append(fieldSeperator).append(strIDRef)
											 .append(fieldSeperator).append(strResiProofType)
											 .append(fieldSeperator).append(strResiIDRef)
											 .append(fieldSeperator).append(strIncome_Source)
											 .append(fieldSeperator).append(strNetworth)
											 .append(fieldSeperator).append(strTurnOver)
											 .append(fieldSeperator).append(strTurnOverEsti)
											 .append(fieldSeperator).append(strPooled_Act)
											 .append(fieldSeperator).append(strAcivity_type)
											 .append(fieldSeperator).append(strOFAC_UNSAN)
											 .append(fieldSeperator).append(strRemittance)
											 .append(fieldSeperator).append(strremit_cntry)
											 .append(fieldSeperator).append(strclient_name1)
											 .append(fieldSeperator).append(strclient_location1)
											 .append(fieldSeperator).append(strclient_city1)
											 .append(fieldSeperator).append(strclient_cntry1)
											 .append(fieldSeperator).append(strclient_name2)
											 .append(fieldSeperator).append(strclient_location2)
											 .append(fieldSeperator).append(strclient_city2)
											 .append(fieldSeperator).append(strclient_cntry2)
											 .append(fieldSeperator).append(strclient_name3)
											 .append(fieldSeperator).append(strclient_location3)
											 .append(fieldSeperator).append(strclient_city3)
											 .append(fieldSeperator).append(strclient_cntry3)
											 .append(fieldSeperator).append(strrisk_cat)
											 .append(fieldSeperator).append(Strcusttype)
											 .append(fieldSeperator).append(strhealthcode)
											 .append(fieldSeperator).append(strfreecode7)
											 .append(fieldSeperator).append(strHashOut)
											 .append(fieldSeperator).append(strSleepPartner)
											 .append(fieldSeperator).append(strPoliticalExposed)
											 .append(fieldSeperator).append(strFamilyShare);
					
					SanctionDetails=SanctionDetails.append(KYCNorms);
					}	
					} else {
					SanctionDetails .append(strException);
				}
			//}

		} catch (Exception e) {
			throw new EJBException("Error Occured  " + e.getMessage());
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}

		}
		hashmap.put("FinacleFileValues", SanctionDetails.toString());
		return hashmap;

	}

	private boolean updateappstatus(String strAppno) {
		boolean result=false;
		ArrayList arrValues=new ArrayList();
		HashMap hshQuery=new HashMap();
		HashMap hshQueryValues=new HashMap();
		try{
			hshQuery.put("strQueryId","commworkflowclosapprove");
			arrValues.add(strAppno);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			result=true;
		}catch(Exception ex)
		{
			throw new EJBException("Error in updateappstatus :: "+ex.toString());
		}
		return result;
	}
	public HashMap CoporateCustomerProfile(HashMap hashmap)  {
		HashMap hshcustomer = new HashMap();
		String strQuery = "";
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		ResultSet rs3 = null;
		String strException = "false";
		String CustomerProfile = "";

		try {

			String strApplicationNumber = correctNull((String) hashmap
					.get("com_appno"));
			if (strApplicationNumber.equals("")) {
				strApplicationNumber = correctNull((String) hashmap
						.get("appno"));
			}

			if (strApplicationNumber.equals("")) {
				strException = "Error Occured while Generating Sanction Details File";
			}

			if (strException.equalsIgnoreCase("false")) {
				strQuery = SQLParser
						.getSqlQuery("interface_retcustomerdetailR^"
								+ strApplicationNumber);
				rs1 = DBUtils.executeQuery(strQuery);
				if (rs1.next()) {
					String companyname = Helper.correctNull(Helper
							.correctNull(rs1.getString("comapp_companyname")));
					int subsize = 0;
					if (companyname.length() >= 8)
						subsize = 8;
					else
						subsize = companyname.length();

					String shortname = companyname.substring(0, subsize);

					String PERAPP_ADDRESS2 = Helper.correctNull(rs1
							.getString("comapp_regadd2"));
					String PERAPP_ADDRESS4 = (PERAPP_ADDRESS2);

					String CBS_Constitution = "";
					String Constitution = Helper.correctNull(rs1
							.getString("comapp_ownership"));

					if (Constitution.equalsIgnoreCase("OLP"))// PVT LTD
																// COMPANY
					{
						CBS_Constitution = "005";
					} else if (Constitution.equalsIgnoreCase("OCC"))// PUBLIC
																	// LTD
																	// COMPANY
					{
						CBS_Constitution = "006";
					} else if (Constitution.equalsIgnoreCase("OP"))// PARTNER
																	// SHIP
					{
						CBS_Constitution = "007";
					} else if (Constitution.equalsIgnoreCase("OLC"))// Joint
																	// Borrowers
					{
						CBS_Constitution = "002";
					} else if (Constitution.equalsIgnoreCase("OS"))// Sole
																	// Proprietor
					{
						CBS_Constitution = "009";
					} else if (Constitution.equalsIgnoreCase("Jo"))// Joint
																	// Venture
					{
						CBS_Constitution = "011";
					} else if (Constitution.equalsIgnoreCase("sub"))// Wholly
																	// owned
																	// subsidiary
					{
						CBS_Constitution = "011";
					} else if (Constitution.equalsIgnoreCase("TR"))// Trusts
					{
						CBS_Constitution = "004";
					} else if (Constitution.equalsIgnoreCase("AC"))// Association
					{
						CBS_Constitution = "003";
					} else if (Constitution.equalsIgnoreCase("nbfc"))// NBFC
					{
						CBS_Constitution = "999";
					} else if (Constitution.equalsIgnoreCase("OO"))// Others
					{
						CBS_Constitution = "999";
					} else if (Constitution.equalsIgnoreCase("IN"))// Individual
					{
						CBS_Constitution = "001";
					}

					CustomerProfile = Helper.correctNull(rs1
							.getString("cbs_companycode"))
							+ "|"
							+ Helper.correctNull(rs1.getString("comapp_id"))
							+ "|M/S|"
							+ Helper.correctNull(rs1
									.getString("comapp_companyname"))
							+ "|"
							+ shortname
							+ "|O| |"
							+ Helper.correctNull(rs1
									.getString("comapp_yrsinbusiness"))
							+ "|"
							+ Helper.correctNull(rs1
									.getString("comapp_regadd1"))
							+ "|"
							+ PERAPP_ADDRESS4
							+ "|"
							+ Helper.correctNull(rs1
									.getString("comapp_regstate"))
							+ "|"
							+ Helper
									.correctNull(rs1.getString("comapp_regpin"))
							+ "|"
							+ Helper.correctNull(rs1
									.getString("comapp_regcountry"))
							+ "|"
							+ Helper.correctNull(rs1
									.getString("comapp_regadd1"))
							+ "|"
							+ PERAPP_ADDRESS4
							+ "|"
							+ Helper.correctNull(rs1
									.getString("comapp_regstate"))
							+ "|"
							+ Helper
									.correctNull(rs1.getString("comapp_regpin"))
							+ "|"
							+ Helper.correctNull(rs1
									.getString("comapp_regcountry"))
							+ "| | | | | |N| | |999|"
							+ CBS_Constitution
							+ "|999|N|N| | | |"
							+ Helper
									.correctNull(rs1.getString("company_staff"))
							+ "|"
							+ Helper.correctNull(rs1
									.getString("company_inland"))
							+ "|"
							+ Helper.correctNull(rs1
									.getString("company_introtitle"))
							+ "|"
							+ Helper.correctNull(rs1
									.getString("company_introname"));
				} else {
					strException = "Error Occured while Generating Sanction Details File";
					CustomerProfile = strException;
				}
			} else {
				CustomerProfile = strException;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs1 != null)
					rs1.close();
				if (rs2 != null)
					rs2.close();
				if (rs3 != null)
					rs3.close();
			} catch (Exception e) {
				e.printStackTrace();
			}

		}
		hshcustomer.put("FinacleFileValues", CustomerProfile);
		return hshcustomer;
	}

	/**
	 * @author :R. Muralidharan
	 * @PURPOSE: CORPORATE SANCTION DETAILS.
	 */

	public HashMap corporateSanctionDetails(HashMap hashmap)
			 {
		String strQuery = "";
		String facility_id = "";
		String strException = "false";
		String CompanyID = "";
		String CompanyName = "";
		String SolID = "";
		String Address1 = "", Address2 = "";
		String State = "", City = "";
		String Pincode = "", Country = "";
		String Constitution = "", CBS_Constitution = "";
		String SanctionedDate = "", Limit_Expiry_Date = "";
		String Facility_Parent = "", Scheme_Code = "", CBS_COMPANYCODE = "";
		double dblProposalin = 100000.0;
		// CBS PARAMETERS
		String TAXSLAB = "", OPERATION_MODE = "", LOAN_AMT = "", LOAN_FREQ = "", LOAN_PERIOD = "";
		String PAYMENT_METHOD = "", OPERATING_ACCOUNT = "", NO_OF_FLOWS = "", LOAN_START_DATE = "";
		String SECTOR_CODE = "", PURPOSE_ADVANCE = "", NATURE_ADVANCE = "", SUB_SECTOR_CODE = "";
		String SANCTION_LEVEL = "", SANCTION_AUTH = "", SANCTION_REF_NO = "", ROI = "", DOCUMENT_DATE = "", FREETEXT7 = "";
		String strBorrowercat = "";
		String Stradvmode = "";
		String stradvtype = "";
		String strindtype = "";
		String strPANno = "";
		String strDOB = "";
		String strMaritalstatus = "";
		String strEmpId = "";
		String SENT_FLAG = "false";
		String approve_flag = "Y";
		//String SanctionDetails = "";
		String serialno = "";
		String CBS_Accountno = "";
		String strmodtype = "";
		ResultSet rs = null;

		String strtitle = "M/S";
		String strGender = "O";
		String strOccupation = "999";
		String strstatus = "999";
		String strCommunity = "999";
		String strCaste = "999";
		String strphyshandicapped = "NN";
		// String strOccAccntcode="";
		
		String strCropCust="";
		String strKYCOccupation="";
		String strAnnual_Income="";
		String strResiCntry="";
		String strForm60_61="";
		String strFormRef="";
		String strIDProofType="";
		String strIDRef="";
		String strResiProofType="";
		String strResiIDRef="";
		String strIncome_Source="";
		String strNetworth="";
		String strTurnOver="";
		String strTurnOverEsti="";
		String strPooled_Act="";
		String strAcivity_type="";
		String strOFAC_UNSAN="";
		String strRemittance="";
		String strremit_cntry="";
		String strclient_name1="";
		String strclient_location1="";
		String strclient_city1="";
		String strclient_cntry1="";
		String strclient_name2="";
		String strclient_location2="";
		String strclient_city2="";
		String strclient_cntry2="";
		String strclient_name3="";
		String strclient_location3="";
		String strclient_city3="";
		String strclient_cntry3="";
		String strrisk_cat="";
		String Strcusttype = "";
		String strhealthcode = "";
		String strfreecode7 = "";
		String strSleepPartner = "";
		String strPoliticalExposed = "";
		String strFamilyShare = "";
		StringBuffer strHashin2=new StringBuffer();
		String strHashOut="";
		
		StringBuffer SanctionDetails = new StringBuffer();
		StringBuffer KYCNorms = new StringBuffer();
		try {
			String strapplicationno = correctNull((String) hashmap
					.get("com_appno"));
			strmodtype = correctNull((String) hashmap.get("mod_type"));

			if (strapplicationno.equalsIgnoreCase("")) {
				strapplicationno = correctNull((String) hashmap.get("appno"));
			}

			if (strapplicationno.equalsIgnoreCase("")) {
				strException = "Error Occured while Generating Sanction Details File";
			}

			// To get selected facility id from page

			facility_id = correctNull((String) hashmap.get("sel_ram_facility"));

			// TO get data from customer profile for tertiary

			if (strException.equalsIgnoreCase("false")) {
				if (strmodtype.equalsIgnoreCase("ops")) {
					strQuery = SQLParser
							.getSqlQuery("tertiary_sanction_details^"
									+ strapplicationno);
					rs = DBUtils.executeQuery(strQuery);

					if (rs.next()) {
						strtitle = correctNull(rs.getString("perapp_title"));
						strtitle=strtitle.equals("MRS")?"MS":strtitle;
						// CompanyID=correctNull(rs.getString("comapp_id"));
						CBS_COMPANYCODE = correctNull(rs
								.getString("perapp_cbsid"));
						CompanyName = correctNull(rs.getString("perapp_fname"));
						SolID = correctNull(rs.getString("solid"));
						Address1 = correctNull(rs.getString("PERAPP_ADDRESS1"));
						Address2 = correctNull(rs.getString("PERAPP_ADDRESS2"));
						City = correctNull(rs.getString("PERAPP_CITY"));
						State = correctNull(rs.getString("PERAPP_STATE"));
						Pincode = correctNull(rs.getString("PERAPP_ZIP"));
						Country = correctNull(rs.getString("perapp_country"));
						CBS_Constitution = correctNull(rs
								.getString("perapp_constitution"));
						SanctionedDate = correctNull(rs
								.getString("sanction_date"));
						Limit_Expiry_Date = correctNull(rs
								.getString("expiry_date"));
						// DOCUMENT_DATE=correctNull(rs.getString("application_date"));
						DOCUMENT_DATE = correctNull(rs
								.getString("current_date"));// document date
															// should be system
															// date as per
															// discussion with
															// pankaj as on
															// 28.01.2008
						//strOccupation = correctNull(rs.getString("peremp_occupation"));
						
						strGender = correctNull(rs.getString("PERAPP_SEX"));
						strstatus = correctNull(rs.getString("perapp_istatus"));
						strCommunity = correctNull(rs
								.getString("PERAPP_RELIGION"));
						strCaste = correctNull(rs.getString("perapp_category"));
						strphyshandicapped = correctNull(rs
								.getString("handiservice"));
						strPANno = correctNull(rs.getString("perapp_panno"));
						if(strPANno.equals("NOPAN"))
							strPANno="";
						strDOB = correctNull(rs.getString("perapp_dob"));
						if (correctNull(rs.getString("perapp_marstat"))
								.equalsIgnoreCase("1")) {
							strMaritalstatus = "MARID";
						} else if (correctNull(rs.getString("perapp_marstat"))
								.equalsIgnoreCase("5")) {
							strMaritalstatus = "";
						} else {
							strMaritalstatus = "SINGL";
						}
						strEmpId = "";//correctNull(rs.getString("peremp_empno"));
					}

				} else {
					strQuery = SQLParser
							.getSqlQuery("corporate_sanction_details^"
									+ strapplicationno);
					rs = DBUtils.executeQuery(strQuery);

					if (rs.next()) {
						CompanyID = correctNull(rs.getString("comapp_oldid"));
						CBS_COMPANYCODE = correctNull(rs
								.getString("CBS_COMPANYCODE"));
						CompanyName = correctNull(rs
								.getString("comapp_companyname"));
						SolID = correctNull(rs.getString("solid"));
						Address1 = correctNull(rs.getString("comapp_regadd1"));
						Address2 = correctNull(rs.getString("comapp_regadd2"));
						City = correctNull(rs.getString("comapp_regcity"));
						State = correctNull(rs.getString("comapp_regstate"));
						Pincode = correctNull(rs.getString("comapp_regpin"));
						Country = correctNull(rs.getString("comapp_regcountry"));
						Constitution = correctNull(rs
								.getString("comapp_ownership"));
						SanctionedDate = correctNull(rs
								.getString("sanction_date"));
						Limit_Expiry_Date = correctNull(rs
								.getString("expiry_date"));
						// DOCUMENT_DATE=correctNull(rs.getString("application_date"));
						DOCUMENT_DATE = correctNull(rs
								.getString("current_date"));// document date
															// should be system
															// date as per
															// discussion with
															// pankaj as on
															// 28.01.2008
						strPANno = correctNull(rs
								.getString("comapp_corpstructure"));
						if(strPANno.equals("NOPAN"))
							strPANno="";
						strDOB = correctNull(rs.getString("doi"));
						strMaritalstatus = "";
						strEmpId = "";
					}
				}
			}
			if (!strmodtype.equalsIgnoreCase("ops")) {
				if (CompanyName.equalsIgnoreCase("")
						|| Constitution.equalsIgnoreCase("")) {
					strException = "Error Occured while Generating Sanction Details File";
				}

				if (SolID.equalsIgnoreCase("")) {
					strException = "Error: SOLID is not defined for the Organisation";
				}
			}
			if (rs != null) {
				rs.close();
			}

			strQuery = SQLParser.getSqlQuery("selprosalvaluesin^"
					+ strapplicationno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				if (rs.getString("prop_valuesin").equalsIgnoreCase("C")) {
					dblProposalin = 10000000.0;
				}
			}
			// To get data from sanction details page

			if (strException.equalsIgnoreCase("false")) {

				strQuery = SQLParser
						.getSqlQuery("sel_sanction_details_interface^"
								+ strapplicationno + "^" + facility_id + "^"
								+ approve_flag);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					Scheme_Code = correctNull(rs.getString("scheme_code"));
					Facility_Parent = correctNull(rs
							.getString("facility_parent"));
					serialno = correctNull(rs.getString("sno"));
					TAXSLAB = correctNull(rs.getString("cbs_taxslab"));
					OPERATION_MODE = correctNull(rs
							.getString("cbs_operation_mode"));
					if (strmodtype.equalsIgnoreCase("ops"))// for tertiray
					{
						LOAN_AMT = Helper.formatDoubleValue((Double
								.parseDouble(Helper.correctDouble(rs
										.getString("sanctioned_amt")))));
					} else {
						LOAN_AMT = Helper
								.formatDoubleValue((Double.parseDouble(Helper
										.correctDouble(rs
												.getString("sanctioned_amt"))) * dblProposalin));
					}
					LOAN_FREQ = correctNull(rs.getString("cbs_loan_frequency"));
					if (LOAN_FREQ.equalsIgnoreCase("N"))
						LOAN_FREQ = "";// for nota applicable we need to send
										// blank.
					LOAN_PERIOD = correctNull(rs.getString("cbs_loan_period"));
					PAYMENT_METHOD = correctNull(rs
							.getString("cbs_payment_method"));
					OPERATING_ACCOUNT = correctNull(rs
							.getString("cbs_operating_accno"));
					NO_OF_FLOWS = correctNull(rs.getString("cbs_noofflows"));
					LOAN_START_DATE = correctNull(rs
							.getString("loan_start_date"));
					SECTOR_CODE = correctNull(rs.getString("cbs_sector_code"));
					PURPOSE_ADVANCE = correctNull(rs
							.getString("cbs_purposeof_advance"));
					NATURE_ADVANCE = correctNull(rs
							.getString("cbs_natureof_advance"));
					SUB_SECTOR_CODE = correctNull(rs
							.getString("cbs_subsector_code"));
					SANCTION_LEVEL = correctNull(rs
							.getString("cbs_sanction_level"));
					SANCTION_AUTH = correctNull(rs
							.getString("cbs_sanction_authority"));
					SANCTION_REF_NO = correctNull(rs
							.getString("cbs_sanction_refno"));
					ROI = correctNull(rs.getString("sanctioned_interest"));
					FREETEXT7 = correctNull(rs.getString("FreeText7"));
					CBS_Accountno = correctNull(rs.getString("cbs_accountno"));
					strBorrowercat = correctNull(rs
							.getString("cbs_borrowercat"));
					Stradvmode = correctNull(rs.getString("cbs_advmode"));
					stradvtype = correctNull(rs.getString("cbs_advtype"));
					strindtype = correctNull(rs.getString("cbs_indtype"));
					
					/*Three New Parameter Added - CBS CUSTOMER TYPE,CBS HEALTH CODE and CBS FREE CODE7(DISTRICT)*/
					Strcusttype = correctNull(rs.getString("cbs_cust_type"));
					strhealthcode = correctNull(rs.getString("cbs_health_code"));
					strfreecode7 = correctNull(rs.getString("cbs_freecode7"));
					
					/*-------------------------By Kamal-----------------------------------*/

				} else {
					strException = "Error Occured while Generating Sanction Details File";

				}
			}
			if (rs != null) {
				rs.close();
			}

			
			if (strException.equalsIgnoreCase("false")) 
			{
				
				String custid=correctNull((String) hashmap.get("comid"));
				if(custid.equalsIgnoreCase(""))
				{
					custid=correctNull((String) hashmap.get("comappid"));
				}
				
				strQuery = SQLParser.getSqlQuery("Finacle_KYCNorms_corp^"+ strapplicationno);
				rs.close();
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) 
				{
				
					strCropCust=correctNull(rs.getString("kyc_custtype"));
					strKYCOccupation=correctNull(rs.getString("kyc_occupation"));
					strOccupation=correctNull(rs.getString("kyc_occupationcode"));
					strAnnual_Income=correctNull(rs.getString("kyc_annualincome"));
					strResiCntry=correctNull(rs.getString("kyc_countryresi"));
					strForm60_61=correctNull(rs.getString("kyc_form"));
					strFormRef=correctNull(rs.getString("kyc_formrefno"));
					strIDProofType=correctNull(rs.getString("kyc_idprooftype"));
					strIDRef=correctNull(rs.getString("kyc_idproofref"));
					strResiProofType=correctNull(rs.getString("kyc_resiprooftype"));
					strResiIDRef=correctNull(rs.getString("kyc_resiidrefno"));
					strIncome_Source=correctNull(rs.getString("kyc_sourceincome"));
					strNetworth=correctNull(rs.getString("kyc_networth"));
					strTurnOver=correctNull(rs.getString("kyc_turnover"));
					strTurnOverEsti=correctNull(rs.getString("kyc_estiturnover"));
					strPooled_Act=correctNull(rs.getString("kyc_account"));
					strAcivity_type=correctNull(rs.getString("kyc_activity"));
					strOFAC_UNSAN=correctNull(rs.getString("kyc_ofac"));
					strRemittance=correctNull(rs.getString("kyc_remittance"));
					strremit_cntry=correctNull(rs.getString("kyc_remitcountry"));
					strclient_name1=correctNull(rs.getString("kyc_clientname_1"));
					strclient_location1=correctNull(rs.getString("kyc_clientlocation_1"));
					strclient_city1=correctNull(rs.getString("kyc_clientcitycode_1"));
					strclient_cntry1=correctNull(rs.getString("kyc_clientcntrycode_1"));
					strclient_name2=correctNull(rs.getString("kyc_clientname_2"));
					strclient_location2=correctNull(rs.getString("kyc_clientlocation_2"));
					strclient_city2=correctNull(rs.getString("kyc_clientcitycode_2"));
					strclient_cntry2=correctNull(rs.getString("kyc_clientcntrycode_2"));
					strclient_name3=correctNull(rs.getString("kyc_clientname_3"));
					strclient_location3=correctNull(rs.getString("kyc_clientlocation_3"));
					strclient_city3=correctNull(rs.getString("kyc_clientcitycode_3"));
					strclient_cntry3=correctNull(rs.getString("kyc_clientcntrycode_3"));
					strrisk_cat=correctNull(rs.getString("kyc_risk"));
					strSleepPartner=correctNull(rs.getString("kyc_sleeppartner"));
					strPoliticalExposed=correctNull(rs.getString("kyc_politicalexposed"));
					strFamilyShare=correctNull(rs.getString("kyc_familyshare"));
					
				}
			}
			
			// TO MAP COMPANY CONSTITUTION WITH CBS CODE

			if (strException.equalsIgnoreCase("false")) {
				if (!strmodtype.equalsIgnoreCase("ops")) {
					if (Constitution.equalsIgnoreCase("OLP"))// PVT LTD
																// COMPANY
					{
						CBS_Constitution = "07";
					} else if (Constitution.equalsIgnoreCase("OCC"))// PUBLIC
																	// LTD
																	// COMPANY
					{
						CBS_Constitution = "08";
					} else if (Constitution.equalsIgnoreCase("OP"))// PARTNER
																	// SHIP
					{
						CBS_Constitution = "09";
					} else if (Constitution.equalsIgnoreCase("OLC"))// Joint
																	// Borrowers
					{
						CBS_Constitution = "02";
					} else if (Constitution.equalsIgnoreCase("OS"))// Sole
																	// Proprietor
					{
						CBS_Constitution = "009";
					} else if (Constitution.equalsIgnoreCase("Jo"))// Joint
																	// Venture
					{
						CBS_Constitution = "011";
					} else if (Constitution.equalsIgnoreCase("sub"))// Wholly
																	// owned
																	// subsidiary
					{
						CBS_Constitution = "011";
					} else if (Constitution.equalsIgnoreCase("TR"))// Trusts
					{
						CBS_Constitution = "06";
					} else if (Constitution.equalsIgnoreCase("AC"))// Association
					{
						CBS_Constitution = "04";
					} else if (Constitution.equalsIgnoreCase("nbfc"))// NBFC
					{
						CBS_Constitution = "999";
					} else if (Constitution.equalsIgnoreCase("OO"))// Others
					{
						CBS_Constitution = "99";
					} else if (Constitution.equalsIgnoreCase("IN"))// Individual
					{
						CBS_Constitution = "01";
					}
				}
				
				strHashin2=strHashin2.append(strapplicationno).append(LOAN_AMT).append(ROI).append(Scheme_Code);
				strQuery = SQLParser.getSqlQuery("cbshashcode^"+strHashin2);
				rs.close();
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) 
				{
					strHashOut=rs.getString(1);
				}
				if(!strHashOut.equalsIgnoreCase(""))
				{
				SanctionDetails = SanctionDetails .append(strapplicationno) .append("|")
												  .append(SolID).append("|")
												  .append(CBS_COMPANYCODE ).append("| |")
												  .append(Scheme_Code).append("|")
												  .append(strtitle).append("|")
												  .append(CompanyName).append("|")
												  .append(strstatus).append("|")
												  .append(strOccupation).append("|")
												  .append(CBS_Constitution).append("|")
												  .append(strGender).append("|C|")
												  .append(Address1).append("|")
												  .append(City).append("|")
												  .append(State).append("|")
												  .append(Pincode).append("|")
												  .append(strCommunity).append("|")
												  .append(strCaste).append("|")
												  .append(TAXSLAB ).append("|")
												  .append(OPERATION_MODE ).append("|")
												  .append(LOAN_AMT).append("|")
												  .append(LOAN_FREQ).append("|")
												  .append(LOAN_PERIOD).append("|")
												  .append(PAYMENT_METHOD).append("|")
												  .append(OPERATING_ACCOUNT).append( "|")
												  .append(NO_OF_FLOWS).append("|")
												  .append(LOAN_START_DATE).append("|")
												  .append(SECTOR_CODE).append("|")
												  .append(PURPOSE_ADVANCE).append("|")
												  .append(NATURE_ADVANCE).append("|" )
												  .append(SUB_SECTOR_CODE).append("|")
												  .append(strphyshandicapped).append("|" )
												  .append(FREETEXT7).append("|")
												  .append(SANCTION_LEVEL).append("|")
												  .append(SANCTION_AUTH).append("|")
												  .append(SANCTION_REF_NO).append("|")
												  .append(SanctionedDate).append("|")
												  .append(Limit_Expiry_Date).append("|")
												  .append(DOCUMENT_DATE).append("|M|")
												  .append(ROI).append("|")
												  .append(CBS_Accountno).append("|")
												  .append(serialno).append("|")
												  .append(Address2).append("|")
												  .append(strBorrowercat).append("|")
												  .append(Stradvmode).append("|")
												  .append(stradvtype).append("|")
												  .append(strindtype).append("|")
												  .append(strOccupation).append("|")
												  .append(strPANno).append("|")
												  .append(strDOB).append("|")
												  .append(strEmpId).append("|")
												  .append(strMaritalstatus);

							   KYCNorms=KYCNorms.append("|").append(Country)
							   					.append("||").append(strCropCust)
												.append("|").append(strKYCOccupation)
												.append("|").append(strAnnual_Income)
												.append("|").append(strResiCntry)
												.append("|").append(strForm60_61)
												.append("|").append(strFormRef)
												.append("|").append(strIDProofType)
												.append("|").append(strIDRef)
												.append("|").append(strResiProofType)
												.append("|").append(strResiIDRef)
												.append("|").append(strIncome_Source)
												.append("|").append(strNetworth)
												.append("|").append(strTurnOver)
												.append("|").append(strTurnOverEsti)
												.append("|").append(strPooled_Act)
												.append("|").append(strAcivity_type)
												.append("|").append(strOFAC_UNSAN)
												.append("|").append(strRemittance)
												.append("|").append(strremit_cntry)
												.append("|").append(strclient_name1)
												.append("|").append(strclient_location1)
												.append("|").append(strclient_city1)
												.append("|").append(strclient_cntry1)
												.append("|").append(strclient_name2)
												.append("|").append(strclient_location2)
												.append("|").append(strclient_city2)
												.append("|").append(strclient_cntry2)
												.append("|").append(strclient_name3)
												.append("|").append(strclient_location3)
												.append("|").append(strclient_city3)
												.append("|").append(strclient_cntry3)
												.append("|").append(strrisk_cat)
												.append("|").append(Strcusttype)
												.append("|").append(strhealthcode)
												.append("|").append(strfreecode7)
												.append("|").append(strHashOut)
												.append("|").append(strSleepPartner)
												.append("|").append(strPoliticalExposed)
												.append("|").append(strFamilyShare);
							   
				
			SanctionDetails=SanctionDetails.append(KYCNorms);
			
			}
			}
			else {
				SanctionDetails .append(strException);
			}

			SENT_FLAG = "true";
		} catch (Exception e) {
			throw new EJBException(e.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}

		}
		hashmap.put("SENT_FLAG", SENT_FLAG);
		hashmap.put("checkData", "YES");
		hashmap.put("FinacleFileValues", SanctionDetails.toString());
		return hashmap;

	}

	// Retail Sanction Detail

	public HashMap getadditionalParameter1(HashMap hshValues)
			 {
		String strQuery = "";
		String strAppStatus = "";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String appno = correctNull((String) hshValues.get("strappno"));
		if (appno.equalsIgnoreCase("")) {
			appno = correctNull((String) hshValues.get("hidAppNo"));
		}
		if (appno.equalsIgnoreCase("")) {
			appno = correctNull((String) hshValues.get("appno"));
		}
		String hidapptype = correctNull((String) hshValues.get("hidAppType"));
		// String strGradeNo= correctNull((String)hshValues.get("selsno"));
		// String strDate= correctNull((String)hshValues.get("txt_insdate"));
		try {

			
			
			strQuery = SQLParser.getSqlQuery("addparameterselval1^" + appno
					+ "^" + hidapptype);
			rs = DBUtils.executeQuery(strQuery);

			if (rs.next()) {
				hshRecord.put("txt_taxslab", Helper.correctNull((String) rs
						.getString("tax_slab")));
				hshRecord.put("sel_subsector", Helper.correctNull((String) rs
						.getString("subsector")));
				hshRecord.put("sel_operationmode", Helper
						.correctNull((String) rs.getString("operation_mode")));
				hshRecord.put("sel_sanctionlevel", Helper
						.correctNull((String) rs.getString("sanction_level")));
				hshRecord.put("sel_sectorcode", Helper.correctNull((String) rs
						.getString("sector_code")));
				hshRecord.put("sel_sanctionauthority", Helper
						.correctNull((String) rs
								.getString("sanction_authority")));
				hshRecord.put("sel_purpose_advance", Helper
						.correctNull((String) rs.getString("purpose_advance")));
				hshRecord.put("FreeText7", Helper.correctNull((String) rs
						.getString("FreeText7")));
				hshRecord.put("freetextdesc", Helper.correctNull((String) rs
						.getString("freetextdesc")));
				hshRecord.put("borrowcat", Helper.correctNull((String) rs
						.getString("borrowcat")));
				hshRecord.put("advmode", Helper.correctNull((String) rs
						.getString("advmode")));
				hshRecord.put("advtype", Helper.correctNull((String) rs
						.getString("advtype")));
				hshRecord.put("indtype", Helper.correctNull((String) rs
						.getString("indtype")));
				hshRecord.put("labelcode", Helper.correctNull((String) rs
						.getString("label")));
				hshRecord.put("labeldesc", Helper.correctNull((String) rs
						.getString("labeldesc")));
				/*Three New Parameter*/
				hshRecord.put("customertype", Helper.correctNull((String) rs.getString("cbs_cust_type")));
				hshRecord.put("customertypedesc", Helper.correctNull((String) rs.getString("cbs_cust_typedesc")));
				hshRecord.put("healthcode", Helper.correctNull((String) rs.getString("cbs_health_code")));
				hshRecord.put("healthcodedesc", Helper.correctNull((String) rs.getString("cbs_health_codedesc")));
				hshRecord.put("freecode7", Helper.correctNull((String) rs.getString("cbs_freecode7")));
				hshRecord.put("freecode7desc", Helper.correctNull((String) rs.getString("cbs_freecode7desc")));
				/*-----By Kamal----*/
				hshRecord.put("flag", "true");
				hshRecord.put("appno", appno);

			}

			if (rs != null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("commworkflowsel2^" + appno);
			if (rs.next()) {
				strAppStatus = rs.getString(1);
			}
			if (rs != null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("comfunsel2^" + appno);
			if (rs.next()) {
				String strPanno = Helper.correctNull((String)rs.getString("perapp_panno"));
				
				if(strPanno.trim().equalsIgnoreCase("NOPAN"))
					hshRecord.put("txt_taxslab",strPanno);
					
			}
			if (rs != null)
				rs.close();
			
			hshRecord.put("appstatus", strAppStatus);

		} catch (Exception ce) {
			throw new EJBException("Error in getData " + ce.toString());
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

	public HashMap updateadditionalParameter1(HashMap hshValues)
			 {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = new ArrayList();
		String strAction = (String) hshValues.get("hidAction");
		String appno = correctNull((String) hshValues.get("strappno"));
		if (appno.equalsIgnoreCase("")) {
			appno = correctNull((String) hshValues.get("hidAppNo"));
		}
		if (appno.equalsIgnoreCase("")) {
			appno = correctNull((String) hshValues.get("appno"));
		}

		String hidapptype = correctNull((String) hshValues.get("hidAppType"));
		try {
			if (strAction.equals("insert")) {
				hshQueryValues = new HashMap();
				int intUpdateSize = 0;

				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdateSize++;
				hshQuery.put("strQueryId", "addparameterinsval1");
				arrValues.add(appno);
				arrValues.add((String) hshValues.get("sel_taxslab"));
				arrValues.add(correctNull((String) hshValues
						.get("sel_subsector")));
				arrValues.add(correctNull((String) hshValues
						.get("sel_oprationmode")));
				arrValues.add(correctNull((String) hshValues
						.get("sel_sanctionlevel")));
				arrValues.add(correctNull((String) hshValues
						.get("sel_sectorcode")));
				arrValues.add(correctNull((String) hshValues
						.get("sel_sanctionauthority")));
				arrValues.add(correctNull((String) hshValues
						.get("select_purposeadvance")));
				arrValues.add(hidapptype);
				arrValues.add(correctNull((String) hshValues
						.get("hidfreetext7")));
				arrValues.add(correctNull((String) hshValues
						.get("selborrowercat")));
				arrValues
						.add(correctNull((String) hshValues.get("seladvmode")));
				arrValues
						.add(correctNull((String) hshValues.get("seladvtype")));
				arrValues
						.add(correctNull((String) hshValues.get("selindtype")));
				arrValues
						.add(correctNull((String) hshValues.get("hidlabel")));
				/*Three New Parameter*/
				arrValues.add(correctNull((String) hshValues.get("hidcusttype")));
				arrValues.add(correctNull((String) hshValues.get("hidhealthcode")));
				arrValues.add(correctNull((String) hshValues.get("hidfreecode7")));
				/*Three New Parameter End*/
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

			} else if (strAction.equals("delete")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "addparameterdelval1");
				arrValues.add(appno);
				arrValues.add(hidapptype);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			} else if (strAction.equals("update")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "addparameterdelval1");
				arrValues.add(appno);
				arrValues.add(hidapptype);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

				hshQueryValues = new HashMap();
				int intUpdateSize = 0;

				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdateSize++;
				hshQuery.put("strQueryId", "addparameterinsval1");
				arrValues.add(appno);
				arrValues.add((String) hshValues.get("sel_taxslab"));
				arrValues.add(correctNull((String) hshValues
						.get("sel_subsector")));
				arrValues.add(correctNull((String) hshValues
						.get("sel_oprationmode")));
				arrValues.add(correctNull((String) hshValues
						.get("sel_sanctionlevel")));
				arrValues.add(correctNull((String) hshValues
						.get("sel_sectorcode")));
				arrValues.add(correctNull((String) hshValues
						.get("sel_sanctionauthority")));
				arrValues.add(correctNull((String) hshValues
						.get("select_purposeadvance")));
				arrValues.add(hidapptype);
				arrValues.add(correctNull((String) hshValues
						.get("hidfreetext7")));
				arrValues.add(correctNull((String) hshValues
						.get("selborrowercat")));
				arrValues
						.add(correctNull((String) hshValues.get("seladvmode")));
				arrValues
						.add(correctNull((String) hshValues.get("seladvtype")));
				arrValues
						.add(correctNull((String) hshValues.get("selindtype")));
				arrValues
						.add(correctNull((String) hshValues.get("hidlabel")));
				/*Three New Parameter*/
				arrValues.add(correctNull((String) hshValues.get("hidcusttype")));
				arrValues.add(correctNull((String) hshValues.get("hidhealthcode")));
				arrValues.add(correctNull((String) hshValues.get("hidfreecode7")));
				/*Three New Parameter End*/
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(Integer.toString(intUpdateSize), hshQuery);
				hshQueryValues.put("size", Integer.toString(intUpdateSize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

			}

			HashMap hshRecord = getadditionalParameter1(hshValues);
			hshRecord.put("appno", appno);
			return hshRecord;
		} catch (Exception ce) {
			throw new EJBException("inside update" + ce.toString());
		}
	}

	private HashMap Finacle_CBSCUSTID_CBSAccountNo(HashMap hshValues)
			 {
		String rootPath = "C:/";
		String FolderName = "FINACLEINTERFACE/LapsUpdation/Data";
		String FolderName1 = "";
		String Path = "";
		String badFileName = "";
		String strQuery = "";
		ResultSet rs = null;
		int filecount = 0;
		int goodfile = 0;
		int badfile = 0;

		String ufile = "";
		String strBadColumnName = "";
		String strReadedValue = "";
		int columncount = 0;
		int rowcount = 0;

		String errMsg = "";
		File selectfile = new File(rootPath + FolderName);

		if (!selectfile.exists())
			selectfile.mkdirs();

		String[] FILELIST = selectfile.list();

		String filenames = "";
		FileReader fr = null;
		BufferedReader br = null;

		String BadFileNames[] = new String[FILELIST.length + 1];
		String BadColumnNames[] = new String[FILELIST.length * 20];
		String BadTokenReaded[] = new String[FILELIST.length];
		String BadColumnCount[] = new String[FILELIST.length * 20];
		String BadRowCount[] = new String[FILELIST.length * 100];

		String demo_appid = "";
		String LAPS_ApplicationNo = "";
		String CBS_CustomerID = "";
		String CBS_AccountNo = "";
		String CBS_SchemeCode = "";
		String module = "";
		String serialno = "";

		try {
			for (int i = 0; i < FILELIST.length; i++) {
				int dflag = 0;
				rowcount = 0;
				filecount = FILELIST.length;
				filenames = FILELIST[i];
				Path = rootPath + FolderName + "/" + filenames;
				badFileName = filenames;
				if (!new File(rootPath + FolderName + "/" + filenames).isFile())
					continue;

				fr = new FileReader(Path);
				br = new BufferedReader(fr);
				int j = 0;
				while (true) {
				log.info("Line Started at      ==================   "
									+ j++);
					String read = br.readLine();
					if (read == null || read.equals("null"))
						break;

					String strValues[] = read.split("~");

					LAPS_ApplicationNo = "";
					CBS_CustomerID = "";
					CBS_AccountNo = "";
					CBS_SchemeCode = "";
					serialno = "";

					if (strValues != null && strValues.length == 5) {
						ArrayList arrValues = new ArrayList();
						HashMap hshQuery = new HashMap();
						HashMap hshQueryValues = new HashMap();

						++rowcount;

						if (correctNull(strValues[0]).trim().length() > 2) {
							LAPS_ApplicationNo = correctNull(strValues[0])
									.trim();
							dflag = 1;
						} else {
							errMsg = "Application Number Not Available";
							dflag = 0;
						}

						if (dflag != 0) {
							if (correctNull(strValues[1]).trim().length() > 2) {
								CBS_CustomerID = correctNull(strValues[1])
										.trim();
								dflag = 1;
							} else {
								errMsg = "CBS ID NOT Available for the Application number :: "
										+ LAPS_ApplicationNo;
								dflag = 0;
							}
						}
						if (dflag != 0) {
							if (correctNull(strValues[2]).trim().length() > 2) {
								CBS_AccountNo = correctNull(strValues[2])
										.trim();
								dflag = 1;
							} else {
								errMsg = "Account Number NOT Available for the Application number :: "
										+ LAPS_ApplicationNo;
								dflag = 0;
							}
						}
						if (dflag != 0) {
							if (correctNull(strValues[3]).trim().length() > 2) {
								CBS_SchemeCode = correctNull(strValues[3])
										.trim();
								dflag = 1;
							} else {
								errMsg = "Scheme Code NOT Available for the Application number :: "
										+ LAPS_ApplicationNo;
								dflag = 0;
							}
						}
						if (dflag != 0) {
							if (correctNull(strValues[4]).trim().length() != 0) {
								serialno = correctNull(strValues[4]).trim();
								dflag = 1;
							} else {
								errMsg = "Serial Number NOT Available for the Application number :: "
										+ LAPS_ApplicationNo;
								dflag = 0;
							}
						}
						if (!LAPS_ApplicationNo.equalsIgnoreCase("")
								&& dflag != 0) {
							demo_appid = "";
							strQuery = SQLParser
									.getSqlQuery("FinacleToLaps_onetime_FINACLE_Details_sel^"
											+ LAPS_ApplicationNo);
							rs = DBUtils.executeQuery(strQuery);
							if (rs.next()) {
								demo_appid = correctNull((String) rs
										.getString("demo_appid"));
								module = "Retail";
							}
							if (demo_appid.equalsIgnoreCase("")) {
								rs = null;
								strQuery = SQLParser
										.getSqlQuery("FinacleToLaps_onetime_FINACLE_Details_CORPSEL^"
												+ LAPS_ApplicationNo);
								rs = DBUtils.executeQuery(strQuery);
								if (rs.next()) {
									demo_appid = correctNull((String) rs
											.getString("demo_comappid"));
									if (correctNull(
											(String) rs
													.getString("app_loantype"))
											.equalsIgnoreCase("C"))
										module = "Corporate";
									else
										module = "Tertiary";
								}
							}
							if (demo_appid.equalsIgnoreCase("")) {
								errMsg = "Unknown LAPS Application number";
								dflag = 0;
							}

							rs = null;
							hshQuery = new HashMap();
							hshQueryValues = new HashMap();
							arrValues = new ArrayList();

							if (module.equalsIgnoreCase("Retail")
									&& !demo_appid.equalsIgnoreCase("")
									&& serialno.equalsIgnoreCase("99")) {
								log.info("****** FINACLE INTERFACE - Inside Retail Module *********");

								arrValues.add(CBS_CustomerID);
								arrValues.add(demo_appid);
								hshQuery
										.put("strQueryId",
												"FinacleToLaps_onetime_FINACLE_cbsidupdate");
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("1", hshQuery);

								hshQuery = new HashMap();
								arrValues = new ArrayList();

								arrValues.add(CBS_AccountNo);
								arrValues.add(LAPS_ApplicationNo);
								hshQuery
										.put("strQueryId",
												"FinacleToLaps_onetime_FINACLE_accountupdate");
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", "2");
								hshQueryValues.put("2", hshQuery);
								EJBInvoker.executeStateLess("dataaccess",
										hshQueryValues, "updateData");
								dflag = 1;
							} else if (module.equalsIgnoreCase("Corporate")
									&& !demo_appid.equalsIgnoreCase("")) {

								if (!serialno.equalsIgnoreCase("")) {

									log.info("****** FINACLE INTERFACE - Inside Corporate Module *********");
									arrValues.add(CBS_CustomerID);
									arrValues.add(demo_appid);
									hshQuery
											.put("strQueryId",
													"FinacleToLaps_onetime_FINACLE_cbscorpidupdate");
									hshQuery.put("arrValues", arrValues);
									hshQueryValues.put("1", hshQuery);

									hshQuery = new HashMap();
									arrValues = new ArrayList();

									arrValues.add(CBS_AccountNo);
									arrValues.add(CBS_SchemeCode);
									arrValues.add(LAPS_ApplicationNo);
									arrValues.add(serialno);
									hshQuery
											.put("strQueryId",
													"FinacleToLaps_onetime_FINACLE_corpaccountupdate");
									hshQuery.put("arrValues", arrValues);
									hshQueryValues.put("size", "2");
									hshQueryValues.put("2", hshQuery);
									EJBInvoker.executeStateLess("dataaccess",
											hshQueryValues, "updateData");

									dflag = 1;
								} else {
									dflag = 0;
								}
							} else if (module.equalsIgnoreCase("Tertiary")
									&& !demo_appid.equalsIgnoreCase("")) {

								if (!serialno.equalsIgnoreCase("")) {

								log.info("****** FINACLE INTERFACE - Inside Tertiary Module *********");
									arrValues.add(CBS_CustomerID);
									arrValues.add(demo_appid);
									hshQuery
											.put("strQueryId",
													"FinacleToLaps_onetime_FINACLE_cbsidupdate");
									hshQuery.put("arrValues", arrValues);
									hshQueryValues.put("1", hshQuery);

									hshQuery = new HashMap();
									arrValues = new ArrayList();

									arrValues.add(CBS_AccountNo);
									// arrValues.add(CBS_SchemeCode);
									arrValues.add(LAPS_ApplicationNo);
									arrValues.add(serialno);
									hshQuery
											.put("strQueryId",
													"FinacleToLaps_onetime_FINACLE_corpaccountupdate");
									hshQuery.put("arrValues", arrValues);
									hshQueryValues.put("size", "2");
									hshQueryValues.put("2", hshQuery);
									EJBInvoker.executeStateLess("dataaccess",
											hshQueryValues, "updateData");

									dflag = 1;
								} else {
									dflag = 0;
								}
							} else {
								dflag = 0;
								break;
							}
						} else {
							dflag = 0;
							break;
						}
					} else {
						dflag = 0;
						break;
					}
				}

				br.close();

				FolderName1 = "/FINACLEINTERFACE/LapsUpdation";
				// After success insertion Moving File to Done Folder
				if (dflag == 1) {
					++goodfile;
					File movefile = new File(rootPath + FolderName1 + "/Done");

					if (!movefile.exists()) {
						movefile.mkdir();
					}

					FileReader fr1 = new FileReader(Path);
					BufferedReader br1 = new BufferedReader(fr1);

					// Moving the Success file to Done folder....
					new File(rootPath + FolderName + "/Done/" + filenames);
					FileWriter fw = new FileWriter(rootPath + FolderName1
							+ "/Done/" + filenames);
					BufferedWriter bw = new BufferedWriter(fw);

					while (true) {
						String tempString = br1.readLine();
						if (tempString == null || tempString.equals("null")) {
							break;
						}
						bw.write(tempString);
						bw.newLine();
					}

					br1.close();
					bw.close();
					File dfile = new File(Path);
					if (dfile.exists())
						dfile.delete();

				}

				// Moving the bad file to Bad Folder
				if (dflag == 0) {
					BadFileNames[badfile] = filenames;
					BadColumnNames[badfile] = strBadColumnName;
					BadTokenReaded[badfile] = strReadedValue;
					BadColumnCount[badfile] = new Integer(columncount)
							.toString();
					BadRowCount[badfile] = new Integer(rowcount).toString();

					++badfile;
					File movefile1 = new File(rootPath + FolderName1 + "/Bad");

					if (!movefile1.exists()) {
						movefile1.mkdir();
					}

					new File(rootPath + FolderName + "/Bad/" + filenames);

					FileWriter fw = new FileWriter(rootPath + FolderName1
							+ "/Bad/" + filenames);
					BufferedWriter bw = new BufferedWriter(fw);
					FileReader fr1 = new FileReader(Path);
					BufferedReader br1 = new BufferedReader(fr1);

					while (true) {
						String tempString = br1.readLine();
						if (tempString == null || tempString.equals("null")) {
							dflag = 0;
							break;
						}
						bw.write(tempString);
						bw.newLine();

					}

					bw.close();
					br1.close();
					File dfile = new File(Path);
					if (dfile.exists())
						dfile.delete();

				}// end of if

			}// end of for file selecting loop
			/**
			 * 
			 * END OF SELECTION CODING
			 */

		} catch (Exception e) {

			try {
				ufile = "UnKnown Format File Present in the folder(Terminated)";
				br.close();
				FileReader fr1 = new FileReader(rootPath + FolderName1
						+ filenames);
				BufferedReader br1 = new BufferedReader(fr1);
				if (!new File(rootPath + FolderName1 + "/Bad").exists())
					new File(rootPath + FolderName1 + "/Bad").mkdirs();
				new File(rootPath + FolderName1 + "/Bad/" + filenames);
				FileWriter fw1 = new FileWriter(rootPath + FolderName1
						+ "/Bad/" + filenames);
				BufferedWriter bw1 = new BufferedWriter(fw1);
				while (true) {
					String tempString = br1.readLine();
					if (tempString == null || tempString.equals("null")) {
						break;
					}
					bw1.write(tempString);
					bw1.newLine();
				}

				fr1.close();
				bw1.close();
				try {
					if (new File(Path).exists())
						new File(Path).delete();
				} catch (Exception e1) {
					log.error("File Error" + e1.toString());
				}
			} catch (Exception exce) {
			}

		}
		HashMap returnValues = new HashMap();
		returnValues.put("filecount", new Integer(filecount).toString());
		returnValues.put("goodfile", new Integer(goodfile).toString());
		if (ufile.equals("")) {
			returnValues.put("badfile", new Integer(badfile).toString());
		} else {
			returnValues.put("badfile", ufile);
		}
		returnValues.put("type", "LAPS UPDATION DETAILS");

		ArrayList vecBadFilename = new ArrayList();
		ArrayList vecBadColumnName = new ArrayList();
		ArrayList vecBadColumnCount = new ArrayList();
		ArrayList vecBadRowCount = new ArrayList();
		ArrayList vecBadToken = new ArrayList();

		for (int i = 0; i < badfile; i++) {
			vecBadFilename.add(correctNull(BadFileNames[i]));
			vecBadColumnName.add(correctNull(BadColumnNames[i]));
			vecBadColumnCount.add(correctNull(BadColumnCount[i]));
			vecBadRowCount.add(correctNull(BadRowCount[i]));
			vecBadToken.add(correctNull(BadTokenReaded[i]));
		}

		returnValues.put("badfilename", vecBadFilename);
		returnValues.put("badcolumnname", vecBadColumnName);
		returnValues.put("badcolumncount", vecBadColumnCount);
		returnValues.put("badrowcount", vecBadRowCount);
		returnValues.put("badtoken", vecBadToken);

		returnValues.put("errMsg", errMsg);

		return returnValues;

	}

//	public HashMap Finacledailyupload(HashMap hshValues)  {
//		HashMap hshRecord = new HashMap();
//		try {
//			String strMethod = "";
//			strMethod = correctNull((String) hshValues.get("hidMethod"));
//			if (strMethod.equalsIgnoreCase("ClosedAccounts")) {
//				hshRecord.putAll(ClosedAccounts(hshValues));
//			} else if (strMethod.equalsIgnoreCase("reverseupload")) {
//				hshRecord.putAll(Finacle_CBSCUSTID_CBSAccountNo(hshValues));
//			}
//		} catch (Exception ex) {
//			throw new EJBException("Error In Daily Upload :: " + ex.toString());
//		}
//		return hshRecord;
//	}

	private HashMap ClosedAccounts(HashMap hshValues)  {
		String rootPath = "C:/";
		String FolderName = "/CLOSEDACCOUNTS";
		String FolderName1 = "";
		String Path = "";
		String badFileName = "";
		HashMap hshReturn = new HashMap();
		int filecount = 0;
		int goodfile = 0;
		int badfile = 0;

		String strBadColumnName = "";
		String strReadedValue = "";
		int columncount = 0;
		int rowcount = 0;

		File selectfile = new File(rootPath + FolderName);

		if (!selectfile.exists())
			selectfile.mkdirs();

		String[] FILELIST = selectfile.list();

		String filenames = "";
		FileReader fr = null;
		BufferedReader br = null;

		String BadFileNames[] = new String[FILELIST.length + 1];
		String BadColumnNames[] = new String[FILELIST.length * 4];
		String BadTokenReaded[] = new String[FILELIST.length];
		String BadColumnCount[] = new String[FILELIST.length * 4];
		String BadRowCount[] = new String[FILELIST.length * 100];

		try {

			for (int i = 0; i < FILELIST.length; i++) {
				int dflag = 0;
				rowcount = 0;

				filecount = FILELIST.length;
				filenames = FILELIST[i];
				Path = rootPath + FolderName + "/" + filenames;
				badFileName = filenames;
				if (!new File(rootPath + FolderName + File.separator + filenames).isFile())
					continue;

				fr = new FileReader(Path);
				br = new BufferedReader(fr);

				while (true) {
					String read = br.readLine();
					if (read == null || read.equals("null"))
						break;

					if (!read.equals("")) {
						String strValues[] = read.split("~");

						if (strValues != null && strValues.length == 4) {
							ArrayList arrValues = new ArrayList();
							HashMap hshQuery = new HashMap();
							HashMap hshQueryValues = new HashMap();

							++rowcount;
							dflag = 1;
							if (dflag != 0) {
								int intUpdatesize = 0;
								hshQueryValues = new HashMap();
								hshQuery = new HashMap();
								arrValues = new ArrayList();
								intUpdatesize = intUpdatesize + 1;
								hshQuery.put("strQueryId",
										"updlimitregisterstatus");
								arrValues.add("C");
								arrValues.add(strValues[3]);
								arrValues.add(strValues[0]);
								arrValues.add(strValues[2].trim());
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size", Integer
										.toString(intUpdatesize));
								hshQueryValues.put(Integer
										.toString(intUpdatesize), hshQuery);
								EJBInvoker.executeStateLess("dataaccess",
										hshQueryValues, "updateData");
								dflag = 1;
							} else {
								dflag = 0;
								break;
							}
						}
					}
				}
				br.close();

				FolderName1 = "/";
				// After success insertion Moving File to Done Folder
				if (dflag == 1) {
					++goodfile;
					File movefile = new File(rootPath + FolderName1 + "/Done");

					if (!movefile.exists()) {
						movefile.mkdir();
					}

					FileReader fr1 = new FileReader(Path);
					BufferedReader br1 = new BufferedReader(fr1);

					// Moving the Success file to Done folder....
					new File(rootPath + FolderName1 + "/Done/" + filenames);
					FileWriter fw = new FileWriter(rootPath + FolderName1
							+ "/Done/" + filenames);
					BufferedWriter bw = new BufferedWriter(fw);

					while (true) {
						String tempString = br1.readLine();
						if (tempString == null || tempString.equals("null")) {
							break;
						}
						bw.write(tempString);
						bw.newLine();
					}

					br1.close();
					bw.close();
					File dfile = new File(Path);
					if (dfile.exists())
						dfile.delete();

				}

				// Moving the bad file to Bad Folder
				if (dflag == 0) {
					BadFileNames[badfile] = filenames;
					BadColumnNames[badfile] = strBadColumnName;
					BadTokenReaded[badfile] = strReadedValue;
					BadColumnCount[badfile] = new Integer(columncount)
							.toString();
					BadRowCount[badfile] = new Integer(rowcount).toString();
					++badfile;
					File movefile1 = new File(rootPath + FolderName1 + "/Bad");

					if (!movefile1.exists()) {
						movefile1.mkdir();
					}

					new File(rootPath + FolderName1 + "/Bad/" + filenames);

					FileWriter fw = new FileWriter(rootPath + FolderName1
							+ "/Bad/" + filenames);
					BufferedWriter bw = new BufferedWriter(fw);
					FileReader fr1 = new FileReader(Path);
					BufferedReader br1 = new BufferedReader(fr1);

					while (true) {
						String tempString = br1.readLine();
						if (tempString == null || tempString.equals("null")) {
							dflag = 0;
							break;
						}
						bw.write(tempString);
						bw.newLine();
					}

					bw.close();
					br1.close();
					File dfile = new File(Path);
					if (dfile.exists())
						dfile.delete();

				}// end of if

			}// end of for file selecting loop
			/**
			 * 
			 * END OF SELECTION CODING
			 */

		} catch (Exception e) {
			try {
				br.close();
				FolderName1 = "";
				++badfile;
				File movefile1 = new File(rootPath + FolderName1 + "/Bad");

				if (!movefile1.exists()) {
					movefile1.mkdir();
				}

				new File(rootPath + FolderName1 + "/Bad/" + filenames);

				FileWriter fw = new FileWriter(rootPath + FolderName1 + "/Bad/"
						+ filenames);
				BufferedWriter bw = new BufferedWriter(fw);
				FileReader fr1 = new FileReader(Path);
				BufferedReader br1 = new BufferedReader(fr1);

				while (true) {
					String tempString = br1.readLine();
					if (tempString == null || tempString.equals("null")) {
						break;
					}
					bw.write(tempString);
				}

				br1.close();
				bw.close();
				fr1.close();
				fw.close();
				File dfile = new File(Path);
				if (dfile.exists())
					dfile.delete();
			} catch (Exception exce) {
				throw new EJBException("Error Occured  " + exce.getMessage());
			}

		}

		hshReturn.put("filecount", new Integer(filecount).toString());
		hshReturn.put("goodfile", new Integer(goodfile).toString());
		hshReturn.put("badfile", new Integer(badfile).toString());
		hshReturn.put("type", "Importing Closed Accounts");

		ArrayList vecBadFilename = new ArrayList();
		ArrayList vecBadColumnName = new ArrayList();
		ArrayList vecBadColumnCount = new ArrayList();
		ArrayList vecBadRowCount = new ArrayList();
		ArrayList vecBadToken = new ArrayList();

		for (int i = 0; i < badfile; i++) {
			vecBadFilename.add(Helper.correctNull(BadFileNames[i]));
			vecBadColumnName.add(Helper.correctNull(BadColumnNames[i]));
			vecBadColumnCount.add(Helper.correctNull(BadColumnCount[i]));
			vecBadRowCount.add(Helper.correctNull(BadRowCount[i]));
			vecBadToken.add(Helper.correctNull(BadTokenReaded[i]));
		}

		hshReturn.put("badfilename", vecBadFilename);
		hshReturn.put("badcolumnname", vecBadColumnName);
		hshReturn.put("badcolumncount", vecBadColumnCount);
		hshReturn.put("badrowcount", vecBadRowCount);
		hshReturn.put("badtoken", vecBadToken);

		return hshReturn;

	}

	// Kamal Added - Start
	public HashMap AppStatusFileGeneration(HashMap hashmap)  {
		HashMap hshvalue = new HashMap();
		String strQuery = "";
		ResultSet rs = null;
		ResultSet rs1 = null;
		String frmdate = correctNull((String) hashmap.get("txt_fromdate"));
		String todate = correctNull((String) hashmap.get("txt_todate"));
		StringBuffer strbufdatas = new StringBuffer();
		String strFieldseparator = "~";
		String newLine = System.getProperty("line.separator");
		try {

			if (!frmdate.equals("") && !todate.equals("")) {
				strQuery = SQLParser.getSqlQuery("selappstatus_flatfile_in^"
						+ frmdate + "^" + todate);
			} else if (frmdate.equals("") && !todate.equals("")) {
				strQuery = SQLParser
						.getSqlQuery("selappstatus_flatfiletodate_in^" + todate);
			}

			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				strbufdatas.append(correctNull(rs.getString("INWARD_NO")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("org_name")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("INWARD_CUSTNAME")));
				strbufdatas.append(strFieldseparator);

				String strPurpose = correctNull(rs.getString("INWARD_PURPOSE")).replaceAll("\n", "");
				strbufdatas.append(strPurpose);
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("INWARD_SECTOR")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("CREATEDON")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append("");
				strbufdatas.append(strFieldseparator);

				strbufdatas.append("");
				strbufdatas.append(strFieldseparator);

				strbufdatas.append("");
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("org_add1")) + "  "
						+ correctNull(rs.getString("org_add2")) + " "
						+ correctNull(rs.getString("city_name")) + " "
						+ correctNull(rs.getString("state_name")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("org_phone")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append("DOCUMENTS INCOMPLETE");
				strbufdatas.append(newLine);
			}
			if (rs != null)
				rs.close();

			if (!frmdate.equals("") && !todate.equals("")) {
				strQuery = SQLParser.getSqlQuery("selappstatus_flatfile_prog^"
						+ frmdate + "^" + todate);
			} else if (frmdate.equals("") && !todate.equals("")) {
				strQuery = SQLParser
						.getSqlQuery("selappstatus_flatfiletodate_prog^"
								+ todate);
			}

			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				
				strbufdatas.append(correctNull(rs.getString("INWARD_NO")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("org_name")));
				strbufdatas.append(strFieldseparator);

				strbufdatas
						.append(correctNull(rs.getString("INWARD_CUSTNAME")));
				strbufdatas.append(strFieldseparator);

				String strPurpose = correctNull(rs.getString("INWARD_PURPOSE"))
						.replaceAll("\n", " ");
				strbufdatas.append(strPurpose);
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("INWARD_SECTOR")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("CREATEDON")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("pendingdate")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("pendingorg")));
				strbufdatas.append(strFieldseparator);
				
				strbufdatas.append(correctNull(rs.getString("usr_fname")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("org_add1")) + "  "
						+ correctNull(rs.getString("org_add2")) + " "
						+ correctNull(rs.getString("city_name")) + " "
						+ correctNull(rs.getString("state_name")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("org_phone")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append("IN PROCESS");
				strbufdatas.append(newLine);
			}

			if (rs != null)
				rs.close();

			if (!frmdate.equals("") && !todate.equals("")) {
				strQuery = SQLParser.getSqlQuery("selappstatus_ff_inprocess^"
						+ frmdate + "^" + todate);
			} else if (frmdate.equals("") && !todate.equals("")) {
				strQuery = SQLParser
						.getSqlQuery("selappstatus_fftodate_inprocess^"
								+ todate);
			}

			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				
				strbufdatas.append(correctNull(rs.getString("INWARD_NO")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("receivedorg")));
				strbufdatas.append(strFieldseparator);

				strbufdatas
						.append(correctNull(rs.getString("INWARD_CUSTNAME")));
				strbufdatas.append(strFieldseparator);

				String strPurpose = correctNull(rs.getString("INWARD_PURPOSE"))
						.replaceAll("\n", " ");
				strbufdatas.append(strPurpose);
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("INWARD_SECTOR")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("CREATEDON")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("pendingdate")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("pendingorg")));
				strbufdatas.append(strFieldseparator);
				
				strbufdatas.append(correctNull(rs.getString("usr_fname")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("org_add1")) + "  "
						+ correctNull(rs.getString("org_add2")) + " "
						+ correctNull(rs.getString("city_name")) + " "
						+ correctNull(rs.getString("state_name")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("org_phone")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append("IN PROCESS");
				strbufdatas.append(newLine);
			}

			if (rs != null)
				rs.close();

			if (!frmdate.equals("") && !todate.equals("")) {
				strQuery = SQLParser.getSqlQuery("selappstatus_flatfile_san^"
						+ frmdate + "^" + todate);
			} else if (frmdate.equals("") && !todate.equals("")) {
				strQuery = SQLParser
						.getSqlQuery("selappstatus_flatfiletodate_san^"
								+ todate);
			}

			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				
				strbufdatas.append(correctNull(rs.getString("INWARD_NO")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("org_name")));
				strbufdatas.append(strFieldseparator);

				strbufdatas
						.append(correctNull(rs.getString("INWARD_CUSTNAME")));
				strbufdatas.append(strFieldseparator);

				String strPurpose = correctNull(rs.getString("INWARD_PURPOSE"))
						.replaceAll("\n", " ");
				strbufdatas.append(strPurpose);
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("INWARD_SECTOR")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("CREATEDON")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append("");
				strbufdatas.append(strFieldseparator);

				strbufdatas.append("");
				strbufdatas.append(strFieldseparator);

				strbufdatas.append("");
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("org_add1")) + "  "
						+ correctNull(rs.getString("org_add2")) + " "
						+ correctNull(rs.getString("city_name")) + " "
						+ correctNull(rs.getString("state_name")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("org_phone")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append("SANCTIONED");
				strbufdatas.append(newLine);
			}

			if (rs != null)
				rs.close();

			if (!frmdate.equals("") && !todate.equals("")) {
				strQuery = SQLParser.getSqlQuery("selappstatus_flatfile_rej^"
						+ frmdate + "^" + todate);
			} else if (frmdate.equals("") && !todate.equals("")) {
				strQuery = SQLParser
						.getSqlQuery("selappstatus_flatfiletodate_rej^"
								+ todate);
			}

			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				
				strbufdatas.append(correctNull(rs.getString("INWARD_NO")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("org_name")));
				strbufdatas.append(strFieldseparator);

				strbufdatas
						.append(correctNull(rs.getString("INWARD_CUSTNAME")));
				strbufdatas.append(strFieldseparator);

				String strPurpose = correctNull(rs.getString("INWARD_PURPOSE"))
						.replaceAll("\n", " ");
				strbufdatas.append(strPurpose);
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("INWARD_SECTOR")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("CREATEDON")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append("");
				strbufdatas.append(strFieldseparator);

				strbufdatas.append("");
				strbufdatas.append(strFieldseparator);

				strbufdatas.append("");
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("org_add1")) + "  "
						+ correctNull(rs.getString("org_add2")) + " "
						+ correctNull(rs.getString("city_name")) + " "
						+ correctNull(rs.getString("state_name")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("org_phone")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append("REJECTED/RETURN");
				strbufdatas.append(newLine);
			}
			if (rs != null)
				rs.close();

			if (!frmdate.equals("") && !todate.equals("")) {
				strQuery = SQLParser.getSqlQuery("selappstatus_appnotattach^"
						+ frmdate + "^" + todate);
			} else if (frmdate.equals("") && !todate.equals("")) {
				strQuery = SQLParser
						.getSqlQuery("selappstatustodate_appnotattach^"
								+ todate);
			}

			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				strbufdatas.append(correctNull(rs.getString("INWARD_NO")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("org_name")));
				strbufdatas.append(strFieldseparator);

				strbufdatas
						.append(correctNull(rs.getString("INWARD_CUSTNAME")));
				strbufdatas.append(strFieldseparator);
				String strPurpose = correctNull(rs.getString("INWARD_PURPOSE"))
						.replaceAll("\n", " ");
				strbufdatas.append(strPurpose);
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("INWARD_SECTOR")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("CREATEDON")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("CREATEDON")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("org_name")));
				strbufdatas.append(strFieldseparator);
				
				strbufdatas.append(correctNull(rs.getString("usr_fname")));
				strbufdatas.append(strFieldseparator);
				
				strbufdatas.append(correctNull(rs.getString("org_add1")) + "  "
						+ correctNull(rs.getString("org_add2")) + " "
						+ correctNull(rs.getString("org_city")) + " "
						+ correctNull(rs.getString("org_state")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("org_phone")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append("IN PROCESS");
				strbufdatas.append(newLine);
			}

			if (rs != null)
				rs.close();

			if (!frmdate.equals("") && !todate.equals("")) {
				strQuery = SQLParser.getSqlQuery("selappstatus_brpending^"
						+ frmdate + "^" + todate);
			} else if (frmdate.equals("") && !todate.equals("")) {
				strQuery = SQLParser
						.getSqlQuery("selappstatustodate_brpending^" + todate);
			}

			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				strbufdatas.append(correctNull(rs.getString("INWARD_NO")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("org_name")));
				strbufdatas.append(strFieldseparator);

				strbufdatas
						.append(correctNull(rs.getString("INWARD_CUSTNAME")));
				strbufdatas.append(strFieldseparator);
				String strPurpose = correctNull(rs.getString("INWARD_PURPOSE"))
						.replaceAll("\n", " ");
				strbufdatas.append(strPurpose);
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("INWARD_SECTOR")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("CREATEDON")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("CREATEDON")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("org_name")));
				strbufdatas.append(strFieldseparator);
				
				strbufdatas.append(correctNull(rs.getString("usr_fname")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("org_add1")) + "  "
						+ correctNull(rs.getString("org_add2")) + " "
						+ correctNull(rs.getString("org_city")) + " "
						+ correctNull(rs.getString("org_state")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("org_phone")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append("IN PROCESS");
				strbufdatas.append(newLine);
			}

			if (rs != null)
				rs.close();

			if (!frmdate.equals("") && !todate.equals("")) {
				strQuery = SQLParser.getSqlQuery("selappstatus_saralpending^"
						+ frmdate + "^" + todate);
			} else if (frmdate.equals("") && !todate.equals("")) {
				strQuery = SQLParser
						.getSqlQuery("selappstatustodate_saralpending^"
								+ todate);
			}

			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				strbufdatas.append(correctNull(rs.getString("INWARD_NO")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("org_name")));
				strbufdatas.append(strFieldseparator);

				strbufdatas
						.append(correctNull(rs.getString("INWARD_CUSTNAME")));
				strbufdatas.append(strFieldseparator);
				String strPurpose = correctNull(rs.getString("INWARD_PURPOSE"))
						.replaceAll("\n", " ");
				strbufdatas.append(strPurpose);
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("INWARD_SECTOR")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("CREATEDON")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("CREATEDON")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("org_name")));
				strbufdatas.append(strFieldseparator);
				
				strbufdatas.append(correctNull(rs.getString("usr_fname")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("org_add1")) + "  "
						+ correctNull(rs.getString("org_add2")) + " "
						+ correctNull(rs.getString("city_name")) + " "
						+ correctNull(rs.getString("state_name")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append(correctNull(rs.getString("org_phone")));
				strbufdatas.append(strFieldseparator);

				strbufdatas.append("IN PROCESS");
				strbufdatas.append(newLine);
			}

			if (rs != null)
				rs.close();
			if (rs1 != null)
				rs1.close();
			hshvalue.put("status", "success");
			hshvalue.put("FinacleFileValues", strbufdatas.toString());

		} catch (Exception e) {
			hshvalue.put("status", "fail");
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (rs1 != null)
					rs1.close();
			} catch (Exception e) {
				e.printStackTrace();
			}

		}
		return hshvalue;

	}

	// //Kamal Added - End

	// added by prashanth sent by kamal - 27-08-2009
	public HashMap monBankTypeFlatFile(HashMap hashmap)  {
		HashMap hshvalue = new HashMap();

		String strQuery = "";
		ResultSet rs = null;
		ResultSet rs1 = null;
		String month = correctNull((String) hashmap.get("month"));
		String year = correctNull((String) hashmap.get("year"));
		StringBuffer buf = new StringBuffer();
		String strException = "false";
		try {

			strQuery = SQLParser.getSqlQuery("banktypeflatgenertion^" + month
					+ "^" + year);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {

				buf.append(Helper.correctNull(rs.getString("PERSONAL_SOLID")));
				buf.append("~");
				buf.append(Helper.correctNull(rs.getString("PERSONAL_CBSID")));
				buf.append("~");
				String bank_type = Helper.correctNull(rs
						.getString("PERSONAL_BANKARRANGEMENT"));
				if (bank_type.equals("3")) {
					buf.append("Multiple Banking");
					buf.append("~");
					buf.append("");
					buf.append("~");
					buf.append("");
					buf.append("~");
					buf.append("");

				} else if (bank_type.equals("2")) {
					String lead_bank = Helper.correctNull(rs
							.getString("MMR_LEADBANK"));
					if (lead_bank.equals("1")) {
						buf.append("Consortium Leader");
						buf.append("~");
					} else {
						buf.append("Consortium Member");
						buf.append("~");
					}
					buf.append(Helper.correctNull(rs.getString("MMR_BRANCH")));
					buf.append("~");
					buf.append(Helper.correctNull(rs
							.getString("MMR_SHAREPERCENT")));
					buf.append("~");
					buf.append(Helper
							.correctNull(rs.getString("MON_DATEOFMET")));

				}

				buf.append("\n");
				strException = "true";
			}
			if (strException.equals("true")) {

				hshvalue.put("FinacleFileValues", buf.toString());
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (rs1 != null)
					rs1.close();
			} catch (Exception e) {
				e.printStackTrace();
			}

		}

		return hshvalue;
	}

	public HashMap getPreDisbursementflatfileData(HashMap hshValues)
			 {
		String strQuery = "";
		StringBuffer PredisbursementDetails = new StringBuffer();
		ResultSet rs = null;
		String strstartdate = "", strenddate = "", strOptiontype = "";
		try {
			strstartdate = correctNull((String) hshValues.get("startdate"));
			strenddate = correctNull((String) hshValues.get("enddate"));
			strOptiontype = correctNull((String) hshValues.get("hid_option"));
			if (!strstartdate.equals("") && !strenddate.equals("")
					&& !strOptiontype.equals("")) {
				if (strOptiontype.equals("R")) {
					strQuery = SQLParser
							.getSqlQuery("select_predisbursement_details^"
									+ strstartdate + "^" + strenddate);
					rs = DBUtils.executeQuery(strQuery);

					while (rs.next()) {
						PredisbursementDetails
								.append(correctNull((String) rs
										.getString("solid"))
										+ "~"
										+ correctNull((String) rs
												.getString("app_no"))
										+ "~"
										+ correctNull((String) rs
												.getString("perapp_fname"))
										+ "~"
										+ correctNull((String) rs
												.getString("inward_appliedon"))
										+ "~"
										+ correctNull((String) rs
												.getString("perapp_constitution"))
										+ "~"
										+ " "
										+ "~"
										+ correctNull((String) rs
												.getString("peremp_occupation"))
										+ "~"
										+ correctNull((String) rs
												.getString("perapp_religion"))
										+ "~"
										+ correctNull((String) rs
												.getString("per_caste"))
										+ "~"
										+ " "
										+ "~"
										+ " "
										+ "~"
										+ correctNull((String) rs
												.getString("loan_amtreqd"))
										+ "~"
										+ correctNull((String) rs
												.getString("sector_code"))
										+ "~"
										+ correctNull((String) rs
												.getString("subsector"))
										+ "~"
										+ correctNull((String) rs
												.getString("purpose_advance"))
										+ "~"
										+ correctNull((String) rs
												.getString("prd_code"))
										+ "~"
										+ " "
										+ "~"
										+ " "
										+ "~"
										+ " "
										+ "~"
										+ correctNull((String) rs
												.getString("pre_visitdate"))
										+ "~"
										+ " "
										+ "~"
										+ correctNull((String) rs
												.getString("app_processdate"))
										+ "~"
										+ " "
										+ "~"
										+ correctNull((String) rs
												.getString("app_processdate"))
										+ "~"
										+ correctNull((String) rs
												.getString("loan_recmdamt"))
										+ "~"
										+ correctNull((String) rs
												.getString("perapp_selphysical"))
										+ "~"
										+ correctNull((String) rs
												.getString("loan_costloanprd"))
										+ "~"
										+ " "
										+ "~"
										+ correctNull((String) rs
												.getString("loan_costloanprd"))
										+ "~"
										+ correctNull((String) rs
												.getString("perinc_takehome")));
						PredisbursementDetails.append("\n");
					}
				} else if (strOptiontype.equals("A")) {
					strQuery = SQLParser
							.getSqlQuery("select_predisbursement_details_agr^"
									+ strstartdate + "^" + strenddate);
					rs = DBUtils.executeQuery(strQuery);

					while (rs.next()) {
						PredisbursementDetails
								.append(correctNull((String) rs
										.getString("solid"))
										+ "~"
										+ correctNull((String) rs
												.getString("app_no"))
										+ "~"
										+ correctNull((String) rs
												.getString("perapp_fname"))
										+ "~"
										+ " "
										+ "~"
										+ correctNull((String) rs
												.getString("perapp_constitution"))
										+ "~"
										+ " "
										+ "~"
										+ correctNull((String) rs
												.getString("peremp_occupation"))
										+ "~"
										+ correctNull((String) rs
												.getString("perapp_religion"))
										+ "~"
										+ correctNull((String) rs
												.getString("per_caste"))
										+ "~"
										+ " "
										+ "~"
										+ " "
										+ "~"
										+ correctNull((String) rs
												.getString("loan_amtreqd"))
										+ "~"
										+ correctNull((String) rs
												.getString("sector_code"))
										+ "~"
										+ correctNull((String) rs
												.getString("subsector"))
										+ "~"
										+ correctNull((String) rs
												.getString("purpose_advance"))
										+ "~"
										+ correctNull((String) rs
												.getString("prd_code"))
										+ "~"
										+ " "
										+ "~"
										+ " "
										+ "~"
										+ " "
										+ "~"
										+ correctNull((String) rs
												.getString("inspection_date"))
										+ "~"
										+ " "
										+ "~"
										+ correctNull((String) rs
												.getString("app_processdate"))
										+ "~"
										+ " "
										+ "~"
										+ correctNull((String) rs
												.getString("app_processdate"))
										+ "~"
										+ correctNull((String) rs
												.getString("loan_recmdamt"))
										+ "~"
										+ correctNull((String) rs
												.getString("perapp_selphysical"))
										+ "~"
										+ correctNull((String) rs
												.getString("loan_costloanprd"))
										+ "~"
										+ " "
										+ "~"
										+ correctNull((String) rs
												.getString("loan_costloanprd"))
										+ "~"
										+ correctNull((String) rs
												.getString("perinc_takehome")));
						PredisbursementDetails.append("\n");
					}
				} else if (strOptiontype.equals("T")) {
					strQuery = SQLParser
							.getSqlQuery("select_predisbursement_details_tertiary^"
									+ strstartdate + "^" + strenddate);
					rs = DBUtils.executeQuery(strQuery);

					while (rs.next()) {
						PredisbursementDetails.append(correctNull((String) rs
								.getString("solid"))
								+ "~"
								+ correctNull((String) rs.getString("app_no"))
								+ "~"
								+ correctNull((String) rs
										.getString("perapp_fname"))
								+ "~"
								+ " "
								+ "~"
								+ correctNull((String) rs
										.getString("perapp_constitution"))
								+ "~"
								+ " "
								+ "~"
								+ correctNull((String) rs
										.getString("peremp_occupation"))
								+ "~"
								+ correctNull((String) rs
										.getString("perapp_religion"))
								+ "~"
								+ correctNull((String) rs
										.getString("per_caste"))
								+ "~"
								+ " "
								+ "~"
								+ " "
								+ "~"
								+ correctNull((String) rs
										.getString("facility_proposed"))
								+ "~"
								+ correctNull((String) rs
										.getString("cbs_sector_code"))
								+ "~"
								+ correctNull((String) rs
										.getString("cbs_subsector_code"))
								+ "~"
								+ correctNull((String) rs
										.getString("cbs_purposeof_advance"))
								+ "~"
								+ correctNull((String) rs
										.getString("facility_headid"))
								+ "-"
								+ correctNull((String) rs
										.getString("facility_id"))
								+ "~"
								+ " "
								+ "~"
								+ " "
								+ "~"
								+ " "
								+ "~"
								+ correctNull((String) rs
										.getString("ins_dateofvisit"))
								+ "~"
								+ " "
								+ "~"
								+ correctNull((String) rs
										.getString("app_processdate"))
								+ "~"
								+ " "
								+ "~"
								+ correctNull((String) rs
										.getString("app_processdate"))
								+ "~"
								+ correctNull((String) rs
										.getString("sanctioned_amt"))
								+ "~"
								+ correctNull((String) rs
										.getString("perapp_selphysical"))
								+ "~"
								+ " " + "~" + " " + "~" + " " + "~" + " ");
						PredisbursementDetails.append("\n");
					}
				}
				/*----------------------- Added by Kamal - Start----------------------------*/
				else if (strOptiontype.equals("C")) {
					strQuery = SQLParser
							.getSqlQuery("select_predisbursement_details_corp^"
									+ strstartdate + "^" + strenddate);
					rs = DBUtils.executeQuery(strQuery);

					while (rs.next()) {
						String approve = "";
						String reject = "";

						String strOwnership = correctNull((String) rs
								.getString("COMAPP_OWNERSHIP"));
						if (strOwnership.equalsIgnoreCase("IN")) {
							strOwnership = "001";

						} else if (strOwnership.equalsIgnoreCase("OLP")) {
							strOwnership = "005";

						} else if (strOwnership.equalsIgnoreCase("OCC")) {
							strOwnership = "006";

						} else if (strOwnership.equalsIgnoreCase("OP")) {
							strOwnership = "007";

						} else if (strOwnership.equalsIgnoreCase("OLC")) {
							strOwnership = "002";

						} else if (strOwnership.equalsIgnoreCase("OS")) {
							strOwnership = "009";

						} else if (strOwnership.equalsIgnoreCase("Jo")) {
							strOwnership = "011";

						} else if (strOwnership.equalsIgnoreCase("sub")) {
							strOwnership = "011";

						} else if (strOwnership.equalsIgnoreCase("TR")) {
							strOwnership = "004";

						} else if (strOwnership.equalsIgnoreCase("AC")) {
							strOwnership = "003";

						} else if (strOwnership.equalsIgnoreCase("nbfc")) {
							strOwnership = "999";

						} else if (strOwnership.equalsIgnoreCase("HUF")) {
							strOwnership = "008";

						} else if (strOwnership.equalsIgnoreCase("OO")) {
							strOwnership = "999";

						}

						if (correctNull((String) rs.getString("app_status"))
								.equalsIgnoreCase("pa")
								|| correctNull(
										(String) rs.getString("app_status"))
										.equalsIgnoreCase("ca")) {
							approve = correctNull((String) rs
									.getString("app_processdate"));
						} else if (correctNull(
								(String) rs.getString("app_status"))
								.equalsIgnoreCase("pr")
								|| correctNull(
										(String) rs.getString("app_status"))
										.equalsIgnoreCase("cr")) {
							reject = correctNull((String) rs
									.getString("app_processdate"));
						}
						PredisbursementDetails.append(correctNull((String) rs
								.getString("solid"))
								+ "~"
								+ correctNull((String) rs.getString("app_no"))
								+ "~"
								+ correctNull((String) rs
										.getString("COMAPP_COMPANYNAME"))
								+ "~"
								+ correctNull((String) rs
										.getString("INWARD_APPLIEDON"))
								+ "~"
								+ strOwnership
								+ "~"
								+ ""
								+ "~"
								+ "999"
								+ "~"
								+ "999"
								+ "~"
								+ "999"
								+ "~"
								+ "0"
								+ "~"
								+ ""
								+ "~"
								+ correctNull((String) rs
										.getString("facility_proposed"))
								+ "~"
								+ correctNull((String) rs
										.getString("cbs_sector_code"))
								+ "~"
								+ correctNull((String) rs
										.getString("cbs_subsector_code"))
								+ "~"
								+ correctNull((String) rs
										.getString("cbs_purposeof_advance"))
								+ "~"
								+ correctNull((String) rs
										.getString("Facility_schemecode"))
								+ "~"
								+ ""
								+ "~"
								+ ""
								+ "~"
								+ ""
								+ "~"
								+ correctNull((String) rs
										.getString("DATEOFINSPECTION"))
								+ "~"
								+ ""
								+ "~"
								+ reject
								+ "~"
								+ ""
								+ "~"
								+ approve
								+ "~"
								+ correctNull((String) rs
										.getString("sanctioned_amt"))
								+ "~"
								+ "N"
								+ "~"
								+ correctNull((String) rs
										.getString("facility_proposed"))
								+ "~"
								+ "" + "~" + "" + "~" + "");
						PredisbursementDetails.append("\n");

					}
				}
				/*----------------------- Added by Kamal - End----------------------------*/
			}
		} catch (Exception e) {
			throw new EJBException(
					"Exception in getPreDisbursementflatfileData "
							+ e.getMessage());
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		hshValues.put("FinacleFileValues", PredisbursementDetails.toString());
		return hshValues;
	}

	public HashMap SuitFileGeneration(HashMap hashmap)  {
		HashMap hshvalue = new HashMap();

		String strQuery = "";
		ResultSet rs = null;
		ResultSet rs1 = null;
		String frmdate = correctNull((String) hashmap.get("frmdate"));
		String todate = correctNull((String) hashmap.get("todate"));
		StringBuffer buf = new StringBuffer();
		String strException = "false";
		try {
			if (!frmdate.equals("") && !todate.equals("")) {
				strQuery = SQLParser.getSqlQuery("suitfilegenertion^" + frmdate
						+ "^" + todate);
			} else if (frmdate.equals("") && !todate.equals("")) {
				strQuery = SQLParser.getSqlQuery("suitfilegenertion_to^"
						+ todate);
			}
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				if (rs1 != null)
					rs1.close();
				String appno = Helper.correctNull(rs.getString("appno"));
				strQuery = SQLParser.getSqlQuery("selcbs_solid^" + appno);
				rs1 = DBUtils.executeQuery(strQuery);
				if (rs1.next()) {
					buf.append(Helper.correctNull(rs1
							.getString("cbsnpa_custbranch")));
					buf.append("~");
					buf.append(Helper.correctNull(rs1
							.getString("cbsnpa_custid")));
					buf.append("~");
				}

				buf.append(Helper.correctNull(rs.getString("suit_no")));
				buf.append("~");
				String suit_type = Helper.correctNull(rs
						.getString("suit_courtname"));
				if (suit_type.equals("0"))
					buf.append(suit_type);
				else if (suit_type.equals("2"))
					buf.append("1");
				else
					buf.append("2");
				buf.append("~");
				buf.append(Helper.correctNull(rs.getString("suit_date")));
				buf.append("~");
				buf.append(Helper.correctDouble(rs.getString("suit_amount")));
				buf.append("~");
				buf.append(Helper
						.correctNull(rs.getString("suit_dateofdecree")));
				buf.append("~");
				buf.append(Helper.correctDouble(rs
						.getString("suit_decreeamount")));
				buf.append("~");
				buf.append(Helper
						.correctNull(rs.getString("suit_advocatename")));
				buf.append("~");
				buf.append(Helper.correctNull(rs.getString("suit_phoneno")));
				buf.append("~");
				buf.append(Helper.correctNull(rs.getString("suit_address")));
				buf.append("~");
				buf.append(Helper.correctDouble(rs
						.getString("SUIT_TOTALRECOVERY")));
				buf.append("\n");
				strException = "true";
			}
			if (strException.equals("true")) {

				hshvalue.put("FinacleFileValues", buf.toString());
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (rs1 != null)
					rs1.close();
			} catch (Exception e) {
				e.printStackTrace();
			}

		}

		return hshvalue;
	}

	public HashMap advanceAccountGeneration(HashMap hashmap)
			 {
		HashMap hshvalue = new HashMap();

		String strQuery = "";
		ResultSet rs = null;
		ResultSet rs1 = null;
		String frmdate = correctNull((String) hashmap.get("frmdate"));
		String todate = correctNull((String) hashmap.get("todate"));
		StringBuffer buf = new StringBuffer();
		String strException = "false";
		StringBuffer promoters = null;
		int promflag;

		try {
			if (!frmdate.equals("") && !todate.equals("")) {
				strQuery = SQLParser.getSqlQuery("advaccgenertionretagr^"
						+ frmdate + "^" + todate);
			} else if (frmdate.equals("") && !todate.equals("")) {
				strQuery = SQLParser.getSqlQuery("advaccgenertionretagr_to^"
						+ todate);
			}
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				buf.append(Helper.correctNull(rs.getString("SOLID")));
				buf.append("~");
				buf.append(Helper.correctNull(rs.getString("PERAPP_CBSID")));
				buf.append("~");
				buf.append("");
				buf.append("~");
				buf.append("");
				buf.append("~");
				buf.append(Helper.correctNull(rs.getString("perapp_brdet")));
				buf.append("~");
				buf.append(Helper.correctNull(rs
						.getString("perapp_relativedet")));
				buf.append("~");
				buf.append("");
				buf.append("\n");
				strException = "true";
			}
			if (rs != null)
				rs.close();
			if (!frmdate.equals("") && !todate.equals("")) {
				strQuery = SQLParser.getSqlQuery("advaccgenertionter^"
						+ frmdate + "^" + todate);
			} else if (frmdate.equals("") && !todate.equals("")) {
				strQuery = SQLParser.getSqlQuery("advaccgenertionter_to^"
						+ todate);
			}
			rs = DBUtils.executeQuery(strQuery);

			while (rs.next()) {
				buf.append(Helper.correctNull(rs.getString("SOLID")));
				buf.append("~");
				buf.append(Helper.correctNull(rs.getString("PERAPP_CBSID")));
				buf.append("~");
				buf.append("");
				buf.append("~");
				buf.append("");
				buf.append("~");
				buf.append(Helper.correctNull(rs.getString("perapp_brdet")));
				buf.append("~");
				buf.append(Helper.correctNull(rs
						.getString("perapp_relativedet")));
				buf.append("~");
				buf.append("");
				buf.append("\n");
				strException = "true";
			}

			if (rs != null)
				rs.close();
			if (!frmdate.equals("") && !todate.equals("")) {
				strQuery = SQLParser.getSqlQuery("advaccgenertioncorp^"
						+ frmdate + "^" + todate);
			} else if (frmdate.equals("") && !todate.equals("")) {
				strQuery = SQLParser.getSqlQuery("advaccgenertioncorp_to^"
						+ todate);
			}
			rs = DBUtils.executeQuery(strQuery);

			while (rs.next()) {
				buf.append(Helper.correctNull(rs.getString("SOLID")));
				buf.append("~");
				buf.append(Helper.correctNull(rs.getString("cbs_companycode")));
				buf.append("~");
				buf.append("");
				buf.append("~");
				if (rs1 != null)
					rs1.close();
				strQuery = SQLParser.getSqlQuery("com_promotersname^"
						+ Helper.correctNull(rs.getString("App_no")));
				rs1 = DBUtils.executeQuery(strQuery);
				promoters = new StringBuffer();
				promflag = 0;
				while (rs1.next()) {
					promoters.append(Helper.correctNull(rs1
							.getString("com_compdtfname")));
					promoters.append(",");
					promflag = 1;
				}
				if (promflag == 1) {
					int len = promoters.length();
					buf.append(promoters.substring(0, len - 1));
					buf.append("~");
				} else {
					buf.append("");
					buf.append("~");
				}

				buf.append(Helper.correctNull(rs.getString("COMAPP_EMPRELNO")));
				buf.append("~");
				buf
						.append(Helper.correctNull(rs
								.getString("COMAPP_PLACEPOST")));
				buf.append("~");
				buf.append(Helper.correctNull(rs.getString("COMAPP_BORREL")));
				buf.append("\n");
				strException = "true";
			}
			if (strException.equals("true")) {

				hshvalue.put("FinacleFileValues", buf.toString());
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();

			} catch (Exception e) {
				e.printStackTrace();
			}

		}

		return hshvalue;
	}
	public HashMap getAccountFlatFileReport(HashMap hshValues) 
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		String strAppNo="";
		String strQuery="";
		String strLoanType="";
		try
		{
			strAppNo=Helper.correctNull((String)hshValues.get("appno"));
			if(strAppNo.equalsIgnoreCase(""))
			{
				strAppNo=Helper.correctNull((String)hshValues.get("appno1"));
			}
			if(strAppNo.equalsIgnoreCase(""))
			{
				strAppNo=Helper.correctNull((String)hshValues.get("strappno"));
			}
			if(!strAppNo.equalsIgnoreCase(""))
			{
				strQuery=SQLParser.getSqlQuery("sel_prdloantype^"+strAppNo);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strLoanType=Helper.correctNull((String)rs.getString("prd_loantype"));
				}
				if(strLoanType.equalsIgnoreCase("TL")||strLoanType.equalsIgnoreCase("DL"))
				{
					hshResult=getOtherFlatFileReport(hshValues);
				}
				else if(strLoanType.equalsIgnoreCase("OD"))
				{
					hshResult=getODFlatFileReport(hshValues);
				}
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error Occured  " + e.getMessage());
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
			catch (Exception e)
			{
				e.printStackTrace();
			}
		}
		return hshResult;
	}
	public HashMap getOtherFlatFileReport(HashMap hshValues) 
	{
		java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		SimpleDateFormat sdnew=new SimpleDateFormat("dd/MM/yyyy");
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshRecord = new HashMap();
		ArrayList arrValues=new ArrayList();
		ResultSet rs=null;
		ResultSet rs1=null;
		ResultSet rs2=null;
		ResultSet rs3=null;
		ResultSet rs4=null;
		ResultSet rs8=null;
		ResultSet rs7=null;
		int intDateDiff = 0;
		String strDateDiff = "";
		/*File Directory = null;
		String strPath = "";
		strPath = ApplicationParams.getFlatFile();
		Directory = new File(strPath);
		if (!Directory.exists())
		{
			Directory.mkdirs();
		}*/
		String strFileName = "";
		String strFile = "";
		String strCustCBSId="";
		String strSchemeCode="";
		String strGLSubHeadCode="";
		String strModeOfOperCode="";
		String strPBPSCode="B";
		String strIntTBLCode="";
		String strIDDRPrefPerc="";
		String strSanctLim="";
		String strRepPrdMths="";
		String strRepPrdDays="0";
		String strOpAcId="";
		String strIDMDEffDate="";
		String strIntOnIDMDFlag="Y";
		String strNumOfFlows="";
		String strLRFreqType="";
		String strFlowStartDate="";
		String strFlowAmt="";
		String strLRIntFreqType="";
		String strNextIntDmdDate="";
		String strLimSanctDate="";
		String strLimExpDate="";
		String strLoanPaperDate="";
		String strSanctLevlCode="";
		String strSanctAuthCode="";
		String strSanctRefNum="";
		String strDescOfSecurity="";
		String strDrwngPowerInd="";
		String strLimitB2kid="";
		String strDrwngPowerPcnt="";
		String strDrwngPower="";
		String strFreeCode6="";
		String strFreeCode7="";
		String strFreeCode8="";
		String SanctionDetails="";
		String strExcludeHoliday="";
		String strIntType="";
		String strPrdCode="";
		String strQuery="";
		String strQuery1="";
		String strQuery2="";
		String strQuery3="";
		String strQuery4="";
		String strAppId="";
		String strAppNo="";
		String strHolidayPeriod="";
		String strPrdType="";
		String strSolID="";
		String strAdvanceNature="";
		String strAdvanceType="";
		String strAdvanceMode="";
		String strAdvancePurpose="";
		String strFreeCode3="";
		String strSecurityCode="";
		String strSectorCode="";
		String strSubSectorCode="";
		String strSensitiveSectorCode="";
		String strGuarCoverCode="";
		String strBSROccuCode="";
		String strLBRCode="";
		String strServiceAreaCode="";
		String strLandHoldCode="";
		String strBankScheme="";
		String strLrIntFreqHldyStat="N";
		String strProcessedFlg="";
		String strAcctOccpCode="";
		String strBorrowerCatCode="";
		String strSCSTCode="";
		String strLRFreqStartDD="";
		String strRenewFlg="";
		String strFreqStartDD="1";
		String strFreqHldyStat="N";
		String strPSDespatchMode="N";
		String strLocalCallFlg="N";
		String strMinorityCode="";
		String strDeptCode="";
		String strSNo="1";
		String strHealthCode="";
		String strMaxAlwdAdvnLim="";
		String strPSFreqType="M";
		String strPSFreqWeekDay="";
		String strIntFreqTypeDR="";
		String strIntFreqStartDDDR="31";
		String strIntFreqHldyStatDR="N";
		String strNextIntRunDateDR="";
		String strForAcID="";
		String strStaffId="",strStaffNumber="";
		String strEMIamount="";
		String activityCode="";
		String alliedactivityCode="";
		double dblModIntRate=0.00, dblBaseRate=0.00, dblFloatingRate=0.00, dblRecmdAmount=0.00,dblFinalRate=0.0;
		int intNoOfFlow=0, intRepayPeriod=0, intHolidayPeriod=0, intLoanPeriod=0, intNextIntDMDDate=0;
		int intPeriod=0, intLRPeriod=0;;
		NumberFormat nf = NumberFormat.getInstance();
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
		nf.setGroupingUsed(false);
		NumberFormat nf1 = NumberFormat.getInstance();
		nf1.setMaximumFractionDigits(0);
		nf1.setMinimumFractionDigits(0);
		nf1.setGroupingUsed(false);
		Date currentDate=new Date();
		String strQuery7="",strResetFreqFlag="";
		String CBSSchemecode="",CBSGLsubheadcode="",strAgriproduct="",strSHGCode="",strGovtSponSch="";
		int tenor_Staff_house=0;
		StringBuffer strDepDetails=new StringBuffer();
		StringBuffer strDepAmt=new StringBuffer();
		String strDSAID="",strGoldRate="",strLoanMargin="",strloan_creditrskval="",strloan_busstatval="",
		strECSBankname="",strECSAccountTYpe="",strECSIFSCCODE="",strECSOperaccnum="",strECSAuthMode="",strenachumrn="",strModeofPayment="",
		strLGHGUSRID="",strLGHGTIME="",STRDELFLAG="N",strFREETXT="";		
		String proc_chrg_amt="",proc_chrg_coll_flg="";
		
		try
		{
			String strmoduleType=Helper.correctNull((String)hshValues.get("moduleType"));
			String strdigiType=Helper.correctNull((String)hshValues.get("strdigiType"));
			String mobilebanking=Helper.correctNull((String)hshValues.get("strmobilebankingtype"));
			String strLoanRepaymentType="";
			String strLoanServised="",strMCLRCode="",strMCLRType="";
			String strCurrentDate=Helper.getCurrentDateTime();
			strAppNo=Helper.correctNull((String)hshValues.get("appno"));
			if(strAppNo.equalsIgnoreCase(""))
			{
				strAppNo=Helper.correctNull((String)hshValues.get("appno1"));
			}
			if(strAppNo.equalsIgnoreCase(""))
			{
				strAppNo=Helper.correctNull((String)hshValues.get("strappno"));
			}
			if(!strAppNo.equalsIgnoreCase(""))
			{
				strQuery=SQLParser.getSqlQuery("sel_AccFlatFileData1^"+strAppNo);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strAppId=Helper.correctNull((String)rs.getString("perapp_id"));
					strCustCBSId=Helper.correctNull((String)rs.getString("perapp_cbsid"));
					strSchemeCode=Helper.correctNull((String)rs.getString("scheme_code"));
					String strModIntRate=Helper.correctNull((String)rs.getString("loan_modintrate"));
					strRepPrdMths=Helper.correctNull((String)rs.getString("loan_reqterms"));
					strLoanRepaymentType=Helper.correctNull((String)rs.getString("loan_repaymenttype"));
					strLoanServised=Helper.correctNull((String)rs.getString("LOAN_SERVISED"));
					strHolidayPeriod=Helper.correctInt((String)rs.getString("loan_noofinstallment"));
					intLoanPeriod=Integer.parseInt(Helper.correctInt((String)strRepPrdMths));
					strLimExpDate=Helper.addMonthWithDate(currentDate, intLoanPeriod);
					intHolidayPeriod=Integer.parseInt(Helper.correctInt(strHolidayPeriod));
					intRepayPeriod=Integer.parseInt(Helper.correctInt(strRepPrdMths))-Integer.parseInt(Helper.correctInt(strHolidayPeriod));
					strExcludeHoliday=Integer.toString(intRepayPeriod);
					strSanctLim=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("loan_recmdamt"))));
					strECSIFSCCODE=Helper.correctNull((String)rs.getString("LOAN_ECSIFSCCODE"));
					strECSOperaccnum=Helper.correctNull((String)rs.getString("LOAN_ECSOPERACCNUM"));
					strModeofPayment=Helper.correctNull((String)rs.getString("LOAN_MODEOFPAY"));
					
					
					strECSAccountTYpe=Helper.correctNull((String)rs.getString("LOAN_ECSACCOUNTTYPE"));
					if(!strECSAccountTYpe.equalsIgnoreCase(""))
					{
						if(strECSAccountTYpe.equalsIgnoreCase("1"))
						{
							strECSAccountTYpe="SB";
						}else if(strECSAccountTYpe.equalsIgnoreCase("2"))
						{
							strECSAccountTYpe="CA";
						}else if(strECSAccountTYpe.equalsIgnoreCase("3")){
							strECSAccountTYpe="OD";

						}
					}
					strECSBankname=Helper.correctDouble((String)rs.getString("LOAN_ECSBANKNAME"));
					if(!strECSAccountTYpe.equalsIgnoreCase(""))
					{
						strQuery = SQLParser.getSqlQuery("sel_enach_bankname^"+strECSBankname);
						rs1 = DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							strECSBankname=Helper.correctNull((String)rs1.getString("stat_data_desc1"));	
						}
					}
					
					strECSAuthMode=Helper.correctNull((String)rs.getString("LOAN_ECSATHUNMODE"));
					if(!strECSAuthMode.equalsIgnoreCase(""))
					{
						if(strECSAuthMode.equalsIgnoreCase("1"))
						{
							strECSAuthMode="IB";
						}else if(strECSAuthMode.equalsIgnoreCase("2"))
						{
							strECSAuthMode="Debit Card";
						}
					}
					
					
					
					if(Helper.correctNull((String)rs.getString("APP_LOANSUBTYPE_DIGI")).equals("PR") && 
							(Helper.correctNull((String)rs.getString("prd_type")).equals("pH") 
									|| Helper.correctNull((String)rs.getString("prd_type")).equals("pA")
										|| Helper.correctNull((String)rs.getString("prd_type")).equals("pB")) )
					{
						if(strSchemeCode.equalsIgnoreCase("TGDY"))
						{
							if(intLoanPeriod>35)
							{
								strSchemeCode="TGDY";
							}
							else
							{
								strSchemeCode="DGDY";
							}
						}
						else if(strSchemeCode.equalsIgnoreCase("TGDQ"))
						{
							if(intLoanPeriod>35)
							{
								strSchemeCode="TGDQ";
							}
							else
							{
								strSchemeCode="DGDQ";
							}
						}
						else{
							if(intLoanPeriod>35)
							{
								strSchemeCode="TGAQ";
							}
							else
							{
								strSchemeCode="DGAQ";
							}
						}
					}
					dblModIntRate=Double.parseDouble(Helper.correctDouble(strModIntRate));
					dblFinalRate=dblModIntRate;
					strIntType=Helper.correctNull((String)rs.getString("loan_inttype"));
					strPrdCode=Helper.correctNull((String)rs.getString("prd_code"));
					strEMIamount=Helper.correctNull((String)rs.getString("loan_emi"));
					dblBaseRate=Double.parseDouble(Helper.correctDouble(rs.getString("loan_baserate")));
					strLimSanctDate=Helper.correctNull((String)rs.getString("app_processdate"));
					//strLimSanctDate="03/05/2023";
					strMCLRCode=Helper.correctNull(rs.getString("loan_mclrtabcode"));
					strMCLRType=Helper.correctNull(rs.getString("loan_mclrtype"));
					strGovtSponSch=Helper.correctNull(rs.getString("govt_scheme"));
					if(strGovtSponSch.equalsIgnoreCase("0"))
						strGovtSponSch=null;
						
					
					if(rs1!=null)
					{
						rs1.close();
					}
					strQuery1=SQLParser.getSqlQuery("sel_sancdate_diff_Intcode^"+strLimSanctDate);
					rs1=DBUtils.executeQuery(strQuery1);
					if(rs1.next())
					{
						intDateDiff=Integer.parseInt(Helper.correctInt((String)rs1.getString("datediff")));
						
						if(intDateDiff>=0)
							strDateDiff="Y";
						else
							strDateDiff="N";
					}
					
					if(rs1!=null)
					{
						rs1.close();
					}
					strQuery1=SQLParser.getSqlQuery("sel_staffprd^"+strPrdCode);
					rs1=DBUtils.executeQuery(strQuery1);
					if(rs1.next())
					{
						strStaffId=Helper.correctNull((String)rs1.getString("prd_staffprd"));
						tenor_Staff_house=Integer.parseInt(Helper.correctInt((String)rs1.getString("PRD_STAFF_MAXTERM_PRIN")));
					}
					if(rs1!=null)
					{
						rs1.close();
					}
					strPrdType=Helper.correctNull((String)rs.getString("prd_type"));
					if(strStaffId.equalsIgnoreCase("Y") && !strPrdType.equalsIgnoreCase("pR"))
					{
						double dbl=0.00;
						strQuery1=SQLParser.getSqlQuery("sel_tablecode^"+strPrdCode);
						rs1=DBUtils.executeQuery(strQuery1);
						if(rs1.next())
						{
							strIntTBLCode=Helper.correctNull((String)rs1.getString("prd_tablecode"));
							strIDDRPrefPerc=nf.format(dbl);
							strIDDRPrefPerc=strIDDRPrefPerc.trim();
							
							/*if(strDateDiff.equalsIgnoreCase("Y"))
							{
								strIntTBLCode = "A"+strIntTBLCode.substring(1, strIntTBLCode.length());
							}
							else
							{
								strIntTBLCode = "L"+strIntTBLCode.substring(1, strIntTBLCode.length());
							}*/
						}
					}
					else
					{
						if(!strModIntRate.equalsIgnoreCase(""))
						{
							if(strIntType.equalsIgnoreCase("fixed"))
							{
								double dblFlooredModIntRate=Math.floor(dblModIntRate);
								double dblRemaining=dblModIntRate-dblFlooredModIntRate;
								String strFlooredModIntRate=nf1.format(dblFlooredModIntRate);
								if(strFlooredModIntRate.length()==1)
								{
									if(strDateDiff.equalsIgnoreCase("Y"))
									{
										
										if((Helper.correctNull((String)rs.getString("prd_type")).equals("pC")  && 
												(Helper.correctNull((String)rs.getString("APP_LOANSUBTYPE_DIGI")).equals("PR") ))){
										strIntTBLCode="D0"+nf1.format(dblFlooredModIntRate)+"00";
										}else{
										strIntTBLCode="A0"+nf1.format(dblFlooredModIntRate)+"00";
										}
									}
									else
									{
										strIntTBLCode="L0"+nf1.format(dblFlooredModIntRate)+"00";
									}
								}
								else
								{
									if(strDateDiff.equalsIgnoreCase("Y"))
									{
										if((Helper.correctNull((String)rs.getString("prd_type")).equals("pC")  && 
												(Helper.correctNull((String)rs.getString("APP_LOANSUBTYPE_DIGI")).equals("PR") ))){
										strIntTBLCode="D"+nf1.format(dblFlooredModIntRate)+"00";
										}else{
										strIntTBLCode="A"+nf1.format(dblFlooredModIntRate)+"00";
										}
									}
									else
									{
										strIntTBLCode="L"+nf1.format(dblFlooredModIntRate)+"00";
									}
								}
								strIDDRPrefPerc=nf.format(dblRemaining);
							}
							else if(strIntType.equalsIgnoreCase("floating"))
							{
								/*strIntType="floating";
								if(rs1!=null)
								{
									rs1.close();
								}
								strQuery1=SQLParser.getSqlQuery("sel_AccFlatFileData3^"+strRepPrdMths+"^"+strSanctLim+"^"+strIntType+"^"+strPrdCode);
								rs1=DBUtils.executeQuery(strQuery1);
								if(rs1.next())
								{*/
//								if(strDateDiff.equalsIgnoreCase("Y"))
//								{
//									strIntTBLCode="ABASE";
//								}
//								else
//								{
//									strIntTBLCode="LBASE";
//								}
//									//dblBaseRate=Double.parseDouble(Helper.correctDouble((String)rs1.getString("int_intvalue")));
//									dblFloatingRate=dblModIntRate-dblBaseRate;
//									strIDDRPrefPerc=nf.format(dblFloatingRate);
								//}
									
								
								if(rs1!=null)
								{
									rs1.close();
								}
								strQuery=SQLParser.getSqlQuery("sanctiondate_mclr^"+strAppNo);
								rs1=DBUtils.executeQuery(strQuery);
								if(rs1.next())
								{
									if(Integer.parseInt(Helper.correctInt(rs1.getString("datediff")))<0)
									{
										if(strDateDiff.equalsIgnoreCase("Y"))
										{
											strIntTBLCode="ABASE";
										}
										else
										{
											strIntTBLCode="LBASE";
										}
											dblFloatingRate=dblModIntRate-dblBaseRate;
											strIDDRPrefPerc=nf.format(dblFloatingRate);
										
									}
									else
									{
										
										// MCLR Changes
										//strIntTBLCode="AMC"+strMCLRCode;
										strIntTBLCode=strMCLRCode;
										dblFloatingRate=dblModIntRate-dblBaseRate;
										strIDDRPrefPerc=nf.format(dblFloatingRate);
										//strIDDRPrefPerc=nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("loan_creditrskval")))+Double.parseDouble(Helper.correctDouble(rs.getString("loan_busstatval"))));
										
										
										if(!strMCLRType.equalsIgnoreCase(""))
					 					{
					 						String[] strArr=strMCLRType.split("@");
					 						if(strArr.length>1)
					 						{
					 							if(strArr[0].equalsIgnoreCase("O")||strArr[0].equalsIgnoreCase("M")||strArr[0].equalsIgnoreCase("Q")||strArr[0].equalsIgnoreCase("H")||strArr[0].equalsIgnoreCase("Y"))
					 							strResetFreqFlag=strArr[0];
					 							if(rs2!=null)
					 								rs2.close();
					 							rs2=DBUtils.executeLAPSQuery("sel_mclrspreadrate^"+Helper.getCurrentDateTime()+"^"+strArr[0]);
					 							if(rs2.next())
					 							{
					 								dblFinalRate=Double.parseDouble(Helper.correctDouble(rs2.getString("mclr_baseratespread")))+Double.parseDouble(Helper.correctDouble(rs.getString("loan_creditrskval")))+Double.parseDouble(Helper.correctDouble(rs.getString("loan_busstatval")));
					 							}
					 						}
					 					}
										
									}
								}
							}
						}
					}
					dblRecmdAmount=Double.parseDouble(Helper.correctDouble(strSanctLim));
					if(Helper.correctNull((String)rs.getString("loan_modeofpay")).equalsIgnoreCase("E"))
					{
						strOpAcId=Helper.correctNull((String)rs.getString("loan_operativeaccno"));
					}
					if(strPrdType.equalsIgnoreCase("pR"))
					{
						if(rs2!=null)
							rs2.close();
						strQuery2=SQLParser.getSqlQuery("sel_AccFlatFileData4^"+strAppNo);
						rs2=DBUtils.executeQuery(strQuery2);
						if(rs2.next())
						{
							strIDMDEffDate=Helper.correctNull((String)rs2.getString("loan_matdate"));
							strRepPrdDays=(String)Long.toString(Helper.dateDiff(strLimExpDate, strIDMDEffDate));
							strLimExpDate=strIDMDEffDate;
							
							if(Integer.parseInt(Helper.correctInt(strRepPrdDays))<0)
							{
								
								if(rs1!=null)
									rs1.close();
								rs1=DBUtils.executeLAPSQuery("getdaysofbirth^"+strLimExpDate);
	 							if(rs1.next())
	 							{
	 								strRepPrdMths=Helper.correctInt(rs1.getString("dates"));
									Date currDate=new Date();
									strRepPrdDays=(String)Long.toString(Helper.dateDiff(Helper.addMonthWithDate(currDate,(Integer.parseInt(strRepPrdMths))), strLimExpDate));
	 							}
							}
						}
					}
					else if(strHolidayPeriod.equalsIgnoreCase("0"))
					{
						strIDMDEffDate="";
					}
					else
					{
						strIDMDEffDate=Helper.addMonthWithDate(currentDate,intHolidayPeriod);
					}
					/*
					 * The month comes after the holiday period will be considered as flow start date
					 */
					if(strPrdType.equalsIgnoreCase("pE"))
					{
						strIntOnIDMDFlag="N";
					}
					strLRFreqType=Helper.correctNull((String)rs.getString("loan_periodicity"));
					if(strLRFreqType.equalsIgnoreCase("m"))
					{
						intPeriod=1;
					}
					else if(strLRFreqType.equalsIgnoreCase("q"))
					{
						intPeriod=3;
					}
					else if(strLRFreqType.equalsIgnoreCase("h"))
					{
						intPeriod=6;
					}
					else if(strLRFreqType.equalsIgnoreCase("y"))
					{
						intPeriod=12;
					}
					else if(strLRFreqType.equalsIgnoreCase("n"))
					{
						if(strPrdType.equalsIgnoreCase("pR")||strPrdType.equalsIgnoreCase("pG"))
						{
							if(strSchemeCode.equalsIgnoreCase("JGQCK"))// By default for the scheme JGQCK it is Half Yearly, For others it is Yearly
							{
								strLRFreqType="h";
								intPeriod=6;
							}
							else
							{
								strLRFreqType="y";
								intPeriod=12;
							}
						}
					}
					if(intPeriod!=0)
					{
						intNoOfFlow=intRepayPeriod/intPeriod;
					}
					if(strPrdType.equalsIgnoreCase("pR")||strPrdType.equalsIgnoreCase("pG"))//For DL and GL No of Flows by default it is 1
					{
						intNoOfFlow=1;
					}
					int intflowstartperiod=1;
					if(strLRFreqType.equalsIgnoreCase("m") && strLoanRepaymentType.equalsIgnoreCase("1"))
					{
						intflowstartperiod=intflowstartperiod+intHolidayPeriod;
						strFlowStartDate=Helper.addMonthWithDate(currentDate, intflowstartperiod); 
					}
					else{
						if(rs3!=null)
						{rs3.close();}
						strQuery3=SQLParser.getSqlQuery("selloan_account_details^"+strAppNo+"^"+"1");
						rs3=DBUtils.executeQuery(strQuery3);
						if(rs3.next())
						{
							strFlowStartDate=Helper.correctNull((String)rs3.getString("flow_start_date"));
						}
					}
					if(strPrdType.equalsIgnoreCase("pR"))//For DL by default Maturity Date
					{
						strFlowStartDate=strIDMDEffDate;
					}
					else if(strPrdType.equalsIgnoreCase("pG")) // For GL by default Current Date + Loan Period
					{
						strFlowStartDate=Helper.addMonthWithDate(currentDate,intLoanPeriod);
					}
					//else
					//{
						//strFlowStartDate=Helper.addMonthWithDate(currentDate, intHolidayPeriod+1); //Based on DC Initial Requirement 
					//}
					
					if(strPrdType.equalsIgnoreCase("pR")||strPrdType.equalsIgnoreCase("pG"))
					{
						strLimExpDate=strFlowStartDate; //Both
					}
					if(!strFlowStartDate.equalsIgnoreCase(""))
					strLRFreqStartDD=strFlowStartDate.substring(0,2);
					strNumOfFlows=Integer.toString(intNoOfFlow);
					if(Helper.correctNull((String)rs.getString("loan_repaymenttype")).equalsIgnoreCase("1"))
					{
						strFlowAmt=Helper.correctNull((String)rs.getString("loan_emi"));
						
						double dblEMI=0.0,dblAmt=dblRecmdAmount;
	    				 double dblRate=dblFinalRate/(12*100);
	    				 double dblDenomi=0.0,dblNumeri=0.0,dblInterestAmt=0.0;
	    				 if((intHolidayPeriod>0) && Helper.correctNull(rs.getString("LOAN_INTERESTCHARGED")).equalsIgnoreCase("2") && Helper.correctNull((rs.getString("LOAN_SERVISED"))).equalsIgnoreCase("n"))
	    				 {
	    					 
	    					 if(Helper.correctNull(rs.getString("loan_intcalcmode")).equalsIgnoreCase("C"))
	    					 {
	    							dblAmt=dblAmt*Math.pow((1+dblRate),intHolidayPeriod);
	    					 }
	    					 else if(Helper.correctNull(rs.getString("loan_intcalcmode")).equalsIgnoreCase("S"))
	    					 {
	    						 dblAmt+=(dblAmt*intHolidayPeriod*dblFinalRate)/1200;
	    					 }
	    					 
	    				 }
	    				 dblDenomi=Math.pow(dblRate+1,(intRepayPeriod))-1;	
	    				 dblNumeri=dblRate*Math.pow(dblRate+1,(intRepayPeriod));
	    				 if(dblNumeri!=0.0 && dblDenomi!=0.0)
	    				 {
	    					 dblEMI=Math.ceil((dblNumeri/dblDenomi)*dblAmt);
	    					 strFlowAmt=nf.format(dblEMI);
	    					 strEMIamount=strFlowAmt;
	    				 }
						
					
					}
					else if(strPrdType.equalsIgnoreCase("pG")||strPrdType.equalsIgnoreCase("pR"))
					{
						strFlowAmt=strSanctLim;
					}
					else
					{
						if(intNoOfFlow>0)
						{
							double dblTemp=dblRecmdAmount/intNoOfFlow;
							strFlowAmt=nf.format(dblTemp);
						}
					}
					
					strLoanPaperDate=Helper.correctNull((String)rs.getString("ac_opening_date"));
					//strLoanPaperDate="03/05/2023";
					strSanctLevlCode=Helper.correctNull((String)rs.getString("appraisal_sanclevel"));
					strSanctAuthCode=Helper.correctNull((String)rs.getString("appraisal_sancauth"));
					if(rs3!=null)
					{
						rs3.close();
					}
					strQuery3=SQLParser.getSqlQuery("sel_misappclassification^"+strAppNo+"^"+"1");
					rs3=DBUtils.executeQuery(strQuery3);
					if(rs3.next())
					{
						strSectorCode=Helper.correctNull((String)rs3.getString("app_sector"));
						strSubSectorCode=Helper.correctNull((String)rs3.getString("app_subsector"));
						strSensitiveSectorCode=Helper.correctNull((String)rs3.getString("app_sensitivesector"));
					}
					if(rs3!=null)
					{
						rs3.close();
					}
					if((!strSchemeCode.equalsIgnoreCase(""))&&(!strSubSectorCode.equalsIgnoreCase("")))
					{
						strQuery3=SQLParser.getSqlQuery("sel_AccFlatFileData2^"+strSchemeCode+"^"+strSubSectorCode+"@^@"+strSubSectorCode+"@");
						rs3=DBUtils.executeQuery(strQuery3);
						if(rs3.next())
						{
							strGLSubHeadCode=Helper.correctNull((String)rs3.getString("sch_datadescription"));
						}
					}
					strQuery4=SQLParser.getSqlQuery("sel_cbsdetails^"+strAppNo+"^1");
					rs4=DBUtils.executeQuery(strQuery4);
					if(rs4.next())
					{
						strFreeCode6=Helper.correctNull((String)rs4.getString("FREECODE6"));
						strFreeCode7=Helper.correctNull((String)rs4.getString("FREECODE7FINCODE"));
						strFreeCode8=Helper.correctNull((String)rs4.getString("FREECODE8FINCODE"));
						strModeOfOperCode=Helper.correctNull((String)rs4.getString("MODE_OF_OPERATION"));
						strDrwngPowerInd=Helper.correctNull((String)rs4.getString("DRAWING_PWR_IND"));
						strDrwngPower=Helper.correctNull((String)rs4.getString("DRAWING_PWR"));
						strSolID=Helper.correctNull((String)rs4.getString("LOANDISBBRANCH"));
						strAdvanceNature=Helper.correctNull((String)rs4.getString("NATUREOFADV"));
						strAdvanceType=Helper.correctNull((String)rs4.getString("TYPEOFADV"));
						strAdvanceMode=Helper.correctNull((String)rs4.getString("MODEOFADV"));
						strAdvancePurpose=Helper.correctNull((String)rs4.getString("PURPOSEOFADV"));
						strFreeCode3=Helper.correctNull((String)rs4.getString("FREECODE3"));
						//strSecurityCode=Helper.correctNull((String)rs4.getString("SECURITYCODE"));
						strIntFreqTypeDR=Helper.correctNull((String)rs4.getString("INTRATEFREQ"));
						CBSSchemecode=Helper.correctNull((String)rs4.getString("facility_schemecode"));
						CBSGLsubheadcode=Helper.correctNull((String)rs4.getString("facility_glsubheadcode"));
						//strLBRCode=Helper.correctNull((String)rs4.getString("LBRCODE"));
						strDescOfSecurity=Helper.correctNull((String)rs4.getString("CER_GISTOFSECURITUES"));
					}
					strBorrowerCatCode=Helper.correctNull((String)rs.getString("perapp_constitution"));
					strRenewFlg=Helper.correctNull((String)rs.getString("app_renew_flag"));
					
					if(strRenewFlg.equalsIgnoreCase("R") && !(strPrdType.equalsIgnoreCase("pR")||strPrdType.equalsIgnoreCase("pG")))
						strLimExpDate=Helper.correctNull((String)rs.getString("loan_duedate"));
					strBankScheme=Helper.correctNull((String)rs.getString("prd_bankscheme"));
					strDeptCode=Helper.correctNull((String)rs.getString("appraisal_department"));
					strFile=Helper.correctNull((String)rs.getString("loan_fileno"));
					if(!CBSSchemecode.equalsIgnoreCase(""))
					{
						strSchemeCode=CBSSchemecode;
					}
					if(!CBSGLsubheadcode.equalsIgnoreCase(""))
					{
						strGLSubHeadCode=CBSGLsubheadcode;
					}
					strAgriproduct=Helper.correctNull(rs.getString("prd_whetheragri"));
					
					if(Integer.parseInt(Helper.correctInt(rs.getString("perapp_constitution")))>=183 && Integer.parseInt(Helper.correctInt(rs.getString("perapp_constitution")))<=191)
						strSHGCode="002";
					else
						strSHGCode="001";
					if(strPrdType.equalsIgnoreCase("pG"))
					{
						strLoanMargin=Helper.correctNull(rs.getString("loan_margin"));
					}
					
					if(!mobilebanking.equalsIgnoreCase("Y"))
					{
					if(strmoduleType.equals("manualCBS") || strmoduleType.equals("RETDIGI"))
					{
						strloan_creditrskval=Helper.correctDouble(rs.getString("loan_creditrskval"));
						strloan_busstatval=Helper.correctDouble(rs.getString("loan_busstatval"));
						if(strIntType.equalsIgnoreCase("fixed"))
						{
						double strspreadrate=Double.parseDouble(Helper.correctDouble(strloan_creditrskval))+ Double.parseDouble(Helper.correctDouble(strloan_busstatval));
						strIDDRPrefPerc=String.valueOf(nf.format(strspreadrate));
						}
					}
					}
					
				}
				if(rs!=null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("sel_FinacleSancRefNo^"+strAppNo);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strSanctRefNum=Helper.correctNull((String)rs.getString("finaclesancrefno"));
				}
				
				if(rs!=null)
				{
					rs.close();
				}
				if(strPrdType.equalsIgnoreCase("pG"))
				{
				strQuery=SQLParser.getSqlQuery("getgoldloanprocesschrg^"+strAppNo);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					int chrgs=0;
					//String proc_chrg_amt="",proc_chrg_coll_flg="";
					proc_chrg_amt= Helper.correctNull((String)rs.getString("LOAN_PROFEE"));
					if(!proc_chrg_amt.equalsIgnoreCase(""))
					{
						
						chrgs=	Integer.parseInt(proc_chrg_amt);
						
					if( chrgs<= 0 )
					{
						proc_chrg_amt="0";
						proc_chrg_coll_flg="N";
					}
					else
					{
						proc_chrg_coll_flg="Y";
					}
					}
					else
					{
						proc_chrg_amt="0";
						proc_chrg_coll_flg="N";
					}
					
				}
				}
				
				if(rs!=null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("sel_misappdetails^"+strAppNo+"^"+"1");
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strGuarCoverCode=Helper.correctNull((String)rs.getString("app_guarantee"));
					strBSROccuCode=Helper.correctNull((String)rs.getString("app_bsrcode"));
					strServiceAreaCode=Helper.correctNull((String)rs.getString("app_whetherservice"));
					activityCode = Helper.correctNull((String)rs.getString("app_activitycode"));
					alliedactivityCode=Helper.correctNull((String)rs.getString("APP_ALLIED_ACTIVITYCODE"));
					if(strServiceAreaCode.equalsIgnoreCase("Y"))
					{
						strServiceAreaCode="001";
					}else{
						strServiceAreaCode="002";
					}
					strLBRCode=Helper.correctNull((String)rs.getString("app_bsr1code"));
				}
				if(rs!=null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("sel_misappdisplayscreen^"+strAppNo+"^"+"1");
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					//strLandHoldCode=Helper.correctNull((String)rs.getString("app_totland"));
					strLandHoldCode=Helper.correctNull((String)rs.getString("app_farmercategory"));
				}
				if(rs!=null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("sel_CustomerDetails^"+strAppId);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strAcctOccpCode=Helper.correctNull((String)rs.getString("kyc_occupationcode"));
					strSCSTCode=Helper.correctNull((String)rs.getString("indinfo_caste"));
					strMinorityCode=Helper.correctNull((String)rs.getString("indinfo_religion"));
					strStaffNumber=Helper.correctNull((String)rs.getString("indinfo_staff_id"));
				}
				/*if(strLRIntFreqType.equalsIgnoreCase("m"))
				{
					intLRPeriod=1;
				}
				else if(strLRIntFreqType.equalsIgnoreCase("q"))
				{
					intLRPeriod=3;
				}
				else if(strLRIntFreqType.equalsIgnoreCase("h"))
				{
					intLRPeriod=6;
				}
				else if(strLRIntFreqType.equalsIgnoreCase("y"))
				{
					intLRPeriod=12;
				}
				else if(strLRIntFreqType.equalsIgnoreCase("n"))
				{
					if(strPrdType.equalsIgnoreCase("pR")||strPrdType.equalsIgnoreCase("pG"))
					{
						intLRPeriod=12;
						strLRIntFreqType="y";
					}
				}
				if(intLRPeriod!=0)
				{
					intNextIntDMDDate=intRepayPeriod/intLRPeriod;
				}
				strNextIntDmdDate=Helper.addMonthWithDate(currentDate, intLRPeriod+1);*/
				
				if(strIntFreqTypeDR.equalsIgnoreCase("m"))//Prakash
				{
					intPeriod=1;
				}
				else if(strIntFreqTypeDR.equalsIgnoreCase("q"))
				{
					intPeriod=3;
				}
				else if(strIntFreqTypeDR.equalsIgnoreCase("h"))
				{
					intPeriod=6;
				}
				else if(strIntFreqTypeDR.equalsIgnoreCase("y"))
				{
					intPeriod=12;
				}
				else if(strIntFreqTypeDR.equalsIgnoreCase("n"))
				{
					if(strPrdType.equalsIgnoreCase("pR")||strPrdType.equalsIgnoreCase("pG"))
					{
						intPeriod=12;
						strIntFreqTypeDR="y";
					}
				}
				strLRIntFreqType=strIntFreqTypeDR;//Both are Same
				
				if(strPrdType.equalsIgnoreCase("pR")||strPrdType.equalsIgnoreCase("pG"))
				{
					strNextIntDmdDate=Helper.addMonthWithDate(currentDate, intPeriod);
				}
				
				strNextIntDmdDate=Helper.addMonthWithDate(currentDate, intPeriod-1);
				
				if(!(strIntFreqTypeDR.equalsIgnoreCase("m")&& strLoanRepaymentType.equalsIgnoreCase("1")))
				{
					strQuery3=SQLParser.getSqlQuery("sel_enddateofmonth^"+strNextIntDmdDate);
					rs3=DBUtils.executeQuery(strQuery3);
					if(rs3.next())
					{
						strNextIntDmdDate=Helper.correctNull((String)rs3.getString("mon_enddate"));
					}
				}
				if(strIntFreqTypeDR.equalsIgnoreCase("m")&& strLoanRepaymentType.equalsIgnoreCase("1"))
				{
					strNextIntDmdDate=Helper.addMonthWithDate(currentDate, intPeriod);
				}
				if(strIntFreqTypeDR.equalsIgnoreCase("y") && !strFreeCode6.equalsIgnoreCase(""))
				{
					strNextIntDmdDate=Helper.getNextIntDmdDate(strCurrentDate, strIntFreqTypeDR, strFreeCode6);
				}
				//if Interest Frequency Quarterly means
				if(strIntFreqTypeDR.equalsIgnoreCase("q"))
				{
					strNextIntDmdDate=Helper.getNextIntDmdDate(strCurrentDate, strIntFreqTypeDR, strFreeCode6);	
				}
//				if(! strNextIntDmdDate.equalsIgnoreCase(""))
//				{
//					strIntFreqStartDDDR=strNextIntDmdDate.substring(0,2);
//				}
				if(!strPrdType.equalsIgnoreCase("pR"))
				{
					if(strIntFreqTypeDR.equalsIgnoreCase("m")&& !strLoanRepaymentType.equalsIgnoreCase("1"))
					{
						strQuery3=SQLParser.getSqlQuery("sel_enddateofmonth^"+strCurrentDate);
						//close rs3
						rs3=DBUtils.executeQuery(strQuery3);
						if(rs3.next())
						{
							strIDMDEffDate=Helper.correctNull((String)rs3.getString("mon_enddate"));
						}
					}
					if(intHolidayPeriod==0)
					{
						strIDMDEffDate="";
					}
				}
				
				//Added by Guhan for Taking Next Int dmd date as Anniversary date
				if(strSchemeCode.equalsIgnoreCase("GGDQ") || strSchemeCode.equalsIgnoreCase("TGDYA") || strSchemeCode.equalsIgnoreCase("DGDYA")
						|| strSchemeCode.equalsIgnoreCase("TGDKA") || ((strPrdType.equalsIgnoreCase("pG") && strAgriproduct.equalsIgnoreCase("Y"))
								&& !(strSchemeCode.equalsIgnoreCase("JGAQK")||strSchemeCode.equalsIgnoreCase("JGGQK"))))
					strNextIntDmdDate=Helper.addMonthWithDate(currentDate, 12);
				
				/*if(!strIntFreqTypeDR.equalsIgnoreCase("y"))
				{
					if(rs4 !=null)
					{
						rs4.close();
					}
					strQuery4=SQLParser.getSqlQuery("sel_enddate^"+strNextIntDmdDate);
					rs4=DBUtils.executeQuery(strQuery4);
					//rs4=DBUtils.executeLAPSQuery("sel_enddate^"+strNextIntDmdDate);
					if(rs4.next())
					{
						strNextIntDmdDate=Helper.correctNull((String)rs4.getString("end_date"));
					}
				}*/
				//strNextIntRunDateDR=Helper.addMonthWithDate(currentDate, intPeriod+1);
				strNextIntRunDateDR=strNextIntDmdDate;
				//Description of the security to be passed to Finacle other than gold loan
				if(!strPrdType.equalsIgnoreCase("pG"))
				{
					if(rs!=null)
					{
						rs.close();
					}
					/*strQuery=SQLParser.getSqlQuery("sel_sec_desc^"+strAppNo);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strDescOfSecurity=Helper.correctNull((String)rs.getString("sec_description"));
					}*/
				}
				String strMulti_schedule_num="",strSchedule_details="";
				String strFLOW_ID="PRDEM",strNUM_OF_FLOWS="",strFLOW_START_DATE="",strLR_FREQ_TYPE="",strLR_FREQ_START_DD="",strFLOW_AMT="";
				String strNEXT_INT_DMD_DATE="",strLR_INT_FREQ_START_DD="";
				String strColumnDelimitor="^",strRowDelimitor="~";
				//Other than EMI Account Opening
				if(strLoanRepaymentType.equalsIgnoreCase("1"))
				{
					//EMI
					strFLOW_ID="EIDEM";
					strMulti_schedule_num="1";
					hshQuery.put("strQueryId","del_tl_repayschedule");
					arrValues=new ArrayList();
					arrValues.add(strAppNo);
					arrValues.add("1");
					arrValues.add("1");	
					hshQuery.put("arrValues",arrValues);					
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData"); 
					
					hshQuery.put("strQueryId","ins_tl_repayschedule");
					arrValues=new ArrayList();
					arrValues.add(strAppNo);
					arrValues.add("1");
					arrValues.add("1");	
					arrValues.add("M");
					arrValues.add(strExcludeHoliday);
					arrValues.add(strEMIamount);
					double Totalamount=Double.parseDouble(strExcludeHoliday)*Double.parseDouble(strEMIamount);
					arrValues.add(jtn.format(Totalamount));
					arrValues.add("P");
					hshQuery.put("arrValues",arrValues);					
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				else
				{
					//Other than EMI
					
					//Otherthan EI
					if(rs!=null)
					{
						rs.close();
					}
					strQuery=SQLParser.getSqlQuery("sel_multi_schedule_num^"+strAppNo+"^"+"1");
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strMulti_schedule_num=Helper.correctNull((String)rs.getString("multi_schedule_num"));
					}
					if(rs!=null)
					{
						rs.close();
					}
					
				}
					if(Integer.parseInt(Helper.correctInt(strMulti_schedule_num))>0)
					{
						strQuery=SQLParser.getSqlQuery("selflowstart_date^"+strAppNo+"^"+"1");
						rs=DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							strFLOW_START_DATE=Helper.correctNull((String)rs.getString("flow_start_date"));
							strLR_FREQ_START_DD=Helper.correctNull((String)rs.getString("lr_freq_start_dd"));
						}
						strNEXT_INT_DMD_DATE=strNextIntDmdDate;
						strFLOW_START_DATE=strFlowStartDate;
						if(rs!=null)
						{
							rs.close();
						}
						strQuery=SQLParser.getSqlQuery("sel_tl_repayschedule_loanaccount^"+strAppNo+"^"+"1");
						rs=DBUtils.executeQuery(strQuery);
						if(Integer.parseInt(Helper.correctInt(strMulti_schedule_num))==1)
						{
							int intperiodnum=0;
							if(rs.next())
							{
								strNUM_OF_FLOWS=Helper.correctNull((String)rs.getString("num_of_flows"));
								strLR_FREQ_TYPE=Helper.correctNull((String)rs.getString("lr_freq_type"));
								strFLOW_AMT=Helper.correctNull((String)rs.getString("flow_amt"));
								
								
								//strNEXT_INT_DMD_DATE=Helper.getIntDmdDate(strCurrentDate,strIntFreqTypeDR);
								if(!(strIntFreqTypeDR.equalsIgnoreCase("y") || strIntFreqTypeDR.equalsIgnoreCase("h")))
								{
									strNEXT_INT_DMD_DATE=Helper.getMQHDate(strIntFreqTypeDR);
								}
								strNEXT_INT_DMD_DATE=strNextIntDmdDate;
								strFLOW_START_DATE=strFlowStartDate;
								if(!strNEXT_INT_DMD_DATE.equalsIgnoreCase(""))
								{
									strNEXT_INT_DMD_DATE=strNEXT_INT_DMD_DATE.replace("/", "-");
									strLR_INT_FREQ_START_DD=strNEXT_INT_DMD_DATE.substring(0,2);
								}
								else
								{
									strNEXT_INT_DMD_DATE="";strLR_INT_FREQ_START_DD="";
								}
								if(!strFLOW_START_DATE.equalsIgnoreCase(""))
								{
									//"select_month_enddate"
									strFLOW_START_DATE=strFLOW_START_DATE.replace("/", "-");
									strLR_FREQ_START_DD=strFLOW_START_DATE.substring(0,2);
									/*String strMonthEndDate="";
									String strMonthend=SQLParser.getSqlQuery("select_month_enddate^"+strFLOW_START_DATE+"^"+strFLOW_START_DATE);
									ResultSet rsmonthend=DBUtils.executeQuery(strMonthend);
									if(rsmonthend.next())
									{
										strMonthEndDate=Helper.correctNull((String)rsmonthend.getString("next_int_dmd_date"));
									}
									if(strMonthEndDate.equalsIgnoreCase(strFLOW_START_DATE))
									{
										strLR_FREQ_START_DD="31";
									}else{
										strLR_FREQ_START_DD=strFLOW_START_DATE.substring(0,2);
									}*/
								}
								/*if(!strNEXT_INT_DMD_DATE.equalsIgnoreCase(""))
								{
									//"select_month_enddate"
									String strMonthEndDate="";
									String strMonthend=SQLParser.getSqlQuery("select_month_enddate^"+strNEXT_INT_DMD_DATE+"^"+strNEXT_INT_DMD_DATE);
									ResultSet rsmonthend=DBUtils.executeQuery(strMonthend);
									if(rsmonthend.next())
									{
										strMonthEndDate=Helper.correctNull((String)rsmonthend.getString("next_int_dmd_date"));
									}
									if(strMonthEndDate.equalsIgnoreCase(strNEXT_INT_DMD_DATE))
									{
										strLR_INT_FREQ_START_DD="31";
									}
								}*/
								if(!strLoanRepaymentType.equalsIgnoreCase("1"))
								{
									if(strSchemeCode.equalsIgnoreCase("GGDQ") || strSchemeCode.equalsIgnoreCase("TGDYA") || strSchemeCode.equalsIgnoreCase("DGDYA")
											|| strSchemeCode.equalsIgnoreCase("TGDKA"))
									{
										//
									}
									else
									{
										strLR_INT_FREQ_START_DD="31";
									}
								}
								strSchedule_details=strFLOW_ID+strColumnDelimitor+strNUM_OF_FLOWS+strColumnDelimitor+strFLOW_START_DATE+
									strColumnDelimitor+strLR_FREQ_TYPE+strColumnDelimitor+strLR_FREQ_START_DD+strColumnDelimitor+strFLOW_AMT+
									strColumnDelimitor+strNEXT_INT_DMD_DATE+strColumnDelimitor+strIntFreqTypeDR+strColumnDelimitor+strLR_INT_FREQ_START_DD;
							}
						}
						else
						{
							int i=0;
							while(rs.next())
							{
								int inttempmonths=0;
								if(i>0)
								{
									if(strLR_FREQ_TYPE.equalsIgnoreCase("m"))
									{
										inttempmonths=Integer.parseInt(Helper.correctInt(strNUM_OF_FLOWS))*1;
									}
									else if(strLR_FREQ_TYPE.equalsIgnoreCase("q"))
									{
										inttempmonths=Integer.parseInt(Helper.correctInt(strNUM_OF_FLOWS))*3;
									}
									else if(strLR_FREQ_TYPE.equalsIgnoreCase("h"))
									{
										inttempmonths=Integer.parseInt(Helper.correctInt(strNUM_OF_FLOWS))*6;
									}
									else if(strLR_FREQ_TYPE.equalsIgnoreCase("y"))
									{
										inttempmonths=Integer.parseInt(Helper.correctInt(strNUM_OF_FLOWS))*12;
									}
									else
									{
										inttempmonths=0;
									}
									strQuery7=SQLParser.getSqlQuery("sel_flowstartdate_loanaccount^"+strFLOW_START_DATE+"^"+inttempmonths+"^"+strFLOW_START_DATE+"^"+inttempmonths);
									rs7=DBUtils.executeQuery(strQuery7);
									if(rs7.next())
									{
										strFLOW_START_DATE=Helper.correctNull((String)rs7.getString("flow_start_date"));
										strLR_FREQ_START_DD=Helper.correctNull((String)rs7.getString("lr_freq_start_dd"));
									}
									if(rs7!=null)
									{
										rs7.close();
									}
									strQuery7=SQLParser.getSqlQuery("sel_flowstartdate_loanaccount^"+strNEXT_INT_DMD_DATE+"^"+inttempmonths+"^"+strNEXT_INT_DMD_DATE+"^"+inttempmonths);
									rs7=DBUtils.executeQuery(strQuery7);
									if(rs7.next())
									{
										strNEXT_INT_DMD_DATE=Helper.correctNull((String)rs7.getString("flow_start_date"));
										strLR_INT_FREQ_START_DD=Helper.correctNull((String)rs7.getString("lr_freq_start_dd"));
									}
									if(rs7!=null)
									{
										rs7.close();
									}
								}
								strNUM_OF_FLOWS=Helper.correctNull((String)rs.getString("num_of_flows"));
								strLR_FREQ_TYPE=Helper.correctNull((String)rs.getString("lr_freq_type"));
								strFLOW_AMT=Helper.correctNull((String)rs.getString("flow_amt"));
								if(i==0)
								{
										
										
									strNEXT_INT_DMD_DATE=Helper.getIntDmdDate(strCurrentDate,strIntFreqTypeDR);
									
										if(!(strIntFreqTypeDR.equalsIgnoreCase("y") || strIntFreqTypeDR.equalsIgnoreCase("h")))
										{
											strNEXT_INT_DMD_DATE=Helper.getMQHDate(strIntFreqTypeDR);
										}
										strNEXT_INT_DMD_DATE=strNextIntDmdDate;
										if(!strNEXT_INT_DMD_DATE.equalsIgnoreCase(""))
										{
											strNEXT_INT_DMD_DATE=strNEXT_INT_DMD_DATE.replace("/", "-");
											strLR_INT_FREQ_START_DD=strNEXT_INT_DMD_DATE.substring(0,2);
										}
										else
										{
											strNEXT_INT_DMD_DATE="";strLR_INT_FREQ_START_DD="";
										}
								}
								
								if(!strFLOW_START_DATE.equalsIgnoreCase(""))
								{
									//"select_month_enddate"
									strFLOW_START_DATE=strFLOW_START_DATE.replace("/", "-");
									/*String strMonthEndDate="";
									String strMonthend=SQLParser.getSqlQuery("select_month_enddate^"+strFLOW_START_DATE+"^"+strFLOW_START_DATE);
									ResultSet rsmonthend=DBUtils.executeQuery(strMonthend);
									if(rsmonthend.next())
									{
										strMonthEndDate=Helper.correctNull((String)rsmonthend.getString("next_int_dmd_date"));
									}
									if(strMonthEndDate.equalsIgnoreCase(strFLOW_START_DATE))
									{
										strLR_FREQ_START_DD="31";
									}*/
								}
								/*if(!strNEXT_INT_DMD_DATE.equalsIgnoreCase(""))
								{
									//"select_month_enddate"
									String strMonthEndDate="";
									String strMonthend=SQLParser.getSqlQuery("select_month_enddate^"+strNEXT_INT_DMD_DATE+"^"+strNEXT_INT_DMD_DATE);
									ResultSet rsmonthend=DBUtils.executeQuery(strMonthend);
									if(rsmonthend.next())
									{
										strMonthEndDate=Helper.correctNull((String)rsmonthend.getString("next_int_dmd_date"));
									}
									if(strMonthEndDate.equalsIgnoreCase(strNEXT_INT_DMD_DATE))
									{
										strLR_INT_FREQ_START_DD="31";
									}
								}*/
								if(!strLoanRepaymentType.equalsIgnoreCase("1"))
								{
									if(strSchemeCode.equalsIgnoreCase("GGDQ") || strSchemeCode.equalsIgnoreCase("TGDYA") || strSchemeCode.equalsIgnoreCase("DGDYA")
											|| strSchemeCode.equalsIgnoreCase("TGDKA"))
									{
										//
									}
									else
									{
										strLR_INT_FREQ_START_DD="31";
									}
								}
								if(strSchedule_details.equalsIgnoreCase(""))
								{
									strSchedule_details=strFLOW_ID+strColumnDelimitor+strNUM_OF_FLOWS+strColumnDelimitor+strFLOW_START_DATE+
									strColumnDelimitor+strLR_FREQ_TYPE+strColumnDelimitor+strLR_FREQ_START_DD+strColumnDelimitor+strFLOW_AMT+
									strColumnDelimitor+strNEXT_INT_DMD_DATE+strColumnDelimitor+strIntFreqTypeDR+strColumnDelimitor+strLR_INT_FREQ_START_DD;
								}
								else
								{
									strSchedule_details=strSchedule_details+strRowDelimitor+strFLOW_ID+strColumnDelimitor+strNUM_OF_FLOWS+strColumnDelimitor+strFLOW_START_DATE+
									strColumnDelimitor+strLR_FREQ_TYPE+strColumnDelimitor+strLR_FREQ_START_DD+strColumnDelimitor+strFLOW_AMT+
									strColumnDelimitor+strNEXT_INT_DMD_DATE+strColumnDelimitor+strIntFreqTypeDR+strColumnDelimitor+strLR_INT_FREQ_START_DD;
								}
								i++;
							}
						}
						
						if(rs!=null)
						{
							rs.close();
						}
					}
				if(strPrdType.equalsIgnoreCase("pR")||(strPrdType.equalsIgnoreCase("pG") && !strLoanRepaymentType.equalsIgnoreCase("14")))
				{
					strMulti_schedule_num="1";
					strNUM_OF_FLOWS=strNumOfFlows;
					String strTempFlowStartDt=strFlowStartDate.replace("/", "-");
					SimpleDateFormat sd=new SimpleDateFormat("dd-mm-yyyy");
					Date dateFlowStartDate=sd.parse(strTempFlowStartDt);
					
					strFlowStartDate=sd.format(dateFlowStartDate);
					
					strFLOW_START_DATE=strFlowStartDate;
					strLR_FREQ_TYPE=strLRFreqType.toUpperCase();
					strLR_FREQ_START_DD=strLRFreqStartDD;
					strFLOW_AMT=strFlowAmt;
					
					String strTempNextIntDmdDate=strNextIntDmdDate.replace("/", "-");
					Date dateNextIntDmdDate=sd.parse(strTempNextIntDmdDate);
					strNextIntDmdDate=sd.format(dateNextIntDmdDate);
					
					strNEXT_INT_DMD_DATE=strNextIntDmdDate;
					strIntFreqTypeDR=strIntFreqTypeDR;
					strLR_INT_FREQ_START_DD=strIntFreqStartDDDR;
					if(!strLoanRepaymentType.equalsIgnoreCase("1"))
					{
						if(strSchemeCode.equalsIgnoreCase("GGDQ") || strSchemeCode.equalsIgnoreCase("TGDYA") || strSchemeCode.equalsIgnoreCase("DGDYA")
								|| strSchemeCode.equalsIgnoreCase("TGDKA"))
						{
							//
						}
						else
						{
							strLR_INT_FREQ_START_DD="31";
						}
					}
					strSchedule_details=strFLOW_ID+strColumnDelimitor+strNUM_OF_FLOWS+strColumnDelimitor+strFLOW_START_DATE+
					strColumnDelimitor+strLR_FREQ_TYPE+strColumnDelimitor+strLR_FREQ_START_DD+strColumnDelimitor+strFLOW_AMT+
					strColumnDelimitor+strNEXT_INT_DMD_DATE+strColumnDelimitor+strIntFreqTypeDR+strColumnDelimitor+strLR_INT_FREQ_START_DD;
				}
				if((strPrdType.equalsIgnoreCase("pH")||strPrdType.equalsIgnoreCase("pA")) && strStaffId.equalsIgnoreCase("Y"))
				{
					int repaymentperiod_house=tenor_Staff_house;
					intNoOfFlow=repaymentperiod_house-intHolidayPeriod;
					strNumOfFlows=Integer.toString(intNoOfFlow);
				}
				String strSecid="";
				strQuery7=SQLParser.getSqlQuery("sel_securityid^"+strAppNo+"^1");
				rs8=DBUtils.executeQuery(strQuery7);
				if(rs8.next())
				{
					strSecid=Helper.correctNull((String)rs8.getString("APP_SEC_SECID"));
				}
				if(rs8!=null)
				{rs8.close();}
				strQuery7=SQLParser.getSqlQuery("sel_securitycbscode^"+Helper.correctInt((String)strSecid));
				rs8=DBUtils.executeQuery(strQuery7);
				if(rs8.next())
				{
					strSecurityCode=Helper.correctNull((String)rs8.getString("sec_cbssecurity"));
				}
				if(rs8!=null)
				{rs8.close();}
				
				int intTotRepayperiod=0,intFacRepayperiod=0;
				if(strStaffId.equalsIgnoreCase("Y"))
				{
					strFile=strStaffNumber;
					
					if(!(strPrdType.equalsIgnoreCase("pH") || strPrdType.equalsIgnoreCase("pA") || strPrdType.equalsIgnoreCase("pR")))
					{
						strIDMDEffDate="";
					}
					else
					{
						if(rs7!=null)
						{
							rs7.close();
						}
						rs7=DBUtils.executeLAPSQuery("sel_tl_repayschedule^"+strAppNo+"^1");
						while(rs7.next())
						{
							if(Helper.correctNull(rs7.getString(3)).equalsIgnoreCase("M")){
								intFacRepayperiod=Integer.parseInt(Helper.correctInt(rs7.getString(4)));
							}else if(Helper.correctNull(rs7.getString(3)).equalsIgnoreCase("Q")){
								intFacRepayperiod=Integer.parseInt(Helper.correctInt(rs7.getString(4)))*3;
							}
							else if(Helper.correctNull(rs7.getString(3)).equalsIgnoreCase("H")){
								intFacRepayperiod=Integer.parseInt(Helper.correctInt(rs7.getString(4)))*6;
							}
							else if(Helper.correctNull(rs7.getString(3)).equalsIgnoreCase("Y")){
								intFacRepayperiod=Integer.parseInt(Helper.correctInt(rs7.getString(4)))*12;
							}
							intTotRepayperiod=intTotRepayperiod+intFacRepayperiod;
						}
						if(!strPrdType.equalsIgnoreCase("pR"))
						strIDMDEffDate=Helper.addMonthWithDate(currentDate,intTotRepayperiod+1);
					}
				}
				else
				{
					strFile="PF"+strFile;
				}
				

				
				strFlowAmt=nf.format(Math.round(Double.parseDouble(Helper.correctDouble(strFlowAmt))));
				
				//Added by Guhan for Relationship type addition
				if(rs!=null)rs.close();
				String strRelationType ="";
				strQuery = SQLParser.getSqlQuery("sel_relation_type_ret^"+strAppNo);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					if(strRelationType.equalsIgnoreCase(""))
					{
						strRelationType = Helper.correctNull((String)rs.getString("relation_type"));
					}
					else
					{
						strRelationType = strRelationType+"~"+Helper.correctNull((String)rs.getString("relation_type"));
					}
				}
				//End
				
				
				//DSA - BSA ID taken from appinwardreg table
				if(rs!=null)rs.close();
				strQuery = SQLParser.getSqlQuery("sel_inward_proposed_values^"+strAppNo);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strDSAID=Helper.correctNull(rs.getString("inward_agentid"));
				}
				
				//Deposit Details
				if(strPrdType.equalsIgnoreCase("pR"))
				{
					if(rs!=null)rs.close();
					strQuery = SQLParser.getSqlQuery("sel_loanagainstdeposit^"+strAppNo);
					rs = DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						if((strDepDetails.toString()).equalsIgnoreCase(""))
						{
							strDepDetails=strDepDetails.append(Helper.correctNull(rs.getString("loan_accno")));
							strDepAmt=strDepAmt.append(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("loan_presentos")))));
						}
						else
						{
							strDepDetails=strDepDetails.append("|").append(Helper.correctNull(rs.getString("loan_accno")));
							strDepAmt=strDepAmt.append("|").append(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("loan_presentos")))));
						}
					}
				}
				
				
				if(strPrdType.equalsIgnoreCase("pG"))
				{
					if(rs!=null)
					rs.close();
					strQuery = SQLParser.getSqlQuery("sel_goldwight^" + strAppNo);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strGoldRate=Helper.formatDoubleValue(rs.getDouble("netval"));
					}
				}
				
				//For Making Interest Dmd date as NULL in case if the interest is servised during Holiday period
				if(strLoanServised.equalsIgnoreCase("y") && !strPrdType.equalsIgnoreCase("pR"))
				{
					strIDMDEffDate = "";
				}
				
				
				
				String strStageWiseRelease="";
				if(rs!=null)
				rs.close();
				strQuery = SQLParser.getSqlQuery("sel_allcomments1^" + strAppNo+"^repaycomment^1");
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strStageWiseRelease=Helper.correctNull(rs.getString("FIN_STAGEWISE_RELEASE"));
				}
				if(rs!=null)
					rs.close();
				
					strQuery = SQLParser.getSqlQuery("sel_retmclrresetfreq^"+ strAppNo);
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) {
						strMCLRCode = Helper.correctNull((String) rs.getString("loan_mclrtabcode"));
						if (strMCLRCode.equalsIgnoreCase("AGSEC")|| strMCLRCode.equalsIgnoreCase("NGSEC")	|| strMCLRCode.equalsIgnoreCase("ATBIL")|| strMCLRCode.equalsIgnoreCase("NTBIL")) {
							strResetFreqFlag = "Q";
						}else{
							strResetFreqFlag=strResetFreqFlag;
						}
					}
					
				if(strmoduleType.equals("RETDIGI"))
				{
					OracleDataSource dataSource = new OracleDataSource();
					dataSource.setUser(Helper.correctNull(ApplicationParams.getStrFinacleURL()).split(",")[1]);
					dataSource.setPassword(Helper.correctNull(ApplicationParams.getStrFinacleURL()).split(",")[2]);
					dataSource.setURL(Helper.correctNull(ApplicationParams.getStrFinacleURL()).split(",")[0]);
					Connection con = dataSource.getConnection();
					PreparedStatement ps=null;

					ps=con.prepareStatement("insert into laps(laps_application_num, cust_id, schm_code, gl_sub_head_code," +
							"mode_of_oper_code, ps_reqd_flg, int_tbl_code, id_dr_pref_pcnt, sanct_lim, rep_perd_mths," +
							"rep_perd_days, op_acid, idmd_eff_date, int_on_idmd_flg, num_of_flows, lr_freq_type, flow_start_date," +
							"flow_amt, lr_int_freq_type, next_int_dmd_date, lim_sanct_date, lim_exp_date, loan_paper_date," +
							"sanct_levl_code, sanct_auth_code, sanct_ref_num, desc_of_security, drwng_power_ind, limit_b2kid," +
							"drwng_power_pcnt, drwng_power, free_code_6, free_code_7, free_code_8, max_alwd_advn_lim, ps_freq_type," +
							"ps_freq_week_day, ps_freq_start_dd, ps_freq_hldy_stat, ps_despatch_mode, int_freq_type_dr," +
							"int_freq_start_dd_dr, int_freq_hldy_stat_dr, next_int_run_date_dr, foracid, sol_id, local_cal_flg," +
							"sector_code, sub_sector_code, acct_occp_code, borrower_category_code, purpose_of_advn, mode_of_advn," +
							"type_of_advn, nature_of_advn, guar_cover_code, bsr_occu_code, lbr_code, service_area_code," +
							"land_holding_code, schematic_code, scst_code, minority_code, sensitive_sector_code, security_code," +
							"dept_code, free_code_3, lr_freq_start_dd, lr_int_freq_hldy_stat, health_code, renew_flg," +
							"processed_flg, facility_sno, rcre_time,multi_schedule_num,schedule_details,party_file_no," +
							"REL_PARTY_DETAILS,reset_freq,shg_code,govt_scheme,dsaid,dep_acct,dep_amt,ACTIVITY_CODE,GOLD_MARGIN_PERCENT,GOLD_COLL_VAL,ALLIED_ACTIVITY_CODE,PROC_CHRG_AMT,PROC_CHRG_COLL_FLG) values " +
							"(?,?,?,?,?,?,?,?,?,?,?,?,to_date(?,'dd/mm/yyyy'),?,?,?,to_date(?,'dd/mm/yyyy'),?,?,to_date(?,'dd/mm/yyyy')," +
							"to_date(?,'dd/mm/yyyy'),to_date(?,'dd/mm/yyyy'),to_date(?,'dd/mm/yyyy'),?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?" +
							",?,?,?,to_date(?,'dd/mm/yyyy'),?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,sysdate,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					
					ps.setString(1,strAppNo);//1
					ps.setString(2,strCustCBSId);//2
					ps.setString(3,strSchemeCode);//3
					ps.setString(4,strGLSubHeadCode);//4
					ps.setString(5,strModeOfOperCode);//5
					ps.setString(6,strPBPSCode);//6
					ps.setString(7,strIntTBLCode);//7
					ps.setString(8,strIDDRPrefPerc);//8   ///SHIVA
					ps.setString(9,strSanctLim);//9
					ps.setString(10,strRepPrdMths);//10
					ps.setString(11,strRepPrdDays);//11
					ps.setString(12,strOpAcId);//12 for Operative account nmbr
					ps.setString(13,strIDMDEffDate);//13
					ps.setString(14,strIntOnIDMDFlag);//14
					ps.setString(15,strNumOfFlows);//15
					ps.setString(16,strLRFreqType.toUpperCase());//16
					ps.setString(17,strFlowStartDate);//17
					ps.setString(18,strFlowAmt);//18
					ps.setString(19,strLRIntFreqType);//19
					ps.setString(20,strNextIntDmdDate);//20
					ps.setString(21,strLimSanctDate);//21
					ps.setString(22,strLimExpDate);//22
					ps.setString(23,strLoanPaperDate);//23
					ps.setString(24,strSanctLevlCode);//24
					ps.setString(25,strSanctAuthCode);//25
					ps.setString(26,strSanctRefNum);//26
					ps.setString(27,strDescOfSecurity);//27
					ps.setString(28,strDrwngPowerInd);//28
					ps.setString(29,strLimitB2kid);//29
					ps.setString(30,strDrwngPowerPcnt);//30
					ps.setString(31,strDrwngPower);//31
					ps.setString(32,strFreeCode6);//32
					ps.setString(33,strFreeCode7);//33
					ps.setString(34,strFreeCode8);//34
					ps.setString(35,strMaxAlwdAdvnLim);//35
					ps.setString(36,strPSFreqType);//36
					ps.setString(37,strPSFreqWeekDay);//37
					ps.setString(38,strFreqStartDD);//38
					ps.setString(39,strFreqHldyStat);//39
					ps.setString(40,strPSDespatchMode);//40
					ps.setString(41,strIntFreqTypeDR);//41
					ps.setString(42,strIntFreqStartDDDR);//42
					ps.setString(43,strIntFreqHldyStatDR);//43
					ps.setString(44,strNextIntRunDateDR);//44
					ps.setString(45,strForAcID);//45
					ps.setString(46,strSolID);//46
					ps.setString(47,strLocalCallFlg);//47
					ps.setString(48,strSectorCode);//48
					ps.setString(49,strSubSectorCode);//49
					ps.setString(50,strAcctOccpCode);//50
					ps.setString(51,strBorrowerCatCode);//51
					ps.setString(52,strAdvancePurpose);//52
					ps.setString(53,strAdvanceMode);//53
					ps.setString(54,strAdvanceType);//54
					ps.setString(55,strAdvanceNature);//55
					ps.setString(56,strGuarCoverCode);//56
					ps.setString(57,strBSROccuCode);//57
					ps.setString(58,strLBRCode);//58
					ps.setString(59,strServiceAreaCode);//59
					ps.setString(60,strLandHoldCode);//60
					ps.setString(61,strBankScheme);//61
					ps.setString(62,strSCSTCode);//62
					ps.setString(63,strMinorityCode);//63
					ps.setString(64,strSensitiveSectorCode);//64
					ps.setString(65,strSecurityCode);//65
					ps.setString(66,strDeptCode);//66
					ps.setString(67,strFreeCode3);//67
					ps.setString(68,strLRFreqStartDD);//68
					ps.setString(69,strLrIntFreqHldyStat);//69
					ps.setString(70,strHealthCode);//70
					ps.setString(71,strRenewFlg);//71
					ps.setString(72,strProcessedFlg);//72
					ps.setString(73,strSNo);//73
					ps.setString(74,strMulti_schedule_num);//74
					ps.setString(75,strSchedule_details);//75
					ps.setString(76,strFile);
					ps.setString(77,strRelationType);
					ps.setString(78,strResetFreqFlag);
					ps.setString(79,strSHGCode);
					ps.setString(80,strGovtSponSch);
					ps.setString(81,strDSAID);
					ps.setString(82,strDepDetails.toString());
					ps.setString(83,strDepAmt.toString());
					ps.setString(84,activityCode);
					ps.setString(85,strLoanMargin);
					ps.setString(86,strGoldRate);
					ps.setString(87,alliedactivityCode);
					ps.setString(88,proc_chrg_amt);
					ps.setString(89,proc_chrg_coll_flg);
					
					ps.executeUpdate();
					
					log.info("insert into laps@kbl table completed. proposal number ===="+strAppNo);
					System.out.println("insert into laps@kbl table completed. proposal number ===="+strAppNo);
		
					if (ps != null)
					{
						ps.close();
					}
					if (con != null)
					{
						con.close();
					}
					
					//insert E-NACH
					if(!strModeofPayment.equalsIgnoreCase("") && ! strECSAuthMode.equalsIgnoreCase("")){
						if(strModeofPayment.equalsIgnoreCase("C") && !strECSAuthMode.equalsIgnoreCase("3")){
							
						dataSource = new OracleDataSource();
						dataSource.setUser(Helper.correctNull(ApplicationParams.getStrFinacleURL()).split(",")[1]);
						dataSource.setPassword(Helper.correctNull(ApplicationParams.getStrFinacleURL()).split(",")[2]);
						dataSource.setURL(Helper.correctNull(ApplicationParams.getStrFinacleURL()).split(",")[0]);
						con = dataSource.getConnection();
	
							
						ps=con.prepareStatement("insert into LAPS_ENACH(laps_application_num, BANK_NAME, ACCOUNT_TYPE, IFSC_CODE," +
								"OPER_ACCT_NUMBER, AUTHENTICATION_MODE, UMRN, RCRE_USER_ID, RCRE_TIME, LCHG_USER_ID," +
								"LCHG_TIME, DEL_FLG, FREE_TEXT1)	values " +
								"(?,?,?,?,?,?,?,?,to_date(?,'dd/mm/yyyy'),?,?,?,?)");
						
						ps.setString(1,strAppNo);//1
						ps.setString(2,strECSBankname);//2
						ps.setString(3,strECSAccountTYpe);//3
						ps.setString(4,strECSIFSCCODE);//4
						ps.setString(5,strECSOperaccnum);//5
						ps.setString(6,strECSAuthMode);//6
						ps.setString(7,strenachumrn);//7
						ps.setString(8,Helper.correctNull((String)hshValues.get("strUserId")));//8
						ps.setString(9,strCurrentDate);//9
						ps.setString(10,Helper.correctNull((String)hshValues.get("strUserId")));//10
						ps.setString(11,strCurrentDate);//11
						ps.setString(12,STRDELFLAG);//12
						ps.setString(13,strFREETXT);//13
						
						ps.executeUpdate();
						
						log.info("insert into E-NACH table completed. proposal number ===="+strAppNo);
						System.out.println("insert into E-NACH table completed. proposal number ===="+strAppNo);
			
						if (ps != null)
						{
							ps.close();
						}
						if (con != null)
						{
							con.close();
							
						}
					 }
					}
					//insertAccountHandOffDetails
					
				con = null;
					dataSource = new OracleDataSource();
					dataSource.setUser(Helper.correctNull(ApplicationParams.getStrORACLEDBURL()).split(",")[1]);
					dataSource.setPassword(Helper.correctNull(ApplicationParams.getStrORACLEDBURL()).split(",")[2]);
					dataSource.setURL(Helper.correctNull(ApplicationParams.getStrORACLEDBURL()).split(",")[0]);
					con = dataSource.getConnection();
					

				ps=con.prepareStatement("insert into laps_aif(laps_appno, laps_custcbsid, laps_schemecode, laps_glsubheadcode," +
						" laps_modeofopercode, laps_pbpscode,laps_inttblcode, laps_iddrprefperc,	laps_sanctlim, laps_repprdmths, " +
						"laps_repprddays, laps_opacid, laps_idmdeffdate,laps_intonidmdflag, laps_numofflows, laps_lrfreqtype, " +
						"laps_flowstartdate, laps_flowamt, laps_lrintfreqtype, laps_nextintdmddate,laps_limsanctdate, laps_limexpdate," +
						" laps_loanpaperdate, laps_sanctlevlcode, laps_sanctauthcode, laps_sanctrefnum, laps_descofsecurity,laps_drwngpowerind, " +
						"laps_limitb2kid, laps_drwngpowerpcnt, laps_drwngpower, laps_freecode6, laps_freecode7, laps_freecode8,laps_maxalwdadvnlim," +
						" laps_psfreqtype, laps_psfreqweekday, laps_freqstartdd, laps_freqhldystat, laps_psdespatchmode,laps_intfreqtypedr, " +
						"laps_intfreqstartdddr, laps_intfreqhldystatdr, laps_nextintrundatedr, laps_foracid, laps_sol_id,laps_local_cal_flg, " +
						"laps_sector_code, laps_sub_sector_code, laps_acct_occp_code, laps_borrower_category_code, laps_purpose_of_advn," +
						"laps_mode_of_advn, laps_type_of_advn, laps_nature_of_advn, laps_guar_cover_code, laps_bsr_occu_code, laps_lbr_code," +
						"laps_service_area_code, laps_land_holding_code, laps_schematic_code, laps_scst_code, laps_minority_code,laps_sensitive_sector_code," +
						"laps_security_code, laps_dept_code, laps_free_code_3, laps_lr_freq_start_dd, laps_lr_int_freq_hldy_stat," +
						"laps_health_code, laps_rcre_time, laps_renew_flg, laps_processed_flg, laps_sno, laps_handoff_time, laps_handoff_flag," +
						"laps_user_id, laps_app_file_name,MULTI_SCHEDULE_NUM,SCHEDULE_DETAILS,LAPS_RELATIONTYPE,reset_freq,shg_code,govt_scheme," +
						"dep_acct,dep_amt,dsaid,ACTIVITY_CODE,GOLD_MARGIN_PERCENT,GOLD_COLL_VAL,ALLIED_ACTIVITY_CODE,PROC_CHRG_AMT,PROC_CHRG_COLL_FLG) values(?,?,?,?,?,?,?,?,?,?,?,?,to_date(?,'dd/mm/yyyy'),?,?,?,to_date(?,'dd/mm/yyyy'),?,?," +
						"to_date(?,'dd/mm/yyyy'),to_date(?,'dd/mm/yyyy'),to_date(?,'dd/mm/yyyy'),to_date(?,'dd/mm/yyyy'),?,?,?,?,?,?,?,?,?,?,?," +
						"?,?,?,?,?,?,?,?,?,to_date(?,'dd/mm/yyyy'),?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,sysdate,?,?,?,sysdate,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				
				ps.setString(1,strAppNo);//1
				ps.setString(2,strCustCBSId);//2
				ps.setString(3,strSchemeCode);//3
				ps.setString(4,strGLSubHeadCode);//4
				ps.setString(5,strModeOfOperCode);//5
				ps.setString(6,strPBPSCode);//6
				ps.setString(7,strIntTBLCode);//7
				ps.setString(8,strIDDRPrefPerc);//8
				ps.setString(9,strSanctLim);//9
				ps.setString(10,strRepPrdMths);//10
				ps.setString(11,strRepPrdDays);//11
				ps.setString(12,strOpAcId);//12 for Operative account nmbr
				ps.setString(13,strIDMDEffDate);//13
				ps.setString(14,strIntOnIDMDFlag);//14
				ps.setString(15,strNumOfFlows);//15
				ps.setString(16,strLRFreqType.toUpperCase());//16
				ps.setString(17,strFlowStartDate);//17
				ps.setString(18,strFlowAmt);//18
				ps.setString(19,strLRIntFreqType);//19
				ps.setString(20,strNextIntDmdDate);//20
				ps.setString(21,strLimSanctDate);//21
				ps.setString(22,strLimExpDate);//22
				ps.setString(23,strLoanPaperDate);//23
				ps.setString(24,strSanctLevlCode);//24
				ps.setString(25,strSanctAuthCode);//25
				ps.setString(26,strSanctRefNum);//26
				ps.setString(27,strDescOfSecurity);//27
				ps.setString(28,strDrwngPowerInd);//28
				ps.setString(29,strLimitB2kid);//29
				ps.setString(30,strDrwngPowerPcnt);//30
				ps.setString(31,strDrwngPower);//31
				ps.setString(32,strFreeCode6);//32
				ps.setString(33,strFreeCode7);//33
				ps.setString(34,strFreeCode8);//34
				ps.setString(35,strMaxAlwdAdvnLim);//35
				ps.setString(36,strPSFreqType);//36
				ps.setString(37,strPSFreqWeekDay);//37
				ps.setString(38,strFreqStartDD);//38
				ps.setString(39,strFreqHldyStat);//39
				ps.setString(40,strPSDespatchMode);//40
				ps.setString(41,strIntFreqTypeDR);//41
				ps.setString(42,strIntFreqStartDDDR);//42
				ps.setString(43,strIntFreqHldyStatDR);//43
				ps.setString(44,strNextIntRunDateDR);//44
				ps.setString(45,strForAcID);//45
				ps.setString(46,strSolID);//46
				ps.setString(47,strLocalCallFlg);//47
				ps.setString(48,strSectorCode);//48
				ps.setString(49,strSubSectorCode);//49
				ps.setString(50,strAcctOccpCode);//50
				ps.setString(51,strBorrowerCatCode);//51
				ps.setString(52,strAdvancePurpose);//52
				ps.setString(53,strAdvanceMode);//53
				ps.setString(54,strAdvanceType);//54
				ps.setString(55,strAdvanceNature);//55
				ps.setString(56,strGuarCoverCode);//56
				ps.setString(57,strBSROccuCode);//57
				ps.setString(58,strLBRCode);//58
				ps.setString(59,strServiceAreaCode);//59
				ps.setString(60,strLandHoldCode);//60
				ps.setString(61,strBankScheme);//61
				ps.setString(62,strSCSTCode);//62
				ps.setString(63,strMinorityCode);//63
				ps.setString(64,strSensitiveSectorCode);//64
				ps.setString(65,strSecurityCode);//65
				ps.setString(66,strDeptCode);//66
				ps.setString(67,strFreeCode3);//67
				ps.setString(68,strLRFreqStartDD);//68
				ps.setString(69,strLrIntFreqHldyStat);//69
				ps.setString(70,strHealthCode);//70
				ps.setString(71,strRenewFlg);//71
				ps.setString(72,strProcessedFlg);//72
				ps.setString(73,strSNo);//73
				ps.setString(74,"Y");//74
				ps.setString(75,Helper.correctNull((String)hshValues.get("strUserId")));//75
				ps.setString(76,strFile);//76
				ps.setString(77,strMulti_schedule_num);//77
				ps.setString(78,strSchedule_details);//78
				ps.setString(79,strRelationType);//79
				ps.setString(80,strResetFreqFlag);//80
				ps.setString(81,strSHGCode);//81
				ps.setString(82,strGovtSponSch);//82
				ps.setString(83,strDepDetails.toString());//83
				ps.setString(84,strDepAmt.toString());//84
				ps.setString(85,strDSAID);//85
				ps.setString(86,activityCode);//86
				ps.setString(87,strLoanMargin);//87
				ps.setString(88,strGoldRate);//88
				ps.setString(89,alliedactivityCode);//89
				ps.setString(90,proc_chrg_amt);//90
				ps.setString(91,proc_chrg_coll_flg);//91
				ps.executeUpdate();
				log.info("insert into laps_aif table completed. proposal number ===="+strAppNo);
				System.out.println("insert into laps_aif table completed. proposal number ===="+strAppNo);
				if (ps != null)
				{
					ps.close();
				}
				
				if (con != null)
				{
					con.close();
				}
				
				hshQuery=new HashMap();
				hshQuery.put("strQueryId", "update_loanduedate");
				arrValues = new ArrayList();
				arrValues.add(strLimExpDate);
				arrValues.add(strEMIamount);
				arrValues.add(nf.format(dblFinalRate));
				arrValues.add(strAppNo);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
				else if(strmoduleType.equals("RETDIGI")&&(strPrdType.equalsIgnoreCase("pR")||strPrdType.equalsIgnoreCase("pG")) && (strdigiType.equalsIgnoreCase("")))
				{
					OracleDataSource dataSource = new OracleDataSource();
					dataSource.setUser(Helper.correctNull(ApplicationParams.getStrFinacleURL()).split(",")[1]);
					dataSource.setPassword(Helper.correctNull(ApplicationParams.getStrFinacleURL()).split(",")[2]);
					dataSource.setURL(Helper.correctNull(ApplicationParams.getStrFinacleURL()).split(",")[0]);
					Connection con = dataSource.getConnection();
					PreparedStatement ps=null;

					ps=con.prepareStatement("insert into laps(laps_application_num, cust_id, schm_code, gl_sub_head_code," +
							"mode_of_oper_code, ps_reqd_flg, int_tbl_code, id_dr_pref_pcnt, sanct_lim, rep_perd_mths," +
							"rep_perd_days, op_acid, idmd_eff_date, int_on_idmd_flg, num_of_flows, lr_freq_type, flow_start_date," +
							"flow_amt, lr_int_freq_type, next_int_dmd_date, lim_sanct_date, lim_exp_date, loan_paper_date," +
							"sanct_levl_code, sanct_auth_code, sanct_ref_num, desc_of_security, drwng_power_ind, limit_b2kid," +
							"drwng_power_pcnt, drwng_power, free_code_6, free_code_7, free_code_8, max_alwd_advn_lim, ps_freq_type," +
							"ps_freq_week_day, ps_freq_start_dd, ps_freq_hldy_stat, ps_despatch_mode, int_freq_type_dr," +
							"int_freq_start_dd_dr, int_freq_hldy_stat_dr, next_int_run_date_dr, foracid, sol_id, local_cal_flg," +
							"sector_code, sub_sector_code, acct_occp_code, borrower_category_code, purpose_of_advn, mode_of_advn," +
							"type_of_advn, nature_of_advn, guar_cover_code, bsr_occu_code, lbr_code, service_area_code," +
							"land_holding_code, schematic_code, scst_code, minority_code, sensitive_sector_code, security_code," +
							"dept_code, free_code_3, lr_freq_start_dd, lr_int_freq_hldy_stat, health_code, renew_flg," +
							"processed_flg, facility_sno, rcre_time,multi_schedule_num,schedule_details,party_file_no," +
							"REL_PARTY_DETAILS,reset_freq,shg_code,govt_scheme,dsaid,dep_acct,dep_amt,ACTIVITY_CODE,ALLIED_ACTIVITY_CODE,PROC_CHRG_AMT,PROC_CHRG_COLL_FLG)	values " +
							"(?,?,?,?,?,?,?,?,?,?,?,?,to_date(?,'dd/mm/yyyy'),?,?,?,to_date(?,'dd/mm/yyyy'),?,?,to_date(?,'dd/mm/yyyy')," +
							"to_date(?,'dd/mm/yyyy'),to_date(?,'dd/mm/yyyy'),to_date(?,'dd/mm/yyyy'),?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?" +
							",?,?,?,to_date(?,'dd/mm/yyyy'),?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,sysdate,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					
					ps.setString(1,strAppNo);//1
					ps.setString(2,strCustCBSId);//2
					ps.setString(3,strSchemeCode);//3
					ps.setString(4,strGLSubHeadCode);//4
					ps.setString(5,strModeOfOperCode);//5
					ps.setString(6,strPBPSCode);//6
					ps.setString(7,strIntTBLCode);//7
					ps.setString(8,strIDDRPrefPerc);//8
					ps.setString(9,strSanctLim);//9
					ps.setString(10,strRepPrdMths);//10
					ps.setString(11,strRepPrdDays);//11
					ps.setString(12,strOpAcId);//12 for Operative account nmbr
					ps.setString(13,strIDMDEffDate);//13
					ps.setString(14,strIntOnIDMDFlag);//14
					ps.setString(15,strNumOfFlows);//15
					ps.setString(16,strLRFreqType.toUpperCase());//16
					ps.setString(17,strFlowStartDate);//17
					ps.setString(18,strFlowAmt);//18
					ps.setString(19,strLRIntFreqType);//19
					ps.setString(20,strNextIntDmdDate);//20
					ps.setString(21,strLimSanctDate);//21
					ps.setString(22,strLimExpDate);//22
					ps.setString(23,strLoanPaperDate);//23
					ps.setString(24,strSanctLevlCode);//24
					ps.setString(25,strSanctAuthCode);//25
					ps.setString(26,strSanctRefNum);//26
					ps.setString(27,strDescOfSecurity);//27
					ps.setString(28,strDrwngPowerInd);//28
					ps.setString(29,strLimitB2kid);//29
					ps.setString(30,strDrwngPowerPcnt);//30
					ps.setString(31,strDrwngPower);//31
					ps.setString(32,strFreeCode6);//32
					ps.setString(33,strFreeCode7);//33
					ps.setString(34,strFreeCode8);//34
					ps.setString(35,strMaxAlwdAdvnLim);//35
					ps.setString(36,strPSFreqType);//36
					ps.setString(37,strPSFreqWeekDay);//37
					ps.setString(38,strFreqStartDD);//38
					ps.setString(39,strFreqHldyStat);//39
					ps.setString(40,strPSDespatchMode);//40
					ps.setString(41,strIntFreqTypeDR);//41
					ps.setString(42,strIntFreqStartDDDR);//42
					ps.setString(43,strIntFreqHldyStatDR);//43
					ps.setString(44,strNextIntRunDateDR);//44
					ps.setString(45,strForAcID);//45
					ps.setString(46,strSolID);//46
					ps.setString(47,strLocalCallFlg);//47
					ps.setString(48,strSectorCode);//48
					ps.setString(49,strSubSectorCode);//49
					ps.setString(50,strAcctOccpCode);//50
					ps.setString(51,strBorrowerCatCode);//51
					ps.setString(52,strAdvancePurpose);//52
					ps.setString(53,strAdvanceMode);//53
					ps.setString(54,strAdvanceType);//54
					ps.setString(55,strAdvanceNature);//55
					ps.setString(56,strGuarCoverCode);//56
					ps.setString(57,strBSROccuCode);//57
					ps.setString(58,strLBRCode);//58
					ps.setString(59,strServiceAreaCode);//59
					ps.setString(60,strLandHoldCode);//60
					ps.setString(61,strBankScheme);//61
					ps.setString(62,strSCSTCode);//62
					ps.setString(63,strMinorityCode);//63
					ps.setString(64,strSensitiveSectorCode);//64
					ps.setString(65,strSecurityCode);//65
					ps.setString(66,strDeptCode);//66
					ps.setString(67,strFreeCode3);//67
					ps.setString(68,strLRFreqStartDD);//68
					ps.setString(69,strLrIntFreqHldyStat);//69
					ps.setString(70,strHealthCode);//70
					ps.setString(71,strRenewFlg);//71
					ps.setString(72,strProcessedFlg);//72
					ps.setString(73,strSNo);//73
					ps.setString(74,strMulti_schedule_num);//74
					ps.setString(75,strSchedule_details);//75
					ps.setString(76,strFile);
					ps.setString(77,strRelationType);
					ps.setString(78,strResetFreqFlag);
					ps.setString(79,strSHGCode);
					ps.setString(80,strGovtSponSch);
					ps.setString(81,strDSAID);
					ps.setString(82,strDepDetails.toString());
					ps.setString(83,strDepAmt.toString());
					ps.setString(84,activityCode);
					ps.setString(85,alliedactivityCode);
					ps.setString(86,proc_chrg_amt);
					ps.setString(87,proc_chrg_coll_flg);
					ps.executeUpdate();
					
					log.info("insert into laps@kbl table completed. proposal number ===="+strAppNo);
					System.out.println("insert into laps@kbl table completed. proposal number ===="+strAppNo);
		
					if (ps != null)
					{
						ps.close();
					}
					if (con != null)
					{
						con.close();
					}
					
					//insert E-NACH
					if(!strModeofPayment.equalsIgnoreCase("") && ! strECSAuthMode.equalsIgnoreCase("")){
						if(strModeofPayment.equalsIgnoreCase("C") && !strECSAuthMode.equalsIgnoreCase("3")){
							
						dataSource = new OracleDataSource();
						dataSource.setUser(Helper.correctNull(ApplicationParams.getStrFinacleURL()).split(",")[1]);
						dataSource.setPassword(Helper.correctNull(ApplicationParams.getStrFinacleURL()).split(",")[2]);
						dataSource.setURL(Helper.correctNull(ApplicationParams.getStrFinacleURL()).split(",")[0]);
						con = dataSource.getConnection();
	
							
						ps=con.prepareStatement("insert into LAPS_ENACH(laps_application_num, BANK_NAME, ACCOUNT_TYPE, IFSC_CODE," +
								"OPER_ACCT_NUMBER, AUTHENTICATION_MODE, UMRN, RCRE_USER_ID, RCRE_TIME, LCHG_USER_ID," +
								"LCHG_TIME, DEL_FLG, FREE_TEXT1)	values " +
								"(?,?,?,?,?,?,?,?,to_date(?,'dd/mm/yyyy'),?,?,?,?)");
						
						ps.setString(1,strAppNo);//1
						ps.setString(2,strECSBankname);//2
						ps.setString(3,strECSAccountTYpe);//3
						ps.setString(4,strECSIFSCCODE);//4
						ps.setString(5,strECSOperaccnum);//5
						ps.setString(6,strECSAuthMode);//6
						ps.setString(7,strenachumrn);//7
						ps.setString(8,Helper.correctNull((String)hshValues.get("strUserId")));//8
						ps.setString(9,strCurrentDate);//9
						ps.setString(10,Helper.correctNull((String)hshValues.get("strUserId")));//10
						ps.setString(11,strCurrentDate);//11
						ps.setString(12,STRDELFLAG);//12
						ps.setString(13,strFREETXT);//13
						
						ps.executeUpdate();
						
						log.info("insert into E-NACH table completed. proposal number ===="+strAppNo);
						System.out.println("insert into E-NACH table completed. proposal number ===="+strAppNo);
			
						if (ps != null)
						{
							ps.close();
						}
						if (con != null)
						{
							con.close();
							
						}
					 }
					}
					//insertAccountHandOffDetails
					
				con = null;
					dataSource = new OracleDataSource();
					dataSource.setUser(Helper.correctNull(ApplicationParams.getStrORACLEDBURL()).split(",")[1]);
					dataSource.setPassword(Helper.correctNull(ApplicationParams.getStrORACLEDBURL()).split(",")[2]);
					dataSource.setURL(Helper.correctNull(ApplicationParams.getStrORACLEDBURL()).split(",")[0]);
					con = dataSource.getConnection();
					

				ps=con.prepareStatement("insert into laps_aif(laps_appno, laps_custcbsid, laps_schemecode, laps_glsubheadcode," +
						" laps_modeofopercode, laps_pbpscode,laps_inttblcode, laps_iddrprefperc,	laps_sanctlim, laps_repprdmths, " +
						"laps_repprddays, laps_opacid, laps_idmdeffdate,laps_intonidmdflag, laps_numofflows, laps_lrfreqtype, " +
						"laps_flowstartdate, laps_flowamt, laps_lrintfreqtype, laps_nextintdmddate,laps_limsanctdate, laps_limexpdate," +
						" laps_loanpaperdate, laps_sanctlevlcode, laps_sanctauthcode, laps_sanctrefnum, laps_descofsecurity,laps_drwngpowerind, " +
						"laps_limitb2kid, laps_drwngpowerpcnt, laps_drwngpower, laps_freecode6, laps_freecode7, laps_freecode8,laps_maxalwdadvnlim," +
						" laps_psfreqtype, laps_psfreqweekday, laps_freqstartdd, laps_freqhldystat, laps_psdespatchmode,laps_intfreqtypedr, " +
						"laps_intfreqstartdddr, laps_intfreqhldystatdr, laps_nextintrundatedr, laps_foracid, laps_sol_id,laps_local_cal_flg, " +
						"laps_sector_code, laps_sub_sector_code, laps_acct_occp_code, laps_borrower_category_code, laps_purpose_of_advn," +
						"laps_mode_of_advn, laps_type_of_advn, laps_nature_of_advn, laps_guar_cover_code, laps_bsr_occu_code, laps_lbr_code," +
						"laps_service_area_code, laps_land_holding_code, laps_schematic_code, laps_scst_code, laps_minority_code,laps_sensitive_sector_code," +
						"laps_security_code, laps_dept_code, laps_free_code_3, laps_lr_freq_start_dd, laps_lr_int_freq_hldy_stat," +
						"laps_health_code, laps_rcre_time, laps_renew_flg, laps_processed_flg, laps_sno, laps_handoff_time, laps_handoff_flag," +
						"laps_user_id, laps_app_file_name,MULTI_SCHEDULE_NUM,SCHEDULE_DETAILS,LAPS_RELATIONTYPE,reset_freq,shg_code,govt_scheme," +
						"dep_acct,dep_amt,dsaid,ACTIVITY_CODE,ALLIED_ACTIVITY_CODE,PROC_CHRG_AMT,PROC_CHRG_COLL_FLG) values(?,?,?,?,?,?,?,?,?,?,?,?,to_date(?,'dd/mm/yyyy'),?,?,?,to_date(?,'dd/mm/yyyy'),?,?," +
						"to_date(?,'dd/mm/yyyy'),to_date(?,'dd/mm/yyyy'),to_date(?,'dd/mm/yyyy'),to_date(?,'dd/mm/yyyy'),?,?,?,?,?,?,?,?,?,?,?," +
						"?,?,?,?,?,?,?,?,?,to_date(?,'dd/mm/yyyy'),?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,sysdate,?,?,?,sysdate,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				
				ps.setString(1,strAppNo);//1
				ps.setString(2,strCustCBSId);//2
				ps.setString(3,strSchemeCode);//3
				ps.setString(4,strGLSubHeadCode);//4
				ps.setString(5,strModeOfOperCode);//5
				ps.setString(6,strPBPSCode);//6
				ps.setString(7,strIntTBLCode);//7
				ps.setString(8,strIDDRPrefPerc);//8
				ps.setString(9,strSanctLim);//9
				ps.setString(10,strRepPrdMths);//10
				ps.setString(11,strRepPrdDays);//11
				ps.setString(12,strOpAcId);//12 for Operative account nmbr
				ps.setString(13,strIDMDEffDate);//13
				ps.setString(14,strIntOnIDMDFlag);//14
				ps.setString(15,strNumOfFlows);//15
				ps.setString(16,strLRFreqType.toUpperCase());//16
				ps.setString(17,strFlowStartDate);//17
				ps.setString(18,strFlowAmt);//18
				ps.setString(19,strLRIntFreqType);//19
				ps.setString(20,strNextIntDmdDate);//20
				ps.setString(21,strLimSanctDate);//21
				ps.setString(22,strLimExpDate);//22
				ps.setString(23,strLoanPaperDate);//23
				ps.setString(24,strSanctLevlCode);//24
				ps.setString(25,strSanctAuthCode);//25
				ps.setString(26,strSanctRefNum);//26
				ps.setString(27,strDescOfSecurity);//27
				ps.setString(28,strDrwngPowerInd);//28
				ps.setString(29,strLimitB2kid);//29
				ps.setString(30,strDrwngPowerPcnt);//30
				ps.setString(31,strDrwngPower);//31
				ps.setString(32,strFreeCode6);//32
				ps.setString(33,strFreeCode7);//33
				ps.setString(34,strFreeCode8);//34
				ps.setString(35,strMaxAlwdAdvnLim);//35
				ps.setString(36,strPSFreqType);//36
				ps.setString(37,strPSFreqWeekDay);//37
				ps.setString(38,strFreqStartDD);//38
				ps.setString(39,strFreqHldyStat);//39
				ps.setString(40,strPSDespatchMode);//40
				ps.setString(41,strIntFreqTypeDR);//41
				ps.setString(42,strIntFreqStartDDDR);//42
				ps.setString(43,strIntFreqHldyStatDR);//43
				ps.setString(44,strNextIntRunDateDR);//44
				ps.setString(45,strForAcID);//45
				ps.setString(46,strSolID);//46
				ps.setString(47,strLocalCallFlg);//47
				ps.setString(48,strSectorCode);//48
				ps.setString(49,strSubSectorCode);//49
				ps.setString(50,strAcctOccpCode);//50
				ps.setString(51,strBorrowerCatCode);//51
				ps.setString(52,strAdvancePurpose);//52
				ps.setString(53,strAdvanceMode);//53
				ps.setString(54,strAdvanceType);//54
				ps.setString(55,strAdvanceNature);//55
				ps.setString(56,strGuarCoverCode);//56
				ps.setString(57,strBSROccuCode);//57
				ps.setString(58,strLBRCode);//58
				ps.setString(59,strServiceAreaCode);//59
				ps.setString(60,strLandHoldCode);//60
				ps.setString(61,strBankScheme);//61
				ps.setString(62,strSCSTCode);//62
				ps.setString(63,strMinorityCode);//63
				ps.setString(64,strSensitiveSectorCode);//64
				ps.setString(65,strSecurityCode);//65
				ps.setString(66,strDeptCode);//66
				ps.setString(67,strFreeCode3);//67
				ps.setString(68,strLRFreqStartDD);//68
				ps.setString(69,strLrIntFreqHldyStat);//69
				ps.setString(70,strHealthCode);//70
				ps.setString(71,strRenewFlg);//71
				ps.setString(72,strProcessedFlg);//72
				ps.setString(73,strSNo);//73
				ps.setString(74,"Y");//74
				ps.setString(75,Helper.correctNull((String)hshValues.get("strUserId")));//75
				ps.setString(76,strFile);//76
				ps.setString(77,strMulti_schedule_num);//77
				ps.setString(78,strSchedule_details);//78
				ps.setString(79,strRelationType);//79
				ps.setString(80,strResetFreqFlag);//80
				ps.setString(81,strSHGCode);//81
				ps.setString(82,strGovtSponSch);//82
				ps.setString(83,strDepDetails.toString());//83
				ps.setString(84,strDepAmt.toString());//84
				ps.setString(85,strDSAID);//85
				ps.setString(86,activityCode);//86
				ps.setString(87,alliedactivityCode);//86
				
				ps.setString(88,proc_chrg_amt);//88
				ps.setString(89,proc_chrg_coll_flg);//89
				ps.executeUpdate();
				log.info("insert into laps_aif table completed. proposal number ===="+strAppNo);
				System.out.println("insert into laps_aif table completed. proposal number ===="+strAppNo);
				if (ps != null)
				{
					ps.close();
				}
				
				if (con != null)
				{
					con.close();
				}
				
				hshQuery=new HashMap();
				hshQuery.put("strQueryId", "update_loanduedate");
				arrValues = new ArrayList();
				arrValues.add(strLimExpDate);
				arrValues.add(strEMIamount);
				arrValues.add(nf.format(dblFinalRate));
				arrValues.add(strAppNo);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
				else
				{
					hshQueryValues=new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
					{
						hshQuery.put("strQueryId", "ins_FinacleAccCreation_newconnection_new_one");
					}
					else
					{
					hshQuery.put("strQueryId", "ins_FinacleAccCreation_new_one");
					}
					arrValues.add(strAppNo);//1
					arrValues.add(strCustCBSId);//2
					arrValues.add(strSchemeCode);//3
					arrValues.add(strGLSubHeadCode);//4
					arrValues.add(strModeOfOperCode);//5
					arrValues.add(strPBPSCode);//6
					arrValues.add(strIntTBLCode);//7
					arrValues.add(strIDDRPrefPerc);//8
					arrValues.add(strSanctLim);//9
					arrValues.add(strRepPrdMths);//10
					arrValues.add(strRepPrdDays);//11
					arrValues.add(strOpAcId);//12 for Operative account nmbr
					arrValues.add(strIDMDEffDate);//13
					arrValues.add(strIntOnIDMDFlag);//14
					arrValues.add(strNumOfFlows);//15
					arrValues.add(strLRFreqType.toUpperCase());//16
					arrValues.add(strFlowStartDate);//17
					arrValues.add(strFlowAmt);//18
					arrValues.add(strLRIntFreqType);//19
					arrValues.add(strNextIntDmdDate);//20
					arrValues.add(strLimSanctDate);//21
					arrValues.add(strLimExpDate);//22
					arrValues.add(strLoanPaperDate);//23
					arrValues.add(strSanctLevlCode);//24
					arrValues.add(strSanctAuthCode);//25
					arrValues.add(strSanctRefNum);//26
					arrValues.add(strDescOfSecurity);//27
					arrValues.add(strDrwngPowerInd);//28
					arrValues.add(strLimitB2kid);//29
					arrValues.add(strDrwngPowerPcnt);//30
					arrValues.add(strDrwngPower);//31
					arrValues.add(strFreeCode6);//32
					arrValues.add(strFreeCode7);//33
					arrValues.add(strFreeCode8);//34
					arrValues.add(strMaxAlwdAdvnLim);//35
					arrValues.add(strPSFreqType);//36
					arrValues.add(strPSFreqWeekDay);//37
					arrValues.add(strFreqStartDD);//38
					arrValues.add(strFreqHldyStat);//39
					arrValues.add(strPSDespatchMode);//40
					arrValues.add(strIntFreqTypeDR);//41
					arrValues.add(strIntFreqStartDDDR);//42
					arrValues.add(strIntFreqHldyStatDR);//43
					arrValues.add(strNextIntRunDateDR);//44
					arrValues.add(strForAcID);//45
					arrValues.add(strSolID);//46
					arrValues.add(strLocalCallFlg);//47
					arrValues.add(strSectorCode);//48
					arrValues.add(strSubSectorCode);//49
					arrValues.add(strAcctOccpCode);//50
					arrValues.add(strBorrowerCatCode);//51
					arrValues.add(strAdvancePurpose);//52
					arrValues.add(strAdvanceMode);//53
					arrValues.add(strAdvanceType);//54
					arrValues.add(strAdvanceNature);//55
					arrValues.add(strGuarCoverCode);//56
					arrValues.add(strBSROccuCode);//57
					arrValues.add(strLBRCode);//58
					arrValues.add(strServiceAreaCode);//59
					arrValues.add(strLandHoldCode);//60
					arrValues.add(strBankScheme);//61
					arrValues.add(strSCSTCode);//62
					arrValues.add(strMinorityCode);//63
					arrValues.add(strSensitiveSectorCode);//64
					arrValues.add(strSecurityCode);//65
					arrValues.add(strDeptCode);//66
					arrValues.add(strFreeCode3);//67
					arrValues.add(strLRFreqStartDD);//68
					arrValues.add(strLrIntFreqHldyStat);//69
					arrValues.add(strHealthCode);//70
					arrValues.add(strRenewFlg);//71
					arrValues.add(strProcessedFlg);//72
					arrValues.add(strSNo);//73
					arrValues.add(strMulti_schedule_num);//74
					arrValues.add(strSchedule_details);//75
					arrValues.add(strFile);
					arrValues.add(strRelationType);
					arrValues.add(strResetFreqFlag);
					arrValues.add(strSHGCode);
					arrValues.add(strGovtSponSch);
					arrValues.add(strDSAID);
					arrValues.add(strDepDetails.toString());
					arrValues.add(strDepAmt.toString());
					arrValues.add(strGoldRate);
					arrValues.add(strLoanMargin);
					arrValues.add(strStageWiseRelease);
					arrValues.add(activityCode);
					arrValues.add(alliedactivityCode);
					
					arrValues.add(proc_chrg_amt);
					arrValues.add(proc_chrg_coll_flg);
					
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					
					if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
					{
					   EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateCBSData");
					}
					else
					{
					   EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
										
					}
					
					
					if(!strModeofPayment.equalsIgnoreCase("") && ! strECSAuthMode.equalsIgnoreCase("")){
						if(strModeofPayment.equalsIgnoreCase("C") && !strECSAuthMode.equalsIgnoreCase("3")){
							
							hshQuery=new HashMap();
							hshQuery.put("strQueryId", "ins_laps_enach");
							arrValues = new ArrayList();
							arrValues.add(strAppNo);
							arrValues.add(strECSBankname);
							arrValues.add(strECSAccountTYpe);
							arrValues.add(strECSIFSCCODE);
							arrValues.add(strECSOperaccnum);
							arrValues.add(strECSAuthMode);
							arrValues.add(strenachumrn);
							arrValues.add(Helper.correctNull((String)hshValues.get("strUserId")));
							arrValues.add(strCurrentDate);
							arrValues.add(Helper.correctNull((String)hshValues.get("strUserId")));
							arrValues.add(strCurrentDate);
							arrValues.add(STRDELFLAG);
							arrValues.add(strFREETXT);
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("1", hshQuery);
							hshQueryValues.put("size", "1");
							
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
							
						}
					}
					
					
					hshQueryValues=new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId", "insertAccountHandOffDetails_new_one");
					arrValues.add(strAppNo);//1
					arrValues.add(strCustCBSId);//2
					arrValues.add(strSchemeCode);//3
					arrValues.add(strGLSubHeadCode);//4
					arrValues.add(strModeOfOperCode);//5
					arrValues.add(strPBPSCode);//6
					arrValues.add(strIntTBLCode);//7
					arrValues.add(strIDDRPrefPerc);//8
					arrValues.add(strSanctLim);//9
					arrValues.add(strRepPrdMths);//10
					arrValues.add(strRepPrdDays);//11
					arrValues.add(strOpAcId);//12 for Operative account nmbr
					arrValues.add(strIDMDEffDate);//13
					arrValues.add(strIntOnIDMDFlag);//14
					arrValues.add(strNumOfFlows);//15
					arrValues.add(strLRFreqType.toUpperCase());//16
					arrValues.add(strFlowStartDate);//17
					arrValues.add(strFlowAmt);//18
					arrValues.add(strLRIntFreqType);//19
					arrValues.add(strNextIntDmdDate);//20
					arrValues.add(strLimSanctDate);//21
					arrValues.add(strLimExpDate);//22
					arrValues.add(strLoanPaperDate);//23
					arrValues.add(strSanctLevlCode);//24
					arrValues.add(strSanctAuthCode);//25
					arrValues.add(strSanctRefNum);//26
					arrValues.add(strDescOfSecurity);//27
					arrValues.add(strDrwngPowerInd);//28
					arrValues.add(strLimitB2kid);//29
					arrValues.add(strDrwngPowerPcnt);//30
					arrValues.add(strDrwngPower);//31
					arrValues.add(strFreeCode6);//32
					arrValues.add(strFreeCode7);//33
					arrValues.add(strFreeCode8);//34
					arrValues.add(strMaxAlwdAdvnLim);//35
					arrValues.add(strPSFreqType);//36
					arrValues.add(strPSFreqWeekDay);//37
					arrValues.add(strFreqStartDD);//38
					arrValues.add(strFreqHldyStat);//39
					arrValues.add(strPSDespatchMode);//40
					arrValues.add(strIntFreqTypeDR);//41
					arrValues.add(strIntFreqStartDDDR);//42
					arrValues.add(strIntFreqHldyStatDR);//43
					arrValues.add(strNextIntRunDateDR);//44
					arrValues.add(strForAcID);//45
					arrValues.add(strSolID);//46
					arrValues.add(strLocalCallFlg);//47
					arrValues.add(strSectorCode);//48
					arrValues.add(strSubSectorCode);//49
					arrValues.add(strAcctOccpCode);//50
					arrValues.add(strBorrowerCatCode);//51
					arrValues.add(strAdvancePurpose);//52
					arrValues.add(strAdvanceMode);//53
					arrValues.add(strAdvanceType);//54
					arrValues.add(strAdvanceNature);//55
					arrValues.add(strGuarCoverCode);//56
					arrValues.add(strBSROccuCode);//57
					arrValues.add(strLBRCode);//58
					arrValues.add(strServiceAreaCode);//59
					arrValues.add(strLandHoldCode);//60
					arrValues.add(strBankScheme);//61
					arrValues.add(strSCSTCode);//62
					arrValues.add(strMinorityCode);//63
					arrValues.add(strSensitiveSectorCode);//64
					arrValues.add(strSecurityCode);//65
					arrValues.add(strDeptCode);//66
					arrValues.add(strFreeCode3);//67
					arrValues.add(strLRFreqStartDD);//68
					arrValues.add(strLrIntFreqHldyStat);//69
					arrValues.add(strHealthCode);//70
					arrValues.add(strRenewFlg);//71
					arrValues.add(strProcessedFlg);//72
					arrValues.add(strSNo);//73
					arrValues.add("Y");//74
					arrValues.add(Helper.correctNull((String)hshValues.get("strUserId")));//75
					arrValues.add(strFile);//76
					arrValues.add(strMulti_schedule_num);//77
					arrValues.add(strSchedule_details);//78
					arrValues.add(strRelationType);//79
					arrValues.add(strResetFreqFlag);
					arrValues.add(strSHGCode);
					arrValues.add(strGovtSponSch);
					arrValues.add(strDepDetails.toString());
					arrValues.add(strDepAmt.toString());
					arrValues.add(strDSAID);
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add(strGoldRate);
					arrValues.add(strLoanMargin);
					arrValues.add(strStageWiseRelease);
					arrValues.add("");
					arrValues.add(activityCode);
					arrValues.add(alliedactivityCode);
					arrValues.add(proc_chrg_amt);
					arrValues.add(proc_chrg_coll_flg);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					
					
					hshQuery=new HashMap();
					hshQuery.put("strQueryId", "update_loanduedate");
					arrValues = new ArrayList();
					arrValues.add(strLimExpDate);
					arrValues.add(strEMIamount);
					arrValues.add(nf.format(dblFinalRate));
					arrValues.add(strAppNo);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("2", hshQuery);
					hshQueryValues.put("size", "2");
					
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					
				}
				
				
				
				
				
			}
			hshRecord.put("SanctionDetails",SanctionDetails);
		}
		catch (Exception e)
		{
			throw new EJBException("Error Occured  " + e.getMessage());
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
			catch (Exception e)
			{
				e.printStackTrace();
			}
		}
		return hshRecord;
	}
	public HashMap getODFlatFileReport(HashMap hshValues) 
	{
		SimpleDateFormat sdnew=new SimpleDateFormat("dd/MM/yyyy");
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshRecord = new HashMap();
		ArrayList arrValues=new ArrayList();
		ResultSet rs=null;
		ResultSet rs1=null;
		ResultSet rs2=null;
		ResultSet rs3=null;
		int intDateDiff = 0;
		String strDateDiff = "",SchemeCode="";
		/*File Directory = null;
		String strPath = "";
		strPath = ApplicationParams.getFlatFile();
		Directory = new File(strPath);
		if (!Directory.exists())
		{
			Directory.mkdirs();
		}*/
		String strFileName = "";
		String strFile = "";
		String strCustCBSId="";
		String strSchemeCode="";
		String strGLSubHeadCode="";
		String strModeOfOperCode="";
		String strPBPSCode="B";
		String strPSFreqType="M";
		String strIntTBLCode="";
		String strIDDRPrefPerc="";
		String strSanctLim="";
		String strRepPrdMths="";
		String strLimSanctDate="";
		String strLimExpDate="";
		String strLoanPaperDate="";
		String strSanctLevlCode="";
		String strSanctAuthCode="";
		String strSanctRefNum="";
		String strDescOfSecurity="";
		String strDrwngPowerInd="";
		String strLimitB2kid="";
		String strDrwngPowerPcnt="";
		String strDrwngPower="";
		String strFreeCode6="";
		String strFreeCode7="";
		String strFreeCode8="";
		String SanctionDetails="";
		String strExcludeHoliday="";
		String strIntType="";
		String strPrdCode="";
		String strPrdType="";
		String strQuery="";
		String strQuery1="";
		String strQuery2="";
		String strQuery3="";
		String strAppId="";
		String strAppNo="";
		String strHolidayPeriod="";
		String strLoanServised="";
		String strPSFreqWeekDay="";
		String strFreqStartDD="1";
		String strFreqHldyStat="N";
		String strPSDespatchMode="N";
		String strIntFreqTypeDR="";
		String strIntFreqStartDDDR="31";
		String strIntFreqHldyStatDR="P";
		String strNextIntRunDateDR="";
		String strForAcID="";
		String strSolID="";
		String strAdvanceNature="";
		String strAdvanceType="";
		String strAdvanceMode="";
		String strAdvancePurpose="";
		String strFreeCode3="";
		String strSecurityCode="";
		String strLocalCallFlg="N";
		String strSectorCode="";
		String strSubSectorCode="";
		String strSensitiveSectorCode="";
		String strGuarCoverCode="";
		String strBSROccuCode="";
		String strLBRCode="";
		String strServiceAreaCode="";
		String strLandHoldCode="";
		String strBankScheme="";
		String strProcessedFlg="";
		String strAcctOccpCode="";
		String strBorrowerCatCode="";
		String strSCSTCode="";
		String strRenewFlg="";
		String strHealthCode="01";
		String strMinorityCode="";
		String strDeptCode="";
		String strSNo="1";
		String strRepPrdDays="";
		String strOpAcId="";
		String strIDMDEffDate="";
		String strIntOnIDMDFlag="";
		String strNumOfFlows="";
		String strLRFreqType="";
		String strFlowStartDate="";
		String strFlowAmt="";
		String strLRIntFreqType="";
		String strNextIntDmdDate="";
		String strMaxAlwdAdvnLim="";
		String strLRFreqStartDD="";
		String strLrIntFreqHldyStat="";
		String strStaffId="",strStaffNumber="",activityCode="";
		String alliedactivityCode="";
		double dblModIntRate=0.00, dblBaseRate=0.00, dblFloatingRate=0.00,dblFinalRate=0.0;
		int intRepayPeriod=0, intLoanPeriod=0, intNextIntRunDateDR=0, intPeriod=0;
		NumberFormat nf = NumberFormat.getInstance();
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
		nf.setGroupingUsed(false);
		NumberFormat nf1 = NumberFormat.getInstance();
		nf1.setMaximumFractionDigits(0);
		nf1.setMinimumFractionDigits(0);
		nf1.setGroupingUsed(false);
		Date currentDate=new Date();
		//String strCurrentDate=(String)currentDate.toString();
		String strLoanRepaymentType="",strSHGCode="";
		int intHolidayPeriod=0;
		String CBSSchemecode="",CBSGLsubheadcode="",stragriproduct="",strMCLRCode="",strResetFreqFlag="",strMCLRType="",strGovtSponsSch="";
		StringBuffer strDepDetails=new StringBuffer();
		StringBuffer strDepAmt=new StringBuffer();
		String strDSAID="",strGoldRate="",strLoanMargin="",strEMIamount="";
		try
		{
			String strCurrentDate=Helper.getCurrentDateTime();
			strAppNo=Helper.correctNull((String)hshValues.get("appno"));
			if(strAppNo.equalsIgnoreCase(""))
			{
				strAppNo=Helper.correctNull((String)hshValues.get("appno1"));
			}
			if(strAppNo.equalsIgnoreCase(""))
			{
				strAppNo=Helper.correctNull((String)hshValues.get("strappno"));
			}
			if(!strAppNo.equalsIgnoreCase(""))
			{
				strQuery=SQLParser.getSqlQuery("sel_AccFlatFileData1^"+strAppNo);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strAppId=Helper.correctNull((String)rs.getString("perapp_id"));
					strCustCBSId=Helper.correctNull((String)rs.getString("perapp_cbsid"));
					strSchemeCode=Helper.correctNull((String)rs.getString("scheme_code"));
					String strModIntRate=Helper.correctNull((String)rs.getString("loan_modintrate"));
					strRepPrdMths=Helper.correctNull((String)rs.getString("loan_reqterms"));
					intLoanPeriod=Integer.parseInt(Helper.correctInt((String)strRepPrdMths));
					strLimExpDate=Helper.addMonthWithDate(currentDate, intLoanPeriod);
					strHolidayPeriod=Helper.correctInt((String)rs.getString("loan_noofinstallment"));
					strLoanServised=Helper.correctInt((String)rs.getString("LOAN_SERVISED"));
					intHolidayPeriod=Integer.parseInt(Helper.correctInt(strHolidayPeriod));
					intRepayPeriod=Integer.parseInt(Helper.correctInt(strRepPrdMths))-Integer.parseInt(Helper.correctInt(strHolidayPeriod));
					strExcludeHoliday=Integer.toString(intRepayPeriod);
					strSanctLim=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("loan_recmdamt"))));
					dblModIntRate=Double.parseDouble(Helper.correctDouble(strModIntRate));
					dblFinalRate=dblModIntRate;
					strIntType=Helper.correctNull((String)rs.getString("loan_inttype"));
					strPrdCode=Helper.correctNull((String)rs.getString("prd_code"));
					strLoanRepaymentType=Helper.correctNull((String)rs.getString("loan_repaymenttype"));
					dblBaseRate=Double.parseDouble(Helper.correctDouble(rs.getString("loan_baserate")));
					strLimSanctDate=Helper.correctNull((String)rs.getString("app_processdate"));
					strMCLRCode=Helper.correctNull(rs.getString("loan_mclrtabcode"));
					strMCLRType=Helper.correctNull(rs.getString("loan_mclrtype"));
					strEMIamount=Helper.correctNull((String)rs.getString("loan_emi"));
					strGovtSponsSch=Helper.correctNull(rs.getString("govt_scheme"));
					if(strGovtSponsSch.equalsIgnoreCase("0"))
						strGovtSponsSch=null;
					if(rs1!=null)
					{
						rs1.close();
					}
					strQuery1=SQLParser.getSqlQuery("sel_sancdate_diff_Intcode^"+strLimSanctDate);
					rs1=DBUtils.executeQuery(strQuery1);
					if(rs1.next())
					{
						intDateDiff=Integer.parseInt(Helper.correctInt((String)rs1.getString("datediff")));
						
						if(intDateDiff>=0)
							strDateDiff="Y";
						else
							strDateDiff="N";
					}
					if(rs1!=null)
					{
						rs1.close();
					}
					strQuery1=SQLParser.getSqlQuery("sel_staffprd^"+strPrdCode);
					rs1=DBUtils.executeQuery(strQuery1);
					if(rs1.next())
					{
						strStaffId=Helper.correctNull((String)rs1.getString("prd_staffprd"));
					}
					if(rs1!=null)
					{
						rs1.close();
					}
					
					strPrdType=Helper.correctNull(rs.getString("prd_type"));
					if(strStaffId.equalsIgnoreCase("Y") && !strPrdType.equalsIgnoreCase("pR"))
					{
						strQuery1=SQLParser.getSqlQuery("sel_tablecode^"+strPrdCode);
						rs1=DBUtils.executeQuery(strQuery1);
						if(rs1.next())
						{
							strIntTBLCode=Helper.correctNull((String)rs1.getString("prd_tablecode"));
							strIDDRPrefPerc="0";
							
							/*if(strDateDiff.equalsIgnoreCase("Y"))
							{
								strIntTBLCode = "A"+strIntTBLCode.substring(1, strIntTBLCode.length());
							}
							else
							{
								strIntTBLCode = "L"+strIntTBLCode.substring(1, strIntTBLCode.length());
							}*/
						}
					}
					else
					{
						if(!strModIntRate.equalsIgnoreCase(""))
						{
							if(strIntType.equalsIgnoreCase("fixed"))
							{
								double dblFlooredModIntRate=Math.floor(dblModIntRate);
								double dblRemaining=dblModIntRate-dblFlooredModIntRate;
								String strFlooredModIntRate=nf1.format(dblFlooredModIntRate);
								if(strFlooredModIntRate.length()==1)
								{
									if(strDateDiff.equalsIgnoreCase("Y"))
									{
										strIntTBLCode="N0"+nf1.format(dblFlooredModIntRate)+"00";
									}
									else
									{
										strIntTBLCode="0"+nf1.format(dblFlooredModIntRate)+"00";
									}
								}
								else
								{
									if(strDateDiff.equalsIgnoreCase("Y"))
									{
										strIntTBLCode="N"+nf1.format(dblFlooredModIntRate)+"00";
									}
									else
									{
										strIntTBLCode=nf1.format(dblFlooredModIntRate)+"00";
									}
								}
								strIDDRPrefPerc=nf.format(dblRemaining);
							}
							else if(strIntType.equalsIgnoreCase("floating"))
							{
								/*strIntType="floating";
								strQuery1=SQLParser.getSqlQuery("sel_AccFlatFileData3^"+strRepPrdMths+"^"+strSanctLim+"^"+strIntType+"^"+strPrdCode);
								rs1=DBUtils.executeQuery(strQuery1);
								if(rs1.next())
								{*/
//								if(strDateDiff.equalsIgnoreCase("Y"))
//								{
//									strIntTBLCode="NBASE";
//								}
//								else
//								{
//									strIntTBLCode="BASE";
//								}
									//dblBaseRate=Double.parseDouble(Helper.correctDouble((String)rs1.getString("int_intvalue")));
//									dblFloatingRate=dblModIntRate-dblBaseRate;
//									strIDDRPrefPerc=nf.format(dblFloatingRate);
								//}
								
								if(rs1!=null)
								{
									rs1.close();
								}
								strQuery=SQLParser.getSqlQuery("sanctiondate_mclr^"+strAppNo);
								rs1=DBUtils.executeQuery(strQuery);
								if(rs1.next())
								{
									if(Integer.parseInt(Helper.correctInt(rs1.getString("datediff")))<0)
									{
										if(strDateDiff.equalsIgnoreCase("Y"))
										{
											strIntTBLCode="NBASE";
										}
										else
										{
											strIntTBLCode="BASE";
										}
											dblFloatingRate=dblModIntRate-dblBaseRate;
											strIDDRPrefPerc=nf.format(dblFloatingRate);
									
									}
									else
									{
										//strIntTBLCode="NMC"+strMCLRCode;
										strIntTBLCode=strMCLRCode;
										dblFloatingRate=dblModIntRate-dblBaseRate;
										//strIDDRPrefPerc=nf.format(dblFloatingRate);
										strIDDRPrefPerc=nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("loan_creditrskval")))+Double.parseDouble(Helper.correctDouble(rs.getString("loan_busstatval"))));
										
										if(!strMCLRType.equalsIgnoreCase(""))
					 					{
					 						String[] strArr=strMCLRType.split("@");
					 						if(strArr.length>1)
					 						{
					 							if(strArr[0].equalsIgnoreCase("O")||strArr[0].equalsIgnoreCase("M")||strArr[0].equalsIgnoreCase("Q")||strArr[0].equalsIgnoreCase("H")||strArr[0].equalsIgnoreCase("Y"))
					 							strResetFreqFlag=strArr[0];
					 							
					 							if(rs2!=null)
					 								rs2.close();
					 							rs2=DBUtils.executeLAPSQuery("sel_mclrspreadrate^"+Helper.getCurrentDateTime()+"^"+strArr[0]);
					 							if(rs2.next())
					 							{
					 								dblFinalRate=Double.parseDouble(Helper.correctDouble(rs2.getString("mclr_baseratespread")))+Double.parseDouble(Helper.correctDouble(rs.getString("loan_creditrskval")))+Double.parseDouble(Helper.correctDouble(rs.getString("loan_busstatval")));
					 							}
					 						}
					 					}
									}
								}
								
							}
						}
					}
					if(Helper.correctNull((String)rs.getString("loan_modeofpay")).equalsIgnoreCase("E"))
					{
						strOpAcId=Helper.correctNull((String)rs.getString("loan_operativeaccno"));
					}
					if(strPrdType.equalsIgnoreCase("pR"))
					{
						if(rs2!=null)
							rs2.close();
						strQuery2=SQLParser.getSqlQuery("sel_AccFlatFileData4^"+strAppNo);
						rs2=DBUtils.executeQuery(strQuery2);
						if(rs2.next())
						{
							String strMatDate=Helper.correctNull((String)rs2.getString("loan_matdate"));
							strRepPrdDays=(String)Long.toString(Helper.dateDiff(strLimExpDate, strMatDate));
							strLimExpDate=strMatDate;
							
							if(Integer.parseInt(Helper.correctInt(strRepPrdDays))<0)
							{
								
								if(rs1!=null)
									rs1.close();
								rs1=DBUtils.executeLAPSQuery("getdaysofbirth^"+strLimExpDate);
	 							if(rs1.next())
	 							{
	 								strRepPrdMths=Helper.correctInt(rs1.getString("dates"));
									Date currDate=new Date();
									strRepPrdDays=(String)Long.toString(Helper.dateDiff(Helper.addMonthWithDate(currDate,(Integer.parseInt(strRepPrdMths))), strLimExpDate));
	 							}
							}
						}
					}
					
					strLoanPaperDate=Helper.correctNull((String)rs.getString("ac_opening_date"));
					strSanctLevlCode=Helper.correctNull((String)rs.getString("appraisal_sanclevel"));
					strSanctAuthCode=Helper.correctNull((String)rs.getString("appraisal_sancauth"));
					if(rs3!=null)
					{
						rs3.close();
					}
					strQuery3=SQLParser.getSqlQuery("sel_misappclassification^"+strAppNo+"^"+1);
					rs3=DBUtils.executeQuery(strQuery3);
					if(rs3.next())
					{
						strSectorCode=Helper.correctNull((String)rs3.getString("app_sector"));
						strSubSectorCode=Helper.correctNull((String)rs3.getString("app_subsector"));
						strSensitiveSectorCode=Helper.correctNull((String)rs3.getString("app_sensitivesector"));
					}
					if(rs3!=null)
					{
						rs3.close();
					}
					if((!strSchemeCode.equalsIgnoreCase(""))&&(!strSubSectorCode.equalsIgnoreCase("")))
					{
						strQuery3=SQLParser.getSqlQuery("sel_AccFlatFileData2^"+strSchemeCode+"^"+strSubSectorCode+"@^@"+strSubSectorCode+"@");
						rs3=DBUtils.executeQuery(strQuery3);
						if(rs3.next())
						{
							strGLSubHeadCode=Helper.correctNull((String)rs3.getString("sch_datadescription"));
						}
					}
					strQuery3=SQLParser.getSqlQuery("sel_cbsdetails^"+strAppNo+"^1");
					rs3=DBUtils.executeQuery(strQuery3);
					if(rs3.next())
					{
						strFreeCode6=Helper.correctNull((String)rs3.getString("FREECODE6"));
						strFreeCode7=Helper.correctNull((String)rs3.getString("FREECODE7FINCODE"));
						strFreeCode8=Helper.correctNull((String)rs3.getString("FREECODE8FINCODE"));
						strModeOfOperCode=Helper.correctNull((String)rs3.getString("MODE_OF_OPERATION"));
						strDrwngPowerInd=Helper.correctNull((String)rs3.getString("DRAWING_PWR_IND"));
						strDrwngPower=Helper.correctNull((String)rs3.getString("DRAWING_PWR"));
						strSolID=Helper.correctNull((String)rs3.getString("LOANDISBBRANCH"));
						strAdvanceNature=Helper.correctNull((String)rs3.getString("NATUREOFADV"));
						strAdvanceType=Helper.correctNull((String)rs3.getString("TYPEOFADV"));
						strAdvanceMode=Helper.correctNull((String)rs3.getString("MODEOFADV"));
						strAdvancePurpose=Helper.correctNull((String)rs3.getString("PURPOSEOFADV"));
						strFreeCode3=Helper.correctNull((String)rs3.getString("FREECODE3"));
						//strSecurityCode=Helper.correctNull((String)rs3.getString("SECURITYCODE"));
						strIntFreqTypeDR=Helper.correctNull((String)rs3.getString("INTRATEFREQ"));
						//strLBRCode=Helper.correctNull((String)rs3.getString("LBRCODE"));
						strDescOfSecurity=Helper.correctNull((String)rs3.getString("CER_GISTOFSECURITUES"));
						CBSSchemecode=Helper.correctNull((String)rs3.getString("facility_schemecode"));
						CBSGLsubheadcode=Helper.correctNull((String)rs3.getString("facility_glsubheadcode"));
					}
					strBorrowerCatCode=Helper.correctNull((String)rs.getString("perapp_constitution"));
					strRenewFlg=Helper.correctNull((String)rs.getString("app_renew_flag"));
					if(strRenewFlg.equalsIgnoreCase("R") && !(strPrdType.equalsIgnoreCase("pR")||strPrdType.equalsIgnoreCase("pG")))
						strLimExpDate=Helper.correctNull((String)rs.getString("loan_duedate"));
					strBankScheme=Helper.correctNull((String)rs.getString("prd_bankscheme"));
					strDeptCode=Helper.correctNull((String)rs.getString("appraisal_department"));
					strFile=Helper.correctNull((String)rs.getString("loan_fileno"));
					if(!CBSSchemecode.equalsIgnoreCase(""))
					{
						strSchemeCode=CBSSchemecode;
					}
					if(!CBSGLsubheadcode.equalsIgnoreCase(""))
					{
						strGLSubHeadCode=CBSGLsubheadcode;
					}
					stragriproduct=Helper.correctNull(rs.getString("prd_whetheragri"));
					
					if(Integer.parseInt(Helper.correctInt(rs.getString("perapp_constitution")))>=183 && Integer.parseInt(Helper.correctInt(rs.getString("perapp_constitution")))<=191)
						strSHGCode="002";
					else
						strSHGCode="001";
					if(strPrdType.equalsIgnoreCase("pG"))
					{
						strLoanMargin=Helper.correctNull(rs.getString("loan_margin"));
					}
				}
				if(rs!=null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("sel_FinacleSancRefNo^"+strAppNo);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strSanctRefNum=Helper.correctNull((String)rs.getString("finaclesancrefno"));
				}
				if(rs!=null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("sel_misappdetails^"+strAppNo+"^"+"1");
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strGuarCoverCode=Helper.correctNull((String)rs.getString("app_guarantee"));
					strBSROccuCode=Helper.correctNull((String)rs.getString("app_bsrcode"));
					strServiceAreaCode=Helper.correctNull((String)rs.getString("app_whetherservice"));
					activityCode = Helper.correctNull((String)rs.getString("app_activitycode"));
					alliedactivityCode= Helper.correctNull((String)rs.getString("APP_ALLIED_ACTIVITYCODE"));
					if(strServiceAreaCode.equalsIgnoreCase("Y"))
					{
						strServiceAreaCode="001";
					}else{
						strServiceAreaCode="002";
					}
					strLBRCode=Helper.correctNull((String)rs.getString("app_bsr1code"));
				}
				if(rs!=null)
				{
					rs.close();
				}
				//  Sno Hard Coded by Ahilandeswari.M  
				strQuery=SQLParser.getSqlQuery("sel_misappdisplayscreen^"+strAppNo+"^"+"1");
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					//strLandHoldCode=Helper.correctNull((String)rs.getString("app_totland"));
					strLandHoldCode=Helper.correctNull((String)rs.getString("app_farmercategory"));
				}
				if(rs!=null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("sel_CustomerDetails^"+strAppId);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strAcctOccpCode=Helper.correctNull((String)rs.getString("kyc_occupationcode"));
					strSCSTCode=Helper.correctNull((String)rs.getString("indinfo_caste"));
					strMinorityCode=Helper.correctNull((String)rs.getString("indinfo_religion"));
					strStaffNumber=Helper.correctNull((String)rs.getString("indinfo_staff_id"));
				}
				if(strIntFreqTypeDR.equalsIgnoreCase("m"))
				{
					intPeriod=1;
				}
				else if(strIntFreqTypeDR.equalsIgnoreCase("q"))
				{
					intPeriod=3;
				}
				else if(strIntFreqTypeDR.equalsIgnoreCase("h"))
				{
					intPeriod=6;
				}
				else if(strIntFreqTypeDR.equalsIgnoreCase("y"))
				{
					intPeriod=12;
				}
				else if(strIntFreqTypeDR.equalsIgnoreCase("n"))
				{
					if(strPrdType.equalsIgnoreCase("pR")||strPrdType.equalsIgnoreCase("pG"))
					{
						intPeriod=12;
						strIntFreqTypeDR="y";
					}
				}
				if(intPeriod!=0)
				{
					intNextIntRunDateDR=intRepayPeriod/intPeriod;
				}
				/*if(strPrdType.equalsIgnoreCase("pR")||strPrdType.equalsIgnoreCase("pG"))
				{
					strNextIntRunDateDR=Helper.addMonthWithDate(currentDate, intPeriod);

				}
				else
				{
					strNextIntRunDateDR=Helper.addMonthWithDate(currentDate, intPeriod+1);

				}*/
				if(strPrdType.equalsIgnoreCase("pR")||strPrdType.equalsIgnoreCase("pG"))
				{
					strNextIntDmdDate=Helper.addMonthWithDate(currentDate, intPeriod);
				}
				strNextIntDmdDate=Helper.addMonthWithDate(currentDate, intPeriod-1);
				
				if(!(strIntFreqTypeDR.equalsIgnoreCase("m")&& strLoanRepaymentType.equalsIgnoreCase("1")))
				{
					strQuery3=SQLParser.getSqlQuery("sel_enddateofmonth^"+strNextIntDmdDate);
					rs3=DBUtils.executeQuery(strQuery3);
					if(rs3.next())
					{
						strNextIntDmdDate=Helper.correctNull((String)rs3.getString("mon_enddate"));
					}
				}
				if(strIntFreqTypeDR.equalsIgnoreCase("m")&& strLoanRepaymentType.equalsIgnoreCase("1"))
				{
					strNextIntDmdDate=Helper.addMonthWithDate(currentDate, intPeriod);
				}
				
				// Next interest demand date calculated based on the Interest frequency yearly and freecode6 value in CBS details page
				if(strIntFreqTypeDR.equalsIgnoreCase("y") && !strFreeCode6.equalsIgnoreCase(""))
				{
					strNextIntDmdDate=Helper.getNextIntDmdDate(strCurrentDate, strIntFreqTypeDR, strFreeCode6);
				}
				
				//if Interest Frequency Quarterly means
				if(strIntFreqTypeDR.equalsIgnoreCase("q"))
				{
					strNextIntDmdDate=Helper.getNextIntDmdDate(strCurrentDate, strIntFreqTypeDR, strFreeCode6);	
				}
//				if(! strNextIntDmdDate.equalsIgnoreCase(""))
//				{
//					strIntFreqStartDDDR=strNextIntDmdDate.substring(0,2);
//				}
				
				if(strIntFreqTypeDR.equalsIgnoreCase("m")&& !strLoanRepaymentType.equalsIgnoreCase("1"))
				{
					strQuery3=SQLParser.getSqlQuery("sel_enddateofmonth^"+strCurrentDate);
					rs3=DBUtils.executeQuery(strQuery3);
					if(rs3.next())
					{
						strIDMDEffDate=Helper.correctNull((String)rs3.getString("mon_enddate"));
					}
				}
				if(intHolidayPeriod==0)
				{
					strIDMDEffDate="";
				}
				//Added by Guhan for Next Int Dmd Date passing as Anniversary date
				if(strSchemeCode.equalsIgnoreCase("GGDQ") || strSchemeCode.equalsIgnoreCase("TGDYA") || strSchemeCode.equalsIgnoreCase("DGDYA")
						|| strSchemeCode.equalsIgnoreCase("TGDKA") || ((strPrdType.equalsIgnoreCase("pG") && stragriproduct.equalsIgnoreCase("Y"))
								&& !(strSchemeCode.equalsIgnoreCase("JGAQK")||strSchemeCode.equalsIgnoreCase("JGGQK"))))
					strNextIntDmdDate=Helper.addMonthWithDate(currentDate, 12);
				
				
				strNextIntRunDateDR=strNextIntDmdDate;
				
				
				/*if(!strIntFreqTypeDR.equalsIgnoreCase("y"))
				{
					if(rs3 !=null)
					{
						rs3.close();
					}
					strQuery3=SQLParser.getSqlQuery("sel_enddate^"+strNextIntRunDateDR);
					rs3=DBUtils.executeQuery(strQuery3);
					if(rs3.next())
					{
						strNextIntRunDateDR=Helper.correctNull((String)rs3.getString("end_date"));
					}
				}*/
				strMaxAlwdAdvnLim=strSanctLim;
				if(!strPrdType.equalsIgnoreCase("pG"))
				{
					if(rs!=null)
					{
						rs.close();
					}
					/*strQuery=SQLParser.getSqlQuery("sel_sec_desc^"+strAppNo);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strDescOfSecurity=Helper.correctNull((String)rs.getString("sec_description"));
					}*/
				}
				String strMulti_schedule_num="",strSchedule_details="";
				String strFLOW_ID="PRDEM",strNUM_OF_FLOWS="",strFLOW_START_DATE="",strLR_FREQ_TYPE="",strLR_FREQ_START_DD="",strFLOW_AMT="";
				String strNEXT_INT_DMD_DATE="",strLR_INT_FREQ_START_DD="";
				String strColumnDelimitor="^",strRowDelimitor="~";
				//Other than EMI Account Opening
				//Commented by Anees on 23/04/2014 as told by Prakash - since for OD accounts this calculation is not required
				/*if(strLoanRepaymentType.equalsIgnoreCase("1"))
				{
					//EMI
					strMulti_schedule_num="1";
					strSchedule_details=null;
				}
				else
				{
					//Other than EMI
					
					//Otherthan EI
					if(rs!=null)
					{
						rs.close();
					}
					strQuery=SQLParser.getSqlQuery("sel_multi_schedule_num^"+strAppNo+"^"+"1");
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strMulti_schedule_num=Helper.correctNull((String)rs.getString("multi_schedule_num"));
					}
					if(rs!=null)
					{
						rs.close();
					}
					if(Integer.parseInt(Helper.correctInt(strMulti_schedule_num))>0)
					{
						strQuery=SQLParser.getSqlQuery("selflowstart_date^"+strAppNo+"^"+"1");
						rs=DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							strFLOW_START_DATE=Helper.correctNull((String)rs.getString("flow_start_date"));
							strLR_FREQ_START_DD=Helper.correctNull((String)rs.getString("lr_freq_start_dd"));
						}
						if(rs!=null)
						{
							rs.close();
						}
						strQuery=SQLParser.getSqlQuery("sel_tl_repayschedule_loanaccount^"+strAppNo+"^"+"1");
						rs=DBUtils.executeQuery(strQuery);
						if(Integer.parseInt(Helper.correctInt(strMulti_schedule_num))==1)
						{
							if(rs.next())
							{
								strNUM_OF_FLOWS=Helper.correctNull((String)rs.getString("num_of_flows"));
								strLR_FREQ_TYPE=Helper.correctNull((String)rs.getString("lr_freq_type"));
								strFLOW_AMT=Helper.correctNull((String)rs.getString("flow_amt"));
								
								strNEXT_INT_DMD_DATE=Helper.getIntDmdDate(strCurrentDate,strIntFreqTypeDR);
								
								if(!strNEXT_INT_DMD_DATE.equalsIgnoreCase(""))
								{
									strNEXT_INT_DMD_DATE=strNEXT_INT_DMD_DATE.replace("/", "-");
									strLR_INT_FREQ_START_DD=strNEXT_INT_DMD_DATE.substring(0,2);
								}
								else
								{
									strNEXT_INT_DMD_DATE="";strLR_INT_FREQ_START_DD="";
								}
								
								if(!strFLOW_START_DATE.equalsIgnoreCase(""))
								{
									//"select_month_enddate"
									String strMonthEndDate="";
									String strMonthend=SQLParser.getSqlQuery("select_month_enddate^"+strFLOW_START_DATE+"^"+strFLOW_START_DATE);
									ResultSet rsmonthend=DBUtils.executeQuery(strMonthend);
									if(rsmonthend.next())
									{
										strMonthEndDate=Helper.correctNull((String)rsmonthend.getString("next_int_dmd_date"));
									}
									if(strMonthEndDate.equalsIgnoreCase(strFLOW_START_DATE))
									{
										strLR_FREQ_START_DD="31";
									}
								}
								if(!strNEXT_INT_DMD_DATE.equalsIgnoreCase(""))
								{
									//"select_month_enddate"
									String strMonthEndDate="";
									String strMonthend=SQLParser.getSqlQuery("select_month_enddate^"+strNEXT_INT_DMD_DATE+"^"+strNEXT_INT_DMD_DATE);
									ResultSet rsmonthend=DBUtils.executeQuery(strMonthend);
									if(rsmonthend.next())
									{
										strMonthEndDate=Helper.correctNull((String)rsmonthend.getString("next_int_dmd_date"));
									}
									if(strMonthEndDate.equalsIgnoreCase(strNEXT_INT_DMD_DATE))
									{
										strLR_INT_FREQ_START_DD="31";
									}
								}
								
								strSchedule_details=strFLOW_ID+strColumnDelimitor+strNUM_OF_FLOWS+strColumnDelimitor+strFLOW_START_DATE+
									strColumnDelimitor+strLR_FREQ_TYPE+strColumnDelimitor+strLR_FREQ_START_DD+strColumnDelimitor+strFLOW_AMT+
									strColumnDelimitor+strNEXT_INT_DMD_DATE+strColumnDelimitor+strIntFreqTypeDR+strColumnDelimitor+strLR_INT_FREQ_START_DD;
							}
						}
						else
						{
							int i=0;
							while(rs.next())
							{
								int inttempmonths=0;
								if(i>0)
								{
									if(strLR_FREQ_TYPE.equalsIgnoreCase("m"))
									{
										inttempmonths=Integer.parseInt(Helper.correctInt(strNUM_OF_FLOWS))*1;
									}
									else if(strLR_FREQ_TYPE.equalsIgnoreCase("q"))
									{
										inttempmonths=Integer.parseInt(Helper.correctInt(strNUM_OF_FLOWS))*3;
									}
									else if(strLR_FREQ_TYPE.equalsIgnoreCase("h"))
									{
										inttempmonths=Integer.parseInt(Helper.correctInt(strNUM_OF_FLOWS))*6;
									}
									else if(strLR_FREQ_TYPE.equalsIgnoreCase("y"))
									{
										inttempmonths=Integer.parseInt(Helper.correctInt(strNUM_OF_FLOWS))*12;
									}
									else
									{
										inttempmonths=0;
									}
									String strQuery7=SQLParser.getSqlQuery("sel_flowstartdate_loanaccount^"+strFLOW_START_DATE+"^"+inttempmonths+"^"+strFLOW_START_DATE+"^"+inttempmonths);
									ResultSet rs7=DBUtils.executeQuery(strQuery7);
									if(rs7.next())
									{
										strFLOW_START_DATE=Helper.correctNull((String)rs7.getString("flow_start_date"));
										strLR_FREQ_START_DD=Helper.correctNull((String)rs7.getString("lr_freq_start_dd"));
									}
									if(rs7!=null)
									{
										rs7.close();
									}
									strQuery7=SQLParser.getSqlQuery("sel_flowstartdate_loanaccount^"+strNEXT_INT_DMD_DATE+"^"+inttempmonths+"^"+strNEXT_INT_DMD_DATE+"^"+inttempmonths);
									rs7=DBUtils.executeQuery(strQuery7);
									if(rs7.next())
									{
										strNEXT_INT_DMD_DATE=Helper.correctNull((String)rs7.getString("flow_start_date"));
										strLR_INT_FREQ_START_DD=Helper.correctNull((String)rs7.getString("lr_freq_start_dd"));
									}
									if(rs7!=null)
									{
										rs7.close();
									}
								}
								strNUM_OF_FLOWS=Helper.correctNull((String)rs.getString("num_of_flows"));
								strLR_FREQ_TYPE=Helper.correctNull((String)rs.getString("lr_freq_type"));
								strFLOW_AMT=Helper.correctNull((String)rs.getString("flow_amt"));
								if(i==0)
								{
									strNEXT_INT_DMD_DATE=Helper.getIntDmdDate(strCurrentDate,strIntFreqTypeDR);
									if(!(strIntFreqTypeDR.equalsIgnoreCase("y") || strIntFreqTypeDR.equalsIgnoreCase("h")))
									{
										strNEXT_INT_DMD_DATE=Helper.getMQHDate(strIntFreqTypeDR);
									}
									if(!strNEXT_INT_DMD_DATE.equalsIgnoreCase(""))
									{
										strNEXT_INT_DMD_DATE=strNEXT_INT_DMD_DATE.replace("/", "-");
										strLR_INT_FREQ_START_DD=strNEXT_INT_DMD_DATE.substring(0,2);
									}
									else
									{
										strNEXT_INT_DMD_DATE="";strLR_INT_FREQ_START_DD="";
									}
								}
								
								if(!strFLOW_START_DATE.equalsIgnoreCase(""))
								{
									//"select_month_enddate"
									String strMonthEndDate="";
									String strMonthend=SQLParser.getSqlQuery("select_month_enddate^"+strFLOW_START_DATE+"^"+strFLOW_START_DATE);
									ResultSet rsmonthend=DBUtils.executeQuery(strMonthend);
									if(rsmonthend.next())
									{
										strMonthEndDate=Helper.correctNull((String)rsmonthend.getString("next_int_dmd_date"));
									}
									if(strMonthEndDate.equalsIgnoreCase(strFLOW_START_DATE))
									{
										strLR_FREQ_START_DD="31";
									}
								}
								if(!strNEXT_INT_DMD_DATE.equalsIgnoreCase(""))
								{
									//"select_month_enddate"
									String strMonthEndDate="";
									String strMonthend=SQLParser.getSqlQuery("select_month_enddate^"+strNEXT_INT_DMD_DATE+"^"+strNEXT_INT_DMD_DATE);
									ResultSet rsmonthend=DBUtils.executeQuery(strMonthend);
									if(rsmonthend.next())
									{
										strMonthEndDate=Helper.correctNull((String)rsmonthend.getString("next_int_dmd_date"));
									}
									if(strMonthEndDate.equalsIgnoreCase(strNEXT_INT_DMD_DATE))
									{
										strLR_INT_FREQ_START_DD="31";
									}
								}
								
								if(strSchedule_details.equalsIgnoreCase(""))
								{
									strSchedule_details=strFLOW_ID+strColumnDelimitor+strNUM_OF_FLOWS+strColumnDelimitor+strFLOW_START_DATE+
									strColumnDelimitor+strLR_FREQ_TYPE+strColumnDelimitor+strLR_FREQ_START_DD+strColumnDelimitor+strFLOW_AMT+
									strColumnDelimitor+strNEXT_INT_DMD_DATE+strColumnDelimitor+strIntFreqTypeDR+strColumnDelimitor+strLR_INT_FREQ_START_DD;
								}
								else
								{
									strSchedule_details=strSchedule_details+strRowDelimitor+strFLOW_ID+strColumnDelimitor+strNUM_OF_FLOWS+strColumnDelimitor+strFLOW_START_DATE+
									strColumnDelimitor+strLR_FREQ_TYPE+strColumnDelimitor+strLR_FREQ_START_DD+strColumnDelimitor+strFLOW_AMT+
									strColumnDelimitor+strNEXT_INT_DMD_DATE+strColumnDelimitor+strIntFreqTypeDR+strColumnDelimitor+strLR_INT_FREQ_START_DD;
								}
								i++;
							}
						}
						
						if(rs!=null)
						{
							rs.close();
						}
					}
					
				}*/
				
				/*SanctionDetails="";
				SanctionDetails=strCustCBSId+"|"+strSchemeCode+"|"+strGLSubHeadCode+"|"+strModeOfOperCode+"|"+strPBPSCode+"|"+
								strPSFreqType+"|"+strPSFreqWeekDay+"|"+strFreqStartDD+"|"+strFreqHldyStat+"|"+strPSDespatchMode+"|"+
								strIntTBLCode+"|"+strIDDRPrefPerc+"|"+strIntFreqTypeDR+"|"+strIntFreqStartDDDR+"|"+strIntFreqHldyStatDR+"|"+
								strNextIntRunDateDR+"|"+strSanctLim+"|"+strSanctLim+"|"+strSanctLim+"|"+strLimSanctDate+"|"+
								strLimExpDate+"|"+strLoanPaperDate+"|"+strSanctLevlCode+"|"+strSanctAuthCode+"|"+strSanctRefNum+"|"+
								strDescOfSecurity+"|"+strDrwngPowerInd+"|"+strLimitB2kid+"|"+strDrwngPowerPcnt+"|"+strDrwngPower+"|"+
								strFreeCode6+"|"+strFreeCode7+"|"+strFreeCode8;
				String strGetCurDateTime=Helper.getCurrentDateTime();
				String[] strSplitted=strGetCurDateTime.split("/");
				String strDateVal="";
				for(int z=0;z<strSplitted.length;z++)
				{
					strDateVal=strDateVal+strSplitted[z];
				}
				strFile="ACC"+strDateVal+"_"+strAppNo+".TXT";
				strFileName = strPath + "/" +strFile;
				File file = new File(strFileName);
				RandomAccessFile raf = new RandomAccessFile(file, "rw");
				raf.seek(file.length());
				raf.writeBytes(SanctionDetails);
				raf.writeBytes("\n");
				raf.close();*/
				/*hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId", "deleteAccountHandOffDetails");
				arrValues.add(strAppNo);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);*/
				
				String strSecid="",strQuery8="";
				ResultSet rs8=null;
				strQuery8=SQLParser.getSqlQuery("sel_securityid^"+strAppNo+"^1");
				rs8=DBUtils.executeQuery(strQuery8);
				if(rs8.next())
				{
					strSecid=Helper.correctNull((String)rs8.getString("APP_SEC_SECID"));
				}
				if(rs8!=null)
				{rs8.close();}
				strQuery8=SQLParser.getSqlQuery("sel_securitycbscode^"+Helper.correctInt((String)strSecid));
				rs8=DBUtils.executeQuery(strQuery8);
				if(rs8.next())
				{
					strSecurityCode=Helper.correctNull((String)rs8.getString("sec_cbssecurity"));
				}
				if(rs8!=null)
				{rs8.close();}
				
				if(strStaffId.equalsIgnoreCase("Y"))
				{
					strFile=strStaffNumber;
				}
				else
				{
					strFile="PF"+strFile;
				}
				
				
				//Added by Guhan for Relationship type addition
				if(rs!=null)rs.close();
				String strRelationType ="";
				strQuery = SQLParser.getSqlQuery("sel_relation_type_ret^"+strAppNo);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					if(strRelationType.equalsIgnoreCase(""))
					{
						strRelationType = Helper.correctNull((String)rs.getString("relation_type"));
					}
					else
					{
						strRelationType = strRelationType+"~"+Helper.correctNull((String)rs.getString("relation_type"));
					}
				}
				//End
				
				//Interest servised should NULL the Interest demand date
				if(strLoanServised.equalsIgnoreCase("y"))
				{
					strIDMDEffDate="";
				}
				
				if(strPrdType.equalsIgnoreCase("pR"))
				{
					if(rs!=null)rs.close();
					strQuery2=SQLParser.getSqlQuery("sel_AccFlatFileData4^"+strAppNo);
					rs=DBUtils.executeQuery(strQuery2);
					if(rs.next())
					{
						strIDMDEffDate=Helper.correctNull((String)rs.getString("loan_matdate"));
					}
				}
				
				
				//DSA - BSA ID taken from appinwardreg table
				if(rs!=null)rs.close();
				strQuery = SQLParser.getSqlQuery("sel_inward_proposed_values^"+strAppNo);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strDSAID=Helper.correctNull(rs.getString("inward_agentid"));
				}
				
				if(strPrdType.equalsIgnoreCase("pR"))
				{
					if(rs!=null)rs.close();
					strQuery = SQLParser.getSqlQuery("sel_loanagainstdeposit^"+strAppNo);
					rs = DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						if((strDepDetails.toString()).equalsIgnoreCase(""))
						{
							strDepDetails=strDepDetails.append(Helper.correctNull(rs.getString("loan_accno")));
							strDepAmt=strDepAmt.append(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("loan_presentos")))));
						}
						else
						{
							strDepDetails=strDepDetails.append("|").append(Helper.correctNull(rs.getString("loan_accno")));
							strDepAmt=strDepAmt.append("|").append(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("loan_presentos")))));
						}
					}
				}
				
				if(strPrdType.equalsIgnoreCase("pG"))
				{
					if(rs!=null)
					rs.close();
					strQuery = SQLParser.getSqlQuery("sel_goldwight^" + strAppNo);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strGoldRate=Helper.formatDoubleValue(rs.getDouble("netval"));
					}
				}
				if(rs!=null)
					rs.close();
				
					strQuery = SQLParser.getSqlQuery("sel_retmclrresetfreq^"+ strAppNo);
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) {
						strSchemeCode = Helper.correctNull((String) rs.getString("loan_mclrtabcode"));
						if (strSchemeCode.equalsIgnoreCase("AGSEC")|| strSchemeCode.equalsIgnoreCase("NGSEC")	|| strSchemeCode.equalsIgnoreCase("ATBIL")|| strSchemeCode.equalsIgnoreCase("NTBIL")) {
							strResetFreqFlag = "Q";
						}else{
							strResetFreqFlag=strResetFreqFlag;
						}
					}
					if(rs!=null)
						rs.close();
					strQuery=SQLParser.getSqlQuery("sel_AccFlatFileData1^"+strAppNo);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						SchemeCode=Helper.correctNull((String)rs.getString("scheme_code"));
						
					}
				
				hshQueryValues=new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
				{
					hshQuery.put("strQueryId","ins_FinacleAccCreation_newconnection");
				}
				else
				{
				hshQuery.put("strQueryId", "ins_FinacleAccCreation");
				}
				arrValues.add(strAppNo);//1
				arrValues.add(strCustCBSId);//2
				arrValues.add(SchemeCode);//3
				arrValues.add(strGLSubHeadCode);//4
				arrValues.add(strModeOfOperCode);//5
				arrValues.add(strPBPSCode);//6
				arrValues.add(strIntTBLCode);//7
				arrValues.add(strIDDRPrefPerc);//8
				arrValues.add(strSanctLim);//9
				arrValues.add(strRepPrdMths);//10
				arrValues.add(strRepPrdDays);//11
				arrValues.add(strOpAcId);//12 for Operative account nmbr
				arrValues.add(strIDMDEffDate);//13
				arrValues.add(strIntOnIDMDFlag);//14
				arrValues.add(strNumOfFlows);//15
				arrValues.add(strLRFreqType.toUpperCase());//16
				arrValues.add(strFlowStartDate);//17
				arrValues.add(strFlowAmt);//18
				arrValues.add(strLRIntFreqType);//19
				arrValues.add(strNextIntDmdDate);//20
				arrValues.add(strLimSanctDate);//21
				arrValues.add(strLimExpDate);//22
				arrValues.add(strLoanPaperDate);//23
				arrValues.add(strSanctLevlCode);//24
				arrValues.add(strSanctAuthCode);//25
				arrValues.add(strSanctRefNum);//26
				arrValues.add(strDescOfSecurity);//27
				arrValues.add(strDrwngPowerInd);//28
				arrValues.add(strLimitB2kid);//29
				arrValues.add(strDrwngPowerPcnt);//30
				arrValues.add(strDrwngPower);//31
				arrValues.add(strFreeCode6);//32
				arrValues.add(strFreeCode7);//33
				arrValues.add(strFreeCode8);//34
				arrValues.add(strMaxAlwdAdvnLim);//35
				arrValues.add(strPSFreqType);//36
				arrValues.add(strPSFreqWeekDay);//37
				arrValues.add(strFreqStartDD);//38
				arrValues.add(strFreqHldyStat);//39
				arrValues.add(strPSDespatchMode);//40
				arrValues.add(strIntFreqTypeDR);//41
				arrValues.add(strIntFreqStartDDDR);//42
				arrValues.add(strIntFreqHldyStatDR);//43
				arrValues.add(strNextIntRunDateDR);//44
				arrValues.add(strForAcID);//45
				arrValues.add(strSolID);//46
				arrValues.add(strLocalCallFlg);//47
				arrValues.add(strSectorCode);//48
				arrValues.add(strSubSectorCode);//49
				arrValues.add(strAcctOccpCode);//50
				arrValues.add(strBorrowerCatCode);//51
				arrValues.add(strAdvancePurpose);//52
				arrValues.add(strAdvanceMode);//53
				arrValues.add(strAdvanceType);//54
				arrValues.add(strAdvanceNature);//55
				arrValues.add(strGuarCoverCode);//56
				arrValues.add(strBSROccuCode);//57
				arrValues.add(strLBRCode);//58
				arrValues.add(strServiceAreaCode);//59
				arrValues.add(strLandHoldCode);//60
				arrValues.add(strBankScheme);//61
				arrValues.add(strSCSTCode);//62
				arrValues.add(strMinorityCode);//63
				arrValues.add(strSensitiveSectorCode);//64
				arrValues.add(strSecurityCode);//65
				arrValues.add(strDeptCode);//66
				arrValues.add(strFreeCode3);//67
				arrValues.add(strLRFreqStartDD);//68
				arrValues.add(strLrIntFreqHldyStat);//69
				arrValues.add(strHealthCode);//70
				arrValues.add(strRenewFlg);//71
				arrValues.add(strProcessedFlg);//72
				arrValues.add(strSNo);//73
				arrValues.add(strMulti_schedule_num);//74
				arrValues.add(strSchedule_details);//75
				arrValues.add(strFile);//76
				arrValues.add(strRelationType);//77
				arrValues.add(strResetFreqFlag);
				arrValues.add(strSHGCode);
				arrValues.add(strGovtSponsSch);
				arrValues.add(strDSAID);
				arrValues.add(strDepDetails.toString());
				arrValues.add(strDepAmt.toString());
				arrValues.add(strGoldRate);
				arrValues.add(strLoanMargin);
				arrValues.add("");
				arrValues.add(activityCode);
				arrValues.add(alliedactivityCode);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				
				if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
				{
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateCBSData");
					
				}
				else
				{
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					
				}
				
				hshQueryValues=new HashMap();
				hshQuery=new HashMap();
				hshQuery.put("strQueryId", "insertAccountHandOffDetails");
				arrValues = new ArrayList();
				arrValues.add(strAppNo);//1
				arrValues.add(strCustCBSId);//2
				arrValues.add(SchemeCode);//3
				arrValues.add(strGLSubHeadCode);//4
				arrValues.add(strModeOfOperCode);//5
				arrValues.add(strPBPSCode);//6
				arrValues.add(strIntTBLCode);//7
				arrValues.add(strIDDRPrefPerc);//8
				arrValues.add(strSanctLim);//9
				arrValues.add(strRepPrdMths);//10
				arrValues.add(strRepPrdDays);//11
				arrValues.add(strOpAcId);//12
				arrValues.add(strIDMDEffDate);//13
				arrValues.add(strIntOnIDMDFlag);//14
				arrValues.add(strNumOfFlows);//15
				arrValues.add(strLRFreqType.toUpperCase());//16
				arrValues.add(strFlowStartDate);//17
				arrValues.add(strFlowAmt);//18
				arrValues.add(strLRIntFreqType);//19
				arrValues.add(strNextIntDmdDate);//20
				arrValues.add(strLimSanctDate);//21
				arrValues.add(strLimExpDate);//22
				arrValues.add(strLoanPaperDate);//23
				arrValues.add(strSanctLevlCode);//24
				arrValues.add(strSanctAuthCode);//25
				arrValues.add(strSanctRefNum);//26
				arrValues.add(strDescOfSecurity);//27
				arrValues.add(strDrwngPowerInd);//28
				arrValues.add(strLimitB2kid);//29
				arrValues.add(strDrwngPowerPcnt);//30
				arrValues.add(strDrwngPower);//31
				arrValues.add(strFreeCode6);//32
				arrValues.add(strFreeCode7);//33
				arrValues.add(strFreeCode8);//34
				arrValues.add(strMaxAlwdAdvnLim);//35
				arrValues.add(strPSFreqType);//36
				arrValues.add(strPSFreqWeekDay);//37
				arrValues.add(strFreqStartDD);//38
				arrValues.add(strFreqHldyStat);//39
				arrValues.add(strPSDespatchMode);//40
				arrValues.add(strIntFreqTypeDR);//41
				arrValues.add(strIntFreqStartDDDR);//42
				arrValues.add(strIntFreqHldyStatDR);//43
				arrValues.add(strNextIntRunDateDR);//44
				arrValues.add(strForAcID);//45
				arrValues.add(strSolID);//46
				arrValues.add(strLocalCallFlg);//47
				arrValues.add(strSectorCode);//48
				arrValues.add(strSubSectorCode);//49
				arrValues.add(strAcctOccpCode);//50
				arrValues.add(strBorrowerCatCode);//51
				arrValues.add(strAdvancePurpose);//52
				arrValues.add(strAdvanceMode);//53
				arrValues.add(strAdvanceType);//54
				arrValues.add(strAdvanceNature);//55
				arrValues.add(strGuarCoverCode);//56
				arrValues.add(strBSROccuCode);//57
				arrValues.add(strLBRCode);//58
				arrValues.add(strServiceAreaCode);//59
				arrValues.add(strLandHoldCode);//60
				arrValues.add(strBankScheme);//61
				arrValues.add(strSCSTCode);//62
				arrValues.add(strMinorityCode);//63
				arrValues.add(strSensitiveSectorCode);//64
				arrValues.add(strSecurityCode);//65
				arrValues.add(strDeptCode);//66
				arrValues.add(strFreeCode3);//67
				arrValues.add(strLRFreqStartDD);//68
				arrValues.add(strLrIntFreqHldyStat);//69
				arrValues.add(strHealthCode);//70
				arrValues.add(strRenewFlg);//71
				arrValues.add(strProcessedFlg);//72
				arrValues.add(strSNo);//73
				arrValues.add("Y");//74
				arrValues.add(Helper.correctNull((String)hshValues.get("strUserId")));//75
				arrValues.add(strFile);//76
				arrValues.add(strMulti_schedule_num);//77
				arrValues.add(strSchedule_details);//78
				arrValues.add(strRelationType);//79
				arrValues.add(strResetFreqFlag);
				arrValues.add(strSHGCode);
				arrValues.add(strGovtSponsSch);
				arrValues.add(strDepDetails.toString());
				arrValues.add(strDepAmt.toString());
				arrValues.add(strDSAID);
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add(strGoldRate);
				arrValues.add(strLoanMargin);
				arrValues.add("");
				arrValues.add("");
				arrValues.add(activityCode);
				arrValues.add(alliedactivityCode);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				
				
				
				hshQuery=new HashMap();
				hshQuery.put("strQueryId", "update_loanduedate");
				arrValues = new ArrayList();
				arrValues.add(strLimExpDate);
				arrValues.add(strEMIamount);
				arrValues.add(nf.format(dblFinalRate));
				arrValues.add(strAppNo);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				hshQueryValues.put("size", "2");
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			hshRecord.put("SanctionDetails",SanctionDetails);
		}
		catch (Exception e)
		{
			throw new EJBException("Error Occured  " + e.getMessage());
		}
		finally
		{
			try
			{
				if (rs != null)
				{
					rs.close();
				}
				if (rs1 != null)
				{
					rs1.close();
				}
				if (rs2 != null)
				{
					rs2.close();
				}
			}
			catch (Exception e)
			{
				e.printStackTrace();
			}
		}
		return hshRecord;
	}
	public HashMap getCBSDetails(HashMap hshValues)  {
		
		java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		ResultSet rs = null;
		ResultSet rs1 = null,rs5=null;
		HashMap hshRecord = new HashMap();
		HashMap hshRecord8 = new HashMap();
		String strQuery="";
		String strQuery1="";
		ArrayList arrCol = new ArrayList();
		ArrayList arrValue = new ArrayList();
		
		ArrayList arrCol1 = new ArrayList();
		ArrayList arrValue1 = new ArrayList();
		String strApplicationNumber = "";
		String strLoanAmount="";
		String strOrgCode="";
		String strOrgName="";
		String strintratefrq="",prdcode="",strIntRate="";
		String stramtreq="",strsecval="",stractivitycode="",strlbrcode="",strsector="",stractivitysno="";
		String strmodeofadv="",strprdtype="", strMPBFAmt="", strProductType="";
		String strAppLoanType="";
		String strFacilitySno="";
		String strscheme="";
		String freeCode6="",freeCode7="",freeCode8="";
		boolean boolflag=false;
		String srtCBSSchmecode="",strFacnature="",strAccOpening="",strFacLoantype="",strCashMargin="";
		try{
			strApplicationNumber = Helper.correctNull((String)hshValues.get("appno"));
			
			if(strApplicationNumber.equalsIgnoreCase(""))
			{
				strApplicationNumber = Helper.correctNull((String)hshValues.get("hidapplno"));
				
			}
			strOrgCode=Helper.correctNull((String)hshValues.get("strOrgShortCode"));
			strOrgName=Helper.correctNull((String)hshValues.get("strOrgName"));
			prdcode=Helper.correctNull((String)hshValues.get("prdcode"));
			strAppLoanType=Helper.correctNull((String)hshValues.get("apploantype"));
			strFacilitySno=Helper.correctInt((String)hshValues.get("sel_facilitysno"));
			
			if(strAppLoanType.equalsIgnoreCase("P"))
			{
				strFacilitySno="1";	
			}
			if(strAppLoanType.equalsIgnoreCase("P"))
			{
			strQuery = SQLParser.getSqlQuery("selperprdmargin^" + strApplicationNumber);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strLoanAmount=Helper.correctDouble((String)rs.getString("loan_recmdamt"));
			}
			hshRecord.put("strLoanAmount",strLoanAmount);
			
			if(rs != null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("selectmpbfeligibleamount^" + strApplicationNumber);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strMPBFAmt=Helper.correctDouble((String)rs.getString("mpbf_eligibleamount"));
			}
			hshRecord.put("strMPBFAmt",strMPBFAmt);
			if(rs != null)
			{
				rs.close();
			}
			if(strAppLoanType.equalsIgnoreCase("P"))
			{

				if(rs != null)
				{
					rs.close();
				}
				String livedate=ApplicationParams.getStrCLPHdate();
				String postsanctionflag="";
				String applicationStatus="";
				// check when application is created
				String appcreatedate="";
				
					strQuery = SQLParser.getSqlQuery("getcreatedate^"+strApplicationNumber);
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
				strQuery = SQLParser.getSqlQuery("sel_ApplnBranch^"+strApplicationNumber);
						}else{
							strQuery = SQLParser.getSqlQuery("sel_ApplnBranchnewchk^"+strApplicationNumber);
						}
						}
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					if(!(Helper.correctNull(rs.getString("inward_applnprocessat")).equalsIgnoreCase("6")||Helper.correctNull(rs.getString("inward_applnprocessat")).equalsIgnoreCase("5")))
					{
						strOrgCode=Helper.correctNull((String)rs.getString("org_scode"));
						strOrgName=Helper.correctNull((String)rs.getString("org_name"));
					}
					else
					{
						strOrgCode="";
						strOrgName="";
					}
					if(prdcode.equalsIgnoreCase(""))
						prdcode=Helper.correctNull(rs.getString("app_prdcode"));

				}

				strQuery = SQLParser.getSqlQuery("sel_intratefreq^" + prdcode);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strintratefrq=Helper.correctDouble((String)rs.getString("prd_intrate"));
					strprdtype=Helper.correctDouble((String)rs.getString("prd_loantype"));
					strProductType=Helper.correctDouble((String)rs.getString("prd_type"));
				}
				hshRecord.put("INTRATEFREQ",strintratefrq);
				hshRecord.put("strprdtype",strprdtype);
				hshRecord.put("strProductType",strProductType);
				if(rs != null)
				{
					rs.close();
				}
			}
			
			}
			else
			{
				String livedate=ApplicationParams.getStrCLPHdate();
				String postsanctionflag="";
				String applicationStatus="";
				// check when application is created
				String appcreatedate="";
				
					strQuery = SQLParser.getSqlQuery("getcreatedate^"+strApplicationNumber);
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
				strQuery = SQLParser.getSqlQuery("sel_ApplnBranch^"+strApplicationNumber);
						}else{
							strQuery = SQLParser.getSqlQuery("sel_ApplnBranchnewchk^"+strApplicationNumber);
						}
						}
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					if(!(Helper.correctNull(rs.getString("inward_applnprocessat")).equalsIgnoreCase("6")||Helper.correctNull(rs.getString("inward_applnprocessat")).equalsIgnoreCase("5")))
					{
						strOrgCode=Helper.correctNull((String)rs.getString("org_scode"));
						strOrgName=Helper.correctNull((String)rs.getString("org_name"));
					}
					else
					{
						strOrgCode="";
						strOrgName="";
					}
				}
			}
			
			if(rs!=null)
			rs.close();
			strQuery =SQLParser.getSqlQuery("sel_misappdetails^" +strApplicationNumber+"^"+strFacilitySno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				stractivitycode=Helper.correctNull((String)rs.getString("app_activitycode"));
				
				stractivitysno=Helper.correctNull((String)rs.getString("app_activitysno"));
				
				hshRecord.put("strMISFlag","Y");
				
			}
			if(rs!=null)
			rs.close();
			strQuery =SQLParser.getSqlQuery("sel_activitylbrcode^" +stractivitycode);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strlbrcode=Helper.correctNull((String)rs.getString("ACT_LBRCODE"));
				freeCode6=Helper.correctNull(rs.getString("act_freecode6"));
				freeCode7=Helper.correctNull(rs.getString("act_freecode7"));
				freeCode8=Helper.correctNull(rs.getString("act_freecode8"));
			}
			hshRecord.put("strlbrcode",strlbrcode);
			
			/*for (int level = 1; level <=2 ; level++){
			String strlevel = Integer.toString(level);
			if(level == 1){
				strQuery =SQLParser.getSqlQuery("sel_cbsdetails7^" +strApplicationNumber+"^"+strlevel);
			}else if(level == 2){
			strQuery =SQLParser.getSqlQuery("sel_cbsdetails8^" +strApplicationNumber+"^"+strlevel);
			}*/
			strQuery =SQLParser.getSqlQuery("sel_cbsdetails^" +strApplicationNumber+"^"+strFacilitySno);
			if(rs!=null)
			rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				//arrCol1 = new ArrayList();
				hshRecord.put("appno",Helper.correctNull(rs.getString("APPNO")));
				hshRecord.put("freecode6",Helper.correctNull(rs.getString("FREECODE6")));
				hshRecord.put("freecode7",Helper.correctNull(rs.getString("FREECODE7")));
				hshRecord.put("freecode8",Helper.correctNull(rs.getString("FREECODE8")));
				hshRecord.put("modeofoper",Helper.correctNull(rs.getString("MODE_OF_OPERATION")));
				hshRecord.put("drwingpwrind",Helper.correctNull(rs.getString("DRAWING_PWR_IND")));
				hshRecord.put("drwingpwr",Helper.correctNull(rs.getString("DRAWING_PWR")));
				hshRecord.put("handoffflg",Helper.correctNull(rs.getString("ACCT_HANDOFF_COMPLETE_FLAG")));
				hshRecord.put("strAdvanceNature",Helper.correctNull(rs.getString("NATUREOFADV")));
				hshRecord.put("strAdvanceType",Helper.correctNull(rs.getString("TYPEOFADV")));
				hshRecord.put("strAdvanceMode",Helper.correctNull(rs.getString("MODEOFADV")));
				hshRecord.put("strAdvancePurpose",Helper.correctNull(rs.getString("PURPOSEOFADV")));
				hshRecord.put("strFreeCode3",Helper.correctNull(rs.getString("FREECODE3")));
				hshRecord.put("strSecurityCode",Helper.correctNull(rs.getString("SECURITYCODE")));
				hshRecord.put("strFreecode7Fincode",Helper.correctNull(rs.getString("FREECODE7FINCODE")));
				hshRecord.put("strFreecode8Fincode",Helper.correctNull(rs.getString("FREECODE8FINCODE")));
				hshRecord.put("CER_GISTOFSECURITUES",Helper.correctNull(rs.getString("CER_GISTOFSECURITUES")));
				hshRecord.put("facility_schemecode",Helper.correctNull(rs.getString("facility_schemecode")));
				hshRecord.put("facility_glsubheadcode",Helper.correctNull(rs.getString("facility_glsubheadcode")));
				hshRecord.put("LAPS_CODE_1",Helper.correctNull(rs.getString("LAPS_CODE_1")));
				hshRecord.put("LAPS_CODE_2",Helper.correctNull(rs.getString("LAPS_CODE_2")));
				hshRecord.put("LAPS_CODE_3",Helper.correctNull(rs.getString("LAPS_CODE_3")));
				
				srtCBSSchmecode =Helper.correctNull(rs.getString("facility_schemecode"));
				
				strOrgCode=Helper.correctNull(rs.getString("LOANDISBBRANCH"));
				strOrgName="";
				if(!strOrgCode.equalsIgnoreCase(""))
				{
					if(rs1!=null)
					{
						rs1.close();
					}
					strQuery1=SQLParser.getSqlQuery("selectorgname^"+strOrgCode);
					rs1=DBUtils.executeQuery(strQuery1);
					if(rs1.next())
					{
						strOrgName=Helper.correctNull((String)rs1.getString("org_name"));
					}
				}
				if(rs!=null)
				rs.close();
				strQuery =SQLParser.getSqlQuery("sel_cbsdetails^" +strApplicationNumber+"^"+strFacilitySno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strIntRate=Helper.correctNull((String)rs.getString("INTRATEFREQ"));
				}
				if(!strAppLoanType.equalsIgnoreCase("P")){
				if(strIntRate.equalsIgnoreCase(""))
				{
					strQuery = SQLParser.getSqlQuery("sel_com_facility_intfreq^" +strFacilitySno+"^"+strApplicationNumber);
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						strintratefrq=Helper.correctNull((String)rs1.getString("com_facility_intfreq"));
					}
					hshRecord.put("INTRATEFREQ",strintratefrq);
					if(rs1!=null)
					{
						rs1.close();
					}
				}	
				else
				{
					hshRecord.put("INTRATEFREQ",strIntRate);
				}

				strQuery = SQLParser.getSqlQuery("sel_com_facility_intfreq^" +strFacilitySno+"^"+strApplicationNumber);
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					strLoanAmount = jtn.format(Double.parseDouble(Helper.correctDouble((String)rs1.getString("facility_sancamt"))));
					strFacnature=Helper.correctDouble(rs1.getString("com_facnature"));
					strAccOpening=Helper.correctNull(rs1.getString("facility_accountopen"));
					strFacLoantype=Helper.correctNull(rs1.getString("com_facility_loantype"));
					hshRecord.put("strCashMargin",Helper.correctNull(rs1.getString("COM_CASHMARGIN")));
					hshRecord.put("FACILITY_HEADID",Helper.correctNull(rs1.getString("FACILITY_HEADID")));
					hshRecord.put("FACILITY_ID",Helper.correctNull(rs1.getString("FACILITY_ID")));
				}
				if(rs1!=null)
				{
					rs1.close();
				}
				}
				if(((strFacnature.equalsIgnoreCase("2") && (strFacLoantype.equalsIgnoreCase("TL") ||strFacLoantype.equalsIgnoreCase("DL"))) && strAccOpening.equalsIgnoreCase("Y")) || (strprdtype.equalsIgnoreCase("TL")|| strprdtype.equalsIgnoreCase("DL")))
				{
					hshRecord.put("strFieldFreeze","Y");
				}
				hshRecord.put("strLoanAmount",strLoanAmount);
				hshRecord.put("strMPBFAmt",strLoanAmount);
				//hshRecord.put("desc",Helper.correctNull(rs.getString("FC_DESC")));
				//arrValue1.add(arrCol1);
				//hshRecord8.put("appno",Helper.correctNull(rs.getString("APPNO")));
				//hshRecord8.put("freecode6",Helper.correctNull(rs.getString("FREECODE6")));
				//hshRecord8.put("freecode7",Helper.correctNull(rs.getString("FREECODE7")));
				//hshRecord8.put("freecode8",Helper.correctNull(rs.getString("FREECODE8")));
				//hshRecord8.put("modeofoper",Helper.correctNull(rs.getString("MODE_OF_OPERATION")));
				//hshRecord8.put("drwingpwrind",Helper.correctNull(rs.getString("DRAWING_PWR_IND")));
				//hshRecord8.put("drwingpwr",Helper.correctNull(rs.getString("DRAWING_PWR")));
				//hshRecord8.put("handoffflg",Helper.correctNull(rs.getString("ACCT_HANDOFF_COMPLETE_FLAG")));
				//hshRecord8.put("desc",Helper.correctNull(rs.getString("FC_DESC")));
			}
			else
			{
				boolflag=true;
				if(strAppLoanType.equalsIgnoreCase("P"))
				{
					if(rs!=null)
					rs.close();
					strQuery = SQLParser.getSqlQuery("sel_intratefreq^" + prdcode);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strintratefrq=Helper.correctDouble((String)rs.getString("prd_intrate"));
					}
					hshRecord.put("INTRATEFREQ",strintratefrq);

				}
				else
				{
					if(rs!=null)
					rs.close();
					strQuery = SQLParser.getSqlQuery("sel_com_facility_intfreq^" + strFacilitySno+"^"+strApplicationNumber);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strintratefrq=Helper.correctDouble((String)rs.getString("com_facility_intfreq"));
						strLoanAmount = jtn.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("facility_sancamt"))));
						strFacnature=Helper.correctDouble(rs.getString("com_facnature"));
						strAccOpening=Helper.correctNull(rs.getString("facility_accountopen"));
						strFacLoantype=Helper.correctNull(rs.getString("com_facility_loantype"));
						strCashMargin=Helper.correctNull(rs.getString("COM_CASHMARGIN"));
						hshRecord.put("FACILITY_HEADID",Helper.correctNull(rs.getString("FACILITY_HEADID")));
						hshRecord.put("FACILITY_ID",Helper.correctNull(rs.getString("FACILITY_ID")));
					}
					hshRecord.put("INTRATEFREQ",strintratefrq);
					hshRecord.put("strLoanAmount",strLoanAmount);
					hshRecord.put("strMPBFAmt",strLoanAmount);
					hshRecord.put("strCashMargin",strCashMargin);
					if(rs!=null)
					{
						rs.close();
					}
				}
				if(((strFacnature.equalsIgnoreCase("2") && (strFacLoantype.equalsIgnoreCase("TL") ||strFacLoantype.equalsIgnoreCase("DL"))) && strAccOpening.equalsIgnoreCase("Y")) || (strprdtype.equalsIgnoreCase("TL")|| strprdtype.equalsIgnoreCase("DL")))
				{
					hshRecord.put("drwingpwrind","E");
					hshRecord.put("drwingpwr",strLoanAmount);
					hshRecord.put("strFieldFreeze","Y");
				}
				else
				{
					hshRecord.put("drwingpwrind","0");
				}
				
				if(Helper.correctNull((String)hshValues.get("strProductType")).equalsIgnoreCase("pI")||Helper.correctNull((String)hshValues.get("strProductType")).equalsIgnoreCase("pR")||Helper.correctNull((String)hshValues.get("strProductType")).equalsIgnoreCase("pG"))
				{
					hshRecord.put("drwingpwrind","D");
				}
				
				hshRecord.put("freecode6",freeCode6);
				hshRecord.put("freecode7",freeCode7);
				hshRecord.put("freecode8",freeCode8);
				
				if(Helper.correctNull((String)hshValues.get("strProductType")).equalsIgnoreCase("pG"))
				{
					hshRecord.put("strFreeCode3","999");
					hshRecord.put("modeofoper","01");
					hshRecord.put("LAPS_CODE_1","99");
					hshRecord.put("LAPS_CODE_2","99");
					hshRecord.put("LAPS_CODE_3","99");
					
					if(rs!=null)
					rs.close();
					strQuery = SQLParser.getSqlQuery("sel_goldwight^" + strApplicationNumber);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						hshRecord.put("CER_GISTOFSECURITUES","Pledge of Gold ornaments of Net weight "+Helper.correctNull(rs.getString("netweight"))+" gm with Market value Rs. "+Helper.formatDoubleValue(rs.getDouble("netval")));
					}
				}
			}
			
			if(rs!=null)
			{
				rs.close();
			}
			
			//}
			//hshRecord.put("arrCust1",arrValue1);
			//hshRecord.put("hshRecord8",hshRecord8);
			hshRecord.put("strOrgCode",strOrgCode);
			hshRecord.put("strOrgName",strOrgName);
						
			if(strAppLoanType.equalsIgnoreCase("P"))
			{
			/*strQuery =SQLParser.getSqlQuery("selLoanAmt^" +strApplicationNumber);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				stramtreq=Helper.correctDouble((String)rs.getString("amtreqd"));
				strsecval=Helper.correctDouble((String)rs.getString("cloanprd"));
				hshRecord.put("stramtreq",stramtreq);
				hshRecord.put("strsecval",strsecval);
			}*/
			
			strQuery =SQLParser.getSqlQuery("getCollSecPercnt^" +strApplicationNumber);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("strSecCoverage",correctNull(rs.getString("app_totalpropcoverage")));
			}
			
			}
			if(rs != null)
			{
				rs.close();
			}
			
			strQuery =SQLParser.getSqlQuery("sel_misappclassification^" +strApplicationNumber+"^"+strFacilitySno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strsector=Helper.correctNull((String)rs.getString("app_sector"));
				
			}
			if(rs!=null)
			rs.close();
			strQuery =SQLParser.getSqlQuery("sel_ModeOfAdv^" +strApplicationNumber+"^"+strFacilitySno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strmodeofadv=Helper.correctNull(rs.getString("mis_modadv"));
			}
			if(rs != null)
			{
				rs.close();
			}
			
			if(Helper.correctNull((String)hshValues.get("strappstatus")).equalsIgnoreCase("pa"))
			{
				HashMap hshQueryValues = new HashMap();
				HashMap hshQuery = new HashMap();
				ArrayList arrValues=new ArrayList();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "updcbsdetailsmodeofadv");
				arrValues.add(strmodeofadv);
				arrValues.add(strApplicationNumber);
				arrValues.add(strFacilitySno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
			
			
			hshRecord.put("strmodeofadv", strmodeofadv);
			String strSchemeCode = "";
			
			String strLoanType="";
			if(strAppLoanType.equalsIgnoreCase("P"))
			{
			strQuery =SQLParser.getSqlQuery("sel_PrdSchemeCode^"+strApplicationNumber+"^op");
			}
			else
			{
				strQuery =SQLParser.getSqlQuery("selFacid^"+strApplicationNumber+"^"+strFacilitySno+"^"+strApplicationNumber+"^op");
			}
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strLoanType=Helper.correctNull((String)rs.getString("prd_loantype"));
				strSchemeCode=Helper.correctNull((String)rs.getString("scheme_code"));
			}
			if(strLoanType.equalsIgnoreCase("TL")||strLoanType.equalsIgnoreCase("DL"))
			{
				strLoanType="LAA";
			}
			else if(strLoanType.equalsIgnoreCase("OD"))
			{
				strLoanType="ODA";
			}
			if(!strLoanType.equalsIgnoreCase("")&&!strSchemeCode.equalsIgnoreCase(""))
			{
				if(rs != null)
				{
					rs.close();
				}
				strQuery =SQLParser.getSqlQuery("sel_TypeOfAdv^"+strLoanType+"^"+strSchemeCode);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("strAdvanceType",Helper.correctNull(rs.getString("sch_typeadv")));
				}
			}
			if(!strAppLoanType.equalsIgnoreCase("P"))
			{
				if(rs != null)
				{
					rs.close();
				}
				strQuery = SQLParser.getSqlQuery("sel_com_facility_intfreq^" + strFacilitySno+"^"+strApplicationNumber);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strscheme=Helper.correctNull((String)rs.getString("com_facility_emischeme"));
					hshRecord.put("strForexFacility",Helper.correctNull(rs.getString("com_forexfac")));
				}
				
			}else{
				if(rs != null)
				{rs.close();}
				strQuery = SQLParser.getSqlQuery("sel_intratefreq^" + prdcode);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strscheme=Helper.correctNull(rs.getString("scheme_code"));
				}
			}
			hshRecord.put("strscheme",strscheme);
			
			if(strscheme.equalsIgnoreCase("ODKCC"))
			{
				if(boolflag)
				{
					hshRecord.put("drwingpwrind","M");
				}
			}
			
			if( (strscheme.equalsIgnoreCase("ODGEN")|| strscheme.equalsIgnoreCase("ODPS") || strscheme.equalsIgnoreCase("ODPSA") || strscheme.equalsIgnoreCase("ODAG")) && (!srtCBSSchmecode.equalsIgnoreCase(""))  ) 
			{
				hshRecord.put("strscheme",srtCBSSchmecode);
				
			}
		
			if(rs!=null) rs.close();
			if(strAppLoanType.equalsIgnoreCase("P"))
			{
				hshRecord.put("app_loantype","P");
				
				strQuery = SQLParser.getSqlQuery("sel_vehicle_type_CBS^"+strApplicationNumber);
				rs= DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					if(Helper.correctNull((String)rs.getString("AUTO_CATEGORY")).equalsIgnoreCase("1"))
					{
						hshRecord.put("freecode3val","111");
					}
					else if(Helper.correctNull((String)rs.getString("AUTO_OLDVEHICLETYPE")).equalsIgnoreCase("1"))
					{
						hshRecord.put("freecode3val","112");
					}
					else if(Helper.correctNull((String)rs.getString("AUTO_OLDVEHICLETYPE")).equalsIgnoreCase("2"))
					{
						hshRecord.put("freecode3val","113");
					}
					hshRecord.put("prdpurpose",Helper.correctNull((String)rs.getString("AUTO_VEHICLETYPE")));
				}
			}
			
			//To select the post sanction parameters
//			String strTemp = "and PS_APP_SNO='"+strFacilitySno+"'";
			hshRecord.put("strEditFlag","N");
			if(strAppLoanType.equalsIgnoreCase("P"))
			{
				if(rs!=null) rs.close();
				strQuery = SQLParser.getSqlQuery("sel_pageid_PSapp^"+strApplicationNumber);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("strPostSancParam", "@"+Helper.correctNull(rs.getString("ps_modify_terms")));
				}
			}
			else
			{
				String strQueryPS = SQLParser.getSqlQuery("sel_postsanctiondet^"+strFacilitySno+"^"+strApplicationNumber);
				ResultSet rsPS = DBUtils.executeQuery(strQueryPS);
				if(rsPS.next())
				{
					hshRecord.put("strPostSancParam", Helper.correctNull(rsPS.getString("PS_MODIFY_TERMS")));
					hshRecord.put("strEditFlag","Y");
				}
			}
		}
		catch (Exception e) {
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
		hshRecord.put("strFacilitySno",strFacilitySno);
		hshRecord.put("strApplicationNumber",strApplicationNumber);
		return hshRecord;
	}
	
	public void updateCBSDetails(HashMap hshValues)
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues=new ArrayList();
		ResultSet rs=null;
		String strApplicationNumber = "";
		String strAction = "";
		String strModeOfOperation = "";
		String strDrawingPowerInd = "";
		String strDrawingPower = "";
		String strFreeCode6 = "";
		String strFreeCode7 = "";
		String strFreeCode8 = "";
		String strAcctHandOff = "";
		String strAdvanceNature = "";
		String strAdvanceType = "";
		String strAdvanceMode = "";
		String strAdvancePurpose = "";
		String strFreeCode3 = "";
		String strLoanDisbBranch = "";
		String strSecurityCode = "";
		String strintratefrq="";
		String strFreeCode7FinCode="";
		String strFreeCode8FinCode="";
		String strFreeCode7FinVal="";
		String strFreeCode8FinVal="";
		String strQuery="";
		String strLBRCode="";
		String strFreeCode7Desc="";
		String strFreeCode8Desc="";
		String stractivitycode="";
		String stractivitysno="";
		String strlbrcode="";
		String strsector="";
		String strmodeofadv="";
		String strAppend="";
		StringBuilder sbActionData=new StringBuilder();
		StringBuilder sbOldAudit = new StringBuilder();
		String strLoanType="",str_GISTOFSECURITUES="";
		String facilityschemecode="",facility_glsubheadcode="";
		try
		{
			strApplicationNumber = Helper.correctNull((String)hshValues.get("hidappno"));
			strAction = Helper.correctNull((String)hshValues.get("hidAction"));
			strModeOfOperation = Helper.correctNull((String)hshValues.get("sel_mode"));
			strDrawingPowerInd = Helper.correctNull((String)hshValues.get("sel_power_indicator"));
			strDrawingPower = Helper.correctNull((String)hshValues.get("txt_drawingpower"));
			strFreeCode6 = Helper.correctNull((String)hshValues.get("sel_freecode6"));
			strFreeCode7 = Helper.correctNull((String)hshValues.get("sel_freecode7"));
			strFreeCode8 = Helper.correctNull((String)hshValues.get("sel_freecode8"));
			strAcctHandOff = "N";
			
			strAdvanceNature=Helper.correctNull((String)hshValues.get("sel_advancenature"));
			strAdvanceType=Helper.correctNull((String)hshValues.get("sel_advancetype"));
			strAdvanceMode=Helper.correctNull((String)hshValues.get("sel_advancemode"));
			strAdvancePurpose=Helper.correctNull((String)hshValues.get("sel_advancepurpose"));
			strFreeCode3=Helper.correctNull((String)hshValues.get("sel_freecode3"));
			strLoanDisbBranch=Helper.correctNull((String)hshValues.get("hid_LoanDisbBranch"));
			strSecurityCode=Helper.correctNull((String)hshValues.get("sel_securitycode"));
			strintratefrq=Helper.correctNull((String)hshValues.get("selintrate"));
			strFreeCode7FinCode=Helper.correctNull((String)hshValues.get("hidFreeCode7"));
			strFreeCode8FinCode=Helper.correctNull((String)hshValues.get("hidFreeCode8"));
			strFreeCode7FinVal=Helper.correctNull((String)hshValues.get("hidFreeCode7FinVal"));
			strFreeCode8FinVal=Helper.correctNull((String)hshValues.get("hidFreeCode8FinVal"));
			strLBRCode=Helper.correctNull((String)hshValues.get("sel_LBRCode"));
			strFreeCode7Desc=Helper.correctNull((String)hshValues.get("hidFreeCode7Desc"));
			strFreeCode8Desc=Helper.correctNull((String)hshValues.get("hidFreeCode8Desc"));
			str_GISTOFSECURITUES=Helper.correctNull((String)hshValues.get("txt_gistofsecurities"));
			String strFacilitySno=Helper.correctInt((String)hshValues.get("sel_facilitysno"));
			strLoanType=Helper.correctNull((String)hshValues.get("apploantype"));
			facilityschemecode=Helper.correctNull((String)hshValues.get("sel_facilitybankscheme"));
			facility_glsubheadcode=Helper.correctNull((String)hshValues.get("selschemehead"));
			/***
			 * For Audit Trial Old Data - By Karthikeyan.S on 18/09/2013
			 */
			if(strFacilitySno.equalsIgnoreCase(""))
				strFacilitySno=Helper.correctInt((String)hshValues.get("hidFacSno"));
			
			strQuery=SQLParser.getSqlQuery("sel_cbsdetails^"+strApplicationNumber+"^"+strFacilitySno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				
				String strModeOfOperationOldAudit=Helper.correctNull((String)rs.getString("mode_of_operation"));
				String strDrawingPowerIndOldAudit=Helper.correctNull((String)rs.getString("drawing_pwr_ind"));
				String strDrawingPowerOldAudit=Helper.correctDouble((String)rs.getString("drawing_pwr"));
				String strintratefrqOldAudit=Helper.correctNull((String)rs.getString("intratefreq"));
				String strFreeCode3OldAudit=Helper.correctNull((String)rs.getString("freecode3"));
				String strFreeCode6OldAudit=Helper.correctNull((String)rs.getString("freecode6"));
				Helper.correctNull((String)rs.getString("freecode7"));
				Helper.correctNull((String)rs.getString("freecode8"));
				String strAdvanceNatureOldAudit=Helper.correctNull((String)rs.getString("natureofadv"));
				String strAdvanceTypeOldAudit=Helper.correctNull((String)rs.getString("typeofadv"));
				String strAdvanceModeOldAudit=Helper.correctNull((String)rs.getString("modeofadv"));
				String strAdvancePurposeOldAudit=Helper.correctNull((String)rs.getString("purposeofadv"));
				String strLBRCodeOldAudit=Helper.correctNull((String)rs.getString("lbrcode"));
				String strLoanDisbBranchOldAudit=Helper.correctNull((String)rs.getString("loandisbbranch"));
				MastApplicantBean MAB= new MastApplicantBean();
				String strModeOfOperationDescOldAudit=MAB.getMasterDesc("CBSMast", "17", strModeOfOperationOldAudit);
				String strDrawingPowerIndDescOldAudit=MAB.getMasterDesc("CBSMast", "16", strDrawingPowerIndOldAudit);
				String strAdvanceNatureDescOldAudit=MAB.getMasterDesc("CBSMast", "21", strAdvanceNatureOldAudit);
				String strAdvanceTypeDescOldAudit=MAB.getMasterDesc("CBSMast", "22", strAdvanceTypeOldAudit);
				String strAdvanceModeDescOldAudit=MAB.getMasterDesc("CBSMast", "23", strAdvanceModeOldAudit);
				String strAdvancePurposeDescOldAudit=MAB.getMasterDesc("CBSMast", "24", strAdvancePurposeOldAudit);
				String strFreeCode3DescOldAudit=MAB.getMasterDesc("StatMast", "129", strFreeCode3OldAudit);
				String strFreeCode6DescOldAudit=MAB.getMasterDesc("StatMast", "127", strFreeCode6OldAudit);
				String strLBRCodeDescOldAudit=MAB.getMasterDesc("MISMast", "21", strLBRCodeOldAudit);
				String strIntRateFreqDescOldAudit="";
				if(strintratefrqOldAudit.equalsIgnoreCase("M"))
				{
					strIntRateFreqDescOldAudit="Monthly";
				}
				else if(strintratefrqOldAudit.equalsIgnoreCase("Q"))
				{
					strIntRateFreqDescOldAudit="Quartely";
				}
				else if(strintratefrqOldAudit.equalsIgnoreCase("H"))
				{
					strIntRateFreqDescOldAudit="Half-yearly";
				}
				else if(strintratefrqOldAudit.equalsIgnoreCase("Y"))
				{
					strIntRateFreqDescOldAudit="Yearly";
				}
				String strLoanDisbBranchDescOldAudit="";
				String strFreeCode7RefNoOldAudit=Helper.correctNull((String)rs.getString("freecode7"));
				String strFreeCode8RefNoOldAudit=Helper.correctNull((String)rs.getString("freecode8"));
				strQuery=SQLParser.getSqlQuery("selectorgname^"+strLoanDisbBranchOldAudit);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strLoanDisbBranchDescOldAudit=Helper.correctNull((String)rs.getString("org_name"));
				}
				if(rs!=null)
				{
					rs.close();
				}
				String strFreeCode7DescOldAudit="";
				strQuery=SQLParser.getSqlQuery("sel_freecodedesc^1^"+strFreeCode7);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strFreeCode7DescOldAudit=Helper.correctNull((String)rs.getString("fc_desc"));
				}
				if(rs!=null)
				{
					rs.close();
				}
				String strFreeCode8DescOldAudit="";
				strQuery=SQLParser.getSqlQuery("sel_freecodedesc^2^"+strFreeCode8);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strFreeCode8DescOldAudit=Helper.correctNull((String)rs.getString("fc_desc"));
				}
				sbOldAudit.append("~Mode Of Operation=").append(strModeOfOperationDescOldAudit)
				.append("~Drawing Power Indicator=").append(strDrawingPowerIndDescOldAudit)
				.append("~Drawing Power=").append(strDrawingPowerOldAudit)
				.append("~Interest Rate Frequency=").append(strIntRateFreqDescOldAudit)
				.append("~Free Code 3=").append(strFreeCode3DescOldAudit)
				.append("~Free Code 6=").append(strFreeCode6DescOldAudit)
				.append("~Free Code 7=").append(strFreeCode7DescOldAudit)
				.append("~Free Code 8=").append(strFreeCode8DescOldAudit)
				.append("~Nature Of Advance=").append(strAdvanceNatureDescOldAudit)
				.append("~Type Of Advance=").append(strAdvanceTypeDescOldAudit)
				.append("~Mode Of Advance=").append(strAdvanceModeDescOldAudit)
				.append("~Purpose Of Advance=").append(strAdvancePurposeDescOldAudit)
				.append("~LBR Code=").append(strLBRCodeDescOldAudit)
				.append("~Loan Disbursing Branch=").append(strLoanDisbBranchDescOldAudit)
				.append("~Facility Sno=").append(strFacilitySno);
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
				
				if(strFreeCode7FinCode.equalsIgnoreCase(""))
				{
					strQuery=SQLParser.getSqlQuery("sel_FreeCodeFinData^"+strFreeCode7+"^"+strFreeCode7FinVal);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strFreeCode7FinCode=Helper.correctNull((String)rs.getString("fc_code"));
					}
				}
				if(rs!=null)
				{
					rs.close();
				}
				if(strFreeCode8FinCode.equalsIgnoreCase(""))
				{
					strQuery=SQLParser.getSqlQuery("sel_FreeCodeFinData^"+strFreeCode8+"^"+strFreeCode8FinVal);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strFreeCode8FinCode=Helper.correctNull((String)rs.getString("fc_code"));
					}
				}
				
				if(!strFacilitySno.equalsIgnoreCase("") && !strFacilitySno.equalsIgnoreCase("0")){
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "setcbsdetailsdel");
				arrValues.add(strApplicationNumber);
				arrValues.add(strFacilitySno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
				//To get the LBR code and Mode of advance by Guhan on 12.10.2015
				strQuery = SQLParser.getSqlQuery("selmisappdetails^"+strApplicationNumber+"^"+strFacilitySno+"^ ");
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					stractivitycode=Helper.correctNull((String)rs.getString("app_activitycode"));
					stractivitysno=Helper.correctNull((String)rs.getString("app_activitysno"));
				}
				
				if(!(strApplicationNumber.equalsIgnoreCase("") || stractivitycode.equalsIgnoreCase("") || stractivitysno.equalsIgnoreCase("")))
				{
					strQuery =SQLParser.getSqlQuery("sel_activitylbrcode^" +stractivitycode);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strlbrcode=Helper.correctNull((String)rs.getString("ACT_LBRCODE"));
					}
					if(rs != null)
					{
						rs.close();
					}
					
					strAppend = ",MIS_APPCLASSIFICATION where APP_NO='"+strApplicationNumber+"' and APP_FACILITY_SNO='"+strFacilitySno+"' and MIS_SNO=APP_MISMASTER_SNO";
					strQuery =SQLParser.getSqlQuery("sel_ModeOfAdv_mastersno^"+strAppend);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strmodeofadv=Helper.correctNull((String)rs.getString("MIS_MODEADV"));
					}
					if(rs != null)
					{
						rs.close();
					}
				}
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strApplicationNumber);
				arrValues.add(strFreeCode6);
				arrValues.add(strFreeCode7);
				arrValues.add(strFreeCode8);
				arrValues.add(strModeOfOperation);
				arrValues.add(strDrawingPowerInd);
				arrValues.add(strDrawingPower);
				arrValues.add(strAcctHandOff);
				arrValues.add(strAdvanceNature);
				arrValues.add(strAdvanceType);
				arrValues.add(strmodeofadv);
				arrValues.add(strAdvancePurpose);
				arrValues.add(strFreeCode3);
				arrValues.add(strLoanDisbBranch);
				arrValues.add(strSecurityCode);
				arrValues.add(strintratefrq);
				arrValues.add(strFreeCode7FinCode);
				arrValues.add(strFreeCode8FinCode);
				arrValues.add(strlbrcode);
				arrValues.add(strFacilitySno);
				arrValues.add(str_GISTOFSECURITUES);
				arrValues.add(facilityschemecode);
				arrValues.add(facility_glsubheadcode);
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_lapscode1")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_lapscode2")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_lapscode3")));
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","ins_cbsdetails");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
		  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
			}
			else if(strAction.equalsIgnoreCase("delete")){
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "setcbsdetailsdel");
				arrValues.add(strApplicationNumber);
				arrValues.add(strFacilitySno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			/***
			 * For Audit Trial New Data - By Karthikeyan.S on 18/09/2013
			 */
			MastApplicantBean MAB= new MastApplicantBean();
			String strModeOfOperationDesc=MAB.getMasterDesc("CBSMast", "17", strModeOfOperation);
			String strDrawingPowerIndDesc=MAB.getMasterDesc("CBSMast", "16", strDrawingPowerInd);
			String strAdvanceNatureDesc=MAB.getMasterDesc("CBSMast", "21", strAdvanceNature);
			String strAdvanceTypeDesc=MAB.getMasterDesc("CBSMast", "22", strAdvanceType);
			String strAdvanceModeDesc=MAB.getMasterDesc("CBSMast", "23", strAdvanceMode);
			String strAdvancePurposeDesc=MAB.getMasterDesc("CBSMast", "24", strAdvancePurpose);
			String strFreeCode3Desc=MAB.getMasterDesc("StatMast", "129", strFreeCode3);
			String strFreeCode6Desc=MAB.getMasterDesc("StatMast", "127", strFreeCode6);
			String strLBRCodeDesc=MAB.getMasterDesc("MISMast", "21", strLBRCode);
			String strIntRateFreqDesc="";
			if(strintratefrq.equalsIgnoreCase("M"))
			{
				strIntRateFreqDesc="Monthly";
			}
			else if(strintratefrq.equalsIgnoreCase("Q"))
			{
				strIntRateFreqDesc="Quartely";
			}
			else if(strintratefrq.equalsIgnoreCase("H"))
			{
				strIntRateFreqDesc="Half-yearly";
			}
			else if(strintratefrq.equalsIgnoreCase("Y"))
			{
				strIntRateFreqDesc="Yearly";
			}
			String strLoanDisbBranchDesc="";
			strQuery=SQLParser.getSqlQuery("selectorgname^"+strLoanDisbBranch);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strLoanDisbBranchDesc=Helper.correctNull((String)rs.getString("org_name"));
			}
			sbActionData.append("~Mode Of Operation=").append(strModeOfOperationDesc)
					.append("~Drawing Power Indicator=").append(strDrawingPowerIndDesc)
					.append("~Drawing Power=").append(strDrawingPower)
					.append("~Interest Rate Frequency=").append(strIntRateFreqDesc)
					.append("~Free Code 3=").append(strFreeCode3Desc)
					.append("~Free Code 6=").append(strFreeCode6Desc)
					.append("~Free Code 7=").append(strFreeCode7Desc)
					.append("~Free Code 8=").append(strFreeCode8Desc)
					.append("~Nature Of Advance=").append(strAdvanceNatureDesc)
					.append("~Type Of Advance=").append(strAdvanceTypeDesc)
					.append("~Mode Of Advance=").append(strAdvanceModeDesc)
					.append("~Purpose Of Advance=").append(strAdvancePurposeDesc)
					.append("~LBR Code=").append(strLBRCodeDesc)
					.append("~Loan Disbursing Branch=").append(strLoanDisbBranchDesc)
					.append("~Facility Sno=").append(strFacilitySno);
			AuditTrial.auditNewLog(hshValues, "233", strApplicationNumber, sbActionData.toString(), sbOldAudit.toString());
			/***
			 * End - Audit Trial New Data
			 */
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
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
	}
	public HashMap getFreeCodeData(HashMap hshValues) 
	{
		ResultSet rs=null;
		ArrayList arrCol=new ArrayList();
		ArrayList arrRow=new ArrayList();
		String strQuery="";
		int i=0;
		try
		{
			String strLevel=Helper.correctNull((String)hshValues.get("strLevel"));
			String strParentRefNo=Helper.correctNull((String)hshValues.get("strParentRefNo"));
			if(strParentRefNo.equalsIgnoreCase(""))
			{
				strParentRefNo="0";
			}
			String strSelectedValue=Helper.correctNull((String)hshValues.get("selFreeCodeVal"));
			strQuery=SQLParser.getSqlQuery("sel_freecodes^" + strLevel + "^" + strParentRefNo);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arrCol=new ArrayList();
				if(i==0)
				{
					arrCol.add("");
					arrCol.add("--Select--");
					arrCol.add("");
					arrRow.add(arrCol);
					++i;
				}
				arrCol=new ArrayList();
				arrCol.add(correctNull(rs.getString("FC_REFNO")));
				arrCol.add(correctNull(rs.getString("FC_DESC")));
				arrCol.add(correctNull(rs.getString("FC_CODE")));
				arrRow.add(arrCol);
			}
			if(arrRow.size()==0)
			{
				arrCol.add("");
				arrCol.add("--Select--");
				arrCol.add("");
				arrRow.add(arrCol);
			}
			hshValues.put("arrRow", arrRow);
			hshValues.put("strSelectedValue", strSelectedValue);
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
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshValues;
	}
 
	public void updateCORPCBSDetails(HashMap hshValues)
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues=new ArrayList();
		ResultSet rs=null;
		String strApplicationNumber = "";
		String strAction = "";
		String strModeOfOperation = "";
		String strDrawingPowerInd = "";
		String strDrawingPower = "";
		String strFreeCode6 = "";
		String strFreeCode7 = "";
		String strFreeCode8 = "";
		String strAcctHandOff = "";
		String strAdvanceNature = "";
		String strAdvanceType = "";
		String strAdvanceMode = "";
		String strAdvancePurpose = "";
		String strFreeCode3 = "";
		String strLoanDisbBranch = "";
		String strSecurityCode = "";
		String strintratefrq="";
		String strFreeCode7FinCode="";
		String strFreeCode8FinCode="";
		String strFreeCode7FinVal="";
		String strFreeCode8FinVal="";
		String strQuery="";
		String strLBRCode="";
		String strFreeCode7Desc="";
		String strFreeCode8Desc="";
		StringBuilder sbActionData=new StringBuilder();
		StringBuilder sbOldAudit = new StringBuilder();
		try
		{
			strApplicationNumber = Helper.correctNull((String)hshValues.get("hidappno"));
			strAction = Helper.correctNull((String)hshValues.get("hidAction"));
			strModeOfOperation = Helper.correctNull((String)hshValues.get("sel_mode"));
			strDrawingPowerInd = Helper.correctNull((String)hshValues.get("sel_power_indicator"));
			strDrawingPower = Helper.correctNull((String)hshValues.get("txt_drawingpower"));
			strFreeCode6 = Helper.correctNull((String)hshValues.get("sel_freecode6"));
			strFreeCode7 = Helper.correctNull((String)hshValues.get("sel_freecode7"));
			strFreeCode8 = Helper.correctNull((String)hshValues.get("sel_freecode8"));
			strAcctHandOff = "N";
			
			strAdvanceNature=Helper.correctNull((String)hshValues.get("sel_advancenature"));
			strAdvanceType=Helper.correctNull((String)hshValues.get("sel_advancetype"));
			strAdvanceMode=Helper.correctNull((String)hshValues.get("sel_advancemode"));
			strAdvancePurpose=Helper.correctNull((String)hshValues.get("sel_advancepurpose"));
			strFreeCode3=Helper.correctNull((String)hshValues.get("sel_freecode3"));
			strLoanDisbBranch=Helper.correctNull((String)hshValues.get("hid_LoanDisbBranch"));
			strSecurityCode=Helper.correctNull((String)hshValues.get("sel_securitycode"));
			strintratefrq=Helper.correctNull((String)hshValues.get("selintrate"));
			strFreeCode7FinCode=Helper.correctNull((String)hshValues.get("hidFreeCode7"));
			strFreeCode8FinCode=Helper.correctNull((String)hshValues.get("hidFreeCode8"));
			strFreeCode7FinVal=Helper.correctNull((String)hshValues.get("hidFreeCode7FinVal"));
			strFreeCode8FinVal=Helper.correctNull((String)hshValues.get("hidFreeCode8FinVal"));
			strLBRCode=Helper.correctNull((String)hshValues.get("sel_LBRCode"));
			strFreeCode7Desc=Helper.correctNull((String)hshValues.get("hidFreeCode7Desc"));
			strFreeCode8Desc=Helper.correctNull((String)hshValues.get("hidFreeCode8Desc"));
			/***
			 * For Audit Trial 
			 *//*
			strQuery=SQLParser.getSqlQuery("sel_cbsdetails^"+strApplicationNumber);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				
				String strModeOfOperationOldAudit=Helper.correctNull((String)rs.getString("mode_of_operation"));
				String strDrawingPowerIndOldAudit=Helper.correctNull((String)rs.getString("drawing_pwr_ind"));
				String strDrawingPowerOldAudit=Helper.correctDouble((String)rs.getString("drawing_pwr"));
				String strintratefrqOldAudit=Helper.correctNull((String)rs.getString("intratefreq"));
				String strFreeCode3OldAudit=Helper.correctNull((String)rs.getString("freecode3"));
				String strFreeCode6OldAudit=Helper.correctNull((String)rs.getString("freecode6"));
				Helper.correctNull((String)rs.getString("freecode7"));
				Helper.correctNull((String)rs.getString("freecode8"));
				String strAdvanceNatureOldAudit=Helper.correctNull((String)rs.getString("natureofadv"));
				String strAdvanceTypeOldAudit=Helper.correctNull((String)rs.getString("typeofadv"));
				String strAdvanceModeOldAudit=Helper.correctNull((String)rs.getString("modeofadv"));
				String strAdvancePurposeOldAudit=Helper.correctNull((String)rs.getString("purposeofadv"));
				String strLBRCodeOldAudit=Helper.correctNull((String)rs.getString("lbrcode"));
				String strLoanDisbBranchOldAudit=Helper.correctNull((String)rs.getString("loandisbbranch"));
				MastApplicantBean MAB= new MastApplicantBean();
				String strModeOfOperationDescOldAudit=MAB.getMasterDesc("CBSMast", "17", strModeOfOperationOldAudit);
				String strDrawingPowerIndDescOldAudit=MAB.getMasterDesc("CBSMast", "16", strDrawingPowerIndOldAudit);
				String strAdvanceNatureDescOldAudit=MAB.getMasterDesc("CBSMast", "21", strAdvanceNatureOldAudit);
				String strAdvanceTypeDescOldAudit=MAB.getMasterDesc("CBSMast", "22", strAdvanceTypeOldAudit);
				String strAdvanceModeDescOldAudit=MAB.getMasterDesc("CBSMast", "23", strAdvanceModeOldAudit);
				String strAdvancePurposeDescOldAudit=MAB.getMasterDesc("CBSMast", "24", strAdvancePurposeOldAudit);
				String strFreeCode3DescOldAudit=MAB.getMasterDesc("StatMast", "129", strFreeCode3OldAudit);
				String strFreeCode6DescOldAudit=MAB.getMasterDesc("StatMast", "127", strFreeCode6OldAudit);
				String strLBRCodeDescOldAudit=MAB.getMasterDesc("MISMast", "21", strLBRCodeOldAudit);
				String strIntRateFreqDescOldAudit="";
				if(strintratefrqOldAudit.equalsIgnoreCase("M"))
				{
					strIntRateFreqDescOldAudit="Monthly";
				}
				else if(strintratefrqOldAudit.equalsIgnoreCase("Q"))
				{
					strIntRateFreqDescOldAudit="Quartely";
				}
				else if(strintratefrqOldAudit.equalsIgnoreCase("H"))
				{
					strIntRateFreqDescOldAudit="Half-yearly";
				}
				else if(strintratefrqOldAudit.equalsIgnoreCase("Y"))
				{
					strIntRateFreqDescOldAudit="Yearly";
				}
				String strLoanDisbBranchDescOldAudit="";
				String strFreeCode7RefNoOldAudit=Helper.correctNull((String)rs.getString("freecode7"));
				String strFreeCode8RefNoOldAudit=Helper.correctNull((String)rs.getString("freecode8"));
				strQuery=SQLParser.getSqlQuery("selectorgname^"+strLoanDisbBranchOldAudit);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strLoanDisbBranchDescOldAudit=Helper.correctNull((String)rs.getString("org_name"));
				}
				if(rs!=null)
				{
					rs.close();
				}
				String strFreeCode7DescOldAudit="";
				strQuery=SQLParser.getSqlQuery("sel_freecodedesc^1^"+strFreeCode7RefNoOldAudit);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strFreeCode7DescOldAudit=Helper.correctNull((String)rs.getString("fc_desc"));
				}
				if(rs!=null)
				{
					rs.close();
				}
				String strFreeCode8DescOldAudit="";
				strQuery=SQLParser.getSqlQuery("sel_freecodedesc^2^"+strFreeCode8RefNoOldAudit);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strFreeCode8DescOldAudit=Helper.correctNull((String)rs.getString("fc_desc"));
				}
				sbOldAudit.append("~Mode Of Operation=").append(strModeOfOperationDescOldAudit)
				.append("~Drawing Power Indicator=").append(strDrawingPowerIndDescOldAudit)
				.append("~Drawing Power=").append(strDrawingPowerOldAudit)
				.append("~Interest Rate Frequency=").append(strIntRateFreqDescOldAudit)
				.append("~Free Code 3=").append(strFreeCode3DescOldAudit)
				.append("~Free Code 6=").append(strFreeCode6DescOldAudit)
				.append("~Free Code 7=").append(strFreeCode7DescOldAudit)
				.append("~Free Code 8=").append(strFreeCode8DescOldAudit)
				.append("~Nature Of Advance=").append(strAdvanceNatureDescOldAudit)
				.append("~Type Of Advance=").append(strAdvanceTypeDescOldAudit)
				.append("~Mode Of Advance=").append(strAdvanceModeDescOldAudit)
				.append("~Purpose Of Advance=").append(strAdvancePurposeDescOldAudit)
				.append("~LBR Code=").append(strLBRCodeDescOldAudit)
				.append("~Loan Disbursing Branch=").append(strLoanDisbBranchDescOldAudit);
			}
			if(rs!=null)
			{
				rs.close();
			}
			*//***
			 * End - Audit Trial Old Data
			 */
			if(strAction.equalsIgnoreCase("update"))
			{
				
				if(strFreeCode7FinCode.equalsIgnoreCase(""))
				{
					strQuery=SQLParser.getSqlQuery("sel_FreeCodeFinData^"+strFreeCode7+"^"+strFreeCode7FinVal);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strFreeCode7FinCode=Helper.correctNull((String)rs.getString("fc_code"));
					}
				}
				if(rs!=null)
				{
					rs.close();
				}
				if(strFreeCode8FinCode.equalsIgnoreCase(""))
				{
					strQuery=SQLParser.getSqlQuery("sel_FreeCodeFinData^"+strFreeCode8+"^"+strFreeCode8FinVal);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strFreeCode8FinCode=Helper.correctNull((String)rs.getString("fc_code"));
					}
				}
				
				
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "corpcbsdetailsdel");
				arrValues.add(strApplicationNumber);
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_facilitysno")));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strApplicationNumber);
				arrValues.add(strFreeCode6);
				arrValues.add(strFreeCode7);
				arrValues.add(strFreeCode8);
				arrValues.add(strModeOfOperation);
				arrValues.add(strDrawingPowerInd);
				arrValues.add(strDrawingPower);
				arrValues.add(strAcctHandOff);
				arrValues.add(strAdvanceNature);
				arrValues.add(strAdvanceType);
				arrValues.add(strAdvanceMode);
				arrValues.add(strAdvancePurpose);
				arrValues.add(strFreeCode3);
				arrValues.add(strLoanDisbBranch);
				arrValues.add(strSecurityCode);
				arrValues.add(strintratefrq);
				arrValues.add(strFreeCode7FinCode);
				arrValues.add(strFreeCode8FinCode);
				arrValues.add(strLBRCode);
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_facilitysno")));
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","ins_corpcbsdetails");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
		  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("delete")){
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "corpcbsdetailsdel");
				arrValues.add(strApplicationNumber);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			/***
			 * For Audit Trial New Data  
			 *//*
			MastApplicantBean MAB= new MastApplicantBean();
			String strModeOfOperationDesc=MAB.getMasterDesc("CBSMast", "17", strModeOfOperation);
			String strDrawingPowerIndDesc=MAB.getMasterDesc("CBSMast", "16", strDrawingPowerInd);
			String strAdvanceNatureDesc=MAB.getMasterDesc("CBSMast", "21", strAdvanceNature);
			String strAdvanceTypeDesc=MAB.getMasterDesc("CBSMast", "22", strAdvanceType);
			String strAdvanceModeDesc=MAB.getMasterDesc("CBSMast", "23", strAdvanceMode);
			String strAdvancePurposeDesc=MAB.getMasterDesc("CBSMast", "24", strAdvancePurpose);
			String strFreeCode3Desc=MAB.getMasterDesc("StatMast", "129", strFreeCode3);
			String strFreeCode6Desc=MAB.getMasterDesc("StatMast", "127", strFreeCode6);
			String strLBRCodeDesc=MAB.getMasterDesc("MISMast", "21", strLBRCode);
			String strIntRateFreqDesc="";
			if(strintratefrq.equalsIgnoreCase("M"))
			{
				strIntRateFreqDesc="Monthly";
			}
			else if(strintratefrq.equalsIgnoreCase("Q"))
			{
				strIntRateFreqDesc="Quartely";
			}
			else if(strintratefrq.equalsIgnoreCase("H"))
			{
				strIntRateFreqDesc="Half-yearly";
			}
			else if(strintratefrq.equalsIgnoreCase("Y"))
			{
				strIntRateFreqDesc="Yearly";
			}
			String strLoanDisbBranchDesc="";
			strQuery=SQLParser.getSqlQuery("selectorgname^"+strLoanDisbBranch);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strLoanDisbBranchDesc=Helper.correctNull((String)rs.getString("org_name"));
			}
			sbActionData.append("~Mode Of Operation=").append(strModeOfOperationDesc)
					.append("~Drawing Power Indicator=").append(strDrawingPowerIndDesc)
					.append("~Drawing Power=").append(strDrawingPower)
					.append("~Interest Rate Frequency=").append(strIntRateFreqDesc)
					.append("~Free Code 3=").append(strFreeCode3Desc)
					.append("~Free Code 6=").append(strFreeCode6Desc)
					.append("~Free Code 7=").append(strFreeCode7Desc)
					.append("~Free Code 8=").append(strFreeCode8Desc)
					.append("~Nature Of Advance=").append(strAdvanceNatureDesc)
					.append("~Type Of Advance=").append(strAdvanceTypeDesc)
					.append("~Mode Of Advance=").append(strAdvanceModeDesc)
					.append("~Purpose Of Advance=").append(strAdvancePurposeDesc)
					.append("~LBR Code=").append(strLBRCodeDesc)
					.append("~Loan Disbursing Branch=").append(strLoanDisbBranchDesc);
			AuditTrial.auditNewLog(hshValues, "233", strApplicationNumber, sbActionData.toString(), sbOldAudit.toString());
			*//***
			 * End - Audit Trial New Data
			 */
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
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
	}
	public HashMap getCORPCBSDetails(HashMap hshValues)  {
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord = new HashMap();
		HashMap hshRecord8 = new HashMap();
		String strQuery="";
		String strQuery1="";
		ArrayList arrCol = new ArrayList();
		ArrayList arrValue = new ArrayList();
		
		ArrayList arrCol1 = new ArrayList();
		ArrayList arrValue1 = new ArrayList();
		String strApplicationNumber = "";
		String strLoanAmount="";
		String strOrgCode="";
		String strOrgName="";
		String strintratefrq="",prdcode="",strIntRate="";
		String stramtreq="",strsecval="",stractivitycode="",strlbrcode="",strsector="",stractivitysno="";
		String strFacilityno="";
		String strmodeofadv="",strprdtype="", strMPBFAmt="", strProductType="";
		try{
			strApplicationNumber = Helper.correctNull((String)hshValues.get("appno"));
			strOrgCode=Helper.correctNull((String)hshValues.get("strOrgShortCode"));
			strOrgName=Helper.correctNull((String)hshValues.get("strOrgName"));
			prdcode=Helper.correctNull((String)hshValues.get("prdcode"));
			strFacilityno=Helper.correctNull((String)hshValues.get("FacilitySno")); 
		
			strQuery =SQLParser.getSqlQuery("sel_corpcbsdetails^" +strApplicationNumber+"^"+Helper.correctInt((String)hshValues.get("FacilitySno")));

			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				//arrCol1 = new ArrayList();
				hshRecord.put("appno",Helper.correctNull(rs.getString("APPNO")));
				hshRecord.put("freecode6",Helper.correctNull(rs.getString("FREECODE6")));
				hshRecord.put("freecode7",Helper.correctNull(rs.getString("FREECODE7")));
				hshRecord.put("freecode8",Helper.correctNull(rs.getString("FREECODE8")));
				hshRecord.put("modeofoper",Helper.correctNull(rs.getString("MODE_OF_OPERATION")));
				hshRecord.put("drwingpwrind",Helper.correctNull(rs.getString("DRAWING_PWR_IND")));
				hshRecord.put("drwingpwr",Helper.correctNull(rs.getString("DRAWING_PWR")));
				hshRecord.put("handoffflg",Helper.correctNull(rs.getString("ACCT_HANDOFF_COMPLETE_FLAG")));
				hshRecord.put("strAdvanceNature",Helper.correctNull(rs.getString("NATUREOFADV")));
				hshRecord.put("strAdvanceType",Helper.correctNull(rs.getString("TYPEOFADV")));
				hshRecord.put("strAdvanceMode",Helper.correctNull(rs.getString("MODEOFADV")));
				hshRecord.put("strAdvancePurpose",Helper.correctNull(rs.getString("PURPOSEOFADV")));
				hshRecord.put("strFreeCode3",Helper.correctNull(rs.getString("FREECODE3")));
				hshRecord.put("strSecurityCode",Helper.correctNull(rs.getString("SECURITYCODE")));
				hshRecord.put("strFreecode7Fincode",Helper.correctNull(rs.getString("FREECODE7FINCODE")));
				hshRecord.put("strFreecode8Fincode",Helper.correctNull(rs.getString("FREECODE8FINCODE")));
				
				strOrgCode=Helper.correctNull(rs.getString("LOANDISBBRANCH"));
				strOrgName="";
				if(!strOrgCode.equalsIgnoreCase(""))
				{
					if(rs1!=null)
					{
						rs1.close();
					}
					strQuery1=SQLParser.getSqlQuery("selectorgname^"+strOrgCode);
					rs1=DBUtils.executeQuery(strQuery1);
					if(rs1.next())
					{
						strOrgName=Helper.correctNull((String)rs1.getString("org_name"));
					}
				}
				
				hshRecord.put("FACILITY_SNO",Helper.correctNull(rs.getString("FACILITY_SNO")));
			}
			 
			if(rs!=null)
			{
				rs.close();
			}
			
			//}
			//hshRecord.put("arrCust1",arrValue1);
			//hshRecord.put("hshRecord8",hshRecord8);
			hshRecord.put("strOrgCode",strOrgCode);
			hshRecord.put("strOrgName",strOrgName);
			if(rs != null)
			{
				rs.close();
			}
			 
		}
		catch (Exception e) {
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
		hshRecord.put("strApplicationNumber",strApplicationNumber);
		return hshRecord;
	}
 
	public HashMap getAccountFlatFileReportCorpAgri(HashMap hshValues) 
	{
		HashMap hshResult=new HashMap();
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs=null;
		String strAppNo="";
		String strQuery="";
		String strLoanType="";
		String strFacilitySno="";
		String strFacilityNature="",strRenewFlg="",strProjectLoan="",strDCCODate="",strFacCateogry="";
		String strCustCBSId="",strSanctLim="",strAdvanceNature="",strSolID="",strLimit_prefix="",strLimit_suffix="",strBG_NUM="",strProcessed_flag="N";
		NumberFormat nf = NumberFormat.getInstance();
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
		nf.setGroupingUsed(false);
		try
		{
			strAppNo=Helper.correctNull((String)hshValues.get("appno"));
			if(strAppNo.equalsIgnoreCase(""))
			{
				strAppNo=Helper.correctNull((String)hshValues.get("appno1"));
			}
			if(strAppNo.equalsIgnoreCase(""))
			{
				strAppNo=Helper.correctNull((String)hshValues.get("strappno"));
			}
			strFacilitySno=Helper.correctNull((String)hshValues.get("sel_facility"));

			if(!strAppNo.equalsIgnoreCase(""))
			{
				//Added by Guhan for Relationship type addition
				String strRelationType ="";
				strQuery = SQLParser.getSqlQuery("sel_relation_type_corp_agri^"+strAppNo+"^"+strFacilitySno);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					if(strRelationType.equalsIgnoreCase(""))
					{
						strRelationType = Helper.correctNull((String)rs.getString("relation_type"));
					}
					else
					{
						strRelationType = strRelationType+"~"+Helper.correctNull((String)rs.getString("relation_type"));
					}
				}
				
				hshValues.put("strRelationType", strRelationType);
				//End
				
				
				if(rs!=null)rs.close();
				strQuery=SQLParser.getSqlQuery("sel_facility_details_interface_sno^"+strAppNo+"^"+strFacilitySno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strFacilitySno=Helper.correctNull((String)rs.getString("FACILITY_SNO"));
					strFacilityNature=Helper.correctNull((String)rs.getString("COM_FACNATURE"));
					strRenewFlg=Helper.correctNull(rs.getString("facility_typefor"));
					strFacCateogry=Helper.correctNull(rs.getString("facility_category"));
					String strcom_facid=Helper.correctNull((String)rs.getString("com_facid"));
					String strQuery1 = SQLParser.getSqlQuery("sel_otherdetails^"+strcom_facid);
					ResultSet rs1 = DBUtils.executeQuery(strQuery1);
					String strLoanaccount="",strLimitNodeType="",strBankingArrangement="";
		  			if(rs1.next())
					{
		  				strLoanaccount=Helper.correctNull((String)rs1.getString("COM_LOANACC"));
		  				strLimitNodeType=Helper.correctNull(rs1.getString("com_limtnodetype"));
					}
		  			if(strLoanaccount.equalsIgnoreCase("Y"))
		  			{
		  				if(strFacilityNature.equalsIgnoreCase("1"))//Workingcapital
						{
							hshResult=getODFlatFileReportCorpAgri(hshValues,strFacilitySno);
						}
						else//TL
						{
							hshResult=getOtherFlatFileReportCorpAgri(hshValues,strFacilitySno);
						}
		  			}else{
		  				strQuery=SQLParser.getSqlQuery("sel_facility_sanlimit^"+strAppNo+"^"+strFacilitySno);
						rs1=DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							strCustCBSId=Helper.correctNull((String)rs1.getString("perapp_cbsid"));
							strSanctLim=nf.format(Double.parseDouble(Helper.correctDouble((String)rs1.getString("FACILITY_SANCAMT"))));
							strBankingArrangement=Helper.correctNull(rs1.getString("FACILITY_PROPBANKTYPE"));
						}
						if(rs1!=null)
						rs1.close();
						strQuery=SQLParser.getSqlQuery("sel_cbsdetails_corpagri^"+strAppNo+"^"+strFacilitySno);
						rs1=DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							strAdvanceNature=Helper.correctNull((String)rs1.getString("NATUREOFADV"));
							if(strAdvanceNature.equalsIgnoreCase("01"))
							{
								strAdvanceNature="F";
							}else if(strAdvanceNature.equalsIgnoreCase("02")){
								strAdvanceNature="P";
							}else if(strAdvanceNature.equalsIgnoreCase("03")){
								strAdvanceNature="P";
							}
							strSolID=Helper.correctNull((String)rs1.getString("LOANDISBBRANCH"));
						}
						
						//Project Loan & DCCO Date
						if(rs1!=null)
						rs1.close();
						rs1=DBUtils.executeLAPSQuery("sel_management^BreifDetaisTL^"+strFacilitySno+"^"+strAppNo);
						if(rs1.next())
						{
							strProjectLoan=Helper.correctNull(rs1.getString("com_projectloan"));
							strDCCODate=Helper.correctNull(rs1.getString("com_date"));
						}
						
						hshQueryValues=new HashMap();
						hshQuery=new HashMap();
						if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
						{
							hshQuery.put("strQueryId", "ins_FinacleAccCreationNFB_newconnection");
						}
						else
						{
							hshQuery.put("strQueryId", "ins_FinacleAccCreation_NFB");
						}
						arrValues = new ArrayList();
						arrValues.add(strAppNo);//1
						arrValues.add(strFacilitySno);//2
						arrValues.add(strSolID);//3
						arrValues.add(strCustCBSId);//4
						if(strLimitNodeType.equalsIgnoreCase("BG"))
						{
							arrValues.add(strAdvanceNature);//5
						}
						else
						{
							arrValues.add(strLimitNodeType);//5
						}
						arrValues.add(strSanctLim);//6
						arrValues.add(strLimit_prefix);//7
						arrValues.add(strLimit_suffix);//8
						arrValues.add(strBG_NUM);//9
						arrValues.add(strProcessed_flag );//10
						arrValues.add(strRenewFlg );//11
						arrValues.add(strProjectLoan );//12
						arrValues.add(strDCCODate );//13
						arrValues.add(strFacCateogry);
						arrValues.add(strBankingArrangement);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("1", hshQuery);
						hshQueryValues.put("size", "1");
						if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
						{
						   EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateCBSData");
						}
						else
						{
						   EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
											
						}
						
						
						hshQueryValues=new HashMap();
						hshQuery=new HashMap();
						hshQuery.put("strQueryId", "insertAccountHandOffDetails_nfb");
						arrValues = new ArrayList();
						arrValues.add(strAppNo);//1
						arrValues.add(strFacilitySno);//2
						arrValues.add(strSolID);//3
						arrValues.add(strCustCBSId);//4
						if(strLimitNodeType.equalsIgnoreCase("BG"))
						{
							arrValues.add(strAdvanceNature);//5
						}
						else
						{
							arrValues.add(strLimitNodeType);//5
						}
						arrValues.add(strSanctLim);//6
						arrValues.add(strLimit_prefix);//7
						arrValues.add(strLimit_suffix);//8
						arrValues.add(strBG_NUM);//9
						arrValues.add(strProcessed_flag );//10
						arrValues.add(strRenewFlg );//11
						arrValues.add(strProjectLoan );//12
						arrValues.add(strDCCODate );//13
						arrValues.add(strFacCateogry);//14
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("1", hshQuery);
						hshQueryValues.put("size", "1");
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
						
						
		  			}
				}
				/*if(rs.next())
				{
					strLoanType=Helper.correctNull((String)rs.getString("prd_loantype"));
				}
				if(strLoanType.equalsIgnoreCase("TL")||strLoanType.equalsIgnoreCase("DL"))
				{
					hshResult=getOtherFlatFileReportCorpAgri(hshValues);
				}
				else if(strLoanType.equalsIgnoreCase("OD"))
				{
					hshResult=getODFlatFileReportCorpAgri(hshValues);
				}*/
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error Occured  " + e.getMessage());
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
			catch (Exception e)
			{
				e.printStackTrace();
			}
		}
		return hshResult;
	}
	public HashMap getOtherFlatFileReportCorpAgri(HashMap hshValues,String strFacilitySno) 
	{
		SimpleDateFormat sdnew=new SimpleDateFormat("dd/MM/yyyy");
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshRecord = new HashMap();
		ArrayList arrValues=new ArrayList();
		ResultSet rs=null;
		ResultSet rs1=null;
		ResultSet rs2=null;
		ResultSet rs3=null;
		ResultSet rs4=null;
		int intDateDiff = 0;
		String strDateDiff = "";
		/*File Directory = null;
		String strPath = "";
		strPath = ApplicationParams.getFlatFile();
		Directory = new File(strPath);
		if (!Directory.exists())
		{
			Directory.mkdirs();
		}*/
		String strFileName = "";
		String strFile = "";
		String strCustCBSId="";
		String strSchemeCode="",SchemeCode="";
		String strGLSubHeadCode="";
		String strModeOfOperCode="";
		String strPBPSCode="B";
		String strIntTBLCode="";
		String strIDDRPrefPerc="";
		String strSanctLim="";
		String strRepPrdMths="";
		String strRepPrdDays="0";
		String strOpAcId="";
		String strIDMDEffDate="";
		String strIntOnIDMDFlag="Y";
		String strNumOfFlows="";
		String strLRFreqType="";
		String strFlowStartDate="";
		String strFlowAmt="";
		String strLRIntFreqType="";
		String strNextIntDmdDate="";
		String strLimSanctDate="";
		String strLimExpDate="";
		String strLoanPaperDate="";
		String strSanctLevlCode="";
		String strSanctAuthCode="";
		String strSanctRefNum="";
		String strDescOfSecurity="";
		String strDrwngPowerInd="";
		String strLimitB2kid="";
		String strDrwngPowerPcnt="";
		String strDrwngPower="";
		String strFreeCode6="";
		String strFreeCode7="";
		String strFreeCode8="";
		String SanctionDetails="";
		String strExcludeHoliday="";
		String strIntType="";
		String strPrdCode="";
		String strQuery="";
		String strQuery1="";
		String strQuery2="";
		String strQuery3="";
		String strQuery4="";
		String strAppId="";
		String strAppNo="";
		String strHolidayPeriod="";
		String strPrdType="";
		String strSolID="";
		String strAdvanceNature="";
		String strAdvanceType="";
		String strAdvanceMode="";
		String strAdvancePurpose="";
		String strFreeCode3="";
		String strSecurityCode="";
		String strSectorCode="";
		String strSubSectorCode="";
		String strSensitiveSectorCode="";
		String strGuarCoverCode="";
		String strBSROccuCode="";
		String strLBRCode="";
		String strServiceAreaCode="";
		String strLandHoldCode="";
		String strBankScheme="";
		String strLrIntFreqHldyStat="P";
		String strProcessedFlg="";
		String strAcctOccpCode="";
		String strBorrowerCatCode="";
		String strSCSTCode="";
		String strLRFreqStartDD="";
		String strRenewFlg="";
		String strFreqStartDD="1";
		String strFreqHldyStat="N";
		String strPSDespatchMode="N";
		String strLocalCallFlg="N";
		String strMinorityCode="";
		String strDeptCode="";
		String strSNo="1";
		String strHealthCode="";
		String strMaxAlwdAdvnLim="";
		String strPSFreqType="M";
		String strPSFreqWeekDay="";
		String strIntFreqTypeDR="";
		String strIntFreqStartDDDR="31";
		String strIntFreqHldyStatDR="P";
		String strNextIntRunDateDR="";
		String strForAcID="";
		String strStaffId="",strResetFreqFlag="";
		double dblModIntRate=0.00, dblBaseRate=0.00, dblFloatingRate=0.00, dblRecmdAmount=0.00,dblRmdamt=0.0,dblFinalRate=0.0;
		int intNoOfFlow=0, intRepayPeriod=0, intHolidayPeriod=0, intLoanPeriod=0, intNextIntDMDDate=0;
		int intPeriod=0, intLRPeriod=0;;
		NumberFormat nf = NumberFormat.getInstance();
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
		nf.setGroupingUsed(false);
		NumberFormat nf1 = NumberFormat.getInstance();
		nf1.setMaximumFractionDigits(0);
		nf1.setMinimumFractionDigits(0);
		nf1.setGroupingUsed(false);
		Date currentDate=new Date();
		String alliedactivityCode="";
		String strValuesIn="",strINTRATEFREQ="";
		String CBSSchemecode="",CBSGLsubheadcode="";
		String strPendingPaymentMode="",strInterestCharged="",strSHGCode="",strGovtSponsSch="";
		double dblEMI=0.00;
		
		String strDSAID="",strProjectLoan="",strDCCODate="",strFITLFlag="",strBankingArrangement="",strECSBankname="",activityCode="",
			strECSAccountTYpe="",strECSIFSCCODE="",strECSOperaccnum="",strECSAuthMode="",strenachumrn="",strModeofPayment="",STRDELFLAG="N",strFREETXT="";
		try
		{
			String strfacility_repaytype="";
			String strCurrentDate=Helper.getCurrentDateTime();
			strAppNo=Helper.correctNull((String)hshValues.get("appno"));
			String strModuleType=Helper.correctNull((String)hshValues.get("sessionModuleType"));
			if(strAppNo.equalsIgnoreCase(""))
			{
				strAppNo=Helper.correctNull((String)hshValues.get("appno1"));
			}
			if(strAppNo.equalsIgnoreCase(""))
			{
				strAppNo=Helper.correctNull((String)hshValues.get("strappno"));
			}
			if(!strAppNo.equalsIgnoreCase(""))
			{
				strQuery=SQLParser.getSqlQuery("sel_facility_interfacedetails^"+strAppNo+"^"+strFacilitySno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strInterestCharged=Helper.correctNull(rs.getString("facility_interestrec"));
					strPendingPaymentMode=correctNull(rs.getString("facility_interestcharged"));
					strAppId=Helper.correctNull((String)rs.getString("perapp_id"));
					strCustCBSId=Helper.correctNull((String)rs.getString("perapp_cbsid"));
					strSchemeCode=Helper.correctNull((String)rs.getString("scheme_code"));
					String strModIntRate=Helper.correctNull((String)rs.getString("facility_sancinterest"));
					strRepPrdMths=Helper.correctNull((String)rs.getString("FACILITY_MONTHS"));
					strHolidayPeriod=Helper.correctInt((String)rs.getString("FACILITY_HOLIDAYPERIOD"));
					intLoanPeriod=Integer.parseInt(Helper.correctInt((String)strRepPrdMths));
					strLimExpDate=Helper.addMonthWithDate(currentDate, intLoanPeriod);
					intHolidayPeriod=Integer.parseInt(Helper.correctInt(strHolidayPeriod));
					intRepayPeriod=Integer.parseInt(Helper.correctInt(strRepPrdMths))-Integer.parseInt(Helper.correctInt(strHolidayPeriod));
					strExcludeHoliday=Integer.toString(intRepayPeriod);
					strSanctLim=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("FACILITY_SANCAMT"))));
					dblModIntRate=Double.parseDouble(Helper.correctDouble(strModIntRate));
					dblFinalRate=dblModIntRate;
					strIntType=Helper.correctNull((String)rs.getString("FACILITY_INTTYPE"));
					strPrdCode=Helper.correctNull((String)rs.getString("FACILITY_CODE"));
					strIntFreqTypeDR=Helper.correctNull((String)rs.getString("COM_FACILITY_INTFREQ"));
					strValuesIn=Helper.correctNull((String)rs.getString("APP_VALUESIN"));
					strfacility_repaytype=Helper.correctNull((String)rs.getString("facility_repaytype"));
					strRenewFlg=Helper.correctNull((String)rs.getString("facility_typefor"));
					strSanctLim=Helper.convertApplicationToSetup(strValuesIn, Double.parseDouble(strSanctLim));
					dblBaseRate=Double.parseDouble(Helper.correctDouble(rs.getString("facility_baserate")));
					strLimSanctDate=Helper.correctNull((String)rs.getString("app_processdate"));
					strGovtSponsSch=Helper.correctNull(rs.getString("facility_schemetype"));
					
					strECSIFSCCODE=Helper.correctNull((String)rs.getString("FACILITY_ECSIFSCCODE"));
					strECSOperaccnum=Helper.correctNull((String)rs.getString("FACILITY_ECSOPERACCNUM"));
					strModeofPayment=Helper.correctNull((String)rs.getString("FACILITY_MODEOFREPAY"));
					
					strECSAccountTYpe=Helper.correctNull((String)rs.getString("FACILITY_ECSACCOUNTTYPE"));
					if(!strECSAccountTYpe.equalsIgnoreCase(""))
					{
						if(strECSAccountTYpe.equalsIgnoreCase("1"))
						{
							strECSAccountTYpe="SB";
						}else if(strECSAccountTYpe.equalsIgnoreCase("2"))
						{
							strECSAccountTYpe="CA";
						}else if(strECSAccountTYpe.equalsIgnoreCase("3")){
							strECSAccountTYpe="OD";

						}
					}
					strECSBankname=Helper.correctDouble((String)rs.getString("FACILITY_ECSBANKNAME"));
					if(!strECSAccountTYpe.equalsIgnoreCase(""))
					{
						strQuery = SQLParser.getSqlQuery("sel_enach_bankname^"+strECSBankname);
						rs1 = DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							strECSBankname=Helper.correctNull((String)rs1.getString("stat_data_desc1"));	
						}
					}
					
					strECSAuthMode=Helper.correctNull((String)rs.getString("FACILITY_ECSATHUNMODE"));
					if(!strECSAuthMode.equalsIgnoreCase(""))
					{
						if(strECSAuthMode.equalsIgnoreCase("1"))
						{
							strECSAuthMode="IB";
						}else if(strECSAuthMode.equalsIgnoreCase("2"))
						{
							strECSAuthMode="Debit Card";
						}
					}
					
					if(strGovtSponsSch.equalsIgnoreCase("0"))
						strGovtSponsSch=null;
					
					if(rs1!=null)
					{
						rs1.close();
					}
					strQuery1=SQLParser.getSqlQuery("sel_sancdate_diff_Intcode^"+strLimSanctDate);
					rs1=DBUtils.executeQuery(strQuery1);
					if(rs1.next())
					{
						intDateDiff=Integer.parseInt(Helper.correctInt((String)rs1.getString("datediff")));
						
						if(intDateDiff>=0)
							strDateDiff="Y";
						else
							strDateDiff="N";
					}
					
					if(rs1!=null)
					{
						rs1.close();
					}
					strQuery1=SQLParser.getSqlQuery("sel_staffprd^"+strPrdCode);
					rs1=DBUtils.executeQuery(strQuery1);
					if(rs1.next())
					{
						//strStaffId=Helper.correctNull((String)rs1.getString("prd_staffprd"));
						strStaffId="N";// Need to capture
					}
					if(rs1!=null)
					{
						rs1.close();
					}
					if(strStaffId.equalsIgnoreCase("Y"))
					{
						double dbl=0.00;
						strQuery1=SQLParser.getSqlQuery("sel_tablecode^"+strPrdCode);
						rs1=DBUtils.executeQuery(strQuery1);
						if(rs1.next())
						{
							strIntTBLCode=Helper.correctNull((String)rs1.getString("prd_tablecode"));
							strIDDRPrefPerc=nf.format(dbl);
							strIDDRPrefPerc=strIDDRPrefPerc.trim();
							
							/*if(strDateDiff.equalsIgnoreCase("Y"))
							{
								strIntTBLCode="A"+strIntTBLCode.substring(1, strIntTBLCode.length());
							}*/
						}
					}
					else
					{
						if(!strModIntRate.equalsIgnoreCase(""))
						{
							if(strIntType.equalsIgnoreCase("fix"))
							{
								double dblFlooredModIntRate=Math.floor(dblModIntRate);
								double dblRemaining=dblModIntRate-dblFlooredModIntRate;
								String strFlooredModIntRate=nf1.format(dblFlooredModIntRate);
								if(strFlooredModIntRate.length()==1)
								{
									if(strDateDiff.equalsIgnoreCase("Y"))
									{
										strIntTBLCode="A0"+nf1.format(dblFlooredModIntRate)+"00";
									}
									else
									{
										strIntTBLCode="L0"+nf1.format(dblFlooredModIntRate)+"00";
									}
								}
								else
								{
									if(strDateDiff.equalsIgnoreCase("Y"))
									{
										strIntTBLCode="A"+nf1.format(dblFlooredModIntRate)+"00";
									}
									else
									{
										strIntTBLCode="L"+nf1.format(dblFlooredModIntRate)+"00";
									}
								}
								strIDDRPrefPerc=nf.format(dblRemaining);
							}
							else if(strIntType.equalsIgnoreCase("flo"))
							{/*
								strIntType="floating";
								if(rs1!=null)
								{
									rs1.close();
								}
								strQuery1=SQLParser.getSqlQuery("sel_AccFlatFileDatacorpagri3^"+strRepPrdMths+"^"+strSanctLim+"^"+strIntType+"^"+strPrdCode);
								rs1=DBUtils.executeQuery(strQuery1);
								if(rs1.next())
								{*/
//								if(strDateDiff.equalsIgnoreCase("Y"))
//								{
//									strIntTBLCode="ABASE";
//								}
//								else
//								{
//									strIntTBLCode="LBASE";
//								}
//									//dblBaseRate=Double.parseDouble(Helper.correctDouble((String)rs1.getString("int_intvalue")));
//									dblFloatingRate=dblModIntRate-dblBaseRate;
//									strIDDRPrefPerc=nf.format(dblFloatingRate);
							//	}
								
								
								if(rs2!=null)
								{
									rs2.close();
								}
								strQuery=SQLParser.getSqlQuery("sanctiondate_mclr^"+strAppNo);
								rs2=DBUtils.executeQuery(strQuery);
								if(rs2.next())
								{
									if(Integer.parseInt(Helper.correctInt(rs2.getString("datediff")))<0)
									{
										if(strDateDiff.equalsIgnoreCase("Y"))
										{
											strIntTBLCode="ABASE";
										}
										else
										{
											strIntTBLCode="LBASE";
										}
											dblFloatingRate=dblModIntRate-dblBaseRate;
											strIDDRPrefPerc=nf.format(dblFloatingRate);
									
									}
									else
									{
										
										// MCLR Changes
										dblBaseRate=0.0;
										strIntTBLCode="";
										if(rs1!=null)
											rs1.close();
										strQuery1=SQLParser.getSqlQuery("sel_facility_mclrspread^"+strFacilitySno+"^"+strAppNo);
										rs1=DBUtils.executeQuery(strQuery1);
										if(rs1.next())
										{
											//strIntTBLCode="AMC"+Helper.correctNull(rs1.getString("mclr_tablecode"));
											strIntTBLCode=Helper.correctNull(rs1.getString("mclr_tablecode"));
											dblBaseRate=Double.parseDouble(Helper.correctDouble(rs1.getString("mclr_spread")));
											
											strIDDRPrefPerc=nf.format(Double.parseDouble(Helper.correctDouble(rs1.getString("mclr_crp_total")))+Double.parseDouble(Helper.correctDouble(rs1.getString("mclr_bsp_total"))));
											
											String strMCLRType=Helper.correctNull(rs1.getString("facility_mclrtype"));
											if(!strMCLRType.equalsIgnoreCase(""))
						 					{
						 						String[] strArr=strMCLRType.split("@");
						 						if(strArr.length>1)
						 						{
						 							if(strArr[0].equalsIgnoreCase("O")||strArr[0].equalsIgnoreCase("M")||strArr[0].equalsIgnoreCase("Q")||strArr[0].equalsIgnoreCase("H")||strArr[0].equalsIgnoreCase("Y"))
						 							strResetFreqFlag=strArr[0];
						 							
						 							if(rs3!=null)
						 								rs3.close();
						 							rs3=DBUtils.executeLAPSQuery("sel_mclrspreadrate^"+Helper.getCurrentDateTime()+"^"+strArr[0]);
						 							if(rs3.next())
						 							{
						 								dblFinalRate=Double.parseDouble(Helper.correctDouble(rs3.getString("mclr_baseratespread")))+Double.parseDouble(Helper.correctDouble(rs1.getString("mclr_crp_total")))+Double.parseDouble(Helper.correctDouble(rs1.getString("mclr_bsp_total")));
						 							}
						 						}
						 					}
											
										}
										
											//dblFloatingRate=dblModIntRate-dblBaseRate;
											//strIDDRPrefPerc=nf.format(dblFloatingRate);
										
									}
								}
							}
						}
					}
					dblRecmdAmount=Double.parseDouble(Helper.correctDouble(strSanctLim));
					dblRmdamt=dblRecmdAmount;
					
					//Commented by Archunan as Operational code is not needed  to pass to cbs
					if(Helper.correctNull((String)rs.getString("FACILITY_MODEOFREPAY")).equalsIgnoreCase("E"))
					{
						strOpAcId=Helper.correctNull((String)rs.getString("FACILITY_OPERATIONACCNO"));
					}
					//=Helper.correctNull((String)rs.getString("prd_type"));
					/*if(strPrdType.equalsIgnoreCase("pR"))
					{
						strQuery2=SQLParser.getSqlQuery("sel_AccFlatFileData4^"+strAppNo);
						rs2=DBUtils.executeQuery(strQuery2);
						if(rs2.next())
						{
							strIDMDEffDate=Helper.correctNull((String)rs2.getString("loan_matdate"));
							strRepPrdDays=(String)Long.toString(Helper.dateDiff(strLimExpDate, strIDMDEffDate));
						}
					}
					else*/ if(strHolidayPeriod.equalsIgnoreCase("0"))
					{
						strIDMDEffDate="";
					}
					else
					{
						strIDMDEffDate=Helper.addMonthWithDate(currentDate,intHolidayPeriod);
					}
					/*
					 * The month comes after the holiday period will be considered as flow start date
					 */
					/*if(strPrdType.equalsIgnoreCase("pE"))
					{
						strIntOnIDMDFlag="N";
					}*/
					strLRFreqType=Helper.correctNull((String)rs.getString("FACILITY_PERINSTALL"));
					if(strLRFreqType.equalsIgnoreCase("m"))
					{
						intPeriod=1;
					}
					else if(strLRFreqType.equalsIgnoreCase("q"))
					{
						intPeriod=3;
					}
					else if(strLRFreqType.equalsIgnoreCase("h"))
					{
						intPeriod=6;
					}
					else if(strLRFreqType.equalsIgnoreCase("y"))
					{
						intPeriod=12;
					}
					else if(strLRFreqType.equalsIgnoreCase("n"))
					{
						/*if(strPrdType.equalsIgnoreCase("pR")||strPrdType.equalsIgnoreCase("pG"))
						{
							if(strSchemeCode.equalsIgnoreCase("JGQCK"))// By default for the scheme JGQCK it is Half Yearly, For others it is Yearly
							{
								strLRFreqType="h";
								intPeriod=6;
							}
							else
							{
								strLRFreqType="y";
								intPeriod=12;
							}
						}*/
					}
					if(intPeriod!=0)
					{
						intNoOfFlow=intRepayPeriod/intPeriod;
					}
					/*if(strPrdType.equalsIgnoreCase("pR")||strPrdType.equalsIgnoreCase("pG"))//For DL and GL No of Flows by default it is 1
					{
						intNoOfFlow=1;
					}
					if(strPrdType.equalsIgnoreCase("pR"))//For DL by default Maturity Date
					{
						strFlowStartDate=strIDMDEffDate;
					}
					else if(strPrdType.equalsIgnoreCase("pG")) // For GL by default Current Date + Loan Period
					{
						strFlowStartDate=Helper.addMonthWithDate(currentDate,intLoanPeriod);
					}
					else
					{
						strFlowStartDate=Helper.addMonthWithDate(currentDate, intHolidayPeriod+1); //Based on DC Initial Requirement 
					}
					/*if(strPrdType.equalsIgnoreCase("pR")||strPrdType.equalsIgnoreCase("pG"))
					{
						strLimExpDate=strFlowStartDate; //Both
					}*/
					int intflowstartperiod=1;
					if(strLRFreqType.equalsIgnoreCase("m") && strfacility_repaytype.equalsIgnoreCase("E"))
					{
						intflowstartperiod=intflowstartperiod+intHolidayPeriod;
						strFlowStartDate=Helper.addMonthWithDate(currentDate, intflowstartperiod); 
					}
					else{
						if(rs3!=null)
						{rs3.close();}
						strQuery3=SQLParser.getSqlQuery("selloan_account_details^"+strAppNo+"^"+strFacilitySno);
						rs3=DBUtils.executeQuery(strQuery3);
						if(rs3.next())
						{
							strFlowStartDate=Helper.correctNull((String)rs3.getString("flow_start_date"));
						}
					}
					if(!strFlowStartDate.equalsIgnoreCase(""))
					strLRFreqStartDD=strFlowStartDate.substring(0,2);
					strNumOfFlows=Integer.toString(intNoOfFlow);
					if(Helper.correctNull((String)rs.getString("FACILITY_REPAYTYPE")).equalsIgnoreCase("E"))
					{
						
	    				 double dblRate=dblFinalRate/(12*100);
	    				 double dblDenomi=0.0,dblNumeri=0.0,dblInterestAmt=0.0;
	    				 if((intHolidayPeriod>0) && strPendingPaymentMode.equalsIgnoreCase("2"))
	    				 {
	    					 for(int k=0;k<intHolidayPeriod;k++)
	    					 {
	    						 dblInterestAmt=(dblRmdamt* dblRate);
	    						 dblRmdamt=dblRmdamt+dblInterestAmt;
	    					 }

	    				 }
    					 dblDenomi=Math.pow(dblRate+1,(intRepayPeriod))-1;	
    					 dblNumeri=dblRate*Math.pow(dblRate+1,(intRepayPeriod));
	    				 if(dblNumeri!=0.0 && dblDenomi!=0.0)
	    				 {
	    					 dblEMI=Math.ceil((dblNumeri/dblDenomi)*dblRmdamt);
	    					 strFlowAmt=nf.format(dblEMI);
	    				 }
						
						//strFlowAmt=Helper.correctNull((String)rs.getString("loan_emi"));//Need to put new column
					}
					/*else if(strPrdType.equalsIgnoreCase("pG")||strPrdType.equalsIgnoreCase("pR"))
					{
						strFlowAmt=strSanctLim;
					}*/
					else
					{
						if(intNoOfFlow>0)
						{
							double dblTemp=dblRecmdAmount/intNoOfFlow;
							strFlowAmt=nf.format(dblTemp);
						}
					}
					
					strLoanPaperDate=Helper.correctNull((String)rs.getString("ac_opening_date"));
					strSanctLevlCode=Helper.correctNull((String)rs.getString("COM_SACTIONLEVEL"));
					strSanctAuthCode=Helper.correctNull((String)rs.getString("COM_SANCAUTHORITY"));
					if(rs3!=null)
					{
						rs3.close();
					}
					strQuery3=SQLParser.getSqlQuery("sel_misappclassification_corpagri^"+strAppNo+"^"+strFacilitySno);
					rs3=DBUtils.executeQuery(strQuery3);
					if(rs3.next())
					{
						strSectorCode=Helper.correctNull((String)rs3.getString("app_sector"));
						strSubSectorCode=Helper.correctNull((String)rs3.getString("app_subsector"));
						strSensitiveSectorCode=Helper.correctNull((String)rs3.getString("app_sensitivesector"));
					}
					if(rs3!=null)
					{
						rs3.close();
					}
					if((!strSchemeCode.equalsIgnoreCase(""))&&(!strSubSectorCode.equalsIgnoreCase("")))
					{
						strQuery3=SQLParser.getSqlQuery("sel_AccFlatFileData2^"+strSchemeCode+"^"+strSubSectorCode+"@^@"+strSubSectorCode+"@");
						rs3=DBUtils.executeQuery(strQuery3);
						if(rs3.next())
						{
							strGLSubHeadCode=Helper.correctNull((String)rs3.getString("sch_datadescription"));
						}
					}
					strQuery4=SQLParser.getSqlQuery("sel_cbsdetails_corpagri^"+strAppNo+"^"+strFacilitySno);
					rs4=DBUtils.executeQuery(strQuery4);
					if(rs4.next())
					{
						strFreeCode6=Helper.correctNull((String)rs4.getString("FREECODE6"));
						strFreeCode7=Helper.correctNull((String)rs4.getString("FREECODE7FINCODE"));
						strFreeCode8=Helper.correctNull((String)rs4.getString("FREECODE8FINCODE"));
						strModeOfOperCode=Helper.correctNull((String)rs4.getString("MODE_OF_OPERATION"));
						strDrwngPowerInd=Helper.correctNull((String)rs4.getString("DRAWING_PWR_IND"));
						strDrwngPower=Helper.correctNull((String)rs4.getString("DRAWING_PWR"));
						strSolID=Helper.correctNull((String)rs4.getString("LOANDISBBRANCH"));
						strAdvanceNature=Helper.correctNull((String)rs4.getString("NATUREOFADV"));
						strAdvanceType=Helper.correctNull((String)rs4.getString("TYPEOFADV"));
						strAdvanceMode=Helper.correctNull((String)rs4.getString("MODEOFADV"));
						strAdvancePurpose=Helper.correctNull((String)rs4.getString("PURPOSEOFADV"));
						strFreeCode3=Helper.correctNull((String)rs4.getString("FREECODE3"));
						//strSecurityCode=Helper.correctNull((String)rs4.getString("SECURITYCODE"));
						//strLBRCode=Helper.correctNull((String)rs4.getString("LBRCODE"));
						strINTRATEFREQ=Helper.correctNull((String)rs4.getString("INTRATEFREQ"));
						CBSSchemecode=Helper.correctNull((String)rs4.getString("facility_schemecode"));
						CBSGLsubheadcode=Helper.correctNull((String)rs4.getString("facility_glsubheadcode"));
						strDescOfSecurity=Helper.correctNull((String)rs4.getString("CER_GISTOFSECURITUES"));
					}
					strBorrowerCatCode=Helper.correctNull((String)rs.getString("perapp_constitution"));
					//strRenewFlg=Helper.correctNull((String)rs.getString("app_renew_flag"));
					strBankScheme=Helper.correctNull((String)rs.getString("COM_BANKSCHEME"));
					strDeptCode=Helper.correctNull((String)rs.getString("COM_SANCDEPT"));
					String strSpecifGLCode=Helper.correctNull((String)rs.getString("com_schemeheadcode"));
					if((strSchemeCode.equalsIgnoreCase("BPGEN"))||(strSchemeCode.equalsIgnoreCase("FBA")))
					{
						strGLSubHeadCode=strSpecifGLCode;
					}
					if(!CBSSchemecode.equalsIgnoreCase(""))
					{
						strSchemeCode=CBSSchemecode;
					}
					if(!CBSGLsubheadcode.equalsIgnoreCase(""))
					{
						strGLSubHeadCode=CBSGLsubheadcode;
					}
					strFile=Helper.correctNull((String)rs.getString("com_partyfileno"));
					

					if(Integer.parseInt(Helper.correctInt(rs.getString("perapp_constitution")))>=183 && Integer.parseInt(Helper.correctInt(rs.getString("perapp_constitution")))<=191)
						strSHGCode="002";
					else
						strSHGCode="001";
					
					if(!Helper.correctNull(rs.getString("facility_duedate")).equalsIgnoreCase(""))
						strLimExpDate=Helper.correctNull(rs.getString("facility_duedate"));
					
					strFITLFlag=Helper.correctNull(rs.getString("facility_fitl_acc"));
				}
				if(rs!=null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("sel_FinacleSancRefNo^"+strAppNo);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strSanctRefNum=Helper.correctNull((String)rs.getString("finaclesancrefno"));
				}
				if(rs!=null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("sel_misappdetails_corpagri^"+strAppNo+"^"+strFacilitySno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strGuarCoverCode=Helper.correctNull((String)rs.getString("app_guarantee"));
					strBSROccuCode=Helper.correctNull((String)rs.getString("app_bsrcode"));
					strServiceAreaCode=Helper.correctNull((String)rs.getString("app_whetherservice"));
					activityCode = Helper.correctNull((String)rs.getString("app_activitycode"));
					alliedactivityCode=Helper.correctNull((String)rs.getString("APP_ALLIED_ACTIVITYCODE"));
					if(strServiceAreaCode.equalsIgnoreCase("Y"))
					{
						strServiceAreaCode="001";
					}else{
						strServiceAreaCode="002";
					}
					strLBRCode=Helper.correctNull((String)rs.getString("app_bsr1code"));
				}
				if(rs!=null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("sel_misappdisplayscreen_corpagri^"+strAppNo+"^"+strFacilitySno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					//strLandHoldCode=Helper.correctNull((String)rs.getString("app_totland"));
					strLandHoldCode=Helper.correctNull((String)rs.getString("app_farmercategory")); // changes done by subha
					
				}
				if(rs!=null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("sel_CustomerDetails^"+strAppId);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strAcctOccpCode=Helper.correctNull((String)rs.getString("kyc_occupationcode"));
					strSCSTCode=Helper.correctNull((String)rs.getString("indinfo_caste"));
					strMinorityCode=Helper.correctNull((String)rs.getString("indinfo_religion"));
				}
				/*if(strLRIntFreqType.equalsIgnoreCase("m"))
				{
					intLRPeriod=1;
				}
				else if(strLRIntFreqType.equalsIgnoreCase("q"))
				{
					intLRPeriod=3;
				}
				else if(strLRIntFreqType.equalsIgnoreCase("h"))
				{
					intLRPeriod=6;
				}
				else if(strLRIntFreqType.equalsIgnoreCase("y"))
				{
					intLRPeriod=12;
				}
				else if(strLRIntFreqType.equalsIgnoreCase("n"))
				{
					if(strPrdType.equalsIgnoreCase("pR")||strPrdType.equalsIgnoreCase("pG"))
					{
						intLRPeriod=12;
						strLRIntFreqType="y";
					}
				}
				if(intLRPeriod!=0)
				{
					intNextIntDMDDate=intRepayPeriod/intLRPeriod;
				}
				strNextIntDmdDate=Helper.addMonthWithDate(currentDate, intLRPeriod+1);*/
				
				if(strINTRATEFREQ.equalsIgnoreCase("m"))//Prakash
				{
					intPeriod=1;
				}
				else if(strINTRATEFREQ.equalsIgnoreCase("q"))
				{
					intPeriod=3;
				}
				else if(strINTRATEFREQ.equalsIgnoreCase("h"))
				{
					intPeriod=6;
				}
				else if(strINTRATEFREQ.equalsIgnoreCase("y"))
				{
					intPeriod=12;
				}
				else if(strINTRATEFREQ.equalsIgnoreCase("n"))
				{
					/*if(strPrdType.equalsIgnoreCase("pR")||strPrdType.equalsIgnoreCase("pG"))
					{
						intPeriod=12;
						strIntFreqTypeDR="y";
					}*/
				}
				strLRIntFreqType=strINTRATEFREQ;//Both are Same
				
				strNextIntDmdDate=Helper.addMonthWithDate(currentDate, intPeriod-1);
					
				if(!(strINTRATEFREQ.equalsIgnoreCase("m")&& strfacility_repaytype.equalsIgnoreCase("E")))
				{
					strQuery3=SQLParser.getSqlQuery("sel_enddateofmonth^"+strNextIntDmdDate);
					rs3=DBUtils.executeQuery(strQuery3);
					if(rs3.next())
					{
						strNextIntDmdDate=Helper.correctNull((String)rs3.getString("mon_enddate"));
					}
				}
				if(strINTRATEFREQ.equalsIgnoreCase("m")&& strfacility_repaytype.equalsIgnoreCase("E"))
				{
					strNextIntDmdDate=Helper.addMonthWithDate(currentDate, intPeriod);
				}
				if(strINTRATEFREQ.equalsIgnoreCase("y") && !strFreeCode6.equalsIgnoreCase(""))
				{
					strNextIntDmdDate=Helper.getNextIntDmdDate(strCurrentDate, strINTRATEFREQ, strFreeCode6);
				}
				//if Interest Frequency Quarterly means
				if(strINTRATEFREQ.equalsIgnoreCase("q"))
				{
					strNextIntDmdDate=Helper.getNextIntDmdDate(strCurrentDate, strINTRATEFREQ, strFreeCode6);	
				}
//				if(! strNextIntDmdDate.equalsIgnoreCase(""))
//				{
//					strIntFreqStartDDDR=strNextIntDmdDate.substring(0,2);
//				}
				if(strINTRATEFREQ.equalsIgnoreCase("m")&& !strfacility_repaytype.equalsIgnoreCase("E"))
				{
					strQuery3=SQLParser.getSqlQuery("sel_enddateofmonth^"+strCurrentDate);
					rs3=DBUtils.executeQuery(strQuery3);
					if(rs3.next())
					{
						strIDMDEffDate=Helper.correctNull((String)rs3.getString("mon_enddate"));
					}
				}
				if(intHolidayPeriod==0)
				{
					strIDMDEffDate="";
				}
				if(strModuleType.equalsIgnoreCase("AGR"))
				{
					strIDMDEffDate="";
				}
				
				if(strInterestCharged.equalsIgnoreCase("y"))
					strIDMDEffDate="";
				
				//Added by Guhan
				if(strSchemeCode.equalsIgnoreCase("GGDQ") || strSchemeCode.equalsIgnoreCase("TGDYA") || strSchemeCode.equalsIgnoreCase("DGDYA")
						|| strSchemeCode.equalsIgnoreCase("TGDKA"))
					strNextIntDmdDate=Helper.addMonthWithDate(currentDate, 12);
				/*if(!strIntFreqTypeDR.equalsIgnoreCase("y"))
				{
					if(rs4 !=null)
					{
						rs4.close();
					}
					strQuery4=SQLParser.getSqlQuery("sel_enddate^"+strNextIntDmdDate);
					rs4=DBUtils.executeQuery(strQuery4);
					//rs4=DBUtils.executeLAPSQuery("sel_enddate^"+strNextIntDmdDate);
					if(rs4.next())
					{
						strNextIntDmdDate=Helper.correctNull((String)rs4.getString("end_date"));
					}
				}*/
				//strNextIntRunDateDR=Helper.addMonthWithDate(currentDate, intPeriod+1);
				
				if(strModuleType.equalsIgnoreCase("AGR")&& strINTRATEFREQ.equalsIgnoreCase("y"))
					strNextIntDmdDate=Helper.addMonthWithDate(currentDate, 12);
				
				strNextIntRunDateDR=strNextIntDmdDate;
				
				
				//Description of the security to be passed to Finacle other than gold loan
				//if(!strPrdType.equalsIgnoreCase("pG"))
				{
					if(rs!=null)
					{
						rs.close();
					}
					strQuery=SQLParser.getSqlQuery("sel_sec_desc^"+strAppNo);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strDescOfSecurity=Helper.correctNull((String)rs.getString("sec_description"));
					}
				}
				
				/*SanctionDetails="";
				SanctionDetails=strCustCBSId+"|"+strSchemeCode+"|"+strGLSubHeadCode+"|"+strModeOfOperCode+"|"+strPBPSCode+"|"+
								strIntTBLCode+"|"+strIDDRPrefPerc+"|"+strSanctLim+"|"+strRepPrdMths+"|"+strRepPrdDays+"|"+
								strOpAcId+"|"+strIDMDEffDate+"|"+strIntOnIDMDFlag+"|"+strNumOfFlows+"|"+strLRFreqType.toUpperCase()+"|"+
								strFlowStartDate+"|"+strFlowAmt+"|"+strLRIntFreqType+"|"+strNextIntDmdDate+"|"+strSanctLim+"|"+
								strLimSanctDate+"|"+strLimExpDate+"|"+strLoanPaperDate+"|"+strSanctLevlCode+"|"+strSanctAuthCode+"|"+
								strSanctRefNum+"|"+strDescOfSecurity+"|"+strDrwngPowerInd+"|"+strLimitB2kid+"|"+strDrwngPowerPcnt+"|"+strDrwngPower+"|"+strFreeCode6+"|"+
								strFreeCode7+"|"+strFreeCode8;
				String strGetCurDateTime=Helper.getCurrentDateTime();
				String[] strSplitted=strGetCurDateTime.split("/");
				String strDateVal="";
				for(int z=0;z<strSplitted.length;z++)
				{
					strDateVal=strDateVal+strSplitted[z];
				}
				strFile="ACC"+strDateVal+"_"+strAppNo+".TXT";
				strFileName = strPath + "/" +strFile;
				File file = new File(strFileName);
				RandomAccessFile raf = new RandomAccessFile(file, "rw");
				raf.seek(file.length());
				raf.writeBytes(SanctionDetails);
				raf.writeBytes("\n");
				raf.close();*/
				/*hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId", "deleteAccountHandOffDetails");
				arrValues.add(strAppNo);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);*/
				
				//For Non EMI data
				String strMulti_schedule_num="",strSchedule_details="";
				String strFLOW_ID="PRDEM",strNUM_OF_FLOWS="",strFLOW_START_DATE="",strLR_FREQ_TYPE="",strLR_FREQ_START_DD="",strFLOW_AMT="";
				String strNEXT_INT_DMD_DATE="",strLR_INT_FREQ_START_DD="";
				String strColumnDelimitor="^",strRowDelimitor="~";
				
				if(strfacility_repaytype.equalsIgnoreCase("E"))
				{
					//EI Account 
					strFLOW_ID="EIDEM";
					strMulti_schedule_num="1";
					if(rs!=null)
					{
						rs.close();
					}
					strQuery = SQLParser.getSqlQuery("select_facilityproposed^"+strAppNo+"^"+strFacilitySno);	
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						int intMoritorium = Integer.parseInt(Helper.correctInt(rs.getString("FACILITY_HOLIDAYPERIOD")));
						int intterm = Integer.parseInt(Helper.correctInt(rs.getString("FACILITY_MONTHS")));
						int  terms = intterm - intMoritorium;
						strNUM_OF_FLOWS=String.valueOf(terms);
						strLR_FREQ_TYPE=Helper.correctNull((String)rs.getString("FACILITY_PERINSTALL")).toUpperCase();
						double dblInterest=Double.parseDouble(Helper.correctDouble((String)rs.getString("facility_sancinterest")));
						strFLOW_AMT=nf.format(dblEMI);
						
						strNEXT_INT_DMD_DATE=Helper.getIntDmdDate(strCurrentDate,strIntFreqTypeDR);
						
						strFLOW_START_DATE=strFlowStartDate;
						strNEXT_INT_DMD_DATE=strNextIntDmdDate;
						strBankingArrangement=Helper.correctNull(rs.getString("facility_propbanktype"));
					}
					if(!(strIntFreqTypeDR.equalsIgnoreCase("y") || strIntFreqTypeDR.equalsIgnoreCase("h")))
					{
						strNEXT_INT_DMD_DATE=Helper.getMQHDate(strIntFreqTypeDR);
					}
					strNEXT_INT_DMD_DATE=strNextIntDmdDate;
					strFLOW_START_DATE=strFlowStartDate;
					if(!strNEXT_INT_DMD_DATE.equalsIgnoreCase(""))
					{
						strNEXT_INT_DMD_DATE=strNEXT_INT_DMD_DATE.replace("/", "-");
						strLR_INT_FREQ_START_DD=strNEXT_INT_DMD_DATE.substring(0,2);
					}
					else
					{
						strNEXT_INT_DMD_DATE="";strLR_INT_FREQ_START_DD="";
					}
					if(!strFLOW_START_DATE.equalsIgnoreCase(""))
					{
						//"select_month_enddate"
						strFLOW_START_DATE=strFLOW_START_DATE.replace("/", "-");
						/*String strMonthEndDate="";
						String strMonthend=SQLParser.getSqlQuery("select_month_enddate^"+strFLOW_START_DATE+"^"+strFLOW_START_DATE);
						ResultSet rsmonthend=DBUtils.executeQuery(strMonthend);
						if(rsmonthend.next())
						{
							strMonthEndDate=Helper.correctNull((String)rsmonthend.getString("next_int_dmd_date"));
						}
						if(strMonthEndDate.equalsIgnoreCase(strFLOW_START_DATE))
						{
							strLR_FREQ_START_DD="31";
						}else{*/
							strLR_FREQ_START_DD=strFLOW_START_DATE.substring(0,2);
						//}
					}
					/*if(!strNEXT_INT_DMD_DATE.equalsIgnoreCase(""))
					{
						//"select_month_enddate"
						String strMonthEndDate="";
						String strMonthend=SQLParser.getSqlQuery("select_month_enddate^"+strNEXT_INT_DMD_DATE+"^"+strNEXT_INT_DMD_DATE);
						ResultSet rsmonthend=DBUtils.executeQuery(strMonthend);
						if(rsmonthend.next())
						{
							strMonthEndDate=Helper.correctNull((String)rsmonthend.getString("next_int_dmd_date"));
						}
						if(strMonthEndDate.equalsIgnoreCase(strNEXT_INT_DMD_DATE))
						{
							strLR_INT_FREQ_START_DD="31";
						}
					}
					*/
					strSchedule_details=strFLOW_ID+strColumnDelimitor+strNUM_OF_FLOWS+strColumnDelimitor+strFLOW_START_DATE+
						strColumnDelimitor+strLR_FREQ_TYPE+strColumnDelimitor+strLR_FREQ_START_DD+strColumnDelimitor+strFLOW_AMT+
						strColumnDelimitor+strNEXT_INT_DMD_DATE+strColumnDelimitor+strIntFreqTypeDR+strColumnDelimitor+strLR_INT_FREQ_START_DD;
				
				}
				else
				{
					//Otherthan EI
					if(rs!=null)
					{
						rs.close();
					}
					strQuery=SQLParser.getSqlQuery("sel_multi_schedule_num^"+strAppNo+"^"+strFacilitySno);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strMulti_schedule_num=Helper.correctNull((String)rs.getString("multi_schedule_num"));
					}
					if(rs!=null)
					{
						rs.close();
					}
					if(Integer.parseInt(Helper.correctInt(strMulti_schedule_num))>0)
					{
						strQuery=SQLParser.getSqlQuery("selflowstart_date^"+strAppNo+"^"+strFacilitySno);
						rs=DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							strFLOW_START_DATE=Helper.correctNull((String)rs.getString("flow_start_date"));
							strLR_FREQ_START_DD=Helper.correctNull((String)rs.getString("lr_freq_start_dd"));
						}
						if(rs!=null)
						{
							rs.close();
						}
						strFLOW_START_DATE=strFlowStartDate;
						strNEXT_INT_DMD_DATE=strNextIntDmdDate;
						
						strQuery=SQLParser.getSqlQuery("sel_tl_repayschedule_loanaccount^"+strAppNo+"^"+strFacilitySno);
						rs=DBUtils.executeQuery(strQuery);
						if(Integer.parseInt(Helper.correctInt(strMulti_schedule_num))==1)
						{
							if(rs.next())
							{
								strNUM_OF_FLOWS=Helper.correctNull((String)rs.getString("num_of_flows"));
								strLR_FREQ_TYPE=Helper.correctNull((String)rs.getString("lr_freq_type"));
								strFLOW_AMT=Helper.correctNull((String)rs.getString("flow_amt"));
								
								strNEXT_INT_DMD_DATE=Helper.getIntDmdDate(strCurrentDate,strIntFreqTypeDR);
								
								strFLOW_START_DATE=strFlowStartDate;
								strNEXT_INT_DMD_DATE=strNextIntDmdDate;
								
								if(!strNEXT_INT_DMD_DATE.equalsIgnoreCase(""))
								{
									strNEXT_INT_DMD_DATE=strNEXT_INT_DMD_DATE.replace("/", "-");
									strLR_INT_FREQ_START_DD=strNEXT_INT_DMD_DATE.substring(0,2);
								}
								else
								{
									strNEXT_INT_DMD_DATE="";strLR_INT_FREQ_START_DD="";
								}
								
								if(!strFLOW_START_DATE.equalsIgnoreCase(""))
								{
									//"select_month_enddate"
									strFLOW_START_DATE=strFLOW_START_DATE.replace("/", "-");
									/*String strMonthEndDate="";
									String strMonthend=SQLParser.getSqlQuery("select_month_enddate^"+strFLOW_START_DATE+"^"+strFLOW_START_DATE);
									ResultSet rsmonthend=DBUtils.executeQuery(strMonthend);
									if(rsmonthend.next())
									{
										strMonthEndDate=Helper.correctNull((String)rsmonthend.getString("next_int_dmd_date"));
									}
									if(strMonthEndDate.equalsIgnoreCase(strFLOW_START_DATE))
									{
										strLR_FREQ_START_DD="31";
									}*/
								}
								/*if(!strNEXT_INT_DMD_DATE.equalsIgnoreCase(""))
								{
									//"select_month_enddate"
									String strMonthEndDate="";
									String strMonthend=SQLParser.getSqlQuery("select_month_enddate^"+strNEXT_INT_DMD_DATE+"^"+strNEXT_INT_DMD_DATE);
									ResultSet rsmonthend=DBUtils.executeQuery(strMonthend);
									if(rsmonthend.next())
									{
										strMonthEndDate=Helper.correctNull((String)rsmonthend.getString("next_int_dmd_date"));
									}
									if(strMonthEndDate.equalsIgnoreCase(strNEXT_INT_DMD_DATE))
									{
										strLR_INT_FREQ_START_DD="31";
									}
								}*/
								if(strSchemeCode.equalsIgnoreCase("GGDQ") || strSchemeCode.equalsIgnoreCase("TGDYA") || strSchemeCode.equalsIgnoreCase("DGDYA")
										|| strSchemeCode.equalsIgnoreCase("TGDKA"))
								{
									//
								}
								else
								{
									strLR_INT_FREQ_START_DD="31";
								}
								strSchedule_details=strFLOW_ID+strColumnDelimitor+strNUM_OF_FLOWS+strColumnDelimitor+strFLOW_START_DATE+
									strColumnDelimitor+strLR_FREQ_TYPE+strColumnDelimitor+strLR_FREQ_START_DD+strColumnDelimitor+strFLOW_AMT+
									strColumnDelimitor+strNEXT_INT_DMD_DATE+strColumnDelimitor+strINTRATEFREQ+strColumnDelimitor+strLR_INT_FREQ_START_DD;
							}
						}
						else
						{
							int i=0;
							while(rs.next())
							{
								int inttempmonths=0;
								if(i>0)
								{
									if(strLR_FREQ_TYPE.equalsIgnoreCase("m"))
									{
										inttempmonths=Integer.parseInt(Helper.correctInt(strNUM_OF_FLOWS))*1;
									}
									else if(strLR_FREQ_TYPE.equalsIgnoreCase("q"))
									{
										inttempmonths=Integer.parseInt(Helper.correctInt(strNUM_OF_FLOWS))*3;
									}
									else if(strLR_FREQ_TYPE.equalsIgnoreCase("h"))
									{
										inttempmonths=Integer.parseInt(Helper.correctInt(strNUM_OF_FLOWS))*6;
									}
									else if(strLR_FREQ_TYPE.equalsIgnoreCase("y"))
									{
										inttempmonths=Integer.parseInt(Helper.correctInt(strNUM_OF_FLOWS))*12;
									}
									else
									{
										inttempmonths=0;
									}
									String strQuery7=SQLParser.getSqlQuery("sel_flowstartdate_loanaccount^"+strFLOW_START_DATE+"^"+inttempmonths+"^"+strFLOW_START_DATE+"^"+inttempmonths);
									ResultSet rs7=DBUtils.executeQuery(strQuery7);
									if(rs7.next())
									{
										strFLOW_START_DATE=Helper.correctNull((String)rs7.getString("flow_start_date"));
										strLR_FREQ_START_DD=Helper.correctNull((String)rs7.getString("lr_freq_start_dd"));
									}
									if(rs7!=null)
									{
										rs7.close();
									}
									strQuery7=SQLParser.getSqlQuery("sel_flowstartdate_loanaccount^"+strNEXT_INT_DMD_DATE+"^"+inttempmonths+"^"+strNEXT_INT_DMD_DATE+"^"+inttempmonths);
									rs7=DBUtils.executeQuery(strQuery7);
									if(rs7.next())
									{
										strNEXT_INT_DMD_DATE=Helper.correctNull((String)rs7.getString("flow_start_date"));
										strLR_INT_FREQ_START_DD=Helper.correctNull((String)rs7.getString("lr_freq_start_dd"));
									}
									if(rs7!=null)
									{
										rs7.close();
									}
								}
								strNUM_OF_FLOWS=Helper.correctNull((String)rs.getString("num_of_flows"));
								strLR_FREQ_TYPE=Helper.correctNull((String)rs.getString("lr_freq_type"));
								strFLOW_AMT=Helper.correctNull((String)rs.getString("flow_amt"));
								if(i==0)
								{
									int intperiodnum=0;
									strNEXT_INT_DMD_DATE=Helper.getIntDmdDate(strCurrentDate,strIntFreqTypeDR);
									if(!(strIntFreqTypeDR.equalsIgnoreCase("y") || strIntFreqTypeDR.equalsIgnoreCase("h")))
									{
										strNEXT_INT_DMD_DATE=Helper.getMQHDate(strIntFreqTypeDR);
									}
									strNEXT_INT_DMD_DATE=strNextIntDmdDate;
									if(!strNEXT_INT_DMD_DATE.equalsIgnoreCase(""))
									{
										strNEXT_INT_DMD_DATE=strNEXT_INT_DMD_DATE.replace("/", "-");
										strLR_INT_FREQ_START_DD=strNEXT_INT_DMD_DATE.substring(0,2);
									}
									else
									{
										strNEXT_INT_DMD_DATE="";strLR_INT_FREQ_START_DD="";
									}
								}
								
								if(!strFLOW_START_DATE.equalsIgnoreCase(""))
								{
									//"select_month_enddate"
									strFLOW_START_DATE=strFLOW_START_DATE.replace("/", "-");
									/*String strMonthEndDate="";
									String strMonthend=SQLParser.getSqlQuery("select_month_enddate^"+strFLOW_START_DATE+"^"+strFLOW_START_DATE);
									ResultSet rsmonthend=DBUtils.executeQuery(strMonthend);
									if(rsmonthend.next())
									{
										strMonthEndDate=Helper.correctNull((String)rsmonthend.getString("next_int_dmd_date"));
									}
									if(strMonthEndDate.equalsIgnoreCase(strFLOW_START_DATE))
									{
										strLR_FREQ_START_DD="31";
									}*/
								}
								/*if(!strNEXT_INT_DMD_DATE.equalsIgnoreCase(""))
								{
									//"select_month_enddate"
									String strMonthEndDate="";
									String strMonthend=SQLParser.getSqlQuery("select_month_enddate^"+strNEXT_INT_DMD_DATE+"^"+strNEXT_INT_DMD_DATE);
									ResultSet rsmonthend=DBUtils.executeQuery(strMonthend);
									if(rsmonthend.next())
									{
										strMonthEndDate=Helper.correctNull((String)rsmonthend.getString("next_int_dmd_date"));
									}
									if(strMonthEndDate.equalsIgnoreCase(strNEXT_INT_DMD_DATE))
									{
										strLR_INT_FREQ_START_DD="31";
									}
								}*/
								if(strSchemeCode.equalsIgnoreCase("GGDQ") || strSchemeCode.equalsIgnoreCase("TGDYA") || strSchemeCode.equalsIgnoreCase("DGDYA")
										|| strSchemeCode.equalsIgnoreCase("TGDKA"))
								{
									//
								}
								else
								{
									strLR_INT_FREQ_START_DD="31";
								}
								if(strSchedule_details.equalsIgnoreCase(""))
								{
									strSchedule_details=strFLOW_ID+strColumnDelimitor+strNUM_OF_FLOWS+strColumnDelimitor+strFLOW_START_DATE+
									strColumnDelimitor+strLR_FREQ_TYPE+strColumnDelimitor+strLR_FREQ_START_DD+strColumnDelimitor+strFLOW_AMT+
									strColumnDelimitor+strNEXT_INT_DMD_DATE+strColumnDelimitor+strINTRATEFREQ+strColumnDelimitor+strLR_INT_FREQ_START_DD;
								}
								else
								{
									strSchedule_details=strSchedule_details+strRowDelimitor+strFLOW_ID+strColumnDelimitor+strNUM_OF_FLOWS+strColumnDelimitor+strFLOW_START_DATE+
									strColumnDelimitor+strLR_FREQ_TYPE+strColumnDelimitor+strLR_FREQ_START_DD+strColumnDelimitor+strFLOW_AMT+
									strColumnDelimitor+strNEXT_INT_DMD_DATE+strColumnDelimitor+strINTRATEFREQ+strColumnDelimitor+strLR_INT_FREQ_START_DD;
								}
								i++;
							}
						}
						
						if(rs!=null)
						{
							rs.close();
						}
					}
				}
				
				String strSecid="",strQuery8="";
				ResultSet rs8=null;
				strQuery8=SQLParser.getSqlQuery("sel_securityid^"+strAppNo+"^"+strFacilitySno);
				rs8=DBUtils.executeQuery(strQuery8);
				if(rs8.next())
				{
					strSecid=Helper.correctNull((String)rs8.getString("APP_SEC_SECID"));
				}
				if(rs8!=null)
				{rs8.close();}
				strQuery8=SQLParser.getSqlQuery("sel_securitycbscode^"+Helper.correctInt((String)strSecid));
				rs8=DBUtils.executeQuery(strQuery8);
				if(rs8.next())
				{
					strSecurityCode=Helper.correctNull((String)rs8.getString("sec_cbssecurity"));
				}
				if(rs8!=null)
				{rs8.close();}
				
				//DSA - BSA ID taken from appinwardreg table
				if(rs!=null)rs.close();
				strQuery = SQLParser.getSqlQuery("sel_inward_proposed_values^"+strAppNo);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strDSAID=Helper.correctNull(rs.getString("inward_agentid"));
				}
				
				//Project Loan & DCCO Date
				if(rs!=null)
				rs.close();
				rs=DBUtils.executeLAPSQuery("sel_management^BreifDetaisTL^"+strFacilitySno+"^"+strAppNo);
				if(rs.next())
				{
					strProjectLoan=Helper.correctNull(rs.getString("com_projectloan"));
					strDCCODate=Helper.correctNull(rs.getString("com_date"));
				}
				
				strFlowAmt=nf.format(Math.round(Double.parseDouble(Helper.correctDouble(strFlowAmt))));
				
				String strStageWiseRelease="";
				if(rs!=null)
				rs.close();
				strQuery = SQLParser.getSqlQuery("sel_allcomments1^" + strAppNo+"^repaycomment^"+strFacilitySno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strStageWiseRelease=Helper.correctNull(rs.getString("FIN_STAGEWISE_RELEASE"));
				}
				if(rs!=null)
					rs.close();
				String fbilfreq="";
				strQuery = SQLParser.getSqlQuery("sel_corpmclrresetfreq^"+ strAppNo+"^"+strFacilitySno);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					strSchemeCode = Helper.correctNull((String) rs.getString("mclr_tablecode"));
					fbilfreq= Helper.correctNull((String) rs.getString("FBILL_FRQ"));
					if (strSchemeCode.equalsIgnoreCase("AGSEC")|| strSchemeCode.equalsIgnoreCase("NGSEC")|| strSchemeCode.equalsIgnoreCase("ATBIL")|| strSchemeCode.equalsIgnoreCase("NTBIL")) {
						strResetFreqFlag = "Q";
					}else if(strSchemeCode.equalsIgnoreCase("AMD07")||strSchemeCode.equalsIgnoreCase("NMD07")
							||strSchemeCode.equalsIgnoreCase("AMD14")||strSchemeCode.equalsIgnoreCase("NMD14")
							||strSchemeCode.equalsIgnoreCase("AMM01")||strSchemeCode.equalsIgnoreCase("NMM01")
							||strSchemeCode.equalsIgnoreCase("AMM02")||strSchemeCode.equalsIgnoreCase("NMM02")
							||strSchemeCode.equalsIgnoreCase("AMM03")||strSchemeCode.equalsIgnoreCase("NMM03")
							||strSchemeCode.equalsIgnoreCase("AMM04")||strSchemeCode.equalsIgnoreCase("NMM04")
							||strSchemeCode.equalsIgnoreCase("AMM05")||strSchemeCode.equalsIgnoreCase("NMM05")
							||strSchemeCode.equalsIgnoreCase("AMM06")||strSchemeCode.equalsIgnoreCase("NMM06")
							||strSchemeCode.equalsIgnoreCase("AMM07")||strSchemeCode.equalsIgnoreCase("NMM07")
							||strSchemeCode.equalsIgnoreCase("AMM08")||strSchemeCode.equalsIgnoreCase("NMM08")
							||strSchemeCode.equalsIgnoreCase("AMM09")||strSchemeCode.equalsIgnoreCase("NMM09")
							||strSchemeCode.equalsIgnoreCase("AMM10")||strSchemeCode.equalsIgnoreCase("NMM10")
							||strSchemeCode.equalsIgnoreCase("AMM11")||strSchemeCode.equalsIgnoreCase("NMM11")
							||strSchemeCode.equalsIgnoreCase("AMM12")||strSchemeCode.equalsIgnoreCase("NMM12")){
						strResetFreqFlag=fbilfreq;
					}else
					{
						strResetFreqFlag=strResetFreqFlag;	
					}
				}
				if(rs!=null)
					rs.close();
				strQuery=SQLParser.getSqlQuery("sel_facility_interfacedetails^"+strAppNo+"^"+strFacilitySno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					SchemeCode=Helper.correctNull((String)rs.getString("scheme_code"));
				}
				if(rs!=null)
					rs.close();
				String com_facility_emischeme="", strncgtcSchemecode="";
				strQuery=SQLParser.getSqlQuery("chck_cgsdvalass_ncgtc^"+strAppNo+"^"+strFacilitySno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strncgtcSchemecode=Helper.correctNull((String)rs.getString("COM_BANKSCHEME"));
					com_facility_emischeme=Helper.correctNull((String)rs.getString("com_facility_emischeme"));
					if(strncgtcSchemecode.equals("070") && !com_facility_emischeme.equals("ODGEN") && !com_facility_emischeme.equals("ODPS"))
					{
						strResetFreqFlag="";
					}
				}
				hshQueryValues=new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
				{
					hshQuery.put("strQueryId", "ins_FinacleAccCreation_corpagri_newconnection");

				}
				else
				{
				hshQuery.put("strQueryId", "ins_FinacleAccCreation_corpagri");
				}
				arrValues.add(strAppNo);//1
				arrValues.add(strCustCBSId);//2
				arrValues.add(SchemeCode);//3
				arrValues.add(strGLSubHeadCode);//4
				arrValues.add(strModeOfOperCode);//5
				arrValues.add(strPBPSCode);//6
				arrValues.add(strIntTBLCode);//7
				arrValues.add(strIDDRPrefPerc);//8
				arrValues.add(strSanctLim);//9 convertApplicationToSetup  Helper.convertApplicationToSetup(strValuesIn, Double.parseDouble(strSanctLim))
				arrValues.add(strRepPrdMths);//10
				arrValues.add(strRepPrdDays);//11
				arrValues.add(strOpAcId);//12
				arrValues.add(strIDMDEffDate);//13
				arrValues.add(strIntOnIDMDFlag);//14
				arrValues.add(strNumOfFlows);//15
				arrValues.add(strLRFreqType.toUpperCase());//16
				arrValues.add(strFlowStartDate);//17
				arrValues.add(strFlowAmt);//18
				arrValues.add(strLRIntFreqType);//19
				arrValues.add(strNextIntDmdDate);//20
				arrValues.add(strLimSanctDate);//21
				arrValues.add(strLimExpDate);//22
				arrValues.add(strLoanPaperDate);//23
				arrValues.add(strSanctLevlCode);//24
				arrValues.add(strSanctAuthCode);//25
				arrValues.add(strSanctRefNum);//26
				arrValues.add(strDescOfSecurity);//27
				arrValues.add(strDrwngPowerInd);//28
				arrValues.add(strLimitB2kid);//29
				arrValues.add(strDrwngPowerPcnt);//30
				arrValues.add(strDrwngPower);//31
				arrValues.add(strFreeCode6);//32
				arrValues.add(strFreeCode7);//33
				arrValues.add(strFreeCode8);//34
				arrValues.add(strMaxAlwdAdvnLim);//35
				arrValues.add(strPSFreqType);//36
				arrValues.add(strPSFreqWeekDay);//37
				arrValues.add(strFreqStartDD);//38
				arrValues.add(strFreqHldyStat);//39
				arrValues.add(strPSDespatchMode);//40
				arrValues.add(strIntFreqTypeDR);//41
				arrValues.add(strIntFreqStartDDDR);//42
				arrValues.add(strIntFreqHldyStatDR);//43
				arrValues.add(strNextIntRunDateDR);//44
				arrValues.add(strForAcID);//45
				arrValues.add(strSolID);//46
				arrValues.add(strLocalCallFlg);//47
				arrValues.add(strSectorCode);//48
				arrValues.add(strSubSectorCode);//49
				arrValues.add(strAcctOccpCode);//50
				arrValues.add(strBorrowerCatCode);//51
				arrValues.add(strAdvancePurpose);//52
				arrValues.add(strAdvanceMode);//53
				arrValues.add(strAdvanceType);//54
				arrValues.add(strAdvanceNature);//55
				arrValues.add(strGuarCoverCode);//56
				arrValues.add(strBSROccuCode);//57
				arrValues.add(strLBRCode);//58
				arrValues.add(strServiceAreaCode);//59
				arrValues.add(strLandHoldCode);//60
				arrValues.add(strBankScheme);//61
				arrValues.add(strSCSTCode);//62
				arrValues.add(strMinorityCode);//63
				arrValues.add(strSensitiveSectorCode);//64
				arrValues.add(strSecurityCode);//65
				arrValues.add(strDeptCode);//66
				arrValues.add(strFreeCode3);//67
				arrValues.add(strLRFreqStartDD);//68
				arrValues.add(strLrIntFreqHldyStat);//69
				arrValues.add(strHealthCode);//70
				arrValues.add(strRenewFlg);//71
				arrValues.add(strProcessedFlg);//72
				arrValues.add(strFacilitySno);//73
				arrValues.add(strMulti_schedule_num);//74
				arrValues.add(strSchedule_details);//75
				arrValues.add(strFile);//76
				arrValues.add(Helper.correctNull((String)hshValues.get("strRelationType")));//77
				arrValues.add(strResetFreqFlag);//78
				arrValues.add(strSHGCode);
				arrValues.add(strGovtSponsSch);
				arrValues.add(strDSAID);
				arrValues.add(strProjectLoan);
				arrValues.add(strDCCODate);
				arrValues.add(strFITLFlag);
				arrValues.add(strStageWiseRelease);
				arrValues.add(strBankingArrangement);
				arrValues.add(activityCode);
				arrValues.add(alliedactivityCode);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
				{
				   EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateCBSData");
									
				}
				else
				{
				   EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
									
				}
				hshQueryValues=new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId", "insertAccountHandOffDetails");
				arrValues.add(strAppNo);//1
				arrValues.add(strCustCBSId);//2
				arrValues.add(SchemeCode);//3
				arrValues.add(strGLSubHeadCode);//4
				arrValues.add(strModeOfOperCode);//5
				arrValues.add(strPBPSCode);//6
				arrValues.add(strIntTBLCode);//7
				arrValues.add(strIDDRPrefPerc);//8
				arrValues.add(strSanctLim);//9 convertApplicationToSetup  Helper.convertApplicationToSetup(strValuesIn, Double.parseDouble(strSanctLim))
				arrValues.add(strRepPrdMths);//10
				arrValues.add(strRepPrdDays);//11
				arrValues.add(strOpAcId);//12
				arrValues.add(strIDMDEffDate);//13
				arrValues.add(strIntOnIDMDFlag);//14
				arrValues.add(strNumOfFlows);//15
				arrValues.add(strLRFreqType.toUpperCase());//16
				arrValues.add(strFlowStartDate);//17
				arrValues.add(strFlowAmt);//18
				arrValues.add(strLRIntFreqType);//19
				arrValues.add(strNextIntDmdDate);//20
				arrValues.add(strLimSanctDate);//21
				arrValues.add(strLimExpDate);//22
				arrValues.add(strLoanPaperDate);//23
				arrValues.add(strSanctLevlCode);//24
				arrValues.add(strSanctAuthCode);//25
				arrValues.add(strSanctRefNum);//26
				arrValues.add(strDescOfSecurity);//27
				arrValues.add(strDrwngPowerInd);//28
				arrValues.add(strLimitB2kid);//29
				arrValues.add(strDrwngPowerPcnt);//30
				arrValues.add(strDrwngPower);//31
				arrValues.add(strFreeCode6);//32
				arrValues.add(strFreeCode7);//33
				arrValues.add(strFreeCode8);//34
				arrValues.add(strMaxAlwdAdvnLim);//35
				arrValues.add(strPSFreqType);//36
				arrValues.add(strPSFreqWeekDay);//37
				arrValues.add(strFreqStartDD);//38
				arrValues.add(strFreqHldyStat);//39
				arrValues.add(strPSDespatchMode);//40
				arrValues.add(strIntFreqTypeDR);//41
				arrValues.add(strIntFreqStartDDDR);//42
				arrValues.add(strIntFreqHldyStatDR);//43
				arrValues.add(strNextIntRunDateDR);//44
				arrValues.add(strForAcID);//45
				arrValues.add(strSolID);//46
				arrValues.add(strLocalCallFlg);//47
				arrValues.add(strSectorCode);//48
				arrValues.add(strSubSectorCode);//49
				arrValues.add(strAcctOccpCode);//50
				arrValues.add(strBorrowerCatCode);//51
				arrValues.add(strAdvancePurpose);//52
				arrValues.add(strAdvanceMode);//53
				arrValues.add(strAdvanceType);//54
				arrValues.add(strAdvanceNature);//55
				arrValues.add(strGuarCoverCode);//56
				arrValues.add(strBSROccuCode);//57
				arrValues.add(strLBRCode);//58
				arrValues.add(strServiceAreaCode);//59
				arrValues.add(strLandHoldCode);//60
				arrValues.add(strBankScheme);//61
				arrValues.add(strSCSTCode);//62
				arrValues.add(strMinorityCode);//63
				arrValues.add(strSensitiveSectorCode);//64
				arrValues.add(strSecurityCode);//65
				arrValues.add(strDeptCode);//66
				arrValues.add(strFreeCode3);//67
				arrValues.add(strLRFreqStartDD);//68
				arrValues.add(strLrIntFreqHldyStat);//69
				arrValues.add(strHealthCode);//70
				arrValues.add(strRenewFlg);//71
				arrValues.add(strProcessedFlg);//72
				arrValues.add(strFacilitySno);//73
				arrValues.add("Y");//74
				arrValues.add(Helper.correctNull((String)hshValues.get("strUserId")));//75
				arrValues.add(strFile);//76
				arrValues.add(strMulti_schedule_num);//77
				arrValues.add(strSchedule_details);//78
				arrValues.add(Helper.correctNull((String)hshValues.get("strRelationType")));//79
				arrValues.add(strResetFreqFlag);//80
				arrValues.add(strSHGCode);
				arrValues.add(strGovtSponsSch);
				arrValues.add("");
				arrValues.add("");
				arrValues.add(strDSAID);
				arrValues.add(strProjectLoan);
				arrValues.add(strDCCODate);
				arrValues.add(strFITLFlag);
				arrValues.add("");
				arrValues.add("");
				arrValues.add(strStageWiseRelease);
				arrValues.add(strBankingArrangement);
				arrValues.add(activityCode);
				arrValues.add(alliedactivityCode);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				
				hshQuery=new HashMap();
				hshQuery.put("strQueryId", "update_facduedate");
				arrValues = new ArrayList();
				arrValues.add(strLimExpDate);
				arrValues.add(nf.format(dblFinalRate));
				arrValues.add(strAppNo);
				arrValues.add(strFacilitySno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				hshQueryValues.put("size", "2");
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
				//insert E-NACH
				
				if(!strModeofPayment.equalsIgnoreCase("") && ! strECSAuthMode.equalsIgnoreCase("")){
					if(strModeofPayment.equalsIgnoreCase("C") && !strECSAuthMode.equalsIgnoreCase("3")){
						
						hshQuery=new HashMap();
						hshQuery.put("strQueryId", "ins_laps_enach");
						arrValues = new ArrayList();
						arrValues.add(strAppNo);
						arrValues.add(strECSBankname);
						arrValues.add(strECSAccountTYpe);
						arrValues.add(strECSIFSCCODE);
						arrValues.add(strECSOperaccnum);
						arrValues.add(strECSAuthMode);
						arrValues.add(strenachumrn);
						arrValues.add(Helper.correctNull((String)hshValues.get("strUserId")));
						arrValues.add(strCurrentDate);
						arrValues.add(Helper.correctNull((String)hshValues.get("strUserId")));
						arrValues.add(strCurrentDate);
						arrValues.add(STRDELFLAG);
						arrValues.add(strFREETXT);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("1", hshQuery);
						hshQueryValues.put("size", "1");
						
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
						
					}
				}
			}
			hshRecord.put("SanctionDetails",SanctionDetails);
		}
		catch (Exception e)
		{
			throw new EJBException("Error Occured  " + e.getMessage());
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
			catch (Exception e)
			{
				e.printStackTrace();
			}
		}
		return hshRecord;
	}
	public HashMap getODFlatFileReportCorpAgri(HashMap hshValues,String strFacilitySno) 
	{
		SimpleDateFormat sdnew=new SimpleDateFormat("dd/MM/yyyy");
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshRecord = new HashMap();
		ArrayList arrValues=new ArrayList();
		ResultSet rs=null;
		ResultSet rs1=null;
		ResultSet rs2=null;
		ResultSet rs3=null;
		int intDateDiff=0;
		String strDateDiff="";
		/*File Directory = null;
		String strPath = "";
		strPath = ApplicationParams.getFlatFile();
		Directory = new File(strPath);
		if (!Directory.exists())
		{
			Directory.mkdirs();
		}*/
		String strFileName = "";
		String strFile = "";
		String strCustCBSId="";
		String strSchemeCode="",SchemeCode="";
		String strGLSubHeadCode="";
		String strModeOfOperCode="";
		String strPBPSCode="B";
		String strPSFreqType="M";
		String strIntTBLCode="";
		String strIDDRPrefPerc="";
		String strSanctLim="";
		String strRepPrdMths="";
		String strLimSanctDate="";
		String strLimExpDate="";
		String strLoanPaperDate="";
		String strSanctLevlCode="";
		String strSanctAuthCode="";
		String strSanctRefNum="";
		String strDescOfSecurity="";
		String strDrwngPowerInd="";
		String strLimitB2kid="";
		String strDrwngPowerPcnt="";
		String strDrwngPower="";
		String strFreeCode6="";
		String strFreeCode7="";
		String strFreeCode8="";
		String SanctionDetails="";
		String strExcludeHoliday="";
		String strIntType="";
		String strPrdCode="";
		String strPrdType="";
		String strQuery="";
		String strQuery1="";
		String strQuery2="";
		String strQuery3="";
		String strAppId="";
		String strAppNo="";
		String strHolidayPeriod="";
		String strPSFreqWeekDay="";
		String strFreqStartDD="1";
		String strFreqHldyStat="N";
		String strPSDespatchMode="N";
		String strIntFreqTypeDR="";
		String strIntFreqStartDDDR="31";
		String strIntFreqHldyStatDR="P";
		String strNextIntRunDateDR="";
		String strForAcID="";
		String strSolID="";
		String strAdvanceNature="";
		String strAdvanceType="";
		String strAdvanceMode="";
		String strAdvancePurpose="";
		String strFreeCode3="";
		String strSecurityCode="";
		String strLocalCallFlg="N";
		String strSectorCode="";
		String strSubSectorCode="";
		String strSensitiveSectorCode="";
		String strGuarCoverCode="";
		String strBSROccuCode="";
		String strLBRCode="";
		String strServiceAreaCode="";
		String strLandHoldCode="";
		String strBankScheme="";
		String strProcessedFlg="";
		String strAcctOccpCode="";
		String strBorrowerCatCode="";
		String strSCSTCode="";
		String strRenewFlg="";
		String strHealthCode="01";
		String strMinorityCode="";
		String strDeptCode="";
		String strSNo="1";
		String strRepPrdDays="";
		String strOpAcId="";
		String strIDMDEffDate="";
		String strIntOnIDMDFlag="";
		String strNumOfFlows="";
		String strLRFreqType="";
		String strFlowStartDate="";
		String strFlowAmt="";
		String strLRIntFreqType="";
		String strNextIntDmdDate="";
		String strMaxAlwdAdvnLim="";
		String strLRFreqStartDD="";
		String strLrIntFreqHldyStat="";
		String strStaffId="",strProjectLoan="",strDCCODate="",strFITLFlag="";
		double dblModIntRate=0.00, dblBaseRate=0.00, dblFloatingRate=0.00,dblFinalRate=0.0;
		int intRepayPeriod=0, intLoanPeriod=0, intNextIntRunDateDR=0, intPeriod=0;
		NumberFormat nf = NumberFormat.getInstance();
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
		nf.setGroupingUsed(false);
		NumberFormat nf1 = NumberFormat.getInstance();
		nf1.setMaximumFractionDigits(0);
		nf1.setMinimumFractionDigits(0);
		nf1.setGroupingUsed(false);
		Date currentDate=new Date();
		//String strCurrentDate=(String)currentDate.toString();
		String strValuesIn="",strINTRATEFREQ="";
		String CBSSchemecode="",CBSGLsubheadcode="",strSHGCode="";
		String strSchemeType="",StrFacLoanType="",strResetFreqFlag="",strInterestCharged="",strGovtSponsSch="";
		int intHolidayPeriod=0;
		String strDSAID="",strBankingArrangement="",activityCode="",alliedactivityCode="";
		try
		{
			String strCurrentDate=Helper.getCurrentDateTime();
			String strfacility_repaytype="";
			strAppNo=Helper.correctNull((String)hshValues.get("appno"));
			String strModuleType=Helper.correctNull((String)hshValues.get("sessionModuleType"));
			if(strAppNo.equalsIgnoreCase(""))
			{
				strAppNo=Helper.correctNull((String)hshValues.get("appno1"));
			}
			if(strAppNo.equalsIgnoreCase(""))
			{
				strAppNo=Helper.correctNull((String)hshValues.get("strappno"));
			}
			if(!strAppNo.equalsIgnoreCase(""))
			{
				strQuery=SQLParser.getSqlQuery("sel_facility_interfacedetails^"+strAppNo+"^"+strFacilitySno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strInterestCharged=Helper.correctNull(rs.getString("facility_interestrec"));
					strAppId=Helper.correctNull((String)rs.getString("perapp_id"));
					strCustCBSId=Helper.correctNull((String)rs.getString("perapp_cbsid"));
					strSchemeCode=Helper.correctNull((String)rs.getString("scheme_code"));
					String strModIntRate=Helper.correctNull((String)rs.getString("facility_sancinterest"));
					strRepPrdMths=Helper.correctNull((String)rs.getString("FACILITY_MONTHS"));
					intLoanPeriod=Integer.parseInt(Helper.correctInt((String)strRepPrdMths));
					if(strSchemeCode.equalsIgnoreCase("ODKCC"))
						strLimExpDate=Helper.addMonthWithDate(currentDate, 12);
					else
						strLimExpDate=Helper.addMonthWithDate(currentDate, intLoanPeriod);
					strHolidayPeriod=Helper.correctNull((String)rs.getString("FACILITY_HOLIDAYPERIOD"));
					intHolidayPeriod=Integer.parseInt(Helper.correctInt(strHolidayPeriod));
					intRepayPeriod=Integer.parseInt(Helper.correctInt(strRepPrdMths))-Integer.parseInt(Helper.correctInt(strHolidayPeriod));
					strExcludeHoliday=Integer.toString(intRepayPeriod);
					strSanctLim=nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("FACILITY_SANCAMT"))));
					dblModIntRate=Double.parseDouble(Helper.correctDouble(strModIntRate));
					dblFinalRate=dblModIntRate;
					strIntType=Helper.correctNull((String)rs.getString("FACILITY_INTTYPE"));
					strPrdCode=Helper.correctNull((String)rs.getString("FACILITY_CODE"));
					strIntFreqTypeDR=Helper.correctNull((String)rs.getString("COM_FACILITY_INTFREQ"));
					strValuesIn=Helper.correctNull((String)rs.getString("APP_VALUESIN"));
					strfacility_repaytype=Helper.correctNull((String)rs.getString("facility_repaytype"));
					strRenewFlg=Helper.correctNull((String)rs.getString("facility_typefor"));
					strSchemeType=Helper.correctNull((String)rs.getString("facility_agrschemetype"));
					StrFacLoanType=Helper.correctNull((String)rs.getString("com_facility_loantype"));
					strSanctLim=Helper.convertApplicationToSetup(strValuesIn, Double.parseDouble(strSanctLim));
					dblBaseRate=Double.parseDouble(Helper.correctDouble(rs.getString("facility_baserate")));
					strLimSanctDate=Helper.correctNull((String)rs.getString("app_processdate"));
					strGovtSponsSch=Helper.correctNull(rs.getString("facility_schemetype"));
					if(strGovtSponsSch.equalsIgnoreCase("0"))
						strGovtSponsSch=null;
					
					if(rs1!=null)
					{
						rs1.close();
					}
					strQuery1=SQLParser.getSqlQuery("sel_sancdate_diff_Intcode^"+strLimSanctDate);
					rs1=DBUtils.executeQuery(strQuery1);
					if(rs1.next())
					{
						intDateDiff=Integer.parseInt(Helper.correctInt((String)rs1.getString("datediff")));
						
						if(intDateDiff>=0)
							strDateDiff="Y";
						else
							strDateDiff="N";
					}
					
					if(rs1!=null)
					{
						rs1.close();
					}
					strQuery1=SQLParser.getSqlQuery("sel_staffprd^"+strPrdCode);
					rs1=DBUtils.executeQuery(strQuery1);
					if(rs1.next())
					{
						//strStaffId=Helper.correctNull((String)rs1.getString("prd_staffprd"));
						strStaffId="N";
					}
					if(rs1!=null)
					{
						rs1.close();
					}
					if(strStaffId.equalsIgnoreCase("Y"))
					{
						strQuery1=SQLParser.getSqlQuery("sel_tablecode^"+strPrdCode);
						rs1=DBUtils.executeQuery(strQuery1);
						if(rs1.next())
						{
							strIntTBLCode=Helper.correctNull((String)rs1.getString("prd_tablecode"));
							strIDDRPrefPerc="0";
							
							/*if(strDateDiff.equalsIgnoreCase("Y"))
							{
								strIntTBLCode="A"+strIntTBLCode.substring(1, strIntTBLCode.length());
							}*/
						}
					}
					else
					{
						if(!strModIntRate.equalsIgnoreCase(""))
						{
							if(strIntType.equalsIgnoreCase("fix"))
							{
								double dblFlooredModIntRate=Math.floor(dblModIntRate);
								double dblRemaining=dblModIntRate-dblFlooredModIntRate;
								String strFlooredModIntRate=nf1.format(dblFlooredModIntRate);
								if(strFlooredModIntRate.length()==1)
								{
									if(strDateDiff.equalsIgnoreCase("Y"))
									{
										strIntTBLCode="N0"+nf1.format(dblFlooredModIntRate)+"00";
									}
									else
									{
										strIntTBLCode="0"+nf1.format(dblFlooredModIntRate)+"00";
									}
								}
								else
								{
									if(strDateDiff.equalsIgnoreCase("Y"))
									{
										strIntTBLCode="N"+nf1.format(dblFlooredModIntRate)+"00";
									}
									else
									{
										strIntTBLCode=nf1.format(dblFlooredModIntRate)+"00";
									}
								}
								strIDDRPrefPerc=nf.format(dblRemaining);
							}
							else if(strIntType.equalsIgnoreCase("flo"))
							{
								//strIntType="floating";
								//strQuery1=SQLParser.getSqlQuery("sel_AccFlatFileDatacorpagri3^"+strRepPrdMths+"^"+strSanctLim+"^"+strIntType+"^"+strPrdCode);
								//rs1=DBUtils.executeQuery(strQuery1);
								//if(rs1.next())
								//{
//								if(strDateDiff.equalsIgnoreCase("Y"))
//								{
//									strIntTBLCode="NBASE";
//								}
//								else
//								{
//									strIntTBLCode="BASE";
//								}
									//dblBaseRate=Double.parseDouble(Helper.correctDouble((String)rs1.getString("int_intvalue")));
								
								if(rs2!=null)
								{
									rs2.close();
								}
								strQuery=SQLParser.getSqlQuery("sanctiondate_mclr^"+strAppNo);
								rs2=DBUtils.executeQuery(strQuery);
								if(rs2.next())
								{
									if(Integer.parseInt(Helper.correctInt(rs2.getString("datediff")))<0)
									{
										if(strDateDiff.equalsIgnoreCase("Y"))
										{
											strIntTBLCode="NBASE";
										}
										else
										{
											strIntTBLCode="BASE";
										}
											dblFloatingRate=dblModIntRate-dblBaseRate;
											strIDDRPrefPerc=nf.format(dblFloatingRate);
										
									
									}
									else
									{
										if(rs1!=null)
											rs1.close();
										dblBaseRate=0.0;
										strIntTBLCode="";
										strQuery1=SQLParser.getSqlQuery("sel_facility_mclrspread^"+strFacilitySno+"^"+strAppNo);
										rs1=DBUtils.executeQuery(strQuery1);
										if(rs1.next())
										{
											//strIntTBLCode="NMC"+Helper.correctNull(rs1.getString("mclr_tablecode"));
											strIntTBLCode=Helper.correctNull(rs1.getString("mclr_tablecode"));
											dblBaseRate=Double.parseDouble(Helper.correctDouble(rs1.getString("mclr_spread")));
											strIDDRPrefPerc=nf.format(Double.parseDouble(Helper.correctDouble(rs1.getString("mclr_crp_total")))+Double.parseDouble(Helper.correctDouble(rs1.getString("mclr_bsp_total"))));
											
											String strMCLRType=Helper.correctNull(rs1.getString("facility_mclrtype"));
											if(!strMCLRType.equalsIgnoreCase(""))
						 					{
						 						String[] strArr=strMCLRType.split("@");
						 						if(strArr.length>1)
						 						{
						 							if(strArr[0].equalsIgnoreCase("O")||strArr[0].equalsIgnoreCase("M")||strArr[0].equalsIgnoreCase("Q")||strArr[0].equalsIgnoreCase("H")||strArr[0].equalsIgnoreCase("Y"))
						 							strResetFreqFlag=strArr[0];
						 							
						 							if(rs3!=null)
						 								rs3.close();
						 							rs3=DBUtils.executeLAPSQuery("sel_mclrspreadrate^"+Helper.getCurrentDateTime()+"^"+strArr[0]);
						 							if(rs3.next())
						 							{
						 								dblFinalRate=Double.parseDouble(Helper.correctDouble(rs3.getString("mclr_baseratespread")))+Double.parseDouble(Helper.correctDouble(rs1.getString("mclr_crp_total")))+Double.parseDouble(Helper.correctDouble(rs1.getString("mclr_bsp_total")));
						 							}
						 						}
						 					}
											
										}
										
											//dblFloatingRate=dblModIntRate-dblBaseRate;
											//strIDDRPrefPerc=nf.format(dblFloatingRate);
									}
								}
								//}
							}
						}
					}
					//strPrdType=Helper.correctNull((String)rs.getString("prd_type"));
					/*if(strPrdType.equalsIgnoreCase("pR"))
					{
						strQuery2=SQLParser.getSqlQuery("sel_AccFlatFileData4^"+strAppNo);
						rs2=DBUtils.executeQuery(strQuery2);
						if(rs2.next())
						{
							String strMatDate=Helper.correctNull((String)rs2.getString("loan_matdate"));
							strRepPrdDays=(String)Long.toString(Helper.dateDiff(strLimExpDate, strMatDate));
							strLimExpDate=strMatDate;
						}
					}*/
					if(Helper.correctNull((String)rs.getString("FACILITY_MODEOFREPAY")).equalsIgnoreCase("E"))
					{
						strOpAcId=Helper.correctNull((String)rs.getString("FACILITY_OPERATIONACCNO"));
					}
					strLoanPaperDate=Helper.correctNull((String)rs.getString("ac_opening_date"));
					strSanctLevlCode=Helper.correctNull((String)rs.getString("COM_SACTIONLEVEL"));
					strSanctAuthCode=Helper.correctNull((String)rs.getString("COM_SANCAUTHORITY"));
					if(rs3!=null)
					{
						rs3.close();
					}
					strQuery3=SQLParser.getSqlQuery("sel_misappclassification_corpagri^"+strAppNo+"^"+strFacilitySno);
					rs3=DBUtils.executeQuery(strQuery3);
					if(rs3.next())
					{
						strSectorCode=Helper.correctNull((String)rs3.getString("app_sector"));
						strSubSectorCode=Helper.correctNull((String)rs3.getString("app_subsector"));
						strSensitiveSectorCode=Helper.correctNull((String)rs3.getString("app_sensitivesector"));
					}
					if(rs3!=null)
					{
						rs3.close();
					}
					if((!strSchemeCode.equalsIgnoreCase(""))&&(!strSubSectorCode.equalsIgnoreCase("")))
					{
						strQuery3=SQLParser.getSqlQuery("sel_AccFlatFileData2^"+strSchemeCode+"^"+strSubSectorCode+"@^@"+strSubSectorCode+"@");
						rs3=DBUtils.executeQuery(strQuery3);
						if(rs3.next())
						{
							strGLSubHeadCode=Helper.correctNull((String)rs3.getString("sch_datadescription"));
						}
					}
					strQuery3=SQLParser.getSqlQuery("sel_cbsdetails_corpagri^"+strAppNo+"^"+strFacilitySno);
					rs3=DBUtils.executeQuery(strQuery3);
					if(rs3.next())
					{
						strFreeCode6=Helper.correctNull((String)rs3.getString("FREECODE6"));
						strFreeCode7=Helper.correctNull((String)rs3.getString("FREECODE7FINCODE"));
						strFreeCode8=Helper.correctNull((String)rs3.getString("FREECODE8FINCODE"));
						strModeOfOperCode=Helper.correctNull((String)rs3.getString("MODE_OF_OPERATION"));
						strDrwngPowerInd=Helper.correctNull((String)rs3.getString("DRAWING_PWR_IND"));
						strDrwngPower=Helper.correctNull((String)rs3.getString("DRAWING_PWR"));
						strSolID=Helper.correctNull((String)rs3.getString("LOANDISBBRANCH"));
						strAdvanceNature=Helper.correctNull((String)rs3.getString("NATUREOFADV"));
						strAdvanceType=Helper.correctNull((String)rs3.getString("TYPEOFADV"));
						strAdvanceMode=Helper.correctNull((String)rs3.getString("MODEOFADV"));
						strAdvancePurpose=Helper.correctNull((String)rs3.getString("PURPOSEOFADV"));
						strFreeCode3=Helper.correctNull((String)rs3.getString("FREECODE3"));
						//strSecurityCode=Helper.correctNull((String)rs3.getString("SECURITYCODE"));
						//strLBRCode=Helper.correctNull((String)rs3.getString("LBRCODE"));
						strINTRATEFREQ=Helper.correctNull((String)rs3.getString("INTRATEFREQ"));
						CBSSchemecode=Helper.correctNull((String)rs3.getString("facility_schemecode"));
						CBSGLsubheadcode=Helper.correctNull((String)rs3.getString("facility_glsubheadcode"));
						strDescOfSecurity=Helper.correctNull((String)rs3.getString("CER_GISTOFSECURITUES"));
					}
					strBorrowerCatCode=Helper.correctNull((String)rs.getString("perapp_constitution"));
					//strRenewFlg=Helper.correctNull((String)rs.getString("app_renew_flag"));
					strBankScheme=Helper.correctNull((String)rs.getString("COM_BANKSCHEME"));
					strDeptCode=Helper.correctNull((String)rs.getString("COM_SANCDEPT"));
					
					String strSpecifGLCode=Helper.correctNull((String)rs.getString("com_schemeheadcode"));
					if((strSchemeCode.equalsIgnoreCase("BPGEN"))||(strSchemeCode.equalsIgnoreCase("FBA")))
					{
						strGLSubHeadCode=strSpecifGLCode;
					}
					if(!CBSSchemecode.equalsIgnoreCase(""))
					{
						strSchemeCode=CBSSchemecode;
					}
					if(!CBSGLsubheadcode.equalsIgnoreCase(""))
					{
						strGLSubHeadCode=CBSGLsubheadcode;
					}
					strFile=Helper.correctNull((String)rs.getString("com_partyfileno"));
					

					if(Integer.parseInt(Helper.correctInt(rs.getString("perapp_constitution")))>=183 && Integer.parseInt(Helper.correctInt(rs.getString("perapp_constitution")))<=191)
						strSHGCode="002";
					else
						strSHGCode="001";
					
					if(!Helper.correctNull(rs.getString("facility_duedate")).equalsIgnoreCase(""))
						strLimExpDate=Helper.correctNull(rs.getString("facility_duedate"));
					
					strFITLFlag=Helper.correctNull(rs.getString("facility_fitl_acc"));
					strBankingArrangement=Helper.correctNull(rs.getString("facility_propbanktype"));
				}
				if(rs!=null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("sel_FinacleSancRefNo^"+strAppNo);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strSanctRefNum=Helper.correctNull((String)rs.getString("finaclesancrefno"));
				}
				if(rs!=null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("sel_misappdetails_corpagri^"+strAppNo+"^"+strFacilitySno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strGuarCoverCode=Helper.correctNull((String)rs.getString("app_guarantee"));
					strBSROccuCode=Helper.correctNull((String)rs.getString("app_bsrcode"));
					strServiceAreaCode=Helper.correctNull((String)rs.getString("app_whetherservice"));
					activityCode = Helper.correctNull((String)rs.getString("app_activitycode"));
					alliedactivityCode=Helper.correctNull((String)rs.getString("APP_ALLIED_ACTIVITYCODE"));
					if(strServiceAreaCode.equalsIgnoreCase("Y"))
					{
						strServiceAreaCode="001";
					}else{
						strServiceAreaCode="002";
					}
					strLBRCode=Helper.correctNull((String)rs.getString("app_bsr1code"));
				}
				if(rs!=null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("sel_misappdisplayscreen_corpagri^"+strAppNo+"^"+strFacilitySno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					//strLandHoldCode=Helper.correctNull((String)rs.getString("app_totland"));
					strLandHoldCode=Helper.correctNull((String)rs.getString("app_farmercategory")); // changes done by subha
				}
				if(rs!=null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("sel_CustomerDetails^"+strAppId);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strAcctOccpCode=Helper.correctNull((String)rs.getString("kyc_occupationcode"));
					strSCSTCode=Helper.correctNull((String)rs.getString("indinfo_caste"));
					strMinorityCode=Helper.correctNull((String)rs.getString("indinfo_religion"));
				}
				if(strINTRATEFREQ.equalsIgnoreCase("m"))
				{
					intPeriod=1;
				}
				else if(strINTRATEFREQ.equalsIgnoreCase("q"))
				{
					intPeriod=3;
				}
				else if(strINTRATEFREQ.equalsIgnoreCase("h"))
				{
					intPeriod=6;
				}
				else if(strINTRATEFREQ.equalsIgnoreCase("y"))
				{
					intPeriod=12;
				}
				else if(strINTRATEFREQ.equalsIgnoreCase("n"))
				{
					/*if(strPrdType.equalsIgnoreCase("pR")||strPrdType.equalsIgnoreCase("pG"))
					{
						intPeriod=12;
						strIntFreqTypeDR="y";
					}*/
				}
				if(intPeriod!=0)
				{
					intNextIntRunDateDR=intRepayPeriod/intPeriod;
				}
				/*if(strPrdType.equalsIgnoreCase("pR")||strPrdType.equalsIgnoreCase("pG"))
				{
					strNextIntRunDateDR=Helper.addMonthWithDate(currentDate, intPeriod);

				}
				else
				{
					strNextIntRunDateDR=Helper.addMonthWithDate(currentDate, intPeriod+1);

				}*/
				/*if(strPrdType.equalsIgnoreCase("pR")||strPrdType.equalsIgnoreCase("pG"))
				{
					strNextIntDmdDate=Helper.addMonthWithDate(currentDate, intPeriod);
				}
				else*/
				strNextIntDmdDate=Helper.addMonthWithDate(currentDate, intPeriod-1);
				
				if(!(strINTRATEFREQ.equalsIgnoreCase("m")&& strfacility_repaytype.equalsIgnoreCase("E")))
				{
					if(rs3!=null){rs3.close();}
					strQuery3=SQLParser.getSqlQuery("sel_enddateofmonth^"+strNextIntDmdDate);
					rs3=DBUtils.executeQuery(strQuery3);
					if(rs3.next())
					{
						strNextIntDmdDate=Helper.correctNull((String)rs3.getString("mon_enddate"));
					}
				}
				if(strINTRATEFREQ.equalsIgnoreCase("m")&& strfacility_repaytype.equalsIgnoreCase("E"))
				{
					strNextIntDmdDate=Helper.addMonthWithDate(currentDate, intPeriod);
				}
				if(strINTRATEFREQ.equalsIgnoreCase("y") && !strFreeCode6.equalsIgnoreCase(""))
				{
					strNextIntDmdDate=Helper.getNextIntDmdDate(strCurrentDate, strINTRATEFREQ, strFreeCode6);
				}
				
				//if Interest Frequency Quarterly means
				if(strINTRATEFREQ.equalsIgnoreCase("q"))
				{
					strNextIntDmdDate=Helper.getNextIntDmdDate(strCurrentDate, strINTRATEFREQ, strFreeCode6);	
				}
				
				if(strSchemeType.equalsIgnoreCase("aQ") && StrFacLoanType.equalsIgnoreCase("OD")){
					
					strNextIntDmdDate=Helper.addMonthWithDate(currentDate, 12);
				}
				
				if(!strSchemeType.equalsIgnoreCase("aQ") && StrFacLoanType.equalsIgnoreCase("OD")){
					if(rs3!=null){rs3.close();}
					strQuery3=SQLParser.getSqlQuery("sel_enddateofmonth^"+strCurrentDate);
					rs3=DBUtils.executeQuery(strQuery3);
					if(rs3.next())
					{
						strNextIntDmdDate=Helper.correctNull((String)rs3.getString("mon_enddate"));
					}
				}
//				if(! strNextIntDmdDate.equalsIgnoreCase(""))
//				{
//					strIntFreqStartDDDR=strNextIntDmdDate.substring(0,2);
//				}
				//Added by Guhan 
				if(strSchemeCode.equalsIgnoreCase("GGDQ") || strSchemeCode.equalsIgnoreCase("TGDYA") || strSchemeCode.equalsIgnoreCase("DGDYA")
						|| strSchemeCode.equalsIgnoreCase("TGDKA"))
					strNextIntDmdDate=Helper.addMonthWithDate(currentDate, 12);
				
				if(strModuleType.equalsIgnoreCase("AGR")&& strINTRATEFREQ.equalsIgnoreCase("y"))
					strNextIntDmdDate=Helper.addMonthWithDate(currentDate, 12);
				
				
				strNextIntRunDateDR=strNextIntDmdDate;
				
				if(strINTRATEFREQ.equalsIgnoreCase("m")&& !strfacility_repaytype.equalsIgnoreCase("E"))
				{
					strQuery3=SQLParser.getSqlQuery("sel_enddateofmonth^"+strCurrentDate);
					rs3=DBUtils.executeQuery(strQuery3);
					if(rs3.next())
					{
						strIDMDEffDate=Helper.correctNull((String)rs3.getString("mon_enddate"));
					}
				}
				if(intHolidayPeriod==0)
				{
					strIDMDEffDate="";
				}
				if(strModuleType.equalsIgnoreCase("AGR"))
				{
					strIDMDEffDate="";
				}
				
				if(strInterestCharged.equalsIgnoreCase("y"))
					strIDMDEffDate="";
				
				/*if(!strIntFreqTypeDR.equalsIgnoreCase("y"))
				{
					if(rs3 !=null)
					{
						rs3.close();
					}
					strQuery3=SQLParser.getSqlQuery("sel_enddate^"+strNextIntRunDateDR);
					rs3=DBUtils.executeQuery(strQuery3);
					if(rs3.next())
					{
						strNextIntRunDateDR=Helper.correctNull((String)rs3.getString("end_date"));
					}
				}*/
				strMaxAlwdAdvnLim=strSanctLim;
				//if(!strPrdType.equalsIgnoreCase("pG"))
				{
					if(rs!=null)
					{
						rs.close();
					}
					/*strQuery=SQLParser.getSqlQuery("sel_sec_desc^"+strAppNo);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strDescOfSecurity=Helper.correctNull((String)rs.getString("sec_description"));
					}*/
				}
				//For Non EMI data
				String strMulti_schedule_num="",strSchedule_details="";
				String strFLOW_ID="PRDEM",strNUM_OF_FLOWS="",strFLOW_START_DATE="",strLR_FREQ_TYPE="",strLR_FREQ_START_DD="",strFLOW_AMT="";
				String strNEXT_INT_DMD_DATE="",strLR_INT_FREQ_START_DD="";
				String strColumnDelimitor="^",strRowDelimitor="~";
				
				//Commented by Anees on 23/04/2014 as told by Prakash - since for OD accounts this calculation is not required
				/*if(strfacility_repaytype.equalsIgnoreCase("EI"))
				{
					//EI Account 
					strMulti_schedule_num="1";
					strSchedule_details=null;
				}
				else
				{
					//Otherthan EI
					if(rs!=null)
					{
						rs.close();
					}
					strQuery=SQLParser.getSqlQuery("sel_multi_schedule_num^"+strAppNo+"^"+strFacilitySno);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strMulti_schedule_num=Helper.correctNull((String)rs.getString("multi_schedule_num"));
					}
					if(rs!=null)
					{
						rs.close();
					}
					if(Integer.parseInt(Helper.correctInt(strMulti_schedule_num))>0)
					{
						strQuery=SQLParser.getSqlQuery("selflowstart_date^"+strAppNo+"^"+strFacilitySno);
						rs=DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							strFLOW_START_DATE=Helper.correctNull((String)rs.getString("flow_start_date"));
							strLR_FREQ_START_DD=Helper.correctNull((String)rs.getString("lr_freq_start_dd"));
						}
						if(rs!=null)
						{
							rs.close();
						}
						strQuery=SQLParser.getSqlQuery("sel_tl_repayschedule_loanaccount^"+strAppNo+"^"+strFacilitySno);
						rs=DBUtils.executeQuery(strQuery);
						if(Integer.parseInt(Helper.correctInt(strMulti_schedule_num))==1)
						{
							if(rs.next())
							{
								strNUM_OF_FLOWS=Helper.correctNull((String)rs.getString("num_of_flows"));
								strLR_FREQ_TYPE=Helper.correctNull((String)rs.getString("lr_freq_type"));
								strFLOW_AMT=Helper.correctNull((String)rs.getString("flow_amt"));
								
								
								strNEXT_INT_DMD_DATE=Helper.getIntDmdDate(strCurrentDate,strIntFreqTypeDR);
								
								
								if(!strNEXT_INT_DMD_DATE.equalsIgnoreCase(""))
								{
									strNEXT_INT_DMD_DATE=strNEXT_INT_DMD_DATE.replace("/", "-");
									strLR_INT_FREQ_START_DD=strNEXT_INT_DMD_DATE.substring(0,2);
								}
								else
								{
									strNEXT_INT_DMD_DATE="";strLR_INT_FREQ_START_DD="";
								}
								
								if(!strFLOW_START_DATE.equalsIgnoreCase(""))
								{
									//"select_month_enddate"
									String strMonthEndDate="";
									String strMonthend=SQLParser.getSqlQuery("select_month_enddate^"+strFLOW_START_DATE+"^"+strFLOW_START_DATE);
									ResultSet rsmonthend=DBUtils.executeQuery(strMonthend);
									if(rsmonthend.next())
									{
										strMonthEndDate=Helper.correctNull((String)rsmonthend.getString("next_int_dmd_date"));
									}
									if(strMonthEndDate.equalsIgnoreCase(strFLOW_START_DATE))
									{
										strLR_FREQ_START_DD="31";
									}
								}
								if(!strNEXT_INT_DMD_DATE.equalsIgnoreCase(""))
								{
									//"select_month_enddate"
									String strMonthEndDate="";
									String strMonthend=SQLParser.getSqlQuery("select_month_enddate^"+strNEXT_INT_DMD_DATE+"^"+strNEXT_INT_DMD_DATE);
									ResultSet rsmonthend=DBUtils.executeQuery(strMonthend);
									if(rsmonthend.next())
									{
										strMonthEndDate=Helper.correctNull((String)rsmonthend.getString("next_int_dmd_date"));
									}
									if(strMonthEndDate.equalsIgnoreCase(strNEXT_INT_DMD_DATE))
									{
										strLR_INT_FREQ_START_DD="31";
									}
								}
								
								
								strSchedule_details=strFLOW_ID+strColumnDelimitor+strNUM_OF_FLOWS+strColumnDelimitor+strFLOW_START_DATE+
									strColumnDelimitor+strLR_FREQ_TYPE+strColumnDelimitor+strLR_FREQ_START_DD+strColumnDelimitor+strFLOW_AMT+
									strColumnDelimitor+strNEXT_INT_DMD_DATE+strColumnDelimitor+strINTRATEFREQ+strColumnDelimitor+strLR_INT_FREQ_START_DD;
							}
						}
						else
						{
							int i=0;
							while(rs.next())
							{
								int inttempmonths=0;
								if(i>0)
								{
									if(strLR_FREQ_TYPE.equalsIgnoreCase("m"))
									{
										inttempmonths=Integer.parseInt(Helper.correctInt(strNUM_OF_FLOWS))*1;
									}
									else if(strLR_FREQ_TYPE.equalsIgnoreCase("q"))
									{
										inttempmonths=Integer.parseInt(Helper.correctInt(strNUM_OF_FLOWS))*3;
									}
									else if(strLR_FREQ_TYPE.equalsIgnoreCase("h"))
									{
										inttempmonths=Integer.parseInt(Helper.correctInt(strNUM_OF_FLOWS))*6;
									}
									else if(strLR_FREQ_TYPE.equalsIgnoreCase("y"))
									{
										inttempmonths=Integer.parseInt(Helper.correctInt(strNUM_OF_FLOWS))*12;
									}
									else
									{
										inttempmonths=0;
									}
									String strQuery7=SQLParser.getSqlQuery("sel_flowstartdate_loanaccount^"+strFLOW_START_DATE+"^"+inttempmonths+"^"+strFLOW_START_DATE+"^"+inttempmonths);
									ResultSet rs7=DBUtils.executeQuery(strQuery7);
									if(rs7.next())
									{
										strFLOW_START_DATE=Helper.correctNull((String)rs7.getString("flow_start_date"));
										strLR_FREQ_START_DD=Helper.correctNull((String)rs7.getString("lr_freq_start_dd"));
									}
									if(rs7!=null)
									{
										rs7.close();
									}
									strQuery7=SQLParser.getSqlQuery("sel_flowstartdate_loanaccount^"+strNEXT_INT_DMD_DATE+"^"+inttempmonths+"^"+strNEXT_INT_DMD_DATE+"^"+inttempmonths);
									rs7=DBUtils.executeQuery(strQuery7);
									if(rs7.next())
									{
										strNEXT_INT_DMD_DATE=Helper.correctNull((String)rs7.getString("flow_start_date"));
										strLR_INT_FREQ_START_DD=Helper.correctNull((String)rs7.getString("lr_freq_start_dd"));
									}
									if(rs7!=null)
									{
										rs7.close();
									}
								}
								strNUM_OF_FLOWS=Helper.correctNull((String)rs.getString("num_of_flows"));
								strLR_FREQ_TYPE=Helper.correctNull((String)rs.getString("lr_freq_type"));
								strFLOW_AMT=Helper.correctNull((String)rs.getString("flow_amt"));
								if(i==0)
								{
									int intperiodnum=0;
									if(strIntFreqTypeDR.equalsIgnoreCase("m"))
									{
										intperiodnum=1;
									}
									else if(strIntFreqTypeDR.equalsIgnoreCase("q"))
									{
										intperiodnum=3;
									}
									else if(strIntFreqTypeDR.equalsIgnoreCase("h"))
									{
										intperiodnum=6;
									}
									else if(strIntFreqTypeDR.equalsIgnoreCase("y"))
									{
										intperiodnum=12;
									}

									strNEXT_INT_DMD_DATE=Helper.getIntDmdDate(strCurrentDate,strIntFreqTypeDR);
									
									if(!strNEXT_INT_DMD_DATE.equalsIgnoreCase(""))
									{
										strNEXT_INT_DMD_DATE=strNEXT_INT_DMD_DATE.replace("/", "-");
										strLR_INT_FREQ_START_DD=strNEXT_INT_DMD_DATE.substring(0,2);
									}
									else
									{
										strNEXT_INT_DMD_DATE="";strLR_INT_FREQ_START_DD="";
									}
								}
								
								if(!strFLOW_START_DATE.equalsIgnoreCase(""))
								{
									//"select_month_enddate"
									String strMonthEndDate="";
									String strMonthend=SQLParser.getSqlQuery("select_month_enddate^"+strFLOW_START_DATE+"^"+strFLOW_START_DATE);
									ResultSet rsmonthend=DBUtils.executeQuery(strMonthend);
									if(rsmonthend.next())
									{
										strMonthEndDate=Helper.correctNull((String)rsmonthend.getString("next_int_dmd_date"));
									}
									if(strMonthEndDate.equalsIgnoreCase(strFLOW_START_DATE))
									{
										strLR_FREQ_START_DD="31";
									}
								}
								if(!strNEXT_INT_DMD_DATE.equalsIgnoreCase(""))
								{
									//"select_month_enddate"
									String strMonthEndDate="";
									String strMonthend=SQLParser.getSqlQuery("select_month_enddate^"+strNEXT_INT_DMD_DATE+"^"+strNEXT_INT_DMD_DATE);
									ResultSet rsmonthend=DBUtils.executeQuery(strMonthend);
									if(rsmonthend.next())
									{
										strMonthEndDate=Helper.correctNull((String)rsmonthend.getString("next_int_dmd_date"));
									}
									if(strMonthEndDate.equalsIgnoreCase(strNEXT_INT_DMD_DATE))
									{
										strLR_INT_FREQ_START_DD="31";
									}
								}
								
								if(strSchedule_details.equalsIgnoreCase(""))
								{
									strSchedule_details=strFLOW_ID+strColumnDelimitor+strNUM_OF_FLOWS+strColumnDelimitor+strFLOW_START_DATE+
									strColumnDelimitor+strLR_FREQ_TYPE+strColumnDelimitor+strLR_FREQ_START_DD+strColumnDelimitor+strFLOW_AMT+
									strColumnDelimitor+strNEXT_INT_DMD_DATE+strColumnDelimitor+strINTRATEFREQ+strColumnDelimitor+strLR_INT_FREQ_START_DD;
								}
								else
								{
									strSchedule_details=strSchedule_details+strRowDelimitor+strFLOW_ID+strColumnDelimitor+strNUM_OF_FLOWS+strColumnDelimitor+strFLOW_START_DATE+
									strColumnDelimitor+strLR_FREQ_TYPE+strColumnDelimitor+strLR_FREQ_START_DD+strColumnDelimitor+strFLOW_AMT+
									strColumnDelimitor+strNEXT_INT_DMD_DATE+strColumnDelimitor+strINTRATEFREQ+strColumnDelimitor+strLR_INT_FREQ_START_DD;
								}
								i++;
							}
						}
						
						if(rs!=null)
						{
							rs.close();
						}
					}
				}*/
				
				//End of Non EMI
				/*SanctionDetails="";
				SanctionDetails=strCustCBSId+"|"+strSchemeCode+"|"+strGLSubHeadCode+"|"+strModeOfOperCode+"|"+strPBPSCode+"|"+
								strPSFreqType+"|"+strPSFreqWeekDay+"|"+strFreqStartDD+"|"+strFreqHldyStat+"|"+strPSDespatchMode+"|"+
								strIntTBLCode+"|"+strIDDRPrefPerc+"|"+strIntFreqTypeDR+"|"+strIntFreqStartDDDR+"|"+strIntFreqHldyStatDR+"|"+
								strNextIntRunDateDR+"|"+strSanctLim+"|"+strSanctLim+"|"+strSanctLim+"|"+strLimSanctDate+"|"+
								strLimExpDate+"|"+strLoanPaperDate+"|"+strSanctLevlCode+"|"+strSanctAuthCode+"|"+strSanctRefNum+"|"+
								strDescOfSecurity+"|"+strDrwngPowerInd+"|"+strLimitB2kid+"|"+strDrwngPowerPcnt+"|"+strDrwngPower+"|"+
								strFreeCode6+"|"+strFreeCode7+"|"+strFreeCode8;
				String strGetCurDateTime=Helper.getCurrentDateTime();
				String[] strSplitted=strGetCurDateTime.split("/");
				String strDateVal="";
				for(int z=0;z<strSplitted.length;z++)
				{
					strDateVal=strDateVal+strSplitted[z];
				}
				strFile="ACC"+strDateVal+"_"+strAppNo+".TXT";
				strFileName = strPath + "/" +strFile;
				File file = new File(strFileName);
				RandomAccessFile raf = new RandomAccessFile(file, "rw");
				raf.seek(file.length());
				raf.writeBytes(SanctionDetails);
				raf.writeBytes("\n");
				raf.close();*/
				/*hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId", "deleteAccountHandOffDetails");
				arrValues.add(strAppNo);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);*/
				
				
				String strfacdesc="",strfacype="";
				strQuery=SQLParser.getSqlQuery("selCBSproduct^"+strPrdCode);
				rs=DBUtils.executeQuery(strQuery);
				
				if(rs.next())
				{
					strfacdesc=Helper.correctNull((String)rs.getString("com_facdesc"));
					strfacype=Helper.correctNull((String)rs.getString("com_facility_loantype"));
				}
				if(strfacdesc.equalsIgnoreCase("KCC") && strfacype.equalsIgnoreCase("OD"))
				{
					strDrwngPowerInd="M";
				}
				
				
				String strSecid="",strQuery8="";
				ResultSet rs8=null;
				strQuery8=SQLParser.getSqlQuery("sel_securityid^"+strAppNo+"^"+strFacilitySno);
				rs8=DBUtils.executeQuery(strQuery8);
				if(rs8.next())
				{
					strSecid=Helper.correctNull((String)rs8.getString("APP_SEC_SECID"));
				}
				if(rs8!=null)
				{rs8.close();}
				strQuery8=SQLParser.getSqlQuery("sel_securitycbscode^"+Helper.correctInt((String)strSecid));
				rs8=DBUtils.executeQuery(strQuery8);
				if(rs8.next())
				{
					strSecurityCode=Helper.correctNull((String)rs8.getString("sec_cbssecurity"));
				}
				if(rs8!=null)
				{rs8.close();}
				
				//DSA - BSA ID taken from appinwardreg table
				if(rs!=null)rs.close();
				strQuery = SQLParser.getSqlQuery("sel_inward_proposed_values^"+strAppNo);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strDSAID=Helper.correctNull(rs.getString("inward_agentid"));
				}
				
				//Project Loan & DCCO Date
				if(rs!=null)
				rs.close();
				rs=DBUtils.executeLAPSQuery("sel_management^BreifDetaisTL^"+strFacilitySno+"^"+strAppNo);
				if(rs.next())
				{
					strProjectLoan=Helper.correctNull(rs.getString("com_projectloan"));
					strDCCODate=Helper.correctNull(rs.getString("com_date"));
				}
				
				String strStageWiseRelease="";
				if(rs!=null)
				rs.close();
				strQuery = SQLParser.getSqlQuery("sel_allcomments1^" + strAppNo+"^repaycomment^"+strFacilitySno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strStageWiseRelease=Helper.correctNull(rs.getString("FIN_STAGEWISE_RELEASE"));
				}
				if(rs!=null)
					rs.close();
				
                    String fbilfreq="";
					strQuery = SQLParser.getSqlQuery("sel_corpmclrresetfreq^"+ strAppNo+"^"+strFacilitySno);
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) {
						
					strSchemeCode = Helper.correctNull((String) rs.getString("mclr_tablecode"));
					fbilfreq= Helper.correctNull((String) rs.getString("FBILL_FRQ"));
					if (strSchemeCode.equalsIgnoreCase("AGSEC")|| strSchemeCode.equalsIgnoreCase("NGSEC")|| strSchemeCode.equalsIgnoreCase("ATBIL")|| strSchemeCode.equalsIgnoreCase("NTBIL")) {
						strResetFreqFlag = "Q";
					}else if(strSchemeCode.equalsIgnoreCase("AMD07")||strSchemeCode.equalsIgnoreCase("NMD07")
							||strSchemeCode.equalsIgnoreCase("AMD14")||strSchemeCode.equalsIgnoreCase("NMD14")
							||strSchemeCode.equalsIgnoreCase("AMM01")||strSchemeCode.equalsIgnoreCase("NMM01")
							||strSchemeCode.equalsIgnoreCase("AMM02")||strSchemeCode.equalsIgnoreCase("NMM02")
							||strSchemeCode.equalsIgnoreCase("AMM03")||strSchemeCode.equalsIgnoreCase("NMM03")
							||strSchemeCode.equalsIgnoreCase("AMM04")||strSchemeCode.equalsIgnoreCase("NMM04")
							||strSchemeCode.equalsIgnoreCase("AMM05")||strSchemeCode.equalsIgnoreCase("NMM05")
							||strSchemeCode.equalsIgnoreCase("AMM06")||strSchemeCode.equalsIgnoreCase("NMM06")
							||strSchemeCode.equalsIgnoreCase("AMM07")||strSchemeCode.equalsIgnoreCase("NMM07")
							||strSchemeCode.equalsIgnoreCase("AMM08")||strSchemeCode.equalsIgnoreCase("NMM08")
							||strSchemeCode.equalsIgnoreCase("AMM09")||strSchemeCode.equalsIgnoreCase("NMM09")
							||strSchemeCode.equalsIgnoreCase("AMM10")||strSchemeCode.equalsIgnoreCase("NMM10")
							||strSchemeCode.equalsIgnoreCase("AMM11")||strSchemeCode.equalsIgnoreCase("NMM11")
							||strSchemeCode.equalsIgnoreCase("AMM12")||strSchemeCode.equalsIgnoreCase("NMM12")){
						strResetFreqFlag=fbilfreq;
					}else
					{
						strResetFreqFlag=strResetFreqFlag;	
					}}
				if(rs!=null)
					rs.close();
				strQuery=SQLParser.getSqlQuery("sel_facility_interfacedetails^"+strAppNo+"^"+strFacilitySno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					SchemeCode=Helper.correctNull((String)rs.getString("scheme_code"));
				}
				if(rs!=null)
					rs.close();
				String com_facility_emischeme="", strncgtcSchemecode="";
				strQuery=SQLParser.getSqlQuery("chck_cgsdvalass_ncgtc^"+strAppNo+"^"+strFacilitySno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strncgtcSchemecode=Helper.correctNull((String)rs.getString("COM_BANKSCHEME"));
					com_facility_emischeme=Helper.correctNull((String)rs.getString("com_facility_emischeme"));
					if(strncgtcSchemecode.equals("070") && !com_facility_emischeme.equals("ODGEN") && !com_facility_emischeme.equals("ODPS"))
					{
						strResetFreqFlag="";
					}
				}
					
				hshQueryValues=new HashMap();
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
				{
					hshQuery.put("strQueryId","ins_FinacleAccCreation_corpagri_newconnection");

				}
				else
				{
				hshQuery.put("strQueryId", "ins_FinacleAccCreation_corpagri");
				}

				

				arrValues.add(strAppNo);//1
				arrValues.add(strCustCBSId);//2
				arrValues.add(SchemeCode);//3
				arrValues.add(strGLSubHeadCode);//4
				arrValues.add(strModeOfOperCode);//5
				arrValues.add(strPBPSCode);//6
				arrValues.add(strIntTBLCode);//7
				arrValues.add(strIDDRPrefPerc);//8
				arrValues.add(strSanctLim);//9
				arrValues.add(strRepPrdMths);//10
				arrValues.add(strRepPrdDays);//11
				arrValues.add(strOpAcId);//12
				arrValues.add(strIDMDEffDate);//13
				arrValues.add(strIntOnIDMDFlag);//14
				arrValues.add(strNumOfFlows);//15
				arrValues.add(strLRFreqType.toUpperCase());//16
				arrValues.add(strFlowStartDate);//17
				arrValues.add(strFlowAmt);//18
				arrValues.add(strLRIntFreqType);//19
				arrValues.add(strNextIntDmdDate);//20
				arrValues.add(strLimSanctDate);//21
				arrValues.add(strLimExpDate);//22
				arrValues.add(strLoanPaperDate);//23
				arrValues.add(strSanctLevlCode);//24
				arrValues.add(strSanctAuthCode);//25
				arrValues.add(strSanctRefNum);//26
				arrValues.add(strDescOfSecurity);//27
				arrValues.add(strDrwngPowerInd);//28
				arrValues.add(strLimitB2kid);//29
				arrValues.add(strDrwngPowerPcnt);//30
				arrValues.add(strDrwngPower);//31
				arrValues.add(strFreeCode6);//32
				arrValues.add(strFreeCode7);//33
				arrValues.add(strFreeCode8);//34
				arrValues.add(strMaxAlwdAdvnLim);//35
				arrValues.add(strPSFreqType);//36
				arrValues.add(strPSFreqWeekDay);//37
				arrValues.add(strFreqStartDD);//38
				arrValues.add(strFreqHldyStat);//39
				arrValues.add(strPSDespatchMode);//40
				arrValues.add(strIntFreqTypeDR);//41
				arrValues.add(strIntFreqStartDDDR);//42
				arrValues.add(strIntFreqHldyStatDR);//43
				arrValues.add(strNextIntRunDateDR);//44
				arrValues.add(strForAcID);//45
				arrValues.add(strSolID);//46
				arrValues.add(strLocalCallFlg);//47
				arrValues.add(strSectorCode);//48
				arrValues.add(strSubSectorCode);//49
				arrValues.add(strAcctOccpCode);//50
				arrValues.add(strBorrowerCatCode);//51
				arrValues.add(strAdvancePurpose);//52
				arrValues.add(strAdvanceMode);//53
				arrValues.add(strAdvanceType);//54
				arrValues.add(strAdvanceNature);//55
				arrValues.add(strGuarCoverCode);//56
				arrValues.add(strBSROccuCode);//57
				arrValues.add(strLBRCode);//58
				arrValues.add(strServiceAreaCode);//59
				arrValues.add(strLandHoldCode);//60
				arrValues.add(strBankScheme);//61
				arrValues.add(strSCSTCode);//62
				arrValues.add(strMinorityCode);//63
				arrValues.add(strSensitiveSectorCode);//64
				arrValues.add(strSecurityCode);//65
				arrValues.add(strDeptCode);//66
				arrValues.add(strFreeCode3);//67
				arrValues.add(strLRFreqStartDD);//68
				arrValues.add(strLrIntFreqHldyStat);//69
				arrValues.add(strHealthCode);//70
				arrValues.add(strRenewFlg);//71
				arrValues.add(strProcessedFlg);//72
				arrValues.add(strFacilitySno);//73
				arrValues.add(strMulti_schedule_num);//74
				arrValues.add(strSchedule_details);//75
				arrValues.add(strFile);//76
				arrValues.add(Helper.correctNull((String)hshValues.get("strRelationType")));//77
				arrValues.add(strResetFreqFlag);//78
				arrValues.add(strSHGCode);
				arrValues.add(strGovtSponsSch);
				arrValues.add(strDSAID);
				arrValues.add(strProjectLoan);
				arrValues.add(strDCCODate);
				arrValues.add(strFITLFlag);
				arrValues.add(strStageWiseRelease);
				arrValues.add(strBankingArrangement);
				arrValues.add(activityCode);
				arrValues.add(alliedactivityCode);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
				{
				   EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateCBSData");
									
				}
				else
				{
				   EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
									
				}
				hshQueryValues=new HashMap();
				hshQuery=new HashMap();
				hshQuery.put("strQueryId", "insertAccountHandOffDetails");
				arrValues = new ArrayList();
				arrValues.add(strAppNo);//1
				arrValues.add(strCustCBSId);//2
				arrValues.add(SchemeCode);//3
				arrValues.add(strGLSubHeadCode);//4
				arrValues.add(strModeOfOperCode);//5
				arrValues.add(strPBPSCode);//6
				arrValues.add(strIntTBLCode);//7
				arrValues.add(strIDDRPrefPerc);//8
				arrValues.add(strSanctLim);//9
				arrValues.add(strRepPrdMths);//10
				arrValues.add(strRepPrdDays);//11
				arrValues.add(strOpAcId);//12
				arrValues.add(strIDMDEffDate);//13
				arrValues.add(strIntOnIDMDFlag);//14
				arrValues.add(strNumOfFlows);//15
				arrValues.add(strLRFreqType.toUpperCase());//16
				arrValues.add(strFlowStartDate);//17
				arrValues.add(strFlowAmt);//18
				arrValues.add(strLRIntFreqType);//19
				arrValues.add(strNextIntDmdDate);//20
				arrValues.add(strLimSanctDate);//21
				arrValues.add(strLimExpDate);//22
				arrValues.add(strLoanPaperDate);//23
				arrValues.add(strSanctLevlCode);//24
				arrValues.add(strSanctAuthCode);//25
				arrValues.add(strSanctRefNum);//26
				arrValues.add(strDescOfSecurity);//27
				arrValues.add(strDrwngPowerInd);//28
				arrValues.add(strLimitB2kid);//29
				arrValues.add(strDrwngPowerPcnt);//30
				arrValues.add(strDrwngPower);//31
				arrValues.add(strFreeCode6);//32
				arrValues.add(strFreeCode7);//33
				arrValues.add(strFreeCode8);//34
				arrValues.add(strMaxAlwdAdvnLim);//35
				arrValues.add(strPSFreqType);//36
				arrValues.add(strPSFreqWeekDay);//37
				arrValues.add(strFreqStartDD);//38
				arrValues.add(strFreqHldyStat);//39
				arrValues.add(strPSDespatchMode);//40
				arrValues.add(strIntFreqTypeDR);//41
				arrValues.add(strIntFreqStartDDDR);//42
				arrValues.add(strIntFreqHldyStatDR);//43
				arrValues.add(strNextIntRunDateDR);//44
				arrValues.add(strForAcID);//45
				arrValues.add(strSolID);//46
				arrValues.add(strLocalCallFlg);//47
				arrValues.add(strSectorCode);//48
				arrValues.add(strSubSectorCode);//49
				arrValues.add(strAcctOccpCode);//50
				arrValues.add(strBorrowerCatCode);//51
				arrValues.add(strAdvancePurpose);//52
				arrValues.add(strAdvanceMode);//53
				arrValues.add(strAdvanceType);//54
				arrValues.add(strAdvanceNature);//55
				arrValues.add(strGuarCoverCode);//56
				arrValues.add(strBSROccuCode);//57
				arrValues.add(strLBRCode);//58
				arrValues.add(strServiceAreaCode);//59
				arrValues.add(strLandHoldCode);//60
				arrValues.add(strBankScheme);//61
				arrValues.add(strSCSTCode);//62
				arrValues.add(strMinorityCode);//63
				arrValues.add(strSensitiveSectorCode);//64
				arrValues.add(strSecurityCode);//65
				arrValues.add(strDeptCode);//66
				arrValues.add(strFreeCode3);//67
				arrValues.add(strLRFreqStartDD);//68
				arrValues.add(strLrIntFreqHldyStat);//69
				arrValues.add(strHealthCode);//70
				arrValues.add(strRenewFlg);//71
				arrValues.add(strProcessedFlg);//72
				arrValues.add(strFacilitySno);//73
				arrValues.add("Y");//74
				arrValues.add(Helper.correctNull((String)hshValues.get("strUserId")));//75
				arrValues.add(strFile);//76
				arrValues.add(strMulti_schedule_num);//77
				arrValues.add(strSchedule_details);//78
				arrValues.add(Helper.correctNull((String)hshValues.get("strRelationType")));//79
				arrValues.add(strResetFreqFlag);//80
				arrValues.add(strSHGCode);
				arrValues.add(strGovtSponsSch);
				arrValues.add("");
				arrValues.add("");
				arrValues.add(strDSAID);
				arrValues.add(strProjectLoan);
				arrValues.add(strDCCODate);
				arrValues.add(strFITLFlag);
				arrValues.add("");
				arrValues.add("");
				arrValues.add(strStageWiseRelease);
				arrValues.add(strBankingArrangement);
				arrValues.add(activityCode);
				arrValues.add(alliedactivityCode);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");

				hshQuery=new HashMap();
				hshQuery.put("strQueryId", "update_facduedate");
				arrValues = new ArrayList();
				arrValues.add(strLimExpDate);
				arrValues.add(nf.format(dblFinalRate));
				arrValues.add(strAppNo);
				arrValues.add(strFacilitySno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				hshQueryValues.put("size", "2");
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			hshRecord.put("SanctionDetails",SanctionDetails);
		}
		catch (Exception e)
		{
			throw new EJBException("Error Occured  " + e.getMessage());
		}
		finally
		{
			try
			{
				if (rs != null)
				{
					rs.close();
				}
				if (rs1 != null)
				{
					rs1.close();
				}
				if (rs2 != null)
				{
					rs2.close();
				}
			}
			catch (Exception e)
			{
				e.printStackTrace();
			}
		}
		return hshRecord;
	}
 
}// END OF FINACLE INTERFACE BEAN