package com.sai.laps.ejb.modsancterms;


import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.StringTokenizer;
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
import com.sai.laps.tagdatahelper.TagDataHelperMST;

@Stateless(name = "modsanctermsnBean", mappedName = "modsanctermsHome")
@Remote (modsanctermsRemote.class)
public class modsanctermsBean extends BeanAdapter
{
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(modsanctermsBean.class);
	private static final long serialVersionUID = -5055172921636107806L;
	
	public HashMap getDataFinal(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord = null;
		String strid="",strQuery="";
		ArrayList vecval =  new ArrayList();
		ArrayList vecdata =  new ArrayList();
		
		try
		{
			hshRecord = new HashMap();
			strid = correctNull((String)hshRequestValues.get("id"));
			if(strid.equalsIgnoreCase(""))
			{
				strid=Helper.correctNull((String)hshRequestValues.get("comapp_id"));
			}
			  
			String strOrgSelect=correctNull((String)hshRequestValues.get("strOrgSelect"));

			strQuery = SQLParser.getSqlQuery("commstapplist^"+strOrgSelect+"%^"+strid);
			
			rs =DBUtils.executeQuery(strQuery);	
			while(rs.next())
			{
				vecval =  new ArrayList();
				vecval.add(rs.getString("mst_appno"));
				vecval.add(rs.getString("comapp_companyname"));
				vecval.add(rs.getString("mst_status"));
				String strAppholderid=correctNull(rs.getString("mst_holdusrid"));
				if(correctNull((String)hshRequestValues.get("strUserId")).equals(strAppholderid))
				{
					vecval.add("Y");
					vecval.add(strAppholderid);
				}
				else
				{
					vecval.add("N");	
					vecval.add(strAppholderid);
				}
				vecdata.add(vecval);	
			}
			hshRecord.put("vecval",vecdata);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData login  "+ce.toString());
		}
		finally
		{
			try
			{				
				if(rs != null)
				{
					rs.close();
				}	
				if(rs1!=null)
				{
					rs1.close();
				}
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}
//	public HashMap getData(HashMap hshValues)
//	{
//		HashMap hshRecord=new HashMap();
//		ResultSet rs = null;
//		//ResultSet rs1 = null;
//		String strcustid="";
//		String strQuery="";
//		String strstatus="";
//		String strAppno="";
//		ArrayList vecval =  new ArrayList();
//		ArrayList vecdata =  new ArrayList();
//		String hidPageType="";
//		String token="";
//		StringBuffer strcomappidList=null;
//		try
//		{
//			hshRecord = new HashMap();
//			
//			strcustid=correctNull((String)hshValues.get("id"));
//			if(strcustid.equalsIgnoreCase(""))
//			{
//				strcustid=Helper.correctNull((String)hshValues.get("comid"));
//			}
//			strAppno= correctNull((String)hshValues.get("appno"));
//			       
//			if(strAppno.equals(""))
//			{
//				String strOrgShortCode = Helper.correctNull((String)hshValues.get("strOrgShortCode"));
//				strcomappidList=new StringBuffer();
//				if(Helper.correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("A"))
//				{
//					strQuery = SQLParser.getSqlQuery("UniqComappidListBranch^"+strOrgShortCode+"^"+strcustid);
//				}
//				else
//				{
//					strQuery = SQLParser.getSqlQuery("UniqComappidListOthers^"+strcustid);
//				}
//				rs =DBUtils.executeQuery(strQuery);
//					
//				int j = 0;
//				strcomappidList.append("(");
//				while(rs.next())
//				{
//					if(j!=0)
//					{
//						strcomappidList.append(",");
//					}
//					strcomappidList.append(Helper.correctNull((String)rs.getString("comapp_id")));
//					j++;
//				}
//				strcomappidList.append(")");
//				strQuery = SQLParser.getSqlQuery("appgeneration^"+strcomappidList.toString());
//			}
//			else if(hidPageType.trim().equals("NEW"))
//			{
//				strQuery = SQLParser.getSqlQuery("appgeneration^"+strcustid);
//			}
//			
//						
//			rs =DBUtils.executeQuery(strQuery);			
//			while(rs.next())
//			{
//				vecval =  new ArrayList();
//				vecval.add(rs.getString(1));
//				token=rs.getString(1);
//				
//				
//				String strchk = correctNull((String)rs.getString("mailchkstatus"));	
//				
//				String strAppholderid=correctNull(rs.getString("app_applnholder"));
//				String strAppholdername=correctNull(rs.getString("appholdername"));
//				
//				if(correctNull((String)hshValues.get("strGroupRights")).charAt(18)=='w')
//				{
//					if(!strAppholderid.equals(""))
//					{
//						if(correctNull((String)hshValues.get("strUserId")).equals(strAppholderid))
//						{
//							vecval.add("Y");
//							vecval.add(strAppholdername);
//						}
//						else
//						{
//							vecval.add("N");	
//							vecval.add(strAppholdername);
//						}
//					}
//					else if(strchk.trim().equalsIgnoreCase("Y"))
//					{
//						String authUserId ="", usr_fname="",usr_lname="";
//						strQuery= SQLParser.getSqlQuery("selmailbxchkstatus^"+token+"^"+token);
//						//rs1=DBUtils.executeQuery(strQuery);
//						//if(rs1.next())
//						{
//							//authUserId = Helper.correctNull((String)rs1.getString("mail_tousrid"));
//							//usr_fname = Helper.correctNull((String)rs1.getString("usr_fname"));
//							//usr_lname = Helper.correctNull((String)rs1.getString("usr_lname"));
//						}
//						if(correctNull((String)hshValues.get("strUserId")).equals(authUserId))
//						{
//							vecval.add("Y");
//							vecval.add(usr_fname+" "+usr_lname);	
//						}
//						else{
//							vecval.add("N");	
//							vecval.add(usr_fname+" "+usr_lname);	
//						}
//					}
//					else
//					{
//						vecval.add("Y");	
//						vecval.add(correctNull((String)hshValues.get("strUserId")));
//					}
//				}
//				else
//				{
//					vecval.add("Y");	
//					vecval.add(correctNull((String)hshValues.get("strUserId")));
//				}
//				vecval.add(correctNull((String)rs.getString("app_orglevel")));
//				vecdata.add(vecval);	
//			}
//			hshRecord.put("vecval",vecdata);
//		}catch(Exception ex)
//		{
//			throw new EJBException("Error in getData of ModSancterms :: "+ ex.toString());
//		}finally
//		{
//			try
//			{
//				
//			}catch (Exception e) {
//				throw new EJBException("Error in Closing the connection :: "+e.toString());
//			}
//		}
//		
//		return hshRecord;
//	}
	
	
	public void updateModsoughtData(HashMap hshValues)
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		
		String strAppno="";
		String strAction="";
		String strSecno="";
		String strQuery="";
		
		ResultSet rs=null;
		
		int intUpdatesize=0;
		try
		{
			strAction=correctNull((String)hshValues.get("hidAction"));
			strAppno=correctNull((String)hshValues.get("appno"));
			strSecno=correctNull((String)hshValues.get("hidsno"));
			
			if(strAction.equals("insert"))
			{
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				intUpdatesize++;
				
				strQuery=SQLParser.getSqlQuery("selmax_otrsancterms^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strSecno=rs.getString("snomax");
				}
				
				arrValues.add(strAppno);
				arrValues.add(strSecno);
				arrValues.add(correctNull((String)hshValues.get("txt_existing")));
				arrValues.add(correctNull((String)hshValues.get("txt_modification")));
				arrValues.add(correctNull((String)hshValues.get("txt_justification")));
				hshQuery.put("strQueryId","ins_otrsancterms");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
			}
			else if(strAction.equals("update"))
			{
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				intUpdatesize++;
				
				arrValues.add(correctNull((String)hshValues.get("txt_existing")));
				arrValues.add(correctNull((String)hshValues.get("txt_modification")));
				arrValues.add(correctNull((String)hshValues.get("txt_justification")));
				arrValues.add(strAppno);
				arrValues.add(strSecno);
				hshQuery.put("strQueryId","upd_otrsancterms");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
			}
			else if(strAction.equals("delete"))
			{
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				intUpdatesize++;
				
				arrValues.add(strAppno);
				arrValues.add(strSecno);
				hshQuery.put("strQueryId","del_otrsancterms");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
			}
			
			hshQueryValues.put("size",""+intUpdatesize);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		catch(Exception ex)
		{
			throw new EJBException("Error in updateModsoughtData  :: "+ex.toString());
		}
	
	}
	
	public HashMap getModsoughtData(HashMap hshValues)
	{

		HashMap hshRecord=null;
		
		ResultSet rs=null;
		
		String strAppno="";
		String strQuery="";
		
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		try
		{
			hshRecord=new HashMap();
			strAppno=correctNull((String)hshValues.get("appno"));
			strQuery=SQLParser.getSqlQuery("sel_otrsancterms^"+strAppno);
			
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(correctNull(rs.getString("otrsancterms_slrno")));//0
				arrCol.add(correctNull(rs.getString("otrsancterms_terms")));//1
				arrCol.add(correctNull(rs.getString("otrsancterms_modification")));//2
				arrCol.add(correctNull(rs.getString("otrsancterms_justification")));//3
				arrRow.add(arrCol);
			}
			hshRecord.put("arrRow",arrRow);
		}
		catch(Exception ex)
		{
			throw new EJBException("Error in updateData of getModsoughtData :: "+ex.toString());
		}
		return hshRecord;
	}
	
	
	public void updateValueofAccountData(HashMap hsh) 
	{
		HashMap hshqueryval = null;
		HashMap hshQuery = null;
		ArrayList arrValues = null;
		ResultSet rs=null;
		String val="";
		String appno="";
		try
		{
			val=(String)hsh.get("hidAction");
			appno=(String)hsh.get("appno");

			String []previous=null;	
			String []current=null;
			
			int intUpdatesize=0;
			
			if (val.equals("update"))
			{
				
				previous= (String [])hsh.get("txt_previous");
				current= (String [])hsh.get("txt_current");
				int len=previous.length;
			
				hshQuery = new HashMap();
				hshqueryval = new HashMap();
				arrValues=new ArrayList();
				
				intUpdatesize=intUpdatesize+1;
				
				hshQuery.put("strQueryId","del_valofacct");
				
				arrValues.add(appno);
				
				hshQuery.put("arrValues",arrValues);
				
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);
				
				
				for(int k=0;k<len;k++)
				{				
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize=intUpdatesize+1;
						hshQuery.put("strQueryId","ins_valofacct");
						
						arrValues.add(appno);
						arrValues.add(Integer.toString(k));
						arrValues.add(correctNull((String)previous[k]));
						arrValues.add(correctNull((String)current[k]));
						
						hshQuery.put("arrValues",arrValues);						
						hshqueryval.put("size",Integer.toString(intUpdatesize));
						hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);	
				}	
				
				
			}
			else if(val.equals("delete"))
			{
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshqueryval = new HashMap();
				
				intUpdatesize=intUpdatesize+1;
				
				hshQuery.put("strQueryId","del_valofacct");
				
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);
				
			}
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
						
		}
		catch (Exception e)
		{
			log.error("in bean"+e);
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
	
	public HashMap getValueofAccountData(HashMap hsh) 
	{
		ResultSet rs=null;
		
		HashMap hshValues = new HashMap();
		ArrayList arrVal = new ArrayList();
		ArrayList arrRec= new ArrayList();
		
		String appno="";
		
		try
		{
			appno=(String)hsh.get("appno");
			rs=DBUtils.executeLAPSQuery("sel_valofacct^"+appno);
			
			while(rs.next())
			{
				arrRec = new ArrayList();						
				arrRec.add(correctNull(rs.getString("valofacct_previous")));
				arrRec.add(correctNull(rs.getString("valofacct_current")));
				arrVal.add(arrRec);	
			}
			hshValues.put("arrVal",arrVal);
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
		return hshValues;
	}
	
	
	
	public void updateRemarksData(HashMap hshValues)
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		
		String strAppno="";
		String strAction="";
		int intUpdatesize=0;
		try
		{
			strAction=correctNull((String)hshValues.get("hidAction"));
			strAppno=correctNull((String)hshValues.get("appno"));
			
			if(strAction.equals("update"))
			{
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				intUpdatesize++;
				
				arrValues.add(strAppno);
				arrValues.add(correctNull((String)hshValues.get("sel_level")));
				
				hshQuery.put("strQueryId","del_remarks");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
				
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				intUpdatesize++;
			
				arrValues.add(strAppno);
				arrValues.add(correctNull((String)hshValues.get("sel_level")));
				arrValues.add(correctNull((String)hshValues.get("txt_recommendation")));
				//arrValues.add(correctNull((String)hshValues.get("txt_signatures")));
				//arrValues.add(correctNull((String)hshValues.get("txt_refno")));
				//arrValues.add(correctNull((String)hshValues.get("txt_date")));
				
				hshQuery.put("strQueryId","ins_remarks");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
				
				hshQuery = new HashMap();	
				intUpdatesize++;
				arrValues=new ArrayList();
				
				arrValues.add(correctNull((String)hshValues.get("txt_signatures")));
				arrValues.add(correctNull((String)hshValues.get("txt_refno")));
				arrValues.add(correctNull((String)hshValues.get("txt_date")));
				//arrValues.add(correctNull((String)hshValues.get("sel_level")));
				arrValues.add(strAppno);
				
				hshQuery.put("strQueryId","upd_remarks");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
			}
			else if(strAction.equals("delete"))
			{
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				intUpdatesize++;
				
				arrValues.add(strAppno);
				arrValues.add(correctNull((String)hshValues.get("sel_level")));
				
				hshQuery.put("strQueryId","del_remarks");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
			}
			hshQueryValues.put("size",""+intUpdatesize);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		catch(Exception ex)
		{
			throw new EJBException("Error in updateRecommedationData :: "+ex.toString());
		}
	}
	
	
	public HashMap getRemarksData(HashMap hshValues)
	{
		HashMap hshRecord=null;
		
		ResultSet rs=null;
		
		String strAppno="";
		String strQuery="";
		String strLevel="";
		
		try
		{
			hshRecord=new HashMap();
			strAppno=correctNull((String)hshValues.get("appno"));
			strLevel=correctNull((String)hshValues.get("sel_level"));
			
				strQuery=SQLParser.getSqlQuery("sel_remarks^"+strAppno+"^"+"'"+strLevel+"'");
				
				rs=DBUtils.executeQuery(strQuery);
			
				if(rs.next())
				{
					hshRecord.put("remarksappno",correctNull(rs.getString("remarks_appno")));
					hshRecord.put("remarkscomments",Helper.CLOBToString(rs.getClob("remarks_comments")));
					hshRecord.put("remarkssignatures",Helper.CLOBToString(rs.getClob("remarks_signatures")));
					hshRecord.put("remarksrefno",Helper.correctNull(rs.getString("remarks_refno")));
					hshRecord.put("remarksdate",Helper.correctNull(rs.getString("remarks_date")));
					
				}
				hshRecord.put("remarksorglevel",strLevel);
		}
		catch(Exception ex)
		{
			throw new EJBException("Error in getRecommedationData  :: "+ex.toString());
		}
		
		return hshRecord;
	}
	
	public void updateRecommendationData(HashMap hshValues)
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		
		String strAppno="";
		String strAction="";
		String strSecno="";
		String strQuery="";
		
		ResultSet rs=null;
		
		int intUpdatesize=0;
		try
		{
			strAction=correctNull((String)hshValues.get("hidAction"));
			strAppno=correctNull((String)hshValues.get("appno"));
			strSecno=correctNull((String)hshValues.get("hidsno"));
			
			if(strAction.equals("insert"))
			{
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				intUpdatesize++;
				
				strQuery=SQLParser.getSqlQuery("selmax_recommendations^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strSecno=rs.getString("snomax");
				}
				
				arrValues.add(strAppno);
				arrValues.add(strSecno);
				arrValues.add(correctNull((String)hshValues.get("sel_sanction")));
				arrValues.add(correctNull((String)hshValues.get("txt_stipulated")));
				//arrValues.add(correctNull((String)hshValues.get("txt_details")));
				arrValues.add(correctNull((String)hshValues.get("txt_ROrecmd")));
				arrValues.add(correctNull((String)hshValues.get("txt_COrecmd")));
				
				hshQuery.put("strQueryId","ins_recommendations");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
			}
			else if(strAction.equals("update"))
			{
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				intUpdatesize++;
				
				arrValues.add(correctNull((String)hshValues.get("sel_sanction")));
				arrValues.add(correctNull((String)hshValues.get("txt_stipulated")));
				//arrValues.add(correctNull((String)hshValues.get("txt_details")));
				arrValues.add(correctNull((String)hshValues.get("txt_ROrecmd")));
				arrValues.add(correctNull((String)hshValues.get("txt_COrecmd")));
				arrValues.add(strAppno);
				arrValues.add(strSecno);
				
				hshQuery.put("strQueryId","upd_recommendations");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
			}
			else if(strAction.equals("delete"))
			{
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				intUpdatesize++;
				
				arrValues.add(strAppno);
				arrValues.add(strSecno);
				
				hshQuery.put("strQueryId","del_recommendations");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
			}
			
			hshQueryValues.put("size",""+intUpdatesize);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		catch(Exception ex)
		{
			throw new EJBException("Error in updateRecommendationData  :: "+ex.toString());
		}
	
	}
	
	public HashMap getRecommendationData(HashMap hshValues)
	{

		HashMap hshRecord=null;
		
		ResultSet rs=null;
		
		String strAppno="";
		String strQuery="";
		
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		try
		{
			hshRecord=new HashMap();
			strAppno=correctNull((String)hshValues.get("appno"));
			strQuery=SQLParser.getSqlQuery("sel_recommendations^"+strAppno);
			
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(correctNull(rs.getString("recmd_sancterms")));//0
				arrCol.add(correctNull(rs.getString("recmd_srlno")));//1
				arrCol.add(correctNull(rs.getString("recmd_stipulated")));//2
				//arrCol.add(correctNull(rs.getString("recmd_details")));//3
				arrCol.add(correctNull(rs.getString("recmd_recommendRO")));//4
				arrCol.add(correctNull(rs.getString("recmd_recommendCO")));//5
				arrRow.add(arrCol);
			}
			hshRecord.put("arrRow",arrRow);
		}
		catch(Exception ex)
		{
			throw new EJBException("Error in updateData of getRecommendationData :: "+ex.toString());
		}
		return hshRecord;
	}
	
	public void updatefacilityData(HashMap hshValues)
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		
		//ResultSet rs=null;
		
		String strAction=(String)hshValues.get("hidAction");
		String strAppno="";
		int intUpdateSize=0;
		StringTokenizer stk = null;
		
		String strSno="";
		String strFactype="";
		String strFacilityhead="";
		String strFacility="";
		String strSanclimit="";
		String strOutstanding="";
		String strMargin="";
		String strOutstandingason="";
		String strCbsno="";
		String strAppint="";
		String strExistint="";
		String strPropint="";
		String strROremd="";
		String strCOremd="";
		String strConcession="";
		String strIrregularties="";
		String strZOremd="";
		
		boolean updflag=true;
		try
		{
			strSno=correctNull((String)hshValues.get("hidsno"));
			strFactype=correctNull((String)hshValues.get("hidfactype"));
			strAppno=correctNull((String)hshValues.get("appno"));
			if(strFactype.equals("sublimit"))
			{
				strFacilityhead=correctNull((String) hshValues.get("subfacility_head"));
				stk = new StringTokenizer(strFacilityhead,"-");
				if(stk.hasMoreTokens())
				{
					strFacilityhead = (String)stk.nextToken();
				}
				
				strFacility =correctNull((String) hshValues.get("subfacility"));
				stk = new StringTokenizer(strFacility,"-");
				if(stk.hasMoreTokens())
				{
					strFacility = (String)stk.nextToken();
				}
				strSanclimit=Helper.correctDouble((String)hshValues.get("txt_subsanclimit"));
				strOutstanding=Helper.correctDouble((String)hshValues.get("txt_suboutstanding"));
				strMargin=correctNull((String)hshValues.get("txt_submargin"));
				strOutstandingason=correctNull((String)hshValues.get("txt_suboutstandingason"));
				strCbsno=correctNull((String)hshValues.get("txt_subcbsno"));
				strAppint=correctNull((String)hshValues.get("txt_subappint"));
				strExistint=correctNull((String)hshValues.get("txt_subexistint"));
				strPropint=correctNull((String)hshValues.get("txt_subpropint"));
				strROremd=correctNull((String)hshValues.get("txt_subROremd"));
				strCOremd=correctNull((String)hshValues.get("txt_subCOremd"));
				strConcession=correctNull((String)hshValues.get("txt_subconcession"));
				strIrregularties=correctNull((String)hshValues.get("txt_subirregularties"));
				strZOremd=correctNull((String)hshValues.get("txt_subZOremd"));
			}
			else
			{
				strFacilityhead=correctNull((String) hshValues.get("facility_head"));
				stk = new StringTokenizer(strFacilityhead,"-");
				if(stk.hasMoreTokens())
				{
					strFacilityhead = (String)stk.nextToken();
				}
				
				strFacility =correctNull((String) hshValues.get("facility"));
				stk = new StringTokenizer(strFacility,"-");
				if(stk.hasMoreTokens())
				{
					strFacility = (String)stk.nextToken();
				}
				
				strSanclimit=Helper.correctDouble((String)hshValues.get("txt_sanclimit"));
				strOutstanding=Helper.correctDouble((String)hshValues.get("txt_outstanding"));
				strMargin=correctNull((String)hshValues.get("txt_margin"));
				strOutstandingason=correctNull((String)hshValues.get("txt_outstandingason"));
				strCbsno=correctNull((String)hshValues.get("txt_cbsno"));
				strAppint=correctNull((String)hshValues.get("txt_appint"));
				strExistint=correctNull((String)hshValues.get("txt_existint"));
				strPropint=correctNull((String)hshValues.get("txt_propint"));
				strROremd=correctNull((String)hshValues.get("txt_ROremd"));
				strCOremd=correctNull((String)hshValues.get("txt_COremd"));
				strConcession=correctNull((String)hshValues.get("txt_concession"));
				strIrregularties=correctNull((String)hshValues.get("txt_irregularties"));
				strZOremd=correctNull((String)hshValues.get("txt_ZOremd"));
			}
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdateSize++;
			if(strAction.equalsIgnoreCase("update"))
			{
				hshQuery.put("strQueryId","upd_mstfacility");		
				
				arrValues.add(strFacilityhead);
				arrValues.add(strFacility);
				arrValues.add(strSanclimit);
				arrValues.add(strOutstanding);
				arrValues.add(strMargin);
				arrValues.add(strOutstandingason);
				arrValues.add(strCbsno);
				arrValues.add(strAppint);
				arrValues.add(strExistint);
				arrValues.add(strPropint);
				arrValues.add(strROremd);
				arrValues.add(strCOremd);
				arrValues.add(strConcession);
				arrValues.add(strIrregularties);
				arrValues.add(strZOremd);
				arrValues.add(strAppno);
				arrValues.add(strSno);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdateSize,hshQuery);	
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				intUpdateSize++;
				
				hshQuery.put("strQueryId","updmstfacility");
				
				arrValues.add(strOutstandingason);
				arrValues.add(strAppno);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdateSize,hshQuery);
				
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQuery.put("strQueryId","upd_mstfacility");		
				
				arrValues.add(strFacilityhead);
				arrValues.add(strFacility);
				arrValues.add(strSanclimit);
				arrValues.add(null);
				arrValues.add(null);
				arrValues.add(null);
				arrValues.add(null);
				arrValues.add(null);
				arrValues.add(null);
				arrValues.add(null);
				arrValues.add(null);
				arrValues.add(null);
				arrValues.add(null);
				arrValues.add(null);
				arrValues.add(null);
				arrValues.add(strAppno);
				arrValues.add(strSno);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdateSize,hshQuery);	
			}
			if(updflag)
			{
				hshQueryValues.put("size",""+intUpdateSize);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			StringBuilder sbAt = new StringBuilder();
		   // sbAt.append("All Values are in  =").append(correctNull((String)hshValues.get("sel_valuesin")));
			sbAt.append("Facility Head =").append(correctNull((String)hshValues.get("facility_head")));
			sbAt.append(" ~Facility = ").append(correctNull((String)hshValues.get("facility")));
			sbAt.append(" ~Sanctioned Limits   = ").append(correctNull((String)hshValues.get("txt_sanclimit")));
		//	sbAt.append(" ~Proposed Limit  = ").append(correctNull((String)hshValues.get("txt_outstanding")));
			sbAt.append(" ~Outstanding = ").append(correctNull((String)hshValues.get("txt_outstanding")));
			//sbAt.append(" ~Interest/Commission Proposed = ").append(correctNull((String)hshValues.get("txt_limitproposedint")));
			sbAt.append(" ~Margin(%) = ").append(correctNull((String)hshValues.get("txt_margin")));
			sbAt.append(" ~Out Standing as on = ").append(correctNull((String)hshValues.get("txt_outstandingason")));
			sbAt.append(" ~CBS Account No = ").append(correctNull((String)hshValues.get("txt_cbsno")));
			sbAt.append(" ~Applicable =").append(correctNull((String)hshValues.get("txt_appint")));
			sbAt.append(" ~Existing=").append(correctNull((String)hshValues.get("txt_existint")));
			sbAt.append(" ~Proposed by Branch = ").append(correctNull((String)hshValues.get("txt_propint")));
			sbAt.append(" ~Recommended by RO  = ").append(correctNull((String)hshValues.get("txt_ROremd")));
			sbAt.append(" ~Recommended by FGMO  = ").append(correctNull((String)hshValues.get("txt_ZOremd")));
			sbAt.append(" ~Recommended by CO= ").append(correctNull((String)hshValues.get("txt_COremd")));
			sbAt.append(" ~Concession Involved = ").append(correctNull((String)hshValues.get("txt_concession")));
						
			sbAt.append(" ~Sub-Limits= ").append(correctNull((String)hshValues.get("chksublimit")));
			sbAt.append(" ~Sub-Limit Head  = ").append(correctNull((String)hshValues.get("subfacility_head")));
			sbAt.append(" ~Sub-Limit  = ").append(correctNull((String)hshValues.get("subfacility")));
			sbAt.append(" ~Sanctioned Limits   = ").append(correctNull((String)hshValues.get("txt_subsanclimit")));
			sbAt.append(" ~Outstanding = ").append(correctNull((String)hshValues.get("txt_suboutstanding")));
			sbAt.append(" ~Margin(%) = ").append(correctNull((String)hshValues.get("txt_submargin")));
			sbAt.append(" ~Out Standing as on = ").append(correctNull((String)hshValues.get("txt_suboutstandingason")));
			sbAt.append(" ~CBS Account No = ").append(correctNull((String)hshValues.get("txt_subcbsno")));
			sbAt.append(" ~Applicable =").append(correctNull((String)hshValues.get("txt_subappint")));
			sbAt.append(" ~Existing=").append(correctNull((String)hshValues.get("txt_subexistint")));
			sbAt.append(" ~Proposed by Branch = ").append(correctNull((String)hshValues.get("txt_subpropint")));
			sbAt.append(" ~Recommended by RO  = ").append(correctNull((String)hshValues.get("txt_subROremd")));
			sbAt.append(" ~Recommended by FGMO  = ").append(correctNull((String)hshValues.get("txt_subZOremd")));
			sbAt.append(" ~Recommended by CO= ").append(correctNull((String)hshValues.get("txt_subCOremd")));
			sbAt.append(" ~Concession Involved = ").append(correctNull((String)hshValues.get("txt_subconcession")));
//Purpose
		AuditTrial.auditLog(hshValues,"315",strAppno,sbAt.toString());
			
			
		}
		catch(Exception e1)
		{
			throw new EJBException(e1.getMessage());
		}
	}
	
	public HashMap getfacilityData(HashMap hshValues)
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;
		ResultSet rs1=null;
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		String strQuery="";
		String strAppno="";
		String strPropappno="";
		String strValuesin=""; 
		try
		{
			strAppno= correctNull((String)hshValues.get("appno"));	
			
			if(strAppno.equalsIgnoreCase("NEW"))
			{
				String strappoldid=correctNull((String)hshValues.get("hidappoldid"));
				String strOrgSelect=correctNull((String)hshValues.get("strOrgSelect"));
				StringBuffer strcomappidList=new StringBuffer();
				String strMsg="";
				boolean boolcancreate=true;
				strQuery = SQLParser.getSqlQuery("UniqComappidListBranch^"+strOrgSelect+"^"+strappoldid);
				rs=DBUtils.executeQuery(strQuery);
				int j = 0;
				strcomappidList.append("(");
				while(rs.next())
				{
					if(j!=0)
					{
						strcomappidList.append(",");
					}
					strcomappidList.append(Helper.correctNull((String)rs.getString("comapp_id")));
					
					j++;
				}
				strcomappidList.append(")");
				
				strQuery = SQLParser.getSqlQuery("selpendingmstapplns^"+strcomappidList.toString());
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					if(!rs.getString(1).equals("0"))
					{
						strMsg="Application is not closed, so you cannot create new modification in sanction terms";
						hshRecord.put("appavailable","YES");
						hshRecord.put("strMsg",strMsg);
						boolcancreate=false;
						//throw new EJBException(strExp);
					}
				}
				
				if(boolcancreate)
				{
					strQuery=SQLParser.getSqlQuery("getapprovedappno^"+strcomappidList.toString());
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strPropappno=correctNull(rs.getString("app_no"));
						strValuesin=correctNull(rs.getString("app_valuesin"));
					}
					if(strPropappno.equals(""))
					{
						strMsg="No Proposals are available to copy the datas, so cann't create Modification in sanction terms";
						hshRecord.put("strMsg",strMsg);
						hshRecord.put("propavailable","No");
						boolcancreate=false;
					}
				}
				
				if(boolcancreate)
				{
					double dblproposalamt=0.0;
					String strPrdcode="";
					String strSolid=correctNull((String)hshValues.get("strSolid"));
					HashMap hshQuery=null;
					ArrayList arrValues=null;
					int intUpdateSize=0;
					HashMap hshQueryValues=new HashMap();
					
					strQuery=SQLParser.getSqlQuery("getpropamount^"+strPropappno);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						dblproposalamt=rs.getDouble("proposed");
					}
					
					strQuery=SQLParser.getSqlQuery("selautolimitid^M^"+dblproposalamt);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strPrdcode=correctNull(rs.getString("prd_code"));
					}
					if(strPrdcode.equalsIgnoreCase(""))
					{
						strMsg="Limit Master Not defined in setup";
						hshRecord.put("strMsg",strMsg);
						hshRecord.put("propavailable","No");
					}
					else
					{
						strAppno=getMSTAppno(strSolid);
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						intUpdateSize++;
						hshQuery.put("strQueryId","insmstapplication");
						arrValues.add(strAppno);
						arrValues.add(correctNull((String)hshValues.get("strUserId")));
						arrValues.add(correctNull((String)hshValues.get("strUserId")));
						arrValues.add("op");
						arrValues.add(strPrdcode);
						arrValues.add(correctNull((String)hshValues.get("hidapplicantid")));
						arrValues.add(strPropappno);
						arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
						arrValues.add(strValuesin);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(""+intUpdateSize,hshQuery);
						
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						intUpdateSize++;
						hshQuery.put("strQueryId","insmstfacility");
						arrValues.add(strAppno);
						arrValues.add(strPropappno);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(""+intUpdateSize,hshQuery);
						
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						intUpdateSize++;
						hshQuery.put("strQueryId","insmstsecurity");
						arrValues.add(strAppno);
						arrValues.add(strPropappno);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(""+intUpdateSize,hshQuery);
						
						hshQueryValues.put("size",""+intUpdateSize);
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
					
				}
			}

			if(!strAppno.equalsIgnoreCase("NEW"))
			{
				strQuery=SQLParser.getSqlQuery("sel_mstfacility^"+strAppno+"^0");

				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					
					arrCol = new ArrayList();
					arrCol.add(correctNull(rs.getString("mstfacilities_headid")));//0
					arrCol.add(correctNull(rs.getString("mstfacilities_id")));//1
					arrCol.add(Helper.correctDouble(rs.getString("mstfacilities_sanclimit")));//2
					arrCol.add(Helper.correctDouble(rs.getString("mstfacilities_outstanding")));//3
					arrCol.add(correctNull(rs.getString("mstfacilities_margin")));//4
					arrCol.add(correctNull(rs.getString("mstfacilities_outstandason")));//5
					arrCol.add(correctNull(rs.getString("mstfacilities_cbsaccno")));//6
					arrCol.add(correctNull(rs.getString("mstfacilities_appint")));//7
					arrCol.add(correctNull(rs.getString("mstfacilities_existint")));//8
					arrCol.add(correctNull(rs.getString("mstfacilities_propint")));//9
					arrCol.add(correctNull(rs.getString("mstfacilities_roremd")));//10
					arrCol.add(correctNull(rs.getString("mstfacilities_coremd")));//11
					arrCol.add(correctNull(rs.getString("mstfacilities_concession")));//12
					arrCol.add(correctNull(rs.getString("mstfacilities_irregularties")));//13
					arrCol.add(correctNull(rs.getString("mstfacilities_facgroup")));//14
					String strFacgrp=correctNull(rs.getString("mstfacilities_sno"));
					arrCol.add(strFacgrp);//15
					
					arrCol.add(correctNull(rs.getString("facheaddesc")));//16
					arrCol.add(correctNull(rs.getString("facdesc")));//17
					arrCol.add(correctNull(rs.getString("mstfacilities_zoremd")));//18
					
					arrRow.add(arrCol);
					
					strQuery=SQLParser.getSqlQuery("sel_mstfacility^"+strAppno+"^"+strFacgrp);
					
					if(rs1!=null)
						rs1.close();
					
					rs1=DBUtils.executeQuery(strQuery);
					while(rs1.next())
					{
						arrCol = new ArrayList();
						arrCol.add(correctNull(rs1.getString("mstfacilities_headid")));//0
						arrCol.add(correctNull(rs1.getString("mstfacilities_id")));//1
						arrCol.add(Helper.correctDouble(rs1.getString("mstfacilities_sanclimit")));//2
						arrCol.add(Helper.correctDouble(rs1.getString("mstfacilities_outstanding")));//3
						arrCol.add(correctNull(rs1.getString("mstfacilities_margin")));//4
						arrCol.add(correctNull(rs1.getString("mstfacilities_outstandason")));//5
						arrCol.add(correctNull(rs1.getString("mstfacilities_cbsaccno")));//6
						arrCol.add(correctNull(rs1.getString("mstfacilities_appint")));//7
						arrCol.add(correctNull(rs1.getString("mstfacilities_existint")));//8
						arrCol.add(correctNull(rs1.getString("mstfacilities_propint")));//9
						arrCol.add(correctNull(rs1.getString("mstfacilities_roremd")));//10
						arrCol.add(correctNull(rs1.getString("mstfacilities_coremd")));//11
						arrCol.add(correctNull(rs1.getString("mstfacilities_concession")));//12
						arrCol.add(correctNull(rs1.getString("mstfacilities_irregularties")));//13
						arrCol.add(correctNull(rs1.getString("mstfacilities_facgroup")));//14
						arrCol.add(correctNull(rs1.getString("mstfacilities_sno")));//15
						
						arrCol.add(correctNull(rs1.getString("facheaddesc")));//16
						arrCol.add(correctNull(rs1.getString("facdesc")));//17
						arrCol.add(correctNull(rs1.getString("mstfacilities_zoremd")));//18
						
						arrRow.add(arrCol);
					}
				}
				
				hshRecord.put("arrRow",arrRow);
				hshRecord.put("appno",strAppno);
				
				TagDataHelperMST tagDataHelpermst=new TagDataHelperMST();
				hshRecord.putAll((HashMap)tagDataHelpermst.getMSTAppData(hshRecord));
				char readFlag=Helper.correctNull((String)hshValues.get("strGroupRights")).charAt(18);
				hshRecord.put("btnenable",(""+readFlag).equals("r")?"N":(correctNull((String)hshRecord.get("appstatus")).equalsIgnoreCase("op") && hshValues.get("strUserId").equals(correctNull((String)hshRecord.get("applnholder"))))?"Y":"N");
				
			}
		}
		catch(Exception e1)
		{
			throw new EJBException(e1.getMessage());
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
	
	public void updateSecuritesData(HashMap hshValues)
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		
		String strAppno="";
		String strAction="";
		String strSecno="";
		String strSectype="";
		String strFacsno="";
		
		int intUpdatesize=0;
		StringBuilder sbolddata=new StringBuilder();
		ResultSet rs=null;
		
		try
		{
			strAction=correctNull((String)hshValues.get("hidAction"));
			strAppno=correctNull((String)hshValues.get("appno"));
			strSecno=correctNull((String)hshValues.get("hidsno"));
			strSectype=correctNull((String)hshValues.get("selsectype"));
			
			if(strSectype.equalsIgnoreCase("Primary"))
			{
				strFacsno=correctNull((String)hshValues.get("sellimit"));
			}
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
			{
				String strQuery=SQLParser.getSqlQuery("sel_mstsecdetailsbysno^"+strSecno+"^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					sbolddata.append("Security Type  =").append(correctNull(rs.getString("mstsec_type")));
					sbolddata.append(" ~Security = ").append(correctNull(rs.getString("sec_name")));
					sbolddata.append(" ~Security Value as On  = ").append(correctNull(rs.getString("mstsec_ason")));
					sbolddata.append(" ~Security Tenor(In Months)  = ").append(correctNull(rs.getString("mstsec_tenor")));
					sbolddata.append(" ~Security Value = ").append(correctNull(rs.getString("mstsec_value")));
					sbolddata.append(" ~Insurance Expiry Date = ").append(correctNull(rs.getString("mstsec_insexpirydate")));
					sbolddata.append(" ~Valuers Name = ").append(correctNull(rs.getString("mstsec_valuersname")));
					sbolddata.append(" ~Insurance Amount = ").append(correctNull(rs.getString("mstsec_insuranceamt")));
				}
			}
			
			if(strAction.equals("Insert"))
			{
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				intUpdatesize++;
				strSecno=getMaxsecno(strAppno);
				arrValues.add(strAppno);
				arrValues.add(strSecno);
				arrValues.add(correctNull((String)hshValues.get("hidsecid")));
				arrValues.add(correctNull((String)hshValues.get("txtsecdetails")));
				arrValues.add(correctNull((String)hshValues.get("txtsecvalue")));
				arrValues.add(correctNull((String)hshValues.get("txtsecvaldate")));
				arrValues.add(strSectype);
				arrValues.add(correctNull((String)hshValues.get("txtsectenor")));
				arrValues.add(correctNull((String)hshValues.get("txtvaluername")));
				arrValues.add(correctNull((String)hshValues.get("txtinsuranceamt")));
				arrValues.add(correctNull((String)hshValues.get("txtinsexpdate")));
				arrValues.add(correctNull((String)hshValues.get("txtremarks")));
				arrValues.add(strFacsno);
				hshQuery.put("strQueryId","ins_mstsecdetails");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
			}
			else if(strAction.equals("Update"))
			{
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				intUpdatesize++;
			
				arrValues.add(correctNull((String)hshValues.get("hidsecid")));
				arrValues.add(correctNull((String)hshValues.get("txtsecdetails")));
				arrValues.add(correctNull((String)hshValues.get("txtsecvalue")));
				arrValues.add(correctNull((String)hshValues.get("txtsecvaldate")));
				arrValues.add(strSectype);
				arrValues.add(correctNull((String)hshValues.get("txtsectenor")));
				arrValues.add(correctNull((String)hshValues.get("txtvaluername")));
				arrValues.add(correctNull((String)hshValues.get("txtinsuranceamt")));
				arrValues.add(correctNull((String)hshValues.get("txtinsexpdate")));
				arrValues.add(correctNull((String)hshValues.get("txtremarks")));
				arrValues.add(strFacsno);
				arrValues.add(strAppno);
				arrValues.add(strSecno);
				hshQuery.put("strQueryId","upd_mstsecdetails");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
			}
			else if(strAction.equals("Delete"))
			{
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				intUpdatesize++;
				
				/*strQuery=SQLParser.getSqlQuery("sel_mstfacdetails^"+strAppno+"^"+correctNull((String)hshValues.get("hidsecid")));
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					updflag=false;
					String strExp="$";
					strExp=strExp+"Security Attached with Facility , you cann't delete it";
					throw new EJBException(strExp);
				}
				if(updflag)
				{*/
				arrValues.add(strAppno);
				arrValues.add(strSecno);
				hshQuery.put("strQueryId","del_mstsecdetails");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
				//}
			}
			
			hshQueryValues.put("size",""+intUpdatesize);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			StringBuilder sbAt = new StringBuilder();
			
			sbAt.append("Security Type  =").append(correctNull((String)hshValues.get("selsectype")));
			sbAt.append(" ~Security = ").append(correctNull((String)hshValues.get("txtsecdesc")));
			sbAt.append(" ~Security Value as On  = ").append(correctNull((String)hshValues.get("txtsecvalue")));
			sbAt.append(" ~Security Tenor(In Months)  = ").append(correctNull((String)hshValues.get("txtsectenor")));
			sbAt.append(" ~Security Value = ").append(correctNull((String)hshValues.get("txtsecvalue")));
			sbAt.append(" ~Insurance Expiry Date = ").append(correctNull((String)hshValues.get("txtinsexpdate")));
			sbAt.append(" ~Valuers Name = ").append(correctNull((String)hshValues.get("txtvaluername")));
			sbAt.append(" ~Insurance Amount = ").append(correctNull((String)hshValues.get("txtinsuranceamt")));

		AuditTrial.auditNewLog(hshValues,"295",strAppno,sbAt.toString(),sbolddata.toString());
		}
		catch(Exception ex)
		{
			throw new EJBException("Error in updateSecuritesData  :: "+ex.toString());
		}
	}
	
	
	public HashMap getSecuritesData(HashMap hshValues)
	{
		HashMap hshRecord=null;
		
		ResultSet rs=null;
		
		String strAppno="";
		String strQuery="";
		
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		boolean recordflag=false;
		try
		{
			hshRecord=new HashMap();
			strAppno=correctNull((String)hshValues.get("appno"));
			
			strQuery=SQLParser.getSqlQuery("sel_mstsecdetails^"+strAppno);
			
			rs=DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(correctNull(rs.getString("mstsec_srlno")));//0
				arrCol.add(correctNull(rs.getString("mstsec_id")));//1
				arrCol.add(correctNull(rs.getString("sec_name")));//2
				arrCol.add(correctNull(rs.getString("mstsec_details")));//3
				arrCol.add(correctNull(rs.getString("mstsec_value")));//4
				arrCol.add(correctNull(rs.getString("mstsec_ason")));//5
				arrCol.add(correctNull(rs.getString("mstsec_tenor")));//6
				arrCol.add(correctNull(rs.getString("mstsec_type")));//7
				arrCol.add(correctNull(rs.getString("mstsec_valuersname")));//8
				arrCol.add(correctNull(rs.getString("mstsec_insuranceamt")));//9
				arrCol.add(correctNull(rs.getString("mstsec_insexpirydate")));//10
				arrCol.add(correctNull(rs.getString("mstsec_remarks")));//11
				arrCol.add(correctNull(rs.getString("mstsec_facsno")));//12
				arrRow.add(arrCol);
				recordflag=true;
			}
			hshRecord.put("arrRow",arrRow);
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
		}
		catch(Exception ex)
		{
			throw new EJBException("Error in updateData of getSecuritesData :: "+ex.toString());
		}
		return hshRecord;
	}
	
	/*public void updateFacSecurityData(HashMap hshValues)
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		
		ResultSet rs=null;
		String strAction=(String)hshValues.get("hidAction");
		String strappno="";
		String[] strSecurity = null;
		String strFacility = "";
		try
		{
			strSecurity=correctNull((String)hshValues.get("hidsecurity")).split("@");
			strFacility=correctNull((String)hshValues.get("selfacility"));
			strappno=correctNull((String)hshValues.get("appno"));
			
				if(strAction.equalsIgnoreCase("insert"))
				{
					
					 arrValues.add(strappno);
					 arrValues.add(strFacility);
					 hshQuery.put("arrValues",arrValues); 
					 hshQuery.put("strQueryId","del_facsecurity"); 
					 hshQueryValues.put("1",hshQuery);
					 hshQueryValues.put("size","1");	
					 EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					for (int i = 0; i < strSecurity.length; i++) 
					{
						
						 hshQueryValues=new HashMap();
						 hshQuery=new HashMap();
						 arrValues=new ArrayList();
						 
						 arrValues.add(strappno);
						 arrValues.add(strFacility);
						 arrValues.add(strSecurity[i]);
						 
						 hshQuery.put("arrValues",arrValues); 
						 hshQuery.put("strQueryId","ins_facsecurity"); 
						 hshQueryValues.put("1",hshQuery);
						 hshQueryValues.put("size","1");	
						 EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
				}
				if(strAction.equalsIgnoreCase("Delete"))
				{
					 arrValues.add(strappno);
					 arrValues.add(strFacility);
					 hshQuery.put("arrValues",arrValues); 
					 hshQuery.put("strQueryId","del_facsecurity"); 
					 hshQueryValues.put("1",hshQuery);
					 hshQueryValues.put("size","1");	
					 EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
		}
		catch(Exception e1)
		{
			throw new EJBException(e1.getMessage());
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
				throw new EJBException("Error closing in updateSecuInsuranceMapping the connection "+cf.getMessage());
						
			}
		}
	}
	
	public HashMap getFacSecurityData(HashMap hshValues)
	{
		ResultSet rs=null;
		ResultSet rs1=null;
		String strQuery;
		HashMap hshRecord=new HashMap();
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		
		String strAppno = correctNull((String)hshValues.get("appno"));
		String strfacility="";
		
		String strsecurity="";
		try
		{
			if(!(correctNull((String)hshValues.get("selfacility")).equalsIgnoreCase("")))
			{
			strfacility= correctNull((String)hshValues.get("selfacility"));
				if(!(strfacility).equalsIgnoreCase(""))
				{
					strQuery=SQLParser.getSqlQuery("sel_facsecurity^"+strAppno+"^"+strfacility);
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						arrCol = new ArrayList();
						strsecurity=strsecurity + correctNull((String)rs.getString("facsecurity_secsno"))+"@";
						arrRow.add(arrCol);
					}
				}
			}
			hshRecord.put("arrRow",arrRow);
			hshRecord.put("facility",strfacility);
			hshRecord.put("security",strsecurity);
		}
		catch(Exception e1)
		{
			throw new EJBException(e1.getMessage());
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
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing in the getFacSecurityData connection "+cf.getMessage());
						
			}
		}
		return hshRecord;
	}*/
	
	public HashMap getMstLimitMasterData(HashMap hshRequestValues) 
	{		
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strQuery="";
		String strLimitId="";
		String strPrdType="M";
		boolean recordflag=false;
		try
		{				
			hshRecord = new HashMap();
			strLimitId=correctNull((String)hshRequestValues.get("selectlimit"));
			strPrdType = correctNull((String)hshRequestValues.get("prdtype"));
			strQuery = SQLParser.getSqlQuery("getlimitval^"+strPrdType+"^"+strLimitId);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{  
				recordflag=true;
				hshRecord.put("prd_rng_from",correctNull(rs.getString(1)));
				hshRecord.put("prd_rng_to",correctNull(rs.getString(2)));
				hshRecord.put("prd_term",correctNull(rs.getString(3)));
				hshRecord.put("prd_code",correctNull(strLimitId));
				hshRecord.put("prd_maxappclass",correctNull(rs.getString(4)));
				hshRecord.put("prd_maxskipclass",correctNull(rs.getString(5)));
			}
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getMstLimitMasterDate login  "+ce.toString());
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

	public void updateMstLimitMasterData(HashMap hshValues) 
	{	
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=null;
		
		String strAction="";
		String strLimitId = "";
		String strExp="$";
		String strLimitFrom="";
		String strLimitTo = "";
		String strLimitClass ="";
		String strSkipClass="";
		String strPrdType="C";		
		String strQuery="";
		
		int intUpdatesize = 0;
		ResultSet rs = null;
		StringBuilder sbAt=new StringBuilder();
		StringBuilder sbolddata = new StringBuilder();
		String strKeyId = "";

		try
		{
			strAction=(String)hshValues.get("hidAction");
			strLimitId =  correctNull((String )hshValues.get("selectlimit"));
			strLimitFrom = correctNull((String )hshValues.get("txtlimit_from"));
			strLimitTo =  correctNull((String )hshValues.get("txtlimit_to"));
			strLimitClass = correctNull((String )hshValues.get("txtlimit_class"));
			strSkipClass = correctNull((String )hshValues.get("txtskip_class"));
			strPrdType = correctNull((String)hshValues.get("prdtype"));
			strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
			{
				rs = DBUtils.executeLAPSQuery("getlimitval^"+strPrdType+"^"+strLimitId);
				if(rs.next())
				{
					sbolddata.append("~ Loan Limit From = "+Helper.correctNull((String)rs.getString("prd_rng_from")));
					sbolddata.append("~ Loan Limit To = "+Helper.correctNull((String)rs.getString("prd_rng_to")));
					sbolddata.append("~ Minimum Class for Approval / Rejection = "+Helper.correctNull((String)rs.getString("prd_approval")));
					sbolddata.append("~ Minimum Class for Skip flowpoints = "+Helper.correctNull((String)rs.getString("prd_skip")));
				}
				if(rs!=null)
				rs.close();
			}
			
			if(strSkipClass.trim().equals(""))
			{
				strSkipClass="0";
			}
			
			if(strLimitFrom.trim().equals(""))
			{
				strLimitFrom ="0";
			}
			if(strLimitTo.trim().equals(""))
			{
				strLimitTo ="0";
			}

								

			if(strAction.trim().equals("update"))
			{
				int curLimitId=0;
				if(!strLimitId.trim().equals(""))
				{
					curLimitId = Integer.parseInt(strLimitId);
				}
				strQuery = SQLParser.getSqlQuery("checklimitrange^"+strPrdType+"^"+strLimitId+"^"+strLimitFrom +"^"+strLimitTo);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next())
				{		
					int intLimitid = rs.getInt("prd_code");
					if(intLimitid != curLimitId)
					{
						strExp = strExp + " Check the existing limit range ";
						throw new Exception(strExp);
					}
				}
				
				intUpdatesize ++ ;
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","updatelimit");
				arrValues.add(strLimitFrom);
				arrValues.add(strLimitTo);
				arrValues.add(strLimitClass);
				arrValues.add(strPrdType);
				arrValues.add(strLimitId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				
				intUpdatesize ++ ;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","updatesancauth");
				arrValues.add(strSkipClass);
				arrValues.add(strLimitClass);
				arrValues.add("0");
				arrValues.add(strLimitId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
			}
			else if(strAction.equals("insert"))
			{
				strLimitId =  Integer.toString(getLimitCode());
				strQuery = SQLParser.getSqlQuery("checklimitrange^"+strPrdType+"^"+strLimitId+"^"+strLimitFrom +"^"+strLimitTo);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next())
				{
					strExp = strExp + " Check the existing limit range ";
					throw new Exception(strExp);
				}
				
				intUpdatesize ++ ;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","insertlimit");
				arrValues.add(strLimitId);
				arrValues.add(strLimitFrom);
				arrValues.add(strLimitTo);
				arrValues.add(strPrdType);
				arrValues.add(strLimitClass);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				
				intUpdatesize ++ ;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","prdauthins");
				arrValues.add(strLimitId);
				arrValues.add(strSkipClass);
				arrValues.add(strLimitClass );
				arrValues.add("0");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
			}
 			else if(strAction.equals("delete"))
			{
 				
 				strQuery = SQLParser.getSqlQuery("checkmstapplication^"+strLimitId);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next())
				{
					if(!correctNull((String)rs.getString(1)).equals("0"))
					{	
						strExp = strExp + "Application created in this limit range so can't able to delete the limit";
						throw new Exception(strExp);
					}	
				}
 				
				intUpdatesize ++ ;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","prdauthdel");
				arrValues.add(strLimitId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				intUpdatesize ++ ;
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				hshQuery.put("strQueryId","deletelimit");
				arrValues.add(strPrdType);
				arrValues.add(strLimitId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);	
				
				
				
				
			}
			//for Entering the values into auditrial
			String strActionData = "";
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("Insert"))
			{
			 strActionData = "Loan limit from ="+strLimitFrom+
									"~Loan limit To="+strLimitTo+
				"~Minimum Class for Approval / Rejection ="+strLimitClass+
				"~Minimum Class for Skip flowpoints="+strSkipClass;
			}		
			hshQueryValues.put("size",Integer.toString(intUpdatesize));
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");			
			AuditTrial.auditNewLog(hshValues,"359",strKeyId,strActionData,sbolddata.toString());
		}
		catch(Exception ce)
		{
			throw new EJBException(ce.toString());
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
	
	public void updateMstWorkflowMasterData(HashMap hshRequestValues) 
	{
		String[] strPrd_workid = null;
		String[] strPrd_maxclass = null;
		String[] strPrd_duration = null;
		String[] strWrk_flowname = null;
		String strPrdCode = null;
		String strWrk_flowtype = null;
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		int intSize = 1;
		int intFlowpoint = 0;
		StringBuilder sbAt=new StringBuilder();
		StringBuilder sbolddata = new StringBuilder();
		String strKeyId = "";
		String[] strTextclass = null;
		ResultSet rs = null;
		String strSelect = "",strDataCheck="no";
		String[] strPrd_wrkflowname = null;
		try
		{
			strPrd_workid = (String[]) hshRequestValues.get("prd_workid");
			strPrd_maxclass = (String[]) hshRequestValues.get("prd_maxclass");
			strPrd_duration = (String[]) hshRequestValues.get("prd_duration");
			strPrd_wrkflowname = (String[]) hshRequestValues.get("wrk_flowname");
	
			strPrdCode = correctNull((String) hshRequestValues.get("prdCode"));
			strWrk_flowtype = correctNull((String) hshRequestValues.get("wrk_flowtype"));
			strTextclass = (String[]) hshRequestValues.get("hid_prd_maxclass");
			strSelect = Helper.correctNull((String)hshRequestValues.get("hid_prdCode"));
			rs = DBUtils.executeLAPSQuery("prdworkflowsel^" + strPrdCode+ "^" + strWrk_flowtype);
			strKeyId = Helper.correctNull((String)hshRequestValues.get("hidkeyid"));
			while(rs.next())
			{
				strDataCheck="yes";
				sbolddata.append("~ Select Limit = "+strSelect);
				//sbolddata.append("~ Flow Point = "+Helper.correctNull((String)rs.getString("prd_workid")));
				sbolddata.append("~ Action = "+Helper.correctNull((String)rs.getString("WRK_FLOWNAME")));
				sbolddata.append("~ Minimum Class = "+Helper.correctNull((String)rs.getString("stat_data_desc1")));
				sbolddata.append("~ Duration = "+Helper.correctNull((String)rs.getString("prd_duration")));
			}
			if(rs!=null)
			rs.close();
			
			if (strWrk_flowtype.equalsIgnoreCase("p")) 
			{
				intFlowpoint = 1;
			}
			else if (strWrk_flowtype.equalsIgnoreCase("a")) 
			{
				intFlowpoint = 9;
			}
			else 
			{
				intFlowpoint = 17;
			}
			strWrk_flowname = (String[]) hshRequestValues.get("wrk_flowname");
			hshQueryValues.put("size", "1");
			hshQuery.put("strQueryId", "prdworkflowdel");
			arrValues.add(strPrdCode);
			arrValues.add(strWrk_flowtype);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1", hshQuery);
			intSize++;
			for (int i = 0; i < strPrd_workid.length; i++) 
			{
				if (!strWrk_flowname[i].equals("")) 
				{
					hshQueryValues.put("size", String.valueOf(intSize));
					hshQuery = new HashMap();
					hshQuery.put("strQueryId", "prdworkflowins");
					arrValues = new ArrayList();
					arrValues.add(strPrdCode);
					arrValues.add(String.valueOf(intFlowpoint));
					arrValues.add(strPrd_workid[i]);
					arrValues.add(strPrd_maxclass[i]);
					arrValues.add(strPrd_duration[i]);
					arrValues.add("");
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(String.valueOf(intSize), hshQuery);
					intSize++;
					intFlowpoint++;
				}
			}
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				//updateProductSaveStatus
				//sbAt.append("~ Select Limit = "+strSelect);
					if(strDataCheck.equals("yes"))
					{
						hshRequestValues.put("hidAction","Update");
					}
					else
					{
						hshRequestValues.put("hidAction","Insert");
					}
				for (int i = 0; i < strPrd_workid.length; i++) 
				{
					if (!strWrk_flowname[i].equals("")) 
					{
						//sbAt.append("~ Flow Point = "+String.valueOf(intFlowpoint));
						sbAt.append("~ Select Limit = "+strSelect);
						sbAt.append("~ Action = "+strPrd_wrkflowname[i]);
						sbAt.append("~ Minimum Class = "+strTextclass[i]);
						sbAt.append("~ Duration in Days = "+strPrd_duration[i]);
						intSize++;
						intFlowpoint++;
					}
				}
				AuditTrial.auditNewLog(hshRequestValues,"360",strKeyId,sbAt.toString(),sbolddata.toString());
		}
		catch (Exception e) 
		{
			log.error("Exception in updateWorkflowdata.. " + e);
			throw new EJBException(e.getMessage());
		}
	}
	
	public HashMap getMstWorkflowMasterData(HashMap hshRequestValues) 
	{
		String strQuery = null;
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList arrWorkid = new ArrayList();
		ArrayList arrMaxclass = new ArrayList();
		ArrayList arrDuration = new ArrayList();
		ArrayList arrWorkflowname = new ArrayList();
		String strPrdCode = null;
		String strWorkflowType = null;
		try 
		{
			strPrdCode = correctNull((String)hshRequestValues.get("prdCode"));
			strWorkflowType = correctNull((String)hshRequestValues.get("wrk_flowtype"));
			if (strWorkflowType == null || strWorkflowType.trim().equals(""))
			strWorkflowType = "p";
			if(!strPrdCode.equals(""))
			{
				strQuery = SQLParser.getSqlQuery("prdworkflowsel^" + strPrdCode	+ "^" + strWorkflowType);
				rs = DBUtils.executeQuery(strQuery);

				while (rs.next())
				{
					arrWorkid.add(rs.getString("prd_workid"));
					arrMaxclass.add(rs.getString("prd_maxclass"));
					arrDuration.add(rs.getString("prd_duration"));
					arrWorkflowname.add(rs.getString("wrk_flowname"));
				}
			}
			hshRecord.put("prd_workid", arrWorkid);
			hshRecord.put("prd_maxclass", arrMaxclass);
			hshRecord.put("prd_duration", arrDuration);
			hshRecord.put("wrk_flowname", arrWorkflowname);
	
		}
		catch (Exception e) 
		{
				log.error("error in getWorkflowData.. " + e);
				throw new EJBException(e.getMessage());
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
			catch (Exception e1) 	
			{
				log.error("Error closing connection.." + e1);
			}
		}
		return hshRecord;
	}
	
	
	public HashMap getMSTHistory(HashMap hshValues)
	{
		String strAppno="";
		ResultSet rs=null;
		ResultSet rs1=null;
		HashMap hshRecord=new HashMap();
		ArrayList arrFromflow=new ArrayList();
		ArrayList arrToflow=new ArrayList();
		ArrayList arrFromUsr=new ArrayList();
		ArrayList arrToUsr=new ArrayList();
		ArrayList arrDate=new ArrayList();
		ArrayList arrMailType=new ArrayList();
		
		try
		{
			
			strAppno=correctNull((String)hshValues.get("appno"));
			if(rs!=null)
			rs.close();	
			
			rs=DBUtils.executeLAPSQuery("mst_workflowhistory^"+strAppno);
			while(rs.next())
			{
				arrFromUsr.add(correctNull(rs.getString("fromuser")));
				arrToUsr.add(correctNull(rs.getString("touser")));
				arrFromflow.add(correctNull(rs.getString("mstmail_fromflowpoint")));
				arrToflow.add(correctNull(rs.getString("mstmail_toflowpoint")));
				arrDate.add(correctNull(rs.getString("maildate")));
			}
			hshRecord.put("arrFromUsr",arrFromUsr);
			hshRecord.put("arrToUsr",arrToUsr);
			hshRecord.put("arrFromflow",arrFromflow);
			hshRecord.put("arrToflow",arrToflow);
			hshRecord.put("arrDate",arrDate);
			hshRecord.put("arrMailType",arrMailType);
			
			return hshRecord;
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
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
				
			}
			catch(Exception e1)
			{
				throw new EJBException("Error closing connection.."+e1);
			}
		}
	}

	public HashMap getMSTAction(HashMap hshValues) 
	{
		
		String strAppno="";
		String strQuery="";
		String strAppStatus="";
		String strAction="";
		
		ResultSet rs=null;
		ResultSet rs1=null;
		ResultSet rs2=null;
		
		
		HashMap hshRecord=new HashMap();
		ArrayList arrFlowpoint=new ArrayList();
		ArrayList arrDone=new ArrayList();
		ArrayList arrClassDesc=new ArrayList();
		ArrayList arrMaxclass=new ArrayList();
		ArrayList arrAction=new ArrayList();
		try
		{
			strAppno=correctNull((String)hshValues.get("appno"));
			strAction=correctNull((String)hshValues.get("hidAction"));
			
			if(rs!=null)
			rs.close();	
			
			strQuery=SQLParser.getSqlQuery("sel_mstapplication^"+strAppno);
     		rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strAppStatus=correctNull((String)rs.getString("mst_status"));
				hshRecord.put("ApproveRejectedby",correctNull(rs.getString("mst_processedusrid")));
				hshRecord.put("Sanction_Comments",correctNull(rs.getString("mst_sancauthcomments")));
				hshRecord.put("appstatus",strAppStatus);
			}
			
			if(rs!=null)
				rs.close();	
			
			strQuery=SQLParser.getSqlQuery("sel_mstworkflowsel^"+strAppno+"^<^9^>^0");
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				strQuery=SQLParser.getSqlQuery("mst_workflowcnt^"+strAppno+"^"+rs.getString(1));
				if(rs1!=null)
				rs1.close();
				
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					arrDone.add(rs1.getString(1));
				}
				arrFlowpoint.add((correctNull((String)rs.getString(1))));
				arrAction.add((correctNull((String)rs.getString(2))));
				arrMaxclass.add((correctNull((String)rs.getString(3))));
				arrClassDesc.add((correctNull((String)rs.getString(5))));
			}
			
			if(strAppStatus.equalsIgnoreCase("op"))
			{
				arrDone.add("0");
			}
			else
			{
				arrDone.add("1");
			}
			
			if(!strAppStatus.equalsIgnoreCase("op"))
			{
				if((strAppStatus.equalsIgnoreCase("pa")) || (strAppStatus.equalsIgnoreCase("ca"))) 
				{
					strQuery=SQLParser.getSqlQuery("sel_mstworkflowsel^"+strAppno+"^<^17^>^8");
				}
				else if(strAppStatus.equalsIgnoreCase("pr") || strAppStatus.equalsIgnoreCase("cr"))
				{
					strQuery=SQLParser.getSqlQuery("sel_mstworkflowsel^"+strAppno+"^<^25^>^16");
				}
				if(rs!=null)
				rs.close();	
				
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					strQuery=SQLParser.getSqlQuery("mst_workflowcnt^"+strAppno+"^"+rs.getString(1));
					if(rs1!=null)
					rs1.close();
					
					rs1=DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						arrDone.add((correctNull((String)rs1.getString(1))));
					}
					arrFlowpoint.add((correctNull((String)rs.getString(1))));
					arrAction.add((correctNull((String)rs.getString(2))));
					arrMaxclass.add((correctNull((String)rs.getString(3))));
					arrClassDesc.add((correctNull((String)rs.getString(5))));
				}
			}

			strQuery=SQLParser.getSqlQuery("sel_mstworkflow^"+strAppno+"^"+strAppno);
			if(rs!=null)
			rs.close();	
			
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("strCurrFlowPoint",(correctNull((String)rs.getString("mstmail_toflowpoint"))));
				hshRecord.put("strDate",(correctNull((String)rs.getString("mstmail_date"))));
				hshRecord.put("strDueDate",(correctNull((String)rs.getString("duedate"))));
			}
			else
			{
					strQuery=SQLParser.getSqlQuery("sel_mstappworkflow^"+strAppno);
					if(rs!=null)
					rs.close();	
					
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						hshRecord.put("strCurrFlowPoint","1");
						hshRecord.put("strDate",(correctNull((String)rs.getString("createdate"))));
						hshRecord.put("strDueDate",(correctNull((String)rs.getString("duedate"))));
					}
			}
			
			strQuery=SQLParser.getSqlQuery("sel_mstworkflowpoint^"+strAppno);
			if(rs!=null)
			rs.close();	
			
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("prd_skip",(correctNull((String)rs.getString("prd_skip"))));
				hshRecord.put("prd_approval",(correctNull((String)rs.getString("prd_approval"))));
			}
			
			hshRecord.put("arrFlowpoint",arrFlowpoint);
			hshRecord.put("arrAction",arrAction);
			hshRecord.put("arrMaxclass",arrMaxclass);
			hshRecord.put("arrClassDesc",arrClassDesc);
			hshRecord.put("arrDone",arrDone);
			
			if(strAction.trim().equalsIgnoreCase("send"))
			{
				hshRecord.put("status","success");
				
			}
			return hshRecord;
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
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
			}
			catch(Exception e1)
			{
				throw new EJBException(e1.getMessage());
			}
		}
	}
	
	
	public HashMap updateMSTAction(HashMap hshValues)
	{
		String strAppno="";
		String strAction="";
		String strFromflowpoint="";
		String strToflowpoint="";
		String strFromuserid="";
		String strTouserid="";
		String strQuery="";
		
		HashMap hshResult=new HashMap();
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		StringBuilder sbAuditTrial=new StringBuilder();
		ResultSet rs=null;
		try
		{
			strAction=correctNull((String)hshValues.get("hidAction"));
			strAppno=correctNull((String)hshValues.get("appno1"));
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno=(String)hshValues.get("appno");
			}
			strFromflowpoint=correctNull((String)hshValues.get("mail_fromflowpoint"));
			strToflowpoint=correctNull((String)hshValues.get("mail_toflowpoint"));
			strFromuserid=correctNull((String)hshValues.get("strUserId"));
			strTouserid=correctNull((String)hshValues.get("hidmail_tousrid"));
			
			if(strAction.equalsIgnoreCase("send"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","mst_insmailbox");//insert into bstmail table 
				arrValues.add(strAppno);
				arrValues.add(strFromuserid);
				arrValues.add(strTouserid);
				arrValues.add(strFromflowpoint);
				arrValues.add(strToflowpoint);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","upd_mstappholder");//update bst application table
				arrValues.add(strTouserid);
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","2");
				hshQueryValues.put("2",hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			if(strAction.equalsIgnoreCase("approve")||strAction.equalsIgnoreCase("reject"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","upd_mstappstatus");//update application table - status
				
				if(strAction.equalsIgnoreCase("approve"))
				arrValues.add("pa");
				else
				arrValues.add("pr");
				arrValues.add(correctNull((String)hshValues.get("strUserId")));
				arrValues.add(Helper.getCurrentDateTime());
				arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
				arrValues.add(correctNull((String)hshValues.get("txt_sanctioncomments")));
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","mst_insmailbox");//insert into bstmail table 
				arrValues.add(strAppno);
				arrValues.add(strFromuserid);
				arrValues.add(strFromuserid);
				arrValues.add(strFromflowpoint);
				
				if(strAction.equalsIgnoreCase("approve"))
				{
					arrValues.add("9");
				}
				else
				{
					arrValues.add("17");
				}
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);
				
				hshQueryValues.put("size","2");
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			if(strAction.equalsIgnoreCase("undo"))
			{
				strQuery=SQLParser.getSqlQuery("getmaxflowpoint^"+strAppno);
	     		rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strToflowpoint=correctNull((String)rs.getString("maxflowpoint"));
				}
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","upd_mstappstatus");//update application table - status
				arrValues.add("op");
				arrValues.add(correctNull((String)hshValues.get("strUserId")));
				arrValues.add(Helper.getCurrentDateTime());
				arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
				arrValues.add(null);
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","mst_insmailbox");//insert into bstmail table 
				arrValues.add(strAppno);
				arrValues.add(strFromuserid);
				arrValues.add(strFromuserid);
				arrValues.add(strFromflowpoint);
				arrValues.add(strToflowpoint);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);
				
				hshQueryValues.put("size","2");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			if(strAction.equalsIgnoreCase("freeze"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","upd_mstworkflowcloseappln");
				
				arrValues.add(strAppno);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			sbAuditTrial.append(
			"~Application Sent By=").append(strFromuserid).append(
			"~Application Sent To=").append(strTouserid).append(
			"~From FlowPoint=").append(strFromflowpoint).append(
			"~Flow Point Action=").append(strToflowpoint).append(
			"~Action Type Requested=").append(correctNull((String)hshValues.get("hidAction")));
			AuditTrial.auditLog(hshValues,"317",strAppno,sbAuditTrial.toString());
		}
		catch(Exception e)
		{
			throw new EJBException(e.toString());
		}
		return hshResult;
	}
	
	public void updateMSTMailcomments(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAppno="";
		String strMailComments="";
		String strUserId="";
		String strtoUser="";
		
		try
		{	
				strAppno = correctNull((String )hshValues.get("appno"));
				strMailComments = correctNull((String )hshValues.get("comments"));
				strUserId = correctNull((String )hshValues.get("hiduserid"));
				strtoUser = correctNull((String )hshValues.get("hidtoUser"));
				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","ins_mstmailcomments");
				arrValues.add(strAppno);
				arrValues.add(strMailComments);
				arrValues.add(strUserId);
				arrValues.add(strtoUser);
				arrValues.add(correctNull((String )hshValues.get("txt_pano")));
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
		}
	}
	
	
	public HashMap getMSTMailcomments(HashMap hshValues) 
	{	
		ResultSet rs = null;
		HashMap hshRecord = null;
		HashMap hshRow=null;

		String strAppno = "";

		int no=1;

		try
		{

			strAppno = correctNull((String)hshValues.get("appno"));

			hshRecord = new HashMap();
			
			rs=DBUtils.executeLAPSQuery("sel_mstmailcomments^"+strAppno);
			while(rs.next())
			{		hshRow=new HashMap();
					hshRow.put("mail_appno",correctNull(rs.getString(1)));
					hshRow.put("mail_comments",correctNull(Helper.CLOBToString(rs.getClob("mail_comments"))));
					hshRow.put("mail_userid",correctNull(rs.getString(3)));
					hshRow.put("mail_date",correctNull(rs.getString(4)));
					hshRow.put("mail_touser",correctNull(rs.getString(5)));
					hshRow.put("mail_usrname",correctNull(rs.getString(7)));
					hshRow.put("mail_usrdesign",correctNull(rs.getString(6)));
					hshRow.put("mail_pano",correctNull(rs.getString(8)));

					hshRecord.put(Integer.toString(no),hshRow);
					no++;				
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData login  "+ce.toString());
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
	
	public HashMap getMSTApprovalprint(HashMap hshValues)
	{
		HashMap hshRecord=null;
		
		ResultSet rs=null;
		ResultSet rs1=null;
		ResultSet rs2=null;
		
		String strQuery="";
		String strAppno="";
		String strLevel="";
		StringBuffer sbfsignatories=null;
		
		ArrayList arrCol=null;
		ArrayList arrRow=new ArrayList();
		try
		{
			hshRecord=new HashMap();
			strAppno=correctNull((String)hshValues.get("appno"));
			
			
			// Customer Details
			strQuery=SQLParser.getSqlQuery("sel_mstcustinfo^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
		
			if(rs.next())
			{
				hshRecord.put("comapp_companyname",correctNull(rs.getString("comapp_companyname")));
				hshRecord.put("org_name",correctNull(rs.getString("org_name")));
				hshRecord.put("comapp_businessnature",correctNull(rs.getString("comapp_businessnature")));
			}
			
			if(rs!=null)
				rs.close();
			
			strQuery = SQLParser.getSqlQuery("sel_mstrating^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("Creditrating",Helper.correctNull(rs.getString("currentrating_basemodel")));
			}
			
			if(rs!=null)
				rs.close();
			
			strQuery = SQLParser.getSqlQuery("sel_mstasset^"+strAppno);
			if(rs!=null)
				rs.close();
			rs= DBUtils.executeQuery(strQuery);
			if(rs.next())
			{  						
					hshRecord.put("asset",correctNull(rs.getString("com_propassettype")));
			}
			
			if(rs!=null)
				rs.close();
			
			/*if(correctNull((String)hshValues.get("Orglevel")).equalsIgnoreCase("A"))
			{
				strLevel="'A'";
			}
			if(correctNull((String)hshValues.get("Orglevel")).equalsIgnoreCase("D"))
			{
				strLevel="'A','D'";
			}
			if(correctNull((String)hshValues.get("Orglevel")).equalsIgnoreCase("R"))
			{
				strLevel="'A','D','R'";
			}
			if(correctNull((String)hshValues.get("Orglevel")).equalsIgnoreCase("C"))
			{*/
				strLevel="'A','D','R','C'";
			//}
			
			
			strQuery=SQLParser.getSqlQuery("sel_remarks^"+strAppno+"^"+strLevel);
			
			rs=DBUtils.executeQuery(strQuery);
		
			while(rs.next())
			{
				if(correctNull((String)rs.getString("remarks_orglevel")).equalsIgnoreCase("A"))
				{
					hshRecord.put("branch_comments",Helper.CLOBToString(rs.getClob("remarks_comments")));
				}
				else if(correctNull((String)rs.getString("remarks_orglevel")).equalsIgnoreCase("D"))
				{
					hshRecord.put("region_comments",Helper.CLOBToString(rs.getClob("remarks_comments")));
				}
				else if(correctNull((String)rs.getString("remarks_orglevel")).equalsIgnoreCase("R"))
				{
					hshRecord.put("zonal_comments",Helper.CLOBToString(rs.getClob("remarks_comments")));
				}
				else if(correctNull((String)rs.getString("remarks_orglevel")).equalsIgnoreCase("C"))
				{
					hshRecord.put("central_comments",Helper.CLOBToString(rs.getClob("remarks_comments")));
				}
				sbfsignatories = new StringBuffer(Helper.CLOBToString(rs.getClob("remarks_signatures")));
				hshRecord.put("refno",Helper.correctNull(rs.getString("remarks_refno")));
				hshRecord.put("remarkdate",Helper.correctNull(rs.getString("remarks_date")));
			}
			
			
			
			if(sbfsignatories!=null)
			{
				for (int i = 0;i < sbfsignatories.length(); i++) 
				{
					if (sbfsignatories.charAt(i) == '\n') 
					{
						sbfsignatories.replace(i, i + 1, "<br>");
					}
					if (sbfsignatories.charAt(i) == ' ')
					{
						sbfsignatories.replace(i, i + 1, "&nbsp;");
					}
				}
				hshRecord.put("signatures",sbfsignatories.toString());
			}
			
			if(rs!=null)
				rs.close();
			
			// to get the ref.no and the date 
			/*strLevel=correctNull((String)hshValues.get("Orglevel"));
			strQuery=SQLParser.getSqlQuery("sel_remarks^"+strAppno+"^"+"'"+strLevel+"'");
			
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("refno",Helper.correctNull(rs.getString("remarks_refno")));
				hshRecord.put("remarkdate",Helper.correctNull(rs.getString("remarks_date")));
			}
			
			hshRecord.put("OrgLevel",strLevel);*/
			
			//Facility
			ArrayList arrSecRemarkscol=new ArrayList();
			ArrayList arrSecRemarksrow=new ArrayList();
			strQuery=SQLParser.getSqlQuery("sel_mstfacility^"+strAppno+"^0");

			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("mstfacilities_headid")));//0
				arrCol.add(correctNull(rs.getString("mstfacilities_id")));//1
				arrCol.add(Helper.correctDouble(rs.getString("mstfacilities_sanclimit")));//2
				arrCol.add(Helper.correctDouble(rs.getString("mstfacilities_outstanding")));//3
				arrCol.add(correctNull(rs.getString("mstfacilities_margin")));//4
				arrCol.add(correctNull(rs.getString("mstfacilities_outstandason")));//5
				arrCol.add(correctNull(rs.getString("mstfacilities_cbsaccno")));//6
				arrCol.add(correctNull(rs.getString("mstfacilities_appint")));//7
				arrCol.add(correctNull(rs.getString("mstfacilities_existint")));//8
				arrCol.add(correctNull(rs.getString("mstfacilities_propint")));//9
				arrCol.add(correctNull(rs.getString("mstfacilities_roremd")));//10
				arrCol.add(correctNull(rs.getString("mstfacilities_coremd")));//11
				arrCol.add(correctNull(rs.getString("mstfacilities_concession")));//12
				arrCol.add(correctNull(rs.getString("mstfacilities_irregularties")));//13
				arrCol.add(correctNull(rs.getString("mstfacilities_facgroup")));//14
				String strFacgrp=correctNull(rs.getString("mstfacilities_sno"));
				arrCol.add(strFacgrp);//15
				
				arrCol.add(correctNull(rs.getString("facheaddesc")));//16
				arrCol.add(correctNull(rs.getString("facdesc")));//17
				arrCol.add(correctNull(rs.getString("mstfacilities_zoremd")));//18
					ArrayList arrFacSecCol = null;
					ArrayList arrFacSecRow = new ArrayList();
					int count = 0;
					strQuery=SQLParser.getSqlQuery("sel_secdetails^"+strFacgrp+"^"+strAppno);
					rs2=DBUtils.executeQuery(strQuery);
					while (rs2.next())
					{
						arrFacSecCol = new ArrayList();
						arrSecRemarkscol=new ArrayList();
						arrFacSecCol.add(correctNull(rs2.getString("mstsec_details")));//19
						arrFacSecCol.add(""+count);//19
						arrSecRemarkscol.add(correctNull(rs2.getString("mstsec_remarks")));//19
						arrSecRemarksrow.add(arrSecRemarkscol);
						arrFacSecRow.add(arrFacSecCol);
					}
				arrCol.add(arrFacSecRow);//19
				
				arrRow.add(arrCol);
				
				strQuery=SQLParser.getSqlQuery("sel_mstfacility^"+strAppno+"^"+strFacgrp);
				
				if(rs1!=null)
					rs1.close();
				
				rs1=DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{
					arrCol = new ArrayList();
					arrCol.add(correctNull(rs1.getString("mstfacilities_headid")));//0
					arrCol.add(correctNull(rs1.getString("mstfacilities_id")));//1
					arrCol.add(Helper.correctDouble(rs1.getString("mstfacilities_sanclimit")));//2
					arrCol.add(Helper.correctDouble(rs1.getString("mstfacilities_outstanding")));//3
					arrCol.add(correctNull(rs1.getString("mstfacilities_margin")));//4
					arrCol.add(correctNull(rs1.getString("mstfacilities_outstandason")));//5
					arrCol.add(correctNull(rs1.getString("mstfacilities_cbsaccno")));//6
					arrCol.add(correctNull(rs1.getString("mstfacilities_appint")));//7
					arrCol.add(correctNull(rs1.getString("mstfacilities_existint")));//8
					arrCol.add(correctNull(rs1.getString("mstfacilities_propint")));//9
					arrCol.add(correctNull(rs1.getString("mstfacilities_roremd")));//10
					arrCol.add(correctNull(rs1.getString("mstfacilities_coremd")));//11
					arrCol.add(correctNull(rs1.getString("mstfacilities_concession")));//12
					arrCol.add(correctNull(rs1.getString("mstfacilities_irregularties")));//13
					arrCol.add(correctNull(rs1.getString("mstfacilities_facgroup")));//14
					strFacgrp=correctNull(rs1.getString("mstfacilities_sno"));
					arrCol.add(strFacgrp);//15
					arrCol.add(correctNull(rs1.getString("facheaddesc")));//16
					arrCol.add(correctNull(rs1.getString("facdesc")));//17
					arrCol.add(correctNull(rs1.getString("mstfacilities_zoremd")));//18
					
					count = 0;
					arrFacSecRow = new ArrayList();
					strQuery=SQLParser.getSqlQuery("sel_secdetails^"+strFacgrp+"^"+strAppno);
					rs2=DBUtils.executeQuery(strQuery);
					while (rs2.next())
					{
						count ++;
						arrFacSecCol = new ArrayList();
						arrSecRemarkscol=new ArrayList();
						arrFacSecCol.add(correctNull(rs2.getString("mstsec_details")));//19
						arrFacSecCol.add(""+count);//19
						arrSecRemarkscol.add(correctNull(rs2.getString("mstsec_remarks")));//19
						arrSecRemarksrow.add(arrSecRemarkscol);
						arrFacSecRow.add(arrFacSecCol);
					}
					arrCol.add(arrFacSecRow);
					
					arrRow.add(arrCol);
				}
				hshRecord.put("outstandingason",correctNull(rs.getString("mstfacilities_outstandason")));
				hshRecord.put("arrSecRemarks",arrSecRemarksrow);
			}			
			hshRecord.put("arrFacility",arrRow);
			
			//Security 
			arrRow=new ArrayList();
			strQuery=SQLParser.getSqlQuery("sel_mstcollsecdetails^"+strAppno);
			
			rs=DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(correctNull(rs.getString("mstsec_srlno")));
				arrCol.add(correctNull(rs.getString("mstsec_id")));
				arrCol.add(correctNull(rs.getString("sec_name")));
				arrCol.add(correctNull(rs.getString("mstsec_details")));
				arrCol.add(correctNull(rs.getString("mstsec_value")));
				arrCol.add(correctNull(rs.getString("mstsec_ason")));
				arrCol.add(correctNull(rs.getString("mstsec_tenor")));
				arrCol.add(correctNull(rs.getString("mstsec_type")));
				arrCol.add(correctNull(rs.getString("mstsec_valuersname")));
				arrCol.add(correctNull(rs.getString("mstsec_insuranceamt")));
				arrCol.add(correctNull(rs.getString("mstsec_insexpirydate")));
				arrCol.add(correctNull(rs.getString("mstsec_remarks")));
				arrRow.add(arrCol);
			}
			hshRecord.put("arrSecurity",arrRow);
			
			//Modification sought
			arrRow=new ArrayList();
			strQuery=SQLParser.getSqlQuery("sel_otrsancterms^"+strAppno);
			
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(correctNull(rs.getString("otrsancterms_slrno")));//0
				arrCol.add(correctNull(rs.getString("otrsancterms_terms")));//1
				arrCol.add(correctNull(rs.getString("otrsancterms_modification")));//2
				arrCol.add(correctNull(rs.getString("otrsancterms_justification")));//3
				arrRow.add(arrCol);
			}
			hshRecord.put("arrModification",arrRow);
			
			//Value of account
			arrRow=new ArrayList();
			rs=DBUtils.executeLAPSQuery("sel_valofacct^"+strAppno);
			
			while(rs.next())
			{
				arrCol = new ArrayList();						
				arrCol.add(correctNull(rs.getString("valofacct_previous")));
				arrCol.add(correctNull(rs.getString("valofacct_current")));
				arrRow.add(arrCol);	
			}
			hshRecord.put("arrValueofAcc",arrRow);
			
			
			//Regard to Margin and securities
			arrRow=new ArrayList();
			strQuery=SQLParser.getSqlQuery("sel_recommendations^"+strAppno);
			
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(correctNull(rs.getString("recmd_sancterms")));//0
				arrCol.add(correctNull(rs.getString("recmd_stipulated")));//1
				arrCol.add(correctNull(rs.getString("recmd_recommendRO")));//2
				arrCol.add(correctNull(rs.getString("recmd_recommendCO")));//3
				arrRow.add(arrCol);
			}
			hshRecord.put("arrMarginSec",arrRow);
			
			
			/*if(rs!=null)rs.close();
			
			strQuery=SQLParser.getSqlQuery("sel_MSTOrgDetails^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("orgname",correctNull(rs.getString("org_name")));
				hshRecord.put("orgadd1",correctNull(rs.getString("org_add1")));
				hshRecord.put("orgadd2",correctNull(rs.getString("org_add2")));
				hshRecord.put("orgcity",correctNull(rs.getString("city_name")));
				hshRecord.put("orgstate",correctNull(rs.getString("state_name")));
				hshRecord.put("orgzip",correctNull(rs.getString("org_zip")));
				hshRecord.put("orgphone",correctNull(rs.getString("org_phone")));
			}*/
			hshRecord.put("orgname",correctNull((String)hshValues.get("strOrgName")));
			if(rs!=null)rs.close();
			
			strQuery=SQLParser.getSqlQuery("selmstappdetails^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshValues.put("propappno",correctNull(rs.getString("mst_applicationno")));
			//	hshValues.put("valuesin",correctNull(rs.getString("mst_valuesin")));
			}
			
			
			hshRecord.putAll(getFinancialData(hshValues));
		}
		catch(Exception ex)
		{
			throw new EJBException("Error in getMSTApprovalprint  :: "+ex.toString());
		}
		return hshRecord;
	}
	
	
	public HashMap getFinancialData(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		ResultSet rs2 = null;
		ResultSet rs5 = null;
		ResultSet rs7 = null;	
		ResultSet rs10 = null;
		ResultSet rs11 = null;
		ResultSet rs12 = null;
		
		HashMap hshValues=null;
		
		ArrayList arr=new ArrayList();
		ArrayList arrVal=new ArrayList();
		
		String strQuery="";
		String strValue="";
		String sel_divID="";
		String page="";
		String strappno="";
		
		//int str=0;
		
		
	try
	{			
		strValue=correctNull((String)hshRequestValues.get("propappno"));
		strappno=correctNull((String)hshRequestValues.get("appno"));
		//String page = correctNull((String)hshRequestValues.get("flowtype"));
		//if(page.equals(""))
		//{
			page="MST";
	//	}
	
		sel_divID=correctNull((String)hshRequestValues.get("sel_divID"));
		if(sel_divID.equalsIgnoreCase("") || sel_divID.equalsIgnoreCase("null"))
		{
			sel_divID="0";
		}
		
		
		hshValues = new HashMap();
		ArrayList vecVal=new ArrayList();
		ArrayList vecVal1=new ArrayList();
		ArrayList vecVal2=new ArrayList();
		ArrayList vecVal3=new ArrayList();
		ArrayList vecVal4=new ArrayList();
		ArrayList vecVal5=new ArrayList();
		ArrayList vecVal41=new ArrayList();
		ArrayList vecVal51=new ArrayList();
		ArrayList vecVal6=new ArrayList();
		ArrayList vecVal7=new ArrayList();
	
		ArrayList vecrec=new ArrayList();
	
		ArrayList vecid = new ArrayList();
		ArrayList vecdesc = new ArrayList();
		ArrayList vectype = new ArrayList();

		

		//-------------- to find the time of review-----------------
	
		/*strQuery = SQLParser.getSqlQuery("executive_finselect1^"+strValue+"^"+sel_divID);
		if(rs!=null)
			rs.close();
		
		rs = DBUtils.executeQuery(strQuery);
		while(rs.next())
		{  
			str=rs.getInt("cnt");
		}*/
		

		//--------------- to find the cma format of the particular applications-------
		if(	rs!=null)
		{
			rs.close();
			
		}
		String cma="";
		strQuery=SQLParser.getSqlQuery("comfintrendsel1^"+strValue);
		
		if(rs!=null)
			rs.close();

		rs = DBUtils.executeQuery(strQuery);
			 
		if(rs.next())
		{  
			cma=rs.getString("demo_finstandard");
		}
		if (cma.trim().equals(""))
		{
			cma="4";
		}
			
		String strDate=""; 
		String strYear=""; 
		String strYear1="";
		String moncurryear="";
		int monthcurryear=0;
		
		strQuery = SQLParser.getSqlQuery("selmon_curyear");
			if(rs12!=null)
				rs12.close();
			rs12=DBUtils.executeQuery(strQuery);
			if(rs12.next())
			{
				moncurryear=rs12.getString("mon_curryear");
			}
			monthcurryear=Integer.parseInt(moncurryear);
		
			if (monthcurryear>3)
			{			
				strQuery = SQLParser.getSqlQuery("noteassessselect5");
				if(rs7!=null)
					rs7.close();
				
				rs7=DBUtils.executeQuery(strQuery);
				if(rs7.next())
				{
					strDate=rs7.getString("dat");
					String val=strDate.substring(6,10);					
					int valcon=Integer.parseInt(val)+1;
					val=Integer.toString(valcon);
					//strDate=val1.concat(val);					
					strYear=rs7.getString("txtyear");
					strYear1=rs7.getString("txtyear");					
				}
				
			}
					
			else
			{
				strQuery = SQLParser.getSqlQuery("noteassessselect5");
				if(rs7!=null)
					rs7.close();
				rs7=DBUtils.executeQuery(strQuery);
				if(rs7.next())
				{
					strDate=rs7.getString("dat");
					strYear=rs7.getString("txtyear");
					strYear1=rs7.getString("txtyear");					
				}
				
			}
		
			if(rs!=null)
			rs.close();
			
			String baseyear_query = SQLParser.getSqlQuery("sel_financial_baseyear^"+strValue);
			rs = DBUtils.executeQuery(baseyear_query);
			if(rs.next())
			{	
				strDate=Helper.correctNull((String)rs.getString("base_year"));
				strYear=Helper.correctNull((String)rs.getString("year"));
				strYear1=Helper.correctNull((String)rs.getString("year"));
			}
			if(rs!=null){
				rs.close();
			}
			
		strQuery = SQLParser.getSqlQuery("executive_finselect9^"+strValue+"^"+sel_divID+"^"+strDate);
		if(rs5!=null)
			rs5.close();
		rs5=DBUtils.executeQuery(strQuery);
		
		String strDesc="";
		String strCurDate="";
		if(rs5.next())
		{
			if(rs5.getDouble("sumaudit")>0)
			{
				strDesc="a";
			}
			else if(rs5.getDouble("sumunaudit")>0)
			{
				strDesc="u";
			}
			else if(rs5.getDouble("sumestimated")>0)
			{
				strDesc="e";
			}
			else if(rs5.getDouble("sumprojection")>0)
			{
				strDesc="p";
			}
			strCurDate=rs5.getString("fin_year");

		}
			strQuery = SQLParser.getSqlQuery("noteassessselect10^"+strValue+"^"+sel_divID);
			if(rs10!=null)
				rs10.close();
			rs10=DBUtils.executeQuery(strQuery);
			
			
		while(rs10.next())
		{
			arr=new ArrayList();
			arr.add(rs10.getString(1));
			arrVal.add(arr);
		}			

		
		int checkYear=0;
		int count=0;
		String strPrevDesc="";
		String strPrevDate="";
		String strPrevDesc1="";
		String strPrevDate1="";
		checkYear=Integer.parseInt(strYear);
      	for(int x=1;x<=arrVal.size();x++)
    	{
			count=count+1;			
			if(count>2)				
			break;
			
			checkYear=checkYear-1;
			
			strQuery = SQLParser.getSqlQuery("executive_finselect11^"+strValue+"^"+sel_divID+"^"+checkYear);
			if(rs11!=null)
				rs11.close();
			rs11=DBUtils.executeQuery(strQuery);
			if(rs11.next())
			{
				if(rs11.getDouble("sumaudit")>0)
				{
					strPrevDesc="a";
				}
				else if(rs11.getDouble("sumunaudit")>0)
				{
					strPrevDesc="u";
				}
				else if(rs11.getDouble("sumestimated")>0)
				{
					strPrevDesc="e";
				}
				else if(rs11.getDouble("sumprojection")>0)
				{
					strPrevDesc="p";
				}
				strPrevDate=rs11.getString("fin_year");

			}
			else
			{
				strPrevDate="";
				strPrevDesc="";
			}
			if(!strPrevDesc.trim().equals("") && strPrevDate1.trim().equals(""))
			{
				strPrevDate1=strPrevDate;
				strPrevDesc1=strPrevDesc;				
			}
	}

			
			int chkYear=0;			
			String strNextDesc="";
			String strNextDate="";	
			String strNextDesc2="";
			String strNextDate2="";
			chkYear=Integer.parseInt(strYear1);
			
	for(int y=1;y<=2;y++)
	{
			chkYear=chkYear+1;
			strQuery = SQLParser.getSqlQuery("executive_finselect11^"+strValue+"^"+sel_divID+"^"+chkYear);
			if(rs12!=null)
				rs12.close();
			rs12=DBUtils.executeQuery(strQuery);
			if(rs12.next())
			{
				if(rs12.getDouble("sumaudit")>0)
				{
					strNextDesc="a";
				}
				else if(rs12.getDouble("sumunaudit")>0)
				{
					strNextDesc="u";
				}
				else if(rs12.getDouble("sumestimated")>0)
				{
					strNextDesc="e";
				}
				else if(rs12.getDouble("sumprojection")>0)
				{
					strNextDesc="p";
				}
				strNextDate=rs12.getString("fin_year");

			}
			else
			{
				strNextDate="";
				strNextDesc="";
			}
			if(!strNextDesc.trim().equals("") && strNextDate2.trim().equals(""))
			{
				strNextDate2=strNextDate;
				strNextDesc2=strNextDesc;				
			}
			
			
	}

				strQuery = SQLParser.getSqlQuery("noteassessselect1^"+cma+"^"+page);
				
				if(rs2!=null)
					rs2.close();
				rs2=DBUtils.executeQuery(strQuery);
				String strRowtype="";
				//String strRowid="";
				int strRowformula=0;
				int strRowformula2=0;
				vecVal  = new ArrayList();
				vecVal1 = new ArrayList();
				vecVal2 = new ArrayList();
				vecVal3 = new ArrayList();
				vecVal4 = new ArrayList();
				vecVal5 = new ArrayList();
				vecVal41 = new ArrayList();
				vecVal51 = new ArrayList();
				vecVal6 = new ArrayList();
				vecVal7 = new ArrayList();
				vecid   = new ArrayList();
				vecdesc = new ArrayList();
				vectype = new ArrayList();
				while (rs2.next())
				{
					strRowtype=correctNull(rs2.getString("fin_rowtype"));
				//	strRowid=correctNull(rs2.getString("fin_rowid"));
					strRowformula=rs2.getInt("fin_formula");
					strRowformula2=rs2.getInt("fin_formula2");
					vectype.add(strRowtype);
					
					String strX="";
					
					if ((strRowtype.trim().equals("FO") || strRowtype.trim().equals("C")) && strRowformula>0 && !strDesc.trim().equals(""))
					{						
						HashMap hshformula =  new HashMap();
						hshformula.put("appno",strValue);
						hshformula.put("sel_divID",sel_divID);
						hshformula.put("formulaid",Integer.toString(strRowformula));
						hshformula.put("curryear",strCurDate);
						hshformula.put("prevyear","");
						hshformula.put("currfinancialtype",strDesc);
						hshformula.put("prevfinancialtype","");
						HashMap hshRes = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula,"GetFinValue");
						strX=correctNull((String)hshRes.get("strTotalValue"));
						vecVal.add(strX);
						vecid.add(correctNull(rs2.getString("fin_rowid")));
						vecdesc.add(correctNull(rs2.getString("fin_rowdesc")));
						
					}// if IC

					else
					{
						vecVal.add("0.00");
						vecid.add(correctNull(rs2.getString("fin_rowid")));
						vecdesc.add(correctNull(rs2.getString("fin_rowdesc")));
					}
						
						String strY="";
					 if ((strRowtype.trim().equals("FO") || strRowtype.trim().equals("C"))&& strRowformula2>0 && !strDesc.trim().equals(""))
					{
						
						HashMap hshformula1 =  new HashMap();
						hshformula1.put("appno",strValue);
						hshformula1.put("sel_divID",sel_divID);
						hshformula1.put("formulaid",Integer.toString(strRowformula2));
						hshformula1.put("curryear",strCurDate);
						hshformula1.put("prevyear","");
						hshformula1.put("currfinancialtype",strDesc);
						hshformula1.put("prevfinancialtype","");
						HashMap hshRes1 = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula1,"GetFinValue");
						strY = correctNull((String)hshRes1.get("strTotalValue"));						
						vecVal1.add(strY);
					}
					else
					{
							vecVal1.add("0.00");
					}
					// for prev year
					
					String strZ="";
					
					if ( (strRowtype.trim().equals("FO")|| strRowtype.trim().equals("C")) && strRowformula>0 && !strPrevDesc.trim().equals(""))
					{
						
						HashMap hshformula =  new HashMap();
						hshformula.put("appno",strValue);
						hshformula.put("sel_divID",sel_divID);
						hshformula.put("formulaid",Integer.toString(strRowformula));
						hshformula.put("curryear",strPrevDate);
						hshformula.put("prevyear","");
						hshformula.put("currfinancialtype",strPrevDesc);
						hshformula.put("prevfinancialtype","");
						HashMap hshRes2 = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula,"GetFinValue");
						strZ = correctNull((String)hshRes2.get("strTotalValue"));
						vecVal2.add(strZ);
					}// if IC

					else
					{
						vecVal2.add("0.00");						
					}
							
						String strA="";
					 if ((strRowtype.trim().equals("FO")|| strRowtype.trim().equals("C")) && strRowformula2>0 && !strPrevDesc.trim().equals(""))
					{
						
						HashMap hshformula1 =  new HashMap();
						hshformula1.put("appno",strValue);
						hshformula1.put("sel_divID",sel_divID);
						hshformula1.put("formulaid",Integer.toString(strRowformula2));
						hshformula1.put("curryear",strPrevDate);
						hshformula1.put("prevyear","");
						hshformula1.put("currfinancialtype",strPrevDesc);
						hshformula1.put("prevfinancialtype","");
						HashMap hshRes3 = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula1,"GetFinValue");
						strA = correctNull((String)hshRes3.get("strTotalValue"));
						vecVal3.add(strA);
					}
					else
					{
							vecVal3.add("0.00");
					}
						// for prev2 year
						
						String strZ1="";						
					if ((strRowtype.trim().equals("FO")|| strRowtype.trim().equals("C"))&& strRowformula>0 && !strPrevDesc1.trim().equals(""))
					{
						HashMap hshformula =  new HashMap();
						hshformula.put("appno",strValue);
						hshformula.put("sel_divID",sel_divID);
						hshformula.put("formulaid",Integer.toString(strRowformula));
						hshformula.put("curryear",strPrevDate1);
						hshformula.put("prevyear","");
						hshformula.put("currfinancialtype",strPrevDesc1);
						hshformula.put("prevfinancialtype","");
						HashMap hshRes2 = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula,"GetFinValue");
						strZ1= correctNull((String)hshRes2.get("strTotalValue"));
						vecVal6.add(strZ1);
					}// if IC

					else
					{
						vecVal6.add("0.00");
						
					}
						
						String strA1="";
					 if ((strRowtype.trim().equals("FO")|| strRowtype.trim().equals("C")) && strRowformula2>0 && !strPrevDesc1.trim().equals(""))
					{
						
						HashMap hshformula1 =  new HashMap();
						hshformula1.put("appno",strValue);
						hshformula1.put("sel_divID",sel_divID);
						hshformula1.put("formulaid",Integer.toString(strRowformula2));
						hshformula1.put("curryear",strPrevDate1);
						hshformula1.put("prevyear","");
						hshformula1.put("currfinancialtype",strPrevDesc1);
						hshformula1.put("prevfinancialtype","");
						HashMap hshRes3a = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula1,"GetFinValue");
						strA1 = correctNull((String)hshRes3a.get("strTotalValue"));
						vecVal7.add(strA1);
					}
					else
					{
							vecVal7.add("0.00");
					}

						// for next year
										
						String strB1="0.00";
						
					if ((strRowtype.trim().equals("FO")|| strRowtype.trim().equals("C")) && strRowformula>0 && !strNextDesc.trim().equals(""))
					{
						
						HashMap hshformula =  new HashMap();
						hshformula.put("appno",strValue);
						hshformula.put("sel_divID",sel_divID);
						hshformula.put("formulaid",Integer.toString(strRowformula));
						hshformula.put("curryear",strNextDate);
						hshformula.put("prevyear","");
						hshformula.put("currfinancialtype",strNextDesc);
						hshformula.put("prevfinancialtype","");
						HashMap hshRes4 = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula,"GetFinValue");
						strB1 = correctNull((String)hshRes4.get("strTotalValue"));
						vecVal4.add(strB1);
					}// if IC

					else
					{
						vecVal4.add("0.00");
						
					}
						String strT1 = "0.00";
									
					 if ((strRowtype.trim().equals("FO") || strRowtype.trim().equals("C"))&& strRowformula2>0 && !strNextDesc.trim().equals(""))
					{
						
						HashMap hshformula1 =  new HashMap();
						hshformula1.put("appno",strValue);
						hshformula1.put("sel_divID",sel_divID);
						hshformula1.put("formulaid",Integer.toString(strRowformula2));
						hshformula1.put("curryear",strNextDate);
						hshformula1.put("prevyear","");
						hshformula1.put("currfinancialtype",strNextDesc);
						hshformula1.put("prevfinancialtype","");
						HashMap hshRes5 = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula1,"GetFinValue");
						strT1=correctNull((String)hshRes5.get("strTotalValue"));
						vecVal5.add(strT1);
					}
					else
					{
							vecVal5.add("0.00");
					}
					
					// for next year
						
						String strB2="0.00";
						
					if ((strRowtype.trim().equals("FO")|| strRowtype.trim().equals("C")) && strRowformula>0 && !strNextDesc2.trim().equals(""))
					{
						
						HashMap hshformula =  new HashMap();
						hshformula.put("appno",strValue);
						hshformula.put("sel_divID",sel_divID);
						hshformula.put("formulaid",Integer.toString(strRowformula));
						hshformula.put("curryear",strNextDate2);
						hshformula.put("prevyear","");
						hshformula.put("currfinancialtype",strNextDesc2);
						hshformula.put("prevfinancialtype","");
						HashMap hshRes4 = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula,"GetFinValue");
						strB2 = correctNull((String)hshRes4.get("strTotalValue"));
						vecVal41.add(strB2);
					}// if IC

					else
					{
						vecVal41.add("0.00");
						
					}
						String strT2 = "0.00";
									
					 if ((strRowtype.trim().equals("FO") || strRowtype.trim().equals("C"))&& strRowformula2>0 && !strNextDesc2.trim().equals(""))
					{
						
						HashMap hshformula1 =  new HashMap();
						hshformula1.put("appno",strValue);
						hshformula1.put("sel_divID",sel_divID);
						hshformula1.put("formulaid",Integer.toString(strRowformula2));
						hshformula1.put("curryear",strNextDate2);
						hshformula1.put("prevyear","");
						hshformula1.put("currfinancialtype",strNextDesc2);
						hshformula1.put("prevfinancialtype","");
						HashMap hshRes5 = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula1,"GetFinValue");
						strT2=correctNull((String)hshRes5.get("strTotalValue"));
						vecVal51.add(strT2);
					}
					else
					{
							vecVal51.add("0.00");
					}
				}
				//while rs2
				

					hshValues.put("year",vecVal);	
					hshValues.put("yearhold",vecVal1);
					hshValues.put("prevyear",vecVal2);	
					hshValues.put("prevyearhold",vecVal3);	
					hshValues.put("nextyear2",vecVal4);	
					hshValues.put("nextyearhold2",vecVal5);
					hshValues.put("nextyear",vecVal41);	
					hshValues.put("nextyearhold",vecVal51);
					hshValues.put("prevyear1",vecVal5);	
					hshValues.put("prevyearhold1",vecVal6);	
					hshValues.put("vecid",vecid);
					hshValues.put("vecdesc",vecdesc);
					hshValues.put("vectype",vectype);
					hshValues.put("sel_divID",sel_divID);
					
					if(!strCurDate.trim().equals(""))
						
					{
						vecrec.add(strCurDate);
					}

					else 
					{
						strDate=strDate.substring(6,10);
						vecrec.add(strDate);
					}
						vecrec.add(strDesc);
						vecrec.add(strPrevDate);
						vecrec.add(strPrevDesc);	
						vecrec.add(strNextDate2);
						vecrec.add(strNextDesc2);	
						vecrec.add(strPrevDate1);
						vecrec.add(strPrevDesc1);
						vecrec.add(strNextDate);
						vecrec.add(strNextDesc);

					hshValues.put("yearvalue",vecrec);
					hshValues.put("page",page); //old one
					
					strQuery = SQLParser.getSqlQuery("sel_mstfincomments^"+strappno+"^"+page+"^"+sel_divID);
					if(rs5!=null)
						rs5.close();
					rs5=DBUtils.executeQuery(strQuery);
					if(rs5.next())
					{
						hshValues.put("comments",correctNull(Helper.CLOBToString(rs5.getClob("fin_comments"))));
					}
					

	}
		catch(Exception ce)
		{
				throw new EJBException("Error in getData login  "+ce.toString());
		}
		finally
		{
			try
			{	
				if(rs != null)
					rs.close();
				if(rs2 != null)
					rs2.close();
				if(rs5 != null)
					rs5.close();
				if(rs7 != null)
					rs7.close();
				if(rs10 != null)
					rs10.close();
				if(rs11 != null)
					rs11.close();
				if(rs12 != null)
					rs12.close();
			
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
			
			return hshValues; 
	}
	
	
	public void updateFinancial(HashMap hshValues) 
	{
		ResultSet rs = null;
		
		HashMap hshQuery = null;
		HashMap hshQueryValues = null;
		
		ArrayList arrValues = new ArrayList();
		
		String strAppno = "";
		String sel_divID = "";
		String notes = "";
		String hidAction ="";
		String page = "";
		
		int intUpdatesize = 0;

		try 
		{
			hshQueryValues = new HashMap();
			
			strAppno = correctNull((String) hshValues.get("appno"));
			page = correctNull((String) hshValues.get("flowtype"));
			sel_divID = correctNull((String) hshValues.get("sel_divID"));
			notes = correctNull((String) hshValues.get("exec_notes"));
		    hidAction=correctNull((String) hshValues.get("hidAction"));
		    
			if (sel_divID.equalsIgnoreCase("")|| sel_divID.equalsIgnoreCase("null")) 
			{
				sel_divID = "0";
			}

			if (hidAction.equalsIgnoreCase("Update"))
			{
			
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					arrValues.add(strAppno);
					arrValues.add(page);
					arrValues.add(sel_divID);
					hshQuery.put("arrValues", arrValues);
					hshQuery.put("strQueryId", "del_mstfincomments");
					intUpdatesize = intUpdatesize + 1;
					hshQueryValues.put(Integer.toString(intUpdatesize),	hshQuery);
					hshQueryValues.put("size", Integer.toString(intUpdatesize));

					hshQuery = new HashMap();
					arrValues = new ArrayList();
					arrValues.add(strAppno);
					arrValues.add(page);
					arrValues.add(sel_divID);
					arrValues.add(notes);
					hshQuery.put("arrValues", arrValues);
					hshQuery.put("strQueryId", "ins_mstfincomments");
					intUpdatesize = intUpdatesize + 1;
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					hshQueryValues.put("size", Integer.toString(intUpdatesize));

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			else if (hidAction.equalsIgnoreCase("Delete"))
			{
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strAppno);
				arrValues.add(page);
				arrValues.add(sel_divID);
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "del_mstfincomments");
				intUpdatesize = intUpdatesize + 1;
				hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}

		} 
		catch (Exception ce)
		{
			throw new EJBException("Error in updateFinancial login  " + ce.toString());
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
			catch (Exception cf) 
			{
				throw new EJBException("Error closing the connection "	+ cf.getMessage());
			}
		}
	}
	
	private String getMaxsecno(String strAppno) 
	{
		String strSecno="";
		ResultSet rs=null;
		String strQuery="";
		try
		{
			strQuery=SQLParser.getSqlQuery("selmax_mstsecdetails^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strSecno=rs.getString("snomax");
			}
			
		}catch(Exception ex)
		{
			throw new EJBException("Error in getMaxsecno :: "+ex.toString());
		}
		finally
		{
			try{
				if(rs!=null)
					rs.close();
			}catch(Exception ex)
			{
				throw new EJBException("Error in Closing Connection"+ex.toString());
			}
		}
		return strSecno;
	}
	
	
	/*private String getMaxfacilityId(String appno)
	{
		String strSno="";
		ResultSet rs=null;
		try
		{
				rs=DBUtils.executeLAPSQuery("sel_mstfacilityMaxid^"+appno);
				if(rs.next())
				{
					strSno = correctNull(rs.getString("facilityid"));
				}
		}
		catch(Exception Ex)
		{
			throw new EJBException(Ex.getMessage());
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
		return strSno;
	}*/
	
	private int getLimitCode()
	{		
		String strQuery="";
		ResultSet rs = null;
		int limitid = 0;
		try
		{				
			strQuery = SQLParser.getSqlQuery("maxlimitid");
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				limitid = rs.getInt(1);
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getLimitCode "+ce.toString());
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
		return limitid;
	}
	
	private String getMSTAppno(String strSolid)
	{
		String strappno="";
		int appno=0;
		String strQuery="";
		java.text.NumberFormat nf=java.text.NumberFormat.getNumberInstance();
		nf.setMinimumIntegerDigits(7);
		nf.setGroupingUsed(false);
		
		ResultSet rs=null;
		try
		{
				strQuery=SQLParser.getSqlQuery("selmstappno^"+strSolid);

				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					appno = (rs.getInt("appno"));
				}
				appno++;
				strappno=strSolid+2+nf.format(appno);
		}
		catch(Exception Ex)
		{
			throw new EJBException(Ex.getMessage());
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
		return strappno;
	}
	
	
	/*	public HashMap getFacilityName(HashMap hshValues) 
	{	
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList arrFacsno= new ArrayList();
		ArrayList arrFacdesc= new ArrayList();	
		String strFachead="";
		String strQuery="";
		try
		{	
			String appno= correctNull((String)hshValues.get("appno"));
			strFachead= correctNull((String)hshValues.get("facilityhead"));
			if(!strFachead.equals("S"))
			{
				strQuery=SQLParser.getSqlQuery("sel_facilityformodification^"+appno+"^"+strFachead);
				rs=DBUtils.executeQuery(strQuery);
			
				hshRecord = new HashMap();
				while(rs.next())
				{
					arrFacsno.add(correctNull(rs.getString("mstfacilities_sno")));
					arrFacdesc.add(correctNull(rs.getString("facility_catdesc")) +" - "+Helper.formatDoubleValue(rs.getDouble("mstfacilities_sanclimit")));
				}
				hshRecord.put("arrFacsno",arrFacsno);	
				hshRecord.put("arrFacdesc",arrFacdesc);
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getFacilityName "+ce.toString());
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
}