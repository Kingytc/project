package com.sai.laps.ejb.corpexecutivesummarypdf;

import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.lowagie.text.Cell;
import com.lowagie.text.Document;
import com.lowagie.text.PageSize;
import com.lowagie.text.Phrase;
import com.lowagie.text.Table;
import com.sai.fw.management.utils.FwHelper;
import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.helper.report.ReportConstants;
import com.sai.laps.helper.report.ReportGenerator;
import com.sai.laps.helper.report.ReportManager;
@Stateless(name = "ExecutiveSummaryBean", mappedName = "ExecutiveSummaryHome")
@Remote (ExecutiveSummaryRemote.class)
public class ExecutiveSummaryBean extends BeanAdapter {
	/**
	 * 
	 */
	//
	private static final long serialVersionUID = 1L;
	
	
	static Logger log=Logger.getLogger(ExecutiveSummaryBean.class);
	
	public HashMap getExecutiveSummaryData(HashMap hshValues) 
	{
		
		 java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
	      nf.setGroupingUsed(false);
	      nf.setMaximumFractionDigits(2);
	      nf.setMinimumFractionDigits(2);
		Document document=null;
		Cell cell=null;
		Table table=null;
		ResultSet rs = null,rs1=null,rs2=null,rs5=null;
		ArrayList arrUnitsworks= new ArrayList();
		ArrayList arrTmpList = new ArrayList();
		ArrayList arrPromotors = new ArrayList();
		ArrayList arrRow = new ArrayList();
		ArrayList arrData = new ArrayList();
		ArrayList arrVec4 = new ArrayList();
		ArrayList arrGuarantors = new ArrayList();
		ArrayList arrCorpguarantee = new ArrayList();
		ArrayList arrProback = new ArrayList();
		ArrayList arrVec = new ArrayList();
		ArrayList arrRow15 = new ArrayList();
		ArrayList arrworkingCol = new ArrayList();
		ArrayList arrworkingRow = new ArrayList();
		ArrayList arrtermsRow = new ArrayList();
		ArrayList arrtermsCol =  new ArrayList();
		ArrayList arrRow1 = new ArrayList();
		ArrayList arrVec1 = new ArrayList();
		ArrayList arrVec2 = new ArrayList();
		ArrayList arrRow2 = new ArrayList();
		ArrayList arrRow16 = new ArrayList();
		ArrayList arrVecRate = new ArrayList();
		ArrayList arryCol = new ArrayList();
		ArrayList arrColldetails = new ArrayList();
		ArrayList arrValues = new ArrayList();
		HashMap hshValueFinancial = new HashMap();
		HashMap hshformula = new HashMap();
		HashMap hshResult =new HashMap();
		HashMap hashformula = new HashMap();
		String strAppno="",comappid="",strGroup="",strstatusbanking="",strTemp="",strpropleadbank="",strpropdevrevdate=""
		,strtotalfundedexi="",strtotalnonfundedexi="",strtotalfundedprop="",strtotalnonfundedprop="",
		strconsortiumassessment="",strcompropassettype="",strstatusofacc="",strBranchName="",strRegCity="",
		strRegCityDesc="",strRegState="",strRegStateDesc="",strConstitution="",strbgroundpromoters="",strauthcaptial="",
		strappsubcapital="",strbookvalue="",strmarketvalue="",strownership="",strownership1="",strProposalvalue="",
		strcompanyid="",strsearchreport="",strduediligence="",strdealbank="",strcreditsince="",strConstitutionCode="",
		strexecborrtype="",strauditnotes="",strindservices="",strIndcode="",sel_applicantguarantee="";
		String strQuery="";
		String strnegflag="n";
		String selrbi4="",strComDesc="",strOtherMatters="",strExposureNorms="",strExecSancauth="",
		strExecAagendano="",strExecMcm="";
		double dblTotalshares=0.00,dblgrpsanctionedlimit=0.0,dblgrpos=0.0,dblgrpexposure=0.0,dblBankcreditexposure=0.0,
		dblgrpremainig=0.0;
		boolean flag=false,bflag1=false,bflag2=false;
		try
		{
			strAppno=correctNull((String)hshValues.get("strappno"));
			comappid=correctNull((String)hshValues.get("comappid"));
			
			ReportManager rm = new ReportManager();
			document=ReportGenerator.getCustomizeInstance(PageSize.A4, 37, 27, 20, 20);
			
			strQuery = SQLParser.getSqlQuery("comfunsel3^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			
			if(rs.next())
			{
				comappid=correctNull(rs.getString("demo_appid"));
			}
			
			strQuery = SQLParser.getSqlQuery("execsel_port^" + strAppno);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				strExecSancauth=correctNull(rs.getString("exec_sancauth"));
				strExecAagendano=correctNull(rs.getString("exec_agendano"));
				strExecMcm= correctNull(rs.getString("exec_mcm"));
			}
			if(rs!=null)
				rs.close();
			
			
			if (strExecSancauth.equals("7")) 
			{
				table=new Table(2);
				table.setPadding(1.0f);
				table.setBorderWidth(0.0f);
				table.setAutoFillEmptyCells(true);
				table.setWidth(100.0f); 
				table.setCellsFitPage(true);
				table.setTableFitsPage(true);
				
				cell=new Cell(new Phrase("Agenda Item No: "+strExecAagendano,ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(2);
				cell.setColspan(2);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("MCM of: "+strExecMcm,ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(2);
				cell.setColspan(2);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				
				document.add(table);
				table=null;
			}
						
			
			
			document.add(ReportGenerator.createPDFImage(1,50.0f));
			
			
			strQuery = SQLParser.getSqlQuery("applicant_create_code^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strBranchName=correctNull((String)rs.getString("org_name"));
			}
			
			if (rs != null) {
				rs.close();
			}
			
			
			
			table=new Table(2);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f); 
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			cell=new Cell(new Phrase("Branch / Office,"+strBranchName,ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(1);
			cell.setColspan(2);
			cell.setBorder(0);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(1);
			cell.setColspan(2);
			cell.setBorder(0);
			table.addCell(cell);
			cell=null;
			
			document.add(table);
			table=null;
			
			if(strExecSancauth.equalsIgnoreCase("5") || strExecSancauth.equalsIgnoreCase("6") || strExecSancauth.equalsIgnoreCase("7"))
			{
				table=new Table(2);
				table.setPadding(1.0f);
				table.setBorderWidth(0.0f);
				table.setAutoFillEmptyCells(true);
				table.setWidth(20.0f); 
				table.setBorder(1);
				table.setAlignment(2);
				table.setCellsFitPage(true);
				table.setTableFitsPage(true);
				bflag1=true;
			}
			else if(strExecSancauth.equalsIgnoreCase("4"))
			{
				table=new Table(1);
				table.setPadding(1.0f);
				table.setBorderWidth(0.0f);
				table.setAutoFillEmptyCells(true);
				table.setWidth(10.0f); 
				table.setBorder(1);
				table.setAlignment(2);
				table.setCellsFitPage(true);
				table.setTableFitsPage(true);
				bflag2=true;
			}
			
			
			boolean flag5=false;
			
			if (strExecSancauth.equals("4") || strExecSancauth.equals("5"))
			{
				if(bflag1==true)
				{
					cell=new Cell(new Phrase(".",ReportConstants.REPORT_FONT_COLOR_WHITE_9));
					cell.setHorizontalAlignment(0);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase(".",ReportConstants.REPORT_FONT_COLOR_WHITE_9));
					cell.setHorizontalAlignment(0);
					table.addCell(cell);
					cell=null;
					
					flag5=true;
				}
				else
				{
					cell=new Cell(new Phrase(".",ReportConstants.REPORT_FONT_COLOR_WHITE_9));
					cell.setHorizontalAlignment(0);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase("GM",ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(1);
					table.addCell(cell);
					cell=null;
				}
				
				
			}
			if (strExecSancauth.equals("5") || strExecSancauth.equals("6")|| strExecSancauth.equals("7")) 
			{
				if(flag5==true)
				{
					cell=new Cell(new Phrase("GM",ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(1);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase("E.D.",ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(1);
					table.addCell(cell);
					cell=null;
				}
				else
				{
					cell=new Cell(new Phrase(".",ReportConstants.REPORT_FONT_COLOR_WHITE_9));
					cell.setHorizontalAlignment(0);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase(".",ReportConstants.REPORT_FONT_COLOR_WHITE_9));
					cell.setHorizontalAlignment(0);
					table.addCell(cell);
					cell=null;
				}
				
			}
			if (strExecSancauth.equals("6") || strExecSancauth.equals("7")) 
			{
				cell=new Cell(new Phrase("E.D.",ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(1);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("CMD",ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(1);
				table.addCell(cell);
				cell=null;
				
			
			}
			if(strExecSancauth.equalsIgnoreCase("4") || strExecSancauth.equalsIgnoreCase("5") || strExecSancauth.equalsIgnoreCase("6") || strExecSancauth.equalsIgnoreCase("7"))
			{
				document.add(table);
				table=null;
			}
	
			table=new Table(2);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f); 
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			cell=new Cell(new Phrase("MEMORANDUM TO THE COMPETENT AUTHORITY FOR APPROVAL",ReportConstants.REPORT_FONT_BOLD_UNDERLINE_12));
			cell.setHorizontalAlignment(1);
			cell.setColspan(2);
			cell.setBorder(0);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("PROPOSAL FOR: SANCTION/RENEWAL/MODIFICATIONS",ReportConstants.REPORT_FONT_BOLD_UNDERLINE_12));
			cell.setHorizontalAlignment(1);
			cell.setColspan(2);
			cell.setBorder(0);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase(".",ReportConstants.REPORT_FONT_COLOR_WHITE_9));
			cell.setHorizontalAlignment(1);
			cell.setColspan(2);
			cell.setBorder(0);
			table.addCell(cell);
			cell=null;
			
			document.add(table);
			table=null;
			
			table=new Table(2);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f); 
			table.setBorder(1);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			cell=new Cell(new Phrase("Present Request:",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(0);
			cell.setColspan(2);
			table.addCell(cell);
			cell=null;
			
			strQuery = SQLParser.getSqlQuery("selprosalvaluesin^"+strAppno);
 			if(rs!=null)
 			{
 				rs.close();
 			}
 			String Strproposalvaluesin="";
 			rs = DBUtils.executeQuery(strQuery);
 			if(rs.next())
 			{
 				Strproposalvaluesin=correctNull(rs.getString("prop_valuesin"));
 			}
 			
 			if(rs!=null)
 			{
 				rs.close();
 			}
 			
 			if (strProposalvalue.equalsIgnoreCase("C"))
				strProposalvalue = "Crores";
			else
				strProposalvalue = "Lacs";
			
			strQuery = SQLParser.getSqlQuery("execsel_port^" + strAppno);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				strsearchreport=correctNull(rs.getString("cmd_searchreport"));
				strduediligence=correctNull(rs.getString("due_diligence"));
				strcreditsince=correctNull(rs.getString("credit_since"));
				strexecborrtype=correctNull(rs.getString("exec_borrowertype"));
				sel_applicantguarantee= correctNull(rs.getString("exec_whetherapplco"));
				if(!correctNull((String)rs.getString("audit_notes")).equalsIgnoreCase(""))
				{
					strauditnotes= correctNull(Helper.CLOBToString(rs.getClob("audit_notes")));
				}
				else
				{
					strauditnotes="";
				}
				if(!correctNull(rs.getString("exec_presentreq")).equalsIgnoreCase(""))
				{
					cell=new Cell(new Phrase(correctNull(rs.getString("exec_presentreq")),ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(0);
					cell.setColspan(2);
					table.addCell(cell);
					cell=null;
				}
				else
				{
					cell=new Cell(new Phrase("Nil",ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(0);
					cell.setColspan(2);
					table.addCell(cell);
					cell=null;
				}
				
				cell=new Cell(new Phrase("Ref No:"+correctNull((String) rs.getString("exec_refno")),ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(0);
				cell.setColspan(1);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("Date:"+correctNull((String) rs.getString("exec_date")),ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(2);
				cell.setColspan(1);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
			}
			else
			{
				cell=new Cell(new Phrase("Nil",ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				cell.setColspan(2);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("Ref No:",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(0);
				cell.setColspan(1);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("Date:",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(2);
				cell.setColspan(1);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
			}
			
			if(rs!=null)
				rs.close();
			
			document.add(table);
			table=null;
			
			table=new Table(5);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f); 
			table.setBorder(1);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			strQuery = SQLParser.getSqlQuery("comappmastersel^" + comappid);

			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				
				strGroup=correctNull((String)rs.getString("comapp_group"));
				strcompanyid=correctNull((String)rs.getString("comapp_companyid"));
				strdealbank=correctNull(rs.getString("comapp_bankdealing"));
				strIndcode=correctNull(rs.getString("comapp_indcode"));
			}
			
			cell=new Cell(new Phrase("GROUP",ReportConstants.REPORT_FONT_NORMAL));
			cell.setHorizontalAlignment(0);
			cell.setColspan(1);
			table.addCell(cell);
			cell=null;
			if(!strGroup.equalsIgnoreCase(""))
			{
				cell=new Cell(new Phrase(strGroup,ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				cell.setColspan(4);
				table.addCell(cell);
				cell=null;
			}
			else
			{
				cell=new Cell(new Phrase(".",ReportConstants.REPORT_FONT_COLOR_WHITE_9));
				cell.setHorizontalAlignment(0);
				cell.setColspan(4);
				table.addCell(cell);
				cell=null;
			}
			
			strQuery = SQLParser.getSqlQuery("comoperationaldata1^" + strAppno);

			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				
				strTemp=correctNull(rs.getString("com_propmulbank"));
				strstatusbanking=strTemp.equals("1")?"Sole":strTemp.equals("2")?"Consortium":strTemp.equals("3")?"Multiple":strTemp.equals("4")?"Sole / Consortium":strTemp.equals("5")?"Sole / Multiple":strTemp.equals("6")?"Consortium / Multiple":strTemp.equals("7")?"Sole/ Consortium / Multiple":"";
				strpropleadbank= correctNull(rs.getString("com_propleadbank")).equals("")?"N.A":correctNull(rs.getString("com_propleadbank"));
				strpropdevrevdate=correctNull(rs.getString("com_propdevrevdate1")).equals("January  -1900")?"N.A.":correctNull(rs.getString("com_propdevrevdate1"));
				String exfb = correctNull(rs.getString("com_propexistfb"));
				String exnfb = correctNull(rs.getString("com_propexistnfb"));
				strtotalfundedexi =Helper.formatDoubleValue(rs.getDouble("com_propexistfb"));
				strtotalnonfundedexi=Helper.formatDoubleValue(rs.getDouble("com_propexistnfb"));
				strtotalfundedprop=Helper.formatDoubleValue(rs.getDouble("com_propproposedfb"));
				strtotalnonfundedprop=Helper.formatDoubleValue(rs.getDouble("com_propproposednfb"));
				strconsortiumassessment=Helper.CLOBToString(rs.getClob("com_bankingremarks"));
			}
			
			strQuery = SQLParser.getSqlQuery("compropform8^" + strAppno);

			if (rs != null) 
			{
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				strcompropassettype=correctNull(rs.getString("com_propassettype")).equals("")?"Standard":correctNull(rs.getString("com_propassettype"));
			}
			
			cell=new Cell(new Phrase("BANKING",ReportConstants.REPORT_FONT_NORMAL));
			cell.setHorizontalAlignment(0);
			cell.setColspan(1);
			table.addCell(cell);
			cell=null;
			if(!strstatusbanking.equalsIgnoreCase(""))
			{
				cell=new Cell(new Phrase(strstatusbanking,ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
			}
			else
			{
				cell=new Cell(new Phrase(".",ReportConstants.REPORT_FONT_COLOR_WHITE_9));
				cell.setHorizontalAlignment(0);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
			}
			
			cell=new Cell(new Phrase("LEAD BANK",ReportConstants.REPORT_FONT_NORMAL));
			cell.setHorizontalAlignment(0);
			cell.setColspan(1);
			table.addCell(cell);
			cell=null;
			if(!strpropleadbank.equalsIgnoreCase(""))
			{
				cell=new Cell(new Phrase(strpropleadbank,ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				cell.setColspan(2);
				table.addCell(cell);
				cell=null;
			}
			else
			{
				cell=new Cell(new Phrase(".",ReportConstants.REPORT_FONT_COLOR_WHITE_9));
				cell.setHorizontalAlignment(0);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
			}
			
			
			if(strstatusbanking.contains("Consortium"))
			{
				cell=new Cell(new Phrase("MONTH OF REVIEW",ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
				if(!strpropdevrevdate.equalsIgnoreCase(""))
				{
					cell=new Cell(new Phrase(strpropdevrevdate,ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(0);
					cell.setColspan(1);
					table.addCell(cell);
					cell=null;
				}
				else
				{
					cell=new Cell(new Phrase(".",ReportConstants.REPORT_FONT_COLOR_WHITE_9));
					cell.setHorizontalAlignment(0);
					cell.setColspan(1);
					table.addCell(cell);
					cell=null;
				}
				
				cell=new Cell(new Phrase("OUR SHARE",ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("EXISTING",ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("PROPOSED",ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
			}
			else
			{
				cell=new Cell(new Phrase("MONTH OF REVIEW",ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
				
				if(!strpropdevrevdate.equalsIgnoreCase(""))
				{
					cell=new Cell(new Phrase(strpropdevrevdate,ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(0);
					cell.setColspan(4);
					table.addCell(cell);
					cell=null;
				}
				else
				{
					cell=new Cell(new Phrase(".",ReportConstants.REPORT_FONT_COLOR_WHITE_9));
					cell.setHorizontalAlignment(0);
					cell.setColspan(4);
					table.addCell(cell);
					cell=null;
				}
				
			
			}
			if(strstatusbanking.contains("Consortium"))
			{
				cell=new Cell(new Phrase("ASSET CLASSIFICATION",ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				cell.setColspan(1);
				cell.setRowspan(3);
				table.addCell(cell);
				cell=null;
				
				if(!strcompropassettype.equalsIgnoreCase(""))
				{
					cell=new Cell(new Phrase(strcompropassettype,ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(0);
					cell.setColspan(1);
					cell.setRowspan(3);
					table.addCell(cell);
					cell=null;
				}
				else
				{
					cell=new Cell(new Phrase(".",ReportConstants.REPORT_FONT_COLOR_WHITE_9));
					cell.setHorizontalAlignment(0);
					cell.setColspan(1);
					cell.setRowspan(3);
					table.addCell(cell);
					cell=null;
				}
				
				cell=new Cell(new Phrase("Fund based",ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				cell.setColspan(1);
				cell.setRowspan(2);
				table.addCell(cell);
				cell=null;
				if(!strtotalfundedexi.equalsIgnoreCase(""))
				{
					cell=new Cell(new Phrase(strtotalfundedexi+" %",ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(0);
					cell.setColspan(1);
					cell.setRowspan(2);
					table.addCell(cell);
					cell=null;
				}
				else
				{
					cell=new Cell(new Phrase(".",ReportConstants.REPORT_FONT_COLOR_WHITE_9));
					cell.setHorizontalAlignment(0);
					cell.setColspan(1);
					cell.setRowspan(2);
					table.addCell(cell);
					cell=null;
				}
				if(!strtotalfundedprop.equalsIgnoreCase(""))
				{
					cell=new Cell(new Phrase(strtotalfundedprop+" %",ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(0);
					cell.setColspan(1);
					cell.setRowspan(2);
					table.addCell(cell);
					cell=null;
				}
				else
				{
					cell=new Cell(new Phrase(".",ReportConstants.REPORT_FONT_COLOR_WHITE_9));
					cell.setHorizontalAlignment(0);
					cell.setColspan(1);
					cell.setRowspan(2);
					table.addCell(cell);
					cell=null;
				}
				
				cell=new Cell(new Phrase("Non Fund based",ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
				if(!strtotalnonfundedexi.equalsIgnoreCase(""))
				{
					cell=new Cell(new Phrase(strtotalnonfundedexi+" %",ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(0);
					cell.setColspan(1);
					table.addCell(cell);
					cell=null;
				}
				else
				{
					cell=new Cell(new Phrase(".",ReportConstants.REPORT_FONT_COLOR_WHITE_9));
					cell.setHorizontalAlignment(0);
					cell.setColspan(1);
					table.addCell(cell);
					cell=null;
				}
				if(!strtotalnonfundedprop.equalsIgnoreCase(""))
				{
					cell=new Cell(new Phrase(strtotalnonfundedprop+" %",ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(0);
					cell.setColspan(1);
					table.addCell(cell);
					cell=null;
				}
				else
				{
					cell=new Cell(new Phrase(".",ReportConstants.REPORT_FONT_COLOR_WHITE_9));
					cell.setHorizontalAlignment(0);
					cell.setColspan(1);
					table.addCell(cell);
					cell=null;
				}
			}
			else
			{
				cell=new Cell(new Phrase("ASSET CLASSIFICATION",ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
				
				if(!strcompropassettype.equalsIgnoreCase(""))
				{
					cell=new Cell(new Phrase(strcompropassettype,ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(0);
					cell.setColspan(4);
					table.addCell(cell);
					cell=null;
				}
				else
				{
					cell=new Cell(new Phrase(".",ReportConstants.REPORT_FONT_COLOR_WHITE_9));
					cell.setHorizontalAlignment(0);
					cell.setColspan(4);
					table.addCell(cell);
					cell=null;
				}
			}
			
			cell=new Cell(new Phrase("INTERNAL CREDIT RATING",ReportConstants.REPORT_FONT_NORMAL));
			cell.setHorizontalAlignment(0);
			cell.setColspan(1);
			cell.setRowspan(4);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase(".",ReportConstants.REPORT_FONT_COLOR_WHITE_9));
			cell.setHorizontalAlignment(0);
			cell.setColspan(1);
			cell.setRowspan(2);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("Rating Grade",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(0);
			cell.setColspan(1);
			cell.setRowspan(2);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("Score",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(0);
			cell.setColspan(1);
			cell.setRowspan(2);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("Risk definition",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(0);
			cell.setColspan(1);
			cell.setRowspan(2);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("Previous Year",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(0);
			cell.setColspan(1);
			table.addCell(cell);
			cell=null;
			
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeLAPSQuery("getramrating105details^"+ strAppno);
			if (rs.next()) 
			{
				cell=new Cell(new Phrase(correctNull((String) rs.getString("lastrating_basemodel")),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase(correctNull((String) rs.getString("lastscore_basemodel")),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase(correctNull((String) rs.getString("lastgradef_basemodel")),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("Current Year",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(0);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase(correctNull((String) rs.getString("currentrating_basemodel")),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase(correctNull((String) rs.getString("currentscore_basemodel")),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase(correctNull((String) rs.getString("currentgradef_basemodel")),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
			}
			else
			{
				cell=new Cell(new Phrase(".",ReportConstants.REPORT_FONT_COLOR_WHITE_9));
				cell.setHorizontalAlignment(0);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase(".",ReportConstants.REPORT_FONT_COLOR_WHITE_9));
				cell.setHorizontalAlignment(0);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase(".",ReportConstants.REPORT_FONT_COLOR_WHITE_9));
				cell.setHorizontalAlignment(0);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("Current Year",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(0);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase(".",ReportConstants.REPORT_FONT_COLOR_WHITE_9));
				cell.setHorizontalAlignment(0);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase(".",ReportConstants.REPORT_FONT_COLOR_WHITE_9));
				cell.setHorizontalAlignment(0);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase(".",ReportConstants.REPORT_FONT_COLOR_WHITE_9));
				cell.setHorizontalAlignment(0);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
			}
			
			cell=new Cell(new Phrase("EXTERNAL CREDIT RATING",ReportConstants.REPORT_FONT_NORMAL));
			cell.setHorizontalAlignment(0);
			cell.setColspan(1);
			cell.setRowspan(3);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("RATING AGENCY",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(0);
			cell.setColspan(1);
			cell.setRowspan(2);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("PREVIOUS YEAR",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(0);
			cell.setColspan(1);
			cell.setRowspan(2);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("CURRENT YEAR",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(0);
			cell.setColspan(2);
			cell.setRowspan(2);
			table.addCell(cell);
			cell=null;
			
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeLAPSQuery("selexternalrating^"+ strAppno);
			while (rs.next()) {
				flag=true;
				if(correctNull(rs.getString("com_propcomtype")).equals("extagency"))
				{
					cell=new Cell(new Phrase(correctNull(Helper.CLOBToString(rs.getClob("com_propcomdesc"))),ReportConstants.REPORT_FONT_BOLD));
					cell.setHorizontalAlignment(0);
					cell.setColspan(1);
					table.addCell(cell);
					cell=null;
				}
				if(correctNull(rs.getString("com_propcomtype")).equals("extlastrate"))
				{
					cell=new Cell(new Phrase(correctNull(Helper.CLOBToString(rs.getClob("com_propcomdesc"))),ReportConstants.REPORT_FONT_BOLD));
					cell.setHorizontalAlignment(0);
					cell.setColspan(1);
					table.addCell(cell);
					cell=null;
				}
				if(correctNull(rs.getString("com_propcomtype")).equals("extcurrate"))
				{
					cell=new Cell(new Phrase(correctNull(Helper.CLOBToString(rs.getClob("com_propcomdesc"))),ReportConstants.REPORT_FONT_BOLD));
					cell.setHorizontalAlignment(0);
					cell.setColspan(2);
					table.addCell(cell);
					cell=null;
				}
			}
			if(flag==false)
			{
				cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(0);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(0);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(0);
				cell.setColspan(2);
				table.addCell(cell);
				cell=null;
			}
			
			cell=new Cell(new Phrase("STATUS OF ACCOUNT",ReportConstants.REPORT_FONT_NORMAL));
			cell.setHorizontalAlignment(0);
			cell.setColspan(1);
			table.addCell(cell);
			cell=null;
			
			strQuery = SQLParser.getSqlQuery("execsel_summary_val^" + strAppno);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				strTemp=Helper.correctNull(rs.getString("status_acc"));
				strstatusofacc=strTemp.equals("1")?"Regular":strTemp.equals("2")?"EAS-I":strTemp.equals("3")?"EAS-II":strTemp.equals("4")?"SMA":strTemp.equals("5")?"N.A.":"";
				strindservices=Helper.correctNull(rs.getString("ind_services")).equalsIgnoreCase("")?"Nil":correctNull(rs.getString("ind_services"));
				selrbi4=Helper.correctNull((String)rs.getString("company_rbi"));
				if(!Helper.correctNull((String)rs.getString("company_rbidesc")).equalsIgnoreCase(""))
				{	
					strComDesc=correctNull((String)Helper.CLOBToString(rs.getClob("company_rbidesc")));
				}
				else
				{
					strComDesc="";
				}
				strOtherMatters =  Helper.correctNull(Helper.CLOBToString(rs.getClob("other_matters")));
				strExposureNorms=correctNull(rs.getString("exposure_norms"));
			}
			
			cell=new Cell(new Phrase(strstatusofacc,ReportConstants.REPORT_FONT_NORMAL));
			cell.setHorizontalAlignment(0);
			cell.setColspan(4);
			table.addCell(cell);
			cell=null;

			document.add(table);
			table=null;
			
			if (rs != null) {
				rs.close();
			}
			
			int[] wd1={7,50,43};
			table=new Table(3);
			table.setPadding(2.0f);			
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f);
			table.setWidths(wd1);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);			
			
			table.addCell(rm.ReportCellBold(1,"\n",3,0.0f));
			
			table.addCell(rm.ReportCellBold(0,"1.",1,0.0f));
			table.addCell(rm.ReportCellBold(0,"NAME OF THE ACCOUNT",1,0.0f));
			
			strQuery = SQLParser.getSqlQuery("comappmastersel^" + comappid);

			if (rs != null) {
				rs.close();
			}
			String strcompanyname="",strcompnature="";
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{

				strcompanyname=Helper.correctNull(rs.getString("comapp_companyname"));
				strcompnature=correctNull((String)rs.getString("comapp_businessnature"));
				table.addCell(rm.ReportCell(0,Helper.correctNull(rs.getString("comapp_companyname")),1,0.0f));				

				table.addCell(rm.ReportCellBold(0,"1.1",1,0.0f));				
				table.addCell(rm.ReportCellBold(0,"BRANCH / ZONE",1,0.0f));
				table.addCell(rm.ReportCell(0,strBranchName,1,0.0f));
				
				table.addCell(rm.ReportCellBold(0,"2.",1,0.0f));				
				table.addCell(rm.ReportCellBold(0,"CONSTITUTION",1,0.0f));
				strConstitutionCode =Helper.correctNull(rs.getString("comapp_ownership"));
				strConstitution = getConstitution(Helper.correctNull(rs.getString("comapp_ownership")));
				table.addCell(rm.ReportCell(0,strConstitution,1,0.0f));	
				
				table.addCell(rm.ReportCellBold(0,"2.1.",1,0.0f));	
				table.addCell(rm.ReportCellBold(0,"DATE OF INCORPORATION",1,0.0f));
				table.addCell(rm.ReportCell(0,correctNull((String)rs.getString("comapp_yrsinbusiness")),1,0.0f));
				
				table.addCell(rm.ReportCellBold(0,"3.",1,0.0f));	
				table.addCell(rm.ReportCellBold(0,"LINE OF ACTIVITY",1,0.0f));
				table.addCell(rm.ReportCell(0,correctNull((String)rs.getString("comapp_businessnature")),1,0.0f));
				
				table.addCell(rm.ReportCellBold(0,"4.",1,0.0f));	
				table.addCell(rm.ReportCellBold(0,"ADDRESS",1,0.0f));
				table.addCell(rm.ReportCell(0,"",1,0.0f));
				
				table.addCell(rm.ReportCellBold(0,"4.1.",1,0.0f));	
				table.addCell(rm.ReportCellBold(0,"Regd./Admn.Office",1,0.0f));
				
				strRegCity = correctNull((String)rs.getString("comapp_regcity"));
				if(!strRegCity.equalsIgnoreCase(""))
				{
					strQuery = SQLParser.getSqlQuery("selcityname2^" + strRegCity);
					
					rs1 = DBUtils.executeQuery(strQuery);
					if (rs1.next()) 
					{
						strRegCityDesc=correctNull((String)rs1.getString("city_name"));
					}
				}
				if (rs1 != null) {
					rs1.close();
				}
				
				strRegState = correctNull((String)rs.getString("comapp_regstate"));
				if(!strRegState.equalsIgnoreCase(""))
				{
					strQuery = SQLParser.getSqlQuery("selstatename2^" + strRegState);
					rs1 = DBUtils.executeQuery(strQuery);
					
					if (rs1.next()) {
						strRegStateDesc=correctNull((String)rs1.getString("state_name"));
					}
				}
				
				if (rs1 != null) {
					rs1.close();
				}
				table.addCell(rm.ReportCell(0,correctNull((String)rs.getString("comapp_regadd1"))+" - "+correctNull((String)rs.getString("comapp_regadd2"))+"\n"+strRegCityDesc+"\n"+strRegStateDesc+"\n"+"Pin:"+correctNull(rs.getString("comapp_regpin")),1,0.0f));
			}
			
			strQuery=SQLParser.getSqlQuery("selallfactorydetails^" + comappid);
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeQuery(strQuery);
			String strFactype="";
			while(rs.next())
			{
				arrTmpList = new ArrayList();
				
				strFactype=correctNull((String)rs.getString("comapp_detailtype"));
				arrTmpList.add(correctNull((String)rs.getString("comapp_name")));
				arrTmpList.add(correctNull((String)rs.getString("comapp_add")));
				arrTmpList.add(correctNull((String)rs.getString("comapp_city")));
				arrTmpList.add(correctNull((String)rs.getString("comapp_state")));
				arrTmpList.add(correctNull((String)rs.getString("comapp_pincode")));
				
				arrUnitsworks.add(arrTmpList);
			}
			
			arrData = new ArrayList();
			arrRow = new ArrayList();
			arrRow = arrUnitsworks;
			int j=0;
			if (arrRow != null && arrRow.size() > 0) 
			{
				for (int i = 0; i < arrRow.size(); i++)
				{
					if(j==0)
					{
						
						table.addCell(rm.ReportCellBold(0,"4.2.",1,0.0f));	
						table.addCell(rm.ReportCellBold(0,"Units/Works",1,0.0f));
					}
					else
					{
						table.addCell(rm.ReportCellBold(0,"",1,0.0f));	
						table.addCell(rm.ReportCellBold(0,"",1,0.0f));
					}
					
					arrData = (ArrayList) arrRow.get(i);
					table.addCell(rm.ReportCell(0,correctNull((String)(arrData.get(0)))+"\n"+correctNull((String)(arrData.get(1)))+"\n"+correctNull((String)(arrData.get(2))+"\n"+correctNull((String)(arrData.get(3)))+" - "+correctNull((String)(arrData.get(4)))),1,0.0f));
					j++;
				}
			}
			
			strQuery = SQLParser.getSqlQuery("compromoterselectionpromoters^"+ strAppno);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			
			while (rs.next()) {
				arrVec4 = new ArrayList();

				arrVec4.add(correctNull(rs.getString("com_compdtfname")));
				arrVec4.add(correctNull(rs.getString("com_compdtlname")));
				arrVec4.add(correctNull(rs.getString("com_compdtmname")));
				arrVec4.add(correctNull(rs.getString("com_compdaca")));
				String company_id = correctNull((String) rs
						.getString("com_compdtid"));
				if (rs1 != null) {
					rs1.close();
				}
				strQuery = SQLParser.getSqlQuery("selcreditreport2^" + strAppno+ "^" + company_id);
				rs1 = DBUtils.executeQuery(strQuery);
				if (rs1.next()) {
					arrVec4.add(correctNull(rs1.getString("CR_Total_MEANS")));
					arrVec4.add(correctNull(rs1.getString("cr_meansason")));
				} else {
					arrVec4.add("0.00");
					arrVec4.add("");
				}
				arrVec4.add(correctNull(rs.getString("com_compdexp")));
				arrVec4.add(correctNull(rs.getString("com_background")));
				String strpromgua[] = correctNull(
						rs.getString("com_compdttype")).split("@");
		        ArrayList arrProCheck=new ArrayList();
				
				for(int i = 0; i < strpromgua.length; i++) {
			
					if (strpromgua[i].equals("G")) 
					{
						String strGuaType=correctNull(rs.getString("COM_COMPDSEX"));
						if(strGuaType.trim().equals("Male") || strGuaType.trim().equals("Female"))
						  arrGuarantors.add(arrVec4);
						else
							arrCorpguarantee.add(arrVec4);
						
					}
					else{
						
						if(!arrProCheck.contains("PT") && !arrProCheck.contains("SP") && !arrProCheck.contains("OT") && !strpromgua[i].equals("O"))
						{
						    if(strpromgua[i].equals("PT"))
							{
								arrVec4.add("Partner");
							
							}else if(strpromgua[i].equals("SP"))
							{
								arrVec4.add("Sole Proprietor");
								
							}
							else if(strpromgua[i].equals("D"))
							{
								arrVec4.add("Director");
								
							}
							else if(strpromgua[i].equals("OT")) 
							{
								arrVec4.add(correctNull(rs.getString("com_compdtdesignation")));
							}
						 	arrPromotors.add(arrVec4);
							
						}
				    }
					arrProCheck.add(strpromgua[i]);
					
				}
				if(correctNull(rs.getString("com_compdtfname")).equals("gen"))
				{
					strbgroundpromoters=correctNull(rs.getString("com_background"));
				}
				arrProback.add(arrVec4);
				
			}
			
			arrRow = new ArrayList();
			arrRow = arrPromotors;
			if (arrRow != null && arrRow.size() != 0)
			{
				document.add(table);
				table=null;
				
				float[] cmwid1={7.0f,5.0f,25.0f,25.0f,25.0f,13.0f};
				table=new Table(6);
				table.setPadding(1.0f);
				table.setBorderWidth(0.0f);
				table.setAutoFillEmptyCells(true);
				table.setWidth(100.0f);
				table.setWidths(cmwid1);
				table.setBorder(1);
				table.setCellsFitPage(true);
				table.setTableFitsPage(true);
				
				
				table.addCell(rm.ReportCellBold(1,"5.",1,0.0f));	
				table.addCell(rm.ReportCellBold(0,"NAMES OF PROPRIETORS / PARTNERS / DIRECTORS & THEIR MEANS",5,0.0f));
				
				cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(0);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("Sno",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("Name",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("Designation",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("Means("+ApplicationParams.getCurrency()+"In "+strProposalvalue+")",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("Means As on",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(0);
				table.addCell(cell);
				cell=null;
				
			
				for (int i = 0; i < arrRow.size(); i++) 
				{
					arrData = (ArrayList) arrRow.get(i);
					
					cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(0);
					cell.setBorder(0);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase(String.valueOf(i+1),ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(0);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase(correctNull((String)(arrData.get(0)))+" "+correctNull((String)(arrData.get(2)))+" "+correctNull((String)(arrData.get(1))),ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(0);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase(correctNull((String)(arrData.get(8))),ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(0);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase(correctNull((String)(arrData.get(4))),ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(2);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase(correctNull((String)(arrData.get(5))),ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(0);
					table.addCell(cell);
					cell=null;
				}
			}
			else
			{
				cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(0);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("Nil",ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				table.addCell(cell);
				cell=null;
			}
			
			cell=new Cell(new Phrase("\n",ReportConstants.REPORT_FONT_NORMAL));
			cell.setHorizontalAlignment(0);
			cell.setBorder(0);
			cell.setColspan(6);
			table.addCell(cell);
			cell=null;
			
			document.add(table);
			table=null;
			
			table=new Table(3);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f);
			table.setWidths(wd1);
			table.setBorder(0);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			table.addCell(rm.ReportCellBold(0,"6.",1,0.0f));
			table.addCell(rm.ReportCellBold(0,"BACKGROUND OF PROMOTERS / DIRECTORS / PROPRIETOR / PARTNER",2,0.0f));
			
			document.add(table);
			table=null;
			
			float[] cmwid2={7.0f,93.0f};
			table=new Table(2);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f);
			table.setWidths(cmwid2);
			table.setBorder(1);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
						
			if (strbgroundpromoters.equalsIgnoreCase(""))
			{
				arrRow = new ArrayList();
				arrRow = arrProback;
				if (arrRow != null && arrRow.size() != 0) 
				{
					for (int i = 0; i < arrRow.size(); i++) 
					{
						arrData = (ArrayList) arrRow.get(i);
						if (!(Helper.correctNull((String) arrData.get(7)).equals(""))) 
						{
							table.addCell(rm.ReportCell(0,"",1,0.0f));
							table.addCell(rm.ReportCell(0,Helper.correctNull((String) arrData.get(7)),1,0.0f));
							
						}
					}
				}
				table.addCell(rm.ReportCell(0,"",1,0.0f));
				table.addCell(rm.ReportCell(0,strbgroundpromoters,1,0.0f));	
			}
			else
			{
				table.addCell(rm.ReportCell(0,"",1,0.0f));
				table.addCell(rm.ReportCell(0,strbgroundpromoters,1));
			}
			
			document.add(table);
			table=null;
			
			int[] cmwid8={7,25,25,23,20};
			table=new Table(5);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f);
			table.setWidths(cmwid8);
			table.setBorder(0);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			table.addCell(rm.ReportCellBold(1,"7.",1,0.0f));				
			if (rs != null)
				rs.close();
			strQuery=SQLParser.getSqlQuery("selcapitalstructure^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			
			if(rs.next())
			{
				strauthcaptial=Helper.formatDoubleValue(rs.getDouble("com_authcapital"));
				strappsubcapital= Helper.formatDoubleValue(rs.getDouble("com_subisscapital"));
				strbookvalue=correctNull(rs.getString("com_bookvalue"));
				strmarketvalue=correctNull(rs.getString("com_marketvalue"));
				dblTotalshares=rs.getDouble("com_paidshares");
			}
			if (rs != null)
				rs.close();
			String tot_capital_contribution = "0.00";
			strQuery = SQLParser
					.getSqlQuery("total_pro_gua_capitalcontribution^" + strAppno);
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				tot_capital_contribution = Helper.formatDoubleValue(rs.getDouble("TotCapContribution"));
			}
			
			table.addCell(rm.ReportCellBold(0,"CAPITAL STRUCTURE",1,0.0f));
			table.addCell(rm.ReportCell(0,"",3,0.0f));
			
			table.addCell(rm.ReportCellBold(1,"",1,0.0f));				
			table.addCell(rm.ReportCell(0,"In case of Companies",1,0.0f));
			table.addCell(rm.ReportCell(0,"",3,0.0f));
			
			if (strConstitutionCode.trim().equals("OLP")|| strConstitutionCode.trim().equals("OCC"))
			{
				table.addCell(rm.ReportCellBold(1,"",1,0.0f));				
				table.addCell(rm.ReportCell(0,"Authorised Capital",1));
				table.addCell(rm.ReportCell(0,"Rs."+strauthcaptial+" Lacs",1));
				table.addCell(rm.ReportCell(0,"",2,0.0f));
				
				table.addCell(rm.ReportCellBold(1,"",1,0.0f));				
				table.addCell(rm.ReportCell(0,"Issued/Subscribed Capital",1));
				table.addCell(rm.ReportCell(0,"Rs."+strappsubcapital+" Lacs",1));
				table.addCell(rm.ReportCell(0,"",2,0.0f));
				
				table.addCell(rm.ReportCellBold(1,"",1,0.0f));				
				table.addCell(rm.ReportCell(0,"Paid-up capital",1));
				table.addCell(rm.ReportCell(0,"Rs."+tot_capital_contribution+" Lacs",1));
				table.addCell(rm.ReportCell(0,"",2,0.0f));
				
				table.addCell(rm.ReportCellBold(1,"",1,0.0f));				
				table.addCell(rm.ReportCell(0,"Book Value",1));
				table.addCell(rm.ReportCell(0,"Rs."+strbookvalue+" Lacs",1));
				table.addCell(rm.ReportCell(0,"",2,0.0f));
				
				table.addCell(rm.ReportCellBold(1,"",1,0.0f));				
				table.addCell(rm.ReportCell(0,"Market value",1));
				table.addCell(rm.ReportCell(0,"Rs."+strmarketvalue+" Lacs",1));
				table.addCell(rm.ReportCell(0,"",2,0.0f));
				
			}
			else
			{
				table.addCell(rm.ReportCellBold(1,"",1,0.0f));				
				table.addCell(rm.ReportCell(0,"Authorised Capital",1));
				table.addCell(rm.ReportCell(0,"",1));
				table.addCell(rm.ReportCell(0,"",2,0.0f));
				
				table.addCell(rm.ReportCellBold(1,"",1,0.0f));				
				table.addCell(rm.ReportCell(0,"Issued/Subscribed Capital",1));
				table.addCell(rm.ReportCell(0,"",1));
				table.addCell(rm.ReportCell(0,"",2,0.0f));
				
				table.addCell(rm.ReportCellBold(1,"",1,0.0f));				
				table.addCell(rm.ReportCell(0,"Paid-up capital",1));
				table.addCell(rm.ReportCell(0,"",1));
				table.addCell(rm.ReportCell(0,"",2,0.0f));
				
				table.addCell(rm.ReportCellBold(1,"",1,0.0f));				
				table.addCell(rm.ReportCell(0,"Book Value",1));
				table.addCell(rm.ReportCell(0,"",1));
				table.addCell(rm.ReportCell(0,"",2,0.0f));
				
				table.addCell(rm.ReportCellBold(1,"",1,0.0f));				
				table.addCell(rm.ReportCell(0,"Market value",1));
				table.addCell(rm.ReportCell(0,"",1));
				table.addCell(rm.ReportCell(0,"",2,0.0f));
			}
			
			table.addCell(rm.ReportCellBold(1,"",1,0.0f));				
			table.addCell(rm.ReportCell(0,"",1,0.0f));
			table.addCell(rm.ReportCell(0,"",1,0.0f));
			table.addCell(rm.ReportCell(0,"",2,0.0f));
			
			document.add(table);
			table=null;
			
			
			int[] wd2={7,50,43};
			table=new Table(3);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f);
			table.setWidths(wd2);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			strQuery = SQLParser.getSqlQuery("com_sel_shareholding^" + strAppno);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			double dblsharepercent=0.0;
			double dblshares=0.0;
			arrRow = new ArrayList();
			while (rs.next()) 
			{
				DecimalFormat dc=new DecimalFormat();
				dc.setGroupingUsed(false);
				dc.setMaximumFractionDigits(2);
				dc.setMinimumFractionDigits(2);
				arrVec = new ArrayList();
				arrVec.add(correctNull(rs.getString("com_compdtfname"))); // 0
				arrVec.add(correctNull(rs.getString("com_compdtlname"))); // 1
				arrVec.add(correctNull(rs.getString("com_compdtmname"))); // 2
				if(dblTotalshares!=0.0)
				{
					if(rs.isLast())
					{
						dblshares=dblshares+rs.getDouble("com_compdtshareheld");
						if(dblshares==dblTotalshares)
						{
							arrVec.add(""+(100.0-dblsharepercent));
						}
						else if(dblshares<dblTotalshares)
						{
							dblsharepercent=dblsharepercent+Double.parseDouble(dc.format((rs.getDouble("com_compdtshareheld")/dblTotalshares)*100.0));
							arrVec.add(dc.format((rs.getDouble("com_compdtshareheld")/dblTotalshares)*100));
						}
						else
						{
							arrVec.add("0.0");
						}
					}
					else
					{
						dblshares=dblshares+rs.getDouble("com_compdtshareheld");
						dblsharepercent=dblsharepercent+Double.parseDouble(dc.format((rs.getDouble("com_compdtshareheld")/dblTotalshares)*100.0));
						arrVec.add(dc.format((rs.getDouble("com_compdtshareheld")/dblTotalshares)*100));
					}
					
				}
				else
				{
					arrVec.add("0.0");
				}
				
				arrVec.add(correctNull(rs.getString("com_compdtshareheld"))); // 4
				arrVec.add(correctNull(rs.getString("CapContribution"))); // 5
				arrVec.add(correctNull(rs.getString("COM_FACEVALUE"))); // 6

				arrRow.add(arrVec);
			}
			
			table.addCell(rm.ReportCellBold(1,"7.1.",1,0.0f));				
			table.addCell(rm.ReportCellBold(0,"SHAREHOLDING PATTERN",1,0.0f));
			
			if (strConstitutionCode.trim().equals("OLP")|| strConstitutionCode.trim().equals("OCC"))
			{
				table.addCell(rm.ReportCell(0,"",1,0.0f));
				
				document.add(table);
				table=null;
				
				int[] wd3={7,25,15,15,15,23};
				table=new Table(6);
				table.setPadding(1.0f);
				table.setBorderWidth(0.0f);
				table.setAutoFillEmptyCells(true);
				table.setWidth(100.0f);
				table.setWidths(wd3);
				table.setCellsFitPage(true);
				table.setTableFitsPage(true);
				
				cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(1);
				cell.setColspan(1);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("Share Holder",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(1);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("No of Shares",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(1);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("Value",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(1);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("Holding %",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(1);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(1);
				cell.setColspan(1);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;

				ArrayList arr = new ArrayList();
				ArrayList arr1 = new ArrayList();
				dblshares = 0.0;
				long lngvalue = 0;
				double dblholding = 0.0;
				arr = arrRow;
				if (arr != null && arr.size() > 0) 
				{
					int arrSize = arr.size();
					for (int i = 0; i < arrSize; i++) 
					{
						arr1 = (ArrayList) arr.get(i);
						dblshares = dblshares
								+ Double.parseDouble(Helper
										.correctDouble((String) arr1.get(4)));
						lngvalue = lngvalue
								+ (long) Double.parseDouble(Helper
										.correctDouble((String) arr1.get(6)));
						dblholding = dblholding
								+ Double.parseDouble(Helper
										.correctDouble((String) arr1.get(3)));
						
						cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
						cell.setHorizontalAlignment(1);
						cell.setColspan(1);
						cell.setBorder(0);
						table.addCell(cell);
						cell=null;
						
						cell=new Cell(new Phrase(correctNull((String)arr1.get(0))+correctNull((String)arr1.get(2))+correctNull((String)arr1.get(1)),ReportConstants.REPORT_FONT_NORMAL));
						cell.setHorizontalAlignment(0);
						cell.setColspan(1);
						table.addCell(cell);
						cell=null;
						
						cell=new Cell(new Phrase(correctNull((String)arr1.get(4)),ReportConstants.REPORT_FONT_NORMAL));
						cell.setHorizontalAlignment(2);
						cell.setColspan(1);
						table.addCell(cell);
						cell=null;
						
						cell=new Cell(new Phrase(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arr1.get(6)))),ReportConstants.REPORT_FONT_NORMAL));
						cell.setHorizontalAlignment(2);
						cell.setColspan(1);
						table.addCell(cell);
						cell=null;
						
						String val_hold = Helper.correctNull((String) arr1.get(3));
						double dblval_hold = 0.00;
						if (!val_hold.equalsIgnoreCase("")) {
							dblval_hold = Double.parseDouble(val_hold);
						}
						
						cell=new Cell(new Phrase(Helper.formatDoubleValue(dblval_hold),ReportConstants.REPORT_FONT_NORMAL));
						cell.setHorizontalAlignment(2);
						cell.setColspan(1);
						table.addCell(cell);
						cell=null;
						
						cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
						cell.setHorizontalAlignment(1);
						cell.setColspan(1);
						cell.setBorder(0);
						table.addCell(cell);
						cell=null;
					}
					
					cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
					cell.setHorizontalAlignment(1);
					cell.setBorder(0);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase("Total",ReportConstants.REPORT_FONT_BOLD));
					cell.setHorizontalAlignment(0);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase(Helper.formatDoubleValue(dblshares),ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(2);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase(Helper.formatDoubleValue(Double.parseDouble(Long.toString(lngvalue))),ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(2);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase(Helper.formatDoubleValue(dblholding),ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(2);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
					cell.setHorizontalAlignment(1);
					cell.setBorder(0);
					table.addCell(cell);
					cell=null;
					
				}
				else
				{
					cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
					cell.setHorizontalAlignment(1);
					cell.setColspan(1);
					cell.setBorder(0);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase("N.A",ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(1);
					cell.setColspan(4);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
					cell.setHorizontalAlignment(1);
					cell.setColspan(1);
					cell.setBorder(0);
					table.addCell(cell);
					cell=null;
					
				}
			}
			else
			{
				table.addCell(rm.ReportCellFontColorWhite9(0,".",6));
			}
			
			strQuery = SQLParser.getSqlQuery("compromoterselectionpartner^"+ strAppno);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				arrVec = new ArrayList();
				arrVec.add(correctNull(rs.getString("COM_COMPDTTYPE")));
				arrVec.add(correctNull(rs.getString("com_compdtfname")));
				arrVec.add(correctNull(rs.getString("com_compdtlname")));
				arrVec.add(correctNull(rs.getString("com_compdtmname")));
				arrVec.add(correctNull(rs.getString("com_comdtpershare")));
				arrVec.add(correctNull(rs.getString("com_compdtshareheld")));
				arrVec.add(correctNull(rs.getString("CapContribution")));
				arrRow15.add(arrVec);
			}
			
			document.add(table);
			table=null;
			
			table=new Table(3);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f);
			table.setWidths(wd2);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			table.addCell(rm.ReportCellBold(1,"7.2.",1,0.0f));				
			table.addCell(rm.ReportCellBold(0,"IN CASE OF PARTNERSHIP FIRMS INDICATE CAPITAL CONTRIBUTED BY EACH PARTNER SEPARATELY",1,0.0f));
			String conValue = "", conValue1 = "";
			if (strConstitutionCode.trim().equals("OP"))
			{
				ArrayList arrR = new ArrayList();
				ArrayList arrC = new ArrayList();
				int arrSize6 = 0;
				arrR = arrRow15;

				if (arrR != null) 
				{

					arrSize6 = arrR.size();
					for (int i = 0; i < arrSize6; i++) 
					{
						arrC = (ArrayList) arrR.get(i);
						{

							if (!arrC.get(4).equals("")) 
							{
								conValue = Helper.correctNull((String) arrC
										.get(4));
							}
							else
							{
								conValue = "0.00";
							}
							if (!arrC.get(6).equals("")) 
							{
								conValue1 = Helper.correctNull((String) arrC
										.get(6));
							} 
							else 
							{
								conValue1 = "0.00";
							}
						}
						table.addCell(rm.ReportCell(0,String.valueOf(i + 1)+"."+correctNull((String) arrC.get(1))+correctNull((String) arrC.get(2))+" - "+ApplicationParams.getCurrency()+conValue1+strProposalvalue,1,0.0f));
					}
				}
			}
			else
			{
				table.addCell(rm.ReportCell(0,"N.A",1,0.0f));
			}
			table.addCell(rm.ReportCellBold(1,"8.",1,0.0f));				
			table.addCell(rm.ReportCellBold(0,"SECTOR / BSR CODE",1,0.0f));
			table.addCell(rm.ReportCell(0,strcompanyid,1,0.0f));
			
			if(strsearchreport.equalsIgnoreCase(""))
			{
				table.addCell(rm.ReportCellBold(1,"9.",1,0.0f));				
				table.addCell(rm.ReportCellBold(0,"COMMENTS ON LATEST CREDIT/SEARCH REPORT",1,0.0f));
				table.addCell(rm.ReportCell(0,"Nil",1,0.0f));
			}
			else
			{
				StringTokenizer strIdV16c = new StringTokenizer(strsearchreport, "\n");
				int k=0;
				while (strIdV16c.hasMoreTokens()) 
				{
					if(k==0)
					{
						table.addCell(rm.ReportCellBold(1,"9.",1,0.0f));				
						table.addCell(rm.ReportCellBold(0,"COMMENTS ON LATEST CREDIT/SEARCH REPORT",1,0.0f));
					}
					else
					{
						table.addCell(rm.ReportCellBold(1,"",1,0.0f));				
						table.addCell(rm.ReportCellBold(0,"",1,0.0f));
					}
					String strTempV = (String) strIdV16c.nextToken();
					table.addCell(rm.ReportCell(0,strTempV,1,0.0f));
					k++;
				}
			
			}
			
			table.addCell(rm.ReportCellBold(1,"10.",1,0.0f));				
			table.addCell(rm.ReportCellBold(0,"WHETHER A/C IS TAKEN/ TO BE TAKEN OVER. IF SO NORMS FOR TAKE OVER ARE FUL FILLED",1,0.0f));
			
			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("pro_takeoversel^" + strAppno);
			String stristakeover="";
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				stristakeover=correctNull(rs.getString("istakeover"));
			}
			if (rs != null) {
				rs.close();
			}
			String strTake = "";
			if (stristakeover.equalsIgnoreCase("2")|| stristakeover.equalsIgnoreCase("0"))
			{
				strTake = "Not Applicable";
			}
			else
			{
				strTake = "Yes";
			}
			table.addCell(rm.ReportCell(0,strTake,1,0.0f));
			
			strQuery = SQLParser.getSqlQuery("takeoverworkingsel^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);

			while (rs.next())
			{
				arrworkingCol = new ArrayList();
				arrworkingCol.add(correctNull((String) rs
						.getString("WORKING_NORMS")));
				arrworkingCol.add(correctNull((String) rs
						.getString("WORKING_NORMSAVAIL")));
				arrworkingCol.add(correctNull((String) rs
						.getString("WORKING_REASONS")));
				arrworkingRow.add(arrworkingCol);

			}
			
			strQuery = SQLParser.getSqlQuery("takeovertermsel^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);

			while (rs.next()) 
			{
				arrtermsCol = new ArrayList();
				arrtermsCol.add(correctNull((String) rs
						.getString("TERM_NORMS")));
				arrtermsCol.add(correctNull((String) rs
						.getString("TERM_STATUS")));
				arrtermsCol.add(correctNull((String) rs
						.getString("TERM_REASON")));
				arrtermsRow.add(arrtermsCol);
			}
			
			if (stristakeover.equalsIgnoreCase("1"))
			{
				arrRow = new ArrayList();
				arrRow = arrworkingRow;
				if (arrRow != null && arrRow.size() > 0)
				{
					table.addCell(rm.ReportCell(0,"\n",3,0.0f));
					
					table.addCell(rm.ReportCellBold(1,"TAKE-OVER NORMS FOR TRADE SERVICES",2,1));
					table.addCell(rm.ReportCellBold(1,"COMPLIANCE",1,1));
					
					for (int i = 0; i < arrRow.size(); i++) 
					{
						arrData = (ArrayList) arrRow.get(i);
						if (arrData != null && arrData.size() > 0) 
						{
							table.addCell(rm.ReportCell(0,Helper.correctNull((String) arrData.get(0)),2));
							table.addCell(rm.ReportCell(0,Helper.correctNull((String) arrData.get(2)),1));
						}
					}
				}

				arrRow = new ArrayList();
				arrRow = arrtermsRow;
				if (arrRow != null && arrRow.size() > 0) 
				{
					table.addCell(rm.ReportCellBold(0,"\n",3,0.0f));
					
					table.addCell(rm.ReportCellBold(1,"TAKE-OVER NORMS FOR TRADE SERVICES",2,1));
					table.addCell(rm.ReportCellBold(1,"COMPLIANCE",1,1));
					
					for (int i = 0; i < arrRow.size(); i++) 
					{
						arrData = (ArrayList) arrRow.get(i);
						if (arrData != null && arrData.size() > 0) 
						{
							table.addCell(rm.ReportCell(0,Helper.correctNull((String) arrData.get(0)),2));
							table.addCell(rm.ReportCell(0,Helper.correctNull((String) arrData.get(2)),1));
						}
					}
				}
			
			}
			
			table.addCell(rm.ReportCellBold(0,"\n",3,0.0f));
			
			table.addCell(rm.ReportCellBold(0,"10.1",1,0.0f));
			table.addCell(rm.ReportCellBold(0,"DUE DILIGENCE",1,0.0f));
			table.addCell(rm.ReportCell(0,strduediligence,1,0.0f));
			
			table.addCell(rm.ReportCellBold(0,"11.",1,0.0f));
			table.addCell(rm.ReportCellBold(0,"DEALING WITH BANK SINCE",1,0.0f));
			table.addCell(rm.ReportCell(0,strdealbank,1,0.0f));
			
			table.addCell(rm.ReportCellBold(0,"12.",1,0.0f));
			table.addCell(rm.ReportCellBold(0,"CREDIT FACILITIES SINCE",1,0.0f));
			
			if(strexecborrtype.equalsIgnoreCase("E"))
			{
				table.addCell(rm.ReportCell(0,strcreditsince,1,0.0f));
			}
			else
			{
				table.addCell(rm.ReportCell(0,"New Borrower",1,0.0f));
			}
			table.addCell(rm.ReportCellBold(0,"13.",1,0.0f));
			table.addCell(rm.ReportCellBold(0,"TOTAL INDEBTEDNESS",2,0.0f));
			
			document.add(table);
			table=null;
			
			float[] cmwid3={7.0f,3.0f,10.0f,10.0f,10.0f,10.0f,10.0f,10.0f,10.0f,10.0f};
			table=new Table(10);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f);
			table.setWidths(cmwid3);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(1);
			cell.setColspan(1);
			cell.setBorder(0);
			table.addCell(cell);
			cell=null;
			
			table.addCell(rm.ReportCellBold(2,"(Rs In "+strProposalvalue+")",9));
			
			cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(1);
			cell.setColspan(1);
			cell.setBorder(0);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(1);
			cell.setColspan(3);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("NON-FUND BASED",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(1);
			cell.setColspan(2);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("FUND BASED",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(1);
			cell.setColspan(2);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("TOTAL ",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(1);
			cell.setColspan(2);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(1);
			cell.setColspan(1);
			cell.setBorder(0);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(1);
			cell.setColspan(3);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("Existing",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(1);
			cell.setColspan(1);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("Proposed",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(1);
			cell.setColspan(1);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("Existing",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(1);
			cell.setColspan(1);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("Proposed",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(1);
			cell.setColspan(1);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("Existing",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(1);
			cell.setColspan(1);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("Proposed",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(1);
			cell.setColspan(1);
			table.addCell(cell);
			cell=null;
			
			if (rs != null) {
				rs.close();
			}
			double dblourFundExist = 0.0;
			double dblourFundProp = 0.0;
			double dblourNonFundExist = 0.0;
			double dblourNonFundProp = 0.0;
			double dblourTotExist = 0.0;
			double dblourTotProp = 0.0;
			double dblotrFundExist = 0.0;
			double dblotrFundProp = 0.0;
			double dblotrNonFundExist = 0.0;
			double dblotrNonFundProp = 0.0;
			double dblotrTotExist = 0.0;
			double dblotrTotProp = 0.0;
			double dbltotpropFI=0.0;
			double dbltotexistFI=0.0;
			double dblnonfundpropFI=0.0;
			double dblnonfundexistFI=0.0;
			double dblfundpropFI=0.0;
			double dblfundexistFI=0.0;
			
			boolean blnFlag=false;
			
			strQuery = SQLParser.getSqlQuery("combankingselection^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {

				arrVec1 = new ArrayList();
				String strType = correctNull((String)rs.getString("combk_selbank"));
				if(strType.trim().equalsIgnoreCase("Other")){
					dblotrFundExist = dblotrFundExist + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtfundexist")));
					dblotrFundProp = dblotrFundProp + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtfundprop")));
					dblotrNonFundExist = dblotrNonFundExist + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtnonfundexist")));
					dblotrNonFundProp = dblotrNonFundProp + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtnonfundprop")));
					dblotrTotExist = dblotrFundExist+dblotrNonFundExist;
					dblotrTotProp = dblotrFundProp+dblotrNonFundProp;
					blnFlag=true;
				}else{
					dblourFundExist = dblourFundExist + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtfundexist")));
					dblourFundProp = dblourFundProp + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtfundprop")));
					dblourNonFundExist = dblourNonFundExist + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtnonfundexist")));
					dblourNonFundProp = dblourNonFundProp + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtnonfundprop")));
					dblourTotExist = dblourFundExist+dblourNonFundExist;
					dblourTotProp = dblourFundProp+dblourNonFundProp;
					blnFlag=true;
				}
			}
			if(blnFlag)
			{
				arrVec1 = new ArrayList();
				arrVec1.add(Helper.formatDoubleValue(dblotrFundExist));
				arrVec1.add(Helper.formatDoubleValue(dblotrFundProp));
				arrVec1.add(Helper.formatDoubleValue(dblotrNonFundExist));
				arrVec1.add(Helper.formatDoubleValue(dblotrNonFundProp));
				arrVec1.add(Helper.formatDoubleValue(dblotrTotExist));
				arrVec1.add(Helper.formatDoubleValue(dblotrTotProp));
				arrVec1.add("Other Bank");
				arrRow1.add(arrVec1);
				
				arrVec1 = new ArrayList();
				arrVec1.add(Helper.formatDoubleValue(dblourFundExist));
				arrVec1.add(Helper.formatDoubleValue(dblourFundProp));
				arrVec1.add(Helper.formatDoubleValue(dblourNonFundExist));
				arrVec1.add(Helper.formatDoubleValue(dblourNonFundProp));
				arrVec1.add(Helper.formatDoubleValue(dblourTotExist));
				arrVec1.add(Helper.formatDoubleValue(dblourTotProp));
				arrVec1.add("KBL");
				arrRow1.add(arrVec1);
			}
			if (rs != null) {
				rs.close();
			}
			/** We r reusing the same variable used in the previous loop */
			dblourFundExist = 0.0;
			dblourFundProp = 0.0;
			dblourNonFundExist = 0.0;
			dblourNonFundProp = 0.0;
			dblourTotExist = 0.0;
			dblourTotProp = 0.0;
			dblotrFundExist = 0.0;
			dblotrFundProp = 0.0;
			dblotrNonFundExist = 0.0;
			dblotrNonFundProp = 0.0;
			dblotrTotExist = 0.0;
			dblotrTotProp = 0.0;
			blnFlag=false;
			
			arrRow2=new ArrayList();
			strQuery = SQLParser.getSqlQuery("combankingselectionFI^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) 
			{
				arrVec2 = new ArrayList();
				String strType = correctNull((String)rs.getString("combk_selbank"));
				if(strType.trim().equalsIgnoreCase("Other")){
					dblotrFundExist = dblotrFundExist + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtfundexist")));
					dblotrFundProp = dblotrFundProp + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtfundprop")));
					dblotrNonFundExist = dblotrNonFundExist + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtnonfundexist")));
					dblotrNonFundProp = dblotrNonFundProp + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtnonfundprop")));
					dblotrTotExist = dblotrFundExist+dblotrNonFundExist;
					dblotrTotProp = dblotrFundProp+dblotrNonFundProp;
					blnFlag = true;
				}else if(strType.trim().equalsIgnoreCase("FI")){
						dblfundexistFI = dblfundexistFI + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtfundexist")));
						dblfundpropFI = dblfundpropFI + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtfundprop")));
						dblnonfundexistFI = dblnonfundexistFI + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtnonfundexist")));
						dblnonfundpropFI = dblnonfundpropFI + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtnonfundprop")));
						dbltotexistFI = dblfundexistFI+dblnonfundexistFI;
						dbltotpropFI = dblfundpropFI+dblnonfundpropFI;
						blnFlag = true;
				}else{
					blnFlag = true;
					dblourFundExist = dblourFundExist + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtfundexist")));
					dblourFundProp = dblourFundProp + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtfundprop")));
					dblourNonFundExist = dblourNonFundExist + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtnonfundexist")));
					dblourNonFundProp = dblourNonFundProp + Double.parseDouble(Helper.correctDouble((String)rs.getString("combk_lmtnonfundprop")));
					dblourTotExist = dblourFundExist+dblourNonFundExist;
					dblourTotProp = dblourFundProp+dblourNonFundProp;
				}
			}
			if(blnFlag)
			{
				arrVec2 = new ArrayList();
				arrVec2.add(Helper.formatDoubleValue(dblotrFundExist));
				arrVec2.add(Helper.formatDoubleValue(dblotrFundProp));
				arrVec2.add(Helper.formatDoubleValue(dblotrNonFundExist));
				arrVec2.add(Helper.formatDoubleValue(dblotrNonFundProp));
				arrVec2.add(Helper.formatDoubleValue(dblotrTotExist));
				arrVec2.add(Helper.formatDoubleValue(dblotrTotProp));
				arrVec2.add("Other Bank");
				arrRow2.add(arrVec2);
				
				arrVec2 = new ArrayList();
				arrVec2.add(Helper.formatDoubleValue(dblourFundExist));
				arrVec2.add(Helper.formatDoubleValue(dblourFundProp));
				arrVec2.add(Helper.formatDoubleValue(dblourNonFundExist));
				arrVec2.add(Helper.formatDoubleValue(dblourNonFundProp));
				arrVec2.add(Helper.formatDoubleValue(dblourTotExist));
				arrVec2.add(Helper.formatDoubleValue(dblourTotProp));
				arrVec2.add("KBL");
				arrRow2.add(arrVec2);
				
				arrVec2 = new ArrayList();
				arrVec2.add(Helper.formatDoubleValue(dblfundexistFI));
				arrVec2.add(Helper.formatDoubleValue(dblfundpropFI));
				arrVec2.add(Helper.formatDoubleValue(dblnonfundexistFI));
				arrVec2.add(Helper.formatDoubleValue(dblnonfundpropFI));
				arrVec2.add(Helper.formatDoubleValue(dbltotexistFI));
				arrVec2.add(Helper.formatDoubleValue(dbltotpropFI));
				arrVec2.add("Financial Institutions");
				arrRow2.add(arrVec2);
			}

			ArrayList arr2 = new ArrayList();
			ArrayList arr3 = new ArrayList();
			double nfundext = 0.00;
			double nfundext1 = 0.00;
			double nfundpro = 0.00;
			double nfundpro1 = 0.00;

			double fundext = 0.00;
			double fundext1 = 0.00;
			double fundpro = 0.00;
			double fundpro1 = 0.00;

			double tfundext = 0.00;
			double tfundext1 = 0.00;
			double tfundpro = 0.00;
			double tfundpro1 = 0.00;

			int arrSize1 = 0;
			arr2 = arrRow1;
			if (arr2 != null && arr2.size() > 0) 
			{
				arrSize1 = arr2.size();

				for (int i = 0; i < arrSize1; i++) 
				{
					arr3 = (ArrayList) arr2.get(i);

					nfundext = Double.parseDouble(Helper
							.correctDouble((String) arr3.get(0)));
					nfundext1 = nfundext1 + nfundext;
					nfundpro = Double.parseDouble(Helper
							.correctDouble((String) arr3.get(1)));
					nfundpro1 = nfundpro1 + nfundpro;

					fundext = Double.parseDouble(Helper
							.correctDouble((String) arr3.get(2)));
					fundext1 = fundext1 + fundext;
					fundpro = Double.parseDouble(Helper
							.correctDouble((String) arr3.get(3)));
					fundpro1 = fundpro1 + fundpro;

					tfundext = Double.parseDouble(Helper
							.correctDouble((String) arr3.get(4)));
					tfundext1 = tfundext1 + tfundext;
					tfundpro = Double.parseDouble(Helper
							.correctDouble((String) arr3.get(5)));
					tfundpro1 = tfundpro1 + tfundpro;
					
					cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
					cell.setHorizontalAlignment(1);
					cell.setColspan(1);
					cell.setBorder(0);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase("Working Capital - "+correctNull((String)arr3.get(6)),ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(0);
					cell.setColspan(3);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arr3.get(2)))),ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(2);
					cell.setColspan(1);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arr3.get(3)))),ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(2);
					cell.setColspan(1);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arr3.get(0)))),ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(2);
					cell.setColspan(1);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arr3.get(1)))),ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(2);
					cell.setColspan(1);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arr3.get(4)))),ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(2);
					cell.setColspan(1);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arr3.get(5)))),ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(2);
					cell.setColspan(1);
					table.addCell(cell);
					cell=null;
				}
				
			}
			else
			{
				cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(1);
				cell.setColspan(1);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase(".",ReportConstants.REPORT_FONT_COLOR_WHITE_9));
				cell.setHorizontalAlignment(1);
				cell.setColspan(3);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase(".",ReportConstants.REPORT_FONT_COLOR_WHITE_9));
				cell.setHorizontalAlignment(1);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase(".",ReportConstants.REPORT_FONT_COLOR_WHITE_9));
				cell.setHorizontalAlignment(1);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase(".",ReportConstants.REPORT_FONT_COLOR_WHITE_9));
				cell.setHorizontalAlignment(1);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase(".",ReportConstants.REPORT_FONT_COLOR_WHITE_9));
				cell.setHorizontalAlignment(1);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase(".",ReportConstants.REPORT_FONT_COLOR_WHITE_9));
				cell.setHorizontalAlignment(1);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase(".",ReportConstants.REPORT_FONT_COLOR_WHITE_9));
				cell.setHorizontalAlignment(1);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
			}
			
			ArrayList arr4 = new ArrayList();
			ArrayList arr5 = new ArrayList();
			int arrSize3 = 0;
			arr4 = arrRow2;
			if (arr4 != null && arr4.size() > 0) 
			{

				arrSize3 = arr4.size();

				for (int i = 0; i < arrSize3; i++) 
				{
					arr5 = (ArrayList) arr4.get(i);

					nfundext = Double.parseDouble(Helper
							.correctDouble((String) arr5.get(0)));
					nfundext1 = nfundext1 + nfundext;
					nfundpro = Double.parseDouble(Helper
							.correctDouble((String) arr5.get(1)));
					nfundpro1 = nfundpro1 + nfundpro;

					fundext = Double.parseDouble(Helper
							.correctDouble((String) arr5.get(2)));
					fundext1 = fundext1 + fundext;
					fundpro = Double.parseDouble(Helper
							.correctDouble((String) arr5.get(3)));
					fundpro1 = fundpro1 + fundpro;

					tfundext = Double.parseDouble(Helper
							.correctDouble((String) arr5.get(4)));
					tfundext1 = tfundext1 + tfundext;
					tfundpro = Double.parseDouble(Helper
							.correctDouble((String) arr5.get(5)));
					tfundpro1 = tfundpro1 + tfundpro;
					
					cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
					cell.setHorizontalAlignment(1);
					cell.setColspan(1);
					cell.setBorder(0);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase("Term Loan - "+correctNull((String)arr5.get(6)),ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(0);
					cell.setColspan(3);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arr5.get(2)))),ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(2);
					cell.setColspan(1);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arr5.get(3)))),ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(2);
					cell.setColspan(1);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arr5.get(0)))),ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(2);
					cell.setColspan(1);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arr5.get(1)))),ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(2);
					cell.setColspan(1);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arr5.get(4)))),ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(2);
					cell.setColspan(1);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arr5.get(5)))),ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(2);
					cell.setColspan(1);
					table.addCell(cell);
					cell=null;
				}
			}
			cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(1);
			cell.setColspan(1);
			cell.setBorder(0);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("TOTAL",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(2);
			cell.setColspan(3);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase(Helper.formatDoubleValue(fundext1),ReportConstants.REPORT_FONT_NORMAL));
			cell.setHorizontalAlignment(2);
			cell.setColspan(1);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase(Helper.formatDoubleValue(fundpro1),ReportConstants.REPORT_FONT_NORMAL));
			cell.setHorizontalAlignment(2);
			cell.setColspan(1);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase(Helper.formatDoubleValue(nfundext1),ReportConstants.REPORT_FONT_NORMAL));
			cell.setHorizontalAlignment(2);
			cell.setColspan(1);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase(Helper.formatDoubleValue(nfundpro1),ReportConstants.REPORT_FONT_NORMAL));
			cell.setHorizontalAlignment(2);
			cell.setColspan(1);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase(Helper.formatDoubleValue(tfundext1),ReportConstants.REPORT_FONT_NORMAL));
			cell.setHorizontalAlignment(2);
			cell.setColspan(1);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase(Helper.formatDoubleValue(tfundpro1),ReportConstants.REPORT_FONT_NORMAL));
			cell.setHorizontalAlignment(2);
			cell.setColspan(1);
			table.addCell(cell);
			cell=null;	
			
			document.add(table);
			table=null;
			
			if (rs != null) {
				rs.close();
			}
			String strpropcomdesc="";
			strQuery = SQLParser.getSqlQuery("compropform11^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				if(!Helper.correctNull((String)rs.getString("com_propcomdesc")).equalsIgnoreCase(""))
				{
					strpropcomdesc=correctNull(Helper.CLOBToString(rs.getClob("com_propcomdesc")));
				}
				else
				{
					strpropcomdesc="";
				}
			}
			
			if (rs != null) {
				rs.close();
			}
			
			int[] wid2={7,50,43};
			table=new Table(3);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f);
			table.setWidths(wid2);
			table.setBorder(1);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(0);
			cell.setBorder(0);
			cell.setColspan(1);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("BRIEF BACKGROUND",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(0);
			cell.setBorder(0);
			cell.setColspan(2);
			table.addCell(cell);
			cell=null;
			
			if(!strpropcomdesc.equalsIgnoreCase(""))
			{
				
				//cell=new Cell(new Phrase(ReportGenerator.getParsingHTML(strpropcomdesc, document),ReportConstants.REPORT_FONT_NORMAL));
				//cell.setHorizontalAlignment(0);
				//cell.setBorder(0);
				//cell.setColspan(2);
				//table.addCell(cell);
				document.add(table);
				document=ReportGenerator.getParsingHTML(strpropcomdesc, document);
				
			}
			else
			{
				table.addCell(rm.ReportCellFontColorWhite9(0,".",3));
				document.add(table);
			}
			table=null;
			
			table=new Table(3);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f);
			table.setWidths(wd1);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			table.addCell(rm.ReportCell(0,"\n",3,0.0f));	
			
			table.addCell(rm.ReportCellBold(1,"14.",1,2,0.0f));				
			table.addCell(rm.ReportCellBold(0,"FINANCIAL INDICATORS",2,1,0.0f));			
					
			table.addCell(rm.ReportCellBold(0,"Company Name : "+strcompanyname,2,0.0f));
			
			document.add(table);
			table=null;
			
			float[] cmwid4={7.0f,13.0f,10.0f,10.0f,10.0f,10.0f,10.0f,10.0f,10.0f};
			table=new Table(9);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f);
			table.setWidths(cmwid4);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			hshformula.put("appno", strAppno);
			hshformula.put("comappid", comappid);
			hshValueFinancial = (HashMap) EJBInvoker.executeStateLess("corpexecutivesummarytwopdf", hshformula, "getFinancialData");

			String label0 = "";
			label0 = Helper.correctNull((String) hshValueFinancial.get("label0"));

			ArrayList vecdesc = (ArrayList) hshValueFinancial.get("vecdesc");
			ArrayList vectype = (ArrayList) hshValueFinancial.get("vectype");
			ArrayList vecCuryear = (ArrayList) hshValueFinancial.get("year");
			ArrayList vecCuryearHold = (ArrayList) hshValueFinancial.get("yearhold");
			ArrayList vecPreyear = (ArrayList) hshValueFinancial.get("prevyear");
			ArrayList vecPreyearHold = (ArrayList) hshValueFinancial
					.get("prevyearhold");
			ArrayList vecNextyear = (ArrayList) hshValueFinancial.get("nextyear");
			ArrayList vecNextyearHold = (ArrayList) hshValueFinancial
					.get("nextyearhold");
			ArrayList vecNextyear2 = (ArrayList) hshValueFinancial.get("nextyear2");
			ArrayList vecNextyearHold2 = (ArrayList) hshValueFinancial
					.get("nextyearhold2");
			ArrayList vecPreyear1 = (ArrayList) hshValueFinancial.get("prevyear1");
			ArrayList vecPreyearHold1 = (ArrayList) hshValueFinancial
					.get("prevyearhold1");
			
			int vecsizeFI = 0;

			ArrayList yearval = new ArrayList();
			yearval = (ArrayList) hshValueFinancial.get("yearvalue");

			String curYear = Helper.correctNull((String) yearval.get(0));
			String curYearDesc = Helper.correctNull((String) yearval.get(1));
			String pervYear = Helper.correctNull((String) yearval.get(2));
			String prevYearDesc = Helper.correctNull((String) yearval.get(3));
			String nextYear = Helper.correctNull((String) yearval.get(4));
			String nextYearDesc = Helper.correctNull((String) yearval.get(5));
			String pervYear1 = Helper.correctNull((String) yearval.get(6));
			String prevYearDesc1 = Helper.correctNull((String) yearval.get(7));
			String nextYear2 = Helper.correctNull((String) yearval.get(8));
			String nextYearDesc2 = Helper.correctNull((String) yearval.get(9));

			String a = "", b = "", c = "", d = "", e = "";
			if (curYearDesc.trim().equals("a")) {
				a = "Audited";
			} else if (curYearDesc.trim().equals("u")) {
				a = "Unaudited";
			} else if (curYearDesc.trim().equals("e")) {
				a = "Estimated";
			} else if (curYearDesc.trim().equals("p")) {
				a = "Projection";
			}
			if (prevYearDesc.trim().equals("a")) {
				b = "Audited";
			} else if (prevYearDesc.trim().equals("u")) {
				b = "Unaudited";
			} else if (prevYearDesc.trim().equals("e")) {
				b = "Estimated";
			} else if (prevYearDesc.trim().equals("p")) {
				b = "Projection";
			}
			if (nextYearDesc.trim().equals("a")) {
				c = "Audited";
			} else if (nextYearDesc.trim().equals("u")) {
				c = "Unaudited";
			} else if (nextYearDesc.trim().equals("e")) {
				c = "Estimated";
			} else if (nextYearDesc.trim().equals("p")) {
				c = "Projection";
			}
			if (prevYearDesc1.trim().equals("a")) {
				d = "Audited";
			} else if (prevYearDesc1.trim().equals("u")) {
				d = "Unaudited";
			} else if (prevYearDesc1.trim().equals("e")) {
				d = "Estimated";
			} else if (prevYearDesc1.trim().equals("p")) {
				d = "Projection";
			}
			if (nextYearDesc2.trim().equals("a")) {
				e = "Audited";
			} else if (nextYearDesc2.trim().equals("u")) {
				e = "Unaudited";
			} else if (nextYearDesc2.trim().equals("e")) {
				e = "Estimated";
			} else if (nextYearDesc2.trim().equals("p")) {
				e = "Projection";
			}
			table.addCell(rm.ReportCellBold(0,"",1,0.0f));
			table.addCell(rm.ReportCellBold(2,"(Rs In "+strProposalvalue+")",8));				
			
			table.addCell(rm.ReportCellBold(0,"",1,0.0f));
			table.addCell(rm.ReportCellBold(1,"Particulars",3));
			
			table.addCell(rm.ReportCellBold(1,pervYear,1));
			table.addCell(rm.ReportCellBold(1,pervYear1,1));
			table.addCell(rm.ReportCellBold(1,curYear,1));
			table.addCell(rm.ReportCellBold(1,nextYear,1));
			table.addCell(rm.ReportCellBold(1,nextYear2,1));
			
				table.addCell(rm.ReportCellBold(0,"",1,0.0f));
				table.addCell(rm.ReportCellBold(1,"",3));
				table.addCell(rm.ReportCellBold(1,b,1));
				table.addCell(rm.ReportCellBold(1,d,1));
				table.addCell(rm.ReportCellBold(1,a,1));
				table.addCell(rm.ReportCellBold(1,c,1));
				table.addCell(rm.ReportCellBold(1,e,1));
			
			
			if (vecdesc != null) {
				vecsizeFI = vecdesc.size();
			}

			for (int i = 0; i < vecsizeFI; i++) 
			{
				String desc = Helper.correctNull((String) vecdesc.get(i));
				String type = Helper.correctNull((String) vectype.get(i));
				String col1 = Helper.correctNull((String) vecCuryear
						.get(i));//3
				String col2 = Helper.correctNull((String) vecCuryearHold
						.get(i));
				String col3 = Helper.correctNull((String) vecPreyear
						.get(i));//1
				String col4 = Helper.correctNull((String) vecPreyearHold
						.get(i));
				String col5 = Helper.correctNull((String) vecNextyear
						.get(i));//4
				String col6 = Helper.correctNull((String) vecNextyearHold
						.get(i));
				String col9 = Helper.correctNull((String) vecNextyear2
						.get(i));//5
				String col10 = Helper.correctNull((String) vecNextyearHold2
						.get(i));
				String col7 = Helper.correctNull((String) vecPreyear1
						.get(i));
				String col8 = Helper.correctNull((String) vecPreyearHold1
						.get(i));//2
				if (type.trim().equals("HE") || type.trim().equals("H")) 
				{
					cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(0);
					cell.setColspan(1);
					cell.setBorder(0);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase(desc,ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(0);
					cell.setColspan(3);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(2);
					cell.setColspan(1);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(2);
					cell.setColspan(1);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(2);
					cell.setColspan(1);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(2);
					cell.setColspan(1);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(2);
					cell.setColspan(1);
					table.addCell(cell);
					cell=null;
				}
				else
				{
					cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(0);
					cell.setColspan(1);
					cell.setBorder(0);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase(desc,ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(0);
					cell.setColspan(3);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase(col3,ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(2);
					cell.setColspan(1);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase(col8,ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(2);
					cell.setColspan(1);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase(col1,ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(2);
					cell.setColspan(1);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase(col5,ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(2);
					cell.setColspan(1);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase(col9,ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(2);
					cell.setColspan(1);
					table.addCell(cell);
					cell=null;
				}
			}
			document.add(table);
			table=null;
			
			table=new Table(3);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f);
			table.setWidths(wid2);
			table.setBorder(1);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			table.addCell(rm.ReportCellBold(0,"",1,0.0f));
			table.addCell(rm.ReportCellBold(0,"COMMENTS ON FINANCIAL INDICATORS",2,0.0f));
			if(!Helper.correctNull((String) hshValueFinancial.get("exec_notes")).equalsIgnoreCase(""))
			{
				//document.add(table);
				document=ReportGenerator.getParsingHTML(correctNull((String) hshValueFinancial.get("exec_notes")), document);
			}
			else
			{
				table.addCell(rm.ReportCellFontColorWhite9(0,".",2,0.0f));
				document.add(table);
			}
			
			table=null;
			
			displayComments1(document,strAppno,strcompanyname,strauditnotes);
			
			table=new Table(3);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f);
			table.setWidths(wd2);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);

////////start of saravanan

			
			String strConductAccount = "",strConductNumber="",selstock="",strStockNumber="",strConductMSOD="";
			String strConductMSODNumber = "",strConductQPR="",strConductQPRNumber="";
			String strConductFin="",strConductFinNumber="",strConductCMA="",strConductCMANumber="";
			String strStockAmount="",strStockDate="",strConductMSODStatement="",strConductMSODDate="";
			String strConductTurn="",strConductExcess="",strConductCheques="",strConductQprstmt="",
			strConductQprdate="";
			strQuery = SQLParser.getSqlQuery("conduct_sel^" + strAppno);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				strConductAccount = correctNull(rs.getString("conduct_acc"));
				strConductNumber = correctNull(rs.getString("conduct_no"));
				selstock = correctNull(rs.getString("conduct_accstock"));
				strStockNumber = correctNull(rs.getString("conduct_stockno"));
				strConductMSOD = correctNull(rs.getString("conduct_msod"));
				strConductMSODNumber = correctNull(rs.getString("conduct_msodno"));
				strConductQPR = correctNull(rs.getString("conduct_qpr"));
				if(strConductQPR.equalsIgnoreCase("1"))
				{
					strConductQPR="Yes";
				}
				else if(strConductQPR.equalsIgnoreCase("2"))
				{
					strConductQPR="No";
				}
				else
				{
					strConductQPR="";
				}
				strConductQPRNumber = correctNull(rs.getString("conduct_qprno"));
				strConductFin = Helper.correctDouble((String) rs.getString("conduct_fin"));
				strConductFinNumber = correctNull(rs.getString("conduct_finno"));
				strConductCMA = correctNull(rs.getString("conduct_cma"));
				if(strConductCMA.equalsIgnoreCase("1"))
				{
					strConductCMA="Yes";
				}
				else if(strConductCMA.equalsIgnoreCase("2"))
				{
					strConductCMA="No";
				}
				else
				{
					strConductCMA="";
				}
				strConductCMANumber = correctNull(rs.getString("conduct_cmano"));
				strStockAmount = correctNull(rs.getString("conduct_stockstamt"));
				strStockDate = correctNull(rs.getString("conduct_stockdate"));	
				strConductMSODStatement = correctNull(rs.getString("conduct_msodstmt"));
				strConductMSODDate = correctNull(rs.getString("conduct_msoddate"));
				strConductTurn = correctNull(rs.getString("conduct_turn"));
				strConductExcess = correctNull(rs.getString("conduct_excess"));
				strConductCheques = correctNull(rs.getString("conduct_cheques"));
				strConductQprstmt=correctNull(rs.getString("conduct_qprstmt"));
				strConductQprdate=correctNull(rs.getString("conduct_qprdate"));
			}
			
			if (strConductExcess.equalsIgnoreCase("")) {
				strConductExcess = "Nil";
			}
			
			if (strConductCheques.equalsIgnoreCase("")) {
				strConductCheques = "Nil";
			}
			if (strConductMSOD.equalsIgnoreCase("1")) {
				strConductMSOD = "Yes";
			} else if (strConductMSOD.equalsIgnoreCase("2")) {
				strConductMSOD = "No";
			} else {
				strConductMSOD = " ";
			}
			
			if (strConductFin.equalsIgnoreCase("1")) {
				strConductFin = "Yes";
			} else if (strConductFin.equalsIgnoreCase("2")) {
				strConductFin = "No";
			} else {
				strConductFin = " ";
			}
			
			
			if (strConductAccount.equalsIgnoreCase("1")) {
				strConductAccount = "Satisfactory";
			} else if (strConductAccount.equalsIgnoreCase("2")) {
				strConductAccount = "Not Satisfactory";
			} else if (strConductAccount.equalsIgnoreCase("3")) {
				strConductAccount = "Good";
			} else if (strConductAccount.equalsIgnoreCase("4")) {
				strConductAccount = "Poor";
			} else if (strConductAccount.equalsIgnoreCase("5")) {
				strConductAccount = "Not Healthy";
			} else {
				strConductAccount = " ";
			}
			
			if (selstock.equalsIgnoreCase("1")) {
				selstock = "Yes";
			} else if (selstock.equalsIgnoreCase("2")) {
				selstock = "No";
			} else {
				selstock = " ";
			}
			
			table.addCell(rm.ReportCellBold(1,"18. ",1,0.0f));				
			table.addCell(rm.ReportCellBold(0,"CONDUCT OF THE ACCOUNT",2,0.0f));
			
			
			if(!strConductAccount.trim().equalsIgnoreCase(""))
			{
				table.addCell(rm.ReportCellBold(1,"",1,0.0f));	
				table.addCell(rm.ReportCell(0,strConductAccount+""+strConductNumber,2,0.0f));
			}
			else
			{
				table.addCell(rm.ReportCellFontColorWhite9(0,".",1,0.0f));	
				table.addCell(rm.ReportCellFontColorWhite9(0,".",2,0.0f));
			}
			
			table.addCell(rm.ReportCellBold(1,"18.1 ",1,0.0f));				
			table.addCell(rm.ReportCellBold(0,"REGULARITY IN SUBMISSION OF",2,0.0f));			
			
			table.addCell(rm.ReportCellBold(1,"",1,0.0f));				
			table.addCell(rm.ReportCell(0,"- Stock Statements / Book Debt Statements",1,0.0f));
			
			if(!selstock.trim().equalsIgnoreCase(""))
			{
				table.addCell(rm.ReportCell(0,selstock+" "+strStockNumber,1,0.0f));
			}
			else
			{
				table.addCell(rm.ReportCellFontColorWhite9(0,".",1,0.0f));
			}
			
			
			
			table.addCell(rm.ReportCellBold(1,"",1,0.0f));				
			table.addCell(rm.ReportCell(0,"MSOD",1,0.0f));
			
			if(!strConductMSOD.trim().equals(""))
			{
				table.addCell(rm.ReportCell(0,strConductMSOD+""+strConductMSODNumber,1,0.0f));
			}
			else
			{
				table.addCell(rm.ReportCellFontColorWhite9(0,".",1,0.0f));
			}
			
			
			table.addCell(rm.ReportCellBold(1,"",1,0.0f));				
			table.addCell(rm.ReportCell(0,"-QPR Statements / Half Yearly Statements",1,0.0f));
			
			if(!strConductQPR.equals(""))
			{
				table.addCell(rm.ReportCell(0,strConductQPR+""+strConductQPRNumber,1,0.0f));
			}
			else
			{
				table.addCell(rm.ReportCellFontColorWhite9(0,".",1,0.0f));
			}
			
			table.addCell(rm.ReportCellBold(1,"",1,0.0f));				
			table.addCell(rm.ReportCell(0,"-Financial Statements",1,0.0f));
			
			if(!strConductFin.equals(" "))
			{
				table.addCell(rm.ReportCell(0,strConductFin+""+strConductFinNumber,1,0.0f));
			}
			else
			{
				table.addCell(rm.ReportCellFontColorWhite9(0,".",1,0.0f));
				
			}
			table.addCell(rm.ReportCellBold(1,"",1,0.0f));				
			table.addCell(rm.ReportCell(0,"-CMA Data",1,0.0f));
			
			if(!strConductCMA.trim().equals(""))
			{
				table.addCell(rm.ReportCell(0,strConductCMA+""+strConductCMANumber,1,0.0f));
			}
			else
			{
				table.addCell(rm.ReportCellFontColorWhite9(0,".",1,0.0f));
			}
			
			table.addCell(rm.ReportCellBold(1,"18.2",1,0.0f));				
			table.addCell(rm.ReportCellBold(0,"Name of the statement/return",2,0.0f));
			
			document.add(table);
			table=null;
			
			int[] cmwid5={7,40,30,23};
			table=new Table(4);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f);
			table.setWidths(cmwid5);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			table.addCell(rm.ReportCellBold(1,"",1,0.0f));
			table.addCell(rm.ReportCellBold(1,"",1));
			table.addCell(rm.ReportCellBold(0,"No of Statements/Return \n recd. during the year "+"Last Stat. \n / Return recd.",1));
			table.addCell(rm.ReportCellBold(0,"Last Stat. / Return recd.",1));
			
			//--------to be insert code here--------//
			
			table.addCell(rm.ReportCellBold(1,"",1,0.0f));
			table.addCell(rm.ReportCellBold(0,"Stock Statement /BD",1));
			
			if(!strStockAmount.equals(""))
			{
				table.addCell(rm.ReportCell(0,strStockAmount,1));				
				table.addCell(rm.ReportCell(0,strStockDate,1));
			}
			else
			{
				table.addCell(rm.ReportCellFontColorWhite9(1,".",1));			
				table.addCell(rm.ReportCellFontColorWhite9(0,".",1));
			}
			
			table.addCell(rm.ReportCellBold(1,"",1,0.0f));
			table.addCell(rm.ReportCellBold(0,"MSOD",1));
			
			if(!strConductMSODStatement.equals(""))
			{
				table.addCell(rm.ReportCell(0,strConductMSODStatement,1));				
				table.addCell(rm.ReportCell(0,strConductMSODDate,1));
			}else
			{
				table.addCell(rm.ReportCellFontColorWhite9(1,".",1));			
				table.addCell(rm.ReportCellFontColorWhite9(0,".",1));
			}
			
			table.addCell(rm.ReportCellBold(1,"",1,0.0f));
			table.addCell(rm.ReportCellBold(0,"QPR / Half Yearly Statement",1));
			if(!strConductQprstmt.equals(""))
			{
				table.addCell(rm.ReportCell(0,strConductQprstmt,1));				
				table.addCell(rm.ReportCell(0,strConductQprdate,1));
			}else
			{
				table.addCell(rm.ReportCellFontColorWhite9(1,".",1));			
				table.addCell(rm.ReportCellFontColorWhite9(0,".",1));
			}
			
			
			document.add(table);
			table=null;
			
			table=new Table(3);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f);
			table.setWidths(wd2);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			table.addCell(rm.ReportCellBold(1,"18.3",1,0.0f));				
			table.addCell(rm.ReportCellBold(0,"COMMENTS ON OPERATIONS / OVERDUES",2,0.0f));
			
			table.addCell(rm.ReportCellBold(1,"",1,0.0f));				
			table.addCell(rm.ReportCell(0,"Indicate Whether",2,0.0f));
			
			table.addCell(rm.ReportCellBold(1,"",1,0.0f));				
			table.addCell(rm.ReportCellBold(0,"(1) Turnover in the account is \n commensurate with the limits.",2,0.0f));
			
			String conduct_turn = Helper.correctNull((String) hshValues.get("conduct_turn"));
            if (strConductTurn.trim().equals("")) 
            {
            	strConductTurn="Nil"; 
            } 
            else 
            {
				StringTokenizer strIdV16c = new StringTokenizer(strConductTurn,"\n");
				while (strIdV16c.hasMoreTokens()) {
					String strTempV = (String) strIdV16c.nextToken();
					
				}
			}
			
			table.addCell(rm.ReportCellBold(1,"",1,0.0f));				
			table.addCell(rm.ReportCell(0,strConductTurn,2,0.0f));
			
			table.addCell(rm.ReportCellBold(1,"",1,0.0f));				
			table.addCell(rm.ReportCellBold(0,"(2) Frequent excesses are given.",1,0.0f));
			table.addCell(rm.ReportCell(0,strConductExcess,1,0.0f));
			
			table.addCell(rm.ReportCellBold(1,"",1,0.0f));				
			table.addCell(rm.ReportCellBold(0,"(3) Cheques are returned frequently.",1,0.0f));
			table.addCell(rm.ReportCell(0,strConductCheques,1,0.0f));
		
			table.addCell(rm.ReportCellBold(1,"19. ",1,0.0f));				
			table.addCell(rm.ReportCellBold(0,"COMPLIANCE TO TERMS OF SANCTION ",2,0.0f));
			
			if(strConductAccount.equals(""))
			{
				table.addCell(rm.ReportCellBold(1,"",1,0.0f));				
				table.addCell(rm.ReportCell(0,strConductAccount+""+strConductNumber,2,0.0f));
			}
			else
			{
				table.addCell(rm.ReportCellFontColorWhite9(1,".",1,0.0f));			
				table.addCell(rm.ReportCellFontColorWhite9(0,".",2,0.0f));
			}			
			
			strQuery = SQLParser.getSqlQuery("execsel_inducom^" + strAppno);

			String selmort="",strSumMortgage="",strExecutionSumRoc="",strExecSummaryRocY="",strConcatRocY="";
			String strSumValiDoc="",strSumValiDocY="",strExecSumTerms="",strExecSumTermsY="";
			String strSumLevelRbiY2="",strSumLevelRemarks2="",strSummMeetingHeld="",strSummMeetingHeldY="";
			String strExecIndLevelBankY="",strExecSummRemarks="",strExecSummDateofInspc="",strIndLevelOtherRisk="";
			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				selmort = Helper.correctNull((String)correctNull(rs.getString("exec_summ_mortage")));
				if (selmort.equalsIgnoreCase("1")) {
					selmort = "Yes";
				} else if (selmort.equalsIgnoreCase("2")) {
					selmort = "No";
				} else {
					selmort = " ";
				}
				
				strSumMortgage = correctNull((String)rs.getString("exec_summ_mortageY"));
				strExecutionSumRoc = correctNull((String)rs.getString("exec_summ_roc"));
				strExecSummaryRocY = correctNull((String)rs.getString("exec_summ_rocY"));
				
				strSumValiDoc = correctNull((String)rs.getString("exec_summ_validdoc"));
				strSumValiDocY = correctNull((String)rs.getString("exec_summ_validdocY"));
				strExecSumTerms = correctNull((String)rs.getString("exec_summ_terms"));
				strExecSumTermsY = correctNull((String)rs.getString("exec_summ_termsY"));
				
				strSumLevelRbiY2 = correctNull((String)rs.getString("exec_summ_indlevelrbiY"));
				strSumLevelRemarks2 = correctNull((String)rs.getString("exec_summ_indlevelrbiremarks"));
				
				strSummMeetingHeld = correctNull((String)rs.getString("exec_summ_meetingheld"));
				strSummMeetingHeldY = correctNull((String)rs.getString("exec_summ_meetingheldY"));
				
				strExecIndLevelBankY = correctNull((String)rs.getString("exec_summ_indlevelbankY"));
				strExecSummRemarks = correctNull((String)rs.getString("exec_summ_remarks"));
				
				strExecSummDateofInspc = correctNull((String)rs.getString("exec_summ_dateofinspc"));
				strIndLevelOtherRisk = correctNull((String)rs.getString("exec_summ_indlevelotherrisk"));
				
				
				
				
				if (strExecIndLevelBankY.equalsIgnoreCase("1")) {
					strExecIndLevelBankY = "Yes";
				} else if (strExecIndLevelBankY.equalsIgnoreCase("2")) {
					strExecIndLevelBankY = "No";
				} else {
					strExecIndLevelBankY = " ";
				}
				
				if (strSummMeetingHeld.equalsIgnoreCase("1")) {
					strSummMeetingHeld = "Yes";
				} else if (strSummMeetingHeld.equalsIgnoreCase("2")) {
					strSummMeetingHeld = "No";
				} else {
					strSummMeetingHeld = " ";
				}
				
				if (strSumLevelRbiY2.equalsIgnoreCase("1")) {
					strSumLevelRbiY2 = "Yes";
				} else if (strSumLevelRbiY2.equalsIgnoreCase("2")) {
					strSumLevelRbiY2 = "No";
				} else {
					strSumLevelRbiY2 = " ";
				}
				
				if (strExecSumTerms.equalsIgnoreCase("1")) {
					strExecSumTerms = "Yes";
				} else if (strExecSumTerms.equalsIgnoreCase("2")) {
					strExecSumTerms = "No";
				} else {
					strExecSumTerms = " ";
				}
				
				 
							
				if (strExecutionSumRoc.equalsIgnoreCase("1")) {
					strExecutionSumRoc = "Yes";
				} else if (strExecutionSumRoc.equalsIgnoreCase("2")) {
					strExecutionSumRoc = "No";
				} else {
					strExecutionSumRoc = " ";
				}
			}
			if(strExecSummDateofInspc.equalsIgnoreCase("")){
				strExecSummDateofInspc = "Nil";
			}	
			
			if (strExecSummaryRocY.trim().equals("")) {
		           strConcatRocY="";
				 }
		       	 else {
		       		strConcatRocY = strExecSummaryRocY;
					}
			
			table.addCell(rm.ReportCellBold(1,"19.1 ",1,0.0f));				
			table.addCell(rm.ReportCellBold(0,"Complete of Mortgage formalities",2,0.0f));
			
			if(!selmort.trim().equalsIgnoreCase(""))
			{
				table.addCell(rm.ReportCellBold(1,"",1,0.0f));				
				table.addCell(rm.ReportCell(0,selmort,2,0.0f));
			}
			else
			{
				table.addCell(rm.ReportCellFontColorWhite9(1,".",1,0.0f));			
				table.addCell(rm.ReportCellFontColorWhite9(0,".",2,0.0f));
			}
			
			
			if(!strSumMortgage.trim().equalsIgnoreCase(""))
			{
				table.addCell(rm.ReportCellBold(1,"",1,0.0f));				
				table.addCell(rm.ReportCell(0,strSumMortgage,2,0.0f));
			}
			else
			{
				table.addCell(rm.ReportCellFontColorWhite9(1,".",1,0.0f));			
				table.addCell(rm.ReportCellFontColorWhite9(0,".",2,0.0f));
			}
			
			table.addCell(rm.ReportCellBold(1,"19.2 ",1,0.0f));				
			table.addCell(rm.ReportCellBold(0,"Registration of charges with ROC",2,0.0f));
			
			if(!strExecutionSumRoc.trim().equalsIgnoreCase(""))
			{
				table.addCell(rm.ReportCellBold(1,"",1,0.0f));				
				table.addCell(rm.ReportCell(0,strExecutionSumRoc+""+strConcatRocY,2,0.0f));
			}
			else
			{
				table.addCell(rm.ReportCellFontColorWhite9(1,".",1,0.0f));			
				table.addCell(rm.ReportCellFontColorWhite9(0,".",2,0.0f));
			}
			
			
			
			if (strSumValiDoc.equalsIgnoreCase("1")) {
				strSumValiDoc = "Yes";
			} else if (strSumValiDoc.equalsIgnoreCase("2")) {
				strSumValiDoc = "No";
			} else {
				strSumValiDoc = " ";
			}
			
			table.addCell(rm.ReportCellBold(1,"19.3",1,0.0f));				
			table.addCell(rm.ReportCellBold(0,"Whether documents valid and in force",2,0.0f));
			
			if(!strSumValiDoc.trim().equalsIgnoreCase(""))
			{
				table.addCell(rm.ReportCellBold(1,"",1,0.0f));				
				table.addCell(rm.ReportCell(0,strSumValiDoc+""+strSumValiDocY,2,0.0f));
			}
			else
			{
				table.addCell(rm.ReportCellFontColorWhite9(1,".",1,0.0f));			
				table.addCell(rm.ReportCellFontColorWhite9(0,".",2,0.0f));
			}
			
			table.addCell(rm.ReportCellBold(1,"19.4",1,0.0f));				
			table.addCell(rm.ReportCellBold(0,"Whether all other terms and conditions complied with",2,0.0f));
			
			if(!strExecSumTerms.trim().equalsIgnoreCase(""))
			{
				table.addCell(rm.ReportCellBold(1,"",1,0.0f));				
				table.addCell(rm.ReportCell(0,strExecSumTerms+""+strExecSumTermsY,2,0.0f));
			}
			else
			{
				table.addCell(rm.ReportCellFontColorWhite9(1,".",1,0.0f));			
				table.addCell(rm.ReportCellFontColorWhite9(0,".",2,0.0f));
			}
			
			
			table.addCell(rm.ReportCellBold(1,"19.5",1,0.0f));				
			table.addCell(rm.ReportCellBold(0,"Compliance of RBI guidelines",2,0.0f));
			
			if(!strSumLevelRbiY2.trim().equalsIgnoreCase(""))
			{
				table.addCell(rm.ReportCellBold(1,"",1,0.0f));				
				table.addCell(rm.ReportCell(0,strSumLevelRbiY2+""+strSumLevelRemarks2,2,0.0f));
			}
			else
			{
				table.addCell(rm.ReportCellFontColorWhite9(1,".",1,0.0f));			
				table.addCell(rm.ReportCellFontColorWhite9(0,".",2,0.0f));
			}
			
			table.addCell(rm.ReportCellBold(1,"19.6",1,0.0f));				
			table.addCell(rm.ReportCellBold(0,"Whether consortium meetings held at prescribed periodic intervals",2,0.0f));
			
			if(!strSummMeetingHeld.trim().equalsIgnoreCase(""))
			{
				table.addCell(rm.ReportCellBold(1,"",1,0.0f));				
				table.addCell(rm.ReportCell(0,strSummMeetingHeld+""+strSummMeetingHeldY,2,0.0f));
			}
			else
			{
				table.addCell(rm.ReportCellFontColorWhite9(1,".",1,0.0f));			
				table.addCell(rm.ReportCellFontColorWhite9(0,".",2,0.0f));
			}
						
			table.addCell(rm.ReportCellBold(1,"19.7",1,0.0f));				
			table.addCell(rm.ReportCellBold(0,"Compliance on Loan Policy",2,0.0f));
			
			if(!strExecIndLevelBankY.trim().equalsIgnoreCase(""))
			{
				table.addCell(rm.ReportCellBold(1,"",1,0.0f));				
				table.addCell(rm.ReportCell(0,strExecIndLevelBankY+""+strExecSummRemarks,2,0.0f));
			}
			else
			{
				table.addCell(rm.ReportCellFontColorWhite9(1,".",1,0.0f));			
				table.addCell(rm.ReportCellFontColorWhite9(0,".",2,0.0f));
			}
			
			
	
			table.addCell(rm.ReportCellBold(1,"19.8",1,0.0f));				
			table.addCell(rm.ReportCellBold(0,"DATES OF INSPECTION DURING THE FINANCIAL YEAR",2,0.0f));
			
			if(!strExecSummDateofInspc.trim().equalsIgnoreCase(""))
			{
				table.addCell(rm.ReportCellBold(1,"",1,0.0f));				
				table.addCell(rm.ReportCell(0,strExecSummDateofInspc+""+strExecSummRemarks,2,0.0f));
			}
			else
			{
				table.addCell(rm.ReportCellFontColorWhite9(1,".",1,0.0f));			
				table.addCell(rm.ReportCellFontColorWhite9(0,".",2,0.0f));
			}
		
			document.add(table);
			table=null;
			
			int [] cmwid6={7,30,15,15,20,13};
			table=new Table(6);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f); 
			table.setBorder(1);
			table.setWidths(cmwid6);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			table.addCell(rm.ReportCellBold(0,"20.",1,0.0f));
			table.addCell(rm.ReportCellBold(0,"NATURE AND VALUE OF COLLATERAL SECURITY",5,0.0f));
			
			table.addCell(rm.ReportCellBold(0,"",1,0.0f));
			cell=new Cell(new Phrase("Nature / Description of collateral security indicating area & location of property",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(0);
			cell.setColspan(1);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("Value ("+ApplicationParams.getCurrency()+" in "+strProposalvalue+")",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(0);
			cell.setColspan(1);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("Date of Valuation along with name of Valuer",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(0);
			cell.setColspan(1);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("Insurance Amount & Date of Expiry",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(0);
			cell.setColspan(1);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("Remarks",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(0);
			cell.setColspan(1);
			table.addCell(cell);
			cell=null;
			
			rs = DBUtils.executeLAPSQuery("selsecuritybytype^" + strAppno+"^Collateral");
			while (rs.next()) {
				arryCol = new ArrayList();
				arryCol.add(rs.getString("sec_desc_details"));
				arryCol.add(rs.getString("sec_desc_value"));
				arryCol.add(rs.getString("as_on_date"));
				arryCol.add(rs.getString("sec_valuersname"));
				arryCol.add(rs.getString("sec_insuranceamt"));
				arryCol.add(rs.getString("sec_insexpirydate"));
				arryCol.add(rs.getString("sec_remarks"));

				arrColldetails.add(arryCol);

			}
			
			arrColldetails = arrColldetails;
			double dbltotal = 0.00;
			if (arrColldetails != null && arrColldetails.size() != 0)
			{
				for (int i = 0; i < arrColldetails.size(); i++) 
				{
					arrValues = (ArrayList) arrColldetails.get(i);
					dbltotal = dbltotal
							+ Double.parseDouble(Helper
									.correctDouble((String) arrValues.get(1)));
					
					table.addCell(rm.ReportCellBold(0,"",1,0.0f));
					
					cell=new Cell(new Phrase(Helper.correctNull((String) arrValues.get(0)),ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(0);
					cell.setColspan(1);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrValues.get(1)))),ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(0);
					cell.setColspan(1);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase(Helper.correctNull((String) arrValues.get(2))+" - "+Helper.correctNull((String) arrValues.get(3)),ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(0);
					cell.setColspan(1);
					table.addCell(cell);
					cell=null;
					
					if (Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrValues.get(4)))).equals("0.00")) 
					{
						cell=new Cell(new Phrase(" - ",ReportConstants.REPORT_FONT_NORMAL));
						cell.setHorizontalAlignment(0);
						cell.setColspan(1);
						table.addCell(cell);
						cell=null;
					}
					else
					{
						cell=new Cell(new Phrase(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrValues.get(4))))+" - "+Helper.correctNull((String) arrValues.get(5)),ReportConstants.REPORT_FONT_NORMAL));
						cell.setHorizontalAlignment(0);
						cell.setColspan(1);
						table.addCell(cell);
						cell=null;
					}
					
					cell=new Cell(new Phrase(Helper.correctNull((String) arrValues.get(6)),ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(0);
					cell.setColspan(1);
					table.addCell(cell);
					cell=null;
				}
				
				table.addCell(rm.ReportCellBold(0,"",1,0.0f));
				
				cell=new Cell(new Phrase("Total",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(0);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase(Helper.formatDoubleValue(dbltotal),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(2);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
			}
			else
			{
				cell=new Cell(new Phrase(".",ReportConstants.REPORT_FONT_COLOR_WHITE_9));
				cell.setHorizontalAlignment(0);
				cell.setColspan(1);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase(".",ReportConstants.REPORT_FONT_COLOR_WHITE_9));
				cell.setHorizontalAlignment(0);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase(".",ReportConstants.REPORT_FONT_COLOR_WHITE_9));
				cell.setHorizontalAlignment(0);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase(".",ReportConstants.REPORT_FONT_COLOR_WHITE_9));
				cell.setHorizontalAlignment(0);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase(".",ReportConstants.REPORT_FONT_COLOR_WHITE_9));
				cell.setHorizontalAlignment(0);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase(".",ReportConstants.REPORT_FONT_COLOR_WHITE_9));
				cell.setHorizontalAlignment(0);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
			}
			
			document.add(table);
			table=null;
			
			String strasondate="";
			if(rs!=null)rs.close();
			strQuery=SQLParser.getSqlQuery("selprevdate");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strasondate=correctNull((String)rs.getString("date1"));
			}	
			
			int[] wd4={7,35,23,35};
			table=new Table(4);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f);
			table.setWidths(wd4);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			cell=new Cell(new Phrase("20.1.",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(0);
			cell.setBorder(0);
			cell.setColspan(1);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("PERSONAL GUARANTEE (with means) / CORPORATE GUARANTEE (with TNW of company)",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(0);
			cell.setColspan(3);
			cell.setBorder(0);
			table.addCell(cell);
			cell=null;
			
			
			String sel_divID="",strDate="";
			String curDate = "";
			
			curDate = Helper.getCurrentDateTime();

			if (rs5 != null)
				rs5.close();

			String baseyear_query = SQLParser.getSqlQuery("sel_financial_baseyear^" + strAppno);
			rs5 = DBUtils.executeQuery(baseyear_query);

			if (rs5.next()) {
				curDate = correctNull((String) rs5.getString("base_year"));
			}

			
			strQuery = SQLParser.getSqlQuery("executive_finselect9^" + strAppno+ "^" + "0" + "^" + curDate);
			if(rs5!=null)
				rs5.close();
			rs5=DBUtils.executeQuery(strQuery);
			
			String strDesc="";
			String strCurDate="";
			if(rs5.next())
			{
				if(rs5.getDouble("sumaudit")>0)
				{
					strDesc="a";
				}
				else if(rs5.getDouble("sumunaudit")>0)
				{
					strDesc="u";
				}
				else if(rs5.getDouble("sumestimated")>0)
				{
					strDesc="e";
				}
				else if(rs5.getDouble("sumprojection")>0)
				{
					strDesc="p";
				}
				strCurDate=rs5.getString("fin_year");

			}
			
			strQuery=SQLParser.getSqlQuery("comfintrendsel1^"+strAppno);
			
			if (rs != null)
				rs.close();
			String cma = "";
			rs = DBUtils.executeQuery(strQuery);

			if (rs.next()) {
				cma=correctNull(rs.getString("demo_finstandard"));
			}

			if (cma != "") {
				strQuery = SQLParser.getSqlQuery("sel_tangiblenetworth^" + cma);
			}
			if (rs2 != null)
				rs2.close();
			rs2 = DBUtils.executeQuery(strQuery);

			String strRowtype = "";
			String strRowid = "";
			int strRowformula = 0;
			int strRowformula2 = 0;
			String strTangibleNetworth = "0.00";

			if (rs2.next()) {
				strRowtype = correctNull(rs2.getString("fin_rowtype"));
				strRowid = correctNull(rs2.getString("fin_rowid"));
				strRowformula = rs2.getInt("fin_formula");
				strRowformula2 = rs2.getInt("fin_formula2");

				if (strRowtype.trim().equals("C") && strRowformula > 0&& !strDesc.trim().equals("")) {
					hashformula = new HashMap();
					hashformula.put("appno", strAppno);
					hashformula.put("sel_divID", "0");
					hashformula.put("formulaid", Integer.toString(strRowformula));
					hashformula.put("curryear", strCurDate);
					hashformula.put("prevyear", "");
					hashformula.put("currfinancialtype", strDesc);
					hashformula.put("prevfinancialtype", "");
					hshResult = (HashMap) EJBInvoker.executeStateLess("comformula", hashformula, "GetFinValue");
					strTangibleNetworth = correctNull((String) hshResult.get("strTotalValue"));
				}
			}
			
			
			boolean bolguarantee = false;
	        boolean corpguarantee = false;
				arrRow = new ArrayList();
				arrData = new ArrayList();

				arrRow = arrGuarantors;

				if (arrRow != null && arrRow.size() != 0) 
				{
					bolguarantee = true;
					
					cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
					cell.setHorizontalAlignment(0);
					cell.setColspan(1);
					cell.setBorder(0);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase("\n",ReportConstants.REPORT_FONT_BOLD));
					cell.setHorizontalAlignment(0);
					cell.setColspan(3);
					cell.setBorder(0);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
					cell.setHorizontalAlignment(0);
					cell.setColspan(1);
					cell.setBorder(0);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase("Name",ReportConstants.REPORT_FONT_BOLD));
					cell.setHorizontalAlignment(0);
					cell.setColspan(1);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase("Means ("+ApplicationParams.getCurrency()+"In"+strProposalvalue+")",ReportConstants.REPORT_FONT_BOLD));
					cell.setHorizontalAlignment(0);
					cell.setColspan(1);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase("Means As on",ReportConstants.REPORT_FONT_BOLD));
					cell.setHorizontalAlignment(0);
					cell.setColspan(1);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
					cell.setHorizontalAlignment(0);
					cell.setColspan(1);
					cell.setBorder(0);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase("PERSONAL GUARANTEE",ReportConstants.REPORT_FONT_BOLD));
					cell.setHorizontalAlignment(0);
					cell.setColspan(3);
					table.addCell(cell);
					cell=null;
					
					for (int i = 0; i < arrRow.size(); i++) 
					{
						arrData = (ArrayList) arrRow.get(i);
						
						cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
						cell.setHorizontalAlignment(0);
						cell.setColspan(1);
						cell.setBorder(0);
						table.addCell(cell);
						cell=null;
						
						cell=new Cell(new Phrase(correctNull((String)arrData.get(0))+correctNull((String)arrData.get(2))+correctNull((String)arrData.get(1)),ReportConstants.REPORT_FONT_NORMAL));
						cell.setHorizontalAlignment(0);
						cell.setColspan(1);
						table.addCell(cell);
						cell=null;
						
						cell=new Cell(new Phrase(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrData.get(4)))),ReportConstants.REPORT_FONT_NORMAL));
						cell.setHorizontalAlignment(0);
						cell.setColspan(1);
						table.addCell(cell);
						cell=null;
						
						cell=new Cell(new Phrase(Helper.correctNull((String)arrData.get(5)),ReportConstants.REPORT_FONT_NORMAL));
						cell.setHorizontalAlignment(0);
						cell.setColspan(1);
						table.addCell(cell);
						cell=null;
					}
				}
				
				if (sel_applicantguarantee.equalsIgnoreCase("Y")) 
				{
					if (!bolguarantee) 
					{
						bolguarantee = true;
						
						cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
						cell.setHorizontalAlignment(0);
						cell.setColspan(1);
						cell.setBorder(0);
						table.addCell(cell);
						cell=null;
						
						cell=new Cell(new Phrase("Name",ReportConstants.REPORT_FONT_BOLD));
						cell.setHorizontalAlignment(0);
						cell.setColspan(1);
						table.addCell(cell);
						cell=null;
						
						cell=new Cell(new Phrase("Means ("+ApplicationParams.getCurrency()+"In"+strProposalvalue+")",ReportConstants.REPORT_FONT_BOLD));
						cell.setHorizontalAlignment(0);
						cell.setColspan(1);
						table.addCell(cell);
						cell=null;
						
						cell=new Cell(new Phrase("Means As on",ReportConstants.REPORT_FONT_BOLD));
						cell.setHorizontalAlignment(0);
						cell.setColspan(1);
						table.addCell(cell);
						cell=null;
					}
					
					if(!corpguarantee)
					{
	                	corpguarantee=true;
	                	
	                	cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
						cell.setHorizontalAlignment(0);
						cell.setColspan(1);
						cell.setBorder(0);
						table.addCell(cell);
						cell=null;
						
	                	cell=new Cell(new Phrase("CORPORATE GUARANTEE",ReportConstants.REPORT_FONT_BOLD));
						cell.setHorizontalAlignment(0);
						cell.setColspan(3);
						table.addCell(cell);
						cell=null;
					}
					
					cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
					cell.setHorizontalAlignment(0);
					cell.setColspan(1);
					cell.setBorder(0);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase(strcompanyname,ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(0);
					cell.setColspan(1);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)strTangibleNetworth))),ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(0);
					cell.setColspan(1);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase(Helper.correctNull((String)strCurDate),ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(0);
					cell.setColspan(1);
					table.addCell(cell);
					cell=null;
				}
				
				arrRow = new ArrayList();
				arrData = new ArrayList();
				arrRow = arrCorpguarantee;
				if (arrRow != null && arrRow.size() > 0)
				{
					if (!bolguarantee) 
					{
						bolguarantee = true;
						
						cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
						cell.setHorizontalAlignment(0);
						cell.setColspan(1);
						cell.setBorder(0);
						table.addCell(cell);
						cell=null;
						
						cell=new Cell(new Phrase("Name",ReportConstants.REPORT_FONT_BOLD));
						cell.setHorizontalAlignment(0);
						cell.setColspan(1);
						table.addCell(cell);
						cell=null;
						
						cell=new Cell(new Phrase("Means ("+ApplicationParams.getCurrency()+"In"+strProposalvalue+")",ReportConstants.REPORT_FONT_BOLD));
						cell.setHorizontalAlignment(0);
						cell.setColspan(1);
						table.addCell(cell);
						cell=null;
						
						cell=new Cell(new Phrase("Means As on",ReportConstants.REPORT_FONT_BOLD));
						cell.setHorizontalAlignment(0);
						cell.setColspan(1);
						table.addCell(cell);
						cell=null;
					}
					
					if(!corpguarantee)
					{
	                	corpguarantee=true;
	                	
	                	cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
						cell.setHorizontalAlignment(0);
						cell.setColspan(1);
						cell.setBorder(0);
						table.addCell(cell);
						cell=null;
						
	                	cell=new Cell(new Phrase("CORPORATE GUARANTEE",ReportConstants.REPORT_FONT_BOLD));
						cell.setHorizontalAlignment(0);
						cell.setColspan(3);
						table.addCell(cell);
						cell=null;
	                	
					}
					for (int i = 0; i < arrRow.size(); i++) 
					{
						arrData = (ArrayList) arrRow.get(i);
						
						cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
						cell.setHorizontalAlignment(0);
						cell.setColspan(1);
						cell.setBorder(0);
						table.addCell(cell);
						cell=null;
						
						cell=new Cell(new Phrase(Helper.correctNull((String) arrData.get(0)),ReportConstants.REPORT_FONT_NORMAL));
						cell.setHorizontalAlignment(0);
						cell.setColspan(1);
						table.addCell(cell);
						cell=null;
						
						cell=new Cell(new Phrase(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrData.get(4)))),ReportConstants.REPORT_FONT_NORMAL));
						cell.setHorizontalAlignment(0);
						cell.setColspan(1);
						table.addCell(cell);
						cell=null;
						
						cell=new Cell(new Phrase(Helper.correctNull((String)arrData.get(5)),ReportConstants.REPORT_FONT_NORMAL));
						cell.setHorizontalAlignment(0);
						cell.setColspan(1);
						table.addCell(cell);
						cell=null;
						
					}
				}
				
				if (!bolguarantee) 
				{
					cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
					cell.setHorizontalAlignment(0);
					cell.setColspan(1);
					cell.setBorder(0);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase("Nil",ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(0);
					cell.setColspan(3);
					table.addCell(cell);
					cell=null;
				}
			
			
			document.add(table);
			table=null;
			
			/////////end of saravanan
			
			
			//Start Nalini
			
		
			int[] wid21={7,50,43};
			table=new Table(3);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f); 
			table.setWidths(wid21);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			if (selrbi4.equalsIgnoreCase("1")) {
				selrbi4 = "Yes";
			} else if (selrbi4.equalsIgnoreCase("2")) {
				selrbi4 = "No";
			} else {
				selrbi4 = "Nil";
			}
			cell=new Cell(new Phrase("21.",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(0);
			cell.setBorder(0);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("WHETHER THE NAME OF THE COMPANY / DIRECTORS FIGURE IN RBI DEFAULTERS'/CAUTION LIST / WILFUL DEFAULTERS / ECGC. IF YES, PLEASE FURNISH DETAILS.",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(0);
			cell.setBorder(0);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase(selrbi4,ReportConstants.REPORT_FONT_NORMAL));
			cell.setHorizontalAlignment(0);
			cell.setBorder(0);
			table.addCell(cell);
			cell=null;
			
			if(!strComDesc.equalsIgnoreCase(""))
			{
				cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase(strComDesc,ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				cell.setBorder(0);
				cell.setColspan(2);
				table.addCell(cell);
				cell=null;
			}
			
			String strDir=null;
			strQuery = SQLParser.getSqlQuery("execsel_credit^" + strAppno);
			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
							
				cell=new Cell(new Phrase("21.1",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(0);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				strDir=correctNull(rs.getString("exec_summ_indlevelrbiY"));
				if (strDir.equalsIgnoreCase("1")) {
					strDir = "Yes";
				} else if (strDir.equalsIgnoreCase("2")) {
					strDir = "No";
				} else {
					strDir = "Nil";
				}
				
				cell=new Cell(new Phrase("WHETHER DIRECTOR PARTNER / PROPRIETOR IS A DIRECTOR IN OUR / OTHER BANK OR IS RELATED TO THEM. IF YES",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(0);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase(strDir,ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("      (1) Name of such Director with name of the Bank ",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(0);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase(correctNull(rs.getString("exec_summ_indlevelrbiremarks")),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("      (2) Type of Relation ",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(0);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase(correctNull(rs.getString("exec_summ_indlevelbankremarks")),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("21.2",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(0);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("Any litigation in force against the firm/ company or against the Partners / Directors. If so, mention details and present position.",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(0);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase(correctNull(rs.getString("exec_summ_strengths")),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
			
			}
			else
			{
				cell=new Cell(new Phrase("21.1.",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(0);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("WHETHER DIRECTOR PARTNER / PROPRIETOR IS A DIRECTOR IN OUR / OTHER BANK OR IS RELATED TO THEM. IF YES",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(0);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("Nil",ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("(1) Name of such Director with name of the Bank ",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(0);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("Nil",ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("(2) Type of Relation ",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(0);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("Nil",ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("21.2",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(0);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("Any litigation in force against the firm/ company or against the Partners / Directors. If so, mention details and present position.",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(0);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("Nil",ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
			}
			document.add(table);
			table=null;
			
			float[] wid22={7.0f,46.5f,46.5f};
			table=new Table(3);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f); 
			table.setWidths(wid22);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			cell=new Cell(new Phrase("22.",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(0);
			cell.setBorder(0);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("AUDIT OBSERVATIONS",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(0);
			cell.setColspan(2);
			cell.setBorder(0);
			table.addCell(cell);
			cell=null;
			
			String audit_type = "";
			strQuery = SQLParser.getSqlQuery("selallauditobservation^"+strAppno);
			if (rs != null) {
				rs.close();
			}
			String strInter="",strCon="",strRbi="",strSt="",strStock="";
			
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				
				audit_type = correctNull((String) rs.getString("adv_audittype"));
				if (audit_type.equalsIgnoreCase("1")) {
					strInter=correctNull(rs.getString("adv_dateaudited"));
				}
				if (audit_type.equalsIgnoreCase("2")) {
					strCon=correctNull(rs.getString("adv_dateaudited"));
				}
				if (audit_type.equalsIgnoreCase("3")) {
					strRbi=correctNull(rs.getString("adv_dateaudited"));
				}
				if (audit_type.equalsIgnoreCase("4")) {
					strSt=correctNull(rs.getString("adv_dateaudited"));
				}
				if (audit_type.equalsIgnoreCase("5")) {
					strStock=correctNull(rs.getString("adv_dateaudited"));
				}
			}
//			internal audit
				cell=new Cell(new Phrase("22.1.",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(0);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("Internal Audit"+" as on "+strInter,ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(0);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(0);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(0);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("Audit Remark",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(1);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("Branch Reply",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(1);
				table.addCell(cell);
				cell=null;
			
			strQuery = SQLParser.getSqlQuery("selallauditobservation^"+strAppno);
			if (rs != null) {
				rs.close();
			}
			boolean inter=true;
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				audit_type = correctNull((String) rs.getString("adv_audittype"));
				if (audit_type.equalsIgnoreCase("1")) {
					inter=false;
				cell=new Cell(new Phrase(" ",ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase(correctNull(rs.getString("adv_auditorsobservations")),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase(correctNull(rs.getString("adv_branchcomments")),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				table.addCell(cell);
				cell=null;
				}
			}
			
			if(inter)
			{
				cell=new Cell(new Phrase(" ",ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("N.A",ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(1);
				cell.setColspan(2);
				table.addCell(cell);
				cell=null;
			}
				
//         concurrent audit			
			cell=new Cell(new Phrase("22.2.",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(0);
			cell.setBorder(0);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("Concurrent Audit"+" as on "+strCon,ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(0);
			cell.setBorder(0);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(0);
			cell.setBorder(0);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(0);
			cell.setBorder(0);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("Audit Remark",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(1);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("Branch Reply",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(1);
			table.addCell(cell);
			cell=null;
		
		strQuery = SQLParser.getSqlQuery("selallauditobservation^"+strAppno);
		if (rs != null) {
			rs.close();
		}
		boolean con =true;
		rs = DBUtils.executeQuery(strQuery);
		while (rs.next()) {
			audit_type = correctNull((String) rs.getString("adv_audittype"));
			if (audit_type.equalsIgnoreCase("2")) {
				con=false;
			cell=new Cell(new Phrase(" ",ReportConstants.REPORT_FONT_NORMAL));
			cell.setHorizontalAlignment(0);
			cell.setBorder(0);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase(correctNull(rs.getString("adv_auditorsobservations")),ReportConstants.REPORT_FONT_NORMAL));
			cell.setHorizontalAlignment(0);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase(correctNull(rs.getString("adv_branchcomments")),ReportConstants.REPORT_FONT_NORMAL));
			cell.setHorizontalAlignment(0);
			table.addCell(cell);
			cell=null;
			}
		}
		
		if(con)
		{
			cell=new Cell(new Phrase(" ",ReportConstants.REPORT_FONT_NORMAL));
			cell.setHorizontalAlignment(0);
			cell.setBorder(0);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("N.A",ReportConstants.REPORT_FONT_NORMAL));
			cell.setHorizontalAlignment(1);
			cell.setColspan(2);
			table.addCell(cell);
			cell=null;
		}
		
		
		cell=new Cell(new Phrase("22.3.",ReportConstants.REPORT_FONT_BOLD));
		cell.setHorizontalAlignment(0);
		cell.setBorder(0);
		table.addCell(cell);
		cell=null;
		
		cell=new Cell(new Phrase("Statutory Audit"+" as on "+strSt,ReportConstants.REPORT_FONT_BOLD));
		cell.setHorizontalAlignment(0);
		cell.setBorder(0);
		table.addCell(cell);
		cell=null;
		
		cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
		cell.setHorizontalAlignment(0);
		cell.setBorder(0);
		table.addCell(cell);
		cell=null;
		
		cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
		cell.setHorizontalAlignment(0);
		cell.setBorder(0);
		table.addCell(cell);
		cell=null;
		
		cell=new Cell(new Phrase("Audit Remark",ReportConstants.REPORT_FONT_BOLD));
		cell.setHorizontalAlignment(1);
		table.addCell(cell);
		cell=null;
		
		cell=new Cell(new Phrase("Branch Reply",ReportConstants.REPORT_FONT_BOLD));
		cell.setHorizontalAlignment(1);
		table.addCell(cell);
		cell=null;

	strQuery = SQLParser.getSqlQuery("selallauditobservation^"+strAppno);
	if (rs != null) {
		rs.close();
	}
	boolean staud=true;
	rs = DBUtils.executeQuery(strQuery);
	while (rs.next()) {
		audit_type = correctNull((String) rs.getString("adv_audittype"));
		if (audit_type.equalsIgnoreCase("4")) {
		staud=false;
		cell=new Cell(new Phrase(" ",ReportConstants.REPORT_FONT_NORMAL));
		cell.setHorizontalAlignment(0);
		cell.setBorder(0);
		table.addCell(cell);
		cell=null;
		
		cell=new Cell(new Phrase(correctNull(rs.getString("adv_auditorsobservations")),ReportConstants.REPORT_FONT_NORMAL));
		cell.setHorizontalAlignment(0);
		table.addCell(cell);
		cell=null;
		
		cell=new Cell(new Phrase(correctNull(rs.getString("adv_branchcomments")),ReportConstants.REPORT_FONT_NORMAL));
		cell.setHorizontalAlignment(0);
		table.addCell(cell);
		cell=null;
		}
	}

	if(staud)
	{
		cell=new Cell(new Phrase(" ",ReportConstants.REPORT_FONT_NORMAL));
		cell.setHorizontalAlignment(0);
		cell.setBorder(0);
		table.addCell(cell);
		cell=null;
		
		cell=new Cell(new Phrase("N.A",ReportConstants.REPORT_FONT_NORMAL));
		cell.setHorizontalAlignment(1);
		cell.setColspan(2);
		table.addCell(cell);
		cell=null;
	}

		
		//rbi
		cell=new Cell(new Phrase("22.4.",ReportConstants.REPORT_FONT_BOLD));
		cell.setHorizontalAlignment(0);
		cell.setBorder(0);
		table.addCell(cell);
		cell=null;
		
		cell=new Cell(new Phrase("RBI Inspection"+" as on "+strRbi,ReportConstants.REPORT_FONT_BOLD));
		cell.setHorizontalAlignment(0);
		cell.setBorder(0);
		table.addCell(cell);
		cell=null;
		
		cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
		cell.setHorizontalAlignment(0);
		cell.setBorder(0);
		table.addCell(cell);
		cell=null;
		
		cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
		cell.setHorizontalAlignment(0);
		cell.setBorder(0);
		table.addCell(cell);
		cell=null;
		
		cell=new Cell(new Phrase("Audit Remark",ReportConstants.REPORT_FONT_BOLD));
		cell.setHorizontalAlignment(1);
		table.addCell(cell);
		cell=null;
		
		cell=new Cell(new Phrase("Branch Reply",ReportConstants.REPORT_FONT_BOLD));
		cell.setHorizontalAlignment(1);
		table.addCell(cell);
		cell=null;
	
	strQuery = SQLParser.getSqlQuery("selallauditobservation^"+strAppno);
	if (rs != null) {
		rs.close();
	}
	boolean rbi=true;
	rs = DBUtils.executeQuery(strQuery);
	while (rs.next()) {
		audit_type = correctNull((String) rs.getString("adv_audittype"));
		if (audit_type.equalsIgnoreCase("3")) {
		rbi=false;
		cell=new Cell(new Phrase(" ",ReportConstants.REPORT_FONT_NORMAL));
		cell.setHorizontalAlignment(0);
		cell.setBorder(0);
		table.addCell(cell);
		cell=null;
		
		cell=new Cell(new Phrase(correctNull(rs.getString("adv_auditorsobservations")),ReportConstants.REPORT_FONT_NORMAL));
		cell.setHorizontalAlignment(0);
		table.addCell(cell);
		cell=null;
		
		cell=new Cell(new Phrase(correctNull(rs.getString("adv_branchcomments")),ReportConstants.REPORT_FONT_NORMAL));
		cell.setHorizontalAlignment(0);
		table.addCell(cell);
		cell=null;
		}
	}
	if(rbi)
	{
		cell=new Cell(new Phrase(" ",ReportConstants.REPORT_FONT_NORMAL));
		cell.setHorizontalAlignment(0);
		cell.setBorder(0);
		table.addCell(cell);
		cell=null;
		
		cell=new Cell(new Phrase("N.A",ReportConstants.REPORT_FONT_NORMAL));
		cell.setHorizontalAlignment(1);
		cell.setColspan(2);
		table.addCell(cell);
		cell=null;
	}
cell=new Cell(new Phrase("22.5.",ReportConstants.REPORT_FONT_BOLD));
cell.setHorizontalAlignment(0);
cell.setBorder(0);
table.addCell(cell);
cell=null;

cell=new Cell(new Phrase("Stock Audit"+" as on "+strStock,ReportConstants.REPORT_FONT_BOLD));
cell.setHorizontalAlignment(0);
cell.setBorder(0);
table.addCell(cell);
cell=null;

cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
cell.setHorizontalAlignment(0);
cell.setBorder(0);
table.addCell(cell);
cell=null;

cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
cell.setHorizontalAlignment(0);
cell.setBorder(0);
table.addCell(cell);
cell=null;

cell=new Cell(new Phrase("Audit Remark",ReportConstants.REPORT_FONT_BOLD));
cell.setHorizontalAlignment(1);
table.addCell(cell);
cell=null;

cell=new Cell(new Phrase("Branch Reply",ReportConstants.REPORT_FONT_BOLD));
cell.setHorizontalAlignment(1);
table.addCell(cell);
cell=null;

strQuery = SQLParser.getSqlQuery("selallauditobservation^"+strAppno);
if (rs != null) {
rs.close();
}
boolean stock =true;
rs = DBUtils.executeQuery(strQuery);
while (rs.next()) {
audit_type = correctNull((String) rs.getString("adv_audittype"));
if (audit_type.equalsIgnoreCase("5")) {
	stock=false;
cell=new Cell(new Phrase(" ",ReportConstants.REPORT_FONT_NORMAL));
cell.setHorizontalAlignment(0);
cell.setBorder(0);
table.addCell(cell);
cell=null;

cell=new Cell(new Phrase(correctNull(rs.getString("adv_auditorsobservations")),ReportConstants.REPORT_FONT_NORMAL));
cell.setHorizontalAlignment(0);
table.addCell(cell);
cell=null;

cell=new Cell(new Phrase(correctNull(rs.getString("adv_branchcomments")),ReportConstants.REPORT_FONT_NORMAL));
cell.setHorizontalAlignment(0);
table.addCell(cell);
cell=null;
}
}
if(stock)
{
	cell=new Cell(new Phrase(" ",ReportConstants.REPORT_FONT_NORMAL));
	cell.setHorizontalAlignment(0);
	cell.setBorder(0);
	table.addCell(cell);
	cell=null;
	
	cell=new Cell(new Phrase("N.A",ReportConstants.REPORT_FONT_NORMAL));
	cell.setHorizontalAlignment(1);
	cell.setColspan(2);
	table.addCell(cell);
	cell=null;
}
			document.add(table);
			table=null;
			
			table=new Table(3);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f); 
			table.setWidths(wid21);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			strQuery = SQLParser.getSqlQuery("execsel_credit^" + strAppno);
			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			
			if(rs.next())
			{
			cell=new Cell(new Phrase("23.",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(0);
			cell.setBorder(0);
			cell.setColspan(1);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("ANY IRREGULAR FEATURE OBSERVED IN THE MONITORING REPORT",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(0);
			cell.setBorder(0);
			cell.setColspan(2);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase(correctNull(rs.getString("exec_summ_manager")),ReportConstants.REPORT_FONT_NORMAL));
			cell.setHorizontalAlignment(0);
			cell.setBorder(0);
			cell.setColspan(3);
			table.addCell(cell);
			cell=null;
			}
			else
			{
				cell=new Cell(new Phrase("23.",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(0);
				cell.setBorder(0);
				cell.setColspan(1);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("ANY IRREGULAR FEATURE OBSERVED IN THE MONITORING REPORT",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(0);
				cell.setBorder(0);
				cell.setColspan(2);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(0);
				cell.setBorder(0);
				cell.setColspan(3);
				table.addCell(cell);
				cell=null;
			}
			document.add(table);
			table=null;
			
			int[] widhead ={7,83,10};
			table=new Table(3);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f); 
			table.setWidths(widhead);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			cell=new Cell(new Phrase("24.",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(0);
			cell.setBorder(0);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("EXPOSURE DETAILS FROM OUR BANK",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(0);
			cell.setBorder(0);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("("+ApplicationParams.getCurrency()+"In "+strProposalvalue+")",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(2);
			cell.setBorder(0);
			table.addCell(cell);
			cell=null;
			
			document.add(table);
			table=null;
			
			//24
			String strason="";
			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("get_FacilityData^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				strason=correctNull(rs.getString("facility_osason"));
			}
			int[] wid24={7,20,10,13,10,15,10,15};
			table=new Table(8);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f); 
			table.setWidths(wid24);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(1);
			cell.setBorder(0);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("Nature of Facility",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(1);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("Limits Existing",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(1);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("Limits Recommended",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(1);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("D.P.",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(1);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("O/S as On "+strason,ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(1);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("Value of Securities ",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(1);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("Irregularities, if any",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(1);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(1);
			cell.setBorder(0);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("A] FUND BASED LIMITS",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(0);
			cell.setColspan(7);
			table.addCell(cell);
			cell=null;
			
			if (rs != null) {
				rs.close();
			}
			boolean wcfund=true,wcnonfund=true,tlfund=true;
			double dblext=0,dblprop=0,dbldp=0,dblos=0,dblsec=0;
			strQuery = SQLParser.getSqlQuery("com_wc_funded^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				wcfund=false;
				
				cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(1);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase(correctNull(rs.getString("facility_catdesc")),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("facility_existing")))),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(2);
				table.addCell(cell);
				cell=null;
				dblext=dblext+Double.parseDouble(Helper.correctDouble(rs.getString("facility_existing")));
				cell=new Cell(new Phrase(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("facility_proposed")))),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(2);
				table.addCell(cell);
				cell=null;
				dblprop=dblprop+Double.parseDouble(Helper.correctDouble(rs.getString("facility_proposed")));
				cell=new Cell(new Phrase(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("facility_dp")))),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(2);
				table.addCell(cell);
				cell=null;
				dbldp=dbldp+Double.parseDouble(Helper.correctDouble(rs.getString("facility_dp")));
				cell=new Cell(new Phrase(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("facility_outstanding")))),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(2);
				table.addCell(cell);
				cell=null;
				dblos=dblos+Double.parseDouble(Helper.correctDouble(rs.getString("facility_outstanding")));
				cell=new Cell(new Phrase(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("security_value")))),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(2);
				table.addCell(cell);
				cell=null;
				dblsec=dblsec+Double.parseDouble(Helper.correctDouble(rs.getString("security_value")));
				cell=new Cell(new Phrase(correctNull(rs.getString("facility_desc")),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				table.addCell(cell);
				cell=null;
			}
			if(wcfund)
			{
				cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(1);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(2);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase(" ",ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(2);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase(" ",ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(2);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase(" ",ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(2);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase(" ",ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(2);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase(" ",ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(2);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase(".",ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(2);
				table.addCell(cell);
				cell=null;
			}
			
			cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(1);
			cell.setBorder(0);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase(">>Sub-Limit",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(0);
			cell.setColspan(7);
			table.addCell(cell);
			cell=null;
			if(rs!=null)
				rs.close();
			
			strQuery = SQLParser.getSqlQuery("com_facility_pdf_select^"+strAppno+"^3");
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
			
				cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(1);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase(correctNull(rs.getString("facility_catdesc")),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("facility_existing")))),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(2);
				table.addCell(cell);
				cell=null;
				dblext=dblext+Double.parseDouble(Helper.correctDouble(rs.getString("facility_existing")));
				cell=new Cell(new Phrase(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("facility_proposed")))),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(2);
				table.addCell(cell);
				cell=null;
				dblprop=dblprop+Double.parseDouble(Helper.correctDouble(rs.getString("facility_proposed")));
				cell=new Cell(new Phrase(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("facility_dp")))),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(2);
				table.addCell(cell);
				cell=null;
				dbldp=dbldp+Double.parseDouble(Helper.correctDouble(rs.getString("facility_dp")));
				cell=new Cell(new Phrase(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("facility_outstanding")))),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(2);
				table.addCell(cell);
				cell=null;
				dblos=dblos+Double.parseDouble(Helper.correctDouble(rs.getString("facility_outstanding")));
				cell=new Cell(new Phrase(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("security_value")))),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(2);
				table.addCell(cell);
				cell=null;
				dblsec=dblsec+Double.parseDouble(Helper.correctDouble(rs.getString("security_value")));
				cell=new Cell(new Phrase(correctNull(rs.getString("facility_desc")),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				table.addCell(cell);
				cell=null;
				
			}
			
			cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(1);
			cell.setBorder(0);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("Sub-total [A]",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(2);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase(nf.format(dblext),ReportConstants.REPORT_FONT_NORMAL));
			cell.setHorizontalAlignment(2);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase(nf.format(dblprop),ReportConstants.REPORT_FONT_NORMAL));
			cell.setHorizontalAlignment(2);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase(nf.format(dbldp),ReportConstants.REPORT_FONT_NORMAL));
			cell.setHorizontalAlignment(2);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase(nf.format(dblos),ReportConstants.REPORT_FONT_NORMAL));
			cell.setHorizontalAlignment(2);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase(nf.format(dblsec),ReportConstants.REPORT_FONT_NORMAL));
			cell.setHorizontalAlignment(2);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_NORMAL));
			cell.setHorizontalAlignment(2);
			table.addCell(cell);
			cell=null;
			double dblext2=0,dblprop2=0,dbldp2=0,dblos2=0,dblsec2=0;
			
			cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(1);
			cell.setBorder(0);
			table.addCell(cell);
			cell=null;
			cell=new Cell(new Phrase("B] NONFUND BASED LIMITS",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(0);
			cell.setColspan(7);
			table.addCell(cell);
			cell=null;
			
			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("com_wc_nonfunded^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				wcnonfund=false;
				cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(1);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				cell=new Cell(new Phrase(correctNull(rs.getString("facility_catdesc")),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				table.addCell(cell);
				cell=null;
				cell=new Cell(new Phrase(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("facility_existing")))),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(2);
				table.addCell(cell);
				cell=null;
				dblext2=dblext2+Double.parseDouble(Helper.correctDouble(rs.getString("facility_existing")));
				cell=new Cell(new Phrase(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("facility_proposed")))),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(2);
				table.addCell(cell);
				cell=null;
				dblprop2=dblprop2+Double.parseDouble(Helper.correctDouble(rs.getString("facility_proposed")));
				cell=new Cell(new Phrase(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("facility_dp")))),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(2);
				table.addCell(cell);
				cell=null;
				dbldp2=dbldp2+Double.parseDouble(Helper.correctDouble(rs.getString("facility_dp")));
				cell=new Cell(new Phrase(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("facility_outstanding")))),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(2);
				table.addCell(cell);
				cell=null;
				dblos2=dblos2+Double.parseDouble(Helper.correctDouble(rs.getString("facility_outstanding")));
				cell=new Cell(new Phrase(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("security_value")))),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(2);
				table.addCell(cell);
				cell=null;
				dblsec2=dblsec2+Double.parseDouble(Helper.correctDouble(rs.getString("security_value")));
				cell=new Cell(new Phrase(correctNull(rs.getString("facility_desc")),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				table.addCell(cell);
				cell=null;
			}
			if(wcnonfund)
			{
					cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
					cell.setHorizontalAlignment(1);
					cell.setBorder(0);
					table.addCell(cell);
					cell=null;
					cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(2);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(2);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(2);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(2);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(2);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(2);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase(".",ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(2);
					table.addCell(cell);
					cell=null;
			}
			cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(1);
			cell.setBorder(0);
			table.addCell(cell);
			cell=null;
			cell=new Cell(new Phrase(">>Sub-Limit",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(0);
			cell.setColspan(7);
			table.addCell(cell);
			cell=null;
			if(rs!=null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("com_facility_pdf_select^" + strAppno+ "^4");
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(1);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				cell=new Cell(new Phrase(correctNull(rs.getString("facility_catdesc")),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				table.addCell(cell);
				cell=null;
				cell=new Cell(new Phrase(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("facility_existing")))),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(2);
				table.addCell(cell);
				cell=null;
				dblext2=dblext2+Double.parseDouble(Helper.correctDouble(rs.getString("facility_existing")));
				cell=new Cell(new Phrase(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("facility_proposed")))),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(2);
				table.addCell(cell);
				cell=null;
				dblprop2=dblprop2+Double.parseDouble(Helper.correctDouble(rs.getString("facility_proposed")));
				cell=new Cell(new Phrase(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("facility_dp")))),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(2);
				table.addCell(cell);
				cell=null;
				dbldp2=dbldp2+Double.parseDouble(Helper.correctDouble(rs.getString("facility_dp")));
				cell=new Cell(new Phrase(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("facility_outstanding")))),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(2);
				table.addCell(cell);
				cell=null;
				dblos2=dblos2+Double.parseDouble(Helper.correctDouble(rs.getString("facility_outstanding")));
				cell=new Cell(new Phrase(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("security_value")))),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(2);
				table.addCell(cell);
				cell=null;
				dblsec2=dblsec2+Double.parseDouble(Helper.correctDouble(rs.getString("security_value")));
				cell=new Cell(new Phrase(correctNull(rs.getString("facility_desc")),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				table.addCell(cell);
				cell=null;
			}
			
			cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(1);
			cell.setBorder(0);
			table.addCell(cell);
			cell=null;
			cell=new Cell(new Phrase("Sub-total [B]",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(2);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase(nf.format(dblext2),ReportConstants.REPORT_FONT_NORMAL));
			cell.setHorizontalAlignment(2);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase(nf.format(dblprop2),ReportConstants.REPORT_FONT_NORMAL));
			cell.setHorizontalAlignment(2);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase(nf.format(dbldp2),ReportConstants.REPORT_FONT_NORMAL));
			cell.setHorizontalAlignment(2);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase(nf.format(dblos2),ReportConstants.REPORT_FONT_NORMAL));
			cell.setHorizontalAlignment(2);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase(nf.format(dblsec2),ReportConstants.REPORT_FONT_NORMAL));
			cell.setHorizontalAlignment(2);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_NORMAL));
			cell.setHorizontalAlignment(2);
			table.addCell(cell);
			cell=null;
			double dblext3=0,dblprop3=0,dbldp3=0,dblos3=0,dblsec3=0;
			cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(1);
			cell.setBorder(0);
			table.addCell(cell);
			cell=null;
			cell=new Cell(new Phrase("C] TERM LOAN",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(0);
			cell.setColspan(7);
			table.addCell(cell);
			cell=null;
			
			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("com_tl_funded_nonfunded^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				tlfund=false;
				cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(1);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				cell=new Cell(new Phrase(correctNull(rs.getString("facility_catdesc")),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(2);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("facility_existing")))),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(2);
				table.addCell(cell);
				cell=null;
				dblext3=dblext3+Double.parseDouble(Helper.correctDouble(rs.getString("facility_existing")));
				cell=new Cell(new Phrase(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("facility_proposed")))),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(2);
				table.addCell(cell);
				cell=null;
				dblprop3=dblprop3+Double.parseDouble(Helper.correctDouble(rs.getString("facility_proposed")));
				cell=new Cell(new Phrase(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("facility_dp")))),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(2);
				table.addCell(cell);
				cell=null;
				dbldp3=dbldp3+Double.parseDouble(Helper.correctDouble(rs.getString("facility_dp")));
				cell=new Cell(new Phrase(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("facility_outstanding")))),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(2);
				table.addCell(cell);
				cell=null;
				dblos3=dblos3+Double.parseDouble(Helper.correctDouble(rs.getString("facility_outstanding")));
				cell=new Cell(new Phrase(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("security_value")))),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(2);
				table.addCell(cell);
				cell=null;
				dblsec3=dblsec3+Double.parseDouble(Helper.correctDouble(rs.getString("security_value")));
				cell=new Cell(new Phrase(correctNull(rs.getString("facility_desc")),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				table.addCell(cell);
				cell=null;
			}
			
			if(tlfund)
			{
					cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
					cell.setHorizontalAlignment(1);
					cell.setBorder(0);
					table.addCell(cell);
					cell=null;
					cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(2);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(2);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(2);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(2);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(2);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(2);
					table.addCell(cell);
					cell=null;
					
					cell=new Cell(new Phrase(".",ReportConstants.REPORT_FONT_NORMAL));
					cell.setHorizontalAlignment(2);
					table.addCell(cell);
					cell=null;
			}
			cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(1);
			cell.setBorder(0);
			table.addCell(cell);
			cell=null;
			cell=new Cell(new Phrase(">>Sub-Limit",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(0);
			cell.setColspan(7);
			table.addCell(cell);
			cell=null;
			if(rs!=null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("com_facility_pdfTL_select^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
				cell.setHorizontalAlignment(1);
				cell.setBorder(0);
				table.addCell(cell);
				cell=null;
				cell=new Cell(new Phrase(correctNull(rs.getString("facility_catdesc")),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(2);
				table.addCell(cell);
				cell=null;
				
				cell=new Cell(new Phrase(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("facility_existing")))),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(2);
				table.addCell(cell);
				cell=null;
				dblext3=dblext3+Double.parseDouble(Helper.correctDouble(rs.getString("facility_existing")));
				cell=new Cell(new Phrase(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("facility_proposed")))),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(2);
				table.addCell(cell);
				cell=null;
				dblprop3=dblprop3+Double.parseDouble(Helper.correctDouble(rs.getString("facility_proposed")));
				cell=new Cell(new Phrase(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("facility_dp")))),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(2);
				table.addCell(cell);
				cell=null;
				dbldp3=dbldp3+Double.parseDouble(Helper.correctDouble(rs.getString("facility_dp")));
				cell=new Cell(new Phrase(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("facility_outstanding")))),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(2);
				table.addCell(cell);
				cell=null;
				dblos3=dblos3+Double.parseDouble(Helper.correctDouble(rs.getString("facility_outstanding")));
				cell=new Cell(new Phrase(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("security_value")))),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(2);
				table.addCell(cell);
				cell=null;
				dblsec3=dblsec3+Double.parseDouble(Helper.correctDouble(rs.getString("security_value")));
				cell=new Cell(new Phrase(correctNull(rs.getString("facility_desc")),ReportConstants.REPORT_FONT_NORMAL));
				cell.setHorizontalAlignment(0);
				table.addCell(cell);
				cell=null;
				
			}
			cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(1);
			cell.setBorder(0);
			table.addCell(cell);
			cell=null;
			cell=new Cell(new Phrase("Sub-total [C]",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(2);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase(nf.format(dblext3),ReportConstants.REPORT_FONT_NORMAL));
			cell.setHorizontalAlignment(2);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase(nf.format(dblprop3),ReportConstants.REPORT_FONT_NORMAL));
			cell.setHorizontalAlignment(2);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase(nf.format(dbldp3),ReportConstants.REPORT_FONT_NORMAL));
			cell.setHorizontalAlignment(2);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase(nf.format(dblos3),ReportConstants.REPORT_FONT_NORMAL));
			cell.setHorizontalAlignment(2);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase(nf.format(dblsec3),ReportConstants.REPORT_FONT_NORMAL));
			cell.setHorizontalAlignment(2);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_NORMAL));
			cell.setHorizontalAlignment(2);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(1);
			cell.setBorder(0);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("TOTAL [A+B+C]",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(1);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase(nf.format(dblext+dblext2+dblext3),ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(2);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase(nf.format(dblprop+dblprop2+dblprop3),ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(2);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase(nf.format(dbldp+dbldp2+dbldp3),ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(2);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase(nf.format(dblos+dblos2+dblos3),ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(2);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase(nf.format(dblsec+dblsec2+dblsec3),ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(2);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_NORMAL));
			cell.setHorizontalAlignment(2);
			table.addCell(cell);
			cell=null;
			document.add(table);
			table=null;
			
			
			table=new Table(3);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f); 
			table.setWidths(wid22);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			cell=new Cell(new Phrase("24.1.",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(0);
			cell.setBorder(0);
			table.addCell(cell);
			cell=null;
			
			cell=new Cell(new Phrase("DETAILS OF EXCESS ALLOWED DURING THE YEAR ",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(0);
			cell.setBorder(0);
			cell.setColspan(2);
			table.addCell(cell);
			cell=null;
			
			document.add(table);
			table=null;
			
			int [] widsub={10,45,45};
			table=new Table(3);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(60.0f); 
			table.setWidths(widsub);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			table.setAlignment(0);
			cell=new Cell(new Phrase("",ReportConstants.REPORT_FONT_BOLD));
			cell.setHorizontalAlignment(0);
			cell.setBorder(0);
			table.addCell(cell);
			cell=null;
			table.addCell(rm.ReportCellBold(2,"("+ApplicationParams.getCurrency()+"In "+strProposalvalue+")",2));
			if(rs!=null)
				rs.close();
				
			table.addCell(rm.ReportCell(0,"",1,0.0f));
			table.addCell(rm.ReportCellBold(1,"No. of occasions excesses allowed",1));
			table.addCell(rm.ReportCellBold(1,"Maximum Excess Allowed",1));
			table.addCell(rm.ReportCell(0,"",1,0.0f));
			strQuery = SQLParser.getSqlQuery("execsel_DETAILEXCESS^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				table.addCell(rm.ReportCell(1,correctNull(rs.getString("EXEC_NOEXCESS")),1));
				table.addCell(rm.ReportCell(1,correctNull(rs.getString("EXEC_MAXEXCESS")),1));
				
			}
			else
			{
				table.addCell(rm.ReportCell(1,"",1));
				table.addCell(rm.ReportCell(1,".",1));
			}
			document.add(table);
			table=null;
			
			table=new Table(3);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f); 
			table.setWidths(wid22);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			table.addCell(rm.ReportCellBold(0,"24.2.",1,0.0f));
			table.addCell(rm.ReportCellBold(0,"OTHER EXPOSURE, IF ANY,INCLUDING INVESTMENTS",1,0.0f));
			if(rs!=null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("execsel_DETAILEXCESS^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				table.addCell(rm.ReportCell(0,correctNull(rs.getString("EXEC_OTHEXP")),1,0.0f));
				table.addCell(rm.ReportCellBold(0,"24.3.",1,0.0f));
				table.addCell(rm.ReportCellBold(0,"OTHER LIABILITIES OF DIRECTORS / PARTNERS [in their individual capacity]",1,0.0f));
				table.addCell(rm.ReportCell(0,correctNull(rs.getString("EXEC_OTHLIAB")),1,0.0f));
			}
			else
			{
				table.addCell(rm.ReportCell(0,"Nil",1,1.0f));
				table.addCell(rm.ReportCellBold(0,"24.3.",1,0.0f));
				table.addCell(rm.ReportCellBold(0,"OTHER LIABILITIES OF DIRECTORS / PARTNERS [in their individual capacity]",1,0.0f));
				table.addCell(rm.ReportCell(0,"Nil",1,0.0f));
			}
			document.add(table);
			table=null;
			
			int[] wid25={7,28,10,10,10,10,25};
			table=new Table(7);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f); 
			table.setWidths(wid25);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			table.addCell(rm.ReportCellBold(0,"25.",1,0.0f));
			table.addCell(rm.ReportCellBold(0,"EXPOSURE DETAILS FROM BANKING SYSTEM (Incl. Our Bank)",5,0.0f));
			table.addCell(rm.ReportCellBold(2,"("+ApplicationParams.getCurrency()+"In"+strProposalvalue+")",1,0.0f));
			
			table.addCell(rm.ReportCellBold(0,"",1,0.0f));
			table.addCell(rm.ReportCellBold(1,"Name of the Bank",1,2));
			table.addCell(rm.ReportCellBold(1,"Non-Fund Based",2));
			table.addCell(rm.ReportCellBold(1,"Fund Based",2));
			table.addCell(rm.ReportCellBold(1,"Conduct of the Account",1,2));
			table.addCell(rm.ReportCellBold(0,"",1,0.0f));
			table.addCell(rm.ReportCellBold(1,"%Share",1));
			table.addCell(rm.ReportCellBold(1,"Amt.",1));
			table.addCell(rm.ReportCellBold(1,"%Share",1));
			table.addCell(rm.ReportCellBold(1,"Amt.",1));

		ArrayList arrBankArrangement = new ArrayList();
		ArrayList arrBankArrangementFI=new ArrayList();
		ArrayList arrNonBankArrange=new ArrayList();
		ArrayList arrBank = new ArrayList();
		arrVec1=new ArrayList();
			String loan_type = "";
			String bank_name = "";
			double TOT_FE = 0.00;
			double TOT_NFE = 0.00;
			double LIMIT_FE_CON = 0.00;
			double LIMIT_NFE_CON = 0.00;
			double LIMIT_FE_NONCON = 0.00;
			double LIMIT_NFE_NONCON = 0.00;
			double SHARE_FE_CON = 0.00;
			double SHARE_NFE_CON = 0.00;
			String strconductofacctconsort=null;
			String strconductofacctnoncort=null;

			if (rs != null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("comtotalsel^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				TOT_FE=rs.getDouble("com_totwcfundexist");
				TOT_NFE=rs.getDouble("com_totwcnonfundexist");
			}

			strQuery = SQLParser.getSqlQuery("com_banksel^" + strAppno);

			if (rs != null)
				rs.close();

			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				arrBank.add(correctNull(rs.getString("bank_name")));
			}

			for (j = 0; j < arrBank.size(); j++) {
				bank_name = (String) arrBank.get(j);
							
				strconductofacctconsort="";
				strconductofacctnoncort="";
				strQuery = SQLParser.getSqlQuery("com_banking_consortiumsel^" + strAppno
						+ "^" + bank_name+"^Y");

				if (rs != null)
					rs.close();
				
				SHARE_FE_CON=0.00;
				SHARE_NFE_CON=0.00;
				LIMIT_NFE_CON=0.0;
				LIMIT_FE_CON=0.0;
				LIMIT_FE_NONCON=0.0;
				LIMIT_NFE_NONCON=0.0;
				boolean consortiumflag=false;
				boolean nonconsortiumflag=false;
				
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					if(correctNull(rs.getString("combk_consortium")).equals("Y"))
					{
						LIMIT_FE_CON=LIMIT_FE_CON+rs.getDouble("combk_lmtfundexist");
						LIMIT_NFE_CON=LIMIT_NFE_CON+rs.getDouble("combk_lmtnonfundexist");
						
						if(!correctNull(rs.getString("combk_overdue")).equals(""))
							strconductofacctconsort=correctNull(rs.getString("combk_overdue"));
						
						if (TOT_FE != 0.00) {
							SHARE_FE_CON = (LIMIT_FE_CON / TOT_FE) * 100;
						}
						if (TOT_NFE != 0.00) {
							SHARE_NFE_CON = (LIMIT_NFE_CON / TOT_NFE) * 100;
						}
						consortiumflag=true;
					}
					else if(correctNull(rs.getString("combk_selbank")).equals("FI"))
					{
						arrVec1 = new ArrayList();
						arrVec1.add(bank_name);
						arrVec1.add(Helper.formatDoubleValue(rs.getDouble("combk_lmtfundexist")));
						arrVec1.add(Helper.formatDoubleValue(rs.getDouble("combk_lmtnonfundexist")));
						arrVec1.add(correctNull(rs.getString("combk_overdue")));
						arrVec1.add(correctNull(rs.getString("combk_excess")));
						arrBankArrangementFI.add(arrVec1);
					}
					else
					{
						LIMIT_FE_NONCON=LIMIT_FE_NONCON+rs.getDouble("combk_lmtfundexist");
						LIMIT_NFE_NONCON=LIMIT_NFE_NONCON+rs.getDouble("combk_lmtnonfundexist");
						
						if(!correctNull(rs.getString("combk_overdue")).equals(""))
							strconductofacctnoncort=correctNull(rs.getString("combk_overdue"));
						
						nonconsortiumflag=true;
						
					}
					
				}
				 
				if(consortiumflag)
				{
					arrVec1 = new ArrayList();
					arrVec1.add(bank_name);
					arrVec1.add(Helper.formatDoubleValue(SHARE_NFE_CON));
					arrVec1.add(Helper.formatDoubleValue(LIMIT_NFE_CON));
					arrVec1.add(Helper.formatDoubleValue(SHARE_FE_CON));
					arrVec1.add(Helper.formatDoubleValue(LIMIT_FE_CON));
					arrVec1.add(strconductofacctconsort);
					arrBankArrangement.add(arrVec1);
				}
				if(nonconsortiumflag)
				{
					arrVec1 = new ArrayList();
					arrVec1.add(bank_name);
					arrVec1.add("--");
					arrVec1.add(Helper.formatDoubleValue(LIMIT_NFE_NONCON));
					arrVec1.add("--");
					arrVec1.add(Helper.formatDoubleValue(LIMIT_FE_NONCON));
					arrVec1.add(strconductofacctnoncort);
					arrNonBankArrange.add(arrVec1);
				}
			}
			boolean conflag=true;
		arr3 =new ArrayList();			
    	if (arrBankArrangement != null && arrBankArrangement.size() != 0) {
    		conflag=false;
    		table.addCell(rm.ReportCell(0,"",1,0.0f));
    		table.addCell(rm.ReportCell(0,"Under Consortium",6));
    		
             for (int i = 0; i < arrBankArrangement.size(); i++) {
			arr3 = new ArrayList();
			arr3 = (ArrayList) arrBankArrangement.get(i);
			table.addCell(rm.ReportCell(0,"",1,0.0f));
			table.addCell(rm.ReportCell(0,correctNull((String)arr3.get(0)),1));
			table.addCell(rm.ReportCell(2,correctNull((String)arr3.get(1)),1));
			table.addCell(rm.ReportCell(2,correctNull((String)arr3.get(2)),1));
			table.addCell(rm.ReportCell(2,correctNull((String)arr3.get(3)),1));
			table.addCell(rm.ReportCell(2,correctNull((String)arr3.get(4)),1));
			table.addCell(rm.ReportCell(0,correctNull((String)arr3.get(5)),1));
        }
	}
    	arr4 =new ArrayList();			
    	if (arrNonBankArrange != null && arrNonBankArrange.size() != 0) {
    		conflag=false;
    		table.addCell(rm.ReportCell(0,"",1,0.0f));
    		table.addCell(rm.ReportCell(0,"Under Non Consortium",6));
    		
             for (int i = 0; i < arrNonBankArrange.size(); i++) {
			arr4 = new ArrayList();
			arr4 = (ArrayList) arrNonBankArrange.get(i);
			table.addCell(rm.ReportCell(0,"",1,0.0f));
			table.addCell(rm.ReportCell(0,correctNull((String)arr4.get(0)),1));
			table.addCell(rm.ReportCell(2,correctNull((String)arr4.get(1)),1));
			table.addCell(rm.ReportCell(2,correctNull((String)arr4.get(2)),1));
			table.addCell(rm.ReportCell(2,correctNull((String)arr4.get(3)),1));
			table.addCell(rm.ReportCell(2,correctNull((String)arr4.get(4)),1));
			table.addCell(rm.ReportCell(0,correctNull((String)arr4.get(5)),1));
        }
	}
    	
    	if(conflag)
    	{
    		table.addCell(rm.ReportCell(0,"",1,0.0f));
			table.addCell(rm.ReportCell(0,"",1));
			table.addCell(rm.ReportCell(2,"",1));
			table.addCell(rm.ReportCell(2,"",1));
			table.addCell(rm.ReportCell(2,"",1));
			table.addCell(rm.ReportCell(2,"",1));
			table.addCell(rm.ReportCell(0,".",1));
    		
    	}
    	
			document.add(table);
			table=null;
			
			int [] setwid251={7,20,20,20,20,13};
			table=new Table(6);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f); 
			table.setWidths(setwid251);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			table.addCell(rm.ReportCellBold(0,"25.1.",1,0.0f));
			table.addCell(rm.ReportCellBold(0,"CONDUCT OF THE ACCOUNT AND EXPOSURE DETAILS FROM FINANCIAL INSTITUTIONS",4,0.0f));
			table.addCell(rm.ReportCellBold(2,"("+ApplicationParams.getCurrency()+"In "+strProposalvalue+")",1,0.0f));
			
			table.addCell(rm.ReportCellBold(0,"",1,0.0f));
			table.addCell(rm.ReportCellBold(1,"Name of the Bank",1,2));
			table.addCell(rm.ReportCellBold(1,"Amount",2));
			table.addCell(rm.ReportCellBold(1,"Remarks",1,2));
			table.addCell(rm.ReportCellBold(1,"Over Due if any.",1,2));
			
			table.addCell(rm.ReportCellBold(0,"",1,0.0f));
			table.addCell(rm.ReportCellBold(1,"Fund Based",1));
			table.addCell(rm.ReportCellBold(1,"Non-Fund Based",1));
			boolean fundflag=true;
			arr5 =new ArrayList();			
	             for (int i = 0; i < arrBankArrangementFI.size(); i++) {
	            	 fundflag=false;
				arr5 = new ArrayList();
				arr5 = (ArrayList) arrBankArrangementFI.get(i);
				table.addCell(rm.ReportCell(0,"",1,0.0f));
				table.addCell(rm.ReportCell(0,correctNull((String)arr5.get(0)),1));
				table.addCell(rm.ReportCell(2,correctNull((String)arr5.get(1)),1));
				table.addCell(rm.ReportCell(2,correctNull((String)arr5.get(2)),1));
				table.addCell(rm.ReportCell(0,correctNull((String)arr5.get(3)),1));
				table.addCell(rm.ReportCell(0,correctNull((String)arr5.get(4)),1));
	        }
	             if(fundflag)
	             {
	            	 table.addCell(rm.ReportCell(0,"",1,0.0f));
	 				table.addCell(rm.ReportCell(0,"",1));
	 				table.addCell(rm.ReportCell(2,"",1));
	 				table.addCell(rm.ReportCell(2,"",1));
	 				table.addCell(rm.ReportCell(0,"",1));
	 				table.addCell(rm.ReportCell(0,".",1)); 
	             }
			document.add(table);
			table=null;
			String strPrvfrom="";
			String strPrvto="";
			String strcurrfrom="";
			String strcurrto="";
			int [] widset252={7,21,18,18,18,18};
			table=new Table(6);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f); 
			table.setWidths(widset252);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			table.addCell(rm.ReportCellBold(0,"25.2.",1,0.0f));
			table.addCell(rm.ReportCellBold(0,"VALUE OF ACCOUNT",4,0.0f));
			table.addCell(rm.ReportCellBold(2,"("+ApplicationParams.getCurrency()+"In "+strProposalvalue+")",1,0.0f));
			
			strQuery = SQLParser.getSqlQuery("execsel_VALOFACCOUNT^" + strAppno);
			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				strPrvfrom=correctNull(rs.getString("EXEC_PFROM")).equals("")?"__/__/____":correctNull(rs.getString("EXEC_PFROM"));
				strPrvto=correctNull(rs.getString("EXEC_PTO")).equals("")?"__/__/____":correctNull(rs.getString("EXEC_PTO"));
				strcurrfrom=correctNull(rs.getString("EXEC_CFROM")).equals("")?"__/__/____":correctNull(rs.getString("EXEC_CFROM"));
				strcurrto=correctNull(rs.getString("EXEC_CTO")).equals("")?"__/__/____":correctNull(rs.getString("EXEC_CTO"));
				
				table.addCell(rm.ReportCell(0,"",1,0.0f));
				table.addCell(rm.ReportCell(1,"Advances",1));
				table.addCell(rm.ReportCell(1,"Previous Year\nFrom: "+strPrvfrom+"  To: "+strPrvto,2));
				table.addCell(rm.ReportCell(1,"Current Year\nFrom: "+strcurrfrom+"  To: "+strcurrto,2));
				
				table.addCell(rm.ReportCell(0,"",1,0.0f));
				table.addCell(rm.ReportCell(0,"- Interest Income",1));
				table.addCell(rm.ReportCell(2,nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("EXEC_PINTINC")))),2));
				table.addCell(rm.ReportCell(2,nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("EXEC_CINTINC")))),2));
				
				table.addCell(rm.ReportCell(0,"",1,0.0f));
				table.addCell(rm.ReportCell(0,"-Feebased Income",1));
				table.addCell(rm.ReportCell(2,nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("EXEC_PFEEINC")))),2));
				table.addCell(rm.ReportCell(2,nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("EXEC_CFEEINC")))),2));

				table.addCell(rm.ReportCell(0,"",1,0.0f));
				table.addCell(rm.ReportCell(0,"Retail / Consumer / Finance (to employees associates)",1,2));
				table.addCell(rm.ReportCell(1,"No.of Accounts",1));
				table.addCell(rm.ReportCell(1,"Amount",1));
				table.addCell(rm.ReportCell(1,"No.of Accounts",1));
				table.addCell(rm.ReportCell(1,"Amount",1));
				table.addCell(rm.ReportCell(0,"",1,0.0f));
				table.addCell(rm.ReportCell(2,correctNull(rs.getString("EXEC_PNOACS")),1));
				table.addCell(rm.ReportCell(2,correctNull(rs.getString("EXEC_PRETAILAMT")),1));
				table.addCell(rm.ReportCell(2,correctNull(rs.getString("EXEC_CNOACS")),1));
				table.addCell(rm.ReportCell(2,correctNull(rs.getString("EXEC_CRETAILAMT")),1));
				
			
				
				table.addCell(rm.ReportCell(0,"",1,0.0f));
				table.addCell(rm.ReportCell(0,"Deposit",1));
				table.addCell(rm.ReportCell(1,"Amount",1));
				table.addCell(rm.ReportCell(1,"Tenor & due date",1));
				table.addCell(rm.ReportCell(1,"Amount",1));
				table.addCell(rm.ReportCell(1,"Tenor & due date",1));
				
				table.addCell(rm.ReportCell(0,"",1,0.0f));
				table.addCell(rm.ReportCell(0,"-Own -",1));
				table.addCell(rm.ReportCell(2,nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("EXEC_POWNAMT")))),1));
				table.addCell(rm.ReportCell(2,correctNull(rs.getString("EXEC_POWNTENORDATE")),1));
				table.addCell(rm.ReportCell(2,nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("EXEC_COWNAMT")))),1));
				table.addCell(rm.ReportCell(2,correctNull(rs.getString("EXEC_COWNTENORDATE")),1));
				
				table.addCell(rm.ReportCell(0,"",1,0.0f));
				table.addCell(rm.ReportCell(0,"Third Party",1));
				table.addCell(rm.ReportCell(2,nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("EXEC_PTHIRDAMT")))),1));
				table.addCell(rm.ReportCell(2,correctNull(rs.getString("EXEC_PTHIRDTENORDATE")),1));
				table.addCell(rm.ReportCell(2,nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("EXEC_CTHIRDAMT")))),1));
				table.addCell(rm.ReportCell(2,correctNull(rs.getString("EXEC_CTHIRDTENORDATE")),1));
				
				table.addCell(rm.ReportCell(0,"\n",6,0.0f));
			}
			
			else{

				table.addCell(rm.ReportCell(0,"",1,0.0f));
				table.addCell(rm.ReportCell(1,"Advances",1));
				table.addCell(rm.ReportCell(1,"Previous Year\nFrom: __/__/____  To: __/__/____",2));
				table.addCell(rm.ReportCell(1,"Current Year\nFrom: __/__/____  To: __/__/____",2));
				
				table.addCell(rm.ReportCell(0,"",1,0.0f));
				table.addCell(rm.ReportCell(0,"- Interest Income",1));
				table.addCell(rm.ReportCell(2,"",2));
				table.addCell(rm.ReportCell(2,"",2));
				
				table.addCell(rm.ReportCell(0,"",1,0.0f));
				table.addCell(rm.ReportCell(0,"-Feebased Income",1));
				table.addCell(rm.ReportCell(2,"",2));
				table.addCell(rm.ReportCell(2,"",2));

				table.addCell(rm.ReportCell(0,"",1,0.0f));
				table.addCell(rm.ReportCell(0,"Retail / Consumer / Finance (to employees associates)",1,2));
				table.addCell(rm.ReportCell(1,"No.of Accounts",1));
				table.addCell(rm.ReportCell(1,"Amount",1));
				table.addCell(rm.ReportCell(1,"No.of Accounts",1));
				table.addCell(rm.ReportCell(1,"Amount",1));
				table.addCell(rm.ReportCell(0,"",1,0.0f));
				table.addCell(rm.ReportCell(2,"",1));
				table.addCell(rm.ReportCell(2,"",1));
				table.addCell(rm.ReportCell(2,"",1));
				table.addCell(rm.ReportCell(2,"",1));
				
			
				
				table.addCell(rm.ReportCell(0,"",1,0.0f));
				table.addCell(rm.ReportCell(0,"Deposit",1));
				table.addCell(rm.ReportCell(1,"Amount",1));
				table.addCell(rm.ReportCell(1,"Tenor & due date",1));
				table.addCell(rm.ReportCell(1,"Amount",1));
				table.addCell(rm.ReportCell(1,"Tenor & due date",1));
				
				table.addCell(rm.ReportCell(0,"",1,0.0f));
				table.addCell(rm.ReportCell(0,"-Own -",1));
				table.addCell(rm.ReportCell(2,"",1));
				table.addCell(rm.ReportCell(2,"",1));
				table.addCell(rm.ReportCell(2,"",1));
				table.addCell(rm.ReportCell(2,"",1));
				
				table.addCell(rm.ReportCell(0,"",1,0.0f));
				table.addCell(rm.ReportCell(0,"Third Party",1));
				table.addCell(rm.ReportCell(2,"",1));
				table.addCell(rm.ReportCell(2,"",1));
				table.addCell(rm.ReportCell(2,"",1));
				table.addCell(rm.ReportCell(2,"",1));
				
				table.addCell(rm.ReportCell(0,"\n",6,0.0f));
			
			}
			document.add(table);
			table=null;
			
			table=new Table(3);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f); 
			table.setWidths(wid22);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			table.addCell(rm.ReportCellBold(0,"25.3.",1,0.0f));
			table.addCell(rm.ReportCellBold(0,"DETAILS OF THE FOREIGN CURRENCY EXPOSURE COMMITMENTS AND UNHEDGED PORTION IF ANY. ",1,0.0f));
			if(rs!=null)
				rs.close();
			String FOREIGN_FLAG = "NO";
			strQuery = SQLParser.getSqlQuery("execsel_FOREIGNCURRENCY^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				FOREIGN_FLAG = "YES";
				table.addCell(rm.ReportCell(0,FOREIGN_FLAG,1,0.0f));
			}
			else
			{
				table.addCell(rm.ReportCell(0,FOREIGN_FLAG,1,0.0f));
			}
			document.add(table);
			table=null;
			
			if(FOREIGN_FLAG.equalsIgnoreCase("YES"))
			{
			int[] widfor={7,7,35,16,17,18};
			table=new Table(6);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f); 
			table.setWidths(widfor);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			table.addCell(rm.ReportCellBold(0,"",1,0.0f));
			table.addCell(rm.ReportCellBold(2,"(Amt. in USD, 000' omitted)",5,0.0f));
			
			table.addCell(rm.ReportCell(0,"",1,0.0f));
			table.addCell(rm.ReportCell(1,"",1));
			table.addCell(rm.ReportCellBold(1,"Name of the Corporate",1));
			table.addCell(rm.ReportCellBold(1,"Amount of Exposure",1));
			table.addCell(rm.ReportCellBold(1,"Unhedged Portion",1));
			table.addCell(rm.ReportCellBold(1,"Due date for payment (Range)",1));
			
			table.addCell(rm.ReportCell(0,"",1,0.0f));
			table.addCell(rm.ReportCell(1,"1.",1));
			table.addCell(rm.ReportCell(0,"External Commercial Borrowings",1));
			table.addCell(rm.ReportCell(2,nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("EXEC_EXPAMT1")))),1));
			table.addCell(rm.ReportCell(2,correctNull(rs.getString("EXEC_UNHEDPOS1")),1));
			table.addCell(rm.ReportCell(0,correctNull(rs.getString("EXEC_DUEDATE1")),1));
			
			table.addCell(rm.ReportCell(0,"",1,0.0f));
			table.addCell(rm.ReportCell(1,"2.",1));
			table.addCell(rm.ReportCell(0,"Import usance bills received on collection basis duly accepted and outstanding",1));
			table.addCell(rm.ReportCell(2,nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("EXEC_EXPAMT2")))),1));
			table.addCell(rm.ReportCell(2,correctNull(rs.getString("EXEC_UNHEDPOS2")),1));
			table.addCell(rm.ReportCell(0,correctNull(rs.getString("EXEC_DUEDATE2")),1));
			
			table.addCell(rm.ReportCell(0,"",1,0.0f));
			table.addCell(rm.ReportCell(1,"3.",1));
			table.addCell(rm.ReportCell(0,"O/s. L/Cs & PADs for import of goods/capital equipment.",1));
			table.addCell(rm.ReportCell(2,nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("EXEC_EXPAMT3")))),1));
			table.addCell(rm.ReportCell(2,correctNull(rs.getString("EXEC_UNHEDPOS3")),1));
			table.addCell(rm.ReportCell(0,correctNull(rs.getString("EXEC_DUEDATE3")),1));
			
			table.addCell(rm.ReportCell(0,"",1,0.0f));
			table.addCell(rm.ReportCell(1,"4.",1));
			table.addCell(rm.ReportCell(0,"Outstanding in packing credit for which the corporate is committed to submit export bills",1));
			table.addCell(rm.ReportCell(2,nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("EXEC_EXPAMT4")))),1));
			table.addCell(rm.ReportCell(2,correctNull(rs.getString("EXEC_UNHEDPOS4")),1));
			table.addCell(rm.ReportCell(0,correctNull(rs.getString("EXEC_DUEDATE4")),1));
			
			table.addCell(rm.ReportCell(0,"",1,0.0f));
			table.addCell(rm.ReportCell(1,"5.",1));
			table.addCell(rm.ReportCell(0,"Other Export Receivables",1));
			table.addCell(rm.ReportCell(2,nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("EXEC_EXPAMT5")))),1));
			table.addCell(rm.ReportCell(2,correctNull(rs.getString("EXEC_UNHEDPOS5")),1));
			table.addCell(rm.ReportCell(0,correctNull(rs.getString("EXEC_DUEDATE5")),1));
			
			table.addCell(rm.ReportCell(0,"",1,0.0f));
			table.addCell(rm.ReportCell(1,"6.",1));
			table.addCell(rm.ReportCell(0,"Others Import Obligations",1));
			table.addCell(rm.ReportCell(2,nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("EXEC_EXPAMT6")))),1));
			table.addCell(rm.ReportCell(2,correctNull(rs.getString("EXEC_UNHEDPOS6")),1));
			table.addCell(rm.ReportCell(0,correctNull(rs.getString("EXEC_DUEDATE6")),1));
			
			table.addCell(rm.ReportCell(0,"",1,0.0f));
			table.addCell(rm.ReportCell(1,"7.",1));
			table.addCell(rm.ReportCell(0,"Foreign currency loans availed from Authorised Dealers in India",1));
			table.addCell(rm.ReportCell(2,nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("EXEC_EXPAMT7")))),1));
			table.addCell(rm.ReportCell(2,correctNull(rs.getString("EXEC_UNHEDPOS7")),1));
			table.addCell(rm.ReportCell(0,correctNull(rs.getString("EXEC_DUEDATE7")),1));
			
			table.addCell(rm.ReportCell(0,"",1,0.0f));
			table.addCell(rm.ReportCell(1,"8.",1));
			table.addCell(rm.ReportCell(0,"Any other exposure: Please specify",1));
			table.addCell(rm.ReportCell(2,nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("EXEC_EXPAMT8")))),1));
			table.addCell(rm.ReportCell(2,correctNull(rs.getString("EXEC_UNHEDPOS8")),1));
			table.addCell(rm.ReportCell(0,correctNull(rs.getString("EXEC_DUEDATE8")),1));
			
			document.add(table);
			table=null;
			}
			
			ArrayList arrCol = new ArrayList();
			ArrayList arrVec_supp=new ArrayList();
			String stroperexp = SQLParser.getSqlQuery("execgrpconsel^" + strAppno);
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(stroperexp);
			double dblgccomlimit = 0.0;
			double dblgccomos = 0.0;
			double dblgcfbwclt = 0.0;
			double dblgcfbwcpd = 0.0;
			double dblgcfbwcos = 0.0;
			double dblgctllt = 0.0;
			double dblgctlos = 0.0;
			double dblgcins = 0.0;

			while (rs.next()) {
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("EXEC_GCCONNAME")));
				arrCol.add(correctNull(rs.getString("EXEC_GCBRANCH")));
				arrCol.add(correctNull(rs.getString("EXCE_GCCOA")));
				dblgccomlimit = dblgccomlimit
						+ (rs.getDouble("EXEC_GCCOMLIMIT"));
				arrCol.add(correctNull(rs.getString("EXEC_GCCOMLIMIT")));
				dblgccomos = dblgccomos + (rs.getDouble("EXEC_GCCOMOS"));
				arrCol.add(correctNull(rs.getString("EXEC_GCCOMOS")));
				dblgcfbwclt = dblgcfbwclt + (rs.getDouble("EXEC_GCFBWCLT"));
				arrCol.add(correctNull(rs.getString("EXEC_GCFBWCLT")));
				dblgcfbwcpd = dblgcfbwcpd + (rs.getDouble("EXEC_GCFBWCDP"));
				arrCol.add(correctNull(rs.getString("EXEC_GCFBWCDP")));
				dblgcfbwcos = dblgcfbwcos + (rs.getDouble("EXEC_GCFBWCOS"));
				arrCol.add(correctNull(rs.getString("EXEC_GCFBWCOS")));
				dblgctllt = dblgctllt + (rs.getDouble("EXEC_GCTLLT"));
				arrCol.add(correctNull(rs.getString("EXEC_GCTLLT")));
				dblgctlos = dblgctlos + (rs.getDouble("EXEC_GCTLOS"));
				arrCol.add(correctNull(rs.getString("EXEC_GCTLOS")));
				dblgcins = dblgcins + (rs.getDouble("EXEC_GCINS"));
				arrCol.add(correctNull(rs.getString("EXEC_GCINS")));
				arrCol.add(correctNull(rs.getString("EXEC_GCMOR")));
				arrCol.add(correctNull(rs.getString("EXEC_GCIRREG")));
				arrCol.add(correctNull(rs.getString("comapp_div_name")));
				arrVec_supp.add(arrCol);
			}
			
			int[] simwid={7,80,13};
			table=new Table(3);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f); 
			table.setWidths(simwid);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			table.addCell(rm.ReportCellBold(0,"26.",1,0.0f));
			table.addCell(rm.ReportCellBold(0,"OPERATIONAL EXPERIENCE WITH REGARD TO GROUP CONCERNS",1,0.0f));
			table.addCell(rm.ReportCellBold(2,"("+ApplicationParams.getCurrency()+"In "+strProposalvalue+")",1,0.0f));
			document.add(table);
			table=null;
			
			int[] widfor={7,9,9,9,5,5,5,5,5,5,4,9,9,9};
			table=new Table(14);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f); 
			table.setWidths(widfor);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			table.addCell(rm.ReportCellBold(1,"",1,0.0f));
			table.addCell(rm.ReportCellBold(1,"Name of the Concern",1,2));
			table.addCell(rm.ReportCellBold(1,"Branch",1,2));
			table.addCell(rm.ReportCellBold(1,"CoA",1,2));
			table.addCell(rm.ReportCellBold(1,"Contingent",2));
			table.addCell(rm.ReportCellBold(1,"FBWC",3));
			table.addCell(rm.ReportCellBold(1,"Term Loan",2));
			table.addCell(rm.ReportCellBold(1,"Investment",1,2));
			table.addCell(rm.ReportCellBold(1,"MOR",1,2));
			table.addCell(rm.ReportCellBold(1,"Irregularity, if any",1,2));
			
			table.addCell(rm.ReportCellBold(1,"",1,0.0f));
			table.addCell(rm.ReportCellBold(1,"Limit",1));
			table.addCell(rm.ReportCellBold(1,"O/s",1));
			table.addCell(rm.ReportCellBold(1,"Limit",1));
			table.addCell(rm.ReportCellBold(1,"DP",1));
			table.addCell(rm.ReportCellBold(1,"O/s",1));
			table.addCell(rm.ReportCellBold(1,"Limit",1));
			table.addCell(rm.ReportCellBold(1,"O/s",1));
			
			boolean bool26=true;
			arr5 =new ArrayList();			
            for (int i = 0; i < arrVec_supp.size(); i++) {
            	bool26=false;
			arr5 = new ArrayList();
			arr5 = (ArrayList) arrVec_supp.get(i);
			
			table.addCell(rm.ReportCellBold(1,"",1,0.0f));
			table.addCell(rm.ReportCell(0,correctNull((String)arr5.get(13)),1));
			
			table.addCell(rm.ReportCellBold(1,"",1,0.0f));
			table.addCell(rm.ReportCell(0,correctNull((String)arr5.get(1)),1));
			table.addCell(rm.ReportCell(0,correctNull((String)arr5.get(2)),1));
			table.addCell(rm.ReportCell(2,nf.format(Double.parseDouble(Helper.correctDouble((String)arr5.get(3)))),1));
			table.addCell(rm.ReportCell(2,nf.format(Double.parseDouble(Helper.correctDouble((String)arr5.get(4)))),1));
			table.addCell(rm.ReportCell(2,nf.format(Double.parseDouble(Helper.correctDouble((String)arr5.get(5)))),1));
			table.addCell(rm.ReportCell(2,nf.format(Double.parseDouble(Helper.correctDouble((String)arr5.get(6)))),1));
			table.addCell(rm.ReportCell(2,nf.format(Double.parseDouble(Helper.correctDouble((String)arr5.get(7)))),1));
			table.addCell(rm.ReportCell(2,nf.format(Double.parseDouble(Helper.correctDouble((String)arr5.get(8)))),1));
			table.addCell(rm.ReportCell(2,nf.format(Double.parseDouble(Helper.correctDouble((String)arr5.get(9)))),1));
			table.addCell(rm.ReportCell(2,nf.format(Double.parseDouble(Helper.correctDouble((String)arr5.get(10)))),1));
			table.addCell(rm.ReportCell(0,correctNull((String)arr5.get(11)),1));
			table.addCell(rm.ReportCell(0,correctNull((String)arr5.get(12)),1));
       }
           if(bool26)
           {
        	table.addCell(rm.ReportCellBold(1,"",1,0.0f));
        	table.addCell(rm.ReportCell(0,"",1));
   			table.addCell(rm.ReportCell(0,"",1));
   			table.addCell(rm.ReportCell(0,"",1));
   			table.addCell(rm.ReportCell(2,"",1));
   			table.addCell(rm.ReportCell(2,"",1));
   			table.addCell(rm.ReportCell(2,"",1));
   			table.addCell(rm.ReportCell(2,"",1));
   			table.addCell(rm.ReportCell(2,"",1));
   			table.addCell(rm.ReportCell(2,"",1));
   			table.addCell(rm.ReportCell(2,"",1));
   			table.addCell(rm.ReportCell(2,"",1));
   			table.addCell(rm.ReportCell(0,"",1));
   			table.addCell(rm.ReportCell(0,".",1));
           }
            table.addCell(rm.ReportCellBold(1,"",1,0.0f));
            table.addCell(rm.ReportCellBold(0,"Total Exposure",1));
			table.addCell(rm.ReportCellBold(0,"",1));
			table.addCell(rm.ReportCellBold(0,"",1));
			table.addCell(rm.ReportCellBold(2,nf.format(dblgccomlimit),1));
			table.addCell(rm.ReportCellBold(2,nf.format(dblgccomos),1));
			table.addCell(rm.ReportCellBold(2,nf.format(dblgcfbwclt),1));
			table.addCell(rm.ReportCellBold(2,nf.format(dblgcfbwcpd),1));
			table.addCell(rm.ReportCellBold(2,nf.format(dblgcfbwcos),1));
			table.addCell(rm.ReportCellBold(2,nf.format(dblgctllt),1));
			table.addCell(rm.ReportCellBold(2,nf.format(dblgctlos),1));
			table.addCell(rm.ReportCellBold(2,nf.format(dblgcins),1));
			table.addCell(rm.ReportCellBold(0,"",1));
			table.addCell(rm.ReportCellBold(0,"",1));
			document.add(table);
			table=null;
			
			table=new Table(3);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f); 
			table.setWidths(wid22);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			table.addCell(rm.ReportCellBold(0,"26.1.",1,0.0f));
			table.addCell(rm.ReportCellBold(0,"COMMENTS ON OTHER BANK'S CREDIT REPORT ON SISTER CONCERNS",2,0.0f));
			if(rs!=null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("execsel_port^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				table.addCell(rm.ReportCell(0,correctNull(rs.getString("exec_comments_sisterconcern")),3,0.0f));
			}
			else
			{
				table.addCell(rm.ReportCell(0,"",3,0.0f));
			}
			document.add(table);
			table=null;
			
			int[] widpru={7,93};
			table=new Table(2);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f); 
			table.setWidths(widpru);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			table.addCell(rm.ReportCellBold(0,"27.",1,0.0f));
			table.addCell(rm.ReportCellBold(0,"PRUDENTIAL EXPOSURE NORMS [inclusive of Bank's exposure in the form of investments like shares, debentures, CP, etc.]",1,0.0f));
			document.add(table);
			table=null;
			
			int[] cmwid7={7,25,25,25,25};
			table=new Table(5);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100); 
			table.setAlignment(0);
			table.setWidths(cmwid7);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			table.addCell(rm.ReportCellBold(1,"",1,0.0f));
			table.addCell(rm.ReportCellBold(1,"Constitution",1));
			table.addCell(rm.ReportCellBold(1,"Prudential Limit in("+ApplicationParams.getCurrency()+"In "+strProposalvalue+")",1));
			table.addCell(rm.ReportCellFontColorWhite9(1,"",1,0.0f));
			table.addCell(rm.ReportCellFontColorWhite9(1,"",1,0.0f));
			
			String strBorrowerType="",strcon="",strPublictype="",strOwnership="";
			String strIndustryType="";
			double dblprulimit=0.0;
			strQuery = SQLParser.getSqlQuery("execsel_port^" + strAppno);
			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				strBorrowerType=correctNull(rs.getString("exec_borrowertype"));		
			}
			strQuery = SQLParser.getSqlQuery("selprosalvaluesin^"+strAppno);
 			if(rs!=null)
 			{
 				rs.close();
 			}
 			rs = DBUtils.executeQuery(strQuery);
 			if(rs.next())
 			{
 				Strproposalvaluesin=correctNull(rs.getString("prop_valuesin"));
 			}
				strQuery = SQLParser.getSqlQuery("comappmastersel^" + comappid);
				if (rs != null) {
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strIndcode=correctNull(rs.getString("comapp_indcode"));
					strIndustryType=correctNull(rs.getString("scale"));
					strGroup=correctNull(rs.getString("comapp_group"));
					strPublictype=correctNull(rs.getString("comapp_pubtype")).equals("")?"S":correctNull(rs.getString("comapp_pubtype"));
					strcon =getConstitution(correctNull(rs.getString("comapp_ownership")));
					strOwnership= correctNull(rs.getString("comapp_ownership"));
					
					if(strOwnership.equalsIgnoreCase("IN"))//Individual
					{
						strOwnership="001";
					}
					else if(strOwnership.equalsIgnoreCase("OLP"))//PVT LTD COMPANY
					{
						strOwnership="005";
					}
					else if(strOwnership.equalsIgnoreCase("OCC"))//PUBLIC LTD COMPANY
					{
						strOwnership="006";
					}
					else if(strOwnership.equalsIgnoreCase("OP"))//PARTNER SHIP
					{
						strOwnership="007";
					}
					else if(strOwnership.equalsIgnoreCase("OLC"))//Joint Borrowers
					{
						strOwnership="002";
					}
					else if(strOwnership.equalsIgnoreCase("OS"))//Sole Proprietor
					{
						strOwnership="009";
					}
					else if(strOwnership.equalsIgnoreCase("Jo"))//Joint Venture
					{
						strOwnership="011";
					}
					else if(strOwnership.equalsIgnoreCase("sub"))//Wholly owned subsidiary
					{
						strOwnership="011";
					}
					else if(strOwnership.equalsIgnoreCase("TR"))//Trusts
					{
						strOwnership="004";
					}
					else if(strOwnership.equalsIgnoreCase("AC"))//Association
					{
						strOwnership="003";
					}
					else if(strOwnership.equalsIgnoreCase("nbfc"))//NBFC
					{
						strOwnership="999";
					}
					else if(strOwnership.equalsIgnoreCase("HUF"))//HUF
					{
						strOwnership="008";
					}
					else if(strOwnership.equalsIgnoreCase("OO"))//Others
					{
						strOwnership="999";
					}
					
				}
				strQuery = SQLParser.getSqlQuery("sel_constitutionexposure^"+strBorrowerType+"^"+strOwnership+"^"+strPublictype);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					dblprulimit=Strproposalvaluesin.equalsIgnoreCase("C")?rs.getDouble("exp_maxlimit"):(rs.getDouble("exp_maxlimit")*100);
				}
				table.addCell(rm.ReportCellBold(1,"",1,0.0f));
				table.addCell(rm.ReportCell(0,strcon,1));
				table.addCell(rm.ReportCell(2,Helper.formatDoubleValue(dblprulimit),1));
				table.addCell(rm.ReportCellFontColorWhite9(1,"",1,0.0f));
				table.addCell(rm.ReportCellFontColorWhite9(1,"",1,0.0f));
			document.add(table);
			table=null;
			
			table=new Table(5);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100); 
			table.setWidths(cmwid7);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			table.setAlignment(0);
			table.addCell(rm.ReportCellBold(1,"",1,0.0f));
			table.addCell(rm.ReportCellBold(1,"Category",1));
			table.addCell(rm.ReportCellBold(1,"Ceiling as % to Bank's Capital Funds",1));
			table.addCell(rm.ReportCellBold(1,"Amount based on Capital Funds ("+ApplicationParams.getCurrency()+"In "+strProposalvalue+")",1));
			table.addCell(rm.ReportCellFontColorWhite9(1,"",1,0.0f));
	
			double dblcapital_funds=0.0;
			String label="";
			if(rs!=null) rs.close();
			strQuery=SQLParser.getSqlQuery("selbanknetfunds");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				if(!(strIndustryType.equalsIgnoreCase("4")) && (strGroup.equalsIgnoreCase("")))
				{
					dblcapital_funds=rs.getDouble("net_singleborrexp");
					label="Single Borrower";
				}
				else if(!(strIndustryType.equalsIgnoreCase("4")) && (!(strGroup.equalsIgnoreCase(""))))
				{	
					dblcapital_funds=Double.parseDouble(Helper.correctDouble(rs.getString("net_groupborrexp")));
					label="Group";
				}
				else if(strIndustryType.equalsIgnoreCase("4") && (strGroup.equalsIgnoreCase("")))
				{
					dblcapital_funds=Double.parseDouble(Helper.correctDouble(rs.getString("net_singleborrinfra")));
					label="Single Borrower with infrastructure";
				}
				else if(strIndustryType.equalsIgnoreCase("4") && (!(strGroup.equalsIgnoreCase(""))))
				{	
					dblcapital_funds=Double.parseDouble(Helper.correctDouble(rs.getString("net_groupborrinfra")));
					label="Group of Borrower with infrastructure";
				}
				table.addCell(rm.ReportCellBold(1,"",1,0.0f));
				table.addCell(rm.ReportCell(0,label,1));
				table.addCell(rm.ReportCell(1,Helper.formatDoubleValue(dblcapital_funds),1));
				
				double dbltotbank_credit=rs.getDouble("net_bankfunds");
				if(Strproposalvaluesin.equalsIgnoreCase("C"))
				{
					table.addCell(rm.ReportCell(1,nf.format(dbltotbank_credit*dblcapital_funds/100),1));
				}
				else
				{
					table.addCell(rm.ReportCell(1,nf.format(dbltotbank_credit*dblcapital_funds),1));
				}
				table.addCell(rm.ReportCellFontColorWhite9(1,"",1,0.0f));
			}
			
			table.addCell(rm.ReportCellBold(1,"",1,0.0f));
			table.addCell(rm.ReportCell(0, strExposureNorms, 4,0.0f));
			
			document.add(table);
			table=null;
			
			//End Nalini
			
			// START OF MURALI
			
			displayComments2(document,strAppno,strcompanyname,strauditnotes,strProposalvalue,strconsortiumassessment,strOtherMatters);
			
			
			
			
			//END OF MURALI
			

			// Added by subha .. From 31st Item
			
			table=new Table(4);
			table.setPadding(2.0f);			
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f);
			table.setWidths(wd4);
			table.setBorder(0);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			table.addCell(rm.ReportCellBold(1,"31.",1,0.0f));				
			table.addCell(rm.ReportCellBold(0,"CREDIT RATING",3,0.0f));
			
			
			String facilityrating_dm_prevyear="",facilityrating_dm_curryear="";
			String facilityratingscore_dm_prevyear="",facilityratingscore_dm_curryear="";
			String lastrating_basemodel="",lastscore_basemodel="",lastgradef_basemodel="";
			String currentrating_basemodel="",currentscore_basemodel="",currentgradef_basemodel="";
			
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeLAPSQuery("getramrating105details^"+ strAppno);
			if (rs.next()) {
				lastrating_basemodel= correctNull((String) rs.getString("lastrating_basemodel"));
				lastscore_basemodel= correctNull((String) rs.getString("lastscore_basemodel"));
				lastgradef_basemodel= correctNull((String) rs.getString("lastgradef_basemodel"));
				currentrating_basemodel=correctNull((String) rs.getString("currentrating_basemodel"));
				currentscore_basemodel=correctNull((String) rs.getString("currentscore_basemodel"));
				currentgradef_basemodel=correctNull((String) rs.getString("currentgradef_basemodel"));
		}
			
			strQuery = SQLParser.getSqlQuery("sel_irbcreditrating1_esp^"+ strAppno);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				if(correctNull(rs.getString("description")).equals("Facility Rating(Dynamic Model)"))
				{
					facilityrating_dm_prevyear=correctNull((String)rs.getString("previous_year"));
					facilityrating_dm_curryear=correctNull((String)rs.getString("current_year"));
				}
				else if(correctNull(rs.getString("description")).equals("Facility Score(Dynamic Model)"))
				{
					facilityratingscore_dm_prevyear=correctNull((String)rs.getString("previous_year"));
					facilityratingscore_dm_curryear=correctNull((String)rs.getString("current_year"));
				}
				else
				{
					arrVecRate = new ArrayList();
					arrVecRate.add(correctNull((String)rs.getString("description")));
					arrVecRate.add(correctNull((String)rs.getString("previous_year")));
					arrVecRate.add(correctNull((String)rs.getString("current_year")));
					arrRow16.add(arrVecRate);
				}
			}
			
			arrRow = new ArrayList();
			arrData = new ArrayList();
			arrRow = arrRow16;
			int ratesize = 0;
			if (arrRow != null && arrRow.size() > 0) 
			{
				table.addCell(rm.ReportCellBold(0,"",1,0.0f));				
				table.addCell(rm.ReportCellBold(0,"Parameters ",1));
				table.addCell(rm.ReportCellBold(0,"Marks obtained  ",2));
				
				table.addCell(rm.ReportCellBold(0,"",1,0.0f));				
				table.addCell(rm.ReportCellBold(0,"Score Sheet for Bank Model ",1));
				table.addCell(rm.ReportCellBold(0,"PreviousYr. ",1));
				table.addCell(rm.ReportCellBold(0,"Current Yr. ",1));
				
				ratesize = arrRow.size();
				for (int i = 0; i < ratesize; i++) 
				{
					arrData = (ArrayList) arrRow.get(i);
					table.addCell(rm.ReportCell(0,"",1,0.0f));				
					table.addCell(rm.ReportCell(0,Helper.correctNull((String) arrData.get(0)),1));
					table.addCell(rm.ReportCell(0,Helper.correctNull((String) arrData.get(1)),1));
					table.addCell(rm.ReportCell(0,Helper.correctNull((String) arrData.get(2)),1));
				}
				
				table.addCell(rm.ReportCell(0,"",1,0.0f));				
				table.addCell(rm.ReportCell(0,"Borrower Rating",1));
				table.addCell(rm.ReportCell(0,lastrating_basemodel,1));
				table.addCell(rm.ReportCell(0,currentrating_basemodel,1));
				
				table.addCell(rm.ReportCell(0,"",1,0.0f));				
				table.addCell(rm.ReportCell(0,"Risk Definition",1));
				table.addCell(rm.ReportCell(0,lastgradef_basemodel,1));
				table.addCell(rm.ReportCell(0,currentgradef_basemodel,1));
			}
			
						
			document.add(table);
			table=null;
			
			int[] wd5={7,33,15,15,15,15};
			table=new Table(6);
			table.setPadding(2.0f);			
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f);
			table.setWidths(wd5);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			table.addCell(rm.ReportCellBold(0,"",1,0.0f));				
			table.addCell(rm.ReportCellBold(0,"Score Sheet for CRISIL Model",1));
			table.addCell(rm.ReportCell(0,"Grade",1));
			table.addCell(rm.ReportCell(0,"Score",1));
			table.addCell(rm.ReportCell(0,"Grade",1));
			table.addCell(rm.ReportCell(0,"Score",1));
			
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeLAPSQuery("getramrating105details^"+ strAppno);
			if (rs.next()) {
				
				table.addCell(rm.ReportCellBold(0,"",1,0.0f));				
				table.addCell(rm.ReportCell(0,"Borrower Rating",1));
				table.addCell(rm.ReportCell(0,Helper.correctNull((String) hshValues.get("lastrating_dynamicmodel")),1));
				table.addCell(rm.ReportCell(0,Helper.correctNull((String) hshValues.get("lastscore_dynamicmodel")),1));
				table.addCell(rm.ReportCell(0,Helper.correctNull((String) hshValues.get("currentrating_dynamicmodel")),1));
				table.addCell(rm.ReportCell(0,Helper.correctNull((String) hshValues.get("currentscore_dynamicmodel")),1));
				
				table.addCell(rm.ReportCellBold(0,"",1,0.0f));				
				table.addCell(rm.ReportCell(0,"Facility Rating",1));
				table.addCell(rm.ReportCell(0,facilityrating_dm_prevyear,1));
				table.addCell(rm.ReportCell(0,facilityratingscore_dm_prevyear,1));
				table.addCell(rm.ReportCell(0,facilityrating_dm_curryear,1));
				table.addCell(rm.ReportCell(0,facilityratingscore_dm_curryear,1));
				
				table.addCell(rm.ReportCellBold(0,"",1,0.0f));				
				table.addCell(rm.ReportCell(0,"Combined Rating",1));
				table.addCell(rm.ReportCell(0,Helper.correctNull((String) hshValues.get("lastcombinedrating_dm")),2));
				table.addCell(rm.ReportCell(0,Helper.correctNull((String) hshValues.get("currentcombinedrating_dm")),2));
				
				table.addCell(rm.ReportCellBold(0,"",1,0.0f));				
				table.addCell(rm.ReportCell(0,"Risk Definition",1));
				table.addCell(rm.ReportCell(0,Helper.correctNull((String) hshValues.get("lastgradef_dynamicmodel")),2));
				table.addCell(rm.ReportCell(0,Helper.correctNull((String) hshValues.get("currentgradef_dynamicmodel")),2));
			}
			else
			{
				table.addCell(rm.ReportCellBold(0,"",1,0.0f));				
				table.addCell(rm.ReportCell(0,"Borrower Rating",1));
				table.addCell(rm.ReportCell(0,"",1));
				table.addCell(rm.ReportCell(0,"",1));
				table.addCell(rm.ReportCell(0,"",1));
				table.addCell(rm.ReportCell(0,"",1));
				
				table.addCell(rm.ReportCellBold(0,"",1,0.0f));				
				table.addCell(rm.ReportCell(0,"Facility Rating",1));
				table.addCell(rm.ReportCell(0,"",1));
				table.addCell(rm.ReportCell(0,"",1));
				table.addCell(rm.ReportCell(0,"",1));
				table.addCell(rm.ReportCell(0,"",1));
				
				table.addCell(rm.ReportCellBold(0,"",1,0.0f));				
				table.addCell(rm.ReportCell(0,"Combined Rating",1));
				table.addCell(rm.ReportCell(0,"",2));
				table.addCell(rm.ReportCell(0,"",2));
				
				table.addCell(rm.ReportCellBold(0,"",1,0.0f));				
				table.addCell(rm.ReportCell(0,"Risk Definition",1));
				table.addCell(rm.ReportCell(0,"",2));
				table.addCell(rm.ReportCell(0,"",2));
			}
			
			document.add(table);
			table=null;
			
			table=new Table(3);
			table.setPadding(2.0f);			
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f);
			table.setWidths(wd1);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);			
			
			table.addCell(rm.ReportCellBold(1,"32.",1,0.0f));
			table.addCell(rm.ReportCellBold(0,"INDICATE PRODUCTS / SERVICES PROPOSED TO BE MARKETED TO CUSTOMER:",1,0.0f));
			table.addCell(rm.ReportCell(0,strindservices,1,0.0f));
			
			table.addCell(rm.ReportCellBold(1,"33.",1,0.0f));
			table.addCell(rm.ReportCellBold(0,"BANK'S EXPOSURE TO INDUSTRY (BSR Code:"+strcompanyid+")",1,0.0f));
			table.addCell(rm.ReportCell(0,"Activity:"+strcompnature,1,0.0f));
		
			
			if(rs!=null) rs.close();
			String strGrpcode="",strGrpexp="";
			strQuery=SQLParser.getSqlQuery("selindustrynamebyindno^"+strIndcode);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strGrpcode=correctNull(rs.getString("ind_grpcode"));
			}
			
			if(rs!=null) rs.close();
			
			if(!strGrpcode.equalsIgnoreCase(""))
			{
				if(rs!=null) rs.close();
				strQuery=SQLParser.getSqlQuery("selindexpbygrpcode^"+strGrpcode);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strGrpexp=Helper.correctDouble(rs.getString("exp_maxexp"));
				}
				strQuery=SQLParser.getSqlQuery("selindexpfromcbs^"+strGrpcode);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					dblgrpsanctionedlimit=Double.parseDouble(Helper.correctDouble(rs.getString("IND_SANCLIMIT")));
					dblgrpos=Double.parseDouble(Helper.correctDouble(rs.getString("IND_OSLIMIT")));
				}
			}
			
			dblgrpexposure=dblBankcreditexposure*Double.parseDouble(Helper.correctDouble(strGrpexp))/100;
			dblgrpremainig=dblgrpexposure-dblgrpsanctionedlimit;
			if(dblgrpremainig<0)
			{
				strnegflag="y";
			}
			if(Strproposalvaluesin.equalsIgnoreCase("C"))
			{
				dblgrpexposure=dblgrpexposure;
				dblgrpsanctionedlimit=dblgrpsanctionedlimit;
				dblgrpos=dblgrpos;
				dblgrpremainig=dblgrpremainig;
			}
			else
			{
				dblgrpexposure=(dblgrpexposure*100);
				dblgrpsanctionedlimit=(dblgrpsanctionedlimit*100);
				dblgrpos=(dblgrpos*100);
				dblgrpremainig=(dblgrpremainig*100);
			}
			
			table.addCell(rm.ReportCellBold(0,"",1,0.0f));
			table.addCell(rm.ReportCellBold(0,"Industry Exposure Limit as per loan policy",1,0.0f));
			table.addCell(rm.ReportCell(0,ApplicationParams.getCurrency() + dblgrpexposure+" "+strProposalvalue,1,0.0f));
			
			table.addCell(rm.ReportCellBold(0,"",1,0.0f));
			table.addCell(rm.ReportCellBold(0,"Bank's Present Exposure to this Industry",1,0.0f));
			table.addCell(rm.ReportCell(0,"",1,0.0f));
			
			table.addCell(rm.ReportCellBold(0,"",1,0.0f));
			table.addCell(rm.ReportCell(0,"Total Sanctioned limit as on"+"  "+strasondate,1,0.0f));
			table.addCell(rm.ReportCell(0,ApplicationParams.getCurrency()+dblgrpsanctionedlimit+" "+strProposalvalue,1,0.0f));
			
			table.addCell(rm.ReportCellBold(0,"",1,0.0f));
			table.addCell(rm.ReportCell(0,"Present O/s as on"+"  "+strasondate,1,0.0f));
			table.addCell(rm.ReportCell(0,ApplicationParams.getCurrency()+dblgrpos+" "+strProposalvalue,1,0.0f));
			
			table.addCell(rm.ReportCellBold(0,"",1,0.0f));
			table.addCell(rm.ReportCell(0,"Available Limit for sanction as on"+"  "+strasondate,1,0.0f));
			if (strnegflag.equalsIgnoreCase("y")) 
			{
				table.addCell(rm.ReportCell(0,ApplicationParams.getCurrency()+dblgrpremainig+" "+strProposalvalue+" *",1,0.0f));
			}
			else
			{
				table.addCell(rm.ReportCell(0,ApplicationParams.getCurrency()+dblgrpremainig+" "+strProposalvalue,1,0.0f));
			}
			if (strnegflag.equalsIgnoreCase("y")) 
			{
				table.addCell(rm.ReportCellBold(0,"",1,0.0f));
				table.addCell(rm.ReportCell(0,"* - (Minus sign indicates that the industry exposure limit is already exceeded)",2,0.0f));
			}
			document.add(table);
			table=null;
			
			int[] wd6={7,25,15,18,22,13};
			table=new Table(6);
			table.setPadding(2.0f);			
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f);
			table.setWidths(wd6);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			table.addCell(rm.ReportCellBold(1,"",1,0.0f));
			table.addCell(rm.ReportCellBold(2,ApplicationParams.getCurrency()+" In "+strProposalvalue,5));
			
			table.addCell(rm.ReportCellBold(1,"",1,0.0f));
			table.addCell(rm.ReportCellBold(1,"Classification of Asset",1));
			table.addCell(rm.ReportCellBold(1,"No. of A/cs.",1));
			table.addCell(rm.ReportCellBold(1,"Fund Based limits",1));
			table.addCell(rm.ReportCellBold(1,"Non Fund Based limits",1));
			table.addCell(rm.ReportCellBold(1,"Total",1));
			
			strQuery = SQLParser.getSqlQuery("selexec_finratio^" + strAppno);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				table.addCell(rm.ReportCellBold(1,"",1,0.0f));
				table.addCell(rm.ReportCell(0,"Standard",1));
				table.addCell(rm.ReportCell(1,correctNull(rs.getString("exec_summ_finTL1")),1));
				table.addCell(rm.ReportCell(1,correctNull(rs.getString("exec_summ_finTL2")),1));
				table.addCell(rm.ReportCell(1,correctNull(rs.getString("exec_summ_finTL3")),1));
				table.addCell(rm.ReportCell(1,correctNull(rs.getString("exec_summ_finTL4")),1));
				
				table.addCell(rm.ReportCellBold(1,"",1,0.0f));
				table.addCell(rm.ReportCell(0,"Sub-Standard",1));
				table.addCell(rm.ReportCell(1,correctNull(rs.getString("exec_summ_finTOL1")),1));
				table.addCell(rm.ReportCell(1,correctNull(rs.getString("exec_summ_finTOL2")),1));
				table.addCell(rm.ReportCell(1,correctNull(rs.getString("exec_summ_finTOL3")),1));
				table.addCell(rm.ReportCell(1,correctNull(rs.getString("exec_summ_finTOL4")),1));
				
				table.addCell(rm.ReportCellBold(1,"",1,0.0f));
				table.addCell(rm.ReportCell(0,"Doubtful",1));
				table.addCell(rm.ReportCell(1,correctNull(rs.getString("exec_summ_fincurrentratio1")),1));
				table.addCell(rm.ReportCell(1,correctNull(rs.getString("exec_summ_fincurrentratio2")),1));
				table.addCell(rm.ReportCell(1,correctNull(rs.getString("exec_summ_fincurrentratio3")),1));
				table.addCell(rm.ReportCell(1,correctNull(rs.getString("exec_summ_fincurrentratio4")),1));
				
				table.addCell(rm.ReportCellBold(1,"",1,0.0f));
				table.addCell(rm.ReportCell(0,"Loss",1));
				table.addCell(rm.ReportCell(1,correctNull(rs.getString("exec_summ_findscr1")),1));
				table.addCell(rm.ReportCell(1,correctNull(rs.getString("exec_summ_findscr2")),1));
				table.addCell(rm.ReportCell(1,correctNull(rs.getString("exec_summ_findscr3")),1));
				table.addCell(rm.ReportCell(1,correctNull(rs.getString("exec_summ_findscr4")),1));
				
				table.addCell(rm.ReportCellBold(1,"",1,0.0f));
				table.addCell(rm.ReportCellBold(0,"TOTAL",1));
				table.addCell(rm.ReportCell(1,correctNull(rs.getString("exec_summ_fincovratio1")),1));
				table.addCell(rm.ReportCell(1,correctNull(rs.getString("exec_summ_fincovratio2")),1));
				table.addCell(rm.ReportCell(1,correctNull(rs.getString("exec_summ_fincovratio3")),1));
				table.addCell(rm.ReportCell(1,correctNull(rs.getString("exec_summ_fincovratio4")),1));
				
				table.addCell(rm.ReportCellBold(1,"",1,0.0f));
				table.addCell(rm.ReportCellBold(0,"* to be filled in at Central Office level.",5));
			}
			else
			{
				table.addCell(rm.ReportCellBold(1,"",1,0.0f));
				table.addCell(rm.ReportCell(0,"Standard",1));
				table.addCell(rm.ReportCell(1,"",1));
				table.addCell(rm.ReportCell(1,"",1));
				table.addCell(rm.ReportCell(1,"",1));
				table.addCell(rm.ReportCell(1,"",1));
				
				table.addCell(rm.ReportCellBold(1,"",1,0.0f));
				table.addCell(rm.ReportCell(0,"Sub-Standard",1));
				table.addCell(rm.ReportCell(1,"",1));
				table.addCell(rm.ReportCell(1,"",1));
				table.addCell(rm.ReportCell(1,"",1));
				table.addCell(rm.ReportCell(1,"",1));
				
				table.addCell(rm.ReportCellBold(1,"",1,0.0f));
				table.addCell(rm.ReportCell(0,"Doubtful",1));
				table.addCell(rm.ReportCell(1,"",1));
				table.addCell(rm.ReportCell(1,"",1));
				table.addCell(rm.ReportCell(1,"",1));
				table.addCell(rm.ReportCell(1,"",1));
				
				table.addCell(rm.ReportCellBold(1,"",1,0.0f));
				table.addCell(rm.ReportCell(0,"Loss",1));
				table.addCell(rm.ReportCell(1,"",1));
				table.addCell(rm.ReportCell(1,"",1));
				table.addCell(rm.ReportCell(1,"",1));
				table.addCell(rm.ReportCell(1,"",1));
				
				table.addCell(rm.ReportCellBold(1,"",1,0.0f));
				table.addCell(rm.ReportCellBold(1,"TOTAL",1));
				table.addCell(rm.ReportCell(1,"",1));
				table.addCell(rm.ReportCell(1,"",1));
				table.addCell(rm.ReportCell(1,"",1));
				table.addCell(rm.ReportCell(1,"",1));
				
				table.addCell(rm.ReportCellBold(1,"",1,0.0f));
				table.addCell(rm.ReportCellBold(0,"* to be filled in at Central Office level.",5));
			}
			
			document.add(table);
			table=null;
			
			//START OF MURALI
			
			table=new Table(3);
			table.setPadding(2.0f);			
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f);		
			table.setWidths(wd1);
			table.setCellsFitPage(true);
			table.setTableFitsPage(false);
			
			table.addCell(rm.ReportCellBold(1,"34.",1,0.0f));
			table.addCell(rm.ReportCellBold(0,"SUMMARY OF CHANGES IN SANCTION TERMS, IF ANY",2,0.0f));	
			
			document.add(table);
			table=null;
			
			int[] wd3={7,33,20,20,20};
			table=new Table(5);
			table.setPadding(2.0f);			
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f);		
			table.setWidths(wd3);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			table.addCell(rm.ReportCellBold(1,"",1,0.0f));
			table.addCell(rm.ReportCellBold(1,"Terms of Sanction",1,1));
			table.addCell(rm.ReportCellBold(1,"Stipulated earlier",1,1));
			table.addCell(rm.ReportCellBold(1,"Present",1,1));
			table.addCell(rm.ReportCellBold(1,"Now recommended",1,1));
			
			if(rs != null){
				rs.close();
			}
			String strFacility = "";
			String strSanctionTerms = "";
			flag=false;
			strQuery = SQLParser.getSqlQuery("sel_exec_sanctermsfacility^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) 
			{
				flag=true;
				if (strFacility.equalsIgnoreCase("") || !strFacility.equalsIgnoreCase(Helper.correctNull(rs.getString("facility")))) {
					strFacility = Helper.correctNull(rs.getString("facility"));
					table.addCell(rm.ReportCellBold(1,"",1,0.0f));
					table.addCell(rm.ReportCellBold(0,strFacility,4));
				}
				strSanctionTerms = Helper.correctNull(rs.getString("exec_sanctionterms"));
				table.addCell(rm.ReportCellBold(1,"",1,0.0f));
				table.addCell(rm.ReportCell(0,getSanctionTermsDescription(strSanctionTerms),1));
				table.addCell(rm.ReportCell(0,Helper.correctNull(rs.getString("exec_stipearlier")),1));
				table.addCell(rm.ReportCell(0,Helper.correctNull(rs.getString("exec_present")),1));
				table.addCell(rm.ReportCell(0,Helper.correctNull(rs.getString("exec_recmdnow")),1));
			}
			if(flag==false)
			{
				table.addCell(rm.ReportCellBold(1,"",1,0.0f));
				table.addCell(rm.ReportCellBold(1,"N.A",4));
			}
			
			if(rs != null){
				rs.close();
			}			
			strQuery = SQLParser.getSqlQuery("sel_exec_sanctermsgeneral^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) 
			{
				strSanctionTerms = Helper.correctNull(rs.getString("exec_sanctionterms"));
				table.addCell(rm.ReportCellBold(1,"",1,0.0f));
				table.addCell(rm.ReportCell(0,getSanctionTermsDescription(strSanctionTerms),1));
				table.addCell(rm.ReportCell(0,Helper.correctNull(rs.getString("exec_stipearlier")),1));
				table.addCell(rm.ReportCell(0,Helper.correctNull(rs.getString("exec_present")),1));
				table.addCell(rm.ReportCell(0,Helper.correctNull(rs.getString("exec_recmdnow")),1));
			}
			
			if(rs != null){
				rs.close();
			}
			document.add(table);
			table=null;
			
			table=new Table(3);
			table.setPadding(2.0f);			
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f);
			table.setWidths(wd1);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);			
			
			strQuery = SQLParser.getSqlQuery("sel_exec_signatures^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			StringBuffer sbfsignatories=null;
			StringBuffer sbfgridcomments=null;
			String strMcmResolution="",strDelegatedAuthority="";
			if(rs.next())
			{
				sbfsignatories = new StringBuffer(Helper.correctNull(rs.getString("exec_signatures")));
				sbfgridcomments= new StringBuffer(Helper.correctNull(rs.getString("exec_gridcomments")));
				strMcmResolution = Helper.correctNull(rs.getString("exec_mcmresolution"));
				strDelegatedAuthority = Helper.correctNull(rs.getString("exec_delegated"));
			}
			
			table.addCell(rm.ReportCellBold(1,"35.",1,1,0.0f));
			table.addCell(rm.ReportCellBold(0,"Delegated Authority",2,0.0f));	
			
			table.addCell(rm.ReportCellBold(1," ",1,1,0.0f));
			table.addCell(rm.ReportCell(0,strDelegatedAuthority.trim(),2,0.0f));
					
			table.addCell(rm.ReportCellBold(1,"36.",1,0.0f));
			table.addCell(rm.ReportCellBold(0,"RECOMMENDATIONS",2,0.0f));	
			
			table.addCell(rm.ReportCellBold(1,"36.1.",1,0.0f));
			table.addCell(rm.ReportCellBold(0,"In view of the above we recommend for the Sanction/Renewal/Modification of the following credit limits in favour of M/S "+strcompanyname,2,0.0f));
			
			table.addCell(rm.ReportCellBold(2,"("+ApplicationParams.getCurrency()+" In "+strProposalvalue+")",3,0.0f));
			
			document.add(table);
			table=null;

			/***************************************************************************************************************************
			 * 
			 * FOR WC FUND , WC NON FUND AND TERM LOAN FACILITY TOTAL AMT
			 * 
			 ***************************************************************************************************************************/	

			double wc_funded_existing = 0.00, wc_funded_proposed = 0.00;
			double wc_nonfunded_existing = 0.00, wc_nonfunded_proposed = 0.00;
			double tl_funded_existing = 0.00, tl_funded_proposed = 0.00;
			double tl_total_existing = 0.00, tl_total_proposed = 0.00;
			double total_existing = 0.00, total_proposed = 0.00;

			if (rs != null){
				rs.close();
			}
			rs = DBUtils.executeLAPSQuery("WC_FUNDED_TOTAL^" + strAppno);
			if (rs.next())
			{
				wc_funded_existing = Double.parseDouble(Helper.correctDouble(correctNull((String) rs.getString("WC_FUNDED_EXISTING"))));
				wc_funded_proposed = Double.parseDouble(Helper.correctDouble(correctNull((String) rs.getString("WC_FUNDED_PROPOSED"))));
			}
			if (rs != null) 
			{
				rs.close();
			}

			rs = DBUtils.executeLAPSQuery("WC_NONFUNDED_TOTAL^" + strAppno);
			if (rs.next()) 
			{
				wc_nonfunded_existing = Double.parseDouble(Helper.correctDouble(correctNull((String)rs.getString("WC_NONFUNDED_EXISTING"))));
				wc_nonfunded_proposed = Double.parseDouble(Helper.correctDouble(correctNull((String) rs.getString("WC_NONFUNDED_PROPOSED"))));
			}
			if (rs != null) 
			{
				rs.close();
			}
						
			rs = DBUtils.executeLAPSQuery("TL_FUNDED_TOTAL^" + strAppno);
			if (rs.next()) 
			{
				tl_funded_existing = Double.parseDouble(Helper.correctDouble(correctNull((String)rs.getString("TL_FUNDED_EXISTING"))));
				tl_funded_proposed = Double.parseDouble(Helper.correctDouble(correctNull((String) rs.getString("TL_FUNDED_PROPOSED"))));
			}
			if (rs != null)
			{
				rs.close();
			}
						
			tl_total_existing = tl_funded_existing ;//+ tl_nonfunded_existing;
			tl_total_proposed = tl_funded_proposed ;//+ tl_nonfunded_proposed;

			total_existing = wc_funded_existing + wc_nonfunded_existing + tl_total_existing;
			total_proposed = wc_funded_proposed + wc_nonfunded_proposed	+ tl_total_proposed;


			int[] cellWidths ={7,26,10,10,10,10,27};
			table=new Table(7);
			table.setPadding(2.0f);			
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f);		
			table.setWidths(cellWidths);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			table.addCell(rm.ReportCellBold(1,"",1,2,0.0f));
			table.addCell(rm.ReportCellBold(1,"Nature of Limit",1,2));
			table.addCell(rm.ReportCellBold(1,"Amount",2,1));
			table.addCell(rm.ReportCellBold(1,"Margin (%)",1,2));
			table.addCell(rm.ReportCellBold(1,"Int./ Comm.",1,2));
			table.addCell(rm.ReportCellBold(1,"Security",1,2));
			
			table.addCell(rm.ReportCellBold(1,"Existing",1,1));
			table.addCell(rm.ReportCellBold(1,"Proposed",1,1));
			
			
			
			ArrayList WC_Funded;
			ArrayList OurBank_WC_Funded;
			ArrayList WC_NonFunded;
			ArrayList OurBank_WC_NonFunded;
			ArrayList TL_Funded_NonFunded;
			ArrayList OurBank_TL;
			ArrayList arrSubFac;
			ArrayList arrSecurities;
			//ArrayList arrCol;
			
			
			/***************************************************************************************************************************
			 * 
			 * WC NON FUNDED FACILITY DETAILS WITH SECURITY
			 * 
			 ***************************************************************************************************************************/
			ArrayList arrSecRemarkscol=new ArrayList();
			ArrayList arrSecRemarksrow=new ArrayList();
			OurBank_WC_Funded = new ArrayList();
			OurBank_WC_NonFunded = new ArrayList();
			OurBank_TL = new ArrayList();
						
			if (rs != null) {
				rs.close();
			}

			strQuery = SQLParser.getSqlQuery("com_wc_nonfunded^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				WC_NonFunded = new ArrayList();
				String strFacSno = correctNull((String)rs.getString("facility_sno"));
				WC_NonFunded.add(correctNull(rs.getString("facility_catdesc"))); 		//0
				WC_NonFunded.add(correctNull(rs.getString("facility_existing"))); 		//1
				WC_NonFunded.add(correctNull(rs.getString("facility_proposed"))); 		//2
				WC_NonFunded.add(correctNull(rs.getString("facility_margin"))); 		//3
				WC_NonFunded.add(correctNull(rs.getString("facility_intremarks")));		//4
				WC_NonFunded.add(correctNull(rs.getString("facility_dp")));				//5
				WC_NonFunded.add(correctNull(rs.getString("facility_outstanding")));	//6
				WC_NonFunded.add(correctNull(rs.getString("security_value")));			//7
				WC_NonFunded.add(correctNull(rs.getString("facility_desc")));			//8

				String strfacheadid = correctNull(rs.getString("facility_headid"));
							
				//By Gokul.C for the sub facilities
				arrSubFac = new ArrayList();
				arrSubFac = getSubFacilitiesData(strAppno,strFacSno,"NFD");				

	//9
				WC_NonFunded.add(arrSubFac);
				//end for sub-facilities
				WC_NonFunded.add(correctNull(rs.getString("bplr")));					

	//10
				WC_NonFunded.add(correctNull(rs.getString("facility_intadjustment")));	//11
				WC_NonFunded.add(correctNull(rs.getString("facility_category")));		//12
				WC_NonFunded.add(correctNull(rs.getString("facility_months")));			//13
				WC_NonFunded.add(strfacheadid);							

				//14
								
							
				strQuery = SQLParser.getSqlQuery("selsecuritybyfacility^" + strFacSno + "^" + strAppno);
				rs1 = DBUtils.executeQuery(strQuery);
				arrSecurities=new ArrayList();
				j=0;
				while (rs1.next()) 
				{
					arrCol=new ArrayList();
					arrSecRemarkscol=new ArrayList();
					arrCol.add(correctNull(rs1.getString("sec_desc_details"))); 
					arrCol.add(correctNull(rs1.getString("sec_margin"))); 
					arrSecRemarkscol.add(correctNull(rs1.getString("sec_remarks")));
					arrSecRemarksrow.add(arrSecRemarkscol);
					arrSecurities.add(arrCol);
					j++;
				}
				WC_NonFunded.add(arrSecurities); //15
				WC_NonFunded.add(""+j); //16
							
				OurBank_WC_NonFunded.add(WC_NonFunded);
			}
			
			displayLimitsInRecommendation(document,table,OurBank_WC_NonFunded,"A] NON-FUND BASED LIMITS","Sub- Total [A]",wc_nonfunded_existing,wc_nonfunded_proposed);
			
						
			/***************************************************************************************************************************
			 * 
			 * WC FUNDED FACILITY DETAILS WITH SECURITY
			 * 
			 **************************************************************************************************************************/
						
			if (rs != null) 
			{
				rs.close();
			}
			
			if (rs1 != null) 
			{
				rs1.close();
			}
						
			strQuery = SQLParser.getSqlQuery("com_wc_funded^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) 
			{
				WC_Funded = new ArrayList();
				WC_Funded.add(correctNull(rs.getString("facility_catdesc")));
				WC_Funded.add(correctNull(rs.getString("facility_existing")));
				WC_Funded.add(correctNull(rs.getString("facility_proposed")));
				WC_Funded.add(correctNull(rs.getString("facility_margin")));
				WC_Funded.add(correctNull(rs.getString("facility_intremarks")));
				WC_Funded.add(correctNull(rs.getString("facility_dp")));
				WC_Funded.add(correctNull(rs.getString("facility_outstanding")));
				WC_Funded.add(correctNull(rs.getString("security_value")));
				WC_Funded.add(correctNull(rs.getString("facility_desc")));

				String strFacSno = correctNull((String)rs.getString("facility_sno"));
				arrSubFac = new ArrayList();
				arrSubFac = getSubFacilitiesData(strAppno,strFacSno,"FD");
				WC_Funded.add(arrSubFac);
				WC_Funded.add(correctNull(rs.getString("bplr")));
				WC_Funded.add(correctNull(rs.getString("facility_intadjustment")));
				WC_Funded.add(correctNull(rs.getString("facility_category")));
				WC_Funded.add(correctNull(rs.getString("facility_months")));
				WC_Funded.add(correctNull(rs.getString("facility_headid")));

				strQuery = SQLParser.getSqlQuery("selsecuritybyfacility^" +  strFacSno + "^" + strAppno);
				rs1 = DBUtils.executeQuery(strQuery);
				arrSecurities=new ArrayList();
				j=0;
				while (rs1.next()) 
				{
					arrCol=new ArrayList();
					arrSecRemarkscol=new ArrayList();
					arrCol.add(correctNull(rs1.getString("sec_desc_details"))); 
					arrCol.add(correctNull(rs1.getString("sec_margin")));
					arrSecRemarkscol.add(correctNull(rs1.getString("sec_remarks")));
					arrSecRemarksrow.add(arrSecRemarkscol);
					arrSecurities.add(arrCol);
					j++;
				}
				WC_Funded.add(arrSecurities);
				WC_Funded.add(""+j);
				OurBank_WC_Funded.add(WC_Funded);
			}

			//displayLimitsInRecommendation(document,table,OurBank_WC_Funded,"B] FUND BASED LIMITS","Sub- Total[B]",wc_funded_existing,wc_funded_proposed);
			displayLimitsInRecommendation(document,table,OurBank_WC_Funded,"B] FUND BASED LIMITS","Sub- Total[B]",wc_funded_existing,wc_funded_proposed);
						
			/***************************************************************************************************************************
			 * 
			 * TL FUNDED & NON FUNDED FACILITY DETAILS WITH SECURITY
			 * 
			 **************************************************************************************************************************/

			if (rs != null)
			{
				rs.close();
			}
			
			if (rs1 != null)
			{
				rs1.close();
			}

			strQuery = SQLParser.getSqlQuery("com_tl_funded_nonfunded^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) 
			{
				TL_Funded_NonFunded = new ArrayList();
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_catdesc")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_existing")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_proposed")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_margin")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_intremarks")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_dp")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_outstanding")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("security_value")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_desc")));

				String strFacSno = correctNull((String)rs.getString("facility_sno"));				

			
				arrSubFac = new ArrayList();							
				arrSubFac = getSubFacilitiesData(strAppno,strFacSno,"TL");
							
				TL_Funded_NonFunded.add(arrSubFac);
				TL_Funded_NonFunded.add(correctNull(rs.getString("bplr")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_intadjustment")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_category")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_months")));
				TL_Funded_NonFunded.add(correctNull(rs.getString("facility_headid")));

				strQuery = SQLParser.getSqlQuery("selsecuritybyfacility^" + strFacSno + "^" +  strAppno);
				rs1 = DBUtils.executeQuery(strQuery);
				arrSecurities=new ArrayList();
				j=0;
				while (rs1.next()) 
				{
					arrCol=new ArrayList();
					arrSecRemarkscol=new ArrayList();
					arrCol.add(correctNull(rs1.getString("sec_desc_details"))); 
					arrCol.add(correctNull(rs1.getString("sec_margin"))); 
					arrSecRemarkscol.add(correctNull(rs1.getString("sec_remarks")));
					arrSecRemarksrow.add(arrSecRemarkscol);
					arrSecurities.add(arrCol);
					j++;
				}
				
				TL_Funded_NonFunded.add(arrSecurities);
				TL_Funded_NonFunded.add(""+j);
				OurBank_TL.add(TL_Funded_NonFunded);
			}
			displayLimitsInRecommendation(document,table,OurBank_TL,"C] TERM LOAN / DPGL","Sub- Total[C]",tl_total_existing,tl_total_proposed);
			
			if (rs != null)
			{
				rs.close();
			}
			
			if (rs1 != null)
			{
				rs1.close();
			}
			
			table.addCell(rm.ReportCellBold(1,"",1,0.0f));
			table.addCell(rm.ReportCellBold(0,"TOTAL [A+B+C]",1,1));
			table.addCell(rm.ReportCellBold(2,Helper.formatDoubleValue(total_existing),1,1));
			table.addCell(rm.ReportCellBold(2,Helper.formatDoubleValue(total_proposed),1,1));
			table.addCell(rm.ReportCellBold(0," ",1,1));
			table.addCell(rm.ReportCellBold(0," ",1,1));
			table.addCell(rm.ReportCellBold(0," ",1,1));
			
			document.add(table);
			table=null;
			
			
			//END OF MURALI

//			Terms 
			int[] widfin={7,93};
			table=new Table(2);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100); 
			table.setWidths(widfin);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			table.setAlignment(0);
			table.addCell(rm.ReportCellBold(0,"36.2.",1,0.0f));
			table.addCell(rm.ReportCellBold(0,"TERMS AND CONDITIONS",1,0.0f));
			
			strQuery = SQLParser.getSqlQuery("seltermsandconditionval^" + strAppno);
			int i=0;
			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				i++;
				table.addCell(rm.ReportCell(2,Integer.toString(i)+".",1,0.0f));
				table.addCell(rm.ReportCell(0," "+rs.getString("terms_termdesc"),1,0.0f));
			}
			document.add(table);
			table=null;

			table=new Table(2);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100); 
			table.setWidths(widfin);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			table.setAlignment(0);
			
			table.addCell(rm.ReportCell(2,"",1,0.0f));
			table.addCell(rm.ReportCell(0,"Submitted for Approval",1,0.0f));
			
			if(rs!=null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("sel_exec_signatures^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			StringBuffer sbfsignatories1=null;
			StringBuffer sbfgridcomments1=null;
			if(rs.next())
			{
				sbfsignatories1 = new StringBuffer(correctNull(rs.getString("exec_signatures")));
				sbfgridcomments1= new StringBuffer(correctNull(rs.getString("exec_gridcomments")));
				table.addCell(rm.ReportCell(2,"",1,0.0f));
				table.addCell(rm.ReportCellBold(0,"Resolution",1,0.0f));
				table.addCell(rm.ReportCell(2,"",1,0.0f));
				table.addCell(rm.ReportCellBold(0,"If approved, the MANAGEMENT COMMITTEE is requested to adopt the following resolution. ",1,0.0f));
				table.addCell(rm.ReportCell(2,"",1,0.0f));
				table.addCell(rm.ReportCell(0,correctNull(rs.getString("exec_mcmresolution")),1,0.0f));
				table.addCell(rm.ReportCell(2,"\n",2,0.0f));
			}
			
			if(sbfsignatories1!=null)
			{
				for (i = 0;i < sbfsignatories1.length(); i++) {
					if (sbfsignatories1.charAt(i) == '\n') {
						sbfsignatories1.replace(i, i + 1, "<br>");
					}
					if (sbfsignatories1.charAt(i) == ' ') {
						sbfsignatories1.replace(i, i + 1, "&nbsp;");
					}
				}
				table.addCell(rm.ReportCell(2,"",1,0.0f));
				table.addCell(rm.ReportCellBold(0,sbfsignatories1.toString(),1,0.0f));
			}
			j=0;
			if(sbfgridcomments1!=null)
			{
				for (i = 0,  j=0;i < sbfgridcomments1.length(); i++) 
				{
					if (sbfgridcomments1.charAt(i) == '\n') {
						sbfgridcomments1.replace(i, i + 1, "<br>");
						j++;
					}
					if (j>1 && sbfgridcomments1.charAt(i) == ' ') {
						sbfgridcomments1.replace(i, i + 1, "&nbsp;");
					}
				}
				table.addCell(rm.ReportCell(2,"",1,0.0f));
				table.addCell(rm.ReportCell(0,sbfgridcomments1.toString(),1,0.0f));
			}
			
			document.add(table);
			table=null;
			
			ReportGenerator.drawPDF(hshValues);
			table=null; cell=null;
			
		}
		catch (Exception e) {
			// TODO: handle exception
		}
	return hshValues;	
		
	}

	
	
	/**
	 * Method to get the Constitution Name by Code
	 * @param strConstitutionCode
	 * @return
	 */
	private String getConstitution(String strConstitutionCode){
				
		String strConstitution="";
		if(strConstitutionCode.equalsIgnoreCase("IN"))//Individual
		{
			strConstitution="Individual";
		}
		else if(strConstitutionCode.equalsIgnoreCase("OLP"))//PVT LTD COMPANY
		{
			strConstitution="Private Limited Company";
		}
		else if(strConstitutionCode.equalsIgnoreCase("OCC"))//PUBLIC LTD COMPANY
		{
			strConstitution="Public Limited Company";
		}
		else if(strConstitutionCode.equalsIgnoreCase("OP"))//PARTNER SHIP
		{
			strConstitution="Partnership";
		}
		else if(strConstitutionCode.equalsIgnoreCase("OLC"))//Joint Borrowers
		{
			strConstitution="Joint Borrowers";
		}
		else if(strConstitutionCode.equalsIgnoreCase("OS"))//Sole Proprietor
		{
			strConstitution="Sole Proprietor";
		}
		else if(strConstitutionCode.equalsIgnoreCase("Jo"))//Joint Venture
		{
			strConstitution="Joint Venture";
		}
		else if(strConstitutionCode.equalsIgnoreCase("sub"))//Wholly owned subsidiary
		{
			strConstitution="Wholly owned subsidiary";
		}
		else if(strConstitutionCode.equalsIgnoreCase("TR"))//Trusts
		{
			strConstitution="Trusts";
		}
		else if(strConstitutionCode.equalsIgnoreCase("AC"))//Association
		{
			strConstitution="Association";
		}
		else if(strConstitutionCode.equalsIgnoreCase("nbfc"))//NBFC
		{
			strConstitution="NBFC";
		}
		else if(strConstitutionCode.equalsIgnoreCase("HUF"))//HUF
		{
			strConstitution="H.U.F";
		}
		else if(strConstitutionCode.equalsIgnoreCase("OO"))//Others
		{
			strConstitution="Others";
		}
		return strConstitution;
	}
	
	/**
	 * @author Muralidharan R
	 * Method to get the Sanction Terms Description by Code
	 * @param strSanctionTermsCode
	 * @return
	 */
	private String getSanctionTermsDescription(String strSanctionTermsCode){
		String strstrSanctionTermsDesc;
		if (strSanctionTermsCode.equalsIgnoreCase("pc")){
			strstrSanctionTermsDesc = "Processing charges";
		}else if (strSanctionTermsCode.equalsIgnoreCase("ps")){
			strstrSanctionTermsDesc = "Primary security (give details)";
		}else if (strSanctionTermsCode.equalsIgnoreCase("cs")){
			strstrSanctionTermsDesc = "Collateral security (give details)";
		}else if (strSanctionTermsCode.equalsIgnoreCase("pcg")){
			strstrSanctionTermsDesc = "Personal /Corporate guarantees(Name/means/TNW)";
		}else if (strSanctionTermsCode.equalsIgnoreCase("roi")){
			strstrSanctionTermsDesc = "Rate of Interest(fixed or floating)";
		}else if (strSanctionTermsCode.equalsIgnoreCase("mar")){
			strstrSanctionTermsDesc = "Margin(%)";
		}else if (strSanctionTermsCode.equalsIgnoreCase("lclg")){
			strstrSanctionTermsDesc = "Commission for L/c,LG,DPGL(%)";
		}else if (strSanctionTermsCode.equalsIgnoreCase("remit")){
			strstrSanctionTermsDesc = "Commission on remittances and other services(please specify)";
		}else if (strSanctionTermsCode.equalsIgnoreCase("othr")){
			strstrSanctionTermsDesc = "Other Matters";
		}else{
			strstrSanctionTermsDesc = "";
		}
		return strstrSanctionTermsDesc;
	}
	
	/**
	 * Method to get the sub facilities under each major facility
	 * Added by gokulakrishnan.c
	 */	
		private ArrayList getSubFacilitiesData(String strAppno, String strFacSno, String strType) throws Exception{
			ArrayList arrSubFac = new ArrayList();
			ArrayList arrSubFacRecords = new ArrayList();
			String strQuery="";
			ResultSet rs =null;
			ResultSet rs1=null;
			String strsubfacsno="";
			try{
				if(strType.trim().equalsIgnoreCase("TL"))
					strQuery = SQLParser.getSqlQuery("com_subfac^"+strAppno+"^"+strFacSno);
				else if(strType.trim().equalsIgnoreCase("FD"))
					strQuery = SQLParser.getSqlQuery("com_subfac^"+strAppno+"^"+strFacSno);
				else if(strType.trim().equalsIgnoreCase("NFD"))
					strQuery = SQLParser.getSqlQuery("com_subfac^"+strAppno+"^"+strFacSno);
				
				else if(strType.trim().equalsIgnoreCase("stl_TL"))
					strQuery = SQLParser.getSqlQuery("com_subfac_stl^"+strAppno+"^"+strFacSno);
				else if(strType.trim().equalsIgnoreCase("stl_FD"))
					strQuery = SQLParser.getSqlQuery("com_subfac_stl^"+strAppno+"^"+strFacSno);
				else if(strType.trim().equalsIgnoreCase("stl_NFD"))
					strQuery = SQLParser.getSqlQuery("com_subfac_stl^"+strAppno+"^"+strFacSno);
				
				else if(strType.trim().equalsIgnoreCase("existstl_TL"))
					strQuery = SQLParser.getSqlQuery("com_subfac_existing_stl^"+strAppno+"^"+strFacSno);
				else if(strType.trim().equalsIgnoreCase("existstl_FD"))
					strQuery = SQLParser.getSqlQuery("com_subfac_existing_stl^"+strAppno+"^"+strFacSno);
				else if(strType.trim().equalsIgnoreCase("existstl_NFD"))
					strQuery = SQLParser.getSqlQuery("com_subfac_existing_stl^"+strAppno+"^"+strFacSno);
				
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next()){
					//int d2b = 0;
					arrSubFacRecords = new ArrayList();
					arrSubFacRecords.add(correctNull(rs.getString("facility_catdesc")));//0
					arrSubFacRecords.add(correctNull(rs.getString("facility_existing")));//1
					arrSubFacRecords.add(correctNull(rs.getString("facility_proposed")));//2
					arrSubFacRecords.add(correctNull(rs.getString("facility_margin")));//3
					arrSubFacRecords.add(correctNull(rs.getString("facility_intremarks")));//4
					arrSubFacRecords.add(correctNull(rs.getString("facility_dp")));//5
					arrSubFacRecords.add(correctNull(rs.getString("facility_outstanding")));//6
					arrSubFacRecords.add(correctNull(rs.getString("security_value")));//7
					arrSubFacRecords.add(correctNull(rs.getString("facility_desc")));//8
					arrSubFacRecords.add(correctNull(rs.getString("bplr")));//9
					arrSubFacRecords.add(correctNull(rs.getString("facility_intadjustment")));//10
					arrSubFacRecords.add(correctNull(rs.getString("facility_category")));//11
					arrSubFacRecords.add(correctNull(rs.getString("facility_months")));//12
					arrSubFacRecords.add(correctNull(rs.getString("facility_headid")));//13
					strsubfacsno=correctNull(rs.getString("facility_sno"));
					
					strQuery = SQLParser.getSqlQuery("selsecuritybyfacility^" +  strsubfacsno
							+ "^" + strAppno);
					rs1 = DBUtils.executeQuery(strQuery);
					ArrayList arrSecurities=new ArrayList();
					int j=0;
					while (rs1.next()) {
						ArrayList arrCol=new ArrayList();
						arrCol.add(correctNull(rs1.getString("sec_desc_details"))); 
						arrCol.add(correctNull(rs1.getString("sec_margin")));
						arrSecurities.add(arrCol);
						j++;
					}
					if (rs1 != null){
						rs1.close();
					}
					arrSubFacRecords.add(arrSecurities);//14
					arrSubFacRecords.add(""+j);//15
					/*String strfacheadid = correctNull(rs.getString("facility_headid"));
					String strfacsubid = correctNull(rs.getString("facility_id"));
					
					//By venu for the sublimit security
					strQuery = SQLParser.getSqlQuery("secfacilitywise^" + strAppno
							+ "^" + strfacheadid + "^" + strfacsubid);
					rs1 = DBUtils.executeQuery(strQuery);
					if (rs1.next()) {
						String strVal = correctNull(rs1.getString(1));

						strQuery = SQLParser.getSqlQuery("propfacmastersel1^"
								+ strVal);
						if (rs1 != null)
							rs1.close();
						rs1 = DBUtils.executeQuery(strQuery);
						while (rs1.next()) {
							String secdetails = correctNull(rs1.getString(3));
							if (!secdetails.equalsIgnoreCase("")) {
								d2b = d2b + 1;
								arrSubFacRecords.add(correctNull(rs1.getString(3)));
							}
						}

						if (d2b == 0) {
							for (int d3b = 1; d3b <= d2b; d3b++) {
								arrSubFacRecords.add("");
							}
						}

					}
					int valsecol = d2b;
					String valfacstrseccol = Integer.toString(valsecol);
					arrSubFacRecords.add((valfacstrseccol));
//		 Don't add additional field here
					//end of sublimit security*/
							
					arrSubFac.add(arrSubFacRecords);
				}
			}catch(Exception e)
			{
				log.error("Exception in getSubFacilitiesData of ExcutiveSummaryBean "+e.getMessage());
			}finally{
				try{
					if(rs!=null){
						rs.close();
					}
					if (rs1 != null){
						rs1.close();
					}
				}catch(Exception ce)
				{
					log.error("Exception in closing connection in getSubFacilitiesData of ExcutiveSummaryBean"+ce.getMessage());
				}
			}
			return arrSubFac;
		}
	
	
	/**
	 * @author Muralidharan R
	 * @param document
	 * @param arrLimitRecords
	 * @param strLimitHeading
	 * @param strTotalLable
	 * @param dblExistiingTotal
	 * @param dblProposedTotal
	 * @throws Exception
	 */
	private void displayLimitsInRecommendation(Document document,Table table,ArrayList arrLimitRecords, String strLimitHeading, String strTotalLable, double dblExistiingTotal, double dblProposedTotal) throws Exception 
	{
		ReportManager rm = new ReportManager();
		ArrayList arrLimitData, arrSubFacilityRecords,arrSubFacilityData,arrSecurities;
		int intLimitsSize = 0, introwspan = 0,intsubrowspan = 0,j = 0;
		String chkCategory="",chkCategory1="";
		
		try{
			
			/*int[] cellWidths={30,10,10,10,10,30};
			table=new Table(6);
			table.setPadding(2.0f);			
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f);		
			table.setWidths(cellWidths);
			table.setCellsFitPage(false);
			table.setTableFitsPage(true);*/
			
			table.addCell(rm.ReportCellBold(1,"",1,0.0f));
			table.addCell(rm.ReportCellBold(0,strLimitHeading,6));
			
			if (arrLimitRecords != null) {
				intLimitsSize = arrLimitRecords.size();
			}	
			
			for (int i = 0; i < intLimitsSize; i++) {
				arrLimitData = (ArrayList) arrLimitRecords.get(i);
				
				chkCategory = Helper.correctNull((String) arrLimitData.get(12));
				if (chkCategory.equals("A")) {
					chkCategory1 = "\n (Adhoc Limit for "+ Helper.correctNull((String) arrLimitData.get(13))+ " Month ) ";
				} else {
					chkCategory1 = "";
				}
				introwspan = Integer.parseInt(Helper.correctInt((String) arrLimitData.get(16)));
				
				if(introwspan == 0)
				{
					introwspan = 1;
				}
				table.addCell(rm.ReportCellBold(1,"",1,0.0f));
				table.addCell(rm.ReportCell(0,Helper.correctNull((String) arrLimitData.get(0))+" "+chkCategory1,1,introwspan));
				table.addCell(rm.ReportCell(2,Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrLimitData.get(1)))),1,introwspan));
				table.addCell(rm.ReportCell(2,Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrLimitData.get(2)))),1,introwspan));
				
				arrSecurities = new ArrayList();
				arrSecurities = (ArrayList) arrLimitData.get(15);
				if (arrSecurities != null && arrSecurities.size() > 0) {
					for (j = 0; j < arrSecurities.size(); j++) {
						ArrayList arrSecurity = new ArrayList();
						arrSecurity = (ArrayList) arrSecurities.get(j);
						
						if (j == 0) {
							table.addCell(rm.ReportCell(2,Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSecurity.get(1)))),1,1));
							table.addCell(rm.ReportCell(0,Helper.correctNull((String) arrLimitData.get(4)),1,introwspan));
							table.addCell(rm.ReportCell(0,Helper.correctNull((String) arrSecurity.get(0)),1,1));
						}else{
							table.addCell(rm.ReportCellBold(1,"",1,0.0f));
							table.addCell(rm.ReportCell(2,Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSecurity.get(1)))),1,1));
							table.addCell(rm.ReportCell(0,Helper.correctNull((String) arrSecurity.get(0)),1,1));
						}
					}
				}else{
					table.addCell(rm.ReportCell(2,Helper.correctDouble((String) arrLimitData.get(3)),1,1));
					table.addCell(rm.ReportCell(0,Helper.correctNull((String) arrLimitData.get(4)),1,introwspan));
					table.addCell(rm.ReportCell(0," ",1,1));
				}
				
				// For the Sub-limits, under each one
				arrSubFacilityRecords = new ArrayList();
				arrSubFacilityRecords = (ArrayList) arrLimitData.get(9);
				int intSubFaclitySize = arrSubFacilityRecords.size();
				if (arrSubFacilityRecords != null && intSubFaclitySize > 0) {
					for (j = 0; j < intSubFaclitySize; j++) {
						arrSubFacilityData = new ArrayList();
						arrSubFacilityData = (ArrayList) arrSubFacilityRecords.get(j);

						chkCategory = Helper.correctNull((String) arrSubFacilityData.get(11));
						if (chkCategory.equals("A")) {
							chkCategory1 = "<br>(Adhoc Limit for "+ Helper.correctNull((String) arrSubFacilityData.get(12)) + " Month) ";
						} else {
							chkCategory1 = "";
						}
						intsubrowspan = Integer.parseInt(Helper.correctInt((String) arrSubFacilityData.get(15)));
						
						if(intsubrowspan == 0){
							intsubrowspan = 1;
						}
						
						if (j == 0) {
							table.addCell(rm.ReportCellBold(1,"",1,0.0f));
							table.addCell(rm.ReportCellBold(0," >> Sub-Limit",6));
						}
						table.addCell(rm.ReportCellBold(1,"",1,0.0f));
						table.addCell(rm.ReportCell(0,Helper.correctNull((String) arrSubFacilityData.get(0))+" "+chkCategory1,1,intsubrowspan));
						table.addCell(rm.ReportCell(2,Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSubFacilityData.get(1)))),1,intsubrowspan));
						table.addCell(rm.ReportCell(2,Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSubFacilityData.get(2)))),1,intsubrowspan));
						
						arrSecurities = new ArrayList();
						arrSecurities = (ArrayList) arrSubFacilityData.get(14);
						if (arrSecurities != null && arrSecurities.size() > 0) {
							for (int k = 0; k < arrSecurities.size(); k++) {
								ArrayList arrSecurity = new ArrayList();
								arrSecurity = (ArrayList) arrSecurities.get(k);
								
								if (k == 0) {
									table.addCell(rm.ReportCell(2,Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSecurity.get(1)))),1,1));
									table.addCell(rm.ReportCell(0,Helper.correctNull((String) arrSubFacilityData.get(4)),1,intsubrowspan));
									table.addCell(rm.ReportCell(0,Helper.correctNull((String) arrSecurity.get(0)),1,1));
								}else{
									table.addCell(rm.ReportCellBold(1,"",1,0.0f));
									table.addCell(rm.ReportCell(2,Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrSecurity.get(1)))),1,1));
									table.addCell(rm.ReportCell(0,Helper.correctNull((String) arrSecurity.get(0)),1,1));
								}
							}
						}else{
							table.addCell(rm.ReportCell(2,Helper.correctDouble((String) arrSubFacilityData.get(3)),1,1));
							table.addCell(rm.ReportCell(0,Helper.correctNull((String) arrSubFacilityData.get(4)),1,intsubrowspan));
							table.addCell(rm.ReportCell(0," ",1,1));
						}						
					}
				}				
			}
			table.addCell(rm.ReportCellBold(1,"",1,0.0f));
			table.addCell(rm.ReportCellBold(0,strTotalLable,1,1));
			table.addCell(rm.ReportCellBold(2,Helper.formatDoubleValue(dblExistiingTotal),1,1));
			table.addCell(rm.ReportCellBold(2,Helper.formatDoubleValue(dblProposedTotal),1,1));
			table.addCell(rm.ReportCellBold(0," ",1,1));
			table.addCell(rm.ReportCellBold(0," ",1,1));
			table.addCell(rm.ReportCellBold(0," ",1,1));
			
		
		}catch(Exception e){
			log.error("Exception in displayLimitsInRecommendation of ExcutiveSummaryBean "+e.getMessage());
		}
	}
	
	/**
	 * @author SUBHARANI P
	 * @param document
	 * @param strAppno
	 * @param strcompanyname
	 * @param strauditnotes
	 * @throws Exception
	 */
	private void displayComments1(Document document,String strAppno,String strcompanyname,String strauditnotes) throws Exception 
	{
		Cell cell=null;
		Table table=null;
		ResultSet rs = null,rs1=null;
		String strQuery="";
		try
		{
			ReportManager rm = new ReportManager();
			
			int[] wd2={7,50,43};
			table=new Table(3);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f);
			table.setWidths(wd2);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			table.addCell(rm.ReportCellBold(1,"14.1.",1,0.0f));				
			table.addCell(rm.ReportCellBold(0,"CASH FLOW",2,0.0f));
			
			table.addCell(rm.ReportCellBold(1,"",1,0.0f));				
			table.addCell(rm.ReportCellBold(0,"Company Name : "+strcompanyname,2,0.0f));
			
			if (rs1 != null) {
				rs1 = null;
			}
			String strcashflowcmds="";
			rs1 = DBUtils.executeLAPSQuery("executive_finnotes_sel^" + strAppno+ "^" + "CA" + "^" + "0");
			if (rs1.next())
			{
				if(!correctNull((String)rs1.getString("notes")).equalsIgnoreCase(""))
				{
					strcashflowcmds=correctNull(Helper.CLOBToString(rs1.getClob("notes")));
				}
				else
				{
					strcashflowcmds="";
				}
			}
			
			table.addCell(rm.ReportCellBold(1,"14.1.1",1,0.0f));				
			table.addCell(rm.ReportCellBold(0,"COMMENTS ON FINANCIAL INDICATORS ON CASH BASIS:",2,0.0f));
			
			table.addCell(rm.ReportCellBold(1,"",3,0.0f));
			if(!strcashflowcmds.equalsIgnoreCase(""))
			{
				document.add(table);
				document=ReportGenerator.getParsingHTML(strcashflowcmds, document);
			}
			else
			{
				table.addCell(rm.ReportCellFontColorWhite9(0,".",3,0.0f));
				document.add(table);
			}
			
			table=null;
			
			table=new Table(3);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f);
			table.setWidths(wd2);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			table.addCell(rm.ReportCellBold(1,"14.2.",1,0.0f));	
			table.addCell(rm.ReportCellBold(0,"AUDIT NOTES IN BALANCE SHEET IF ANY, TO BE SPECIFIED",2,0.0f));
			
			table.addCell(rm.ReportCellBold(1,"",3,0.0f));	
			if(!strcashflowcmds.equalsIgnoreCase(""))
			{
				document.add(table);
				document=ReportGenerator.getParsingHTML(strauditnotes, document);
			}
			else
			{
				table.addCell(rm.ReportCellFontColorWhite9(0,".",3,0.0f));
				document.add(table);
			}
			
			table=null;
			
			table=new Table(3);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f);
			table.setWidths(wd2);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			String strmagmt="";
			String strindustry="";
			String strbussinessrisk="";
			strQuery = SQLParser.getSqlQuery("execsel_summary^" + strAppno);

			if (rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				strmagmt=correctNull(Helper.CLOBToString(rs.getClob("EXEC_EVAL_MAGMT")));
				strindustry=correctNull(Helper.CLOBToString(rs.getClob("EXEC_EVAL_INDUSTRY")));
				strbussinessrisk=correctNull(Helper.CLOBToString(rs.getClob("EXEC_EVAL_BUSSINESSRISK")));

			}
			
			table.addCell(rm.ReportCellBold(1,"15.",1,0.0f));				
			table.addCell(rm.ReportCellBold(0,"EVALUATION OF MANAGEMENT",2,0.0f));
			
			table.addCell(rm.ReportCellBold(1,"",3,0.0f));
			if(!strcashflowcmds.equalsIgnoreCase(""))
			{
				document.add(table);
				document=ReportGenerator.getParsingHTML(strmagmt, document);
			}
			else
			{
				table.addCell(rm.ReportCellFontColorWhite9(0,".",3,0.0f));
				document.add(table);
			}
			
			table=null;
			
			table=new Table(3);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f);
			table.setWidths(wd2);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			table.addCell(rm.ReportCellBold(1,"16.",1,0.0f));				
			table.addCell(rm.ReportCellBold(0,"EVALUATION OF INDUSTRY",2,0.0f));
			
			table.addCell(rm.ReportCellBold(1,"",3,0.0f));			
			if(!strcashflowcmds.equalsIgnoreCase(""))
			{
				document.add(table);
				document=ReportGenerator.getParsingHTML(strindustry, document);
			}
			else
			{
				table.addCell(rm.ReportCellFontColorWhite9(0,".",3,0.0f));
				document.add(table);
			}
			
			table=null;
			
			table=new Table(3);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f);
			table.setWidths(wd2);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			table.addCell(rm.ReportCellBold(1,"17.",1,0.0f));				
			table.addCell(rm.ReportCellBold(0,"EVALUATION OF BUSINESS RISK",2,0.0f));
			
			table.addCell(rm.ReportCellBold(1,"",3,0.0f));		
			if(!strcashflowcmds.equalsIgnoreCase(""))
			{
				document.add(table);
				document=ReportGenerator.getParsingHTML(strbussinessrisk, document);
			}
			else
			{
				table.addCell(rm.ReportCellFontColorWhite9(0,".",3,0.0f));
				document.add(table);
			}
			
			table=null;
		}
		catch(Exception e){
			log.error("Exception in displayComments1 of ExcutiveSummaryBean "+e.getMessage());
		}
	}
	
	/**
	 * @author SUBHARANI P
	 * @param document
	 * @param strAppno
	 * @param strcompanyname
	 * @param strauditnotes
	 * @throws Exception
	 */
	private void displayComments2(Document document,String strAppno,String strcompanyname,String strauditnotes,String strProposalvalue,String strconsortiumassessment,String strOtherMatters) throws Exception 
	{
		Cell cell=null;
		Table table=null;
		ResultSet rs = null,rs1=null;
		String strQuery="";
		try
		{
			ReportManager rm = new ReportManager();
			
			int[] wd2={7,50,43};
			table=new Table(3);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f);
			table.setWidths(wd2);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			table.addCell(rm.ReportCellBold(1,"28.",1,0.0f));				
			table.addCell(rm.ReportCellBold(0,"COMMENTS ON ASSESSMENT OF LIMITS",2,1,0.0f));
			
			table.addCell(rm.ReportCellBold(1,"28.1.",1,0.0f));				
			table.addCell(rm.ReportCellBold(0,"PROJECTED LEVEL OF SALES",2,0.0f));
			strQuery = SQLParser.getSqlQuery("sel_projectedsales^" + strAppno);//Projected of Sales
			if(rs!=null)rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				document.add(table);
				document=ReportGenerator.getParsingHTML(correctNull(Helper.CLOBToString(rs.getClob("com_projectedsales_comments"))), document);
			}else{
				table.addCell(rm.ReportCell(0,"",3,0.0f));
				document.add(table);
			}			
			
			table=null;
			
			table=new Table(3);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f);
			table.setWidths(wd2);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			table.addCell(rm.ReportCellBold(1,"28.2.",1,0.0f));				
			table.addCell(rm.ReportCellBold(0,"INVENTORY & RECEIVABLE NORMS",2,0.0f));
							
			table.addCell(rm.ReportCellBold(0,"",1,0.0f));
			table.addCell(rm.ReportCellBold(0,"COMMENTS ON HOLDING LEVELS",2,0.0f));
			strQuery = SQLParser.getSqlQuery("sel_holdinglevel^" + strAppno);//Holding Levels
			if(rs!=null)rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()){
				document.add(table);
				document=ReportGenerator.getParsingHTML(Helper.correctNull(Helper.CLOBToString(rs.getClob("com_holdinglevel_comments"))), document);
			}else{
				table.addCell(rm.ReportCell(0,"",3,0.0f));
				document.add(table);
			}
			
			table=null;
			
			table=new Table(3);
			table.setPadding(1.0f);
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f);
			table.setWidths(wd2);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			table.addCell(rm.ReportCellBold(1,"28.3.",1,0.0f));				
			table.addCell(rm.ReportCellBold(0,"WORKING CAPITAL ASSESSMENT",2,0.0f));
			
			document.add(table);
			table=null;
			
			// For Assessment type 
 			String assessment_type="";
 			strQuery = SQLParser.getSqlQuery("sel_assessmenttype^"+strAppno);
 			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				assessment_type = correctNull((String)rs.getString("com_assessmenttype"));
			}
			if(rs!=null){
				rs.close();
			}
			// This Condition is for Turn Over Methord,Flexible Bank Finance,NBFC1,NBFC2
			if(!(assessment_type.equalsIgnoreCase("CBM")))
			{
				int intYearCount=0;
				int intCount=0;
				strQuery=SQLParser.getSqlQuery("selfinassessvalues^"+strAppno+"^0");
				rs=DBUtils.executeQuery(strQuery);
				
				ArrayList arrRowAssessment=new ArrayList();
				ArrayList arrColAssessment;
				while(rs.next())
				{					
					arrColAssessment=new ArrayList();
					if(intCount < 1){						
						if(!Helper.correctNull(rs.getString("finassess_year1")).equals("")){
							intYearCount++;
						}
						if(!Helper.correctNull(rs.getString("finassess_year2")).equals("")){
							intYearCount++;
						}
						if(!Helper.correctNull(rs.getString("finassess_year3")).equals("")){
							intYearCount++;
						}
						if(!Helper.correctNull(rs.getString("finassess_year4")).equals("")){
							intYearCount++;
						}
						if(!Helper.correctNull(rs.getString("finassess_year5")).equals("")){
							intYearCount++;
						}
					}
					arrColAssessment.add(Helper.correctNull(rs.getString("finassess_rowdesc")));
					arrColAssessment.add(Helper.correctNull(rs.getString("finassess_year1")));
					arrColAssessment.add(Helper.correctNull(rs.getString("finassess_year2")));
					arrColAssessment.add(Helper.correctNull(rs.getString("finassess_year3")));
					arrColAssessment.add(Helper.correctNull(rs.getString("finassess_year4")));
					arrColAssessment.add(Helper.correctNull(rs.getString("finassess_year5")));					
					arrRowAssessment.add(arrColAssessment);
					intCount++;
				}

				if(intYearCount > 0){
					table=new Table(intYearCount+2);
					table.setPadding(2.0f);
					table.setBorderWidth(0.0f);
					table.setAutoFillEmptyCells(true);
					table.setWidth(100.0f);
					table.setBorder(0);
					table.setCellsFitPage(true);
					table.setTableFitsPage(true);
					
					for(int i=0; i<arrRowAssessment.size(); i++){
						arrColAssessment = new ArrayList();
						arrColAssessment = (ArrayList) arrRowAssessment.get(i);		
						if (i < 2) {
							table.addCell(rm.ReportCellBold(1,"",1,0.0f));	
							table.addCell(rm.ReportCellBold(1,Helper.removeHTMLTags((String) arrColAssessment.get(0)).toString(),1,1));
							if(!Helper.correctNull((String) arrColAssessment.get(1)).equals("")){
								table.addCell(rm.ReportCellBold(1,Helper.correctNull((String) arrColAssessment.get(1)),1,1));
							}
							if(!Helper.correctNull((String) arrColAssessment.get(2)).equals("")){
								table.addCell(rm.ReportCellBold(1,Helper.correctNull((String) arrColAssessment.get(2)),1,1));
							}
							if(!Helper.correctNull((String) arrColAssessment.get(3)).equals("")){
								table.addCell(rm.ReportCellBold(1,Helper.correctNull((String) arrColAssessment.get(3)),1,1));
							}
							if(!Helper.correctNull((String) arrColAssessment.get(4)).equals("")){
								table.addCell(rm.ReportCellBold(1,Helper.correctNull((String) arrColAssessment.get(4)),1,1));
							}
							if(!Helper.correctNull((String) arrColAssessment.get(5)).equals("")){
								table.addCell(rm.ReportCellBold(1,Helper.correctNull((String) arrColAssessment.get(5)),1,1));
							}
						}else{
							table.addCell(rm.ReportCellBold(1,"",1,0.0f));
							table.addCell(rm.ReportCell(0,Helper.correctNull((String) arrColAssessment.get(0)),1));
							if(!Helper.correctNull((String) arrColAssessment.get(1)).equals("")){
								table.addCell(rm.ReportCell(2,Helper.correctDouble((String) arrColAssessment.get(1)),1));
							}
							if(!Helper.correctNull((String) arrColAssessment.get(2)).equals("")){
								table.addCell(rm.ReportCell(2,Helper.correctDouble((String) arrColAssessment.get(2)),1));
							}
							if(!Helper.correctNull((String) arrColAssessment.get(3)).equals("")){
								table.addCell(rm.ReportCell(2,Helper.correctDouble((String) arrColAssessment.get(3)),1));
							}
							if(!Helper.correctNull((String) arrColAssessment.get(4)).equals("")){
								table.addCell(rm.ReportCell(2,Helper.correctDouble((String) arrColAssessment.get(4)),1));
							}
							if(!Helper.correctNull((String) arrColAssessment.get(5)).equals("")){
								table.addCell(rm.ReportCell(2,Helper.correctDouble((String) arrColAssessment.get(5)),1));
							}
						}
					}
					document.add(table);
					table=null;
				}
				
			}
			//This Condition is for Cash Budget Method 
			else
			{
				HashMap hshRecord = new HashMap();
				strQuery = SQLParser.getSqlQuery("com_mpbfsel^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("com_mbpfcshdeficit",correctNull(rs.getString("com_mbpfcshdeficit")));	
					hshRecord.put("com_mbpfcshdeficitof",correctNull(rs.getString("com_mbpfcshdeficitof")));	
					hshRecord.put("com_mbpfstockmonth",correctNull(rs.getString("com_mbpfstockmonth")).equals("")?"0":correctNull(rs.getString("com_mbpfstockmonth")));
					hshRecord.put("com_mbpfseasonfrom",correctNull(rs.getString("com_mbpfseasonfrom")).equals("")?"0":correctNull(rs.getString("com_mbpfseasonfrom")));
					hshRecord.put("com_mbpfseasonto",correctNull(rs.getString("com_mbpfseasonto")).equals("")?"0":correctNull(rs.getString("com_mbpfseasonto")));
					hshRecord.put("com_mbpfseasonyear",correctNull(rs.getString("com_mbpfseasonyear")));
					hshRecord.put("com_mbpftotaltonnes",correctNull(rs.getString("com_mbpftotaltonnes")));
					hshRecord.put("com_mbpftonnesrupees",correctNull(rs.getString("com_mbpftonnesrupees")));
					hshRecord.put("com_mbpfpertonn",correctNull(rs.getString("com_mbpfpertonn")));
					hshRecord.put("com_mbpfsundry",correctNull(rs.getString("com_mbpfsundry")));
					hshRecord.put("com_mbpfmarginper",correctNull(rs.getString("com_mbpfmarginper")));
					hshRecord.put("com_mbpfmarginvalue",correctNull(rs.getString("com_mbpfmarginvalue")));
					hshRecord.put("com_mbpfdp",correctNull(rs.getString("com_mbpfdp")));
					hshRecord.put("com_mbpfwc",correctNull(rs.getString("com_mbpfwc")));
				}
				
				table=new Table(3);
				table.setPadding(2.0f);
				table.setBorderWidth(0.0f);
				table.setAutoFillEmptyCells(true);
				table.setWidth(100.0f);
				table.setBorder(0);
				table.setCellsFitPage(true);
				table.setTableFitsPage(true);
				
				table.addCell(rm.ReportCellGrayBold(1,"Calculation of MPBF",3,1));
				
				table.addCell(rm.ReportCell(0,"Peak Level Cash Deficit is "+Helper.correctNull((String) hshRecord.get("com_mbpfcshdeficit"))+" as of "+Helper.correctNull((String) hshRecord.get("com_mbpfcshdeficitof"))+" and " +
						"Peak Build up of stock is in month of "+Helper.getMonths(Integer.parseInt(Helper.correctInt((String) hshRecord.get("com_mbpfstockmonth")))),3));
				
				table.addCell(rm.ReportCellBold(0,"Drawing Power on the Basis of Peak Build up of stock is as follows : ",3));
				
				table.addCell(rm.ReportCell(0,"Peak Level of Stock Build up during the season from "+Helper.getMonths(Integer.parseInt(Helper.correctInt((String) hshRecord.get("com_mbpfseasonfrom"))))+" to "+Helper.getMonths(Integer.parseInt(Helper.correctInt((String) hshRecord.get("com_mbpfseasonto"))))+" (Year) " +
						Helper.correctNull((String) hshRecord.get("com_mbpfseasonyear"))+" for "+Helper.correctNull((String) hshRecord.get("com_mbpftotaltonnes"))+" Tonnes @ "+ApplicationParams.getCurrency()+" In "+strProposalvalue+" "+
						Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshRecord.get("com_mbpftonnesrupees"))))+" Per Tonn",3));
				
				table.addCell(rm.ReportCell(0,"Total Stock Holding",1));
				table.addCell(rm.ReportCell(1,ApplicationParams.getCurrency()+" In "+strProposalvalue,1));
				table.addCell(rm.ReportCell(2,Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshRecord.get("com_mbpfpertonn")))),1));
				
				table.addCell(rm.ReportCell(0,"Less : Sundry Creditors",1));
				table.addCell(rm.ReportCell(1,ApplicationParams.getCurrency()+" In "+strProposalvalue,1));
				table.addCell(rm.ReportCell(2,Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshRecord.get("com_mbpfsundry")))),1));
				
				table.addCell(rm.ReportCell(0,"Less: Margin on the above @ "+Helper.correctNull((String) hshRecord.get("com_mbpfmarginper"))+" %",1));
				table.addCell(rm.ReportCell(1,ApplicationParams.getCurrency()+" In "+strProposalvalue,1));
				table.addCell(rm.ReportCell(2,Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshRecord.get("com_mbpfmarginvalue")))),1));
				
				table.addCell(rm.ReportCell(0,"Drawing Power for the Stock",1));
				table.addCell(rm.ReportCell(1,ApplicationParams.getCurrency()+" In "+strProposalvalue,1));
				table.addCell(rm.ReportCell(2,Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshRecord.get("com_mbpfdp")))),1));
				
				table.addCell(rm.ReportCell(0,"Working Capital Eligible",1));
				table.addCell(rm.ReportCell(1,ApplicationParams.getCurrency()+" In "+strProposalvalue,1));
				table.addCell(rm.ReportCell(2,Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshRecord.get("com_mbpfwc")))),1));
				
				document.add(table);
				table=null;
			}
			
			int[] wd1={7,50,43};
			table=new Table(3);
			table.setPadding(2.0f);			
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f);
			table.setWidths(wd1);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);			
			
			table.addCell(rm.ReportCellBold(1," ",1,0.0f));
			table.addCell(rm.ReportCellBold(0,"COMMENTS ON ASSESSMENT",2,0.0f));	
			
			strQuery = SQLParser.getSqlQuery("sel_assessmentoflimit^" + strAppno);//Assessment of Limit
			if(rs!=null)rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{	
				document.add(table);
				document=ReportGenerator.getParsingHTML(correctNull(Helper.CLOBToString(rs.getClob("com_limitassessmnent_comments"))), document);
			}else{
				table.addCell(rm.ReportCell(0,"\n",3,0.0f));
				document.add(table);
			}
			
			table=null;
			
			table=new Table(3);
			table.setPadding(2.0f);			
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f);
			table.setWidths(wd1);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			table.addCell(rm.ReportCellBold(1,"28.4.",1,0.0f));
			table.addCell(rm.ReportCellBold(0,"TERM LOAN ASSESSMENT",2,0.0f));	
			
			strQuery = SQLParser.getSqlQuery("sel_termloanassessmentcomments^" + strAppno);//Assessment of Limit
			if(rs!=null)rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{			
				document.add(table);
				document=ReportGenerator.getParsingHTML(correctNull(Helper.CLOBToString(rs.getClob("com_termloan_comments"))), document);
			}else{
				table.addCell(rm.ReportCell(0,"\n",3,0.0f));
				document.add(table);
			}
			
			table=null;
			
			table=new Table(3);
			table.setPadding(2.0f);			
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f);
			table.setWidths(wd1);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			table.addCell(rm.ReportCellBold(1,"28.5.",1,0.0f));
			table.addCell(rm.ReportCellBold(0,"ASSESSEMENT OF NON-FUND LIMITS",2,0.0f));	
			
			strQuery = SQLParser.getSqlQuery("sel_nonfundassessment^" + strAppno);//Assessment of Limit
			if(rs!=null)rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{	
				document.add(table);
				document=ReportGenerator.getParsingHTML(correctNull(Helper.CLOBToString(rs.getClob("com_nonfund_comments"))), document);
			}else{
				table.addCell(rm.ReportCell(0,"\n",3,0.0f));
				document.add(table);
			}
			
			table=null;
			
			table=new Table(3);
			table.setPadding(2.0f);			
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f);
			table.setWidths(wd1);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			table.addCell(rm.ReportCellBold(1,"28.6.",1,0.0f));
			table.addCell(rm.ReportCellBold(0,"ASSESSEMENT OF EXPORT/IMPORT LIMITS",2,0.0f));	
			
			strQuery = SQLParser.getSqlQuery("sel_assessment^" + strAppno);//Assessment of Limit
			if(rs!=null)rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{	
				document.add(table);
				document=ReportGenerator.getParsingHTML(correctNull(Helper.CLOBToString(rs.getClob("com_assessment_comments"))), document);
			}else{
				table.addCell(rm.ReportCell(0,"\n",3,0.0f));
				document.add(table);
			}
			
			table=null;
			
			table=new Table(3);
			table.setPadding(2.0f);			
			table.setBorderWidth(0.0f);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f);
			table.setWidths(wd1);
			table.setCellsFitPage(true);
			table.setTableFitsPage(true);
			
			table.addCell(rm.ReportCellBold(1,"29.",1,2,0.0f));
			table.addCell(rm.ReportCellBold(0,"CONSORTIUM ARRANGEMENT",2,0.0f));	
			if(!strconsortiumassessment.equals("")){
				table.addCell(rm.ReportCell(0,strconsortiumassessment,2,0.0f));
			}else{
				table.addCell(rm.ReportCell(0,"\n",2,0.0f));
			}	
			
			table.addCell(rm.ReportCellBold(1,"30.",1,0.0f));
			table.addCell(rm.ReportCellBold(0,"OTHER MATTERS ",2,0.0f));	
			if(!strOtherMatters.equals("") || strOtherMatters.equalsIgnoreCase("<P>&nbsp;</P>") ){
				document.add(table);
				document=ReportGenerator.getParsingHTML(strOtherMatters, document);
			}else{
				table.addCell(rm.ReportCell(0,"",3,0.0f));
				document.add(table);
			}			
			
			table=null;
		}
		catch(Exception e){
			log.error("Exception in displayComments2 of ExcutiveSummaryBean "+e.getMessage());
		}
	}

}



