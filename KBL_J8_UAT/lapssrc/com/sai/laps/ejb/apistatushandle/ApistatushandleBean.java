package com.sai.laps.ejb.apistatushandle;

import java.util.ArrayList;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;


@Stateless(name = "ApistatushandleBean", mappedName = "ApistatushandleRemote")
@Remote (ApistatushandleRemote.class)
public class ApistatushandleBean extends BeanAdapter {
	
	static Logger log = Logger.getLogger(ApistatushandleBean.class);
	
	public static HashMap updateApiStatus(HashMap hshValues) throws EJBException 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		String strProductType="",typeofApi="",applicantIn="",Resp="",strproposalnumber="",msg="",exception="";

		try{
			
			
			strproposalnumber=Helper.correctNull((String)hshValues.get("appno"));
			strProductType=Helper.correctNull((String)hshValues.get("strRoiProductType"));
			applicantIn=Helper.correctNull((String)hshValues.get("applicantIn"));
			Resp=Helper.correctNull((String)hshValues.get("Resp"));
			msg=Helper.correctNull((String)hshValues.get("msg"));
			typeofApi=Helper.correctNull((String)hshValues.get("typeofApi"));
			exception=Helper.correctNull((String)hshValues.get("exception"));
			
			hshQueryValues=new HashMap();
			hshQuery=new HashMap();
			arrValues=new ArrayList();   
			hshQuery.put("strQueryId","ins_apistatus");
			arrValues.add(String.valueOf(exception));
			arrValues.add(applicantIn);
			arrValues.add(msg); 
			arrValues.add(strProductType); 
			arrValues.add(typeofApi);
			arrValues.add(Resp);
			arrValues.add(strproposalnumber); 
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);	
			hshQueryValues.put("size","1");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			
			
		}catch(Exception e)
		{
			throw new EJBException("Error in Apistatushandle Bean updateApiStatus..."+e.toString());
		}
		return hshValues;
		
	}

}
