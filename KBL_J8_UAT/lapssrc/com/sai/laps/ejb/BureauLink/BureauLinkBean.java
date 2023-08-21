package com.sai.laps.ejb.BureauLink;

import com.sai.laps.ejb.borrowersearch.borrowersearchBean;


import com.sai.laps.helper.BeanAdapter;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.text.SimpleDateFormat;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.ConnectionFactory;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "BureauLinkBean", mappedName = "BureauLinkHome")
@Remote (BureauLinkRemote.class)
public class BureauLinkBean extends BeanAdapter{
	
	static Logger log=Logger.getLogger(borrowersearchBean.class);
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public HashMap getBureauData(HashMap hshValues) 
	{
		ResultSet rs = null,rs1=null,rs2=null;
		HashMap hshRecord = null;
		String strQuery="",strInwardno="",strDistcode="",strDistDesc="",StrFetchDate="";
		String hunterbuttonflag="N";
		try
		{
			hshRecord = new HashMap();
			strInwardno=correctNull((String)hshValues.get("txt_inwardno"));
			if(strInwardno.equals(""))
				strInwardno=correctNull((String)hshValues.get("strInwardno"));
			if(strInwardno.equals(""))
				strInwardno=correctNull((String)hshValues.get("hidinwardno"));
			if(strInwardno.equals(""))
				strInwardno=correctNull((String)hshValues.get("hidinwardno"));
			if(strInwardno.equals(""))
				strInwardno=correctNull((String)hshValues.get("hidBRappno"));
			strQuery = SQLParser.getSqlQuery("getBureaudetails^"+strInwardno);
			rs =DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("BUR_APPNO",correctNull(rs.getString("BUR_APPNO")));//0
				hshRecord.put("BUR_CBSID",correctNull(rs.getString("BUR_CBSID")));//1
				hshRecord.put("BUR_CUSTYPE",correctNull(rs.getString("BUR_CUSTYPE")));//2
				hshRecord.put("BUR_FNAME",correctNull(rs.getString("BUR_FNAME")));//3
				//hshRecord.put("BUR_LNAME",correctNull(rs.getString("BUR_LNAME")));//4
				hshRecord.put("BUR_DOB",correctNull(rs.getString("BUR_DOB")));//5
				hshRecord.put("BUR_GENDER",correctNull(rs.getString("BUR_GENDER")));//6
				hshRecord.put("BUR_ADDRESS1",correctNull(rs.getString("BUR_ADDRESS1")));//7
				hshRecord.put("BUR_ADDRESS2",correctNull(rs.getString("BUR_ADDRESS2")));//8
				hshRecord.put("BUR_ZIP",correctNull(rs.getString("BUR_ZIP")));//9
				hshRecord.put("BUR_PANNO",correctNull(rs.getString("BUR_PANNO")));//10
				hshRecord.put("BUR_AADHAR",correctNull(rs.getString("BUR_AADHAR")));//11
				hshRecord.put("BUR_EMAIL",correctNull(rs.getString("BUR_EMAIL")));//12
				hshRecord.put("CREATED_DATE",correctNull(rs.getString("CREATED_DATE")));//13
				hshRecord.put("BUR_PRDTYPE",correctNull(rs.getString("BUR_PRDTYPE")));//13
				//hshRecord.put("BUR_REQAMNT",Double.parseDouble(Helper.correctDouble(rs.getString("BUR_REQAMNT"))));//13
				hshRecord.put("BUR_REQAMNT",Helper.correctNull((rs.getString("BUR_REQAMNT"))));//13
				hshRecord.put("BUR_TENOR",correctNull(rs.getString("BUR_TENOR")));//13
				hshRecord.put("BUR_HUNTER_REQ",correctNull(rs.getString("BUR_HUNTER_REQ")));
				if(rs1 !=null)
				{
					rs1.close();
				}
				rs1=DBUtils.executeLAPSQuery("sel_citynamebycode^"+ correctNull(rs.getString("BUR_CITY")));	
				if (rs1.next()) 
				{
					hshRecord.put("BUR_CITY",correctNull(rs1.getString("city_name")));
					hshRecord.put("BUR_CITYCODE",correctNull(rs.getString("BUR_CITY")));
				}
				if(rs1 !=null)
				{
					rs1.close();
				}
				rs1=DBUtils.executeLAPSQuery("sel_distnamebycode^"+ correctNull(rs.getString("BUR_DIST")));	
				if (rs1.next()) 
				{
					hshRecord.put("BUR_DIST",correctNull(rs1.getString("district_desc")));
					hshRecord.put("BUR_DISTCODE",correctNull(rs.getString("BUR_DIST")));
				}
				
				if(rs1 !=null)
				{
					rs1.close();
				}
				rs1=DBUtils.executeLAPSQuery("sel_statenamebycode^"+ correctNull(rs.getString("BUR_STATE")));	
				if (rs1.next()) 
				{
					hshRecord.put("BUR_STATE",correctNull(rs1.getString("state_name")));
					hshRecord.put("BUR_STATECODE",correctNull(rs.getString("BUR_STATE")));
				}
				if(rs1 !=null)
				{
					rs1.close();
				}
				rs1=DBUtils.executeLAPSQuery("sel_countrynamebycode^"+ correctNull(rs.getString("BUR_COUNTRY")));	
				if (rs1.next()) 
				{
					hshRecord.put("BUR_COUNTRY",correctNull(rs1.getString("CON_COUNTRY")));
					hshRecord.put("BUR_COUNTRYCODE",correctNull(rs.getString("BUR_COUNTRY")));
				}
				
				rs2 = DBUtils.executeLAPSQuery("sel_hunter_score_setup^"+"124");
				if(rs2.next())
				{
					hshRecord.put("Hunter_Period", Helper.correctNull(rs2.getString("LOAN_PARAMVAL")));
				}
				
				long remaining_days=0;
				String today_date=(String)Helper.getCurrentDateTime();
				
				StrFetchDate=Helper.correctNull((String)rs.getString("BUR_HUNTER_FETCH_DATE"));
				int StrHunterPeriod=Integer.parseInt(Helper.correctInt(rs2.getString("LOAN_PARAMVAL")));
				Date Fetch_Date,cur_Date;
				if(!StrFetchDate.equalsIgnoreCase("")){
				SimpleDateFormat sdt1=new SimpleDateFormat("dd/MM/yyyy");
				Fetch_Date=sdt1.parse(StrFetchDate);
				cur_Date=sdt1.parse(today_date);
				remaining_days=(cur_Date.getTime()-Fetch_Date.getTime())/(1000*60*60*24);
				}
				int days=(int)remaining_days;
				
				if(StrHunterPeriod <= days || StrFetchDate=="")
				{
					hunterbuttonflag="Y";
				}
				hshRecord.put("BUR_PERAPPID",correctNull(rs.getString("BUR_PERAPPID")));
				hshRecord.put("BUR_FATHERNAME",correctNull(rs.getString("BUR_FATHERNAME")));
				hshRecord.put("BUR_MARSTAT",correctNull(rs.getString("bur_marstat")));
				hshRecord.put("BUR_MOBILE",correctNull(rs.getString("bur_mobile")));
				hshRecord.put("app_createdusr",correctNull(rs.getString("created_usrid")));
				hshRecord.put("BUR_HUNTER_SCORE",correctNull(rs.getString("BUR_HUNTER_SCORE")));
				hshRecord.put("BUR_HUNTER_FETCH_DATE",correctNull(rs.getString("BUR_HUNTER_FETCH_DATE")));
			}
			hshRecord.put("BUR_APPNO", strInwardno);
			hshRecord.put("hunterbuttonflag",hunterbuttonflag);
			
			
			if(rs!=null)
				rs.close();
			
			rs=DBUtils.executeLAPSQuery("chk_hw_cibil_details^"+strInwardno);
			if(rs.next())
			{
				hshRecord.put("strReportFlag","Y");
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getBureauData login  "+ce.toString());
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
	
	public HashMap updateBureauData(HashMap hshValues)  {
		HashMap hshRecord = new HashMap();
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		int maxsno =0;
		String strAction =null;
		String strCusType =null;
		String strcbsid="";
		ResultSet rs = null;
		String strcusName="";
		String strVoterid="";
		String strcusGen="";
		String strDob="";
		String strPAN="";
		String str_city="";
		String str_address1="";
		String str_address2="",str_Aadhar="",str_country="",str_perappId="",str_cibilRequired="";
		String str_dist="",str_state="",str_Zip="",str_Email="",strSno="",strcusLName="";
		String strExp="$";
		String strSolid=correctNull((String)hshValues.get("strSolid"));
		String strInwardno=correctNull((String)hshValues.get("txt_inwardno"));
		String strOrgCode=correctNull((String)hshValues.get("strOrgCode"));
		try{
			
			strAction = Helper.correctNull((String)hshValues.get("hidAction"));
			strCusType= Helper.correctNull((String)hshValues.get("selcusttype"));
			strcbsid =Helper.correctNull((String)hshValues.get("txt_cbscustid"));//
			strcusName=correctNull((String) hshValues.get("txt_comncustame"));
			//strcusLName=correctNull((String) hshValues.get("txt_custlname"));
			strcusGen=Helper.correctNull((String) hshValues.get("selgender"));
			if(strcusGen.equalsIgnoreCase("")){
				strcusGen=Helper.correctNull((String) hshValues.get("hidgender"));
			}
			strDob=Helper.correctNull((String) hshValues.get("txt_comDOB"));
			strPAN=Helper.correctNull((String) hshValues.get("txtcomcust_pan"));
			str_city=Helper.correctNull((String) hshValues.get("hidcity"));
			str_address1=Helper.correctNull((String) hshValues.get("txt_comcustadd1"));
			str_address2=Helper.correctNull((String) hshValues.get("txt_comcustadd2"));
			str_dist=Helper.correctNull((String) hshValues.get("hid_dist"));
			str_state=Helper.correctNull((String) hshValues.get("hid_state"));
			str_Zip=Helper.correctNull((String) hshValues.get("txtcomcust_zip"));
			str_Email=Helper.correctNull((String) hshValues.get("txtcomcust_email"));
			str_Aadhar=Helper.correctNull((String) hshValues.get("txtcust_Aadharid"));
			str_country=Helper.correctNull((String) hshValues.get("hid_country"));
			str_perappId=Helper.correctNull((String) hshValues.get("hid_perapp_id"));
			str_cibilRequired=Helper.correctNull((String) hshValues.get("hunter_required"));
			if (strAction.equalsIgnoreCase("insert"))
			{	
				
				
				if(rs!=null)
					rs.close();
				rs=DBUtils.executeLAPSQuery("sel_bur_details^"+strDob+"^"+strPAN+"^"+str_Aadhar);
				if(rs.next())
				{
					if(Integer.parseInt(Helper.correctInt(rs.getString("datediff")))<90)
					{
						strExp=strExp+"Proposal("+Helper.correctNull(rs.getString("BUR_APPNO"))+") created on  "+Helper.correctNull(rs.getString("created_date"))+", More than one proposal cannot create upto 90 Days ";
						throw new Exception(strExp);
					}
				}
				/*rs = DBUtils.executeLAPSQuery("selmaxpermission");
				if(rs.next()){
					maxsno = rs.getInt("snomax");
				}*/
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				strInwardno=getMaxInwardno(strSolid);
				hshValues.put("strInwardno", strInwardno);
				arrValues.add(strInwardno);
				if(strCusType.equalsIgnoreCase("N"))
					arrValues.add(strInwardno);
				else
					arrValues.add(strcbsid);
				arrValues.add(strCusType);
				arrValues.add(correctNull((String)hshValues.get("strUserId")));
				arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
				arrValues.add(strcusName);
				arrValues.add(strDob);
				arrValues.add(strcusGen);
				arrValues.add(str_address1);
				arrValues.add(str_address2);
				arrValues.add(str_city);
				arrValues.add(str_state);
				arrValues.add(str_dist);
				arrValues.add(str_Zip);
				arrValues.add(strPAN);
				arrValues.add(str_country);
				arrValues.add(str_Aadhar);
				arrValues.add(str_Email);
				arrValues.add(correctNull((String)hshValues.get("prd_type2")));
				arrValues.add(correctNull((String)hshValues.get("txt_reqAmount")));
				arrValues.add(correctNull((String)hshValues.get("txt_tenor")));
				arrValues.add(strOrgCode);
				if(strCusType.equalsIgnoreCase("N"))
					arrValues.add(strInwardno);
				else
					arrValues.add(str_perappId);
				arrValues.add(correctNull((String)hshValues.get("txt_custFname")));
				arrValues.add(correctNull((String)hshValues.get("sel_martial_status")));
				arrValues.add(correctNull((String)hshValues.get("txtcomcust_mobile")));
				arrValues.add(str_cibilRequired); 
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","insBureaudetails");
				hshQueryValues.put("size","1");					
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			}

						
			if (strAction.equalsIgnoreCase("update")){
				
				strSno = Helper.correctNull((String)hshValues.get("hidBRappno"));
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				if(strCusType.equalsIgnoreCase("N"))
					arrValues.add(strSno);
				else
					arrValues.add(strcbsid);
				arrValues.add(strCusType);
				arrValues.add(correctNull((String)hshValues.get("strUserId")));
				arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
				arrValues.add(strcusName);
				arrValues.add(strDob);
				arrValues.add(strcusGen);
				arrValues.add(str_address1);
				arrValues.add(str_address2);
				arrValues.add(str_city);
				arrValues.add(str_state);
				arrValues.add(str_dist);
				arrValues.add(str_Zip);
				arrValues.add(strPAN);
				arrValues.add(str_country);
				arrValues.add(str_Aadhar);
				arrValues.add(str_Email);
				arrValues.add(correctNull((String)hshValues.get("prd_type2")));
				arrValues.add(correctNull((String)hshValues.get("txt_reqAmount")));
				arrValues.add(correctNull((String)hshValues.get("txt_tenor")));
				arrValues.add(strOrgCode);
				if(strCusType.equalsIgnoreCase("N"))
					arrValues.add(strSno);
				else
					arrValues.add(str_perappId);
				arrValues.add(correctNull((String)hshValues.get("txt_custFname")));
				arrValues.add(correctNull((String)hshValues.get("sel_martial_status")));
				arrValues.add(correctNull((String)hshValues.get("txtcomcust_mobile")));
				arrValues.add(str_cibilRequired); 
				arrValues.add(strSno);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","updBureaudetails");
				hshQueryValues.put("size","1");					
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			}
			
			if (strAction.equalsIgnoreCase("delete")){
				
				strSno = Helper.correctNull((String)hshValues.get("hidBRappno"));
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(Helper.correctNull((String)hshValues.get("strUserId")));
				arrValues.add(strSno);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","delBureaudetails");
				hshQueryValues.put("size","1");					
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			}
			hshValues.put("strInwardno", strInwardno);
			hshValues=getBureauData(hshValues);
			
			
		}
		catch(Exception ce){
			log.error(ce.toString());
 			throw new EJBException("Error in updateBureauData "+ce.toString());
		}
		return hshValues;
		
	}
	
	public String getMaxInwardno(String strSolid)
	{
		String strQuery="";
		ResultSet rs = null;
		String strInwardno = "";
		String strFinancialYear="";
		try
		{	
			if(rs !=null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("getmaxbureau_appno");
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				strInwardno = strSolid +"BR"+ rs.getString(1) ;				
			}
		}
		catch(Exception ce)
		{
			
			throw new EJBException("Error in getMaxInwardno "+ce.toString());
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
		return strInwardno;
	}

	public HashMap  getInwardSearch(HashMap hshValues) 
	{			
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord =new HashMap();
		String areacheckval="",strQuery="";
		String area1="",area2="",area3="",area4="",area5="",glptotlevel="",absPosition="";
		String inward_assignusrid="",strCBSIDflag="",desc="";
		String inward_usrid="",strCategorytype="",str_statuscust="",strCusCBSStatus="",str_statuscompkyc="",str_statuscompincexp="";
		
		try
		{
			strCBSIDflag="N";
			strCategorytype=correctNull((String)hshValues.get("hidCategoryType"));
			String orgSelCode = Helper.correctNull((String)hshValues.get("strOrgSelect"));
			String strUser = correctNull((String) hshValues.get("strUserId"));
			String name=correctNull((String)hshValues.get("search"));
			orgSelCode = orgSelCode+"%"; 
			absPosition = Helper.correctInt((String)hshValues.get("hid_rowcount"));
		 	area1= correctNull((String)hshValues.get("area1"));
			area2= correctNull((String)hshValues.get("area2"));
			area3 = correctNull((String)hshValues.get("area3"));
			area4 = correctNull((String)hshValues.get("area4"));
			area5 = correctNull((String)hshValues.get("area5"));
			String val=correctNull((String)hshValues.get("hidvalue"));
			rs = DBUtils.executeLAPSQuery("glpoption");
			if(rs.next())
			{
				glptotlevel = (String)Helper.correctNull(rs.getString(1));	
			}
			if(rs!=null)
				rs.close();
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
			if(rs1!=null)
				rs1.close();
			if (!areacheckval.equals(""))
			{
				if(val.equals("name"))
				{
					desc="and org_code like ('"+areacheckval+"')";
				}
			}
			
			if(val.equals("name"))
			{
				desc+=" and upper(BUR_FNAME) like upper('%"+name+"%')";
			}
			else if(val.equals("no"))
			{
				desc=" and BUR_APPNO='"+name+"'";
			}
			else if(val.equals("CBSID"))
			{
				desc="and BUR_CBSID='"+name+"'";
			}
			strQuery = SQLParser.getSqlQuery("bur_inwardsearchbyname^"+desc);
			ArrayList arrval =  new ArrayList();
			ArrayList arrdata =  new ArrayList();
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
				arrval =  new ArrayList();
				arrval.add(correctNull(rs.getString("BUR_APPNO")));//0
				arrval.add(correctNull(rs.getString("BUR_CBSID")));//1
				arrval.add(correctNull(rs.getString("BUR_CUSTYPE")));//2
				arrval.add(correctNull(rs.getString("CREATED_USRID")));//3
				if(rs1!=null)
		 			 rs1.close();
				rs1 = DBUtils.executeLAPSQuery("getorgcode^"+correctNull(rs.getString("CREATED_ORG")));
				if(rs1.next())
				{ 
					arrval.add(correctNull(rs1.getString("org_name")));//4
				}
				arrval.add(correctNull(rs.getString("CREATED_DATE")));//5
				arrval.add(correctNull(rs.getString("BUR_FNAME")));//6
				arrval.add(correctNull(rs.getString("BUR_DOB")));//7
				arrval.add(correctNull(rs.getString("BUR_GENDER")));//8
				arrval.add(correctNull(rs.getString("BUR_ADDRESS1")));//9
				arrval.add(correctNull(rs.getString("BUR_ADDRESS2")));//10
				arrval.add(correctNull(rs.getString("BUR_CITY")));//11
				arrval.add(correctNull(rs.getString("BUR_STATE")));//12
				arrval.add(correctNull(rs.getString("BUR_DIST")));//13
				arrval.add(correctNull(rs.getString("BUR_ZIP")));//14
				arrval.add(correctNull(rs.getString("BUR_PANNO")));//15
				arrval.add(correctNull(rs.getString("BUR_COUNTRY")));//16
				arrval.add(correctNull(rs.getString("BUR_AADHAR")));//17
				arrval.add(correctNull(rs.getString("BUR_EMAIL")));//18
				arrval.add(correctNull(rs.getString("BUR_PRDTYPE")));//19
				arrval.add(correctNull(rs.getString("BUR_TENOR")));//20
				arrval.add(correctNull(rs.getString("BUR_ORGCODE")));//21
				arrdata.add(arrval);
			}
			
			hshRecord.put("arrval",arrdata);	
			hshRecord.put("strCBSIDflag",strCBSIDflag);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getInwardnoSearch ::  "+ce.toString());
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
	public HashMap getData(HashMap hshValues) 
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
			hshValues.put("arr",arr);
				
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
		return hshValues;
	}
}
