
package com.sai.laps.ejb.comrepayschedule;

import java.rmi.RemoteException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;
import java.text.DecimalFormat;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.ejb.comrepapptrack.ComRepAppTrackRemote;
import com.sai.laps.helper.ApplicantParams;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;


@Stateless(name = "ComRepayScheduleBean", mappedName = "ComRepayScheduleHome")
@Remote (ComRepayScheduleRemote.class)
public class ComRepayScheduleBean extends BeanAdapter
{	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	


	static Logger log=Logger.getLogger(ComRepayScheduleBean.class);	




	public HashMap getTermFinanceFac(HashMap hshRequestValues) 
	{
		
		ResultSet rs = null;
		ResultSet rs1 = null;
	 	String strQuery ="",strAppno="",strPagename="",strValue="",strQuery1="";
		HashMap hshResult = new HashMap();
		try
		{
			
			strAppno = correctNull((String)hshRequestValues.get("appno"));
			strPagename = correctNull((String)hshRequestValues.get("pagename"));
			
			if(strPagename.equalsIgnoreCase("EMI"))
			{
				strValue="E";
				strQuery = SQLParser.getSqlQuery("seltermfinancefac1^"+strAppno+"^"+strValue);
				rs = DBUtils.executeQuery(strQuery);
	  			while(rs.next())
				{
					String strCode= correctNull((String)rs.getString(1));
					String strName= correctNull((String)rs.getString(2));
					hshResult.put(strCode,strName);
				}
			}
			else if(strPagename.equalsIgnoreCase("NONEMI"))
			{
				strValue="'NE','OD','LC','CO','BG','DD','PC','PS'";
				String strLoanaccount="";  
				strQuery = SQLParser.getSqlQuery("seltermfinancefac_NE^"+strAppno+"^"+strValue);
				rs = DBUtils.executeQuery(strQuery);
	  			while(rs.next())
				{
					String strCode= correctNull((String)rs.getString(1));
					String strName= correctNull((String)rs.getString(2));
					String strFaccode= correctNull((String)rs.getString(4));
					strQuery1 = SQLParser.getSqlQuery("sel_otherdetails^"+strFaccode);
					rs1 = DBUtils.executeQuery(strQuery1);
		  			if(rs1.next())
					{
		  				strLoanaccount=Helper.correctNull((String)rs1.getString("COM_LOANACC"));
					}
		  			if(strLoanaccount.equalsIgnoreCase("Y"))
		  			{
		  				hshResult.put(strCode,strName);
		  			}
				}
			}
			if(rs != null)
				rs.close();
			rs = DBUtils.executeQuery(SQLParser.getSqlQuery("selfactypecheckrating^"+strAppno));
			if(rs.next())
			{
				hshResult.put("COM_BANKSCHEME", Helper.correctNull((String)rs.getString("COM_BANKSCHEME")));
			}
			if(rs != null)
				rs.close();

		}
		catch(Exception e)
		{
			throw new EJBException("Error in getTermFinanceFac  "+e.toString());
		}
		finally
		{
			try
			{	
				if(rs != null)
					rs.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshResult;
	}

	
	/*public HashMap getFacRepayment(HashMap hshRequestValues) 
	{
		
		ResultSet rs = null;
		String strQuery ="",strAction="",strAppno="",strFacno="",strMoratorium="";
		String strInstalment="",strPeriodicity="",strDisbursement="";
		double dblPrin=0.00,dblFac=0,dblInstalment=0;
 		ArrayList vecMon = new ArrayList();
		ArrayList vecYear = new ArrayList();
		java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		HashMap hshResult = new HashMap();
		try
		{
			
			strAppno = correctNull((String)hshRequestValues.get("appno"));
			strFacno = correctNull((String)hshRequestValues.get("selfacility"));
			strPeriodicity = correctNull((String)hshRequestValues.get("selperiodicity"));//mck
			if(!strFacno.trim().equals(""))
			{
				strQuery = SQLParser.getSqlQuery("selfacrepaymentval^"+strAppno+"^"+strFacno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strMoratorium = correctNull((String)rs.getString(1));
					dblInstalment =  rs.getDouble(2);
					strPeriodicity = correctNull((String)rs.getString(3));
					strDisbursement = correctNull((String)rs.getString(4));
					
					if (!strPeriodicity.trim().equalsIgnoreCase("C"))
					{
					
							int intStartMonth = rs.getInt(6);
							int intStartYear = rs.getInt(7);
							dblPrin = rs.getDouble(8);
							dblFac = dblPrin * dblInstalment;
							int intEndMonth = rs.getInt(9);
							int intEndYear = rs.getInt(10);
							int intInc =0,monCount=0,yearCount=0;
							if(strPeriodicity.trim().equals("M"))
							{
								intInc = 1;
							}
							else if(strPeriodicity.trim().equals("Q"))
							{
								intInc = 3;
							}
							if(strPeriodicity.trim().equals("H"))
							{
								intInc = 6;
							}
							if(strPeriodicity.trim().equals("Y"))
							{
								intInc = 12;
							}
							boolean flag=true;
							monCount = intStartMonth;
							yearCount = intStartYear;
							int intCount=1;
							for(double i=1;i<=dblInstalment;i++)
							{
								
								if(monCount>12)
								{
									monCount = monCount - 12;
									yearCount = yearCount + 1;
								}
								String strMonth="";
								if(monCount==1)
								{
									strMonth = "Jan";
								}
								else if(monCount==2)
								{
									strMonth = "Feb";
								}
								else if(monCount==3)
								{	strMonth = "Mar";
								}
								else if(monCount==4)
								{	strMonth = "Apr";
								}
								else if(monCount==5)
								{	strMonth = "May";
								}
								else if(monCount==6)
								{	strMonth = "Jun";
								}
								else if(monCount==7)
								{	strMonth = "Jul";
								}
								else if(monCount==8)
								{	strMonth = "Aug";
								}
								else if(monCount==9)
								{	strMonth = "Sep";
								}
								else if(monCount==10)
								{	strMonth = "Oct";
								}
								else if(monCount==11)
								{	strMonth = "Nov";
								}
								else if(monCount==12)
								{	strMonth = "Dec";
								}

								vecMon.add(strMonth);
								vecYear.add(Integer.toString(yearCount));
								monCount = monCount + intInc;
						}
					}
				}
			} 
			hshResult.put("vecmon",vecMon);
			hshResult.put("vecyear",vecYear);
			hshResult.put("prin",(String)jtn.format(dblPrin));
			hshResult.put("facamt",(String)jtn.format(dblFac));
			hshResult.put("selfacility",strFacno);
			hshResult.put("Moratorium",strMoratorium);
			hshResult.put("Instalment",Helper.formatDoubleValue(dblInstalment));
			hshResult.put("Periodicity",strPeriodicity);
			hshResult.put("Disbursement",strDisbursement);

					if (strPeriodicity.trim().equalsIgnoreCase("C"))
					{
						strQuery = SQLParser.getSqlQuery("comcomman^"+"comfacrepayment"+"^"+strAppno);
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							hshResult.put("comfacrepayment",correctNull(rs.getString(1)));
						}
						strQuery = SQLParser.getSqlQuery("selcomfacrepayment^"+strAppno+"^"+strFacno);
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							String strdate=correctNull(rs.getString(1));
							if (strdate.trim().equals("01/01/1900"))
							{
									hshResult.put("endon","");
							}
							else
							{
								hshResult.put("endon",strdate);
							}
						
						}

						
						hshResult.put("Disbursement",strDisbursement);
					}
				


		}
		catch(Exception e)
		{
			throw new EJBException("Error in getTermFinanceFac  "+e.toString());

		}
		finally
		{
			try
			{	
				if(rs != null)
					rs.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshResult;
	}*/
	
	public HashMap getFacRepayment(HashMap hshRequestValues) 
	{
		
 		ResultSet rs = null;
		String strQuery ="",strAppno="",strFacno="",strMoratorium="";
		String strPeriodicity="",strDisbursement="";
		double dblExist=0.00,dblProposed=0.00,dblDiff=0.00,dblTotDiff=0.00,dblTotExist=0.00;
		dblExist=0.00;
		dblProposed=0.00;
		dblDiff=0.00;
		double dblPrin=0.00,dblFac=0,dblInstalment=0, dblPrincipal=0.00;
 		ArrayList vecMon = new ArrayList();
		ArrayList vecYear = new ArrayList();
		java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(0);
		jtn.setMinimumFractionDigits(0);
		jtn.setGroupingUsed(false);
		HashMap hshResult = new HashMap();
		String strProposed="",strDiff="",strValuesin;
		boolean recordflag=false;
		try
		{			
			strAppno = correctNull((String)hshRequestValues.get("appno"));
			String strpageFrom = correctNull((String)hshRequestValues.get("pageFrom"));
			strFacno = correctNull((String)hshRequestValues.get("selfacility"));
			strValuesin = Helper.correctNull((String)hshRequestValues.get("valuesin"));
			
			strPeriodicity = correctNull((String)hshRequestValues.get("selperiodicity"));//mck
			if(!strFacno.trim().equals(""))
				{	if(rs != null){
					rs.close();
				}
				
				String strAppstatus="";
				
				strQuery = SQLParser.getSqlQuery("sel_appstatusnew^"+strAppno);	
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strAppstatus=Helper.correctNull(rs.getString("app_status"));
				}
				strQuery = SQLParser.getSqlQuery("select_facilityproposed^"+strAppno+"^"+strFacno);	
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					dblExist =rs.getDouble("facility_existing");
					dblProposed =Double.parseDouble(Helper.convertApplicationToSetup(strValuesin, Double.parseDouble(Helper.correctDouble(rs.getString("facility_proposed")))));
					String Strperidicity = Helper.correctNull(rs.getString("FACILITY_PERINSTALL"));
					int intMoritorium = Integer.parseInt(Helper.correctInt(rs.getString("FACILITY_HOLIDAYPERIOD")));
					int intterm = Integer.parseInt(Helper.correctInt(rs.getString("FACILITY_MONTHS")));
					int  terms = intterm - intMoritorium;
					double dblrecamt=Double.parseDouble(Helper.correctDouble(rs.getString("FACILITY_SANCAMT")));
					String strInttype =  Helper.correctNull(rs.getString("FACILITY_INTTYPE"));
					String strCalmonth ="";
					if(strAppstatus.equalsIgnoreCase("op"))
					{
						strCalmonth= Helper.getCurrentDateTime();
					}
					else
					{
						strCalmonth=Helper.correctNull(rs.getString("FAC_PROCESSDATE"));	
					}
					String strInteresttype=Helper.correctNull(rs.getString("FACILITY_INTERESTREC"));
					String strIntcharged=Helper.correctNull(rs.getString("FACILITY_INTERESTCHARGED"));
					
					double dblInterestrate=Double.parseDouble(Helper.correctDouble(rs.getString("FACILITY_SANCINTEREST")));
					
					hshResult.put("Instalment", String.valueOf(terms));
					hshResult.put("Moratorium", String.valueOf(intMoritorium));
					hshResult.put("Disbursement", strCalmonth);
					hshResult.put("Periodicity", Strperidicity);
					hshResult.put("FacilityDesc", Helper.correctNull(rs.getString("COM_FACDESC")));
					if(dblInterestrate>0 && terms>0  && dblrecamt>0)
					{
							if(strInteresttype.equalsIgnoreCase("Y") && intMoritorium < 0)
							{
								hshRequestValues.put("terms", String.valueOf(terms));
								hshRequestValues.put("terms2", String.valueOf(intMoritorium));
								hshRequestValues.put("recmdAmt", String.valueOf(dblrecamt));
								hshRequestValues.put("hidrepaymenttype", "amort");
								hshRequestValues.put("inttype", strInttype);
								hshRequestValues.put("strCalmonth", strCalmonth);
								hshRequestValues.put("modIntRate", String.valueOf(dblInterestrate));
							}
							else
							{
								hshRequestValues.put("terms", String.valueOf(terms+intMoritorium));
								hshRequestValues.put("terms2", String.valueOf(intMoritorium));
								hshRequestValues.put("recmdAmt", String.valueOf(dblrecamt));
								hshRequestValues.put("hidrepaymenttype", "amort");
								hshRequestValues.put("inttype", strInttype);
								hshRequestValues.put("strCalmonth", strCalmonth);
								hshRequestValues.put("modIntRate", String.valueOf(dblInterestrate));
							}
							hshRequestValues.put("sel_interestcharge", strIntcharged);
					}
					HashMap hshAmort = new HashMap();
					hshAmort=calculateAmortizationCorporate(hshRequestValues);
					strProposed = Helper.formatDoubleValue(dblProposed);
					strDiff = Helper.formatDoubleValue(dblProposed);
					hshResult.put("arryRow",hshAmort.get("arryRow"));
					hshResult.put("strAppno",strAppno);
					hshResult.put("txt_date",hshAmort.get("txt_date"));
					hshResult.put("loan_noofinstallment",hshAmort.get("loan_noofinstallment"));
					hshResult.put("prin",hshAmort.get("strEmi"));
					hshResult.put("sel_interestcharge",strIntcharged);
				}
				hshResult.put("strDiff",strProposed);
				if(rs != null)
				{
					rs.close();
				}
			} 
			hshResult.put("facamt",strProposed);
			hshResult.put("selfacility",strFacno);
			hshResult.put("pageFrom",strpageFrom);
			 if(recordflag)
				hshResult.put("recordflag","Y");
			else
			   hshResult.put("recordflag","N");
			

					if (strPeriodicity.trim().equalsIgnoreCase("C"))
					{
						strQuery = SQLParser.getSqlQuery("comcomman^"+"comfacrepayment"+"^"+strAppno);
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							hshResult.put("comfacrepayment",correctNull(rs.getString(1)));
						}
						strQuery = SQLParser.getSqlQuery("selcomfacrepayment^"+strAppno+"^"+strFacno);
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							String strdate=correctNull(rs.getString(1));
				 			if (strdate.trim().equals("01/01/1900"))
							{
									hshResult.put("endon","");
							}
							else
							{
								hshResult.put("endon",strdate);
							}
						}
						hshResult.put("Disbursement",strDisbursement);
					}

		}
		catch(Exception e)
		{
			throw new EJBException("Error in getTermFinanceFac  "+e.toString());

		}
		finally
		{
			try
			{	
				if(rs != null)
					rs.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshResult;
	}



	public void updFacRepayment(HashMap hshRequestValues) 
	{
		
		ResultSet rs = null;
		String strQuery ="",strAction="",strAppno="",strFacno="",strMoratorium="";
		String strInstalment="",strPeriodicity="",strDisbursement="",strRepayEndon="",strConvert="",strEnd="",strSchedule="";
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
 
		try
		{
			
			strAction = correctNull((String)hshRequestValues.get("hidAction"));
			strAppno = correctNull((String)hshRequestValues.get("appno"));
			strFacno = correctNull((String)hshRequestValues.get("selfacility"));
			strMoratorium = correctNull((String)hshRequestValues.get("txt_moratorium"));
			strInstalment = correctNull((String)hshRequestValues.get("txt_noofinstalmt"));
			strPeriodicity = correctNull((String)hshRequestValues.get("selperiodicity"));
			strDisbursement = correctNull((String)hshRequestValues.get("txt_disbursement"));

			strEnd = correctNull((String)hshRequestValues.get("txt_endon"));  //mck
			strSchedule = correctNull((String)hshRequestValues.get("txt_schedule"));//mck

			if(strAction.trim().equals("update"))
			{
				strConvert="1";
					double val =0;
					val = Double.parseDouble(strInstalment);

					if(strPeriodicity.trim().equals("M"))
					{
						strConvert = Helper.formatDoubleValue(1*val);
					}
					else if(strPeriodicity.trim().equals("Q"))
					{
						strConvert =Helper.formatDoubleValue(3 *val);
					}
					if(strPeriodicity.trim().equals("H"))
					{
						strConvert = Helper.formatDoubleValue(6  * val);
					}
					if(strPeriodicity.trim().equals("Y"))
					{
						strConvert = Helper.formatDoubleValue(12 * val);
					}
				if (strPeriodicity.trim().equalsIgnoreCase("C"))  //mck
				{
					strRepayEndon=strEnd;
				}
				else
				{
					strQuery = SQLParser.getSqlQuery("findrepayendon^"+strConvert+"^"+strMoratorium+"^"+strDisbursement);
					//strQuery = SQLParser.getSqlQuery("getrepayendondata^"+strConvert+"^"+strMoratorium+"^"+strDisbursement);
					//rs = DBUtils.executeQuery(strQuery);
					strRepayEndon = "23/01/2007";
					/*if(rs.next())
					{
						strRepayEndon = rs.getString(1);
					}*/
					if(rs != null)
						rs.close();
				}
				strQuery = SQLParser.getSqlQuery("selfacrepaymentvalue^"+strAppno+"^"+strFacno);
				//strQuery = SQLParser.getSqlQuery("selfacrepaymentval^"+strAppno+"^"+strFacno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshQuery.put("strQueryId","updfacrepayment");
					arrValues.add(strMoratorium.trim());
					arrValues.add(strInstalment.trim());
					arrValues.add(strPeriodicity.trim());
					arrValues.add(strDisbursement.trim());
					arrValues.add(strRepayEndon.trim());
					arrValues.add(strAppno.trim());
					arrValues.add(strFacno.trim());
				}
				else
				{
					hshQuery.put("strQueryId","insfacrepayment");
					arrValues.add(strAppno);
					arrValues.add(strFacno);
					arrValues.add(strMoratorium);
					arrValues.add(strInstalment);
					arrValues.add(strPeriodicity);
					arrValues.add(strDisbursement);
					arrValues.add(strRepayEndon);
				}
			}
			else if(strAction.trim().equals("delete"))
			{
				hshQuery.put("strQueryId","delfacrepayment");
				arrValues.add(strAppno);
				arrValues.add(strFacno);
			}

			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);	
			
			if (strPeriodicity.trim().equalsIgnoreCase("C"))  //mck
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","comfacrepaymendelete");
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","2");
				hshQueryValues.put("2",hshQuery);	

				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","comimporttins");
				arrValues.add(strAppno);
				arrValues.add("comfacrepayment");
				arrValues.add(strSchedule);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","3");
				hshQueryValues.put("3",hshQuery);	
			}


			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");

			
			if(Helper.correctNull((String)hshRequestValues.get("hidRecordflag")).equalsIgnoreCase("N"))
			{
				hshRequestValues.put("hidAction","Insert");
			}
			strAction = Helper.correctNull((String)hshRequestValues.get("hidAction"));
			StringBuilder sbAuditTrial=new StringBuilder();
			if(!(strAction.trim().equals("delete"))){
			sbAuditTrial.append("Term Finance Facilities  =").append(correctNull((String)hshRequestValues.get("selfacility1"))).append("~Moratorium (Months) =").append(correctNull((String)hshRequestValues.get("txt_moratorium")))
			.append("~No of Installments =").append(correctNull((String)hshRequestValues.get("txt_noofinstalmt"))).append("~Repayment Periodicity =").append(ApplicantParams.getApplicantParams("RepaymentCorporate",correctNull((String)hshRequestValues.get("selperiodicity"))))
			.append("~First disbursement on =").append(correctNull((String)hshRequestValues.get("txt_disbursement")));
			if(correctNull((String)hshRequestValues.get("selperiodicity")).equals(""))
			{
				sbAuditTrial.append("Repay end on Date =").append(correctNull((String)hshRequestValues.get("txt_endon")));
			}
		}
			
			
			
			if(correctNull((String)hshRequestValues.get("cattype")).equalsIgnoreCase("OPS"))
			{	
				AuditTrial.auditLog(hshRequestValues,"188",strAppno,sbAuditTrial.toString());
			}
			else
			{
				AuditTrial.auditLog(hshRequestValues,"161",strAppno,sbAuditTrial.toString());
			}

		}
		catch(Exception e)
		{
			throw new EJBException("Error in getTermFinanceFac  "+e.toString());

		}
		finally
		{
			try
			{	
				if(rs != null)
					rs.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
	}
	
	public  HashMap getFacNonEMIRepayment(HashMap hshValues) 
	{
		String strQuery="";
		ResultSet rs=null;	
		ResultSet rs1=null;	
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol = new ArrayList();
		String strappno="";
		String strfacility="";
		String strfacamt="";
		String strvaluesin="";
		double dblTotal=0;
		java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		int intRepayperiod=0,intHolidayperiod=0;
		int strStaffMaxRepay_prin=0,strStaffMaxRepay_intr=0;
		String strFacinstallment="",strSelType="";
		 double dblSanctionAmount=0.0;
			int strLoanTenor=0;
		try
		{
			strfacility=correctNull((String)hshValues.get("facility"));
			if(strfacility=="")
			strfacility=correctNull((String)hshValues.get("select_facility"));
			if(strfacility=="")
				strfacility="0";
			strvaluesin=Helper.correctNull((String)hshValues.get("valuesin"));
			strappno = correctNull((String)hshValues.get("appno"));
			if(strappno.equalsIgnoreCase(""))
				strappno = correctNull((String)hshValues.get("strappno"));
			String strpageid=correctNull((String)hshValues.get("hiPgDist"));
		
					if(strpageid.equalsIgnoreCase("P"))
					{
						//For retail facility should be 1
						strfacility="1";
						double dblSancAmt=0.00,dblIntr=0.00,dblIntrAmt=0.00;
						int intTenor=0,intHoliday=0;
						strSelType=Helper.correctNull((String)hshValues.get("selRepaymentFor"));
						if(strSelType.equalsIgnoreCase(""))
						{
							strSelType="P";
						}
						String strQuery1 = SQLParser.getSqlQuery("pergetloanProduct_selsancamount^"+strappno);
						   rs =  DBUtils.executeQuery(strQuery1);
						   if(rs.next())
						   {
							   	strfacamt=(Helper.correctDouble(rs.getString("sancamount"))); 
							   	dblSancAmt=Double.parseDouble(Helper.correctDouble(rs.getString("sancamount")));
						   		dblIntr=Double.parseDouble(Helper.correctDouble(rs.getString("loan_modintrate")));
						   		intTenor=Integer.parseInt(Helper.correctInt(rs.getString("loan_reqterms")));
						   		intHoliday=Integer.parseInt(Helper.correctInt(rs.getString("loan_noofinstallment")));
						   		intTenor=intTenor-intHoliday;
						   		hshValues.put("strMaxRepaymentperiodPrin", String.valueOf(intTenor));
						   		hshValues.put("strRepaymentType", Helper.correctNull(rs.getString("loan_repaymenttype")));
						   		
						   		strLoanTenor=Integer.parseInt(Helper.correctInt(rs.getString("loan_reqterms")));
								dblSanctionAmount=Double.parseDouble(Helper.correctDouble(rs.getString("sancamount")));
						   }
						   rs =  DBUtils.executeLAPSQuery("securesel^"+strappno);
						   if(rs.next())
						   {
							   strFacinstallment=Helper.correctNull(rs.getString("loan_periodicity"));
						   }
						   if(rs!= null) 
							{rs.close();}
						   rs =  DBUtils.executeLAPSQuery("pergetloanProduct^"+strappno);
						   if(rs.next())
						   {
							   hshValues.put("strprd_desc", Helper.correctNull(rs.getString("prd_desc")));
						   }
						   if(rs!= null) 
							{rs.close();}
						   strQuery1 = SQLParser.getSqlQuery("findapptype^"+strappno);
						   rs =  DBUtils.executeQuery(strQuery1);
						   if(rs.next())
						   {
							   if((Helper.correctNull(rs.getString("prd_type")).equalsIgnoreCase("pH")||Helper.correctNull(rs.getString("prd_type")).equalsIgnoreCase("pA"))&&Helper.correctNull(rs.getString("prd_staffprd")).equalsIgnoreCase("Y"))
							   {
								   	   strStaffMaxRepay_prin=Integer.parseInt(Helper.correctInt(rs.getString("prd_staff_maxterm_prin")));
									   strStaffMaxRepay_intr=Integer.parseInt(Helper.correctInt(rs.getString("prd_staff_maxterm_intr")));
									   hshValues.put("strstaffProduct", Helper.correctNull(rs.getString("prd_staffprd")));
									   hshValues.put("strMaxRepaymentperiodPrin", String.valueOf(strStaffMaxRepay_prin));
									   hshValues.put("strMaxRepaymentperiodIntr", String.valueOf(strStaffMaxRepay_intr));
									   dblIntr=dblIntr/100;
									   dblIntrAmt=(dblSancAmt*intTenor*dblIntr)/100;
									   hshValues.put("strInterestAmt", jtn.format(dblIntrAmt));
									   
									   
							   }
						   }
						   
						   if(rs!=null)
								rs.close();
							rs = DBUtils.executeLAPSQuery("selinwardappdata^" + strappno);
							if (rs.next())
							{
								
								if(Helper.correctNull(rs.getString("app_renew_flag")).equalsIgnoreCase("P"))
								{
									if(rs1!=null)
										rs1.close();
									rs1 = DBUtils.executeLAPSQuery("getappamt^" + Helper.correctNull(rs.getString("APP_PARENT_APPNO")));
									if(rs1.next())
									{
										if((strLoanTenor<Integer.parseInt(Helper.correctInt(rs1.getString("loan_reqterms"))))||
												(dblSanctionAmount<Double.parseDouble(Helper.correctDouble(rs1.getString("loan_recmdamt")))))
										{
											hshValues.put("strRepayFlag","Y");
										}
									}
								}
									
							}
							
							if(rs!=null) rs.close();
							strQuery = SQLParser.getSqlQuery("sel_pageid_PSapp^"+strappno);
							rs = DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								hshValues.put("strModifyterms", "@"+Helper.correctNull(rs.getString("ps_modify_terms")));
							}
						   
					}
					else
					{
			String strQuery1 = SQLParser.getSqlQuery("sel_tl_fac^"+strappno+"^"+strfacility);
		
			rs = DBUtils.executeQuery(strQuery1);
			if(rs.next())
			{
				strfacamt= jtn.format(Double.parseDouble(Helper.convertApplicationToSetup(strvaluesin,Double.parseDouble(Helper.correctDouble(rs.getString("FACILITY_SANCAMT"))))));
				intRepayperiod=Integer.parseInt(Helper.correctInt(rs.getString("facility_months")));
				intHolidayperiod=Integer.parseInt(Helper.correctInt(rs.getString("facility_holidayperiod")));
				strFacinstallment=Helper.correctNull(rs.getString("facility_perinstall"));
			}
			intRepayperiod=intRepayperiod-intHolidayperiod;
			hshValues.put("strMaxRepaymentperiodPrin", String.valueOf(intRepayperiod));
			//hshValues.put("arrtlfac",arrRow);
					}
					hshValues.put("strRepaymentperiod", String.valueOf(intRepayperiod));
					hshValues.put("strfacamt",strfacamt);
			if(rs!= null)
			{
				rs.close();
			}
			double dblTotsanamt=0.00;
			int intTotRepayperiod=0,intFacRepayperiod=0;
			arrRow = new ArrayList();
			String strQuery2="";
			if((Helper.correctNull((String)hshValues.get("strProductType")).equalsIgnoreCase("pH")||Helper.correctNull((String)hshValues.get("strProductType")).equalsIgnoreCase("pA"))&&Helper.correctNull((String)hshValues.get("strstaffProduct")).equalsIgnoreCase("Y"))
				strQuery2 = SQLParser.getSqlQuery("sel_tl_repayschedulestaffloan^"+strappno+"^"+strfacility+"^"+strSelType);
			else
				strQuery2 = SQLParser.getSqlQuery("sel_tl_repayschedule^"+strappno+"^"+strfacility);
			rs=DBUtils.executeQuery(strQuery2);
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString(1)));
				arrCol.add(correctNull(rs.getString(2)));
				arrCol.add(correctNull(rs.getString(3)));
				arrCol.add(correctNull(rs.getString(4)));
				arrCol.add(correctNull(rs.getString(5)));
				arrCol.add(correctNull(rs.getString(6)));
				dblTotsanamt=dblTotsanamt+Double.parseDouble(Helper.correctDouble((String)rs.getString(6)));
				if(Helper.correctNull((String)rs.getString(3)).equalsIgnoreCase("M")){
					intFacRepayperiod=Integer.parseInt(Helper.correctInt((String)rs.getString(4)));
				}else if(Helper.correctNull((String)rs.getString(3)).equalsIgnoreCase("Q")){
					intFacRepayperiod=Integer.parseInt(Helper.correctInt((String)rs.getString(4)))*3;
				}
				else if(Helper.correctNull((String)rs.getString(3)).equalsIgnoreCase("H")){
					intFacRepayperiod=Integer.parseInt(Helper.correctInt((String)rs.getString(4)))*6;
				}
				else if(Helper.correctNull((String)rs.getString(3)).equalsIgnoreCase("Y")){
					intFacRepayperiod=Integer.parseInt(Helper.correctInt((String)rs.getString(4)))*12;
				}
				intTotRepayperiod=intTotRepayperiod+intFacRepayperiod;
				String strQuery6 = SQLParser.getSqlQuery("sel_tl_spfac^"+strappno+"^"+correctNull((String)rs.getString(2)));
				rs1=DBUtils.executeQuery(strQuery6);
				if(rs1.next())
				{
					arrCol.add(correctNull(rs1.getString("fac_desc")));
				}
				else
				{
					arrCol.add("");
				}
				if((Helper.correctNull((String)hshValues.get("strProductType")).equalsIgnoreCase("pH")||Helper.correctNull((String)hshValues.get("strProductType")).equalsIgnoreCase("pA"))&&Helper.correctNull((String)hshValues.get("strstaffProduct")).equalsIgnoreCase("Y"))
					arrCol.add(strSelType);
				else
					arrCol.add("");
				arrRow.add(arrCol);
			}
			hshValues.put("strEditFlag","N");
			//To select the post sanction parameters
			//String strTemp = "and PS_APP_SNO='"+strfacility+"'";
			String strQueryPS = SQLParser.getSqlQuery("sel_postsanctiondet^"+strfacility+"^"+strappno);
			ResultSet rsPS = DBUtils.executeQuery(strQueryPS);
			if(rsPS.next())
			{
				hshValues.put("strPostSancParam", Helper.correctNull(rsPS.getString("PS_MODIFY_TERMS")));
				hshValues.put("strEditFlag","Y");
			}
			  if(rs!= null)
				{rs.close();}
			   strQuery = SQLParser.getSqlQuery("sel_facilityDesc^"+strappno+"^"+strfacility);
			   rs =  DBUtils.executeQuery(strQuery);
			   if(rs.next())
			   {
				   hshValues.put("FacilityDesc", Helper.correctNull(rs.getString("fac_desc")));
			   }
			
			//selGradedValue 
			hshValues.put("strfacility",correctNull((String)hshValues.get("select_facility")));
			hshValues.put("selfacility",strfacility);
			hshValues.put("arrtlrec",arrRow);
			hshValues.put("dblTotalrsch",jtn.format(dblTotal));
			hshValues.put("dblTotalfacRepayamt",String.valueOf(dblTotsanamt));
			hshValues.put("dblTotalfacPeriod",String.valueOf(intTotRepayperiod));
			hshValues.put("strFacinstallment",strFacinstallment);
			hshValues.put("strRepaymentfor",strSelType);
			if(rs != null)
				rs.close();
			rs = DBUtils.executeQuery(SQLParser.getSqlQuery("selfactypecheckrating^"+strappno));
			if(rs.next())
			{
				hshValues.put("COM_BANKSCHEME", Helper.correctNull((String)rs.getString("COM_BANKSCHEME")));
			}
			if(rs != null)
				rs.close();
		}	
		catch (Exception e)
		{
			throw new EJBException("Error in getNonemirepayschedule== "+e.toString());
		}
		finally
		{
			try
			{
				if(rs!= null)
				{
					rs.close();
				}
				if(rs1!= null)
				{
					rs1.close();
				}
			}
			catch (Exception e1)
			{
				throw new EJBException("Error in Closing connection== "+e1.toString());
			}
		}
		return hshValues;
	}
	
	public void updateFacNonEMIRepayment(HashMap hshValues) 
	{
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		ArrayList arrValues ;		 
		ResultSet rs=null;
		
		String strappno = correctNull((String)hshValues.get("appno"));
		if(strappno.equalsIgnoreCase(""))
			strappno = correctNull((String)hshValues.get("strappno"));
		
		String strAction =correctNull((String)hshValues.get("hidAction"));
		String strfacility = correctNull((String)hshValues.get("select_facility"));	
		String strfrequency = correctNull((String)hshValues.get("sel_frequency"));
		String strnooffrequency= correctNull((String)hshValues.get("txt_noofinst"));
		String strinstamt = Helper.correctDouble((String)hshValues.get("txt_instamt"));	
		String strtotamt = Helper.correctDouble((String)hshValues.get("txt_totamt"));	
		String strSno=Helper.correctDouble((String)hshValues.get("hidsno"));
		String strpageid=correctNull((String)hshValues.get("hiPgDist"));
		String strStaffLoan=correctNull((String)hshValues.get("hidStaffLoan"));
//For retail facility should be 1
		if(strpageid.equalsIgnoreCase("P"))
		{
		
			strfacility="1";
		}
		try
		{ 
			if(strAction.equalsIgnoreCase("insert"))
			{
				
				String strQuery1 = SQLParser.getSqlQuery("selsno_tl_repayschedule^"+ strappno+"^"+strfacility);
				rs = DBUtils.executeQuery(strQuery1);
				if(rs.next())
				{
					strSno = correctNull((String)rs.getString("tl_slno"));
				}
				
				if(!strSno.equalsIgnoreCase(""))
				{
				hshQuery.put("strQueryId","ins_tl_repayschedule");
				arrValues=new ArrayList();
				arrValues.add(strappno);
				arrValues.add(strSno);
				arrValues.add(strfacility);	
				arrValues.add(strfrequency);
				arrValues.add(strnooffrequency);
				arrValues.add(strinstamt);
				arrValues.add(strtotamt);
				if(strStaffLoan.equalsIgnoreCase("Y") && (correctNull((String)hshValues.get("strProductType")).equalsIgnoreCase("pH")||correctNull((String)hshValues.get("strProductType")).equalsIgnoreCase("pA")))
					arrValues.add(correctNull((String)hshValues.get("selRepaymentFor")));
				else
					arrValues.add("P");
				hshQuery.put("arrValues",arrValues);					
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
			}
			else if(strAction.equalsIgnoreCase("update"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();				
				hshQuery.put("strQueryId","upd_tl_repayschedule");
				arrValues=new ArrayList();
				arrValues.add(strfrequency);
				arrValues.add(strnooffrequency);
				arrValues.add(strinstamt);
				arrValues.add(strtotamt);
				if(strStaffLoan.equalsIgnoreCase("Y") && (correctNull((String)hshValues.get("strProductType")).equalsIgnoreCase("pH")||correctNull((String)hshValues.get("strProductType")).equalsIgnoreCase("pA")))
					arrValues.add(correctNull((String)hshValues.get("selRepaymentFor")));
				else
					arrValues.add("P");
				arrValues.add(strappno);
				arrValues.add(strSno);
				arrValues.add(strfacility);	
				hshQuery.put("arrValues",arrValues);					
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();				
				arrValues=new ArrayList();	
				hshQuery.put("strQueryId","del_tl_repayschedule");		
				arrValues.add(strappno);
				arrValues.add(strSno);
				arrValues.add(strfacility);
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("size","1");
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in updateNonemirepayschedule== "+e.getMessage());
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
				 arrValues =null;	
			}
			catch(Exception e1)
			{
				throw new EJBException("Error in closing connection== " +e1.getMessage());
			}
		}		
	}
	
	public HashMap calculateAmortizationCorporate(HashMap hshValues) 
	{
		ResultSet rs = null;
		HashMap hshResult = new HashMap();
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = new ArrayList();
		int i = 1;
		int intMoratorium=0;
		double dblInterest = 0.0;
		double dblPrincipal = 0.0;
		double dblloans = 0.0;
		double dblEMI = 0.0;
		double dblDenomi = 0.0;
		double dblNumeri = 0.0;
		double dblRate = 0.0;
		double dblActualAmtDue = 0.0;
		double dblTotalInterest = 0.0;
		double dblTotalEMI = 0.0;
		double dblTotalPrincipal = 0.0;
		double dblModIntRate = 0.0;
		int intTerms,intRepayMonths = 0;
		double dblRecAmount = 0.0;
		String bool = "false";
		String emdate = "";

		String strrepaymenttype = correctNull((String) hshValues.get("hidrepaymenttype"));
		emdate = correctNull((String) hshValues.get("emidate"));
		DecimalFormat dc = new DecimalFormat();
		dc.setGroupingUsed(false);
		dc.setMaximumFractionDigits(2);
		dc.setMinimumFractionDigits(2);
		String strperidicity = correctNull((String)hshValues.get("peridicity"));
		if(strperidicity.equalsIgnoreCase(""))
		{
			strperidicity="m";
		}
		
		try
		{
			if (strrepaymenttype.equals("amort"))
			{	
				double dblPendingPayment=0,dblHolidayEMI=0,dblHolidayInterest=0;
				dblModIntRate=Double.parseDouble(Helper.correctDouble((String)hshValues.get("modIntRate")));
				String strLockPayment="B",strPendingPaymentMode=correctNull((String)hshValues.get("sel_interestcharge"));
				intTerms = Integer.parseInt(Helper.correctInt((String) hshValues.get("terms")));
				int intHolidayPeriod = Integer.parseInt(Helper.correctInt((String)hshValues.get("terms2")));
				dblRecAmount=Double.parseDouble(Helper.correctDouble((String)hshValues.get("recmdAmt")));
				double dblTenor=intTerms-intHolidayPeriod;
				String txtmonPayamor=correctNull((String)hshValues.get("txtmonPay"));
				hshResult.put("txtmonPayamor",txtmonPayamor);
				hshResult.put("dblrequested_amount",(correctNull((String)hshValues.get("recmdAmt"))));
				hshResult.put("terms",Integer.toString(intTerms-intHolidayPeriod));
				hshResult.put("loan_noofinstallment",Integer.toString(intHolidayPeriod));
				hshResult.put("inttype",Helper.correctNull((String)hshValues.get("inttype")));
				hshResult.put("cattype",Helper.correctNull((String)hshValues.get("cattype")));
				dblRate=dblModIntRate/(12*100);
				String txt_date = Helper.correctNull((String) hshValues.get("strCalmonth"));
				hshResult.put("txt_date", txt_date);
				if(strLockPayment.trim().equalsIgnoreCase("I") && strPendingPaymentMode.trim().equals("2"))
				{
					dblDenomi=Math.pow(dblRate+1,(intTerms))-1;	
					dblNumeri=dblRate*Math.pow(dblRate+1,(intTerms));
				}	
				else{
					dblDenomi=Math.pow(dblRate+1,(dblTenor))-1;	
					dblNumeri=dblRate*Math.pow(dblRate+1,(dblTenor));
				}
				
				if(dblNumeri!=0.0 && dblDenomi!=0.0)
				{
					dblEMI=Math.ceil((dblNumeri/dblDenomi)*dblRecAmount);
				}
				/*	dblDenomi=Math.pow(dblRate+1,(intTerms-intHolidayPeriod))-1;	
				dblNumeri=dblRate*Math.pow(dblRate+1,(intTerms-intHolidayPeriod));
				if(dblNumeri!=0.0 && dblDenomi!=0.0)
				{
					dblEMI=(dblNumeri/dblDenomi)*dblRecAmount;
				}
				dblInterest=(dblRecAmount*dblRate);
				dblloans = dblRecAmount;*/
					
					dblInterest=(dblRecAmount*dblRate); //monthly interest 
					dblloans = dblRecAmount; //loan amount
					double dblInterest_new=0.00;
					double dblActualAmtDue_new=0.00;					
					double dblloans_new=dblRecAmount;
				// Amortization for Holiday Period
				if(!strLockPayment.trim().equalsIgnoreCase("S") && intHolidayPeriod>0)
				{
					while(i<=intHolidayPeriod)
					{						
						

						if(strLockPayment.trim().equalsIgnoreCase("P"))
						{
							arryCol=new ArrayList();
							arryCol.add(new Integer(i));
							i=i+1;
							
							//Lock Only Principal amount. Only interest will be paid.  No change in balance amount and OS Loan amount.
							dblInterest=(dblloans*dblRate);
							dblActualAmtDue=dblloans;   
							dblTotalInterest=dblTotalInterest+dblInterest;
							dblTotalPrincipal=0.0;
							//dblTotalPrincipal=dblTotalPrincipal+0;
							//dblloans=(dblloans+dblInterest-dblEMI);							
							//dblPendingPayment = dblPendingPayment + dblEMI - dblInterest;
							dblPendingPayment=0.0;
							
							arryCol.add(new Double(dc.format(dblActualAmtDue+dblInterest)));	//Loan Amount OS						
							arryCol.add(new Double(dc.format(dblInterest)));		//Interest Amount
							arryCol.add(new Double(dc.format(0)));					//Principal Amount
							arryCol.add(new Double(dc.format((dblInterest))));		//EMI
							arryCol.add(new Double(dc.format(dblloans)));				//Balance Amount	
							
							arryRow.add(arryCol);
							dblHolidayEMI+=dblInterest;//changes* For toal calculation

						}
						else if(strLockPayment.trim().equalsIgnoreCase("I"))
						{//calamort
							arryCol=new ArrayList();
							arryCol.add(new Integer(i));
							i=i+1;
							
							dblInterest=(dblloans*dblRate);
							dblActualAmtDue=dblloans+dblInterest;
							dblPrincipal=dblEMI-dblInterest;
							//dblloans = dblloans+dblInterest-dblEMI;
							dblloans = dblloans+dblInterest-dblPrincipal;
							
							dblInterest_new=(dblloans_new*dblRate);
							dblActualAmtDue_new=dblloans_new+dblInterest_new;
							dblloans_new = dblloans_new+dblInterest_new-dblPrincipal;
							
							dblPendingPayment = dblPendingPayment + dblInterest_new;
							dblTotalInterest=dblTotalInterest+dblInterest_new;
							dblTotalPrincipal=dblTotalPrincipal+dblPrincipal;
							
							arryCol.add(new Double(dc.format(dblActualAmtDue_new)));	//Balance Amount
							arryCol.add(new Double(dc.format(0))); 				//Interest Amount
							arryCol.add(new Double(dc.format(dblPrincipal))); 		//Principal Amount
							arryCol.add(new Double(dc.format((dblPrincipal))));		//EMI
							arryCol.add(new Double(dc.format(dblloans_new)));			//Loan Amount OS
							arryRow.add(arryCol);
							dblHolidayEMI+=dblPrincipal;//changes* For toal calculation*/
						}
						else if(strLockPayment.trim().equalsIgnoreCase("B"))
						{
							if(strPendingPaymentMode.trim().equals("1"))
							{
								//Amortization for regular Customers
								dblRate = dblModIntRate / (12 * 100);
								dblDenomi = Math.pow(dblRate + 1, dblTenor) - 1;
								dblNumeri = dblRate * Math.pow(dblRate + 1, dblTenor);
								dblEMI =Math.ceil( (dblNumeri / dblDenomi) * dblRecAmount);
								dblPrincipal = dblEMI - (dblRecAmount * dblRate);
								dblInterest = dblRecAmount * dblRate;
								dblPrincipal = (dblEMI - dblInterest);
				
				
								dblActualAmtDue = dblRecAmount - dblPrincipal;// change negleted dblEMI by  mohan
								// dblloans = dblActualAmtDue+dblInterest;
				
								dblTotalEMI = dblEMI * dblTenor;
				
								arryCol = new ArrayList();
								arryCol.add(new Integer(i));
								i = i + 1;
								arryCol.add(new Double(dc.format(dblRecAmount)));
								arryCol.add(new Double(dc.format(dblInterest)));
								dblTotalInterest = dblInterest;
								arryCol.add(new Double(dc.format(dblPrincipal)));
								dblTotalPrincipal = dblPrincipal;
								arryCol.add(new Double(dc.format(dblEMI)));
								arryCol.add(new Double(dc.format(dblActualAmtDue)));
								arryRow.add(arryCol);
								while (i <= dblTenor)
								{
									arryCol = new ArrayList();
									arryCol.add(new Integer(i));
									i = i + 1;
									// dblActualAmtDue=dblloans;//change emi negleted
									arryCol.add(new Double(dc.format(dblActualAmtDue)));
				
									dblInterest = dblActualAmtDue * dblRate;
				
									arryCol.add(new Double(dc.format(dblInterest)));
				
									dblTotalInterest = dblTotalInterest + dblInterest;
				
									dblPrincipal = (dblEMI - dblInterest);
				
									arryCol.add(new Double(dc.format(dblPrincipal)));
				
									dblTotalPrincipal = dblTotalPrincipal + dblPrincipal;
				
									arryCol.add(new Double(dc.format(dblEMI)));
				
									dblActualAmtDue = dblActualAmtDue - dblPrincipal;
				
									dblloans = dblActualAmtDue;
									
									if(dblActualAmtDue<0)
										dblActualAmtDue=0.0;
				
									arryCol.add(new Double(dc.format(dblActualAmtDue)));
				
									arryRow.add(arryCol);
								if(i>dblTenor){
								arryCol = new ArrayList();
								arryCol.add(new String("Total"));
								arryCol.add(new Double(dc.format(dblTotalInterest)));
								arryCol.add(new Double(dc.format(dblTotalPrincipal)));
								arryCol.add(new Double(dc.format(dblTotalEMI)));
								arryRow.add(arryCol);
								}
								}
								if(dblActualAmtDue==0.0 && i>1){
									break;
								}
							}
							else if(strPendingPaymentMode.trim().equals("2"))
							{
								arryCol=new ArrayList();
								arryCol.add(new Integer(i));
								i=i+1;					
											
								// Lock both Interest and Principal
								dblInterest=(dblloans*dblRate);
								dblActualAmtDue=dblloans+dblInterest;
								dblTotalInterest=dblTotalInterest+dblInterest;
								dblPrincipal=0;
								dblTotalPrincipal=dblTotalPrincipal+dblPrincipal;
								
								/*
								 * Compound Interest Calculation
								 * During holiday period, Interest added to Principal in each month till repayment
								 */
								dblloans = dblloans + dblInterest;  
								dblPendingPayment = dblPendingPayment + dblInterest;
								if(dblloans<=0)
								{
									dblloans=0.00;
								}							
								arryCol.add(new Double(dc.format(dblActualAmtDue)));	//Balance Amount
								arryCol.add(new Double(dc.format(0)));					//Interest Amount
								arryCol.add(new Double(dc.format(0)));					//Principal Amount
								arryCol.add(new Double(dc.format(0)));					//EMI
								arryCol.add(new Double(dc.format(dblloans)));			//Loan Amount OS
								arryRow.add(arryCol);
							}
							
							
						}
					}
				}
				//Recalculating EMI
				boolean blnPendingPayment = false;
				double dblFirstEMI = 0.0;
				
								
				double dblTotIntPrincLock=0.00;
				if(!strLockPayment.trim().equalsIgnoreCase("S") && intHolidayPeriod>0)
				{
					 if(strPendingPaymentMode.trim().equals("2"))
					{
						//Add pending payments to the Principal and recalculate the EMI
						//commented ---- dblloans = dblloans + dblPendingPayment;
						dblRate=dblModIntRate/(12*100);
						dblDenomi=Math.pow(dblRate+1,(intTerms-intHolidayPeriod))-1;	
						dblNumeri=dblRate*Math.pow(dblRate+1,(intTerms-intHolidayPeriod));
						//if(strLockPayment.trim().equalsIgnoreCase("B"))
						{
							if(dblNumeri!=0.0 && dblDenomi!=0.0)
							{
								dblEMI=Math.floor((dblNumeri/dblDenomi)*dblloans);
							}
						}/*else
						{
							if(dblNumeri!=0.0 && dblDenomi!=0.0)
							{
								dblEMI=dblNumeri/dblDenomi*(dblloans + dblPendingPayment);
							}
						}*/
						dblInterest=((dblloans + dblPendingPayment)*dblRate);
						dblPrincipal=dblEMI-dblInterest;
						dblActualAmtDue=dblloans + dblPendingPayment+ dblInterest;
						dblTotalEMI=(dblEMI*(intTerms-intHolidayPeriod) + dblHolidayEMI);
						
					}	
					else if(strPendingPaymentMode.trim().equals("1"))
					{
						//Add pending payments to the Principal and recalculate the EMI
						//commented ---- dblloans = dblloans + dblPendingPayment;
						dblRate=dblModIntRate/(12*100);
						dblDenomi=Math.pow(dblRate+1,(intTerms-intHolidayPeriod))-1;	
						dblNumeri=dblRate*Math.pow(dblRate+1,(intTerms-intHolidayPeriod));
						
					
						dblloans+=dblPendingPayment;
						//if(strLockPayment.trim().equalsIgnoreCase("B"))
						{
							if(dblNumeri!=0.0 && dblDenomi!=0.0)
							{
								dblEMI=(dblNumeri/dblDenomi*dblloans);
							}
						}/*else
						{
							if(dblNumeri!=0.0 && dblDenomi!=0.0)
							{
								dblEMI=dblNumeri/dblDenomi*(dblloans + dblPendingPayment);
							}
						}*/
						dblInterest=(dblloans*dblRate);
						dblPrincipal=dblEMI-dblInterest;
						//dblActualAmtDue=dblloans + dblInterest;
						dblActualAmtDue=dblloans + dblInterest;
						dblTotalEMI=(dblEMI*(intTerms-intHolidayPeriod) + dblHolidayEMI);
						
					}	
					else
					{
						dblTotalEMI=(dblHolidayEMI);
					}
				}
				int j=0;
				if(!strLockPayment.trim().equalsIgnoreCase("S") && intHolidayPeriod>0 && strPendingPaymentMode.trim().equals("1"))
				{
					dblTenor=dblTenor;
				}
				else{
					dblTenor=dblTenor+intHolidayPeriod;
				}
				while(i<=(dblTenor))
				{
					arryCol=new ArrayList();
					arryCol.add(new Integer(i));
					if(blnPendingPayment && j==0)
					{
						
						dblFirstEMI =(dblEMI + dblPendingPayment);
						dblInterest=(dblloans*dblRate);	
						dblTotalInterest=dblTotalInterest+dblInterest;
						
						dblPrincipal=dblEMI-dblInterest;
						dblTotalPrincipal=dblTotalPrincipal+dblPrincipal;
						dblActualAmtDue=dblloans+dblInterest;  //Formula: Balance Amt := OS Loan + IR
						if(strLockPayment.trim().equalsIgnoreCase("B"))
						{
							dblloans = dblloans+dblInterest-dblFirstEMI;
						}else if(strLockPayment.trim().equalsIgnoreCase("I"))
						{
							dblloans = dblloans+dblInterest-dblEMI;
						}
						
						dblInterest+=dblPendingPayment;
						if(dblloans<=0)
						{
							dblloans=0.00;
						}	
						arryCol.add(new Double(dc.format(dblActualAmtDue)));
						arryCol.add(new Double(dc.format(dblInterest)));
						arryCol.add(new Double(dc.format(dblPrincipal)));
						arryCol.add(new Double(dc.format((dblFirstEMI))));
						arryCol.add(new Double(dc.format(dblloans)));
						
						dblTotalEMI+=(dblFirstEMI);
					
					}
					else
					{
						//Checking for Last Entry(To Adjust final amount)
						if(i==dblTenor+intHolidayPeriod)
						{
							double dblTempLoans = 0.0;
							dblInterest=(dblloans*dblRate);
							dblActualAmtDue=dblloans+dblInterest;
							dblPrincipal=dblEMI-dblInterest;
							dblTempLoans =dblloans+dblInterest-dblEMI;
							
							//Add the balance to the EMI and recalculate
							dblEMI =(dblEMI + dblTempLoans);
							dblPrincipal=dblEMI-dblInterest;
							dblloans = dblloans+dblInterest-dblEMI;
							if(strLockPayment.trim().equalsIgnoreCase("B"))
							{
								dblTotIntPrincLock+=dblInterest+dblPendingPayment;//changes* Total interest calculation
							}else
							{
								dblTotIntPrincLock+=dblInterest;
							}
							dblTotalInterest=dblTotalInterest+dblInterest;
							dblTotalPrincipal=dblTotalPrincipal+dblPrincipal;
						}
						else
						{
							dblInterest=(dblloans*dblRate);
							dblTotIntPrincLock+=dblInterest;//changes*
							dblActualAmtDue=dblloans+dblInterest;
							dblTotalInterest=dblTotalInterest+dblInterest;
							dblPrincipal=dblEMI-dblInterest;
							dblTotalPrincipal=dblTotalPrincipal+dblPrincipal;
							dblloans = dblloans+dblInterest-dblEMI;
						}
						if(dblloans<=0)
						{
							dblloans=0.00;
						}	
						arryCol.add(new Double(dc.format(dblActualAmtDue)));
						arryCol.add(new Double(dc.format(dblInterest)));
						arryCol.add(new Double(dc.format(dblPrincipal)));
						arryCol.add(new Double(dc.format((dblEMI))));
						arryCol.add(new Double(dc.format(dblloans)));
						/*if( strLockPayment.trim().equalsIgnoreCase("P"))
							dblTotalEMI+=(dblEMI);*/
						dblTotalEMI=(dblTotalPrincipal+dblTotalInterest);
					}
					arryRow.add(arryCol);	
					
					i=i+1;
					j++;
				}
				if(strPendingPaymentMode.trim().equals("2") || strPendingPaymentMode.trim().equals("1"))
				{
					dblTotalInterest=dblTotIntPrincLock;  // for showing total interest when pricipal is locked
				}
				if(!strPendingPaymentMode.trim().equals("1") || intHolidayPeriod==0 )
				{
					arryCol=new ArrayList();
					arryCol.add(new String("Total"));
					
					 if((strLockPayment.trim().equalsIgnoreCase("B"))&&(strPendingPaymentMode.trim().equals("1")))
					{
						 arryCol.add(new Double(dc.format(dblTotalInterest-dblHolidayInterest)));
					}
					else
					{
						arryCol.add(new Double(dc.format(dblTotalInterest)));
					}
					arryCol.add(new Double(dc.format(dblTotalPrincipal)));
					if(strLockPayment.trim().equalsIgnoreCase("P"))
					{
						arryCol.add(new Double(dc.format((dblTotalInterest+dblTotalPrincipal))));
					}
					else
					{
						arryCol.add(new Double(dc.format((dblTotalEMI))));
					}
					
					arryRow.add(arryCol);
				}
				double dblEmi=0;
				if(arryRow.size()>0 && arryRow!=null)
				{
					if(!strPendingPaymentMode.trim().equals("1")){
					for(j=intHolidayPeriod;j<(intHolidayPeriod+1);j++)
					{
						arryCol=(ArrayList)arryRow.get(j);
						dblEmi=Double.parseDouble(Helper.correctDouble((String)arryCol.get(4).toString()));
					}
					}
					else{
						for(j=(int)dblTenor;j<((int)dblTenor+1);j++)
						{
							arryCol=(ArrayList)arryRow.get(j-1);
							dblEmi=Double.parseDouble(Helper.correctDouble((String)arryCol.get(4).toString()));
						}
					}
				}
				hshResult.put("strEmi",String.valueOf(dblEmi));
				hshResult.put("arryRow",arryRow);
				hshResult.put("emidate",emdate);
				hshResult.put("totalInterest",dc.format(dblTotalInterest));
				hshResult.put("strperidicity",strperidicity);
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in closing calculateAmortization" + e.getMessage());
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
				throw new EJBException("Error in closing Connection " + e.getMessage());
			}
		}
		return hshResult;
	}
	
}
