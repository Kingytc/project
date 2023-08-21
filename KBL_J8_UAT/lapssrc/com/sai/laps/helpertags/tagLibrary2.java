package com.sai.laps.helpertags;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.ArrayList;

import javax.ejb.EJBException;

import org.apache.log4j.Logger;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

public class tagLibrary2 extends BeanAdapter {
	
	static Logger log=Logger.getLogger(tagLibrary2.class);
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public HashMap getWorkflowData(HashMap hshValues) 
	{
		HashMap hshRecord = new HashMap();
		String strMethod ="";

		try
		{
			strMethod=(String)hshValues.get("hidMethod");
			if (strMethod.equalsIgnoreCase("getWork"))
			{
				hshRecord =(HashMap)getWork(hshValues);
			}
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getdata "+ce.toString());
		}		
		return hshRecord;
	}
	
	private HashMap getWork(HashMap hshValues) 
	{
		
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecCatid = new ArrayList();
		ArrayList vecCatName = new ArrayList();
		String strValue = "";
		try
		{
			
			strValue = (String)hshValues.get("select");
			rs=DBUtils.executeLAPSQuery("sel_workflow^"+strValue);	
			
			//rs = stmt.executeQuery(strQuery);			
			while(rs.next())
			{
				String catid =correctNull(rs.getString("wrk_flowid"));
				String catpa =correctNull(rs.getString("wrk_flowtype"));
				catpa= catid+"-"+catpa;
				vecCatid.add(catpa);
				vecCatName.add(correctNull(rs.getString("wrk_flowname")));	
			}			
			hshRecord.put("vecCodes",vecCatid);
			hshRecord.put("vecValues",vecCatName);		
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in help "+ce.toString());
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
		return hshRecord;
	}
	
	public HashMap getProductsData(HashMap hshValues) 
	{
		HashMap hshRecord = new HashMap();
		String strMethod ="";

		try
		{
			strMethod=(String)hshValues.get("hidMethod");

			if (strMethod.equalsIgnoreCase("getProd"))
			{
				hshRecord =(HashMap)getProd(hshValues);
			}
			
		
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getdata "+ce.toString());
		}
		
		return hshRecord;

	}
	
	private HashMap getProd(HashMap hshValues) 
	{
		 
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecCatid = new ArrayList();
		ArrayList vecCatName = new ArrayList();
		String strValue = "";
		String strParent = "1";

		try
		{
			 
			strValue = (String)hshValues.get("value");
			strParent = (String)hshValues.get("parent");

			if (strValue.equalsIgnoreCase("parent"))
			{
				 rs=DBUtils.executeLAPSQuery("selparentproduct");
			}
			else if (strValue.equalsIgnoreCase("sub"))
			{
				 rs=DBUtils.executeLAPSQuery("selallproduct");
			}
			else if (strValue.equalsIgnoreCase("subsel"))
			{
				 rs=DBUtils.executeLAPSQuery("selsubproduct^"+Integer.parseInt(strParent));
			}

			
			while(rs.next())
			{
				String catid =correctNull(rs.getString("cat_id"));
				String catpa =correctNull(rs.getString("cat_parent"));
				catpa= catid+"-"+catpa;
				vecCatid.add(catpa);
				vecCatName.add(correctNull(rs.getString("cat_name")));
	
			}
			
			hshRecord.put("vecCodes",vecCatid);
			hshRecord.put("vecValues",vecCatName);
		
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in help "+ce.toString());
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
	public HashMap getWorkflowList(HashMap hshRequestValues) 
	{
		ResultSet rs=null;
		String strWorkflowType=null;
		HashMap hshRecord=new HashMap();
		try
		{
			strWorkflowType=(String)hshRequestValues.get("wrk_flowtype");
			rs=DBUtils.executeLAPSQuery("workflowlist^"+strWorkflowType);
			while(rs.next())
			{
				hshRecord.put(rs.getString("wrk_flowid"),rs.getString("wrk_flowname"));
			}
		}
		catch(Exception e)
		{
			log.error("Exception in getWorkList.. "+e);
			throw new EJBException(e.getMessage());
		}
		finally
		{
			try
			{
				
			}
			catch(Exception e1)
			{
				log.error("Error closing connection.. "+e1);
			}
		}
		return hshRecord;
	}

	public HashMap getCatgList(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		HashMap hshRecord = null;
		String strCatId=null;
		try
		{
		
            strCatId=(String)hshRequestValues.get("cat_id");
    		rs = DBUtils.executeLAPSQuery("categorylist^"+strCatId);
			
	
			hshRecord = new HashMap();
			while(rs.next())
			{
				String strId=rs.getString("cat_id");
				String strName=rs.getString("cat_name");
				hshRecord.put(strId,strName);
			}
			
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getCatgList "+ce.toString());
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
		return hshRecord;
	}

//	public  HashMap getTagLibData(HashMap hshValues) 
//	{
//		 
//		ResultSet rs = null;
//		HashMap hshRecord = new HashMap();
//		ArrayList vecRec=null;
//		
//		try
//		{
//			 
//			rs=DBUtils.executeLAPSQuery("selperglpopt");
//			 
//			while(rs.next())
//			{
//				vecRec = new ArrayList();
//				String strId =correctNull(rs.getString("perglp_id"));
//				vecRec.add(correctNull(rs.getString("perglp_desc")));
//				hshRecord.put(strId,vecRec);
//			}
//
//		}
//		catch(Exception ce)
//		{
//			log.error(ce.toString());
//			throw new EJBException("Error in getData "+ce.toString());
//
//		}
//		finally
//		{
//			try
//			{
//				if(rs != null)
//				{
//					rs.close();
//				}
//				 
//			}
//			catch(Exception cf)
//			{
//				throw new EJBException("Error closing the connection "+cf.getMessage());
//						
//			}
//		}
//		return hshRecord;
//	}
	
	
		public HashMap getDataHelp(HashMap hsh) 
	{
		 
		String strQuery="";
		ResultSet rs=null;
		
		HashMap hshvalues = new HashMap();
		ArrayList arr = new ArrayList();
		ArrayList arr1 = new ArrayList();
		String valsys="";
		try
			{ 
				valsys =Helper.correctNull((String)hsh.get("valsys"));
				strQuery = SQLParser.getSqlQuery("orgcodesel^"+valsys);
				 rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arr.add(correctNull(rs.getString(1)));
					arr1.add(correctNull(rs.getString(2)));
				}
				hshvalues.put("arrVal",arr);
				hshvalues.put("arrValdesc",arr1);
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
			log.error("the val is "+hshvalues);
			return hshvalues;
	}
	
		/*public HashMap getAppData(HashMap hshRequestValues)
		{
			 
			ResultSet rs = null;
			HashMap hshRecord = new HashMap();		
			String appno = Helper.correctNull((String)hshRequestValues.get("appno"));
			if(appno.equalsIgnoreCase(""))
			{
				appno = Helper.correctNull((String)hshRequestValues.get("appno1"));
			}
			if(appno.equalsIgnoreCase("") || appno.equalsIgnoreCase("null"))
			{
				appno = Helper.correctNull((String)hshRequestValues.get("strappno"));
			}
			String formtype = "";

			try
			{
				boolean bstate=false;
				 
				rs=DBUtils.executeLAPSQuery("comfunsel1^"+appno);
	 
				while(rs.next())
				{
					formtype = Helper.correctDoubleQuote(correctNull(rs.getString("app_loantype")));
					bstate=true;
				}
				if(formtype.equalsIgnoreCase("P") || formtype.equalsIgnoreCase("A"))
				{
				 
					 
					rs=DBUtils.executeLAPSQuery("comfunsel2^"+appno);

				}
				else if(formtype.equalsIgnoreCase("C"))
				{
					 
					 
					rs=DBUtils.executeLAPSQuery("comfunsel3^"+appno);

				}else if (formtype.equalsIgnoreCase("T")) {
					rs=DBUtils.executeLAPSQuery("comfunsel3^" + appno + "^N");
				}
				 if(bstate==true)
				 {
				while(rs.next())
				{
					hshRecord = new HashMap();
					hshRecord.put("app_name",Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
					hshRecord.put("app_status",Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
					hshRecord.put("applicantid",rs.getString("demo_appid"));
				}
				 }
				hshRecord.put("appno", appno);
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
			return hshRecord;
		}*/
		
		public HashMap getApplicantIDHelp(HashMap hshValues) 
		{
			String strQuery="";			
			ResultSet rs=null;
			HashMap hshResult=new HashMap();
			ArrayList arryRow=new ArrayList();
			ArrayList arryCol=null;
			String strAppid=correctNull((String)hshValues.get("appid"));
			boolean bState=false;
			try
			{ 
				if(strAppid.equals(""))
				{
					//strQuery= SQLParser.getSqlQuery("pergetappidhelp");
				       rs=DBUtils.executeLAPSQuery("pergetappidhelp");
				     
				}
				else
				{
					strQuery= SQLParser.getSqlQuery("pergetcoappidhelpNEW^"+strAppid);	
					 rs =DBUtils.executeQuery(strQuery);
				}
				
				

				 bState=rs.next();
				if(!bState)
				{
					hshResult.put("noData","noData");
				}
				else
				{
					hshResult.put("noData","Data");
				}
				while(bState)
				{
					arryCol=new ArrayList();
					arryCol.add(rs.getString(1));
					arryCol.add(rs.getString(2));
					arryRow.add(arryCol);
					bState=rs.next();
				}
				hshResult.put("arryRow",arryRow);
			}
			catch(Exception e)
			{
				throw new EJBException("Error in getApplicantIDHelp "+e.getMessage());		
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
					throw new EJBException("Error in closing Connection "+e.getMessage());
				}
			}
			return hshResult;
		}
		
		public HashMap getCoAppGuarantorType(HashMap hshRequestValues)
		{
			 
			ResultSet rs=null;
			HashMap hshRecord=new HashMap();
			String strAppno=(String)hshRequestValues.get("appno");
			String strAppType = (String)hshRequestValues.get("applnt");
			String strQuery = null;
			ArrayList arrRow = new ArrayList();
			ArrayList arrCol = null;
				
			try
			{
				strQuery=SQLParser.getSqlQuery("getcoappguarantortype^"+strAppno+"^"+strAppType);
				rs =DBUtils.executeQuery(strQuery);
	 
				while(rs.next())
				{
					arrCol = new ArrayList();
					arrCol.add(correctNull(rs.getString(1)));
					arrCol.add(correctNull(rs.getString(2)));
					arrCol.add(correctNull(rs.getString(3)));
					arrCol.add(correctNull(rs.getString(4)));
					arrRow.add(arrCol);
				}
				hshRecord.put("arrRow",arrRow);
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
					throw new EJBException(e1.getMessage());
				}
			}
			return hshRecord;
		}
		public HashMap getDocList(HashMap hshValues) 
		{
			HashMap hshRecord=new HashMap();
			
			ResultSet rs=null;
			ArrayList vecData = new ArrayList();
			ArrayList vecRec= new ArrayList();
			try
			{
				
				rs=DBUtils.executeLAPSQuery("prddoclist^"+hshValues.get("doc_type"));
				
				while(rs.next())
				{
					//added by balaji for aplha order on 29/03/2004
					vecRec = new ArrayList();
					vecRec.add(rs.getString("doc_code"));
					vecRec.add(rs.getString("doc_create_date"));
					vecRec.add(rs.getString("doc_desc"));
					vecData.add(vecRec);
					hshRecord.put("vecData",vecData);
					//first = (rs.getString("doc_code"))  + "#" +  (rs.getString("doc_create_date"));
					//hshRecord.put(first,rs.getString("doc_desc"));


//					hshRecord.put(rs.getString("doc_code"),rs.getString("doc_desc"));
//					dateNow=rs.getString("doc_create_date");
//					hshRecord.put("doc_create_date",dateNow);
				}
			}
			catch(Exception e)
			{
				log.error("Exception in getDocList.. "+e);
				throw new EJBException(e.getMessage());
			}
			finally
			{
				try
				{
					
				}
				catch(Exception e1)
				{
					log.error("Error closing connection.. "+e1);
				}
			}
			return hshRecord;
		}

		public HashMap getstaticdataData(HashMap hshValues) 
		{	
			
			ResultSet rs = null;
			HashMap hshRecord = null;
			ArrayList vecCol		= new ArrayList();
			ArrayList vecRow		= new ArrayList();	
			
			try
			{
				
				String strstatecode= correctNull((String)hshValues.get("apptype"));
				rs = DBUtils.executeLAPSQuery("selstaticdata^"+strstatecode);
				
				hshRecord = new HashMap();
				while(rs.next())
				{
					vecCol = new ArrayList();
					vecCol.add(correctNull(rs.getString(1)));
					vecCol.add(correctNull(rs.getString(2)));
					vecRow.add(vecCol);	
				}
				hshRecord.put("vecRow",vecRow);				
			}
			catch(Exception ce)
			{
				log.error(ce.toString());
				throw new EJBException("Error in getDataHoliday "+ce.toString());
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
		
		public HashMap getDataHelp1(HashMap hshParamter) 
		{
		
			String strQuery="";
			String strName="";
			String strVal="";
			ResultSet rs = null;
			HashMap hshRecord = new HashMap();
			ArrayList vecCodes = new ArrayList();
			ArrayList vecValues = new ArrayList();
			String strDynquery = (String)hshParamter.get("TagQuery");
			int intTokens =0;
			try
			{
							
				StringTokenizer strHelpTok =new StringTokenizer(strDynquery,"^");
				intTokens = strHelpTok.countTokens();
				if(intTokens == 2)
				{
					strName = strHelpTok.nextToken();
					strVal =  strHelpTok.nextToken();
				}
				else
				{
					strName ="";
					strVal  ="";
				}

				strQuery = SQLParser.getSqlQuery("setorghelp^"+strName+"^"+strVal);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					vecCodes.add(correctNull(rs.getString("org_code")));
					vecValues.add(correctNull(rs.getString("org_name")));
				}
				hshRecord.put("vecCodes",vecCodes);
				hshRecord.put("vecValues",vecValues);
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
			HashMap hshRecord = null;
			String strId="",strName="",strRights="",strDiscreteId="";
			ArrayList vecVal = new ArrayList();		
			ArrayList vecRec= new ArrayList();

			try
			{
				rs=DBUtils.executeLAPSQuery("setgroupssel");
				 
				
				hshRecord = new HashMap();

				while(rs.next())
				{
					strId=rs.getString("grp_id");
					strName=rs.getString("grp_name");
					strRights=rs.getString("grp_rights");
				    strDiscreteId=rs.getString("grp_discreteid");							

					vecRec = new ArrayList();		
					vecRec.add(strId);
					vecRec.add(strName);
					vecRec.add(strRights);						
					vecRec.add(strDiscreteId);
					vecVal.add(vecRec);
				}
				hshRecord.put("groups_data",vecVal);		
			}
			catch(Exception ce)
			{
				throw new EJBException("Error in getData "+ce.toString());
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
			return hshRecord;
		}

		public HashMap getTermData(HashMap hshRequestValues) 
		{	
			ResultSet rs = null;
			ArrayList vecRow = new ArrayList();
			ArrayList vecCol=null;
			HashMap hshRecord = new HashMap();
			try
			{	
				hshRecord = new HashMap();
				rs = DBUtils.executeLAPSQuery("setmodtermcondterm");
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

		public HashMap getData1(HashMap hshValues) 
		{
			HashMap hshRecord = new HashMap();
			String strMethod ="";

			try
			{
				strMethod=(String)hshValues.get("hidMethod");

				if (strMethod.equalsIgnoreCase("getLevels"))
				{
					hshRecord =(HashMap)getLevels(hshValues);
				}
				else if (strMethod.equalsIgnoreCase("getSubLevels"))
				{
					hshRecord =(HashMap)getSubLevels(hshValues);
				} 
				else if (strMethod.equalsIgnoreCase("getListValues"))
				{
					hshRecord =(HashMap)getListValues(hshValues);
				} 
				else if (strMethod.equalsIgnoreCase("getParamList"))
				{
					hshRecord =(HashMap)getParamList(hshValues);
				} 
				else if (strMethod.equalsIgnoreCase("showProfile"))
				{
					hshRecord =(HashMap)showProfile(hshValues);
				} 
			
			}
			catch(Exception ce)
			{
				throw new EJBException("Error in getdata "+ce.toString());
			}
			
			return hshRecord;

		}

		private HashMap getListValues(HashMap hshValues) 
		{
			 
			ResultSet rs = null;
			HashMap hshRecord = new HashMap();
			ArrayList vecBnkCode = new ArrayList();
			ArrayList vecBnkName = new ArrayList();
			String strValue = null;
			String strTemp  = null;
			
			try
			{
				 
				strValue=(String)hshValues.get("bnklevel");
				//strTemp = strValue.substring(0,1);
//	modified for  organisations taglib by thangam
				if (strValue.equalsIgnoreCase("Corporate Center") || strValue.equalsIgnoreCase("C"))
				{
					strTemp = "C";
				}
				else if (strValue.equalsIgnoreCase("Zone") || strValue.equalsIgnoreCase("R"))
				{
					strTemp = "R";
				}
				else if (strValue.equalsIgnoreCase("Region") || strValue.equalsIgnoreCase("D"))
				{
					strTemp = "D";
				}
				else if (strValue.equalsIgnoreCase("Branch") || strValue.equalsIgnoreCase("A"))
				{
					strTemp = "A";
				}


				   rs=DBUtils.executeLAPSQuery("setorgrepbanks^"+strTemp);
				 
				while(rs.next())
				{
				strTemp = rs.getString("org_level")+"-"+rs.getString("org_code");
					vecBnkCode.add(strTemp);
					vecBnkName.add(rs.getString("org_name"));
				}
				
				hshRecord.put("vecCodes",vecBnkCode);
				hshRecord.put("vecValues",vecBnkName);
				
			}
			catch(Exception ce)
			{
				throw new EJBException("Error in help "+ce.toString());
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

		private HashMap getLevels(HashMap hshPar) 
		{
			 
			ResultSet rs = null;
			HashMap hshRecord = new HashMap();
			ArrayList vecBnkCode = new ArrayList();
	 		ArrayList vecBnkName = new ArrayList();		
			String strTemp =null;

			try
			{
				 
				
				   rs=DBUtils.executeLAPSQuery("setorgreplevel");
				 
				
				while(rs.next())
				{
					strTemp = correctNull(rs.getString("glp_orgname1"));
					if (!strTemp.trim().equals(""))
					{
						//strTemp = strTemp.substring(0,1);
						strTemp = "C";
						vecBnkCode.add(strTemp);
					}
					strTemp = correctNull(rs.getString("glp_orgname2"));
					if (!strTemp.trim().equals(""))
					{
						//strTemp = strTemp.substring(0,1);
						strTemp = "R";
						vecBnkCode.add(strTemp);
					}
					strTemp = correctNull(rs.getString("glp_orgname3"));
					if (!strTemp.trim().equals(""))
					{
						//strTemp = strTemp.substring(0,1);
						strTemp = "D";
						vecBnkCode.add(strTemp);
					}
					strTemp = correctNull(rs.getString("glp_orgname4"));
					if (!strTemp.trim().equals(""))
					{
						strTemp = "A";

						vecBnkCode.add(strTemp);
					}
					strTemp = correctNull(rs.getString("glp_orgname5"));
					if (!strTemp.trim().equals(""))
					{
						strTemp = "B";
						vecBnkCode.add(strTemp);
					}
					strTemp = correctNull(rs.getString("glp_orgname1"));
					if (!strTemp.trim().equals(""))
					{
						vecBnkName.add(strTemp);
					}
					strTemp = correctNull(rs.getString("glp_orgname2"));
					if (!strTemp.trim().equals(""))
					{
						vecBnkName.add(strTemp);
					}
					strTemp = correctNull(rs.getString("glp_orgname3"));
					if (!strTemp.trim().equals(""))
					{
						vecBnkName.add(strTemp);
					}
					strTemp = correctNull(rs.getString("glp_orgname4"));
					if (!strTemp.trim().equals(""))
					{
						vecBnkName.add(strTemp);
					}
					strTemp = correctNull(rs.getString("glp_orgname5"));
					if (!strTemp.trim().equals(""))
					{
						vecBnkName.add(strTemp);
					}
				}
										
				hshRecord.put("vecCodes",vecBnkCode);
				hshRecord.put("vecValues",vecBnkName);
			}
			catch(Exception ce)
			{
				throw new EJBException("Error in help "+ce.toString());
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

		

		private HashMap getSubLevels(HashMap hshRequestValues) 
		{
			 
			ResultSet rs = null;
			ArrayList vecRecords=null;
			HashMap hshRec=null;
			ArrayList vecVal =null;
			String strQuery=null;
			String strBankCode = null;
			String strBankLevel  = null;
			String strOpFields = null;
			String strSelFields=null;
			ArrayList vecT = new ArrayList();
			String strDate=null;
			String strGen=null;
				
			try
			{
				 
				
				strDate =(String)hshRequestValues.get("txtDate");
				strGen =(String)hshRequestValues.get("strUserId");
				strSelFields =(String)hshRequestValues.get("hidSelFields");
				strOpFields =(String)hshRequestValues.get("hidOpFields");
							
				   rs=DBUtils.executeLAPSQuery("selusername^"+strGen);
				 
				while (rs.next())
				{
					strGen =correctNull(rs.getString(1))+" "+correctNull(rs.getString(2));//+" "+correctNull(rs.getString(3));
				}
				StringTokenizer st = new StringTokenizer(strOpFields,",");
				while (st.hasMoreTokens())
				{
					vecT.add(st.nextToken());
				}
				strBankLevel =(String)hshRequestValues.get("bnklevel");
				strBankCode = (String)hshRequestValues.get("hidOrgCode");
				if (strBankLevel.equalsIgnoreCase("C"))
				{
					strBankCode = strBankCode.substring(0,3);
				}
				else if (strBankLevel.equalsIgnoreCase("R"))
				{
					strBankCode = strBankCode.substring(0,6);
				}
				else if (strBankLevel.equalsIgnoreCase("D"))
				{
					strBankCode = strBankCode.substring(0,9);
				}
				else if (strBankLevel.equalsIgnoreCase("A"))
				{
					strBankCode = strBankCode.substring(0,12);
				}
				else if (strBankLevel.equalsIgnoreCase("B"))
				{
					strBankCode = strBankCode.substring(0,15);
				}

				strQuery = SQLParser.getSqlQuery("setorgrep^"+strOpFields+"^"+strBankCode);
				rs =DBUtils.executeQuery(strQuery);

				hshRec = new HashMap();
				vecVal = new ArrayList();
				while (rs.next())
				{
					vecRecords = new ArrayList();
					vecRecords.add(correctNull(rs.getString("org_level")));
					if (vecT.contains("org_name"))
					{
					vecRecords.add(correctNull(rs.getString("org_name")));
					}
					if (vecT.contains("org_add1"))
					{
					vecRecords.add(correctNull(rs.getString("org_add1")));
					}
					if (vecT.contains("org_add2"))
					{
					vecRecords.add(correctNull(rs.getString("org_add2")));
					}
					if (vecT.contains("org_city"))
					{
					vecRecords.add(correctNull(rs.getString("org_city")));
					}
					if (vecT.contains("org_state"))
					{
					vecRecords.add(correctNull(rs.getString("org_state")));
					}
					if (vecT.contains("org_zip"))
					{
					vecRecords.add(correctNull(rs.getString("org_zip")));
					}
					if (vecT.contains("org_phone"))
					{
					vecRecords.add(correctNull(rs.getString("org_phone")));
					}
					if (vecT.contains("org_fax"))
					{
					vecRecords.add(correctNull(rs.getString("org_fax")));
					}
					if (vecT.contains("org_url"))
					{
					vecRecords.add(correctNull(rs.getString("org_url")));
					}

					vecVal.add(vecRecords);
				}
				hshRec.put("vecValues",vecVal);
				hshRec.put("labels",strSelFields);
				hshRec.put("txtDate",strDate);
				hshRec.put("genby",strGen);
			}
			catch(Exception e)
			{
				throw new EJBException("inside getdata"+e.toString());
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
					throw new EJBException("close"+e.toString()); 
				}
			}
			return hshRec;
		}

		private HashMap getParamList(HashMap hshPar) 
		{
			HashMap hshRecord = new HashMap();
			HashMap hshTemp = new HashMap();
			String strTemp=null;
			String strParam = null;
			String strBankCode = null;
			String strBankLevel  = null;
			String hidOpFields = null;
			String hidSelFields = null;
			String strDate =null;
			String strGen =null;

			try
			{
							
				hshTemp=(HashMap)EJBInvoker.executeStateLess("repData",hshPar,"getParameter");
				strGen =(String)hshTemp.get("genby");
				strDate =(String)hshTemp.get("txtDate");
				strParam =(String)hshTemp.get("param");
				StringTokenizer st = new StringTokenizer(strParam,";");
				
				strTemp = st.nextToken();
				strBankLevel =strTemp.substring(0,1);
				strBankCode = strTemp.substring(strTemp.indexOf("-")+1,strTemp.length());

				strTemp = st.nextToken();
				hidOpFields = strTemp;

				strTemp = st.nextToken();
				hidSelFields =strTemp;
				
				hshRecord.put("bnklevel",strBankLevel);
				hshRecord.put("hidOrgCode",strBankCode);
				hshRecord.put("hidSelFields",hidSelFields);
				hshRecord.put("hidOpFields",hidOpFields);
				hshRecord.put("txtDate",strDate);
				hshRecord.put("strUserId",strGen);
				
				hshPar = new HashMap();
				hshPar =(HashMap)getSubLevels(hshRecord);
			}
			catch(Exception ce)
			{
				throw new EJBException("Error in help "+ce.toString());
			}
			
			return hshPar;
		}

		
		private HashMap showProfile(HashMap hshPar) 
		{
			 
			ResultSet rs = null;
			HashMap hshRecord = new HashMap();
			HashMap hshTemp = new HashMap();
			ArrayList vecLabel = new ArrayList();
			ArrayList vecValue = new ArrayList();
			String strTemp=null;
			String strParam = null;
			String strBankCode = null;
			String strBankLevel  = null;
			String hidSelFields = null;
			String strProfileName = null;

			try
			{
				 			
				//hshTemp = (HashMap)Helper.getParameter(hshPar);
				hshTemp=(HashMap)EJBInvoker.executeStateLess("repData",hshPar,"getParameter");
				strParam = (String)hshTemp.get("param");
				strProfileName =(String)hshTemp.get("profilename");
				StringTokenizer st = new StringTokenizer(strParam,";");
				
				strTemp = st.nextToken();
				strBankLevel =strTemp.substring(0,1);
				strBankCode = strTemp.substring(strTemp.indexOf("-")+1,strTemp.length());

				strTemp = st.nextToken();
				

				strTemp = st.nextToken();
				hidSelFields =strTemp;

				vecLabel.add("Profile Name");
				vecLabel.add("Organisation Level");
				vecLabel.add("Organisation Name");
				vecLabel.add("Output Fields");

				if (strBankLevel.equalsIgnoreCase("C"))
				{
					strBankLevel = "Corporate";
				}
				else if (strBankLevel.equalsIgnoreCase("R"))
				{
					strBankLevel = "Region";
				}
				else if (strBankLevel.equalsIgnoreCase("D"))
				{
					strBankLevel = "District";
				}
				else if (strBankLevel.equalsIgnoreCase("A"))
				{
					strBankLevel = "Area";
				}
				else if (strBankLevel.equalsIgnoreCase("B"))
				{
					strBankLevel = "Branch";
				}
				
				   rs=DBUtils.executeLAPSQuery("repbankname^"+strBankCode);
				 
				
				while(rs.next())
				{
					strBankCode = correctNull(rs.getString("org_name"));			
				}
				
				vecValue.add(strProfileName);
				vecValue.add(strBankLevel);
				vecValue.add(strBankCode);
				vecValue.add(hidSelFields);
				
				hshRecord.put("vecLabel",vecLabel);
				hshRecord.put("vecValue",vecValue);
				
			}
			catch(Exception ce)
			{
				throw new EJBException("Error in help "+ce.toString());
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
		public HashMap getCoAppGuarantorType1(HashMap hshRequestValues)
		{
			 
			ResultSet rs=null;
			//ResultSet rs1=null;
			HashMap hshRecord=new HashMap();
			String strAppno=(String)hshRequestValues.get("appno");
			String strAppType = (String)hshRequestValues.get("applnt");
			//String strAppId = (String)hshRequestValues.get("bowid");
			String strQuery = null;
			ArrayList arrRow = new ArrayList();
			ArrayList arrCol = null;
		//	ArrayList arrRow1 = new ArrayList();
		//	ArrayList arrCol1 = null;
		//	String count1="";
				
			try
			{
				strQuery=SQLParser.getSqlQuery("getcoappguarantortype^"+strAppno+"^"+strAppType);
				rs =DBUtils.executeQuery(strQuery);
	 
				while(rs.next())
				{
					arrCol = new ArrayList();
					arrCol.add(correctNull(rs.getString(1)));
					arrCol.add(correctNull(rs.getString(2)));
					arrCol.add(correctNull(rs.getString(3)));
					arrCol.add(correctNull(rs.getString(4)));
					arrRow.add(arrCol);
				}
//				strQuery=SQLParser.getSqlQuery("getjointapplicantnames^"+strAppId );
//				rs1 =DBUtils.executeQuery(strQuery);
//	           String count2="";
//				while(rs1.next())
//				{
//					arrCol1 = new ArrayList();
//					 count1 = Helper.correctNull((String)rs1.getString("part_name"));
//					 count2 = Helper.correctNull((String)rs1.getString("part_slno"));
//						
//					 arrCol1.add(count1);
//					 arrCol1.add(count2);
//					 arrRow1.add(arrCol1);
//					
//				}
				
				hshRecord.put("arrRow",arrRow);
//				hshRecord.put("arrRow1",arrRow1);
				hshRecord.put("applnt",strAppType);
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
					throw new EJBException(e1.getMessage());
				}
			}
			return hshRecord;
		}
	
		
	}
		

	


	
	 


	
 