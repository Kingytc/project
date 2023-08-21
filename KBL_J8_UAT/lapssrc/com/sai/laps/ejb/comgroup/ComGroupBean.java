package com.sai.laps.ejb.comgroup;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.SQLParser;
@Stateless(name = "ComGroupBean", mappedName = "ComGroupHome")
@Remote (ComGroupRemote.class)
public class ComGroupBean extends BeanAdapter
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public  HashMap getData(HashMap hshValues) 
	{		
		String strQuery="";
		ResultSet rs = null;
		String strQuery1="";
		ResultSet rs1 = null;
		String strQuery2="";
		ResultSet rs2 = null;
		String strQuery3="";
		ResultSet rs3 = null;
		String strQuery4="";
		ResultSet rs4 = null;
		String strQuery5="";
		ResultSet rs5 = null;
		ResultSet rs6 = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();
		ArrayList vecVal=new ArrayList();
		ArrayList vecData1 = new ArrayList();
		ArrayList vecVal1=new ArrayList();
		String appno="";	
		if(correctNull((String)hshValues.get("hidpageflag")).equalsIgnoreCase("cgc"))
		{
			appno=	correctNull((String)hshValues.get("num"));
		}
		else
		{
			appno=	correctNull((String)hshValues.get("appno"));
		}
		String strAction = correctNull((String)hshValues.get("hidAction"));
		String strGradeNo= correctNull((String)hshValues.get("selsno"));
		try
		{			
			java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
			jtn.setMaximumFractionDigits(2);
			jtn.setMinimumFractionDigits(2);
			jtn.setGroupingUsed(false);			
			if(strAction.equals("edit"))
			{
				strQuery = SQLParser.getSqlQuery("comgroupselection^"+appno+"^"+strGradeNo);
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("comgroupsel^"+appno);
			}
			rs = DBUtils.executeQuery(strQuery);
	 		while(rs.next())
			{	
				vecVal = new ArrayList();
				vecVal.add(correctNull(rs.getString("com_grpid")));
				vecVal.add(correctNull(rs.getString("com_grpcompname")));
				vecVal.add(correctNull(rs.getString("com_grpcompactivity")));
				vecVal.add(correctNull(rs.getString("com_grpfundbob")));
				vecVal.add(correctNull(rs.getString("com_grpnonfundbob")));
				vecVal.add(correctNull(rs.getString("com_grpfundbased")));
				vecVal.add(correctNull(rs.getString("com_grpnonfundbased")));							
				vecVal.add(correctNull(rs.getString("com_grpremarks")));	
    vecVal.add(correctNull(rs.getString("com_banktype")));
				vecData.add(vecVal);							
			}
			strQuery = SQLParser.getSqlQuery("comgrpsel^"+appno);
			if( rs != null)
			{
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				double wcfundexist=0.00;
				double wcfundprop=0.00;
				double wcnonfundexist=0.00;
				double wcnonfundprop=0.00;
				double tffundprop=0.00;
				double tfnonfundprop=0.00;
				double TotalFund=0.00;
				double TotalNonFund=0.00;				
				String no=correctNull(rs.getString(1));
				String id=correctNull(rs.getString(2));
				strQuery3 = SQLParser.getSqlQuery("comgrpselection^"+id);
				if(rs3!=null)
				{
					rs3.close();
				}
				rs3 = DBUtils.executeQuery(strQuery3);
				if (rs3.next())
				{
					vecVal1 = new ArrayList();
					vecVal1.add(correctNull(rs3.getString(1)));
					vecVal1.add(correctNull(rs3.getString(3)));
				
					strQuery1 = SQLParser.getSqlQuery("comfundtotal^"+no);	
					if(rs1!=null)
					{
						rs1.close();
					}
					rs1 = DBUtils.executeQuery(strQuery1);
					if (rs1.next())
					{	
						vecVal1.add(correctNull(rs1.getString(1)));
						vecVal1.add(correctNull(rs1.getString(2)));
					}					
					strQuery2 = SQLParser.getSqlQuery("comnonfundtotal^"+no);
					if(rs2!=null)
					{
						rs2.close();
					}
					rs2 = DBUtils.executeQuery(strQuery2);
					if (rs2.next())
					{	
						vecVal1.add(correctNull(rs2.getString(1)));
						vecVal1.add(correctNull(rs2.getString(2)));
					}
					strQuery4 = SQLParser.getSqlQuery("comtotalsel^"+no);
					if(rs4!=null)
					{
						rs4.close();
					}
					rs4 = DBUtils.executeQuery(strQuery4);
					if (rs4.next())
					{
						wcfundexist=Double.parseDouble((String)rs4.getString(1));
						wcfundprop=Double.parseDouble((String)rs4.getString(2));
						wcnonfundexist=Double.parseDouble((String)rs4.getString(3));
						wcnonfundprop=Double.parseDouble((String)rs4.getString(4));
					}
					strQuery5= SQLParser.getSqlQuery("termbanksel^"+no);
					if(rs5!=null)
					{
						rs5.close();
					}
					rs5 = DBUtils.executeQuery(strQuery5);
					while(rs5.next())
					{
						if ((String)rs5.getString("tf")!=null)
						{
							tffundprop=tffundprop+Double.parseDouble((String)rs5.getString("tf"));
						}
						if ((String)rs5.getString("tnf")!=null)
						{
							tfnonfundprop=tfnonfundprop+Double.parseDouble((String)rs5.getString("tnf"));
						}																		
					}
					TotalFund=wcfundprop+tffundprop;
					TotalNonFund=wcnonfundprop+tfnonfundprop;
					vecVal1.add(String.valueOf(jtn.format(TotalFund)));
					vecVal1.add(String.valueOf(jtn.format(TotalNonFund)));
				}
				vecData1.add(vecVal1);			
			}			
			hshRecord.put("vecData",vecData);
			hshRecord.put("vecData1",vecData1);			
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
				if(rs2 != null)
				{
					rs2.close();
				}
				if(rs3 != null)
				{
					rs3.close();
				}
				if(rs4 != null)
				{
					rs4.close();
				}
				if(rs5 != null)
				{
					rs5.close();
				}
				if(rs6 != null)
				{
					rs6.close();
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
		String strQuery="";
		ResultSet rs = null;
		int termId = 0;

		try
		{	
			strQuery = SQLParser.getSqlQuery("comgroupmax^"+appno);
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

	public HashMap updateData(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String strGradeId = "";
		String appno=correctNull((String)hshValues.get("num"));
		try
		{
		  if(strAction.equals("update"))
			{
				strGradeId =  correctNull((String )hshValues.get("idno"));				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","2");				
				hshQuery.put("strQueryId","comgroupdel");
				arrValues.add(appno);
				arrValues.add(strGradeId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","comgroupins");
				arrValues.add(appno);
				arrValues.add(strGradeId);
				arrValues.add(correctNull((String )hshValues.get("name")));
				arrValues.add(correctNull((String )hshValues.get("nature")));
				if(!correctNull((String )hshValues.get("fundbob")).trim().equals(""))
				{
					arrValues.add(correctNull((String )hshValues.get("fundbob")));
				}
				else
				{
					arrValues.add("0.00");
				}
				if(!correctNull((String )hshValues.get("nonfundbob")).trim().equals(""))
				{
					arrValues.add(correctNull((String )hshValues.get("nonfundbob")));
				}
				else
				{
					arrValues.add("0.00");
				}
				if(!correctNull((String )hshValues.get("fund")).trim().equals(""))
				{
					arrValues.add(correctNull((String )hshValues.get("fund")));
				}
				else
				{
					arrValues.add("0.00");
				}
			 	if(!correctNull((String )hshValues.get("nonfund")).trim().equals(""))
				{
					arrValues.add(correctNull((String )hshValues.get("nonfund")));
				}
				else
				{
					arrValues.add("0.00");
				}
				arrValues.add(correctNull((String )hshValues.get("remarks")));
 
				if(correctNull((String )hshValues.get("selbankdet")).equals(""))
				{
				arrValues.add("0");
				}
				else
				{
				arrValues.add(correctNull((String )hshValues.get("selbankdet")));
 				}
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equals("insert"))
			{				
				strGradeId = Integer.toString(getMaxGradeId(appno));					
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");				
				
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","comgroupins");
				arrValues.add(appno);
				arrValues.add(strGradeId);
				arrValues.add(correctNull((String )hshValues.get("name")));
				arrValues.add(correctNull((String )hshValues.get("nature")));
				if(!correctNull((String )hshValues.get("fundbob")).trim().equals(""))
				{
					arrValues.add(correctNull((String )hshValues.get("fundbob")));
				}
				else
				{
					arrValues.add("0.00");
				}
				if(!correctNull((String )hshValues.get("nonfundbob")).trim().equals(""))
				{
					arrValues.add(correctNull((String )hshValues.get("nonfundbob")));
				}
				else
				{
					arrValues.add("0.00");
				}

				if(!correctNull((String )hshValues.get("fund")).trim().equals(""))
				{
					arrValues.add(correctNull((String )hshValues.get("fund")));
				}
				else
				{
					arrValues.add("0.00");
				}
				if(!correctNull((String )hshValues.get("nonfund")).trim().equals(""))
				{
					arrValues.add(correctNull((String )hshValues.get("nonfund")));
				}
				else
				{
					arrValues.add("0.00");
				}
 
				arrValues.add(correctNull((String )hshValues.get("remarks")));
				if(correctNull((String )hshValues.get("selbankdet")).equals(""))
						{
					arrValues.add("0");
						}
				else
				{
				arrValues.add(correctNull((String )hshValues.get("selbankdet")));
 			}
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);					
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equals("delete"))
			{
				strGradeId =  correctNull((String )hshValues.get("idno"));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");				
				hshQuery.put("strQueryId","comgroupdel");
				arrValues.add(appno);
				arrValues.add(strGradeId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			HashMap hshRecord = getData(hshValues);			
			return hshRecord;
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
		}
	}
}