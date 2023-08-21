<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ page import="java.util.*,java.text.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<% request.setAttribute("_cache_refresh", "true"); %>
<laps:handleerror/>
<%
ArrayList arrBranchRow		= new ArrayList();
ArrayList arrBranchCol		= new ArrayList();
ArrayList arrFactoryRow		= new ArrayList();
ArrayList arrFactoryCol		= new ArrayList();
ArrayList arrGodownRow		= new ArrayList();
ArrayList arrGodownCol		= new ArrayList();
ArrayList arrPromoterRow	= new ArrayList();
ArrayList arrOutCol			= new ArrayList();
ArrayList arrGuaRow			= new ArrayList();
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
ArrayList arrDigiRating=new ArrayList();
arrDigiRating=(ArrayList)hshValues.get("arrDigiRating");

ArrayList arrRestRow=new ArrayList();
ArrayList arrRestCol=new ArrayList();
String strAmtValueIn = Helper.correctNull((String)hshValues.get("strAmtValueIn"));
String strPagetype = Helper.correctNull((String)request.getParameter("pageVal"));
String strHeaderFlag="true";
if(strPagetype.equalsIgnoreCase("PROPOSALLC") || strPagetype.equalsIgnoreCase("MCFD")|| strPagetype.equalsIgnoreCase("ECLGS")|| strPagetype.equalsIgnoreCase("DPN"))
{
	hshValues = (HashMap)hshValues.get("PROPOSALLC");
}

HashMap hshAddeDetails=new HashMap();

java.text.NumberFormat jtn	= java.text.NumberFormat.getInstance();

jtn.setMaximumFractionDigits(2);
jtn.setMinimumFractionDigits(2);
jtn.setGroupingUsed(false);

if(hshValues!=null)
{
	arrFactoryRow	= (ArrayList)hshValues.get("arrBranchRow0");
	arrBranchRow	= (ArrayList)hshValues.get("arrBranchRow1");
	arrGodownRow	= (ArrayList)hshValues.get("arrBranchRow2");
	arrPromoterRow	= (ArrayList)hshValues.get("arrPromoterRow");
	arrGuaRow		= (ArrayList)hshValues.get("arrGuaRow");
	hshAddeDetails  = (HashMap)hshValues.get("hshRespDetails");
	arrRowRating = (ArrayList)hshValues.get("arrRowRating");
	arrRowDefault = (ArrayList)hshValues.get("arrRowDefault");
	arrRowEcgc = (ArrayList)hshValues.get("arrRowEcgc");
	arrRowRelation = (ArrayList)hshValues.get("Relationship");
	arrRowCIBIL = (ArrayList)hshValues.get("arrRowCIBIL");
	arrRowIntRating = (ArrayList)hshValues.get("arrRowIntRating");
	arrRowShare = (ArrayList)hshValues.get("Shareholding");
	arrRowNature = (ArrayList)hshValues.get("Natureofshare");
	arrCoApplicant=(ArrayList)hshValues.get("arrCoApplicant");
	arrRowRatingRMD=(ArrayList)hshValues.get("arrRowRatingRMD");
	arrRestCol=(ArrayList)hshValues.get("arrRestRow");
}

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
String IntRat=Helper.correctNull((String)hshValues.get("IntRat"));
String strAmountValue=Helper.correctNull((String)hshValues.get("strAmountValue"));



if(strAmountValue.equalsIgnoreCase("C")){
	strAmtValueIn="( Rs. in Crore )";
}else if(strAmountValue.equalsIgnoreCase("L")){
	strAmtValueIn="( Rs. in Lacs )";
}else{
	strAmtValueIn="( Amount in Rs. )";
}

String str_birflag=Helper.correctNull((String)hshValues.get("bir_flag"));
String strAPPLOANSUBTYPE_DIGI=Helper.correctNull((String)session.getAttribute("APP_LOANSUBTYPE_DIGI"));
ArrayList arrRowBor=new ArrayList();
ArrayList arrColBor=new ArrayList();
	if(hshValues!=null)
	{
		arrRowBor = (ArrayList)hshValues.get("arrRowBor");
	}
%>
<html>
<head>
<title>Annexure - II</title>
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
<body>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<%if(!(strPagetype.equalsIgnoreCase("PROPOSALLC") || strPagetype.equalsIgnoreCase("MCFD")|| strPagetype.equalsIgnoreCase("ECLGS")|| strPagetype.equalsIgnoreCase("DPN"))) {%>
<tr><td align="center" class="title"><br>ANNEXURE	- II</td></tr>
<%} else if(strPagetype.equalsIgnoreCase("PROPOSALLC")|| strPagetype.equalsIgnoreCase("ECLGS")|| strPagetype.equalsIgnoreCase("DPN")) { %>
<tr><td align="left" class="title"><br>BORROWERS PROFILE / HISTORY & BACKGROUND</td></tr>
<%} else if(strPagetype.equalsIgnoreCase("MCFD")) { %>
<tr><td align="left" class="title"><br>II.&nbsp;BORROWERS PROFILE / HISTORY & BACKGROUND</td></tr>
<%} %>
<tr>
<td>
<div id="top">
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
<%if(!(strPagetype.equalsIgnoreCase("PROPOSALLC") || strPagetype.equalsIgnoreCase("MCFD")|| strPagetype.equalsIgnoreCase("ECLGS")|| strPagetype.equalsIgnoreCase("DPN"))) {%>
<tr><td align="left" class="title" colspan="3"><div>a. Applicant's Profile :</div></td></tr>
<%}%>
<tr>
<%
int setRowspan=1;
	setRowspan+=RowCount+intBranchSize;
	if(strPagetype.equalsIgnoreCase("PROPOSALLC")) {
		setRowspan=1;
	}
%>
<td align="left" width="3%" rowspan="<%=setRowspan%>" valign="top">1)&nbsp;a.</td>
<td align="left" width="35%">Name of the Applicant</td>
<td align="left" width="62%"><%=Helper.correctNull((String)hshValues.get("perapp_title"))%>.&nbsp;<%=Helper.correctNull((String)hshValues.get("perapp_name"))%></td>
</tr>
<%if(!strPagetype.equalsIgnoreCase("PROPOSALLC")) {%>
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
<%}} %>
<%
int intRowspan=0;
if(!(Helper.correctNull((String)hshValues.get("cbs_static_data_desc")).equalsIgnoreCase("")))
{
	intRowspan++;
}
if(!strPagetype.equalsIgnoreCase("PROPOSALLC")) {
	if(!(Helper.correctNull((String)hshValues.get("cominfo_incorporation_date")).equalsIgnoreCase("")))
	{
		intRowspan++;
	}
	if(!(Helper.correctNull((String)hshValues.get("cominfo_commencement_date")).equalsIgnoreCase("")))
	{
		intRowspan++;
	}
	if(!(Helper.correctNull((String)hshValues.get("perapp_dob")).equalsIgnoreCase("")))
	{
		intRowspan++;
	}
}
if(!(Helper.correctNull((String)hshValues.get("perapp_banksince")).equalsIgnoreCase("")))
{
	intRowspan++;
}
if(Helper.correctNull((String)hshValues.get("COMINFO_GSTINREG")).equalsIgnoreCase("Y"))
{
	intRowspan++;
}
if(!Helper.correctNull((String)hshValues.get("PERAPP_MSE_REGNO")).equalsIgnoreCase(""))
{
	intRowspan++;
}
if(!Helper.correctNull((String)hshValues.get("PERAPP_UDYOG_AADHAR")).equalsIgnoreCase(""))
{
	intRowspan++;
}
if(!(Helper.correctNull((String)hshValues.get("PERAPP_UDYAM_REGNO")).equalsIgnoreCase("")))
{
	intRowspan++;
}
if(!Helper.correctNull((String)hshValues.get("PERAPP_CERTIFICATION_DATE")).equalsIgnoreCase("")){intRowspan++;}
if(!Helper.correctNull((String)hshValues.get("PERAPP_MSME_CLASSIFICATION")).equalsIgnoreCase("")){
	intRowspan++;} 
if(!Helper.correctNull((String)hshValues.get("perapp_status")).equalsIgnoreCase("")||!Helper.correctNull((String)hshValues.get("perapp_status")).equalsIgnoreCase("0")||
		Helper.correctNull((String)hshValues.get("perapp_status")).equalsIgnoreCase("")||Helper.correctNull((String)hshValues.get("perapp_status")).equalsIgnoreCase("0")){
	intRowspan++;}
if(!Helper.correctNull((String)hshValues.get("perapp_relation_bankstaff")).equalsIgnoreCase("")||!Helper.correctNull((String)hshValues.get("perapp_relation_bankstaff")).equalsIgnoreCase("0")||
		Helper.correctNull((String)hshValues.get("perapp_relation_bankstaff")).equalsIgnoreCase("")||Helper.correctNull((String)hshValues.get("perapp_relation_bankstaff")).equalsIgnoreCase("0")){
	intRowspan++;}
if(Helper.correctNull((String)hshValues.get("perapp_relation_bankstaff_val")).equalsIgnoreCase("005")||Helper.correctNull((String)hshValues.get("perapp_relation_bankstaff_val")).equalsIgnoreCase("006")){
if(!Helper.correctNull((String)hshValues.get("perapp_relat_staffid")).equalsIgnoreCase("")||Helper.correctNull((String)hshValues.get("perapp_relat_staffid")).equalsIgnoreCase("")){
	intRowspan++;}

if(!Helper.correctNull((String)hshValues.get("perapp_relation_staffname")).equalsIgnoreCase("")||Helper.correctNull((String)hshValues.get("perapp_relation_staffname")).equalsIgnoreCase("")){
	intRowspan++;
	intRowspan++;
}
}else{
	if(!Helper.correctNull((String)hshValues.get("perapp_relation_staffname")).equalsIgnoreCase("")||Helper.correctNull((String)hshValues.get("perapp_relation_staffname")).equalsIgnoreCase("")||Helper.correctNull((String)hshValues.get("perapp_relation_staffname")).equalsIgnoreCase("0")){
		intRowspan++;
	}
	intRowspan++;
}

if(Helper.correctNull((String) hshValues.get("APP_RENEW_FLAG")).equalsIgnoreCase("S")){
if(!Helper.correctNull((String)hshValues.get("strrestscheme")).equalsIgnoreCase("")){
	intRowspan++;
}
if(!Helper.correctNull((String)hshValues.get("PERAPP_INVOCDATE")).equalsIgnoreCase("")||Helper.correctNull((String)hshValues.get("PERAPP_INVOCDATE")).equalsIgnoreCase("")){
	intRowspan++;
}
}
if(!Helper.correctNull((String)hshValues.get("perapp_blood_relation")).equalsIgnoreCase("")||Helper.correctNull((String)hshValues.get("perapp_blood_relation")).equalsIgnoreCase("")){
	intRowspan++;
}
if(Helper.correctNull((String)hshValues.get("corprestructureval")).equalsIgnoreCase("Y")) {

}
%>
<tr>
<td align="right" rowspan="<%=intRowspan%>" valign="top">b.</td>
<td align="left">Constitution</td>
<td align="left"><%=Helper.correctNull((String)hshValues.get("cbs_static_data_desc"))%></td>
</tr>
<%if(!strPagetype.equalsIgnoreCase("PROPOSALLC")) {%>
<% if(!(Helper.correctNull((String)hshValues.get("cominfo_incorporation_date")).equalsIgnoreCase("")))
{%>
<tr>
<td align="left">Date of Incorporation</td>
<td align="left"><%=Helper.correctNull((String)hshValues.get("cominfo_incorporation_date"))%></td>
</tr>
<%} 
if(!(Helper.correctNull((String)hshValues.get("cominfo_commencement_date")).equalsIgnoreCase("")))
{%>
<tr>
<td align="left">Date of commencement of business</td>
<td align="left"><%=Helper.correctNull((String)hshValues.get("cominfo_commencement_date"))%></td>
</tr>
<%}
if(!(Helper.correctNull((String)hshValues.get("perapp_dob")).equalsIgnoreCase("")))
{%>
<tr>
<% if(app_constitution.equalsIgnoreCase("01") || app_constitution.equalsIgnoreCase("02")){%>
<td align="left">Date of Birth</td>
<%}else{ %>
<td align="left">Date of Establishment</td>
<%}%>
<td align="left"><%=Helper.correctNull((String)hshValues.get("perapp_dob"))%></td>
</tr>
<%}}%>
<%if(!(Helper.correctNull((String)hshValues.get("perapp_banksince")).equalsIgnoreCase("")))
{%>
<tr>
<td align="left">Dealing with us since</td>
<td align="left"><%=Helper.correctNull((String)hshValues.get("perapp_banksince"))%></td>
</tr>
<%} %>
<%if(Helper.correctNull((String)hshValues.get("COMINFO_GSTINREG")).equalsIgnoreCase("Y")){ %>
<tr>
<td align="left">GSTIN No.</td>
<%String[] strArr=Helper.correctNull((String)hshValues.get("COMINFO_GSTIN")).split("@");
%>
<td align="left"><%
for(int i=0;i<strArr.length;i++)
{
out.println(strArr[i]);%>
</br>
<%}
%></td>
</tr>
<%} %>
<%if(!Helper.correctNull((String)hshValues.get("PERAPP_MSE_REGNO")).equalsIgnoreCase("")){ %>
<tr>
<td align="left" >MSE Regno</td>
<td align="left" ><%=Helper.correctNull((String)hshValues.get("PERAPP_MSE_REGNO"))%></td>
</tr>
<%} %>
<%if(!Helper.correctNull((String)hshValues.get("PERAPP_UDYOG_AADHAR")).equalsIgnoreCase("")){ %>
<tr>
<td align="left" >Udyog Aadhaar Number </td>
<td align="left" ><%=Helper.correctNull((String)hshValues.get("PERAPP_UDYOG_AADHAR"))%></td>
</tr>
<%} %>
<%if(!Helper.correctNull((String)hshValues.get("PERAPP_UDYAM_REGNO")).equalsIgnoreCase("")){ %>
<tr>
<td align="left" >Udyam Registration Certificate Number</td>
<td align="left" ><%=Helper.correctNull((String)hshValues.get("PERAPP_UDYAM_REGNO"))%></td>
</tr>
<%} %>
<%if(!Helper.correctNull((String)hshValues.get("PERAPP_CERTIFICATION_DATE")).equalsIgnoreCase("")){ %>
<tr>
<td align="left" >Udyam Certification Date</td>
<td align="left"><%=Helper.correctNull((String)hshValues.get("PERAPP_CERTIFICATION_DATE"))%></td>
</tr>
<%} %>
<%if(!Helper.correctNull((String)hshValues.get("PERAPP_MSME_CLASSIFICATION")).equalsIgnoreCase("")){ %>
<tr>
<td align="left" >MSME Classification as per Udyam Registration Certificate</td>
<td align="left"><%=Helper.correctNull((String)hshValues.get("PERAPP_MSME_CLASSIFICATION"))%></td>
</tr>
<%} %>
<%if(Helper.correctNull((String) hshValues.get("APP_RENEW_FLAG")).equalsIgnoreCase("S")){%>
<%if(!Helper.correctNull((String)hshValues.get("PERAPP_INVOCDATE")).equalsIgnoreCase("")||Helper.correctNull((String)hshValues.get("PERAPP_INVOCDATE")).equalsIgnoreCase("")){ %>

<tr>
	<td align="left">Date of Restructure Invocation</td>
	<td align="left"><%=Helper.correctNull((String) hshValues.get("PERAPP_INVOCDATE"))%></td>
</tr>
<%} %>
	<% if(arrRestCol!=null&&arrRestCol.size()>0)
{%>
<tr>
	<td align="left">Restructure Settlement Scheme</td>
<td align="left">
	<%for(int i=0;i<arrRestCol.size();i++)
	{
	 arrRestRow=(ArrayList)arrRestCol.get(i);%>
	
	<%=Helper.correctNull((String)arrRestRow.get(0))%></br>
<%
}%>	
	</td>
	</tr>
	<%}} %>
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
				if(!Helper.correctNull((String)hshValues.get("indinfo_staff_id")).equalsIgnoreCase("")||Helper.correctNull((String)hshValues.get("perapp_relation_staffname")).equalsIgnoreCase("")){
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
			
   <%if(Helper.correctNull((String)hshValues.get("corprestructureval")).equalsIgnoreCase("Y")) {%>
<tr>
<td align="left" class="title" colspan="3">
<div id="top">
<table width="98%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr class="tblhead" align="center">
				<td colspan="4"><b>&nbsp;&nbsp; Eligibility under Restructure:</b></td>
			</tr>
<tr>
<td align="left" >a.</td>
<td align="left"><b>Type of Borrower</b></td>

<td align="left" colspan="2"><%=Helper.correctNull((String)hshValues.get("strborrower"))%></td>

</tr>
<tr>
<td align="left">b.</td>
<td align="left"><b>Purpose of the Loan</b></td>
<td align="left" colspan="1"><%=Helper.correctNull((String)hshValues.get("strpurposeloan"))%></td>
<%if(Helper.correctNull((String)hshValues.get("COM_PURPOSE_OF_LOAN")).equalsIgnoreCase("3")){ %>
<td><%=Helper.correctNull((String)hshValues.get("stragriallied"))%></td>
<%}else{ %>
<td colspan="1"></td>
<%} %>
</tr>
		
				<tr>
					<td align="center" colspan="4" ><b>RBI Parameters</b></td>
				</tr>
			
				<tr >
					<td ><b>S.No<b></td>
					<td ><b>Parameters under<b></td>
					<td><b>Instant Case<b></td>
					<td ><b>Eligible<b></td>
				</tr>
				<tr>
					<td>1.</td>
					<td nowrap="nowrap"><b>Permitted activities under Resolution Frame work</b></td>
					<td><%=Helper.correctNull((String)hshValues.get("strpermact"))%>
					<%  if(Helper.correctNull((String)hshValues.get("COM_PERM_ACT")).equalsIgnoreCase("6")){%><%="-"+Helper.correctNull((String)hshValues.get("COM_OTHER_LOAN"))%><%} %></td>
					<td><%=Helper.correctNull((String)hshValues.get("strpermactelig"))%></td>
				</tr>
				<tr>
					<td>2.</td>
					<td nowrap="nowrap"><b>Aggregate exposure across all Member Lending Institutions (MLIs) as on March 31,2021</b></td>
					<td><%=Helper.correctNull((String)hshValues.get("COM_EXPOSUE"))%></td>
					<td><%=Helper.correctNull((String)hshValues.get("strexposueelig"))%></td>
				</tr>
				<% if(Helper.correctNull((String)hshValues.get("COM_TYPE_OF_BORROWER")).equalsIgnoreCase("1")){%>
				<tr>
					<td id="val1">3.</td>
					<td nowrap="nowrap"><b>whether borrower availed Resolution Framework 1.0</b></td>
					<td><%=Helper.correctNull((String)hshValues.get("strborroweravailed"))%></td>
					<td><%=Helper.correctNull((String)hshValues.get("strborroweravailedelig"))%></td>
				</tr>
				<%} %>
				<% if(Helper.correctNull((String)hshValues.get("COM_TYPE_OF_BORROWER")).equalsIgnoreCase("1")&& Helper.correctNull((String)hshValues.get("COM_BRW_AVAILED")).equalsIgnoreCase("Y")){%>
				<tr>
					<td nowrap="nowrap" id="val1">3.a)</td>
					<td nowrap="nowrap"><b>Previous Moratorium Granted</b></td>
					<td><%=Helper.correctNull((String)hshValues.get("COM_PREVIOUS_MOROTORIUM"))%></td>
<td></td>
				</tr>
				<tr>
					<td nowrap="nowrap">3.b)</td>
					<td nowrap="nowrap"><b>Already extended Due date in CBS</b></td>
					<td><%=Helper.correctNull((String)hshValues.get("COM_EXTENDED_DATE"))%></td>
					<td></td>
				</tr>
				<tr id="id_borrower3">
					<td nowrap="nowrap">3.c)</td>
					<td nowrap="nowrap"><b>Present Moratorium Granted</b></td>
					<td><%=Helper.correctNull((String)hshValues.get("COM_PRESENT_MOROTORIUM"))%></td>
<td></td>
				</tr>
<%} %>


				<tr>
								<% if(Helper.correctNull((String)hshValues.get("COM_TYPE_OF_BORROWER")).equalsIgnoreCase("1")){%>
				
					<td id="val2">4.</td>
					<%}else{ %>
						<td id="val2">3.</td>
					<%} %>
					<td nowrap="nowrap" ><b>Whether GSTIN Registered<b></td>
					<%
					String strwhethergstrn=Helper.correctNull((String)hshValues.get("COMINFO_GSTINREG"));
					if(strwhethergstrn.equalsIgnoreCase("Y")){
						strwhethergstrn="Yes";
					}else if(strwhethergstrn.equalsIgnoreCase("N")){
						strwhethergstrn="No";
					}else if (strwhethergstrn.equalsIgnoreCase("NA")){
						strwhethergstrn="Not Applicable";
					}else{
						strwhethergstrn="";
					}
					 %>
					 <td><%=strwhethergstrn %></td>
					 <td>&nbsp;</td>
					 </tr>
					 <tr>
											
						<%if(Helper.correctNull((String)hshValues.get("COMINFO_GSTINREG")).equalsIgnoreCase("Y")){ %>
											<td >a)</td>
						
						<td nowrap="nowrap" ><b> GSTIN <b></td>	
						<td>			
						<%
						String[] strArr1=Helper.correctNull((String)hshValues.get("COMINFO_GSTIN")).split("@");
						for(int a=0;a<strArr1.length;a++)
						{
							%>
							
						<%=strArr1[a] %><br/>
									 
						<%} }else if(Helper.correctNull((String)hshValues.get("COMINFO_GSTINREG")).equalsIgnoreCase("N")){%>
						<td >a)</td>
						<td nowrap="nowrap" ><b>Whether GSTIN Exempted <b></td>				
						<td>
						<%String strexempted=Helper.correctNull((String)hshValues.get("COMINFO_GST_EXEMPTED"));
						if(strexempted.equalsIgnoreCase("Y")){
							strexempted="Yes";
							
						}else if(strexempted.equalsIgnoreCase("N")){
							strexempted="No";
						}else{
							strexempted="";
						}
						%>
						<%=strexempted%><br/>
						
						<%} else{%>
			        		
						
						<%} %>
						</td>
						<td></td>
				</tr>
				<% if(Helper.correctNull((String)hshValues.get("COM_TYPE_OF_BORROWER")).equalsIgnoreCase("3")){%>
				<tr>
					<td id="val3">4.</td>
					<td nowrap="nowrap"><b>Restructure under earlier MSME Restructuring Schemes</b></td>
					<td><%=Helper.correctNull((String)hshValues.get("strmsmerestscheme"))%></td>
					<td><%=Helper.correctNull((String)hshValues.get("strmsmerestschemeelig"))%></td>
				</tr>
				<%} %>
				<% if(Helper.correctNull((String)hshValues.get("COM_TYPE_OF_BORROWER")).equalsIgnoreCase("2")){%>
				<tr>
					<td id="val4">4.</td>
					<td nowrap="nowrap"><b>Restructured under earlier Resolution Framework 1.0</b></td>
					<td><%=Helper.correctNull((String)hshValues.get("strframework"))%></td>
					<td><%=Helper.correctNull((String)hshValues.get("strframeworkelig"))%></td>
				</tr>
				<%} %>
				<% if(Helper.correctNull((String)hshValues.get("COM_TYPE_OF_BORROWER")).equalsIgnoreCase("4")){%>
				<tr>
					<td id="val4">4.</td>
					<td nowrap="nowrap"><b>Restructured under earlier Resolution Framework 1.0</b></td>
					<td><%=Helper.correctNull((String)hshValues.get("strrestallied"))%></td>
					<td><%=Helper.correctNull((String)hshValues.get("strrestalliedelig"))%></td>
				</tr>
				<%} %>
				
</table>
</div>
</td>
</tr>
<%} %>
<%
if(!strPagetype.equalsIgnoreCase("PROPOSALLC")&&!strPagetype.equalsIgnoreCase("ECLGS")&& !strPagetype.equalsIgnoreCase("DPN")) {
ArrayList arrCoAppCol=new ArrayList();
ArrayList arrCoAppFactory=new ArrayList();
ArrayList arrCoAppBranch=new ArrayList();
ArrayList arrCoAppGodown=new ArrayList();
int k=2;
if(arrCoApplicant!=null && arrCoApplicant.size()>0)
{%>
<tr><td  align="left" class="title" colspan="3"><div> b. Co - Applicant's Profile</div></td></tr>
<%
	for(int j=0;j<arrCoApplicant.size();j++)
	{
		setRowspan=1;
		RowCount=0;intBranchSize=0;
		arrCoAppCol=(ArrayList)arrCoApplicant.get(j);
		if(!Helper.correctNull((String)arrCoAppCol.get(6)).equalsIgnoreCase("")){
			RowCount++;
		}
		if(!Helper.correctNull((String)arrCoAppCol.get(8)).equalsIgnoreCase("")){
			RowCount++;
		}
		if(!Helper.correctNull((String)arrCoAppCol.get(3)).equalsIgnoreCase("01") && !Helper.correctNull((String)arrCoAppCol.get(7)).equalsIgnoreCase("")){
			RowCount++;
		}
		arrCoAppFactory=(ArrayList)arrCoAppCol.get(9);
		arrCoAppBranch=(ArrayList)arrCoAppCol.get(10);
		arrCoAppGodown=(ArrayList)arrCoAppCol.get(11);
		int Facsize=arrCoAppFactory.size();
		int Branchsize=arrCoAppBranch.size();
		int Godownsize=arrCoAppGodown.size();
		if(Facsize>0)
		{
			intBranchSize++;
		}
		if(Branchsize>0)
		{
			intBranchSize++;
		}
		if(Godownsize>0)
		{
			intBranchSize++;
		}
		setRowspan+=RowCount+intBranchSize;
%>
<tr>
<td align="left" width="3%" rowspan="<%=setRowspan%>" valign="top"><%=k %>)&nbsp;a.</td>
<td align="left" width="35%">Name of the Applicant</td>
<td align="left" width="62%"><%=Helper.correctNull((String)arrCoAppCol.get(0))%></td>
</tr>
<%ArrayList arrFac=new ArrayList(); 
ArrayList arrFacCol=new ArrayList(); %>
<%if(Helper.correctNull((String)arrCoAppCol.get(3)).equalsIgnoreCase("01")){ %>
<%if(!Helper.correctNull((String)arrCoAppCol.get(6)).equalsIgnoreCase("")){ %>
<tr>
	<td>Communication Address</td>
	<td><%=Helper.correctNull((String)arrCoAppCol.get(6)).toUpperCase()%></td>
</tr>
<%} %>
<%if(!Helper.correctNull((String)arrCoAppCol.get(8)).equalsIgnoreCase("")){ %>
<tr>
	<td>Permanent Address</td>
	<td><%=Helper.correctNull((String)arrCoAppCol.get(8)).toUpperCase() %></td>
</tr>
<%}%>
<%}else{ %>
<%if(!Helper.correctNull((String)arrCoAppCol.get(6)).equalsIgnoreCase("")){ %>
<tr>
	<td>Registered Office Address</td>
	<td><%=Helper.correctNull((String)arrCoAppCol.get(6)).toUpperCase()%></td>
</tr>
<%} %>
<%if(!Helper.correctNull((String)arrCoAppCol.get(8)).equalsIgnoreCase("")){ %>
<tr>
	<td>Administrative Office Address</td>
	<td><%=Helper.correctNull((String)arrCoAppCol.get(8)).toUpperCase() %></td>
</tr>
<%}%>
<%if(!Helper.correctNull((String)arrCoAppCol.get(7)).equalsIgnoreCase("")){%>
<tr>
	<td>Corporate Address<br></td>
	<td><%=Helper.correctNull((String)arrCoAppCol.get(7)).toUpperCase()%></td>
</tr>
<%}%>
<%} %>
<%if(Facsize>0){%>
<tr>
	<td>Factories<br></td>
	<td>
<%
arrFac=(ArrayList)arrCoAppCol.get(9);
if(arrFac!=null && arrFac.size()>0){
for(int i=0;i<arrFac.size();i++)
	{
	arrFacCol=(ArrayList)arrFac.get(i);%>
	<%=i+1%>).&nbsp;
	<%=Helper.correctNull((String)arrFacCol.get(0)).toUpperCase()%><br>
	<%}}%>	
</td>
</tr>
<%}%>
<%if(Branchsize>0){%>
<tr>
	<td>Branch<br></td>
	<td>
	<%
arrFac=(ArrayList)arrCoAppCol.get(10);
if(arrFac!=null && arrFac.size()>0){
for(int i=0;i<arrFac.size();i++)
	{
	arrFacCol=(ArrayList)arrFac.get(i);%>
	<%=i+1%>).&nbsp;
	<%=Helper.correctNull((String)arrFacCol.get(0)).toUpperCase()%><br>
	<%}}%>
</td>
</tr>
<%}%>
<%if(Godownsize>0){%>
<tr>
	<td>Godown<br></td>
	<td>
	<%
arrFac=(ArrayList)arrCoAppCol.get(11);
if(arrFac!=null && arrFac.size()>0){
for(int i=0;i<arrFac.size();i++)
	{
	arrFacCol=(ArrayList)arrFac.get(i);%>
	<%=i+1%>).&nbsp;
	<%=Helper.correctNull((String)arrFacCol.get(0)).toUpperCase()%><br>
	<%}}%>
	</td>
</tr>
<%}
intRowspan=1;%>
<%if(!(Helper.correctNull((String)arrCoAppCol.get(1)).equalsIgnoreCase("")))
{
	intRowspan++;
}
if(!(Helper.correctNull((String)arrCoAppCol.get(2)).equalsIgnoreCase("")))
{
	intRowspan++;
}
if(!(Helper.correctNull((String)arrCoAppCol.get(4)).equalsIgnoreCase("")))
{
	intRowspan++;
}
if(!(Helper.correctNull((String)arrCoAppCol.get(5)).equalsIgnoreCase("")))
{
	intRowspan++;
}
%>
<tr>
<td align="right" rowspan="<%=intRowspan%>" valign="top">b.</td>
<td align="left">Constitution</td>
<td align="left"><%=Helper.correctNull((String)arrCoAppCol.get(12))%></td>
</tr>
<% if(!(Helper.correctNull((String)arrCoAppCol.get(5)).equalsIgnoreCase("")))
{%>
<tr>
<td align="left">Date of Incorporation</td>
<td align="left"><%=Helper.correctNull((String)arrCoAppCol.get(5))%></td>
</tr>
<%} 
if(!(Helper.correctNull((String)arrCoAppCol.get(4)).equalsIgnoreCase("")))
{%>
<tr>
<td align="left">Date of commencement of business</td>
<td align="left"><%=Helper.correctNull((String)arrCoAppCol.get(4))%></td>
</tr>
<%}
if(!(Helper.correctNull((String)arrCoAppCol.get(1)).equalsIgnoreCase("")))
{%>
<tr>
<% if(Helper.correctNull((String)arrCoAppCol.get(3)).equalsIgnoreCase("01") || Helper.correctNull((String)arrCoAppCol.get(3)).equalsIgnoreCase("02")){%>
<td align="left">Date of Birth</td>
<%}else{ %>
<td align="left">Date of Establishment</td>
<%}%>
<td align="left"><%=Helper.correctNull((String)arrCoAppCol.get(1))%></td>
</tr>
<%}
 if(!(Helper.correctNull((String)arrCoAppCol.get(2)).equalsIgnoreCase("")))
{%>
<tr>
<td align="left">Dealing with us since</td>
<td align="left"><%=Helper.correctNull((String)arrCoAppCol.get(2))%></td>
</tr>
<%} %>
<%k++;}} }%>
<tr>
<td class="title" align="left" colspan="3">
<div>Benificial Owner Details
</div>
<div>
<table width="98%" align="center" cellpadding="3" cellspacing="0" border="0" >
 <% if(arrRowBor!=null&&arrRowBor.size()>0)
{
for(int i=0;i<arrRowBor.size();i++) {
	arrColBor	= (ArrayList)arrRowBor.get(i);
%>
<%if(i==0){ %>
<tr>
<td align="center">Beneficial Owner Customer ID</td>
<td align="center">Name of the Beneficial Owner</td>
<td align="center">Identification Document</td>
<td align="center">Identification Document Number<br/></td>
<td align="center">Percentage of Shares held</td>
<td align="center">Relationship with the borrower</td>
<td align="center">No of shares held</td>
<td align="center">Guarantee available</td>
</tr>
<%} %>
<tr>
<td><%=Helper.correctNull((String)arrColBor.get(0))%></td>
<td><%=Helper.correctNull((String)arrColBor.get(1))%></td>
<td><%=Helper.correctNull((String)arrColBor.get(2))%></td>
<td><%=Helper.correctNull((String)arrColBor.get(3))%></td>
<td><%=Helper.correctNull((String)arrColBor.get(4))%></td>
<td><%=Helper.correctNull((String)arrColBor.get(5))%></td>
<td><%=Helper.correctNull((String)arrColBor.get(6))%></td>
<td><%=Helper.correctNull((String)arrColBor.get(7))%></td>
</tr>
<%}%>
<%}else{%>
<tr><td align="center" style="border:none;"><%=strNil%></td></tr>
<%} %>
</table>
</div>
</td>
</tr>
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
<%if(!Helper.correctNull((String)hshValues.get("cmt_ratingcomments")).equalsIgnoreCase("")){ %>
<tr>
<td colspan="8" align="left">Reason for downgrading: <%=Helper.correctNull((String)hshValues.get("cmt_ratingcomments"))%></td>
</tr>
<%} %>
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
<%boolean bflag1=true; %>
<%if(IntRat.equalsIgnoreCase("Y")){ %>
<tr>
<td align="center" width="20%">Year</td>
<td align="center" width="30%">Type</td>
<td align="center" width="30%">Rating</td>
</tr>
<%if(arrRowRatingRMD!=null&&arrRowRatingRMD.size()>0){
	for(int i=0;i<arrRowRatingRMD.size();i++) {
	arrOutCol	= (ArrayList)arrRowRatingRMD.get(i);%>
	<%if(i==0 && !Helper.correctNull((String)hshValues.get("cre_weight")).equalsIgnoreCase("")){
	bflag1=false;%>
<tr>
<td align="left"><%=Helper.correctNull((String)hshValues.get("cre_ratyear"))%></td>
<td align="left"><%=Helper.correctNull((String)hshValues.get("cre_rattype"))%></td>
<td align="left"><%=Helper.correctNull((String)hshValues.get("cre_weight"))%></td>
</tr>
<% }%>
<tr>
<td align="left"><%=Helper.correctNull((String)arrOutCol.get(0))%></td>
<td align="left"><%=Helper.correctNull((String)arrOutCol.get(1))%></td>
<td align="left"><%=Helper.correctNull((String)arrOutCol.get(2))%></td>
</tr>
<%}} } else{%>
<tr><td align="center" style="border:none;"><%=strNil%></td></tr>
<%} %>
<%if(bflag1 && !Helper.correctNull((String)hshValues.get("cre_weight")).equalsIgnoreCase("")){ %>
<tr>
<td align="left"><%=Helper.correctNull((String)hshValues.get("cre_ratyear"))%></td>
<td align="left"><%=Helper.correctNull((String)hshValues.get("cre_rattype"))%></td>
<td align="left"><%=Helper.correctNull((String)hshValues.get("cre_weight"))%></td>
</tr>
<% }%>
<%if(!Helper.correctNull((String)hshValues.get("strInternalrating_comment")).equalsIgnoreCase("")){ %>
	<tr>
	<td colspan="8" align="left">Reason for downgrading: <%=Helper.correctNull((String)hshValues.get("strInternalrating_comment"))%></td>
	</tr>
<%} %>
</table>
</div>
</td>
</tr>
<%  	if(strAPPLOANSUBTYPE_DIGI.equalsIgnoreCase("PC")){
				%>


<tr>
<td class="title" align="left" colspan="3"><b>Digi Rating <br/>
<div id="top">
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">

<tr>
<td width="38%" align="left">COMMERCIAL_BUREAU_SCORE </td>
<td align="left"><%=arrDigiRating.get(0)%> </td>
</tr>
<tr>
<td align="left">CONSUMER_IND_SCORE </td>
<td align="left"><%=arrDigiRating.get(1)%> </td>
</tr>
<tr>
<td align="left">CONSUMER_PARTY_SCORE </td>
<td align="left"><%=arrDigiRating.get(2)%> </td>
</tr>
<tr>
<td align="left">OD_ACCOUNT_SCORE </td>
<td align="left"><%=arrDigiRating.get(3)%> </td>
</tr>
<tr>
<td align="left">CURRENT_ACCOUNT_SCORE </td>
<td align="left"><%=arrDigiRating.get(4)%> </td>
</tr>
<tr>
<td align="left">FSA_SCORE </td>
<td align="left"><%=arrDigiRating.get(5)%> </td>
</tr>
<tr>
<td align="left">BAND_RATING </td>
<td align="left"><%=arrDigiRating.get(6)%> </td>
</tr>
<tr>
<td align="left">BAND_PATH </td>
<td align="left"><%=arrDigiRating.get(7)%> </td>
</tr>
<tr>
<td align="left">KB_RATING </td>
<td align="left"><%=arrDigiRating.get(8)%> </td>
</tr>

</table>
</div>
</td>
</tr>

<%  	}
				%>



<!-- Promoter -->
<tr>
<td class="title" align="left" colspan="3">
<div>e. Details of Proprietor/ Partners/ Directors/ Trustee/Karta/Power of Attorney/Others:
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
<td align="center" width="42%">Name of the Proprietor/ Partners/ Director/ Trustee/Karta/Power of Attorney/Others</td>
<td align="center" width="5%">Age <br>(Yrs)</td>
<td align="center" width="25%">Relationship among themselves</td>
<td align="center" width="10%">Net Worth as on <br/></td>
<td align="center" width="15%">Income for Year ended</td>
</tr>
<%} %>
<tr>
<td align="left"><%=++Promsno%></td>
<td align="left"><%=Helper.correctNull((String)arrOutCol.get(0))%></td>
<td align="right"><%=Helper.correctNull((String)arrOutCol.get(1))%></td>
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
<%
int sno=0;
String strPrevCusID = "";
%>
<%if(true){ %>
<!-- Guarantors -->
<tr>
<td class="title" align="left" width="50%" colspan="3">
<div>f. Details of Co-Applicants/Co-Obligants/ Guarantors :
</div>
<div id="top">
<table width="98%" align="center" cellpadding="3" cellspacing="0" border="0">
<%strHeaderFlag="true";

if(arrGuaRow!=null&&arrGuaRow.size()>0){ %>
<%for(int i=0;i<arrGuaRow.size();i++) {
	arrOutCol	= (ArrayList)arrGuaRow.get(i);
	
	if(strPrevCusID.equalsIgnoreCase(Helper.correctNull((String)arrOutCol.get(9))))
	{
		continue;
	}
	else
	{
		strPrevCusID = Helper.correctNull((String)arrOutCol.get(9));		
	}
	if(Helper.correctNull((String)arrOutCol.get(6)).equalsIgnoreCase("G") || Helper.correctNull((String)arrOutCol.get(6)).equalsIgnoreCase("CO")|| Helper.correctNull((String)arrOutCol.get(6)).equalsIgnoreCase("C")){
		if(strHeaderFlag.equalsIgnoreCase("true")){
			strHeaderFlag="false";
%>
<div align="right"><%=strAmtValueIn%>
</div>
<tr>
<td align="center" width="3%">Sl.No</td>
<td align="center" width="42%">Name of Co-Applicants/Co-obligants/ Guarantors</td>
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
if(sno==0)
{ %>
<tr><td align="center" style="border:none;"><%=strNil%></td></tr>
<%} %>
</table>
</div>
</td>
</tr>
<%} %>
<%if(!strPagetype.equalsIgnoreCase("PROPOSALLC")&&!strPagetype.equalsIgnoreCase("ECLGS")&&!strPagetype.equalsIgnoreCase("DPN")) {%>
<tr>
<td class="title" align="left" colspan="3" width="50%">g. Whether related to any of the Directors/ Executives of the Bank<br/>
<div id="top">
<table width="98%" align="center" cellpadding="3" cellspacing="0" border="0" >
 <% if(arrRowRelation!=null&&arrRowRelation.size()>0)
{%>
 

<tr>
<td align="center" width="5%">S.no</td>
<td align="center" width="40%">Name</td>
<td align="center" width="55%">Relationship</td>
</tr>
<%
strPrevCusID="";int j=0;
for(int i=0;i<arrRowRelation.size();i++) {
	arrColRelation	= (ArrayList)arrRowRelation.get(i);
	if(strPrevCusID.equalsIgnoreCase(Helper.correctNull((String)arrColRelation.get(0))))
	{
		continue;
	}
	else
	{
		strPrevCusID = Helper.correctNull((String)arrColRelation.get(0));		
	}j=j+1;
%>
<tr>
<td width="5%"><%=j%></td>
<td width="40%"><%=Helper.correctNull((String)arrColRelation.get(1))%></td>
<td width="55%"><%=Helper.correctNull((String)arrColRelation.get(2))%></td>
</tr>
<%}}else{%>
<tr><td align="center" style="border:none;"><%=strNil%></td></tr>
<%} %>
</table>
</div>
</td>
</tr>

<tr>
<td class="title" align="left" colspan="3" width="50%">h. Whether the name of the Applicant/ Directors. Co-obligants/ Guarantors is in the Defaulters List of RBI<br/>
<div id="top">
	<table width="98%" align="center" cellpadding="3" cellspacing="0" border="0" >
	 <% if(arrRowDefault!=null&&arrRowDefault.size()>0)
	{%>
	 
	
	<tr>
	<td align="center" width="5%">S.no</td>
	<td align="center" width="20%">Name</td>
	<td align="center" width="10%">Defaulters List</td>
	<td align="center" width="20%">As on date</td>
	<td align="center" width="45%">Comments</td>
	</tr>
	<%
	strPrevCusID="";int j=0;
	for(int i=0;i<arrRowDefault.size();i++) {
		arrColDefault	= (ArrayList)arrRowDefault.get(i);
		
		if(strPrevCusID.equalsIgnoreCase(Helper.correctNull((String)arrColDefault.get(0))))
		{
			continue;
		}
		else
		{
			strPrevCusID = Helper.correctNull((String)arrColDefault.get(0));		
		}j=j+1;
	%>
	<tr>
	<td width="5%"><%=j%></td>
	<td width="20%"><%=Helper.correctNull((String)arrColDefault.get(1))%></td>
	<td width="10%" align="center"><%=Helper.correctNull((String)arrColDefault.get(2))%></td>
	<td width="20%"><%=Helper.correctNull((String)arrColDefault.get(3))%></td>
	<td width="45%"><%=Helper.correctNull((String)arrColDefault.get(4))%></td>
	</tr>
	<%}}else{%>
	<tr><td align="center" style="border:none;"><%=strNil%></td></tr>
	<%} %>
	</table>
</div>
</td>
</tr>


<tr>
<td class="title" align="left" colspan="3" width="50%">i. Whether in ECGCI specific approval List<br/>
<div id="top">
<table width="98%" align="center" cellpadding="3" cellspacing="0" border="0" >
 <% if(arrRowEcgc!=null&&arrRowEcgc.size()>0)
{%>
 

<tr>
<td align="center" width="5%">S.no</td>
<td align="center" width="20%">Name</td>
<td align="center" width="10%">Whether appearing in SAL</td>
<td align="center" width="20%">As on date</td>
<td align="center" width="45%">Comments</td>
</tr>
<%
strPrevCusID="";int j=0;
for(int i=0;i<arrRowEcgc.size();i++) {
	arrColEcgc	= (ArrayList)arrRowEcgc.get(i);
	
	if(strPrevCusID.equalsIgnoreCase(Helper.correctNull((String)arrColEcgc.get(0))))
	{
		continue;
	}
	else
	{
		strPrevCusID = Helper.correctNull((String)arrColEcgc.get(0));		
	}j=j+1;
%>
<tr>
<td width="5%"><%=j%></td>
<td width="20%"><%=Helper.correctNull((String)arrColEcgc.get(1))%></td>
<td width="10%" align="center"><%=Helper.correctNull((String)arrColEcgc.get(2))%></td>
<td width="20%"><%=Helper.correctNull((String)arrColEcgc.get(3))%></td>
<td width="45%"><%=Helper.correctNull((String)arrColEcgc.get(4))%></td>
</tr>
<%}}else{%>
<tr><td align="center" style="border:none;"><%=strNil%></td></tr>
<%} %>
</table>
</div>
</td>
</tr>

<%} %>
<tr>
<td class="title"><%if(!strPagetype.equalsIgnoreCase("PROPOSALLC") && !strPagetype.equalsIgnoreCase("ECLGS") &&!strPagetype.equalsIgnoreCase("DPN")) {%>j.<%}else{ %>g.<%} %></td>
<td class="title" align="left" width="50%">Nature of Activity</td>
<td><%=Helper.correctNull((String)hshValues.get("NatureofActivity"))%></td>
</tr>
<tr>
<td class="title"><%if(!strPagetype.equalsIgnoreCase("PROPOSALLC") && !strPagetype.equalsIgnoreCase("ECLGS")&&!strPagetype.equalsIgnoreCase("DPN")) {%>k.<%}else{ %>h.<%} %></td>
<td class="title" align="left" width="50%">Sector - Priority / Non-Priority</td>
<td><%=Helper.correctNull((String)hshValues.get("Sector"))%></td>
</tr>

<%if(!strPagetype.equalsIgnoreCase("DPN")) {%>
<tr>
<td class="title" align="left" colspan="3" width="50%"><%if(strPagetype.equalsIgnoreCase("PROPOSALLC")||strPagetype.equalsIgnoreCase("ECLGS")||strPagetype.equalsIgnoreCase("DPN")){ %>i.<%}else{ %><%} %> Whether referred to CIBIL?<br/>
<br/>
<div id="top">
<table width="98%" align="center" cellpadding="3" cellspacing="0" border="0" >
 <% if(arrRowCIBIL!=null&&arrRowCIBIL.size()>0)
{%>

<tr>
	<td align="center" width="5%">S.no</td>
	<td align="center" width="20%">Name</td>
	<td align="center" width="10%">CIBIL Refered</td>
	<td align="center" width="10%">Reported Date</td>
	<td align="center" width="10%">CIBIL Score</td>
	<td align="center" width="50%">CIBIL Details</td>
</tr>
<%
strPrevCusID="";int j=0;
for(int i=0;i<arrRowCIBIL.size();i++) {
	arrColCIBIL	= (ArrayList)arrRowCIBIL.get(i);
	if(strPrevCusID.equalsIgnoreCase(Helper.correctNull((String)arrColCIBIL.get(0))))
	{
		continue;
	}
	else
	{
		strPrevCusID = Helper.correctNull((String)arrColCIBIL.get(0));		
	}j=j+1;
%>
<tr>
	<td width="5%"><%=j%></td>
	<td width="20%"><%=Helper.correctNull((String)arrColCIBIL.get(1))%></td>
	<td width="10%" align="center"><%=Helper.correctNull((String)arrColCIBIL.get(2))%></td>
	<td width="10%"><%=Helper.correctNull((String)arrColCIBIL.get(3))%></td>
	<td width="10%" align="right"><%=Helper.correctNull((String)arrColCIBIL.get(4))%></td>
	<td width="50%"><%=Helper.correctNull((String)arrColCIBIL.get(5))%></td>
</tr>
<%}}else{%>
<tr><td align="center" style="border:none;"><%=strNil%></td></tr>
<%} %>
</table>
</div>
</td>
</tr>
<%if(!strPagetype.equalsIgnoreCase("ECLGS")&&!strPagetype.equalsIgnoreCase("DPN")){ %>
<tr>
<td class="title" align="left" colspan="3" width="50%"><%if(strPagetype.equalsIgnoreCase("PROPOSALLC")){ %>j.<%}else{ %>m.<%} %> Whether suit filed, whether action initiated by other bank/ financial institutions still pending <br/>
<div id="top">
	<table width="98%" align="center" cellpadding="3" cellspacing="0" border="0" >
	 <% if(arrRowDefault!=null&&arrRowDefault.size()>0)
	{%>
	 
	
	<tr>
	<td align="center" width="5%">S.no</td>
	<td align="center" width="30%">Name</td>
	<td align="center" width="20%">Whether suit filed</td>
	<td align="center" width="40%">Comments</td>
	</tr>
	<%
	strPrevCusID="";int j=0;
	for(int i=0;i<arrRowDefault.size();i++) {
		arrColDefault	= (ArrayList)arrRowDefault.get(i);
		
		if(strPrevCusID.equalsIgnoreCase(Helper.correctNull((String)arrColDefault.get(0))))
		{
			continue;
		}
		else
		{
			strPrevCusID = Helper.correctNull((String)arrColDefault.get(0));		
		}j=j+1;
	%>
	<tr>
	<td width="5%"><%=j%></td>
	<td width="30%"><%=Helper.correctNull((String)arrColDefault.get(1))%></td>
	<td width="20%" align="center"><%=Helper.correctNull((String)arrColDefault.get(5))%></td>
	<%if(Helper.correctNull((String)arrColDefault.get(5)).equalsIgnoreCase("No")){%>
	<td width="40%">Not Applicable</td>
	<%}else{ %>
	<td width="40%"><%=Helper.correctNull((String)arrColDefault.get(6))%></td>
	<%} %>
	</tr>
	<%}}else{%>
	<tr><td align="center" style="border:none;"><%=strNil%></td></tr>
	<%} %>
	</table>
</div>
</td>
</tr>
<%} }
if(!strPagetype.equalsIgnoreCase("DPN")){%>
<tr>
<td class="title" align="left" colspan="3" width="50%"><%if(strPagetype.equalsIgnoreCase("ECLGS")||strPagetype.equalsIgnoreCase("DPN")) {%>j.<%}else if(!strPagetype.equalsIgnoreCase("PROPOSALLC")) {%>n.<%}else{ %>k. <%} %>Whether Reported to CRILC?<br/>
<br/>
<div id="top">
<table width="98%" align="center" cellpadding="3" cellspacing="0" border="0" >
 <% if(arrRowCIBIL!=null&&arrRowCIBIL.size()>0)
{%>

<tr>
	<td align="center" width="5%">S.no</td>
	<td align="center" width="30%">Name</td>
	<td align="center" width="20%">Whether Reported to CRILC?</td>
	<td align="center" width="25%">Reported to CRILC</td>
	<td align="center" width="30%">CRILC Details</td>
</tr>
<%boolean bflag=true;
strPrevCusID="";int j=0;
for(int i=0;i<arrRowCIBIL.size();i++) {
	arrColCIBIL	= (ArrayList)arrRowCIBIL.get(i);
	
	if(strPrevCusID.equalsIgnoreCase(Helper.correctNull((String)arrColCIBIL.get(0))))
	{
		continue;
	}
	else
	{
		strPrevCusID = Helper.correctNull((String)arrColCIBIL.get(0));		
	}
	
	if(true){
		bflag=false;
		j=j+1;
		
%>
<tr>
	<td width="5%"><%=j%></td>
	<td width="30%"><%=Helper.correctNull((String)arrColCIBIL.get(1))%></td>
	<td width="20%"><%=Helper.correctNull((String)arrColCIBIL.get(6))%></td>
	<td width="25%"><%=Helper.correctNull((String)arrColCIBIL.get(9))%></td>
	<td width="30%"><%=Helper.correctNull((String)arrColCIBIL.get(7))%></td>
</tr>
<%}}
if(bflag)
{%>
	<tr>
	<td align="center" colspan="5">- No Record Found -</td>
</tr>
<%}
} %>
</table>
</div>
</td>
</tr>
<tr>
<td class="title" align="left" colspan="3" width="50%"><%if(strPagetype.equalsIgnoreCase("ECLGS")||strPagetype.equalsIgnoreCase("DPN")) {%>k.<%}else if(!strPagetype.equalsIgnoreCase("PROPOSALLC")) {%>o.<%}else{ %>l. <%} %>Whether referred to CRIF ?
<br/>
<div id="top">
<table width="98%" align="center" cellpadding="3" cellspacing="0" border="0" >
 <% if(arrRowCIBIL!=null&&arrRowCIBIL.size()>0)
{%>
<tr>
	<td align="center" width="5%">S.no</td>
	<td align="center" width="30%">Name</td>
	<td align="center" width="30%">Whether referred to CRIF ?</td>
	<td align="center" width="20%">CRIF Score</td>
	<td align="center" width="25%">CRIF Details</td>
	<td align="center" width="30%">CRIF Reported date</td>
	
</tr>
<%
boolean bflag=true;
strPrevCusID="";int j=0;
for(int i=0;i<arrRowCIBIL.size();i++) {
	arrColCIBIL	= (ArrayList)arrRowCIBIL.get(i);
	if(strPrevCusID.equalsIgnoreCase(Helper.correctNull((String)arrColCIBIL.get(0))))
	{
		continue;
	}
	else
	{
		strPrevCusID = Helper.correctNull((String)arrColCIBIL.get(0));		
	}j=j+1;
%>
<tr>
	<td width="5%"><%=j%></td>
	<td width="20%"><%=Helper.correctNull((String)arrColCIBIL.get(1))%></td>
	<td width="10%" align="center"><%=Helper.correctNull((String)arrColCIBIL.get(10))%></td>
	<td width="10%" align="center"><%=Helper.correctNull((String)arrColCIBIL.get(11))%></td>
	<td width="10%"><%=Helper.correctNull((String)arrColCIBIL.get(12))%></td>
	<td width="50%"><%=Helper.correctNull((String)arrColCIBIL.get(13))%></td>
</tr>
<%
}}else{%>
	<tr>
	<td align="center" colspan="5">- No Record Found -</td>
</tr>
<%}%>
</table>
</div>
</td>
</tr>

<%}
if(strPagetype.equalsIgnoreCase("ECLGS")) {%><tr>
<td class="title">l.</td>
<td class="title" align="left" width="50%">Total No. Of Employees</td>
<td><%=Helper.correctNull((String)hshValues.get("cominfo_total_employees"))%>&nbsp; <%if(!Helper.correctNull((String)hshValues.get("cominfo_employees_asondate")).equalsIgnoreCase("")){%> - As on <%=Helper.correctNull((String)hshValues.get("cominfo_employees_asondate"))%><%} %></td>
</tr>
<%} %>
<%if(!strPagetype.equalsIgnoreCase("ECLGS")&& !strPagetype.equalsIgnoreCase("DPN")){ %>
<tr>
<td class="title" align="left" colspan="6" width="50%"><b><%if(strPagetype.equalsIgnoreCase("PROPOSALLC")){ %>m<%}else{ %>p<%} %>.Whether Background Information search conducted</b>
<br/>
<div id="top">
<table width="98%" align="center" cellpadding="3" cellspacing="0" border="0" >
<%if(str_birflag.equalsIgnoreCase("Y"))
{ %>
<tr>
	<td align="center" width="10%">BIR Required</td>
	<td align="center" width="10%">Date of submission of request for BIR by Bank </td>
	<td align="center" width="10%">Date of receipt of BIR report by Bank </td>
	<td align="center" width="10%">BIR Report Date </td>
	<td align="center" width="10%">BIR charges (Excluding Taxes)</td>
	<td align="center" width="10%">BIR Service Name </td>
	<td align="center" width="10%">Quality of report</td>
	<td align="center" width="10%">Over all opinion of prospective borrower</td>
</tr>
<tr>
	<td width="10%" align="center"><%=Helper.correctNull((String)hshValues.get("bir_flag1"))%></td>
	<td width="10%" align="center"><%=Helper.correctNull((String)hshValues.get("bir_submitteddate"))%></td>
	<td width="10%" align="center"><%=Helper.correctNull((String)hshValues.get("bir_receiptdate"))%></td>
	<td width="10%" align="center"><%=Helper.correctNull((String)hshValues.get("bir_processdate"))%></td>
	<td width="10%" align="center"><%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("bir_charges")),strAmountValue)%></td>
	<td width="10%" align="center"><%=Helper.correctNull((String)hshValues.get("bir_service_name"))%></td>
	<td width="10%" align="center"><%=Helper.correctNull((String)hshValues.get("bir_quality_report"))%></td>
	<td width="10%" align="center"><%=Helper.correctNull((String)hshValues.get("bir_opinion_all"))%></td>

</tr>
<tr>
<td colspan="8"><%=Helper.correctNull((String)hshValues.get("bir_comments"))%>&nbsp;</td>
</tr>
<%}else{%>
<tr>
	<td align="left" width="25%">BIR Required</td>
	<td align="left" width="25%"  class="tblhead">Reason for Not obtaining BIR</td>
</tr>
<tr>
	<td align="left" width="25%"><%=Helper.correctNull((String)hshValues.get("bir_flag1"))%></td>
	 <td align="left" width="25%"><%=Helper.correctNull((String)hshValues.get("bir_comments"))%></td>
</tr>
<%} %>

</table>
</td>
</tr>


<%} %>
</table>
</div>
</td>
</tr>
<% if (!(strPagetype.equalsIgnoreCase("PROPOSALLC") || strPagetype.equalsIgnoreCase("MCFD")|| strPagetype.equalsIgnoreCase("ECLGS")|| strPagetype.equalsIgnoreCase("DPN"))){ %>
<% if (!Helper.correctNull((String)hshValues.get("cmt_Briefhistory1")).equalsIgnoreCase("")){ %>
<tr><td class="title">Brief History:</td></tr>
<tr><td><%=Helper.correctNull((String)hshValues.get("cmt_Briefhistory1"))%></td></tr>
<%}} else {
	if (!Helper.correctNull((String)hshValues.get("cmt_Briefhistory")).equalsIgnoreCase("")) { 	%>
<tr><td class="title"><br>Brief History & Background:</td></tr>
<tr><td><%=Helper.correctNull((String)hshValues.get("cmt_Briefhistory"))%></td></tr>
<% }  
if (!Helper.correctNull((String)hshValues.get("cmt_Briefhistory2")).equalsIgnoreCase("")) { 	%>
<tr><td class="title"><br>Additional Information/Comments :</td></tr>
<tr><td><%=Helper.correctNull((String)hshValues.get("cmt_Briefhistory2"))%></td></tr>
<% } } %>
<% if (!strPagetype.equalsIgnoreCase("PROPOSALLC")&&!strPagetype.equalsIgnoreCase("ECLGS")&&!strPagetype.equalsIgnoreCase("DPN")){ %>
<% if (!Helper.correctNull((String)hshValues.get("MgmtComments1")).equalsIgnoreCase("")){ %>
<tr><td class="title">Management and brief biodata :</td></tr>
<tr><td><%=Helper.correctNull((String)hshValues.get("MgmtComments1"))%></td></tr><%}%>

<% if (!Helper.correctNull((String)hshValues.get("MgmtComments2")).equalsIgnoreCase("")){ %>
<tr><td class="title">Activity :</td></tr>
<tr><td><%=Helper.correctNull((String)hshValues.get("MgmtComments2"))%></td></tr><%}%>

<% if (!Helper.correctNull((String)hshValues.get("MgmtComments3")).equalsIgnoreCase("")){ %>
<tr><td class="title">Products/ Services :</td></tr>
<tr><td><%=Helper.correctNull((String)hshValues.get("MgmtComments3"))%></td></tr><%}%>

<% if (!Helper.correctNull((String)hshValues.get("MgmtComments4")).equalsIgnoreCase("")){ %>
<tr><td class="title">Manufacturing process :</td></tr>
<tr><td><%=Helper.correctNull((String)hshValues.get("MgmtComments4"))%></td></tr><%}%>

<% if (!Helper.correctNull((String)hshValues.get("MgmtComments5")).equalsIgnoreCase("")){ %>
<tr><td class="title">Details of suppliers :</td></tr>
<tr><td><%=Helper.correctNull((String)hshValues.get("MgmtComments5"))%></td></tr><%}%>

<% if (!Helper.correctNull((String)hshValues.get("MgmtComments6")).equalsIgnoreCase("")){ %>
<tr><td class="title">Details of buyers and Marketing arrangement :</td></tr>
<tr><td><%=Helper.correctNull((String)hshValues.get("MgmtComments6"))%></td></tr><%}%>

<% if (!Helper.correctNull((String)hshValues.get("MgmtComments8")).equalsIgnoreCase("")){ %>
<tr><td class="title">Memorandum and articles of association :</td></tr>
<tr><td><%=Helper.correctNull((String)hshValues.get("MgmtComments8"))%></td></tr><%}%>

<% if (!Helper.correctNull((String)hshValues.get("MgmtComments9")).equalsIgnoreCase("")){ %>
<tr><td class="title">Partnership / Reconstitution deed :</td></tr>
<tr><td><%=Helper.correctNull((String)hshValues.get("MgmtComments9"))%></td></tr><%}%>

<% if (!Helper.correctNull((String)hshValues.get("MgmtComments10")).equalsIgnoreCase("")){ %>
<tr><td class="title">Trust deed / bye Laws :</td></tr>
<tr><td><%=Helper.correctNull((String)hshValues.get("MgmtComments10"))%></td></tr><%}%>

<% if (!Helper.correctNull((String)hshValues.get("MgmtComments11")).equalsIgnoreCase("")){ %>
<tr><td class="title">Search Report from ROC :</td></tr>
<tr><td><%=Helper.correctNull((String)hshValues.get("MgmtComments11"))%></td></tr><%}%>

<% if (!Helper.correctNull((String)hshValues.get("MgmtComments7")).equalsIgnoreCase("")){ %>
<tr><td class="title">Others :</td></tr>
<tr><td><%=Helper.correctNull((String)hshValues.get("MgmtComments7"))%></td></tr><%}%>
<%double dbltotfaceval=0.0,dbltotamount=0.0,dbltotpercent=0.0;
long lngtotshares=0;%>
<% if(arrRowShare!=null&&arrRowShare.size()>0)
	{%>
<tr>
	<td>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title" align="left">Share Holding Pattern :</td>
			</tr>
		</table>
	</td>
</tr>
<tr><td>
<div id="top">
<table width="100%" align="center" cellpadding="3" cellspacing="0">
<tr>
<td align="right" colspan="5">Market Values of the Shares (Rs.)</td>
<td align="right" ><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("MrktValOfShares"))))%></td>
</tr>
<tr><td>&nbsp;</td>
<td align="center">Shares held by</td>
<td align="center">No. of Shares held</td>
<td align="center">Face Value (Rs.) </td>
<td align="center">Amount (Rs.)</td>
<td align="center">% of Holding</td>
</tr>
 <%for(int i=0;i<arrRowShare.size();i++) {
		 arrColShare	= (ArrayList)arrRowShare.get(i);
	%>
	<tr>
		 <td>&nbsp;</td>
		 <td><%=Helper.correctNull((String)arrColShare.get(1))%></td>
		 <td><%=Helper.correctNull((String)arrColShare.get(2))%></td>
		 <td style="text-align: right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrColShare.get(3))))%></td>
		 <td style="text-align: right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrColShare.get(4))))%></td>
		 <td style="text-align: right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrColShare.get(5))))%></td>
		<%
		lngtotshares = lngtotshares + Integer.parseInt(Helper.correctDouble((String)arrColShare.get(2)));
		dbltotfaceval = dbltotfaceval + Double.parseDouble(Helper.correctDouble((String)arrColShare.get(3)));
		dbltotamount = dbltotamount + Double.parseDouble(Helper.correctDouble((String)arrColShare.get(4)));
		dbltotpercent=dbltotpercent+Double.parseDouble(Helper.correctDouble((String)arrColShare.get(5)));
		%>
									</tr>
	
	<%}%>
	<tr>
	<td colspan="2" align="center"> Total</td>
	<td align="left"><%=lngtotshares %></td>
	<td>&nbsp;</td>
<!--	<td align="right"><%//=Helper.formatDoubleValue(dbltotfaceval) %></td>-->
	<td align="right"><%=Helper.formatDoubleValue(dbltotamount) %></td>
	<td align="right"><%=Helper.formatDoubleValue(dbltotpercent) %></td>
	</tr>
</table>
</div>
</td>
</tr>	
	
 <%}%>
	<% if(arrRowNature!=null&&arrRowNature.size()>0)
	{%>
	<tr><td class="title">Nature of Shares :</td></tr>
<tr><td>
<div id="top">
<table width="100%" align="center" cellpadding="3" cellspacing="0">
	<tr>
	<td>&nbsp;</td>
	<td align="center">Nature of Shares</td>
	<td colspan="2" align="center">Authorised</td>
	<td colspan="2" align="center">Issued / Paid up</td>
	</tr>
	<tr>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td align="center">No. of Shares</td>
	<td align="center">Value (Rs.)<br/></td>
	<td align="center">No. of shares</td>
	<td align="center">Value (Rs.)<br/></td>
	</tr>
	<% 
	 for(int i=0;i<arrRowNature.size();i++) {
		 arrColNature	= (ArrayList)arrRowNature.get(i);
	%>
	<tr>
	<td>&nbsp;</td>
	<td><%=Helper.changetoTitlecase(Helper.correctNull((String)arrColNature.get(2)))%></td>
	<td><%=Helper.correctNull((String)arrColNature.get(3))%></td>
	<td style="text-align: right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrColNature.get(4))))%></td>
	<td><%=Helper.correctNull((String)arrColNature.get(5))%></td>
	 <td style="text-align: right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrColNature.get(6))))%></td>
	</tr>	
	<%}%>
	</table>
</div></td>
</tr>
	<% } %>
<%if(!Helper.correctNull((String)hshValues.get("cmt_shareholdingpattern")).equalsIgnoreCase("")){%>
<tr><td class="title"> Comment on Share Holding Pattern: </td></tr>
<tr><td> <%= Helper.correctNull((String)hshValues.get("cmt_shareholdingpattern"))%></td></tr>
<%} %>
<% if (!Helper.correctNull((String)hshValues.get("cmt_natureofshare")).equalsIgnoreCase("")){%>
<tr><td class="title">Comment on Nature of Shares:</td></tr>
<tr><td><%=Helper.correctNull((String)hshValues.get("cmt_natureofshare"))%></td></tr><%} %>
<%}
if(Helper.correctNull((String)hshValues.get("strSvanidhi")).equalsIgnoreCase("Y"))
{%>
<tr> <br><td class="title"> Details of  KBL PM SVANidhi</td></tr>
<tr><td>
<div id="top">
<table width="100%" align="center" cellpadding="3" cellspacing="0">
<tr><td>Unique Application No. (given by SVANidhi)</td><td colspan="3"><%=Helper.correctNull((String)hshValues.get("PER_SVANIDHIAPPNO")) %>&nbsp;</td></tr>
<tr><td>Member of CIG</td><td colspan="3"><%=Helper.correctNull((String)hshValues.get("PERAPP_CIG")) %>&nbsp;</td></tr>
<tr><td>Name of the CIG</td><td colspan="1"><%=Helper.correctNull((String)hshValues.get("PERAPP_CIGNAME")) %>&nbsp;</td>
<td>Code</td><td colspan="1"><%=Helper.correctNull((String)hshValues.get("PERAPP_CIGCODE")) %>&nbsp;</td></tr>
<tr><td>Member of JLG</td><td colspan="3"><%=Helper.correctNull((String)hshValues.get("PERAPP_JLG")) %>&nbsp;</td></tr>
<tr><td>Name of the JLG</td><td colspan="1"><%=Helper.correctNull((String)hshValues.get("PERAPP_JLGNAME")) %>&nbsp;</td>
<td>Code</td><td colspan="1"><%=Helper.correctNull((String)hshValues.get("PERAPP_JLGCODE")) %>&nbsp;</td></tr>
<tr><td>Nativity</td><td colspan="1"><%=Helper.correctNull((String)hshValues.get("PERAPP_NATIVITY")) %>&nbsp;</td>
<td>PWD</td><td colspan="1"><%=Helper.correctNull((String)hshValues.get("perapp_pwd")) %>&nbsp;</td></tr>


<tr><td colspan="4" class="title">Proof of Vending</td></tr>
<tr><td>Vendor ID Card No.</td><td colspan="1"><%=Helper.correctNull((String)hshValues.get("PERAPP_VENDERIDCARDNO")) %>&nbsp;</td>
<td>Certificate of Vending No</td><td colspan="1"><%=Helper.correctNull((String)hshValues.get("PERAPP_CARTVENDINGNO")) %>&nbsp;</td></tr>
<tr><td>Letter of Recommendation No (LoR)</td><td colspan="3"><%=Helper.correctNull((String)hshValues.get("PERAPP_LETTEROFRECOMMD")) %>&nbsp;</td></tr>

<tr><td colspan="4" class="title">Vending Activity</td></tr>
<tr><td>Name of the Activity (Please Specify)</td><td colspan="1"><%=Helper.correctNull((String)hshValues.get("PERAPP_NATIVEOFACTIVITY")) %>&nbsp;</td>
<td>Place of Vending (Fixed Location/Mobile)</td><td colspan="1"><%=Helper.correctNull((String)hshValues.get("PERAPP_PLACEOFVENDING_desc")) %>&nbsp;</td></tr>
<tr><td>Duration of Vending</td><td colspan="3"><%=Helper.correctInt((String)hshValues.get("PERAPP_DUROFVENDINGYRS")) %>&nbsp; Years &nbsp; <%=Helper.correctNull((String)hshValues.get("PERAPP_DUROFVENDINGMONTH")) %> Months  </td></tr>

<tr><td colspan="4" class="title">Location/Area of Vending</td></tr>
<tr>
<%if(Helper.correctNull((String)hshValues.get("PERAPP_PLACEOFVENDING")).equalsIgnoreCase("F"))
{%>
	<td>Stationary Vendor (Fixed Location) </td>
<%} else { %>
  <td>Mobile Vendor (Locality)  </td> 
<%} %>
<td colspan="1"><%=Helper.correctNull((String)hshValues.get("PERAPP_STATIONARYVEYNDOR")) %>&nbsp;</td>
<td>Nearest Landmark </td><td colspan="1"><%=Helper.correctNull((String)hshValues.get("PERAPP_NEARESTLANDMARK")) %>&nbsp;</td></tr>

<tr><td>Ward No.  </td><td colspan="1"><%=Helper.correctNull((String)hshValues.get("PERAPP_WARDNO")) %>&nbsp;</td>
<td>District </td><td colspan="1"><%=Helper.correctNull((String)hshValues.get("PERAPP_DISTRICTDesc")) %>&nbsp;</td></tr>

<tr><td>Pin Code </td><td colspan="1"><%=Helper.correctNull((String)hshValues.get("PERAPP_PINCODE")) %>&nbsp;</td>
<td>Average Monthly Sales </td><td colspan="1"><%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("PERAPP_AVERAGEMONTHLY")),strAmountValue)%>&nbsp;</td></tr>

<tr><td colspan="4" class="title">Aadhaar Linked Bank Account(s)</td></tr>
<tr><td>Name of the Bank </td><td colspan="1"><%=Helper.correctNull((String)hshValues.get("PERAPP_BANKNAMEDesc")) %>&nbsp;</td>
<td>Name of the Branch </td><td colspan="1"><%=Helper.correctNull((String)hshValues.get("PERAPP_BRANCHNAME")) %>&nbsp;</td></tr>
<tr><td>IFSC Code  </td><td colspan="1"><%=Helper.correctNull((String)hshValues.get("PERAPP_IFSCCODE")) %>&nbsp;</td>
<td>Account No </td><td colspan="1"><%=Helper.correctNull((String)hshValues.get("PERAPP_ACCOUNTNO")) %>&nbsp;</td></tr>


<tr><td colspan="4" class="title">Digital Payment Details</td></tr>
<tr><td>Payment Aggregator/s </td><td colspan="1"><%=Helper.correctNull((String)hshValues.get("PERAPP_PAYMENTAGGREGATOR")) %>&nbsp;</td>
<td>UPI ID/VPA </td><td colspan="1"><%=Helper.correctNull((String)hshValues.get("PERAPP_UPIID")) %>&nbsp;</td></tr>
<tr><td>Durable QR Code  </td><td colspan="3"><%=Helper.correctNull((String)hshValues.get("PERAPP_QRCODE")) %>&nbsp;</td></tr>

<tr><td colspan="4" class="title">Local references</td></tr>
<tr><td colspan="4" >Reference No 1</td></tr>
<tr>
	<td>Name </td> <td><%=Helper.correctNull((String)hshValues.get("perapp_localref1_name")) %>&nbsp;</td> 
	<td>Mobile </td> <td><%=Helper.correctNull((String)hshValues.get("perapp_localref1_mobile")) %>&nbsp;</td> 
</tr>
	<tr>
	<td>Address </td> <td colspan="3"><%=Helper.correctNull((String)hshValues.get("perapp_localref1_address")) %>&nbsp;</td> 
</tr>
<tr><td colspan="4" >Reference No 2</td></tr>
<tr>
	<td>Name </td> <td><%=Helper.correctNull((String)hshValues.get("perapp_localref2_name")) %>&nbsp;</td> 
	<td>Mobile </td> <td><%=Helper.correctNull((String)hshValues.get("perapp_localref2_mobile")) %>&nbsp;</td> 
</tr>
	<tr>
	<td>Address </td> <td colspan="3"><%=Helper.correctNull((String)hshValues.get("perapp_localref2_address")) %>&nbsp;</td> 
</tr>
<tr>
	<td>Benefits availed under other Govt. Schemes </td>
	<td colspan="3"><%=Helper.correctNull((String)hshValues.get("govtschemes")) %>&nbsp; </td>
</tr>
<tr><td>Whether the applicant has undertaken the below <br>mentioned statements in the loan application form</td>
<td colspan="3"><%=Helper.correctNull((String)hshValues.get("perapp_whtapplundertaken")) %>&nbsp;</td> </td> </tr>
<tr>
	<td>Authorisation</td>
	<td colspan="3"> 
		<%if(Helper.correctNull((String)hshValues.get("PERAPP_TERM1CERTIFIED")).equals("Y")){ %>
		<input type="checkbox" checked="checked" name="chk111" disabled="disabled">
		<%} else { %>
		<input type="checkbox" name="chk222" disabled="disabled">
		<%} %>
		I here certify that all information furnished by me/us is true,correct and complete.I have no borrowing arrangements except as indicated in the application form.I have not applied to any lending institution. There is/are no overdue/statutory due owed by me.The information may also be exchanged by you with the agency,you may deem fit.You, your representatives or MoHUA,or any other agency as authorized by you,may  at any time,inspect/verify my/our assets etc. You may take appropriate safeguards/action for recovery of lending institutions dues.
		<br>
		<%if(Helper.correctNull((String)hshValues.get("PERAPP_TERMCERTIFIED2")).equals("Y")){ %>
		<input type="checkbox" checked="checked" name="chk333" disabled="disabled">
		<%} else { %>
		<input type="checkbox" name="chk444" disabled="disabled">
		<%} %>
		I have no objection to authenticate my Aadhaar number, share the same with other Ministries/Departments under the Government of India for the purpose of extension of benefits under any of their Schemes,carry out e-KYC and accessing my credit history & credit score by credit bureau,lenders and  their authorized agents. The consent and purpose of collecting Aadhaar has been explained to me/us in local language.MoHUA/Lending Institution has informed me that my Aadhaar submitted shall not be used for any purpose other than mentioned above, or as per requirements of law. I have been informed that this consent and my Aadhaar  will be stored along with my accounts details with MoHUA.
	
	</td>
</tr>

</table>
</div>
<%ArrayList arrSRow=new ArrayList();
ArrayList arrSCol=new ArrayList();
arrSRow=(ArrayList)hshValues.get("arrSvanidhi");
if(arrSRow!=null && arrSRow.size()>0)
{%>
<tr><td class="title">Family Details</td></tr>
<tr><td>

<div id="top">
<table width="100%" align="center" cellpadding="3" cellspacing="0">
<tr align="center">
<td width="5%">S.No</td>
<td width="15%">Name</td>
<td width="25%">Relationship</td>
<td width="25%">Age</td>
</tr>
<%for(int i=0;i<arrSRow.size();i++){
	arrSCol=(ArrayList)arrSRow.get(i);%>
	
	<tr>
	<td><%=i+1 %></td>
	<td><%=Helper.correctNull((String)arrSCol.get(0)) %></td>
	<td><%=Helper.correctNull((String)arrSCol.get(1)) %></td>
	<td><%=Helper.correctNull((String)arrSCol.get(2)) %></td>
	</tr>

<%} %>
</table>
</td>
</tr>
	<%
}
%>

<%}%>

<%if(Helper.correctNull((String)hshValues.get("strSvanidhi")).equalsIgnoreCase("Y") && Helper.correctNull((String)hshValues.get("StrSvanidhi3")).equalsIgnoreCase("Y"))
{%>
<tr> <br><td class="title">Assessment for PM SVANidhi 3.0</td></tr>
<tr><td>
<div id="top">
<div align="right"><b><%=strAmtValueIn%></b>
</div>
<table width="100%" align="center" cellpadding="3" cellspacing="0">
<tr><td>Svanidhi 2.0 Account number</td><td ><%=Helper.correctNull((String)hshValues.get("SVANIDHI_ACCNUMBER3")) %>&nbsp;</td></tr>
<tr><td>Svanidhi 2.0 Account Open Date</td><td ><%=Helper.correctNull((String)hshValues.get("SVANIDHI_OPENED_DATE3")) %>&nbsp;</td></tr>
<tr><td>Svanidhi 2.0 Account Close Date</td><td ><%=Helper.correctNull((String)hshValues.get("SVANIDHI_CLOSED_DATE3")) %>&nbsp;</td></tr>
<tr><td>Svanidhi 2.0 Loan amount sanctioned</td><td ><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("SVANIDHI_SANCTIONED_AMOUNT3"))))),strAmountValue) %>&nbsp;</td></tr>
<tr><td>Repayment Days</td><td ><%=Helper.correctNull((String)hshValues.get("SVANIDHI_REPAY_DAYS3")) %>&nbsp;</td></tr>
<tr><td>Limit eligible for Svanidhi 3.0</td><td ><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("SVANIDHI_ELIGIBLE_AMOUNT3"))))),strAmountValue) %>&nbsp;</td></tr>
<tr><td>Limit Requested by Borrower under Svanidhi 3.0</td><td ><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("SVANIDHI_BORROWER_AMOUNT3"))))),strAmountValue) %>&nbsp;</td></tr>
<tr><td>Limit proposed and recommended under Svanidhi 3.0</td><td ><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("SVANIDHI_PROPOSED_AMOUNT3"))))),strAmountValue) %>&nbsp;</td></tr>
</table>
</div>
</td>
</tr>


<%} %>
</table>
</body>
</html>