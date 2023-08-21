package com.sai.laps.ejb.setmodtermscond;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.SQLParser;


@Stateless(name = "SetModTermsCondBean", mappedName = "SetModTermsCondHome")
@Remote (SetModTermsCondRemote.class)
public class SetModTermsCondBean extends BeanAdapter
{	
	/**
	 * 
	 */
	private static final long serialVersionUID = 557048597094126813L;

	/**
	 * 
	 */
	

	public HashMap getTermData(HashMap hshRequestValues) 
	{	
		ResultSet rs = null;
		ArrayList vecRow = new ArrayList();
		ArrayList vecCol=null;
		HashMap hshRecord = new HashMap();
		try
		{	
			hshRecord = new HashMap();
			rs=DBUtils.executeLAPSQuery("setmodtermcondterm");
			while (rs.next())
			{   vecCol = new ArrayList();
				for (int i=0;i<1;i++ )
				{ vecCol.add(rs.getString(i+1));
				}
				vecRow.add(vecCol);
			}
			hshRecord.put("vecVal",vecRow);
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
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}
	
	public HashMap getData(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		ArrayList vecRow = new ArrayList();
		ArrayList vecCol=null;
		HashMap hshRecord = new HashMap();
		String strQuery="";
		String strDesc="";		
		String strAction = correctNull((String)hshRequestValues.get("hidAction"));
		try
		{	
			hshRecord = new HashMap();
			strDesc=correctNull((String)hshRequestValues.get("hiddesc"));
			if(strDesc.equals(""))
			{ 
				strDesc="0";
			}
			if(strAction.equals("edit"))
			{
				String strRuleID = correctNull((String)hshRequestValues.get("selsno"));
				strQuery = SQLParser.getSqlQuery("getmodruletermcond^"+strDesc+"^"+strRuleID);
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("getmodtermcond^"+strDesc);
			}
			rs = DBUtils.executeQuery(strQuery);

			while (rs.next())
			{   vecCol = new ArrayList();
				for (int i=0 ;i<5; i++ )
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


	public void updateData(HashMap hshValues) 
	{	
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String strtermId = null;
		String strRuleNo = null;		
		String strtermDesc=null;
		String strtermContent=null;
		String strtermAction=null;
		try
		{
		  if(strAction.equals("update"))
			{
				strtermId =  correctNull((String )hshValues.get("hiddesc"));
				strRuleNo =  correctNull((String )hshValues.get("selsno"));
				strtermDesc = correctNull((String )hshValues.get("txttrmdesc"));
				strtermContent =  correctNull((String )hshValues.get("txttrmcontent"));
				strtermAction=	correctNull((String)hshValues.get("sel_Action"));		
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","updmodtermcond");
				arrValues.add(strtermDesc.toUpperCase());
				arrValues.add(strtermContent);
				arrValues.add(strtermAction);
				arrValues.add(strtermId);
				arrValues.add(strRuleNo);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
			}

			else if(strAction.equals("insertnew"))
			{
				strtermId =  Integer.toString(getTermCode());
				strRuleNo =  Integer.toString(getTermRuleCode(strtermId));
				strtermDesc = correctNull((String )hshValues.get("txttrmdesc"));
				strtermContent =  correctNull((String )hshValues.get("txttrmcontent"));
				strtermAction= correctNull((String)hshValues.get("sel_Action"));					
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshValues.put("hidId","strtermId");
				
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","insmodtermcond");
				arrValues.add(strtermId);
				arrValues.add(strRuleNo);
				arrValues.add(strtermDesc.toUpperCase());
				arrValues.add(strtermContent);
				arrValues.add(strtermAction);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
			 }

			 else if(strAction.equals("insertadd"))
			{
				strtermId =  correctNull((String )hshValues.get("hiddesc"));
				strRuleNo =  Integer.toString(getTermRuleCode(strtermId));
				strtermDesc = correctNull((String )hshValues.get("txttrmdesc"));
				strtermContent =  correctNull((String )hshValues.get("txttrmcontent"));
				strtermAction=correctNull((String)hshValues.get("sel_Action"));
									
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshValues.put("hidId","strtermId");
				
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","insmodtermcond");
				arrValues.add(strtermId);
				arrValues.add(strRuleNo);
				arrValues.add(strtermDesc.toUpperCase());
				arrValues.add(strtermContent);
				arrValues.add(strtermAction);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
			 }

			else if(strAction.equals("delete"))
			{
				String strRuleID = correctNull((String)hshValues.get("selsno"));
				strtermId =  correctNull((String )hshValues.get("hiddesc"));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				
				hshQuery.put("strQueryId","delmodtermcond");
				arrValues.add(strtermId);
				arrValues.add(strRuleID);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
			}

			//for Entering the values into auditrial
			/*String strActionData = "Term Description="+correctNull((String)hshValues.get("txttrmdesc"))+
			"~TermContent="+correctNull((String)hshValues.get("txttrmcontent"));
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","audittrial");
			arrValues.add("12");
			arrValues.add(correctNull((String)hshValues.get("strUserId")));
			arrValues.add(correctNull((String)hshValues.get("strClientIP")));
			arrValues.add(correctNull((String)hshValues.get("txttrmdesc")));
			arrValues.add(strActionData);
			if(strAction.equals("delete"))
				arrValues.add("delete");
			else
				arrValues.add("insert");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("2",hshQuery);*/
				try
				{
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					StringBuilder sbAuditTrial=new StringBuilder();
					sbAuditTrial.append("Term Description="+correctNull((String )hshValues.get("txttrmdesc"))).append("~TermContent=").append(correctNull((String )hshValues.get("txttrmcontent")));
					AuditTrial.auditLog(hshValues,"12","",sbAuditTrial.toString());
				}
				catch(Exception se)
				{
					throw new Exception("Cannot Delete Terms and Conditions, It is used in Products");
				}
		   
		}
		catch(Exception ce)
		{
			throw new EJBException(ce.toString());
		}
	}
	
	private int getTermCode()
	{
		ResultSet rs = null;
		int termId = 0;
		try
		{	
			rs=DBUtils.executeLAPSQuery("maxmodtermid");
			while(rs.next())
			{
				if(rs.getString(1) != null)
				{
					termId = Integer.parseInt(rs.getString(1)) ;
				}
				
			}
			rs.close();
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getTermCode "+ce.toString());
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
				throw new EJBException("Error closing the connection getTermCode"+cf.getMessage());
						
			}
		}
		return termId;
	}

	private int getTermRuleCode(String strtermId)
	{
		ResultSet rs = null;
		int termRuleId = 0;		
		try
		{	
			rs=DBUtils.executeLAPSQuery("maxmodtermrule^"+strtermId);
			while(rs.next())
			{
				if(rs.getString(1) != null)
				{
					termRuleId = Integer.parseInt(rs.getString(1)) ;
				}
				
			}
			rs.close();
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getTermRuleCode "+ce.toString());
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
				throw new EJBException("Error closing the connection getTermRuleCode"+cf.getMessage());
						
			}
		}
		return termRuleId;
	}
	
//	kamal added
	public void updateshemedocData(HashMap hshValues) 
	{	
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String strtermId = null;
		String strRuleNo = null;		
		String strtermDesc=null;
		String strtermContent=null;
		String str_sector=null;
		String strSch_Type=null;
		try
		{
		  if(strAction.equals("update"))
			{
				strtermId =  correctNull((String )hshValues.get("hiddesc"));
				strRuleNo =  correctNull((String )hshValues.get("selsno"));
				strtermDesc = correctNull((String )hshValues.get("txttrmdesc"));
				strtermContent =  correctNull((String )hshValues.get("txttrmcontent"));
				str_sector		=  correctNull((String )hshValues.get("selsector"));
				strSch_Type		=  correctNull((String )hshValues.get("sel_active"));
							
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","updschemedoc");
				arrValues.add(strtermDesc.toUpperCase());
				arrValues.add(strtermContent.toUpperCase());
				arrValues.add(strSch_Type);
				arrValues.add(strtermId);
				arrValues.add(strRuleNo);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
			}

			else if(strAction.equals("insertnew"))
			{
				strtermId =  Integer.toString(getSchemeDoc());
				strRuleNo =  Integer.toString(getSchemeRuleCode(strtermId));
				strtermDesc = correctNull((String )hshValues.get("txttrmdesc"));
				strtermContent =  correctNull((String )hshValues.get("txttrmcontent"));
				str_sector		=  correctNull((String )hshValues.get("selsector"));
				strSch_Type		=  correctNull((String )hshValues.get("sel_active"));
									
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshValues.put("hidId","strtermId");
				
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","insschemedoc");
				arrValues.add(strtermId);
				arrValues.add(strRuleNo);
				arrValues.add(strtermDesc.toUpperCase());
				arrValues.add(strtermContent.toUpperCase());
				arrValues.add(str_sector);
				arrValues.add(strSch_Type);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
			 }

			 else if(strAction.equals("insertadd"))
			{
				strtermId =  correctNull((String )hshValues.get("hiddesc"));
				strRuleNo =  Integer.toString(getSchemeRuleCode(strtermId));
				strtermDesc = correctNull((String )hshValues.get("txttrmdesc"));
				strtermContent =  correctNull((String )hshValues.get("txttrmcontent"));
				str_sector		=  correctNull((String )hshValues.get("selsector"));
				strSch_Type	  =  correctNull((String )hshValues.get("sel_active"));
									
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshValues.put("hidId","strtermId");
				
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","insschemedoc");
				arrValues.add(strtermId);
				arrValues.add(strRuleNo);
				arrValues.add(strtermDesc.toUpperCase());
				arrValues.add(strtermContent.toUpperCase());
				arrValues.add(str_sector);
				arrValues.add(strSch_Type);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
			 }

			else if(strAction.equals("delete"))
			{
				String strRuleID = correctNull((String)hshValues.get("selsno"));
				strtermId =  correctNull((String )hshValues.get("hiddesc"));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				
				hshQuery.put("strQueryId","delschemedoc");
				arrValues.add(strtermId);
				arrValues.add(strRuleID);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
			}

			//for Entering the values into auditrial
			/*String strActionData = "Term Description="+correctNull((String)hshValues.get("txttrmdesc"))+
			"~TermContent="+correctNull((String)hshValues.get("txttrmcontent"));
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","audittrial");
			arrValues.add("12");
			arrValues.add(correctNull((String)hshValues.get("strUserId")));
			arrValues.add(correctNull((String)hshValues.get("strClientIP")));
			arrValues.add(correctNull((String)hshValues.get("txttrmdesc")));
			arrValues.add(strActionData);
			if(strAction.equals("delete"))
				arrValues.add("delete");
			else
				arrValues.add("insert");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("2",hshQuery);*/
				try
				{
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					/*StringBuilder sbAuditTrial=new StringBuilder();
					sbAuditTrial.append("Term Description="+correctNull((String )hshValues.get("txttrmdesc"))).append("~TermContent=").append(correctNull((String )hshValues.get("txttrmcontent")));
					AuditTrial.auditLog(hshValues,"12","",sbAuditTrial.toString());*/
				}
				catch(Exception se)
				{
					throw new Exception("Cannot Delete Terms and Conditions, It is used in Products");
				}
		   
		}
		catch(Exception ce)
		{
			throw new EJBException(ce.toString());
		}
	}
	
//	kamal added
	public HashMap getSchemeDocData(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		ArrayList vecRow = new ArrayList();
		ArrayList vecCol=null;
		HashMap hshRecord = new HashMap();
		String strQuery="";
		String strDesc="";		
		String strAction = correctNull((String)hshRequestValues.get("hidAction"));
		String sector="";
		String scheme="";
		String desc ="";
		String strSch_Type="";
		try
		{	
			hshRecord = new HashMap();
			strDesc=correctNull((String)hshRequestValues.get("hiddesc"));
			if(!strDesc.equals("") && !strDesc.equals("0"))
			{ 
				if(strAction.equals("edit"))
				{
					String strRuleID = correctNull((String)hshRequestValues.get("selsno"));
					strQuery = SQLParser.getSqlQuery("getschemedocrule^"+strDesc+"^"+strRuleID);
				}
				else 
				{
					strQuery = SQLParser.getSqlQuery("getschemedoc^"+strDesc);
				}
				rs = DBUtils.executeQuery(strQuery);
	
				while (rs.next())
				{   vecCol = new ArrayList();
					for (int i=0 ;i<6; i++ )
					{ vecCol.add(rs.getString(i+1));
					}
					vecRow.add(vecCol);
				}
				hshRecord.put("vecRow",vecRow);
				
				
				if(vecRow != null && vecRow.size()>0)
				{
					ArrayList vcol= (ArrayList)vecRow.get(0);
					if(vcol != null)
					{
						scheme = (String)vcol.get(0);
						desc  = (String)vcol.get(2);
						sector = (String)vcol.get(4);
						strSch_Type = (String)vcol.get(5);
						
					}
				}
				else
				{
					scheme=strDesc;
				}
			}
			hshRecord.put("sector",sector);
			hshRecord.put("scheme",scheme);
			hshRecord.put("desc",desc);
			hshRecord.put("strBankScheme",strDesc);
			hshRecord.put("SCHEME_Active",strSch_Type);
			
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
//	kamal added
	private int getSchemeDoc()
	{
		ResultSet rs = null;
		int termId = 0;
		try
		{	
			rs=DBUtils.executeLAPSQuery("maxmodschemeid");
			while(rs.next())
			{
				if(rs.getString(1) != null)
				{
					termId = Integer.parseInt(rs.getString(1)) ;
				}
				
			}
			rs.close();
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getTermCode "+ce.toString());
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
				throw new EJBException("Error closing the connection getTermCode"+cf.getMessage());
						
			}
		}
		return termId;
	}
//	kamal added
	private int getSchemeRuleCode(String strtermId)
	{
		ResultSet rs = null;
		int termRuleId = 0;		
		try
		{	
			rs=DBUtils.executeLAPSQuery("maxmodschemerule^"+strtermId);
			while(rs.next())
			{
				if(rs.getString(1) != null)
				{
					termRuleId = Integer.parseInt(rs.getString(1)) ;
				}
				
			}
			rs.close();
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getTermRuleCode "+ce.toString());
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
				throw new EJBException("Error closing the connection getTermRuleCode"+cf.getMessage());
						
			}
		}
		return termRuleId;
	}
//	kamal added
	public HashMap getSchemeData(HashMap hshRequestValues)  {

		ResultSet rs = null;
		ArrayList vecRow = new ArrayList();
		ArrayList vecCol = null;
		HashMap hshRecord = new HashMap();
		String str_sector = correctNull((String)hshRequestValues.get("sector"));
		String scheme_exi = correctNull((String)hshRequestValues.get("scheme_exi"));
		try {

			hshRecord = new HashMap();

			rs = DBUtils.executeLAPSQuery("setscheme^"+str_sector);
			while (rs.next()) {
				vecCol = new ArrayList();
				for (int i = 0; i < 2; i++) {
					vecCol.add(rs.getString(i + 1));
				}
				vecRow.add(vecCol);
			}
			hshRecord.put("vecVal",vecRow);
			hshRecord.put("scheme_exi",scheme_exi);
		} catch (Exception ce) {
			throw new EJBException("Error in getData login  " + ce.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();

			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return hshRecord;
	}
	
//	kamal Added 11/07/09
	public HashMap getSectorSchemeDoc(HashMap hshRequestValues)  {

		ResultSet rs = null;
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol = null;
		HashMap hshRecord = new HashMap();
		String str_sector = correctNull((String)hshRequestValues.get("sector"));
		
		
		try {

			hshRecord = new HashMap();

			rs = DBUtils.executeLAPSQuery("selSectorSchemeDoc^"+str_sector);
			while (rs.next()) {
				arrCol = new ArrayList();
				arrCol.add(correctNull((String)rs.getString("Scheme_ID")));
				arrCol.add(correctNull((String)rs.getString("mis_static_data_desc")));
				arrCol.add(correctNull((String)rs.getString("Document_content")));
				arrRow.add(arrCol);
				
			}
			hshRecord.put("arrCust",arrRow);
			
		} catch (Exception ce) {
			throw new EJBException("Error ingetSectorSchemeDoc login  " + ce.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();

			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return hshRecord;
	}

	//kamal End 11/07/09
	/**
	 * @author : Karthikeyan.S
	 * @date : March 08, 2014
	 * @category to get Take Over Norms Master Data
	 * @return HashMap
	 * @
	 */
	public HashMap getTakeOverNorms(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ArrayList arrRow=new ArrayList();
		ResultSet rs=null;
		try
		{
			String strModule=correctNull((String)hshValues.get("sel_Module"));
			String strQuery=SQLParser.getSqlQuery("sel_TakeOverNorms^"+strModule);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				ArrayList arrCol=new ArrayList();
				arrCol.add(correctNull((String)rs.getString("ston_sno")));
				arrCol.add(correctNull((String)rs.getString("ston_takeovernorm")));
				arrCol.add(correctNull((String)rs.getString("ston_active_type")));
				arrRow.add(arrCol);
			}
			hshRecord.put("arrRow",arrRow);
		}
		catch (Exception ce)
		{
			throw new EJBException("Error in getTakeOverNorms " + ce.toString());
		}
		finally
		{
			try
			{
				if (rs != null)
					rs.close();
			}
			catch (Exception cf)
			{
				throw new EJBException("Error closing the connection "+ cf.getMessage());
			}
		}
		return hshRecord;
	}
	/**
	 * @author : Karthikeyan.S
	 * @date : March 08, 2014
	 * @category to update Take Over Norms Master Data
	 * @return
	 * @
	 */
	public void updateTakeOverNorms(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery =  new HashMap();
		ArrayList arrValues=new ArrayList();
		try
		{
			String strAction=correctNull((String)hshValues.get("hidAction"));
			String strModule=correctNull((String)hshValues.get("sel_Module"));
			String strTerms=correctNull((String)hshValues.get("txt_TakeOverNorm"));
			String strSNo=correctNull((String)hshValues.get("hidSNo"));
			String strSelectType=correctNull((String)hshValues.get("sel_active"));

			if(strAction.equalsIgnoreCase("insert"))
			{
				strSNo=getTakeOverNormMaxId();
				hshQuery.put("strQueryId","ins_TakeOverNorms");
				arrValues.add(strSNo);
				arrValues.add(strTerms);
				arrValues.add(strModule);
				arrValues.add(strSelectType);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
			}
			else if(strAction.equalsIgnoreCase("update"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","upd_TakeOverNorms");
				arrValues.add(strTerms);
				arrValues.add(strModule);
				arrValues.add(strSelectType);
				arrValues.add(strSNo);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","del_TakeOverNorms");
				arrValues.add(strSNo);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
			}
			hshQueryValues.put("size","1");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		catch(Exception ce)
		{
			throw new EJBException(ce.toString());
		}
	}
	private String getTakeOverNormMaxId() 
	{
		String strSNo="";
		ResultSet rs=null;
		try
		{
			String strQuery=SQLParser.getSqlQuery("sel_TakeOverNorms_MaxSNo");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strSNo=correctNull((String)rs.getString("ston_maxsno"));
			}
		}
		catch (Exception ce)
		{
			throw new EJBException("Error in getTakeOverNormMaxId " + ce.toString());
		}
		finally
		{
			try
			{
				if (rs != null)
					rs.close();
			}
			catch (Exception cf)
			{
				throw new EJBException("Error closing the connection "+ cf.getMessage());
			}
		}
		return strSNo;
	}
	public void updateRBIGuidelines(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery =  new HashMap();
		ArrayList arrValues=new ArrayList();
		ResultSet rs=null;
		try
		{
			String strAction=correctNull((String)hshValues.get("hidAction"));
			String strModule=correctNull((String)hshValues.get("sel_Module"));
			String strCompliance=correctNull((String)hshValues.get("sel_compliances"));
			String strTerms=correctNull((String)hshValues.get("txt_guideliness"));
			String strSNo=correctNull((String)hshValues.get("hidSNo"));
			String strSelectType=correctNull((String)hshValues.get("sel_active"));
			if(strAction.equalsIgnoreCase("insert"))
			{
				String strQuery=SQLParser.getSqlQuery("sel_rbiguidelines_restr_maxsno");
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strSNo=correctNull((String)rs.getString("rbi_restr_maxsno"));
				}
				hshQuery.put("strQueryId","ins_rbiguidelines_restr");
				arrValues.add(strSNo);
				arrValues.add(strTerms);
				arrValues.add(strModule);
				arrValues.add(strCompliance);
				arrValues.add(strSelectType);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
			}
			else if(strAction.equalsIgnoreCase("update"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","upd_rbiguidelines_restrs");
				arrValues.add(strTerms);
				arrValues.add(strCompliance);
				arrValues.add(strSelectType);
				arrValues.add(strModule);
				arrValues.add(strSNo);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","del_rbiguidelines_restr");
				arrValues.add(strSNo);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
			}
			hshQueryValues.put("size","1");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		catch(Exception ce)
		{
			throw new EJBException(ce.toString());
		}
	}
	public HashMap getRBIGuidelines(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ArrayList arrRow=new ArrayList();
		ResultSet rs=null;
		try
		{
			String strModule=correctNull((String)hshValues.get("sel_Module"));
			String strCompliances=correctNull((String)hshValues.get("sel_compliances"));
			String StrSelectType=correctNull((String)hshValues.get("sel_active"));
			String strQuery=SQLParser.getSqlQuery("sel_rbiguidelines_restr^"+strModule+"^"+strCompliances);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				ArrayList arrCol=new ArrayList();
				arrCol.add(correctNull((String)rs.getString("rbi_restr_sno")));
				arrCol.add(correctNull((String)rs.getString("rbi_restr_desc")));
				arrCol.add(correctNull((String)rs.getString("rbi_active_type")));
				arrRow.add(arrCol);
			}
			hshRecord.put("arrRow",arrRow);
			hshRecord.put("strModule",strModule);
			hshRecord.put("strCompliance",strCompliances);
		}
		catch (Exception ce)
		{
			throw new EJBException("Error in getRBIGuidelines for Restructuring " + ce.toString());
		}
		finally
		{
			try
			{
				if (rs != null)
					rs.close();
			}
			catch (Exception cf)
			{
				throw new EJBException("Error closing the connection "+ cf.getMessage());
			}
		}
		return hshRecord;
	}
}