package com.sai.laps.ejb.ssidemographics;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.StringTokenizer;

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

@Stateless(name = "ssidemographicsBean", mappedName = "ssidemographicsHome")
@Remote (ssidemographicsRemote.class)
public class ssidemographicsBean extends BeanAdapter
{	
	
				
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(ssidemographicsBean.class);
	private static final long serialVersionUID = -5351906114795356317L;
	/**
	 * 
	 */
	
				public String printype="";
				public String prinfname="";
				public String prinmname="";
				public String prinlname="";
				public String prinfhname="";
				public String prinfullname="";

				public String prinage="";
				public String prinsex="";
				public String princaste="";
				public String prinracno="";
				public String prinoff="";
				public String ssi_officetelno="";
				public String ssi_residencetelno="";
				public String prinres="";
				public String prinexser="";
				public String prinqualif="";
				public String ssi_prinpassportno="";
				public String shareper="";
				public String faceval="";
				public String shareheld="";
				public String share_type="";

				public String hidVal="";
				public String appno="";
				
				// added by subha
				public String txtloan_cname="";
							

           
	public HashMap autoGen(HashMap hshRequestValues) 
	{	
			
				HashMap hshRecord = null;
				hshRecord=new HashMap();
				boolean stats=false;
				int prinid=1;
				String prinid1="";
				
				printype =   Helper.correctNull((String)hshRequestValues.get("printype"));
				prinfname =  Helper.correctNull((String)hshRequestValues.get("prinfname"));
				prinmname=   Helper.correctNull((String)hshRequestValues.get("prinmname"));
				prinlname=   Helper.correctNull((String)hshRequestValues.get("prinlname"));
				prinfhname = Helper.correctNull((String)hshRequestValues.get("prinfhname"));
				prinage =    Helper.correctNull((String)hshRequestValues.get("prinage"));				
				prinsex =    Helper.correctNull((String)hshRequestValues.get("prinsex"));
				princaste =  Helper.correctNull((String)hshRequestValues.get("princaste"));
				prinracno =  Helper.correctNull((String)hshRequestValues.get("prinracno"));
				prinoff =    Helper.correctNull((String)hshRequestValues.get("prinoff"));
				prinres =    Helper.correctNull((String)hshRequestValues.get("prinres"));
				ssi_officetelno=Helper.correctNull((String)hshRequestValues.get("ssi_officetelno"));
				ssi_residencetelno=Helper.correctNull((String)hshRequestValues.get("ssi_residencetelno"));
				prinexser =  Helper.correctNull((String)hshRequestValues.get("prinexser"));
				prinqualif = Helper.correctNull((String)hshRequestValues.get("prinqualif"));
				ssi_prinpassportno=Helper.correctNull((String)hshRequestValues.get("ssi_prinpassportno"));
				shareper=Helper.correctNull((String)hshRequestValues.get("txt_sharepercent"));
				faceval=Helper.correctNull((String)hshRequestValues.get("txt_facevalue"));
				shareheld=Helper.correctNull((String)hshRequestValues.get("txt_sharesheld"));
				share_type=Helper.correctNull((String)hshRequestValues.get("share_holder"));
				hidVal =     Helper.correctNull((String)hshRequestValues.get("hidVal"));
				appno =      Helper.correctNull((String)hshRequestValues.get("appno"));

		if(hidVal.equals("edit"))
						{							
				try
				{						
					prinid1 =Helper.correctNull((String)hshRequestValues.get("prinname"));				
					stats=UpdateData(appno,prinid1,printype,prinfname,prinlname,prinmname,prinfhname,prinage,prinsex,princaste,prinexser,prinracno,prinoff,prinres,prinqualif,ssi_prinpassportno,ssi_officetelno,ssi_residencetelno);
									
					hshRecord.put("prinfullname",prinid1);					
					hshRecord.put("printype",printype);
					hshRecord.put("prinfname",prinfname);
					hshRecord.put("prinlname",prinlname);
					hshRecord.put("prinmname",prinmname);
					hshRecord.put("prinfhname",prinfhname);
					hshRecord.put("prinage",prinage);
					hshRecord.put("prinsex",prinsex);
					hshRecord.put("princaste",princaste);
					hshRecord.put("prinexser",prinexser);					
					hshRecord.put("prinracno",prinracno);
					hshRecord.put("prinoff",prinoff);
					hshRecord.put("prinres",prinres);
					hshRecord.put("ssi_officetelno",ssi_officetelno);
					hshRecord.put("ssi_residencetelno",ssi_residencetelno);
					hshRecord.put("prinqualif",prinqualif);	
					hshRecord.put("ssi_prinpassportno",ssi_prinpassportno);	
					hshRecord.put("shareper",shareper);
					hshRecord.put("faceval",faceval);
					hshRecord.put("shareheld",shareheld);
					hshRecord.put("share_type",share_type);


					hshRecord.put("comapp_id",correctNull((String)hshRequestValues.get("comapp_id")));
					hshRecord.put("hidPageType",correctNull((String)hshRequestValues.get("hidPageType")));
					hshRecord.put("hidCategoryType",correctNull((String)hshRequestValues.get("hidCategoryType")));
					hshRecord.put("hidSSIType",correctNull((String)hshRequestValues.get("hidSSIType")));
					
				}
				catch(Exception cf)
				{

					log.error("Exception in calling update "+cf.getMessage());						

									

				}
			}

			if(hidVal.equals("delete"))
			{				
				try
				{							
					
					prinid1 = Helper.correctNull((String)hshRequestValues.get("prinname"));
					stats=DeleteData(prinid1,appno);
							
				}
				catch(Exception cf)
				{

					log.error("Exception in calling delete "+cf.getMessage());

			

						
				}

			}
			
			if(hidVal.equals("insert"))
			{	
				ResultSet rs = null;
				String strQuery="";
				try
				{
					
					strQuery = SQLParser.getSqlQuery("selmaxprinid^"+appno);
					rs = DBUtils.executeQuery(strQuery);
					stats = rs.next();
					
					if(stats)
					{		
						
						prinid=Integer.parseInt(Helper.correctInt(rs.getString("ssi_prinid")));
					}
					
					// insert in to ss-_prindemographics (calling inserdata method)	
				   stats=InsertData(appno,prinid,printype,prinfname,prinlname,prinmname,prinfhname,prinage,prinsex,princaste,prinexser,prinracno,prinoff,prinres,prinqualif,ssi_prinpassportno,ssi_officetelno,ssi_residencetelno);		
		}
		catch(Exception ce)
		{
			throw new EJBException("Error In slecting max value and inserting  (from,in) ssi_prindemographics  "+ce.toString());
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

		} // close of insert


			hshRecord.put("hidVal",hidVal);						
			
			return hshRecord;
	}
	
	public HashMap updateOpsdemograph(HashMap hshRequestValues) 
	{	
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		
		HashMap hshRecord = null;
		hshRecord=new HashMap();
		//boolean stats=false;
		//int prinid=1;
		String hidVal="";
		String appno="";
		String demoid="";
		String prinfullname="";
		String strQuery = "";
		ResultSet rs = null;
		String strrecordflag="N";
		try
		{
			hidVal =Helper.correctNull((String)hshRequestValues.get("hidVal"));
			appno=Helper.correctNull((String)hshRequestValues.get("appno"));
			demoid=Helper.correctNull((String)hshRequestValues.get("hidCoDemoId"));
			prinfullname=Helper.correctNull((String)hshRequestValues.get("prinfullname"));
			hshRequestValues.put("demoid",demoid);
			String strPersonName = "",strPersonType = "";
			String strParticularPerson = "",strPersonType_desc = "",strdin="";
			
			//hshRequestValues.put("hidVal",hidVal);
			StringBuilder strOldAudit = new StringBuilder();
			if(hidVal.equalsIgnoreCase("delete") || !(hidVal.equals("add") && prinfullname.equalsIgnoreCase("New")))
			{
				strQuery= SQLParser.getSqlQuery("opsdemosel^"+appno+"^"+prinfullname);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next()){ 
					strrecordflag = "Y";
					strPersonName = Helper.correctNull((String)rs.getString("perapp_fname"));
					strPersonType = Helper.correctNull((String)rs.getString("demo_apptype"));
				}
				strOldAudit.append("~Name of the Person = ");
				strOldAudit.append(strPersonName);
				strOldAudit.append("~Proprietor / Partner/ Guarantor Type= ");
				StringTokenizer stPersonType = new StringTokenizer(strPersonType,"@");
				int i=0;
				while (stPersonType.hasMoreTokens())			
				{
					if(i!=0)
					{
						strOldAudit.append(" , ");
					}
					i=i+1;			
					strParticularPerson=(String)stPersonType.nextToken();
					if(strParticularPerson.equalsIgnoreCase("P"))
					{
						strPersonType_desc = "Promoters / Founders";
					}
					else if(strParticularPerson.equalsIgnoreCase("D"))
					{
						strPersonType_desc = "Directors";
					}	else if(strParticularPerson.equalsIgnoreCase("G"))
					{
						strPersonType_desc = "Guarantors";
					}	else if(strParticularPerson.equalsIgnoreCase("O"))
					{
						strPersonType_desc = "Share Holders";
					}	else if(strParticularPerson.equalsIgnoreCase("C"))
					{
						strPersonType_desc = "Chairman";
					}	else if(strParticularPerson.equalsIgnoreCase("MD"))
					{
						strPersonType_desc = "Chairman";
					}	else if(strParticularPerson.equalsIgnoreCase("PA"))
					{
						strPersonType_desc = "Managing Director";
					}	else if(strParticularPerson.equalsIgnoreCase("SP"))
					{
						strPersonType_desc = "Sole Proprietor";
					}	else if(strParticularPerson.equalsIgnoreCase("SH"))
					{
						strPersonType_desc = "SHG Member";
					}else if(strParticularPerson.equalsIgnoreCase("CA"))
					{
						strPersonType_desc = "Co - Applicant";
					}else if(strParticularPerson.equalsIgnoreCase("PT"))
					{
						strPersonType_desc = "Partners";
					}
					
					if(rs != null){
					rs.close();	
					}
					
					
					strOldAudit.append(strPersonType_desc);
				}
				rs=DBUtils.executeLAPSQuery("mastgetdemographics^"+prinfullname);				 
				if(rs.next()){
					
				 strdin = correctNull(rs.getString("perapp_din"));
				 
				}
				strOldAudit.append("~DIN = "+strdin);
			}
			
			
			if(hidVal.equals("add") && prinfullname.equalsIgnoreCase("New"))
			{	
				
				hshRequestValues.put("hidAction","Insert");
				hshQueryValues = new HashMap();
				int intUpdateSize=0;
				hshQuery = new HashMap();		
				arrValues=new ArrayList();
				intUpdateSize++;
				hshQuery.put("strQueryId","opsdemoins");
				arrValues.add(appno);
				arrValues.add(demoid);
				arrValues.add(correctNull((String )hshRequestValues.get("hidprintype")));
				//arrValues.add(correctNull((String )hshRequestValues.get("sel_minor")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);	
				hshQueryValues.put("size",Integer.toString(intUpdateSize));
				
				hshQuery = new HashMap();		
				arrValues=new ArrayList();
				intUpdateSize++;
				hshQuery.put("strQueryId","mastdemographicsupdtery");
				arrValues.add(correctNull((String )hshRequestValues.get("txt_din")));
				arrValues.add(demoid);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);	
				hshQueryValues.put("size",Integer.toString(intUpdateSize));
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}else{
			
		hshRequestValues.put("hidAction","Delete");
		hshQueryValues = new HashMap();
		hshQuery = new HashMap();		
		arrValues=new ArrayList();
		hshQueryValues.put("size","1");
		hshQuery.put("strQueryId","opsdemodelete");
		arrValues.add(appno);
		arrValues.add(prinfullname);
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("1",hshQuery);
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
		
		hshQueryValues = new HashMap();
		hshQuery = new HashMap();		
		arrValues=new ArrayList();
		hshQueryValues.put("size","1");
		hshQuery.put("strQueryId","mastdemographicsupdtery");
		arrValues.add("");
		arrValues.add(demoid);
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("1",hshQuery);
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
		
		hshRequestValues.put("hidAction","Insert");
		hshQueryValues = new HashMap();
		int intUpdateSize=0;
		hshQuery = new HashMap();		
		arrValues=new ArrayList();
		intUpdateSize++;
		hshQuery.put("strQueryId","opsdemoins");
		arrValues.add(appno);
		arrValues.add(demoid);
		arrValues.add(correctNull((String )hshRequestValues.get("hidprintype")));
		//arrValues.add(correctNull((String )hshRequestValues.get("sel_minor")));
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);	
		hshQueryValues.put("size",Integer.toString(intUpdateSize));
		
		hshQuery = new HashMap();		
		arrValues=new ArrayList();
		intUpdateSize++;
		hshQuery.put("strQueryId","mastdemographicsupdtery");
		arrValues.add(correctNull((String )hshRequestValues.get("txt_din")));
		arrValues.add(demoid);
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);	
		hshQueryValues.put("size",Integer.toString(intUpdateSize));
		
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		
		}
		if(hidVal.equals("delete"))
		{
			hshRequestValues.put("hidAction","Delete");
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();		
			arrValues=new ArrayList();
			hshQueryValues.put("size","1");
			hshQuery.put("strQueryId","opsdemodelete");
			arrValues.add(appno);
			arrValues.add(prinfullname);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
			
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();		
			arrValues=new ArrayList();
			hshQueryValues.put("size","1");
			hshQuery.put("strQueryId","mastdemographicsupdtery");
			arrValues.add("");
			arrValues.add(demoid);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
		}
		hshRecord=(HashMap)getOpsdemograph(hshRequestValues);
		
		StringBuilder strNewAudit=new StringBuilder();
		if(hidVal.equalsIgnoreCase("add"))
		{
			strQuery= SQLParser.getSqlQuery("opsdemosel^"+appno+"^"+demoid);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()){
				strPersonName = Helper.correctNull((String)rs.getString("perapp_fname"));
			}
			strNewAudit.append("~Name of the Person = ");
			strNewAudit.append(strPersonName);
			strNewAudit.append("~Proprietor / Partner/ Guarantor Type= ");
			strPersonType = Helper.correctNull((String )hshRequestValues.get("hidprintype"));
			StringTokenizer stPersonType = new StringTokenizer(strPersonType,"@");
			int i=0;
			while (stPersonType.hasMoreTokens())			
			{
				if(i!=0)
				{
					strNewAudit.append(" , ");
					
				}
				i=i+1;			
				strParticularPerson=(String)stPersonType.nextToken();
				if(strParticularPerson.equalsIgnoreCase("P"))
				{
					strPersonType_desc = "Promoters / Founders";
				}else if(strParticularPerson.equalsIgnoreCase("D"))
				{
					strPersonType_desc = "Directors";
				}	else if(strParticularPerson.equalsIgnoreCase("G"))
				{
					strPersonType_desc = "Guarantors";
				}	else if(strParticularPerson.equalsIgnoreCase("O"))
				{
					strPersonType_desc = "Share Holders";
				}	else if(strParticularPerson.equalsIgnoreCase("C"))
				{
					strPersonType_desc = "Chairman";
				}	else if(strParticularPerson.equalsIgnoreCase("MD"))
				{
					strPersonType_desc = "Managing Director";
				}	else if(strParticularPerson.equalsIgnoreCase("SP"))
				{
					strPersonType_desc = "Sole Proprietor";
				}	else if(strParticularPerson.equalsIgnoreCase("SH"))
				{
					strPersonType_desc = "SHG Member";
				}else if(strParticularPerson.equalsIgnoreCase("CA"))
				{
					strPersonType_desc = "Co - Applicant";
				}else if(strParticularPerson.equalsIgnoreCase("PT"))
				{
					strPersonType_desc = "Partners";
				}
				strNewAudit.append(strPersonType_desc);
				
			}				
			strNewAudit.append("~DIN = "+correctNull((String )hshRequestValues.get("txt_din")));
			
			
		}
		if(!hidVal.equalsIgnoreCase("delete")){
		if(strrecordflag.equalsIgnoreCase("Y")){
			hshRequestValues.put("strAction", "update");
		
		}else{
			hshRequestValues.put("strAction", "insert");
		}}else{
			hshRequestValues.put("strAction", "delete");
		}
		AuditTrial.auditNewLog(hshRequestValues, "170", appno, strNewAudit.toString(), strOldAudit.toString());
	   }
	catch(Exception ce)
	{
		throw new EJBException("inside update"+ce.toString());
	}
	return hshRecord;
}
private boolean InsertData(String appno,int prinid,String printype,String prinfname,String prinlname,String prinmname,String prinfhname,String prinage,String prinsex,String princaste,String prinexser,String prinracno,String prinoff,String prinres,String prinqualif,String ssi_prinpassportno,String ssi_officetelno,String ssi_residencetelno) 
	{

		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();		
		boolean bstate = false;
		try
		{
			hshQueryValues.put("size","1");
			hshQuery.put("strQueryId","ssiprinins");
			String prinid1=Integer.toString(prinid);
			
			arrValues.add(appno);
			arrValues.add(prinid1);			
			arrValues.add(printype);			
			arrValues.add(prinfname);			
			arrValues.add(prinlname);
			arrValues.add(prinmname);
			arrValues.add(prinfhname);			
			arrValues.add(prinage);
			arrValues.add(prinsex);
			arrValues.add(princaste);
			arrValues.add(prinexser);
			arrValues.add(prinracno);			
			arrValues.add(prinoff);
			arrValues.add(prinres);
			arrValues.add(prinqualif);
			arrValues.add(ssi_prinpassportno);
			arrValues.add(shareper);
			arrValues.add(faceval);
			arrValues.add(shareheld);
			arrValues.add(share_type);
			arrValues.add(ssi_officetelno);
			arrValues.add(ssi_residencetelno);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			bstate = true;

		}
		catch(Exception ce)
		{
			bstate = false;			
			throw new EJBException("problem in Delete"+ce);
		}

		return bstate;		
	}

	
	private boolean DeleteData(String prinid,String appno) 
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		boolean bstate = false;
		try
		{
			hshQueryValues.put("size","1");
			hshQuery.put("strQueryId","ssiprindel");
			arrValues.add(prinid);
			arrValues.add(appno);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			hshQueryValues.put("size", "1");
			hshQuery.put("strQueryId", "ssiexpparamdel");
			arrValues.add(prinid);
			arrValues.add(appno);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			
			hshQueryValues=new HashMap();
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQueryValues.put("size", "1");
			hshQuery.put("strQueryId","ssidelfinancialbnk1");
			arrValues.add(appno);
			arrValues.add(prinid);
			arrValues.add("P");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			
			hshQueryValues=new HashMap();
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQueryValues.put("size", "1");
			hshQuery.put("strQueryId","ssidelfinancialinv1");
			arrValues.add(appno);
			arrValues.add(prinid);
			arrValues.add("P");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			
			hshQueryValues=new HashMap();
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQueryValues.put("size", "1");
			hshQuery.put("strQueryId","ssidelfinancialpol1");
			arrValues.add(appno);
			arrValues.add(prinid);
			arrValues.add("P");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			
			hshQueryValues=new HashMap();
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQueryValues.put("size", "1");
			hshQuery.put("strQueryId","ssidelfinancialprop1");
			arrValues.add(appno);
			arrValues.add(prinid);
			arrValues.add("P");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			
			hshQueryValues=new HashMap();
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQueryValues.put("size", "1");
			hshQuery.put("strQueryId","ssidelfinancialliab1");
			arrValues.add(appno);
			arrValues.add(prinid);
			arrValues.add("P");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			
			hshQueryValues=new HashMap();
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQueryValues.put("size", "1");
			hshQuery.put("strQueryId","delcreditreport");
			arrValues.add(appno);
			arrValues.add(prinid);			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			
			hshQueryValues=new HashMap();
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQueryValues.put("size", "1");
			hshQuery.put("strQueryId","delcreditreport2");
			arrValues.add(appno);
			arrValues.add(prinid);			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			
			hshQueryValues=new HashMap();
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQueryValues.put("size", "1");
			hshQuery.put("strQueryId","delcreditreport3");
			arrValues.add(appno);
			arrValues.add(prinid);			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			
			bstate = true;

		}
		catch(Exception ce)
		{
			bstate = false;			
			throw new EJBException("problem in Delete"+ce);
		}

		return bstate;		
	}
	
/*	public OpsDeleteData(HashMap hshRequestValues) 
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		boolean bstate = false;
		try
		{
			hshQueryValues.put("size","1");
			hshQuery.put("strQueryId","opsdemodelete");
			//arrValues.add(prinid);
			arrValues.add(appno);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
	    }
		catch(Exception ce)
		{
			bstate = false;			
			throw new EJBException("problem in Delete"+ce);
		}

		return bstate;		
	}*/


	private boolean UpdateData(String appno,String prinid,String printype,String prinfname,String prinlname,String prinmname,String prinfhname,String prinage,String prinsex,String princaste,String prinexser,String prinracno,String prinoff,String prinres,String prinqualif,String ssi_prinpassportno,String ssi_officetelno,String ssi_residencetelno) 
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();		
		boolean bstate = false;
		try
		{
			hshQueryValues.put("size","1");	
			hshQuery.put("strQueryId","ssiprinup");					
			arrValues.add(printype);			
			arrValues.add(prinfname);			
			arrValues.add(prinlname);
			arrValues.add(prinmname);
			arrValues.add(prinfhname);			
			arrValues.add(prinage);
			arrValues.add(prinsex);
			arrValues.add(princaste);
			arrValues.add(prinexser);
			arrValues.add(prinracno);			
			arrValues.add(prinoff);
			arrValues.add(prinres);
			arrValues.add(prinqualif);
			arrValues.add(ssi_prinpassportno);
			arrValues.add(shareper);
			arrValues.add(faceval);
			arrValues.add(shareheld);
			arrValues.add(share_type);
			arrValues.add(ssi_officetelno);
			arrValues.add(ssi_residencetelno);
			
			arrValues.add(prinid);	
			arrValues.add(appno);			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			bstate = true;

		}
		catch(Exception ce)
		{
			bstate = false;			
			throw new EJBException("problem in Delete"+ce);
		}

		return bstate;		
	}




public HashMap getNames(HashMap hshRequestValues) 
	{
		
		String strQuery="";
		ResultSet rs = null;
		HashMap hshRecord = null;
		hshRecord = new HashMap();
		ArrayList arr = new ArrayList();
		ArrayList arr1 = new ArrayList();
		ArrayList arr2 = new ArrayList();
		ArrayList arr3 = new ArrayList();
		String appno1 =  Helper.correctNull((String)hshRequestValues.get("appno1"));
		String prinid =  Helper.correctNull((String)hshRequestValues.get("prinid"));		
		
		try
		{
			
			if((prinid=="")||(prinid==null))
			strQuery = SQLParser.getSqlQuery("selnames^"+appno1);
			else
			strQuery = SQLParser.getSqlQuery("selnamestype^"+appno1+"^"+prinid);
			rs = DBUtils.executeQuery(strQuery);
						
			while(rs.next())
					{
						arr.add(Helper.correctNull(rs.getString("ssi_prinfname")));
						arr1.add(Helper.correctNull(rs.getString("ssi_prinlname")));
						arr2.add(Helper.correctNull(rs.getString("ssi_prinmname")));
						arr3.add(Helper.correctNull(rs.getString("ssi_prinid")));
												
					}
					hshRecord.put("arrFNames",arr);
					hshRecord.put("arrLNames",arr1);
					hshRecord.put("arrMNames",arr2);
					hshRecord.put("arrPrinid",arr3);
					
					hshRecord.put("comapp_id",correctNull((String)hshRequestValues.get("comapp_id")));
					hshRecord.put("hidPageType",correctNull((String)hshRequestValues.get("hidPageType")));
					hshRecord.put("hidCategoryType",correctNull((String)hshRequestValues.get("hidCategoryType")));
					hshRecord.put("hidSSIType",correctNull((String)hshRequestValues.get("hidSSIType")));

					
		}
		catch(Exception e)
		{
			
			throw new EJBException(e.getMessage());
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

public HashMap getCorresRec(HashMap hshRequestValues) 
	{
				
				String strQuery="";
				String strQuery1="";
				String prinname = "";	
				String strcom_appid = "";	
				ResultSet rs = null;
				HashMap hshRecord = null;	
				hshRecord = new HashMap();
				String prinfullname =  Helper.correctNull((String)hshRequestValues.get("prinfullname"));
				String prinfname=prinfullname;
				appno =  Helper.correctNull((String)hshRequestValues.get("appno"));
				hidVal =  Helper.correctNull((String)hshRequestValues.get("hidVal"));						
				prinname = Helper.correctNull((String)hshRequestValues.get("prinname"));
				hshRecord.put("prinfullname",prinfullname);

			try
			{
			
				
				     strcom_appid = correctNull((String)hshRequestValues.get("hidBorrowerType"));
					
					rs=DBUtils.executeLAPSQuery("comappmasterexistsel^"+strcom_appid);
					if(rs.next())
					{
						hshRecord.put("comapp_totalshares",correctNull(rs.getString("comapp_totalshares")));
					}
					
					strQuery = SQLParser.getSqlQuery("selssicrorepromotershare^"+appno);				
					rs = DBUtils.executeQuery(strQuery);
					//int Count=0;
					if (rs.next())
					{
						hshRecord.put("totalsharevalue",correctNull(rs.getString("totalsharevalue")));
					}	
				
				
				
			strQuery1 = SQLParser.getSqlQuery("selcoresp1^"+prinfullname+"^"+appno);	
			rs = DBUtils.executeQuery(strQuery1);
			if(rs.next())
			{
				prinfullname=Helper.correctNull(rs.getString("prinfullname"));
			}
			
			rs=null;
			strQuery = SQLParser.getSqlQuery("selcoresp^"+prinfname+"^"+appno);	
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
					{
								prinname=Helper.correctNull(rs.getString("ssi_prinid"));
								printype=Helper.correctNull(rs.getString("ssi_printype"));
								prinfname=Helper.correctNull(rs.getString("ssi_prinfname"));
								prinlname=Helper.correctNull(rs.getString("ssi_prinlname"));
								prinmname=Helper.correctNull(rs.getString("ssi_prinmname"));
				
								prinfhname=Helper.correctNull(rs.getString("ssi_prinfathername"));
								prinage=Helper.correctNull(rs.getString("ssi_prinage"));
								prinsex=Helper.correctNull(rs.getString("ssi_prinsex"));
								princaste=Helper.correctNull(rs.getString("ssi_princategory"));
								prinexser=Helper.correctNull(rs.getString("ssi_prinexservice"));
								prinracno=Helper.correctNull(rs.getString("ssi_prinrationno"));
								prinoff=Helper.correctNull(rs.getString("ssi_prinofficeadd"));
								prinres=Helper.correctNull(rs.getString("ssi_prinbusinessadd"));
								prinqualif=Helper.correctNull(rs.getString("ssi_prinqualification"));	
								ssi_prinpassportno=Helper.correctNull(rs.getString("ssi_prinpassportno"));
								shareper=Helper.correctNull(rs.getString("ssi_shareper"));
								faceval=Helper.correctNull(rs.getString("ssi_facevalue"));
								shareheld=Helper.correctNull(rs.getString("ssi_shareheld"));
								share_type=Helper.correctNull(rs.getString("ssi_sharetype"));
								ssi_officetelno=Helper.correctNull(rs.getString("ssi_offtelno"));
								ssi_residencetelno=Helper.correctNull(rs.getString("ssi_restelno"));
												}
					hshRecord.put("printype",printype);
					hshRecord.put("prinfname",prinfname);
					hshRecord.put("prinlname",prinlname);
					hshRecord.put("prinmname",prinmname);
					hshRecord.put("prinfullname",prinfullname);

					hshRecord.put("prinfhname",prinfhname);
					hshRecord.put("prinage",prinage);
					hshRecord.put("prinsex",prinsex);
					hshRecord.put("princaste",princaste);
					hshRecord.put("prinexser",prinexser);
					hshRecord.put("prinracno",prinracno);
					hshRecord.put("prinoff",prinoff);
					hshRecord.put("prinres",prinres);
					hshRecord.put("ssi_officetelno",ssi_officetelno);
					hshRecord.put("ssi_residencetelno",ssi_residencetelno);
					hshRecord.put("prinqualif",prinqualif);
					hshRecord.put("ssi_prinpassportno",ssi_prinpassportno);
					hshRecord.put("shareper",shareper);
					hshRecord.put("faceval",faceval);
					hshRecord.put("shareheld",shareheld);
					hshRecord.put("share_type",share_type);

					hshRecord.put("hidVal",hidVal);
					hshRecord.put("prinname",prinname);


					hshRecord.put("comapp_id",correctNull((String)hshRequestValues.get("comapp_id")));
					hshRecord.put("hidPageType",correctNull((String)hshRequestValues.get("hidPageType")));
					hshRecord.put("hidCategoryType",correctNull((String)hshRequestValues.get("hidCategoryType")));
					hshRecord.put("hidSSIType",correctNull((String)hshRequestValues.get("hidSSIType")));

		}
		
		catch(Exception e)
		{
				throw new EJBException(e.getMessage());
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

public HashMap getOpsdemograph(HashMap hshRequestValues) 
{
			String strQuery="";
			//String strQuery1="";
			//String strcom_appid = "";
			//String demoid="";
			ResultSet rs = null;
			HashMap hshRecord = null;	
			String recordflag="N";
			hshRecord = new HashMap();
			String prinfullname =  Helper.correctNull((String)hshRequestValues.get("prinfullname"));
			if(prinfullname.equalsIgnoreCase("new"))
			{
				prinfullname =  Helper.correctNull((String)hshRequestValues.get("demoid"));
			}
			//String prinfname=prinfullname;
			appno =  Helper.correctNull((String)hshRequestValues.get("appno"));
			hidVal =  Helper.correctNull((String)hshRequestValues.get("hidVal"));
			hshRecord.put("prinfullname",prinfullname);
			hshRecord.put("hidVal",hidVal);

		try
		{
			rs=null;
			if(!prinfullname.equalsIgnoreCase("")){
			strQuery = SQLParser.getSqlQuery("opsdemosel^"+appno+"^"+prinfullname);	
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
				{
					String strdemoapptype=Helper.correctNull(rs.getString("demo_apptype"));
				    hshRecord.put("strdemoapptype",strdemoapptype);
				    String perapp_fname=Helper.correctNull(rs.getString("perapp_fname"));
				    hshRecord.put("perapp_fname",perapp_fname);
					hshRecord.put("hidVal",hidVal);
					//hshRecord.put("comapp_id",correctNull((String)hshRequestValues.get("comapp_id")));
			  	    hshRecord.put("hidPageType",correctNull((String)hshRequestValues.get("hidPageType")));
				    hshRecord.put("hidCategoryType",correctNull((String)hshRequestValues.get("cattype")));
				    hshRecord.put("hidSSIType",correctNull((String)hshRequestValues.get("hidSSIType")));
				    recordflag="Y";
				    hshRecord.put("recordflag",recordflag);
	              }
			rs=null;
			rs=DBUtils.executeLAPSQuery("mastgetdemographics^"+prinfullname);				 
			if(rs.next())
			{
				hshRecord.put("perapp_din",correctNull(rs.getString("perapp_din")));
			}
			}
		}
	
	catch(Exception e)
	{
			throw new EJBException(e.getMessage());
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

}

					
