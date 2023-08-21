package com.sai.laps.helper;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

/**
 * @author Kanagaraj.M Created on : Dec 12, 2004 @
 * @version $Revision: 1.1 $
 */
public class ReferenceTableDAO  {
	static Logger log=Logger.getLogger(ReferenceTableDAO.class);

    /**
     * Added by Ram on 05/08/2006 to initialize Reference Table Data Preloading and caching.
     * 
     * @param fieldname
     * @return ArrayList
     * @throws Exception
     */
    public Map getAllReferenceData() throws Exception {
        
        ResultSet rs = null;
        ConcurrentHashMap hshRefKeyValue	=	new ConcurrentHashMap();
        try 
        {
        	String strPrevMasterId = "";
        	ArrayList arrRow		=	new ArrayList();
        	 String strQuery = SQLParser.getSqlQuery("sel_static_data_master");
        	rs =DBUtils.executeQuery(strQuery);
        	while(rs.next())
        	{
        		String strMasterID = Helper.correctNull((String)rs.getString("STAT_MAST_ID"));
        		if(!strMasterID.equalsIgnoreCase(strPrevMasterId) && strPrevMasterId.length()!=0)
            	{
        			hshRefKeyValue.put(strPrevMasterId, arrRow);
        			arrRow = new ArrayList();
            	}
        		ArrayList arrCol		= 	new ArrayList();
        		arrCol.add(Helper.correctNull(rs.getString("stat_data_desc")));
        		arrCol.add(Helper.correctNull(rs.getString("stat_data_desc1")));
        		arrCol.add(Helper.correctNull(rs.getString("stat_data_sno")));
        		arrCol.add(Helper.correctNull(rs.getString("stat_data_active")));
        		arrRow.add(arrCol);
        		strPrevMasterId = strMasterID;
        	}
        	hshRefKeyValue.put(strPrevMasterId, arrRow);
        	
        	if(rs!=null)
        	{
        		rs.close();
        	}
        } 
        catch (Exception ce) 
        {
            log.error(ce);
        }  
        return hshRefKeyValue;

    }
    
    public Map getAllReferenceCBSDataNew() throws Exception {
        ResultSet rs = null;
        String strQuery="";
        ArrayList arrRow		=	new ArrayList();
        ConcurrentHashMap hshRefKeyValue	=	new ConcurrentHashMap();
        try 
        {
        	String strMasterID="";String strPrevMasterId ="";
        	
        	strQuery = SQLParser.getSqlQuery("sel_cbsstatic_data_master");
        	rs =DBUtils.executeQuery(strQuery);
        	while(rs.next())
        	{
        		 strMasterID = Helper.correctNull((String)rs.getString("STAT_MAST_ID"));
        		if(!strMasterID.equalsIgnoreCase(strPrevMasterId) && strPrevMasterId.length()!=0)
            	{
        			hshRefKeyValue.put(strPrevMasterId, arrRow);
        			arrRow = new ArrayList();
            	}
        		ArrayList arrCol	=	new ArrayList();
        		arrCol.add(Helper.correctNull(rs.getString("cbs_static_data_code")));
        		arrCol.add(Helper.correctNull(rs.getString("cbs_static_data_desc")));
        		arrCol.add(Helper.correctNull(rs.getString("cbs_slno")));
        		arrCol.add(Helper.correctNull(rs.getString("cbs_static_data_show")));
        		arrRow.add(arrCol);
        		strPrevMasterId = strMasterID;
        	}
        	hshRefKeyValue.put(strPrevMasterId, arrRow);
        } 
        catch (Exception ce) 
        {
        log.error(ce);
        } finally {
            if(rs!=null)
            	rs.close();
        }
        return hshRefKeyValue;

    }
    
public  ArrayList getcreditsaleReferenceData(String strStaticId,String strType) throws Exception {
        
        ResultSet rs = null;
        ConcurrentHashMap hshRefKeyValue	=	new ConcurrentHashMap();
        ArrayList arrRow		=	new ArrayList();
        String strQuery="";
        try 
        {
        	String strPrevMasterId = "";
        	//condition added for AHP loan govt.scheme.
        	if(("11").equalsIgnoreCase(strStaticId) && ("P").equalsIgnoreCase(strType)){
        		  strQuery = SQLParser.getSqlQuery("sel_staticgecl4_ahpdesc^"+strStaticId);
        	}
        	else if((strStaticId.equals("245") || strStaticId.equalsIgnoreCase("246")) && !strType.equals(""))
        	{
        		strQuery = SQLParser.getSqlQuery("sel_staticdata_type^"+strStaticId+"^"+strType);
        	}
        	else{
        		strQuery = SQLParser.getSqlQuery("sel_staticgecl4_desc^"+strStaticId);
        	}
        	rs =DBUtils.executeQuery(strQuery);
        	while(rs.next())
        	{
        		ArrayList arrCol		= 	new ArrayList();
        		arrCol.add(Helper.correctNull(rs.getString("stat_data_desc")));
        		arrCol.add(Helper.correctNull(rs.getString("stat_data_desc1")));
        		arrCol.add(Helper.correctNull(rs.getString("stat_data_sno")));
        		arrCol.add(Helper.correctNull(rs.getString("stat_data_active")));
        		arrRow.add(arrCol);
        	}
        	if(rs!=null)
        	{
        		rs.close();
        	}
        } 
        catch (Exception ce) 
        {
            log.error(ce);
        }  
        return arrRow;

    }
public  ArrayList getGovtSchemeReferenceData(String strStaticId,String strType,String appno) throws Exception {
    
    ResultSet rs = null;
    ConcurrentHashMap hshRefKeyValue	=	new ConcurrentHashMap();
    ArrayList arrRow		=	new ArrayList();
    String strQuery="";
    try 
    {
    	String strPrevMasterId = "";
    	//condition added for AHP loan govt.scheme.
    	strQuery=SQLParser.getSqlQuery("getlreq^"+appno);
		rs=DBUtils.executeQuery(strQuery);
		String govt_scheme="";
		String loan_govt="";
		if(rs.next())
		{
			govt_scheme=Helper.correctNull(rs.getString("GOVT_SCHEME"));
			loan_govt=Helper.correctNull(rs.getString("LOAN_GOVT"));

		}
    	if(("P").equalsIgnoreCase(strType)&&("1").equalsIgnoreCase(loan_govt)&&((("080").equalsIgnoreCase(govt_scheme)) ||(("081").equalsIgnoreCase(govt_scheme)) )){
    		
    		strQuery = SQLParser.getSqlQuery("sel_staticgecl4_ahpdesc^"+strStaticId);
			
			
    	}else if(("P").equalsIgnoreCase(strType)&&(("2").equalsIgnoreCase(loan_govt)) ){
    		
    		strQuery = SQLParser.getSqlQuery("sel_staticgecl4_notahpdesc^"+strStaticId);
			
			
    	}else if(("P").equalsIgnoreCase(strType)&&(("1").equalsIgnoreCase(loan_govt))&&((!("080").equalsIgnoreCase(govt_scheme)) ||(!("081").equalsIgnoreCase(govt_scheme)) ) ){
    		
    		strQuery = SQLParser.getSqlQuery("sel_staticgecl4_notahpdesc^"+strStaticId);
			
			
    	}else{
    	
    	  strQuery = SQLParser.getSqlQuery("sel_staticgecl4_desc^"+strStaticId);
    	}
    	 rs =DBUtils.executeQuery(strQuery);
    	while(rs.next())
    	{
    		
    		ArrayList arrCol		= 	new ArrayList();
    		arrCol.add(Helper.correctNull(rs.getString("stat_data_desc")));
    		arrCol.add(Helper.correctNull(rs.getString("stat_data_desc1")));
    		arrCol.add(Helper.correctNull(rs.getString("stat_data_sno")));
    		arrCol.add(Helper.correctNull(rs.getString("stat_data_active")));
    		arrRow.add(arrCol);
    	}
    	
    	if(rs!=null)
    	{
    		rs.close();
    	}
    } 
    catch (Exception ce) 
    {
        log.error(ce);
    }  
    return arrRow;

}
}


