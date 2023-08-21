<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ page import="java.util.*,java.text.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<% request.setAttribute("_cache_refresh", "true"); %>
<laps:handleerror/>
<%
int intSno=1;
//From annexure page
ArrayList arrBranchRow		= new ArrayList();
ArrayList arrBranchCol		= new ArrayList();
ArrayList arrFactoryRow		= new ArrayList();
ArrayList arrFactoryCol		= new ArrayList();
ArrayList arrGodownRow		= new ArrayList();
ArrayList arrGodownCol		= new ArrayList();
ArrayList arrPromoterRow	= new ArrayList();
ArrayList arrGuaRow	= new ArrayList();
ArrayList arrOutCol			= new ArrayList();
ArrayList arrRowRating		= new ArrayList();
ArrayList arrColRating		= new ArrayList();
ArrayList arrRowDefault		= new ArrayList();
ArrayList arrColDefault		= new ArrayList();
ArrayList arrRowEcgc		= new ArrayList();
ArrayList arrColEcgc		= new ArrayList();
ArrayList arrRowRelation	= new ArrayList();
ArrayList arrColRelation	= new ArrayList();
ArrayList arrRowCIBIL	= new ArrayList();
ArrayList arrColCIBIL	= new ArrayList();
ArrayList arrRowIntRating	= new ArrayList();
ArrayList arrColIntRating	= new ArrayList();
ArrayList arrRowShare	= new ArrayList();
ArrayList arrColShare	= new ArrayList();
ArrayList arrRowNature	= new ArrayList();
ArrayList arrColNature	= new ArrayList();
ArrayList arrCoApplicant =new ArrayList();
ArrayList arrRowRatingRMD=new ArrayList();
ArrayList arrFinCommRow=new ArrayList();
ArrayList arrRecommRow=new ArrayList();
ArrayList arrPostSancTerms=new ArrayList();

String strAmtValueIn = Helper.correctNull((String)hshValues.get("strAmtValueIn"));
String strPagetype = Helper.correctNull((String)request.getParameter("pageVal"));
String strHeaderFlag="true";
HashMap hshValues1=new HashMap();
if(strPagetype.equalsIgnoreCase("PROPOSALLC"))
{
	hshValues1 = (HashMap)hshValues.get("PROPOSALLC");
}

HashMap hshAddeDetails=new HashMap();
HashMap hshFinlValues=new HashMap();

java.text.NumberFormat jtn	= java.text.NumberFormat.getInstance();

jtn.setMaximumFractionDigits(2);
jtn.setMinimumFractionDigits(2);
jtn.setGroupingUsed(false);

if(hshValues!=null)
{
	arrFactoryRow	= (ArrayList)hshValues1.get("arrBranchRow0");
	arrBranchRow	= (ArrayList)hshValues1.get("arrBranchRow1");
	arrGodownRow	= (ArrayList)hshValues1.get("arrBranchRow2");
	arrPromoterRow	= (ArrayList)hshValues1.get("arrPromoterRow");
	arrGuaRow	= (ArrayList)hshValues.get("arrGuaRow1");
	hshAddeDetails  = (HashMap)hshValues1.get("hshRespDetails");
	arrRowRating = (ArrayList)hshValues1.get("arrRowRating");
	arrRowDefault = (ArrayList)hshValues1.get("arrRowDefault");
	arrRowEcgc = (ArrayList)hshValues1.get("arrRowEcgc");
	arrRowRelation = (ArrayList)hshValues1.get("Relationship");
	arrRowCIBIL = (ArrayList)hshValues1.get("arrRowCIBIL");
	arrRowIntRating = (ArrayList)hshValues1.get("arrRowIntRating");
	arrRowShare = (ArrayList)hshValues1.get("Shareholding");
	arrRowNature = (ArrayList)hshValues1.get("Natureofshare");
	arrCoApplicant=(ArrayList)hshValues1.get("arrCoApplicant");
	arrRowRatingRMD=(ArrayList)hshValues1.get("arrRowRatingRMD");
	arrFinCommRow		= (ArrayList)hshValues.get("arrfinComments");
	hshFinlValues = (HashMap) hshValues.get("hshFinlValues");
	arrPostSancTerms=(ArrayList)hshValues.get("arrPostSancTerms");
}
arrRecommRow = (ArrayList) hshValues.get("arrRecommRow");
String strNil= "Nil",strValuesIn="";

String strValIn = Helper.correctNull((String)hshValues.get("strValuesIn"));


int intBranchSize	= 0;

if(arrBranchRow!=null&&arrBranchRow.size()>0)
{
	intBranchSize+= 1;
}

if(arrFactoryRow!=null&&arrFactoryRow.size()>0)
{
	intBranchSize+= 1;
}
if(arrGodownRow!=null&&arrGodownRow.size()>0)
{
	intBranchSize+= 1;
}


String strAd1="",strAd2="",strAd3="",strDis="",strCity="",strState="",strCountry="",app_constitution="",strAddress="";
String Address="",strZipcode="",strCommaddress="",strPerAddress="",strAdminAddress="";
int RowCount=0;
if(hshAddeDetails!=null)
{
	strAd1=Helper.changetoTitlecase(Helper.correctNull((String)hshAddeDetails.get("txtperapp_address1")));
	strAd2=Helper.changetoTitlecase(Helper.correctNull((String)hshAddeDetails.get("txtperapp_address2")));
 	strAd3=Helper.changetoTitlecase(Helper.correctNull((String)hshAddeDetails.get("txtperapp_address3")));
 	strCity=Helper.changetoTitlecase(Helper.correctNull((String)hshAddeDetails.get("txtperapp_city")));
 	strDis=Helper.changetoTitlecase(Helper.correctNull((String)hshAddeDetails.get("txtperapp_district")));
 	strState=Helper.changetoTitlecase(Helper.correctNull((String)hshAddeDetails.get("txtperapp_state")));
 	strZipcode=Helper.correctNull((String)hshAddeDetails.get("txtperapp_zip"));
 	
 	app_constitution=Helper.correctNull((String)hshAddeDetails.get("app_constitution"));
 	if(!strAd1.equalsIgnoreCase(""))
 	{ 
 		Address=strAd1;
 	}
 	if(!strAd2.equalsIgnoreCase(""))
 	{
 		Address=Address+","+strAd2;
 	}
 	if(!strAd3.equalsIgnoreCase(""))
 	{
 		Address=Address+","+strAd3;	
 	}
 	if(!strCity.equalsIgnoreCase(""))
 	{
 		Address=Address+","+strCity;
 	}
 	if(!strDis.equalsIgnoreCase(""))
 	{
 		Address=Address+","+strDis;
 	}
 	if(!strState.equalsIgnoreCase(""))
 	{
 		Address=Address+","+strState;
 		if(!strZipcode.equalsIgnoreCase(""))
 		{
 			Address=Address+"-"+strZipcode;	
 		}
 	}
 	if(!strAd1.equalsIgnoreCase(""))
 	{
 		strCommaddress=Address;
 		RowCount++;
 	}
 	strAd1="";
 	Address="";
 	strAd1=Helper.changetoTitlecase(Helper.correctNull((String)hshAddeDetails.get("txtperapp_permadd1")));
	strAd2=Helper.changetoTitlecase(Helper.correctNull((String)hshAddeDetails.get("txtperapp_permadd2")));
 	strAd3=Helper.changetoTitlecase(Helper.correctNull((String)hshAddeDetails.get("txtperapp_permadd3")));
 	strCity=Helper.changetoTitlecase(Helper.correctNull((String)hshAddeDetails.get("txtperapp_permcity")));
 	strDis=Helper.changetoTitlecase(Helper.correctNull((String)hshAddeDetails.get("txtperapp_permdistrict")));
 	strState=Helper.changetoTitlecase(Helper.correctNull((String)hshAddeDetails.get("txtperapp_permstate")));
 	strZipcode=Helper.correctNull((String)hshAddeDetails.get("txtperapp_permzip"));
 	
 	if(!strAd1.equalsIgnoreCase(""))
 	{ 
 		Address=strAd1;
 	}
 	if(!strAd2.equalsIgnoreCase(""))
 	{
 		Address=Address+","+strAd2;
 	}
 	if(!strAd3.equalsIgnoreCase(""))
 	{
 		Address=Address+","+strAd3;	
 	}
 	if(!strCity.equalsIgnoreCase(""))
 	{
 		Address=Address+","+strCity;
 	}
 	if(!strDis.equalsIgnoreCase(""))
 	{
 		Address=Address+","+strDis;
 	}
 	if(!strState.equalsIgnoreCase(""))
 	{
 		Address=Address+","+strState+".";
 		if(!strZipcode.equalsIgnoreCase(""))
 		{
 			Address=Address+"-"+strZipcode+".";	
 		}
 	}
 	if(!strAd1.equalsIgnoreCase(""))
 	{
		strPerAddress=Address;
 		RowCount++;
 		
 	}
 	strAd1="";
 	Address="";
 	strAd1=Helper.changetoTitlecase(Helper.correctNull((String)hshAddeDetails.get("txtperapp_adminadd1")));
 	strAd2=Helper.changetoTitlecase(Helper.correctNull((String)hshAddeDetails.get("txtperapp_adminadd2")));
 	strAd3=Helper.changetoTitlecase(Helper.correctNull((String)hshAddeDetails.get("txtperapp_adminadd3")));
 	strCity=Helper.changetoTitlecase(Helper.correctNull((String)hshAddeDetails.get("txtperapp_admincity")));
 	strDis=Helper.changetoTitlecase(Helper.correctNull((String)hshAddeDetails.get("txtperapp_admindistrict")));
 	strState=Helper.changetoTitlecase(Helper.correctNull((String)hshAddeDetails.get("perapp_adminstate")));
 	strZipcode=Helper.correctNull((String)hshAddeDetails.get("txtperapp_adminzip"));
 	if(!strAd1.equalsIgnoreCase(""))
 	{ 
 		Address=strAd1;
 	}
 	if(!strAd2.equalsIgnoreCase(""))
 	{
 		Address=Address+","+strAd2;
 	}
 	if(!strAd3.equalsIgnoreCase(""))
 	{
 		Address=Address+","+strAd3;	
 	}
 	if(!strCity.equalsIgnoreCase(""))
 	{
 		Address=Address+","+strCity;
 	}
 	if(!strDis.equalsIgnoreCase(""))
 	{
 		Address=Address+","+strDis;
 	}
 	if(!strState.equalsIgnoreCase(""))
 	{
 		Address=Address+","+strState+".";
 		if(!strZipcode.equalsIgnoreCase(""))
 		{
 			Address=Address+"-"+strZipcode+".";	
 		}
 	}
 	if(!strAd1.equalsIgnoreCase(""))
 	{
		strAdminAddress=Address;
		if(!app_constitution.equalsIgnoreCase("01"))
 			RowCount++;
 	}
}
String IntRat=Helper.correctNull((String)hshValues1.get("IntRat"));
String strAmountValue=Helper.correctNull((String)hshValues.get("strAmountValue"));


//End
String strOrgLevel=(String)session.getAttribute("strOrgLevel");
String strFinancialrequired="";
String strLoanType="";
boolean finacial_flag=false;
ArrayList arrRow = new ArrayList();
ArrayList arrCol = new ArrayList();
ArrayList arrFacRow = new ArrayList();
ArrayList arrRowNonBr = new ArrayList();
ArrayList arrColNonBr = new ArrayList();
ArrayList arrDeleRow = new ArrayList();
ArrayList arrBAOurRow = new ArrayList();
ArrayList arrFACexistingRow = new ArrayList();
ArrayList arrFAConlyRow = new ArrayList();

ArrayList arrFacilityTerm0 = (ArrayList)hshValues.get("arrFacilityTerm0");
ArrayList arrFacilityIdVal0 = (ArrayList)hshValues.get("arrFacilityIdVal0");
ArrayList arrParentID0 = (ArrayList)hshValues.get("arrParentID0");
ArrayList arrFacilityTermApp0 = (ArrayList)hshValues.get("arrFacilityTermApp0");

if(hshValues!=null&&hshValues.size()>0)
{
	arrRow = (ArrayList)hshValues.get("arrRow");
	arrFacRow = (ArrayList)hshValues.get("arrFacRow");
	arrRowNonBr	= (ArrayList)hshValues.get("arrRowNonBr");
	arrDeleRow = (ArrayList)hshValues.get("arrDeleRow");
	arrBAOurRow	= (ArrayList)hshValues.get("arrBAOurRow");
	arrFACexistingRow = (ArrayList)hshValues.get("arrFACexistingRow");
	arrFAConlyRow = (ArrayList)hshValues.get("arrFAConlyRow");
	strLoanType=Helper.correctNull((String)hshValues.get("strLoanTypeNew"));
	strFinancialrequired=Helper.correctNull((String)hshValues.get("Financialrequired"));
	if(strLoanType.equalsIgnoreCase("a"))
	{
		if(strFinancialrequired.equalsIgnoreCase("Y"))
				{				
			finacial_flag=true;
					
				}
		
	}
	else
	{
		finacial_flag=true;	
	}
	
}

String strOutstandingDate=Helper.correctNull((String)hshValues.get("strOutstandingDate"));
String strWhetherBRAvail = Helper.correctNull((String)hshValues.get("strWhetherBRAvail"));
String strTLValIn="",strPreWC="",strExiWC="";
String strFinValuesIn=Helper.correctNull((String)hshValues.get("strFinvalues"));
if(strValIn.equalsIgnoreCase("Rs"))
{
	strValuesIn	= "(Amount in  "+strValIn+".)";
	strTLValIn="";
}
else
{
	strValuesIn	= "(Rs. in  "+strValIn+")";
	strTLValIn=strValIn;
}

if(strAmtValueIn.equalsIgnoreCase("Rs"))
{
	strAmtValueIn	= "(Amount in  "+strAmtValueIn+".)";
}
else
{
	strAmtValueIn	= "(Rs. in  "+strAmtValueIn+")";
}
if(strFinValuesIn.equalsIgnoreCase("C")){
	strFinValuesIn="( Rs. in Crore )";
}else if(strFinValuesIn.equalsIgnoreCase("L")){
	strFinValuesIn="( Rs. in Lacs )";
}else{
	strFinValuesIn="( Amount in Rs. )";
}
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
%>

<html>
<head>
<title>Short Notes Proposal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
body, table td
{
FONT-SIZE: 16px !important; COLOR: #000000 !important; FONT-FAMILY: "Book Antiqua" !important;
}
#top{background-color: #ffffff;}
#top table{ border-collapse: collapse;}
#top td {border: 0.5pt solid #000000; FONT-SIZE: 16px; COLOR: #000000; LINE-HEIGHT: 16px; FONT-FAMILY: "Book Antiqua"}

.title
{
FONT-SIZE: 16px !important; COLOR: #000000 !important; FONT-FAMILY: "Book Antiqua" !important;font-weight: bold !important;
}
</style>

</head>
<body contentEditable="false" designMode="on">
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr><td align="center"><br><img src="<%=ApplicationParams.getAppUrl()%>img/kbl_newlogo.jpg"></td></tr>
<%if(Helper.correctNull((String)hshValues.get("com_sancdeptcode")).equalsIgnoreCase("008")){ %>
<tr><td align="center" width="50%">Credit LCFD</td></tr>
<%}else if(Helper.correctNull((String)hshValues.get("com_sancdeptcode")).equalsIgnoreCase("010")){ 
String strComSancbranchcode=Helper.correctNull((String)hshValues.get("com_sancbranchcode"));
if(strComSancbranchcode.equalsIgnoreCase("MCFD"))
	strComSancbranchcode="Credit MCFD";
else
	strComSancbranchcode="Credit RFD";
%>
<tr><td align="center" width="50%"><%=strComSancbranchcode%><%//=Helper.correctNull((String) hshValues.get("com_sancdept")).toUpperCase()%>&nbsp;&nbsp;<%//=Helper.correctNull((String) hshValues.get("com_sancbranch")).toUpperCase()%></td></tr>
<%}else if(Helper.correctNull((String)hshValues.get("com_sancdeptcode")).equalsIgnoreCase("013")){ %>
<tr><td align="center" width="50%">Credit RFD</td></tr>
<%}else if(Helper.correctNull((String)hshValues.get("com_sancdeptcode")).equalsIgnoreCase("014")){ %>
<tr><td align="center" width="50%">Credit MCFD</td></tr>
<%}
else if(Helper.correctNull((String)hshValues.get("com_sancdeptcode")).equalsIgnoreCase("015")||Helper.correctNull((String)hshValues.get("com_sancdeptcode")).equalsIgnoreCase("016")){
	%>
<tr><td align="center" width="50%"><%=Helper.correctNull((String)hshValues.get("strSanctiondept"))%></td></tr>
<%}
else{ %>
<tr><td align="center" width="50%">Branch&nbsp;/&nbsp;Office&nbsp;:&nbsp;<%=Helper.correctNull((String) hshValues.get("username")).toUpperCase()%></td></tr>
<%} %>
<tr><td>&nbsp;</td></tr>
<tr>
	<td class="title" align="center"><br>Post Sanction Short Note Proposal Format</td>
</tr>
<tr>
<td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
	<td colspan="2"><b>Date&nbsp;:&nbsp;</b><%=Helper.getCurrentDateTime()%></td>
</tr>
<tr>
<td align="left" width="70%"><b>Proposal No&nbsp;:&nbsp;</b><%=Helper.correctNull((String)request.getParameter("appno"))%></td>
<td align="left" width="30%"><b>PF No&nbsp;:&nbsp;</b>
<% if(strOrgLevel.equalsIgnoreCase("A")){ %>
						<%=Helper.correctNull((String)hshValues.get("com_partyfileno"))%>
						<%}else{  %>
						<%=Helper.correctNull((String)hshValues.get("com_roho"))%>
						<%} %>
</td>
</tr>
<tr>
<td align="left"><b>Branch&nbsp;:&nbsp;</b><%=Helper.correctNull(Helper.correctNull((String)hshValues.get("org_name"))).toUpperCase()%></td>
<td align="left"><b>Region&nbsp;:&nbsp;</b><%=Helper.correctNull(Helper.correctNull((String)hshValues.get("Reg_org_name"))).toUpperCase()%></td>
</tr>
</table>
</td></tr>
<tr>
	<td align="center"><br><b> SUBMITTED TO THE <%=Helper.correctNull((String)hshValues.get("com_submittedto")).toUpperCase()%>
		<br>-------------------------------------------------------------------------------------------</b>
	</td>
</tr>

<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
	
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td>
				<b>Reg&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;</b><%=Helper.correctNull((String)hshValues.get("OTHERPARAMS"))%> </td>
			</tr>
			<%if(Helper.correctNull((String)hshValues.get("strModifiedTerms")).contains("@REODWC@")){ %>
			<tr>
			<td>
			<p>This is a proposal for considering the review of working capital facilities sanctioned to the captioned borrower and seeking permission for allowing operations in the account for a period of six months.</p>
			</td>
			</tr>
			<%} %>
		</table>
	</td>
</tr>

<%if(arrPostSancTerms!=null && arrPostSancTerms.size()>0){ %>
			
			<tr>
			<td>
			<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
			<td>&nbsp;<b>Post Sanction Request</b></td>
			</tr>
			</table>
			</td>
			</tr>
			<%for(int a=0;a<arrPostSancTerms.size();a++){
				
				arrCol=(ArrayList)arrPostSancTerms.get(a);%>
			<%String strTerms[]=Helper.correctNull((String)arrCol.get(2)).split("@");%>
			
			<tr>
			<td>
			<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
			<td><%=Helper.correctNull((String)arrCol.get(0)) %> - <%=Helper.correctNull((String)arrCol.get(1)) %></td>
			</tr>
			</table>
			</td>
			</tr>
			<tr>
			<td>
			<div id="top">
				<table width="95%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
				    <tr>
					<tr class="tblhead" align="center">
						<td width="10%" >Sl. No</td>
						<td align="center" width="100%">Description</td>
						</tr>
			
			<%for(int z=0;z<strTerms.length;z++)
			{
				String strTemp=strTerms[z];
				if(strTemp.equalsIgnoreCase("MRS")){strTemp="Modifications to Repayment Schedule without restructuring";}
				else if(strTemp.equalsIgnoreCase("SEC")){strTemp="Addition/Substitution/Release of security";}
				else if(strTemp.equalsIgnoreCase("MODSEC")){strTemp="Modification of security type (Prime /Collateral) and value / Change of security owner";}
				else if(strTemp.equalsIgnoreCase("CHBRANCH")){strTemp="Change of facility availing branch";}
				else if(strTemp.equalsIgnoreCase("DLA")){strTemp="Decrease of Limit amount";}
				else if(strTemp.equalsIgnoreCase("DLP")){strTemp="Decrease of loan period";}
				else if(strTemp.equalsIgnoreCase("MIS")){strTemp="Change in MIS details including RBI industry codes";}
				else if(strTemp.equalsIgnoreCase("MRI")){strTemp="Modification in Rate of Interest";}
				else if(strTemp.equalsIgnoreCase("INLIM")){strTemp="Increase in Limit of the sub limit ";}
				else if(strTemp.equalsIgnoreCase("GUAR")){strTemp="Addition/Deletion of Guarantor";}
				else if(strTemp.equalsIgnoreCase("BRTOMCLR")){strTemp="Migration from Base Rate/PLR to Other Reference Rate";}
				else if(strTemp.equalsIgnoreCase("LAD")){strTemp="Sanctioning LAD / Protested Bills as sub limits of LC/BG/Buyer's Credit";}
				else if(strTemp.equalsIgnoreCase("SUBLIMIT")){strTemp="Sanction of sub-limit for the existing/already sanctioned main limit";}
				else if(strTemp.equalsIgnoreCase("MISMOD")){strTemp="Miscellaneous changes / Modifications";}
				else if(strTemp.equalsIgnoreCase("CHDPOWER")){strTemp="Modification in Drawing Power Indicator";}
				else if(strTemp.equalsIgnoreCase("MODGSS")){strTemp="Modification in Govt. Sponser scheme";}
				else if(strTemp.equalsIgnoreCase("REODWC")){strTemp="Short Review (Only for Working Capital Limits)";}
				else if(strTemp.equalsIgnoreCase("CHSCHEMECODE")){strTemp="Modifications in GL Sub head code and scheme code in CBS details";}
				else if(strTemp.equalsIgnoreCase("MARGIN")){strTemp="Modification to margin (for stock/book debts/cash margin and other margins)";}
				else if(strTemp.equalsIgnoreCase("CHDCCO")){strTemp="Change in DCCO without restructuring ";}
				else if(strTemp.equalsIgnoreCase("DCCO")){strTemp="Capturing Actual Date of Commencement of commercial operation for the first time  ";}
				else if(strTemp.equalsIgnoreCase("CHDCCO")){strTemp="Change in DCCO without restructuring ";}
				else if(strTemp.equalsIgnoreCase("MISMOD")){strTemp="Miscellaneous changes / Modifications";}
				else if(strTemp.equalsIgnoreCase("MODPROCESSCHARG")){strTemp="Modification of Processing Charges";}
				else if(strTemp.equalsIgnoreCase("MODBA")){strTemp="Modification in Banking Arrangement Type";}%>
				
				
				<tr>
					<td align="center"><%=z+1 %>&nbsp;</td>
					<td><%=strTemp %>&nbsp;</td>
				</tr>		
			
			<%}%>
			</table>
			</td>
			</tr>
			<%} }%>

<!-- APPLICANT'S PROFILE -->
<tr><td>
<div id="top">
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr><td align="left" class="title" colspan="3"><%=intSno++ %>. Borrower's Profile :</td></tr>
<tr>
<%
int setRowspan=1;
	setRowspan+=RowCount+intBranchSize;

%>
<td align="left" width="3%" rowspan="<%=setRowspan%>" valign="top">&nbsp;a.</td>
<td align="left" width="35%">Name of the Applicant</td>
<td align="left" width="62%"><%=Helper.correctNull((String)hshValues.get("perapp_title"))%>.&nbsp;<%=Helper.correctNull((String)hshValues.get("perapp_name"))%></td>
</tr>
<%if(app_constitution.equalsIgnoreCase("01")){ %>
<%if(!strCommaddress.equalsIgnoreCase("")){ %>
<tr>
	<td>Communication Address</td>
	<td><%=strCommaddress.toUpperCase()%></td>
</tr>
<%} %>
<%if(!strPerAddress.equalsIgnoreCase("")){ %>
<tr>
	<td>Permanent Address</td>
	<td><%=strPerAddress.toUpperCase() %></td>
</tr>
<%}%>
<%}else{ %>
<%if(!strCommaddress.equalsIgnoreCase("")){ %>
<tr>
	<td>Registered Office Address</td>
	<td><%=strCommaddress.toUpperCase()%></td>
</tr>
<%} %>
<%if(!strPerAddress.equalsIgnoreCase("")){ %>
<tr>
	<td>Administrative Office Address</td>
	<td><%=strPerAddress.toUpperCase() %></td>
</tr>
<%}%>
<%if(!strAdminAddress.equalsIgnoreCase("")){%>
<tr>
	<td>Corporate Address<br></td>
	<td><%=strAdminAddress.toUpperCase()%></td>
</tr>
<%}%>
<%} %>
<%
if(arrFactoryRow!=null&&arrFactoryRow.size()>0)
{%>
<tr>		
<td align="left" valign="top">Factories
</td>
<td align="left">
	<%for(int i=0;i<arrFactoryRow.size();i++)
	{
	 arrFactoryCol=(ArrayList)arrFactoryRow.get(i);%>
	 <%=i+1%>).&nbsp;
	<%=Helper.correctNull((String)arrFactoryCol.get(1))%>,<%=Helper.correctNull((String)arrFactoryCol.get(2))%>,
	<%=Helper.correctNull((String)arrFactoryCol.get(4))%>,
	<%=Helper.correctNull((String)arrFactoryCol.get(6))%>-<%=Helper.correctNull((String)arrFactoryCol.get(7))%>.<br>
<%
}%>	
</td>
</tr>
<%}%>
<%if(arrBranchRow!=null&&arrBranchRow.size()>0)
{ %>
<tr>		
<td align="left" valign="top">Branch
</td>
<td align="left">
<%for(int i=0;i<arrBranchRow.size();i++)
	{
	arrBranchCol=(ArrayList)arrBranchRow.get(i);%>
	<%=i+1%>).&nbsp;
	<%=Helper.correctNull((String)arrBranchCol.get(1))%>,
	<%=Helper.correctNull((String)arrBranchCol.get(2))%>,<%=Helper.correctNull((String)arrBranchCol.get(4))%>,
	<%=Helper.correctNull((String)arrBranchCol.get(6))%>-<%=Helper.correctNull((String)arrBranchCol.get(7))%>.<br>
<%}%>	
</td>
</tr>
<%} %>
<% if(arrGodownRow!=null&&arrGodownRow.size()>0)
{%>
<tr>		
<td align="left" valign="top">Godown</td>
<td align="left">

<% for(int i=0;i<arrGodownRow.size();i++)
	{
	arrGodownCol=(ArrayList)arrGodownRow.get(i);%>
	<%=i+1%>).&nbsp;
	<%=Helper.correctNull((String)arrGodownCol.get(1))%><br>
	<%=Helper.correctNull((String)arrGodownCol.get(2))%><br>
	<%=Helper.correctNull((String)arrGodownCol.get(4))%>,<%=Helper.correctNull((String)arrGodownCol.get(6))%>-<%=Helper.correctNull((String)arrGodownCol.get(7))%>.<br>
	<%}%>	
</td>
</tr>
<%} %>
<%
int intRowspan=0;
if(!(Helper.correctNull((String)hshValues1.get("cbs_static_data_desc")).equalsIgnoreCase("")))
{
	intRowspan++;
}

if(!(Helper.correctNull((String)hshValues1.get("cominfo_incorporation_date")).equalsIgnoreCase("")))
{
	intRowspan++;
}
if(!(Helper.correctNull((String)hshValues1.get("cominfo_commencement_date")).equalsIgnoreCase("")))
{
	intRowspan++;
}
if(!(Helper.correctNull((String)hshValues1.get("perapp_dob")).equalsIgnoreCase("")))
{
	intRowspan++;
}
if(!(Helper.correctNull((String)hshValues.get("perapp_banksince")).equalsIgnoreCase("")))
{
	intRowspan++;
}
if(!Helper.correctNull((String)hshValues.get("perapp_status")).equalsIgnoreCase("")||!Helper.correctNull((String)hshValues.get("perapp_status")).equalsIgnoreCase("0")
		||Helper.correctNull((String)hshValues.get("perapp_status")).equalsIgnoreCase("")||Helper.correctNull((String)hshValues.get("perapp_status")).equalsIgnoreCase("0")){
	intRowspan++;}
if(!Helper.correctNull((String)hshValues.get("perapp_relation_bankstaff")).equalsIgnoreCase("")||!Helper.correctNull((String)hshValues.get("perapp_relation_bankstaff")).equalsIgnoreCase("0")
		||Helper.correctNull((String)hshValues.get("perapp_relation_bankstaff")).equalsIgnoreCase("")||Helper.correctNull((String)hshValues.get("perapp_relation_bankstaff")).equalsIgnoreCase("0")){
	intRowspan++;}
if(Helper.correctNull((String)hshValues.get("perapp_relation_bankstaff_val")).equalsIgnoreCase("005")||Helper.correctNull((String)hshValues.get("perapp_relation_bankstaff_val")).equalsIgnoreCase("006")){
if(!Helper.correctNull((String)hshValues.get("perapp_relat_staffid")).equalsIgnoreCase("")||Helper.correctNull((String)hshValues.get("perapp_relat_staffid")).equalsIgnoreCase("")){
	intRowspan++;}

if(!Helper.correctNull((String)hshValues.get("perapp_relation_staffname")).equalsIgnoreCase("")||Helper.correctNull((String)hshValues.get("perapp_relation_staffname")).equalsIgnoreCase("")){
	intRowspan++;
}
}else{
	if(!Helper.correctNull((String)hshValues.get("perapp_relation_staffname")).equalsIgnoreCase("")||Helper.correctNull((String)hshValues.get("perapp_relation_staffname")).equalsIgnoreCase("")){
		intRowspan++;
	}
	intRowspan++;
}

if(Helper.correctNull((String) hshValues.get("APP_RENEW_FLAG")).equalsIgnoreCase("S")){
if(!Helper.correctNull((String)hshValues.get("strrestscheme")).equalsIgnoreCase("")){
	intRowspan++;
}
if(!Helper.correctNull((String)hshValues.get("PERAPP_INVOCDATE")).equalsIgnoreCase("")){
	intRowspan++;
}
}
if(!Helper.correctNull((String)hshValues.get("perapp_blood_relation")).equalsIgnoreCase("")){
	intRowspan++;
}
%>
<tr>
<td align="left" rowspan="<%=intRowspan%>" valign="top">b.</td>
<td align="left">Constitution</td>
<td align="left"><%=Helper.correctNull((String)hshValues1.get("cbs_static_data_desc"))%>&nbsp;</td>
</tr>
<% if(!(Helper.correctNull((String)hshValues1.get("cominfo_incorporation_date")).equalsIgnoreCase("")))
{%>
<tr>
<td align="left">Date of Incorporation</td>
<td align="left"><%=Helper.correctNull((String)hshValues1.get("cominfo_incorporation_date"))%></td>
</tr>
<%} 
if(!(Helper.correctNull((String)hshValues.get("cominfo_commencement_date")).equalsIgnoreCase("")))
{%>
<tr>
<td align="left">Date of commencement of business</td>
<td align="left"><%=Helper.correctNull((String)hshValues1.get("cominfo_commencement_date"))%></td>
</tr>
<%}
if(!(Helper.correctNull((String)hshValues1.get("perapp_dob")).equalsIgnoreCase("")))
{%>
<tr>
<% if(app_constitution.equalsIgnoreCase("01") || app_constitution.equalsIgnoreCase("02")){%>
<td align="left">Date of Birth</td>
<%}else{ %>
<td align="left">Date of Establishment</td>
<%}%>
<td align="left"><%=Helper.correctNull((String)hshValues1.get("perapp_dob"))%></td>
</tr>
<%}
 if(!(Helper.correctNull((String)hshValues.get("perapp_banksince")).equalsIgnoreCase("")))
{%>
<tr>
<td align="left">Dealing with us since</td>
<td align="left"><%=Helper.correctNull((String)hshValues.get("perapp_banksince"))%></td>
</tr>
<%} %>

			<tr>
			<td align="left" >Borrower status</td>
			<td align="left" ><%=Helper.correctNull((String)hshValues.get("perapp_status"))%></td>
			</tr>
			<tr>
			<td align="left" >Any relation to Bank Staff/Executive/Director </td>
			<td align="left"><%=Helper.correctNull((String)hshValues.get("perapp_relation_bankstaff"))%></td>
			</tr>
			<%if(Helper.correctNull((String)hshValues.get("perapp_relation_bankstaff_val")).equalsIgnoreCase("005")||Helper.correctNull((String)hshValues.get("perapp_relation_bankstaff_val")).equalsIgnoreCase("006")){ %>
			<tr>
			<td align="left" >Staff ID </td>
			<td align="left"><%=Helper.correctNull((String)hshValues.get("perapp_relat_staffid"))%></td>
			</tr>
			<tr>
			<td align="left" >Staff Name</td>
			<td align="left"><%=Helper.correctNull((String)hshValues.get("perapp_relation_staffname"))%></td>
			</tr>
			<%} else{%>
			<tr>
			<td align="left" >Name of Bank's Director</td>
			<td align="left"><%=Helper.correctNull((String)hshValues.get("perapp_relation_staffname"))%></td>
			</tr>
			<%}%>
			<tr>
			<td align="left" >Relation to the borrower</td>
			<td align="left"><%=Helper.correctNull((String)hshValues.get("perapp_blood_relation"))%></td>
			</tr>
			
						
			<%if(Helper.correctNull((String)hshValues.get("indinfo_is_staff")).equalsIgnoreCase("02")){ %>
			
			<% int intRowspanval=0;
			if(Helper.correctNull((String)hshValues.get("indinfo_is_staff")).equalsIgnoreCase("02")){ 
				if(!Helper.correctNull((String)hshValues.get("indinfo_staff_id")).equalsIgnoreCase("")||Helper.correctNull((String)hshValues.get("indinfo_staff_id")).equalsIgnoreCase("")){
					intRowspanval++;
				}
				if(!Helper.correctNull((String)hshValues.get("peremp_department")).equalsIgnoreCase("")||Helper.correctNull((String)hshValues.get("peremp_department")).equalsIgnoreCase("")){ 
					intRowspanval++;
				}
				if(!Helper.correctNull((String)hshValues.get("indinfo_dateof_joining")).equalsIgnoreCase("")||Helper.correctNull((String)hshValues.get("indinfo_dateof_joining")).equalsIgnoreCase("")){ 
					intRowspanval++;
				}
				if(!Helper.correctNull((String)hshValues.get("peremp_retdate")).equalsIgnoreCase("")||Helper.correctNull((String)hshValues.get("peremp_retdate")).equalsIgnoreCase("")){ 
					intRowspanval++;
				}
				if(!Helper.correctNull((String)hshValues.get("peremp_retdate")).equalsIgnoreCase("")||Helper.correctNull((String)hshValues.get("peremp_retdate")).equalsIgnoreCase("")){ 
					intRowspanval++;
				}
			} %>
			<td align="left" width="3%" rowspan="<%=intRowspanval%>" valign="top">&nbsp; Staff Details</td>
			<tr>
			<td align="left" >Staff ID </td>
			<td align="left" ><%=Helper.correctNull((String)hshValues.get("indinfo_staff_id"))%></td>
			</tr>
			<tr>
			<td align="left" >Department Name</td>
			<td align="left"><%=Helper.correctNull((String)hshValues.get("peremp_department"))%></td>
			</tr>
			<tr>
			<td align="left" >Date of Joining </td>
			<td align="left" ><%=Helper.correctNull((String)hshValues.get("indinfo_dateof_joining"))%></td>
			</tr>
			<tr>
			<td align="left" > Retirement Date</td>
			<td align="left"><%=Helper.correctNull((String)hshValues.get("peremp_retdate"))%></td>
			</tr>
			
			<%} %>
<tr>
<td class="title" align="left" colspan="3">
<div>c. Rating profile : External agency 
</div>
 <% if(arrRowRating!=null&&arrRowRating.size()>0)
{%>
<div align="right"><%=strAmtValueIn%>
</div>
<%} %>
<div id="top">
<table width="98%" align="center" cellpadding="3" cellspacing="0" border="0" >
 <% if(arrRowRating!=null&&arrRowRating.size()>0)
{
for(int i=0;i<arrRowRating.size();i++) {
	arrColRating	= (ArrayList)arrRowRating.get(i);
%>
<%if(i==0){ %>
<tr>
<td align="center">Name of rating agency</td>
<td align="center">Date of rating/press release</td>
<td align="center">Particulars of facility rated</td>
<td align="center">Amount rated <br/></td>
<td align="center">Rating assigned</td>
<td align="center">Description</td>
<td align="center">Due date</td>
<td align="center">Risk Weight</td>
</tr>
<%} %>
<tr>
<td><%=Helper.correctNull((String)arrColRating.get(2))%></td>
<td><%=Helper.correctNull((String)arrColRating.get(3))%></td>
<td><%=Helper.correctNull((String)arrColRating.get(4))%></td>
<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrColRating.get(5))))),strAmountValue)%></td>
<td><%=Helper.correctNull((String)arrColRating.get(6))%></td>
<td><%=Helper.correctNull((String)arrColRating.get(7))%></td>
<td><%=Helper.correctNull((String)arrColRating.get(8))%></td>
<td><%=Helper.correctNull((String)arrColRating.get(9))%>%</td>
</tr>
<%}%>
<tr>
<td colspan="8" align="left">Reason for downgrading: <%=Helper.correctNull((String)hshValues1.get("ExternalRatingComments1"))%></td>
</tr>

<%}else{%>
<tr><td align="center" style="border:none;"><%=strNil%></td></tr>
<%} %>
</table>
</div>
</td>
</tr>

<tr>
<td class="title" align="left" colspan="3"><b>d. Rating profile : Internal as confirmed by RMD 
<br/>
<div id="top">
<table width="98%" align="center" cellpadding="3" cellspacing="0" border="0">
<%if(IntRat.equalsIgnoreCase("Y")){ %>
<tr>
<td align="center" width="20%">Year</td>
<td align="center" width="30%">Type</td>
<td align="center" width="30%">Rating</td>
</tr>
<%if(arrRowRatingRMD!=null&&arrRowRatingRMD.size()>0){
	for(int i=0;i<arrRowRatingRMD.size();i++) {
	arrOutCol	= (ArrayList)arrRowRatingRMD.get(i);%>
<tr>
<td align="left"><%=Helper.correctNull((String)arrOutCol.get(0))%></td>
<td align="left"><%=Helper.correctNull((String)arrOutCol.get(1))%></td>
<td align="left"><%=Helper.correctNull((String)arrOutCol.get(2))%></td>
</tr>
<%}} } else{%>
<tr><td align="center" style="border:none;"><%=strNil%></td></tr>
<%} %>
<%if(!Helper.correctNull((String)hshValues1.get("cre_weight")).equalsIgnoreCase("")){ %>
<tr>
<td align="left"><%=Helper.correctNull((String)hshValues1.get("cre_ratyear"))%></td>
<td align="left"><%=Helper.correctNull((String)hshValues1.get("cre_rattype"))%></td>
<td align="left"><%=Helper.correctNull((String)hshValues1.get("cre_weight"))%></td>
</tr>
<% }%>
</table>
</div>
</td>
</tr>


<!-- Promoter -->
<tr>
<td class="title" align="left" colspan="3">
<div>e. Details of Management:
</div>
<div id="top">
<table width="98%" align="center" cellpadding="3" cellspacing="0" border="0">
<%
int Promsno=0;
if(arrPromoterRow!=null&&arrPromoterRow.size()>0){ %>
<%for(int i=0;i<arrPromoterRow.size();i++) {
	arrOutCol	= (ArrayList)arrPromoterRow.get(i);
	//if(Helper.correctNull((String)arrOutCol.get(6)).equalsIgnoreCase("SP") || Helper.correctNull((String)arrOutCol.get(6)).equalsIgnoreCase("PT") || Helper.correctNull((String)arrOutCol.get(6)).equalsIgnoreCase("D")){
if(strHeaderFlag.equalsIgnoreCase("true")){
strHeaderFlag="false";%>
<div align="right"><%=strAmtValueIn%>
</div>
<tr>
<td align="center" width="3%">Sl.No</td>
<td align="center" width="42%">Name of the Proprietor/ Partners/ Director</td>
<td align="center" width="5%">Age <br>(Yrs)</td>
<td align="center" width="25%">Relationship among themselves</td>
<td align="center" width="10%">Net Worth as on <br/></td>
<td align="center" width="15%">Income for Year ended</td>
</tr>
<%} %>
<tr>
<td align="left"><%=++Promsno%></td>
<td align="left"><%=Helper.correctNull((String)arrOutCol.get(0))%></td>
<td align="right"><%=Helper.correctInt((String)arrOutCol.get(1))%></td>
<td align="left"><%=Helper.correctNull((String)arrOutCol.get(8))%></td>
<td align="left" nowrap="nowrap"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrOutCol.get(4))))),strAmountValue)%>
&nbsp;-&nbsp;<%=Helper.correctNull((String)arrOutCol.get(5))%>
</td>
<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrOutCol.get(2))))),strAmountValue)%> - <%=Helper.correctNull((String)arrOutCol.get(7))%></td>
</tr>
<%//}
	} } else{%>
<tr><td align="center" style="border:none;"><%=strNil%></td></tr>
<%} %>
</table>
</div>
</td>
</tr>


<!-- Guarantors -->
<tr>
<td class="title" align="left" width="50%" colspan="3">
<div>f. Details of Co-Obligants/ Guarantors :
</div>
<div id="top">
<table width="98%" align="center" cellpadding="3" cellspacing="0" border="0">
<%strHeaderFlag="true";
int sno=0;
if(arrGuaRow!=null&&arrGuaRow.size()>0){%>
<%for(int i=0;i<arrGuaRow.size();i++) {
	arrOutCol	= (ArrayList)arrGuaRow.get(i);
	if(Helper.correctNull((String)arrOutCol.get(6)).equalsIgnoreCase("G") || Helper.correctNull((String)arrOutCol.get(6)).equalsIgnoreCase("CO")){
		if(strHeaderFlag.equalsIgnoreCase("true")){
			strHeaderFlag="false";
%>
<div align="right"><%=strAmtValueIn%>
</div>
<tr>
<td align="center" width="3%">Sl.No</td>
<td align="center" width="42%">Name of Co-obligants/ Guarantors</td>
<td align="center" width="5%">Age <br>(Yrs)</td>
<td align="center" width="25%">Relationship to borrower</td>
<td align="center" width="10%">Net Worth as on</td>
<td align="center" width="15%">Income for Year ended</td>

</tr>
<%} %>
<tr>
<td align="left"><%=++sno%></td>
<td align="left"><%=Helper.correctNull((String)arrOutCol.get(0))%></td>
<td align="right"><%=Helper.correctInt((String)arrOutCol.get(1))%></td>
<td align="left"><%=Helper.correctNull((String)arrOutCol.get(3))%></td>
<td align="left" nowrap="nowrap"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrOutCol.get(4))))),strAmountValue)%>
&nbsp;-&nbsp;<%=Helper.correctNull((String)arrOutCol.get(5))%></td>
<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrOutCol.get(2))))),strAmountValue)%> - <%=Helper.correctNull((String)arrOutCol.get(7))%></td>
</tr>
<%}} }
if(sno==0){ %>
<tr><td align="center" style="border:none;"><%=strNil%></td></tr>
<%} %>
</table>
</div>
</td>
</tr>

<tr>
<td class="title">g.</td>
<td class="title" align="left" width="50%">Nature of Activity</td>
<td><%=Helper.correctNull((String)hshValues1.get("NatureofActivity"))%></td>
</tr>
<tr>
<td class="title">h.</td>
<td class="title" align="left" width="50%">Sector - Priority / Non-Priority</td>
<td><%=Helper.correctNull((String)hshValues1.get("Sector"))%></td>
</tr>

</table>
</div>
<!-- END -->
</td></tr>
<tr>
	<td>
		<table width="95%" align="center" cellpadding="0" cellspacing="0" border="1">
<tr>
<%for(int a=0;a<arrPostSancTerms.size();a++){
				
				arrCol=(ArrayList)arrPostSancTerms.get(a);
			String strTerms[]=Helper.correctNull((String)arrCol.get(2)).split("@");
			
for(int z=0;z<strTerms.length;z++)
			{
				String strTemp=strTerms[z];
				 if(strTemp.equalsIgnoreCase("MODPROCESSCHARG")){
				 %>
				
				
				<td width="40%">Processing Charges</td>
<td align="right" width="45%"><%=Helper.correctNull((String)hshValues1.get("com_processingfee"))%></td>
</tr>	
			
			<%}}}%>

		</table>
	</td>
	</tr>
<tr>
	<td>
		<table width="95%" align="center" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td class="title"><%=intSno++ %>.Brief background of the applicant:</td>
		</tr>
		<tr>
		<%if(!Helper.correctNull((String)hshValues.get("OTHERPARAMS1")).equalsIgnoreCase("")){ %>
		<td><%=Helper.correctNull((String)hshValues.get("OTHERPARAMS1"))%>&nbsp;</td>
		<%}else{ %>
		<td align="center"> - NIL -&nbsp;</td>
		<%} %>
		</tr>
		</table>
	</td>
</tr>
<tr>
<td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">

<%
			if (!Helper.correctNull((String) hshValues.get("presentBankArng"))
					.equalsIgnoreCase("")) {
		%>
		<tr>
			<td class="title">Banking Arrangement :</td>
		</tr>
		<%
			}
		%>
		<tr>
		<td>
<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
			<div align="left" id="top">
					<jsp:include page="../print/com_consortiumPrint.jsp" flush="true">
					<jsp:param name="pagevalue" value="PROPOSAL"/>
					<jsp:param name="pagevalueAmt" value="<%=strAmtValueIn %>"/>
					</jsp:include>
	</div>
	</td>
	</tr>
	
	<%
	if (!Helper.correctNull(
			(String) hshValues.get("fin_commentsbankargmnt"))
			.equalsIgnoreCase("")) {
%>
<tr><td><b>Remarks:</b></td></tr>
<tr><td style="text-align: justify;"><%=Helper.correctNull((String) hshValues
								.get("fin_commentsbankargmnt"))%></td></tr>
<%
	}
%>
	</table>
	</td>
	</tr>
				
<tr>
	<td>
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
		<tr>
			<td width="50%" class="title"><br><%=intSno++ %>.Details of the existing Credit facilities with Our Bank:</td>
			<td width="50%" align="right">&nbsp;</td>
		</tr>
		<% if(arrBAOurRow!=null&&arrBAOurRow.size()>0){ %>
		<tr>
			<td width="50%">&nbsp;</td>
			<td width="50%" align="right"><%=strAmtValueIn%></td>
		</tr>
		<%} %>
		<tr><td colspan="2"><%=Helper.correctNull((String)hshValues.get("strExistingFacAbove"))%></td></tr>
		</table>
		</td>
		</tr>
<tr>
	<td>
		<div id="top">
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
		<%
		if(arrBAOurRow!=null&&arrBAOurRow.size()>0){ %>
		<tr>
			<td width="3%" align="center"><b>S.No</b></td>
			<td width="15%" align="center"><b>Nature of facility</b></td>
			<td width="10%" align="center"><b>Limit</b></td>
			<td width="10%" align="center"><b>Purpose</b></td>
			<td width="10%" align="center"><b>Sanction Ref. & Date</b></td>
			<td width="10%" align="center"><b>ROI/ Com %</b></td>
			<td width="10%" align="center"><b>Balance as on <%=strOutstandingDate%></b></td>
			<td width="10%" align="center"><b>Due Date</b></td>
			<td width="10%" align="center"><b>Arrears if any</b></td>
		</tr>
		<%
		double dbLimitTotal=0.00,dbbalanceTotal=0.00;
		for(int i=0;i<arrBAOurRow.size();i++){
			arrCol	= (ArrayList)arrBAOurRow.get(i);
			dbLimitTotal=dbLimitTotal+Double.parseDouble(Helper.correctDouble((String)arrCol.get(2)));
			dbbalanceTotal=dbbalanceTotal+Double.parseDouble(Helper.correctDouble((String)arrCol.get(6)));	
		%>
		<tr>
			<td align="left"><%=i+1%></td>
			<td align="left"><%=Helper.changetoTitlecase(Helper.correctNull((String)arrCol.get(0)))%></td>
			<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(2))))),strAmountValue)%></td>
			<td align="left"><%=Helper.correctNull((String)arrCol.get(10))%></td>
			<td align="left"><%=Helper.correctNull((String)arrCol.get(3))%>&nbsp;-&nbsp;<%=Helper.correctNull((String)arrCol.get(4))%></td>
			<td align="right"><%=Helper.correctNull((String)arrCol.get(11))%>&nbsp;+&nbsp;<%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(5))))%>% p.a presently at &nbsp;<%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(12))))%>% p.a</td>
			<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))),strAmountValue)%></td>
			<td align="center"><%=Helper.correctNull((String)arrCol.get(8))%></td>
			<td align="left"><%=Helper.correctNull((String)arrCol.get(9))%></td>
		</tr>
		<%} %>
		<tr>
			<td colspan="2" align="right"><b>Total</b></td>
			<td style="text-align: right"><b><%=Helper.converAmount(Helper.correctNull(Helper.formatDoubleValue(dbLimitTotal)),strAmountValue)%></b></td>
			<td colspan="3">&nbsp;</td>
			<td style="text-align: right"><b><%=Helper.converAmount(Helper.correctNull(Helper.formatDoubleValue(dbbalanceTotal)),strAmountValue)%></b></td>
			<td colspan="2">&nbsp;</td>
		</tr>
		<%}else{%>
		<tr><td style="border: none;"><%=strNil%></td></tr>
		<%} %>
		</table>
		</div>
	</td>
</tr>

<tr>
	<td>
	<div id="top">
	<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
	<%if(arrBAOurRow!=null && arrBAOurRow.size()>0){ %>
	<tr>
	<td width="3%" align="center"><b>S.No</b></td>
	<td width="17%" align="center"><b>Nature of facility</b></td>
	<td width="10%" align="center"><b>Repayment Comments</b></td>
	</tr>
	<%
	for(int i=0;i<arrBAOurRow.size();i++){
		arrCol	= (ArrayList)arrBAOurRow.get(i); %>
	<tr>
	<td align="left"><%=i+1%></td>
	<td align="left"><%=Helper.correctNull((String)arrCol.get(0)).toUpperCase()%></td>
	<td align="left"><%=Helper.correctNull((String)arrCol.get(15))%></td>
	</tr>
	<%}} %>
	</table>
	</td>
</tr>
<tr>
	<td>
		<table width="95%" align="center" cellpadding="0" cellspacing="0" border="0">
		<tr>
		<td><%=Helper.correctNull((String)hshValues.get("strExistingFacBelow"))%></td>
		</tr>
		</table>
	</td>
</tr>
<tr><td>&nbsp;</td></tr>


<tr><td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
<td class="title" align="left" width="50%">Asset Classification: </b>&nbsp;<%=Helper.correctNull((String)hshValues.get("strAssetClassification"))%>
&nbsp;<%if(!Helper.correctNull((String)hshValues.get("com_asscladate")).equals("")) { %>as on <%=Helper.correctNull((String)hshValues.get("com_asscladate"))%><%} %>&nbsp;</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
<td class="title"><%=intSno++ %>.Details of Securities :</td></tr>
</table>
</td></tr>

<%
String secValue = "";
String strGroupSecFlag=Helper.correctNull((String)hshValues.get("COMSEC_GROUPCOVERAGE"));
String strSec_groupcomments=Helper.correctNull((String)hshValues.get("COMSEC_GROUPCOMMENTS"));
ArrayList arrpropsecurityRow=(ArrayList)hshValues.get("arrExistingSecfacwise");
ArrayList arrpropsecCollRow = (ArrayList) hshValues
		.get("arrcollateralforEF");
ArrayList arrproposedCollateralSec = (ArrayList) hshValues
		.get("arrproposedCollateralSec");
ArrayList arrproposedFacility = (ArrayList) hshValues
		.get("arrproposedFacility");
String strProposedSecurity = Helper.correctNull((String) hshValues
		.get("strProposedSecurity"));
String strProposedSecurityComments = Helper
		.correctNull((String) hshValues
				.get("strProposedSecurityComments"));
String strAppSecFlag = Helper.correctNull((String) hshValues
		.get("COMSEC_APPCOVERAGE"));
ArrayList arrproposedSecfacwise = (ArrayList) hshValues
		.get("arrproposedSecfacwise");
ArrayList arrRowCollSec = (ArrayList) hshValues.get("arrRowCollSec");


if(!strGroupSecFlag.equalsIgnoreCase("M")){
if((arrpropsecurityRow!=null && arrpropsecurityRow.size()>0) || (arrpropsecCollRow!=null && arrpropsecCollRow.size()>0)){ %>
<tr><td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr><td><b><br>A. Already available for the existing facilities : </b><div align="right"><%=strAmtValueIn%></div></td></tr>
<tr><td>
<div id="top">
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
<td  align="center" width="20%"><b>Facility</b></td>
<td  align="center" width="55%"><b>Details of Security</b></td>
<td  align="center" width="10%"><b>Value</b></td>
<td  align="center" width="15%"><b>Date of Valuation</b></td>
</tr>
<%if((arrpropsecurityRow!=null && arrpropsecurityRow.size()>0)) { %>

<tr>
<td colspan="4"><b>Prime :</b></td>
</tr>

<% 

ArrayList arrpropsecurityCol=new ArrayList();
ArrayList arrpropsecurity=new ArrayList();
if(arrpropsecurityRow!=null && arrpropsecurityRow.size()>0){
	for(int i=0;i<arrpropsecurityRow.size();i++)
	{
		arrpropsecurityCol=(ArrayList)arrpropsecurityRow.get(i);
		  for(int k=0;k<arrpropsecurityCol.size();k++) {
			  arrpropsecurity=(ArrayList)arrpropsecurityCol.get(k);
			  if(k==0) {
				  secValue = Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurity.get(3)))),strAmountValue);
					if(secValue.equals("0.00")) secValue=" ";
		%>
		<tr>
		<td><%=Helper.correctNull((String)arrpropsecurity.get(0))%> (<%=Helper.converAmount(Helper.correctNull(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurity.get(1))))),strAmountValue) %>)</td>
		 <td  rowspan="<%=(arrpropsecurityCol.size())%>"> <%=Helper.correctNull((String)arrpropsecurity.get(2))%></td>
		 <td  align="right"  rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper.correctNull(secValue)%></td>
		 <td  rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper.correctNull((String)arrpropsecurity.get(4))%></td>
		</tr>	
		<%} else {%>
		<tr><td><%=Helper.correctNull((String)arrpropsecurity.get(0))%>  (<%=Helper.converAmount(Helper.correctNull(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurity.get(1))))),strAmountValue) %>)</td>
		</tr>
		<%	}}
	}
} }
%>
<%if((arrpropsecCollRow!=null && arrpropsecCollRow.size()>0)){ %>
<tr>
<td colspan="4"><b>Collateral :</b></td>
</tr>
<% 
ArrayList arrpropsecurityCol=new ArrayList();
ArrayList arrpropsecurity=new ArrayList();
if(arrpropsecCollRow!=null && arrpropsecCollRow.size()>0){
	for(int i=0;i<arrpropsecCollRow.size();i++)
	{
		arrpropsecurityCol=(ArrayList)arrpropsecCollRow.get(i);
		secValue = Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurityCol.get(1)))),strAmountValue);
		if(secValue.equals("0.00")) secValue=" ";
		 %>
		<tr>
		 <td colspan="2"> <%=Helper.correctNull((String)arrpropsecurityCol.get(0))%></td>
		 <td  align="right"><%=Helper.correctNull(secValue)%></td>
		 <td><%=Helper.correctNull((String)arrpropsecurityCol.get(2))%></td>
		</tr>		
		<%	
	}
} }
%>
</TABLE>
</div><br>
</td>
</tr>
</table>
</td>
</tr>
<% }else{ %>
<tr><td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr><td><b><br>A. Already available for the existing facilities : </b> Nil</td></tr>
</table>
</td></tr>
<%}}else if(strGroupSecFlag.equalsIgnoreCase("M")) {%>
<tr><td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr><td><b><br>A. Already available for the existing facilities : </b> </td></tr>
<tr><td><%=strSec_groupcomments%></td></tr>
</table>
</td>
</tr>
<%} %>

			<%

				ArrayList arrpropsecurity = new ArrayList();
				ArrayList arrpropsecurityCol = new ArrayList();
				if ((arrproposedFacility != null && arrproposedFacility.size() > 0)
						|| (arrproposedCollateralSec != null && arrproposedCollateralSec.size() > 0)) {
			%>
			<tr>
				<td>
				<table width="95%" align="center" cellpadding="3" cellspacing="0"
					border="0">
					<tr>
						<td><b><br>
						B.Additional / Fresh securities offered for the proposed
						facilities/Security released :</b>
						<div align="right"><%=strAmtValueIn%></div>
						</td>
					</tr>
					<tr>
						<td><b>Additional / Fresh Securities Offered :</b></td>
					</tr>
					<tr>
						<td>
						<div id="top">
						<table width="95%" align="center" cellpadding="3" cellspacing="0"
							border="0">


							<tr>
								<td align="center" width="20%"><b>Facility</b></td>
								<td align="center" width="55%"><b>Details of Security</b></td>
								<td align="center" width="10%"><b>Value</b></td>
								<td align="center" width="15%"><b>Date of Valuation</b></td>
							</tr>
							<%
								if (arrproposedFacility != null
											&& arrproposedFacility.size() > 0) {
							%>
							<tr align="left">
								<td colspan="4"><b>Prime :</b></td>
							</tr>
							<%
								for (int i = 0; i < arrproposedFacility.size(); i++) {
											arrpropsecurityCol = (ArrayList) arrproposedFacility
													.get(i);
											for (int k = 0; k < arrpropsecurityCol.size(); k++) {
												arrpropsecurity = (ArrayList) arrpropsecurityCol
														.get(k);
												if (k == 0) {
													secValue = Helper
															.converAmount(
																	Helper
																			.formatDoubleValue(Double
																					.parseDouble(Helper
																							.correctDouble((String) arrpropsecurity
																									.get(3)))),
																	strAmountValue);
													if (secValue.equals("0.00"))
														secValue = " ";
							%>
							<tr>
								<td><%=Helper
														.correctNull((String) arrpropsecurity
																.get(0))%>
								(<%=Helper
														.converAmount(
																Helper
																		.correctNull(Helper
																				.formatDoubleValue(Double
																						.parseDouble(Helper
																								.correctDouble((String) arrpropsecurity
																										.get(1))))),
																strAmountValue)%>)</td>
								<td rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper
														.correctNull((String) arrpropsecurity
																.get(2))%></td>
								<td align="right" rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper.correctNull(secValue)%></td>
								<td rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper
														.correctNull((String) arrpropsecurity
																.get(4))%></td>
							</tr>
							<%
								} else {
							%>
							<tr>
								<td><%=Helper
														.correctNull((String) arrpropsecurity
																.get(0))%>
								(<%=Helper
														.converAmount(
																Helper
																		.correctNull(Helper
																				.formatDoubleValue(Double
																						.parseDouble(Helper
																								.correctDouble((String) arrpropsecurity
																										.get(1))))),
																strAmountValue)%>)</td>
							</tr>
							<%
								}
											}
										}
									}

									arrpropsecurity = new ArrayList();
									arrpropsecurityCol = new ArrayList();
									secValue = "";
							%>
							<%
								if (arrproposedCollateralSec != null
											&& arrproposedCollateralSec.size() > 0) {
							%>
							<tr align="left">
								<td colspan="4"><b>Collateral :</b></td>
							</tr>
							<%
								for (int i = 0; i < arrproposedCollateralSec.size(); i++) {
											arrpropsecurityCol = (ArrayList) arrproposedCollateralSec
													.get(i);
											secValue = Helper
													.converAmount(
															Helper
																	.formatDoubleValue(Double
																			.parseDouble(Helper
																					.correctDouble((String) arrpropsecurityCol
																							.get(1)))),
															strAmountValue);
											if (secValue.equals("0.00"))
												secValue = " ";
							%>
							<tr>
								<td colspan="2"><%=Helper
												.correctNull((String) arrpropsecurityCol
														.get(0))%></td>
								<td align="right"><%=Helper.correctNull(secValue)%></td>
								<td><%=Helper
												.correctNull((String) arrpropsecurityCol
														.get(2))%></td>
							</tr>
							<%
								}
									}
							%>
						</table>
						</div>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<%
				} else {
			%>
			<tr>
				<td>
				<table width="95%" align="center" cellpadding="3" cellspacing="0"
					border="0">
					<tr>
						<td><b><br>
						 B.Additional / Fresh securities offered for the proposed
						facilities/Security released :</b> Nil</td>
					</tr>
				</table>
				</td>
			</tr>
			<%
				}
			%>


			<%
				if (!strProposedSecurity.equalsIgnoreCase("M")) {
					if ((arrproposedSecfacwise != null && arrproposedSecfacwise
							.size() > 0)
							|| (arrRowCollSec != null && arrRowCollSec.size() > 0)) {
			%>
			<tr>
				<td>
				<table width="95%" align="center" cellpadding="3" cellspacing="0"
					border="0">
					<tr>
						<td><b><br>
						C.Securities for the proposed / renewed facilities : </b>
						<div align="right"><%=strAmtValueIn%></div>
						</td>
					</tr>
					<tr>
						<td>
						<div id="top">
						<table width="95%" align="center" cellpadding="3" cellspacing="0"
							border="0">

							<tr>
								<td align="center" width="20%"><b>Facility</b></td>
								<td align="center" width="55%"><b>Details of Security</b></td>
								<td align="center" width="10%"><b>Value</b></td>
								<td align="center" width="15%"><b>Date of Valuation</b></td>
							</tr>
							<%
								if ((arrproposedSecfacwise != null && arrproposedSecfacwise
												.size() > 0)) {
							%>
							<tr align="left">
								<td colspan="4"><b>Prime :</b></td>
							</tr>
							<%
								arrpropsecurityCol = new ArrayList();
											arrpropsecurity = new ArrayList();
											secValue = "";
											if (arrproposedSecfacwise != null
													&& arrproposedSecfacwise.size() > 0) {
												for (int i = 0; i < arrproposedSecfacwise.size(); i++) {
													arrpropsecurityCol = (ArrayList) arrproposedSecfacwise
															.get(i);
													for (int k = 0; k < arrpropsecurityCol.size(); k++) {
														arrpropsecurity = (ArrayList) arrpropsecurityCol
																.get(k);
														if (k == 0) {
															secValue = Helper
																	.converAmount(
																			Helper
																					.formatDoubleValue(Double
																							.parseDouble(Helper
																									.correctDouble((String) arrpropsecurity
																											.get(3)))),
																			strAmountValue);
															if (secValue.equals("0.00"))
																secValue = " ";
							%>
							<tr>
								<td><%=Helper
																.correctNull((String) arrpropsecurity
																		.get(0))%>
								( <%=Helper
																.converAmount(
																		Helper
																				.correctDouble(Helper
																						.formatDoubleValue(Double
																								.parseDouble(Helper
																										.correctDouble((String) arrpropsecurity
																												.get(1))))),
																		strAmountValue)%>)</td>
								<td rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper
																.correctNull((String) arrpropsecurity
																		.get(2))%></td>
								<td align="right" rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper.correctNull(secValue)%></td>
								<td rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper
																.correctNull((String) arrpropsecurity
																		.get(4))%></td>
							</tr>
							<%
								} else {
							%>
							<tr>
								<td><%=Helper
																.correctNull((String) arrpropsecurity
																		.get(0))%>
								( <%=Helper
																.converAmount(
																		Helper
																				.correctDouble(Helper
																						.formatDoubleValue(Double
																								.parseDouble(Helper
																										.correctDouble((String) arrpropsecurity
																												.get(1))))),
																		strAmountValue)%>)</td>
							</tr>
							<%
								}
													}
												}
											}
										}
										if ((arrRowCollSec != null && arrRowCollSec.size() > 0)) {
							%>
							<tr>
								<td colspan="4" align="left"><b>Collateral:</b></td>
							</tr>
							<%
								arrpropsecurityCol = new ArrayList();
											arrpropsecurity = new ArrayList();
											secValue = "";
											if (arrRowCollSec != null && arrRowCollSec.size() > 0) {
												for (int i = 0; i < arrRowCollSec.size(); i++) {
													arrpropsecurityCol = (ArrayList) arrRowCollSec
															.get(i);
													secValue = Helper
															.converAmount(
																	Helper
																			.formatDoubleValue(Double
																					.parseDouble(Helper
																							.correctDouble((String) arrpropsecurityCol
																									.get(1)))),
																	strAmountValue);
													if (secValue.equals("0.00"))
														secValue = " ";
							%>
							<tr>
								<td colspan="2"><%=Helper
														.correctNull((String) arrpropsecurityCol
																.get(0))%></td>
								<td align="right"><%=Helper.correctNull(secValue)%></td>
								<td><%=Helper
														.correctNull((String) arrpropsecurityCol
																.get(2))%></td>
							</tr>
							<%
								}
											}
										}
							%>
						</TABLE>
						</div>
						<br>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<%
				} else {
			%>
			<tr>
				<td>
				<table width="95%" align="center" cellpadding="3" cellspacing="0"
					border="0">
					<tr>
						<td><b><br>
						C.Securities for the proposed / renewed facilities :</b> Nil</td>
					</tr>
				</table>
				</td>
			</tr>
			<%
				}
				} else if (strProposedSecurity.equalsIgnoreCase("M")) {
			%>
			<tr>
				<td>
				<table width="95%" align="center" cellpadding="3" cellspacing="0"
					border="0">
					<tr>
						<td><b><br>
						C.Securities for the proposed / renewed facilities :</b></td>
					</tr>
					<tr>
						<td><%=strProposedSecurityComments%></td>
					</tr>
				</table>
				</td>
			</tr>
			<%
				}
			%>


			<%
if(!strAppSecFlag.equalsIgnoreCase("M")){%>
	<tr><td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
<td><b>D. Security coverage for Bank's exposure to the applicant :</b><div align="right"><%=strAmtValueIn%></div></td>
</tr>
<tr>
	<td>
	
	<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
<td>
		<div align="left" id="top">
			<jsp:include page="../print/Securitiesprint.jsp" flush="true">
			<jsp:param name="pageVal" value="shortnote"/>
			</jsp:include>
			
		</div>
		</td>
			</tr>
			</table>
	</td>
</tr>
</table>
</td>
</tr>
<%
	}else if(strAppSecFlag.equalsIgnoreCase("M")){ %>
<tr><td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
<td><b>D.Security coverage for Bank's exposure to the applicant:</b></td>
</tr>
<tr>
<td>
<%if(hshValues!=null){ %>
<%=Helper.correctNull((String)hshValues.get("COMSEC_APPCOMMENTS"))%>
<%} %>&nbsp;</td>
</tr>
</table>
</td>
</tr>
<%} %>

<%
	String year1 = Helper.correctNull((String) hshFinlValues
			.get("txt_year1"));
		if (!year1.equalsIgnoreCase("")) {
%>
<tr>
	<td>
		<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="95%" border="0" cellspacing="0" cellpadding="3" align="center">
			<tr>
			</tr>
		</table>
	</td>
</tr>
<tr><td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
<td class="title"><%=intSno++ %>.Brief Financial Indicators of the borrower:</td>
</tr>
<tr>
<td><%=Helper.correctNull((String) hshValues.get("fin_comments_interfirm")) %></td>
</tr>
</table>
</td>
</tr>

<%
	String year2 = Helper.correctNull((String) hshFinlValues
				.get("txt_year2"));
		String year3 = Helper.correctNull((String) hshFinlValues
				.get("txt_year3"));
		String year4 = Helper.correctNull((String) hshFinlValues
				.get("txt_year4"));
		String year5 = Helper.correctNull((String) hshFinlValues
				.get("txt_year5"));
%>
<tr><td align="right"><%=strFinValuesIn%>&nbsp;</td></tr>
<tr>
	<td>
		<div id="top">
			<table width="95%" border="0" cellspacing="0" cellpadding="3" align="center">
				<tr> 
                	<td width="25%">&nbsp;Year</td>
                	<%
                		if (!year1.equalsIgnoreCase("")) {
                	%>
                  	<td width="15%" align="center"><%=Helper.correctNull((String) hshFinlValues
									.get("txt_year1"))%>&nbsp;</td>
                  	<%
                  		}
                  	%>
                  	<%
                  		if (!year2.equalsIgnoreCase("")) {
                  	%>
                  	<td width="15%" align="center"><%=Helper.correctNull((String) hshFinlValues
									.get("txt_year2"))%>&nbsp;</td>
					<%
						}
					%>                  
                    <%
                                      	if (!year3.equalsIgnoreCase("")) {
                                      %>
                  	<td width="15%" align="center"><%=Helper.correctNull((String) hshFinlValues
									.get("txt_year3"))%>&nbsp;</td>
                  	<%
                  		}
                  	%>
                  	<%
                  		if (!year4.equalsIgnoreCase("")) {
                  	%>
                  	<td width="15%" align="center"><%=Helper.correctNull((String) hshFinlValues
									.get("txt_year4"))%>&nbsp;</td>
                  	<%
                  		}
                  	%>
                  	<%
                  		if (!year5.equalsIgnoreCase("")) {
                  	%>
                  	<td width="15%" align="center"><%=Helper.correctNull((String) hshFinlValues
									.get("txt_year5"))%>&nbsp;</td>
                  	<%
                  		}
                  	%>
                </tr>
                <tr> 
                  <td width="25%">&nbsp;Type</td>
                  <%
                  	if (!year1.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="center"><%=Helper.correctNull((String) hshFinlValues
									.get("txt_type1"))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year2.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="center"><%=Helper.correctNull((String) hshFinlValues
									.get("txt_type2"))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year3.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="center"><%=Helper.correctNull((String) hshFinlValues
									.get("txt_type3"))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year4.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="center"><%=Helper.correctNull((String) hshFinlValues
									.get("txt_type4"))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year5.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="center"><%=Helper.correctNull((String) hshFinlValues
									.get("txt_type5"))%>&nbsp;</td>
                  <%
                  	}
                  %>
                </tr>
                <tr> 
                  <td width="25%">&nbsp;Sales</td>
                  <%
                  	if (!year1.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
									.correctDouble((String) hshFinlValues
											.get("txt_netsales1"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year2.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
									.correctDouble((String) hshFinlValues
											.get("txt_netsales2"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year3.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
									.correctDouble((String) hshFinlValues
											.get("txt_netsales3"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year4.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
									.correctDouble((String) hshFinlValues
											.get("txt_netsales4"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year5.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
									.correctDouble((String) hshFinlValues
											.get("txt_netsales5"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
               </tr>
              
               <%
                             	if (!((Double.parseDouble(Helper
                             				.correctDouble((String) hshFinlValues
                             						.get("FINGRPCONCERN_FREETEXT41"))) == 0)
                             				&& (Double.parseDouble(Helper
                             						.correctDouble((String) hshFinlValues
                             								.get("FINGRPCONCERN_FREETEXT42"))) == 0)
                             				&& (Double.parseDouble(Helper
                             						.correctDouble((String) hshFinlValues
                             								.get("FINGRPCONCERN_FREETEXT43"))) == 0)
                             				&& (Double.parseDouble(Helper
                             						.correctDouble((String) hshFinlValues
                             								.get("FINGRPCONCERN_FREETEXT44"))) == 0) && (Double
                             				.parseDouble(Helper
                             						.correctDouble((String) hshFinlValues
                             								.get("FINGRPCONCERN_FREETEXT45"))) == 0))) {
                             %>
               			
               			
               	<tr> 
                  <td width="25%">&nbsp;<%=Helper.correctNull((String) hshValues
									.get("COM_FREETEXT4"))%>&nbsp;</td>
                  <%
                  	if (!year1.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn
												.format(Double
														.parseDouble(Helper
																.correctDouble((String) hshFinlValues
																		.get("FINGRPCONCERN_FREETEXT41"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year2.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn
												.format(Double
														.parseDouble(Helper
																.correctDouble((String) hshFinlValues
																		.get("FINGRPCONCERN_FREETEXT42"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year3.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn
												.format(Double
														.parseDouble(Helper
																.correctDouble((String) hshFinlValues
																		.get("FINGRPCONCERN_FREETEXT43"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year4.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn
												.format(Double
														.parseDouble(Helper
																.correctDouble((String) hshFinlValues
																		.get("FINGRPCONCERN_FREETEXT44"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year5.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn
												.format(Double
														.parseDouble(Helper
																.correctDouble((String) hshFinlValues
																		.get("FINGRPCONCERN_FREETEXT45"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
               </tr>
               
             <%
                            	}
                            %>
              
               <%
                             	if (!((Double.parseDouble(Helper
                             				.correctDouble((String) hshFinlValues
                             						.get("txt_netprofit1"))) == 0)
                             				&& (Double.parseDouble(Helper
                             						.correctDouble((String) hshFinlValues
                             								.get("txt_netprofit2"))) == 0)
                             				&& (Double.parseDouble(Helper
                             						.correctDouble((String) hshFinlValues
                             								.get("txt_netprofit3"))) == 0)
                             				&& (Double.parseDouble(Helper
                             						.correctDouble((String) hshFinlValues
                             								.get("txt_netprofit4"))) == 0) && (Double
                             				.parseDouble(Helper
                             						.correctDouble((String) hshFinlValues
                             								.get("txt_netprofit5"))) == 0))) {
                             %>
               		
               	<tr> 
                  <td width="25%">&nbsp;Net Profit</td>
                  <%
                  	if (!year1.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_netprofit1"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year2.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_netprofit2"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year3.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_netprofit3"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year4.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_netprofit4"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year5.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_netprofit5"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
               </tr>
               
               <%
                              	}
                              %>
               		
               		  <%
               		               		  	if (!((Double.parseDouble(Helper
               		               		  				.correctDouble((String) hshFinlValues
               		               		  						.get("txt_tangnet1"))) == 0)
               		               		  				&& (Double.parseDouble(Helper
               		               		  						.correctDouble((String) hshFinlValues
               		               		  								.get("txt_tangnet2"))) == 0)
               		               		  				&& (Double.parseDouble(Helper
               		               		  						.correctDouble((String) hshFinlValues
               		               		  								.get("txt_tangnet3"))) == 0)
               		               		  				&& (Double.parseDouble(Helper
               		               		  						.correctDouble((String) hshFinlValues
               		               		  								.get("txt_tangnet4"))) == 0) && (Double
               		               		  				.parseDouble(Helper
               		               		  						.correctDouble((String) hshFinlValues
               		               		  								.get("txt_tangnet5"))) == 0))) {
               		               		  %>
          		
          		   <tr> 
                  <td width="25%">&nbsp;Net Worth</td>
                  <%
                  	if (!year1.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_tangnet1"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year2.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_tangnet2"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year3.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_tangnet3"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year4.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_tangnet4"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year5.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_tangnet5"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
               </tr>
          		
          		<%
          		          			}
          		          		%>	 
              
            
            	
               		  <%
	                                       	               		  	if (!((Double.parseDouble(Helper
	                                       	               		  				.correctDouble((String) hshFinlValues
	                                       	               		  						.get("txt_toltnw1"))) == 0)
	                                       	               		  				&& (Double.parseDouble(Helper
	                                       	               		  						.correctDouble((String) hshFinlValues
	                                       	               		  								.get("txt_toltnw2"))) == 0)
	                                       	               		  				&& (Double.parseDouble(Helper
	                                       	               		  						.correctDouble((String) hshFinlValues
	                                       	               		  								.get("txt_toltnw3"))) == 0)
	                                       	               		  				&& (Double.parseDouble(Helper
	                                       	               		  						.correctDouble((String) hshFinlValues
	                                       	               		  								.get("txt_toltnw4"))) == 0) && (Double
	                                       	               		  				.parseDouble(Helper
	                                       	               		  						.correctDouble((String) hshFinlValues
	                                       	               		  								.get("txt_toltnw5"))) == 0))) {
	                                       	               		  %>
          		
          		 <tr> 
                  <td width="25%">&nbsp;Debt-Equity Ratio</td>
                  <%
                  	if (!year1.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_toltnw1"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year2.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_toltnw2"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year3.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_toltnw3"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year4.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_toltnw4"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year5.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_toltnw5"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
               </tr>
          		<%
          			}
          		%>
          		
          		
          		  <%
          		          		          		  	if (!((Double.parseDouble(Helper
          		          		          		  				.correctDouble((String) hshFinlValues
          		          		          		  						.get("txt_currratio1"))) == 0)
          		          		          		  				&& (Double.parseDouble(Helper
          		          		          		  						.correctDouble((String) hshFinlValues
          		          		          		  								.get("txt_currratio2"))) == 0)
          		          		          		  				&& (Double.parseDouble(Helper
          		          		          		  						.correctDouble((String) hshFinlValues
          		          		          		  								.get("txt_currratio3"))) == 0)
          		          		          		  				&& (Double.parseDouble(Helper
          		          		          		  						.correctDouble((String) hshFinlValues
          		          		          		  								.get("txt_currratio4"))) == 0) && (Double
          		          		          		  				.parseDouble(Helper
          		          		          		  						.correctDouble((String) hshFinlValues
          		          		          		  								.get("txt_currratio5"))) == 0))) {
          		          		          		  %>
               <tr> 
                  <td width="25%">&nbsp;TOL/TNW</td>
                  <%
                  	if (!year1.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_currratio1"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year2.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_currratio2"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year3.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_currratio3"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year4.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_currratio4"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year5.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_currratio5"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
               </tr>
               
               <%
                              	}
                              %>
               
               
                <%
                                              	if (!((Double.parseDouble(Helper
                                              				.correctDouble((String) hshFinlValues
                                              						.get("txt_estproturn1"))) == 0)
                                              				&& (Double.parseDouble(Helper
                                              						.correctDouble((String) hshFinlValues
                                              								.get("txt_estproturn2"))) == 0)
                                              				&& (Double.parseDouble(Helper
                                              						.correctDouble((String) hshFinlValues
                                              								.get("txt_estproturn3"))) == 0)
                                              				&& (Double.parseDouble(Helper
                                              						.correctDouble((String) hshFinlValues
                                              								.get("txt_estproturn4"))) == 0) && (Double
                                              				.parseDouble(Helper
                                              						.correctDouble((String) hshFinlValues
                                              								.get("txt_estproturn5"))) == 0))) {
                                              %>
          		
          		<tr> 
                  <td width="25%">&nbsp;Current Ratio</td>
                  <%
                  	if (!year1.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_estproturn1"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year2.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_estproturn2"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year3.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_estproturn3"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year4.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_estproturn4"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year5.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_estproturn5"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
               </tr>
               
          		<%
                         			}
                         		%>
               
               
                  <%
                                                	if (!((Double.parseDouble(Helper
                                                				.correctDouble((String) hshFinlValues
                                                						.get("txt_freetext1"))) == 0)
                                                				&& (Double.parseDouble(Helper
                                                						.correctDouble((String) hshFinlValues
                                                								.get("txt_freetext2"))) == 0)
                                                				&& (Double.parseDouble(Helper
                                                						.correctDouble((String) hshFinlValues
                                                								.get("txt_freetext3"))) == 0)
                                                				&& (Double.parseDouble(Helper
                                                						.correctDouble((String) hshFinlValues
                                                								.get("txt_freetext4"))) == 0) && (Double
                                                				.parseDouble(Helper
                                                						.correctDouble((String) hshFinlValues
                                                								.get("txt_freetext5"))) == 0))) {
                                                %>
          		
               <tr> 
                  <td width="25%">&nbsp;<%=Helper.correctNull((String) hshFinlValues
									.get("intcompfreetxt_txt1"))%>&nbsp;</td>
                  <%
                  	if (!year1.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext1"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year2.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext2"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year3.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext3"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year4.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext4"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year5.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext5"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
               </tr>
               
               <%
                              	}
                              %>
               
               
                 <%
                                               	if (!((Double.parseDouble(Helper
                                               				.correctDouble((String) hshFinlValues
                                               						.get("txt_freetext11"))) == 0)
                                               				&& (Double.parseDouble(Helper
                                               						.correctDouble((String) hshFinlValues
                                               								.get("txt_freetext12"))) == 0)
                                               				&& (Double.parseDouble(Helper
                                               						.correctDouble((String) hshFinlValues
                                               								.get("txt_freetext13"))) == 0)
                                               				&& (Double.parseDouble(Helper
                                               						.correctDouble((String) hshFinlValues
                                               								.get("txt_freetext14"))) == 0) && (Double
                                               				.parseDouble(Helper
                                               						.correctDouble((String) hshFinlValues
                                               								.get("txt_freetext15"))) == 0))) {
                                               %>
               <tr> 
                  <td width="25%">&nbsp;<%=Helper.correctNull((String) hshFinlValues
									.get("intcompfreetxt_txt2"))%>&nbsp;</td>
                  <%
                  	if (!year1.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext11"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year2.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext12"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year3.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext13"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year4.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext14"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year5.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext15"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
               </tr>
               
               <%
                              	}
                              %>
               
                <%
                               	if (!((Double.parseDouble(Helper
                               				.correctDouble((String) hshFinlValues
                               						.get("txt_freetext21"))) == 0)
                               				&& (Double.parseDouble(Helper
                               						.correctDouble((String) hshFinlValues
                               								.get("txt_freetext22"))) == 0)
                               				&& (Double.parseDouble(Helper
                               						.correctDouble((String) hshFinlValues
                               								.get("txt_freetext23"))) == 0)
                               				&& (Double.parseDouble(Helper
                               						.correctDouble((String) hshFinlValues
                               								.get("txt_freetext24"))) == 0) && (Double
                               				.parseDouble(Helper
                               						.correctDouble((String) hshFinlValues
                               								.get("txt_freetext25"))) == 0))) {
                               %>
               <tr> 
                  <td width="25%">&nbsp;<%=Helper.correctNull((String) hshFinlValues
									.get("intcompfreetxt_txt3"))%>&nbsp;</td>
                  <%
                  	if (!year1.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext21"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year2.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext22"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year3.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext23"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year4.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext24"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year5.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext25"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
               </tr>
               <%
               	}
               %>
			</table>
		</div>
	</td>
</tr>
<tr><td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
<td><%=Helper.correctNull((String) hshValues.get("fin_comments_interfirm1")) %></td>
</tr>
</table>
</td>
</tr>


<%
	}
%>

<% if(Helper.correctNull((String)hshValues.get("fincommcheck")).equalsIgnoreCase("Y")) { %>
<tr><td>
<div id="top">
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
				
	<%if(arrFinCommRow!=null&&arrFinCommRow.size()>0){ 
	
	for(int j=0;j<arrFinCommRow.size();j++)
	{ 
		arrCol	= (ArrayList)arrFinCommRow.get(j);%>
		<%if(j==0){ %>
		<tr><td class="title" colspan="2">Financial Position Comments  :</td></tr>
		<%} %>
		<tr>
		<td align="left"><%=Helper.correctNull((String)arrCol.get(0))%></td>
		<td align="left"><%=Helper.correctNull((String)arrCol.get(1))%></td>
		</tr>
		
<%}}%>
</table>
</div>
</td></tr>
<%} %>
<!-- TRANSACTIONS IN THE EXISTING ACCOUNTS-->
<tr>
	<td>
	<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
	<tr><td class="title"><%=intSno++ %>.TRANSACTIONS IN THE EXISTING ACCOUNTS :</td></tr>
	</table>
	</td>
	</tr>
<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<jsp:include page="../print/com_AnnexureV.jsp" flush="true">
		<jsp:param name="pageVal" value="PostSanc"/>
		</jsp:include>
	</td>
</tr>
<%if(!Helper.correctNull((String)hshValues.get("OTHERPARAMS2")).equalsIgnoreCase("")){%>
	<tr>
	<td>
	<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
	<tr><td class="title"><%=intSno++ %>.Present Proposal :</td></tr>
		<tr>
			<td><%=Helper.correctNull((String)hshValues.get("OTHERPARAMS2")) %></td>
		</tr>
	</table>
	</td>
	</tr>
<%} %>
<%if(!Helper.correctNull((String)hshValues.get("OTHERPARAMS5")).equalsIgnoreCase("")){%>
	<tr>
	<td>
	<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
	<tr><td class="title"><%=intSno++ %>.Other Relevant Information :</td></tr>
		<tr>
			<td><%=Helper.correctNull((String)hshValues.get("OTHERPARAMS5")) %></td>
		</tr>
	</table>
	</td>
	</tr>
<%} %>
<%if(!Helper.correctNull((String)hshValues.get("OTHERPARAMS4")).equalsIgnoreCase("")){%>
	<tr>
	<td>
	<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
	<tr><td class="title"><%=intSno++ %>.Ratification, If Any :</td></tr>
		<tr>
			<td><%=Helper.correctNull((String)hshValues.get("OTHERPARAMS4")) %></td>
		</tr>
	</table>
	</td>
	</tr>
<%} %>
<%if(!Helper.correctNull((String)hshValues.get("OTHERPARAMS3")).equalsIgnoreCase("")){%>
	<tr>
	<td>
	<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
	<tr><td class="title"><%=intSno++ %>.RECOMMENDATIONS :</td></tr>
		<tr>
			<td><%=Helper.correctNull((String)hshValues.get("OTHERPARAMS3")) %></td>
		</tr>
	</table>
	</td>
	</tr>
<%} 
if(arrRecommRow!=null && arrRecommRow.size()>0){%>

<tr>
	<td>
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br>NATURE OF FACILITY AND LIMITS:</td>
			</tr>
			<tr>
				<td align="right" width=""><%=strAmtValueIn%></td>
			</tr>
		</table>
	</td>
</tr>
<tr>
	<td>
		<div id="top">
			<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%
				if (arrRecommRow != null && arrRecommRow.size() > 0) {
			%>
			<tr>
				<td width="3%" align="center">Sl.No</td>
				<td width="35%" align="center">Type of Facility</td>
				<td width="25%" align="center">Type of Limit</td>
				<td width="10%" align="center">Amount</td>
				<!--<td width="27%" align="center">Remark</td>
			--></tr>
			<%
				for (int i = 0; i < arrRecommRow.size(); i++) {
						arrCol = (ArrayList) arrRecommRow.get(i);
			%>
			<tr>
				<td align="center"><%=i + 1%>.</td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(0)).toUpperCase()%></td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(5))%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctDouble(jtn.format(Double.parseDouble(Helper
									.correctDouble((String) arrCol.get(1))))),strAmountValue)%></td>
				<!--<td align="left"><%=Helper.changetoTitlecase((String) arrCol.get(8))%></td>
			--></tr>
			<%
				}
				} else {
			%>
			<tr><td align="left" style="border:none;"><%=strNil%></td></tr>
			<%
				}
			%>
			</table>
		</div>
	</td>
</tr>

<tr>
	<td>
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br>RATE OF INTEREST/ COMMISSION:</td>
			</tr>
			<tr>
				<td align="right" width=""><%=strAmtValueIn%></td>
			</tr>
		</table>
	</td>
</tr>
<%if(strSessionModuleType.equalsIgnoreCase("CORP")){ %>
<tr>
	<td>
		<div id="top">
		<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
			<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%int j=0;
			if(arrRecommRow!=null&&arrRecommRow.size()>0 && strWhetherBRAvail.equalsIgnoreCase("Y")){ 
				 %>
			<tr>
				<td width="3%" align="center">Sl.No</td>
				<td width="47%" align="center">Type of Facility</td>
				<td width="20%" align="center">Amount</td>
				<td width="30%" align="center">Rate of Interest/Commission</td>
			</tr>
			<%for(int i=0;i<arrRecommRow.size();i++){
				arrCol	=  (ArrayList)arrRecommRow.get(i);
				if(Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("BR")){
					j=j+1;
			%>
			<tr>
				<td align="center"><%=j%>.</td>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(0)).toUpperCase()%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctDouble(jtn.format(Double.parseDouble(Helper
									.correctDouble((String) arrCol.get(1))))),strAmountValue)%></td>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(3))%></td>
			</tr>
			<%} }}%>
<%if(arrRowNonBr!=null && arrRowNonBr.size()>0)
	{
		for(int k=0;k<arrRowNonBr.size();k++)
		{
			arrColNonBr=(ArrayList)arrRowNonBr.get(k);
			if(arrColNonBr.size()>0)
			{
			%>
			<tr>
			<td align="center"><%=j+1%>.</td>
			<td><%=Helper.correctNull((String)arrColNonBr.get(0)).toUpperCase()%></td>
			<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
									.correctDouble((String) arrColNonBr.get(2))))),strAmountValue)%></td>
			<td><%=Helper.correctNull((String)arrColNonBr.get(1))%></td>
			</tr>
			<%	
			}
			j=j+1;
		}
	}%>
	</table>
		</div>
	<%
}else{%>
	<tr>
	<td>
		<div id="top">
		<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
			<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%if(arrRecommRow!=null&&arrRecommRow.size()>0){ 
				int j=0; %>
			<tr>
				<td width="3%" align="center">Sl.No</td>
				<td width="47%" align="center">Type of Facility</td>
				<td width="20%" align="center">Amount</td>
				<td width="30%" align="center">Rate of Interest/Commission</td>
			</tr>
			<%for(int i=0;i<arrRecommRow.size();i++){
				arrCol	=  (ArrayList)arrRecommRow.get(i);
					j=j+1;
			%>
			<tr>
				<td align="center"><%=j%>.</td>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(0)).toUpperCase()%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
									.correctDouble((String) arrCol.get(1))))),strAmountValue)%></td>
				<%if(Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("BR")){ %>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(3))%></td>
				<%}else{ %>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(16))%> at the Rate of <%=Helper.correctNull((String)arrCol.get(3))%> % </td>
				<%} %>
			</tr>
			<%}}%>
			</table>
		</div>
	</td>
</tr>
<%}%>



<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br>MARGIN:</td>
			</tr>
			<tr>
				<td align="right" width=""><%=strAmtValueIn%></td>
			</tr>
		</table>
	</td>
</tr>
<tr>
	<td>
		<div id="top">
			<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%
				if (arrRecommRow != null && arrRecommRow.size() > 0) {
			%>
			<tr>
				<td width="3%" align="center">Sl.No</td>
				<td width="47%" align="center">Type of Facility</td>
				<td width="20%" align="center">Amount</td>
				<td width="30%" align="center">Margin</td>
			</tr>
			<%
				for (int i = 0; i < arrRecommRow.size(); i++) {
						arrCol = (ArrayList) arrRecommRow.get(i);
			%>
			<tr>
				<td align="center"><%=i + 1%>.</td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(0)).toUpperCase()%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
									.correctDouble((String) arrCol.get(1))))),strAmountValue)%></td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(10))%></td>
			</tr>
			<%
				}
				} else {
			%>
			<tr><td align="left" style="border:none;"><%=strNil%></td></tr>
			<%
				}
			%>
			</table>
		</div>
	</td>
</tr>

<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br>PERIOD:</td>
			</tr>
			<tr>
				<td align="right" width=""><%=strAmtValueIn%></td>
			</tr>
		</table>
	</td>
</tr>
<tr>
	<td>
		<div id="top">
			<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%
				if (arrRecommRow != null && arrRecommRow.size() > 0) {
			%>
			<tr>
				<td width="3%" align="center">Sl.No</td>
				<td width="37%" align="center">Type of Facility</td>
				<td width="20%" align="center">Amount</td>
				<td width="15%" align="center">Tenor <br>(in Months)</td>
				<td width="15%" align="center">Initial Holiday/ Gestation/ Moratorium Period <br>(in Months)</td>
				<td width="15%" align="center">Due Date</td>
			</tr>
			<%
				for (int i = 0; i < arrRecommRow.size(); i++) {
						arrCol = (ArrayList) arrRecommRow.get(i);
			%>
			<tr>
				<td align="center"><%=i + 1%>.</td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(0)).toUpperCase()%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
									.correctDouble((String) arrCol.get(1))))),strAmountValue)%></td>
				<td align="right"><%=Helper.correctInt((String) arrCol.get(6))%></td>
				<td align="right"><%=Helper.correctNull((String) arrCol.get(11))%></td>
				<%if(!Helper.correctNull((String) arrCol.get(15)).equalsIgnoreCase("")){ %>
				<td align="center"><%=Helper.correctNull((String) arrCol.get(15))%></td>
				<%}else{ %>
				<td align="center">-</td>
				<%} %>
			</tr>
			<%
				}
				} else {
			%>
			<tr><td align="left" style="border:none;"><%=strNil%></td></tr>
			<%
				}
			%>
			</table>
		</div>
	</td>
</tr>

<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br>MODE OF REPAYMENT:</td>
			</tr>
			<tr>
				<td align="right" width=""><%=strAmtValueIn%></td>
			</tr>
		</table>
	</td>
</tr>
<tr>
	<td>
		<div id="top">
			<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%
				if (arrRecommRow != null && arrRecommRow.size() > 0) {
			%>
			<tr>
				<td width="3%" align="center">Sl.No</td>
				<td width="47%" align="center">Type of Facility</td>
				<td width="30%" align="center">Mode of Repayment</td>
			</tr>
			<%
				for (int i = 0; i < arrRecommRow.size(); i++) {
						arrCol = (ArrayList) arrRecommRow.get(i);
			%>
			<tr>
				<td align="center"><%=i + 1%>.</td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(0)).toUpperCase()%></td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(9))%></td>
			</tr>
			<%
				}
				} %>
			</table>
		</div>
	</td>
</tr>

<%} %>			
			
		<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="90%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
			<td align="left">
			Branch Head
			</td>
			</tr>
			
			<tr>
			<td align="center">
			_____________________________________________________________________________________________________________________________________________
			</td>
			</tr>
			<%if(Helper.correctNull((String)hshValues.get("strModifiedTerms")).contains("@REODWC@")){ %>
			<tr class="title">
			<td align="center"><u>FOR REGIONAL OFFICE/ HEAD OFFICE USE</u></td>
			</tr>
			<tr>
			<td>
			<p>In the light of the above, the working capital limits of <b><%=Helper.correctNull((String)hshValues.get("perapp_title"))%>.&nbsp;<%=Helper.correctNull((String)hshValues.get("perapp_name"))%></b> reviewed and permission accorded to allow the operations in the working capital limits for a period of six months from the date of this review  i.e., upto <b><%=Helper.correctNull((String)hshValues.get("strReviewDate"))%></b>, on the terms & conditions mentioned below:
			</td>
			</tr>
			<%} %>
		</table>
	</td>
</tr>


	
	<tr>
	<td>
	<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr><td class="title"><br>TERMS AND CONDITIONS:</td></tr>

<%
	int j=0;
	int sub=0;
	int main=0;
	String prevSno="";
	String currParentId="";
	String termsno = "";
	boolean booflag=true;
	boolean subflag=true;

	if(arrFacilityTerm0!=null && arrFacilityTerm0.size()>0)
	{ %>
		<tr><td class="title"><b>Specific:</b></td></tr>
	<%	j=arrFacilityTerm0.size();
		for(int i=0;i<arrFacilityTerm0.size();i++)
		{
			termsno = Helper.correctNull((String) arrFacilityIdVal0.get(i));
			currParentId=Helper.correctNull((String) arrParentID0.get(i));
			if(currParentId.equalsIgnoreCase("0") && subflag==true )
			{
				booflag=true;
				sub=0;
			}
			if(booflag)
			{
				main = main+1;
				prevSno=Helper.correctNull((String) arrFacilityIdVal0.get(i));
				booflag=false;
			}
		%>
		<%if(currParentId.equalsIgnoreCase("0"))
		{
			subflag=true;
		%>
		<tr> 
		  	<td valign="top" nowrap="nowrap">
		      	<table cellpadding="3" cellspacing="0" width="100%" >
			      	<tr>
			      		<td width="2%" valign="top"><%=main%>.</td>
			      		<td style="text-align: justify;"><%=arrFacilityTerm0.get(i)%></td>
			      	</tr>
		      	</table>
	      	</td>
		</tr>
		<%}
		if(prevSno.equalsIgnoreCase(currParentId) && (!currParentId.equalsIgnoreCase("0")))
		{
		%>
		<tr> 
	      	<td valign="top" nowrap="nowrap">
		      	<table cellpadding="3" cellspacing="0" width="98%" align="right">
			      	<tr>
			      		<td width="2%" valign="top">&nbsp;<%=main%>.<%=++sub%></td>
			      		<td style="text-align: justify;"><%=arrFacilityTerm0.get(i)%></td>
			      	</tr>
		      	</table>
	      	</td>
	    </tr>
		
		<%}
		}
	} %>
	<%
	if(arrFacilityTermApp0!=null)
	{
		for(int i=0;i<arrFacilityTermApp0.size();i++)
			
		{  main = main+1;
		%>
		<tr > 
		  <td align="center"> 
		    <div align="left" style="text-align: justify;"><%=main%>.&nbsp;<%=arrFacilityTermApp0.get(i)%></div>
		  </td>
		</tr>
		<%
		}
	} %>
	

<%-- Terms and Conditon - General -->
   <jsp:include page="../print/com_AnnexureVII.jsp" flush="true">  
   <jsp:param name="pagetype" value="sancborrower" />       
   </jsp:include>
<!-- End --%>
			   
<tr>
	<td>
		<table width="95%" align="center" cellpadding="0" cellspacing="0" border="0">
		<%if(arrDeleRow!=null&&arrDeleRow.size()>0)
		{ 
			for(int i=0;i<arrDeleRow.size();i++)
			{
				arrCol	=  (ArrayList)arrDeleRow.get(i);
		%>
			<%if(i%2==0){ %>
			<tr><td><br><%=Helper.correctNull((String)arrCol.get(0))%></td></tr>
			<tr><td class="title"><%=Helper.correctNull((String)arrCol.get(1))%></td></tr>
			<%}else{ %>
			<tr><td align="right"><br><%=Helper.correctNull((String)arrCol.get(0))%></td></tr>
			<tr><td align="right" class="title"><%=Helper.correctNull((String)arrCol.get(1))%></td></tr>
			<%} %>
		<%} } %>
		</table>
	</td>
</tr>
</table>
</td>
</tr>
</table>	
</body>
</html>
