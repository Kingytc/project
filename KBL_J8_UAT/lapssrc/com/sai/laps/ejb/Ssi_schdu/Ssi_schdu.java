package com.sai.laps.ejb.Ssi_schdu;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.ejb.solvency.ComSolvencyBean;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "Ssi_schdu", mappedName = "Ssi_schduHome")
@Remote (Ssi_schduRemote.class)
public class Ssi_schdu extends BeanAdapter
{	
	private static final long serialVersionUID = 2096773550007880805L;
	static Logger log=Logger.getLogger(Ssi_schdu.class);

	public HashMap getData(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strid="1";
		String strappno="";
		String strQuery="";
		String recordflag = "N";
		try
		{	
			hshRecord = new HashMap();
			strappno=correctNull((String)hshRequestValues.get("appno"));
			strid="1";
			strQuery = SQLParser.getSqlQuery("selssischd^"+strappno+"^"+"Schdeule of Implementation"+"^"+strid);			
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{	
				hshRecord.put("text11",correctNull((String)rs.getString("ssi_projexisting")));
				hshRecord.put("text12",correctNull((String)rs.getString("ssi_projfuture")));
				recordflag = "Y";
			}
			hshRecord.put("hidId1",strid);
			rs = null;	
			strid="2";
			strQuery = SQLParser.getSqlQuery("selssischd^"+strappno+"^"+"Schdeule of Implementation"+"^"+strid);
			
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{	
				hshRecord.put("text21",correctNull((String)rs.getString("ssi_projexisting")));
				hshRecord.put("text22",correctNull((String)rs.getString("ssi_projfuture")));
				recordflag = "Y";
			}
			hshRecord.put("hidId2",strid);
			rs = null;	
			strid ="3";
			strQuery = SQLParser.getSqlQuery("selssischd^"+strappno+"^"+"Schdeule of Implementation"+"^"+strid);
			
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{	
				hshRecord.put("text31",correctNull((String)rs.getString("ssi_projexisting")));
				hshRecord.put("text32",correctNull((String)rs.getString("ssi_projfuture")));
				recordflag = "Y";		
			}
			hshRecord.put("hidId3",strid);
			rs = null;	
			strid ="4";
			strQuery = SQLParser.getSqlQuery("selssischd^"+strappno+"^"+"Schdeule of Implementation"+"^"+strid);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{	
				hshRecord.put("text41",correctNull((String)rs.getString("ssi_projexisting")));
				hshRecord.put("text42",correctNull((String)rs.getString("ssi_projfuture")));
				recordflag = "Y";
			}
			hshRecord.put("hidId4",strid);
			rs = null;	
			strid="5";
			strQuery = SQLParser.getSqlQuery("selssischd^"+strappno+"^"+"Schdeule of Implementation"+"^"+strid);
			
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{	
				hshRecord.put("text51",correctNull((String)rs.getString("ssi_projexisting")));
				hshRecord.put("text52",correctNull((String)rs.getString("ssi_projfuture")));
				recordflag = "Y";
		
			}
			hshRecord.put("hidId5",strid);
			rs = null;	
			strid="6";
			strQuery = SQLParser.getSqlQuery("selssischd^"+strappno+"^"+"Schdeule of Implementation"+"^"+strid);
				
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{	
				hshRecord.put("text61",correctNull((String)rs.getString("ssi_projexisting")));
				hshRecord.put("text62",correctNull((String)rs.getString("ssi_projfuture")));
				recordflag = "Y";
			}
			hshRecord.put("hidId6",strid);
			rs = null;	
			strid="7";
			strQuery = SQLParser.getSqlQuery("selssischd^"+strappno+"^"+"Schdeule of Implementation"+"^"+strid);
			
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{	
				hshRecord.put("text71",correctNull((String)rs.getString("ssi_projexisting")));
				hshRecord.put("text72",correctNull((String)rs.getString("ssi_projfuture")));
				recordflag = "Y";
			}
			hshRecord.put("hidId7",strid);
			rs = null;	
			strid ="8";
			strQuery = SQLParser.getSqlQuery("selssischd^"+strappno+"^"+"Schdeule of Implementation"+"^"+strid);
			
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{	
				hshRecord.put("text81",correctNull((String)rs.getString("ssi_projexisting")));
				hshRecord.put("text82",correctNull((String)rs.getString("ssi_projfuture")));
				recordflag = "Y";
			}
			hshRecord.put("hidId8",strid);
			rs = null;	
			strid ="9";
			strQuery = SQLParser.getSqlQuery("selssischd^"+strappno+"^"+"Schdeule of Implementation"+"^"+strid);
			
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{	
				hshRecord.put("text91",correctNull((String)rs.getString("ssi_projexisting")));
				hshRecord.put("text92",correctNull((String)rs.getString("ssi_projfuture")));
				recordflag = "Y";
			}
			hshRecord.put("hidId9",strid);
			rs = null;	
			strid="10";
			strQuery = SQLParser.getSqlQuery("selssischd^"+strappno+"^"+"Schdeule of Implementation"+"^"+strid);
			
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{	
				hshRecord.put("text101",correctNull((String)rs.getString("ssi_projexisting")));
				hshRecord.put("text102",correctNull((String)rs.getString("ssi_projfuture")));
				recordflag = "Y";
			}
			hshRecord.put("hidId10",strid);
			rs = null;	
			strid="11";
			strQuery = SQLParser.getSqlQuery("selssischd^"+strappno+"^"+"Schdeule of Implementation"+"^"+strid);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{	
				hshRecord.put("text111",correctNull((String)rs.getString("ssi_projexisting")));
				hshRecord.put("text112",correctNull((String)rs.getString("ssi_projfuture")));
				recordflag = "Y";
			}
			
			hshRecord.put("hidId11",strid);
			hshRecord.put("comapp_id",correctNull((String)hshRequestValues.get("comapp_id")));
			hshRecord.put("hidPageType",correctNull((String)hshRequestValues.get("hidPageType")));
			hshRecord.put("hidCategoryType",correctNull((String)hshRequestValues.get("hidCategoryType")));
			hshRecord.put("hidSSIType",correctNull((String)hshRequestValues.get("hidSSIType")));
			hshRecord.put("recordflag",recordflag);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData login  "+ce.toString());
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

	public HashMap updateData(HashMap hshValues) 
	{	
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();	
		ArrayList arrValues=new ArrayList();
        String hidAction="";
		
		try
		{
			hidAction=correctNull((String )hshValues.get("hidAction"));
			if(hidAction.equalsIgnoreCase("Delete")){
				hshQuery = new HashMap();	
				arrValues=new ArrayList();			

				hshQuery.put("strQueryId","delschd");				
				arrValues.add(correctNull((String )hshValues.get("appno")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				hshQueryValues.put("size",Integer.toString(1));
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");		
			}else{
				hshQuery = new HashMap();	
				arrValues=new ArrayList();			
				hshQuery.put("strQueryId","delschd");				
				arrValues.add(correctNull((String )hshValues.get("appno")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
	
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","insssischd");
				arrValues.add(correctNull((String )hshValues.get("appno")));
				arrValues.add(correctNull((String )hshValues.get("hidId1")));
				arrValues.add("Schdeule of Implementation");
				arrValues.add("Acquisition of Land");			
				arrValues.add(correctNull((String )hshValues.get("text11")));
				arrValues.add(correctNull((String )hshValues.get("text12")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","insssischd");
				arrValues.add(correctNull((String )hshValues.get("appno")));
				arrValues.add(correctNull((String )hshValues.get("hidId2")));
				arrValues.add("Schdeule of Implementation");
				arrValues.add("Development of Land");
				arrValues.add(correctNull((String )hshValues.get("text21")));
				arrValues.add(correctNull((String )hshValues.get("text22")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("3",hshQuery);
	
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","insssischd");
				arrValues.add(correctNull((String )hshValues.get("appno")));
				arrValues.add(correctNull((String )hshValues.get("hidId3")));
				arrValues.add("Schdeule of Implementation");
				arrValues.add("Civil works for Factory Building Machinery Foundation Administrative Building ");
				arrValues.add(correctNull((String )hshValues.get("text31")));
				arrValues.add(correctNull((String )hshValues.get("text32")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("4",hshQuery);
	
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","insssischd");
				arrValues.add(correctNull((String )hshValues.get("appno")));
				arrValues.add(correctNull((String )hshValues.get("hidId4")));
				arrValues.add("Schdeule of Implementation");
				arrValues.add("Plant & Machinery Imported Indigenous");
				arrValues.add(correctNull((String )hshValues.get("text41")));
				arrValues.add(correctNull((String )hshValues.get("text42")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("5",hshQuery);
	
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","insssischd");
				arrValues.add(correctNull((String )hshValues.get("appno")));
				arrValues.add(correctNull((String )hshValues.get("hidId5")));
				arrValues.add("Schdeule of Implementation");
				arrValues.add("Arrangement for power");
				arrValues.add(correctNull((String )hshValues.get("text51")));
				arrValues.add(correctNull((String )hshValues.get("text52")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("6",hshQuery);

				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","insssischd");
				arrValues.add(correctNull((String )hshValues.get("appno")));
				arrValues.add(correctNull((String )hshValues.get("hidId6")));
				arrValues.add("Schdeule of Implementation");
				arrValues.add("Arrangement for water");
				arrValues.add(correctNull((String )hshValues.get("text61")));
				arrValues.add(correctNull((String )hshValues.get("text62")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("7",hshQuery);
	
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","insssischd");
				arrValues.add(correctNull((String )hshValues.get("appno")));
				arrValues.add(correctNull((String )hshValues.get("hidId7")));
				arrValues.add("Schdeule of Implementation");
				arrValues.add("Erection of equipment");			
				arrValues.add(correctNull((String )hshValues.get("text71")));
				arrValues.add(correctNull((String )hshValues.get("text72")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("8",hshQuery);
	
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","insssischd");
				arrValues.add(correctNull((String )hshValues.get("appno")));
				arrValues.add(correctNull((String )hshValues.get("hidId8")));
				arrValues.add("Schdeule of Implementation");
				arrValues.add("Commissioning");
				arrValues.add(correctNull((String )hshValues.get("text81")));
				arrValues.add(correctNull((String )hshValues.get("text82")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("9",hshQuery);
	
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","insssischd");
				arrValues.add(correctNull((String )hshValues.get("appno")));
				arrValues.add(correctNull((String )hshValues.get("hidId9")));
				arrValues.add("Schdeule of Implementation");
				arrValues.add("Initial Procurement of Raw Material");
				arrValues.add(correctNull((String )hshValues.get("text91")));
				arrValues.add(correctNull((String )hshValues.get("text92")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("10",hshQuery);
	
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","insssischd");
				arrValues.add(correctNull((String )hshValues.get("appno")));
				arrValues.add(correctNull((String )hshValues.get("hidId10")));
				arrValues.add("Schdeule of Implementation");
				arrValues.add("Trial Runs");
				arrValues.add(correctNull((String )hshValues.get("text101")));
				arrValues.add(correctNull((String )hshValues.get("text102")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("11",hshQuery);
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","insssischd");
				arrValues.add(correctNull((String )hshValues.get("appno")));
				arrValues.add(correctNull((String )hshValues.get("hidId11")));
				arrValues.add("Schdeule of Implementation");
				arrValues.add("Commercial Production");
				arrValues.add(correctNull((String )hshValues.get("text111")));
				arrValues.add(correctNull((String )hshValues.get("text112")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("12",hshQuery);
				hshQueryValues.put("size",Integer.toString(12));
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");			
			}
			//AUDIT TRIAL.
			StringBuilder sbAt = new StringBuilder();
			if(Helper.correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("N"))
			hshValues.put("hidAction","Insert");
			else if(Helper.correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("Y"))
				hshValues.put("hidAction","Update");
				
			if(!(hidAction.equalsIgnoreCase("Update")|| hidAction.equalsIgnoreCase("Delete"))){
				sbAt.append(" Acquisition of Land ^");
				sbAt.append(" ~ Date of Commencement=").append(correctNull((String )hshValues.get("text11")));	sbAt.append(" ~ Expected Date of Completion=").append(correctNull((String )hshValues.get("text12")));
				sbAt.append(" ~ Development of Land ^");
				sbAt.append(" ~ Date of Commencement=").append(correctNull((String )hshValues.get("text21")));	sbAt.append(" ~ Expected Date of Completion=").append(correctNull((String )hshValues.get("text22")));
				sbAt.append(" ~ Civil works for Factory Building Machinery Foundation Administrative Building ^");
				sbAt.append(" ~Date of Commencement =").append(correctNull((String )hshValues.get("text31")));	sbAt.append(" ~ Expected Date of Completion=").append(correctNull((String )hshValues.get("text32")));
				sbAt.append(" ~Plant & Machinery Imported Indigenous  ^");
				sbAt.append(" ~ Date of Commencement=").append(correctNull((String )hshValues.get("text41")));	sbAt.append(" ~ Expected Date of Completion=").append(correctNull((String )hshValues.get("text42")));
				sbAt.append(" ~Arrangement for power  ^");
				sbAt.append(" ~ Date of Commencement=").append(correctNull((String )hshValues.get("text51")));	sbAt.append(" ~ Expected Date of Completion=").append(correctNull((String )hshValues.get("text52")));
				sbAt.append(" ~Arrangement for water  ^");
				sbAt.append(" ~Date of Commencement =").append(correctNull((String )hshValues.get("text61")));	sbAt.append(" ~ Expected Date of Completion=").append(correctNull((String )hshValues.get("text62")));
				sbAt.append(" ~Erection of equipment ^");
				sbAt.append(" ~ Date of Commencement=").append(correctNull((String )hshValues.get("text71")));	sbAt.append(" ~ Expected Date of Completion=").append(correctNull((String )hshValues.get("text72")));
				sbAt.append(" ~ Commissioning ^");
				sbAt.append(" ~ Date of Commencement=").append(correctNull((String )hshValues.get("text81")));	sbAt.append(" ~ Expected Date of Completion=").append(correctNull((String )hshValues.get("text82")));
				sbAt.append(" ~ Initial Procurement of Raw Material ^");
				sbAt.append(" ~ Date of Commencement=").append(correctNull((String )hshValues.get("text91")));	sbAt.append(" ~ Expected Date of Completion=").append(correctNull((String )hshValues.get("text92")));
				sbAt.append(" ~ Trial Runs ^");
				sbAt.append(" ~ Date of Commencement=").append(correctNull((String )hshValues.get("text101")));	sbAt.append(" ~ Expected Date of Completion =").append(correctNull((String )hshValues.get("text102")));
				sbAt.append(" ~Commercial Production  ^");
				sbAt.append(" ~ Date of Commencement=").append(correctNull((String )hshValues.get("text111")));	sbAt.append(" ~ Expected Date of Completion=").append(correctNull((String )hshValues.get("text112")));
			}
			AuditTrial.auditLog(hshValues,"179",correctNull((String )hshValues.get("appno")),sbAt.toString());
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
		}
		HashMap hshRecord=getData(hshValues);
		return hshRecord;
	}
}