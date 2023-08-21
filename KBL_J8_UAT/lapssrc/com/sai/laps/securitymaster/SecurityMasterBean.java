
package com.sai.laps.securitymaster;
import java.rmi.RemoteException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;
import java.util.concurrent.TimeUnit;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;
import org.eclipse.jdt.internal.compiler.util.HashtableOfIntValues;

import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.CLOBInvoker;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.IRB_Encryption;
import com.sai.laps.helper.SQLParser;
@Stateless(name = "SecurityMasterBean", mappedName = "SecurityMasterHome")
@Remote (SecurityMasterRemote.class)
public class SecurityMasterBean extends BeanAdapter {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(SecurityMasterBean.class);
	public HashMap getSecurityMaster (HashMap hshValues)  {
		
		String strQuery="";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList arrVal = new ArrayList();
		ArrayList arrRow = new ArrayList();
		ArrayList arrRow2 = new ArrayList();
		String strValue = "";
		String strParent = "";
		String strSecAction="";
		String secid="",secname="",seccbssecurity="",seccollatflag="",strLiquidFlag="";

		try
		{			
			strQuery = SQLParser.getSqlQuery("selSecurityType^0");
			rs = DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				arrVal = new ArrayList();
				secid =correctNull(rs.getString("sec_id"));
				secname =correctNull(rs.getString("sec_name"));
				seccbssecurity =correctNull(rs.getString("sec_cbssecurity"));
				seccollatflag =correctNull(rs.getString("SEC_COLLATFLAG"));
				strLiquidFlag=correctNull(rs.getString("sec_isliquidflag"));
				strSecAction=correctNull(rs.getString("sec_Action"));
				arrVal.add(secid);
				arrVal.add(secname);		
				arrVal.add(seccbssecurity);
				arrVal.add(seccollatflag);
				arrVal.add(strLiquidFlag);
				arrVal.add(strSecAction);
				arrRow.add(arrVal);
			}
			
			
			if(rs!=null){
				rs.close();
			}
			
			
			strQuery ="";
			strParent = (String)hshValues.get("secType");			
			if(strParent!=null){
				
				strQuery = SQLParser.getSqlQuery("selSecurityList^0^"+strParent);
				rs = DBUtils.executeQuery(strQuery);
				
				while(rs.next())
				{
					arrVal = new ArrayList();
					secid =correctNull(rs.getString("sec_id"));
					secname =correctNull(rs.getString("sec_name"));
					seccollatflag =correctNull(rs.getString("SEC_COLLATFLAG"));
					strLiquidFlag =correctNull(rs.getString("sec_isliquidflag"));
					strSecAction=correctNull(rs.getString("sec_Action"));
					secname=secname+"@"+correctNull(rs.getString("sec_cbssecurity"))+"@"+seccollatflag+"@"+strLiquidFlag+"@"+strSecAction;					
					arrVal.add(secid);
					arrVal.add(secname);
					arrVal.add(seccollatflag);
					arrVal.add(strLiquidFlag);
					arrVal.add(strSecAction);
					arrRow2.add(arrVal);
				}
				hshRecord.put("arrRow2",arrRow2);
			}
			hshRecord.put("arrRow",arrRow);
					
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getSecurityMaster "+ce.toString());
		}
		
		return hshRecord;
	}
	
	public HashMap updateSecurityMaster(HashMap hshValues)  {
		
		HashMap hshRecord = new HashMap();
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		int maxsno =0;
		String strAction =null;
		String strSecType =null;
		String strSecno=null;
		String insType=null;
		String strcbssecurity=null;
		String strCollatflag=null;
		String parentid="0";
		ResultSet rs = null;
		String strSno="";
		String strIsLiquid="";
		String strSecAction=null;
		
		try{
			
			strAction = Helper.correctNull((String)hshValues.get("hidAction"));
			strSecType= Helper.correctNull((String)hshValues.get("txtsec_type"));
			strSecno = Helper.correctNull((String)hshValues.get("selSecType"));
			insType = Helper.correctNull((String)hshValues.get("hidinstype"));
			strcbssecurity=Helper.correctNull((String)hshValues.get("sel_cbssecurity"));
			strCollatflag=Helper.correctNull((String)hshValues.get("sel_collatflag"));
			strIsLiquid=Helper.correctNull((String)hshValues.get("sel_weathliquid"));
			strSecAction=Helper.correctNull((String)hshValues.get("sel_Action"));
						
			if (strAction.equalsIgnoreCase("insert"))
			{				
				rs = DBUtils.executeLAPSQuery("selmaxSecurityType");
				if(rs.next()){
					maxsno = rs.getInt("snomax");
				}
				arrValues = new ArrayList();
				hshQuery = new HashMap();
										
				arrValues.add(String.valueOf(maxsno));
				arrValues.add(strSecType.toString().toUpperCase());
				arrValues.add(strSecno);
				arrValues.add(strcbssecurity);
				arrValues.add(strCollatflag);
				arrValues.add(strIsLiquid);
				arrValues.add(strSecAction);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","insSecurityType");
				hshQueryValues.put("size","1");					
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			}

						
			if (strAction.equalsIgnoreCase("update")){
				
				strSno = Helper.correctNull((String)hshValues.get("hidsno"));
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(strSecType);
				arrValues.add(strcbssecurity);
				arrValues.add(strCollatflag);
				arrValues.add(strIsLiquid);
				arrValues.add(strSecAction);
				arrValues.add(strSno);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","updSecurityList");
				hshQueryValues.put("size","1");					
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			}
			
			if (strAction.equalsIgnoreCase("delete")){
				
				strSno = Helper.correctNull((String)hshValues.get("hidsno"));
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(strSno);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","delSecurityList");
				hshQueryValues.put("size","1");					
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			}
			hshRecord=getSecurityMaster(hshValues);

		}
		catch(Exception ce){
			log.error(ce.toString());
			throw new EJBException("Error in updateSecurityMaster "+ce.toString());
		}
		return hshRecord;
	}
	public void updatePropertyDetData(HashMap hshRequestValues)
    {
    	HashMap hshQueryValues=new HashMap();
    	HashMap hshQuery=new HashMap();
    	ArrayList arrValues=new ArrayList();
    	String strAction=Helper.correctNull((String)hshRequestValues.get("hidAction"));
    	String strSecurityId=Helper.correctNull((String)hshRequestValues.get("hidSecurityId"));
    	String strSecNature="",strCus_classify="";
    	ResultSet rs=null;
    	String strQuery="";
    	String strModifiedField[]=null;
		String strModifiedValue[]=null;
		String strUserId=correctNull((String) hshRequestValues.get("strUserId"));
		try
    	{
    		rs=DBUtils.executeLAPSQuery("securities_sel^"+strSecurityId);
    		if(rs.next())
    		{
    			strSecNature=Helper.correctNull(rs.getString("cus_sec_natureofcharge"));
    			strCus_classify=Helper.correctNull(rs.getString("cus_sec_classification"));
    		}
    		
    		if(rs!=null)
    		rs.close();
    		
    		if(strAction.equalsIgnoreCase("insert"))
			{
    			boolean secHisflag = false;
    			strQuery = SQLParser.getSqlQuery("selsecpropdet^"+strSecurityId);
	    		rs = DBUtils.executeQuery(strQuery);
	    		if(rs.next())
	    		{
	    			secHisflag=true;
	    		}
    			hshQueryValues.put("size","2");
    			arrValues.add(strSecurityId);
				hshQuery.put("arrValues", arrValues);				
				hshQuery.put("strQueryId","delsecpropdet");
				hshQueryValues.put("1", hshQuery);
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(strSecurityId);
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("sel_PropertyType")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("hid_SurveyNo")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_PlotNo")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_TotalArea")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("sel_Measurement")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_ExtOfBuilding")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_ExtOfGround")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_ExtOfNotCovered")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_YearBuilt")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_Valuation")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_ForcedSale")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("select_loc")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("sel_Acquired")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_OtherInf")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_Address1")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_Address2")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("hidcity")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("hid_District")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("hidstate")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_PinCode")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_BoundWest")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_BoundEast")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_BoundNorth")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_BoundSouth")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("sel_extofbuildMeas")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("sel_extofgroundMeas")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("sel_extnotcoveredMeas")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("sel_boundaries")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_titledeeddepposit_date")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_StreetNo")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_WardNo")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("sel_prop")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("sel_propacquisition")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_propothers")));	
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_SaleAmount")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_BuilderName")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_RefnoApprov")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_NoFloor")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_AgeOfBuilding")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("hid_CersaiID")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("hid_CersaiDate")));
				if(strCus_classify.equalsIgnoreCase("61")){
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("sel_whtprojapr")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("hid_buildercode")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_ProjectName")));
				}
				else{
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
				}
				/*arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_CERSAIrefno")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_SearchPerformed_date")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_remarks")));*/
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("hid_CERSAIrefnum")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("hid_CersaiDate1")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_remarks")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("sel_whtalrmortobnk")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("sel_whtbnkchrgreflct")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_remarkschrgonprop")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_remarkschrgnotref")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("sel_anychrgonprop")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("sel_corpType")));

				hshQuery.put("arrValues", arrValues);				
				hshQuery.put("strQueryId","inssecpropdet");
				hshQueryValues.put("2", hshQuery);
				
				if(!(strSecNature.equalsIgnoreCase("5")||strSecNature.equalsIgnoreCase("6")))
				{
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","3");
					hshQuery.put("strQueryId","upd_securities");
					arrValues.add("Y");
					arrValues.add(strSecurityId);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("3",hshQuery);
				}
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
				strQuery=SQLParser.getSqlQuery("selseclegalopinion^"+strSecurityId);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					if(rs!=null)
			    		rs.close();
					strQuery = SQLParser.getSqlQuery("sel_secMailbox_check^"+strSecurityId);
		    		rs = DBUtils.executeQuery(strQuery);
		    		if(rs.next())	
		    		{
		    			String mailboxflag=Helper.correctNull((String)rs.getString("SEC_FLAG"));
						if(mailboxflag.equals("NCN"))
							mailboxflag="N";
						else
							mailboxflag="V";
		    			hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQueryValues.put("size","1");
						hshQuery.put("strQueryId","upd_secMailbox_flag");
						arrValues.add(mailboxflag);
						arrValues.add(strSecurityId);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);
						
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQueryValues.put("size","2");
						hshQuery.put("strQueryId","upd_cussecurities_changeflag");
						arrValues.add("V");
						arrValues.add(strSecurityId);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("2",hshQuery);
						
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		    		}
				}
				
				if(secHisflag==true)
				{
				hshQueryValues=new HashMap();
				int arrquerySize=1;
				String tempOldvalue="",tempNewvalue="",tempField="";
				if(!Helper.correctNull((String)hshRequestValues.get("hidmodifiedField")).equals(""))
					strModifiedField = Helper.correctNull((String)hshRequestValues.get("hidmodifiedField")).split("@") ;
				if(!Helper.correctNull((String)hshRequestValues.get("hidmodifiedvalue")).equals(""))	
					strModifiedValue = Helper.correctNull((String)hshRequestValues.get("hidmodifiedvalue")).split("@");
				if(strModifiedField!=null && strModifiedField.length>0)
				{
					for (int  k = 0; k < strModifiedField.length; k++) 
					{
						tempOldvalue= Helper.correctNull((String)hshRequestValues.get(strModifiedValue[k]));
						tempNewvalue= Helper.correctNull((String)hshRequestValues.get((strModifiedValue[k]).substring(4)));
						tempField= strModifiedField[k];
	
						arrValues=new ArrayList();
						hshQuery = new HashMap();
						arrValues.add(tempField);
						arrValues.add(tempOldvalue);
						arrValues.add(tempNewvalue);
						arrValues.add(Helper.correctNull((String)hshRequestValues.get("strUserId")));
						arrValues.add(strSecurityId);
						hshQuery.put("arrValues", arrValues);
						hshQuery.put("strQueryId", "ins_sec_modified");
						hshQueryValues.put(Integer.toString(arrquerySize),hshQuery);
						hshQueryValues.put("size",Integer.toString(arrquerySize));
						arrquerySize++;
					}
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
				}
				
				if(rs !=null)
					rs.close();
				String cus_sec_statusflag="";
				strQuery = SQLParser.getSqlQuery("securities_sel^"+strSecurityId);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					cus_sec_statusflag =Helper.correctNull((String)rs.getString("cus_sec_statusflag"));				
				}
				
				if( 
				(!Helper.correctNull((String)hshRequestValues.get("txt_Valuation")).equals(Helper.correctNull((String)hshRequestValues.get("old_txt_Valuation")))) ||
				(!Helper.correctNull((String)hshRequestValues.get("txt_ForcedSale")).equals(Helper.correctNull((String)hshRequestValues.get("old_txt_ForcedSale"))))
				
				)
				{
					
					if(rs !=null)
						rs.close();
					strQuery = SQLParser.getSqlQuery("sel_secMailbox_check^"+strSecurityId);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{   hshQuery = new HashMap();
		            arrValues = new ArrayList();
		            hshQueryValues = new HashMap();
		            hshQueryValues.put("size", "1");
		            hshQuery.put("strQueryId", "upd_sec_inbox_mod_NEW");
		            if (cus_sec_statusflag.equals("Y")) {
		              arrValues.add("V");
		            } else {
		              arrValues.add("NCV");
		            }
		            if (!Helper.correctNull((String)hshRequestValues.get("txt_Valuation")).equals(Helper.correctNull((String)hshRequestValues.get("old_txt_Valuation"))))
		            {
		              arrValues.add(Helper.correctNull((String)hshRequestValues.get("old_txt_Valuation")));
		              arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_Valuation")));
		            }
		            else
		            {
		              arrValues.add("");arrValues.add("");
		            }
		            if (!Helper.correctNull((String)hshRequestValues.get("txt_ForcedSale")).equals(Helper.correctNull((String)hshRequestValues.get("old_txt_ForcedSale"))))
		            {
		              arrValues.add(Helper.correctNull((String)hshRequestValues.get("old_txt_ForcedSale")));
		              arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_ForcedSale")));
		            }
		            else
		            {
		              arrValues.add("");arrValues.add("");
		            }
		            arrValues.add(Helper.correctNull((String)hshRequestValues.get("strSolid")));
		            arrValues.add(strSecurityId);
		            hshQuery.put("arrValues", arrValues);
		            hshQueryValues.put("1", hshQuery);
		            EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");}
					else
					{
						
						   hshQuery = new HashMap();
				            arrValues = new ArrayList();
				            hshQueryValues = new HashMap();
				            hshQueryValues.put("size", "1");
				            hshQuery.put("strQueryId", "ins_sec_inbox_mod_new");
				            arrValues.add(strSecurityId);
				            arrValues.add(strUserId);
				            if (cus_sec_statusflag.equals("Y")) {
				              arrValues.add("V");
				            } else {
				              arrValues.add("NCV");
				            }
				            if (!Helper.correctNull((String)hshRequestValues.get("txt_Valuation")).equals(Helper.correctNull((String)hshRequestValues.get("old_txt_Valuation"))))
				            {
				              arrValues.add(Helper.correctNull((String)hshRequestValues.get("old_txt_Valuation")));
				              arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_Valuation")));
				            }
				            else
				            {
				              arrValues.add("");arrValues.add("");
				            }
				            if (!Helper.correctNull((String)hshRequestValues.get("txt_ForcedSale")).equals(Helper.correctNull((String)hshRequestValues.get("old_txt_ForcedSale"))))
				            {
				              arrValues.add(Helper.correctNull((String)hshRequestValues.get("old_txt_ForcedSale")));
				              arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_ForcedSale")));
				            }
				            else
				            {
				              arrValues.add("");arrValues.add("");
				            }
				            arrValues.add(Helper.correctNull((String)hshRequestValues.get("strSolid")));
				            hshQuery.put("arrValues", arrValues);
				            hshQueryValues.put("1", hshQuery);
				            EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
						
					}
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQueryValues = new HashMap();
					hshQueryValues.put("size", "1");
					hshQuery.put("strQueryId", "upd_cussecurities_changeflag");
					if(cus_sec_statusflag.equals("Y"))
					{
						arrValues.add("V");
					}
					else
					{
							arrValues.add("NC");//security not completed
					}
					arrValues.add(strSecurityId);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
				
				
				
				
			}
    		else if(strAction.equalsIgnoreCase("delete"))
			{
    			hshQueryValues.put("size","1");
    			arrValues.add(strSecurityId);
				hshQuery.put("arrValues", arrValues);				
				hshQuery.put("strQueryId","delsecpropdet");
				hshQueryValues.put("1", hshQuery);
				
				if(!(strSecNature.equalsIgnoreCase("5")||strSecNature.equalsIgnoreCase("6")))
				{
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","2");
					hshQuery.put("strQueryId","upd_securities");
					arrValues.add("N");
					arrValues.add(strSecurityId);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("2",hshQuery);
				}
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
    		
			//Commented by Archunan as said by banker for not updating net Security Value
//    		if(!strSecurityId.equalsIgnoreCase(""))
//    		{
//    			updateNetSecurityValue(strSecurityId, Helper.correctNull((String)hshRequestValues.get("txt_ForcedSale")));
//    		}
    	}
    	catch(Exception e)
    	{
			throw new EJBException("Error in updatePropertyDetData "+e.toString());
		}
    }
    public HashMap getPropertyDetData(HashMap hshRequestValues)
    {
    	HashMap hshQuery=new HashMap();
    	ResultSet rs=null,rs1=null;
    	String strQuery="",strAppno="", strSecID=null,strPropType="",strLoanPurpose="",strSec_calssification="";
    	strSecID = Helper.correctNull((String)hshRequestValues.get("hidSecurityId"));
    	if(strSecID.equalsIgnoreCase(""))
		{
    		strSecID=Helper.correctNull((String)hshRequestValues.get("hidsecid"));
		}
    	try
    	{
			
	    	strQuery=SQLParser.getSqlQuery("selsecpropdet^"+strSecID);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{  	
				hshQuery.put("sec_propertytype",correctNull(rs.getString("sec_propertytype")));
				hshQuery.put("sec_surveyno",correctNull(rs.getString("sec_surveyno")));
				hshQuery.put("sec_plotno",correctNull(rs.getString("sec_plotno")));
				hshQuery.put("sec_totalarea",correctNull(rs.getString("sec_totalarea")));
				hshQuery.put("sec_measurement",correctNull(rs.getString("sec_measurement")));
				hshQuery.put("sec_extentofbuilding",correctNull(rs.getString("sec_extentofbuilding")));
				hshQuery.put("sec_extentofground",correctNull(rs.getString("sec_extentofground")));
				hshQuery.put("sec_extentofland",correctNull(rs.getString("sec_extentofland")));
				hshQuery.put("sec_year",correctNull(rs.getString("sec_year")));
				hshQuery.put("sec_valuervalue",Helper.correctDouble(rs.getString("sec_valuervalue")));
				hshQuery.put("sec_salevalue",Helper.correctDouble(rs.getString("sec_salevalue")));
				hshQuery.put("sec_branch",correctNull(rs.getString("sec_branch")));
				hshQuery.put("sec_propertyacq",correctNull(rs.getString("sec_propertyacq")));
				hshQuery.put("sec_otherinfo",correctNull(rs.getString("sec_otherinfo")));
				hshQuery.put("sec_address",correctNull(rs.getString("sec_address")));
				hshQuery.put("sec_address1",correctNull(rs.getString("sec_address1")));
				hshQuery.put("sec_city",correctNull(rs.getString("sec_city")));
				hshQuery.put("sec_district",correctNull(rs.getString("sec_district")));
				hshQuery.put("sec_districtDesc",correctNull(rs.getString("districtdesc")));
				hshQuery.put("sec_state",correctNull(rs.getString("sec_state")));
				hshQuery.put("sec_zip",correctNull(rs.getString("sec_zip")));
				hshQuery.put("sec_west",Helper.CLOBToString(rs.getClob("sec_west")));
				hshQuery.put("sec_east",Helper.CLOBToString(rs.getClob("sec_east")));
				hshQuery.put("sec_north",Helper.CLOBToString(rs.getClob("sec_north")));
				hshQuery.put("sec_south",Helper.CLOBToString(rs.getClob("sec_south")));
				hshQuery.put("custcity",correctNull(rs.getString("custcity")));
				hshQuery.put("custstate",correctNull(rs.getString("custstate")));
				hshQuery.put("org_name",correctNull(rs.getString("org_name")));
				hshQuery.put("sec_extofbuildmeas",correctNull(rs.getString("sec_extofbuildmeas")));
				hshQuery.put("sec_extofbuildmeas",correctNull(rs.getString("sec_extofbuildmeas")));
				hshQuery.put("sec_extnotcoveredmeas",correctNull(rs.getString("sec_extnotcoveredmeas")));
				hshQuery.put("SEC_BOUNDARIES",correctNull(rs.getString("SEC_BOUNDARIES")));
				hshQuery.put("SEC_DEPOSIT_DATE",correctNull(rs.getString("SEC_DEPOSIT_DATE")));
				hshQuery.put("sec_saleamount",correctNull(rs.getString("sec_saleamount")));
				hshQuery.put("sec_refnoapprov",correctNull(rs.getString("sec_refnoapprov")));
				hshQuery.put("sec_nofloor",correctNull(rs.getString("sec_nofloor")));
				hshQuery.put("sec_ageofbuilding",correctNull(rs.getString("sec_ageofbuilding")));
				hshQuery.put("sec_streetno",correctNull(rs.getString("sec_streetno")));
				hshQuery.put("sec_wardno",correctNull(rs.getString("sec_wardno")));
				hshQuery.put("SEC_PROP_STAGE",correctNull(rs.getString("SEC_PROP_STAGE")));			
				hshQuery.put("SEC_PROPACQUISITION",correctNull(rs.getString("SEC_PROPACQUISITION")));
				hshQuery.put("SEC_PROPACQUISITION_OTHERS",correctNull(rs.getString("SEC_PROPACQUISITION_OTHERS")));	
				hshQuery.put("SEC_CERSAI_ID",correctNull(rs.getString("SEC_CERSAI_ID")));
				hshQuery.put("SEC_CERSAI_DATE",correctNull(rs.getString("SEC_CERSAI_DATE")));	
				hshQuery.put("SEC_WHT_PROJECTAPPROVED",correctNull(rs.getString("SEC_WHT_PROJECTAPPROVED")));	
				hshQuery.put("SEC_BUILDERCODE",correctNull(rs.getString("SEC_BUILDERCODE")));
				strSec_calssification=correctNull(rs.getString("CUS_SEC_CLASSIFICATION"));
				hshQuery.put("CUS_SEC_CLASSIFICATION",strSec_calssification);
				if(correctNull(rs.getString("SEC_BUILDERCODE")).equalsIgnoreCase("")){
					hshQuery.put("SEC_PROJECTNAME",correctNull(rs.getString("SEC_PROJECTNAME")));	
					hshQuery.put("sec_buildername",correctNull(rs.getString("sec_buildername")));
				}else{
					if(rs1!=null)rs1.close();
					strQuery = SQLParser.getSqlQuery("sel_builderDetails^" + correctNull(rs.getString("SEC_BUILDERCODE")));
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next()) 
					{
						hshQuery.put("sec_buildername",correctNull(rs1.getString("BUILDER_NAME")));	
						hshQuery.put("SEC_PROJECTNAME",correctNull(rs1.getString("BUILDER_PROJECTNAME")));
					}
				}
				hshQuery.put("SEC_CERSAIREFNO",correctNull(rs.getString("SEC_CERSAIREFNO")));	
				hshQuery.put("SEC_SEARCHPERFORM_DATE",correctNull(rs.getString("SEC_SEARCHPERFORM_DATE")));
				hshQuery.put("sec_remarks",correctNull(rs.getString("sec_remarks")));
				hshQuery.put("SEC_ALREADY_MORTG",correctNull(rs.getString("SEC_ALREADY_MORTG")));
				hshQuery.put("SEC_CHARG_REFLECT",correctNull(rs.getString("SEC_CHARG_REFLECT")));
				hshQuery.put("SEC_OTHERBNK_REMARK",correctNull(rs.getString("SEC_OTHERBNK_REMARK")));
				hshQuery.put("SEC_REMARK_NOT_REFLECT",correctNull(rs.getString("SEC_REMARK_NOT_REFLECT")));
				hshQuery.put("SEC_PROP_OBSERVED",correctNull(rs.getString("SEC_PROP_OBSERVED")));
				hshQuery.put("SEC_CROPTYPE",correctNull(rs.getString("SEC_CROPTYPE")));
				
				
			}
			
			else
			{
				rs=DBUtils.executeLAPSQuery("sel_perHousedetails^"+ strSecID);			 
				if (rs.next()) 
				{
					strLoanPurpose =  correctNull(rs.getString("phpa_loan_purpose"));
					strPropType = correctNull(rs.getString("phpa_prop_type"));
					
					if(strLoanPurpose.trim().equalsIgnoreCase("G"))
					{
						hshQuery.put("sec_valuervalue",Helper.correctDouble(rs.getString("phpa_site_valuation_cost")));
					}
					else if(strLoanPurpose.trim().equalsIgnoreCase("C"))
					{
						hshQuery.put("sec_valuervalue",Helper.correctDouble(rs.getString("phpa_bldg_estimate_cost")));
					}
					else if(strLoanPurpose.trim().equalsIgnoreCase("S"))
					{
						hshQuery.put("sec_valuervalue",Helper.correctDouble(rs.getString("phpa_bldg_estimate_cost")));
					}
					else if(strLoanPurpose.trim().equalsIgnoreCase("H"))
					{
						hshQuery.put("sec_valuervalue",Helper.correctDouble(rs.getString("phpa_bldg_valuation_cost")));
					}
					else if(strLoanPurpose.trim().equalsIgnoreCase("R"))
					{
						hshQuery.put("sec_valuervalue",Helper.correctDouble(rs.getString("phpa_bldg_rennovation_cost")));
					}
					else if(strLoanPurpose.trim().equalsIgnoreCase("M"))
					{
						if(strPropType.trim().equalsIgnoreCase("L"))
						{
							hshQuery.put("sec_valuervalue",Helper.correctDouble(rs.getString("phpa_site_valuation_cost")));
						}
						else
						{
							hshQuery.put("sec_valuervalue",Helper.correctDouble(rs.getString("phpa_bldg_valuation_cost")));	
						}
					}
					else
					{
						hshQuery.put("sec_valuervalue","");
					}
					
					hshQuery.put("sec_propertytype",correctNull(rs.getString("phpa_prop_type")));
					hshQuery.put("sec_surveyno",correctNull(rs.getString("phpa_prop_surveyno")));
					hshQuery.put("sec_plotno",correctNull(rs.getString("phpa_prop_plotno")));
					hshQuery.put("sec_totalarea",correctNull(rs.getString("phpa_site_area")));
					hshQuery.put("sec_measurement","1");  // Sq.ft.
					
					hshQuery.put("sec_extentofbuilding",(""));	////
					hshQuery.put("sec_extentofground",(""));		////
					hshQuery.put("sec_extentofland",(""));		////
					hshQuery.put("sec_year",(""));		////
					
				
					hshQuery.put("sec_salevalue",Helper.correctDouble(rs.getString("phpa_bldg_market_value")));
					
					hshQuery.put("sec_branch",(""));		////
					hshQuery.put("sec_propertyacq",(""));		////
					hshQuery.put("sec_otherinfo",(""));		////
					
					hshQuery.put("sec_address",correctNull(rs.getString("phpa_prop_street")));
					hshQuery.put("sec_address1",correctNull(rs.getString("phpa_prop_taluk")));
					hshQuery.put("sec_city",correctNull(rs.getString("phpa_prop_city")));
					hshQuery.put("sec_district",correctNull(rs.getString("phpa_prop_district")));
					hshQuery.put("sec_state",correctNull(rs.getString("phpa_prop_state")));
					hshQuery.put("sec_zip",correctNull(rs.getString("phpa_prop_pincode")));
					
					hshQuery.put("sec_west",(""));		////
					hshQuery.put("sec_east",(""));		////
					hshQuery.put("sec_north",(""));	////
					hshQuery.put("sec_south",(""));		////
					hshQuery.put("custcity",correctNull(rs.getString("phpa_prop_city")));		////
					hshQuery.put("custstate",correctNull(rs.getString("phpa_prop_state")));		////
					hshQuery.put("org_name",(""));		////
				}
			}
			if(strSec_calssification.equalsIgnoreCase("")){
				if(rs!=null)
		    		rs.close();
				strQuery = SQLParser.getSqlQuery("securities_sel^" + strSecID);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next()) 
				{
					hshQuery.put("CUS_SEC_CLASSIFICATION",correctNull(rs.getString("CUS_SEC_CLASSIFICATION")));
				}
			}
			// To get the Customer Name
			String StrLAPSId = correctNull((String) hshRequestValues.get("hidDemoId"));
			strQuery = SQLParser.getSqlQuery("sel_lapsidfromlapsid^" + StrLAPSId);
			if(rs!=null)
	    		rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()) 
			{
				hshQuery.put("perapp_fname", Helper.correctNull((String)rs.getString("perapp_fname")));
				hshQuery.put("perapp_cbsid", Helper.correctNull((String)rs.getString("perapp_cbsid")));
				hshQuery.put("perapp_oldid", Helper.correctNull((String)rs.getString("perapp_oldid")));
			}
			
			//security - valuer name
			if(rs!=null)
	    		rs.close();
			String CUS_SEC_VALUERCODE="";
			strQuery = SQLParser.getSqlQuery("securities_sel^" + strSecID);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()) 
			{
				CUS_SEC_VALUERCODE= Helper.correctInt((String)rs.getString("CUS_SEC_VALUERCODE"));
				hshQuery.put("cus_sec_type", Helper.correctNull((String)rs.getString("cus_sec_type")));
			}
			
			//valuer - asset location valuation
			if(rs!=null)
	    		rs.close();
			strQuery = SQLParser.getSqlQuery("sel_valmasater_name^" + CUS_SEC_VALUERCODE);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()) 
			{
				hshQuery.put("VALUER_VALUEDLOC", Helper.correctNull((String)rs.getString("VALUER_VALUEDLOC")));
			}
			
			hshQuery.put("strSecID", strSecID);
			hshQuery.put("strValuerCode", CUS_SEC_VALUERCODE);
			hshQuery.put("hid_VerificationFlag", Helper.correctNull((String)hshRequestValues.get("hid_VerificationFlag")));
			
			
			 strQuery = SQLParser.getSqlQuery("chksecurityid^" + strSecID);
		      if (rs != null) {
		        rs.close();
		      }
		      rs = DBUtils.executeQuery(strQuery);
		      if (rs.next()) {
		        hshQuery.put("hid_VerificationFlag", Helper.correctInt(rs.getString("CUS_RELEASEFLAG")));
		        hshQuery.put("security_type", Helper.correctInt(rs.getString("CUS_SEC_TYPE")));
		        hshQuery.put("chk_property_leasehold", Helper.correctInt(rs.getString("CUS_PROPERTY_LEASEHOLD")));
		        hshQuery.put("netsecurity_val", Helper.correctInt(rs.getString("CUS_SEC_NETSECURITY")));
		      }
		      
			
			
    	}
    	catch(Exception e)
    	{
			throw new EJBException("Error in getPropertyDetData "+e.toString());
		}
    	return hshQuery;
    }
    
    public void updateFinDocNonTradeable(HashMap hshValues)
	{
    	HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues= new ArrayList();
		String strSecurityId="";
		String strAction =Helper.correctNull((String)hshValues.get("hidAction"));
		ResultSet rs=null;
    	String strQuery="";
    	String strModifiedField[]=null;
		String strModifiedValue[]=null;
		try
		{
			strSecurityId = Helper.correctNull((String) hshValues.get("hidSecurityId"));
			if(strAction.equalsIgnoreCase("insert"))
			{
				boolean secHisflag = false;
				strQuery = SQLParser.getSqlQuery("sel_security_nontradeable^"+strSecurityId);
	    		rs = DBUtils.executeQuery(strQuery);
	    		if(rs.next())
	    		{
	    			secHisflag=true;
	    		}
	    		
				hshQueryValues = new HashMap();
				hshQueryValues.put("size","1");
				hshQuery = new HashMap();		
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","del_security_nontradeable");
				arrValues.add(strSecurityId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","ins_security_nontradeable");
				arrValues.add(strSecurityId);
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_Instru_Rated")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_pre_agency")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_pre_longsymbol")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_policy_certi_no")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_date")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_Issued_By")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Other_Specify")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_Currency_Type")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Face_Value")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Matu_Assu_Value")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Book_Surr_Value")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Due_Matu_Date")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","3");
				hshQuery.put("strQueryId","upd_securities");
				arrValues.add("Y");
				arrValues.add(strSecurityId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("3",hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				if(rs!=null)
		    		rs.close();
				strQuery = SQLParser.getSqlQuery("sel_secMailbox_check^"+strSecurityId);
	    		rs = DBUtils.executeQuery(strQuery);
	    		if(rs.next())	
	    		{
	    			String mailboxflag=Helper.correctNull((String)rs.getString("SEC_FLAG"));
					if(mailboxflag.equals("NCN"))
						mailboxflag="N";
					else
						mailboxflag="V";
	    			hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","upd_secMailbox_flag");
					arrValues.add(mailboxflag);
					arrValues.add(strSecurityId);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","2");
					hshQuery.put("strQueryId","upd_cussecurities_changeflag");
					arrValues.add("V");
					arrValues.add(strSecurityId);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("2",hshQuery);
					
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
	    		}
				
				if(secHisflag==true)
				{
				 hshQueryValues=new HashMap();
				int arrquerySize=1;
				String tempOldvalue="",tempNewvalue="",tempField="";
				if(!Helper.correctNull((String)hshValues.get("hidmodifiedField")).equals(""))
					strModifiedField = Helper.correctNull((String)hshValues.get("hidmodifiedField")).split("@") ;
				if(!Helper.correctNull((String)hshValues.get("hidmodifiedvalue")).equals(""))	
					strModifiedValue = Helper.correctNull((String)hshValues.get("hidmodifiedvalue")).split("@");
				if(strModifiedField!=null && strModifiedField.length>0)
				{
					for (int  k = 0; k < strModifiedField.length; k++) 
					{
						tempOldvalue= Helper.correctNull((String)hshValues.get(strModifiedValue[k]));
						tempNewvalue= Helper.correctNull((String)hshValues.get((strModifiedValue[k]).substring(4)));
						tempField= strModifiedField[k];
	
						arrValues=new ArrayList();
						hshQuery = new HashMap();
						arrValues.add(tempField);
						arrValues.add(tempOldvalue);
						arrValues.add(tempNewvalue);
						arrValues.add(Helper.correctNull((String)hshValues.get("strUserId")));
						arrValues.add(strSecurityId);
						hshQuery.put("arrValues", arrValues);
						hshQuery.put("strQueryId", "ins_sec_modified");
						hshQueryValues.put(Integer.toString(arrquerySize),hshQuery);
						hshQueryValues.put("size",Integer.toString(arrquerySize));
						arrquerySize++;
					}
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
				}
				
				
				
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_security_nontradeable");
				arrValues.add(strSecurityId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","upd_securities");
				arrValues.add("N");
				arrValues.add(strSecurityId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			//Commented by Archunan as said by banker for not updating net security value 
		//	if(!strSecurityId.equalsIgnoreCase(""))
		//	{
			//	updateNetSecurityValue(strSecurityId, Helper.correctNull((String)hshValues.get("txt_Face_Value")));
		//	}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in updateFinDocNonTradeable :::  " + e.getMessage());
		}
	}
    public HashMap getFinDocNonTradeable(HashMap hshValues)
    {
    	HashMap hshResult=new HashMap();
		ResultSet rs=null;
		String strQuery =null;
		String strSecurityId=null;
		try
		{
			strSecurityId = correctNull((String) hshValues.get("hidSecurityId"));
			
			if(strSecurityId.equalsIgnoreCase(""))
			{
				strSecurityId=Helper.correctNull((String)hshValues.get("hidsecid"));
			}
			strQuery = SQLParser.getSqlQuery("sel_security_nontradeable^"+strSecurityId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{	
				hshResult.put("sec_rated",Helper.correctNull(rs.getString("sec_rated")));
				hshResult.put("sec_agency",Helper.correctNull(rs.getString("sec_agency")));
				hshResult.put("sec_symbol",Helper.correctNull(rs.getString("sec_symbol")));
				hshResult.put("sec_policyno",Helper.correctNull(rs.getString("sec_policyno")));
				hshResult.put("sec_policydate",Helper.correctNull(rs.getString("sec_policydate")));
				hshResult.put("sec_issuedby",Helper.correctNull(rs.getString("sec_issuedby")));
				hshResult.put("sec_specify",Helper.correctNull(rs.getString("sec_specify")));
				hshResult.put("sec_currencytype",Helper.correctNull(rs.getString("sec_currencytype")));
				hshResult.put("sec_facevalue",Helper.correctNull(rs.getString("sec_facevalue")));
				hshResult.put("sec_maturityvalue",Helper.correctNull(rs.getString("sec_maturityvalue")));
				hshResult.put("sec_surrendervalue",Helper.correctNull(rs.getString("sec_surrendervalue")));
				hshResult.put("sec_maturitydate",Helper.correctNull(rs.getString("sec_maturitydate")));
			}
			
			// To get the Customer Name
			String StrLAPSId = correctNull((String) hshValues.get("hidDemoId"));
			strQuery = SQLParser.getSqlQuery("sel_lapsidfromlapsid^" + StrLAPSId);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()) 
			{
				hshResult.put("perapp_fname", Helper.correctNull((String)rs.getString("perapp_fname")));
				hshResult.put("perapp_cbsid", Helper.correctNull((String)rs.getString("perapp_cbsid")));
				hshResult.put("perapp_oldid", Helper.correctNull((String)rs.getString("perapp_oldid")));
			}
			hshResult.put("strSecID", strSecurityId);
			hshResult.put("hid_VerificationFlag", Helper.correctNull((String)hshValues.get("hid_VerificationFlag")));
		}
		catch (Exception e)
		{
			log.error("Exception in getFinDocNonTradeable ::: "+ e.getMessage());
		} 
		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				log.error("Exception in getFinDocNonTradeable ::: "+ cf.getMessage());
			}
		}
		return hshResult;
    }
    public void updateFinDocTradeable(HashMap hshValues)
	{
    	HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues= new ArrayList();
		String strSecurityId="";
		String strAction =Helper.correctNull((String)hshValues.get("hidAction"));
		ResultSet rs=null;
    	String strQuery="";
    	String strModifiedField[]=null;
		String strModifiedValue[]=null;
		try
		{
			strSecurityId = Helper.correctNull((String) hshValues.get("hidSecurityId"));
			if(strAction.equalsIgnoreCase("insert"))
			{
				boolean secHisflag = false;
				strQuery = SQLParser.getSqlQuery("sel_security_tradeable^"+strSecurityId);
	    		rs = DBUtils.executeQuery(strQuery);
	    		if(rs.next())
	    		{
	    			secHisflag=true;
	    		}
				
				
				hshQueryValues = new HashMap();
				hshQueryValues.put("size","1");
				hshQuery = new HashMap();		
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","del_security_tradeable");
				arrValues.add(strSecurityId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","ins_security_tradeable");
				arrValues.add(strSecurityId);
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_SecuExchCode")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Other_Specify")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Units_Held")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Present_Quoted_Rate")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Security_TotValue")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Matu_Value")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Matu_Date")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","3");
				hshQuery.put("strQueryId","upd_securities");
				arrValues.add("Y");
				arrValues.add(strSecurityId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("3",hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				if(rs!=null)
		    		rs.close();
				strQuery = SQLParser.getSqlQuery("sel_secMailbox_check^"+strSecurityId);
	    		rs = DBUtils.executeQuery(strQuery);
	    		if(rs.next())	
	    		{
	    			String mailboxflag=Helper.correctNull((String)rs.getString("SEC_FLAG"));
					if(mailboxflag.equals("NCN"))
						mailboxflag="N";
					else
						mailboxflag="V";
	    			hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","upd_secMailbox_flag");
					arrValues.add(mailboxflag);
					arrValues.add(strSecurityId);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","2");
					hshQuery.put("strQueryId","upd_cussecurities_changeflag");
					arrValues.add("V");
					arrValues.add(strSecurityId);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("2",hshQuery);
					
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
	    		}
				
				
				if(secHisflag==true)
				{
				hshQueryValues=new HashMap();
				int arrquerySize=1;
				String tempOldvalue="",tempNewvalue="",tempField="";
				if(!Helper.correctNull((String)hshValues.get("hidmodifiedField")).equals(""))
					strModifiedField = Helper.correctNull((String)hshValues.get("hidmodifiedField")).split("@") ;
				if(!Helper.correctNull((String)hshValues.get("hidmodifiedvalue")).equals(""))	
					strModifiedValue = Helper.correctNull((String)hshValues.get("hidmodifiedvalue")).split("@");
				if(strModifiedField!=null && strModifiedField.length>0)
				{
					for (int  k = 0; k < strModifiedField.length; k++) 
					{
						tempOldvalue= Helper.correctNull((String)hshValues.get(strModifiedValue[k]));
						tempNewvalue= Helper.correctNull((String)hshValues.get((strModifiedValue[k]).substring(4)));
						tempField= strModifiedField[k];
	
						arrValues=new ArrayList();
						hshQuery = new HashMap();
						arrValues.add(tempField);
						arrValues.add(tempOldvalue);
						arrValues.add(tempNewvalue);
						arrValues.add(Helper.correctNull((String)hshValues.get("strUserId")));
						arrValues.add(strSecurityId);
						hshQuery.put("arrValues", arrValues);
						hshQuery.put("strQueryId", "ins_sec_modified");
						hshQueryValues.put(Integer.toString(arrquerySize),hshQuery);
						hshQueryValues.put("size",Integer.toString(arrquerySize));
						arrquerySize++;
					}
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
				
				}
				
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_security_tradeable");
				arrValues.add(strSecurityId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","upd_securities");
				arrValues.add("N");
				arrValues.add(strSecurityId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			//Commented by Archunan as said by banker for not updating net Security Value
//			if(!strSecurityId.equalsIgnoreCase(""))
			//{
				///updateNetSecurityValue(strSecurityId, Helper.correctNull((String)hshValues.get("txt_Security_TotValue")));
			//}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in updateFinDocTradeable :::  " + e.getMessage());
		}
	}
    public HashMap getFinDocTradeable(HashMap hshValues)
    {
    	HashMap hshResult=new HashMap();
		ResultSet rs=null;
		String strQuery =null;
		String strSecurityId=null;
		try
		{
			strSecurityId = correctNull((String) hshValues.get("hidSecurityId"));
			if(strSecurityId.equalsIgnoreCase(""))
			{
				strSecurityId=Helper.correctNull((String)hshValues.get("hidsecid"));
			}
			strQuery = SQLParser.getSqlQuery("sel_security_tradeable^"+strSecurityId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{	
				hshResult.put("sec_exccode",Helper.correctNull(rs.getString("sec_exccode")));
				hshResult.put("sec_specify",Helper.correctNull(rs.getString("sec_specify")));
				hshResult.put("sec_units",Helper.correctNull(rs.getString("sec_units")));
				hshResult.put("sec_presentrate",Helper.correctNull(rs.getString("sec_presentrate")));
				hshResult.put("sec_totalvalue",Helper.correctNull(rs.getString("sec_totalvalue")));
				hshResult.put("sec_maturityvalue",Helper.correctNull(rs.getString("sec_maturityvalue")));
				hshResult.put("sec_maturitydate",Helper.correctNull(rs.getString("sec_maturitydate")));
			}
			
			// To get the Customer Name
			String StrLAPSId = correctNull((String) hshValues.get("hidDemoId"));
			strQuery = SQLParser.getSqlQuery("sel_lapsidfromlapsid^" + StrLAPSId);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()) 
			{
				hshResult.put("perapp_fname", Helper.correctNull((String)rs.getString("perapp_fname")));
				hshResult.put("perapp_cbsid", Helper.correctNull((String)rs.getString("perapp_cbsid")));
				hshResult.put("perapp_oldid", Helper.correctNull((String)rs.getString("perapp_oldid")));
			}
			
			hshResult.put("strSecID", strSecurityId);
			hshResult.put("hid_VerificationFlag", Helper.correctNull((String)hshValues.get("hid_VerificationFlag")));
		}
		catch (Exception e)
		{
			log.error("Exception in getFinDocTradeable ::: "+ e.getMessage());
		} 
		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				log.error("Exception in getFinDocTradeable ::: "+ cf.getMessage());
			}
		}
		return hshResult;
    }
    public void updateSecurityVehicle(HashMap hshValues)
	{
    	HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues= new ArrayList();
		String strSecurityId="";
		String strAction =Helper.correctNull((String)hshValues.get("hidAction"));
		ResultSet rs=null;
    	String strQuery="";
    	String strModifiedField[]=null;
		String strModifiedValue[]=null;
		try
		{
			strSecurityId = Helper.correctNull((String) hshValues.get("hidSecurityId"));
			String strSal = Helper.correctNull((String) hshValues.get("sel_salutation"));
			if(strSal.equalsIgnoreCase(""))
				strSal = Helper.correctNull((String) hshValues.get("hidsalutation"));
			if(strAction.equalsIgnoreCase("insert"))
			{
				boolean secHisflag = false;
				strQuery = SQLParser.getSqlQuery("sel_security_vehicle^"+strSecurityId);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					secHisflag=true;
				}
				
				hshQueryValues = new HashMap();
				hshQueryValues.put("size","1");
				hshQuery = new HashMap();		
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","del_security_vehicle");
				arrValues.add(strSecurityId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","ins_security_vehicle");
				arrValues.add(strSecurityId);
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_VehicleType")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_company")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_Category")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_make")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_model")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_vehicleage")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_PurcInvoice_Price")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Present_BookVal")));
				if(!("").equalsIgnoreCase(Helper.correctNull((String)hshValues.get("txt_regno")))){
				    arrValues.add(Helper.correctNull((String)hshValues.get("txt_regno")).toUpperCase());
				}else{
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_regno")));	
				}
				if(!("").equalsIgnoreCase(Helper.correctNull((String)hshValues.get("txt_engineno")))){
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_engineno")).toUpperCase());
				}else{
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_engineno")));	
				}
				
				
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_belongsto")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_doorno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_address1")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_address2")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_city")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_state")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_district")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_country")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_pin")));
				if(!("").equalsIgnoreCase(Helper.correctNull((String)hshValues.get("txt_chassisno")))){
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_chassisno")).toUpperCase());
				}else{
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_chassisno")));	
				}
				
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_state")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_rcsubdate")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_veh_hypodate")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_lst_inspdate")));
				
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_dealer_name")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_dealercont")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_dealeraddress1")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_dealercity")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_dealeraddress2")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_dealerstate")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_dealerdistrict")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_dealercountry")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_dealerpin")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_dealermail")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_tax_paid")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_ins_valid")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hidchk_doc")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_dealercode")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_dealertin")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_cbscustid")));
				arrValues.add(strSal);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","3");
				hshQuery.put("strQueryId","upd_securities");
				arrValues.add("Y");
				arrValues.add(strSecurityId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("3",hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");

				if(rs!=null)
		    		rs.close();
				strQuery = SQLParser.getSqlQuery("sel_secMailbox_check^"+strSecurityId);
	    		rs = DBUtils.executeQuery(strQuery);
	    		if(rs.next())	
	    		{
	    			String mailboxflag=Helper.correctNull((String)rs.getString("SEC_FLAG"));
					if(mailboxflag.equals("NCN"))
						mailboxflag="N";
					else
						mailboxflag="V";
	    			hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","upd_secMailbox_flag");
					arrValues.add(mailboxflag);
					arrValues.add(strSecurityId);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","2");
					hshQuery.put("strQueryId","upd_cussecurities_changeflag");
					arrValues.add("V");
					arrValues.add(strSecurityId);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("2",hshQuery);
					
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
	    		}
				
				if(secHisflag==true)
				{
					hshQueryValues=new HashMap();
					int arrquerySize=1;
					String tempOldvalue="",tempNewvalue="",tempField="";
					if(!Helper.correctNull((String)hshValues.get("hidmodifiedField")).equals(""))
						strModifiedField = Helper.correctNull((String)hshValues.get("hidmodifiedField")).split("@") ;
					if(!Helper.correctNull((String)hshValues.get("hidmodifiedvalue")).equals(""))	
						strModifiedValue = Helper.correctNull((String)hshValues.get("hidmodifiedvalue")).split("@");
					if(strModifiedField!=null && strModifiedField.length>0)
					{
						for (int  k = 0; k < strModifiedField.length; k++) 
						{
							tempOldvalue= Helper.correctNull((String)hshValues.get(strModifiedValue[k]));
							tempNewvalue= Helper.correctNull((String)hshValues.get((strModifiedValue[k]).substring(4)));
							tempField= strModifiedField[k];
		
							arrValues=new ArrayList();
							hshQuery = new HashMap();
							arrValues.add(tempField);
							arrValues.add(tempOldvalue);
							arrValues.add(tempNewvalue);
							arrValues.add(Helper.correctNull((String)hshValues.get("strUserId")));
							arrValues.add(strSecurityId);
							hshQuery.put("arrValues", arrValues);
							hshQuery.put("strQueryId", "ins_sec_modified");
							hshQueryValues.put(Integer.toString(arrquerySize),hshQuery);
							hshQueryValues.put("size",Integer.toString(arrquerySize));
							arrquerySize++;
						}
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					}
					
					String engineno="", strregno="", strchasisno="", strrcsubdate="";
					// update Finacle LAPS_HYPOTHECATE table
					if(strModifiedField!=null && strModifiedField.length>0)
					{
						for (int  k = 0; k < strModifiedField.length; k++) 
						{
							tempOldvalue= Helper.correctNull((String)hshValues.get(strModifiedValue[k]));
							tempNewvalue= Helper.correctNull((String)hshValues.get((strModifiedValue[k]).substring(4)));
							tempField= strModifiedValue[k];
							if(strModifiedValue[k].equalsIgnoreCase("old_txt_regno"))
							{
								if(!tempOldvalue.equals(tempNewvalue))
								{
									strregno=tempNewvalue;
								}
								else
								{
									strregno=tempOldvalue;
								}
							}
							if(strModifiedValue[k].equalsIgnoreCase("old_txt_chassisno"))
							{
								//strchasisno=tempNewvalue;
								if(!tempOldvalue.equals(tempNewvalue))
								{
									strchasisno=tempNewvalue;
								}
								else
								{
									strchasisno=tempOldvalue;
								}
							}
							if(strModifiedValue[k].equalsIgnoreCase("old_txt_engineno"))
							{
								//engineno=tempNewvalue;
								if(!tempOldvalue.equals(tempNewvalue))
								{
									engineno=tempNewvalue;
								}
								else
								{
									engineno=tempOldvalue;
								}
							}
							
							if(strModifiedValue[k].equalsIgnoreCase("old_txt_rcsubdate"))
							{
								//strrcsubdate=tempNewvalue;
								if(!tempOldvalue.equals(tempNewvalue))
								{
									strrcsubdate=tempNewvalue;
								}
								else
								{
									strrcsubdate=tempOldvalue;
								}
							}
						}
						arrValues=new ArrayList();
						hshQuery = new HashMap();
						hshQueryValues=new HashMap();
						if(strregno.equalsIgnoreCase(""))
						{
							strregno=Helper.correctNull((String)hshValues.get("txt_regno"));
						}
						if(strchasisno.equalsIgnoreCase(""))
						{
							strchasisno=Helper.correctNull((String)hshValues.get("txt_chassisno"));
						}
						if(engineno.equalsIgnoreCase(""))
						{
							engineno=Helper.correctNull((String)hshValues.get("txt_engineno"));
						}
						if(strrcsubdate.equalsIgnoreCase(""))
						{
							strrcsubdate=Helper.correctNull((String)hshValues.get("txt_rcsubdate"));;
						}
						
						if(!("").equalsIgnoreCase(strregno)){
							arrValues.add(strregno.toUpperCase());
						}else{
							arrValues.add(strregno);	
						}
						if(!("").equalsIgnoreCase(strchasisno)){
							arrValues.add(strchasisno.toUpperCase());
						}else{
							arrValues.add(strchasisno);	
						}
						if(!("").equalsIgnoreCase(engineno)){
							arrValues.add(engineno.toUpperCase());
						}else{
							arrValues.add(engineno);	
						}
						arrValues.add(strrcsubdate);
						
						arrValues.add(strSecurityId);
						hshQuery.put("arrValues", arrValues);
						hshQuery.put("strQueryId", "upd_laps_hypothecate");
						hshQueryValues.put("1",hshQuery);
						hshQueryValues.put("size","1");
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					}
				}

			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_security_vehicle");
				arrValues.add(strSecurityId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","upd_securities");
				arrValues.add("N");
				arrValues.add(strSecurityId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			//Commented by Archunan as said by banker for not updating net Security Value
//			if(!strSecurityId.equalsIgnoreCase(""))
//			{
//				updateNetSecurityValue(strSecurityId, Helper.correctNull((String)hshValues.get("txt_Present_BookVal")));
//			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in updateSecurityVehicle :::  " + e.getMessage());
		}
	}
    public HashMap getSecurityVehicle(HashMap hshValues)
    {
    	HashMap hshResult=new HashMap();
		ResultSet rs=null,rs1=null;
		String strQuery =null;
		String strSecurityId=null;
		String strGradeId="",appno="";
		try
		{
			strSecurityId = correctNull((String) hshValues.get("hidSecurityId"));
			if(strSecurityId.equalsIgnoreCase(""))
			{
				strSecurityId=Helper.correctNull((String)hshValues.get("hidsecid"));
			}
			strQuery = SQLParser.getSqlQuery("sel_security_vehicle^"+strSecurityId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{	
				hshResult.put("sec_vehicletype",Helper.correctNull(rs.getString("sec_vehicletype")));
				hshResult.put("sec_company",Helper.correctNull(rs.getString("sec_company")));
				hshResult.put("sec_vehiclecat",Helper.correctNull(rs.getString("sec_vehiclecat")));
				hshResult.put("sec_make",Helper.correctNull(rs.getString("sec_make")));
				hshResult.put("sec_model",Helper.correctNull(rs.getString("sec_model")));
				hshResult.put("sec_age",Helper.correctNull(rs.getString("sec_age")));
				hshResult.put("sec_purchasevalue",Helper.correctNull(rs.getString("sec_purchasevalue")));
				hshResult.put("sec_bookvalue",Helper.correctNull(rs.getString("sec_bookvalue")));
				hshResult.put("sec_regno",Helper.correctNull(rs.getString("sec_regno")));
				hshResult.put("sec_hpno",Helper.correctNull(rs.getString("sec_hpno")));
				hshResult.put("SEC_CHASSISNO",Helper.correctNull(rs.getString("SEC_CHASSISNO")));
		
				hshResult.put("sec_ownername",Helper.correctNull(rs.getString("sec_ownername")));
				hshResult.put("sec_ownerdoorno",Helper.correctNull(rs.getString("sec_ownerdoorno")));
				hshResult.put("sec_owneraddress1",Helper.correctNull(rs.getString("sec_owneraddress1")));
				hshResult.put("sec_owneraddress2",Helper.correctNull(rs.getString("sec_owneraddress2")));
				hshResult.put("sec_ownerzipcode",Helper.correctNull(rs.getString("sec_ownerzipcode")));
				hshResult.put("sec_ownercitycode",Helper.correctNull(rs.getString("sec_ownercity")));
				hshResult.put("sec_ownerstatecode",Helper.correctNull(rs.getString("sec_ownerstate")));
				hshResult.put("sec_ownercountrycode",Helper.correctNull(rs.getString("sec_ownercountry")));
				hshResult.put("sec_ownerdistrictcode",Helper.correctNull(rs.getString("sec_ownerdistrict")));
				hshResult.put("SEC_VEH_REGSTATE",Helper.correctNull(rs.getString("SEC_VEH_REGSTATE")));
				
				hshResult.put("SEC_RC_SUBDATE",Helper.correctNull(rs.getString("SEC_RC_SUBDATE")));
				hshResult.put("SEC_VEH_HYPODATE",Helper.correctNull(rs.getString("SEC_VEH_HYPODATE")));
				hshResult.put("SEC_LAST_INSPDATE",Helper.correctNull(rs.getString("SEC_LAST_INSPDATE")));
				hshResult.put("sec_dealername",Helper.correctNull(rs.getString("sec_dealername")));
				hshResult.put("sec_dealercont",Helper.correctNull(rs.getString("sec_dealercont")));
				hshResult.put("sec_dealeraddress1",Helper.correctNull(rs.getString("sec_dealeraddress1")));
				hshResult.put("sec_dealercitycode",Helper.correctNull(rs.getString("sec_dealercity")));
				hshResult.put("sec_dealeraddress2",Helper.correctNull(rs.getString("sec_dealeraddress2")));
				hshResult.put("sec_dealerstatecode",Helper.correctNull(rs.getString("sec_dealerstate")));
				hshResult.put("sec_dealercountrycode",Helper.correctNull(rs.getString("sec_dealercountry")));
				hshResult.put("sec_dealerdistrictcode",Helper.correctNull(rs.getString("sec_dealerdistrict")));
				hshResult.put("sec_dealerpin",Helper.correctNull(rs.getString("sec_dealerpin")));
				hshResult.put("sec_dealermail",Helper.correctNull(rs.getString("sec_dealermail")));
				hshResult.put("sec_taxpaid",Helper.correctNull(rs.getString("sec_taxpaid")));
				hshResult.put("sec_insvalid",Helper.correctNull(rs.getString("sec_insvalid")));
				hshResult.put("SEC_DOCS",Helper.correctNull(rs.getString("SEC_DOCS")));
				hshResult.put("sec_dealercode",Helper.correctNull(rs.getString("SEC_DEALERCODE")));
				hshResult.put("sec_dealertin",Helper.correctNull(rs.getString("SEC_DEALERTINNO")));
				hshResult.put("SEC_SALUTATION",Helper.correctNull(rs.getString("SEC_SALUTATION")));
				
				if(!Helper.correctNull(rs.getString("sec_ownercity")).equalsIgnoreCase(""))
				{
					rs1=DBUtils.executeLAPSQuery("sel_citynamebycode^"+Helper.correctNull(rs.getString("sec_ownercity")));
					if(rs1.next())
						hshResult.put("sec_ownercityname",Helper.correctNull(rs1.getString("city_name")));
					
					if(rs1!=null)
						rs1.close();
				}
				
				//dealercity
				if(!Helper.correctNull(rs.getString("sec_dealercity")).equalsIgnoreCase(""))
				{
					rs1=DBUtils.executeLAPSQuery("sel_citynamebycode^"+Helper.correctNull(rs.getString("sec_dealercity")));
					if(rs1.next())
						hshResult.put("txt_dealercity",Helper.correctNull(rs1.getString("city_name")));
					
					if(rs1!=null)
						rs1.close();
				}
				
				if(!Helper.correctNull(rs.getString("sec_ownerstate")).equalsIgnoreCase(""))
				{
					rs1=DBUtils.executeLAPSQuery("sel_statenamebycode^"+Helper.correctNull(rs.getString("sec_ownerstate")));
					if(rs1.next())
						hshResult.put("sec_ownerstatename",Helper.correctNull(rs1.getString("state_name")));
					
					if(rs1!=null)
						rs1.close();
				}
				
				//dealerstate
				if(!Helper.correctNull(rs.getString("sec_dealerstate")).equalsIgnoreCase(""))
				{
					rs1=DBUtils.executeLAPSQuery("sel_statenamebycode^"+Helper.correctNull(rs.getString("sec_dealerstate")));
					if(rs1.next())
						hshResult.put("txt_dealerstate",Helper.correctNull(rs1.getString("state_name")));
					
					if(rs1!=null)
						rs1.close();
				}
				
				if(!Helper.correctNull(rs.getString("sec_ownercountry")).equalsIgnoreCase(""))
				{
					rs1=DBUtils.executeLAPSQuery("sel_countrynamebycode^"+Helper.correctNull(rs.getString("sec_ownercountry")));
					if(rs1.next())
						hshResult.put("sec_ownercountryname",Helper.correctNull(rs1.getString("con_country")));
					
					if(rs1!=null)
						rs1.close();
				}
				
				//dealercountry
				if(!Helper.correctNull(rs.getString("sec_dealercountry")).equalsIgnoreCase(""))
				{
					rs1=DBUtils.executeLAPSQuery("sel_countrynamebycode^"+Helper.correctNull(rs.getString("sec_dealercountry")));
					if(rs1.next())
						hshResult.put("txt_dealercountry",Helper.correctNull(rs1.getString("con_country")));
					
					if(rs1!=null)
						rs1.close();
				}
				if(!Helper.correctNull(rs.getString("sec_ownerdistrict")).equalsIgnoreCase(""))
				{
					rs1=DBUtils.executeLAPSQuery("sel_distnamebycode^"+Helper.correctNull(rs.getString("sec_ownerdistrict")));
					if(rs1.next())
						hshResult.put("sec_ownerdistrictname",Helper.correctNull(rs1.getString("district_desc")));
					
					if(rs1!=null)
						rs1.close();
				}
				
				//dealerdistrict
				if(!Helper.correctNull(rs.getString("sec_dealerdistrict")).equalsIgnoreCase(""))
				{
					rs1=DBUtils.executeLAPSQuery("sel_distnamebycode^"+Helper.correctNull(rs.getString("sec_dealerdistrict")));
					if(rs1.next())
						hshResult.put("txt_dealerdistrict",Helper.correctNull(rs1.getString("district_desc")));
					
					if(rs1!=null)
						rs1.close();
				}
				hshResult.put("sec_cbsid",Helper.correctNull(rs.getString("sec_cbsid")));
				
				
			}
			
		/** For Vehicle Details in Security Master by DINESH on 10/02/2014 **/	
			else {
				
			strGradeId = "A";
			strQuery = SQLParser.getSqlQuery("sel_perAutodetails^"+ strGradeId + "^" + strSecurityId);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) 
			{
				hshResult.put("sec_vehicletype", correctNull(rs.getString("auto_category")));
				hshResult.put("sec_make", correctNull(rs.getString("auto_make")));
				hshResult.put("sec_model", correctNull(rs.getString("auto_model")));
				hshResult.put("sec_purchasevalue", correctNull(rs.getString("auto_valuation")));
				hshResult.put("sec_age", correctNull(rs.getString("auto_age")));
				hshResult.put("sec_company", correctNull(rs.getString("auto_dealer")));
				hshResult.put("sec_regno", correctNull(rs.getString("auto_registration")));
				hshResult.put("sec_hpno", correctNull(rs.getString("auto_engine")));
				hshResult.put("sec_vehiclecat", correctNull(rs.getString("auto_vehicletype")));
				hshResult.put("sec_bookvalue",Helper.correctNull(rs.getString("auto_valuation")));
			}
			}
		/**END **/
			
			// To get the Customer Name
			String StrLAPSId = correctNull((String) hshValues.get("hidDemoId"));
			strQuery = SQLParser.getSqlQuery("sel_lapsidfromlapsid^" + StrLAPSId);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()) 
			{
				hshResult.put("perapp_fname", Helper.correctNull((String)rs.getString("perapp_fname")));
				hshResult.put("perapp_cbsid", Helper.correctNull((String)rs.getString("perapp_cbsid")));
				hshResult.put("perapp_oldid", Helper.correctNull((String)rs.getString("perapp_oldid")));
			}
			String CUS_SEC_VALUERCODE="";
			strQuery = SQLParser.getSqlQuery("securities_sel^"+strSecurityId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshResult.put("SEC_VALUATION_DATE", Helper.correctNull((String)rs.getString("CUS_SEC_VALUATION_DATE")));
				hshResult.put("CUS_VALSUBMITTEDDATE", Helper.correctNull((String)rs.getString("CUS_VALSUBMITTEDDATE")));
				hshResult.put("CUS_VALRECVDATE", Helper.correctNull((String)rs.getString("CUS_VALRECVDATE")));
				CUS_SEC_VALUERCODE= Helper.correctInt((String)rs.getString("CUS_SEC_VALUERCODE"));
			}
			
			//valuer - asset location valuation
			if(rs!=null)
	    		rs.close();
			strQuery = SQLParser.getSqlQuery("sel_valmasater_name^" + CUS_SEC_VALUERCODE);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()) 
			{
				hshResult.put("VALUER_VALUEDLOC", Helper.correctNull((String)rs.getString("VALUER_VALUEDLOC")));
			}
			
			hshResult.put("strSecID", strSecurityId);
			hshResult.put("hid_VerificationFlag", Helper.correctNull((String)hshValues.get("hid_VerificationFlag")));
		}
		catch (Exception e)
		{
			log.error("Exception in getSecurityVehicle ::: "+ e.getMessage());
		} 
		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				log.error("Exception in getSecurityVehicle ::: "+ cf.getMessage());
			}
		}
		return hshResult;
    }
    public void updateSecurityBankDeposit(HashMap hshValues)
	{
    	HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues= new ArrayList();
		String strSecurityId="";
		String strAction =Helper.correctNull((String)hshValues.get("hidAction"));
		ResultSet rs=null;
    	String strQuery="";
    	String strModifiedField[]=null;
		String strModifiedValue[]=null;
		try
		{
			strSecurityId = Helper.correctNull((String) hshValues.get("hidSecurityId"));
			if(strAction.equalsIgnoreCase("update")||strAction.equalsIgnoreCase("insert"))
			{
				boolean secHisflag = false;
				strQuery = SQLParser.getSqlQuery("sel_security_bankdeposit^"+strSecurityId);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					secHisflag=true;
				}
				
				hshQueryValues = new HashMap();
				hshQueryValues.put("size","1");
				hshQuery = new HashMap();		
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","del_security_bankdeposit");
				arrValues.add(strSecurityId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","ins_security_bankdeposit");
				arrValues.add(strSecurityId);
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_bank")));
				arrValues.add(Helper.correctNull((String)hshValues.get("strFldName")));
				arrValues.add(Helper.correctNull((String)hshValues.get("strFldCode")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_accountno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_rateintrest")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Issue_Date")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Face_PrinciValue")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Maturity_Value")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Present_BookValue")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Due_Date")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","3");
				hshQuery.put("strQueryId","upd_securities");
				arrValues.add("Y");
				arrValues.add(strSecurityId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("3",hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");

				if(rs!=null)
		    		rs.close();
				strQuery = SQLParser.getSqlQuery("sel_secMailbox_check^"+strSecurityId);
	    		rs = DBUtils.executeQuery(strQuery);
	    		if(rs.next())	
	    		{
	    			String mailboxflag=Helper.correctNull((String)rs.getString("SEC_FLAG"));
					if(mailboxflag.equals("NCN"))
						mailboxflag="N";
					else
						mailboxflag="V";
	    			hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","upd_secMailbox_flag");
					arrValues.add(mailboxflag);
					arrValues.add(strSecurityId);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","2");
					hshQuery.put("strQueryId","upd_cussecurities_changeflag");
					arrValues.add("V");
					arrValues.add(strSecurityId);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("2",hshQuery);
					
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
	    		}

				if(secHisflag==true)
				{
				hshQueryValues=new HashMap();
				int arrquerySize=1;
				String tempOldvalue="",tempNewvalue="",tempField="";
				if(!Helper.correctNull((String)hshValues.get("hidmodifiedField")).equals(""))
					strModifiedField = Helper.correctNull((String)hshValues.get("hidmodifiedField")).split("@") ;
				if(!Helper.correctNull((String)hshValues.get("hidmodifiedvalue")).equals(""))	
					strModifiedValue = Helper.correctNull((String)hshValues.get("hidmodifiedvalue")).split("@");
				if(strModifiedField!=null && strModifiedField.length>0)
				{
					for (int  k = 0; k < strModifiedField.length; k++) 
					{
						tempOldvalue= Helper.correctNull((String)hshValues.get(strModifiedValue[k]));
						tempNewvalue= Helper.correctNull((String)hshValues.get((strModifiedValue[k]).substring(4)));
						tempField= strModifiedField[k];
	
						arrValues=new ArrayList();
						hshQuery = new HashMap();
						arrValues.add(tempField);
						arrValues.add(tempOldvalue);
						arrValues.add(tempNewvalue);
						arrValues.add(Helper.correctNull((String)hshValues.get("strUserId")));
						arrValues.add(strSecurityId);
						hshQuery.put("arrValues", arrValues);
						hshQuery.put("strQueryId", "ins_sec_modified");
						hshQueryValues.put(Integer.toString(arrquerySize),hshQuery);
						hshQueryValues.put("size",Integer.toString(arrquerySize));
						arrquerySize++;
					}
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
				}
				
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_security_bankdeposit");
				arrValues.add(strSecurityId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","upd_securities");
				arrValues.add("N");
				arrValues.add(strSecurityId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			//Commented by Archunan as said by banker for not updating net Security Value
//			if(!strSecurityId.equalsIgnoreCase(""))
//			{
//				updateNetSecurityValue(strSecurityId, Helper.correctNull((String)hshValues.get("txt_Present_BookValue")));
//			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in updateSecurityBankDeposit :::  " + e.getMessage());
		}
	}
    public HashMap getSecurityBankDeposit(HashMap hshValues)
    {
    	HashMap hshResult=new HashMap();
		ResultSet rs=null;
		String strQuery =null;
		String strSecurityId=null;
		try
		{
			strSecurityId = correctNull((String) hshValues.get("hidSecurityId"));
			if(strSecurityId.equalsIgnoreCase(""))
			{
				strSecurityId=Helper.correctNull((String)hshValues.get("hidsecid"));
			}
			strQuery = SQLParser.getSqlQuery("sel_security_bankdeposit^"+strSecurityId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{	
				hshResult.put("sec_banktype",Helper.correctNull(rs.getString("sec_banktype")));
				hshResult.put("sec_branchname",Helper.correctNull(rs.getString("sec_branchname")));
				hshResult.put("sec_branchscode",Helper.correctNull(rs.getString("sec_branchscode")));
				hshResult.put("sec_accno",Helper.correctNull(rs.getString("sec_accno")));
				hshResult.put("sec_roi",Helper.correctNull(rs.getString("sec_roi")));
				hshResult.put("sec_dateofissue",Helper.correctNull(rs.getString("sec_dateofissue")));
				hshResult.put("sec_facevalue",Helper.correctNull(rs.getString("sec_facevalue")));
				hshResult.put("sec_maturityvalue",Helper.correctNull(rs.getString("sec_maturityvalue")));
				hshResult.put("sec_bookvalue",Helper.correctNull(rs.getString("sec_bookvalue")));
				hshResult.put("sec_duedate",Helper.correctNull(rs.getString("sec_duedate")));
			}
			// To get the Customer Name
			String StrLAPSId = correctNull((String) hshValues.get("hidDemoId"));
			strQuery = SQLParser.getSqlQuery("sel_lapsidfromlapsid^" + StrLAPSId);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()) 
			{
				hshResult.put("perapp_fname", Helper.correctNull((String)rs.getString("perapp_fname")));
				hshResult.put("perapp_cbsid", Helper.correctNull((String)rs.getString("perapp_cbsid")));
				hshResult.put("perapp_oldid", Helper.correctNull((String)rs.getString("perapp_oldid")));
			}
			hshResult.put("strSecID", strSecurityId);
			hshResult.put("hid_VerificationFlag", Helper.correctNull((String)hshValues.get("hid_VerificationFlag")));
		}
		catch (Exception e)
		{
			log.error("Exception in getSecurityBankDeposit ::: "+ e.getMessage());
		} 
		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				log.error("Exception in getSecurityBankDeposit ::: "+ cf.getMessage());
			}
		}
		return hshResult;
    }
    
	public HashMap getSecurityClassification(HashMap hshRequestValues) 
	{
		HashMap hshRecord = new HashMap();
		ResultSet rs=null;
		String strsectorType="";
		ArrayList arrCol=new ArrayList();
		ArrayList arrRow=null;
		String strSecurityClassification="";
		String  strSecType="";
		String strAppid="";
		String strSecID="";
		try
		{
			strSecurityClassification=Helper.correctNull((String)hshRequestValues.get("securityclassificationtype"));
			 strSecType=Helper.correctNull((String)hshRequestValues.get("sectype"));
			 strAppid=Helper.correctNull((String)hshRequestValues.get("appid"));
			 strSecID=Helper.correctNull((String)hshRequestValues.get("secID"));
			if(!strSecType.equals(""))
			{
				rs=DBUtils.executeLAPSQuery("selstaticdata_security1^"+strSecID+"^"+strSecType);
				arrRow=new ArrayList();
				arrCol=new ArrayList();
				if(rs.next())
				{
					
					arrCol.add(Helper.correctNull((String)rs.getString("sec_id")));
					arrCol.add(Helper.correctNull((String)rs.getString("sec_name")));
					arrRow.add(arrCol);
				}
				
				rs=DBUtils.executeLAPSQuery("selstaticdata_security^"+strSecurityClassification);
				//arrRow=new ArrayList();
				while(rs.next())
				{
					arrCol=new ArrayList();
					arrCol.add(Helper.correctNull((String)rs.getString("sec_id")));
					arrCol.add(Helper.correctNull((String)rs.getString("sec_name")));
					arrRow.add(arrCol);
				}
				hshRecord.put("arrRow",arrRow);
				hshRecord.put("strSchemeId",strSecurityClassification);
				
				
			}else{
			rs=DBUtils.executeLAPSQuery("selstaticdata_security^"+strSecurityClassification);
			arrRow=new ArrayList();
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull((String)rs.getString("sec_id")));
				arrCol.add(Helper.correctNull((String)rs.getString("sec_name")));
				arrRow.add(arrCol);
			}
			hshRecord.put("arrRow",arrRow);
			hshRecord.put("strSchemeId",strSecurityClassification);
			//hshRecord.put("schemecode",strSchemeCode);
			}
		}
		catch(Exception ce)
		{
		
			throw new EJBException("Error in getdata "+ce.toString());
		}
		
		return hshRecord;
	}
	
	
	public void updateSecurities(HashMap hshRequestValues)  {
		HashMap hshQuery = null;
		HashMap hshQueryValues = null;
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null,rs1 = null;
		String strQuery = "";
		String strSecId="",strSno="";		
		String strAppid = correctNull((String) hshRequestValues.get("hidDemoId"));
		String strAction = correctNull((String) hshRequestValues.get("hidAction"));
		String strUserId=correctNull((String) hshRequestValues.get("strUserId"));
		String strOrgCode=correctNull((String) hshRequestValues.get("strOrgCode"));
		String strCBSID=Helper.correctInt((String) hshRequestValues.get("hidCBSID"));
		String strReleaseFlag=Helper.correctNull((String)hshRequestValues.get("hidReleaseFlag"));
		String strOwnerCount="";
		int intOwnerCount=0,Count=0;
		String strSecType="",strSecStatusflag="";
		String strModifiedField[]=null;
		String strModifiedValue[]=null;
		
		try {
			if(strAppid.equalsIgnoreCase(""))
			{
				strQuery=SQLParser.getSqlQuery("sel_lapsidfromcbsid^"+strCBSID);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strAppid=Helper.correctNull((String)rs.getString("perapp_oldid"));
				}
			}
			if(rs !=null){
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("select_perappoldid^"+strAppid);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strAppid = rs.getString("perapp_oldid");				
			}
			strOwnerCount=Helper.correctNull((String)hshRequestValues.get("hidOwners"));
			intOwnerCount=Integer.parseInt(strOwnerCount);
			strSecType=correctNull((String) hshRequestValues.get("sel_securitytype"));
			if(strSecType.equalsIgnoreCase("1")||strSecType.equalsIgnoreCase("2") ||strSecType.equalsIgnoreCase("4")||strSecType.equalsIgnoreCase("23")||strSecType.equalsIgnoreCase("24")||strSecType.equalsIgnoreCase("136"))
			{
				strSecStatusflag="Y";
			}else{
				strSecStatusflag="N";
			}
			if (strAction.equalsIgnoreCase("new")) {
				// Security DETAILS
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQueryValues = new HashMap();
				hshQuery.put("strQueryId", "ins_securities");
				strSecId=getOldAppidWithSno(strAppid);
				arrValues.add(strSecId);
				arrValues.add(correctNull((String) hshRequestValues.get("sel_securitytype")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_security_type_specify")));
				arrValues.add(correctNull((String) hshRequestValues.get("sel_securityclassifcation")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_security_clasicification_specify")));
				
				arrValues.add(Helper.correctNull((String) hshRequestValues.get("txt_security_desc")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_collareral_start_date")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_collareral_end_date")));
				arrValues.add(correctNull((String) hshRequestValues.get("sel_alreadycharged")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_charged_to_institution")));
				arrValues.add(correctNull((String) hshRequestValues.get("hid_LeadBankcode")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_net_security")));
				arrValues.add(correctNull((String) hshRequestValues.get("sel_residual_risk")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_Valuers_name")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_validation_date")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_insurence_company")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_insured_amount")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_duedate")));				
				arrValues.add(correctNull((String) hshRequestValues.get("sel_jointholder")));
				arrValues.add(correctNull((String) hshRequestValues.get("strUserId")));
				arrValues.add(correctNull((String) hshRequestValues.get("strOrgCode")));
				
				strQuery = SQLParser.getSqlQuery("sel_securityCount^"+correctNull((String) hshRequestValues.get("hidSecurityId")));
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					Count = rs1.getInt("count");				
				}
				
	
				arrValues.add(correctNull((String) hshRequestValues.get("txt_net_security"))); // First Time Entry - For Residual value
	
				arrValues.add(correctNull((String) hshRequestValues.get("sel_natureCharge")));
				//added by bhaskar for Liquid secu and maturity date
				arrValues.add(correctNull((String) hshRequestValues.get("sel_weathliquid")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_matudateliq")));
				//ende			
				arrValues.add(correctNull((String) hshRequestValues.get("txt_total_secval")));
				arrValues.add(strSecStatusflag);
				if(strSecStatusflag.equals("Y"))	
					arrValues.add("V");
				else
					arrValues.add("NC");//security not completed
				arrValues.add(correctNull((String) hshRequestValues.get("hidcompanycode")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_shareval")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_noofshares")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_dateofsubmissionbybank")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_dateofreceiptbybank")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_secintID_roc")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_charid_roc")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_Valuers_code")));
				arrValues.add(correctNull((String) hshRequestValues.get("sel_type")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_cersai_id")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_CersaiDate")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_gvtscheme_name")));
				arrValues.add(correctNull((String) hshRequestValues.get("sel_property")));
				arrValues.add(correctNull((String) hshRequestValues.get("sel_lessor")));

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
				// OWNERSHIP DETAILS
				
				String strJointOwner=Helper.correctNull((String) hshRequestValues.get("sel_jointholder"));
				if(strJointOwner.equalsIgnoreCase("Y"))
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQueryValues = new HashMap();					
					for(int i=1;i<=intOwnerCount;i++)
					{
						arrValues=new ArrayList();
						hshQuery = new HashMap();
						String size=Integer.toString(i);
						int j=i;
						--j;
						if(i==1) //To add the Main Applicant
						{
							arrValues.add(strSecId);
							arrValues.add(strAppid);
							arrValues.add(Integer.toString(i));
							hshQuery.put("arrValues", arrValues);
							hshQuery.put("strQueryId", "ins_ownership_securities");
						}
						else //To add Joint Owner newly
						{
							String strOwnerID=Helper.correctNull((String)hshRequestValues.get("hid_jointID["+j+"]"));
							arrValues.add(strSecId);
							arrValues.add(strOwnerID);
							arrValues.add(Integer.toString(i));
							hshQuery.put("arrValues", arrValues);
							hshQuery.put("strQueryId", "ins_ownership_securities");
						}
						hshQueryValues.put(Integer.toString(i),hshQuery);
					}
					hshQueryValues.put("size",Integer.toString(intOwnerCount));
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
				else
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQueryValues = new HashMap();
					hshQueryValues.put("size", "1");
					hshQuery.put("strQueryId", "ins_ownership_securities");
					
					arrValues.add(strSecId);
					arrValues.add(strAppid);
					arrValues.add("1");
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");

				}
				
				String[] tempcount=null;
				int countsize=0;
				hshQueryValues = new HashMap();
				if(hshRequestValues.get("sel_approveFlag_mul") instanceof String[])
				{
					String[] txt_Valuers_name_mul = (String[])hshRequestValues.get("txt_Valuers_name_mul");
					String[] txt_dateofsubmissionbybank_mul = (String[])hshRequestValues.get("txt_dateofsubmissionbybank_mul");
					String[] txt_dateofreceiptbybank_mul = (String[])hshRequestValues.get("txt_dateofreceiptbybank_mul");
					String[] txt_validation_date_mul = (String[])hshRequestValues.get("txt_validation_date_mul");
					String[] txt_net_security_mul = (String[])hshRequestValues.get("txt_net_security_mul");
					String[] sel_approveFlag_mul = (String[])hshRequestValues.get("sel_approveFlag_mul");
					String[] txt_Valuers_Code_mul = (String[])hshRequestValues.get("txt_Valuers_code_mul");

					tempcount = (String[])hshRequestValues.get("sel_approveFlag_mul");
					 for(int i=0;i<tempcount.length;i++)
					 {
						 	countsize++;
						 	hshQuery = new HashMap();
							arrValues = new ArrayList();
							hshQueryValues.put("size", String.valueOf(countsize));
							hshQuery.put("strQueryId", "ins_sec_valuerDetails");
							arrValues.add(strSecId);
							arrValues.add(String.valueOf(i+1));
							arrValues.add(txt_Valuers_name_mul[i]);
							arrValues.add(txt_dateofsubmissionbybank_mul[i]);
							arrValues.add(txt_dateofreceiptbybank_mul[i]);
							arrValues.add(txt_validation_date_mul[i]);
							arrValues.add(txt_net_security_mul[i]);
							arrValues.add(sel_approveFlag_mul[i]);
							arrValues.add(txt_Valuers_Code_mul[i]);
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put(String.valueOf(countsize),hshQuery);
					 }
					 EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
				else
				{
					if(!Helper.correctNull((String)hshRequestValues.get("txt_Valuers_name_mul")).equalsIgnoreCase(""))
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQueryValues.put("size", "1");
						hshQuery.put("strQueryId", "ins_sec_valuerDetails");
						arrValues.add(strSecId);
						arrValues.add("1");
						arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_Valuers_name_mul")));
						arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_dateofsubmissionbybank_mul")));
						arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_dateofreceiptbybank_mul")));
						arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_validation_date_mul")));
						arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_net_security_mul")));
						arrValues.add(Helper.correctNull((String)hshRequestValues.get("sel_approveFlag_mul")));
						arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_Valuers_code_mul")));
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("1",hshQuery);
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					}
				}
				
				
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQueryValues = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "ins_sec_inbox_new");
				arrValues.add(strSecId);
				arrValues.add(strUserId);
				if(strSecStatusflag.equals("Y"))	
					arrValues.add("N");
				else
					arrValues.add("NCN");//security not completed
				arrValues.add(Helper.correctNull((String) hshRequestValues.get("strSolid")));
				arrValues.add(Helper.correctNull((String) hshRequestValues.get("strUserDepartment")));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
				//strSecId=getOldAppidWithSno(strAppid);
			/*	arrValues.add(strSecId);
				arrValues.add(strAppid);
				arrValues.add(strOwnerCount);
				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");*/
			}

			if (strAction.equalsIgnoreCase("update")) {
//				hshQueryValues = new HashMap();
//				hshQuery = new HashMap();
//				strSecId=correctNull((String) hshRequestValues.get("hidSecurityId"));
//				hshQueryValues.put("size", "1");
//				hshQuery.put("strQueryId", "del_securities");
//				arrValues.add(strSecId);
//				hshQuery.put("arrValues", arrValues);
//				hshQueryValues.put("1", hshQuery);
//				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				strSecId=correctNull((String) hshRequestValues.get("hidSecurityId"));
				
				arrValues = new ArrayList();
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "del_ownership_securities");
				arrValues.add(strSecId);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				hshQuery.put("strQueryId", "upd_cussecurities");
				//strSecId=getOldAppidWithSno(strAppid);
				arrValues.add(correctNull((String) hshRequestValues.get("sel_securitytype")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_security_type_specify")));
				arrValues.add(correctNull((String) hshRequestValues.get("sel_securityclassifcation")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_security_clasicification_specify")));
				
				arrValues.add(Helper.replaceForJavaScriptString(Helper.correctNull((String) hshRequestValues.get("txt_security_desc"))));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_collareral_start_date")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_collareral_end_date")));
				arrValues.add(correctNull((String) hshRequestValues.get("sel_alreadycharged")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_charged_to_institution")));
				arrValues.add(correctNull((String) hshRequestValues.get("hid_LeadBankcode")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_net_security")));
				arrValues.add(correctNull((String) hshRequestValues.get("sel_residual_risk")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_Valuers_name")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_validation_date")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_insurence_company")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_insured_amount")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_duedate")));				
				arrValues.add(correctNull((String) hshRequestValues.get("sel_jointholder")));
//				arrValues.add(correctNull((String) hshRequestValues.get("strUserId")));
//				arrValues.add(correctNull((String) hshRequestValues.get("strOrgCode")));
				
				strQuery = SQLParser.getSqlQuery("sel_securityCount^"+correctNull((String) hshRequestValues.get("hidSecurityId")));
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					Count = rs1.getInt("count");				
				}
				
				if(Count>0)
				{
					arrValues.add(correctNull((String) hshRequestValues.get("txt_net_security")));
				}
				else
				{
					arrValues.add(correctNull((String) hshRequestValues.get("txt_residual_amount")));
				}
				arrValues.add(correctNull((String) hshRequestValues.get("sel_natureCharge")));
				arrValues.add(correctNull((String) hshRequestValues.get("sel_weathliquid")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_matudateliq")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_total_secval")));
//				arrValues.add(strSecStatusflag);
				arrValues.add(correctNull((String) hshRequestValues.get("hidcompanycode")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_shareval")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_noofshares")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_dateofsubmissionbybank")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_dateofreceiptbybank")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_comments")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_secintID_roc")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_charid_roc")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_Valuers_code")));
				arrValues.add(correctNull((String) hshRequestValues.get("sel_type")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_cersai_id")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_CersaiDate")));
				arrValues.add(correctNull((String) hshRequestValues.get("txt_gvtscheme_name")));
				
				arrValues.add(correctNull((String) hshRequestValues.get("sel_property")));
				arrValues.add(correctNull((String) hshRequestValues.get("sel_lessor")));
				
				arrValues.add(strSecId);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", "1");
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
				if(correctNull((String) hshRequestValues.get("sel_jointholder")).equals("Y"))
				{
					hshQueryValues = new HashMap();	
					int j=0;
					for(int i=1;i<=intOwnerCount;i++)
					{
						String strOwnerID=Helper.correctNull((String)hshRequestValues.get("hid_jointID["+i+"]"));
						if(!strOwnerID.equalsIgnoreCase(""))
						{
							j++;
						arrValues=new ArrayList();
						hshQuery = new HashMap();
						String size=Integer.toString(i);
						if(i==1) //To add the Main Applicant
						{
							arrValues.add(strSecId);
							arrValues.add(strAppid);
							arrValues.add(Integer.toString(i));
							hshQuery.put("arrValues", arrValues);
							hshQuery.put("strQueryId", "ins_ownership_securities");
						}
						else //To add Joint Owner newly
						{
								arrValues.add(strSecId);
								arrValues.add(strOwnerID);
								arrValues.add(Integer.toString(i));
								hshQuery.put("arrValues", arrValues);
								hshQuery.put("strQueryId", "ins_ownership_securities");
						}
						hshQueryValues.put(Integer.toString(j),hshQuery);
						}
					}
				
				hshQueryValues.put("size",Integer.toString(j));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
				else
				{
					hshQueryValues = new HashMap();	
					int j=0;
					for(int i=1;i<=intOwnerCount;i++)
					{
						String strOwnerID=Helper.correctNull((String)hshRequestValues.get("hid_jointID["+i+"]"));
						if(!strOwnerID.equalsIgnoreCase(""))
						{
							arrValues=new ArrayList();
							hshQuery = new HashMap();
							String size=Integer.toString(i);
							if(i==1) //To add the Main Applicant
							{
								j++;
								arrValues.add(strSecId);
								arrValues.add(strAppid);
								arrValues.add(Integer.toString(i));
								hshQuery.put("arrValues", arrValues);
								hshQuery.put("strQueryId", "ins_ownership_securities");
								hshQueryValues.put(Integer.toString(j),hshQuery);
							}
						}
					}
					hshQueryValues.put("size",Integer.toString(j));
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}

				String[] tempcount=null;
				int countsize=0;
				hshQueryValues = new HashMap();
				if(hshRequestValues.get("sel_approveFlag_mul") instanceof String[])
				{
					countsize++;
					arrValues = new ArrayList();
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					hshQueryValues.put("size", String.valueOf(countsize));
					hshQuery.put("strQueryId", "del_sec_valuerDetails");
					arrValues.add(strSecId);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(String.valueOf(countsize),hshQuery);
					
					String[] txt_Valuers_name_mul = (String[])hshRequestValues.get("txt_Valuers_name_mul");
					String[] txt_dateofsubmissionbybank_mul = (String[])hshRequestValues.get("txt_dateofsubmissionbybank_mul");
					String[] txt_dateofreceiptbybank_mul = (String[])hshRequestValues.get("txt_dateofreceiptbybank_mul");
					String[] txt_validation_date_mul = (String[])hshRequestValues.get("txt_validation_date_mul");
					String[] txt_net_security_mul = (String[])hshRequestValues.get("txt_net_security_mul");
					String[] sel_approveFlag_mul = (String[])hshRequestValues.get("sel_approveFlag_mul");
					String[] txt_Valuers_Code_mul = (String[])hshRequestValues.get("txt_Valuers_code_mul");

					tempcount = (String[])hshRequestValues.get("sel_approveFlag_mul");
					 for(int i=0;i<tempcount.length;i++)
					 {
						 	countsize++;
						 	hshQuery = new HashMap();
							arrValues = new ArrayList();
							hshQueryValues.put("size", String.valueOf(countsize));
							hshQuery.put("strQueryId", "ins_sec_valuerDetails");
							arrValues.add(strSecId);
							arrValues.add(String.valueOf(i+1));
							arrValues.add(txt_Valuers_name_mul[i]);
							arrValues.add(txt_dateofsubmissionbybank_mul[i]);
							arrValues.add(txt_dateofreceiptbybank_mul[i]);
							arrValues.add(txt_validation_date_mul[i]);
							arrValues.add(txt_net_security_mul[i]);
							arrValues.add(sel_approveFlag_mul[i]);
							arrValues.add(txt_Valuers_Code_mul[i]);
							
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put(String.valueOf(countsize),hshQuery);
					 }
					 EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
				else
				{
					if(!Helper.correctNull((String)hshRequestValues.get("txt_Valuers_name_mul")).equalsIgnoreCase(""))
					{
						arrValues = new ArrayList();
						hshQueryValues = new HashMap();
						hshQuery = new HashMap();
						hshQueryValues.put("size", "2");
						hshQuery.put("strQueryId", "del_sec_valuerDetails");
						arrValues.add(strSecId);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("1",hshQuery);
						
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "ins_sec_valuerDetails");
						arrValues.add(strSecId);
						arrValues.add("1");
						arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_Valuers_name_mul")));
						arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_dateofsubmissionbybank_mul")));
						arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_dateofreceiptbybank_mul")));
						arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_validation_date_mul")));
						arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_net_security_mul")));
						arrValues.add(Helper.correctNull((String)hshRequestValues.get("sel_approveFlag_mul")));
						arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_Valuers_code_mul")));
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("2",hshQuery);
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					}
				}
				
				if(strOwnerCount.equalsIgnoreCase("1"))
				{
					hshQueryValues=new HashMap();
					arrValues=new ArrayList();
					hshQuery = new HashMap();
					arrValues.add(strSecId);
					arrValues.add(strAppid);
					arrValues.add("1");
					hshQuery.put("arrValues", arrValues);
					hshQuery.put("strQueryId", "ins_ownership_securities");
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
				
				hshQueryValues=new HashMap();
				int arrquerySize=1;
				String tempOldvalue="",tempNewvalue="",tempField="";
				if(!Helper.correctNull((String)hshRequestValues.get("hidmodifiedField")).equals(""))
					strModifiedField = Helper.correctNull((String)hshRequestValues.get("hidmodifiedField")).split("@") ;
				if(!Helper.correctNull((String)hshRequestValues.get("hidmodifiedvalue")).equals(""))	
					strModifiedValue = Helper.correctNull((String)hshRequestValues.get("hidmodifiedvalue")).split("@");
				if(strModifiedField!=null && strModifiedField.length>0)
				{
					for (int  k = 0; k < strModifiedField.length; k++) 
					{
						tempOldvalue= Helper.correctNull((String)hshRequestValues.get(strModifiedValue[k]));
						tempNewvalue= Helper.correctNull((String)hshRequestValues.get((strModifiedValue[k]).substring(4)));
						tempField= strModifiedField[k];
	
						arrValues=new ArrayList();
						hshQuery = new HashMap();
						arrValues.add(tempField);
						arrValues.add(tempOldvalue);
						arrValues.add(tempNewvalue);
						arrValues.add(Helper.correctNull((String)hshRequestValues.get("strUserId")));
						arrValues.add(strSecId);
						hshQuery.put("arrValues", arrValues);
						hshQuery.put("strQueryId", "ins_sec_modified");
						hshQueryValues.put(Integer.toString(arrquerySize),hshQuery);
						hshQueryValues.put("size",Integer.toString(arrquerySize));
						arrquerySize++;
					}
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
				
				if(rs !=null)
					rs.close();
				String cus_sec_statusflag="";
				strQuery = SQLParser.getSqlQuery("securities_sel^"+strSecId);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					cus_sec_statusflag =Helper.correctNull((String)rs.getString("cus_sec_statusflag"));				
				}
				
				if( 
				(!Helper.correctNull((String)hshRequestValues.get("txt_net_security")).equals(Helper.correctNull((String)hshRequestValues.get("old_txt_net_security")))) ||
				(!Helper.correctNull((String)hshRequestValues.get("txt_Valuers_name")).equals(Helper.correctNull((String)hshRequestValues.get("old_txt_Valuers_name")))) ||
				(!Helper.correctNull((String)hshRequestValues.get("txt_validation_date")).equals(Helper.correctNull((String)hshRequestValues.get("old_txt_validation_date"))))
				)
				{
					
					if(rs !=null)
						rs.close();
					strQuery = SQLParser.getSqlQuery("sel_secMailbox_check^"+strSecId);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQueryValues = new HashMap();
						hshQueryValues.put("size", "1");
						hshQuery.put("strQueryId", "upd_sec_inbox_mod");
						
						if(cus_sec_statusflag.equals("Y"))
						{
							arrValues.add("V");
						}
						else
						{
							if(strSecStatusflag.equals("Y"))	
								arrValues.add("V");
							else
								arrValues.add("NCV");//security not completed
						}
						if((!Helper.correctNull((String)hshRequestValues.get("txt_net_security")).equals(Helper.correctNull(rs.getString("sec_securityvalue_old"))))||(!Helper.correctNull((String)hshRequestValues.get("txt_charged_to_institution")).equals(Helper.correctNull(rs.getString("sec_amtcharged_old")))))
						{
							arrValues.add(Helper.correctNull(rs.getString("sec_securityvalue_old")));
							arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_net_security")));
							arrValues.add(Helper.correctNull(rs.getString("sec_amtcharged_old")));
							arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_charged_to_institution")));
						}
						else if((!Helper.correctNull((String)hshRequestValues.get("txt_net_security")).equals(Helper.correctNull((String)hshRequestValues.get("old_txt_net_security"))))||(!Helper.correctNull((String)hshRequestValues.get("txt_charged_to_institution")).equals(Helper.correctNull((String)hshRequestValues.get("old_txt_charged_to_institution")))))
						{
							arrValues.add(Helper.correctNull((String)hshRequestValues.get("old_txt_net_security")));
							arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_net_security")));
							arrValues.add(Helper.correctNull((String)hshRequestValues.get("old_txt_charged_to_institution")));
							arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_charged_to_institution")));
						}
						else
						{
							arrValues.add("");arrValues.add("");
							arrValues.add("");arrValues.add("");
						}
						
						if(!Helper.correctNull((String)hshRequestValues.get("txt_Valuers_name")).equals(Helper.correctNull(rs.getString("SEC_VALUERNAME_OLD"))))
						{
							arrValues.add(Helper.correctNull(rs.getString("SEC_VALUERNAME_OLD")));
							arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_Valuers_name")));
						}
						else if(!Helper.correctNull((String)hshRequestValues.get("txt_Valuers_name")).equals(Helper.correctNull((String)hshRequestValues.get("old_txt_Valuers_name"))))
						{
							arrValues.add(Helper.correctNull((String)hshRequestValues.get("old_txt_Valuers_name")));
							arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_Valuers_name")));
						}
						else
						{
							arrValues.add("");arrValues.add("");
						}
						if(!Helper.correctNull((String)hshRequestValues.get("txt_validation_date")).equals(Helper.correctNull(rs.getString("SEC_VALUATIONDATE_OLD"))))
						{
							arrValues.add(Helper.correctNull(rs.getString("SEC_VALUATIONDATE_OLD")));
							arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_validation_date")));
						}
						else if(!Helper.correctNull((String)hshRequestValues.get("txt_validation_date")).equals(Helper.correctNull((String)hshRequestValues.get("old_txt_validation_date"))))
						{
							arrValues.add(Helper.correctNull((String)hshRequestValues.get("old_txt_validation_date")));
							arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_validation_date")));
						}
						else
						{
							arrValues.add("");arrValues.add("");
						}
						if(!Helper.correctNull((String)hshRequestValues.get("txt_Valuers_code")).equals(Helper.correctNull(rs.getString("sec_valuercode_old"))))
						{
							arrValues.add(Helper.correctNull(rs.getString("sec_valuercode_old")));
							arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_Valuers_code")));
						}
						else if(!Helper.correctNull((String)hshRequestValues.get("txt_Valuers_code")).equals(Helper.correctNull((String)hshRequestValues.get("old_txt_Valuers_code"))))
						{
							arrValues.add(Helper.correctNull((String)hshRequestValues.get("old_txt_Valuers_code")));
							arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_Valuers_code")));
						}
						else
						{
							arrValues.add("");arrValues.add("");
						}
						arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_comments")));
						arrValues.add(strSecId);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("1",hshQuery);
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");				
					}
					else
					{
					
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQueryValues = new HashMap();
						hshQueryValues.put("size", "1");
						hshQuery.put("strQueryId", "ins_sec_inbox_mod");
						arrValues.add(strSecId);
						arrValues.add(strUserId);
						if(cus_sec_statusflag.equals("Y"))
						{
							arrValues.add("V");
						}
						else
						{
							if(strSecStatusflag.equals("Y"))	
								arrValues.add("V");
							else
								arrValues.add("NCV");//security not completed
						}
						if((!Helper.correctNull((String)hshRequestValues.get("txt_net_security")).equals(Helper.correctNull((String)hshRequestValues.get("old_txt_net_security"))))||(!Helper.correctNull((String)hshRequestValues.get("txt_charged_to_institution")).equals(Helper.correctNull((String)hshRequestValues.get("old_txt_charged_to_institution")))))
						{
							arrValues.add(Helper.correctNull((String)hshRequestValues.get("old_txt_net_security")));
							arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_net_security")));
							arrValues.add(Helper.correctNull((String)hshRequestValues.get("old_txt_charged_to_institution")));
							arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_charged_to_institution")));
						}
						else
						{
							arrValues.add("");arrValues.add("");
							arrValues.add("");arrValues.add("");
						}
						
						
						if(!Helper.correctNull((String)hshRequestValues.get("txt_Valuers_name")).equals(Helper.correctNull((String)hshRequestValues.get("old_txt_Valuers_name"))))
						{
							arrValues.add(Helper.correctNull((String)hshRequestValues.get("old_txt_Valuers_name")));
							arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_Valuers_name")));
						}
						else
						{
							arrValues.add("");arrValues.add("");
						}
						if(!Helper.correctNull((String)hshRequestValues.get("txt_validation_date")).equals(Helper.correctNull((String)hshRequestValues.get("old_txt_validation_date"))))
						{
							arrValues.add(Helper.correctNull((String)hshRequestValues.get("old_txt_validation_date")));
							arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_validation_date")));
						}
						else
						{
							arrValues.add("");arrValues.add("");
						}
						
						arrValues.add(Helper.correctNull((String)hshRequestValues.get("strSolid")));
						arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_comments")));
						arrValues.add(Helper.correctNull((String)hshRequestValues.get("strUserDepartment")));
						if(!Helper.correctNull((String)hshRequestValues.get("txt_Valuers_code")).equals(Helper.correctNull((String)hshRequestValues.get("old_txt_Valuers_code"))))
						{
							arrValues.add(Helper.correctNull((String)hshRequestValues.get("old_txt_Valuers_code")));
							arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_Valuers_code")));
						}
						else
						{
							arrValues.add("");arrValues.add("");
						}
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("1",hshQuery);
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					}
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQueryValues = new HashMap();
					hshQueryValues.put("size", "1");
					hshQuery.put("strQueryId", "upd_cussecurities_changeflag");
					if(cus_sec_statusflag.equals("Y"))
					{
						arrValues.add("V");
					}
					else
					{
						if(strSecStatusflag.equals("Y"))	
							arrValues.add("V");
						else
							arrValues.add("NC");//security not completed
					}
					arrValues.add(strSecId);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
				
				if(rs !=null)
					rs.close();
				strQuery = SQLParser.getSqlQuery("sel_CERSAIID^"+strSecId);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					int intsize=0;
					
					hshQueryValues=new HashMap();
					
					
					arrValues=new ArrayList();
					hshQuery = new HashMap();
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("hidstate")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("hid_District")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("hidcity")));
					arrValues.add(strSecId);
					hshQuery.put("arrValues", arrValues);
					hshQuery.put("strQueryId", "upd_Security_Land");
					hshQueryValues.put(Integer.toString(++intsize),hshQuery);
					hshQueryValues.put("size",Integer.toString(intsize));
					
					
					if(!Helper.correctNull(rs.getString("Sec_State")).equalsIgnoreCase(Helper.correctNull((String)hshRequestValues.get("hidstate"))))
					{
						arrValues=new ArrayList();
						hshQuery = new HashMap();
						arrValues.add("State ");
						arrValues.add(Helper.correctNull(rs.getString("Sec_State")));
						arrValues.add(Helper.correctNull((String)hshRequestValues.get("c")));
						arrValues.add(Helper.correctNull((String)hshRequestValues.get("strUserId")));
						arrValues.add(strSecId);
						hshQuery.put("arrValues", arrValues);
						hshQuery.put("strQueryId", "ins_sec_modified");
						hshQueryValues.put(Integer.toString(++intsize),hshQuery);
						hshQueryValues.put("size",Integer.toString(intsize));
					}
					if(!Helper.correctNull(rs.getString("Sec_District")).equalsIgnoreCase(Helper.correctNull((String)hshRequestValues.get("hid_District"))))
					{
						arrValues=new ArrayList();
						hshQuery = new HashMap();
						arrValues.add("District");
						arrValues.add(Helper.correctNull(rs.getString("Sec_District")));
						arrValues.add(Helper.correctNull((String)hshRequestValues.get("hid_District")));
						arrValues.add(Helper.correctNull((String)hshRequestValues.get("strUserId")));
						arrValues.add(strSecId);
						hshQuery.put("arrValues", arrValues);
						hshQuery.put("strQueryId", "ins_sec_modified");
						hshQueryValues.put(Integer.toString(++intsize),hshQuery);
						hshQueryValues.put("size",Integer.toString(intsize));
					}
					if(!Helper.correctNull(rs.getString("Sec_City")).equalsIgnoreCase(Helper.correctNull((String)hshRequestValues.get("hidcity"))))
					{
						arrValues=new ArrayList();
						hshQuery = new HashMap();
						arrValues.add("City/Town");
						arrValues.add(Helper.correctNull(rs.getString("Sec_City")));
						arrValues.add(Helper.correctNull((String)hshRequestValues.get("hidcity")));
						arrValues.add(Helper.correctNull((String)hshRequestValues.get("strUserId")));
						arrValues.add(strSecId);
						hshQuery.put("arrValues", arrValues);
						hshQuery.put("strQueryId", "ins_sec_modified");
						hshQueryValues.put(Integer.toString(++intsize),hshQuery);
						hshQueryValues.put("size",Integer.toString(intsize));
					}
					
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					
					
				}
				
				
			}
			if (strAction.equalsIgnoreCase("release")) {
				/*hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				strSecId=correctNull((String) hshRequestValues.get("hidSecurityId"));
				hshQueryValues.put("size", "2");
				hshQuery.put("strQueryId", "del_securities");
				arrValues.add(strSecId);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				//EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
				hshQuery = new HashMap();
				//hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "del_ownership_securities");
				arrValues.add(strSecId);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");*/
				
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				strSecId=correctNull((String) hshRequestValues.get("hidSecurityId"));
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "update_securities");
				arrValues.add(strReleaseFlag);
				arrValues.add(correctNull((String) hshRequestValues.get("strUserId")));
				arrValues.add(strSecId);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
				arrValues=new ArrayList();
				hshQuery = new HashMap();
				arrValues.add("Security released");
				arrValues.add("");
				arrValues.add("");
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("strUserId")));
				arrValues.add(strSecId);
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "ins_sec_modified");
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			
			//Removing Joint Security
			if (strAction.equalsIgnoreCase("remove")) {
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				strSecId=correctNull((String) hshRequestValues.get("hidSecurityId"));
				strSno=correctNull((String) hshRequestValues.get("hidsno"));
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "del_ownership_joint_securities");
				arrValues.add(strSecId);
				arrValues.add(strSno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
		} catch (Exception e1) {
			log.error(e1.toString());
			throw new EJBException("Error closing in updateSecurities"
					+ e1.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}

			} catch (Exception cf) {
				throw new EJBException("Error closing in updateSecurities"
						+ cf.getMessage());
			}
		}

	}
	
	public HashMap getSecuritiesbySecId(HashMap hshRequestValues)  
	{
		HashMap hshRecord = new HashMap();
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		String strQuery = "";
		String strSecId="";
		String strJointOwnDetails="";
		
		try {
				strSecId = Helper.correctNull((String)hshRequestValues.get("hidsecid"));
				if(strSecId.equalsIgnoreCase(""))
					strSecId = Helper.correctNull((String)hshRequestValues.get("hidSecurityId"));	
				if(!strSecId.equalsIgnoreCase("")){
				strQuery = SQLParser.getSqlQuery("securities_sel^" + strSecId); 
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next()) 
				{
					hshRecord.put("cus_sec_id",correctNull((String) rs.getString("cus_sec_id")));//0
					hshRecord.put("cus_sec_type",correctNull((String) rs.getString("cus_sec_type")));//1
					hshRecord.put("cus_sec_classification",correctNull((String) rs.getString("cus_sec_classification")));//2
					hshRecord.put("cus_sec_security_description",Helper.CLOBToString(rs.getClob("cus_sec_security_description")));//3
					hshRecord.put("cus_sec_netsecurity",correctNull((String) rs.getString("cus_sec_netsecurity")));//4
					hshRecord.put("CUS_SEC_TYPE_SPECIFY",correctNull((String) rs.getString("CUS_SEC_TYPE_SPECIFY")));//5
					hshRecord.put("CUS_SEC_CLASSIFICATION_SPECIFY",correctNull((String) rs.getString("CUS_SEC_CLASSIFICATION_SPECIFY")));//6
					hshRecord.put("CUS_SEC_COLLATERAL_START_DATE",correctNull((String) rs.getString("CUS_SEC_COLLATERAL_START_DATE")));//7
					hshRecord.put("CUS_SEC_COLLATERAL_END_DATE",correctNull((String) rs.getString("CUS_SEC_COLLATERAL_END_DATE")));//8
					hshRecord.put("CUS_SEC_Already_Charged",correctNull((String) rs.getString("CUS_SEC_Already_Charged")));//9
					
					hshRecord.put("CUS_SEC_Amount_Charged",correctNull((String) rs.getString("CUS_SEC_Amount_Charged")));//9
					hshRecord.put("CUS_SEC_NAME_institution",correctNull((String) rs.getString("CUS_SEC_NAME_institution")));//10
					hshRecord.put("CUS_SEC_Residual_RiskFlag",correctNull((String) rs.getString("CUS_SEC_Residual_RiskFlag")));//11
					hshRecord.put("CUS_SEC_Valuer_Name",correctNull((String) rs.getString("CUS_SEC_Valuer_Name")));//12
					hshRecord.put("CUS_SEC_VALUATION_DATE",correctNull((String) rs.getString("CUS_SEC_VALUATION_DATE")));//13
					
					hshRecord.put("CUS_SEC_INSURENCE_COMPANY",correctNull((String) rs.getString("CUS_SEC_INSURENCE_COMPANY")));//14
					hshRecord.put("CUS_SEC_Insured_Amount",correctNull((String) rs.getString("CUS_SEC_Insured_Amount")));//15
					hshRecord.put("CUS_SEC_DUE_DATE",correctNull((String) rs.getString("CUS_SEC_DUE_DATE")));//16
					hshRecord.put("CUS_SEC_Joint_Holder",correctNull((String) rs.getString("CUS_SEC_Joint_Holder")));//17
					hshRecord.put("CUS_SEC_Createdby",correctNull((String) rs.getString("CUS_SEC_Createdby")));//18
					
					hshRecord.put("CUS_SEC_Created_branch",correctNull((String) rs.getString("CUS_SEC_Created_branch")));//19
					hshRecord.put("CUS_SEC_Created_ON",correctNull((String) rs.getString("CUS_SEC_Created_ON")));//20					
					//Getting Security Type Description for Grid..
					if(rs1 !=null)
						rs1.close();
					rs1 = DBUtils.executeLAPSQuery("selstaticdata_securitytype_sel^"+correctNull((String) rs.getString("cus_sec_type")));
					if(rs1.next())
					{
						hshRecord.put("sec_name",correctNull((String) rs1.getString("sec_name")));//21
					}
					if(rs1 !=null)
						rs1.close();
					rs1 = DBUtils.executeLAPSQuery("selstaticdata_securitytype_sel^"+correctNull((String) rs.getString("cus_sec_classification")));
					if(rs1.next())
					{
						hshRecord.put("sec_name",correctNull((String) rs1.getString("sec_name")));//22
					}else{
						
						hshRecord.put("sec_name","");//22
					}
					
					boolean bflag=true;
					strJointOwnDetails="";
					strQuery = SQLParser.getSqlQuery("securities_owner_sel^" + strSecId);
					rs1 = DBUtils.executeQuery(strQuery);
					while (rs1.next()) 
					{
						String strSeperator="@";
	
						String strId=Helper.correctNull((String)rs1.getString("cus_owner_laps_id"));
						if(bflag)
						{
							hshRecord.put("strAppid",strId);//22
							bflag=false;
						}
						String strName="";
						String strCBSID="";
						String strOldID="";
						strQuery = SQLParser.getSqlQuery("selcustomerdetails^"+strId);
						rs2 = DBUtils.executeQuery(strQuery);
						if(rs2.next())
						{
							
							 strName=Helper.correctNull((String)rs2.getString("perapp_fname"));
							 strOldID=Helper.correctNull((String)rs2.getString("perapp_oldid"));
							 strCBSID=Helper.correctNull((String)rs2.getString("perapp_cbsid"));
						}
						strJointOwnDetails+=strName;
						strJointOwnDetails+=strSeperator;
						strJointOwnDetails+=strOldID;
						strJointOwnDetails+=strSeperator;
						strJointOwnDetails+=strCBSID;
						strJointOwnDetails+=strSeperator;
					}
					strJointOwnDetails+=strSecId;
					hshRecord.put("strJointOwnDetails",strJointOwnDetails);//23					
					hshRecord.put("CUS_SEC_REIDUALVAL",correctNull((String) rs.getString("CUS_SEC_REIDUALVAL")));//24
					hshRecord.put("CUS_VALSUBMITTEDDATE",correctNull((String) rs.getString("CUS_VALSUBMITTEDDATE")));//25
					hshRecord.put("CUS_VALRECVDATE",correctNull((String) rs.getString("CUS_VALRECVDATE")));//26
					hshRecord.put("CUS_SEC_NATUREOFCHARGE",correctNull((String) rs.getString("CUS_SEC_NATUREOFCHARGE")));//27
					hshRecord.put("CUS_SEC_INTID_ROC",correctNull((String) rs.getString("CUS_SEC_INTID_ROC")));//27
					hshRecord.put("CUS_SEC_CHARGEID_ROC",correctNull((String) rs.getString("CUS_SEC_CHARGEID_ROC")));//27

					hshRecord.put("CUS_COMPANYCODE",correctNull((String) rs.getString("CUS_COMPANYCODE")));//27
					hshRecord.put("CUS_COMPANYSHARE_CNT",correctNull((String) rs.getString("CUS_COMPANYSHARE_CNT")));//27
					hshRecord.put("CUS_COMPANYSHAREVAL",correctNull((String) rs.getString("CUS_COMPANYSHAREVAL")));//27
					if(!Helper.correctNull(rs.getString("cus_companycode")).equalsIgnoreCase(""))
					{
						if(rs1!=null)
							rs1.close();
						strQuery = SQLParser.getSqlQuery("selcompanymaster_comname^"+correctNull(rs.getString("cus_companycode")));
						rs1 = DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							hshRecord.put("svm_companycinno",correctNull(rs1.getString("svm_companycinno"))); 
							hshRecord.put("svm_companyname",correctNull(rs1.getString("svm_companyname"))); 
						}
					}
					
					if(rs1!=null)
						rs1.close();
					strQuery = SQLParser.getSqlQuery("sel_static_desc^147^"+correctNull(rs.getString("CUS_SEC_NAME_institution")));
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						hshRecord.put("CUS_SEC_NAME_institution",correctNull(rs1.getString("stat_data_desc1")));
					}
					else
					{
						hshRecord.put("CUS_SEC_NAME_institution",correctNull(rs.getString("CUS_SEC_NAME_institution")));
					}
					
					if(rs1!=null)
						rs1.close();
					ArrayList tempcol=new ArrayList();
					ArrayList tempRow=new ArrayList();
					strQuery = SQLParser.getSqlQuery("sel_sec_valuerDetails^"+strSecId);
					rs1 = DBUtils.executeQuery(strQuery);
					while(rs1.next())
					{
						 tempcol=new ArrayList();
						 tempcol.add(correctNull(rs1.getString("CUS_VALUERNAME")));
						 tempcol.add(correctNull(rs1.getString("CUS_VALSUBM_DATE")));
						 tempcol.add(correctNull(rs1.getString("CUS_VALRECEIPT_DATE")));
						 tempcol.add(correctNull(rs1.getString("CUS_VALUATION_DATE")));
						 tempcol.add(Helper.checkDecimal(Helper.correctDouble((String)rs1.getString("CUS_SECURITY_VALUE"))));
						 if(correctNull(rs1.getString("CUS_APPROVE_FLAG")).equalsIgnoreCase("Y"))
							 tempcol.add("Yes");
						 else
							 tempcol.add("No");
						 tempRow.add(tempcol);
					}
					hshRecord.put("arrsec_valuerlist",tempRow);

					hshRecord.put("CUS_SEC_VALUERCODE",correctNull((String) rs.getString("CUS_SEC_VALUERCODE")));
					hshRecord.put("CUS_SEC_GOVT_VALUER",correctNull((String) rs.getString("CUS_SEC_GOVT_VALUER")));
					
					
					
				}
				}
			
			if (rs != null) 
			{rs.close();}
		} 
		catch (Exception e1) {
			log.error(e1.toString());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			}

			catch (Exception e) {
				log.error(e.toString());
			}
		}
		return hshRecord;
	
	}
	
	public HashMap getSecurities(HashMap hshRequestValues)  {
		HashMap hshRecord = new HashMap();
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		ResultSet rs4 = null;
		ResultSet rs5 = null;
		String strQuery = "";
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();
		String strAppid="";
		String strSecId="";
		String strCBSCustID="";
		String strJointOwnDetails="";
		int Count=0;
		
		try {
			strCBSCustID=Helper.correctNull((String)hshRequestValues.get("cbsid"));
			if(strCBSCustID.equalsIgnoreCase("")){
				strCBSCustID=Helper.correctNull((String)hshRequestValues.get("hidCBSID"));
			}
			if(!strCBSCustID.equalsIgnoreCase(""))
			{
				strQuery=SQLParser.getSqlQuery("sel_lapsidfromcbsid^"+strCBSCustID);
				rs5=DBUtils.executeQuery(strQuery);
				if(rs5.next())
				{
					strAppid=Helper.correctNull((String)rs5.getString("perapp_oldid"));
				}
			}
			if(strAppid.equalsIgnoreCase(""))
			{
				strAppid=Helper.correctNull((String) hshRequestValues.get("hidDemoId"));
			}
			if(strAppid.equalsIgnoreCase(""))
			{
				strAppid=Helper.correctNull((String) hshRequestValues.get("demoid"));
			}
			/*
			if(rs !=null){
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("select_perappoldid^"+strAppid);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strAppid = rs.getString("perapp_oldid");				
			}*/

			if(rs !=null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("select_securities^" + strAppid);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next()) 
				{
					String strValuationArea="";
					vecCol = new ArrayList();
					strSecId=correctNull((String) rs.getString("cus_sec_id"));
					vecCol.add(correctNull((String) rs.getString("cus_sec_id")));//0
					vecCol.add(correctNull((String) rs.getString("cus_sec_type")));//1
					vecCol.add(correctNull((String) rs.getString("cus_sec_classification")));//2
					vecCol.add(Helper.CLOBToString(rs.getClob("cus_sec_security_description")));//3
					vecCol.add(correctNull((String) rs.getString("cus_sec_netsecurity")));//4
					vecCol.add(correctNull((String) rs.getString("CUS_SEC_TYPE_SPECIFY")));//5
					vecCol.add(correctNull((String) rs.getString("CUS_SEC_CLASSIFICATION_SPECIFY")));//6
					vecCol.add(correctNull((String) rs.getString("CUS_SEC_COLLATERAL_START_DATE")));//7
					vecCol.add(correctNull((String) rs.getString("CUS_SEC_COLLATERAL_END_DATE")));//8
					vecCol.add(correctNull((String) rs.getString("CUS_SEC_Already_Charged")));//9
					
					vecCol.add(correctNull((String) rs.getString("CUS_SEC_Amount_Charged")));//10
					vecCol.add(correctNull((String) rs.getString("CUS_SEC_NAME_institution")));//11
					vecCol.add(correctNull((String) rs.getString("CUS_SEC_Residual_RiskFlag")));//12
					vecCol.add(correctNull((String) rs.getString("CUS_SEC_Valuer_Name")));//13
					vecCol.add(correctNull((String) rs.getString("CUS_SEC_VALUATION_DATE")));//14
					
					vecCol.add(correctNull((String) rs.getString("CUS_SEC_INSURENCE_COMPANY")));//15
					vecCol.add(correctNull((String) rs.getString("CUS_SEC_Insured_Amount")));//16
					vecCol.add(correctNull((String) rs.getString("CUS_SEC_DUE_DATE")));//17
					vecCol.add(correctNull((String) rs.getString("CUS_SEC_Joint_Holder")));//18
					vecCol.add(correctNull((String) rs.getString("CUS_SEC_Createdby")));//19
					
					vecCol.add(correctNull((String) rs.getString("CUS_SEC_Created_branch")));//20
					vecCol.add(correctNull((String) rs.getString("CUS_SEC_Created_ON")));//21					
					//Getting Security Type Description for Grid..
					if(rs1 !=null)
						rs1.close();
					rs1 = DBUtils.executeLAPSQuery("selstaticdata_securitytype_sel^"+correctNull((String) rs.getString("cus_sec_type")));
					if(rs1.next())
					{
						vecCol.add(correctNull((String) rs1.getString("sec_name")));//22
					}
					else
					{
						vecCol.add("");//21
					}
					if(rs1 !=null)
						rs1.close();
					rs1 = DBUtils.executeLAPSQuery("selstaticdata_securitytype_sel^"+correctNull((String) rs.getString("cus_sec_classification")));
					if(rs1.next())
					{
						vecCol.add(correctNull((String) rs1.getString("sec_name")));//23
					}else{
						
						vecCol.add("");//22
					}
					
					strJointOwnDetails="";
					strQuery = SQLParser.getSqlQuery("securities_owner_sel^" + strSecId);
					rs1 = DBUtils.executeQuery(strQuery);
					while (rs1.next()) 
					{
						String strSeperator="@";
	
						String strId=Helper.correctNull((String)rs1.getString("cus_owner_laps_id"));
						String strName="";
						String strCBSID="";
						String strOldID="";
						strQuery = SQLParser.getSqlQuery("selcustomerdetails^"+strId);
						rs2 = DBUtils.executeQuery(strQuery);
						if(rs2.next())
						{
							
							 strName=Helper.correctNull((String)rs2.getString("perapp_fname"));
							 strOldID=Helper.correctNull((String)rs2.getString("perapp_oldid"));
							 strCBSID=Helper.correctNull((String)rs2.getString("perapp_cbsid"));
						}
						strJointOwnDetails+=strName;
						strJointOwnDetails+=strSeperator;
						strJointOwnDetails+=strOldID;
						strJointOwnDetails+=strSeperator;
						strJointOwnDetails+=strCBSID;
						strJointOwnDetails+=strSeperator;
					}
					strJointOwnDetails+=strSecId;
					vecCol.add(strJointOwnDetails);//24					
					vecCol.add(correctNull((String) rs.getString("CUS_SEC_REIDUALVAL")));//25
					vecCol.add(correctNull((String) rs.getString("CUS_SEC_NATUREOFCHARGE")));//26
					
					/** For Security Details delete function in Security Master by DINESH on 07/02/2014 **/
					/**Counted for op and pa application in which app_sec_attached is A**/
					strQuery = SQLParser.getSqlQuery("sel_securityCount_master1^"+correctNull((String) rs.getString("cus_sec_id"))+"^op','pa^op','pa");
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						Count = rs1.getInt("count");				
					}
					vecCol.add(Integer.toString(Count));//27
					vecCol.add(correctNull((String) rs.getString("cus_sec_matuliddate")));//28
					vecCol.add(correctNull((String) rs.getString("cus_sec_isliqidsecu")));//29
					vecCol.add(correctNull((String) rs.getString("cus_sec_totalsecvalue")));//30
					vecCol.add(correctNull((String) rs.getString("cus_sec_statusflag")));//31
					if(Helper.correctNull(rs.getString("cus_owner_sno")).equalsIgnoreCase("1"))
						vecCol.add("Y");//32
					else
						vecCol.add("N");//32
					vecCol.add(correctNull((String) rs.getString("cus_releaseflag")));//33
					if(correctNull((String) rs.getString("cus_releaseflag")).equalsIgnoreCase("Y")){
						vecCol.add("Released on "+correctNull((String) rs.getString("cus_releasedon")));//34
					}
					else if(correctNull((String) rs.getString("cus_releaseflag")).equalsIgnoreCase("W")){
						vecCol.add("Waiting for ownership change approval");//34
					}
					else if(correctNull((String) rs.getString("cus_releaseflag")).equalsIgnoreCase("V")){
						if(rs1!=null)
							rs1.close();
						strQuery = SQLParser.getSqlQuery("sel_secVerMailbox_secval^"+correctNull((String) rs.getString("cus_sec_id")));
						rs1 = DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							if(!Helper.correctNull(rs1.getString("SEC_APPROVEDBY")).equalsIgnoreCase(""))
								vecCol.add("Verification Pending with "+Helper.correctNull(rs1.getString("SEC_APPROVEDBY")));//34
							else
								vecCol.add("Verification Pending");//34
						}
						else
						{
							vecCol.add("Verification Pending");//34
						}
					}
					else if(correctNull((String) rs.getString("cus_releaseflag")).equalsIgnoreCase("F")){
						vecCol.add("Rejected");//34
					}
					else{
						vecCol.add("Available");//34	
					}
					
					if(rs1!=null)
						rs1.close();
					strQuery = SQLParser.getSqlQuery("sel_securityCount_master^"+correctNull((String) rs.getString("cus_sec_id"))+"^op^op");
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						if(Integer.parseInt(Helper.correctInt(rs1.getString("count")))>0)
							vecCol.add("Y");//35
						else
							vecCol.add("N");//35
					}
					
					//List of OP proposals 
					if(rs1!=null)
						rs1.close();
					
					String strAttachAppno = "";
					strQuery = SQLParser.getSqlQuery("sel_pending_proposals^op^"+correctNull((String) rs.getString("cus_sec_id")));
					rs1 = DBUtils.executeQuery(strQuery);
					while(rs1.next())
					{
						if(strAttachAppno.equalsIgnoreCase(""))
							strAttachAppno = Helper.correctNull(rs1.getString("APP_NO"));
						else
							strAttachAppno = strAttachAppno+","+Helper.correctNull(rs1.getString("APP_NO"));
					}
					vecCol.add(strAttachAppno);//36
					
					if(!Helper.correctNull(rs.getString("cus_companycode")).equalsIgnoreCase(""))
					{
						if(rs1!=null)
							rs1.close();
						strQuery = SQLParser.getSqlQuery("selcompanymaster_comname^"+correctNull(rs.getString("cus_companycode")));
						rs1 = DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							vecCol.add(correctNull(rs1.getString("svm_companycinno")));//37
							vecCol.add(correctNull(rs1.getString("svm_companyname")));//38
						}
						else
						{
							vecCol.add("");//37
							vecCol.add("");//38
						}
					}
					else
					{
						vecCol.add("");//37
						vecCol.add("");//38
					}
					
					vecCol.add(correctNull(rs.getString("cus_companycode")));//39
					vecCol.add(correctNull(rs.getString("cus_companyshareval")));//40
					vecCol.add(correctNull(rs.getString("cus_companyshare_cnt")));//41
					vecCol.add(correctNull(rs.getString("cus_valsubmitteddate")));//42
					vecCol.add(correctNull(rs.getString("cus_valrecvdate")));//43
					vecCol.add(correctNull(rs.getString("CUS_SEC_COMMENTS")));//44
					vecCol.add(correctNull(rs.getString("CUS_SEC_INTID_ROC")));//45
					vecCol.add(correctNull(rs.getString("CUS_SEC_CHARGEID_ROC")));//46
					
					if(rs1!=null)
						rs1.close();
					strQuery = SQLParser.getSqlQuery("sel_static_desc^147^"+correctNull(rs.getString("CUS_SEC_NAME_institution")));
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						vecCol.add(correctNull(rs1.getString("stat_data_desc1")));//47
					}
					else
					{
						vecCol.add(correctNull((String) rs.getString("CUS_SEC_NAME_institution")));//47
					}
					
					if(rs1!=null)
						rs1.close();
					strQuery = SQLParser.getSqlQuery("sel_valmasater_name^"+Helper.correctInt(rs.getString("CUS_SEC_VALUERCODE")));
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						vecCol.add(correctNull(rs1.getString("VALUER_CATEGORYCODE")));//48
						vecCol.add(correctNull(rs1.getString("VALUERS_ACTIVE")));//49
						strValuationArea=correctNull(rs1.getString("VALUER_VALUEDLOC"));
					}
					else
					{
						vecCol.add("");//48
						vecCol.add("");//49
					}
					
					if(rs1!=null)
						rs1.close();
					String temp="";
					ArrayList vectval=new ArrayList();
					ArrayList vectvalRow=new ArrayList();
					strQuery = SQLParser.getSqlQuery("sel_sec_valuerDetails^"+correctNull(rs.getString("cus_sec_id")));
					rs1 = DBUtils.executeQuery(strQuery);
					while(rs1.next())
					{
						temp=temp+correctNull(rs1.getString("CUS_SECID"))+",";
						temp=temp+correctNull(rs1.getString("CUS_SLNO"))+",";
						temp=temp+correctNull(rs1.getString("CUS_VALUERNAME"))+",";
						temp=temp+correctNull(rs1.getString("CUS_VALSUBM_DATE"))+",";
						temp=temp+correctNull(rs1.getString("CUS_VALRECEIPT_DATE"))+",";
						temp=temp+correctNull(rs1.getString("CUS_VALUATION_DATE"))+",";
						temp=temp+correctNull(rs1.getString("CUS_SECURITY_VALUE"))+",";
						temp=temp+correctNull(rs1.getString("CUS_APPROVE_FLAG"))+",";
						temp=temp+correctNull(rs1.getString("cus_valuercode"))+",";
						temp=temp+correctNull(rs1.getString("VALUER_CATEGORYCODE"))+",";
						temp=temp+correctNull(rs1.getString("valuation_limit"))+",";
						temp=temp+correctNull(rs1.getString("valuer_valuedloc"));
						temp=temp+"@";
					}
					vecCol.add(temp); //50
					vecCol.add(correctNull(rs.getString("CUS_SEC_VALUERCODE")));//51
					vecCol.add(correctNull(rs.getString("CUS_SEC_SHARETYPE")));//52
					
					if(!correctNull((String)vecCol.get(48)).equalsIgnoreCase(""))
					{
						if(rs1!=null)
							rs1.close();
						rs1 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^205^"+correctNull((String)vecCol.get(48)));
						if(rs1.next())
						{
							vecCol.add(Helper.correctDouble(rs1.getString("stat_data_value")));
						}
						else
						{
							vecCol.add("0.00");
						}
					}
					else
					{
						vecCol.add("0.00");
					}
					vecCol.add(correctNull(rs.getString("CUS_SEC_CERSAI_ID")));//54
					vecCol.add(correctNull(rs.getString("CUS_SEC_CERSAI_DATE")));//55
					
					String strCityCode="",strCityName="",strStateId="",strStateName="",strDistrictCode="",strDistrictName="";
					
					if(rs1!=null)
						rs1.close();
					rs1 = DBUtils.executeLAPSQuery("selsecpropdet^"+correctNull(rs.getString("cus_sec_id")));
					if(rs1.next())
					{
						vecCol.add(Helper.correctNull(rs1.getString("Sec_District")));//56
						vecCol.add("Y");//57
						
						strCityCode=Helper.correctNull(rs1.getString("Sec_City"));
						strCityName=Helper.correctNull(rs1.getString("Custcity"));
						strStateId=Helper.correctNull(rs1.getString("Sec_State"));
						strStateName=Helper.correctNull(rs1.getString("Custstate"));
						strDistrictCode=Helper.correctNull(rs1.getString("Sec_District"));
						strDistrictName=Helper.correctNull(rs1.getString("districtdesc"));
					}
					else
					{
						vecCol.add("");
						vecCol.add("N");
					}
					vecCol.add(strValuationArea);//58
					
					vecCol.add(strCityCode);//59
					vecCol.add(strCityName);//60
					vecCol.add(strStateId);//61
					vecCol.add(strStateName);//62
					vecCol.add(strDistrictCode);//63
					vecCol.add(strDistrictName);//64
					
					//added as part of AHP
					vecCol.add(Helper.correctNull(rs.getString("CUS_SEC_GOVT_VALUER")));//65
					vecCol.add(Helper.correctNull(rs.getString("CUS_PROPERTY_LEASEHOLD")));//66
					vecCol.add(Helper.correctNull(rs.getString("CUS_PROPERTY_LESSOR")));//67
					
					
					if(rs1!=null)
						rs1.close();
					rs1 = DBUtils.executeLAPSQuery("getfsvvalues^"+correctNull(rs.getString("cus_sec_id")));
					if(rs1.next())
					{
						vecCol.add(Helper.correctNull(rs1.getString("SEC_VALUERVALUE")));//68
						vecCol.add(Helper.correctNull(rs1.getString("SEC_SALEVALUE")));//69
					}
					else
					{
						vecCol.add("");//68
						vecCol.add("");//69
					}
					
					
					
					
//					if(rs1!=null)
//						rs1.close();
//					
//					rs1 = DBUtils.executeLAPSQuery("selsecpropdet^"+strSecId);
//					if(rs1.next())
//					{
//						vecCol.add(Helper.checkDecimal(Helper.correctNull(rs1.getString("sec_valuervalue"))));//67
//						vecCol.add(Helper.checkDecimal(Helper.correctNull(rs1.getString("sec_salevalue"))));//68
//					}
//					else
//					{
//						vecCol.add("0.00");//67
//						vecCol.add("0.00");//68
//					}
//					if(rs1!=null)
//						rs1.close();
					
					vecRow.add(vecCol);
				}
			hshRecord.put("vecRow", vecRow);
			hshRecord.put("strSecId", strSecId);
			hshRecord.put("strAppid", strAppid);
			hshRecord.put("strCBSCustID", strCBSCustID);
			
			// To get the Customer Name
			strQuery = SQLParser.getSqlQuery("sel_lapsidfromlapsid^" + strAppid);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()) 
			{
				hshRecord.put("perapp_fname", Helper.correctNull((String)rs.getString("perapp_fname")));
				hshRecord.put("perapp_cbsid", Helper.correctNull((String)rs.getString("perapp_cbsid")));
				hshRecord.put("perapp_oldid", Helper.correctNull((String)rs.getString("perapp_oldid")));
				hshRecord.put("perapp_profilestatus", Helper.correctNull((String)rs.getString("perapp_profilestatus")));
			}
			
			if (rs != null) {
				rs.close();
			}
			
		} catch (Exception e1) {
			log.error(e1.toString());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			}

			catch (Exception e) {
				log.error(e.toString());
			}
		}
		return hshRecord;
	}
	
	public String getOldAppidWithSno(String strAppid)
	{
		String strQuery="";
		ResultSet rs = null;
		String strSecId = "";
		try
		{	
			strQuery = SQLParser.getSqlQuery("getMaxSeqNoForAppOldId");
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				strSecId = strAppid + rs.getString(1);				
			}
			if(rs != null)rs.close();
		}
		catch(Exception ce)
		{
			
			throw new EJBException("Error in getMaxAckId "+ce.toString());
		}
		finally
		{
			try
			{
				if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return strSecId;
	}
	
	
	public HashMap getJointSecurity(HashMap hshRequestValues){
		
		HashMap hshRecord = new HashMap();
		ResultSet rs2 = null;
		String strQuery = "";
		ArrayList vecCol1 = new ArrayList();
		ArrayList vecRow1 = new ArrayList();
		ResultSet rs = null;
		String strSecId1="";
		String strLapsId="";
		String strAction="";
		HashMap hshValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		String strMaxSno="";
		int intSno=0;
			try{
			
			strLapsId=Helper.correctNull((String)hshRequestValues.get("lapsid")); 
			strAction=Helper.correctNull((String)hshRequestValues.get("action")); 
			strSecId1=Helper.correctNull((String) hshRequestValues.get("hidSecurityId"));
			
			if(strAction.equalsIgnoreCase("update"))
			{
				strQuery = SQLParser.getSqlQuery("sel_secownermax^" + strSecId1);
				rs= DBUtils.executeQuery(strQuery);
				intSno=Integer.parseInt(Helper.correctInt((String)rs.getString("")));
				hshValues.put("size", "1");
				hshQuery.put("strQueryId","ins_ownership_securities");
				arrValues.add(strSecId1);
				arrValues.add(strLapsId);
				arrValues.add(strSecId1);
				strQuery = SQLParser.getSqlQuery("ins_ownership_securities^" + strSecId1);
			}
			
			strQuery = SQLParser.getSqlQuery("securities_owner_sel^" + strSecId1);
			rs= DBUtils.executeQuery(strQuery);
			while (rs.next()) 
			{
				vecCol1 = new ArrayList();
				vecCol1.add(correctNull((String) rs.getString("cus_owner_laps_id")));
				if(rs2 !=null)
					rs2.close();
				strQuery = SQLParser.getSqlQuery("joint_securities_sel^" + correctNull((String) rs.getString("cus_owner_laps_id")));
				rs2 = DBUtils.executeQuery(strQuery);
				while(rs2.next()){
									
					vecCol1.add(correctNull((String) rs2.getString("name")));
					vecCol1.add(correctNull((String) rs2.getString("PERAPP_CBSID")));
				}
				vecCol1.add(correctNull((String) rs.getString("cus_owner_security_id")));
				vecCol1.add(correctNull((String) rs.getString("cus_owner_sno")));
				vecRow1.add(vecCol1);
			}
			hshRecord.put("vecRow1", vecRow1);
		}
			catch (Exception e1) {
				log.error(e1.toString());
			} finally {
				try {
					if (rs != null) {
						rs.close();
					}
				}

				catch (Exception e) {
					log.error(e.toString());
				}
			}
			return hshRecord;
			
	}
	public void updateFurnitures(HashMap hshValues)
	{
    	ResultSet rs = null;
		String strQuery=null;
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshRecord=new HashMap();
		ArrayList arrValues = new ArrayList();
    	String hidSecurityId = Helper.correctNull((String)hshValues.get("hidSecurityId"));
    	String strModifiedField[]=null;
		String strModifiedValue[]=null;
		try
		{
			String strAction = correctNull((String)hshValues.get("hidAction"));
			String txt_natureasset=Helper.correctNull((String)hshValues.get("txt_natureasset"));
			String txt_make =Helper.correctNull((String)hshValues.get("txt_make"));
			String txt_model=Helper.correctNull((String)hshValues.get("txt_model"));
			String txt_yearmanufacture=Helper.correctNull((String)hshValues.get("txt_yearmanufacture"));
			String txt_purchseinvceval =Helper.correctNull((String)hshValues.get("txt_purchseinvceval"));
			String txt_presentbookvalue=Helper.correctNull((String)hshValues.get("txt_presentbookvalue"));
			String txt_valuepervaluate=Helper.correctNull((String)hshValues.get("txt_valuepervaluate"));
			String txt_locationcity=Helper.correctNull((String)hshValues.get("hid_locationcity"));
			String strSal = Helper.correctNull((String) hshValues.get("sel_salutation"));
			if(strSal.equalsIgnoreCase(""))
				strSal = Helper.correctNull((String) hshValues.get("hidsalutation"));
			if(strAction.equalsIgnoreCase("update"))
			{
				boolean secHisflag = false;
				strQuery = SQLParser.getSqlQuery("sel_securityfurnitures^"+hidSecurityId);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					secHisflag=true;
				}
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(hidSecurityId);
				hshQuery.put("arrValues", arrValues);				
				hshQuery.put("strQueryId", "del_securityfurnitures");
				hshQuery.put("size","1");
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				
				
				hshQuery.put("strQueryId","ins_securityfurnitures");
				arrValues = new ArrayList();
				arrValues.add(hidSecurityId);//0
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_natureasset")));//1
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_make")));//2
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_model")));//3
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_yearmanufacture")));//4
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_purchseinvceval")));//5
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_presentbookvalue")));//6
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_valuepervaluate")));//7
				
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_add1")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_add2")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_belongsto")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_locationcity")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_locationdistrict")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_locationstate")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_pincode")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_locationcountry")));
				arrValues.add(strSal);
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_surveyno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_cbscustid")));
				
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("size","1");
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size","1");
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","upd_securities");
				arrValues.add("Y");
				arrValues.add(hidSecurityId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				
				if(rs!=null)
		    		rs.close();
				strQuery = SQLParser.getSqlQuery("sel_secMailbox_check^"+hidSecurityId);
	    		rs = DBUtils.executeQuery(strQuery);
	    		if(rs.next())	
	    		{
	    			String mailboxflag=Helper.correctNull((String)rs.getString("SEC_FLAG"));
					if(mailboxflag.equals("NCN"))
						mailboxflag="N";
					else
						mailboxflag="V";
	    			hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","upd_secMailbox_flag");
					arrValues.add(mailboxflag);
					arrValues.add(hidSecurityId);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","2");
					hshQuery.put("strQueryId","upd_cussecurities_changeflag");
					arrValues.add("V");
					arrValues.add(hidSecurityId);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("2",hshQuery);
					
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
	    		}
				
				if(secHisflag==true)
				{
				hshQueryValues=new HashMap();
				int arrquerySize=1;
				String tempOldvalue="",tempNewvalue="",tempField="";
				if(!Helper.correctNull((String)hshValues.get("hidmodifiedField")).equals(""))
					strModifiedField = Helper.correctNull((String)hshValues.get("hidmodifiedField")).split("@") ;
				if(!Helper.correctNull((String)hshValues.get("hidmodifiedvalue")).equals(""))	
					strModifiedValue = Helper.correctNull((String)hshValues.get("hidmodifiedvalue")).split("@");
				if(strModifiedField!=null && strModifiedField.length>0)
				{
					for (int  k = 0; k < strModifiedField.length; k++) 
					{
						tempOldvalue= Helper.correctNull((String)hshValues.get(strModifiedValue[k]));
						tempNewvalue= Helper.correctNull((String)hshValues.get((strModifiedValue[k]).substring(4)));
						tempField= strModifiedField[k];
	
						arrValues=new ArrayList();
						hshQuery = new HashMap();
						arrValues.add(tempField);
						arrValues.add(tempOldvalue);
						arrValues.add(tempNewvalue);
						arrValues.add(Helper.correctNull((String)hshValues.get("strUserId")));
						arrValues.add(hidSecurityId);
						hshQuery.put("arrValues", arrValues);
						hshQuery.put("strQueryId", "ins_sec_modified");
						hshQueryValues.put(Integer.toString(arrquerySize),hshQuery);
						hshQueryValues.put("size",Integer.toString(arrquerySize));
						arrquerySize++;
					}
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}}

			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_securityfurnitures");
				arrValues.add(hidSecurityId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","upd_securities");
				arrValues.add("N");
				arrValues.add(hidSecurityId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			//Commented by Archunan as said by banker for not updating net Security Value
//			if(!hidSecurityId.equalsIgnoreCase(""))
//			{
//				updateNetSecurityValue(hidSecurityId, txt_presentbookvalue);
//			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in updateData "+ce.toString());
		}
	}
    public HashMap getFurnitures(HashMap hshValues)
    {
    	ResultSet rs = null;
		String strQuery=null;
		String strQuery1=null;
		ResultSet rs1=null;
		HashMap hshResult = new HashMap();
		String hidSecurityId=Helper.correctNull((String)hshValues.get("hidSecurityId"));
		if(hidSecurityId.equalsIgnoreCase(""))
		{
			hidSecurityId=Helper.correctNull((String)hshValues.get("hidsecid"));
		}
		try
		{
			strQuery=SQLParser.getSqlQuery("sel_securityfurnitures^"+hidSecurityId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{  	
				hshResult.put("txt_natureasset",correctNull(rs.getString("SEC_NATUREOFASSET")));
				hshResult.put("txt_make",correctNull(rs.getString("SEC_MAKE")));
				hshResult.put("txt_model",correctNull(rs.getString("SEC_MODEL")));
				hshResult.put("txt_yearmanufacture",correctNull(rs.getString("SEC_YEAR")));
				hshResult.put("txt_purchseinvceval",correctNull(rs.getString("SEC_PURCHASEVALUE")));
				hshResult.put("txt_presentbookvalue",correctNull(rs.getString("SEC_PRESENTVALUE")));
				hshResult.put("txt_valuepervaluate",correctNull(rs.getString("SEC_VALUERVALUE")));
				
				hshResult.put("SEC_SALUTATION_NAME",correctNull(rs.getString("SEC_SALUTATION_NAME")));
				hshResult.put("SEC_SURVEYNO",correctNull(rs.getString("SEC_SURVEYNO")));
				hshResult.put("SEC_ADDRESS1",correctNull(rs.getString("SEC_ADDRESS1")));
				hshResult.put("SEC_ADDRESS2",correctNull(rs.getString("SEC_ADDRESS2")));
				hshResult.put("SEC_PINCODE",correctNull(rs.getString("SEC_PINCODE")));
				hshResult.put("SEC_CITY",correctNull(rs.getString("SEC_CITY")));
				hshResult.put("SEC_STATE",correctNull(rs.getString("SEC_STATE")));
				hshResult.put("SEC_COUNTRY",correctNull(rs.getString("SEC_COUNTRY")));
				hshResult.put("SEC_DISTRICT",correctNull(rs.getString("SEC_DISTRICT")));
				
				if(!Helper.correctNull(rs.getString("SEC_CITY")).equalsIgnoreCase(""))
				{
					rs1=DBUtils.executeLAPSQuery("sel_citynamebycode^"+Helper.correctNull(rs.getString("SEC_CITY")));
					if(rs1.next())
						hshResult.put("txt_dealercity",Helper.correctNull(rs1.getString("city_name")));
					
					if(rs1!=null)
						rs1.close();
				}
				
				
				if(!Helper.correctNull(rs.getString("SEC_STATE")).equalsIgnoreCase(""))
				{
					rs1=DBUtils.executeLAPSQuery("sel_statenamebycode^"+Helper.correctNull(rs.getString("SEC_STATE")));
					if(rs1.next())
						hshResult.put("txt_dealerstate",Helper.correctNull(rs1.getString("state_name")));
					
					if(rs1!=null)
						rs1.close();
				}
				
				
				if(!Helper.correctNull(rs.getString("SEC_COUNTRY")).equalsIgnoreCase(""))
				{
					rs1=DBUtils.executeLAPSQuery("sel_countrynamebycode^"+Helper.correctNull(rs.getString("SEC_COUNTRY")));
					if(rs1.next())
						hshResult.put("txt_dealercountry",Helper.correctNull(rs1.getString("con_country")));
					
					if(rs1!=null)
						rs1.close();
				}
				
				
				
				if(!Helper.correctNull(rs.getString("SEC_DISTRICT")).equalsIgnoreCase(""))
				{
					rs1=DBUtils.executeLAPSQuery("sel_distnamebycode^"+Helper.correctNull(rs.getString("SEC_DISTRICT")));
					if(rs1.next())
						hshResult.put("txt_dealerdistrict",Helper.correctNull(rs1.getString("district_desc")));
					
					if(rs1!=null)
						rs1.close();
				}
				hshResult.put("SEC_SALUTATION",correctNull(rs.getString("SEC_SALUTATION")));
				hshResult.put("sec_cbsid",correctNull(rs.getString("sec_cbsid")));
			}
			
			// To get the Customer Name
			String StrLAPSId = correctNull((String) hshValues.get("hidDemoId"));
			strQuery = SQLParser.getSqlQuery("sel_lapsidfromlapsid^" + StrLAPSId);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()) 
			{
				hshResult.put("perapp_fname", Helper.correctNull((String)rs.getString("perapp_fname")));
				hshResult.put("perapp_cbsid", Helper.correctNull((String)rs.getString("perapp_cbsid")));
				hshResult.put("perapp_oldid", Helper.correctNull((String)rs.getString("perapp_oldid")));
			}
			hshResult.put("strSecID", hidSecurityId);
			hshResult.put("hid_VerificationFlag", Helper.correctNull((String)hshValues.get("hid_VerificationFlag")));
		}
		catch(Exception e)
		{
			throw new EJBException("Error in updateData "+e.toString());
		}
		return hshResult;
	}

public void updateJewelDetail(HashMap hshValues)
	{
    	ResultSet rs = null;
		String strQuery=null;
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshRecord=new HashMap();
		ArrayList arrValues = new ArrayList();
		String hidSecurityId = Helper.correctNull((String)hshValues.get("hidSecurityId"));
		//String hidDemoId=correctNull((String)hshValues.get("hidDemoId"));
		boolean secHisflag = false;
		String strModifiedField[]=null;
		String strModifiedValue[]=null;
		try
		{
			String strAction = correctNull((String)hshValues.get("hidAction"));
			
			String txt_descjewel=Helper.correctNull((String)hshValues.get("txt_descjewel"));
			String txt_quality=Helper.correctNull((String)hshValues.get("txt_quality"));
			String txt_netweight =Helper.correctNull((String)hshValues.get("txt_netweight"));
			String txt_marketrate=Helper.correctNull((String)hshValues.get("txt_marketrate"));
			String txt_amount =Helper.correctNull((String)hshValues.get("txt_amount"));
			
			if(strAction.equalsIgnoreCase("update")||strAction.equalsIgnoreCase("insert"))
			{
				strQuery = SQLParser.getSqlQuery("sel_jeweldetail^"+hidSecurityId);
	    		rs = DBUtils.executeQuery(strQuery);
	    		if(rs.next())
	    		{
	    			secHisflag=true;
	    		}
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(hidSecurityId);
				hshQuery.put("arrValues", arrValues);				
				hshQuery.put("strQueryId", "del_jeweldetail");
				hshQuery.put("size","1");
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				
				hshQuery.put("strQueryId","ins_jeweldetail");
				arrValues = new ArrayList();
				arrValues.add(hidSecurityId);//0
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_descjewel")));//1
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_quality")));//2
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_netweight")));//3
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_marketrate")));//4
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_amount")));//5
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("size","1");
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				
				hshQueryValues=new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","upd_securities");
				arrValues.add("Y");
				arrValues.add(hidSecurityId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				
				if(rs!=null)
		    		rs.close();
				strQuery = SQLParser.getSqlQuery("sel_secMailbox_check^"+hidSecurityId);
	    		rs = DBUtils.executeQuery(strQuery);
	    		if(rs.next())	
	    		{
	    			String mailboxflag=Helper.correctNull((String)rs.getString("SEC_FLAG"));
					if(mailboxflag.equals("NCN"))
						mailboxflag="N";
					else
						mailboxflag="V";
	    			hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","upd_secMailbox_flag");
					arrValues.add(mailboxflag);
					arrValues.add(hidSecurityId);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","2");
					hshQuery.put("strQueryId","upd_cussecurities_changeflag");
					arrValues.add("V");
					arrValues.add(hidSecurityId);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("2",hshQuery);
					
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
	    		}
				
				if(secHisflag==true)
				{
				hshQueryValues=new HashMap();
				int arrquerySize=1;
				String tempOldvalue="",tempNewvalue="",tempField="";
				if(!Helper.correctNull((String)hshValues.get("hidmodifiedField")).equals(""))
					strModifiedField = Helper.correctNull((String)hshValues.get("hidmodifiedField")).split("@") ;
				if(!Helper.correctNull((String)hshValues.get("hidmodifiedvalue")).equals(""))	
					strModifiedValue = Helper.correctNull((String)hshValues.get("hidmodifiedvalue")).split("@");
				if(strModifiedField!=null && strModifiedField.length>0)
				{
					for (int  k = 0; k < strModifiedField.length; k++) 
					{
						tempOldvalue= Helper.correctNull((String)hshValues.get(strModifiedValue[k]));
						tempNewvalue= Helper.correctNull((String)hshValues.get((strModifiedValue[k]).substring(4)));
						tempField= strModifiedField[k];
	
						arrValues=new ArrayList();
						hshQuery = new HashMap();
						arrValues.add(tempField);
						arrValues.add(tempOldvalue);
						arrValues.add(tempNewvalue);
						arrValues.add(Helper.correctNull((String)hshValues.get("strUserId")));
						arrValues.add(hidSecurityId);
						hshQuery.put("arrValues", arrValues);
						hshQuery.put("strQueryId", "ins_sec_modified");
						hshQueryValues.put(Integer.toString(arrquerySize),hshQuery);
						hshQueryValues.put("size",Integer.toString(arrquerySize));
						arrquerySize++;
					}
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
				}
				
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();	
				arrValues.add(hidSecurityId);
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_jeweldetail");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","upd_securities");
				arrValues.add("N");
				arrValues.add(hidSecurityId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			//Commented by Archunan as said by banker for not updating net Security Value
//			if(!hidSecurityId.equalsIgnoreCase(""))
//			{
//				updateNetSecurityValue(hidSecurityId, txt_amount);
//			}
		}
		
				catch(Exception ce)
				{
					throw new EJBException("Error in updateJewelDetail "+ce.toString());
				}
	}
    public HashMap getJewelDetail(HashMap hshValues) 
    {
    	ResultSet rs = null;
		String strQuery=null;
		String strQuery1=null;
		ResultSet rs1=null;
		HashMap hshResult = new HashMap();
		String hidSecurityId=Helper.correctNull((String)hshValues.get("hidSecurityId"));
		if(hidSecurityId.equalsIgnoreCase(""))
		{
			hidSecurityId=Helper.correctNull((String)hshValues.get("hidsecid"));
		}
		try
		{
			strQuery=SQLParser.getSqlQuery("sel_jeweldetail^"+hidSecurityId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{  	
				hshResult.put("txt_descjewel",correctNull(rs.getString("SEC_JEWELDESC")));
				hshResult.put("txt_quality",correctNull(rs.getString("SEC_QUALITY")));
				hshResult.put("txt_netweight",correctNull(rs.getString("SEC_NETWT")));
				hshResult.put("txt_marketrate",correctNull(rs.getString("SEC_MARKETVALUE")));
				hshResult.put("txt_amount",correctNull(rs.getString("SEC_TOTALVALUE")));
			}
			
			// To get the Customer Name
			String StrLAPSId = correctNull((String) hshValues.get("hidDemoId"));
			strQuery = SQLParser.getSqlQuery("sel_lapsidfromlapsid^" + StrLAPSId);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()) 
			{
				hshResult.put("perapp_fname", Helper.correctNull((String)rs.getString("perapp_fname")));
				hshResult.put("perapp_cbsid", Helper.correctNull((String)rs.getString("perapp_cbsid")));
				hshResult.put("perapp_oldid", Helper.correctNull((String)rs.getString("perapp_oldid")));
			}
			hshResult.put("strSecID", hidSecurityId);
			hshResult.put("hid_VerificationFlag", Helper.correctNull((String)hshValues.get("hid_VerificationFlag")));
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getJewelDetail"+e.toString());
		}
		return hshResult;
    }
    
    public HashMap updateTitleGoods(HashMap hshValues)
	{
    	ResultSet rs = null;
		String strQuery=null;
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshRecord=new HashMap();
		ArrayList arrValues = new ArrayList();
		String hidSecurityId=Helper.correctNull((String)hshValues.get("hidSecurityId"));
		String strModifiedField[]=null;
		String strModifiedValue[]=null;
		try
		{
			String strAction = correctNull((String)hshValues.get("hidAction"));
			String txt_receiptno=Helper.correctNull((String)hshValues.get("txt_receiptno"));
			String txt_dateissue =Helper.correctNull((String)hshValues.get("txt_dateissue"));
			String txt_issuer=Helper.correctNull((String)hshValues.get("txt_issuer"));
			String txt_goodsheld=Helper.correctNull((String)hshValues.get("txt_goodsheld"));
			String txt_quantity =Helper.correctNull((String)hshValues.get("txt_quantity"));
			String txt_value =Helper.correctNull((String)hshValues.get("txt_value"));
			
			if(strAction.equalsIgnoreCase("update"))
			{

				boolean secHisflag = false;
				strQuery = SQLParser.getSqlQuery("sel_titlegoods^"+hidSecurityId);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					secHisflag=true;
				}
				
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(hidSecurityId);
				hshQuery.put("arrValues", arrValues);				
				hshQuery.put("strQueryId", "del_titlegoods");
				hshQuery.put("size","1");
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				
				hshQuery.put("strQueryId","ins_titlegoods");
				arrValues = new ArrayList();
				arrValues.add(hidSecurityId);//0
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_receiptno")));//1
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_dateissue")));//2
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_issuer")));//3
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_goodsheld")));//4
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_quantity")));//5
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_value")));
				
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("size","1");
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","upd_securities");
				arrValues.add("Y");
				arrValues.add(hidSecurityId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				
				if(rs!=null)
		    		rs.close();
				strQuery = SQLParser.getSqlQuery("sel_secMailbox_check^"+hidSecurityId);
	    		rs = DBUtils.executeQuery(strQuery);
	    		if(rs.next())	
	    		{
	    			String mailboxflag=Helper.correctNull((String)rs.getString("SEC_FLAG"));
					if(mailboxflag.equals("NCN"))
						mailboxflag="N";
					else
						mailboxflag="V";
	    			hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","upd_secMailbox_flag");
					arrValues.add(mailboxflag);
					arrValues.add(hidSecurityId);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","2");
					hshQuery.put("strQueryId","upd_cussecurities_changeflag");
					arrValues.add("V");
					arrValues.add(hidSecurityId);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("2",hshQuery);
					
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
	    		}
				
				if(secHisflag==true)
				{
				hshQueryValues=new HashMap();
				int arrquerySize=1;
				String tempOldvalue="",tempNewvalue="",tempField="";
				if(!Helper.correctNull((String)hshValues.get("hidmodifiedField")).equals(""))
					strModifiedField = Helper.correctNull((String)hshValues.get("hidmodifiedField")).split("@") ;
				if(!Helper.correctNull((String)hshValues.get("hidmodifiedvalue")).equals(""))	
					strModifiedValue = Helper.correctNull((String)hshValues.get("hidmodifiedvalue")).split("@");
				if(strModifiedField!=null && strModifiedField.length>0)
				{
					for (int  k = 0; k < strModifiedField.length; k++) 
					{
						tempOldvalue= Helper.correctNull((String)hshValues.get(strModifiedValue[k]));
						tempNewvalue= Helper.correctNull((String)hshValues.get((strModifiedValue[k]).substring(4)));
						tempField= strModifiedField[k];
	
						arrValues=new ArrayList();
						hshQuery = new HashMap();
						arrValues.add(tempField);
						arrValues.add(tempOldvalue);
						arrValues.add(tempNewvalue);
						arrValues.add(Helper.correctNull((String)hshValues.get("strUserId")));
						arrValues.add(hidSecurityId);
						hshQuery.put("arrValues", arrValues);
						hshQuery.put("strQueryId", "ins_sec_modified");
						hshQueryValues.put(Integer.toString(arrquerySize),hshQuery);
						hshQueryValues.put("size",Integer.toString(arrquerySize));
						arrquerySize++;
					}
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
				}
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_titlegoods");
				arrValues.add(hidSecurityId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","upd_securities");
				arrValues.add("N");
				arrValues.add(hidSecurityId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			//Commented by Archunan as said by banker for not updating net Security Value
//			if(!hidSecurityId.equalsIgnoreCase(""))
//			{
//				updateNetSecurityValue(hidSecurityId, txt_value);
//			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in updateTitleGoods"+ce.toString());
		}
		return hshRecord;
				
	}
    public HashMap getTitleGoods(HashMap hshValues) 
    {
    	ResultSet rs = null;
		String strQuery=null;
		String strQuery1=null;
		ResultSet rs1=null;
		HashMap hshResult = new HashMap();
		String hidSecurityId=Helper.correctNull((String)hshValues.get("hidSecurityId"));
		if(hidSecurityId.equalsIgnoreCase(""))
		{
			hidSecurityId=Helper.correctNull((String)hshValues.get("hidsecid"));
		}
		try
		{
			strQuery=SQLParser.getSqlQuery("sel_titlegoods^"+hidSecurityId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{  	
				hshResult.put("txt_receiptno",correctNull(rs.getString("SEC_RECEIPTNO")));
				hshResult.put("txt_dateissue",correctNull(rs.getString("SEC_DATEOFISSUE")));
				hshResult.put("txt_issuer",correctNull(rs.getString("SEC_ISSUERNAME")));
				hshResult.put("txt_goodsheld",correctNull(rs.getString("SEC_GOODSHELD")));
				hshResult.put("txt_quantity",correctNull(rs.getString("SEC_QUANTITY")));
				hshResult.put("txt_value",correctNull(rs.getString("SEC_VALUE")));
			}
			
			// To get the Customer Name
			String StrLAPSId = correctNull((String) hshValues.get("hidDemoId"));
			strQuery = SQLParser.getSqlQuery("sel_lapsidfromlapsid^" + StrLAPSId);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()) 
			{
				hshResult.put("perapp_fname", Helper.correctNull((String)rs.getString("perapp_fname")));
				hshResult.put("perapp_cbsid", Helper.correctNull((String)rs.getString("perapp_cbsid")));
				hshResult.put("perapp_oldid", Helper.correctNull((String)rs.getString("perapp_oldid")));
			}
			hshResult.put("strSecID", hidSecurityId);
			hshResult.put("hid_VerificationFlag", Helper.correctNull((String)hshValues.get("hid_VerificationFlag")));
		}
		catch(Exception e)
		{
			throw new EJBException("Error in updateData "+e.toString());
		}
		return hshResult;
    }
    public void updatePlantMachinery(HashMap hshValues)
	{
    	ResultSet rs = null;
		String strQuery=null;
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshRecord=new HashMap();
		ArrayList arrValues = new ArrayList();
		String hidSecurityId=Helper.correctNull((String)hshValues.get("hidSecurityId"));
		String strModifiedField[]=null;
		String strModifiedValue[]=null;
		try
		{
			String strAction = correctNull((String)hshValues.get("hidAction"));
			/*String txt_machinerytype=Helper.correctNull((String)hshValues.get("txt_machinerytype"));//sec_machinetype
			String sel_workcondition =Helper.correctNull((String)hshValues.get("sel_workcondition"));//sec_working
			String txt_manufacture=Helper.correctNull((String)hshValues.get("txt_manufacture"));//sec_manucompany
			String txt_yearmanufact =Helper.correctNull((String)hshValues.get("txt_yearmanufact"));//sec_year
			String txt_model=Helper.correctNull((String)hshValues.get("txt_model"));//sec_model
			String txt_purinvprice =Helper.correctNull((String)hshValues.get("txt_purinvprice"));//SEC_PURCHASEVALUE
			String txt_prebookval =Helper.correctNull((String)hshValues.get("txt_prebookval"));//SEC_BOOKVALUE
			String txt_balsheetval =Helper.correctNull((String)hshValues.get("txt_balsheetval"));//SEC_BALANCESHEETVALUE
			String txt_valvaluate =Helper.correctNull((String)hshValues.get("txt_valvaluate"));//SEC_VALUERVALUE
			String txt_forcedsale =Helper.correctNull((String)hshValues.get("txt_forcedsale"));//SEC_SALEVALUE
			String txt_balsheetdate =Helper.correctNull((String)hshValues.get("txt_balsheetdate"));//SEC_BALANCESHEETDATE
			String txt_lst_inspdate =Helper.correctNull((String)hshValues.get("txt_lst_inspdate"));//Last Inspection Date
			String txt_dealer_name =Helper.correctNull((String)hshValues.get("txt_dealer_name"));
			String txt_dealercont =Helper.correctNull((String)hshValues.get("txt_dealercont"));
			String txt_dealeraddress1 =Helper.correctNull((String)hshValues.get("txt_dealeraddress1"));
			String txt_dealercity =Helper.correctNull((String)hshValues.get("hid_dealercity"));
			String txt_dealeraddress2 =Helper.correctNull((String)hshValues.get("txt_dealeraddress2"));
			String txt_dealerstate =Helper.correctNull((String)hshValues.get("hid_dealerstate"));
			String txt_dealerdistrict =Helper.correctNull((String)hshValues.get("hid_dealerdistrict"));
			String txt_dealercountry =Helper.correctNull((String)hshValues.get("hid_dealercountry"));
			String txt_dealerpin =Helper.correctNull((String)hshValues.get("txt_dealerpin"));
			String txt_dealermail =Helper.correctNull((String)hshValues.get("txt_dealermail"));*/
			
			String strSal = Helper.correctNull((String) hshValues.get("sel_salutation"));
			if(strSal.equalsIgnoreCase(""))
				strSal = Helper.correctNull((String) hshValues.get("hidsalutation"));
			
			if(strAction.equalsIgnoreCase("update"))
			{
				boolean secHisflag = false;
				strQuery = SQLParser.getSqlQuery("sel_plantmachinery^"+hidSecurityId);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					secHisflag=true;
				}
				
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_plantmachinery"); 
				arrValues.add(hidSecurityId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQueryValues.put("size","1");	
				hshQuery.put("strQueryId","ins_plantmachinery");
				
				arrValues.add(hidSecurityId);//0
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_machinerytype")));//1
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_workcondition")));//2
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_manufacture")));//3
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_yearmanufact")));//4
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_model")));//5
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_balsheetval")));//6
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_purinvprice")));//7
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_prebookval")));//8
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_forcedsale")));//9
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_valvaluate")));//10
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_balsheetdate")));//11
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_lst_inspdate")));//12
				
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_dealer_name")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_dealercont")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_dealeraddress1")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_dealercity")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_dealeraddress2")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_dealerstate")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_dealerdistrict")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_dealercountry")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_dealerpin")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_dealermail")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_dealercode")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_dealertin")));
				
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_type")));
				arrValues.add(strSal);
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_belongsto")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_doorno")));
				
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_add1")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_add2")));
				
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_locationcity")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_locationdistrict")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_locationstate")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_pincode")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_locationcountry")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_cbscustid")));
				
			


				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","upd_securities");
				arrValues.add("Y");
				arrValues.add(hidSecurityId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				
				if(rs!=null)
		    		rs.close();
				strQuery = SQLParser.getSqlQuery("sel_secMailbox_check^"+hidSecurityId);
	    		rs = DBUtils.executeQuery(strQuery);
	    		if(rs.next())	
	    		{
	    			String mailboxflag=Helper.correctNull((String)rs.getString("SEC_FLAG"));
					if(mailboxflag.equals("NCN"))
						mailboxflag="N";
					else
						mailboxflag="V";
	    			hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","upd_secMailbox_flag");
					arrValues.add(mailboxflag);
					arrValues.add(hidSecurityId);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","2");
					hshQuery.put("strQueryId","upd_cussecurities_changeflag");
					arrValues.add("V");
					arrValues.add(hidSecurityId);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("2",hshQuery);
					
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
	    		}
				
				if(secHisflag==true)
				{
					hshQueryValues=new HashMap();
					int arrquerySize=1;
					String tempOldvalue="",tempNewvalue="",tempField="";
					if(!Helper.correctNull((String)hshValues.get("hidmodifiedField")).equals(""))
						strModifiedField = Helper.correctNull((String)hshValues.get("hidmodifiedField")).split("@") ;
					if(!Helper.correctNull((String)hshValues.get("hidmodifiedvalue")).equals(""))	
						strModifiedValue = Helper.correctNull((String)hshValues.get("hidmodifiedvalue")).split("@");
					if(strModifiedField!=null && strModifiedField.length>0)
					{
						for (int  k = 0; k < strModifiedField.length; k++) 
						{
							tempOldvalue= Helper.correctNull((String)hshValues.get(strModifiedValue[k]));
							tempNewvalue= Helper.correctNull((String)hshValues.get((strModifiedValue[k]).substring(4)));
							tempField= strModifiedField[k];
		
							arrValues=new ArrayList();
							hshQuery = new HashMap();
							arrValues.add(tempField);
							arrValues.add(tempOldvalue);
							arrValues.add(tempNewvalue);
							arrValues.add(Helper.correctNull((String)hshValues.get("strUserId")));
							arrValues.add(hidSecurityId);
							hshQuery.put("arrValues", arrValues);
							hshQuery.put("strQueryId", "ins_sec_modified");
							hshQueryValues.put(Integer.toString(arrquerySize),hshQuery);
							hshQueryValues.put("size",Integer.toString(arrquerySize));
							arrquerySize++;
						}
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					}
				}
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_plantmachinery");
				arrValues.add(hidSecurityId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","upd_securities");
				arrValues.add("N");
				arrValues.add(hidSecurityId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			//Commented by Archunan as said by banker for not updating net Security Value
//			if(!hidSecurityId.equalsIgnoreCase(""))
//			{
//				updateNetSecurityValue(hidSecurityId, txt_prebookval);
//			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getTitleGoods "+ce.toString());
		}
	}
    public HashMap getPlantMachinery(HashMap hshValues) 
    {
    	ResultSet rs = null;
		String strQuery=null;
		ResultSet rs1=null;
		HashMap hshResult=new HashMap();
		String hidSecurityId=Helper.correctNull((String)hshValues.get("hidSecurityId"));
		if(hidSecurityId.equalsIgnoreCase(""))
		{
			hidSecurityId=Helper.correctNull((String)hshValues.get("hidsecid"));
		}
		try
		{
			strQuery=SQLParser.getSqlQuery("sel_plantmachinery^"+hidSecurityId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{ 	
				hshResult.put("txt_machinerytype",correctNull(rs.getString("SEC_MACHINETYPE")));
				hshResult.put("sel_workcondition",correctNull(rs.getString("SEC_WORKING")));
				hshResult.put("txt_manufacture",correctNull(rs.getString("SEC_MANUCOMPANY")));
				hshResult.put("txt_yearmanufact",correctNull(rs.getString("SEC_YEAR")));
				hshResult.put("txt_model",correctNull(rs.getString("SEC_MODEL")));
				hshResult.put("txt_balsheetval",correctNull(rs.getString("SEC_BALANCESHEETVALUE")));
				hshResult.put("txt_purinvprice",correctNull(rs.getString("SEC_PURCHASEVALUE")));
				hshResult.put("txt_prebookval",correctNull(rs.getString("SEC_BOOKVALUE")));
				hshResult.put("txt_forcedsale",correctNull(rs.getString("SEC_VALUERVALUE")));
				hshResult.put("txt_valvaluate",correctNull(rs.getString("SEC_SALEVALUE")));
				hshResult.put("txt_balsheetdate",correctNull(rs.getString("SEC_BALANCESHEETDATE")));
				hshResult.put("txt_lst_inspdate",correctNull(rs.getString("SEC_LAST_INSP_DATE")));
				
				hshResult.put("txt_dealer_name",Helper.correctNull(rs.getString("sec_dealername")));
				hshResult.put("txt_dealercont",Helper.correctNull(rs.getString("sec_dealercont")));
				hshResult.put("txt_dealeraddress1",Helper.correctNull(rs.getString("sec_dealeraddress1")));
				hshResult.put("txt_dealercity1",Helper.correctNull(rs.getString("sec_dealercity")));
				hshResult.put("txt_dealeraddress2",Helper.correctNull(rs.getString("sec_dealeraddress2")));
				hshResult.put("txt_dealerstate1",Helper.correctNull(rs.getString("sec_dealerstate")));
				hshResult.put("txt_dealercountry1",Helper.correctNull(rs.getString("sec_dealercountry")));
				hshResult.put("txt_dealerdistrict1",Helper.correctNull(rs.getString("sec_dealerdistrict")));
				hshResult.put("txt_dealerpin",Helper.correctNull(rs.getString("sec_dealerpin")));
				hshResult.put("txt_dealermail",Helper.correctNull(rs.getString("sec_dealermail")));
				hshResult.put("txt_dealercode",Helper.correctNull(rs.getString("SEC_DEALERCODE")));
				hshResult.put("txt_dealertin",Helper.correctNull(rs.getString("SEC_DEALERTINNO")));


				//dealercity
				if(!Helper.correctNull(rs.getString("sec_dealercity")).equalsIgnoreCase(""))
				{
					rs1=DBUtils.executeLAPSQuery("sel_citynamebycode^"+Helper.correctNull(rs.getString("sec_dealercity")));
					if(rs1.next())
						hshResult.put("txt_dealercity",Helper.correctNull(rs1.getString("city_name")));
					
					if(rs1!=null)
						rs1.close();
				}
				
				//dealerstate
				if(!Helper.correctNull(rs.getString("sec_dealerstate")).equalsIgnoreCase(""))
				{
					rs1=DBUtils.executeLAPSQuery("sel_statenamebycode^"+Helper.correctNull(rs.getString("sec_dealerstate")));
					if(rs1.next())
						hshResult.put("txt_dealerstate",Helper.correctNull(rs1.getString("state_name")));
					
					if(rs1!=null)
						rs1.close();
				}
				
				//dealercountry
				if(!Helper.correctNull(rs.getString("sec_dealercountry")).equalsIgnoreCase(""))
				{
					rs1=DBUtils.executeLAPSQuery("sel_countrynamebycode^"+Helper.correctNull(rs.getString("sec_dealercountry")));
					if(rs1.next())
						hshResult.put("txt_dealercountry",Helper.correctNull(rs1.getString("con_country")));
					
					if(rs1!=null)
						rs1.close();
				}
				
				
				//dealerdistrict
				if(!Helper.correctNull(rs.getString("sec_dealerdistrict")).equalsIgnoreCase(""))
				{
					rs1=DBUtils.executeLAPSQuery("sel_distnamebycode^"+Helper.correctNull(rs.getString("sec_dealerdistrict")));
					if(rs1.next())
						hshResult.put("txt_dealerdistrict",Helper.correctNull(rs1.getString("district_desc")));
					
					if(rs1!=null)
						rs1.close();
				}
				hshResult.put("SEC_MACHINERY_TYPE",Helper.correctNull(rs.getString("SEC_MACHINERY_TYPE")));
				hshResult.put("SEC_MACHINERY_BELONGS",Helper.correctNull(rs.getString("SEC_MACHINERY_BELONGS")));
				hshResult.put("SEC_MACHINERY_BELONGS_NAME",Helper.correctNull(rs.getString("SEC_MACHINERY_BELONGS_NAME")));
				hshResult.put("SEC_BELONGSTO_DOORNO",Helper.correctNull(rs.getString("SEC_BELONGSTO_DOORNO")));
				
				hshResult.put("SEC_ADDRESS1",Helper.correctNull(rs.getString("SEC_ADDRESS1")));
				hshResult.put("SEC_ADDRESS2",Helper.correctNull(rs.getString("SEC_ADDRESS2")));
				hshResult.put("SEC_CITY",Helper.correctNull(rs.getString("SEC_CITY")));
				hshResult.put("SEC_DISTRICT",Helper.correctNull(rs.getString("SEC_DISTRICT")));
				hshResult.put("SEC_STATE",Helper.correctNull(rs.getString("SEC_STATE")));
				hshResult.put("SEC_PINCODE",Helper.correctNull(rs.getString("SEC_PINCODE")));
				hshResult.put("SEC_COUNTRY",Helper.correctNull(rs.getString("SEC_COUNTRY")));
				
				if(!Helper.correctNull(rs.getString("SEC_CITY")).equalsIgnoreCase(""))
				{
					rs1=DBUtils.executeLAPSQuery("sel_citynamebycode^"+Helper.correctNull(rs.getString("SEC_CITY")));
					if(rs1.next())
						hshResult.put("txt_dealercity2",Helper.correctNull(rs1.getString("city_name")));
					
					if(rs1!=null)
						rs1.close();
				}
				
				
				if(!Helper.correctNull(rs.getString("SEC_STATE")).equalsIgnoreCase(""))
				{
					rs1=DBUtils.executeLAPSQuery("sel_statenamebycode^"+Helper.correctNull(rs.getString("SEC_STATE")));
					if(rs1.next())
						hshResult.put("txt_dealerstate2",Helper.correctNull(rs1.getString("state_name")));
					
					if(rs1!=null)
						rs1.close();
				}
				
				
				if(!Helper.correctNull(rs.getString("SEC_COUNTRY")).equalsIgnoreCase(""))
				{
					rs1=DBUtils.executeLAPSQuery("sel_countrynamebycode^"+Helper.correctNull(rs.getString("SEC_COUNTRY")));
					if(rs1.next())
						hshResult.put("txt_dealercountry2",Helper.correctNull(rs1.getString("con_country")));
					
					if(rs1!=null)
						rs1.close();
				}
				
				
				
				if(!Helper.correctNull(rs.getString("SEC_DISTRICT")).equalsIgnoreCase(""))
				{
					rs1=DBUtils.executeLAPSQuery("sel_distnamebycode^"+Helper.correctNull(rs.getString("SEC_DISTRICT")));
					if(rs1.next())
						hshResult.put("txt_dealerdistrict2",Helper.correctNull(rs1.getString("district_desc")));
					
					if(rs1!=null)
						rs1.close();
				}
				hshResult.put("sec_cbsid",Helper.correctNull(rs.getString("sec_cbsid")));
				
				
			}
			
			// To get the Customer Name
			String StrLAPSId = correctNull((String) hshValues.get("hidDemoId"));
			strQuery = SQLParser.getSqlQuery("sel_lapsidfromlapsid^" + StrLAPSId);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()) 
			{
				hshResult.put("perapp_fname", Helper.correctNull((String)rs.getString("perapp_fname")));
				hshResult.put("perapp_cbsid", Helper.correctNull((String)rs.getString("perapp_cbsid")));
				hshResult.put("perapp_oldid", Helper.correctNull((String)rs.getString("perapp_oldid")));
			}
			hshResult.put("strSecID", hidSecurityId);
			hshResult.put("hid_VerificationFlag", Helper.correctNull((String)hshValues.get("hid_VerificationFlag")));
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getPlantMachinery "+e.toString());
		}
		return hshResult;
    }
    public void updateNetSecurityValue(String strSecID,String strSecValue)
    {
    	java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
    	HashMap hshQueryValues= new HashMap();
    	HashMap hshQuery= new HashMap();
    	ArrayList arrValues=new ArrayList();
    	ResultSet rs=null;
    	String strQuery="", strAlreadyCharged="";
    	double dblAmtCharged=0.00, dblSecValue=0.00, dblNetSecVal=0.00;
    	try
    	{
    		strQuery=SQLParser.getSqlQuery("securities_sel^"+strSecID);
    		rs=DBUtils.executeQuery(strQuery);
    		if(rs.next())
    		{
    			strAlreadyCharged=Helper.correctNull((String)rs.getString("CUS_SEC_Already_Charged"));
    			if(strAlreadyCharged.equalsIgnoreCase("Y"))
    			{
    				dblAmtCharged=rs.getDouble("CUS_SEC_Amount_Charged");
    			}
    		}
    		if(!strSecValue.equalsIgnoreCase(""))
    		{
    			dblSecValue=Double.parseDouble(Helper.correctDouble((String)strSecValue));
    			dblNetSecVal=dblSecValue-dblAmtCharged;
    			strSecValue=jtn.format(dblNetSecVal);
    		}
    		if(!strSecID.equalsIgnoreCase(""))
    		{
	    		hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","ins_netsecurityval");
				arrValues.add(strSecValue);
				arrValues.add(strSecID);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
    		}
    	}
    	catch(Exception e)
		{
			throw new EJBException("Error in updateNetSecurityValue "+e.toString());
		}
    }
    
    
    public HashMap getScoringParameters (HashMap hshValues)  
    {
    	ResultSet rs = null;
    	ResultSet rs1 = null;
		String strQuery=null;
		String strQuery1=null;
		ArrayList arrCol=new ArrayList();
		ArrayList arrCol2=new ArrayList();
		ArrayList arrColChkd=new ArrayList();
		ArrayList arrColChkData=new ArrayList();
		ArrayList arrRow=new ArrayList();
		ArrayList arrRow2=new ArrayList();
		HashMap hshResult=new HashMap();
		String strRskRule="", strChkdVal="",strRskDesc="",strRskParam="";
		String strRiskRatFor="",strrskratCode="",strRiskbankSchemeCode="";
		String strNewRiskScheme="";
		try
		{
			strRskRule = Helper.correctNull((String)hshValues.get("sel_scorerule"));
			strRskDesc = Helper.correctNull((String)hshValues.get("txtruledesc"));
			
			strQuery = SQLParser.getSqlQuery("selriskparamrule");
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol2=new ArrayList();
				arrCol2.add(Helper.correctNull(rs.getString("rsk_rule_id")));//0
				arrCol2.add(Helper.correctNull(rs.getString("rsk_rule_desc")));//1
				arrCol2.add(Helper.correctNull(rs.getString("rsk_rule_ratfor")));//2
				arrCol2.add(Helper.correctNull(rs.getString("rsk_rule_ratcode")));//3
				arrCol2.add(Helper.correctNull(rs.getString("rsk_rule_bankschmcode")));//4				
				arrRow2.add(arrCol2);
			}
			
			if(rs!=null){
				rs.close();
			}
			
			if(!strRskRule.equals("") && !strRskRule.equals("N"))
			{
				strQuery = SQLParser.getSqlQuery("selriskparamrule2New^"+strRskRule);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strRskDesc = Helper.correctNull(rs.getString("rsk_rule_desc"));
					strRskParam = Helper.correctNull(rs.getString("rsk_rule_params"));
					strRiskRatFor=Helper.correctNull(rs.getString("rsk_rule_ratfor"));
					strrskratCode=Helper.correctNull(rs.getString("rsk_rule_ratcode"));
					strRiskbankSchemeCode=Helper.correctNull(rs.getString("rsk_rule_bankschmcode"));
					if(strRiskbankSchemeCode!="" && strRiskbankSchemeCode.contains("@"))
					{
						strNewRiskScheme=strRiskbankSchemeCode.substring(0,(strRiskbankSchemeCode.length()-1));
					}
					else
					{
						strNewRiskScheme=strRiskbankSchemeCode;
					}
			
				}
				
				if(rs!=null){
					rs.close();
				}
				hshResult.put("strRskRule", strRskRule);
				hshResult.put("strRskDesc", strRskDesc);
				hshResult.put("strRskParam", strRskParam);
				hshResult.put("strRiskRatFor", strRiskRatFor);
				hshResult.put("strrskratCode", strrskratCode);
				hshResult.put("strRiskbankSchemeCode", strNewRiskScheme);	
			}

			strQuery = SQLParser.getSqlQuery("selriskparameters");
			rs = DBUtils.executeQuery(strQuery);
			int i=0;
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull(rs.getString("rsk_seqno")));
				if(!strRskParam.equals(""))
				{
					if(i<strRskParam.length())
					{
					arrCol.add(String.valueOf(strRskParam.charAt(i)));
					}
					else
					{
						arrCol.add("0");
					}
				}
				else
				{
					arrCol.add("0");
				}
				arrCol.add(Helper.correctNull(rs.getString("rsk_paramvalue")));
				arrRow.add(arrCol);
				i++;
			}
						
			if(rs!=null){
				rs.close();
			}
								
			hshResult.put("arrRow", arrRow);
			hshResult.put("arrRow2", arrRow2);
			hshResult.put("arrColChkData", arrColChkData);
		}
		
		catch(Exception e)
		{
			throw new EJBException("Error in getScoringParameters "+e.toString());
		}
		return hshResult;
    }
    
    public HashMap updateScoringParameters(HashMap hshValues) 
    {
    	HashMap hshQueryValues= new HashMap();
    	HashMap  hshRecord=new HashMap();
    	HashMap hshQuery= new HashMap();
    	ArrayList arrValues=new ArrayList();
    	ResultSet rs=null;
    	String strQuery="", strAction="",strRskRule="",strRskDesc="",strRulesno="";
    	double dblAmtCharged=0.00, dblSecValue=0.00, dblNetSecVal=0.00;
    	String strParams[] = null;
    	StringBuffer sbfChkdParams = new StringBuffer();
    	String strRatingFor="",strRatingCode="",strBankSchemeCode="";
    	try
    	{
    		strRskRule = Helper.correctNull((String)hshValues.get("sel_scorerule"));
    		strRskDesc = Helper.correctNull((String)hshValues.get("txtruledesc"));
    		strAction = Helper.correctNull((String)hshValues.get("hidAction"));
    		
    		//added by bhaskar
    		strRatingFor=Helper.correctNull((String)hshValues.get("txt_ratingfor"));
    		strRatingCode=Helper.correctNull((String)hshValues.get("txt_rskparamcode"));
    		strBankSchemeCode=Helper.correctNull((String)hshValues.get("hidSchemTotal"));
    		//ended
    		
    		Object objparams = hshValues.get("hidchk");
    		
    		if(objparams instanceof java.lang.String)
    		{
    			strParams = new String[1];
    			
    			strParams[0] = Helper.correctNull((String)hshValues.get("hidchk"));
    		}
    		
    		else
    		{
    			strParams = (String[])hshValues.get("hidchk");
    		}
    		
    		for(int i=0;i<strParams.length;i++)
    		{
    			sbfChkdParams.append(strParams[i]);
    		}
    		if (strAction.equalsIgnoreCase("insert")) 
    		{
    			if(!strRskRule.equalsIgnoreCase("N"))
				{
	    			hshQueryValues = new HashMap();
					hshQuery = new HashMap();					
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","delriskparamrule");
					arrValues=new ArrayList();
					arrValues.add(strRskRule);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				
	    		hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","insriskparamrule");
				arrValues=new ArrayList();
				if(strRskRule.equalsIgnoreCase("N"))
				{
					strQuery = SQLParser.getSqlQuery("selmaxriskparam");
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strRulesno = Helper.correctNull(rs.getString("rsk_ruleid"));
					}
					arrValues.add(strRulesno);
				}
				else
				{
					arrValues.add(strRskRule);
				}
				arrValues.add(strRskDesc);
				arrValues.add(String.valueOf(sbfChkdParams));
				//added by bhaskar for new fields
				arrValues.add(strRatingFor);
				arrValues.add(strRatingCode);
				arrValues.add(strBankSchemeCode);				
				//end
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
    		}
    		
    		if (strAction.equalsIgnoreCase("delete")) 
    		{
    			if(!strRskRule.equalsIgnoreCase("N"))
				{
	    			hshQueryValues = new HashMap();
					hshQuery = new HashMap();					
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","delriskparamrule");
					arrValues=new ArrayList();
					arrValues.add(strRskRule);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
    		}
    		
    		hshRecord=getScoringParameters(hshValues);
    		
    		
    	}
    	catch(Exception e)
		{
			throw new EJBException("Error in updateRiskParameters "+e.toString());
		} 
    	return hshRecord;
    }
    
    public HashMap getSecurityValuesDetails(HashMap hshValues) 
    {
    	HashMap hshResult=new HashMap();
    	ArrayList arrSecCol=new ArrayList();
    	ArrayList arrSecRow=new ArrayList();
    	
    	ArrayList arrAttachCol=new ArrayList();
    	ArrayList arrAttachRow=new ArrayList();
    	ResultSet rs=null;
    	ResultSet rs1=null;
    	ResultSet rs2=null;
    	String strQuery="",strQuery1="",strQuery2="";
    	String strAppno="",newLapsId="",oldLapsId="",strappId="";
    	String strName="",strValuesin="";
    	String strSecurityId="";
    	String strLoanType="";
    	String strSecClassType="";
    	String strSecurityType="",strExisting="",strShowFlag="";
    	int count =0;
    	double dbl_Netsecurity=0,dbl_Reidualval=0;
    	strValuesin=Helper.correctNull((String)hshValues.get("valuesin"));
    	java.text.NumberFormat jtn= java.text.NumberFormat.getInstance();
    	if(strValuesin.equalsIgnoreCase("L"))
		{
		    jtn= java.text.NumberFormat.getInstance();
			jtn.setMaximumFractionDigits(3);
			jtn.setMinimumFractionDigits(3);
		}
		if(strValuesin.equalsIgnoreCase("C"))
		{
		    jtn= java.text.NumberFormat.getInstance();
			jtn.setMaximumFractionDigits(4);
			jtn.setMinimumFractionDigits(4);
		}
		if(strValuesin.equalsIgnoreCase("R"))
		{
		    jtn= java.text.NumberFormat.getInstance();
			jtn.setMaximumFractionDigits(2);
			jtn.setMinimumFractionDigits(2);
		}
		jtn.setGroupingUsed(false);
    	try
    	{
    		strappId = Helper.correctNull((String)hshValues.get("hidapplicantid"));
    		strAppno=Helper.correctNull((String)hshValues.get("appno"));
    		newLapsId=Helper.correctInt((String)hshValues.get("sel_applicants"));
    		if(newLapsId.equalsIgnoreCase("") || newLapsId.equalsIgnoreCase("0"))
    		{
    			newLapsId=Helper.correctInt((String)hshValues.get("hidapplicantid"));
    		}
    		strQuery = SQLParser.getSqlQuery("selcustomerdetails^"+newLapsId);
    		rs = DBUtils.executeQuery(strQuery);
    		if(rs.next())
    		{
    			oldLapsId = Helper.correctInt((String) rs.getString("perapp_oldid"));
    		}
    		
    		strQuery1 = SQLParser.getSqlQuery("sel_securityvalues^"+oldLapsId);
    		rs1 = DBUtils.executeQuery(strQuery1);
    		while(rs1.next())
    		{
	    		arrSecCol = new ArrayList();
	    		strName="";
	    		strSecurityId=Helper.correctNull((String) rs1.getString("CUS_SEC_ID"));
	    		arrSecCol.add(strSecurityId);//0
	    		arrSecCol.add(Helper.correctNull((String) rs1.getString("CUS_SEC_TYPE")));//1
	    		strSecClassType = Helper.correctNull((String) rs1.getString("CUS_SEC_TYPE"));
	    		arrSecCol.add(Helper.correctNull((String) rs1.getString("CUS_SEC_CLASSIFICATION")));//2
	    		if((Helper.correctNull((String) rs1.getString("CUS_SEC_JOINT_HOLDER"))).equalsIgnoreCase("Y"))
	    		{
		    		strQuery2 = SQLParser.getSqlQuery("sel_secowners^"+Helper.correctNull((String) rs1.getString("CUS_SEC_ID")));
		    		rs2 = DBUtils.executeQuery(strQuery2);
		    		while(rs2.next())
		    		{
		    		   	if(strName.equalsIgnoreCase(""))
		    					strName = Helper.correctNull((String) rs2.getString("cus_name"));
		    				else
		    					strName = strName+", "+Helper.correctNull((String) rs2.getString("cus_name"));
		    		}		    		
	    		}
	    		else
	    		{
	    			strQuery2 = SQLParser.getSqlQuery("sel_secowners^"+Helper.correctNull((String) rs1.getString("CUS_SEC_ID")));
		    		rs2 = DBUtils.executeQuery(strQuery2);
		    		if(rs2.next())
		    		{
		    				strName = Helper.correctNull((String) rs2.getString("cus_name"));
		    		}
	    		}
	    		arrSecCol.add(strName);//3
	    		dbl_Netsecurity=Double.parseDouble(Helper.correctDouble((String) rs1.getString("CUS_SEC_NETSECURITY")));
	    		dbl_Reidualval=Double.parseDouble(Helper.correctDouble((String) rs1.getString("CUS_SEC_REIDUALVAL")));
	    		if(!(strValuesin.equalsIgnoreCase("r")))
	    		{
	    			arrSecCol.add(jtn.format(Double.parseDouble(Helper.convertSetupToApplicationValues(strValuesin, dbl_Netsecurity))));//4
	    			arrSecCol.add(jtn.format(Double.parseDouble(Helper.convertSetupToApplicationValues(strValuesin, dbl_Reidualval))));//5
	    		}else
	    		{
	    			arrSecCol.add(jtn.format(dbl_Netsecurity));//4
	    			arrSecCol.add(jtn.format(dbl_Reidualval));//5
	    		}
	    		arrSecCol.add(Helper.correctNull((String) rs1.getString("SEC_NAME")));//6
	    		arrSecCol.add(Helper.correctNull((String) rs1.getString("SEC_CLASSIFICATION")));//7
	    		arrSecCol.add(Helper.correctNull((String) rs1.getString("CUS_SEC_JOINT_HOLDER")));//8
	    		arrSecCol.add(Helper.correctNull((String) rs1.getString("SEC_COLLATFLAG")));//9
	    		
	    		strQuery2 = SQLParser.getSqlQuery("sel_secowners^"+Helper.correctNull((String) rs1.getString("CUS_SEC_ID")));
	    		rs2 = DBUtils.executeQuery(strQuery2);
	    		if(rs2.next())
	    		{
	    				strName = Helper.correctNull((String) rs2.getString("cus_name"));
	    		}
	    		if(rs2 !=null)
	    		{
	    			rs2.close();
	    		}
	    		strQuery2 = SQLParser.getSqlQuery("sel_appSecdetails^"+strSecurityId+"^"+strAppno);
	    		rs2 = DBUtils.executeQuery(strQuery2);
	    		if(rs2.next())
	    		{
	    			strLoanType=Helper.correctNull((String) rs2.getString("app_sec_loantype"));
	    			strSecurityType=Helper.correctNull((String) rs2.getString("app_sec_securitytype"));
	    			strExisting=Helper.correctNull((String) rs2.getString("APP_SEC_EXISTING"));
	    			strShowFlag=Helper.correctNull((String) rs2.getString("app_sec_show"));
	    		}
	    		else
	    		{
	    			strLoanType="S";
	    			strSecurityType="0";
	    			strExisting="";
	    			strShowFlag="";
	    		}
	    		arrSecCol.add(strLoanType);//10
	    		arrSecCol.add(strSecurityType);//11
	    		arrSecCol.add(strExisting);//12
	    		arrSecCol.add(strShowFlag);//13
	    		arrSecCol.add(Helper.correctNull(rs1.getString("CUS_COMPANYSHARE_CNT")));//14
	    		arrSecRow.add(arrSecCol);
	    		
	    		
	    		/******/
	    		String facid="",facsno="",factype="",margin="",facnature="",loanamt="",outstandamt="",loantype="",sectype="",bowid="",strSecutype="",strSecType="";
	    		count=0;
	    		strQuery = SQLParser.getSqlQuery("sel_attachSecdetails^" + strAppno+"^"+strSecurityId+"^"+ strAppno+"^"+strSecurityId);
				if(rs2 != null)
				{
					rs2.close();
				}
				rs2 = DBUtils.executeQuery(strQuery);
				String strFacID="";
				    		
	    		while(rs2.next())
				{
	    			count = Integer.parseInt(correctNull((String)rs2.getString("count")));
	    			if(count==1)
	    			{
	    				arrAttachCol = new ArrayList();
		    			arrAttachCol.add(correctNull((String)rs2.getString("app_sec_facid")));
		    			arrAttachCol.add(correctNull((String)rs2.getString("app_sec_facsno")));
		    			arrAttachCol.add(correctNull((String)rs2.getString("app_sec_factype")));
		    			arrAttachCol.add(correctNull((String)rs2.getString("app_sec_margin")));
		    			arrAttachCol.add(correctNull((String)rs2.getString("app_sec_facnature")));
		    			arrAttachCol.add(correctNull((String)rs2.getString("app_sec_loanamt")));
		    			arrAttachCol.add(correctNull((String)rs2.getString("app_sec_outstandamt")));
		    			arrAttachCol.add(correctNull((String)rs2.getString("app_sec_loantype")));
		    			arrAttachCol.add(correctNull((String)rs2.getString("app_sec_securitytype")));
		    			arrAttachCol.add(correctNull((String)rs2.getString("app_sec_borrower_id")));
		    			arrAttachCol.add(correctNull((String)rs2.getString("APP_SEC_SECUTYPE")));
		    			arrAttachCol.add(strSecClassType);
		    			arrAttachRow.add(arrAttachCol);
	    			}
	    			else if (count >1)
	    			{
	    				if(facid.equalsIgnoreCase(""))
	    				{
	    					facid = correctNull((String)rs2.getString("app_sec_facid"));
	    				}
	    				else
	    				{
	    					facid = facid +"~"+correctNull((String)rs2.getString("app_sec_facid"));
	    				}
	    				
	    				if(facsno.equalsIgnoreCase(""))
	    				{
	    					facsno = correctNull((String)rs2.getString("app_sec_facsno"));
	    				}
	    				else
	    				{
	    					facsno = facsno +"~"+correctNull((String)rs2.getString("app_sec_facsno"));
	    				}
	    				
	    				if(factype.equalsIgnoreCase(""))
	    				{
	    					factype = correctNull((String)rs2.getString("app_sec_factype"));
	    				}
	    				else
	    				{
	    					factype = factype +"~"+correctNull((String)rs2.getString("app_sec_factype"));
	    				}
	    				
	    				if(margin.equalsIgnoreCase(""))
	    				{
	    					margin = correctNull((String)rs2.getString("app_sec_margin"));
	    				}
	    				else
	    				{
	    					margin = margin +"~"+correctNull((String)rs2.getString("app_sec_margin"));
	    				}
	    				
	    				if(facnature.equalsIgnoreCase(""))
	    				{
	    					facnature = correctNull((String)rs2.getString("app_sec_facnature"));
	    				}
	    				else
	    				{
	    					facnature = facnature +"~"+correctNull((String)rs2.getString("app_sec_facnature"));
	    				}
	    				
	    				if(loanamt.equalsIgnoreCase(""))
	    				{
	    					loanamt = correctNull((String)rs2.getString("app_sec_loanamt"));
	    				}
	    				else
	    				{
	    					loanamt = loanamt +"~"+correctNull((String)rs2.getString("app_sec_loanamt"));
	    				}
	    				
	    				if(outstandamt.equalsIgnoreCase(""))
	    				{
	    					outstandamt = correctNull((String)rs2.getString("app_sec_outstandamt"));
	    				}
	    				else
	    				{
	    					outstandamt = outstandamt +"~"+correctNull((String)rs2.getString("app_sec_outstandamt"));
	    				}
	    				if(loantype.equalsIgnoreCase(""))
	    				{
	    					loantype = correctNull((String)rs2.getString("APP_SEC_LOANTYPE"));
	    				}
	    				else
	    				{
	    					loantype = loantype +"~"+correctNull((String)rs2.getString("APP_SEC_LOANTYPE"));
	    				}
	    				if(sectype.equalsIgnoreCase(""))
	    				{
	    					sectype = correctNull((String)rs2.getString("app_sec_securitytype"));
	    				}
	    				else
	    				{
	    					sectype = sectype +"~"+correctNull((String)rs2.getString("app_sec_securitytype"));
	    				}
	    				
	    				if(bowid.equalsIgnoreCase(""))
	    				{
	    					bowid = correctNull((String)rs2.getString("app_sec_borrower_id"));
	    				}
	    				else
	    				{
	    					if(!bowid.contains(correctNull((String)rs2.getString("app_sec_borrower_id"))))
	    					bowid = bowid +"~"+correctNull((String)rs2.getString("app_sec_borrower_id"));
	    				}
	    				if(strSecutype.equalsIgnoreCase(""))
	    				{
	    					strSecutype = correctNull((String)rs2.getString("APP_SEC_SECUTYPE"));
	    				}
	    				else
	    				{
	    					strSecutype = strSecutype +"~"+correctNull((String)rs2.getString("APP_SEC_SECUTYPE"));
	    				}
	    				if(strSecType.equalsIgnoreCase(""))
	    				{
	    					strSecType = strSecClassType;
	    				}
	    				else
	    				{
	    					strSecType = strSecType +"~"+strSecClassType;
	    				}
	    				
	    				
	    			}
				}
	    		
	    		if (count >1)
	    		{
	    			arrAttachCol = new ArrayList();
	    			arrAttachCol.add(facid);
	    			arrAttachCol.add(facsno);
	    			arrAttachCol.add(factype);
	    			arrAttachCol.add(margin);
	    			arrAttachCol.add(facnature);
	    			arrAttachCol.add(loanamt);
	    			arrAttachCol.add(outstandamt);
	    			arrAttachCol.add(loantype);
	    			arrAttachCol.add(sectype);
	    			arrAttachCol.add(bowid);
	    			arrAttachCol.add(strSecutype);
	    			arrAttachCol.add(strSecType);
	    			arrAttachRow.add(arrAttachCol);
	    		}	
	    		else if(count==0)
	    		{
	    			arrAttachCol = new ArrayList();
	    			arrAttachCol.add("");
	    			arrAttachCol.add("");
	    			arrAttachCol.add("");
	    			arrAttachCol.add("");
	    			arrAttachCol.add("");
	    			arrAttachCol.add("");
	    			arrAttachCol.add("");
	    			arrAttachCol.add("");
	    			arrAttachCol.add("");
	    			arrAttachCol.add("");
	    			arrAttachCol.add("");
	    			arrAttachCol.add(strSecClassType);
	    			arrAttachRow.add(arrAttachCol);
	    		}
	    		/******/
    		}

    		//for checking freeze count
    		   	int strFreezecount=0;
    		   	String strFreezeflag="N",strPrioityflag="N";
    		   	strQuery = SQLParser.getSqlQuery("sel_freezecount^" + strAppno);
    			rs = DBUtils.executeQuery(strQuery);
    			if(rs.next())
    			{	
    				strFreezecount=Integer.parseInt(Helper.correctInt((String)rs.getString("freezecount")));
    				if(strFreezecount!=0 )
    				{
    					strFreezeflag="Y";
    				}
    			}
    			
    			//property type securities attached
    			if(rs!=null)
        			rs.close();
    		 	String propsecFlag="N";
    			strQuery = SQLParser.getSqlQuery("sel_propSecAttachedtoprop^" + strAppno);
    			rs = DBUtils.executeQuery(strQuery);
    			if(rs.next())
    			{
    				hshResult.put("propsecFlag", "Y");
    			}
 			
   			hshResult.put("strFreezeflag",strFreezeflag);	
    		hshResult.put("arrSecRow",arrSecRow);
    		hshResult.put("strAppno",strAppno);
    		hshResult.put("strcmpId",newLapsId);
    		hshResult.put("strappId",strappId);
    		hshResult.put("arrAttachRow",arrAttachRow);
    		
    		
    		//To select the post sanction parameters
			String strTemp=" ",strParameters="";
			String strQueryPS = SQLParser.getSqlQuery("sel_PS_oldaccnum^"+strAppno+"^"+strTemp);
			ResultSet rsPS = DBUtils.executeQuery(strQueryPS);
			while(rsPS.next())
			{
				strParameters=strParameters+Helper.correctNull(rsPS.getString("PS_MODIFY_TERMS"));
			}
			hshResult.put("strPostSancParam",strParameters);
			
			if(Helper.correctNull((String)hshValues.get("strAppType")).equalsIgnoreCase("P"))
			{
				if(rsPS!=null)
					rsPS.close();
				strQueryPS = SQLParser.getSqlQuery("seldistinctappno^"+strAppno);
				rsPS = DBUtils.executeQuery(strQueryPS);
				while(rsPS.next())
				{
					if(rs!=null)
		    			rs.close();
					strQuery=SQLParser.getSqlQuery("selparentfacattachedsec^"+Helper.correctNull(rsPS.getString("ps_old_app_sno"))+"^"+Helper.correctNull(rsPS.getString("appno")));
					rs = DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						if(rs1!=null)
			    			rs1.close();
						strQuery=SQLParser.getSqlQuery("chk_attachedsecurities^"+Helper.correctNull(rs.getString("app_sec_secid"))+"^"+Helper.correctNull(rsPS.getString("ps_app_sno"))+"^"+strAppno);
						rs1 = DBUtils.executeQuery(strQuery);
						if(!rs1.next())
						{
							HashMap hshQueryValues=new HashMap();
							HashMap hshQuery=new HashMap();
							ArrayList arrValues=new ArrayList();
							hshQueryValues.put("size","1");
							hshQuery.put("strQueryId", "insappsecuritydetailspostsanc_corp");
							arrValues.add(strAppno);
							arrValues.add(Helper.correctNull(rsPS.getString("ps_app_sno")));
							arrValues.add(Helper.correctNull(rs.getString("app_sec_secid")));
							arrValues.add(Helper.correctNull(rsPS.getString("ps_old_app_sno")));
							arrValues.add(Helper.correctNull(rsPS.getString("appno")));
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("1", hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}
					}
				}
			}
    		if(rs!=null)
    			rs.close();
    		if(rs1!=null)
    			rs1.close();
    		if(rs2!=null)
    			rs2.close();
    		
    		//To update the security description as per the sanction time
//			if(Helper.correctNull((String)hshValues.get("strappstatus")).equalsIgnoreCase("op"))
//			{
//				HashMap hshQueryValues=new HashMap();
//				HashMap hshQuery=new HashMap();
//				ArrayList arrValues=new ArrayList();
//				hshQueryValues.put("size","1");
//				hshQuery.put("strQueryId", "upd_sec_desc_pending");
//				arrValues.add(strAppno);
//				hshQuery.put("arrValues", arrValues);
//				hshQueryValues.put("1", hshQuery);
//				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
//			}
    	}
    	catch(Exception e)
		{
			throw new EJBException("Error in getsecurityvaluedetails "+e.toString());
		} 
    	return hshResult;
    }
    public HashMap getSecCollateralCoverage(HashMap hshValues) 
    {
    	HashMap hshResult =new HashMap();
    	HashMap hshRecord =new HashMap();
    	String strQuery1="",str_sec_id="",strsecid="",str_sec_temp_id="",strfacsno="";
    	ResultSet rs1=null,rs=null,rs2=null;
    	ArrayList arrCol=new ArrayList();
    	ArrayList arrRow=new ArrayList();
    	ArrayList arrSecrow=new ArrayList();
    	ArrayList arrSeccol=new ArrayList();
    	ArrayList arrGrpexpRow=new ArrayList();
    	ArrayList arrGrpexpCol=new ArrayList();
    	ArrayList arrGrpSecrow=new ArrayList();
    	ArrayList arrGrpSeccol=new ArrayList();
    	ArrayList arrExprow=new ArrayList();
    	ArrayList arrExpcol=new ArrayList();
    	double dbl_outstanding[]=new double[10];
    	double dbl_residual[]=new double[10];
    	double dbl_residualfac=0,dbl_outstandingamt=0,dbl_outstandingtemp=0,dbl_outstandingtemp1=0,dbl_residualfinal=0;
    	double dbSecratio=0.00;
    	int y=0;
    	boolean flag=false;
    	HashMap hshQuery=new HashMap();
    	ArrayList arrValues=new ArrayList();
    	HashMap hshQueryValues=new HashMap();
    	
    	String strValuesIn=Helper.correctNull((String)hshValues.get("valuesin"));
    	java.text.NumberFormat nft= java.text.NumberFormat.getInstance();
    	nft= java.text.NumberFormat.getInstance();
    	nft.setMaximumFractionDigits(2);
    	nft.setMinimumFractionDigits(2);
    	nft.setGroupingUsed(false);
		
		try
    	{
    		String appno=Helper.correctNull((String)hshValues.get("appno"));
    		String strappId = Helper.correctNull((String)hshValues.get("hidapplicantid"));
    		String strAction = Helper.correctNull((String)hshValues.get("hidAction"));
    		
    		
    		strQuery1 = SQLParser.getSqlQuery("sel_appSecdetailsfacsno^"+appno+"^P");
    		rs = DBUtils.executeQuery(strQuery1);
    		while(rs.next())
	    		{
	    			strsecid=Helper.correctNull(rs.getString("app_sec_secid"));
		    		strQuery1 = SQLParser.getSqlQuery("sel_appSecdetailsfac^"+appno+"^"+strsecid+"^P^ and app_sec_facsno!=0 ");
		    		rs1 = DBUtils.executeQuery(strQuery1);
		    		while(rs1.next())
		    		{
		    			if(strfacsno.equalsIgnoreCase(Helper.correctNull(rs1.getString("APP_SEC_FACSNO"))))
		    			{
		    				dbl_outstandingamt=dbl_outstandingtemp1;
		       			 
		    			}
		    			else
		    			{
		    				dbl_outstandingamt=Double.parseDouble(Helper.correctDouble(rs1.getString("app_sec_outstandamt")));
		       			 
		    			}
		    			strfacsno=Helper.correctNull(rs1.getString("APP_SEC_FACSNO"));
		    			
		    			 str_sec_id = Helper.correctNull(rs1.getString("app_sec_secid"));
		    			 if(str_sec_temp_id.equalsIgnoreCase(str_sec_id))
		    			 {
		    				 dbl_residualfac=dbl_outstandingtemp;
		    			 }
		    			 else
		    			 {
		    			 dbl_residualfac=Double.parseDouble(Helper.correctDouble(rs1.getString("app_sec_securityvalue")));
		    			 }
		    			 dbl_outstandingtemp=dbl_residualfac-dbl_outstandingamt;
		    			 dbl_outstandingtemp1=dbl_residualfac-dbl_outstandingamt;
		    			
		    			 if(dbl_outstandingtemp<=0)
		    			 {
		    				 dbl_outstandingtemp1*=-1D;
		    				 dbl_outstandingtemp=0;
		    			 }
		    			// if(!str_sec_temp_id.equalsIgnoreCase(str_sec_id)|| rs1.isLast())
		    			 {
		    				 	/*hshQueryValues=new HashMap();
		    				 	hshQuery=new HashMap();
		    					arrValues=new ArrayList();
		    					arrValues.add(""+dbl_outstandingtemp);
		    					arrValues.add(appno);
		    					arrValues.add(str_sec_id);
		    					arrValues.add(strfacsno);
		    					hshQuery.put("arrValues",arrValues);
		    					hshQuery.put("strQueryId","upd_app_securitydetailsfac");
		    					hshQueryValues.put("size","1");
		    					hshQueryValues.put("1",hshQuery);
		    					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");*/
		    				    hshQueryValues=new HashMap();
		    					hshQuery=new HashMap();
		    					arrValues=new ArrayList();
		    					arrValues.add(""+dbl_outstandingtemp);
		    					arrValues.add(str_sec_id);
		    					hshQuery.put("arrValues",arrValues);
		    					hshQuery.put("strQueryId","upd_cus_securitiessec");
		    					hshQueryValues.put("size","1");
		    					hshQueryValues.put("1",hshQuery);
		    					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
		    					str_sec_temp_id=str_sec_id;
		    			 	}
		    			}
	    			}
    		if(rs!=null)
    		{
    			rs.close();
    		}
    		strQuery1 = SQLParser.getSqlQuery("sel_appSecdetailsdistfac^"+appno+"^P^> ^ ");
    		rs = DBUtils.executeQuery(strQuery1);
    		while(rs.next())
	    		{
    			arrValues=new ArrayList();
    			arrValues.add(Helper.correctNull(rs.getString("cus_sec_netsecurity")));
    			arrValues.add(Helper.correctNull(rs.getString("app_sec_secid")));
				arrRow.add(arrValues);
	    		}
    		strfacsno="";dbl_outstandingamt=0;dbl_outstandingtemp=0;dbl_residualfac=0;
    		arrValues=new ArrayList();
    		if(arrRow!=null && arrRow.size()>0)
    		{
    			strQuery1 = SQLParser.getSqlQuery("sel_appSecdetailsfacsno^"+appno+"^E");
        		rs = DBUtils.executeQuery(strQuery1);
        		while(rs.next())
        		{
        			strsecid=Helper.correctNull(rs.getString("app_sec_secid"));
        		strQuery1 = SQLParser.getSqlQuery("sel_appSecdetailsfac^"+appno+"^"+strsecid+"^E^ and app_sec_facsno!=0 ");
        		rs1 = DBUtils.executeQuery(strQuery1);
        		while(rs1.next())
        		{
        			if(strfacsno.equalsIgnoreCase(Helper.correctNull(rs1.getString("APP_SEC_FACSNO"))))
        			{
        				dbl_outstandingamt=dbl_outstandingtemp1;
           			 
        			}
        			else
        			{
        				dbl_outstandingamt=Double.parseDouble(Helper.correctDouble(rs1.getString("app_sec_outstandamt")));
           			 
        			}
        			strfacsno=Helper.correctNull(rs1.getString("APP_SEC_FACSNO"));
        			
        			 str_sec_id = Helper.correctNull(rs1.getString("app_sec_secid"));
        			 if(str_sec_temp_id.equalsIgnoreCase(str_sec_id))
        			 {
        				 dbl_residualfac=dbl_outstandingtemp;
        			 }
        			 else
        			 {
        			 dbl_residualfac=Double.parseDouble(Helper.correctDouble(rs1.getString("app_sec_securityvalue")));
        			 }
        			 dbl_outstandingtemp=dbl_residualfac-dbl_outstandingamt;
        			 dbl_outstandingtemp1=dbl_residualfac-dbl_outstandingamt;
        			
        			 if(dbl_outstandingtemp<0)
        			 {
        				 dbl_outstandingtemp1*=-1D;
        				 dbl_outstandingtemp=0;
        				
        			 }
        			 hshQueryValues=new HashMap();
 					hshQuery=new HashMap();
 					arrValues=new ArrayList();
 					arrValues.add(""+dbl_outstandingtemp);
 					arrValues.add(str_sec_id);
 					hshQuery.put("arrValues",arrValues);
 					hshQuery.put("strQueryId","upd_cus_securitiessec");
 					hshQueryValues.put("size","1");
 					hshQueryValues.put("1",hshQuery);
 					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
 					str_sec_temp_id=str_sec_id;
        		}
        		}
        		if(rs!=null)
        		{
        			rs.close();
        		}
        		strfacsno="";
        		strQuery1 = SQLParser.getSqlQuery("sel_appSecdetailsdistfac^"+appno+"^E^<= ^ and app_sec_iscollateral='Y'");
        		rs = DBUtils.executeQuery(strQuery1);
        		while(rs.next())
    	    		{
        			if(!strfacsno.equalsIgnoreCase(Helper.correctNull(rs.getString("app_sec_facsno"))))
        			{
        			arrValues=new ArrayList();
        			arrValues.add(Helper.correctNull(rs.getString("APP_SEC_OUTSTANDAMT")));
        			arrValues.add(Helper.correctNull(rs.getString("app_sec_secid")));
        			arrCol.add(arrValues);
        			strfacsno=Helper.correctNull(rs.getString("app_sec_facsno"));
        			}
    	    		}
        		arrValues=new ArrayList();
        		flag=false;
        		if(arrCol!=null && arrCol.size()>0)
        		{
        			if(arrRow!=null && arrRow.size()>0)
            		{
        				for(int j=0;j<arrRow.size();j++)
            			{
	        					ArrayList arr=(ArrayList)arrRow.get(j);
	            				double dbl_outstandingvalue =Double.parseDouble(Helper.correctDouble((String)arr.get(0)));
			        			for(int i=0;i<arrCol.size();i++)
			        			{
				        				ArrayList arrVal=(ArrayList)arrCol.get(i);
				        				double dbl_outstandingval=Double.parseDouble(Helper.correctDouble((String)arrVal.get(0)));
				        				if(dbl_outstandingval>=0)
				        				{
					        					flag=true;
					        					dbl_residualfinal=dbl_outstandingval-dbl_outstandingvalue;
					        					if(dbl_residualfinal<0)dbl_residualfinal*=-1D;
				        				}
			        			}
			        			if(flag)
			        			{
				        			 hshQueryValues=new HashMap();
				 					hshQuery=new HashMap();
				 					arrValues=new ArrayList();
				 					arrValues.add(""+dbl_residualfinal);
				 					arrValues.add(Helper.correctDouble((String)arr.get(1)));
				 					hshQuery.put("arrValues",arrValues);
				 					hshQuery.put("strQueryId","upd_cus_securitiessec");
				 					hshQueryValues.put("size","1");
				 					hshQueryValues.put("1",hshQuery);
				 					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				 					flag=false;
			            		}
			            	}
            			}
        			}
    			}
    		double dbl_collateralsum=0,dbl_facsumamt=0,dbl_collateralsumtmp=0;
    		double dbCollateralSumNew=0.00,dbExisAmntNew=0.00;
    		strQuery1 = SQLParser.getSqlQuery("sel_appSecdetailsfaccoll^"+appno+"^P^ and app_sec_facsno=0 ");
    		rs1 = DBUtils.executeQuery(strQuery1);
    		while(rs1.next())
    		{
    			str_sec_id=Helper.correctNull(rs1.getString("app_sec_secid"));
    			dbl_collateralsum=Double.parseDouble(Helper.correctDouble(rs1.getString("cus_sec_netsecurity")));
    			dbl_collateralsumtmp=Double.parseDouble(Helper.correctDouble(rs1.getString("cus_sec_netsecurity")));
    			dbCollateralSumNew=dbCollateralSumNew+dbl_collateralsum;
    			strQuery1 = SQLParser.getSqlQuery("sel_appSecdetailsfacsumcol^"+appno+"^E^ and app_sec_facsno!=0 ");
        		rs = DBUtils.executeQuery(strQuery1);
        		while(rs.next())
        		{
        			dbl_facsumamt=Double.parseDouble(Helper.correctDouble(rs.getString("app_sec_outstandamt")));
        			dbExisAmntNew=dbExisAmntNew+dbl_facsumamt;        			
        			dbl_collateralsum=dbl_facsumamt-dbl_collateralsum;
        			if((dbl_collateralsum)>0)
            		{
        					hshQueryValues=new HashMap();
		 					hshQuery=new HashMap();
		 					arrValues=new ArrayList();
		 					arrValues.add("0");
		 					arrValues.add(str_sec_id);
		 					hshQuery.put("arrValues",arrValues);
		 					hshQuery.put("strQueryId","upd_cus_securitiessec");
		 					hshQueryValues.put("size","1");
		 					hshQueryValues.put("1",hshQuery);
		 					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
            		}
        			if(dbl_collateralsum<0)
        			{
        				dbl_collateralsum*=-1D;
        				hshQueryValues=new HashMap();
	 					hshQuery=new HashMap();
	 					arrValues=new ArrayList();
	 					arrValues.add(""+dbl_collateralsum);
	 					arrValues.add(str_sec_id);
	 					hshQuery.put("arrValues",arrValues);
	 					hshQuery.put("strQueryId","upd_cus_securitiessec");
	 					hshQueryValues.put("size","1");
	 					hshQueryValues.put("1",hshQuery);
	 					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
        			}
        		}
    		}
    		
    		/*Colletral coverage exposure is calculated*/ 
    		//Added by bhaskar to calculate sec ratio and to adjust to existing loans
			if(dbExisAmntNew>dbCollateralSumNew)
			{
				    hshQueryValues=new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					arrValues.add("0.00");
					arrValues.add(appno);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","upd_apploanamtsec_ratio");
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");        				
				
			}
			else if(dbExisAmntNew<dbCollateralSumNew)
			{
				double dbl_collateralsum1=dbCollateralSumNew-dbExisAmntNew;
				double dbLoanAmntReq=0.00;
				rs2=DBUtils.executeLAPSQuery("selloanrecmtamntloanddet^"+appno);
				if(rs2.next())
				{
					dbLoanAmntReq=Double.parseDouble(Helper.correctDouble(rs2.getString("loan_recmdamt")));
					//String strnewAmount=Helper.convertApplicationToSetup(strValuesIn, dbLoanAmntReq);
					//dbLoanAmntReq=Double.parseDouble(Helper.correctDouble(strnewAmount));        					
				}
				dbSecratio=(dbl_collateralsum1/dbLoanAmntReq)*100;
				hshQueryValues=new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					arrValues.add(String.valueOf(dbSecratio));
					arrValues.add(appno);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","upd_apploanamtsec_ratio");
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");  
			}
			//ended by bhaskar
			
    		dbl_collateralsum=0;dbl_facsumamt=0;dbl_collateralsumtmp=0;
    		strQuery1 = SQLParser.getSqlQuery("sel_appSecdetailsfaccoll^"+appno+"^P^ and app_sec_facsno=0 ");
    		rs1 = DBUtils.executeQuery(strQuery1);
    		while(rs1.next())
    		{
    			str_sec_id=Helper.correctNull(rs1.getString("app_sec_secid"));
    			dbl_collateralsum=Double.parseDouble(Helper.correctDouble(rs1.getString("cus_sec_netsecurity")));
    			dbl_collateralsumtmp=Double.parseDouble(Helper.correctDouble(rs1.getString("cus_sec_netsecurity")));
    			strQuery1 = SQLParser.getSqlQuery("sel_appSecdetailsfacsumcol^"+appno+"^P^ and app_sec_facsno!=0 ");
        		rs = DBUtils.executeQuery(strQuery1);
        		while(rs.next())
        		{
        			dbl_facsumamt=Double.parseDouble(Helper.correctDouble(rs.getString("app_sec_outstandamt")));
        			dbl_collateralsum=dbl_facsumamt-dbl_collateralsum;
        			if((dbl_collateralsum)>0)
            		{
        					hshQueryValues=new HashMap();
		 					hshQuery=new HashMap();
		 					arrValues=new ArrayList();
		 					arrValues.add("0");
		 					arrValues.add(str_sec_id);
		 					hshQuery.put("arrValues",arrValues);
		 					hshQuery.put("strQueryId","upd_cus_securitiessec");
		 					hshQueryValues.put("size","1");
		 					hshQueryValues.put("1",hshQuery);
		 					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
            		}
        			if(dbl_collateralsum<0)
        			{
        				dbl_collateralsum*=-1D;
        				hshQueryValues=new HashMap();
	 					hshQuery=new HashMap();
	 					arrValues=new ArrayList();
	 					arrValues.add(""+dbl_collateralsum);
	 					arrValues.add(str_sec_id);
	 					hshQuery.put("arrValues",arrValues);
	 					hshQuery.put("strQueryId","upd_cus_securitiessec");
	 					hshQueryValues.put("size","1");
	 					hshQueryValues.put("1",hshQuery);
	 					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
        			}
        		}
    		}
    		
	    		hshQueryValues=new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add("Y");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","upd_app_securitydetailsfreeze");
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
	    		
				hshRecord=(HashMap)getCollateralSecurityDisplaynew(hshValues);
	    		int intUpdatesize=0;
	    		String strQuery="";
	    		double dblexitotal=0.00,dblprototal=0.00,dblsubexitotal=0.00,dblsubproptotal=0.00,dblSecpoposed=0.00,dblSecexisting=0.00,dbltotal=0.00,dblsubtotal=0.00;
	    		if(strAction.equalsIgnoreCase("freeze"))
	    		{
	    			arrExprow=(ArrayList)hshRecord.get("arrExposureRow");
	    			if(arrExprow!=null && arrExprow.size()>0)
	    			{
		    			intUpdatesize = intUpdatesize+1;
		    			arrValues=new ArrayList();
		    			hshQueryValues=new HashMap();
		    			//Deleting Exposure details
		    			hshQuery=new HashMap();
						hshQuery.put("strQueryId","DEL_BORROWEREXP");
						arrValues.add(appno);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
						intUpdatesize=0;
						hshQueryValues=new HashMap();
						for(int j=0;j<arrExprow.size();j++)
						{
							dblsubexitotal=0.00;dblsubproptotal=0.00;dblsubtotal=0.00;
							arrExpcol=(ArrayList)arrExprow.get(j);
							{
								if(!(Helper.correctNull((String)arrExpcol.get(6)).equalsIgnoreCase("N")))
								{
									//Inserting Exposure details
									intUpdatesize = intUpdatesize+1;
									hshQuery=new HashMap();
					    			arrValues=new ArrayList();
									hshQuery.put("strQueryId","INS_BORROWEREXP");
									arrValues.add(appno);
									dblexitotal +=Double.parseDouble(Helper.correctDouble((String)arrExpcol.get(0)));
									dblprototal +=Double.parseDouble(Helper.correctDouble((String)arrExpcol.get(1)));
									dblsubexitotal+=Double.parseDouble(Helper.correctDouble((String)arrExpcol.get(0)));
									dblsubproptotal+=Double.parseDouble(Helper.correctDouble((String)arrExpcol.get(1)));
									dbltotal+=Double.parseDouble(Helper.correctDouble((String)arrExpcol.get(8)));
									dblsubtotal+=Double.parseDouble(Helper.correctDouble((String)arrExpcol.get(8)));
									arrValues.add(Helper.correctNull((String)arrExpcol.get(7)));
									arrValues.add("F");
									arrValues.add(Helper.correctDouble((String)arrExpcol.get(0)));
									arrValues.add(Helper.correctDouble((String)arrExpcol.get(1)));
									arrValues.add(Helper.correctNull((String)arrExpcol.get(4)));
									arrValues.add(Helper.correctNull((String)arrExpcol.get(8)));
									hshQuery.put("arrValues",arrValues);
									hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
								
									intUpdatesize = intUpdatesize+1;
									hshQuery=new HashMap();
					    			arrValues=new ArrayList();
									hshQuery.put("strQueryId","INS_BORROWEREXP");
									arrValues.add(appno);
									arrValues.add(Helper.correctNull((String)arrExpcol.get(7)));
									arrValues.add("NF");
									dblexitotal+=Double.parseDouble(Helper.correctDouble((String)arrExpcol.get(2)));
									dblprototal+=Double.parseDouble(Helper.correctDouble((String)arrExpcol.get(3)));
									dblsubexitotal+=Double.parseDouble(Helper.correctDouble((String)arrExpcol.get(2)));
									dblsubproptotal+=Double.parseDouble(Helper.correctDouble((String)arrExpcol.get(3)));
									dbltotal+=Double.parseDouble(Helper.correctDouble((String)arrExpcol.get(9)));
									dblsubtotal+=Double.parseDouble(Helper.correctDouble((String)arrExpcol.get(9)));
									arrValues.add(Helper.correctDouble((String)arrExpcol.get(2)));
									arrValues.add(Helper.correctDouble((String)arrExpcol.get(3)));
									arrValues.add(Helper.correctNull((String)arrExpcol.get(4)));
									arrValues.add(Helper.correctNull((String)arrExpcol.get(9)));
									hshQuery.put("arrValues",arrValues);
									hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							
									intUpdatesize = intUpdatesize+1;
									hshQuery=new HashMap();
					    			arrValues=new ArrayList();
									hshQuery.put("strQueryId","INS_BORROWEREXP");
									arrValues.add(appno);
									arrValues.add(Helper.correctNull((String)arrExpcol.get(7)));
									arrValues.add("SUBTOT");
									arrValues.add(String.valueOf(dblsubexitotal));
									arrValues.add(String.valueOf(dblsubtotal));
									arrValues.add(Helper.correctNull((String)arrExpcol.get(4)));
									arrValues.add(String.valueOf(dblsubproptotal));
									hshQuery.put("arrValues",arrValues);
									hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
									
									if(j==0)
									{
										arrSecrow=(ArrayList)hshRecord.get("Securities");
									}
									else
									{
										arrSecrow=(ArrayList)hshRecord.get("Securities"+j);
									}
									
									if(arrSecrow !=null && arrSecrow.size()>0)
									{
										for(int k=0;k<arrSecrow.size();k++)
										{
											arrSeccol=(ArrayList)arrSecrow.get(k);
											dblSecpoposed+=Double.parseDouble(Helper.correctDouble((String)arrSeccol.get(2)));
											dblSecexisting+=Double.parseDouble(Helper.correctDouble((String)arrSeccol.get(1)));
											
										}
									}
							}
						}
						
					}
					double dblTotalSecValue=dblSecpoposed+dblSecexisting;
					double dblSecCoverage=0.00;
					if(dbltotal!=0.00)
					dblSecCoverage=(dblTotalSecValue/dbltotal)*100;
					
					intUpdatesize = intUpdatesize+1;
					hshQuery=new HashMap();
	    			arrValues=new ArrayList();
					hshQuery.put("strQueryId","INS_BORROWEREXP");
					arrValues.add(appno);
					arrValues.add(strappId);
					arrValues.add("TOT");
					arrValues.add(String.valueOf(dblexitotal));
					arrValues.add(String.valueOf(dblprototal));
					arrValues.add("A");
					arrValues.add(String.valueOf(dbltotal));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					
					double dbl_exiSecval=0,dbl_propsecval=0,dbl_propsecvaltot=0,dbl_RatingexpFund=0.00,dbl_RatingexpNonFund=0.00;
					dbl_RatingexpFund=Double.parseDouble(Helper.correctDouble((String)hshRecord.get("RatingExposureFund")));
					dbl_RatingexpNonFund=Double.parseDouble(Helper.correctDouble((String)hshRecord.get("RatingExposureNonFund")));
					//Security coverage
					intUpdatesize = intUpdatesize+1;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","DEL_SECURITYCOVERAGE");
					arrValues.add(appno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					
					double dbl_secexicoverage=0,dbl_secpropcoverage=0,dbl_colletralSec=0,dbl_Collcoverage=0;
					/*Calculating Colletral coverage exposure*/
					strQuery=SQLParser.getSqlQuery("sel_Colletralsecurity"+"^"+appno+"^"+appno);
					rs = DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						dbl_colletralSec+=Double.parseDouble(Helper.correctDouble(rs.getString("CUS_SEC_NETSECURITY")));
					}
					dbl_Collcoverage=(dbl_colletralSec/dblprototal)/100;
					if(dbl_colletralSec==0.0 || dblprototal==0.0)
					{
						dbl_Collcoverage=0.00;
					}
					
					intUpdatesize = intUpdatesize+1;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","INS_SECURITYCOVERAGE");
					arrValues.add(appno);
					arrValues.add(strappId);
					if(dblSecexisting<=0 || dblexitotal<=0)
					{
						dbl_secexicoverage=0;
					}
					else
					{
						dbl_secexicoverage=(dblSecexisting/dblexitotal)*100;
					}
					if(dblSecpoposed<=0 || dblprototal<=0)
					{
						dbl_secpropcoverage=0;
					}
					else
					{
						dbl_secpropcoverage=(dblSecpoposed/dblprototal)*100;
					}
					arrValues.add(nft.format(Double.parseDouble(Helper.correctDouble(Helper.convertApplicationToSetup(strValuesIn, dbl_secexicoverage)))));
					arrValues.add(nft.format(Double.parseDouble(Helper.correctDouble(Helper.convertApplicationToSetup(strValuesIn, dbl_secpropcoverage)))));
					arrValues.add(nft.format(dbl_Collcoverage));/* Colletral coverage exposure is calculated above*/
					arrValues.add(nft.format(Double.parseDouble(Helper.correctDouble(Helper.convertApplicationToSetup(strValuesIn, dbl_RatingexpFund)))));/*Rating Exposure*/
					arrValues.add(nft.format(dblSecCoverage));
					arrValues.add(nft.format(Double.parseDouble(Helper.correctDouble(Helper.convertApplicationToSetup(strValuesIn, dbl_RatingexpNonFund)))));/*Rating Exposure*/
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
	    		}
	    	  }
	    		
	    		//Updating security description
			  	hshQueryValues=new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId", "upd_sec_desc_pending");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
	    		hshResult=(HashMap)getAttachedSecurityDetails(hshValues);
    		}	
	    	catch(Exception e)
	    	{
	    		throw new EJBException("Error in getCollateralSecurityDisplay "+e.toString());
	    	}
	    	return hshResult;
    }
    
    public HashMap getRatingExposurecorp(HashMap hshValues) 
    {
    	HashMap hshResult = new HashMap();
    	HashMap hshRecord =new HashMap();
    	String strQuery1="";
    	ResultSet rs1=null,rs=null,rs2=null;
    	String strAppno="",strQuery2="",strQuery="",strheadfac="";
    	double dbl_exifundostot=0.00,dbl_totalexposurefund=0.00,dbl_totalexposureNonfund=0.00,dbl_propfundostot=0.00,dbl_propexisfndtot=0.00,dbl_exinonfundostot=0.00;
    	double dbl_propnonfundostot=0.00;
    	String strSchnonsche="",strRatingcheck="",strfacility_code="";
    	//For 100% cash margin products should not include for Rating based exposure 
	    ArrayList arrCashMarginCode= new ArrayList();
	    arrCashMarginCode.add("153");
	    arrCashMarginCode.add("154");
	    arrCashMarginCode.add("156");
	    arrCashMarginCode.add("158");
    	try
    	{
    		strAppno=Helper.correctNull((String)hshValues.get("appno"));
    		
    		//for taking Existing funded 
    		String strcombk_modtype="",str_Loantype="",strFacility = null,strBaltype="";
    		double dblExposure=0,dblOs=0,dblLimit=0;
    		String strfundtype="'F'";
    		strQuery1=SQLParser.getSqlQuery("sel_combkfundednon_rating^"+strAppno+"^"+strAppno+"^"+strfundtype+"^Y");
    		rs1=DBUtils.executeQuery(strQuery1);
    		while(rs1.next())
    		{
    			str_Loantype="";
    			strheadfac="";
    			strcombk_modtype=Helper.correctNull((String)rs1.getString("combk_modtype"));
    			strFacility=Helper.correctNull((String)rs1.getString("combk_facility"));
    			strBaltype=Helper.correctNull((String)rs1.getString("combk_baltype"));
    			dblExposure=Double.parseDouble(Helper.correctDouble((String)rs1.getString("com_exposure")));
    			dblOs=Double.parseDouble(Helper.correctDouble((String)rs1.getString("combk_os")));
    			dblLimit=Double.parseDouble(Helper.correctDouble((String)rs1.getString("combk_limit")));
    			String[] strFacilityArr=strFacility.split("~");
    			if(strcombk_modtype.equalsIgnoreCase("p") || strcombk_modtype.equalsIgnoreCase("r"))
				{
					strQuery2=SQLParser.getSqlQuery("sel_retProductDesc^"+strFacilityArr[0]);
					rs2 = DBUtils.executeQuery(strQuery2);
					if(rs2.next())
					{
						str_Loantype=Helper.correctNull(rs2.getString("PRD_LOANTYPE"));
					}
				}
				else
				{
					strQuery2=SQLParser.getSqlQuery("sel_FacilityCorpDesc^"+strFacilityArr[0]+"^"+strcombk_modtype);
					rs2 = DBUtils.executeQuery(strQuery2);
					if(rs2.next())
					{
						str_Loantype=Helper.correctNull(rs2.getString("com_facility_loantype"));
						strheadfac=Helper.correctNull(rs2.getString("com_headfac"));
					}
				}
    			if(rs2!=null)
	    		{
	    			rs2.close();
	    		}
    			//if od Limit or Outstanding which ever is higher for cr
    			//if dr limit
    			if(str_Loantype.equalsIgnoreCase("TL")||str_Loantype.equalsIgnoreCase("DL"))
    			{
    				if(strheadfac.equalsIgnoreCase("1"))
    				{
    					dblExposure=dblExposure/50;
    				}
    				dbl_exifundostot+=dblExposure;
    			}
    			else
    			{
    				if(strBaltype.equalsIgnoreCase("DR"))
    				{
    					if(dblLimit>dblOs)
    					{
    						if(strheadfac.equalsIgnoreCase("1"))
    	    				{
    							dblLimit=dblLimit/50;
    	    				}
    						dbl_exifundostot+=dblLimit;
    					}else
    					{
    						if(strheadfac.equalsIgnoreCase("1"))
    	    				{
    							dblOs=dblOs/50;
    	    				}
    						dbl_exifundostot+=dblOs;
    					}
    				}else
    				{
    					if(strheadfac.equalsIgnoreCase("1"))
	    				{
    						dblLimit=dblLimit/50;
	    				}
    					dbl_exifundostot+=dblLimit;
    				}
    			}
    		}
    		if(rs1!=null)
    		{
    			rs1.close();
    		}
    		strfundtype="'N','NF'";
    		strQuery1=SQLParser.getSqlQuery("sel_combkfundednon_rating^"+strAppno+"^"+strAppno+"^"+strfundtype+"^Y");
    		rs1=DBUtils.executeQuery(strQuery1);
    		while(rs1.next())
    		{
    			str_Loantype="";
    			strheadfac="";
    			strcombk_modtype=Helper.correctNull((String)rs1.getString("combk_modtype"));
    			strFacility=Helper.correctNull((String)rs1.getString("combk_facility"));
    			strBaltype=Helper.correctNull((String)rs1.getString("combk_baltype"));
    			dblExposure=Double.parseDouble(Helper.correctDouble((String)rs1.getString("com_exposure")));
    			dblOs=Double.parseDouble(Helper.correctDouble((String)rs1.getString("combk_os")));
    			dblLimit=Double.parseDouble(Helper.correctDouble((String)rs1.getString("combk_limit")));
    			String[] strFacilityArr=strFacility.split("~");
    			if(strcombk_modtype.equalsIgnoreCase("p") || strcombk_modtype.equalsIgnoreCase("r"))
				{
					strQuery2=SQLParser.getSqlQuery("sel_retProductDesc^"+strFacilityArr[0]);
					rs2 = DBUtils.executeQuery(strQuery2);
					if(rs2.next())
					{
						str_Loantype=Helper.correctNull(rs2.getString("PRD_LOANTYPE"));
					}
				}
				else
				{
					strQuery2=SQLParser.getSqlQuery("sel_FacilityCorpDesc^"+strFacilityArr[0]+"^"+strcombk_modtype);
					rs2 = DBUtils.executeQuery(strQuery2);
					if(rs2.next())
					{
						str_Loantype=Helper.correctNull(rs2.getString("com_facility_loantype"));
						strheadfac=Helper.correctNull(rs2.getString("com_headfac"));
					}
				}
    			if(rs2!=null)
	    		{
	    			rs2.close();
	    		}
    			//if od Limit or Outstanding which ever is higher for cr
    			//if dr limit
    			if(str_Loantype.equalsIgnoreCase("TL")||str_Loantype.equalsIgnoreCase("DL"))
    			{
    				if(strheadfac.equalsIgnoreCase("1"))
    				{
    					dblExposure=dblExposure/50;
    				}
    				dbl_exinonfundostot+=dblExposure;
    			}
    			else
    			{
    				if(strBaltype.equalsIgnoreCase("DR"))
    				{
    					if(dblLimit>dblOs)
    					{
    						if(strheadfac.equalsIgnoreCase("1"))
    	    				{
    							dblLimit=dblLimit/50;
    	    				}
    						dbl_exinonfundostot+=dblLimit;
    					}else
    					{
    						if(strheadfac.equalsIgnoreCase("1"))
    	    				{
    							dblOs=dblOs/50;
    	    				}
    						dbl_exinonfundostot+=dblOs;
    					}
    				}else
    				{
    					if(strheadfac.equalsIgnoreCase("1"))
	    				{
    						dblLimit=dblLimit/50;
	    				}
    					dbl_exinonfundostot+=dblLimit;
    				}
    			}
    		}
    		if(rs1!=null)
    		{
    			rs1.close();
    		}
    		strQuery1=SQLParser.getSqlQuery("sel_corpBankfacilitylist^"+strAppno+"^0");
    		rs1=DBUtils.executeQuery(strQuery1);
    		while(rs1.next())
    		{
    			
    			strSchnonsche=Helper.correctNull((String)rs1.getString("MIS_SCHEMATIC"));
    			strheadfac=Helper.correctNull(rs1.getString("com_headfac"));
				if(strSchnonsche.equalsIgnoreCase("Y"))
    			{
    				strRatingcheck="N";
    			}else if(strSchnonsche.equalsIgnoreCase("N"))
    			{
    				strRatingcheck="Y";
    			}
    			//For 100% cash margin products should not include for Rating based exposure 
    			if(arrCashMarginCode.contains(strfacility_code))
    			{
    				strRatingcheck="N";
    			}
    			if(strRatingcheck.equalsIgnoreCase("y"))
    			{
    				if(Helper.correctNull((String)rs1.getString("com_factype")).equalsIgnoreCase("NF"))
    				{
    					if(strheadfac.equalsIgnoreCase("1"))
    					{
    						dbl_propnonfundostot+=Double.parseDouble(Helper.correctDouble((String)rs1.getString("facility_proposed")))/50;
    					}else
    					{
    						dbl_propnonfundostot+=Double.parseDouble(Helper.correctDouble((String)rs1.getString("facility_proposed")));		
    					}
    				}
    				else if(Helper.correctNull((String)rs1.getString("com_factype")).equalsIgnoreCase("F"))
    				{
    					if(strheadfac.equalsIgnoreCase("1"))
    					{
    						dbl_propfundostot+=Double.parseDouble(Helper.correctDouble((String)rs1.getString("facility_proposed")))/50;
    					}else
    					{
    						dbl_propfundostot+=Double.parseDouble(Helper.correctDouble((String)rs1.getString("facility_proposed")));		
    					}
    				}
    			}
    		}
    		if(rs1!=null)
    		{
    			rs1.close();
    		}
    		strQuery1=SQLParser.getSqlQuery("sel_corpBankfacilitylist_notopened^"+strAppno);
    		rs1=DBUtils.executeQuery(strQuery1);
    		while(rs1.next())
    		{
    			
    			strSchnonsche=Helper.correctNull((String)rs1.getString("MIS_SCHEMATIC"));
    			strheadfac=Helper.correctNull(rs1.getString("com_headfac"));
    			if(strSchnonsche.equalsIgnoreCase("Y"))
    			{
    				strRatingcheck="N";
    			}else if(strSchnonsche.equalsIgnoreCase("N"))
    			{
    				strRatingcheck="Y";
    			}
    			//For 100% cash margin products should not include for Rating based exposure 
    			if(arrCashMarginCode.contains(strfacility_code))
    			{
    				strRatingcheck="N";
    			}
    			if(strRatingcheck.equalsIgnoreCase("y"))
    			{
    				if(Helper.correctNull((String)rs1.getString("com_factype")).equalsIgnoreCase("NF"))
    				{
    					if(strheadfac.equalsIgnoreCase("1"))
    					{
    						dbl_propnonfundostot+=Double.parseDouble(Helper.correctDouble((String)rs1.getString("facility_proposed")))/50;
    					}else
    					{
    						dbl_propnonfundostot+=Double.parseDouble(Helper.correctDouble((String)rs1.getString("facility_proposed")));		
    					}
    				}
    				else if(Helper.correctNull((String)rs1.getString("com_factype")).equalsIgnoreCase("F"))
    				{
    					if(strheadfac.equalsIgnoreCase("1"))
    					{
    						dbl_propfundostot+=Double.parseDouble(Helper.correctDouble((String)rs1.getString("facility_proposed")))/50;
    					}else
    					{
    						dbl_propfundostot+=Double.parseDouble(Helper.correctDouble((String)rs1.getString("facility_proposed")));		
    					}
    				}
    			}
    		}
    		if(rs1!=null)
    		{
    			rs1.close();
    		}
    		dbl_totalexposurefund=dbl_exifundostot+dbl_propfundostot;
    		dbl_totalexposureNonfund=dbl_exinonfundostot+dbl_propnonfundostot;
    		hshResult.put("RatingExposureFund", String.valueOf(dbl_totalexposurefund));
    		hshResult.put("RatingExposureNonFund", String.valueOf(dbl_totalexposureNonfund));
    	}
    	catch(Exception e)
    	{
    		throw new EJBException("Error in getRatingExposurecorp "+e.toString());
    	}
    	finally
    	{
    	 try
    	 {
    		 if(rs!=null)
      			rs.close();
    		 if(rs1!=null)
     			rs1.close();
   		    if(rs2!=null)
    			rs2.close();
    	 }
    	 catch(Exception c)
    	 {
    		 throw new EJBException("Error in Closing "+c.toString());
    	 }
    	}
    	return hshResult;
    }
    
    public HashMap getRatingExposureretail(HashMap hshValues) 
    {
    	HashMap hshResult = new HashMap();
    	HashMap hshRecord =new HashMap();
    	String strQuery1="";
    	ResultSet rs1=null,rs=null,rs2=null;
    	String strAppno="",strQuery2="",strQuery="",strheadfac="";
    	double dbl_exifundostot=0.00,dbl_totalexposurefund=0.00,dbl_totalexposureNonfund=0.00,dbl_propfundostot=0.00,dbl_propexisfndtot=0.00,dbl_exinonfundostot=0.00;
    	double dbl_propnonfundostot=0.00;
    	String strSchnonsche="",strRatingcheck="",strfacility_code="",strRestrFlag="";
    	//For 100% cash margin products should not include for Rating based exposure 
	    ArrayList arrCashmargincode= new ArrayList();
	    arrCashmargincode.add("153");
	    arrCashmargincode.add("154");
	    arrCashmargincode.add("156");
	    arrCashmargincode.add("158");
    	try
    	{
    		strAppno=Helper.correctNull((String)hshValues.get("appno"));
    		//for taking Existing funded 
    		String strcombk_modtype="",str_Loantype="",strFacility = null,strBaltype="";
    		double dblExposure=0,dblOs=0,dblLimit=0;
    		String strfundtype="'F'";
    		strQuery1=SQLParser.getSqlQuery("sel_combkfundednon_rating^"+strAppno+"^"+strAppno+"^"+strfundtype+"^Y");
    		rs1=DBUtils.executeQuery(strQuery1);
    		while(rs1.next())
    		{
    			str_Loantype="";
    			strheadfac="";
    			strcombk_modtype=Helper.correctNull((String)rs1.getString("combk_modtype"));
    			strRestrFlag=Helper.correctNull((String)rs1.getString("restrflag"));
    			strFacility=Helper.correctNull((String)rs1.getString("combk_facility"));
    			strBaltype=Helper.correctNull((String)rs1.getString("combk_baltype"));
    			dblExposure=Double.parseDouble(Helper.correctDouble((String)rs1.getString("com_exposure")));
    			dblOs=Double.parseDouble(Helper.correctDouble((String)rs1.getString("combk_os")));
    			dblLimit=Double.parseDouble(Helper.correctDouble((String)rs1.getString("combk_limit")));
    			String[] strFacilityArr=strFacility.split("~");
    			if(strcombk_modtype.equalsIgnoreCase("p") || strcombk_modtype.equalsIgnoreCase("r"))
				{
					strQuery2=SQLParser.getSqlQuery("sel_retProductDesc^"+strFacilityArr[0]);
					rs2 = DBUtils.executeQuery(strQuery2);
					if(rs2.next())
					{
						str_Loantype=Helper.correctNull(rs2.getString("PRD_LOANTYPE"));
					}
				}
				else
				{
					strQuery2=SQLParser.getSqlQuery("sel_FacilityCorpDesc^"+strFacilityArr[0]+"^"+strcombk_modtype);
					rs2 = DBUtils.executeQuery(strQuery2);
					if(rs2.next())
					{
						str_Loantype=Helper.correctNull(rs2.getString("com_facility_loantype"));
						strheadfac=Helper.correctNull(rs2.getString("com_headfac"));
					}
				}
    			if(rs2!=null)
	    		{
	    			rs2.close();
	    		}
    			//if od Limit or Outstanding which ever is higher for cr
    			//if dr limit
    			if(str_Loantype.equalsIgnoreCase("TL")||str_Loantype.equalsIgnoreCase("DL"))
    			{
    				if(strheadfac.equalsIgnoreCase("1"))
    				{
    					dblExposure=dblExposure/50;
    				}
    				if(strRestrFlag.equalsIgnoreCase("N"))
    				dbl_exifundostot+=dblExposure;
    			}
    			else
    			{
    				if(strBaltype.equalsIgnoreCase("DR"))
    				{
    					if(dblLimit>dblOs)
    					{
    						if(strheadfac.equalsIgnoreCase("1"))
    	    				{
    							dblLimit=dblLimit/50;
    	    				}
    						if(strRestrFlag.equalsIgnoreCase("N"))
    						dbl_exifundostot+=dblLimit;
    					}else
    					{
    						if(strheadfac.equalsIgnoreCase("1"))
    	    				{
    							dblOs=dblOs/50;
    	    				}
    						if(strRestrFlag.equalsIgnoreCase("N"))
    						dbl_exifundostot+=dblOs;
    					}
    				}else
    				{
    					if(strheadfac.equalsIgnoreCase("1"))
	    				{
    						dblLimit=dblLimit/50;
	    				}
    					if(strRestrFlag.equalsIgnoreCase("N"))
    					dbl_exifundostot+=dblLimit;
    				}
    			}
    		}
    		if(rs1!=null)
    		{
    			rs1.close();
    		}
    		strfundtype="'N','NF'";
    		strQuery1=SQLParser.getSqlQuery("sel_combkfundednon_rating^"+strAppno+"^"+strAppno+"^"+strfundtype+"^Y");
    		rs1=DBUtils.executeQuery(strQuery1);
    		while(rs1.next())
    		{
    			str_Loantype="";
    			strheadfac="";
    			strRestrFlag=Helper.correctNull((String)rs1.getString("restrflag"));
    			strcombk_modtype=Helper.correctNull((String)rs1.getString("combk_modtype"));
    			strFacility=Helper.correctNull((String)rs1.getString("combk_facility"));
    			strBaltype=Helper.correctNull((String)rs1.getString("combk_baltype"));
    			dblExposure=Double.parseDouble(Helper.correctDouble((String)rs1.getString("com_exposure")));
    			dblOs=Double.parseDouble(Helper.correctDouble((String)rs1.getString("combk_os")));
    			dblLimit=Double.parseDouble(Helper.correctDouble((String)rs1.getString("combk_limit")));
    			String[] strFacilityArr=strFacility.split("~");
    			if(strcombk_modtype.equalsIgnoreCase("p") || strcombk_modtype.equalsIgnoreCase("r"))
				{
					strQuery2=SQLParser.getSqlQuery("sel_retProductDesc^"+strFacilityArr[0]);
					rs2 = DBUtils.executeQuery(strQuery2);
					if(rs2.next())
					{
						str_Loantype=Helper.correctNull(rs2.getString("PRD_LOANTYPE"));
					}
				}
				else
				{
					strQuery2=SQLParser.getSqlQuery("sel_FacilityCorpDesc^"+strFacilityArr[0]+"^"+strcombk_modtype);
					rs2 = DBUtils.executeQuery(strQuery2);
					if(rs2.next())
					{
						str_Loantype=Helper.correctNull(rs2.getString("com_facility_loantype"));
						strheadfac=Helper.correctNull(rs2.getString("com_headfac"));
					}
				}
    			if(rs2!=null)
	    		{
	    			rs2.close();
	    		}
    			//if od Limit or Outstanding which ever is higher for cr
    			//if dr limit
    			if(str_Loantype.equalsIgnoreCase("TL")||str_Loantype.equalsIgnoreCase("DL"))
    			{
    				if(strheadfac.equalsIgnoreCase("1"))
    				{
    					dblExposure=dblExposure/50;
    				}
    				if(strRestrFlag.equalsIgnoreCase("N"))
    				dbl_exinonfundostot+=dblExposure;
    			}
    			else
    			{
    				if(strBaltype.equalsIgnoreCase("DR"))
    				{
    					if(dblLimit>dblOs)
    					{
    						if(strheadfac.equalsIgnoreCase("1"))
    	    				{
    							dblLimit=dblLimit/50;
    	    				}
    						if(strRestrFlag.equalsIgnoreCase("N"))
    						dbl_exinonfundostot+=dblLimit;
    					}else
    					{
    						if(strheadfac.equalsIgnoreCase("1"))
    	    				{
    							dblOs=dblOs/50;
    	    				}
    						if(strRestrFlag.equalsIgnoreCase("N"))
    						dbl_exinonfundostot+=dblOs;
    					}
    				}else
    				{
    					if(strheadfac.equalsIgnoreCase("1"))
	    				{
    						dblLimit=dblLimit/50;
	    				}
    					if(strRestrFlag.equalsIgnoreCase("N"))
    					dbl_exinonfundostot+=dblLimit;
    				}
    			}
    		}
    		if(rs1!=null)
    		{
    			rs1.close();
    		}
    		strQuery1=SQLParser.getSqlQuery("selperprdintrate^"+strAppno);  // Recommended loan amt(proposed) from loandetails
    		rs1=DBUtils.executeQuery(strQuery1);
    		if(rs1.next())
    		{
    			strfacility_code=Helper.correctNull((String)rs1.getString("app_prdcode"));
    			strQuery = SQLParser.getSqlQuery("sel_retailBankschemetype^1"+"^"+strfacility_code);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strSchnonsche=Helper.correctNull((String)rs.getString("MIS_SCHEMATIC"));
				}
				if(strSchnonsche.equalsIgnoreCase("Y"))
    			{
    				strRatingcheck="N";
    			}else if(strSchnonsche.equalsIgnoreCase("N"))
    			{
    				strRatingcheck="Y";
    			}
    			//For 100% cash margin products should not include for Rating based exposure 
    			if(arrCashmargincode.contains(strfacility_code))
    			{
    				strRatingcheck="N";
    			}
    			if(strRatingcheck.equalsIgnoreCase("y"))
    			{
    				dbl_propfundostot+=Double.parseDouble(Helper.correctDouble((String)rs1.getString("loan_recmdamt")));
    			}
    		}
    		if(rs1!=null)
    		{
    			rs1.close();
    		}
    		strQuery1=SQLParser.getSqlQuery("selperprdintrate_notopen^"+strAppno);  // Recommended loan amt(Sanctioned not account opened) from loandetails
    		rs1=DBUtils.executeQuery(strQuery1);
    		if(rs1.next())
    		{
    			strfacility_code=Helper.correctNull((String)rs1.getString("app_prdcode"));
    			strQuery = SQLParser.getSqlQuery("sel_retailBankschemetype^1"+"^"+strfacility_code);
    			rs=DBUtils.executeQuery(strQuery);
    			if(rs.next())
    			{
    				strSchnonsche=Helper.correctNull((String)rs.getString("MIS_SCHEMATIC"));
    			}
    			if(strSchnonsche.equalsIgnoreCase("Y"))
    			{
    				strRatingcheck="N";
    			}else if(strSchnonsche.equalsIgnoreCase("N"))
    			{
    				strRatingcheck="Y";
    			}
    			//For 100% cash margin products should not include for Rating based exposure 
    			if(arrCashmargincode.contains(strfacility_code))
    			{
    				strRatingcheck="N";
    			}
    			if(strRatingcheck.equalsIgnoreCase("y"))
    			{
    				dbl_propfundostot+=Double.parseDouble(Helper.correctDouble((String)rs1.getString("loan_recmdamt")));
    			}
    		}
    		if(rs1!=null)
    		{
    			rs1.close();
    		}
    		dbl_totalexposurefund=dbl_exifundostot+dbl_propfundostot;
    		hshResult.put("RatingExposureFund", String.valueOf(dbl_totalexposurefund));
    		hshResult.put("RatingExposureNonFund", String.valueOf(dbl_exinonfundostot));
    	}
    	catch(Exception e)
    	{
    		throw new EJBException("Error in getRatingExposureretail "+e.toString());
    	}
    	finally
    	{
    	 try
    	 {
    		 if(rs!=null)
      			rs.close();
    		 if(rs1!=null)
     			rs1.close();
   		    if(rs2!=null)
    			rs2.close();
    	 }
    	 catch(Exception c)
    	 {
    		 throw new EJBException("Error in Closing "+c.toString());
    	 }
    	}
    	return hshResult;
    }
    
    public HashMap getattachSecurity(HashMap hshValues) 
    {
    	java.text.NumberFormat jtn= java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);		
		
    	String strQuery="",strSno="",strAppno="",strFacCode="",strFacType="";
		ResultSet rs = null,rs1 = null,rs2 = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();
		ArrayList vecVal = new ArrayList();
		ArrayList arrFacID = new ArrayList();
		ArrayList arrColFacID = new ArrayList();
		String hidposition= correctNull((String)hshValues.get("hidposition"));
		String hidFacID= correctNull((String)hshValues.get("hidFacIDlist"));
		double dblExist=0.00,dblProposed=0.00,dblMargin=0.00;
		String selSecType=Helper.correctNull((String)hshValues.get("secType"));
		String secID= Helper.correctNull((String)hshValues.get("hidSecID"));
		String strbowid=Helper.correctNull((String)hshValues.get("applicantid"));
		String strborrid[]=null;
		String strSecOwnerId=Helper.correctNull((String)hshValues.get("strSecOwnerId"));
		String strSecClassifi=Helper.correctNull((String)hshValues.get("strSecClassifi"));
		
    	try
    	{
    		int lngGrpSize = 0,intGroup =0;
    		strAppno=Helper.correctNull((String)hshValues.get("appno"));
    		ArrayList arrSubGrp = new ArrayList();
    		
    		strborrid=strbowid.split("~");
			String strLimit="",strOutstand="",strMargin="",strApplicantid="",strParentfacno="";	
			strQuery = SQLParser.getSqlQuery("sel_applicantiddemo^"+strAppno);
			rs1 = DBUtils.executeQuery(strQuery);
    		if(rs1.next())
			{
    			strApplicantid=Helper.correctNull((String)rs1.getString("DEMO_COMAPPID"));
			}
    		if(rs1 != null)
			{
				rs1.close();
			}
			
			strQuery = SQLParser.getSqlQuery("sel_faclist_sec1^" + strAppno +"^"+intGroup);
			rs1 = DBUtils.executeQuery(strQuery);
    		while(rs1.next())
			{
				vecVal = new ArrayList();
				strFacType="";String strLoanagainstShare="";
				strQuery = SQLParser.getSqlQuery("sel_facilitycorp_desc^" + correctNull((String)rs1.getString("facility_code")));
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strFacCode=rs.getString("com_facdesc");
					strLoanagainstShare=Helper.correctNull(rs.getString("com_loanagainstshares"));
				}
				
				strMargin="0.00";			
				vecVal.add(strFacCode);//0
				dblProposed =rs1.getDouble("facility_proposed");
				strOutstand = jtn.format(dblProposed);
				strSno =correctNull(rs1.getString("facility_sno"));
				vecVal.add(strOutstand);//1
				vecVal.add(strMargin);//2
				vecVal.add(strSno);//3
				vecVal.add(correctNull((String)rs1.getString("facility_code")));//4
				vecVal.add(correctNull((String)rs1.getString("COM_FACTYPE")));//5
				vecVal.add(correctNull((String)rs1.getString("facility_nature")));//6
				vecVal.add(strOutstand);//7 For Proposed Facility - Limit & OS amount are same
				vecVal.add("P");//8
				vecVal.add("");//9
				vecVal.add("");//10
				vecVal.add("");//11
				vecVal.add(strApplicantid);//12
				
				//To select the post sanction parameters
//				String strTemp = "and PS_APP_SNO='"+correctNull((String)rs1.getString("facility_sno"))+"'";
				String strQueryPS = SQLParser.getSqlQuery("sel_postsanctiondet^"+correctNull((String)rs1.getString("facility_sno"))+"^"+strAppno);
				ResultSet rsPS = DBUtils.executeQuery(strQueryPS);
				if(rsPS.next())
				{
					vecVal.add("@"+Helper.correctNull(rsPS.getString("PS_MODIFY_TERMS")));//13
				}
				else
				{
					vecVal.add("");//13
				}
				
				if(strSecOwnerId.equalsIgnoreCase(strApplicantid))
				{
					vecVal.add("Y");//14
				}
				else
				{
					strQueryPS = SQLParser.getSqlQuery("sel_groupconcernchk^"+strSecOwnerId+"^"+correctNull((String)rs1.getString("facility_sno"))+"^"+strAppno);
					if(rsPS!=null)
						rsPS.close();
					rsPS = DBUtils.executeQuery(strQueryPS);
					if(rsPS.next())
					{
						vecVal.add("Y");//14
					}
					else
					{
						vecVal.add("N");//14
					}
				}
				vecVal.add(Helper.correctNull(rs1.getString("facility_sel_type")));//15
				vecVal.add(strLoanagainstShare);//16
				
				
				if(strSecClassifi.equalsIgnoreCase("40"))
				{
					boolean bflag=false;
					if(rs2 !=null)
					{rs2.close();}
					strQuery = SQLParser.getSqlQuery("chk_attachedtoproposal^"+secID);
					rs2 = DBUtils.executeQuery(strQuery);
					while(rs2.next())
					{
						if(!(Helper.correctNull(rs2.getString("app_sec_appno")).equalsIgnoreCase(strAppno) && Helper.correctNull(rs2.getString("app_sec_facsno")).equalsIgnoreCase(correctNull((String)rs1.getString("facility_sno")))))
						{
							if((!Helper.correctNull(rs2.getString("status")).equalsIgnoreCase("ca")&&(Helper.correctNull(rs2.getString("loantype")).equalsIgnoreCase("pS")||Helper.correctNull(rs2.getString("loantype")).equalsIgnoreCase("Y")))||(strLoanagainstShare.equalsIgnoreCase("Y")))
								bflag=true;
						}
					}
					if(bflag)
						vecVal.add("Y");//17
					else
						vecVal.add("N");//17
					
					if(rs2 !=null)
					{rs2.close();}
					strQuery = SQLParser.getSqlQuery("chk_approvedsharedet^"+secID);
					rs2 = DBUtils.executeQuery(strQuery);
					if(rs2.next())
					{
						if(Helper.correctNull(rs2.getString("svm_companyapproveflag")).equalsIgnoreCase("U")||Helper.correctNull(rs2.getString("svm_companyactiveflag")).equalsIgnoreCase("n"))
							vecVal.add("N");
						else
							vecVal.add("");
						if(strLoanagainstShare.equalsIgnoreCase("Y"))
						{
							if(Helper.correctNull(rs1.getString("com_sharetype")).equalsIgnoreCase(Helper.correctNull(rs2.getString("cus_sec_sharetype"))))
								vecVal.add("Y");
							else
								vecVal.add("N");
						}
						else
						{
							vecVal.add("");//19
						}
						
					}
					else
					{
						vecVal.add("");//18
						vecVal.add("");//19
					}
				}
				else
				{
					vecVal.add("N");//17
					vecVal.add("");
					vecVal.add("");
				}
				vecVal.add(correctNull((String)rs1.getString("FACILITY_WHT_CGTMSEAPPLY")));//20
				hshRecord.put("Proposed","Y");
				
				if(Helper.correctNull(rs1.getString("facility_category")).equalsIgnoreCase("R")||Helper.correctNull(rs1.getString("facility_category")).equalsIgnoreCase("O"))
				{
					vecVal.add("");//21
					vecVal.add("");//22
				}
				else
				{
					if(rs2!=null)
						rs2.close();
					strQuery = SQLParser.getSqlQuery("sel_facility_additionaldetails^"+strAppno+"^"+correctNull(rs1.getString("facility_sno")));
					rs2 = DBUtils.executeQuery(strQuery);
					if(rs2.next())
					{
						vecVal.add(Helper.correctNull(rs2.getString("Fac_Addappno")));
						vecVal.add(Helper.correctNull(rs2.getString("Fac_Addappsno")));
					}
					else
					{
						vecVal.add("");
						vecVal.add("");
					}
				}
				vecVal.add(Helper.correctNull(rs1.getString("facility_category")));//23
				vecVal.add(Helper.correctNull(rs1.getString("facility_group")));//24
				vecData.add(vecVal);			
				
			}
    		if(rs1 != null)
			{
				rs1.close();
			}
    		if(strborrid.length>1)
    		{
    			for(int a=0;a<strborrid.length;a++)
	    		{
    				strbowid=strborrid[a];
    				if(!strbowid.equalsIgnoreCase(""))
	    			{
			    		if(strbowid.equalsIgnoreCase(strApplicantid))
			    		{
							strLimit="";
							strOutstand="";
							strMargin="";
							String strbnkFac="",str_modtype="",strNature="",strFacType1="";
							strQuery = SQLParser.getSqlQuery("sel_banking^" + strAppno);
							rs1 = DBUtils.executeQuery(strQuery);
							while(rs1.next())
							{
								vecVal = new ArrayList();
								strNature="";strFacType1="";
								strbnkFac = Helper.correctNull((String)rs1.getString("combk_facility"));
								str_modtype=Helper.correctNull((String)rs1.getString("combk_modtype"));
								String[] bankFac = strbnkFac.split("~");
								String strFlag="C";
								if(str_modtype.equalsIgnoreCase("c") || str_modtype.equalsIgnoreCase("a"))
								{
									strQuery = SQLParser.getSqlQuery("sel_facilitycorp_desc^" + bankFac[0]);
									rs = DBUtils.executeQuery(strQuery);
									if(rs.next())
									{
										strFacCode=rs.getString("com_facdesc");
										strNature=rs.getString("com_facnature");
										strFacType1=rs.getString("com_factype");
									}
								}
								else if(str_modtype.equalsIgnoreCase("r") || str_modtype.equalsIgnoreCase("p"))
								{
										strQuery=SQLParser.getSqlQuery("sel_retProductDesc^"+bankFac[0]);
										rs = DBUtils.executeQuery(strQuery);
										if(rs.next())
										{
											strFacCode=Helper.correctNull(rs.getString("com_facdesc"));
											strFlag="R";
											strFacType1="F";
											strNature=rs.getString("prd_loantype");
										}
								}
								vecVal.add(strFacCode);//0
								dblProposed =rs1.getDouble("combk_limit");
								strOutstand = jtn.format(dblProposed);
								vecVal.add(strOutstand);//1
								vecVal.add("");//2
								vecVal.add(Helper.correctNull((String)rs1.getString("combk_facility_sno")));//3
								vecVal.add(bankFac[0]);//4
								
								vecVal.add(strFacType1);//5
								vecVal.add(strNature);//6
								dblExist =rs1.getDouble("combk_os");
								strLimit = jtn.format(dblExist);
								vecVal.add(strLimit);//7
								vecVal.add("E");//8
								hshRecord.put("Existing","Y");
								strParentfacno=Helper.correctInt((String)rs1.getString("combk_parentfacsno"));
								strQuery = SQLParser.getSqlQuery("sel_facid_appSecdetails_attached^" + Helper.correctInt((String)rs1.getString("COMBK_PARENTAPPNO")) + "^"+secID+"^"+strParentfacno);
								rs2 = DBUtils.executeQuery(strQuery);
					    		if(rs2.next())
								{
					    			vecVal.add("Y");//9
								}
					    		else
					    		{
					    			vecVal.add("N");//9
					    		}
					    		vecVal.add(Helper.correctNull((String)rs1.getString("COMBK_PARENTAPPNO")));//10
					    		vecVal.add(Helper.correctNull((String)rs1.getString("COMBK_PARENTFACSNO")));//11
					    		vecVal.add(strApplicantid);//12
					    		vecVal.add("");//13
					    		vecVal.add("N");//14
					    		vecVal.add("");//15
					    		vecVal.add("");
					    		vecVal.add("");
					    		vecVal.add("");
					    		vecVal.add("");
					    		vecVal.add("");
					    		vecVal.add("");
					    		vecVal.add("");
					    		vecVal.add("");
					    		vecVal.add("");
					    		vecData.add(vecVal);			
							}
						
			    		}else
			    		{
			    			strLimit="";
							strOutstand="";
							strMargin="";
							String strbnkFac="",str_modtype="",strNature="",strFacType1="";
							strQuery = SQLParser.getSqlQuery("sel_groupconcerns^" + strAppno);
							rs1 = DBUtils.executeQuery(strQuery);
							while(rs1.next())
							{
								vecVal = new ArrayList();
								strNature="";strFacType1="";
								strbnkFac = Helper.correctNull((String)rs1.getString("comgc_facility"));
								str_modtype=Helper.correctNull((String)rs1.getString("comgc_modtype"));
								String[] bankFac = strbnkFac.split("~");
								String strFlag="C";
								if(str_modtype.equalsIgnoreCase("c") || str_modtype.equalsIgnoreCase("a"))
								{
									strQuery = SQLParser.getSqlQuery("sel_facilitycorp_desc^" + bankFac[0]);
									rs = DBUtils.executeQuery(strQuery);
									if(rs.next())
									{
										strFacCode=rs.getString("com_facdesc");
										strNature=rs.getString("com_facnature");
										strFacType1=rs.getString("com_factype");
									}
								}
								else if(str_modtype.equalsIgnoreCase("r") || str_modtype.equalsIgnoreCase("p"))
								{
										strQuery=SQLParser.getSqlQuery("sel_retProductDesc^"+bankFac[0]);
										rs = DBUtils.executeQuery(strQuery);
										if(rs.next())
										{
											strFacCode=Helper.correctNull(rs.getString("com_facdesc"));
											strFlag="R";
											strFacType1="F";
											strNature=rs.getString("prd_loantype");
										}
								}
								vecVal.add(strFacCode);//0
								dblProposed =rs1.getDouble("comgc_limit");
								strOutstand = jtn.format(dblProposed);
								vecVal.add(strOutstand);//1
								vecVal.add("");//2
								vecVal.add(Helper.correctNull((String)rs1.getString("comgc_facility_sno")));//3
								vecVal.add(bankFac[0]);//4
								vecVal.add(strFacType1);//5
								vecVal.add(strNature);//6
								dblExist =rs1.getDouble("comgc_os");
								strLimit = jtn.format(dblExist);
								vecVal.add(strLimit);//7
								vecVal.add("E");//8
								hshRecord.put("Existing","Y");
								if(rs2 != null)
								{
									rs2.close();
								}
								strParentfacno=Helper.correctInt((String)rs1.getString("comgc_parentfacsno"));
								strQuery = SQLParser.getSqlQuery("sel_facid_appSecdetails_attached^" + Helper.correctInt((String)rs1.getString("COMgc_PARENTAPPNO")) + "^"+secID+"^"+strParentfacno);
								rs2 = DBUtils.executeQuery(strQuery);
					    		if(rs2.next())
								{
					    			vecVal.add("Y");//9
								}
					    		else
					    		{
					    			vecVal.add("N");//9
					    		}
					    		vecVal.add(Helper.correctNull((String)rs1.getString("COMgc_PARENTAPPNO")));//10
					    		vecVal.add(Helper.correctNull((String)rs1.getString("COMgc_PARENTFACSNO")));//11
					    		vecVal.add(Helper.correctNull((String)rs1.getString("comgc_companyname")));//12
					    		vecVal.add("");//13
					    		vecVal.add("N");//14
					    		vecVal.add("");//15
					    		vecVal.add("");
					    		vecVal.add("");
					    		vecVal.add("");
					    		vecVal.add("");
					    		vecVal.add("");
					    		vecVal.add("");
					    		vecVal.add("");
					    		vecVal.add("");
					    		vecVal.add("");
					    		vecData.add(vecVal);
							}
						}
	    			}
	    		}
    		}
    		else
    		{
    			if(!strbowid.equalsIgnoreCase(""))
    			{
	    		if(strbowid.equalsIgnoreCase(strApplicantid))
	    		{
					strLimit="";
					strOutstand="";
					strMargin="";
					String strbnkFac="",str_modtype="",strNature="",strFacType1="";
					strQuery = SQLParser.getSqlQuery("sel_banking^" + strAppno);
					rs1 = DBUtils.executeQuery(strQuery);
					while(rs1.next())
					{
						vecVal = new ArrayList();
						strNature="";strFacType1="";
						strbnkFac = Helper.correctNull((String)rs1.getString("combk_facility"));
						str_modtype=Helper.correctNull((String)rs1.getString("combk_modtype"));
						String[] bankFac = strbnkFac.split("~");
						String strFlag="C";
						if(str_modtype.equalsIgnoreCase("c") || str_modtype.equalsIgnoreCase("a"))
						{
							strQuery = SQLParser.getSqlQuery("sel_facilitycorp_desc^" + bankFac[0]);
							rs = DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								strFacCode=rs.getString("com_facdesc");
								strNature=rs.getString("com_facnature");
								strFacType1=rs.getString("com_factype");
							}
						}
						else if(str_modtype.equalsIgnoreCase("r") || str_modtype.equalsIgnoreCase("p"))
						{
								strQuery=SQLParser.getSqlQuery("sel_retProductDesc^"+bankFac[0]);
								rs = DBUtils.executeQuery(strQuery);
								if(rs.next())
								{
									strFacCode=Helper.correctNull(rs.getString("com_facdesc"));
									strFlag="R";
									strFacType1="F";
    								strNature=rs.getString("prd_loantype");
								}
						}
						vecVal.add(strFacCode);//0
						dblProposed =rs1.getDouble("combk_limit");
						strOutstand = jtn.format(dblProposed);
						vecVal.add(strOutstand);//1
						vecVal.add("");//2
						vecVal.add(Helper.correctNull((String)rs1.getString("combk_facility_sno")));//3
						vecVal.add(bankFac[0]);//4
						vecVal.add(strFacType1);//5
						vecVal.add(strNature);//6
						dblExist =rs1.getDouble("combk_os");
						strLimit = jtn.format(dblExist);
						vecVal.add(strLimit);//7
						vecVal.add("E");//8
						hshRecord.put("Existing","Y");
						strParentfacno=Helper.correctInt((String)rs1.getString("combk_parentfacsno"));
						strQuery = SQLParser.getSqlQuery("sel_facid_appSecdetails_attached^" + Helper.correctInt((String)rs1.getString("COMBK_PARENTAPPNO")) + "^"+secID+"^"+strParentfacno);
						rs2 = DBUtils.executeQuery(strQuery);
			    		if(rs2.next())
						{
			    			vecVal.add("Y");//9
						}
			    		else
			    		{
			    			vecVal.add("N");//9
			    		}
			    		vecVal.add(Helper.correctNull((String)rs1.getString("COMBK_PARENTAPPNO")));//10
			    		vecVal.add(Helper.correctNull((String)rs1.getString("COMBK_PARENTFACSNO")));//11
			    		vecVal.add(strApplicantid);//12
			    		vecVal.add("");//13
			    		vecVal.add("N");//14
			    		vecVal.add("");//15
			    		vecVal.add("");
			    		vecVal.add("");
			    		vecVal.add("");
			    		vecVal.add("");
			    		vecVal.add("");
			    		vecVal.add("");
			    		vecVal.add("");
			    		vecVal.add("");
			    		vecVal.add("");
			    		vecData.add(vecVal);			
					}
				
	    		}else
	    		{
	    			strLimit="";
					strOutstand="";
					strMargin="";
					String strbnkFac="",str_modtype="",strNature="",strFacType1="";
					strQuery = SQLParser.getSqlQuery("sel_groupconcerns^" + strAppno);
					rs1 = DBUtils.executeQuery(strQuery);
					while(rs1.next())
					{
						vecVal = new ArrayList();
						strNature="";strFacType1="";
						strbnkFac = Helper.correctNull((String)rs1.getString("comgc_facility"));
						str_modtype=Helper.correctNull((String)rs1.getString("comgc_modtype"));
						String[] bankFac = strbnkFac.split("~");
						String strFlag="C";
						if(str_modtype.equalsIgnoreCase("c") || str_modtype.equalsIgnoreCase("a"))
						{
							strQuery = SQLParser.getSqlQuery("sel_facilitycorp_desc^" + bankFac[0]);
							rs = DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								strFacCode=rs.getString("com_facdesc");
								strNature=rs.getString("com_facnature");
    							strFacType1=rs.getString("com_factype");
							}
						}
						else if(str_modtype.equalsIgnoreCase("r") || str_modtype.equalsIgnoreCase("p"))
						{
								strQuery=SQLParser.getSqlQuery("sel_retProductDesc^"+bankFac[0]);
								rs = DBUtils.executeQuery(strQuery);
								if(rs.next())
								{
									strFacCode=Helper.correctNull(rs.getString("com_facdesc"));
									strFlag="R";
									strFacType1="F";
    								strNature=rs.getString("prd_loantype");
								}
						}
						vecVal.add(strFacCode);//0
						dblProposed =rs1.getDouble("comgc_limit");
						strOutstand = jtn.format(dblProposed);
						vecVal.add(strOutstand);//1
						vecVal.add("");//2
						vecVal.add(Helper.correctNull((String)rs1.getString("comgc_facility_sno")));//3
						vecVal.add(bankFac[0]);//4
						vecVal.add(strFacType1);//5
						vecVal.add(strNature);//6
						dblExist =rs1.getDouble("comgc_os");
						strLimit = jtn.format(dblExist);
						vecVal.add(strLimit);//7
						vecVal.add("E");//8
						hshRecord.put("Existing","Y");
						if(rs2 != null)
						{
							rs2.close();
						}
						strParentfacno=Helper.correctInt((String)rs1.getString("comgc_parentfacsno"));
						strQuery = SQLParser.getSqlQuery("sel_facid_appSecdetails_attached^" + Helper.correctInt((String)rs1.getString("COMgc_PARENTAPPNO")) + "^"+secID+"^"+strParentfacno);
						rs2 = DBUtils.executeQuery(strQuery);
			    		if(rs2.next())
						{
			    			vecVal.add("Y");//9
						}
			    		else
			    		{
			    			vecVal.add("N");//9
			    		}
			    		vecVal.add(Helper.correctNull((String)rs1.getString("COMgc_PARENTAPPNO")));//10
			    		vecVal.add(Helper.correctNull((String)rs1.getString("COMgc_PARENTFACSNO")));//11
			    		vecVal.add(Helper.correctNull((String)rs1.getString("comgc_companyname")));//12
			    		vecVal.add("");//13
			    		vecVal.add("N");//14
			    		vecVal.add("");//15
			    		vecVal.add("");
			    		vecVal.add("");
			    		vecVal.add("");
			    		vecVal.add("");
			    		vecVal.add("");
			    		vecVal.add("");
			    		vecVal.add("");
			    		vecVal.add("");
			    		vecVal.add("");
			    		vecData.add(vecVal);
					}
				}
    		}
    		}
    		if(rs2 != null)
			{
				rs2.close();
			}
    		
    		String strFacID="";
    		strQuery = SQLParser.getSqlQuery("sel_appSecdetails_attached^" + strAppno + "^"+secID);
			rs2 = DBUtils.executeQuery(strQuery);
			while(rs2.next())
			{
    			arrFacID = new ArrayList();
    			arrFacID.add(correctNull((String)rs2.getString("app_sec_facid")));
    			arrFacID.add(correctNull((String)rs2.getString("APP_SEC_MARGIN")));
    			arrFacID.add(correctNull((String)rs2.getString("app_sec_securitytype")));
    			arrFacID.add(correctNull((String)rs2.getString("app_sec_loantype")));
    			arrFacID.add(correctNull((String)rs2.getString("app_sec_parentappno")));
    			arrFacID.add(correctNull((String)rs2.getString("app_sec_parent_facsno")));
    			arrFacID.add(correctNull((String)rs2.getString("APP_SEC_SECUTYPE")));
    			arrFacID.add(correctNull((String)rs2.getString("app_sec_facsno")));
    			arrColFacID.add(arrFacID);
			}
			if(rs2 != null)
			{
				rs2.close();
			}
			
			strQuery = SQLParser.getSqlQuery("selsecpropdet_cersai^"+secID);
			rs2 = DBUtils.executeQuery(strQuery);
			if(rs2.next())
			{
				
				hshRecord.put("SEC_CERSAIREFNO",correctNull(rs2 .getString("SEC_CERSAIREFNO")));
				hshRecord.put("SEC_ALREADY_MORTG",correctNull(rs2 .getString("SEC_ALREADY_MORTG")));
				hshRecord.put("SEC_SEARCHPERFORM_DATE",correctNull(rs2.getString("SEC_SEARCHPERFORM_DATE")));
				hshRecord.put("cus_sec_type",correctNull(rs2.getString("cus_sec_type")));
				String cus_sec_type = correctNull(rs2.getString("cus_sec_type"));
				if(cus_sec_type.equalsIgnoreCase("10")||cus_sec_type.equalsIgnoreCase("11")||cus_sec_type.equalsIgnoreCase("12")
						||cus_sec_type.equalsIgnoreCase("13")||cus_sec_type.equalsIgnoreCase("15")||cus_sec_type.equalsIgnoreCase("16")
						||cus_sec_type.equalsIgnoreCase("17"))
				{
					if(rs1 != null)
					{
						rs1.close();
					}
					strQuery = SQLParser.getSqlQuery("selsecpropdet_cersai_statdata");
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
							int intdatadesc = Integer.parseInt(Helper.correctInt(rs1.getString("stat_data_desc1")));
	
							if(rs != null)
							{
								rs.close();
							}
							
							String strcersiDate = correctNull(rs2.getString("SEC_SEARCHPERFORM_DATE"));
							String currdate = Helper.getCurrentDateTime();
							
							if(!strcersiDate.equalsIgnoreCase(""))
							{
								String strArr1[]=strcersiDate.split("@");
								for(int i=0;i<strArr1.length;i++)
								{
									strcersiDate = strArr1[i]; 
									SimpleDateFormat cersaiDate = new SimpleDateFormat("dd/MM/yyyy");//"yyyy-MM-dd""16/4/2021"
									java.util.Date date1;
									java.util.Date date2;
									date1 = cersaiDate.parse(strcersiDate);
									date2 = cersaiDate.parse(currdate);
									long diffInMillies = Math.abs(date2.getTime() - date1.getTime());
								    long diff = TimeUnit.DAYS.convert(diffInMillies, TimeUnit.MILLISECONDS);
									if(diff > intdatadesc)
									{
										hshRecord.put("cersaidate", "Y");
									}
								}
							}
					}
					
				}
			}
			if(rs1 != null)
			{
				rs1.close();
			}
    				
    		strQuery = SQLParser.getSqlQuery("sel_appstatus^"+strAppno);
			rs1 = DBUtils.executeQuery(strQuery);
    		if(rs1.next())
			{
    			hshRecord.put("strAppType",Helper.correctNull((String)rs1.getString("app_renew_flag")));
			}
    		hshRecord.put("vecData",vecData);
    		hshRecord.put("hidposition",hidposition);
    		hshRecord.put("hidFacID",hidFacID);
    		hshRecord.put("arrColFacID",arrColFacID);
    		
    		//***********************************************
    		if(rs1 != null)
			{
				rs1.close();
			}
    		strQuery = SQLParser.getSqlQuery("getsecuritysumofvalue^"+strAppno);
			rs1 = DBUtils.executeQuery(strQuery);
    		if(rs1.next())
			{
    			hshRecord.put("FACILITY_PROPOSEDValue",Helper.correctNull((String)rs1.getString("FACILITY_PROPOSED")));
			}
    		
    	}
    	catch(Exception e)
		{
			throw new EJBException("Error in getattachSecurity "+e.toString());
		} 
    	return hshRecord;
    }
    
    /*Added by Gokul for Dynamic Document Master*/
    public HashMap updateDocumentMaster(HashMap hshValues){
		HashMap hshQueryValues;
		HashMap hshQuery;
		ResultSet rs=null;
		ArrayList arrValues;
		String strSno="";
		String strQuery="";
		String hidaction=Helper.correctNull((String)hshValues.get("hidAction")); 
		String strdocid=Helper.correctNull((String)hshValues.get("txt_docuid"));
		java.sql.PreparedStatement ps=null;
		Connection con1=null;
		oracle.sql.CLOB clob=null;
		String strModuleType=Helper.correctNull((String)hshValues.get("hidsel_module"));
		try
		{
			String strCreatedDate=Helper.getCurrentDateTime();
			if(!strdocid.equalsIgnoreCase(""))
			{
				strQuery=SQLParser.getSqlQuery("sel_doctemplate^"+strdocid);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strCreatedDate=Helper.correctNull(rs.getString("doc_createddate"));
				}
				if(rs!=null)
					rs.close();
			}
			if(hidaction.equalsIgnoreCase("Insert")){
				
				if(strdocid.equals("")){
					strdocid=(String)EJBInvoker.executeStateLess("commworkflow",hshValues,"getDocumentID");
					hidaction="insert";
				}
				else
				{
					hidaction="insert";
				}
				
				String temp=correctNull((String)hshValues.get("txtarea_documentmaster"));
				int templen=temp.length();
				
				if(hidaction.equalsIgnoreCase("insert"))
				{
					strQuery="sel_docid";
					rs=DBUtils.executeLAPSQuery(strQuery);
					if(rs.next())
					{
						strSno=Helper.correctNull((String)rs.getString("snorelmax"));
					}
					
					if(correctNull((String)hshValues.get("txtarea_documentmaster")).length()<32766)
					{
						hshQueryValues=new HashMap();
						hshQuery=new HashMap();
						arrValues=new ArrayList();	
						hshQuery.put("strQueryId","ins_dynamicdocumentmaster");
						
						arrValues.add(correctNull((String)hshValues.get("sel_docuname")));
						arrValues.add(strdocid);
						arrValues.add(strModuleType);
						arrValues.add(correctNull((String)hshValues.get("sel_doctype")));
						arrValues.add(correctNull((String)hshValues.get("txtarea_documentmaster")));
						arrValues.add(strSno);
						arrValues.add(strCreatedDate);
						arrValues.add(correctNull((String)hshValues.get("sel_dynamiccontent")));	
						arrValues.add(correctNull((String)hshValues.get("txt_jspname")));
						arrValues.add(correctNull((String)hshValues.get("sel_docsubtype")));
						arrValues.add(correctNull((String)hshValues.get("strUserId")));

						hshQuery.put("arrValues",arrValues );
						hshQueryValues.put("1",hshQuery);
						hshQueryValues.put("size", "1");
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
					else
					{
						
						if(con1!=null)
						{
							con1.close();
						}
					 	con1=CLOBInvoker.getOracleConnection();
						ps=con1.prepareStatement("insert into doc_dynamicmaster(doc_docuname,doc_id,doc_module,doc_doctype,doc_template,doc_sno,doc_createddate,doc_dynamiccontent,doc_jspname,DOC_DOCSUBTYPE,doc_modifieddate,doc_modifiedby)	values(?,?,?,?,?,?,to_date(?,'dd/mm/yyyy'),?,?,?,sysdate,?)");
						clob=CLOBInvoker.getCLOBInstance(con1);
						clob.putString(1,correctNull((String)hshValues.get("txtarea_documentmaster")));
						ps.setString(1,correctNull((String)hshValues.get("sel_docuname")));
						ps.setString(2,strdocid);
						ps.setString(3,strModuleType);
						ps.setString(4,correctNull((String)hshValues.get("sel_doctype")));
						ps.setClob(5,clob);
						ps.setString(6,strSno);
						ps.setString(7,strCreatedDate);	
						ps.setString(8,correctNull((String)hshValues.get("sel_dynamiccontent")));	
						ps.setString(9,correctNull((String)hshValues.get("txt_jspname")));
						ps.setString(10,correctNull((String)hshValues.get("sel_docsubtype")));
						ps.setString(11,correctNull((String)hshValues.get("strUserId")));
						ps.executeUpdate();
						
						
					}
				}
				else if(hidaction.equalsIgnoreCase("update"))
				{
					strSno=correctNull((String)hshValues.get("hidsno"));
					
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					arrValues.add(strdocid);
					arrValues.add(strSno);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","del_dynamicdocumentmaster");			
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size", "1");
					
					
					if(correctNull((String)hshValues.get("txtarea_documentmaster")).length()<32766)
					{
						hshQuery=new HashMap();
						arrValues=new ArrayList();	
						hshQuery.put("strQueryId","ins_dynamicdocumentmaster");
						
						arrValues.add(correctNull((String)hshValues.get("sel_docuname")));
						arrValues.add(strdocid);
						arrValues.add(strModuleType);
						arrValues.add(correctNull((String)hshValues.get("sel_doctype")));
						arrValues.add(correctNull((String)hshValues.get("txtarea_documentmaster")));
						arrValues.add(strSno);
						arrValues.add(strCreatedDate);
						arrValues.add(correctNull((String)hshValues.get("sel_dynamiccontent")));	
						arrValues.add(correctNull((String)hshValues.get("txt_jspname")));
						arrValues.add(correctNull((String)hshValues.get("sel_docsubtype")));
						arrValues.add(correctNull((String)hshValues.get("strUserId")));

						hshQuery.put("arrValues",arrValues );
						hshQueryValues.put("2",hshQuery);
						hshQueryValues.put("size", "2");
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
					else
					{
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						
						if(con1!=null)
						{
							con1.close();
						}
					 	con1=CLOBInvoker.getOracleConnection();
						ps=con1.prepareStatement("insert into doc_dynamicmaster(doc_docuname,doc_id,doc_module,doc_doctype,doc_template,doc_sno,doc_createddate,doc_dynamiccontent,doc_jspname,DOC_DOCSUBTYPE,doc_modifieddate,doc_modifiedby)	values(?,?,?,?,?,?,to_date(?,'dd/mm/yyyy'),?,?,?,sysdate,?)");
						clob=CLOBInvoker.getCLOBInstance(con1);
						clob.putString(1,correctNull((String)hshValues.get("txtarea_documentmaster")));
						ps.setString(1,correctNull((String)hshValues.get("sel_docuname")));
						ps.setString(2,strdocid);
						ps.setString(3,strModuleType);
						ps.setString(4,correctNull((String)hshValues.get("sel_doctype")));
						ps.setClob(5,clob);
						ps.setString(6,strSno);
						ps.setString(7,strCreatedDate);	
						ps.setString(8,correctNull((String)hshValues.get("sel_dynamiccontent")));	
						ps.setString(9,correctNull((String)hshValues.get("txt_jspname")));
						ps.setString(10,correctNull((String)hshValues.get("sel_docsubtype")));
						ps.setString(11,correctNull((String)hshValues.get("strUserId")));
						ps.executeUpdate();
						
						
					}
				}
			}
              
              if(hidaction.equalsIgnoreCase("delete")){
            	  
            	strdocid=correctNull((String)hshValues.get("txt_docuid"));
  				strSno=correctNull((String)hshValues.get("hidsno"));
  				
  				hshQueryValues = new HashMap();
  				hshQuery = new HashMap();
  				arrValues=new ArrayList();
  				arrValues.add(strdocid);
  				arrValues.add(strSno);
  				hshQuery.put("arrValues",arrValues);
  				hshQuery.put("strQueryId","del_dynamicdocumentmaster");			
  				hshQueryValues.put("1",hshQuery);
  				hshQueryValues.put("size", "1");			
  				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
  				
              }
		}
			
		
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
		}
		finally{
			try
			{
				if(con1!=null)
				{
					con1.close();
				}
				if(ps!=null)
				{
					ps.close();
				}
				if(clob!=null)
				{
					clob.close();
				}
			}catch (Exception e) {
				// TODO: handle exception
			}
		}
		
		hshValues.put("strdocid",strdocid);
		
		hshValues=getDocumentMaster(hshValues);
		
		return hshValues;
		
	}
    
    
    
    		
    public HashMap getDocumentMaster(HashMap hshValues){
		
		ResultSet rs=null;
		String strQuery="";
		HashMap hshRecord = null;
		String strdocid=Helper.correctNull((String)hshValues.get("strdocid"));
		String docname=Helper.correctNull((String)hshValues.get("sel_docuname"));
		String hidaction=Helper.correctNull((String)hshValues.get("hidAction"));
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		try{
			 hshRecord=new HashMap();
		
			if(hidaction.equalsIgnoreCase("insert")){
			strQuery=SQLParser.getSqlQuery("sel_dynamicdocumentmaster^"+strdocid);
     		rs=DBUtils.executeQuery(strQuery);
     		if(rs!=null){
			if(rs.next())
			{
				hshRecord.put("sel_docuname",Helper.correctNull(rs.getString("doc_docuname")));
				hshRecord.put("txt_docuid",Helper.correctNull(rs.getString("doc_id")));
				hshRecord.put("sel_module",Helper.correctNull(rs.getString("doc_module")));
				hshRecord.put("sel_doctype",Helper.correctNull(rs.getString("doc_doctype")));
				hshRecord.put("txtarea_documentmaster",correctNull(Helper.CLOBToString((rs.getClob("doc_template")))));
				hshRecord.put("sno",Helper.correctNull(rs.getString("doc_sno")));
				hshRecord.put("sel_dynamiccontent",Helper.correctNull(rs.getString("DOC_DYNAMICCONTENT")));
				hshRecord.put("txt_jspname",Helper.correctNull(rs.getString("DOC_jspname")));
				hshRecord.put("sel_docsubtype",Helper.correctNull(rs.getString("DOC_DOCSUBTYPE")));

		}
			}
     		
     		}
			
			if(hidaction.equalsIgnoreCase("")){
			    
				strQuery=SQLParser.getSqlQuery("sel_dynamicdocumentmaster_docname^"+docname);
				rs=DBUtils.executeQuery(strQuery);
				if(rs!=null){
				if(rs.next())
				{
					
					hshRecord.put("sel_docuname",Helper.correctNull(rs.getString("doc_docuname")));
					hshRecord.put("txt_docuid",Helper.correctNull(rs.getString("doc_id")));
					hshRecord.put("sel_module",Helper.correctNull(rs.getString("doc_module")));
					hshRecord.put("sel_doctype",Helper.correctNull(rs.getString("doc_doctype")));
					hshRecord.put("txtarea_documentmaster",correctNull(Helper.CLOBToString((rs.getClob("doc_template")))));
					hshRecord.put("sno",Helper.correctNull(rs.getString("doc_sno")));
					hshRecord.put("sel_dynamiccontent",Helper.correctNull(rs.getString("DOC_DYNAMICCONTENT")));
					hshRecord.put("txt_jspname",Helper.correctNull(rs.getString("DOC_jspname")));
					hshRecord.put("sel_docsubtype",Helper.correctNull(rs.getString("DOC_DOCSUBTYPE")));
			}
				else{
	     			strQuery=SQLParser.getSqlQuery("sel_docnamemaster^"+docname);
	         		rs=DBUtils.executeQuery(strQuery);
	         		if(rs.next()){
	         			hshRecord.put("sel_docuname",Helper.correctNull(rs.getString("STAT_DATA_DESC")));
	         		}
				
				}
		}
			}
		}
		catch(Exception e){
			throw new EJBException("Error in getDynamicDocumentMaster"+e.toString());
		}
		finally
		{
			try{
				if(rs!=null)
				{
					rs.close();
				}
			}
			catch(Exception ex)
			{
				throw new EJBException("Error in Closing the connection in getWorkFlowComments of CommWorkflowBean"+ ex.toString());
			}
		}
		return hshRecord;
	}
	
    
    /** Added by DINESH on 26/12/2013 for Security Values Details ***/
    
    public void updateSecurityValuesDetails (HashMap hshValues) 
    {
    	ResultSet rs = null;
		String strQuery=null;
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshRecord=new HashMap();
		ArrayList arrValues = new ArrayList();
		HashMap hshQueryValueslov=new HashMap();
		HashMap hshQuerylov = new HashMap();
		ArrayList arrVallov=new ArrayList();
		String hidSecurityId=Helper.correctNull((String)hshValues.get("hidSecurityId"));
		
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		int arrSize=Integer.parseInt((String)hshValues.get("hidsize"));

		try
		{
			String strAction = correctNull((String)hshValues.get("hidAction"));
			String Applicant = correctNull((String)hshValues.get("hid_applicant"));
			String strAppValue = correctNull((String)hshValues.get("sel_applicants"));
			String strApplicantOldid=correctNull((String)hshValues.get("hidapplicantid"));
			if(strApplicantOldid.equalsIgnoreCase(""))
				strApplicantOldid=correctNull((String)hshValues.get("hidBorrowerType"));
			int intLen=0;
			String[] SecID = new String[arrSize];
			String[] CustID = new String[arrSize];
			String[] SecValue = new String[arrSize];
			String[] ResiValue = new String[arrSize];
			String[] Facsno = new String[arrSize];
			String[] FacType = new String[arrSize];
			String[] Margin = new String[arrSize];
			String[] FacNature = new String[arrSize];
			String[] FacID = new String[arrSize];
			String[] SecType = new String[arrSize];
			String[] LoanAmt = new String[arrSize];
			String[] OutstandAmt = new String[arrSize];
			String[] Unsec = new String[arrSize];
			String[] LoanType=new String[arrSize];
			String[] IsCollateral=new String[arrSize];
			String[] str_type=new String[arrSize];
			String[] hidSecExisting=new String[arrSize];
			String[] strSelect=new String[arrSize];
			String[] strparentappno=new String[arrSize];
			String[] strparentsno=new String[arrSize];
			//String[] strBowID=new String[arrSize];
			String[] strSecuritytype=new String[arrSize];
			String[] strShareCnt=new String[arrSize];
			if(hshValues.get("hidSecID") instanceof String)
			{
				SecID[0] = (String) hshValues.get("hidSecID");
				SecValue[0] = (String) hshValues.get("hid_securityVal");
				ResiValue[0] = (String) hshValues.get("hid_residualVal");
				SecType[0] = (String) hshValues.get("sel_sectype");
				Facsno[0] = (String) hshValues.get("hidFacSno");
				FacType[0] = (String) hshValues.get("hidFacType");
				Margin[0] = (String) hshValues.get("hidSecMargin");
				FacNature[0] = (String) hshValues.get("hidFacNature");
				LoanAmt[0] = (String) hshValues.get("hidFacLimit");
				OutstandAmt[0] = (String) hshValues.get("hidFacOutstand");
				Unsec[0] = (String) hshValues.get("sel_sectype");
				CustID[0] = (String) hshValues.get("sel_sectype");
				FacID[0] = (String) hshValues.get("hidFacID");
				hidSecExisting[0] = (String) hshValues.get("hidSecExisting");
				strSelect[0] = (String) hshValues.get("hidSelect");
				strparentappno[0] = (String) hshValues.get("hid_parentappno");
				strparentsno[0] = (String) hshValues.get("hid_parentsno");
				LoanType[0] = (String) hshValues.get("sel_exisprop");
				IsCollateral[0] = (String)hshValues.get("hidCollFlag");
				str_type[0] = (String)hshValues.get("hidType");
				//strBowID[0] = (String)hshValues.get("hidBowID");
				strSecuritytype[0] = (String)hshValues.get("hidsecuritytype");
				strShareCnt[0] = (String)hshValues.get("hidsharecount");
			}else 
			{
				SecID = (String[]) hshValues.get("hidSecID");
				SecValue = (String[]) hshValues.get("hid_securityVal");
				ResiValue = (String[]) hshValues.get("hid_residualVal");
				SecType = (String[]) hshValues.get("sel_sectype");
				Facsno = (String[]) hshValues.get("hidFacSno");
				FacType = (String[]) hshValues.get("hidFacType");
				Margin = (String[]) hshValues.get("hidSecMargin");
				FacNature = (String[]) hshValues.get("hidFacNature");
				LoanAmt = (String[]) hshValues.get("hidFacLimit");
				OutstandAmt = (String[]) hshValues.get("hidFacOutstand");
				Unsec = (String[]) hshValues.get("sel_sectype");
				CustID = (String[]) hshValues.get("sel_sectype");
				FacID = (String[]) hshValues.get("hidFacID");
				hidSecExisting = (String[]) hshValues.get("hidSecExisting");
				strSelect = (String[]) hshValues.get("hidSelect");
				strparentappno = (String[]) hshValues.get("hid_parentappno");
				strparentsno = (String[]) hshValues.get("hid_parentsno");
				LoanType = (String[]) hshValues.get("sel_exisprop");
				IsCollateral = (String[])hshValues.get("hidCollFlag");
				str_type = (String[])hshValues.get("hidType");
				//strBowID = (String[])hshValues.get("hidBowID");
				strSecuritytype = (String[])hshValues.get("hidsecuritytype");
				strShareCnt = (String[])hshValues.get("hidsharecount");
			}
			
			strQuery = SQLParser.getSqlQuery("selcustomerdetails^"+Applicant);
    		rs = DBUtils.executeQuery(strQuery);
    		if(rs.next())
    		{
    			Applicant = Helper.correctNull((String) rs.getString("perapp_oldid"));
    		}
			
    		if(strAction.equalsIgnoreCase("update"))
			{
    			for (int i = 0 ; i < arrSize; i++)
				{ 
					hshQueryValues = new HashMap();
					int intQsize=0;
					String strFacsno=Facsno[i];
					String strFacsnoArr[]=strFacsno.split("~");
					String strMargin=Margin[i];
					String strMarginArr[]=strMargin.split("~");
					String strFacType=FacType[i];
					String strFacTypeArr[]=strFacType.split("~");
					String strFacNature=FacNature[i];
					String strFacNatureArr[]=strFacNature.split("~");
					String strFacID=FacID[i];
					String strFacIDArr[]=strFacID.split("~");
					String strLoanamt=LoanAmt[i];
					String strLoanamtArr[]=strLoanamt.split("~");
					String strOS=OutstandAmt[i];
					String strOSArr[]=strOS.split("~");
					String strtype=str_type[i];
					String strTypeArr[]=strtype.split("~");
					String strType=SecType[i];
					String strsecType[]=strType.split("~");
					String strParentAppno=strparentappno[i];
					String strParentappnoarr[]=strParentAppno.split("~");
					String strParentSno=strparentsno[i];
					String strParentsnoarr[]=strParentSno.split("~");
					String strUnsecSno=Unsec[i];
					String strUnsecsnoarr[]=strUnsecSno.split("~");
					//String strborrowerid=strBowID[i];
					//String strborrowerArr[]=strborrowerid.split("~");
					String strSecurtype=strSecuritytype[i];
					String strSecuritytypeArr[]=strSecurtype.split("~");
					
					if(strSelect[i].equalsIgnoreCase("Y"))
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						arrValues.add("P");
						arrValues.add(SecID[i]);
						arrValues.add(strAppno);
						intQsize=intQsize+1;
						hshQuery.put("strQueryId","delsecuritydetails_fac");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(String.valueOf(intQsize),hshQuery);
						
						for(int k=0;k<strFacIDArr.length;k++)
						{
							if(strTypeArr[k].equalsIgnoreCase("P"))
							{
								hshQuery = new HashMap();
								arrValues = new ArrayList();
								arrValues.add(strAppno);
								arrValues.add(SecID[i]);
								arrValues.add(strFacsnoArr[k]);
								arrValues.add(Applicant);
								arrValues.add(SecValue[i]);
								arrValues.add(ResiValue[i]);
								arrValues.add(strFacTypeArr[k]);
								arrValues.add(strFacNatureArr[k]);
								arrValues.add(strsecType[k]);
								arrValues.add(strLoanamtArr[k]);//doubt
								arrValues.add(strOSArr[k]);
								arrValues.add(strUnsecsnoarr[k]);
								arrValues.add(Applicant);
								arrValues.add(Helper.correctDouble(strMarginArr[k]));
								arrValues.add(strFacIDArr[k]);
								arrValues.add(strTypeArr[k]);
								arrValues.add(IsCollateral[i]);
								arrValues.add(hidSecExisting[i]);
								arrValues.add("A");
								arrValues.add("Y");
								arrValues.add("");
								arrValues.add(strApplicantOldid);
								arrValues.add(strSecuritytypeArr[k]);
								arrValues.add(strShareCnt[i]);
								if(rs!=null)
									rs.close();
								strQuery = SQLParser.getSqlQuery("sel_facility_mclrreldate^"+strAppno+"^"+strFacsnoArr[k]);
					    		rs = DBUtils.executeQuery(strQuery);
					    		if(rs.next())
					    		{
					    			if(Helper.correctNull(rs.getString("facility_group")).equalsIgnoreCase("0"))
					    				arrValues.add("M");
					    			else
					    				arrValues.add("S");
					    		}
					    		else
					    		{
					    			arrValues.add("");
					    		}
								// Inserting Parent Application number and Parent facility sno for existing facilities alone
								hshQuery.put("strQueryId","ins_securitydetails");
								intQsize=intQsize+1;
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put(String.valueOf(intQsize),hshQuery);
							}
						}
						hshQueryValues.put("size",String.valueOf(intQsize));				
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
					else if(strSelect[i].equalsIgnoreCase("N"))
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						arrValues.add("P");
						arrValues.add(SecID[i]);
						arrValues.add(strAppno);
						intQsize=intQsize+1;
						hshQuery.put("strQueryId","delsecuritydetails_fac");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(String.valueOf(intQsize),hshQuery);
						
						arrValues = new ArrayList();
						hshQuery = new HashMap();					
						hshQuery.put("strQueryId","del_sec_MDTDcomments");
						arrValues.add(strAppno);
						arrValues.add(SecID[i]);
						intQsize=intQsize+1;
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(String.valueOf(intQsize),hshQuery);
						
						hshQueryValues.put("size",String.valueOf(intQsize));				
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
				}
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_securitydetails");
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
					
				arrValues=new ArrayList();
				hshQuery = new HashMap();					
				hshQuery.put("strQueryId","del_sec_MDTDcomments_all");
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);
				hshQueryValues.put("size","2");
				
				arrValues=new ArrayList();
				hshQuery = new HashMap();					
				hshQuery.put("strQueryId","dellopverif");
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("3",hshQuery);
				hshQueryValues.put("size","3");
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
    		
    		hshQueryValues=new HashMap();
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQueryValues.put("size","1");
			hshQuery.put("strQueryId", "upd_sec_desc_pending");
			arrValues.add(strAppno);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			hshQueryValues=new HashMap();
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			arrValues.add(strAppno);
			hshQuery.put("strQueryId","sel_misdupdateflag"); 
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			if(rs!=null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("legal_opinion_verificationforExist^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshQueryValueslov = new HashMap();
				hshQuerylov = new HashMap();
				arrVallov=new ArrayList();
				hshQueryValueslov.put("size","1");
				hshQuerylov.put("strQueryId","dellopverifforExist");
				arrVallov.add(strAppno);
				arrVallov.add(Helper.correctNull((String)rs.getString("SEC_ID")));
				hshQuerylov.put("arrValues",arrVallov);
				hshQueryValueslov.put("1",hshQuerylov);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValueslov,"updateData");
			}
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in updateSecurityValuesDetails "+ce.toString());
		}
		finally
		{
			try
			{
			if(rs!=null)
			{
				rs.close();
			}
			}
			catch(Exception ce)
			{
				throw new EJBException("Error in Connection : "+ce.toString());
			}
		}
    }
    
    
    
    public HashMap getAttachedSecurityDetails(HashMap hshValues) 
    {
    	java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
    	HashMap hshResult=new HashMap();
    	ResultSet rs=null;
    	ResultSet rs1=null;
    	ResultSet rs2=null;
    	ResultSet rs3=null;
    	ResultSet rs4=null,rs5=null;
    	String strQuery="",strQuery1="",strQuery2="",strQuery3="";
    	String strAppno="",newLapsId="",oldLapsId="",strappId="";
    	String strName="",str_facsno="";
    	ArrayList arrCol=new ArrayList();
    	ArrayList arrRow=new ArrayList();
    	ArrayList arrFacCol=new ArrayList();
    	ArrayList arrFacRow=new ArrayList();
    	ArrayList arrMainRow=new ArrayList();
    	String strSecid="",strPrioirycheck="",strFac="";
    	int i=0,j=0,Prioitycount=0,totalcount=0;
    	String strSecurityCustomerId="",strSecurityType="";
    	String strSecownerId="0",strSecownername="",strcolSec="",strattachavail="N";
    	double  SecurityValue=0.00;
    	try
    	{
    		strappId = Helper.correctNull((String)hshValues.get("hidapplicantid"));
    		strAppno=Helper.correctNull((String)hshValues.get("appno"));
    		if(rs2 !=null){
    			rs2.close();
    		}
    		strQuery2 = SQLParser.getSqlQuery("sel_securityvalues_primary^APP_SEC_FACSNO^"+strAppno+"^P");
    		rs2 = DBUtils.executeQuery(strQuery2);
    		while(rs2.next())
    		{
    			int k=1;
    			i++;j++;
    			arrRow = new ArrayList();
    			strQuery = SQLParser.getSqlQuery("select_securityid_primary^" + strAppno+"^APP_SEC_FACSNO ='"+Helper.correctNull((String) rs2.getString("APP_SEC_FACSNO"))+"'"+"^P");
				rs3 = DBUtils.executeQuery(strQuery);
				while(rs3.next())
				{	
					totalcount++;
						strQuery = SQLParser.getSqlQuery("select_facilityproposed^" + strAppno+"^"+Helper.correctNull((String) rs2.getString("APP_SEC_FACSNO")));
						 rs1 = DBUtils.executeQuery(strQuery);
						while(rs1.next())
						{
							strQuery = SQLParser.getSqlQuery("selectFacilityHeadFacandSubFac_facilitycorp^" + Helper.correctNull((String)rs1.getString("facility_code")));
							rs = DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								strFac=Helper.correctNull((String)rs.getString("com_facdesc"));
							}
						}
						String FACILITY_WHT_CGTMSEAPPLY="";
						strQuery1=SQLParser.getSqlQuery("sel_proposedLimit^"+strAppno+"^"+Helper.correctNull((String) rs2.getString("APP_SEC_FACSNO")));
						rs1 = DBUtils.executeQuery(strQuery1);
						while(rs1.next())
						{
							FACILITY_WHT_CGTMSEAPPLY=Helper.correctNull(rs1.getString("FACILITY_WHT_CGTMSEAPPLY"));
						}
						
					arrCol = new ArrayList();
					strSecurityType=Helper.correctNull((String)rs3.getString("app_sec_securitytype"));
					if(strSecurityType.equalsIgnoreCase("1"))
					{
						strSecurityType="Primary";
					}
					else if(strSecurityType.equalsIgnoreCase("2"))
					{
						if(FACILITY_WHT_CGTMSEAPPLY.equals("Y"))
						{
							strattachavail="Y";
						}
						strSecurityType="Collateral";
					}
					else
					{
						strSecurityType=" ";
					}
					strSecid=Helper.correctNull((String)rs3.getString("app_sec_secid"));
					arrCol.add(Helper.correctNull((String)rs3.getString("app_sec_secid")));//0
					if(!Helper.correctNull((String)rs3.getString("app_sec_margin")).equalsIgnoreCase("")){
					arrCol.add(Helper.correctNull((String)rs3.getString("app_sec_margin")));//1
					}else{
						arrCol.add("0.00");	
					}
					SecurityValue=0.00;
					strQuery = SQLParser.getSqlQuery("select_security_calssification^" + Helper.correctInt((String)rs3.getString("app_sec_secid")));
					rs4 = DBUtils.executeQuery(strQuery);
					if(rs4.next())
					{
						arrCol.add(Helper.correctNull((String)rs4.getString("SEC_NAME")));//2
						arrCol.add(Helper.correctNull((String)rs4.getString("SEC_CLASSIFICATION")));//3
						//SecurityValue=Double.parseDouble(Helper.correctDouble((String)rs4.getString("CUS_SEC_NETSECURITY")));
					}else{
						arrCol.add("");//2
						arrCol.add("");//3
					}
					arrCol.add(Helper.correctNull((String) rs2.getString("APP_SEC_FACSNO")));//4
					if(!Helper.correctNull((String) rs3.getString("app_sec_priority")).equalsIgnoreCase("") && !Helper.correctNull((String) rs3.getString("app_sec_priority")).equalsIgnoreCase("null"))
					{
						if(!(Helper.correctNull((String) rs3.getString("app_sec_priority")).equalsIgnoreCase("0")))
						{
							Prioitycount++;
							if(strPrioirycheck.equalsIgnoreCase(""))
							{
								strPrioirycheck=str_facsno+"@"+Helper.correctNull((String) rs3.getString("app_sec_priority"));	
							}else
							{
								strPrioirycheck=strPrioirycheck+"-"+str_facsno+"@"+Helper.correctNull((String) rs3.getString("app_sec_priority"));
							}
						}
						arrCol.add(Helper.correctNull((String) rs3.getString("app_sec_priority")));//5
					}else{
						arrCol.add("0");
					}
					
					strQuery = SQLParser.getSqlQuery("securities_owner_sel^" + Helper.correctInt((String)rs3.getString("app_sec_secid")));
					rs4 = DBUtils.executeQuery(strQuery);
					if(rs4.next())
					{
						strSecownerId=Helper.correctInt((String)rs4.getString("cus_owner_laps_id"));
					}
					if(rs4 !=null)
					{rs4.close();}
					strQuery = SQLParser.getSqlQuery("select_latestappid^" + strSecownerId);
					rs4 = DBUtils.executeQuery(strQuery);
					if(rs4.next())
					{
						strSecownername=Helper.correctInt((String)rs4.getString("perapp_fname"));
					}
					arrCol.add(strFac);//6
					arrCol.add(strSecurityType);//7
					// for removal of collateral sec when CGTMSE is NO
					if(rs4 !=null)
					{rs4.close();}
					strQuery = SQLParser.getSqlQuery("sel_facility_details^"+strAppno+"^"+Helper.correctNull((String) rs2.getString("APP_SEC_FACSNO")));
					rs4 = DBUtils.executeQuery(strQuery);
					if(rs4.next())
					{
						if(Helper.correctNull((String)rs4.getString("FACILITY_WHT_CGTMSEAPPLY")).equalsIgnoreCase("Y")
								&& Helper.correctNull((String)rs3.getString("APP_SEC_SECURITYTYPE")).equalsIgnoreCase("2"))
						{
							strcolSec+=","+strSecid;
						}
					}
					arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs3.getString("APP_SEC_SECURITYVALUE")))));//8
					arrCol.add(strSecownername);//9
					
					if(rs5 !=null)
		    			rs5.close();
					//current security value
					strQuery = SQLParser.getSqlQuery("select_sec_totalsecValue^" + Helper.correctInt((String)rs3.getString("app_sec_secid")));
					rs5 = DBUtils.executeQuery(strQuery);
					if(rs5.next())
					{
						String CUS_RELEASEFLAG= Helper.correctNull((String)rs5.getString("CUS_RELEASEFLAG"));
						if(CUS_RELEASEFLAG.equals("V"))
						{
							if(rs4 !=null)
				    			rs4.close();
							strQuery = SQLParser.getSqlQuery("sel_secVerMailbox_secval^" + Helper.correctInt((String)rs3.getString("app_sec_secid")));
							rs4 = DBUtils.executeQuery(strQuery);
							if(rs4.next())
							{
								if(Helper.correctNull((String)rs4.getString("SEC_SECURITYVALUE_OLD")).equalsIgnoreCase(""))
									arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs5.getString("CUS_SEC_NETSECURITY")))));
								else
									arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs4.getString("SEC_SECURITYVALUE_OLD")))));
							}
						}
						else
						{
							arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs5.getString("CUS_SEC_NETSECURITY")))));
						}
					}
					else
						arrCol.add("0.00");//10
					
					
					arrRow.add(arrCol);
				}					
				
				hshResult.put("arrRow1"+j,arrRow);
				System.out.println("First===="+j+"-"+arrRow);
    		}
    		hshResult.put("count1",""+j);
    		//
    		j=0;
    		String strProductno="0",strParentFacSno="",strProductcode="0",strParentappno="",strModtype="";
    		String strProductCodeSno[]=new String[2];
    		strQuery2 = SQLParser.getSqlQuery("sel_securityvalues_primary^app_sec_parent_facsno^"+strAppno+"^E");
    		rs2 = DBUtils.executeQuery(strQuery2);
    		while(rs2.next())
    		{
    			int k=1;
    			i++;j++;	
    			arrRow = new ArrayList();
    			strProductno=Helper.correctInt((String)rs2.getString(1));
    			strQuery = SQLParser.getSqlQuery("select_securityid_primary^" + strAppno+"^APP_SEC_PARENT_FACSNO ='"+Helper.correctNull((String) rs2.getString("APP_SEC_FACSNO"))+"'"+"^E");
				rs3 = DBUtils.executeQuery(strQuery);
				while(rs3.next())
				{	
					strParentFacSno="0";
					totalcount++;
						/* strQuery = SQLParser.getSqlQuery("select_facilityproposed^" + strAppno+"^"+Helper.correctNull((String) rs2.getString("APP_SEC_FACSNO")));
						rs1 = DBUtils.executeQuery(strQuery);
						while(rs1.next())
						{
							arrFacCol = new ArrayList();
							strQuery = SQLParser.getSqlQuery("selectFacilityHeadFacandSubFac_facilitycorp^" + Helper.correctNull((String)rs1.getString("facility_code")));
							
							rs = DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								arrFacCol.add(Helper.correctNull((String)rs.getString("com_facdesc")));//0
								strFac=Helper.correctNull((String)rs.getString("com_facdesc"));
							}
							if(!str_facsno.equalsIgnoreCase(Helper.correctNull((String) rs2.getString("APP_SEC_FACSNO"))))
							{
							arrRow.add(arrFacCol);//0
							str_facsno=Helper.correctNull((String) rs2.getString("APP_SEC_FACSNO"));
							}
						}
					arrCol = new ArrayList();
					strQuery = SQLParser.getSqlQuery("select_securityid_primary^" + strAppno+"^APP_SEC_PArent_FACSNO ='"+strProductno+"'"+"^E");
					rs5 = DBUtils.executeQuery(strQuery);
					if(rs5.next())
					{
						if(Helper.correctNull((String) rs5.getString("APP_SEC_SECURITYTYPE")).equalsIgnoreCase("2"))
						{
						arrFacCol.add("Collateral");
						if(!str_facsno.equalsIgnoreCase(strProductno))
						{
							arrRow.add(arrFacCol);
							str_facsno=strProductno;
						}
						}
						else
						{arrFacCol.add("Primary");
						}
					}
					*/
					arrCol = new ArrayList();
					strSecurityType=Helper.correctNull((String)rs3.getString("app_sec_securitytype"));
					if(strSecurityType.equalsIgnoreCase("1"))
					{
						strSecurityType="Primary";
					}
					else if(strSecurityType.equalsIgnoreCase("2"))
					{
						strSecurityType="Collateral";
						//strattachavail="Y";
					}
					else
					{
						strSecurityType="";
					}
					strSecid=Helper.correctNull((String)rs3.getString("app_sec_secid"));
					arrCol.add(Helper.correctNull((String)rs3.getString("app_sec_secid")));//0
					if(!Helper.correctNull((String)rs3.getString("app_sec_margin")).equalsIgnoreCase("")){
					arrCol.add(Helper.correctNull((String)rs3.getString("app_sec_margin")));//1
					}else{
						arrCol.add("0.00");	
					}
					SecurityValue=0.00;
					strQuery = SQLParser.getSqlQuery("select_security_calssification^" + Helper.correctInt((String)rs3.getString("app_sec_secid")));
					rs4 = DBUtils.executeQuery(strQuery);
					if(rs4.next())
					{
						arrCol.add(Helper.correctNull((String)rs4.getString("SEC_NAME")));//2
						arrCol.add(Helper.correctNull((String)rs4.getString("SEC_CLASSIFICATION")));//3
						SecurityValue=Double.parseDouble(Helper.correctDouble((String)rs4.getString("CUS_SEC_NETSECURITY")));
					}else{
						arrCol.add("");//2
						arrCol.add("");//3
					}
					arrCol.add(Helper.correctNull((String) rs2.getString("APP_SEC_FACSNO")));//4
					if(!Helper.correctNull((String) rs3.getString("app_sec_priority")).equalsIgnoreCase("") && !Helper.correctNull((String) rs3.getString("app_sec_priority")).equalsIgnoreCase("null"))
					{
						if(!(Helper.correctNull((String) rs3.getString("app_sec_priority")).equalsIgnoreCase("0")))
						{
							Prioitycount++;
							if(strPrioirycheck.equalsIgnoreCase(""))
							{
								strPrioirycheck=str_facsno+"@"+Helper.correctNull((String) rs3.getString("app_sec_priority"));	
							}else
							{
								strPrioirycheck=strPrioirycheck+"-"+str_facsno+"@"+Helper.correctNull((String) rs3.getString("app_sec_priority"));
							}
						}
						arrCol.add(Helper.correctNull((String) rs3.getString("app_sec_priority")));//5
					}else{
						arrCol.add("0");
					}
					if(strParentFacSno.equalsIgnoreCase("0"))
					{
						strSecurityCustomerId=Helper.correctNull((String)rs3.getString("app_sec_borrower_id"));
						strParentFacSno=Helper.correctNull((String)rs3.getString("app_sec_parent_facsno"));
						strParentappno=Helper.correctNull((String)rs3.getString("app_sec_parentappno"));
						strFac="";strProductcode="0";strModtype="";					
						if(strappId.equalsIgnoreCase(strSecurityCustomerId))
						{
							strQuery = SQLParser.getSqlQuery("sel_bankingfaccode^"+strAppno+"^"+strParentFacSno+"^"+strParentappno);
							rs4 = DBUtils.executeQuery(strQuery);
							if(rs4.next())
							{
								strProductcode=Helper.correctNull((String)rs4.getString("combk_facility"));
								strModtype=Helper.correctNull((String)rs4.getString("combk_modtype"));
								strProductCodeSno=strProductcode.split("~");
								strProductcode=strProductCodeSno[0];
							}
						}
						else
						{
							strQuery = SQLParser.getSqlQuery("sel_groupfaccode^"+strAppno+"^"+strParentFacSno+"^"+strParentappno);		
							rs4 = DBUtils.executeQuery(strQuery);
							if(rs4.next())
							{
								strProductcode=Helper.correctNull((String)rs4.getString("comgc_facility"));
								strModtype=Helper.correctNull((String)rs4.getString("comgc_modtype"));
							}
						}
						if(rs4 !=null)
						{
							rs4.close();
						}
						
						if(strModtype.equalsIgnoreCase("a") || strModtype.equalsIgnoreCase("c"))
						{
							strQuery = SQLParser.getSqlQuery("selectFacilityHeadFacandSubFac_facilitycorp^" + strProductcode);
							rs4 = DBUtils.executeQuery(strQuery);
							if(rs4.next())
							{
								strFac=Helper.correctNull((String)rs4.getString("com_facdesc"));
							}
						}
						else
						{
							strQuery=SQLParser.getSqlQuery("sel_retProductDesc^"+strProductcode);
    						rs4 = DBUtils.executeQuery(strQuery);
    						if(rs4.next())
    						{
    							strFac=Helper.correctNull(rs4.getString("com_facdesc"));
    						}
						}
						if(rs4 !=null)
						{
							rs4.close();
						}
					}
					strQuery = SQLParser.getSqlQuery("securities_owner_sel^" + Helper.correctInt((String)rs3.getString("app_sec_secid")));
					rs4 = DBUtils.executeQuery(strQuery);
					if(rs4.next())
					{
						strSecownerId=Helper.correctInt((String)rs4.getString("cus_owner_laps_id"));
					}
					if(rs4 !=null)
					{rs4.close();}
					strQuery = SQLParser.getSqlQuery("select_latestappid^" + strSecownerId);
					rs4 = DBUtils.executeQuery(strQuery);
					if(rs4.next())
					{
						strSecownername=Helper.correctInt((String)rs4.getString("perapp_fname"));
					}
					arrCol.add(strFac);//6
					arrCol.add(strSecurityType);//7
					
					arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs3.getString("APP_SEC_SECURITYVALUE")))));//8
					arrCol.add(strSecownername);//9
					if(rs5 !=null)
		    			rs5.close();
					//current security value
					strQuery = SQLParser.getSqlQuery("select_sec_totalsecValue^" + Helper.correctInt((String)rs3.getString("app_sec_secid")));
					rs5 = DBUtils.executeQuery(strQuery);
					if(rs5.next())
					{
						String CUS_RELEASEFLAG= Helper.correctNull((String)rs5.getString("CUS_RELEASEFLAG"));
						if(CUS_RELEASEFLAG.equals("V"))
						{
							if(rs4 !=null)
				    			rs4.close();
							strQuery = SQLParser.getSqlQuery("sel_secVerMailbox_secval^" + Helper.correctInt((String)rs3.getString("app_sec_secid")));
							rs4 = DBUtils.executeQuery(strQuery);
							if(rs4.next())
							{
								if(Helper.correctNull((String)rs4.getString("SEC_SECURITYVALUE_OLD")).equalsIgnoreCase(""))
									arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs5.getString("CUS_SEC_NETSECURITY")))));
								else
									arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs4.getString("SEC_SECURITYVALUE_OLD")))));
							}
						}
						else
						{
							arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs5.getString("CUS_SEC_NETSECURITY")))));
						}
					}
					else
						arrCol.add("0.00");//10
					
					arrRow.add(arrCol);
				}					
				
				hshResult.put("arrRow2"+j,arrRow);
				System.out.println("Second===="+j+"-"+arrRow);
    		}
    		hshResult.put("strcolSec",strcolSec.replaceFirst(",", ""));
    		//for checking freeze count
    		int strFreezecount=0;
    		String strFreezeflag="N",strPrioityflag="N";
    		strQuery = SQLParser.getSqlQuery("sel_freezecount^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{	
				strFreezecount=Integer.parseInt(Helper.correctInt((String)rs.getString("freezecount")));
				if(strFreezecount!=0 )
				{
					strFreezeflag="Y";
				}
			}
			if( Helper.correctNull((String)hshValues.get("hidAction")).equalsIgnoreCase("undo"))
			{
				strFreezeflag="N";
			}
    		hshResult.put("count2",""+j);
    		hshResult.put("strFreezeflag",strFreezeflag);
    		hshResult.put("strPrioirycheck",strPrioirycheck);
    		hshResult.put("strPrioityflag",strPrioityflag);
    		hshResult.put("arrFacRow",arrFacRow);
    		hshResult.put("strAppno",strAppno);
    		
    		if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("sel_applications_freeze_flag^"+strAppno);
    		rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshResult.put("strPromotorFreezeflag",Helper.correctNull((String)rs.getString("app_freeze_flag")));
			}
			
			//To select the post sanction parameters
			String strTemp=" ",strParameters="";
			String strQueryPS = SQLParser.getSqlQuery("sel_PS_oldaccnum^"+strAppno+"^"+strTemp);
			ResultSet rsPS = DBUtils.executeQuery(strQueryPS);
			while(rsPS.next())
			{
				strParameters=strParameters+Helper.correctNull(rsPS.getString("PS_MODIFY_TERMS"));
			}
			hshResult.put("strPostSancParam",strParameters);
			
			//Security check for Loan against share facility
			String strFacdesc="";
			if(rs!=null) rs.close();
    		rs = DBUtils.executeLAPSQuery("sel_CORPLASFAC^"+strAppno);
			while (rs.next()) 
			{
				if(Helper.correctNull(rs.getString("com_loanagainstshares")).equalsIgnoreCase("Y"))
				{
					if(rs4 !=null)
					{rs4.close();}
					strQuery = SQLParser.getSqlQuery("sel_loanagainstsharesec^" + strAppno+"^"+Helper.correctNull(rs.getString("facility_sno")));
					rs4 = DBUtils.executeQuery(strQuery);
					if(!rs4.next())
					{
						if(strFacdesc.equalsIgnoreCase(""))
						{
							strFacdesc=Helper.correctNull(rs.getString("fac_desc"));
						}
						else
						{
							strFacdesc=strFacdesc+","+Helper.correctNull(rs.getString("fac_desc"));
						}
					}
				}
			}
			
			if(!strFacdesc.equalsIgnoreCase(""))
				hshResult.put("strLASCHK",strFacdesc);
			
			String strBorrID="",strID="";
			if(rs!=null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("sel_unknownsec^"+strAppno);
			while (rs.next()) 
			{
				if(!Helper.correctNull(rs.getString("app_sec_customerid")).equalsIgnoreCase(strappId))
				{
					if(!strID.contains(Helper.correctNull(rs.getString("cbsid"))))
					{
						if(strBorrID.equalsIgnoreCase(""))
						{
							strID=Helper.correctNull(rs.getString("cbsid"));
							strBorrID=Helper.correctNull(rs.getString("cbsid"))+" - "+Helper.correctNull(rs.getString("name"));
						}
						else
						{
							strID+=","+Helper.correctNull(rs.getString("cbsid"));
							strBorrID+=","+Helper.correctNull(rs.getString("cbsid"))+" - "+Helper.correctNull(rs.getString("name"));
						}
					}
				}
			}
			
			hshResult.put("strBorrID",strBorrID);
			
			String strReleasedSec="",strSecVerification="",strSecValuation="";
			if(rs!=null)
				rs.close();
			strQuery=SQLParser.getSqlQuery("sel_releasedsec^"+strAppno+"^Y");
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) 
			{
				if(strReleasedSec.equalsIgnoreCase(""))
					strReleasedSec=Helper.correctNull(rs.getString("cus_sec_id"));
				else
					strReleasedSec+=","+Helper.correctNull(rs.getString("cus_sec_id"));
			}
			if(rs!=null)
				rs.close();
			strQuery=SQLParser.getSqlQuery("sel_releasedsec^"+strAppno+"^W");
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) 
			{
				if(strSecVerification.equalsIgnoreCase(""))
					strSecVerification=Helper.correctNull(rs.getString("cus_sec_id"));
				else
					strSecVerification+=","+Helper.correctNull(rs.getString("cus_sec_id"));
			}
			if(rs!=null)
				rs.close();
			strQuery=SQLParser.getSqlQuery("sel_releasedsec^"+strAppno+"^V");
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) 
			{
				if(strSecValuation.equalsIgnoreCase(""))
					strSecValuation=Helper.correctNull(rs.getString("cus_sec_id"));
				else
					strSecValuation+=","+Helper.correctNull(rs.getString("cus_sec_id"));
			}
			if(rs!=null)
				rs.close();
			hshResult.put("strSecValuation",strSecValuation);
			hshResult.put("strSecVerification",strSecVerification);
			hshResult.put("strReleasedSec",strReleasedSec);
			
			/*String strcgtmseavail="N";
			strQuery1=SQLParser.getSqlQuery("sel_facility_details_CGTMSE^"+strAppno);
			rs = DBUtils.executeQuery(strQuery1);
			while(rs.next())
			{
				if(Helper.correctNull(rs.getString("FACILITY_WHT_CGTMSEAPPLY")).equalsIgnoreCase("Y") && strattachavail.equalsIgnoreCase("Y"))
				{
					strcgtmseavail="Y";
					break;
				}
			}*/
			if(rs!=null)
				rs.close();
			
			String strcgtmsecoapp="N";
			strQuery1=SQLParser.getSqlQuery("sel_compname_coapp^"+strAppno);
			rs = DBUtils.executeQuery(strQuery1);
			while(rs.next())
			{
				strcgtmsecoapp="Y"	;
			
			}
			if(rs!=null)
				rs.close();
			hshResult.put("strcgtmseavail",strattachavail);		
			hshResult.put("strcgtmsecoapp",strcgtmsecoapp);			

    	}
    	catch(Exception e)
		{
			throw new EJBException("Error in getAttachedSecurityDetails "+e.toString());
		} 
    	finally{
    		try{
    			if(rs !=null){
    				rs.close();
    			}
    			if(rs1 !=null){
        			rs1.close();
        		}
    			
    			if(rs2 !=null){
        			rs2.close();
        		}
    			if(rs3 !=null){
        			rs3.close();
        		}
    			if(rs4 !=null){
        			rs4.close();
        		}if(rs5 !=null){
        			rs5.close();
        		}
    			
    		}catch (Exception e){
    			throw new EJBException("Error in getAttachedSecurityDetails "+e.toString());
    		}
    	}
    	return hshResult;
    }
    public void updateSecurityCoverage(HashMap hshValues)
    {
    	try
    	{
    		
    	}
    	catch(Exception e)
    	{
    		throw new EJBException("Error in calculating Security Coverage"+e.toString());
    	}
    }
    
    
    
    /** Added by Venkata Prasad Mullamuri on 07/01/2014 for Attached Security Values Details ***/
    
    public void updateAttachedSecurityDetails(HashMap hshValues) 
    {
    	ResultSet rs = null;
		String strQuery=null;
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshRecord=new HashMap();
		ArrayList arrValues = new ArrayList();
		String hidSecurityId=Helper.correctNull((String)hshValues.get("hidSecurityId"));
		
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		int arrSize=Integer.parseInt(Helper.correctInt((String)hshValues.get("hidsize_priority")));
		try
		{
			String[] SecID = new String [arrSize];
			String[] Facsno = new String [arrSize];		
			String[] strPriority=new String [arrSize];		
			String strAction = correctNull((String)hshValues.get("hidAction"));
			String Applicant = correctNull((String)hshValues.get("hid_applicant"));
			int intLen=0,intQsize=0;
			if(arrSize>1)
			{
				strPriority = (String[])hshValues.get("sel_priority");
				SecID = (String[]) hshValues.get("hidSecID");					
				Facsno = (String[]) hshValues.get("hidFacSno");		
			}
			else if(arrSize==1)
			{
			strPriority [0]= (String)hshValues.get("sel_priority");
			SecID [0]= (String) hshValues.get("hidSecID");					
			Facsno[0] = (String) hshValues.get("hidFacSno");		
			}
			if(strAction.equalsIgnoreCase("update"))
			{					
					for(int k=0;k<strPriority.length;k++)
					{
						
						hshQuery = new HashMap();
						arrValues = new ArrayList();					
						arrValues.add(strPriority[k]);
						arrValues.add(strAppno);
						arrValues.add(SecID[k]);
						arrValues.add(Facsno[k]);	
						intQsize=intQsize+1;
						hshQuery.put("strQueryId","update_securitydetails");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(String.valueOf(intQsize),hshQuery);		
					}
			
					hshQueryValues.put("size",String.valueOf(intQsize));				
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				if(strAction.equalsIgnoreCase("undo"))
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();					
					arrValues.add("");
					arrValues.add("");
					arrValues.add(strAppno);
					intQsize=intQsize+1;
					hshQuery.put("strQueryId","upd_priorityundo");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(String.valueOf(intQsize),hshQuery);	
					hshQueryValues.put("size",String.valueOf(intQsize));
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in updateSecurityValuesDetails "+ce.toString());
		}
    }
    public HashMap getCollateralSecurityDisplay(HashMap hshValues) 
    {
    	HashMap hshRecord=  new HashMap();
    	ResultSet rs = null,rs1=null,rs2=null;
    	String strQuery="",strAppno="",str_sec_id="",strAction="",strApplicantid="",strQuery1="",strGrpconcernid="",strQuery2="";
    	double dbl_exifundostot=0,dbl_exinonfundostot=0,dbl_propfundostot=0,dbl_propnonfundostot=0,
    	dbl_secexitot=0,dbl_secproptot=0,dbl_secpropcoverage=0,dbl_secexicoverage=0,dbl_grpexifundostot=0,dbl_grpexinonfundostot=0,dbl_GrpExpExiSubtotal=0,
    	dbl_grpExpPropSubtotal=0,dbl_grpsecpropSubtot=0,dbl_grpsecexiSubtot=0,dbl_GrpExpExitotal=0,dbl_secexiSubtot=0,dbl_secpropSubtot=0;
    	ArrayList arrcol=new ArrayList();
    	ArrayList arrRow=new ArrayList();
    	ArrayList arrGrpcol=new ArrayList();
    	ArrayList arrGrpRow=new ArrayList();
    	ArrayList arrGrpexpcol=new ArrayList();
    	ArrayList arrGrpexpRow=new ArrayList();
    	NumberFormat nft=NumberFormat.getInstance();
		nft.setMinimumFractionDigits(2);
		nft.setMaximumFractionDigits(2);
		nft.setGroupingUsed(false);
    	try
    	{	
    		strAction=Helper.correctNull((String)hshValues.get("hidAction"));
    		strAppno=Helper.correctNull((String)hshValues.get("appno"));
    		strApplicantid=Helper.correctNull((String)hshValues.get("hidapplicantid"));
    		if(strApplicantid.equalsIgnoreCase(""))
    		{
    			strApplicantid=Helper.correctNull((String)hshValues.get("appid"));
    		}
    		
    		strQuery=SQLParser.getSqlQuery("sel_com_bankingsum^"+strAppno+"^F");
    		rs=DBUtils.executeQuery(strQuery);
    		if(rs.next())
    		{
    			dbl_exifundostot=Double.parseDouble(Helper.correctDouble((String)rs.getString(1)));
    		} 
    		if(rs!=null)
    		{
    			rs.close();
    		}
    		strQuery=SQLParser.getSqlQuery("sel_com_bankingsum^"+strAppno+"^N");
    		rs=DBUtils.executeQuery(strQuery);
    		if(rs.next())
    		{
    			dbl_exinonfundostot=Double.parseDouble(Helper.correctDouble((String)rs.getString(1)));
    		}
    		if(rs!=null)
    		{
    			rs.close();
    		}
    		
    		int i=0;
    		strQuery=SQLParser.getSqlQuery("SEL_GRPCONCCUSTOMER^"+strAppno);
    		rs=DBUtils.executeQuery(strQuery);
    		while(rs.next())
    		{    
    			i++;
    			strGrpconcernid=Helper.correctNull((String)rs.getString("APP_SEC_CUSTOMERID"));
    			strQuery1=SQLParser.getSqlQuery("SEL_GRPCONCCUSTOMERSUM^"+strAppno+"^"+strGrpconcernid+"^F");
        		rs1=DBUtils.executeQuery(strQuery1);
        		if(rs1.next())
        		{
        			dbl_grpexifundostot=Double.parseDouble(Helper.correctDouble((String)rs1.getString(1)));
        		}
        		if(rs1!=null)
        		{
        			rs1.close();
        		}
        		strQuery1=SQLParser.getSqlQuery("SEL_GRPCONCCUSTOMERSUM^"+strAppno+"^"+strGrpconcernid+"^N");
        		rs1=DBUtils.executeQuery(strQuery1);
        		if(rs1.next())
        		{
        			dbl_grpexinonfundostot=Double.parseDouble(Helper.correctDouble((String)rs1.getString(1)));
        		}
        		if(rs1!=null)
        		{
        			rs1.close();
        		}
        		dbl_GrpExpExiSubtotal=dbl_grpexinonfundostot+dbl_grpexifundostot;
        		dbl_GrpExpExitotal=dbl_grpexinonfundostot+dbl_grpexifundostot;
        		arrGrpexpcol=new ArrayList();
        		arrGrpexpcol.add(strGrpconcernid);
            	arrGrpexpcol.add(dbl_grpexifundostot);
            	arrGrpexpcol.add(dbl_grpexinonfundostot);
            	arrGrpexpcol.add(dbl_GrpExpExiSubtotal);
            	arrGrpexpRow.add(arrGrpexpcol);
            	dbl_GrpExpExiSubtotal=0;
            	
            	strQuery1=SQLParser.getSqlQuery("sel_appSecdetailsfacsno_applicant^"+strAppno+"^"+strGrpconcernid+"^P");
        		rs1=DBUtils.executeQuery(strQuery1);
        		while(rs1.next())
        		{
        			str_sec_id=Helper.correctInt((String)rs1.getString("app_sec_secid"));
        			strQuery2=SQLParser.getSqlQuery("select_security_calssification^"+str_sec_id);
        			rs2=DBUtils.executeQuery(strQuery2);
    	    		while(rs2.next())
    	    		{
    	    			arrGrpcol=new ArrayList();
    	    			arrGrpcol.add(strGrpconcernid);//0
    	    			arrGrpcol.add(Helper.correctNull((String)rs2.getString("CUS_SEC_ID")));//1
    	    			arrGrpcol.add(Helper.correctNull((String)rs2.getString("SEC_NAME")));//2
    	    			arrGrpcol.add(Helper.checkDecimal(Helper.correctDouble((String)rs2.getString("CUS_SEC_NETSECURITY"))));//3
    	    			arrGrpcol.add(Helper.checkDecimal(Helper.correctDouble((String)rs2.getString("CUS_SEC_NETSECURITY"))));//4
    	    			dbl_secproptot+=Double.parseDouble(Helper.checkDecimal(Helper.correctDouble((String)rs2.getString("CUS_SEC_NETSECURITY"))));
    	    			dbl_secexitot+=Double.parseDouble(Helper.checkDecimal(Helper.correctDouble((String)rs2.getString("CUS_SEC_NETSECURITY"))));
    	    			dbl_grpsecpropSubtot+=Double.parseDouble(Helper.checkDecimal(Helper.correctDouble((String)rs2.getString("CUS_SEC_NETSECURITY"))));
    	    			arrGrpRow.add(arrGrpcol);
    	    		}
        		}
        		hshRecord.put("dbl_grpsecpropSubtot"+i,nft.format(dbl_grpsecpropSubtot));
        		dbl_grpsecpropSubtot=0;
        		if(rs1!=null)
        		{
        			rs1.close();
        		}
        		if(rs2!=null)
        		{
        			rs2.close();
        		}
        		strQuery1=SQLParser.getSqlQuery("sel_appSecdetailsfacsno_applicant^"+strAppno+"^"+strGrpconcernid+"^E");
        		rs1=DBUtils.executeQuery(strQuery1);
        		while(rs1.next())
        		{
    	    		str_sec_id=Helper.correctInt((String)rs1.getString("app_sec_secid"));
    	    		strQuery2=SQLParser.getSqlQuery("select_security_calssification^"+str_sec_id);
    	    		rs2=DBUtils.executeQuery(strQuery2);
    	    		while(rs2.next())
    	    		{
    	    			arrGrpcol=new ArrayList();
    	    			arrGrpcol.add(strGrpconcernid);//0
    	    			arrGrpcol.add(Helper.correctNull((String)rs2.getString("CUS_SEC_ID")));//1
    	    			arrGrpcol.add(Helper.correctNull((String)rs2.getString("SEC_NAME")));//2
    	    			arrGrpcol.add(Helper.checkDecimal(Helper.correctDouble((String)rs2.getString("CUS_SEC_NETSECURITY"))));//3 
    	    			arrGrpcol.add(Helper.checkDecimal(Helper.correctDouble((String)rs2.getString("CUS_SEC_NETSECURITY"))));//4
    	    			dbl_secexitot+=Double.parseDouble(Helper.checkDecimal(Helper.correctDouble((String)rs2.getString("CUS_SEC_NETSECURITY"))));
    	    			dbl_secproptot+=Double.parseDouble(Helper.checkDecimal(Helper.correctDouble((String)rs2.getString("CUS_SEC_NETSECURITY"))));
    	    			dbl_grpsecexiSubtot+=Double.parseDouble(Helper.checkDecimal(Helper.correctDouble((String)rs2.getString("CUS_SEC_NETSECURITY"))));
    	    			arrGrpRow.add(arrGrpcol);
    	    		}
        		}
        		if(rs1!=null)
        		{
        			rs1.close();
        		}
        		if(rs2!=null)
        		{
        			rs2.close();
        		}
        		hshRecord.put("dbl_grpsecexiSubtot"+i,nft.format(dbl_grpsecexiSubtot));
        		dbl_grpsecexiSubtot=0;
        	}
    		hshRecord.put("arrGrpexpRow",arrGrpexpRow);
    		hshRecord.put("arrGrpRow",arrGrpRow);
    		hshRecord.put("Count",i);
    		
    		if(rs!=null)
    		{
    			rs.close();
    		}
    		
    		strQuery=SQLParser.getSqlQuery("selfacilitylistnew^"+strAppno+"^0^F");
    		rs=DBUtils.executeQuery(strQuery);
    		while(rs.next())
    		{
    			dbl_propfundostot+=Double.parseDouble(Helper.correctDouble((String)rs.getString("facility_proposed")));
    		}
    		if(rs!=null)
    		{
    			rs.close();
    		}
    		strQuery=SQLParser.getSqlQuery("selfacilitylistnew^"+strAppno+"^0^NF");
    		rs=DBUtils.executeQuery(strQuery);
    		while(rs.next())
    		{
    			dbl_propnonfundostot+=Double.parseDouble(Helper.correctDouble((String)rs.getString("facility_proposed")));
    		}
    		if(rs!=null)
    		{
    			rs.close();
    		}
    		hshRecord.put("dbl_exifundostot", nft.format(dbl_exifundostot));
    		hshRecord.put("dbl_exinonfundostot",nft.format(dbl_exinonfundostot));
    		hshRecord.put("dbl_propfundostot", nft.format(dbl_propfundostot));
    		hshRecord.put("dbl_propnonfundostot",nft.format(dbl_propnonfundostot));
    		hshRecord.put("dbl_subtotvalexis", nft.format(dbl_exifundostot+dbl_exinonfundostot));
    		hshRecord.put("dbl_totvalexis", nft.format(dbl_exifundostot+dbl_exinonfundostot+dbl_GrpExpExitotal));
    		hshRecord.put("dbl_totvalproposed",nft.format(dbl_propfundostot+dbl_propnonfundostot));
    		strQuery=SQLParser.getSqlQuery("sel_appSecdetailsfacsno_applicant^"+strAppno+"^"+strApplicantid+"^P");
    		rs1=DBUtils.executeQuery(strQuery);
    		while(rs1.next())
    		{
    		str_sec_id=Helper.correctInt((String)rs1.getString("app_sec_secid"));
    		strQuery=SQLParser.getSqlQuery("select_security_calssification^"+str_sec_id);
    		rs=DBUtils.executeQuery(strQuery);
	    		while(rs.next())
	    		{
	    			arrcol=new ArrayList();
	    			arrcol.add(Helper.correctNull((String)rs.getString("CUS_SEC_ID")));//0
	    			arrcol.add(Helper.correctNull((String)rs.getString("SEC_NAME")));//1
	    			arrcol.add(Helper.checkDecimal(Helper.correctDouble((String)rs.getString("CUS_SEC_NETSECURITY"))));//2
	    			arrcol.add(Helper.checkDecimal(Helper.correctDouble((String)rs.getString("CUS_SEC_NETSECURITY"))));//3
	    			dbl_secproptot+=Double.parseDouble(Helper.checkDecimal(Helper.correctDouble((String)rs.getString("CUS_SEC_NETSECURITY"))));
	    			dbl_secexitot+=Double.parseDouble(Helper.checkDecimal(Helper.correctDouble((String)rs.getString("CUS_SEC_NETSECURITY"))));
	    			dbl_secexiSubtot+=Double.parseDouble(Helper.checkDecimal(Helper.correctDouble((String)rs.getString("CUS_SEC_NETSECURITY"))));
	    			dbl_secpropSubtot+=Double.parseDouble(Helper.checkDecimal(Helper.correctDouble((String)rs.getString("CUS_SEC_NETSECURITY"))));
	    			arrRow.add(arrcol);
	    		}
    		}
    		if(rs!=null)
    		{
    			rs.close();
    		}
    		if(rs1!=null)
    		{
    			rs1.close();
    		}
    		strQuery=SQLParser.getSqlQuery("sel_appSecdetailsfacsno_applicant^"+strAppno+"^"+strApplicantid+"^E");
    		rs1=DBUtils.executeQuery(strQuery);
    		while(rs1.next())
    		{
	    		str_sec_id=Helper.correctInt((String)rs1.getString("app_sec_secid"));
	    		strQuery=SQLParser.getSqlQuery("select_security_calssification^"+str_sec_id);
	    		rs=DBUtils.executeQuery(strQuery);
	    		while(rs.next())
	    		{
	    			arrcol=new ArrayList();
	    			arrcol.add(Helper.correctNull((String)rs.getString("CUS_SEC_ID")));//0
	    			arrcol.add(Helper.correctNull((String)rs.getString("SEC_NAME")));//1
	    			arrcol.add(Helper.checkDecimal(Helper.correctDouble((String)rs.getString("CUS_SEC_NETSECURITY"))));//2
	    			arrcol.add(Helper.checkDecimal(Helper.correctDouble((String)rs.getString("CUS_SEC_NETSECURITY"))));//3
	    			dbl_secexitot+=Double.parseDouble(Helper.checkDecimal(Helper.correctDouble((String)rs.getString("CUS_SEC_NETSECURITY"))));
	    			dbl_secproptot+=Double.parseDouble(Helper.checkDecimal(Helper.correctDouble((String)rs.getString("CUS_SEC_NETSECURITY"))));
	    			dbl_secexiSubtot+=Double.parseDouble(Helper.checkDecimal(Helper.correctDouble((String)rs.getString("CUS_SEC_NETSECURITY"))));
	    			dbl_secpropSubtot+=Double.parseDouble(Helper.checkDecimal(Helper.correctDouble((String)rs.getString("CUS_SEC_NETSECURITY"))));
	    			arrRow.add(arrcol);
	    		}
    		}
    		hshRecord.put("arrRow",arrRow);
    		hshRecord.put("dbl_secexitot", nft.format(dbl_secexitot));
    		hshRecord.put("dbl_secproptot", nft.format(dbl_secproptot));
    		hshRecord.put("dbl_secexiSubtot", nft.format(dbl_secexiSubtot));
    		hshRecord.put("dbl_secpropSubtot", nft.format(dbl_secpropSubtot));
    		
    		if((dbl_exifundostot+dbl_exinonfundostot+dbl_GrpExpExitotal)!=0 && dbl_secexitot!=0)
    		{
    			dbl_secexicoverage=(dbl_secexitot/(dbl_exifundostot+dbl_exinonfundostot+dbl_GrpExpExitotal))*100;
    		}
    		hshRecord.put("dbl_secexicoverage", nft.format(dbl_secexicoverage));
    		if((dbl_propfundostot+dbl_propnonfundostot)!=0 && dbl_secexitot!=0)
    		{
    			dbl_secpropcoverage=(dbl_secproptot/(dbl_propfundostot+dbl_propnonfundostot))*100;
    		}
    		hshRecord.put("dbl_secpropcoverage", nft.format(dbl_secpropcoverage));
    		
    		if(rs!=null)
    		{
    			rs.close();
    		}
    	}
    	catch(Exception exception)
    	{
    		throw new EJBException("Error in getCollateralSecurityDisplay "+exception.toString());
    		
    	}
    	return hshRecord;
    }
    public HashMap getCollateralSecurityDisplayretail(HashMap hshValues) 
    {
    	HashMap hshRecord=  new HashMap();
    	HashMap hshRating = new HashMap();
    	ResultSet rs = null,rs1=null,rs2=null,rs3=null;
    	String strQuery="",strAppno="",str_sec_id="",strAction="",strApplicantid="",strQuery1="",strQuery2="",strApplnid="",strOldApplnID="",strApplicanttype="",strQuery3="",strHeadfac="";
    	double dbl_exifundostot=0,dbl_exinonfundostot=0,dbl_propfundostot=0,dbl_propnonfundostot=0,
    	dbl_secexitot=0,dbl_secproptot=0,dbl_secpropcoverage=0,dbl_secexicoverage=0,dbl_grpexifundostot=0,dbl_grpexinonfundostot=0,dbl_GrpExpExiSubtotal=0,
    	dbl_secexiSubtot=0,dbl_secpropSubtot=0,dbl_Proposedexptot=0,dbl_propexisfndtot=0,dbl_propexisnonfndtot=0,dbl_totalexposurefund=0,dbl_totalexposureNonfund=0;
    	ArrayList arrApplicantRow=new ArrayList();
    	ArrayList arrSecidRow = new ArrayList();
    	ArrayList arrSecidCol = new ArrayList();
    	ArrayList arrExposureRow = new ArrayList();
    	ArrayList arrExposureCol = new ArrayList();
		ArrayList arrSecidcommon = new ArrayList();
		ArrayList arrSecidcomRow = new ArrayList();
		ArrayList arrBorrowerlist = new ArrayList();
		ArrayList arrSecidExculsive = new ArrayList();
		HashMap hshSec = new HashMap(); 
    	String strValuesin=Helper.correctNull((String)hshValues.get("valuesin"));
    	java.text.NumberFormat nft= java.text.NumberFormat.getInstance();
    	String strapplType="",strCommonsecid="",strAttachedSecurityid="",strFlag="",strBorrowercheckec="",strName="",strRestrFlag="";
		nft= java.text.NumberFormat.getInstance();
		nft.setMaximumFractionDigits(2);
		nft.setMinimumFractionDigits(2);
		nft.setGroupingUsed(false);
		double dblRestrVal=0.0,dblRestrValNF=0.0;
		try
    	{	
    		int i=0,Count=0;
    		strAction=Helper.correctNull((String)hshValues.get("hidAction"));
    		strAppno=Helper.correctNull((String)hshValues.get("appno"));
    		strApplicantid=Helper.correctNull((String)hshValues.get("hidapplicantnewid"));
    		if(strApplicantid.equalsIgnoreCase(""))
    		{
    			strApplicantid=Helper.correctNull((String)hshValues.get("comappid"));
    		}	
    		
    		//for taking old ID
    		strQuery = SQLParser.getSqlQuery("selcustomerdetails^"+strApplicantid);
    		rs = DBUtils.executeQuery(strQuery);
    		if(rs.next())
    		{
    			strApplicantid = Helper.correctNull((String) rs.getString("perapp_oldid"));
    		}
    		String strAppType="";

    		arrApplicantRow.add(strApplicantid);
			  		
    		strQuery=SQLParser.getSqlQuery("SEL_COUNTAPPLI^"+strAppno);
    		rs=DBUtils.executeQuery(strQuery);
    		while(rs.next())
    		{
    			Count++;
    		}
    		if(rs!=null)
    		{
    			rs.close();
    		}
    		
    		strAppType="C','G','P','O";
    		strQuery=SQLParser.getSqlQuery("getcoappguarantortype^" + strAppno+ "^" + strAppType);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				strApplnid=Helper.correctNull((String)rs.getString("demo_appid"));
				strOldApplnID=Helper.correctNull((String)rs.getString("perapp_oldid"));
    			if(!(strApplnid.equalsIgnoreCase("")))
    			{
    				arrApplicantRow.add(strApplnid);
    			}
			}
   			for(int l =0;l<arrApplicantRow.size();l++)
       		{
        			strApplnid=Helper.correctNull((String)arrApplicantRow.get(l));
        			if(strApplnid.equalsIgnoreCase(strApplicantid))
        			{
        				strApplicanttype="A";
        			}
        			else
        			{
        				strApplicanttype="O";
        			}
    			if(strApplicanttype.equalsIgnoreCase("A"))
	    		{
    				String strSecid="";
    				
    				strQuery=SQLParser.getSqlQuery("sel_Securityidlist^"+strAppno+"^"+"P");
    	    		rs=DBUtils.executeQuery(strQuery);
    	    		while(rs.next())
	    	    	{
    	    			strSecid = Helper.correctNull(rs.getString("APP_SEC_SECID"));
    	    			boolean allow=true;
    	    			strQuery1=SQLParser.getSqlQuery("sel_Seccount^"+strAppno+"^"+strSecid+"^"+strApplnid);
        	    		rs1=DBUtils.executeQuery(strQuery1);
        	    		if(rs1.next())
    	    	    	{
        	    			strQuery2=SQLParser.getSqlQuery("sel_Securitydetails^"+strSecid+"^"+strAppno+"^P");
            	    		rs2=DBUtils.executeQuery(strQuery2);
            	    		while(rs2.next())
            	    		{
            	    			if(allow){
            	    				allow=false;
            	    			arrSecidcommon = new ArrayList();
    		        			arrSecidcommon.add(Helper.correctNull(rs2.getString("APP_SEC_SECID")));
    		        			arrSecidcommon.add("");
    		        			arrSecidcommon.add(Helper.correctNull(rs2.getString("CUS_SEC_TYPE")));
    		        			arrSecidcommon.add(Helper.correctNull(rs2.getString("CUS_SEC_NETSECURITY")));
    		        			
    		        			if(strCommonsecid.equalsIgnoreCase(""))
    		        			{
    		        				strCommonsecid="'"+Helper.correctNull(rs2.getString("APP_SEC_SECID"))+"'";
    		        			}else
    		        			{
    		        				strCommonsecid=strCommonsecid+",'"+Helper.correctNull(rs2.getString("APP_SEC_SECID"))+"'";
    		        			}
    		        			arrSecidcomRow.add(arrSecidcommon);
            	    		}
    		        			if(!(Helper.correctNull(rs2.getString("APP_SEC_CUSTOMERID")).equalsIgnoreCase(Helper.correctNull(rs2.getString("APP_SEC_BORROWER_ID")))))
    		        			{
    		        				if(!arrBorrowerlist.contains(Helper.correctNull(rs2.getString("APP_SEC_CUSTOMERID"))))
    		        				{
    		        					arrBorrowerlist.add(Helper.correctNull(rs2.getString("APP_SEC_CUSTOMERID")));
    		        				}
    		        			}
            	    		}
        	    		}
        	    		else
        	    		{
        	    			strQuery2=SQLParser.getSqlQuery("sel_Securitydetails^"+strSecid+"^"+strAppno+"^P");
            	    		rs2=DBUtils.executeQuery(strQuery2);
            	    		while(rs2.next())
            	    		{
	        	    			arrSecidExculsive = new ArrayList();
			        			arrSecidExculsive.add(Helper.correctNull(rs2.getString("APP_SEC_SECID")));
			        			arrSecidExculsive.add("");
			        			arrSecidExculsive.add(Helper.correctNull(rs2.getString("CUS_SEC_TYPE")));
			        			arrSecidExculsive.add(Helper.correctNull(rs2.getString("CUS_SEC_NETSECURITY")));
			        			if(strCommonsecid.equalsIgnoreCase(""))
    		        			{
    		        				strCommonsecid="'"+Helper.correctNull(rs2.getString("APP_SEC_SECID"))+"'";
    		        			}else
    		        			{
    		        				strCommonsecid=strCommonsecid+",'"+Helper.correctNull(rs2.getString("APP_SEC_SECID"))+"'";
    		        			}
			        			arrSecidRow.add(arrSecidExculsive);
            	    		}
        	    		}
	    	    	}
	        		hshValues.put("arrSecidRow",arrSecidRow);
	        		hshValues.put("arrSecidcomRow",arrSecidcomRow);
	        		arrSecidcomRow = new ArrayList();
	        		arrSecidRow = new ArrayList();
	        		
	        		strQuery=SQLParser.getSqlQuery("sel_Securitylistexisting^"+strAppno+"^"+strApplnid+"^ ");
    	    		rs=DBUtils.executeQuery(strQuery);
    	    		while(rs.next())
	    	    	{
    	    			strSecid = Helper.correctNull(rs.getString("APP_SEC_SECID"));
    	    			boolean allow=true;
    	    			strQuery1=SQLParser.getSqlQuery("sel_Seccount^"+strAppno+"^"+strSecid+"^"+strApplnid);
        	    		rs1=DBUtils.executeQuery(strQuery1);
        	    		if(rs1.next())
    	    	    	{
        	    			strQuery2=SQLParser.getSqlQuery("sel_Securitydetails^"+strSecid+"^"+strAppno+"^E");
            	    		rs2=DBUtils.executeQuery(strQuery2);
            	    		while(rs2.next())
            	    		{
	            	    		if(allow)
	            	    		{
	            	    				allow=false;
	            	    			arrSecidcommon = new ArrayList();
	    		        			arrSecidcommon.add(Helper.correctNull(rs2.getString("APP_SEC_SECID")));
	    		        			arrSecidcommon.add("");
	    		        			arrSecidcommon.add(Helper.correctNull(rs2.getString("CUS_SEC_TYPE")));
	    		        			arrSecidcommon.add(Helper.correctNull(rs2.getString("CUS_SEC_NETSECURITY")));
	    		        			if(!(Helper.correctNull(rs2.getString("APP_SEC_CUSTOMERID")).equalsIgnoreCase(Helper.correctNull(rs2.getString("APP_SEC_BORROWER_ID")))))
	    		        			{
	    		        				if(!arrBorrowerlist.contains(Helper.correctNull(rs2.getString("APP_SEC_CUSTOMERID"))))
	    		        				{
	    		        					arrBorrowerlist.add(Helper.correctNull(rs2.getString("APP_SEC_CUSTOMERID")));
	    		        				}
	    		        			}
	    		        			if(strCommonsecid.equalsIgnoreCase(""))
	    		        			{
	    		        				strCommonsecid="'"+Helper.correctNull(rs2.getString("APP_SEC_SECID"))+"'";
	    		        			}else
	    		        			{
	    		        				strCommonsecid=strCommonsecid+",'"+Helper.correctNull(rs2.getString("APP_SEC_SECID"))+"'";
	    		        			}
	    		        			arrSecidcomRow.add(arrSecidcommon);
	            	    		}
	            	    		if(!(Helper.correctNull(rs2.getString("APP_SEC_CUSTOMERID")).equalsIgnoreCase(Helper.correctNull(rs2.getString("APP_SEC_BORROWER_ID")))))
    		        			{
	            	    			if(!arrBorrowerlist.contains(Helper.correctNull(rs2.getString("APP_SEC_CUSTOMERID"))))
    		        				{
	            	    				arrBorrowerlist.add(Helper.correctNull(rs2.getString("APP_SEC_CUSTOMERID")));
    		        				}
    		        			}
            	    		}
        	    		}
        	    		else
        	    		{
        	    			strQuery2=SQLParser.getSqlQuery("sel_Securitydetails^"+strSecid+"^"+strAppno+"^E");
            	    		rs2=DBUtils.executeQuery(strQuery2);
            	    		while(rs2.next())
            	    		{
	        	    			arrSecidExculsive = new ArrayList();
			        			arrSecidExculsive.add(Helper.correctNull(rs2.getString("APP_SEC_SECID")));
			        			arrSecidExculsive.add("");
			        			arrSecidExculsive.add(Helper.correctNull(rs2.getString("CUS_SEC_TYPE")));
			        			arrSecidExculsive.add(Helper.correctNull(rs2.getString("CUS_SEC_NETSECURITY")));
			        			if(strCommonsecid.equalsIgnoreCase(""))
    		        			{
    		        				strCommonsecid="'"+Helper.correctNull(rs2.getString("APP_SEC_SECID"))+"'";
    		        			}else
    		        			{
    		        				strCommonsecid=strCommonsecid+",'"+Helper.correctNull(rs2.getString("APP_SEC_SECID"))+"'";
    		        			}
			        			arrSecidRow.add(arrSecidExculsive);
            	    		}
        	    		}
	        			
	    	    	}
	        		hshValues.put("arrExisidExc",arrSecidRow);
	        		hshValues.put("arrExisecidcom",arrSecidcomRow);
	        		hshSec=getSum(hshValues);
	        		strAttachedSecurityid=Helper.correctNull((String)hshSec.get("strSecId"));
	        		strFlag=Helper.correctNull((String)hshSec.get("strFlag"));
	        		strBorrowercheckec="'"+strApplnid+"'";
	        		hshRecord.put("Securities",hshSec.get("arrValueRow"));
	        		hshRecord.put("strFlag",strFlag);
	        		

    				arrExposureCol = new ArrayList();
    				dbl_exifundostot=0;
    	    		dbl_totalexposurefund=0;
    				dbl_totalexposureNonfund=0;
    				//for taking Existing funded 
    	    		String strcombk_modtype="",str_Loantype="",strFacility = null,strBaltype="",strfundtype="'F'";
    	    		double dblExposure=0,dblOs=0,dblLimit=0;
    	    		strfundtype="'F'";
    	    		strQuery1=SQLParser.getSqlQuery("sel_combkfundednon^"+strAppno+"^"+strAppno+"^"+strfundtype);
    	    		rs1=DBUtils.executeQuery(strQuery1);
    	    		while(rs1.next())
    	    		{
    	    			str_Loantype="";
    	    			strHeadfac="";
    	    			strRestrFlag=Helper.correctNull((String)rs1.getString("restrflag"));
    	    			strcombk_modtype=Helper.correctNull((String)rs1.getString("combk_modtype"));
    	    			strFacility=Helper.correctNull((String)rs1.getString("combk_facility"));
    	    			strBaltype=Helper.correctNull((String)rs1.getString("combk_baltype"));
    	    			dblExposure=Double.parseDouble(Helper.correctDouble((String)rs1.getString("com_exposure")));
    	    			dblOs=Double.parseDouble(Helper.correctDouble((String)rs1.getString("combk_os")));
    	    			dblLimit=Double.parseDouble(Helper.correctDouble((String)rs1.getString("combk_limit")));
    	    			String[] strFacilityArr=strFacility.split("~");
    	    			if(strcombk_modtype.equalsIgnoreCase("p") || strcombk_modtype.equalsIgnoreCase("r"))
    					{
    						strQuery2=SQLParser.getSqlQuery("sel_retProductDesc^"+strFacilityArr[0]);
    						rs2 = DBUtils.executeQuery(strQuery2);
    						if(rs2.next())
    						{
    							str_Loantype=Helper.correctNull(rs2.getString("PRD_LOANTYPE"));
    						}
    					}
    					else
    					{
    						strQuery2=SQLParser.getSqlQuery("sel_FacilityCorpDesc^"+Helper.correctInt(strFacilityArr[0])+"^"+strcombk_modtype);
    						rs2 = DBUtils.executeQuery(strQuery2);
    						if(rs2.next())
    						{
    							str_Loantype=Helper.correctNull(rs2.getString("com_facility_loantype"));
    							strHeadfac=Helper.correctNull(rs2.getString("com_headfac"));
    						}
    					}
    	    			if(rs2!=null)
        	    		{
        	    			rs2.close();
        	    		}
    	    			//if od Limit or Outstanding which ever is higher for cr
    	    			//if dr limit
    	    			if(str_Loantype.equalsIgnoreCase("TL")||str_Loantype.equalsIgnoreCase("DL"))
    	    			{
    	    				if(strHeadfac.equalsIgnoreCase("1"))
    	    				{
    	    					dblExposure=dblExposure/50;
    	    				}
    	    				dbl_exifundostot+=dblExposure;
    	    				if(strRestrFlag.equalsIgnoreCase("Y"))
    	    				dblRestrVal+=dblExposure;
    	    			}
    	    			else
    	    			{
    	    				if(strBaltype.equalsIgnoreCase("DR"))
    	    				{
    	    					if(dblLimit>dblOs)
    	    					{
    	    						if(strHeadfac.equalsIgnoreCase("1"))
    	    	    				{
    	    							dblLimit=dblLimit/50;
    	    	    				}
    	    						dbl_exifundostot+=dblLimit;
    	    						if(strRestrFlag.equalsIgnoreCase("Y"))
    	        	    				dblRestrVal+=dblLimit;
    	    					}else
    	    					{
    	    						if(strHeadfac.equalsIgnoreCase("1"))
    	    	    				{
    	    							dblOs=dblOs/50;
    	    	    				}
    	    						dbl_exifundostot+=dblOs;
    	    						if(strRestrFlag.equalsIgnoreCase("Y"))
    	        	    				dblRestrVal+=dblOs;
    	    					}
    	    				}else
    	    				{
    	    					if(strHeadfac.equalsIgnoreCase("1"))
	    	    				{
    	    						dblLimit=dblLimit/50;
	    	    				}
    	    					dbl_exifundostot+=dblLimit;
    	    					if(strRestrFlag.equalsIgnoreCase("Y"))
    	    	    				dblRestrVal+=dblLimit;
    	    				}
    	    			}
    	    		}
    	    		if(rs1!=null)
    	    		{
    	    			rs1.close();
    	    		}
    	    		arrExposureCol.add(nft.format(dbl_exifundostot));//0
    	    		dbl_propfundostot=0;
    	    		
    	    		
    	    		strQuery1=SQLParser.getSqlQuery("selperprdmargin^"+strAppno);  // Recommended loan amt(proposed) from loandetails
    	    		rs1=DBUtils.executeQuery(strQuery1);
    	    		if(rs1.next())
    	    		{
    	    			dbl_propfundostot+=Double.parseDouble(Helper.correctDouble((String)rs1.getString("loan_recmdamt")));
    	    		}
    	    		if(rs1!=null)
    	    		{
    	    			rs1.close();
    	    		}
    	    		
    	    		double dbl_renew_limit=0;
    	    		strQuery1=SQLParser.getSqlQuery("sel_renewal_limit_retail^"+strAppno);  // Proposed loan amt in case of renewal
    	    		rs1=DBUtils.executeQuery(strQuery1);
    	    		if(rs1.next())
    	    		{
    	    			dbl_renew_limit+=Double.parseDouble(Helper.correctDouble(rs1.getString("loan_recmdamt")));
    	    		}
    	    		if(rs1!=null)
    	    		{
    	    			rs1.close();
    	    		}
    	    		arrExposureCol.add(String.valueOf(dbl_propfundostot));//1
    	    		if(dbl_propfundostot > dbl_renew_limit)
    	    			dbl_totalexposurefund=dbl_exifundostot+dbl_propfundostot-dbl_renew_limit;
    	    		else
    	    			dbl_totalexposurefund=dbl_exifundostot+dbl_propfundostot;
    	    		dbl_exinonfundostot=0;
    	    		//for taking the existing non funded 
    	    		strcombk_modtype="";str_Loantype="";strFacility = null;strBaltype="";
    	    		dblExposure=0;dblOs=0;dblLimit=0;
    	    		String strnonfundtype="'N','NF'";
    	    		strQuery1=SQLParser.getSqlQuery("sel_combkfundednon^"+strAppno+"^"+strAppno+"^"+strnonfundtype);
    	    		rs1=DBUtils.executeQuery(strQuery1);
    	    		while(rs1.next())
    	    		{
    	    			str_Loantype="";
    	    			strHeadfac="";
    	    			strRestrFlag=Helper.correctNull((String)rs1.getString("restrflag"));
    	    			strcombk_modtype=Helper.correctNull((String)rs1.getString("combk_modtype"));
    	    			strFacility=Helper.correctNull((String)rs1.getString("combk_facility"));
    	    			strBaltype=Helper.correctNull((String)rs1.getString("combk_baltype"));
    	    			dblExposure=Double.parseDouble(Helper.correctDouble((String)rs1.getString("com_exposure")));
    	    			dblOs=Double.parseDouble(Helper.correctDouble((String)rs1.getString("combk_os")));
    	    			dblLimit=Double.parseDouble(Helper.correctDouble((String)rs1.getString("combk_limit")));
    	    			String[] strFacilityArr=strFacility.split("~");
    	    			if(strcombk_modtype.equalsIgnoreCase("p") || strcombk_modtype.equalsIgnoreCase("r"))
    					{
    						strQuery2=SQLParser.getSqlQuery("sel_retProductDesc^"+strFacilityArr[0]);
    						rs2 = DBUtils.executeQuery(strQuery2);
    						if(rs2.next())
    						{
    							str_Loantype=Helper.correctNull(rs2.getString("PRD_LOANTYPE"));
    						}
    					}
    					else
    					{
    						strQuery2=SQLParser.getSqlQuery("sel_FacilityCorpDesc^"+Helper.correctInt(strFacilityArr[0])+"^"+strcombk_modtype);
    						rs2 = DBUtils.executeQuery(strQuery2);
    						if(rs2.next())
    						{
    							str_Loantype=Helper.correctNull(rs2.getString("com_facility_loantype"));
    							strHeadfac=Helper.correctNull(rs2.getString("com_headfac"));
    						}
    					}
    	    			if(rs2!=null)
        	    		{
        	    			rs2.close();
        	    		}
    	    			//if od Limit or Outstanding which ever is higher for cr
    	    			//if dr limit
    	    			if(str_Loantype.equalsIgnoreCase("TL")||str_Loantype.equalsIgnoreCase("DL"))
    	    			{
    	    				if(strHeadfac.equalsIgnoreCase("1"))
    	    				{
    	    					dblExposure=dblExposure/50;
    	    				}
    	    				dbl_exinonfundostot+=dblExposure;
    	    				if(strRestrFlag.equalsIgnoreCase("Y"))
    	    					dblRestrValNF+=dblExposure;
    	    			}
    	    			else
    	    			{
    	    				if(strBaltype.equalsIgnoreCase("DR"))
    	    				{
    	    					if(dblLimit>dblOs)
    	    					{
    	    						if(strHeadfac.equalsIgnoreCase("1"))
    	    	    				{
    	    							dblLimit=dblLimit/50;
    	    	    				}
    	    						dbl_exinonfundostot+=dblLimit;
    	    						if(strRestrFlag.equalsIgnoreCase("Y"))
    	    							dblRestrValNF+=dblLimit;
    	    					}else
    	    					{
    	    						if(strHeadfac.equalsIgnoreCase("1"))
    	    	    				{
    	    							dblOs=dblOs/50;
    	    	    				}
    	    						dbl_exinonfundostot+=dblOs;
    	    						if(strRestrFlag.equalsIgnoreCase("Y"))
    	    							dblRestrValNF+=dblOs;
    	    					}
    	    				}else
    	    				{
    	    					if(strHeadfac.equalsIgnoreCase("1"))
        	    				{
    	    						dblLimit=dblLimit/50;
        	    				}
    	    					dbl_exinonfundostot+=dblLimit;
    	    					if(strRestrFlag.equalsIgnoreCase("Y"))
    	    						dblRestrValNF+=dblLimit;
    	    				}
    	    			}
    	    		}
    	    		
    	    		if(rs1!=null)
    	    		{
    	    			rs1.close();
    	    		}
    	    		
    	    		arrExposureCol.add(String.valueOf(dbl_exinonfundostot));//2
    	    		dbl_totalexposureNonfund=dbl_exinonfundostot;
    	    		/*strQuery1=SQLParser.getSqlQuery("selfacilitylistnew^"+strAppno+"^0^NF");
    	    		rs1=DBUtils.executeQuery(strQuery1);
    	    		while(rs1.next())
    	    		{
    	    			dbl_propnonfundostot+=Double.parseDouble(Helper.correctDouble((String)rs1.getString("facility_proposed")));
    	    		}
    	    		if(rs1!=null)
    	    		{
    	    			rs1.close();
    	    		}*/
    	    		arrExposureCol.add(String.valueOf("0.00"));//3
    	    		arrExposureCol.add(strApplicanttype);//4
    	    		strQuery1=SQLParser.getSqlQuery("sel_lapsidfromlapsid^"+strApplnid);
    	    		rs1=DBUtils.executeQuery(strQuery1);
    	    		while(rs1.next())
    	    		{
    	    			strName=Helper.correctNull((String)rs1.getString("perapp_fname"));
    	    		}
    	    		if(rs1!=null)
    	    		{
    	    			rs1.close();
    	    		}
    	    		arrExposureCol.add(Helper.changetoTitlecase(strName));//5
    	    		arrExposureCol.add(strFlag);//6
    	    		arrExposureCol.add(strApplnid);//7
    	    		arrExposureCol.add(String.valueOf(dbl_totalexposurefund-dblRestrVal));//8
    	    		arrExposureCol.add(String.valueOf(dbl_totalexposureNonfund-dblRestrValNF));//9
    	    		arrExposureRow.add(arrExposureCol);
				}
    			else
	    		{
	    				arrSecidcomRow=new ArrayList();
	    				arrSecidRow=new ArrayList();
	    				String strRemainingborrower="";
	    				hshSec = new HashMap();
	    			    	
	    				if(strCommonsecid.equalsIgnoreCase("")){
	    				strCommonsecid="' '";
	    				}
	    				String strquery4="and APP_SEC_SECID not in  ("+strCommonsecid+")";
	    				strQuery=SQLParser.getSqlQuery("sel_Securitylistexisting^"+strAppno+"^"+strApplnid+"^"+strquery4);
	    	    		rs=DBUtils.executeQuery(strQuery);
	    	    		while(rs.next())
		    	    	{

	    	    			String strSecid = Helper.correctNull(rs.getString("APP_SEC_SECID"));
	    	    			strQuery1=SQLParser.getSqlQuery("sel_Seccount^"+strAppno+"^"+strSecid+"^"+strApplnid);
	        	    		rs1=DBUtils.executeQuery(strQuery1);
	        	    		if(rs1.next())
	    	    	    	{
	        	    			strQuery2=SQLParser.getSqlQuery("sel_Securitydetails^"+strSecid+"^"+strAppno+"^E");
	            	    		rs2=DBUtils.executeQuery(strQuery2);
	            	    		while(rs2.next())
	            	    		{
	            	    			arrSecidcommon = new ArrayList();
	    		        			arrSecidcommon.add(Helper.correctNull(rs2.getString("APP_SEC_SECID")));
	    		        			arrSecidcommon.add("");
	    		        			arrSecidcommon.add(Helper.correctNull(rs2.getString("CUS_SEC_TYPE")));
	    		        			arrSecidcommon.add(Helper.correctNull(rs2.getString("CUS_SEC_NETSECURITY")));
	    		        			arrSecidcommon.add(Helper.correctNull(rs2.getString("APP_SEC_CUSTOMERID")));
	    		        			if(strCommonsecid.equalsIgnoreCase(""))
	    		        			{
	    		        				strCommonsecid="'"+Helper.correctNull(rs2.getString("APP_SEC_SECID"))+"'";
	    		        			}else
	    		        			{
	    		        				strCommonsecid=strCommonsecid+",'"+Helper.correctNull(rs2.getString("APP_SEC_SECID"))+"'";
	    		        			}
	    		        			arrSecidcomRow.add(arrSecidcommon);
	            	    		}
	        	    		}
	        	    		else
	        	    		{
	        	    			strQuery2=SQLParser.getSqlQuery("sel_Securitydetails^"+strSecid+"^"+strAppno+"^E");
	            	    		rs2=DBUtils.executeQuery(strQuery2);
	            	    		while(rs2.next())
	            	    		{
		        	    			arrSecidExculsive = new ArrayList();
				        			arrSecidExculsive.add(Helper.correctNull(rs2.getString("APP_SEC_SECID")));
				        			arrSecidExculsive.add("");
				        			arrSecidExculsive.add(Helper.correctNull(rs2.getString("CUS_SEC_TYPE")));
				        			arrSecidExculsive.add(Helper.correctNull(rs2.getString("CUS_SEC_NETSECURITY")));
				        			arrSecidExculsive.add(Helper.correctNull(rs2.getString("APP_SEC_CUSTOMERID")));
				        			if(strCommonsecid.equalsIgnoreCase(""))
	    		        			{
	    		        				strCommonsecid="'"+Helper.correctNull(rs2.getString("APP_SEC_SECID"))+"'";
	    		        			}else
	    		        			{
	    		        				strCommonsecid=strCommonsecid+",'"+Helper.correctNull(rs2.getString("APP_SEC_SECID"))+"'";
	    		        			}
				        			arrSecidRow.add(arrSecidExculsive);
	            	    		}
	        	    		}
	        	    	}
	    				
	    	    		hshValues.put("arrExisidExc",arrSecidRow);
		        		hshValues.put("arrExisecidcom",arrSecidcomRow);
		        		hshValues.put("strAttachedSecurityid",strAttachedSecurityid);
		        		hshSec=getSumoth(hshValues);
		        		//strFlag=Helper.correctNull((String)hshSec.get("strFlag"));
		        		if(!strFlag.equalsIgnoreCase("EC"))
		        		{
		        			strFlag=Helper.correctNull((String)hshSec.get("strFlag"));
		        		}
		        		strAttachedSecurityid=Helper.correctNull((String)hshSec.get("strSecId"));
		        		hshRecord.put("Securities"+l,hshSec.get("arrValueRow"));
		        		if(!strFlag.equalsIgnoreCase(""))
		        		{
		        			hshRecord.put("strFlag",strFlag);
		        		}
		        		
		        		
		        		strAttachedSecurityid=Helper.correctNull((String)hshSec.get("strSecId"));
		        		hshRecord.put("Securities"+l,hshSec.get("arrValueRow"));
		        		arrExposureCol = new ArrayList();
	    				dbl_grpexifundostot=0;
	    				dbl_totalexposurefund=0;
	    				dbl_totalexposureNonfund=0;
	    				String strcombk_modtype="",str_Loantype="",strFacility = null,strBaltype="";
	    	    		double dblExposure=0.00,dblOs=0.00,dblLimit=0.00;
	    	    		strQuery1=SQLParser.getSqlQuery("sel_comgcfundednon^"+strAppno+"^"+strApplnid+"^"+strOldApplnID+"^F");
	    	    		rs1=DBUtils.executeQuery(strQuery1);
	    	    		while(rs1.next())
	    	    		{
	    	    			str_Loantype="";
	    	    			strHeadfac="";
	    	    			strcombk_modtype=Helper.correctNull((String)rs1.getString("comgc_modtype"));
	    	    			strFacility=Helper.correctNull((String)rs1.getString("comgc_facility"));
	    	    			strBaltype=Helper.correctNull((String)rs1.getString("comgc_baltype"));
	    	    			dblExposure=Double.parseDouble(Helper.correctDouble((String)rs1.getString("comgc_exposure")));
	    	    			dblOs=Double.parseDouble(Helper.correctDouble((String)rs1.getString("comgc_os")));
	    	    			dblLimit=Double.parseDouble(Helper.correctDouble((String)rs1.getString("comgc_limit")));
	    	    			if(strcombk_modtype.equalsIgnoreCase("p") || strcombk_modtype.equalsIgnoreCase("r"))
	    					{
	    						strQuery2=SQLParser.getSqlQuery("sel_retProductDesc^"+strFacility);
	    						rs2 = DBUtils.executeQuery(strQuery2);
	    						if(rs2.next())
	    						{
	    							str_Loantype=Helper.correctNull(rs2.getString("PRD_LOANTYPE"));
	    						}
	    					}
	    					else
	    					{
	    						strQuery2=SQLParser.getSqlQuery("sel_FacilityCorpDesc^"+strFacility+"^"+strcombk_modtype);
	    						rs2 = DBUtils.executeQuery(strQuery2);
	    						if(rs2.next())
	    						{
	    							str_Loantype=Helper.correctNull(rs2.getString("com_facility_loantype"));
	    							strHeadfac=Helper.correctNull(rs2.getString("com_headfac"));
	    						}
	    					}
	    	    			if(rs2!=null)
	        	    		{
	        	    			rs2.close();
	        	    		}
	    	    			//if od Limit or Outstanding which ever is higher for cr
	    	    			//if dr limit should be taken
	    	    			if(str_Loantype.equalsIgnoreCase("TL")||str_Loantype.equalsIgnoreCase("DL"))
	    	    			{
	    	    				if(strHeadfac.equalsIgnoreCase("1"))
	    	    				{
	    	    					dblExposure=dblExposure/50;
	    	    				}
	    	    				dbl_grpexifundostot+=dblExposure;
	    	    			}
	    	    			else
	    	    			{
	    	    				if(strBaltype.equalsIgnoreCase("DR"))
	    	    				{
	    	    					if(dblLimit>dblOs)
	    	    					{
	    	    						if(strHeadfac.equalsIgnoreCase("1"))
	    	    	    				{
	    	    							dblLimit=dblLimit/50;
	    	    	    				}
	    	    						dbl_grpexifundostot+=dblLimit;
	    	    					}else
	    	    					{
	    	    						if(strHeadfac.equalsIgnoreCase("1"))
	    	    	    				{
	    	    							dblOs=dblOs/50;
	    	    	    				}
	    	    						dbl_grpexifundostot+=dblOs;
	    	    					}
	    	    				}else
	    	    				{
	    	    					if(strHeadfac.equalsIgnoreCase("1"))
    	    	    				{
	    	    						dblLimit=dblLimit/50;
    	    	    				}
	    	    					dbl_grpexifundostot+=dblLimit;
	    	    				}
	    	    			}
	    	    		}
	    	    		if(rs1!=null)
	    	    		{
	    	    			rs1.close();
	    	    		}
	    	    		dbl_totalexposurefund=dbl_grpexifundostot;
	    	    		arrExposureCol.add(String.valueOf(dbl_grpexifundostot));//0
	            		arrExposureCol.add("0.00");//1
	            		boolean strflag=true;
	            		//for taking the existing non funded 
	    	    		strcombk_modtype="";str_Loantype="";strFacility = "";strBaltype="";
	    	    		dblExposure=0;dblOs=0;dblLimit=0;
	    	    		strQuery1=SQLParser.getSqlQuery("sel_comgcfundednon^"+strAppno+"^"+strApplnid+"^"+strOldApplnID+"^N");
	    	    		rs1=DBUtils.executeQuery(strQuery1);
	    	    		while(rs1.next())
	    	    		{
	    	    			str_Loantype="";
	    	    			strHeadfac="";
	    	    			strcombk_modtype=Helper.correctNull((String)rs1.getString("comgc_modtype"));
	    	    			strFacility=Helper.correctNull((String)rs1.getString("comgc_facility"));
	    	    			strBaltype=Helper.correctNull((String)rs1.getString("comgc_baltype"));
	    	    			dblExposure=Double.parseDouble(Helper.correctDouble((String)rs1.getString("comgc_exposure")));
	    	    			dblOs=Double.parseDouble(Helper.correctDouble((String)rs1.getString("comgc_os")));
	    	    			dblLimit=Double.parseDouble(Helper.correctDouble((String)rs1.getString("comgc_limit")));
	    	    			if(strcombk_modtype.equalsIgnoreCase("p") || strcombk_modtype.equalsIgnoreCase("r"))
	    					{
	    						strQuery2=SQLParser.getSqlQuery("sel_retProductDesc^"+strFacility);
	    						rs2 = DBUtils.executeQuery(strQuery2);
	    						if(rs2.next())
	    						{
	    							str_Loantype=Helper.correctNull(rs2.getString("PRD_LOANTYPE"));
	    						}
	    					}
	    					else
	    					{
	    						strQuery2=SQLParser.getSqlQuery("sel_FacilityCorpDesc^"+strFacility+"^"+strcombk_modtype);
	    						rs2 = DBUtils.executeQuery(strQuery2);
	    						if(rs2.next())
	    						{
	    							str_Loantype=Helper.correctNull(rs2.getString("com_facility_loantype"));
	    							strHeadfac=Helper.correctNull(rs2.getString("com_headfac"));
	    						}
	    					}
	    	    			if(rs2!=null)
	        	    		{
	        	    			rs2.close();
	        	    		}
	    	    			//if od Limit or Outstanding which ever is higher for cr
	    	    			//if dr limit
	    	    			if(str_Loantype.equalsIgnoreCase("TL")||str_Loantype.equalsIgnoreCase("DL"))
	    	    			{
	    	    				if(strHeadfac.equalsIgnoreCase("1"))
	    	    				{
	    	    					dblExposure=dblExposure/50;
	    	    				}
	    	    				dbl_grpexinonfundostot+=dblExposure;
	    	    				
	    	    			}
	    	    			else
	    	    			{
	    	    				if(strBaltype.equalsIgnoreCase("DR"))
		    	    			{
	    	    					if(dblLimit>dblOs)
	    	    					{
	    	    						if(strHeadfac.equalsIgnoreCase("1"))
	    	    	    				{
	    	    							dblLimit=dblLimit/50;
	    	    	    				}
	    	    						dbl_grpexinonfundostot+=dblLimit;
	    	    					}else
	    	    					{
	    	    						if(strHeadfac.equalsIgnoreCase("1"))
	    	    	    				{
	    	    							dblOs=dblOs/50;
	    	    	    				}
	    	    						dbl_grpexinonfundostot+=dblOs;
	    	    					}
	    	    				
	    	    				}else
	    	    				{
	    	    					if(strHeadfac.equalsIgnoreCase("1"))
		    	    				{
	    	    						dblLimit=dblLimit/50;
		    	    				}
	    	    					dbl_grpexinonfundostot+=dblLimit;
	    	    				}
	    	    			}
	    	    		}
	    	    		if(rs1!=null)
	    	    		{
	    	    			rs1.close();
	    	    		}
	    	    		dbl_totalexposureNonfund=dbl_grpexinonfundostot;
	            		arrExposureCol.add(String.valueOf(dbl_grpexinonfundostot));//2
	            		arrExposureCol.add("0.00");//3
	            		arrExposureCol.add(strApplicanttype);//4
	            	
	            		strQuery1=SQLParser.getSqlQuery("sel_lapsidfromlapsid^"+strApplnid);
	    	    		rs1=DBUtils.executeQuery(strQuery1);
	    	    		while(rs1.next())
	    	    		{
	    	    			strName=Helper.correctNull((String)rs1.getString("perapp_fname"));
	    	    		}
	    	    		if(rs1!=null)
	    	    		{
	    	    			rs1.close();
	    	    		}
	    	    		arrExposureCol.add(Helper.changetoTitlecase(strName));//5
	    	    		for(int k =0;k<arrBorrowerlist.size();k++)
	    	    		{
	    	    			if(Helper.correctNull((String)arrBorrowerlist.get(k)).equalsIgnoreCase(strApplnid))
	    	    			{
	    	    				arrExposureCol.add("Y");//6		
	    	    				strflag=false;
	    	    			}
	    	    		}
	    	    		if(strflag)
	    	    		{
	    	    			arrExposureCol.add("N");//6	
	    	    		}
	    	    		arrExposureCol.add(strApplnid);//7
	    	    		arrExposureCol.add(String.valueOf(dbl_totalexposurefund));//8
	    	    		arrExposureCol.add(String.valueOf(dbl_totalexposureNonfund));//9
	    	    		arrExposureRow.add(arrExposureCol);
	            }
    		}
   			
   			if(rs!=null)
    		{
    			rs.close();
    		}
   			rs=DBUtils.executeLAPSQuery("sel_prdDesc^"+strAppno);
			if(rs.next())
			{
				hshRecord.put("prd_applicablefor", Helper.correctNull((String)rs.getString("PRD_APPLICABLEFOR")));
			}
			//for proposed assets check 
			if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("sel_editApply_valuation^"+ strAppno);
    		rs = DBUtils.executeQuery(strQuery);
			while(rs.next()) 
			{
				if(Helper.correctNull((String)rs.getString("EDIT_APPLY_FLAG")).equalsIgnoreCase("N")){
					hshRecord.put("valuationFlag","N");
				}
			}
    			
			if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("sel_editApply_house^"+ strAppno);
    		rs = DBUtils.executeQuery(strQuery);
			while(rs.next()) 
			{
				if(Helper.correctNull((String)rs.getString("PHPA_EDIT_APPLYFLAG")).equalsIgnoreCase("N")){
					hshRecord.put("HouseEdit_Flag","N");
				}
			}
			
			if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("sel_editApply_vehicle^"+ strAppno);
    		rs = DBUtils.executeQuery(strQuery);
			while(rs.next()) 
			{
				if(Helper.correctNull((String)rs.getString("AUTO_EDIT_APPLYFLAG")).equalsIgnoreCase("N")){
					hshRecord.put("VehicleEdit_Flag","N");
				}
			}
   			hshRating=getRatingExposureretail(hshValues);
   			hshRecord.put("RatingExposureFund", String.valueOf((String)hshRating.get("RatingExposureFund")));
   			hshRecord.put("RatingExposureNonFund", String.valueOf((String)hshRating.get("RatingExposureNonFund")));
    		hshRecord.put("arrExposureRow",arrExposureRow);
    		hshRecord.put("dblRestrValFund",String.valueOf(dblRestrVal));
    		hshRecord.put("dblRestrValNF",String.valueOf(dblRestrValNF));
    	}
    	catch(Exception exception)
    	{
    		throw new EJBException("Error in getCollateralSecurityDisplaynew "+exception.toString());
    		
    	}
    	return hshRecord;
    	
    }
    
    public HashMap getCollateralSecurityDisplaynew(HashMap hshValues) 
    {
    	/*
    	 * 
    	 * This method is for corporate & agri module Security coverage 
    	 */
    	HashMap hshRecord=  new HashMap();
    	ResultSet rs = null,rs1=null,rs2=null,rs3=null;
    	String strQuery="",strAppno="",str_sec_id="",strApplicantid="",strQuery1="",strQuery2="",strApplnid="",strApplicanttype="",strQuery3="";
    	double dbl_exifundostot=0,dbl_exinonfundostot=0,dbl_propfundostot=0,dbl_propnonfundostot=0,dbl_propexisfndtot=0,dbl_propexisnonfndtot=0,
    	dbl_secexitot=0,dbl_secproptot=0,dbl_secpropcoverage=0,dbl_secexicoverage=0,dbl_grpexifundostot=0,dbl_grpexinonfundostot=0,dbl_GrpExpExiSubtotal=0,
    	dbl_secexiSubtot=0,dbl_secpropSubtot=0,dbl_Proposedexptot=0,dbl_totalexposurefund=0,dbl_totalexposureNonfund=0,dblETLExposure=0.0,dblEFCExposure=0.0,dblEWCExposure=0.0,dblPTLExposure=0.0,dblPFCExposure=0.0,dblPWCExposure=0.0;
    	String strAttachedSecurityid="",strBorrowercheckec="",strFlag="",strName="",strheadfac="";
    	String strCommonsecid="",strQuery4="";
    	ArrayList arrcol=new ArrayList();
    	ArrayList arrRow=new ArrayList();
    	ArrayList arrApplicantRow=new ArrayList();
    	ArrayList arrSecidRow = new ArrayList();
    	ArrayList arrSecidCol = new ArrayList();
    	ArrayList arrExposureRow = new ArrayList();
    	ArrayList arrExposureCol = new ArrayList();
		ArrayList arrSecidcommon = new ArrayList();
		ArrayList arrSecidcomRow = new ArrayList();
		ArrayList arrBorrowerlist = new ArrayList();
		ArrayList arrSecidExculsive = new ArrayList();
		ArrayList arrSectype = new ArrayList();
		HashMap hshSec = new HashMap(); 
    	String strValuesin=Helper.correctNull((String)hshValues.get("valuesin"));
    	java.text.NumberFormat nft= java.text.NumberFormat.getInstance();
    	nft= java.text.NumberFormat.getInstance();
		nft.setMaximumFractionDigits(2);
		nft.setMinimumFractionDigits(2);
		nft.setGroupingUsed(false);
		HashMap hshRating = new HashMap();
		
    	try
    	{	
    		int i=0,Count=0,strsecCount=0;
    		strAppno=Helper.correctNull((String)hshValues.get("appno"));
    		strApplicantid=Helper.correctNull((String)hshValues.get("hidapplicantid"));
    		if(strApplicantid.equalsIgnoreCase(""))
    		{
    			strApplicantid=Helper.correctNull((String)hshValues.get("appid"));		
    		}
    		arrApplicantRow.add(strApplicantid);
    		strQuery=SQLParser.getSqlQuery("SEL_COUNTAPPLI^"+strAppno);
    		rs=DBUtils.executeQuery(strQuery);
    		while(rs.next())
    		{
    			Count++;
    		}
    		if(rs!=null)
    		{
    			rs.close();
    		}
    		strQuery=SQLParser.getSqlQuery("sel_secexpoprom^"+strAppno+"^"+strAppno);
    		rs=DBUtils.executeQuery(strQuery);
    		while(rs.next())
    		{
    			strApplnid=Helper.correctNull((String)rs.getString("comapp_div_appid"));
    			if(!(strApplnid.equalsIgnoreCase("")))
    			{
    				arrApplicantRow.add(strApplnid);
    			}
    		}
    		if(rs!=null)
    		{
    			rs.close();
    		}
    		for(int l =0;l<arrApplicantRow.size();l++)
    		{
    			strApplnid=Helper.correctNull((String)arrApplicantRow.get(l));
    			if(strApplnid.equalsIgnoreCase(strApplicantid))
    			{
    				strApplicanttype="A";
    			}
    			else
    			{
    				strApplicanttype="O";
    			}
    			
    			if(strApplicanttype.equalsIgnoreCase("A"))
	    		{
    				String strSecid="";
    				
    				strQuery=SQLParser.getSqlQuery("sel_Securityidlist^"+strAppno+"^"+"P");
    	    		rs=DBUtils.executeQuery(strQuery);
    	    		while(rs.next())
	    	    	{
    	    			strSecid = Helper.correctNull(rs.getString("APP_SEC_SECID"));
    	    			boolean allow=true;
    	    			strQuery1=SQLParser.getSqlQuery("sel_Seccount^"+strAppno+"^"+strSecid+"^"+strApplnid);
        	    		rs1=DBUtils.executeQuery(strQuery1);
        	    		if(rs1.next())
    	    	    	{
        	    			strQuery2=SQLParser.getSqlQuery("sel_Securitydetails^"+strSecid+"^"+strAppno+"^P");
            	    		rs2=DBUtils.executeQuery(strQuery2);
            	    		while(rs2.next())
            	    		{
            	    			if(allow){
            	    				allow=false;
            	    			arrSecidcommon = new ArrayList();
    		        			arrSecidcommon.add(Helper.correctNull(rs2.getString("APP_SEC_SECID")));
    		        			arrSecidcommon.add("");
    		        			arrSecidcommon.add(Helper.correctNull(rs2.getString("CUS_SEC_TYPE")));
    		        			arrSecidcommon.add(Helper.correctNull(rs2.getString("CUS_SEC_NETSECURITY")));
    		        			
    		        			if(strCommonsecid.equalsIgnoreCase(""))
    		        			{
    		        				strCommonsecid="'"+Helper.correctNull(rs2.getString("APP_SEC_SECID"))+"'";
    		        			}else
    		        			{
    		        				strCommonsecid=strCommonsecid+",'"+Helper.correctNull(rs2.getString("APP_SEC_SECID"))+"'";
    		        			}
    		        			arrSecidcomRow.add(arrSecidcommon);
            	    		}
    		        			if(!(Helper.correctNull(rs2.getString("APP_SEC_CUSTOMERID")).equalsIgnoreCase(Helper.correctNull(rs2.getString("APP_SEC_BORROWER_ID")))))
    		        			{
    		        				if(!arrBorrowerlist.contains(Helper.correctNull(rs2.getString("APP_SEC_CUSTOMERID"))))
    		        				{
    		        					arrBorrowerlist.add(Helper.correctNull(rs2.getString("APP_SEC_CUSTOMERID")));
    		        				}
    		        			}
            	    		}
        	    		}
        	    		else
        	    		{
        	    			strQuery2=SQLParser.getSqlQuery("sel_Securitydetails^"+strSecid+"^"+strAppno+"^P");
            	    		rs2=DBUtils.executeQuery(strQuery2);
            	    		while(rs2.next())
            	    		{
	        	    			arrSecidExculsive = new ArrayList();
			        			arrSecidExculsive.add(Helper.correctNull(rs2.getString("APP_SEC_SECID")));
			        			arrSecidExculsive.add("");
			        			arrSecidExculsive.add(Helper.correctNull(rs2.getString("CUS_SEC_TYPE")));
			        			arrSecidExculsive.add(Helper.correctNull(rs2.getString("CUS_SEC_NETSECURITY")));
			        			if(strCommonsecid.equalsIgnoreCase(""))
    		        			{
    		        				strCommonsecid="'"+Helper.correctNull(rs2.getString("APP_SEC_SECID"))+"'";
    		        			}else
    		        			{
    		        				strCommonsecid=strCommonsecid+",'"+Helper.correctNull(rs2.getString("APP_SEC_SECID"))+"'";
    		        			}
			        			arrSecidRow.add(arrSecidExculsive);
            	    		}
        	    		}
	    	    	}
	        		hshValues.put("arrSecidRow",arrSecidRow);
	        		hshValues.put("arrSecidcomRow",arrSecidcomRow);
	        		arrSecidcomRow = new ArrayList();
	        		arrSecidRow = new ArrayList();
	        		
	        		strQuery=SQLParser.getSqlQuery("sel_Securitylistexisting^"+strAppno+"^"+strApplicantid+"^ ");
    	    		rs=DBUtils.executeQuery(strQuery);
    	    		while(rs.next())
	    	    	{
    	    			strSecid = Helper.correctNull(rs.getString("APP_SEC_SECID"));
    	    			boolean allow=true;
    	    			strQuery1=SQLParser.getSqlQuery("sel_Seccount^"+strAppno+"^"+strSecid+"^"+strApplnid);
        	    		rs1=DBUtils.executeQuery(strQuery1);
        	    		if(rs1.next())
    	    	    	{
        	    			strQuery2=SQLParser.getSqlQuery("sel_Securitydetails^"+strSecid+"^"+strAppno+"^E");
            	    		rs2=DBUtils.executeQuery(strQuery2);
            	    		while(rs2.next())
            	    		{
	            	    		if(allow)
	            	    		{
	            	    				allow=false;
	            	    			arrSecidcommon = new ArrayList();
	    		        			arrSecidcommon.add(Helper.correctNull(rs2.getString("APP_SEC_SECID")));
	    		        			arrSecidcommon.add("");
	    		        			arrSecidcommon.add(Helper.correctNull(rs2.getString("CUS_SEC_TYPE")));
	    		        			arrSecidcommon.add(Helper.correctNull(rs2.getString("CUS_SEC_NETSECURITY")));
	    		        			if(!(Helper.correctNull(rs2.getString("APP_SEC_CUSTOMERID")).equalsIgnoreCase(Helper.correctNull(rs2.getString("APP_SEC_BORROWER_ID")))))
	    		        			{
	    		        				if(!arrBorrowerlist.contains(Helper.correctNull(rs2.getString("APP_SEC_CUSTOMERID"))))
	    		        				{
	    		        					arrBorrowerlist.add(Helper.correctNull(rs2.getString("APP_SEC_CUSTOMERID")));
	    		        				}
	    		        			}
	    		        			if(strCommonsecid.equalsIgnoreCase(""))
	    		        			{
	    		        				strCommonsecid="'"+Helper.correctNull(rs2.getString("APP_SEC_SECID"))+"'";
	    		        			}else
	    		        			{
	    		        				strCommonsecid=strCommonsecid+",'"+Helper.correctNull(rs2.getString("APP_SEC_SECID"))+"'";
	    		        			}
	    		        			arrSecidcomRow.add(arrSecidcommon);
	            	    		}
	            	    		if(!(Helper.correctNull(rs2.getString("APP_SEC_CUSTOMERID")).equalsIgnoreCase(Helper.correctNull(rs2.getString("APP_SEC_BORROWER_ID")))))
    		        			{
	            	    			if(!arrBorrowerlist.contains(Helper.correctNull(rs2.getString("APP_SEC_CUSTOMERID"))))
    		        				{
	            	    				arrBorrowerlist.add(Helper.correctNull(rs2.getString("APP_SEC_CUSTOMERID")));
    		        				}
    		        			}
            	    		}
        	    		}
        	    		else
        	    		{
        	    			strQuery2=SQLParser.getSqlQuery("sel_Securitydetails^"+strSecid+"^"+strAppno+"^E");
            	    		rs2=DBUtils.executeQuery(strQuery2);
            	    		while(rs2.next())
            	    		{
	        	    			arrSecidExculsive = new ArrayList();
			        			arrSecidExculsive.add(Helper.correctNull(rs2.getString("APP_SEC_SECID")));
			        			arrSecidExculsive.add("");
			        			arrSecidExculsive.add(Helper.correctNull(rs2.getString("CUS_SEC_TYPE")));
			        			arrSecidExculsive.add(Helper.correctNull(rs2.getString("CUS_SEC_NETSECURITY")));
			        			if(strCommonsecid.equalsIgnoreCase(""))
    		        			{
    		        				strCommonsecid="'"+Helper.correctNull(rs2.getString("APP_SEC_SECID"))+"'";
    		        			}else
    		        			{
    		        				strCommonsecid=strCommonsecid+",'"+Helper.correctNull(rs2.getString("APP_SEC_SECID"))+"'";
    		        			}
			        			arrSecidRow.add(arrSecidExculsive);
            	    		}
        	    		}
	        			
	    	    	}
	        		hshValues.put("arrExisidExc",arrSecidRow);
	        		hshValues.put("arrExisecidcom",arrSecidcomRow);
	        		hshSec=getSum(hshValues);
	        		strAttachedSecurityid=Helper.correctNull((String)hshSec.get("strSecId"));
	        		strFlag=Helper.correctNull((String)hshSec.get("strFlag"));
	        		strBorrowercheckec="'"+strApplnid+"'";
	        		hshRecord.put("Securities",hshSec.get("arrValueRow"));
	        		hshRecord.put("strFlag",strFlag);
	        		

    				arrExposureCol = new ArrayList();
    				dbl_exifundostot=0;
    				dbl_totalexposurefund=0;
    				dbl_totalexposureNonfund=0;
    				//for taking Existing funded 
    	    		String strcombk_modtype="",str_Loantype="",strFacility = null,strBaltype="";
    	    		double dblExposure=0,dblOs=0,dblLimit=0;
    	    		String strfundtype="'F'";
    	    		strQuery1=SQLParser.getSqlQuery("sel_combkfundednon^"+strAppno+"^"+strAppno+"^"+strfundtype);
    	    		rs1=DBUtils.executeQuery(strQuery1);
    	    		while(rs1.next())
    	    		{
    	    			str_Loantype="";
    	    			strheadfac="";
    	    			strcombk_modtype=Helper.correctNull((String)rs1.getString("combk_modtype"));
    	    			strFacility=Helper.correctNull((String)rs1.getString("combk_facility"));
    	    			strBaltype=Helper.correctNull((String)rs1.getString("combk_baltype"));
    	    			dblExposure=Double.parseDouble(Helper.correctDouble((String)rs1.getString("com_exposure")));
    	    			dblOs=Double.parseDouble(Helper.correctDouble((String)rs1.getString("combk_os")));
    	    			dblLimit=Double.parseDouble(Helper.correctDouble((String)rs1.getString("combk_limit")));
    	    			String[] strFacilityArr=strFacility.split("~");
    	    			if(strcombk_modtype.equalsIgnoreCase("p") || strcombk_modtype.equalsIgnoreCase("r"))
    					{
    						strQuery2=SQLParser.getSqlQuery("sel_retProductDesc^"+strFacilityArr[0]);
    						rs2 = DBUtils.executeQuery(strQuery2);
    						if(rs2.next())
    						{
    							str_Loantype=Helper.correctNull(rs2.getString("PRD_LOANTYPE"));
    						}
    					}
    					else
    					{
    						strQuery2=SQLParser.getSqlQuery("sel_FacilityCorpDesc^"+Helper.correctInt(strFacilityArr[0])+"^"+strcombk_modtype);
    						rs2 = DBUtils.executeQuery(strQuery2);
    						if(rs2.next())
    						{
    							str_Loantype=Helper.correctNull(rs2.getString("com_facility_loantype"));
    							strheadfac=Helper.correctNull(rs2.getString("com_headfac"));
    							
    						}
    					}
    	    			if(rs2!=null)
        	    		{
        	    			rs2.close();
        	    		}
    	    			
    	    			if(str_Loantype.equalsIgnoreCase("TL")||str_Loantype.equalsIgnoreCase("DL"))
    	    			{
    	    				if(strheadfac.equalsIgnoreCase("1"))
    	    				{
    	    					dblEFCExposure+=(dblExposure/50);
    	    				}
    	    				else
    	    				{
    	    					dblETLExposure+=dblExposure;
    	    				}
    	    			}
    	    			else
    	    			{
    	    				if(strBaltype.equalsIgnoreCase("DR"))
    	    				{
    	    					if(dblLimit>dblOs)
    	    					{
    	    						if(strheadfac.equalsIgnoreCase("1"))
    	    	    				{
    	    							dblEFCExposure+=(dblLimit/50);
    	    	    				}
    	    						else
    	    						{
    	    							dblEWCExposure+=dblLimit;
    	    						}
    	    					}else
    	    					{
    	    						if(strheadfac.equalsIgnoreCase("1"))
    	    	    				{
    	    							dblEFCExposure+=(dblOs/50);
    	    	    				}
    	    						else
    	    						{
    	    							dblEWCExposure+=dblOs;
    	    						}
    	    					}
    	    				}
    	    				else
    	    				{
    	    					if(strheadfac.equalsIgnoreCase("1"))
	    	    				{
    	    						dblEFCExposure+=(dblLimit/50);
	    	    				}
    	    					else
	    						{
    	    						dblEWCExposure+=dblLimit;
	    						}
    	    				}
    	    			}
    	    			//if od Limit or Outstanding which ever is higher for cr
    	    			//if dr limit
    	    			if(str_Loantype.equalsIgnoreCase("TL"))
    	    			{
    	    				if(strheadfac.equalsIgnoreCase("1"))
    	    				{
    	    					dblExposure=dblExposure/50;
    	    				}
    	    				dbl_exifundostot+=dblExposure;
    	    				
    	    			}
    	    			else
    	    			{
    	    				if(strBaltype.equalsIgnoreCase("DR"))
    	    				{
    	    					if(dblLimit>dblOs)
    	    					{
    	    						if(strheadfac.equalsIgnoreCase("1"))
    	    	    				{
    	    							dblLimit=dblLimit/50;
    	    	    				}
    	    						dbl_exifundostot+=dblLimit;
    	    					}else
    	    					{
    	    						if(strheadfac.equalsIgnoreCase("1"))
    	    	    				{
    	    							dblOs=dblOs/50;
    	    	    				}
    	    						dbl_exifundostot+=dblOs;
    	    					}
    	    				}else
    	    				{
    	    					if(strheadfac.equalsIgnoreCase("1"))
	    	    				{
    	    						dblLimit=dblLimit/50;
	    	    				}
    	    					dbl_exifundostot+=dblLimit;
    	    				}
    	    			}
    	    			
    	    		}
    	    		
    	    		
    	    		if(rs1!=null)
    	    		{
    	    			rs1.close();
    	    		}
    	    		
    	    		dbl_propfundostot=0;
    	    		dbl_propexisfndtot=0;
    	    		String strFaccode="";
    	    		strQuery1=SQLParser.getSqlQuery("selfacilitylistnew^"+strAppno+"^0^F");
    	    		rs1=DBUtils.executeQuery(strQuery1);
    	    		while(rs1.next())
    	    		{
    	    			strheadfac="";String strLoantype="";
    	    			strFaccode=Helper.correctNull((String)rs1.getString("facility_code"));
    	    			strQuery2=SQLParser.getSqlQuery("selectFacilityHeadFacandSubFac_facilitycorp^"+strFaccode);
						rs2 = DBUtils.executeQuery(strQuery2);
						if(rs2.next())
						{
							strheadfac=Helper.correctNull((String)rs2.getString("com_headfac"));
							strLoantype=Helper.correctNull(rs2.getString("com_facility_loantype"));
						}
						if(strheadfac.equalsIgnoreCase("1"))
	    				{
							dbl_propfundostot+=Double.parseDouble(Helper.correctDouble((String)rs1.getString("facility_proposed")))/50;
	    	    			dbl_propexisfndtot+=Double.parseDouble(Helper.correctDouble((String)rs1.getString("FACILITY_EXISTING")))/50;
	    	    			
	    	    			dblPFCExposure+=Double.parseDouble(Helper.correctDouble((String)rs1.getString("facility_proposed")))/50;
	    	    			dblEFCExposure+=Double.parseDouble(Helper.correctDouble((String)rs1.getString("FACILITY_EXISTING")))/50;
	    				}
						else
						{
							dbl_propfundostot+=Double.parseDouble(Helper.correctDouble((String)rs1.getString("facility_proposed")));
							dbl_propexisfndtot+=Double.parseDouble(Helper.correctDouble((String)rs1.getString("FACILITY_EXISTING")));
							
							if(strLoantype.equalsIgnoreCase("TL")||strLoantype.equalsIgnoreCase("DL"))
							{
								dblPTLExposure+=Double.parseDouble(Helper.correctDouble((String)rs1.getString("facility_proposed")));
								dblETLExposure+=Double.parseDouble(Helper.correctDouble((String)rs1.getString("FACILITY_EXISTING")));
							}
							else
							{
								dblPWCExposure+=Double.parseDouble(Helper.correctDouble((String)rs1.getString("facility_proposed")));
								dblEWCExposure+=Double.parseDouble(Helper.correctDouble((String)rs1.getString("FACILITY_EXISTING")));
							}
						}
						
    	    		}
    	    		if(rs1!=null)
    	    		{
    	    			rs1.close();
    	    		}
    	    		dbl_totalexposurefund=dbl_exifundostot+dbl_propfundostot;
    	    		dbl_exifundostot=dbl_exifundostot+dbl_propexisfndtot;//for taking proposed exposure incase of renwal
    	    		//dbl_totalexposurefund=dbl_exifundostot+dbl_propfundostot;
    	    		arrExposureCol.add(String.valueOf(dbl_exifundostot));//0
    	    		arrExposureCol.add(String.valueOf(dbl_propfundostot));//1
    	    		
    	    		dbl_exinonfundostot=0;
    	    		//for taking the existing non funded 
    	    		strcombk_modtype="";str_Loantype="";strFacility = null;strBaltype="";
    	    		dblExposure=0;dblOs=0;dblLimit=0;
    	    		String strnonfundtype="'N','NF'";
    	    		strQuery1=SQLParser.getSqlQuery("sel_combkfundednon^"+strAppno+"^"+strAppno+"^"+strnonfundtype);
    	    		rs1=DBUtils.executeQuery(strQuery1);
    	    		while(rs1.next())
    	    		{
    	    			str_Loantype="";
    	    			strheadfac="";
    	    			strcombk_modtype=Helper.correctNull((String)rs1.getString("combk_modtype"));
    	    			strFacility=Helper.correctNull((String)rs1.getString("combk_facility"));
    	    			strBaltype=Helper.correctNull((String)rs1.getString("combk_baltype"));
    	    			dblExposure=Double.parseDouble(Helper.correctDouble((String)rs1.getString("com_exposure")));
    	    			dblOs=Double.parseDouble(Helper.correctDouble((String)rs1.getString("combk_os")));
    	    			dblLimit=Double.parseDouble(Helper.correctDouble((String)rs1.getString("combk_limit")));
    	    			String[] strFacilityArr=strFacility.split("~");
    	    			if(strcombk_modtype.equalsIgnoreCase("p") || strcombk_modtype.equalsIgnoreCase("r"))
    					{
    						strQuery2=SQLParser.getSqlQuery("sel_retProductDesc^"+strFacilityArr[0]);
    						rs2 = DBUtils.executeQuery(strQuery2);
    						if(rs2.next())
    						{
    							str_Loantype=Helper.correctNull(rs2.getString("PRD_LOANTYPE"));
    						}
    					}
    					else
    					{
    						strQuery2=SQLParser.getSqlQuery("sel_FacilityCorpDesc^"+Helper.correctInt(strFacilityArr[0])+"^"+strcombk_modtype);
    						rs2 = DBUtils.executeQuery(strQuery2);
    						if(rs2.next())
    						{
    							str_Loantype=Helper.correctNull(rs2.getString("com_facility_loantype"));
    							strheadfac=Helper.correctNull(rs2.getString("com_headfac"));
    						}
    					}
    	    			if(rs2!=null)
        	    		{
        	    			rs2.close();
        	    		}
    	    			/*********/
    	    			
    	    			if(str_Loantype.equalsIgnoreCase("TL")||str_Loantype.equalsIgnoreCase("DL"))
    	    			{
    	    				if(strheadfac.equalsIgnoreCase("1"))
    	    				{
    	    					dblEFCExposure+=(dblExposure/50);
    	    				}
    	    				else
    	    				{
    	    					dblETLExposure+=dblExposure;
    	    				}
    	    			}
    	    			else
    	    			{
    	    				if(strBaltype.equalsIgnoreCase("DR"))
    	    				{
    	    					if(dblLimit>dblOs)
    	    					{
    	    						if(strheadfac.equalsIgnoreCase("1"))
    	    	    				{
    	    							dblEFCExposure+=(dblLimit/50);
    	    	    				}
    	    						else
    	    						{
    	    							dblEWCExposure+=dblLimit;
    	    						}
    	    					}else
    	    					{
    	    						if(strheadfac.equalsIgnoreCase("1"))
    	    	    				{
    	    							dblEFCExposure+=(dblOs/50);
    	    	    				}
    	    						else
    	    						{
    	    							dblEWCExposure+=dblOs;
    	    						}
    	    					}
    	    				}
    	    				else
    	    				{
    	    					if(strheadfac.equalsIgnoreCase("1"))
	    	    				{
    	    						dblEFCExposure+=(dblLimit/50);
	    	    				}
    	    					else
	    						{
    	    						dblEWCExposure+=dblLimit;
	    						}
    	    				}
    	    			}
    	    			/**************/
    	    			
    	    			//if od Limit or Outstanding which ever is higher for cr
    	    			//if dr limit
    	    			if(str_Loantype.equalsIgnoreCase("TL")||str_Loantype.equalsIgnoreCase("DL"))
    	    			{
    	    				if(strheadfac.equalsIgnoreCase("1"))
    	    				{
    	    					dblExposure=dblExposure/50;
    	    				}
    	    				dbl_exinonfundostot+=dblExposure;
    	    			}
    	    			else
    	    			{
    	    				if(strBaltype.equalsIgnoreCase("DR"))
    	    				{
    	    					if(dblLimit>dblOs)
    	    					{
    	    						if(strheadfac.equalsIgnoreCase("1"))
    	    	    				{
    	    							dblLimit=dblLimit/50;
    	    	    				}
    	    						dbl_exinonfundostot+=dblLimit;
    	    					}else
    	    					{
    	    						if(strheadfac.equalsIgnoreCase("1"))
    	    	    				{
    	    							dblOs=dblOs/50;
    	    	    				}
    	    						dbl_exinonfundostot+=dblOs;
    	    					}
    	    				}else
    	    				{
    	    					if(strheadfac.equalsIgnoreCase("1"))
	    	    				{
    	    						dblLimit=dblLimit/50;
	    	    				}
    	    					dbl_exinonfundostot+=dblLimit;
    	    				}
    	    			}
    	    		}
    	    		
    	    		if(rs1!=null)
    	    		{
    	    			rs1.close();
    	    		}
    	    		dbl_propnonfundostot=0;
    	    		dbl_propexisnonfndtot=0;
    	    		strQuery1=SQLParser.getSqlQuery("selfacilitylistnew^"+strAppno+"^0^NF");
    	    		rs1=DBUtils.executeQuery(strQuery1);
    	    		while(rs1.next())
    	    		{
    	    			strheadfac="";String strLoantype="";
    	    			strFaccode=Helper.correctNull((String)rs1.getString("facility_code"));
    	    			strQuery2=SQLParser.getSqlQuery("selectFacilityHeadFacandSubFac_facilitycorp^"+strFaccode);
						rs2 = DBUtils.executeQuery(strQuery2);
						if(rs2.next())
						{
							strheadfac=Helper.correctNull((String)rs2.getString("com_headfac"));
							strLoantype=Helper.correctNull(rs2.getString("com_facility_loantype"));
						}
						if(strheadfac.equalsIgnoreCase("1"))
	    				{
							dbl_propnonfundostot+=Double.parseDouble(Helper.correctDouble((String)rs1.getString("facility_proposed")))/50;
	    	    			dbl_propexisnonfndtot+=Double.parseDouble(Helper.correctDouble((String)rs1.getString("FACILITY_EXISTING")))/50;
	    				}
						else
						{
							dbl_propnonfundostot+=Double.parseDouble(Helper.correctDouble((String)rs1.getString("facility_proposed")));
	    	    			dbl_propexisnonfndtot+=Double.parseDouble(Helper.correctDouble((String)rs1.getString("FACILITY_EXISTING")));
	    	    			
	    	    			if(strLoantype.equalsIgnoreCase("TL")||strLoantype.equalsIgnoreCase("DL"))
							{
								dblPTLExposure+=Double.parseDouble(Helper.correctDouble((String)rs1.getString("facility_proposed")));
								dblETLExposure+=Double.parseDouble(Helper.correctDouble((String)rs1.getString("FACILITY_EXISTING")));
							}
							else
							{
								dblPWCExposure+=Double.parseDouble(Helper.correctDouble((String)rs1.getString("facility_proposed")));
								dblEWCExposure+=Double.parseDouble(Helper.correctDouble((String)rs1.getString("FACILITY_EXISTING")));
							}
						}
					}
    	    		if(rs1!=null)
    	    		{
    	    			rs1.close();
    	    		}
    	    		dbl_totalexposureNonfund=dbl_propnonfundostot+dbl_exinonfundostot;
    	    		dbl_exinonfundostot=dbl_exinonfundostot+dbl_propexisnonfndtot;
    	    	//	dbl_totalexposureNonfund=dbl_exinonfundostot+dbl_propnonfundostot;
    	    		arrExposureCol.add(String.valueOf(dbl_exinonfundostot));//2
    	    		arrExposureCol.add(String.valueOf(dbl_propnonfundostot));//3
    	    		arrExposureCol.add(strApplicanttype);//4
    	    		strQuery1=SQLParser.getSqlQuery("sel_lapsidfromlapsid^"+strApplnid);
    	    		rs1=DBUtils.executeQuery(strQuery1);
    	    		while(rs1.next())
    	    		{
    	    			strName=Helper.correctNull((String)rs1.getString("perapp_fname"));
    	    		}
    	    		if(rs1!=null)
    	    		{
    	    			rs1.close();
    	    		}
    	    		arrExposureCol.add(Helper.changetoTitlecase(strName));//5
    	    		arrExposureCol.add(strFlag);//6
    	    		arrExposureCol.add(strApplnid);//7
    	    		arrExposureCol.add(String.valueOf(dbl_totalexposurefund));//8
    	    		arrExposureCol.add(String.valueOf(dbl_totalexposureNonfund));//9
    	    		
    	    		arrExposureCol.add(String.valueOf(dblPTLExposure));//10
    	    		arrExposureCol.add(String.valueOf(dblETLExposure));//11
    	    		arrExposureCol.add(String.valueOf(dblPWCExposure));//12
    	    		arrExposureCol.add(String.valueOf(dblEWCExposure));//13
    	    		arrExposureCol.add(String.valueOf(dblPFCExposure));//14
    	    		arrExposureCol.add(String.valueOf(dblEFCExposure));//15
    	    		arrExposureRow.add(arrExposureCol);
				}
    			else
	    		{
	    				arrSecidcomRow=new ArrayList();
	    				arrSecidRow=new ArrayList();
	    				String strRemainingborrower="";
	    				hshSec = new HashMap();
	    			
	    			String strquery4="and APP_SEC_SECID not in  ("+strCommonsecid+")";
	    			if(!(strCommonsecid.equalsIgnoreCase("")))
	    			{
	    				strquery4="and APP_SEC_SECID not in  ("+strCommonsecid+")";
	    			}
	    			else
	    			{
	    				strquery4=" ";
	    			}
	    				strQuery=SQLParser.getSqlQuery("sel_Securitylistexisting^"+strAppno+"^"+strApplicantid+"^"+strquery4);
	    	    		rs=DBUtils.executeQuery(strQuery);
	    	    		while(rs.next())
		    	    	{

	    	    			String strSecid = Helper.correctNull(rs.getString("APP_SEC_SECID"));
	    	    			strQuery1=SQLParser.getSqlQuery("sel_Seccount^"+strAppno+"^"+strSecid+"^"+strApplnid);
	        	    		rs1=DBUtils.executeQuery(strQuery1);
	        	    		if(rs1.next())
	    	    	    	{
	        	    			strQuery2=SQLParser.getSqlQuery("sel_Securitydetails^"+strSecid+"^"+strAppno+"^E");
	            	    		rs2=DBUtils.executeQuery(strQuery2);
	            	    		while(rs2.next())
	            	    		{
	            	    			arrSecidcommon = new ArrayList();
	    		        			arrSecidcommon.add(Helper.correctNull(rs2.getString("APP_SEC_SECID")));
	    		        			arrSecidcommon.add("");
	    		        			arrSecidcommon.add(Helper.correctNull(rs2.getString("CUS_SEC_TYPE")));
	    		        			arrSecidcommon.add(Helper.correctNull(rs2.getString("CUS_SEC_NETSECURITY")));
	    		        			arrSecidcommon.add(Helper.correctNull(rs2.getString("APP_SEC_CUSTOMERID")));
	    		        			if(strCommonsecid.equalsIgnoreCase(""))
	    		        			{
	    		        				strCommonsecid="'"+Helper.correctNull(rs2.getString("APP_SEC_SECID"))+"'";
	    		        			}else
	    		        			{
	    		        				strCommonsecid=strCommonsecid+",'"+Helper.correctNull(rs2.getString("APP_SEC_SECID"))+"'";
	    		        			}
	    		        			arrSecidcomRow.add(arrSecidcommon);
	            	    		}
	        	    		}
	        	    		else
	        	    		{
	        	    			strQuery2=SQLParser.getSqlQuery("sel_Securitydetails^"+strSecid+"^"+strAppno+"^E");
	            	    		rs2=DBUtils.executeQuery(strQuery2);
	            	    		while(rs2.next())
	            	    		{
		        	    			arrSecidExculsive = new ArrayList();
				        			arrSecidExculsive.add(Helper.correctNull(rs2.getString("APP_SEC_SECID")));
				        			arrSecidExculsive.add("");
				        			arrSecidExculsive.add(Helper.correctNull(rs2.getString("CUS_SEC_TYPE")));
				        			arrSecidExculsive.add(Helper.correctNull(rs2.getString("CUS_SEC_NETSECURITY")));
				        			arrSecidExculsive.add(Helper.correctNull(rs2.getString("APP_SEC_CUSTOMERID")));
				        			if(strCommonsecid.equalsIgnoreCase(""))
	    		        			{
	    		        				strCommonsecid="'"+Helper.correctNull(rs2.getString("APP_SEC_SECID"))+"'";
	    		        			}else
	    		        			{
	    		        				strCommonsecid=strCommonsecid+",'"+Helper.correctNull(rs2.getString("APP_SEC_SECID"))+"'";
	    		        			}
				        			arrSecidRow.add(arrSecidExculsive);
	            	    		}
	        	    		}
	        	    	}
	    				
	    	    		hshValues.put("arrExisidExc",arrSecidRow);
		        		hshValues.put("arrExisecidcom",arrSecidcomRow);
		        		hshValues.put("strAttachedSecurityid",strAttachedSecurityid);
		        		hshSec=getSumoth(hshValues);
		        		if(!strFlag.equalsIgnoreCase("EC"))
		        		{
		        			strFlag=Helper.correctNull((String)hshSec.get("strFlag"));
		        		}
		        		strAttachedSecurityid=Helper.correctNull((String)hshSec.get("strSecId"));
		        		hshRecord.put("Securities"+l,hshSec.get("arrValueRow"));
		        		if(!strFlag.equalsIgnoreCase(""))
		        		{
		        			hshRecord.put("strFlag",strFlag);
		        		}

	    				arrExposureCol = new ArrayList();
	    				dbl_grpexifundostot=0;
	    				dbl_grpexinonfundostot=0;
	    				dbl_totalexposurefund=0;
	    				dbl_totalexposureNonfund=0;
	    				dblETLExposure=0.0;dblEFCExposure=0.0;dblEWCExposure=0.0;dblPTLExposure=0.0;dblPFCExposure=0.0;dblPWCExposure=0.0;
	    				String strcombk_modtype="",str_Loantype="",strFacility = null,strBaltype="";
	    	    		double dblExposure=0.00,dblOs=0.00,dblLimit=0.00;
	    	    		strQuery1=SQLParser.getSqlQuery("sel_comgcfundednon^"+strAppno+"^"+strApplnid+"^"+strApplnid+"^F");
	    	    		rs1=DBUtils.executeQuery(strQuery1);
	    	    		while(rs1.next())
	    	    		{
	    	    			str_Loantype="";
	    	    			strheadfac="";
	    	    			strcombk_modtype=Helper.correctNull((String)rs1.getString("comgc_modtype"));
	    	    			strFacility=Helper.correctNull((String)rs1.getString("comgc_facility"));
	    	    			strBaltype=Helper.correctNull((String)rs1.getString("comgc_baltype"));
	    	    			dblExposure=Double.parseDouble(Helper.correctDouble((String)rs1.getString("comgc_exposure")));
	    	    			dblOs=Double.parseDouble(Helper.correctDouble((String)rs1.getString("comgc_os")));
	    	    			dblLimit=Double.parseDouble(Helper.correctDouble((String)rs1.getString("comgc_limit")));
	    	    			if(strcombk_modtype.equalsIgnoreCase("p") || strcombk_modtype.equalsIgnoreCase("r"))
	    					{
	    						strQuery2=SQLParser.getSqlQuery("sel_retProductDesc^"+strFacility);
	    						rs2 = DBUtils.executeQuery(strQuery2);
	    						if(rs2.next())
	    						{
	    							str_Loantype=Helper.correctNull(rs2.getString("PRD_LOANTYPE"));
	    						}
	    					}
	    					else
	    					{
	    						strQuery2=SQLParser.getSqlQuery("sel_FacilityCorpDesc^"+strFacility+"^"+strcombk_modtype);
	    						rs2 = DBUtils.executeQuery(strQuery2);
	    						if(rs2.next())
	    						{
	    							str_Loantype=Helper.correctNull(rs2.getString("com_facility_loantype"));
	    							strheadfac=Helper.correctNull(rs2.getString("com_headfac"));
	    						}
	    					}
	    	    			if(rs2!=null)
	        	    		{
	        	    			rs2.close();
	        	    		}
	    	    			/************/
	    	    			
	    	    			if(str_Loantype.equalsIgnoreCase("TL")||str_Loantype.equalsIgnoreCase("DL"))
	    	    			{
	    	    				if(strheadfac.equalsIgnoreCase("1"))
	    	    				{
	    	    					dblEFCExposure+=(dblExposure/50);
	    	    				}
	    	    				else
	    	    				{
	    	    					dblETLExposure+=dblExposure;
	    	    				}
	    	    			}
	    	    			else
	    	    			{
	    	    				if(strBaltype.equalsIgnoreCase("DR"))
	    	    				{
	    	    					if(dblLimit>dblOs)
	    	    					{
	    	    						if(strheadfac.equalsIgnoreCase("1"))
	    	    	    				{
	    	    							dblEFCExposure+=(dblLimit/50);
	    	    	    				}
	    	    						else
	    	    						{
	    	    							dblEWCExposure+=dblLimit;
	    	    						}
	    	    					}else
	    	    					{
	    	    						if(strheadfac.equalsIgnoreCase("1"))
	    	    	    				{
	    	    							dblEFCExposure+=(dblOs/50);
	    	    	    				}
	    	    						else
	    	    						{
	    	    							dblEWCExposure+=dblOs;
	    	    						}
	    	    					}
	    	    				}
	    	    				else
	    	    				{
	    	    					if(strheadfac.equalsIgnoreCase("1"))
		    	    				{
	    	    						dblEFCExposure+=(dblLimit/50);
		    	    				}
	    	    					else
		    						{
	    	    						dblEWCExposure+=dblLimit;
		    						}
	    	    				}
	    	    			}
	    	    			
	    	    			/***********/
	    	    			//if od Limit or Outstanding which ever is higher for cr
	    	    			//if dr limit should be taken
	    	    			if(str_Loantype.equalsIgnoreCase("TL")||str_Loantype.equalsIgnoreCase("DL"))
	    	    			{
	    	    				if(strheadfac.equalsIgnoreCase("1"))
	    	    				{
	    	    					dblExposure=dblExposure/50;
	    	    				}
	    	    				dbl_grpexifundostot+=dblExposure;
	    	    			}
	    	    			else
	    	    			{
	    	    				if(strBaltype.equalsIgnoreCase("DR"))
	    	    				{
	    	    					if(dblLimit>dblOs)
	    	    					{
	    	    						if(strheadfac.equalsIgnoreCase("1"))
	    	    	    				{
	    	    							dblLimit=dblLimit/50;
	    	    	    				}
	    	    						dbl_grpexifundostot+=dblLimit;
	    	    					}else
	    	    					{
	    	    						if(strheadfac.equalsIgnoreCase("1"))
	    	    	    				{
	    	    							dblOs=dblOs/50;
	    	    	    				}
	    	    						dbl_grpexifundostot+=dblOs;
	    	    					}
	    	    				}else
	    	    				{
	    	    					if(strheadfac.equalsIgnoreCase("1"))
    	    	    				{
	    	    						dblLimit=dblLimit/50;
    	    	    				}
	    	    					dbl_grpexifundostot+=dblLimit;
	    	    				}
	    	    			}
	    	    		}
	    	    		if(rs1!=null)
	    	    		{
	    	    			rs1.close();
	    	    		}
	    	    		dbl_totalexposurefund=dbl_grpexifundostot;
	    	    		arrExposureCol.add(String.valueOf(dbl_grpexifundostot));//0
	            		arrExposureCol.add("0.00");//1
	            		boolean strflag=true;
	            		//for taking the existing non funded 
	    	    		strcombk_modtype="";str_Loantype="";strFacility = "";strBaltype="";
	    	    		dblExposure=0;dblOs=0;dblLimit=0;
	    	    		strQuery1=SQLParser.getSqlQuery("sel_comgcfundednon^"+strAppno+"^"+strApplnid+"^"+strApplnid+"^N");
	    	    		rs1=DBUtils.executeQuery(strQuery1);
	    	    		while(rs1.next())
	    	    		{
	    	    			str_Loantype="";
	    	    			strheadfac="";
	    	    			strcombk_modtype=Helper.correctNull((String)rs1.getString("comgc_modtype"));
	    	    			strFacility=Helper.correctNull((String)rs1.getString("comgc_facility"));
	    	    			strBaltype=Helper.correctNull((String)rs1.getString("comgc_baltype"));
	    	    			dblExposure=Double.parseDouble(Helper.correctDouble((String)rs1.getString("comgc_exposure")));
	    	    			dblOs=Double.parseDouble(Helper.correctDouble((String)rs1.getString("comgc_os")));
	    	    			dblLimit=Double.parseDouble(Helper.correctDouble((String)rs1.getString("comgc_limit")));
	    	    			if(strcombk_modtype.equalsIgnoreCase("p") || strcombk_modtype.equalsIgnoreCase("r"))
	    					{
	    						strQuery2=SQLParser.getSqlQuery("sel_retProductDesc^"+strFacility);
	    						rs2 = DBUtils.executeQuery(strQuery2);
	    						if(rs2.next())
	    						{
	    							str_Loantype=Helper.correctNull(rs2.getString("PRD_LOANTYPE"));
	    						}
	    					}
	    					else
	    					{
	    						strQuery2=SQLParser.getSqlQuery("sel_FacilityCorpDesc^"+strFacility+"^"+strcombk_modtype);
	    						rs2 = DBUtils.executeQuery(strQuery2);
	    						if(rs2.next())
	    						{
	    							str_Loantype=Helper.correctNull(rs2.getString("com_facility_loantype"));
	    							strheadfac=Helper.correctNull(rs2.getString("com_headfac"));
	    						}
	    					}
	    	    			if(rs2!=null)
	        	    		{
	        	    			rs2.close();
	        	    		}
	    	    			
	    	    			/*************/
	    	    			
	    	    			if(str_Loantype.equalsIgnoreCase("TL")||str_Loantype.equalsIgnoreCase("DL"))
	    	    			{
	    	    				if(strheadfac.equalsIgnoreCase("1"))
	    	    				{
	    	    					dblEFCExposure+=(dblExposure/50);
	    	    				}
	    	    				else
	    	    				{
	    	    					dblETLExposure+=dblExposure;
	    	    				}
	    	    			}
	    	    			else
	    	    			{
	    	    				if(strBaltype.equalsIgnoreCase("DR"))
	    	    				{
	    	    					if(dblLimit>dblOs)
	    	    					{
	    	    						if(strheadfac.equalsIgnoreCase("1"))
	    	    	    				{
	    	    							dblEFCExposure+=(dblLimit/50);
	    	    	    				}
	    	    						else
	    	    						{
	    	    							dblEWCExposure+=dblLimit;
	    	    						}
	    	    					}else
	    	    					{
	    	    						if(strheadfac.equalsIgnoreCase("1"))
	    	    	    				{
	    	    							dblEFCExposure+=(dblOs/50);
	    	    	    				}
	    	    						else
	    	    						{
	    	    							dblEWCExposure+=dblOs;
	    	    						}
	    	    					}
	    	    				}
	    	    				else
	    	    				{
	    	    					if(strheadfac.equalsIgnoreCase("1"))
		    	    				{
	    	    						dblEFCExposure+=(dblLimit/50);
		    	    				}
	    	    					else
		    						{
	    	    						dblEWCExposure+=dblLimit;
		    						}
	    	    				}
	    	    			}
	    	    			
	    	    			/************/
	    	    			//if od Limit or Outstanding which ever is higher for cr
	    	    			//if dr limit
	    	    			if(str_Loantype.equalsIgnoreCase("TL"))
	    	    			{
	    	    				if(strheadfac.equalsIgnoreCase("1"))
	    	    				{
	    	    					dblExposure=dblExposure/50;
	    	    				}
	    	    				dbl_grpexinonfundostot+=dblExposure;
	    	    			}
	    	    			else
	    	    			{
	    	    				if(strBaltype.equalsIgnoreCase("DR"))
		    	    			{
	    	    					if(dblLimit>dblOs)
	    	    					{
	    	    						if(strheadfac.equalsIgnoreCase("1"))
	    	    	    				{
	    	    							dblLimit=dblLimit/50;
	    	    	    				}
	    	    						dbl_grpexinonfundostot+=dblLimit;
	    	    					}else
	    	    					{
	    	    						if(strheadfac.equalsIgnoreCase("1"))
	    	    	    				{
	    	    							dblOs=dblOs/50;
	    	    	    				}
	    	    						dbl_grpexinonfundostot+=dblOs;
	    	    					}
	    	    				
	    	    				}else
	    	    				{
	    	    					if(strheadfac.equalsIgnoreCase("1"))
    	    	    				{
	    	    						dblLimit=dblLimit/50;
    	    	    				}
	    	    					dbl_grpexinonfundostot+=dblLimit;
	    	    				}
	    	    			}
	    	    		}
	    	    		if(rs1!=null)
	    	    		{
	    	    			rs1.close();
	    	    		}
	    	    		dbl_totalexposureNonfund=dbl_grpexinonfundostot;
	            		arrExposureCol.add(String.valueOf(dbl_grpexinonfundostot));//2
	            		arrExposureCol.add("0.00");//3
	            		arrExposureCol.add(strApplicanttype);//4
	            		strQuery1=SQLParser.getSqlQuery("sel_lapsidfromlapsid^"+strApplnid);
	    	    		rs1=DBUtils.executeQuery(strQuery1);
	    	    		while(rs1.next())
	    	    		{
	    	    			strName=Helper.correctNull((String)rs1.getString("perapp_fname"));
	    	    		}
	    	    		if(rs1!=null)
	    	    		{
	    	    			rs1.close();
	    	    		}
	    	    		arrExposureCol.add(Helper.changetoTitlecase(strName));//5
	    	    		for(int k =0;k<arrBorrowerlist.size();k++)
	    	    		{
	    	    			if(Helper.correctNull((String)arrBorrowerlist.get(k)).equalsIgnoreCase(strApplnid))
	    	    			{
	    	    				arrExposureCol.add("Y");//6		
	    	    				strflag=false;
	    	    			}
	    	    		}
	    	    		if(strflag)
	    	    		{
	    	    			arrExposureCol.add("N");//6	
	    	    		}
	    	    		arrExposureCol.add(strApplnid);//7
	    	    		arrExposureCol.add(String.valueOf(dbl_totalexposurefund));//8
	    	    		arrExposureCol.add(String.valueOf(dbl_totalexposureNonfund));//9
	    	    		
	    	    		arrExposureCol.add(String.valueOf(dblPTLExposure));//10
	    	    		arrExposureCol.add(String.valueOf(dblETLExposure));//11
	    	    		arrExposureCol.add(String.valueOf(dblPWCExposure));//12
	    	    		arrExposureCol.add(String.valueOf(dblEWCExposure));//13
	    	    		arrExposureCol.add(String.valueOf(dblPFCExposure));//14
	    	    		arrExposureCol.add(String.valueOf(dblEFCExposure));//15
	    	    		
	    	    		arrExposureRow.add(arrExposureCol);
	            }
    		}
    		hshRating=getRatingExposurecorp(hshValues);
    		hshRecord.put("arrExposureRow",arrExposureRow);
    		hshRecord.put("RatingExposureFund", String.valueOf((String)hshRating.get("RatingExposureFund")));
    		hshRecord.put("RatingExposureNonFund", String.valueOf((String)hshRating.get("RatingExposureNonFund")));
	 	}
    	catch(Exception exception)
    	{
    		throw new EJBException("Error in getCollateralSecurityDisplaynew "+exception.toString());
    		
    	}
    	return hshRecord;
    	
    }
    
    public void updateLegalOpinion(HashMap hshRequestValues)
    {
    	HashMap hshQueryValues=new HashMap();
    	HashMap hshQuery=new HashMap();
    	ArrayList arrValues=new ArrayList();
    	String strAction=Helper.correctNull((String)hshRequestValues.get("hidAction"));
    	String strSecurityId=Helper.correctNull((String)hshRequestValues.get("hidSecurityId"));
    	ResultSet rs=null;
    	String strQuery="";
    	String strModifiedField[]=null;
		String strModifiedValue[]=null;
		try
    	{
    		if(strAction.equalsIgnoreCase("insert"))
			{
    			boolean secHisflag = false;
    			strQuery = SQLParser.getSqlQuery("selseclegalopinion^"+strSecurityId);
    			rs = DBUtils.executeQuery(strQuery);
    			if(rs.next())
    			{
    				secHisflag=true;
    			}
    			
    			hshQueryValues.put("size","2");
    			arrValues.add(strSecurityId);
				hshQuery.put("arrValues", arrValues);				
				hshQuery.put("strQueryId","seclegalopiniondel");
				hshQueryValues.put("1", hshQuery);
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(strSecurityId);
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_nameofadviser")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_date_leaglopinion")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_date_supleaglopinion")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_date_leaglaudrep")));
				//arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_cersid")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("sel_flowtitle")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("sel_ec")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_taxpaidtear")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("sel_tomrec")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("sel_elitepanel_leg")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("hid_sno")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_dateofsubmissionbybank")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_dateofreceiptbybank")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_date_chargecreation")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_mortgage_createdon")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_roccharge_createdt")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("hid_flowprop_dt")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("hid_Period_Ec")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_legalauditor")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("hid_legalauditorsno")));
				//added as part of AHP
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_gvtscheme_name")));
				
				/*String[] tempcount=null;
				int countsize=0;
				
				String[] txt_dateofsearchfrom_prop = (String[])hshRequestValues.get("txt_searchfrom_prop");
				String[] txt_dateofsearchto_prop = (String[])hshRequestValues.get("txt_searchto_prop");
				
				tempcount = (String[])hshRequestValues.get("txt_searchfrom_prop");

				for(int i=0;i<tempcount.length;i++)
				 {
				arrValues.add(txt_dateofsearchfrom_prop[i]);
				arrValues.add(txt_dateofsearchto_prop[i]);
				 }
				*/
				hshQuery.put("arrValues", arrValues);				
				hshQuery.put("strQueryId","seclegalopinionins");
				hshQueryValues.put("2", hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","3");
				hshQuery.put("strQueryId","upd_securities");
				arrValues.add("Y");
				arrValues.add(strSecurityId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("3",hshQuery);
	    		EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
	    	
	    		strQuery=SQLParser.getSqlQuery("selsecpropdet^"+strSecurityId);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{  	
					if(rs!=null)
			    		rs.close();
					strQuery = SQLParser.getSqlQuery("sel_secMailbox_check^"+strSecurityId);
		    		rs = DBUtils.executeQuery(strQuery);
		    		if(rs.next())	
		    		{
		    			String mailboxflag=Helper.correctNull((String)rs.getString("SEC_FLAG"));
						if(mailboxflag.equals("NCN"))
							mailboxflag="N";
						else
							mailboxflag="V";
		    			hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQueryValues.put("size","1");
						hshQuery.put("strQueryId","upd_secMailbox_flag");
						arrValues.add(mailboxflag);
						arrValues.add(strSecurityId);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);
						
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQueryValues.put("size","2");
						hshQuery.put("strQueryId","upd_cussecurities_changeflag");
						arrValues.add("V");
						arrValues.add(strSecurityId);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("2",hshQuery);
						
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		    		}
				}
				
				
	    		if(secHisflag==true)
	    		{
	    		hshQueryValues=new HashMap();
				int arrquerySize=1;
				String tempOldvalue="",tempNewvalue="",tempField="";
				if(!Helper.correctNull((String)hshRequestValues.get("hidmodifiedField")).equals(""))
					strModifiedField = Helper.correctNull((String)hshRequestValues.get("hidmodifiedField")).split("@") ;
				if(!Helper.correctNull((String)hshRequestValues.get("hidmodifiedvalue")).equals(""))	
					strModifiedValue = Helper.correctNull((String)hshRequestValues.get("hidmodifiedvalue")).split("@");
				if(strModifiedField!=null && strModifiedField.length>0)
				{
					for (int  k = 0; k < strModifiedField.length; k++) 
					{
						tempOldvalue= Helper.correctNull((String)hshRequestValues.get(strModifiedValue[k]));
						tempNewvalue= Helper.correctNull((String)hshRequestValues.get((strModifiedValue[k]).substring(4)));
						tempField= strModifiedField[k];
	
						arrValues=new ArrayList();
						hshQuery = new HashMap();
						arrValues.add(tempField);
						arrValues.add(tempOldvalue);
						arrValues.add(tempNewvalue);
						arrValues.add(Helper.correctNull((String)hshRequestValues.get("strUserId")));
						arrValues.add(strSecurityId);
						hshQuery.put("arrValues", arrValues);
						hshQuery.put("strQueryId", "ins_sec_modified");
						hshQueryValues.put(Integer.toString(arrquerySize),hshQuery);
						hshQueryValues.put("size",Integer.toString(arrquerySize));
						arrquerySize++;
					}
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
	    		}

			}
    		else if(strAction.equalsIgnoreCase("delete"))
			{
    			hshQueryValues.put("size","1");
    			arrValues.add(strSecurityId);
				hshQuery.put("arrValues", arrValues);				
				hshQuery.put("strQueryId","seclegalopiniondel");
				hshQueryValues.put("1", hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","upd_securities");
				arrValues.add("N");
				arrValues.add(strSecurityId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);
				
	    		EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");

			} 
    		if(strAction.equalsIgnoreCase("insert"))
    		{
    			if(Helper.correctNull(ApplicationParams.getMONITORINGDBENABLED()).equalsIgnoreCase("YES"))
				{
    				String StrLegalauditDate=Helper.correctNull((String)hshRequestValues.get("txt_date_leaglaudrep"));
    				arrValues = new ArrayList();
    				hshQueryValues = new HashMap();
    				hshQuery=new HashMap();
    				hshQuery.put("strQueryId","update_monitoring");	
    				arrValues.add(StrLegalauditDate);
    				arrValues.add(StrLegalauditDate);
    				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_legalauditor")));
    				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_nameofadviser")));
    				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_date_leaglopinion")));
    				arrValues.add(strSecurityId);
    				hshQuery.put("arrValues",arrValues);
    				hshQueryValues.put("1",hshQuery);
    				hshQueryValues.put("size","1");	
		         	EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateMonitoringData");
			    }
			
    		}
    	}
    	catch(Exception e)
    	{
			throw new EJBException("Error in updateLegalOpinion "+e.toString());
		}
    }
    public HashMap getLegalOpinion(HashMap hshRequestValues)
    {
    	HashMap hshQuery=new HashMap();
    	ResultSet rs=null,rs1=null;
    	String strQuery="",strAppno="", strSecID=null,strPropType="",strLoanPurpose="";
    	strSecID = Helper.correctNull((String)hshRequestValues.get("hidSecurityId"));
    	if(strSecID.equalsIgnoreCase(""))
		{
    		strSecID=Helper.correctNull((String)hshRequestValues.get("hidsecid"));
		}
    	try
    	{
	    	strQuery=SQLParser.getSqlQuery("selseclegalopinion^"+strSecID);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{  	
				hshQuery.put("SEC_PL_LAWNAME",correctNull(rs.getString("SEC_PL_LAWNAME")));
				hshQuery.put("SEC_PL_LEGOPDATE",correctNull(rs.getString("SEC_PL_LEGOPDATE")));
				hshQuery.put("SEC_PL_LEGOPSUPDATE",correctNull(rs.getString("SEC_PL_LEGOPSUPDATE")));
				hshQuery.put("SEC_PL_LEGALAUDREPDATE",correctNull(rs.getString("SEC_PL_LEGALAUDREPDATE")));
				hshQuery.put("SEC_PL_CERSID",correctNull(rs.getString("SEC_PL_CERSID")));
				hshQuery.put("SEC_PL_TITLE",correctNull(rs.getString("SEC_PL_TITLE")));
				hshQuery.put("SEC_PL_EC",correctNull(rs.getString("SEC_PL_EC")));
				hshQuery.put("SEC_PL_TAX",correctNull(rs.getString("SEC_PL_TAX")));
				hshQuery.put("SEC_PL_MORTG",correctNull(rs.getString("SEC_PL_MORTG")));
				hshQuery.put("sec_pl_elitepanel",correctNull(rs.getString("sec_pl_elitepanel")));
				hshQuery.put("sec_lawyer_seqno",correctNull(rs.getString("sec_lawyer_seqno")));
				hshQuery.put("sec_pl_legsubmitteddate",correctNull(rs.getString("sec_pl_legsubmitteddate")));
				hshQuery.put("sec_pl_legrecvdate",correctNull(rs.getString("sec_pl_legrecvdate")));
				hshQuery.put("SEC_PL_CHARGECREATIONDATE",correctNull(rs.getString("SEC_PL_CHARGECREATIONDATE")));
				hshQuery.put("SEC_PL_MORTGAGE_CREATED_ON",correctNull(rs.getString("SEC_PL_MORTGAGE_CREATED_ON")));
				hshQuery.put("SEC_PL_ROC_CHARGE_CREATEDDT",correctNull(rs.getString("SEC_PL_ROC_CHARGE_CREATEDDT")));
				hshQuery.put("SEC_PL_SEARCHFROM_PROP",correctNull(rs.getString("SEC_PL_SEARCHFROM_PROP")));
				hshQuery.put("SEC_PL_PERIOD_EC",correctNull(rs.getString("SEC_PL_PERIOD_EC")));
				hshQuery.put("sec_legalaudit_lawyername",correctNull(rs.getString("sec_legalaudit_lawyername")));
				hshQuery.put("sec_legalaudit_lawyersno",correctNull(rs.getString("sec_legalaudit_lawyersno")));
			    //added as part of AHP
				hshQuery.put("SEC_PL_GOVT_LAWYERNAME",correctNull(rs.getString("SEC_PL_GOVT_LAWYERNAME")));

			}
			
			// To get the Customer Name
			String StrLAPSId = correctNull((String) hshRequestValues.get("hidDemoId"));
			if(("").equalsIgnoreCase(StrLAPSId)){
				
				StrLAPSId=correctNull((String) hshRequestValues.get("hidapplicantid"));
			}
			strQuery = SQLParser.getSqlQuery("sel_lapsidfromlapsid^" + StrLAPSId);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()) 
			{
				hshQuery.put("perapp_fname", Helper.correctNull((String)rs.getString("perapp_fname")));
				hshQuery.put("perapp_cbsid", Helper.correctNull((String)rs.getString("perapp_cbsid")));
				hshQuery.put("perapp_oldid", Helper.correctNull((String)rs.getString("perapp_oldid")));
			}
			
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeLAPSQuery("selsecpropdet^"+strSecID);
    		if(rs.next())
    		{
    			hshQuery.put("strPropFlag","Y");
    		}
    		hshQuery.put("strSecID", strSecID);
			hshQuery.put("hid_VerificationFlag", Helper.correctNull((String)hshRequestValues.get("hid_VerificationFlag")));
    	}
    	catch(Exception e)
    	{
			throw new EJBException("Error in getPropertyDetData "+e.toString());
		}
    	finally
    	{
    		try
    		{
    			if(rs!=null)
    				rs.close();
    		}
    		catch(Exception ef)
    		{
    			throw new EJBException("Error in getPropertyDetData "+ef.getMessage());
    			
    		}     		
    	}
    	return hshQuery;
    }
    
    public HashMap getReleaseofSecurity(HashMap hshValues) 
    {
    	java.text.NumberFormat jtn= java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);		
		
    	String strQuery="",strSno="",strAppno="",strFacCode="";
		ResultSet rs = null,rs1 = null,rs2 = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();
		ArrayList vecVal=null;
		ArrayList arrFacID = new ArrayList();
		ArrayList arrColFacID = new ArrayList();
		String hidposition= correctNull((String)hshValues.get("hidposition"));
		String hidFacID= correctNull((String)hshValues.get("hidFacIDlist"));
		double dblExist=0.00,dblProposed=0.00,dblMargin=0.00;
		boolean flag=true;
		String secID="";
		ArrayList vecColFac = new ArrayList();
		ArrayList vecRowFac = new ArrayList();
    	try
    	{
    		strAppno=Helper.correctNull((String)hshValues.get("appno"));
    		int i=1;
			String strLimit="",strOutstand="",strbnkFac="",srtModtype="";	
			strQuery = SQLParser.getSqlQuery("sel_banking^" + strAppno);
			rs1 = DBUtils.executeQuery(strQuery);
			while(rs1.next())
			{
				vecVal = new ArrayList();
				strbnkFac = Helper.correctNull((String)rs1.getString("combk_facility"));
				srtModtype= Helper.correctNull((String)rs1.getString("combk_modtype"));
				String[] bankFac = strbnkFac.split("~");
				if(srtModtype.equalsIgnoreCase("C") || srtModtype.equalsIgnoreCase("a"))
				{
					strQuery = SQLParser.getSqlQuery("sel_facilityCorp^" + bankFac[0]);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strFacCode=rs.getString("com_facdesc");
					}
				}
				else
				{
					strQuery=SQLParser.getSqlQuery("sel_retProductDesc^"+bankFac[0]);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strFacCode=Helper.correctNull(rs.getString("com_facdesc"));
					}
				}
								
				vecVal.add(strFacCode);//0
				dblProposed =rs1.getDouble("combk_limit");
				strOutstand = jtn.format(dblProposed);
				vecVal.add(strOutstand);//1
				vecVal.add("");//2
				vecVal.add(correctNull((String)rs1.getString("combk_facility_sno")));//3
				vecVal.add(bankFac[0]);//4
				if(srtModtype.equalsIgnoreCase("C") || srtModtype.equalsIgnoreCase("a"))
				{
					vecVal.add(correctNull((String)rs.getString("com_factype")));//5
					vecVal.add(correctNull((String)rs.getString("com_facnature")));//6
				}
				else
				{
					vecVal.add(correctNull((String)rs.getString("PRD_LOANTYPE")));//5
					vecVal.add(correctNull((String)rs.getString("PRD_TYPE")));//6
				}
				 
				if(rs != null)
				{
					rs.close();
				}
				dblExist =rs1.getDouble("combk_os");
				strLimit = jtn.format(dblExist);
				vecVal.add(strLimit);//7
				vecVal.add("E");//8
				
				hshRecord.put("Existing","Y");
				
				strQuery = SQLParser.getSqlQuery("sel_facid_appSecdetails^" + Helper.correctInt((String)rs1.getString("COMBK_PARENTAPPNO")) + "^"+secID);
				rs2 = DBUtils.executeQuery(strQuery);
	    		if(rs2.next())
				{
	    			vecVal.add("Y");//9
				}
	    		else
	    		{
	    			vecVal.add("N");//9
	    		}
	    		if(rs2 != null)
				{
					rs2.close();
				}
	    		vecVal.add(Helper.correctNull((String)rs1.getString("COMBK_PARENTAPPNO")));//10
	    		vecVal.add(Helper.correctNull((String)rs1.getString("COMBK_PARENTFACSNO")));//11
	    		strQuery = SQLParser.getSqlQuery("sel_app_securities_faclist^" +strAppno+"^"+ correctNull((String)rs1.getString("combk_facility_sno")) +"^E"+"^"+ correctNull((String)rs1.getString("COMBK_PARENTAPPNO")));
				rs = DBUtils.executeQuery(strQuery);
	    		while(rs.next())
				{
	    			flag=false;
	    			 vecColFac = new ArrayList();
	    			 vecColFac.add(Helper.correctNull((String)rs1.getString("combk_facility_sno")));//
	    			 vecColFac.add(Helper.correctNull((String)rs.getString("app_sec_secid")));//
	    			 vecColFac.add(Helper.correctNull((String)rs.getString("SEC_NAME")));//
	    			 vecColFac.add(Helper.correctNull((String)rs.getString("SEC_CLASSIFICATION")));//
	    			 vecColFac.add(Helper.correctNull((String)rs.getString("cus_sec_netsecurity")));//
	    			 vecRowFac.add(vecColFac);	
	    			 vecVal.add(vecColFac);	
	    			 strQuery = SQLParser.getSqlQuery("sel_facid_appSecdetails_existing^" + strAppno + "^"+Helper.correctNull((String)rs.getString("app_sec_secid"))+"^"+ correctNull((String)rs1.getString("combk_facility_sno")) +"^"+ correctNull((String)rs1.getString("COMBK_PARENTAPPNO")));
	    			 rs2 = DBUtils.executeQuery(strQuery);
    				 String strFacID="";
    				 while(rs2.next())
    				 {
    	    			arrFacID = new ArrayList();
    	    			arrFacID.add(correctNull((String)rs2.getString("app_sec_facid")));
    	    			arrFacID.add(correctNull((String)rs2.getString("APP_SEC_MARGIN")));
    	    			arrFacID.add(correctNull((String)rs2.getString("app_sec_securitytype")));
    	    			arrFacID.add(correctNull((String)rs2.getString("app_sec_loantype")));
    	    			arrFacID.add(correctNull((String)rs2.getString("app_sec_parentappno")));
    	    			arrFacID.add(correctNull((String)rs2.getString("app_sec_parent_facsno")));
    	    			arrFacID.add(correctNull((String)rs1.getString("combk_facility_sno")));
    	    			arrFacID.add(correctNull((String)rs2.getString("app_sec_attached")));
    	    			arrColFacID.add(arrFacID);
    				 }
	    	   }
	    		if(flag)
	    		{
	    			 vecColFac = new ArrayList();
	    			 vecColFac.add("");//
	    			 vecColFac.add("");//
	    			 vecColFac.add("");//
	    			 vecColFac.add("");//
	    			 vecColFac.add("");//
	    			 vecVal.add(vecColFac);	
	    			 arrFacID = new ArrayList();
 	    			arrFacID.add("");
 	    			arrFacID.add("");
 	    			arrFacID.add("");
 	    			arrFacID.add("");
 	    			arrFacID.add("");
 	    			arrFacID.add("");
 	    			arrFacID.add("");
 	    			arrFacID.add("");
 	    			vecVal.add(arrFacID);
	    		}
	    		vecData.add(vecVal);		
	    		hshRecord.put("count",""+(i++));
			}
    		hshRecord.put("vecData",vecData);
    		hshRecord.put("hidposition",hidposition);
    		hshRecord.put("hidFacID",hidFacID);
    		hshRecord.put("arrColFacID",arrColFacID);
    		hshRecord.put("vecRowFac",vecRowFac);
    		//***********************************************
    		
    	}
    	catch(Exception e)
		{
			throw new EJBException("Error in getReleaseofSecurity "+e.toString());
		}finally
		{
			try
			{	if(rs != null)
					rs.close();
				if(rs1 != null)
					rs1.close();
				if(rs2 != null)
					rs2.close();
			}
			catch(Exception cf)
			{
				log.error("Exception in getReleaseofSecurity ::: "+ cf.getMessage());
			}
		}
    	return hshRecord;
    }
    public void updateReleaseofSecurity(HashMap hshValues) 
    {
		HashMap hshRecord = new HashMap();
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		int maxsno =0;
		String strAction =null;
		ResultSet rs = null;
		String appno="";
		try{
			int size=Integer.parseInt(Helper.correctInt((String)hshValues.get("hid_count")));
			String[] strSecID=new String[size];
			String[] strFacsno=new String[size];
			String[] strchk=new String[size];
			String[] strParentappno=new String[size];
			String[] strParentsno=new String[size];
			strAction= Helper.correctNull((String)hshValues.get("hidAction"));
			if(hshValues.get("txt_facilitysno") instanceof String[])
			{
				strSecID = (String[])hshValues.get("txt_secid");
				strFacsno=  (String[])hshValues.get("txt_facilitysno");
				strParentappno = (String[])hshValues.get("hidparentappno");
				strParentsno=  (String[])hshValues.get("hidparentsno");
				
			}
			strchk= Helper.correctNull((String)hshValues.get("hidchk")).split("@");
			appno= Helper.correctNull((String)hshValues.get("hidappno"));
			if (strAction.equalsIgnoreCase("release"))
			{			
				for(int j=0;j<size;j++)
				{
					if(!strchk[j].equalsIgnoreCase("0"))
					{
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(appno);
				arrValues.add(strSecID[j]);
				arrValues.add(strParentsno[j]);
				arrValues.add(strParentappno[j]);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","upd_app_securitydetails_attached");
				hshQueryValues.put("1",hshQuery);
				
				//for releasing from parent application
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(strParentappno[j]);
				arrValues.add(strSecID[j]);
				arrValues.add(strParentsno[j]);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","upd_app_securitydetails");
				hshQueryValues.put("size","2");					
				hshQueryValues.put("2",hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
					}
				}
			}

		}
		catch(Exception ce){
			log.error(ce.toString());
			throw new EJBException("Error in updateReleaseofSecurity "+ce.toString());
		}
		finally
		{
			
		}
	}
    private HashMap getSum(HashMap hshValues) 
    {
    	int intSeccate=0;
		String strSecid="";
		HashMap hshResult = new HashMap(); 
		double dblSumProperties=0.00,dblSumPlant=0.00,dblSumDep=0.00,dblSumCost=0.00,dblSumFixed=0.00,dblSumOth=0.00,
		dblSumPropExi=0.00,dblSumPlantExi=0.00,dblSumDepExi=0.00,dblSumCostExi=0.00,dblSumFixedExi=0.00,dblSumOthExi=0.00;
		double dblSumProptot=0.00,dblSumDeptot=0.00,dblSumCosttot=0.00,dblSumFixedtot=0.00,dblSumOthtot=0.00,dblSumPlanttot=0.00;
		ArrayList arrSecidRow = new ArrayList();
		ArrayList arrSecidCol = new ArrayList();
		ArrayList arrValueRow = new ArrayList();
		ArrayList arrValueCol = new ArrayList();
		ArrayList arrValueTotRow = new ArrayList();
		ArrayList arrValueTotCol = new ArrayList();
		ArrayList arrValueTempcol = new ArrayList();
		String strValuesin=Helper.correctNull((String)hshValues.get("valuesin")),strFlag="";
		arrSecidRow = (ArrayList)hshValues.get("arrSecidRow"); 
    	try
    	{
    		
    		for(int k=0;k<arrSecidRow.size();k++)
    		{
    			arrSecidCol = (ArrayList)arrSecidRow.get(k);
    			arrValueTotCol = new ArrayList();
    			arrValueTotCol.add(arrSecidCol.get(0));
    			arrValueTotCol.add(arrSecidCol.get(1));
    			arrValueTotCol.add(arrSecidCol.get(2));
    			arrValueTotCol.add(arrSecidCol.get(3));
    			arrValueTotRow.add(arrValueTotCol);
    		}
    		//Exclusive Security Proposed amount
    		for(int k=0;k<arrSecidRow.size();k++)
    		{
    			arrSecidCol = (ArrayList)arrSecidRow.get(k);
    			intSeccate=Integer.parseInt(Helper.correctInt((String)arrSecidCol.get(2)));
    			if(intSeccate>=10 && intSeccate<=17)
    			{
    				dblSumProperties+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
    				if(strSecid.equalsIgnoreCase(""))
    				{
    					strSecid="'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";			
    				}else
    				{
    					strSecid=strSecid+",'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";
    				}
    			}else if(intSeccate==19)
    			{
    				dblSumPlant+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
    				if(strSecid.equalsIgnoreCase(""))
    				{
    					strSecid="'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";			
    				}else
    				{
    					strSecid=strSecid+",'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";
    				}
    			}
    			else if(intSeccate==7)
    			{
    				dblSumDep+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
    				if(strSecid.equalsIgnoreCase(""))
    				{
    					strSecid="'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";			
    				}else
    				{
    					strSecid=strSecid+",'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";
    				}
    			}
    			else if(intSeccate==2)
    			{
    				dblSumCost+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
    				if(strSecid.equalsIgnoreCase(""))
    				{
    					strSecid="'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";			
    				}else
    				{
    					strSecid=strSecid+",'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";
    				}
    			}
    			else if(intSeccate==18 || intSeccate==20 || intSeccate==23)
    			{
    				dblSumFixed+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
    				if(strSecid.equalsIgnoreCase(""))
    				{
    					strSecid="'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";			
    				}else
    				{
    					strSecid=strSecid+",'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";
    				}
    			}
    			else if(intSeccate==5 || intSeccate==6 || intSeccate==8 || intSeccate==24 || intSeccate==9 || intSeccate==21 || intSeccate==22)
    			{
    				dblSumOth+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
    				if(strSecid.equalsIgnoreCase(""))
    				{
    					strSecid="'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";			
    				}else
    				{
    					strSecid=strSecid+",'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";
    				}
    			}
    		}
    		//Exclusive Security Existing amount
    		boolean bolFlag=true;
    		arrSecidRow = (ArrayList)hshValues.get("arrExisidExc"); 
    		for(int k=0;k<arrSecidRow.size();k++)
    		{
    			arrSecidCol = (ArrayList)arrSecidRow.get(k);
    			String intSecid=Helper.correctInt((String)arrSecidCol.get(0));
    			String intSecid1="";
    			for(int j=0;j<arrValueTotRow.size();j++)
    			{
    				 bolFlag=true;
    				arrValueTempcol=(ArrayList)arrValueTotRow.get(j);
    				intSecid1=Helper.correctInt((String)arrValueTempcol.get(0));
    				if(intSecid1.equalsIgnoreCase(intSecid))
    				{
    					bolFlag=false;
    					break;
    				}
    			}
    			if(bolFlag)
    			{
    				arrValueTotCol = new ArrayList();
        			arrValueTotCol.add(arrSecidCol.get(0));
        			arrValueTotCol.add(arrSecidCol.get(1));
        			arrValueTotCol.add(arrSecidCol.get(2));
        			arrValueTotCol.add(arrSecidCol.get(3));
        			arrValueTotRow.add(arrValueTotCol);
        		}
    			
    		}
    		for(int k=0;k<arrSecidRow.size();k++)
    		{
    			arrSecidCol = (ArrayList)arrSecidRow.get(k);
    			intSeccate=Integer.parseInt(Helper.correctInt((String)arrSecidCol.get(2)));
    			if(intSeccate>=10 && intSeccate<=17)
    			{
    				dblSumPropExi+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
    				if(strSecid.equalsIgnoreCase(""))
    				{
    					strSecid="'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";			
    				}else
    				{
    					strSecid=strSecid+",'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";
    				}
    			}else if(intSeccate==19)
    			{
    				dblSumPlantExi+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
    				if(strSecid.equalsIgnoreCase(""))
    				{
    					strSecid="'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";			
    				}else
    				{
    					strSecid=strSecid+",'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";
    				}
    			}
    			else if(intSeccate==7)
    			{
    				dblSumDepExi+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
    				if(strSecid.equalsIgnoreCase(""))
    				{
    					strSecid="'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";			
    				}else
    				{
    					strSecid=strSecid+",'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";
    				}
    			}
    			else if(intSeccate==2)
    			{
    				dblSumCostExi+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
    				if(strSecid.equalsIgnoreCase(""))
    				{
    					strSecid="'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";			
    				}else
    				{
    					strSecid=strSecid+",'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";
    				}
    			}
    			else if(intSeccate==18 || intSeccate==20 || intSeccate==23)
    			{
    				dblSumFixedExi+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
    				if(strSecid.equalsIgnoreCase(""))
    				{
    					strSecid="'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";			
    				}else
    				{
    					strSecid=strSecid+",'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";
    				}
    			}
    			else if(intSeccate==5 || intSeccate==6 || intSeccate==8 || intSeccate==24 || intSeccate==9 || intSeccate==21 || intSeccate==22)
    			{
    				dblSumOthExi+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
    				if(strSecid.equalsIgnoreCase(""))
    				{
    					strSecid="'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";			
    				}else
    				{
    					strSecid=strSecid+",'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";
    				}
    			}
    		}
    		//for total Exclusive security value
    		for(int k=0;k<arrValueTotRow.size();k++)
    		{
    			arrSecidCol = (ArrayList)arrValueTotRow.get(k);
    			intSeccate=Integer.parseInt(Helper.correctInt((String)arrSecidCol.get(2)));
    			if(intSeccate>=10 && intSeccate<=17)
    			{
    				dblSumProptot+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
    			}else if(intSeccate==19)
    			{
    				dblSumPlanttot+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
    			}
    			else if(intSeccate==7)
    			{
    				dblSumDeptot+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
    			}
    			else if(intSeccate==2)
    			{
    				dblSumCosttot+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
    			}
    			else if(intSeccate==18 || intSeccate==20 || intSeccate==23)
    			{
    				dblSumFixedtot+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
    			}
    			else if(intSeccate==5 || intSeccate==6 || intSeccate==8 || intSeccate==24 || intSeccate==9 || intSeccate==21 || intSeccate==22)
    			{
    				dblSumOthtot+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
    			}
    		}
    			if(dblSumProperties>0 || dblSumPropExi>0 || dblSumProptot>0)
    			{
    				arrValueCol = new ArrayList();
    				strFlag="E";
    				arrValueCol.add("Properties [Exclusive]");
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumPropExi)));
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumProperties)));
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumProptot)));
    				arrValueRow.add(arrValueCol);
    			}
    			if(dblSumPlant>0 || dblSumPlantExi>0 ||dblSumPlanttot>0)
    			{
    				arrValueCol = new ArrayList();
    				strFlag="E";
    				arrValueCol.add("Plant and Machinery [Exclusive]");
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumPlantExi)));
   					arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumPlant)));
   					arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumPlanttot)));
    				arrValueRow.add(arrValueCol);
    			}
    			if(dblSumDep>0 || dblSumDepExi>0 || dblSumDeptot>0)
    			{
    				arrValueCol = new ArrayList();
    				strFlag="E";
    				arrValueCol.add("Deposits [Exclusive]");
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumDepExi)));
   					arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumDep)));
   					arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumDeptot)));
    				arrValueRow.add(arrValueCol);
    			}
    			if(dblSumCost>0 || dblSumCostExi>0 || dblSumCosttot>0)
    			{
    				arrValueCol = new ArrayList();
    				strFlag="E";
    				arrValueCol.add("Cash Margin [Exclusive]");
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumCostExi)));
   					arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumCost)));
   					arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumCosttot)));
    				arrValueRow.add(arrValueCol);
    			}
    			if(dblSumFixed>0 || dblSumFixedExi>0 || dblSumFixedtot>0)
    			{
    				arrValueCol = new ArrayList();
    				strFlag="E";
    				arrValueCol.add("Fixed Assets [Exclusive]");
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumFixedExi)));
   					arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumFixed)));
   					arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumFixedtot)));
    				arrValueRow.add(arrValueCol);
    			}
    			if(dblSumOth>0 || dblSumOthExi>0 || dblSumOthtot>0)
    			{
    				arrValueCol = new ArrayList();
    				strFlag="E";
    				arrValueCol.add("Others [Exclusive]");
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumOthExi)));
   					arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumOth)));
   					arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumOthtot)));
    				arrValueRow.add(arrValueCol);
    			}
    			
    			arrValueTotRow = new ArrayList();
    			dblSumProperties=0.00;dblSumPlant=0.00;dblSumDep=0.00;dblSumCost=0.00;dblSumFixed=0.00;dblSumOth=0.00;
    			dblSumPropExi=0.00;dblSumPlantExi=0.00;dblSumDepExi=0.00;dblSumCostExi=0.00;dblSumFixedExi=0.00;dblSumOthExi=0.00;
    			dblSumProptot=0.00;dblSumDeptot=0.00;dblSumCosttot=0.00;dblSumFixedtot=0.00;dblSumOthtot=0.00;dblSumPlanttot=0.00;
    			 bolFlag=true;
    			//Common Security Proposed amount
    			arrSecidRow = (ArrayList)hshValues.get("arrSecidcomRow"); 
    			for(int k=0;k<arrSecidRow.size();k++)
        		{
        			arrSecidCol = (ArrayList)arrSecidRow.get(k);
        			String intSecid=Helper.correctInt((String)arrSecidCol.get(0));
        			String intSecid1="";
        			for(int j=0;j<arrValueTotRow.size();j++)
        			{
        				 bolFlag=true;
        				arrValueTempcol=(ArrayList)arrValueTotRow.get(j);
        				intSecid1=Helper.correctInt((String)arrValueTempcol.get(0));
        				if(intSecid1.equalsIgnoreCase(intSecid))
        				{
        					bolFlag=false;
        					break;
        				}
        			}
        			if(bolFlag)
        			{
        				arrValueTotCol = new ArrayList();
            			arrValueTotCol.add(arrSecidCol.get(0));
            			arrValueTotCol.add(arrSecidCol.get(1));
            			arrValueTotCol.add(arrSecidCol.get(2));
            			arrValueTotCol.add(arrSecidCol.get(3));
            			arrValueTotRow.add(arrValueTotCol);
            		}
        			
        		}
    			arrSecidCol=new ArrayList();
        		for(int k=0;k<arrSecidRow.size();k++)
        		{
        			arrSecidCol = (ArrayList)arrSecidRow.get(k);
        			intSeccate=Integer.parseInt(Helper.correctInt((String)arrSecidCol.get(2)));
        			if(intSeccate>=10 && intSeccate<=17)
        			{
        				dblSumProperties+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
        				if(strSecid.equalsIgnoreCase(""))
        				{
        					strSecid="'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";			
        				}else
        				{
        					strSecid=strSecid+",'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";
        				}
        			}else if(intSeccate==19)
        			{
        				dblSumPlant+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
        				if(strSecid.equalsIgnoreCase(""))
        				{
        					strSecid="'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";			
        				}else
        				{
        					strSecid=strSecid+",'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";
        				}
        			}
        			else if(intSeccate==7)
        			{
        				dblSumDep+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
        				if(strSecid.equalsIgnoreCase(""))
        				{
        					strSecid="'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";			
        				}else
        				{
        					strSecid=strSecid+",'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";
        				}
        			}
        			else if(intSeccate==2)
        			{
        				dblSumCost+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
        				if(strSecid.equalsIgnoreCase(""))
        				{
        					strSecid="'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";			
        				}else
        				{
        					strSecid=strSecid+",'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";
        				}
        			}
        			else if(intSeccate==18 || intSeccate==20 || intSeccate==23)
        			{
        				dblSumFixed+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
        				if(strSecid.equalsIgnoreCase(""))
        				{
        					strSecid="'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";			
        				}else
        				{
        					strSecid=strSecid+",'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";
        				}
        			}
        			else if(intSeccate==5 || intSeccate==6 || intSeccate==8 || intSeccate==24 || intSeccate==9 || intSeccate==21 || intSeccate==22)
        			{
        				dblSumOth+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
        				if(strSecid.equalsIgnoreCase(""))
        				{
        					strSecid="'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";			
        				}else
        				{
        					strSecid=strSecid+",'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";
        				}
        			}
        		}
        		//Common Security Existing amount
        		arrSecidRow = (ArrayList)hshValues.get("arrExisecidcom"); 
        		 bolFlag=true;
        		for(int k=0;k<arrSecidRow.size();k++)
        		{
        			arrSecidCol = (ArrayList)arrSecidRow.get(k);
        			String intSecid=Helper.correctInt((String)arrSecidCol.get(0));
        			String intSecid1="";
        			for(int j=0;j<arrValueTotRow.size();j++)
        			{
        				 bolFlag=true;
        				arrValueTempcol=(ArrayList)arrValueTotRow.get(j);
        				intSecid1=Helper.correctInt((String)arrValueTempcol.get(0));
        				if(intSecid1.equalsIgnoreCase(intSecid))
        				{
        					bolFlag=false;
        					break;
        				}
        			}
        			if(bolFlag)
        			{
        				arrValueTotCol = new ArrayList();
            			arrValueTotCol.add(arrSecidCol.get(0));
            			arrValueTotCol.add(arrSecidCol.get(1));
            			arrValueTotCol.add(arrSecidCol.get(2));
            			arrValueTotCol.add(arrSecidCol.get(3));
            			arrValueTotRow.add(arrValueTotCol);
            		}
        			
        		}
        		arrSecidCol=new ArrayList();
        		for(int k=0;k<arrSecidRow.size();k++)
        		{
        			arrSecidCol = (ArrayList)arrSecidRow.get(k);
        			intSeccate=Integer.parseInt(Helper.correctInt((String)arrSecidCol.get(2)));
        			if(intSeccate>=10 && intSeccate<=17)
        			{
        				dblSumPropExi+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
        				if(strSecid.equalsIgnoreCase(""))
        				{
        					strSecid="'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";			
        				}else
        				{
        					strSecid=strSecid+",'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";
        				}
        			}else if(intSeccate==19)
        			{
        				dblSumPlantExi+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
        				if(strSecid.equalsIgnoreCase(""))
        				{
        					strSecid="'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";			
        				}else
        				{
        					strSecid=strSecid+",'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";
        				}
        			}
        			else if(intSeccate==7)
        			{
        				dblSumDepExi+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
        				if(strSecid.equalsIgnoreCase(""))
        				{
        					strSecid="'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";			
        				}else
        				{
        					strSecid=strSecid+",'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";
        				}
        			}
        			else if(intSeccate==2)
        			{
        				dblSumCostExi+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
        				if(strSecid.equalsIgnoreCase(""))
        				{
        					strSecid="'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";			
        				}else
        				{
        					strSecid=strSecid+",'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";
        				}
        			}
        			else if(intSeccate==18 || intSeccate==20 || intSeccate==23)
        			{
        				dblSumFixedExi+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
        				if(strSecid.equalsIgnoreCase(""))
        				{
        					strSecid="'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";			
        				}else
        				{
        					strSecid=strSecid+",'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";
        				}
        			}
        			else if(intSeccate==5 || intSeccate==6 || intSeccate==8 || intSeccate==24 || intSeccate==9 || intSeccate==21 || intSeccate==22)
        			{
        				dblSumOthExi+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
        				if(strSecid.equalsIgnoreCase(""))
        				{
        					strSecid="'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";			
        				}else
        				{
        					strSecid=strSecid+",'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";
        				}
        			}
        		}
        		
        		//for total Common security value
        		for(int k=0;k<arrValueTotRow.size();k++)
        		{
        			arrSecidCol = (ArrayList)arrValueTotRow.get(k);
        			intSeccate=Integer.parseInt(Helper.correctInt((String)arrSecidCol.get(2)));
        			if(intSeccate>=10 && intSeccate<=17)
        			{
        				dblSumProptot+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
        			}else if(intSeccate==19)
        			{
        				dblSumPlanttot+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
        			}
        			else if(intSeccate==7)
        			{
        				dblSumDeptot+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
        			}
        			else if(intSeccate==2)
        			{
        				dblSumCosttot+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
        			}
        			else if(intSeccate==18 || intSeccate==20 || intSeccate==23)
        			{
        				dblSumFixedtot+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
        			}
        			else if(intSeccate==5 || intSeccate==6 || intSeccate==8 || intSeccate==24 || intSeccate==9 || intSeccate==21 || intSeccate==22)
        			{
        				dblSumOthtot+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
        			}
        		}
    			
        		if(dblSumProperties>0 || dblSumPropExi>0 || dblSumProptot>0)
    			{
    				arrValueCol = new ArrayList();
    				arrValueCol.add("Properties [Common]");
    				if(!strFlag.equalsIgnoreCase("E"))
    				{
    					strFlag="C";
    				}else
    				{
    					strFlag="EC";	
    				}
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumPropExi)));
   					arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumProperties)));
   					arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumProptot)));
    				arrValueRow.add(arrValueCol);
    			}
    			if(dblSumPlant>0 || dblSumPlantExi>0 || dblSumPlanttot>0)
    			{
    				arrValueCol = new ArrayList();
    				arrValueCol.add("Plant and Machinery [Common]");
    				if(!strFlag.equalsIgnoreCase("E"))
    				{
    					strFlag="C";
    				}else
    				{
    					strFlag="EC";	
    				}
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumPlantExi)));
   					arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumPlant)));
   					arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumPlanttot)));
    				arrValueRow.add(arrValueCol);
    			}
    			if(dblSumDep>0 || dblSumDepExi>0 || dblSumDeptot>0)
    			{
    				arrValueCol = new ArrayList();
    				arrValueCol.add("Deposits [Common]");
    				if(!strFlag.equalsIgnoreCase("E"))
    				{
    					strFlag="C";
    				}else
    				{
    					strFlag="EC";	
    				}
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumDepExi)));
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumDep)));
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumDeptot)));
    				arrValueRow.add(arrValueCol);
    			}
    			if(dblSumCost>0 || dblSumCostExi>0 || dblSumCosttot>0)
    			{
    				arrValueCol = new ArrayList();
    				arrValueCol.add("Cash Margin [Common]");
    				if(!strFlag.equalsIgnoreCase("E"))
    				{
    					strFlag="C";
    				}else
    				{
    					strFlag="EC";	
    				}
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumCostExi)));
   					arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumCost)));
   					arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumCosttot)));
    				arrValueRow.add(arrValueCol);
    			}
    			if(dblSumFixed>0 || dblSumFixedExi>0 || dblSumFixedtot>0)
    			{
    				arrValueCol = new ArrayList();
    				arrValueCol.add("Fixed Assets [Common]");
    				if(!strFlag.equalsIgnoreCase("E"))
    				{
    					strFlag="C";
    				}else
    				{
    					strFlag="EC";	
    				}
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumFixedExi)));
   					arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumFixed)));
   					arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumFixedtot)));
    				arrValueRow.add(arrValueCol);
    			}
    			if(dblSumOth>0 || dblSumOthExi>0 || dblSumOthtot>0)
    			{
    				arrValueCol = new ArrayList();
    				arrValueCol.add("Others [Common]");
    				if(!strFlag.equalsIgnoreCase("E"))
    				{
    					strFlag="C";
    				}else
    				{
    					strFlag="EC";	
    				}
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumOthExi)));
   					arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumOth)));
   					arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumOthtot)));
    				arrValueRow.add(arrValueCol);
    			}
    			
    			hshResult.put("arrValueRow", arrValueRow);
    			hshResult.put("strSecId", strSecid);
    			hshResult.put("strFlag", strFlag);
    	}
    	catch(Exception e)
    	{
    		log.error(e.toString());
    		throw new EJBException("Error in getSum "+e.toString());
    	}
		return hshResult;
    }
    
    private HashMap getSumoth(HashMap hshValues) 
    {
    	int intSeccate=0;
		String strSecname="";
		String strSecid="";
		HashMap hshResult = new HashMap(); 
		double dblSumProperties=0.00,dblSumPlant=0.00,dblSumDep=0.00,dblSumCost=0.00,dblSumFixed=0.00,dblSumOth=0.00,
		dblSumPropExi=0.00,dblSumPlantExi=0.00,dblSumDepExi=0.00,dblSumCostExi=0.00,dblSumFixedExi=0.00,dblSumOthExi=0.00;
		double dblSumProptot=0.00,dblSumDeptot=0.00,dblSumCosttot=0.00,dblSumFixedtot=0.00,dblSumOthtot=0.00,dblSumPlanttot=0.00;
		String strValuesin=Helper.correctNull((String)hshValues.get("valuesin")),strFlag="";
		ArrayList arrSecidRow = new ArrayList();
		ArrayList arrSecidCol = new ArrayList();
		ArrayList arrValueRow = new ArrayList();
		ArrayList arrValueCol = new ArrayList();
		ArrayList arrValueTotRow = new ArrayList();
		ArrayList arrValueTotCol = new ArrayList();
		ArrayList arrValueTempcol = new ArrayList();
		try
    	{
    
    		//Exclusive Security Existing amount
			strSecid=Helper.correctNull((String)hshValues.get("strAttachedSecurityid"));
    		arrSecidRow = (ArrayList)hshValues.get("arrExisidExc"); 
    		for(int k=0;k<arrSecidRow.size();k++)
    		{
    			arrSecidCol = (ArrayList)arrSecidRow.get(k);
    			arrValueTotCol = new ArrayList();
    			arrValueTotCol.add(arrSecidCol.get(0));
    			arrValueTotCol.add(arrSecidCol.get(1));
    			arrValueTotCol.add(arrSecidCol.get(2));
    			arrValueTotCol.add(arrSecidCol.get(3));
    			arrValueTotRow.add(arrValueTotCol);
    		}
    		for(int k=0;k<arrSecidRow.size();k++)
    		{
    			arrSecidCol = (ArrayList)arrSecidRow.get(k);
    			intSeccate=Integer.parseInt(Helper.correctInt((String)arrSecidCol.get(2)));
    			if(intSeccate>=10 && intSeccate<=17)
    			{
    				dblSumPropExi+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
    				if(strSecid.equalsIgnoreCase(""))
    				{
    					strSecid="'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";			
    				}else
    				{
    					strSecid=strSecid+",'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";
    				}
    			}else if(intSeccate==19)
    			{
    				dblSumPlantExi+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
    				if(strSecid.equalsIgnoreCase(""))
    				{
    					strSecid="'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";			
    				}else
    				{
    					strSecid=strSecid+",'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";
    				}
    			}
    			else if(intSeccate==7)
    			{
    				dblSumDepExi+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
    				if(strSecid.equalsIgnoreCase(""))
    				{
    					strSecid="'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";			
    				}else
    				{
    					strSecid=strSecid+",'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";
    				}
    			}
    			else if(intSeccate==2)
    			{
    				dblSumCostExi+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
    				if(strSecid.equalsIgnoreCase(""))
    				{
    					strSecid="'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";			
    				}else
    				{
    					strSecid=strSecid+",'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";
    				}
    			}
    			else if(intSeccate==18 || intSeccate==20 || intSeccate==23)
    			{
    				dblSumFixedExi+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
    				if(strSecid.equalsIgnoreCase(""))
    				{
    					strSecid="'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";			
    				}else
    				{
    					strSecid=strSecid+",'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";
    				}
    			}
    			else if(intSeccate==5 || intSeccate==6 || intSeccate==8 || intSeccate==24 || intSeccate==9 || intSeccate==21 || intSeccate==22)
    			{
    				dblSumOthExi+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
    				if(strSecid.equalsIgnoreCase(""))
    				{
    					strSecid="'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";			
    				}else
    				{
    					strSecid=strSecid+",'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";
    				}
    			}
    		}
    		
    		//for total Exclusive security value
    		for(int k=0;k<arrValueTotRow.size();k++)
    		{
    			arrSecidCol = (ArrayList)arrValueTotRow.get(k);
    			intSeccate=Integer.parseInt(Helper.correctInt((String)arrSecidCol.get(2)));
    			if(intSeccate>=10 && intSeccate<=17)
    			{
    				dblSumProptot+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
    			}else if(intSeccate==19)
    			{
    				dblSumPlanttot+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
    			}
    			else if(intSeccate==7)
    			{
    				dblSumDeptot+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
    			}
    			else if(intSeccate==2)
    			{
    				dblSumCosttot+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
    			}
    			else if(intSeccate==18 || intSeccate==20 || intSeccate==23)
    			{
    				dblSumFixedtot+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
    			}
    			else if(intSeccate==5 || intSeccate==6 || intSeccate==8 || intSeccate==24 || intSeccate==9 || intSeccate==21 || intSeccate==22)
    			{
    				dblSumOthtot+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
    			}
    		}
    			if(dblSumProperties>0 || dblSumPropExi>0 || dblSumProptot>0)
    			{
    				arrValueCol = new ArrayList();
    				arrValueCol.add("Properties [Exclusive]");
    				strFlag="E";
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumPropExi)));
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumProperties)));
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumProptot)));
    				arrValueRow.add(arrValueCol);
    			}
    			if(dblSumPlant>0 || dblSumPlantExi>0 || dblSumPlanttot>0)
    			{
    				arrValueCol = new ArrayList();
    				arrValueCol.add("Plant and Machinery [Exclusive]");
    				strFlag="E";
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumPlantExi)));
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumPlant)));
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumPlanttot)));
    				arrValueRow.add(arrValueCol);
    			}
    			if(dblSumDep>0 || dblSumDepExi>0 || dblSumDeptot>0)
    			{
    				arrValueCol = new ArrayList();
    				arrValueCol.add("Deposits [Exclusive]");
    				strFlag="E";
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumDepExi)));
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumDep)));
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumDeptot)));
    				arrValueRow.add(arrValueCol);
    			}
    			if(dblSumCost>0 || dblSumCostExi>0 || dblSumCosttot>0)
    			{
    				arrValueCol = new ArrayList();
    				arrValueCol.add("Cash Margin [Exclusive]");
    				strFlag="E";
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumCostExi)));
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumCost)));
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumCosttot)));
    				arrValueRow.add(arrValueCol);
    			}
    			if(dblSumFixed>0 || dblSumFixedExi>0 || dblSumFixedtot>0)
    			{
    				arrValueCol = new ArrayList();
    				arrValueCol.add("Fixed Assets [Exclusive]");
    				strFlag="E";
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumFixedExi)));
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumFixed)));
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumFixedtot)));
    				arrValueRow.add(arrValueCol);
    			}
    			if(dblSumOth>0 || dblSumOthExi>0 || dblSumOthtot>0)
    			{
    				arrValueCol = new ArrayList();
    				arrValueCol.add("Others [Exclusive]");
    				strFlag="E";
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumOthExi)));
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumOth)));
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumOthtot)));
    				arrValueRow.add(arrValueCol);
    			}
    			
    			
    			dblSumProperties=0.00;dblSumPlant=0.00;dblSumDep=0.00;dblSumCost=0.00;dblSumFixed=0.00;dblSumOth=0.00;
    			dblSumPropExi=0.00;dblSumPlantExi=0.00;dblSumDepExi=0.00;dblSumCostExi=0.00;dblSumFixedExi=0.00;dblSumOthExi=0.00;
    			dblSumProptot=0.00;dblSumDeptot=0.00;dblSumCosttot=0.00;dblSumFixedtot=0.00;dblSumOthtot=0.00;dblSumPlanttot=0.00;
    			
        		//Common Security Existing amount
        		 boolean bolFlag=true;
        		 arrValueTotRow=new ArrayList();
         		 arrSecidRow = (ArrayList)hshValues.get("arrExisecidcom");
     			for(int k=0;k<arrSecidRow.size();k++)
         		{
         			arrSecidCol = (ArrayList)arrSecidRow.get(k);
         			String intSecid=Helper.correctInt((String)arrSecidCol.get(0));
         			String intSecid1="";
         			for(int j=0;j<arrValueTotRow.size();j++)
         			{
         				 bolFlag=true;
         				arrValueTempcol=(ArrayList)arrValueTotRow.get(j);
         				intSecid1=Helper.correctInt((String)arrValueTempcol.get(0));
         				if(intSecid1.equalsIgnoreCase(intSecid))
         				{
         					bolFlag=false;
         					break;
         				}
         			}
         			if(bolFlag)
         			{
         				arrValueTotCol = new ArrayList();
             			arrValueTotCol.add(arrSecidCol.get(0));
             			arrValueTotCol.add(arrSecidCol.get(1));
             			arrValueTotCol.add(arrSecidCol.get(2));
             			arrValueTotCol.add(arrSecidCol.get(3));
             			arrValueTotRow.add(arrValueTotCol);
             		}
         			
         		}
        		for(int k=0;k<arrSecidRow.size();k++)
        		{
        			arrSecidCol = (ArrayList)arrSecidRow.get(k);
        			intSeccate=Integer.parseInt(Helper.correctInt((String)arrSecidCol.get(2)));
        			if(intSeccate>=10 && intSeccate<=17)
        			{
        				dblSumPropExi+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
        				if(strSecid.equalsIgnoreCase(""))
        				{
        					strSecid="'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";			
        				}else
        				{
        					strSecid=strSecid+",'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";
        				}
        			}else if(intSeccate==19)
        			{
        				dblSumPlantExi+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
        				if(strSecid.equalsIgnoreCase(""))
        				{
        					strSecid="'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";			
        				}else
        				{
        					strSecid=strSecid+",'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";
        				}
        			}
        			else if(intSeccate==7)
        			{
        				dblSumDepExi+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
        				if(strSecid.equalsIgnoreCase(""))
        				{
        					strSecid="'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";			
        				}else
        				{
        					strSecid=strSecid+",'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";
        				}
        			}
        			else if(intSeccate==2)
        			{
        				dblSumCostExi+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
        				if(strSecid.equalsIgnoreCase(""))
        				{
        					strSecid="'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";			
        				}else
        				{
        					strSecid=strSecid+",'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";
        				}
        			}
        			else if(intSeccate==18 || intSeccate==20 || intSeccate==23)
        			{
        				dblSumFixedExi+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
        				if(strSecid.equalsIgnoreCase(""))
        				{
        					strSecid="'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";			
        				}else
        				{
        					strSecid=strSecid+",'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";
        				}
        			}
        			else if(intSeccate==5 || intSeccate==6 || intSeccate==8 || intSeccate==24 || intSeccate==9 || intSeccate==21 || intSeccate==22)
        			{
        				dblSumOthExi+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
        				if(strSecid.equalsIgnoreCase(""))
        				{
        					strSecid="'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";			
        				}else
        				{
        					strSecid=strSecid+",'"+Helper.correctNull((String)arrSecidCol.get(0))+"'";
        				}
        			}
        		}
        		//for total Common security value
        		for(int k=0;k<arrValueTotRow.size();k++)
        		{
        			arrSecidCol = (ArrayList)arrValueTotRow.get(k);
        			intSeccate=Integer.parseInt(Helper.correctInt((String)arrSecidCol.get(2)));
        			if(intSeccate>=10 && intSeccate<=17)
        			{
        				dblSumProptot+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
        			}else if(intSeccate==19)
        			{
        				dblSumPlanttot+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
        			}
        			else if(intSeccate==7)
        			{
        				dblSumDeptot+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
        			}
        			else if(intSeccate==2)
        			{
        				dblSumCosttot+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
        			}
        			else if(intSeccate==18 || intSeccate==20 || intSeccate==23)
        			{
        				dblSumFixedtot+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
        			}
        			else if(intSeccate==5 || intSeccate==6 || intSeccate==8 || intSeccate==24 || intSeccate==9 || intSeccate==21 || intSeccate==22)
        			{
        				dblSumOthtot+=Double.parseDouble(Helper.correctDouble((String)arrSecidCol.get(3)));
        			}
        		}
        		if(dblSumProperties>0 || dblSumPropExi>0 || dblSumProptot>0)
    			{
    				arrValueCol = new ArrayList();
    				arrValueCol.add("Properties [Common]");
    				if(strFlag.equalsIgnoreCase(""))
    				{
    					strFlag="C";
    				}else
    				{
    					strFlag="EC";	
    				}
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumPropExi)));
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumProperties)));
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumProptot)));
    				arrValueRow.add(arrValueCol);
    			}
    			if(dblSumPlant>0 || dblSumPlantExi>0 || dblSumPlanttot>0)
    			{
    				arrValueCol = new ArrayList();
    				arrValueCol.add("Plant and Machinery [Common]");
    				if(strFlag.equalsIgnoreCase(""))
    				{
    					strFlag="C";
    				}else
    				{
    					strFlag="EC";	
    				}
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumPlantExi)));
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumPlant)));
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumPlanttot)));
    				arrValueRow.add(arrValueCol);
    			}
    			if(dblSumDep>0 || dblSumDepExi>0 || dblSumDeptot>0)
    			{
    				arrValueCol = new ArrayList();
    				arrValueCol.add("Deposits [Common]");
    				if(strFlag.equalsIgnoreCase(""))
    				{
    					strFlag="C";
    				}else
    				{
    					strFlag="EC";	
    				}
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumDepExi)));
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumDep)));
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumDeptot)));
    				arrValueRow.add(arrValueCol);
    			}
    			if(dblSumCost>0 || dblSumCostExi>0 || dblSumCosttot>0)
    			{
    				arrValueCol = new ArrayList();
    				arrValueCol.add("Cash Margin [Common]");
    				if(strFlag.equalsIgnoreCase(""))
    				{
    					strFlag="C";
    				}else
    				{
    					strFlag="EC";	
    				}
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumCostExi)));
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumCost)));
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumCosttot)));
    				arrValueRow.add(arrValueCol);
    			}
    			if(dblSumFixed>0 || dblSumFixedExi>0 || dblSumFixedtot>0)
    			{
    				arrValueCol = new ArrayList();
    				arrValueCol.add("Fixed Assets [Common]");
    				if(strFlag.equalsIgnoreCase(""))
    				{
    					strFlag="C";
    				}else
    				{
    					strFlag="EC";	
    				}
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumFixedExi)));
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumFixed)));
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumFixedtot)));
    				arrValueRow.add(arrValueCol);
    			}
    			if(dblSumOth>0 || dblSumOthExi>0 || dblSumOthtot>0)
    			{
    				arrValueCol = new ArrayList();
    				arrValueCol.add("Others [Common]");
    				if(strFlag.equalsIgnoreCase(""))
    				{
    					strFlag="C";
    				}else
    				{
    					strFlag="EC";	
    				}
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumOthExi)));
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumOth)));
    				arrValueCol.add(Helper.correctDouble((String)Helper.convertSetupToApplicationValues(strValuesin, dblSumOthtot)));
    				arrValueRow.add(arrValueCol);
    			}
    			
    			hshResult.put("arrValueRow", arrValueRow);
    			hshResult.put("strSecId", strSecid);
    			hshResult.put("strFlag", strFlag);
    	}
    	catch(Exception e)
    	{
    		log.error(e.toString());
    		throw new EJBException("Error in getSum "+e.toString());
    	}
		return hshResult;
    }
   
    public HashMap updateSecurityOwnerChange(HashMap hshRequestValues)
    {
    	
    	ResultSet rs=null,rs1=null;
    	HashMap hshResult=new HashMap();
    	HashMap hshQueryValues=new HashMap();
    	HashMap hshQuery=new HashMap();
    	ArrayList arrValues=new ArrayList();
    	String strAction=Helper.correctNull((String)hshRequestValues.get("hidAction"));
    	String strSecurityId=Helper.correctNull((String)hshRequestValues.get("txt_secid"));
    	String strUserID=Helper.correctNull((String)hshRequestValues.get("strUserId"));
    	if(strSecurityId.equalsIgnoreCase(""))
    	strSecurityId=Helper.correctNull((String)hshRequestValues.get("hidSecurityId"));
    	String strQuery="";
    	StringBuilder strBuff=new StringBuilder();
    	boolean bFlag=true;
    	try
    	{
    		
    		
    		if(strAction.equalsIgnoreCase("change"))
			{
    			
    			strQuery=SQLParser.getSqlQuery("sel_securities_ownershipchk^"+Helper.correctNull((String)hshRequestValues.get("txt_newsecownerid"))+"^"+strSecurityId
    					+"^"+Helper.correctNull((String)hshRequestValues.get("txt_newsecownerid"))+"^"+strSecurityId);
    			rs=DBUtils.executeQuery(strQuery);
    			while(rs.next())
    			{
    				if(rs1!=null)
    					rs1.close();
    				strQuery=SQLParser.getSqlQuery("sel_comdemographicschk^"+Helper.correctNull(rs.getString("appno"))+"^"+Helper.correctNull((String)hshRequestValues.get("txt_newsecownerid")));
        			rs1=DBUtils.executeQuery(strQuery);
    				if(!rs1.next())
    				{
    					if(Helper.correctNull(rs.getString("DEMO_OLDAPPID")).equalsIgnoreCase(""))
        				{
        					strBuff.append(Helper.correctNull(rs.getString("app_no"))).append(",");
        					bFlag=false;
        				}
    				}
    				
    			}
    			
    			if(!bFlag)
    			{
    				log.info("Exception in updateSecurityOwnerChange");
    				throw new Exception(strBuff.toString());
    			}
    			hshQueryValues.put("size","2");
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(strSecurityId);
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("hidDemoId")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_newsecownerid")));
				arrValues.add(strUserID);
				arrValues.add("op");
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("strOrgShortCode")));
				hshQuery.put("arrValues", arrValues);				
				hshQuery.put("strQueryId","ins_cussecurityownershiptemp");
				hshQueryValues.put("1", hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add("W");
				arrValues.add(strSecurityId);
				hshQuery.put("arrValues", arrValues);				
				hshQuery.put("strQueryId","upd_cussecurities_changeflag");
				hshQueryValues.put("2", hshQuery);
			}
    		else if(strAction.equalsIgnoreCase("delete"))
			{
    			hshQueryValues.put("size","2");
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(strSecurityId);
				hshQuery.put("arrValues", arrValues);				
				hshQuery.put("strQueryId","del_cussecurityownershiptemp");
				hshQueryValues.put("1", hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add("N");
				arrValues.add(strSecurityId);
				hshQuery.put("arrValues", arrValues);				
				hshQuery.put("strQueryId","upd_cussecurities_changeflag");
				hshQueryValues.put("2", hshQuery);
			} 
    		else if(strAction.equalsIgnoreCase("receive"))
			{
    			hshQueryValues.put("size","1");
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(strUserID);
				arrValues.add(strSecurityId);
				hshQuery.put("arrValues", arrValues);				
				hshQuery.put("strQueryId","upd_cussecurities_receiveflag");
				hshQueryValues.put("1", hshQuery);
			} 
    		else if(strAction.equalsIgnoreCase("approve"))
    		{
    			hshQueryValues.put("size","4");
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add("pa");
				arrValues.add(strSecurityId);
				hshQuery.put("arrValues", arrValues);				
				hshQuery.put("strQueryId","upd_cussecurities_approveflag");
				hshQueryValues.put("1", hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add("N");
				arrValues.add(strSecurityId);
				hshQuery.put("arrValues", arrValues);				
				hshQuery.put("strQueryId","upd_cussecurities_changeflag");
				hshQueryValues.put("2", hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_newsecownerid")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("hidDemoId")));
				arrValues.add(strSecurityId);
				hshQuery.put("arrValues", arrValues);				
				hshQuery.put("strQueryId","upd_cussecurities_ownership");
				hshQueryValues.put("3", hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_newsecownerid")));
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_newsecownerid")));
				arrValues.add(strSecurityId);
				arrValues.add(Helper.correctNull((String)hshRequestValues.get("hidDemoId")));
				arrValues.add(strSecurityId);
				hshQuery.put("arrValues", arrValues);				
				hshQuery.put("strQueryId","upd_securityownershipapprove");
				hshQueryValues.put("4", hshQuery);
    		} 
    		else if(strAction.equalsIgnoreCase("reject"))
    		{
    			hshQueryValues.put("size","2");
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add("pr");
				arrValues.add(strSecurityId);
				hshQuery.put("arrValues", arrValues);				
				hshQuery.put("strQueryId","upd_cussecurities_approveflag");
				hshQueryValues.put("1", hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add("N");
				arrValues.add(strSecurityId);
				hshQuery.put("arrValues", arrValues);				
				hshQuery.put("strQueryId","upd_cussecurities_changeflag");
				hshQueryValues.put("2", hshQuery);
    		} 
    		else if(strAction.equalsIgnoreCase("revert"))
    		{
    			hshQueryValues.put("size","1");
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add("");
				arrValues.add(strSecurityId);
				hshQuery.put("arrValues", arrValues);				
				hshQuery.put("strQueryId","upd_cussecurities_receiveflag");
				hshQueryValues.put("1", hshQuery);
    		} 
    		EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
    		
    		return hshResult;
    		
    	}
    	catch(Exception e)
    	{
			throw new EJBException(e.getMessage());
		}
    	finally
    	{
    		try{ 			
    			hshResult=getSecurityOwnerChange(hshRequestValues);
    			if(bFlag)
    			{
	        		if(strAction.equalsIgnoreCase("delete"))
	    			{
	        			hshResult.put("strStatus","CRequest");
	    			}
	        		if(strAction.equalsIgnoreCase("revert"))
	        		{
	        			hshResult.put("strStatus","Revert");
	        		}
	        		if(strAction.equalsIgnoreCase("approve"))
	        		{
	        			hshResult.put("strStatus","Approve");
	        			hshResult.put("strname",Helper.correctNull((String)hshRequestValues.get("txt_secownername")));//11
	        		}
	        		if(strAction.equalsIgnoreCase("reject"))
	        		{
	        			hshResult.put("strStatus","Reject");
	        		}
	        		if(strAction.equalsIgnoreCase("change"))
	        		{
	        			hshResult.put("strStatus","Success");
	        		}
	        		
    			}
    			else
    			{
    				strBuff.replace(strBuff.length()-1, strBuff.length(), "");
    				hshResult.put("strError",strBuff.toString());
    			}
    			return hshResult;
        		
    		}
    		catch(Exception ce)
    		{
    			
    		}
    	}
    }
    
    
    public HashMap updateSecurityApproval(HashMap hshRequestValues)
    {
    	ResultSet rs=null,rs1=null;
    	HashMap hshResult=new HashMap();
    	HashMap hshQueryValues=new HashMap();
    	HashMap hshQuery=new HashMap();
    	java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
		nf.setGroupingUsed(false);
		ArrayList arrValues=new ArrayList();
    	String strAction=Helper.correctNull((String)hshRequestValues.get("hidAction"));
    	String strSecurityId=Helper.correctNull((String)hshRequestValues.get("txt_secid"));
    	String strUserID=Helper.correctNull((String)hshRequestValues.get("strUserId"));
    	if(strSecurityId.equalsIgnoreCase(""))
    	strSecurityId=Helper.correctNull((String)hshRequestValues.get("hidSecurityId"));
    	String strQuery="";
    	StringBuilder strBuff=new StringBuilder();
    	boolean bFlag=true;
    	String strSecFlag=Helper.correctNull((String)hshRequestValues.get("hidSEC_FLAG"));
    	try
    	{
    		if(strAction.equalsIgnoreCase("receive"))
			{
    			hshQueryValues.put("size","1");
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(strUserID);
				arrValues.add(strSecurityId);
				hshQuery.put("arrValues", arrValues);				
				hshQuery.put("strQueryId","upd_cussecuritiesVerify_receiveflag");
				hshQueryValues.put("1", hshQuery);
			} 
    		else if(strAction.equalsIgnoreCase("approve"))
    		{
    			hshQueryValues.put("size","2");
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add("pa");
				arrValues.add(strSecurityId);
				hshQuery.put("arrValues", arrValues);				
				hshQuery.put("strQueryId","upd_cussecuritiesVerify_approveflag");
				hshQueryValues.put("1", hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add("N");
				arrValues.add(strSecurityId);
				hshQuery.put("arrValues", arrValues);				
				hshQuery.put("strQueryId","upd_cussecurities_changeflag");
				hshQueryValues.put("2", hshQuery);
				
				hshQueryValues.put("size","3");
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(strUserID);
				arrValues.add(strSecurityId);
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId","updsecuappuserid");
				hshQueryValues.put("3", hshQuery);
				

    		} 
    		else if(strAction.equalsIgnoreCase("reject")||strAction.equalsIgnoreCase("rollback"))
    		{
    			int hshqrySize=1;
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				if(strAction.equalsIgnoreCase("rollback"))
				arrValues.add("rb");
				else
				arrValues.add("pr");
				arrValues.add(strSecurityId);
				hshQuery.put("arrValues", arrValues);				
				hshQuery.put("strQueryId","upd_cussecuritiesVerify_approveflag");
				hshQueryValues.put(Integer.toString(hshqrySize), hshQuery);
				
				
				if(strSecFlag.equals("N"))
			   {
					hshqrySize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					arrValues.add("F");
					arrValues.add(strSecurityId);
					hshQuery.put("arrValues", arrValues);				
					hshQuery.put("strQueryId","upd_cussecurities_changeflag");
					hshQueryValues.put(Integer.toString(hshqrySize), hshQuery);
				}
				else
				{
					hshqrySize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					arrValues.add("N");
					arrValues.add(strSecurityId);
					hshQuery.put("arrValues", arrValues);				
					hshQuery.put("strQueryId","upd_cussecurities_changeflag");
					hshQueryValues.put(Integer.toString(hshqrySize), hshQuery);
				}
				
				double totsec_old=0.00,netsec_old=0.00,amtcharged_old=0.00;
				double totsec_new=0.00,netsec_new=0.00,amtcharged_new=0.00;
				if(!Helper.correctNull((String)hshRequestValues.get("txt_SECURITYVALUE_OLD")).equals(""))
				{
					netsec_old= Double.parseDouble(Helper.correctDouble((String)hshRequestValues.get("txt_SECURITYVALUE_OLD")));
					amtcharged_old=Double.parseDouble(Helper.correctDouble((String)hshRequestValues.get("hidSEC_AMTCHARGED_OLD")));
					totsec_old=netsec_old+amtcharged_old;
					
					hshqrySize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					arrValues.add(nf.format(netsec_old));
					arrValues.add(nf.format(totsec_old));
					arrValues.add(nf.format(amtcharged_old));
					arrValues.add("");
					arrValues.add(strSecurityId);
					hshQuery.put("arrValues", arrValues);				
					hshQuery.put("strQueryId","upd_cussec_verifyReject_secValue");
					hshQueryValues.put(Integer.toString(hshqrySize), hshQuery);
					
					hshqrySize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					arrValues.add("Net Security Value");
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_SECURITYVALUE_NEW")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_SECURITYVALUE_OLD")));
					arrValues.add(strUserID);
					arrValues.add(strSecurityId);
					hshQuery.put("arrValues", arrValues);				
					hshQuery.put("strQueryId","ins_sec_modified");
					hshQueryValues.put(Integer.toString(hshqrySize), hshQuery);
				
					if(Helper.correctNull((String)hshRequestValues.get("hidSEC_AMTCHARGED_OLD")).equals(""))
					{
						netsec_new= Double.parseDouble(Helper.correctDouble((String)hshRequestValues.get("txt_SECURITYVALUE_new")));
						amtcharged_new=Double.parseDouble(Helper.correctDouble((String)hshRequestValues.get("hidSEC_AMTCHARGED_new")));
						totsec_new=netsec_new+amtcharged_new;
						
						hshqrySize++;
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						arrValues.add("Total Security Value");
						arrValues.add(nf.format(totsec_new));
						arrValues.add(nf.format(totsec_old));
						arrValues.add(strUserID);
						arrValues.add(strSecurityId);
						hshQuery.put("arrValues", arrValues);				
						hshQuery.put("strQueryId","ins_sec_modified");
						hshQueryValues.put(Integer.toString(hshqrySize), hshQuery);
					}
					else
					{
						hshqrySize++;
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						arrValues.add("Amount charged to Institution");
						arrValues.add(Helper.correctDouble((String)hshRequestValues.get("hidSEC_AMTCHARGED_new")));
						arrValues.add(Helper.correctDouble((String)hshRequestValues.get("hidSEC_AMTCHARGED_old")));
						arrValues.add(strUserID);
						arrValues.add(strSecurityId);
						hshQuery.put("arrValues", arrValues);				
						hshQuery.put("strQueryId","ins_sec_modified");
						hshQueryValues.put(Integer.toString(hshqrySize), hshQuery);
					}
				}
				
				if(!Helper.correctNull((String)hshRequestValues.get("txt_VALUERNAME_OLD")).equals(""))
				{
					hshqrySize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_VALUERNAME_OLD")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_VALUERCODE_OLD")));
					arrValues.add(strSecurityId);
					hshQuery.put("arrValues", arrValues);				
					hshQuery.put("strQueryId","upd_cussec_verifyReject_valuername");
					hshQueryValues.put(Integer.toString(hshqrySize), hshQuery);
					
					hshqrySize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					arrValues.add("Valuer Name" );
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_VALUERNAME_OLD")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_VALUERNAME_NEW")));
					arrValues.add(strUserID);
					arrValues.add(strSecurityId);
					hshQuery.put("arrValues", arrValues);				
					hshQuery.put("strQueryId","ins_sec_modified");
					hshQueryValues.put(Integer.toString(hshqrySize), hshQuery);
					
				}
				if(!Helper.correctNull((String)hshRequestValues.get("txt_VALUATIONDATE_OLD")).equals(""))
				{
					hshqrySize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_VALUATIONDATE_OLD")));
					arrValues.add(strSecurityId);
					hshQuery.put("arrValues", arrValues);				
					hshQuery.put("strQueryId","upd_cussec_verifyReject_datevalua");
					hshQueryValues.put(Integer.toString(hshqrySize), hshQuery);
					
					hshqrySize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					arrValues.add("Date of Valuation");
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_VALUATIONDATE_OLD")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_VALUATIONDATE_NEW")));
					arrValues.add(strUserID);
					arrValues.add(strSecurityId);
					hshQuery.put("arrValues", arrValues);				
					hshQuery.put("strQueryId","ins_sec_modified");
					hshQueryValues.put(Integer.toString(hshqrySize), hshQuery);
				}
				
				if(!Helper.correctNull((String)hshRequestValues.get("txt_VALUERVALUE_OLD")).equals(""))
				{
					hshqrySize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_VALUERVALUE_OLD")));
					arrValues.add(strSecurityId);
					hshQuery.put("arrValues", arrValues);				
					hshQuery.put("strQueryId","update_SEC_VALUERVALUE_old");
					hshQueryValues.put(Integer.toString(hshqrySize), hshQuery);
					
					hshqrySize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					arrValues.add("Value as per valuation");
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_VALUERVALUE_OLD")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_VALUERVALUE_NEW")));
					arrValues.add(strUserID);
					arrValues.add(strSecurityId);
					hshQuery.put("arrValues", arrValues);				
					hshQuery.put("strQueryId","ins_sec_modified");
					hshQueryValues.put(Integer.toString(hshqrySize), hshQuery);
				}
				
				
				if(!Helper.correctNull((String)hshRequestValues.get("txt_SALEVALUE_OLD")).equals(""))
				{
					hshqrySize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_SALEVALUE_OLD")));
					arrValues.add(strSecurityId);
					hshQuery.put("arrValues", arrValues);				
					hshQuery.put("strQueryId","update_SEC_SALEVALUE_old");
					hshQueryValues.put(Integer.toString(hshqrySize), hshQuery);
					
					hshqrySize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					arrValues.add("Forced sale value");
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_SALEVALUE_OLD")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_SALEVALUE_NEW")));
					arrValues.add(strUserID);
					arrValues.add(strSecurityId);
					hshQuery.put("arrValues", arrValues);				
					hshQuery.put("strQueryId","ins_sec_modified");
					hshQueryValues.put(Integer.toString(hshqrySize), hshQuery);
				}
				
				hshQueryValues.put("size",Integer.toString(hshqrySize));
    		} 
    		else if(strAction.equalsIgnoreCase("revert"))
    		{
    			hshQueryValues.put("size","1");
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add("");
				arrValues.add(strSecurityId);
				hshQuery.put("arrValues", arrValues);				
				hshQuery.put("strQueryId","upd_cussecuritiesVerify_receiveflag");
				hshQueryValues.put("1", hshQuery);
    		} 
    		EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
    		
    		if(strAction.equalsIgnoreCase("approve") && Helper.correctNull(ApplicationParams.getMONITORINGDBENABLED()).equalsIgnoreCase("YES"))
			{
    			if(!Helper.correctNull((String)hshRequestValues.get("txt_VALUATIONDATE_NEW")).equals(""))
    			{
					arrValues = new ArrayList();
					hshQueryValues = new HashMap();
					hshQuery=new HashMap();
					hshQuery.put("strQueryId","update_secvaluationdate_monitoring");	
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_VALUATIONDATE_NEW")));
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_VALUATIONDATE_NEW")));
					arrValues.add(strSecurityId);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");	
		         	EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateMonitoringData");
    			}
    			if(!Helper.correctNull((String)hshRequestValues.get("txt_VALUERNAME_NEW")).equals(""))
    			{
					arrValues = new ArrayList();
					hshQueryValues = new HashMap();
					hshQuery=new HashMap();
					hshQuery.put("strQueryId","update_secvaluername_monitoring");	
					arrValues.add(Helper.correctNull((String)hshRequestValues.get("txt_VALUERNAME_NEW")));
					arrValues.add(strSecurityId);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");	
		         	EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateMonitoringData");
    			}
			}
    		
    		return hshResult;
    		
    	}
    	catch(Exception e)
    	{
			throw new EJBException(e.getMessage());
		}
    	finally
    	{
    		try{ 			
    			hshResult=getSecurityApproval(hshRequestValues);
    			if(bFlag)
    			{
	        		if(strAction.equalsIgnoreCase("revert"))
	        		{
	        			hshResult.put("strStatus","Revert");
	        		}
	        		if(strAction.equalsIgnoreCase("approve"))
	        		{
	        			hshResult.put("strStatus","Approve");
	        			hshResult.put("strname",Helper.correctNull((String)hshRequestValues.get("txt_secownername")));//11
	        		}
	        		if(strAction.equalsIgnoreCase("reject"))
	        		{
	        			hshResult.put("strStatus","Reject");
	        		}
	        		if(strAction.equalsIgnoreCase("change"))
	        		{
	        			hshResult.put("strStatus","Success");
	        		}
	        		if(strAction.equalsIgnoreCase("rollback"))
	        		{
	        			hshResult.put("strStatus","Rollback");
	        		}
	        		
    			}
    			else
    			{
    				strBuff.replace(strBuff.length()-1, strBuff.length(), "");
    				hshResult.put("strError",strBuff.toString());
    			}
    			return hshResult;
        		
    		}
    		catch(Exception ce)
    		{
    			
    		}
    	}
    }
    
    public HashMap getSecurityApproval(HashMap hshRequestValues)
    {
    	java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
    	
    	ResultSet rs=null,rs1=null;
    	String strQuery="",strUserID="", strSecID=null,strAction="";
    	strSecID = Helper.correctNull((String)hshRequestValues.get("txt_secid"));
    	if(strSecID.equalsIgnoreCase(""))
    		strSecID = Helper.correctNull((String)hshRequestValues.get("hidSecurityId"));
    	strUserID = Helper.correctNull((String)hshRequestValues.get("strUserId"));
    	strAction = Helper.correctNull((String)hshRequestValues.get("hidAction"));
    	try
    	{
	    	strQuery=SQLParser.getSqlQuery("sel_securityApproval_temp^"+strSecID);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{  	
				hshRequestValues.put("strsecid",correctNull(rs.getString("cus_sec_id")));//0
				hshRequestValues.put("strsecdesc",Helper.CLOBToString(rs.getClob("cus_sec_security_description")));//1
				hshRequestValues.put("strsecvalue",jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("cus_sec_netsecurity")))));//2
				if(rs1 !=null)
					rs1.close();
				rs1 = DBUtils.executeLAPSQuery("selstaticdata_securitytype_sel^"+correctNull(rs.getString("cus_sec_type")));
				if(rs1.next())
				{
					hshRequestValues.put("strsecname",correctNull(rs1.getString("sec_name")));//3
				}
				if(rs1 !=null)
					rs1.close();
				rs1 = DBUtils.executeLAPSQuery("selstaticdata_securitytype_sel^"+correctNull(rs.getString("cus_sec_classification")));
				if(rs1.next())
				{
					hshRequestValues.put("strsectype",correctNull(rs1.getString("sec_name")));//4
				}
				
				hshRequestValues.put("strexappname",Helper.correctNull(rs.getString("exappname")));//5
				hshRequestValues.put("strexappid",Helper.correctNull(rs.getString("exapplapsid")));//6
				hshRequestValues.put("strexappcbsid",Helper.correctNull(rs.getString("exappcbsid")));//7
				hshRequestValues.put("strseccreatedby",Helper.correctNull(rs.getString("SEC_CREATEDBY")));//8
				hshRequestValues.put("strsecapprovedby",Helper.correctNull(rs.getString("SEC_APPROVEDBY")));//9
				
				if(!Helper.correctNull(rs.getString("SEC_APPROVEDBY")).equalsIgnoreCase(""))
					hshRequestValues.put("strapproveflag","Y");//11
				else
					hshRequestValues.put("strapproveflag","N");//11
				
				hshRequestValues.put("SEC_SECURITYVALUE_OLD",Helper.correctNull(rs.getString("SEC_SECURITYVALUE_OLD"))); 
				hshRequestValues.put("SEC_SECURITYVALUE_NEW",Helper.correctNull(rs.getString("SEC_SECURITYVALUE_NEW"))); 
				hshRequestValues.put("SEC_VALUERNAME_OLD",Helper.correctNull(rs.getString("SEC_VALUERNAME_OLD"))); 
				hshRequestValues.put("SEC_VALUERNAME_NEW",Helper.correctNull(rs.getString("SEC_VALUERNAME_NEW"))); 
				hshRequestValues.put("SEC_VALUATIONDATE_OLD",Helper.correctNull(rs.getString("SEC_VALUATIONDATE_OLD"))); 
				hshRequestValues.put("SEC_VALUATIONDATE_NEW",Helper.correctNull(rs.getString("SEC_VALUATIONDATE_NEW"))); 
				hshRequestValues.put("SEC_COMMENTS",Helper.correctNull(rs.getString("SEC_COMMENTS"))); 
				hshRequestValues.put("SEC_AMTCHARGED_OLD",Helper.correctNull(rs.getString("SEC_AMTCHARGED_OLD"))); 
				hshRequestValues.put("SEC_AMTCHARGED_NEW",Helper.correctNull(rs.getString("SEC_AMTCHARGED_NEW"))); 
				hshRequestValues.put("SEC_FLAG",Helper.correctNull(rs.getString("SEC_FLAG"))); 
				hshRequestValues.put("cus_sec_type",Helper.correctNull(rs.getString("cus_sec_type"))); 
				
				hshRequestValues.put("SEC_VALUERCODE_OLD",Helper.correctNull(rs.getString("SEC_VALUERCODE_OLD"))); 
				hshRequestValues.put("SEC_VALUERCODE_NEW",Helper.correctNull(rs.getString("SEC_VALUERCODE_NEW"))); 
				
				hshRequestValues.put("SEC_VALUERVALUE_OLD",Helper.correctNull(rs.getString("SEC_VALUERVALUE_OLD"))); 
				hshRequestValues.put("SEC_VALUERCODE_NEW",Helper.correctNull(rs.getString("SEC_VALUERCODE_NEW"))); 
				
				hshRequestValues.put("SEC_SALEVALUE_OLD",Helper.correctNull(rs.getString("SEC_SALEVALUE_OLD"))); 
				hshRequestValues.put("SEC_SALEVALUE_NEW",Helper.correctNull(rs.getString("SEC_SALEVALUE_NEW"))); 

				if(rs1 !=null)
					rs1.close();
				rs1 = DBUtils.executeLAPSQuery("selectusername^"+correctNull(rs.getString("SEC_APPROVEDBY")));
				if(rs1.next())
				{
					hshRequestValues.put("strReceived",correctNull(rs1.getString("name")));//4
				}
			}
			
						
			
    	}
    	catch(Exception e)
    	{
			throw new EJBException("Error in getSecurityApproval "+e.toString());
		}
    	finally
    	{
    		try
    		{
    			if(rs!=null)
    				rs.close();
    		}
    		catch(Exception ef)
    		{
    			throw new EJBException("Error in getSecurityApproval "+ef.getMessage());
    			
    		}     		
    	}
    	return hshRequestValues;
    }
    
    
    public HashMap getSecurityOwnerChange(HashMap hshRequestValues)
    {
    	java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
    	
    	ResultSet rs=null,rs1=null;
    	String strQuery="",strUserID="", strSecID=null,strAction="";
    	strSecID = Helper.correctNull((String)hshRequestValues.get("txt_secid"));
    	if(strSecID.equalsIgnoreCase(""))
    		strSecID = Helper.correctNull((String)hshRequestValues.get("hidSecurityId"));
    	strUserID = Helper.correctNull((String)hshRequestValues.get("strUserId"));
    	strAction = Helper.correctNull((String)hshRequestValues.get("hidAction"));
    	boolean bflag=true;
    	try
    	{
	    	strQuery=SQLParser.getSqlQuery("sel_securitysearch_temp^"+strSecID);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{  	
				hshRequestValues.put("strsecid",correctNull(rs.getString("cus_sec_id")));//0
				hshRequestValues.put("strsecdesc",Helper.CLOBToString(rs.getClob("cus_sec_security_description")));//1
				hshRequestValues.put("strsecvalue",jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("cus_sec_netsecurity")))));//2
				if(rs1 !=null)
					rs1.close();
				rs1 = DBUtils.executeLAPSQuery("selstaticdata_securitytype_sel^"+correctNull(rs.getString("cus_sec_type")));
				if(rs1.next())
				{
					hshRequestValues.put("strsecname",correctNull(rs1.getString("sec_name")));//3
				}
				if(rs1 !=null)
					rs1.close();
				rs1 = DBUtils.executeLAPSQuery("selstaticdata_securitytype_sel^"+correctNull(rs.getString("cus_sec_classification")));
				if(rs1.next())
				{
					hshRequestValues.put("strsectype",correctNull(rs1.getString("sec_name")));//4
				}
				
				hshRequestValues.put("strexappname",Helper.correctNull(rs.getString("exappname")));//5
				hshRequestValues.put("strexappid",Helper.correctNull(rs.getString("exapplapsid")));//6
				hshRequestValues.put("strexappcbsid",Helper.correctNull(rs.getString("exappcbsid")));//7
				hshRequestValues.put("strnewappname",Helper.correctNull(rs.getString("newappname")));//8
				hshRequestValues.put("strnewapplapsid",Helper.correctNull(rs.getString("newapplapsid")));//9
				hshRequestValues.put("strnewappcbsid",Helper.correctNull(rs.getString("newappcbsid")));//9
				hshRequestValues.put("strseccreatedby",Helper.correctNull(rs.getString("sec_createdby")));//9
				hshRequestValues.put("strsecapprovedby",Helper.correctNull(rs.getString("sec_approvedby")));//9
				
				if((Helper.correctNull(rs.getString("sec_createdby")).equalsIgnoreCase(strUserID)))
				{
					hshRequestValues.put("strapproveflag","N");//11
					hshRequestValues.put("strchangeflag","Y");//10
				}
				else if(!Helper.correctNull(rs.getString("sec_approvedby")).equalsIgnoreCase(""))
				{
					hshRequestValues.put("strapproveflag","Y");//11
					hshRequestValues.put("strchangeflag","N");//10
				}
				if(!Helper.correctNull(rs.getString("sec_approvedby")).equalsIgnoreCase(""))
				{
					hshRequestValues.put("strchangeflag","N");//10
				}
				bflag=false;
				
				if(rs1 !=null)
					rs1.close();
				rs1 = DBUtils.executeLAPSQuery("selectusername^"+correctNull(rs.getString("sec_approvedby")));
				if(rs1.next())
				{
					hshRequestValues.put("strReceived",correctNull(rs1.getString("name")));//4
				}
			}
			
			if(bflag)
			{
				strQuery=SQLParser.getSqlQuery("sel_securitysearch^"+strSecID);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{  	
					hshRequestValues.put("strsecid",correctNull(rs.getString("cus_sec_id")));//0
					hshRequestValues.put("strsecdesc",Helper.CLOBToString(rs.getClob("cus_sec_security_description")));//1
					hshRequestValues.put("strsecvalue",jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("cus_sec_netsecurity")))));//2
					if(rs1 !=null)
						rs1.close();
					rs1 = DBUtils.executeLAPSQuery("selstaticdata_securitytype_sel^"+correctNull(rs.getString("cus_sec_type")));
					if(rs1.next())
					{
						hshRequestValues.put("strsecname",correctNull(rs1.getString("sec_name")));//3
					}
					if(rs1 !=null)
						rs1.close();
					rs1 = DBUtils.executeLAPSQuery("selstaticdata_securitytype_sel^"+correctNull(rs.getString("cus_sec_classification")));
					if(rs1.next())
					{
						hshRequestValues.put("strsectype",correctNull(rs1.getString("sec_name")));//4
					}
					
					hshRequestValues.put("strexappname",Helper.correctNull(rs.getString("perapp_fname")));//5
					hshRequestValues.put("strexappid",Helper.correctNull(rs.getString("perapp_oldid")));//6
					hshRequestValues.put("strexappcbsid",Helper.correctNull(rs.getString("perapp_cbsid")));//7
					hshRequestValues.put("strchangeflag","N");//10
					hshRequestValues.put("strapproveflag","N");//11
					
				}
			}
			
			
    	}
    	catch(Exception e)
    	{
			throw new EJBException("Error in getPropertyDetData "+e.toString());
		}
    	finally
    	{
    		try
    		{
    			if(rs!=null)
    				rs.close();
    		}
    		catch(Exception ef)
    		{
    			throw new EJBException("Error in getPropertyDetData "+ef.getMessage());
    			
    		}     		
    	}
    	return hshRequestValues;
    }
    public HashMap getData(HashMap hshRequestValues) 
	{
		HashMap hshRecord = new HashMap();
		ResultSet rs=null;
		ArrayList vecCodes= new ArrayList();
		ArrayList vecValues = new ArrayList();
		String strSecurityClassification="";
		String strQuery="";

		try
		{
			strSecurityClassification=Helper.correctNull((String)hshRequestValues.get("param"));
			strQuery=SQLParser.getSqlQuery("sel_securityvaluationreport^"+strSecurityClassification);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				vecCodes.add(Helper.correctNull(rs.getString("sec_id")));
				vecValues.add(Helper.correctNull(rs.getString("sec_name")));
			}
			hshRecord.put("vecCodes",vecCodes);
			hshRecord.put("vecValues",vecValues);
		
		}
		catch(Exception ce)
		{
		
			throw new EJBException("Error in getdata "+ce.toString());
		}
		
		return hshRecord;
	}
    
    public HashMap getSecModifiedHisData(HashMap hshRequestValues) 
	{
		HashMap hshRecord = new HashMap();
		ResultSet rs=null;
		ArrayList arrRows= new ArrayList();
		ArrayList arrValues = new ArrayList();
		String strSecId="";
		String strQuery="";

		try
		{
			strSecId=Helper.correctNull((String)hshRequestValues.get("SecId"));
			strQuery=SQLParser.getSqlQuery("select_sec_Modified^"+strSecId);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrValues = new ArrayList();
				arrValues.add(Helper.correctNull(rs.getString(1)));
				arrValues.add(Helper.correctNull(rs.getString(2)));
				arrValues.add(Helper.correctNull(rs.getString(3)));
				arrValues.add(Helper.correctNull(rs.getString(4)));
				arrValues.add(Helper.correctNull(rs.getString(5)));
				arrRows.add(arrValues);
			}
			
			hshRecord.put("arrRows",arrRows);
			hshRecord.put("strSecId",strSecId);
		}
		catch(Exception ce)
		{
		
			throw new EJBException("Error in getdata "+ce.toString());
		}
		
		return hshRecord;
	}
    
    public HashMap getSecAttachedData(HashMap hshRequestValues) 
	{
		HashMap hshRecord = new HashMap();
		ResultSet rs=null;
		ArrayList arrRows= new ArrayList();
		ArrayList arrValues = new ArrayList();
		String strSecId="";
		String strQuery="";

		try
		{
			strSecId=Helper.correctNull((String)hshRequestValues.get("SecId"));
			strQuery=SQLParser.getSqlQuery("select_sec_attached^"+strSecId+"^"+strSecId);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrValues = new ArrayList();
				arrValues.add(Helper.correctNull(rs.getString(1)));
				arrValues.add(Helper.correctNull(rs.getString(2)));
				arrValues.add(Helper.correctNull(rs.getString(3)));
				arrValues.add(Helper.correctNull(rs.getString(4)));
				arrValues.add(Helper.correctNull(rs.getString(5)));
				arrValues.add(Helper.correctNull(rs.getString(6)));
				arrValues.add(Helper.correctNull(rs.getString(7)));
				arrValues.add(Helper.correctNull(rs.getString(8)));
				arrValues.add(Helper.correctNull(rs.getString(9)));
				arrValues.add(Helper.correctNull(rs.getString(10)));
				arrValues.add(Helper.correctNull(rs.getString(11)));
				arrRows.add(arrValues);
			}
			
			hshRecord.put("arrRows",arrRows);
			hshRecord.put("strSecId",strSecId);
		}
		catch(Exception ce)
		{
		
			throw new EJBException("Error in getdata "+ce.toString());
		}
		
		return hshRecord;
	}
    public HashMap getMDTDattachedSec(HashMap hshValues)
    {
    	ResultSet rs=null,rs1=null;
    	String strQuery="";
    	String appno = Helper.correctNull((String)hshValues.get("hidAppNo"));
    	String strapp_secid= Helper.correctNull((String)hshValues.get("app_secid"));
    	HashMap hshrecord=new HashMap();
    	try
    	{
    		strQuery=SQLParser.getSqlQuery("sel_appssecDetails^"+appno+"^"+strapp_secid);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshrecord.put("ownername", Helper.correctNull(rs.getString("ownername")));
				hshrecord.put("SEC_NAME", Helper.correctNull(rs.getString("SEC_NAME")));
				hshrecord.put("APP_SEC_SECURITYVALUE", Helper.correctNull(rs.getString("APP_SEC_SECURITYVALUE")));
			}
			if(rs!=null)
				rs.close();
			strQuery=SQLParser.getSqlQuery("sel_sec_MDTDcomments^"+appno+"^"+strapp_secid);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshrecord.put("MDTD_APPNO", Helper.correctNull(rs.getString("MDTD_APPNO")));
				hshrecord.put("MDTD_SECID", Helper.correctNull(rs.getString("MDTD_SECID")));
				hshrecord.put("MDTD_COMMENTS",correctNull(Helper.CLOBToString((rs.getClob("MDTD_COMMENTS")))));
			}
			//for proposed assets check 
			if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("sel_editApply_valuation^"+ appno);
    		rs = DBUtils.executeQuery(strQuery);
			while(rs.next()) 
			{
				if(Helper.correctNull((String)rs.getString("EDIT_APPLY_FLAG")).equalsIgnoreCase("N")){
					hshrecord.put("valuationFlag","N");
				}
			}
    			
			if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("sel_editApply_house^"+ appno);
    		rs = DBUtils.executeQuery(strQuery);
			while(rs.next()) 
			{
				if(Helper.correctNull((String)rs.getString("PHPA_EDIT_APPLYFLAG")).equalsIgnoreCase("N")){
					hshrecord.put("HouseEdit_Flag","N");
				}
			}
			
			if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("sel_editApply_vehicle^"+ appno);
    		rs = DBUtils.executeQuery(strQuery);
			while(rs.next()) 
			{
				if(Helper.correctNull((String)rs.getString("AUTO_EDIT_APPLYFLAG")).equalsIgnoreCase("N")){
					hshrecord.put("VehicleEdit_Flag","N");
				}
			}
    		
    		hshrecord.put("appno",appno);
    		hshrecord.put("app_secid",strapp_secid);
    	}
    	catch(Exception e)
    	{
			throw new EJBException("Error in getMDTDattachedSec "+e.toString());
		}
    	finally
    	{
    		try
    		{
    			if(rs!=null)
    				rs.close();
    		}
    		catch(Exception ef)
    		{
    			throw new EJBException("Error in getMDTDattachedSec "+ef.getMessage());
    			
    		}     		
    	}
    	return hshrecord;
    }
    public void updateMDTDAttachedsec(HashMap hshValues)
    {
    	HashMap hshQueryValues= new HashMap();
    	HashMap hshQuery= new HashMap();
    	ArrayList arrValues=new ArrayList();
    	ResultSet rs=null;
    	String strQuery="", strAlreadyCharged="";
    	String hidAction=Helper.correctNull((String)hshValues.get("hidAction"));
    	String hidAppNo=Helper.correctNull((String)hshValues.get("appno"));
    	String hidsecid=Helper.correctNull((String)hshValues.get("app_secid"));
    	String hidcomments=Helper.correctNull((String)hshValues.get("txtarea_comments"));
    	try
    	{
    		if(hidAction.equals("insert"))
    		{
    			hshQuery = new HashMap();					
				arrValues.add(hidAppNo);
				arrValues.add(hidsecid);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","del_sec_MDTDcomments");
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
    			
				hshQuery = new HashMap();		
				arrValues=new ArrayList();
				arrValues.add(hidAppNo);
				arrValues.add(hidsecid);
				arrValues.add(hidcomments);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","ins_sec_MDTDcomments");
				hshQueryValues.put("2",hshQuery);
				hshQueryValues.put("size","2");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
    		}
    		if(hidAction.equals("delete"))
    		{
    			hshQuery = new HashMap();					
				hshQuery.put("strQueryId","del_sec_MDTDcomments");
				arrValues.add(hidAppNo);
				arrValues.add(hidsecid);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
    		}
    	}
    	catch(Exception e)
		{
			throw new EJBException("Error in updateMDTDAttachedsec "+e.toString());
		}
    }
    public void DetachSecurities(HashMap hshValues)
    {
    	HashMap hshQueryValues= new HashMap();
    	HashMap hshQuery= new HashMap();
    	ArrayList arrValues=new ArrayList();
    	String strAppno=Helper.correctNull((String)hshValues.get("appno"));
    	ResultSet rs=null;
    	try
    	{
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			arrValues.add(strAppno);
			arrValues.add(strAppno);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","del_releasedsec");
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");
			
			int intsize=1;
			rs=DBUtils.executeLAPSQuery("sel_unknownsec^"+strAppno);
			while(rs.next())
			{
				if(!Helper.correctNull(rs.getString("app_sec_customerid")).equalsIgnoreCase(Helper.correctNull((String)hshValues.get("hidapplicantid"))))
				{
					intsize++;
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					arrValues.add("P");
					arrValues.add(Helper.correctNull(rs.getString("app_sec_secid")));
					arrValues.add(strAppno);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","delsecuritydetails_fac");
					hshQueryValues.put(String.valueOf(intsize),hshQuery);
					hshQueryValues.put("size",String.valueOf(intsize));
				}
			}
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
    		
    	}
    	catch(Exception e)
		{
			throw new EJBException("Error in DetachSecurities "+e.toString());
		}
    }
    
    
    public void updateLiveStock(HashMap hshValues)
    {
    	HashMap hshQueryValues= new HashMap();
    	HashMap hshQuery= new HashMap();
    	ArrayList arrValues=new ArrayList();
    	String strQuery="",str_totval="";
    	ResultSet rs=null;
    	String hidAction=Helper.correctNull((String)hshValues.get("hidAction"));
    	String hidSecId=Helper.correctNull((String)hshValues.get("hidSecurityId"));
    	String strModifiedField[]=null;
		String strModifiedValue[]=null;
    	//String hidsecid=Helper.correctNull((String)hshValues.get("app_secid"));
    	
	    try
	    {
	    	
	    	str_totval=Helper.correctNull((String)hshValues.get("old_txt_totnumber"));
	    	String strSal = Helper.correctNull((String) hshValues.get("sel_applt_title"));
			if(strSal.equalsIgnoreCase(""))
				strSal = Helper.correctNull((String) hshValues.get("hidsalutation"));
			if(!str_totval.equals(correctNull((String)hshValues.get("txt_totnumber"))))
			{
				hshQuery = new HashMap();					
				arrValues.add(hidSecId);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","del_livestock_det");
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
    		if(hidAction.equals("insert"))
    		{
    			hshQuery = new HashMap();
    			arrValues=new ArrayList();
    			boolean secHisflag = false;
				strQuery = SQLParser.getSqlQuery("sel_sec_livestock^"+hidSecId);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					secHisflag=true;
				}
    			hshQuery = new HashMap();					
				arrValues.add(hidSecId);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","del_sec_livestock");
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
    			
				hshQuery = new HashMap();		
				arrValues=new ArrayList();
				arrValues.add(hidSecId);
				arrValues.add(correctNull((String)hshValues.get("txt_totnumber")));
				arrValues.add(strSal);
				arrValues.add(correctNull((String)hshValues.get("txt_applName")));
				arrValues.add(correctNull((String)hshValues.get("txt_applsurveyno")));
				arrValues.add(correctNull((String)hshValues.get("txt_applAddress1")));
				arrValues.add(correctNull((String)hshValues.get("txt_applAddress2")));
				arrValues.add(correctNull((String)hshValues.get("hidcity")));
				arrValues.add(correctNull((String)hshValues.get("hidstate")));
				arrValues.add(correctNull((String)hshValues.get("hid_dist")));
				arrValues.add(correctNull((String)hshValues.get("txt_applpincode")));
				arrValues.add(correctNull((String)hshValues.get("hid_applcountry")));
				arrValues.add(correctNull((String)hshValues.get("txt_cbscustid")));
				
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","ins_sec_livestock");
				hshQueryValues.put("2",hshQuery);
				hshQueryValues.put("size","2");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				if(secHisflag==true)
				{
				hshQueryValues=new HashMap();
				int arrquerySize=1;
				String tempOldvalue="",tempNewvalue="",tempField="";
				if(!Helper.correctNull((String)hshValues.get("hidmodifiedField")).equals(""))
					strModifiedField = Helper.correctNull((String)hshValues.get("hidmodifiedField")).split("@") ;
				if(!Helper.correctNull((String)hshValues.get("hidmodifiedvalue")).equals(""))	
					strModifiedValue = Helper.correctNull((String)hshValues.get("hidmodifiedvalue")).split("@");
				if(strModifiedField!=null && strModifiedField.length>0)
				{
					for (int  k = 0; k < strModifiedField.length; k++) 
					{
						tempOldvalue= Helper.correctNull((String)hshValues.get(strModifiedValue[k]));
						tempNewvalue= Helper.correctNull((String)hshValues.get((strModifiedValue[k]).substring(4)));
						tempField= strModifiedField[k];
	
						arrValues=new ArrayList();
						hshQuery = new HashMap();
						arrValues.add(tempField);
						arrValues.add(tempOldvalue);
						arrValues.add(tempNewvalue);
						arrValues.add(Helper.correctNull((String)hshValues.get("strUserId")));
						arrValues.add(hidSecId);
						hshQuery.put("arrValues", arrValues);
						hshQuery.put("strQueryId", "ins_sec_modified");
						hshQueryValues.put(Integer.toString(arrquerySize),hshQuery);
						hshQueryValues.put("size",Integer.toString(arrquerySize));
						arrquerySize++;
					}
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}}
				
    		}
    		if(hidAction.equals("delete"))
    		{
    			arrValues=new ArrayList();
    			hshQuery = new HashMap();					
				hshQuery.put("strQueryId","del_sec_livestock");
				arrValues.add(hidSecId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
			//	EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				arrValues=new ArrayList();
				hshQuery = new HashMap();					
				arrValues.add(hidSecId);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","del_livestock_det");
				hshQueryValues.put("2",hshQuery);
				hshQueryValues.put("size","2");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
    		}
	    
	    }
		catch(Exception e)
		{
			throw new EJBException("Error in updateLiveStock "+e.toString());
		}
    }
    
    public HashMap getLiveStock(HashMap hshValues)
    {
    	ResultSet rs=null,rs1=null,rs2=null;
    	String strQuery="";
    	HashMap hshResult = new HashMap();
    	try
    	{
    		String StrLAPSId = correctNull((String) hshValues.get("hidDemoId"));
			strQuery = SQLParser.getSqlQuery("sel_lapsidfromlapsid^" + StrLAPSId);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()) 
			{
				hshResult.put("perapp_fname", Helper.correctNull((String)rs.getString("perapp_fname")));
				hshResult.put("perapp_cbsid", Helper.correctNull((String)rs.getString("perapp_cbsid")));
				hshResult.put("perapp_oldid", Helper.correctNull((String)rs.getString("perapp_oldid")));
			}
			
			
			if(rs1!=null)
				rs1.close();
			
			String hidSecId=Helper.correctNull((String)hshValues.get("hidSecurityId"));		
			strQuery = SQLParser.getSqlQuery("sel_sec_livestock^" + hidSecId);
			rs1 = DBUtils.executeQuery(strQuery);
			if(rs1.next()) 
			{
				hshResult.put("SEC_SECURITYID", Helper.correctNull((String)rs1.getString("SEC_SECURITYID")));
				hshResult.put("SEC_TOTNUMBER", Helper.correctNull((String)rs1.getString("SEC_TOTNUMBER")));
				hshResult.put("SEC_APP_TITLE", Helper.correctNull((String)rs1.getString("SEC_APP_TITLE")));
				hshResult.put("SEC_APP_NAME", Helper.correctNull((String)rs1.getString("SEC_APP_NAME")));
				hshResult.put("SEC_APP_SURVEYNO", Helper.correctNull((String)rs1.getString("SEC_APP_SURVEYNO")));
				hshResult.put("SEC_APP_ADDR1", Helper.correctNull((String)rs1.getString("SEC_APP_ADDR1")));
				hshResult.put("SEC_APP_ADDR2", Helper.correctNull((String)rs1.getString("SEC_APP_ADDR2")));
				
				hshResult.put("SEC_APP_PINCODE", Helper.correctNull((String)rs1.getString("SEC_APP_PINCODE")));
				hshResult.put("SEC_APP_COUNTRY", Helper.correctNull((String)rs1.getString("SEC_APP_COUNTRY")));			
				if(rs2 !=null)
				{
					rs2.close();
				}
				rs2=DBUtils.executeLAPSQuery("sel_citynamebycode^"+ correctNull(rs1.getString("SEC_APP_CITYCODE")));	
				if (rs2.next()) 
				{
					hshResult.put("SEC_APP_CITYNAME",correctNull(rs2.getString("city_name")));
					hshResult.put("SEC_APP_CITYCODE",correctNull(rs1.getString("SEC_APP_CITYCODE")));
				}
			//	hshResult.put("SEC_APP_STATECODE", Helper.correctNull((String)rs1.getString("SEC_APP_STATECODE")));
				if(rs2 !=null)
				{
					rs2.close();
				}
				rs2=DBUtils.executeLAPSQuery("sel_statenamebycode^"+ correctNull(rs1.getString("SEC_APP_STATECODE")));	
				if (rs2.next()) 
				{
					hshResult.put("SEC_APP_STATENAME",correctNull(rs2.getString("state_name")));
					hshResult.put("SEC_APP_STATECODE",correctNull(rs1.getString("SEC_APP_STATECODE")));
				}
				
			//	hshResult.put("SEC_APP_DISTRICTCODE", Helper.correctNull((String)rs1.getString("SEC_APP_DISTRICTCODE")));
				if(rs2 !=null)
				{
					rs2.close();
				}
				rs2=DBUtils.executeLAPSQuery("sel_distnamebycode^"+ correctNull(rs1.getString("SEC_APP_DISTRICTCODE")));	
				if (rs2.next()) 
				{
					hshResult.put("SEC_APP_DISTRICTNAME",correctNull(rs2.getString("district_desc")));
					hshResult.put("SEC_APP_DISTRICTCODE",correctNull(rs1.getString("SEC_APP_DISTRICTCODE")));

				}
				
				
				if(rs!=null)
				{
					rs.close();
				}
				rs=DBUtils.executeLAPSQuery("sel_countrynamebycode^"+correctNull(rs1.getString("SEC_APP_COUNTRY")));	
				if(rs.next())
				{
					hshResult.put("SEC_APP_COUNTRY",correctNull(rs.getString("con_country")));
					hshResult.put("SEC_APP_COUNTRYCODE",correctNull(rs1.getString("SEC_APP_COUNTRY")));	
				}
				hshResult.put("SEC_APP_CBSID", Helper.correctNull((String)rs1.getString("SEC_APP_CBSID")));	
			}
			if(rs!=null)
				rs.close();
			
			strQuery = SQLParser.getSqlQuery("sel_livestock_count^" + hidSecId);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()) 
			{
				hshResult.put("auto_count", Helper.correctNull((String)rs.getString("auto_count")));
			}
			hshResult.put("hid_VerificationFlag", Helper.correctNull((String) hshValues.get("hid_VerificationFlag")));
			hshResult.put("SEC_SECURITYID", Helper.correctNull((String)hshValues.get("hidSecurityId")));
    	}
    	catch(Exception e)
    	{
			throw new EJBException("Error in getLiveStock "+e.toString());
		}
    	finally
    	{
    		try
    		{
    			if(rs!=null)
    				rs.close();
    			if(rs1!=null)
    				rs1.close();
    		}
    		catch(Exception ef)
    		{
    			throw new EJBException("Error in getLiveStock "+ef.getMessage());
    			
    		}     		
    	}
    	return hshResult;
    }
    
    public void updateLiveStock_det(HashMap hshValues)
    {
    	HashMap hshQueryValues= new HashMap();
    	HashMap hshQuery= new HashMap();
    	ArrayList arrValues=new ArrayList();
    	String strQuery="";
    	String hidAction=Helper.correctNull((String)hshValues.get("hidAction"));
    	String hidSecId=Helper.correctNull((String)hshValues.get("hidSecurityId"));
    	ResultSet rs=null;
    	
    	
    	int size=0;
    	try
		{
    	int count=0;
			if(hidAction.equalsIgnoreCase("insert"))
			{
				size++;
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(hidSecId);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","del_livestock_det");
				hshQueryValues.put(String.valueOf(size), hshQuery);
				hshQueryValues.put("size",String.valueOf(size));
				
				
				if(hshValues.get("txt_sec_age") instanceof String[])
				{
					String[] sec_age=((String[])hshValues.get("txt_sec_age"));
					String[] sec_breed=((String[])hshValues.get("txt_sec_breed"));
					String[] sec_identmark=((String[])hshValues.get("txt_sec_identmark"));
					for(int i=0;i<sec_age.length;i++)
					{
					if(!sec_age[i].equalsIgnoreCase(""))
					{
						size++;
						count++;
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "ins_livestock_det");
						arrValues.add(hidSecId);
						arrValues.add(String.valueOf(size));
						arrValues.add(sec_age[i]);
						arrValues.add(sec_breed[i]);
						arrValues.add(sec_identmark[i]);
						
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(String.valueOf(size), hshQuery);
						hshQueryValues.put("size",String.valueOf(size));
					}
						
					}
				}
				else
				{
					if(!correctNull((String)hshValues.get("txt_sec_age")).equalsIgnoreCase(""))
					{
						count++;
						size++;
						arrValues = new ArrayList();
						arrValues.add(hidSecId);
						arrValues.add("1");
						arrValues.add(correctNull((String)hshValues.get("txt_sec_age")));
						arrValues.add(correctNull((String)hshValues.get("txt_sec_breed")));
						arrValues.add(correctNull((String)hshValues.get("txt_sec_identmark")));
						hshQuery.put("arrValues",arrValues);
						hshQuery.put("strQueryId","ins_livestock_det");
						hshQueryValues.put(String.valueOf(size),hshQuery);
						hshQueryValues.put("size",String.valueOf(size));
					}
				}
				
				if(size>0)
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
				
				if(rs!=null)
		    		rs.close();
				
				strQuery = SQLParser.getSqlQuery("sel_sec_livestock^"+hidSecId);
	    		rs = DBUtils.executeQuery(strQuery);
	    		int intMembers=0;
				if(rs.next())
				{
					intMembers = Integer.parseInt(Helper.correctInt((String)rs.getString("SEC_TOTNUMBER")));
				}
				
				if(count==intMembers)
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId","upd_securities");
					arrValues.add("Y");
					arrValues.add(hidSecId);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size","1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					if(rs!=null)
			    		rs.close();
					strQuery = SQLParser.getSqlQuery("sel_secMailbox_check^"+hidSecId);
		    		rs = DBUtils.executeQuery(strQuery);
		    		if(rs.next())	
		    		{
		    			String mailboxflag=Helper.correctNull((String)rs.getString("SEC_FLAG"));
						if(mailboxflag.equals("NCN"))
							mailboxflag="N";
						else
							mailboxflag="V";
		    			hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQueryValues.put("size","1");
						hshQuery.put("strQueryId","upd_secMailbox_flag");
						arrValues.add(mailboxflag);
						arrValues.add(hidSecId);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);
						
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQueryValues.put("size","2");
						hshQuery.put("strQueryId","upd_cussecurities_changeflag");
						arrValues.add("V");
						arrValues.add(hidSecId);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("2",hshQuery);
						
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		    		}
	    		}
			}
			if(hidAction.equals("delete"))
    		{
				arrValues = new ArrayList();
    			hshQuery = new HashMap();					
				hshQuery.put("strQueryId","del_livestock_det");
				arrValues.add(hidSecId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","upd_securities");
				arrValues.add("N");
				arrValues.add(hidSecId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2", hshQuery);
				hshQueryValues.put("size","2");
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
    		}
	    
	    }
		catch(Exception e)
		{
			throw new EJBException("Error in updateLiveStock "+e.toString());
		}
    }
    
    
    
    public HashMap getLiveStockDet(HashMap hshValues)
    {
    	ResultSet rs=null,rs1=null;
    	String strQuery="";
    	HashMap hshResult = new HashMap();
    	ArrayList arrValues=new ArrayList();
    	ArrayList arrRows=new ArrayList();
    	int intMembers=0;
		int intAvailable=0;

    	try
    	{
    		
    		String StrDemoID = correctNull((String) hshValues.get("hidDemoId"));
    		String hidSecId=Helper.correctNull((String)hshValues.get("hidSecurityId"));		
    		
    		if(rs!=null)
				rs.close();
			rs=DBUtils.executeLAPSQuery("sel_sec_livestock^"+hidSecId);
    		if(rs.next())
    		{
    			hshResult.put("strLiveStrockFlag","Y");
    		}
    		
    		strQuery = SQLParser.getSqlQuery("sel_sec_livestock^"+hidSecId);
    		rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				intMembers = Integer.parseInt(Helper.correctInt((String)rs.getString("SEC_TOTNUMBER")));
			}

			if(rs!=null)
				rs.close();
			
			strQuery = SQLParser.getSqlQuery("sel_lapsidfromlapsid^" + StrDemoID);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()) 
			{
				hshResult.put("perapp_fname", Helper.correctNull((String)rs.getString("perapp_fname")));
				hshResult.put("perapp_cbsid", Helper.correctNull((String)rs.getString("perapp_cbsid")));
				hshResult.put("perapp_oldid", Helper.correctNull((String)rs.getString("perapp_oldid")));
			}
			if(rs1!=null)
				rs1.close();
			
			
			strQuery = SQLParser.getSqlQuery("sel_livestock_det^" + hidSecId);
			rs1 = DBUtils.executeQuery(strQuery);
			while(rs1.next()) 
			{
			
				arrValues = new ArrayList();
				arrValues.add(Helper.correctNull(rs1.getString(1)));
				arrValues.add(Helper.correctNull(rs1.getString(2)));
				arrValues.add(Helper.correctNull(rs1.getString(3)));
				arrRows.add(arrValues);
			}	
				
				intAvailable = arrRows.size();
				for(int i = 0;i<(intMembers - intAvailable);i++)
				{
					arrValues = new ArrayList();
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrRows.add(arrValues);
				}
			hshResult.put("arrRows",arrRows);
			hshResult.put("hid_VerificationFlag", Helper.correctNull((String)hshValues.get("hid_VerificationFlag")));
			hshResult.put("SEC_SECURITYID", Helper.correctNull((String)hshValues.get("hidSecurityId")));
    	}
    	catch(Exception e)
    	{
			throw new EJBException("Error in getLiveStockDet "+e.toString());
		}
    	finally
    	{
    		try
    		{
    			if(rs!=null)
    				rs.close();
    		}
    		catch(Exception ef)
    		{
    			throw new EJBException("Error in getLiveStockDet "+ef.getMessage());
    			
    		}     		
    	}
    	return hshResult;
    }
    
    public void updateSecurityStock(HashMap hshValues)
    {
    	HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues= new ArrayList();
		String strSecurityId="";
		String strAction =Helper.correctNull((String)hshValues.get("hidAction"));
		ResultSet rs=null;
    	String strQuery="";
    	String strModifiedField[]=null;
		String strModifiedValue[]=null;
		try
		{
			strSecurityId = Helper.correctNull((String) hshValues.get("hidSecurityId"));
			String strSal = Helper.correctNull((String) hshValues.get("sel_salutation"));
			if(strSal.equalsIgnoreCase(""))
				strSal = Helper.correctNull((String) hshValues.get("hidsalutation"));
			if(strAction.equalsIgnoreCase("insert"))
			{
				boolean secHisflag = false;
				strQuery = SQLParser.getSqlQuery("sel_security_Stock^"+strSecurityId);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					secHisflag=true;
				}
				hshQueryValues = new HashMap();
				hshQueryValues.put("size","1");
				hshQuery = new HashMap();		
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","del_security_Stock");
				arrValues.add(strSecurityId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","ins_security_Stock");
				arrValues.add(strSecurityId);
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_belongsto")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Surveyno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_address1")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_address2")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_city")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_state")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_district")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_country")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_pin")));
				arrValues.add(strSal);
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_cbscustid")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");

				
				
				if(secHisflag==true)
				{
				hshQueryValues=new HashMap();
				int arrquerySize=1;
				String tempOldvalue="",tempNewvalue="",tempField="";
				if(!Helper.correctNull((String)hshValues.get("hidmodifiedField")).equals(""))
					strModifiedField = Helper.correctNull((String)hshValues.get("hidmodifiedField")).split("@") ;
				if(!Helper.correctNull((String)hshValues.get("hidmodifiedvalue")).equals(""))	
					strModifiedValue = Helper.correctNull((String)hshValues.get("hidmodifiedvalue")).split("@");
				if(strModifiedField!=null && strModifiedField.length>0)
				{
					for (int  k = 0; k < strModifiedField.length; k++) 
					{
						tempOldvalue= Helper.correctNull((String)hshValues.get(strModifiedValue[k]));
						tempNewvalue= Helper.correctNull((String)hshValues.get((strModifiedValue[k]).substring(4)));
						tempField= strModifiedField[k];
	
						arrValues=new ArrayList();
						hshQuery = new HashMap();
						arrValues.add(tempField);
						arrValues.add(tempOldvalue);
						arrValues.add(tempNewvalue);
						arrValues.add(Helper.correctNull((String)hshValues.get("strUserId")));
						arrValues.add(strSecurityId);
						hshQuery.put("arrValues", arrValues);
						hshQuery.put("strQueryId", "ins_sec_modified");
						hshQueryValues.put(Integer.toString(arrquerySize),hshQuery);
						hshQueryValues.put("size",Integer.toString(arrquerySize));
						arrquerySize++;
					}
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
				}

				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","upd_securities");
				arrValues.add("Y");
				arrValues.add(strSecurityId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");

				
				if(rs!=null)
		    		rs.close();
				strQuery = SQLParser.getSqlQuery("sel_secMailbox_check^"+strSecurityId);
	    		rs = DBUtils.executeQuery(strQuery);
	    		if(rs.next())	
	    		{
	    			String mailboxflag=Helper.correctNull((String)rs.getString("SEC_FLAG"));
					if(mailboxflag.equals("NCN"))
						mailboxflag="N";
					else
						mailboxflag="V";
	    			hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","upd_secMailbox_flag");
					arrValues.add(mailboxflag);
					arrValues.add(strSecurityId);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","2");
					hshQuery.put("strQueryId","upd_cussecurities_changeflag");
					arrValues.add("V");
					arrValues.add(strSecurityId);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("2",hshQuery);
					
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
	    		}

				
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				arrValues=new ArrayList();
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_security_Stock");
				arrValues.add(strSecurityId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","upd_securities");
				arrValues.add("N");
				arrValues.add(strSecurityId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2", hshQuery);
				hshQueryValues.put("size","2");
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
		}
		catch (Exception e)
		{
			throw new EJBException("Error in updateSecurityStock :::  " + e.getMessage());
		}
	}
     
    public HashMap getSecurityStock(HashMap hshValues)
    {

    	HashMap hshResult=new HashMap();
		ResultSet rs=null,rs1=null;
		String strQuery =null;
		String strSecurityId=null;
		String strGradeId="",appno="";
		try
		{
			strSecurityId = correctNull((String) hshValues.get("hidSecurityId"));
			if(strSecurityId.equalsIgnoreCase(""))
			{
				strSecurityId=Helper.correctNull((String)hshValues.get("hidsecid"));
			}
			strQuery = SQLParser.getSqlQuery("sel_security_Stock^"+strSecurityId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{	
				hshResult.put("SEC_STOCK_NAME",Helper.correctNull(rs.getString("SEC_STOCK_NAME")));
				hshResult.put("SEC_STOCK_SURVEY",Helper.correctNull(rs.getString("SEC_STOCK_SURVEY")));
				hshResult.put("SEC_STOCK_ADDRESS1",Helper.correctNull(rs.getString("SEC_STOCK_ADDRESS1")));
				hshResult.put("SEC_STOCK_ADDRESS2",Helper.correctNull(rs.getString("SEC_STOCK_ADDRESS2")));
				hshResult.put("SEC_STOCK_CITY",Helper.correctNull(rs.getString("SEC_STOCK_CITY")));
				hshResult.put("SEC_STOCK_STATE",Helper.correctNull(rs.getString("SEC_STOCK_STATE")));
				hshResult.put("SEC_STOCK_DIST",Helper.correctNull(rs.getString("SEC_STOCK_DIST")));
				hshResult.put("SEC_STOCK_COUNTRY",Helper.correctNull(rs.getString("SEC_STOCK_COUNTRY")));
				hshResult.put("SEC_STOCK_ZIP",Helper.correctNull(rs.getString("SEC_STOCK_ZIP")));
				hshResult.put("SEC_STOCK_SAL",Helper.correctNull(rs.getString("SEC_STOCK_SAL")));

				
				if(!Helper.correctNull(rs.getString("SEC_STOCK_CITY")).equalsIgnoreCase(""))
				{
					rs1=DBUtils.executeLAPSQuery("sel_citynamebycode^"+Helper.correctNull(rs.getString("SEC_STOCK_CITY")));
					if(rs1.next())
						hshResult.put("SEC_STOCK_CITYNAME",Helper.correctNull(rs1.getString("city_name")));
					
					if(rs1!=null)
						rs1.close();
				}
				if(!Helper.correctNull(rs.getString("SEC_STOCK_STATE")).equalsIgnoreCase(""))
				{
					rs1=DBUtils.executeLAPSQuery("sel_statenamebycode^"+Helper.correctNull(rs.getString("SEC_STOCK_STATE")));
					if(rs1.next())
						hshResult.put("SEC_STOCK_STATENAME",Helper.correctNull(rs1.getString("state_name")));
					
					if(rs1!=null)
						rs1.close();
				}
				
				
				if(!Helper.correctNull(rs.getString("SEC_STOCK_COUNTRY")).equalsIgnoreCase(""))
				{
					rs1=DBUtils.executeLAPSQuery("sel_countrynamebycode^"+Helper.correctNull(rs.getString("SEC_STOCK_COUNTRY")));
					if(rs1.next())
						hshResult.put("SEC_STOCK_COUNTRYNAME",Helper.correctNull(rs1.getString("con_country")));
					
					if(rs1!=null)
						rs1.close();
				}
				
				if(!Helper.correctNull(rs.getString("SEC_STOCK_DIST")).equalsIgnoreCase(""))
				{
					rs1=DBUtils.executeLAPSQuery("sel_distnamebycode^"+Helper.correctNull(rs.getString("SEC_STOCK_DIST")));
					if(rs1.next())
						hshResult.put("SEC_STOCK_DISTNAME",Helper.correctNull(rs1.getString("district_desc")));
					
					if(rs1!=null)
						rs1.close();
				}
				hshResult.put("sec_cbsid",Helper.correctNull(rs.getString("sec_cbsid")));
				
				
			}
			
			// To get the Customer Name
			String StrLAPSId = correctNull((String) hshValues.get("hidDemoId"));
			strQuery = SQLParser.getSqlQuery("sel_lapsidfromlapsid^" + StrLAPSId);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()) 
			{
				hshResult.put("perapp_fname", Helper.correctNull((String)rs.getString("perapp_fname")));
				hshResult.put("perapp_cbsid", Helper.correctNull((String)rs.getString("perapp_cbsid")));
				hshResult.put("perapp_oldid", Helper.correctNull((String)rs.getString("perapp_oldid")));
			}
			
			hshResult.put("strSecID", strSecurityId);
			hshResult.put("hid_VerificationFlag", Helper.correctNull((String)hshValues.get("hid_VerificationFlag")));
		}
		catch (Exception e)
		{
			log.error("Exception in getSecurityStock ::: "+ e.getMessage());
		} 
		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				log.error("Exception in getSecurityStock ::: "+ cf.getMessage());
			}
		}
		return hshResult;
    }
    public HashMap updateSecurityCrop(HashMap hshValues)
    {
    	HashMap hshQueryValues=new HashMap();
    	HashMap hshQuery=new HashMap();
    	ArrayList arrValues=new ArrayList();
    	String strAction ="";
		String strSecurityId ="";
		String strQuery="";
		ResultSet rs=null;
		String strModifiedField[]=null;
		String strModifiedValue[]=null;
		
		try
		{
		strAction=Helper.correctNull((String)hshValues.get("hidAction"));
    	strSecurityId=Helper.correctNull((String)hshValues.get("hidSecurityId"));
    	String strSal = Helper.correctNull((String) hshValues.get("sel_salutation"));
		if(strSal.equalsIgnoreCase(""))
			strSal = Helper.correctNull((String) hshValues.get("hidsalutation"));
		
			if(strAction.equalsIgnoreCase("insert"))
			{
				boolean secHisflag = false;
				strQuery = SQLParser.getSqlQuery("sel_security_crop^"+strSecurityId);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					secHisflag=true;
				}
				
				hshQueryValues = new HashMap();
				hshQueryValues.put("size","1");
				hshQuery = new HashMap();		
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","del_security_crop");
				arrValues.add(strSecurityId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","ins_security_crop");
				arrValues.add(strSecurityId);
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Area")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_Measurement")));
				arrValues.add(strSal);
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_belonging")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_surveyNo")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_cropaddress1")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_cropaddress2")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_cropcity")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_cropdistrict")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_cropstate")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_cropcountry")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_croppin")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_cbscustid")));
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				if(secHisflag==true)
				{
				hshQueryValues=new HashMap();
				int arrquerySize=1;
				String tempOldvalue="",tempNewvalue="",tempField="";
				if(!Helper.correctNull((String)hshValues.get("hidmodifiedField")).equals(""))
					strModifiedField = Helper.correctNull((String)hshValues.get("hidmodifiedField")).split("@") ;
				if(!Helper.correctNull((String)hshValues.get("hidmodifiedvalue")).equals(""))	
					strModifiedValue = Helper.correctNull((String)hshValues.get("hidmodifiedvalue")).split("@");
				if(strModifiedField!=null && strModifiedField.length>0)
				{
					for (int  k = 0; k < strModifiedField.length; k++) 
					{
						tempOldvalue= Helper.correctNull((String)hshValues.get(strModifiedValue[k]));
						tempNewvalue= Helper.correctNull((String)hshValues.get((strModifiedValue[k]).substring(4)));
						tempField= strModifiedField[k];
	
						arrValues=new ArrayList();
						hshQuery = new HashMap();
						arrValues.add(tempField);
						arrValues.add(tempOldvalue);
						arrValues.add(tempNewvalue);
						arrValues.add(Helper.correctNull((String)hshValues.get("strUserId")));
						arrValues.add(strSecurityId);
						hshQuery.put("arrValues", arrValues);
						hshQuery.put("strQueryId", "ins_sec_modified");
						hshQueryValues.put(Integer.toString(arrquerySize),hshQuery);
						hshQueryValues.put("size",Integer.toString(arrquerySize));
						arrquerySize++;
					}
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
				}
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","upd_securities");
				arrValues.add("Y");
				arrValues.add(strSecurityId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");

				
				if(rs!=null)
		    		rs.close();
				strQuery = SQLParser.getSqlQuery("sel_secMailbox_check^"+strSecurityId);
	    		rs = DBUtils.executeQuery(strQuery);
	    		if(rs.next())	
	    		{
	    			String mailboxflag=Helper.correctNull((String)rs.getString("SEC_FLAG"));
					if(mailboxflag.equals("NCN"))
						mailboxflag="N";
					else
						mailboxflag="V";
	    			hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","upd_secMailbox_flag");
					arrValues.add(mailboxflag);
					arrValues.add(strSecurityId);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","2");
					hshQuery.put("strQueryId","upd_cussecurities_changeflag");
					arrValues.add("V");
					arrValues.add(strSecurityId);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("2",hshQuery);
					
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
	    		}

			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_security_crop");
				arrValues.add(strSecurityId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","upd_securities");
				arrValues.add("N");
				arrValues.add(strSecurityId);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2", hshQuery);
				hshQueryValues.put("size","2");
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
		}
		catch (Exception e)
		{
			throw new EJBException("Error in updateSecurityCrop :::  " + e.getMessage());
		}
		return hshQuery;
	}
	
    public HashMap getSecurityCrop(HashMap hshValues)
    {
    	HashMap hshResult=new HashMap();
		ResultSet rs=null,rs1=null;
		String strQuery =null;
		String strSecurityId=null;
		String strGradeId="",appno="";
		try
		{
			strSecurityId = correctNull((String) hshValues.get("hidSecurityId"));
			if(strSecurityId.equalsIgnoreCase(""))
			{
				strSecurityId=Helper.correctNull((String)hshValues.get("hidsecid"));
			}
			strQuery = SQLParser.getSqlQuery("sel_security_crop^"+strSecurityId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{	
				//hshResult.put("SEC_ID",Helper.correctNull(rs.getString("SEC_ID")));
				hshResult.put("SEC_AREA",Helper.correctNull(rs.getString("SEC_AREA")));
				hshResult.put("SEC_MEASUREMENT",Helper.correctNull(rs.getString("SEC_MEASUREMENT")));
				hshResult.put("SEC_SALUTATION",Helper.correctNull(rs.getString("SEC_SALUTATION")));
				hshResult.put("SEC_BELONGING",Helper.correctNull(rs.getString("SEC_BELONGING")));
				hshResult.put("SEC_SUR_NO",Helper.correctNull(rs.getString("SEC_SUR_NO")));
				hshResult.put("SEC_ADDRESS_1",Helper.correctNull(rs.getString("SEC_ADDRESS_1")));
				hshResult.put("SEC_ADDRESS_2",Helper.correctNull(rs.getString("SEC_ADDRESS_2")));
				hshResult.put("SEC_CITYCODE",Helper.correctNull(rs.getString("SEC_CITY")));
				hshResult.put("SEC_DISTCODE",Helper.correctNull(rs.getString("SEC_DIST")));
				hshResult.put("SEC_STATECODE",Helper.correctNull(rs.getString("SEC_STATE")));
		        hshResult.put("SEC_COUNTRYCODE",Helper.correctNull(rs.getString("SEC_COUNTRY")));
				hshResult.put("SEC_PIN",Helper.correctNull(rs.getString("SEC_PIN")));
				
				
				if(!Helper.correctNull(rs.getString("SEC_CITY")).equalsIgnoreCase(""))
				{
					rs1=DBUtils.executeLAPSQuery("sel_citynamebycode^"+Helper.correctNull(rs.getString("SEC_CITY")));
					if(rs1.next())
						hshResult.put("SEC_CITY",Helper.correctNull(rs1.getString("city_name")));
					
					if(rs1!=null)
						rs1.close();
				}
				
				
				
				//dealerstate
				if(!Helper.correctNull(rs.getString("SEC_STATE")).equalsIgnoreCase(""))
				{
					rs1=DBUtils.executeLAPSQuery("sel_statenamebycode^"+Helper.correctNull(rs.getString("SEC_STATE")));
					if(rs1.next())
						hshResult.put("SEC_STATE",Helper.correctNull(rs1.getString("state_name")));
					
					if(rs1!=null)
						rs1.close();
				}
				
				
				//dealercountry
				if(!Helper.correctNull(rs.getString("SEC_COUNTRY")).equalsIgnoreCase(""))
				{
					rs1=DBUtils.executeLAPSQuery("sel_countrynamebycode^"+Helper.correctNull(rs.getString("SEC_COUNTRY")));
					if(rs1.next())
						hshResult.put("SEC_COUNTRY",Helper.correctNull(rs1.getString("con_country")));
					
					if(rs1!=null)
						rs1.close();
				}
				
				
				//dealerdistrict
				if(!Helper.correctNull(rs.getString("SEC_DIST")).equalsIgnoreCase(""))
				{
					rs1=DBUtils.executeLAPSQuery("sel_distnamebycode^"+Helper.correctNull(rs.getString("SEC_DIST")));
					if(rs1.next())
						hshResult.put("SEC_DIST",Helper.correctNull(rs1.getString("district_desc")));
					
					if(rs1!=null)
						rs1.close();
				}
				hshResult.put("sec_cbsid",Helper.correctNull(rs.getString("sec_cbsid")));
				
				
			}
			
			String StrLAPSId = correctNull((String) hshValues.get("hidDemoId"));
			strQuery = SQLParser.getSqlQuery("sel_lapsidfromlapsid^" + StrLAPSId);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()) 
			{
				hshResult.put("perapp_fname", Helper.correctNull((String)rs.getString("perapp_fname")));
				hshResult.put("perapp_cbsid", Helper.correctNull((String)rs.getString("perapp_cbsid")));
				hshResult.put("perapp_oldid", Helper.correctNull((String)rs.getString("perapp_oldid")));
			}
			hshResult.put("strSecID", strSecurityId);
			hshResult.put("hid_VerificationFlag", Helper.correctNull((String)hshValues.get("hid_VerificationFlag")));
		}
		catch (Exception e)
		{
			log.error("Exception in getSecurityVehicle ::: "+ e.getMessage());
		} 
		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				log.error("Exception in getSecurityVehicle ::: "+ cf.getMessage());
			}
		}
		
		return hshResult;
    	
    }
    
    public HashMap getcersaiIDCheckDuplicate(HashMap hshRequestValues) {
		HashMap hshValues = new HashMap();
		ResultSet rs=null,rs1=null;
		String strQuery=null;
		
		try{

			String strCersaiID = correctNull((String) hshRequestValues.get("strcersailIDCorp"));
			String strrowindexname=correctNull((String) hshRequestValues.get("strrowindexname"));
			String strSecId = correctNull((String) hshRequestValues.get("strSecurityId"));
			String strGSTNo = correctNull((String) hshRequestValues.get("strGSTNo"));
			String strBorrowerId = correctNull((String) hshRequestValues.get("strBorrowerId"));
			String strAccNo = correctNull((String) hshRequestValues.get("strAccNo"));

			if(!strCersaiID.equalsIgnoreCase(""))
			{
				rs = DBUtils.executeLAPSQuery("sel_ces_check_dupId^%" + strCersaiID+"%");
				while(rs.next()){
					String cus_id=Helper.correctNull((String)rs.getString("CUS_SEC_ID"));
					if(!cus_id.equals(strSecId) && strCersaiID.equalsIgnoreCase(Helper.correctNull(rs.getString("CERSAI_ID")))){
						hshValues.put("strCersaiCheck", "Y");
						hshValues.put("CUS_SEC_ID",Helper.correctNull(rs.getString("CUS_SEC_ID")));
					}
	
				}
	
				if(!(Helper.correctNull((String)hshValues.get("strCersaiCheck"))).equalsIgnoreCase("Y"))
				{
					if(rs !=null)
						rs.close();
					rs = DBUtils.executeLAPSQuery("sel_ces_check_property_dupId^%" + strCersaiID+"%");
					while(rs.next())
					{
						String sec_id=Helper.correctNull((String)rs.getString("SEC_ID"));
						if(!sec_id.equals(strSecId) && strCersaiID.equalsIgnoreCase(Helper.correctNull(rs.getString("CERSAI_ID")))){
							hshValues.put("strCersaiCheck", "Y");
							hshValues.put("CUS_SEC_ID",Helper.correctNull(rs.getString("SEC_ID")));
						}
					}
				}
			}
			else if(!strGSTNo.equalsIgnoreCase(""))
			{
				rs = DBUtils.executeLAPSQuery("chk_duplicateGST^%" + strGSTNo+"%^"+strBorrowerId);
				while(rs.next())
				{
					if(rs1!=null)
						rs1.close();
					if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
					{
						strQuery=SQLParser.getCBSSqlQuery("cbscusmastersearch_newconnection^"+Helper.correctNull(rs.getString("perapp_cbsid")));
						rs1=DBUtils.executeQueryCBSConnection(strQuery);
					}
					else
					{
						strQuery= SQLParser.getSqlQuery("cbscusmastersearch^"+Helper.correctNull(rs.getString("perapp_cbsid")));
						rs1=DBUtils.executeQuery(strQuery); 
					}
					if(rs1.next())
					{
						hshValues.put("strGSTAvailability", "Y");
						hshValues.put("strCustCBSID", Helper.correctNull(rs.getString("perapp_cbsid")));
					}
					
	
				}
			}
			else if(!strAccNo.equalsIgnoreCase(""))
			{
				if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
				{
					strQuery=SQLParser.getCBSSqlQuery("chk_operativeaccno^"+strAccNo);
					rs1=DBUtils.executeQueryCBSConnection(strQuery);
				}
				else
				{
					strQuery= SQLParser.getSqlQuery("chk_operativeaccno1^"+strAccNo);
					rs1=DBUtils.executeQuery(strQuery); 
				}
				if(!rs1.next())
				{
					hshValues.put("strAccNoAvailability", "N");
				}
					
	
			}

			hshValues.put("name", strrowindexname);
		}
		
		catch(Exception e){
			e.printStackTrace();
			
		}
		return hshValues;
	}
    public void updateSecurityMovement(HashMap hshValues)
    {
    	HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues= new ArrayList();
		String strAction =Helper.correctNull((String)hshValues.get("hidAction"));
		String strAppno="";
		ResultSet rs=null;
		String[] strFromYear=null;
		String[] strToYear=null;
		String[] strExposure=null;
		String[] strSecCoverage=null;
		String[] strNetworth=null;
		String[] strEXPNetworth=null;
		try
		{
			strAppno =correctNull((String) hshValues.get("appno"));
			if(strAction.equalsIgnoreCase("update"))
			{
				int intSize=0;
				
				++intSize;
				arrValues=new ArrayList();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_management_assementAll");
				arrValues.add("SecCoverage");
				arrValues.add("1");
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				if(hshValues.get("txt_fromyear") instanceof java.lang.String)
				{
					if(!Helper.correctNull((String)hshValues.get("txt_fromyear")).equalsIgnoreCase(""))
					{
						hshQuery = new HashMap();
						++intSize;
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "ins_management_assement");
						arrValues.add(strAppno);
						arrValues.add("1");
						arrValues.add(String.valueOf(intSize));
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_fromyear")));
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_exposure")));
						arrValues.add("SecCoverage");
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_seccoverage")));
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_networth")));
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_extimes")));
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_toyear")));
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("size", String.valueOf(intSize));
						hshQueryValues.put(String.valueOf(intSize), hshQuery);
					}
				}
				else
				{
					strFromYear=(String [])hshValues.get("txt_fromyear");
					strToYear=(String [])hshValues.get("txt_toyear");
					strExposure=(String [])hshValues.get("txt_exposure");
					strSecCoverage=(String [])hshValues.get("txt_seccoverage");
					strNetworth=(String [])hshValues.get("txt_networth");
					strEXPNetworth=(String [])hshValues.get("txt_extimes");
					
					for(int i=0;i<strFromYear.length;i++)
					{
							hshQuery = new HashMap();
							++intSize;
							arrValues = new ArrayList();
							hshQuery.put("strQueryId", "ins_management_assement");
							arrValues.add(strAppno);
							arrValues.add("1");
							arrValues.add(String.valueOf(intSize));
							arrValues.add(Helper.correctNull(strFromYear[i]));
							arrValues.add(Helper.correctNull(strExposure[i]));
							arrValues.add("SecCoverage");
							arrValues.add(Helper.correctNull(strSecCoverage[i]));
							arrValues.add(Helper.correctNull(strNetworth[i]));
							arrValues.add(Helper.correctNull(strEXPNetworth[i]));
							arrValues.add(strToYear[i]);
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("size", String.valueOf(intSize));
							hshQueryValues.put(String.valueOf(intSize), hshQuery);
					}
				}
				
				if(intSize>0)
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				arrValues=new ArrayList();
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_management_assementAll");
				arrValues.add("SecCoverage");
				arrValues.add("1");
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
		}
		catch (Exception e)
		{
			throw new EJBException("Error in updateSecurityMovement :::  " + e.getMessage());
		}
	}
     
    public HashMap getSecurityMovement(HashMap hshValues)
    {

    	HashMap hshResult=new HashMap();
		ResultSet rs=null;
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		try
		{
			String strAppno=Helper.correctNull((String)hshValues.get("appno"));
			rs=DBUtils.executeLAPSQuery("sel_management_Assement^SecCoverage^1^"+strAppno);
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull(rs.getString("ASSEMENT_COMMENT")));
				arrCol.add(Helper.correctNull(rs.getString("ASSESS_CMT5")));
				arrCol.add(Helper.correctNull(rs.getString("ASSEMENT_COMMENT1")));
				arrCol.add(Helper.correctNull(rs.getString("ASSESS_COMMENTS2")));
				arrCol.add(Helper.correctNull(rs.getString("ASSESS_COMMENTS3")));
				arrCol.add(Helper.correctNull(rs.getString("ASSESS_COMMENT4")));
				arrRow.add(arrCol);
			}
			
			hshResult.put("arrRow",arrRow);
		}
		catch (Exception e)
		{
			log.error("Exception in getSecurityMovement ::: "+ e.getMessage());
		} 
		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				log.error("Exception in getSecurityMovement ::: "+ cf.getMessage());
			}
		}
		return hshResult;
    }
    public HashMap getcropType(HashMap hshRequestValues)
    {
    	HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
    	String strQuery = "";
    	ResultSet rs=null;
    	try{
    		if(rs!=null)
	    		rs.close();
			String corptype = Helper.correctNull((String)hshRequestValues.get("corptype"));
			String strcersaireq="";
			strQuery=SQLParser.getSqlQuery("sel_corptype^"+corptype);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strcersaireq =  correctNull(rs.getString("STATIC_DATA_CERSAIREQ"));
				hshQuery.put("strcersaireq", strcersaireq);
			}
    	}catch (Exception e)
		{
			log.error("Exception in getcropType ::: "+ e.getMessage());
		} 
    	return hshQuery;
    }
    
    //
    
public HashMap getAgriunitcostMaster(HashMap hshValues)  {
		
		String strQuery="";
		ResultSet rs = null,rs1=null;
		HashMap hshRecord = new HashMap();
		ArrayList arrVal = new ArrayList();
		ArrayList arrRow = new ArrayList();
		ArrayList arrRow2 = new ArrayList();
		ArrayList arrRow3 = new ArrayList();
		ArrayList arrRow4 = new ArrayList();
		String strValue = "";
		String strParent = "";
		String strAction="";
		String selScheme="",sel_state="",sel_actname="",sel_specifica="",sel_Action="",strSno="",strParent1="",strParent2="",strParent3="";
		strParent = Helper.correctNull((String)hshValues.get("selScheme"));	
		strParent1 = Helper.correctNull((String)hshValues.get("sel_state"));
		strParent2 = Helper.correctNull((String)hshValues.get("sel_actname"));
		strParent3 = Helper.correctNull((String)hshValues.get("sel_specifica"));
		try
		{	
			
			
			if(Helper.correctNull((String)hshValues.get("sel_view")).equalsIgnoreCase("view")  && (! Helper.correctNull((String)hshValues.get("hidsno")).equalsIgnoreCase("")) )
			{
				strQuery = SQLParser.getSqlQuery("selagriunitcostmasterschstateActSpecType^"+strParent+"^"+strParent1+"^"+strParent2+"^"+strParent3);
				rs = DBUtils.executeQuery(strQuery);
				
				if(rs.next())
				{
					arrVal = new ArrayList();
					hshRecord.put("strStatId",Helper.correctNull((String)rs.getString("AGR_DATA_SCHEME")));
					selScheme=Helper.correctNull((String)rs.getString("AGR_DATA_SCHEME"));
					
					hshRecord.put("AGR_DATA_STATE",Helper.correctNull((String)rs.getString("AGR_DATA_STATE")));
					hshRecord.put("AGR_DATA_ACTNAME",Helper.correctNull((String)rs.getString("AGR_DATA_ACTNAME")));
					hshRecord.put("AGR_DATA_SPECIFICATIONS",Helper.correctNull((String)rs.getString("AGR_DATA_SPECIFICATIONS")));
					hshRecord.put("AGR_ACTIVE",Helper.correctNull((String)rs.getString("AGR_ACTIVE")));
					hshRecord.put("stat_data_sno",Helper.correctNull((String)rs.getString("AGR_DATA_ID")));
					
					
					
					
					sel_state = Helper.correctNull((String)rs.getString("AGR_DATA_STATE"));
					sel_actname = Helper.correctNull((String)rs.getString("AGR_DATA_ACTNAME"));
					sel_specifica=Helper.correctNull((String)rs.getString("AGR_DATA_SPECIFICATIONS"));
					sel_Action=Helper.correctNull((String)rs.getString("AGR_ACTIVE"));
					strSno=Helper.correctNull((String)rs.getString("AGR_DATA_ID"));
					arrVal.add(strSno);

					
					arrVal.add(selScheme);
					
					arrVal.add(sel_state);
					arrVal.add(sel_actname);
					arrVal.add(sel_specifica);
					arrVal.add(sel_Action);
					strQuery = SQLParser.getSqlQuery("sel_static_data_masterauc^"+"285"+"^"+selScheme);
					rs1 = DBUtils.executeQuery(strQuery);
					
					if(rs1.next())
					{
						selScheme=Helper.correctNull((String)rs1.getString("stat_data_desc1"));
					}
					
					if(rs1!=null){
						rs1.close();
					}
					arrVal.add(selScheme);
					
					strQuery = SQLParser.getSqlQuery("getflexstatetypeauc^"+sel_state);
					rs1 = DBUtils.executeQuery(strQuery);
					
					if(rs1.next())
					{
						sel_state=Helper.correctNull((String)rs1.getString("state_name"));
					}
					
					if(rs1!=null){
						rs1.close();
					}
					
					arrVal.add(sel_state);
					//arrRow.add(arrVal);
				}
			}
		//	 if(strParent.equalsIgnoreCase(""))
		//	{
				arrRow = new ArrayList();
			rs = DBUtils.executeLAPSQuery("selagriunitcostmasterschTypeAll");;
			
			while(rs.next())
			{
				arrVal = new ArrayList();
				selScheme= Helper.correctNull((String)rs.getString("AGR_DATA_SCHEME"));
				sel_state = Helper.correctNull((String)rs.getString("AGR_DATA_STATE"));
				sel_actname = Helper.correctNull((String)rs.getString("AGR_DATA_ACTNAME"));
				sel_specifica=Helper.correctNull((String)rs.getString("AGR_DATA_SPECIFICATIONS"));
				sel_Action=Helper.correctNull((String)rs.getString("AGR_ACTIVE"));
				strSno = Helper.correctNull((String)rs.getString("AGR_DATA_ID"));
				arrVal.add(strSno);
				
				arrVal.add(selScheme);	
				arrVal.add(sel_state);
				arrVal.add(sel_actname);
				arrVal.add(sel_specifica);
				
				
				
				strQuery = SQLParser.getSqlQuery("sel_static_data_masterauc1^"+"286"+"^"+sel_actname);
				rs1 = DBUtils.executeQuery(strQuery);
				
				if(rs1.next())
				{
					sel_actname=Helper.correctNull((String)rs1.getString("stat_data_desc1"));
				}
				
										
				
				if(rs1!=null){
					rs1.close();
				}
				arrVal.add(sel_actname);
				
				
				strQuery = SQLParser.getSqlQuery("sel_static_data_masterauc1^"+"287"+"^"+sel_specifica);
				rs1 = DBUtils.executeQuery(strQuery);
				
				if(rs1.next())
				{
					sel_specifica=Helper.correctNull((String)rs1.getString("stat_data_desc1"));
				}
				
					
					
				
				if(rs1!=null){
					rs1.close();
				}
				arrVal.add(sel_specifica);
				
				arrVal.add(sel_Action);
				
				strQuery = SQLParser.getSqlQuery("sel_static_data_masterauc^"+"285"+"^"+selScheme);
				rs1 = DBUtils.executeQuery(strQuery);
				
				if(rs1.next())
				{
					selScheme=Helper.correctNull((String)rs1.getString("stat_data_desc1"));
				}
				
				if(rs1!=null){
					rs1.close();
				}
				arrVal.add(selScheme);
				
				strQuery = SQLParser.getSqlQuery("getflexstatetypeauc^"+sel_state);
				rs1 = DBUtils.executeQuery(strQuery);
				
				if(rs1.next())
				{
					sel_state=Helper.correctNull((String)rs1.getString("state_name"));
				}
				
				if(rs1!=null){
					rs1.close();
				}
				
				arrVal.add(sel_state);
				arrRow.add(arrVal);
			}
			//}
			
			if(rs!=null){
				rs.close();
			}
			
			
			hshRecord.put("arrRow",arrRow);
					
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getAgriunitcostMaster "+ce.toString());
		}
		
		return hshRecord;
	}
    
    public HashMap updateAgriunitcostMaster(HashMap hshValues)  {
	
	HashMap hshRecord = new HashMap();
	HashMap hshQueryValues = new HashMap();
	HashMap hshQuery = new HashMap();
	ArrayList arrValues = new ArrayList();
	int maxsno =0;
	String strAction =null;
	String selScheme =null;
	String sel_state=null;
	String sel_actname=null;
	String sel_specifica=null;
	String sel_Action=null;
	String parentid="0";
	ResultSet rs = null;
	String strSno="";
	String strIsLiquid="";
	String strSecAction=null;
	
	try{
		
		strAction = Helper.correctNull((String)hshValues.get("hidAction"));
		selScheme= Helper.correctNull((String)hshValues.get("selScheme"));
		sel_state = Helper.correctNull((String)hshValues.get("sel_state"));
		sel_actname = Helper.correctNull((String)hshValues.get("sel_actname"));
		sel_specifica=Helper.correctNull((String)hshValues.get("sel_specifica"));
		sel_Action=Helper.correctNull((String)hshValues.get("sel_Action"));
					
		if (strAction.equalsIgnoreCase("insert"))
		{				
			rs = DBUtils.executeLAPSQuery("selmaxagriunitcostmaster");
			if(rs.next()){
				maxsno = rs.getInt("snomax");
			}
			arrValues = new ArrayList();
			hshQuery = new HashMap();
									
			arrValues.add(String.valueOf(maxsno));
			arrValues.add(selScheme.toString());
			arrValues.add(sel_state);
			arrValues.add(sel_actname);
			arrValues.add(sel_specifica);
			arrValues.add(sel_Action);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","insagriunitcostmaster");
			hshQueryValues.put("size","1");					
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
		}

					
		if (strAction.equalsIgnoreCase("update")){
			
			strSno = Helper.correctNull((String)hshValues.get("hidsno"));
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			arrValues.add(selScheme.toString());
			arrValues.add(sel_state);
			arrValues.add(sel_actname);
			arrValues.add(sel_specifica);
			arrValues.add(sel_Action);
			arrValues.add(strSno);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","updAgriunitcostList");
			hshQueryValues.put("size","1");					
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
		}
		
		if (strAction.equalsIgnoreCase("delete")){
			
			strSno = Helper.correctNull((String)hshValues.get("hidsno"));
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			arrValues.add(strSno);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","delAgriunitcost");
			hshQueryValues.put("size","1");					
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
		}
		//hshRecord=getAgriunitcostMaster(hshValues);

	}
	catch(Exception ce){
		log.error(ce.toString());
		throw new EJBException("Error in updateAgriunitcostMaster "+ce.toString());
	}
	return hshRecord;
}
}
