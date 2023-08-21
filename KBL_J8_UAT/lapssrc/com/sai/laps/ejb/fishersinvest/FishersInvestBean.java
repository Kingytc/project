package com.sai.laps.ejb.fishersinvest;

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

@Stateless(name = "FishersInvestBean", mappedName = "FishersInvestHome")
@Remote (FishersInvestRemote.class)
public class FishersInvestBean extends BeanAdapter
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public  HashMap getfishersinvest(HashMap hshValues) 
	{
		String strQuery="";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		HashMap hshScheme = new HashMap();
		ArrayList vecData = new ArrayList();
		ArrayList vecVal=new ArrayList();
		String appno=Helper.correctNull((String)hshValues.get("appno"));
		String strschemetype="",strfacsno="",stragrschemetype="";
		try
		{
			if(appno.equalsIgnoreCase(""))
			{
				appno=Helper.correctNull((String)hshValues.get("strAppno"));
			}
			strschemetype	= Helper.correctNull((String )hshValues.get("schemetype"));	
			hshScheme = Helper.splitScheme(strschemetype);
			if(hshScheme!=null)
			{
				strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
				stragrschemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
			}
			
			for(int i=1;i<7;i++)
			{
				vecVal = new ArrayList();
				strQuery = SQLParser.getSqlQuery("selagrfishinvest^"+appno+"^"+i+"^"+strfacsno+"^"+stragrschemetype);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{	
					vecVal.add(correctNull(rs.getString(1)));
					vecVal.add(correctNull(rs.getString(2)));
					vecVal.add(correctNull(rs.getString(3)));
					vecVal.add(correctNull(rs.getString(4)));
					vecData.add(vecVal);							
				}
			}
		hshRecord.put("vecData",vecData);
		if(rs != null)
		{
			rs.close();
			rs=null;
		}
		strQuery = SQLParser.getSqlQuery("selagrfishother^"+appno+"^"+strfacsno+"^"+stragrschemetype);
		rs=DBUtils.executeQuery(strQuery);
		
		if(rs.next())
		{	
			hshRecord.put("ownership_type",correctNull(rs.getString("ownership_type")));
			hshRecord.put("lease_period",correctNull(rs.getString("lease_period")));
			hshRecord.put("tank_length",correctNull(rs.getString("tank_length")));
			hshRecord.put("tank_breath",correctNull(rs.getString("tank_breath")));
			hshRecord.put("tank_debth",correctNull(rs.getString("tank_debth")));
			hshRecord.put("normal_water_level",correctNull(rs.getString("normal_water_level")));
			hshRecord.put("summar_water_level",correctNull(rs.getString("summar_water_level")));
			hshRecord.put("boat_type",correctNull(rs.getString("boat_type")));
			hshRecord.put("boat_length",correctNull(rs.getString("boat_length")));
			hshRecord.put("boat_breath",correctNull(rs.getString("boat_breath")));
			hshRecord.put("boat_catch_capacity",correctNull(rs.getString("boat_catch_capacity")));
			hshRecord.put("tank_rent_year",correctNull(rs.getString("tank_rent_year")));
			
		}
			if(rs!=null)
			{
				rs.close();
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


	public HashMap updatefishersinvest(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		HashMap hshScheme = new HashMap();
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String appno=correctNull((String)hshValues.get("appno"));
		String strschemetype="",strfacsno="",stragrschemetype="";
		//appno="ANBR0000009";
		HashMap hshValuesAgri = new HashMap();
		HashMap hshPhysical = new HashMap();
		try
		{
			if(appno.equalsIgnoreCase(""))
			{
				appno=Helper.correctNull((String)hshValues.get("strAppno"));
			}
			strschemetype	= Helper.correctNull((String )hshValues.get("schemetype"));	
			hshScheme = Helper.splitScheme(strschemetype);
			if(hshScheme!=null)
			{
				strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
				stragrschemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
			}
			
		   if(strAction.equals("insert"))
			{
			   hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","delagrfishinvest");
				arrValues.add(appno);
				arrValues.add(strfacsno);
				arrValues.add(stragrschemetype);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();				
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","delagrfishother");
				arrValues.add(appno);
				arrValues.add(strfacsno);
				arrValues.add(stragrschemetype);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshQueryValues = new HashMap();
							
				int intUpdateSize=0;
				for(int i=1;i<7;i++)
				{
				hshQuery = new HashMap();		
				arrValues=new ArrayList();
				intUpdateSize++;
				hshQuery.put("strQueryId","insagrfishinvest");
				arrValues.add(appno);
				arrValues.add(Integer.toString(i));
				arrValues.add(correctNull((String )hshValues.get("txt_type"+i)));
				arrValues.add(correctNull((String )hshValues.get("txt_cost"+i)));
				arrValues.add(correctNull((String )hshValues.get("txt_margin"+i)));
				arrValues.add(correctNull((String )hshValues.get("txt_loan"+i)));
				arrValues.add(strfacsno);
				arrValues.add(stragrschemetype);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);	
				}
				hshQuery = new HashMap();		
				arrValues=new ArrayList();
				intUpdateSize++;
				hshQuery.put("strQueryId","insagrfishother");
				arrValues.add(appno);
				arrValues.add(correctNull((String )hshValues.get("sel_type")));
				arrValues.add(correctNull((String )hshValues.get("txt_lease")));
				arrValues.add(correctNull((String )hshValues.get("txt_lengthtank")));
				arrValues.add(correctNull((String )hshValues.get("txt_breathtank")));
				arrValues.add(correctNull((String )hshValues.get("txt_depthtank")));
				arrValues.add(correctNull((String )hshValues.get("txt_normaltank")));
				arrValues.add(correctNull((String )hshValues.get("txt_summertank")));
				arrValues.add(correctNull((String )hshValues.get("sel_boattype")));
				arrValues.add(correctNull((String )hshValues.get("txt_lengthboat")));
				arrValues.add(correctNull((String )hshValues.get("txt_breathboat")));
				arrValues.add(correctNull((String )hshValues.get("txt_capacityboat")));
				arrValues.add(correctNull((String )hshValues.get("txt_rent")));
				arrValues.add(strfacsno);
				arrValues.add(stragrschemetype);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);	
				
				hshQueryValues.put("size",Integer.toString(intUpdateSize));
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				// For inserting in Physical and Financial Programme by Arsath on 05/03/2014
				String strTypeone	=	Helper.correctNull((String )hshValues.get("txt_type"+1));
				String strTypetwo	=	Helper.correctNull((String )hshValues.get("txt_type"+2));
				String strTypetwonew = "";
				String strTypethree	=	Helper.correctNull((String )hshValues.get("txt_type"+3));
				String strTypethreenew = "";
				if((strTypeone.equalsIgnoreCase("1")) || (strTypeone.equalsIgnoreCase("2")))
				{
				hshPhysical.put("scheme_sno",strTypeone);	
				hshPhysical.put("scheme_type", strschemetype);
				hshPhysical.put("total_cost",correctNull((String )hshValues.get("txt_estimatecost")));
				hshPhysical.put("hidAction", "insert");
				hshPhysical.put("appno",appno);
				hshPhysical.put("page_id","FI");
				hshPhysical.put("plant_sno", "");
				hshValuesAgri = (HashMap) EJBInvoker.executeStateLess("agrlandholdings", hshPhysical, "updatePhysicalProgramme");
				}
				if((strTypetwo.equalsIgnoreCase("1")) || (strTypetwo.equalsIgnoreCase("2")))
				{
				if(strTypetwo.equalsIgnoreCase("1"))
				{
					strTypetwonew = "3";
				}
				else
				{
					strTypetwonew = "4";
				}
				hshPhysical.put("scheme_sno",strTypetwonew);	
				hshPhysical.put("scheme_type", stragrschemetype);
				hshPhysical.put("total_cost",correctNull((String )hshValues.get("txt_estimatecost")));
				hshPhysical.put("hidAction", "insert");
				hshPhysical.put("appno",appno);
				hshPhysical.put("page_id","FI");
				hshPhysical.put("plant_sno", "");
				hshValuesAgri = (HashMap) EJBInvoker.executeStateLess("agrlandholdings", hshPhysical, "updatePhysicalProgramme");
				}
				if((strTypethree.equalsIgnoreCase("1")) || (strTypethree.equalsIgnoreCase("2")))
				{
				if(strTypethree.equalsIgnoreCase("1"))
				{
					strTypethreenew = "5";
				}
				else
				{
					strTypethreenew = "6";
				}
				hshPhysical.put("scheme_sno",strTypethreenew);	
				hshPhysical.put("scheme_type", stragrschemetype);
				hshPhysical.put("total_cost",correctNull((String )hshValues.get("txt_estimatecost")));
				hshPhysical.put("hidAction", "insert");
				hshPhysical.put("appno",appno);
				hshPhysical.put("page_id","FI");
				hshPhysical.put("plant_sno", "");
				hshValuesAgri = (HashMap) EJBInvoker.executeStateLess("agrlandholdings", hshPhysical, "updatePhysicalProgramme");
				}
				
				
				
			}
			else if(strAction.equals("delete"))
			{
				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();	
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","delagrfishinvest");
				arrValues.add(appno);
				arrValues.add(strfacsno);
				arrValues.add(stragrschemetype);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();			
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","delagrfishother");
				arrValues.add(appno);
				arrValues.add(strfacsno);
				arrValues.add(stragrschemetype);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
			}else  if(strAction.equals("update"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","delagrfishinvest");
				arrValues.add(appno);
				arrValues.add(strfacsno);
				arrValues.add(stragrschemetype);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();		
				ArrayList arrValues1=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","delagrfishother");
				arrValues1.add(appno);
				arrValues1.add(strfacsno);
				arrValues1.add(stragrschemetype);
				hshQuery.put("arrValues",arrValues1);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshQueryValues = new HashMap();
				
				int intUpdateSize=0;
				for(int i=1;i<7;i++)
				{
				hshQuery = new HashMap();		
				arrValues=new ArrayList();
				intUpdateSize++;
				hshQuery.put("strQueryId","insagrfishinvest");
				arrValues.add(appno);
				arrValues.add(Integer.toString(i));
				arrValues.add(correctNull((String )hshValues.get("txt_type"+i)));
				arrValues.add(correctNull((String )hshValues.get("txt_cost"+i)));
				arrValues.add(correctNull((String )hshValues.get("txt_margin"+i)));
				arrValues.add(correctNull((String )hshValues.get("txt_loan"+i)));
				arrValues.add(strfacsno);
				arrValues.add(stragrschemetype);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);	
				}
				
				hshQuery = new HashMap();		
				arrValues=new ArrayList();
				intUpdateSize++;
				hshQuery.put("strQueryId","insagrfishother");
				arrValues.add(appno);
				arrValues.add(correctNull((String )hshValues.get("sel_type")));
				arrValues.add(correctNull((String )hshValues.get("txt_lease")));
				arrValues.add(correctNull((String )hshValues.get("txt_lengthtank")));
				arrValues.add(correctNull((String )hshValues.get("txt_breathtank")));
				arrValues.add(correctNull((String )hshValues.get("txt_depthtank")));
				arrValues.add(correctNull((String )hshValues.get("txt_normaltank")));
				arrValues.add(correctNull((String )hshValues.get("txt_summertank")));
				arrValues.add(correctNull((String )hshValues.get("sel_boattype")));
				arrValues.add(correctNull((String )hshValues.get("txt_lengthboat")));
				arrValues.add(correctNull((String )hshValues.get("txt_breathboat")));
				arrValues.add(correctNull((String )hshValues.get("txt_capacityboat")));
				arrValues.add(correctNull((String )hshValues.get("txt_rent")));
				arrValues.add(strfacsno);
				arrValues.add(stragrschemetype);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);	
				
			
				hshQueryValues.put("size",Integer.toString(intUpdateSize));
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				// For inserting in Physical and Financial Programme by Arsath on 05/03/2014
				String strTypeone	=	Helper.correctNull((String )hshValues.get("txt_type"+1));
				String strTypetwo	=	Helper.correctNull((String )hshValues.get("txt_type"+2));
				String strTypetwonew = "";
				String strTypethree	=	Helper.correctNull((String )hshValues.get("txt_type"+3));
				String strTypethreenew = "";
				if((strTypeone.equalsIgnoreCase("1")) || (strTypeone.equalsIgnoreCase("2")))
				{
				hshPhysical.put("scheme_sno",strTypeone);	
				hshPhysical.put("scheme_type", strschemetype);
				hshPhysical.put("total_cost",correctNull((String )hshValues.get("txt_estimatecost")));
				hshPhysical.put("hidAction", "insert");
				hshPhysical.put("appno",appno);
				hshPhysical.put("page_id","FI");
				hshPhysical.put("plant_sno", "");
				hshValuesAgri = (HashMap) EJBInvoker.executeStateLess("agrlandholdings", hshPhysical, "updatePhysicalProgramme");
				}
				if((strTypetwo.equalsIgnoreCase("1")) || (strTypetwo.equalsIgnoreCase("2")))
				{
				if(strTypetwo.equalsIgnoreCase("1"))
				{
					strTypetwonew = "3";
				}
				else
				{
					strTypetwonew = "4";
				}
				hshPhysical.put("scheme_sno",strTypetwonew);	
				hshPhysical.put("scheme_type", strschemetype);
				hshPhysical.put("total_cost",correctNull((String )hshValues.get("txt_estimatecost")));
				hshPhysical.put("hidAction", "insert");
				hshPhysical.put("appno",appno);
				hshPhysical.put("page_id","FI");
				hshPhysical.put("plant_sno", "");
				hshValuesAgri = (HashMap) EJBInvoker.executeStateLess("agrlandholdings", hshPhysical, "updatePhysicalProgramme");
				}
				if((strTypethree.equalsIgnoreCase("1")) || (strTypethree.equalsIgnoreCase("2")))
				{
				if(strTypethree.equalsIgnoreCase("1"))
				{
					strTypethreenew = "5";
				}
				else
				{
					strTypethreenew = "6";
				}
				hshPhysical.put("scheme_sno",strTypethreenew);	
				hshPhysical.put("scheme_type", strschemetype);
				hshPhysical.put("total_cost",correctNull((String )hshValues.get("txt_estimatecost")));
				hshPhysical.put("hidAction", "insert");
				hshPhysical.put("appno",appno);
				hshPhysical.put("page_id","FI");
				hshPhysical.put("plant_sno", "");
				hshValuesAgri = (HashMap) EJBInvoker.executeStateLess("agrlandholdings", hshPhysical, "updatePhysicalProgramme");
				}
				
				
			}
		   
		   StringBuilder sbAuditTrial=new StringBuilder();
		   if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
		   {
		   String strdesc[]={"Tank","Boats","Net, Twins, Floats etc","Fingerlings","Fish Feed","Maintanence & Other Charges"};
		   String strtext[]={"_text","_text","_text","","",""};
		   for(int i=1;i<7;i++)
			{
			sbAuditTrial
			.append("~Particulars  ^")
					.append("~"+strdesc[i-1])
					.append(" ")
					.append("Type = ")
				    .append(correctNull((String )hshValues.get("txt_type"+i+strtext[i-1])));
			if(i==1)
			{
				if(!(correctNull((String )hshValues.get("txt_type"+1)).equalsIgnoreCase("3")))
				{
					sbAuditTrial
					 .append("~Tank Parameters ^ ")
					   .append("~Type of ownership = ")
					   .append(correctNull((String )hshValues.get("sel_type_text")));
					
					   if(!(correctNull((String )hshValues.get("sel_type")).equalsIgnoreCase("3")))
					   {
						   sbAuditTrial
						   .append("~Agreement Period = ")
						   .append(correctNull((String )hshValues.get("txt_lease")))
						   .append("(yrs),")
						   .append("~Rent/Year = ")
						   .append(correctNull((String)hshValues.get("txt_rent")));
					   }
					   sbAuditTrial
					   .append("~Length = ")
					   .append(correctNull((String )hshValues.get("txt_lengthtank")))
					   .append(" ")
					   .append("Level of Water")
					   .append("~Breath = ")
					   .append(correctNull((String )hshValues.get("txt_breathtank")))
					   .append("~Normal Days = ")
					   .append(correctNull((String )hshValues.get("txt_normaltank")))
					   .append("~Depth = ")
					   .append(correctNull((String )hshValues.get("txt_depthtank")))
					   .append("~Summer Days = ")
					   .append(correctNull((String )hshValues.get("txt_summertank")));
				}
			}
			else if(i==2)
			{
				
				if(!(correctNull((String )hshValues.get("txt_type"+2)).equalsIgnoreCase("3")))
				{
					sbAuditTrial
					   .append("~Boat Parameters ^")
					   .append("~Purpose of Boat Loan = ")
					   .append(correctNull((String )hshValues.get("sel_boattype_text")))
					   .append("~Length = ")
					   .append(correctNull((String )hshValues.get("txt_lengthboat")))
					   .append("~Breath = ")
					   .append(correctNull((String )hshValues.get("txt_breathboat")))
					   .append("~Capacity of catches = ")
					   .append(correctNull((String )hshValues.get("txt_capacityboat")));
					
				}
			}
			   sbAuditTrial
			   .append("~Estimated Cost = ")
			   .append(correctNull((String )hshValues.get("txt_cost"+i)))
			   .append("~Margin in Rs.  = ")
			   .append(correctNull((String )hshValues.get("txt_margin"+i)))
			   .append("~Loan Amount = ")
			   .append(correctNull((String )hshValues.get("txt_loan"+i)));
			}
			sbAuditTrial
			.append("~Total Estimated Cost = ")
			.append(correctNull((String )hshValues.get("txt_estimatecost")))
			.append("~Total Margin in Rs. = ")
			.append(correctNull((String )hshValues.get("txt_totalmargin")))
			.append("~Total Loan Amount = ")
			.append(correctNull((String )hshValues.get("txt_loanamt")));
			}
		   AuditTrial.auditLog(hshValues,"259",appno,sbAuditTrial.toString());
			
			
			HashMap hshRecord = getfishersinvest(hshValues);
			return hshRecord;
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
		}
	}
	public void updatemarketingfisheries(HashMap hshValues)
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String appno=correctNull((String)hshValues.get("appno"));
		strAction=correctNull((String)hshValues.get("hidAction"));
		String strBoat="";
		String strNets="";
		String strFishFeed="";
		String strFingerlings="";
		String strFishConsuming="";
		String strpreservation="";
		String strTransport ="";
		String strDemand ="",strarea_processing="",strselprojecttype="";
		String strschemetype="",strfacsno="",stragrschemetype="",strarea_experience="",strarea_marketing="";
		HashMap hshScheme = new HashMap();
		try
		{	
			
			if(appno.equalsIgnoreCase(""))
			{
				appno=Helper.correctNull((String)hshValues.get("strAppno"));
			}
			strschemetype	= Helper.correctNull((String )hshValues.get("schemetype"));	
			hshScheme = Helper.splitScheme(strschemetype);
			if(hshScheme!=null)
			{
				strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
				stragrschemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
			}
			
			strBoat=Helper.correctNull((String)hshValues.get("txr_boatdetails"));
			strNets=Helper.correctNull((String)hshValues.get("txr_nets"));
			strFishFeed=Helper.correctNull((String)hshValues.get("txr_fishfeed"));
			strFingerlings=Helper.correctNull((String)hshValues.get("txr_fingerlings"));
			strFishConsuming=Helper.correctNull((String)hshValues.get("txr_fishconsuming"));
			strpreservation=Helper.correctNull((String)hshValues.get("txr_arrangement"));
			strTransport=Helper.correctNull((String)hshValues.get("txr_transport"));
			strDemand=Helper.correctNull((String)hshValues.get("txr_demand"));
			strarea_experience=Helper.correctNull((String)hshValues.get("txtarea_experience"));
			strarea_marketing=Helper.correctNull((String)hshValues.get("txtarea_marketing"));
			strarea_processing=Helper.correctNull((String)hshValues.get("txtarea_processing"));
			strselprojecttype=Helper.correctNull((String)hshValues.get("selprojecttype"));
			if(strAction.equals("insert"))
			{
			   hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","delagrfishinvestmarketing");
				arrValues.add(appno);
				arrValues.add(strfacsno);
				arrValues.add(stragrschemetype);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","insagrfishinvestmarketing");
				arrValues.add(appno);//1
				arrValues.add(strBoat);//2
				arrValues.add(strNets);//3
				arrValues.add(strFishFeed);//4
				arrValues.add(strFingerlings);//5
				arrValues.add(strFishConsuming);//6
				arrValues.add(strpreservation);//7
				arrValues.add(strTransport);//8
				arrValues.add(strDemand);//9
				arrValues.add(strfacsno);//10
				arrValues.add(stragrschemetype);//11
				arrValues.add(strarea_experience);//12
				arrValues.add(strarea_marketing);//13
				arrValues.add(strarea_processing);//14
				arrValues.add(strselprojecttype);//15
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equals("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","delagrfishinvestmarketing");
				arrValues.add(appno);
				arrValues.add(strfacsno);
				arrValues.add(stragrschemetype);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
		}catch(Exception e)
		{
			throw new EJBException("inside update"+e.toString());
		}
		
		
	}
	public HashMap getmarketingfisheries(HashMap hshValues)
	{
		String strQuery="";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();	
		String appno=correctNull((String)hshValues.get("appno"));
		String strschemetype="",strfacsno="",stragrschemetype="";
		HashMap hshScheme = new HashMap();
		
		try
		{	
			if(appno.equalsIgnoreCase(""))
			{
				appno=Helper.correctNull((String)hshValues.get("strAppno"));
			}
			strschemetype	= Helper.correctNull((String )hshValues.get("schemetype"));	
			hshScheme = Helper.splitScheme(strschemetype);
			if(hshScheme!=null)
			{
				strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
				stragrschemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
			}
			
			strQuery = SQLParser.getSqlQuery("selagrfishinvestmarketing^"+appno+"^"+strfacsno+"^"+stragrschemetype);
			rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			
		hshRecord.put("agr_fishboat",Helper.correctNull(rs.getString("agr_fishboat")));
		hshRecord.put("agr_fishNets",Helper.correctNull(rs.getString("agr_fishNets")));
		hshRecord.put("agr_fishFeed",Helper.correctNull(rs.getString("agr_fishFeed")));
		hshRecord.put("agr_fishFingerlings",Helper.correctNull(rs.getString("agr_fishFingerlings")));
		hshRecord.put("agr_fishFishConsuming",Helper.correctNull(rs.getString("agr_fishFishConsuming")));
		hshRecord.put("agr_fishpreservation",Helper.correctNull(rs.getString("agr_fishpreservation")));
		hshRecord.put("agr_fishTransport",Helper.correctNull(rs.getString("agr_fishTransport")));
		hshRecord.put("agr_fishDemand",Helper.correctNull(rs.getString("agr_fishDemand")));
		hshRecord.put("agr_experience",Helper.correctNull(rs.getString("agr_experience")));
		hshRecord.put("agr_marketing",Helper.correctNull(rs.getString("agr_marketing")));
		hshRecord.put("agr_processing",Helper.correctNull(rs.getString("agr_processing")));
		hshRecord.put("af_projecttype",Helper.correctNull(rs.getString("af_projecttype")));
		}
		}catch(Exception e)
		{
			throw new EJBException("inside getamrketingfisheries"+e.toString());
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
		
}

	
	
	
	
	
	
	
	

	
	
	
	
	
	
	
	
	
