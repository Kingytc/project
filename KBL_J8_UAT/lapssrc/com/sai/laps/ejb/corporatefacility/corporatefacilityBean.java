package com.sai.laps.ejb.corporatefacility;

import java.awt.image.DataBuffer;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.ArrayList;
import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SAILogger;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "corporatefacilityBean", mappedName = "corporatefacilityHome")
@Remote (corporatefacilityRemote.class)
public class corporatefacilityBean extends BeanAdapter {
	private static final long serialVersionUID = 1L;
	


	static Logger log=Logger.getLogger(corporatefacilityBean.class);	

	public corporatefacilityBean() {
	}
	public HashMap getData(HashMap hshValues)  {
		ResultSet rs = null;
		HashMap hshRecord = null;
		String strProductCode = null;
		java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
		nf.setMinimumIntegerDigits(4);
		nf.setGroupingUsed(false);
		String strQuery = "";
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();
		String fac_id = "";
		try {
			fac_id = (String) hshValues.get("fac_id");
			if (fac_id.equalsIgnoreCase("corpnew") || fac_id.equalsIgnoreCase("new")) {
				hshRecord = new HashMap();
				fac_id = "new";
				hshRecord.put("fac_id", fac_id);
				return hshRecord;
			} else {
				rs = DBUtils.executeLAPSQuery("setproductsselcorporate^"+ fac_id);
				hshRecord = new HashMap();
				if (rs.next()) 
				{
					hshRecord.put("fac_id", correctNull((String) rs.getString("hidcorp_facid")));
					hshRecord.put("txt_code", correctNull((String) rs.getString("hidcorp_faccode")));
					hshRecord.put("txtcat_name", correctNull((String) rs.getString("hidcorp_headname")));
					hshRecord.put("txt_facility", correctNull((String) rs.getString("hidcorp_subfac")));
					hshRecord.put("prd_rng_from", correctNull(rs.getString("prd_rng_from")));
					hshRecord.put("prd_rng_to", correctNull((String) rs.getString("prd_rng_to")));
					hshRecord.put("prd_minterm", correctNull(rs.getString("hid_minperiod")));
					hshRecord.put("prd_maxterm", correctNull((String) rs.getString("hid_maxperiod")));
					hshRecord.put("txt_holiday", correctNull((String) rs.getString("hid_holidayperiod")));
					hshRecord.put("seltype", correctNull((String) rs.getString("hidfac_type")));
					hshRecord.put("facility1", correctNull((String) rs.getString("hidfac_nature")));
					hshRecord.put("fac_parent", correctNull((String) rs.getString("facheaddesc")));
					hshRecord.put("fac_sub", correctNull((String) rs.getString("facdesc")));
					hshRecord.put("fac_descrip", correctNull((String) rs.getString("hid_facdescp")));
					hshRecord.put("com_facility_stop", correctNull((String) rs.getString("com_facility_stop")));
					hshRecord.put("com_facility_loantype", correctNull((String) rs.getString("com_facility_loantype")));
					hshRecord.put("com_facility_emischeme", correctNull((String) rs.getString("com_facility_emischeme")));
					hshRecord.put("com_facility_nonemischeme", correctNull((String) rs.getString("com_facility_nonemischeme")));
					hshRecord.put("com_facility_eischeme", correctNull((String) rs.getString("com_facility_eischeme")));
					hshRecord.put("com_facility_noneischeme", correctNull((String) rs.getString("com_facility_noneischeme")));
					hshRecord.put("com_facility_lumpsum", correctNull((String) rs.getString("com_facility_lumpsum")));
					hshRecord.put("com_purposeofloan", correctNull((String) rs.getString("com_purposeofloan")));
					hshRecord.put("com_module", correctNull((String) rs.getString("com_module")));
					hshRecord.put("com_agrscheme", correctNull((String) rs.getString("com_agrscheme")));
					hshRecord.put("com_bankscheme", correctNull((String) rs.getString("com_bankscheme")));
					hshRecord.put("com_agrschemetype", correctNull((String) rs.getString("com_agrschemetype")));
					hshRecord.put("com_facility_intfreq", correctNull((String) rs.getString("com_facility_intfreq")));
					hshRecord.put("selrating", correctNull((String) rs.getString("com_facRating")));
					hshRecord.put("com_faccreated_date", correctNull((String) rs.getString("com_faccreated_date")));
					hshRecord.put("com_facstatus", correctNull((String) rs.getString("com_facstatus")));
					hshRecord.put("com_schemeheadcode", correctNull((String) rs.getString("com_schemeheadcode")));
					hshRecord.put("com_cashmargin", correctNull(rs.getString("com_cashmargin")));
					hshRecord.put("com_repaytype", correctNull(rs.getString("fac_repaytype")));
					hshRecord.put("com_facintdef", correctNull(rs.getString("com_facintdef")));
					hshRecord.put("com_loanagainstshares", correctNull(rs.getString("com_loanagainstshares")));
					hshRecord.put("COM_SHARETYPE", correctNull(rs.getString("COM_SHARETYPE")));
					hshRecord.put("fac_interesttype", correctNull(rs.getString("fac_interesttype")));
					hshRecord.put("com_whtdigiprd", correctNull(rs.getString("com_whtdigiprd")));
					hshRecord.put("COM_FACILITY_EXPIRYDATE", correctNull(rs.getString("COM_FACILITY_EXPIRYDATE")));
					hshRecord.put("com_facdispdesc", correctNull(rs.getString("com_facdispdesc")));
					hshRecord.put("com_forexfac", correctNull(rs.getString("com_forexfac")));
					hshRecord.put("com_whtdigiprdRat", correctNull(rs.getString("com_whtdigiprdRat")));
					hshRecord.put("COM_POOL_BASED_RATING", correctNull(rs.getString("COM_POOL_BASED_RATING")));
					hshRecord.put("COM_MINREPAYPERIOD_REST", correctNull(rs.getString("COM_MINREPAYPERIOD_REST")));
					hshRecord.put("COM_MAXREPAYPERIOD_REST", correctNull(rs.getString("COM_MAXREPAYPERIOD_REST")));
					hshRecord.put("COM_HOLIDAYPERIOD_REST", correctNull(rs.getString("COM_HOLIDAYPERIOD_REST")));
					hshRecord.put("COM_CGTMSEFLAG", correctNull(rs.getString("COM_CGTMSEFLAG")));
					
				}
			}
			if (!fac_id.equalsIgnoreCase("new")) {
				HashMap hshTemp = new HashMap();
				hshTemp.put("fac_id", hshValues.get("fac_id"));
				EJBInvoker.executeStateLess("corporatefacility", hshTemp, "updateFacilitySaveStatus");
			}
			int count=0;
			rs = DBUtils.executeLAPSQuery("SelStaticDataCorpQuestionMast^"+ "44");
			while(rs.next()) 
			{
				count=count+1;
			}
			if(rs!=null)
			{
				 rs.close();
			}
			hshRecord.put("NoOfRatingDescription", String.valueOf(count));
			
			strQuery = SQLParser.getSqlQuery("sel_otherdetails^" + fac_id);
			String Svanidhi_type="";
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
					hshRecord.put("COM_SVANIDHITYPE", correctNull((String)rs.getString("COM_SVANIDHITYPE")));
				
			}
		} catch (Exception e) {
			log.error("exception in getData... " + e);
			throw new EJBException(e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				vecRow = null;
				vecCol = null;
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return hshRecord;
	}
	public HashMap checkPageStatus(HashMap hshValues)  {
		ResultSet rs = null;
		String strPrdStatus = "";
		HashMap hshRecord=new HashMap();
		String strQuery = null;
		String strsetuplist = "",strappid="";
		String strbankarr = "",strmode="",strtakeover="",strfcccount="";
		String strappno = Helper.correctNull((String) hshValues.get("appno"));
		String strIndtype = Helper.correctNull((String) hshValues.get("industryType"));
		String strssitype = Helper.correctNull((String) hshValues.get("hidSSIType"));
		String strGroupRights = Helper.correctNull((String) hshValues.get("strGroupRights"));
		int intsno=0;
		strappid=Helper.correctNull((String)hshValues.get("comapp_id"));
		if(strappid.equalsIgnoreCase("") || strappid.equalsIgnoreCase("null"))
		{
			strappid=Helper.correctNull((String)hshValues.get("comappid"));			
		}
		if(strappid.equalsIgnoreCase("") || strappid.equalsIgnoreCase("null"))
		{
			strappid=Helper.correctNull((String)hshValues.get("hidapplicantid"));			
		}
		if(strappid.equalsIgnoreCase("") || strappid.equalsIgnoreCase("null"))
		{
			strappid=Helper.correctNull((String)hshValues.get("hidDemoId"));			
		}
		if(strappid.equalsIgnoreCase("") || strappid.equalsIgnoreCase("null"))
		{
			strappid=Helper.correctNull((String)hshValues.get("bowid"));			
		}
		strGroupRights=strGroupRights.substring(9,10);
		try {
				strQuery = SQLParser.getSqlQuery("select_buildingmode^" + strappno);
				if (rs != null)
				{
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
             	{
					strmode = Helper.correctNull((String)rs.getString("com_modepur"));
             	}
				strQuery = SQLParser.getSqlQuery("select_bankingarr^" + strappno);
				if (rs != null) 
				{
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
            	   strbankarr = Helper.correctNull((String)rs.getString("com_bankarr"));
				}
				strQuery = SQLParser.getSqlQuery("pro_takeoversel^" + strappno);
				if (rs != null) 
				{
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
            	   strtakeover = Helper.correctNull((String)rs.getString("istakeover"));
				}
				strQuery = SQLParser.getSqlQuery("checkcountforfcc^" + strappno);
				if (rs != null) 
				{
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				rs.next();
				if((rs.getInt(1) != 0))
				{
					strfcccount = "1";
				}
				else
				{
					strfcccount = "0";
				}
				strQuery = SQLParser.getSqlQuery("setlistofpage_select");
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strsetuplist=Helper.correctDouble(rs.getString("LISTOFPAGE"));
				}
				if(!strsetuplist.equalsIgnoreCase(""))
				{
				StringTokenizer strnewfac= new StringTokenizer(strsetuplist,"@");
				while(strnewfac.hasMoreTokens())			
				{
					String securityvalue  =correctNull((String)strnewfac.nextToken());
			         if(securityvalue.equalsIgnoreCase("17"))
			          {
			        		strQuery = SQLParser.getSqlQuery("checkcustomerinfo^" + strappid);
			        		if (rs != null) 
			        		{
			        			rs.close();
			        		}
			        		rs = DBUtils.executeQuery(strQuery);
			        		rs.next();
			        		if (rs.getInt(1) == 0) 
			        		{
			        			intsno=intsno+1;
			        			strPrdStatus = strPrdStatus+Integer.toString(intsno)+".Enter the values in Customer Profile -> Checklist "+ "\n";
			        		}
			          }
			        else if(securityvalue.equalsIgnoreCase("P"))
					{
						rs = DBUtils.executeLAPSQuery("checkapplnpromoters^" + strappno);
						rs.next();
						if (rs.getInt(1) == 0) 
						{
							intsno=intsno+1;
							strPrdStatus = strPrdStatus+Integer.toString(intsno)+".Enter the Values in Existing Application -> Promoters"+ "\n";
						}
					}
					else if(securityvalue.equalsIgnoreCase("D"))
					{
						strQuery = SQLParser.getSqlQuery("checkapplndefaulterslist^" + strappno);
						if (rs != null)
						{
							rs.close();
						}
						rs = DBUtils.executeQuery(strQuery);
						rs.next();
						if (rs.getInt(1) == 0)
						{
							intsno=intsno+1;
							strPrdStatus = strPrdStatus+Integer.toString(intsno)+".Enter the values in Existing Application -> Promoters -> Defaulters List"+ "\n";
						}
					}
					else if(securityvalue.equalsIgnoreCase("C"))
					{
						strQuery = SQLParser.getSqlQuery("checkbankingarrange^"+ strappno );
						if (rs != null)
						{
							rs.close();
						}
						rs = DBUtils.executeQuery(strQuery);
						rs.next();
						if (rs.getInt(1) == 0) 
						{
							intsno=intsno+1;
							strPrdStatus = strPrdStatus+Integer.toString(intsno)+".Enter the values in Existing Application -> Banking Arrangements -> Credit Facilities"+ "\n";
						}
					}
					else if(securityvalue.equalsIgnoreCase("L"))
					{
						if(strtakeover.equalsIgnoreCase("1"))
						{
						strQuery = SQLParser.getSqlQuery("checklimitdet^"+ strappno );
						if (rs != null) 
						{
							rs.close();
						}
						rs = DBUtils.executeQuery(strQuery);
						rs.next();
						if (rs.getInt(1) == 0) 
						{
							intsno=intsno+1;
							strPrdStatus = strPrdStatus+Integer.toString(intsno)+".Enter the values in Existing Application -> Take Over -> Limit Details"+ "\n";
						}
						}
					}
					else if(securityvalue.equalsIgnoreCase("S"))
					{
						if(strtakeover.equalsIgnoreCase("1"))
						{
							strQuery = SQLParser.getSqlQuery("checktakesecuritydet^"+ strappno);
							if (rs != null) 
							{
								rs.close();
							}
							rs = DBUtils.executeQuery(strQuery);
							rs.next();
							if (rs.getInt(1) == 0) 
							{
								intsno=intsno+1;
								strPrdStatus = strPrdStatus+Integer.toString(intsno)+".Enter the values in Existing Application -> TakeOver -> Security Details"+ "\n";
							}
						}
					}
			          else if(securityvalue.equalsIgnoreCase("C1"))
			          {
			        	  if(strssitype.equalsIgnoreCase("2"))
			        	  {
			        		  strQuery = SQLParser.getSqlQuery("checkstatutorydues^" + strappno);
			        		  if (rs != null)
			        		  {
			        			  rs.close();
			        		  }
			        		  rs = DBUtils.executeQuery(strQuery);
			        		  rs.next();
			        		  if (rs.getInt(1) == 0) 
			        		  {
			        			  intsno=intsno+1;
			        			  strPrdStatus = strPrdStatus+Integer.toString(intsno)+".Enter the values in Existing Application -> Statutory Dues"+ "\n";
			        		  }
			        	  }
			          }
			          else if(securityvalue.equalsIgnoreCase("C2"))
			          {
			        	  strQuery = SQLParser.getSqlQuery("checkappnotes^" + strappno);
			        	  if (rs != null)
			        	  {
			        		  rs.close();
			        	  }
			        	  rs = DBUtils.executeQuery(strQuery);
			        	  rs.next();
			        	  if (rs.getInt(1) == 0) 
			        	  {
			        		  intsno=intsno+1;
			        		  strPrdStatus =strPrdStatus+Integer.toString(intsno)+".Enter the values in Existing Application -> Notes"+ "\n";
			        	  }
			          }
			          else if(securityvalue.equalsIgnoreCase("C3"))
			          {
			        	  if(strssitype.equalsIgnoreCase("2"))
			        	  {
			        		  strQuery = SQLParser.getSqlQuery("checkorgemp^" + strappno);
			        		  if (rs != null) 
			        		  {
			        			  rs.close();
			        		  }
			        		  rs = DBUtils.executeQuery(strQuery);
			        		  rs.next();
			        		  if (rs.getInt(1) == 0) 
			        		  {
			        			  intsno=intsno+1;
			        			  strPrdStatus = strPrdStatus+Integer.toString(intsno)+".Enter the values in Existing Application -> Org Emp"+ "\n";
			        		  }
			        	  }
			          }
			          else if(securityvalue.equalsIgnoreCase("C4"))
			          {
			        	  if(strIndtype.equalsIgnoreCase("1")||strIndtype.equalsIgnoreCase("2"))
				        	{
			        		  strQuery = SQLParser.getSqlQuery("checkmanufacturing^" + strappno);
			        		  if (rs != null)
			        		  {
			        			  rs.close();
			        		  }
			        		  rs = DBUtils.executeQuery(strQuery);
			        		  rs.next();
			        		  if (rs.getInt(1) == 0) 
			        		  {
			        			  intsno=intsno+1;
			        			  strPrdStatus = strPrdStatus+Integer.toString(intsno)+".Enter the values in Existing Application -> Manufacturing"+ "\n";
			        		  }
				        	}
			          }
			          else if(securityvalue.equalsIgnoreCase("C6"))
			          {
			        	  if(strIndtype.equalsIgnoreCase("6"))
				        	{
			        		  	strQuery = SQLParser.getSqlQuery("checktrust^" + strappno);
			        		  	if (rs != null) 
			        		  	{
			        		  		rs.close();
			        		  	}
			        		  	rs = DBUtils.executeQuery(strQuery);
			        		  	rs.next();
			        		  	if (rs.getInt(1) == 0) 
			        		  	{
			        		  		intsno=intsno+1;
			        		  		strPrdStatus = strPrdStatus+Integer.toString(intsno)+".Enter the values in Existing Application -> Trust"+ "\n";
			        		  	}
				        	}
			          }
			          else if(securityvalue.equalsIgnoreCase("C7"))
			          {
			        	  if(strssitype.equalsIgnoreCase("3"))
			        	  {
			        		  strQuery = SQLParser.getSqlQuery("checkswotanalysis^" + strappno);
			        		  if (rs != null) 
			        		  {
			        			  rs.close();
			        		  }
			        		  rs = DBUtils.executeQuery(strQuery);
			        		  rs.next();
			        		  if (rs.getInt(1) == 0) 
			        		  {
			        			  intsno=intsno+1;
			        			  strPrdStatus = strPrdStatus+Integer.toString(intsno)+".Enter the values in Proposal -> Swot Analysis"+ "\n";
			        		  }
			        	  }
			          }
			          else if(securityvalue.equalsIgnoreCase("C8"))
			          {
			        	  if(strIndtype.equalsIgnoreCase("8"))
				        	{
			        		  	strQuery = SQLParser.getSqlQuery("checknbfc^" + strappno);
			        		  	if (rs != null) 
			        		  	{
			        		  		rs.close();
			        		  	}
			        		  	rs = DBUtils.executeQuery(strQuery);
			        		  	rs.next();
			        		  	if (rs.getInt(1) == 0)
			        		  	{
			        		  		intsno=intsno+1;
			        		  		strPrdStatus = strPrdStatus+Integer.toString(intsno)+".Enter the values in Existing Application -> NBFC -> Checklist"+ "\n";
			        		  	}
				        	}
			          }
			          else if(securityvalue.equalsIgnoreCase("C9"))
			          {
			        	  if(strIndtype.equalsIgnoreCase("7"))
				        	{
			        		  	strQuery = SQLParser.getSqlQuery("checkrealestate^" + strappno + "^" + strIndtype);
			        		  	if (rs != null) 
			        		  	{
			        		  		rs.close();
			        		  	}
			        		  	rs = DBUtils.executeQuery(strQuery);
			        		  	rs.next();
			        		  	if (rs.getInt(1) == 0) 
			        		  	{
			        		  		intsno=intsno+1;
			        		  		strPrdStatus = strPrdStatus+Integer.toString(intsno)+".Enter the values in Existing Application -> Real Estate -> Checklist"+ "\n";
			        		  	}
				        	}
			          }
			          else if(securityvalue.equalsIgnoreCase("10"))
			          {
			        	  if(strIndtype.equalsIgnoreCase("11"))
				        	{
			        		  	strQuery = SQLParser.getSqlQuery("checkcommodityexchange^" + strappno);
			        		  	if (rs != null) 
			        		  	{
			        		  		rs.close();
			        		  	}
			        		  	rs = DBUtils.executeQuery(strQuery);
			        		  	rs.next();
			        		  	if (rs.getInt(1) == 0) 
			        		  	{
			        		  		intsno=intsno+1;
			        		  		strPrdStatus = strPrdStatus+Integer.toString(intsno)+".Enter the values in Existing Application -> Commodity Exchange -> Checklist"+ "\n";
			        		  	}
				        	}
			          }
			          else if(securityvalue.equalsIgnoreCase("11"))
			          {
			        	  if(strIndtype.equalsIgnoreCase("10"))
				        	{
			        		  	strQuery = SQLParser.getSqlQuery("checkcapitalmarket^" + strappno);
			        		  	if (rs != null) 
			        		  	{
			        		  		rs.close();
			        		  	}
			        		  	rs = DBUtils.executeQuery(strQuery);
			        		  	rs.next();
			        		  	if (rs.getInt(1) == 0)
			        		  	{
			        		  		intsno=intsno+1;
			        		  		strPrdStatus = strPrdStatus+Integer.toString(intsno)+".Enter the values in Existing Application -> Capital Market -> Checklist"+ "\n";
			        		  	}
				        	}
			          }
				        else if(securityvalue.equalsIgnoreCase("21"))
				          {
				        	if(strIndtype.equalsIgnoreCase("4"))
				        		{
				        			strQuery = SQLParser.getSqlQuery("checkservicesme^" + strappid);
				        			if (rs != null) 
				        			{
				        				rs.close();
				        			}
				        			rs = DBUtils.executeQuery(strQuery);
				        			rs.next();
				        			if (rs.getInt(1) == 0) 
				        			{
				        				intsno=intsno+1;
				        				strPrdStatus = strPrdStatus+Integer.toString(intsno)+".Enter the values in Existing Application -> Service SME -> Checklist"+ "\n";
				        			}
				        		}
				          }
				        else if(securityvalue.equalsIgnoreCase("22"))
				          {
				        	if(strIndtype.equalsIgnoreCase("5"))
				        		{
				        			strQuery = SQLParser.getSqlQuery("checknonservicesme^" + strappid);
				        			if (rs != null)
				        			{
				        				rs.close();
				        			}
				        			rs = DBUtils.executeQuery(strQuery);
				        			rs.next();
				        			if (rs.getInt(1) == 0) 
				        			{
				        				intsno=intsno+1;
				        				strPrdStatus = strPrdStatus+Integer.toString(intsno)+".Enter the values in Existing Application -> Service Non-SME -> Checklist"+ "\n";
				        			}
				        		}
				          }
				        else if(securityvalue.equalsIgnoreCase("23"))
				          {
				        	if(strIndtype.equalsIgnoreCase("13"))
				        		{
				        			strQuery = SQLParser.getSqlQuery("checkothers^" + strappno);
				        			if (rs != null) 
				        			{
				        				rs.close();
				        			}
				        			rs = DBUtils.executeQuery(strQuery);
				        			rs.next();
				        			if (rs.getInt(1) == 0) 
				        			{
				        				intsno=intsno+1;
				        				strPrdStatus = strPrdStatus+Integer.toString(intsno)+".Enter the values in Existing Application -> Others -> Checklist"+ "\n";
				        			}
				        		}
				          }
				        else if(securityvalue.equalsIgnoreCase("24"))
				          {
				        	if(strIndtype.equalsIgnoreCase("12"))
				        		{
				        			strQuery = SQLParser.getSqlQuery("checkmicrofinance^" + strappno);
				        			if (rs != null) 
				        			{
				        				rs.close();
				        			}
				        			rs = DBUtils.executeQuery(strQuery);
				        			rs.next();
				        			if (rs.getInt(1) == 0)
				        			{
				        				intsno=intsno+1;
				        				strPrdStatus = strPrdStatus+Integer.toString(intsno)+".Enter the values in Existing Application -> Microfinance -> Checklist"+ "\n";
				        			}
				        		}
				          }
				        else if(securityvalue.equalsIgnoreCase("25"))
				          {
				        	if(strIndtype.equalsIgnoreCase("7"))
				        		{
				        			strQuery = SQLParser.getSqlQuery("checkmarketability^" + strappno);
				        			if (rs != null) 
				        			{
				        				rs.close();
				        			}
				        			rs = DBUtils.executeQuery(strQuery);
				        			rs.next();
				        			if (rs.getInt(1) == 0)
				        			{
				        				intsno=intsno+1;
				        				strPrdStatus = strPrdStatus+Integer.toString(intsno)+".Enter the values in Existing Application -> Real Estate -> Marketability Check List"+ "\n";
				        				throw new Exception(strPrdStatus);
				        			}
				        		}
				          }
				         else if(securityvalue.equalsIgnoreCase("29"))
				          {
				        		strQuery = SQLParser.getSqlQuery("checksecurityanalysis^" + strappid);
				        		if (rs != null) 
				        		{
				        			rs.close();
				        		}
				        		rs = DBUtils.executeQuery(strQuery);
				        		rs.next();
				        		if (rs.getInt(1) == 0) 
				        		{
				        			intsno=intsno+1;
				        			strPrdStatus = strPrdStatus+Integer.toString(intsno)+".Enter the values in Security Analysis"+ "\n";
				        		}
				          }
				         else if(securityvalue.equalsIgnoreCase("30"))
				          {
				        		strQuery = SQLParser.getSqlQuery("checkbriefhistory^" + strappid);
				        		if (rs != null) 
				        		{
				        			rs.close();
				        		}
				        		rs = DBUtils.executeQuery(strQuery);
				        		rs.next();
				        		if (rs.getInt(1) == 0) 
				        		{
				        			intsno=intsno+1;
				        			strPrdStatus = strPrdStatus+Integer.toString(intsno)+".Enter comments in Brief History "+ "\n";
				        		}
				          }
					if(strGroupRights.equals("1"))
					{
			           if(securityvalue.equalsIgnoreCase("B"))
				        {
			  	        	strQuery = SQLParser.getSqlQuery("checkbriefbg^"+ strappno);
			  	        	if (rs != null) 
			  	        	{
			  	        		rs.close();
			  	        	}
			  	        	rs = DBUtils.executeQuery(strQuery);
			  	        	rs.next();
			  	        	if (rs.getInt(1) == 0) 
			  	        	{
			  	        		intsno=intsno+1;
			  	        		strPrdStatus = strPrdStatus+Integer.toString(intsno)+".Enter the values in Proposal -> Brief Background"+ "\n";
			  	        	}
				        }
				        else if(securityvalue.equalsIgnoreCase("R"))
				        {
				        	strQuery = SQLParser.getSqlQuery("checkproppromoters^" + strappno);
				        	if (rs != null)
				        	{
				        		rs.close();
				        	}
				        	rs = DBUtils.executeQuery(strQuery);
				        	rs.next();
				        	if (rs.getInt(1) == 0) 
				        	{
				        		intsno=intsno+1;
				        		strPrdStatus = strPrdStatus+Integer.toString(intsno)+".Enter the values in Proposal -> Brief Background -> Promoters"+ "\n";
				        	}
				        }
				        else if(securityvalue.equalsIgnoreCase("N"))
				        {
				        	strQuery = SQLParser.getSqlQuery("checkpresentreferences^"+ strappno);
				        	if (rs != null) 
				        	{
				        		rs.close();
				        	}
				        	rs = DBUtils.executeQuery(strQuery);
				        	rs.next();
				        	if (rs.getInt(1) == 0) 
				        	{
				        		intsno=intsno+1;
				        		strPrdStatus = strPrdStatus+Integer.toString(intsno)+".Enter the values in Proposal -> Brief Background -> Present References"+ "\n";
				        	}
				         }
				         else if(securityvalue.equalsIgnoreCase("O"))
				         {
				        	 strQuery = SQLParser.getSqlQuery("checkoperbankingdet^" + strappno);
				        	 if (rs != null)
				        	 {
				        		 rs.close();
				        	 }
				        	 rs = DBUtils.executeQuery(strQuery);
				        	 rs.next();
				        	 if (rs.getInt(1) == 0) 
				        	 {
				        		 intsno=intsno+1;
				        		 strPrdStatus = strPrdStatus+Integer.toString(intsno)+".Enter the values in Proposal -> Operational Details -> Banking Details"+ "\n";
				        	 }
				         }
				         else if(securityvalue.equalsIgnoreCase("I"))
				         {
				        	 strQuery = SQLParser.getSqlQuery("checkinspectionremarks^"+ strappno);
				        	 if (rs != null) 
				        	 {
				        		 rs.close();
				        	 }
				        	 rs = DBUtils.executeQuery(strQuery);
				        	 rs.next();
				        	 if (rs.getInt(1) == 0) 
				        	 {
				        		 intsno=intsno+1;
				        		 strPrdStatus = strPrdStatus+Integer.toString(intsno)+".Enter the values in Proposal -> Inspection Remarks "+ "\n";
				        	 }
				          }
				          else if(securityvalue.equalsIgnoreCase("F"))
				          {
				        	  if(strfcccount.equalsIgnoreCase("1"))
				        	  {
				        		  strQuery = SQLParser.getSqlQuery("checkfcc^" + strappno);
				        		  if (rs != null)
				        		  {
				        			  rs.close();
				        		  }
				        		  rs = DBUtils.executeQuery(strQuery);
				        		  rs.next();
				        		  if (rs.getInt(1) == 0) 
				        		  {
				        			  intsno=intsno+1;
				        			  strPrdStatus = strPrdStatus+Integer.toString(intsno)+".Enter the values in Proposal -> Implementation Schedule -> FCC"+ "\n";
				        		  }
				        	  	}
				          }
				          else if(securityvalue.equalsIgnoreCase("T"))
				          {
				        	  strQuery = SQLParser.getSqlQuery("checktermsncondition^" + strappno);
				        	  if (rs != null) 
				        	  {
				        		  rs.close();
				        	  }
				        	  rs = DBUtils.executeQuery(strQuery);
				        	  rs.next();
				        	  if (rs.getInt(1) == 0) 
				        	  {
				        		  intsno=intsno+1;
				        		  strPrdStatus = strPrdStatus+Integer.toString(intsno)+".Enter the values in Proposal -> Terms and Condition"+ "\n";
				        	  }
				          }
				          else if(securityvalue.equalsIgnoreCase("E"))
				          {
				        	  strQuery = SQLParser.getSqlQuery("checkrecommendation^" + strappno);
				        	  if (rs != null) 
				        	  {
				        		  rs.close();
				        	  }
				        	  rs = DBUtils.executeQuery(strQuery);
				        	  rs.next();
				        	  if (rs.getInt(1) == 0) 
				        	  {
				        		  intsno=intsno+1;
				        		  strPrdStatus = strPrdStatus+Integer.toString(intsno)+".Enter the values in Proposal -> Recommendations"+ "\n";
				        	  }
				          }
			          else if(securityvalue.equalsIgnoreCase("12"))
			          {
			        	  if(strmode.equalsIgnoreCase("1"))
			        	  	{
			        		  	strQuery = SQLParser.getSqlQuery("checkpoa^" + strappno + "^" + "1");
			        		  	if (rs != null) 
			        		  	{
			        		  		rs.close();
			        		  	}
			        		  	rs = DBUtils.executeQuery(strQuery);
			        		  	rs.next();
			        		  	if (rs.getInt(1) == 0) 
			        		  	{
			        		  		intsno=intsno+1;
			        		  		strPrdStatus = strPrdStatus+Integer.toString(intsno)+".Enter the values in Proposal -> Assessment -> Building Details : Mode of purchase land's Checklist"+ "\n";
			        		  	}
			        	  }
			          }
			         else if(securityvalue.equalsIgnoreCase("13"))
			          {
			        	 if(strmode.equalsIgnoreCase("2"))
			        	  {
			        		 	strQuery = SQLParser.getSqlQuery("checkpoa^" + strappno + "^" + "2");
			        		 	if (rs != null) 
			        		 	{
			        		 		rs.close();
			        		 	}
			        		 	rs = DBUtils.executeQuery(strQuery);
			        		 	rs.next();
			        		 	if (rs.getInt(1) == 0) 
			        		 	{
			        		 		intsno=intsno+1;
			        		 		strPrdStatus =strPrdStatus+Integer.toString(intsno)+".Enter the values in Proposal -> Assessment -> Building Details : Mode of purchase land's Checklist"+ "\n";
			        		 	}
			        	  }
			          }
			         else if(securityvalue.equalsIgnoreCase("14"))
			          {
			        	 if(strmode.equalsIgnoreCase("3"))
			        	  {
			        		 strQuery = SQLParser.getSqlQuery("checkpoa^" + strappno + "^" + "3");
			        		 if (rs != null) 
			        		 {
			        			 rs.close();
			        		 }
			        		 rs = DBUtils.executeQuery(strQuery);
			        		 rs.next();
			        		 if (rs.getInt(1) == 0) 
			        		 {
			        			 intsno=intsno+1;
			        			 strPrdStatus = strPrdStatus+Integer.toString(intsno)+".Enter the values in Proposal -> Assessment -> Building Details : Mode of purchase land's Checklist"+ "\n";
			        		 }
			        	  }
			          }
			          else if(securityvalue.equalsIgnoreCase("15"))
			          {
			        	  if(strmode.equalsIgnoreCase("4"))
			        	  	{
			        		  	strQuery = SQLParser.getSqlQuery("checkpoa^" + strappno + "^" + "4");
			        		  	if (rs != null) 
			        		  	{
			        		  		rs.close();
			        		  	}
			        		  	rs = DBUtils.executeQuery(strQuery);
			        		  	rs.next();
			        		  	if (rs.getInt(1) == 0) 
			        		  	{
			        		  		intsno=intsno+1;
			        		  		strPrdStatus = strPrdStatus+Integer.toString(intsno)+".Enter the values in Proposal -> Assessment -> Building Details : Mode of purchase land's Checklist"+ "\n";
			        		  	}
			        	  }
			          }
			        else if(securityvalue.equalsIgnoreCase("16"))
			          {
			        	if(strmode.equalsIgnoreCase("5"))
			        	  {
			        			strQuery = SQLParser.getSqlQuery("checkpoa^" + strappno + "^" + "5");
			        			if (rs != null) 
			        			{
			        				rs.close();
			        			}
			        			rs = DBUtils.executeQuery(strQuery);
			        			rs.next();
			        			if (rs.getInt(1) == 0) 
			        			{
			        				intsno=intsno+1;
			        				strPrdStatus = strPrdStatus+Integer.toString(intsno)+".Enter the values in Proposal -> Assessment -> Building Details : Mode of purchase land's Checklist"+ "\n";
			        			}
			        	  }
			          }
			        else if(securityvalue.equalsIgnoreCase("18"))
			          {
			        		if(strbankarr.equalsIgnoreCase("Consortium"))
			        		{
			        			strQuery = SQLParser.getSqlQuery("checkconsortium^" + strappno);
			        			if (rs != null)
			        			{
			        				rs.close();
			        			}
			        			rs = DBUtils.executeQuery(strQuery);
			        			rs.next();
			        			if (rs.getInt(1) == 0) 
			        			{
			        				intsno=intsno+1;
			        				strPrdStatus = strPrdStatus+Integer.toString(intsno)+".Enter the values in Proposal -> Operational Details -> Consortium Details"+ "\n";
			        			}
			        		}
	                  }
			        else if(securityvalue.equalsIgnoreCase("19"))
			          {
			        	if(strbankarr.equalsIgnoreCase("Multiple Banking"))
		                   {
			        			strQuery = SQLParser.getSqlQuery("checkmultiple^" + strappno);
			        			if (rs != null)
			        			{
			        				rs.close();
			        			}
			        			rs = DBUtils.executeQuery(strQuery);
			        			rs.next();
			        			if (rs.getInt(1) == 0)
			        			{
			        				intsno=intsno+1;
			        				strPrdStatus = strPrdStatus+Integer.toString(intsno)+".Enter the values in Proposal -> Operational Details -> Multiple Details"+ "\n";
			        			}
		                   }
			          }
			        else if(securityvalue.equalsIgnoreCase("26"))
			          {
			        		strQuery = SQLParser.getSqlQuery("checkgeneralfacilityindustry^" + strappno + "^" + "G");
			        		if (rs != null)
			        		{
			        			rs.close();
			        		}
			        		rs = DBUtils.executeQuery(strQuery);
			        		rs.next();
			        		if (rs.getInt(1) == 0)
			        		{
			        			intsno=intsno+1;
			        			strPrdStatus = strPrdStatus+Integer.toString(intsno)+"Enter the values in Proposal -> Checklist : General"+ "\n";
			        		}
			          }
			        else if(securityvalue.equalsIgnoreCase("27"))
			          {
			        		strQuery = SQLParser.getSqlQuery("checkgeneralfacilityindustry^" + strappno + "^" + "S");
			        		if (rs != null) 
			        		{
			        			rs.close();
			        		}
			        		rs = DBUtils.executeQuery(strQuery);
			        		rs.next();
			        		if (rs.getInt(1) == 0) 
			        		{
			        			intsno=intsno+1;
			        			strPrdStatus = strPrdStatus+Integer.toString(intsno)+".Enter the values in Proposal -> Checklist : Facility Based"+ "\n";
			        		}
			          }
			        else if(securityvalue.equalsIgnoreCase("28"))
			          {
			        		strQuery = SQLParser.getSqlQuery("checkgeneralfacilityindustry^" + strappno + "^" + "I");
			        		if (rs != null) 
			        		{
			        			rs.close();
			        		}
			        		rs = DBUtils.executeQuery(strQuery);
			        		rs.next();
			        		if (rs.getInt(1) == 0) 
			        		{
			        			intsno=intsno+1;
			        			strPrdStatus = strPrdStatus+Integer.toString(intsno)+".Enter the values in Proposal -> Checklist : Industry Based"+ "\n";
		                 	 }
			          }
					}
					if (rs != null) 
	        		{
	        			rs.close();
	        		}
		           	}
			      }
				if(!strPrdStatus.equalsIgnoreCase(""))
				{
					strPrdStatus="$"+strPrdStatus;
					hshRecord.put("strPrdStatus", strPrdStatus);
				}
			   }
		       catch (Exception e) 
		       {
		    	   log.error("exception in checkPageStatus... " + e);
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
		    	   catch (Exception e1) 
		    	   {
		    		   log.error("Error closing connection.. " + e1);
		    	   }
		       }
		return hshRecord;
	}
public String checkFacilitySaveStatus(HashMap hshValues)
{
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		String strPrdStatus = "";
		String strQuery = null;
		String fac_id = Helper.correctNull((String) hshValues.get("fac_id"));
		try {
			rs = DBUtils.executeLAPSQuery("checkfacusedby^" + fac_id);
			rs.next();
			if (rs.getInt(1) == 0) {
				strPrdStatus += "u";
			}
			
			//Blocked by Guhan.T - this check is not required
			/*String strFacType="",strFacNature="";
			strQuery = SQLParser.getSqlQuery("sel_facilitycorp^" + fac_id);
			if (rs != null)
			{
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				strFacType=Helper.correctNull((String)rs.getString("COM_FACTYPE"));
				strFacNature=Helper.correctNull((String)rs.getString("COM_FACNATURE"));
			}
			if((strFacType.trim().equalsIgnoreCase("NF")) && (strFacNature.trim().equalsIgnoreCase("1")) )
			{
				strQuery = SQLParser.getSqlQuery("checkfaccommission^" + fac_id);
				if (rs != null) {
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				rs.next();
				if (rs.getInt(1) == 0) {
					strPrdStatus += "ch";
				}
			}
			else
			{*/
				String strfacrating="",ratingflag="Y",strIntDefination="";
				String strsector[]={"01","02","11"};
				rs=DBUtils.executeLAPSQuery("setproductsselcorporate^"+fac_id);
				if(rs.next())
				{
					strfacrating=Helper.correctNull((String)rs.getString("com_facRating"));
					strIntDefination=Helper.correctNull(rs.getString("com_facintdef"));
				}
//				if(strfacrating.equalsIgnoreCase("Y")) {
//					if (rs != null) {
//						rs.close();
//					}
//					boolean bolIntAvailFlag = false; 
//					rs = DBUtils.executeLAPSQuery("sel_intidFrommaster^"+fac_id);
//					while(rs.next())
//					{
//						bolIntAvailFlag = true;
//						rs1=DBUtils.executeLAPSQuery("sel_intsnofromlimit^"+Helper.correctInt((String)rs.getString("corpprdint_sno")));
//						while(rs1.next())
//						{
//								if(!ratingflag.equalsIgnoreCase("N")) 
//								{
//								for(int i=0;i<3;i++) {
//									if(!ratingflag.equalsIgnoreCase("N")) 
//									{
//										rs2=DBUtils.executeLAPSQuery("checkfacRatingBasedRoi^"+Helper.correctInt((String)rs.getString("corpprdint_sno"))+"^"+
//												Helper.correctInt((String)rs1.getString("corpprd_sno"))+"^"+strsector[i]);
//										if(rs2.next())
//										{
//											if(rs2.getInt(1)==0)
//											{ratingflag="N" ; break;}
//										}
//								     }
//								 }
//							  }
//						}
//					}
//					if ((ratingflag.equalsIgnoreCase("N")|| bolIntAvailFlag == false) && !(strIntDefination.equalsIgnoreCase("M"))) {
//						strPrdStatus += "i";
//					}
//				}
				//else {
					strQuery = SQLParser.getSqlQuery("checkfacinterest^" + fac_id);
					if (rs != null) {
						rs.close();
					}
					rs = DBUtils.executeQuery(strQuery);
					rs.next();
					if ((rs.getInt(1) == 0)&& !(strIntDefination.equalsIgnoreCase("M"))) {
						strPrdStatus += "i";
					}
				//}
			//}
			strQuery = SQLParser.getSqlQuery("checkfacothers^" + fac_id);
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			rs.next();
			if (rs.getInt(1) == 0) {
				strPrdStatus += "d";
			}
			
			strQuery = SQLParser.getSqlQuery("checkprdactcode^"+ fac_id);
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			rs.next();
			if (rs.getInt(1) == 0) {
				strPrdStatus += "pa";
			}
			strQuery = SQLParser.getSqlQuery("checkfacdeligpower^"+ fac_id);
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			rs.next();
			if (rs.getInt(1) == 0) {
				strPrdStatus += "dp";
			}
			/* End - Checking entry in Products - Activity Codes */
			if (strPrdStatus.equals("")) {
				strPrdStatus = "c";
			}
		} catch (Exception e) {
			log.error("exception in checkProductSaveStatus... " + e);
			throw new EJBException(e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e1) {
				log.error("Error closing connection.. " + e1);
			}
		}
		return strPrdStatus;
	}
	public void updateFacilitySaveStatus(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		String strPrdStatus = "";
		String fac_id = (String) hshValues.get("fac_id");
		try {
			strPrdStatus = checkFacilitySaveStatus(hshValues);
			hshQueryValues.put("size", "1");
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "facility_status");
			if (strPrdStatus.equals("c"))
				arrValues.add("c");
			else
				arrValues.add("p");
			arrValues.add(fac_id);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
		} catch (Exception e) {
			log.error("exception in updateFacilitySaveStatus.." + e);
			throw new EJBException(e.getMessage());
		} finally {
			hshQueryValues = null;
			hshQuery = null;
			arrValues = null;
		}
	}
	public HashMap getAmountRange(HashMap hshRequestValues)  {
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();
		String fac_id = Helper.correctNull((String) hshRequestValues.get("fac_id1"));
		String amountrange = Helper.correctNull((String) hshRequestValues.get("amountrange"));

		try {
			hshRecord = new HashMap();
			rs = DBUtils.executeLAPSQuery("com_facility_amountrange^"+ fac_id);
			while (rs.next()) {
				vecCol = new ArrayList();
				for (int i = 0; i < 3; i++) {
					vecCol.add(rs.getString(i + 1));
				}
				vecRow.add(vecCol);
			}
			hshRecord.put("vecRow", vecRow);
			hshRecord.put("amountrange", amountrange);
		} catch (Exception e) {
			throw new EJBException(e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e1) {
				throw new EJBException(e1.getMessage());
			}
		}
		return hshRecord;
	}
	public HashMap getProcessingFee(HashMap hsh)  {
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshValues = null;
		String industrytype = "";
		String fac_id = Helper.correctNull((String) hsh.get("fac_id1"));
		String range_id = "";
		try {
			hshValues = new HashMap();
			industrytype = correctNull((String) hsh.get("hidindtype"));
			range_id = correctNull((String) hsh.get("hiddesc"));
			hshValues.put("range_id", range_id);
			if(!range_id.equalsIgnoreCase("S"))
			{
			strQuery = SQLParser.getSqlQuery("com_selprocessfee^"+ fac_id + "^" + range_id);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshValues.put("FACILITYCODE", Helper.correctNull(rs
						.getString("PROCESS_FACILITYCODE")));
				hshValues.put("PROCESS_ID", Helper.correctNull(rs
						.getString("PROCESS_ID")));
				hshValues.put("PROCESS_RANGEFROM", Helper.correctDouble(rs
						.getString("PROCESS_RANGEFROM")));
				hshValues.put("PROCESS_RANGETO", Helper.correctDouble(rs
						.getString("PROCESS_RANGETO")));
				hshValues.put("PROCESS_PERCENTCHARGE", Helper.correctNull(rs
						.getString("PROCESS_PERCENTCHARGE")));
				hshValues
						.put("PROCESS_MINACTUALCHARGE", Helper.correctNull(rs
								.getString("PROCESS_MINACTUALCHARGE")));
				hshValues
						.put("PROCESS_MAXACTUALCHARGE", Helper.correctNull(rs
								.getString("PROCESS_MAXACTUALCHARGE")));
				hshValues.put("PROCESS_NONPRIORITY", Helper.correctNull(rs
						.getString("PROCESS_NONPRIORITY")));
				hshValues.put("PROCESS_ADHOCAMT", Helper.correctNull(rs
						.getString("PROCESS_ADHOCAMT")));
			}
}
			hsh = null;
		}
		catch (Exception e) {
			throw new EJBException(
					"in corporatefacilityBean bean - getProcessingFee method"
							+ e.toString());
		}
		finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e1) {
				throw new EJBException("error occured" + e1.toString());
			}
		}
		return hshValues;
	}
	public void updateProcessChargesData(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = new ArrayList();
		String strAction = (String) hshValues.get("hidAction");
		String fac_id = Helper.correctNull((String) hshValues.get("fac_id1"));
		String strProcessID = null;
		String strrangefrom = "", strrangeto = "";
		String strExp = "$";
		String strQuery = "";
		ResultSet rs = null;
		try {
			if (strAction.equals("insert")) {
				strrangefrom = Helper.correctDouble((String) hshValues
						.get("proc_amtrangfrm"));
				strrangeto = Helper.correctDouble((String) hshValues
						.get("proc_amtrangto"));
				strQuery = SQLParser
						.getSqlQuery("setfacilitycheckprocessrange^" + fac_id
								+ "^" + strrangefrom
								+ "^" + strrangeto);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					if (rs.getInt(1) != 0) {
						strExp = strExp + " Check the existing amount range ";
						throw new EJBException(strExp);
					}
				}
				strProcessID = (String) getMaxProcessFeeID(fac_id);
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshValues.put("hidId", "strtermId");
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_setfacilityprocessfee");
				arrValues.add(fac_id);//BIGINT
				arrValues.add(strProcessID);//BIGINT
				arrValues.add(strrangefrom);//DECIMAL
				arrValues.add(strrangeto);//DECIMAL
				arrValues.add(Helper.correctDouble((String) hshValues
						.get("proc_profees")));//DECIMAL
				arrValues.add(Helper.correctDouble((String) hshValues
						.get("proc_minprofees")));//DECIMAL
				arrValues.add(Helper.correctDouble((String) hshValues
						.get("proc_maxprofees")));//DECIMAL
				arrValues.add(Helper.correctDouble((String) hshValues
						.get("proc_profees4")));//DECIMAL
				arrValues
						.add(Helper.correctDouble((String) hshValues.get("proc_adhoc")));//DDECIMAL

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");

				HashMap hshTemp = new HashMap();
				hshTemp.put("fac_id", hshValues.get("fac_id1"));
				EJBInvoker.executeStateLess("corporatefacility", hshTemp,
						"updateFacilitySaveStatus");
			}
			else if (strAction.equals("update")) {
				strProcessID = correctNull((String) hshValues.get("hiddesc"));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "update_setfacilityprocessfee");
				arrValues.add(Helper.correctDouble((String) hshValues
						.get("proc_amtrangfrm")));
				arrValues.add(Helper.correctDouble((String) hshValues
						.get("proc_amtrangto")));
				arrValues.add(Helper.correctDouble((String) hshValues
						.get("proc_profees")));
				arrValues.add(Helper.correctDouble((String) hshValues
						.get("proc_minprofees")));
				arrValues.add(Helper.correctDouble((String) hshValues
						.get("proc_maxprofees")));
				arrValues.add(Helper.correctDouble((String) hshValues
						.get("proc_profees4")));
				arrValues
						.add(Helper.correctDouble((String) hshValues.get("proc_adhoc")));
				arrValues.add(fac_id);
				arrValues.add(strProcessID);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			} else if (strAction.equals("delete")) {
				strProcessID = correctNull((String) hshValues.get("hiddesc"));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "del_setfacilityprocessfee");
				arrValues.add(fac_id);
				arrValues.add(strProcessID);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
		} catch (Exception ce) {
			throw new EJBException(ce.toString());
		} finally {
			hshQueryValues = null;
			hshQuery = null;
			arrValues = null;
		}
	}
	private String getMaxProcessFeeID(String strFacilityid)  {
		String strQuery = "";
		ResultSet rs = null;
		String termId = "";
		try {
			strQuery = SQLParser.getSqlQuery("setfacility_maxprocessid^"+ strFacilityid);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				termId = rs.getString(1);
			}
			rs.close();

		} catch (Exception ce) {
			log.error(ce.toString());
			throw new EJBException("Error in getMaxProcessFeeID "
					+ ce.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return termId;
	}
	public HashMap getDocFee(HashMap hsh)  {
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshValues = null;
		String industrytype = "";
		String range_id = "", fac_id = "";
		try {
			fac_id = Helper.correctNull((String) hsh.get("fac_id1"));
			hshValues = new HashMap();
			industrytype = correctNull((String) hsh.get("hidindtype"));
			range_id = correctNull((String) hsh.get("hiddesc"));
			if(!range_id.equalsIgnoreCase("S"))	
			{
			strQuery = SQLParser.getSqlQuery("com_seldocfee^" + fac_id + "^" + range_id);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshValues.put("INDUSTRYTYPE", Helper.correctNull(rs
						.getString("Doc_INDUSTRYTYPE")));
				hshValues.put("FACILITYCODE", Helper.correctNull(rs
						.getString("Doc_FACILITYCODE")));
				hshValues.put("Doc_ID", Helper.correctNull(rs
						.getString("Doc_ID")));
				hshValues.put("Doc_RANGEFROM", Helper.correctDouble(rs
						.getString("Doc_RANGEFROM")));
				hshValues.put("Doc_RANGETO", Helper.correctDouble(rs
						.getString("Doc_RANGETO")));
				hshValues.put("Doc_PERCENTCHARGE", Helper.correctDouble(rs
						.getString("Doc_PERCENTCHARGE")));
				hshValues.put("Doc_MINACTUALCHARGE", Helper.correctDouble(rs
						.getString("Doc_MINACTUALCHARGE")));
				hshValues.put("Doc_MAXACTUALCHARGE", Helper.correctDouble(rs
						.getString("Doc_MAXACTUALCHARGE")));
			}
			}
		}
		catch (Exception e) {
			throw new EJBException(
					"in corporatefacilityBean bean - getDocFee method"
							+ e.toString());
		}
		finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e1) {
				throw new EJBException("error occured" + e1.toString());
			}
		}
		return hshValues;
	}
	public HashMap updateDocChargesData(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = new ArrayList();
		String strAction = (String) hshValues.get("hidAction");
		String fac_id = Helper.correctNull((String) hshValues.get("fac_id1"));
		String strindustrytype = null;
		String strDocID = null;
		String strrangefrom = "", strrangeto = "";
		String strExp = "$";
		String strQuery = "";
		ResultSet rs = null;
		try {
			if (strAction.equals("insert")) {
				strindustrytype = correctNull((String) hshValues
						.get("hidindtype"));
				strrangefrom = Helper.correctDouble((String) hshValues
						.get("doc_amtrangfrm"));
				strrangeto = Helper.correctDouble((String) hshValues
						.get("doc_amtrangto"));
				strQuery = SQLParser.getSqlQuery("setfacilitycheckdocrange^"+ fac_id + "^" + strrangefrom
						+ "^" + strrangeto);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					if (rs.getInt(1) != 0) {
						strExp = strExp + " Check the existing amount range ";
						throw new Exception(strExp);
					}
				}
				strDocID = (String) getMaxDocFeeID(strindustrytype, fac_id);
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshValues.put("hidId", "strtermId");
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_setfacilitydocfee");
				arrValues.add(fac_id);//doc_facilityCODE BIGINT
				arrValues.add(strDocID);//doc_ID 			BIGINT
				arrValues.add(strrangefrom);//doc_RANGEFROM  	DECIMAL
				arrValues.add(strrangeto);//doc_RANGETO      DECIMAL
				arrValues
						.add(Helper.correctDouble((String) hshValues.get("doc_profees")));//doc_PERCENTCHARGE DECIMAL
				arrValues.add(Helper.correctDouble((String) hshValues
						.get("doc_minprofees")));//doc_MINACTUALCHARGE DECIMAL
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
				HashMap hshTemp = new HashMap();
				hshTemp.put("fac_id", hshValues.get("fac_id1"));
				EJBInvoker.executeStateLess("corporatefacility", hshTemp,
						"updateFacilitySaveStatus");
			}
			else if (strAction.equals("update")) {
				strDocID = correctNull((String) hshValues.get("hiddesc"));
				strindustrytype = correctNull((String) hshValues
						.get("hidindtype"));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "update_setfacilitydocfee");
				arrValues.add(Helper.correctDouble((String) hshValues
						.get("doc_amtrangfrm")));
				arrValues.add(Helper.correctDouble((String) hshValues
						.get("doc_amtrangto")));
				arrValues
						.add(Helper.correctDouble((String) hshValues.get("doc_profees")));
				arrValues.add(Helper.correctDouble((String) hshValues
						.get("doc_minprofees")));
				arrValues.add(Helper.correctDouble((String) hshValues
						.get("doc_maxprofees")));
				arrValues.add(fac_id);
				arrValues.add(strDocID);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			} else if (strAction.equals("delete")) {
				strDocID = correctNull((String) hshValues.get("hiddesc"));
				strindustrytype = correctNull((String) hshValues
						.get("hidindtype"));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "del_setfacilitydocfee");
				arrValues.add(fac_id);
				arrValues.add(strDocID);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
		} catch (Exception ce) {
			throw new EJBException(ce.toString());
		} finally {
			hshQueryValues = null;
			hshQuery = null;
			arrValues = null;
		}
		return hshValues;
	}
	private String getMaxDocFeeID(String strIndustryType, String strFacilityid)
			 {
		String strQuery = "";
		ResultSet rs = null;
		String termId = "";
		try {
			strQuery = SQLParser.getSqlQuery("setfacility_maxdocid^"+ strFacilityid);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				termId = rs.getString(1);
			}
			rs.close();
		} catch (Exception ce) {
			log.error(ce.toString());
			throw new EJBException("Error in getMaxDocFeeID " + ce.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return termId;
	}
	public HashMap getAmountDocRange(HashMap hshRequestValues)
			 {
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();
		String strIndType = Helper.correctNull((String) hshRequestValues
				.get("indtype"));
		String fac_id = Helper.correctNull((String) hshRequestValues
				.get("fac_id1"));
		// String facility_catid = Helper.correctNull((String)
		// hshRequestValues.get("facility_catid"));
		String amountrange = Helper.correctNull((String) hshRequestValues
				.get("amountrange"));
		try {
			hshRecord = new HashMap();
			rs = DBUtils.executeLAPSQuery("com_facility_amountdocrange^"+ fac_id);
			while (rs.next()) {
				vecCol = new ArrayList();
				for (int i = 0; i < 3; i++) {
					vecCol.add(rs.getString(i + 1));
				}
				vecRow.add(vecCol);
			}
			hshRecord.put("vecRow", vecRow);
			hshRecord.put("amountrange", amountrange);
		} catch (Exception e) {
			throw new EJBException(e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e1) {
				throw new EJBException(e1.getMessage());
			}
		}
		return hshRecord;
	}
	public HashMap getMarginFee(HashMap hsh)  {
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshValues = null;
		String industrytype = "";
		String range_id = "";
		String fac_id = "";
		try {
			fac_id = Helper.correctNull((String) hsh.get("fac_id1"));
			hshValues = new HashMap();
			industrytype = correctNull((String) hsh.get("hidindtype"));
			range_id = correctNull((String) hsh.get("hiddesc"));
			strQuery = SQLParser.getSqlQuery("com_selmarfee^" + fac_id + "^" + range_id);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshValues.put("INDUSTRYTYPE", Helper.correctNull(rs
						.getString("mar_industrytype")));
				hshValues.put("FACILITYCODE", Helper.correctNull(rs
						.getString("Mar_FACILITYCODE")));
				hshValues.put("Mar_ID", Helper.correctNull(rs
						.getString("Mar_ID")));
				hshValues.put("Mar_RANGEFROM", Helper.correctDouble(rs
						.getString("Mar_RANGEFROM")));
				hshValues.put("Mar_RANGETO", Helper.correctDouble(rs
						.getString("Mar_RANGETO")));
				hshValues.put("Mar_PN", Helper.correctDouble(rs
						.getString("mar_priornew")));
				hshValues.put("Mar_PO", Helper.correctDouble(rs
						.getString("mar_priorold")));
				hshValues.put("Mar_NPN", Helper.correctDouble(rs
						.getString("mar_nonpriornew")));
				hshValues.put("Mar_NPO", Helper.correctDouble(rs
						.getString("mar_nonpriorold")));
			}
		}
		catch (Exception e) {
			throw new EJBException(
					"in corporatefacilityBean bean - getMarginFee method"
							+ e.toString());
		}
		finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e1) {
				throw new EJBException("error occured" + e1.toString());
			}
		}
		return hshValues;
	}
	public HashMap updateMarginChargesData(HashMap hshValues)
			 {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = new ArrayList();
		String strAction = (String) hshValues.get("hidAction");
		String strindustrytype = null;
		String strmarID = null;
		String strrangefrom = "", strrangeto = "";
		String strExp = "$";
		String strQuery = "";
		String fac_id = "";
		ResultSet rs = null;
		try {
			fac_id = Helper.correctNull((String) hshValues.get("fac_id1"));
			if (strAction.equals("insert")) {
				strindustrytype = correctNull((String) hshValues
						.get("hidindtype"));
				strrangefrom = Helper.correctDouble((String) hshValues
						.get("mar_amtrangfrm"));
				strrangeto = Helper.correctDouble((String) hshValues
						.get("mar_amtrangto"));
				strQuery = SQLParser.getSqlQuery("setfacilitycheckmarrange^" + fac_id + "^" + strrangefrom
						+ "^" + strrangeto);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					if (rs.getInt(1) != 0) {
						strExp = strExp + " Check the existing amount range ";
						throw new Exception(strExp);
					}
				}
				strmarID = (String) getMaxMarginID(strindustrytype, fac_id);
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshValues.put("hidId", "strtermId");
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_setfacilitymarfee");
				arrValues.add(fac_id);//mar_facilityCODE  BI
				arrValues.add(strmarID);//mar_ID BI
				arrValues.add(strrangefrom); //MAR_RANGEFROM DECIMAL
				arrValues.add(strrangeto);//mar_RANGETO DEC
				arrValues.add(Helper.correctDouble((String) hshValues.get("margin_pn")));//mar_priornew DEC
				arrValues.add(Helper.correctDouble((String) hshValues.get("margin_po")));//mar_priorold DEC
				arrValues
						.add(Helper.correctDouble((String) hshValues.get("margin_npn")));//mar_nonpriornew DEC
				arrValues
						.add(Helper.correctDouble((String) hshValues.get("margin_npo")));//mar_nonpriorold DEC
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
				HashMap hshTemp = new HashMap();
				hshTemp.put("fac_id", hshValues.get("fac_id1"));
				EJBInvoker.executeStateLess("corporatefacility", hshTemp,
						"updateFacilitySaveStatus");
			}
			else if (strAction.equals("update")) {
				strmarID = correctNull((String) hshValues.get("hiddesc"));
				strindustrytype = correctNull((String) hshValues
						.get("hidindtype"));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "update_setfacilitymarfee");
				arrValues.add(Helper.correctDouble((String) hshValues
						.get("mar_amtrangfrm")));//mar_RANGEFROM DEC
				arrValues.add(Helper.correctDouble((String) hshValues
						.get("mar_amtrangto")));//mar_RANGETO DEC
				arrValues.add(Helper.correctDouble((String) hshValues.get("margin_pn")));//mar_priornew DEC
				arrValues.add(Helper.correctDouble((String) hshValues.get("margin_po")));//mar_priorold DEC
				arrValues
						.add(Helper.correctDouble((String) hshValues.get("margin_npn")));//mar_nonpriornew DEC
				arrValues
						.add(Helper.correctDouble((String) hshValues.get("margin_npo")));//mar_nonpriorold DEC
				arrValues.add(fac_id);
				arrValues.add(strmarID);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			} else if (strAction.equals("delete")) {
				strmarID = correctNull((String) hshValues.get("hiddesc"));
				strindustrytype = correctNull((String) hshValues
						.get("hidindtype"));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "del_setfacilitymarfee");
				arrValues.add(fac_id);
				arrValues.add(strmarID);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
		} catch (Exception ce) {
			throw new EJBException(ce.toString());
		} finally {
			hshQueryValues = null;
			hshQuery = null;
			arrValues = null;
		}
		return hshValues;
	}
	private String getMaxMarginID(String strIndustryType, String strFacilityid)
			 {
		String strQuery = "";
		ResultSet rs = null;
		String termId = "";
		try {
			strQuery = SQLParser.getSqlQuery("setfacility_maxmarid^"+ strFacilityid);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				termId = rs.getString(1);
			}
			rs.close();
		} catch (Exception ce) {
			log.error(ce.toString());
			throw new EJBException("Error in getMaxMarginID " + ce.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return termId;
	}
	public HashMap getAmountMarginRange(HashMap hshRequestValues)
			 {
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();
		String strIndType = Helper.correctNull((String) hshRequestValues
				.get("indtype"));
		String fac_id = Helper.correctNull((String) hshRequestValues
				.get("fac_id1"));
		String amountrange = Helper.correctNull((String) hshRequestValues
				.get("amountrange"));
		try {
			hshRecord = new HashMap();
			rs = DBUtils.executeLAPSQuery("com_facility_amountmarrange^" + fac_id);
			while (rs.next()) {
				vecCol = new ArrayList();
				for (int i = 0; i < 3; i++) {
					vecCol.add(rs.getString(i + 1));
				}
				vecRow.add(vecCol);
			}
			hshRecord.put("vecRow", vecRow);
			hshRecord.put("amountrange", amountrange);
		} catch (Exception e) {
			throw new EJBException(e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e1) {
				throw new EJBException(e1.getMessage());
			}
		}
		return hshRecord;
	}
	public HashMap updateData(HashMap hshValues)  {
		ResultSet rs = null;
		String strQuery = null;
		HashMap hshQueryValues = new HashMap();
		HashMap hshRecord = new HashMap();
		HashMap hshQuery = new HashMap();
		String fac_id = "";
		ArrayList arrValues = new ArrayList();
		String indtype = Helper.correctNull((String) hshValues.get("indtype"));
		StringBuilder sbAuditTrial=new StringBuilder();
		StringBuilder sbOldAudit = new StringBuilder();
		try {
			String strAction = correctNull((String) hshValues.get("hidAction"));
			String strfaccode = correctNull((String) hshValues.get("txt_code"));
			String strheadfac = correctNull((String) hshValues.get("hidcat_id"));
			String strsubfac = correctNull((String) hshValues
					.get("hidcat_parent"));
			if (strheadfac.equalsIgnoreCase("")
					|| strheadfac.equalsIgnoreCase("null")) {
				strheadfac = correctNull((String) hshValues
						.get("hidcorp_headname"));
			}
			if (strsubfac.equalsIgnoreCase("")
					|| strsubfac.equalsIgnoreCase("null")) {
				strsubfac = correctNull((String) hshValues
						.get("hidcorp_subfac"));
			}
			String strrangefrom = correctNull((String) hshValues.get("prd_rng_from"));
			String strrangeto = correctNull((String) hshValues.get("prd_rng_to"));
			String strcprdminterm = correctNull((String) hshValues.get("prd_minterm"));
			String strprdmaxterm = correctNull((String) hshValues.get("prd_maxterm"));
			String strholiday = correctNull((String) hshValues.get("txt_holiday"));
			String strfacid = correctNull((String) hshValues.get("fac_id1"));
			String strfactype = correctNull((String) hshValues.get("seltype"));
			String strfacnature = correctNull((String) hshValues.get("facility1"));
			String strfacdescrip = correctNull((String) hshValues.get("txt_descrip"));
			String strfacility_stop = correctNull((String) hshValues.get("sel_stop"));			
			String strfacility_loan = correctNull((String) hshValues.get("fac_loantype"));
			String strfacility_emicode = correctNull((String) hshValues.get("scheme_code"));
			String strfacility_nonemicode = correctNull((String) hshValues.get("schcode_nonemi"));
			String strfacility_eicode = correctNull((String) hshValues.get("schcode_ei"));
			String strfacility_noneicode = correctNull((String) hshValues.get("schcode_nonei"));
			String strfacility_lumpsum= correctNull((String) hshValues.get("schcode_lumpsum"));
			String strfacility_module= correctNull((String) hshValues.get("sel_facility"));
			String stragr_scheme = correctNull((String) hshValues.get("prd_type"));
			String strBankScheme=correctNull((String) hshValues.get("sel_bankscheme"));
			String strAgrScheme=correctNull((String) hshValues.get("sel_schemetype"));
			String strselintrate=correctNull((String) hshValues.get("selintrate"));
			String strratingreq=correctNull((String) hshValues.get("selrating"));
			String strintrodate=correctNull((String)hshValues.get("fac_intro_date"));
			String strschemeheadcode=correctNull((String)hshValues.get("selschemehead"));
			String strCashMargin=correctNull((String)hshValues.get("hidcashmargin"));
			String strLoanagainstshare=correctNull((String)hshValues.get("hidloanagainstshare"));
			String strRepayType=correctNull((String)hshValues.get("hidRepaymentType"));
			String strIntDefinition=correctNull((String)hshValues.get("sel_intdefinition"));
			String strWhetherDigi=correctNull((String)hshValues.get("sel_digi"));
			String strWhetherDigiRating=correctNull((String)hshValues.get("sel_digiRating"));
			String strExpiryDate=correctNull((String)hshValues.get("txt_expirydate"));
			String strpoolrating=correctNull((String)hshValues.get("sel_rating_pool"));

			if(strfacility_stop.equalsIgnoreCase("")||strfacility_stop.equalsIgnoreCase(null))
			{
				strfacility_stop="0";
			}
			if(strfacility_loan.equalsIgnoreCase("")||strfacility_loan.equalsIgnoreCase(null))
			{
				strfacility_loan="0";
			}
			if(strfacility_emicode.equalsIgnoreCase("")||strfacility_emicode.equalsIgnoreCase(null))
			{
				strfacility_emicode="S";
			}
			if(strfacility_nonemicode.equalsIgnoreCase("")||strfacility_nonemicode.equalsIgnoreCase(null))
			{
				strfacility_nonemicode="S";
			}
			String strsel_purposeofloan = correctNull((String) hshValues.get("sel_purposeofloan"));
			if (!(strfacid.equalsIgnoreCase("corpnew") || strfacid.equalsIgnoreCase("new")))
			{
				/***
				 * For Audit Trial Old Data - By Karthikeyan.S on 10/10/2013
				 */
				strQuery=SQLParser.getSqlQuery("setproductsselcorporate^"+strfacid);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					//Facility For
					String strFacForOldAudit=Helper.correctNull(rs.getString("com_module"));
					String strFacForDescOldAudit="";
					if(strFacForOldAudit.equalsIgnoreCase("c"))
					{
						strFacForDescOldAudit="Corporate";
					}
					else if(strFacForOldAudit.equalsIgnoreCase("a"))
					{
						strFacForDescOldAudit="Agriculture";
					}
					//Type of Loan
					String strLoanTypeOldAudit=Helper.correctNull(rs.getString("com_facility_loantype"));
					String strLoanTypeDescOldAudit="";
					if(strLoanTypeOldAudit.equalsIgnoreCase("TL"))
					{
						strLoanTypeDescOldAudit="Term Loan";
					}
					else if(strLoanTypeOldAudit.equalsIgnoreCase("DL"))
					{
						strLoanTypeDescOldAudit="Demand Loan";
					}
					else if(strLoanTypeOldAudit.equalsIgnoreCase("OD"))
					{
						strLoanTypeDescOldAudit="Over Draft";
					}
					else if(strLoanTypeOldAudit.equalsIgnoreCase("CC"))
					{
						strLoanTypeDescOldAudit="Cash Credit";
					}
					//Nature Of Facility
					String strFacNatureOldAudit=Helper.correctNull(rs.getString("hidfac_nature"));
					String strFacNatureDescOldAudit="";
					if(strFacNatureOldAudit.equalsIgnoreCase("1"))
					{
						strFacNatureDescOldAudit="Working Capital";
					}
					else if(strFacNatureDescOldAudit.equalsIgnoreCase("2"))
					{
						strFacNatureDescOldAudit="Term Loan";
					}
					//Type
					String strTypeOldAudit=Helper.correctNull(rs.getString("hidfac_type"));
					String strTypeDescOldAudit="";
					if(strTypeOldAudit.equalsIgnoreCase("F"))
					{
						strTypeDescOldAudit="Funded";
					}
					else if(strTypeOldAudit.equalsIgnoreCase("NF"))
					{
						strTypeDescOldAudit="Non Funded";
					}
					//Stop Product to User
					String strPrdStopOldAudit=Helper.correctNull(rs.getString("com_facility_stop"));
					String strPrdStopDescOldAudit="";
					if(strPrdStopOldAudit.equalsIgnoreCase("0"))
					{
						strPrdStopDescOldAudit="No";
					}
					else if(strPrdStopOldAudit.equalsIgnoreCase("1"))
					{
						strPrdStopDescOldAudit="Yes";
					}
					String strCashMarginOldAudit=Helper.correctNull(rs.getString("com_cashmargin"));
					if(strCashMarginOldAudit.equalsIgnoreCase("N"))
					{
						strCashMarginOldAudit="No";
					}
					else if(strPrdStopOldAudit.equalsIgnoreCase("Y"))
					{
						strCashMarginOldAudit="Yes";
					}
					String strLoanAgainstShareOldAudit=Helper.correctNull(rs.getString("com_loanagainstshares"));
					if(strLoanAgainstShareOldAudit.equalsIgnoreCase("N"))
					{
						strLoanAgainstShareOldAudit="No";
					}
					else if(strLoanAgainstShareOldAudit.equalsIgnoreCase("Y"))
					{
						strLoanAgainstShareOldAudit="Yes";
					}
					sbOldAudit.append("~Facility Code=").append(Helper.correctNull(rs.getString("hidcorp_faccode")))
					.append("~Facility ID=").append(Helper.correctNull(rs.getString("hidcorp_facid")))
					.append("~Facility For=").append(strFacForDescOldAudit)
					.append("~Type of Loan=").append(strLoanTypeDescOldAudit)
					.append("~Nature Of Facility=").append(strFacNatureDescOldAudit)
					.append("~Head Of the Facility=").append(Helper.correctNull(rs.getString("facheaddesc")))
					.append("~Facility=").append(Helper.correctNull(rs.getString("facdesc")))
					.append("~Description=").append(Helper.correctNull(rs.getString("hid_facdescp")))
					.append("~Scheme Code=").append(Helper.correctNull(rs.getString("com_facility_emischeme")))
					.append("~Type=").append(strTypeDescOldAudit)
					.append("~Agri Scheme=").append(Helper.correctNull(rs.getString("com_agrscheme")))
					.append("~Range From=").append(Helper.correctNull(rs.getString("prd_rng_from")))
					.append("~Range To=").append(Helper.correctNull(rs.getString("prd_rng_to")))
					.append("~Min. Loan Period (in Months)=").append(Helper.correctNull(rs.getString("hid_minperiod")))
					.append("~Max. Loan Period (in Months)=").append(Helper.correctNull(rs.getString("hid_maxperiod")))
					.append("~Holiday Period=").append(Helper.correctNull(rs.getString("hid_holidayperiod")))
					.append("~Stop Product to User=").append(strPrdStopDescOldAudit)
					.append("~100 % Cash Margin=").append(strCashMarginOldAudit)
					.append("~Loan Against Share =").append(strLoanAgainstShareOldAudit)
					.append("~Applicable Interest Type =").append(Helper.correctNull(rs.getString("fac_interesttype")))
					.append("~Facility Display Description =").append(Helper.correctNull(rs.getString("com_facdispdesc")))
					.append("~Forex Facility").append(Helper.correctNull(rs.getString("com_forexfac")));
				}
				if(rs!=null)
				{
					rs.close();
				}
				/***
				 * End - Audit Trial Old Data
				 */
			}
			if (strAction.equalsIgnoreCase("update")) {
				if (strfacid.equalsIgnoreCase("corpnew") || strfacid.equalsIgnoreCase("new")) {
					strQuery = "selmaxfacid";
					rs = DBUtils.executeLAPSQuery(strQuery);
					if (rs.next()) {
						strfacid = Helper.correctNull((String) rs.getString("snorelmax"));
					}
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					hshQuery.put("strQueryId", "insfacdetail");
					arrValues.add(strfacid);
					arrValues.add(strfaccode);
					arrValues.add(strheadfac);
					arrValues.add(strsubfac);
					arrValues.add(strrangefrom);
					arrValues.add(strrangeto);
					arrValues.add(strcprdminterm);
					arrValues.add(strprdmaxterm);
					arrValues.add(strholiday);
					arrValues.add(strfactype);
					arrValues.add(strfacnature);
					arrValues.add(strfacdescrip);
					arrValues.add(strfacility_stop);
					arrValues.add(strfacility_loan );
					arrValues.add(strfacility_emicode);
					arrValues.add(strfacility_nonemicode);
					arrValues.add(strfacility_eicode);
					arrValues.add(strfacility_noneicode);
					arrValues.add(strfacility_lumpsum);
					arrValues.add(strsel_purposeofloan);
					arrValues.add(strfacility_module);
					arrValues.add(stragr_scheme);
					arrValues.add(strBankScheme);
					arrValues.add(strAgrScheme);					
					arrValues.add(strselintrate);		
					arrValues.add(strratingreq);
					arrValues.add(strintrodate);
					arrValues.add(strschemeheadcode);
					arrValues.add(strCashMargin);
					arrValues.add(strRepayType);
					arrValues.add(strIntDefinition);
					arrValues.add(strLoanagainstshare);
					arrValues.add(Helper.correctNull((String)hshValues.get("loan_again_share")));
					arrValues.add(Helper.correctNull((String)hshValues.get("hidInterestType")));
					arrValues.add(strWhetherDigi);
					arrValues.add(strExpiryDate);
					arrValues.add(Helper.correctNull((String)hshValues.get("hidFacDisplayDesc")));
					arrValues.add(Helper.correctNull((String)hshValues.get("sel_forexfac")));
					arrValues.add(strWhetherDigiRating);
					arrValues.add(strpoolrating);
					arrValues.add(correctNull((String)hshValues.get("prd_mintermrest")));
					arrValues.add(correctNull((String)hshValues.get("prd_maxtermrest")));
					arrValues.add(correctNull((String) hshValues.get("txt_holidayrest")));
					arrValues.add(correctNull((String) hshValues.get("sel_CGTMSE")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
				else {
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					hshQuery.put("strQueryId", "updatefacdetail");
					arrValues.add(strfaccode);
					arrValues.add(strheadfac);
					arrValues.add(strsubfac);
					arrValues.add(strrangefrom);
					arrValues.add(strrangeto);
					arrValues.add(strcprdminterm);
					arrValues.add(strprdmaxterm);
					arrValues.add(strholiday);
					arrValues.add(strfactype);
					arrValues.add(strfacnature);
					arrValues.add(strfacdescrip);
					arrValues.add(strfacility_stop);
					arrValues.add(strfacility_loan );
					arrValues.add(strfacility_emicode);
					arrValues.add(strfacility_nonemicode);
					arrValues.add(strfacility_eicode);
					arrValues.add(strfacility_noneicode);
					arrValues.add(strfacility_lumpsum);
					arrValues.add(strsel_purposeofloan);
					arrValues.add(strfacility_module);
					arrValues.add(stragr_scheme);
					arrValues.add(strBankScheme);
					arrValues.add(strAgrScheme);
					arrValues.add(strselintrate);	
					arrValues.add(strratingreq);
					arrValues.add(strintrodate);
					arrValues.add(strschemeheadcode);
					arrValues.add(strCashMargin);
					arrValues.add(strRepayType);
					arrValues.add(strIntDefinition);
					arrValues.add(strLoanagainstshare);
					arrValues.add(Helper.correctNull((String)hshValues.get("loan_again_share")));
					arrValues.add(Helper.correctNull((String)hshValues.get("hidInterestType")));
					arrValues.add(strWhetherDigi);
					arrValues.add(strExpiryDate);
					arrValues.add(Helper.correctNull((String)hshValues.get("hidFacDisplayDesc")));
					arrValues.add(Helper.correctNull((String)hshValues.get("sel_forexfac")));
					arrValues.add(strWhetherDigiRating);
					arrValues.add(strpoolrating);
					arrValues.add(correctNull((String)hshValues.get("prd_mintermrest")));
					arrValues.add(correctNull((String)hshValues.get("prd_maxtermrest")));
					arrValues.add(correctNull((String) hshValues.get("txt_holidayrest")));
					arrValues.add(correctNull((String) hshValues.get("sel_CGTMSE")));
					arrValues.add(strfacid);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
							"updateData");
				}
			} else if (strAction.equalsIgnoreCase("Delete")) {
				arrValues = new ArrayList();
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "facility_usedby_delete");
				arrValues = new ArrayList();
				arrValues.add(strfacid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "deletefacprocfee");
				arrValues = new ArrayList();
				arrValues.add(strfacid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "deletefacdocfee");
				arrValues = new ArrayList();
				arrValues.add(strfacid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("3", hshQuery);
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "deletecommisionfee");
				arrValues = new ArrayList();
				arrValues.add(strfacid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("4", hshQuery);
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "delcomsanclimit");
				arrValues = new ArrayList();
				arrValues.add(strfacid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("5", hshQuery);
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "deleteintmaster");
				arrValues = new ArrayList();
				arrValues.add(strfacid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("6", hshQuery);
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "del_otherdetails");
				arrValues = new ArrayList();
				arrValues.add(strfacid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("7", hshQuery);
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "delete_rangedeviation");
				arrValues = new ArrayList();
				arrValues.add(strfacid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("8", hshQuery);
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "delfacdetail");
				arrValues = new ArrayList();
				arrValues.add(strfacid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("9", hshQuery);
				hshQueryValues.put("size", "9");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
			/***
			 * For Audit Trial New Data - By Karthikeyan.S on 10/10/2013
			 */
			//Facility For
			String strFacForDesc="";
			if(strfacility_module.equalsIgnoreCase("c"))
			{
				strFacForDesc="Corporate";
			}
			else if(strfacility_module.equalsIgnoreCase("a"))
			{
				strFacForDesc="Agriculture";
			}
			//Type of Loan
			String strLoanTypeDesc="";
			if(strfacility_loan.equalsIgnoreCase("TL"))
			{
				strLoanTypeDesc="Term Loan";
			}
			else if(strfacility_loan.equalsIgnoreCase("DL"))
			{
				strLoanTypeDesc="Demand Loan";
			}
			else if(strfacility_loan.equalsIgnoreCase("OD"))
			{
				strLoanTypeDesc="Over Draft";
			}
			else if(strfacility_loan.equalsIgnoreCase("CC"))
			{
				strLoanTypeDesc="Cash Credit";
			}
			//Nature Of Facility
			String strFacNatureDesc="";
			if(strfacnature.equalsIgnoreCase("1"))
			{
				strFacNatureDesc="Working Capital";
			}
			else if(strfacnature.equalsIgnoreCase("2"))
			{
				strFacNatureDesc="Term Loan";
			}
			//Type
			String strTypeDesc="";
			if(strfactype.equalsIgnoreCase("F"))
			{
				strTypeDesc="Funded";
			}
			else if(strfactype.equalsIgnoreCase("NF"))
			{
				strTypeDesc="Non Funded";
			}
			//Stop Product to User
			String strPrdStopDesc="";
			if(strfacility_stop.equalsIgnoreCase("0"))
			{
				strPrdStopDesc="No";
			}
			else if(strfacility_stop.equalsIgnoreCase("1"))
			{
				strPrdStopDesc="Yes";
			}
			String strstrCashMarginAudit="",strLoanAgainstShareAudit="";
			if(strCashMargin.equalsIgnoreCase("Y"))
				strstrCashMarginAudit="YES";
			else if(strCashMargin.equalsIgnoreCase("N"))
				strstrCashMarginAudit="No";
			
			if(strLoanagainstshare.equalsIgnoreCase("Y"))
				strLoanAgainstShareAudit="Yes";
			else
				strLoanAgainstShareAudit="No";
			sbAuditTrial.append("~Facility Code=").append(strfaccode)
			.append("~Facility ID=").append(strfacid)
			.append("~Facility For=").append(strFacForDesc)
			.append("~Type of Loan=").append(strLoanTypeDesc)
			.append("~Nature Of Facility=").append(strFacNatureDesc)
			.append("~Head Of the Facility=").append(Helper.correctNull((String)hshValues.get("txtcat_name")))
			.append("~Facility=").append(Helper.correctNull((String)hshValues.get("txt_facility")))
			.append("~Description=").append(strfacdescrip)
			.append("~Scheme Code=").append(strfacility_emicode)
			.append("~Type=").append(strTypeDesc)
			.append("~Agri Scheme=").append(stragr_scheme)
			.append("~Range From=").append(strrangefrom)
			.append("~Range To=").append(strrangeto)
			.append("~Min. Loan Period (in Months)=").append(strcprdminterm)
			.append("~Max. Loan Period (in Months)=").append(strprdmaxterm)
			.append("~Holiday Period=").append(strholiday)
			.append("~Stop Product to User=").append(strPrdStopDesc)
			.append("~Bank Scheme=").append(strBankScheme)
			.append("~100 % Cash Margin=").append(strstrCashMarginAudit)
			.append("~Loan Against Share =").append(strLoanAgainstShareAudit)
			.append("~Facility Display Description =").append(Helper.correctNull((String)hshValues.get("hidFacDisplayDesc")));
			AuditTrial.auditNewLog(hshValues,"101",strfacid,sbAuditTrial.toString(),sbOldAudit.toString());
			/***
			 * End - Audit Trial New Data
			 */
			hshValues.put("fac_id", strfacid);
			hshValues = getData(hshValues);
		} catch (Exception e) {
			throw new EJBException("Error in update_facility " + e.getMessage());
		}
		finally {
			try {
				if (rs != null) {
					rs.close();
				}
				hshQueryValues = null;
				arrValues = null;
				hshQuery = null;
			} catch (Exception cf) {
				throw new EJBException(
						"Error closing in update_trustdetail the connection "
								+ cf.getMessage());
			}
		}
		return hshValues;
	}
	public void updateotherdet(HashMap hshValues)  {
		ResultSet rs = null;
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		String repaytype = Helper.correctNull((String) hshValues.get("repaytype"));
		String fac_id = "";
		fac_id = Helper.correctNull((String) hshValues.get("fac_id1"));
		StringBuilder sbAuditTrial=new StringBuilder();
		StringBuilder sbOldAudit = new StringBuilder();
		String strQuery="";
		try {
			String strAction = correctNull((String) hshValues.get("hidAction"));
			String strDSCR = correctNull((String) hshValues.get("sel_DSCR"));
			String strSubvention = correctNull((String)hshValues.get("sel_subvention"));
			String strLimitNodeType=correctNull((String)hshValues.get("sel_limitnodetype"));
			/***
			 * For Audit Trial Old Data - By Karthikeyan.S on 10/10/2013
			 */
			strQuery = SQLParser.getSqlQuery("sel_otherdetails^" + fac_id);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				//Repayment Type
				String strRepayType=Helper.correctNull((String) rs.getString("com_otherrepay"));
				String strRepayTypeDescOldAudit="";
				if(strRepayType.contains("M"))
				{
					strRepayTypeDescOldAudit="Monthly, ";
				}
				if(strRepayType.contains("Q"))
				{
					strRepayTypeDescOldAudit=strRepayTypeDescOldAudit+"Quarterly, ";
				}
				if(strRepayType.contains("H"))
				{
					strRepayTypeDescOldAudit=strRepayTypeDescOldAudit+"Half-Yearly, ";
				}
				if(strRepayType.contains("Y"))
				{
					strRepayTypeDescOldAudit=strRepayTypeDescOldAudit+"Yearly, ";
				}
				if(strRepayType.contains("L"))
				{
					strRepayTypeDescOldAudit=strRepayTypeDescOldAudit+"Lump-sum, ";
				}
				if(strRepayType.contains("Sup"))
				{
					strRepayTypeDescOldAudit=strRepayTypeDescOldAudit+"Step-up, ";
				}
				if(strRepayType.contains("SDwn"))
				{
					strRepayTypeDescOldAudit=strRepayTypeDescOldAudit+"Step-Down, ";
				}
				if(strRepayType.contains("C"))
				{
					strRepayTypeDescOldAudit=strRepayTypeDescOldAudit+"Customise";
				}
				//Whether DSCR is needed
				String strDSCROldAudit=Helper.correctNull((String) rs.getString("com_DSCR"));
				String strDSCRDescOldAudit="";
				if(strDSCROldAudit.equalsIgnoreCase("Y"))
				{
					strDSCRDescOldAudit="Yes";
				}
				else if(strDSCROldAudit.equalsIgnoreCase("N"))
				{
					strDSCRDescOldAudit="No";
				}
				sbOldAudit.append("~Repayment Type=").append(strRepayTypeDescOldAudit)
				.append("~Whether DSCR is need=").append(strDSCRDescOldAudit);
				//Loan account
				String strLoanAcc=Helper.correctNull((String) rs.getString("COM_LOANACC"));
				String strloanaccvalue="";
				if(strLoanAcc.equalsIgnoreCase("Y"))
				{
					strloanaccvalue="Yes";
				}
				else if(strLoanAcc.equalsIgnoreCase("N"))
				{
					strloanaccvalue="No";
				}
				sbOldAudit.append("~Whether Loan account opening is there=").append(strloanaccvalue);
				
				String strLimitNodeTypeAudit=Helper.correctNull(rs.getString("com_limtnodetype"));
				
				sbOldAudit.append("~Limit Node Type=").append(strLimitNodeTypeAudit);
				
			}
			/***
			 * End - Audit Trial Old Data
			 */
			if (strAction.equalsIgnoreCase("update")) {
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQueryValues = new HashMap();
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "del_otherdetails");
				arrValues.add(fac_id);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_otherdetails");
				arrValues.add(repaytype);
				arrValues.add(strDSCR);
				arrValues.add(fac_id);
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_loanacc")));
				arrValues.add(strSubvention);
				arrValues.add(strLimitNodeType);
				arrValues.add(hshValues.get("prd_HO"));
				arrValues.add(hshValues.get("prd_RO"));
				arrValues.add(hshValues.get("prd_CLPU"));
				arrValues.add(hshValues.get("prd_branch"));
				arrValues.add(hshValues.get("prd_sanc_days"));
				arrValues.add(hshValues.get("prd_revalid_days"));
				arrValues.add(hshValues.get("prd_notavailed_days"));
				arrValues.add(hshValues.get("txt_cgssd"));
				arrValues.add(hshValues.get("sel_gecl"));
				arrValues.add(hshValues.get("txt_lmtogborrower"));
				arrValues.add(hshValues.get("txt_limitnoc"));
				arrValues.add(hshValues.get("txt_limitmlis"));
				arrValues.add(hshValues.get("txt_limitbank"));
				arrValues.add(hshValues.get("txt_lmtogborrowermlis"));
				arrValues.add(hshValues.get("txt_lmtogborrowerbank"));
				arrValues.add(hshValues.get("txt_lmtpropandrecomended"));
				arrValues.add(hshValues.get("txt_lmtogborrowerrest"));
				arrValues.add(hshValues.get("sel_SvanidhiType"));
				
				
				arrValues.add(hshValues.get("txt_lmtogborrowergecl1ext"));
				arrValues.add(hshValues.get("txt_max_eli_fin_gecl1ext"));
				arrValues.add(hshValues.get("txt_eli_fin_gecl1ext"));
				
				arrValues.add(hshValues.get("txt_max_eli_fin_gecl2ext"));
				arrValues.add(hshValues.get("txt_eli_fin_gecl2ext"));
				
				arrValues.add(hshValues.get("txt_max_eli_fin_gecl3ext"));
				arrValues.add(hshValues.get("txt_eli_fin_gecl3ext"));
				
				
				

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
				HashMap hshTemp = new HashMap();
				hshTemp.put("fac_id", hshValues.get("fac_id1"));
				EJBInvoker.executeStateLess("corporatefacility", hshTemp,
						"updateFacilitySaveStatus");
			} else if (strAction.equalsIgnoreCase("Delete")) {
				arrValues = new ArrayList();
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "del_otherdetails");
				arrValues.add(fac_id);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
			/***
			 * For Audit Trial New Data - By Karthikeyan.S on 10/10/2013
			 */
			//Repayment Type
			String strRepayTypeDesc="";
			if(repaytype.contains("M"))
			{
				strRepayTypeDesc="Monthly, ";
			}
			if(repaytype.contains("Q"))
			{
				strRepayTypeDesc=strRepayTypeDesc+"Quarterly, ";
			}
			if(repaytype.contains("H"))
			{
				strRepayTypeDesc=strRepayTypeDesc+"Half-Yearly, ";
			}
			if(repaytype.contains("Y"))
			{
				strRepayTypeDesc=strRepayTypeDesc+"Yearly, ";
			}
			if(repaytype.contains("L"))
			{
				strRepayTypeDesc=strRepayTypeDesc+"Lump-sum, ";
			}
			if(repaytype.contains("Sup"))
			{
				strRepayTypeDesc=strRepayTypeDesc+"Step-up, ";
			}
			if(repaytype.contains("SDwn"))
			{
				strRepayTypeDesc=strRepayTypeDesc+"Step-Down, ";
			}
			if(repaytype.contains("C"))
			{
				strRepayTypeDesc=strRepayTypeDesc+"Customise";
			}
			//Whether DSCR is needed
			String strDSCRDesc="";
			if(strDSCR.equalsIgnoreCase("Y"))
			{
				strDSCRDesc="Yes";
			}
			else if(strDSCR.equalsIgnoreCase("N"))
			{
				strDSCRDesc="No";
			}
			sbAuditTrial.append("~Repayment Type=").append(strRepayTypeDesc)
			.append("~Whether DSCR is need=").append(strDSCRDesc);
			
			//Loan account
			String strLoanAccnew=Helper.correctNull((String) hshValues.get("sel_loanacc"));
			String strloanaccvaluenew="";
			if(strLoanAccnew.equalsIgnoreCase("Y"))
			{
				strloanaccvaluenew="Yes";
			}
			else if(strLoanAccnew.equalsIgnoreCase("N"))
			{
				strloanaccvaluenew="No";
			}
			sbAuditTrial.append("~Whether Loan account opening is there=").append(strloanaccvaluenew);
			/***
			 * End - Audit Trial New Data
			 */
			AuditTrial.auditNewLog(hshValues,"105",fac_id,sbAuditTrial.toString(),sbOldAudit.toString());
		} catch (Exception e) {
			throw new EJBException("Error in updateotherdet " + e.getMessage());
		}
		finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException(
						"Error closing in updateotherdet the connection "
								+ cf.getMessage());
			}
		}
	}
	public HashMap getDataotherdet(HashMap hshValues)  {
		ResultSet rs = null;
		String strQuery = "";
		HashMap hshRecord = new HashMap();
		String fac_id = "",fac_module="";
		fac_id = Helper.correctNull((String) hshValues.get("fac_id1"));
		fac_module = Helper.correctNull((String) hshValues.get("fac_module"));
		try {
			if(fac_id.equalsIgnoreCase(""))
			{
				fac_id = Helper.correctNull((String) hshValues.get("fac_id"));
			}
			strQuery = SQLParser.getSqlQuery("sel_otherdetails^" + fac_id);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("com_otherrepay", correctNull(rs.getString("com_otherrepay")));
				hshRecord.put("com_DSCR", correctNull(rs.getString("com_DSCR")));
				hshRecord.put("COM_LOANACC", correctNull(rs.getString("COM_LOANACC")));
				hshRecord.put("com_subvention", correctNull(rs.getString("com_subvention")));
				hshRecord.put("com_limtnodetype",correctNull(rs.getString("com_limtnodetype")));
				hshRecord.put("COM_HO_POWER", rs.getString("COM_HO_POWER"));
				hshRecord.put("COM_RO_POWER", rs.getString("COM_RO_POWER"));
				hshRecord.put("COM_CLPU_POWER", rs.getString("COM_CLPU_POWER"));
				hshRecord.put("COM_BRANCH_POWER", rs.getString("COM_BRANCH_POWER"));
				hshRecord.put("COM_SANC_DAYS", correctNull((String)rs.getString("COM_SANC_DAYS")));
				hshRecord.put("COM_REVALID_DAYS", correctNull((String)rs.getString("COM_REVALID_DAYS")));
				hshRecord.put("COM_NOTAVAILED_DAYS", correctNull((String)rs.getString("COM_NOTAVAILED_DAYS"))); 
				hshRecord.put("COM_CGSSDPERC", correctNull((String)rs.getString("COM_CGSSDPERC")));
				hshRecord.put("COM_GECLTYPE", rs.getString("COM_GECLTYPE"));
				hshRecord.put("COM_GECL1_MAXLIMITBORRO", correctNull((String)rs.getString("COM_GECL1_MAXLIMITBORRO")));
				hshRecord.put("COM_GECL1_MAXLIMITNOC", correctNull((String)rs.getString("COM_GECL1_MAXLIMITNOC")));
				hshRecord.put("COM_GECL2_ELGLIMITMLIS", correctNull((String)rs.getString("COM_GECL2_ELGLIMITMLIS"))); 
				hshRecord.put("COM_GECL2_ELIGLIMITBANK", correctNull((String)rs.getString("COM_GECL2_ELIGLIMITBANK")));
				hshRecord.put("COM_GECL3_MAXLIMITBORROMLIS", correctNull((String)rs.getString("COM_GECL3_MAXLIMITBORROMLIS"))); 
				hshRecord.put("COM_GECL3_MAXLIMITBANK", correctNull((String)rs.getString("COM_GECL3_MAXLIMITBANK")));
				hshRecord.put("COM_GECL4_LIMITPROPOSED", correctNull((String)rs.getString("COM_GECL4_LIMITPROPOSED")));
				hshRecord.put("COM_BAL_OUTSTANDING", correctNull((String)rs.getString("COM_BAL_OUTSTANDING")));
				hshRecord.put("COM_SVANIDHITYPE", correctNull((String)rs.getString("COM_SVANIDHITYPE")));
				
				hshRecord.put("COM_GECL1EXT_MAXLIMITBORRO", correctNull((String)rs.getString("COM_GECL1EXT_MAXLIMITBORRO")));
				hshRecord.put("COM_GECL1EXT_MAXELGFINANCE", correctNull((String)rs.getString("COM_GECL1EXT_MAXELGFINANCE")));
				hshRecord.put("COM_GECL1EXT_ELGFINANCE", correctNull((String)rs.getString("COM_GECL1EXT_ELGFINANCE")));
				
				
				hshRecord.put("COM_GECL2EXT_MAXELGFINANCE", correctNull((String)rs.getString("COM_GECL2EXT_MAXELGFINANCE")));
				hshRecord.put("COM_GECL2EXT_ELGFINANCE", correctNull((String)rs.getString("COM_GECL2EXT_ELGFINANCE")));
				
				
				hshRecord.put("COM_GECL3EXT_MAXELGFINANCE", correctNull((String)rs.getString("COM_GECL3EXT_MAXELGFINANCE")));
				hshRecord.put("COM_GECL3EXT_ELGFINANCE", correctNull((String)rs.getString("COM_GECL3EXT_ELGFINANCE")));
				
				
			}
			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_FacilityCorpDesc^" + fac_id+"^"+fac_module);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("schemetype", correctNull((String) rs.getString("com_agrschemetype")));
			}
			String strbankschemeflag="N";
			strQuery = SQLParser.getSqlQuery("sel_bankscheme^" + fac_id+"^"+fac_module);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				strbankschemeflag="Y";
			}
			String strbankschemegeclflag="N";
			strQuery = SQLParser.getSqlQuery("sel_bankschemegecl^" + fac_id+"^"+fac_module);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				strbankschemegeclflag="Y";
			}
			hshRecord.put("strbankschemeflag",strbankschemeflag);
			hshRecord.put("strbankschemegeclflag",strbankschemegeclflag);
			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_FacilitySvanidhi^" + fac_id);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("COM_BANKSCHEME", correctNull((String) rs.getString("COM_BANKSCHEME")));
			}

		}
		catch (Exception e) {
			throw new EJBException(e.getMessage());
		}
		finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e1) {
				throw new EJBException("Error closing connection.." + e1);
			}
		}
		return hshRecord;
	}
	public void update_securitytype(HashMap hshValues)  {
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		ArrayList arrValues;
		ResultSet rs = null;
		String strAction = "";
		String fac_id = "";
		fac_id = Helper.correctNull((String) hshValues.get("fac_id1"));
		try {
			String[] strprimary = null;
			String[] strcollateral = null;
			int intUpdatesize = 0;
			intUpdatesize = intUpdatesize + 1;
			strAction = correctNull((String) hshValues.get("hidAction"));
			if (hshValues.get("txt_primary") instanceof java.lang.String) {
				strprimary = new String[1];
				strprimary[0] = (String) hshValues.get("txt_primary");
			} else {
				strprimary = (String[]) hshValues.get("txt_primary");
			}
			if (hshValues.get("txt_collateral") instanceof java.lang.String) {
				strcollateral = new String[1];
				strcollateral[0] = (String) hshValues.get("txt_collateral");
			} else {
				strcollateral = (String[]) hshValues.get("txt_collateral");
			}
			int len = strprimary.length;
			if (strAction.equals("update")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "del_com_security");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
				for (int k = 0; k < len; k++) {
					hshQuery.put("strQueryId", "ins_com_security");
					arrValues = new ArrayList();
					arrValues.add("17");
					arrValues.add(strprimary[k]);
					arrValues.add(strcollateral[k]);
					arrValues.add(fac_id);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
							"updateData");
				}
				HashMap hshTemp = new HashMap();
				hshTemp.put("fac_id", hshValues.get("fac_id1"));
				EJBInvoker.executeStateLess("corporatefacility", hshTemp,
						"updateFacilitySaveStatus");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e1) {
				throw new EJBException(e1.getMessage());
			}
		}
	}
	public HashMap getdatasecuritytype(HashMap hshValues)  {
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();
		ArrayList vecRec1 = new ArrayList();
		ArrayList vecData2 = new ArrayList();
		ArrayList vecRec2 = new ArrayList();
		ArrayList vecData3 = new ArrayList();
		String strAction = "";
		String strappno = "";
		int vecsize = 0;
		int vecsize1 = 0;
		int vecsize3 = 0;
		String fac_id = "";
		fac_id = Helper.correctNull((String) hshValues.get("fac_id1"));
		try {
			if(fac_id.equalsIgnoreCase(""))
			{
				fac_id = Helper.correctNull((String) hshValues.get("fac_id"));
			}
			strAction = "select";
			rs = DBUtils.executeLAPSQuery("selstaticdatanewcorporate^" + "17");
			vecData = new ArrayList();
			vecRec2 = new ArrayList();
			vecData2 = new ArrayList();
			while (rs.next()) {
				vecRec1 = new ArrayList();
				vecRec1.add(correctNull(rs
						.getString("STAT_DATA_CORPORATE_DESC")));
				vecRec1.add(correctNull(rs
						.getString("STAT_DATA_CORPORATE_DESC1")));
				vecData.add(vecRec1);
			}
			vecsize1 = vecData.size();
			if (strAction.equals("select")) {
				rs1 = DBUtils.executeLAPSQuery("selcom_security^" + fac_id);
				while (rs1.next()) {
					if (correctNull(rs1.getString("securitypri_type"))
							.equalsIgnoreCase("17")) {
						vecRec2 = new ArrayList();
						vecRec2.add(correctNull(rs1
								.getString("securitypri_primary")));
						vecRec2.add(correctNull(rs1
								.getString("securitypri_collateral")));
						vecData2.add(vecRec2);
					}
				}
			}
			vecsize = vecData2.size();
			if (vecsize1 != vecsize) {
				int i = vecsize1 - vecsize;
				for (int l = 1; l <= i; l++) {
					vecRec2 = new ArrayList();
					vecRec2.add("");
					vecRec2.add("");
					vecRec2.add("");
					vecData2.add(vecRec2);
				}
				vecsize = vecData2.size();
			}
			String str = Integer.toString(vecsize);
			hshRecord.put("vecData2", vecData2);
			hshRecord.put("vecData", vecData);
			hshRecord.put("str", str);
		} catch (Exception e) {
			throw new EJBException(e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (rs1 != null) {
					rs1.close();
				}
				vecData = null;
				vecRec1 = null;
				vecData2 = null;
				vecRec2 = null;
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return hshRecord;
	}
	public HashMap getAssesAmountRange(HashMap hshRequestValues)
			 {
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();
		String strIndType = Helper.correctNull((String) hshRequestValues
				.get("indtype"));
		String fac_id = Helper.correctNull((String) hshRequestValues
				.get("fac_id1"));
		String amountrange = Helper.correctNull((String) hshRequestValues
				.get("amountrange"));
		try {
			hshRecord = new HashMap();
			rs = DBUtils.executeLAPSQuery("setfacasses_amountrange^"
					+ strIndType + "^" + fac_id);
			while (rs.next()) {
				vecCol = new ArrayList();
				for (int i = 0; i < 3; i++) {
					vecCol.add(rs.getString(i + 1));
				}
				vecRow.add(vecCol);
			}
			hshRecord.put("vecRow", vecRow);
			hshRecord.put("amountrange", amountrange);
		} catch (Exception e) {
			throw new EJBException(e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e1) {
				throw new EJBException(e1.getMessage());
			}
		}
		return hshRecord;
	}
	public void updateAssesment(HashMap hshValues)  {
		ResultSet rs = null;
		String strQuery = null;
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		ArrayList arrValues;
		String strAppno = "";
		try {
			String seltermid[] = null;
			if (hshValues.get("seltermid") instanceof java.lang.String) {
				seltermid = new String[1];
				seltermid[0] = (String) hshValues.get("seltermid");
			} else {
				seltermid = (String[]) hshValues.get("seltermid");
			}
			int len = seltermid.length;
			int k = 0;
			strAppno = correctNull((String) hshValues.get("appno"));
			rs = DBUtils.executeLAPSQuery("selfacilitylist^" + strAppno + "^"
					+ strAppno + "^" + "0");
			while (rs.next()) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(seltermid[k]);
				arrValues.add(correctNull(rs.getString("facility_headid")));
				arrValues.add(correctNull(rs.getString("facility_id")));
				arrValues.add(strAppno);
				hshQuery.put("strQueryId", "upd_facility_assessment");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
				k++;
			}
		} catch (Exception e) {
			throw new EJBException("Error in update " + e.getMessage());
		}
		finally {
			try {
				if (rs != null) {
					rs.close();
				}
				hshQueryValues = null;
				hshQuery = null;
			} catch (Exception cf) {
				throw new EJBException(
						"Error closing in update the connection "
								+ cf.getMessage());
			}
		}
	}
	public HashMap getassessment(HashMap hshValues)  {
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecVal = null;
		ArrayList vecData = new ArrayList();
		ArrayList vecVal1 = null;
		ArrayList vecData1 = new ArrayList();
		String strAppno = "";
		try {
			strAppno = correctNull((String) hshValues.get("appno"));
			rs = DBUtils.executeLAPSQuery("selfacilitylist^" + strAppno + "^"
					+ strAppno + "^" + "0");
			while (rs.next()) {
				vecVal = new ArrayList();
				vecVal.add(correctNull(rs.getString("facility_headid")));
				vecVal.add(correctNull(rs.getString("facheaddesc")));
				vecVal.add(correctNull(rs.getString("facility_id")));
				vecVal.add(correctNull(rs.getString("facdesc")));
				vecVal.add(correctNull(rs.getString("facility_headid")));
				vecVal.add(correctNull(rs
						.getString("facility_assessmenttype")));
				vecData.add(vecVal);
			}
			hshRecord.put("vecData", vecData);
			hshRecord.put("vecData1", vecData1);
		} catch (Exception e) {
			throw new EJBException(e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (rs1 != null) {
					rs1.close();
				}
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return hshRecord;
	}
	public HashMap getAssesmentData(HashMap hsh)  {
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshValues = null;
		String industrytype = "";
		String range_id = "";
		String fac_id = "";
		try {
			hshValues = new HashMap();
			fac_id = Helper.correctNull((String) hsh.get("fac_id1"));
			industrytype = correctNull((String) hsh.get("hidindtype"));
			range_id = correctNull((String) hsh.get("hiddesc"));
			strQuery = SQLParser.getSqlQuery("setfacasses_select^"
					+ industrytype + "^" + fac_id + "^" + range_id);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshValues.put("INDUSTRYTYPE", Helper.correctNull(rs
						.getString("ASSES_INDUSTRYTYPE")));
				hshValues.put("FACILITYCODE", Helper.correctNull(rs
						.getString("ASSES_FACILITYCODE")));
				hshValues.put("PROCESS_ID", Helper.correctNull(rs
						.getString("ASSES_ID")));
				hshValues.put("PROCESS_RANGEFROM", Helper.correctDouble(rs
						.getString("ASSES_RANGEFROM")));
				hshValues.put("PROCESS_RANGETO", Helper.correctDouble(rs
						.getString("ASSES_RANGETO")));
				hshValues.put("ASSES_TYPE", Helper.correctDouble(rs
						.getString("ASSES_TYPE")));
			}
		}
		catch (Exception e) {
			throw new EJBException(
					"in corporatefacilityBean bean - getProcessingFee method"
							+ e.toString());
		}
		finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e1) {
				throw new EJBException("error occured" + e1.toString());
			}
		}
		return hshValues;
	}
	public HashMap updateAssesmentData(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = new ArrayList();
		String strAction = (String) hshValues.get("hidAction");
		String strindustrytype = null;
		String strProcessID = null;
		String strrangefrom = "", strrangeto = "";
		String strExp = "$";
		String strQuery = "";
		ResultSet rs = null;
		String fac_id = "";
		String assestype = Helper.correctNull((String) hshValues
				.get("assestype"));
		try {
			fac_id = Helper.correctNull((String) hshValues.get("fac_id1"));
			if (strAction.equals("insert")) {
				strindustrytype = correctNull((String) hshValues
						.get("hidindtype"));
				strrangefrom = correctNull((String) hshValues
						.get("proc_amtrangfrm"));
				strrangeto = correctNull((String) hshValues
						.get("proc_amtrangto"));
				strQuery = SQLParser.getSqlQuery("setfacilitycheckassessrange^"
						+ fac_id + "^" + strindustrytype + "^" + strrangefrom
						+ "^" + strrangeto);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					if (rs.getInt(1) != 0) {
						strExp = strExp + " Check the existing amount range ";
						throw new Exception(strExp);
					}
				}
				strProcessID = (String) getMaxAssesID(strindustrytype, fac_id);
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshValues.put("hidId", "strtermId");
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "setfacasses_insert");
				arrValues.add(fac_id);
				arrValues.add(strindustrytype);
				arrValues.add(strProcessID);
				arrValues.add(strrangefrom);
				arrValues.add(strrangeto);
				arrValues.add(assestype);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
				HashMap hshTemp = new HashMap();
				hshTemp.put("fac_id", hshValues.get("fac_id1"));
				EJBInvoker.executeStateLess("corporatefacility", hshTemp,
						"updateFacilitySaveStatus");
			}
			else if (strAction.equals("update")) {
				strProcessID = correctNull((String) hshValues.get("hiddesc"));
				strindustrytype = correctNull((String) hshValues
						.get("hidindtype"));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "setfacasses_update");
				arrValues.add(correctNull((String) hshValues
						.get("proc_amtrangfrm")));
				arrValues.add(correctNull((String) hshValues
						.get("proc_amtrangto")));
				arrValues.add(assestype);
				arrValues.add(strindustrytype);
				arrValues.add(fac_id);
				arrValues.add(strProcessID);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			} else if (strAction.equals("delete")) {
				strProcessID = correctNull((String) hshValues.get("hiddesc"));
				strindustrytype = correctNull((String) hshValues.get("hidindtype"));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "setfacility_assesment_delete");
				arrValues.add(strindustrytype);
				arrValues.add(fac_id);
				arrValues.add(strProcessID);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
		} catch (Exception ce) {
			throw new EJBException(ce.toString());
		} finally {
			hshQueryValues = null;
			hshQuery = null;
			arrValues = null;
		}
		return hshValues;
	}
	private String getMaxAssesID(String strIndustryType, String strFacilityid)
			 {
		String strQuery = "";
		ResultSet rs = null;
		String termId = "";
		try {
			strQuery = SQLParser.getSqlQuery("setfacasses_maxassesid^"
					+ strIndustryType + "^" + strFacilityid);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				termId = rs.getString(1);
			}
			rs.close();
		} catch (Exception ce) {
			log.error(ce.toString());
			throw new EJBException("Error in getMaxAssID " + ce.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return termId;
	}
	public HashMap getListofPageData(HashMap hsh)  {
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshValues = null;
		String industrytype = "";
		String range_id = "";
		String fac_id = "";
		try {
			hshValues = new HashMap();
			strQuery = SQLParser.getSqlQuery("setlistofpage_select");
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshValues.put("LISTOFPAGE", Helper.correctDouble(rs
						.getString("LISTOFPAGE")));
			}
		}
		catch (Exception e) {
			throw new EJBException(
					"in corporatefacilityBean bean - getProcessingFee method"
							+ e.toString());
		}
		finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e1) {
				throw new EJBException("error occured" + e1.toString());
			}
		}
		return hshValues;
	}
	public HashMap updateListofPageData(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = new ArrayList();
		String strAction = (String) hshValues.get("hidAction");
		String strindustrytype = null;
		String strProcessID = null;
		String strrangefrom = "", strrangeto = "";
		String strExp = "$";
		String strQuery = "";
		ResultSet rs = null;
		String assestype = Helper.correctNull((String) hshValues
				.get("assestype"));
		try {
			if (strAction.equals("insert")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "setlistofpage_delete");
				hshQuery.put("arrValues", new ArrayList());
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshValues.put("hidId", "strtermId");
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "setlistofpage_insert");
				arrValues.add(assestype);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
			else if (strAction.equals("update")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "setlistofpage_update");
				arrValues.add(assestype);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			} else if (strAction.equals("delete")) {
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "setlistofpage_delete");
				hshQuery.put("arrValues", new ArrayList());
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
		} catch (Exception ce) {
			throw new EJBException(ce.toString());
		} finally {
			hshQueryValues = null;
			hshQuery = null;
			arrValues = null;
		}
		return hshValues;
	}
	public void updateFormulaData(HashMap hshValues)  {
		ResultSet rs = null;
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		String strAction = (String) hshValues.get("hidAction");
		try {
			if (strAction.equalsIgnoreCase("insert")) {
				hshQueryValues.put("size", "2");
				hshQuery.put("strQueryId", "set_expformula_del");
				arrValues
						.add(correctNull((String) hshValues.get("choformula")));
				arrValues.add(correctNull((String) hshValues.get("sel_type")));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "set_expfromula_ins");
				arrValues
						.add(correctNull((String) hshValues.get("choformula")));
				arrValues.add(correctNull((String) hshValues.get("sel_type")));
				arrValues
						.add(correctNull((String) hshValues.get("txtformula")));
				arrValues
						.add(correctNull((String) hshValues.get("formuladesc")));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
			}
			if (hshQueryValues != null) {
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
		} catch (Exception e) {
			log.error("in bean" + e);
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
	}
	public HashMap getFormulaData(HashMap hshvalues)  {
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshValues = null;
		String choformula = "";
		String sel_type = "";
		hshValues = new HashMap();
		try {
			choformula = Helper.correctNull((String) hshvalues
					.get("choformula"));
			sel_type = correctNull((String) hshvalues.get("sel_type"));
			strQuery = SQLParser.getSqlQuery("set_expformula_sel^" + choformula
					+ "^" + sel_type);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshValues.put("exp_formulafor", Helper.correctNull(rs
						.getString("exp_formulafor")));
				hshValues.put("exp_formulatype", Helper.correctNull(rs
						.getString("exp_formulatype")));
				hshValues.put("exp_formula", Helper.correctNull(rs
						.getString("exp_formula")));
				hshValues.put("exp_formulaname", Helper.correctNull(rs
						.getString("exp_formulaname")));
			}
			hshValues.put("exp_formulafor", choformula);
			hshValues.put("exp_formulatype", sel_type);
		}
		catch (Exception e) {
			throw new EJBException(
					"in corporatefacilityBean bean - getFormulaData method"
							+ e.toString());
		}
		finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e1) {
				throw new EJBException("error occured" + e1.toString());
			}
		}
		return hshValues;
	}
	public void updatedatafacilitylevel(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = new ArrayList();
		String strAction = (String) hshValues.get("hidAction");
		String strappno = correctNull((String) hshValues.get("appno"));
		String facsno = correctNull((String) hshValues.get("selsno"));
		String facid = correctNull((String) hshValues.get("fac_id1"));
		ResultSet rs = null;
		String strforflag="N";
		String strorglevel = "";
		try {
			if (strAction.equals("update")) {
				int intValue = 0;
				String strQuery = "";
				String[] txt_branchamt = null;
				String[] txt_doamt = null;
				String[] txt_coamt = null;
				String[] txt_roi = null;
				String[] txt_margin = null;
				String[] txt_repay = null;
				String[] txt_facility_sno = null;
				String strRecAmount="",strRecommDone="",strRecommDone1="";
				int intUpdatesize = 0;
				String strOrgCode = (String) hshValues.get("strOrgCode");
				strQuery = SQLParser.getSqlQuery("selorhganisationlevel^"+ strOrgCode);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					strorglevel = Helper.correctNull((String) rs.getString("org_level"));
				}
				if (hshValues.get("txt_facility_sno") instanceof java.lang.String) {
					txt_facility_sno = new String[1];
					txt_facility_sno[0] = (String) hshValues.get("txt_facility_sno");
				} else {
					txt_facility_sno = (String[]) hshValues.get("txt_facility_sno");
				}
				if (hshValues.get("txt_branchamt") instanceof java.lang.String) {
					txt_branchamt = new String[1];
					txt_branchamt[0] = (String) hshValues.get("txt_branchamt");
				} else {
					txt_branchamt = (String[]) hshValues.get("txt_branchamt");
				}
				if (hshValues.get("txt_doamt") instanceof java.lang.String) {
					txt_doamt = new String[1];
					txt_doamt[0] = (String) hshValues.get("txt_doamt");
				} else {
					txt_doamt = (String[]) hshValues.get("txt_doamt");
				}
				if (hshValues.get("txt_coamt") instanceof java.lang.String) {
					txt_coamt = new String[1];
					txt_coamt[0] = (String) hshValues.get("txt_coamt");
				} else {
					txt_coamt = (String[]) hshValues.get("txt_coamt");
				}
				if (hshValues.get("txt_roi") instanceof java.lang.String) {
					txt_roi = new String[1];
					txt_roi[0] = (String) hshValues.get("txt_roi");
				} else {
					txt_roi = (String[]) hshValues.get("txt_roi");
				}
				if (hshValues.get("txt_margin") instanceof java.lang.String) {
					txt_margin = new String[1];
					txt_margin[0] = (String) hshValues.get("txt_margin");
				} else {
					txt_margin = (String[]) hshValues.get("txt_margin");
				}
				if (hshValues.get("txt_repay") instanceof java.lang.String) {
					txt_repay = new String[1];
					txt_repay[0] = (String) hshValues.get("txt_repay");
				} else {
					txt_repay = (String[]) hshValues.get("txt_repay");
				}
				strRecommDone =correctNull((String)hshValues.get("txt_recommdone")); 
				if(strRecommDone.equalsIgnoreCase("") || strRecommDone.equalsIgnoreCase("A"))
				{
					if(strorglevel.equalsIgnoreCase("A"))
						strRecommDone1="A";
					if(strorglevel.equalsIgnoreCase("D"))
						strRecommDone1="D";	
					if(strorglevel.equalsIgnoreCase("R") || strorglevel.equalsIgnoreCase("C"))
						strRecommDone1="C";
				}
				else if(strRecommDone.equalsIgnoreCase("D"))
				{
					if(strorglevel.equalsIgnoreCase("A"))
						strRecommDone1="D";
					if(strorglevel.equalsIgnoreCase("D"))
						strRecommDone1="D";	
					if(strorglevel.equalsIgnoreCase("R") || strorglevel.equalsIgnoreCase("C"))
						strRecommDone1="C";
				}
				else if(strRecommDone.equalsIgnoreCase("C"))
				{
					if(strorglevel.equalsIgnoreCase("A"))
						strRecommDone1="C";
					if(strorglevel.equalsIgnoreCase("D"))
						strRecommDone1="C";
					if(strorglevel.equalsIgnoreCase("R") || strorglevel.equalsIgnoreCase("C"))
						strRecommDone1="C";
				}
				hshQuery = new HashMap();
				arrValues = new ArrayList();
					int len = txt_branchamt.length;
					for (int k = 0; k < len; k++) {
						if ((!txt_branchamt[k].equals(""))
								|| (!txt_doamt[k].equals(""))
								|| (!txt_coamt[k].equals(""))) {
							strforflag="Y";
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							hshQuery.put("strQueryId", "ins_facilitydetail");
							arrValues.add(Helper.correctDouble((String) (txt_branchamt[k])));
							arrValues.add(Helper.correctDouble((String) txt_doamt[k]));
							arrValues.add(Helper.correctDouble((String) txt_coamt[k]));
							arrValues.add(strRecommDone1);
							arrValues.add(strappno);
							arrValues.add(Helper.correctNull((String) txt_facility_sno[k]));
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
							if (strorglevel.equals("C") || strorglevel.equals("R"))
								strRecAmount=Helper.correctDouble((String) (txt_coamt[k]));		
					        else if (strorglevel.equals("D") && (strRecommDone.equalsIgnoreCase("D") || strRecommDone.equalsIgnoreCase("A") || strRecommDone.equalsIgnoreCase("")))
					        	strRecAmount=Helper.correctDouble((String) (txt_doamt[k]));
					        else if (strorglevel.equals("A") && (strRecommDone.equalsIgnoreCase("A") || strRecommDone.equalsIgnoreCase("")))
					        	strRecAmount=Helper.correctDouble((String) (txt_branchamt[k]));
					        else
					        	strRecAmount="";
							if(!strRecAmount.equalsIgnoreCase("0") 
									&& !strRecAmount.equalsIgnoreCase("0.00")
									 && !strRecAmount.equalsIgnoreCase(""))
							{
							intUpdatesize = intUpdatesize + 1;
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							hshQuery.put("strQueryId",
									"updatefacsancinterest");
							arrValues.add(Helper.correctDouble(strRecAmount));
							arrValues.add(strappno);
							arrValues.add(Helper.correctNull((String) txt_facility_sno[k]));
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer
									.toString(intUpdatesize));
							hshQueryValues.put(Integer
									.toString(intUpdatesize), hshQuery);
							}
						}
					}
			}
			if(strforflag.equals("Y"))
			{
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
					"updateData");
			}
			EJBInvoker.executeStateLess("facilities", hshValues,
					"updatefreezeData");
		} catch (Exception ce) {
			throw new EJBException("Error in updatesecurity" + ce.toString());
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
	}
	public HashMap getdatafacilitylevel(HashMap hshValues)  {
		java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		ResultSet rs = null;
		ResultSet rs1 = null;
		String strQuery = "", strQuery1 = "";
		String strappno = "", strpage = "", strBorrowId = "", strBorrowDesc = "";
		ArrayList vecRec = null;
		ArrayList vecFacility = null;
		ArrayList vecFacData = new ArrayList();
		ArrayList vecVal = new ArrayList();
		ArrayList vecData = new ArrayList();
		HashMap hshRecord = new HashMap();
		strappno = Helper.correctNull((String) hshValues.get("appno"));
		strpage = Helper.correctNull((String) hshValues.get("page"));
		String strseldata = Helper.correctNull((String) hshValues
				.get("seltermid"));
		double dblLC = 0.00, dblMargin = 0.00, dblSubExist = 0.00;
		double dblExist = 0.00, dblProposed = 0.00, dblDiff = 0.00, dblTotDiff = 0.00, dblTotExist = 0.00, dblSubProposed = 0.00, dblSubmargin = 0.00;
		hshRecord.put("strseldata", strseldata);
		try {
			String strOrgCode = (String) hshValues.get("strOrgCode");
			strQuery = SQLParser.getSqlQuery("selorhganisationlevel^"
					+ strOrgCode);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("strorglevel", Helper.correctNull((String) rs
						.getString("org_level")));
			}
			int intGroup = 0;
			strQuery = SQLParser.getSqlQuery("selfacilitylist^" + strappno
					+ "^" + strappno + "^" + intGroup);
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			dblExist = 0.00;
			dblProposed = 0.00;
			dblDiff = 0.00;
			double dblPreExist = 0.00, dblPreProposed = 0.00;
			String strExist = "", strProposed = "";
			while (rs.next()) {
				intGroup = rs.getInt("facility_sno");
				vecVal = new ArrayList();
				vecVal.add(correctNull(rs.getString("facility_headid")));//0
				vecVal.add(correctNull(rs.getString("facheaddesc")));//1
				vecVal.add(correctNull(rs.getString("facility_id")));//2
				vecVal.add(correctNull(rs.getString("facdesc")));//3
				vecVal.add(correctNull((String) rs.getString("facility_interest")));//4
				vecVal.add(correctNull((String) rs.getString("facility_margin_deviation")));//5
				vecVal.add(correctNull((String) rs.getString("facility_repay_deviation")));//6
				vecVal.add(correctNull((String) rs.getString("facility_branchrecom")));//7
				vecVal.add(correctNull((String) rs.getString("facility_dorecom")));//8
				vecVal.add(correctNull((String) rs.getString("facility_corecom")));//9
				vecVal.add(correctNull((String) rs.getString("facility_sno")));//10
				vecVal.add(correctNull((String) rs.getString("facility_recomorg")));//11
				vecVal.add(correctNull((String) rs.getString("fac_desc")));//12
				vecData.add(vecVal);
				strBorrowDesc = correctNull(rs.getString("comapp_companyname"));
				if (!strProposed.trim().equals("")) {
					dblLC = dblLC + Double.parseDouble(strProposed);
				}
				strQuery1 = SQLParser.getSqlQuery("selfacilitylist^" + strappno
						+ "^" + strappno + "^" + intGroup);
				if (rs1 != null) {
					rs1.close();
				}
				rs1 = DBUtils.executeQuery(strQuery1);
				while (rs1.next()) {
					vecVal = new ArrayList();
					vecVal.add(correctNull(rs1.getString("facility_headid")));//0
					vecVal.add(correctNull(rs1.getString("facheaddesc")));//1
					vecVal.add(correctNull(rs1.getString("facility_id")));//2
					vecVal.add(correctNull(rs1.getString("facdesc")));//3
					vecVal.add(correctNull((String) rs1.getString("facility_interest")));//4
					vecVal.add(correctNull((String) rs1.getString("facility_margin_deviation")));//5
					vecVal.add(correctNull((String) rs1.getString("facility_repay_deviation")));//6
					vecVal.add(correctNull((String) rs1.getString("facility_branchrecom")));//7
					vecVal.add(correctNull((String) rs1.getString("facility_dorecom")));//8
					vecVal.add(correctNull((String) rs1.getString("facility_corecom")));//9
					vecVal.add(correctNull((String) rs1.getString("facility_sno")));//10
					vecVal.add(correctNull((String) rs1.getString("facility_recomorg")));//11
					vecVal.add(correctNull((String) rs1.getString("fac_desc")));//12
					vecData.add(vecVal);
					strBorrowDesc = correctNull(rs1
							.getString("comapp_companyname"));
				}
			}
			hshRecord.put("vecData", vecData);
		}
		catch (Exception e) {
			throw new EJBException(e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e1) {
				throw new EJBException("Error closing connection.." + e1);
			}
		}
		return hshRecord;
	}
	public HashMap getOtherDetailLend(HashMap hshRequestValues)
			 {
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();
		String strpower = Helper.correctNull((String) hshRequestValues
				.get("powervalue"));
		String strfacilitycode = Helper.correctNull((String) hshRequestValues
				.get("strfacilitycode"));
		String strfac = "", strfac1 = "";
		try {
			if (strpower.equals("0") || strpower.equals("")) {
				strpower = correctNull((String) hshRequestValues
						.get("hidpowerchk"));
			}
			hshRecord = new HashMap();
			if (strpower.equalsIgnoreCase("1")) {
				rs = DBUtils.executeLAPSQuery("sel_facname_warehouse");
				while (rs.next()) {
					vecCol = new ArrayList();
					vecCol
							.add(correctNull(rs
									.getString("facility_code")));
					vecCol.add(correctNull(rs.getString("com_headfac")));
					vecCol.add(correctNull(rs.getString("com_subfac")));
					strfac = correctNull(rs.getString("com_headfac"));
					strfac1 = correctNull(rs.getString("com_subfac"));
					if (!strfac.equalsIgnoreCase("")) {
						rs1 = DBUtils.executeLAPSQuery("selfacilitydesc^"
								+ strfac);
						while (rs1.next()) {
							vecCol.add(correctNull(rs1
									.getString("facility_catdesc")));
						}
					}
					rs1.close();
					if (!strfac1.equalsIgnoreCase("")) {
						rs1 = DBUtils.executeLAPSQuery("selfacilitydesc^"
								+ strfac1);
						while (rs1.next()) {
							vecCol.add(correctNull(rs1
									.getString("facility_catdesc")));
						}
					}
					rs1.close();
					vecRow.add(vecCol);
				}
			}
			if (strpower.equalsIgnoreCase("2")) {
				rs = DBUtils.executeLAPSQuery("sel_facname_book");
				while (rs.next()) {
					vecCol = new ArrayList();
					vecCol
							.add(correctNull(rs
									.getString("facility_code")));
					vecCol.add(correctNull(rs.getString("com_headfac")));
					vecCol.add(correctNull(rs.getString("com_subfac")));
					strfac = correctNull(rs.getString("com_headfac"));
					strfac1 = correctNull(rs.getString("com_subfac"));
					if (!strfac.equalsIgnoreCase("")) {
						rs1 = DBUtils.executeLAPSQuery("selfacilitydesc^"
								+ strfac);
						while (rs1.next()) {
							vecCol.add(correctNull(rs1
									.getString("facility_catdesc")));
						}
					}
					rs1.close();
					if (!strfac1.equalsIgnoreCase("")) {
						rs1 = DBUtils.executeLAPSQuery("selfacilitydesc^"
								+ strfac1);
						while (rs1.next()) {
							vecCol.add(correctNull(rs1
									.getString("facility_catdesc")));
						}
					}
					rs1.close();
					vecRow.add(vecCol);
				}
			}
			if (strpower.equalsIgnoreCase("3")) {
				rs = DBUtils.executeLAPSQuery("sel_facname_dbplc");
				while (rs.next()) {
					vecCol = new ArrayList();
					vecCol
							.add(correctNull(rs
									.getString("facility_code")));
					vecCol.add(correctNull(rs.getString("com_headfac")));
					vecCol.add(correctNull(rs.getString("com_subfac")));
					strfac = correctNull(rs.getString("com_headfac"));
					strfac1 = correctNull(rs.getString("com_subfac"));
					if (!strfac.equalsIgnoreCase("")) {
						rs1 = DBUtils.executeLAPSQuery("selfacilitydesc^"
								+ strfac);
						while (rs1.next()) {
							vecCol.add(correctNull(rs1
									.getString("facility_catdesc")));
						}
					}
					rs1.close();
					if (!strfac1.equalsIgnoreCase("")) {
						rs1 = DBUtils.executeLAPSQuery("selfacilitydesc^"
								+ strfac1);
						while (rs1.next()) {
							vecCol.add(correctNull(rs1
									.getString("facility_catdesc")));
						}
					}
					rs1.close();
					vecRow.add(vecCol);
				}
			}
			if (strpower.equalsIgnoreCase("4")) {
				rs = DBUtils.executeLAPSQuery("sel_facname_cheque");
				while (rs.next()) {
					vecCol = new ArrayList();
					vecCol
							.add(correctNull(rs
									.getString("facility_code")));
					vecCol.add(correctNull(rs.getString("com_headfac")));
					vecCol.add(correctNull(rs.getString("com_subfac")));
					strfac = correctNull(rs.getString("com_headfac"));
					strfac1 = correctNull(rs.getString("com_subfac"));
					if (!strfac.equalsIgnoreCase("")) {
						rs1 = DBUtils.executeLAPSQuery("selfacilitydesc^"
								+ strfac);
						while (rs1.next()) {
							vecCol.add(correctNull(rs1
									.getString("facility_catdesc")));
						}
					}
					rs1.close();
					if (!strfac1.equalsIgnoreCase("")) {
						rs1 = DBUtils.executeLAPSQuery("selfacilitydesc^"
								+ strfac1);
						while (rs1.next()) {
							vecCol.add(correctNull(rs1
									.getString("facility_catdesc")));
						}
					}
					rs1.close();
					vecRow.add(vecCol);
				}
			}
			if (strpower.equalsIgnoreCase("5")) {
				rs = DBUtils.executeLAPSQuery("sel_facname_usance");
				while (rs.next()) {
					vecCol = new ArrayList();
					vecCol
							.add(correctNull(rs
									.getString("facility_code")));
					vecCol.add(correctNull(rs.getString("com_headfac")));
					vecCol.add(correctNull(rs.getString("com_subfac")));
					strfac = correctNull(rs.getString("com_headfac"));
					strfac1 = correctNull(rs.getString("com_subfac"));
					if (!strfac.equalsIgnoreCase("")) {
						rs1 = DBUtils.executeLAPSQuery("selfacilitydesc^"
								+ strfac);
						while (rs1.next()) {
							vecCol.add(correctNull(rs1
									.getString("facility_catdesc")));
						}
					}
					rs1.close();
					if (!strfac1.equalsIgnoreCase("")) {
						rs1 = DBUtils.executeLAPSQuery("selfacilitydesc^"
								+ strfac1);
						while (rs1.next()) {
							vecCol.add(correctNull(rs1
									.getString("facility_catdesc")));
						}
					}
					rs1.close();
					vecRow.add(vecCol);
				}
			}
			if (strpower.equalsIgnoreCase("6")) {
				rs = DBUtils.executeLAPSQuery("sel_facname_others");
				while (rs.next()) {
					vecCol = new ArrayList();
					vecCol
							.add(correctNull(rs
									.getString("facility_code")));
					vecCol.add(correctNull(rs.getString("com_headfac")));
					vecCol.add(correctNull(rs.getString("com_subfac")));
					strfac = correctNull(rs.getString("com_headfac"));
					strfac1 = correctNull(rs.getString("com_subfac"));
					if (!strfac.equalsIgnoreCase("")) {
						rs1 = DBUtils.executeLAPSQuery("selfacilitydesc^"
								+ strfac);
						while (rs1.next()) {
							vecCol.add(correctNull(rs1
									.getString("facility_catdesc")));
						}
					}
					rs1.close();
					if (!strfac1.equalsIgnoreCase("")) {
						rs1 = DBUtils.executeLAPSQuery("selfacilitydesc^"
								+ strfac1);
						while (rs1.next()) {
							vecCol.add(correctNull(rs1
									.getString("facility_catdesc")));
						}
					}
					rs1.close();
					vecRow.add(vecCol);
				}
			}
			hshRecord.put("vecRow", vecRow);
			hshRecord.put("strfacilitycode", strfacilitycode);
		} catch (Exception e) {
			throw new EJBException(e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e1) {
				throw new EJBException(e1.getMessage());
			}
		}
		return hshRecord;
	}
	public HashMap getDataOtherLendingPower(HashMap hshValues)
			 {
		String strQuery = "";
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();
		ArrayList vecData1 = new ArrayList();
		ArrayList vecVal = null;
		String strtypecode = "";
		try {
			String strPrdCode = correctNull((String) hshValues
					.get("hidpowerchk"));
			String strfacilitycode = correctNull((String) hshValues
					.get("hidfacility"));
			if (strtypecode.equalsIgnoreCase("")) {
				if (strPrdCode.equalsIgnoreCase("1")) {
					strtypecode = correctNull((String) hshValues
							.get("hidseltype"));
				} else if (strPrdCode.equalsIgnoreCase("2")) {
					strtypecode = correctNull((String) hshValues
							.get("hidseltype1"));
				} else if (strPrdCode.equalsIgnoreCase("3")) {
					strtypecode = correctNull((String) hshValues
							.get("hidseltype2"));
				} else if (strPrdCode.equalsIgnoreCase("4")) {
					strtypecode = correctNull((String) hshValues
							.get("hidseltype3"));
				}
			}
			String strid = correctNull((String) hshValues.get("hiddesc"));
			if (!strPrdCode.equals("")) {
				strQuery = SQLParser.getSqlQuery("sel_otherlendingpowermaster^"
						+ strfacilitycode + "^" + strPrdCode + "^"
						+ strtypecode);
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) {
					vecVal = new ArrayList();
					String strclass = correctNull(rs.getString("grp_id"));
					String strdesig = correctNull(rs.getString("grp_name"));
					String strsanction = correctNull(rs
							.getString("otherlend_sanctionamount"));
					String strInformalsanction = correctNull(rs
							.getString("otherlend_informalsanamount"));
					hshRecord.put("otherlend_type", correctNull(rs
							.getString("otherlend_type")));
					hshRecord.put("otherlend_facility", correctNull(rs
							.getString("otherlend_facility")));
					hshRecord.put("otherlend_powertype", correctNull(rs
							.getString("otherlend_powertype")));
					vecVal.add(correctNull(strclass));
					vecVal.add(correctNull(strsanction));
					vecVal.add(correctNull(strdesig));
					vecVal.add(correctNull(strInformalsanction));
					vecData.add(vecVal);
				}
				hshRecord.put("vecData", vecData);
			}
			if (vecData.size() == 0) {
				if (rs != null)
					rs.close();
				strQuery = SQLParser.getSqlQuery("selgroupsanctionlimit");
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) {
					vecVal = new ArrayList();
					String strclass = correctNull(rs.getString("grp_id"));
					String strdesig = correctNull(rs.getString("grp_name"));
					vecVal.add(correctNull(strclass));
					vecVal.add(correctNull(strdesig));
					vecData1.add(vecVal);
				}
				hshRecord.put("vecDatagroup", vecData1);
			}
			hshRecord.put("strPrdCode", strPrdCode);
			hshRecord.put("strfacilitycode", strfacilitycode);
			hshRecord.put("strtypecode", strtypecode);
		} catch (Exception ce) {
			throw new EJBException("Error in getData " + ce.toString());
		} finally {
			try {
				if (rs1 != null) {
					rs1.close();
				}
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
	public void updateDataOtherLendingPower(HashMap hshValues)
			 {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = null;
		String strSancclass[] = null;
		String strSanlimit[] = null;
		String strSanDesig[] = null;
		int intUpdatesize = 0;
		String strtypeCode = "";
		int j = 0;
		try {
			String facility_code = correctNull((String) hshValues
					.get("sel_facility"));
			String strPrdCode = correctNull((String) hshValues
					.get("sel_powerchk"));
			String strAction = correctNull((String) hshValues.get("hidAction"));
			if (strtypeCode.equalsIgnoreCase("")) {
				if (strPrdCode.equalsIgnoreCase("1")) {
					strtypeCode = correctNull((String) hshValues
							.get("hidseltype"));
				} else if (strPrdCode.equalsIgnoreCase("2")) {
					strtypeCode = correctNull((String) hshValues
							.get("hidseltype1"));
				} else if (strPrdCode.equalsIgnoreCase("3")) {
					strtypeCode = correctNull((String) hshValues
							.get("hidseltype2"));
				} else if (strPrdCode.equalsIgnoreCase("4")) {
					strtypeCode = correctNull((String) hshValues
							.get("hidseltype3"));
				}
			}
			if (hshValues.get("txtsanc_class") instanceof java.lang.String) {
				strSancclass = new String[1];
				strSancclass[0] = (String) hshValues.get("txtsanc_class");
			} else {
				strSancclass = (String[]) hshValues.get("txtsanc_class");
			}
			if (hshValues.get("txtsanc_limit") instanceof java.lang.String) {
				strSanlimit = new String[1];
				strSanlimit[0] = (String) hshValues.get("txtsanc_limit");
			} else {
				strSanlimit = (String[]) hshValues.get("txtsanc_limit");
			}
			if (hshValues.get("txtsanc_desig") instanceof java.lang.String) {
				strSanDesig = new String[1];
				strSanDesig[0] = (String) hshValues.get("txtsanc_desig");
			} else {
				strSanDesig = (String[]) hshValues.get("txtsanc_desig");
			}
			if (!strAction.equalsIgnoreCase("delete")) {
				arrValues = new ArrayList();
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "deleteotherlendingpower");
				arrValues.add(strPrdCode);
				arrValues.add(facility_code);
				arrValues.add(strtypeCode);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				for (int i = 0; i < strSancclass.length; i++) {
					if (!strSancclass[i].trim().equals("")
							&& strSancclass[i] != null) {
						String strclass = correctNull((String) strSancclass[i]);
						String strlimit = correctNull((String) strSanlimit[i]);
						if (strclass.equals("")) {
							strclass = "0";
						}
						if (strlimit.equals("")) {
							strlimit = "0";
						}
						intUpdatesize = intUpdatesize + 1;
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "insotherlendingpower");
						arrValues.add(strPrdCode);
						arrValues.add(facility_code);
						arrValues.add(strclass);
						arrValues.add(strlimit);
						arrValues.add("0.00");
						arrValues.add(strtypeCode);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("size", Integer
								.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(j + 1), hshQuery);
						EJBInvoker.executeStateLess("dataaccess",
								hshQueryValues, "updateData");
					}
					j++;
				}
			}
			if (strAction.equalsIgnoreCase("delete")) {
				arrValues = new ArrayList();
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "deleteotherlendingpower");
				arrValues.add(strPrdCode);
				arrValues.add(facility_code);
				arrValues.add(strtypeCode);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
		} catch (Exception ce) {
			throw new EJBException("inside update" + ce.toString());
		} finally {
			try {
				hshQueryValues = null;
				hshQuery = null;
				arrValues = null;
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
	}
	public void update_NFBLData(HashMap hshValues)  {
		ResultSet rs = null;
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		String repaytype = Helper.correctNull((String) hshValues
				.get("repaytype"));
		String strappno = "";
		strappno = Helper.correctNull((String) hshValues.get("appno"));
		try {
			String strAction = correctNull((String) hshValues.get("hidAction"));
			String strsel_type = correctNull((String) hshValues.get("sel_type"));
			String strtxt_lcdaCreditPurchase = correctNull((String) hshValues
					.get("txt_lcdaCreditPurchase"));
			String strtxt_lcdaUsance = correctNull((String) hshValues
					.get("txt_lcdaUsance"));
			String strtxt_lcdaLeadtimee = correctNull((String) hshValues
					.get("txt_lcdaLeadtime"));
			String strtxt_lcdaLetterCredit = correctNull((String) hshValues
					.get("txt_lcdaLetterCredit"));
			String strtxt_lcBPCreditPurchase = correctNull((String) hshValues
					.get("txt_lcBPCreditPurchase"));
			String strtxt_lcBPLeadTime = correctNull((String) hshValues
					.get("txt_lcBPLeadTime"));
			String strtxt_lcBPLetterCredit = correctNull((String) hshValues
					.get("txt_lcBPLetterCredit"));
			String strtxt_BGcreditPurchase = correctNull((String) hshValues
					.get("txt_BGcreditPurchase"));
			String strtxt_BGUsanceperiod = correctNull((String) hshValues
					.get("txt_BGUsanceperiod"));
			String strtxt_BGLeadTime = correctNull((String) hshValues
					.get("txt_BGLeadTime"));
			String strtxt_BGRequirement = correctNull((String) hshValues
					.get("txt_BGRequirement"));
			if (strAction.equalsIgnoreCase("update")) {
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQueryValues = new HashMap();
				arrValues.add(strappno);
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "com_del_assNFBL");
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "com_ins_assNFBL");
				arrValues.add(strappno);
				arrValues.add(strsel_type);
				arrValues.add(strtxt_lcdaCreditPurchase);
				arrValues.add(strtxt_lcdaUsance);
				arrValues.add(strtxt_lcdaLeadtimee);
				arrValues.add(strtxt_lcdaLetterCredit);
				arrValues.add(strtxt_lcBPCreditPurchase);
				arrValues.add(strtxt_lcBPLeadTime);
				arrValues.add(strtxt_lcBPLetterCredit);
				arrValues.add(strtxt_BGcreditPurchase);
				arrValues.add(strtxt_BGUsanceperiod);
				arrValues.add(strtxt_BGLeadTime);
				arrValues.add(strtxt_BGRequirement);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			} else if (strAction.equalsIgnoreCase("delete")) {
				arrValues = new ArrayList();
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				arrValues.add(strappno);
				hshQuery.put("strQueryId", "com_del_assNFBL");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
		} catch (Exception e) {
			throw new EJBException("Error in update_NFBLData " + e.getMessage());
		}
		finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException(
						"Error closing in updateotherdet the connection "
								+ cf.getMessage());
			}
		}
	}
	public HashMap get_NFBLData(HashMap hshValues)  {
		ResultSet rs = null;
		String strQuery = "";
		HashMap hshRecord = new HashMap();
		String strappno = "";
		strappno = Helper.correctNull((String) hshValues.get("appno"));
		try {
			strQuery = SQLParser.getSqlQuery("com_sel_assNFBL^" + strappno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("ass_sel_type", correctNull((String) rs
						.getString("ass_sel_type")));
				hshRecord.put("ass_lcdaCreditPurchase", correctNull((String) rs
						.getString("ass_lcdaCreditPurchase")));
				hshRecord.put("ass_lcdaUsance", correctNull((String) rs
						.getString("ass_lcdaUsance")));
				hshRecord.put("ass_lcdaLeadtime", correctNull((String) rs
						.getString("ass_lcdaLeadtime")));
				hshRecord.put("ass_lcdaLetterCredit", correctNull((String) rs
						.getString("ass_lcdaLetterCredit")));
				hshRecord.put("ass_lcBPCreditPurchase", correctNull((String) rs
						.getString("ass_lcBPCreditPurchase")));
				hshRecord.put("ass_lcBPLeadTime", correctNull((String) rs
						.getString("ass_lcBPLeadTime")));
				hshRecord.put("ass_lcBPLetterCredit", correctNull((String) rs
						.getString("ass_lcBPLetterCredit")));
				hshRecord.put("ass_BGcreditPurchase", correctNull((String) rs
						.getString("ass_BGcreditPurchase")));
				hshRecord.put("ass_BGUsanceperiod", correctNull((String) rs
						.getString("ass_BGUsanceperiod")));
				hshRecord.put("ass_BGLeadTime", correctNull((String) rs
						.getString("ass_BGLeadTime")));
				hshRecord.put("ass_BGRequirement", correctNull((String) rs
						.getString("ass_BGRequirement")));
			}
		}
		catch (Exception e) {
			throw new EJBException(e.getMessage());
		}
		finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e1) {
				throw new EJBException("Error closing connection.." + e1);
			}
		}
		return hshRecord;
	}
	public HashMap getcommissionFee(HashMap hsh)  {
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshValues = null;
		String industrytype = "";
		String fac_id = Helper.correctNull((String) hsh.get("fac_id1"));
		String range_id = "";
		try {
			hshValues = new HashMap();
			industrytype = correctNull((String) hsh.get("hidindtype"));
			range_id = correctNull((String) hsh.get("hiddesc"));
			strQuery = SQLParser.getSqlQuery("com_selcommissionfee^"
					+ fac_id + "^" + range_id);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshValues.put("INDUSTRYTYPE", Helper.correctNull(rs
						.getString("PROCESS_INDUSTRYTYPE")));
				hshValues.put("FACILITYCODE", Helper.correctNull(rs
						.getString("PROCESS_FACILITYCODE")));
				hshValues.put("PROCESS_ID", Helper.correctNull(rs
						.getString("PROCESS_ID")));
				hshValues.put("PROCESS_RANGEFROM", Helper.correctDouble(rs
						.getString("PROCESS_RANGEFROM")));
				hshValues.put("PROCESS_RANGETO", Helper.correctDouble(rs
						.getString("PROCESS_RANGETO")));
				hshValues.put("COM_FRESHFEE", Helper.correctNull(rs
						.getString("COM_FRESHFEE")));
				hshValues.put("COM_RENEWALFEE", Helper.correctNull(rs
						.getString("COM_RENEWALFEE")));
				hshValues.put("COM_AMOUNT", Helper.correctDouble(rs
						.getString("COM_AMOUNT")));
				hshValues.put("PROCESS_MARGINFROM", Helper.correctDouble(rs
						.getString("PROCESS_MARGINFROM")));
				hshValues.put("PROCESS_MARGINTO", Helper.correctDouble(rs
						.getString("PROCESS_MARGINTO")));
			}
			hsh = null;
		}
		catch (Exception e) {
			throw new EJBException(
					"in corporatefacilityBean bean - getcommissionFee method"
							+ e.toString());
		}
		finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e1) {
				throw new EJBException("error occured" + e1.toString());
			}
		}
		return hshValues;
	}
	public void updatecommissionData(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = new ArrayList();
		String strAction = (String) hshValues.get("hidAction");
		String fac_id = Helper.correctNull((String) hshValues.get("fac_id1"));
		String strindustrytype = null;
		String strProcessID = null;
		String strrangefrom = "", strrangeto = "";
		String strExp = "$";
		String strQuery = "";
		ResultSet rs = null;
		try {
			if (strAction.equals("insert")) {
				strindustrytype = correctNull((String) hshValues
						.get("hidindtype"));
				strrangefrom = correctNull((String) hshValues
						.get("proc_amtrangfrm"));
				strrangeto = Helper.correctDouble((String) hshValues
						.get("proc_amtrangto"));
				strQuery = SQLParser.getSqlQuery("setfacilitycommissionrange^"
						+ fac_id + "^" + strrangefrom
						+ "^" + strrangeto);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					if (rs.getInt(1) != 0) {
						strExp = strExp + " Check the existing amount range ";
						throw new Exception(strExp);
					}
				}
				strProcessID = (String) getMaxcommissionID(strindustrytype,
						fac_id);
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshValues.put("hidId", "strtermId");
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_setfacilitycommissionfee");
				arrValues.add(fac_id);//PROCESS_facilityCODE BI
				arrValues.add(strProcessID);//PROCESS_ID BI
				arrValues.add(strrangefrom);//PROCESS_RANGEFROM BI
				arrValues.add(strrangeto);//PROCESS_RANGETO DEC
				if((Helper.correctNull((String) hshValues.get("com_freshfee"))).equals(""))
				{
					arrValues.add("0.00");
				}
				else
				{
				arrValues.add(Helper.correctNull((String) hshValues.get("com_freshfee")));//COM_FRESHFEE DEC
				}
				if((Helper.correctNull((String) hshValues.get("com_renewfee"))).equals(""))
				{
					arrValues.add("0.00");
				}
				else
				{
				arrValues.add(Helper.correctNull((String) hshValues.get("com_renewfee")));//COM_RENEWALFEE DEC
				}
				arrValues
						.add(Helper.correctDouble((String) hshValues.get("com_amount")));//COM_AMOUNT DEC
				arrValues.add(Helper.correctDouble((String) hshValues
						.get("proc_marginfrom")));//PROCESS_MARGINFROM DEC
				arrValues.add(Helper.correctDouble((String) hshValues
						.get("proc_marginto")));//PROCESS_MARGINTO DEC
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
				HashMap hshTemp = new HashMap();
				hshTemp.put("fac_id", hshValues.get("fac_id1"));
				EJBInvoker.executeStateLess("corporatefacility", hshTemp,
						"updateFacilitySaveStatus");
			}
			else if (strAction.equals("update")) {
				strProcessID = correctNull((String) hshValues.get("hiddesc"));
				strindustrytype = correctNull((String) hshValues
						.get("hidindtype"));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "update_setfacilitycommissionfee");
				arrValues.add(correctNull((String) hshValues
						.get("proc_amtrangfrm")));
				arrValues.add(Helper.correctDouble((String) hshValues
						.get("proc_amtrangto")));
				if((Helper.correctNull((String) hshValues.get("com_freshfee"))).equals(""))
				{
					arrValues.add("0.00");
				}
				else
				{
				arrValues.add(Helper.correctNull((String) hshValues.get("com_freshfee")));//COM_FRESHFEE DEC
				}
				if((Helper.correctNull((String) hshValues.get("com_renewfee"))).equals(""))
				{
					arrValues.add("0.00");
				}
				else
				{
				arrValues.add(Helper.correctNull((String) hshValues.get("com_renewfee")));//COM_RENEWALFEE DEC
				}
				arrValues
						.add(Helper.correctDouble((String) hshValues.get("com_amount")));
				arrValues.add(Helper.correctDouble((String) hshValues
						.get("proc_marginfrom")));
				arrValues.add(Helper.correctDouble((String) hshValues
						.get("proc_marginto")));
				arrValues.add(fac_id);
				arrValues.add(strProcessID);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			} else if (strAction.equals("delete")) {
				strProcessID = correctNull((String) hshValues.get("hiddesc"));
				strindustrytype = correctNull((String) hshValues
						.get("hidindtype"));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "del_setfacilitycommissionfee");
				arrValues.add(fac_id);
				arrValues.add(strProcessID);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
		} catch (Exception ce) {
			throw new EJBException(ce.toString());
		} finally {
			hshQueryValues = null;
			hshQuery = null;
			arrValues = null;
		}
	}
	private String getMaxcommissionID(String strIndustryType,
			String strFacilityid)  {
		String strQuery = "";
		ResultSet rs = null;
		String termId = "";
		try {
			strQuery = SQLParser.getSqlQuery("setcommission_maxprocessid^"+ strFacilityid);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				termId = rs.getString(1);
			}
			rs.close();
		} catch (Exception ce) {
			log.error(ce.toString());
			throw new EJBException("Error in getMaxProcessFeeID "
					+ ce.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return termId;
	}
	public HashMap getAmountcommissionRange(HashMap hshRequestValues)
			 {
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();
		String strIndType = Helper.correctNull((String) hshRequestValues
				.get("indtype"));
		String fac_id = Helper.correctNull((String) hshRequestValues
				.get("fac_id1"));
		String amountrange = Helper.correctNull((String) hshRequestValues
				.get("amountrange"));
		try {
			hshRecord = new HashMap();
			rs = DBUtils.executeLAPSQuery("com_facility_commissionamountrange^"+ fac_id);
			while (rs.next()) {
				vecCol = new ArrayList();
				for (int i = 0; i < 3; i++) {
					vecCol.add(rs.getString(i + 1));
				}
				vecRow.add(vecCol);
			}
			hshRecord.put("vecRow", vecRow);
			hshRecord.put("amountrange", amountrange);
		} catch (Exception e) {
			throw new EJBException(e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e1) {
				throw new EJBException(e1.getMessage());
			}
		}
		return hshRecord;
	}
	public void updateComFacilityDelegatedPowers(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = null;
		String strSancclass[] = null;
		String strSanlimit[] = null;
		String strSanDesig[] = null;
		String strSancSecurity[] = null;
		String strInformalSanlimit[] = null;
 		int intUpdatesize=0;
		int j=0;
		StringBuilder sbAuditTrial=new StringBuilder();
		StringBuilder sbOldAudit = new StringBuilder();
		ResultSet rs=null;
		String strQuery="";
		try
		{
			String fac_id = Helper.correctNull((String) hshValues.get("fac_id1"));
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
 			if(hshValues.get("txtsanc_security")  instanceof java.lang.String){
 				strSancSecurity=new String[1];
 				strSancSecurity[0]= (String) hshValues.get("txtsanc_security");
 			}else{
 				strSancSecurity=(String[]) hshValues.get("txtsanc_security");
 			}
 			/***
			 * For Audit Trial Old Data - By Karthikeyan.S on 11/10/2013
			 */
 			strQuery=SQLParser.getSqlQuery("com_selgroupname^"+fac_id);
 			rs=DBUtils.executeQuery(strQuery);
 			while(rs.next())
 			{
 				sbOldAudit.append("~User Group =").append(Helper.correctNull((String)rs.getString("grp_name")))
 				.append("~Limit Sanction Powers =").append(Helper.correctDouble((String)rs.getString("sanction_limit")))
 				.append("~Security Sanction Powers =").append(Helper.correctDouble((String)rs.getString("sanction_security")));
 			}
 			if(sbOldAudit.length()<=0)
 			{
 				if(rs!=null)
 				{
 					rs.close();
 				}
 				strQuery=SQLParser.getSqlQuery("selgroupsanctionlimit");
 	 			rs=DBUtils.executeQuery(strQuery);
 	 			while(rs.next())
 	 			{
 	 				sbOldAudit.append("~User Group =").append(Helper.correctNull((String)rs.getString("grp_name")))
 	 				.append("~Limit Sanction Powers =").append(Helper.correctDouble(""))
 	 				.append("~Security Sanction Powers =").append(Helper.correctDouble(""));
 	 			}
 			}
 			
 			/***
			 * End - Audit Trial Old Data
			 */
			intUpdatesize = intUpdatesize+1;
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","delcomsanclimit");
			arrValues.add(correctNull(fac_id));
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
					String strsecurity = correctNull((String)strSancSecurity[i]);
					if(strclass.equals(""))
					{
						strclass="0";
					}
					if(strlimit.equals(""))
					{
						strlimit="0";
					}
					if(strsecurity.equals(""))
					{
						strsecurity="0";
					}
					intUpdatesize = intUpdatesize+1;
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","com_inssanclimit");
					arrValues.add(fac_id);
					arrValues.add(strclass);
					arrValues.add(strlimit);
					arrValues.add(strsecurity);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(j+1),hshQuery);	
					j++;
					/***
					 * For Audit Trial New Data - By Karthikeyan.S on 11/10/2013
					 */
					if(rs!=null)
	 				{
	 					rs.close();
	 				}
					String strGrpName="";
					strQuery=SQLParser.getSqlQuery("setgroupssel_audit^"+strclass);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strGrpName=Helper.correctNull((String)rs.getString("grp_name"));
					}
					sbAuditTrial.append("~User Group =").append(strGrpName)
 	 				.append("~Limit Sanction Powers =").append(strlimit)
 	 				.append("~Security Sanction Powers =").append(strsecurity);
				}
			}
			hshQueryValues.put("size",Integer.toString(intUpdatesize));
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			AuditTrial.auditNewLog(hshValues,"103",fac_id,sbAuditTrial.toString(),sbOldAudit.toString());
			/***
			 * End - Audit Trial New Data
			 */
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
		}
		finally
		{
			try
			{
				if(rs!=null)
 				{
 					rs.close();
 				}
				hshQueryValues = null;
				hshQuery = null;
				arrValues = null;
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
	}
	public  HashMap getComFacilityDelegatedPowers(HashMap hshValues) 
	{
		String strQuery="";
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();
		ArrayList vecData1 = new ArrayList();
		ArrayList vecVal=null;
		try
		{
			String fac_id = Helper.correctNull((String) hshValues.get("fac_id1"));
			if(fac_id.equalsIgnoreCase(""))
			{
				fac_id=Helper.correctNull((String) hshValues.get("fac_id"));
			}
			if (!fac_id.equals(""))
			{
				rs=null;
				strQuery = SQLParser.getSqlQuery("com_selgroupname^"+fac_id);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					vecVal = new ArrayList();
					String strclass = correctNull(rs.getString("grp_id"));
					String strdesig = correctNull(rs.getString("grp_name"));
					String strsanction=correctNull(rs.getString("sanction_limit"));
					String strsecurity=correctNull(rs.getString("sanction_security"));
					vecVal.add(correctNull(strclass));
					vecVal.add(correctNull(strsanction));
					vecVal.add(correctNull(strdesig));	
					vecVal.add(correctNull(strsecurity));	
					vecData.add(vecVal);				
				}
				hshRecord.put("vecData",vecData);
			}
			if(vecData.size()==0)
			{
				rs.close();
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
				vecData = null;
				vecData1 = null;
				vecVal = null;
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}
	public void update_svanidhi(HashMap hshValues)  {
		ResultSet rs = null;
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		String fac_id = "";
		String svanidhi_type = "";
		fac_id = Helper.correctNull((String) hshValues.get("fac_id1"));
		svanidhi_type=Helper.correctNull((String) hshValues.get("com_svanidhi"));
		String min_days=correctNull((String) hshValues.get("svanidhi_mindays"));
		String max_days=correctNull((String) hshValues.get("svanidhi_maxdays"));
		String strQuery="";
		String strExp="$";
		try {
			String strAction = correctNull((String) hshValues.get("hidAction"));
			if (strAction.equalsIgnoreCase("insert")) {
				
				if(rs!=null)
				{
					rs.close();
				}
				
				strQuery=SQLParser.getSqlQuery("svanidhi_checkrange^"+fac_id+"^"+svanidhi_type
							+"^"+min_days+"^"+max_days
							+"^"+min_days+"^"+max_days
							+"^"+min_days+"^"+max_days
							);
				rs=DBUtils.executeQuery(strQuery);
				
				
				if(rs.next())
					{
					if(rs.getInt(1)!=0)
						{
						strExp = strExp + " Check the existing range ";
						throw new Exception(strExp);
						}
					}
				
				
				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_svanidhi_eligibility");
				arrValues.add(getsno());
				arrValues.add(fac_id);
				arrValues.add(svanidhi_type);
				arrValues.add(correctNull((String) hshValues.get("svanidhi_mindays")));
				arrValues.add(correctNull((String) hshValues.get("svanidhi_maxdays")));
				arrValues.add(correctNull((String) hshValues.get("svanidhi_eligible_percentage")));
				
				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");

			} 
			else if (strAction.equalsIgnoreCase("update")) {
				
				arrValues = new ArrayList();
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				arrValues.add(fac_id);
				arrValues.add(svanidhi_type);
				arrValues.add(correctNull((String) hshValues.get("hid_sno")));
				
				hshQuery.put("strQueryId", "del_svanidhi_eligibility");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
				if(rs!=null)
				{
					rs.close();
				}
				
				strQuery=SQLParser.getSqlQuery("svanidhi_checkrange^"+fac_id+"^"+svanidhi_type
							+"^"+min_days+"^"+max_days
							+"^"+min_days+"^"+max_days
							+"^"+min_days+"^"+max_days
							);
				rs=DBUtils.executeQuery(strQuery);
				
				
				if(rs.next())
					{
					if(rs.getInt(1)!=0)
						{
						strExp = strExp + " Check the existing range ";
						throw new Exception(strExp);
						}
					}
				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_svanidhi_eligibility");
				arrValues.add(correctNull((String) hshValues.get("hid_sno")));
				arrValues.add(fac_id);
				arrValues.add(svanidhi_type);
				arrValues.add(correctNull((String) hshValues.get("svanidhi_mindays")));
				arrValues.add(correctNull((String) hshValues.get("svanidhi_maxdays")));
				arrValues.add(correctNull((String) hshValues.get("svanidhi_eligible_percentage")));
				
				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");	
			}
			else if (strAction.equalsIgnoreCase("Delete")) {
				arrValues = new ArrayList();
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				arrValues.add(fac_id);
				arrValues.add(svanidhi_type);
				arrValues.add(correctNull((String) hshValues.get("hid_sno")));
				
				hshQuery.put("strQueryId", "del_svanidhi_eligibility");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
			}
				
		} catch (Exception e) {
			throw new EJBException("Error in upd_svanidhi " + e.getMessage());
		}
		finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException(
						"Error closing in update_svanidhi the connection "
								+ cf.getMessage());
			}
		}
	}
	
		public HashMap get_svanidhi(HashMap hshValues)  {
		ResultSet rs = null;
		String strQuery = "";
		HashMap hshRecord = new HashMap();
		String fac_id = "",fac_module="";
		fac_id = Helper.correctNull((String) hshValues.get("fac_id1"));
		fac_module = Helper.correctNull((String) hshValues.get("fac_module"));
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol= new ArrayList();
		try {
			if(fac_id.equalsIgnoreCase(""))
			{
				fac_id = Helper.correctNull((String) hshValues.get("fac_id"));
			}
			
			strQuery = SQLParser.getSqlQuery("sel_otherdetails^" + fac_id);
			String Svanidhi_type="";
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
					hshRecord.put("COM_SVANIDHITYPE", correctNull((String)rs.getString("COM_SVANIDHITYPE")));
				Svanidhi_type= correctNull((String)rs.getString("COM_SVANIDHITYPE"));			
			}
			
			
			strQuery = SQLParser.getSqlQuery("sel_svanidhi_eligibility^"+fac_id +"^"+Svanidhi_type);
			if (rs != null)
			{
				rs.close();
			}
			
			
				rs=DBUtils.executeQuery(strQuery);
				
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(correctNull((String)rs.getString("SVANIDHI_MINDAYS")));
				arrCol.add(correctNull((String)rs.getString("SVANIDHI_MAXDAYS")));
				arrCol.add(correctNull((String)rs.getString("SVANIDHI_ELIGIBILE_PERCENTAGE")));
				arrCol.add(correctNull((String)rs.getString("SVANIDHI_SNO")));
				arrRow.add(arrCol);
				
			}
			hshRecord.put("arrRowSvanidhi", arrRow);
		}
		catch (Exception e) {
			throw new EJBException(e.getMessage());
		}
		finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e1) {
				throw new EJBException("Error closing connection.." + e1);
			}
		}
		return hshRecord;
	}
		private String getsno() throws Exception {
			String strSno = "";
			ResultSet rs = null;
			try {
				rs = DBUtils.executeLAPSQuery("sel_svanidhi_sno");
				if (rs.next()) {
					strSno = rs.getString("SVANIDHI_SNO");
				}
			} catch (Exception e) {
				System.out.println("exception in getSno.. " + e);
				throw e;
			} finally {
				if (rs != null) {
					rs.close();
				}
			}
			return strSno;
		}


}