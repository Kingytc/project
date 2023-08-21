package com.sai.laps.ejb.formula;

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
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "FormulaBean", mappedName = "FormulaHome")
@Remote (FormulaRemote.class)
public class FormulaBean extends BeanAdapter 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public HashMap updateData(HashMap hshValues)  
	{
		ResultSet rs = null;
		HashMap hshQueryValues = new HashMap();
		HashMap hshRecord = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		String strAction = (String) hshValues.get("hidAction");
		int intValue = 0;
		String rowid = (String) hshValues.get("rowid");
		String strKeyId = "";
		StringBuilder sbAt=new StringBuilder();
		StringBuilder sbolddata = new StringBuilder();
		try 
		{
			strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
			{
				
				rs = DBUtils.executeLAPSQuery("formulasel^"+Helper.correctNull((String) hshValues.get("cmano")));
				while(rs.next())
				{	
					sbolddata.append("~ CMA Type = "+Helper.correctNull((String)rs.getString("formula_cma_no")));
					sbolddata.append("~ Formula For = ");
					if(Helper.correctNull((String)rs.getString("formula_for")).equalsIgnoreCase("FI")) sbolddata.append("Financial");
						else if(Helper.correctNull((String)rs.getString("formula_for")).equalsIgnoreCase("CA")) sbolddata.append("Cash Flow");
						else if(Helper.correctNull((String)rs.getString("formula_for")).equalsIgnoreCase("FU")) sbolddata.append("Fund Flow");
						else if(Helper.correctNull((String)rs.getString("formula_for")).equalsIgnoreCase("RA")) sbolddata.append("Ratios");
						else if(Helper.correctNull((String)rs.getString("formula_for")).equalsIgnoreCase("SCA")) sbolddata.append("Stress Flow");						
						else if(Helper.correctNull((String)rs.getString("formula_for")).equalsIgnoreCase("MPBF1")) sbolddata.append("Assessment - MPBF1");
						else if(Helper.correctNull((String)rs.getString("formula_for")).equalsIgnoreCase("MPBF2")) sbolddata.append("Assessment - MPBF2");
						else if(Helper.correctNull((String)rs.getString("formula_for")).equalsIgnoreCase("PBF1")) sbolddata.append("Assessment - PBF1");
						else if(Helper.correctNull((String)rs.getString("formula_for")).equalsIgnoreCase("PBF2")) sbolddata.append("Assessment - PBF2");
						else if(Helper.correctNull((String)rs.getString("formula_for")).equalsIgnoreCase("PBF3")) sbolddata.append("Assessment - PBF3");
						else if(Helper.correctNull((String)rs.getString("formula_for")).equalsIgnoreCase("PBF4")) sbolddata.append("Assessment - PBF4");
						else if(Helper.correctNull((String)rs.getString("formula_for")).equalsIgnoreCase("TO")) sbolddata.append("Assessment - Turn Over");
					sbolddata.append("~ Formula Type = ");
					if(Helper.correctNull((String)rs.getString("formula_for_type")).equalsIgnoreCase("I")) sbAt.append("Increase");
					else if(Helper.correctNull((String)rs.getString("formula_for_type")).equalsIgnoreCase("D")) sbAt.append("Decrease");
					else if(Helper.correctNull((String)rs.getString("formula_for_type")).equalsIgnoreCase("GT")) sbAt.append("Group-Total");
					else if(Helper.correctNull((String)rs.getString("formula_for_type")).equalsIgnoreCase("NFL")) sbAt.append("Net Funds Lost");
					else if(Helper.correctNull((String)rs.getString("formula_for_type")).equalsIgnoreCase("LTS")) sbAt.append("Long Term Sources");
					else if(Helper.correctNull((String)rs.getString("formula_for_type")).equalsIgnoreCase("ID")) sbAt.append("Increase/Decrease");
					else if(Helper.correctNull((String)rs.getString("formula_for_type")).equalsIgnoreCase("S")) sbAt.append("Select");
					sbolddata.append("~ Formula = "+Helper.correctNull((String)rs.getString("formula_desc")));
				}
				if(rs!=null)
				rs.close();
			}
			if (strAction.equalsIgnoreCase("insert"))
			{
				rs = DBUtils.executeLAPSQuery("formulamax");
				if (rs.next()) 
				{
					intValue = rs.getInt(1);
				}
				intValue = intValue + 1;
				String i = Integer.toString(intValue);
				hshQuery.put("strQueryId", "formulains");
				arrValues.add(i);
				arrValues.add(correctNull((String) hshValues.get("forname")));
				arrValues.add(correctNull((String) hshValues.get("txtformula")));
				arrValues.add(correctNull((String) hshValues.get("formuladesc")));
				arrValues.add(correctNull((String) hshValues.get("choformula")));
				arrValues.add(correctNull((String) hshValues.get("forcode"))); //add later
				arrValues.add(hshValues.get("cmano"));
				arrValues.add(correctNull((String) hshValues.get("choformulatype")));
				hshQueryValues.put("size", "1");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
			}
			if (strAction.equalsIgnoreCase("update")) 
			{
				hshQuery.put("strQueryId", "formulaup");
				arrValues.add(correctNull((String) hshValues.get("forname")));
				arrValues.add(correctNull((String) hshValues.get("txtformula")));
				arrValues.add(correctNull((String) hshValues.get("formuladesc")));
				arrValues.add(correctNull((String) hshValues.get("choformula"))); //add later
				arrValues.add(correctNull((String) hshValues.get("forcode")));
				arrValues.add(hshValues.get("cmano"));
				arrValues.add(correctNull((String) hshValues.get("choformulatype")));
				arrValues.add(hshValues.get("rowid"));
				hshQueryValues.put("size", "1");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
			}
			if (strAction.equalsIgnoreCase("delete")) 
			{
				String cmaval = (String) hshValues.get("cmano");
				rs = DBUtils.executeLAPSQuery("formuladelfind^" + rowid + "^"+ cmaval);
				intValue = 0;
				if (rs.next()) 
				{
					intValue = rs.getInt(1);
				}
				if (intValue <= 0) 
				{
					hshQuery.put("strQueryId", "formuladel");
					arrValues.add(correctNull((String) hshValues.get("rowid")));
					hshQueryValues.put("size", "1");
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					hshRecord.put("deletion", "completed");
				} else {
					hshQueryValues = null;
					hshRecord.put("deletion", "terminated");
				}
			}
			if (strAction.equalsIgnoreCase("update")) {
				hshRecord.put("rowid", hshValues.get("rowid"));
				hshRecord.put("forname", hshValues.get("forname"));
				hshRecord.put("txtformula", hshValues.get("txtformula"));
				hshRecord.put("formuladesc", hshValues.get("formuladesc"));
				hshRecord.put("choformula", hshValues.get("choformula"));
				hshRecord.put("choformulatype", hshValues.get("choformulatype"));
				hshRecord.put("forcode", hshValues.get("forcode"));
				hshRecord.put("selcma", hshValues.get("selcma"));
				hshRecord.put("cmano", hshValues.get("cmano"));
			}
			if (hshQueryValues != null)
			{
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			sbAt = new StringBuilder();
			sbAt.append("~ CMA Type = "+Helper.correctNull((String)hshValues.get("cmano")));
			sbAt.append("~ Formula For = "+Helper.correctNull((String)hshValues.get("hidformfor")));
			sbAt.append("~ Formula Type = ");
			if(Helper.correctNull((String)hshValues.get("choformulatype")).equalsIgnoreCase("I")) sbAt.append("Increase");
			else if(Helper.correctNull((String)hshValues.get("choformulatype")).equalsIgnoreCase("D")) sbAt.append("Decrease");
			else if(Helper.correctNull((String)hshValues.get("choformulatype")).equalsIgnoreCase("GT")) sbAt.append("Group-Total");
			else if(Helper.correctNull((String)hshValues.get("choformulatype")).equalsIgnoreCase("NFL")) sbAt.append("Net Funds Lost");
			else if(Helper.correctNull((String)hshValues.get("choformulatype")).equalsIgnoreCase("LTS")) sbAt.append("Long Term Sources");
			else if(Helper.correctNull((String)hshValues.get("choformulatype")).equalsIgnoreCase("ID")) sbAt.append("Increase/Decrease");
			else if(Helper.correctNull((String)hshValues.get("choformulatype")).equalsIgnoreCase("H")) sbAt.append("Higher");
			else if(Helper.correctNull((String)hshValues.get("choformulatype")).equalsIgnoreCase("L")) sbAt.append("Lower");
			sbAt.append("~ Formula = "+Helper.correctNull((String)hshValues.get("formuladesc")));
			AuditTrial.auditNewLog(hshValues,"110",strKeyId,sbAt.toString(),sbolddata.toString());
		} 
		catch (Exception e) 
		{
			throw new EJBException("Error Occured  "+e.getMessage());
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
				throw new EJBException("Error closing the connection "+ cf.getMessage());
			}
		}
		return hshRecord;
	}

	public HashMap updateCMA(HashMap hshValues)  
	{
		String strQuery = "";
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		ResultSet rs3 = null;
		ResultSet rs5 = null;
		HashMap hshQueryValues = new HashMap();
		HashMap hshRecord = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		String strMode = correctNull((String) hshValues.get("hid_mode"));
		String strAction = correctNull((String) hshValues.get("hidAction"));
		int intValue = 0;
		int intUpdatesize = 0;
		String cmano = "", hidtotal="";
		String forcmatype = "";
		try 
		{
			cmano = correctNull((String) hshValues.get("cmano"));
			hidtotal = correctNull((String) hshValues.get("hidtotal"));
			int idlen = 0;
			if (!hidtotal.equals("")) 
			{
				idlen = Integer.parseInt(hidtotal);
			}
			forcmatype = correctNull((String) hshValues.get("cmaformat"));
			for (int i = 1; i <= idlen; i++) 
			{
				String strTemp = correctNull((String) hshValues.get("txtindno"+ i));
				String strDelTemp = correctNull((String) hshValues.get("txtdelindno" + i));
				
				if (strAction.equalsIgnoreCase("insert")) 
				{
					rs = DBUtils.executeLAPSQuery("cmamastermax");
					if (rs.next()) 
					{
						intValue = rs.getInt(1);
					}
					intValue = intValue + 1;
					cmano = Integer.toString(intValue);
					String j = Integer.toString(intValue);
					if (!strTemp.trim().equals("")) 
					{
						strQuery = SQLParser.getSqlQuery("cmamastersel^"+ strTemp);
						rs5 = DBUtils.executeQuery(strQuery);
						if (rs5.next()) 
						{
							hshRecord.put("failure", "N");
							hshRecord.put("success", "Y");
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							hshQuery.put("strQueryId", "cmamasterins");
							arrValues.add(j);
							arrValues.add(forcmatype);
							arrValues.add(strTemp);
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						}
					}
				}
				if (strAction.equalsIgnoreCase("update")) 
				{
					if (!strTemp.equals("") || !strDelTemp.trim().equals("")) 
					{
						if (!strTemp.equals("")) 
						{
							strQuery = SQLParser.getSqlQuery("cmafinappcount^"+ cmano + "^" + strTemp);
						}
						if (!strDelTemp.trim().equals("")) 
						{
							strQuery = SQLParser.getSqlQuery("cmafinappcount^"+ cmano + "^" + strDelTemp);
						}
						if (rs3 != null)//suresh
						{
							rs3.close();
						}
						rs3 = DBUtils.executeQuery(strQuery);
						if (rs3.next()) 
						{
							hshRecord.put("failure", "N");
						} 
						else 
						{
							hshRecord.put("success", "Y");
							if (strDelTemp.trim().equals(strTemp.trim())) 
							{
								strDelTemp = "";
							}
							if (strDelTemp.trim().equals("")) 
							{
								strQuery = SQLParser.getSqlQuery("cmamastersel^" + strTemp);
								if (rs != null) 
								{
									rs.close();
								}
								rs = DBUtils.executeQuery(strQuery);
								if (rs.next()) 
								{
									hshQuery = new HashMap();
									arrValues = new ArrayList();
									intUpdatesize = intUpdatesize + 1;
									hshQuery.put("strQueryId", "cmamasterup");
									arrValues.add(forcmatype);
									arrValues.add(cmano);
									arrValues.add(strTemp);
									hshQuery.put("arrValues", arrValues);
									hshQueryValues.put("size", Integer.toString(intUpdatesize));
									hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
								} 
								else 
								{
									hshQuery = new HashMap();
									arrValues = new ArrayList();
									intUpdatesize = intUpdatesize + 1;
									hshQuery.put("strQueryId", "cmamasterins");
									arrValues.add(cmano);
									arrValues.add(forcmatype);
									arrValues.add(strTemp);
									hshQuery.put("arrValues", arrValues);
									hshQueryValues.put("size", Integer.toString(intUpdatesize));
									hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
								}
							} 
							else 
							{
								strQuery = SQLParser.getSqlQuery("cmamastercount^" + cmano);
								rs1 = DBUtils.executeQuery(strQuery);
								int cnt = 0;
								if (rs1.next()) 
								{
									cnt = rs1.getInt("cnt");
								}
								if (cnt > 1) 
								{
									hshQuery = new HashMap();
									arrValues = new ArrayList();
									intUpdatesize = 1;
									hshQuery.put("strQueryId", "cmamasterdel");
									arrValues.add(cmano);
									arrValues.add(strDelTemp);
									hshQuery.put("arrValues", arrValues);
									hshQueryValues.put("size", Integer.toString(intUpdatesize));
									hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
								} 
								else 
								{									
									hshQuery = new HashMap();
									arrValues = new ArrayList();
									intUpdatesize = 1;
									hshQuery.put("strQueryId", "cmamasterup1");
									arrValues.add(forcmatype);
									arrValues.add("0");
									arrValues.add(cmano);
									hshQuery.put("arrValues", arrValues);									
									hshQueryValues.put("size", Integer.toString(intUpdatesize));
									hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
								}
								EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
							}

						}
					}
				}

				if (strAction.equalsIgnoreCase("delete")) 
				{					
					strQuery = SQLParser.getSqlQuery("cmafinmastersel^" + cmano);
					if (!strTemp.equals("")) 
					{
						rs2 = DBUtils.executeQuery(strQuery);
						if (rs2.next()) 
						{
							hshRecord.put("failure", "N");
						} 
						else 
						{
							hshRecord.put("success", "Y");
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							hshQuery.put("strQueryId", "cmamasterdel1");
							arrValues.add(cmano);
							hshQuery.put("arrValues", arrValues);							
							hshQueryValues.put("size", Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						}

					} 
					else 
					{
						rs = DBUtils.executeLAPSQuery("cmafinappcount1^"+ cmano);
						if (rs.next()) 
						{
							hshRecord.put("failure", "N");
						} 
						else 
						{
							hshRecord.put("success", "Y");
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							hshQuery.put("strQueryId", "cmamasterdel1");
							arrValues.add(cmano);
							hshQuery.put("arrValues", arrValues);							
							hshQueryValues.put("size", Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),
									hshQuery);
						}
					}

				}
			}

			int size = hshQueryValues.size();
			
			if (size > 1) 
			{
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}

			ArrayList vecVal = new ArrayList();
			ArrayList vecRec = new ArrayList();
			ArrayList vecVal1 = new ArrayList();
			ArrayList vecRec1 = new ArrayList();
			String appno = "";
			String strIndid = "";
			appno = (String) hshValues.get("appno");
			strIndid = (String) hshValues.get("strIndid");
			
			if (cmano.trim().equals(""))
			{				
				strQuery = SQLParser.getSqlQuery("cmaindmastersel1");
			} 
			else 
			{
				strQuery = SQLParser.getSqlQuery("cmaindmastersel^" + cmano);
			}
			String cmadesc = "";
			if (rs != null) 
			{
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			
			while (rs.next())
			{
				if (cmano.trim().equals("")) 
				{
					cmano = correctNull(rs.getString(2));
				}
				if (cmadesc.trim().equals("")) 
				{
					cmadesc = correctNull(rs.getString(4));
				}
				vecRec = new ArrayList();
				vecRec.add(correctNull(rs.getString(1)));
				vecRec.add(correctNull(rs.getString(2)));
				vecRec.add(correctNull(rs.getString(3)));
				vecVal.add(vecRec);
			}

			hshRecord.put("cmano", cmano);			

			if (!cmadesc.trim().equals("")) 
			{
				hshRecord.put("cmadesc", cmadesc);				
			}			

			if (!strAction.equalsIgnoreCase("delete")&& !strMode.trim().equalsIgnoreCase("new")) 
			{
				hshRecord.put("cmadesc", correctNull((String) hshValues.get("cmaformat")));				
			}
			
			hshRecord.put("vecVal", vecVal);

		} 
		catch (Exception e) 
		{
			throw new EJBException("Error Occured  "+e.getMessage());
		}

		finally 
		{
			try 
			{
				if (rs != null) 
				{
					rs.close();
				}
				if (rs1 != null) 
				{
					rs1.close();
				}
				if (rs2 != null) 
				{
					rs2.close();
				}
				if (rs3 != null) 
				{
					rs3.close();
				}
			} 
			catch (Exception cf) 
			{
				throw new EJBException("Error closing the connection "+ cf.getMessage());
			}

		}
		
		return hshRecord;
	}

	public HashMap getIndData(HashMap hsh)  
	{		
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshValues = new HashMap();
		ArrayList vecVal = new ArrayList();
		ArrayList vecRec = new ArrayList();
		String appno = "";
		String str = "";
		try 
		{
			appno = (String) hsh.get("appno");
			rs = DBUtils.executeLAPSQuery("indmastsel");
			
			while (rs.next()) 
			{
				vecRec = new ArrayList();				
				vecRec.add(correctNull(rs.getString(1)));
				vecRec.add(correctNull(rs.getString(2)));
				vecRec.add(correctNull(rs.getString(3)));
				vecRec.add(correctNull(rs.getString(4)));
				vecVal.add(vecRec);
			}
			hshValues.put("vecVal", vecVal);
		}

		catch (Exception e) 
		{
			throw new EJBException("Error Occured  "+e.getMessage());
		}

		finally {
			try {
				if (rs != null) 
				{
					rs.close();
				}
			} 
			catch (Exception e1) 
			{
				throw new EJBException("Error Occured  "+e1.getMessage());
			}
		}
		
		return hshValues;
	}

	public HashMap getFormulaData(HashMap hsh)  
	{		
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshValues = new HashMap();
		ArrayList arr = new ArrayList();
		ArrayList arr1 = new ArrayList();
		String val = "";
		String appno = "";
		String str = "";
		boolean recordflag=false;
		try {

			val = (String) hsh.get("cmano");			
			strQuery = SQLParser.getSqlQuery("formulasel^" + val);
			rs = DBUtils.executeQuery(strQuery);
			
			while (rs.next()) 
			{
				recordflag=true;
				arr.add(correctNull(rs.getString("formula_rowid")) + "::"
						+ correctNull(rs.getString("formula")) + "::"
						+ correctNull(rs.getString("formula_desc")) + "::"
						+ correctNull(rs.getString("formula_for")) + "::"
						+ correctNull(rs.getString("formula_shortcode")) + "::"
						+ correctNull(rs.getString("formula_cma_no")) + "::"
						+ correctNull(rs.getString("formula_for_type")));			

				arr1.add(correctNull(rs.getString("formula_rowname")));
			}
			hshValues.put("arr", arr);
			hshValues.put("arr1", arr1);
			if(recordflag)
				hshValues.put("recordflag","Y");
			else
				hshValues.put("recordflag","N");
		}

		catch (Exception e) 
		{
			throw new EJBException("Error Occured  "+e.getMessage());
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
				throw new EJBException("Error Occured  "+e1.getMessage());
			}
		}
		
		return hshValues;
	}

	public HashMap getDataHelp(HashMap hsh)  
	{
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshvalues = new HashMap();
		ArrayList arr = new ArrayList();
		ArrayList arr1 = new ArrayList();
		String str = "", value5 = "", value6 = "";
		try 
		{
			str = (String) hsh.get("val");
			str = str.trim();
			value5 = Helper.correctNull((String) hsh.get("tabtitle"));
			value6 = Helper.correctNull((String) hsh.get("cmano"));

			if (str.equals("formula")) 
			{
				rs = DBUtils.executeLAPSQuery("formulachoice");
				while (rs.next()) 
				{
					arr.add(correctNull(rs.getString("formula_rowid")));
					arr1.add(correctNull(rs.getString("formula_rowname")));
				}
				hshvalues.put("arrVal", arr);
				hshvalues.put("arrValdesc", arr1);
			}

			if (str.equals("cma")) 
			{
				rs = DBUtils.executeLAPSQuery("cmachoice");
				while (rs.next()) 
				{
					arr.add(correctNull(rs.getString("cma_no")));
					arr1.add(correctNull(rs.getString("cma_format_desc")));
				}
				hshvalues.put("arrVal", arr);
				hshvalues.put("arrValdesc", arr1);
			}

			if (str.equals("tabtitle")) 
			{
				rs = DBUtils.executeLAPSQuery("tabchoice^" + value6);
				while (rs.next()) 
				{
					arr.add(correctNull(rs.getString("fin_tabname")));
					arr1.add(correctNull(rs.getString("fin_tabname")));
				}
				hshvalues.put("arrVal", arr);
				hshvalues.put("arrValdesc", arr1);
			}

			if (str.equals("rowdesc")) 
			{
				rs = DBUtils.executeLAPSQuery("rowchoice^" + value6 + "^"+ value5);
				while (rs.next()) 
				{
					String totalval;
					totalval = correctNull(rs.getString("formula_rowname"))
							+ "^" + correctNull(rs.getString("formula_rowid"))
							+ "^" + correctNull(rs.getString("fin_rowtype"))
							+ "^" + correctNull(rs.getString("fin_rowid"));
					arr.add(totalval);
					arr1.add(correctNull(rs.getString("fin_rowdesc")));
				}
				hshvalues.put("arrVal", arr);
				hshvalues.put("arrValdesc", arr1);
			}

		}

		catch (Exception e) 
		{
			throw new EJBException("Error Occured  "+e.getMessage());
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
				throw new EJBException("Error Occured  "+e1.getMessage());
			}
		}
		
		return hshvalues;
	}
	/**
	 * @author Anbu
	 * @param hshValues
	 * @return HashMap
	 * @
	 */
	public HashMap getCMA(HashMap hshValues)  
	{
		ResultSet rs = null;
		String strQuery = "";
		HashMap hshRecord = new HashMap();
		ArrayList arrIndusttryVal = new ArrayList();
		ArrayList arrIndusttryname = new ArrayList();
		String cmano = "";
		cmano = correctNull((String) hshValues.get("cmano"));
		ArrayList arrIndustryCheckedVal = new ArrayList();
		ArrayList arrIndustrycheckedname = new ArrayList();

		String strCMAName = "";
		String strCMANo = "";

		try {
			//strQuery = SQLParser.getSqlQuery("cmaindmastersel1");		
			strQuery = SQLParser.getSqlQuery("selindustryname");
			if (rs != null) 
			{
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) 
			{
				arrIndusttryname = new ArrayList();
				arrIndusttryname.add(correctNull(rs.getString("ind_no")));
				arrIndusttryname.add(correctNull(rs.getString("ind_name")));
				arrIndusttryVal.add(arrIndusttryname);
			}
			hshRecord.put("arrIndusttryVal", arrIndusttryVal);

			if (!cmano.trim().equalsIgnoreCase("")) 
			{
				strCMAName = correctNull((String) hshValues.get("cmaformat"));
				strCMANo = cmano;
				strQuery = SQLParser.getSqlQuery("cmaindmastersel^" + cmano);

				if (rs != null) 
				{
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) 
				{
					strCMAName = correctNull((String) rs.getString("cma_format_desc"));
					arrIndustrycheckedname = new ArrayList();
					arrIndustrycheckedname.add(correctNull(rs.getString("ind_no")));
					arrIndustrycheckedname.add(correctNull(rs.getString("cma_no")));
					arrIndustrycheckedname.add(correctNull(rs.getString("ind_name")));
					arrIndustrycheckedname.add(correctNull(rs.getString("cma_format_desc")));
					arrIndustryCheckedVal.add(arrIndustrycheckedname);
				}
			}
			hshRecord.put("strCMANo", strCMANo);
			hshRecord.put("strCMAName", strCMAName);
			hshRecord.put("arrIndustryCheckedVal", arrIndustryCheckedVal);

		} 
		catch (Exception e) 
		{
			throw new EJBException("Error Occured  "+e.getMessage());
		}
		return hshRecord;
	}
/**
 * @author Anbu
 * @param hshValues
 * @return HashMap
 * @
 */
	public HashMap updateCMAData(HashMap hshValues)  
	{
		ResultSet rs = null;
		int intValue = 0;
		String cmano = "";
		String strAction = "";
		String strQuery = "";
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		int intUpdatesize = 0;
		String forcmatype = "";
		forcmatype = correctNull((String) hshValues.get("cmaformat"));
		strAction = correctNull((String) hshValues.get("hidAction"));
		String[] strIndustryNames = null;
		String strindustryname = "";
		if (hshValues.get("indno") instanceof java.lang.String) 
		{
			strindustryname = (String) hshValues.get("indno");
		} 
		else 
		{
			strIndustryNames = (String[]) hshValues.get("indno");
		}

		try 
		{
			if (strAction.equalsIgnoreCase("insert")) 
			{
				rs = DBUtils.executeLAPSQuery("cmamastermax");
				if (rs.next()) 
				{
					intValue = rs.getInt(1);
				}
				intValue = intValue + 1;
				cmano = Integer.toString(intValue);				
				strQuery = SQLParser.getSqlQuery("getcmaindmaster");
				ArrayList arrCMAIndNo = new ArrayList();
				
				if (rs != null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) 
				{
					arrCMAIndNo.add(correctNull(rs.getString("ind_no")));
				}

				if (hshValues.get("indno") instanceof java.lang.String) 
				{					
					if(arrCMAIndNo.contains(strindustryname))
						return hshValues;
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize = intUpdatesize + 1;
					hshQuery.put("strQueryId", "cmamasterins");
					arrValues.add(cmano);
					arrValues.add(forcmatype);
					arrValues.add(strindustryname);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("size", Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				} 
				else 
				{
					for (int i = 0; i < strIndustryNames.length; i++) 
					{
						if(arrCMAIndNo.contains(strIndustryNames[i]))
							continue;
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intUpdatesize = intUpdatesize + 1;
						hshQuery.put("strQueryId", "cmamasterins");
						arrValues.add(cmano);
						arrValues.add(forcmatype);
						arrValues.add(strIndustryNames[i]);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("size", Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					}
				}
			}

			if (strAction.equalsIgnoreCase("update")) 
			{
				cmano = correctNull((String) hshValues.get("cmano"));
				if ((hshValues.get("indno") instanceof java.lang.String) || (hshValues.get("indno") ==null)) 
				{					
					strQuery = SQLParser.getSqlQuery("cmaindmastersel^" + cmano);
					ArrayList arrCMAIndNo = new ArrayList();
					if (rs != null)
						rs.close();
					rs = DBUtils.executeQuery(strQuery);
					while (rs.next()) {
						arrCMAIndNo.add(correctNull(rs.getString("ind_no")));
					}				

					ArrayList arrIndNo = new ArrayList();
					if(hshValues.get("indno") !=null)
					arrIndNo.add(hshValues.get("indno"));

					ArrayList arrIndBSRCode = new ArrayList();
					for (int i = 0; i < arrIndNo.size(); i++) 
					{
						if(arrCMAIndNo.contains(arrIndNo.get(i)))
							arrCMAIndNo.remove(arrIndNo.get(i));
						strQuery = SQLParser.getSqlQuery("selectindbsrcode^"+ Helper.correctNull((String) arrIndNo.get(i)));

						if (rs != null) 
						{
							rs.close();
						}
						rs = DBUtils.executeQuery(strQuery);
						if (rs.next()) 
						{
							arrIndBSRCode.add(correctNull(rs.getString("ind_bsr_code")));
						}

					}

					ArrayList arrComAppId = new ArrayList();
					for (int i = 0; i < arrIndBSRCode.size(); i++) 
					{
						strQuery = SQLParser.getSqlQuery("cmaindcomapplicant^"+ correctNull((String) arrIndBSRCode.get(i)));
						if (rs != null) 
						{
							rs.close();
						}
						rs = DBUtils.executeQuery(strQuery);
						while (rs.next()) 
						{
							arrComAppId.add(correctNull(rs.getString("comapp_id")));
						}
					}

					ArrayList arrFacilityBorrowerId = new ArrayList();
					for (int i = 0; i < arrComAppId.size(); i++) 
					{
						strQuery = SQLParser.getSqlQuery("cmaborroweridfacility^"+ correctNull((String) arrComAppId.get(i)));
						if (rs != null) 
						{
							rs.close();
						}
						rs = DBUtils.executeQuery(strQuery);
						while (rs.next()) 
						{
							arrFacilityBorrowerId.add(correctNull(rs.getString("borrower_id")));
						}
					}
					
					strQuery = SQLParser.getSqlQuery("cmaindustrymastersel^" + cmano);
					ArrayList arrCMAIndNumber = new ArrayList();
					if (rs != null)
						rs.close();
					rs = DBUtils.executeQuery(strQuery);
					while (rs.next()) 
					{
						arrCMAIndNumber.add(correctNull(rs.getString("ind_no")));
					}
					
	for(int intCMAIndNo=0;intCMAIndNo<arrCMAIndNo.size();intCMAIndNo++)
	{						
						ArrayList arrDelIndBSRCode = new ArrayList();
						strQuery = SQLParser.getSqlQuery("selectindbsrcode^"+ intCMAIndNo);
						if (rs != null)
							rs.close();
						rs = DBUtils.executeQuery(strQuery);
						if (rs.next()) 
						{
							arrDelIndBSRCode.add(correctNull(rs.getString("ind_bsr_code")));
						}
				
						ArrayList arrDelComAppId = new ArrayList();
						for (int j = 0; j < arrDelIndBSRCode.size(); j++) {
							strQuery = SQLParser.getSqlQuery("cmaindcomapplicant^"+ correctNull((String) arrDelIndBSRCode.get(j)));
							if (rs != null)
								rs.close();
							rs = DBUtils.executeQuery(strQuery);
							while (rs.next()) 
							{
								arrDelComAppId.add(correctNull(rs.getString("comapp_id")));
							}
						}

						ArrayList arrDelFacilityBorrowerId = new ArrayList();
						for (int z = 0; z < arrDelComAppId.size(); z++) 
						{
							strQuery = SQLParser.getSqlQuery("cmaborroweridfacility^"+ correctNull((String) arrDelComAppId.get(z)));
							if (rs != null)
								rs.close();
							rs = DBUtils.executeQuery(strQuery);
							while (rs.next()) 
							{
								arrDelFacilityBorrowerId.add(correctNull(rs.getString("borrower_id")));
							}
						}

						if (arrDelFacilityBorrowerId.size() > 0)
							continue;
						
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intUpdatesize = intUpdatesize + 1;
						hshQuery.put("strQueryId", "cmamasterdelete");
						arrValues.add(cmano);
						arrValues.add(arrCMAIndNo.get(intCMAIndNo));
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("size", Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
						}
	
						
					if (arrFacilityBorrowerId.size() > 0)						
						return hshValues;
					
						if(arrCMAIndNumber.contains(Helper.correctNull((String)hshValues.get("indno"))))
							return hshValues;
						
						intUpdatesize = 0;	
						
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize = intUpdatesize + 1;
					hshQuery.put("strQueryId", "cmamasterdelete");
					arrValues.add(cmano);
					arrValues.add(Helper.correctNull((String) hshValues.get("indno")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("size", Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);

					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize = intUpdatesize + 1;
					hshQuery.put("strQueryId", "cmamasterins");
					arrValues.add(cmano);
					arrValues.add(forcmatype);
					arrValues.add(strindustryname);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("size", Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					
				} 
				else 
				{
					strQuery = SQLParser.getSqlQuery("cmaindmastersel^" + cmano);
					ArrayList arrCMAIndNo = new ArrayList();
					ArrayList arrIndNo = new ArrayList();
					ArrayList arrIndBSRCode = new ArrayList();
					ArrayList arrComAppId = new ArrayList();
					ArrayList arrFacilityBorrowerId = new ArrayList();
					if (rs != null)
						rs.close();
					rs = DBUtils.executeQuery(strQuery);
					while (rs.next()) {
						arrCMAIndNo.add(correctNull(rs.getString("ind_no")));
					}

					strQuery = SQLParser.getSqlQuery("cmaindustrymastersel^" + cmano);
					ArrayList arrCMAIndNumber = new ArrayList();
					if (rs != null)
						rs.close();
					rs = DBUtils.executeQuery(strQuery);
					while (rs.next()) 
					{
						arrCMAIndNumber.add(correctNull(rs.getString("ind_no")));
					}

					for (int i = 0; i < strIndustryNames.length; i++) 
					{	
						if(arrCMAIndNumber.contains(strIndustryNames[i]))
						{
							arrCMAIndNo.remove(strIndustryNames[i]);
							continue;
						}

						cmano = correctNull((String) hshValues.get("cmano"));						
						arrIndNo = new ArrayList();
						arrIndBSRCode = new ArrayList();
						arrComAppId = new ArrayList();
						arrFacilityBorrowerId = new ArrayList();
						arrIndNo.add(correctNull(strIndustryNames[i]));	
							
							for (int k = 0; k < arrIndNo.size(); k++) 
							{
								if(arrCMAIndNo.contains(arrIndNo.get(k)))
									arrCMAIndNo.remove(arrIndNo.get(k));
								strQuery = SQLParser.getSqlQuery("selectindbsrcode^"+ Helper.correctNull((String) arrIndNo
																.get(k)));

								if (rs != null)
									rs.close();
								rs = DBUtils.executeQuery(strQuery);
								if (rs.next()) 
								{
									arrIndBSRCode.add(correctNull(rs.getString("ind_bsr_code")));
								}
							}

							
							for (int j = 0; j < arrIndBSRCode.size(); j++) 
							{
								strQuery = SQLParser.getSqlQuery("cmaindcomapplicant^"+ correctNull((String) arrIndBSRCode
														.get(j)));
								if (rs != null)
									rs.close();
								rs = DBUtils.executeQuery(strQuery);
								while (rs.next()) 
								{
									arrComAppId.add(correctNull(rs.getString("comapp_id")));
								}
							}

							
							for (int z = 0; z < arrComAppId.size(); z++) 
							{
								strQuery = SQLParser.getSqlQuery("cmaborroweridfacility^"+ correctNull((String) arrComAppId
														.get(z)));
								if (rs != null)
									rs.close();
								rs = DBUtils.executeQuery(strQuery);
								while (rs.next()) 
								{
									arrFacilityBorrowerId.add(correctNull(rs.getString("borrower_id")));
								}
							}

							if (arrFacilityBorrowerId.size() > 0)
								continue;
							
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							hshQuery.put("strQueryId", "cmamasterdelete");
							arrValues.add(cmano);
							arrValues.add(strIndustryNames[i]);
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);

							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intUpdatesize = intUpdatesize + 1;
							hshQuery.put("strQueryId", "cmamasterins");
							arrValues.add(cmano);
							arrValues.add(forcmatype);
							arrValues.add(strIndustryNames[i]);
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						}
						
					for(int intCMAIndNo=0;intCMAIndNo<arrCMAIndNo.size();intCMAIndNo++)
					{						
						ArrayList arrDelIndBSRCode = new ArrayList();
					for (int k = 0; k < arrCMAIndNo.size(); k++) 
					{
						strQuery = SQLParser.getSqlQuery("selectindbsrcode^"+ Helper.correctNull((String) arrCMAIndNo.get(k)));
						if (rs != null)
							rs.close();
						rs = DBUtils.executeQuery(strQuery);
						if (rs.next()) 
						{
							arrDelIndBSRCode.add(correctNull(rs.getString("ind_bsr_code")));
						}
					}
						
						ArrayList arrDelComAppId = new ArrayList();
						for (int j = 0; j < arrDelIndBSRCode.size(); j++) 
						{
							strQuery = SQLParser.getSqlQuery("cmaindcomapplicant^"+ correctNull((String) arrDelIndBSRCode
													.get(j)));
							if (rs != null)
								rs.close();
							rs = DBUtils.executeQuery(strQuery);
							while (rs.next()) 
							{
								arrDelComAppId.add(correctNull(rs.getString("comapp_id")));
							}
						}

						ArrayList arrDelFacilityBorrowerId = new ArrayList();
						for (int z = 0; z < arrDelComAppId.size(); z++) {
							strQuery = SQLParser.getSqlQuery("cmaborroweridfacility^"
											+ correctNull((String) arrDelComAppId.get(z)));
							if (rs != null)
								rs.close();
							rs = DBUtils.executeQuery(strQuery);
							while (rs.next()) 
							{
								arrDelFacilityBorrowerId.add(correctNull(rs.getString("borrower_id")));
							}
						}

						if (arrDelFacilityBorrowerId.size() > 0)
							continue;
						
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intUpdatesize = intUpdatesize + 1;
						hshQuery.put("strQueryId", "cmamasterdelete");
						arrValues.add(cmano);
						arrValues.add(arrCMAIndNo.get(intCMAIndNo));
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("size", Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						
						}
					}
		}
		
			if (strAction.equalsIgnoreCase("delete")) 
			{
				cmano = correctNull((String) hshValues.get("cmano"));
				strQuery = SQLParser.getSqlQuery("cmaindmastersel^" + cmano);
				ArrayList arrIndNo = new ArrayList();

				if (rs != null) 
				{
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) 
				{
					arrIndNo.add(correctNull(rs.getString("ind_no")));
				}
				ArrayList arrIndBSRCode = new ArrayList();
				for (int i = 0; i < arrIndNo.size(); i++) 
				{
					strQuery = SQLParser.getSqlQuery("selectindbsrcode^"+ Helper.correctNull((String) arrIndNo.get(i)));

					if (rs != null) 
					{
						rs.close();
					}
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) 
					{
						arrIndBSRCode.add(correctNull(rs.getString("ind_bsr_code")));
					}

				}
				ArrayList arrComAppId = new ArrayList();
				for (int i = 0; i < arrIndBSRCode.size(); i++) 
				{
					strQuery = SQLParser.getSqlQuery("cmaindcomapplicant^"+ correctNull((String) arrIndBSRCode.get(i)));
					if (rs != null) 
					{
						rs.close();
					}
					rs = DBUtils.executeQuery(strQuery);
					while (rs.next()) 
					{
						arrComAppId.add(correctNull(rs.getString("comapp_id")));
					}
				}
				ArrayList arrFacilityBorrowerId = new ArrayList();
				for (int i = 0; i < arrComAppId.size(); i++) 
				{
					strQuery = SQLParser.getSqlQuery("cmaborroweridfacility^"+ correctNull((String) arrComAppId.get(i)));
					if (rs != null) 
					{
						rs.close();
					}
					rs = DBUtils.executeQuery(strQuery);
					while (rs.next()) 
					{
						arrFacilityBorrowerId.add(correctNull(rs.getString("borrower_id")));
					}
				}

				if (arrFacilityBorrowerId.size() > 0)
					return hshValues;

				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdatesize = intUpdatesize + 1;
				hshQuery.put("strQueryId", "cma_masterdelete");
				arrValues.add(cmano);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
			}
			if (!strAction.trim().equalsIgnoreCase(""))
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
		} 
		catch (Exception e) 
		{
			throw new EJBException("Error Occured  "+e.getMessage());
		}
		return hshValues;
	}
}