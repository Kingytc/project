package com.sai.laps.ejb.dscr;

import java.sql.ResultSet;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "DscrBean", mappedName = "DscrHome")
@Remote (DscrRemote.class)

public class DscrBean extends BeanAdapter{
	static Logger log=Logger.getLogger(DscrBean.class);
	private static final long serialVersionUID = 1L;
	String strIsQisFormula = null;
    String strColName = null;
    String strFrom = null;
    String strTo = null;
    String strFormulaApply = null;
    NumberFormat nf=NumberFormat.getInstance();
	public DscrBean()
	{
		 	strIsQisFormula = "";
	        strColName = "";
	        strFrom = "";
	        strTo = "";
	        strFormulaApply = "";
	        nf.setGroupingUsed(false);
	    	nf.setMaximumFractionDigits(2);
	    	nf.setMinimumFractionDigits(2);
	        
	}
	public HashMap getDataForDSCR(HashMap hshRequestValues) 
	{		
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs3 = null;
		ResultSet rs4 = null;
		ResultSet rs10 =null;
		HashMap hshValues=null;
		String strQuery="",strValue="";		
		int str=0,tabcnt=0,l=0;		
		String sumaudit="";
		String sumunaudit="";
		String sumestimated="";
		String sumprojection="";
		String sel_divID="";
		String pagetab="";
		String base_year="";
		String strAction="";
		String fintype = null;
	try
	{	
		String hidUpload=correctNull((String)hshRequestValues.get("hidUpload"));
		strAction=correctNull((String)hshRequestValues.get("hidAction"));
		//--------This is Existing Finia-----
		strValue=correctNull((String)hshRequestValues.get("appno"));
		//Added by Kishan
		String strFinID = "0";
		String cma="0",strValuesin="";
		strQuery = SQLParser.getSqlQuery("sel_financeid^"+strValue);
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strFinID=Helper.correctNull((String)rs.getString("DEMO_FINSTANDARD"));
			if(!strFinID.equals("")) {
				strQuery = SQLParser.getSqlQuery("fin_cmano_select^"+strFinID);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next()) {
					cma = Helper.correctNull((String)rs.getString("FIN_CMANO"));
					strValuesin = Helper.correctNull((String) rs.getString("fin_valuesarein"));
				}
			}
		}
		sel_divID=correctNull((String)hshRequestValues.get("sel_divID"));
		if(sel_divID.equalsIgnoreCase(""))
		{
			sel_divID="0";
		}
		
		String page = correctNull((String)hshRequestValues.get("pageval"));
		pagetab=Helper.correctNull(page);
		
		rs=null;		

		
		hshValues = new HashMap();
		ArrayList vecVal=new ArrayList();
		ArrayList vecRec=new ArrayList();		
		ArrayList vecid = new ArrayList();
	    hshValues.put("sel_divID",sel_divID);
		
			
//			Retreving of values for project input 
			
			String query1 = SQLParser.getSqlQuery("financial_new_projectinputfields_select^"+strValue);
			rs = DBUtils.executeQuery(query1);
			ArrayList vec=new ArrayList();
			if(rs.next())
			{			
				vec.add(Helper.correctNull(Helper.correctNull((String)rs.getString(10))));
				vec.add(Helper.correctNull(Helper.correctNull((String)rs.getString(2))));
				if(Helper.correctNull(rs.getString(3)).equalsIgnoreCase(""))
				{
					vec.add("0.00");
				}
				else
				{
					vec.add(Helper.correctNull((String)rs.getString(3)));
				}
				if(Helper.correctNull(rs.getString(4)).equalsIgnoreCase(""))
				{
					vec.add("0.00");
				}
				else
				{
					vec.add(Helper.correctNull((String)rs.getString(4)));
				}
				vec.add(Helper.correctNull((String)rs.getString(5)));
				vec.add(Helper.correctNull((String)rs.getString(6)));
				vec.add(Helper.correctNull((String)rs.getString(7)));
				vec.add(Helper.correctNull((String)rs.getString(8)));
				vec.add(Helper.correctNull((String)rs.getString(9)));
				hshValues.put("projectinputvalue",vec);
			}
			else
			{
				vec.add("");
				vec.add("");
				vec.add("0.00");
				vec.add("0.00");
				vec.add("");
				vec.add("");
				vec.add("");
				vec.add("");
				vec.add("0.00");
				hshValues.put("projectinputvalue",vec);
			}
			

			//Retreving of value for base year
			
			if(rs!=null)
			{
				rs.close();
			}
		
		//-------------- to find the time of review-----------------

		if(rs!=null)
		{
			rs.close();
		}

		//--------------- to find the cma format of the particular applications-------

		String tempbool="2",tabool="";
		//String cma="0";		
	//	log.info((String)hshRequestValues.get("cattype"));

			strQuery=SQLParser.getSqlQuery("comfintrendsel1^"+strValue);
			if(rs != null)
			{
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			 
			while(rs.next())
			{  
				//cma=correctNull(rs.getString("demo_finstandard"));
				fintype = Helper.correctNull((String)rs.getString("demo_finmodel"));
			}
		
			if(cma.equalsIgnoreCase("5"))
			{
				if(pagetab.equalsIgnoreCase(""))
				{
				pagetab="INFRA STRUCTURE MODEL";
				}
			}
		//}
		
		// -----------------to find the tab----------------------
		
		
			if(cma.equalsIgnoreCase(""))
			{
				cma="0";
			}
			strQuery = SQLParser.getSqlQuery("com_fintabselect^"+cma);
			if(rs != null)
			{
				rs.close();
			}
			rs=DBUtils.executeQuery(strQuery);
			int y=0;
			while(rs.next())
			{		
				//tempbool = "2";
				if((y==0) && (page.trim().equals("") || page.trim().equals("RA") ) )
					{
						page = correctNull((String)rs.getString("fin_tabname"));
					}
		
				
					vecRec = new ArrayList();
					vecRec.add(correctNull(rs.getString("fin_tabname")));
					vecVal.add(vecRec);
					
			}
		//}

			hshValues.put("tabdetails",vecVal);			
			vecVal = new ArrayList();
			
			
	//--------------- to select label depending upon existence of application
		String tempsno="";
		
		str=0;
		if (str <= 0)
			{
				strQuery = SQLParser.getSqlQuery("finselect2a^"+"1"+"^"+"DSCR");
				if(rs != null)
				{
					rs.close();
				}
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
						vecRec = new ArrayList();
						vecRec.add(correctNull(rs.getString("fin_rowid")));
						vecRec.add(correctNull(rs.getString("fin_rowdesc")));
						vecRec.add(correctNull(rs.getString("fin_rowtype")));
						tempsno = correctNull(rs.getString("fin_sno"));
						if (tempsno.trim().equals(""))
						{
							tempsno=" ";
						}
						
						vecRec.add(tempsno);
						vecVal.add(vecRec);								
				}

				hshValues.put("labeldetails",vecVal);
				
		
				
			}

			
		hshValues.put("count",Integer.toString(str));
		
		String yearselect="",seloption="",givenyear="";
		int i = 0,k=0;
		int from = 0,p=0,tt=0;
		
		ArrayList vecrec = new ArrayList();
		givenyear = correctNull((String)hshRequestValues.get("from"));
		if (givenyear.equals(""))
		{
			givenyear="0";
		}
		from = Integer.parseInt(givenyear);
		if (from == 0)
		{
			from = 1;
		}
		
		    	String valarray[] = new String[6];		    	
			   	valarray[0] ="0";
				valarray[1] ="0";
				valarray[2] ="0";
				valarray[3] ="0";
				valarray[4] ="0";
		
				strQuery = SQLParser.getSqlQuery("finYearSelDSCR^"+strValue+"^"+sel_divID);				
				rs=DBUtils.executeQuery(strQuery);
				ArrayList arryvall=new ArrayList();
				
				int kk=0;
				while(rs.next())
				{
					arryvall.add(Helper.correctNull(rs.getString("fin_year")));
					
				}
		
//this code has been commented by balaji & shanmugam for get all the year for all the sub tags
//and new line has been added bellow
				
		strQuery = SQLParser.getSqlQuery("finYearSelDSCR^"+strValue+"^"+sel_divID);

		if(rs != null)
		{
			rs.close();
		}
		rs=DBUtils.executeQuery(strQuery);
		while(rs.next())
		{
				valarray[0] ="0";
				valarray[1] ="0";
				valarray[2] ="0";
				valarray[3] ="0";
				valarray[4] ="0";					
				vecVal = new ArrayList();	
				String desc="";			
				yearselect = (String)Helper.correctNull(rs.getString("fin_year"));
			
			if(!yearselect.equals(""))
			{
				
				if(rs3 != null)
				{
					rs3.close();
				}
				

				String strQuery10 = SQLParser.getSqlQuery("assessselect9DSCR^"+strValue+"^"+yearselect);
				if(rs10 != null)
				{
					rs10.close();
				}
				
				rs10 = DBUtils.executeQuery(strQuery10);
				if (rs10.next())
				{
					 sumaudit=Helper.correctDouble(rs10.getString("sumaudit"));
					 sumunaudit=Helper.correctDouble(rs10.getString("sumunaudit"));
					 sumestimated=Helper.correctDouble(rs10.getString("sumestimated"));
					 sumprojection=Helper.correctDouble(rs10.getString("sumprojection"));
				}
				if (valarray[0].equals("0") && !sumaudit.equals("0"))
				{
					valarray[0]="fin_audit";
				}
				if (valarray[1].equals("0") && !sumunaudit.equals("0"))
				{
					valarray[1]="fin_unaudit";
				}
				if (valarray[2].equals("0") && !sumestimated.equals("0"))
				{
					valarray[2]="fin_estimated";
				}
				if (valarray[3].equals("0") && !sumprojection.equals("0"))
				{
					valarray[3]="fin_projection";
				}
				if (valarray[4].equals("0") && !sumprojection.equals("0"))
				{
					valarray[4]="fin_projection";
				}			
						
				if(rs10!=null)
				{
					rs10.close();
				}
				

			for (int h=0;h<4;h++)
			{
				vecVal = new ArrayList();
				vecid  = new ArrayList();
				
				if(valarray[h].equals(""))
				{
				valarray[h]="0.00";
				}
				if (!valarray[h].equals("0"))
				{
					i=i+1;
					seloption=valarray[h];
					if ((i >=  from) && (k < 5) )
					{
						p=i;
						k=k+1;
					
						strQuery = SQLParser.getSqlQuery("finselect5DSCR^"+seloption+"^"+yearselect+"^"+strValue);
						
						if(rs1 != null)
						{
							rs1.close();
						}						
						rs1=DBUtils.executeQuery(strQuery);
						while (rs1.next())
						{
									vecVal.add(correctNull(rs1.getString("txtvalue")));
									vecid.add(correctNull(rs1.getString("fin_rowid")));
						
									
									hshValues.put("year"+k,vecVal);	
									hshValues.put("vecid"+k,vecid);					
							}
																	
							if(rs1!=null)
							{
								rs1.close();
							}
							vecrec.add(yearselect);
							vecrec.add(seloption);
					}

				}
			}
		}
	}
	
	hshValues.put("from",Integer.toString(from));

	//added by balaji and shanmugam for get the Next and Previous anchor bellow the page

		
		hshValues.put("totalyear",i+"");
		hshValues.put("upto",p+"");
		hshValues.put("yearvalue",vecrec);
		hshValues.put("page",page);
		hshValues.put("IRBUpload",hidUpload);
		
	// checking for the values in the com_finappvalues table
	strQuery = SQLParser.getSqlQuery("com_finappvaluesselDSCR^"+strValue+"^"+sel_divID);
	rs = DBUtils.executeQuery(strQuery);
		 
	if(rs.next())
	{  
		hshValues.put("findata","true");
	}
	else
	{
		hshValues.put("findata","false");
	}

	if(rs!=null){rs.close();}
	
	strQuery = SQLParser.getSqlQuery("com_finappdscr_Avg_sel^"+strValue);
	rs = DBUtils.executeQuery(strQuery);
	if(rs.next())
	{
		hshValues.put("DscrAvg", nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("com_avgdscr")))));
	}
	else
	{
		hshValues.put("DscrAvg", "0.00");
	}
	//select financial values are in lakhs/ crores
	if(strValuesin.equalsIgnoreCase("C"))
	{
		hshValues.put("strValuesin", "Crore");
	}
	else if(strValuesin.equalsIgnoreCase("L"))
	{
		hshValues.put("strValuesin", "Lacs");
	}else{
		hshValues.put("strValuesin", "Rupees");
	}
}
		catch(Exception ce)
		{
			ce.printStackTrace();
			throw new EJBException("Error in getData login  "+ce.toString());
			
		}
		finally
		{
			try
			{	
				if(rs != null)
					rs.close();
				if(rs1 != null)
					rs1.close();
				if(rs3 != null)
					rs3.close();
				if(rs4 != null)
					rs4.close();
				if(rs10 != null)
					rs10.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		hshValues.put("tabname",pagetab);
		hshValues.put("strAction",strAction);
		hshValues.put("fintype", fintype);
		return hshValues; 
	}
	public void updateDSCRData(HashMap hsh) 
	{		
		
		ResultSet rs = null,rs1=null;
		String strQuery="";
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		String year1="",year2="",year3="",year4="",year5="";
		String c1year="",c2year="",c3year="",c4year="",c5year="",strDivid="";		
		String strRowCol1="",strRowCol2="",strRowCol3="",strRowCol4="",strRowCol5="";		
		int intUpdatesize =0,intValue=0;		
		String test=Integer.toString(intValue);		
		String []id=null;		
		String appno="";		
		String []strType=null;
		String strAction="";
		
		try
		{
				appno=(String)hsh.get("appno");
				//Added by Kishan
				//String strFinID = appno;
				/*String cma="0";
				strQuery = SQLParser.getSqlQuery("sel_financeid^"+appno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strFinID=Helper.correctNull((String)rs.getString("DEMO_FINSTANDARD"));
					if(!strFinID.equals("")) {
						strQuery = SQLParser.getSqlQuery("fin_cmano_select^"+strFinID);
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next()) {
							cma = Helper.correctNull((String)rs.getString("FIN_CMANO"));
						}
					}
				}
				*/
				hsh.get("id");				
				id= (String[])hsh.get("id");			
				int idlen=id.length;
				strType=(String [])hsh.get("type");				
				strDivid=(String )hsh.get("sel_divID");	
				if(strDivid=="")
				{
					strDivid="0";
				}
				year1=correctNull((String)hsh.get("txtyear1"));
				year2=correctNull((String)hsh.get("txtyear2"));
				year3=correctNull((String)hsh.get("txtyear3"));
				year4=correctNull((String)hsh.get("txtyear4"));
				year5=correctNull((String)hsh.get("txtyear5"));
				
				c1year=correctNull((String)hsh.get("combo1"));
				c2year=correctNull((String)hsh.get("combo2"));
				c3year=correctNull((String)hsh.get("combo3"));
				c4year=correctNull((String)hsh.get("combo4"));
				c5year=correctNull((String)hsh.get("combo5"));
				int x=0;
				strAction=Helper.correctNull((String)hsh.get("hidAction"));

					
		//-----------------------------------------------------------------------------------------------------------		
				
				
				/**
				 * 
				 * @Author: Muralidharan. R
				 * @CREATED FOR : TO STORE BASE YEAR FOR ALL MODELS 
				 * @PURPOSE : RAM INTERFACE
				 * @DATE : 11/01/2008
				 * 
				 */
				
		
				String BaseYearFlag=Helper.correctNull((String)hsh.get("BaseYearFlag"));
			
				//Added by Punitha To Avoid Duplicate Entry
				if(strAction.equalsIgnoreCase("update"))
					updateDSCRSensitivityTableUpdate(hsh);

	for(int i=0;i<idlen;i++)
	{			
			
			String y = correctNull(id[i]);
			x= Integer.parseInt(y);
			if(strType[i].equalsIgnoreCase("I"))
			{				
				String temp=correctNull((String)hsh.get("desc"+x));
				if(!temp.equals(""))
				{
					hshQueryValues=new HashMap();
					intUpdatesize=0;
					strQuery = SQLParser.getSqlQuery("finappdesccount^"+appno+'^'+x);
					
					if(rs != null)
					{
						rs.close();
					}
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","finappdescup");
						arrValues.add(correctNull((String)hsh.get("desc"+x)));
						arrValues.add(appno);
						arrValues.add(correctNull(id[i]));
						hshQuery.put("arrValues",arrValues);
						
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					}
					else
					{
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;						
						hshQuery.put("strQueryId","finappdescins");
						arrValues.add(appno);
						arrValues.add(correctNull(id[i]));
						arrValues.add(correctNull((String)hsh.get("desc"+x)));
						hshQuery.put("arrValues",arrValues);						
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					}
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				}
				
			}//for first if
							
				strRowCol1 = Helper.correctDouble((String)hsh.get("row"+x+"c1"));
				strRowCol2 = Helper.correctDouble((String)hsh.get("row"+x+"c2"));
				strRowCol3 = Helper.correctDouble((String)hsh.get("row"+x+"c3"));
				strRowCol4 = Helper.correctDouble((String)hsh.get("row"+x+"c4"));
				strRowCol5 = Helper.correctDouble((String)hsh.get("row"+x+"c5"));

				String strTemp="";
				strTemp=strType[i];
				String tempDesc=correctNull((String)hsh.get("desc"+x));				
				hshQueryValues=new HashMap();
				intUpdatesize=0;

		if (!year1.equals("") && !c1year.trim().equals("") )
		{
			if(!strType[i].equalsIgnoreCase("C") && ! strType[i].equalsIgnoreCase("H"))
			{				
				strQuery = SQLParser.getSqlQuery("finappvaluescountDSCR^"+appno+"^"+year1+'^'+x);
				
				if(rs !=  null)
				{
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				
				if(rs.next())
				{					
						hshQueryValues=new HashMap();
						intUpdatesize=0;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						if (c1year.trim().equalsIgnoreCase("a"))
						{
							hshQuery.put("strQueryId","finappvaluesup1DSCR");
						}
						if (c1year.trim().equalsIgnoreCase("u"))
						{
							hshQuery.put("strQueryId","finappvaluesup2DSCR");
						}
						if (c1year.trim().equalsIgnoreCase("e"))
						{
							hshQuery.put("strQueryId","finappvaluesup3DSCR");
						}
						if (c1year.trim().equalsIgnoreCase("p"))
						{
							hshQuery.put("strQueryId","finappvaluesup4DSCR");
						}

						if(strTemp.equalsIgnoreCase("I") && tempDesc.equals("") && c1year.trim().equalsIgnoreCase("p"))
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year1);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
						}
						else if(c1year.trim().equalsIgnoreCase("p"))
						{
							arrValues.add(strRowCol1);//get values from Rowcal field
							arrValues.add(strRowCol1);
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year1);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
						}
						else if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year1);												
							hshQuery.put("arrValues",arrValues);							
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						}
						else
						{
							arrValues.add(strRowCol1);//get values from Rowcal field
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year1);												
							hshQuery.put("arrValues",arrValues);							
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						}
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
					
					
				}
				else
				{					
						hshQueryValues=new HashMap();
						intUpdatesize=0;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","finappDSCRins");
						arrValues.add(appno);
						arrValues.add(year1);
						arrValues.add(correctNull(id[i]));
						if (c1year.trim().equalsIgnoreCase("a"))
						{
							if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
							{
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								
							}
							else
							{
								arrValues.add(strRowCol1);//get values from Rowcal field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								
							}
							
						}
						if (c1year.trim().equalsIgnoreCase("u"))
						{
							if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
							{
								arrValues.add(test);
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								
							}
							else
							{
								arrValues.add(test);
								arrValues.add(strRowCol1);//get values from Rowcal field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								
							}
						}
						if (c1year.trim().equalsIgnoreCase("e"))
						{
							if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(test);
								arrValues.add(test);
								
							}
							else
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(strRowCol1);//get values from Rowcal field
								arrValues.add(test);
								arrValues.add(test);
								
							}
							
						}
						if (c1year.trim().equalsIgnoreCase("p"))
						{
							if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(test);
								
							}
							else
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(strRowCol1);//get values from Rowcal field
								arrValues.add(strRowCol1);
								
							}
							
						}
						strDivid="0";
						arrValues.add(strDivid);   arrValues.add(""+(i+1));
						hshQuery.put("arrValues",arrValues);						
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
					
				}
			}
			else
			{
						
				strQuery = SQLParser.getSqlQuery("finappvaluescountDSCR^"+appno+"^"+year1+'^'+x);
				
				if(rs !=  null)
				{
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				
				if(rs.next())
				{
						hshQueryValues=new HashMap();
						intUpdatesize=0;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						if (c1year.trim().equalsIgnoreCase("a"))
						{
							hshQuery.put("strQueryId","finappvaluesup1DSCR");
						}
						if (c1year.trim().equalsIgnoreCase("u"))
						{
							hshQuery.put("strQueryId","finappvaluesup2DSCR");
						}
						if (c1year.trim().equalsIgnoreCase("e"))
						{
							hshQuery.put("strQueryId","finappvaluesup3DSCR");
						}
						if (c1year.trim().equalsIgnoreCase("p"))
						{
							hshQuery.put("strQueryId","finappvaluesup4DSCR");
						}

						if (c1year.trim().equalsIgnoreCase("p"))
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year1);
												
							hshQuery.put("arrValues",arrValues);						
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}
						else
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year1);
												
							hshQuery.put("arrValues",arrValues);						
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
						}
						
				}
				else
				{						
						hshQueryValues=new HashMap();
						intUpdatesize=0;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","finappDSCRins");
						arrValues.add(appno);
						arrValues.add(year1);
						arrValues.add(correctNull(id[i]));
						if (c1year.trim().equalsIgnoreCase("a"))
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);
							
						}
						if (c1year.trim().equalsIgnoreCase("u"))
						{
							arrValues.add(test);
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);
							
						}
						if (c1year.trim().equalsIgnoreCase("e"))
						{
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(test);
							
						}
						if (c1year.trim().equalsIgnoreCase("p"))
						{
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							
						}
				
						strDivid="0";
						arrValues.add(strDivid);  arrValues.add(""+(i+1));
						hshQuery.put("arrValues",arrValues);						
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				}
				
			}
			
		}//year
		

		hshQueryValues=new HashMap();
		intUpdatesize=0;

		if (!year2.equals("") && !c2year.trim().equals(""))
		{
			if(!strType[i].equalsIgnoreCase("C")&& !strType[i].equalsIgnoreCase("H"))
			{				
				strQuery = SQLParser.getSqlQuery("finappvaluescountDSCR^"+appno+"^"+year2+'^'+x);
				if(rs !=  null)
				{
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				
				if(rs.next())
				{					
						hshQueryValues=new HashMap();
						intUpdatesize=0;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						if (c2year.trim().equalsIgnoreCase("a"))
						{
							hshQuery.put("strQueryId","finappvaluesup1DSCR");
						}
						if (c2year.trim().equalsIgnoreCase("u"))
						{
							hshQuery.put("strQueryId","finappvaluesup2DSCR");
						}
						if (c2year.trim().equalsIgnoreCase("e"))
						{
							hshQuery.put("strQueryId","finappvaluesup3DSCR");
						}
						if (c2year.trim().equalsIgnoreCase("p"))
						{
							hshQuery.put("strQueryId","finappvaluesup4DSCR");
						}
						if(strTemp.equalsIgnoreCase("I") && tempDesc.equals("") && c2year.trim().equalsIgnoreCase("p"))
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year2);					
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
						}
						else if(c2year.trim().equalsIgnoreCase("p"))
						{
							arrValues.add(strRowCol2);//get values from Rowcal field
							arrValues.add(strRowCol2);
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year2);					
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
						}
						else if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year2);					
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						}
						else
						{
							arrValues.add(strRowCol2);//get values from Rowcal field
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year2);					
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						}
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
					
				}
				else
				{
						hshQueryValues=new HashMap();
						intUpdatesize=0;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","finappDSCRins");
						arrValues.add(appno);
						arrValues.add(year2);
						arrValues.add(correctNull(id[i]));
						if (c2year.trim().equalsIgnoreCase("a"))
						{
							if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(test);
								
							}
							else
							{
								arrValues.add(strRowCol2);//get values from Rowcal field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								
							}
						}
						if (c2year.trim().equalsIgnoreCase("u"))
						{
							if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(test);
								
							}
							else
							{
								arrValues.add(test);
								arrValues.add(strRowCol2);//get values from Rowcal field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								
							}
						}
						if (c2year.trim().equalsIgnoreCase("e"))
						{
							if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(test);
								
							}
							else
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(strRowCol2);//get values from Rowcal field
								arrValues.add(test);
								arrValues.add(test);
							}
						}
						if (c2year.trim().equalsIgnoreCase("p"))
						{
							if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(test);
								
							}
							else
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(strRowCol2);//get values from Rowcal field
								arrValues.add(strRowCol2);
								
							}
						}
						strDivid="0";
						arrValues.add(strDivid);   arrValues.add(""+(i+1));
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				}
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("finappvaluescountDSCR^"+appno+"^"+year2+'^'+x);
				
				if(rs !=  null)
				{
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				
				if(rs.next())
				{
						hshQueryValues=new HashMap();
						intUpdatesize=0;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						if (c2year.trim().equalsIgnoreCase("a"))
						{
							hshQuery.put("strQueryId","finappvaluesup1DSCR");
						}
						if (c2year.trim().equalsIgnoreCase("u"))
						{
							hshQuery.put("strQueryId","finappvaluesup2DSCR");
						}
						if (c2year.trim().equalsIgnoreCase("e"))
						{
							hshQuery.put("strQueryId","finappvaluesup3DSCR");
						}
						if (c2year.trim().equalsIgnoreCase("p"))
						{
							hshQuery.put("strQueryId","finappvaluesup4DSCR");
						}
//						if (c2year.trim().equalsIgnoreCase("p"))
//						{
//							hshQuery.put("strQueryId","finappvaluesup5");
//						}
//						
						if(c2year.trim().equalsIgnoreCase("p"))
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year2);
												
							hshQuery.put("arrValues",arrValues);						
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}else
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year2);
												
							hshQuery.put("arrValues",arrValues);						
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}
						
				}
				else
				{						
						hshQueryValues=new HashMap();
						intUpdatesize=0;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","finappDSCRins");
						arrValues.add(appno);
						arrValues.add(year2);
						arrValues.add(correctNull(id[i]));
						if (c2year.trim().equalsIgnoreCase("a"))
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);
							
						}
						if (c2year.trim().equalsIgnoreCase("u"))
						{
							arrValues.add(test);
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);
							
						}
						if (c2year.trim().equalsIgnoreCase("e"))
						{
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(test);
							
						}
						if (c2year.trim().equalsIgnoreCase("p"))
						{
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							
						}
						strDivid="0";
						arrValues.add(strDivid);   arrValues.add(""+(i+1));
						hshQuery.put("arrValues",arrValues);						
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				}				
			
			}
		}

		
		hshQueryValues=new HashMap();
		intUpdatesize=0;

		if (!year3.equals("") && !c3year.trim().equals("") )
		{
			if(!strType[i].equalsIgnoreCase("C") && !strType[i].equalsIgnoreCase("H"))
			{
				strQuery = SQLParser.getSqlQuery("finappvaluescountDSCR^"+appno+"^"+year3+'^'+x);
				
				if(rs !=  null)
				{
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				
				if(rs.next())
				{					
						hshQueryValues=new HashMap();
						intUpdatesize=0;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						if (c3year.trim().equalsIgnoreCase("a"))
						{
							hshQuery.put("strQueryId","finappvaluesup1DSCR");
						}
						if (c3year.trim().equalsIgnoreCase("u"))
						{
							hshQuery.put("strQueryId","finappvaluesup2DSCR");
						}
						if (c3year.trim().equalsIgnoreCase("e"))
						{
							hshQuery.put("strQueryId","finappvaluesup3DSCR");
						}
						if (c3year.trim().equalsIgnoreCase("p"))
						{
							hshQuery.put("strQueryId","finappvaluesup4DSCR");
						}
						if(strTemp.equalsIgnoreCase("I") && tempDesc.equals("") && c3year.trim().equalsIgnoreCase("p"))
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year3);					
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
						}
						else if(c3year.trim().equalsIgnoreCase("p"))
						{
							arrValues.add(strRowCol3);//get values from Rowcal field
							arrValues.add(strRowCol3);
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year3);					
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
						}
						else if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
						{							
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year3);
												
							hshQuery.put("arrValues",arrValues);							
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);

						}
						else
						{
							arrValues.add(strRowCol3);//get values from Rowcal field
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year3);
												
							hshQuery.put("arrValues",arrValues);							
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						}
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
					
				}
				else
				{
					
						hshQueryValues=new HashMap();
						intUpdatesize=0;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","finappDSCRins");
						arrValues.add(appno);
						arrValues.add(year3);
						arrValues.add(correctNull(id[i]));
						if (c3year.trim().equalsIgnoreCase("a"))
						{
							if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(test);
								
							}
							else
							{
								arrValues.add(strRowCol3);//get values from Rowcal field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								
							}
						}
						if (c3year.trim().equalsIgnoreCase("u"))
						{
							if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(test);
								
							}
							else
							{
								arrValues.add(test);
								arrValues.add(strRowCol3);//get values from Rowcal field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								
							}
						}
						if (c3year.trim().equalsIgnoreCase("e"))
						{
							if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(test);
								
							}
							else
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(strRowCol3);//get values from Rowcal field
								arrValues.add(test);
								arrValues.add(test);
								
							}
						}
						if (c3year.trim().equalsIgnoreCase("p"))
						{
							if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(test);
								
							}
							else
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(strRowCol3);//get values from Rowcal field
								arrValues.add(strRowCol3);
								
							}
						}
						strDivid="0";
						arrValues.add(strDivid);   arrValues.add(""+(i+1));
						
						hshQuery.put("arrValues",arrValues);						
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				}
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("finappvaluescountDSCR^"+appno+"^"+year3+'^'+x);
				
				if(rs !=  null)
				{
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				
				if(rs.next())
				{
						hshQueryValues=new HashMap();
						intUpdatesize=0;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						if (c3year.trim().equalsIgnoreCase("a"))
						{
							hshQuery.put("strQueryId","finappvaluesup1DSCR");
						}
						if (c3year.trim().equalsIgnoreCase("u"))
						{
							hshQuery.put("strQueryId","finappvaluesup2DSCR");
						}
						if (c3year.trim().equalsIgnoreCase("e"))
						{
							hshQuery.put("strQueryId","finappvaluesup3DSCR");
						}
						if (c3year.trim().equalsIgnoreCase("p"))
						{
							hshQuery.put("strQueryId","finappvaluesup4DSCR");
						}

						if(c3year.trim().equalsIgnoreCase("p"))
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year3);
												
							hshQuery.put("arrValues",arrValues);						
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}else
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year3);
												
							hshQuery.put("arrValues",arrValues);						
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}
					
				}
				else
				{
						
						hshQueryValues=new HashMap();
						intUpdatesize=0;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","finappDSCRins");
						arrValues.add(appno);
						arrValues.add(year3);
						arrValues.add(correctNull(id[i]));
						if (c3year.trim().equalsIgnoreCase("a"))
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);
							
						}
						if (c3year.trim().equalsIgnoreCase("u"))
						{
							arrValues.add(test);
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);
						}
						if (c3year.trim().equalsIgnoreCase("e"))
						{
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(test);
						}
						if (c3year.trim().equalsIgnoreCase("p"))
						{
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
						}
						strDivid="0";
						arrValues.add(strDivid);   arrValues.add(""+(i+1));
						hshQuery.put("arrValues",arrValues);						
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				}				
			}
		}
			
		hshQueryValues=new HashMap();
		intUpdatesize=0;
				
				
		if (!year4.equals("") && !c4year.trim().equals(""))
		{
			if(!strType[i].equalsIgnoreCase("C")&& !strType[i].equalsIgnoreCase("H"))
			{
				strQuery = SQLParser.getSqlQuery("finappvaluescountDSCR^"+appno+"^"+year4+'^'+x);
				
				if(rs !=  null)
				{
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				
				if(rs.next())
				{
					
						hshQueryValues=new HashMap();
						intUpdatesize=0;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						if (c4year.trim().equalsIgnoreCase("a"))
						{
							hshQuery.put("strQueryId","finappvaluesup1DSCR");
						}
						if (c4year.trim().equalsIgnoreCase("u"))
						{
							hshQuery.put("strQueryId","finappvaluesup2DSCR");
						}
						if (c4year.trim().equalsIgnoreCase("e"))
						{
							hshQuery.put("strQueryId","finappvaluesup3DSCR");
						}
						if (c4year.trim().equalsIgnoreCase("p"))
						{
							hshQuery.put("strQueryId","finappvaluesup4DSCR");
						}
						if(strTemp.equalsIgnoreCase("I") && tempDesc.equals("") && c4year.trim().equalsIgnoreCase("p"))
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year4);					
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
						}
						else if(c4year.trim().equalsIgnoreCase("p"))
						{
							arrValues.add(strRowCol4);//get values from Rowcal field
							arrValues.add(strRowCol4);
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year4);					
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
						}
						else if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
						{
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(appno);
								arrValues.add(correctNull(id[i]));
								//arrValues.add(strDivid);
								arrValues.add(year4);
													
								hshQuery.put("arrValues",arrValues);								
								hshQueryValues.put("size",Integer.toString(intUpdatesize));
								hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						}
						else
						{								
								arrValues.add(strRowCol4);//get values from Rowcal field
								arrValues.add(appno);
								arrValues.add(correctNull(id[i]));
								//arrValues.add(strDivid);
								arrValues.add(year4);
													
								hshQuery.put("arrValues",arrValues);								
								hshQueryValues.put("size",Integer.toString(intUpdatesize));
								hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						}
					
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
				}
				else
				{
					
						hshQueryValues=new HashMap();
						intUpdatesize=0;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","finappDSCRins");
						arrValues.add(appno);
						arrValues.add(year4);
						arrValues.add(correctNull(id[i]));
						if (c4year.trim().equalsIgnoreCase("a"))
						{
							if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(test);
							}
							else
							{
								arrValues.add(strRowCol4);//get values from Rowcal field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
							}
						}
						if (c4year.trim().equalsIgnoreCase("u"))
						{
							if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(test);
							}
							else
							{
								arrValues.add(test);
								arrValues.add(strRowCol4);//get values from Rowcal field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
							}
						}
						if (c4year.trim().equalsIgnoreCase("e"))
						{
							
							if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(test);
							}
							else
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(strRowCol4);//get values from Rowcal field
								arrValues.add(test);
								arrValues.add(test);
							}
						}
						if (c4year.trim().equalsIgnoreCase("p"))
						{
							
							if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(test);
							}
							else
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(strRowCol4);//get values from Rowcal field
								arrValues.add(strRowCol4);
							}
						}
						strDivid="0";
						arrValues.add(strDivid);   arrValues.add(""+(i+1));
						hshQuery.put("arrValues",arrValues);						
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("finappvaluescountDSCR^"+appno+"^"+year4+'^'+x);
				
				if(rs !=  null)
				{
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				
				if(rs.next())
				{
						hshQueryValues=new HashMap();
						intUpdatesize=0;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						if (c4year.trim().equalsIgnoreCase("a"))
						{
							hshQuery.put("strQueryId","finappvaluesup1DSCR");
						}
						if (c4year.trim().equalsIgnoreCase("u"))
						{
							hshQuery.put("strQueryId","finappvaluesup2DSCR");
						}
						if (c4year.trim().equalsIgnoreCase("e"))
						{
							hshQuery.put("strQueryId","finappvaluesup3DSCR");
						}
						if (c4year.trim().equalsIgnoreCase("p"))
						{
							hshQuery.put("strQueryId","finappvaluesup4DSCR");
						}
						if(c4year.trim().equalsIgnoreCase("p"))
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year4);
												
							hshQuery.put("arrValues",arrValues);						
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}
						else
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year4);
												
							hshQuery.put("arrValues",arrValues);						
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}
						
				}
				else
				{
						
						hshQueryValues=new HashMap();
						intUpdatesize=0;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","finappDSCRins");
						arrValues.add(appno);
						arrValues.add(year4);
						arrValues.add(correctNull(id[i]));
						if (c4year.trim().equalsIgnoreCase("a"))
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);
						}
						if (c4year.trim().equalsIgnoreCase("u"))
						{
							arrValues.add(test);
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);
						}
						if (c4year.trim().equalsIgnoreCase("e"))
						{
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(test);
						}
						
						if (c4year.trim().equalsIgnoreCase("p"))
						{
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
						}
						strDivid="0";
						arrValues.add(strDivid);   arrValues.add(""+(i+1));
						hshQuery.put("arrValues",arrValues);						
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				}
			}
		}	
		/////
		hshQueryValues=new HashMap();
		intUpdatesize=0;
				
				
		if (!year5.equals("") && !c5year.trim().equals(""))
		{
			if(!strType[i].equalsIgnoreCase("C")&& !strType[i].equalsIgnoreCase("H"))
			{
				strQuery = SQLParser.getSqlQuery("finappvaluescountDSCR^"+appno+"^"+year5+'^'+x);
				
				if(rs !=  null)
				{
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				
				if(rs.next())
				{
					
						hshQueryValues=new HashMap();
						intUpdatesize=0;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						if (c5year.trim().equalsIgnoreCase("a"))
						{
							hshQuery.put("strQueryId","finappvaluesup1DSCR");
						}
						if (c5year.trim().equalsIgnoreCase("u"))
						{
							hshQuery.put("strQueryId","finappvaluesup2DSCR");
						}
						if (c5year.trim().equalsIgnoreCase("e"))
						{
							hshQuery.put("strQueryId","finappvaluesup3DSCR");
						}
						if (c5year.trim().equalsIgnoreCase("p"))
						{
							hshQuery.put("strQueryId","finappvaluesup4DSCR");
						}

						if(strTemp.equalsIgnoreCase("I") && tempDesc.equals("") && c5year.trim().equalsIgnoreCase("p"))
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year5);					
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
						}
						else if(c5year.trim().equalsIgnoreCase("p"))
						{
							arrValues.add(strRowCol5);//get values from Rowcal field
							arrValues.add(strRowCol5);
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year5);					
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
						}
						else if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
						{								
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(appno);
								arrValues.add(correctNull(id[i]));
								//arrValues.add(strDivid);
								arrValues.add(year5);
													
								hshQuery.put("arrValues",arrValues);								
								hshQueryValues.put("size",Integer.toString(intUpdatesize));
								hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						}
						else
						{								
								arrValues.add(strRowCol5);//get values from Rowcal field
								arrValues.add(appno);
								arrValues.add(correctNull(id[i]));
								//arrValues.add(strDivid);
								arrValues.add(year5);
													
								hshQuery.put("arrValues",arrValues);								
								hshQueryValues.put("size",Integer.toString(intUpdatesize));
								hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						}
					
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
				}
				else
				{					
						hshQueryValues=new HashMap();
						intUpdatesize=0;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","finappDSCRins");
						arrValues.add(appno);
						arrValues.add(year5);
						arrValues.add(correctNull(id[i]));
						if (c5year.trim().equalsIgnoreCase("a"))
						{
							if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(test);
							}
							else
							{
								arrValues.add(strRowCol5);//get values from Rowcal field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
							}
						}
						if (c5year.trim().equalsIgnoreCase("u"))
						{
							if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(test);
							}
							else
							{
								arrValues.add(test);
								arrValues.add(strRowCol5);//get values from Rowcal field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
							}
						}
						if (c5year.trim().equalsIgnoreCase("e"))
						{
							
							if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(test);
							}
							else
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(strRowCol5);//get values from Rowcal field
								arrValues.add(test);
								arrValues.add(test);
							}
						}
						if (c5year.trim().equalsIgnoreCase("p"))
						{
							
							if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(test);
							}
							else
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(strRowCol5);//get values from Rowcal field
								arrValues.add(strRowCol5);
							}
						}
						strDivid="0";
						arrValues.add(strDivid);   arrValues.add(""+(i+1));
						hshQuery.put("arrValues",arrValues);						
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("finappvaluescountDSCR^"+appno+"^"+year5+'^'+x);
				
				if(rs !=  null)
				{
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				
				if(rs.next())
				{
						hshQueryValues=new HashMap();
						intUpdatesize=0;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						if (c5year.trim().equalsIgnoreCase("a"))
						{
							hshQuery.put("strQueryId","finappvaluesup1DSCR");
						}
						if (c5year.trim().equalsIgnoreCase("u"))
						{
							hshQuery.put("strQueryId","finappvaluesup2DSCR");
						}
						if (c5year.trim().equalsIgnoreCase("e"))
						{
							hshQuery.put("strQueryId","finappvaluesup3DSCR");
						}
						if (c5year.trim().equalsIgnoreCase("p"))
						{
							hshQuery.put("strQueryId","finappvaluesup4DSCR");
						}
						if(c5year.trim().equalsIgnoreCase("p"))
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year5);
												
							hshQuery.put("arrValues",arrValues);						
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}
						else
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year5);
												
							hshQuery.put("arrValues",arrValues);						
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}
						
				}
				else
				{
						
						hshQueryValues=new HashMap();
						intUpdatesize=0;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","finappDSCRins");
						arrValues.add(appno);
						arrValues.add(year5);
						arrValues.add(correctNull(id[i]));
						if (c5year.trim().equalsIgnoreCase("a"))
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);
						}
						if (c5year.trim().equalsIgnoreCase("u"))
						{
							arrValues.add(test);
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);
						}
						if (c5year.trim().equalsIgnoreCase("e"))
						{
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(test);
						}
						if (c5year.trim().equalsIgnoreCase("p"))
						{
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
						}
						strDivid="0";
						arrValues.add(strDivid);   arrValues.add(""+(i+1));
						hshQuery.put("arrValues",arrValues);						
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				}
			}
		}
	
	}

	strQuery = SQLParser.getSqlQuery("seldistinctfinYearDSCR^"+appno+"^0");
	if(rs != null)
	{
		rs.close();
	}
	rs=DBUtils.executeQuery(strQuery);
	while(rs.next())
	{
		String strYear=Helper.correctNull(rs.getString("fin_year"));
		strQuery=SQLParser.getSqlQuery("assessselect9DSCR^"+appno+"^"+strYear);
			
		if(rs1 != null)
		{
			rs1.close();
		}
		rs1 = DBUtils.executeQuery(strQuery);
		if (rs1.next())
		{
			if(rs1.getDouble("sumaudit")==0 && rs1.getDouble("sumunaudit")==0 && rs1.getDouble("sumestimated")==0 && rs1.getDouble("sumprojection")==0)
			{
				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize = 1;
				hshQuery.put("strQueryId","finappvaluesdelDSCR");
				arrValues.add(appno);
				arrValues.add(strYear);
				arrValues.add("0");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
		}
	}
	
	hshQueryValues=new HashMap();
	intUpdatesize=0;
	
	hshQuery = new HashMap();
	arrValues=new ArrayList();
	intUpdatesize = intUpdatesize+1;
	hshQuery.put("strQueryId","finappdscr_avg_del");
	arrValues.add(appno);
	hshQuery.put("arrValues",arrValues);						
	hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);

	intUpdatesize = intUpdatesize+1;hshQuery = new HashMap();
	hshQuery.put("strQueryId","finappdscr_avg_ins");
	arrValues=new ArrayList();
	arrValues.add(appno);
	arrValues.add("0.00");
	hshQuery.put("arrValues",arrValues);						
	
	
	hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
	hshQueryValues.put("size",Integer.toString(intUpdatesize));
	
	EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");

		}
		catch (Exception e)
		{
			throw new EJBException("Exception in updateDSCRData:  "+e.getMessage());
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
				cf.printStackTrace();
				throw new EJBException("Error closing the connection "+cf.getMessage());
						
			}
		}
		
		
	}
	
	

	public HashMap updateDSCRFormula(HashMap hshRequestValues) 
	{		
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs3 = null;
		ResultSet rs4 = null;
		ResultSet rs10 =null;
		ArrayList arrValues=new ArrayList();		
		HashMap hshValues=null;
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		String strQuery="",strValue="";		
		
		String sumaudit="";
		String sumunaudit="";
		String sumestimated="";
		String sumprojection="";
		String sel_divID="";
		String pagetab="";
		int intUpdatesize =0;
		//String finance_id="";
	
	try
	{	
		strValue=correctNull((String)hshRequestValues.get("appno"));
		sel_divID=correctNull((String)hshRequestValues.get("sel_divID"));
		if(sel_divID.equalsIgnoreCase(""))
		{
			sel_divID="0";
		}
		String page = correctNull((String)hshRequestValues.get("pageval"));
		pagetab=Helper.correctNull(page);
			
		hshValues = new HashMap();
		ArrayList vecVal=new ArrayList();
		//ArrayList vecRec=new ArrayList();		
		ArrayList vecid = new ArrayList();
	    hshValues.put("sel_divID",sel_divID);
				
		
		//--------------- to find the cma format of the particular applications-------

		//String cma="";

			
			
			/*if(!strValue.equals(""))
			{
				if(finance_id.equals(""))
				{
					String query1 = SQLParser.getSqlQuery("comdemographics_sel^"+strValue);
					rs = DBUtils.executeQuery(query1);
				
					if(rs.next())
					{		
						finance_id=(Helper.correctNull((String)rs.getString("demo_finstandard")));
						strValue=(Helper.correctNull((String)rs.getString("demo_finstandard")));
					}
				}
			}
		
			if(cma.equalsIgnoreCase(""))
			{
				if(rs != null)
				{
					rs.close();
				}
				
				if(!strValue.equals(""))
				{
				strQuery=SQLParser.getSqlQuery("fin_cmano_select^"+strValue);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{  
					
					cma=Helper.correctNull((String)rs.getString("fin_cmano"));
				}
				}
			}
*/
		String yearselect="",seloption="",givenyear="";
		int i = 0,k=0;
		int from = 0,p=0;
		ArrayList vecrec = new ArrayList();
		givenyear = correctNull((String)hshRequestValues.get("from"));
		if (givenyear.equals(""))
		{
			givenyear="0";
		}
		from = Integer.parseInt(givenyear);
		if (from == 0)
		{
			from = 1;
		}
		
		    	String valarray[] = new String[6];		    	
			   	valarray[0] ="0";
				valarray[1] ="0";
				valarray[2] ="0";
				valarray[3] ="0";
				valarray[4] ="0";
		
	//this code has been commented by balaji & shanmugam for get all the year for all the sub tags
	//and new line has been added bellow
				
//		strQuery = SQLParser.getSqlQuery("finselect4^"+page+"^"+masterpage+"^"+strValue);
		strQuery = SQLParser.getSqlQuery("finYearSelDSCR^"+strValue);

		if(rs != null)
		{
			rs.close();
		}
		rs=DBUtils.executeQuery(strQuery);
		while(rs.next())
		{
				valarray[0] ="0";
				valarray[1] ="0";
				valarray[2] ="0";
				valarray[3] ="0";
				valarray[4] ="0";					
				vecVal = new ArrayList();	
				String desc="";			
				yearselect = (String)Helper.correctNull(rs.getString("fin_year"));
			
			if(!yearselect.equals(""))
			{
				
				if(rs3 != null)
				{
					rs3.close();
				}

				String strQuery10 = SQLParser.getSqlQuery("assessselect9DSCR^"+strValue+"^"+yearselect);
				if(rs10 != null)
				{
					rs10.close();
				}
				
				rs10 = DBUtils.executeQuery(strQuery10);
				if (rs10.next())
				{
					 sumaudit=Helper.correctDouble(rs10.getString("sumaudit"));
					 sumunaudit=Helper.correctDouble(rs10.getString("sumunaudit"));
					 sumestimated=Helper.correctDouble(rs10.getString("sumestimated"));
					 sumprojection=Helper.correctDouble(rs10.getString("sumprojection"));
				}
				if (valarray[0].equals("0") && !sumaudit.equals("0"))
				{
					valarray[0]="fin_audit";
				}
				if (valarray[1].equals("0") && !sumunaudit.equals("0"))
				{
					valarray[1]="fin_unaudit";
				}
				if (valarray[2].equals("0") && !sumestimated.equals("0"))
				{
					valarray[2]="fin_estimated";
				}
				if (valarray[3].equals("0") && !sumprojection.equals("0"))
				{
					valarray[3]="fin_projection";
				}
				if (valarray[4].equals("0") && !sumprojection.equals("0"))
				{
					valarray[4]="fin_projection";
				}			
						
				if(rs10!=null)
				{
					rs10.close();
				}
				

			for (int h=0;h<4;h++)
			{
				vecVal = new ArrayList();
				vecid  = new ArrayList();
				
				if(valarray[h].equals(""))
				{
				valarray[h]="0.00";
				}
				if (!valarray[h].equals("0"))
				{
					i=i+1;
					seloption=valarray[h];
					if ((i >=  from) && (k < 5) )
					{
						p=i;
						k=k+1;
					
						strQuery = SQLParser.getSqlQuery("testfinselect5DSCR^"+seloption+"^"+"1"+"^"+yearselect+"^"+strValue);
						
						if(rs1 != null)
						{
							rs1.close();
						}						
						rs1=DBUtils.executeQuery(strQuery);
						while (rs1.next())
						{
								if (seloption.equals("fin_audit"))
								{
								desc="a";
								}
								else if (seloption.equals("fin_unaudit"))
								{
								desc="u";
								}
								else if (seloption.equals("fin_estimated"))
								{
								desc="e";
								}
								else if (seloption.equals("fin_projection"))
								{
								desc="p";
								}
								int formuladesc=0;	
								String fin_rowid="";
								formuladesc =(rs1.getInt("formula")) ;		
								
								//
								fin_rowid=Helper.correctNull(rs1.getString("fin_rowid"));
								//
								if (formuladesc > 0 )
								{
								    HashMap hshformula =  new HashMap();
									hshformula.put("appno",strValue);
									hshformula.put("sel_divID",sel_divID);
									hshformula.put("formulaid",Integer.toString(formuladesc));
									hshformula.put("curryear",yearselect);
									hshformula.put("prevyear"," ");
									hshformula.put("currfinancialtype",desc);
									hshformula.put("prevfinancialtype","a");
									hshformula.put("internalcalc","N");
									hshformula.put("hshdata",new HashMap());
									//HashMap hshRes = (HashMap)EJBInvoker.executeStateLess("dscr",hshformula,"GetFinValue");
									HashMap hshRes =GetFinValue(hshformula);
									String strTotalValue=correctNull((String)hshRes.get("strTotalValue"));
									vecVal.add(correctNull((String)hshRes.get("strTotalValue")));
									vecid.add(correctNull(rs1.getString("fin_rowid")));
																
									/**
									 * By venu
									 * Storing financial calculated data into tables
									 */
									hshQueryValues=new HashMap();
									intUpdatesize=0;
									hshQuery = new HashMap();
									arrValues=new ArrayList();
									intUpdatesize = intUpdatesize+1;
									if (seloption.equals("fin_audit"))
									{
										hshQuery.put("strQueryId","finappvaluesup1DSCR");
									}
									if (seloption.equals("fin_unaudit"))
									{
										hshQuery.put("strQueryId","finappvaluesup2DSCR");
									}
									if (seloption.equals("fin_estimated"))
									{
										hshQuery.put("strQueryId","finappvaluesup3DSCR");
									}
									if (seloption.equals("fin_projection"))
									{
										hshQuery.put("strQueryId","finappvaluesup4DSCR");
									}
											
									if(seloption.equals("fin_projection"))
									{
										arrValues.add(strTotalValue);//get values from Rowcal field
										arrValues.add(strTotalValue);//get values from Rowcal field
										arrValues.add(strValue);
										arrValues.add(fin_rowid);
										//arrValues.add(sel_divID);
										arrValues.add(yearselect);
															
										hshQuery.put("arrValues",arrValues);						
										hshQueryValues.put("size",Integer.toString(intUpdatesize));
										hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
										EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
									}
									else
									{
										arrValues.add(strTotalValue);//get values from Rowcal field
										arrValues.add(strValue);
										arrValues.add(fin_rowid);
										//arrValues.add(sel_divID);
										arrValues.add(yearselect);
															
										hshQuery.put("arrValues",arrValues);						
										hshQueryValues.put("size",Integer.toString(intUpdatesize));
										hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
										EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
									}
									
															
								}
								hshValues.put("year"+k,vecVal);	
								hshValues.put("vecid"+k,vecid);		
														
						
							}
					
							if(rs1!=null)
							{
								rs1.close();
							}
							vecrec.add(yearselect);
							vecrec.add(seloption);
					}

				}
			}
		}
	}

		/*calculate Avg DSCR 
		 * 
		 */
		strQuery = SQLParser.getSqlQuery("sel_com_finappdscr^"+strValue);	
		if(rs!=null)
		{
		rs.close();	
		}
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			String AvgDSCR="";
			
			double TotDSCR=0.00,avg=0.00;
			double count1=0.00;
			TotDSCR=Double.parseDouble(Helper.correctDouble(rs.getString("avgdscr")));
			
			String str=SQLParser.getSqlQuery("count_finappdscr_year^"+strValue);	
			if(rs1!=null)
			{
				rs1.close();
			}
			rs1=DBUtils.executeQuery(str);
			if(rs1.next())
			{
				count1=Double.parseDouble(Helper.correctInt(rs1.getString("cols")));
			}
			else
			{
				count1=1.00;
			}
			
			if(count1!=0){avg=TotDSCR/count1;}
			AvgDSCR=""+nf.format(avg);
			
			hshQueryValues=new HashMap();
			intUpdatesize=0;
			
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			intUpdatesize = intUpdatesize+1;
			hshQuery.put("strQueryId","finappdscr_avg_del");
			arrValues.add(strValue);
			hshQuery.put("arrValues",arrValues);						
			hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);

			intUpdatesize = intUpdatesize+1;hshQuery = new HashMap();
			hshQuery.put("strQueryId","finappdscr_avg_ins");
			arrValues=new ArrayList();
			arrValues.add(strValue);
			arrValues.add(AvgDSCR);
			hshQuery.put("arrValues",arrValues);						
			
			
			hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
			hshQueryValues.put("size",Integer.toString(intUpdatesize));
			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			hshValues.put("DscrAvg",AvgDSCR);
	
		}
		if(rs!=null){rs.close();}
		
		
	}
		catch(Exception ce)
		{
			ce.printStackTrace();
			throw new EJBException("Error in getData login  "+ce.toString());
			
		}
		finally
		{
			try
			{	
				if(rs != null)
					rs.close();
				if(rs1 != null)
					rs1.close();
				if(rs3 != null)
					rs3.close();
				if(rs4 != null)
					rs4.close();
				if(rs10 != null)
					rs10.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		hshValues.put("tabname",pagetab);

		return hshValues; 
	}
	
	
	public void deleteData(HashMap hsh) 
	{		
		ResultSet rs = null;
		String strQuery="";
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		String year1="",year2="",year3="",year4="",year5="";
		String c1year="",c2year="",c3year="",c4year="",c5year="";
		String chk1="",chk2="",chk3="",chk4="",chk5="";		
		int intUpdatesize =0;		
		String appno="";		
					
		String strDivid="";		
		ResultSet rs1=null;
		String strQuery1="",strQuery2="";
		
		String strpageType="";
		strpageType=Helper.correctNull((String)hsh.get("hidPageName"));
		String strFlag="";
		try
		{				
			appno=correctNull((String)hsh.get("appno"));
			//Added by Kishan
			/*
			String strFinID = "0";
			String cma="0";
			strQuery = SQLParser.getSqlQuery("sel_financeid^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strFinID=Helper.correctNull((String)rs.getString("DEMO_FINSTANDARD"));
				if(!strFinID.equals("")) {
					strQuery = SQLParser.getSqlQuery("fin_cmano_select^"+strFinID);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next()) {
						cma = Helper.correctNull((String)rs.getString("FIN_CMANO"));
					}
				}
			}
			*/
			strDivid=correctNull((String )hsh.get("sel_divID"));
			year1=correctNull((String)hsh.get("txtyear1"));
			year2=correctNull((String)hsh.get("txtyear2"));
			year3=correctNull((String)hsh.get("txtyear3"));
			year4=correctNull((String)hsh.get("txtyear4"));
			year5=correctNull((String)hsh.get("txtyear5"));
			
			c1year=correctNull((String)hsh.get("combo1"));
			c2year=correctNull((String)hsh.get("combo2"));
			c3year=correctNull((String)hsh.get("combo3"));
			c4year=correctNull((String)hsh.get("combo4"));
			c5year=correctNull((String)hsh.get("combo5"));				
			
			chk1=correctNull((String)hsh.get("chk1"));
			chk2=correctNull((String)hsh.get("chk2"));
			chk3=correctNull((String)hsh.get("chk3"));
			chk4=correctNull((String)hsh.get("chk4"));
			chk5=correctNull((String)hsh.get("chk5"));
			
			String strchklen[]={chk1,chk2,chk3,chk4,chk5};
			String stryear []={year1,year2,year3,year4,year5};
			
			if(strDivid.equalsIgnoreCase(""))
			{
				strDivid="0";
			}
		
			int Chkcount=strchklen.length;
						
			if(strpageType.equalsIgnoreCase("DSCR.jsp"))
			{
				strFlag="D";
			}
			else
			{
				strFlag="S";
			}
			String year="";
			for(int i=0;i<Chkcount;i++)
			{
			if (!strchklen[i].equals(""))
			{
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize = intUpdatesize+1;
				if(i==0) year = c1year;
				else if(i==1) year = c2year;
				else if(i==2) year = c3year;
				else if(i==3) year = c4year;
				else if(i==4) year = c5year;
				
				if (year.trim().equalsIgnoreCase("a"))
				{
					if(strFlag.equalsIgnoreCase("D"))
					{
					   hshQuery.put("strQueryId","finappvaluesdel1DSCR");  
					}
					else
					{
						hshQuery.put("strQueryId","finappvaluesdel1DSCRSENS");
						
					}
				}
				if (year.trim().equalsIgnoreCase("u"))
				{
					if(strFlag.equalsIgnoreCase("D"))
					{
					  hshQuery.put("strQueryId","finappvaluesdel2DSCR");
					}
					else
					{
						hshQuery.put("strQueryId","finappvaluesdel2DSCRSENS");
					}
				}
				if (year.trim().equalsIgnoreCase("e"))
				{
					if(strFlag.equalsIgnoreCase("D"))
					{
					   hshQuery.put("strQueryId","finappvaluesdel3DSCR");
					}
					else
					{
						hshQuery.put("strQueryId","finappvaluesdel3DSCRSENS");
						
					}
				}
				if (year.trim().equalsIgnoreCase("p"))
				{
					if(strFlag.equalsIgnoreCase("D"))
					{
					  hshQuery.put("strQueryId","finappvaluesdel4DSCR");
					}
					else
					{
						hshQuery.put("strQueryId","finappvaluesdel4DSCRSENS");
					}
				}
				//hshQuery.put("strQueryId","strQuery1");
				arrValues.add("0");
				arrValues.add(appno);
				arrValues.add(stryear[i]);					
				arrValues.add(strDivid);
				hshQuery.put("arrValues",arrValues);
				if(!year1.equalsIgnoreCase("")){
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
			}
			}
		    intUpdatesize=0;
			hshQueryValues=new HashMap();
			
			if(strFlag.equalsIgnoreCase("D"))
			{
			strQuery = SQLParser.getSqlQuery("finYearSelDSCR^"+appno);
			
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("finYearSelDSCRSENS^"+appno);
				
			}
			//rs = DBUtils.executeQuery(strQuery);
			//while(rs.next())
			//{
				//String strYear=Helper.correctNull(rs.getString("fin_year"));
				
				if(!chk1.equals(""))
				{
					if(strFlag.equalsIgnoreCase("D"))
					{
					  strQuery=SQLParser.getSqlQuery("assessselect9DSCR^"+appno+"^"+year1);
					}
					else
					{
					  strQuery=SQLParser.getSqlQuery("assessselect9DSCRSENS^"+appno+"^"+year1);
						
					}
					
					if(rs1 != null)
					{
						rs1.close();
					}
					 rs1 = DBUtils.executeQuery(strQuery);
					if (rs1.next())
					{
						if(rs1.getDouble("sumaudit")==0 && rs1.getDouble("sumunaudit")==0 && rs1.getDouble("sumestimated")==0 && rs1.getDouble("sumprojection")==0)
						{
							hshQuery = new HashMap();
							arrValues=new ArrayList();
							intUpdatesize = 1;
							if(strFlag.equalsIgnoreCase("D"))
							{
								hshQuery.put("strQueryId","finappvaluesdelDSCR");
							}
							else
							{
								hshQuery.put("strQueryId","finappvaluesdelDSCRSens");
							}
							arrValues.add(appno);
							arrValues.add(year1);
							arrValues.add(strDivid);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}
						
					}
				}
				if(!chk2.equals(""))
				{
					if(strFlag.equalsIgnoreCase("D"))
					{
					  strQuery=SQLParser.getSqlQuery("assessselect9DSCR^"+appno+"^"+year2);
					}
					else
					{
					  strQuery=SQLParser.getSqlQuery("assessselect9DSCRSENS^"+appno+"^"+year2);
						
					}
					
					if(rs1 != null)
					{
						rs1.close();
					}
					 rs1 = DBUtils.executeQuery(strQuery);
					if (rs1.next())
					{
						if(rs1.getDouble("sumaudit")==0 && rs1.getDouble("sumunaudit")==0 && rs1.getDouble("sumestimated")==0 && rs1.getDouble("sumprojection")==0)
						{
							hshQuery = new HashMap();
							arrValues=new ArrayList();
							intUpdatesize = 1;
							if(strFlag.equalsIgnoreCase("D"))
							{
								hshQuery.put("strQueryId","finappvaluesdelDSCR");
							}
							else
							{
								hshQuery.put("strQueryId","finappvaluesdelDSCRSens");
							}
							arrValues.add(appno);
							arrValues.add(year2);
							arrValues.add(strDivid);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}
						
					}
				}
				if(!chk3.equals(""))
				{
					if(strFlag.equalsIgnoreCase("D"))
					{
					  strQuery=SQLParser.getSqlQuery("assessselect9DSCR^"+appno+"^"+year3);
					}
					else
					{
					  strQuery=SQLParser.getSqlQuery("assessselect9DSCRSENS^"+appno+"^"+year3);
						
					}
					
					if(rs1 != null)
					{
						rs1.close();
					}
					 rs1 = DBUtils.executeQuery(strQuery);
					if (rs1.next())
					{
						if(rs1.getDouble("sumaudit")==0 && rs1.getDouble("sumunaudit")==0 && rs1.getDouble("sumestimated")==0 && rs1.getDouble("sumprojection")==0)
						{
							hshQuery = new HashMap();
							arrValues=new ArrayList();
							intUpdatesize = 1;
							if(strFlag.equalsIgnoreCase("D"))
							{
								hshQuery.put("strQueryId","finappvaluesdelDSCR");
							}
							else
							{
								hshQuery.put("strQueryId","finappvaluesdelDSCRSens");
							}
							arrValues.add(appno);
							arrValues.add(year3);
							arrValues.add(strDivid);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}
						
					}
				}
				if(!chk4.equals(""))
				{
					if(strFlag.equalsIgnoreCase("D"))
					{
					  strQuery=SQLParser.getSqlQuery("assessselect9DSCR^"+appno+"^"+year4);
					}
					else
					{
					  strQuery=SQLParser.getSqlQuery("assessselect9DSCRSENS^"+appno+"^"+year4);
						
					}
					
					if(rs1 != null)
					{
						rs1.close();
					}
					 rs1 = DBUtils.executeQuery(strQuery);
					if (rs1.next())
					{
						if(rs1.getDouble("sumaudit")==0 && rs1.getDouble("sumunaudit")==0 && rs1.getDouble("sumestimated")==0 && rs1.getDouble("sumprojection")==0)
						{
							hshQuery = new HashMap();
							arrValues=new ArrayList();
							intUpdatesize = 1;
							if(strFlag.equalsIgnoreCase("D"))
							{
								hshQuery.put("strQueryId","finappvaluesdelDSCR");
							}
							else
							{
								hshQuery.put("strQueryId","finappvaluesdelDSCRSens");
							}
							arrValues.add(appno);
							arrValues.add(year4);
							arrValues.add(strDivid);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}
						
					}
				}
				if(!chk5.equals(""))
				{
					if(strFlag.equalsIgnoreCase("D"))
					{
					  strQuery=SQLParser.getSqlQuery("assessselect9DSCR^"+appno+"^"+year5);
					}
					else
					{
					  strQuery=SQLParser.getSqlQuery("assessselect9DSCRSENS^"+appno+"^"+year5);
						
					}
					
					if(rs1 != null)
					{
						rs1.close();
					}
					 rs1 = DBUtils.executeQuery(strQuery);
					if (rs1.next())
					{
						if(rs1.getDouble("sumaudit")==0 && rs1.getDouble("sumunaudit")==0 && rs1.getDouble("sumestimated")==0 && rs1.getDouble("sumprojection")==0)
						{
							hshQuery = new HashMap();
							arrValues=new ArrayList();
							intUpdatesize = 1;
							if(strFlag.equalsIgnoreCase("D"))
							{
								hshQuery.put("strQueryId","finappvaluesdelDSCR");
							}
							else
							{
								hshQuery.put("strQueryId","finappvaluesdelDSCRSens");
							}
							arrValues.add(appno);
							arrValues.add(year5);
							arrValues.add(strDivid);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}
						
					}
				}
				
				
			//}
			
			/*calculate Avg DSCR 
			 * 
			 */
			if(strFlag.equalsIgnoreCase("D"))
			{
			
			     strQuery = SQLParser.getSqlQuery("sel_com_finappdscr^"+appno);	
				
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("sel_com_finappdscrSENS^"+appno);	
				
				
			}
			
			if(rs!=null)
			{
			rs.close();	
			}
			rs = DBUtils.executeQuery(strQuery);
			
			if(rs.next())
			{
				String AvgDSCR="";
				
				double TotDSCR=0.00,avg=0.00;
				double count1=0.00;
				TotDSCR=Double.parseDouble(Helper.correctDouble(rs.getString("avgdscr")));
				String str="";
				if(strFlag.equalsIgnoreCase("D"))
				{
				   str=SQLParser.getSqlQuery("count_finappdscr_year^"+appno);
				}
				else
				{
				  str=SQLParser.getSqlQuery("count_finappdscrSENS_year^"+appno);
									
				}
				
				if(rs1!=null)
				{
					rs1.close();
				}
				rs1=DBUtils.executeQuery(str);
				if(rs1.next())
				{
					count1=Double.parseDouble(Helper.correctInt(rs1.getString("cols")));
				}
				else
				{
					count1=1.00;
				}
				
				avg=TotDSCR/count1;
				AvgDSCR=""+nf.format(avg);
				
				hshQueryValues=new HashMap();
				intUpdatesize=0;
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize = intUpdatesize+1;
				if(strFlag.equalsIgnoreCase("D"))
				{
				hshQuery.put("strQueryId","finappdscr_avg_del");
				}
				else
				{
					hshQuery.put("strQueryId","finappdscrsens_avg_del");
				}
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);						
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);

				intUpdatesize = intUpdatesize+1;hshQuery = new HashMap();
				if(strFlag.equalsIgnoreCase("D"))
				{
				hshQuery.put("strQueryId","finappdscr_avg_ins");
				}
				else
				{
					hshQuery.put("strQueryId","finappdscrsens_avg_ins");
				}
				arrValues=new ArrayList();
				arrValues.add(appno);
				arrValues.add(AvgDSCR);
				hshQuery.put("arrValues",arrValues);						
				
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				//hshValues.put("DscrAvg",AvgDSCR);
		
			}
			if(rs!=null){rs.close();}
		}
		catch (Exception e)
		{
			log.error("in bean"+e);
		}
		finally
		{
			try
			{
				
				if(rs != null)
				{
					rs.close();
				}
				if(rs1 != null)
				{
					rs1.close();
				}
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
						
			}
		}
	
		
	}
    private HashMap GetFinValue(HashMap hashtable)
    {  
    	String strColName="",strFrom="",strTo="",strFormulaApply="",strIsQisFormula="";
        ResultSet resultset = null;
        ResultSet resultset1 = null;
        ResultSet resultset2 = null;
        ResultSet resultset3 = null;
        ResultSet resultset4 = null;
        HashMap hashtable1 = new HashMap();
        String s16 = "";
        String s17 = "";
        String strpagetype="";
        ArrayList ArrayList = new ArrayList();        
        NumberFormat numberformat = NumberFormat.getNumberInstance();
        numberformat.setGroupingUsed(false);
        numberformat.setMaximumFractionDigits(2);
        numberformat.setMinimumFractionDigits(2);
        try
        {
            try
            {              
              
            	String sel_divID = correctNull((String)hashtable.get("sel_divID"));
                String s5 = correctNull((String)hashtable.get("appno"));
                String s7 = correctNull((String)hashtable.get("formulaid"));
                String s9 = correctNull((String)hashtable.get("curryear"));
                String s11 = correctNull((String)hashtable.get("prevyear"));
                String s13 = correctNull((String)hashtable.get("currfinancialtype"));
                String s15 = correctNull((String)hashtable.get("prevfinancialtype"));
                String s27 = correctNull((String)hashtable.get("isstress"));
                String s29 = correctNull((String)hashtable.get("ratiostress"));
                strColName = correctNull((String)hashtable.get("colname"));
                strFrom = correctNull((String)hashtable.get("datefrom"));
                strTo = correctNull((String)hashtable.get("dateto"));
                strFormulaApply = correctNull((String)hashtable.get("formulaapply"));
                strpagetype=correctNull((String)hashtable.get("pagetype")); //added by gaensan for Sensitivity Analysis  
                HashMap hashtable3 = (HashMap)hashtable.get("hshdata");
                hashtable3.put("pagetype", strpagetype);
                String s1 = SQLParser.getSqlQuery("selfinformula^" + s7);
                if(resultset!=null)
                	resultset.close();	               	
              
                resultset = DBUtils.executeQuery(s1);
                if(resultset.next())
                {
                    s7 = correctNull(resultset.getString("formula"));
                    s16 = correctNull(resultset.getString("formula_for"));
                    if(s29.trim().equalsIgnoreCase("Y"))
                        s16 = "CA";
                    s17 = correctNull(resultset.getString("formula_for_type"));
                }
                else
                {
                    s7 = "";
                }
                if(strFormulaApply.trim().equalsIgnoreCase("QIS1") || strFormulaApply.trim().equalsIgnoreCase("QIS2"))
                    strIsQisFormula = "Y";
                else
                    strIsQisFormula = "N";
                String s21;
                if(s17.equals("GT") || s17.equals("NFL") || s17.equals("LTS"))
                    s21 = "Y";
                else
                    s21 = "N";
                String s19;
                if(!s7.equals(""))
                {
                    if(s7.indexOf("?") != -1)
                    {
                        String s23 = s17;
                        String s25 = s16;
                        s19 = getComapreValues(s5, s7, s9, s11, s13, s15, hashtable3, s23, s25, s27);
                        ArrayList = new ArrayList();
                        for(int i = 0; i < 4; i++)
                            ArrayList.add("0.00");

                        hashtable1.put("vecTemp", ArrayList);
                    }
                    else
                    if(s16.equals("CA") && (s17.equals("I") || s17.equals("D")))
                    {
                        double d7;
                        if(s7.indexOf("~") == -1)
                        {
                            hashtable1 = FormulaParser(s5, s7, s16, s17, s9, s11, s13, s15, s21, hashtable3, s27,sel_divID);
                            double d1 = Double.parseDouble((String)hashtable1.get("strTotalValue"));
                            s9 = s11;
                            s13 = s15;
                            hashtable1 = FormulaParser(s5, s7, s16, s17, s9, s11, s13, s15, s21, hashtable3, s27,sel_divID);
                            double d4 = Double.parseDouble((String)hashtable1.get("strTotalValue"));
                            d7 = d1 - d4;
                        }
                        else
                        {
                            hashtable1 = FormulaParser(s5, s7, s16, s17, s9, s11, s13, s15, s21, hashtable3, s27,sel_divID);
                            d7 = Double.parseDouble((String)hashtable1.get("strTotalValue"));
                        }
                        
                        if(correctNull(s17).equals("I"))
                        {
                            if(d7 < 0.0D)
                            	d7 = 0.0D;
                        }
                        else
                        if(correctNull(s17).equals("D") && d7 != 0.0D)
                            if(d7 > 0.0D)
                            	d7 = 0.0D;
                            else
                            	d7 *= -1D;
                        s19 = Helper.formatDoubleValue(d7);
                    }
                    else if(s16.equals("FU") && (s17.equals("I") || s17.equals("D") || s17.equals("ID")))
                    {
                        double d8;
                        if(s7.indexOf("~") == -1)
                        {
                            hashtable1 = FormulaParser(s5, s7, s16, s17, s9, s11, s13, s15, s21, hashtable3, s27,sel_divID);
                            double d2 = Double.parseDouble((String)hashtable1.get("strTotalValue"));
                            s9 = s11;
                            s13 = s15;
                            hashtable1 = FormulaParser(s5, s7, s16, s17, s9, s11, s13, s15, s21, hashtable3, s27,sel_divID);
                            double d5 = Double.parseDouble((String)hashtable1.get("strTotalValue"));
                            d8 = d2 - d5;
                        }
                        else
                        {
                            hashtable1 = FormulaParser(s5, s7, s16, s17, s9, s11, s13, s15, s21, hashtable3, s27,sel_divID);
                            d8 = Double.parseDouble((String)hashtable1.get("strTotalValue"));
                        }
                        if(correctNull(s17).equals("I"))
                        {
                            if(d8 < 0.0D)
                                d8 = 0.0D;
                        }
                        else
                        if(correctNull(s17).equals("D") && d8 != 0.0D)
                            if(d8 > 0.0D)
                                d8 = 0.0D;
                            else
                                d8 *= -1D;
                        s19 = Helper.formatDoubleValue(d8);
                    }
                    else
                    {                        
                        if(s16.trim().equals("RA"))
                        {
                            String s2 = SQLParser.getSqlQuery("selrayearDSCR^" + s5 + "^<^" + s9); 
                        	
                            if(resultset3!=null)
                            	resultset3.close();	
                        
                            resultset3 = DBUtils.executeQuery(s2);
                            String s30 = "";
                            String s31 = "";
                            if(resultset3.next())
                            {
                                String s33 = correctNull(resultset3.getString(1));
                                double d12 = resultset3.getDouble(2);
                                double d13 = resultset3.getDouble(3);
                                double d14 = resultset3.getDouble(4);
                                double d15 = resultset3.getDouble(5);
                                if(s33 != "" && d12 > 0.0D)
                                {
                                    s30 = s33;
                                    s31 = "a";
                                }
                                else
                                if(s33 != "" && d13 > 0.0D)
                                {
                                    s30 = s33;
                                    s31 = "u";
                                }
                                else
                                if(s33 != "" && d14 > 0.0D)
                                {
                                    s30 = s33;
                                    s31 = "e";
                                }
                                else
                                if(s33 != "" && d15 > 0.0D)
                                {
                                    s30 = s33;
                                    s31 = "p";
                                }
                            }
                            s11 = s30;
                            s15 = s31;
                        }
                        hashtable1 = FormulaParser(s5, s7, s16, s17, s9, s11, s13, s15, s21, hashtable3, s27,sel_divID);
                        s19 = (String)hashtable1.get("strTotalValue");
                        if(s16.equals("FU") && s17.equals("NFL"))
                        {
                            double d9 = Double.parseDouble(s19);
                            if(d9 > 0.0D)
                                d9 = 0.0D;
                            s19 = Helper.formatDoubleValue(d9);
                        }
                        else
                        if(s16.equals("FU") && s17.equals("LTS"))
                        {
                            double d10 = Double.parseDouble(s19);
                            if(d10 < 0.0D)
                                d10 = 0.0D;
                            s19 = Helper.formatDoubleValue(d10);
                        }
                    }
                    ArrayList = (ArrayList)hashtable1.get("vecTemp");
                }
                else
                {
                    s19 = "0.00";
                }
                if(s16.trim().equalsIgnoreCase("RHP"))
                {
                    int j = 0;
                    String s3;
                    if(s11.trim().equals(""))
                    {
                        s3 = SQLParser.getSqlQuery("selholdingdaysDSCR^" + s9 + "^" + s5 + "^<^" + s9);
                    }
                    else
                    {
                        s3 = SQLParser.getSqlQuery("selyeardateDSCR^" + s5 + "^" + s11);
                      
                        if(resultset1!=null)
                        	resultset1.close();	
                      
                        resultset1 = DBUtils.executeQuery(s3);
                        String s32 = "";
                        if(resultset1.next())
                            s32 = correctNull(resultset1.getString("fin_year"));
                        s3 = SQLParser.getSqlQuery("selyeardateDSCR^" + s5 + "^" + s9);
                    
                        if(resultset2!=null)
                        	resultset2.close();	
                      
                        resultset2 = DBUtils.executeQuery(s3);
                        String s34 = "";
                        if(resultset2.next())
                            s34 = correctNull(resultset2.getString("fin_year"));
                        s3 = SQLParser.getSqlQuery("selholdingdays1DSCR^" + s32 + "^" + s34 + "^" + s5 + "^<^" + s9);
                    }
                    if(resultset4!=null)
                    	resultset4.close();	
                  
                    resultset4 = DBUtils.executeQuery(s3);
                    if(resultset4.next())
                        j = resultset4.getInt(1);
                    else
                        j = 365;
                    double d11 = Double.parseDouble(s19);
                    d11 *= j;
                    s19 = Helper.formatDoubleValue(d11);
                }
                s19 = numberformat.format(Double.parseDouble(Helper.correctDouble(s19)));
                hashtable1 = new HashMap();
                hashtable1.put("strTotalValue", s19);
                hashtable1.put("vecTemp", ArrayList);
                hashtable1.put("strisInternalCalc", s21);
            }
            catch(Exception exception)
            {
                throw new EJBException("Error in GetFinValue =" + exception.toString());
            }
        }
        finally
        {
            try
            {
                if(resultset != null)
                    resultset.close();
                if(resultset1 != null)
                    resultset1.close();
                if(resultset2 != null)
                    resultset2.close();
                if(resultset3 != null)
                    resultset3.close();
                if(resultset4 != null)
                    resultset4.close();
              
            }
            catch(Exception exception2)
            {
                throw new EJBException("Error closing the connection " + exception2.getMessage());
            }
        }
        return hashtable1;
    }
    private String getComapreValues(String s, String s1, String s2, String s3, String s4, String s5, HashMap hashtable, 
            String s6, String s7, String s8)
        
    {       
        ResultSet rs = null;
        char c = ' ';
        String s17 = "";
        HashMap hashtable3 = new HashMap();
        try
        {
            try
            {               
                String s10 = s1;
                String s12 = s10.replace('<', c).replace('(', c).replace(')', c).replace('>', c);
                s12 = s12.trim();
                StringTokenizer stringtokenizer = new StringTokenizer(s12, "$");
                String s14 = "";
                String s16 = "";
                s14 = stringtokenizer.nextToken();
                s16 = stringtokenizer.nextToken();
                s16 = s16.substring(2, s16.length());
                hashtable3.put("appno", s);
                hashtable3.put("formulaid", s14);
                hashtable3.put("curryear", s2);
                hashtable3.put("prevyear", s3);
                hashtable3.put("currfinancialtype", s4);
                hashtable3.put("prevfinancialtype", s5);
                hashtable3.put("isstress", s8);
                hashtable3.put("hshdata", new HashMap());
                HashMap hashtable2 = GetFinValue(hashtable3);
                
                double d1 = Double.parseDouble((String)hashtable2.get("strTotalValue"));
                hashtable3 = new HashMap();
                hashtable3.put("appno", s);
                hashtable3.put("formulaid", s16);
                hashtable3.put("curryear", s2);
                hashtable3.put("prevyear", s3);
                hashtable3.put("currfinancialtype", s4);
                hashtable3.put("prevfinancialtype", s5);
                hashtable2.put("isstress", s8);
                hashtable3.put("hshdata", new HashMap());
                hashtable2 = GetFinValue(hashtable3);
               
                double d3 = Double.parseDouble((String)hashtable2.get("strTotalValue"));
                if(s6.equals("H"))
                {
                    if(d1 < d3)
                        d1 = d3;
                }
                else
                if(s6.equals("L") && d1 > d3)
                    d1 = d3;
                s17 = Helper.formatDoubleValue(d1);
            }
            catch(Exception exception)
            {
                throw new EJBException("Error in GetCompare " + exception.getMessage());
            }
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
            catch(Exception exception2)
            {
                throw new EJBException("Error closing the connection " + exception2.getMessage());
            }
        }
        return s17;
    }
    private HashMap FormulaParser(String s, String s1, String s2, String s3, String s4, String s5, String s6, 
            String s7, String s8, HashMap hashtable, String s9,String sel_divID)
        
    {
       
		ResultSet rs = null;
        HashMap hashtable1 = new HashMap();
        String s11 = "0.00";
        char c = ' ';
        String s23 = "";
        
        int l1 = 0;
        int i2 = 0;
        
        ArrayList ArrayList = new ArrayList();
        
        NumberFormat numberformat = NumberFormat.getNumberInstance();
        numberformat.setGroupingUsed(false);
        numberformat.setMaximumFractionDigits(2);
        numberformat.setMinimumFractionDigits(2);
        try
        {
            try
            {
                for(int j2 = 0; j2 < 4; j2++)
                    ArrayList.add("0.00");

                StringTokenizer stringtokenizer = new StringTokenizer(s1, "$");
                String s25 = stringtokenizer.nextToken();
                int i = s25.indexOf("*");
                while(s1.indexOf("$") != -1 || s1.indexOf("~") != -1) 
                {
                    String s13 = s1;
                    int j1 = s13.indexOf(">");
                    int l = s13.indexOf("<", l1);
                    i = s13.indexOf("<", l1);
                    while(l < j1) 
                    {
                        l = s13.indexOf("<", l1);
                        if(l < s13.lastIndexOf("<") && l < j1)
                        {
                            i = s13.indexOf("<", l1);
                            l1 = l + 1;
                            continue;
                        }
                        if(l > j1)
                            l = i;
                        break;
                    }

                    l1 = 0;
                    String s17 = s13.substring(l - 1, j1 + 1);
                    String s26 = s17.replace('<', c).replace('(', c).replace(')', c).replace('>', c);
                    s26 = s26.trim();
                    StringTokenizer stringtokenizer3 = new StringTokenizer(s26, "$");
                    String s31 = "";
                    String s34 = "";
                    String s21 = "";
                    while(stringtokenizer3.hasMoreTokens()) 
                    {
                        String s27 = stringtokenizer3.nextToken();
                        if(s27.indexOf("~") != -1)
                        {
                            s27 = s27 + "$";
                            for(StringTokenizer stringtokenizer4 = new StringTokenizer(s27, "~"); stringtokenizer4.hasMoreTokens();)
                            {
                                s27 = stringtokenizer4.nextToken();
                                if(!s27.equals("$"))
                                    if(s27.indexOf("&") != -1)
                                    {
                                        i = s27.indexOf("&");
                                        s21 = s27.substring(i - 1, i);
                                        s31 = s27.substring(0, i);
                                        s34 = s27.substring(i + 1);
                                        if(s34.indexOf("$") != -1)
                                        {
                                            s34 = s34.replace('$', c).trim();
                                            s27 = s27.replace('$', c).trim();
                                            HashMap hashtable3 = getStrIDValue(s27, s31, s34, s23, s21, s, s4, s6, s8, hashtable, ArrayList, s4, s5, s6, s7, s9,sel_divID);
                                            s23 = (String)hashtable3.get("strIdValues");
                                            ArrayList = (ArrayList)hashtable3.get("vecTemp");
                                        }
                                        else
                                        {
                                            HashMap hashtable4 = getStrIDValue(s27, s31, s34, s23, s21, s, s5, s7, s8, hashtable, ArrayList, s4, s5, s6, s7, s9,sel_divID);
                                            s23 = (String)hashtable4.get("strIdValues");
                                            ArrayList = (ArrayList)hashtable4.get("vecTemp");
                                        }
                                        s21 = "";
                                    }
                                    else
                                    {
                                        HashMap hashtable5 = getStrIDValue(s27, s31, s34, s23, s21, s, s5, s7, s8, hashtable, ArrayList, s4, s5, s6, s7, s9,sel_divID);
                                        s23 = (String)hashtable5.get("strIdValues");
                                        ArrayList = (ArrayList)hashtable5.get("vecTemp");
                                        s21 = "";
                                    }
                            }

                        }
                        else
                        {
                            if(s27.indexOf("&") != -1)
                            {
                                i = s27.indexOf("&");
                                s21 = s27.substring(i - 1, i);
                                s31 = s27.substring(0, i);
                                s34 = s27.substring(i + 1);
                            }
                            HashMap hashtable6 = getStrIDValue(s27, s31, s34, s23, s21, s, s4, s6, s8, hashtable, ArrayList, s4, s5, s6, s7, s9,sel_divID);
                            s23 = (String)hashtable6.get("strIdValues");
                            ArrayList = (ArrayList)hashtable6.get("vecTemp");
                        }
                    }

                    s23 = s23 + "#";
                    StringBuffer stringbuffer1 = new StringBuffer(s1);
                    stringbuffer1 = stringbuffer1.replace(l - 1, j1 + 1, s23);
                    s1 = stringbuffer1.toString();
                }

                s11 = s1;
                i = 0;
                l1 = 0;                
                
                double d1 = 0.0D;
                
                if(s1.indexOf("&") != -1)
                    s11 = "0.00";
                while(s1.indexOf("&") != -1) 
                {
                    String s15 = s1;
                    int k1 = s15.indexOf(">");
                    int i1 = s15.indexOf("<", l1);
                    int j = s15.indexOf("<", l1);
                    while(i1 < k1) 
                    {
                        i1 = s15.indexOf("<", l1);
                        if(i1 < s15.lastIndexOf("<") && i1 < k1)
                        {
                            j = s15.indexOf("<", l1);
                            l1 = i1 + 1;
                            continue;
                        }
                        if(i1 > k1)
                            i1 = j;
                        break;
                    }

                    l1 = 0;
                    String s19 = s15.substring(i1 - 1, k1 + 1);
                    String s28 = s19.replace('<', c).replace('(', c).replace(')', c).replace('>', c);
                    s28 = s28.trim();
                    StringTokenizer stringtokenizer2 = new StringTokenizer(s28, "#");
                    
                    while(stringtokenizer2.hasMoreTokens()) 
                    {
                        String s29 = stringtokenizer2.nextToken();
                        i2++;
                        if(s29.indexOf("&") != -1)
                        {
                            int k = s29.indexOf("&");
                            String s22 = s29.substring(k - 1, k);
                            String s36 = s29.substring(k + 1);
                            if(s22.equals("+"))
                                s11 = Helper.formatDoubleValue(Double.parseDouble(s11) + Double.parseDouble(s36));
                            else
                            if(s22.equals("-"))
                                s11 = Helper.formatDoubleValue(Double.parseDouble(s11) - Double.parseDouble(s36));
                            else
                            if(s22.equals("*"))
                            {
                                if(!s36.equals("0"))
                                {
                                    double d4 = Double.parseDouble(s36);
                                    if(d4 != 0.0D)
                                        d1 = Double.parseDouble(s11) * Double.parseDouble(s36);
                                    else
                                        d1 = 0.0D;
                                    if(Double.isNaN(d1) || Double.isInfinite(d1))
                                        s11 = "0.00";
                                    else
                                        s11 = Helper.formatDoubleValue(d1);
                                }
                            }
                            else
                            if(s22.equals("/") && !s36.equals("0"))
                            {
                                double d5 = Double.parseDouble(s36);
                                if(d5 != 0.0D)
                                    d1 = Double.parseDouble(s11) / Double.parseDouble(s36);
                                else
                                    d1 = 0.0D;
                                if(Double.isNaN(d1) || Double.isInfinite(d1))
                                    s11 = "0.00";
                                else
                                    s11 = Helper.formatDoubleValue(d1);
                            }
                        }
                        else
                        {
                            s11 = Helper.formatDoubleValue(Double.parseDouble("0.00") + Double.parseDouble(s29));
                        }
                    }

                    s11 = s11 + "#";
                    StringBuffer stringbuffer = new StringBuffer(s1);
                    stringbuffer = stringbuffer.replace(i1 - 1, k1 + 1, s11);
                    s11 = s11.replace('#', c).trim();
                    s1 = stringbuffer.toString();
                    stringtokenizer2 = new StringTokenizer(s1, "&");
                }

                s11 = s11.replace('#', c).trim();
                d1 = Double.parseDouble(s11);
                s11 = Helper.formatDoubleValue(d1);
                s11 = numberformat.format(Double.parseDouble(Helper.correctDouble(s11)));
            }
            catch(Exception exception)
            {
                throw new EJBException("Error in FormulaParser =" + exception.toString());
            }
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
            catch(Exception exception2)
            {
                throw new EJBException("Error closing the connection " + exception2.getMessage());
            }
        }
        hashtable1.put("strTotalValue", s11);
        hashtable1.put("vecTemp", ArrayList);
        return hashtable1;
    }
    private HashMap getStrIDValue(String s, String s1, String s2, String s3, String s4, String s5, String s6, 
            String s7, String s8, HashMap hashtable, ArrayList ArrayList, String s9, String s10, String s11, 
            String s12, String s13,String sel_divID)
        
    {
        HashMap hashtable1 = new HashMap();
        HashMap hashtable2 = new HashMap();
      String   strpagetype=correctNull((String)hashtable.get("pagetype"));
        if(!s1.trim().equals("") && s1.indexOf("#") != -1)
        {
            int i = s1.indexOf("#");
            s3 = s.substring(0, i);
        }
        if(!s2.trim().equals("") && s2.indexOf("#") != -1)
        {
            int j = s2.indexOf("#");
            if(s4.length() != 0)
            {
                if(s4.equals("+"))
                    s3 = Helper.formatDoubleValue(Double.parseDouble(s3) + Double.parseDouble(s2.substring(0, j)));
                if(s4.equals("-"))
                    s3 = Helper.formatDoubleValue(Double.parseDouble(s3) - Double.parseDouble(s2.substring(0, j)));
                if(s4.equals("*"))
                {
                    double d6 = Double.parseDouble(s3) * Double.parseDouble(s2.substring(0, j));
                    if(Double.isNaN(d6) || Double.isInfinite(d6))
                        s3 = "0.00";
                    else
                        s3 = Helper.formatDoubleValue(d6);
                }
                if(s4.equals("/"))
                {
                    double d7 = Double.parseDouble(s3) / Double.parseDouble(s2.substring(0, j));
                    if(Double.isNaN(d7) || Double.isInfinite(d7))
                        s3 = "0.00";
                    else
                        s3 = Helper.formatDoubleValue(d7);
                }
            }
            s2 = "0";
        }
        if(s4.length() == 0)
        {
            if(!s8.equals("Y"))
            {
                s3 = getIDData(s5, s6, s, s7, s13,sel_divID,strpagetype);
            }
            else
            {
                s3 = "0.00";
                hashtable2.put("appno", s5);
                hashtable2.put("formulaid", s);
                hashtable2.put("curryear", s9);
                hashtable2.put("prevyear", s10);
                hashtable2.put("currfinancialtype", s11);
                hashtable2.put("prevfinancialtype", s12);
                hashtable2.put("isstress", s13);
                hashtable2.put("hshdata", new HashMap());
                hashtable2 = GetFinValue(hashtable2);
                s3 = (String)hashtable2.get("strTotalValue");
            }
        }
        else
        if(s4.equals("+"))
        {
            if(!s8.equals("Y"))
            {
            	String temp="";
            	temp=Helper.correctDouble(getIDData(s5, s6, s2, s7, s13,sel_divID,strpagetype));
                s3=Helper.formatDoubleValue(Double.parseDouble(s3) +Double.parseDouble(temp));
            }
            else
            {
                hashtable2.put("appno", s5);
                hashtable2.put("formulaid", s2);
                hashtable2.put("curryear", s9);
                hashtable2.put("prevyear", s10);
                hashtable2.put("currfinancialtype", s11);
                hashtable2.put("prevfinancialtype", s12);
                hashtable2.put("isstress", s13);
                hashtable2.put("hshdata", new HashMap());
                hashtable2 = GetFinValue(hashtable2);
                s3 = Helper.formatDoubleValue(Double.parseDouble(s3) + Double.parseDouble((String)hashtable2.get("strTotalValue")));
            }
        }
        else
        if(s4.equals("-"))
        {
            if(!s8.equals("Y"))
            {
                s3 = Helper.formatDoubleValue(Double.parseDouble(s3) - Double.parseDouble(getIDData(s5, s6, s2, s7, s13,sel_divID,strpagetype)));
            }
            else
            {
                hashtable2.put("appno", s5);
                hashtable2.put("formulaid", s2);
                hashtable2.put("curryear", s9);
                hashtable2.put("prevyear", s10);
                hashtable2.put("currfinancialtype", s11);
                hashtable2.put("prevfinancialtype", s12);
                hashtable2.put("isstress", s13);
                hashtable2.put("hshdata", new HashMap());
                hashtable2 = GetFinValue(hashtable2);
                s3 = Helper.formatDoubleValue(Double.parseDouble(s3) - Double.parseDouble((String)hashtable2.get("strTotalValue")));
            }
        }
        else
        if(s4.equals("*"))
        {
            if(!s2.equals("0"))
                if(!s8.equals("Y"))
                {
                    double d8 = Double.parseDouble(getIDData(s5, s6, s2, s7, s13,sel_divID,strpagetype));
                    double d1;
                    if(d8 != 0.0D)
                        d1 = Double.parseDouble(s3) * d8;
                    else
                        d1 = 0.0D;
                    if(Double.isNaN(d1) || Double.isInfinite(d1))
                        s3 = "0.00";
                    else
                        s3 = Helper.formatDoubleValue(d1);
                }
                else
                {
                    hashtable2.put("appno", s5);
                    hashtable2.put("formulaid", s2);
                    hashtable2.put("curryear", s9);
                    hashtable2.put("prevyear", s10);
                    hashtable2.put("currfinancialtype", s11);
                    hashtable2.put("prevfinancialtype", s12);
                    hashtable2.put("isstress", s13);
                    hashtable2.put("hshdata", new HashMap());
                    hashtable2 = GetFinValue(hashtable2);
                    double d9 = Double.parseDouble((String)hashtable2.get("strTotalValue"));
                    double d2;
                    if(d9 != 0.0D)
                        d2 = Double.parseDouble(s3) * d9;
                    else
                        d2 = 0.0D;
                    if(Double.isNaN(d2) || Double.isInfinite(d2))
                        s3 = "0.00";
                    else
                        s3 = Helper.formatDoubleValue(d2);
                }
        }
        else
        if(s4.equals("/") && !s2.equals("0"))
            if(!s8.equals("Y"))
            {
                double d10 = Double.parseDouble(getIDData(s5, s6, s2, s7, s13,sel_divID,strpagetype));
                double d3;
                if(d10 != 0.0D)
                    d3 = Double.parseDouble(s3) / d10;
                else
                    d3 = 0.0D;
                if(Double.isNaN(d3) || Double.isInfinite(d3))
                    s3 = "0.00";
                else
                    s3 = Helper.formatDoubleValue(d3);
            }
            else
            {
                hashtable2.put("appno", s5);
                hashtable2.put("formulaid", s2);
                hashtable2.put("curryear", s9);
                hashtable2.put("prevyear", s10);
                hashtable2.put("currfinancialtype", s11);
                hashtable2.put("prevfinancialtype", s12);
                hashtable2.put("isstress", s13);
                hashtable2.put("hshdata", new HashMap());
                hashtable2 = GetFinValue(hashtable2);
                double d11 = Double.parseDouble((String)hashtable2.get("strTotalValue"));
                double d4;
                if(d11 != 0.0D)
                    d4 = Double.parseDouble(s3) / d11;
                else
                    d4 = 0.0D;
                if(Double.isNaN(d4) || Double.isInfinite(d4))
                    s3 = "0.00";
                else
                    s3 = Helper.formatDoubleValue(d4);
            }
        hashtable1.put("strIdValues", s3);
        hashtable1.put("vecTemp", ArrayList);
        return hashtable1;
    }
    private String getIDData(String s, String s1, String s2, String s3, String s4,String sel_divID,String strpagetype)
    
{  
	
	
    ResultSet resultset = null;
    String s5 = "";
    String s6 = "";
    String s7 = "";
    String s8 = "Y";
    String s12 = "0.00";
    double d2 = 0.0D;
    if(!s8.equals(""))
        s8 = s4;
    try
    {
        try
        {
         
                if(s3.equalsIgnoreCase("A"))
                    s7 = "fin_audit";
                else
                if(s3.equalsIgnoreCase("U"))
                    s7 = "fin_unaudit";
                else
                if(s3.equalsIgnoreCase("E"))
                    s7 = "fin_estimated";
                else
                if(s3.equalsIgnoreCase("P"))
                    s7 = "fin_projection";
                else
                    if(s3.equalsIgnoreCase("S"))//By venu for sensitive analysis--[projection year only]
                          s7 = "fin_stress_projection"; 
                
                if(s8.equals("Y") && (s3.equals("E") || s3.equals("P")))
                {
                    s5 = SQLParser.getSqlQuery("selstressvaluesDSCR^" + s2);
                    if(resultset!=null)
                    	resultset.close();
                 
                    resultset = DBUtils.executeQuery(s5);
                    if(resultset.next())
                    {
                        s12 = resultset.getString("fin_stress_percent");
                    }
                    else
                    {
                        s12 = "0.00";
                    }
                }
                double d1 = (100D - Double.parseDouble(s12)) / 100D;
                if(Double.isNaN(d1) || Double.isInfinite(d1))
                    d1 = 1.0D;
                if(!s7.trim().equals("") && !s.trim().equals("") && !s1.trim().equals("") && !s2.trim().equals(""))
                {
                	
                	if(sel_divID.equalsIgnoreCase(""))
                	{
                		sel_divID="0";
                	}
                	
//                	modified by S.SATHYA MOORTHY FOR EXCEPTION OCCURRED IN THE CASH FLOW AND FINANICAL PAGE.
                	if(s1.length()<=4)
                	{
                    s5 = SQLParser.getSqlQuery("selfinformulavalues_cashflowDSCR^" + s7 + "^" + s + "^" + s1 + "^" + s2+"^"+sel_divID);
                	}
                	else if(strpagetype.equalsIgnoreCase("SENS"))
                	{
                		s5 = SQLParser.getSqlQuery("selfinformulavaluesDSCRSENS^" + s7 + "^" + s + "^" + s1 + "^" + s2+"^"+sel_divID);
                	}
                	else
                	{
                		s5 = SQLParser.getSqlQuery("selfinformulavaluesDSCR^" + s7 + "^" + s + "^" + s1 + "^" + s2+"^"+sel_divID);
                		
                	}
                    if(resultset != null)
                        resultset.close();
                 
                    resultset = DBUtils.executeQuery(s5);
                    if(resultset.next())
                        s6 = resultset.getString("columname");
                }
                if(s6.equals(""))
                    s6 = "0.00";
                s6 = Helper.formatDoubleValue(Double.parseDouble(s6) * d1);
                d2 = Double.parseDouble(s6);
           
            if(Double.isNaN(d2) || Double.isInfinite(d2))
                s6 = "0.00";
        }
        catch(Exception exception)
        {
            throw new EJBException("Error in getIDData =" + exception.toString());
        }
    }
    finally
    {
        try
        {
            if(resultset != null)
                {
            	resultset.close();
                }
         
        }
        catch(Exception exception2)
        {
            throw new EJBException("Error closing the connection getIDData " + exception2.getMessage());
        }
    }
    return s6;
}
    public HashMap getPrintValues(HashMap hshRequestValues) 
    {
    	ResultSet rs=null;
    	ResultSet rs1=null;
    	ResultSet rs2=null;
    	String strQuery="",appno="",strQuery1="";
    	HashMap hshValues=new HashMap();
    	ArrayList vecRec=new ArrayList();
    	ArrayList vecVal=new ArrayList();
    	String tempsno="",year1="";
    	ArrayList vecYear=new ArrayList();
    	ArrayList VecValue=new ArrayList();
    	double sumaudit=0.00,sumunaudit=0.00,sumestimated=0.00,sumprojection=0.00;
    	String FinType="";
    	try
    	{
    		appno=correctNull((String)hshRequestValues.get("appno"));
    		
    		strQuery = SQLParser.getSqlQuery("finselect2a^"+"1"+"^"+"DSCR");
			
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
					vecRec = new ArrayList();
					vecRec.add(correctNull(rs.getString("fin_rowid")));
					vecRec.add(correctNull(rs.getString("fin_rowdesc")));
					vecRec.add(correctNull(rs.getString("fin_rowtype")));
					tempsno = correctNull(rs.getString("fin_sno"));
					if (tempsno.trim().equals(""))
					{
						tempsno=" ";
					}
					
					vecRec.add(tempsno);
					vecVal.add(vecRec);								
			}
			hshValues.put("labeldetails",vecVal);
			vecVal=new ArrayList();
			if(rs != null)
			{
				rs.close();
			}
		
			strQuery1=SQLParser.getSqlQuery("finYearSelDSCR^"+appno);
			rs1=DBUtils.executeQuery(strQuery1);
			while(rs1.next())
			{
				year1=Helper.correctNull((String)rs1.getString("fin_year"));
				if(rs!=null){rs.close();}
				strQuery=SQLParser.getSqlQuery("com_finappdscr_print_sel^"+appno+"^"+year1);
				rs=DBUtils.executeQuery(strQuery);
				VecValue=new ArrayList();
				vecYear=new ArrayList();
				while(rs.next())
				{
					String tempValue=""+nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("fin_value"))));
					VecValue.add(tempValue);
				}
				
				
				if(rs2!=null){rs.close();}
				strQuery = SQLParser.getSqlQuery("assessselect9DSCR^"+appno+"^"+year1);
				rs2=DBUtils.executeQuery(strQuery);
				if (rs2.next())
				{
					 sumaudit=Double.parseDouble(Helper.correctDouble(rs2.getString("sumaudit")));
					 sumunaudit=Double.parseDouble(Helper.correctDouble(rs2.getString("sumunaudit")));
					 sumestimated=Double.parseDouble(Helper.correctDouble(rs2.getString("sumestimated")));
					 sumprojection=Double.parseDouble(Helper.correctDouble(rs2.getString("sumprojection")));
				}
				if(sumaudit>0.00)
				{
					FinType="Audited";
				}
				else if(sumunaudit>0.00)
				{ 
					FinType="Unaudited / Provisional";
				}
				else if(sumestimated>0.00)
				{
					FinType="Estimated";
				}
				else
				{
					FinType="Projection";
				}
				vecYear.add(year1);
				vecYear.add(FinType);
				vecYear.add(VecValue);
				vecVal.add(vecYear);
			}
			hshValues.put("TableValues", vecVal);
			if(rs2!=null)
			{
				rs2.close();
			}
			if(rs!=null){rs.close();}
			
			strQuery = SQLParser.getSqlQuery("com_finappdscr_Avg_sel^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshValues.put("DscrAvg", nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("com_avgdscr")))));
			}
			else
			{
				hshValues.put("DscrAvg", "0.00");
			}
			
    		if(rs!=null)
    		{
    			rs.close();
    		}
    		if(rs1!=null)
    		{
    			rs1.close();
    		}
    	}catch(Exception ex)
    	{
    		throw new EJBException("Exception in getPrintValues : "+ex);
    	}
    	
    	
    	return hshValues;
    }

    public HashMap getDataAssessment(HashMap hshRequestValues) 
	{
		
		ResultSet rs = null;
		ResultSet rs1 = null;		
		ResultSet rs3 = null;
		ResultSet rsPrevYear =null;
		ResultSet rsFormulaFor =null;	
		HashMap hshValues=null;
		String strQuery="",strValue="",strAppName="";
		int str=0;
		
		
	try
	{			
		strValue=correctNull((String)hshRequestValues.get("appno"));		
		hshValues = new HashMap();
		ArrayList vecVal=new ArrayList();
		ArrayList vecRec=new ArrayList();		
		ArrayList vecid = new ArrayList();		
		String page="";
		page=Helper.correctNull((String)hshRequestValues.get("pagefrom"));		
		//-----------to get the borrower name-------------
		strQuery = SQLParser.getSqlQuery("com_lapsidsearch2^"+strValue);
		rs = DBUtils.executeQuery(strQuery);
			 
		if(rs.next())
		{  
			strAppName=correctNull((String)rs.getString("comapp_companyname"));
		}
		if(rs!=null)
		{
			rs.close();
		}

		//-------------- to find the time of review-----------------

		strQuery = SQLParser.getSqlQuery("finselect1^"+strValue+"^0");
		rs = DBUtils.executeQuery(strQuery);
			 
		while(rs.next())
		{  
			str=rs.getInt("cnt");
		}
		if(rs!=null)
		{
			rs.close();
		}
		
		//--------------- to find the cma format of the particular applications-------

		String cma="";
		//strQuery = SQLParser.getSqlQuery("finselect8^"+strValue);
		strQuery=SQLParser.getSqlQuery("comfintrendsel1^"+strValue);
		rs = DBUtils.executeQuery(strQuery);
	 
		while(rs.next())
		{  
			cma=rs.getString("demo_finstandard");
		}
		hshValues.put("cma",cma);
		if(rs!=null)
		{
			rs.close();
		}
		
		// -----------------to find the tab----------------------
		
		vecVal = new ArrayList();		
		
	 //--------------- to select label depending upon existence of application

		if (str <= 0)
			{
				strQuery = SQLParser.getSqlQuery("finselect2a^"+cma+"^"+page);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
						vecRec = new ArrayList();
						vecRec.add(correctNull(rs.getString("fin_rowid")));
						vecRec.add(correctNull(rs.getString("fin_rowdesc")));
						vecRec.add(correctNull(rs.getString("fin_rowtype")));
						vecRec.add(correctNull(rs.getString("fin_sno")));
						vecVal.add(vecRec);
								
				}

				hshValues.put("labeldetails",vecVal);

			}

		else if (str > 0)
			{		
				vecVal = new ArrayList();
				String temp="";
				//strQuery = SQLParser.getSqlQuery("finselect3a^"+strValue+"^"+cma+"^"+page);
				strQuery = SQLParser.getSqlQuery("finselect3a^"+cma+"^"+page);
				
				
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					vecRec = new ArrayList();
					vecRec.add(correctNull(rs.getString("myrowid")));

					temp = Helper.correctNull(rs.getString("desc1"));
					if (temp.equals(""))
					{
						vecRec.add(correctNull(rs.getString("desc2")));
					}
					else 
					{
						vecRec.add(correctNull(rs.getString("desc1")));
					}

					vecRec.add(correctNull(rs.getString("fin_rowtype")));
					vecRec.add(correctNull(rs.getString("fin_sno")));					
					vecVal.add(vecRec);
				}
					
				hshValues.put("labeldetails",vecVal);

			}
				
		if(rs!=null)
		{
			rs.close();
		}
		hshValues.put("count",Integer.toString(str));
		
		String yearselect="",seloption="",givenyear="",yearvalue="",tempyear="";
		int i = 0,k=0;
		int from = 0,p=0;
		int yearint = 0;
		ArrayList vecrec = new ArrayList();

		givenyear = correctNull((String)hshRequestValues.get("from"));
		if (givenyear.equals(""))
		{
			givenyear="0";
		}
		from = Integer.parseInt(givenyear);
		if (from == 0)
		{
			from = 1;
		}
		
		String valarray[] = new String[5];
		valarray[0] ="0";
		valarray[1] ="0";
		valarray[2] ="0";
		valarray[3] ="0";
		valarray[4] ="0";
	String sno="";
		strQuery = SQLParser.getSqlQuery("finselect4a^"+strValue);
		rs=DBUtils.executeQuery(strQuery);

		while(rs.next())
		{
				valarray[0] ="0";
				valarray[1] ="0";
				valarray[2] ="0";
				valarray[3] ="0";
				valarray[4] ="0";
					
			vecVal = new ArrayList();
			String str1="",str2="",str3="",str0="";
			String desc="",formula_desc="";
			sno = (String)Helper.correctNull(rs.getString("fin_sno"));
			// To Find the years assigned for each application

			yearselect = (String)Helper.correctNull(rs.getString("fin_year"));
			yearvalue = (String)Helper.correctNull(rs.getString("yearvalue"));
			if (!sno.equals(tempyear) )
			{
			
			// to check for the occurance of audited,.,.,. for a paricular year

			strQuery = SQLParser.getSqlQuery("finselect7a^"+yearselect+"^"+strValue+"^"+sno);
			
			rs3 = DBUtils.executeQuery(strQuery);		
		
			while(rs3.next())
			{ 
				if(valarray[0].equals("0"))
				{
				valarray[0]=Helper.correctDouble(rs3.getString("fin_audit"));
				}
				if(valarray[1].equals("0"))
				{
				valarray[1]=Helper.correctDouble(rs3.getString("fin_unaudit"));
				}
				if(valarray[2].equals("0"))
				{
				valarray[2]=Helper.correctDouble(rs3.getString("fin_estimated"));
				}
				if(valarray[3].equals("0"))
				{
				valarray[3]=Helper.correctDouble(rs3.getString("fin_projection"));
				}
				if(valarray[4].equals("0"))
				{
				valarray[4]=Helper.correctDouble(rs3.getString("fin_projection"));
				}			
			
				if (!valarray[0].equals("0"))
				{
					valarray[0]= "fin_audit";					
				}			

				 if (!valarray[1].equals("0"))
				{
					valarray[1] = "fin_unaudit";					
				}				
				
				 if (!valarray[2].equals("0"))
				{
					valarray[2] = "fin_estimated";					
				}
				
				if (!valarray[3].equals("0"))
				{
					valarray[3] = "fin_projection";					
				}
				if (!valarray[4].equals("0"))
				{
					valarray[4] = "fin_projection";					
				}
		}
		if(rs3!=null)
		{
			rs3.close();
		}
				
// to find the values for each label with respect to value(a,una,p,e),year and id
int int_finrowid=0;
double dbl_wcg=0.00,dbl_wcgpercnt=0.00,dbl_actwcg=0.00,dbl_mpbf=0.00,dbl_excess=0.00,dbl_bankborr=0.00;
NumberFormat numberformat = NumberFormat.getNumberInstance();
numberformat.setGroupingUsed(false);
numberformat.setMaximumFractionDigits(2);
numberformat.setMinimumFractionDigits(2);
		for (int h=0;h<=3;h++)
		{
			vecVal = new ArrayList();
			vecid  = new ArrayList();
	
			if(valarray[h].equals(""))
			{
				valarray[h]="0";
			}
			if (!valarray[h].equals("0"))
			{
				i=i+1;
				seloption=valarray[h];
				if ((i >=  from) && (k < 5) )
					{
						p=i;
						k=k+1;						
						strQuery = SQLParser.getSqlQuery("finratio1^"+page+"^"+cma);						
						
						rs1=DBUtils.executeQuery(strQuery);
						while (rs1.next())
						{
								if (seloption.equals("fin_audit"))
								{
									desc="a";
								}
								else if (seloption.equals("fin_unaudit"))
								{
									desc="u";
								}
								else if (seloption.equals("fin_estimated"))
								{
									desc="e";
								}
								else if (seloption.equals("fin_projection"))
								{
									desc="p";
								}
								int formuladesc=0;			
								formuladesc =(rs1.getInt("fin_formula")) ;
								int_finrowid=(rs1.getInt("fin_rowid")) ;
								
									
			strQuery = SQLParser.getSqlQuery("selfinformula^"+formuladesc);
			
			rsFormulaFor = DBUtils.executeQuery(strQuery);
			String strFormulaFor="";
			if(rsFormulaFor.next())
			{
				strFormulaFor  =  correctNull((String)rsFormulaFor.getString("formula_for"));
			}
		
			String strPreYear ="",strPreYearDesc="";
			if(rsFormulaFor!=null)
			{
			rsFormulaFor.close();
			}
											
					HashMap hshformula =  new HashMap();
					hshformula.put("appno",strValue);
					hshformula.put("formulaid",Integer.toString(formuladesc));
					hshformula.put("curryear",yearselect);
					hshformula.put("prevyear",strPreYear);
					hshformula.put("currfinancialtype",desc);
					hshformula.put("prevfinancialtype",strPreYearDesc);
					hshformula.put("internalcalc","N");
					hshformula.put("sno",sno);
					hshformula.put("hshdata",new HashMap());
					HashMap hshRes = (HashMap)EJBInvoker.executeStateLess("comformula",hshformula,"GetFinValue");
					
								
					if(cma.equalsIgnoreCase("5"))
					{
					if(page.equalsIgnoreCase("MU"))
					{
				   	if(int_finrowid==1211)
					{
						dbl_wcg=Double.parseDouble(Helper.correctDouble((String)hshRes.get("strTotalValue")));
						vecVal.add(correctNull((String)hshRes.get("strTotalValue")));
					}
					if(int_finrowid==1212)
					{
						dbl_wcgpercnt=Double.parseDouble(Helper.correctDouble((String)hshRes.get("strTotalValue")));
						vecVal.add(correctNull((String)hshRes.get("strTotalValue")));
					}
					if(int_finrowid==1213)
					{
						dbl_actwcg=Double.parseDouble(Helper.correctDouble((String)hshRes.get("strTotalValue")));
						vecVal.add(correctNull((String)hshRes.get("strTotalValue")));
					}
					if(int_finrowid==1226)
					{
						if((dbl_wcg-dbl_wcgpercnt)<(dbl_wcg-dbl_actwcg))
						{
							dbl_mpbf=(dbl_wcg-dbl_wcgpercnt);
						}
						else
						{
							dbl_mpbf=dbl_wcg-dbl_actwcg;
						}
						vecVal.add(""+numberformat.format((dbl_mpbf)));
					}
					if(int_finrowid==1227)
					{
						dbl_bankborr=Double.parseDouble(Helper.correctDouble((String)hshRes.get("strTotalValue")));

						if((dbl_bankborr-dbl_mpbf)>0)
						{
						dbl_excess=dbl_bankborr-dbl_mpbf;
						}
						else
						{
						dbl_excess=0;
						}
						vecVal.add(""+numberformat.format((dbl_excess)));
					}
					}
					else if(page.equalsIgnoreCase("MA"))
					{
						if(int_finrowid==1214)
						{
							dbl_wcg=Double.parseDouble(Helper.correctDouble((String)hshRes.get("strTotalValue")));
							vecVal.add(correctNull((String)hshRes.get("strTotalValue")));
						}
						if(int_finrowid==1215)
						{
							dbl_wcgpercnt=Double.parseDouble(Helper.correctDouble((String)hshRes.get("strTotalValue")));
							vecVal.add(correctNull((String)hshRes.get("strTotalValue")));
						}
						if(int_finrowid==1216)
						{
							dbl_actwcg=Double.parseDouble(Helper.correctDouble((String)hshRes.get("strTotalValue")));
							vecVal.add(correctNull((String)hshRes.get("strTotalValue")));
						}
						if(int_finrowid==1228)
						{
							if((dbl_wcg-dbl_wcgpercnt)<(dbl_wcg-dbl_actwcg))
							{
								dbl_mpbf=dbl_wcg-dbl_wcgpercnt;
							}
							else
							{
								dbl_mpbf=dbl_wcg-dbl_actwcg;
							}
							vecVal.add(""+numberformat.format((dbl_mpbf)));
						}
						if(int_finrowid==1229)
						{
							dbl_bankborr=Double.parseDouble(Helper.correctDouble((String)hshRes.get("strTotalValue")));

							if((dbl_bankborr-dbl_mpbf)>0)
							{
							dbl_excess=dbl_bankborr-dbl_mpbf;
							}
							else
							{
							dbl_excess=0;
							}
							vecVal.add(""+numberformat.format((dbl_excess)));
						}
					}
						else if(page.equalsIgnoreCase("FL"))
						{
							if(int_finrowid==1217)
							{
								dbl_wcg=Double.parseDouble(Helper.correctDouble((String)hshRes.get("strTotalValue")));
								vecVal.add(correctNull((String)hshRes.get("strTotalValue")));
							}
							if(int_finrowid==1218)
							{
								dbl_wcgpercnt=Double.parseDouble(Helper.correctDouble((String)hshRes.get("strTotalValue")));
								vecVal.add(correctNull((String)hshRes.get("strTotalValue")));
							}
							if(int_finrowid==1219)
							{
								dbl_actwcg=Double.parseDouble(Helper.correctDouble((String)hshRes.get("strTotalValue")));
								vecVal.add(correctNull((String)hshRes.get("strTotalValue")));
							}
							if(int_finrowid==1230)
							{
								if((dbl_wcg-dbl_wcgpercnt)<(dbl_wcg-dbl_actwcg))
								{
									dbl_mpbf=dbl_wcg-dbl_wcgpercnt;
								}
								else
								{
									dbl_mpbf=dbl_wcg-dbl_actwcg;
								}
								vecVal.add(""+numberformat.format((dbl_mpbf)));
							}
							if(int_finrowid==1231)
							{
								dbl_bankborr=Double.parseDouble(Helper.correctDouble((String)hshRes.get("strTotalValue")));

								if((dbl_bankborr-dbl_mpbf)>0)
								{
								dbl_excess=dbl_bankborr-dbl_mpbf;
								}
								else
								{
								dbl_excess=0;
								}
								vecVal.add(""+numberformat.format((dbl_excess)));
							}
					}
						else
						{
							vecVal.add(correctNull((String)hshRes.get("strTotalValue")));
						}
					}
					
					else if(cma.equalsIgnoreCase("9"))
					{
					if(page.equalsIgnoreCase("MU"))
					{
				   	if(int_finrowid==1175)
					{
						dbl_wcg=Double.parseDouble(Helper.correctDouble((String)hshRes.get("strTotalValue")));
						vecVal.add(correctNull((String)hshRes.get("strTotalValue")));
					}
					if(int_finrowid==1176)
					{
						dbl_wcgpercnt=Double.parseDouble(Helper.correctDouble((String)hshRes.get("strTotalValue")));
						vecVal.add(correctNull((String)hshRes.get("strTotalValue")));
					}
					if(int_finrowid==1177)
					{
						dbl_actwcg=Double.parseDouble(Helper.correctDouble((String)hshRes.get("strTotalValue")));
						vecVal.add(correctNull((String)hshRes.get("strTotalValue")));
					}
					if(int_finrowid==1220)
					{
						if((dbl_wcg-dbl_wcgpercnt)<(dbl_wcg-dbl_actwcg))
						{
							dbl_mpbf=dbl_wcg-dbl_wcgpercnt;
						}
						else
						{
							dbl_mpbf=dbl_wcg-dbl_actwcg;
						}
						vecVal.add(""+numberformat.format((dbl_mpbf)));
					}
					if(int_finrowid==1221)
					{
						dbl_bankborr=Double.parseDouble(Helper.correctDouble((String)hshRes.get("strTotalValue")));

						if((dbl_bankborr-dbl_mpbf)>0)
						{
						dbl_excess=dbl_bankborr-dbl_mpbf;
						}
						else
						{
						dbl_excess=0;
						}
						vecVal.add(""+numberformat.format((dbl_excess)));
					}
					}
					else if(page.equalsIgnoreCase("MA"))
					{
						if(int_finrowid==1178)
						{
							dbl_wcg=Double.parseDouble(Helper.correctDouble((String)hshRes.get("strTotalValue")));
							vecVal.add(correctNull((String)hshRes.get("strTotalValue")));
						}
						if(int_finrowid==1179)
						{
							dbl_wcgpercnt=Double.parseDouble(Helper.correctDouble((String)hshRes.get("strTotalValue")));
							vecVal.add(correctNull((String)hshRes.get("strTotalValue")));
						}
						if(int_finrowid==1180)
						{
							dbl_actwcg=Double.parseDouble(Helper.correctDouble((String)hshRes.get("strTotalValue")));
							vecVal.add(correctNull((String)hshRes.get("strTotalValue")));
						}
						if(int_finrowid==1222)
						{
							if((dbl_wcg-dbl_wcgpercnt)<(dbl_wcg-dbl_actwcg))
							{
								dbl_mpbf=dbl_wcg-dbl_wcgpercnt;
							}
							else
							{
								dbl_mpbf=dbl_wcg-dbl_actwcg;
							}
							vecVal.add(""+numberformat.format((dbl_mpbf)));
						}
						if(int_finrowid==1223)
						{
							dbl_bankborr=Double.parseDouble(Helper.correctDouble((String)hshRes.get("strTotalValue")));

							if((dbl_bankborr-dbl_mpbf)>0)
							{
							dbl_excess=dbl_bankborr-dbl_mpbf;
							}
							else
							{
							dbl_excess=0;
							}
							vecVal.add(""+numberformat.format((dbl_excess)));
						}
					}
						else if(page.equalsIgnoreCase("FL"))
						{
							if(int_finrowid==1181)
							{
								dbl_wcg=Double.parseDouble(Helper.correctDouble((String)hshRes.get("strTotalValue")));
								vecVal.add(correctNull((String)hshRes.get("strTotalValue")));
							}
							if(int_finrowid==1182)
							{
								dbl_wcgpercnt=Double.parseDouble(Helper.correctDouble((String)hshRes.get("strTotalValue")));
								vecVal.add(correctNull((String)hshRes.get("strTotalValue")));
							}
							if(int_finrowid==1183)
							{
								dbl_actwcg=Double.parseDouble(Helper.correctDouble((String)hshRes.get("strTotalValue")));
								vecVal.add(correctNull((String)hshRes.get("strTotalValue")));
							}
							if(int_finrowid==1224)
							{
								if((dbl_wcg-dbl_wcgpercnt)<(dbl_wcg-dbl_actwcg))
								{
									dbl_mpbf=dbl_wcg-dbl_wcgpercnt;
								}
								else
								{
									dbl_mpbf=dbl_wcg-dbl_actwcg;
								}
								vecVal.add(""+dbl_mpbf);
							}
							if(int_finrowid==1225)
							{
								dbl_bankborr=Double.parseDouble(Helper.correctDouble((String)hshRes.get("strTotalValue")));

								if((dbl_bankborr-dbl_mpbf)>0)
								{
								dbl_excess=dbl_bankborr-dbl_mpbf;
								}
								else
								{
								dbl_excess=0;
								}
								vecVal.add(""+dbl_excess);
							}
					}
						else
						{
							vecVal.add(correctNull((String)hshRes.get("strTotalValue")));
						}
					}
		
					rs=DBUtils.executeLAPSQuery("com_assessmentselection_select^"+strValue);
					if(rs.next())
					{
						hshValues.put("COM_ASSESSMENTTYPE",correctNull((String)rs.getString("COM_ASSESSMENTTYPE")));
					}
					
				vecid.add(correctNull(rs1.getString("fin_rowid")));
																
			hshValues.put("year"+k,vecVal);	
			hshValues.put("vecid"+k,vecid);			

	}
					
						if(rs1 != null)
						{
							rs1.close();
						}
						vecrec.add(yearselect);
						vecrec.add(seloption);
					}

			}
		}
		
	}
	
		yearint=yearint + 1;
		tempyear = sno;
		
	}
	hshValues.put("from",Integer.toString(from));
	hshValues.put("totalyear",i+"");
	hshValues.put("upto",p+"");	
	hshValues.put("yearvalue",vecrec);
	hshValues.put("page",page);
	hshValues.put("cma_no",cma);
	hshValues.put("appno",strValue);
	hshValues.put("appname",strAppName);

}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData login  "+ce.toString());
		}
		finally
		{
			try
			{	
				if(rs != null)
					rs.close();
				if(rs1 != null)
					rs1.close();
				if(rsFormulaFor != null)
					rsFormulaFor.close();
				if(rsPrevYear != null)
					rsPrevYear.close();
				if(rs3 != null)
					rs3.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		
		return hshValues; 
	}
    
    public HashMap getDataForDSCRSensitivitydata(HashMap hshRequestValues) 
    {
		
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs3 = null;
		ResultSet rs4 = null;
		ResultSet rs10 =null;
		HashMap hshValues=null;
		String strQuery="",strValue="";		
		int str=0,tabcnt=0,l=0;		
		String sumaudit="";
		String sumunaudit="";
		String sumestimated="";
		String sumprojection="";
		String sel_divID="";
		String pagetab="";
		String base_year="";
		String strAction="";
		String fintype = null;
	try
	{	
		String hidUpload=correctNull((String)hshRequestValues.get("hidUpload"));
		strAction=correctNull((String)hshRequestValues.get("hidAction"));
		//--------This is Existing Finia-----
		strValue=correctNull((String)hshRequestValues.get("appno"));
		//Added by Kishan
		String strFinID = "0";
		String cma="0",strValuesin="";
		strQuery = SQLParser.getSqlQuery("sel_financeid^"+strValue);
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strFinID=Helper.correctNull((String)rs.getString("DEMO_FINSTANDARD"));
			//strValue=Helper.correctNull((String)rs.getString("DEMO_FINSTANDARD"));
			if(!strFinID.equals("")) {
				strQuery = SQLParser.getSqlQuery("fin_cmano_select^"+strFinID);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next()) {
					cma = Helper.correctNull((String)rs.getString("FIN_CMANO"));
					strValuesin = Helper.correctNull((String) rs.getString("fin_valuesarein"));
				}
			}
		}
		sel_divID=correctNull((String)hshRequestValues.get("sel_divID"));
		if(sel_divID.equalsIgnoreCase(""))
		{
			sel_divID="0";
		}
		
		String page = correctNull((String)hshRequestValues.get("pageval"));
		pagetab=Helper.correctNull(page);
		
		rs=null;		

		
		hshValues = new HashMap();
		ArrayList vecVal=new ArrayList();
		ArrayList vecRec=new ArrayList();		
		ArrayList vecid = new ArrayList();
	    hshValues.put("sel_divID",sel_divID);
		
			
//			Retreving of values for project input 
			
			String query1 = SQLParser.getSqlQuery("financial_new_projectinputfields_select^"+strValue);
			rs = DBUtils.executeQuery(query1);
			ArrayList vec=new ArrayList();
			if(rs.next())
			{			
				vec.add(Helper.correctNull(Helper.correctNull((String)rs.getString(10))));
				vec.add(Helper.correctNull(Helper.correctNull((String)rs.getString(2))));
				if(Helper.correctNull(rs.getString(3)).equalsIgnoreCase(""))
				{
					vec.add("0.00");
				}
				else
				{
					vec.add(Helper.correctNull((String)rs.getString(3)));
				}
				if(Helper.correctNull(rs.getString(4)).equalsIgnoreCase(""))
				{
					vec.add("0.00");
				}
				else
				{
					vec.add(Helper.correctNull((String)rs.getString(4)));
				}
				vec.add(Helper.correctNull((String)rs.getString(5)));
				vec.add(Helper.correctNull((String)rs.getString(6)));
				vec.add(Helper.correctNull((String)rs.getString(7)));
				vec.add(Helper.correctNull((String)rs.getString(8)));
				vec.add(Helper.correctNull((String)rs.getString(9)));
				hshValues.put("projectinputvalue",vec);
			}
			else
			{
				vec.add("");
				vec.add("");
				vec.add("0.00");
				vec.add("0.00");
				vec.add("");
				vec.add("");
				vec.add("");
				vec.add("");
				vec.add("0.00");
				hshValues.put("projectinputvalue",vec);
			}
			

			//Retreving of value for base year
			
			if(rs!=null)
			{
				rs.close();
			}
		
		//-------------- to find the time of review-----------------

		if(rs!=null)
		{
			rs.close();
		}

		//--------------- to find the cma format of the particular applications-------

		String tempbool="2",tabool="";
		//String cma="0";		
		log.info((String)hshRequestValues.get("cattype"));

			strQuery=SQLParser.getSqlQuery("comfintrendsel1^"+strValue);
			if(rs != null)
			{
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			 
			while(rs.next())
			{  
				//cma=correctNull(rs.getString("demo_finstandard"));
				fintype = Helper.correctNull((String)rs.getString("demo_finmodel"));
			}
		
			if(cma.equalsIgnoreCase("5"))
			{
				if(pagetab.equalsIgnoreCase(""))
				{
				pagetab="INFRA STRUCTURE MODEL";
				}
			}
	
		// -----------------to find the tab----------------------
		
		
			if(cma.equalsIgnoreCase(""))
			{
				cma="0";
			}
			strQuery = SQLParser.getSqlQuery("com_fintabselect^"+cma);
			if(rs != null)
			{
				rs.close();
			}
			rs=DBUtils.executeQuery(strQuery);
			int y=0;
			while(rs.next())
			{		
				
				if((y==0) && (page.trim().equals("") || page.trim().equals("RA") ) )
					{
						page = correctNull((String)rs.getString("fin_tabname"));
					}
		
				
					vecRec = new ArrayList();
					vecRec.add(correctNull(rs.getString("fin_tabname")));
					vecVal.add(vecRec);
					
			}
	

			hshValues.put("tabdetails",vecVal);			
			vecVal = new ArrayList();
			
			

		String tempsno="";
		
		str=0;
		if (str <= 0)
			{
				strQuery = SQLParser.getSqlQuery("finselect2a^"+"1"+"^"+"DSCR");
				if(rs != null)
				{
					rs.close();
				}
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
						vecRec = new ArrayList();
						vecRec.add(correctNull(rs.getString("fin_rowid")));
						vecRec.add(correctNull(rs.getString("fin_rowdesc")));
						vecRec.add(correctNull(rs.getString("fin_rowtype")));
						tempsno = correctNull(rs.getString("fin_sno"));
						if (tempsno.trim().equals(""))
						{
							tempsno=" ";
						}
						
						vecRec.add(tempsno);
						vecVal.add(vecRec);								
				}

				hshValues.put("labeldetails",vecVal);
				
		
				
			}

			
		hshValues.put("count",Integer.toString(str));
		
		String yearselect="",seloption="",givenyear="";
		int i = 0,k=0;
		int from = 0,p=0,tt=0;
		
		ArrayList vecrec = new ArrayList();
		givenyear = correctNull((String)hshRequestValues.get("from"));
		if (givenyear.equals(""))
		{
			givenyear="0";
		}
		from = Integer.parseInt(givenyear);
		if (from == 0)
		{
			from = 1;
		}
		
		    	String valarray[] = new String[6];		    	
			   	valarray[0] ="0";
				valarray[1] ="0";
				valarray[2] ="0";
				valarray[3] ="0";
				valarray[4] ="0";
		
				strQuery = SQLParser.getSqlQuery("finYearSelDSCRSENS^"+strValue+"^"+sel_divID);				
				rs=DBUtils.executeQuery(strQuery);
				ArrayList arryvall=new ArrayList();
				
				int kk=0;
				while(rs.next())
				{
					arryvall.add(Helper.correctNull(rs.getString("fin_year")));
					
				}
		
//this code has been commented by GANESAN for get all the year for all the sub tags

				
		strQuery = SQLParser.getSqlQuery("finYearSelDSCRSENS^"+strValue+"^"+sel_divID);

		if(rs != null)
		{
			rs.close();
		}
		rs=DBUtils.executeQuery(strQuery);
		while(rs.next())
		{
				valarray[0] ="0";
				valarray[1] ="0";
				valarray[2] ="0";
				valarray[3] ="0";
				valarray[4] ="0";					
				vecVal = new ArrayList();	
				String desc="";			
				yearselect = (String)Helper.correctNull(rs.getString("fin_year"));
			
			if(!yearselect.equals(""))
			{
				
				if(rs3 != null)
				{
					rs3.close();
				}
				

				String strQuery10 = SQLParser.getSqlQuery("assessselect9DSCRSENS^"+strValue+"^"+yearselect);
				if(rs10 != null)
				{
					rs10.close();
				}
				
				rs10 = DBUtils.executeQuery(strQuery10);
				if (rs10.next())
				{
					 sumaudit=Helper.correctDouble(rs10.getString("sumaudit"));
					 sumunaudit=Helper.correctDouble(rs10.getString("sumunaudit"));
					 sumestimated=Helper.correctDouble(rs10.getString("sumestimated"));
					 sumprojection=Helper.correctDouble(rs10.getString("sumprojection"));
				}
				if (valarray[0].equals("0") && !sumaudit.equals("0"))
				{
					valarray[0]="fin_audit";
				}
				if (valarray[1].equals("0") && !sumunaudit.equals("0"))
				{
					valarray[1]="fin_unaudit";
				}
				if (valarray[2].equals("0") && !sumestimated.equals("0"))
				{
					valarray[2]="fin_estimated";
				}
				if (valarray[3].equals("0") && !sumprojection.equals("0"))
				{
					valarray[3]="fin_projection";
				}
				if (valarray[4].equals("0") && !sumprojection.equals("0"))
				{
					valarray[4]="fin_projection";
				}			
						
				if(rs10!=null)
				{
					rs10.close();
				}
				

			for (int h=0;h<4;h++)
			{
				vecVal = new ArrayList();
				vecid  = new ArrayList();
				
				if(valarray[h].equals(""))
				{
				valarray[h]="0.00";
				}
				if (!valarray[h].equals("0"))
				{
					i=i+1;
					seloption=valarray[h];
					if ((i >=  from) && (k < 5) )
					{
						p=i;
						k=k+1;
					
						strQuery = SQLParser.getSqlQuery("finselect5DSCRsens^"+seloption+"^"+yearselect+"^"+strValue);
						
						if(rs1 != null)
						{
							rs1.close();
						}						
						rs1=DBUtils.executeQuery(strQuery);
						while (rs1.next())
						{
									vecVal.add(correctNull(rs1.getString("txtvalue")));
									vecid.add(correctNull(rs1.getString("fin_rowid")));
						
									
									hshValues.put("year"+k,vecVal);	
									hshValues.put("vecid"+k,vecid);					
							}
																	
							if(rs1!=null)
							{
								rs1.close();
							}
							vecrec.add(yearselect);
							vecrec.add(seloption);
					}

				}
			}
		}
	}
	
	hshValues.put("from",Integer.toString(from));

	//added by balaji and shanmugam for get the Next and Previous anchor bellow the page

		
		hshValues.put("totalyear",i+"");
		hshValues.put("upto",p+"");
		hshValues.put("yearvalue",vecrec);
		hshValues.put("page",page);
		hshValues.put("IRBUpload",hidUpload);
		
	// checking for the values in the com_finappvalues table
	strQuery = SQLParser.getSqlQuery("com_finappvaluesselDSCR^"+strValue+"^"+sel_divID);
	rs = DBUtils.executeQuery(strQuery);
		 
	if(rs.next())
	{  
		hshValues.put("findata","true");
	}
	else
	{
		hshValues.put("findata","false");
	}

	if(rs!=null){rs.close();}
	
	strQuery = SQLParser.getSqlQuery("com_finappdscrsens_Avg_sel^"+strValue);
	rs = DBUtils.executeQuery(strQuery);
	if(rs.next())
	{
		hshValues.put("DscrAvg", nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("com_avgdscr")))));
	}
	else
	{
		hshValues.put("DscrAvg", "0.00");
	}
	
	//select financial values are in lakhs/ crores
	if(strValuesin.equalsIgnoreCase("C"))
	{
		hshValues.put("strValuesin", "Crore");
	}
	else if(strValuesin.equalsIgnoreCase("L"))
	{
		hshValues.put("strValuesin", "Lacs");
	}else{
		hshValues.put("strValuesin", "Rupees");
	}
}
		catch(Exception ce)
		{
			ce.printStackTrace();
			throw new EJBException("Error in getData login  "+ce.toString());
			
		}
		finally
		{
			try
			{	
				if(rs != null)
					rs.close();
				if(rs1 != null)
					rs1.close();
				if(rs3 != null)
					rs3.close();
				if(rs4 != null)
					rs4.close();
				if(rs10 != null)
					rs10.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		hshValues.put("tabname",pagetab);
		hshValues.put("strAction",strAction);
		hshValues.put("fintype", fintype);
		return hshValues; 
	
    	
    }
    
    public void updategetDataForDSCRSensitivitydata(HashMap hsh) 
    {
		
		
		ResultSet rs = null,rs1=null;
		String strQuery="";
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		String year1="",year2="",year3="",year4="",year5="";
		String c1year="",c2year="",c3year="",c4year="",c5year="",strDivid="";		
		String strRowCol1="",strRowCol2="",strRowCol3="",strRowCol4="",strRowCol5="";		
		int intUpdatesize =0,intValue=0;		
		String test=Integer.toString(intValue);		
		String []id=null;		
		String appno="";		
		String []strType=null;
		String strAction="";
		try
		{
				appno=(String)hsh.get("appno");
				//String strFinID = "0";
				//String cma="0";
				/*strQuery = SQLParser.getSqlQuery("sel_financeid^"+appno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strFinID=Helper.correctNull((String)rs.getString("DEMO_FINSTANDARD"));
					
					if(!strFinID.equals("")) {
						strQuery = SQLParser.getSqlQuery("fin_cmano_select^"+strFinID);
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next()) {
							cma = Helper.correctNull((String)rs.getString("FIN_CMANO"));
						}
					}
				}*/
				hsh.get("id");				
				id= (String[])hsh.get("id");			
				int idlen=id.length;
				strType=(String [])hsh.get("type");				
				strDivid=(String )hsh.get("sel_divID");	
				if(strDivid=="")
				{
					strDivid="0";
				}
				year1=correctNull((String)hsh.get("txtyear1"));
				year2=correctNull((String)hsh.get("txtyear2"));
				year3=correctNull((String)hsh.get("txtyear3"));
				year4=correctNull((String)hsh.get("txtyear4"));
				year5=correctNull((String)hsh.get("txtyear5"));
				
				c1year=correctNull((String)hsh.get("combo1"));
				c2year=correctNull((String)hsh.get("combo2"));
				c3year=correctNull((String)hsh.get("combo3"));
				c4year=correctNull((String)hsh.get("combo4"));
				c5year=correctNull((String)hsh.get("combo5"));
				int x=0;
				strAction=Helper.correctNull((String)hsh.get("hidAction"));

					
		//-----------------------------------------------------------------------------------------------------------		
				
				
				
				
		
				String BaseYearFlag=Helper.correctNull((String)hsh.get("BaseYearFlag"));
				
				//Added by Punitha To Avoid Duplicate Entry
				if(strAction.equalsIgnoreCase("update"))
					updateDSCRSensitivityTableUpdate(hsh);
			

	for(int i=0;i<idlen;i++)
	{			
			
			String y = correctNull(id[i]);
			x= Integer.parseInt(y);
			if(strType[i].equalsIgnoreCase("I"))
			{				
				String temp=correctNull((String)hsh.get("desc"+x));
				if(!temp.equals(""))
				{
					hshQueryValues=new HashMap();
					intUpdatesize=0;
					strQuery = SQLParser.getSqlQuery("finappdesccountsens^"+appno+'^'+x);
					
					if(rs != null)
					{
						rs.close();
					}
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","finappdescupsens");
						arrValues.add(correctNull((String)hsh.get("desc"+x)));
						arrValues.add(appno);
						arrValues.add(correctNull(id[i]));
						hshQuery.put("arrValues",arrValues);
						
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					}
					else
					{
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;						
						hshQuery.put("strQueryId","finappdescinssens");
						arrValues.add(appno);
						arrValues.add(correctNull(id[i]));
						arrValues.add(correctNull((String)hsh.get("desc"+x)));
						hshQuery.put("arrValues",arrValues);						
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					}
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				}
				
			}//for first if
							
				strRowCol1 = Helper.correctDouble((String)hsh.get("row"+x+"c1"));
				strRowCol2 = Helper.correctDouble((String)hsh.get("row"+x+"c2"));
				strRowCol3 = Helper.correctDouble((String)hsh.get("row"+x+"c3"));
				strRowCol4 = Helper.correctDouble((String)hsh.get("row"+x+"c4"));
				strRowCol5 = Helper.correctDouble((String)hsh.get("row"+x+"c5"));

				String strTemp="";
				strTemp=strType[i];
				String tempDesc=correctNull((String)hsh.get("desc"+x));				
				hshQueryValues=new HashMap();
				intUpdatesize=0;

		if (!year1.equals("") && !c1year.trim().equals("") )
		{
			if(!strType[i].equalsIgnoreCase("C") && ! strType[i].equalsIgnoreCase("H"))
			{				
				strQuery = SQLParser.getSqlQuery("finappvaluescountDSCRsens^"+appno+"^"+year1+'^'+x);
				
				if(rs !=  null)
				{
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				
				if(rs.next())
				{					
						hshQueryValues=new HashMap();
						intUpdatesize=0;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						if (c1year.trim().equalsIgnoreCase("a"))
						{
							hshQuery.put("strQueryId","finappvaluesup1DSCRsens");
						}
						if (c1year.trim().equalsIgnoreCase("u"))
						{
							hshQuery.put("strQueryId","finappvaluesup2DSCRsens");
						}
						if (c1year.trim().equalsIgnoreCase("e"))
						{
							hshQuery.put("strQueryId","finappvaluesup3DSCRsens");
						}
						if (c1year.trim().equalsIgnoreCase("p"))
						{
							hshQuery.put("strQueryId","finappvaluesup4DSCRsens");
						}

						if(strTemp.equalsIgnoreCase("I") && tempDesc.equals("") && c1year.trim().equalsIgnoreCase("p"))
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year1);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
						}
						else if(c1year.trim().equalsIgnoreCase("p"))
						{
							arrValues.add(strRowCol1);//get values from Rowcal field
							arrValues.add(strRowCol1);
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year1);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
						}
						else if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year1);												
							hshQuery.put("arrValues",arrValues);							
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						}
						else
						{
							arrValues.add(strRowCol1);//get values from Rowcal field
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year1);												
							hshQuery.put("arrValues",arrValues);							
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						}
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
					
					
				}
				else
				{					
						hshQueryValues=new HashMap();
						intUpdatesize=0;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","finappDSCRinssens");
						arrValues.add(appno);
						arrValues.add(year1);
						arrValues.add(correctNull(id[i]));
						if (c1year.trim().equalsIgnoreCase("a"))
						{
							if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
							{
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								
							}
							else
							{
								arrValues.add(strRowCol1);//get values from Rowcal field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								
							}
							
						}
						if (c1year.trim().equalsIgnoreCase("u"))
						{
							if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
							{
								arrValues.add(test);
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								
							}
							else
							{
								arrValues.add(test);
								arrValues.add(strRowCol1);//get values from Rowcal field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								
							}
						}
						if (c1year.trim().equalsIgnoreCase("e"))
						{
							if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(test);
								arrValues.add(test);
								
							}
							else
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(strRowCol1);//get values from Rowcal field
								arrValues.add(test);
								arrValues.add(test);
								
							}
							
						}
						if (c1year.trim().equalsIgnoreCase("p"))
						{
							if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(test);
								
							}
							else
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(strRowCol1);//get values from Rowcal field
								arrValues.add(strRowCol1);
								
							}
							
						}
						strDivid="0";
						arrValues.add(strDivid);   arrValues.add(""+(i+1));
						hshQuery.put("arrValues",arrValues);						
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
					
				}
			}
			else
			{
						
				strQuery = SQLParser.getSqlQuery("finappvaluescountDSCRsens^"+appno+"^"+year1+'^'+x);
				
				if(rs !=  null)
				{
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				
				if(rs.next())
				{
						hshQueryValues=new HashMap();
						intUpdatesize=0;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						if (c1year.trim().equalsIgnoreCase("a"))
						{
							hshQuery.put("strQueryId","finappvaluesup1DSCRsens");
						}
						if (c1year.trim().equalsIgnoreCase("u"))
						{
							hshQuery.put("strQueryId","finappvaluesup2DSCRsens");
						}
						if (c1year.trim().equalsIgnoreCase("e"))
						{
							hshQuery.put("strQueryId","finappvaluesup3DSCRsens");
						}
						if (c1year.trim().equalsIgnoreCase("p"))
						{
							hshQuery.put("strQueryId","finappvaluesup4DSCRsens");
						}

						if (c1year.trim().equalsIgnoreCase("p"))
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year1);
												
							hshQuery.put("arrValues",arrValues);						
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}
						else
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year1);
												
							hshQuery.put("arrValues",arrValues);						
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
						}
						
				}
				else
				{						
						hshQueryValues=new HashMap();
						intUpdatesize=0;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","finappDSCRinssens");
						arrValues.add(appno);
						arrValues.add(year1);
						arrValues.add(correctNull(id[i]));
						if (c1year.trim().equalsIgnoreCase("a"))
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);
							
						}
						if (c1year.trim().equalsIgnoreCase("u"))
						{
							arrValues.add(test);
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);
							
						}
						if (c1year.trim().equalsIgnoreCase("e"))
						{
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(test);
							
						}
						if (c1year.trim().equalsIgnoreCase("p"))
						{
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							
						}
				
						strDivid="0";
						arrValues.add(strDivid);  arrValues.add(""+(i+1));
						hshQuery.put("arrValues",arrValues);						
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				}
				
			}
			
		}//year
		

		hshQueryValues=new HashMap();
		intUpdatesize=0;

		if (!year2.equals("") && !c2year.trim().equals(""))
		{
			if(!strType[i].equalsIgnoreCase("C")&& !strType[i].equalsIgnoreCase("H"))
			{				
				strQuery = SQLParser.getSqlQuery("finappvaluescountDSCRsens^"+appno+"^"+year2+'^'+x);
				if(rs !=  null)
				{
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				
				if(rs.next())
				{					
						hshQueryValues=new HashMap();
						intUpdatesize=0;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						if (c2year.trim().equalsIgnoreCase("a"))
						{
							hshQuery.put("strQueryId","finappvaluesup1DSCRsens");
						}
						if (c2year.trim().equalsIgnoreCase("u"))
						{
							hshQuery.put("strQueryId","finappvaluesup2DSCRsens");
						}
						if (c2year.trim().equalsIgnoreCase("e"))
						{
							hshQuery.put("strQueryId","finappvaluesup3DSCRsens");
						}
						if (c2year.trim().equalsIgnoreCase("p"))
						{
							hshQuery.put("strQueryId","finappvaluesup4DSCRsens");
						}
						if(strTemp.equalsIgnoreCase("I") && tempDesc.equals("") && c2year.trim().equalsIgnoreCase("p"))
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year2);					
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
						}
						else if(c2year.trim().equalsIgnoreCase("p"))
						{
							arrValues.add(strRowCol2);//get values from Rowcal field
							arrValues.add(strRowCol2);
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year2);					
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
						}
						else if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year2);					
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						}
						else
						{
							arrValues.add(strRowCol2);//get values from Rowcal field
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year2);					
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						}
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
					
				}
				else
				{
						hshQueryValues=new HashMap();
						intUpdatesize=0;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","finappDSCRinssens");
						arrValues.add(appno);
						arrValues.add(year2);
						arrValues.add(correctNull(id[i]));
						if (c2year.trim().equalsIgnoreCase("a"))
						{
							if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(test);
								
							}
							else
							{
								arrValues.add(strRowCol2);//get values from Rowcal field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								
							}
						}
						if (c2year.trim().equalsIgnoreCase("u"))
						{
							if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(test);
								
							}
							else
							{
								arrValues.add(test);
								arrValues.add(strRowCol2);//get values from Rowcal field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								
							}
						}
						if (c2year.trim().equalsIgnoreCase("e"))
						{
							if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(test);
								
							}
							else
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(strRowCol2);//get values from Rowcal field
								arrValues.add(test);
								arrValues.add(test);
							}
						}
						if (c2year.trim().equalsIgnoreCase("p"))
						{
							if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(test);
								
							}
							else
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(strRowCol2);//get values from Rowcal field
								arrValues.add(strRowCol2);
								
							}
						}
						strDivid="0";
						arrValues.add(strDivid);   arrValues.add(""+(i+1));
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				}
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("finappvaluescountDSCRsens^"+appno+"^"+year2+'^'+x);
				
				if(rs !=  null)
				{
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				
				if(rs.next())
				{
						hshQueryValues=new HashMap();
						intUpdatesize=0;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						if (c2year.trim().equalsIgnoreCase("a"))
						{
							hshQuery.put("strQueryId","finappvaluesup1DSCRsens");
						}
						if (c2year.trim().equalsIgnoreCase("u"))
						{
							hshQuery.put("strQueryId","finappvaluesup2DSCRsens");
						}
						if (c2year.trim().equalsIgnoreCase("e"))
						{
							hshQuery.put("strQueryId","finappvaluesup3DSCRsens");
						}
						if (c2year.trim().equalsIgnoreCase("p"))
						{
							hshQuery.put("strQueryId","finappvaluesup4DSCRsens");
						}
//						if (c2year.trim().equalsIgnoreCase("p"))
//						{
//							hshQuery.put("strQueryId","finappvaluesup5");
//						}
//						
						if(c2year.trim().equalsIgnoreCase("p"))
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year2);
												
							hshQuery.put("arrValues",arrValues);						
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}else
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year2);
												
							hshQuery.put("arrValues",arrValues);						
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}
						
				}
				else
				{						
						hshQueryValues=new HashMap();
						intUpdatesize=0;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","finappDSCRinssens");
						arrValues.add(appno);
						arrValues.add(year2);
						arrValues.add(correctNull(id[i]));
						if (c2year.trim().equalsIgnoreCase("a"))
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);
							
						}
						if (c2year.trim().equalsIgnoreCase("u"))
						{
							arrValues.add(test);
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);
							
						}
						if (c2year.trim().equalsIgnoreCase("e"))
						{
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(test);
							
						}
						if (c2year.trim().equalsIgnoreCase("p"))
						{
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							
						}
						strDivid="0";
						arrValues.add(strDivid);   arrValues.add(""+(i+1));
						hshQuery.put("arrValues",arrValues);						
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				}				
			
			}
		}

		
		hshQueryValues=new HashMap();
		intUpdatesize=0;

		if (!year3.equals("") && !c3year.trim().equals("") )
		{
			if(!strType[i].equalsIgnoreCase("C") && !strType[i].equalsIgnoreCase("H"))
			{
				strQuery = SQLParser.getSqlQuery("finappvaluescountDSCRsens^"+appno+"^"+year3+'^'+x);
				
				if(rs !=  null)
				{
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				
				if(rs.next())
				{					
						hshQueryValues=new HashMap();
						intUpdatesize=0;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						if (c3year.trim().equalsIgnoreCase("a"))
						{
							hshQuery.put("strQueryId","finappvaluesup1DSCRsens");
						}
						if (c3year.trim().equalsIgnoreCase("u"))
						{
							hshQuery.put("strQueryId","finappvaluesup2DSCRsens");
						}
						if (c3year.trim().equalsIgnoreCase("e"))
						{
							hshQuery.put("strQueryId","finappvaluesup3DSCRsens");
						}
						if (c3year.trim().equalsIgnoreCase("p"))
						{
							hshQuery.put("strQueryId","finappvaluesup4DSCRsens");
						}
						if(strTemp.equalsIgnoreCase("I") && tempDesc.equals("") && c3year.trim().equalsIgnoreCase("p"))
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year3);					
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
						}
						else if(c3year.trim().equalsIgnoreCase("p"))
						{
							arrValues.add(strRowCol3);//get values from Rowcal field
							arrValues.add(strRowCol3);
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year3);					
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
						}
						else if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
						{							
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year3);
												
							hshQuery.put("arrValues",arrValues);							
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);

						}
						else
						{
							arrValues.add(strRowCol3);//get values from Rowcal field
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year3);
												
							hshQuery.put("arrValues",arrValues);							
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						}
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
					
				}
				else
				{
					
						hshQueryValues=new HashMap();
						intUpdatesize=0;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","finappDSCRinssens");
						arrValues.add(appno);
						arrValues.add(year3);
						arrValues.add(correctNull(id[i]));
						if (c3year.trim().equalsIgnoreCase("a"))
						{
							if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(test);
								
							}
							else
							{
								arrValues.add(strRowCol3);//get values from Rowcal field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								
							}
						}
						if (c3year.trim().equalsIgnoreCase("u"))
						{
							if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(test);
								
							}
							else
							{
								arrValues.add(test);
								arrValues.add(strRowCol3);//get values from Rowcal field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								
							}
						}
						if (c3year.trim().equalsIgnoreCase("e"))
						{
							if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(test);
								
							}
							else
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(strRowCol3);//get values from Rowcal field
								arrValues.add(test);
								arrValues.add(test);
								
							}
						}
						if (c3year.trim().equalsIgnoreCase("p"))
						{
							if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(test);
								
							}
							else
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(strRowCol3);//get values from Rowcal field
								arrValues.add(strRowCol3);
								
							}
						}
						strDivid="0";
						arrValues.add(strDivid);   arrValues.add(""+(i+1));
						
						hshQuery.put("arrValues",arrValues);						
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				}
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("finappvaluescountDSCRsens^"+appno+"^"+year3+'^'+x);
				
				if(rs !=  null)
				{
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				
				if(rs.next())
				{
						hshQueryValues=new HashMap();
						intUpdatesize=0;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						if (c3year.trim().equalsIgnoreCase("a"))
						{
							hshQuery.put("strQueryId","finappvaluesup1DSCRsens");
						}
						if (c3year.trim().equalsIgnoreCase("u"))
						{
							hshQuery.put("strQueryId","finappvaluesup2DSCRsens");
						}
						if (c3year.trim().equalsIgnoreCase("e"))
						{
							hshQuery.put("strQueryId","finappvaluesup3DSCRsens");
						}
						if (c3year.trim().equalsIgnoreCase("p"))
						{
							hshQuery.put("strQueryId","finappvaluesup4DSCRsens");
						}

						if(c3year.trim().equalsIgnoreCase("p"))
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year3);
												
							hshQuery.put("arrValues",arrValues);						
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}else
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year3);
												
							hshQuery.put("arrValues",arrValues);						
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}
					
				}
				else
				{
						
						hshQueryValues=new HashMap();
						intUpdatesize=0;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","finappDSCRinssens");
						arrValues.add(appno);
						arrValues.add(year3);
						arrValues.add(correctNull(id[i]));
						if (c3year.trim().equalsIgnoreCase("a"))
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);
							
						}
						if (c3year.trim().equalsIgnoreCase("u"))
						{
							arrValues.add(test);
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);
						}
						if (c3year.trim().equalsIgnoreCase("e"))
						{
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(test);
						}
						if (c3year.trim().equalsIgnoreCase("p"))
						{
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
						}
						strDivid="0";
						arrValues.add(strDivid);   arrValues.add(""+(i+1));
						hshQuery.put("arrValues",arrValues);						
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				}				
			}
		}
			
		hshQueryValues=new HashMap();
		intUpdatesize=0;
				
				
		if (!year4.equals("") && !c4year.trim().equals(""))
		{
			if(!strType[i].equalsIgnoreCase("C")&& !strType[i].equalsIgnoreCase("H"))
			{
				strQuery = SQLParser.getSqlQuery("finappvaluescountDSCRsens^"+appno+"^"+year4+'^'+x);
				
				if(rs !=  null)
				{
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				
				if(rs.next())
				{
					
						hshQueryValues=new HashMap();
						intUpdatesize=0;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						if (c4year.trim().equalsIgnoreCase("a"))
						{
							hshQuery.put("strQueryId","finappvaluesup1DSCRsens");
						}
						if (c4year.trim().equalsIgnoreCase("u"))
						{
							hshQuery.put("strQueryId","finappvaluesup2DSCRsens");
						}
						if (c4year.trim().equalsIgnoreCase("e"))
						{
							hshQuery.put("strQueryId","finappvaluesup3DSCRsens");
						}
						if (c4year.trim().equalsIgnoreCase("p"))
						{
							hshQuery.put("strQueryId","finappvaluesup4DSCRsens");
						}
						if(strTemp.equalsIgnoreCase("I") && tempDesc.equals("") && c4year.trim().equalsIgnoreCase("p"))
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year4);					
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
						}
						else if(c4year.trim().equalsIgnoreCase("p"))
						{
							arrValues.add(strRowCol4);//get values from Rowcal field
							arrValues.add(strRowCol4);
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year4);					
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
						}
						else if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
						{
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(appno);
								arrValues.add(correctNull(id[i]));
								//arrValues.add(strDivid);
								arrValues.add(year4);
													
								hshQuery.put("arrValues",arrValues);								
								hshQueryValues.put("size",Integer.toString(intUpdatesize));
								hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						}
						else
						{								
								arrValues.add(strRowCol4);//get values from Rowcal field
								arrValues.add(appno);
								arrValues.add(correctNull(id[i]));
								//arrValues.add(strDivid);
								arrValues.add(year4);
													
								hshQuery.put("arrValues",arrValues);								
								hshQueryValues.put("size",Integer.toString(intUpdatesize));
								hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						}
					
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
				}
				else
				{
					
						hshQueryValues=new HashMap();
						intUpdatesize=0;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","finappDSCRinssens");
						arrValues.add(appno);
						arrValues.add(year4);
						arrValues.add(correctNull(id[i]));
						if (c4year.trim().equalsIgnoreCase("a"))
						{
							if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(test);
							}
							else
							{
								arrValues.add(strRowCol4);//get values from Rowcal field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
							}
						}
						if (c4year.trim().equalsIgnoreCase("u"))
						{
							if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(test);
							}
							else
							{
								arrValues.add(test);
								arrValues.add(strRowCol4);//get values from Rowcal field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
							}
						}
						if (c4year.trim().equalsIgnoreCase("e"))
						{
							
							if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(test);
							}
							else
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(strRowCol4);//get values from Rowcal field
								arrValues.add(test);
								arrValues.add(test);
							}
						}
						if (c4year.trim().equalsIgnoreCase("p"))
						{
							
							if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(test);
							}
							else
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(strRowCol4);//get values from Rowcal field
								arrValues.add(strRowCol4);
							}
						}
						strDivid="0";
						arrValues.add(strDivid);   arrValues.add(""+(i+1));
						hshQuery.put("arrValues",arrValues);						
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("finappvaluescountDSCRsens^"+appno+"^"+year4+'^'+x);
				
				if(rs !=  null)
				{
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				
				if(rs.next())
				{
						hshQueryValues=new HashMap();
						intUpdatesize=0;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						if (c4year.trim().equalsIgnoreCase("a"))
						{
							hshQuery.put("strQueryId","finappvaluesup1DSCRsens");
						}
						if (c4year.trim().equalsIgnoreCase("u"))
						{
							hshQuery.put("strQueryId","finappvaluesup2DSCRsens");
						}
						if (c4year.trim().equalsIgnoreCase("e"))
						{
							hshQuery.put("strQueryId","finappvaluesup3DSCRsens");
						}
						if (c4year.trim().equalsIgnoreCase("p"))
						{
							hshQuery.put("strQueryId","finappvaluesup4DSCRsens");
						}
						if(c4year.trim().equalsIgnoreCase("p"))
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year4);
												
							hshQuery.put("arrValues",arrValues);						
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}
						else
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year4);
												
							hshQuery.put("arrValues",arrValues);						
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}
						
				}
				else
				{
						
						hshQueryValues=new HashMap();
						intUpdatesize=0;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","finappDSCRinssens");
						arrValues.add(appno);
						arrValues.add(year4);
						arrValues.add(correctNull(id[i]));
						if (c4year.trim().equalsIgnoreCase("a"))
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);
						}
						if (c4year.trim().equalsIgnoreCase("u"))
						{
							arrValues.add(test);
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);
						}
						if (c4year.trim().equalsIgnoreCase("e"))
						{
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(test);
						}
						
						if (c4year.trim().equalsIgnoreCase("p"))
						{
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
						}
						strDivid="0";
						arrValues.add(strDivid);   arrValues.add(""+(i+1));
						hshQuery.put("arrValues",arrValues);						
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				}
			}
		}	
		/////
		hshQueryValues=new HashMap();
		intUpdatesize=0;
				
				
		if (!year5.equals("") && !c5year.trim().equals(""))
		{
			if(!strType[i].equalsIgnoreCase("C")&& !strType[i].equalsIgnoreCase("H"))
			{
				strQuery = SQLParser.getSqlQuery("finappvaluescountDSCRsens^"+appno+"^"+year5+'^'+x);
				
				if(rs !=  null)
				{
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				
				if(rs.next())
				{
					
						hshQueryValues=new HashMap();
						intUpdatesize=0;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						if (c5year.trim().equalsIgnoreCase("a"))
						{
							hshQuery.put("strQueryId","finappvaluesup1DSCRsens");
						}
						if (c5year.trim().equalsIgnoreCase("u"))
						{
							hshQuery.put("strQueryId","finappvaluesup2DSCRsens");
						}
						if (c5year.trim().equalsIgnoreCase("e"))
						{
							hshQuery.put("strQueryId","finappvaluesup3DSCRsens");
						}
						if (c5year.trim().equalsIgnoreCase("p"))
						{
							hshQuery.put("strQueryId","finappvaluesup4DSCRsens");
						}

						if(strTemp.equalsIgnoreCase("I") && tempDesc.equals("") && c5year.trim().equalsIgnoreCase("p"))
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year5);					
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
						}
						else if(c5year.trim().equalsIgnoreCase("p"))
						{
							arrValues.add(strRowCol5);//get values from Rowcal field
							arrValues.add(strRowCol5);
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year5);					
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
						}
						else if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
						{								
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(appno);
								arrValues.add(correctNull(id[i]));
								//arrValues.add(strDivid);
								arrValues.add(year5);
													
								hshQuery.put("arrValues",arrValues);								
								hshQueryValues.put("size",Integer.toString(intUpdatesize));
								hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						}
						else
						{								
								arrValues.add(strRowCol5);//get values from Rowcal field
								arrValues.add(appno);
								arrValues.add(correctNull(id[i]));
								//arrValues.add(strDivid);
								arrValues.add(year5);
													
								hshQuery.put("arrValues",arrValues);								
								hshQueryValues.put("size",Integer.toString(intUpdatesize));
								hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						}
					
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
				}
				else
				{					
						hshQueryValues=new HashMap();
						intUpdatesize=0;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","finappDSCRinssens");
						arrValues.add(appno);
						arrValues.add(year5);
						arrValues.add(correctNull(id[i]));
						if (c5year.trim().equalsIgnoreCase("a"))
						{
							if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(test);
							}
							else
							{
								arrValues.add(strRowCol5);//get values from Rowcal field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
							}
						}
						if (c5year.trim().equalsIgnoreCase("u"))
						{
							if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(test);
							}
							else
							{
								arrValues.add(test);
								arrValues.add(strRowCol5);//get values from Rowcal field
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
							}
						}
						if (c5year.trim().equalsIgnoreCase("e"))
						{
							
							if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(test);
							}
							else
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(strRowCol5);//get values from Rowcal field
								arrValues.add(test);
								arrValues.add(test);
							}
						}
						if (c5year.trim().equalsIgnoreCase("p"))
						{
							
							if(strTemp.equalsIgnoreCase("I") && tempDesc.equals(""))
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);//get values from Rowcal field
								arrValues.add(test);
							}
							else
							{
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(test);
								arrValues.add(strRowCol5);//get values from Rowcal field
								arrValues.add(strRowCol5);
							}
						}
						strDivid="0";
						arrValues.add(strDivid);   arrValues.add(""+(i+1));
						hshQuery.put("arrValues",arrValues);						
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("finappvaluescountDSCRsens^"+appno+"^"+year5+'^'+x);
				
				if(rs !=  null)
				{
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				
				if(rs.next())
				{
						hshQueryValues=new HashMap();
						intUpdatesize=0;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						if (c5year.trim().equalsIgnoreCase("a"))
						{
							hshQuery.put("strQueryId","finappvaluesup1DSCRsens");
						}
						if (c5year.trim().equalsIgnoreCase("u"))
						{
							hshQuery.put("strQueryId","finappvaluesup2DSCRsens");
						}
						if (c5year.trim().equalsIgnoreCase("e"))
						{
							hshQuery.put("strQueryId","finappvaluesup3DSCRsens");
						}
						if (c5year.trim().equalsIgnoreCase("p"))
						{
							hshQuery.put("strQueryId","finappvaluesup4DSCRsens");
						}
						if(c5year.trim().equalsIgnoreCase("p"))
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year5);
												
							hshQuery.put("arrValues",arrValues);						
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}
						else
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(appno);
							arrValues.add(correctNull(id[i]));
							//arrValues.add(strDivid);
							arrValues.add(year5);
												
							hshQuery.put("arrValues",arrValues);						
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}
						
				}
				else
				{
						
						hshQueryValues=new HashMap();
						intUpdatesize=0;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","finappDSCRinssens");
						arrValues.add(appno);
						arrValues.add(year5);
						arrValues.add(correctNull(id[i]));
						if (c5year.trim().equalsIgnoreCase("a"))
						{
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);
						}
						if (c5year.trim().equalsIgnoreCase("u"))
						{
							arrValues.add(test);
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);
						}
						if (c5year.trim().equalsIgnoreCase("e"))
						{
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
							arrValues.add(test);
						}
						if (c5year.trim().equalsIgnoreCase("p"))
						{
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);
							arrValues.add(test);//get values from Rowcal field
							arrValues.add(test);
						}
						strDivid="0";
						arrValues.add(strDivid);   arrValues.add(""+(i+1));
						hshQuery.put("arrValues",arrValues);						
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				}
			}
		}
	
	}

	strQuery = SQLParser.getSqlQuery("seldistinctfinYearDSCRSENS^"+appno+"^0");
	if(rs != null)
	{
		rs.close();
	}
	rs=DBUtils.executeQuery(strQuery);
	while(rs.next())
	{
		String strYear=Helper.correctNull(rs.getString("fin_year"));
		strQuery=SQLParser.getSqlQuery("assessselect9DSCRSENS^"+appno+"^"+strYear);
			
		if(rs1 != null)
		{
			rs1.close();
		}
		rs1 = DBUtils.executeQuery(strQuery);
		if (rs1.next())
		{
			if(rs1.getDouble("sumaudit")==0 && rs1.getDouble("sumunaudit")==0 && rs1.getDouble("sumestimated")==0 && rs1.getDouble("sumprojection")==0)
			{
				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize = 1;
				hshQuery.put("strQueryId","finappvaluesdelDSCRSens");
				arrValues.add(appno);
				arrValues.add(strYear);
				arrValues.add("0");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
		}
	}
	
	hshQueryValues=new HashMap();
	intUpdatesize=0;
	
	hshQuery = new HashMap();
	arrValues=new ArrayList();
	intUpdatesize = intUpdatesize+1;
	hshQuery.put("strQueryId","finappdscr_avg_del");
	arrValues.add(appno);
	hshQuery.put("arrValues",arrValues);						
	hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);

	intUpdatesize = intUpdatesize+1;hshQuery = new HashMap();
	hshQuery.put("strQueryId","finappdscr_avg_ins");
	arrValues=new ArrayList();
	arrValues.add(appno);
	arrValues.add("0.00");
	hshQuery.put("arrValues",arrValues);						
	
	
	hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
	hshQueryValues.put("size",Integer.toString(intUpdatesize));
	
	EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");

		}
		catch (Exception e)
		{
			e.printStackTrace();
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
				cf.printStackTrace();
				throw new EJBException("Error closing the connection "+cf.getMessage());
						
			}
		}
		
		
	
    }
    
    
    public HashMap updateDSCRSENSFormula(HashMap hshRequestValues) 
    {	
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs3 = null;
		ResultSet rs4 = null;
		ResultSet rs10 =null;
		ArrayList arrValues=new ArrayList();		
		HashMap hshValues=null;
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		String strQuery="",strValue="";		
		
		String sumaudit="";
		String sumunaudit="";
		String sumestimated="";
		String sumprojection="";
		String sel_divID="";
		String pagetab="";
		int intUpdatesize =0;	
		//String finance_id="";
	
	try
	{	
		strValue=correctNull((String)hshRequestValues.get("appno"));
		sel_divID=correctNull((String)hshRequestValues.get("sel_divID"));
		if(sel_divID.equalsIgnoreCase(""))
		{
			sel_divID="0";
		}
		String page = correctNull((String)hshRequestValues.get("pageval"));
		pagetab=Helper.correctNull(page);
			
		hshValues = new HashMap();
		ArrayList vecVal=new ArrayList();
		//ArrayList vecRec=new ArrayList();		
		ArrayList vecid = new ArrayList();
	    hshValues.put("sel_divID",sel_divID);
				
		
		//--------------- to find the cma format of the particular applications-------

		String cma="";
	

		
		/*
		if(!strValue.equals(""))
		{
			if(finance_id.equals(""))
			{
				String query1 = SQLParser.getSqlQuery("comdemographics_sel^"+strValue);
				rs = DBUtils.executeQuery(query1);
			
				if(rs.next())
				{		
					finance_id=(Helper.correctNull((String)rs.getString("demo_finstandard")));
					strValue=(Helper.correctNull((String)rs.getString("demo_finstandard")));
				}
			}
		}
	*/
		if(cma.equalsIgnoreCase(""))
		{
			if(rs != null)
			{
				rs.close();
			}
			
			if(!strValue.equals(""))
			{
			strQuery=SQLParser.getSqlQuery("fin_cmano_select^"+strValue);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{  
				
				cma=Helper.correctNull((String)rs.getString("fin_cmano"));
			}
			}
		}


		/*
			strQuery=SQLParser.getSqlQuery("comfintrendsel1^"+strValue);
			//strQuery = SQLParser.getSqlQuery("finselect8^"+strValue);
			if(rs != null)
			{
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			 
			while(rs.next())
			{  
				cma=rs.getString("demo_finstandard");
			}
		
			if(cma.equalsIgnoreCase("5"))
			{
				if(pagetab.equalsIgnoreCase(""))
				{
				pagetab="INFRA STRUCTURE MODEL";
				}
			}
		//}
		*/
		String yearselect="",seloption="",givenyear="";
		int i = 0,k=0;
		int from = 0,p=0;
		ArrayList vecrec = new ArrayList();
		givenyear = correctNull((String)hshRequestValues.get("from"));
		if (givenyear.equals(""))
		{
			givenyear="0";
		}
		from = Integer.parseInt(givenyear);
		if (from == 0)
		{
			from = 1;
		}
		
		    	String valarray[] = new String[6];		    	
			   	valarray[0] ="0";
				valarray[1] ="0";
				valarray[2] ="0";
				valarray[3] ="0";
				valarray[4] ="0";
		
	//this code has been commented by balaji & shanmugam for get all the year for all the sub tags
	//and new line has been added bellow
				
//		strQuery = SQLParser.getSqlQuery("finselect4^"+page+"^"+masterpage+"^"+strValue);
		strQuery = SQLParser.getSqlQuery("finYearSelDSCRSENS^"+strValue);

		if(rs != null)
		{
			rs.close();
		}
		rs=DBUtils.executeQuery(strQuery);
		while(rs.next())
		{
				valarray[0] ="0";
				valarray[1] ="0";
				valarray[2] ="0";
				valarray[3] ="0";
				valarray[4] ="0";					
				vecVal = new ArrayList();	
				String desc="";			
				yearselect = (String)Helper.correctNull(rs.getString("fin_year"));
			
			if(!yearselect.equals(""))
			{
				
				if(rs3 != null)
				{
					rs3.close();
				}

				String strQuery10 = SQLParser.getSqlQuery("assessselect9DSCRSENS^"+strValue+"^"+yearselect);
				if(rs10 != null)
				{
					rs10.close();
				}
				
				rs10 = DBUtils.executeQuery(strQuery10);
				if (rs10.next())
				{
					 sumaudit=Helper.correctDouble(rs10.getString("sumaudit"));
					 sumunaudit=Helper.correctDouble(rs10.getString("sumunaudit"));
					 sumestimated=Helper.correctDouble(rs10.getString("sumestimated"));
					 sumprojection=Helper.correctDouble(rs10.getString("sumprojection"));
				}
				if (valarray[0].equals("0") && !sumaudit.equals("0"))
				{
					valarray[0]="fin_audit";
				}
				if (valarray[1].equals("0") && !sumunaudit.equals("0"))
				{
					valarray[1]="fin_unaudit";
				}
				if (valarray[2].equals("0") && !sumestimated.equals("0"))
				{
					valarray[2]="fin_estimated";
				}
				if (valarray[3].equals("0") && !sumprojection.equals("0"))
				{
					valarray[3]="fin_projection";
				}
				if (valarray[4].equals("0") && !sumprojection.equals("0"))
				{
					valarray[4]="fin_projection";
				}			
						
				if(rs10!=null)
				{
					rs10.close();
				}
				

			for (int h=0;h<4;h++)
			{
				vecVal = new ArrayList();
				vecid  = new ArrayList();
				
				if(valarray[h].equals(""))
				{
				valarray[h]="0.00";
				}
				if (!valarray[h].equals("0"))
				{
					i=i+1;
					seloption=valarray[h];
					if ((i >=  from) && (k < 5) )
					{
						p=i;
						k=k+1;
					
						strQuery = SQLParser.getSqlQuery("testfinselect5DSCRSENS^"+seloption+"^"+"1"+"^"+yearselect+"^"+strValue);
						
						if(rs1 != null)
						{
							rs1.close();
						}						
						rs1=DBUtils.executeQuery(strQuery);
						while (rs1.next())
						{
								if (seloption.equals("fin_audit"))
								{
								desc="a";
								}
								else if (seloption.equals("fin_unaudit"))
								{
								desc="u";
								}
								else if (seloption.equals("fin_estimated"))
								{
								desc="e";
								}
								else if (seloption.equals("fin_projection"))
								{
								desc="p";
								}
								int formuladesc=0;	
								String fin_rowid="";
								formuladesc =(rs1.getInt("formula")) ;		
								
								//
								fin_rowid=Helper.correctNull(rs1.getString("fin_rowid"));
								//
								if (formuladesc > 0 )
								{
								    HashMap hshformula =  new HashMap();
									hshformula.put("appno",strValue);
									hshformula.put("sel_divID",sel_divID);
									hshformula.put("formulaid",Integer.toString(formuladesc));
									hshformula.put("curryear",yearselect);
									hshformula.put("prevyear"," ");
									hshformula.put("currfinancialtype",desc);
									hshformula.put("prevfinancialtype","a");
									hshformula.put("internalcalc","N");
									hshformula.put("hshdata",new HashMap());
									hshformula.put("pagetype","SENS");
									//HashMap hshRes = (HashMap)EJBInvoker.executeStateLess("dscr",hshformula,"GetFinValue");
									HashMap hshRes =GetFinValue(hshformula);
									String strTotalValue=correctNull((String)hshRes.get("strTotalValue"));
									vecVal.add(correctNull((String)hshRes.get("strTotalValue")));
									vecid.add(correctNull(rs1.getString("fin_rowid")));
																
									/**
									 * By venu
									 * Storing financial calculated data into tables
									 */
									hshQueryValues=new HashMap();
									intUpdatesize=0;
									hshQuery = new HashMap();
									arrValues=new ArrayList();
									intUpdatesize = intUpdatesize+1;
									if (seloption.equals("fin_audit"))
									{
										hshQuery.put("strQueryId","finappvaluesup1DSCRsens");
									}
									if (seloption.equals("fin_unaudit"))
									{
										hshQuery.put("strQueryId","finappvaluesup2DSCRsens");
									}
									if (seloption.equals("fin_estimated"))
									{
										hshQuery.put("strQueryId","finappvaluesup3DSCRsens");
									}
									if (seloption.equals("fin_projection"))
									{
										hshQuery.put("strQueryId","finappvaluesup4DSCRsens");
									}
											
									if(seloption.equals("fin_projection"))
									{
										arrValues.add(strTotalValue);//get values from Rowcal field
										arrValues.add(strTotalValue);//get values from Rowcal field
										arrValues.add(strValue);
										arrValues.add(fin_rowid);
										//arrValues.add(sel_divID);
										arrValues.add(yearselect);
															
										hshQuery.put("arrValues",arrValues);						
										hshQueryValues.put("size",Integer.toString(intUpdatesize));
										hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
										EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
									}
									else
									{
										arrValues.add(strTotalValue);//get values from Rowcal field
										arrValues.add(strValue);
										arrValues.add(fin_rowid);
										//arrValues.add(sel_divID);
										arrValues.add(yearselect);
															
										hshQuery.put("arrValues",arrValues);						
										hshQueryValues.put("size",Integer.toString(intUpdatesize));
										hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
										EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
									}
									
															
								}
								hshValues.put("year"+k,vecVal);	
								hshValues.put("vecid"+k,vecid);		
														
						
							}
					
							if(rs1!=null)
							{
								rs1.close();
							}
							vecrec.add(yearselect);
							vecrec.add(seloption);
					}

				}
			}
		}
	}

		/*calculate Avg DSCR 
		 * 
		 */
		strQuery = SQLParser.getSqlQuery("sel_com_finappdscrSENS^"+strValue);	
		if(rs!=null)
		{
		rs.close();	
		}
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			String AvgDSCR="";
			
			double TotDSCR=0.00,avg=0.00;
			double count1=0.00;
			TotDSCR=Double.parseDouble(Helper.correctDouble(rs.getString("avgdscr")));
			
			String str=SQLParser.getSqlQuery("count_finappdscrsens_year^"+strValue);	
			if(rs1!=null)
			{
				rs1.close();
			}
			rs1=DBUtils.executeQuery(str);
			if(rs1.next())
			{
				count1=Double.parseDouble(Helper.correctInt(rs1.getString("cols")));
			}
			else
			{
				count1=1.00;
			}
			if(count1!=0){avg=TotDSCR/count1;}
			AvgDSCR=""+nf.format(avg);
			
			hshQueryValues=new HashMap();
			intUpdatesize=0;
			
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			intUpdatesize = intUpdatesize+1;
			hshQuery.put("strQueryId","finappdscrsens_avg_del");
			arrValues.add(strValue);
			hshQuery.put("arrValues",arrValues);						
			hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);

			intUpdatesize = intUpdatesize+1;hshQuery = new HashMap();
			hshQuery.put("strQueryId","finappdscrsens_avg_ins");
			arrValues=new ArrayList();
			arrValues.add(strValue);
			arrValues.add(AvgDSCR);
			hshQuery.put("arrValues",arrValues);						
			
			
			hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
			hshQueryValues.put("size",Integer.toString(intUpdatesize));
			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			hshValues.put("DscrAvg",AvgDSCR);
	
		}
		if(rs!=null){rs.close();}
		
		
	}
		catch(Exception ce)
		{
			ce.printStackTrace();
			throw new EJBException("Error in getData login  "+ce.toString());
			
		}
		finally
		{
			try
			{	
				if(rs != null)
					rs.close();
				if(rs1 != null)
					rs1.close();
				if(rs3 != null)
					rs3.close();
				if(rs4 != null)
					rs4.close();
				if(rs10 != null)
					rs10.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		hshValues.put("tabname",pagetab);

		return hshValues; 
	
}
    
    
    public HashMap getPrintSensitivityVal(HashMap hshRequestValues) 
    {
    	ResultSet rs=null;
    	ResultSet rs1=null;
    	ResultSet rs2=null;
    	String strQuery="",appno="",strQuery1="";
    	HashMap hshValues=new HashMap();
    	ArrayList vecRec=new ArrayList();
    	ArrayList vecVal=new ArrayList();
    	String tempsno="",year1="";
    	ArrayList vecYear=new ArrayList();
    	ArrayList VecValue=new ArrayList();
    	double sumaudit=0.00,sumunaudit=0.00,sumestimated=0.00,sumprojection=0.00;
    	String FinType="";
    	try
    	{
    		appno=correctNull((String)hshRequestValues.get("appno"));
    		
    		strQuery = SQLParser.getSqlQuery("finselect2a^"+"1"+"^"+"DSCR");
			
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
					vecRec = new ArrayList();
					vecRec.add(correctNull(rs.getString("fin_rowid")));
					vecRec.add(correctNull(rs.getString("fin_rowdesc")));
					vecRec.add(correctNull(rs.getString("fin_rowtype")));
					tempsno = correctNull(rs.getString("fin_sno"));
					if (tempsno.trim().equals(""))
					{
						tempsno=" ";
					}
					
					vecRec.add(tempsno);
					vecVal.add(vecRec);								
			}
			hshValues.put("labeldetails",vecVal);
			vecVal=new ArrayList();
			if(rs != null)
			{
				rs.close();
			}
		
			strQuery1=SQLParser.getSqlQuery("finYearSelDSCRSENS^"+appno);
			rs1=DBUtils.executeQuery(strQuery1);
			while(rs1.next())
			{
				year1=Helper.correctNull((String)rs1.getString("fin_year"));
				if(rs!=null){rs.close();}
				strQuery=SQLParser.getSqlQuery("com_finappdscrsens_print_sel^"+appno+"^"+year1);
				rs=DBUtils.executeQuery(strQuery);
				VecValue=new ArrayList();
				vecYear=new ArrayList();
				while(rs.next())
				{
					String tempValue=""+nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("fin_value"))));
					VecValue.add(tempValue);
				}
				
				
				if(rs2!=null){rs.close();}
				strQuery = SQLParser.getSqlQuery("assessselect9DSCRSENS^"+appno+"^"+year1);
				rs2=DBUtils.executeQuery(strQuery);
				if (rs2.next())
				{
					 sumaudit=Double.parseDouble(Helper.correctDouble(rs2.getString("sumaudit")));
					 sumunaudit=Double.parseDouble(Helper.correctDouble(rs2.getString("sumunaudit")));
					 sumestimated=Double.parseDouble(Helper.correctDouble(rs2.getString("sumestimated")));
					 sumprojection=Double.parseDouble(Helper.correctDouble(rs2.getString("sumprojection")));
				}
				if(sumaudit>0.00)
				{
					FinType="Audited";
				}
				else if(sumunaudit>0.00)
				{ 
					FinType="Unaudited / Provisional";
				}
				else if(sumestimated>0.00)
				{
					FinType="Estimated";
				}
				else
				{
					FinType="Projection";
				}
				vecYear.add(year1);
				vecYear.add(FinType);
				vecYear.add(VecValue);
				vecVal.add(vecYear);
			}
			hshValues.put("TableValues", vecVal);
			if(rs2!=null)
			{
				rs2.close();
			}
			if(rs!=null){rs.close();}
			
			strQuery = SQLParser.getSqlQuery("com_finappdscrsens_Avg_sel^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshValues.put("DscrAvg", nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("com_avgdscr")))));
			}
			else
			{
				hshValues.put("DscrAvg", "0.00");
			}
			
    		if(rs!=null)
    		{
    			rs.close();
    		}
    		if(rs1!=null)
    		{
    			rs1.close();
    		}
    	}catch(Exception ex)
    	{
    		throw new EJBException("Exception in getPrintValues : "+ex);
    	}
    	
    	
    	return hshValues;
    }  
    
    public void updateDSCRSensitivityTableUpdate(HashMap hsh) 
	{		
		ResultSet rs = null;
		String strQuery="";
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		String year1="",year2="",year3="",year4="",year5="";
		String c1year="",c2year="",c3year="",c4year="",c5year="";
		int intUpdatesize =0;		
		String appno="";		
					
		String strDivid="";		
		ResultSet rs1=null;
		String strQuery1="",strQuery2="";
		
		String strpageType="";
		strpageType=Helper.correctNull((String)hsh.get("hidPageName"));
		String strFlag="";
		try
		{				
			appno=correctNull((String)hsh.get("appno"));
			strDivid=correctNull((String )hsh.get("sel_divID"));
			year1=correctNull((String)hsh.get("hidyear1"));
			year2=correctNull((String)hsh.get("hidyear2"));
			year3=correctNull((String)hsh.get("hidyear3"));
			year4=correctNull((String)hsh.get("hidyear4"));
			year5=correctNull((String)hsh.get("hidyear5"));
			
			c1year=correctNull((String)hsh.get("hidtype1"));
			c2year=correctNull((String)hsh.get("hidtype2"));
			c3year=correctNull((String)hsh.get("hidtype3"));
			c4year=correctNull((String)hsh.get("hidtype4"));
			c5year=correctNull((String)hsh.get("hidtype5"));				
			
			String stryear []={year1,year2,year3,year4,year5};
			
			if(strDivid.equalsIgnoreCase(""))
			{
				strDivid="0";
			}
		
						
			if(strpageType.equalsIgnoreCase("DSCR.jsp"))
			{
				strFlag="D";
			}
			else
			{
				strFlag="S";
			}
			String year="";
			for(int i=0;i<stryear.length;i++)
			{
				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize = 1;
				if(i==0) year = c1year;
				else if(i==1) year = c2year;
				else if(i==2) year = c3year;
				else if(i==3) year = c4year;
				else if(i==4) year = c5year;
				
				if(!year.equalsIgnoreCase(""))
				{
					if (year.trim().equalsIgnoreCase("a"))
					{
						if(strFlag.equalsIgnoreCase("D"))
						{
						   hshQuery.put("strQueryId","finappvaluesdel1DSCR");  
						}
						else
						{
							hshQuery.put("strQueryId","finappvaluesdel1DSCRSENS");
							
						}
					}
					if (year.trim().equalsIgnoreCase("u"))
					{
						if(strFlag.equalsIgnoreCase("D"))
						{
						  hshQuery.put("strQueryId","finappvaluesdel2DSCR");
						}
						else
						{
							hshQuery.put("strQueryId","finappvaluesdel2DSCRSENS");
						}
					}
					if (year.trim().equalsIgnoreCase("e"))
					{
						if(strFlag.equalsIgnoreCase("D"))
						{
						   hshQuery.put("strQueryId","finappvaluesdel3DSCR");
						}
						else
						{
							hshQuery.put("strQueryId","finappvaluesdel3DSCRSENS");
							
						}
					}
					if (year.trim().equalsIgnoreCase("p"))
					{
						if(strFlag.equalsIgnoreCase("D"))
						{
						  hshQuery.put("strQueryId","finappvaluesdel4DSCR");
						}
						else
						{
							hshQuery.put("strQueryId","finappvaluesdel4DSCRSENS");
						}
					}
					arrValues.add("0");
					arrValues.add(appno);
					arrValues.add(stryear[i]);					
					arrValues.add(strDivid);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
			}
			
			
			if(rs!=null){rs.close();}
		}
		catch (Exception e)
		{
			log.error("in bean"+e);
			throw new EJBException("Error in updateDSCRSensitivityTableUpdate " + e.getMessage());
		}
	
		
	}
    
}
