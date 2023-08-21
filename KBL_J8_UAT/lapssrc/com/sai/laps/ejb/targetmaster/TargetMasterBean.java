package com.sai.laps.ejb.targetmaster;

import java.sql.ResultSet;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.ejb.supuser.SupUserBean;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "TargetMasterBean", mappedName = "TargetMasterHome")
@Remote (TargetMasterRemote.class)
public class TargetMasterBean extends BeanAdapter {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -4612727074681962783L;
	static Logger log=Logger.getLogger(TargetMasterBean.class);
	/**
	 * 
	 */

	public void updateTargetMasterData(HashMap hshValues) 
	{
		java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		String str_periodfrom=null;
		String str_periodto=null;
		String str_branchcode=null;
		String str_code=null;
		String[] str_target_noofaccounts=null;
		String[] str_target_amount=null;
		String[] str_target_sanction_noofaccounts=null;
		String[] str_target_sanction_amount=null;
		String[] str_target_os_noofaccounts=null;
		String[] str_target_os_amount=null;
		HashMap hshQueryValues=null;
		HashMap hshQuery=null;
		ResultSet rs=null;
		ArrayList arrValues=null;
		//int count_editabletargets=0;
		
		String str_yearfrom="";
		String str_yearto="";
		String target_year="";
		String target_exi_month="";
		String target_month="";
		try
		{
			/* String[] str_target_code={"T_DEP","GROSS","EXP","A","A_DI","A_IN","MA","MA_DI","MA_IN","MM","MM_MI","MM_SM","MM_ME","MS","MS_MI"
					,"MS_SM","MS_ME","MS_RT","MS_SB","MS_EM","RETTR","R_HOM","R_TRA","R_CC","R_CS","R_MIL","R_EDU"
					,"R_HEA","R_SMI","R_CAS","R_MOR","R_SHA","PMRY","SGSY","SJSRY","SLRS","DRI","OTHER","D_SMF","D_SCT","D_VCI","D_PMR"
					,"D_SHG","D_DRI","CASHR","UPGRA","WO","SLIPP","RECWO","PROFI","NIL","NIE"}; */
			/* String[] str_target_code={"T_DEP","GROSS","EXP","A_DI","A_IN","MA_DI","MA_IN","MM_MI","MM_SM","MM_ME","MS_MI"
					,"MS_SM","MS_ME","MS_RT","MS_SB","MS_EM","RETTR","R_HOM","R_TRA","R_CC","R_CS","R_MIL","R_EDU"
					,"R_HEA","R_SMI","R_CAS","R_MOR","R_SHA","PMRY","SGSY","SJSRY","SLRS","DRI","OTHER","D_SMF","D_SCT","D_VCI","D_PMR"
					,"D_SHG","D_DRI","CASHR","UPGRA","WO","SLIPP","RECWO","PROFI","NIL","NIE"};*/
			String[] str_target_code={"T_DEP","GROSS","EXP","A_DI","A_IN","MA_DI","MA_IN","MM_MI","MM_SM","MM_ME","MSMIO","MSMIB","MSMIT",
									  "MSMIP","MSMIE","MSSMO","MSSMB","MSSMT","MSSMP","MSSME","KHADI","MEDIU","INDIR","NBFC","MICRO",
									  "SCST","EDU_R","EDU_U","HOM_R","HOM_U","R_TRA","R_EDU","R_HOM","R_CC","R_CS","R_MIL",
									  "R_HEA","R_SMI","R_CAS","R_MOR","R_SHA","PMRY","PMEGP","SGSY","SJSRY","GJRHF","SLRS","SRMS",
									  "ULUCC","UACC","SCC","SCP","SACP","D_SMF","D_VCI","D_SGS","D_SCT","D_DRI","D_SJS","D_SLR",
									  "D_SHG","D_POO","D_MIN","D_WOM","BALAN","CASHR","UPGRA","WO","SLIPP","RECWO","PROFI","NII","NIE"};
			String[] str_editablefields_sanctioned={"T_DEP","GROSS","EXP","KHADI","MEDIU","INDIR","NBFC","MICRO","SCST","D_SMF","D_VCI","D_SGS","D_SCT","D_DRI","D_SJS","D_SLR",
					  								"D_SHG","D_POO","D_MIN","D_WOM","BALAN","CASHR","UPGRA","WO","SLIPP","RECWO","PROFI","NII","NIE"};
			String[] str_editablefields_outstanding={"T_DEP","GROSS","EXP","MM_ME","MEDIU","BALAN","CASHR","UPGRA","WO","SLIPP","RECWO","PROFI","NII","NIE"};
			//String[] str_editablefields_target={"BALAN"};
            str_periodfrom=Helper.correctNull((String)hshValues.get("txt_periodfrom"));
			str_periodto=Helper.correctNull((String)hshValues.get("txt_periodto"));
			str_branchcode=Helper.correctNull((String)hshValues.get("sel_branch"));
			str_code=str_branchcode.substring(2,str_branchcode.length());
			str_target_noofaccounts=(String[])hshValues.get("txt_target_noofaccounts");
			str_target_amount=(String[])hshValues.get("txt_target_amount");
			str_target_sanction_noofaccounts=(String[])hshValues.get("txt_sanctioned_noofaccounts");
			str_target_sanction_amount=(String[])hshValues.get("txt_sanctioned_amount");
			str_target_os_noofaccounts=(String[])hshValues.get("txt_outstanding_noofaccounts");
			str_target_os_amount=(String[])hshValues.get("txt_outstanding_amount");
			str_yearfrom=Helper.correctNull((String)hshValues.get("txt_yearfrom"));
			str_yearto=Helper.correctNull((String)hshValues.get("txt_yearto"));
			target_year=Helper.correctNull((String)hshValues.get("sel_year"));
			target_exi_month=Helper.correctNull((String)hshValues.get("sel_target"));
			target_month=Helper.correctNull((String)hshValues.get("sel_month"));
			//----------------------- start for converting amount in lakhs to rupees----------------------
			for(int i=0;i<str_target_amount.length;i++)
			{
				str_target_amount[i]=jtn.format(Double.parseDouble(Helper.correctDouble(str_target_amount[i]))*100000.00);
				str_target_sanction_amount[i]=jtn.format(Double.parseDouble(Helper.correctDouble(str_target_sanction_amount[i]))*100000.00);
				str_target_os_amount[i]=jtn.format(Double.parseDouble(Helper.correctDouble(str_target_os_amount[i]))*100000.00);
			}
			//----------------------- End for converting amount in lakhs to rupees----------------------
			
			if(((String)hshValues.get("hidAction")).equals("delete"))
			{
				
				//-------------------Start for deleting Monthly data from target master--------------
				
					arrValues=new ArrayList();
					hshQueryValues=new HashMap();
					hshQuery=new HashMap();
					arrValues.add(str_periodfrom);
					arrValues.add(str_periodto);
					arrValues.add(str_code);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","targetmaster_delete");
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				//-------------------End for deleting Monthly data from target master--------------
				//-------------------Start for deleting data from targetbranchlist--------------
				
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					hshQueryValues=new HashMap();
					arrValues.add(str_periodfrom);
					arrValues.add(str_periodto);
					arrValues.add(str_code);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","targetbranchlist_delete");
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				}
				//-------------------End for deleting data from targetbranchlist--------------
			
			
			
			
			if(((String)hshValues.get("hidAction")).equals("insert")&& target_exi_month.equalsIgnoreCase("new"))//indicates New Target 
			{
				
					for(int i=0;i<str_target_code.length;i++)
					{
						hshQuery=null;
						hshQueryValues=null;
						arrValues=null;
						arrValues=new ArrayList();
						hshQueryValues=new HashMap();
						hshQuery=new HashMap();
						arrValues.add(str_code);
						arrValues.add(str_periodfrom);
						arrValues.add(str_periodto);
						arrValues.add(str_target_code[i]);
						arrValues.add(str_target_noofaccounts[i]);
						arrValues.add(str_target_amount[i]);
						arrValues.add(str_target_sanction_noofaccounts[i]);
						arrValues.add(str_target_sanction_amount[i]);
						arrValues.add(str_target_os_noofaccounts[i]);
						arrValues.add(str_target_os_amount[i]);
						arrValues.add(Integer.toString(i));
						hshQuery.put("strQueryId","targetmaster_insert");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size","1");
						hshQueryValues.put("1",hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}	
						hshQuery=null;
						hshQueryValues=null;
						arrValues=null;
						arrValues=new ArrayList();
						hshQueryValues=new HashMap();
						hshQuery=new HashMap();
						arrValues.add(str_code);
						arrValues.add(str_periodfrom);
						arrValues.add(str_periodto);
						hshQuery.put("strQueryId","ins_targetbranchlist");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size","1");
						hshQueryValues.put("1",hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
	
			}
			//-----------------Start For Updating Target Master For Sanctioned Fields----------------
			else if(((String)hshValues.get("hidAction")).equals("insert") &&  !target_exi_month.equalsIgnoreCase("new"))
			{
				hshQuery=null;
				hshQueryValues=null;
				arrValues=null;
				hshQueryValues=new HashMap();
				for(int i=0;i<str_editablefields_sanctioned.length;i++)
				{
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					for(int j=0;j<str_target_code.length;j++)
					{
						if(str_editablefields_sanctioned[i].equalsIgnoreCase(str_target_code[j]))
						{
							arrValues.add(str_target_sanction_noofaccounts[j]);
							arrValues.add(str_target_sanction_amount[j]);
							arrValues.add(str_periodfrom);
							arrValues.add(str_periodto);
							arrValues.add(str_editablefields_sanctioned[i]);
							arrValues.add(str_code);
							hshQuery.put("strQueryId","updsanction_target");
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("1",hshQuery);
							hshQueryValues.put("size","1");
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
							arrValues=null;
							hshQuery=null;
							break;
						}
					}
					
				 }
				 
              //-----------------End For Updating Target Master For Sanctioned Fields----------------
				  
              //-----------------Start For Updating Target Master For Outstanding Fields----------------
				  hshQueryValues=null;
				  hshQueryValues=new HashMap();
				  for(int i=0;i<str_editablefields_outstanding.length;i++)
					{
						arrValues=new ArrayList();
						hshQuery=new HashMap();
						for(int j=0;j<str_target_code.length;j++)
						{
							if(str_editablefields_outstanding[i].equalsIgnoreCase(str_target_code[j]))
							{
								arrValues.add(str_target_os_noofaccounts[j]);
								arrValues.add(str_target_os_amount[j]);
								arrValues.add(str_periodfrom);
								arrValues.add(str_periodto);
								arrValues.add(str_editablefields_outstanding[i]);
								arrValues.add(str_code);
								hshQuery.put("strQueryId","updoutstanding_target");
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put("1",hshQuery);
								hshQueryValues.put("size","1");
								EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
								arrValues=null;
								hshQuery=null;
								break;
							}
						}
					}
					 
                //-----------------End For Updating Target Master For Outstanding Fields----------------
					  
//					-----------------Start For Updating Target Master For Target Fields----------------
					  hshQueryValues=null;
					  hshQueryValues=new HashMap();
					 /* for(int i=0;i<str_editablefields_target.length;i++)
						{*/
							
							for(int j=0;j<str_target_code.length;j++)
							{
								/*if(str_editablefields_target[i].equalsIgnoreCase(str_target_code[j]))
								{*/
									arrValues=new ArrayList();
									hshQuery=new HashMap();
									arrValues.add(str_target_noofaccounts[j]);
									arrValues.add(str_target_amount[j]);
									arrValues.add(str_code);
									arrValues.add(str_periodfrom);
									arrValues.add(str_periodto);
									arrValues.add(str_target_code[j]);
									hshQuery.put("strQueryId","targetmaster_update");
									hshQuery.put("arrValues",arrValues);
									hshQueryValues.put("1",hshQuery);
									hshQueryValues.put("size","1");
									EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
									arrValues=null;
									hshQuery=null;
									//break;
								//}
							}
						//}
						 
	                //-----------------End For Updating Target Master For Target Fields----------------
			}
			
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Exception Occurred in updateTargetMasterData"+ce.toString());
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
	
	public HashMap getTargetMasterData(HashMap hshValues) 
	{
		String strQuery="";
		ResultSet rs = null;
		HashMap hshRecord =new HashMap();
		String 	branch = "";
		String  fromdate= "";
		String  todate= "";
		ArrayList branchtarget= new ArrayList();
		
		NumberFormat nf = NumberFormat.getInstance();
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
		nf.setGroupingUsed(false);
		
		try
		{
			
			branch = correctNull((String)hshValues.get("branch"));
			fromdate = correctNull((String)hshValues.get("fromdate"));
			todate = correctNull((String)hshValues.get("todate"));
			
			
			strQuery=SQLParser.getSqlQuery("getbranchtarget^"+branch+"^"+fromdate+"^"+todate);		
			rs = DBUtils.executeQuery(strQuery);
		
			while(rs.next())
			{
				ArrayList paramtarget = new ArrayList();
				paramtarget.add(Helper.correctInt(rs.getString("target_noacc")));
				paramtarget.add(nf.format(rs.getDouble("target_amount")));
				
				paramtarget.add(Helper.correctInt(rs.getString("target_sanction_noacc")));
				paramtarget.add(nf.format(rs.getDouble("target_sanction_amount")));
				
				paramtarget.add(Helper.correctInt(rs.getString("target_os_noacc")));
				paramtarget.add(nf.format(rs.getDouble("target_os_amount")));
				
				branchtarget.add(paramtarget);
			}	
			hshRecord.put("arrCust",branchtarget);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getTargetMasterData "+ce.toString());
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
	
	public HashMap getTargetBranchMasterData(HashMap hshValues) 
	{
		String strQuery="";
		ResultSet rs = null;
		HashMap hshRecord =new HashMap();
		String 	branch = "";
		String  fromdate= "";
		String  todate= "";
		ArrayList branchtarget= null;
		Calendar cal = Calendar.getInstance();
		java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
		nf.setGroupingUsed(false);
		String frmdate="";
		String to_date="";
		
		try
		{
			
			branch = correctNull((String)hshValues.get("branch"));
			fromdate = correctNull((String)hshValues.get("fromdate"));
			todate = correctNull((String)hshValues.get("todate"));
			
			for(int i=0;i<3;i++)
			{
				branchtarget= new ArrayList();
				if(i==0)
				{
					frmdate=fromdate;
					int mon = Integer.parseInt(fromdate.substring(3,5));
					cal.set(Integer.parseInt(fromdate.substring(6,10)),mon-1,Integer.parseInt(fromdate.substring(0,2)));
					to_date =Integer.toString(cal.getActualMaximum(Calendar.DAY_OF_MONTH))+"/"+fromdate.substring(3,5)+"/"+fromdate.substring(6,10);
			
				}
				else if(i==1)
				{
					int mon = Integer.parseInt(fromdate.substring(3,5))+1;
					cal.set(Integer.parseInt(fromdate.substring(6,10)),mon-1,Integer.parseInt(fromdate.substring(0,2)));
					frmdate="01/"+Integer.toString(mon)+"/"+fromdate.substring(6,10);
					to_date =Integer.toString(cal.getActualMaximum(Calendar.DAY_OF_MONTH))+"/"+Integer.toString(mon)+"/"+fromdate.substring(6,10);
					
				}
				else if(i==2)
				{

					int mon = Integer.parseInt(todate.substring(3,5));
					cal.set(Integer.parseInt(todate.substring(6,10)),mon-1,Integer.parseInt(todate.substring(0,2)));
					frmdate = "01/"+Integer.toString(mon)+"/"+todate.substring(6,10);
					to_date=todate;
				}
										
				strQuery=SQLParser.getSqlQuery("getbranchtarget^"+branch+"^"+frmdate+"^"+to_date);		
				rs = DBUtils.executeQuery(strQuery);
		
				while(rs.next())
				{
					ArrayList paramtarget = new ArrayList();
					
						paramtarget.add(Helper.correctInt(rs.getString("target_noacc")));
						paramtarget.add(nf.format(rs.getDouble("target_amount")));
				
						
					
					branchtarget.add(paramtarget);
				}	
				if(i==0)
					hshRecord.put("arrCust",branchtarget);
				if(i==1)
					hshRecord.put("arrCust1",branchtarget);
				if(i==2)
					hshRecord.put("arrCust2",branchtarget);
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getTargetBranchMasterData "+ce.toString());
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
  
  public HashMap getBranchTarget(HashMap hshValues) 
	{
	  String strQuery="";
		ResultSet rs = null;
		HashMap hshRecord =new HashMap();
		String 	branch = "";
		ArrayList branchtarget = null;
		ArrayList totaltarget = new ArrayList();
		
		try
		{
			branch = correctNull((String)hshValues.get("branch"));
			strQuery=SQLParser.getSqlQuery("getbranchtargetvalue^"+branch);		
			rs = DBUtils.executeQuery(strQuery);
		
			while(rs.next())
			{
				branchtarget = new ArrayList();
				branchtarget.add(rs.getString("target_from"));
				totaltarget.add(branchtarget);
			}	
			hshRecord.put("vecVal",totaltarget);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getBranchTarget "+ce.toString());
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
  
  public HashMap getTargetDataPrint(HashMap hshValues) 
	{
		String strQuery="";
		ResultSet rs = null;
		HashMap hshRecord =new HashMap();
		String 	branch = "";
		ArrayList branchtarget= new ArrayList();
		ArrayList paramtarget = null;
		ArrayList temp=new ArrayList();
		ArrayList calculated_targets=new ArrayList();
		Calendar cal = Calendar.getInstance();
		int count=0;
		NumberFormat nf = NumberFormat.getInstance();
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
		nf.setGroupingUsed(false);
		
		try
		{
			branch = correctNull((String)hshValues.get("branchcode"));
			String[] temp_branch = branch.split("-");
			branch = temp_branch[1];
			String frommonth = correctNull((String)hshValues.get("frommonth"));
			String tomonth = correctNull((String)hshValues.get("tomonth"));
			String fromyear = correctNull((String)hshValues.get("fromyear"));
			String toyear = correctNull((String)hshValues.get("toyear"));
			
			//----------------------Start for getting values for target and sanctioned fields----------------------
			strQuery=SQLParser.getSqlQuery("targetmaster_select_sum^"+"01/"+frommonth+"/"+fromyear+"^"+"01/"+tomonth+"/"+toyear+"^"+branch);		
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				paramtarget = new ArrayList();
				paramtarget.add(Helper.correctInt(rs.getString("target_noacc")));
				paramtarget.add(nf.format(rs.getDouble("target_amount")/100000.00));
				paramtarget.add(Helper.correctInt(rs.getString("target_sanction_noacc")));
				paramtarget.add(nf.format(rs.getDouble("target_sanction_amount")/100000.00));
				branchtarget.add(paramtarget);
				paramtarget=null;
			}
			//----------------------End for getting values for target and sanctioned fields----------------------
			
			
			//----------------------Start for getting values for Outstanding fields----------------------
			strQuery=SQLParser.getSqlQuery("targetmaster_select_os^"+"01/"+tomonth+"/"+toyear+"^"+branch);
			if(rs!=null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			count=0;
			if(branchtarget.size()>0 && !rs.isBeforeFirst())
			{
				for(int i=0;i<73;i++)
				{
					paramtarget=(ArrayList)branchtarget.get(i);
					paramtarget.add("0");
					paramtarget.add("0.00");
					branchtarget.set(i,paramtarget);
					paramtarget=null;
				}
			}
			else if(branchtarget.size()==0 && rs.isBeforeFirst())
			{
				paramtarget = new ArrayList();
				paramtarget.add("0");
				paramtarget.add("0.00");
				paramtarget.add("0");
				paramtarget.add("0.00");
				for(int i=0;i<73;i++)
				{
					branchtarget.add(paramtarget);
				}
				paramtarget=null;
			}
			while(rs.next())
			{
				paramtarget=(ArrayList)branchtarget.get(count);
				paramtarget.add(Helper.correctInt(rs.getString("TARGET_OS_NOACC")));
				paramtarget.add(nf.format(rs.getDouble("TARGET_OS_AMOUNT")/100000.00));
				branchtarget.set(count,paramtarget);
				paramtarget=null;
				count++;
			} 
			//----------------------End for getting values for Outstanding fields----------------------
			
			//------------Start For Getting Opening Balance----------------
			strQuery=SQLParser.getSqlQuery("getbranchtarget_bycode^"+branch+"^"+"01/"+frommonth+"/"+fromyear+"^"+"BALAN");
			if(rs!=null)
					rs.close();
			rs = DBUtils.executeQuery(strQuery);
			paramtarget = new ArrayList();
			if(rs.next())
			{
				paramtarget.add(Helper.correctInt(rs.getString("target_noacc")));
				paramtarget.add(nf.format(rs.getDouble("target_amount")/100000.00));
				paramtarget.add(Helper.correctInt(rs.getString("target_sanction_noacc")));
				paramtarget.add(nf.format(rs.getDouble("target_sanction_amount")/100000.00));
				paramtarget.add(Helper.correctInt(rs.getString("TARGET_OS_NOACC")));
				paramtarget.add(nf.format(rs.getDouble("TARGET_OS_AMOUNT")/100000.00));
			}
			else
			{
				paramtarget.add("0");
				paramtarget.add("0.00");
				paramtarget.add("0");
				paramtarget.add("0.00");
				paramtarget.add("0");
				paramtarget.add("0.00");
			}
			if(branchtarget.size()>=65)
			{
				branchtarget.set(64,paramtarget); // 64 is the row index for opening balance
			}
			paramtarget=null;
			//------------End For Getting Opening Balance----------------
			
			
			
			
			//-------------Start for computing period of report-------------------------
			String str_periodfrom="01/"+frommonth+"/"+fromyear;
			String str_periodto="/"+tomonth+"/"+toyear;
			cal.set(Integer.parseInt(toyear),Integer.parseInt(tomonth)-1,01);
			cal.getActualMaximum(Integer.parseInt(tomonth));
			str_periodto=Integer.toString(cal.getActualMaximum(Calendar.DAY_OF_MONTH))+str_periodto;
			hshRecord.put("period",str_periodfrom+" - "+str_periodto);
			//-------------End for computing period of report-------------------------
			
			//-------Start for computing calculated fields--------
			if(branchtarget.size()>0)
			{
				calculated_targets.add(calculate(3,5,branchtarget));  // Agriculture
				calculated_targets.add(calculate(5,7,branchtarget));  // MSME Enterprises
				calculated_targets.add(calculate(7,10,branchtarget));  // MSME Manufacturing
				calculated_targets.add(calculate(10,15,branchtarget));  // MSME Services - Micro
				calculated_targets.add(calculate(15,20,branchtarget));  // MSME Services - Small
				calculated_targets.add(calculate(22,24,branchtarget));  // Total Indirect MSME 
				calculated_targets.add(calculate(26,28,branchtarget));  // Union Education
				calculated_targets.add(calculate(28,30,branchtarget));  // Union Home
				//-----------Start for calculating  Total Of Priority Sector------------------
				temp=(ArrayList)calculate(7,31,branchtarget);
				paramtarget=(ArrayList)calculated_targets.get(0);
				for(int i=0;i<temp.size();i++)
				{
					if(i%2==0)
						temp.set(i,Integer.toString(Integer.parseInt(temp.get(i).toString())+Integer.parseInt(paramtarget.get(i).toString())));
					else
						temp.set(i,nf.format(Double.parseDouble(temp.get(i).toString())+Double.parseDouble(paramtarget.get(i).toString())));
				}
				calculated_targets.add(temp);
				temp=null;
				//-----------End for calculating  Total Of Priority Sector------------------
				calculated_targets.add(calculate(33,35,branchtarget));  // Union Comfort
				
				//-------------------Start for calculating NPA as on end of period-----------
				paramtarget=new ArrayList();
				paramtarget.add("0");
				paramtarget.add("0.00");
				paramtarget.add("0");
				paramtarget.add("0.00");
				paramtarget.add("0");
				paramtarget.add("0.00");
				strQuery=SQLParser.getSqlQuery("getbranchtarget_bymultiplecodes^"+branch+"^"+"01/"+tomonth+"/"+toyear+"^"+"'BALAN','CASHR','UPGRA','WO','SLIPP'");
				if(rs!=null)
						rs.close();
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					if(rs.getString("target_code").equalsIgnoreCase("BALAN") || rs.getString("target_code").equalsIgnoreCase("SLIPP"))
					{
						paramtarget.set(0,Integer.toString(Integer.parseInt(paramtarget.get(0).toString())+rs.getInt("target_noacc")));
						paramtarget.set(1,nf.format(Double.parseDouble(paramtarget.get(1).toString())+rs.getDouble("target_amount")/100000.00));
						paramtarget.set(2,Integer.toString(Integer.parseInt(paramtarget.get(2).toString())+rs.getInt("target_sanction_noacc")));
						paramtarget.set(3,nf.format(Double.parseDouble(paramtarget.get(3).toString())+rs.getDouble("target_sanction_amount")/100000.00));
						paramtarget.set(4,Integer.toString(Integer.parseInt(paramtarget.get(4).toString())+rs.getInt("target_os_noacc")));
						paramtarget.set(5,nf.format(Double.parseDouble(paramtarget.get(5).toString())+rs.getDouble("target_os_amount")/100000.00));
					}
					else if(rs.getString("target_code").equalsIgnoreCase("CASHR") || rs.getString("target_code").equalsIgnoreCase("UPGRA") || rs.getString("target_code").equalsIgnoreCase("WO"))
					{
						paramtarget.set(0,Integer.toString(Integer.parseInt(paramtarget.get(0).toString())-rs.getInt("target_noacc")));
						paramtarget.set(1,nf.format(Double.parseDouble(paramtarget.get(1).toString())-rs.getDouble("target_amount")/100000.00));
						paramtarget.set(2,Integer.toString(Integer.parseInt(paramtarget.get(2).toString())-rs.getInt("target_sanction_noacc")));
						paramtarget.set(3,nf.format(Double.parseDouble(paramtarget.get(3).toString())-rs.getDouble("target_sanction_amount")/100000.00));
						paramtarget.set(4,Integer.toString(Integer.parseInt(paramtarget.get(4).toString())-rs.getInt("target_os_noacc")));
						paramtarget.set(5,nf.format(Double.parseDouble(paramtarget.get(5).toString())-rs.getDouble("target_os_amount")/100000.00));
					}
				}
				calculated_targets.add(paramtarget);
				//------------------End for calculating NPA as on end of period-----------
				
				
				for(int i=0;i<calculated_targets.size();i++)
				{
					temp=(ArrayList)calculated_targets.get(i);
					temp.set(1,nf.format(Double.parseDouble(temp.get(1).toString())));
					temp.set(3,nf.format(Double.parseDouble(temp.get(3).toString())));
					temp.set(5,nf.format(Double.parseDouble(temp.get(5).toString())));
					calculated_targets.set(i,temp);
					temp=null;
				}
							
				
			//-------End for computing calculated fields--------
			}
			hshRecord.put("branch",hshValues.get("branch"));
			hshRecord.put("branchtarget",branchtarget);
			hshRecord.put("calculated_targets",calculated_targets);
			
			
			
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getTargetDataPrint "+ce.toString());
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
  
  private ArrayList calculate(int i,int j,ArrayList branchtarget)
  {
	  java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
	  jtn.setMaximumFractionDigits(2);
	  jtn.setMinimumFractionDigits(2);
	  jtn.setGroupingUsed(false);
		
	  ArrayList temp=new ArrayList();
	  temp.add("0");
	  temp.add("0.00");
	  temp.add("0");
	  temp.add("0.00");
	  temp.add("0");
	  temp.add("0.00");
	  ArrayList paramtarget=null;
	  for(;i<j;i++)
	  {
			paramtarget = (ArrayList)branchtarget.get(i);
			for(int k=0;k<paramtarget.size();k++)
			{
				if(k%2==0)
					temp.set(k,Integer.toString(Integer.parseInt(temp.get(k).toString())+Integer.parseInt(paramtarget.get(k).toString())));
				else
					temp.set(k,jtn.format(Double.parseDouble(temp.get(k).toString())+Double.parseDouble(paramtarget.get(k).toString())));
			}
			paramtarget=null;
	}
		return temp;	
  }
	

	
	
	
}
