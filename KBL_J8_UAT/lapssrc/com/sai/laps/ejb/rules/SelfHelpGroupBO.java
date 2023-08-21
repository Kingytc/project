package com.sai.laps.ejb.rules;

import java.sql.Date;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.ejb.EJBException;

import com.sai.fw.management.log.LogWriter;
import com.sai.fw.management.utils.FwHelper;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.Helper;
public class SelfHelpGroupBO {
	/**
	 * Method to get shg group details. Used in customer profile
	 * @param strappid
	 * @return
	 * @throws Exception
	 */
	public ArrayList getSHGDetailsByAppId(String strappid)throws Exception
	{
		ResultSet rs = null;
		ArrayList arrCol =new ArrayList();
		ArrayList arrRow=new ArrayList();
		try {
			rs=DBUtils.executeLAPSQuery("per_selfhelpgroupdetails_select^"+strappid);				
 		
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(Helper.correctNull((String)rs.getString("PA_SNO")));	//0 sno
				arrCol.add(Helper.correctNull((String)rs.getString("PA_APPID")));	//1 
				arrCol.add(Helper.correctNull((String)rs.getString("PA_MEMBERNAME")));//2
				arrCol.add(Helper.correctNull((String)rs.getString("PA_RELATIONTYPE")));//3
				arrCol.add(Helper.correctNull((String)rs.getString("PA_RELATIONNAME")));//4
				arrCol.add(Helper.correctNull((String)rs.getString("PA_AGE")));//5
				arrCol.add(Helper.correctNull((String)rs.getString("PA_VILLAGE")));//6
				arrCol.add(Helper.correctNull((String)rs.getString("PA_POSITION")));//7
				arrRow.add(arrCol);	
			}
			arrCol=null;
			}
		catch (Exception e) {
			if(rs!=null){rs.close();}
			LogWriter.log("Error in getSHGDetailsByAppId of SelfHelpGroupBO::" +e.getMessage());
			throw new EJBException("Error in getSHGDetailsByAppId === SelfHelpGroupBO"+e.toString());
			
		}
		return arrRow;
	}
	/**
	 * Method to get shg meeting details added on 10-04-2010
	 * @param strAppNo
	 * @return
	 * @throws Exception
	 */
	public ArrayList getSHGMeetingDetailByAppno(String strAppNo) throws Exception
	{
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		ResultSet rs=null;
	
		try {
			rs=DBUtils.executeLAPSQuery("agr_groupmeetingdetails_select^"+strAppNo);
			while(rs.next())
			{
				arrCol=new ArrayList();
				
				arrCol.add(Helper.correctNull(rs.getString("agr_appno")));//0 Appno
				arrCol.add(Helper.correctNull(rs.getString("agr_sno")));//1  serial number
				arrCol.add(Helper.correctNull(rs.getString("agr_dateofmeeting")));//2 Meeting date
				arrCol.add(Helper.correctNull(rs.getString("agr_attendance")));//3 attendance
				arrCol.add(Helper.correctNull(rs.getString("agr_dateofremittance")));//4 date of remittance
				arrCol.add(Helper.correctNull(rs.getString("agr_amountremitted")));//5 amount remited
					
				arrRow.add(arrCol);	
		}
			arrCol=null;
		} catch (Exception e) {
			if(rs!=null){rs.close();}
			LogWriter.log("Error in getSHGMeetingDetailByAppno of SelfHelpGroupBO::" +e.getMessage());
			throw new EJBException("Error in getSHGMeetingDetailByAppno === SelfHelpGroupBO"+e.toString());
		}
		return arrRow;
	}
	
	public HashMap getCreditRatingByAppno(String strAppNo) throws Exception
	{
		HashMap hshAgency=new HashMap();
		ResultSet rs=null;
		try 
		{
			rs=DBUtils.executeLAPSQuery("agr_shgcategory_select^"+strAppNo);
			while(rs.next())
			{
				
				hshAgency.put("appno", Helper.correctNull(rs.getString("agr_appno")));
				hshAgency.put("rating", Helper.correctNull(rs.getString("agr_rating")));
				hshAgency.put("earlierrating", Helper.correctNull(rs.getString("agr_earlierrating")));
				hshAgency.put("lastgradingdate", Helper.correctNull(rs.getString("agr_lastgradingdate")));
				hshAgency.put("ratingdoneby", Helper.correctNull(rs.getString("agr_ratingdoneby")));
				
			}
			if(rs!=null){rs.close();}
			
		} catch (Exception e) {
			if(rs!=null){rs.close();}
			LogWriter.log("Error in getCreditRatingByAppno SelfHelpGroupBO::" +e.getMessage());
			throw new EJBException("Error in getCreditRatingByAppno === SelfHelpGroupBO"+e.toString());
			
		}
		
		
		return hshAgency;
	}
	public HashMap getSHGFinancePositionByAppno(String strAppNo,String schemetype,String facno) throws Exception
	{
		HashMap hshFinancePosition=new HashMap();
		ResultSet rs=null;
		try 
		{
			rs=DBUtils.executeLAPSQuery("agr_shgfinanceposition_select^"+strAppNo+"^"+schemetype+"^"+facno);
			while(rs.next())
			{
				hshFinancePosition.put("appno", Helper.correctNull(rs.getString("agr_appno")));
				hshFinancePosition.put("cumsavings", Helper.correctNull(rs.getString("agr_cumsavings")));
				hshFinancePosition.put("intcollected", Helper.correctNull(rs.getString("agr_intcollected")));
				hshFinancePosition.put("rfa", Helper.correctNull(rs.getString("agr_rfa")));
				hshFinancePosition.put("fines", Helper.correctNull(rs.getString("agr_fines")));
				hshFinancePosition.put("bankloan", Helper.correctNull(rs.getString("agr_bankloan")));
				hshFinancePosition.put("sourcetotal", Helper.correctNull(rs.getString("agr_sourcetotal")));
				hshFinancePosition.put("outstandingloan", Helper.correctNull(rs.getString("agr_outstandingloan")));
				hshFinancePosition.put("cashinhand", Helper.correctNull(rs.getString("agr_cashinhand")));
				hshFinancePosition.put("savingsbal", Helper.correctNull(rs.getString("agr_savingsbal")));
				hshFinancePosition.put("deposits", Helper.correctNull(rs.getString("agr_deposits")));
				hshFinancePosition.put("otherexpenditure", Helper.correctNull(rs.getString("agr_otherexpenditure")));
				hshFinancePosition.put("usetotal", Helper.correctNull(rs.getString("agr_usetotal")));
				hshFinancePosition.put("difference", Helper.correctNull(rs.getString("agr_difference")));
			}
			if(rs!=null){rs.close();}
			
		} catch (Exception e) {
			if(rs!=null){rs.close();}
			LogWriter.log("Error in getSHGFinancePositionByAppno SelfHelpGroupBO::" +e.getMessage());
			throw new EJBException("Error in getSHGFinancePositionByAppno === SelfHelpGroupBO"+e.toString());
		}
		return hshFinancePosition;
	}
	
	
	
	private String correctNull(String string) {
		// TODO Auto-generated method stub
		return null;
	}
	public HashMap getSHGDetailsByComments(String strAppNo) throws Exception
	{
		HashMap hshAgency=new HashMap();
		ResultSet rs=null;
		try 
		{
			rs=DBUtils.executeLAPSQuery("per_selfhelpgroupcomments_select^"+strAppNo);
			while(rs.next())
			{
				
				hshAgency.put("appno", Helper.correctNull(rs.getString("shg_appid")));
				hshAgency.put("comments", Helper.correctNull(rs.getString("shg_comments")));
				
			}
			if(rs!=null){rs.close();}
			
		} catch (Exception e) {
			if(rs!=null){rs.close();}
			LogWriter.log("Error in getCreditRatingByAppno SelfHelpGroupBO::" +e.getMessage());
			throw new EJBException("Error in getSHGDetailsByComments === SelfHelpGroupBO"+e.toString());
			
		}
		
		
		return hshAgency;
	}
	public HashMap getSHGOtherFinancePositionByAppno(String strAppNo) throws Exception
	{
		HashMap hshFinancePosition=new HashMap();
		ResultSet rs=null;
		try 
		{
			rs=DBUtils.executeLAPSQuery("agr_shg_otherfinanceposition_select^"+strAppNo);
			while(rs.next())
			{
				hshFinancePosition.put("appno", Helper.correctNull(rs.getString("agr_appno")));
				hshFinancePosition.put("agr_maintenance", Helper.correctNull(rs.getString("agr_maintenance")));
				hshFinancePosition.put("agr_updated", Helper.correctNull(rs.getString("agr_updated")));
				hshFinancePosition.put("agr_loaningterms", Helper.correctNull(rs.getString("agr_loaningterms")));
				hshFinancePosition.put("agr_avgintrate", Helper.correctNull(rs.getString("agr_avgintrate")));
				hshFinancePosition.put("agr_avgrepayperiod", Helper.correctNull(rs.getString("agr_avgrepayperiod")));
				hshFinancePosition.put("agr_outborrowings", Helper.correctNull(rs.getString("agr_outborrowings")));
				
			}
			if(rs!=null){rs.close();}
			
		} catch (Exception e) {
			if(rs!=null){rs.close();}
			LogWriter.log("Error in getSHGOtherFinancePositionByAppno SelfHelpGroupBO::" +e.getMessage());
			throw new EJBException("Error in getSHGOtherFinancePositionByAppno === SelfHelpGroupBO"+e.toString());
		}
		return hshFinancePosition;
	}
	
	public HashMap getSHGCorpusOfGroupByAppno(String strAppNo,String schemetype,String facno) throws Exception
	{
		HashMap hshCorpusOFGrp=new HashMap();
		ResultSet rs=null;
		try 
		{
			rs=DBUtils.executeLAPSQuery("agrshgcorpusofgroup_select^"+strAppNo+"^"+schemetype+"^"+facno);
			if(rs.next())
			{
				
				hshCorpusOFGrp.put("balanceamt", Helper.correctNull(rs.getString("agr_cog_balanceamt")));
				hshCorpusOFGrp.put("amtlent", Helper.correctNull(rs.getString("agr_cog_amtlent")));
				hshCorpusOFGrp.put("interest", Helper.correctNull(rs.getString("agr_cog_interest")));
				hshCorpusOFGrp.put("fundgovt", Helper.correctNull(rs.getString("agr_cog_fndgovt")));
				hshCorpusOFGrp.put("total", Helper.correctNull(rs.getString("agr_cog_total")));			
				hshCorpusOFGrp.put("monthlysave", Helper.correctNull(rs.getString("agr_cog_monthlysavg")));
				hshCorpusOFGrp.put("loanoutstand", Helper.correctNull(rs.getString("agr_cog_loanoutstand")));		
				hshCorpusOFGrp.put("recoverperf", Helper.correctNull(rs.getString("agr_cog_recoverperf")));
				hshCorpusOFGrp.put("levelofsavg", Helper.correctNull(rs.getString("agr_cog_levelofsavg")));
				hshCorpusOFGrp.put("velofsavg", Helper.correctNull(rs.getString("agr_cog_velofsavg")));
			}
			if(rs!=null){rs.close();}
		} catch (Exception e) {
			if(rs!=null){rs.close();}
			LogWriter.log("Error in getSHGCorpusOfGroupByAppno SelfHelpGroupBO::" +e.getMessage());
			throw new EJBException("Error in getSHGCorpusOfGroupByAppno === SelfHelpGroupBO"+e.toString());
		}
		return hshCorpusOFGrp;
	}
	
	public int getSHGGroupMemberCountByAppId(String strCustID) throws Exception
	{
		int memberCount=0;
		ResultSet rs=null;
		try 
		{
			rs=DBUtils.executeLAPSQuery("perSHGgroupcount_select^"+strCustID);
			if(rs.next())
			{
				memberCount=FwHelper.parseInt(rs.getString("count"));			
			}
			if(rs!=null)rs.close();
		}
		catch (Exception e) 
		{
			if(rs!=null){rs.close();}
			LogWriter.log("Error in getSHGGroupMemberCountByAppId SelfHelpGroupBO::" +e.getMessage());
			throw new EJBException("Error in getSHGGroupMemberCountByAppId === SelfHelpGroupBO"+e.toString());
		}
		return memberCount;
	}
	
	public Date getDateOfFormationByAppId(String strCustID) throws Exception
	{
		Date dateofFormation=null;
		ResultSet rs=null;
		try 
		{
			rs=DBUtils.executeLAPSQuery("percustomerdemographicsdof_select^"+strCustID);
			if(rs.next())
			{	
				dateofFormation=rs.getDate("perapp_dob");			
			}
			if(rs!=null){rs.close();}
			
		} catch (Exception e) {
			if(rs!=null){rs.close();}
			LogWriter.log("Error in getDateOfFormationByAppId SelfHelpGroupBO::" +e.getMessage());
			throw new EJBException("Error in getDateOfFormationByAppId === SelfHelpGroupBO"+e.toString());
		}
		return dateofFormation;
	}
	public String getCumulativeSavingsByAppNo(String strAppNo,String schemetype) throws Exception
	{
		String strCumulative="";
		ResultSet rs=null;
		try 
		{
			rs=DBUtils.executeLAPSQuery("agr_shgfinancepositioncumul_select^"+strAppNo+"^"+schemetype);
			if(rs.next())
			{			
				strCumulative=FwHelper.correctNull(rs.getString("agr_cumsavings"));			
			}
			if(rs!=null){rs.close();}
			
		} catch (Exception e) {
			if(rs!=null){rs.close();}
			LogWriter.log("Error in getCumulativeSavingsByAppNo SelfHelpGroupBO::" +e.getMessage());
			throw new EJBException("Error in getCumulativeSavingsByAppNo === SelfHelpGroupBO"+e.toString());
		}
		return strCumulative;
	}
	public HashMap getDose1DetailsByAppno(String strAppNo,String strPage_Id) throws Exception
	{
		HashMap hshDoseDet=new HashMap();
		ResultSet rs=null;
		try 
		{
			rs=DBUtils.executeLAPSQuery("agr_shg_dose1details_select^"+strAppNo+"^"+strPage_Id);
			while(rs.next())
			{
				hshDoseDet.put("appno", Helper.correctNull(rs.getString("agr_appno")));
				hshDoseDet.put("reglimit", Helper.correctNull(rs.getString("agr_reg_limit")));
				hshDoseDet.put("debtswapping", Helper.correctNull(rs.getString("agr_debtswapping")));
				hshDoseDet.put("indiramma", Helper.correctNull(rs.getString("agr_indiramma")));
				hshDoseDet.put("sanctiondate", Helper.correctNull(rs.getString("agr_sanctiondate")));
				hshDoseDet.put("sanctionedAuth", Helper.correctNull(rs.getString("agr_sanctionedAuth")));
			}
			if(rs!=null){rs.close();}
		} catch (Exception e) {
			if(rs!=null){rs.close();}
			LogWriter.log("Error in getDose1DetailsByAppno SelfHelpGroupBO::" +e.getMessage());
			throw new EJBException("Error in getDose1DetailsByAppno === SelfHelpGroupBO"+e.toString());
			
		}
		return hshDoseDet;
	}
	public ArrayList getSHGmcpDetailByAppno(String strAppNo,String strAppid) throws Exception
	{
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		ResultSet rs=null;
		ResultSet rs1=null;
	
		try {
			rs=DBUtils.executeLAPSQuery("agr_shgmcpdetails_select^"+strAppNo);
			while(rs.next())
			{
				arrCol=new ArrayList();
				
				arrCol.add(Helper.correctNull(rs.getString("agr_appno")));//0 Appno
				arrCol.add(Helper.correctNull(rs.getString("agr_sno")));//1  serial number
				String memberName=Helper.correctNull(rs.getString("agr_member"));
				arrCol.add(Helper.correctNull(rs.getString("agr_member")));//2 
				arrCol.add(Helper.correctNull(rs.getString("agr_regactivity")));//3 
				arrCol.add(Helper.correctNull(rs.getString("agr_regamount")));//4 
				arrCol.add(Helper.correctNull(rs.getString("agr_socialactivity")));//5 
				arrCol.add(Helper.correctNull(rs.getString("agr_socialamount")));//6 
				arrCol.add(Helper.correctNull(rs.getString("agr_debtactivity")));//7
				arrCol.add(Helper.correctNull(rs.getString("agr_debtamount")));//8 
				arrCol.add(Helper.correctNull(rs.getString("agr_indiactivity")));//9
				arrCol.add(Helper.correctNull(rs.getString("agr_indiamount")));//10 
					
				rs1=DBUtils.executeLAPSQuery("per_selfhelpgroupdetails_selectByIdName^"+strAppid+"^"+memberName);
				if(rs1.next())
				{
					arrCol.add(Helper.correctNull(rs1.getString("pa_membername")));//11
				}
				arrRow.add(arrCol);	
				if(rs1!=null){rs1.close();}
		}
			arrCol=null;
		} catch (Exception e) {
			if(rs!=null){rs.close();}
			LogWriter.log("Error in getSHGmcpDetailByAppno of SelfHelpGroupBO::" +e.getMessage());
			throw new EJBException("Error in getSHGmcpDetailByAppno === SelfHelpGroupBO"+e.toString());
		}
		return arrRow;
	}
	
}
