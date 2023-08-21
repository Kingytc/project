/*package com.sai.laps.ejb.eduparticulars;
 
import java.sql.ResultSet;
 
import java.util.ArrayList;
import java.util.HashMap;
import javax.ejb.EJBException;
import com.sai.laps.helper.*;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.SQLParser;

public class eduparticularsBean extends BeanAdapter
{
	public HashMap getData(HashMap hshRequestValues) 
	{
		 
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		try
		{
			 
			String appno=correctNull((String)hshRequestValues.get("appno"));
			rs=DBUtils.executeLAPSQuery("eduparticularssel^"+appno);
			
			if (rs.next())
			{
				hshRecord = new HashMap();
				hshRecord.put("eduloan_appno",correctNull(rs.getString("eduloan_appno")));
				hshRecord.put("edu_coursename",correctNull(rs.getString("edu_coursename")));
				hshRecord.put("edu_course_approved",correctNull(rs.getString("edu_course_approved")));
				hshRecord.put("edu_course_approvedby",correctNull(rs.getString("edu_course_approvedby")));
				hshRecord.put("edu_univ_name",correctNull(rs.getString("edu_univ_name")));
				hshRecord.put("edu_univ_approved",correctNull(rs.getString("edu_univ_approved")));
				hshRecord.put("edu_univ_approvedby",correctNull(rs.getString("edu_univ_approvedby")));
				hshRecord.put("edu_univ_addr",correctNull(rs.getString("edu_univ_addr")));
				hshRecord.put("edu_duration",correctNull(rs.getString("edu_duration")));
				hshRecord.put("edu_partfull",correctNull(rs.getString("edu_partfull")));
				hshRecord.put("edu_qual_proposed",correctNull(rs.getString("edu_qual_proposed")));
				hshRecord.put("edu_commencedate",correctNull(rs.getString("edu_commencedate")));
				hshRecord.put("edu_mode_secure",correctNull(rs.getString("edu_mode_secure")));
				hshRecord.put("edu_univ_situ_domicile",correctNull(rs.getString("edu_univ_situ_domicile")));
				hshRecord.put("edu_comp_stay_hostel",correctNull(rs.getString("edu_comp_stay_hostel")));
				hshRecord.put("edu_comments1",correctNull(rs.getString("edu_comments1")));
				hshRecord.put("edu_comments2",correctNull(rs.getString("edu_comments2")));
				hshRecord.put("edu_comments3",correctNull(rs.getString("edu_comments3")));
				hshRecord.put("edu_comments4",correctNull(rs.getString("edu_comments4")));
				hshRecord.put("edu_studies_in",correctNull(rs.getString("edu_studies_in")));
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getDataeduparticulars "+ce.toString());
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

	public void updateData(HashMap hsh) 
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();
		ArrayList arr = new ArrayList();
		ArrayList arrVal = new ArrayList();
		 
		ResultSet rs=null;
		String val="";
		String appno="";
		
		try
		{	 		
			val=correctNull((String)hsh.get("hidAction"));
			appno=correctNull((String)hsh.get("appno"));			
			hshquery.put("strQueryId","eduparticularsdel");
			arr.add(appno);
			hshquery.put("arrValues",arr);
			hshqueryval.put("size","1");
			hshqueryval.put("1",hshquery);
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			
			if (val.equals("update"))
			{
				arrVal = new ArrayList();
				hshquery.put("strQueryId","eduparticularsins");
				arrVal.add(Helper.correctNull((String)hsh.get("appno")));
				arrVal.add(Helper.correctNull((String)hsh.get("txtnameofcourse")));
				arrVal.add(Helper.correctNull((String)hsh.get("cboapprovedcourse")));
				arrVal.add(Helper.correctNull((String)hsh.get("txtcourseapprby")));
				arrVal.add(Helper.correctNull((String)hsh.get("txtnameofunins")));
				arrVal.add(Helper.correctNull((String)hsh.get("cboapprovedinsti")));
				arrVal.add(Helper.correctNull((String)hsh.get("txtinstitutionapprby")));
				arrVal.add(Helper.correctNull((String)hsh.get("textunivaddr")));
				arrVal.add(Helper.correctNull((String)hsh.get("cbocoursetype")));
				arrVal.add(Helper.correctNull((String)hsh.get("cboqualproposed")));
				arrVal.add(Helper.correctNull((String)hsh.get("txtdurofcourse")));
				arrVal.add(Helper.correctNull((String)hsh.get("txtcommencement_date")));
				arrVal.add(Helper.correctNull((String)hsh.get("cbomodeofsecure")));
				arrVal.add(Helper.correctNull((String)hsh.get("cboinstdomicile")));
				arrVal.add(Helper.correctNull((String)hsh.get("cbocomphostel")));
				arrVal.add(Helper.correctNull((String)hsh.get("textcomments1")));
				arrVal.add(Helper.correctNull((String)hsh.get("textcomments2")));
				arrVal.add(Helper.correctNull((String)hsh.get("textcomments3")));
				arrVal.add(Helper.correctNull((String)hsh.get("textcomments4")));
				arrVal.add(Helper.correctNull((String)hsh.get("cbostudies")));
				hshquery.put("arrValues",arrVal);
				hshqueryval.put("size","1");
				hshqueryval.put("1",hshquery);						
			}	
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");			
		}
		catch (Exception e)
		{
		throw new EJBException("Error Occured  "+e.getMessage());
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
}*/
package com.sai.laps.ejb.eduparticulars;
 
import java.sql.ResultSet;
 
import java.util.ArrayList;
import java.util.HashMap;
import java.util.StringTokenizer;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.ejb.edudetails.EdudetailsBean;
import com.sai.laps.helper.*;

@Stateless(name = "eduparticularsBean", mappedName = "eduparticularsHome")
@Remote (eduparticularsRemote.class)
public class eduparticularsBean extends BeanAdapter
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(eduparticularsBean.class);

	public HashMap getData(HashMap hshRequestValues) 
	{
		 
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String recordflag="N";
		try
		{
			 
			String appno=correctNull((String)hshRequestValues.get("appno"));
			strQuery=SQLParser.getSqlQuery("eduparticularssel^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			
			if (rs.next())
			{
				hshRecord = new HashMap();
				hshRecord.put("eduloan_appno",correctNull(rs.getString("eduloan_appno")));
				hshRecord.put("edu_coursename",correctNull(rs.getString("edu_coursename")));
				hshRecord.put("edu_course_approved",correctNull(rs.getString("edu_course_approved")));
				hshRecord.put("edu_course_approvedby",correctNull(rs.getString("edu_course_approvedby")));
				hshRecord.put("edu_univ_name",correctNull(rs.getString("edu_univ_name")));
				hshRecord.put("edu_univ_approved",correctNull(rs.getString("edu_univ_approved")));
				hshRecord.put("edu_univ_approvedby",correctNull(rs.getString("edu_univ_approvedby")));
				hshRecord.put("edu_univ_addr",correctNull(rs.getString("edu_univ_addr")));
				hshRecord.put("edu_partfull",correctNull(rs.getString("edu_partfull")));
				hshRecord.put("edu_qual_proposed",correctNull(rs.getString("edu_qual_proposed")));
				hshRecord.put("edu_commencedate",correctNull(rs.getString("edu_commencedate")));
				hshRecord.put("edu_mode_secure",correctNull(rs.getString("edu_mode_secure")));
				hshRecord.put("edu_univ_situ_domicile",correctNull(rs.getString("edu_univ_situ_domicile")));
				hshRecord.put("edu_comp_stay_hostel",correctNull(rs.getString("edu_comp_stay_hostel")));
				hshRecord.put("edu_comments1",correctNull(rs.getString("edu_comments1")));
				hshRecord.put("edu_comments2",correctNull(rs.getString("edu_comments2")));
				hshRecord.put("edu_comments3",correctNull(rs.getString("edu_comments3")));
				hshRecord.put("edu_comments4",correctNull(rs.getString("edu_comments4")));
				hshRecord.put("edu_studies_in",correctNull(rs.getString("edu_studies_in")));
				hshRecord.put("expected_income",correctNull(rs.getString("expected_income")));
				hshRecord.put("EDU_MERITORIOUS",correctNull(rs.getString("EDU_MERITORIOUS")));
				hshRecord.put("EDU_QUALIFYINGEXA",correctNull(rs.getString("EDU_QUALIFYINGEXA")));
				hshRecord.put("edu_typeofcourse",correctNull(rs.getString("edu_typeofcourse")));
				hshRecord.put("edu_schemetype",correctNull(rs.getString("edu_schemetype")));
				hshRecord.put("EDU_OTHR_SUBSIDY",correctNull(rs.getString("EDU_OTHR_SUBSIDY")));
				hshRecord.put("EDU_INC_CERT",correctNull(rs.getString("EDU_INC_CERT")));
				hshRecord.put("EDU_INC_CERT_NUMBER",correctNull(rs.getString("EDU_INC_CERT_NUMBER")));
				hshRecord.put("EDU_INC_CERT_DATE",correctNull(rs.getString("EDU_INC_CERT_DATE")));
				hshRecord.put("EDU_INC_CERT_AUTHORITY",correctNull(rs.getString("EDU_INC_CERT_AUTHORITY")));
				hshRecord.put("EDU_COURSE_EXTEND",correctNull(rs.getString("EDU_COURSE_EXTEND")));
				hshRecord.put("EDU_COURSE_STRTDATE",correctNull(rs.getString("EDU_COURSE_STRTDATE")));
				
				String duration=correctNull(rs.getString("edu_duration"));
				StringTokenizer tknz = new StringTokenizer(duration,"~");
				hshRecord.put("edu_durationyrs",((String) tknz.nextElement()).trim());
				hshRecord.put("edu_durationmon",((String) tknz.nextElement()).trim());
				
				recordflag="Y";
			}
			hshRecord.put("recordflag",recordflag);
			
			if(rs!=null)
			{
				rs.close();
			}
			String strPrdCode= Helper.correctNull((String)hshRequestValues.get("prdcode"));
			strQuery = SQLParser.getSqlQuery("sel_products_edu^"+strPrdCode);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("splscheme",Helper.correctNull((String)rs.getString("prd_homeplus")));
			}
			if(rs!=null)
			{
				rs.close();
			}
			
			strQuery = SQLParser.getSqlQuery("sel_products_education^"+strPrdCode);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("prd_purpose",Helper.correctNull((String)rs.getString("prd_purpose")));
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getDataeduparticulars "+ce.toString());
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

	public void updateData(HashMap hsh) 
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();
		ArrayList arr = new ArrayList();
		ArrayList arrVal = new ArrayList();
		 
		ResultSet rs=null;
		String strAction="";
		String appno="";
		try
		{	 		
			strAction=correctNull((String)hsh.get("hidAction"));
			appno=correctNull((String)hsh.get("appno"));			
			hshquery.put("strQueryId","eduparticularsdel");
			arr.add(appno);
			hshquery.put("arrValues",arr);
			hshqueryval.put("size","1");
			hshqueryval.put("1",hshquery);
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			
			
			if (strAction.equals("update"))
			{
				arrVal = new ArrayList();
				hshquery.put("strQueryId","eduparticularsins");
				arrVal.add(Helper.correctNull((String)hsh.get("appno")));//appno
				arrVal.add(Helper.correctNull((String)hsh.get("txtnameofcourse")));// name of the 
				arrVal.add(Helper.correctNull((String)hsh.get("cboapprovedcourse")));
				arrVal.add(Helper.correctNull((String)hsh.get("txtcourseapprby")));
				arrVal.add(Helper.correctNull((String)hsh.get("txtnameofunins")));
				arrVal.add(Helper.correctNull((String)hsh.get("cboapprovedinsti")));
				arrVal.add(Helper.correctNull((String)hsh.get("txtinstitutionapprby")));
				arrVal.add(Helper.correctNull((String)hsh.get("textunivaddr")));
				arrVal.add(Helper.correctNull((String)hsh.get("cboqualproposed")));
				arrVal.add(Helper.correctNull((String)hsh.get("cbocoursetype")));
				String coursedurationyrs=Helper.correctNull((String)hsh.get("txtdurofcourseyr"));
				if(coursedurationyrs.equalsIgnoreCase(""))
					coursedurationyrs="0";
				String courseduration=Helper.correctNull((String)hsh.get("txtdurofcoursemon"));
				if(courseduration.equalsIgnoreCase(""))
					courseduration="0";
				courseduration=coursedurationyrs+"~"+courseduration;
				arrVal.add(courseduration);
				arrVal.add(Helper.correctNull((String)hsh.get("txtcommencement_date")));
				arrVal.add(Helper.correctNull((String)hsh.get("cbomodeofsecure")));
				arrVal.add(Helper.correctNull((String)hsh.get("cboinstdomicile")));
				arrVal.add(Helper.correctNull((String)hsh.get("cbocomphostel")));
				arrVal.add(Helper.correctNull((String)hsh.get("textcomments1")));
				arrVal.add(Helper.correctNull((String)hsh.get("textcomments2")));
				arrVal.add(Helper.correctNull((String)hsh.get("textcomments3")));
				arrVal.add(Helper.correctNull((String)hsh.get("textcomments4")));
				arrVal.add(Helper.correctNull((String)hsh.get("cbostudies")));
				/*added by Madhura*/
				//start
				arrVal.add(Helper.correctNull((String)hsh.get("expected_income")));
				arrVal.add(Helper.correctNull((String)hsh.get("sel_studentmeri")));//added by ganesan for Is the Student Meritorious 
				arrVal.add(Helper.correctNull((String)hsh.get("txt_markseq")));////added by ganesan for % of marks Secured in the Qualifying Examination  
				//end
				arrVal.add(Helper.correctNull((String)hsh.get("seltypeofcourse")));
				arrVal.add(Helper.correctNull((String)hsh.get("selscheme")));
				arrVal.add(Helper.correctNull((String)hsh.get("sel_othersubsidy")));
				arrVal.add(Helper.correctNull((String)hsh.get("sel_inc_cert")));
				arrVal.add(Helper.correctNull((String)hsh.get("txt_inc_cert_number")));
				arrVal.add(Helper.correctNull((String)hsh.get("txt_inc_cert_date")));
				arrVal.add(Helper.correctNull((String)hsh.get("sel_inc_cert_authority")));
				arrVal.add(Helper.correctNull((String)hsh.get("txtdurofcourse_extend")));
				arrVal.add(Helper.correctNull((String)hsh.get("txt_crse_strt_date")));
				hshquery.put("arrValues",arrVal);
				hshqueryval.put("size","1");
				hshqueryval.put("1",hshquery);						
			}	
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");			
			
//			for Entering the values into auditrial
			
			StringBuilder sbActionData = new StringBuilder();
			if((strAction.equalsIgnoreCase("update"))||(strAction.equalsIgnoreCase("insert")))
			{
				sbActionData.append("Name of course=").append(correctNull((String)hsh.get("txtnameofcourse"))).
				append(" ~Is it an approved course =").append(SetupParams.getSetupParams("Education",correctNull((String)hsh.get("cboapprovedcourse"))));
				if(SetupParams.getSetupParams("Education",correctNull((String)hsh.get("cboapprovedcourse"))).equalsIgnoreCase("Yes"))
				{
					sbActionData.append(" ~course Recognized by=").append(correctNull((String)hsh.get("txtcourseapprby")));
				}
				sbActionData.append("~Name of University/Institution=").append(correctNull((String)hsh.get("txtnameofunins"))).
				append(" ~Is it a Recognized University/Institution=").append(SetupParams.getSetupParams("Education",correctNull((String)hsh.get("cboapprovedinsti"))));
				if(SetupParams.getSetupParams("Education",correctNull((String)hsh.get("cboapprovedinsti"))).equalsIgnoreCase("Yes"))
				{
					sbActionData.append("~University/Institution Recognized by=").append(correctNull((String)hsh.get("txtinstitutionapprby")));
				}
				sbActionData.append(" ~Address of the University/Institution=").append(correctNull((String)hsh.get("textunivaddr"))).
				append(" ~Type of Course=").append(SetupParams.getSetupParams("Course",correctNull((String)hsh.get("cbocoursetype")))).
				append(" ~Edu. Qualification Proposed=").append(SetupParams.getSetupParams("Qualification",correctNull((String)hsh.get("cboqualproposed")))).
				append(" ~Duration of course in Years=").append(correctNull((String)hsh.get("txtdurofcourseyr"))).
				append(" ~Duration of course in Months=").append(correctNull((String)hsh.get("txtdurofcoursemon"))).
				append(" ~Date of commencement of the course=").append(correctNull((String)hsh.get("txtcommencement_date"))).
				append(" ~Mode of securing admission=").append(SetupParams.getSetupParams("admission",correctNull((String)hsh.get("cbomodeofsecure")))).
				append(" ~Studies=").append(SetupParams.getSetupParams("Studies",correctNull((String)hsh.get("cbostudies")))).
				append(" ~Is the institution situated at the place of domicile?=").append(SetupParams.getSetupParams("Education",correctNull((String)hsh.get("cboinstdomicile")))).
				append(" ~Expected Income per month after completion of course=").append(correctNull((String)hsh.get("expected_income"))).
				append(" ~Is it compulsory to stay in hostel?=").append(SetupParams.getSetupParams("Education",correctNull((String)hsh.get("cbocomphostel")))).
				append(" ~Course Specailization=").append(correctNull((String)hsh.get("seltypeofcourse")));
				//append("~Particular of admission letter=").append(correctNull((String)hsh.get("textcomments1"))).
				//append("~Other information in case of studies abroad=").append(correctNull((String)hsh.get("textcomments2"))).
				//append("~Insurance Details=").append(correctNull((String)hsh.get("textcomments3"))).
				//append("~Other Details=").append(correctNull((String)hsh.get("textcomments4")));
				if(correctNull((String)hsh.get("hidRecordflag")).equalsIgnoreCase("N"))
				{
					hsh.put("hidAction","insert");
				}	

				
			}				
			AuditTrial.auditLog(hsh,"44",appno,sbActionData.toString());
		}
		catch (Exception e)
		{
			throw new EJBException("Error Occured  "+e.getMessage());
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
}