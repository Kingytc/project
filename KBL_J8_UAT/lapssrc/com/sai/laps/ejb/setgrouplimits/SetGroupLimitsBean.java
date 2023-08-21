package com.sai.laps.ejb.setgrouplimits;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

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

@Stateless(name = "SetGroupLimitsBean", mappedName = "SetGroupLimitsHome")
@Remote (SetGroupLimitsRemote.class)
public class SetGroupLimitsBean extends BeanAdapter
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 7987108699564182112L;
	static Logger log=Logger.getLogger(SetGroupLimitsBean.class);
	/**
	 * 
	 */
	

	public HashMap getGroupLimitListData(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		HashMap hshRecord = null;
		ArrayList arrValues=null;
		try
		{
			rs=DBUtils.executeLAPSQuery("selgrouplimits");
			hshRecord = new HashMap();
			while(rs.next())
			{
				arrValues=new ArrayList();
				String strId=rs.getString("disc_grpid");
				String strName=rs.getString("disc_grpname");
				arrValues.add(strName);
				hshRecord.put(strId,arrValues);
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



	public HashMap getData(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		HashMap hshRecord = null;
		String strId=null;
		String strgrpname="";
		boolean recordflag=false;
		try
		{
            strId=(String)hshRequestValues.get("grp_id");
            strgrpname=(String)hshRequestValues.get("dis_authname");
			strId=correctSingleQuote(strId); 
			if(strId.equals(""))
			{
				rs=DBUtils.executeLAPSQuery("selgrouplimitsdetailsbyname^"+strgrpname);
			}
			else{
			rs=DBUtils.executeLAPSQuery("selgrouplimitsdetails^"+strId);
			}
			hshRecord = new HashMap();
			while(rs.next())
			{
				recordflag=true;
				hshRecord.put("disc_grpid",correctNull(rs.getString("disc_grpid")));
				hshRecord.put("disc_grpname",correctNull(rs.getString("disc_grpname")));
				hshRecord.put("disc_perpartyanncap",correctNull(rs.getString("disc_perpartyanncap")));
				hshRecord.put("disc_grouplimit",correctNull(rs.getString("disc_grouplimit")));
				hshRecord.put("disc_perptyfundbased",correctNull(rs.getString("disc_perptyfundbased")));
				hshRecord.put("disc_perptynonfund",correctNull(rs.getString("disc_perptynonfund")));
				hshRecord.put("disc_perptyunsecured",correctNull(rs.getString("disc_perptyunsecured")));
				hshRecord.put("disc_adhocsanclimit",correctNull(rs.getString("disc_adhocsanclimit")));
				hshRecord.put("disc_adhocmonths",correctNull(rs.getString("disc_adhocmonths")));
				hshRecord.put("disc_adhocunsecured",correctNull(rs.getString("disc_adhocunsecured")));
				hshRecord.put("disc_guarantee",correctNull(rs.getString("disc_guarantee")));
				hshRecord.put("disc_workingcapital",correctNull(rs.getString("disc_workingcapital")));
				hshRecord.put("disc_lgmargin",correctNull(rs.getString("disc_lgmargin")));
				hshRecord.put("disc_lgwomargin",correctNull(rs.getString("disc_lgwomargin")));
				hshRecord.put("disc_lc",correctNull(rs.getString("disc_lc")));
				hshRecord.put("disc_termloan",correctNull(rs.getString("disc_termloan")));
				hshRecord.put("disc_bankdeposits",correctNull(rs.getString("disc_bankdeposits")));
				hshRecord.put("disc_lcpb",correctNull(rs.getString("disc_lcpb")));

			}
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
		}
		catch(Exception e)
		{
			log.error("exception in getData... "+e);
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
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String strKeyId = "";
		StringBuilder sbolddata=new StringBuilder();
		String strQuery="";
		ResultSet rs2 = null;
		StringBuilder sbAt = new StringBuilder();
		try
		{
			strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			String sancmonths = correctNull((String)hshValues.get("dis_authsancmonths"));
			String strGrpid = Helper.correctNull((String)hshValues.get("grp_id"));
			if(sancmonths.trim().equals(""))
			{
				sancmonths ="0";
			}			
			hshQueryValues.put("size","1");
			ResultSet rs1=null;
			int intCount1=0;String strExp1="$";
			String dis_authname=correctNull((String)hshValues.get("dis_authname"));
			dis_authname=dis_authname.toUpperCase();
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
			{
				strQuery=SQLParser.getSqlQuery("selgrouplimitsdetails^"+strGrpid);
				rs2=DBUtils.executeQuery(strQuery);	
				if(rs2.next())
				{
					sbolddata.append("Authority="+correctNull((String)rs2.getString("disc_grpname")));
			       	sbolddata.append("~Annual Cap Per Party="+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs2.getString("disc_perpartyanncap")))));
			       //sbolddata.append("~Annual Cap Group Limit="+Helper.correctDouble((String)rs2.getString("disc_grouplimit")));
			       	sbolddata.append("~Fund Based="+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs2.getString("disc_perptyfundbased")))));
			       	sbolddata.append("~Term Loan="+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs2.getString("disc_termloan")))));
			       	sbolddata.append("~Working Capital ="+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs2.getString("disc_workingcapital")))));
			       	sbolddata.append("~W/w Unsecured Advances, not to exceed ="+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs2.getString("disc_perptyunsecured")))));
			       	sbolddata.append("~Non Fund Based ="+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs2.getString("disc_perptynonfund")))));
			       	sbolddata.append("~Maximum Adhoc Limit ="+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs2.getString("disc_adhocsanclimit")))));
			       	sbolddata.append("~For no. of Adhoc months="+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs2.getString("disc_adhocmonths")))));;
			       	sbolddata.append("~W/w Unsecured Adhoc Limit   ="+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs2.getString("disc_adhocunsecured")))));
			       	//sbolddata.append("~Letter of Guarantee with 100% cash margin / Term Deposits under Lien (Non Fund Based Limits) ="+Helper.correctDouble((String)rs2.getString("disc_lgmargin")));
			       //sbolddata.append("~Clean LG ="+Helper.correctDouble((String)rs2.getString("disc_lgwomargin")));
			       	
			       	sbolddata.append("~Letter of Guarantee with 100% cash margin / Term Deposits under Lien (Non Fund Based Limits) ="+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs2.getString("disc_guarantee")))));
			       	sbolddata.append("~Letter of Credit with 100% cash margin / Term Deposits under Lien (In respect of import LC 110% Cash Margin/ Term Deposit under Lien) ="+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs2.getString("disc_lc")))));
			       	sbolddata.append("~Advances against Banks Own Deposits ="+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs2.getString("disc_bankdeposits")))));
			       	sbolddata.append("~Advances Under LC of Prime Bank ="+Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs2.getString("disc_lcpb")))));
				}
				if(rs2!=null)
				{
					rs2.close();
				}
			}
			if(strAction.equalsIgnoreCase("insert"))
			{
				rs1=DBUtils.executeLAPSQuery("setdupcheckgroup^"+dis_authname);
				if(rs1.next())
				{
					intCount1 = Integer.parseInt(rs1.getString(1));
				}
				if(rs1!=null)
				{
					rs1.close();
				}
				if(intCount1 == 0)
				{
					hshQuery.put("strQueryId","insgrouplimits");
					arrValues.add(getGroupId());
					arrValues.add(dis_authname);
					arrValues.add(Helper.correctDouble((String)hshValues.get("dis_authperparty")));
					arrValues.add(Helper.correctDouble((String)hshValues.get("dis_authgrplimit")));
					arrValues.add(Helper.correctDouble((String)hshValues.get("dis_authfundbased")));
					arrValues.add(Helper.correctDouble((String)hshValues.get("dis_authnonfundbased")));
					arrValues.add(Helper.correctDouble((String)hshValues.get("dis_authunsecadv")));
					arrValues.add(Helper.correctDouble((String)hshValues.get("dis_authmaxsanclimit")));
					arrValues.add(sancmonths);
					arrValues.add(Helper.correctDouble((String)hshValues.get("disc_adhocunsecured")));
					arrValues.add(Helper.correctDouble((String)hshValues.get("disc_lgcashmargin")));
					//arrValues.add(Helper.correctDouble((String)hshValues.get("dis_perptytotal")));
					arrValues.add(Helper.correctDouble((String)hshValues.get("dis_workingcapital")));
					arrValues.add(Helper.correctDouble((String)hshValues.get("dis_termloan")));
					arrValues.add(Helper.correctDouble((String)hshValues.get("dis_lgmargin")));
					arrValues.add(Helper.correctDouble((String)hshValues.get("dis_lgwomargin")));
					arrValues.add(Helper.correctDouble((String)hshValues.get("dis_lccashmargin")));
					arrValues.add(Helper.correctDouble((String)hshValues.get("dis_banksdeposits")));
					arrValues.add(Helper.correctDouble((String)hshValues.get("dis_lcprimebank")));
					
				}
				
				else{
					strExp1 = strExp1+"Cannot insert the authority name,it already exists";
					throw new Exception(strExp1);					
				}				
		    }
			if(strAction.equalsIgnoreCase("update"))
			{
				hshQuery.put("strQueryId","updtgrouplimits");
				arrValues.add(dis_authname);
				arrValues.add(Helper.correctDouble((String)hshValues.get("dis_authperparty")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("dis_authgrplimit")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("dis_authfundbased")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("dis_authnonfundbased")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("dis_authunsecadv")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("dis_authmaxsanclimit")));
				arrValues.add(sancmonths);
				arrValues.add(Helper.correctDouble((String)hshValues.get("disc_adhocunsecured")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("disc_lgcashmargin")));
				//arrValues.add(Helper.correctDouble((String)hshValues.get("dis_perptytotal")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("dis_workingcapital")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("dis_termloan")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("dis_lgmargin")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("dis_lgwomargin")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("dis_lccashmargin")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("dis_banksdeposits")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("dis_lcprimebank")));
				arrValues.add(hshValues.get("grp_id"));
			}
			ResultSet rs=null;
			int intCount2=0;
			String strExp= "$";
			String grp_id=correctNull((String)hshValues.get("grp_id"));
			if(strAction.equalsIgnoreCase("delete"))
			{
				rs=DBUtils.executeLAPSQuery("setdelchecklending^"+grp_id);
				if(rs.next())
				{
					intCount2 = Integer.parseInt(rs.getString(1));
				}
				if(rs!=null)
				{
					rs.close();
				}
				if(intCount2 == 0)
				{
					hshQuery=new HashMap();
					hshQuery.put("strQueryId","delgrouplimits");
					arrValues.add(hshValues.get("grp_id"));
					
					
				}
				else{
					strExp = strExp+"Cannot delete this authority, its attached to group";
					throw new Exception(strExp);
					
				}
				
			}
			hshQuery.put("arrValues",arrValues);
	       	hshQueryValues.put("1",hshQuery);
	       	EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");

			//for Entering the values into auditrial
	       	if(!strAction.equalsIgnoreCase("delete"))
	       	{
	       		sbAt.append("Authority="+correctNull((String)hshValues.get("dis_authname")));
		       	sbAt.append("~Annual Cap Per Party="+Helper.correctDouble((String)hshValues.get("dis_authperparty")));
		       	//sbAt.append("~Annual Cap Group Limit="+Helper.correctDouble((String)hshValues.get("dis_authgrplimit")));
		       	sbAt.append("~Fund Based="+Helper.correctDouble((String)hshValues.get("dis_authfundbased")));
		       	sbAt.append("~Term Loan="+Helper.correctDouble((String)hshValues.get("dis_termloan")));
		       	sbAt.append("~Working Capital ="+Helper.correctDouble((String)hshValues.get("dis_workingcapital")));
		       	sbAt.append("~W/w Unsecured Advances, not to exceed ="+Helper.correctDouble((String)hshValues.get("dis_authunsecadv")));
		       	sbAt.append("~Non Fund Based ="+Helper.correctDouble((String)hshValues.get("dis_authnonfundbased")));
		    	sbAt.append("~Maximum Adhoc Limit ="+Helper.correctDouble((String)hshValues.get("dis_authmaxsanclimit")));
		    	sbAt.append("~For no. of Adhoc months="+sancmonths);
		    	sbAt.append("~W/w Unsecured Adhoc Limit   ="+Helper.correctDouble((String)hshValues.get("disc_adhocunsecured")));
		    	sbAt.append("~Letter of Guarantee with 100% cash margin / Term Deposits under Lien (Non Fund Based Limits) ="+Helper.correctDouble((String)hshValues.get("disc_lgcashmargin")));
		    	sbAt.append("~Letter of Credit with 100% cash margin / Term Deposits under Lien (In respect of import LC 110% Cash Margin/ Term Deposit under Lien) ="+Helper.correctDouble((String)hshValues.get("dis_lccashmargin")));
		    	sbAt.append("~Advances against Banks Own Deposits ="+Helper.correctDouble((String)hshValues.get("dis_banksdeposits")));
		       	sbAt.append("~Advances Under LC of Prime Bank ="+Helper.correctDouble((String)hshValues.get("dis_lcprimebank")));
		       	
		       //	sbAt.append("~Clean LG ="+Helper.correctDouble((String)hshValues.get("dis_lgwomargin")));
		       //	sbAt.append("~Aggregate ="+Helper.correctNull((String)hshValues.get("dis_perptytotal")));
		       	//sbAt.append("~LG with minimum 10% cash margin ="+Helper.correctDouble((String)hshValues.get("dis_lgmargin")));
		       
		       	if(correctNull((String)hshValues.get("hidRecordflag")).equals("Y"))
				hshValues.put("hidAction", "update");
			}
	       	AuditTrial.auditNewLog(hshValues,"6",strKeyId,sbAt.toString(),sbolddata.toString());			
		}
		catch(Exception ce)
		{
			log.error("in bean... "+ce);
			throw new EJBException("Error in updateData "+ce.toString());
		}		
	}

	private String getGroupId()
	{
		ResultSet rs=null;
		String strGroupId="1";
		try
		{
			 rs=DBUtils.executeLAPSQuery("setgrouplimitsid");
			if(rs.next())
			{
				int intgrpid = rs.getInt(1)+1;
				strGroupId=Integer.toString(intgrpid);
			}
			else
			{
				strGroupId = rs.getString(1);
			}
		}
		catch(Exception e)
		{
			log.error("exception in geGroupId.. "+e);
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
				log.error("Error closing the connection "+cf.getMessage());
						
			}
		}
		return strGroupId;
	}
}
