package com.sai.laps.ejb.agrcoffee;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.ApplicantParams;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.helper.SetupParams;

@Stateless(name = "agrcoffeeBean", mappedName = "agrcoffeeHome")
@Remote (agrcoffeeRemote.class)
public class agrcoffeeBean extends BeanAdapter 
{
	static Logger log=Logger.getLogger(agrcoffeeBean.class);	
	/**
	 * 
	 */
	private static final long serialVersionUID = 7984919827714540220L;

	/**
	 * 
	 */
	

	public HashMap getCoffeeEstateData(HashMap hshValues)  {

		String strQuery="";
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		ResultSet rs3  = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();
		ArrayList vecVal=new ArrayList();
			
		try
		{
			java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
			jtn.setMaximumFractionDigits(2);
			jtn.setMinimumFractionDigits(2);
			jtn.setGroupingUsed(false);
			String appno=correctNull((String)hshValues.get("appno"));
				if(appno.equalsIgnoreCase("null") ||  appno.equalsIgnoreCase(""))
			{
				appno = correctNull((String)hshValues.get("strappno"));
			}
			String strAction = correctNull((String)hshValues.get("hidAction"));
			String strGradeNo= correctNull((String)hshValues.get("selsno"));
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^"+appno);
			rs1 = DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				hshRecord.put("app_name",Helper.correctDoubleQuote(correctNull(rs1.getString("app_name"))) );
				hshRecord.put("app_status",Helper.correctDoubleQuote(correctNull(rs1.getString("app_status"))) );
				hshRecord.put("applicantid",rs1.getString("demo_appid"));
			}
			
			if(strAction.trim().equals("edit"))
			{
				strQuery = SQLParser.getSqlQuery("agrcoffeestatesel^"+appno+"^"+strGradeNo);
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("agrcoffeestateselection^"+appno);
			}				
			
			rs2 =DBUtils.executeQuery(strQuery);
			while(rs2.next())
			{
				vecVal = new ArrayList();
				vecVal.add(correctNull(rs2.getString("appno")));
				vecVal.add(correctNull(rs2.getString("coffee_estate")));
				vecVal.add(correctNull(rs2.getString("coffee_id")));
				vecVal.add(correctNull(rs2.getString("coffee_regno")));
				vecVal.add(correctNull(rs2.getString("coffee_village")));
				vecVal.add(correctNull(rs2.getString("coffee_taluk")));
				vecVal.add(correctNull(rs2.getString("coffee_district")));
				vecVal.add(correctNull(rs2.getString("coffee_survey")));
				vecVal.add(correctNull(rs2.getString("coffee_location")));
				vecVal.add(correctNull(rs2.getString("coffee_value")));
				vecVal.add(correctNull(rs2.getString("coffee_acreage")));
				vecVal.add(correctNull(rs2.getString("coffee_acreage1")));
				vecData.add(vecVal);							
			}	
	    	hshRecord.put("vecData",vecData);
	    	
	    	strQuery = SQLParser.getSqlQuery("agrlandmeasurement^"+appno);
			rs3 = DBUtils.executeQuery(strQuery);
			if(rs3.next())
					{
						hshRecord.put("land_measurement",correctNull(rs3.getString("land_measurement")));
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
				if(rs1 != null)
				{
					rs1.close();
				}
				if(rs2 != null)
				{
					rs2.close();
				}
				if(rs3 != null)
				{
					rs3.close();
				}
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}
	private int getMaxGradeId(String appno)
	{
		
		String strQuery="";
		ResultSet rs = null;
		int termId = 0;

		try
		{	
			strQuery = SQLParser.getSqlQuery("agrcoffeemax^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				if(rs.getString(1) != null)
				{
					termId = Integer.parseInt(rs.getString(1)) + 1;
				}
				else
				{
					termId = 1;
				}
			}
			rs.close();			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getMaxGradeId "+ce.toString());
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
				throw new EJBException("Error closing the connection in getMaxGradeId"+cf.getMessage());
			}
		}
		return termId;
	}
	

	public void updateCoffeeEstateData(HashMap hshValues)  
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String strGradeId = "";
		String measurementtype = null;
		String appno=correctNull((String)hshValues.get("appno"));
	 	if(appno.equalsIgnoreCase("null") ||  appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("strappno"));
		}
		ResultSet rs = null;
		StringBuilder sbaudittrail = null;
		try
		{
			sbaudittrail=new StringBuilder();
			if(strAction.equals("update"))
			{
				strGradeId =  correctNull((String )hshValues.get("selsno"));	
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","agrcoffeestateupdate");			
				arrValues.add(correctNull((String)hshValues.get("txt_estate")));
				arrValues.add(correctNull((String )hshValues.get("txt_coffeeregno")));
				arrValues.add(correctNull((String )hshValues.get("txt_village")));
				arrValues.add(correctNull((String )hshValues.get("txt_taluk")));
				arrValues.add(correctNull((String )hshValues.get("txt_district")));
				arrValues.add(correctNull((String )hshValues.get("txt_survey")));
				arrValues.add(correctNull((String )hshValues.get("txt_location")));
				String val=correctNull((String )hshValues.get("txt_value"));
				if(val.equalsIgnoreCase(""))
				{
					val="0.00";
				}
				arrValues.add(val);
				
				
				arrValues.add(correctNull((String )hshValues.get("txt_acreage")));
				arrValues.add(correctNull((String )hshValues.get("txt_acreage1")));
				arrValues.add(appno);
				arrValues.add(strGradeId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.trim().equals("insert"))
			{				
				strGradeId = Integer.toString(getMaxGradeId(appno));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");	
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","agrcoffeestateinsert");
				arrValues.add(appno);
				arrValues.add(correctNull((String)hshValues.get("txt_estate")));
				arrValues.add(strGradeId);
				arrValues.add(correctNull((String )hshValues.get("txt_coffeeregno")));
				arrValues.add(correctNull((String )hshValues.get("txt_village")));
				arrValues.add(correctNull((String )hshValues.get("txt_taluk")));
				arrValues.add(correctNull((String )hshValues.get("txt_district")));
				arrValues.add(correctNull((String )hshValues.get("txt_survey")));
				arrValues.add(correctNull((String )hshValues.get("txt_location")));
			
				String val=correctNull((String )hshValues.get("txt_value"));
				if(val.equalsIgnoreCase(""))
				{
					val="0.00";
				}
				arrValues.add(val);
				arrValues.add(correctNull((String )hshValues.get("txt_acreage")));
				arrValues.add(correctNull((String )hshValues.get("txt_acreage1")));
			    hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equals("delete"))
			{
				strGradeId =  correctNull((String )hshValues.get("selsno"));
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","agrcoffeestatedelete");
				arrValues.add(appno);
				arrValues.add(strGradeId);				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
//			-------------------Start Of Audit Trail-------------------
			sbaudittrail.append("~Name of the Estate(s) Owned = ").append(correctNull((String)hshValues.get("txt_estate")))
						.append("~Coffee Registration No.= ").append(correctNull((String )hshValues.get("txt_coffeeregno")))
						.append("~Village= ").append(correctNull((String )hshValues.get("txt_village")))
						.append("~Location(Zone)= ").append(correctNull((String )hshValues.get("txt_location")))
						.append("~Taluk= ").append(correctNull((String )hshValues.get("txt_taluk")))
						.append("~Survey No. = ").append(correctNull((String )hshValues.get("txt_survey")))
						.append("~District= ").append(correctNull((String )hshValues.get("txt_district")))
						.append("~Value of Land(Rs. in Lakhs)= ").append((String )hshValues.get("txt_value"))
						.append("~Extent= ").append(correctNull((String )hshValues.get("txt_acreage"))).append(" Acre ").append(correctNull((String )hshValues.get("txt_acreage1")));
			measurementtype = correctNull((String)hshValues.get("land_measurement"));
			if(measurementtype.equalsIgnoreCase("c"))
  	  		{
  	 			sbaudittrail.append(" Cents");
  	 		}
  	 		 else
  	  		{
  	 			sbaudittrail.append(" Guntas");
   	 		}
   	 		AuditTrial.auditLog(hshValues,"279",appno,sbaudittrail.toString());
//			------------------- End  Of Audit Trail-------------------
   	 		
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
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
	public HashMap getcoffeeplantdata(HashMap hshValues)  
	{
		String strQuery = "";
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord = new HashMap();
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;
		String appno = correctNull((String) hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") ||  appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("strappno"));
		}
       
        String PageType=correctNull((String)hshValues.get("hidpagetype1"));
        if(PageType.equalsIgnoreCase(""))
        {
        	 PageType=correctNull((String)hshValues.get("hidpagetype"));
        }
        
		try 
		{
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshRecord.put("applicantid", rs.getString("demo_appid"));
			}
										 
			strQuery = SQLParser.getSqlQuery("per_get_coffeeplantdata^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arryCol = new ArrayList();
				arryCol.add(rs.getString("seqno"));
				arryCol.add(appno);
				arryCol.add(rs.getString("sno"));
				arryCol.add(rs.getString("coffee_type"));
				arryCol.add(rs.getString("coffee_plantarea"));
				arryCol.add(rs.getString("coffee_plantguntas"));
				arryCol.add(rs.getString("coffee_bearingarea"));
				arryCol.add(rs.getString("coffee_bearingguntas"));
				arryCol.add(rs.getString("coffee_nonbearingarea"));
				arryCol.add(rs.getString("coffee_nonbearingguntas"));
				arryRow.add(arryCol);
			}
			strQuery = SQLParser.getSqlQuery("agrlandmeasurement^"+appno);
			rs1= DBUtils.executeQuery(strQuery);
			if(rs1.next())
					{
			hshRecord.put("land_measurement",correctNull(rs1.getString("land_measurement")));
					}
			hshRecord.put("appno", appno);
			hshRecord.put("arryRow", arryRow);
			hshRecord.put("PageType", PageType);
			
		} 
		catch (Exception ce)
		{
			throw new EJBException("Error in closing getData" + ce.getMessage());
		}
		finally 
		{
			try
			{
				if (rs != null) 
				{
					rs.close();
					rs = null;
				}
				if (rs1 != null) 
				{
					rs1.close();
					rs1 = null;
				}
				
			}
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshRecord;
	}

	public HashMap updatecoffeeplantdata(HashMap hshValues)  
	{
		String strQuery = "";
		HashMap hshQueryValues = new HashMap();
	//	HashMap hshQueryValues6 = new HashMap();
		HashMap hshpasValues = new HashMap();
		HashMap hshQuery = new HashMap();
		//HashMap hshQuery5 = new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null;
		String strAction = null;		
		HashMap hshResult = new HashMap();
		HashMap hshQuery4 = new HashMap();
		int intUpdatesize = 0;
		StringBuilder sbaudittrail=null;
		int f = 0;
		String strid = "", strQuery1 = "";
		String appno = correctNull((String) hshValues.get("appno"));
			if(appno.equalsIgnoreCase("null") ||  appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("strappno"));
		}
		strAction = correctNull((String) hshValues.get("hidAction"));
			
		try 
		{
			String[] txt_area1 = null;
			String[]txt_guntas1 = null;
			String[] txt_area2 = null;
			String[] txt_guntas2 = null;
			String[]txt_area3 = null;
			String[] txt_guntas3 = null;
			String measurementtype=null;
			String measurementtypedesc=null;
			String strcropname=null;
			sbaudittrail=new StringBuilder();
			txt_area1= (String[]) hshValues.get("txt_area1");
			txt_guntas1= (String[]) hshValues.get("txt_guntas1");
			txt_area2 = (String[]) hshValues.get("txt_area2");
			strid = correctNull((String) hshValues.get("hid_sno"));
			txt_guntas2 = (String[]) hshValues.get("txt_guntas2");
			txt_area3 = (String[]) hshValues.get("txt_area3");
			txt_guntas3  = (String[]) hshValues.get("txt_guntas3");
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshResult.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshResult.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshResult.put("applicantid", rs.getString("demo_appid"));
			}
			if (strAction.equals("delete"))
			{
				hshQuery4 = new HashMap();
				HashMap hshQueryValues4 = new HashMap();
				ArrayList arrValues4 = new ArrayList();
				hshQueryValues4.put("size", "1");
				hshQuery4.put("strQueryId", "per_del_coffeeplantdata");
				arrValues4.add(appno);
				hshQuery4.put("arrValues", arrValues4);
				hshQueryValues4.put("1", hshQuery4);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues4,"updateData");
			}
			
			if (strAction.equals("insert"))
			{
				HashMap hshQuery3 = new HashMap();
				ArrayList arrValues3 = new ArrayList();
				hshQuery3.put("size", "2");
				hshQuery3.put("strQueryId", "per_del_coffeeplantdata");
				arrValues3.add(appno);
				hshQuery3.put("arrValues", arrValues3);
				strQuery1 = SQLParser.getSqlQuery("sel_maxid_coffeeplantdata");
				rs = DBUtils.executeQuery(strQuery1);
				if (rs.next())
				{
					strid = correctNull((String) rs.getString("maxid"));
					f = Integer.parseInt(strid);
				}
				intUpdatesize = 1;

				for (int i = 0; i < txt_area1.length; i++)
				{					
					intUpdatesize = intUpdatesize + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "per_ins_coffeeplantdata");
					arrValues.add(Integer.toString(f));
					arrValues.add(appno);
					arrValues.add(new Integer(i + 1).toString());
					if (i + 1 == 1) 
					{
						arrValues.add("ar");
					}
					if (i + 1 == 2) 
					{
						arrValues.add("rb");
					}
					
					if (correctNull( txt_area1[i]).equals("")) 
					{
						arrValues.add("0");
					} 
					else 
					{
						arrValues.add(correctNull(txt_area1[i]));
					}
					if (correctNull(txt_guntas1[i]).equals(""))
					{
						arrValues.add("0");
					} 
					else 
					{
						arrValues.add(correctNull(txt_guntas1[i]));
					}
					if (correctNull(txt_area2[i]).equals("")) 
					{
						arrValues.add("0");
					}
					else 
					{
						arrValues.add(correctNull(txt_area2[i]));
					}
					if (correctNull(txt_guntas2[i]).equals(""))
					{
						arrValues.add("0");
					} 
					else
					{
						arrValues.add(correctNull(txt_guntas2[i]));
					}
					if (correctNull(txt_area3[i]).equals(""))
					{
						arrValues.add("0");
					} 
					else 
					{
						arrValues.add(correctNull(txt_area3[i]));
					}
					if (correctNull(txt_guntas3[i]).equals(""))
					{
						arrValues.add("0");
					} 
					else
					{
						arrValues.add(correctNull(txt_guntas3[i]));
					}
					
					hshQuery.put("arrValues", arrValues);
					f = f + 1;
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);					
				}
				hshQueryValues.put("1", hshQuery3);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
//              --------------------Start Of Audit Trail--------------------
				measurementtype = Helper.correctNull((String)hshValues.get("land_measurement"));
				for (int i = 0; i < txt_area1.length; i++)
				{	
					if (i + 1 == 1) 
					{
						strcropname="~Arabica-";
					}
					if (i + 1 == 2) 
					{
						strcropname="~Robusta-";
					}
					if(measurementtype.equalsIgnoreCase("c"))
					{
						measurementtypedesc="Cents";
					}
					else
					{
						measurementtypedesc="Guntas";
					}
					sbaudittrail.append(strcropname).append("Planted Area= ");
					if(((String)correctNull(txt_area1[i])).length()==0)
					{
						sbaudittrail.append("0");
					}
					else
					{
						sbaudittrail.append((String)correctNull(txt_area1[i]));
					}
					sbaudittrail.append(" Acres ");
					if(((String)correctNull(txt_guntas1[i])).length()==0)
					{
						sbaudittrail.append("0");
					}
					else
					{
						sbaudittrail.append((String)correctNull(txt_guntas1[i]));
					}
					sbaudittrail.append(" ").append(measurementtypedesc);
					
					sbaudittrail.append(strcropname).append("Bearing Area= ");
					if(((String)correctNull(txt_area2[i])).length()==0)
					{
						sbaudittrail.append("0");
					}
					else
					{
						sbaudittrail.append((String)correctNull(txt_area2[i]));
					}
					sbaudittrail.append(" Acres ");
					if(((String)correctNull(txt_guntas2[i])).length()==0)
					{
						sbaudittrail.append("0");
					}
					else
					{
						sbaudittrail.append((String)correctNull(txt_guntas2[i]));
					}
					sbaudittrail.append(" ").append(measurementtypedesc);
					
					sbaudittrail.append(strcropname).append("Non Bearing Area= ");
					if(((String)correctNull(txt_area3[i])).length()==0)
					{
						sbaudittrail.append("0");
					}
					else
					{
						sbaudittrail.append((String)correctNull(txt_area3[i]));
					}
					sbaudittrail.append(" Acres ");
					if(((String)correctNull(txt_guntas3[i])).length()==0)
					{
						sbaudittrail.append("0");
					}
					else
					{
						sbaudittrail.append((String)correctNull(txt_guntas3[i]));
					}
					sbaudittrail.append(" ").append(measurementtypedesc);
							
				}
				AuditTrial.auditLog(hshValues,"280",appno,sbaudittrail.toString());
//              -------------------- End  Of Audit Trail--------------------
			}
			
			hshpasValues.put("appno", appno);
			hshResult =getcoffeeplantdata(hshpasValues);
		}
		catch (Exception e)
		{
			throw new EJBException("Error in Insert Data " + e.getMessage());
		} 
		finally 
		{
			try 
			{
				if (rs != null) 
				{
					rs.close();
					rs = null;
				}
			} 
			catch (Exception e1) 
			{
				throw new EJBException("Error in closing Connection "+ e1.getMessage());
			}
		}
		return hshResult;
	}
	public HashMap updatecoffeepreviousdata(HashMap hshValues)  
	{
		String strQuery = "";
		HashMap hshQueryValues = new HashMap();
		//HashMap hshQueryValues6 = new HashMap();
		HashMap hshpasValues = new HashMap();
		HashMap hshQuery = new HashMap();
		//HashMap hshQuery5 = new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null;
		String strAction = null;		
		HashMap hshResult = new HashMap();
		HashMap hshQuery4 = new HashMap();
		int intUpdatesize = 0;
		int f = 0;
		String strid = "", strQuery1 = "";
		String appno = correctNull((String) hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") ||  appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("strappno"));
		}
		strAction = correctNull((String) hshValues.get("hidAction"));
			
		try 
		{
			String[] txt_area1 = null;
			String[] txt_area2 = null;
			String[]txt_area3 = null;
			String[]txt_area4 = null;
			String[]txt_grossincome= null;
			String[] txt_maintexp = null;
			String[] txt_netinc = null;
			String[] txt_year = null;
			txt_year= (String[]) hshValues.get("txt_year");
			txt_area1= (String[]) hshValues.get("txt_area1");
			txt_area2 = (String[]) hshValues.get("txt_area2");
			strid = correctNull((String) hshValues.get("hid_sno"));
			txt_area3 = (String[]) hshValues.get("txt_area3");
			txt_area4 = (String[]) hshValues.get("txt_area4");
			txt_grossincome = (String[]) hshValues.get("txt_grossincome");
			txt_maintexp= (String[]) hshValues.get("txt_maintexp");
			txt_netinc = (String[]) hshValues.get("txt_netinc");
			
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshResult.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshResult.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshResult.put("applicantid", rs.getString("demo_appid"));
			}
			if (strAction.equals("delete"))
			{
				hshQuery4 = new HashMap();
				HashMap hshQueryValues4 = new HashMap();
				ArrayList arrValues4 = new ArrayList();
				hshQueryValues4.put("size", "1");
				hshQuery4.put("strQueryId", "per_del_coffeepreviousdata");
				arrValues4.add(appno);
				hshQuery4.put("arrValues", arrValues4);
				hshQueryValues4.put("1", hshQuery4);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues4,"updateData");
			}
			
			if (strAction.equals("insert"))
			{
				HashMap hshQuery3 = new HashMap();
				ArrayList arrValues3 = new ArrayList();
				hshQuery3.put("size", "2");
				hshQuery3.put("strQueryId", "per_del_coffeepreviousdata");
				arrValues3.add(appno);
				hshQuery3.put("arrValues", arrValues3);
				strQuery1 = SQLParser.getSqlQuery("sel_maxid_coffeepreviousdata");
				rs = DBUtils.executeQuery(strQuery1);
				if (rs.next())
				{
					strid = correctNull((String) rs.getString("maxid"));
					f = Integer.parseInt(strid);
				}
				intUpdatesize = 1;

				for (int i = 0; i < txt_area1.length; i++)
				{					
					intUpdatesize = intUpdatesize + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "per_ins_coffeepreviousdata");
					arrValues.add(Integer.toString(f));
					arrValues.add(appno);
					arrValues.add(new Integer(i + 1).toString());
					if (i + 1 == 1) 
					{
						arrValues.add("a1");
					}
					if (i + 1 == 2) 
					{
						arrValues.add("a2");
					}
					if (i + 1 == 3) 
					{
						arrValues.add("a3");
					}
					if (i + 1 == 4) 
					{
						arrValues.add("a4");
					}
					if (correctNull( txt_year[i]).equals("")) 
					{
						arrValues.add("0");
					} 
					else 
					{
						arrValues.add(correctNull(txt_year[i]));
					}
					if (correctNull( txt_area1[i]).equals("")) 
					{
						arrValues.add("0");
					} 
					else 
					{
						arrValues.add(correctNull(txt_area1[i]));
					}
					
					if (correctNull(txt_area2[i]).equals("")) 
					{
						arrValues.add("0");
					}
					else 
					{
						arrValues.add(correctNull(txt_area2[i]));
					}
					
					if (correctNull(txt_area3[i]).equals(""))
					{
						arrValues.add("0");
					} 
					else 
					{
						arrValues.add(correctNull(txt_area3[i]));
					}
					
					if (correctNull(txt_area4[i]).equals(""))
					{
						arrValues.add("0");
					} 
					else 
					{
						arrValues.add(correctNull(txt_area4[i]));
					}
					
					if (correctNull(txt_grossincome[i]).equals(""))
					{
						arrValues.add("0");
					} 
					else
					{
						arrValues.add(correctNull(txt_grossincome[i]));
					}
					if (correctNull(txt_maintexp[i]).equals(""))
					{
						arrValues.add("0");
					} 
					else
					{
						arrValues.add(correctNull(txt_maintexp[i]));
					}
					if (correctNull(txt_netinc[i]).equals(""))
					{
						arrValues.add("0");
					} 
					else
					{
						arrValues.add(correctNull(txt_netinc[i]));
					}
					
					hshQuery.put("arrValues", arrValues);
					f = f + 1;
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);					
				}
				hshQueryValues.put("1", hshQuery3);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			/*------------------Audit Trial Start--------------------------*/
			StringBuilder sbAt = new StringBuilder();
			 for (int i = 0; i < txt_area1.length; i++)
				{					
					
					if (correctNull( txt_year[i]).equals("")) 
					{
						sbAt.append(" ~ Year = ").append("0");
					} 
					else 
					{
						sbAt.append(" ~ Year = ").append(correctNull(txt_year[i]));
					}
					if (correctNull( txt_area1[i]).equals("")) 
					{
						sbAt.append(" ~ Arabica-Parchment = ").append("0");
					} 
					else 
					{
						sbAt.append(" ~ Arabica-Parchment = ").append(correctNull(txt_area1[i]));
						
					}
					
					if (correctNull(txt_area2[i]).equals("")) 
					{
						sbAt.append(" ~ Arabica-Cherry = ").append("0");
					}
					else 
					{
						sbAt.append(" ~ Arabica-Cherry = ").append(correctNull(txt_area2[i]));
						
					}
					
					if (correctNull(txt_area3[i]).equals(""))
					{
						sbAt.append(" ~ Robusta-Parchment = ").append("0");
						
					} 
					else 
					{
						sbAt.append(" ~ Robusta-Parchment = ").append(correctNull(txt_area3[i]));
						
					}
					
					if (correctNull(txt_area4[i]).equals(""))
					{
						sbAt.append(" ~ Robusta-Cherry = ").append("0");
					} 
					else 
					{
						sbAt.append(" ~ Robusta-Cherry = ").append(correctNull(txt_area4[i]));
						
					}
					
					if (correctNull(txt_grossincome[i]).equals(""))
					{
						 
						sbAt.append(" ~ Gross Income(Rs.) = ").append("0");
						
					} 
					else
					{
						sbAt.append(" ~ Gross Income(Rs.) = ").append(correctNull(txt_grossincome[i]));
						
					}
					if (correctNull(txt_maintexp[i]).equals(""))
					{
						 
						sbAt.append(" ~ Maintenance Expenses(Rs.) = ").append("0");
						
					} 
					else
					{
						sbAt.append(" ~ Maintenance Expenses(Rs.) = ").append(correctNull(txt_maintexp[i]));
						
					}
					
					
								
				}
			
      
			AuditTrial.auditLog(hshValues,"1200",appno,sbAt.toString());
			/*------------------Audit Trial End--------------------------*/
			hshpasValues.put("appno", appno);
			hshResult =getcoffeepreviousdata(hshpasValues);
		}
		catch (Exception e)
		{
			throw new EJBException("Error in Insert Data " + e.getMessage());
		} 
		finally 
		{
			try 
			{
				if (rs != null) 
				{
					rs.close();
					rs = null;
				}
			} 
			catch (Exception e1) 
			{
				throw new EJBException("Error in closing Connection "+ e1.getMessage());
			}
		}
		return hshResult;
	}
	public HashMap getcoffeepreviousdata(HashMap hshValues)  
	{
		String strQuery = "";
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord = new HashMap();
		double netarea1=0.00;double netarea2=0.00;
		double netarea3=0.00;double netarea4=0.00;
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;
		String appno = correctNull((String) hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") ||  appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("strappno"));
		}
        String PageType=correctNull((String)hshValues.get("hidpagetype1"));
        if(PageType.equalsIgnoreCase(""))
        {
        	 PageType=correctNull((String)hshValues.get("hidpagetype"));
        }
        
		try 
		{
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshRecord.put("applicantid", rs.getString("demo_appid"));
			}
										 
			strQuery = SQLParser.getSqlQuery("per_get_coffeepreviousdata^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arryCol = new ArrayList();
				arryCol.add(rs.getString("seqno"));
				arryCol.add(appno);
				arryCol.add(rs.getString("sno"));
				arryCol.add(rs.getString("coffee_type"));
				arryCol.add(rs.getString("coffee_year"));
				arryCol.add(rs.getString("coffee_area1"));
				netarea1=  netarea1+Double.parseDouble((Helper.correctDouble((String)rs.getString("coffee_area1"))));
				arryCol.add(rs.getString("coffee_area2"));
				netarea2=  netarea2+Double.parseDouble((Helper.correctDouble((String)rs.getString("coffee_area2"))));
				arryCol.add(rs.getString("coffee_area3"));
				netarea3=  netarea3+ Double.parseDouble((Helper.correctDouble((String)rs.getString("coffee_area3"))));
				arryCol.add(rs.getString("coffee_area4"));
				netarea4=  netarea4+ Double.parseDouble((Helper.correctDouble((String)rs.getString("coffee_area4"))));
				arryCol.add(rs.getString("coffee_grossincome"));
				arryCol.add(rs.getString("coffee_mainexp"));
				arryCol.add(rs.getString("coffee_netinc"));
				arryRow.add(arryCol);
			}
			strQuery = SQLParser.getSqlQuery("agrlandmeasurement^"+appno);
			rs1= DBUtils.executeQuery(strQuery);
			if(rs1.next())
					{
			hshRecord.put("land_measurement",correctNull(rs1.getString("land_measurement")));
					}
			hshRecord.put("appno", appno);
			hshRecord.put("arryRow", arryRow);
			hshRecord.put("PageType", PageType);
			hshRecord.put("netarea1", Helper.formatDoubleValue(netarea1));
			hshRecord.put("netarea2", Helper.formatDoubleValue(netarea2));
			hshRecord.put("netarea3", Helper.formatDoubleValue(netarea3));
			hshRecord.put("netarea4", Helper.formatDoubleValue(netarea4));
			
		} 
		catch (Exception ce)
		{
			throw new EJBException("Error in closing getData" + ce.getMessage());
		}
		finally 
		{
			try
			{
				if (rs != null) 
				{
					rs.close();
					rs = null;
				}
				if (rs1 != null) 
				{
					rs1.close();
					rs1 = null;
				}
				
			}
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshRecord;
	}
	public HashMap getcoffeeinterdata(HashMap hshValues)  
	{
		String strQuery = "";
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord = new HashMap();
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;
		String appno = correctNull((String) hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") ||  appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("strappno"));
		}
          String PageType=correctNull((String)hshValues.get("hidpagetype1"));
        if(PageType.equalsIgnoreCase(""))
        {
        	 PageType=correctNull((String)hshValues.get("hidpagetype"));
        }
        
		try 
		{
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshRecord.put("applicantid", rs.getString("demo_appid"));
			}
										 
			strQuery = SQLParser.getSqlQuery("per_get_coffeeinterdata^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arryCol = new ArrayList();
				arryCol.add(rs.getString("seqno"));
				arryCol.add(appno);
				arryCol.add(rs.getString("sno"));
				arryCol.add(rs.getString("coffee_cropname"));
				arryCol.add(rs.getString("coffee_area"));
				arryCol.add(rs.getString("coffee_guntas"));
				arryCol.add(rs.getString("coffee_yield"));
				arryCol.add(rs.getString("coffee_netinc"));
				arryRow.add(arryCol);
			}
			strQuery = SQLParser.getSqlQuery("agrlandmeasurement^"+appno);
			rs1= DBUtils.executeQuery(strQuery);
			if(rs1.next())
					{
			hshRecord.put("land_measurement",correctNull(rs1.getString("land_measurement")));
					}
			hshRecord.put("appno", appno);
			hshRecord.put("arryRow", arryRow);
			hshRecord.put("PageType", PageType);
			
		} 
		catch (Exception ce)
		{
			throw new EJBException("Error in closing getData" + ce.getMessage());
		}
		finally 
		{
			try
			{
				if (rs != null) 
				{
					rs.close();
					rs = null;
				}
				if (rs1 != null) 
				{
					rs1.close();
					rs1 = null;
				}
				
			}
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshRecord;
	}

	public HashMap updatecoffeeinterdata(HashMap hshValues)  
	{
		String strQuery = "";
		HashMap hshQueryValues = new HashMap();
		HashMap hshpasValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null;
		String strAction = null;		
		HashMap hshResult = new HashMap();
		HashMap hshQuery4 = new HashMap();
		int intUpdatesize = 0;
		int f = 0;
		String strid = "", strQuery1 = "";
		String appno = correctNull((String) hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") ||  appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("strappno"));
		}
		strAction = correctNull((String) hshValues.get("hidAction"));
			
		try 
		{
			String[] txt_cropname = null;
			String[]txt_guntas = null;
			String[] txt_area = null;
			String[] txt_yield = null;
			String[] txt_netinc = null;
			txt_cropname= (String[]) hshValues.get("txt_cropname");
			txt_area= (String[]) hshValues.get("txt_area");
			txt_guntas= (String[]) hshValues.get("txt_guntas");
			strid = correctNull((String) hshValues.get("hid_sno"));
			txt_yield = (String[]) hshValues.get("txt_yield");
			txt_netinc = (String[]) hshValues.get("txt_netinc");
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshResult.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshResult.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshResult.put("applicantid", rs.getString("demo_appid"));
			}
			if (strAction.equals("delete"))
			{
				hshQuery4 = new HashMap();
				HashMap hshQueryValues4 = new HashMap();
				ArrayList arrValues4 = new ArrayList();
				hshQueryValues4.put("size", "1");
				hshQuery4.put("strQueryId", "per_del_coffeeinterdata");
				arrValues4.add(appno);
				hshQuery4.put("arrValues", arrValues4);
				hshQueryValues4.put("1", hshQuery4);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues4,"updateData");
			}
			
			if (strAction.equals("insert"))
			{
				HashMap hshQuery3 = new HashMap();
				ArrayList arrValues3 = new ArrayList();
				hshQuery3.put("size", "2");
				hshQuery3.put("strQueryId", "per_del_coffeeinterdata");
				arrValues3.add(appno);
				hshQuery3.put("arrValues", arrValues3);
				strQuery1 = SQLParser.getSqlQuery("sel_maxid_coffeeinterdata");
				rs = DBUtils.executeQuery(strQuery1);
				if (rs.next())
				{
					strid = correctNull((String) rs.getString("maxid"));
					f = Integer.parseInt(strid);
				}
				intUpdatesize = 1;

				for (int i = 0; i < txt_area.length; i++)
				{					
					intUpdatesize = intUpdatesize + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "per_ins_coffeeinterdata");
					arrValues.add(Integer.toString(f));
					arrValues.add(appno);
					arrValues.add(new Integer(i + 1).toString());
					arrValues.add(correctNull(txt_cropname[i]));
					if (correctNull( txt_area[i]).equals("")) 
					{
						arrValues.add("0");
					} 
					else 
					{
						arrValues.add(correctNull(txt_area[i]));
					}
					if (correctNull(txt_guntas[i]).equals(""))
					{
						arrValues.add("0");
					} 
					else 
					{
						arrValues.add(correctNull(txt_guntas[i]));
					}
					
					
					if (correctNull(txt_yield[i]).equals(""))
					{
						arrValues.add("0.00");
					} 
					else 
					{
						arrValues.add(correctNull(txt_yield[i]));
					}
					if (correctNull(txt_netinc[i]).equals(""))
					{
						arrValues.add("0.00");
					} 
					else
					{
						arrValues.add(correctNull(txt_netinc[i]));
					}
					
					hshQuery.put("arrValues", arrValues);
					f = f + 1;
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);					
				}
				hshQueryValues.put("1", hshQuery3);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			/*------------------Audit Trial Start--------------------------*/
			StringBuilder sbAt = new StringBuilder();
			for (int j = 0; j < txt_area.length; j++) 
			{
				sbAt.append("~Crop Name = ").append(correctNull(txt_cropname[j]));
				if (correctNull( txt_area[j]).equals("")) 
				{
					sbAt.append(" ~ Area-Acres = ").append("0");
				} 
				else 
				{
					sbAt.append(" ~ Area-Acres = ").append(correctNull(txt_area[j]));
				}
				if (correctNull(txt_guntas[j]).equals(""))
				{
					sbAt.append(" ~ Area-Cents/Guntas = ").append("0");
					
				} 
				else 
				{
					sbAt.append(" ~ Area-Cents/Guntas = ").append(correctNull(txt_guntas[j]));
				}
				
				
				if (correctNull(txt_yield[j]).equals(""))
				{
					sbAt.append(" ~ Average Yield(Kgs) = ").append("0.00");
					
				} 
				else 
				{
					sbAt.append(" ~ Average Yield(Kgs) = ").append(correctNull(txt_yield[j]));
					
				}
				if (correctNull(txt_netinc[j]).equals(""))
				{
					sbAt.append(" ~ Net Income Realised(Rs.) = ").append("0.00");
					
				} 
				else
				{
					sbAt.append(" ~ Net Income Realised(Rs.) = " ).append(correctNull(txt_netinc[j]));
				}
				
						
			}
      
			AuditTrial.auditLog(hshValues,"1100",appno,sbAt.toString());
			/*------------------Audit Trial End--------------------------*/
			hshpasValues.put("appno", appno);
			hshResult =getcoffeeinterdata(hshpasValues);
		}
		catch (Exception e)
		{
			throw new EJBException("Error in Insert Data " + e.getMessage());
		} 
		finally 
		{
			try 
			{
				if (rs != null) 
				{
					rs.close();
					rs = null;
				}
			} 
			catch (Exception e1) 
			{
				throw new EJBException("Error in closing Connection "+ e1.getMessage());
			}
		}
		return hshResult;
	}
	public void updatecoffeesourcesdata(HashMap hshValues) 
	{
		String appno=correctNull((String)hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") ||  appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("strappno"));
		}
		//String appno1=correctNull((String)hshValues.get("appno1"));
		String strappno=correctNull((String)hshValues.get("strappno"));
		String strAction=null;String strAction1=null;
		strAction = correctNull((String) hshValues.get("hidAction"));
		strAction1 = correctNull((String) hshValues.get("hidAction1"));
		HashMap hshQueryValues = new HashMap();
		HashMap hshQueryValues1 = new HashMap();
		ArrayList arrValues3 = new ArrayList();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();	
		HashMap hshQuery3 = new HashMap();
		String[] txt_village= null;
		String[] txt_taluk = null;
		String[] txt_syno = null;
		String[] txt_acres1 = null;
		String[] txt_guntas1 = null;
		String[] txt_cropname= null;
		String[] txt_acres2 = null;
		String[] txt_guntas2 = null;
		String[] txt_yield = null;
		String[] txt_grossinc = null;
		String[] txt_netinc = null;
		String[] txt_source = null;
		String[] txt_netincome = null;
		String txt_familyexp=null;
		StringBuilder sbaudittrail=null;
		String measurementtype=null;
		String measurementval=null;
		/*if(appno.equalsIgnoreCase(""))
		{
			//appno=appno1;
		}*/
		if(appno.equalsIgnoreCase(""))
		{
			appno=strappno;
		}		
		ResultSet rs = null;
		int intUpdatesize = 0;	int intUpdatesize1 = 0;
		try
		{		
			sbaudittrail=new StringBuilder();
			
			//village
			
			txt_village = (String[]) hshValues.get("txt_village");
			txt_taluk= (String[])hshValues.get("txt_taluk");
			txt_syno= (String[])hshValues.get("txt_syno");
			txt_acres1 = (String[])hshValues.get("txt_acres1");
			txt_guntas1= (String[])hshValues.get("txt_guntas1");
			//crop
			
			txt_cropname = (String[])hshValues.get("txt_cropname");
			txt_acres2 = (String[])hshValues.get("txt_acres2");
			txt_guntas2= (String[])hshValues.get("txt_guntas2");
			txt_yield= (String[])hshValues.get("txt_yield");
			txt_grossinc = (String[])hshValues.get("txt_grossinc");
			txt_netinc = (String[])hshValues.get("txt_netinc");
			txt_familyexp = correctNull((String)hshValues.get("txt_familyexp"));
			txt_source= (String[])hshValues.get("txt_source");
			txt_netincome = (String[])hshValues.get("txt_netincome");
			//village
			if (strAction.equals("delete"))
			{
				 hshQuery3 = new HashMap();
				 arrValues3 = new ArrayList();
				hshQuery3.put("strQueryId", "del_coffee_sourcesloans");
				arrValues3.add(appno);
				hshQuery3.put("arrValues", arrValues3);
				hshQueryValues1.put("1", hshQuery3);
				hshQueryValues1.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
			}
			if (strAction1.equals("delete1"))
			{
				 hshQuery3 = new HashMap();
				 arrValues3 = new ArrayList();
				hshQuery3.put("strQueryId", "del_coffee_sourcesloansexp");
				arrValues3.add(appno);
				hshQuery3.put("arrValues", arrValues3);
				hshQueryValues1.put("1", hshQuery3);
				hshQueryValues1.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
			}
			
			if (strAction.equals("insert"))
			{
			
			 hshQuery3 = new HashMap();
			 arrValues3 = new ArrayList();
			hshQuery3.put("size", "1");
			hshQuery3.put("strQueryId", "del_coffee_sourcesloans");
			arrValues3.add(appno);
			hshQuery3.put("arrValues", arrValues3);
			hshQueryValues1.put("1", hshQuery3);
			hshQueryValues1.put("size", "1");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
			
			intUpdatesize = 1;
			for (int i = 0; i < txt_village.length; i++)
			{
				intUpdatesize = intUpdatesize + 1;
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_coffee_sourcesloans");
				arrValues.add(appno);
				if(txt_village[i].equalsIgnoreCase(""))
				{
					txt_village[i] = "";
				}
				arrValues.add(txt_village[i]);
				if(txt_taluk[i].equalsIgnoreCase(""))
				{
					txt_taluk[i] = "";
				}
				arrValues.add(txt_taluk[i]);
			
				if(txt_syno[i].equalsIgnoreCase(""))
				{
					txt_syno[i] = "";
				}
				arrValues.add(txt_syno[i]);
				if(txt_acres1[i].equalsIgnoreCase(""))
				{
					txt_acres1[i] = "";
				}				
				arrValues.add(txt_acres1[i]);
				if(txt_guntas1[i].equalsIgnoreCase(""))
				{
					txt_guntas1[i] = "";
				}
				arrValues.add(txt_guntas1[i]);
				arrValues.add("");
				arrValues.add("0");
				arrValues.add("0");
				arrValues.add("0.00");
				arrValues.add("0.00");
				arrValues.add("0.00");
				hshQuery.put("arrValues", arrValues);	
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			
			//cropname
			
			intUpdatesize = 1;
			for (int i = 0; i < txt_cropname.length; i++)
			{
				intUpdatesize = intUpdatesize + 1;
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_coffee_sourcesloans");
				arrValues.add(appno);
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("0");
				arrValues.add("0");
				if(txt_cropname[i].equalsIgnoreCase(""))
				{
					txt_cropname[i] = "";
				}
				arrValues.add(txt_cropname[i]);
				if(txt_acres2[i].equalsIgnoreCase(""))
				{
					txt_acres2[i] = "";
				}
				arrValues.add(txt_acres2[i]);
				if(txt_guntas2[i].equalsIgnoreCase(""))
				{
					txt_guntas2[i] = "";
				}
				arrValues.add(txt_guntas2[i]);
				if(txt_yield[i].equalsIgnoreCase(""))
				{
					txt_yield[i] = "";
				}
				arrValues.add(txt_yield[i]);
				if(txt_grossinc[i].equalsIgnoreCase(""))
				{
					txt_grossinc[i] = "";
				}
				arrValues.add(txt_grossinc[i]);
				if(txt_netinc[i].equalsIgnoreCase(""))
				{
					txt_netinc[i] = "";
				}
				arrValues.add(txt_netinc[i]);
				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			
			}
			//---------------------
			if (strAction1.equals("insert1"))
			{
			
			 hshQuery3 = new HashMap();
			arrValues3 = new ArrayList();
			hshQuery3.put("size", "1");
			hshQuery3.put("strQueryId", "del_coffee_sourcesloansexp");
			arrValues3.add(appno);
			hshQuery3.put("arrValues", arrValues3);
			hshQueryValues1.put("1", hshQuery3);
			hshQueryValues1.put("size", "1");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
			
			intUpdatesize1 = 1;
			for (int j = 0; j<txt_source.length; j++)
			{
				intUpdatesize1 = intUpdatesize1 + 1;
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_coffee_sourcesloansexp");
				arrValues.add(appno);
				if(txt_source[j].equalsIgnoreCase(""))
				{
					txt_source[j] = "";
				}
				arrValues.add(txt_source[j]);
				if(txt_netincome[j].equalsIgnoreCase(""))
				{
					txt_netincome[j] = "";
				}
				arrValues.add(txt_netincome[j]);
				arrValues.add("0.00");
				hshQuery.put("arrValues", arrValues);	
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			
			//cropname
			
			intUpdatesize1 = 1;
			for (int j = 0; j < 1; j++)
			{
				intUpdatesize1 = intUpdatesize1 + 1;
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_coffee_sourcesloansexp");
				arrValues.add(appno);
				arrValues.add("0");
				arrValues.add("0.00");
				if(txt_familyexp.equalsIgnoreCase(""))
				{
					txt_familyexp = "";
				}
				arrValues.add(txt_familyexp);
				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			
			}
			
//          -----------------------Start Of Audit Trail------------------------
			measurementtype = Helper.correctNull((String)hshValues.get("land_measurement"));
			if(measurementtype.equalsIgnoreCase("c"))
			{
				measurementval=" Cents ";
			}
			else
			if(measurementtype.equalsIgnoreCase("c"))
			{
				measurementval=" Guntas ";
			}
			for (int i = 0; i < txt_village.length; i++)
			{
				sbaudittrail.append("~Village= ").append(txt_village[i])
							.append("~Taluk= ").append(txt_taluk[i])
							.append("~Survey No.= ").append(txt_syno[i])
							.append("~Extent= ").append(txt_acres1[i]).append(" Acres ").append(txt_guntas1[i])
							.append(measurementval);
			}
	
			//cropname
			for (int i = 0; i < txt_cropname.length; i++)
			{
				sbaudittrail.append("~Type Of Crop= ").append(txt_cropname[i])
							.append("~Area= ").append(txt_acres2[i]).append(" Acres ").append(txt_guntas2[i])
							.append(measurementval)
							.append("~Average Yield= ").append(txt_yield[i])
							.append("~Gross Income(Rs.)= ").append(txt_grossinc[i])
							.append("~Net Income(Rs.)= ").append(txt_netinc[i]);
			}
			for (int j = 0; j<txt_source.length; j++)
			{
				sbaudittrail.append("~Sources= ").append(txt_source[j])
							.append("~Net Income(Rs.)= ").append(txt_netincome[j]);
			}
			sbaudittrail.append("~Family & Household Expenses per Annum(in Rs.)(C)= ").append(txt_familyexp);
			AuditTrial.auditLog(hshValues,"281",appno,sbaudittrail.toString());
//          -----------------------End Of Audit Trail------------------------
		}		
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
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
	
	public  HashMap getcoffeesourcesdata(HashMap hshValues) 
	{
 		ResultSet rs = null;
 		ArrayList arryColprev = new ArrayList();
 		ArrayList arryRowprev = new ArrayList();
 		ArrayList arryColinter = new ArrayList();
 		ArrayList arryRowinter = new ArrayList();
 		ResultSet rs1 = null;ResultSet rs2 = null;
 		String strQuery = "";
 		HashMap hshRecord = new HashMap();
 		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;
		ArrayList arryRow1 = new ArrayList();
		ArrayList arryCol1 = null;
 		String appno = correctNull((String) hshValues.get("appno"));
 		if(appno.equalsIgnoreCase("null") ||  appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("strappno"));
		}
        String PageType=correctNull((String)hshValues.get("hidpagetype1"));
        if(PageType.equalsIgnoreCase(""))
         {
      	 PageType=correctNull((String)hshValues.get("hidpagetype"));
         }
 		try 
		{
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshRecord.put("applicantid", rs.getString("demo_appid"));
			}
										 
			strQuery = SQLParser.getSqlQuery("sel_coffee_sourcesloans^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arryCol = new ArrayList();
				arryCol.add(appno);
				arryCol.add(rs.getString("sno"));
				arryCol.add(rs.getString("coffee_village"));
				arryCol.add(rs.getString("coffee_taluk"));
				arryCol.add(rs.getString("coffee_suyno"));
				arryCol.add(rs.getString("coffee_acres1"));
				arryCol.add(rs.getString("coffee_guntas1"));
				arryCol.add(rs.getString("coffee_cropname"));
				arryCol.add(rs.getString("coffee_acres2"));
				arryCol.add(rs.getString("coffee_guntas2"));
				arryCol.add(rs.getString("coffee_yield"));
				arryCol.add(rs.getString("coffee_grossinc"));
				arryCol.add(rs.getString("coffee_netinc"));
				arryRow.add(arryCol);
			}
			strQuery = SQLParser.getSqlQuery("sel_coffee_sourcesloansexp^" + appno);
			rs2 = DBUtils.executeQuery(strQuery);
			while (rs2.next())
			{
				arryCol1 = new ArrayList();
				arryCol1.add(appno);
				arryCol1.add(rs2.getString("sno"));
				arryCol1.add(rs2.getString("coffee_source"));
				arryCol1.add(rs2.getString("coffee_netincome"));
				arryCol1.add(rs2.getString("coffee_familyexp"));
			
				arryRow1.add(arryCol1);
			}
			strQuery = SQLParser.getSqlQuery("per_get_coffeepreviousdata^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			double coffee_netinc=0.00;
			while (rs.next())
			{
				arryColprev = new ArrayList();
				arryColprev.add(appno);
				coffee_netinc=coffee_netinc+ Double.parseDouble((Helper.correctDouble((String)rs.getString("coffee_netinc"))));
				arryRowprev.add(arryColprev);
			}
			coffee_netinc=coffee_netinc/4;
			strQuery = SQLParser.getSqlQuery("per_get_coffeeinterdata^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			double coffee_internetinc=0.00;
			while (rs.next())
			{
				arryColinter = new ArrayList();
				coffee_internetinc=coffee_internetinc+ Double.parseDouble((Helper.correctDouble((String)rs.getString("coffee_netinc"))));
				arryRowinter.add(arryColinter);
			}
			strQuery = SQLParser.getSqlQuery("agrlandmeasurement^"+appno);
			rs1= DBUtils.executeQuery(strQuery);
			if(rs1.next())
					{
			hshRecord.put("land_measurement",correctNull(rs1.getString("land_measurement")));
					}
			hshRecord.put("appno", appno);
			hshRecord.put("arryRow", arryRow);
			hshRecord.put("arryRow1", arryRow1);
			hshRecord.put("PageType", PageType);
			hshRecord.put("coffee_netinc", Helper.formatDoubleValue(coffee_netinc));
			hshRecord.put("coffee_internetinc", Helper.formatDoubleValue(coffee_internetinc));
			
		} 
		catch(Exception ce)
		{
			throw new EJBException("Error in getcoopsocMasterList "+ce.toString());
		}
		finally 
		{
			try
			{
				if (rs != null) 
				{
					rs.close();
					rs = null;
				}
				if (rs1 != null) 
				{
					rs1.close();
					rs1 = null;
				}
				if (rs2 != null) 
				{
					rs2.close();
					rs2 = null;
				}
			}
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshRecord;
	}		
	//coffee assesment
	public  HashMap getcoffeeassesment(HashMap hshValues) 
	{
		ArrayList arryColval= new ArrayList();
		ArrayList arryRowval = new ArrayList();
		ResultSet rs = null;
		ResultSet rs1 = null;ResultSet rs2 = null;
 		String strQuery = "";
 		HashMap hshRecord = new HashMap();
 		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;
		ArrayList arryRowplant = new ArrayList();
		ArrayList arryColplant = null;
		//ArrayList arryRowcoffeeass = new ArrayList();
		//ArrayList arryColcoffeeass = null;
		
		ArrayList arryRow1 = new ArrayList();
		double netitem=0.00;double netitem1=0.00;
		double netcherry1=0.00;double netcherry2=0.00;double nettotseason=0.00;
		ArrayList arryCol1 = null;
		double netarea1=0.00;double netarea2=0.00;
		double netarea3=0.00;double netarea4=0.00;
 		String appno = correctNull((String) hshValues.get("appno"));
 		if(appno.equalsIgnoreCase("null") ||  appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("strappno"));
		}
        String PageType=correctNull((String)hshValues.get("hidpagetype1"));
        if(PageType.equalsIgnoreCase(""))
         {
        	PageType=correctNull((String)hshValues.get("hidpagetype"));
         }
 		try 
		{
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshRecord.put("applicantid", rs.getString("demo_appid"));
			}
										 
			strQuery = SQLParser.getSqlQuery("per_get_coffeedetails^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arryCol = new ArrayList();
				arryCol.add(appno);
				arryCol.add(rs.getString("sno"));
				arryCol.add(rs.getString("item"));
				netitem=  netitem + Double.parseDouble((Helper.correctDouble((String)rs.getString("item"))));
			    arryCol.add(rs.getString("cherry1"));
				netcherry1=  netcherry1+ Double.parseDouble((Helper.correctDouble((String)rs.getString("cherry1"))));
				arryCol.add(rs.getString("item1"));
				netitem1=  netitem1 + Double.parseDouble((Helper.correctDouble((String)rs.getString("item1"))));
				arryCol.add(rs.getString("cherry2"));
				netcherry2=  netcherry2 + Double.parseDouble((Helper.correctDouble((String)rs.getString("cherry2"))));
				arryCol.add(rs.getString("totseason"));
				nettotseason= nettotseason+ Double.parseDouble((Helper.correctDouble((String)rs.getString("totseason"))));
				
				arryCol.add(rs.getString("item2"));
				arryCol.add(rs.getString("fertilizer"));
				arryCol.add(rs.getString("wage"));
				arryCol.add(rs.getString("other"));
				arryCol.add(rs.getString("total"));
				arryCol.add(rs.getString("area"));
				arryCol.add(rs.getString("cost"));
				arryCol.add(rs.getString("year1"));
				arryCol.add(rs.getString("year2"));
				arryCol.add(rs.getString("acre"));
				
				arryRow.add(arryCol);
			}
			hshRecord.put("netitem", Helper.formatDoubleValue(netitem));
			hshRecord.put("netitem1", Helper.formatDoubleValue(netitem1));
			hshRecord.put("netcherry1", Helper.formatDoubleValue(netcherry1));
			hshRecord.put("netcherry2", Helper.formatDoubleValue(netcherry2));
			hshRecord.put("nettotseason", Helper.formatDoubleValue(nettotseason));
			hshRecord.put("arryRow", arryRow);
		    //coffee prev
		    								 
			strQuery = SQLParser.getSqlQuery("per_get_coffeepreviousdata^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arryCol1 = new ArrayList();
				arryCol1.add(rs.getString("seqno"));
				arryCol1.add(appno);
				arryCol1.add(rs.getString("sno"));
				arryCol1.add(rs.getString("coffee_type"));
				arryCol1.add(rs.getString("coffee_year"));
				arryCol1.add(rs.getString("coffee_area1"));
				netarea1=  netarea1+Double.parseDouble((Helper.correctDouble((String)rs.getString("coffee_area1"))));
				arryCol1.add(rs.getString("coffee_area2"));
				netarea2=  netarea2+Double.parseDouble((Helper.correctDouble((String)rs.getString("coffee_area2"))));
				arryCol1.add(rs.getString("coffee_area3"));
				netarea3=  netarea3+ Double.parseDouble((Helper.correctDouble((String)rs.getString("coffee_area3"))));
				arryCol1.add(rs.getString("coffee_area4"));
				netarea4=  netarea4+ Double.parseDouble((Helper.correctDouble((String)rs.getString("coffee_area4"))));
				arryCol1.add(rs.getString("coffee_grossincome"));
				arryCol1.add(rs.getString("coffee_mainexp"));
				arryCol1.add(rs.getString("coffee_netinc"));
				arryRow1.add(arryCol1);
			}
			
			strQuery = SQLParser.getSqlQuery("agrlandmeasurement^"+appno);
			rs1= DBUtils.executeQuery(strQuery);
			if(rs1.next())
					{
			hshRecord.put("land_measurement",correctNull(rs1.getString("land_measurement")));
					}
			netarea1=netarea1/4;
			netarea2=netarea2/4;
			netarea3=netarea3/4;
			netarea4=netarea4/4;
			hshRecord.put("appno", appno);
			hshRecord.put("arryRow1", arryRow1);
			hshRecord.put("PageType", PageType);
			hshRecord.put("netarea1", Helper.formatDoubleValue(netarea1));
			hshRecord.put("netarea2", Helper.formatDoubleValue(netarea2));
			hshRecord.put("netarea3", Helper.formatDoubleValue(netarea3));
			hshRecord.put("netarea4", Helper.formatDoubleValue(netarea4));
			strQuery = SQLParser.getSqlQuery("per_get_coffeeplantdata^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arryColplant = new ArrayList();
				arryColplant.add(rs.getString("seqno"));
				arryColplant.add(appno);
				arryColplant.add(rs.getString("sno"));
				arryColplant.add(rs.getString("coffee_type"));
				arryColplant.add(rs.getString("coffee_plantarea"));
				arryColplant.add(rs.getString("coffee_plantguntas"));
				arryColplant.add(rs.getString("coffee_bearingarea"));
				arryColplant.add(rs.getString("coffee_bearingguntas"));
				arryColplant.add(rs.getString("coffee_nonbearingarea"));
				arryColplant.add(rs.getString("coffee_nonbearingguntas"));
				arryRowplant.add(arryColplant);
			}
		hshRecord.put("arryRowplant",arryRowplant);
		//namrata
		strQuery = SQLParser.getSqlQuery("per_get_coffeeassesmentdata^" + appno);
		rs2 = DBUtils.executeQuery(strQuery);
		while (rs2.next())
		{
			hshRecord.put("parach_ar_av",correctNull(rs2.getString("parach_ar_av")));
			hshRecord.put("cherry_ar_av",correctNull(rs2.getString("cherry_ar_av")));
			hshRecord.put("parach_rb_av",correctNull(rs2.getString("parach_rb_av")));
			hshRecord.put("cherry_rb_av",correctNull(rs2.getString("cherry_rb_av")));
			hshRecord.put("parach_ar_es",correctNull(rs2.getString("parach_ar_es")));
			hshRecord.put("cherry_ar_es",correctNull(rs2.getString("cherry_ar_es")));
			hshRecord.put("parach_rb_es",correctNull(rs2.getString("parach_rb_es")));
			hshRecord.put("cherry_rb_es",correctNull(rs2.getString("cherry_rb_es")));
			hshRecord.put("bearing_ar_ql",correctNull(rs2.getString("bearing_ar_ql")));
			hshRecord.put("nonbearing_ar_ql",correctNull(rs2.getString("nonbearing_ar_ql")));
			hshRecord.put("bearing_rb_ql",correctNull(rs2.getString("bearing_rb_ql")));
			hshRecord.put("nonbearing_rb_ql",correctNull(rs2.getString("nonbearing_rb_ql")));
			hshRecord.put("bearing_ar_an",correctNull(rs2.getString("bearing_ar_an")));
			hshRecord.put("nonbearing_ar_an",correctNull(rs2.getString("nonbearing_ar_an")));
			hshRecord.put("bearing_rb_an",correctNull(rs2.getString("bearing_rb_an")));
			hshRecord.put("nonbearing_rb_an",correctNull(rs2.getString("nonbearing_rb_an")));
			hshRecord.put("coffee_leastamt",correctNull(rs2.getString("coffee_leastamt")));
			String coffee_loanamount=correctNull(rs2.getString("coffee_loanamount"));
			if(coffee_loanamount.equalsIgnoreCase(""))
			{
				coffee_loanamount="0";	
			}
			else{
				coffee_loanamount=correctNull(rs2.getString("coffee_loanamount"));	
			}
			
			hshRecord.put("coffee_loanamount",coffee_loanamount);
			
					}
		
		String checkData="";
		strQuery = SQLParser.getSqlQuery("sel_coffeevaluenorms");
		rs2 = DBUtils.executeQuery(strQuery);
		while(rs2.next())
		{
			arryColval= new ArrayList();
			arryColval.add(correctNull(rs2.getString("coffee_name")));
			arryColval.add(correctNull(rs2.getString("coffee_type")));
			arryColval.add(correctNull(rs2.getString("coffee_value")));
			arryColval.add(correctNull(rs2.getString("coffee_date")));
			arryRowval.add(arryColval);	
			checkData="true";
		}	
		
		if(!checkData.equals(""))
		{
			hshRecord.put("checkSetUpData",checkData);
		}
		
    	hshRecord.put("arryRowval",arryRowval);
		
		} 
		catch(Exception ce)
		{
			throw new EJBException("Error in getcoopsocMasterList "+ce.toString());
		}
		finally 
		{
			try
			{
				if (rs != null) 
				{
					rs.close();
					rs = null;
				}
				if (rs1 != null) 
				{
					rs1.close();
					rs1 = null;
				}
				if (rs2 != null) 
				{
					rs2.close();
					rs2 = null;
				}
			}
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshRecord;	
	}		
//	inter assesment
	public HashMap getinterassesment(HashMap hshValues)  
	{
		String strQuery = "";
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord = new HashMap();
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;
		double crop_leastamt=0.00;
		String appno = correctNull((String) hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("strappno"));
		}
      
        ArrayList arryRow1 = new ArrayList();
		ArrayList arryCol1 = null;
       String PageType=correctNull((String)hshValues.get("hidpagetype1"));
        if(PageType.equalsIgnoreCase(""))
        {
        	 PageType=correctNull((String)hshValues.get("hidpagetype"));
        }
		try 
		{
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshRecord.put("applicantid", rs.getString("demo_appid"));
			}
			strQuery = SQLParser.getSqlQuery("per_get_coffeeinterdata^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			String str="",str1="",str2="";
			while (rs.next())
			{
				arryCol1 = new ArrayList();
				arryCol1.add(rs.getString("seqno"));
				arryCol1.add(appno);
				arryCol1.add(rs.getString("sno"));
				arryCol1.add(rs.getString("coffee_cropname"));
				//arryCol1.add(rs.getString("coffee_area"));
				 str=correctNull(rs.getString("coffee_area"));
				//arryCol1.add(rs.getString("coffee_guntas"));
				 str1=correctNull(rs.getString("coffee_guntas"));
				 str2=str+"."+str1;
				arryCol1.add(rs.getString("coffee_yield"));
				arryCol1.add(rs.getString("coffee_netinc"));
				arryCol1.add(str2);
				arryRow1.add(arryCol1);
			}
			
			strQuery = SQLParser.getSqlQuery("per_get_interassesment^" + appno);
			rs1 = DBUtils.executeQuery(strQuery);
			while (rs1.next())
			{
				arryCol = new ArrayList();
				arryCol.add(rs1.getString("seqno"));
				arryCol.add(appno);
				arryCol.add(rs1.getString("sno"));
				arryCol.add(rs1.getString("crop_name"));
				arryCol.add(rs1.getString("crop_area"));
				arryCol.add(rs1.getString("crop_finance"));
				arryCol.add(rs1.getString("crop_eligibility"));
				arryCol.add(rs1.getString("crop_loanamt"));
				arryCol.add(rs1.getString("crop_leastamount"));
				crop_leastamt = crop_leastamt + Double.parseDouble((Helper.correctDouble((String)rs1.getString("crop_leastamount"))));
				arryRow.add(arryCol);
			}
			hshRecord.put("appno", appno);
			hshRecord.put("arryRow", arryRow);
			hshRecord.put("arryRow1",arryRow1);
			hshRecord.put("PageType", PageType);
			hshRecord.put("crop_leastamt",Helper.formatDoubleValue(crop_leastamt));
			strQuery = SQLParser.getSqlQuery("agrlandmeasurement^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("land_measurement",correctNull(rs.getString("land_measurement")));
			}
		} 
		catch (Exception ce)
		{
			throw new EJBException("Error in closing getData" + ce.getMessage());
		}
		finally 
		{
			try
			{
				if (rs != null) 
				{
					rs.close();
					rs = null;
				}
				if (rs1 != null)
			    {
					 rs1.close();
			    }
			}
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshRecord;
	}


	public HashMap updateinterassesment(HashMap hshValues)  
	{
		String strQuery = "";
		HashMap hshQueryValues = new HashMap();
		HashMap hshpasValues = new HashMap();
		HashMap hshQuery = new HashMap();
		//HashMap hshQuery5 = new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null;
		String strAction = null;		
		HashMap hshResult = new HashMap();
		HashMap hshQuery4 = new HashMap();
		int intUpdatesize = 0;
		int f = 0;
		String strid = "", strQuery1 = "";
		String appno = correctNull((String) hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("strappno"));
		}
		strAction = correctNull((String) hshValues.get("hidAction"));
				
		try 
		{
			String[] txt_crop = null;
			String[] txt_area = null;
			String[] txt_finance = null;
			String[] txt_amount = null;
			String[] txt_amount1 = null;
			String[] txt_eligibility = null;
			txt_crop = (String[]) hshValues.get("txt_crop");
			txt_area = (String[]) hshValues.get("txt_area");
			txt_finance = (String[]) hshValues.get("txt_finance");
			strid = correctNull((String) hshValues.get("hid_sno"));
			txt_amount = (String[]) hshValues.get("txt_amount");
			txt_amount1= (String[]) hshValues.get("txt_amount1");
			txt_eligibility= (String[]) hshValues.get("txt_eligibility");
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshResult.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshResult.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshResult.put("applicantid", rs.getString("demo_appid"));
			}
			if (strAction.equals("delete"))
			{
				hshQuery4 = new HashMap();
				HashMap hshQueryValues4 = new HashMap();
				ArrayList arrValues4 = new ArrayList();
				hshQueryValues4.put("size", "1");
				hshQuery4.put("strQueryId", "per_del_interassesment");
				arrValues4.add(appno);
				hshQuery4.put("arrValues", arrValues4);
				hshQueryValues4.put("1", hshQuery4);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues4,"updateData");
			}
			
			if (strAction.equals("insert"))
			{
				HashMap hshQuery3 = new HashMap();
				ArrayList arrValues3 = new ArrayList();
				hshQuery3.put("size", "2");
				hshQuery3.put("strQueryId", "per_del_interassesment");
				arrValues3.add(appno);
				hshQuery3.put("arrValues", arrValues3);
				strQuery1 = SQLParser.getSqlQuery("sel_maxid_interassesment");
				rs = DBUtils.executeQuery(strQuery1);
				if (rs.next())
				{
					strid = correctNull((String) rs.getString("maxid"));
					f = Integer.parseInt(strid);
				}
				intUpdatesize = 1;

				for (int i = 0; i < txt_amount.length; i++)
				{					
					intUpdatesize = intUpdatesize + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "per_ins_interassesment");
					arrValues.add(Integer.toString(f));
					arrValues.add(appno);
					arrValues.add(new Integer(i + 1).toString());
					if (correctNull(txt_crop[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_crop[i]));
					}
					if (correctNull(txt_area[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_area[i]));
					}
					if (correctNull(txt_finance[i]).equals(""))
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_finance[i]));
					}
					if (correctNull(txt_eligibility[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_eligibility[i]));
					}
					if (correctNull(txt_amount[i]).equals("")) 
					{
						arrValues.add("");
					}
					else 
					{
						arrValues.add(correctNull(txt_amount[i]));
					}
					
						if (correctNull(txt_amount1[i]).equals("")) 
					{
						arrValues.add("0.00");
					} 
					else 
					{
						arrValues.add(correctNull(txt_amount1[i]));
					}
					hshQuery.put("arrValues", arrValues);
					f = f + 1;
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);					
				}
				hshQueryValues.put("1", hshQuery3);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			/*------------------Audit Trial Start--------------------------*/
			StringBuilder sbAt = new StringBuilder();
			for (int i = 0; i < txt_amount.length; i++)
			{					
				
				if (correctNull(txt_area[i]).equals("")) 
				{
					sbAt.append(" ~ Area in Acre/Cents = ").append("");
				} 
				else 
				{
					sbAt.append(" ~ Area in Acre/Cents = ").append(correctNull(txt_area[i]));
				}
				if (correctNull(txt_finance[i]).equals(""))
				{
					sbAt.append(" ~ Scale of Finance = ").append("");
				} 
				else 
				{
					sbAt.append(" ~ Scale of Finance = ").append(correctNull(txt_finance[i]));
				}
				
				if (correctNull(txt_amount[i]).equals("")) 
				{
					sbAt.append(" ~ Loan Amount Requested(B) = ").append("");
				}
				else 
				{
					sbAt.append(" ~ Loan Amount Requested(B) = ").append(correctNull(txt_amount[i]));
				}
			}
			AuditTrial.auditLog(hshValues,"1400",appno,sbAt.toString());
			/*------------------Audit Trial End--------------------------*/
			hshpasValues.put("appno", appno);
			hshResult = getinterassesment(hshpasValues);
		}
		catch (Exception e)
		{
			throw new EJBException("Error in Insert Data " + e.getMessage());
		} 
		finally 
		{
			try 
			{
				if (rs != null) 
				{
					rs.close();
					rs = null;
				}
			} 
			catch (Exception e1) 
			{
				throw new EJBException("Error in closing Connection "+ e1.getMessage());
			}
		}
		return hshResult;
	}
	//coffee ass
	public void updatecoffeeassesment(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery =  new HashMap();
		ArrayList arrValues=new ArrayList();
		String strAction=correctNull((String)hshValues.get("hidAction"));
		String appno=correctNull((String)hshValues.get("strappno"));
		StringBuilder sbaudittrail=null;
		if(appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("appno"));
		}
		ResultSet rs = null;
		try
		{	
			sbaudittrail=new StringBuilder();
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","per_del_coffeeassesmentdata");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
	            hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				String txt_parachmentarbval=correctNull((String) hshValues.get("txt_parachmentarbval"));
				if(txt_parachmentarbval.equalsIgnoreCase(""))
				{
					txt_parachmentarbval="";
				}
				arrValues.add(txt_parachmentarbval);				
				String txt_cherryarbval=correctNull((String) hshValues.get("txt_cherryarbval"));
				if(txt_cherryarbval.equalsIgnoreCase(""))
				{
					txt_cherryarbval="";
				}
				arrValues.add(txt_cherryarbval);				
				String txt_parachmentrobval=correctNull((String) hshValues.get("txt_parachmentrobval"));
				if(txt_parachmentrobval.equalsIgnoreCase(""))
				{
					txt_parachmentrobval="";
				}
				arrValues.add(txt_parachmentrobval);				
				String txt_cherryrobval=correctNull((String) hshValues.get("txt_cherryrobval"));
				if(txt_cherryrobval.equalsIgnoreCase(""))
				{
					txt_cherryrobval="";
				}
				arrValues.add(txt_cherryrobval);
				//
				String txtparachmentarbval=correctNull((String) hshValues.get("txtparachmentarbval"));
				if(txtparachmentarbval.equalsIgnoreCase(""))
				{
					txtparachmentarbval="";
				}
				arrValues.add(txtparachmentarbval);				
				String txtcherryarbval=correctNull((String) hshValues.get("txtcherryarbval"));
				if(txtcherryarbval.equalsIgnoreCase(""))
				{
					txtcherryarbval="";
				}
				arrValues.add(txtcherryarbval);				
				String txtparachmentrobval=correctNull((String) hshValues.get("txtparachmentrobval"));
				if(txtparachmentrobval.equalsIgnoreCase(""))
				{
					txtparachmentrobval="";
				}
				arrValues.add(txtparachmentrobval);				
				String txtcherryrobval=correctNull((String) hshValues.get("txtcherryrobval"));
				if(txtcherryrobval.equalsIgnoreCase(""))
				{
					txtcherryrobval="";
				}
				arrValues.add(txtcherryrobval);	
				//
				String txt_bearingarbval=correctNull((String) hshValues.get("txt_bearingarbval"));
				if(txt_bearingarbval.equalsIgnoreCase(""))
				{
					txt_bearingarbval="";
				}
				arrValues.add(txt_bearingarbval);	
				String txt_bearingrobval=correctNull((String) hshValues.get("txt_bearingrobval"));
				if(txt_bearingrobval.equalsIgnoreCase(""))
				{
					txt_bearingrobval="";
				}
				arrValues.add(txt_bearingrobval);	
				String txt_nonbearingarbval=correctNull((String) hshValues.get("txt_nonbearingarbval"));
				if(txt_nonbearingarbval.equalsIgnoreCase(""))
				{
					txt_nonbearingarbval="";
				}
				arrValues.add(txt_nonbearingarbval);	
				String txt_nonbearingrobval=correctNull((String) hshValues.get("txt_nonbearingrobval"));
				if(txt_nonbearingrobval.equalsIgnoreCase(""))
				{
					txt_nonbearingrobval="";
				}
				arrValues.add(txt_nonbearingrobval);
				String txt_cost1=correctNull((String) hshValues.get("txt_cost1"));
				if(txt_cost1.equalsIgnoreCase(""))
				{
					txt_cost1="";
				}
				arrValues.add(txt_cost1);	
				String txt_cost2=correctNull((String) hshValues.get("txt_cost2"));
				if(txt_cost2.equalsIgnoreCase(""))
				{
					txt_cost2="";
				}
				arrValues.add(txt_cost2);	
				String txt_cost3=correctNull((String) hshValues.get("txt_cost3"));
				if(txt_cost3.equalsIgnoreCase(""))
				{
					txt_cost3="";
				}
				arrValues.add(txt_cost3);	
				String txt_cost4=correctNull((String) hshValues.get("txt_cost4"));
				if(txt_cost4.equalsIgnoreCase(""))
				{
					txt_cost4="";
				}
				arrValues.add(txt_cost4);	
				String txt_leastamount=correctNull((String) hshValues.get("txt_leastamount"));
				if(txt_leastamount.equalsIgnoreCase(""))
				{
					txt_leastamount="";
				}
				arrValues.add(txt_leastamount);	
				String txt_loanamount=correctNull((String) hshValues.get("txt_loanamount"));
				if(txt_loanamount.equalsIgnoreCase(""))
				{
					txt_loanamount="";
				}
				arrValues.add(txt_loanamount);	
				
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "per_ins_coffeeassesmentdata");
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","per_del_coffeeassesmentdata");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");  
			}
//          ----------------------Start Of Audit Trail--------------------
			sbaudittrail.append("~Arabica Bearing Scale Of Finance= ").append(correctNull((String) hshValues.get("txt_bearingarbval")))
						.append("~Arabica Non-Bearing Scale Of Finance= ").append(correctNull((String) hshValues.get("txt_bearingrobval")))
						.append("~Robusta Bearing Scale Of Finance= ").append(correctNull((String) hshValues.get("txt_nonbearingarbval")))
						.append("~Robusta Non-Bearing Scale Of Finance= ").append(correctNull((String) hshValues.get("txt_nonbearingrobval")))
						.append("~Arabica Bearing Cost Of Cultivation= ").append(correctNull((String) hshValues.get("txt_cost1")))
						.append("~Arabica Non-Bearing Cost Of Cultivation= ").append(correctNull((String) hshValues.get("txt_cost2")))
						.append("~Robusta Bearing Cost Of Cultivation= ").append(correctNull((String) hshValues.get("txt_cost3")))
						.append("~Robusta Non-Bearing Cost Of Cultivation= ").append(correctNull((String) hshValues.get("txt_cost4")))
						.append("~Amount Requested= ").append(correctNull((String) hshValues.get("txt_loanamount")));
			AuditTrial.auditLog(hshValues,"282",appno,sbaudittrail.toString());
//          ---------------------- End  Of Audit Trail--------------------
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
		}
		finally 
		{
			try 
			{
				if (rs != null) 
				{
					rs.close();
					rs = null;
				}
			} 
			catch (Exception e1) 
			{
				throw new EJBException("Error in closing Connection "+ e1.getMessage());
			}
		}
	}
//coffee term loan
	public void updatecoffeetermtechdata(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery =  new HashMap();
		ArrayList arrValues=new ArrayList();
		String strAction=correctNull((String)hshValues.get("hidAction"));
		String appno=correctNull((String)hshValues.get("strappno"));
		if(appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("appno"));
		}
		ResultSet rs = null;
		try
		{			
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues.put("size","2");
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","agr_del_coffeeterm_tech");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
	            hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				arrValues.add(correctNull((String) hshValues.get("txt_estate")));
				arrValues.add(correctNull((String) hshValues.get("txt_location")));
				arrValues.add(correctNull((String) hshValues.get("txt_route")));
				arrValues.add(correctNull((String) hshValues.get("txt_distance")));
				arrValues.add(correctNull((String) hshValues.get("txt_plantationcrop")));
				arrValues.add(correctNull((String) hshValues.get("txt_variety")));
				arrValues.add(correctNull((String) hshValues.get("txt_acres")));
				arrValues.add(correctNull((String) hshValues.get("txt_guntas")));
				arrValues.add(correctNull((String) hshValues.get("txt_annual")));
				String sel_rainfall=correctNull((String) hshValues.get("sel_rainfall"));
				if(sel_rainfall.equalsIgnoreCase(""))
				{
					sel_rainfall="0";
				}
				arrValues.add(sel_rainfall);				
				arrValues.add(correctNull((String) hshValues.get("txt_average")));
				arrValues.add(correctNull((String) hshValues.get("txt_daterainfall")));
				arrValues.add(correctNull((String) hshValues.get("txt_lastyear")));
				arrValues.add(correctNull((String) hshValues.get("txt_irrigation")));
				arrValues.add(correctNull((String) hshValues.get("txr_comments")));
				arrValues.add(correctNull((String) hshValues.get("txr_technical")));
				String sel_sprinkler=correctNull((String) hshValues.get("sel_sprinkler"));
				if(sel_sprinkler.equalsIgnoreCase(""))
				{
					sel_sprinkler="0";
				}
				arrValues.add(sel_sprinkler);
				String sel_powersprayer=correctNull((String) hshValues.get("sel_powersprayer"));
				if(sel_powersprayer.equalsIgnoreCase(""))
				{
					sel_powersprayer="0";
				}
				arrValues.add(sel_powersprayer);
				String sel_pulper=correctNull((String) hshValues.get("sel_pulper"));
				if(sel_pulper.equalsIgnoreCase(""))
				{
					sel_pulper="0";
				}
				arrValues.add(sel_pulper);
				String sel_tractor=correctNull((String) hshValues.get("sel_tractor"));
				if(sel_tractor.equalsIgnoreCase(""))
				{
					sel_tractor="0";
				}
				arrValues.add(sel_tractor);
				String sel_pulp=correctNull((String) hshValues.get("sel_pulp"));
				if(sel_pulp.equalsIgnoreCase(""))
				{
					sel_pulp="0";
				}
				arrValues.add(sel_pulp);
				String sel_drying=correctNull((String) hshValues.get("sel_drying"));
				if(sel_drying.equalsIgnoreCase(""))
				{
					sel_drying="0";
				}
				arrValues.add(sel_drying);
				String sel_drier=correctNull((String) hshValues.get("sel_drier"));
				if(sel_drier.equalsIgnoreCase(""))
				{
					sel_drier="0";
				}
				arrValues.add(sel_drier);
				String sel_farmhouse=correctNull((String) hshValues.get("sel_farmhouse"));
				if(sel_farmhouse.equalsIgnoreCase(""))
				{
					sel_farmhouse="0";
				}
				arrValues.add(sel_farmhouse);
				String sel_staffquarter=correctNull((String) hshValues.get("sel_staffquarter"));
				if(sel_staffquarter.equalsIgnoreCase(""))
				{
					sel_staffquarter="0";
				}
				arrValues.add(sel_staffquarter);
				String sel_officeblog=correctNull((String) hshValues.get("sel_officeblog"));
				if(sel_officeblog.equalsIgnoreCase(""))
				{
					sel_officeblog="0";
				}
				arrValues.add(sel_officeblog);
				
				
				
				
				
				String sel_godown=correctNull((String) hshValues.get("sel_godown"));
				if(sel_godown.equalsIgnoreCase(""))
				{
					sel_godown="0";
				}
				arrValues.add(sel_godown);
				String sel_garage=correctNull((String) hshValues.get("sel_garage"));
				if(sel_garage.equalsIgnoreCase(""))
				{
					sel_garage="0";
				}
				arrValues.add(sel_garage);
				arrValues.add(correctNull((String) hshValues.get("txt_saplingsno")));
				arrValues.add(correctNull((String) hshValues.get("txt_spacings")));
				arrValues.add(correctNull((String) hshValues.get("txt_syno")));
				arrValues.add(correctNull((String) hshValues.get("txt_procgrafts")));
				arrValues.add(correctNull((String) hshValues.get("txt_procinputs")));
				arrValues.add(correctNull((String) hshValues.get("txt_marprod")));
				String sel_teaunit=correctNull((String) hshValues.get("sel_teaunit"));
				if(sel_teaunit.equalsIgnoreCase(""))
				{
					sel_teaunit="0";
				}
				arrValues.add(sel_teaunit);
				String sel_rubberunit=correctNull((String) hshValues.get("sel_rubberunit"));
				if(sel_rubberunit.equalsIgnoreCase(""))
				{
					sel_rubberunit="0";
				}
				arrValues.add(sel_rubberunit);
				
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "agr_ins_coffeeterm_tech");
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues.put("size","1");
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","agr_del_coffeeterm_tech");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");  
			}		
			
			StringBuilder sbAuditTrial=new StringBuilder();
			String land_measurement=Helper.correctNull((String)hshValues.get("land_measurement"));
			if(land_measurement.equalsIgnoreCase("c"))
			{
				land_measurement="Cents";				
			}
			else
			{
				land_measurement="Guntas";
			}
			if (strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update")) {
			sbAuditTrial
			.append("~Name of the Estate = ")
			.append(correctNull((String) hshValues.get("txt_estate")))
			.append("~Location(Zone) = ")
			.append(correctNull((String) hshValues.get("txt_location")))
			.append("~Distance from the branch = ")
			.append(correctNull((String) hshValues.get("txt_distance")))
			.append("~Variety = ")
			.append(correctNull((String) hshValues.get("txt_variety")))
			.append("~No. of Saplings per Acre = ")
			.append(correctNull((String) hshValues.get("txt_saplingsno")))
			.append("~Spacings to be adopted = ")
			.append(correctNull((String) hshValues.get("txt_spacings")))
			.append("~Survey no. in which crops being cultivated / to be cultivated = ")
			.append(correctNull((String) hshValues.get("txt_syno")))
			.append("~Extent of the Land to be brought under development = ")
			.append(correctNull((String) hshValues.get("txt_acres")))
			.append("(Acres)")
			.append(" ")
			.append(correctNull((String) hshValues.get("txt_guntas")))
			.append(" ")
			.append(land_measurement)
			.append("~Rainfall (Annual)= ")
			.append(correctNull((String) hshValues.get("txt_annual")))
			.append(" ")
			.append(correctNull((String) hshValues.get("sel_rainfall_text")))
			.append("~average of = ")
			.append(correctNull((String) hshValues.get("txt_average")))
			.append("(Years)")
			.append("~Till Date(from 1st Jan) = ")
			.append(correctNull((String) hshValues.get("txt_daterainfall")))
			.append(" ")
			.append(correctNull((String) hshValues.get("txt_mm")))
			.append("~Corresponding Last year = ")
			.append(correctNull((String) hshValues.get("txt_lastyear")))
			.append("~Irrigation Facilities(Specify)  = ")
			.append(correctNull((String) hshValues.get("txt_irrigation")))
			.append("~Procurring grafts/ Planting Material = ")
			.append(correctNull((String) hshValues.get("txt_procgrafts")))
			.append("~Procuring inputs / such as farm yard manure/fertilizer/insecticide = ")
			.append(correctNull((String) hshValues.get("txt_procinputs")))
			.append("~Marketing of Produce = ")
			.append(correctNull((String) hshValues.get("txt_marprod")))
			.append("~Infrastructure Available ^")
			.append("~Sprinkler Unit = ")
			.append(ApplicantParams.getApplicantParams("InfrastructureAvailable",correctNull((String) hshValues.get("sel_sprinkler"))))
			.append("~Power Sprayer = ")
			.append(ApplicantParams.getApplicantParams("InfrastructureAvailable",correctNull((String) hshValues.get("sel_powersprayer"))))
			.append("~Pulper Machinery = ")
			.append(ApplicantParams.getApplicantParams("InfrastructureAvailable",correctNull((String) hshValues.get("sel_pulper"))))
			.append("~Tractor/Power Triller = ")
			.append(ApplicantParams.getApplicantParams("InfrastructureAvailable",correctNull((String) hshValues.get("sel_tractor"))))
			.append("~Smoke/Pulp House = ")
			.append(ApplicantParams.getApplicantParams("InfrastructureAvailable",correctNull((String) hshValues.get("sel_pulp"))))
			.append("~Drying Yard = ")
			.append(ApplicantParams.getApplicantParams("InfrastructureAvailable",correctNull((String) hshValues.get("sel_drying"))))
			.append("~Cardamom Drier/Kiln = ")
			.append(ApplicantParams.getApplicantParams("InfrastructureAvailable",correctNull((String) hshValues.get("sel_drier"))))
			.append("~Bungalow/Farm House = ")
			.append(ApplicantParams.getApplicantParams("InfrastructureAvailable",correctNull((String) hshValues.get("sel_farmhouse"))))
			.append("~Staff Quarter = ")
			.append(ApplicantParams.getApplicantParams("InfrastructureAvailable",correctNull((String) hshValues.get("sel_staffquarter"))))
			.append("~Office Block = ")
			.append(ApplicantParams.getApplicantParams("InfrastructureAvailable",correctNull((String) hshValues.get("sel_officeblog"))))
			.append("~Godown = ")
			.append(ApplicantParams.getApplicantParams("InfrastructureAvailable",correctNull((String) hshValues.get("sel_godown"))))
			.append("~Garage = ")
			.append(ApplicantParams.getApplicantParams("InfrastructureAvailable",correctNull((String) hshValues.get("sel_garage"))))
			.append("~Tea manufacturing unit = ")
			.append(ApplicantParams.getApplicantParams("InfrastructureAvailable",correctNull((String) hshValues.get("sel_teaunit"))))
			.append("~Rubber pressing/Sheeting unit = ")
			.append(ApplicantParams.getApplicantParams("InfrastructureAvailable",correctNull((String) hshValues.get("sel_rubberunit"))));
				
			if(correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("Y"))
			{
				hshValues.put("strAction", "update");
			}
				
			}
			AuditTrial.auditLog(hshValues,"268",appno,sbAuditTrial.toString());
			
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
		}
		finally 
		{
			try 
			{
				if (rs != null) 
				{
					rs.close();
					rs = null;
				}
			} 
			catch (Exception e1) 
			{
				throw new EJBException("Error in closing Connection "+ e1.getMessage());
			}
		}
	}

	public  HashMap getcoffeetermtechdata(HashMap hshValues) 
	{		
		String strQuery="";
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		HashMap hshResult = new HashMap();	
		String recordflag="N";
		try
		{
			java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
			jtn.setMaximumFractionDigits(2);
			jtn.setMinimumFractionDigits(2);
			jtn.setGroupingUsed(false);
			String appno=correctNull((String)hshValues.get("strappno"));
			if(appno.equalsIgnoreCase(""))
			{
				appno = correctNull((String)hshValues.get("appno"));
			}
			strQuery = SQLParser.getSqlQuery("agrlandmeasurement^"+appno);
			rs2 = DBUtils.executeQuery(strQuery);
			if(rs2.next())
			{
				hshResult.put("land_measurement",correctNull(rs2.getString("land_measurement")));
			}
			strQuery = SQLParser.getSqlQuery("agr_sel_coffeeterm_tech^"+appno);			
			rs2 =DBUtils.executeQuery(strQuery);
			while(rs2.next())
			{
				recordflag="Y";
				hshResult.put("txt_estate",correctNull(rs2.getString("agr_estate")));
				hshResult.put("txt_location",correctNull(rs2.getString("agr_location")));
				hshResult.put("txt_route",correctNull(rs2.getString("agr_route")));
				hshResult.put("txt_distance",correctNull(rs2.getString("agr_distance")));
				hshResult.put("txt_plantationcrop",correctNull(rs2.getString("agr_plantationcrop")));
				hshResult.put("txt_variety",correctNull(rs2.getString("agr_variety")));
				hshResult.put("txt_acres",correctNull(rs2.getString("agr_acres")));
				hshResult.put("txt_guntas",correctNull(rs2.getString("agr_guntas")));
				hshResult.put("txt_annual",correctNull(rs2.getString("agr_annual")));
				hshResult.put("sel_rainfall",correctNull(rs2.getString("agr_rainfall")));
				hshResult.put("txt_average",correctNull(rs2.getString("agr_average")));
				hshResult.put("txt_daterainfall",correctNull(rs2.getString("agr_daterainfall")));
				hshResult.put("txt_lastyear",correctNull(rs2.getString("agr_lastyear")));
				hshResult.put("txt_irrigation",correctNull(rs2.getString("agr_irrigation")));
				hshResult.put("txr_comments",correctNull(rs2.getString("agr_comments")));
				hshResult.put("txr_technical",correctNull(rs2.getString("agr_technical")));
				hshResult.put("sel_sprinkler",correctNull(rs2.getString("agr_sprinkler")));
				hshResult.put("sel_powersprayer",correctNull(rs2.getString("agr_powersprayer")));
				hshResult.put("sel_pulper",correctNull(rs2.getString("agr_pulper")));
				hshResult.put("sel_tractor",correctNull(rs2.getString("agr_tractor")));
				hshResult.put("sel_pulp",correctNull(rs2.getString("agr_pulp")));
				hshResult.put("sel_teaunit",correctNull(rs2.getString("agr_teaunit")));
				hshResult.put("sel_rubberunit",correctNull(rs2.getString("agr_rubberunit")));
			
				hshResult.put("sel_drying",correctNull(rs2.getString("agr_drying")));
				hshResult.put("sel_drier",correctNull(rs2.getString("agr_drier")));
				hshResult.put("sel_farmhouse",correctNull(rs2.getString("agr_farmhouse")));
				hshResult.put("sel_staffquarter",correctNull(rs2.getString("agr_staffquarter")));
				hshResult.put("sel_officeblog",correctNull(rs2.getString("agr_officeblog")));
				hshResult.put("sel_godown",correctNull(rs2.getString("agr_godown")));
				hshResult.put("sel_garage",correctNull(rs2.getString("agr_garage")));
				hshResult.put("txt_saplingsno",correctNull(rs2.getString("agr_saplingsno")));
				hshResult.put("txt_spacings",correctNull(rs2.getString("agr_spacings")));
				hshResult.put("txt_syno",correctNull(rs2.getString("agr_syno")));
				hshResult.put("txt_procgrafts",correctNull(rs2.getString("agr_procgrafts")));
				hshResult.put("txt_procinputs",correctNull(rs2.getString("agr_procinputs")));
				hshResult.put("txt_marprod",correctNull(rs2.getString("agr_marprod")));
				hshResult.put("recordflag",recordflag);
				
			}		    	
			return hshResult;
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData "+ce.toString());
		}
		finally 
		{
			try 
			{
				if (rs1 != null) 
				{
					rs1.close();
				}
				if (rs2 != null) 
				{
					rs2.close();
				}
			} 
			catch (Exception e1) 
			{
				throw new EJBException("Error in closing Connection "+ e1.getMessage());
			}
		}
	}
//ckls scheme
//	public HashMap getcklsdata(HashMap hshValues)  
//	{
//		String strQuery = "";
//		ResultSet rs = null;
//		ResultSet rs1 = null;ResultSet rs2 = null;
//		HashMap hshRecord = new HashMap();
//		ArrayList arryRow = new ArrayList();
//		ArrayList arryCol = null;
//		ArrayList arryRow1 = new ArrayList();
//		ArrayList arryCol1 = null;
//		String prd_type = correctNull((String)hshValues.get("strProductType"));
//		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
//		{
//			prd_type = correctNull((String)hshValues.get("prd_type"));
//		}
//		String appno=correctNull((String)hshValues.get("appno"));
//		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
//		{
//			appno = correctNull((String)hshValues.get("strappno"));
//		}
//		String txt_date="";
//        String PageType=correctNull((String)hshValues.get("hidpagetype1"));
//        if(PageType.equalsIgnoreCase(""))
//        {
//        	 PageType=correctNull((String)hshValues.get("hidpagetype"));
//        }
//        
//		try 
//		{
//			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
//			rs = DBUtils.executeQuery(strQuery);
//			if (rs.next()) 
//			{
//				hshRecord.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
//				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
//				hshRecord.put("applicantid", rs.getString("demo_appid"));
//			}
//			strQuery = SQLParser.getSqlQuery("agr_sel_cklsdata^"+appno+"^"+prd_type);
//			rs1 = DBUtils.executeQuery(strQuery);
//			if (rs1.next()) 
//			{
//				hshRecord.put("sel_farmer", Helper.correctDoubleQuote(correctNull(rs1.getString("ckls_farmer"))));
//				hshRecord.put("txt_years", Helper.correctDoubleQuote(correctNull(rs1.getString("ckls_years"))));
//				hshRecord.put("txt_days", Helper.correctDoubleQuote(correctNull(rs1.getString("ckls_days"))));
//				hshRecord.put("sel_concession", Helper.correctDoubleQuote(correctNull(rs1.getString("ckls_concession"))));
//				hshRecord.put("sel_tenant", Helper.correctDoubleQuote(correctNull(rs1.getString("ckls_tenant"))));
//				hshRecord.put("sel_liability", Helper.correctDoubleQuote(correctNull(rs1.getString("ckls_liability"))));
//				hshRecord.put("txt_namebank", Helper.correctDoubleQuote(correctNull(rs1.getString("ckls_namebank"))));
//				hshRecord.put("sel_value", Helper.correctDoubleQuote(correctNull(rs1.getString("ckls_value"))));
//				hshRecord.put("txt_specify", Helper.correctDoubleQuote(correctNull(rs1.getString("ckls_specify"))));
//				hshRecord.put("txt_amountpacre", Helper.correctDoubleQuote(correctNull(rs1.getString("ckls_amountpacre"))));
//				hshRecord.put("txt_netincome", Helper.correctDoubleQuote(correctNull(rs1.getString("ckls_netincome"))));
//				hshRecord.put("txt_date1", Helper.correctDoubleQuote(correctNull(rs1.getString("ckls_date1"))));
//				hshRecord.put("txt_loanamount", Helper.correctDoubleQuote(correctNull(rs1.getString("ckls_loanamount"))));
//				hshRecord.put("txt_total_area", Helper.correctDoubleQuote(correctNull(rs1.getString("ckls_total_area"))));
//				hshRecord.put("txt_totvalue", Helper.correctDoubleQuote(correctNull(rs1.getString("ckls_totvalue"))));
//				
//				hshRecord.put("txt_agriincome", Helper.correctDoubleQuote(correctNull(rs1.getString("ckls_agriincome"))));
//				hshRecord.put("txt_specifyagri", Helper.correctDoubleQuote(correctNull(rs1.getString("ckls_specifyagri"))));
//				hshRecord.put("txt_specifyamount", Helper.correctDoubleQuote(correctNull(rs1.getString("ckls_specifyamount"))));
//			}
//			
//				 if (rs1 != null)
//				    {
//					rs1.close();
//				    }
//				 			
//				
//						 							 
//			strQuery = SQLParser.getSqlQuery("agr_sel_cklslimit^" + appno+"^"+prd_type);
//			rs = DBUtils.executeQuery(strQuery);
//			while (rs.next())
//			{
//				arryCol = new ArrayList();
//				arryCol.add(rs.getString("seqno"));
//				arryCol.add(appno);
//				arryCol.add(rs.getString("sno"));
//				arryCol.add(rs.getString("ckls_limit"));
//				arryCol.add(rs.getString("ckls_amount"));
//				txt_date=correctNull((String)rs.getString("ckls_date"));
//				if(txt_date.equalsIgnoreCase("01/01/1900"))
//				{
//					arryCol.add("");
//				}
//				else
//				{
//					arryCol.add(txt_date);
//				}
//				arryCol.add(rs.getString("ckls_balance"));
//				arryCol.add(rs.getString("ckls_comments"));
//				arryRow.add(arryCol);
//			   }
//				strQuery = SQLParser.getSqlQuery("agr_sel_cklsland^" + appno+"^"+prd_type);
//				rs = DBUtils.executeQuery(strQuery);
//				while (rs.next())
//				{
//					arryCol1 = new ArrayList();
//					arryCol1.add(rs.getString("seqno"));
//					arryCol1.add(appno);
//					arryCol1.add(rs.getString("sno"));
//					arryCol1.add(rs.getString("ckls_location"));
//					arryCol1.add(rs.getString("ckls_surveyno"));
//					arryCol1.add(rs.getString("ckls_acres"));
//					arryCol1.add(rs.getString("ckls_guntas"));
//					arryCol1.add(rs.getString("ckls_value"));
//					arryRow1.add(arryCol1);
//			}
//				strQuery = SQLParser.getSqlQuery("agrlandmeasurement^"+appno);
//				rs = DBUtils.executeQuery(strQuery);
//				if(rs.next())
//				{
//					hshRecord.put("land_measurement",correctNull(rs.getString("land_measurement")));
//				}
////				---------------------------------------------------------------------------------------------------------
//				rs=DBUtils.executeLAPSQuery("agrlandholdings_owned^"+appno);
//				ArrayList vecData1=new ArrayList();
//				int land_acreage=0,land_acreage1=0;
//				while(rs.next())
//				{
//					ArrayList vecVal = new ArrayList();
//				    vecVal.add(correctNull(rs.getString("land_appno")));
//					vecVal.add(correctNull(rs.getString("land_apptype")));
//					vecVal.add(correctNull(rs.getString("land_id")));
//					vecVal.add(correctNull(rs.getString("land_nature")));
//					vecVal.add(correctNull(rs.getString("land_acreage")));
//					land_acreage =land_acreage + Integer.parseInt((correctNull((String)rs.getString("land_acreage"))));
//					vecVal.add(correctNull(rs.getString("land_village")));
//					vecVal.add(correctNull(rs.getString("land_taluk")));
//					vecVal.add(correctNull(rs.getString("land_district")));
//					vecVal.add(correctNull(rs.getString("land_survey")));
//					vecVal.add(correctNull(rs.getString("land_revenue")));
//					vecVal.add(correctNull(rs.getString("land_value")));
//					vecVal.add(correctNull(rs.getString("land_owned_leased")));
//					vecVal.add(correctNull(rs.getString("land_leaseperiod")));
//					vecVal.add(correctNull(rs.getString("land_rent_repay")));
//					vecVal.add(correctNull(rs.getString("land_irrigated")));
//					vecVal.add(correctNull(rs.getString("land_which_irrigated")));
//					vecVal.add(correctNull(rs.getString("land_source")));
//					vecVal.add(correctNull(rs.getString("land_encumbrance")));
//					vecVal.add(correctNull(rs.getString("land_Encroached_Land")));
//					vecVal.add(correctNull(rs.getString("land_farmdistance")));
//					vecVal.add(correctNull(rs.getString("land_housedistance")));
//					vecVal.add(correctNull(rs.getString("land_landlorddetails")));
//					vecVal.add(correctNull(rs.getString("land_acreage1")));
//					land_acreage1 =land_acreage1 + Integer.parseInt((correctNull((String)rs.getString("land_acreage1"))));
//					vecVal.add(correctNull(rs.getString("land_mortgage")));
//					vecVal.add(correctNull(rs.getString("land_security")));
//					vecData1.add(vecVal);							
//				}	
//			hshRecord.put("vecData1",vecData1);
//			hshRecord.put("appno", appno);
//			hshRecord.put("arryRow", arryRow);
//			hshRecord.put("arryRow1", arryRow1);
//			hshRecord.put("PageType", PageType);
//			hshRecord.put("land_acreage",Integer.toString(land_acreage));
//			hshRecord.put("land_acreage1",Integer.toString(land_acreage1));
//		} 
//		catch (Exception ce)
//		{
//			throw new EJBException("Error in closing getData" + ce.getMessage());
//		}
//		finally 
//		{
//			try
//			{
//				if (rs != null) 
//				{
//					rs.close();
//					rs = null;
//				}
//				 if (rs1 != null)
//				    {
//					rs1.close();
//				    }
//				 if (rs2 != null)
//				    {
//					rs2.close();
//				    }
//			}
//			catch (Exception e)
//			{
//				throw new EJBException("Error in closing Connection "+ e.getMessage());
//			}
//		}
//		return hshRecord;
//	}

//	public HashMap updatecklsdata(HashMap hshValues)  
//	{
//		String strQuery = "";
//		String prd_type = correctNull((String)hshValues.get("strProductType"));
//		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
//		{
//			prd_type = correctNull((String)hshValues.get("prd_type"));
//		}
//		HashMap hshQueryValues = new HashMap();
//		//HashMap hshQueryValues6 = new HashMap();
//		HashMap hshpasValues = new HashMap();
//		HashMap hshQuery = new HashMap();
//		HashMap hshQuery5 = new HashMap();
//		ArrayList arrValues = new ArrayList();
//		ResultSet rs = null;
//		String strAction = null;		
//		String strAction1 = null;	
//		String strAction2 = null;	
//		HashMap hshResult = new HashMap();
//		HashMap hshQuery4 = new HashMap();
//		int intUpdatesize = 0;
//		int f = 0;
//		String strid = "", strQuery1 = "";
//		String appno=correctNull((String)hshValues.get("appno"));
//		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
//		{
//			appno = correctNull((String)hshValues.get("strappno"));
//		}
//		strAction = correctNull((String) hshValues.get("hidAction"));
//		strAction1 = correctNull((String) hshValues.get("hidAction1"));
//		strAction2= correctNull((String) hshValues.get("hidAction2"));
//		String sel_farmer= correctNull((String) hshValues.get("sel_farmer"));
//		if(sel_farmer.equalsIgnoreCase(""))
//		{
//			sel_farmer="0";	
//		}
//		else
//		{
//			sel_farmer= correctNull((String) hshValues.get("sel_farmer"));
//		}
//		String txt_years= correctNull((String) hshValues.get("txt_years"));
//		String txt_days = correctNull((String) hshValues.get("txt_days"));
//	    String sel_concession= correctNull((String) hshValues.get("sel_concession"));
//		if(sel_concession.equalsIgnoreCase(""))
//		{
//			sel_concession="0";	
//		}
//		else
//		{
//			sel_concession= correctNull((String) hshValues.get("sel_concession"));
//		}
//		String sel_tenant= correctNull((String) hshValues.get("sel_tenant"));
//		if(sel_tenant.equalsIgnoreCase(""))
//		{
//			sel_tenant="0";	
//		}
//		else
//		{
//			sel_tenant= correctNull((String) hshValues.get("sel_tenant"));
//		}
//		String sel_liability= correctNull((String) hshValues.get("sel_liability"));
//		if(sel_liability.equalsIgnoreCase(""))
//		{
//			sel_liability="0";	
//		}
//		else
//		{
//			sel_liability= correctNull((String) hshValues.get("sel_liability"));
//		}
//		String txt_namebank = correctNull((String) hshValues.get("txt_namebank"));
//		String sel_value= correctNull((String) hshValues.get("sel_value"));
//		if(sel_value.equalsIgnoreCase(""))
//		{
//			sel_value="0";	
//		}
//		else
//		{
//			sel_value= correctNull((String) hshValues.get("sel_value"));
//		}   
//		String txt_specify = correctNull((String) hshValues.get("txt_specify"));
//	    String txt_amountpacre = correctNull((String) hshValues.get("txt_amountpacre"));
//		String txt_netincome = correctNull((String) hshValues.get("txt_netincome"));
//		String txt_date1= correctNull((String) hshValues.get("txt_date1"));
//		if(txt_date1.equalsIgnoreCase(""))
//		{
//			txt_date1="01/01/1900";	
//		}
//		else
//		{
//			txt_date1= correctNull((String) hshValues.get("txt_date1"));
//		}
//		String txt_loanamount = correctNull((String) hshValues.get("txt_loanamount"));
//		String txt_total_area = correctNull((String) hshValues.get("txt_total_area"));
//		String txt_totvalue = correctNull((String) hshValues.get("txt_totvalue"));
//		String txt_agriincome= correctNull((String) hshValues.get("txt_agriincome"));
//		if(txt_agriincome.equalsIgnoreCase(""))
//		{
//			txt_agriincome="0";	
//		}
//		else
//		{
//			txt_agriincome= correctNull((String) hshValues.get("txt_agriincome"));
//		}
//		String txt_specifyagri= correctNull((String) hshValues.get("txt_specifyagri"));
//		if(txt_specifyagri.equalsIgnoreCase(""))
//		{
//			txt_specifyagri="";	
//		}
//		else
//		{
//			txt_specifyagri= correctNull((String) hshValues.get("txt_specifyagri"));
//		}
//		String txt_specifyamount= correctNull((String) hshValues.get("txt_specifyamount"));
//		if(txt_specifyamount.equalsIgnoreCase(""))
//		{
//			txt_specifyamount="0";	
//		}
//		else
//		{
//			txt_specifyamount= correctNull((String) hshValues.get("txt_specifyamount"));
//		}
//		try 
//		{
//			String[] txt_limit = null;
//			String[]txt_amount = null;
//			String[] txt_date = null;
//			String[] txt_balance = null;
//			String[]txt_comments = null;
//			String[] txt_location = null;
//			String[]txt_surveyno= null;
//			String[] txt_area= null;
//			String[] txt_guntas = null;
//			String[] txt_value = null;
//			txt_limit= (String[]) hshValues.get("txt_limit");
//			txt_amount= (String[]) hshValues.get("txt_amount");
//			txt_date = (String[]) hshValues.get("txt_date");
//			strid = correctNull((String) hshValues.get("hid_sno"));
//			txt_balance= (String[]) hshValues.get("txt_balance");
//			txt_comments = (String[]) hshValues.get("txt_comments");
//			txt_location= (String[]) hshValues.get("txt_location");
//			txt_surveyno= (String[]) hshValues.get("txt_surveyno");
//			txt_area= (String[]) hshValues.get("txt_area");
//			txt_guntas= (String[]) hshValues.get("txt_guntas");
//			txt_value= (String[]) hshValues.get("txt_value");
//			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
//			rs = DBUtils.executeQuery(strQuery);
//			if (rs.next()) 
//			{
//				hshResult.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
//				hshResult.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
//				hshResult.put("applicantid", rs.getString("demo_appid"));
//			}
//			if (strAction.equals("delete"))
//			{
//				hshQuery4 = new HashMap();
//				HashMap hshQueryValues4 = new HashMap();
//				ArrayList arrValues4 = new ArrayList();
//				hshQueryValues4.put("size", "1");
//				hshQuery4.put("strQueryId", "agr_del_cklsdata");
//				arrValues4.add(appno);
//				arrValues4.add(prd_type);
//				hshQuery4.put("arrValues", arrValues4);
//				hshQueryValues4.put("1", hshQuery4);
//				EJBInvoker.executeStateLess("dataaccess", hshQueryValues4,"updateData");
//			}
//			if (strAction1.equals("delete1"))
//			{
//				hshQuery5 = new HashMap();
//				HashMap hshQueryValues5 = new HashMap();
//				ArrayList arrValues5 = new ArrayList();
//				hshQueryValues5.put("size", "1");
//				hshQuery5.put("strQueryId", "agr_del_cklslimit");
//				arrValues5.add(appno);
//				arrValues5.add(prd_type);
//				hshQuery5.put("arrValues", arrValues5);
//				hshQueryValues5.put("1", hshQuery5);
//				EJBInvoker.executeStateLess("dataaccess", hshQueryValues5,"updateData");
//			}
//			if (strAction1.equals("delete2"))
//			{
//				hshQuery5 = new HashMap();
//				HashMap hshQueryValues5 = new HashMap();
//				ArrayList arrValues5 = new ArrayList();
//				hshQueryValues5.put("size", "1");
//				hshQuery5.put("strQueryId", "agr_del_cklsland");
//				arrValues5.add(appno);
//				arrValues5.add(prd_type);
//				hshQuery5.put("arrValues", arrValues5);
//				hshQueryValues5.put("1", hshQuery5);
//				EJBInvoker.executeStateLess("dataaccess", hshQueryValues5,"updateData");
//			}
//			if(strAction.equalsIgnoreCase("insert"))
//			{
//				hshQuery= new HashMap();
//				arrValues = new ArrayList();
//				hshQuery.put("size", "2");
//				hshQuery.put("strQueryId", "agr_del_cklsdata");
//				arrValues.add(appno);
//				arrValues.add(prd_type);
//				hshQuery.put("arrValues",arrValues);	
//				hshQueryValues.put("1",hshQuery);
//				hshQuery= new HashMap();
//				arrValues = new ArrayList();
//				arrValues.add(appno);
//				arrValues.add(sel_farmer);
//				arrValues.add(txt_years);
//				arrValues.add(txt_days);
//				arrValues.add(sel_concession);
//				arrValues.add(sel_tenant);
//				arrValues.add(sel_liability);
//				arrValues.add(txt_namebank);
//				arrValues.add(sel_value);
//				arrValues.add(txt_specify);
//				arrValues.add(txt_amountpacre);
//				arrValues.add(txt_netincome);
//				arrValues.add(txt_date1);
//				arrValues.add(txt_loanamount);
//				arrValues.add(txt_total_area);
//				arrValues.add(prd_type);
//				if(prd_type.equalsIgnoreCase("aS"))
//				{
//				arrValues.add("");
//				
//				}
//				if(prd_type.equalsIgnoreCase("aK"))
//				{
//					arrValues.add(txt_totvalue);
//					
//				}
//				arrValues.add(txt_agriincome);
//				arrValues.add(txt_specifyagri);
//				arrValues.add(txt_specifyamount);
//				hshQueryValues.put("size", "2");
//				hshQuery.put("arrValues", arrValues);
//				hshQuery.put("strQueryId", "agr_ins_cklsdata");
//				hshQueryValues.put("2", hshQuery);
//				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
//			}
//			if(strAction1.equalsIgnoreCase("insert1"))
//			{
//				HashMap hshQuery3 = new HashMap();
//				ArrayList arrValues3 = new ArrayList();
//				hshQuery3.put("size", "2");
//				hshQuery3.put("strQueryId", "agr_del_cklslimit");
//				arrValues3.add(appno);
//				arrValues3.add(prd_type);
//				hshQuery3.put("arrValues", arrValues3);
//				strQuery1 = SQLParser.getSqlQuery("sel_maxid_cklslimit");
//				rs = DBUtils.executeQuery(strQuery1);
//				if (rs.next())
//				{
//					strid = correctNull((String) rs.getString("maxid"));
//					f = Integer.parseInt(strid);
//				}
//				intUpdatesize = 1;
//
//				for (int i = 0; i < txt_limit.length; i++)
//				{					
//					intUpdatesize = intUpdatesize + 1;
//					hshQuery = new HashMap();
//					arrValues = new ArrayList();
//					hshQuery.put("strQueryId", "agr_ins_cklslimit");
//					arrValues.add(Integer.toString(f));
//					arrValues.add(appno);
//					arrValues.add(new Integer(i + 1).toString());
//								
//					if (correctNull( txt_limit[i]).equals("")) 
//					{
//						arrValues.add("");
//					} 
//					else 
//					{
//						arrValues.add(correctNull(txt_limit[i]));
//					}
//					if (correctNull(txt_amount[i]).equals(""))
//					{
//						arrValues.add("");
//					} 
//					else 
//					{
//						arrValues.add(correctNull(txt_amount[i]));
//					}
//					if (correctNull(txt_date[i]).equals("")) 
//					{
//						arrValues.add("01/01/1900");
//					}
//					else 
//					{
//						arrValues.add(correctNull(txt_date[i]));
//					}
//					if (correctNull(txt_balance[i]).equals(""))
//					{
//						arrValues.add("");
//					} 
//					else
//					{
//						arrValues.add(correctNull(txt_balance[i]));
//					}
//					if (correctNull(txt_comments[i]).equals(""))
//					{
//						arrValues.add("");
//					} 
//					else 
//					{
//						arrValues.add(correctNull(txt_comments[i]));
//					}
//					arrValues.add(prd_type);
//				
//					hshQuery.put("arrValues", arrValues);
//					f = f + 1;
//					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);					
//				}
//				hshQueryValues.put("1", hshQuery3);
//				hshQueryValues.put("size", Integer.toString(intUpdatesize));
//				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
//			}
//			ArrayList arrValues1 = new ArrayList();
//			if (strAction2.equals("insert2"))
//			{
//				HashMap hshQuery3 = new HashMap();
//				ArrayList arrValues3 = new ArrayList();
//				hshQuery3.put("size", "2");
//				hshQuery3.put("strQueryId", "agr_del_cklsland");
//				arrValues3.add(appno);
//				arrValues3.add(prd_type);
//				hshQuery3.put("arrValues", arrValues3);
//				strQuery1 = SQLParser.getSqlQuery("sel_maxid_cklsland");
//				rs = DBUtils.executeQuery(strQuery1);
//				if (rs.next())
//				{
//					strid = correctNull((String) rs.getString("maxid"));
//					f = Integer.parseInt(strid);
//				}
//				intUpdatesize = 1;
//				
//				for (int i = 0; i < txt_location.length; i++)
//				{					
//					intUpdatesize = intUpdatesize + 1;
//					hshQuery = new HashMap();
//					arrValues1 = new ArrayList();
//					hshQuery.put("strQueryId", "agr_ins_cklsland");
//					arrValues1.add(Integer.toString(f));
//					arrValues1.add(appno);
//					arrValues1.add(new Integer(i + 1).toString());
//										
//					if (correctNull( txt_location[i]).equals("")) 
//					{
//						arrValues1.add("");
//					} 
//					else 
//					{
//						arrValues1.add(correctNull(txt_location[i]));
//					}
//					if (correctNull(txt_surveyno[i]).equals(""))
//					{
//						arrValues1.add("");
//					} 
//					else 
//					{
//						arrValues1.add(correctNull(txt_surveyno[i]));
//					}
//					if (correctNull(txt_area[i]).equals("")) 
//					{
//						arrValues1.add("0");
//					}
//					else 
//					{
//						arrValues1.add(correctNull(txt_area[i]));
//					}
//					if (correctNull(txt_guntas[i]).equals(""))
//					{
//						arrValues1.add("0");
//					} 
//					else
//					{
//						arrValues1.add(correctNull(txt_guntas[i]));
//					}
//					if(prd_type.equalsIgnoreCase("aS"))
//					{
//					arrValues1.add("");
//					}
//					if(prd_type.equalsIgnoreCase("aK"))
//					{
//					arrValues1.add(correctNull(txt_value[i]));
//					}
//					arrValues1.add(prd_type);
//				
//					hshQuery.put("arrValues", arrValues1);
//					f = f + 1;
//					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);					
//				}
//				hshQueryValues.put("1", hshQuery3);
//				hshQueryValues.put("size", Integer.toString(intUpdatesize));
//				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
//			}
//			hshpasValues.put("prd_type", prd_type);
//			hshpasValues.put("appno", appno);
//			hshResult = getcklsdata(hshpasValues);
//		}
//		
//		catch (Exception e)
//		{
//			throw new EJBException("Error in Insert Data " + e.getMessage());
//		} 
//		finally 
//		{
//			try 
//			{
//				if (rs != null) 
//				{
//					rs.close();
//					rs = null;
//				}
//			} 
//			catch (Exception e1) 
//			{
//				throw new EJBException("Error in closing Connection "+ e1.getMessage());
//			}
//		}
//		return hshResult;
//	}
//	public HashMap getcklseligibilitydata(HashMap hshValues)  
//	{
//		String strQuery = "";
//		ResultSet rs = null;
//		ResultSet rs1 = null;ResultSet rs2 = null;
//		HashMap hshRecord = new HashMap();
//		ArrayList arryRow = new ArrayList();
//		ArrayList arryCol = null;
//		//ArrayList arryRow1 = new ArrayList();
//		//ArrayList arryCol1 = null;
//		String appno=correctNull((String)hshValues.get("appno"));
//		String prd_type = correctNull((String)hshValues.get("strProductType"));
//		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
//		{
//			prd_type = correctNull((String)hshValues.get("prd_type"));
//		}
//		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
//		{
//			appno = correctNull((String)hshValues.get("strappno"));
//		}
//		String txt_date="";
//        String PageType=correctNull((String)hshValues.get("hidpagetype1"));
//        if(PageType.equalsIgnoreCase(""))
//        {
//        	 PageType=correctNull((String)hshValues.get("hidpagetype"));
//        }
//        
//		try 
//		{
//			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
//			rs = DBUtils.executeQuery(strQuery);
//			if (rs.next()) 
//			{
//				hshRecord.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
//				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
//				hshRecord.put("applicantid", rs.getString("demo_appid"));
//			}
//			strQuery = SQLParser.getSqlQuery("agr_sel_cklsdata^"+appno+"^"+prd_type);
//			rs1 = DBUtils.executeQuery(strQuery);
//			if (rs1.next()) 
//			{
//				hshRecord.put("sel_farmer", Helper.correctDoubleQuote(correctNull(rs1.getString("ckls_farmer"))));
//				hshRecord.put("txt_years", Helper.correctDoubleQuote(correctNull(rs1.getString("ckls_years"))));
//				hshRecord.put("txt_days", Helper.correctDoubleQuote(correctNull(rs1.getString("ckls_days"))));
//				hshRecord.put("sel_concession", Helper.correctDoubleQuote(correctNull(rs1.getString("ckls_concession"))));
//				hshRecord.put("sel_tenant", Helper.correctDoubleQuote(correctNull(rs1.getString("ckls_tenant"))));
//				hshRecord.put("sel_liability", Helper.correctDoubleQuote(correctNull(rs1.getString("ckls_liability"))));
//				hshRecord.put("txt_namebank", Helper.correctDoubleQuote(correctNull(rs1.getString("ckls_namebank"))));
//				hshRecord.put("sel_value", Helper.correctDoubleQuote(correctNull(rs1.getString("ckls_value"))));
//				hshRecord.put("txt_specify", Helper.correctDoubleQuote(correctNull(rs1.getString("ckls_specify"))));
//				hshRecord.put("txt_amountpacre", Helper.correctDoubleQuote(correctNull(rs1.getString("ckls_amountpacre"))));
//				hshRecord.put("txt_netincome", Helper.correctDoubleQuote(correctNull(rs1.getString("ckls_netincome"))));
//				hshRecord.put("txt_date1", Helper.correctDoubleQuote(correctNull(rs1.getString("ckls_date1"))));
//				hshRecord.put("txt_loanamount", Helper.correctDoubleQuote(correctNull(rs1.getString("ckls_loanamount"))));
//				hshRecord.put("txt_total_area", Helper.correctDoubleQuote(correctNull(rs1.getString("ckls_total_area"))));
//				hshRecord.put("txt_totvalue", Helper.correctDoubleQuote(correctNull(rs1.getString("ckls_totvalue"))));
//			}
//			
//				 if (rs1 != null)
//				    {
//					rs1.close();
//				    }
//				 			
//				
//						 							 
//			strQuery = SQLParser.getSqlQuery("agr_sel_cklslimit^" + appno+"^"+prd_type);
//			rs = DBUtils.executeQuery(strQuery);
//			while (rs.next())
//			{
//				arryCol = new ArrayList();
//				arryCol.add(rs.getString("seqno"));
//				arryCol.add(appno);
//				arryCol.add(rs.getString("sno"));
//				arryCol.add(rs.getString("ckls_limit"));
//				arryCol.add(rs.getString("ckls_amount"));
//				txt_date=correctNull((String)rs.getString("ckls_date"));
//				if(txt_date.equalsIgnoreCase("01/01/1900"))
//				{
//					arryCol.add("");
//				}
//				else
//				{
//					arryCol.add(txt_date);
//				}
//				arryCol.add(rs.getString("ckls_balance"));
//				arryCol.add(rs.getString("ckls_comments"));
//				arryRow.add(arryCol);
//			   }
//				
//				strQuery = SQLParser.getSqlQuery("agrlandmeasurement^"+appno);
//				rs = DBUtils.executeQuery(strQuery);
//				if(rs.next())
//				{
//					hshRecord.put("land_measurement",correctNull(rs.getString("land_measurement")));
//				}
//				strQuery = SQLParser.getSqlQuery("agr_sel_cklseligibilitydata^"+appno+"^"+prd_type);
//				rs = DBUtils.executeQuery(strQuery);
//				if(rs.next())
//				{
//					hshRecord.put("txt_times",correctNull(rs.getString("ckls_times")));
//				}
//				/*strQuery = SQLParser.getSqlQuery("agr_sel_bullockrepay^"+appno+ "^" +prd_type);			
//				rs2 =DBUtils.executeQuery(strQuery);
//				while(rs2.next())
//				{
//					hshRecord.put("txt_roi",correctNull(rs2.getString("bullock_roi")));
//					hshRecord.put("txt_holiday",correctNull(rs2.getString("bullock_holiday")));
//					hshRecord.put("sel_payment",correctNull(rs2.getString("bullock_payment")));
//					hshRecord.put("txt_installment",correctNull(rs2.getString("bullock_installment")));
//					hshRecord.put("txt_date",correctNull(rs2.getString("bullock_date")));
//					hshRecord.put("txt_lastinstallment",correctNull(rs2.getString("bullock_lastinstallment")));
//				}*/
////				---------------------------------------------------------------------------------------------------------
//			hshRecord.put("appno", appno);
//			hshRecord.put("arryRow", arryRow);
//			hshRecord.put("PageType", PageType);
//		
//		} 
//		catch (Exception ce)
//		{
//			throw new EJBException("Error in closing getData" + ce.getMessage());
//		}
//		finally 
//		{
//			try
//			{
//				if (rs != null) 
//				{
//					rs.close();
//					rs = null;
//				}
//				 if (rs1 != null)
//				    {
//					rs1.close();
//				    }
//				 if (rs2 != null)
//				    {
//					rs2.close();
//				    }
//			}
//			catch (Exception e)
//			{
//				throw new EJBException("Error in closing Connection "+ e.getMessage());
//			}
//		}
//		return hshRecord;
//	}
//	public void updatecklseligibilitydata(HashMap hshValues) 
//	{
//		HashMap hshQueryValues = new HashMap();
//		HashMap hshQuery =  new HashMap();
//		ArrayList arrValues=new ArrayList();
//		String strAction=correctNull((String)hshValues.get("hidAction"));
//		String strAction1=correctNull((String)hshValues.get("hidAction1"));
//		String appno=correctNull((String)hshValues.get("strappno"));
//		String prd_type = correctNull((String)hshValues.get("strProductType"));
//		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
//		{
//			prd_type = correctNull((String)hshValues.get("prd_type"));
//		}
//		String txt_roi ="", txt_holiday="",sel_payment="",txt_installment="",txt_date="";
//		String txt_lastinstallment="";
//		
//		if(appno.equalsIgnoreCase(""))
//		{
//			appno = correctNull((String)hshValues.get("appno"));
//		}
//		ResultSet rs = null;
//		try
//		{			
//			if(strAction.equalsIgnoreCase("insert"))
//			{
//				hshQueryValues.put("size","2");
//				hshQuery.put("strQueryId","agr_del_cklseligibilitydata");
//				arrValues.add(appno);
//				arrValues.add(prd_type);
//				hshQuery.put("arrValues",arrValues);
//				hshQueryValues.put("1",hshQuery);
//	            hshQuery = new HashMap();
//				arrValues = new ArrayList();
//				arrValues.add(appno);
//				arrValues.add(correctNull((String) hshValues.get("txt_totallandval")));
//				arrValues.add(correctNull((String) hshValues.get("txt_times")));
//				arrValues.add(correctNull((String) hshValues.get("txt_totalnetincome")));
//				arrValues.add(correctNull((String) hshValues.get("txt_leastamount")));
//				arrValues.add(prd_type);
//				hshQueryValues.put("size", "2");
//				hshQuery.put("arrValues", arrValues);
//				hshQuery.put("strQueryId", "agr_ins_cklseligibilitydata");
//				hshQueryValues.put("2", hshQuery);
//				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
//			}
//			if(strAction.equalsIgnoreCase("delete"))
//			{
//				hshQueryValues.put("size","1");
//				hshQuery.put("strQueryId","agr_del_cklseligibilitydata");
//				arrValues.add(appno);
//				arrValues.add(prd_type);
//				hshQuery.put("arrValues",arrValues);
//				hshQueryValues.put("1",hshQuery);
//				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");  
//			}	
//			  ArrayList arrValues1 = new ArrayList();
//             if(strAction1.equalsIgnoreCase("insert1"))
//				
//			   {
//				hshQueryValues.put("size","2");
//				hshQuery.put("strQueryId","agr_del_bullockrepay");
//				arrValues1.add(appno);
//				arrValues1.add(prd_type);
//				hshQuery.put("arrValues",arrValues1);
//				hshQueryValues.put("1",hshQuery);
//	            hshQuery = new HashMap();
//				arrValues1 = new ArrayList();
//				arrValues1.add(appno);
//				txt_roi= correctNull((String)hshValues.get("txt_roi"));
//				txt_holiday= correctNull((String)hshValues.get("txt_holiday"));
//				sel_payment= correctNull((String)hshValues.get("sel_payment"));
//				txt_installment = correctNull((String)hshValues.get("txt_installment"));
//				txt_date = correctNull((String)hshValues.get("txt_insdate"));
//				txt_lastinstallment= correctNull((String)hshValues.get("txt_lastinstallment"));
//				if(txt_roi.equalsIgnoreCase(""))
//				{	
//					txt_roi="0";
//				}
//				arrValues1.add(txt_roi);
//				
//				if(txt_holiday.equalsIgnoreCase(""))
//				{	
//					txt_holiday="0";
//				}
//				arrValues1.add(txt_holiday);
//				
//				if(sel_payment.equalsIgnoreCase(""))
//				{	
//					sel_payment ="1";
//				}
//				arrValues1.add(sel_payment);
//									
//				if(txt_installment.equalsIgnoreCase(""))
//				{	
//					txt_installment="0.00";
//				}
//				arrValues1.add(txt_installment);
//				
//				if(txt_date.equalsIgnoreCase(""))
//				{	
//					txt_date ="01/01/1900";
//				}
//				arrValues1.add(txt_date);
//				if(txt_lastinstallment.equalsIgnoreCase(""))
//				{	
//					txt_lastinstallment ="0.00";
//				}
//				arrValues1.add(txt_lastinstallment);		
//				arrValues1.add(prd_type);
//				arrValues1.add("");
//				hshQueryValues.put("size", "2");
//				hshQuery.put("arrValues", arrValues1);
//				hshQuery.put("strQueryId", "agr_ins_bullockrepay");
//				hshQueryValues.put("2", hshQuery);
//				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
//			}
//		}
//		catch(Exception ce)
//		{
//			throw new EJBException("inside update"+ce.toString());
//		}
//		finally 
//		{
//			try
//			{
//				if (rs != null) 
//				{
//					rs.close();
//				}
//				 
//			}
//			catch (Exception e)
//			{
//				throw new EJBException("Error in closing Connection "+ e.getMessage());
//			}
//		}
//	}
//coffee economics
	public HashMap getcoffeeeconomicsdata(HashMap hshValues)  
	{
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;
		String appno = correctNull((String) hshValues.get("strappno"));
		if(appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("appno"));
		}
		String PageType = correctNull((String)hshValues.get("hidpagetype"));
		try 
		{
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshRecord.put("applicantid", rs.getString("demo_appid"));
			}
			strQuery = SQLParser.getSqlQuery("per_get_coffeeeconomicsdetails^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arryCol = new ArrayList();
				arryCol.add(rs.getString("seqno"));
				arryCol.add(appno);
				arryCol.add(rs.getString("sno"));
				arryCol.add(rs.getString("coffee_year"));
				arryCol.add(rs.getString("area"));
				arryCol.add(rs.getString("arabica"));
				arryCol.add(rs.getString("robusta"));
				arryCol.add(rs.getString("yield"));
				arryCol.add(rs.getString("cult"));
				arryCol.add(rs.getString("netinc"));
				arryCol.add(rs.getString("amount"));
				arryCol.add(rs.getString("totincome"));
				arryCol.add(rs.getString("sources"));
				arryRow.add(arryCol);
			}
			strQuery = SQLParser.getSqlQuery("agrlandmeasurement^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("land_measurement",correctNull(rs.getString("land_measurement")));
			}
			hshRecord.put("appno", appno);
			hshRecord.put("arryRow", arryRow);
			hshRecord.put("PageType", PageType);
		} 
		catch (Exception ce)
		{
			throw new EJBException("Error in closing getData" + ce.getMessage());
		}
		finally 
		{
			try 
			{
				if (rs != null)
				{
					rs.close();
					rs = null;
				}
			} 
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshRecord;
	}

	public HashMap updatecoffeeeconomicsdata(HashMap hshValues)  
	{
		String strQuery = "";
		HashMap hshQueryValues = new HashMap();
		HashMap hshpasValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null;
		String strAction = null;
		HashMap hshResult = new HashMap();
		HashMap hshQuery4 = new HashMap();
		int intUpdatesize = 0;
		int f = 0;
		String strid = "", strQuery1 = "";
		String appno = correctNull((String) hshValues.get("strappno"));
		if(appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("appno"));
		}
		strAction = correctNull((String) hshValues.get("hidAction"));
		String PageType=correctNull((String)hshValues.get("hidpagetype"));
		
		try
		{
			String[] txt_year = null;
			String[] txt_area = null;
			String[] txt_arabica = null;
			String[] txt_robusta = null;
			String[] txt_yield = null;
			String[] txt_cult = null;
			String[] txt_netinc = null;
			String[] txt_amount = null;
			String[] txt_totincome= null;
			String txr_sources=null;
			txt_year= (String[]) hshValues.get("txt_year");
			txt_area = (String[]) hshValues.get("txt_area");
			strid = correctNull((String) hshValues.get("hid_sno"));
			txt_arabica = (String[]) hshValues.get("txt_arabica");
			txt_robusta = (String[]) hshValues.get("txt_robusta");
			txt_yield = (String[]) hshValues.get("txt_yield");
			txt_cult = (String[]) hshValues.get("txt_cult");
			txt_netinc= (String[]) hshValues.get("txt_netinc");
			txt_amount = (String[]) hshValues.get("txt_amount");
			txt_totincome = (String[]) hshValues.get("txt_totincome");
			 txr_sources=correctNull((String)hshValues.get("txr_sources"));
			
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshResult.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshResult.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshResult.put("applicantid", rs.getString("demo_appid"));
			}
			if (strAction.equals("delete"))
			{
				hshQuery4 = new HashMap();
				HashMap hshQueryValues4 = new HashMap();
				ArrayList arrValues4 = new ArrayList();
				hshQueryValues4.put("size", "1");
				hshQuery4.put("strQueryId", "per_del_coffeeeconomicsdetails");
				arrValues4.add(appno);
				hshQuery4.put("arrValues", arrValues4);
				hshQueryValues4.put("1", hshQuery4);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues4,"updateData");
			}
			if (strAction.equals("insert"))
			{
				HashMap hshQuery3 = new HashMap();
				ArrayList arrValues3 = new ArrayList();
				hshQuery3.put("size", "2");
				hshQuery3.put("strQueryId", "per_del_coffeeeconomicsdetails");
				arrValues3.add(appno);
				hshQuery3.put("arrValues", arrValues3);
				strQuery1 = SQLParser.getSqlQuery("sel_maxid_coffeeeconomicsdetails");
				rs = DBUtils.executeQuery(strQuery1);
				if (rs.next()) 
				{
					strid = correctNull((String) rs.getString("maxid"));
					f = Integer.parseInt(strid);
				}
				intUpdatesize = 1;

				for (int i = 0; i<txt_year.length; i++) 
				{
					intUpdatesize = intUpdatesize + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "per_ins_coffeeeconomicsdetails");
					arrValues.add(Integer.toString(f));
					arrValues.add(appno);
					arrValues.add(new Integer(i + 1).toString());
					arrValues.add(correctNull(txt_year[i]));
					if (correctNull(txt_area[i]).equals(""))
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_area[i]));
					}
					if (correctNull(txt_arabica[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_arabica[i]));
					}
					if (correctNull(txt_robusta[i]).equals("")) 
					{
						arrValues.add("");
					}
					else 
					{
						arrValues.add(correctNull(txt_robusta[i]));
					}
					if (correctNull(txt_yield[i]).equals("")) 
					{
						arrValues.add("");
					}
					else
					{
						arrValues.add(correctNull(txt_yield[i]));
					}
					if (correctNull(txt_cult[i]).equals(""))
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_cult[i]));
					}
					if (correctNull(txt_netinc[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_netinc[i]));
					}
					if (correctNull(txt_amount[i]).equals("")) 
					{
						arrValues.add("");
					}
					else
					{
						arrValues.add(correctNull(txt_amount[i]));
					}
					if (correctNull(txt_totincome[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else
					{
						arrValues.add(correctNull(txt_totincome[i]));
					}
					
					for (int m = 0; m<1; m++) 
					{
						arrValues.add(correctNull(txr_sources));	
					}
					hshQuery.put("arrValues", arrValues);
					f = f + 1;
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				}
                 
				hshQueryValues.put("1", hshQuery3);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			hshpasValues.put("appno", appno);
			hshResult = getcoffeeeconomicsdata(hshpasValues);
			hshResult.put("PageType",PageType);
		}
		catch (Exception e) 
		{
			throw new EJBException("Error in Insert Data " + e.getMessage());
		}
		finally 
		{
			try 
			{
				if (rs != null) 
				{
					rs.close();
					rs = null;
				}
			} 
			catch (Exception e) 
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshResult;
	}
	//cashflow
	public HashMap getcoffeetermcashflow(HashMap hshValues)  
	{
		String strQuery = "";
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord = new HashMap();
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;
		ArrayList vecRow = new ArrayList();
		ArrayList vecData = new ArrayList() ;
		ArrayList vecyearlyincome=new ArrayList();
		String strProductType=correctNull((String)hshValues.get("strProductType"));
		String appno = correctNull((String) hshValues.get("strappno"));
		if(appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("appno"));
		}
		String PageType = correctNull((String)hshValues.get("hidpagetype"));
		try 
		{
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshRecord.put("applicantid", rs.getString("demo_appid"));
			}
			strQuery = SQLParser.getSqlQuery("per_get_coffeeeconomicsdetails^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				vecRow = new ArrayList();
				vecRow.add(rs.getString("seqno"));
				vecRow.add(appno);
				vecRow.add(rs.getString("sno"));
				vecRow.add(rs.getString("coffee_year"));
				vecRow.add(rs.getString("area"));
				vecRow.add(rs.getString("arabica"));
				vecRow.add(rs.getString("robusta"));
				vecRow.add(rs.getString("yield"));
				vecRow.add(rs.getString("cult"));
				vecRow.add(rs.getString("netinc"));
				vecRow.add(rs.getString("amount"));
				vecRow.add(rs.getString("totincome"));
				vecData.add(vecRow);
			}
			strQuery = SQLParser.getSqlQuery("agrlandmeasurement^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("land_measurement",correctNull(rs.getString("land_measurement")));
			}
			strQuery = SQLParser.getSqlQuery("per_get_coffeetermcashflow^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arryCol = new ArrayList();
				arryCol.add(rs.getString("seqno"));
				arryCol.add(appno);
				arryCol.add(rs.getString("sno"));
				arryCol.add(rs.getString("loan"));
				arryCol.add(rs.getString("totincome"));
				arryCol.add(rs.getString("croploan"));
				arryCol.add(rs.getString("termloane"));
				arryCol.add(rs.getString("termloanp"));
				arryCol.add(rs.getString("taxes"));
				arryCol.add(rs.getString("termloaner"));
				arryCol.add(rs.getString("termloanpr"));
				arryCol.add(rs.getString("outgoings"));
				arryCol.add(rs.getString("surplus"));
				arryCol.add(rs.getString("interest"));
				arryRow.add(arryCol);
			}
			if(arryRow==null || arryRow.size()==0)
			{
				for(int i=0;i<14;i++)
				{
					arryRow.add("");
				}
			}
			hshRecord.put("appno", appno);
			hshRecord.put("vecData", vecData);
			hshRecord.put("arryRow", arryRow);
			hshRecord.put("PageType", PageType);
		
			if(strProductType.equalsIgnoreCase("aQ"))
			{
				hshRecord.put("intyearsize","25");
			double incyear1=0.00;
			double incyear2=0.00;
			double incyear3=0.00;
			double incyear4=0.00;
			double incyear5=0.00;
			double incyear6=0.00;
			double incyear7=0.00;
			double incyear8=0.00;
			double incyear9=0.00;
			double incyear10=0.00;
			double incyear11=0.00;
			double incyear12=0.00;
			double incyear13=0.00;
			double incyear14=0.00;
			double incyear15=0.00;
			double incyear16=0.00;
			double incyear17=0.00;
			double incyear18=0.00;
			double incyear19=0.00;
			double incyear20=0.00;
			double incyear21=0.00;
			double incyear22=0.00;
			double incyear23=0.00;
			double incyear24=0.00;
			double incyear25=0.00;
			
			if(rs1!=null)
			{
				rs1.close();
			}
			
			strQuery = SQLParser.getSqlQuery("netincome_inc_plantation^" + appno);
			rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					incyear1= Double.parseDouble((Helper.correctDouble((String)rs1.getString("INC1"))));
					incyear2= Double.parseDouble((Helper.correctDouble((String)rs1.getString("INC2"))));
					incyear3= Double.parseDouble((Helper.correctDouble((String)rs1.getString("INC3"))));
					incyear4= Double.parseDouble((Helper.correctDouble((String)rs1.getString("INC4"))));
					incyear5= Double.parseDouble((Helper.correctDouble((String)rs1.getString("INC5"))));
					incyear6= Double.parseDouble((Helper.correctDouble((String)rs1.getString("INC6"))));
					incyear7= Double.parseDouble((Helper.correctDouble((String)rs1.getString("INC7"))));
					incyear8= Double.parseDouble((Helper.correctDouble((String)rs1.getString("INC8"))));
					incyear9= Double.parseDouble((Helper.correctDouble((String)rs1.getString("INC9"))));
					incyear10= Double.parseDouble((Helper.correctDouble((String)rs1.getString("INC10"))));
					incyear11= Double.parseDouble((Helper.correctDouble((String)rs1.getString("INC11"))));
					incyear12= Double.parseDouble((Helper.correctDouble((String)rs1.getString("INC12"))));
					incyear13= Double.parseDouble((Helper.correctDouble((String)rs1.getString("INC13"))));
					incyear14= Double.parseDouble((Helper.correctDouble((String)rs1.getString("INC14"))));
					incyear15= Double.parseDouble((Helper.correctDouble((String)rs1.getString("INC15"))));
					incyear16= Double.parseDouble((Helper.correctDouble((String)rs1.getString("INC16"))));
					incyear17= Double.parseDouble((Helper.correctDouble((String)rs1.getString("INC17"))));
					incyear18= Double.parseDouble((Helper.correctDouble((String)rs1.getString("INC18"))));
					incyear19= Double.parseDouble((Helper.correctDouble((String)rs1.getString("INC19"))));
					incyear20= Double.parseDouble((Helper.correctDouble((String)rs1.getString("INC20"))));
					incyear21= Double.parseDouble((Helper.correctDouble((String)rs1.getString("INC21"))));
					incyear22= Double.parseDouble((Helper.correctDouble((String)rs1.getString("INC22"))));
					incyear23= Double.parseDouble((Helper.correctDouble((String)rs1.getString("INC23"))));
					incyear24= Double.parseDouble((Helper.correctDouble((String)rs1.getString("INC24"))));
					incyear25= Double.parseDouble((Helper.correctDouble((String)rs1.getString("INC25"))));
					
					
					
				}
				double expyear1=0.00;
				double expyear2=0.00;
				double expyear3=0.00;
				double expyear4=0.00;
				double expyear5=0.00;
				double expyear6=0.00;
				double expyear7=0.00;
				double expyear8=0.00;
				double expyear9=0.00;
				double expyear10=0.00;
				double expyear11=0.00;
				double expyear12=0.00;
				double expyear13=0.00;
				double expyear14=0.00;
				double expyear15=0.00;
				double expyear16=0.00;
				double expyear17=0.00;
				double expyear18=0.00;
				double expyear19=0.00;
				double expyear20=0.00;
				double expyear21=0.00;
				double expyear22=0.00;
				double expyear23=0.00;
				double expyear24=0.00;
				double expyear25=0.00;
				
				if(rs1!=null)
				{
					rs1.close();
				}
				
				strQuery = SQLParser.getSqlQuery("netincome_exp_plantation^" + appno);
				rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						expyear1=Double.parseDouble((Helper.correctDouble((String)rs1.getString("EXP1"))));
						expyear2=Double.parseDouble((Helper.correctDouble((String)rs1.getString("EXP2"))));
						expyear3= Double.parseDouble((Helper.correctDouble((String)rs1.getString("EXP3"))));
						expyear4=Double.parseDouble((Helper.correctDouble((String)rs1.getString("EXP4"))));
						expyear5=Double.parseDouble((Helper.correctDouble((String)rs1.getString("EXP5"))));
						expyear6=Double.parseDouble((Helper.correctDouble((String)rs1.getString("EXP6"))));
						expyear7= Double.parseDouble((Helper.correctDouble((String)rs1.getString("EXP7"))));
						expyear8=Double.parseDouble((Helper.correctDouble((String)rs1.getString("EXP8"))));
						expyear9=Double.parseDouble((Helper.correctDouble((String)rs1.getString("EXP9"))));
						expyear10=Double.parseDouble((Helper.correctDouble((String)rs1.getString("EXP10"))));
						expyear11= Double.parseDouble((Helper.correctDouble((String)rs1.getString("EXP11"))));
						expyear12=Double.parseDouble((Helper.correctDouble((String)rs1.getString("EXP12"))));
						expyear13=Double.parseDouble((Helper.correctDouble((String)rs1.getString("EXP13"))));
						expyear14=Double.parseDouble((Helper.correctDouble((String)rs1.getString("EXP14"))));
						expyear15= Double.parseDouble((Helper.correctDouble((String)rs1.getString("EXP15"))));
						expyear16= Double.parseDouble((Helper.correctDouble((String)rs1.getString("EXP16"))));
						expyear17= Double.parseDouble((Helper.correctDouble((String)rs1.getString("EXP17"))));
						expyear18= Double.parseDouble((Helper.correctDouble((String)rs1.getString("EXP18"))));
						expyear19= Double.parseDouble((Helper.correctDouble((String)rs1.getString("EXP19"))));
						expyear20= Double.parseDouble((Helper.correctDouble((String)rs1.getString("EXP20"))));
						expyear21= Double.parseDouble((Helper.correctDouble((String)rs1.getString("EXP21"))));
						expyear22= Double.parseDouble((Helper.correctDouble((String)rs1.getString("EXP22"))));
						expyear23= Double.parseDouble((Helper.correctDouble((String)rs1.getString("EXP23"))));
						expyear24= Double.parseDouble((Helper.correctDouble((String)rs1.getString("EXP24"))));
						expyear25= Double.parseDouble((Helper.correctDouble((String)rs1.getString("EXP25"))));
						
						
					}
					double netincomeyear1=0.00;
					double netincomeyear2=0.00;
					double netincomeyear3=0.00;
					double netincomeyear4=0.00;
					double netincomeyear5=0.00;
					double netincomeyear6=0.00;
					double netincomeyear7=0.00;
					double netincomeyear8=0.00;
					double netincomeyear9=0.00;
					double netincomeyear10=0.00;
					double netincomeyear11=0.00;
					double netincomeyear12=0.00;
					double netincomeyear13=0.00;
					double netincomeyear14=0.00;
					double netincomeyear15=0.00;
					double netincomeyear16=0.00;
					double netincomeyear17=0.00;
					double netincomeyear18=0.00;
					double netincomeyear19=0.00;
					double netincomeyear20=0.00;
					double netincomeyear21=0.00;
					double netincomeyear22=0.00;
					double netincomeyear23=0.00;
					double netincomeyear24=0.00;
					double netincomeyear25=0.00;
					
					netincomeyear1=incyear1-expyear1;
					netincomeyear2=incyear2-expyear2;
					netincomeyear3=incyear3-expyear3;
					netincomeyear4=incyear4-expyear4;
					netincomeyear5=incyear5-expyear5;
					netincomeyear6=incyear6-expyear6;
					netincomeyear7=incyear7-expyear7;
					netincomeyear8=incyear8-expyear8;
					netincomeyear9=incyear9-expyear9;
					netincomeyear10=incyear10-expyear10;
					netincomeyear11=incyear11-expyear11;
					netincomeyear12=incyear12-expyear12;
					netincomeyear13=incyear13-expyear13;
					netincomeyear14=incyear14-expyear14;
					netincomeyear15=incyear15-expyear15;
					netincomeyear16=incyear16-expyear16;
					netincomeyear17=incyear17-expyear17;
					netincomeyear18=incyear18-expyear18;
					netincomeyear19=incyear19-expyear19;
					netincomeyear20=incyear20-expyear20;
					netincomeyear21=incyear21-expyear21;
					netincomeyear22=incyear22-expyear22;
					netincomeyear23=incyear23-expyear23;
					netincomeyear24=incyear24-expyear24;
					netincomeyear25=incyear25-expyear25;
					
					vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear1));
					vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear2));
					vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear3));
					vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear4));
					vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear5));
					vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear6));
					vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear7));
					vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear8));
					vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear9));
					vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear10));
					vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear11));
					vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear12));
					vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear13));
					vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear14));
					vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear15));
					vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear16));
					vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear17));
					vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear18));
					vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear19));
					vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear20));
					vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear21));
					vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear22));
					vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear23));
					vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear24));
					vecyearlyincome.add(Helper.formatDoubleValue(netincomeyear25));
					
					
			}	
			hshRecord.put("strProductType",strProductType);
			hshRecord.put("vecyearlyincome",vecyearlyincome);
			if(rs1!=null)
			{
				rs1.close();
			}
			
			strQuery = SQLParser.getSqlQuery("getloanterms^" + appno);
			rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					hshRecord.put("loan_recmdamt", Helper.correctDouble((String)rs1.getString("loan_recmdamt")));
					hshRecord.put("loan_modintrate", Helper.correctDouble((String)rs1.getString("loan_modintrate")));
				}
		}
		catch (Exception ce)
		{
			throw new EJBException("Error in closing getData" + ce.getMessage());
		}
		finally 
		{
			try 
			{
				if (rs != null)
				{
					rs.close();
					rs = null;
				}
				if (rs1 != null)
				{
					rs1.close();
					rs1= null;
				}
			} 
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshRecord;
	}

	public HashMap updatecoffeetermcashflow(HashMap hshValues)  
	{
		String strQuery = "";
		HashMap hshQueryValues = new HashMap();
		HashMap hshpasValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null;
		String strAction = null;
		HashMap hshResult = new HashMap();
		HashMap hshQuery4 = new HashMap();
		int intUpdatesize = 0;
		int f = 0;
		String strid = "", strQuery1 = "";
		String prd_type="";
		 prd_type = correctNull((String)hshValues.get("strProductType"));
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = correctNull((String)hshValues.get("prd_type"));
		}
		String appno = correctNull((String) hshValues.get("strappno"));
		if(appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("appno"));
		}
		strAction = correctNull((String) hshValues.get("hidAction"));
		String PageType=correctNull((String)hshValues.get("hidpagetype"));
		
		try
		{
			String[] txt_loan = null;
			String[] txt_totincome = null;
			String[] txt_croploan= null;
			String[] txt_termloane= null;
			String[] txt_termloanp= null;
			String[] txt_taxes = null;
			String[] txt_termloaner = null;
			String[] txt_termloanpr = null;
			String[] txt_outgoings= null;
			String[] txt_surplus= null;
			String[] txt_interest=null;
			txt_loan= (String[]) hshValues.get("txt_loan");
			txt_interest=(String[]) hshValues.get("txt_interest");
			txt_totincome = (String[]) hshValues.get("txt_totincome");
			strid = correctNull((String) hshValues.get("hid_sno"));
			txt_croploan = (String[]) hshValues.get("txt_croploan");
			txt_termloane= (String[]) hshValues.get("txt_termloane");
			txt_termloanp = (String[]) hshValues.get("txt_termloanp");
			txt_taxes = (String[]) hshValues.get("txt_taxes");
			txt_termloaner= (String[]) hshValues.get("txt_termloaner");
			txt_termloanpr = (String[]) hshValues.get("txt_termloanpr");
			txt_outgoings = (String[]) hshValues.get("txt_outgoings");
			txt_surplus= (String[]) hshValues.get("txt_surplus");
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshResult.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshResult.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshResult.put("applicantid", rs.getString("demo_appid"));
			}
			if (strAction.equals("delete"))
			{
				hshQuery4 = new HashMap();
				HashMap hshQueryValues4 = new HashMap();
				ArrayList arrValues4 = new ArrayList();
				hshQueryValues4.put("size", "1");
				hshQuery4.put("strQueryId", "per_del_coffeetermcashflow");
				arrValues4.add(appno);
				hshQuery4.put("arrValues", arrValues4);
				hshQueryValues4.put("1", hshQuery4);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues4,"updateData");
			}
			if (strAction.equals("insert"))
			{
				HashMap hshQuery3 = new HashMap();
				ArrayList arrValues3 = new ArrayList();
				hshQuery3.put("size", "2");
				hshQuery3.put("strQueryId", "per_del_coffeetermcashflow");
				arrValues3.add(appno);
				hshQuery3.put("arrValues", arrValues3);
				strQuery1 = SQLParser.getSqlQuery("sel_maxid_coffeetermcashflow");
				rs = DBUtils.executeQuery(strQuery1);
				if (rs.next()) 
				{
					strid = correctNull((String) rs.getString("maxid"));
					f = Integer.parseInt(strid);
				}
				intUpdatesize = 1;

				for (int i = 0; i<25; i++) 
				{
					intUpdatesize = intUpdatesize + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "per_ins_coffeetermcashflow");
					arrValues.add(Integer.toString(f));
					arrValues.add(appno);
					arrValues.add(new Integer(i + 1).toString());
					if (correctNull(txt_loan[i]).equals(""))
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_loan[i]));
					}
                	if (correctNull(txt_totincome[i]).equals(""))
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_totincome[i]));
					}
					if (correctNull(txt_croploan[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_croploan[i]));
					}
					if (correctNull(txt_termloane[i]).equals("")) 
					{
						arrValues.add("");
					}
					else 
					{
						arrValues.add(correctNull(txt_termloane[i]));
					}
					if (correctNull(txt_termloanp[i]).equals("")) 
					{
						arrValues.add("");
					}
					else
					{
						arrValues.add(correctNull(txt_termloanp[i]));
					}
					if (correctNull(txt_taxes[i]).equals(""))
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_taxes[i]));
					}
					if (correctNull(txt_termloaner[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_termloaner[i]));
					}
					if (correctNull(txt_termloanpr[i]).equals("")) 
					{
						arrValues.add("0");
					}
					else
					{
						arrValues.add(correctNull(txt_termloanpr[i]));
					}
					if (correctNull(txt_outgoings[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else
					{
						arrValues.add(correctNull(txt_outgoings[i]));
					}
					if (correctNull(txt_surplus[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else
					{
						arrValues.add(correctNull(txt_surplus[i]));
					}
					if (correctNull(txt_interest[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else
					{
						arrValues.add(correctNull(txt_interest[i]));
					}
					
					
					hshQuery.put("arrValues", arrValues);
					f = f + 1;
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				}

				hshQueryValues.put("1", hshQuery3);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			StringBuilder sbAuditTrial=new StringBuilder();
			for (int i = 0; i<25; i++) 
			{
				sbAuditTrial
				.append("~Project Year = ")
				.append(i+1)
				.append("~Loan at the Begining of the year = ")
				.append(correctNull(txt_loan[i]))
				.append("~Interest = ")
				.append(correctNull(txt_interest[i]))
				.append("~Net Income = ")
				.append(correctNull(txt_totincome[i]))
				.append("~Bank Interest for Crop Loan = ")
				.append(correctNull(txt_croploan[i]))
				.append("~Bank Interest for Existing Term Loan = ")
				.append(correctNull(txt_termloane[i]))
				.append("~Bank Interest for Proposed Term Loan = ")
				.append(correctNull(txt_termloanp[i]))
				.append("~Taxes = ")
				.append(correctNull(txt_taxes[i]))
				.append("~Repayment of Existing Term Loan Installment = ")
				.append(correctNull(txt_termloaner[i]))
				.append("~Repayment of Proposed Term Loans = ")
				.append(correctNull(txt_termloanpr[i]))
				.append("~Total Outgoings = ")
				.append(correctNull(txt_outgoings[i]))
				.append("~Surplus = ")
				.append(correctNull(txt_surplus[i]));
			}
			
			AuditTrial.auditLog(hshValues,"272",appno,sbAuditTrial.toString());
			
			hshpasValues.put("appno", appno);
			hshpasValues.put("strProductType", prd_type);
			hshResult = getcoffeetermcashflow(hshpasValues);
			hshResult.put("PageType",PageType);
		}
		catch (Exception e) 
		{
			throw new EJBException("Error in Insert Data " + e.getMessage());
		}
		finally 
		{
			try 
			{
				if (rs != null) 
				{
					rs.close();
					rs = null;
				}
			} 
			catch (Exception e) 
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshResult;
	}
	//coffeeterm eligibility
	public HashMap getcoffeetermeligibility(HashMap hshValues)  
	{
		String strQuery = "";
		ResultSet rs = null;
		String prd_type="";
		 prd_type = correctNull((String)hshValues.get("strProductType"));
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = correctNull((String)hshValues.get("prd_type"));
		}
		HashMap hshRecord = new HashMap();
		ArrayList arryRow = new ArrayList();
		
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = correctNull((String)hshValues.get("prd_type"));
		}
		ArrayList arryCol = null;
		ArrayList arryRow1 = new ArrayList();
		ArrayList arryCol1 = null;
		ArrayList arryRow2 = new ArrayList();
		ArrayList arryCol2 = null;
		//int rowsize = 15;
		double totalcost1=0.00;double totalloan1=0.00;double totalmargin=0.00;
		double totalcost11=0.00;double totalloan11=0.00;double totalmargin11=0.00;
		String appno = correctNull((String) hshValues.get("strappno"));
		if(appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("appno"));
		}
		String PageType = correctNull((String)hshValues.get("hidpagetype"));
		try 
		{
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshRecord.put("applicantid", rs.getString("demo_appid"));
			}
			strQuery = SQLParser.getSqlQuery("per_get_yearcostdetails^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arryCol = new ArrayList();
				arryCol.add(rs.getString("seqno"));
				arryCol.add(appno);
				arryCol.add(rs.getString("sno"));
				arryCol.add(rs.getString("product_type"));
				arryCol.add(rs.getString("item"));
				arryCol.add(rs.getString("cost1"));
				arryCol.add(rs.getString("loan1"));
				arryCol.add(rs.getString("cost2"));
				arryCol.add(rs.getString("loan2"));
				arryCol.add(rs.getString("cost3"));
				arryCol.add(rs.getString("loan3"));
				arryCol.add(rs.getString("cost4"));
				arryCol.add(rs.getString("loan4"));
				arryCol.add(rs.getString("cost5"));
				arryCol.add(rs.getString("loan5"));
				arryCol.add(rs.getString("cost6"));
				arryCol.add(rs.getString("loan6"));
				arryCol.add(rs.getString("cost7"));
				arryCol.add(rs.getString("loan7"));	
				arryCol.add(rs.getString("totalcost1"));
				totalcost1=Double.parseDouble((Helper.correctDouble((String)rs.getString("totalcost1"))));
			    arryCol.add(rs.getString("totalloan1"));	
				totalloan1=Double.parseDouble((Helper.correctDouble((String)rs.getString("totalloan1"))));
				totalmargin=(totalcost1)-(totalloan1);
				arryCol.add(Helper.formatDoubleValue(totalmargin));
				totalcost11 = totalcost11 + Double.parseDouble((Helper.correctDouble((String)rs.getString("totalcost1"))));
				totalloan11 = totalloan11 + Double.parseDouble((Helper.correctDouble((String)rs.getString("totalloan1"))));
				totalmargin11 = totalmargin11 +totalmargin;
				
				arryRow.add(arryCol);
			}
		/*		strQuery = SQLParser.getSqlQuery("agr_get_plantaionexpenses^" + appno+"^"+"EXP");
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arryCol = new ArrayList();
				
				
				arryCol.add(rs.getString("exp_item"));
				
				arryCol.add(rs.getString("exp_total"));
				
					
				arryRow.add(arryCol);
			}

			if(arryRow.size()!=rowsize)
			{
				int rsize = rowsize-arryRow.size();
				for(int i=0; i<rsize; i++)
				{
					arryCol = new ArrayList();
					arryCol.add("");
					arryCol.add("");
					
					
					arryRow.add(arryCol);
				}
					
			} */

			
			hshRecord.put("arryRow", arryRow);
			strQuery = SQLParser.getSqlQuery("per_get_coffeetermeligibility^" + appno+"^"+prd_type);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arryCol1 = new ArrayList();
				arryCol1.add(rs.getString("loanamounte"));
				arryRow1.add(arryCol1);
			}
			strQuery = SQLParser.getSqlQuery("per_get_coffeetermdisbursement^" + appno+"^"+prd_type);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arryCol2 = new ArrayList();
				arryCol2.add(rs.getString("loanamounte"));
				arryRow2.add(arryCol2);
			}
			hshRecord.put("appno", appno);
			hshRecord.put("arryRow", arryRow);
			hshRecord.put("arryRow1", arryRow1);
			hshRecord.put("arryRow2", arryRow2);
			hshRecord.put("PageType", PageType);
			hshRecord.put("totalcost", Helper.formatDoubleValue(totalcost11));
			hshRecord.put("totalloanamount",Helper.formatDoubleValue(totalloan11));
			hshRecord.put("totalmarginamount",Helper.formatDoubleValue(totalmargin11));
			
		} 
		catch (Exception ce)
		{
			throw new EJBException("Error in closing getData" + ce.getMessage());
		}
		finally 
		{
			try 
			{
				if (rs != null)
				{
					rs.close();
					rs = null;
				}
			} 
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshRecord;
	}
	public void updatecoffeetermeligibility(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery =  new HashMap();
		ArrayList arrValues=new ArrayList();
		String prd_type = correctNull((String)hshValues.get("strProductType"));
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = correctNull((String)hshValues.get("prd_type"));
		}
		String strAction=correctNull((String)hshValues.get("hidAction"));
		String strAction1=correctNull((String)hshValues.get("hidAction1"));
		String appno=correctNull((String)hshValues.get("strappno"));
		if(appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("appno"));
		}
		ResultSet rs = null;
		try
		{			
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","per_del_coffeetermeligibility");
				arrValues.add(appno);
				arrValues.add(prd_type);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
	            hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				arrValues.add(correctNull((String) hshValues.get("txt_totalloanamount")));
				String txt_totalloanamounte=correctNull((String) hshValues.get("txt_totalloanamounte"));
				if(txt_totalloanamounte.equalsIgnoreCase(""))
				{
					txt_totalloanamounte="";
				}
				
				arrValues.add(txt_totalloanamounte);
				arrValues.add(prd_type);
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "per_ins_coffeetermeligibility");
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","per_del_coffeetermeligibility");
				arrValues.add(appno);
				arrValues.add(prd_type);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");  
			}	
			if(strAction1.equalsIgnoreCase("insert1"))
			{
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","per_del_coffeetermdisbursement");
				arrValues.add(appno);
				arrValues.add(prd_type);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
	            hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				arrValues.add(correctNull((String) hshValues.get("txt_totalloanamount")));
				String txt_totalloanamounte=correctNull((String) hshValues.get("txt_totalloanamounte"));
				if(txt_totalloanamounte.equalsIgnoreCase(""))
				{
					txt_totalloanamounte="";
				}
				
				arrValues.add(txt_totalloanamounte);
				arrValues.add(prd_type);
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "per_ins_coffeetermdisbursement");
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction1.equalsIgnoreCase("delete1"))
			{
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","per_del_coffeetermdisbursement");
				arrValues.add(appno);
				arrValues.add(prd_type);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");  
			}	
			
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
		}
		finally 
		{
			try
			{
				if (rs != null) 
				{
					rs.close();
					rs = null;
				}
				 
			}
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
	}
//coffee repayment
	public HashMap updatecoffeetermrepayment(HashMap hshValues)  
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshpasValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ResultSet rs = null;
		HashMap hshResult = new HashMap();
		String strAction="";	String strAction1="";
		String txt_roi ="", txt_holiday="",sel_payment="",txt_installment="",txt_date="";
		String txt_lastinstallment="";
		String prd_type = correctNull((String)hshValues.get("strProductType"));
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = correctNull((String)hshValues.get("prd_type"));
		}
		String strApplicationNo = correctNull((String) hshValues.get("strappno"));
		if(strApplicationNo.equalsIgnoreCase(""))
		{
			strApplicationNo = correctNull((String)hshValues.get("appno"));
		}
		 strAction = correctNull((String) hshValues.get("hidAction"));
		 strAction1 = correctNull((String) hshValues.get("hidAction1"));
	  	String []txt_loaninstallment=null;
		String []sel_interest=null;
		int intUpdatesize=0;
		ArrayList arrValues1=new ArrayList();
		try
		{
			strApplicationNo=correctNull((String)hshValues.get("strappno"));
			if(strApplicationNo.equalsIgnoreCase(""))
			{
				strApplicationNo = correctNull((String)hshValues.get("appno"));
			}
			sel_interest=(String [])hshValues.get("sel_interest");
			txt_loaninstallment=(String [])hshValues.get("txt_loaninstallment");
			if (strAction.equals("insert"))
			{			
				hshQuery=new HashMap();
				ArrayList arrValues=new ArrayList();
				arrValues.add(strApplicationNo);
				arrValues.add(prd_type);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","agr_del_coffeetermrepayment");
				intUpdatesize=1;
				hshQueryValues.put("1",hshQuery);
				for(int i=2;i<txt_loaninstallment.length+2;i++)
				{
					if(!txt_loaninstallment[i-2].equals(""))
					{
						intUpdatesize=intUpdatesize+1;
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","agr_ins_coffeetermrepayment");
						arrValues.add(strApplicationNo);
						arrValues.add(new Integer(i-1).toString());
						if(correctNull(txt_loaninstallment[i-2]).equals(""))
						{
							arrValues.add("0");
						}
						else
						{
							arrValues.add(correctNull(txt_loaninstallment[i-2]));
						}
						arrValues.add(correctNull(sel_interest[i-2]));
						arrValues.add(prd_type);	
						hshQuery.put("arrValues",arrValues);	
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(i),hshQuery);		
					}
				}
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			} 			
		    if(strAction1.equalsIgnoreCase("insert1"))
				
			{
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","agr_del_bullockrepay");
				arrValues1.add(strApplicationNo);
				arrValues1.add(prd_type);
				hshQuery.put("arrValues",arrValues1);
				hshQueryValues.put("1",hshQuery);
	            hshQuery = new HashMap();
				arrValues1 = new ArrayList();
				arrValues1.add(strApplicationNo);
				txt_roi= correctNull((String)hshValues.get("txt_roi"));
				txt_holiday= correctNull((String)hshValues.get("txt_holiday"));
				sel_payment= correctNull((String)hshValues.get("sel_payment"));
				txt_installment = correctNull((String)hshValues.get("txt_installment"));
				txt_date = correctNull((String)hshValues.get("txt_date"));
				txt_lastinstallment= correctNull((String)hshValues.get("txt_lastinstallment"));
				if(txt_roi.equalsIgnoreCase(""))
				{	
					txt_roi="0";
				}
				arrValues1.add(txt_roi);
				
				if(txt_holiday.equalsIgnoreCase(""))
				{	
					txt_holiday="0";
				}
				arrValues1.add(txt_holiday);
				
				if(sel_payment.equalsIgnoreCase(""))
				{	
					sel_payment ="1";
				}
				arrValues1.add(sel_payment);
									
				if(txt_installment.equalsIgnoreCase(""))
				{	
					txt_installment="0.00";
				}
				arrValues1.add(txt_installment);
				
				if(txt_date.equalsIgnoreCase(""))
				{	
					txt_date ="01/01/1900";
				}
				arrValues1.add(txt_date);
				if(txt_lastinstallment.equalsIgnoreCase(""))
				{	
					txt_lastinstallment ="0.00";
				}
				arrValues1.add(txt_lastinstallment);		
				arrValues1.add(prd_type);
				arrValues1.add("");
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues1);
				hshQuery.put("strQueryId", "agr_ins_bullockrepay");
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
			}
		    if (strAction.equals("delete"))
			{
		    	hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","agr_del_coffeetermrepayment");
				arrValues1.add(strApplicationNo);
				arrValues1.add(prd_type);
				hshQuery.put("arrValues",arrValues1);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");  	
			}
		    if (strAction1.equals("delete1"))
			{
		    	arrValues1=new ArrayList();
		    	hshQuery=new HashMap();
		    	hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","agr_del_bullockrepay");
				arrValues1.add(strApplicationNo);
				arrValues1.add(prd_type);
				hshQuery.put("arrValues",arrValues1);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");  	
			}
			hshpasValues.put("appno",strApplicationNo);
			hshpasValues.put("txt_roi",txt_roi);
			hshpasValues.put("txt_installment",txt_installment);
			hshpasValues.put("txt_lastinstallment",txt_lastinstallment);
			hshpasValues.put("prd_type",prd_type);
			hshResult=getcoffeetermrepayment(hshpasValues);
		} 
		catch (Exception ce) 
		{
			throw new EJBException("Error in closing getData" + ce.getMessage());
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
			catch (Exception e) 
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshResult;
	}
	
	public HashMap getcoffeetermrepayment(HashMap hshValues)  
	{		 
		ResultSet rs=null;
		HashMap hshResult=new HashMap();
		ArrayList arryRow=new ArrayList();
		ArrayList arryCol=null;		
		String strApplicationNo=correctNull((String)hshValues.get("strappno"));
		if(strApplicationNo.equalsIgnoreCase(""))
		{
			strApplicationNo = correctNull((String)hshValues.get("appno"));
		}
		String prd_type = correctNull((String)hshValues.get("strProductType"));
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = correctNull((String)hshValues.get("prd_type"));
		}
		try
		{
			rs=DBUtils.executeLAPSQuery("agr_get_coffeetermrepayment^"+strApplicationNo+"^"+prd_type);
			double txt_total=0.00;
			while (rs.next())
			{
				arryCol=new ArrayList();
				arryCol.add(rs.getString("appno"));
				arryCol.add(rs.getString("sno"));
				arryCol.add(rs.getString("coffee_loaninstallment"));
				txt_total = txt_total + Double.parseDouble((Helper.correctDouble((String)rs.getString("coffee_loaninstallment"))));
				txt_total=Math.round(txt_total);
				arryCol.add(rs.getString("coffee_interest"));
				
				arryRow.add(arryCol);
			}
			hshResult.put("arryRow",arryRow);
			String strQuery="";
			strQuery = SQLParser.getSqlQuery("per_get_coffeetermcashflow^" + strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			ArrayList arryCol1 = new ArrayList();
			ArrayList arryRow1 = new ArrayList();
			while (rs.next())
			{
				arryCol1 = new ArrayList();
				arryCol1.add(rs.getString("seqno"));
				arryCol1.add(strApplicationNo);
				arryCol1.add(rs.getString("sno"));
				arryCol1.add(rs.getString("loan"));
				arryCol1.add(rs.getString("totincome"));
				arryCol1.add(rs.getString("croploan"));
				arryCol1.add(rs.getString("termloane"));
				arryCol1.add(rs.getString("termloanp"));
				arryCol1.add(rs.getString("taxes"));
				arryCol1.add(rs.getString("termloaner"));
				arryCol1.add(rs.getString("termloanpr"));
				arryCol1.add(rs.getString("outgoings"));
				arryCol1.add(rs.getString("surplus"));
				arryRow1.add(arryCol1);
			}
			hshResult.put("arryRow1",arryRow1);
			hshResult.put("txt_total",Helper.formatDoubleValue(txt_total));
			 strQuery="";
			
			strQuery = SQLParser.getSqlQuery("agr_sel_bullockrepay^"+strApplicationNo+ "^" +prd_type);			
			rs =DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				hshResult.put("txt_roi",correctNull(rs.getString("bullock_roi")));
				hshResult.put("txt_installment",correctNull(rs.getString("bullock_installment")));
				hshResult.put("txt_lastinstallment",correctNull(rs.getString("bullock_lastinstallment")));
				
			}
		} 
		catch (Exception e) 
		{
			throw new EJBException("Error in Insert Data " + e.getMessage());
		}
		finally 
		{
			try
			{
				if (rs != null) 
				{
					rs.close();
					rs = null;
				}
				 
			}
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshResult;
	}
//sericulture tech data
	public void updateseritechdata(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery =  new HashMap();
		ArrayList arrValues=new ArrayList();
		String strAction=correctNull((String)hshValues.get("hidAction"));
		String appno=correctNull((String)hshValues.get("strappno"));
		if(appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("appno"));
		}
		ResultSet rs = null;
		try
		{			
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues.put("size","2");
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","agr_del_seritechdata");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
	            hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				arrValues.add(correctNull((String) hshValues.get("txt_mainoccupation")));
				arrValues.add(correctNull((String) hshValues.get("txt_subsidaryoccupation")));
				arrValues.add(correctNull((String) hshValues.get("txt_proposedactivity")));
				arrValues.add(correctNull((String) hshValues.get("txt_place")));
				arrValues.add(correctNull((String) hshValues.get("txt_distance")));
				arrValues.add(correctNull((String) hshValues.get("txt_place1")));
				arrValues.add(correctNull((String) hshValues.get("txt_distance1")));
				String sel_labour=correctNull((String) hshValues.get("sel_labour"));
				if(sel_labour.equalsIgnoreCase(""))
				{
					sel_labour="0";
				}
				arrValues.add(sel_labour);				
			//	arrValues.add(correctNull((String) hshValues.get("txt_labourers")));
				String txt_labourers=correctNull((String) hshValues.get("txt_labourers"));
				
				if(txt_labourers.equalsIgnoreCase(""))
				{
					txt_labourers="0";
				}
				arrValues.add(txt_labourers);	
             String txt_wage=correctNull((String) hshValues.get("txt_wage"));
				
				if(txt_wage.equalsIgnoreCase(""))
				{
					txt_wage="0";
				}
				arrValues.add(txt_wage);	
				//arrValues.add(correctNull((String) hshValues.get("txt_wage")));
				String txt_area=correctNull((String) hshValues.get("txt_area"));
				if(txt_area.equalsIgnoreCase(""))
				{
					txt_area="0";
				}
				arrValues.add(txt_area);	
				String txt_guntas=correctNull((String) hshValues.get("txt_guntas"));
				if(txt_guntas.equalsIgnoreCase(""))
				{
					txt_guntas="0";
				}
				arrValues.add(txt_guntas);	
				arrValues.add(correctNull((String) hshValues.get("txt_irrigation")));
				arrValues.add(correctNull((String) hshValues.get("txt_chandrika")));
				arrValues.add(correctNull((String) hshValues.get("txt_trays")));
				arrValues.add(correctNull((String) hshValues.get("txt_stand")));
				arrValues.add(correctNull((String) hshValues.get("txt_noeggs")));
				arrValues.add(correctNull((String) hshValues.get("txt_nocrops")));
				arrValues.add(correctNull((String) hshValues.get("txt_quantity")));
				arrValues.add(correctNull((String) hshValues.get("txt_avgcost")));
				arrValues.add(correctNull((String) hshValues.get("txt_income")));
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "agr_ins_seritechdata");
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","agr_del_seritechdata");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");  
			}	
			String land_measure=correctNull((String) hshValues.get("land_measurement"));
			if(land_measure.equalsIgnoreCase("g"))
			{
				land_measure="Guntas";
			}
			else if(land_measure.equalsIgnoreCase("c"))
			{
				land_measure="Cents";
			}
			
			StringBuilder sbAuditTrial=new StringBuilder();
			if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
			{
				sbAuditTrial
				.append("~Main Occupation = ")
				.append(correctNull((String) hshValues.get("txt_mainoccupation")))
				.append("~Subsidary Occupation = ")
				.append(correctNull((String) hshValues.get("txt_subsidaryoccupation")))
				.append("~Knowledge & Experience in proposed Activity = ")
				.append(correctNull((String) hshValues.get("txt_proposedactivity")))
				.append("~Availibility of Eggs ^ ")
				.append("~Place = ")
				.append(correctNull((String) hshValues.get("txt_place")))
				.append("~Distance from Farm = ")
				.append(correctNull((String) hshValues.get("txt_distance")))
				.append("~Marketing of cocoons ^ ")
				.append("~Place = ")
				.append(correctNull((String) hshValues.get("txt_place1")))
				.append("~Distance from Farm = ")
				.append(correctNull((String) hshValues.get("txt_distance1")))
				.append("~Labourers to be Employed = ")
				.append(correctNull((String) hshValues.get("sel_labourtext")));
				if(correctNull((String) hshValues.get("sel_labourtext")).equalsIgnoreCase("Labour Employed"))
				{
					sbAuditTrial
					.append("~No of labourers = ")
					.append(correctNull((String) hshValues.get("txt_labourers")))
					.append("~Wages per Employee = ")
					.append(correctNull((String) hshValues.get("txt_wage")));
				}
				sbAuditTrial
				.append("~Existing Arrangements for Cocoon Production  ^ ")
				.append("~Area under Mulbery Plantation = ")
				.append(correctNull((String) hshValues.get("txt_area"))).append(" (Acres) ")
				.append(correctNull((String) hshValues.get("txt_guntas"))).append("")
				.append(" ( " + land_measure +" ) ")
				.append("~Irrigation Facility(Specify) = ")
				.append(correctNull((String) hshValues.get("txt_irrigation")))
				.append("~Chandrika(Nos &amp; Condition) = ")
				.append(correctNull((String) hshValues.get("txt_chandrika")))
				.append("~Trays(Nos & Condition) = ")
				.append(correctNull((String) hshValues.get("txt_trays")))
				.append("~Stand(Nos &amp; Condition) = ")
				.append(correctNull((String) hshValues.get("txt_stand")))
				.append("~No of Eggs reared(DFLs) = ")
				.append(correctNull((String) hshValues.get("txt_noeggs")))
				.append("~No. of successful Crops per year = ")
				.append(correctNull((String) hshValues.get("txt_nocrops")))
				.append("~Average Quantity of cocoons produced per crop = ")
				.append(correctNull((String) hshValues.get("txt_quantity")))
				.append("~Average Cost of cocoons produced per Kg(Rs.) = ")
				.append(correctNull((String) hshValues.get("txt_avgcost")))
				.append("~Net annual income from existing arrangements(Rs.) = ")
				.append(correctNull((String) hshValues.get("txt_income")));
				if(correctNull((String)hshValues.get("hidAuditFlag")).equalsIgnoreCase("Y"))
				{
					hshValues.put("strAction", "update");
				}
				else
				{
					hshValues.put("strAction", "insert");
				}
			}
				AuditTrial.auditLog(hshValues,"265",appno,sbAuditTrial.toString());
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
		}
		finally 
		{
			try
			{
				if (rs != null) 
				{
					rs.close();
					rs = null;
				}
				 
			}
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
	}

	public  HashMap getseritechdata(HashMap hshValues) 
	{		
		String strQuery="";
		ResultSet rs1 = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		HashMap hshResult = new HashMap();	
		try
		{
			String appstatus=correctNull((String)hshValues.get("appstatus1"));
			hshResult.put("appstatus",appstatus);
			java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
			jtn.setMaximumFractionDigits(2);
			jtn.setMinimumFractionDigits(2);
			jtn.setGroupingUsed(false);
			String appno=correctNull((String)hshValues.get("strappno"));
			if(appno.equalsIgnoreCase(""))
			{
				appno = correctNull((String)hshValues.get("appno"));
			}
			String prd_type = correctNull((String)hshValues.get("strProductType"));
			if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
			{
				prd_type = correctNull((String)hshValues.get("prd_type"));
			}
			strQuery = SQLParser.getSqlQuery("agrlandmeasurement^"+appno);
			
			rs2= DBUtils.executeQuery(strQuery);
			if(rs2.next())
			{
				hshResult.put("land_measurement",correctNull(rs2.getString("land_measurement")));
			}
			strQuery = SQLParser.getSqlQuery("agr_sel_seritechdata^"+appno);			
			rs2 =DBUtils.executeQuery(strQuery);
			while(rs2.next())
			{
				hshResult.put("txt_mainoccupation",correctNull(rs2.getString("agr_mainoccupation")));
				hshResult.put("txt_subsidaryoccupation",correctNull(rs2.getString("agr_subsidaryoccupation")));
				hshResult.put("txt_proposedactivity",correctNull(rs2.getString("agr_proposedactivity")));
				hshResult.put("txt_place",correctNull(rs2.getString("agr_place")));
				hshResult.put("txt_distance",correctNull(rs2.getString("agr_distance")));
				hshResult.put("txt_place1",correctNull(rs2.getString("agr_place1")));
				hshResult.put("txt_distance1",correctNull(rs2.getString("agr_distance1")));
				hshResult.put("sel_labour",correctNull(rs2.getString("agr_labour")));
				hshResult.put("txt_labourers",correctNull(rs2.getString("agr_labourers")));
				hshResult.put("txt_wage",correctNull(rs2.getString("agr_wage")));
				hshResult.put("txt_area",correctNull(rs2.getString("agr_area")));
				hshResult.put("txt_guntas",correctNull(rs2.getString("agr_guntas")));
				hshResult.put("txt_irrigation",correctNull(rs2.getString("agr_irrigation")));
				hshResult.put("txt_chandrika",correctNull(rs2.getString("agr_chandrika")));
				hshResult.put("txt_trays",correctNull(rs2.getString("agr_trays")));
				hshResult.put("txt_stand",correctNull(rs2.getString("agr_stand")));
				hshResult.put("txt_noeggs",correctNull(rs2.getString("agr_noeggs")));
				hshResult.put("txt_nocrops",correctNull(rs2.getString("agr_nocrops")));
				hshResult.put("txt_quantity",correctNull(rs2.getString("agr_quantity")));
				hshResult.put("txt_avgcost",correctNull(rs2.getString("agr_avgcost")));
				hshResult.put("txt_income",correctNull(rs2.getString("agr_income")));
				hshResult.put("auditFlag", "Y");
				
			}
			strQuery = SQLParser.getSqlQuery("agr_sel_serieconomics^"+appno);			
			rs2 =DBUtils.executeQuery(strQuery);
			while(rs2.next())
			{
				hshResult.put("txt_finval",correctNull(rs2.getString("agr_finval")));
				hshResult.put("txt_unit1",correctNull(rs2.getString("agr_unit1")));
				hshResult.put("txt_cost1",correctNull(rs2.getString("agr_cost1")));
				hshResult.put("txt_crop1",correctNull(rs2.getString("agr_crop1")));
				hshResult.put("txt_unit2",correctNull(rs2.getString("agr_unit2")));
				hshResult.put("txt_cost2",correctNull(rs2.getString("agr_cost2")));
				hshResult.put("txt_totamount1",correctNull(rs2.getString("agr_totamount1")));
				hshResult.put("txt_totamount2",correctNull(rs2.getString("agr_totamount2")));
				hshResult.put("txt_totalamount",correctNull(rs2.getString("agr_totalamount")));
				
				hshResult.put("txt_unit3",correctNull(rs2.getString("agr_unit3")));
				hshResult.put("txt_cost3",correctNull(rs2.getString("agr_cost3")));
				hshResult.put("txt_crop3",correctNull(rs2.getString("agr_crop3")));
				hshResult.put("txt_specify",correctNull(rs2.getString("agr_specify")));
				hshResult.put("txt_iyearincome1",correctNull(rs2.getString("agr_iyearincome1")));
				hshResult.put("txt_iiyearincome1",correctNull(rs2.getString("agr_iiyearincome1")));
				hshResult.put("txttotincomeiyear",correctNull(rs2.getString("agr_totincomeiyear")));
				hshResult.put("txt_totincomeiiyear",correctNull(rs2.getString("agr_totincomeiiyear")));
				hshResult.put("txt_totalincomeiyear",correctNull(rs2.getString("agr_totalincomeiyear")));
				hshResult.put("txt_totalincomeiiyear",correctNull(rs2.getString("agr_totalincomeiiyear")));
			}
			strQuery = SQLParser.getSqlQuery("agr_get_sheeploanamountdata^"+appno+"^"+prd_type);
			rs1 = DBUtils.executeQuery(strQuery);
			if (rs1.next()) 
			{
				hshResult.put("txt_totalamount", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_totalamount"))));
				hshResult.put("txt_margin", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_marginper"))));
				hshResult.put("txt_marginper", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_margin"))));
				hshResult.put("txt_subsidyper", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_subsidyper"))));
				hshResult.put("txt_subsidy", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_subsidy"))));
				hshResult.put("txt_totalloanamount1", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_totalloanamount"))));
				hshResult.put("txt_value1", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_value1"))));
				hshResult.put("txt_value2", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_value2"))));
				hshResult.put("txt_value3", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_value3"))));
				
			}
			
				 if (rs1 != null)
				    {
					rs1.close();
				    }
						 							 
			
			strQuery = SQLParser.getSqlQuery("agr_get_seriloanreqdata^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			
			ArrayList arryCol = new ArrayList();
			ArrayList arryRow = new ArrayList();
			while (rs.next())
			{
				arryCol = new ArrayList();
				arryCol.add(rs.getString("seqno"));
				arryCol.add(appno);
				arryCol.add(rs.getString("sno"));
				arryCol.add(rs.getString("seri_sq"));
				arryCol.add(rs.getString("seri_value"));
				arryCol.add(rs.getString("seri_specify"));
				arryCol.add(rs.getString("seri_unit"));
				arryCol.add(rs.getString("seri_cost"));
				arryCol.add(rs.getString("seri_amount"));
				arryRow.add(arryCol);
			}
			strQuery = SQLParser.getSqlQuery("agr_sel_bullockrepay^"+appno+ "^" +prd_type);			
			rs1 =DBUtils.executeQuery(strQuery);
			while(rs1.next())
			{
				hshResult.put("txt_roi",correctNull(rs1.getString("bullock_roi")));
				hshResult.put("txt_holiday",correctNull(rs1.getString("bullock_holiday")));
				hshResult.put("sel_payment",correctNull(rs1.getString("bullock_payment")));
				hshResult.put("txt_installment",correctNull(rs1.getString("bullock_installment")));
				hshResult.put("txt_date",correctNull(rs1.getString("bullock_date")));
				hshResult.put("txt_lastinstallment",correctNull(rs1.getString("bullock_lastinstallment")));
			}
			hshResult.put("appno", appno);
			hshResult.put("arryRow", arryRow);			
	
			return hshResult;
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData "+ce.toString());
		}
		finally 
		{
			try
			{
				if (rs != null) 
				{
					rs.close();
					rs = null;
				}
				 if (rs1 != null)
				    {
					rs1.close();
				    }
				 if (rs2 != null)
				    {
					rs2.close();
				    }
			}
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
	}
//sericulture loanreq
	public HashMap updateseriloanreq(HashMap hshValues) 
	{
		String strQuery = "";
		HashMap hshQueryValues = new HashMap();
		//HashMap hshQueryValues6 = new HashMap();
		HashMap hshpasValues = new HashMap();
		HashMap hshQuery = new HashMap();
		//HashMap hshQuery5 = new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null;
		String strAction = null;		
		//String strAction1 = null;	
		//String strAction2 = null;	
		HashMap hshResult = new HashMap();
		HashMap hshQuery4 = new HashMap();
		int intUpdatesize = 0;
		int f = 0;
		String strid = "", strQuery1 = "";
		String appno=correctNull((String)hshValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("strappno"));
		}
		strAction = correctNull((String) hshValues.get("hidAction"));
		//strAction1 = correctNull((String) hshValues.get("hidAction1"));
		//String  txt_totalamount = correctNull((String) hshValues.get("txt_totalamount"));
		//String  txt_marginper= correctNull((String) hshValues.get("txt_marginper"));
		//String  txt_subsidy= correctNull((String) hshValues.get("txt_subsidy"));
		//String  txt_margin= correctNull((String) hshValues.get("txt_margin"));
		//String  txt_subsidyper= correctNull((String) hshValues.get("txt_subsidyper"));
		//String  txt_totalloanamount1= correctNull((String) hshValues.get("txt_totalloanamount1"));
		//String  txt_totalloanamount= correctNull((String) hshValues.get("txt_totalloanamount"));
		//String  txt_value1= correctNull((String) hshValues.get("txt_value1"));
		//String  txt_value2= correctNull((String) hshValues.get("txt_value2"));
		//String  txt_value3= correctNull((String) hshValues.get("txt_value3"));
		String prd_type = correctNull((String)hshValues.get("strProductType"));
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = correctNull((String)hshValues.get("prd_type"));
		}
		try 
		{
			String[] txt_specify= null;
			String[]txt_unit = null;
			String[] txt_cost = null;
			String[] txt_amount= null;
			String[] txt_val = null;
			String[] txt_value= null;
			//String[] strdesc={"~Construction of rearing shed measuring = ","~Unit cost per acre*Area under cultivation = ",
			//		"~Requested Amount(Rs.)* (B) = ","~Least of (A& B)(Rs.) (C) = ","~Chandrika = ","~Trays = ","~Stand = "
				//	,"~Cost of Eggs(DFLs) = ","~Wages/Salary for = ","~ = "};;
			
			txt_specify= (String[]) hshValues.get("txt_specify");
			txt_unit= (String[]) hshValues.get("txt_unit");
			txt_cost= (String[]) hshValues.get("txt_cost");
			strid = correctNull((String) hshValues.get("hid_sno"));
			txt_amount = (String[]) hshValues.get("txt_amount");
			txt_val = (String[]) hshValues.get("txt_val");
			txt_value= (String[]) hshValues.get("txt_value");
			
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshResult.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
				hshResult.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
				hshResult.put("applicantid", rs.getString("demo_appid"));
			}
			if (strAction.equals("delete"))
			{
				hshQuery4 = new HashMap();
				HashMap hshQueryValues4 = new HashMap();
				ArrayList arrValues4 = new ArrayList();
				hshQueryValues4.put("size", "1");
				hshQuery4.put("strQueryId", "agr_del_seriloanreqdata");
				arrValues4.add(appno);
				hshQuery4.put("arrValues", arrValues4);
				hshQueryValues4.put("1", hshQuery4);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues4,"updateData");
			}
			/*if (strAction.equals("delete"))
			{
				hshQuery5 = new HashMap();
				HashMap hshQueryValues5 = new HashMap();
				ArrayList arrValues5 = new ArrayList();
				hshQueryValues5.put("size", "1");
				hshQuery5.put("strQueryId", "agr_del_sheeploanamountdata");
				arrValues5.add(appno);
				arrValues5.add(prd_type);
				hshQuery5.put("arrValues", arrValues5);
				hshQueryValues5.put("1", hshQuery5);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues5,"updateData");
			}*/
		
			/*if(strAction.equalsIgnoreCase("insert"))
			{
				hshQuery= new HashMap();
				ArrayList arrValues1 = new ArrayList();
				hshQuery.put("size", "2");
				hshQuery.put("strQueryId", "agr_del_sheeploanamountdata");
				arrValues1.add(appno);
				arrValues1.add(prd_type);
				hshQuery.put("arrValues",arrValues1);	
				hshQueryValues.put("1",hshQuery);
				hshQuery= new HashMap();
				arrValues1 = new ArrayList();
				arrValues1.add(appno);
				arrValues1.add(txt_totalamount);
				arrValues1.add(txt_marginper);
				arrValues1.add(txt_margin);
				arrValues1.add(txt_subsidyper);
				arrValues1.add(txt_subsidy);
				if(txt_totalloanamount1.equalsIgnoreCase(""))
				{
					arrValues1.add(txt_totalloanamount);	
				}
				else{
				arrValues1.add(txt_totalloanamount1);
					
				}
				if(txt_value1.equalsIgnoreCase(""))
				{
					arrValues1.add("");	
				}
				else{
				arrValues1.add(txt_value1);
				}
				if(txt_value2.equalsIgnoreCase(""))
				{
					arrValues1.add("");	
				}
				else{
				arrValues1.add(txt_value2);
				}
				if(txt_value3.equalsIgnoreCase(""))
				{
					arrValues1.add("");	
				}
				else{
				arrValues1.add(txt_value3);
				}
				arrValues1.add(prd_type);
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues1);
				hshQuery.put("strQueryId", "agr_ins_sheeploanamountdata");
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}*/
			
			if (strAction.equalsIgnoreCase("insert"))
			{
				HashMap hshQuery3 = new HashMap();
				ArrayList arrValues3 = new ArrayList();
				hshQuery3.put("size", "2");
				hshQuery3.put("strQueryId", "agr_del_seriloanreqdata");
				arrValues3.add(appno);
				hshQuery3.put("arrValues", arrValues3);
				strQuery1 = SQLParser.getSqlQuery("sel_maxid_seriloanreqdata");
				rs = DBUtils.executeQuery(strQuery1);
				if (rs.next())
				{
					strid = correctNull((String) rs.getString("maxid"));
					f = Integer.parseInt(strid);
				}
				intUpdatesize = 1;

				for (int i =0; i <= 10; i++)
				{					
					intUpdatesize = intUpdatesize + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "agr_ins_seriloanreqdata");
					arrValues.add(Integer.toString(f));
					arrValues.add(appno);
					arrValues.add(new Integer(i + 1).toString());
					if (correctNull(txt_val[i]).equals("")) 
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_val[i]));
					}
					if (correctNull(txt_value[i]).equals(""))
					{
						arrValues.add("");
					} 
					else 
					{
						arrValues.add(correctNull(txt_value[i]));
					}
					if (correctNull(txt_specify[i]).equals("")) 
					{
						arrValues.add("");
					}
					else 
					{
						arrValues.add(correctNull(txt_specify[i]));
					}
					if (correctNull(txt_unit[i]).equals(""))
					{
						arrValues.add("");
					} 
					else
					{
						arrValues.add(correctNull(txt_unit[i]));
					}
					if (correctNull(txt_cost[i]).equals(""))
					{
						arrValues.add("");
					} 
					else
					{
						arrValues.add(correctNull(txt_cost[i]));
					}
					if (correctNull(txt_amount[i]).equals(""))
					{
						arrValues.add("");
					} 
					else
					{
						arrValues.add(correctNull(txt_amount[i]));
					}
					hshQuery.put("arrValues", arrValues);
					f = f + 1;
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);					
				}
				for (int i =11; i<13; i++)
				{					
					intUpdatesize = intUpdatesize + 1;
					hshQuery = new HashMap();
					ArrayList arrValues4 = new ArrayList();
					hshQuery.put("strQueryId", "agr_ins_seriloanreqdata");
					arrValues4.add(Integer.toString(f));
					arrValues4.add(appno);
					arrValues4.add(new Integer(i + 1).toString());
					
						arrValues4.add("");
					
					
					if (correctNull(txt_value[i]).equals(""))
					{
						arrValues4.add("");
					} 
					else 
					{
						arrValues4.add(correctNull(txt_value[i]));
					}
					if (correctNull(txt_specify[i]).equals("")) 
					{
						arrValues4.add("");
					}
					else 
					{
						arrValues4.add(correctNull(txt_specify[i]));
					}
					if (correctNull(txt_unit[i]).equals(""))
					{
						arrValues4.add("");
					} 
					else
					{
						arrValues4.add(correctNull(txt_unit[i]));
					}
					if (correctNull(txt_cost[i]).equals(""))
					{
						arrValues4.add("");
					} 
					else
					{
						arrValues4.add(correctNull(txt_cost[i]));
					}
					if (correctNull(txt_amount[i]).equals(""))
					{
						arrValues4.add("");
					} 
					else
					{
						arrValues4.add(correctNull(txt_amount[i]));
					}
					hshQuery.put("arrValues", arrValues4);
					f = f + 1;
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);					
				}
				hshQueryValues.put("1", hshQuery3);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			
		StringBuilder sbAuditTrial=new StringBuilder();
			if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
			{
			 sbAuditTrial
				.append("~1) Construction of rearing shed measuring  = ")
				.append(correctNull(txt_val[0]))
				.append(" ")
				.append("sq ft @ Rs. = ")
				.append(correctNull(txt_value[0]))
				.append(" ")
				.append("per sq ft  ")
				.append("~No. of units = ")
				.append(correctNull(txt_unit[0]))
				.append("~Amount(Rs.) = ")
				.append(correctNull(txt_amount[0]))
				
				.append("~2)Cost of cultivation of mulberry  ^ ")
				.append("~a)Unit cost per acre*Area under cultivation (  ")
				.append(correctNull(txt_val[1]))
				.append(" * ")
				.append(correctNull(txt_value[1]))
				.append(" = ")
				.append("<b>")
				.append(correctNull(txt_specify[1]))
				.append(" )(A)  ")
				.append("</b>")
				.append("~Amount(Rs.) = ")
				.append(correctNull(txt_amount[1]))
				
				.append("~Requested Amount(Rs.) ^ ")
				.append(correctNull(txt_value[2]))
				.append("(B)")
				.append("~Least of (A&amp; B)(Rs.) = ")
				.append(correctNull(txt_value[3]))
				.append("(C)")
				
				.append("~3)Chandrika ^ ")
				.append("~No. of units = ")
				.append(correctNull(txt_unit[4]))
				.append("~Cost per unit(Rs.) = ")
				.append(correctNull(txt_cost[4]))
				.append("~Amount(Rs.) = ")
				.append(correctNull(txt_amount[4]))
				
				
				.append("~4)Trays ^ ")
				
				.append("~No. of units = ")
				.append(correctNull(txt_unit[5]))
				.append("~Cost per unit(Rs.) = ")
				.append(correctNull(txt_cost[5]))
				.append("~Amount(Rs.) = ")
				.append(correctNull(txt_amount[5]))
				
				.append("~5)Stand ^ ")
				
				.append("~No. of units = ")
				.append(correctNull(txt_unit[6]))
				.append("~Cost per unit(Rs.) = ")
				.append(correctNull(txt_cost[6]))
				.append("~Amount(Rs.) = ")
				.append(correctNull(txt_amount[6]))
				
				.append("~6) Cost of Eggs(DFLs) ^ ")
				
				.append("~No. of units = ")
				.append(correctNull(txt_unit[7]))
				.append("~Cost per unit(Rs.)  = ")
				.append(correctNull(txt_cost[7]))
				.append("~Amount(Rs.)  = ")
				.append(correctNull(txt_amount[7]))
				
				.append("~7)Wages/Salary for ")
				.append(" ")
				.append(correctNull(txt_specify[8]))
				.append(" ")
				.append("Months  ")
				.append("~Amount(Rs.) = ")
				.append(correctNull(txt_amount[8]))
				
				.append("~Others Specify ^")
				.append("~")
				.append(correctNull(txt_specify[9]))
				.append("~No. of units = ")
				.append(correctNull(txt_unit[9]))
				.append("~Cost per unit(Rs.) = ")
				.append(correctNull(txt_cost[9]))
				.append("~Amount(Rs.) = ")
				.append(correctNull(txt_amount[9]))
				
				.append("~")
				.append(correctNull(txt_specify[10]))
				.append("~No. of units = ")
				.append(correctNull(txt_unit[10]))
				.append("~Cost per unit(Rs.) = ")
				.append(correctNull(txt_cost[10]))
				.append("~Amount(Rs.) = ")
				.append(correctNull(txt_amount[10]))
				
				.append("~")
				.append(correctNull(txt_specify[11]))
				.append("~No. of units = ")
				.append(correctNull(txt_unit[11]))
				.append("~Cost per unit(Rs.) = ")
				.append(correctNull(txt_cost[11]))
				.append("~Amount(Rs.) = ")
				.append(correctNull(txt_amount[11]))
				
				.append("~")
				.append(correctNull(txt_specify[12]))
				.append("~No. of units = ")
				.append(correctNull(txt_unit[12]))
				.append("~Cost per unit(Rs.) = ")
				.append(correctNull(txt_cost[12]))
				.append("~Amount(Rs.) = ")
				.append(correctNull(txt_amount[12]))
				
				.append("~Total(Amount)(Rs.) = ")
				.append(Helper.correctNull((String)hshValues.get("txt_totalamount")));
			 if(correctNull((String)hshValues.get("hidAuditFlag")).equalsIgnoreCase("Y"))
			 {
				 hshValues.put("strAction", "update");
			 }
			 else
			 {
				 hshValues.put("strAction", "insert");
			 }
			}
			AuditTrial.auditLog(hshValues,"266",appno,sbAuditTrial.toString());
			
			hshpasValues.put("appno", appno);
			hshpasValues.put("prd_type", prd_type);
			hshResult = getseriloanreq(hshpasValues);
		}
		catch (Exception e)
		{
			throw new EJBException("Error in Insert Data " + e.getMessage());
		} 
		finally 
		{
			try 
			{
				if (rs != null) 
				{
					rs.close();
					rs = null;
				}
			} 
			catch (Exception e1) 
			{
				throw new EJBException("Error in closing Connection "+ e1.getMessage());
			}
		}
		return hshResult;
	}

	public  HashMap getseriloanreq(HashMap hshValues) 
	{
			ResultSet rs = null;
			ResultSet rs2 = null;
			ResultSet rs1 = null;
			String strQuery = "";
		HashMap hshResult = new HashMap();
		String prd_type = correctNull((String)hshValues.get("strProductType"));
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = correctNull((String)hshValues.get("prd_type"));
		}
		try
		{
			String appno	= correctNull((String )hshValues.get("appno"));	
			//String appno1 = correctNull((String)hshValues.get("appno1"));
			/*if(appno.equalsIgnoreCase(""))
			{
				appno=appno1;
			}	*/
			if(appno.equalsIgnoreCase(""))
			{
				appno = correctNull((String)hshValues.get("strappno"));
			}
			strQuery = SQLParser.getSqlQuery("agrlandmeasurement^"+appno);
			
			rs2= DBUtils.executeQuery(strQuery);
			if(rs2.next())
			{
				hshResult.put("land_measurement",correctNull(rs2.getString("land_measurement")));
			}
				
			strQuery = SQLParser.getSqlQuery("agr_sel_seritechdata^"+appno);			
			rs2 =DBUtils.executeQuery(strQuery);
			while(rs2.next())
			{
				hshResult.put("txt_mainoccupation",correctNull(rs2.getString("agr_mainoccupation")));
				hshResult.put("txt_subsidaryoccupation",correctNull(rs2.getString("agr_subsidaryoccupation")));
				hshResult.put("txt_proposedactivity",correctNull(rs2.getString("agr_proposedactivity")));
				hshResult.put("txt_place",correctNull(rs2.getString("agr_place")));
				hshResult.put("txt_distance",correctNull(rs2.getString("agr_distance")));
				hshResult.put("txt_place1",correctNull(rs2.getString("agr_place1")));
				hshResult.put("txt_distance1",correctNull(rs2.getString("agr_distance1")));
				hshResult.put("sel_labour",correctNull(rs2.getString("agr_labour")));
				hshResult.put("txt_labourers",correctNull(rs2.getString("agr_labourers")));
				hshResult.put("txt_wage",correctNull(rs2.getString("agr_wage")));
				hshResult.put("txt_area",correctNull(rs2.getString("agr_area")));
				hshResult.put("txt_guntas",correctNull(rs2.getString("agr_guntas")));
				hshResult.put("txt_irrigation",correctNull(rs2.getString("agr_irrigation")));
				hshResult.put("txt_chandrika",correctNull(rs2.getString("agr_chandrika")));
				hshResult.put("txt_trays",correctNull(rs2.getString("agr_trays")));
				hshResult.put("txt_stand",correctNull(rs2.getString("agr_stand")));
				hshResult.put("txt_noeggs",correctNull(rs2.getString("agr_noeggs")));
				hshResult.put("txt_nocrops",correctNull(rs2.getString("agr_nocrops")));
				hshResult.put("txt_quantity",correctNull(rs2.getString("agr_quantity")));
				hshResult.put("txt_avgcost",correctNull(rs2.getString("agr_avgcost")));
				hshResult.put("txt_income",correctNull(rs2.getString("agr_income")));
				
				
			}		
			
			strQuery = SQLParser.getSqlQuery("agr_get_sheeploanamountdata^"+appno+"^"+prd_type);
			rs1 = DBUtils.executeQuery(strQuery);
			if (rs1.next()) 
			{
				hshResult.put("txt_totalamount", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_totalamount"))));
				hshResult.put("txt_margin", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_marginper"))));
				hshResult.put("txt_marginper", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_margin"))));
				hshResult.put("txt_subsidyper", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_subsidyper"))));
				hshResult.put("txt_subsidy", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_subsidy"))));
				hshResult.put("txt_totalloanamount1", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_totalloanamount"))));
				hshResult.put("txt_value1", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_value1"))));
				hshResult.put("txt_value2", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_value2"))));
				hshResult.put("txt_value3", Helper.correctDoubleQuote(correctNull(rs1.getString("sheep_value3"))));
				
			}
			
				 if (rs1 != null)
				    {
					rs1.close();
				    }
						 							 
			
			strQuery = SQLParser.getSqlQuery("agr_get_seriloanreqdata^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			
			ArrayList arryCol = new ArrayList();
			ArrayList arryRow = new ArrayList();
			while (rs.next())
			{
				arryCol = new ArrayList();
				arryCol.add(rs.getString("seqno"));
				arryCol.add(appno);
				arryCol.add(rs.getString("sno"));
				arryCol.add(rs.getString("seri_sq"));
				arryCol.add(rs.getString("seri_value"));
				arryCol.add(rs.getString("seri_specify"));
				arryCol.add(rs.getString("seri_unit"));
				arryCol.add(rs.getString("seri_cost"));
				arryCol.add(rs.getString("seri_amount"));
				arryRow.add(arryCol);
				hshResult.put("auditFlag", "Y");
			}
			hshResult.put("appno", appno);
			hshResult.put("arryRow", arryRow);			
			if(rs!=null)rs.close();
			
			String strProdPurpose="";
			strQuery = SQLParser.getSqlQuery("selprodpurpose^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()){strProdPurpose=Helper.correctNull((String)rs.getString("prd_purpose"));}
			/*
			 * 			For Purchase of Ready Built House and Used Vehicle loan, 
			 * 				Margin is based on age of the building / vehicle respectively
			 */
			if(strProdPurpose.equalsIgnoreCase("H") || strProdPurpose.equalsIgnoreCase("U")) 
			{
				strQuery = SQLParser.getSqlQuery("pergetloanProductbymargin^" + appno);
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("pergetloanProduct^" + appno);
			}
			if(rs !=null)
			{
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshResult.put("REQUESTED_AMT",rs.getString("amtreqd"));
			}
			
			
			if(rs!=null)rs.close();
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getcoopsocMasterList "+ce.toString());
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
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());						
			}
		}
		return hshResult;
	}
//seri economics
	public void updateserieconomics(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery =  new HashMap();
		ArrayList arrValues=new ArrayList();
		String strAction=correctNull((String)hshValues.get("hidAction"));
		String appno=correctNull((String)hshValues.get("strappno"));
		if(appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("appno"));
		}
		//ResultSet rs = null;
		try
		{			
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","agr_del_serieconomics");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
	            hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				arrValues.add(correctNull((String) hshValues.get("txt_finval")));
				arrValues.add(correctNull((String) hshValues.get("txt_unit1")));
				arrValues.add(correctNull((String) hshValues.get("txt_cost1")));
				arrValues.add(correctNull((String) hshValues.get("txt_crop1")));
				arrValues.add(correctNull((String) hshValues.get("txt_unit2")));
				arrValues.add(correctNull((String) hshValues.get("txt_cost2")));
				arrValues.add(correctNull((String) hshValues.get("txt_totamount1")));
				arrValues.add(correctNull((String) hshValues.get("txt_totamount2")));
				arrValues.add(correctNull((String) hshValues.get("txt_totalamount")));
				
				
				arrValues.add(correctNull((String) hshValues.get("txt_unit3")));
				arrValues.add(correctNull((String) hshValues.get("txt_cost3")));
				arrValues.add(correctNull((String) hshValues.get("txt_crop3")));
				arrValues.add(correctNull((String) hshValues.get("txt_specify")));
				arrValues.add(correctNull((String) hshValues.get("txt_iyearincome1")));
				arrValues.add(correctNull((String) hshValues.get("txt_iiyearincome1")));
				arrValues.add(correctNull((String) hshValues.get("txt_totincomeiyear")));
				arrValues.add(correctNull((String) hshValues.get("txt_totincomeiiyear")));
				arrValues.add(correctNull((String) hshValues.get("txt_totalincomeiyear")));
				arrValues.add(correctNull((String) hshValues.get("txt_totalincomeiiyear")));
				arrValues.add(correctNull((String) hshValues.get("txt_disinfect1")));
				
					
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "agr_ins_serieconomics");
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","agr_del_serieconomics");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");  
			}			
			
			StringBuilder sbAuditTrial=new StringBuilder();
			if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
			{
			sbAuditTrial
		    .append("~ Recurring Expenses on cultivation of mulberry Crop Scale of Finance * Area under Cultivation = ( ^")
		    .append(" ")
		    .append(correctNull((String) hshValues.get("txt_finval")))
		    .append(" ")
		    .append("*")
		    .append(" ")
		    .append(correctNull((String) hshValues.get("txt_area")))
		    .append(")")
		    .append("~ I year Amount(Rs.) = ")
		    .append(correctNull((String) hshValues.get("txt_ibatchiyear")))
		    .append("~ II year (onwards) Amount(Rs.) = ")
		    .append(correctNull((String) hshValues.get("txt_ibatchiiyear")))
		    
		    .append(" ~ Cost of Eggs(DFLs)(No. of units of DFLs * Cost/unit of DFLs * No. of Crops/year) ( ^")
			.append(correctNull((String) hshValues.get("txt_unit1")))
			.append("*")
			.append(correctNull((String) hshValues.get("txt_cost1")))
			.append("*")
			.append(correctNull((String) hshValues.get("txt_crop1")))
			.append(" = ")
			.append(correctNull((String) hshValues.get("txt_amount1")))
			.append(" ) ")
			.append("~ I year Amount(Rs.) = ")
		    .append(correctNull((String) hshValues.get("txt_iibatchiyear")))
		    .append("~II year (onwards) Amount(Rs.)= ")
		    .append(correctNull((String) hshValues.get("txt_iibatchiiyear")))
		    
		    .append("~ Salary/Wages (No. of Employeess * Salary/Months * 12) ( ^")
		    .append(correctNull((String) hshValues.get("txt_unit2")))
		    .append("*")
		    .append(correctNull((String) hshValues.get("txt_cost2")))
		    .append("*")
		    .append("12")
		    .append("=")
		    .append(correctNull((String) hshValues.get("txt_amount2")))
		    .append(")")
		    .append("~I year Amount(Rs.) = ")
		    .append(correctNull((String) hshValues.get("txt_iiibatchiyear")))
		    .append("~II year (onwards) Amount(Rs.) = ")
		    .append(correctNull((String) hshValues.get("txt_iiibatchiiyear")))
		    
		    .append("~ Disinfection and other charges ^")
		    .append("~ I year Amount(Rs.) = ")
		    .append(correctNull((String) hshValues.get("txt_disinfect1")))
			.append("~II year (onwards) Amount(Rs.) = ")
			.append(correctNull((String) hshValues.get("txt_disinfect2")))
			
			.append("~ Total(Rs.) ^")
			.append("~ I year Amount(Rs.) = ")
			.append(correctNull((String) hshValues.get("txt_totamount1")))
			.append("~II year (onwards) Amount(Rs.) = ")
			.append(correctNull((String) hshValues.get("txt_totamount2")))
			
			.append("~ Income ^")
			.append("~ Anticipated production of cocoons( Production/crop * average rate per kg of cocoons * no. of crops/year )( ^")
			.append(correctNull((String) hshValues.get("txt_unit3")))
			.append("")
			.append("kgs*Rs.")
			.append("")
			.append(correctNull((String) hshValues.get("txt_cost3")))
			.append("*")
			.append(correctNull((String) hshValues.get("txt_crop3")))
			.append(")")
			.append("~I year Amount(Rs.) = ")
			.append(correctNull((String) hshValues.get("txt_iyearincome")))
			.append("~II year (onwards) Amount(Rs.) = ")
			.append(correctNull((String) hshValues.get("txt_iiyearincome")))
			
			.append("~Other Income ^")
			.append(correctNull((String) hshValues.get("txt_specify")))
			.append("~I year Amount(Rs.) = ")
			.append(correctNull((String) hshValues.get("txt_iyearincome1")))
			.append("~II year (onwards) Amount(Rs.) = ")
			.append(correctNull((String) hshValues.get("txt_iiyearincome1")))
			
			.append("~Total ^")
			.append("~I year Amount(Rs.)  = ")
			.append(correctNull((String) hshValues.get("txt_totincomeiyear")))
			.append("~II  year (onwards) Amount(Rs.) = ")
			.append(correctNull((String) hshValues.get("txt_totincomeiiyear")))
			
			.append("~Net Income(Rs.) ^")
			.append("~I year Amount(Rs.) = ")
			.append(correctNull((String) hshValues.get("txt_totalincomeiyear")))
			.append("~II year (onwards) Amount(Rs.) = ")
			.append(correctNull((String) hshValues.get("txt_totalincomeiiyear")));
			
			if(correctNull((String)hshValues.get("hidAuditFlag")).equalsIgnoreCase("Y"))
			{
				hshValues.put("strAction", "update");
			}
			else
			{
				hshValues.put("strAction", "insert");
			}
			}
			AuditTrial.auditLog(hshValues,"267",appno,sbAuditTrial.toString());
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
		}
	}

	public  HashMap getserieconomics(HashMap hshValues) 
	{		
		String strQuery="";
		ResultSet rs = null;
		ResultSet rs2 = null;
		HashMap hshResult = new HashMap();
		boolean flag = false;
		try
		{
			java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
			jtn.setMaximumFractionDigits(2);
			jtn.setMinimumFractionDigits(2);
			jtn.setGroupingUsed(false);
			String appno=correctNull((String)hshValues.get("strappno"));
			if(appno.equalsIgnoreCase(""))
			{
				appno = correctNull((String)hshValues.get("appno"));
			}
			strQuery = SQLParser.getSqlQuery("agr_sel_seritechdata^"+appno);			
			rs2 =DBUtils.executeQuery(strQuery);
			while(rs2.next())
			{
				hshResult.put("txt_mainoccupation",correctNull(rs2.getString("agr_mainoccupation")));
				hshResult.put("txt_subsidaryoccupation",correctNull(rs2.getString("agr_subsidaryoccupation")));
				hshResult.put("txt_proposedactivity",correctNull(rs2.getString("agr_proposedactivity")));
				hshResult.put("txt_place",correctNull(rs2.getString("agr_place")));
				hshResult.put("txt_distance",correctNull(rs2.getString("agr_distance")));
				hshResult.put("txt_place1",correctNull(rs2.getString("agr_place1")));
				hshResult.put("txt_distance1",correctNull(rs2.getString("agr_distance1")));
				hshResult.put("sel_labour",correctNull(rs2.getString("agr_labour")));
				hshResult.put("txt_labourers",correctNull(rs2.getString("agr_labourers")));
				hshResult.put("txt_wage",correctNull(rs2.getString("agr_wage")));
				hshResult.put("txt_area",correctNull(rs2.getString("agr_area")));
				hshResult.put("txt_guntas",correctNull(rs2.getString("agr_guntas")));
				hshResult.put("txt_irrigation",correctNull(rs2.getString("agr_irrigation")));
				hshResult.put("txt_chandrika",correctNull(rs2.getString("agr_chandrika")));
				hshResult.put("txt_trays",correctNull(rs2.getString("agr_trays")));
				hshResult.put("txt_stand",correctNull(rs2.getString("agr_stand")));
				hshResult.put("txt_noeggs",correctNull(rs2.getString("agr_noeggs")));
				hshResult.put("txt_nocrops",correctNull(rs2.getString("agr_nocrops")));
				hshResult.put("txt_quantity",correctNull(rs2.getString("agr_quantity")));
				hshResult.put("txt_avgcost",correctNull(rs2.getString("agr_avgcost")));
				hshResult.put("txt_income",correctNull(rs2.getString("agr_income")));
			}
				strQuery = SQLParser.getSqlQuery("agr_sel_serieconomics^"+appno);			
				rs2 =DBUtils.executeQuery(strQuery);
				while(rs2.next())
				{
					hshResult.put("txt_finval",correctNull(rs2.getString("agr_finval")));
					hshResult.put("txt_unit1",correctNull(rs2.getString("agr_unit1")));
					hshResult.put("txt_cost1",correctNull(rs2.getString("agr_cost1")));
					hshResult.put("txt_crop1",correctNull(rs2.getString("agr_crop1")));
					hshResult.put("txt_unit2",correctNull(rs2.getString("agr_unit2")));
					hshResult.put("txt_cost2",correctNull(rs2.getString("agr_cost2")));
					hshResult.put("txt_totamount1",correctNull(rs2.getString("agr_totamount1")));
					hshResult.put("txt_totamount2",correctNull(rs2.getString("agr_totamount2")));
					hshResult.put("txt_totalamount",correctNull(rs2.getString("agr_totalamount")));
					
					hshResult.put("txt_unit3",correctNull(rs2.getString("agr_unit3")));
					hshResult.put("txt_cost3",correctNull(rs2.getString("agr_cost3")));
					hshResult.put("txt_crop3",correctNull(rs2.getString("agr_crop3")));
					hshResult.put("txt_specify",correctNull(rs2.getString("agr_specify")));
					hshResult.put("txt_iyearincome1",correctNull(rs2.getString("agr_iyearincome1")));
					hshResult.put("txt_iiyearincome1",correctNull(rs2.getString("agr_iiyearincome1")));
					hshResult.put("txttotincomeiyear",correctNull(rs2.getString("agr_totincomeiyear")));
					hshResult.put("txt_totincomeiiyear",correctNull(rs2.getString("agr_totincomeiiyear")));
					hshResult.put("txt_totalincomeiyear",correctNull(rs2.getString("agr_totalincomeiyear")));
					hshResult.put("txt_totalincomeiiyear",correctNull(rs2.getString("agr_totalincomeiiyear")));
					hshResult.put("txt_disinfect1",correctNull(rs2.getString("agr_disinfection")));
					flag = true;
				}
				strQuery = SQLParser.getSqlQuery("agrlandmeasurement^"+appno);
				
				rs2= DBUtils.executeQuery(strQuery);
				if(rs2.next())
				{
					hshResult.put("land_measurement",correctNull(rs2.getString("land_measurement")));
				}
				strQuery = SQLParser.getSqlQuery("agr_get_seriloanreqdata^" + appno);
				rs = DBUtils.executeQuery(strQuery);
				
				ArrayList arryCol = new ArrayList();
				ArrayList arryRow = new ArrayList();
				while (rs.next())
				{
					arryCol = new ArrayList();
					arryCol.add(rs.getString("seqno"));
					arryCol.add(appno);
					arryCol.add(rs.getString("sno"));
					arryCol.add(rs.getString("seri_sq"));
					arryCol.add(rs.getString("seri_value"));
					arryCol.add(rs.getString("seri_specify"));
					arryCol.add(rs.getString("seri_unit"));
					arryCol.add(rs.getString("seri_cost"));
					arryCol.add(rs.getString("seri_amount"));
					arryRow.add(arryCol);
					flag = true;
				}
				if(flag == true)
				{
					hshResult.put("auditFlag", "Y");
				}
				hshResult.put("appno", appno);
				hshResult.put("arryRow", arryRow);			
				if(rs!=null)rs.close();
				strQuery = SQLParser.getSqlQuery("get_loanreq_eggDetails^" + appno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
				hshResult.put("seri_unit",rs.getString("seri_unit"));	
				hshResult.put("seri_cost",rs.getString("seri_cost"));
				}
				if(rs!=null)rs.close();
						    	
			return hshResult;
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
				if(rs2 != null)
				{
					rs2.close();
				}
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());						
			}
		}
	}
	//seri cashflow
	public void updatesericashflow(HashMap hshRequestValues) 
	{
		String appno=correctNull((String)hshRequestValues.get("appno"));
		//String productType=correctNull((String)hshRequestValues.get("strProductType"));
        String prd_type=correctNull((String)hshRequestValues.get("strProductType"));
		String txt_roi ="", txt_holiday="",sel_payment="",txt_installment="",txt_date="";
		String txt_lastinstallment="";
		
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno=correctNull((String)hshRequestValues.get("strappno"));
		}
		HashMap hshQueryValues = new HashMap();
		HashMap hshQueryValues1 = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();	
		ArrayList arrValues1 = new ArrayList();
		String[] loanamt = null;
		String[] intrate = null;
		String[] netinc = null;
		String[] principal = null;
		String[] netintamt = null;
		String[] outgoingamt = null;
		String[] surplusamt = null;
		String[] repayment = null;
		String[] txt_taxdedc = null;
		String[] txt_aftertax = null;
		String[] txt_depri = null;
		String[] txt_dscr = null;
		String strAction = correctNull((String)hshRequestValues.get("hidAction"));
		ResultSet rs = null;
		String strAction1 = correctNull((String)hshRequestValues.get("hidAction1"));
		int intUpdatesize = 0;
		try
		{		
			loanamt = (String[]) hshRequestValues.get("txt_loan");
			intrate = (String[])hshRequestValues.get("txt_int");
			netinc = (String[])hshRequestValues.get("txt_netinc");
			principal = (String[])hshRequestValues.get("txt_principal");
			netintamt = (String[])hshRequestValues.get("txt_netint");
			outgoingamt = (String[])hshRequestValues.get("txt_outgoing");
			surplusamt = (String[])hshRequestValues.get("txt_surplus");
			repayment = (String[])hshRequestValues.get("txt_repayment");
			txt_taxdedc = (String[])hshRequestValues.get("txt_taxdec");
			txt_aftertax = (String[])hshRequestValues.get("txt_aftertax");
			txt_depri= (String[])hshRequestValues.get("txt_depri");
			txt_dscr= (String[])hshRequestValues.get("txt_dscr");
		
			if(strAction.equalsIgnoreCase("insert"))
			{
				HashMap hshQuery3 = new HashMap();
				ArrayList arrValues3 = new ArrayList();
				hshQuery3.put("size", "1");
				hshQuery3.put("strQueryId", "del_poultrycashflow");
				arrValues3.add(appno);
				arrValues3.add(prd_type);
				hshQuery3.put("arrValues", arrValues3);
				hshQueryValues1.put("1", hshQuery3);
				hshQueryValues1.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
				
				intUpdatesize = 1;
				for (int i = 0; i < loanamt.length; i++)
				{
					intUpdatesize = intUpdatesize + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "ins_poultrycashflow");
					arrValues.add(appno);
					arrValues.add(Integer.toString(i+1));
					if(loanamt[i].equalsIgnoreCase(""))
					{
						loanamt[i] = "0.00";
					}
					arrValues.add(loanamt[i]);
					if(intrate[i].equalsIgnoreCase(""))
					{
						intrate[i] = "0.00";
					}
					arrValues.add(intrate[i]);
					if(netinc[i].equalsIgnoreCase(""))
					{
						netinc[i] = "0.00";
					}
					arrValues.add(netinc[i]);
					if(principal[i].equalsIgnoreCase(""))
					{
						principal[i] = "0.00";
					}
					arrValues.add(principal[i]);
					if(netintamt[i].equalsIgnoreCase(""))
					{
						netintamt[i] = "0.00";
					}	
					arrValues.add(netintamt[i]);
					if(outgoingamt[i].equalsIgnoreCase(""))
					{
						outgoingamt[i] = "0.00";
					}
					arrValues.add(outgoingamt[i]);
					if(surplusamt[i].equalsIgnoreCase(""))
					{
						surplusamt[i] = "0.00";
					}
					     arrValues.add(surplusamt[i]);
								
						if(repayment[i].equalsIgnoreCase(""))
						{
							repayment[i]="0.00";
						}
						arrValues.add(repayment[i]);
						arrValues.add(prd_type);
						if(txt_taxdedc[i].equalsIgnoreCase(""))
						{
							txt_taxdedc[i]="0.00";
						}
						arrValues.add(txt_taxdedc[i]);
						if(txt_aftertax[i].equalsIgnoreCase(""))
						{
							txt_aftertax[i]="0.00";
						}
						arrValues.add(txt_aftertax[i]);
						if(txt_depri[i].equalsIgnoreCase(""))
						{
							txt_depri[i]="0.00";
						}
						arrValues.add(txt_depri[i]);
						if(txt_dscr[i].equalsIgnoreCase(""))
						{
							txt_dscr[i]="0.00";
						}
						arrValues.add(txt_dscr[i]);
					hshQuery.put("arrValues", arrValues);	
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
			}
          if(strAction1.equalsIgnoreCase("insert1"))
				
			{
        	    arrValues1 = new ArrayList();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","agr_del_bullockrepay");
				arrValues1.add(appno);
				arrValues1.add(prd_type);
				hshQuery.put("arrValues",arrValues1);
				hshQueryValues.put("1",hshQuery);
	            hshQuery = new HashMap();
				arrValues1 = new ArrayList();
				arrValues1.add(appno);
				txt_roi= correctNull((String)hshRequestValues.get("txt_roi"));
				txt_holiday= correctNull((String)hshRequestValues.get("txt_holiday"));
				sel_payment= correctNull((String)hshRequestValues.get("sel_payment"));
				txt_installment = correctNull((String)hshRequestValues.get("txt_installment"));
				txt_date = correctNull((String)hshRequestValues.get("txt_date"));
				txt_lastinstallment= correctNull((String)hshRequestValues.get("txt_lastinstallment"));
				if(txt_roi.equalsIgnoreCase(""))
				{	
					txt_roi="0";
				}
				arrValues1.add(txt_roi);
				
				if(txt_holiday.equalsIgnoreCase(""))
				{	
					txt_holiday="0";
				}
				arrValues1.add(txt_holiday);
				
				if(sel_payment.equalsIgnoreCase(""))
				{	
					sel_payment ="1";
				}
				arrValues1.add(sel_payment);
									
				if(txt_installment.equalsIgnoreCase(""))
				{	
					txt_installment="0.00";
				}
				arrValues1.add(txt_installment);
				
				if(txt_date.equalsIgnoreCase(""))
				{	
					txt_date ="01/01/1900";
				}
				arrValues1.add(txt_date);
				if(txt_lastinstallment.equalsIgnoreCase(""))
				{	
					txt_lastinstallment ="0.00";
				}
				arrValues1.add(txt_lastinstallment);		
				arrValues1.add(prd_type);
				arrValues1.add("0");
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues1);
				hshQuery.put("strQueryId", "agr_ins_bullockrepay");
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				HashMap hshQuery3 = new HashMap();
				ArrayList arrValues3 = new ArrayList();
				hshQuery3.put("size", "1");
				hshQuery3.put("strQueryId", "del_poultrycashflow");
				arrValues3.add(appno);
				arrValues3.add(prd_type);
				hshQuery3.put("arrValues", arrValues3);
				hshQueryValues1.put("1", hshQuery3);
				hshQueryValues1.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
			}
			if(strAction1.equalsIgnoreCase("delete1"))
			{
				HashMap hshQuery3 = new HashMap();
				ArrayList arrValues3 = new ArrayList();
				hshQuery3.put("size", "1");
				hshQuery3.put("strQueryId","agr_del_bullockrepay");
				arrValues3.add(appno);
				arrValues3.add(prd_type);
				hshQuery3.put("arrValues", arrValues3);
				hshQueryValues1.put("1", hshQuery3);
				hshQueryValues1.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
			}
		}		
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
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

	public  HashMap getsericashflow(HashMap hshValues) 
	{
			ResultSet rs = null;
			ResultSet rs1 = null;ResultSet rs2 = null;
			String strQuery = "";
		HashMap hshRecord = new HashMap();
		//HashMap hshRecord1 = new HashMap();
		//HashMap hshRecordtmp = new HashMap();
		ArrayList vecRow = new ArrayList();
		ArrayList vecData = new ArrayList();
		boolean bstate =true;
		String prd_type = correctNull((String)hshValues.get("strProductType"));
		if(prd_type.equalsIgnoreCase("null") || prd_type.equalsIgnoreCase(""))
		{
			prd_type = correctNull((String)hshValues.get("prd_type"));
		}
		try
		{
			String appno	= correctNull((String )hshValues.get("appno"));	
			//String appno1 = correctNull((String)hshValues.get("appno1"));
			/*if(appno.equalsIgnoreCase(""))
			{
				appno=appno1;
			}*/	
			if(appno.equalsIgnoreCase(""))
			{
				appno = correctNull((String)hshValues.get("strappno"));
			}
			
				
			strQuery = SQLParser.getSqlQuery("sel_poultrycashflow^" + appno+"^"+prd_type);
			rs = DBUtils.executeQuery(strQuery);
			rs1 = DBUtils.executeQuery(strQuery);
			bstate = rs1.next();
			if(bstate == true)
			{
				while(rs.next())
				{
					vecRow = new ArrayList();
					vecRow.add(correctNull((String)rs.getString("appno")));
					if(correctNull((String)rs.getString("loan_begin")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull((String)rs.getString("loan_begin")));
					}
					if(correctNull((String)rs.getString("interest")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull((String)rs.getString("interest")));
					}
					if(correctNull((String)rs.getString("netincome")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull((String)rs.getString("netincome")));
					}
					if(correctNull((String)rs.getString("principalamt")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull((String)rs.getString("principalamt")));
					}
					if(correctNull((String)rs.getString("netintamt")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull((String)rs.getString("netintamt")));
					}
					if(correctNull((String)rs.getString("outgoingamt")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull((String)rs.getString("outgoingamt")));
					}
					if(correctNull((String)rs.getString("surplusamt")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull((String)rs.getString("surplusamt")));
					}
					if(correctNull((String)rs.getString("repayment")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull((String)rs.getString("repayment")));
					}
					if(correctNull((String)rs.getString("taxdedc")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull((String)rs.getString("taxdedc")));
					} 
					if(correctNull((String)rs.getString("netprofit")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull((String)rs.getString("netprofit")));
					}
					if(correctNull((String)rs.getString("depriciation")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull((String)rs.getString("depriciation")));
					}
					if(correctNull((String)rs.getString("dscr")).equalsIgnoreCase("0.00"))
					{
						vecRow.add("");
					}
					else
					{
						vecRow.add(correctNull((String)rs.getString("dscr")));
					} 
					vecData.add(vecRow);
				}
			}
			else
			{
				for(int i=0; i<13; i++)
				{
					vecRow = new ArrayList();
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecRow.add("");
					vecData.add(vecRow);
				}
			}
				hshRecord.put("vecData", vecData);
				strQuery = SQLParser.getSqlQuery("agr_sel_serieconomics^"+appno);			
				rs2 =DBUtils.executeQuery(strQuery);
				while(rs2.next())
				{
					hshRecord.put("txt_finval",correctNull(rs2.getString("agr_finval")));
					hshRecord.put("txt_unit1",correctNull(rs2.getString("agr_unit1")));
					hshRecord.put("txt_cost1",correctNull(rs2.getString("agr_cost1")));
					hshRecord.put("txt_crop1",correctNull(rs2.getString("agr_crop1")));
					hshRecord.put("txt_unit2",correctNull(rs2.getString("agr_unit2")));
					hshRecord.put("txt_cost2",correctNull(rs2.getString("agr_cost2")));
					hshRecord.put("txt_totamount1",correctNull(rs2.getString("agr_totamount1")));
					hshRecord.put("txt_totamount2",correctNull(rs2.getString("agr_totamount2")));
					hshRecord.put("txt_totalamount",correctNull(rs2.getString("agr_totalamount")));
					
					hshRecord.put("txt_unit3",correctNull(rs2.getString("agr_unit3")));
					hshRecord.put("txt_cost3",correctNull(rs2.getString("agr_cost3")));
					hshRecord.put("txt_crop3",correctNull(rs2.getString("agr_crop3")));
					hshRecord.put("txt_specify",correctNull(rs2.getString("agr_specify")));
					hshRecord.put("txt_iyearincome1",correctNull(rs2.getString("agr_iyearincome1")));
					hshRecord.put("txt_iiyearincome1",correctNull(rs2.getString("agr_iiyearincome1")));
					hshRecord.put("txttotincomeiyear",correctNull(rs2.getString("agr_totincomeiyear")));
					hshRecord.put("txt_totincomeiiyear",correctNull(rs2.getString("agr_totincomeiiyear")));
					hshRecord.put("txt_totalincomeiyear",correctNull(rs2.getString("agr_totalincomeiyear")));
					hshRecord.put("txt_totalincomeiiyear",correctNull(rs2.getString("agr_totalincomeiiyear")));
				}
			
			strQuery = SQLParser.getSqlQuery("agr_sel_bullockrepay^"+appno+ "^" +prd_type);			
			rs1 =DBUtils.executeQuery(strQuery);
			while(rs1.next())
			{
				hshRecord.put("txt_roi",correctNull(rs1.getString("bullock_roi")));
				hshRecord.put("txt_holiday",correctNull(rs1.getString("bullock_holiday")));
				hshRecord.put("sel_payment",correctNull(rs1.getString("bullock_payment")));
				hshRecord.put("txt_installment",correctNull(rs1.getString("bullock_installment")));
				hshRecord.put("txt_date",correctNull(rs1.getString("bullock_date")));
				hshRecord.put("txt_lastinstallment",correctNull(rs1.getString("bullock_lastinstallment")));
			}
					
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getcoopsocMasterList "+ce.toString());
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
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());						
			}
		}
		return hshRecord;
	}
	//plantation tech aspects

	public void updateplantationtechdata(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery =  new HashMap();
		ArrayList arrValues=new ArrayList();
		String strAction=correctNull((String)hshValues.get("hidAction"));
		String appno=correctNull((String)hshValues.get("strappno"));
		if(appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String)hshValues.get("appno"));
		}
		ResultSet rs = null;
		try
		{			
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues.put("size","2");
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","agr_del_plantation_tech");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
	            hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				String sel_export=correctNull((String) hshValues.get("sel_export"));
				if(sel_export.equalsIgnoreCase(""))
				{
					sel_export="0";
				}
				arrValues.add(sel_export);
				arrValues.add(correctNull((String) hshValues.get("txt_distanceexp")));
				String sel_local=correctNull((String) hshValues.get("sel_local"));
				if(sel_local.equalsIgnoreCase(""))
				{
					sel_local="0";
				}
				arrValues.add(sel_local);
				arrValues.add(correctNull((String) hshValues.get("txt_distanceloc")));
				String sel_state=correctNull((String) hshValues.get("sel_state"));
				if(sel_state.equalsIgnoreCase(""))
				{
					sel_state="0";
				}
				arrValues.add(sel_state);
				
				arrValues.add(correctNull((String) hshValues.get("txt_distancestate")));
				String sel_demand=correctNull((String) hshValues.get("sel_demand"));
				if(sel_demand.equalsIgnoreCase(""))
				{
					sel_demand="0";
				}
				arrValues.add(sel_demand);
				arrValues.add(correctNull((String) hshValues.get("txt_source")));
					
				hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "agr_ins_plantation_tech");
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues.put("size","1");
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","agr_del_plantation_tech");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");  
			}	
			
			StringBuilder sbAuditTrial=new StringBuilder();
			if (strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update")) {
			sbAuditTrial
				.append("~Backward & Forward Linkages:What are the arrangements/Linkages made? ^ ")
				
				.append("~Any Export tie-up of Production = ")
				.append(SetupParams.getSetupParams("SAABranch",correctNull((String )hshValues.get("sel_export"))));
				if(correctNull((String )hshValues.get("sel_export")).equalsIgnoreCase("1"))
				{
				sbAuditTrial
				.append("~Pick-up point at  = ")
				.append(correctNull((String) hshValues.get("txt_distanceexp")))
				.append("(Km) from place of production.");
				}
				sbAuditTrial
				.append("~Any Local market tie up from place of production = ")
				.append(SetupParams.getSetupParams("SAABranch",correctNull((String )hshValues.get("sel_local"))));
				if(correctNull((String )hshValues.get("sel_local")).equalsIgnoreCase("1"))
				{
					sbAuditTrial
				.append("~Pick-up point at  = ")
				.append(correctNull((String) hshValues.get("txt_distanceloc")))
				.append("(Km) from place of production.");
				}
				sbAuditTrial
				.append("~Out of state tie-up = ")
				.append(SetupParams.getSetupParams("SAABranch",correctNull((String )hshValues.get("sel_state"))));
				if(correctNull((String )hshValues.get("sel_state")).equalsIgnoreCase("1"))
				{
					sbAuditTrial
				.append("~Pick-up point at  = ")
				.append(correctNull((String) hshValues.get("txt_distancestate")))
				.append("(Km)");
				}
				sbAuditTrial
				.append("~Any Data on Demand & Supply of concerned crop produce and timing of release of produce to market form cold storage = ")
				.append(SetupParams.getSetupParams("SAABranch",correctNull((String )hshValues.get("sel_demand"))))
				;
				if(correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("Y"))
				{
					hshValues.put("strAction", "update");
				}
			}
				AuditTrial.auditLog(hshValues,"269",appno,sbAuditTrial.toString());
		}
			
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
		}
		finally 
		{
			try 
			{
				if (rs != null) 
				{
					rs.close();
					rs = null;
				}
			} 
			catch (Exception e1) 
			{
				throw new EJBException("Error in closing Connection "+ e1.getMessage());
			}
		}
	}

	public  HashMap getplantationtechdata(HashMap hshValues) 
	{		
		String strQuery="";
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		HashMap hshResult = new HashMap();	
		String recordflag="N";
		try
		{
			java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
			jtn.setMaximumFractionDigits(2);
			jtn.setMinimumFractionDigits(2);
			jtn.setGroupingUsed(false);
			String appno=correctNull((String)hshValues.get("strappno"));
			if(appno.equalsIgnoreCase(""))
			{
				appno = correctNull((String)hshValues.get("appno"));
			}
			strQuery = SQLParser.getSqlQuery("agrlandmeasurement^"+appno);
			rs2 = DBUtils.executeQuery(strQuery);
			if(rs2.next())
			{
				hshResult.put("land_measurement",correctNull(rs2.getString("land_measurement")));
			}
			strQuery = SQLParser.getSqlQuery("agr_sel_plantation_tech^"+appno);			
			rs2 =DBUtils.executeQuery(strQuery);
			while(rs2.next())
			{
				recordflag="Y";
				hshResult.put("sel_export",correctNull(rs2.getString("agr_export")));
				hshResult.put("txt_distanceexp",correctNull(rs2.getString("agr_distanceexp")));
				hshResult.put("sel_local",correctNull(rs2.getString("agr_local")));
				hshResult.put("txt_distanceloc",correctNull(rs2.getString("agr_distanceloc")));
				hshResult.put("sel_state",correctNull(rs2.getString("agr_state")));
				hshResult.put("txt_distancestate",correctNull(rs2.getString("agr_distancestate")));
				hshResult.put("sel_demand",correctNull(rs2.getString("agr_demand")));
				hshResult.put("txt_source",correctNull(rs2.getString("agr_source")));
				hshResult.put("recordflag",recordflag);
			}		    	
			return hshResult;
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData "+ce.toString());
		}
		finally 
		{
			try 
			{
				if (rs1 != null) 
				{
					rs1.close();
				}
				if (rs2 != null) 
				{
					rs2.close();
				}
			} 
			catch (Exception e1) 
			{
				throw new EJBException("Error in closing Connection "+ e1.getMessage());
			}
		}
	}
}