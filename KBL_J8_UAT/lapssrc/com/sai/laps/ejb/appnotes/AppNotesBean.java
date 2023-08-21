package com.sai.laps.ejb.appnotes;

import java.io.ByteArrayOutputStream;
import java.sql.Blob;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
//import java.util.ArrayList;
import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;

@Stateless(name = "AppNotesBean", mappedName = "AppNotesHome")
@Remote (AppNotesRemote.class)
public class AppNotesBean extends BeanAdapter
{
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(AppNotesBean.class);	

	public HashMap getData(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String appno = correctNull((String)hshRequestValues.get("appno"));
		Blob b = null;
		byte[] aBlob = null;	
		
		try
		{
			rs=null;
			ByteArrayOutputStream bios=new ByteArrayOutputStream();
			rs=DBUtils.executeLAPSQuery("appnotessel^"+appno);
			if(rs.next())
			{
				hshRecord = new HashMap();
				hshRecord.put("not_appno",correctNull(rs.getString("not_appno")));
				hshRecord.put("not_usrid",correctNull(rs.getString("not_usrid")));
				b = rs.getBlob("not_text");
				aBlob = b.getBytes(0, (int) b.length());			
				bios.write(aBlob);
				bios.flush();
				hshRecord.put("not_text",bios.toString());
				hshRecord.put("not_date",correctNull(rs.getString("not_date")));
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

	public HashMap updateData(HashMap hshValues) 
	{
		String strApplicationNo="";
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshRecord = new HashMap();
		ArrayList arrValues = new ArrayList();
		String PresentComments="";
        String strAction ="";
		try
		{
			strApplicationNo=correctNull((String)hshValues.get("appno"));
			strAction= correctNull((String)hshValues.get("hidAction"));
			
			if(strAction.equalsIgnoreCase("Delete")){
				hshQuery = new HashMap();	
				arrValues=new ArrayList();	
				hshQuery.put("strQueryId","appnotesdelete");
				arrValues.add(hshValues.get("appno"));			
				hshQueryValues.put("size","1");			
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}else{
				hshQuery.put("strQueryId","appnotesdelete");
				arrValues = new ArrayList();
				arrValues.add(hshValues.get("appno"));			
				hshQueryValues.put("size","1");			
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
	
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","appnotesins");			
				arrValues.add(hshValues.get("strUserId"));
				arrValues.add(hshValues.get("appno"));
				PresentComments=Helper.correctNull((String)hshValues.get("presentcomments"));
				arrValues.add(PresentComments.getBytes());
				hshQueryValues.put("size","2");	
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				String strActionData = "Present Comments = " +correctNull((String)hshValues.get("presentcomments"));			
				hshQuery.put("strQueryId","audittrial");
				arrValues.add("38");
				arrValues.add(correctNull((String)hshValues.get("strUserId")));
				arrValues.add(correctNull((String)hshValues.get("strClientIP")));
				arrValues.add(strApplicationNo);
				arrValues.add(strActionData);			
				arrValues.add("Insert");				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("3",hshQuery);			
				hshQueryValues.put("size","3");		
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in updateData "+ce.toString());
		}
		finally
		{
			try
			{
				//EJBInvoker.executeStateLess("appeditlock",hshValues,"unLockApplication");
			}
			catch(Exception e1)
			{
				throw new EJBException(e1.getMessage());
			}
		}
		hshRecord=(HashMap)getData(hshValues);
		return hshRecord;
	}
}
