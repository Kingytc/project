package com.sai.laps.ejb.document;

 
import java.sql.ResultSet;
 
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.ejb.dependdetails.DependDetailsBean;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.tagdatahelper.TagDataHelper7;

@Stateless(name = "DocumentBean", mappedName = "DocumentHome")
@Remote (DocumentRemote.class)
public class DocumentBean extends BeanAdapter
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(DocumentBean.class);
	/**
	*	Function  updateData :This Method is invoked for updating table
	*	@param hshValues     :Carries all the request parametes as HashMap
	*   @return void		 
	*	@exception java.ejb.EJBException
	*/
	public HashMap updateData(HashMap hshValues) 
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		String strExp = "$";
		StringBuilder sbAuditAlternate = new StringBuilder();
		StringBuilder sbAuditTrial=new StringBuilder();
		String strKeyId = "";
		String strAction = "";
		StringBuilder sbolddata=new StringBuilder();
		ResultSet rs = null,rs1=null;
		String strDocumentNo = "";
		try
		{		
			TagDataHelper7 tagData = new TagDataHelper7();
			strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			strAction = Helper.correctNull((String) hshValues.get("hidAction"));
			strDocumentNo=Helper.correctNull((String)hshValues.get("hidDocId"));
			if(strAction.equalsIgnoreCase("update"))
			{				
				if(!strDocumentNo.equals(""))
				{ 
					rs=DBUtils.executeLAPSQuery("docselect^"+strDocumentNo);
					while(rs.next())
					{
						if(Helper.correctNull((String)rs.getString("doc_type")).equalsIgnoreCase("A"))
						{
							sbolddata.append("Document Type = ").append("By Applicant");
						}
						else
						{
							sbolddata.append("Document Type = ").append("By Bank");
						}
						sbolddata.append("~Description=").append(Helper.correctNull((String)rs.getString("doc_desc")))
						.append("~Security Code=").append(Helper.correctNull((String)tagData.getStaticDataDesc("1",Helper.correctNull((String)rs.getString("doc_scode")))))
						.append("~Document Code=").append(Helper.correctNull((String)tagData.getStaticDataDesc("40",Helper.correctNull((String)rs.getString("doc_primary")))))
						.append("~Primary Rules=").append(Helper.correctNull((String)rs.getString("doc_prule")));
						rs1 = DBUtils.executeLAPSQuery("commdocview2^"+Helper.correctNull((String)hshValues.get("hidDocId")));
						int i=0;
						while(rs1.next())
						{
							if(!(Helper.correctNull((String)rs1.getString("doc_subalternate")).equalsIgnoreCase("")|| Helper.correctNull((String)rs1.getString("doc_subrule")).equalsIgnoreCase("")))
							{
								sbolddata.append("~Alternate-Doc "+(i+1)+" = ");
								sbolddata.append(Helper.correctNull((String)rs1.getString("doc_subalternate")));
								sbolddata.append("~Alternate -Rules"+(i+1)+"  =");
								sbolddata.append(Helper.correctNull((String)rs1.getString("doc_subrule")));
								
							}
							i= i+1;
							
						}
						//.append("~"+sbAuditAlternate);
					}
				}
			}
			hshValues.put("hidAction","update");
			hshQueryValues.put("size","8");
			
			hshQuery.put("strQueryId","docdelete");	
			arrValues.add(hshValues.get("hidDocId"));
			hshQuery.put("arrValues",arrValues);
			
			hshQueryValues.put("1",hshQuery);
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","subdocdelete");
			arrValues.add(hshValues.get("hidDocId"));
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("2",hshQuery);
			hshQuery=new HashMap();
			hshQuery=insertParent(hshValues);
			hshQuery.put("valchanged",(String)hshQuery.get("valchanged"));
			hshQueryValues.put("3",hshQuery);
			hshQueryValues.put("start","4");
			hshQuery=new HashMap();
			hshQuery=insertRow1(hshValues,hshQueryValues);
			//Audit Trial - For Alternate Rules
			sbAuditAlternate = (StringBuilder)hshQuery.get("sbAudit");
			//End
			strExp = strExp+"Cannot modify this document it is used in Products";
			EJBInvoker.executeStateLess("dataaccess",hshQuery,"updateData");
			hshQuery=new HashMap();
			hshQuery.put("hidUsedFor",(String)hshValues.get("hidDocId"));
			
			
/** For Entering the values into 'AuditTrail' */
			String strDocSecCode = "";
			String strDocCode = "";
			String strDocType = "";
			if(correctNull((String)hshValues.get("chodoc_type")).trim().equalsIgnoreCase("A"))
				strDocType = "By the Applicant";
			else{
				strDocType = "By the Bank";
			}
			
			
			//Get the value from 'Static data master' whose id='1'
			strDocSecCode = Helper.correctNull((String)tagData.getStaticDataDesc("1",
					Helper.correctNull((String)hshValues.get("sec_code"))));
			
			//Get the value from 'Static data master' whose id='40'
			strDocCode = Helper.correctNull((String)tagData.getStaticDataDesc("40",
					Helper.correctNull((String)hshValues.get("txtdoc_docsp"))));
			
			sbAuditTrial.append("Document Type=").append(correctNull(strDocType))
			.append("~Description=").append(correctNull((String)hshValues.get("txtdoc_desc")))
			.append("~Security Code=").append(correctNull((String)strDocSecCode))
			.append("~Document Code=").append(correctNull((String)strDocCode))
			.append("~Primary Rules=").append(correctNull((String)hshValues.get("taadoc_rulesp")))
			.append("~"+sbAuditAlternate);
			AuditTrial.auditNewLog(hshValues,"10",strKeyId,sbAuditTrial.toString(),sbolddata.toString());
/** End */

			HashMap hshResult=getData(hshQuery);
			return hshResult;
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in updateData ===> "+ce.toString());
		}
	}
	
	/**
	*	Function  insertParent :This Method common method for inserting parent
								table
	*	@param hshValues       :Carries all the request parametes as HashMap
	*   @return hshQuery	   :contails all the request paramaters and query 
	*	@exception java.ejb.Exception
	*/
	
	private HashMap insertParent(HashMap hshValues) throws Exception
	{
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		hshQuery.put("strQueryId","docinsert");
		String valchanged="";
		arrValues.add(correctNull((String)hshValues.get("hidDocId")));
		arrValues.add(correctNull((String)hshValues.get("txtdoc_desc")));
		String val=correctNull((String)hshValues.get("hidaction"));
		if(val.equalsIgnoreCase(""))
		{
		arrValues.add(correctNull((String)hshValues.get("chodoc_type")));
		 valchanged="n";
		}
		else{
			arrValues.add(correctNull((String)hshValues.get("hid_value")));
		    valchanged="y";
		}
		arrValues.add(correctNull((String)hshValues.get("txtdoc_docsp")));
		arrValues.add(correctNull((String)hshValues.get("taadoc_rulesp")));
		arrValues.add(correctNull((String)hshValues.get("sec_code")));
		arrValues.add(correctNull((String)hshValues.get("hid_doccode")));
		arrValues.add(correctNull((String)hshValues.get("hid_docdate")));
		arrValues.add(correctNull((String)hshValues.get("hid_docvalue")));
		arrValues.add(correctNull((String)hshValues.get("hid_docmaturitydate")));
		arrValues.add(correctNull((String)hshValues.get("hid_docrequired")));
		arrValues.add(correctNull((String)hshValues.get("hid_docmandatory")));
		arrValues.add(correctNull((String)hshValues.get("txtdoc_code")));
		hshQuery.put("valchanged",valchanged);
		hshQuery.put("arrValues",arrValues);
		return hshQuery;	
	}

	/**
	*	Function  insertRow1   :This Method common method for inserting detail 
								table
	*	@param hshValues       :Carries all the request parametes as HashMap
	*   @return hshQuery	   :contails all the request paramaters and query 
	*	@exception java.ejb.Exception
	*/
	private HashMap insertRow1(HashMap hshValues,HashMap hshQueryValues)throws Exception
	{
		HashMap hshQuery=null;
		ArrayList arrValues=null;
		String strDocNumber="";
		String []stralternate=null;
		String []strrules=null;
		String []stridentify=null;
		int intstart=Integer.parseInt((String)hshQueryValues.get("start"));
		StringBuilder sbAudit = new StringBuilder();
		try
		{
			strDocNumber=(String)hshValues.get("hidDocId");
			stralternate=(String[])hshValues.get("txtdoc_subalternate");
			strrules=(String[])hshValues.get("taadoc_subrule");
			stridentify=(String[])hshValues.get("hiddoc_subidentify");
			//stridentify=new stridentify[5];
			stridentify[0]="A1";
			stridentify[1]="A2";
			stridentify[2]="A3";
			stridentify[3]="A4";
			stridentify[4]="A5";
			for(int i=intstart;i<(stridentify.length + intstart);i++)
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","docsubinsert");
				arrValues.add(strDocNumber);
				arrValues.add(stralternate[i-intstart]);
				arrValues.add(strrules[i-intstart]);
				arrValues.add(stridentify[i-intstart]);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(i),hshQuery);
				//For Audit Trial Purpose
				if(!stralternate[i-intstart].trim().equalsIgnoreCase("")){
				sbAudit.append("Alternate-Doc"+(i-intstart+1)+"="+stralternate[i-intstart]+"~");
				sbAudit.append("Alternate-Rules"+(i-intstart+1)+"="+strrules[i-intstart]+"~");
				}
				//End
			}
			hshQueryValues.put("sbAudit",sbAudit);
		}
		catch(Exception e)
		{
			throw new EJBException("Exception in insert row 1"+e.getMessage());
		}
		return hshQueryValues;
	}
	
	/**
	*	Function  insertData   :This Method common method for inserting parent- 
								Detail table
	*	@param hshValues       :Carries all the request parametes as HashMap
	*   @return hshQuery	   :contails all the request paramaters and query 
	*	@exception java.ejb.EJBException
	*/
	
	public HashMap insertData(HashMap hshValues) 
	{
		String strQuery="";
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		 
		ResultSet rs=null;
		int intDocId=0;
		String strDocId="";
		StringBuilder sbAuditTrial=new StringBuilder();
		StringBuilder sbAuditAlternate = new StringBuilder();
		try
		{	 	
			 rs=DBUtils.executeLAPSQuery("docmax");
			 hshValues.put("hidAction","insert");
			while(rs.next())
			{
				strDocId=correctNull(rs.getString(1));
				if(!strDocId.equals(""))
				{
					intDocId=Integer.parseInt(strDocId)+1;
				}
			}
			strDocId=String.valueOf(intDocId);
			hshValues.put("hidDocId",strDocId);
			if(rs!=null)
			{
				rs.close();
			}
			 
			hshQueryValues.put("size","6");
			hshQuery=new HashMap();
			hshQuery=insertParent(hshValues);			
			hshQueryValues.put("1",hshQuery);
			hshQuery=new HashMap();
			hshQueryValues.put("start","2");
			hshQuery=insertRow1(hshValues,hshQueryValues);
			//AuditTrial - For Alternate Doc's and Rules
			sbAuditAlternate = (StringBuilder)hshQuery.get("sbAudit");
			//End
			EJBInvoker.executeStateLess("dataaccess",hshQuery,"updateData");
			hshQuery=new HashMap();
			hshQuery.put("hidUsedFor",strDocId);
			HashMap hshResult=getData(hshQuery);
			/** For Entering the values into 'AuditTrail' */
			String strDocSecCode = "";
			String strDocCode = "";
			String strDocType = "";
			if(correctNull((String)hshValues.get("chodoc_type")).trim().equalsIgnoreCase("A"))
				strDocType = "By the Applicant";
			else{
				strDocType = "By the Bank";
			}
			
			TagDataHelper7 tagData = new TagDataHelper7();
			//Get the value from 'Static data master' whose id='1'
			strDocSecCode = Helper.correctNull((String)tagData.getStaticDataDesc("1",
					Helper.correctNull((String)hshValues.get("sec_code"))));
			
			//Get the value from 'Static data master' whose id='40'
			strDocCode = Helper.correctNull((String)tagData.getStaticDataDesc("40",
					Helper.correctNull((String)hshValues.get("txtdoc_docsp"))));
			
			//To get the 'Alternate Documents and Rules'
			
			
			sbAuditTrial.append("Document Type=").append(correctNull(strDocType))
			.append("~Description=").append(correctNull((String)hshValues.get("txtdoc_desc")))
			.append("~Security Code=").append(correctNull((String)strDocSecCode))
			.append("~Document Code=").append(correctNull((String)strDocCode))
			.append("~Primary Rules=").append(correctNull((String)hshValues.get("taadoc_rulesp")))
			.append("~"+sbAuditAlternate);
			AuditTrial.auditLog(hshValues,"10","",sbAuditTrial.toString());
/** End */
			return hshResult;
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in insertData "+ce.toString());
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

	/**
	*	Function  deleteData   :This Method common method for deleting parent or 
								Detail table
	*	@param hshValues       :Carries all the request parametes as HashMap
	*   @return hshQuery	   :contails all the request paramaters and query 
	*	@exception java.ejb.EJBException
	*/
	public HashMap deleteData(HashMap hshValues) 
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		ResultSet rs=null;
		String strParentDelete="";
		String strChildDelete1="";
		String strChildDelete2="";
		String strChildDelete3="";
		String strChildDelete4="";
		String strChildDelete5="";
		String strExp="$";
		StringBuilder sbAuditAlternate = new StringBuilder();
		StringBuilder sbnewAuditTrial = new StringBuilder();
		String strKeyId = "";
		String strAction = "";
		StringBuilder sboldAuditTrial=new StringBuilder();
		StringBuilder sboldAuditTrial1=new StringBuilder();
		String strDocumentNo = "";
		
		try
		{
			strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			strAction = Helper.correctNull((String) hshValues.get("hidAction"));
			if(strAction.equalsIgnoreCase("delete"))
			{
				strDocumentNo=correctNull((String)hshValues.get("hidDocId"));
				/*if(!strDocumentNo.equals(""))
				{ 
					rs=DBUtils.executeLAPSQuery("docselect^"+strDocumentNo);
					while(rs.next())
					{
						if(Helper.correctNull((String)rs.getString("doc_type")).equalsIgnoreCase("A"))
						{
							sboldAuditTrial.append("Document Type = ").append("By Applicant");
						}
						else
						{
							sboldAuditTrial.append("Document Type = ").append("By Bank");
						}
						sboldAuditTrial.append("~Description=").append(Helper.correctNull((String)rs.getString("doc_desc")))
						.append("~Security Code=").append(Helper.correctNull((String)rs.getString("doc_scode")))
						.append("~Document Code=").append(Helper.correctNull((String)rs.getString("doc_primary")))
						.append("~"+sbAuditAlternate);
					}
					if(rs!=null)
					{
						rs.close();
					}
				}*/
			}
			hshValues.put("hidAction","delete");
			strParentDelete=correctNull((String)hshValues.get("hiddocrow"));
			strChildDelete1=correctNull((String)hshValues.get("hiddocsubrow1"));
			strChildDelete2=correctNull((String)hshValues.get("hiddocsubrow2"));
			strChildDelete3=correctNull((String)hshValues.get("hiddocsubrow3"));
			strChildDelete4=correctNull((String)hshValues.get("hiddocsubrow4"));
			strChildDelete5=correctNull((String)hshValues.get("hiddocsubrow5"));
			ArrayList vDel = new ArrayList();
			vDel.add(strChildDelete1);
			vDel.add(strChildDelete2);
			vDel.add(strChildDelete3);
			vDel.add(strChildDelete4);
			vDel.add(strChildDelete5);
             int intCount2=0;
             String hidDocId=correctNull((String)hshValues.get("hidDocId"));
			if(!strParentDelete.equals("") && strParentDelete.equalsIgnoreCase("A"))
			{
				rs=DBUtils.executeLAPSQuery("setdelcheckdocument^"+hidDocId);
				if(rs.next())
				{
					intCount2 = Integer.parseInt(rs.getString(1));
				}
				if(intCount2 == 0)
				{
					hshQueryValues.put("size","2");
					hshQuery.put("strQueryId","docsubdelete");
					arrValues.add(hshValues.get("hidDocId"));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","docdelete");
					arrValues.add(hshValues.get("hidDocId"));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("2",hshQuery);
				}
				else{
					strExp = strExp+"Cannot delete the document,it is attached to product";
					throw new Exception(strExp);
					
				}
			}
			else 
			{
				int i=0;
				
				rs=DBUtils.executeLAPSQuery("setdelcheckdocument^"+hidDocId);
				if(rs.next())
				{
					intCount2 = Integer.parseInt(rs.getString(1));
				}
				if(intCount2 == 0)
				{
					for(int k=0;k<vDel.size();k++)
					{
						if(!vDel.get(k).equals(""))
						{
							i++;
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							arrValues.add(hshValues.get("hidDocId"));
							arrValues.add(vDel.get(k));
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(Integer.toString(i),hshQuery);
							hshQuery.put("strQueryId","docsubdeletep");
						}
					}
				}
				else{
					strExp = strExp+"Cannot delete the document,it is attached to product";
					throw new Exception(strExp);
				}
				
				hshQueryValues.put("size",Integer.toString(i));
									
			}
			hshQuery=new HashMap();
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
/** For Audit Trial */
			String strDocType = "";
			if(correctNull((String)hshValues.get("chodoc_type")).trim().equalsIgnoreCase("A"))
				strDocType = "By the Applicant";
			else{
				strDocType = "By the Bank";
			}

			TagDataHelper7 tagData = new TagDataHelper7();
			//Get the value from 'Static data master' whose id='1'
			String strDocSecCode = Helper.correctNull((String)tagData.getStaticDataDesc("1",
					Helper.correctNull((String)hshValues.get("sec_code"))));
			
			//Get the value from 'Static data master' whose id='40'
			String strDocCode = Helper.correctNull((String)tagData.getStaticDataDesc("40",
					Helper.correctNull((String)hshValues.get("txtdoc_docsp"))));
			
		    
			
			sboldAuditTrial.append("Document Type=").append(correctNull(strDocType))
			.append("~Description=").append(correctNull((String)hshValues.get("txtdoc_desc")))
			.append("~Security Code=").append(correctNull((String)strDocSecCode))
			.append("~Document Code=").append(correctNull((String)strDocCode))
			.append("~Primary Rules=").append(correctNull((String)hshValues.get("taadoc_rulesp")));
			
			sboldAuditTrial1 = deleteRow1(hshValues,hshQueryValues,strParentDelete,vDel);
			sboldAuditTrial.append(sboldAuditTrial1);
			
			AuditTrial.auditNewLog(hshValues,"10",strKeyId,sbnewAuditTrial.toString(),sboldAuditTrial.toString());
/** End */			
			
			hshQuery.put("hidUsedFor",(String)hshValues.get("hidDocId"));
			HashMap hshResult=getData(hshQuery);
			return hshResult;
		}
		catch(Exception ce)
		{
			throw new EJBException(strExp);
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

/**
 * Method created for 'Audit trial purpose'
 * @author Gokulakrishnan.C
 * @param hshValues
 * @param hshQueryValues
 * @param strParentDelete
 * @param vecDel
 * @return
 */
	private StringBuilder deleteRow1(HashMap hshValues, HashMap hshQueryValues, String strParentDelete, ArrayList vecDel) {
		HashMap hshQuery=null;
		ArrayList arrValues=null;
		String strDocNumber="";
		String []stralternate=null;
		String []strrules=null;
		String []stridentify=null;
		StringBuilder sbAudit = new StringBuilder();
		try
		{
			strDocNumber=(String)hshValues.get("hidDocId");
			stralternate=(String[])hshValues.get("txtdoc_subalternate");
			strrules=(String[])hshValues.get("taadoc_subrule");
			stridentify=(String[])hshValues.get("hiddoc_subidentify");
			stridentify[0]="A1";
			stridentify[1]="A2";
			stridentify[2]="A3";
			stridentify[3]="A4";
			stridentify[4]="A5";
			if(!strParentDelete.equals("") && strParentDelete.equalsIgnoreCase("A")){
				for(int i=0;i<(stridentify.length);i++)
				{
					//For Audit Trial Purpose
					if(!stralternate[i].trim().equalsIgnoreCase("")){
						sbAudit.append("Alternate-Doc"+(i+1)+"="+stralternate[i]+"~");
						sbAudit.append("Alternate-Rules"+(i+1)+"="+strrules[i]+"~");
					}
					//End
				}
			}else{
				for(int k=0;k<vecDel.size();k++)
				{
					String strValue = Helper.correctNull((String)vecDel.get(k));
					if(!strValue.trim().equals(""))
					{
						int intValue = Integer.parseInt(Helper.correctInt((String)strValue.substring(1)));
						sbAudit.append("~Alternate-Doc"+(intValue)+"="+stralternate[intValue-1]+"~");
						sbAudit.append("~Alternate-Rules"+(intValue)+"="+strrules[intValue-1]+"~");
					}
				}	
			}
		}catch(Exception e)
		{
			throw new EJBException("Exception in deleteRow1 of DocumentBean "+e.getMessage());
		}
		return sbAudit;
	}

	/**
	*	Function  getData	   :This Method common method for selecting parent- 
								Detail records
	*	@param hshValues       :Carries all the request parametes as HashMap
	*   @return hshQuery	   :contails all the request paramaters and query 
	*	@exception java.ejb.EJBException
	*/
	
	public HashMap getData(HashMap hshRequestValues) 
	{
		 
		String strQuery="";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList arryCol=null;
		ArrayList arryRow=new ArrayList();
		String strDocumentNo="";
		boolean recordflag=false;
		try
		{	
			strDocumentNo=correctNull((String)hshRequestValues.get("hidUsedFor"));
			if(!strDocumentNo.equals(""))
			{ 
				 rs=DBUtils.executeLAPSQuery("docselect^"+strDocumentNo);
				
				while(rs.next())
				{
					recordflag=true;
					hshRecord.put("doc_code",correctNull(rs.getString("doc_code")));
					hshRecord.put("doc_desc",correctNull(rs.getString("doc_desc")));
					hshRecord.put("doc_type",correctNull(rs.getString("doc_type")));
					hshRecord.put("doc_primary",correctNull(rs.getString("doc_primary")));
					hshRecord.put("doc_prule",correctNull(rs.getString("doc_prule")));					
					hshRecord.put("doc_create_date",correctNull(rs.getString("doc_create_date")));
					hshRecord.put("doc_scode",correctNull(rs.getString("doc_scode")));
					hshRecord.put("reqdcode",correctNull(rs.getString("reqdcode")));
					hshRecord.put("reqddate",correctNull(rs.getString("reqddate")));
					hshRecord.put("reqdvalue",correctNull(rs.getString("reqdvalue")));
					hshRecord.put("reqdmdate",correctNull(rs.getString("reqdmdate")));					
					hshRecord.put("docreqfl",correctNull(rs.getString("docreqfl")));
					hshRecord.put("docmanfl",correctNull(rs.getString("docmanfl")));
					hshRecord.put("doc_codename",correctNull(rs.getString("doc_codename")));
				}
				   rs=DBUtils.executeLAPSQuery("docsubselect^"+strDocumentNo);

				while(rs.next())
				{
					arryCol=new ArrayList();
					arryCol.add(rs.getString("doc_subid"));
					arryCol.add(rs.getString("doc_subalternate"));
					arryCol.add(rs.getString("doc_subrule"));
					arryCol.add(rs.getString("doc_subidentify"));
					arryRow.add(arryCol);
				}
				hshRecord.put("arryRow",arryRow);
				if(recordflag)
					hshRecord.put("recordflag","Y");
				else
					hshRecord.put("recordflag","N");
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
		return hshRecord;
	}

	/**
	*	Function  getUsedFor   :This Method common method for getting help
								values form parent table
	*	@param hshValues       :Carries all the request parametes as HashMap
	*   @return hshQuery	   :contails all the request paramaters and query 
	*	@exception java.ejb.EJBException
	*/

	public HashMap getUsedFor(HashMap hashValues) 
	{
		 
		ResultSet rs=null;
		ResultSet rs1=null;
		String strValue=correctNull((String)hashValues.get("value"));
		HashMap hashResult=new HashMap();
		ArrayList arrCode=new ArrayList();
		ArrayList arrDesc=new ArrayList();
		ArrayList arrValues=new ArrayList();
		String strQuery="";
		boolean bState=false;
		try
		{ 
			  rs=DBUtils.executeLAPSQuery("dochelp^"+strValue);
			  bState=rs.next();
			if(!bState)
			{
				hashResult.put("noData","noData");	
			}
			else
			{
				hashResult.put("noData","Data");
			}
			while(bState)
			{
				arrCode.add(rs.getString("doc_code"));
				arrDesc.add(rs.getString("doc_desc"));
				bState=rs.next();
			}
			
			
			rs1=DBUtils.executeLAPSQuery("sel_doc_id");
			
			while(rs1.next()){
				arrValues.add(rs1.getString("doc_id"));
			}
			
			hashResult.put("arrCode",arrCode);
			hashResult.put("arrDesc",arrDesc);
			hashResult.put("arrVal",arrValues);
			
			return hashResult;
		}
		catch(Exception e)
		{
			throw new EJBException("Exception in TdocHelp "+e.getMessage());
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
			catch(Exception e)
			{
				throw new EJBException("Exception in Closing Connection "+e.getMessage());
			}		
		}
	}
}
