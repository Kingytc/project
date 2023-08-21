package com.sai.laps.ejb.facilitiesdoc;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
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
import com.sai.laps.helper.SQLParser;

@Stateless(name = "FacilitiesDocBean", mappedName = "FacilitiesDocHome")
@Remote (FacilitiesDocRemote.class)
public class FacilitiesDocBean extends BeanAdapter
{

	static Logger log=Logger.getLogger(FacilitiesDocBean.class);
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public HashMap getFacilityHead(HashMap hshRequestValues) 
	{			
		ResultSet rs = null;
		ArrayList vecVal = new ArrayList();
		ArrayList vecRec=null;
		HashMap hshRecord = new HashMap();
		String strQuery="";
		try
		{	
			
			hshRecord = new HashMap();
			strQuery = SQLParser.getSqlQuery("selfacilityhead");
			
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{   vecRec = new ArrayList();
				for (int i=0;i<2;i++ )
				{ vecRec.add(rs.getString(i+1));
				  
				}
				vecVal.add(vecRec);
				
			}
			hshRecord.put("vecVal",vecVal);
			
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


	public HashMap getFacility(HashMap hshRequestValues) 
	{		
		ResultSet rs = null;
		ArrayList vecVal = new ArrayList();
		ArrayList vecRec=null;
		boolean bstate = false;
		HashMap hshRecord = new HashMap();
		String strQuery="";
		String strFacHeadId="";
		try
		{	
			
			hshRecord = new HashMap();
			strFacHeadId=(String)hshRequestValues.get("hiddesc");			
			strQuery = SQLParser.getSqlQuery("selfacility^'"+strFacHeadId+"'");			
			
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{   vecRec = new ArrayList();
				for (int i=0;i<3;i++ )
				{ vecRec.add(rs.getString(i+1));
				  
				}
				vecVal.add(vecRec);				
			}
			hshRecord.put("vecVal",vecVal);
			
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
	public HashMap getDocData(HashMap hshRequestValues) 
	{		
		ResultSet rs=null;
		String strHeadCode=null;
		String strMastCode=null;
		String strQuery=null;
		String strConstitution="",constitution="",strGeneral="";
		HashMap hshRecord=new HashMap();
		ArrayList arrCode=new ArrayList();
		ArrayList arrDesc=new ArrayList();
		ArrayList arrConst=new ArrayList();
		
		try
		{
			
			strHeadCode=correctNull((String)hshRequestValues.get("selfacilityhead"));
			strMastCode=correctNull((String)hshRequestValues.get("selfacility"));
			
			if(strHeadCode.equals(""))
			strHeadCode="0";
			
			if(strMastCode.equals(""))
			strMastCode="0";
			
			strConstitution=correctNull((String)hshRequestValues.get("constitution"));

			strGeneral=correctNull((String)hshRequestValues.get("general"));
			if((strConstitution.equals(""))||(strConstitution.equals("Select")))
			strConstitution=strGeneral;

			strQuery=SQLParser.getSqlQuery("seldocfacility^"+strHeadCode+"^"+strMastCode+"^A"+"^"+strConstitution);
			
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				String strCode=rs.getString("fac_doccode");
				String strDesc=rs.getString("doc_desc");
				constitution=correctNull(rs.getString("fac_constitution"));
				arrCode.add(strCode);
				arrDesc.add(strDesc);
				arrConst.add(constitution);

			}
			hshRecord.put("appdoccode",arrCode);
			hshRecord.put("appdocdesc",arrDesc);
			hshRecord.put("appconst",arrConst);
			rs.close();

			arrCode=new ArrayList();
			arrDesc=new ArrayList();
			arrConst=new ArrayList();
			strQuery=SQLParser.getSqlQuery("seldocfacility^"+strHeadCode+"^"+strMastCode+"^I"+"^"+strConstitution);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				String strCode=rs.getString("fac_doccode");
				String strDesc=rs.getString("doc_desc");
				constitution=correctNull(rs.getString("fac_constitution"));
				arrCode.add(strCode);
				arrDesc.add(strDesc);
				arrConst.add(constitution);
			}
			hshRecord.put("intdoccode",arrCode);
			hshRecord.put("intdocdesc",arrDesc);
			hshRecord.put("intconst",arrConst);

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
			catch(Exception e1)
			{
				log.error("Error closing connections.. "+e1);
			}
		}
		return hshRecord;
	}

	public void updateDocData(HashMap hshRequestValues) 
	{
		String strQuery="";
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		String strHeadCode=null;
		String strMastCode=null;
		String strConstitution="",strGeneral="";
		int intSize=1;
		String[] strDocCode=null;
		String[] strDocDesc=null;
		String strLoanType="";
		try
		{
			strLoanType=correctNull((String)hshRequestValues.get("prdtype"));
			String strCode="";
			StringBuilder sbAt = new StringBuilder();
			String strDocMode=correctNull((String)hshRequestValues.get("doc_mode"));
			if(strDocMode.equals("G"))
			sbAt.append(" ~DocumentType=").append("General Documents");
			else 
				sbAt.append(" ~DocumentType=").append("Facility Based Documents");
			    
			
			
			
			strDocCode=(String[])hshRequestValues.get("adoc_code");
			strDocDesc=(String[])hshRequestValues.get("adoc_desc");

			strConstitution=correctNull((String)hshRequestValues.get("constitution"));
			strGeneral=correctNull((String)hshRequestValues.get("general"));
			if((strConstitution.equals(""))||(strConstitution.equals("Select")))
			strConstitution=strGeneral;

			strHeadCode=correctNull((String)hshRequestValues.get("selfacilityhead"));
			if(strHeadCode.equals(""))
			strHeadCode="0";

			strMastCode=correctNull((String)hshRequestValues.get("selfacility"));
			if(strMastCode.equals(""))
			strMastCode="0";
			

			if(!strDocMode.equals("G")){
				
				sbAt.append(" ~Facility Head=").append(correctNull((String)hshRequestValues.get("hid_selfacilityhead")));
				sbAt.append(" ~Constitution=").append((String)hshRequestValues.get("hid_constitution"));
				sbAt.append(" ~Facility").append(correctNull((String)hshRequestValues.get("hid_selfacility")));
				
			}
			
			
			hshQueryValues.put("size","1");
			hshQuery.put("strQueryId","deldocfacility");
			arrValues.add(strHeadCode);
			arrValues.add(strMastCode);
			arrValues.add(strConstitution);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			intSize++;
			sbAt.append(" ~ Document Category - Applicant=");
			for(int i=0;i<strDocDesc.length;i++)
			{
				if(!strDocDesc[i].equals(""))
				{
					hshQueryValues.put("size",String.valueOf(intSize));
					hshQuery=new HashMap();
					hshQuery.put("strQueryId","insdocfacility");
					arrValues=new ArrayList();
					arrValues.add(strHeadCode);
					arrValues.add(strMastCode);
					arrValues.add(strDocCode[i]);
					arrValues.add("A");
					arrValues.add(strConstitution);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(String.valueOf(intSize),hshQuery);
					intSize++;
					sbAt.append("-").append(strDocDesc[i]);
				}
			}
			strDocCode=(String[])hshRequestValues.get("idoc_code");
			strDocDesc=(String[])hshRequestValues.get("idoc_desc");
			sbAt.append(" ~Document Category - Internal=");
			for(int i=0;i<strDocDesc.length;i++)
			{
				if(!strDocDesc[i].equals(""))
				{
					hshQueryValues.put("size",String.valueOf(intSize));
					hshQuery=new HashMap();
					hshQuery.put("strQueryId","insdocfacility");
					arrValues=new ArrayList();
					arrValues.add(strHeadCode);
					arrValues.add(strMastCode);
					arrValues.add(strDocCode[i]);
					arrValues.add("I");
					arrValues.add(strConstitution);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(String.valueOf(intSize),hshQuery);
					intSize++;
					sbAt.append("~").append(strDocDesc[i]);
				}
				
			}
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			hshRequestValues.put("hidAction","update");
			 if(strLoanType.equalsIgnoreCase("T"))
			   	strCode="117";
			 else
		    	strCode="107";
			AuditTrial.auditLog(hshRequestValues,strCode,"",sbAt.toString());
			
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
		}
	}			
}