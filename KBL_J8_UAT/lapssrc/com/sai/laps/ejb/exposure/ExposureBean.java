package com.sai.laps.ejb.exposure;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import jxl.write.NumberFormat;

import com.sai.fw.management.utils.FwHelper;
import com.sai.laps.ejb.executive.ExecutiveBean;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "ExposureBean", mappedName = "ExposureHome")
@Remote (ExposureRemote.class)
public class ExposureBean extends BeanAdapter
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(ExposureBean.class);

	public HashMap getApplicantList(HashMap hshRequestValues) 
	{
		ResultSet resultset = null;
		HashMap hashtable1 = new HashMap();
		ArrayList arraylist = new ArrayList();
		try 
		{
			String s1 = correctNull((String) hshRequestValues.get("txtvalue"));
			String type = correctNull((String) hshRequestValues.get("srchtype"));
			String cond = new String();
			String strQueryId = new String();
			
			if (type.equalsIgnoreCase("Group")) 
			{
				if (!type.equals("")) 
				{
					cond = "exp_type='" + type + "'";
				}
				if (!s1.equals("")) 
				{
					if (!cond.equals("")) 
					{
						cond = cond + " and upper(exp_desc) LIKE upper('" + s1 + "%')";
					} 
					else
						cond = " upper(exp_desc) LIKE upper('" + s1 + "%')";
				}
				strQueryId = "expconsearch^" + cond;
				String strQuery = SQLParser.getSqlQuery(strQueryId);
				ArrayList arraylist1;
				resultset = DBUtils.executeQuery(strQuery);
				while (resultset.next()) 
				{
					arraylist1 = new ArrayList();
					arraylist1.add(resultset.getString(1));
					arraylist1.add(resultset.getString(2));
					arraylist1.add(resultset.getString(3));
					arraylist.add(arraylist1);
				}
				hashtable1.put("arryRow", arraylist);
			} 
			else if (type.equalsIgnoreCase("Industry")) 
			{
				if (!type.equals("")) 
				{
					cond = "exp_type='" + type + "'";
				}
				if (!s1.equals("")) 
				{
					if (!cond.equals("")) 
					{
						cond = cond + " and upper(exp_desc) LIKE upper('" + s1 + "%')";
					} 
					else
						cond = " upper(exp_desc) LIKE upper('" + s1 + "%')";
				}
				strQueryId = "expconsearch^" + cond;
				String strQuery = SQLParser.getSqlQuery(strQueryId);
				ArrayList arraylist1;
				resultset = DBUtils.executeQuery(strQuery);
				while (resultset.next()) 
				{
					arraylist1 = new ArrayList();
					arraylist1.add(resultset.getString(1));
					arraylist1.add(resultset.getString(2));
					arraylist1.add(resultset.getString(3));
					arraylist.add(arraylist1);
				}
				hashtable1.put("arryRow", arraylist);			
			}
	
		} catch (Exception exception) {
			throw new EJBException("Error in getApplicantList  "+ exception.toString());
		} finally {
			try {
				if (resultset != null)
					resultset.close();
			} catch (Exception exception2) {
				throw new EJBException("Error closing the connection "
						+ exception2.getMessage());
			}
		}
		return hashtable1;
	}
    
	public HashMap getExpData(HashMap hshRequestValues)  
	{
		ResultSet resultset = null;
		HashMap hashtable1 = new HashMap();
		try 
		{
			try 
			{
				String s1 = correctNull((String) hshRequestValues.get("expid"));
				String mode = correctNull((String) hshRequestValues.get("mode"));
				String exptype= correctNull((String) hshRequestValues.get("exp_type"));
				String strindbsrcode=correctNull((String)hshRequestValues.get("hidindcode"));
				if(exptype.equalsIgnoreCase(""))
				{
					exptype= correctNull((String) hshRequestValues.get("exptype"));
				}
				hashtable1 = new HashMap();
				String strQuery="";
				//ArrayList arraylist1 = new ArrayList();
				if(exptype.equalsIgnoreCase("Industry"))
                {
					s1= correctNull((String) hshRequestValues.get("expid"));
					if(s1.equalsIgnoreCase("0"))
					{
						s1= correctNull((String) hshRequestValues.get("hidid"));	
					}
					strQuery = SQLParser.getSqlQuery("selindexp^" + s1+" and exp_type='"+exptype+"'");
				// arraylist1 = new ArrayList();
					resultset = DBUtils.executeQuery(strQuery);
					if (resultset.next()) {
						hashtable1.put("expid",correctNull(resultset.getString("exp_id")));
						hashtable1.put("exptype",correctNull(resultset.getString("exp_type")));
						hashtable1.put("expdesc",correctNull(resultset.getString("exp_desc")));
						hashtable1.put("expmax",correctNull(resultset.getString("exp_maxexp")));
						hashtable1.put("expdate",correctNull(resultset.getString("exp_expirydate")));
						hashtable1.put("expgrp",correctNull(resultset.getString("exp_grpcode")));
						
						/*arraylist1.add(correctNull((String)resultset.getString(1)));
						arraylist1.add(correctNull((String)resultset.getString(2)));
						arraylist1.add(correctNull((String)resultset.getString(3)));
						arraylist1.add(correctNull((String)resultset.getString(4)));
						arraylist1.add(correctNull((String)resultset.getString(5)));*/
					}
					if(resultset!=null)
						resultset.close();
					if(!strindbsrcode.equalsIgnoreCase(""))
					{
						strQuery=SQLParser.getSqlQuery("selindustrynamebyindno^"+strindbsrcode);
						resultset = DBUtils.executeQuery(strQuery);
						if(resultset.next())
						{
							hashtable1.put("expbsrdesc",correctNull(resultset.getString("ind_name")));
							hashtable1.put("expbsrmaxexp",correctNull(resultset.getString("ind_exposure")));
							hashtable1.put("expbsrexpirydate",correctNull(resultset.getString("ind_exp_expirydate")));
							hashtable1.put("expindcode",correctNull(resultset.getString("ind_no")));
							hashtable1.put("expbsrcode",correctNull(resultset.getString("ind_bsr_code")));
						}
					}
					//hashtable1.put("arryRow", arraylist1);
					hashtable1.put("exptype", exptype);
				}
                if(exptype.equalsIgnoreCase("Group"))
                {
				//if (!s1.equalsIgnoreCase("")) 
			//	{
					if (mode.equalsIgnoreCase("Insert")) 
					{
						strQuery = SQLParser.getSqlQuery("maxexposuregroup");
						resultset = DBUtils.executeQuery(strQuery);
						if (resultset.next()) 
						{
							s1 = resultset.getString(1);
						}
					}
				//}
				 
				strQuery = SQLParser.getSqlQuery("selexposure^" + s1+" and exp_type='"+exptype+"'");
				//arraylist1 = new ArrayList();
				resultset = DBUtils.executeQuery(strQuery);
				while (resultset.next()) 
				{
					hashtable1.put("expid",correctNull(resultset.getString("exp_id")));
					hashtable1.put("exptype",correctNull(resultset.getString("exp_type")));
					hashtable1.put("expdesc",correctNull(resultset.getString("exp_desc")));
					hashtable1.put("expmax",correctNull(resultset.getString("exp_maxexp")));
					hashtable1.put("expdate",correctNull(resultset.getString("exp_expirydate")));
					hashtable1.put("exp_panno",correctNull(resultset.getString("exp_panno")));
					hashtable1.put("exp_groupborr",correctNull(resultset.getString("exp_groupborr")));
					
					/*arraylist1.add(resultset.getString(1));
						arraylist1.add(resultset.getString(2));
						arraylist1.add(resultset.getString(3));
						arraylist1.add(resultset.getString(4));
						arraylist1.add(resultset.getString(5));*/
					}
					//hashtable1.put("arryRow", arraylist1);
					hashtable1.put("exptype", exptype);
				
				}            	
			} 
			catch (Exception exception) 
			{
				throw new EJBException("Error in getData login  "
						+ exception.toString());
			}
		} 
		catch (Exception exception) 
		{
			throw new EJBException("Error in getData login  "
					+ exception.toString());
		} 
		finally
		{
			try 
			{
				if (resultset != null)
					resultset.close();

			} 
				catch (Exception exception2) 
			{
				throw new EJBException("Error closing the connection "
						+ exception2.getMessage());
			}
		}
		return hashtable1;
	}

	public void updateExp(HashMap hashtable)  
	{
		ResultSet resultset = null;
		HashMap hashtable1 = null;
		HashMap hashtable2 = null;
		ArrayList arraylist = new ArrayList();
		String strKeyId="";
		try {
			try {
				hashtable1 = new HashMap();
				strKeyId = Helper.correctNull((String)hashtable.get("hidkeyid"));
				String strexpid = correctNull((String) hashtable.get("expid"));
				String strExptype = correctNull((String) hashtable.get("exp_type"));
				if(strExptype.equalsIgnoreCase("")){
					strExptype = correctNull((String) hashtable.get("exptype"));
				}
				String strExpdesc = correctNull((String) hashtable.get("exp_desc"));
				String strExpmaxexp = correctNull((String) hashtable.get("exp_maxexp"));
				String strExpirydate = correctNull((String) hashtable.get("exp_expirydate"));
				String mode = correctNull((String) hashtable.get("mode"));
				//String hidid=correctNull((String) hashtable.get("hidid"));
				
				String strbsrindcode=correctNull((String) hashtable.get("hidindcode"));
				String strbsrmaxexp=correctNull((String) hashtable.get("exp_bsrmaxexp"));
				String strbsrexpirydate=correctNull((String) hashtable.get("exp_bsrexpirydate"));
				String txt_bsrcode=correctNull((String) hashtable.get("txt_bsrcode"));
				String txt_grpcode=correctNull((String) hashtable.get("txt_grpcode"));
				String txt_panno=correctNull((String) hashtable.get("txt_panno"));
				String txt_grpborr=correctNull((String) hashtable.get("txt_borrowername"));
				
				String size = "1",strIECheck="no";
				int expid = 0;
				hashtable1.put("size", size);
				hashtable2 = new HashMap();
				StringBuilder sbOldData=new StringBuilder();
				java.text.NumberFormat nf=java.text.NumberFormat.getInstance();
				nf.setMaximumFractionDigits(2);
				nf.setMinimumFractionDigits(2);
				if(strExptype.equalsIgnoreCase("Group") || 
						(strExptype.equalsIgnoreCase("Industry") &&	strbsrindcode.equalsIgnoreCase("")))
				{
					if (mode.equalsIgnoreCase("update")||mode.equalsIgnoreCase("delete")) {
					resultset=DBUtils.executeLAPSQuery("sel_exposure_audit^"+strexpid+"^ and exp_type='"+strExptype+"'");
					if(resultset.next())
					{
						//update
						sbOldData.append(" ~Type=").append(strExptype);
						sbOldData.append(" ~Description=").append(correctNull((String)resultset.getString("exp_desc")));
						sbOldData.append(" ~Maximum Exposure Limit Rs=").append(nf.format(FwHelper.parseDouble(Helper.correctDouble((String)resultset.getString("exp_maxexp")))));
						sbOldData.append(" ~Expiry Date=").append(correctNull((String)resultset.getString("exp_expirydate")));
					}
					}
				}
				else 
				{
					if (mode.equalsIgnoreCase("update")||mode.equalsIgnoreCase("delete")) {
					resultset=DBUtils.executeLAPSQuery("sel_exposure_bsr_audit^"+strexpid+"^"+strbsrindcode+"^"+strExptype);
					if(resultset.next())
					{
						//update
						sbOldData.append(" ~Type=").append(strExptype);
						sbOldData.append(" ~Description=").append(correctNull((String)resultset.getString("exp_desc")));
						sbOldData.append(" ~Maximum Exposure Limit Rs=").append(nf.format(FwHelper.parseDouble(Helper.correctDouble((String)resultset.getString("exp_maxexp")))));
						sbOldData.append(" ~Expiry Date=").append(correctNull((String)resultset.getString("exp_expirydate")));
						sbOldData.append(" ~BSR CODE=").append(Helper.correctNull((String)resultset.getString("ind_name")));
						sbOldData.append(" ~Maximum Exposure Limit=").append(nf.format(FwHelper.parseDouble(Helper.correctDouble((String)resultset.getString("ind_exposure")))));
						sbOldData.append(" ~Expiry Date=").append(Helper.correctNull((String)resultset.getString("ind_exp_expirydate")));
					}
					}
				}

				if (mode.equalsIgnoreCase("Insert") && checkAvailIndGrp(hashtable)) 
				{
				    if(strExptype.equalsIgnoreCase("Group"))
					{
						String strQuery = SQLParser.getSqlQuery("maxexposuregroup");	
						resultset = DBUtils.executeQuery(strQuery);
						
								if (resultset.next()) 
								{
									expid = Integer.parseInt(resultset.getString(1));
								}
								if (expid == 0) 
								{
									expid = 1;
								} 
								else 
								{
									expid = expid + 1;
								}
					}
				    if(strExptype.equalsIgnoreCase("Industry"))
				    {
				       	expid=Integer.parseInt(strexpid);	
					}
				    if(strExptype.equalsIgnoreCase("Group") || (strExptype.equalsIgnoreCase("Industry") && strbsrindcode.equalsIgnoreCase("")))
				    {
				    	hashtable2.put("strQueryId", "exposureins");
						arraylist.add(Integer.toString(expid));
						arraylist.add(strExptype);
						arraylist.add(strExpdesc);
						arraylist.add(strExpmaxexp);
						arraylist.add(strExpirydate);
						arraylist.add(txt_panno);
						arraylist.add(txt_grpborr);
						hashtable2.put("arrValues", arraylist);
				    }
				    else
				    {
				    	hashtable2.put("strQueryId", "bsrexpupd");
						arraylist.add(strbsrmaxexp);
						arraylist.add(strbsrexpirydate);
						arraylist.add(strbsrindcode);
						hashtable2.put("arrValues", arraylist);
				    }
					
				} 
				else if (mode.equalsIgnoreCase("update")) 
				{		
					
					if(strExptype.equalsIgnoreCase("Industry"))
					{
						if(strbsrindcode.equalsIgnoreCase(""))
						{
							hashtable2.put("strQueryId", "exposuredel");
							arraylist.add(strexpid);
							hashtable2.put("arrValues", arraylist);
							hashtable1.put(Integer.toString(1), hashtable2);
							EJBInvoker.executeStateLess("dataaccess", hashtable1,"updateData");
				       	
							arraylist = new ArrayList();
							hashtable2 = new HashMap();
							
							hashtable2.put("strQueryId", "exposureins");
							arraylist.add(strexpid);
							arraylist.add(strExptype);
							arraylist.add(strExpdesc);
							arraylist.add(strExpmaxexp);
							arraylist.add(strExpirydate);
							arraylist.add(txt_panno);
							arraylist.add(txt_grpborr);
							hashtable2.put("arrValues", arraylist);
						}
						else
					    {
					    	hashtable2.put("strQueryId", "bsrexpupd");
							arraylist.add(strbsrmaxexp);
							arraylist.add(strbsrexpirydate);
							arraylist.add(strbsrindcode);
							hashtable2.put("arrValues", arraylist);
					    }
						
					}
					else
					{
						hashtable2.put("strQueryId", "exposureupd");
						arraylist.add(strExptype);
						arraylist.add(strExpdesc);
						arraylist.add(strExpmaxexp);
						arraylist.add(strExpirydate);
						arraylist.add(strexpid);
						arraylist.add(txt_panno);
						arraylist.add(txt_grpborr);
						hashtable2.put("arrValues", arraylist);
					}
				
				} 
				else if (mode.equalsIgnoreCase("delete")) 
				{
					hashtable2.put("strQueryId", "exposuredel");
					arraylist.add(strexpid);
					hashtable2.put("arrValues", arraylist);
				}

				hashtable1.put(Integer.toString(1), hashtable2);
				hashtable1.put("expid",Integer.toString(expid));
				if(strExptype.equalsIgnoreCase("Industry") && !strbsrindcode.equalsIgnoreCase(""))
				{
					String strQuery = SQLParser.getSqlQuery("selindustrynamebyindno^"+strbsrindcode);	
					resultset = DBUtils.executeQuery(strQuery);
					if (resultset.next()) 
					{
						strIECheck = correctNull(resultset.getString("ind_exposure"));
						if (strIECheck.equalsIgnoreCase("")) 
							hashtable.put("hidAction","Insert");
						else
							hashtable.put("hidAction",mode);
					}
				}
				else
					hashtable.put("hidAction",mode);
				EJBInvoker.executeStateLess("dataaccess", hashtable1,"updateData");
				
				
				//AUDIT TRIAL:
				StringBuilder sbAt = new StringBuilder();
				if (!mode.equalsIgnoreCase("delete")) {
						String strType=correctNull(correctNull((String)hashtable.get("exptype")));
						if(strType.equals(""))strType=correctNull(correctNull((String)hashtable.get("exp_type")));
						sbAt.append(" ~Type=").append(strType);
						sbAt.append(" ~Description=").append(correctNull((String)hashtable.get("exp_desc")));
						sbAt.append(" ~Maximum Exposure Limit Rs=").append(correctNull((String)hashtable.get("exp_maxexp")));
						sbAt.append(" ~Expiry Date=").append(correctNull((String)hashtable.get("exp_expirydate")));
						if(!strbsrindcode.equalsIgnoreCase(""))
						{
							sbAt.append(" ~BSR CODE=").append(Helper.correctNull((String)hashtable.get("exp_bsrdesc")));
							sbAt.append(" ~Maximum Exposure Limit=").append(nf.format(FwHelper.parseDouble(Helper.correctDouble(strbsrmaxexp))));
							sbAt.append(" ~Expiry Date=").append(strbsrexpirydate);
						}
				}
				//AuditTrial.auditLog(hashtable, "111", strexpid, sbAt.toString());
				AuditTrial.auditNewLog(hashtable,"111",strKeyId,sbAt.toString(),sbOldData.toString());
				
				
				
				} 
			catch (Exception exception) 
			{
				throw new EJBException("Error in updateData login  "
						+ exception.toString());
			}
		} 
		catch (Exception exception) 
		{
			throw new EJBException("Error in updateData login  "
					+ exception.toString());
		} 
		finally
		{
			try 
			{
				if (resultset != null)
					resultset.close();

			} 
				catch (Exception exception2) 
			{
				throw new EJBException("Error closing the connection "+ exception2.getMessage());
			}
		}
	}


	public HashMap showGroup(HashMap hashtable) 
	{		
        ResultSet resultset = null;
		HashMap hashtable1 = new HashMap();
        ArrayList arry = new ArrayList();
        ArrayList arry1 = new ArrayList();
		
		try
		{
			String strQuery=SQLParser.getSqlQuery("showgrouplist^" + "Group");
			
			resultset = DBUtils.executeQuery(strQuery);
			while(resultset.next())
			{
				arry.add(resultset.getString(1));
				arry1.add(resultset.getString(2));
			}
			hashtable1.put("arry", arry);
			hashtable1.put("arry1", arry1);
        }
		catch(Exception exception)
		{
			throw new EJBException("Error in getgrouplist  " + exception.toString());
		}
        finally
        {
            try
            {
                if(resultset != null)
                    resultset.close();
                
            }
            catch(Exception exception2)
            {
                throw new EJBException("Error closing the connection " + exception2.getMessage());
            }
        }
		return hashtable1;
	}

	
	public HashMap showIndustry(HashMap hashtable) 
	{		
        ResultSet resultset = null;
		HashMap hashtable1 = new HashMap();
        ArrayList arry = new ArrayList();
        ArrayList arr = null;
		
		try
		{
			String strQuery=SQLParser.getSqlQuery("showindustrylist");			
			resultset = DBUtils.executeQuery(strQuery);
			while(resultset.next())
			{
				arr = new ArrayList();
				arr.add(correctNull((String)resultset.getString(1)));
				arr.add(correctNull((String)resultset.getString(2)));
				arry.add(arr);
			}
			hashtable1.put("arryRow", arry);
        }
		catch(Exception exception)
		{
			throw new EJBException("Error in getindustrylist  " + exception.toString());
		}
        finally
        {
            try
            {
                if(resultset != null)
                    resultset.close();
                
            }
            catch(Exception exception2)
            {
                throw new EJBException("Error closing the connection " + exception2.getMessage());
            }
        }
		return hashtable1;
	}
	
	private boolean checkAvailIndGrp(HashMap hshMap)
	{
		boolean result=true;
		ResultSet rs=null;
		String strQuery=null;
		String strExposuretype=correctNull((String)hshMap.get("exp_type"));
		String strExp ="$";
		
		try
		{
			if(strExposuretype.equalsIgnoreCase("Industry"))
			{
				String strExpid=correctNull((String) hshMap.get("expid"));
				strQuery=SQLParser.getSqlQuery("expconsearch^ exp_id="+strExpid + " and exp_type='"+strExposuretype+"'");
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strExp = strExp+"Exposure for the Industry Already Defined";
					result=false;
					throw new Exception(strExp);
				}
				
			
			}
			else
			{
				String strexpdesc=correctNull((String) hshMap.get("exp_desc"));
				strQuery=SQLParser.getSqlQuery("expconsearch^ upper(exp_desc)=upper('"+strexpdesc+"') and exp_type='"+strExposuretype+"'");
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strExp = strExp+"Exposure for the Group Already Defined";
					result=false;
					throw new Exception(strExp);
				}
			}
			if(rs!=null)
				rs.close();
		}
		catch(Exception ex)
		{
			throw new EJBException("Error in Checking the availability of Industry Group"+ex.toString());
		}
		finally
		{
			try{
				if(rs!=null)
					rs.close();
			}catch(Exception ex)
			{
				throw new EJBException("Error in closing Conenction :: "+ex.getMessage());
			}
		}
		
		return result;
	}
	
	
	public void updateConsExp(HashMap hshMap) 
	{
		String strAction="";
		ArrayList arrValues=new ArrayList();
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		int intUpdatesize=0;
		String strKeyId = "";
		StringBuilder sbAt=new StringBuilder();
		StringBuilder sbolddata = new StringBuilder();
		ResultSet rs = null;
		try 
		{
			strAction=correctNull((String)hshMap.get("hidAction"));
			strKeyId = Helper.correctNull((String)hshMap.get("hidkeyid"));
			if(strAction.equalsIgnoreCase("Insert") || strAction.equalsIgnoreCase("Delete"))
			{
				rs = DBUtils.executeLAPSQuery("sel_con_exposure_audit^"+Helper.correctNull((String)hshMap.get("seltype"))+"^"
						+Helper.correctNull((String)hshMap.get("selconstitution")));
				if(rs.next())
				{
					String strExpFor1 = Helper.correctNull((String)rs.getString("exp_type"));
					sbolddata.append("~ Exposure For = ");
					if(strExpFor1.equalsIgnoreCase("S"))sbolddata.append("Select");
					else if(strExpFor1.equalsIgnoreCase("N")) sbolddata.append("New");
					else if(strExpFor1.equalsIgnoreCase("E")) sbolddata.append("Existing");
					sbolddata.append("~ Constituition = "+Helper.correctNull((String)hshMap.get("hidconstituition")));
					if(Helper.correctNull((String)rs.getString("EXP_CONSTITUTION")).equalsIgnoreCase("005"))
					{
						sbolddata.append("~ Public Type = ");
						if(Helper.correctNull((String)rs.getString("EXP_PUBLICTYPE")).equalsIgnoreCase("S"))
						{
							sbolddata.append("Select");
						}
						else if(Helper.correctNull((String)rs.getString("EXP_PUBLICTYPE")).equalsIgnoreCase("C"))
						{
							sbolddata.append("Closely Held");
						}
						else if(Helper.correctNull((String)rs.getString("EXP_PUBLICTYPE")).equalsIgnoreCase("W"))
						{
							sbolddata.append("Widely Held");
						}
					}
					sbolddata.append("~ Maximum Exposure Limit in (Rs in Crores) = "+Helper.correctNull((String)rs.getString("exp_maxlimit")));
				}
				if(rs!=null)
				rs.close();
			}
			if(strAction.equalsIgnoreCase("Insert"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				intUpdatesize++;
				hshQuery.put("strQueryId","delconsexp");
				arrValues.add(correctNull((String)hshMap.get("seltype")));
				arrValues.add(correctNull((String)hshMap.get("selconstitution")));
				arrValues.add(correctNull((String)hshMap.get("selpublictype")).equalsIgnoreCase("")?"S":correctNull((String)hshMap.get("selpublictype")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);	
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				intUpdatesize++;
				hshQuery.put("strQueryId","insconsexp");
				arrValues.add(correctNull((String)hshMap.get("seltype")));
				arrValues.add(correctNull((String)hshMap.get("selconstitution")));
				arrValues.add(correctNull((String)hshMap.get("selpublictype")).equalsIgnoreCase("")?"S":correctNull((String)hshMap.get("selpublictype")));
				arrValues.add(correctNull((String)hshMap.get("txt_maxexp")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);	
			}
			else if(strAction.equalsIgnoreCase("Delete"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				intUpdatesize++;
				hshQuery.put("strQueryId","delconsexp");
				arrValues.add(correctNull((String)hshMap.get("seltype")));
				arrValues.add(correctNull((String)hshMap.get("selconstitution")));
				arrValues.add(correctNull((String)hshMap.get("selpublictype")).equalsIgnoreCase("")?"S":correctNull((String)hshMap.get("selpublictype")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);	
			}
			hshQueryValues.put("size",""+intUpdatesize);	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			sbAt = new StringBuilder();
			if(strAction.equalsIgnoreCase("Insert") || strAction.equalsIgnoreCase("Update"))
			{
			String strExpFor = Helper.correctNull((String)hshMap.get("seltype"));
			sbAt.append("~ Exposure For = ");
			if(strExpFor.equalsIgnoreCase("S")) sbAt.append("Select");
			else if(strExpFor.equalsIgnoreCase("N")) sbAt.append("New");
			else if(strExpFor.equalsIgnoreCase("E")) sbAt.append("Existing");
			sbAt.append("~ Constituition = "+Helper.correctNull((String)hshMap.get("hidconstituition")));
			if(Helper.correctNull((String)hshMap.get("selconstituition")).equalsIgnoreCase("005"))
			{
				sbAt.append("~ Public Type = ");
				if(Helper.correctNull((String)hshMap.get("selpublictype")).equalsIgnoreCase("S"))
				{
					sbAt.append("Select");
				}
				else if(Helper.correctNull((String)hshMap.get("selpublictype")).equalsIgnoreCase("C"))
				{
					sbAt.append("Closely Held");
				}
				else if(Helper.correctNull((String)hshMap.get("selpublictype")).equalsIgnoreCase("W"))
				{
					sbAt.append("Widely Held");
				}
			}
			sbAt.append("~ Maximum Exposure Limit in (Rs in Crores) = "+Helper.correctNull((String)hshMap.get("txt_maxexp")));
			}
			if(Helper.correctNull((String)hshMap.get("radiobutton")).equalsIgnoreCase("radiobutton")
					&& (strAction.equalsIgnoreCase("Insert")))
			{
				hshMap.put("hidAction", "Update");
			}
			AuditTrial.auditNewLog(hshMap,"357",strKeyId,sbAt.toString(),sbolddata.toString());
		} 
		catch (Exception exception) 
		{
			throw new EJBException("Error in updateData login  "
					+ exception.toString());
		}
	}
	
	public HashMap getConsExp(HashMap hshMap) 
	{
		String strQuery="";
		ResultSet rs=null;
		HashMap hshRecord=new HashMap();
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol= new ArrayList();
		
		try {
			strQuery=SQLParser.getSqlQuery("selconsexp");
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol= new ArrayList();
				arrCol.add(correctNull(rs.getString("exp_type")));
				arrCol.add(correctNull(rs.getString("exp_constitution")));
				arrCol.add(correctNull(rs.getString("exp_publictype")));
				arrCol.add(correctNull(rs.getString("exp_maxlimit")));
				arrCol.add(correctNull(rs.getString("constitution")));
				arrRow.add(arrCol);
			}
			hshRecord.put("arrRow",arrRow);
		} 
		catch (Exception exception) 
		{
			throw new EJBException("Error in updateData login  "
					+ exception.toString());
		}
		
	return hshRecord;
	}

}