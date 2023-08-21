package com.sai.laps.ejb.perborrowersearch;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SAILogger;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "perborrowersearchBean", mappedName = "perborrowersearchHome")
@Remote (perborrowersearchRemote.class)
public class perborrowersearchBean extends BeanAdapter
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(perborrowersearchBean.class);	
	public HashMap getData(HashMap hshRequestValues) 
	{
		ResultSet rs = null;	
		
		HashMap hshRecord = null;
		ArrayList arr = null;
		String strQuery="";
					
		try
		{
			hshRecord = new HashMap();
			arr =  new ArrayList();
			strQuery = SQLParser.getSqlQuery("glpoption");
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				arr.add(Helper.correctNull(rs.getString(1)));	
				arr.add(Helper.correctNull(rs.getString(2)));	
				arr.add(Helper.correctNull(rs.getString(3)));	
				arr.add(Helper.correctNull(rs.getString(4)));	
				arr.add(Helper.correctNull(rs.getString(5)));	
				arr.add(Helper.correctNull(rs.getString(6)));	
			}
			hshRequestValues.put("arr",arr);
				
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData login  "+ce.toString());
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
		return hshRequestValues;
	}
	
	public HashMap getDataFinal(HashMap hshRequestValues) 
	{
		HashMap hshValues=new HashMap();
		String strPage="";
		
		try
		{
			strPage=correctNull((String)hshRequestValues.get("hidCategoryType"));
		
			if(strPage.equalsIgnoreCase("OPS"))
				hshValues=getOPSDataFinal(hshRequestValues);
			else
				hshValues=getPerDataFinal(hshRequestValues);
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getBorrowerDetails Bean ::  "+e.getMessage());
		}
		
		return hshValues;
	}

	public HashMap getBorrowerDetails(HashMap hshRequestValues) 
	{
		
		HashMap hshValues=new HashMap();
		ResultSet rs = null;
		String strQuery="",areacheckval="",desc="",bownameval="";
		String area2="",area3="",area4="",area5="" ,glptotlevel="",absPosition="";
		String strCategorytype="",str_statuscust=""
		,str_statuscompkyc="",str_statuscompincexp="";
		String strCusCBSStatus="N";
		String strradioValues="",strSearchText="";
		String strQuery1="";
		ArrayList arrdata =  new ArrayList();
		try
		{
			strQuery = SQLParser.getSqlQuery("glpoption");
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				glptotlevel = (String)Helper.correctNull(rs.getString(1));	
			}
	        absPosition = correctNull((String)hshRequestValues.get("hid_rowcount"));
			
			area2= correctNull((String)hshRequestValues.get("area2"));
			area3 = correctNull((String)hshRequestValues.get("area3"));
			area4 = correctNull((String)hshRequestValues.get("area4"));
			area5 = correctNull((String)hshRequestValues.get("area5"));
			if(area4.equals("undefined"))
				area4="";
			
			if(!area5.equals(""))
			{
				areacheckval=area5;
			}
			else if(!area4.equals(""))
			{
				if(glptotlevel.equals("4"))
				{
					areacheckval=area4.substring(0,12)+"%%%";
				}
				else if(glptotlevel.equals("5"))
				{
					areacheckval=area4.substring(0,15);
				}
			}
			else if(!area3.equals(""))
			{
				areacheckval=area3.substring(0,9)+"%%%%%%";
			}
			else if(!area2.equals(""))
			{
					areacheckval=area2.substring(0,6)+"%%%%%%%%%";
			}
			else
			{
				areacheckval="";			
			}
			bownameval = Helper.correctDoubleQuote(correctNull((String)hshRequestValues.get("bow_name")));
			String strStaffFlag = correctNull((String)hshRequestValues.get("chk_staff_only"));
			String datecheck = correctNull((String)hshRequestValues.get("dateofbirth"));
			String orgSelCode = Helper.correctNull((String)hshRequestValues.get("strOrgSelect"));
			strCategorytype=correctNull((String)hshRequestValues.get("hidCategoryType"));
			orgSelCode = orgSelCode+"%"; 
			
			/*
			 * Added by prakash for new search using Application number , Inward number and CBS customer id
			 */
			strSearchText=Helper.correctSingleQuote(correctNull((String)hshRequestValues.get("txtsearch")));
			strradioValues=correctNull((String)hshRequestValues.get("radiobutton"));
			
			if (!strSearchText.equals("") ) 
			{
				if(!areacheckval.equals(""))
				{

				
			if(strradioValues.equalsIgnoreCase("NAME"))
			{
				desc= "(upper(perapp_fname) like upper('%"+strSearchText+"%'))" ;
				
				strQuery1 = SQLParser.getSqlQuery("sel_appnosearchbyname^"+desc+"^"+areacheckval);

			}
				}
				else
				{
			 if(strradioValues.equalsIgnoreCase("CBSID"))
			{
				desc=strSearchText;
				
				strQuery1 = SQLParser.getSqlQuery("sel_appnosearchbycbsid^"+desc);
				
			}
			else if(strradioValues.equalsIgnoreCase("INWARDNO"))
			{
				desc="app_inwardno = '"+strSearchText+"'";
				
				strQuery1 = SQLParser.getSqlQuery("sel_appnosearchbyappno^"+desc);

			}
			else if(strradioValues.equalsIgnoreCase("APPLICATIONNO"))
			{
				desc="app_no = '"+strSearchText+"'";
				
				strQuery1 = SQLParser.getSqlQuery("sel_appnosearchbyappno^"+desc);
			}
			else if(strradioValues.equalsIgnoreCase("DIGIAPPNO"))
			{
				//No Function;sel_by_digiApp
				desc=strSearchText;
				strQuery1 = SQLParser.getSqlQuery("sel_by_digiApp^"+desc);	
			}
			}
		}
			if(!strQuery1.equalsIgnoreCase(""))
			{
			rs = DBUtils.executeQuery(strQuery1);

			while(rs.next())
			{
				ArrayList arrval =  new ArrayList();
				arrval.add(rs.getString(1));//0
				arrval.add(rs.getString(2));//1
				arrval.add(rs.getString(3));//2
				arrval.add(rs.getString(4));//3
				arrval.add(rs.getString(5));//4
				arrval.add(rs.getString(6));	//5
				
				if(strCategorytype.equalsIgnoreCase("RET") || strCategorytype.equalsIgnoreCase("LAD"))
				{
					str_statuscust=Helper.correctNull((String)rs.getString("perapp_profilestatus"));
					if(str_statuscust.equalsIgnoreCase(""))
						str_statuscust="N";
					strCusCBSStatus=Helper.correctNull((String)rs.getString("perapp_cbsstatus"));
				}
				arrval.add(str_statuscust);//6
				arrval.add(str_statuscompkyc);//7
				arrval.add(str_statuscompincexp);//8
				arrval.add(strCusCBSStatus);//9
				arrval.add(strradioValues);//10
				arrval.add(strSearchText);//11
				arrdata.add(arrval);
				
			}
		}
			hshValues.put("vecval",arrdata);	
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getBorrowerDetails  "+ce.toString());
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

	public HashMap getDataHelp(HashMap hsh) 
	{
		String strQuery="";
		ResultSet rs=null;
		HashMap hshvalues = new HashMap();
		ArrayList arr = new ArrayList();
		ArrayList arr1 = new ArrayList();
		String valsys="";
		try
		{
			valsys =Helper.correctNull((String)hsh.get("valsys"));
			strQuery = SQLParser.getSqlQuery("orgcodesel^"+valsys);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arr.add(correctNull(rs.getString(1)));
				arr1.add(correctNull(rs.getString(2)));
			}
			hshvalues.put("arrVal",arr);
			hshvalues.put("arrValdesc",arr1);
		}
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
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
		return hshvalues;
	}
	
	private HashMap getPerBorrowerDetails(HashMap hshRequestValues)
	{

		ResultSet rs = null;
		String strQuery="",areacheckval="",desc="",bownameval="";
		String area2="",area3="",area4="",area5="" ,glptotlevel="",absPosition="";
		String strCategorytype="";
		
		try
		{
			strQuery = SQLParser.getSqlQuery("glpoption");
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				glptotlevel = (String)Helper.correctNull(rs.getString(1));	
			}
	        absPosition = correctNull((String)hshRequestValues.get("hid_rowcount"));
			
			area2= correctNull((String)hshRequestValues.get("area2"));
			area3 = correctNull((String)hshRequestValues.get("area3"));
			area4 = correctNull((String)hshRequestValues.get("area4"));
			area5 = correctNull((String)hshRequestValues.get("area5"));
			if(area4.equals("undefined"))
				area4="";
			
			if(!area5.equals(""))
			{
				areacheckval=area5;
			}
			else if(!area4.equals(""))
			{
				if(glptotlevel.equals("4"))
				{
					areacheckval=area4.substring(0,12)+"%%%";
				}
				else if(glptotlevel.equals("5"))
				{
					areacheckval=area4.substring(0,15);
				}
			}
			else if(!area3.equals(""))
			{
				areacheckval=area3.substring(0,9)+"%%%%%%";
			}
			else if(!area2.equals(""))
			{
				areacheckval=area2.substring(0,6)+"%%%%%%%%%";
			}
			else
			{
				areacheckval="";			
			}
			bownameval = Helper.correctDoubleQuote(correctNull((String)hshRequestValues.get("bow_name")));
			String strStaffFlag = correctNull((String)hshRequestValues.get("chk_staff_only"));
			String datecheck = correctNull((String)hshRequestValues.get("dateofbirth"));
			String orgSelCode = Helper.correctNull((String)hshRequestValues.get("strOrgSelect"));
			strCategorytype=correctNull((String)hshRequestValues.get("hidCategoryType"));
			orgSelCode = orgSelCode+"%"; 
			
			if(!strStaffFlag.trim().equalsIgnoreCase("Y"))
				strStaffFlag = "%";
			if (!areacheckval.equals("") && !bownameval.equals("") ) 
			{
				if(strCategorytype.equalsIgnoreCase("LAD") || strCategorytype.equalsIgnoreCase("OPS"))
				{
					desc= "(upper(perapp_fname) like upper('%"+bownameval+"%'))" ;
				}
				else
				{
					desc= "(upper(perapp_fname) like upper('%"+bownameval+"%'))" +
					"and (upper(PERAPP_PROFILESTATUS)='Y' or PERAPP_PROFILESTATUS is null) " ;
				}
				
			}
			else if(!areacheckval.equals("") && !datecheck.equals(""))
			{
				if(strCategorytype.equalsIgnoreCase("LAD") || strCategorytype.equalsIgnoreCase("OPS"))
				{
					desc= "(to_char(perapp_dob,'dd/mm/yyyy') like '"+datecheck+"') " ;
				}
				else
				{
					desc= "(to_char(perapp_dob,'dd/mm/yyyy') like '"+datecheck+"') " +
					"and (upper(PERAPP_PROFILESTATUS)='Y' or PERAPP_PROFILESTATUS is null) " ;
				}
			}
			
			strQuery = SQLParser.getSqlQuery("search_borrower2^"+desc+"^"+strStaffFlag+"^"+areacheckval);

			ArrayList vecval =  new ArrayList();
			ArrayList vecdata =  new ArrayList();
			rs = DBUtils.executeQuery(strQuery);
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
				vecval =  new ArrayList();
				vecval.add(rs.getString(1));
				vecval.add(rs.getString(2));
				vecval.add(rs.getString(3));
				vecval.add(rs.getString(4));
				vecval.add(rs.getString(5));
				vecval.add(rs.getString(6));	
				vecdata.add(vecval);
			}
			hshRequestValues.put("vecval",vecdata);	
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData login  "+ce.toString());
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
		return hshRequestValues;
	
	}
	private HashMap getOPSBorrowerDetails(HashMap hshRequestValues)
	{

		ResultSet rs = null;
		String strQuery="",areacheckval="",desc="",bownameval="";
		String area1="",area2="",area3="",area4="",area5="" ,staffid="",glptotlevel="",absPosition="",pagetype="";
		staffid=correctNull((String)hshRequestValues.get("staffid"));
		//Added by Mercy for tertiary search
		if(staffid.equals(""))
		{
			staffid=correctNull((String)hshRequestValues.get("strUserId"));
		}
		try
		{
			strQuery = SQLParser.getSqlQuery("glpoption");
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				glptotlevel = (String)Helper.correctNull(rs.getString(1));	
			}
	        absPosition = correctNull((String)hshRequestValues.get("hid_rowcount"));
			pagetype = correctNull((String)hshRequestValues.get("link"));
			area1= correctNull((String)hshRequestValues.get("area1"));
			area2= correctNull((String)hshRequestValues.get("area2"));
			area3 = correctNull((String)hshRequestValues.get("area3"));
			area4 = correctNull((String)hshRequestValues.get("area4"));
			area5 = correctNull((String)hshRequestValues.get("area5"));
			if(area4.equals("undefined"))
				area4="";
			
			if(!area5.equals(""))
			{
				areacheckval=area5;
			}
			else if(!area4.equals(""))
			{
				if(glptotlevel.equals("4"))
				{
					areacheckval=area4.substring(0,12)+"%%%";
				}
				else if(glptotlevel.equals("5"))
				{
					areacheckval=area4.substring(0,15);
				}
			}
			else if(!area3.equals(""))
			{
				areacheckval=area3.substring(0,9)+"%%%%%%";
			}
			else if(!area2.equals(""))
			{
				areacheckval=area2.substring(0,6)+"%%%%%%%%%";
			}
			else if(!area1.equals(""))
			{
				areacheckval=area1.substring(0,3)+"%%%%%%%%%";
			}
			else
			{
				areacheckval="";			
			}
			bownameval = correctNull((String)hshRequestValues.get("bow_name"));
			String strStaffFlag = correctNull((String)hshRequestValues.get("chk_staff_only"));
			String datecheck = correctNull((String)hshRequestValues.get("dateofbirth"));
			String orgcode = Helper.correctNull((String)hshRequestValues.get("strOrgCode"));
			String orgSelCode = Helper.correctNull((String)hshRequestValues.get("strOrgSelect"));
			orgSelCode = orgSelCode+"%"; 
			
			if(!strStaffFlag.trim().equalsIgnoreCase("Y"))
				strStaffFlag = "%";
		
			if (!areacheckval.equals("") && !bownameval.equals("") ) 
			{
				/*if((Helper.correctNull((String)hshRequestValues.get("link")).equalsIgnoreCase("EXI")) || 
						(Helper.correctNull((String)hshRequestValues.get("link")).equalsIgnoreCase("PD")) ||
						(Helper.correctNull((String)hshRequestValues.get("link")).equalsIgnoreCase("PROP")))
						
				{
					desc="and upper(perapp_fname) like upper('%"+bownameval+"%')  " +
					//"and nvl(perapp_staffusrid,'0')!='"+staffid+"' "+
					"and nvl(perapp_istaff, 'N') like ('"+strStaffFlag+"') "+
					"and org_code like ('"+areacheckval+"%') ";
					
					strQuery = SQLParser.getSqlQuery("terappexisearch^"+desc);
				}
				else if(pagetype.equalsIgnoreCase("NEW"))
				{*/
					desc= "(upper(perapp_fname) like upper('%"+bownameval+"%') or upper(perapp_lname) like upper('%"+bownameval+"%'))" ;
					strQuery = SQLParser.getSqlQuery("search_borrower2^"+desc+"^"+strStaffFlag+"^"+areacheckval);
				//}
				
			}
			else if(!areacheckval.equals("") && !datecheck.equals(""))
			{
				desc="and (to_char(perapp_dob,'dd/mm/yyyy') like '"+datecheck+"') "  +
				//"and nvl(perapp_staffusrid,'0')!='"+staffid+"' "+
				"and nvl(indinfo_is_staff, 'N') like ('"+strStaffFlag+"') "+
				"and org_code like ('"+areacheckval+"%') ";
				
				strQuery = SQLParser.getSqlQuery("terappexisearch^"+desc);
			}
			/*else if (areacheckval.equals("") && !bownameval.equals(""))
			{
				if((correctNull((String)hshRequestValues.get("link")).equalsIgnoreCase("EXI")) || 
						(correctNull((String)hshRequestValues.get("link")).equalsIgnoreCase("PD"))||
						(correctNull((String)hshRequestValues.get("link")).equalsIgnoreCase("PROP")))
				{
				
					desc="and upper(perapp_fname) like upper('%"+bownameval+"%')  " +
					//"and nvl(perapp_staffusrid,'0')!='"+staffid+"' "+
					"and nvl(perapp_istaff, 'N') like ('"+strStaffFlag+"') "+
					"and org_code like ('"+orgSelCode+"%') ";
			
					strQuery = SQLParser.getSqlQuery("terappexisearch^"+desc);
				}
				else if(Helper.correctNull((String)hshRequestValues.get("link")).equalsIgnoreCase("NEW"))
				{
					strQuery = SQLParser.getSqlQuery("borrowernamea^"+bownameval+"^"+staffid+"^"+strStaffFlag+"^"+orgcode);
				}
			}
			else if (areacheckval.equals("") && !datecheck.equals("") )
			{				
				desc="and (to_char(perapp_dob,'dd/mm/yyyy') like '"+datecheck+"') "  +
				//"and nvl(perapp_staffusrid,'0')!='"+staffid+"' "+
				"and nvl(perapp_istaff, 'N') like ('"+strStaffFlag+"') "+
				"and org_code like ('"+orgSelCode+"%') ";
				
				strQuery = SQLParser.getSqlQuery("terappexisearch^"+desc);
				
			}

			else if (areacheckval.equals("") && bownameval.equals("") )
			{
				String level1=correctNull((String)hshRequestValues.get("strOrgLevel"));
				String orgcode1= correctNull((String)hshRequestValues.get("strOrgCode"));
				if (level1.equals("C"))
				{
					orgcode1=orgcode1.substring(0,3)+"%%%%%%%%%%%%";
					desc= "in (select org_scode from organisations where org_code like '"+orgcode1+"')";
				}
				else if(level1.equals("R"))
				{
					orgcode1=orgcode1.substring(0,6)+"%%%%%%%%%";
					desc= "in (select org_scode from organisations where org_code like '"+orgcode1+"')"	;	
				}
				else if(level1.equals("D"))
				{
					orgcode1=orgcode1.substring(0,9)+"%%%%%%";
					desc= "in (select org_scode from organisations where org_code like '"+orgcode1+"')";	
				}
				else if(level1.equals("A"))
				{
					if(glptotlevel.equals("4"))
					{
						orgcode1=orgcode1.substring(0,9)+"%%%%%%";
					}
					else if(glptotlevel.equals("5"))
					{
						orgcode1=orgcode1.substring(0,12)+"%%%";
					}
					desc= "in (select org_scode from organisations where org_code like '"+orgcode1+"')";
				}
				else if(level1.equals("B"))
				{
					orgcode1=orgcode1.substring(0,12)+"%%%";
					desc= "in (select org_scode from organisations where org_code like '"+orgcode1+"')";
				}
				strQuery = SQLParser.getSqlQuery("search_borrower^"+desc+"^"+staffid+"^"+strStaffFlag);
			}*/
			ArrayList vecval =  new ArrayList();
			ArrayList vecdata =  new ArrayList();
			rs = DBUtils.executeQuery(strQuery);
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
				vecval =  new ArrayList();
				vecval.add(rs.getString(1));
				vecval.add(rs.getString(2));
				vecval.add(rs.getString(3));
				vecval.add(rs.getString(4));
				vecval.add(rs.getString(5));
				vecval.add(rs.getString(6));	
				vecdata.add(vecval);
			}
			hshRequestValues.put("vecval",vecdata);	
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData login  "+ce.toString());
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
		return hshRequestValues;
	
	}
	private HashMap getPerDataFinal(HashMap hshRequestValues) 
	{
		 
		ResultSet rs = null;
		ResultSet rs1=null;	
		HashMap hshRecord = null;
		String strQuery="",status="",strappid="";
		ArrayList vecval =  new ArrayList();
		ArrayList vecdata =  new ArrayList();
		String strOrgSelect = "";	
		String strCattype="";
		String strPrdtype="";
		String strApplicantid="",strCBSID="";
		String strprofilestatus="N",str_statuscompkyc=null;
		String appno="";
		
		boolean apprenewed=false;
			
		try
		{			
			
			
			hshRecord = new HashMap();
			strOrgSelect = Helper.correctNull((String)hshRequestValues.get("strOrgSelect"));
			if(strOrgSelect.equalsIgnoreCase("001001"))
			{
				strOrgSelect="001";
			}
			String strSearchType=Helper.correctNull((String)hshRequestValues.get("searchtype"));
			String strAppno=Helper.correctNull((String)hshRequestValues.get("searchval"));
			strappid = correctNull((String)hshRequestValues.get("applicantoldid"));	
			if((strappid.equalsIgnoreCase(""))||(strappid.equalsIgnoreCase("undefined")))
			{
				strappid = correctNull((String)hshRequestValues.get("id"));	
			}
			
			
			strCattype=correctNull((String)hshRequestValues.get("hidCategoryType"));	
			
			String appidList="";
			
			strOrgSelect=strOrgSelect+"%";
			
			strQuery = SQLParser.getSqlQuery("UniqAppidList^"+strappid);
					
			rs =DBUtils.executeQuery(strQuery);
			/*while(rs.next())
			{
				appidList = appidList + Helper.correctNull((String)rs.getString("perapp_id")) + ",";
				if(!apprenewed && (correctNull(rs.getString("perapp_renew")).equals("") || correctNull(rs.getString("perapp_renew")).equalsIgnoreCase("n")))
				{
					strApplicantid=correctNull((String)rs.getString("perapp_id"));
					strprofilestatus=correctNull((String)rs.getString("perapp_profilestatus"));
					apprenewed=true;
				}
			}*/
			if(rs.next())
			{
				strApplicantid=correctNull((String)rs.getString("perapp_id"));
				strprofilestatus=correctNull((String)rs.getString("perapp_profilestatus"));
				strCBSID=correctNull(rs.getString("perapp_cbsid"));
				apprenewed=true;
			}
			if(rs!=null)
			{
				rs.close();
			}

			if(!appidList.equalsIgnoreCase(""))
			{
				appidList = appidList.substring(0,appidList.length()-1);
			}
			if(strCattype.equalsIgnoreCase("RET"))
			{
				strPrdtype= " prd_type like 'p%' and prd_type not in ('aH','aR','pG','pR')";
			}
			else if(strCattype.equalsIgnoreCase("AGR"))
			{
				strPrdtype= " prd_type like 'a%' ";
			}
			else if(strCattype.equalsIgnoreCase("LAD"))
			{
				strPrdtype= " prd_type in ('aH','aR','pG','pR') ";
			}
			else 
			{
				strPrdtype= " prd_type like '%' ";
			}
			if(strSearchType.equalsIgnoreCase("APPLICATIONNO"))
			{
				appno="and app_no='"+strAppno+"'";
			}
			else if(strSearchType.equalsIgnoreCase("INWARDNO"))
			{
				appno="and app_inwardno='"+strAppno+"'";
			}
			else if(strSearchType.equalsIgnoreCase("DIGIAPPNO"))
			{
				appno="and INWARD_DIGIAPPNO='"+strAppno+"'";
			}
			else
			{
				appno="and app_no <> ' '";
			}
			if(!appidList.equalsIgnoreCase(""))
			{
				strQuery = SQLParser.getSqlQuery("UniqOrgAppgenerationa^"+strPrdtype+"^"+appidList+"^"+appno);
			} 
			else if(strSearchType.equalsIgnoreCase("DIGIAPPNO") && !strappid.equalsIgnoreCase(""))
			{
				strQuery = SQLParser.getSqlQuery("UniqOrgAppgenerationa_digi^"+strPrdtype+"^"+strappid+"^"+appno);
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("UniqOrgAppgenerationa^"+strPrdtype+"^"+strappid+"^"+appno);
			}

			if(!strQuery.equalsIgnoreCase(""))
			{
				rs=DBUtils.executeQuery(strQuery);
			}
			
			while(rs.next())
			{
				vecval =  new ArrayList();
				vecval.add(rs.getString(1));
				//token=rs.getString(1);
				//scode=token.substring(0,token.length()-7);
				//ano=token.substring(token.length()-7,token.length());
				status=rs.getString(2);
				
				if(status.equalsIgnoreCase("op"))
				{
					status="OPEN/PENDING";
				}
				else if(status.equalsIgnoreCase("ol"))
				{
					status="OPEN/LODGED";
				}
				else if(status.equalsIgnoreCase("pa"))
				{
					status="PROCESSED/APPROVED";
				}
				else if(status.equalsIgnoreCase("pr"))
				{
					status="PROCESSED/REJECTED";
				}
				else if(status.equalsIgnoreCase("CA"))
				{
					status="CLOSED/APPROVED";
				}
				else if(status.equalsIgnoreCase("CR"))
				{
					status="CLOSED/REJECTED";
				}
				
				vecval.add(status);
				//vecval.add(scode);
				//vecval.add(ano);
				vecval.add(correctNull((String)rs.getString("cat_name")));
				vecval.add(correctNull((String)rs.getString("prdsubcat")));
			
				//String strchk = correctNull((String)rs.getString("mailchkstatus"));	
				
				String strAppholderid=correctNull(rs.getString("app_applnholder"));
				String strAppholdername=correctNull(rs.getString("appholdername"));
				
				//if(correctNull((String)hshRequestValues.get("strGroupRights")).charAt(18)=='w')
				//{
					if(!strAppholderid.equals(""))
					{
						if(correctNull((String)hshRequestValues.get("strUserId")).equals(strAppholderid))
						{
							vecval.add("Y");
							vecval.add(strAppholdername);
							vecval.add(strAppholderid);
						}
						else
						{
							vecval.add("N");	
							vecval.add(strAppholdername);
							vecval.add(strAppholderid);
						}
					}
					/*else if(strchk.trim().equalsIgnoreCase("Y"))
					{
						String authUserId ="",usr_fname="",usr_lname="";
						strQuery= SQLParser.getSqlQuery("selmailbxchkstatus^"+token+"^"+token);
						rs1=DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							authUserId=correctNull(rs1.getString("mail_tousrid"));
							usr_fname=correctNull(rs1.getString("usr_fname"));
							usr_lname=correctNull(rs1.getString("usr_lname"));
						}
						if(Helper.correctNull((String)hshRequestValues.get("strUserId")).equals(authUserId))
						{
							vecval.add("Y");
							vecval.add(usr_fname+usr_lname);
							vecval.add(authUserId);
						}
						else{
							vecval.add("N");	
							vecval.add(usr_fname+usr_lname);
							vecval.add(authUserId);
						}
					}*/
					else
					{
						vecval.add("Y");
						vecval.add(Helper.correctNull((String)hshRequestValues.get("strUserId")));
						vecval.add(Helper.correctNull((String)hshRequestValues.get("strUserId")));
					}
				/*}
				else
				{
					vecval.add("Y");	
					vecval.add(correctNull((String)hshRequestValues.get("strUserId")));
				}*/
					
				vecval.add(correctNull((String)rs.getString("demo_appid")));
				
				vecval.add(correctNull((String)rs.getString("prd_desc")));
				vecval.add(correctNull(rs.getString("app_renew_flag")));
				vecval.add(correctNull(rs.getString("APP_LOANSUBTYPE_DIGI")));
				
				vecdata.add(vecval);
				
				
			}
			
			String strOccupation="";
			if(rs1!=null)
				rs1.close();
			
			if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
			{
				strQuery=SQLParser.getCBSSqlQuery("cbscusmastersearch_newconnection^"+strCBSID);
				rs1=DBUtils.executeQueryCBSConnection(strQuery);
			}
			else
			{
				strQuery= SQLParser.getSqlQuery("cbscusmastersearch^"+strCBSID);
				rs1=DBUtils.executeQuery(strQuery); 
			}
			if(rs1.next())
			{
				strOccupation=Helper.correctNull(rs1.getString("cust_occp_code"));
			}
			if(rs1!=null)
				rs1.close();
			
			strQuery=SQLParser.getSqlQuery("sel_applKYCNorms^"+strApplicantid);
			rs1=DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
					str_statuscompkyc="Y";
					if(!strOccupation.equalsIgnoreCase("MIGR"))
						strOccupation=Helper.correctNull(rs1.getString("kyc_occupationcode"));
			}
			else
			{
				str_statuscompkyc="N";
			}
			
			hshRecord.put("strOccupationCode",strOccupation);
			if(rs1 != null)
			{
				rs1.close();
			}
			
			strQuery=SQLParser.getSqlQuery("sel_processAppl_demoid^"+strappid+"^"+strappid+"^"+strappid);
			rs1=DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				hshRecord.put("str_approvedAppl_demoid","Y");
			}
			else
			{
				hshRecord.put("str_approvedAppl_demoid","N");
			}
			
			hshRecord.put("vecval",vecdata);	
			hshRecord.put("newbuttonenable",Boolean.toString(apprenewed));
			hshRecord.put("hidapplicantid",strApplicantid);
			hshRecord.put("profilestatus",strprofilestatus);
			hshRecord.put("str_statuscompkyc",str_statuscompkyc);
			hshRecord.put("searchtype", strSearchType);
			if(rs != null)
			{rs.close();}
			strQuery=SQLParser.getSqlQuery("sel_op_ratingproposal^"+strCBSID);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				if(rs1!=null)
				{rs1.close();}
				String strRatAppNo=correctNull(rs.getString("fin_ratappno"));
				strQuery=SQLParser.getSqlQuery("selcrefreezeflag^"+strRatAppNo);
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					if(!correctNull(rs1.getString("cre_rating")).equalsIgnoreCase("")&& !correctNull(rs1.getString("cre_weight")).equalsIgnoreCase(""))
						hshRecord.put("strRatingProposalPending", "Y");
					else
						hshRecord.put("strProposalPendinginKalypto", "Y");	
					hshRecord.put("strProposalUserID",correctNull(rs1.getString("cre_userid")));
					hshRecord.put("strProposalUserName",correctNull(rs1.getString("username")));
					
				}
				else
				{
					hshRecord.put("strRatingProposalPending", "Y");
				}
			}
			if(rs1 != null)
			{rs1.close();}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData login  "+ce.toString());
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
	private HashMap getOPSDataFinal(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		//ResultSet rs1 = null;
		HashMap hshRecord = null;
		String strappid="";
		String strQuery="";
		String status="";
		//String appno="";
		String strOrgSelect="";
		ArrayList vecval =  new ArrayList();
		ArrayList vecdata =  new ArrayList();
		boolean apprenewed=false;
		String strApplicantid="";
		String strprofilestatus="";
		//String hidPageType="";
		//String token="";
		
		try
		{
			hshRecord = new HashMap();
			strappid = correctNull((String)hshRequestValues.get("applicantoldid"));
			if(strappid.equalsIgnoreCase(""))
			{
				strappid=Helper.correctNull((String)hshRequestValues.get("comappid"));
			}
			
			strOrgSelect = Helper.correctNull((String)hshRequestValues.get("strOrgSelect"));
			strOrgSelect = strOrgSelect + "%";
			
			if(!strappid.equals(""))
			{

				//String chkAppid = Helper.correctNull((String)hshRequestValues.get("chkAppid"));
				
				//if(chkAppid.equalsIgnoreCase("Y"))
				//{
					String appidList="";
					
					//String uniqoldid = Helper.correctNull((String)hshRequestValues.get("uniqoldid"));
					strQuery = SQLParser.getSqlQuery("UniqAppidList^"+strappid);
					
					rs =DBUtils.executeQuery(strQuery);
					/*while(rs.next())
					{
						appidList = appidList + correctNull((String)rs.getString("perapp_id")) + "," ;
						if(!apprenewed && (correctNull(rs.getString("perapp_renew")).equals("") || correctNull(rs.getString("perapp_renew")).equalsIgnoreCase("n")))
						{
							strApplicantid=correctNull((String)rs.getString("perapp_id"));
							strprofilestatus=correctNull((String)rs.getString("perapp_profilestatus"));
							apprenewed=true;
						}
					}*/
					if(rs.next())
					{
						strApplicantid=correctNull((String)rs.getString("perapp_id"));
						strprofilestatus=correctNull((String)rs.getString("perapp_profilestatus"));
						apprenewed=true;
					}
					if(rs!=null)
					{
						rs.close();
					}
					
					
						if(!appidList.equalsIgnoreCase(""))
						{
							appidList = appidList.substring(0,appidList.length()-1);
						}
					
					
					if(!appidList.equalsIgnoreCase(""))
					{
						strQuery = SQLParser.getSqlQuery("UniqOrgAppgenerationOPS^"+appidList+"^"+strOrgSelect);
					} 
					else
					{
						strQuery = SQLParser.getSqlQuery("UniqOrgAppgenerationOPS^"+strappid+"^"+strOrgSelect);
					}
				/*}
				else
				{
					strQuery = SQLParser.getSqlQuery("appgeneration^"+strappid +"^T"); //+"^"+strappid
				}*/
				
				if(!strQuery.equalsIgnoreCase(""))
				{
					rs=DBUtils.executeQuery(strQuery);
				}
			}
			
			rs =DBUtils.executeQuery(strQuery);			
			while(rs.next())
			{
				vecval =  new ArrayList();
				vecval.add(rs.getString(1));
				//token=rs.getString(1);
				status=rs.getString(2);
				if(status.equalsIgnoreCase("op"))
				{
					status="OPEN/PENDING";
				}
				if(status.equalsIgnoreCase("pa"))
				{
					status="PROCESSED/APPROVED";
				}
				if(status.equalsIgnoreCase("pr"))
				{
					status="PROCESSED/REJECTED";
				}
				if(status.equalsIgnoreCase("ca"))
				{
					status="CLOSED/APPROVED";
				}
				if(status.equalsIgnoreCase("cr"))
				{
					status="CLOSED/REJECTED";
				}
				vecval.add(status);
				
				String strAppholderid=correctNull(rs.getString("app_applnholder"));
				String strAppholdername=correctNull(rs.getString("appholdername"));
				
				//if(correctNull((String)hshRequestValues.get("strGroupRights")).charAt(18)=='w')
				//{
				if(!strAppholderid.equals(""))
				{
					if(correctNull((String)hshRequestValues.get("strUserId")).equals(strAppholderid))
					{
						vecval.add("Y");
						vecval.add(strAppholdername);
						vecval.add(strAppholderid);
					}
					else
					{
						vecval.add("N");	
						vecval.add(strAppholdername);
						vecval.add(strAppholderid);
					}
				}
					
				vecval.add(correctNull((String)rs.getString("app_orglevel")));
				vecval.add(correctNull((String)rs.getString("demo_comappid")));
				vecdata.add(vecval);	
			}
			hshRecord.put("vecval",vecdata);
			hshRecord.put("newbuttonenable",Boolean.toString(apprenewed));
			hshRecord.put("hidapplicantid",strApplicantid);
			hshRecord.put("profilestatus",strprofilestatus);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData login  "+ce.toString());
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
}
