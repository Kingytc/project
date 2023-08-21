<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ page import="java.util.*,java.text.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<% request.setAttribute("_cache_refresh", "true"); %>
<laps:handleerror/>
<%
String strOrgLevel=(String)session.getAttribute("strOrgLevel");

java.text.NumberFormat jtn	= java.text.NumberFormat.getInstance();
jtn.setMaximumFractionDigits(2);
jtn.setMinimumFractionDigits(2);
jtn.setGroupingUsed(false);

ArrayList arrCol = new ArrayList();
ArrayList arrPromoterRow=new ArrayList();
ArrayList arrFinRow=new ArrayList();
ArrayList arrFinCol=new ArrayList();
ArrayList arrOutCol=new ArrayList();
ArrayList arrFacRow=new ArrayList();
ArrayList arrFacCol=new ArrayList();
ArrayList arrProfitLossActCol=new ArrayList();
ArrayList arrProfitLossActRow=new ArrayList();
ArrayList arrGroupconcerns=new ArrayList();
ArrayList arrCGOurRow=new ArrayList();
ArrayList arrGroupConcernDetailsRow1=new ArrayList();
ArrayList arrGroupConcernDetailsCol1=new ArrayList();
ArrayList arrRow1=new ArrayList();
HashMap hshAddeDetails = new HashMap();
HashMap hshGroupConcern = new HashMap();
if(hshValues!=null)
{
	arrPromoterRow	= (ArrayList)hshValues.get("arrPromoterRow");
	arrFinRow	= (ArrayList)hshValues.get("arrFinRow");
	arrFacRow  = (ArrayList)hshValues.get("arrFacRow");
	arrProfitLossActRow  = (ArrayList)hshValues.get("arrProfitLossAct");
	hshAddeDetails  = (HashMap)hshValues.get("hshRespDetails");
	hshGroupConcern = (HashMap) hshValues.get("hshGroupConcern");
}
if(hshGroupConcern != null) {
	arrGroupconcerns = (ArrayList)hshGroupConcern.get("arrGroupconcerns");
	arrCGOurRow		= (ArrayList)hshGroupConcern.get("arrCGOurRow");
	arrGroupConcernDetailsRow1	= (ArrayList)hshGroupConcern.get("arrGroupConcernDetails1");
}
String[] strFinPart = {"Year","Current Assets","Current Liabilities","Current Ratio","Debt Equity Ratio"};
ArrayList arrGrpExp=(ArrayList)hshValues.get("arrGrpExpDet");
ArrayList arrColExp = new ArrayList();

double dblgrpexptot=0;
dblgrpexptot=Double.parseDouble(Helper.correctDouble((String)hshValues.get("dblGrpExpVal")));

int count=0;
String strTLValIn="",strValuesIn="",strNil="Nil",strWhetherBRAvail="",strOutstandingDate="",strSanctioningAuthority="",strValIn="",str_arry="";

strWhetherBRAvail=Helper.correctNull((String)hshValues.get("strWhetherBRAvail"));
strOutstandingDate=Helper.correctNull((String)hshValues.get("strOutstandingDate"));
strSanctioningAuthority=Helper.correctNull((String)hshValues.get("com_sancauthorityVal"));
str_arry = Helper.correctNull((String)hshValues.get("str_arr")); 

strValIn = Helper.correctNull((String)hshValues.get("strValuesIn"));

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

int finColSize=0,profitLossSize=0;
if(arrFinRow!=null && arrFinRow.size()>0) {
	arrFinCol = (ArrayList) arrFinRow.get(0);
	finColSize=arrFinCol.size();
}
if(arrProfitLossActRow!=null && arrProfitLossActRow.size()>0) {
	arrProfitLossActCol = (ArrayList) arrProfitLossActRow.get(0);
	profitLossSize=arrProfitLossActCol.size()-1;
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
 		RowCount++;
 		
 	}
	app_constitution=Helper.correctNull((String)hshAddeDetails.get("app_constitution"));
}
double sanctionamount = 0.00;
double total_percentage =0.00;
double totalpercenvalue = 0.00;
double emi_totalcost=0.00;
emi_totalcost = Double.parseDouble(Helper.correctDouble((String)hshValues.get("emi_totalcost")));
sanctionamount=Double.parseDouble(Helper.correctDouble((String)hshValues.get("loan_recmdamt")));
totalpercenvalue = (emi_totalcost - sanctionamount);
totalpercenvalue = Double.parseDouble(Helper.formatDoubleValue(totalpercenvalue));
if(emi_totalcost!=0.00)
	total_percentage = Math.round((totalpercenvalue / emi_totalcost)*100);

String strDealing=Helper.correctNull((String)hshValues.get("MD_DEALING"));
if(strDealing.equalsIgnoreCase("NN")) strDealing = "New Borrower-New Unit";
else if(strDealing.equalsIgnoreCase("NT")) strDealing = "New Borrower-Taken Over";
else if(strDealing.equalsIgnoreCase("EB")) strDealing = "Existing Borrower";
else strDealing="&nbsp;";

HashMap hshRecord=new HashMap();
hshRecord=(HashMap)hshValues.get("PROPOSAL");

ArrayList arrSingleCons =  new ArrayList();
ArrayList arrMultipleCons = new ArrayList();
ArrayList arrMultiple 	= new ArrayList();
ArrayList arrSingleConsWC = new ArrayList();
ArrayList arrMultipleConsWC = new ArrayList();
ArrayList arrMultipleWC = new ArrayList();
ArrayList arrMultiBnk = new ArrayList();
ArrayList arrColCons	= new ArrayList();
String flag="",val="";
String multipleConsWCflag="",multipleConsflag="";
String intRate = "";
int arrCount=0;

if(hshRecord!=null)
{
	arrSingleCons = (ArrayList)hshRecord.get("arrSingleCons");
	arrMultipleCons = (ArrayList)hshRecord.get("arrMultipleCons");
	arrMultiple		= (ArrayList)hshRecord.get("arrMultiple");
	arrSingleConsWC = (ArrayList)hshRecord.get("arrSingleConsWC");
	arrMultipleConsWC = (ArrayList)hshRecord.get("arrMultipleConsWC");
	arrMultipleWC 	= (ArrayList)hshRecord.get("arrMultipleWC");
	arrMultiBnk		= (ArrayList)hshRecord.get("arrMultiBnk");
}

if(arrMultipleConsWC!=null && arrMultipleConsWC.size()>0)
{ 
	for(int i=0;i<arrMultipleConsWC.size();i++)
	{
		count=0;
		arrCol	= (ArrayList)arrMultipleConsWC.get(i);
		arrCount=arrCol.size();
		for(int j=0;j<arrCount;j++)
		{
			arrColCons	= (ArrayList)arrCol.get(j);
			if(Helper.correctNull((String)arrColCons.get(7)).equals(""))
				count++;
		}
		if(count==arrCount && arrCount != 0)
			multipleConsWCflag+="Y,";
		else
			multipleConsWCflag+="N,";
	}
	if(!multipleConsWCflag.equals(""))
		multipleConsWCflag = multipleConsWCflag.substring(0,multipleConsWCflag.length()-1);
}
count=0;arrCount=0;
if(arrMultipleCons!=null && arrMultipleCons.size()>0)
{ 
	for(int i=0;i<arrMultipleCons.size();i++)
	{
		count=0;
		arrCol	= (ArrayList)arrMultipleCons.get(i);
		arrCount=arrCol.size();
		for(int j=0;j<arrCount;j++)
		{
			arrColCons	= (ArrayList)arrCol.get(j);
			if(Helper.correctNull((String)arrColCons.get(7)).equals(""))
				count++;
		}
		if(count==arrCount && arrCount != 0)
			multipleConsflag+="Y,";
		else
			multipleConsflag+="N,";
	}
	if(!multipleConsflag.equals(""))
		multipleConsflag = multipleConsflag.substring(0,multipleConsflag.length()-1);
}


%>

<html>
<head>
<title>MD Sanction Format</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
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
<script>
function callLoad()
{
	var varspan=document.getElementsByTagName('span');
	var space="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
	 for(i in varspan)
	 {
	  if(document.getElementsByTagName('span')[i].title=="pagebreak")
	  {
	  document.getElementsByTagName('span')[i].innerHTML=space;
	  document.getElementsByTagName('span')[i].title="Press 'Enter' for line space";
	  }
	 }

}
//Allow Enter and ctrl+z and ctrl+y  key Only
function callKeyDown()
{
	var pressedKey=String.fromCharCode(event.keyCode).toLowerCase();
    var key=window.event.keyCode;
    if(! ( (key==13) || (event.ctrlKey && pressedKey=="z") || (event.ctrlKey && pressedKey=="y") ))
	 {
     window.event.returnValue=false;
	 }
}
</script>

</head>
<body contentEditable="false" designMode="on" onKeyDown="callKeyDown();" onload="callLoad();">
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr><td align="center"><br><img src="<%=ApplicationParams.getAppUrl()%>img/kbl_newlogo.jpg"></td></tr>
</table>
<br>
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
<td colspan="2">
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
	<tr>
		<td align="left" width="50%">PF No&nbsp;:&nbsp;
		<% if(strOrgLevel.equalsIgnoreCase("A")){ %>
								<%=Helper.correctNull((String)hshValues.get("com_partyfileno"))%>
								<%}else{  %>
								<%=Helper.correctNull((String)hshValues.get("com_roho"))%>
								<%} %>
		</td>
		<td align="left" width="50%">Branch&nbsp;:&nbsp;<%=Helper.changetoTitlecase(Helper.correctNull((String)hshValues.get("org_name")))%></td>
	</tr>
	<tr>
		<td align="left" width="50%">Date&nbsp;:&nbsp;<%=Helper.getCurrentDateTime() %></td>
		<td align="left" width="50%">Region&nbsp;:&nbsp;<%=Helper.changetoTitlecase(Helper.correctNull((String)hshValues.get("Reg_org_name")))%></td>
	</tr>
</table>
</td>
</tr>
<tr>
<td width="50%">
<div id="top">
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td align="left" width="30%">Sector</td>
				<td align="center" width="30%"><%=Helper.correctNull((String)hshValues.get("com_sector"))%></td></tr>
			<tr>
				<td align="left">Classification of asset as on <%=Helper.correctNull((String)hshValues.get("com_asscladate"))%></td>
				<td align="center"><%=Helper.correctNull((String)hshValues.get("assetClass"))%></td>
			</tr>
			<tr>
				<td align="left">Credit Risk Rating as per ABS as on</td>
				<td align="center"></td>
			</tr>
			<tr>
				<td align="left">Credit Risk Rating as per ABS as on</td>
				<td align="center"></td>
			</tr>
			<tr>
				<td align="left">Reason for downgrading</td>
				<td align="center"><%=Helper.correctNull((String)hshValues.get("cmt_ratingcomments"))%></td>
			</tr>
			</table>
</div>
</td>
<td width="50%">
<div id="top">
	<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td align="left" width="30%"><%=strDealing %></td>
				<td align="center" width="30%"></td>
			</tr>
	</table>
</div>
</td>
</tr>
</table>
<table  width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr><td>
Report to the <b>EXECUTIVE COMMITTEE OF DIRECTORS</b> on particulars of Credit facilities sanctioned by the <b>Managing Director</b> 
within his delegated Powers during the month of (MENTION THE MONTH)
<td>
</tr>

<tr>
<td>
	<div id="top">
	<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
	<tr>
		<td align="left" width="3%" rowspan="5" valign="top">1.</td>
		<td align="left" width="35%">Name of the Borrower</td>
		<td align="left" width="62%">
		<%=Helper.correctNull((String)hshValues.get("perapp_title"))%>.&nbsp;<%=Helper.correctNull((String)hshValues.get("perapp_name"))%>
		</td>
	</tr>
	<%if(app_constitution.equalsIgnoreCase("01")){ %>
	<%if(!strCommaddress.equalsIgnoreCase("")){ %>
	<tr>
		<td>Communication Address</td>
		<td><%=strCommaddress%></td>
	</tr>
	<%} %>
	<%if(!strPerAddress.equalsIgnoreCase("")){ %>
	<tr>
		<td>Permanent Address</td>
		<td><%=strPerAddress %></td>
	</tr>
	<%}%>
	<%}else{ %>
	<%if(!strCommaddress.equalsIgnoreCase("")){ %>
	<tr>
		<td>Registered Office Address</td>
		<td><%=strCommaddress%></td>
	</tr>
	<%} %>
	<%if(!strPerAddress.equalsIgnoreCase("")){ %>
	<tr>
		<td>Administrative Office Address</td>
		<td><%=strPerAddress %></td>
	</tr>
	<%}%>
	<%if(!strAdminAddress.equalsIgnoreCase("")){%>
	<tr>
		<td>Corporate Address<br></td>
		<td><%=strAdminAddress%></td>
	</tr>
	<%}%>
	<%} %>
	<tr>
		<td>b). Proprietor/Partners/Directors </td>
		<td><%=Helper.correctNull((String)hshValues.get("partnerDirDetails"))%></td>
	</tr>
	<tr>
		<td>c). Co-obligants / guarantors </td>
		<td><%=Helper.correctNull((String)hshValues.get("coObligantDetails"))%></td>
	</tr>
	<tr>
		<td align="left" width="3%" valign="top">2.</td>
		<td align="left" width="35%">Constitution</td>
		<td align="left" width="62%"><%=Helper.correctNull((String)hshValues.get("cbs_static_data_desc"))%></td>
	</tr>
	<tr>
		<td align="left" width="3%" valign="top">3.</td>
		<td align="left" width="35%">Date of Establishment</td>
		<td align="left" width="62%"><%=Helper.correctNull((String)hshValues.get("perapp_dob"))%></td>
	</tr>
	<tr>
		<td align="left" width="3%" valign="top">4.</td>
		<td align="left" width="35%">Nature of Business/activity</td>
		<td align="left" width="62%"><%=Helper.correctNull((String)hshValues.get("NatureofActivity"))%></td>
	</tr>
	<tr>
		<td align="left" width="3%" valign="top">5.</td>
		<td align="left" width="35%">Dealing with us since</td>
		<td align="left" width="62%"><%=Helper.correctNull((String)hshValues.get("perapp_banksince"))%></td>
	</tr>
	<tr>
		<td align="left" width="3%" valign="top">6.</td>
		<td align="left" width="95%" colspan="2">
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
				<tr>
					<td>S.No</td>
					<td>Name of the partners/Directors</td>
					<td>Age</td>
					<td>Relationship  among themselves</td>
					<td>Net Worth as on <br>(Rs. in lakhs)</td>
					<td>Income for the period <br>(Rs. in lakhs)</td>
				</tr>
		<% 
			int Promsno=0;
			if(arrPromoterRow!=null&&arrPromoterRow.size()>0){ %>
			
				<%for(int i=0;i<arrPromoterRow.size();i++) {
					arrOutCol	= (ArrayList)arrPromoterRow.get(i);
					if(Helper.correctNull((String)arrOutCol.get(6)).equalsIgnoreCase("PT") || Helper.correctNull((String)arrOutCol.get(6)).equalsIgnoreCase("D")){
				%>
				<tr>
				<td align="left"><%=++Promsno%></td>
				<td align="left"><%=Helper.correctNull((String)arrOutCol.get(0))%></td>
				<td align="right"><%=Helper.correctInt((String)arrOutCol.get(1))%></td>
				<td align="left"><%=Helper.correctNull((String)arrOutCol.get(3))%></td>
				<td align="left" nowrap="nowrap"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrOutCol.get(4))))%>
				&nbsp;-&nbsp;<%=Helper.correctNull((String)arrOutCol.get(5))%>
				</td>
				<td align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrOutCol.get(2))))%></td>
				</tr>
				
				<%} } }else{ %>
			<tr>
			<td colspan="6" align="center"> No Partners / Directors Found</td>
			</tr>
			<%} %>
		&nbsp;</table></td>
	</tr>
	<tr>
		<td align="left" width="3%" valign="top">7.</td>
		<td align="left" width="35%">Tangible Net worth of the Borrower as on </td>
		<td align="left" width="62%">Rs. <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("PERAPP_NETWORTH")))) %></td>
	</tr>
	<tr>
		<td align="left" width="3%" valign="top" rowspan="2">8.</td>
		<td align="left" class="title" colspan="2">Facilities applied with amount</td>
	</tr>
	<tr>
		<td align="left" width="62%" colspan="2">
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
				<tr>
					<td align="center" style="font-weight: bold;" width="50%">Name of the Facility</td>
					<td align="center" style="font-weight: bold;" width="50%">Proposed Amount</td>
				</tr>
		<% if(arrFacRow != null && arrFacRow.size()>0) { 
			for(int i=0;i<arrFacRow.size();i++) {
				arrFacCol = (ArrayList) arrFacRow.get(i);
		%>
				<tr>
					<td><%=Helper.correctNull((String)arrFacCol.get(5))%></td>
					<td><%=Helper.correctNull((String)arrFacCol.get(4))%></td>
				</tr>
		<% } } else  { %>
				<tr>
					<td colspan="2" align="center">No Data Found</td>
				</tr>
		<% } %>
		</table>
		</td>
	</tr>
	<tr>
		<td align="left" width="3%" valign="top" rowspan="2">9.</td>
		<td align="left" class="title" colspan="2">Facilities recommended by the Branch</td>
	</tr>
	<tr>
		<td align="left" width="62%" colspan="2">
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
				<tr>
					<td align="center" style="font-weight: bold;" width="50%">Name of the Facility</td>
					<td align="center" style="font-weight: bold;" width="50%">Proposed Amount</td>
				</tr>
		<% if(arrFacRow != null && arrFacRow.size()>0) { 
			for(int i=0;i<arrFacRow.size();i++) {
				arrFacCol = (ArrayList) arrFacRow.get(i);
		%>
				<tr>
					<td><%=Helper.correctNull((String)arrFacCol.get(5))%></td>
					<td><%=Helper.correctNull((String)arrFacCol.get(4))%></td>
				</tr>
		<% } } else  { %>
				<tr>
					<td colspan="2" align="center">No Data Found</td>
				</tr>
		<% } %>
		</table>
		</td>
	</tr>
	<tr>
		<td align="left" width="3%" valign="top" rowspan="2">10.</td>
		<td align="left" class="title" colspan="2">Purpose of facility</td>
	</tr>
	<tr>
		<td align="left" width="62%" colspan="2">
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
				<tr>
					<td align="center" style="font-weight: bold;" width="50%">Name of the Facility</td>
					<td align="center" style="font-weight: bold;" width="50%">Purpose</td>
				</tr>
		<% if(arrFacRow != null && arrFacRow.size()>0) { 
			for(int i=0;i<arrFacRow.size();i++) {
				arrFacCol = (ArrayList) arrFacRow.get(i);
		%>
				<tr>
					<td><%=Helper.correctNull((String)arrFacCol.get(5))%></td>
					<td><%=Helper.correctNull((String)arrFacCol.get(6))%></td>
				</tr>
		<% } } else  { %>
				<tr>
					<td colspan="2" align="center">No Data Found</td>
				</tr>
		<% } %>
		&nbsp;</table>
		</td>
	</tr>
	<tr>
		<td align="left" width="3%" valign="top">11.</td>
		<td align="left" width="95%" colspan="2">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
				<tr>
					<td align="left" class="title" colspan="<%=profitLossSize+2 %>">PERFORMANCE
					(Mention  whether  financial statements are audited pertaining to each year)
					</td>
				</tr>
				<% if(profitLossSize != 0) { %>
				<tr>
					<td></td>
					<td></td>
					<td colspan="<%=profitLossSize %>" align="center">As on / for the year ended</td>
				</tr>
				<%
				}
				int sno=1;
				if(arrProfitLossActRow!=null && arrProfitLossActRow.size()>0) { 
					for(int i=0;i<arrProfitLossActRow.size();i++) {
						arrProfitLossActCol = (ArrayList) arrProfitLossActRow.get(i);
						
				%>
				<tr>
					<% 
					if(arrProfitLossActCol!=null && arrProfitLossActCol.size()>0) { 
						if(i<2) { %>
						<td width="5%"></td>
						<% } else { %>
						<td width="5%" align="right"><%=sno++ %></td>
						<% }
						for(int j=0;j<arrProfitLossActCol.size();j++) { 
						if(i<2) { %>
							<td align="center" style="font-weight: bold"><%=Helper.correctNull((String)arrProfitLossActCol.get(j)) %></td>
						<% } else { 
							if(j==0) { %>
							<td align="left"><%=Helper.correctNull((String)arrProfitLossActCol.get(j)) %></td>
						<% } else { %>
							<td align="right"><%=Helper.correctNull((String)arrProfitLossActCol.get(j)) %></td>
						<%
					} } } } %>
				</tr>
				<% } } else  { %>
				<tr>
					<td colspan="2" align="center">No Financial Data Found</td>
				</tr>
				<% } %>
			</table>
		</td>
	</tr>
	<tr>
		<td align="left" width="3%" valign="top">12.</td>
		<td align="left" width="95%" colspan="2">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
				<tr>
					<td></td>
					<td align="left" class="title">Others</td>
					<td align="center">2013</td>
					<td align="center">2014</td>
					<td align="center">2015</td>
				</tr>
				<tr>
					<td align="right" width="5%">a</td>
					<td width="50%">Capital</td>
					<td width="15%">&nbsp;</td>
					<td width="15%">&nbsp;</td>
					<td width="15%">&nbsp;</td>
				</tr>
				<tr>
					<td align="right">b</td>
					<td>Net worth</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td align="right">c</td>
					<td>Net long term funds</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td align="right">d</td>
					<td>Funds under long term  uses: (Net block + Investments  to 
					subsidiaries or sister concerns)</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td align="right">e</td>
					<td>Net Working Capital (c - d)</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			</td>
		</tr>
	<tr>
		<td align="left" width="3%" valign="top">13.</td>
		<td align="left" width="95%" colspan="2">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
				<tr>
					<td align="left" class="title" colspan="<%=finColSize+2 %>">Assets/Liabilities</td>
				</tr>
				<% if(arrFinRow!=null && arrFinRow.size()>0) { 
					for(int i=0;i<arrFinRow.size();i++) {
						arrFinCol = (ArrayList) arrFinRow.get(i);
				%>
				<tr>
					<% 
					if(arrFinCol!=null && arrFinCol.size()>0) { 
						if(i==0) { %>
						<td width="5%"></td>
						<td width="30%" align="center" class="title"><%=strFinPart[i] %></td>
					<% } else { %>
						<td width="5%" align="right"><%=i %></td>
						<td width="30%" align="left"><%=strFinPart[i] %></td>
					<% }
						for(int j=0;j<arrFinCol.size();j++) { 
							if(i==0) {
							%>
								<td align="center" style="font-weight: bold"><%=(String) arrFinCol.get(j) %></td>
							<% } else { %>
							<td align="right"><%=(String) arrFinCol.get(j) %></td>
							<% }
						}
					} %>
				</tr>
				<% } %>
				<tr>
					<td width="5%" align="right">5</td>
					<td width="50%">DSCR</td>
					<td colspan="<%=finColSize %>"><%=Helper.correctNull((String)hshValues.get("DscrAvg")) %></td>
				</tr>
					<% } else  { %>
				<tr>
					<td colspan="2" align="center">No Financial Data Found</td>
				</tr>
		<% } %>
			</table>
		</td>
	</tr>
	<tr>
		<td align="left" width="3%" rowspan="6" valign="top">14.</td>
		<td colspan="2"><b>a). Nature and extent of credit facilities already enjoyed with other Banks/Institutions:</b>
		<div align="right"> <%=strValuesIn %></div>
		<% 
	    	int n=0;
		String strGrpconcern="";
		if(arrGroupconcerns!=null && arrGroupconcerns.size()>0){
			for(int s=0;s<arrGroupconcerns.size();s++){
				strGrpconcern=Helper.correctNull((String)arrGroupconcerns.get(s));
				arrGroupConcernDetailsRow1	= (ArrayList)hshGroupConcern.get("arrGroupConcernDetails1"+strGrpconcern);
				if((arrGroupConcernDetailsRow1!=null && arrGroupConcernDetailsRow1.size()>0)){ %>
	
	<% 
	for(int i=0;i<arrGroupConcernDetailsRow1.size();i++){
			arrGroupConcernDetailsCol1=(ArrayList)arrGroupConcernDetailsRow1.get(i);
			arrRow1=(ArrayList)arrGroupConcernDetailsCol1.get(5);
			ArrayList arrCol1=new ArrayList();
			if(arrRow1!=null && arrRow1.size()>0){
	    	for(int j=0;j<arrRow1.size();j++)
	    	{
	    		arrCol1=(ArrayList)arrRow1.get(j);
	    		%>
	    		<%if(n==0){ n++;%>
	    		<tr><td colspan="2">
	<div id="top">
	<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
	    	<tr>
	   <td colspan="6"><%=i+1 %>. Name of the concern : <%=Helper.correctNull((String)arrGroupConcernDetailsCol1.get(1))%></td>
	    </tr>
	    		<%} %>
		  <tr>
	    <td><b>Name of the Bank/ Institution</b></td>
	    <td><b>Fund Based Limit</b></td>    
	    <td><b>Balance as on&nbsp;<%=Helper.correctNull((String)arrCol1.get(5))%></b></td>
	    <td><b>Non-Fund Based Limit</b></td>  
	    <td colspan="2"><b>Balance as on &nbsp; </b><%=Helper.correctNull((String)arrCol1.get(5))%></td>
	    </tr>
	    <tr>
	    <td><%=Helper.correctNull((String)arrCol1.get(0))%></td> 
	    <td><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol1.get(2))))%></td>  
	    <td><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol1.get(1))))%></td> 
	    <td><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol1.get(4))))%></td> 
	    <td colspan="2"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol1.get(3))))%></td>     
	    </tr>     	
	</table>
	</div>
	</td>
	</tr>
	</td></tr>
	    <%
	    	}	} } %>
	
	
	<%}} } if(n==0) {%>
	<tr><td colspan="2" align="center">No Data Found</td></tr>
	<%} %>
	<tr><td class="" colspan="2"><b>b). Nature and extent of credit facilities with our Bank :</b> <div align="right"> <%=strValuesIn %></div> </td></tr>
			
	<!-- Group Concern with our bank -->
		<%
		int k=0;
		strGrpconcern="";
		if(arrGroupconcerns!=null && arrGroupconcerns.size()>0){
			for(int s=0;s<arrGroupconcerns.size();s++){
				strGrpconcern=Helper.correctNull((String)arrGroupconcerns.get(s));
				arrCGOurRow		= (ArrayList)hshGroupConcern.get("arrCGOurRow"+strGrpconcern);
			if(arrCGOurRow!=null && arrCGOurRow.size()>0)
			{ 
			ArrayList arr=new ArrayList();
			%>
			
			<tr><td>
			<div id="top">
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">

<% 
	for(int i=0;i<arrCGOurRow.size();i++){
		arrCol	= (ArrayList)arrCGOurRow.get(i);
	if(k==0) {	
	k++;
%>
<tr><td colspan="3"><b><%=(i+1) %>. Name of the concern </b></td>
<td colspan="6"><b><%=Helper.changetoTitlecase(Helper.correctNull((String)arrCol.get(1)))%>.<%=Helper.changetoTitlecase(Helper.correctNull((String)arrCol.get(2)))%></b></td></tr>
<tr><td colspan="3"><b>Rating </b></td>
<%String strTemp=Helper.correctNull((String)arrCol.get(5));
if(strTemp.equalsIgnoreCase("A"))
{
	strTemp="Audited";
}
else if(strTemp.equalsIgnoreCase("E")){
	strTemp="Estimated";	
}
else if(strTemp.equalsIgnoreCase("U")){
	strTemp="Unaudited";
}else if(strTemp.equalsIgnoreCase("P")){
	strTemp="Projection";
}
%>
<td colspan="6"><%=Helper.correctNull((String)arrCol.get(2))+"-"+Helper.correctNull((String)arrCol.get(4))%>&nbsp;[<%=strTemp%>]</td></tr>
<tr>
<td width="3%" align="center"><b>S.No</b></td>
<td width="17%" align="center"><b>Nature of facility</b></td>
<td width="10%" align="center"><b>Limit</b></td>
<td width="10%" align="center"><b>Purpose</b></td>
<td width="10%" align="center"><b>Sanction Ref. & Date</b></td>
<td width="10%" align="center"><b>ROI/ Com %</b></td>
<td width="10%" align="center"><b>Balance as on</b></td>
<td width="10%" align="center"><b>Due Date</b></td>
<td width="10%" align="center"><b>Arrears if any</b></td>
</tr>
<%} 
}%>
</table></div></td></tr> 
<% } } } if(k==0){ %>
	<tr><td colspan="2" align="center">No Data Found</td></tr>
	<%} %>
	</tr>
	
	<tr>
		<td colspan="2"><b>c). Proposed Banking Arrangement:</b></td>
	</tr>
	
	
	<!-- Banking Arrangement Start-->
<tr>
<td colspan="2">
<div id="top">
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
<% 
String strBnkargWC = Helper.correctNull((String)hshRecord.get("strBnkargWC"));
String strBnkargTL = Helper.correctNull((String)hshRecord.get("strBnkargTL"));
String wcTitle = "<b>Banking Arrangement :</b>";
String tlTitle = "<b>Banking Arrangement :</b>";
if(!strBnkargWC.equals("")) { 
	if(strBnkargWC.equalsIgnoreCase("S")) wcTitle += " Sole";
	else if(strBnkargWC.equalsIgnoreCase("C")) wcTitle += " Consortium";
	else if(strBnkargWC.equalsIgnoreCase("M")) wcTitle += " Multiple";
}
if(!strBnkargTL.equals("")) { 
	if(strBnkargTL.equalsIgnoreCase("S")) tlTitle += " Sole";
	else if(strBnkargTL.equalsIgnoreCase("C")) tlTitle += " Consortium";
	else if(strBnkargTL.equalsIgnoreCase("M")) tlTitle += " Multiple";
}
if(!strBnkargWC.equals("") && !strBnkargWC.equals("0")) { 
%>
<tr>
	<td class="title" >Working Capital :&nbsp;<br><br><%=wcTitle %> </td>
</tr>

<% }
if(!strBnkargTL.equals("") && !strBnkargTL.equals("0")) { %>
<tr>
	<td class="title">Term Loan :&nbsp;<br><br><%=tlTitle %></td>
</tr>

<% }
 %>

<!-- Single - Consortium -->
<%
if(arrSingleCons!=null && arrSingleCons.size()>0){ 
%>
<tr>
	<td class="title"><br>Term Loan:</td>
</tr>
<tr>
	<td><b>Leader:</b>&nbsp;<%=Helper.changetoTitlecase(Helper.correctNull((String)hshRecord.get("com_cons_bank_name"))) %></td>
</tr>
			
<%
if(arrSingleCons!=null && arrSingleCons.size()>0)
{ 
%>
	<tr>
		<td align="right" width=""><%=strValuesIn%></td>
	</tr>
	<tr>
		<td>
			<div id="top">
				<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
					<tr>
						<td width="20%" align="center">Name of the Bank</td>
						<td width="20%" align="center">Facility</td>
						<td width="12%" align="center">Type</td>
						<td width="10%" align="center">Limit</td>
						<td width="10%" align="center">Outstanding</td>
						<td width="10%" align="center">Interest (%)</td>
						<td width="18%" align="center">Remarks</td>
					</tr>
			<%	for(int i=0;i<arrSingleCons.size();i++)
				{
					arrCol	= (ArrayList)arrSingleCons.get(i);
				%>
					<tr>
						<td align="left"><%=Helper.changetoTitlecase(Helper.correctNull((String)arrCol.get(9)))%></td>
						<td align="left"><%=Helper.changetoTitlecase(Helper.correctNull((String)arrCol.get(10)))%></td>
						<td align="left"><%=Helper.correctNull((String)arrCol.get(3))%></td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)arrCol.get(5)))%></td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)arrCol.get(6)))%></td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)arrCol.get(7)))%></td>
						<td align="left"><%=Helper.correctNull((String)arrCol.get(8))%></td>
					</tr>
			<%} %>
				<% if(arrSingleCons.size()>1) {  %>
					<tr>
						<td align="left">TOTAL</td>
						<td align="left">&nbsp;</td>
						<td align="left">&nbsp;</td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)hshRecord.get("dblSglLimit")))%></td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)hshRecord.get("dblSglOutstand")))%></td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)hshRecord.get("dblSglIntRate")))%></td>
						<td align="left">&nbsp;</td>
					</tr>
				<%} %>
				</table>
			</div>
		</td>
	</tr>
<%} } %>


<%
if(arrMultipleCons!=null && arrMultipleCons.size()>0){ %>
<tr>
	<td class="title"><br>Term Loan:</td>
</tr>

<!-- Multiple - Consortium -->			
<%
if(arrMultipleCons!=null && arrMultipleCons.size()>0)
{
	StringTokenizer st1 = new StringTokenizer(multipleConsflag,",");
	for(int i=0;i<arrMultipleCons.size();i++)
	{
		if(st1.hasMoreTokens())
		{
			val = (String)st1.nextToken();
			if(val.equals("Y")) flag="Y";
			else flag="N";
			arrCol	= (ArrayList)arrMultipleCons.get(i);
			
%>
	<tr>
		<td class="title">Consortium<% if(arrMultipleCons.size()>1) out.println(" "+(i+1));%>:<br>
		<br><b>Leader:</b>&nbsp;<%=Helper.changetoTitlecase(Helper.correctNull((String)hshRecord.get("com_cons_bank_name"+(i+1)))) %></td>
	</tr>		
	
	<tr>
		<td align="right" width=""><%=strValuesIn%></td>
	</tr>
	<tr>
		<td>
			<div id="top">
				<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
					<tr>
						<td width="20%" align="center">Name of the Bank</td>
						<td width="20%" align="center">Facility</td>
						<td width="12%" align="center">Type</td>
						<td width="10%" align="center">Limit</td>
						<td width="10%" align="center">Outstanding</td>
						<% if(flag.equals("N")) { %>
						<td width="10%" align="center">Interest (%)</td>
						<% } %>
						<td width="18%" align="center">Remarks</td>
					</tr>
		<%		for(int j=0;j<arrCol.size();j++)
				{
					arrColCons	= (ArrayList)arrCol.get(j);
					intRate = Helper.correctNull((String)arrColCons.get(7));
					if(!intRate.equals(""))
						intRate = Helper.checkDecimal(intRate);
		%>	
					<tr>
						<td align="left"><%=Helper.changetoTitlecase(Helper.correctNull((String)arrColCons.get(9)))%></td>
						<td align="left"><%=Helper.changetoTitlecase(Helper.correctNull((String)arrColCons.get(10)))%></td>
						<td align="left"><%=Helper.correctNull((String)arrColCons.get(3))%></td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)arrColCons.get(5)))%></td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)arrColCons.get(6)))%></td>
						<% if(flag.equals("N")) { %>
						<td align="right"><%=intRate%></td>
						<% } %>
						<td align="left"><%=Helper.correctNull((String)arrColCons.get(8))%></td>
					</tr>
			<%} %>	
			<% if(arrMultipleCons.size()>1) {  %>
					<tr>
						<td align="left">TOTAL</td>
						<td align="left">&nbsp;</td>
						<td align="left">&nbsp;</td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)hshRecord.get("dblMtplConsLimit"+(i+1))))%></td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)hshRecord.get("dblMtplConsOutstand"+(i+1))))%></td>
						<% if(flag.equals("N")) { %>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)hshRecord.get("dblMtplConsIntRate"+(i+1))))%></td>
						<% } %>
						<td align="left">&nbsp;</td>
					</tr>
				<%} %>	
				</table>
			</div>
		</td>
	</tr>
<%} } } } %>

<!-- TL : Multiple - Consortium -->
<%
if(arrMultiple!=null && arrMultiple.size()>0){ %>
<tr>
	<td class="title"><br>Term Loan:</td>
</tr>
<%
if(arrMultiple!=null && arrMultiple.size()>0)
{ 
%>
	<tr>
		<td align="right" width=""><%=strValuesIn%></td>
	</tr>
	<tr>
		<td>
			<div id="top">
				<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
					<tr>
						<td width="25%" align="center">Facility</td>
						<td width="15%" align="center">Type</td>
						<td width="12%" align="center">Limit</td>
						<td width="12%" align="center">Outstanding</td>
						<td width="12%" align="center">Interest (%)</td>
						<td width="24%" align="center">Remarks</td>
					</tr>
			<%	for(int i=0;i<arrMultiple.size();i++)
				{
					arrCol	= (ArrayList)arrMultiple.get(i);
				%>
					<tr>
						<td align="left"><%=Helper.changetoTitlecase(Helper.correctNull((String)arrCol.get(10)))%></td>
						<td align="left"><%=Helper.correctNull((String)arrCol.get(3))%></td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)arrCol.get(5)))%></td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)arrCol.get(6)))%></td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)arrCol.get(7)))%></td>
						<td align="left"><%=Helper.correctNull((String)arrCol.get(8))%></td>
					</tr>
			<%} %>
			<% if(arrMultiple.size()>1) {  %>
					<tr>
						<td align="left">TOTAL</td>
						<td align="left">&nbsp;</td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)hshRecord.get("dblMtplLimit")))%></td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)hshRecord.get("dblMtplOutstand")))%></td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)hshRecord.get("dblMtplIntRate")))%></td>
						<td align="left">&nbsp;</td>
					</tr>
				<%} %>
				</table>
			</div>
		</td>
	</tr>
<%} } %>

<!-- WC : Single - Consortium -->
<%
if(arrSingleConsWC!=null && arrSingleConsWC.size()>0)
{
%>
<tr>
	<td class="title"><br>Working Capital:</td>
</tr>
<tr>
	<td><b>Leader:</b>&nbsp;<%=Helper.changetoTitlecase(Helper.correctNull((String)hshRecord.get("com_cons_bank_name_WC"))) %></td>
</tr>
			
<%
if(arrSingleConsWC!=null && arrSingleConsWC.size()>0)
{ 
%>
	<tr>
		<td align="right" width=""><%=strValuesIn%></td>
	</tr>
	<tr>
		<td>
			<div id="top">
				<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
					<tr>
						<td width="25%" align="center">Name of the Bank</td>
						<td width="25%" align="center">Facility</td>
						<td width="15%" align="center">Type</td>
						<td width="12%" align="center">Limit</td>
						<td width="12%" align="center">Outstanding</td>
						<td width="12%" align="center">Interest (%)</td>
						<td width="24%" align="center">Remarks</td>
					</tr>
					<%
					for(int i=0;i<arrSingleConsWC.size();i++)
					{
						arrCol	= (ArrayList)arrSingleConsWC.get(i);
					%>
					<tr>
						<td align="left"><%=Helper.changetoTitlecase(Helper.correctNull((String)arrCol.get(9)))%></td>
						<td align="left"><%=Helper.changetoTitlecase(Helper.correctNull((String)arrCol.get(10)))%></td>
						<td align="left"><%=Helper.correctNull((String)arrCol.get(3))%></td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)arrCol.get(5)))%></td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)arrCol.get(6)))%></td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)arrCol.get(7)))%></td>
						<td align="left"><%=Helper.correctNull((String)arrCol.get(8))%></td>
					</tr>
					<%} %>
				</table>
			</div>
		</td>
	</tr>
<%} } %>

<%
out.println("arrMultipleConsWC : " + arrMultipleConsWC);
if(arrMultipleConsWC!=null && arrMultipleConsWC.size()>0){ %>
<tr>
	<td class="title"><br>Working Capital:</td>
</tr>

<!-- WC : Multiple - Consortium -->			
<%
if(arrMultipleConsWC!=null && arrMultipleConsWC.size()>0)
{ 
	StringTokenizer st = new StringTokenizer(multipleConsWCflag,",");
	for(int i=0;i<arrMultipleConsWC.size();i++)
	{
		if(st.hasMoreTokens())
		{
			val = (String)st.nextToken();
			if(val.equals("Y")) flag="Y";
			else flag="N";
		arrCol	= (ArrayList)arrMultipleConsWC.get(i);
		
%>
	<tr>
		<td class="title">Consortium<% if(arrMultipleConsWC.size()>1) out.println(" "+(i+1)); %>:<br><br>
		<b>Leader:</b>&nbsp;<%=Helper.changetoTitlecase(Helper.correctNull((String)hshRecord.get("com_cons_bank_name_WC"+(i+1)))) %></td>
	</tr>		
	
	<tr>
		<td align="right" width=""><%=strValuesIn%></td>
	</tr>
	<tr>
		<td>
			<div id="top">
				<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
					<tr>
						<td width="20%" align="center">Name of the Bank</td>
						<td width="20%" align="center">Facility</td>
						<td width="12%" align="center">Type</td>
						<td width="10%" align="center">Limit</td>
						<td width="10%" align="center">Outstanding</td>
						<% if(flag.equals("N")) { %>
						<td width="10%" align="center">Interest (%)</td>
						<% } %>
						<td width="18%" align="center">Remarks</td>
					</tr>
	<%		for(int j=0;j<arrCol.size();j++)
			{
				arrColCons	= (ArrayList)arrCol.get(j);
				intRate = Helper.correctNull((String)arrColCons.get(7));
				if(!intRate.equals(""))
					intRate = Helper.checkDecimal(intRate);
	%>	
					<tr>
						<td align="left"><%=Helper.changetoTitlecase(Helper.correctNull((String)arrColCons.get(9)))%></td>
						<td align="left"><%=Helper.changetoTitlecase(Helper.correctNull((String)arrColCons.get(10)))%></td>
						<td align="left"><%=Helper.correctNull((String)arrColCons.get(3))%></td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)arrColCons.get(5)))%></td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)arrColCons.get(6)))%></td>
						<%if(flag.equals("N")) { %>
						<td align="right"><%=intRate%></td>
						<%} %>
						<td align="left"><%=Helper.correctNull((String)arrColCons.get(8))%></td>
					</tr>
		<%} %>		
				</table>
			</div>
		</td>
	</tr>
<%} } } %>

<!-- TL : Multiple - Consortium -->
<%
out.println("arrMultipleWC : " + arrMultipleWC);
if(arrMultipleWC!=null && arrMultipleWC.size()>0){ 
%>
<tr>
	<td class="title"><br>Working Capital:</td>
</tr>
<%
if(arrMultipleWC!=null && arrMultipleWC.size()>0)
{ 
%>
	<tr>
		<td align="right" width=""><%=strValuesIn%></td>
	</tr>
	<tr>
		<td>
			<div id="top">
				<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
					<tr>
						<td width="20%" align="center">Name of the Bank</td>
						<td width="20%" align="center">Facility</td>
						<td width="12%" align="center">Type</td>
						<td width="10%" align="center">Limit</td>
						<td width="10%" align="center">Outstanding</td>
						<td width="10%" align="center">Interest (%)</td>
						<td width="18%" align="center">Remarks</td>
					</tr>
			<%	for(int i=0;i<arrMultipleWC.size();i++)
				{
					arrCol	= (ArrayList)arrMultipleWC.get(i);
				%>
					<tr>
					<td align="left"><%=Helper.changetoTitlecase(Helper.correctNull((String)arrCol.get(9)))%></td>
						<td align="left"><%=Helper.changetoTitlecase(Helper.correctNull((String)arrCol.get(10)))%></td>
						<td align="left"><%=Helper.correctNull((String)arrCol.get(3))%></td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)arrCol.get(5)))%></td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)arrCol.get(6)))%></td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)arrCol.get(7)))%></td>
						<td align="left"><%=Helper.correctNull((String)arrCol.get(8))%></td>
					</tr>
			<%} %>
				</table>
			</div>
		</td>
	</tr>
<% } }  } %>


<!-- Multiple Banking -->
<%
if(arrMultiBnk!=null && arrMultiBnk.size()>0){ %>
<tr>
	<td class="title"><br>Existing and Proposed Exposure:</td>
</tr>
<%
if(arrMultiBnk!=null && arrMultiBnk.size()>0)
{ 
	for(int j=0;j<arrMultiBnk.size();j++)
	{
		arrColCons	= (ArrayList)arrMultiBnk.get(j);
		out.println("Count Existing : " + Helper.correctNull((String)hshRecord.get("countexiting")));
%>
	
	<%if(Helper.correctNull((String)hshRecord.get("countexiting")).equalsIgnoreCase("Y"))
		{%>
	
	<%}else{
		%>
		<tr>
		<td class="title"><br>Consortium <%=j+1%>:</td>
	</tr>
	<%} %>
	
	<tr>
		<td align="right" width=""><%=strValuesIn%></td>
	</tr>
	<tr>
		<td>
			<div id="top">
				<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
				<tr>
	  			  	<td> &nbsp;&nbsp;	Name of the Bank  </td>
	  			  	<td colspan="6" align="center">Existing Exposure  </td>
	  			  	<td colspan="6" align="center">Proposed Exposure </td>
	  			</tr>
	  			<tr align="center">
	  			  	<td>&nbsp;</td>
	  			  	<td>FB</td>
	  			  	<td>% FB<br> exposure</td>
	  			  	<td>NFB</td>
	  			  	<td>% NFB<br> Exposure</td>
	  			  	<td>Total</td>
	  			  	<td>% Total<br> exposure</td>
	  				<td>FB</td>
	  			  	<td>% FB<br> exposure</td>
	  			  	<td>NFB</td>
	  			  	<td>% NFB<br> exposure</td>
	  			  	<td>Total</td>
	  			  	<td>% Total<br> exposure</td>
	  			</tr>
			<%	for(int i=0;i<arrColCons.size();i++)
				{
					arrCol	= (ArrayList)arrColCons.get(i);
				%>
					<tr>
						<td align="left"><%=Helper.changetoTitlecase(Helper.correctNull((String)arrCol.get(1)))%></td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)arrCol.get(2)))%></td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)arrCol.get(3)))%></td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)arrCol.get(4)))%></td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)arrCol.get(5)))%></td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)arrCol.get(6)))%></td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)arrCol.get(7)))%></td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)arrCol.get(8)))%></td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)arrCol.get(9)))%></td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)arrCol.get(10)))%></td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)arrCol.get(11)))%></td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)arrCol.get(12)))%></td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)arrCol.get(13)))%></td>
					</tr>
			<%} %>
			<% if(arrMultiBnk.size()>1) {  %>
					<tr>
						<td align="left">TOTAL</td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)hshRecord.get("FbSum"+(j+1))))%>&nbsp;</td>
						<td align="right">100.00</td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)hshRecord.get("NfbSum"+(j+1))))%>&nbsp;</td>
						<td align="right">100.00</td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)hshRecord.get("ExistSum"+(j+1))))%>&nbsp;</td>
						<td align="right">100.00</td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)hshRecord.get("ProFbSum"+(j+1))))%>&nbsp;</td>
						<td align="right">100.00</td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)hshRecord.get("ProNfbSum"+(j+1))))%>&nbsp;</td>
						<td align="right">100.00</td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)hshRecord.get("ProSum"+(j+1))))%>&nbsp;</td>
						<td align="right">100.00</td>
					</tr>
			<%} %>		
				</table>
			</div>
		</td>
	</tr>
<%} } } %>
	</table>
	</div>
	</td>
	</tr>
	
	<!-- Banking Arrangment End -->
	
	
	
	
	
	
	
	
	
	
	
	<tr>
		<td align="left" width="3%" rowspan="6" valign="top">15.</td>
		<td align="left" width="35%">Provisional  receipts/sales as on</td>
		<td align="left" width="62%"><%=Helper.correctNull((String) hshValues.get("MD_PROVISIONALASON"))%></td>
	</tr>
	<tr>
		<td>Estimated for</td>
		<td><%=Helper.correctNull((String) hshValues.get("MD_ESTIMATEFOR"))%></td>
	</tr>
	<tr>
		<td>Actuals upto</td>
		<td><%=Helper.correctNull((String) hshValues.get("MD_ACTUALSUPTO"))%></td>
	</tr>
	<tr>
		<td>Projections for</td>
		<td><%=Helper.correctNull((String) hshValues.get("MD_PROJECTIONFOR"))%></td>
	</tr>
	<tr>
		<td>Accepted for</td>
		<td><%=Helper.correctNull((String) hshValues.get("MD_ACCEPTEDFOR"))%></td>
	</tr>
	<tr>
		<td>Remarks</td>
		<td><%=Helper.correctNull((String) hshValues.get("MD_REMARKS"))%></td>
	</tr>
	<tr>
		<td align="left" width="3%" rowspan="7" valign="top">16.</td>
		<td align="left" width="35%">Whether the account is a take over</td>
		<td align="left" width="62%"></td>
	</tr>
	<tr>
		<td>If yes furnish details</td>
		<td></td>
	</tr>
	<tr>
		<td>Name of the bank from which limits are taken over</td>
		<td></td>
	</tr>
	<tr>
		<td>Reasons for shifting the account</td>
		<td><%=Helper.correctNull((String) hshValues.get("MD_SHIFTINGREASON"))%></td>
	</tr>
	<tr>
		<td>Whether take over norms are fulfilled</td>
		<td>
		<%if(Helper.correctNull((String) hshValues.get("MD_WHETHERTAKEOVER_FULFIL")).equals("Y")) {
			out.println("Yes");
		} else if(Helper.correctNull((String) hshValues.get("MD_WHETHERTAKEOVER_FULFIL")).equals("N")) {
			out.println("No");
		}%></td>
	</tr>
	<tr>
		<td>If no what is the deviation</td>
		<td><%=Helper.correctNull((String) hshValues.get("MD_DEVIATIONCOMMENTS"))%></td>
	</tr>
	<tr>
		<td>Justification for taking over the account with deviation</td>
		<td><%=Helper.correctNull((String) hshValues.get("MD_JUSTIFICATION"))%></td>
	</tr>
	<tr>
		<td align="left" rowspan="8" valign="top">17.</td>
		<td align="left" colspan="2">Particulars of current sanction:</td>
	</tr>
	<tr>
		<td>A. Sanction reference</td>
		<td><%=Helper.correctNull((String)hshValues.get("sanc_ref_no"))%></td>
	</tr>
	<tr>
		<td>B. Amount/limit sanctioned </td>
		<td><%=Helper.correctNull((String)hshValues.get("sanction_amount"))%></td>
	</tr>
	<tr>
		<td>C. Period</td>
		<td></td>
	</tr>
	<tr>
		<td>D. Interest</td>
		<td><%=Helper.correctNull((String)hshValues.get("loan_modintrate"))%>% 
                  &nbsp;(p.a.) <%=Helper.correctNull((String)hshValues.get("loan_inttype"))%>&nbsp;</td>
	</tr>
	<tr>
		<td>E. Margin</td>
		<td><%=total_percentage %>%&nbsp;</td>
	</tr>
	<tr>
		<td>F. Brief Security particulars and value :</td>
		<td></td>
	</tr>
	<tr>
		<td>G. Comments on DSCR and viability study (if applicable):</td>
		<td></td>
	</tr>
	<tr>
		<td align="left" width="3%" valign="top" rowspan="2">18.</td>
		<td align="left" width="35%" colspan="2">Particulars of Group Companies & Status:</td>
		</tr>
		<%
		
		int Count=0;
		arrRow1 = new ArrayList();
		strGrpconcern=""; boolean flag1=false;
		if(arrGroupconcerns!=null && arrGroupconcerns.size()>0){
			for(int s=0;s<arrGroupconcerns.size();s++){
				strGrpconcern=Helper.correctNull((String)arrGroupconcerns.get(s));
				if(s==0) {
					flag1=true;
				%>
				<tr><td colspan="2">
		<div id="top">
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
		<tr>
		   <td><b>Sl.No</b></td>
		   <td><b>Name of the concern</b></td>
		   <td><b>Constitution</b></td>
		    <td><b>Proprietor/ Partners/ Directors</b></td>
		    <td><b>Activity/ Nature of business</b></td>
		    <td><b>Bankers</b></td>
		</tr>
				<% }
		if(hshGroupConcern!= null)
			arrGroupConcernDetailsRow1	= (ArrayList)hshGroupConcern.get("arrGroupConcernDetails1"+strGrpconcern);
		
		if(arrGroupConcernDetailsRow1!=null && arrGroupConcernDetailsRow1.size()>0){
			for(int i=0;i<arrGroupConcernDetailsRow1.size();i++){
				arrGroupConcernDetailsCol1=(ArrayList)arrGroupConcernDetailsRow1.get(i);
				arrRow1=(ArrayList)arrGroupConcernDetailsCol1.get(5);
				Count++;
			%>
			<tr>
			<td><%=Count%></td>
			<td><%=Helper.changetoTitlecase(Helper.correctNull((String)arrGroupConcernDetailsCol1.get(2)))%>.<%=Helper.changetoTitlecase(Helper.correctNull((String)arrGroupConcernDetailsCol1.get(1)))%></td>
			<td><%=Helper.changetoTitlecase(Helper.correctNull((String)arrGroupConcernDetailsCol1.get(0)))%></td>
			<td>Group Concern</td>
			<td><%=Helper.correctNull((String)arrGroupConcernDetailsCol1.get(3))%></td>
			<td><%=Helper.correctNull((String)arrGroupConcernDetailsCol1.get(6))%></td>	
			</tr>
		<%} %>
		
		
		<% } } } if(flag1) { %>
		</table>
		</div>
		</td>
		</tr>
			<% } %>	
		</td>
	</tr>
	<tr>
		<td align="left" width="3%" valign="top">19.</td>
		<td align="left" width="35%">Any other information</td>
		<td align="left" width="62%"><%=Helper.correctNull((String) hshValues.get("MD_ANYOTHERINFO"))%></td>
	</tr>
	</table>
</div></td>
</tr>
	<tr><td>&nbsp;</td></tr>
	<tr><td>
		<table width="100%" border="0" align="center" cellpadding="20"  cellspacing="0" 
		    		class="outertable">
    		<tr><td>&nbsp;</td></tr>	
			<tr align="center">
			<td width="25%" align="left"><b>DEPUTY GENERAL MANAGER</b></td>
			<td width="25%" align="right"><b>GENERAL MANAGER</b></td>								
			</tr>
			<tr><td>&nbsp;</td></tr>		
			<tr align="center">
			<td width="25%" align="left"><b>CHIEF GENERAL MANAGER</b></td>
			<td>&nbsp;</td>						
			</tr>    	
			<tr align="center">
			<td width="25%" align="center" colspan="2"><b>MANAGING DIRECTOR</b></td>						
			</tr>    	
		</table>
	</td></tr>
	
	
	
</table>
</body>
</html>