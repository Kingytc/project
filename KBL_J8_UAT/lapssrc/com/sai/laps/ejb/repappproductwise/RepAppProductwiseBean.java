

package com.sai.laps.ejb.repappproductwise;

import com.sai.laps.helper.*;

import java.sql.*;
import java.util.*;
import java.lang.Double;
import com.sai.laps.helper.DBUtils;
import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

@Stateless(name = "RepAppProductwiseBean", mappedName = "RepAppProductwiseHome")
@Remote (RepAppProductwiseRemote.class)
public class RepAppProductwiseBean extends BeanAdapter
{

    /**
	 * 
	 */
	private static final long serialVersionUID = -4982892010204728414L;
	/**
	 * 
	 */
	
	
	public RepAppProductwiseBean()
    {
    }

    public HashMap getData(HashMap hashtable)
        
    {
        HashMap hashtable1 = new HashMap();
        try
        {
            String s1 = (String)hashtable.get("hidMethod");
            if(s1.equalsIgnoreCase("getRepDetails"))
                hashtable1 = getRepDetails(hashtable);
            else
            if(s1.equalsIgnoreCase("showProfile"))
                hashtable1 = showProfile(hashtable);
            else
            if(s1.equalsIgnoreCase("getParamList"))
                hashtable1 = getParamList(hashtable);
            else
            if(s1.equalsIgnoreCase("getOrgProducts"))
                hashtable1 = getOrgProducts(hashtable);
        }
        catch(Exception exception)
        {
            throw new EJBException("Error in getdata " + exception.toString());
        }
        return hashtable1;
    }

    private HashMap getRepDetails(HashMap hashtable)
        
    {
        
        ResultSet resultset = null;       
        HashMap hashtable1 = null;
       double dbltemp=0.00;
       java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
		nf.setGroupingUsed(false);
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
		String strOrgName="";
        try
        {
            try
            {

                String s = (String)hashtable.get("txtSaveDate");
                String s1 = (String)hashtable.get("strUserId");
                String strOrgCode = (String)hashtable.get("hidOrgCode");
                String s3 = (String)hashtable.get("hidSelFields");
                String s4 = (String)hashtable.get("hidOpFields");
                String s5 = (String)hashtable.get("hidProducts");
                String s6 = (String)hashtable.get("txtDate");
                String s7 = (String)hashtable.get("hidLoanType");
                String strOrglevel=null;
                strOrglevel=correctNull((String)hashtable.get("orglevel"));
                strOrgName=correctNull((String)hashtable.get("hidOrgName"));
        		StringBuffer strbufOrgcode=new StringBuffer();
        		
                strOrgCode=strOrgCode.replaceAll("'","");
    			if(strOrglevel.equalsIgnoreCase("C"))
    			{
    				strbufOrgcode.append("org_code like '001%'");
    			}
    			else if(strOrglevel.equalsIgnoreCase("R")||strOrglevel.equalsIgnoreCase("CPC"))
    			{
    				strbufOrgcode.append("org_code like '").append(strOrgCode.substring(0,6)).append("%'");
    			}
    			else if(strOrglevel.equalsIgnoreCase("D"))
    			{
    				strbufOrgcode.append("org_code like '").append(strOrgCode.substring(0,9)).append("%'");
    			}
    			else if(strOrglevel.equalsIgnoreCase("A"))
    			{
    				strbufOrgcode.append("org_code like '").append(strOrgCode.substring(0,12)).append("%'");
    			}
    			else if(strOrglevel.equalsIgnoreCase("B"))
    			{
    				strbufOrgcode.append("org_code = '").append(strOrgCode).append("'");
    			}
                
                String s8 = SQLParser.getSqlQuery("selusername^" + s1);
                String s12="",s9="",s10="";
                int sum_app=0;
               double  sum_amt=0;
                for(resultset = DBUtils.executeQuery(s8); resultset.next();)
                    s1 = correctNull(resultset.getString(1)) + " " + correctNull(resultset.getString(2)); 

                if(s6.equals("All"))
                {
                    s8 = SQLParser.getSqlQuery("selproductwise^" + s4 + "^" + strbufOrgcode + "^" + s5 + "^" + s7);
                }
                else
                {
                    s9 = s6.substring(0, s6.indexOf("-"));
                    s10 = s6.substring(s6.indexOf("-") + 1, s6.length());
                    if(strOrglevel.equalsIgnoreCase("CPC"))
                    	s8 = SQLParser.getSqlQuery("selproductdatewise_cpc^" + s4 + "^app_applnholder^" + strbufOrgcode + "^" + s5 + "^" + s9 + "^" + s10 + "^" + s7+"^op','ol");	
                    else
                    	s8 = SQLParser.getSqlQuery("selproductdatewise^" + s4 + "^" + strbufOrgcode + "^" + s5 + "^" + s9 + "^" + s10 + "^" + s7);
                }
                if(resultset != null)
                	resultset.close();
                resultset = DBUtils.executeQuery(s8);
                hashtable1 = new HashMap();
                ArrayList ArrayList = new ArrayList();
                ArrayList ArrayList1;
                for(; resultset.next(); ArrayList.add(ArrayList1))
                {
                    ArrayList1 = new ArrayList();
                    String s11 = correctNull(resultset.getString("org_name"));
                    ArrayList1.add(s11);
                    ArrayList1.add("left");
                    String a=correctNull(resultset.getString("cat_name"));
                   // String b=correctNull(resultset.getString("scatname"));
                   // String c = correctNull(resultset.getString("prd_desc"));
                   // s11 = a+"-"+b+"-"+c;
                    s11 = a;
                    ArrayList1.add(s11);
                    ArrayList1.add("left");
                    s11 = correctNull(resultset.getString("app_status"));
                    if(s11.equalsIgnoreCase("op"))
                        s11 = "Inprocess";
                    else
                    if(s11.equalsIgnoreCase("pa"))
                        s11 = "Sanctioned";
                    else
                    if(s11.equalsIgnoreCase("pr"))
                        s11 = "Rejected/Return";
                    else
                    if(s11.equalsIgnoreCase("ca"))
                        s11 = "Closed/Approved";
                    else
                    if(s11.equalsIgnoreCase("cr"))
                        s11 = "Closed/Rejected";
                    
                    else
                        if(s11.equalsIgnoreCase("ol"))
                            s11 = "Open/Lodged";
                        
                    ArrayList1.add(s11);
                    ArrayList1.add("left");
                    s11 = correctNull(resultset.getString("appno"));
                    
                    ArrayList1.add(s11);
                    sum_app=sum_app+Integer.parseInt(s11);
                    ArrayList1.add("center");
                    s11 = Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(resultset.getString("loan_recmdamt"))));
                    
                    ArrayList1.add(s11);
                    sum_amt=sum_amt+Double.parseDouble(s11);                   
                 
                    ArrayList1.add("right");
                }
                if(resultset != null)
                	resultset.close();
                if(strOrglevel.equalsIgnoreCase("CPC"))
                {
                s12 = SQLParser.getSqlQuery("selproductdatewise_cpc^" + s4 + "^app_approvedby^" + strbufOrgcode + "^" + s5 + "^" + s9 + "^" + s10 + "^" + s7+"^pa','pr','ca','cr");
                resultset = DBUtils.executeQuery(s12);
                for(; resultset.next(); ArrayList.add(ArrayList1))
                {
                    ArrayList1 = new ArrayList();
                    String s11 = correctNull(resultset.getString("org_name"));
                    ArrayList1.add(s11);
                    ArrayList1.add("left");
                    String a=correctNull(resultset.getString("cat_name"));
                   // String b=correctNull(resultset.getString("scatname"));
                   // String c = correctNull(resultset.getString("prd_desc"));
                   // s11 = a+"-"+b+"-"+c;
                    s11 = a;
                    ArrayList1.add(s11);
                    ArrayList1.add("left");
                    s11 = correctNull(resultset.getString("app_status"));
                    if(s11.equalsIgnoreCase("op"))
                        s11 = "Inprocess";
                    else
                    if(s11.equalsIgnoreCase("pa"))
                        s11 = "Sanctioned";
                    else
                    if(s11.equalsIgnoreCase("pr"))
                        s11 = "Rejected/Return";
                    else
                    if(s11.equalsIgnoreCase("ca"))
                        s11 = "Closed/Approved";
                    else
                    if(s11.equalsIgnoreCase("cr"))
                        s11 = "Closed/Rejected";
                    
                    else
                        if(s11.equalsIgnoreCase("ol"))
                            s11 = "Open/Lodged";
                        
                    ArrayList1.add(s11);
                    ArrayList1.add("left");
                    s11 = correctNull(resultset.getString("appno"));
                    
                    ArrayList1.add(s11);
                    sum_app=sum_app+Integer.parseInt(s11);
                    ArrayList1.add("center");
                    s11 = Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(resultset.getString("loan_recmdamt"))));
                    
                    ArrayList1.add(s11);
                    sum_amt=sum_amt+Double.parseDouble(s11);                   
                 
                    ArrayList1.add("right");
                }
                }
                hashtable1.put("sum_app",Integer.toString(sum_app));
                hashtable1.put("sum_amt",Helper.formatDoubleValue(sum_amt));
                hashtable1.put("txtDate", s6);
                hashtable1.put("vecValues", ArrayList);
                hashtable1.put("labels", s3);
                hashtable1.put("genby", s1);
                hashtable1.put("txtSaveDate", s);
                hashtable1.put("OrgName",strOrgName);

			}
            catch(Exception exception)
            {
                throw new EJBException("inside getdata" + exception.toString());
            }
        }
        finally
        {
            try
            {
                if(resultset != null)
                    resultset.close();
                
            }
            catch(Exception exception2)
            {
                throw new EJBException("close" + exception2.toString());
            }
        }
        return hashtable1;
    }

    private HashMap showProfile(HashMap hashtable)
        
    {        
        ResultSet resultset = null;
      
        HashMap hashtable1 = new HashMap();
        
        ArrayList ArrayList = new ArrayList();
        ArrayList ArrayList1 = new ArrayList();
        
        try
        {
            try
            {               
                HashMap hashtable3 = (HashMap)EJBInvoker.executeStateLess("repData", hashtable, "getParameter");
                String s = (String)hashtable3.get("param");
                String s1 = (String)hashtable3.get("profilename");
                StringTokenizer stringtokenizer = new StringTokenizer(s, ";");
                String s2 = stringtokenizer.nextToken();
                String s3 = stringtokenizer.nextToken();
                String s4 = stringtokenizer.nextToken();
                s4 = s4.replace('\'', ' ');
                String s5 = stringtokenizer.nextToken();
                String s7 = stringtokenizer.nextToken();
                String s8 = stringtokenizer.nextToken();
                s8 = stringtokenizer.nextToken();
                ArrayList.add("Profile Name");
                ArrayList.add("Organisation Level");
                ArrayList.add("Organisation Names");
                ArrayList.add("Products");
                ArrayList.add("Period");
                ArrayList.add("Output Fields");
                ArrayList1.add(s1);
                ArrayList1.add(s2);
                String s9 = SQLParser.getSqlQuery("repbanknames^" + s3);
                resultset = DBUtils.executeQuery(s9);
                for(s3 = ""; resultset.next(); s3 = s3 + correctNull(resultset.getString("org_name")) + ",");
                s3 = s3.substring(0, s3.length() - 1);
                ArrayList1.add(s3);
                ArrayList1.add(s8);
                ArrayList1.add(s5);
                ArrayList1.add(s7);
                hashtable1.put("vecLabel", ArrayList);
                hashtable1.put("vecValue", ArrayList1);
            }
            catch(Exception exception)
            {
                throw new EJBException("Error in help " + exception.toString());
            }
        }
        finally
        {
            try
            {
                if(resultset != null)
                    resultset.close();
                
            }
            catch(Exception exception2)
            {
                throw new EJBException("Error closing the connection " + exception2.getMessage());
            }
        }
        return hashtable1;
    }

    private HashMap getParamList(HashMap hashtable)
        
    {
        HashMap hashtable1 = new HashMap();
        
      
        try
        {
            HashMap hashtable3 = (HashMap)EJBInvoker.executeStateLess("repData", hashtable, "getParameter");
            String s = (String)hashtable3.get("genby");
            String s1 = (String)hashtable3.get("txtDate");
            String s2 = (String)hashtable3.get("param");
            StringTokenizer stringtokenizer = new StringTokenizer(s2, ";");
            String s4 = stringtokenizer.nextToken();
            String s5 = stringtokenizer.nextToken();
            String s6 = stringtokenizer.nextToken();
            String s7 = stringtokenizer.nextToken();
            String s8 = stringtokenizer.nextToken();
            String s9 = stringtokenizer.nextToken();
            hashtable1.put("hidOrgCode", s4);
            hashtable1.put("hidProducts", s5);
            hashtable1.put("txtDate", s6);
            hashtable1.put("hidSelFields", s8);
            hashtable1.put("hidOpFields", s7);
            hashtable1.put("hidLoanType", s9);
            hashtable1.put("txtSaveDate", s1);
            hashtable1.put("strUserId", s);
            hashtable = new HashMap();
            hashtable = getRepDetails(hashtable1);
        }
        catch(Exception exception)
        {
            throw new EJBException("Error in help " + exception.toString());
        }
        return hashtable;
    }

    private HashMap getOrgProducts(HashMap hashtable)
        
    {       
        //ResultSet resultset = null;
        ResultSet rs = null;
        //ResultSet re=null;
       // ResultSet re1=null;
        HashMap hashtable1 = new HashMap();
       
        ArrayList ArrayList = new ArrayList();
        ArrayList ArrayList1 = new ArrayList();
       
		//String strShortCode="";
		String strSubCat="";
		String strCat="";
		String strProdtype=null;

        try
        {
            try
            {
                
                String s = (String)hashtable.get("hidOrgCode");
                strProdtype=correctNull((String)hashtable.get("prodtype"));
				String strQry = SQLParser.getSqlQuery("selorgsortcode^"+ s);

				//resultset = DBUtils.executeQuery(strQry);
				//while(resultset.next())
				//{
					//strShortCode= resultset.getString(1);
					//if(!strShortCode.equals(""))
					//{
						if(rs != null)
							rs.close();
						strQry = SQLParser.getSqlQuery("getPrdListReport^"+strProdtype+"%");//^"+ strShortCode);
						rs = DBUtils.executeQuery(strQry);
						while(rs.next() )
						{
							ArrayList.add(correctNull((String)rs.getString("prdcode")));
							strSubCat=correctNull((String)rs.getString("subcategory"));
							strCat=correctNull((String)rs.getString("category"));
							ArrayList1.add(strCat+" - "+strSubCat);
						}
					//}					
				//}
				hashtable1.put("vecCodes", ArrayList);
				hashtable1.put("vecValues", ArrayList1);
     }
            catch(Exception exception)
            {
                throw new EJBException("Error in help " + exception.toString());
            }
        }
        finally
        {
            try
            {
               // if(resultset != null)
                //    resultset.close();
				//if(re != null)
				//	re.close();
				//if(re1 != null)
				//	re1.close();
				if(rs != null)
					rs.close();
                
            }
            catch(Exception exception2)
            {
                throw new EJBException("Error closing the connection " + exception2.getMessage());
            }
        }
        return hashtable1;
    }
    
    public HashMap getMonthlyStatement(HashMap hashtable)
    
    {
    	HashMap hshRecord=new HashMap();
    	HashMap hshTemp=new HashMap();
    	HashMap hshRiskRating=new HashMap();
    	String strOrgCode="";    	
    	ResultSet rs = null;
    	ResultSet rs1 = null;
    	ResultSet rs2 = null;
    	ResultSet rs3 = null;
    	ResultSet rs4 = null;
    	ResultSet rs5 = null;
    	String strQuery="";
    	String appno,strCount="";
    	String strApplName="";
    	int count=0;
    	ArrayList arrCol=new ArrayList();
    	ArrayList arrVecCollat=new ArrayList();
    	
    	try {
    		 
    		strOrgCode=Helper.correctNull((String)hashtable.get("strOrgCode"));
    		String selmonth=correctNull((String)hashtable.get("selmonth"));
			String selyear=correctNull((String)hashtable.get("selyear"));
			String year=selyear;

			String month=selmonth;
			
			String adjustDate="01/"+month+"/"+year;
			strQuery=SQLParser.getSqlQuery("getApprovedAppl^"+strOrgCode+"^"+adjustDate);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next()){
				ArrayList arrRow=new ArrayList();
				count=count+1;
				strCount=Integer.toString(count);
				arrRow.add(strCount);//0
				appno=Helper.correctNull(rs.getString("app_no"));
				strQuery=SQLParser.getSqlQuery("selappraisalsanc^"+appno);
				rs4=DBUtils.executeQuery(strQuery);
				if(rs4.next())
				{
					 strApplName=Helper.correctNull(rs4.getString("applname"));
				}
				
				arrRow.add(strApplName);
				
				
				arrRow.add(Helper.correctNull(rs.getString("app_processdate")));//2
				
				
				
				strQuery = SQLParser.getSqlQuery("getApprovedLoanDetails^"+appno);
				
				if(rs3 != null)
				rs3.close();
				rs3 = DBUtils.executeQuery(strQuery);
			
				if(rs3.next())
				{   
					arrRow.add(correctNull(rs3.getString("loan_modintrate")));//3
					arrRow.add(correctNull(rs3.getString("loan_recmdamt")));//4
					arrRow.add(Helper.CLOBToString(rs3.getClob("loan_purposeofloan")));//5
								
					
				
				}
				else{
					arrRow.add("");//3
					arrRow.add("");//4
					arrRow.add("");//5
				}
				
				strQuery = SQLParser.getSqlQuery("selpropertydetails^"+appno);
				
					if(rs1!=null)
						rs1.close();
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{	
					arrRow.add((String)correctNull(rs1.getString("prop_add1")));//6
					arrRow.add((String)correctNull(rs1.getString("prop_add2")));//7
					arrRow.add((String)correctNull(rs1.getString("prop_city")));//8
					arrRow.add((String)correctNull(rs1.getString("prop_state")));//9
					arrRow.add((String)correctNull(rs1.getString("prop_pin")));//10
					arrRow.add((String)correctNull(rs1.getString("prop_name")));//11
				}
				else{
					arrRow.add("");//6
					arrRow.add("");//7
					arrRow.add("");//8
					arrRow.add("");//9
					arrRow.add("");//10
					arrRow.add("");//11
				}
				strQuery = SQLParser.getSqlQuery("Appraisalgetcollateral^"+appno);
				if(rs2!=null)
					rs2.close();
				rs2=DBUtils.executeQuery(strQuery);
				arrVecCollat=new ArrayList();
				while(rs2.next())
				{
					ArrayList arrColCollat = new ArrayList();
					arrColCollat.add(correctNull(rs2.getString("home_applnt")));
					arrColCollat.add(correctNull(rs2.getString("home_titleadd1")));
					arrColCollat.add(correctNull(rs2.getString("home_titleadd2")));
					arrColCollat.add(correctNull(rs2.getString("home_titlecity")));
					arrColCollat.add(correctNull(rs2.getString("home_titlestate")));
					arrColCollat.add(correctNull(rs2.getString("home_titlezip")));
					arrColCollat.add(correctNull(rs2.getString("home_propname")));
					arrColCollat.add(correctNull(rs2.getString("home_appval")));
					
					
					arrVecCollat.add(arrColCollat);

			}
				arrRow.add(arrVecCollat);//12
				
				hshTemp.put("appno",appno);
				
				hshRiskRating = new HashMap();

				hshRiskRating=(HashMap)EJBInvoker.executeStateLess("perrskana",hshTemp,"getData");
				String strScore = (String)hshRiskRating.get("totscore");
				String strGrade = (String)hshRiskRating.get("cutoffdesc");
				
				arrRow.add("Score "+strScore+" / Grade"+strGrade);//13
				strQuery = SQLParser.getSqlQuery("appraisalprint1^"+appno);
				if(rs5!=null)
					rs5.close();
				rs5=DBUtils.executeQuery(strQuery);
				if(rs5.next()){
					arrRow.add(correctNull(rs5.getString("auto_model")));//15
					arrRow.add(correctNull(rs5.getString("auto_make")));//16
					arrRow.add(correctNull(rs5.getString("auto_regno")));//17
					
				}
				else{
					arrRow.add("");//15
					arrRow.add("");//16
					arrRow.add("");//17
					
				}
				
				
				//-------------For Designation
				strQuery = SQLParser.getSqlQuery("selperempval^"+appno);
				if(rs5!=null)
					rs5.close();
				rs5=DBUtils.executeQuery(strQuery);
				if(rs5.next()){
					arrRow.add(correctNull(rs5.getString("peremp_empdesig")));//17
					
				}
				else{
					arrRow.add("");//17
					
				}
				
				//--------------For Facility
				strQuery = SQLParser.getSqlQuery("selappfacility^"+appno);
				if(rs5!=null)
					rs5.close();
				rs5=DBUtils.executeQuery(strQuery);
				if(rs5.next()){
					arrRow.add(correctNull(rs5.getString("appsanc_facility")));//18
					
				}
				else{
					arrRow.add("");//18
					
				}
				
				//--------------For Limit
				strQuery = SQLParser.getSqlQuery("selappraisalsanc^"+appno);
				if(rs5!=null)
					rs5.close();
				rs5=DBUtils.executeQuery(strQuery);
				if(rs5.next()){
					arrRow.add(correctNull(rs5.getString("loan_recmdamt")));//19
					
				}
				else{
					arrRow.add("");//19
					
				}
				
				
				
				//---------------For Collateral Sec--------------
				
				strQuery = SQLParser.getSqlQuery("Appraisalgetcollateral^"+appno);
				if(rs5!=null)
				rs5.close();	
				rs5=DBUtils.executeQuery(strQuery);
				
				ArrayList arrColf = new ArrayList();
				
				
				while(rs5.next())
				{
					 arrColf = new ArrayList();
						
					arrColf.add(correctNull(rs5.getString("home_applnt")));
					arrColf.add(correctNull(rs5.getString("home_titleadd1")));
					arrColf.add(correctNull(rs5.getString("home_titleadd2")));
					arrColf.add(correctNull(rs5.getString("home_titlecity")));
					arrColf.add(correctNull(rs5.getString("home_titlestate")));
					arrColf.add(correctNull(rs5.getString("home_titlezip")));
					arrColf.add(correctNull(rs5.getString("home_propname")));
					arrColf.add(correctNull(rs5.getString("home_appval")));
					
					
					arrRow.add(arrColf);
				}
				arrCol.add(arrRow);
			}
			hshRecord.put("MonthlyStatus",arrCol);
			hshRecord.put("MMRyear",year);
			hshRecord.put("MMRmonth",month);
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		
		 finally
	        {
	            try
	            {
	                if(rs != null)
	                    rs.close();
					if(rs1 != null)
						rs1.close();
					if(rs2 != null)
						rs2.close();
					if(rs4 != null)
						rs4.close();
					if(rs5 != null)
						rs5.close();
	                
	            }
	            catch(Exception exception2)
	            {
	                throw new EJBException("Error closing the connection " + exception2.getMessage());
	            }
	        }
    	
    	return hshRecord;
    }
    
    public HashMap gettenlacsStatement(HashMap hashtable)   
    {
    	HashMap hshRecord=new HashMap();
    	HashMap hshTemp=new HashMap();
    	HashMap hshRiskRating=new HashMap();
    	String strOrgCode="";
    	ResultSet rs = null;
    	ResultSet rs1 = null;
    	ResultSet rs2 = null;
    	ResultSet rs3 = null;
    	ResultSet rs4 = null;
    	ResultSet rs5 = null;
    	
    	String strQuery="";
    	String appno,strCount="";
    	String strApplName="";
    	String loan_recmdamt="";
    	int count=0;
    	int mon=1;
    	int year1=1;
    	String strAppNo="";
    	ArrayList arrCol=new ArrayList();
    	ArrayList arrVecCollat=new ArrayList();
    	
    	try {
    		strOrgCode=Helper.correctNull((String)hashtable.get("strOrgCode"));
    		
    		String selmonth=correctNull((String)hashtable.get("selmonth"));
			String selyear=correctNull((String)hashtable.get("selyear"));
			String year=selyear;
			String month=selmonth;
			mon=mon+Integer.parseInt(selmonth);
			
			if(mon==13)
			{
				mon=1;
				year1=year1+Integer.parseInt(year);
				
			}
			else
			{
				year1=Integer.parseInt(year);
			}
			String startDate="01/"+month+"/"+year;
			String endDate="01/"+mon+"/"+year1;
									
			rs=DBUtils.executeLAPSQuery("getApprovedAppl2^"+strOrgCode+"^"+startDate+"^"+endDate);
			while(rs.next()){
				ArrayList arrRow=new ArrayList();
				appno=Helper.correctNull(rs.getString("app_no"));
				loan_recmdamt="0.00";
				strQuery = SQLParser.getSqlQuery("getApprovedLoanDetails2^"+appno);
				if(rs3 != null)
				rs3.close();
				rs3 = DBUtils.executeQuery(strQuery);
				
				if(rs3.next())
				{   
					arrRow.add(correctNull(rs3.getString("loan_modintrate")));//3
					arrRow.add(correctNull(rs3.getString("loan_recmdamt")));//4
					loan_recmdamt=Helper.correctNull((String)rs3.getString("loan_recmdamt"));
				  arrRow.add(Helper.CLOBToString(rs3.getClob("loan_purposeofloan")));//5
								
					
				
				}
				else{
					arrRow.add("");//3
					arrRow.add("0.00");//4
					arrRow.add("");//5
				}
				if((Float.parseFloat(loan_recmdamt))<=1000000.00){
					strApplName="";
					
					count=count+1;
					strCount=Integer.toString(count);
					arrRow.add(strCount);	
				strQuery=SQLParser.getSqlQuery("selappraisalsanc^"+appno);
				rs4=DBUtils.executeQuery(strQuery);
				if(rs4.next())
				{
					 strAppNo=Helper.correctNull(rs4.getString("app_no"));
					 strApplName=Helper.correctNull(rs4.getString("applname"));
				}
				
				
				arrRow.add(strApplName);
				
				
				arrRow.add(Helper.correctNull(rs.getString("app_processdate")));//2
				
				strQuery = SQLParser.getSqlQuery("selpropertydetails^"+appno);
				
					if(rs1!=null)
						rs1.close();
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{	
					arrRow.add((String)correctNull(rs1.getString("prop_add1")));//6
					arrRow.add((String)correctNull(rs1.getString("prop_add2")));//7
					arrRow.add((String)correctNull(rs1.getString("prop_city")));//8
					arrRow.add((String)correctNull(rs1.getString("prop_state")));//9
					arrRow.add((String)correctNull(rs1.getString("prop_pin")));//10
					arrRow.add((String)correctNull(rs1.getString("prop_name")));//11
				}
				else{
					arrRow.add("");//6
					arrRow.add("");//7
					arrRow.add("");//8
					arrRow.add("");//9
					arrRow.add("");//10
					arrRow.add("");//11
				}
				strQuery = SQLParser.getSqlQuery("Appraisalgetcollateral^"+appno);
				if(rs2!=null)
					rs2.close();
				rs2=DBUtils.executeQuery(strQuery);
				arrVecCollat=new ArrayList();
				while(rs2.next())
				{
					ArrayList arrColCollat = new ArrayList();
					arrColCollat.add(correctNull(rs2.getString("home_applnt")));
					arrColCollat.add(correctNull(rs2.getString("home_titleadd1")));
					arrColCollat.add(correctNull(rs2.getString("home_titleadd2")));
					arrColCollat.add(correctNull(rs2.getString("home_titlecity")));
					arrColCollat.add(correctNull(rs2.getString("home_titlestate")));
					arrColCollat.add(correctNull(rs2.getString("home_titlezip")));
					arrColCollat.add(correctNull(rs2.getString("home_propname")));
					arrColCollat.add(correctNull(rs2.getString("home_appval")));
					
					
					arrVecCollat.add(arrColCollat);

			}
				arrRow.add(arrVecCollat);//12
				
				hshTemp.put("appno",appno);
				
				hshRiskRating = new HashMap();

				hshRiskRating=(HashMap)EJBInvoker.executeStateLess("perrskana",hshTemp,"getData");
				String strScore = (String)hshRiskRating.get("totscore");
				String strGrade = (String)hshRiskRating.get("cutoffdesc");
				
				arrRow.add("Score "+strScore+" / Grade"+strGrade);//13
				strQuery = SQLParser.getSqlQuery("appraisalprint1^"+appno);
				if(rs5!=null)
					rs5.close();
				rs5=DBUtils.executeQuery(strQuery);
				if(rs5.next()){
					arrRow.add(correctNull(rs5.getString("auto_model")));//15
					arrRow.add(correctNull(rs5.getString("auto_make")));//16
					arrRow.add(correctNull(rs5.getString("auto_regno")));//17
					
				}
				else{
					arrRow.add("");//15
					arrRow.add("");//16
					arrRow.add("");//17
					
				}
				
				
				//-------------For Designation
				strQuery = SQLParser.getSqlQuery("selpernature^"+appno);
				if(rs5!=null)
					rs5.close();
				rs5=DBUtils.executeQuery(strQuery);
				if(rs5.next()){
					arrRow.add(correctNull(rs5.getString("perapp_employment")));//17
					
				}
				else{
					arrRow.add("");//17
					
				}
				
				//--------------For Facility
				strQuery = SQLParser.getSqlQuery("selappfacility^"+appno);
				if(rs5!=null)
					rs5.close();
				rs5=DBUtils.executeQuery(strQuery);
				if(rs5.next()){
					arrRow.add(correctNull(rs5.getString("appsanc_facility")));//18
					
				}
				else{
					arrRow.add("");//18
					
				}
				
				//--------------For Limit
				strQuery = SQLParser.getSqlQuery("selappraisalsanc^"+appno);
				if(rs5!=null)
					rs5.close();
				rs5=DBUtils.executeQuery(strQuery);
				if(rs5.next()){
					arrRow.add(correctNull(rs5.getString("loan_recmdamt")));//19
					
				}
				else
				{
					arrRow.add("0.00");	
				}
				
				
				//---------------For Collateral Sec--------------
				
				strQuery = SQLParser.getSqlQuery("Appraisalgetcollateral^"+appno);
				if(rs5!=null)
				rs5.close();	
				rs5=DBUtils.executeQuery(strQuery);
				ArrayList arrColf = new ArrayList();
				while(rs5.next())
				{
					 arrColf = new ArrayList();
						
					arrColf.add(correctNull(rs5.getString("home_applnt")));
					arrColf.add(correctNull(rs5.getString("home_titleadd1")));
					arrColf.add(correctNull(rs5.getString("home_titleadd2")));
					arrColf.add(correctNull(rs5.getString("home_titlecity")));
					arrColf.add(correctNull(rs5.getString("home_titlestate")));
					arrColf.add(correctNull(rs5.getString("home_titlezip")));
					arrColf.add(correctNull(rs5.getString("home_propname")));
					arrColf.add(correctNull(rs5.getString("home_appval")));
					
					
					arrRow.add(arrColf);
				}
				
				}
				arrRow.add(strAppNo);
				arrCol.add(arrRow);
				
			}
			hshRecord.put("MonthlyStatus",arrCol);
			hshRecord.put("loan_recmdamt",loan_recmdamt);
			hshRecord.put("MMRyear",year);
			hshRecord.put("MMRmonth",month);
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		
		 finally
	        {
	            try
	            {
	                if(rs != null)
	                    rs.close();
					if(rs1 != null)
						rs1.close();
					if(rs2 != null)
						rs2.close();
					if(rs4 != null)
						rs4.close();
					if(rs5 != null)
						rs5.close();
	            }
	            catch(Exception exception2)
	            {
	                throw new EJBException("Error closing the connection " + exception2.getMessage());
	            }
	        }
    	
    	return hshRecord;
    }
    public HashMap gettenlacsStatement1(HashMap hashtable)
    
    {
    	HashMap hshRecord=new HashMap();
    	HashMap hshTemp=new HashMap();
    	HashMap hshRiskRating=new HashMap();
    	String strOrgCode="";
    	ResultSet rs = null;
    	ResultSet rs1 = null;
    	ResultSet rs2 = null;
    	ResultSet rs3 = null;
    	ResultSet rs4 = null;
    	ResultSet rs5 = null;
    	
    	String strQuery="";
    	String appno,strCount="";
    	String strApplName="";
    	String loan_recmdamt="";
    	int count=0;
    	int mon=1;
    	int year1=1;
    	String strAppNo="";
    	ArrayList arrCol=new ArrayList();
    	ArrayList arrVecCollat=new ArrayList();
    	
    	try {
    		strOrgCode=Helper.correctNull((String)hashtable.get("strOrgCode"));
    		String selmonth=correctNull((String)hashtable.get("selmonth"));
			String selyear=correctNull((String)hashtable.get("selyear"));
			String year=selyear;
			String month=selmonth;
			mon=mon+Integer.parseInt(selmonth);
			
			if(mon==13)
			{
				mon=1;
				year1=year1+Integer.parseInt(year);
				
			}
			else
			{
				year1=Integer.parseInt(year);
			}
			
			String startDate="01/"+month+"/"+year;
			String endDate="01/"+mon+"/"+year1;
			rs=DBUtils.executeLAPSQuery("getApprovedAppl1^"+strOrgCode+"^"+startDate+"^"+endDate);
			while(rs.next()){
				ArrayList arrRow=new ArrayList();
				appno=Helper.correctNull(rs.getString("app_no"));
				loan_recmdamt="0.00";
				strQuery = SQLParser.getSqlQuery("getApprovedLoanDetails1^"+appno);
				if(rs3 != null)
				rs3.close();
				rs3 = DBUtils.executeQuery(strQuery);
				
				if(rs3.next())
				{   
					arrRow.add(correctNull(rs3.getString("loan_modintrate")));//3
					arrRow.add(correctNull(rs3.getString("loan_recmdamt")));//4
					loan_recmdamt=Helper.correctNull((String)rs3.getString("loan_recmdamt"));
					arrRow.add(Helper.CLOBToString(rs3.getClob("loan_purposeofloan")));//5
								
				
				}
				else{
					arrRow.add("0.00");//3
					arrRow.add("0.00");//4
					arrRow.add("nil");//5
				}
				if((Float.parseFloat(loan_recmdamt))>=1000000.00){
				 strApplName="";
				 
				 count=count+1;
					strCount=Integer.toString(count);
					arrRow.add(strCount);
				strQuery=SQLParser.getSqlQuery("selappraisalsanc^"+appno);
				rs4=DBUtils.executeQuery(strQuery);
				if(rs4.next())
				{
					 strApplName=Helper.correctNull(rs4.getString("applname"));
					 strAppNo=Helper.correctNull(rs4.getString("app_no"));
				}
				
				arrRow.add(strApplName);
							
				
				arrRow.add(Helper.correctNull(rs.getString("app_processdate")));//2
				strQuery = SQLParser.getSqlQuery("selpropertydetails^"+appno);
				
					if(rs1!=null)
						rs1.close();
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{	
					arrRow.add((String)correctNull(rs1.getString("prop_add1")));//6
					arrRow.add((String)correctNull(rs1.getString("prop_add2")));//7
					arrRow.add((String)correctNull(rs1.getString("prop_city")));//8
					arrRow.add((String)correctNull(rs1.getString("prop_state")));//9
					arrRow.add((String)correctNull(rs1.getString("prop_pin")));//10
					arrRow.add((String)correctNull(rs1.getString("prop_name")));//11
				}
				else{
					arrRow.add("");//6
					arrRow.add("");//7
					arrRow.add("");//8
					arrRow.add("");//9
					arrRow.add("");//10
					arrRow.add("");//11
				}

				strQuery = SQLParser.getSqlQuery("Appraisalgetcollateral^"+appno);
				if(rs2!=null)
					rs2.close();
				rs2=DBUtils.executeQuery(strQuery);
				arrVecCollat=new ArrayList();
				while(rs2.next())
				{
					ArrayList arrColCollat = new ArrayList();
					arrColCollat.add(correctNull(rs2.getString("home_applnt")));
					arrColCollat.add(correctNull(rs2.getString("home_titleadd1")));
					arrColCollat.add(correctNull(rs2.getString("home_titleadd2")));
					arrColCollat.add(correctNull(rs2.getString("home_titlecity")));
					arrColCollat.add(correctNull(rs2.getString("home_titlestate")));
					arrColCollat.add(correctNull(rs2.getString("home_titlezip")));
					arrColCollat.add(correctNull(rs2.getString("home_propname")));
					arrColCollat.add(correctNull(rs2.getString("home_appval")));
					
					
					arrVecCollat.add(arrColCollat);

			}
				arrRow.add(arrVecCollat);//12
				
				hshTemp.put("appno",appno);
				
				hshRiskRating = new HashMap();

				hshRiskRating=(HashMap)EJBInvoker.executeStateLess("perrskana",hshTemp,"getData");
				String strScore = (String)hshRiskRating.get("totscore");
				String strGrade = (String)hshRiskRating.get("cutoffdesc");
				
				arrRow.add("Score "+strScore+" / Grade"+strGrade);//13
				strQuery = SQLParser.getSqlQuery("appraisalprint1^"+appno);
				if(rs5!=null)
					rs5.close();
				rs5=DBUtils.executeQuery(strQuery);
				if(rs5.next()){
					arrRow.add(correctNull(rs5.getString("auto_model")));//15
					arrRow.add(correctNull(rs5.getString("auto_make")));//16
					arrRow.add(correctNull(rs5.getString("auto_regno")));//17
					
				}
				else{
					arrRow.add("");//15
					arrRow.add("");//16
					arrRow.add("");//17
					
				}
				
				
				//-------------For Designation
				strQuery = SQLParser.getSqlQuery("selpernature^"+appno);
				if(rs5!=null)
					rs5.close();
				rs5=DBUtils.executeQuery(strQuery);
				if(rs5.next()){
					arrRow.add(correctNull(rs5.getString("perapp_employment")));//17
					
				}
				else{
					arrRow.add("");//17
					
				}
				
				//--------------For Facility
				strQuery = SQLParser.getSqlQuery("selappfacility^"+appno);
				if(rs5!=null)
					rs5.close();
				rs5=DBUtils.executeQuery(strQuery);
				if(rs5.next()){
					arrRow.add(correctNull(rs5.getString("appsanc_facility")));//18
					
				}
				else{
					arrRow.add("");//18
					
				}
				
				//--------------For Limit
				strQuery = SQLParser.getSqlQuery("selappraisalsanc^"+appno);
				if(rs5!=null)
					rs5.close();
				rs5=DBUtils.executeQuery(strQuery);
				if(rs5.next())
				{
					arrRow.add(correctNull(rs5.getString("loan_recmdamt")));//19
					
				}
				else
				{
					arrRow.add("0.00");	
				}
				
				arrRow.add(strAppNo);
				//---------------For Collateral Sec--------------
				
				strQuery = SQLParser.getSqlQuery("Appraisalgetcollateral^"+appno);
				if(rs5!=null)
				rs5.close();	
				rs5=DBUtils.executeQuery(strQuery);
				ArrayList arrColf = new ArrayList();
				
				
				while(rs5.next())
				{
					 arrColf = new ArrayList();
						
					arrColf.add(correctNull(rs5.getString("home_applnt")));
					arrColf.add(correctNull(rs5.getString("home_titleadd1")));
					arrColf.add(correctNull(rs5.getString("home_titleadd2")));
					arrColf.add(correctNull(rs5.getString("home_titlecity")));
					arrColf.add(correctNull(rs5.getString("home_titlestate")));
					arrColf.add(correctNull(rs5.getString("home_titlezip")));
					arrColf.add(correctNull(rs5.getString("home_propname")));
					arrColf.add(correctNull(rs5.getString("home_appval")));
					if(arrColf==null)
					{
						arrRow.add("nil");	
					}
										
					arrRow.add(arrColf);
					
					
				}
				
			}
					
				arrCol.add(arrRow);

			}
			hshRecord.put("MonthlyStatus",arrCol);
			hshRecord.put("loan_recmdamt",loan_recmdamt);
			hshRecord.put("MMRyear",year);
			hshRecord.put("MMRmonth",month);
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		
		 finally
	        {
	            try
	            {
	                if(rs != null)
	                    rs.close();
					if(rs1 != null)
						rs1.close();
					if(rs2 != null)
						rs2.close();
					if(rs4 != null)
						rs4.close();
					if(rs5 != null)
						rs5.close();
	            }
	            catch(Exception exception2)
	            {
	                throw new EJBException("Error closing the connection " + exception2.getMessage());
	            }
	        }
    	
    	return hshRecord;
    }

}
