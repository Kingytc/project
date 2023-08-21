package com.sai.laps.ejb.setinterest;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
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
import com.sai.laps.helper.SQLParser;
import java.sql.Connection;
import java.sql.PreparedStatement;

@Stateless(name = "SetInterestBean", mappedName = "SetInterestHome")
@Remote (SetInterestRemote.class)
public class SetInterestBean extends BeanAdapter
{

  /**
	 * 
	 */
	private static final long serialVersionUID = 261969794766639403L;
	static Logger log=Logger.getLogger(SetInterestBean.class);
/**
	 * 
	 */

public HashMap getProcessChargesID(HashMap hshRequestValues) 
	{			
		ResultSet rs = null;
		ArrayList vecRow = new ArrayList();
		ArrayList vecCol=null;
		HashMap hshRecord = new HashMap();
		String strQuery="";
		String strPrdCode="";
		try
		{			
			strPrdCode= correctNull((String)hshRequestValues.get("prdCode"));
			hshRecord = new HashMap();
			strQuery = SQLParser.getSqlQuery("selprocesschargeid^"+strPrdCode);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{   vecCol = new ArrayList();
				for (int i=0;i<3;i++)
				{ vecCol.add(rs.getString(i+1));
				}
				vecRow.add(vecCol);
			}
			hshRecord.put("vecRow",vecRow);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData login  "+ce.toString());
		}
		finally
		{	try
			{	if(rs != null)
					rs.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection getProcessChargesID "+cf.getMessage());
			}
		}
		return hshRecord;
	}	

	public HashMap getProcessData(HashMap hshRequestValues) 
	{		
		ResultSet rs = null;
		ArrayList vecRow = new ArrayList();
		ArrayList vecCol =null;
		HashMap hshRecord = new HashMap();
		String strQuery ="";
		String strPrdCode ="";
		String strProcessID ="";
		boolean recordflag=false;
		try
		{				
			hshRecord = new HashMap();			
			strPrdCode = correctNull((String)hshRequestValues.get("prdCode"));
			strQuery = SQLParser.getSqlQuery("selproducttype^"+strPrdCode);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("hidProductType",Helper.correctNull(rs.getString("prd_type")));
			}
			strProcessID =  correctNull((String )hshRequestValues.get("hiddesc"));	
			if (!strProcessID.equals(""))
			{
			strQuery = SQLParser.getSqlQuery("selprocesschargedata^"+strPrdCode+"^"+strProcessID);
			rs = DBUtils.executeQuery(strQuery);

			if(rs.next())
			{
				recordflag=true;
				vecCol = new ArrayList();
				for (int i=1;i< 6 ;i++ )
				{ 
					vecCol.add(rs.getString(i));
					//if(correctNull((String)rs.getString(i)).equalsIgnoreCase("")){}
								
				}
				vecRow.add(vecCol);
			}
			}
			hshRecord.put("vecRow",vecRow);
			hshRecord.put("hidId",strProcessID);
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData login  "+ce.toString());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}
	
	public HashMap updateProcessChargesData(HashMap hshValues) 
	{	
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String strPrdCode = null;
		String strProcessID =null;
		String strrangefrom="",strrangeto="";
		String strExp="$";
		String strQuery="";
		ResultSet rs=null;
		StringBuilder sbAuditTrial=new StringBuilder();
		String strLoanType="";
		String strKeyId = "";
		StringBuilder sbolddata=new StringBuilder();
		try
		{	
			strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			strLoanType=correctNull((String)hshValues.get("prdtype"));
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
			{
				rs = DBUtils.executeLAPSQuery("selprocesschargedata^"+Helper.correctNull((String)hshValues.get("prdCode"))+"^"+
						Helper.correctNull((String)hshValues.get("hiddesc")));
				while(rs.next())
				{
					sbolddata.append("Amount Range From ="+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("process_rangefrom"))))+
							"~Amount Range To ="+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("process_rangeto"))))+
							"~Processing Fees (%) ="+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("process_percentcharge"))))+
							"~Min Processing Fees / Flat Processing fee ="+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("process_minactualcharge"))))+
							"~Max Processing Fees ="+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("process_maxactualcharge")))));
				}
				if(rs!=null)
				rs.close();
			}
			if(strAction.equals("insert"))
			{
			strPrdCode = correctNull((String)hshValues.get("prdCode"));
			strrangefrom=correctNull((String)hshValues.get("prd_procrangefrom"));
			strrangeto=correctNull((String)hshValues.get("prd_procrangeto"));
			strQuery = SQLParser.getSqlQuery("checkprocessrangeins^"+strPrdCode
						+"^"+strrangefrom +"^"+strrangeto
						+"^"+strrangefrom +"^"+strrangeto
						+"^"+strrangefrom +"^"+strrangeto);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				if(rs.getInt(1)!=0)
				{
				strExp = strExp + "Processing Charge is already defined for the given amount range";
				throw new Exception(strExp);
				}
			}
				strPrdCode = correctNull((String)hshValues.get("prdCode"));
				strProcessID = (String)getMaxProcessChageID(strPrdCode);
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshValues.put("hidId","strtermId");				
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","insertprocesschargedata");
				arrValues.add(strPrdCode);
				arrValues.add(strProcessID);
				arrValues.add(strrangefrom);
				arrValues.add(strrangeto);
				arrValues.add( correctNull((String)hshValues.get("prd_procfees")));
				arrValues.add( correctNull((String)hshValues.get("prd_procfees1")));
				arrValues.add( correctNull((String)hshValues.get("prd_procfees2")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);								
			 }

			 else if(strAction.equals("update"))
			{
				strPrdCode = correctNull((String)hshValues.get("prdCode"));
				strProcessID =  correctNull((String )hshValues.get("hiddesc"));	
				strrangefrom=correctNull((String)hshValues.get("prd_procrangefrom"));
				strrangeto=correctNull((String)hshValues.get("prd_procrangeto"));
				strQuery = SQLParser.getSqlQuery("checkprocessrangeupd^"+strPrdCode+"^"+strProcessID
						+"^"+strrangefrom +"^"+strrangeto
						+"^"+strrangefrom +"^"+strrangeto
						+"^"+strrangefrom +"^"+strrangeto);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next())
					{
					if(rs.getInt(1)!=0)
						{
						strExp = strExp + "Processing Charge is already defined for the given amount range";
						throw new Exception(strExp);
						}
					}
				 
				 
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","updateprocesschargedata");
				
				arrValues.add(strrangefrom);
				arrValues.add(strrangeto);
				arrValues.add( correctNull((String)hshValues.get("prd_procfees")));
				arrValues.add( correctNull((String)hshValues.get("prd_procfees1")));
				arrValues.add( correctNull((String)hshValues.get("prd_procfees2")));
				arrValues.add(strPrdCode);
				arrValues.add(strProcessID);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);	
				
			}
			 else if(strAction.equals("delete"))
			{
				strPrdCode = correctNull((String)hshValues.get("prdCode"));
				strProcessID =  correctNull((String )hshValues.get("hiddesc"));	
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				
				hshQuery.put("strQueryId","deleteprocesschargedata");
				arrValues.add(strPrdCode);
				arrValues.add(strProcessID);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
			}

			//--------------------Audit Trial---------------------------
			if(!strAction.equals("delete"))
			{
			sbAuditTrial.append("Amount Range From ="+correctNull((String)hshValues.get("prd_procrangefrom"))+
					"~Amount Range To ="+correctNull((String)hshValues.get("prd_procrangeto"))+
					"~Processing Fees (%) ="+correctNull((String)hshValues.get("prd_procfees"))+
					"~Min Processing Fees / Flat Processing fee ="+correctNull((String)hshValues.get("prd_procfees1"))+
					"~Max Processing Fees ="+correctNull((String)hshValues.get("prd_procfees2")));
			}
			    String strCode="";
			    if(strLoanType.equalsIgnoreCase("T"))
				{
			    	strCode="115";
				}
			    else{
			    	strCode="20";
			    }
			    int intProductCode = Integer.parseInt(strPrdCode);
				String strPrdCode1= Integer.toString(intProductCode);
			  // if(correctNull((String)hshValues.get("hidRecordflag")).equals("Y"))
				//{
				//   hshValues.put("hidAction", "update");
				   AuditTrial.auditNewLog(hshValues,strCode,strPrdCode1,sbAuditTrial.toString(),sbolddata.toString());
			//	}
			   
			 //  if(correctNull((String)hshValues.get("hidRecordflag")).equals("N"))
			 //  {
				   // hshValues.put("hidAction", "insert");
				   // AuditTrial.auditLog(hshValues,strCode,strPrdCode1,sbAuditTrial.toString());
			 //  }
						
			    
			//--------------------End------------------------------------

			try
				{
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					HashMap HashMap3 = new HashMap();
			        HashMap3.put("prdCode", hshValues.get("prdCode"));
			        EJBInvoker.executeStateLess("setproducts", HashMap3, "updateProductSaveStatus");
				}
				catch(Exception se)
				{
					throw new Exception("Transaction Failed");
				}
		}
		catch(Exception ce)
		{
			throw new EJBException(ce.toString());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing in the updateProcessChargesData connection "+cf.getMessage());
			}
		}
		return hshValues;
	}

	private String getMaxProcessChageID(String strPrdCode)
	{			
			String strQuery="";
			ResultSet rs = null;
			String termId = "";
			try
			{	
				strQuery = SQLParser.getSqlQuery("selmaxprocesschargeid^"+strPrdCode);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					termId = rs.getString(1) ;				
				}
				rs.close();
			
			}
			catch(Exception ce)
			{
				log.error(ce.toString());
				throw new EJBException("Error in getData "+ce.toString());
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
				catch(Exception cf)
				{
					throw new EJBException("Error closing the connection "+cf.getMessage());
							
				}
			}
			return termId;
	}

	public HashMap getDocumentChargesID(HashMap hshRequestValues) 	
	{			
		ResultSet rs = null;
		ArrayList vecRow = new ArrayList();
		ArrayList vecCol=null;
		HashMap hshRecord = new HashMap();
		String strQuery="";
		String strPrdCode="";
		try
		{			
			strPrdCode= correctNull((String)hshRequestValues.get("prdCode"));
			hshRecord = new HashMap();
			strQuery = SQLParser.getSqlQuery("seldocumentchargeid^"+strPrdCode);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{  
				vecCol = new ArrayList();
				for (int i=0;i<3;i++)
				{ 
					vecCol.add(rs.getString(i+1));
				}
				vecRow.add(vecCol);
			}
			hshRecord.put("vecRow",vecRow);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getDocumentChargesID login  "+ce.toString());
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
				throw new EJBException("Error closing the connection getDocumentChargesID" + cf.getMessage());
			}
		}
		return hshRecord;
	}

	public HashMap getDocumentData(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		ArrayList vecRow = new ArrayList();
		ArrayList vecCol =null;
		HashMap hshRecord = new HashMap();
		String strQuery ="";
		String strPrdCode ="";
		String strProcessID ="";
		boolean recordflag=false;
		try
		{	
			hshRecord = new HashMap();			
			strPrdCode = correctNull((String)hshRequestValues.get("prdCode"));
			strProcessID =  correctNull((String )hshRequestValues.get("hiddesc"));	
			if (!strProcessID.equals(""))
			{
				strQuery = SQLParser.getSqlQuery("seldocumentchargedata^"+strPrdCode+"^"+strProcessID);
				rs = DBUtils.executeQuery(strQuery);

				if(rs.next())
				{
					recordflag=true;
					vecCol = new ArrayList();
					for (int i=1;i< 6 ;i++ )
					{ 
						vecCol.add(rs.getString(i));
					}
					vecRow.add(vecCol);
				}
			}
			hshRecord.put("strPrdCode",strPrdCode);
			hshRecord.put("vecRow",vecRow);
			hshRecord.put("hidId",strProcessID);
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getDocumentData login  "+ce.toString());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection getDocumentData"+cf.getMessage());
			}
		}
		return hshRecord;
	}

	public HashMap updateDocumentChargesData(HashMap hshValues) 
	{	
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String strPrdCode = null;
		String strrangefrom="",strrangeto="",strExp="$";
		String strQuery="";
		String strProcessID =null;
		ResultSet rs=null;
		StringBuilder sbAuditTrial=new StringBuilder();
		String strLoanType="";
		String strKeyId = "";
		StringBuilder sbolddata=new StringBuilder();
		try
		{	
			strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			strLoanType=correctNull((String)hshValues.get("prdtype"));
		if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
		{
			rs = DBUtils.executeLAPSQuery("seldocumentchargedata^"+Helper.correctNull((String)hshValues.get("prdCode"))+"^"+
					Helper.correctNull((String)hshValues.get("hiddesc")));
			while(rs.next())
			{
				sbolddata.append("Amount Range From ="+Helper.formatDoubleValue(Double.parseDouble((Helper.correctDouble((String)rs.getString("docchrg_rangefrom")))))+
						"~Amount Range To ="+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("docchrg_rangeto"))))+
						"~Documentation Fees (%) ="+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("docchrg_percentcharge"))))+
						"~Min Documentation Fees / Flat Documentation fee ="+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("docchrg_minactualcharge"))))+
						"~Max Documentation Fees ="+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("docchrg_maxactualcharge")))));
			}
			if(rs!=null)
				rs.close();
		}
			if(strAction.equals("insert"))
			{
				strPrdCode = correctNull((String)hshValues.get("prdCode"));
				strrangefrom=correctNull((String)hshValues.get("prd_procrangefrom"));
				strrangeto=correctNull((String)hshValues.get("prd_procrangeto"));
				strQuery = SQLParser.getSqlQuery("checkdocumentrangeins^"+strPrdCode
						+"^"+strrangefrom +"^"+strrangeto
						+"^"+strrangefrom +"^"+strrangeto
						+"^"+strrangefrom +"^"+strrangeto);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next())
				{
					if(rs.getInt(1)!=0)
					{
					strExp = strExp + " Documentation Charge is already defined for the given amount range ";
					throw new Exception(strExp);
					}
				}
				
				strProcessID = (String)getMaxDocumentChageID(strPrdCode);				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshValues.put("hidId","strtermId");				
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","insertdocumentchargedata");
				arrValues.add(strPrdCode);
				arrValues.add(strProcessID);
				arrValues.add( correctNull((String)hshValues.get("prd_procrangefrom")));
				arrValues.add( correctNull((String)hshValues.get("prd_procrangeto")));
				arrValues.add( correctNull((String)hshValues.get("prd_procfees")));
				arrValues.add( correctNull((String)hshValues.get("prd_procfees1")));
				arrValues.add( correctNull((String)hshValues.get("prd_procfees2")));

				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
			}
			else if(strAction.equals("update"))
			{
				strPrdCode = correctNull((String)hshValues.get("prdCode"));
				strProcessID =  correctNull((String )hshValues.get("hiddesc"));	
				strPrdCode = correctNull((String)hshValues.get("prdCode"));
				strrangefrom=correctNull((String)hshValues.get("prd_procrangefrom"));
				strrangeto=correctNull((String)hshValues.get("prd_procrangeto"));
				strQuery = SQLParser.getSqlQuery("checkdocumentrangeupd^"+strPrdCode+"^"+strProcessID
						+"^"+strrangefrom +"^"+strrangeto
						+"^"+strrangefrom +"^"+strrangeto
						+"^"+strrangefrom +"^"+strrangeto);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next())
				{
					if(rs.getInt(1)!=0)
					{
					strExp = strExp + " Documentation Charge is already defined for the given amount range ";
					throw new Exception(strExp);
					}
				}
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","updatedocumentchargedata");
				
				arrValues.add( correctNull((String)hshValues.get("prd_procrangefrom")));
				arrValues.add( correctNull((String)hshValues.get("prd_procrangeto")));
				arrValues.add( correctNull((String)hshValues.get("prd_procfees")));
				arrValues.add( correctNull((String)hshValues.get("prd_procfees1")));
				arrValues.add( correctNull((String)hshValues.get("prd_procfees2")));
				arrValues.add(strPrdCode);
				arrValues.add(strProcessID);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
			}
			else if(strAction.equals("delete"))
			{
				strPrdCode = correctNull((String)hshValues.get("prdCode"));
				strProcessID =  correctNull((String )hshValues.get("hiddesc"));

				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				
				hshQuery.put("strQueryId","deletedocumentchargedata");
				arrValues.add(strPrdCode);
				arrValues.add(strProcessID);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
			}

			//------------------Auditrial-----------------
			if(!strAction.equals("delete"))
			{
			sbAuditTrial.append("Amount Range From ="+correctNull((String)hshValues.get("prd_procrangefrom"))+
					"~Amount Range To ="+correctNull((String)hshValues.get("prd_procrangeto"))+
					"~Documentation Fees (%) ="+correctNull((String)hshValues.get("prd_procfees"))+
					"~Min Documentation Fees / Flat Documentation fee ="+correctNull((String)hshValues.get("prd_procfees1"))+
					"~Max Documentation Fees ="+correctNull((String)hshValues.get("prd_procfees2")));
			}
			
			    String strCode="";
			    if(strLoanType.equalsIgnoreCase("T"))
				{
			    	strCode="116";
				}
			    else{
			    	strCode="21";
			    }
			    
			    /*if(correctNull((String)hshValues.get("hidRecordflag")).equals("Y"))
					hshValues.put("hidAction", "update");*/
			    int intProductCode = Integer.parseInt(strPrdCode);
				String strPrdCode1= Integer.toString(intProductCode);	
				AuditTrial.auditNewLog(hshValues,strCode,strPrdCode1,sbAuditTrial.toString(),sbolddata.toString());
			//------------------End-----------------------

			try
			{
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				HashMap HashMap3 = new HashMap();
		        HashMap3.put("prdCode", hshValues.get("prdCode"));
		        EJBInvoker.executeStateLess("setproducts", HashMap3, "updateProductSaveStatus");
			}
			catch(Exception se)
			{
				throw new Exception("Transaction Failed ");
			}
		}
		catch(Exception ce)
		{
			throw new EJBException(ce.toString());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection updateDocumentChargesData"+cf.getMessage());
			}
		}
		return hshValues;
	}

	private String getMaxDocumentChageID(String strPrdCode)
	{		
		String strQuery="";
		ResultSet rs = null;
		String termId = "";
		try
		{	
			strQuery = SQLParser.getSqlQuery("selmaxdocumentchargeid^"+strPrdCode);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				termId = rs.getString(1) ;				
			}
			rs.close();		
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getData "+ce.toString());
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
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
						
			}
		}
		return termId;
	}
	
	public void updateData(HashMap HashMap) 
    {
		HashMap hshQueryValues = new HashMap();
        HashMap hshQuery = null;
        String strActionData="";
        String strKeyId = "";
        try
        {
        	strKeyId = Helper.correctNull((String)HashMap.get("hidkeyid"));   	
        	ArrayList arraylist1 = new ArrayList();
        	
        	String strIncomeFlag=Helper.correctNull((String)HashMap.get("IncomeFlag"));
        	String prd_collpass = Helper.correctNull((String)HashMap.get("prd_collpass"));
            if(prd_collpass.equalsIgnoreCase(""))
            {
            	prd_collpass = "0";
            }
            String prd_liqpass = Helper.correctNull((String)HashMap.get("prd_liqpass"));
            if(prd_liqpass.equalsIgnoreCase(""))
            {
            	prd_liqpass = "0";
            }
            
            String prd_selfretireage = Helper.correctNull((String)HashMap.get("prd_selfretireage"));
            if(prd_selfretireage.equalsIgnoreCase(""))
            {
            	prd_selfretireage = "0";
            }
            String prd_empretireage = Helper.correctNull((String)HashMap.get("prd_empretireage"));
            if(prd_empretireage.equalsIgnoreCase(""))
            {
            	prd_empretireage = "0";
            }
            String prd_netemp= Helper.correctNull((String)HashMap.get("prd_netemp"));
            if(prd_netemp.equalsIgnoreCase(""))
            {
            	prd_netemp = "0";
            }
            String prd_netselfemp= Helper.correctNull((String)HashMap.get("prd_netselfemp"));
            if(prd_netselfemp.equalsIgnoreCase(""))
            {
            	prd_netselfemp = "0";
            }
            String prd_appminage= Helper.correctNull((String)HashMap.get("prd_appminage"));
            if(prd_appminage.equalsIgnoreCase(""))
            {
            	prd_appminage = "0";
            }
            String txtprd_loanlimit=Helper.correctDouble((String)HashMap.get("txtprd_loanlimit"));
            String txtprd_prepayfixed=Helper.correctDouble((String)HashMap.get("txtprd_prepayfixed"));
            String txtprd_prepayfloating=Helper.correctDouble((String)HashMap.get("txtprd_prepayfloating"));
            String txtprd_salincres=Helper.correctDouble((String)HashMap.get("txtprd_salincres"));
            String txtprd_salincnri=Helper.correctDouble((String)HashMap.get("txtprd_salincnri"));
            String txtprd_nonsalincres=Helper.correctDouble((String)HashMap.get("txtprd_nonsalincres"));
            String txtprd_nonsalincnri=Helper.correctDouble((String)HashMap.get("txtprd_nonsalincnri"));
            String txtprd_upfrontfee=Helper.correctDouble((String)HashMap.get("txtprd_upfrontfee"));
            String txtprd_takeoverloan=Helper.correctNull((String)HashMap.get("txtprd_takeoverloan"));
            String txtrelationadded=Helper.correctNull((String)HashMap.get("hidselrelation"));
            if(txtrelationadded.equalsIgnoreCase(""))
            {
            	txtrelationadded="";
            }
           // String txtprd_minNRIService=Helper.correctNull((String)HashMap.get("txtprd_minNRIService"));
            String sel_incjoinapplicant=Helper.correctNull((String)HashMap.get("sel_incjoinapplicant"));
            String sel_coobligantincome=Helper.correctNull((String)HashMap.get("sel_coobligantincome"));
            String sel_guarantorincome=Helper.correctNull((String)HashMap.get("sel_guarantorincome"));
            String sel_soleproperiterincome=Helper.correctNull((String)HashMap.get("sel_soleproperiterincome"));
        	hshQueryValues.put("size", "2");
        	
        	hshQuery=new HashMap();
        	hshQuery.put("strQueryId", "setprdinterestdel");
        	arraylist1.add(Helper.correctNull((String)HashMap.get("prdCode")));
            hshQuery.put("arrValues", arraylist1);
            hshQueryValues.put("1", hshQuery);
            
            hshQuery = new HashMap();
            hshQuery.put("strQueryId", "setprdinterestins1");
            arraylist1 = new ArrayList();
            
            arraylist1.add(Helper.correctNull((String)HashMap.get("prdCode")));
            arraylist1.add(prd_collpass);
            arraylist1.add(prd_liqpass);
            arraylist1.add(prd_selfretireage);
            arraylist1.add(prd_empretireage);  
            arraylist1.add(prd_netemp);
            arraylist1.add(prd_netselfemp); 
            arraylist1.add(prd_appminage);
            arraylist1.add(txtprd_loanlimit);
            arraylist1.add(txtprd_prepayfixed);
            arraylist1.add(txtprd_prepayfloating);
            arraylist1.add(txtprd_salincres);
            arraylist1.add(txtprd_salincnri);
            arraylist1.add(txtprd_nonsalincres);
            arraylist1.add(txtprd_nonsalincnri);
            arraylist1.add(txtprd_upfrontfee);
            arraylist1.add(txtprd_takeoverloan);
            arraylist1.add(txtrelationadded);
            //arraylist1.add(txtprd_minNRIService);
            arraylist1.add(sel_incjoinapplicant);
            arraylist1.add(sel_coobligantincome);
            arraylist1.add(sel_guarantorincome);
            arraylist1.add(sel_soleproperiterincome);
            
            hshQuery.put("arrValues", arraylist1);
            hshQueryValues.put("2", hshQuery);
            EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
            
            
             if((strIncomeFlag.equalsIgnoreCase("0"))){
            	strActionData = "Product Code ="+correctNull((String)HashMap.get("prdCode"))+
      			"~Max. Limit for Loan (Employed-Gross Annual Income)="+prd_collpass+
      			"~Max. Limit for Loan (Self Employed-Gross Annual Income)="+prd_liqpass+
      			"~Minimun Completed Age for Applicant(s)="+prd_appminage+
      			"~Retirement Age (Employed)="+prd_empretireage+
      			"~Retirement Age (Self Employed)="+prd_selfretireage;		
            }else if((strIncomeFlag.equalsIgnoreCase("1"))){
            	strActionData = "Product Code ="+correctNull((String)HashMap.get("prdCode"))+
      			"~Max. Limit for Loan (Employed-Net Annual Income)="+prd_collpass+
      			"~Max. Limit for Loan (Self Employed-Net Annual Income)="+prd_liqpass+
      			"~Minimun Completed Age for Applicant(s)="+prd_appminage+
      			"~Retirement Age (Employed)="+prd_empretireage+
      			"~Retirement Age (Self Employed)="+prd_selfretireage;	
            } else if((strIncomeFlag.equalsIgnoreCase("2"))){
            	strActionData = "Product Code ="+correctNull((String)HashMap.get("prdCode"))+
      			"~Max. Limit for Loan (Employed-Gross Annual Income)="+prd_collpass+
      			"~Max. Limit for Loan (Self Employed-Gross Annual Income)="+prd_liqpass+
      			"~Max. Limit for Loan (Employed-Net Annual Income)="+prd_netemp+
      			"~Max. Limit for Loan (Self Employed-Net Annual Income)="+prd_netselfemp+
      			"~Minimun Completed Age for Applicant(s)="+prd_appminage+
      			"~Retirement Age (Employed)="+prd_empretireage+
      			"~Retirement Age (Self Employed)="+prd_selfretireage;	
            }
             if(correctNull((String)HashMap.get("hidRecordflag")).equals("Y"))
            	 HashMap.put("hidAction", "update");
             if(correctNull((String)HashMap.get("hidRecordflag")).equals("N"))
            	 HashMap.put("hidAction", "insert");
             int intprdcode=Integer.parseInt(Helper.correctInt((String)HashMap.get("prd_code")));
             String strPrdCode1= Integer.toString(intprdcode);
             AuditTrial.auditLog(HashMap,"26",strPrdCode1,strActionData.toString());
		//-----------------------------END---------------------------------------

           
            HashMap HashMap3 = new HashMap();
            HashMap3.put("prdCode", HashMap.get("prdCode"));
            EJBInvoker.executeStateLess("setproducts", HashMap3, "updateProductSaveStatus");
        }
        catch(Exception exception)
        {
            log.error("in bean... " + exception);
            throw new EJBException("Error in updateData " + exception.toString());
        }
    }

    public HashMap getData(HashMap HashMap)  
    {
    	boolean recordflag=false; 
        HashMap HashMap1 = null;       
        try
        {
            try
            {
               
            	ResultSet resultset=DBUtils.executeLAPSQuery("sel_prdinterest^" + HashMap.get("prdCode"));
                 
                HashMap1 = new HashMap();
                if(resultset.next())
                {
                	recordflag=true;
                	//HashMap1.put("prd_lvr", Helper.correctDoubleQuote(correctNull(resultset.getString("prd_lvr"))));
                    //HashMap1.put("prd_creditbureau", Helper.correctDoubleQuote(correctNull(resultset.getString("prd_creditbureau"))));
                    HashMap1.put("prd_collpass", Helper.correctDoubleQuote(correctNull(resultset.getString("prd_collpass"))));
                    HashMap1.put("prd_liqpass", Helper.correctDoubleQuote(correctNull(resultset.getString("prd_liqpass"))));
                    //HashMap1.put("prd_collweight", Helper.correctDoubleQuote(correctNull(resultset.getString("prd_collweight"))));
                    //HashMap1.put("prd_liqweight", Helper.correctDoubleQuote(correctNull(resultset.getString("prd_liqweight"))));
                    //HashMap1.put("prd_repayselfemp", Helper.correctDoubleQuote(correctNull(resultset.getString("prd_repayselfemp"))));
                    //HashMap1.put("prd_inspection", Helper.correctDoubleQuote(correctNull(resultset.getString("prd_inspection"))));
                    HashMap1.put("prd_selfretireage", Helper.correctDoubleQuote(correctNull(resultset.getString("prd_selfretireage"))));
                    HashMap1.put("prd_empretireage", Helper.correctDoubleQuote(correctNull(resultset.getString("prd_empretireage"))));
                    //HashMap1.put("prd_oldvehiclemargin", Helper.correctDoubleQuote(correctNull(resultset.getString("prd_oldvehiclemargin"))));
                    //HashMap1.put("prd_pp_limit_pensioner", Helper.correctDoubleQuote(correctNull(resultset.getString("prd_pp_limit_pensioner"))));
                    //HashMap1.put("prd_pp_limit_emp_notobt", Helper.correctDoubleQuote(correctNull(resultset.getString("prd_pp_limit_emp_notobt"))));
                    //HashMap1.put("prd_furmargin", Helper.correctDoubleQuote(correctNull(resultset.getString("prd_furmargin"))));
                    HashMap1.put("prd_netemp", Helper.correctDoubleQuote(correctNull(resultset.getString("prd_netemp"))));
                    HashMap1.put("prd_netselfemp", Helper.correctDoubleQuote(correctNull(resultset.getString("prd_netselfemp"))));
                    
                    HashMap1.put("prd_appminage", Helper.correctDoubleQuote(correctNull(resultset.getString("prd_appminage"))));
                    //HashMap1.put("prd_guaminage", Helper.correctDoubleQuote(correctNull(resultset.getString("prd_guaminage"))));
                    HashMap1.put("prd_loanlimit", Helper.correctDouble(resultset.getString("prd_loanlimit")));
                    HashMap1.put("prd_prepayfixed", Helper.correctDouble(resultset.getString("prd_prepayfixed")));
                    HashMap1.put("prd_prepayfloating", Helper.correctDouble(resultset.getString("prd_prepayfloating")));
                    HashMap1.put("prd_salincres", Helper.correctDouble(resultset.getString("prd_salincres")));
                    HashMap1.put("prd_salincnri", Helper.correctDouble(resultset.getString("prd_salincnri")));
                    HashMap1.put("prd_nonsalincres", Helper.correctDouble(resultset.getString("prd_nonsalincres")));
                    HashMap1.put("prd_nonsalincnri", Helper.correctDouble(resultset.getString("prd_nonsalincnri")));
                    HashMap1.put("prd_upfrontfee", Helper.correctDouble(resultset.getString("prd_upfrontfee")));
                    HashMap1.put("prd_takeoverloan", Helper.correctNull(resultset.getString("prd_takeoverloan")));
                    String strRelationarr[] = Helper.correctNull(resultset.getString("PRD_RELATIONSHIP")).split("~");
                    ArrayList arrCol = new ArrayList();
                    ArrayList arrRow = new ArrayList();
                    for(int i=0;i<strRelationarr.length;i++)
                    {
                    	arrCol = new ArrayList();
                    	arrCol.add(strRelationarr[i]);
                    	arrRow.add(arrCol);
                    }                    
                    HashMap1.put("arrRelRow", arrRow);
                    //HashMap1.put("txtprd_minNRIService", Helper.correctNull(resultset.getString("prd_confservice")));
                    
                    HashMap1.put("prd_JointApplicant", Helper.correctNull(resultset.getString("prd_JointApplicant")));//added by ganesan for Include Joint Applicant Income for Eligibility
                    HashMap1.put("prd_CoObligant", Helper.correctNull(resultset.getString("prd_CoObligant")));
                    HashMap1.put("prd_Guarantor", Helper.correctNull(resultset.getString("prd_Guarantor")));
                    HashMap1.put("prd_sole_properiter", Helper.correctNull(resultset.getString("prd_sole_properiter")));
                }
                if(recordflag)
                	HashMap1.put("recordflag","Y");
				else
					HashMap1.put("recordflag","N");
                if(resultset!=null)
                {
             	   resultset.close();
                }
            }
            catch(Exception exception)
            {
                throw new EJBException("Error in getData " + exception.toString());
            }
        }
        finally
        {
            try
            {
               
            }
            catch(Exception exception2)
            {
                throw new EJBException("Error closing the connection " + exception2.getMessage());
            }
        }
        return HashMap1;
    }


    public HashMap getInterests(HashMap hashtable) 
    {
        HashMap hashtable1 = new HashMap();
        HashMap hashtable2 = new HashMap();
        HashMap hashtable3 = new HashMap();
        ResultSet resultset =null;
        
        try
        {
            try
            {                
                String s1 = SQLParser.getSqlQuery("setintindexsel");
                ArrayList ArrayList = new ArrayList();
                ArrayList ArrayList1 = new ArrayList();
                ArrayList ArrayList2 = new ArrayList();
                ArrayList ArrayList3 = new ArrayList();
                resultset = DBUtils.executeQuery(s1);
                while(resultset.next()) 
                {
                    String s2 = Helper.correctDoubleQuote(correctNull(resultset.getString("int_type")));
                    if(s2.equalsIgnoreCase("tl"))
                    {
                        ArrayList.add(Helper.correctDoubleQuote(correctNull(resultset.getString("int_mdrates1"))));
                        ArrayList1.add(Helper.correctDoubleQuote(correctNull(resultset.getString("int_mdratio1"))));
                        ArrayList.add(Helper.correctDoubleQuote(correctNull(resultset.getString("int_mdrates2"))));
                        ArrayList1.add(Helper.correctDoubleQuote(correctNull(resultset.getString("int_mdratio2"))));
                        ArrayList.add(Helper.correctDoubleQuote(correctNull(resultset.getString("int_mdrates3"))));
                        ArrayList1.add(Helper.correctDoubleQuote(correctNull(resultset.getString("int_mdratio3"))));
                        ArrayList.add(Helper.correctDoubleQuote(correctNull(resultset.getString("int_indrates1"))));
                        ArrayList1.add(Helper.correctDoubleQuote(correctNull(resultset.getString("int_indratio1"))));
                        ArrayList.add(Helper.correctDoubleQuote(correctNull(resultset.getString("int_indrates2"))));
                        ArrayList1.add(Helper.correctDoubleQuote(correctNull(resultset.getString("int_indratio2"))));
                        ArrayList.add(Helper.correctDoubleQuote(correctNull(resultset.getString("int_indrates3"))));
                        ArrayList1.add(Helper.correctDoubleQuote(correctNull(resultset.getString("int_indratio3"))));
                    }
                    else if(s2.equalsIgnoreCase("wc"))
                    {
                        ArrayList2.add(Helper.correctDoubleQuote(correctNull(resultset.getString("int_mdrates1"))));
                        ArrayList3.add(Helper.correctDoubleQuote(correctNull(resultset.getString("int_mdratio1"))));
                        ArrayList2.add(Helper.correctDoubleQuote(correctNull(resultset.getString("int_mdrates2"))));
                        ArrayList3.add(Helper.correctDoubleQuote(correctNull(resultset.getString("int_mdratio2"))));
                        ArrayList2.add(Helper.correctDoubleQuote(correctNull(resultset.getString("int_mdrates3"))));
                        ArrayList3.add(Helper.correctDoubleQuote(correctNull(resultset.getString("int_mdratio3"))));
                        ArrayList2.add(Helper.correctDoubleQuote(correctNull(resultset.getString("int_indrates1"))));
                        ArrayList3.add(Helper.correctDoubleQuote(correctNull(resultset.getString("int_indratio1"))));
                        ArrayList2.add(Helper.correctDoubleQuote(correctNull(resultset.getString("int_indrates2"))));
                        ArrayList3.add(Helper.correctDoubleQuote(correctNull(resultset.getString("int_indratio2"))));
                        ArrayList2.add(Helper.correctDoubleQuote(correctNull(resultset.getString("int_indrates3"))));
                        ArrayList3.add(Helper.correctDoubleQuote(correctNull(resultset.getString("int_indratio3"))));
                    }
                }

                hashtable1.put("vecValues1", ArrayList);
                hashtable1.put("vecValues2", ArrayList1);
                hashtable2.put("vecValues3", ArrayList2);
                hashtable2.put("vecValues4", ArrayList3);
                hashtable3.put("interestindex_tl", hashtable1);
                hashtable3.put("interestindex_wc", hashtable2);
            }
            catch(Exception exception)
            {
                throw new EJBException("Error in getData " + exception.toString());
            }
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
        return hashtable3;
    }
    //karthikeyan
    public HashMap getMarginData(HashMap hshValues)  
    {
    	
    	ResultSet rs = null;
		ArrayList vecRow = new ArrayList();
		ArrayList vecCol = new ArrayList();
		HashMap hshRecord = new HashMap();
		String strQuery = "";
		String strPrdCode = "";
		String strmarginID="",strPurpose="",strPrdtype="";
		boolean recordflag=false;
              
       try
            {
    	 
    	   strPrdCode = correctNull((String)hshValues.get("prdCode"));
    	   strmarginID =  correctNull((String )hshValues.get("hiddesc"));
    	   strPrdtype =  correctNull((String )hshValues.get("hidProductType"));
    	   
    	   if(!strmarginID.equalsIgnoreCase(""))
    	   		{
    		   	strQuery=SQLParser.getSqlQuery("selMarginlist^" + strPrdCode +"^"+strmarginID);
    		   	rs = DBUtils.executeQuery(strQuery);
    			while (rs.next()) {
    				
    				vecCol = new ArrayList();
    				vecCol.add(Helper.correctNull((String)rs.getString("margin_prdcode")));
    				vecCol.add(Helper.correctNull((String)rs.getString("margin_id")));
    				vecCol.add(Helper.correctNull((String)rs.getString("margin_range_from")));
    				vecCol.add(Helper.correctNull((String)rs.getString("margin_range_to")));
    				vecCol.add(Helper.correctNull((String)rs.getString("margin_perct")));
    				vecCol.add(Helper.correctNull((String)rs.getString("margin_perct_othersec")));//added by bhaskar
    				vecCol.add(Helper.correctNull((String)rs.getString("MARGIN_PERCT_RECURRING")));
    				vecCol.add(Helper.correctNull((String)rs.getString("MARGIN_PERCT_ALLIED")));
    				if(!Helper.correctNull((String)rs.getString("margin_perct")).equalsIgnoreCase(""))
    				{
    					  recordflag=true;
    				}
    				vecRow.add(vecCol);
    				}
    			hshRecord.put("vecMarginRow", vecRow);
    	   		}
    	   if(rs!=null)
	   		{
	   			rs.close();
	   		}
    	   
    	    strQuery = SQLParser.getSqlQuery("selLoanPurpose^"+strPrdCode);
   			rs=DBUtils.executeQuery(strQuery);
   			if(rs.next())
   			{
   				strPurpose = Helper.correctNull(rs.getString("prd_purpose"));
   				hshRecord.put("strvehitype",Helper.correctNull(rs.getString("prd_vehitype")));
   			}
   		
	   		if(rs!=null)
	   		{
	   			rs.close();
	   		}
	   		strQuery = SQLParser.getSqlQuery("sel_prd_margin^"+strPrdCode);
  			rs=DBUtils.executeQuery(strQuery);
  			if(rs.next())
  			{
  				hshRecord.put("prd_catid",Helper.correctNull(rs.getString("prd_catid")));
  				hshRecord.put("prd_desc",Helper.correctNull(rs.getString("prd_desc")));
  				hshRecord.put("prd_whetheragri",Helper.correctNull(rs.getString("prd_whetheragri")));
  			}
	   		if(rs!=null)
	   		{
	   			rs.close();
	   		}
	   		
   		hshRecord.put("strPurpose",strPurpose);
   		hshRecord.put("hidProductType",strPrdtype);
   		
    	   if(recordflag)
    			hshRecord.put("recordflag","Y");
    		else
    			hshRecord.put("recordflag","N");
            }
            catch(Exception exception)
            {
                throw new EJBException("Error in getData " + exception.toString());
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
    			catch(Exception cf)
    			{
    				throw new EJBException("Error closing the connection "+cf.getMessage());
    						
    			}
    		}
    	
            hshRecord.put("hidId",strmarginID);
           hshRecord.put("strPrdCode",strPrdCode);
            
            
        return hshRecord;
    }
    
    //karthikeyan
    public HashMap updateMarginData(HashMap hshValues) 
	{	
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String strPrdCode = null;
		String strMarginID =null;
		String strrangefrom="",strrangeto="";
		String strExp="$";
		String strQuery="";
		ResultSet rs=null;
		StringBuilder sbAuditTrial=new StringBuilder();
		String strLoanType="";
		StringBuilder sbolddata=new StringBuilder(); 
		String strKeyId = "";
		String strmarginID = "",strCatid="",strAgri="";
		try
		{
			strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			strLoanType=correctNull((String)hshValues.get("prdtype"));
 			strPrdCode = correctNull((String)hshValues.get("prdCode"));
 			strrangefrom=correctNull((String)hshValues.get("prd_procrangefrom"));
			strrangeto=correctNull((String)hshValues.get("prd_procrangeto"));
	    	strmarginID =  correctNull((String )hshValues.get("selectmarginterm"));
	    	String strRange = Helper.correctNull((String)hshValues.get("hiddesc"));
	    	strCatid= Helper.correctNull((String)hshValues.get("hidCatId"));
	    	strAgri=Helper.correctNull((String)hshValues.get("hidAgri"));
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
			{
				if(!strmarginID.equalsIgnoreCase(""))
    	   		{
	    		   	strQuery=SQLParser.getSqlQuery("selMarginlist^" + strPrdCode +"^"+strmarginID);
	    		   	rs = DBUtils.executeQuery(strQuery);
	    			while (rs.next()) 
	    			{
	    				sbolddata.append("Product Code ="+correctNull((String)rs.getString("margin_prdcode"))+
	    		 				"~Amount Range From Rs.= "+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("margin_range_from"))))+
	    						"~Amount Range To  Rs.= "+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("margin_range_to"))))+
	    						"~margin Amount (%) ="+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("margin_perct")))));	
	    			}
	    			if(rs!=null)
	    				rs.close();
    			}
			}
			if(strAction.equalsIgnoreCase("INSERT"))
			{
				strMarginID = (String)getMaxMarginID(strPrdCode);			
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();	
				strQuery = SQLParser.getSqlQuery("checkmarginrangeins^"+strPrdCode
						+"^"+strrangefrom +"^"+strrangeto
						+"^"+strrangefrom +"^"+strrangeto
						+"^"+strrangefrom +"^"+strrangeto);
				
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next())
				{
					if(rs.getInt(1)!=0)
					{
					strExp = strExp + " Check the existing amount range ";
					hshValues.put("strExp","strExp");		
					throw new Exception(strExp);
					}
				}
				hshQueryValues.put("size","1");
				hshValues.put("hidId","strtermId");				
				arrValues=new ArrayList();
				if(((Helper.correctNull((String)hshValues.get("hidProductType"))).equalsIgnoreCase("pG"))&&(strAgri.equalsIgnoreCase("Y")))
					hshQuery.put("strQueryId","insertMarginData1");
				else
					hshQuery.put("strQueryId","insertMarginData");
				//hshQuery.put("strQueryId","insertMarginData");
				arrValues.add(strPrdCode);
				arrValues.add(strMarginID);
				arrValues.add( correctNull((String)hshValues.get("prd_procrangefrom")));
				arrValues.add( correctNull((String)hshValues.get("prd_procrangeto")));
				if((Helper.correctNull((String)hshValues.get("hidProductType"))).equalsIgnoreCase("pG")){
					arrValues.add( correctNull((String)hshValues.get("txt_latestmargin")));
					arrValues.add( correctNull((String)hshValues.get("txt_avgmargin")));
					}
				else{
					arrValues.add( correctNull((String)hshValues.get("prd_procfees")));
					arrValues.add( correctNull((String)hshValues.get("prd_procfees_othersec")));//added	
				}
				if(((Helper.correctNull((String)hshValues.get("hidProductType"))).equalsIgnoreCase("pG"))&&(strAgri.equalsIgnoreCase("Y"))){
					arrValues.add( correctNull((String)hshValues.get("txt_recurexpmargin")));
					arrValues.add( correctNull((String)hshValues.get("txt_maragridevelop")));
				}			
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
			}
			else if(strAction.equals("update"))
			{
				strMarginID = correctNull((String)hshValues.get("selectmarginterm"));			
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();	
				strQuery = SQLParser.getSqlQuery("checkmarginrangeupd^"+strPrdCode+"^"+strMarginID
						+"^"+strrangefrom +"^"+strrangeto
						+"^"+strrangefrom +"^"+strrangeto
						+"^"+strrangefrom +"^"+strrangeto);
				
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next())
				{
					if(rs.getInt(1)!=0)
					{
					strExp = strExp + " Check the existing amount range ";
					hshValues.put("strExp","strExp");		
					throw new Exception(strExp);
					}
				}
				
				arrValues=new ArrayList();
				if(((Helper.correctNull((String)hshValues.get("hidProductType"))).equalsIgnoreCase("pG"))&&(strAgri.equalsIgnoreCase("Y")))
					hshQuery.put("strQueryId","updateMargindata1");
				else
					hshQuery.put("strQueryId","updateMargindata");
				//hshQuery.put("strQueryId","updateMargindata");
				arrValues.add( correctNull((String)hshValues.get("prd_procrangefrom")));
				arrValues.add( correctNull((String)hshValues.get("prd_procrangeto")));
				if((Helper.correctNull((String)hshValues.get("hidProductType"))).equalsIgnoreCase("pG")){
					arrValues.add( correctNull((String)hshValues.get("txt_latestmargin")));
					arrValues.add( correctNull((String)hshValues.get("txt_avgmargin")));
					}
				else{
					arrValues.add( correctNull((String)hshValues.get("prd_procfees")));
					arrValues.add( correctNull((String)hshValues.get("prd_procfees_othersec")));				
				}
				if(((Helper.correctNull((String)hshValues.get("hidProductType"))).equalsIgnoreCase("pG"))&&(strAgri.equalsIgnoreCase("Y"))){
					arrValues.add( correctNull((String)hshValues.get("txt_recurexpmargin")));
					arrValues.add( correctNull((String)hshValues.get("txt_maragridevelop")));
				}
				arrValues.add(strPrdCode);
				arrValues.add(strMarginID);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equals("delete"))
			{
				strMarginID = correctNull((String)hshValues.get("selectmarginterm"));			
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","deletemargindata");
				arrValues.add(strPrdCode);
				arrValues.add(strMarginID);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
			}
			
			
			//-----------------------Audittrial-----------------------
			if(!strAction.equals("delete"))
			{
					sbAuditTrial.append("Product Code ="+correctNull((String)hshValues.get("prdCode"))+
	 				"~Amount Range From Rs. = "+correctNull((String)hshValues.get("prd_procrangefrom"))+
					"~Amount Range To Rs. = "+correctNull((String)hshValues.get("prd_procrangeto"))+
					"~margin Amount (%) ="+correctNull((String)hshValues.get("prd_procfees")));	
			}
			if(Helper.correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("N"))
				hshValues.put("hidAction", "Insert");
			else if(strAction.equals("delete"))
				hshValues.put("hidAction", "delete");
			else
				hshValues.put("hidAction", "update");	
			int intProductCode = Integer.parseInt(strPrdCode);
			String strPrdCode1= Integer.toString(intProductCode),strCode="";
			if(strLoanType.equalsIgnoreCase("T"))
			{
		    	strCode="355";
			}
			else
			{
				strCode="27";
			}
			AuditTrial.auditNewLog(hshValues,strCode,strPrdCode1,sbAuditTrial.toString(),sbolddata.toString());
			//-----------------------End--------------------------------

			try
			{
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				HashMap HashMap3 = new HashMap();
		        HashMap3.put("prdCode", hshValues.get("prdCode"));
		        EJBInvoker.executeStateLess("setproducts", HashMap3, "updateProductSaveStatus");
			}
			catch(Exception se)
			{
				throw new Exception("Transaction Failed ");
			}
		}
		catch(Exception ce)
		{
			throw new EJBException(ce.toString());
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
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
						
			}
		}
	
		hshValues=getMarginData(hshValues);
		return hshValues;
	}
    
    
    
    
    public HashMap getInterestData(HashMap hshValues)  
    {
    	
    	ResultSet rs = null;
		ArrayList vecRow = new ArrayList();
		ArrayList vecCol = new ArrayList();
		HashMap hshRecord = new HashMap();
		String strQuery = "";
		String strPrdCode = "";
		String strinttype="";
		String strprdsno="";
		String strflag="";
		boolean recordflag=false;      
       try
            {
	    	   strPrdCode = correctNull((String)hshValues.get("prdCode"));
	    	   strinttype =  correctNull((String )hshValues.get("work"));
	    	   strprdsno =  correctNull((String )hshValues.get("prdsno"));
	    	   strflag =  correctNull((String )hshValues.get("flag"));
    	   
	    	   strQuery = SQLParser.getSqlQuery("selIntdata^"+strPrdCode + "^" +strinttype);
	    	   rs = DBUtils.executeQuery(strQuery);
	    	   if(rs.next())
	    	   {
	    		   	recordflag=true;
	    		    hshRecord.put("PRDINT_SNO", Helper.correctDoubleQuote(correctNull(rs.getString("PRDINT_SNO"))));
	    			hshRecord.put("PRD_AMTRANGEFROM", Helper.correctDoubleQuote(correctNull(rs.getString("PRD_AMTRANGEFROM"))));
	    			hshRecord.put("PRD_AMTRANGETO", Helper.correctDoubleQuote(correctNull(rs.getString("PRD_AMTRANGETO"))));
	    			hshRecord.put("PRD_BASERATE", Helper.correctDoubleQuote(correctNull(rs.getString("PRD_BASERATE"))));
	    			hshRecord.put("PRD_ADJUST", Helper.correctDoubleQuote(correctNull(rs.getString("PRD_ADJUST"))));
	    			hshRecord.put("PRD_INTEREST", Helper.correctDoubleQuote(correctNull(rs.getString("PRD_INTEREST"))));
	    			if(Helper.correctDoubleQuote(correctNull(rs.getString("PRD_BASERATE"))).equalsIgnoreCase(""))
	    				recordflag=false;
	    	   }
	    	   if(recordflag)
	    			hshRecord.put("recordflag","Y");
	    		else
	    			hshRecord.put("recordflag","N");   
    	   
            }
            catch(Exception exception)
            {
                throw new EJBException("Error in getData " + exception.toString());
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
    			catch(Exception cf)
    			{
    				throw new EJBException("Error closing the connection "+cf.getMessage());
    						
    			}
    		}
    	
          
           hshRecord.put("strPrdCode",strPrdCode);
            
            
        return hshRecord;
    }
    
    public void updateInterestData(HashMap hshValues) 
	{	
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=null;
		String strAction=(String)hshValues.get("hidAction");
		String strsno=null;
		ResultSet rs=null;
		int intUpdatesize = 0;
		String strLoanType="";
		String strKeyId = "";
		StringBuilder sbolddata=new StringBuilder();
		try
		{
			strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			strLoanType=correctNull((String)hshValues.get("prdtype"));
			strsno=correctNull((String)hshValues.get("prdsno"));
			String strPrdCode = Helper.correctNull((String)hshValues.get("prd_code1"));
			String strinttype = Helper.correctNull((String)hshValues.get("wrk_flowtype1"));
			
			if(!strAction.equalsIgnoreCase("delete")){
			if(correctNull((String)hshValues.get("hidRecordflag")).equals("Y")){
				strAction = "update";
				hshValues.put("hidAction", "update");
			}else{
				strAction = "INSERT";
				hshValues.put("hidAction", "INSERT");
			}}
			
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
			{
				rs = DBUtils.executeLAPSQuery("selIntdata^"+strPrdCode+"^"+strinttype);
				while(rs.next())
				{
					sbolddata.append("~ Amount Range From = "+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("PRD_AMTRANGEFROM")))));
					sbolddata.append("~ Amount Range To = "+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("PRD_AMTRANGETO")))));
					sbolddata.append("~ Reference Rate = "+Helper.correctNull((String)rs.getString("PRD_BASERATE")));
					sbolddata.append("~ Adjustments (+/-) ="+Helper.correctNull((String)rs.getString("PRD_ADJUST")));
					sbolddata.append("~ Interest Rate = "+Helper.correctNull((String)rs.getString("PRD_INTEREST")));
				}
				if(rs!=null)
				rs.close();
			}
			if((strAction.equalsIgnoreCase("INSERT")) || (strAction.equalsIgnoreCase("update")))
			{			
				intUpdatesize ++ ;
				arrValues=new ArrayList();
				hshQuery = new HashMap();					
				hshQuery.put("strQueryId","delIntdata");
				arrValues.add(strsno);
				arrValues.add("1");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);				
				
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				intUpdatesize ++ ;
				hshQuery.put("strQueryId","insIntData");
				arrValues.add(strsno);
				arrValues.add("1");
				arrValues.add(correctNull((String)hshValues.get("amtfrom")));
				arrValues.add(correctNull((String)hshValues.get("amtto")));
				arrValues.add(correctNull((String)hshValues.get("baserate")));
				arrValues.add(correctNull((String)hshValues.get("adjust")));
				arrValues.add(correctNull((String)hshValues.get("total")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
			}
			else if(strAction.equals("delete"))
			{
				
				intUpdatesize++;		
				arrValues=new ArrayList();
				hshQuery = new HashMap();					
				hshQuery.put("strQueryId","delIntdata");
				arrValues.add(strsno);
				arrValues.add("1");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
			}

			//for Entering the values into auditrial
			String strActionData = "";
			if(!strAction.equals("delete"))
			{
				strActionData = "~Amount Range From="+correctNull((String)hshValues.get("amtfrom"))+
				"~Amount Range To="+correctNull((String)hshValues.get("amtto"))+
				"~Reference Rate="+correctNull((String)hshValues.get("baserate"))+
				"~Adjustments="+correctNull((String)hshValues.get("adjust"))+
				"~Interest Rate (%)="+correctNull((String)hshValues.get("total"));
			}
			/*if(correctNull((String)hshValues.get("hidRecordflag")).equals("Y"))
			{
				hshValues.put("hidAction", "update");
				AuditTrial.auditNewLog(hshValues,"354",strKeyId,strActionData,sbolddata.toString());
			}
			if(correctNull((String)hshValues.get("hidRecordflag")).equals("N"))
			{
				hshValues.put("hidAction", "insert");
				AuditTrial.auditLog(hshValues,"354",strKeyId,strActionData);
			}*/
			AuditTrial.auditNewLog(hshValues,"354",strKeyId,strActionData,sbolddata.toString());
			hshQueryValues.put("size",Integer.toString(intUpdatesize));
			try
			{
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			catch(Exception se)
			{
				throw new Exception("Transaction Failed ");
			}
		}
		catch(Exception ce)
		{
			throw new EJBException(ce.toString());
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
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
						
			}
		}
	}
    //karthikyean
    
    private String getMaxMarginID(String strPrdCode)
	{
		String strQuery="";
		ResultSet rs = null;
		String termId = "";
		try
		{	
			strQuery = SQLParser.getSqlQuery("selmaxMarginid^"+strPrdCode);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				termId = rs.getString(1) ;				
			}
			rs.close();		
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getData "+ce.toString());
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
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
						
			}
		}
		return termId;
	}
    
    
    public HashMap updateIncomeData(HashMap hshValues)
    {
    	HashMap hshRecord=new HashMap();
    	HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		
		ArrayList arrValues=new ArrayList();
    	
    	String strPrdcode="";
    	String strRepayId="";
    	String strAction="";
    	String strQuery="";
    	String strIncomefrom="";
    	String strIncometo="";
    	String strExp="$";
    	String strKeyId = "";
    	ResultSet rs=null;
    	StringBuilder sbolddata=new StringBuilder();
    	String strinternetproduct="",strprdtype="";
    	try
    	{
    		strPrdcode=correctNull((String)hshValues.get("prdCode"));
    		strRepayId=correctNull((String)hshValues.get("selincomerange"));
    		strAction=correctNull((String)hshValues.get("hidAction"));
    		strIncomefrom=correctNull((String)hshValues.get("txt_incomefrom"));
    		strIncometo=correctNull((String)hshValues.get("txt_incometo"));
    		strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
    		strRepayId=correctNull((String)hshValues.get("repayid"));
    		if(strRepayId.equals(""))
    		{
    			strRepayId=correctNull((String)hshValues.get("selincomerange"));
    		} 
    		
    		if(rs!=null)
    		{
    			rs.close();
    		}
    		strQuery= SQLParser.getSqlQuery("setproductssel^"+correctNull((String)hshValues.get("prdCode")));
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()){
				strinternetproduct = Helper.correctNull((String)rs.getString("prd_internet")).equalsIgnoreCase("Y") ? "YES":"NO";
				strprdtype = Helper.correctNull((String)rs.getString("prd_type"));
			}
			
    		if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
    		{
    			strQuery=SQLParser.getSqlQuery("selprdrepaycapacity^"+strPrdcode+"^"+strRepayId);
        		rs=DBUtils.executeQuery(strQuery);
        		while(rs.next())
        		{
        			sbolddata.append("~ Gross Annual Income Range From = "+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("repay_incrangefrom")))));
        			sbolddata.append("~ Gross Annual Income Range To = "+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("repay_incrangeto")))));
        			sbolddata.append("~ Sustenance Required for Salaried (%) = "+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("repay_salariedsustanece")))));
        			sbolddata.append("~ Sustenance Required for Non Salaried (%) = "+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("repay_nonsalariedsustanece")))));
        			sbolddata.append("~ Sustenance Required for Artificial Bodies (%) = "+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("repay_artificialsustanece")))));
        			sbolddata.append("~ Union credit scheme repay capacity(%) = "+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("repay_credit")))));
        		}
        		if(rs!=null)
        			rs.close();
    		}
    		strQuery = SQLParser.getSqlQuery("checkprdrepaycapacity^"+strPrdcode+"^"+strRepayId
					+"^"+strIncomefrom +"^"+strIncometo
					+"^"+strIncomefrom +"^"+strIncometo
					+"^"+strIncomefrom +"^"+strIncometo);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				if(rs.getInt(1)!=0)
				{
				strExp = strExp + " Gross Monthly Income Range is already defined for the given amount range ";
				throw new Exception(strExp);
				}
			}
			
    		if(strAction.equalsIgnoreCase("insert"))
    		{
    			arrValues.add(strPrdcode);
    			strRepayId=getMaxIncomeId(strPrdcode);
    			arrValues.add(strRepayId);
    			arrValues.add(strIncomefrom);
    			arrValues.add(strIncometo);
    			arrValues.add(correctNull((String)hshValues.get("txt_sustanencesalaried")));
    			arrValues.add(correctNull((String)hshValues.get("txt_sustanencenonsalaried")));
    			arrValues.add(correctNull((String)hshValues.get("txt_sustanenceartificialbodies")));
    			arrValues.add(correctNull((String)hshValues.get("txt_creditscheme")));
    			
    			hshQuery.put("arrValues",arrValues);
    			hshQuery.put("strQueryId","insprdrepaycapacity");
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				
    		} 
    		else if(strAction.equalsIgnoreCase("update"))
    		{
    			arrValues.add(strIncomefrom);
    			arrValues.add(strIncometo);
    			arrValues.add(correctNull((String)hshValues.get("txt_sustanencesalaried")));
    			arrValues.add(correctNull((String)hshValues.get("txt_sustanencenonsalaried")));
    			arrValues.add(correctNull((String)hshValues.get("txt_sustanenceartificialbodies")));
    			arrValues.add(correctNull((String)hshValues.get("txt_creditscheme")));
    			
    			arrValues.add(strPrdcode);
    			arrValues.add(strRepayId);
    			
    			hshQuery.put("arrValues",arrValues);
    			hshQuery.put("strQueryId","updprdrepaycapacity");
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
    		}
    		else if(strAction.equalsIgnoreCase("delete"))
    		{
    			arrValues.add(strPrdcode);
    			arrValues.add(strRepayId);
    			
    			hshQuery.put("arrValues",arrValues);
    			hshQuery.put("strQueryId","delprdrepaycapacitybyid");
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
    		}
    		try
			{
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				HashMap HashMap3 = new HashMap();
		        HashMap3.put("prdCode", correctNull((String)hshValues.get("prdCode")));
		        EJBInvoker.executeStateLess("setproducts", HashMap3, "updateProductSaveStatus");
			}
			catch(Exception se)
			{
				throw new Exception("Transaction Failed ");
			}
    		hshValues.put("repayid",strRepayId);
    		hshRecord=getIncomeData(hshValues);
    		
    		StringBuilder strAt = new StringBuilder();
    		if(!strAction.equalsIgnoreCase("delete"))
    		{
	    		strAt.append("~ Gross Annual Income Range From = "+Helper.correctNull((String)hshValues.get("txt_incomefrom")));
	    		strAt.append("~ Gross Annual Income Range To = "+Helper.correctNull((String)hshValues.get("txt_incometo")));
	    		strAt.append("~ Sustenance Required for Salaried (%) = "+Helper.correctNull((String)hshValues.get("txt_sustanencesalaried")));
	    		strAt.append("~ Sustenance Required for Non Salaried (%) = "+Helper.correctNull((String)hshValues.get("txt_sustanencenonsalaried")));
	    		/*strAt.append("~ Sustenance Required for Artificial Bodies (%) = "+Helper.correctNull((String)hshValues.get("txt_sustanenceartificialbodies")));
	    		strAt.append("~ Union credit scheme repay capacity(%) = "+Helper.correctNull((String)hshValues.get("txt_creditscheme")));*/
    		}
    		if(correctNull((String)hshValues.get("hidRecordflag")).equals("Y"))
				hshValues.put("hidAction", "update");
    		int intProductCode = Integer.parseInt(strPrdcode);
			String strPrdCode1= Integer.toString(intProductCode);	
    		AuditTrial.auditNewLog(hshValues,"343",strPrdCode1,strAt.toString(),sbolddata.toString());
    		
    		hshValues.put("strprdtype", strprdtype);
			
			/*if(Helper.correctNull(ApplicationParams.getstrOnlineEnabled()).equalsIgnoreCase("YES")){
			if(strinternetproduct.equalsIgnoreCase("YES")){
				EJBInvoker.executeStateLess("setproducts", hshValues, "updateOnlineRepayCapacity");
			}}*/
    	}
    	catch(Exception ex)
    	{
    		throw new EJBException("Error in updateIncomeData :: "+ex.getMessage());
    	}finally
    	{
    		
    	}
    	
    	return hshRecord;
    }
    
    public HashMap getIncomeData(HashMap hshValues)
    {
    	HashMap hshRecord=new HashMap();
    	ResultSet rs=null;
    	String strPrdcode="";
    	String strRepayId="";
    	String strQuery="";
    	boolean recordflag=false; 
    	try{
    		
    		strPrdcode=correctNull((String)hshValues.get("prdCode"));
    		strRepayId=correctNull((String)hshValues.get("repayid"));
    		if(strRepayId.equals(""))
    		{
    			strRepayId=correctNull((String)hshValues.get("selincomerange"));
    		}
    		
    		strQuery=SQLParser.getSqlQuery("selprdrepaycapacity^"+strPrdcode+"^"+strRepayId);
    		
    		if(!strRepayId.equals(""))
    		{
    			rs=DBUtils.executeQuery(strQuery);
    			if(rs.next())
        		{
        			recordflag=true;
        			hshRecord.put("incomerangefrom",correctNull(rs.getString("repay_incrangefrom")));
        			hshRecord.put("incomerangeto",correctNull(rs.getString("repay_incrangeto")));
        			hshRecord.put("sustenancesalaried",correctNull(rs.getString("repay_salariedsustanece")));
        			hshRecord.put("sustenancenonsalaried",correctNull(rs.getString("repay_nonsalariedsustanece")));
        			hshRecord.put("sustenanceartificialbodies",correctNull(rs.getString("repay_artificialsustanece")));
        			hshRecord.put("creditscheme",correctNull(rs.getString("repay_credit")));
        			hshRecord.put("selincomerange",strRepayId);
        		}
    		}
    		
    		if(rs!=null)
    		{
    			rs.close();
    		}    		  		
    		
    		if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
    		
    	}catch (Exception e) {
			throw new EJBException("Error in getIncomeData :: "+e.getMessage());
		}finally
		{
			
		}
    	
    	return hshRecord;
    }
    
    private String getMaxIncomeId(String strPrdcode)
    {
    	String strRepaycode="";
    	ResultSet rs=null;
    	String strQuery="";
    	try{
    		strQuery=SQLParser.getSqlQuery("selprdrepaycapacitymaxid^"+strPrdcode);
    		rs=DBUtils.executeQuery(strQuery);
    		if(rs.next())
    		{
    			strRepaycode=correctNull(rs.getString("maxid"));
    		}
    	}catch(Exception ex)
    	{
    		throw new EJBException("Error in getting Maxid of getMaxIncomeId :: "+ex.getMessage());
    	}
    	return strRepaycode;
    }
    public HashMap getRentInsureData(HashMap hshRequestValues) 
	{
    	ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strQuery ="";
		String strPrdCode ="";
		String strProcessID ="";
		boolean recordflag=false;
		try
		{	
			strPrdCode = correctNull((String)hshRequestValues.get("prdCode"));
			strProcessID =  correctNull((String )hshRequestValues.get("hiddesc"));	
			if(!strProcessID.equals(""))
			{
				strQuery = SQLParser.getSqlQuery("selrentinsurechargedata^"+strPrdCode+"^"+strProcessID);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					recordflag=true;
					hshRecord.put("richrg_rangefrom",Helper.correctDouble((String)rs.getString("richrg_rangefrom")));
					hshRecord.put("richrg_rangeto",Helper.correctDouble((String)rs.getString("richrg_rangeto")));
					hshRecord.put("richrg_chrgcollect1",Helper.correctDouble((String)rs.getString("richrg_chrgcollect1")));
					hshRecord.put("richrg_chrgcollect2",Helper.correctDouble((String)rs.getString("richrg_chrgcollect2")));
				}
			}
			hshRecord.put("strPrdCode",strPrdCode);
			hshRecord.put("hidId",strProcessID);
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getDocumentData login  "+ce.toString());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection getDocumentData"+cf.getMessage());
			}
		}
		return hshRecord;
	}
	public HashMap updateRentInsureData(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String strPrdCode = null;
		String strrangefrom="",strrangeto="",strExp="$";
		String strQuery="";
		String strProcessID =null;
		ResultSet rs=null;
		StringBuilder sbAuditTrial=new StringBuilder();
		String strLoanType="";
		StringBuilder sbolddata=new StringBuilder();
		try
		{	
		strLoanType=correctNull((String)hshValues.get("prdtype"));
		if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
		{
			rs = DBUtils.executeLAPSQuery("selrentinsurechargedata^"+Helper.correctNull((String)hshValues.get("prdCode"))+"^"+
					Helper.correctNull((String)hshValues.get("hiddesc")));
			while(rs.next())
			{
				sbolddata.append("Amount Range From ="+Helper.formatDoubleValue(Double.parseDouble((Helper.correctDouble((String)rs.getString("richrg_rangefrom")))))+
						"~Amount Range To ="+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("richrg_rangeto"))))+
						"~Charges to be collected (%) ="+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("richrg_chrgcollect1"))))+"/"+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("richrg_chrgcollect2")))));
			}
			if(rs!=null)
				rs.close();
		}
			if(strAction.equals("insert"))
			{
				strPrdCode = correctNull((String)hshValues.get("prdCode"));
				strrangefrom=correctNull((String)hshValues.get("prd_procrangefrom"));
				strrangeto=correctNull((String)hshValues.get("prd_procrangeto"));
				strQuery = SQLParser.getSqlQuery("checkrentinsurerangeins^"+strPrdCode
						+"^"+strrangefrom +"^"+strrangeto
						+"^"+strrangefrom +"^"+strrangeto
						+"^"+strrangefrom +"^"+strrangeto);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next())
				{
					if(rs.getInt(1)!=0)
					{
					strExp = strExp + " Rent & Insurance charge is already defined for the given amount range ";
					throw new Exception(strExp);
					}
				}
				strProcessID = (String)getMaxRentInsureChageID(strPrdCode);				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshValues.put("hidId","strtermId");				
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","insrentinsurechargedata");
				arrValues.add(strPrdCode);
				arrValues.add(strProcessID);
				arrValues.add( correctNull((String)hshValues.get("prd_procrangefrom")));
				arrValues.add( correctNull((String)hshValues.get("prd_procrangeto")));
				arrValues.add( correctNull((String)hshValues.get("prd_chargecollectrs")));
				arrValues.add( correctNull((String)hshValues.get("prd_chargecollectquarter")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
			}
			else if(strAction.equals("update"))
			{
				strPrdCode = correctNull((String)hshValues.get("prdCode"));
				strProcessID =  correctNull((String )hshValues.get("hiddesc"));	
				strPrdCode = correctNull((String)hshValues.get("prdCode"));
				strrangefrom=correctNull((String)hshValues.get("prd_procrangefrom"));
				strrangeto=correctNull((String)hshValues.get("prd_procrangeto"));
				strQuery = SQLParser.getSqlQuery("checkrentinsurerangeupd^"+strPrdCode+"^"+strProcessID
						+"^"+strrangefrom +"^"+strrangeto
						+"^"+strrangefrom +"^"+strrangeto
						+"^"+strrangefrom +"^"+strrangeto);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next())
				{
					if(rs.getInt(1)!=0)
					{
					strExp = strExp + " Rent & Insurance charge is already defined for the given amount range ";
					throw new Exception(strExp);
					}
				}
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","updrentinsurechargedata");
				arrValues.add( correctNull((String)hshValues.get("prd_procrangefrom")));
				arrValues.add( correctNull((String)hshValues.get("prd_procrangeto")));
				arrValues.add( correctNull((String)hshValues.get("prd_chargecollectrs")));
				arrValues.add( correctNull((String)hshValues.get("prd_chargecollectquarter")));
				arrValues.add(strPrdCode);
				arrValues.add(strProcessID);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
			}
			else if(strAction.equals("delete"))
			{
				strPrdCode = correctNull((String)hshValues.get("prdCode"));
				strProcessID =  correctNull((String )hshValues.get("hiddesc"));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","delrentinsurechargedata");
				arrValues.add(strPrdCode);
				arrValues.add(strProcessID);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
			}
			//------------------Auditrial-----------------
			if(!strAction.equals("delete"))
			{
				sbAuditTrial.append("Amount Range From ="+correctNull((String)hshValues.get("prd_procrangefrom"))+
						"~Amount Range To ="+correctNull((String)hshValues.get("prd_procrangeto"))+
						"~Charges to be collected (%) ="+correctNull((String)hshValues.get("prd_chargecollectrs"))+"/"+correctNull((String)hshValues.get("prd_chargecollectquarter")));
			}
			    String strCode="";
			    if(strLoanType.equalsIgnoreCase("T"))
				{
			    	strCode="120";
				}
			    else{
			    	strCode="24";
			    }
			    int intProductCode = Integer.parseInt(strPrdCode);
				String strPrdCode1= Integer.toString(intProductCode);	
				AuditTrial.auditNewLog(hshValues,strCode,strPrdCode1,sbAuditTrial.toString(),sbolddata.toString());
			//------------------End-----------------------
			try
			{
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				HashMap HashMap3 = new HashMap();
		        HashMap3.put("prdCode", hshValues.get("prdCode"));
		        EJBInvoker.executeStateLess("setproducts", HashMap3, "updateProductSaveStatus");
			}
			catch(Exception se)
			{
				throw new Exception("Transaction Failed ");
			}
		}
		catch(Exception ce)
		{
			throw new EJBException(ce.toString());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection updateDocumentChargesData"+cf.getMessage());
			}
		}
		return hshValues;
	}
	public HashMap getJewelAppraisalData(HashMap hshRequestValues) 
	{
    	ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strQuery ="";
		String strPrdCode ="";
		String strProcessID ="";
		boolean recordflag=false;
		try
		{	
			strPrdCode = correctNull((String)hshRequestValues.get("prdCode"));
			strProcessID =  correctNull((String )hshRequestValues.get("hiddesc"));	
			if (!strProcessID.equals(""))
			{
				strQuery = SQLParser.getSqlQuery("seljewelappraisalchargedata^"+strPrdCode+"^"+strProcessID);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					recordflag=true;
					hshRecord.put("jachrg_rangefrom",Helper.correctDouble((String)rs.getString("jachrg_rangefrom")));
					hshRecord.put("jachrg_rangeto",Helper.correctDouble((String)rs.getString("jachrg_rangeto")));
					hshRecord.put("jachrg_percentchrg",Helper.correctDouble((String)rs.getString("jachrg_percentchrg")));
					hshRecord.put("jachrg_minactualchrg",Helper.correctDouble((String)rs.getString("jachrg_minactualchrg")));
					hshRecord.put("jachrg_maxactualchrg",Helper.correctDouble((String)rs.getString("jachrg_maxactualchrg")));
					hshRecord.put("jachrg_staticval",Helper.correctDouble((String)rs.getString("jachrg_staticval")));
				}
			}
			hshRecord.put("strPrdCode",strPrdCode);
			hshRecord.put("hidId",strProcessID);
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getDocumentData login  "+ce.toString());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection getDocumentData"+cf.getMessage());
			}
		}
		return hshRecord;
	}
	public HashMap updateJewelAppraisalData(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String strPrdCode = null;
		String strrangefrom="",strrangeto="",strExp="$";
		String strQuery="";
		String strProcessID =null;
		ResultSet rs=null;
		StringBuilder sbAuditTrial=new StringBuilder();
		String strLoanType="";
		String strKeyId = "";
		StringBuilder sbolddata=new StringBuilder();
		try
		{	
			strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			strLoanType=correctNull((String)hshValues.get("prdtype"));
		if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
		{
			rs = DBUtils.executeLAPSQuery("seljewelappraisalchargedata^"+Helper.correctNull((String)hshValues.get("prdCode"))+"^"+
					Helper.correctNull((String)hshValues.get("hiddesc")));
			while(rs.next())
			{
				sbolddata.append("Amount Range From ="+Helper.formatDoubleValue(Double.parseDouble((Helper.correctDouble((String)rs.getString("jachrg_rangefrom")))))+
						"~Amount Range To ="+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("jachrg_rangeto"))))+
						"~Jewel Appraisal Fees (%) ="+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("jachrg_percentchrg"))))+
						"~Min Jewel Appraisal Fees / Flat Jewel Appraisal fee ="+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("jachrg_minactualchrg"))))+
						"~Max Jewel Appraisal Fees ="+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("jachrg_maxactualchrg"))))+
						"~Static Value ="+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("jachrg_staticval")))));
			}
			if(rs!=null)
				rs.close();
		}
			if(strAction.equals("insert"))
			{
				strPrdCode = correctNull((String)hshValues.get("prdCode"));
				strrangefrom=correctNull((String)hshValues.get("prd_procrangefrom"));
				strrangeto=correctNull((String)hshValues.get("prd_procrangeto"));
				strQuery = SQLParser.getSqlQuery("checkjewelappraisalrangeins^"+strPrdCode
						+"^"+strrangefrom +"^"+strrangeto
						+"^"+strrangefrom +"^"+strrangeto
						+"^"+strrangefrom +"^"+strrangeto);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next())
				{
					if(rs.getInt(1)!=0)
					{
					strExp = strExp + " Jewel Appraisal charge is already defined for the given amount range ";
					throw new Exception(strExp);
					}
				}
				strProcessID = (String)getMaxJewelAppraisalChageID(strPrdCode);				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshValues.put("hidId","strtermId");				
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","insjewelappraisalchargedata");
				arrValues.add(strPrdCode);
				arrValues.add(strProcessID);
				arrValues.add( correctNull((String)hshValues.get("prd_procrangefrom")));
				arrValues.add( correctNull((String)hshValues.get("prd_procrangeto")));
				arrValues.add( correctNull((String)hshValues.get("prd_procfees")));
				arrValues.add( correctNull((String)hshValues.get("prd_procfees1")));
				arrValues.add( correctNull((String)hshValues.get("prd_procfees2")));
				arrValues.add( correctNull((String)hshValues.get("txtprd_staticval")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
			}
			else if(strAction.equals("update"))
			{
				strPrdCode = correctNull((String)hshValues.get("prdCode"));
				strProcessID =  correctNull((String )hshValues.get("hiddesc"));	
				strPrdCode = correctNull((String)hshValues.get("prdCode"));
				strrangefrom=correctNull((String)hshValues.get("prd_procrangefrom"));
				strrangeto=correctNull((String)hshValues.get("prd_procrangeto"));
				strQuery = SQLParser.getSqlQuery("checkjewelappraisalrangeupd^"+strPrdCode+"^"+strProcessID
						+"^"+strrangefrom +"^"+strrangeto
						+"^"+strrangefrom +"^"+strrangeto
						+"^"+strrangefrom +"^"+strrangeto);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next())
				{
					if(rs.getInt(1)!=0)
					{
					strExp = strExp + " Jewel Appraisal charge is already defined for the given amount range ";
					throw new Exception(strExp);
					}
				}
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","updjewelappraisalchargedata");
				
				arrValues.add( correctNull((String)hshValues.get("prd_procrangefrom")));
				arrValues.add( correctNull((String)hshValues.get("prd_procrangeto")));
				arrValues.add( correctNull((String)hshValues.get("prd_procfees")));
				arrValues.add( correctNull((String)hshValues.get("prd_procfees1")));
				arrValues.add( correctNull((String)hshValues.get("prd_procfees2")));
				arrValues.add( correctNull((String)hshValues.get("txtprd_staticval")));
				arrValues.add(strPrdCode);
				arrValues.add(strProcessID);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
			}
			else if(strAction.equals("delete"))
			{
				strPrdCode = correctNull((String)hshValues.get("prdCode"));
				strProcessID =  correctNull((String )hshValues.get("hiddesc"));

				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				
				hshQuery.put("strQueryId","deljewelappraisalchargedata");
				arrValues.add(strPrdCode);
				arrValues.add(strProcessID);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
			}

			//------------------Auditrial-----------------
			if(!strAction.equals("delete"))
			{
				sbAuditTrial.append("Amount Range From ="+correctNull((String)hshValues.get("prd_procrangefrom"))+
						"~Amount Range To ="+correctNull((String)hshValues.get("prd_procrangeto"))+
						"~Jewel Appraisal Fees (%) ="+correctNull((String)hshValues.get("prd_procfees"))+
						"~Min Jewel Appraisal Fees / Flat Jewel Appraisal fee ="+correctNull((String)hshValues.get("prd_procfees1"))+
						"~Max Jewel Appraisal Fees ="+correctNull((String)hshValues.get("prd_procfees2"))+
						"~Static Value ="+correctNull((String)hshValues.get("txtprd_staticval")));
			}
			    String strCode="";
			    if(strLoanType.equalsIgnoreCase("T"))
				{
			    	strCode="125";
				}
			    else{
			    	strCode="28";
			    }
			    
			    /*if(correctNull((String)hshValues.get("hidRecordflag")).equals("Y"))
					hshValues.put("hidAction", "update");*/
			    int intProductCode = Integer.parseInt(strPrdCode);
				String strPrdCode1= Integer.toString(intProductCode);	
				AuditTrial.auditNewLog(hshValues,strCode,strPrdCode1,sbAuditTrial.toString(),sbolddata.toString());
			//------------------End-----------------------

			try
			{
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				HashMap HashMap3 = new HashMap();
		        HashMap3.put("prdCode", hshValues.get("prdCode"));
		        EJBInvoker.executeStateLess("setproducts", HashMap3, "updateProductSaveStatus");
			}
			catch(Exception se)
			{
				throw new Exception("Transaction Failed ");
			}
		}
		catch(Exception ce)
		{
			throw new EJBException(ce.toString());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection updateDocumentChargesData"+cf.getMessage());
			}
		}
		return hshValues;
	}
	private String getMaxRentInsureChageID(String strPrdCode)
	{		
		String strQuery="";
		ResultSet rs = null;
		String termId = "";
		try
		{	
			strQuery = SQLParser.getSqlQuery("selmaxrentinsurechargeid^"+strPrdCode);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				termId = rs.getString(1) ;				
			}
			rs.close();		
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getData "+ce.toString());
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
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
						
			}
		}
		return termId;
	}
	private String getMaxJewelAppraisalChageID(String strPrdCode)
	{		
		String strQuery="";
		ResultSet rs = null;
		String termId = "";
		try
		{	
			strQuery = SQLParser.getSqlQuery("selmaxjewelappraisalchargeid^"+strPrdCode);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				termId = rs.getString(1) ;				
			}
			rs.close();		
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getData "+ce.toString());
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
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
						
			}
		}
		return termId;
	}
	
	
	public void updateSpecificEligiblity(HashMap hshValues) 
	{
		ResultSet rs = null;
		String strQuery=null;
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		
		try
		{
			String strAction = correctNull((String)hshValues.get("hidAction"));
			String strPrdcode=correctNull((String)hshValues.get("prdCode"));
			String prd_collateral=Helper.correctInt((String)hshValues.get("prd_collateral"));
			String prd_liqsecurity =Helper.correctInt((String)hshValues.get("prd_liqsecurity"));
			String prd_liqother=Helper.correctInt((String)hshValues.get("prd_liqother"));
			String prd_minservice=Helper.correctInt((String)hshValues.get("prd_minservice"));
			String prd_nonlist =Helper.correctInt((String)hshValues.get("prd_nonlist"));
			String txtprd_loanperiod=Helper.correctInt((String)hshValues.get("txtprd_loanperiod"));
			String prd_proofownres =Helper.correctInt((String)hshValues.get("prd_proofownres"));
			String prd_loanperiod=Helper.correctInt((String)hshValues.get("prd_loanperiod"));
			String prd_repayperiodhouse=Helper.correctInt((String)hshValues.get("prd_repayperiodhouse"));
			String prd_minconfservice=Helper.correctInt((String)hshValues.get("prd_minconfservice"));
		    String prd_maxageofveh=Helper.correctInt((String)hshValues.get("txt_maxageveh"));
		    
			if(strAction.equalsIgnoreCase("update"))
			{
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(strPrdcode);
				hshQuery.put("arrValues", arrValues);				
				hshQuery.put("strQueryId","del_specificeligible");
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size","2");
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","ins_specificeligible");
				arrValues.add(strPrdcode);
				arrValues.add(Helper.correctInt((String)hshValues.get("prd_collateral")));//1
				arrValues.add(Helper.correctInt((String)hshValues.get("prd_liqsecurity")));//2
				arrValues.add(Helper.correctInt((String)hshValues.get("prd_liqother")));//3
				arrValues.add(Helper.correctInt((String)hshValues.get("prd_minservice")));//4
				arrValues.add(Helper.correctInt((String)hshValues.get("prd_nonlist")));//5
				arrValues.add(Helper.correctInt((String)hshValues.get("txtprd_loanperiod")));//6
				
				arrValues.add(Helper.correctInt((String)hshValues.get("prd_proofownres")));//5
				arrValues.add(Helper.correctInt((String)hshValues.get("prd_loanperiod")));//6
				arrValues.add(Helper.correctInt((String)hshValues.get("prd_repayperiodhouse")));//7
				arrValues.add(prd_minconfservice);//8
				arrValues.add(Helper.correctInt((String)hshValues.get("txt_costcautiondep")));//9
				arrValues.add(Helper.correctInt((String)hshValues.get("txt_bookequip")));//10
				arrValues.add(Helper.correctInt((String)hshValues.get("txt_netrentreceivalble")));//11
				arrValues.add(Helper.correctInt((String)hshValues.get("txt_timesofnetrent")));//12
				arrValues.add(Helper.correctInt((String)hshValues.get("prd_minmarks")));//12
				arrValues.add(Helper.correctInt((String)hshValues.get("txt_mortgageperc")));//12
				arrValues.add(Helper.correctInt((String)hshValues.get("txt_noofapplicantsinc")));//12
				arrValues.add(Helper.correctInt((String)hshValues.get("txt_maxageveh")));//14
				arrValues.add(Helper.correctInt((String)hshValues.get("txt_maxnoofjointapplicant")));//15
				arrValues.add(Helper.correctInt((String)hshValues.get("txt_maxnoofguarantors")));//16
				arrValues.add(Helper.correctInt((String)hshValues.get("txt_maxnoofproperitier")));//17
				arrValues.add(Helper.correctInt((String)hshValues.get("txt_cibilscore")));//18
				arrValues.add(Helper.correctInt((String)hshValues.get("txt_crifscore")));//19
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			}
		}
				catch(Exception ce)
				{
					throw new EJBException("Error in updateSpecificEligiblity "+ce.toString());
				}
				
	}
	public HashMap getSpecificEligiblity(HashMap hshValues)
	{
	ResultSet rs = null;
	String strQuery="";
	String strQuery1="";
	ResultSet rs1=null;
	String strPrdcode="";
	try{
		strPrdcode=Helper.correctNull((String)hshValues.get("prdCode"));
		strQuery1=SQLParser.getSqlQuery("sel_cashloan^"+strPrdcode);
		rs1=DBUtils.executeQuery(strQuery1);
		if(rs1.next())
		{
			hshValues.put("prd_type",correctNull(rs1.getString("prd_type")));
			hshValues.put("prd_loantype",correctNull(rs1.getString("prd_loantype")));
			hshValues.put("prd_vehitype",correctNull(rs1.getString("prd_vehitype")));
		}
		strQuery=SQLParser.getSqlQuery("sel_specificeligible^"+strPrdcode);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{  	
	
			hshValues.put("prd_collateral",correctNull(rs.getString("prd_percollsec")));
			hshValues.put("prd_liqsecurity",correctNull(rs.getString("prd_percollsecliq")));
			hshValues.put("prd_liqother",correctNull(rs.getString("prd_percollsecoth")));
			hshValues.put("prd_minservice",correctNull(rs.getString("prd_perMinser")));
			hshValues.put("prd_nonlist",correctNull(rs.getString("prd_perdeal")));
			hshValues.put("txtprd_loanperiod",correctNull(rs.getString("prd_perretdate")));
			
			hshValues.put("prd_proofownres",correctNull(rs.getString("prd_vehproofamt")));
			hshValues.put("prd_loanperiod",correctNull(rs.getString("prd_vehloanperiod")));
			hshValues.put("prd_repayperiodhouse",correctNull(rs.getString("prd_hourepperiod")));
			hshValues.put("prd_minconfservice",correctNull(rs.getString("prd_minconfservice")));
			hshValues.put("prd_CautionDeposit",correctNull(rs.getString("prd_CautionDeposit")));
			hshValues.put("prd_bookequipments",correctNull(rs.getString("prd_bookequipments")));
			hshValues.put("prd_leasenrReceivable",correctNull(rs.getString("prd_leasenrReceivable")));
			hshValues.put("prd_leasenrTimes",correctNull(rs.getString("prd_leasenrTimes")));
			hshValues.put("PRD_EXAMMINMARKS",correctNull(rs.getString("PRD_EXAMMINMARKS")));
			hshValues.put("PRD_COLLATRALPERC",correctNull(rs.getString("PRD_COLLATRALPERC")));
			hshValues.put("PRD_NOOFAPPLICNTINC",correctNull(rs.getString("PRD_NOOFAPPLICNTINC")));
			hshValues.put("txt_maxageveh",Helper.correctInt(rs.getString("prd_maxageofvehicle")));
			hshValues.put("prd_minnoofjointapp",Helper.correctInt(rs.getString("prd_maxnoofjointapp")));
			hshValues.put("prd_minnoofguarantors",Helper.correctInt(rs.getString("prd_maxnoofguarantor")));
			hshValues.put("prd_maxnoofproperitier",Helper.correctInt(rs.getString("prd_maxnoofproperitier")));
			hshValues.put("prd_mincibilscore",Helper.correctInt(rs.getString("prd_mincibilscore")));
			hshValues.put("prd_mincrifscore",Helper.correctInt(rs.getString("prd_mincrifscore")));
			
		}
		if(!strPrdcode.equalsIgnoreCase(""))
		{
		if(rs!=null)
		{
			rs.close();
		}
		rs=DBUtils.executeLAPSQuery("sel_proincomeflag^"+strPrdcode);
		if(rs.next())
		{
			hshValues.put("purpose",correctNull(rs.getString("prd_purpose")));			
		}
		
		}
	}	
		
	catch(Exception e){
						throw new EJBException("Error in getSpecificEligiblity "+e.toString());
						}
	
	return hshValues;
}
	public HashMap getDataFacility(HashMap HashMap)  
    {
       
        HashMap HashMap1 = null;      
        ResultSet resultset=null;
        ResultSet rs=null,rs1=null;
        String scoringpattern="";
        ArrayList arrRating=new ArrayList();
      
            try
            {
            	HashMap1 = new HashMap();
            	resultset=DBUtils.executeLAPSQuery("sel_prdinterest_agr^" + HashMap.get("fac_id"));
                 
               
                if(resultset.next())
                {
                    HashMap1.put("prd_lvr", Helper.correctDoubleQuote(correctNull(resultset.getString("fac_lvr"))));
                    HashMap1.put("prd_creditbureau", Helper.correctDoubleQuote(correctNull(resultset.getString("fac_creditbureau"))));
                    HashMap1.put("prd_collpass", Helper.correctDoubleQuote(correctNull(resultset.getString("fac_collpass"))));
                    HashMap1.put("prd_liqpass", Helper.correctDoubleQuote(correctNull(resultset.getString("fac_liqpass"))));
                    HashMap1.put("prd_collweight", Helper.correctDoubleQuote(correctNull(resultset.getString("fac_collweight"))));
                    HashMap1.put("prd_liqweight", Helper.correctDoubleQuote(correctNull(resultset.getString("fac_liqweight"))));
                    HashMap1.put("prd_repayselfemp", Helper.correctDoubleQuote(correctNull(resultset.getString("fac_repayselfemp"))));
                    HashMap1.put("prd_inspection", Helper.correctDoubleQuote(correctNull(resultset.getString("fac_inspection"))));
                    HashMap1.put("prd_selfretireage", Helper.correctDoubleQuote(correctNull(resultset.getString("fac_selfretireage"))));
                    HashMap1.put("prd_empretireage", Helper.correctDoubleQuote(correctNull(resultset.getString("fac_empretireage"))));
                    //HashMap1.put("prd_selfretireage", correctNull(resultset.getString("fac_selfretireage")));
                   // HashMap1.put("prd_empretireage", correctNull(resultset.getString("fac_empretireage")));
                    HashMap1.put("prd_oldvehiclemargin", Helper.correctDoubleQuote(correctNull(resultset.getString("fac_oldvehiclemargin"))));
                    HashMap1.put("prd_pp_limit_pensioner", Helper.correctDoubleQuote(correctNull(resultset.getString("fac_pp_limit_pensioner"))));
                    HashMap1.put("prd_pp_limit_emp_notobt", Helper.correctDoubleQuote(correctNull(resultset.getString("fac_pp_limit_emp_notobt"))));
                    HashMap1.put("prd_furmargin", Helper.correctDoubleQuote(correctNull(resultset.getString("fac_furmargin"))));
                    HashMap1.put("prd_allowance", Helper.correctDoubleQuote(correctNull(resultset.getString("fac_allowance"))));
                    HashMap1.put("prd_noofmonths", Helper.correctDoubleQuote(correctNull(resultset.getString("fac_noofmonths"))));
                    HashMap1.put("prd_coguincome", Helper.correctDoubleQuote(correctNull(resultset.getString("fac_coapguaincome"))));
                    HashMap1.put("prd_repayhol", Helper.correctDoubleQuote(correctNull(resultset.getString("fac_repayhol"))));
                    HashMap1.put("prd_collateralsec", Helper.correctDoubleQuote(correctNull(resultset.getString("fac_collateralsec"))));
                    HashMap1.put("prd_nri_eligibleage", Helper.correctDoubleQuote(correctNull(resultset.getString("fac_nri_eligibleage"))));
                    HashMap1.put("prd_typeofloan",Helper.correctDoubleQuote(correctNull(resultset.getString("fac_loantype"))));
                    HashMap1.put("prd_margin",Helper.correctDoubleQuote(correctNull(resultset.getString("fac_margin"))));
                    //HashMap1.put("prd_loanamount_NREFCAB",Helper.correctDoubleQuote(Helper.correctDouble(resultset.getString("fac_procfees"))));
                    HashMap1.put("prd_intrate_roi",Helper.correctDoubleQuote(Helper.correctDouble(resultset.getString("fac_docfees"))));
                    HashMap1.put("prd_docfees1",Helper.correctDoubleQuote(correctNull(resultset.getString("fac_docfees1"))));
                    HashMap1.put("prd_docfees2",Helper.correctDoubleQuote(correctNull(resultset.getString("fac_docfees2"))));
                    HashMap1.put("prd_procfees1",Helper.correctDoubleQuote(correctNull(resultset.getString("fac_procfees1"))));
                    HashMap1.put("prd_procfees2",Helper.correctDoubleQuote(correctNull(resultset.getString("fac_procfees2"))));
                    HashMap1.put("prd_procfees",Helper.correctDoubleQuote(correctNull(resultset.getString("fac_procfees"))));
                    HashMap1.put("prd_securitytype",Helper.correctDoubleQuote(correctNull(resultset.getString("fac_securitytype"))));
                    HashMap1.put("prd_tablecode",Helper.correctDoubleQuote(correctNull(resultset.getString("fac_tablecode"))));
                    HashMap1.put("prd_networth_percent",Helper.correctDoubleQuote(correctNull(resultset.getString("fac_networth_percent"))));
                    HashMap1.put("prd_intrate",Helper.correctDoubleQuote(correctNull(resultset.getString("fac_intrate"))));
                    HashMap1.put("prd_addlint",Helper.correctDoubleQuote(correctNull(resultset.getString("fac_addlint"))));
                    HashMap1.put("prd_totalint",Helper.correctDoubleQuote(correctNull(resultset.getString("fac_totalint"))));
                    HashMap1.put("prd_ratingdesc",Helper.correctDoubleQuote(correctNull(resultset.getString("fac_ratingdesc"))));
              }
                HashMap1.put("strProductType",Helper.correctNull((String)HashMap.get("fac_id")));
                rs=DBUtils.executeLAPSQuery("select_scoringpattern^"+Helper.correctNull((String)HashMap.get("fac_id")));
                if(rs.next())
                {
                	scoringpattern=Helper.correctInt((String)rs.getString("BUSS_BUSSID"));
                }
                HashMap1.put("scoringpattern", scoringpattern);
                
            }
            catch(Exception exception)
            {
                throw new EJBException("Error in getDataFacility " + exception.toString());
            }
        
        finally
        {
           
        }
        return HashMap1;
    }

	 public HashMap updateAgrimarginData(HashMap hshValues) 
		{	
		 
		
			
			HashMap hshQueryValues = new HashMap();
			HashMap hshQuery = null;
			ArrayList arrValues=new ArrayList();
			String strAction=(String)hshValues.get("hidAction");
			String strPrdCode = null;
			String strMarginID =null;
			String strrangefrom="",strrangeto="";
			String strExp="$";
			String strQuery="";
			ResultSet rs=null;
			StringBuilder sbAuditTrial=new StringBuilder();
			String strLoanType="";
			StringBuilder sbolddata=new StringBuilder(); 
			String strKeyId = "";
			String strmarginID = "";
			try
			{
				strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
				//strLoanType=correctNull((String)hshValues.get("prdtype"));
	 			strPrdCode = correctNull((String)hshValues.get("prdcode"));
	 			strrangefrom=correctNull((String)hshValues.get("prd_procrangefrom"));
				strrangeto=correctNull((String)hshValues.get("prd_procrangeto"));
		    	strmarginID =  correctNull((String )hshValues.get("selectmarginterm"));
		    //	String strRange = Helper.correctNull((String)hshValues.get("hiddesc"));
		    	if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
				{
					if(!strmarginID.equalsIgnoreCase(""))
	    	   		{
		    		   	strQuery=SQLParser.getSqlQuery("sel_COM_MARGINCOST^" + strPrdCode +"^"+strmarginID);
		    		   	rs = DBUtils.executeQuery(strQuery);
		    			while (rs.next()) 
		    			{
		    				sbolddata.append("Product Code ="+correctNull((String)rs.getString("margin_prdcode"))+
		    		 				"~Amount Range From Rs.= "+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("margin_range_from"))))+
		    						"~Amount Range To  Rs.= "+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("margin_range_to"))))+
		    						"~margin Amount (%) ="+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("margin_perct")))));	
		    			}
		    			if(rs!=null)
		    				rs.close();
	    			}
				}
		    	
		    	
				if(strAction.equalsIgnoreCase("INSERT"))
				{
					strMarginID = (String)getMaxCOM_MARGINCOST(strPrdCode);			
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();	
					
					strQuery = SQLParser.getSqlQuery("checkmarginrangeinscor^"+strPrdCode
							+"^"+strrangefrom +"^"+strrangeto
							+"^"+strrangefrom +"^"+strrangeto
							+"^"+strrangefrom +"^"+strrangeto);
					
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next())
					{
						if(rs.getInt(1)!=0)
						{
						strExp = strExp + " Check the existing amount range ";
						hshValues.put("strExp","strExp");		
						throw new Exception(strExp);
						}
					}
					
					hshQueryValues.put("size","1");
					hshValues.put("hidId","strtermId");				
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","ins_COM_MARGINCOST");
					arrValues.add(strPrdCode);
					arrValues.add(strMarginID);
					arrValues.add( correctNull((String)hshValues.get("prd_procrangefrom")));
					arrValues.add( correctNull((String)hshValues.get("prd_procrangeto")));
					arrValues.add( correctNull((String)hshValues.get("prd_procfees")));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
				}
				else if(strAction.equals("update"))
				{
					strMarginID = correctNull((String)hshValues.get("selectmarginterm"));			
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();	
					
					strQuery = SQLParser.getSqlQuery("checkmarginrangeupdcor^"+strPrdCode+"^"+strMarginID
							+"^"+strrangefrom +"^"+strrangeto
							+"^"+strrangefrom +"^"+strrangeto
							+"^"+strrangefrom +"^"+strrangeto);
					
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next())
					{
						if(rs.getInt(1)!=0)
						{
						strExp = strExp + " Check the existing amount range ";
						hshValues.put("strExp","strExp");		
						throw new Exception(strExp);
						}
					}
					
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","updateCOM_MARGINCOST");
					arrValues.add( correctNull((String)hshValues.get("prd_procrangefrom")));
					arrValues.add( correctNull((String)hshValues.get("prd_procrangeto")));
					arrValues.add( correctNull((String)hshValues.get("prd_procfees")));
					arrValues.add(strPrdCode);
					arrValues.add(strMarginID);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				else if(strAction.equals("delete"))
				{
					strMarginID = correctNull((String)hshValues.get("selectmarginterm"));			
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();					
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","deleteCOM_MARGINCOST");
					arrValues.add(strPrdCode);
					arrValues.add(strMarginID);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
				}
				
				
				//-----------------------Audittrial-----------------------
				if(!strAction.equals("delete"))
				{
						sbAuditTrial.append("Product Code ="+strPrdCode+
		 				"~Amount Range From Rs. = "+correctNull((String)hshValues.get("prd_procrangefrom"))+
						"~Amount Range To Rs. = "+correctNull((String)hshValues.get("prd_procrangeto"))+
						"~margin Amount (%) ="+correctNull((String)hshValues.get("prd_procfees")));	
				}
				if(Helper.correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("N"))
					hshValues.put("hidAction", "Insert");
				else if(strAction.equals("delete"))
					hshValues.put("hidAction", "delete");
				else
					hshValues.put("hidAction", "update");	
				int intProductCode = Integer.parseInt(strPrdCode);
				String strPrdCode1= Integer.toString(intProductCode),strCode="";
				if(strLoanType.equalsIgnoreCase("T"))
				{
			    	strCode="355";
				}
				else
				{
					strCode="27";
				}
				AuditTrial.auditNewLog(hshValues,strCode,strPrdCode1,sbAuditTrial.toString(),sbolddata.toString());
				//-----------------------End--------------------------------

				try
				{
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					HashMap HashMap3 = new HashMap();
			        HashMap3.put("prdCode",strPrdCode);
			        EJBInvoker.executeStateLess("setproducts", HashMap3, "updateProductSaveStatus");
				}
				catch(Exception se)
				{
					throw new Exception("Transaction Failed ");
				}
			}
			catch(Exception ce)
			{
				throw new EJBException(ce.toString());
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
				catch(Exception cf)
				{
					throw new EJBException("Error closing the connection "+cf.getMessage());
							
				}
			}
		
			hshValues=getAgrimarginData(hshValues);
			return hshValues;
		
		}
	 
	
	 private String getMaxCOM_MARGINCOST(String strPrdCode)
		{
			String strQuery="";
			ResultSet rs = null;
			String termId = "";
			try
			{	
				strQuery = SQLParser.getSqlQuery("selmaxCOM_MARGINCOST^"+strPrdCode);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					termId = rs.getString(1) ;				
				}
				rs.close();		
			}
			catch(Exception ce)
			{
				log.error(ce.toString());
				throw new EJBException("Error in getData "+ce.toString());
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
				catch(Exception cf)
				{
					throw new EJBException("Error closing the connection "+cf.getMessage());
							
				}
			}
			return termId;
		}
	
	
	  public HashMap getAgrimarginData(HashMap hshValues)  
	    {
	    	
	    	ResultSet rs = null;
			ArrayList vecRow = new ArrayList();
			ArrayList vecCol = new ArrayList();
			HashMap hshRecord = new HashMap();
			String strQuery = "";
			String strPrdCode = "";
			String strmarginID="";
			boolean recordflag=false;
	              
	       try
	            {
	    	 
	    	   strPrdCode = correctNull((String)hshValues.get("prdcode"));
	    	   strmarginID =  correctNull((String )hshValues.get("hiddesc"));	
	    	   if(!strmarginID.equalsIgnoreCase(""))
	    	   		{
	    		   	strQuery=SQLParser.getSqlQuery("sel_COM_MARGINCOST^"+strPrdCode+"^"+strmarginID);
	    		   	rs = DBUtils.executeQuery(strQuery);
	    			while (rs.next()) {
	    				
	    				vecCol = new ArrayList();
	    				vecCol.add(Helper.correctNull((String)rs.getString("margin_prdcode")));
	    				vecCol.add(Helper.correctNull((String)rs.getString("margin_id")));
	    				vecCol.add(Helper.correctNull((String)rs.getString("margin_range_from")));
	    				vecCol.add(Helper.correctNull((String)rs.getString("margin_range_to")));
	    				vecCol.add(Helper.correctNull((String)rs.getString("margin_perct")));
	    				if(!Helper.correctNull((String)rs.getString("margin_perct")).equalsIgnoreCase(""))
	    				{
	    					  recordflag=true;
	    				}
	    				vecRow.add(vecCol);
	    				}
	    			hshRecord.put("vecMarginRow", vecRow);
	    	   		}
	    	   if(recordflag)
	    			hshRecord.put("recordflag","Y");
	    		else
	    			hshRecord.put("recordflag","N");
	            }
	            catch(Exception exception)
	            {
	                throw new EJBException("Error in getData " + exception.toString());
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
	    			catch(Exception cf)
	    			{
	    				throw new EJBException("Error closing the connection "+cf.getMessage());
	    						
	    			}
	    		}
	    	
	            hshRecord.put("hidId",strmarginID);
	           hshRecord.put("strPrdCode",strPrdCode);
	            
	            
	        return hshRecord;
	    }
	  
	  public void updateAgriPropertiesData(HashMap hshValues) 
	  {
		HashMap hshQueryValues = new HashMap();
  		HashMap hshQuery = null;
  		ArrayList arrValues=new ArrayList();
  		String strPrdCode = null;
  			  		
  		try
  		{	 
   			strPrdCode = correctNull((String)hshValues.get("fac_id1"));
   			if(strPrdCode.equalsIgnoreCase(""))
   			{
   				strPrdCode = correctNull((String)hshValues.get("fac_id"));
   			}
   			String strAction=correctNull((String)hshValues.get("hidAction"));
  			
  			if(strAction.equalsIgnoreCase("insert"))
  			{
  				hshQueryValues = new HashMap();
  				hshQueryValues.put("size","2");
  				hshQuery = new HashMap();
  				arrValues = new ArrayList();
  				hshQuery.put("strQueryId","set_perprdagriproperties_delete");
  				arrValues.add(strPrdCode);
  				hshQuery.put("arrValues",arrValues);
  				hshQueryValues.put("1",hshQuery);
  				hshQuery = new HashMap();
  				arrValues=new ArrayList();
  				hshQuery.put("strQueryId","set_perprdagriproperties_insert");
  				arrValues.add(strPrdCode);
  				arrValues.add("0");
  				arrValues.add(Helper.correctInt((String)hshValues.get("txt_lubricants")));
  				arrValues.add(Helper.correctInt((String)hshValues.get("txt_repairs")));
  				arrValues.add("0");
  				arrValues.add("0");
  				arrValues.add("0");
  				arrValues.add("0");  				
  				hshQuery.put("arrValues",arrValues);
  				hshQueryValues.put("2",hshQuery);  				
  			}
  			else if(strAction.equals("delete"))
  			{  				
  				hshQueryValues = new HashMap();
  				hshQueryValues.put("size","1");
  				hshQuery = new HashMap();
  				arrValues=new ArrayList();  				
  				hshQuery.put("strQueryId","set_perprdagriproperties_delete");
  				arrValues.add(strPrdCode);
  				hshQuery.put("arrValues",arrValues);
  				hshQueryValues.put("1",hshQuery);
  			}
  			EJBInvoker.executeStateLess("dataaccess", hshQueryValues , "updatedata");
  		}
  		catch(Exception ce)
  		{
  			throw new EJBException("Error in updateAgriProperties==" +ce.toString());
  		}
	  }
      public HashMap getAgriPropertiesData(HashMap hshValues) 
      {
    	  ResultSet rs = null;
	  		final HashMap hshRecord = new HashMap();
	  		String strQuery = null;
	  		String strPrdCode = null;
	                
	        try
	        {
	      	   	strPrdCode = correctNull((String)hshValues.get("fac_id1"));
	      	   	if(strPrdCode.equalsIgnoreCase(""))
	      	   	{
	      	  	strPrdCode = correctNull((String)hshValues.get("fac_id"));
	      	   	}
	      		strQuery="";
	      		strQuery=SQLParser.getSqlQuery("set_perprdagriproperties_select^" + strPrdCode);
	      		rs = DBUtils.executeQuery(strQuery);
	      	   	if(rs.next()) 
	      		{	      				
      				hshRecord.put("lubricants",correctNull(rs.getString("sa_lubricants")));
      				hshRecord.put("repairs",correctNull(rs.getString("sa_repairs")));	      				
	      		}
	      			
	     	}
	        catch(Exception exception)
	        {
	        	throw new EJBException("Error in getAgriPropertiesdata"+exception.toString());
	        }
	        finally
	        {
	        	try{
	        		if(rs!=null) 
	        		{
	        			rs.close();
	        		}
	            }
	        	catch(final Exception ee)
	        	{
			  	    throw new EJBException("Error in closing connection=="+ee.toString());
	        	}
	        }
	          return hshRecord;
      }
	
      public HashMap getCollateralSecurity(HashMap hshValues)  
      {
      	
      	ResultSet rs = null;
  		ArrayList vecRow = new ArrayList();
  		ArrayList vecCol = new ArrayList();
  		HashMap hshRecord = new HashMap();
  		String strQuery = "";
  		String strPrdCode = "";
  		String strColID="";
  		
                
         try
              {
      	   
      	   strPrdCode = correctNull((String)hshValues.get("prdCode"));
      	   strColID =  correctNull((String )hshValues.get("hidColId"));	
      	 
      	   if(!strColID.equalsIgnoreCase(""))
      	   		{
      		   	strQuery=SQLParser.getSqlQuery("selColSeclist^" + strPrdCode +"^"+strColID);
      		   	rs = DBUtils.executeQuery(strQuery);
      			while (rs.next()) {
      				vecCol = new ArrayList();
      				vecCol.add(Helper.correctNull((String)rs.getString("COL_PRDCODE")));
      				vecCol.add(Helper.correctNull((String)rs.getString("COL_ID")));
      				vecCol.add(Helper.correctNull((String)rs.getString("COL_RANGE_FROM")));
      				vecCol.add(Helper.correctNull((String)rs.getString("COL_RANGE_TO")));
      				vecCol.add(Helper.correctNull((String)rs.getString("COL_PERCENT")));
      				vecCol.add(Helper.correctNull((String)rs.getString("col_immovable_per")));
      				vecCol.add(Helper.correctNull((String)rs.getString("col_other_per")));
      				vecRow.add(vecCol);
      				}
      			hshRecord.put("vecMarginRow", vecRow);
      	   		}
      	   if(rs!=null)
      	   {
      		   rs.close();
      	   }
      	   strQuery=SQLParser.getSqlQuery("sel_prdtype_personal^" + strPrdCode);
		   	rs = DBUtils.executeQuery(strQuery);
      		if(rs.next())
      		{
      			hshRecord.put("product_type", Helper.correctNull((String)rs.getString("prd_type")));
      		}
      		 if(rs!=null)
        	   {
        		   rs.close();
        	   }
              }
              catch(Exception exception)
              {
                  throw new EJBException("Error in getData " + exception.toString());
              }
              finally{
              	vecRow=null;
              	vecCol=null;
              }
              hshRecord.put("hidColId",strColID);
          return hshRecord;
      }
      
      public HashMap updateCollateralSecurity(HashMap hshValues) 
  	{	
  		HashMap hshQueryValues = new HashMap();
  		HashMap hshQuery = null;
  		ArrayList arrValues=new ArrayList();
  		String strAction=(String)hshValues.get("hidActionMode");
  		String strPrdCode = null;
  		String strColID =null;
  		String strAmtfrom="",strAmtto="",strQuery="";
  		String strExp="$";
  		ResultSet rs = null;
  		strPrdCode = correctNull((String)hshValues.get("prdCode"));
  		
  		try
  		{	 
  			if(strAction.equalsIgnoreCase("INSERT"))
  			{
  				
  				strAmtfrom=correctNull((String)hshValues.get("prd_procrangefrom"));
  				strAmtto=correctNull((String)hshValues.get("prd_procrangeto"));
  				
  				strQuery=SQLParser.getSqlQuery("checkColSecAmountRange^"+strPrdCode+"^"+strAmtfrom+"^"+strAmtto+"^"+strAmtfrom+"^"+strAmtto+"^"+strAmtfrom+"^"+strAmtto);
  				rs=DBUtils.executeQuery(strQuery);
  				
  				if(rs.next())
  					{
  					if(rs.getInt(1)!=0)
  						{
  						strExp = strExp + " Check the existing amount range ";
  						throw new Exception(strExp);
  						}
  					}
  				strColID = (String)getMaxColID(strPrdCode);			
  				hshQueryValues = new HashMap();
  				hshQuery = new HashMap();					
  				hshQueryValues.put("size","1");
  				hshValues.put("hidColId",strColID);				
  				arrValues=new ArrayList();
  				hshQuery.put("strQueryId","insertColSecData");
  				arrValues.add(strPrdCode);
  				arrValues.add(strColID);
  				arrValues.add( correctNull((String)hshValues.get("prd_procrangefrom")));
  				arrValues.add( correctNull((String)hshValues.get("prd_procrangeto")));
  				arrValues.add( correctNull((String)hshValues.get("prd_procfees")));
  				arrValues.add( correctNull((String)hshValues.get("prd_immovablesecurity")));
  				arrValues.add( correctNull((String)hshValues.get("prd_othersecurity")));
  				hshQuery.put("arrValues",arrValues);
  				hshQueryValues.put("1",hshQuery);
  			
  			}
  			else if(strAction.equals("update"))
  			{
  				strColID = correctNull((String)hshValues.get("selectmarginterm"));
  				strAmtfrom=correctNull((String)hshValues.get("prd_procrangefrom"));
  				strAmtto=correctNull((String)hshValues.get("prd_procrangeto"));
  				strQuery=SQLParser.getSqlQuery("checkColSecAmountRange1^"+strPrdCode+"^"+strColID+"^"+strAmtfrom+"^"+strAmtto+"^"+strAmtfrom+"^"+strAmtto+"^"+strAmtfrom+"^"+strAmtto);
  				rs=DBUtils.executeQuery(strQuery);
  			
  			if(rs.next())
  				{
  				if(rs.getInt(1)!=1)
  					{
  					strExp = strExp + " Check the existing amount range ";
  					throw new Exception(strExp);
  					}
  				}
  				
  					
  				hshQueryValues = new HashMap();
  				hshQuery = new HashMap();
  				arrValues=new ArrayList();
  				hshQuery.put("strQueryId","updateColSecdata");
  				arrValues.add( correctNull((String)hshValues.get("prd_procrangefrom")));
  				arrValues.add( correctNull((String)hshValues.get("prd_procrangeto")));
  				arrValues.add( correctNull((String)hshValues.get("prd_procfees")));
  				arrValues.add( correctNull((String)hshValues.get("prd_immovablesecurity")));
  				arrValues.add( correctNull((String)hshValues.get("prd_othersecurity")));
  				arrValues.add(strPrdCode);
  				arrValues.add(strColID);
  				hshQuery.put("arrValues",arrValues);
  				hshQueryValues.put("size","1");
  				hshQueryValues.put("1",hshQuery);
  				//EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
  				
  			}
  			else if(strAction.equals("delete"))
  			{
  				strColID = correctNull((String)hshValues.get("selectmarginterm"));
  				hshQueryValues = new HashMap();
  				hshQuery = new HashMap();					
  				hshQueryValues.put("size","1");
  				hshQuery.put("strQueryId","deleteColSecdata");
  				arrValues.add(strPrdCode);
  				arrValues.add(strColID);
  				hshQuery.put("arrValues",arrValues);
  				hshQueryValues.put("size","1");
  				hshQueryValues.put("1",hshQuery);
  				//EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
  			}

  			try
  			{
  				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
  				
  			}
  			catch(Exception se)
  			{
  				throw new Exception("Transaction Failed ");
  			}

  			//for Entering the values into auditrial
   			String strActionData = "Amount Range From ="+correctNull((String)hshValues.get("prd_procrangefrom"))+
  				"~Amount Range To ="+correctNull((String)hshValues.get("prd_procrangeto"))+
  				"~Collateral Security/Immovable Security (%)="+correctNull((String)hshValues.get("prd_procfees"));
  		
   			AuditTrial.auditLog(hshValues, "127",Helper.correctNull((String) hshValues.get("strUserId")), strActionData.toString());
  		}
  		catch(Exception ce)
  		{
  			throw new EJBException(ce.toString());
  		}
  		finally{
  			hshQueryValues=null;
  			arrValues=null;
  			hshQuery=null;
  		}
  		hshValues=getCollateralSecurity(hshValues);
  		return hshValues;
  	}
      private String getMaxColID(String strPrdCode)
  	{
  		String strQuery="";
  		ResultSet rs = null;
  		String termId = "";
  		try
  		{	
  			strQuery = SQLParser.getSqlQuery("selmaxColSecid^"+strPrdCode);
  			rs = DBUtils.executeQuery(strQuery);
  			while(rs.next())
  			{
  				termId = rs.getString(1) ;				
  			}
  			rs.close();		
  		}
  		catch(Exception ce)
  		{
  			throw new EJBException("Error in getMaxNriID "+ce.toString());
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
  		return termId;
  	}
      
      
   public HashMap updateSetcorpcollateralSecurity(HashMap hshValues) 
  	{	
  		HashMap hshQueryValues = new HashMap();
  		HashMap hshQuery = null;
  		ArrayList arrValues=new ArrayList();
  		String strAction=(String)hshValues.get("hidActionMode");
  		String strPrdCode = null;
  		String strSno =null;
  		String strAmtfrom="",strAmtto="",strQuery="";
  		String strExp="$";
  		ResultSet rs = null;
  		String strFacid=null;
  		strPrdCode = correctNull((String)hshValues.get("facility_code"));
  		strFacid=Helper.correctNull((String)hshValues.get("facility_id"));
  		
  		try
  		{	 
  			if(strAction.equalsIgnoreCase("INSERT"))
  			{
  				
  				strAmtfrom=correctNull((String)hshValues.get("prd_procrangefrom"));
  				strAmtto=correctNull((String)hshValues.get("prd_procrangeto"));
  				
  				strQuery=SQLParser.getSqlQuery("compins_set_corpcollateralsecurity^"+strPrdCode+"^"+strFacid+"^"+strAmtfrom+"^"+strAmtto+"^"+strAmtfrom+"^"+strAmtto+"^"+strAmtfrom+"^"+strAmtto);
  				rs=DBUtils.executeQuery(strQuery);
  				
  				if(rs.next())
  					{
  					if(rs.getInt(1)!=0)
  						{
  						strExp = strExp + " Check the existing amount range ";
  						throw new Exception(strExp);
  						}
  					}
  				strSno= (String)getMaxColSno(strFacid);			
  				hshQueryValues = new HashMap();
  				hshQuery = new HashMap();					
  				hshQueryValues.put("size","1");
  				hshValues.put("hidColId",strSno);				
  				arrValues=new ArrayList();
  				hshQuery.put("strQueryId","ins_set_corpcollateralsecurity");
  				arrValues.add(strPrdCode);
  				arrValues.add(strFacid);
  				arrValues.add(strSno);
  				arrValues.add( correctNull((String)hshValues.get("prd_procrangefrom")));
  				arrValues.add( correctNull((String)hshValues.get("prd_procrangeto")));
  				arrValues.add( correctNull((String)hshValues.get("prd_procfees")));
  				hshQuery.put("arrValues",arrValues);
  				hshQueryValues.put("1",hshQuery);
  			
  			}
  			else if(strAction.equals("update"))
  			{
  				strSno = correctNull((String)hshValues.get("selectmarginterm"));
  				strAmtfrom=correctNull((String)hshValues.get("prd_procrangefrom"));
  				strAmtto=correctNull((String)hshValues.get("prd_procrangeto"));
  				strQuery=SQLParser.getSqlQuery("comp_set_corpcollateralsecurity^"+strPrdCode+"^"+strFacid+"^"+strSno+"^"+strAmtfrom+"^"+strAmtto+"^"+strAmtfrom+"^"+strAmtto+"^"+strAmtfrom+"^"+strAmtto);
  				rs=DBUtils.executeQuery(strQuery);
  			
  			if(rs.next())
  				{
  				if(rs.getInt(1)!=1)
  					{
  					strExp = strExp + " Check the existing amount range ";
  					throw new Exception(strExp);
  					}
  				}
  				
  					
  				hshQueryValues = new HashMap();
  				hshQuery = new HashMap();
  				arrValues=new ArrayList();
  				hshQuery.put("strQueryId","upd_set_corpcollateralsecurity");
  				arrValues.add( correctNull((String)hshValues.get("prd_procrangefrom")));
  				arrValues.add( correctNull((String)hshValues.get("prd_procrangeto")));
  				arrValues.add( correctNull((String)hshValues.get("prd_procfees")));
  				arrValues.add(strPrdCode);
  				arrValues.add(strFacid);
  				arrValues.add(strSno);
  				hshQuery.put("arrValues",arrValues);
  				hshQueryValues.put("size","1");
  				hshQueryValues.put("1",hshQuery);
  				//EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
  				
  			}
  			else if(strAction.equals("delete"))
  			{
  				strSno = correctNull((String)hshValues.get("selectmarginterm"));
  				hshQueryValues = new HashMap();
  				hshQuery = new HashMap();					
  				hshQueryValues.put("size","1");
  				hshQuery.put("strQueryId","del_set_corpcollateralsecurity");
  				arrValues.add(strPrdCode);
  				arrValues.add(strFacid);
  				arrValues.add(strSno);
  				hshQuery.put("arrValues",arrValues);
  				hshQueryValues.put("size","1");
  				hshQueryValues.put("1",hshQuery);
  				//EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
  			}

  			try
  			{
  				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
  				
  			}
  			catch(Exception se)
  			{
  				throw new Exception("Transaction Failed ");
  			}

  			//for Entering the values into auditrial
   			String strActionData = "Amount Range From ="+correctNull((String)hshValues.get("prd_procrangefrom"))+
  				"~Amount Range To ="+correctNull((String)hshValues.get("prd_procrangeto"))+
  				"~Collateral Security/Immovable Security (%)="+correctNull((String)hshValues.get("prd_procfees"));
  		
   			AuditTrial.auditLog(hshValues, "127",Helper.correctNull((String) hshValues.get("strUserId")), strActionData.toString());
  		}
  		catch(Exception ce)
  		{
  			throw new EJBException(ce.toString());
  		}
  		finally{
  			hshQueryValues=null;
  			arrValues=null;
  			hshQuery=null;
  		}
  		hshValues=getSet_corpcollateralSecurity(hshValues);
  		return hshValues;
  	}
   
    private String getMaxColSno(String strFacid)
  	{
  		String strQuery="";
  		ResultSet rs = null;
  		String termId = "";
  		try
  		{	
  			strQuery = SQLParser.getSqlQuery("maxid_set_corpcollateralsecurity^"+strFacid);
  			rs = DBUtils.executeQuery(strQuery);
  			while(rs.next())
  			{
  				termId = rs.getString(1) ;				
  			}
  			rs.close();		
  		}
  		catch(Exception ce)
  		{
  			throw new EJBException("Error in getMaxNriID "+ce.toString());
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
  		return termId;
  	}
      
      
      public HashMap getSet_corpcollateralSecurity(HashMap hshValues)  
      {
      	
      	ResultSet rs = null;
  		ArrayList vecRow = new ArrayList();
  		ArrayList vecCol = new ArrayList();
  		HashMap hshRecord = new HashMap();
  		String strQuery = "";
  		String strPrdCode = "";
  		String strSno="";
  		
  		  
         try
              {
        	 strPrdCode = correctNull((String)hshValues.get("facility_code"));
       		 String strFacid=Helper.correctNull((String)hshValues.get("facility_id"));  
      	  
       		strSno =  correctNull((String )hshValues.get("hidColId"));	
      	 
      	   if(!strSno.equalsIgnoreCase(""))
      	   		{
      		   	strQuery=SQLParser.getSqlQuery("sel_set_corpcollateralsecurity^" + strPrdCode +"^"+strFacid+"^"+strSno);
      		   	rs = DBUtils.executeQuery(strQuery);
      			while (rs.next()) {
      				vecCol = new ArrayList();
      				vecCol.add(Helper.correctNull((String)rs.getString("scol_FACCODE")));
      				vecCol.add(Helper.correctNull((String)rs.getString("scol_FACID")));
      				vecCol.add(Helper.correctNull((String)rs.getString("scol_FacSno")));
      				vecCol.add(Helper.correctNull((String)rs.getString("scol_RANGE_FROM")));
      				vecCol.add(Helper.correctNull((String)rs.getString("scol_RANGE_TO")));
      				vecCol.add(Helper.correctNull((String)rs.getString("scol_PERCENT")));
      				
      				vecRow.add(vecCol);
      				}
      			hshRecord.put("vecMarginRow", vecRow);
      	   		}
      	 
      	  
              }
              catch(Exception exception)
              {
                  throw new EJBException("Error in getData " + exception.toString());
              }
              finally{
              	vecRow=null;
              	vecCol=null;
              }
              hshRecord.put("hidColId",strSno);
          return hshRecord;
      }
      public void updateMCLRMaster(HashMap hshValues) 
    	{	
    		HashMap hshQueryValues = new HashMap();
    		HashMap hshQuery = new HashMap();;
    		ArrayList arrValues=new ArrayList();
    		String strAction="",strQuery="";
    		ResultSet rs=null;
    		String strExp="$";
    		Connection conn = null;
    		PreparedStatement stmt = null;
    		java.text.NumberFormat jtn	= java.text.NumberFormat.getInstance();
        	jtn.setMaximumFractionDigits(2);
        	jtn.setMinimumFractionDigits(2);
        	jtn.setGroupingUsed(false);
    		try
    		{	
    			strAction=Helper.correctNull((String)hshValues.get("hidAction"));
    			if(strAction.equalsIgnoreCase("insert"))
    			{
    				strQuery=SQLParser.getSqlQuery("chk_mclrmaster^"+Helper.correctNull((String)hshValues.get("txt_effectivefrom"))+"^"+Helper.correctNull((String)hshValues.get("sel_referencetype")));
					rs=DBUtils.executeQuery(strQuery);
					
					if(rs.next())
						{
							strExp = strExp + " Spread value is already defined for the given Date and MCLR Type ";
							throw new Exception(strExp);
						}
    				
    				hshQueryValues = new HashMap();
    	    		hshQuery = new HashMap();;
    	    		arrValues=new ArrayList();
    	    		arrValues.add(Helper.correctNull((String)hshValues.get("sel_referencetype")));
    	    		arrValues.add(Helper.correctNull((String)hshValues.get("txt_spreadvalue")));
    	    		arrValues.add(Helper.correctNull((String)hshValues.get("txt_tablecodeforoverdraft")));
    	    		arrValues.add(Helper.correctNull((String)hshValues.get("txt_effectivefrom")));
    	    		arrValues.add(Helper.correctNull((String)hshValues.get("sel_mclr_active")));
    	    		arrValues.add(Helper.correctNull((String)hshValues.get("txt_overdraft")));
    	    		hshQuery.put("strQueryId", "ins_mclrmaster");
    	    		hshQuery.put("arrValues", arrValues);
    	    		hshQueryValues.put("1", hshQuery);
    	    		hshQueryValues.put("size", "1");
    				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
    			}
    			else if(strAction.equals("update"))
    			{
    				String strRefRateType=Helper.correctNull((String)hshValues.get("sel_referencetype"));
    				String strRefRateSpread=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_spreadvalue"))));
    				String strRefRateTablecodeTL=Helper.correctNull((String)hshValues.get("txt_tablecodeforoverdraft"));
    				String strRefRateTablecodeOD=Helper.correctNull((String)hshValues.get("txt_overdraft"));
    				
    				String strOldRefRateSpread=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("hid_spreadvalue"))));
    				String strOldRefRateTablecodeTL=Helper.correctNull((String)hshValues.get("hid_tablecodeforoverdraft"));
    				String strOldRefRateTablecodeOD=Helper.correctNull((String)hshValues.get("hid_overdraft"));
    			
    				String strMCLRType = strRefRateType+"@"+strRefRateSpread+"@"+strRefRateTablecodeTL+"@"+strRefRateTablecodeOD;
    				String strOLDMCLRType = strRefRateType+"@"+strOldRefRateSpread+"@"+strOldRefRateTablecodeTL+"@"+strOldRefRateTablecodeOD;
    				
    				String strDiffVal = String.valueOf(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_spreadvalue"))) - Double.parseDouble(Helper.correctDouble((String)hshValues.get("hid_spreadvalue"))));
     
    				if(!strRefRateSpread.equalsIgnoreCase(strOldRefRateSpread) || !strRefRateTablecodeTL.equalsIgnoreCase(strOldRefRateTablecodeTL)
    						||!strRefRateTablecodeOD.equalsIgnoreCase(strOldRefRateTablecodeOD))
    				{
    					
    					hshQueryValues = new HashMap();
        	    		hshQuery = new HashMap();
        	    		arrValues=new ArrayList();
        	    		arrValues.add(Helper.correctNull((String)hshValues.get("sel_referencetype")));
        	    		arrValues.add(Helper.correctNull((String)hshValues.get("txt_spreadvalue")));
        	    		arrValues.add(Helper.correctNull((String)hshValues.get("txt_tablecodeforoverdraft")));
        	    		arrValues.add(Helper.correctNull((String)hshValues.get("txt_effectivefrom")));
        	    		arrValues.add("Y");
        	    		arrValues.add(Helper.correctNull((String)hshValues.get("txt_overdraft")));
        	    		hshQuery.put("strQueryId", "ins_mclrmaster");
        	    		hshQuery.put("arrValues", arrValues);
        	    		hshQueryValues.put("1", hshQuery);
        	    		
        	    		hshQuery = new HashMap();
        	    		arrValues=new ArrayList();
        	    		arrValues.add("N");
        	    		arrValues.add(Helper.correctNull((String)hshValues.get("hidsno")));
        	    		hshQuery.put("strQueryId", "upd_mclrmaster1");
        	    		hshQuery.put("arrValues", arrValues);
        	    		hshQueryValues.put("2", hshQuery);
        	    		hshQueryValues.put("size", "2");

        	    		
        				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
        				if(strRefRateTablecodeOD!="NND07" && strRefRateTablecodeOD!="NND14" && strRefRateTablecodeOD!="NMM01"
        						&& strRefRateTablecodeOD!="NMM02" && strRefRateTablecodeOD!="NMM03")
        				{
	    				conn = getConnection();
	    				stmt=conn.prepareCall("call PROC_MCLRRATE_UPDATE(?,?,?,?,?,?,?,?,?)");
	    				stmt.setString(1, Helper.correctNull(strRefRateType));
	    				stmt.setString(2, Helper.correctNull(strRefRateSpread));
	    				stmt.setString(3, Helper.correctNull(strRefRateTablecodeTL));
	    				stmt.setString(4, Helper.correctNull(strRefRateTablecodeOD));
	    				stmt.setString(5, Helper.correctNull(strOldRefRateSpread));
	    				stmt.setString(6, Helper.correctNull(strOldRefRateTablecodeTL));
	    				stmt.setString(7, Helper.correctNull(strMCLRType));
	    				stmt.setString(8, Helper.correctNull(strOLDMCLRType));
	    				stmt.setString(9, Helper.correctNull(strDiffVal));
	    				
	    				stmt.execute();
	    				if(stmt != null)
	    					stmt.close();
	    				if(conn != null)
	    					conn.close();
        				}
    				}
    				else
    				{
    					hshQueryValues = new HashMap();
    					hshQuery = new HashMap();
        	    		arrValues=new ArrayList();
        	    		arrValues.add(Helper.correctNull((String)hshValues.get("sel_referencetype")));
        	    		arrValues.add(Helper.correctNull((String)hshValues.get("txt_spreadvalue")));
        	    		arrValues.add(Helper.correctNull((String)hshValues.get("txt_tablecodeforoverdraft")));
        	    		arrValues.add(Helper.correctNull((String)hshValues.get("txt_effectivefrom")));
        	    		arrValues.add(Helper.correctNull((String)hshValues.get("sel_mclr_active")));
        	    		arrValues.add(Helper.correctNull((String)hshValues.get("txt_overdraft")));
        	    		arrValues.add(Helper.correctNull((String)hshValues.get("hidsno")));
        	    		hshQuery.put("strQueryId", "upd_mclrmaster");
        	    		hshQuery.put("arrValues", arrValues);
        	    		hshQueryValues.put("1", hshQuery);
        	    		hshQueryValues.put("size", "1");
        	    		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
    				}
    				
    				
    			}
    		}
    		catch(Exception ce)
    		{
    			throw new EJBException(ce.toString());
    		}
    		finally{
    			hshQueryValues=null;
    			arrValues=null;
    			hshQuery=null;
    		}
    	}
     
        public HashMap getMCLRMaster(HashMap hshValues)  
        {
        	java.text.NumberFormat jtn	= java.text.NumberFormat.getInstance();
        	jtn.setMaximumFractionDigits(2);
        	jtn.setMinimumFractionDigits(2);
        	jtn.setGroupingUsed(false);
        	
        	
        	ResultSet rs = null;
    		ArrayList arrRow = new ArrayList();
    		ArrayList arrCol = new ArrayList();
    		String strQuery = "";
    		
    		  
           try
                {
        		   	strQuery=SQLParser.getSqlQuery("sel_mclrmaster_both^<");
        		   	rs = DBUtils.executeQuery(strQuery);
        			while (rs.next()) {
        				arrCol = new ArrayList();
        				arrCol.add(Helper.correctNull(rs.getString("mclr_sno")));
        				arrCol.add(Helper.correctNull(rs.getString("mclr_type")));
        				arrCol.add(jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("mclr_baseratespread")))));
        				arrCol.add(Helper.correctNull(rs.getString("mclr_tablecode")));
        				arrCol.add(Helper.correctNull(rs.getString("effdate")));
        				arrCol.add(Helper.correctNull(rs.getString("description")));
        				arrCol.add(Helper.correctNull(rs.getString("MCLR_ACTIVE")));
        				arrCol.add(Helper.correctNull(rs.getString("MCLR_TABLECODEOVERDRAFTS")));
        				arrRow.add(arrCol);
        				}
        			hshValues.put("arrRow", arrRow);
        	 
        	  
                }
                catch(Exception exception)
                {
                    throw new EJBException("Error in getMCLRMaster " + exception.toString());
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
            return hshValues;
        }
        public void updateMCLRSpreadMaster(HashMap hshValues) 
    	{	
    		HashMap hshQueryValues = new HashMap();
    		HashMap hshQuery = new HashMap();;
    		ArrayList arrValues=new ArrayList();
    		String strAction="",strQuery="";
    		ResultSet rs=null;
    		String strspreadType="",strspreadoption="",strspreadcaption="",strspreadval="",strVal="",strVal1="";
    		String strLevel="",strActiveFlag="";
    		try
    		{	
    			strAction=Helper.correctNull((String)hshValues.get("hidAction"));
    			
    			strspreadType=Helper.correctNull((String)hshValues.get("sel_spreadtype"));
    			strspreadoption=Helper.correctNull((String)hshValues.get("sel_spreadoption"));
    			strspreadcaption=Helper.correctNull((String)hshValues.get("sel_spreadcaption"));
    			strspreadval=Helper.correctNull((String)hshValues.get("txt_spreadvalue"));
    			strAction=Helper.correctNull((String)hshValues.get("hidAction"));
    			strLevel=Helper.correctNull((String)hshValues.get("hidLevel"));
    			strActiveFlag=Helper.correctNull((String)hshValues.get("sel_active"));
    			if(strLevel.equalsIgnoreCase("ST"))
    			{
    				strVal=strspreadType;
    			}
    			else if(strLevel.equalsIgnoreCase("SC"))
    			{
    				strVal=strspreadcaption;
    			}
    			else if(strLevel.equalsIgnoreCase("SO"))
    			{
    				strVal=strspreadoption;
    			}
    			
    			String[] strArr=strVal.split("-");
    			if(strArr.length>1)
    			{
    				strVal=strArr[0];
    				strVal1=strArr[1];
    			
	    			if(strAction.equalsIgnoreCase("insert"))
	    			{
	    				int intsno=0;
	    				strQuery=SQLParser.getSqlQuery("selmaxid_mclrspreadmaster");
	    				rs=DBUtils.executeQuery(strQuery);
	    				if(rs.next())
	    				{
	    					intsno=rs.getInt("sno");
	    				}
	    				hshQueryValues = new HashMap();
	    	    		hshQuery = new HashMap();;
	    	    		arrValues=new ArrayList();
	    	    		arrValues.add(String.valueOf(intsno));
	    	    		if(strLevel.equalsIgnoreCase("SO"))
	    	    			arrValues.add(Helper.correctNull((String)hshValues.get("txt_spreadvalue")));
	    	    		else
	    	    			arrValues.add(Helper.correctNull((String)hshValues.get("txtvalue")));
	    	    		arrValues.add(String.valueOf(strVal));
	    	    		arrValues.add("Y");
	    	    		hshQuery.put("strQueryId", "ins_mclr_spreadmaster");
	    	    		hshQuery.put("arrValues", arrValues);
	    	    		hshQueryValues.put("1", hshQuery);
	    	    		hshQueryValues.put("size", "1");
	    				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
	    			}
	    			else if(strAction.equals("update"))
	    			{
	    				hshQueryValues = new HashMap();
	    	    		hshQuery = new HashMap();
	    	    		arrValues=new ArrayList();
	    	    		arrValues.add(Helper.correctNull((String)hshValues.get("txtvalue")));
	    	    		arrValues.add(String.valueOf(strVal1));
	    	    		arrValues.add(strActiveFlag);
	    	    		arrValues.add(String.valueOf(strVal));
	    	    		hshQuery.put("strQueryId", "upd_mclr_spreadmaster");
	    	    		hshQuery.put("arrValues", arrValues);
	    	    		hshQueryValues.put("1", hshQuery);
	    	    		hshQueryValues.put("size", "1");
	    	    		
	    	    		if(strLevel.equalsIgnoreCase("SO"))
	    	    		{
	    	    			hshQuery = new HashMap();
		    	    		arrValues=new ArrayList();
	    	    			arrValues.add(Helper.correctNull((String)hshValues.get("txt_spreadvalue")));
		    	    		arrValues.add(String.valueOf(strVal));
		    	    		hshQuery.put("strQueryId", "updspreadval_mclr");
		    	    		hshQuery.put("arrValues", arrValues);
		    	    		hshQueryValues.put("2", hshQuery);
		    	    		hshQueryValues.put("size", "2");
	    	    		}
	    				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
	    			}
    			}

    				

    		}
    		catch(Exception ce)
    		{
    			throw new EJBException(ce.toString());
    		}
    		finally{
    			hshQueryValues=null;
    			arrValues=null;
    			hshQuery=null;
    		}
    	}
     
        public HashMap getMCLRSpreadMaster(HashMap hshValues)  
        {
        	
        	java.text.NumberFormat jtn	= java.text.NumberFormat.getInstance();
        	jtn.setMaximumFractionDigits(2);
        	jtn.setMinimumFractionDigits(2);
        	jtn.setGroupingUsed(false);
        	
        	HashMap hshRecord=new HashMap();
        	ResultSet rs = null,rs1=null;
    		ArrayList arrRow = new ArrayList();
    		ArrayList arrCol = new ArrayList();
    		String strQuery = "",strVal="",strVal1="",strAction="",strLevel="";
    		String strspreadType="",strspreadoption="",strspreadcaption="",strspreadval="";
    		try
	        {
		  
    			strspreadType=Helper.correctNull((String)hshValues.get("sel_spreadtype"));
    			strspreadoption=Helper.correctNull((String)hshValues.get("sel_spreadoption"));
    			strspreadcaption=Helper.correctNull((String)hshValues.get("sel_spreadcaption"));
    			strspreadval=Helper.correctNull((String)hshValues.get("txt_spreadvalue"));
    			strAction=Helper.correctNull((String)hshValues.get("hidAction"));
    			
    			if(strspreadType.equalsIgnoreCase(""))
    			{
    				strVal="0-0";
    				strLevel="ST";
    			}
    			
    			if(!(strspreadType.equalsIgnoreCase("")||strspreadType.equalsIgnoreCase("0-0")))
    			{
    				strVal=strspreadType;
    				strLevel="ST";
    			}
    			if(!(strspreadcaption.equalsIgnoreCase("")||strspreadcaption.equalsIgnoreCase("-")))
    			{
    				strVal=strspreadcaption;
    				strLevel="SC";
    			}
    			if(!(strspreadoption.equalsIgnoreCase("")||strspreadoption.equalsIgnoreCase("-")))
    			{
    				strVal=strspreadoption;
    				strLevel="SO";
    			}
    			
    			
	    			String[] strArr=strVal.split("-");
	    			if(strArr.length>1)
	    			{
	    				strVal=strArr[0];
	    				strVal1=strArr[1];
	    			}
	    			if(strAction.equalsIgnoreCase("getvalue"))
	    			{
		    			strQuery = SQLParser.getSqlQuery("sel_mclrspreadmasterval^" +strVal+"^ ");
						rs1 = DBUtils.executeQuery(strQuery);
						if (rs1.next()) 
						{
							strspreadval=Helper.correctDouble(rs1.getString("mclr_desc"));
							strLevel="SO";
						}
	    			}
	    			
    				strQuery = SQLParser.getSqlQuery("sel_mclrspreadmaster^" +strVal);
					rs1 = DBUtils.executeQuery(strQuery);
					if (rs1.next()) 
					{
						hshRecord.put("strDescription",Helper.correctNull(rs1.getString("mclr_desc")));
						hshRecord.put("strActiveFlag",Helper.correctNull(rs1.getString("mclr_activeflag")));
					}
					
					if(!strspreadval.equalsIgnoreCase(""))
					strspreadval=jtn.format(Double.parseDouble(Helper.correctDouble(strspreadval)));
    			hshRecord.put("strspreadtype",strspreadType);
    			hshRecord.put("strspreadoption",strspreadoption);
    			hshRecord.put("strspreadcaption",strspreadcaption);
    			hshRecord.put("strspreadvalue",strspreadval);
    			hshRecord.put("strLevel",strLevel);
	        }
	        catch(Exception exception)
	        {
	            throw new EJBException("Error in getMCLRSpreadMaster " + exception.toString());
	        }
	        finally
	        {
	        	try{
	        		if(rs!=null)
	        			rs.close();
	        		if(rs1!=null)
	        			rs1.close();
	        	}
	        	catch (Exception e)
				{
					throw new EJBException("Error in closing Connection " + e.getMessage());
				}
	        }
            return hshRecord;
        }
      
}
	
