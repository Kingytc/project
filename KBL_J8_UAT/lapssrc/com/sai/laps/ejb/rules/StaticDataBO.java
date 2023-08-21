package com.sai.laps.ejb.rules;

import java.sql.ResultSet;

import com.sai.fw.management.log.LogWriter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

public class StaticDataBO
{
		public String getStateNameByCode(String strStateCode) throws Exception
		{
			String strQuery=null;
			ResultSet rs=null;
			String strStateName="";
		
			strQuery = SQLParser.getSqlQuery("static_data_desc_select^"+"37"+"^"+strStateCode);
			
			
			try{
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{	 
					 
					strStateName = Helper.correctNull((String)rs.getString("ss_datadescription"));
				}
				if(rs!=null){rs.close();}
				}catch(Exception e)
				{
					LogWriter.log("Error in getStateNameByCode of BankAppBO" +e.getMessage());
					if(rs!=null){rs.close();}
				}
			
			return strStateName;
		}
		
		public String getDistrictNameByStateCode(String strStateCode,String strDistrictCode) throws Exception
		{
			String strQuery=null;
			ResultSet rs=null;
			String strDistrictName="";

			strQuery = SQLParser.getSqlQuery("sel_district_name^"+strStateCode+"^"+strDistrictCode);
			
			try{
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{	 
					 
					strDistrictName = Helper.correctNull((String)rs.getString("district_desc"));
				}
				if(rs!=null){rs.close();}
				}catch(Exception e)
				{
					LogWriter.log("Error in getDistrictNameByCode of BankAppBO" +e.getMessage());
					if(rs!=null){rs.close();}
				}
			
			return strDistrictName;
		}
}