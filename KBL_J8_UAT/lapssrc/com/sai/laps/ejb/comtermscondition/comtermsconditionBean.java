package com.sai.laps.ejb.comtermscondition;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "comtermsconditionBean", mappedName = "comtermsconditionHome")
@Remote (comtermsconditionRemote.class)
public class comtermsconditionBean extends BeanAdapter
{	



/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	static Logger log=Logger.getLogger(comtermsconditionBean.class);


private int getSno() 
	{		
		String strQuery="";
		ResultSet rs = null;
		int sno = 0;		
		try
		{							
				strQuery = SQLParser.getSqlQuery("getmaxsno_facilityterms");
				rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						sno = rs.getInt(1);
					}
							
			//rs.close();
			
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
		return sno;
	}




public HashMap UpdateComTermsConData(HashMap hshValues) 
	{
		
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();	
		ArrayList arrValues=new ArrayList();
		String strSno="";
		String strQuery="";		
		String strFacilitySubFac="";
		String strFacilityHeadFac="";
		String strComTermsConHeadIdFrom="";
		String strprepost="";
		String strComTermsConTypeIdFrom="",strMode="",strModule="";
		StringTokenizer stz= null;
		String strLoanType="";
		String  strAction="";
		int ComTermsConSno=0;		
		ResultSet rs=null;
		String strFacilityCode="";
		String hidVal= correctNull((String)hshValues.get("hidVal"));
		strSno=correctNull((String)hshValues.get("sno"));
		strMode=correctNull((String)hshValues.get("mode"));
		strLoanType=correctNull((String)hshValues.get("prdtype"));
		strprepost=correctNull((String)hshValues.get("prepost"));
		strModule=correctNull((String)hshValues.get("module"));
		strFacilityCode = correctNull((String) hshValues.get("sel_Facility"));
		String strHidSno=correctNull((String) hshValues.get("hidSno"));
		String strhidChild=correctNull((String) hshValues.get("hidChild"));
		String strhidParent=correctNull((String)hshValues.get("hidParent"));
		strAction = correctNull((String) hshValues.get("sel_Action"));
		try
		{
			
			
			if(!strFacilityCode.equalsIgnoreCase("")){
				
				strQuery=SQLParser.getSqlQuery("selectFacilityHeadFacandSubFac_facilitycorp^"+strFacilityCode);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strFacilityHeadFac=Helper.correctNull((String)rs.getString("com_headfac"));
					strFacilitySubFac=Helper.correctNull((String)rs.getString("com_subfac"));
				}
			}
		  if(hidVal.equals("edit"))
			{		
			  if((strMode.equalsIgnoreCase("O"))||(strMode.equalsIgnoreCase("B"))||(strMode.equalsIgnoreCase("P"))||(strMode.equalsIgnoreCase("S")))
				{
				    hshQueryValues = new HashMap();
					hshQuery = new HashMap();					
					hshQueryValues.put("size","1");					
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","ComTermsConup_other");
					arrValues.add(correctNull((String )hshValues.get("termscondition")));
					arrValues.add(strAction);
					arrValues.add(strSno);
					arrValues.add(strMode);
					arrValues.add(strModule);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);				
							
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
 
				}
				else
				{			
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();					
					hshQueryValues.put("size","1");					
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","ComTermsConup");
					arrValues.add(correctNull((String )hshValues.get("termscondition")));
					arrValues.add(strAction);
					arrValues.add(strSno);
					arrValues.add(strMode);
					arrValues.add(strprepost);
					arrValues.add(strModule);
					arrValues.add(strhidParent);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);				
							
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				 
				}
 
			}

			else if(hidVal.equals("insert"))
			{						
					
				if(!(strHidSno.equalsIgnoreCase("")) && strhidChild.equalsIgnoreCase("Yes"))
				{
					strQuery=SQLParser.getSqlQuery("sel_termsbysno^"+strHidSno);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strSno= Integer.toString(getSno());	
						hshQueryValues = new HashMap();
						hshQuery = new HashMap();					
						hshQueryValues.put("size","1");					
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","ComTermsConins");
						
						arrValues.add(correctNull((String)rs.getString("fac_id")));
						arrValues.add(correctNull((String)rs.getString("fac_type")));
						arrValues.add(strSno);			
						arrValues.add(correctNull((String )hshValues.get("termscondition")));
						arrValues.add(correctNull((String)rs.getString("fac_mode")));
						arrValues.add(correctNull((String)rs.getString("fac_prepost")));
						arrValues.add(correctNull((String)rs.getString("fac_moduletype")));
						arrValues.add(correctNull((String)rs.getString("fac_facilitycode")));
						arrValues.add(correctNull((String)rs.getString("fac_sno")));
						arrValues.add(correctNull((String)rs.getString("fac_action")));
						

						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);
						
						//EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						
						
					}
					
				}
				else
				{
					
					
				strSno= Integer.toString(getSno());	
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");					
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","ComTermsConins");
				
				if( (strMode.equalsIgnoreCase("G")) || (strMode.equalsIgnoreCase("O"))||(strMode.equalsIgnoreCase("B"))||(strMode.equalsIgnoreCase("P")))
				{
				arrValues.add("");//Facility Head Id
				arrValues.add("");//Facility Type
				arrValues.add(strSno);				
				arrValues.add(correctNull((String )hshValues.get("termscondition")));
				arrValues.add(strMode);
				arrValues.add(strprepost);
				arrValues.add(strModule);
				arrValues.add("");//Facility Code
				arrValues.add("0");
				arrValues.add(strAction);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				}
				else
				{									
					arrValues.add(strFacilityHeadFac);
					arrValues.add(strFacilitySubFac);
					arrValues.add(strSno);				
					arrValues.add(correctNull((String )hshValues.get("termscondition")));
					arrValues.add(strMode);
					arrValues.add(strprepost);
					arrValues.add(strModule);
					arrValues.add(strFacilityCode);
					arrValues.add("0");
					arrValues.add(strAction);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);					
				}
				
				
				}
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			 }
			else if(hidVal.equals("delete"))
			{
				 if(strMode.equalsIgnoreCase("S")||(strMode.equalsIgnoreCase("O"))||(strMode.equalsIgnoreCase("B"))||(strMode.equalsIgnoreCase("P")))
				{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");					
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","ComTermsCondel_other");
				arrValues.add(strSno);
				arrValues.add(strMode);
				arrValues.add(strModule);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);				
							
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				else 
				{
					    hshQueryValues = new HashMap();
						hshQuery = new HashMap();					
						hshQueryValues.put("size","1");					
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","ComTermsCondel"); 
						arrValues.add(strSno);
						arrValues.add(strMode);
						arrValues.add(strprepost);
						arrValues.add(strModule);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);				
									
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				 }
				 
			}
		  
		  
		  //Audit Trial:
		  String doc_mode=correctNull((String)hshValues.get("doc_mode"));
		  StringBuilder sbAt = new StringBuilder();
		  if(doc_mode.equals("G"))
		  {
		  
		  sbAt.append(" ~General Terms & Conditions");
		  }
		  else if(doc_mode.equals("P")&& strModule.equalsIgnoreCase("R"))
		  {		  
		  sbAt.append(" ~Product Based Terms & Conditions ");
		  }
		  else if(doc_mode.equals("S"))
		  {		  
		  sbAt.append(" ~Facility Based Terms & Conditions ");
		  }
		  else if(doc_mode.equals("P"))
		  {		  
		  sbAt.append(" ~Specific Conditions ");
		  }
		  else if(doc_mode.equals("O"))
		  {		  
		  sbAt.append(" ~Other Terms & Conditions ");
		  }
		  else
		  {
		  sbAt.append(" ~Instructions to the Branch ");
		  sbAt.append(" ~Facility Head=").append(correctNull((String)hshValues.get("hid_facility_head")));
		  sbAt.append(" ~Facility Type=").append(correctNull((String)hshValues.get("hid_facility")));
		  }
		  
		  sbAt.append(" ~Terms & Condition=").append(correctNull((String)hshValues.get("termscondition")));
		  if(hidVal.equals("edit"))
		  hshValues.put("hidAction","update");
		  else
			  hshValues.put("hidAction",hidVal);
		  
		    String strCode="";
		    if(strLoanType.equalsIgnoreCase("T"))
			   	strCode="118";
			else
		    	strCode="108";
		    
		  AuditTrial.auditLog(hshValues,strCode,"",sbAt.toString());
		  HashMap hshRecord =getComTermsConData(hshValues);
		return hshRecord;
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
		}finally
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




public HashMap getComTermsConData(HashMap hshValues) 
	{			
		StringTokenizer stz= null;
		String strQuery="";
		ResultSet rs = null;		
		HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();
		ArrayList vecVal=new ArrayList();		
		String strSno=correctNull((String)hshValues.get("termsno"));
		String toget = correctNull((String)hshValues.get("toget"));	
		String strComTermsConHeadId="";
		String strComTermsConTypeId="";
		String strprepost="";
		String strComTermsConHeadIdFrom="";
		String strComTermsConTypeIdFrom="",strMode="",strModule="",strFacilityCode="",strQuery1="";;	
		ResultSet rs1=null;
		String strTermsAction="";
		try
		{
				strFacilityCode = correctNull((String) hshValues.get("sel_Facility"));				
				strMode=correctNull((String)hshValues.get("mode"));
				strprepost=correctNull((String)hshValues.get("prepost"));
				strModule=correctNull((String)hshValues.get("module"));
				strTermsAction=correctNull((String)hshValues.get("sel_Action"));
			if(toget.equals("place"))
			{
					strQuery=SQLParser.getSqlQuery("modify_TermsConditions_place^"+strSno+"^"+strMode+"^"+strprepost+"^"+strModule);
					rs = DBUtils.executeQuery(strQuery);
					while(rs.next())
					{	
						vecVal = new ArrayList();
						vecVal.add(correctNull(rs.getString("fac_sno")));
						vecVal.add(Helper.replaceForJavaScriptString(correctNull(rs.getString("fac_terms"))));
						vecVal.add(correctNull(rs.getString("fac_facilitycode")));
						vecVal.add(Helper.correctInt(rs.getString("fac_parent_id")));
						vecVal.add(Helper.correctNull(rs.getString("fac_action")));
						vecData.add(vecVal);		
						
						strQuery1=SQLParser.getSqlQuery("sel_termschildele^"+correctNull(rs.getString("fac_sno")));
						rs1 = DBUtils.executeQuery(strQuery1);
						while(rs1.next())
						{
							vecVal = new ArrayList();
							vecVal.add(correctNull(rs1.getString("fac_sno")));
							vecVal.add(Helper.replaceForJavaScriptString(correctNull(rs1.getString("fac_terms"))));
							vecVal.add(correctNull(rs1.getString("fac_facilitycode")));
							vecVal.add(Helper.correctInt(rs1.getString("fac_parent_id")));
							vecVal.add(Helper.correctNull(rs1.getString("fac_action")));
							vecData.add(vecVal);		
						}
						if(rs1!=null)
						{
							rs1.close();
						}
					}	
					
			}
			else{
				
				
				if(strMode.equalsIgnoreCase("G"))
				{
					strQuery=SQLParser.getSqlQuery("select_TermsConditions^"+strMode+"^"+strprepost+"^"+strModule);
					rs = DBUtils.executeQuery(strQuery);
					while(rs.next())
					{	
						vecVal = new ArrayList();
						vecVal.add(correctNull(rs.getString("fac_sno")));
						vecVal.add(Helper.replaceForJavaScriptString(correctNull(rs.getString("fac_terms"))));
						vecVal.add(correctNull(rs.getString("fac_facilitycode")));
						vecVal.add(Helper.correctInt(rs.getString("fac_parent_id")));
						vecVal.add(Helper.correctNull(rs.getString("fac_action")));
						vecData.add(vecVal);	
						
						strQuery1=SQLParser.getSqlQuery("sel_termschildele^"+correctNull(rs.getString("fac_sno")));
						rs1 = DBUtils.executeQuery(strQuery1);
						while(rs1.next())
						{
							vecVal = new ArrayList();
							vecVal.add(correctNull(rs1.getString("fac_sno")));
							vecVal.add(Helper.replaceForJavaScriptString(correctNull(rs1.getString("fac_terms"))));
							vecVal.add(correctNull(rs1.getString("fac_facilitycode")));
							vecVal.add(Helper.correctInt(rs1.getString("fac_parent_id")));
							vecVal.add(Helper.correctNull(rs1.getString("fac_action")));
							vecData.add(vecVal);		
						}
						if(rs1!=null)
						{
							rs1.close();
						}
					}	

				}
				else if((strMode.equalsIgnoreCase("O"))||(strMode.equalsIgnoreCase("B"))||(strMode.equalsIgnoreCase("P")))//Other Terms & Conditions and Instructions to the Branch t&c  added by ganesan
				{
				
					strQuery=SQLParser.getSqlQuery("select_OtherTermsConditions^"+strMode+"^"+strModule);
					rs = DBUtils.executeQuery(strQuery);
					while(rs.next())
					{	
						vecVal = new ArrayList();
						vecVal.add(correctNull(rs.getString("fac_sno")));
						vecVal.add(Helper.replaceForJavaScriptString(correctNull(rs.getString("fac_terms"))));
						vecVal.add(correctNull(rs.getString("fac_facilitycode")));
						vecVal.add(correctNull(rs.getString("fac_parent_id")));
						vecVal.add(Helper.correctNull(rs.getString("fac_action"))); 
						vecData.add(vecVal);	
						
						strQuery1=SQLParser.getSqlQuery("sel_termschildele^"+correctNull(rs.getString("fac_sno")));
						rs1 = DBUtils.executeQuery(strQuery1);
						while(rs1.next())
						{
							vecVal = new ArrayList();
							vecVal.add(correctNull(rs1.getString("fac_sno")));
							vecVal.add(Helper.replaceForJavaScriptString(correctNull(rs1.getString("fac_terms"))));
							vecVal.add(correctNull(rs1.getString("fac_facilitycode")));
							vecVal.add(Helper.correctInt(rs1.getString("fac_parent_id")));
							vecVal.add(Helper.correctNull(rs1.getString("fac_action")));
							vecData.add(vecVal);		
						}
						if(rs1!=null)
						{
							rs1.close();
						}
						
						
					}	
					
					
				}
			 
			else
			{
				if(!strFacilityCode.equalsIgnoreCase(""))
				{
					strQuery=SQLParser.getSqlQuery("select_SpecialTermsConditions^"+strMode+"^"+strModule+"^"+strFacilityCode);
					rs = DBUtils.executeQuery(strQuery);
					while(rs.next())
					{	
						vecVal = new ArrayList();
						vecVal.add(correctNull(rs.getString("fac_sno")));
						vecVal.add(Helper.replaceForJavaScriptString(correctNull(rs.getString("fac_terms"))));
						vecVal.add(correctNull(rs.getString("fac_facilitycode")));
						vecVal.add(Helper.correctInt(rs.getString("fac_parent_id")));
						vecVal.add(Helper.correctNull(rs.getString("fac_action")));
						vecData.add(vecVal);	
						
						
						strQuery1=SQLParser.getSqlQuery("sel_termschildele^"+correctNull(rs.getString("fac_sno")));
						rs1 = DBUtils.executeQuery(strQuery1);
						while(rs1.next())
						{
							vecVal = new ArrayList();
							vecVal.add(correctNull(rs1.getString("fac_sno")));
							vecVal.add(Helper.replaceForJavaScriptString(correctNull(rs1.getString("fac_terms"))));
							vecVal.add(correctNull(rs1.getString("fac_facilitycode")));
							vecVal.add(Helper.correctInt(rs1.getString("fac_parent_id")));
							vecVal.add(Helper.correctNull(rs1.getString("fac_action")));
							
							vecData.add(vecVal);		
						}
						if(rs1!=null)
						{
							rs1.close();
						}
					}
					
					}
				}
								
			}
			
						
			hshRecord.put("vecData",vecData);	
			hshRecord.put("mode",strMode);	
			hshRecord.put("prepost",strprepost);
			hshRecord.put("module",strModule);
			hshRecord.put("FacilityCode",strFacilityCode);
			hshRecord.put("strTermsAction",strTermsAction);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getComTermsConData "+ce.toString());
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

public HashMap getModifyData(HashMap hsh) 
{
	String strQuery="";
	ResultSet rs=null;
	HashMap hshformula=new HashMap();
	HashMap hshValues = new HashMap();
	HashMap hshRecord = new HashMap();
	ArrayList vecRec= new ArrayList();
	ArrayList vecVal = new ArrayList();
	ArrayList vecDoc = new ArrayList();
	
	String appno="";
	try
	{
		appno=correctNull((String)hsh.get("appno"));
		strQuery = SQLParser.getSqlQuery("notemodsel^"+appno);
		if(rs!=null)
		rs.close();	
		rs=DBUtils.executeQuery(strQuery);
		while (rs.next())
		{
			if(correctNull(rs.getString(2)).equalsIgnoreCase("Concessions"))
			{
				hshRecord.put("Concessions",correctNull((String)rs.getString(3)));
			}
			else if (correctNull(rs.getString(2)).equalsIgnoreCase("Reference of existing sanction"))
			{
				hshRecord.put("Reference of existing sanction",correctNull((String)rs.getString(3).trim()));
			}
			else if (correctNull(rs.getString(2)).equalsIgnoreCase("Authority"))
			{
				hshRecord.put("Authority",correctNull((String)rs.getString(3).trim()));
			}
		}
		strQuery = SQLParser.getSqlQuery("noteterms^"+appno);
		if(rs!=null)
		rs.close();
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
			vecVal.add(vecRec);
		}
		hshRecord.put("vecVal",vecVal);
		strQuery = SQLParser.getSqlQuery("notedocuments^"+appno);
		if(rs!=null)
		rs.close();
		rs=DBUtils.executeQuery(strQuery);
		while(rs.next())
		{
			vecRec = new ArrayList();
			vecRec.add(correctNull(rs.getString(1)));
			vecRec.add(correctNull(rs.getString(2)));
			vecRec.add(correctNull(rs.getString(3)));
			vecRec.add(correctNull(rs.getString(4)));
			vecRec.add(correctNull(rs.getString(5)));
			vecDoc.add(vecRec);
		}
		hshRecord.put("vecDoc",vecDoc);
		hshformula.put("appno",appno);
		hshValues = (HashMap)EJBInvoker.executeStateLess("comproposal",hshformula,"getDataConfirm");
		ArrayList vecConf=(ArrayList)hshValues.get("value1");
		hshRecord.put("vecConf",vecConf);
		strQuery = SQLParser.getSqlQuery("noterevsel^"+appno);
		if(rs!=null)
		rs.close();
		rs=DBUtils.executeQuery(strQuery);
			
		if(rs.next())
		{
			hshRecord.put("com_proplastrevdate",correctNull(rs.getString("com_proplastrevdate")).trim());
			hshRecord.put("com_propdevrevdate",correctNull(rs.getString("com_propdevrevdate")).trim());
		}
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
	return hshRecord;
}




}//	end of class //


							
