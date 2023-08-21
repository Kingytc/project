package com.sai.laps.ejb.audittrial;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.ejb.attachphoto.AttachPhotoBean;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
@Stateless(name = "AuditTrialBean", mappedName = "AuditTrialHome")
@Remote (AuditTrialRemote.class)
public class AuditTrialBean extends BeanAdapter
{
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(AuditTrialBean.class);
	
	public  HashMap getDataHelp(HashMap hshValues) 
	{		
		ResultSet rs = null;
		String strQuery1="";		
		HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();
		ArrayList vecVal=new ArrayList();
		String strCheck="";
		String strTemp="",desc="";
		try
		{		
			java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
			jtn.setMaximumFractionDigits(2);
			jtn.setMinimumFractionDigits(2);
			jtn.setGroupingUsed(false);
			String appno=correctNull((String)hshValues.get("appno"));
			String user_id=correctNull((String)hshValues.get("user_id"));
			String module=correctNull((String)hshValues.get("select_cat"));	
			String 	From_date=correctNull((String)hshValues.get("From_date"));
			String 	To_date=correctNull((String)hshValues.get("To_date"));
				
			if(!appno.equals(""))
			{
				desc= "key_id='"+appno+"'";
			}
			else
			{
				desc= "at.usr_id='"+user_id+"'";
			}
			strQuery1 = SQLParser.getSqlQuery("selAuditReport^"+module+"^"+desc);//+"^"+From_date+"^"+To_date);-------------Removed by kamal
			
			rs= DBUtils.executeQuery(strQuery1);
			while(rs.next())
			{
				vecVal = new ArrayList();				
				String strTempData="";
				vecVal.add(correctNull(rs.getString("page_name")));//0
				vecVal.add(correctNull(rs.getString("usr_id")));//1
				vecVal.add(correctNull(rs.getString("client_ip_addr")));//2
				vecVal.add(correctNull(rs.getString("key_id")));//3
				vecVal.add(correctNull(rs.getString("action_date")));//4
				strTempData=correctNull(rs.getString("action_data"));
				strTempData=strTempData.replaceAll("=~","=");
				StringTokenizer strId = new StringTokenizer(strTempData,"~");
				int i=0;
				StringBuilder strBufferTemp=new StringBuilder();
				//int count=strId.countTokens();
				while (strId.hasMoreTokens())			
				{
					i=i+1;			
					strCheck=(String)strId.nextToken();
					strBufferTemp.append("<b>").append(strCheck.replaceAll("=","= </b>").replaceAll("\\^"," </b>")).append(" <br>");
				}	
				
				vecVal.add(strBufferTemp.toString());//5			
				vecVal.add(correctNull(rs.getString("action_type")).toUpperCase());//6
				vecVal.add(correctNull(rs.getString("usr_fname")));//7
				vecVal.add(correctNull(rs.getString("usr_lname")));//8
				vecVal.add(correctNull(rs.getString("usr_mname")));//9
				vecData.add(vecVal);							
			}	
			hshRecord.put("vecData",vecData);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getDataHelp "+ce.toString());
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
	
	public  HashMap getData(HashMap hshValues) 
	{		
		ResultSet rs = null;
		String strQuery1="";		
		HashMap hshRecord = new HashMap();
		ArrayList arrData = new ArrayList();
		ArrayList arrRow=new ArrayList();
		String desc="";
		StringBuilder strBufferold=new StringBuilder();
		try
		{		
			String strKeyId=correctNull((String)hshValues.get("KeyId"));
			String strPageId=correctNull((String)hshValues.get("hidPageId"));
			String strCustomername=correctNull((String)hshValues.get("app_name"));
			String strCustomer_id=correctNull((String)hshValues.get("hidradId"));
			if(strCustomername.equals(""))
			{
				strCustomername=correctNull((String)hshValues.get("appname"));
			}
			String strPageName="";
			if(!strKeyId.equals(""))
			{
				if(strKeyId.equalsIgnoreCase("SET"))
				{
					desc= "(key_id is null or key_id like '%')";
				}
				else
				{
					if(strPageId.equalsIgnoreCase("setwrkfl"))
					{
						desc= "key_id='"+strKeyId+"'";
					}
					else if(strPageId.equalsIgnoreCase("queries"))
					{
						desc= "key_id='"+strKeyId+"'and action_data='"+strCustomer_id+"'";
					}
					else
					{
						desc= "key_id='"+strKeyId+"'";
					}
				}	
			}
			strQuery1 = SQLParser.getSqlQuery("selAuditTrailReport^"+strPageId+"^"+desc);//+"^"+From_date+"^"+To_date);-------------Removed by kamal
			
			rs= DBUtils.executeQuery(strQuery1);
			while(rs.next())
			{
				arrData = new ArrayList();				
				arrData.add(correctNull(rs.getString("action_date")));//0
				arrData.add(correctNull(rs.getString("usr_fname"))+" "+correctNull(rs.getString("usr_mname"))+"  "+correctNull(rs.getString("usr_lname")));//1
				arrData.add(correctNull(rs.getString("usr_id")));//2
				if(correctNull(rs.getString("page_type")).equals("N"))
				{
					StringBuilder strBuffernew=new StringBuilder();
					strBuffernew=FormatAuditData(Helper.CLOBToString(rs.getClob("action_newdata")));
					arrData.add(strBufferold.toString());//3
					arrData.add(strBuffernew.toString());//4
					strBufferold=strBuffernew;
				}
				else
				{
					arrData.add(FormatAuditData(Helper.CLOBToString(rs.getClob("action_olddata"))).toString());//3
					arrData.add(FormatAuditData(Helper.CLOBToString(rs.getClob("action_newdata"))).toString());//4
				}
				arrData.add(correctNull(rs.getString("action_type")).toUpperCase());//5
				arrRow.add(arrData);
				strPageName=correctNull(rs.getString("page_name"));
			}
			hshRecord.put("arrRow",arrRow);
			hshRecord.put("KeyId",strKeyId);
			hshRecord.put("PageName",strPageName);
			hshRecord.put("strCustomername", strCustomername);
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
	
	private StringBuilder FormatAuditData(String strData) 
	{
		StringBuilder strBufferData=new StringBuilder();
		String strTempData=null;
		try
		{
			strTempData=strData;
			StringTokenizer strId = new StringTokenizer(strTempData,"~");
			int i=0;
			while (strId.hasMoreTokens())			
			{
				i=i+1;			
				String strCheck=(String)strId.nextToken();
				strBufferData.append("<b>").append(strCheck.replaceAll("=","= </b>").replaceAll("\\^"," </b>")).append(" <br>");
			}
		}catch(Exception ce)
		{
			throw new EJBException("Error in FormatAuditData "+ce.toString());
		}
		return strBufferData;
	}
}