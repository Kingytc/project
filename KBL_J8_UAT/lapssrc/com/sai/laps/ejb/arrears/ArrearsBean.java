package com.sai.laps.ejb.arrears;

import java.io.ByteArrayOutputStream;
import java.sql.Blob;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;


@Stateless(name = "ArrearsBean", mappedName = "ArrearsHome")
@Remote (ArrearsRemote.class)
public class ArrearsBean extends BeanAdapter
{	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(ArrearsBean.class);	
	
	public HashMap UpdateArrearsData(HashMap hshValues) 
	{					
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshRecord =new HashMap();
		ArrayList arrValues=new ArrayList();
		String appno="";		
		try
		{
			StringBuilder sbAt = new StringBuilder();
			if(correctNull((String)hshValues.get("hidappno"))=="")
			{
				appno = correctNull((String) hshValues.get("appno"));
			}
			else
			{
				appno = correctNull((String) hshValues.get("hidappno"));
			}
			String incometax=Helper.correctNull((String)hshValues.get("incometax"));
			String salestax= Helper.correctNull((String)hshValues.get("salestax"));
			String provfund= Helper.correctNull((String)hshValues.get("provfund"));
			String empstateic= Helper.correctNull((String)hshValues.get("empstateic"));
			String others= Helper.correctNull((String)hshValues.get("others"));
			String othernew=Helper.correctNull((String)hshValues.get("othernew"));
			String myAction=Helper.correctNull((String)hshValues.get("hidVal"));					
		
			if(myAction.equals("Edit"))
			{
				hshQueryValues = new HashMap();
				hshQueryValues.put("size","4");	
				hshQuery = new HashMap();	
				arrValues=new ArrayList();				
				hshQuery.put("strQueryId","ArrearsDel");	
				arrValues.add(appno);								
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQuery = new HashMap();	
				arrValues=new ArrayList();				
				hshQuery.put("strQueryId","ArrearsIns");	
				arrValues.add(appno);
				arrValues.add(incometax);
				arrValues.add(salestax);
				arrValues.add(provfund);
				arrValues.add(empstateic);
				arrValues.add(others);	
				arrValues.add(othernew);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);				
				hshQuery = new HashMap();		
				arrValues=new ArrayList();				
				hshQuery.put("strQueryId","ArrearsMonthsDel");	
				arrValues.add(appno);								
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("3",hshQuery);	
				hshQuery = new HashMap();	
				arrValues=new ArrayList();				
				hshQuery.put("strQueryId","ArrearsMonthsIns");	
				arrValues.add(appno);
				arrValues.add(correctNull((String)hshValues.get("jan")));
				arrValues.add(correctNull((String)hshValues.get("feb")));
				arrValues.add(correctNull((String)hshValues.get("mar")));
				arrValues.add(correctNull((String)hshValues.get("apr")));
				arrValues.add(correctNull((String)hshValues.get("may")));
				arrValues.add(correctNull((String)hshValues.get("jun")));
				arrValues.add(correctNull((String)hshValues.get("jul")));
				arrValues.add(correctNull((String)hshValues.get("aug")));
				arrValues.add(correctNull((String)hshValues.get("sep")));
				arrValues.add(correctNull((String)hshValues.get("oct")));
				arrValues.add(correctNull((String)hshValues.get("nov")));
				arrValues.add(correctNull((String)hshValues.get("dec")));				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("4",hshQuery);					
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");				
			}			
			if(myAction.equals("Delete"))	
			{
				if(!incometax.equals(""))
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","ArrearsDel");
					arrValues.add(appno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");

					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","ArrearsMonthsDel");
					arrValues.add(appno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
		    }
			//---------------------------------------------AuditTrial--------------------------------
			if(!myAction.equals("Delete"))	{
			sbAt.append("Arrears in Statutory Payments (if any) (Rs.)^");
			sbAt.append("~Income Tax = ").append(incometax).append(
			"~Sales Tax = ").append(salestax).append(
			"~Provident Fund = ").append(provfund).append(
			"~Employees State Insurance Corporation = ").append(empstateic).append(
			"~Others(specify) = ").append(othernew);	
			sbAt.append("~Monthly Turnover for Last Twelve Months (Rs.)^");
			sbAt.append("~January = ").append(correctNull((String)hshValues.get("jan"))).append(
			"~February = ").append(correctNull((String)hshValues.get("feb"))).append(
			"~March = ").append(correctNull((String)hshValues.get("mar"))).append(
			"~April = ").append(correctNull((String)hshValues.get("apr"))).append(
			"~May = ").append(correctNull((String)hshValues.get("may"))).append(
			"~June = ").append(correctNull((String)hshValues.get("jun"))).append(
			"~July = ").append(correctNull((String)hshValues.get("jul"))).append(
			"~August = ").append(correctNull((String)hshValues.get("aug"))).append(
			"~September = ").append(correctNull((String)hshValues.get("sep"))).append(
			"~October = ").append(correctNull((String)hshValues.get("oct"))).append(
			"~November = ").append(correctNull((String)hshValues.get("nov"))).append(
			"~December = ").append(correctNull((String)hshValues.get("dec")));
			}
			if(Helper.correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("Y"))	
				hshValues.put("hidAction","update");
			else if(Helper.correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("N"))
				hshValues.put("hidAction","Insert");
			else
				hshValues.put("hidAction","Delete");
			AuditTrial.auditLog(hshValues,"172",appno,sbAt.toString());			
			//-------------------------------------------------End-----------------------------------
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
		}		
		hshRecord=getData(hshValues);
		return hshRecord;
	}

	public HashMap getData(HashMap hshValues) 
	{
		HashMap hshRecord = new HashMap();	
		HashMap hsh1 = new HashMap();
		HashMap hsh2 = new HashMap();
		HashMap hsh3 = new HashMap();
		HashMap hsh4 = new HashMap();
		HashMap hsh5 = new HashMap();		
		String strMethodName="";
		String strOtherMethodName="";
		String appno="";
		String strQuery="";
		ResultSet rs = null;	
		try
		{	
			strMethodName = correctNull((String)hshValues.get("hidMethod"));
			strOtherMethodName = correctNull((String)hshValues.get("hidOtherMethod"));
			if(strOtherMethodName.equals("getSSIProductData"))
			{
				hsh1 = (HashMap)getSSIProductData(hshValues);
				
			}
			hshRecord.put("hsh1",hsh1);
			if(strOtherMethodName.equals("getSSIExistProposedData"))
			{
				hsh3 = (HashMap)getSSIExistProposedData(hshValues);
				hshRecord.put("hsh3",hsh3);
			}
			if(strOtherMethodName.equals("getProductInformData"))
			{
				hsh4 = (HashMap)getProductInformData(hshValues);
				hshRecord.put("hsh4",hsh4);
			}
			if(strOtherMethodName.equals("getSourcesOfFundsData"))
			{
				hsh5 = (HashMap)getSourcesOfFundsData(hshValues);
				hshRecord.put("hsh5",hsh5);
			}
			if(strMethodName.equals("getGeneralData"))
			{
				hsh2 = (HashMap)getGeneralData(hshValues);
			}
			hshRecord.put("hsh2",hsh2);
			String recordflag = "N";
			if(strOtherMethodName.equals("hidGetData"))
			{
				if(correctNull((String)hshValues.get("hidappno"))=="")
				{
					appno = correctNull((String) hshValues.get("appno"));
				}
				else
				{
					appno = correctNull((String) hshValues.get("hidappno"));
				}
				strQuery=SQLParser.getSqlQuery("ArrearsSel^"+appno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{	
					recordflag="Y";
					hshRecord.put("incometax",correctNull(rs.getString("comp_incometaxarr")));			
					hshRecord.put("salestax",correctNull(rs.getString("comp_salestaxarr")));	
					hshRecord.put("provfund",correctNull(rs.getString("comp_pfarr")));	
					hshRecord.put("empstateic",correctNull(rs.getString("comp_esiarr")));	
					hshRecord.put("others",correctNull(rs.getString("comp_others")));
					hshRecord.put("othernew",correctNull(rs.getString("comp_othernew")));
				}			
				strQuery=SQLParser.getSqlQuery("ArrearsMonthsSel^"+appno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{	
					recordflag="Y";
					hshRecord.put("jan",correctNull(rs.getString("ssi_january")));
					hshRecord.put("feb",correctNull(rs.getString("ssi_february")));
					hshRecord.put("mar",correctNull(rs.getString("ssi_march")));
					hshRecord.put("apr",correctNull(rs.getString("ssi_april")));
					hshRecord.put("may",correctNull(rs.getString("ssi_may")));
					hshRecord.put("jun",correctNull(rs.getString("ssi_june")));
					hshRecord.put("jul",correctNull(rs.getString("ssi_july")));
					hshRecord.put("aug",correctNull(rs.getString("ssi_august")));
					hshRecord.put("sep",correctNull(rs.getString("ssi_september")));
					hshRecord.put("oct",correctNull(rs.getString("ssi_october")));
					hshRecord.put("nov",correctNull(rs.getString("ssi_november")));
					hshRecord.put("dec",correctNull(rs.getString("ssi_december")));							
				}
				else
				{
					hshRecord.put("jan","0.00");
					hshRecord.put("feb","0.00");
					hshRecord.put("mar","0.00");
					hshRecord.put("apr","0.00");
					hshRecord.put("may","0.00");
					hshRecord.put("jun","0.00");
					hshRecord.put("jul","0.00");
					hshRecord.put("aug","0.00");
					hshRecord.put("sep","0.00");
					hshRecord.put("oct","0.00");
					hshRecord.put("nov","0.00");
					hshRecord.put("dec","0.00");	
				}
			}	
			hshRecord.put("comapp_id",correctNull((String)hshValues.get("comapp_id")));
			hshRecord.put("hidPageType",correctNull((String)hshValues.get("hidPageType")));
			hshRecord.put("hidCategoryType",correctNull((String)hshValues.get("hidCategoryType")));
			hshRecord.put("hidSSIType",correctNull((String)hshValues.get("hidSSIType")));
			hshRecord.put("recordflag",recordflag);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getExpData "+ce.toString());
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

	private HashMap getGeneralData(HashMap hshRequestValues)
	{
		ResultSet rs = null;
		ArrayList vecRow = new ArrayList();
		ArrayList vecCol =new ArrayList();
		HashMap hshRecord = new HashMap();		
		String strQuery="";
		String strAppno="";
		String strTabName="";
		String strParam="";
		String strTemp ="";
		int i =0;
		Blob b = null;
		byte[] aBlob = null;
		
		try
		{
			if(correctNull((String)hshRequestValues.get("hidappno"))=="")
			{
				strAppno = correctNull((String)hshRequestValues.get("appno"));
			}
			else
			{
				strAppno = correctNull((String)hshRequestValues.get("hidappno"));
			}
			strTabName = correctNull((String)hshRequestValues.get("hidTabName"));
			strParam= correctNull((String)hshRequestValues.get("hidparam"));
			StringTokenizer strToken = new StringTokenizer(strParam,"^");
			strTemp="(";

			while (strToken.hasMoreTokens())
			{	
				strTemp = strTemp+" trim(ssi_gendesc) like '"+(String)strToken.nextToken()+"' or";
			}
			strTemp =strTemp.substring(0,(strTemp.length())-3);			
			strTemp = strTemp+")";
			
			ByteArrayOutputStream bios=new ByteArrayOutputStream();
			
			strQuery = SQLParser.getSqlQuery("ssiGeneralSelQueries^"+strAppno+"^"+strTabName+"^"+strTemp);
			rs = DBUtils.executeQuery(strQuery);
			
			while (rs.next())
			{ 
				vecCol = new ArrayList();
				for (i=0;i<2;i++ )
				{	
					b=null;
					aBlob = null;	
					bios=new ByteArrayOutputStream();					
						
					b = rs.getBlob("ssi_genvalue");
					aBlob = b.getBytes(0, (int) b.length());			
					bios.write(aBlob);
					bios.flush();
					vecCol.add(bios.toString());	
					bios.close();
				}
				vecRow.add(vecCol);
			}
			hshRecord.put("vecRow",vecRow);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getGeneralDetails   "+ce.toString());
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
		return hshRecord;
	}

	private HashMap getSSIProductData(HashMap hshValues) 
	{
		String strQuery="";
		ResultSet rs=null;		
		HashMap hshRecord = new HashMap();
		ArrayList vecVal = new ArrayList();
		ArrayList vecRec= new ArrayList();
		String appno="";
		String recordflag = "N";
		try
		{			
			if(correctNull((String)hshValues.get("hidappno"))=="")
			{
				appno = correctNull((String) hshValues.get("appno"));
			}
			else
			{
				appno = correctNull((String) hshValues.get("hidappno"));
			}
			strQuery = SQLParser.getSqlQuery("ssiProductSel^"+appno);
			rs=DBUtils.executeQuery(strQuery);			
			while(rs.next())
			{
				vecRec = new ArrayList();				
				vecRec.add(correctNull(rs.getString(1)));
				vecRec.add(correctNull(rs.getString(2)));
				vecRec.add(correctNull(rs.getString(3)));
				vecRec.add(correctNull(rs.getString(4)));
				vecRec.add(correctNull(rs.getString(5)));
				vecRec.add(correctNull(rs.getString(6)));
				vecRec.add(correctNull(rs.getString(7)));										
				vecVal.add(vecRec);
				recordflag = "Y";
			}
			hshRecord.put("vecVal",vecVal);
			hshRecord.put("recordflag",recordflag);
		}		
		catch (Exception e)
		{
			throw new EJBException("Error Occured"+e.getMessage());
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
				throw new EJBException("Error closing the connection "+e1.getMessage());
			}
		}
		return hshRecord;
	}


	private HashMap getSSIExistProposedData(HashMap hshValues) 
	{
		String strQuery="";
		ResultSet rs=null;		
		HashMap hshRecord = new HashMap();
		ArrayList vecVal = new ArrayList();
		ArrayList vecRec= new ArrayList();
		String appno="";
		String recordflag = "N";
		try
		{
			if(correctNull((String)hshValues.get("hidappno"))=="")
			{
				appno = correctNull((String) hshValues.get("appno"));
			}
			else
			{
				appno = correctNull((String) hshValues.get("hidappno"));
			}
			strQuery = SQLParser.getSqlQuery("ssiExistProposedSel^"+appno);
			rs=DBUtils.executeQuery(strQuery);				
			while(rs.next())
			{
				vecRec = new ArrayList();
				vecRec.add(correctNull(rs.getString(3)));
				vecRec.add(correctNull(rs.getString(4)));
				vecRec.add(correctNull(rs.getString(5)));
				vecRec.add(correctNull(rs.getString(6)));
				vecVal.add(vecRec);
				recordflag = "Y";
			}
			hshRecord.put("vecVal",vecVal);
			hshRecord.put("recordflag",recordflag);
		}
		catch (Exception e)
		{
			throw new EJBException("Error Occured"+e.getMessage());
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
			throw new EJBException("Error closing the connection "+e1.getMessage());
			}
		}
		return hshRecord;
	}

	private HashMap getProductInformData(HashMap hshValues) 
	{
		String strQuery="";
		ResultSet rs=null;		
		HashMap hshRecord = new HashMap();
		ArrayList vecVal = new ArrayList();
		ArrayList vecRec= new ArrayList();
		String appno="";
		String recordflag = "N";
		try
		{
			if(correctNull((String)hshValues.get("hidappno"))=="")
			{
				appno = correctNull((String) hshValues.get("appno"));
			}
			else
			{
				appno = correctNull((String) hshValues.get("hidappno"));
			}
			strQuery = SQLParser.getSqlQuery("ssiProductInformSel^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				vecRec = new ArrayList();
				vecRec.add(correctNull(rs.getString(1)));
				vecRec.add(correctNull(rs.getString(2)));
				vecRec.add(correctNull(rs.getString(3)));
				vecRec.add(correctNull(rs.getString(4)));
				vecRec.add(correctNull(rs.getString(5)));
				vecRec.add(correctNull(rs.getString(6)));
				vecRec.add(correctNull(rs.getString(7)));
				vecRec.add(correctNull(rs.getString(8)));
				vecRec.add(correctNull(rs.getString(9)));						
				vecVal.add(vecRec);
				recordflag = "Y";
			}
			hshRecord.put("vecVal",vecVal);
			hshRecord.put("recordflag",recordflag);	
		}		
		catch (Exception e)
		{
			throw new EJBException("Error Occured"+e.getMessage());
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
				throw new EJBException("Error closing the connection "+e1.getMessage());
			}
		}		
		return hshRecord;
	}
	
	private HashMap getSourcesOfFundsData(HashMap hshValues) 
	{
		String strQuery="";
		ResultSet rs=null;		
		HashMap hshRecord = new HashMap();
		ArrayList vecVal = new ArrayList();
		ArrayList vecRec= new ArrayList();
		String appno="";
		
		String recordflag = "N";
		try
		{
			if(correctNull((String)hshValues.get("hidappno"))=="")
			{
				appno = correctNull((String) hshValues.get("appno"));
			}
			else
			{
				appno = correctNull((String) hshValues.get("hidappno"));
			}
			strQuery = SQLParser.getSqlQuery("ssiSourcesOfFundsSel^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				vecRec = new ArrayList();					
				vecRec.add(correctNull(rs.getString(1)));
				vecRec.add(correctNull(rs.getString(2)));
				vecRec.add(correctNull(rs.getString(3)));
				vecRec.add(correctNull(rs.getString(4)));
				vecRec.add(correctNull(rs.getString(5)));
				vecRec.add(correctNull(rs.getString(6)));
				vecRec.add(correctNull(rs.getString(7)));
				vecRec.add(correctNull(rs.getString(8)));
				vecVal.add(vecRec);	
				recordflag = "Y";
			}
			hshRecord.put("vecVal",vecVal);
			hshRecord.put("recordflag", recordflag);
		}		
		catch (Exception e)
		{
			throw new EJBException("Error Occured"+e.getMessage());
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
				throw new EJBException("Error closing the connection "+e1.getMessage());
			}
		}		
		return hshRecord;
	}

	public HashMap updateSSIAB10Data(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		HashMap hshQueryValues = new HashMap();
		HashMap hsh1 = new HashMap();
		HashMap hsh2 = new HashMap();
		HashMap hsh3 = new HashMap();
		HashMap hsh4 = new HashMap();
		HashMap hsh5 = new HashMap();
		HashMap hshQuery = null;		
		int intUpdSize=0;
		String otherGenTable="";
		String genTable="";
		String strTotalDesc="";
		String strQuery="";
		ResultSet rs=null;
		ArrayList arrValues=new ArrayList();
		String strhidTabName="";
		String appno="";
		String strGenId="";
		String strId="";
		String strDesc="";
		String strGenDesc="";
		String strTemp="";
		int i =1;
		try
		{
			StringBuilder sbAt = new StringBuilder();
			strhidTabName=correctNull((String )hshValues.get("hidTabName"));
			if(correctNull((String)hshValues.get("hidappno")).equalsIgnoreCase(""))
			{
				appno = correctNull((String) hshValues.get("appno"));
			}
			else
			{
				appno = correctNull((String) hshValues.get("hidappno"));
			}
			strTotalDesc=correctNull((String )hshValues.get("hidTotalDesc"));
			otherGenTable=correctNull((String )hshValues.get("otherGenTable"));
			genTable=correctNull((String )hshValues.get("genTable"));			
			if(otherGenTable.equals("UpdateSSIProductData"))
			{				
				hsh1 = (HashMap)UpdateSSIProductData(hshValues);
				hshRecord.put("hsh1",hsh1);				
			}
			if(otherGenTable.equals("UpdateSSIExistProposedData"))
			{				
				hsh3 = (HashMap)UpdateSSIExistProposedData(hshValues);
				hshRecord.put("hsh3",hsh3);				
			}
			if(otherGenTable.equals("UpdateSSIProductInformData"))
			{				
				hsh4 = (HashMap)UpdateSSIProductInformData(hshValues);
				hshRecord.put("hsh4",hsh4);				
			}
			if(otherGenTable.equals("UpdateSSISourcesOfFundsData"))
			{				
				hsh5 = (HashMap)UpdateSSISourcesOfFundsData(hshValues);
				hshRecord.put("hsh5",hsh5);				
			}
		 	if(genTable.equals("yes"))
			{				
				intUpdSize++;
				hshQuery = new HashMap();	
				arrValues=new ArrayList();					
				hshQuery.put("strQueryId","ssiGenDelQueries");	
				for(i=1;i<=Integer.parseInt(strTotalDesc);i++)
				{				
					strId =	correctNull((String )hshValues.get("hidDescId"+i));
					strDesc=correctNull((String )hshValues.get("hidDesc"+i));
					if(!(strGenId.trim().equals("")))
					{
						strGenId = strGenId +","+strId;
					}
					else
					{
						strGenId = strId;
					}	
					if(!(strGenDesc.trim().equals("")))
					{
						strGenDesc = strGenDesc +",'"+strDesc+"'";
					}
					else
					{
						strGenDesc = "'"+strDesc+"'";
					}
				}
				arrValues.add(appno);
				arrValues.add(strhidTabName);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				strQuery = SQLParser.getSqlQuery("ssiGenMaxSno^"+appno);
				rs=DBUtils.executeQuery(strQuery);
				for(i=1;i<=Integer.parseInt(strTotalDesc);i++)
				{
					intUpdSize++;
					hshQuery = new HashMap();	
					arrValues=new ArrayList();					
					hshQuery.put("strQueryId","ssiGenInsQueries");
					arrValues.add(appno);
					arrValues.add(Integer.toString(i));
					arrValues.add(correctNull((String )hshValues.get("hidDesc"+i)));
					strTemp=correctNull((String )hshValues.get("hidDescVal"+i));
					arrValues.add(strTemp.getBytes());					
					arrValues.add(strhidTabName);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(Integer.toString(intUpdSize),hshQuery);	
				}	
				hshQueryValues.put("size",Integer.toString(intUpdSize));
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				hsh2 = (HashMap)getGeneralData(hshValues);
				hshRecord.put("hsh2",hsh2);
			} 
		}
		catch (Exception e)
		{
			throw new EJBException("Error "+e.getMessage());
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
			catch (Exception e)
			{
				throw new EJBException("Error Occured"+e.getMessage());
			}
		}
		return hshRecord;
	}

	private HashMap UpdateSSIProductData(HashMap hsh) 
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();
		HashMap hshQuery = new HashMap();
 		ArrayList arr = new ArrayList();
		ArrayList arrValues = new ArrayList(); 
		ResultSet rs=null;
		String strQuery ="";
		int intValue = 0;
		String appno="";
		String myAction="";
		String hidTabName="";
		try
		{
			if(correctNull((String)hsh.get("hidappno"))=="")
			{
				appno = correctNull((String) hsh.get("appno"));
			}
			else
			{
				appno = correctNull((String) hsh.get("hidappno"));
			}				
			hidTabName=Helper.correctNull((String)hsh.get("hidTabName"));
			myAction=Helper.correctNull((String)hsh.get("hidVal"));				
			String []units=null;	
			String []products=null;
			String []licenced=null;
			String []operating=null;
			String []installed=null;												
			int intUpdatesize=0;
			intUpdatesize=1;				
			hshqueryval.put("size",Integer.toString(intUpdatesize));
			hshquery.put("strQueryId","ssiProductDel");
			arr.add(appno);
			hshquery.put("arrValues",arr);
			hshqueryval.put("1",hshquery);
			strQuery = SQLParser.getSqlQuery("ssiMaxProduct^"+appno);
			rs = DBUtils.executeQuery(strQuery);			
			while(rs.next())
			{
				intValue = (rs.getInt(1));				
			}
			units= (String [])hsh.get("units");
			products= (String [])hsh.get("products");
			licenced= (String [])hsh.get("licenced");
			operating= (String [])hsh.get("operating");
			installed= (String [])hsh.get("installed");
			
			int len=products.length;
			if(!myAction.equals("Delete"))
			{
				if(correctNull((String)hsh.get("hidRecordflag")).equals("Y")){
					hsh.put("hidAction", "update");}
				else{
					hsh.put("hidAction", "Insert");
				}
				for(int k=0;k<len;k++)
				{				
					if(!products[k].equals(""))
					{
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize=intUpdatesize+1;
						hshQuery.put("strQueryId","ssiProductIns");
						arrValues.add(appno);
						intValue=intValue+1;
						String i=Integer.toString(intValue);
						arrValues.add(i);													
						arrValues.add(correctNull(products[k]));
						arrValues.add(correctNull(units[k]));
						arrValues.add(Helper.correctDouble((String)licenced[k]));
						arrValues.add(Helper.correctDouble((String)operating[k]));
						arrValues.add(Helper.correctDouble((String)installed[k]));										
						hshQuery.put("arrValues",arrValues);
						hshqueryval.put("size",Integer.toString(intUpdatesize));
						hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);	
					}
				}						
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			if(myAction.equals("Delete"))
			{		
				hsh.put("hidAction", "Delete");
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshqueryval.put("size","1");
				hshQuery.put("strQueryId","delutilities");
				arrValues.add(hidTabName);
				arrValues.add(appno); 
				hshQuery.put("arrValues",arrValues);
				hshqueryval.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			 	hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshqueryval.put("size","1");
				hshQuery.put("strQueryId","ssiProductDel");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshqueryval.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			
			
			StringBuilder sbAuditTrial=new StringBuilder();
			if(!myAction.equals("Delete")){
			for(int k=0;k<len;k++)
			{				
				if(!products[k].equals(""))
				{
					
					if(k==0)
					{	
						sbAuditTrial.append("S.No = ");
					}
					else
					{
						sbAuditTrial.append("~S.No = ");
					}
					
					sbAuditTrial.append(k+1).append("~Description of the Product/s = ").append(products[k])
					.append("~Units = ").append(units[k])
					.append("~Licensed = ").append(licenced[k])
					.append("~Installed = ").append(operating[k])
					.append("~Operating = ").append(installed[k]);
				}
			}
			
			sbAuditTrial.append("~No. of working days in a month and = ").append((String)hsh.get("hidDescVal4"))
			.append("~No. of shifts in a day = ").append((String)hsh.get("hidDescVal5"));
			}
			AuditTrial.auditLog(hsh,"204",appno,sbAuditTrial.toString());
			
			
		}
		catch (Exception e)
		{
			throw new EJBException("Error Occured"+e.getMessage());
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
		HashMap hshRecord = getSSIProductData(hsh);
		return hshRecord;
	}

	private HashMap UpdateSSIExistProposedData(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshRecord =new HashMap();
		ArrayList arrValues=new ArrayList();		
		String strQuery="";		
		ResultSet rs=null;
		String appno="";
		int intmax=0;
		
		try
		{
			if(correctNull((String)hshValues.get("hidappno"))=="")
			{
				appno = correctNull((String) hshValues.get("appno"));
			}
			else
			{
				appno = correctNull((String) hshValues.get("hidappno"));
			}
			String FLExA=Helper.correctNull((String)hshValues.get("FLExA"));
			String FLPrA= Helper.correctNull((String)hshValues.get("FLPrA"));
			String FLExV= Helper.correctNull((String)hshValues.get("FLExV"));
			String FLPrV= Helper.correctNull((String)hshValues.get("FLPrV"));
			String FBExA= Helper.correctNull((String)hshValues.get("FBExA"));
			String FBPrA=Helper.correctNull((String)hshValues.get("FBPrA"));
			String FBExV=Helper.correctNull((String)hshValues.get("FBExV"));
			String FBPrV= Helper.correctNull((String)hshValues.get("FBPrV"));
			String ABExA= Helper.correctNull((String)hshValues.get("ABExA"));
			String ABPrA= Helper.correctNull((String)hshValues.get("ABPrA"));
			String ABExV= Helper.correctNull((String)hshValues.get("ABExV"));
			String ABPrV=Helper.correctNull((String)hshValues.get("ABPrV"));
			String OSExA=Helper.correctNull((String)hshValues.get("OSExA"));
			String OSPrA= Helper.correctNull((String)hshValues.get("OSPrA"));
			String OSExV= Helper.correctNull((String)hshValues.get("OSExV"));
			String OSPrV= Helper.correctNull((String)hshValues.get("OSPrV"));							
			hshQueryValues = new HashMap();
			hshQueryValues.put("size","5");	
			hshQuery = new HashMap();	
			arrValues=new ArrayList();				
			hshQuery.put("strQueryId","ssiExistProposedDel");	
			arrValues.add(appno);								
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);	
			strQuery = SQLParser.getSqlQuery("ssiMaxExistProposed^"+appno);
			rs = DBUtils.executeQuery(strQuery);
		
			while(rs.next())
			{
				intmax = (rs.getInt(1));				
			}
			hshQuery = new HashMap();	
			arrValues=new ArrayList();				
			hshQuery.put("strQueryId","ssiExistProposedIns");	
			arrValues.add(appno);
			arrValues.add(Integer.toString(intmax));
			arrValues.add(FLExA);
			arrValues.add(FLPrA);
			arrValues.add(FLExV);
			arrValues.add(FLPrV);								
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("2",hshQuery);	
			hshQuery = new HashMap();	
			arrValues=new ArrayList();				
			hshQuery.put("strQueryId","ssiExistProposedIns");	
			arrValues.add(appno);
			arrValues.add(Integer.toString(intmax+1));
			arrValues.add(FBExA);
			arrValues.add(FBPrA);
			arrValues.add(FBExV);
			arrValues.add(FBPrV);								
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("3",hshQuery);				
			hshQuery = new HashMap();	
			arrValues=new ArrayList();				
			hshQuery.put("strQueryId","ssiExistProposedIns");	
			arrValues.add(appno);
			arrValues.add(Integer.toString(intmax+2));
			arrValues.add(ABExA);
			arrValues.add(ABPrA);
			arrValues.add(ABExV);
			arrValues.add(ABPrV);								
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("4",hshQuery);	
			
			hshQuery = new HashMap();	
			arrValues=new ArrayList();				
			hshQuery.put("strQueryId","ssiExistProposedIns");	
			arrValues.add(appno);
			arrValues.add(Integer.toString(intmax+3));
			arrValues.add(OSExA);
			arrValues.add(OSPrA);
			arrValues.add(OSExV);
			arrValues.add(OSPrV);								
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("5",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
			
			StringBuilder sbAuditTrial=new StringBuilder();
			String strAction = "";
			if(Helper.correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("Y"))
			{
				hshValues.put("hidAction","Update");
				strAction = "Update";
				
			}
			else if(Helper.correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("N"))
			{
				hshValues.put("hidAction","Insert");
				strAction = "Insert";
			}
			else
			{
				hshValues.put("hidAction","Delete");
				strAction = "Delete";
			}
			if(!strAction.equalsIgnoreCase("Delete")){
			sbAuditTrial.append("Absence of civic restrictions  = ").append(correctNull((String)hshValues.get("hidDescVal1")))
			.append("~Proximity to the source of raw materials = ").append(correctNull((String)hshValues.get("hidDescVal2")))
			.append("~Market for the product = ").append(correctNull((String)hshValues.get("hidDescVal3")))
			.append("~Availability of Power = ").append(correctNull((String)hshValues.get("hidDescVal4")))
			.append("~Availability of Water = ").append(correctNull((String)hshValues.get("hidDescVal5")))
			.append("~Availability of Labour = ").append(correctNull((String)hshValues.get("hidDescVal6")))
			.append("~Availability of Transport = ").append(correctNull((String)hshValues.get("hidDescVal7")))
			.append("~Whether clearance has obtained from pollution control authority? = ").append(correctNull((String)hshValues.get("hidDescVal8")))
			.append("~Land & Building Existing Detail ^")
			.append("~Factory Land Area / Plinth Area (in Sq. meters)= ").append(correctNull((String)hshValues.get("FLExA")))
			.append("~Factory Land Area Value (Rs. in 000's)= ").append(correctNull((String)hshValues.get("FLExV")))
			.append("~Factory Bldg. Area / Plinth Area (in Sq. meters)= ").append(correctNull((String)hshValues.get("FBExA")))
			.append("~Factory Bldg. Area Value (Rs. in 000's)= ").append(correctNull((String)hshValues.get("FBExV")))
			.append("~Ancillary Bldg.  Area / Plinth Area (in Sq. meters)= ").append(correctNull((String)hshValues.get("ABExA")))
			.append("~Ancillary Bldg. Area Value (Rs. in 000's)= ").append(correctNull((String)hshValues.get("ABExV")))
			.append("~Open Storage space Area / Plinth Area (in Sq. meters)= ").append(correctNull((String)hshValues.get("OSExA")))
			.append("~Open Storage space Area Value (Rs. in 000's)= ").append(correctNull((String)hshValues.get("OSExV")))
			
			.append("~Land & Building Proposed Detail ^")
			.append("~Factory Land Area / Plinth Area (in Sq. meters)= ").append(correctNull((String)hshValues.get("FLPrA")))
			.append("~Factory Land Area Value (Rs. in 000's)= ").append(correctNull((String)hshValues.get("FLPrV")))
			.append("~Factory Bldg. Area / Plinth Area (in Sq. meters)= ").append(correctNull((String)hshValues.get("FBPrA")))
			.append("~Factory Bldg. Area Value (Rs. in 000's)= ").append(correctNull((String)hshValues.get("FBPrV")))
			.append("~Ancillary Bldg.  Area / Plinth Area (in Sq. meters)= ").append(correctNull((String)hshValues.get("ABPrA")))
			.append("~Ancillary Bldg. Area Value (Rs. in 000's)= ").append(correctNull((String)hshValues.get("ABPrV")))
			.append("~Open Storage space Area / Plinth Area (in Sq. meters)= ").append(correctNull((String)hshValues.get("OSPrA")))
			.append("~Open Storage space Area Value (Rs. in 000's)= ").append(correctNull((String)hshValues.get("OSPrV")));
			
			}
			AuditTrial.auditLog(hshValues,"174",appno,sbAuditTrial.toString());
			
			
		}
		catch (Exception e)
		{
			throw new EJBException("Error Occured"+e.getMessage());
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
				throw new EJBException("Error closing the connection "+e1.getMessage());
			}
		}
		hshRecord=getSSIExistProposedData(hshValues);
		return hshRecord;
	}

	private HashMap UpdateSSIProductInformData(HashMap hsh) 
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList(); 
		ResultSet rs=null;
		String strQuery ="";
		int intValue = 0;
		int intUpdatesize=0;
		String appno="";
		try
		{
			if(correctNull((String)hsh.get("hidappno"))=="")
			{
				appno = correctNull((String) hsh.get("appno"));
			}
			else
			{
				appno = correctNull((String) hsh.get("hidappno"));
			}			
			String []prodname=null;	
			String []quantreq=null;
			String []source=null;
			
			String []minquant=null;
			String[]leadprotime=null;
			String[]availableyr=null;
			String[]noofmonths=null;
			String myAction="";
			myAction=Helper.correctNull((String)hsh.get("hidVal"));
							
			intUpdatesize=1;
			hshQuery = new HashMap();	
			arrValues=new ArrayList();
			hshqueryval = new HashMap();				
			hshqueryval.put("size",Integer.toString(intUpdatesize));
			hshQuery.put("strQueryId","ssiProductInformDel");
			arrValues.add(appno);
			hshQuery.put("arrValues",arrValues);
			hshqueryval.put("1",hshQuery);
			strQuery = SQLParser.getSqlQuery("ssiMaxProductInform^"+appno);
			rs = DBUtils.executeQuery(strQuery);
		
			while(rs.next())
			{
				intValue = (rs.getInt(1));				
			}
			prodname= (String [])hsh.get("prodname");
			quantreq= (String [])hsh.get("quantreq");
			source= (String [])hsh.get("source");
			
			minquant= (String [])hsh.get("minquant");
			leadprotime=(String [])hsh.get("leadprotime");
			availableyr=(String [])hsh.get("availableyr");
			noofmonths=(String [])hsh.get("noofmonths");
			int len=quantreq.length;
			
			strQuery = SQLParser.getSqlQuery("selectprodappno^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			int q=0;
			if(rs.next())
			{
				q++;
			}
			if(!myAction.equals("Delete"))
			{
				for(int k=0;k<len;k++)
				{				
					if(!quantreq[k].equals(""))
					{
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize=intUpdatesize+1;
						hshQuery.put("strQueryId","ssiProductInformIns");
						arrValues.add(appno);
						intValue=intValue+1;
						String i=Integer.toString(intValue);
						arrValues.add(i);	
						arrValues.add(correctNull(prodname[k]));		
						arrValues.add(correctNull(quantreq[k]));		
						arrValues.add(Helper.correctNull((String)source[k]));	
						
						arrValues.add(correctNull(minquant[k]));
						arrValues.add(correctNull(leadprotime[k]));
						arrValues.add(correctNull(availableyr[k]));
						arrValues.add(correctNull(noofmonths[k]));
						hshQuery.put("arrValues",arrValues);
						hshqueryval.put("size",Integer.toString(intUpdatesize));
						hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);	
					}
				}
			}						
			if(myAction.equals("Delete"))
			{		
				if(q==1)
				{ 
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshqueryval.put("size","1");
					hshQuery.put("strQueryId","ssiProductInformDel");
					arrValues.add(appno);
					hshQuery.put("arrValues",arrValues);
					hshqueryval.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
				}
			}
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");		
			
			
			StringBuilder sbAuditTrial=new StringBuilder();
			String strAction = "";
			if(Helper.correctNull((String)hsh.get("hidRecordflag")).equalsIgnoreCase("Y"))
			{
				hsh.put("hidAction","update");
				strAction = "Update";
			}
			else if(Helper.correctNull((String)hsh.get("hidRecordflag")).equalsIgnoreCase("N"))
			{
				hsh.put("hidAction","insert");
				strAction = "insert";
			}
			else 
			{
				hsh.put("hidAction","Delete");
				strAction = "Delete";
			}
			if(!strAction.equalsIgnoreCase("Delete")){
			for(int k=0;k<len;k++)
			{				
				if(!quantreq[k].equals(""))
				{
					
					if(k==0)
					{	
						sbAuditTrial.append("Name/Brief Desc of item  = ");
					}
					else
					{
						sbAuditTrial.append("~Name/Brief Desc of item  = ");
					}
					sbAuditTrial.append(prodname[k]).append("~Quantity Required = ").append(quantreq[k])
					.append("~Source of Supply = ").append(source[k])
					.append("~Min. Purchase Quantity = ").append(minquant[k])
					.append("~Lead/Procurement Time = ").append(leadprotime[k])
					.append("~Available throughout Year  = ").append(availableyr[k])
					.append("~If the answer to the previous is no, then No. of months it is available  = ").append(noofmonths[k]);
				}
			}
			}
		
			AuditTrial.auditLog(hsh,"175",appno,sbAuditTrial.toString());
			
		}
		catch (Exception e)
		{
			throw new EJBException("Error Occured"+e.getMessage());
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
		HashMap hshRecord = getProductInformData(hsh);
		return hshRecord;
	}

	private HashMap UpdateSSISourcesOfFundsData(HashMap hsh) 
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList(); 
		ResultSet rs=null;
		String strQuery ="";
		int intValue = 0;
		int intUpdatesize=0;
		String appno="";
		String myAction;
		try
		{
			java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
			nf.setGroupingUsed(false);
			nf.setMaximumFractionDigits(2);
			nf.setMinimumFractionDigits(2);
			StringBuilder sbAt = new StringBuilder();
			if(correctNull((String)hsh.get("hidappno"))=="")
			{
				appno = correctNull((String) hsh.get("appno"));
			}
			else
			{
				appno = correctNull((String) hsh.get("hidappno"));
			}			
			String []sources=null;	
			String []security=null;
			String []rateofInt=null;
			String []repaypermonth=null;
			String []present=null;
			String []amtofdef=null;
			myAction=Helper.correctNull((String)hsh.get("hidVal"));							
			intUpdatesize=1;
			hshQuery = new HashMap();	
			arrValues=new ArrayList();
			hshqueryval = new HashMap();
			hshqueryval.put("size",Integer.toString(intUpdatesize));
			hshQuery.put("strQueryId","ssiSourceOfFundsDel");
			arrValues.add(appno);
			hshQuery.put("arrValues",arrValues);
			hshqueryval.put("1",hshQuery);
			strQuery = SQLParser.getSqlQuery("ssiMaxSourceOfFunds^"+appno);
			rs = DBUtils.executeQuery(strQuery);
		
			while(rs.next())
			{
				intValue = (rs.getInt(1));
			
			}
			sources= (String [])hsh.get("sources");
			security= (String [])hsh.get("security");
			rateofInt= (String [])hsh.get("rateofInt");
			repaypermonth= (String [])hsh.get("repaypermonth");
			
			present= (String [])hsh.get("present");
			amtofdef= (String [])hsh.get("amtofdef");
			int len=sources.length;
			strQuery = SQLParser.getSqlQuery("selectsourceappno^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			int p=0;
			if(rs.next())
			{
				p++;
			}
			if(!myAction.equals("Delete"))
			{
				for(int k=0;k<len;k++)
				{
					
					if(!sources[k].equals(""))
					{
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize=intUpdatesize+1;
						hshQuery.put("strQueryId","ssiSourceOfFundsIns");
						arrValues.add(appno);
						intValue=intValue+1;
						String i=Integer.toString(intValue);
						arrValues.add(i);	
						arrValues.add(correctNull(sources[k]));		
						arrValues.add(correctNull(security[k]));
						arrValues.add(Helper.correctNull((String)rateofInt[k]));										arrValues.add(Helper.correctDouble((String)repaypermonth[k]));										arrValues.add(Helper.correctDouble((String)present[k]));										arrValues.add(Helper.correctNull((String)amtofdef[k]));																		
						hshQuery.put("arrValues",arrValues);
						hshqueryval.put("size",Integer.toString(intUpdatesize));
						hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);	
						if(correctNull((String)hsh.get("hidRecordflag")).equals("Y")){
							hsh.put("hidAction", "update");
						}
						else{
							hsh.put("hidAction","Insert");
						}
						sbAt.append("~Source of funds(*) = ").append(correctNull(sources[k])).append(
						"~Security = ").append(correctNull(security[k])).append(
						"~Rate of Interest (%) = ").append(nf.format(Double.parseDouble(Helper.correctDouble((String)rateofInt[k])))).append(
						"~Repayment per month  (Rs.) = ").append(nf.format(Double.parseDouble(Helper.correctDouble((String)repaypermonth[k])))).append(
						"~Present O/s  (Rs.) = ").append(nf.format(Double.parseDouble(Helper.correctDouble((String)present[k])))).append(
						"~Amount of Default (if any)  (Rs.) = ").append(nf.format(Double.parseDouble(Helper.correctDouble((String)amtofdef[k]))));		
						
					}					 	
					EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
				}
			}
			if(myAction.equals("Delete"))
			{
				hsh.put("hidAction","Delete");
				if(p==1)
				{ 
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","ssiSourceOfFundsDel");
					arrValues.add(appno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
				}
			}
			AuditTrial.auditLog(hsh,"171",appno,sbAt.toString());
		}
		catch (Exception e)
		{
			throw new EJBException("Error Occured"+e.getMessage());
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
		HashMap hshRecord = getSourcesOfFundsData(hsh);
		return hshRecord;
	}
	
	public void removeLocationalData(HashMap hshValues)
	{
		HashMap hshQueryValues = new HashMap();
 		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs=null;
		String appno = "";
		String hidTabName = "";
		String MyAction="";	
		try
		{		
			if(correctNull((String)hshValues.get("hidappno"))=="")
			{
				appno = correctNull((String) hshValues.get("appno"));
			}
			else
			{
				appno = correctNull((String) hshValues.get("hidappno"));
			}		
			String[] units= (String [])hshValues.get("units");
			String[] products= (String [])hshValues.get("products");
			String[] licenced= (String [])hshValues.get("licenced");
			String[] operating= (String [])hshValues.get("operating");
			String[] installed= (String [])hshValues.get("installed");
			hidTabName = Helper.correctNull((String)hshValues.get("hidTabName"));			
			MyAction = correctNull((String)hshValues.get("hidVal"));
			if(MyAction.equals("Delete"))
			{					
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","delutilities");
				arrValues.add(hidTabName);
				arrValues.add(appno); 
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				if(hidTabName.equalsIgnoreCase("TechnicalFeasibility"))
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","ssiProductDel");
					arrValues.add(appno); 
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				if(hidTabName.equalsIgnoreCase("ExistProposed"))
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","ssiExistProposedDel");
					arrValues.add(appno); 
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}

			 }
			
			StringBuilder sbAuditTrial=new StringBuilder();
			if(hidTabName.equalsIgnoreCase("TechnicalFeasibility"))
			{	
				if(MyAction.equals("Delete"))
				{
					hshValues.put("hidAction","Delete");
				}
				/*
				int len = units.length;
				for(int k=0;k<len;k++)
				{				
					if(!products[k].equals(""))
					{
						
						if(k==0)
						{	
							sbAuditTrial.append("S.No = ");
						}
						else
						{
							sbAuditTrial.append("~S.No = ");
						}
						sbAuditTrial.append(k+1).append("~Description of the Product/s = ").append(products[k])
						.append("~Units = ").append(units[k])
						.append("~Licensed = ").append(licenced[k])
						.append("~Installed = ").append(installed[k])
						.append("~Operating = ").append(operating[k]);
					}
				}
				
				sbAuditTrial.append("~No. of working days in a month and = ").append((String)hshValues.get("hidDescVal4"))
				.append("~No. of shifts in a day = ").append((String)hshValues.get("hidDescVal5"));
			*/
				AuditTrial.auditLog(hshValues,"204",appno,sbAuditTrial.toString());
			}
			if(hidTabName.equalsIgnoreCase("ExistProposed"))
			{
				if(MyAction.equals("Delete"))
				{
					hshValues.put("hidAction","Delete");
				}
				/*
				sbAuditTrial.append("Absence of civic restrictions  = ").append(correctNull((String)hshValues.get("hidDescVal1")))
				.append("~Proximity to the source of raw materials = ").append(correctNull((String)hshValues.get("hidDescVal2")))
				.append("~Market for the product = ").append(correctNull((String)hshValues.get("hidDescVal3")))
				.append("~Availability of Power = ").append(correctNull((String)hshValues.get("hidDescVal4")))
				.append("~Availability of Water = ").append(correctNull((String)hshValues.get("hidDescVal5")))
				.append("~Availability of Labour = ").append(correctNull((String)hshValues.get("hidDescVal6")))
				.append("~Availability of Transport = ").append(correctNull((String)hshValues.get("hidDescVal7")))
				.append("~Whether clearance has obtained from pollution control authority? = ").append(correctNull((String)hshValues.get("hidDescVal8")))
				.append("~Land & Building Existing Detail ^")
				.append("~Factory Land Area / Plinth Area (in Sq. meters)= ").append(correctNull((String)hshValues.get("FLExA")))
				.append("~Factory Land Area Value (Rs. in 000's)= ").append(correctNull((String)hshValues.get("FLExV")))
				.append("~Factory Bldg. Area / Plinth Area (in Sq. meters)= ").append(correctNull((String)hshValues.get("FBExA")))
				.append("~Factory Bldg. Area Value (Rs. in 000's)= ").append(correctNull((String)hshValues.get("FBExV")))
				.append("~Ancillary Bldg.  Area / Plinth Area (in Sq. meters)= ").append(correctNull((String)hshValues.get("ABExA")))
				.append("~Ancillary Bldg. Area Value (Rs. in 000's)= ").append(correctNull((String)hshValues.get("ABExV")))
				.append("~Open Storage space Area / Plinth Area (in Sq. meters)= ").append(correctNull((String)hshValues.get("OSExA")))
				.append("~Open Storage space Area Value (Rs. in 000's)= ").append(correctNull((String)hshValues.get("OSExV")))
				
				.append("~Land & Building Proposed Detail ^")
				.append("~Factory Land Area / Plinth Area (in Sq. meters)= ").append(correctNull((String)hshValues.get("FLPrA")))
				.append("~Factory Land Area Value (Rs. in 000's)= ").append(correctNull((String)hshValues.get("FLPrV")))
				.append("~Factory Bldg. Area / Plinth Area (in Sq. meters)= ").append(correctNull((String)hshValues.get("FBPrA")))
				.append("~Factory Bldg. Area Value (Rs. in 000's)= ").append(correctNull((String)hshValues.get("FBPrV")))
				.append("~Ancillary Bldg.  Area / Plinth Area (in Sq. meters)= ").append(correctNull((String)hshValues.get("ABPrA")))
				.append("~Ancillary Bldg. Area Value (Rs. in 000's)= ").append(correctNull((String)hshValues.get("ABPrV")))
				.append("~Open Storage space Area / Plinth Area (in Sq. meters)= ").append(correctNull((String)hshValues.get("OSPrA")))
				.append("~Open Storage space Area Value (Rs. in 000's)= ").append(correctNull((String)hshValues.get("OSPrV")));
				*/
				AuditTrial.auditLog(hshValues,"174",appno,sbAuditTrial.toString());
			}
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in removeData "+ce.toString());
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
	public void updateAnticipatedTurnover(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();		
		HashMap hshQuery =new HashMap();
		
		ResultSet rs=null;
		ArrayList arrValues=new ArrayList();
		String appno="",cattype="";
		String strQuery="";
		int intCount=0;
		String strRecordflag = Helper.correctNull((String)hshValues.get("hidRecordflag"));
		cattype=Helper.correctNull((String)hshValues.get("cattype"));
		String StrAction=Helper.correctNull((String)hshValues.get("hidAction"));
		
		//AGRI SSI
		String Stockmargin=Helper.correctNull((String)hshValues.get("txt_stockperiodmargin"));
		String Outstandlimit=Helper.correctNull((String)hshValues.get("txt_outstandLimit"));
		String Outstandmargin=Helper.correctNull((String)hshValues.get("txt_outstandmargin"));
		String Stocklimit=Helper.correctNull((String)hshValues.get("txt_stockperiodLimit"));
		String Total=Helper.correctNull((String)hshValues.get("txt_total"));
		String Workingcap=Helper.correctNull((String)hshValues.get("txt_workingcapital"));
		String Supplier=Helper.correctNull((String)hshValues.get("txt_creditsupplier"));
		String Counselling=Helper.correctNull((String)hshValues.get("txt_counsellingbank"));
		String stockvalue=Helper.correctNull((String)hshValues.get("txt_stkvalue"));
		String outstandingvalue=Helper.correctNull((String)hshValues.get("txt_outstndvalue"));
		
		//SSI
		String MonthlyTurnover=Helper.correctNull((String)hshValues.get("txt_MonthlyTurnover"));
		String CostOfProduction=Helper.correctNull((String)hshValues.get("txt_CostOfProduction"));
		String CostOfRawConsumed=Helper.correctNull((String)hshValues.get("txt_CostOfRawConsumed"));
		String AvgStockingOfRaw=Helper.correctNull((String)hshValues.get("txt_AvgStockingOfRaw"));
		String AvgPeriodOfProcessing=Helper.correctNull((String)hshValues.get("txt_AvgPeriodOfProcessing"));
		String AvgStockingOfFinishedGoods=Helper.correctNull((String)hshValues.get("txt_AvgStockingOfFinishedGoods"));
		String PercentOfCashInTotSales=Helper.correctNull((String)hshValues.get("txt_PercentOfCashInTotSales"));
		String PaymentPeriod=Helper.correctNull((String)hshValues.get("txt_PaymentPeriod"));
		String AvgCreditAvailOnPurchase=Helper.correctNull((String)hshValues.get("txt_AvgCreditAvailOnPurchase"));
				
		try
		{
			StringBuilder sbAt = new StringBuilder();
			if(correctNull((String)hshValues.get("hidappno"))=="")
			{
				appno = correctNull((String) hshValues.get("appno"));
			}
			else
			{
				appno = correctNull((String) hshValues.get("hidappno"));
			}
			
			//FOR AGRI SSI
			if(cattype.equalsIgnoreCase("OPS"))
			{
				if(StrAction.equalsIgnoreCase("U"))
				{
						
					if(correctNull((String)hshValues.get("hidRecordflag")).equals("N")){
						hshValues.put("hidAction", "Insert");
					}else
					{
						hshValues.put("hidAction","update");
					}
					strQuery=SQLParser.getSqlQuery("selmaxantiturn^"+appno);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						intCount=rs.getInt("turnover");
					}	
					
					if(intCount==0)
					{
						hshQueryValues = new HashMap();
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						
						arrValues.add(appno);
						arrValues.add(Stockmargin);						
						arrValues.add(Outstandmargin);
						arrValues.add(Stocklimit);
						arrValues.add(Outstandlimit);
						arrValues.add(Total);
						arrValues.add(Workingcap);
						arrValues.add(Supplier);
						arrValues.add(Counselling);						
						arrValues.add(stockvalue);
						arrValues.add(outstandingvalue);
						
						hshQuery.put("strQueryId","insanticipated");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);
						hshQueryValues.put("size","1");
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
					else
					{
						hshQueryValues = new HashMap();
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						
						arrValues.add(Stockmargin);						
						arrValues.add(Outstandmargin);
						arrValues.add(Stocklimit);
						arrValues.add(Outstandlimit);
						arrValues.add(Total);
						arrValues.add(Workingcap);
						arrValues.add(Supplier);
						arrValues.add(Counselling);
						arrValues.add(stockvalue);
						arrValues.add(outstandingvalue);
						arrValues.add(appno);
						
						
						hshQuery.put("strQueryId","updanticipated");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);
						hshQueryValues.put("size","1");
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
				}			
				else if(StrAction.equalsIgnoreCase("D"))
				{
						hshValues.put("hidAction","Delete");
					hshQueryValues = new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					
					arrValues.add(appno);
					hshQuery.put("strQueryId","delanticipated");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				//-------------------------------------------AuditTrial-----------------------------------
				if(!StrAction.equalsIgnoreCase("D")){
				sbAt.append("~Average level,of stocking period required at any one time value = ").append(stockvalue).append(
				"~Average level,of stocking period required at any one time margin = ").append(Stockmargin).append(
				"~Average level,of stocking period required at any one time permissible limit = ").append(Stocklimit).append(
				"~Average level of outstanding debtors at any one time value = ").append(outstandingvalue).append(
				"~Average level of outstanding debtors at any one time margin = ").append(Outstandmargin).append(
				"~Average level of outstanding debtors at any one time permissible limit=").append(Outstandlimit).append(
				"~Total = ").append(Total).append(
				"~Credit available from suppliers = ").append(Supplier).append(
				"~Working capital required = ").append(Workingcap);
				
				}
				AuditTrial.auditLog(hshValues,"176",appno,sbAt.toString());		
				//-----------------------------------------------End--------------------------------------
			}
			
			//FOR SSI
			
			if(cattype.equalsIgnoreCase("SSI"))
			{
				if(StrAction.equalsIgnoreCase("U"))
				{
					if(correctNull((String)hshValues.get("hidRecordflag")).equals("N")){
						hshValues.put("hidAction", "Insert");
					}else
					{
						hshValues.put("hidAction","update");
					}
					strQuery=SQLParser.getSqlQuery("ssi_selanticipated^"+appno);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						intCount=1;
					}	
					
					if(intCount==0)
					{
						hshQueryValues = new HashMap();
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						
						arrValues.add(appno);
						arrValues.add(MonthlyTurnover);						
						arrValues.add(CostOfProduction);
						arrValues.add(CostOfRawConsumed);
						arrValues.add(AvgStockingOfRaw);
						arrValues.add(AvgPeriodOfProcessing);
						arrValues.add(AvgStockingOfFinishedGoods);
						arrValues.add(PercentOfCashInTotSales);
						arrValues.add(PaymentPeriod);	
						arrValues.add(AvgCreditAvailOnPurchase);
						
						hshQuery.put("strQueryId","ssi_insanticipated");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);
						hshQueryValues.put("size","1");
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
					else
					{
						hshQueryValues = new HashMap();
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						
						arrValues.add(MonthlyTurnover);						
						arrValues.add(CostOfProduction);
						arrValues.add(CostOfRawConsumed);
						arrValues.add(AvgStockingOfRaw);
						arrValues.add(AvgPeriodOfProcessing);
						arrValues.add(AvgStockingOfFinishedGoods);
						arrValues.add(PercentOfCashInTotSales);
						arrValues.add(PaymentPeriod);	
						arrValues.add(AvgCreditAvailOnPurchase);
						arrValues.add(appno);
						
						hshQuery.put("strQueryId","ssi_updanticipated");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);
						hshQueryValues.put("size","1");
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
				}			
				else if(StrAction.equalsIgnoreCase("D"))
				{
					hshValues.put("hidAction", "Delete");
					hshQueryValues = new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					
					arrValues.add(appno);
					hshQuery.put("strQueryId","ssi_delanticipated");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				if(!StrAction.equalsIgnoreCase("D")){
				sbAt.append("~Average level,of stocking period required at any one time value = ").append(stockvalue).append(
				"~Average level,of stocking period required at any one time margin = ").append(Stockmargin).append(
				"~Average level,of stocking period required at any one time permissible limit = ").append(Stocklimit).append(
				"~Average level of outstanding debtors at any one time value = ").append(outstandingvalue).append(
				"~Average level of outstanding debtors at any one time margin = ").append(Outstandmargin).append(
				"~Average level of outstanding debtors at any one time permissible limit=").append(Outstandlimit).append(
				"~Credit available from suppliers = ").append(Supplier).append(
				"~Working capital required = ").append(Workingcap);
				}
				AuditTrial.auditLog(hshValues,"176",appno,sbAt.toString());	
			}
				
	}
		catch(Exception e)
		{
			throw new EJBException("Exception in updateAnticipatedTurnover Arrearsbean"+e.getMessage());
		}
		finally
		{
			try{
				if(rs!=null)
				{
					rs.close();
				}
			}catch(Exception e)
			{
				throw new EJBException("Exception while closing connection in updateAnticipatedTurnover Arrearsbean"+e.getMessage());
			}
		}
		
	}
	public HashMap getAnticipatedTurnover(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();		
		ResultSet rs=null;		
		String strQuery="";
		String appno="";
		String recordflag = "N";
		if(correctNull((String)hshValues.get("hidappno")).equalsIgnoreCase(""))
		{
			appno = correctNull((String) hshValues.get("appno"));
		}
		else
		{
			appno = correctNull((String) hshValues.get("hidappno"));
		}
		try
		{				

			strQuery=SQLParser.getSqlQuery("sel_anticipated^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			
			if(rs.next())
			{
					hshRecord.put("AT_Stockmargin",rs.getString("AT_Stockmargin"));
					hshRecord.put("AT_Outstandmargin",rs.getString("AT_Outstandmargin"));
					hshRecord.put("AT_Stocklimit",rs.getString("AT_Stocklimit"));
					hshRecord.put("AT_Outstandlimit",rs.getString("AT_Outstandlimit"));
					hshRecord.put("AT_Total",rs.getString("AT_Total"));
					hshRecord.put("AT_Workingcapital",rs.getString("AT_Workingcapital"));
					hshRecord.put("AT_Creditsupplier",rs.getString("AT_Creditsupplier"));
					hshRecord.put("AT_Counsellingbank",rs.getString("AT_Counsellingbank"));
					hshRecord.put("AT_Stockvalue",rs.getString("AT_STOCKVALUE"));
					hshRecord.put("AT_outstandingvalue",rs.getString("AT_OUTSTANDINGVALUE"));
					
					recordflag = "Y";
			}
			
			else
			{
				if(rs!=null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("ssi_selanticipated^"+appno);
				rs=DBUtils.executeQuery(strQuery);
				
				if(rs.next())
				{					
						hshRecord.put("MonthlyTurnover",rs.getString("MonthlyTurnover"));
						hshRecord.put("CostOfProduction",rs.getString("CostOfProduction"));
						hshRecord.put("CostOfRawConsumed",rs.getString("CostOfRawConsumed"));
						hshRecord.put("AvgStockingOfRaw",rs.getString("AvgStockingOfRaw"));
						hshRecord.put("AvgPeriodOfProcessing",rs.getString("AvgPeriodOfProcessing"));
						hshRecord.put("AvgStockingOfFinishedGoods",rs.getString("AvgStockingOfFinishedGoods"));
						hshRecord.put("PercentOfCashInTotSales",rs.getString("PercentOfCashInTotSales"));
						hshRecord.put("PaymentPeriod",rs.getString("PaymentPeriod"));
						hshRecord.put("AvgCreditAvailOnPurchase",rs.getString("AvgCreditAvailOnPurchase"));
						recordflag = "Y";
				}
				
			}			
			hshRecord.put("appno",appno);
			hshRecord.put("recordflag",recordflag);
		
		}
		catch(Exception e)
		{
			throw new EJBException("Exception in getAnticipatedTurnover Arrearsbean"+e.getMessage());
			
		}finally
		{
			try
			{
				if(rs!=null)
					rs.close();
			}catch(Exception exp)
			{
				throw new EJBException("Error in closing the connection in getAnticipatedTurnover"+ exp.toString()); 
			}
		}
		return hshRecord;
	}
	
	public HashMap getSSIpastData(HashMap hshValues) 
	{	
		String strQuery="";
		ResultSet rs = null;
		String particular="";
		ArrayList vecData		= new ArrayList();
		ArrayList vecVal		= new ArrayList();
		HashMap hshRecord = new HashMap();	
		try
		{			
			hshRecord = new HashMap();
			String appno	  = null;
			if(correctNull((String)hshValues.get("hidappno"))=="")
			{
				appno = correctNull((String) hshValues.get("appno"));
			}
			else
			{
				appno = correctNull((String) hshValues.get("hidappno"));
			}
			
			strQuery = SQLParser.getSqlQuery("selssipastperf2^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("txt_UnitNeedsMet",correctNull(rs.getString(2)));
				hshRecord.put("txt_DetailsOfBorrowing",correctNull(rs.getString(3)));
				hshRecord.put("txt_ArrearsInPayments",correctNull(rs.getString(4)));
				hshRecord.put("txt_MonthlyTurnover",correctNull(rs.getString(5)));
			}
			
			if(rs!=null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("selssipastperf^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{	
				vecVal = new ArrayList();
				vecVal.add(correctNull(rs.getString(1)));
				vecVal.add(correctNull(rs.getString(2)));
				if (rs.getString(3).equals("S"))
				{
					particular = "";
				}
				if (rs.getString(3).equals("T"))
				{
					particular = "Turnover";
				}
				if (rs.getString(3).equals("N"))
				{
					particular = "Net Profit";
				}
				if (rs.getString(3).equals("R"))
				{
					particular = "Retained Profit";
				}
				vecVal.add(particular);
				vecVal.add(correctNull(rs.getString(3)));
				vecVal.add(correctNull(rs.getString(4)));				
				vecVal.add(correctNull(rs.getString(5)));
				vecVal.add(correctNull(rs.getString(6)));
				vecData.add(vecVal);	
			}
			hshRecord.put("vecData",vecData);
			rs=null;
			strQuery = SQLParser.getSqlQuery("countssipastperf^"+appno+"^T");
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{	
				hshRecord.put("cntT",correctNull(rs.getString(1)));
			}
			else
			{
				hshRecord.put("cntT","0");
			}
			rs=null;
			strQuery = SQLParser.getSqlQuery("countssipastperf^"+appno+"^N");
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{	
				hshRecord.put("cntN",correctNull(rs.getString(1)));
			}
			else
			{
				hshRecord.put("cntN","0");
			}
			rs=null;
			strQuery = SQLParser.getSqlQuery("countssipastperf^"+appno+"^R");
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{	
				hshRecord.put("cntR",correctNull(rs.getString(1)));
			}
			else
			{
				hshRecord.put("cntR","0");
			}
		}
		catch (Exception ce)
		{
			throw new EJBException("Error in Get Data of --> SSI Past Performance <-- "+ce.toString()); 
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
	
	public void updateSSIpastData(HashMap hshValues)
	{		 
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();	 
		ArrayList arrValues = new ArrayList();		
		ResultSet rs = null;
		String strQuery1="";
		String strslno=""; 	 
		String strAction = null;		 
		String appno = "";
		String part = "";
		String year1 = "";
		String year2 = "";
		String year3 = "";
		String UnitNeedsMet="";
		String DetailsOfBorrowing="",ArrearsInPayments="",MonthlyTurnover="";
		try
		{			
			if(correctNull((String)hshValues.get("hidappno"))=="")
			{
				appno = correctNull((String) hshValues.get("appno"));
			}
			else
			{
				appno = correctNull((String) hshValues.get("hidappno"));
			}
			strAction   = Helper.correctNull((String)hshValues.get("hidAction"));
			
			String strID	= correctNull((String )hshValues.get("seqno"));
			
			part	    = Helper.correctNull((String)hshValues.get("txt_part"));
			year1	 	= Helper.correctNull((String)hshValues.get("txt_year1"));
			year2		= Helper.correctNull((String)hshValues.get("txt_year2"));
			year3       = Helper.correctNull((String)hshValues.get("txt_year3"));
			
			UnitNeedsMet = Helper.correctNull((String)hshValues.get("txt_UnitNeedsMet"));
			DetailsOfBorrowing = Helper.correctNull((String)hshValues.get("txt_DetailsOfBorrowing"));
			ArrearsInPayments = Helper.correctNull((String)hshValues.get("txt_ArrearsInPayments"));
			MonthlyTurnover = Helper.correctNull((String)hshValues.get("txt_MonthlyTurnover"));
			
			
			if(year1.equals(""))
			{
				year1="0.00";
			}
			if(year2.equals(""))
			{
					year2="0.00";
			}
			if(year3.equals(""))
			{
				year3="0.00";
			}
			String strParticularold = "";
			StringBuilder strOldAudit = new StringBuilder();
			if(strAction.equalsIgnoreCase("Edit")|| strAction.equalsIgnoreCase("Delete"))
			{
				strOldAudit.append("Past Performance :");
				String strQuery = SQLParser.getSqlQuery("sel_pastperf_audittrial^"+appno+"^"+strID);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next()){
					strOldAudit.append("~Particulars = ");
					
					if(Helper.correctNull((String)rs.getString("part")).equalsIgnoreCase("N"))
					{
						strParticularold = "Net  Profit";
					}
					else if(Helper.correctNull((String)rs.getString("part")).equalsIgnoreCase("T"))
					{
						strParticularold = "Turn Over";
					}
					else if(Helper.correctNull((String)rs.getString("part")).equalsIgnoreCase("R"))
					{
						strParticularold = "Retained Profit";
					}
					strOldAudit.append(strParticularold);
					strOldAudit.append("~Last Year = ");
					strOldAudit.append(ApplicationParams.getCurrency()+" " +Helper.correctNull((String)rs.getString("lastyearval")));
					strOldAudit.append("~Last but one Year = ");
					strOldAudit.append(ApplicationParams.getCurrency()+" " +Helper.correctNull((String)rs.getString("lastbutoneval")));
					strOldAudit.append("~Last but two Year = ");
					strOldAudit.append(ApplicationParams.getCurrency()+" " +Helper.correctNull((String)rs.getString("lastbuttwoval")));
				}
			}
			if(strAction.equalsIgnoreCase("Edit"))
			{
				hshValues.put("hidAction","Update");
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				//arrValues.add(part);
				arrValues.add(year1);
				arrValues.add(year2);
				arrValues.add(year3);
				arrValues.add(appno);
				arrValues.add(strID);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","updatssipastperf");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
		  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		  		
		  		hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(UnitNeedsMet);
				arrValues.add(DetailsOfBorrowing);
				arrValues.add(ArrearsInPayments);
				arrValues.add(MonthlyTurnover);
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","updatssipastperf2");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
		  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}			
			else if (strAction.equalsIgnoreCase("new"))
			{
				hshValues.put("hidAction","Insert");
				if(!part.equalsIgnoreCase("S"))
				{
					strQuery1 = SQLParser.getSqlQuery("maxssipastperf^"+appno);				
					rs = DBUtils.executeQuery(strQuery1);
					if(rs.next())
					{	
						strslno = rs.getString("maxid");
					}
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					arrValues.add(appno);
					arrValues.add(strslno);
					arrValues.add(part);
					arrValues.add(year1);
					arrValues.add(year2);
					arrValues.add(year3);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","insssipastperf");
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);			  		
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);				
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","delssipastperf2");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();				
				arrValues.add(appno);
				arrValues.add(UnitNeedsMet);
				arrValues.add(DetailsOfBorrowing);
				arrValues.add(ArrearsInPayments);
				arrValues.add(MonthlyTurnover);				
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","insssipastperf2");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
		  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if (strAction.equalsIgnoreCase("delete"))
			{
				hshValues.put("hidAction","Delete");
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				arrValues.add(strID);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","delssipastperf");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);				
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","delssipastperf2");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			StringBuilder strNewAudit=new StringBuilder();
			if(strAction.equalsIgnoreCase("Edit")|| strAction.equalsIgnoreCase("New"))
			{

				strNewAudit.append("Past Performance :");
				strNewAudit.append("~Particulars = ");
				String strParticular = "";
				if(strAction.equalsIgnoreCase("New")){
					
					if(Helper.correctNull((String)hshValues.get("txt_part")).equalsIgnoreCase("N"))
					{
						strParticular = "Net  Profit";
					}
					else if(Helper.correctNull((String)hshValues.get("txt_part")).equalsIgnoreCase("T"))
					{
						strParticular = "Turn Over";
					}
					else if(Helper.correctNull((String)hshValues.get("txt_part")).equalsIgnoreCase("R"))
					{
						strParticular = "Retained Profit";
					}
				}
				else
				{
						strParticular = strParticularold;
				}
					strNewAudit.append(strParticular);
					strNewAudit.append("~Last Year = ");
					strNewAudit.append(ApplicationParams.getCurrency()+" " +year1);
					strNewAudit.append("~Last but one Year = ");
					strNewAudit.append(ApplicationParams.getCurrency()+" " +year2);
					strNewAudit.append("~Last but two Year = ");
					strNewAudit.append(ApplicationParams.getCurrency()+" " +year3);
				
			
			}
			AuditTrial.auditNewLog(hshValues,"212",appno,strNewAudit.toString(),strOldAudit.toString());
		}
		catch (Exception ce)
		{
			throw new EJBException("Error on Updaitng Data of --> SSI Past Performance <-- "+ce.toString());
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
}
