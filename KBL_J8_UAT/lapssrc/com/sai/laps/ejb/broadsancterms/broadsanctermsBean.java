package com.sai.laps.ejb.broadsancterms;

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
import com.sai.laps.tagdatahelper.TagDataHelperBST;

@Stateless(name = "broadsanctermsBean", mappedName = "broadsanctermsHome")
@Remote (broadsanctermsRemote.class)
public class broadsanctermsBean extends BeanAdapter
{
	static Logger log=Logger.getLogger(broadsanctermsBean.class);
	/**
	 * 
	 */
	private static final long serialVersionUID = 3116615463020157047L;

	public HashMap getData(HashMap hshValues)
	{

		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList arr = null;
		String strQuery="";		
		try
		{
			hshRecord = new HashMap();
			arr =  new ArrayList();
			strQuery = SQLParser.getSqlQuery("glpoption");
			rs =DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				arr.add(Helper.correctNull(rs.getString(1)));	
				arr.add(Helper.correctNull(rs.getString(2)));	
				arr.add(Helper.correctNull(rs.getString(3)));	
				arr.add(Helper.correctNull(rs.getString(4)));	
				arr.add(Helper.correctNull(rs.getString(5)));	
				arr.add(Helper.correctNull(rs.getString(6)));	
			}
			hshRecord.put("arr",arr);				
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
	
	public void updateBroadTermsProposalFinancial(HashMap hsh) 
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshQuery ;
		ArrayList arr = new ArrayList();
		ResultSet rs=null;
		String val="";
		String appno="";
		try
		{
			val=(String)hsh.get("hidAction");
			appno=(String)hsh.get("appno");

			String []first_year=null;	
			String []second_year=null;
			String []third_year=null;
			String []desc=null;
			int intUpdatesize=0;
			
			if (val.equals("update"))
			{
				
				first_year= (String [])hsh.get("txt_firstyear");
				second_year= (String [])hsh.get("txt_secondyear");
				third_year= (String [])hsh.get("txt_thirdyear");
				desc= (String [])hsh.get("hid_desc");
				hshQuery = new HashMap();
				int len=first_year.length;
			
				hshQuery = new HashMap();
				hshqueryval = new HashMap();
				arr=new ArrayList();
				intUpdatesize=intUpdatesize+1;
				hshQuery.put("strQueryId","del_broadtermsfin");
				arr.add(appno);
				hshQuery.put("arrValues",arr);
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);
				
				hshQuery = new HashMap();
				arr=new ArrayList();
				intUpdatesize=intUpdatesize+1;
				hshQuery.put("strQueryId","del_broadtermscomments");
				arr.add(appno);
				arr.add("broadtermscomments");
				arr.add(correctNull((String)hsh.get("sel_level")));
				hshQuery.put("arrValues",arr);
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);
				
				for(int k=0;k<len;k++)
				{				
						hshQuery = new HashMap();
						arr=new ArrayList();
						intUpdatesize=intUpdatesize+1;
						hshQuery.put("strQueryId","ins_broadtermsfin");
						
						arr.add(appno);
						arr.add(Integer.toString(k));
						arr.add(correctNull((String)first_year[k]));
						arr.add(correctNull((String)second_year[k]));
						arr.add(correctNull((String)third_year[k]));
						arr.add(correctNull((String)desc[k]));
						hshQuery.put("arrValues",arr);						
						hshqueryval.put("size",Integer.toString(intUpdatesize));
						hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);	
				}	
				
				
				hshQuery = new HashMap();
				arr=new ArrayList();
				intUpdatesize=intUpdatesize+1;
				hshQuery.put("strQueryId","ins_broadtermscomments");
				arr.add(appno);
				arr.add("broadtermscomments");
				arr.add(Helper.correctNull((String)hsh.get("comments")));
				arr.add(correctNull((String)hsh.get("sel_level")));
				
				hshQuery.put("arrValues",arr);
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);
			}
			else if(val.equals("delete"))
			{
				hshQuery = new HashMap();
				hshqueryval = new HashMap();
				arr=new ArrayList();
				intUpdatesize=intUpdatesize+1;
				hshQuery.put("strQueryId","del_broadtermsfin");
				arr.add(appno);
				hshQuery.put("arrValues",arr);
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);
				
				hshQuery = new HashMap();
				arr=new ArrayList();
				intUpdatesize=intUpdatesize+1;
				hshQuery.put("strQueryId","del_broadtermscomments");
				arr.add(appno);
				arr.add("broadtermscomments");
				arr.add(correctNull((String)hsh.get("sel_level")));
				hshQuery.put("arrValues",arr);
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
	
	public HashMap getBroadTermsProposalFinancial(HashMap hsh) 
	{
		ResultSet rs=null;		
		HashMap hshValues = new HashMap();
		ArrayList arrVal = new ArrayList();
		ArrayList arrRec= new ArrayList();
		String appno="";
		String strQuery="";
		try
		{
			appno=(String)hsh.get("appno");
			rs=DBUtils.executeLAPSQuery("sel_broadtermsfin^"+appno);
			
			while(rs.next())
			{
				arrRec = new ArrayList();						
				arrRec.add(correctNull(rs.getString("broadtermsfinfirstyear")));
				arrRec.add(correctNull(rs.getString("broadtermsfinsecondyear")));
				arrRec.add(correctNull(rs.getString("broadtermsfinthirdyear")));
				arrRec.add(correctNull(rs.getString("broadtermsfinrowdesc")));
				arrVal.add(arrRec);	
			}
			

			strQuery = SQLParser.getSqlQuery("sel_broadtermscomments^"+appno+"^"+"'"+"broadtermscomments"+"'");
			rs = DBUtils.executeQuery(strQuery);	
			if(rs.next())
			{
				hshValues.put("comments",correctNull(Helper.CLOBToString((rs.getClob("com_broadtermscomments")))));
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
	
	public void updateBroadTermsProposalComments(HashMap hsh) 
	{
 		HashMap hshqueryval = new HashMap();
		HashMap hshQuery ;
		ArrayList arr = new ArrayList();
		ResultSet rs=null;
		String val="";
		String appno="";
		String strdesc=null;
		String[] strpagedesc=null;
		String[] comments=null;	
		String strlevel=null;
		int len=0;
		try
		{
			val=(String)hsh.get("hidAction");
			appno=(String)hsh.get("appno");

			if(hsh.get("comments") instanceof java.lang.String)
			{
				comments= new String[1];
				comments[0]=(String)hsh.get("comments");
			}
			else
			{
				comments= (String[])hsh.get("comments");
			}
			strdesc= (String)hsh.get("hidpagedesc");
			strlevel= (String)hsh.get("sel_level");
			strdesc=strdesc.replace("'","");
		    strpagedesc=strdesc.split(",");
		
			int intUpdatesize=0;
			len = comments.length;
			if (val.equals("update"))
			{
				
				
				hshqueryval = new HashMap();
				for(int k=0;k<len;k++)
				{
					hshQuery = new HashMap();
					hshQuery = new HashMap();
					arr=new ArrayList();
					intUpdatesize=intUpdatesize+1;
					hshQuery.put("strQueryId","del_broadtermscomments");
					arr.add(appno);
					arr.add(strpagedesc[k]);
					arr.add(strlevel);
					hshQuery.put("arrValues",arr);
					hshqueryval.put("size",Integer.toString(intUpdatesize));
					hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);
				}
				
				for(int k=0;k<len;k++)
				{				
						hshQuery = new HashMap();
						arr=new ArrayList();
						intUpdatesize=intUpdatesize+1;
						hshQuery.put("strQueryId","ins_broadtermscomments");
						
						arr.add(appno);
						arr.add(strpagedesc[k]);
						arr.add(comments[k]);
						arr.add(strlevel);
						hshQuery.put("arrValues",arr);						
						hshqueryval.put("size",Integer.toString(intUpdatesize));
						hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);	
				}	
			}
			else if(val.equals("delete"))
			{
				hshqueryval = new HashMap();
				for(int k=0;k<len;k++)
				{
				hshQuery = new HashMap();
				arr=new ArrayList();
				intUpdatesize=intUpdatesize+1;
				hshQuery.put("strQueryId","del_broadtermscomments");
				arr.add(appno);
				arr.add(strpagedesc[k]);
				arr.add(strlevel);
				hshQuery.put("arrValues",arr);
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);
				}
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
	
	public HashMap getBroadTermsProposalComments(HashMap hsh) 
	{
		ResultSet rs=null;		
		HashMap hshValues = new HashMap();
		String appno="";
		String desc="";
		String strQuery="";
		String strLevel="";
		boolean flag=false;
		try
		{
			appno=(String)hsh.get("appno");
			desc=correctNull((String)hsh.get("hidpage"));
			if(desc.equalsIgnoreCase(""))
			{
				desc=correctNull((String)hsh.get("hidpagedesc"));
			}
			desc=desc.replaceAll("~","','");
			strLevel=correctNull((String)hsh.get("sel_level"));
			
			
			if(desc.equalsIgnoreCase("branchcomments") || desc.equalsIgnoreCase("repayment','prepayment"))
			{
				strQuery = SQLParser.getSqlQuery("bstbrncomments^"+appno+"^'"+desc+"'"+"^"+strLevel);
				
				rs = DBUtils.executeQuery(strQuery);	
				
				while(rs.next())
				{
					flag=true;
					if(correctNull((String)rs.getString("com_broadtermstype")).equalsIgnoreCase("branchcomments"))
					{
					hshValues.put("branch_comments",Helper.CLOBToString(rs.getClob("com_broadtermscomments")));
					}
					else if(correctNull((String)rs.getString("com_broadtermstype")).equalsIgnoreCase("repayment"))
					{
						hshValues.put("repayment_comments",Helper.CLOBToString(rs.getClob("com_broadtermscomments")));
					}
					else if(correctNull((String)rs.getString("com_broadtermstype")).equalsIgnoreCase("prepayment"))
					{
						hshValues.put("prepayment_comments",Helper.CLOBToString(rs.getClob("com_broadtermscomments")));
					}
					hshValues.put("branch_level",correctNull(rs.getString("com_broadtermsseltype")));
				}
				if(flag==false)
				{
				hshValues.put("branch_level",strLevel);
				}
				
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("sel_broadtermscomments^"+appno+"^'"+desc+"'");
			
				rs = DBUtils.executeQuery(strQuery);	
				while(rs.next())
				{
					if(correctNull((String)rs.getString("com_broadtermstype")).equalsIgnoreCase("loanpolicy"))
					{
						hshValues.put("loanpolicy_comments",Helper.CLOBToString(rs.getClob("com_broadtermscomments")));
					}
					else if(correctNull((String)rs.getString("com_broadtermstype")).equalsIgnoreCase("datebst"))
					{
						hshValues.put("datebst",Helper.CLOBToString(rs.getClob("com_broadtermscomments")));
					}
					else if(correctNull((String)rs.getString("com_broadtermstype")).equalsIgnoreCase("customerprofitability"))
					{
						hshValues.put("customerprofitability_comments",Helper.CLOBToString(rs.getClob("com_broadtermscomments")));
					}
					else if(correctNull((String)rs.getString("com_broadtermstype")).equalsIgnoreCase("creditrating"))
					{
						hshValues.put("creditrating",Helper.CLOBToString(rs.getClob("com_broadtermscomments")));
					}
					else if(correctNull((String)rs.getString("com_broadtermstype")).equalsIgnoreCase("promotorsbackground"))
					{
						hshValues.put("promotorsbackground_comments",Helper.CLOBToString(rs.getClob("com_broadtermscomments")));
					}
					else if(correctNull((String)rs.getString("com_broadtermstype")).equalsIgnoreCase("procfees"))
					{
						hshValues.put("procfees",Helper.CLOBToString(rs.getClob("com_broadtermscomments")));
					}
					else if(correctNull((String)rs.getString("com_broadtermstype")).equalsIgnoreCase("projectnature"))
					{
						hshValues.put("projectnature_comments",Helper.CLOBToString(rs.getClob("com_broadtermscomments")));
					}
					else if(correctNull((String)rs.getString("com_broadtermstype")).equalsIgnoreCase("guarantee"))
					{
						hshValues.put("guarantee_comments",Helper.CLOBToString(rs.getClob("com_broadtermscomments")));
					}
					else if(correctNull((String)rs.getString("com_broadtermstype")).equalsIgnoreCase("refno"))
					{
						hshValues.put("refno",Helper.CLOBToString(rs.getClob("com_broadtermscomments")));
						hshValues.put("sancauth",correctNull(rs.getString("com_broadtermsseltype")));
					}
					else if(correctNull((String)rs.getString("com_broadtermstype")).equalsIgnoreCase("signatures"))
					{
						hshValues.put("signatures",Helper.CLOBToString(rs.getClob("com_broadtermscomments")));
					}
					
				}
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
		return hshValues;		
	}
	
	public void updateBSTCustProfitData(HashMap hshValues)
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs=null;
		
		String strAppno="",strQuery="";
		String strAction="";
		int intUpdatesize=0;
		try
		{
			strAction=correctNull((String)hshValues.get("hidAction"));
			strAppno=correctNull((String)hshValues.get("appno"));
			// For Audit Trial
				strQuery=SQLParser.getSqlQuery("sel_bstcustprofit^"+strAppno);
				
				rs=DBUtils.executeQuery(strQuery);
			
				if(rs.next())
				{
					hshValues.put("strAction","Update");
				}
			//End
			if(strAction.equals("Insert"))
			{
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				intUpdatesize++;
				
				arrValues.add(strAppno);
				hshQuery.put("strQueryId","del_bstcustprofit");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
				
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				intUpdatesize++;
			
				arrValues.add(strAppno);
				arrValues.add(correctNull((String)hshValues.get("txt_billscommission")));
				arrValues.add(correctNull((String)hshValues.get("txt_processcharges")));
				arrValues.add(correctNull((String)hshValues.get("txt_lgcommission")));
				arrValues.add(correctNull((String)hshValues.get("txt_sb")));
				arrValues.add(correctNull((String)hshValues.get("txt_cd")));
				arrValues.add(correctNull((String)hshValues.get("txt_ownsources")));
				arrValues.add(correctNull((String)hshValues.get("txt_thridparty")));
				hshQuery.put("strQueryId","ins_bstcustprofit");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
			}
			else if(strAction.equals("Delete"))
			{
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				intUpdatesize++;
				
				arrValues.add(strAppno);
				hshQuery.put("strQueryId","del_bstcustprofit");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
				hshValues.put("strAction","Delete");
			}
			hshQueryValues.put("size",""+intUpdatesize);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			//Audit Trail Starts Here
			StringBuilder sbAt = new StringBuilder();
			if(!strAction.equals("Delete"))
			{
				sbAt.append("Commission earned on bills purchased/discounted =").append(correctNull((String)hshValues.get("txt_billscommission")));
				sbAt.append(" ~Processing Charges  = ").append(correctNull((String)hshValues.get("txt_processcharges")));
				sbAt.append(" ~Commission on LC/LG = ").append(correctNull((String)hshValues.get("txt_lgcommission")));
				sbAt.append(" ~Credit balances in SB = ").append(correctNull((String)hshValues.get("txt_sb")));
				sbAt.append(" ~Credit balances in CD= ").append(correctNull((String)hshValues.get("txt_cd")));
				sbAt.append(" ~Term deposits Through own sources= ").append(correctNull((String)hshValues.get("txt_ownsources")));
				sbAt.append(" ~Term deposits Through thrid Party = ").append(correctNull((String)hshValues.get("txt_thridparty")));
			}
				AuditTrial.auditLog(hshValues,"294",strAppno,sbAt.toString());
		}
		catch(Exception ex)
		{
			throw new EJBException("Error in updateBSTCustProfitData :: "+ex.toString());
		}
	}
	
	
	public HashMap getBSTCustProfitData(HashMap hshValues)
	{
		HashMap hshRecord=null;
		
		ResultSet rs=null;
		
		String strAppno="";
		String strQuery="";
		boolean recordflag=false;
		try
		{
			hshRecord=new HashMap();
			strAppno=correctNull((String)hshValues.get("appno"));
			
				strQuery=SQLParser.getSqlQuery("sel_bstcustprofit^"+strAppno);
				
				rs=DBUtils.executeQuery(strQuery);
			
				if(rs.next())
				{
					hshRecord.put("bstcpappno",correctNull(rs.getString("bstcp_appno")));
					hshRecord.put("bstcpbillscommission",correctNull(rs.getString("bstcp_billscommission")));
					hshRecord.put("bstcpprocesscharges",correctNull(rs.getString("bstcp_processcharges")));
					hshRecord.put("bstcplgcommission",correctNull(rs.getString("bstcp_lgcommission")));
					hshRecord.put("bstcpsb",correctNull(rs.getString("bstcp_sb")));
					hshRecord.put("bstcpcd",correctNull(rs.getString("bstcp_cd")));
					hshRecord.put("bstcpownsources",correctNull(rs.getString("bstcp_ownsources")));
					hshRecord.put("bstcpthirdparty",correctNull(rs.getString("bstcp_thirdparty")));
					recordflag=true;
				}
				 if(recordflag)
					hshRecord.put("recordflag","Y");
				else
					hshRecord.put("recordflag","N");
		}
		catch(Exception ex)
		{
			throw new EJBException("Error in getBSTCustProfitData  :: "+ex.toString());
		}
		return hshRecord;
	}
	
	
	public HashMap updateBSTCustomerDetailsData(HashMap hshValues)
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		
		String strCompId="";
		String strAction="";
		
		//ResultSet rs=null;
		
		int intUpdatesize=0;
		try
		{
			strAction=correctNull((String)hshValues.get("hidAction"));
			String strcomappid=correctNull((String)hshValues.get("hid_comappid"));
			if(strAction.equals("Insert"))
			{
				
				strCompId=getBSTMaxID();
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				intUpdatesize++;
			
				arrValues.add(correctNull((String)hshValues.get("txt_customername")));
				arrValues.add(correctNull((String)hshValues.get("comapp_groupid")));
				arrValues.add(correctNull((String)hshValues.get("comapp_scode")));
				arrValues.add(correctNull((String)hshValues.get("strUserId")));
				arrValues.add(strCompId);
				arrValues.add(strCompId);
				arrValues.add(correctNull((String)hshValues.get("sel_type")));
				hshQuery.put("strQueryId","ins_bstcustinfo");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
			}
			
			else if(strAction.equals("Update"))
			{
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				intUpdatesize++;
			
				arrValues.add(correctNull((String)hshValues.get("txt_customername")));
				arrValues.add(correctNull((String)hshValues.get("comapp_groupid")));
				arrValues.add(correctNull((String)hshValues.get("comapp_scode")));
				arrValues.add(correctNull((String)hshValues.get("strUserId")));
				arrValues.add(correctNull((String)hshValues.get("sel_type")));
				arrValues.add(correctNull((String)hshValues.get("hid_comappid")));
				hshQuery.put("strQueryId","upd_bstcustinfo");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
			}
			else if(strAction.equals("Renew"))
			{
				strCompId=getBSTMaxID();
				
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				intUpdatesize++;
				
				arrValues.add(strCompId);
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_comappid")));
				
				hshQuery.put("strQueryId","renew_bstcust");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
				
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				intUpdatesize++;
				
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_comappid")));
				
				hshQuery.put("strQueryId","upd_bstrenew");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
				
			}
			else if(strAction.equals("Delete"))
			{
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				intUpdatesize++;
				
				arrValues.add(correctNull((String)hshValues.get("hid_comappid")));
				hshQuery.put("strQueryId","del_bstcustinfo");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
			}
			hshQueryValues.put("size",""+intUpdatesize);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			if(strAction.equals("Insert")||strAction.equals("Renew"))
			{
				hshValues.put("hid_comappid",strCompId);
			}
			// Audit Trial Starts Here
			
			StringBuilder sbAt = new StringBuilder();
			
			sbAt.append("Company Name  =").append(correctNull((String)hshValues.get("txt_customername")));
			sbAt.append(" ~Group = ").append(correctNull((String)hshValues.get("comapp_group")));
			sbAt.append(" ~Application Recd. From    = ").append(correctNull((String)hshValues.get("comapp_orgname")));
			if(correctNull((String)hshValues.get("sel_type")).equalsIgnoreCase("1"))
			{
				sbAt.append(" ~Type of Borrower= ").append("Existing connection");
			}
			else if(correctNull((String)hshValues.get("sel_type")).equalsIgnoreCase("2"))
			{
				sbAt.append(" ~Type of Borrower= ").append("New connection");
			}
			else
			{
				sbAt.append(" ~Type of Borrower= ").append("");
			}
			if(strCompId.equalsIgnoreCase(""))
			{
				strCompId=strcomappid;
			}
			AuditTrial.auditLog(hshValues,"314",strCompId,sbAt.toString());
			
			hshValues=getBSTCustomerDetailsData(hshValues);
		}
		catch(Exception ex)
		{
			throw new EJBException("Error in updateBSTCustomerDetailsData :: "+ex.toString());
		}
		return hshValues;
	}
	
	
	public HashMap getBSTCustomerDetailsData(HashMap hshValues)
	{
		HashMap hshRecord=null;
		
		ResultSet rs=null;
		
		String strcomappid="";
		String strQuery="";
		
		try
		{
			hshRecord=new HashMap();
			strcomappid=correctNull((String)hshValues.get("hid_comappid"));
			
				strQuery=SQLParser.getSqlQuery("sel_bstcustinfo^"+strcomappid);
				
				rs=DBUtils.executeQuery(strQuery);
			
				if(rs.next())
				{
					hshRecord.put("combst_customername",correctNull(rs.getString("bst_companyname")));
					hshRecord.put("combst_companygroup",correctNull(rs.getString("bst_companygroup")));
					hshRecord.put("combst_brlocation",correctNull(rs.getString("bst_brlocation")));
					hshRecord.put("combst_modifieddate",correctNull(rs.getString("bst_modifieddate")));
					hshRecord.put("combst_modifiedby",correctNull(rs.getString("bst_modifiedby")));
					hshRecord.put("combst_companyid",correctNull(rs.getString("bst_companyid")));
					hshRecord.put("combst_companycustid",correctNull(rs.getString("bst_companycustid")));
					hshRecord.put("combst_brnlocationdesc",correctNull(rs.getString("brnlocationdesc")));
					hshRecord.put("combst_groupdesc",correctNull(rs.getString("groupdesc")));
					hshRecord.put("bst_custype",correctNull(rs.getString("bst_custype")));
				}
				
				strQuery=SQLParser.getSqlQuery("bstcheckapplnstatus^"+"'PA','PR','CA','CR'"+"^"+strcomappid);
				
				rs=DBUtils.executeQuery(strQuery);
			
				if(rs.next())
				{
					hshRecord.put("appstatus","true");
				}
				else
				{
					hshRecord.put("appstatus","false");
				}
				
				strQuery=SQLParser.getSqlQuery("bstcheckapplnstatus^"+"'OP','PA','PR','CA','CR'"+"^"+strcomappid);
				
				rs=DBUtils.executeQuery(strQuery);
			
				if(rs.next())
				{
					hshRecord.put("delflag","Y");
				}
				else
				{
					hshRecord.put("delflag","N");
				}
				
				
		}
		catch(Exception ex)
		{
			throw new EJBException("Error in getBSTCustomerDetailsData  :: "+ex.toString());
		}
		return hshRecord;
	}
	
	public HashMap getBSTCustomerList(HashMap hshValues)
	{
		HashMap hshRecord=null;
		
		ResultSet rs=null;
		
		String strcomappid="";
		String strQuery="";
		String strOrgSelect="";
		
		ArrayList arryCol=null;
		ArrayList arryRow=new ArrayList();
		try
		{
			hshRecord=new HashMap();
			strcomappid=correctNull((String)hshValues.get("comapp_companyname"));
			strOrgSelect=correctNull((String)hshValues.get("strOrgSelect"));
			
			strQuery=SQLParser.getSqlQuery("sel_bstcustlist^"+strcomappid+"^"+strOrgSelect);
				
				rs=DBUtils.executeQuery(strQuery);
			
				while(rs.next())
				{
					arryCol=new ArrayList();				 
					arryCol.add(correctNull((String)rs.getString("bst_companygroup")));//0
					arryCol.add(correctNull((String)rs.getString("bst_companyname")));//1
					arryCol.add(correctNull((String)rs.getString("bst_brlocation")));//2
					arryCol.add(correctNull((String)rs.getString("bst_modifieddate")));//3
					arryCol.add(correctNull((String)rs.getString("bst_modifiedby")));//4		
					arryCol.add(correctNull((String)rs.getString("bst_companyid")));//5
					arryCol.add(correctNull((String)rs.getString("bst_companycustid")));//6
					arryCol.add(correctNull((String)rs.getString("bst_brlocationdesc")));//7
					arryRow.add(arryCol);
				}
				hshRecord.put("arryRow",arryRow);
		}
		catch(Exception ex)
		{
			throw new EJBException("Error in getBSTCustomerList  :: "+ex.toString());
		}
		return hshRecord;
	}
	
	public HashMap updateBSTfacility(HashMap hshValues)
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		HashMap hshRecord=new HashMap();
		ArrayList arrValues=new ArrayList();
		
		ResultSet rs=null;
		
		String strAction=(String)hshValues.get("hidAction");
		String strAppno="";
		int intUpdateSize=0;
		StringTokenizer stk = null;
		
		String strSno="";
		String strFactype="";
		String strFacilityhead="";
		String strFacility="";
		String strExistlimit="";
		String strProposedlimit="";
		String strCreditrateint="";
		String strProposedint="";
		String strMargin="";
		String strTenor="";
		String strPurpose="";
		String strIntreset="";
		String strFacilitygroup="0";
		String strSolid="";
		String strExp="$",strMsg="";
		String strQuery="";
		boolean updflag=true;
		
		try
		{
			strSno=correctNull((String)hshValues.get("hidsno"));
			strFactype=correctNull((String)hshValues.get("hidfactype"));
			strAppno=correctNull((String)hshValues.get("appno"));
			strSolid=correctNull((String)hshValues.get("strSolid"));
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
				strExistlimit=Helper.correctDouble((String)hshValues.get("txt_sublimitexist"));
				strProposedlimit=Helper.correctDouble((String)hshValues.get("txt_sublimitproposed"));
				strCreditrateint=correctNull((String)hshValues.get("txt_sublimitcreditint"));
				strProposedint=correctNull((String)hshValues.get("txt_sublimitproposedint"));
				strMargin=correctNull((String)hshValues.get("txt_sublimitmargin"));
				strTenor=correctNull((String)hshValues.get("txt_sublimitperiod"));
				strPurpose=correctNull((String)hshValues.get("txt_sublimitpurpose"));
				strIntreset=correctNull((String)hshValues.get("txt_sublimitintreset"));
				strFacilitygroup=correctNull((String)hshValues.get("hidfacgrp"));
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
				
				strExistlimit=Helper.correctDouble((String)hshValues.get("txt_limitexist"));
				strProposedlimit=Helper.correctDouble((String)hshValues.get("txt_limitproposed"));
				strCreditrateint=correctNull((String)hshValues.get("txt_limitcreditint"));
				strProposedint=correctNull((String)hshValues.get("txt_limitproposedint"));
				strMargin=correctNull((String)hshValues.get("txt_limitmargin"));
				strTenor=correctNull((String)hshValues.get("txt_limitperiod"));
				strPurpose=correctNull((String)hshValues.get("txt_limitpurpose"));
				strIntreset=correctNull((String)hshValues.get("txt_limitintreset"));
			}
			
			
			
			if(strAppno.equalsIgnoreCase("NEW"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				intUpdateSize++;
				
				strAppno=getBSTAppno(strSolid);
				
				hshQuery.put("strQueryId","ins_bstapplication");
				arrValues.add(strAppno);
				arrValues.add(correctNull((String)hshValues.get("strUserId")));
				arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
				arrValues.add(correctNull((String)hshValues.get("strUserId")));
				arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
				arrValues.add(correctNull((String)hshValues.get("strOrgLevel")));
				arrValues.add(correctNull((String)hshValues.get("sel_valuesin")));
				arrValues.add(correctNull((String)hshValues.get("com_id")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdateSize,hshQuery);	
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				intUpdateSize++;				
				hshQuery.put("strQueryId","ins_bstfacility");
				arrValues.add(strAppno);
				arrValues.add(getMaxBSTfacilityId(strAppno));
				arrValues.add(strFacilityhead);
				arrValues.add(strFacility);
				arrValues.add(strExistlimit);
				arrValues.add(strProposedlimit);
				arrValues.add(strCreditrateint);
				arrValues.add(strProposedint);
				arrValues.add(strMargin);
				arrValues.add(strTenor);
				arrValues.add(strPurpose);
				arrValues.add(strIntreset);
				arrValues.add(strFacilitygroup);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdateSize,hshQuery);	
				
			}
			else
			{	
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				intUpdateSize++;
				if(strAction.equalsIgnoreCase("delete"))
				{
					strQuery=SQLParser.getSqlQuery("sel_bstfacility^"+strAppno+"^"+strSno);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						//strExp=strExp+"Sub Limit Exists, Cannot be deleted";
						//throw new EJBException(strExp);
						updflag=false;
						strMsg="Sub Limit Exists, Cannot be deleted";
						intUpdateSize=0;
					}
					if(updflag==true)
					{
						hshQuery.put("strQueryId","del_bstfacility");
						arrValues.add(strAppno);
						arrValues.add(strSno);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(""+intUpdateSize,hshQuery);
					}
				}
				else if(strAction.equalsIgnoreCase("insert"))
				{
					hshQuery.put("strQueryId","ins_bstfacility");
					arrValues.add(strAppno);
					arrValues.add(getMaxBSTfacilityId(strAppno));
					arrValues.add(strFacilityhead);
					arrValues.add(strFacility);
					arrValues.add(strExistlimit);
					arrValues.add(strProposedlimit);
					arrValues.add(strCreditrateint);
					arrValues.add(strProposedint);
					arrValues.add(strMargin);
					arrValues.add(strTenor);
					arrValues.add(strPurpose);
					arrValues.add(strIntreset);
					arrValues.add(strFacilitygroup);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdateSize,hshQuery);	
				}
				else if(strAction.equalsIgnoreCase("update"))
				{
					hshQuery.put("strQueryId","upd_bstfacility");				
					arrValues.add(strFacilityhead);
					arrValues.add(strFacility);
					arrValues.add(strExistlimit);
					arrValues.add(strProposedlimit);
					arrValues.add(strCreditrateint);
					arrValues.add(strProposedint);
					arrValues.add(strMargin);
					arrValues.add(strTenor);
					arrValues.add(strPurpose);
					arrValues.add(strIntreset);
					arrValues.add(strFacilitygroup);
					arrValues.add(strAppno);
					arrValues.add(strSno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdateSize,hshQuery);	
					
					if(!(correctNull((String)hshValues.get("hidvaluesin")).equalsIgnoreCase(correctNull((String)hshValues.get("sel_valuesin")))))
					{
					
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						intUpdateSize++;
						
						hshQuery.put("strQueryId","upd_bstvaluesin");				
						arrValues.add(correctNull((String)hshValues.get("sel_valuesin")));
						arrValues.add(strAppno);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(""+intUpdateSize,hshQuery);
					}
					
					
				}
			}
			hshQueryValues.put("size",""+intUpdateSize);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			hshValues.put("appno",strAppno);
			hshRecord = getBSTfacility(hshValues);
			hshRecord.put("msg",strMsg);
			/** Audit Trial**/
			StringBuilder sbAt = new StringBuilder();
			if(!strAction.equalsIgnoreCase("delete"))
			{
				String strValues=correctNull((String)hshValues.get("sel_valuesin"));
				if(strValues.equals("L"))strValues="Lacs";
				if(strValues.equals("C"))strValues="Crores";
			    sbAt.append("All Values are in  =").append(strValues);
				sbAt.append(" ~Facility Head =").append(correctNull((String)hshValues.get("hid_facility_head")));
				sbAt.append(" ~Facility = ").append(correctNull((String)hshValues.get("hid_facility")));
				sbAt.append(" ~Existing Limits  = ").append(correctNull((String)hshValues.get("txt_limitexist")));
				sbAt.append(" ~Proposed Limit  = ").append(correctNull((String)hshValues.get("txt_limitproposed")));
				sbAt.append(" ~Interest as per Credit Rating / Commission= ").append(correctNull((String)hshValues.get("txt_limitcreditint")));
				sbAt.append(" ~Interest/Commission Proposed = ").append(correctNull((String)hshValues.get("txt_limitproposedint")));
				sbAt.append(" ~Margin(%) = ").append(correctNull((String)hshValues.get("txt_limitmargin")));
				sbAt.append(" ~Period (in Months) = ").append(correctNull((String)hshValues.get("txt_limitperiod")));
				sbAt.append(" ~Purpose = ").append(correctNull((String)hshValues.get("txt_limitpurpose")));
				sbAt.append(" ~Interest reset = ").append(correctNull((String)hshValues.get("txt_limitintreset")));
				
				sbAt.append(" ~Sub-Limits =").append(correctNull((String)hshValues.get("chksublimit")));
				sbAt.append(" ~Sub-Limit Head =").append(correctNull((String)hshValues.get("hid_subfacility_head")));
				sbAt.append(" ~Sub-Limit = ").append(correctNull((String)hshValues.get("hid_subfacility")));
				sbAt.append(" ~Sub Existing Limits  = ").append(correctNull((String)hshValues.get("txt_sublimitexist")));
				sbAt.append(" ~Sub Proposed Limit  = ").append(correctNull((String)hshValues.get("txt_sublimitproposed")));
				sbAt.append(" ~Sub Interest as per Credit Rating / Commission= ").append(correctNull((String)hshValues.get("txt_sublimitcreditint")));
				sbAt.append(" ~Sub Interest/Commission Proposed = ").append(correctNull((String)hshValues.get("txt_sublimitproposedint")));
				sbAt.append(" ~Sub Margin(%) = ").append(correctNull((String)hshValues.get("txt_sublimitmargin")));
				sbAt.append(" ~Sub Period (in Months) = ").append(correctNull((String)hshValues.get("txt_sublimitperiod")));
				sbAt.append(" ~Sub Purpose = ").append(correctNull((String)hshValues.get("txt_sublimitpurpose")));
				sbAt.append(" ~Sub Interest reset = ").append(correctNull((String)hshValues.get("txt_sublimitintreset")));
			}
//Purpose
			AuditTrial.auditLog(hshValues,"290",strAppno,sbAt.toString());
			
		}
		catch(Exception e1)
		{
			throw new EJBException(e1.getMessage());
		}
		return hshRecord;
	}
	
	public HashMap getBSTfacility(HashMap hshValues)
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;
		ResultSet rs1=null;
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		String strQuery="";
		String strAppno="";
		String strcomappid="";
		boolean recordflag=false;
		try
		{
			strAppno= correctNull((String)hshValues.get("appno"));	
			strcomappid= correctNull((String)hshValues.get("com_id"));
			strQuery=SQLParser.getSqlQuery("sel_bstfacility^"+strAppno+"^0");

			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("bstfacilities_appno")));//0
				arrCol.add(correctNull(rs.getString("bstfacilities_headid")));//1
				arrCol.add(correctNull(rs.getString("bstfacilities_id")));//2
				arrCol.add(Helper.correctDouble(rs.getString("bstfacilities_existing")));//3
				arrCol.add(Helper.correctDouble(rs.getString("bstfacilities_proposed")));//4
				arrCol.add(correctNull(rs.getString("bstfacilities_creditint")));//5
				arrCol.add(correctNull(rs.getString("bstfacilities_propint")));//6
				arrCol.add(correctNull(rs.getString("bstfacilities_margin")));//7
				arrCol.add(correctNull(rs.getString("bstfacilities_tenor")));//8
				arrCol.add(correctNull(rs.getString("bstfacilities_purpose")));//9
				arrCol.add(correctNull(rs.getString("bstfacilities_intreset")));//10
				arrCol.add(correctNull(rs.getString("bstfacilities_createdate")));//11
				arrCol.add(correctNull(rs.getString("bstfacilities_facgroup")));//12
				String strFacgrp=correctNull(rs.getString("bstfacilities_sno"));
				arrCol.add(strFacgrp);//13
				arrCol.add(correctNull(rs.getString("facheaddesc")));//14
				arrCol.add(correctNull(rs.getString("facdesc")));//15
				arrRow.add(arrCol);
				
				strQuery=SQLParser.getSqlQuery("sel_bstfacility^"+strAppno+"^"+strFacgrp);
				
				if(rs1!=null)
					rs1.close();
				
				rs1=DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{
					arrCol = new ArrayList();
					arrCol.add(correctNull(rs1.getString("bstfacilities_appno")));//0
					arrCol.add(correctNull(rs1.getString("bstfacilities_headid")));//1
					arrCol.add(correctNull(rs1.getString("bstfacilities_id")));//2
					arrCol.add(Helper.correctDouble(rs1.getString("bstfacilities_existing")));//3
					arrCol.add(Helper.correctDouble(rs1.getString("bstfacilities_proposed")));//4
					arrCol.add(correctNull(rs1.getString("bstfacilities_creditint")));//5
					arrCol.add(correctNull(rs1.getString("bstfacilities_propint")));//6
					arrCol.add(correctNull(rs1.getString("bstfacilities_margin")));//7
					arrCol.add(correctNull(rs1.getString("bstfacilities_tenor")));//8
					arrCol.add(correctNull(rs1.getString("bstfacilities_purpose")));//9
					arrCol.add(correctNull(rs1.getString("bstfacilities_intreset")));//10
					arrCol.add(correctNull(rs1.getString("bstfacilities_createdate")));//11
					arrCol.add(correctNull(rs1.getString("bstfacilities_facgroup")));//12
					arrCol.add(correctNull(rs1.getString("bstfacilities_sno")));//13
					arrCol.add(correctNull(rs1.getString("facheaddesc")));//14
					arrCol.add(correctNull(rs1.getString("facdesc")));//15
					arrRow.add(arrCol);
				}
				recordflag=true;
			}			
			
			if(strAppno.equalsIgnoreCase("NEW"))
			{
				strQuery=SQLParser.getSqlQuery("bstcheckapplnstatus^"+"'OP','PR','PA'"+"^"+strcomappid);
				
				rs=DBUtils.executeQuery(strQuery);
			
				if(rs.next())
				{
					hshRecord.put("checkappln","true");
				}
				else
				{
					hshRecord.put("checkappln","false");
				}
			}
			
			
			if(strAppno.equalsIgnoreCase("NEW"))
			{
				hshRecord.put("btnenable","Y");
				hshRecord.put("appstatus","op");
			}
			else
			{
				TagDataHelperBST tagDataHelperbst=new TagDataHelperBST();
				hshRecord.putAll((HashMap)tagDataHelperbst.getBSTAppData(hshValues));
				
				char readFlag=Helper.correctNull((String)hshValues.get("strGroupRights")).charAt(18);
				hshRecord.put("btnenable",(""+readFlag).equals("r")?"N":(correctNull((String)hshRecord.get("appstatus")).equalsIgnoreCase("op") && hshValues.get("strUserId").equals(correctNull((String)hshRecord.get("applnholder"))))?"Y":"N");
			}
			hshRecord.put("arrRow",arrRow);
			hshRecord.put("appno",strAppno);
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
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
	
	public HashMap getBSTApprovalprint(HashMap hshValues)
	{
		HashMap hshRecord=null;
		
		ResultSet rs=null;
		ResultSet rs1=null;
		
		String strQuery="";
		String strAppno="";
		//String com_id="";
		String strdesc="creditrating','promotorsbackground','projectnature','loanpolicy','guarantee','refno','signatures','procfees','datebst";
		String strLevel="";
		String strOrgCode="";
		StringBuffer sbfsignatories=null;
		
		ArrayList arrCol=null;
		ArrayList arrRow=new ArrayList();
		try
		{
			hshRecord=new HashMap();
			//com_id=correctNull((String)hshValues.get("comid"));
			strAppno=correctNull((String)hshValues.get("appno"));
			strOrgCode=correctNull((String)hshValues.get("strOrgCode"));
			
			
			// Customer Details
			/*strQuery=SQLParser.getSqlQuery("sel_bstcustinfo^"+com_id);
			rs=DBUtils.executeQuery(strQuery);
		
			if(rs.next())
			{
				hshRecord.put("combst_customername",correctNull(rs.getString("bst_companyname")));
				hshRecord.put("combst_brnlocationdesc",correctNull(rs.getString("brnlocationdesc")));
				hshRecord.put("combst_groupdesc",correctNull(rs.getString("groupdesc")));
				hshRecord.put("combst_custype",correctNull(rs.getString("bst_custype")));
			}*/
			
			//Customer profitability
			strQuery=SQLParser.getSqlQuery("sel_bstcustprofit^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
		
			if(rs.next())
			{
				hshRecord.put("bstcpappno",correctNull(rs.getString("bstcp_appno")));
				hshRecord.put("bstcpbillscommission",Helper.correctDouble(rs.getString("bstcp_billscommission")));
				hshRecord.put("bstcpprocesscharges",Helper.correctDouble(rs.getString("bstcp_processcharges")));
				hshRecord.put("bstcplgcommission",Helper.correctDouble(rs.getString("bstcp_lgcommission")));
				hshRecord.put("bstcpsb",Helper.correctDouble(rs.getString("bstcp_sb")));
				hshRecord.put("bstcpcd",Helper.correctDouble(rs.getString("bstcp_cd")));
				hshRecord.put("bstcpownsources",Helper.correctDouble(rs.getString("bstcp_ownsources")));
				hshRecord.put("bstcpthirdparty",Helper.correctDouble(rs.getString("bstcp_thirdparty")));
			}
			
			//Financials
			strQuery=SQLParser.getSqlQuery("sel_broadtermsfin^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				arrCol = new ArrayList();						
				arrCol.add(correctNull(rs.getString("broadtermsfinfirstyear")));
				arrCol.add(correctNull(rs.getString("broadtermsfinsecondyear")));
				arrCol.add(correctNull(rs.getString("broadtermsfinthirdyear")));
				arrCol.add(correctNull(rs.getString("broadtermsfinrowdesc")));
				arrRow.add(arrCol);	
			}
			//Financials - comments
			strQuery = SQLParser.getSqlQuery("sel_broadtermscomments^"+strAppno+"^"+"'"+"broadtermscomments"+"'");
			rs = DBUtils.executeQuery(strQuery);	
			if(rs.next())
			{
				hshRecord.put("comments",correctNull(Helper.CLOBToString((rs.getClob("com_broadtermscomments")))));
			}
			hshRecord.put("arrFinancial",arrRow);
			
			//Comments 
			strQuery = SQLParser.getSqlQuery("sel_broadtermscomments^"+strAppno+"^'"+strdesc+"'");
			rs = DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				if(correctNull((String)rs.getString("com_broadtermstype")).equalsIgnoreCase("loanpolicy"))
				{
					hshRecord.put("loanpolicy_comments",Helper.CLOBToString(rs.getClob("com_broadtermscomments")));
				}
				/*else if(correctNull((String)rs.getString("com_broadtermstype")).equalsIgnoreCase("datebst"))
				{
					hshRecord.put("datebst",Helper.CLOBToString(rs.getClob("com_broadtermscomments")));
				}*/
				else if(correctNull((String)rs.getString("com_broadtermstype")).equalsIgnoreCase("customerprofitability"))
				{
					hshRecord.put("customerprofitability_comments",Helper.CLOBToString(rs.getClob("com_broadtermscomments")));
				}
				else if(correctNull((String)rs.getString("com_broadtermstype")).equalsIgnoreCase("creditrating"))
				{
					hshRecord.put("creditrating",Helper.CLOBToString(rs.getClob("com_broadtermscomments")));
				}
				else if(correctNull((String)rs.getString("com_broadtermstype")).equalsIgnoreCase("promotorsbackground"))
				{
					hshRecord.put("promotorsbackground_comments",Helper.CLOBToString(rs.getClob("com_broadtermscomments")));
				}
				else if(correctNull((String)rs.getString("com_broadtermstype")).equalsIgnoreCase("projectnature"))
				{
					hshRecord.put("projectnature_comments",Helper.CLOBToString(rs.getClob("com_broadtermscomments")));
				}
				else if(correctNull((String)rs.getString("com_broadtermstype")).equalsIgnoreCase("guarantee"))
				{
					hshRecord.put("guarantee_comments",Helper.CLOBToString(rs.getClob("com_broadtermscomments")));
				}
				else if(correctNull((String)rs.getString("com_broadtermstype")).equalsIgnoreCase("procfees"))
				{
					hshRecord.put("procfees",Helper.CLOBToString(rs.getClob("com_broadtermscomments")));
				}
				
				/*else if(correctNull((String)rs.getString("com_broadtermstype")).equalsIgnoreCase("refno"))
				{
					hshRecord.put("refno",Helper.CLOBToString(rs.getClob("com_broadtermscomments")));
					//hshValues.put("sancauth",correctNull(rs.getString("com_broadtermsseltype")));
					
				}*/
				/*else if(correctNull((String)rs.getString("com_broadtermstype")).equalsIgnoreCase("signatures"))
				{
					sbfsignatories = new StringBuffer(Helper.CLOBToString(rs.getClob("com_broadtermscomments")));
				}*/
			}
			
			strQuery = SQLParser.getSqlQuery("selbstorgcomments^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				if(correctNull((String)rs.getString("combst_orglevel")).equalsIgnoreCase("A"))
				{
					hshRecord.put("branch_comments",Helper.CLOBToString(rs.getClob("combst_orgrecmds")));
				}
				else if(correctNull((String)rs.getString("combst_orglevel")).equalsIgnoreCase("D"))
				{
					hshRecord.put("region_comments",Helper.CLOBToString(rs.getClob("combst_orgrecmds")));
				}
				else if(correctNull((String)rs.getString("combst_orglevel")).equalsIgnoreCase("R"))
				{
					hshRecord.put("zonal_comments",Helper.CLOBToString(rs.getClob("combst_orgrecmds")));
				}
				else if(correctNull((String)rs.getString("combst_orglevel")).equalsIgnoreCase("C"))
				{
					hshRecord.put("central_comments",Helper.CLOBToString(rs.getClob("combst_orgrecmds")));
				}
				sbfsignatories = new StringBuffer(Helper.correctNull(rs.getString("combst_orgsignatories")));
				hshRecord.put("refno",correctNull(rs.getString("combst_refno")));
				hshRecord.put("datebst",Helper.correctNull(rs.getString("combst_refdate")));
			}
			if(sbfsignatories!=null)
			{
				for (int i = 0;i < sbfsignatories.length(); i++) {
					if (sbfsignatories.charAt(i) == '\n') {
						sbfsignatories.replace(i, i + 1, "<br>");
					}
					if (sbfsignatories.charAt(i) == ' ') {
						sbfsignatories.replace(i, i + 1, "&nbsp;");
					}
				}
				hshRecord.put("signatures",sbfsignatories.toString());
			}
			
			//Facility
			arrRow=new ArrayList();		
			strQuery=SQLParser.getSqlQuery("sel_bstfacility^"+strAppno+"^0");

			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("bstfacilities_appno")));//0
				arrCol.add(correctNull(rs.getString("bstfacilities_headid")));//1
				arrCol.add(correctNull(rs.getString("bstfacilities_id")));//2
				arrCol.add(Helper.correctDouble(rs.getString("bstfacilities_existing")));//3
				arrCol.add(Helper.correctDouble(rs.getString("bstfacilities_proposed")));//4
				arrCol.add(correctNull(rs.getString("bstfacilities_creditint")));//5
				arrCol.add(correctNull(rs.getString("bstfacilities_propint")));//6
				arrCol.add(correctNull(rs.getString("bstfacilities_margin")));//7
				arrCol.add(correctNull(rs.getString("bstfacilities_tenor")));//8
				arrCol.add(correctNull(rs.getString("bstfacilities_purpose")));//9
				arrCol.add(correctNull(rs.getString("bstfacilities_intreset")));//10
				arrCol.add(correctNull(rs.getString("bstfacilities_createdate")));//11
				arrCol.add(correctNull(rs.getString("bstfacilities_facgroup")));//12
				String strFacgrp=correctNull(rs.getString("bstfacilities_sno"));
				arrCol.add(strFacgrp);//13
				arrCol.add(correctNull(rs.getString("facheaddesc")));//14
				arrCol.add(correctNull(rs.getString("facdesc")));//15
				arrRow.add(arrCol);
				
				strQuery=SQLParser.getSqlQuery("sel_bstfacility^"+strAppno+"^"+strFacgrp);
				
				if(rs1!=null)
					rs1.close();
				
				rs1=DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{
					arrCol = new ArrayList();
					arrCol.add(correctNull(rs1.getString("bstfacilities_appno")));//0
					arrCol.add(correctNull(rs1.getString("bstfacilities_headid")));//1
					arrCol.add(correctNull(rs1.getString("bstfacilities_id")));//2
					arrCol.add(Helper.correctDouble(rs1.getString("bstfacilities_existing")));//3
					arrCol.add(Helper.correctDouble(rs1.getString("bstfacilities_proposed")));//4
					arrCol.add(correctNull(rs1.getString("bstfacilities_creditint")));//5
					arrCol.add(correctNull(rs1.getString("bstfacilities_propint")));//6
					arrCol.add(correctNull(rs1.getString("bstfacilities_margin")));//7
					arrCol.add(correctNull(rs1.getString("bstfacilities_tenor")));//8
					arrCol.add(correctNull(rs1.getString("bstfacilities_purpose")));//9
					arrCol.add(correctNull(rs1.getString("bstfacilities_intreset")));//10
					arrCol.add(correctNull(rs1.getString("bstfacilities_createdate")));//11
					arrCol.add(correctNull(rs1.getString("bstfacilities_facgroup")));//12
					arrCol.add(correctNull(rs1.getString("bstfacilities_sno")));//13
					arrCol.add(correctNull(rs1.getString("facheaddesc")));//14
					arrCol.add(correctNull(rs1.getString("facdesc")));//15
					arrRow.add(arrCol);
				}
			}			
			hshRecord.put("arrFacility",arrRow);
			
			if(rs!=null)rs.close();
//			Repayment terms  / Prepayment terms
			arrRow=new ArrayList();
			strQuery=SQLParser.getSqlQuery("sel_bsttremscomments^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				arrCol = new ArrayList();		
				arrCol.add(correctNull(rs.getString("com_broadtermstype")));	
				arrCol.add(correctNull(rs.getString("facility_catdesc")));	
				arrCol.add(correctNull(Helper.CLOBToString(rs.getClob("com_broadtermscomments"))));
				arrCol.add(correctNull(rs.getString("bstfacilities_proposed")));	
				arrRow.add(arrCol);	
			}
			
			hshRecord.put("arrTermComments",arrRow);
			
			if(rs!=null)rs.close();
			
			/*strQuery=SQLParser.getSqlQuery("sel_OrgDetails^"+strAppno);*/
			
			strQuery=SQLParser.getSqlQuery("setorgselect^"+strOrgCode);
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
			}
			
			// Cost of the Project 
			ArrayList vecOthers = new ArrayList();
			ArrayList vecIncurred = new ArrayList();
			ArrayList vecTobeIncurred = new ArrayList();
			ArrayList vecTotal= new ArrayList();
			double dblTotalCapital1=0;
			double dblTotalCapital2=0;
			double dblTotalCapital3=0;

			double dblTotalCost1=0;
			double dblTotalCost2=0;
			double dblTotalCost3=0;
			double dblTotal1=0;
			double dblTotal2=0;
			double dblTotal3=0;
			strAppno=correctNull((String)hshValues.get("appno"));
			rs=DBUtils.executeLAPSQuery("costofprojectsel^"+strAppno);
			vecIncurred=new ArrayList();
			int i=1;
			String strRepay="";
			while(rs.next())
			{   
				if(i==1)
				{
					strRepay=Helper.correctNull(rs.getString("com_repay"));
				}
				//veccomid.add(correctNull(rs.getString("com_id")));
				vecIncurred.add(correctNull(rs.getString("com_costincurred")));
				vecTobeIncurred.add(correctNull(rs.getString("com_costtobe")));
				vecTotal.add(correctNull(rs.getString("totalcost")));
				if(i<=15)
				{
					dblTotalCapital1+=Double.parseDouble(rs.getString("com_costincurred"));
					dblTotalCapital2+=Double.parseDouble(rs.getString("com_costtobe"));
					dblTotalCapital3+=Double.parseDouble(rs.getString("totalcost"));
				}
				else if(i==16)
				{
					dblTotalCost1= dblTotalCapital1+ Double.parseDouble(rs.getString("com_costincurred"));
					dblTotalCost2= dblTotalCapital2+ Double.parseDouble(rs.getString("com_costtobe"));
					dblTotalCost3= dblTotalCapital3+ Double.parseDouble(rs.getString("totalcost"));
				}
				else
				{
					dblTotal1+=Double.parseDouble(rs.getString("com_costincurred"));
					dblTotal2+=Double.parseDouble(rs.getString("com_costtobe"));
					dblTotal3+=Double.parseDouble(rs.getString("totalcost"));
				}
				i++;
				vecOthers.add(correctNull(rs.getString("com_others")));
			}
			//hshRecord.put("veccomid",veccomid);
			hshRecord.put("vecOthers",vecOthers);
			hshRecord.put("vecIncurred",vecIncurred);
			hshRecord.put("vecTobeIncurred",vecTobeIncurred);
			hshRecord.put("vecTotal",vecTotal);
			hshRecord.put("strRepay",strRepay);
			hshRecord.put("dblTotalCapital1",Helper.formatDoubleValue(dblTotalCapital1));
			hshRecord.put("dblTotalCapital2",Helper.formatDoubleValue(dblTotalCapital2));
			hshRecord.put("dblTotalCapital3",Helper.formatDoubleValue(dblTotalCapital3));
			hshRecord.put("dblTotalCost1",Helper.formatDoubleValue(dblTotalCost1));
			hshRecord.put("dblTotalCost2",Helper.formatDoubleValue(dblTotalCost2));
			hshRecord.put("dblTotalCost3",Helper.formatDoubleValue(dblTotalCost3));
			hshRecord.put("dblTotal1",Helper.formatDoubleValue(dblTotal1));
			hshRecord.put("dblTotal2",Helper.formatDoubleValue(dblTotal2));
			hshRecord.put("dblTotal3",Helper.formatDoubleValue(dblTotal3));
		
			//Security 
			arrRow=new ArrayList();
			strQuery=SQLParser.getSqlQuery("sel_bstsecdetails^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(rs.getString("bstsec_srlno"));
				arrCol.add(rs.getString("bstsec_desc_id"));
				arrCol.add(rs.getString("sec_name"));
				arrCol.add(rs.getString("bstsec_desc_details"));
				arrCol.add(rs.getString("bstsec_desc_value"));
				arrCol.add(rs.getString("as_on_date"));
				arrCol.add(rs.getString("bstsec_tenor"));
				arrCol.add(rs.getString("bstsec_type"));
				arrCol.add(rs.getString("bstsec_valuersname"));
				arrCol.add(rs.getString("bstsec_insuranceamt"));
				arrCol.add(rs.getString("sec_insexpirydate"));
				arrCol.add(rs.getString("bstsec_remarks"));
				arrRow.add(arrCol);
			}
			hshRecord.put("arrSecurity",arrRow);
			
			if(rs!=null)rs.close();
			
			strQuery=SQLParser.getSqlQuery("sel_bstcustdetails^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("companyname",correctNull(rs.getString("bst_companyname")));
				hshRecord.put("brnlocation",correctNull(rs.getString("brnlocationdesc")));
				hshRecord.put("group",correctNull(rs.getString("groupdesc")));
				hshRecord.put("combst_custype",correctNull(rs.getString("bst_custype")));
			}
			hshRecord.put("OrgLevel",correctNull((String)hshValues.get("strOrgLevel")));
			if(rs!=null)
				rs.close();
			
			strQuery=SQLParser.getSqlQuery("combst_bankingDetails_select^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				String strTemp=correctNull(rs.getString("cb_banktype"));
				hshRecord.put("cb_banktype",strTemp.equals("1")?"Sole":strTemp.equals("2")?"Consortium":strTemp.equals("3")?"Multiple":strTemp.equals("4")?"Sole / Consortium":strTemp.equals("5")?"Sole / Multiple":strTemp.equals("6")?"Consortium / Multiple":strTemp.equals("7")?"Sole/ Consortium / Multiple":"");
				hshRecord.put("cb_leadbank", correctNull(rs.getString("cb_leadbank")).equals("")?"N.A":correctNull(rs.getString("cb_leadbank")));
				hshRecord.put("banktype",strTemp.trim());
				hshRecord.put("cb_fundexist",correctNull(rs.getString("cb_fundexist")));
				hshRecord.put("cb_fundproposed",correctNull(rs.getString("cb_fundproposed")));
				hshRecord.put("cb_nonfundexist",correctNull(rs.getString("cb_nonfundexist")));
				hshRecord.put("cb_nonfundproposed",correctNull(rs.getString("cb_nonfundproposed")));
				
			}
			
			arrRow = new ArrayList();
			strQuery=SQLParser.getSqlQuery("combst_existcreditlimits_select^"+strAppno+"^0");
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol = new ArrayList();
				String strFacsno=correctNull(rs.getString("cf_facsno"));
				arrCol.add(strFacsno);
				arrCol.add(correctNull(rs.getString("cf_facgroup")));
				arrCol.add(correctNull(rs.getString("cf_bankname")));
				arrCol.add(correctNull(rs.getString("cf_facnature")));
				arrCol.add(Helper.correctDouble(rs.getString("cf_existlimit")));
				arrCol.add(correctNull(rs.getString("cf_approi")));
				arrCol.add(correctNull(rs.getString("cf_presentroi")));
				arrRow.add(arrCol);
			    strQuery=SQLParser.getSqlQuery("combst_existcreditlimits_select^"+strAppno+"^"+strFacsno);
				
				if(rs1!=null)
					rs1.close();
				
				rs1=DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{
					arrCol = new ArrayList();
					arrCol.add(correctNull(rs1.getString("cf_facsno")));//0
					arrCol.add(correctNull(rs1.getString("cf_facgroup")));//1
					arrCol.add(correctNull(rs1.getString("cf_bankname")));//2
					arrCol.add(correctNull(rs1.getString("cf_facnature")));//3
					arrCol.add(Helper.correctDouble(rs1.getString("cf_existlimit")));//4
					arrCol.add(correctNull(rs1.getString("cf_approi")));//5
					arrCol.add(correctNull(rs1.getString("cf_presentroi")));//6
					arrRow.add(arrCol);
				}
				
			}			
			hshRecord.put("CreditFacilities",arrRow);
			strQuery = SQLParser.getSqlQuery("combst_defaulterslist_select^"+strAppno);
			if(rs!=null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("cd_comments", correctNull(Helper.CLOBToString(rs.getClob("cd_comments"))));
			}
			
			
		}
		catch(Exception ex)
		{
			throw new EJBException("Error in getBSTApprovalprint  :: "+ex.toString());
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
		return hshRecord;
	}
	
	public HashMap getBSTHistory(HashMap hshValues)
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
			
			rs=DBUtils.executeLAPSQuery("bst_workflowhistory^"+strAppno);
			while(rs.next())
			{
				arrFromUsr.add(correctNull(rs.getString("fromuser")));
				arrToUsr.add(correctNull(rs.getString("touser")));
				arrFromflow.add(correctNull(rs.getString("bstmail_fromflowpoint")));
				arrToflow.add(correctNull(rs.getString("bstmail_toflowpoint")));
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
	
	public HashMap getBSTAction(HashMap hshValues) 
	{
		String strQuery="",strQuery1="";
		ResultSet rs=null;
		ResultSet rs1=null;
		ResultSet rs2=null;
		
		HashMap hshRecord=new HashMap();
		ArrayList arrFlowpoint=new ArrayList();
		ArrayList arrDone=new ArrayList();
		ArrayList arrClassDesc=new ArrayList();
		ArrayList arrMaxclass=new ArrayList();
		ArrayList arrAction=new ArrayList();
		
		String strstatus="";
		try
			{
			String strappno = correctNull((String)hshValues.get("appno"));
			String strAction = correctNull((String)hshValues.get("hidAction"));
			
			
			if(strappno.equalsIgnoreCase(""))
			{
				strappno = correctNull((String)hshValues.get("hidAppNo"));
			}
			
			strQuery=SQLParser.getSqlQuery("sel_bstapplication^"+strappno);
     		rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strstatus=correctNull((String)rs.getString("bstapp_status"));
				hshRecord.put("ApproveRejectedby",correctNull(rs.getString("bstapp_approvedby")));
				hshRecord.put("Sanction_Comments",correctNull(rs.getString("bstapp_sancauthcomments")));
				hshRecord.put("enablesend",correctNull(rs.getString("bstapp_applnholder")).equalsIgnoreCase(correctNull((String)hshValues.get("strUserId")))?"Y":"N");
				hshRecord.put("appstatus",strstatus);
			}
			
			strQuery=SQLParser.getSqlQuery("sel_bstworkflow^"+strappno+"^"+strappno);
			if(rs!=null)
			rs.close();	
			
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("strCurrFlowPoint",rs.getString("bstmail_toflowpoint"));
				hshRecord.put("strDate",rs.getString("bstmail_date"));
				hshRecord.put("strDueDate",rs.getString("duedate"));
			}
			else
			{
					strQuery=SQLParser.getSqlQuery("sel_bstappworkflow^"+strappno+"^"+strappno);
					if(rs!=null)
					rs.close();	
					
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						hshRecord.put("strCurrFlowPoint","1");
						hshRecord.put("strDate",rs.getString("createdate"));
						hshRecord.put("strDueDate",rs.getString("duedate"));
					}
			}
				
			String state="p";
			String strId="7";
			
			strQuery=SQLParser.getSqlQuery("bst_workflowsel^"+state);
			
				
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				strQuery=SQLParser.getSqlQuery("bst_workflowcnt^"+strappno+"^"+correctNull(rs.getString("bst_flowpoint")));
				if(rs1!=null)
				rs1.close();
					
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					arrDone.add(rs1.getString(1));
				}
				arrFlowpoint.add(rs.getString("bst_flowpoint"));
				arrAction.add(rs.getString("wrk_flowname"));
				arrMaxclass.add(rs.getString("bst_minclass"));
			
				if(rs2!=null)rs2.close();
				
				strQuery1=SQLParser.getSqlQuery("selclasslist_workflow^"+strId+"^"+correctNull(rs.getString("bst_minclass")));
				rs2=DBUtils.executeQuery(strQuery1);
				if(rs2.next())
				{
					arrClassDesc.add(rs2.getString("stat_data_desc1"));
				}
			}
			
			
			if(!(strstatus.equalsIgnoreCase("op")))
			{
				if(strstatus.charAt(1)=='a')
				{
					state="a";
				}
				else
				{
					state="r";
				}
				strQuery=SQLParser.getSqlQuery("bst_workflowsel^"+state);
				
				
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					strQuery=SQLParser.getSqlQuery("bst_workflowcnt^"+strappno+"^"+correctNull(rs.getString("bst_flowpoint")));
					if(rs1!=null)
					rs1.close();
						
					rs1=DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						arrDone.add(rs1.getString(1));
					}
					arrFlowpoint.add(rs.getString("bst_flowpoint"));
					arrAction.add(rs.getString("wrk_flowname"));
					arrMaxclass.add(rs.getString("bst_minclass"));
				
					if(rs2!=null)rs2.close();
					
					strQuery1=SQLParser.getSqlQuery("selclasslist_workflow^"+strId+"^"+correctNull(rs.getString("bst_minclass")));
					rs2=DBUtils.executeQuery(strQuery1);
					if(rs2.next())
					{
						arrClassDesc.add(rs2.getString("stat_data_desc1"));
					}
				}
			}
				
			hshRecord.put("arrFlowpoint",arrFlowpoint);
			hshRecord.put("arrAction",arrAction);
			hshRecord.put("arrMaxclass",arrMaxclass);
			hshRecord.put("arrClassDesc",arrClassDesc);
			hshRecord.put("arrDone",arrDone);
			if(strAction.equalsIgnoreCase("send"))
			{
				hshRecord.put("status","SUCCESS");
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
	
	public HashMap updateBSTAction(HashMap hshValues)
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
				hshQuery.put("strQueryId","bst_insmailbox");//insert into bstmail table 
				arrValues.add(strAppno);
				arrValues.add(strFromuserid);
				arrValues.add(strTouserid);
				arrValues.add(strFromflowpoint);
				arrValues.add(strToflowpoint);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","upd_bstappholder");//update bst application table
				arrValues.add(strTouserid);
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","2");
				hshQueryValues.put("2",hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("approve")||strAction.equalsIgnoreCase("reject"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","upd_bstappstatus");//update application table - status
				
				if(strAction.equalsIgnoreCase("approve"))
				arrValues.add("pa");
				else
				arrValues.add("pr");
				arrValues.add(strFromuserid);
				//arrValues.add(Helper.getCurrentDateTime());
				arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
				arrValues.add(correctNull((String)hshValues.get("txt_sanctioncomments")));
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","bst_insmailbox");//insert into bstmail table 
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
			else if(strAction.equalsIgnoreCase("undo"))
			{
				strQuery=SQLParser.getSqlQuery("get_bstmaxflowpoint");
	     		rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strToflowpoint=correctNull((String)rs.getString("bst_flowpoint"));
				}
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","upd_bstappstatus");//update application table - status
				arrValues.add("op");
				arrValues.add("");
				//arrValues.add(Helper.getCurrentDateTime());
				arrValues.add("");
				arrValues.add(null);
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","bst_insmailbox");//insert into bstmail table 
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
			else if(strAction.equalsIgnoreCase("freeze"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","upd_workflowcloseapprove");
				
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
			AuditTrial.auditLog(hshValues,"316",strAppno,sbAuditTrial.toString());	
			
		}
		catch(Exception e)
		{
			throw new EJBException(e.toString());
		}
		return hshResult;
	}
	
	
	public void updateBSTComments(HashMap hshValues) 
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
				hshQuery.put("strQueryId","ins_bstmailcomments");
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
	
	
	public HashMap getBSTComments(HashMap hshValues) 
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
			
			rs=DBUtils.executeLAPSQuery("sel_bstmailcomments^"+strAppno);
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
	
	public void updateBSTSecurity(HashMap hshValues)
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		
		String strAppno="";
		String strAction="";
		String strSecno="";
		int intUpdatesize=0;
		StringBuilder sbolddata=new StringBuilder();
		ResultSet rs=null;
		try
		{
			strAction=correctNull((String)hshValues.get("hidAction"));
			strAppno=correctNull((String)hshValues.get("appno"));
			strSecno=correctNull((String)hshValues.get("hidsno"));
			
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
			{
				String strQuery=SQLParser.getSqlQuery("sel_bstsecdetailsbysno^"+strSecno+"^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					sbolddata.append("Security =").append(correctNull(rs.getString("sec_name")));
					sbolddata.append(" ~Security Type  = ").append(correctNull(rs.getString("bstsec_type")));
					sbolddata.append(" ~Security Value  = ").append(correctNull(rs.getString("bstsec_desc_value")));
					sbolddata.append(" ~Security Value as On  = ").append(correctNull(rs.getString("as_on_date")));
					sbolddata.append(" ~Valuers Name = ").append(correctNull(rs.getString("bstsec_valuersname")));
					sbolddata.append(" ~Security Tenor(In Months) = ").append(correctNull(rs.getString("bstsec_tenor")));
					sbolddata.append(" ~Insurance Amount = ").append(correctNull(rs.getString("bstsec_insuranceamt")));
					sbolddata.append(" ~Insurance Expiry Date  = ").append(correctNull(rs.getString("sec_insexpirydate")));
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
				arrValues.add(correctNull((String)hshValues.get("txtsectenor")));
				arrValues.add(correctNull((String)hshValues.get("selsectype")));
				
				arrValues.add(correctNull((String)hshValues.get("txtvaluername")));
				arrValues.add(correctNull((String)hshValues.get("txtinsuranceamt")));
				arrValues.add(correctNull((String)hshValues.get("txtinsexpdate")));
				arrValues.add(correctNull((String)hshValues.get("txtremarks")));
				hshQuery.put("strQueryId","ins_bstsecdetails");
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
				arrValues.add(correctNull((String)hshValues.get("txtsectenor")));
				arrValues.add(correctNull((String)hshValues.get("selsectype")));
				arrValues.add(correctNull((String)hshValues.get("txtvaluername")));
				arrValues.add(correctNull((String)hshValues.get("txtinsuranceamt")));
				arrValues.add(correctNull((String)hshValues.get("txtinsexpdate")));
				arrValues.add(correctNull((String)hshValues.get("txtremarks")));
				arrValues.add(strAppno);
				arrValues.add(strSecno);
				hshQuery.put("strQueryId","upd_bstsecdetails");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
			}
			else if(strAction.equals("Delete"))
			{
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				intUpdatesize++;
				
				arrValues.add(strAppno);
				arrValues.add(strSecno);
				hshQuery.put("strQueryId","del_bstsecdetails");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
			}
			
			hshQueryValues.put("size",""+intUpdatesize);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			//Audit Trial Starts Here
			StringBuilder sbAt = new StringBuilder();
		if(!(strAction.equalsIgnoreCase("delete")))
		{
			 sbAt=new StringBuilder();
			sbAt.append("Security =").append(correctNull((String)hshValues.get("txtsecdesc")));
			sbAt.append(" ~Security Type  = ").append(correctNull((String)hshValues.get("selsectype")));
			sbAt.append(" ~Security Value  = ").append(correctNull((String)hshValues.get("txtsecvalue")));
			sbAt.append(" ~Security Value as On  = ").append(correctNull((String)hshValues.get("txtsecvaldate")));
			sbAt.append(" ~Valuers Name = ").append(correctNull((String)hshValues.get("txtvaluername")));
			sbAt.append(" ~Security Tenor(In Months) = ").append(correctNull((String)hshValues.get("txtsectenor")));
			sbAt.append(" ~Insurance Amount = ").append(correctNull((String)hshValues.get("txtinsuranceamt")));
			sbAt.append(" ~Insurance Expiry Date  = ").append(correctNull((String)hshValues.get("txtinsexpdate")));
		}
		AuditTrial.auditNewLog(hshValues,"291",strAppno,sbAt.toString(),sbolddata.toString());
		}catch(Exception ex)
		{
			throw new EJBException("Error in updateBSTSecurity  :: "+ex.toString());
		}
	}
	
	
	public HashMap getDataBSTSecurity(HashMap hshValues)
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
			
			strQuery=SQLParser.getSqlQuery("sel_bstsecdetails^"+strAppno);
			
			rs=DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				
				arrCol=new ArrayList();
				arrCol.add(rs.getString("bstsec_srlno"));
				arrCol.add(rs.getString("bstsec_desc_id"));
				arrCol.add(rs.getString("sec_name"));
				arrCol.add(rs.getString("bstsec_desc_details"));
				arrCol.add(rs.getString("bstsec_desc_value"));
				arrCol.add(rs.getString("as_on_date"));
				arrCol.add(rs.getString("bstsec_tenor"));
				arrCol.add(rs.getString("bstsec_type"));
				arrCol.add(rs.getString("bstsec_valuersname"));
				arrCol.add(rs.getString("bstsec_insuranceamt"));
				arrCol.add(rs.getString("sec_insexpirydate"));
				arrCol.add(rs.getString("bstsec_remarks"));
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
			throw new EJBException("Error in updateData of ComSecuritiesBean :: "+ex.toString());
		}
		return hshRecord;
	}
	
	private String getMaxsecno(String strAppno) 
	{
		String strSecno="";
		ResultSet rs=null;
		String strQuery="";
		try
		{
			strQuery=SQLParser.getSqlQuery("selmax_bstsecdetails^"+strAppno);
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
	
	
	private String getMaxBSTfacilityId(String appno)
	{
		String strSno="";
		ResultSet rs=null;
		try
		{
				rs=DBUtils.executeLAPSQuery("sel_bstfacilityMaxid^"+appno);
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
	}
	private String getBSTAppno(String strSolid)
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
				strQuery=SQLParser.getSqlQuery("sel_BSTMaxAppno^"+strSolid);

				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					appno = (rs.getInt("appno"));
				}
				appno++;
				strappno=strSolid+1+nf.format(appno);
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
	
	private String getBSTMaxID()
	{
		String strQuery="";
		String strCompId="";
		
		ResultSet rs=null;
		try
		{
				strQuery=SQLParser.getSqlQuery("sel_maxbstcustid");

				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strCompId=Helper.correctNull(rs.getString("companyid"));
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
		return 	strCompId;
	}
	
	public HashMap getBSTAppnoData(HashMap hshValues)
	{
		HashMap hshRecord=null;
		
		ResultSet rs=null;
		
		String strcomappid="";
		String strQuery="";
		String strOrgSelect="";
		String strUserId="";
		//String strAppno="";
		String strappholder="";
		ArrayList arryCol=null;
		ArrayList arryRow=new ArrayList();
		try
		{
			hshRecord=new HashMap();
			strcomappid=correctNull((String)hshValues.get("id"));
			strOrgSelect=correctNull((String)hshValues.get("strOrgSelect"));
			strUserId=correctNull((String)hshValues.get("strUserId"));
			
			//
			strQuery=SQLParser.getSqlQuery("sel_bstappnolist^"+strcomappid+"^"+strOrgSelect);
				
				rs=DBUtils.executeQuery(strQuery);
			
				while(rs.next())
				{
					arryCol=new ArrayList();				 
					arryCol.add(correctNull((String)rs.getString("bstapp_no")));//0
					arryCol.add(correctNull((String)rs.getString("bstapp_status")));//1
					strappholder=correctNull((String)rs.getString("bstapp_applnholder"));
					if(strUserId.equalsIgnoreCase(strappholder))
					{
						arryCol.add("Y");//2
					}
					else
					{
						arryCol.add("N");//2
					}
					arryCol.add(correctNull((String)rs.getString("holdername")));//3
					arryRow.add(arryCol);
				}
				hshRecord.put("arryRow",arryRow);
		}
		catch(Exception ex)
		{
			throw new EJBException("Error in getBSTAppnoData  :: "+ex.toString());
		}
		return hshRecord;
	}
	
	public HashMap getOrgrecmds(HashMap hshValues) 
	{	
		ResultSet rs = null;
		HashMap hshRecord = null;
		String strAppno = "";
		String strorglevel="";
		String strQuery="";
		try
		{
			strAppno = correctNull((String)hshValues.get("appno"));
			strorglevel = correctNull((String)hshValues.get("sel_level"));
			hshRecord = new HashMap();

			strQuery=SQLParser.getSqlQuery("sel_bstorgcomments^"+strAppno+"^"+strorglevel);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("orglevel",correctNull(rs.getString("combst_orglevel")));
				hshRecord.put("orgcomments",correctNull(Helper.CLOBToString(rs.getClob("combst_orgrecmds"))));
				hshRecord.put("signatures",correctNull(rs.getString("combst_orgsignatories")));
				hshRecord.put("refno",correctNull(rs.getString("combst_refno")));
				hshRecord.put("datebst",correctNull(rs.getString("combst_refdate")));
			}
			hshRecord.put("branch_level",strorglevel);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getOrgrecmds BROADSANCTERMS bean ::  "+ce.toString());
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
	
	public void updateOrgrecmds(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAppno="";
		String strAction="";
		int intUpdatesize=0;
		try
		{	
			strAppno=correctNull((String )hshValues.get("appno"));
			strAction=correctNull((String )hshValues.get("hidAction"));
			if(strAction.equalsIgnoreCase("update"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();	
				intUpdatesize++;
				arrValues=new ArrayList();
				
				hshQuery.put("strQueryId","del_bstorgcomments");
				arrValues.add(strAppno);
				arrValues.add(correctNull((String)hshValues.get("sel_level")));

				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
				
				hshQuery = new HashMap();	
				intUpdatesize++;
				arrValues=new ArrayList();
				
				hshQuery.put("strQueryId","ins_bstorgcomments");
				arrValues.add(strAppno);
				arrValues.add(correctNull((String)hshValues.get("txt_orgcomments")));
				arrValues.add(correctNull((String)hshValues.get("sel_level")));
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);	
				
				hshQuery = new HashMap();	
				intUpdatesize++;
				arrValues=new ArrayList();
				
				hshQuery.put("strQueryId","upd_bstorgcomments");
				
				arrValues.add(correctNull((String)hshValues.get("txt_orgrefno")));
				arrValues.add(correctNull((String)hshValues.get("txt_orgbstdate")));
				arrValues.add(correctNull((String)hshValues.get("txt_orgsignatories")));
				//arrValues.add(correctNull((String)hshValues.get("sel_level")));
				arrValues.add(strAppno);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);	
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();	
				intUpdatesize++;
				arrValues=new ArrayList();
				
				hshQuery.put("strQueryId","del_bstorgcomments");
				arrValues.add(strAppno);
				arrValues.add(correctNull((String)hshValues.get("sel_level")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
			}
			hshQueryValues.put("size",""+intUpdatesize);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
		}
	}
	public void updateBankingArrangementData(HashMap hshValues) 
	{
		try
		{
			HashMap hshQueryValues = new HashMap();
			HashMap hshQuery = new HashMap();
			ArrayList arrValues = new ArrayList();
			String strAppno="";
			String strAction="";
			int intUpdatesize=0;
			
				strAction=correctNull((String)hshValues.get("hidAction"));
				strAppno=correctNull((String)hshValues.get("appno"));
				
				if(strAction.equals("Update"))
				{
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					intUpdatesize++;
					arrValues.add(strAppno);
					hshQuery.put("strQueryId","combst_bankingDetails_delete");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					intUpdatesize++;
					arrValues.add(strAppno);
					arrValues.add(correctNull((String)hshValues.get("mulbank")));
					arrValues.add(correctNull((String)hshValues.get("leadbank")));
					arrValues.add(correctNull((String)hshValues.get("wc_existfb")));
					arrValues.add(correctNull((String)hshValues.get("wc_propfb")));
					arrValues.add(correctNull((String)hshValues.get("wc_existnfb")));
					arrValues.add(correctNull((String)hshValues.get("wc_propnfb")));
					hshQuery.put("strQueryId","combst_bankingDetails_insert");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
				}
				else if(strAction.equals("Delete"))
				{
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					intUpdatesize++;
					arrValues.add(strAppno);
					hshQuery.put("strQueryId","combst_bankingDetails_delete");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
				}
				
				hshQueryValues.put("size",""+intUpdatesize);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				StringBuilder sbAt = new StringBuilder();
				String bnktype="";
			if(!(strAction.equals("Delete")))
			{
				if(correctNull((String)hshValues.get("mulbank")).equalsIgnoreCase("1"))
				{
					bnktype="Sole";
				}
				else if(correctNull((String)hshValues.get("mulbank")).equalsIgnoreCase("2"))
				{
					bnktype="Consortium";
				}
				else if(correctNull((String)hshValues.get("mulbank")).equalsIgnoreCase("3"))
				{
					bnktype="Multiple";
				}
				else if(correctNull((String)hshValues.get("mulbank")).equalsIgnoreCase("4"))
				{
					bnktype="Sole/Consortium";
				}
				else if(correctNull((String)hshValues.get("mulbank")).equalsIgnoreCase("5"))
				{
					bnktype="Sole/Multiple";
				}
				else if(correctNull((String)hshValues.get("mulbank")).equalsIgnoreCase("6"))
				{
					bnktype="Consortium/Multiple";
				}
				else if(correctNull((String)hshValues.get("mulbank")).equalsIgnoreCase("7"))
				{
					bnktype="Sole/Consortium/Multiple";
				}
				
				sbAt=new StringBuilder();
				sbAt.append("Sole/Consortium/Multiple Banking  =").append(bnktype);
				sbAt.append(" ~Lead Bank  = ").append(correctNull((String)hshValues.get("leadbank")));
				sbAt.append(" ~Existing Fund Based (WC + TL) = ").append(Helper.formatDoubleValue(Double.parseDouble((Helper.correctDouble((String)hshValues.get("wc_existfb"))))));
				sbAt.append(" ~Fun Based Proposed = ").append(Helper.formatDoubleValue(Double.parseDouble((Helper.correctDouble((String)hshValues.get("wc_propfb"))))));
				sbAt.append(" ~Existing Non Fund Based = ").append(Helper.formatDoubleValue(Double.parseDouble((Helper.correctDouble((String)hshValues.get("wc_existnfb"))))));
				sbAt.append(" ~Non Fund Based Proposed = ").append(Helper.formatDoubleValue(Double.parseDouble((Helper.correctDouble((String)hshValues.get("wc_propnfb"))))));
			}  
			   AuditTrial.auditLog(hshValues,"292",strAppno,sbAt.toString());
			
		}catch(Exception ex)
		{
			throw new EJBException("Error in updateBankingArrangementData of broadsanctermsBean :: "+ex.toString());
		}
	}
	
	public HashMap getBankingArrangementData(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;
		boolean recordflag=false;
		try
		{
			String strAppno="";
			String strQuery="";
			hshRecord=new HashMap();
			strAppno=correctNull((String)hshValues.get("appno"));
			strQuery=SQLParser.getSqlQuery("combst_bankingDetails_select^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("cb_banktype",rs.getString("cb_banktype"));
				hshRecord.put("cb_leadbank",rs.getString("cb_leadbank"));
				hshRecord.put("cb_fundexist",rs.getString("cb_fundexist"));
				hshRecord.put("cb_fundproposed",rs.getString("cb_fundproposed"));
				hshRecord.put("cb_nonfundexist",rs.getString("cb_nonfundexist"));
				hshRecord.put("cb_nonfundproposed",rs.getString("cb_nonfundproposed"));
				recordflag=true;
			}
			 if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
			
		}catch(Exception ex)
		{
			throw new EJBException("Error in getBankingArrangementData of broadsanctermsBean :: "+ex.toString());
		}
		finally
		{
			try{
				if(rs!=null)
				{
					rs.close();
				}
			}
			catch(Exception ex)
			{
				throw new EJBException("Error in Closing the connection"+ ex.toString());
			}
		}
		return hshRecord;
	}
	public void updateCreditFacilitiesData(HashMap hshValues)
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
	    ResultSet rs = null;
		String strAppno="";
		int intUpdateSize=0;
		String strSno="";
		String strBankName="";
		String strFacility="";
		String strExistLimit="";
		String strAppROI="";
		String StrPresentROI="";
		String strFacilitygroup="0";
		String strAction = "";
		String strFactype = "";
		String strQuery = "";
		StringBuilder sbolddata=new StringBuilder();
		try
		{
			strSno=correctNull((String)hshValues.get("hidsno"));
			strFactype=correctNull((String)hshValues.get("hidfactype"));
		    strAction=(String)hshValues.get("hidAction");
		    strAppno=correctNull((String)hshValues.get("appno"));	
			if(strFactype.equals("sublimit"))
			{
				strBankName=correctNull((String)hshValues.get("txt_subbankname"));
				strFacility=correctNull((String)hshValues.get("txt_subfacility"));
				strExistLimit=Helper.correctDouble((String)hshValues.get("txt_sublimitexist"));
				strAppROI=correctNull((String)hshValues.get("txt_subapplicable_roi"));
				StrPresentROI=correctNull((String)hshValues.get("txt_subpresent_roi"));
				strFacilitygroup=correctNull((String)hshValues.get("hidfacgrp"));
			}
			else
			{
				strBankName=correctNull((String)hshValues.get("txt_bankname"));
				strFacility=correctNull((String)hshValues.get("txt_facility"));
				strExistLimit=Helper.correctDouble((String)hshValues.get("txt_limitexist"));
				strAppROI=correctNull((String)hshValues.get("txt_applicable_roi"));
				StrPresentROI=correctNull((String)hshValues.get("txt_present_roi"));
				
			}
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
			{
				strQuery=SQLParser.getSqlQuery("combst_existcreditlimits_selectbysno^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);	
				while(rs.next())
				{
					if(correctNull((String)rs.getString("cf_facgroup")).equalsIgnoreCase("0"))
					{
						sbolddata.append("Name of the Bank/FI =").append(correctNull(rs.getString("cf_bankname")));
						sbolddata.append(" ~Nature of Facility  = ").append(correctNull(rs.getString("cf_facnature")));
						sbolddata.append(" ~Existing Limit = ").append(Helper.formatDoubleValue(rs.getDouble("cf_existlimit")));
						sbolddata.append(" ~Applicable ROI/Commision = ").append(correctNull(rs.getString("cf_approi")));
						sbolddata.append(" ~Presently charged ROI/Commision= ").append(correctNull(rs.getString("cf_presentroi")));
					}
					if(!correctNull((String)rs.getString("cf_facgroup")).equalsIgnoreCase("0"))
					{
						sbolddata.append(" ~Sub-Limits</b> ");
						sbolddata.append(" ~Nature of Facility = ").append(correctNull(rs.getString("cf_facnature")));
						sbolddata.append(" ~Existing Limit  = ").append(Helper.formatDoubleValue(rs.getDouble("cf_existlimit")));
						sbolddata.append(" ~Applicable ROI/Commision = ").append(correctNull(rs.getString("cf_approi")));
						sbolddata.append(" ~Presently charged ROI/Commision  = ").append(correctNull(rs.getString("cf_presentroi")));
					}
				}
			}
			
			if(strAction.equalsIgnoreCase("delete"))
			{
				
				strQuery = SQLParser.getSqlQuery("combst_existcreditlimits_deletecheck^"+strAppno +"^"+strSno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					String strExp="$" + "You can't delete the facility, sub-limit exists"; 
					throw new Exception(strExp);
				
				}
				else
				{
					intUpdateSize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","combst_existcreditlimits_delete");
					arrValues.add(strAppno);
					arrValues.add(strSno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdateSize));
					hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);	
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
			}
			else if(strAction.equalsIgnoreCase("insert"))
			{
				intUpdateSize++;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","combst_existcreditlimits_insert");
				arrValues.add(strAppno);
				arrValues.add(getMaxfacilitySecurityId("Facility",strAppno));
				arrValues.add(strFacilitygroup);
				arrValues.add(strBankName);
				arrValues.add(strFacility);
				arrValues.add(strExistLimit);	
				arrValues.add(strAppROI);	
				arrValues.add(StrPresentROI);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdateSize));
				hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("update"))
			{
				intUpdateSize++;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","combst_existcreditlimits_update");	
				arrValues.add(strFacilitygroup);
				arrValues.add(strBankName);
				arrValues.add(strFacility);
				arrValues.add(strExistLimit);	
				arrValues.add(strAppROI);	
				arrValues.add(StrPresentROI);
				arrValues.add(strAppno);
				arrValues.add(strSno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdateSize));
				hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			//Audit Trial Starts Here
			
			StringBuilder sbAt = new StringBuilder();
			
		if(!(strAction.equalsIgnoreCase("delete")))
		{
			sbAt.append("Name of the Bank/FI =").append(correctNull((String)hshValues.get("txt_bankname")));
			sbAt.append(" ~Nature of Facility  = ").append(correctNull((String)hshValues.get("txt_facility")));
			sbAt.append(" ~Existing Limit = ").append(correctNull((String)hshValues.get("txt_limitexist")));
			sbAt.append(" ~Applicable ROI/Commision = ").append(correctNull((String)hshValues.get("txt_applicable_roi")));
			sbAt.append(" ~Presently charged ROI/Commision= ").append(correctNull((String)hshValues.get("txt_present_roi")));
			if(correctNull((String)hshValues.get("chksublimit")).equalsIgnoreCase("N") || correctNull((String)hshValues.get("chksublimit")).equalsIgnoreCase("Y"))
			{
				sbAt.append(" ~Sub-Limits</b> ");
				sbAt.append(" ~Nature of Facility = ").append(correctNull((String)hshValues.get("txt_subfacility")));
				sbAt.append(" ~Existing Limit  = ").append(correctNull((String)hshValues.get("txt_sublimitexist")));
				sbAt.append(" ~Applicable ROI/Commision = ").append(correctNull((String)hshValues.get("txt_subapplicable_roi")));
				sbAt.append(" ~Presently charged ROI/Commision  = ").append(correctNull((String)hshValues.get("txt_subpresent_roi")));
			}
		}
			AuditTrial.auditNewLog(hshValues,"293",strAppno,sbAt.toString(),sbolddata.toString());
					
		}
		catch(Exception e1)
		{
			throw new EJBException(e1.getMessage());
		}
		finally
		{
			try
			{
				if(rs!=null)
					rs.close();
			}
			catch(Exception ce)
			{
				throw new EJBException("Error closing the connection "
						+ ce.getMessage());
			}
		}
	}
	private String getMaxfacilitySecurityId(String facsectype,String strAppno)
	{
		String strSno="";
		ResultSet rs=null;
		try
		{
			if(facsectype.equals("Facility"))
			{
				rs=DBUtils.executeLAPSQuery("combst_existcreditlimits_selectmax^"+strAppno);
				if(rs.next())
				{
					strSno = correctNull(rs.getString("srno"));
				}
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
	}
	public HashMap getCreditFacilitiesData(HashMap hshValues)
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;
		ResultSet rs1=null;
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		String strInwardno="";
		String strQuery="";
		String strAppno="";
		String strSaral="";
		boolean recordflag=false;
		try
		{
		
			strSaral= correctNull((String)hshValues.get("hidsaral"));	
			strAppno= correctNull((String)hshValues.get("appno"));	
			strQuery=SQLParser.getSqlQuery("combst_existcreditlimits_select^"+strAppno+"^0");
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol = new ArrayList();
				String strFacsno=correctNull(rs.getString("cf_facsno"));
				arrCol.add(strFacsno);
				arrCol.add(correctNull(rs.getString("cf_facgroup")));
				arrCol.add(correctNull(rs.getString("cf_bankname")));
				arrCol.add(correctNull(rs.getString("cf_facnature")));
				arrCol.add(Helper.correctDouble(rs.getString("cf_existlimit")));
				arrCol.add(correctNull(rs.getString("cf_approi")));
				arrCol.add(correctNull(rs.getString("cf_presentroi")));
				arrRow.add(arrCol);
			    strQuery=SQLParser.getSqlQuery("combst_existcreditlimits_select^"+strAppno+"^"+strFacsno);
				
				if(rs1!=null)
					rs1.close();
				
				rs1=DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{
					arrCol = new ArrayList();
					arrCol.add(correctNull(rs1.getString("cf_facsno")));//0
					arrCol.add(correctNull(rs1.getString("cf_facgroup")));//1
					arrCol.add(correctNull(rs1.getString("cf_bankname")));//2
					arrCol.add(correctNull(rs1.getString("cf_facnature")));//3
					arrCol.add(Helper.correctDouble(rs1.getString("cf_existlimit")));//4
					arrCol.add(correctNull(rs1.getString("cf_approi")));//5
					arrCol.add(correctNull(rs1.getString("cf_presentroi")));//6
					arrRow.add(arrCol);
				}
				recordflag=true;				
			}			
			hshRecord.put("arrRow",arrRow);
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
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
	public void updateDefaultersListData(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = new ArrayList();
		int updateSize=0;
		String strAppno = null;
 		String strAction = null;
	
		try {
			
			strAction = (String) hshValues.get("hidAction");
			strAppno = correctNull((String) hshValues.get("appno"));
			if (strAction.trim().equals("update")) {
		
				updateSize++;
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "combst_defaulterslist_delete");
				arrValues.add(strAppno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(Integer.toString(updateSize),hshQuery);
				hshQueryValues.put("size",Integer.toString(updateSize));
					
				updateSize++;
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "combst_defaulterslist_insert");
    			arrValues.add(strAppno);
				arrValues.add(correctNull((String) hshValues.get("txt_defaulterslist")));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(Integer.toString(updateSize),hshQuery);
				hshQueryValues.put("size",Integer.toString(updateSize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			
			else if (strAction.trim().equals("delete")) {
				updateSize++;
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "combst_defaulterslist_delete");
				arrValues.add(strAppno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(Integer.toString(updateSize),hshQuery);
				hshQueryValues.put("size",Integer.toString(updateSize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
			}
		}

		catch (Exception ce) {
			throw new EJBException("Errorn in updateDefaultersListData" + ce.toString());
		}

	}
	public HashMap getDefaultersListData(HashMap hshValues)  {
		
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strAppno = null;
		String strQuery=null;

		try {
			strAppno = "";
			strQuery = "";
			strAppno=correctNull((String)hshValues.get("appno"));
			strQuery = SQLParser.getSqlQuery("combst_defaulterslist_select^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("cd_comments", correctNull(Helper.CLOBToString(rs.getClob("cd_comments"))));
			}

		} catch (Exception ce) {
			log.error(ce.toString());
			throw new EJBException("Error in getDefaultersListData " + ce.toString());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());

			}
		}
		return hshRecord;

	}
}