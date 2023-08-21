<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	
<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />

<%

ArrayList arrCol = new ArrayList();
ArrayList arrRow = new ArrayList();
ArrayList arrGroupInfo=new ArrayList();
ArrayList arrGurdetails = new ArrayList();
ArrayList arrOtherInfo = new ArrayList();
ArrayList arrayCol=new ArrayList();

ArrayList arrAppSec_LandRow=new ArrayList();
ArrayList arrAppSec_BuildRow=new ArrayList();
ArrayList arrAppSec_plantmachRow=new ArrayList();
ArrayList arrAppSec_vehicleFurRow=new ArrayList();
ArrayList arrAppSec_stockbookRow=new ArrayList();
ArrayList arrAppSec_othersRow=new ArrayList();
ArrayList arrAppSec_tempcol=new ArrayList();
HashMap hshVal=(HashMap)hshValues.get("hshVal");

arrGroupInfo=(ArrayList)hshValues.get("arrGroupInfo");
arrGurdetails=(ArrayList)hshValues.get("arrGuardetailsRow");
arrOtherInfo=(ArrayList)hshValues.get("arrOtherInfo");
arrAppSec_LandRow=(ArrayList)hshValues.get("arrAppSec_LandRow");
arrAppSec_BuildRow=(ArrayList)hshValues.get("arrAppSec_BuildRow");
arrAppSec_plantmachRow=(ArrayList)hshValues.get("arrAppSec_plantmachRow");
arrAppSec_vehicleFurRow=(ArrayList)hshValues.get("arrAppSec_vehicleFurRow");
arrAppSec_stockbookRow=(ArrayList)hshValues.get("arrAppSec_stockbookRow");
arrAppSec_othersRow=(ArrayList)hshValues.get("arrAppSec_othersRow");

double totalsec=0.00;
String strnature=Helper.correctNull((String)hshValues.get("CG_NATUREINDUSTRY"));
java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
nf.setGroupingUsed(false);
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
%>
<%
ArrayList arrRowDefault		= new ArrayList();//need
ArrayList arrRowCIBIL	= new ArrayList();//need
ArrayList arrColCIBIL	= new ArrayList();
ArrayList arrColDefault		= new ArrayList();
HashMap hshRecord1=new HashMap();
HashMap hshRecord2=new HashMap();
ArrayList VecRow		= new ArrayList();
ArrayList VecCol		= new ArrayList();

hshRecord1 = (HashMap)hshVal.get("hshValues");
hshRecord2 = (HashMap)hshVal.get("hshReqValues5");

	

if(hshValues!=null)
{
	
	arrRowDefault = (ArrayList)hshRecord2.get("arrRowDefault");
	arrRowCIBIL = (ArrayList)hshRecord2.get("arrRowCIBIL");

}
String strNil= "Nil";
%>
<%
			if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
			}

HashMap hshRecord=new HashMap();
// java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
 nf.setGroupingUsed(false);
 nf.setMaximumFractionDigits(2);
 nf.setMinimumFractionDigits(2);
 ArrayList vecid1 = (ArrayList) hshVal.get("vecid1");
 ArrayList vecid2 = (ArrayList) hshVal.get("vecid2");
 ArrayList vecid3 = (ArrayList) hshVal.get("vecid3");
 ArrayList vecid4 = (ArrayList) hshVal.get("vecid4");
 ArrayList vecid5 = (ArrayList) hshVal.get("vecid5");
 
 
// hshRecord=(HashMap)hshVal.get("hshReqValues5");
String bgclr = "";
String tagFlag = "";
int p = 0, sizeyear = 0, from = 0, to = 0, vecModSize = 0,sizeyearval=5,sizeyearval1=5;
String temp = "", totcount = "", upto = "", pageval = "", strCurModule = "", identity = "", fromnext = "",tempyear="",facLoanType="",promoterPhyChallenged="",strCheifPromoter="",promoAadhaar="",mobileNo="",networth="";;
totcount = Helper.correctNull((String) hshVal.get("totalyear"));



String strValuesIn="";
fromnext = Helper.correctNull((String) hshVal.get("from"));
pageval = Helper.correctNull((String) hshVal.get("page"));
identity = Helper.correctNull((String) hshVal.get("identity"));
tempyear= Helper.correctNull((String) hshVal.get("tempyear"));
String strLoanType=Helper.correctNull((String) hshValues.get("FacilityNature"));
String strCgtmseFlag=Helper.correctNull((String) hshValues.get("FacilityCgtmseFlag"));

String strEdu_agri=Helper.correctNull((String) hshValues.get("CG_EDUCATION"));
String strNcgtc=Helper.correctNull((String) hshValues.get("CG_NCGTC"));

String strCONSTITUTION=Helper.correctNull((String) hshValues.get("CONSTITUTION"));

String aadhar=Helper.correctNull((String) hshValues.get("PERAPP_AADHAAR"));
String physicallyChallenged=Helper.correctNull((String) hshValues.get("PHYSICALLY_CHALLENGED"));
       promoterPhyChallenged=Helper.correctNull((String) hshValues.get("PHY_CHALLANGED"));
       strCheifPromoter=Helper.correctNull((String) hshValues.get("CHF_PROMOTER"));
       promoAadhaar=Helper.correctNull((String) hshValues.get("PROMOTER_AADHAAR"));
String indMobile= Helper.correctNull((String) hshValues.get("CON_MOBILE"));
String proMobile= Helper.correctNull((String) hshValues.get("PROMOTER_MOBILE"));  
String promNetworth=Helper.correctNull((String)hshValues.get("promoNetworth"));
String indNetworth=Helper.correctNull((String)hshValues.get("PERAPP_NETWORTH"));
Double exsistAmt=Double.parseDouble(Helper.correctDouble((String)hshValues.get("ExsistingAmt"))); 
Double prosoedAmt=Double.parseDouble(Helper.correctDouble((String)hshValues.get("proposedAmt")));
String renewFlag=Helper.correctNull((String)hshValues.get("loanRenewFlag"));
     
       
  

String strAadhar="",strphysicallyChallenged="";

if(strEdu_agri.equalsIgnoreCase("N")){
	 strEdu_agri="NO";
}

 //type of loan
/* if(strCgtmseFlag.equalsIgnoreCase("Y")){
	if(strLoanType.equalsIgnoreCase("TL")|| strLoanType.equalsIgnoreCase("DL")){
		facLoanType="Term Loan";	
	}else if(strLoanType.equalsIgnoreCase("OD")){
		facLoanType="Working Capital";
	}else{
		facLoanType="";
	} 
	
}
 */
 //loan type
 if(strLoanType.equalsIgnoreCase("OD"))
 {
 if(renewFlag.equalsIgnoreCase("R"))
 {
	   if(exsistAmt < prosoedAmt )
	   {
		   facLoanType="Renewal of Cover for WC";
	   }
	   else //if(exsistAmt > prosoedAmt )
	   {
		   facLoanType="Enhancement in WC";
	   }
	 
 }
  else
    {
	   facLoanType="Working Capital";
    }
 
 }
else{
	facLoanType="Term Loan";
  }
//NCGTC
if(strNcgtc.equalsIgnoreCase("N")){
	strNcgtc="NO";
}

//individual or NonIndividual
if(strCONSTITUTION.equalsIgnoreCase("01")){
	if(aadhar ==""){
		strAadhar="NIL";
	
	}else{
		strAadhar=aadhar;
	}
}else if(strCONSTITUTION != "01"){
	       if(strCheifPromoter.equalsIgnoreCase("Y")){
	    	   if(promoAadhaar !="")
	    	   strAadhar=promoAadhaar;
	       }else{
	    	   strAadhar="NIL";
	       }
	
}





//physically challenged check
if(strCONSTITUTION.equalsIgnoreCase("01")){
	if(physicallyChallenged.equalsIgnoreCase("N")){
		strphysicallyChallenged="NO";
	}else{
		strphysicallyChallenged="yes";
	     }
}else if(strCONSTITUTION != "01"){
	if(strCheifPromoter.equalsIgnoreCase("Y")){
		 if(promoterPhyChallenged.equalsIgnoreCase("N")){
			 strphysicallyChallenged="NO";			 
		 }else{
			 strphysicallyChallenged="YES";
		 }
	}
}
	



//mobile Number applicant or chief promoter Mobile Number
if(strCheifPromoter != "Y"){
	  mobileNo=indMobile;
}else{
	  mobileNo=proMobile;
    }


if(strCONSTITUTION.equalsIgnoreCase("01")){
	  networth=indNetworth;
	  
}
else{
	  networth=promNetworth;
   }


strCurModule = pageval;
ArrayList g1=new ArrayList();
ArrayList g2=new ArrayList();
ArrayList g3 = new ArrayList();
ArrayList g4 = new ArrayList();
ArrayList year1 = new ArrayList();
ArrayList year2 = new ArrayList();
ArrayList year3 = new ArrayList();
ArrayList year4 = new ArrayList();
ArrayList year5 = new ArrayList();

VecRow=(ArrayList)hshVal.get("VecRow");


g2 = (ArrayList) hshVal.get("yearvalue");

g3 = (ArrayList) hshVal.get("value");
g4 = (ArrayList) hshVal.get("yearvalue_strt");
year1 = (ArrayList) hshVal.get("year1");
year2 = (ArrayList) hshVal.get("year2");
year3 = (ArrayList) hshVal.get("year3");
year4 = (ArrayList) hshVal.get("year4");
year5 = (ArrayList) hshVal.get("year5");



ArrayList vecModule = (ArrayList) hshVal.get("tabdetails");

boolean flag=false;


if (vecModule != null) {
	vecModSize = vecModule.size();
}

if (g2.size() != 0)
 {
	flag=true;
	 sizeyear=g2.size();
	 sizeyearval=sizeyear/2;
	 sizeyearval1=sizeyearval;
 }


String yearval[] = new String[sizeyearval];
String comboselect[] = new String[sizeyearval];
String yearval_strt[] = new String[5];
String snos[] = new String[5];


int intSection_count=0;
int intQuotient = (sizeyearval / 5);
int intRemainder = (sizeyearval % 5);
if(sizeyearval > 5)
{
	if(intRemainder == 0)
		intSection_count = intQuotient;
	else
		intSection_count = intQuotient + 1;
}
else
{
	intSection_count = 1;
}
int y = 0,n=0;
	if (g2.size() != 0)
	{
 sizeyear=g2.size();
  
for (int k=0;k<=g2.size()-1;k++)
{

	if ((k % 2 ) == 0)
		{
			temp=Helper.correctNull((String)g2.get(k));
			yearval[y]=temp;
			y =y+1;
		}
	else if ((k % 2) == 1)
		{
			temp=Helper.correctNull((String)g2.get(k));
			if (temp.trim().equals("CGTMSE_AUDIT")) {
				temp = "AUDITED";
			} else if (temp.trim().equals("CGTMSE_UNAUDIT")) {
				temp = "UNAUDITED";
			} else if (temp.trim().equals("CGTMSE_ESTIMATED")) {
				temp = "ESTIMATED";
			} else if (temp.trim().equals("CGTMSE_PROJECTION")) {
				temp = "PROJECTION";
			}
			
			comboselect[n]=temp;
			n = n+1;
		}	 		
}

for (int d = 0 ; d < sizeyearval ; d++)
 {
	
	if (comboselect[d] == null)
	 {
	comboselect[d] = "";
	
	 }
	if (yearval[d] == null)
	 {
	yearval[d]="";			
	 }	
 }	
}
else
{		
 for ( p=0;p<=4;p++)
 {
	comboselect[p]= "";		
	yearval[p]= "";
 }
}


String samplevalue="";
int sampleval=0;
String loanmodule="";
String loanmoduletype="";

String strfintype = Helper.correctNull((String)hshVal.get("fintype"));
String checkcol1= Helper.correctNull((String)hshVal.get("checkcol1"));
String checkcol2= Helper.correctNull((String)hshVal.get("checkcol2"));
String checkcol3= Helper.correctNull((String)hshVal.get("checkcol3"));
String checkcol4= Helper.correctNull((String)hshVal.get("checkcol4"));
String checkcol5= Helper.correctNull((String)hshVal.get("checkcol5"));

String print_selyear1 = "", print_selyear2 = "", print_selyear3 = "", print_selyear4 = "", print_selyear5 = "";
print_selyear1 = Helper.correctNull((String) hshVal.get("printchk1"));
print_selyear2 = Helper.correctNull((String) hshVal.get("printchk2"));
print_selyear3 = Helper.correctNull((String) hshVal.get("printchk3"));
print_selyear4 = Helper.correctNull((String) hshVal.get("printchk4"));
print_selyear5 = Helper.correctNull((String) hshVal.get("printchk5"));


String hshRecord_flag=Helper.correctNull((String)hshVal.get("recordFlag"));
 int rowid_count=Integer.parseInt(Helper.correctInt((String)hshVal.get("rowid_count")));
 ArrayList labeld_details=new ArrayList();
 labeld_details=(ArrayList) hshVal.get("arr_labeldetails");

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<style type="text/css">
body,table td {
	FONT-SIZE: 16px !important;
	COLOR: #000000 !important;
	FONT-FAMILY: "Book Antiqua" !important;
}

#top {
	background-color: #ffffff;
}


.tblheader {  font-family: Book Antiqua; font-size: 16px; font-weight: bold; background-color: #efefef}

</style>

<script type="text/javascript">

</script>

<title>Annexure</title>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<SCRIPT LANGUAGE="JavaScript">
</SCRIPT>
</head>
<script>
var govtDC="<%=Helper.correctNull((String)hshValues.get("CG_ARTISAN_CC"))%>";
var jointFinance="<%=Helper.correctNull((String)hshValues.get("CG_JOINTFINANCE"))%>";
var PrevCGTMSE="<%=Helper.correctNull((String)hshValues.get("CG_PRV_CGP"))%>";
var AsistBank="<%=Helper.correctNull((String)hshValues.get("CG_ASISTBANK"))%>";
function IdCardEnable()
{
	if(govtDC=="YES")
	{		
		document.all.idIssued.style.display="table-row";
		document.all.idIssued2.style.display="table-row";
	}
	else
	{
		document.all.idIssued.style.display="none";
		document.all.idIssued2.style.display="none";
	}
}

function CgpanEnable()
{
	if(jointFinance=="YES")
	{
		document.all.idCgpan.style.display="table-row";
	}
	else
	{
		document.all.idCgpan.style.display="none";
	}
}

function PreCGpan()
{ 
	/*if(document.forms[0].PrevCGTMSE.value=="" || document.forms[0].PrevCGTMSE.value=="N" )
	 {
		document.forms[0].PrevCGPan.value="";
	 }*/
	
	if(PrevCGTMSE=="YES")
	{ 	
		document.all.prvcgpan.style.display="table-row";
		document.all.idAvailAmt.style.display="table-row";
	}
	else
	{
		document.all.prvcgpan.style.display="none";
		document.all.idAvailAmt.style.display="none";
	}
	
}
function callOutstandAmt()
{
	if(AsistBank=="YES")
	{
		document.all.idOutsamt.style.display="table-row";
		document.all.idAsistNpa.style.display="table-row";
	}
	else
	{
		document.all.idOutsamt.style.display="none";
		document.all.idAsistNpa.style.display="none";
	}
		
}
function callonload()
{ 
	

	var facilityNature="<%=Helper.correctNull((String) hshValues.get("FacilityNature"))%>";
	var facLoanType="<%=facLoanType%>";
	//alert("facLoanType"+facLoanType);
	//alert("facility"+facilityNature);
	if(facilityNature=="2" || facilityNature=="OD")
	{
		//alert("aaaa"+facilityNature);
		document.all.WCMF.style.display="table-row";
		//document.all.WCDet.style.display="table-row";
		document.all.TLMF.style.display="none";
		document.all.TLDet.style.display="none";
	    document.all.TLDet1.style.display="none";
		
		
	}
 	if(facilityNature=="1"  || facilityNature=="TL" || facilityNature=="DL")
	{
		document.all.TLMF.style.display="table-row";
		document.all.TLDet.style.display="table-row";
		document.all.WCMF.style.display="none";
		//document.all.WCDet.style.display="none";
		document.all.WCDet2.style.display="none";
		
	} 
	
	/* if(facilityNature=="1" ||  facilityNature=="TL" || facilityNature=="DL") 
	{
	
		document.all.wcdtcgt1.style.visibility="visible";
	    document.all.wcdtcgt1.style.position="relative";
	}
	 else
	{
		
		document.all.wcdtcgt1.style.visibility="hidden";
	    document.all.wcdtcgt1.style.position="absolute";
	}  */
}
</script>
<body onload="callonload();IdCardEnable();CgpanEnable();PreCGpan();callOutstandAmt();">
<table width="100%" border="1" cellspacing="0" cellpadding="0">
	<tr>
		<td>

		<table width="95%" border="0" cellpadding="3" cellspacing="0"
			align="center">
			<tr>
				<td>
				<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0">
					<tr>
						<td align="center" colspan="4"><br>
						<img src="<%=ApplicationParams.getAppUrl()%>img/kbl_newlogo.jpg"></td>
					</tr>
					<tr align="center">
						<td colspan="4"><b> Branch:<u>&nbsp;<%=Helper.correctNull((String)hshValues.get("processedorg_name"))%></u></b></td>
					</tr>
					<tr align="center">
						<td colspan="4"><b><u> CGTMSE-APPLICATION FOR
						GUARANTEE COVER</u></b></td>
					</tr>
					<tr align="center">
						<td colspan="4"><b><u> Annexure for CGTMSE</u></b></td>
					</tr>
					<tr>
						<td><u> APPLICATION DETAILS :</u></td>
					</tr>
				</table>
				</td>
			</tr>

			<tr>
				<td>
				<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable">
					 <!-- <tr>
						<td width="50%"><b>*BANK/INSTITUTION REFERENCE NO (For HO
						Use) :</b></td>
						<td></td>

					</tr>  -->
					<tr>
						<td width="25%" ><b>*BANK/INSTITUTION BRANCH NAME:</b></td>
						<td   nowrap="nowrap">&nbsp;<%=Helper.correctNull((String)hshValues.get("processedorg_name"))%></td>
					</tr>
					<tr>
						<td width="25%"><b>BANK/INSTITUTION BRANCH CODE :</b></td>
						<td  nowrap="nowrap">&nbsp;<%=Helper.correctNull((String)hshValues.get("processedORG_SCODE"))%></td>
					</tr>
					<tr>
						<td width="25%"><b>BANK/INSTITUTION BRANCH STATE :</b></td>
						<td  nowrap="nowrap">&nbsp;<%=Helper.correctNull((String)hshValues.get("process_orgstate"))%></td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
			
			<tr> <td>&nbsp; </td></tr>
			

			<tr>
				<td>
				<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable">	
					
					<tr>
						<td width="25%"  colspan="2"><b>BORROWER DETAILS :</b></td>
					</tr>
					<tr>
					<td>Type of Loan</td><td><%=facLoanType%></td>
					</tr>
					 <!--  <tr>
						<td align="left">Whether borrower already assisted by bank </td>

						<td  > &nbsp;<%=Helper.correctNull((String)hshValues.get("CG_ASISTBANK"))%></td>
						

					</tr>

					<tr id="idOutsamt">
						<td width="70%"> Outstanding amount on date of
						sanction of credit facility:<img src="<%=ApplicationParams.getAppUrl()%>img/INRsymbol.png" height="12px"></td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("CG_APPDET_OUTSTAN_AMT"))%></td>
					</tr>
					<tr id="idAsistNpa">
						<td width="70%">NPA</td>
						<td >&nbsp;<%=Helper.correctNull((String)hshValues.get("CG_APPDET_NPA"))%></td>
					</tr> -->
					<tr>
						<td>Whether Borrower Covered by CGTMSE previously</td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("CG_PRV_CGP"))%></td>
					</tr>
				<% if(Helper.correctNull((String)hshValues.get("CG_PRV_CGP")).equalsIgnoreCase("YES")) %>	
					<tr id="prvcgpan">
						<td>CGPAN</td>
						<td>
						
						<%=Helper.correctNull((String) hshValues.get("TXNDET_CGPAN_NO")) %>
						<br>
							<% 
					if (Helper.correctNull((String) hshValues.get("CG_PREV_CGPAN"))
							.contains("@")) {
						

						String CG_PREV_CGPAN[] = Helper.correctNull(
								(String) hshValues.get("CG_PREV_CGPAN")).split("-");
						String CG_PREV_CGPAN1=CG_PREV_CGPAN[0].replace("@",",");
						//out.println("CG_PREV_CGPAN==>>"+CG_PREV_CGPAN1);

				%><%=CG_PREV_CGPAN1%>
				<%
					} else {
				%> <%=Helper.correctNull((String) hshValues
								.get("CG_PREV_CGPAN"))%>
				<%
					}
				%>
				&nbsp;</td>
						<!-- <td>&nbsp;<%=Helper.correctNull((String)hshValues.get("CG_PREV_CGPAN"))%></td> -->
					</tr>

				</table>
				</div>
				</td>
			</tr>



			<tr>
				<td>
				<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable">



				<!--  	<tr id="idAvailAmt">
						<td width="70%">Balance Amount available for Guarantee:<img src="<%=ApplicationParams.getAppUrl()%>img/INRsymbol.png" height="12px"></td><td>&nbsp;<%=Helper.correctNull((String)hshValues.get("CG_HANDICRAFT_AVAIL_AMT"))%></td>

					</tr> -->
					<tr>
						<td colspan="2"><b>Borrower/Units under constitution Self
						Help Group(SHG) are not eligible for CGTMSE cover.</b></td>

					</tr>
					<tr>
						<td width="30%" >* Constitution</td>
						<td>&nbsp;<%=Helper.correctNull((String) hshValues.get("PERAPP_CONSTITUTION"))%></td>
					</tr>
					<tr>
						<td width="30%" >* Borrower name</td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("fullname"))%></td>
					</tr>
				</table>
				</div>
				</td>
			</tr>






		<!--  	<tr>
				<td>
				<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable">
					<tr>
						<td width="80%">Whether the Unit Assisted is a Micro
						Enterprise and Guarantee cover is within Rs.5 lakh cap  </td>
						<td >&nbsp;<%=Helper.correctNull((String)hshValues.get("CG_MIC_ENTP"))%></td>
						

					</tr>
				</table>
				</div>
				</td>
			</tr> -->
			<tr>
				<td>
				<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable">
					<tr>
						<td width="20%"  align="center">*Borrower address</td>
						 <td width="50%">&nbsp;<%=Helper.correctNull((String)hshValues.get("txtperapp_address1"))%>&nbsp;
						&nbsp;<%=Helper.correctNull((String)hshValues.get("txtperapp_address2"))%></td>
						<td width="10%"  align="center">State</td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("txtperapp_state"))%></td>
					</tr>
					<tr>
						<td width="15%">*District</td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("txtperapp_district"))%></td>
						<td width="8%">* City</td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("txtperapp_city"))%></td>
					</tr>
					<tr>
						<td width="15%">* PIN Code</td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("txtperapp_zip"))%></td>
						<td></td>
						<td></td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
			
			<tr>
				<td>
				<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable">
					<tr>
						<td width="70%" colspan="2">ITPAN of Firm (if partnership or
						Company)</td>
           <%if(!Helper.correctNull((String)hshValues.get("PERAPP_PANNO")).equalsIgnoreCase("")){%>
						<td colspan="2">&nbsp;<%=Helper.correctNull((String)hshValues.get("PERAPP_PANNO"))%></td>
						<%}else{%>
						<td colspan="2">&nbsp;NOPAN</td>
						<%} %>

					</tr>
				<!--  	<tr>
						<td width="70%" colspan="2">MSE Registration Number</td>
						<td colspan="2"> &nbsp;<%=Helper.correctNull((String)hshValues.get("PERAPP_MSE_REGNO"))%></td>
					</tr> -->
					<tr>
						<td width="70%" colspan="2">Udyog Aadhaar Number (12 Digits)</td>
						<td colspan="2"> &nbsp;<%=Helper.correctNull((String)hshValues.get("PERAPP_UDYOG_AADHAR"))%></td>
					</tr>
					<tr>
						<td width="25%">Nature of Industry</td>
						<td width="25%" > &nbsp;<%=Helper.correctNull((String)hshValues.get("STAT_DATA_DESC1"))%></td>
						<td>* Type of Activity</td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("STAT_DATA_DESC2"))%></td>
					</tr>
					<tr>
					    <td width="25%">Industry Sector</td>
						<td width="25%" >&nbsp;<%=Helper.correctNull((String)hshValues.get("STAT_DATA_DESC"))%></td>
						<td>Number of Employees</td>
						<td nowrap="nowrap">&nbsp;<%=Helper.correctNull((String)hshValues.get("cominfo_total_employees"))%></td>
					</tr>
					<tr>
						<td>Projected Optimum Sales Turnover/Income/Receipt</td>
						<td nowrap="nowrap"> &nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("CG_PROJ_OPTI_SALES"))))%></td>
						<td>Projected Optimum Exports</td>
						<td nowrap="nowrap">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("CG_PROJ_OPTI_EXPORT"))))%></td>
					</tr>
					<tr>
					<!-- newly added -->
					<td width="25%" colspan="2">Whether unit is engaged in Training/Education/Agriculture</td>
						<td width="25%" colspan="2">&nbsp;<%=strEdu_agri%></td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
			<tr>
				<td>
				<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable">
					<tr class="tblheader">
						<td colspan="5"><b>Promoter Details:</b></td>
					</tr>
					<tr>
						<td colspan="5"><b>Individual/Promoter(Proprietor/Managing
						Partner/Managing Director details) Chief Promoter's( in case of
						firm)/Borrower (in case of individual) Information</b></td>
					</tr>
				<%
				if(Helper.correctNull((String)hshValues.get("PERAPP_CONSTITUTION_code")).equals("01")){ %>	
				<tr>
						<td colspan="5">
				<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable">
				<tr>
						<td></td>
						<td>* Title</td>
						<td colspan="3">* Borrower Name</td>
						<!--<td>* Middle Name</td>
						<td>* Last Name (Surname)</td>
					--></tr>
					<tr>
						<td >Name</td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("PERAPP_TITLE"))%></td>
						<td colspan="3">&nbsp;<%=Helper.correctNull((String)hshValues.get("PERAPP_FNAME"))%> </td>
					 </tr>
					<tr>
						<td colspan="3">ITPAN of Chief Promoter/Individual</td>
						<td colspan="2">&nbsp;<%=Helper.correctNull((String)hshValues.get("PERAPP_PANNO1"))%></td>

					</tr>
				</table>
				<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable">
					<tr>
						<td colspan="2" width="70%">*Gender&nbsp;<%=Helper.correctNull((String)hshValues.get(""))%></td>
						<td colspan="2"> &nbsp;<%=Helper.correctNull((String)hshValues.get("PERAPP_SEX"))%></td>
					</tr>
					<tr>
						<td colspan="2" width="70%">Mobile No&nbsp;</td>
						<td colspan="2"> &nbsp;<%=mobileNo%></td>
					</tr>  
					
					<tr>
						<td colspan="2">Date Of Birth</td>
						<td colspan="2">&nbsp;<%=Helper.correctNull((String)hshValues.get("PERAPP_DOB"))%></td>
					</tr>
					<tr>
						<td colspan="2" width="30%">Social Category</td>
						<td colspan="2"> &nbsp;<%=Helper.correctNull((String)hshValues.get("CG_SOCIALCATGRY"))%></td>
					</tr>
					<tr>
						<td colspan="2" width="30%">Aadhaar Number</td>
						<td colspan="2"> &nbsp;<%=strAadhar%></td>
					</tr>
					<tr>
						<td colspan="2">Whether the chief Promoter/Individual belongs
						to Minority Community</td>
						<td colspan="2"> &nbsp;<%=Helper.correctNull((String)hshValues.get("indinfo_minority"))%></td>
					</tr>
					<tr>
						<td colspan="2" width="30%">Whether the chief Promoter/Individual is physically handicapped</td>
						<td colspan="2"> &nbsp;<%=strphysicallyChallenged%></td>
					</tr>
				<!--  	<tr>
						<td >Legal ID</td>
						<td > &nbsp;<%=Helper.correctNull((String)hshValues.get("CG_LEGALID"))%></td>
						<%if(!Helper.correctNull((String)hshValues.get("CG_LEGALID")).equalsIgnoreCase("OTHERS")) { %>
						<td nowrap="nowrap">ID No</td>
						<td >&nbsp;<%=Helper.correctNull((String)hshValues.get("CG_LEGALIDNO"))%></td>
						<%} %>
					</tr>
					
					<%if(Helper.correctNull((String)hshValues.get("CG_LEGALID")).equalsIgnoreCase("OTHERS")) { %>
					<tr>
						<td width="30%">Other ID</td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("CG_OTHERIDNAME"))%></td>
						<td width="10%">ID NO</td>
						<td >&nbsp;<%=Helper.correctNull((String)hshValues.get("CG_OTHERIDNO"))%></td>
					</tr> -->
					<% } %>
					
				</table>
				</td>
				</tr>	
					
				<% } else { %>		
					<%if(arrOtherInfo!=null && arrOtherInfo.size()>0){
						for(int i=0;i<arrOtherInfo.size();i++){
						arrCol=(ArrayList)arrOtherInfo.get(i);
						
						%>
					<tr>
					<td colspan="5">
				<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable">
					<tr>
						<td><b><%=i+1 %></b></td>
						<td>* Title</td>
						<td colspan="3">* Borrower Name</td><!--
						<td>* Middle Name</td>
						<td>* Last Name(Surname)</td>
					--></tr>
					<tr>
						<td>&nbsp;Name</td>
						<td>&nbsp;<%=Helper.correctNull((String)arrCol.get(1))%></td>
						<td  colspan="3">&nbsp;<%=Helper.correctNull((String)arrCol.get(2))%></td>
					</tr>
					<tr>
						<td colspan="3">ITPAN of Chief Promoter/Individual</td>
						<td colspan="2">&nbsp;<%=Helper.correctNull((String)arrCol.get(4))%></td>

					</tr>
				</table>
				<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable">
					<tr>
						<td colspan="2" width="50%">*Gender&nbsp;</td>
						<td colspan="2" width="50%"> &nbsp;<%=Helper.correctNull((String)arrCol.get(6))%></td>

					</tr>
					<tr>
						<td colspan="2" width="50%">Mobile NO&nbsp;</td>
						<td colspan="2" width="50%"> &nbsp;<%=Helper.correctNull((String)arrCol.get(8))%></td>

					</tr>
					
					<tr>
						<td colspan="2">Date Of Birth</td>
						<td colspan="2">&nbsp;<%=Helper.correctNull((String)arrCol.get(5))%></td>

					</tr>
					<tr>
						<td colspan="2" >Social Category</td>
						<td colspan="2" >&nbsp;<%=Helper.correctNull((String)arrCol.get(11))%></td>

					</tr>
					<%-- <tr>
						<td colspan="2">Legal ID</td>
						<td colspan="2"> &nbsp;<%=Helper.correctNull((String)arrCol.get(10))%></td>

					</tr>
					<tr>
						<td colspan="2" >ID No</td>
						<td colspan="2" nowrap="nowrap">&nbsp;<%=Helper.correctNull((String)arrCol.get(7))%></td>

					</tr> --%>
					<tr>
					    <td colspan="2">Aadhaar Number</td>
					   <td colspan="2" >&nbsp;<%=Helper.correctNull((String)arrCol.get(9))%></td>
					</tr>
					<tr>
						<td colspan="2">Whether the chief Promoter/Individual belongs
						to Minority Community</td>
						<td colspan="2"> &nbsp;<%=Helper.correctNull((String)arrCol.get(12))%></td>
					</tr>
					<tr>
					    <td colspan="2">Whether the chief Promoter/Individual is physically handicapped </td>
					    <td colspan="2" >&nbsp;<%=Helper.correctNull((String)arrCol.get(10))%></td>
					</tr>
					</table>
				</td>
				</tr>
				<%}} else{ %>
				<tr>
					<td colspan="5" align="center">&nbsp; ---No Record Found---</td>
				</tr>
				<%} %>
				<%} %>
				</table>
				</div>
				</td>
			</tr>
			
			<tr>
				<td>
				<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable">
					<tr class="tblheader">	
						<td colspan="7">Other Partners/Promoters Directors details</td>
					</tr>
					<%
					if(arrGroupInfo!=null && arrGroupInfo.size()>0){ 
						for(int j=0;j<arrGroupInfo.size();j++){
						arrCol=(ArrayList)arrGroupInfo.get(j);%>
					<tr>
						<td width="3%" ><%= j+1 %></td>
						<td width="5%">Name</td>
						<td width="20%">&nbsp;<%=Helper.correctNull((String)arrCol.get(1))%></td>
						<td width="5%">ITPAN</td>
						<td width="20%">&nbsp;<%=Helper.correctNull((String)arrCol.get(3))%></td>
						<td width="9%">Date of Birth</td>
						<td width="20%">&nbsp;<%=Helper.correctNull((String)arrCol.get(2))%></td>
					</tr>
					<%} } else {  %>
					<tr>
						<td colspan="7" align="center">&nbsp; - No Record Found -</td>
					</tr>
					<%} %>
					
					
				</table>
				</div>
				</td>
			</tr>
			<tr>
				<td>
				<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable">
					<!-- <tr class="tblheader">
						<td width="70%" colspan="4"><b><u>Project Details-Outlay</u></b></td>
					
					</tr> -->
					<tr class="tblheader">
						<td width="70%" colspan="4"><b>Project Details-Outlay</b></td>
						
					</tr>
					<tr>
						<td width="80%" colspan="2">Whether unit assisted is as new unit</td>
						<td > &nbsp;<%=Helper.correctNull((String)hshValues.get("CG_NEW_UNIT"))%></td>
						
					</tr>
					<tr>
						<td colspan="2">Whether the unit is Women Operated and/or Women Owned</td>
						<td >&nbsp;<%=Helper.correctNull((String)hshValues.get("CG_NEW_UNIT_WO"))%></td>
						
					</tr>
					<tr>
					<td colspan="2">Whether the credit facility is covered under NCGTC Mudra Guarantee Program</td>
						<td>&nbsp;<%=strNcgtc%></td>
					</tr>
					<tr>
						<!-- <td>Whether the unit Assisted is an MSE as per the MSMED Act
						2020 definition of MSE</td> -->
						 <td colspan="2">Whether the Unit Assisted is an MSE as per the MSMED Act 2020</td>
						<td >&nbsp;<%=Helper.correctNull((String)hshValues.get("CG_MSE_UNIT"))%></td>
						
					</tr>
					<tr>
							<td width="60%" colspan="2">Whether the Unit Assisted is a Micro Enterprise as per the MSMED Act 2006</td>
					<td >&nbsp;<%=Helper.correctNull((String)hshValues.get("CG_MSE_UNIT_WO"))%></td>
					
					</tr>
					<tr>
						<td colspan="2">Whether first charge on Primary Securities is available</td>
						<td >&nbsp;<%=Helper.correctNull((String)hshValues.get("cg_firstcharge"))%></td>
						
					</tr>
					<tr>
						<td colspan="2">* Collateral Security Taken</td>
						<td >&nbsp;<%=Helper.correctNull((String)hshValues.get("CG_COLSEC"))%></td>
						
					</tr>
					<tr>
						<td colspan="2"># Third Party Guarantee</td>
						<td >&nbsp;<%=Helper.correctNull((String)hshValues.get("CG_THIRDPARTY"))%></td>
					</tr>
					<tr>
						<td colspan="4">* Collateral security is any other security
						offered for the said loan. For example hypothecation of jewellery
						mortgage of house etc.</td>

					</tr>
					<tr>
						<td colspan="4">#When the borrower furnishes the guarantee of
						any other person/corporate not connected with the project, it is
						considered as Third Party Guarantee.</td>

					</tr>
					<tr class="tblheader">
						<td colspan="4"><b>Joint Finance</b></td>
						
					</tr>
					<tr>
						<td colspan="2">Whether the credit is sanctioned under Joint Finance
						scheme:</td>
						<td colspan="2" >&nbsp;<%=Helper.correctNull((String)hshValues.get("CG_JOINTFINANCE"))%></td>
					</tr>
					<tr id="idCgpan">
						<td colspan="2">Joint Cgpan (Existing Cgpan of this borrower)</td>
						<td colspan="2" nowrap="nowrap">&nbsp;<%=Helper.correctNull((String)hshValues.get("CG_JFCGPAN"))%></td>
					</tr>
					<tr class="tblheader">
						<td colspan="4"><b>Handicrafts</b></td>
						
					</tr>
					<tr>
						<td colspan="2">*Whether the credit is sanctioned under Artisan Credit
						Card (ACC) scheme for Handicraft Artisans operated by
						DC(Handicrafts), Govt of India</td>
						<td colspan="2">&nbsp;<%=Helper.correctNull((String)hshValues.get("CG_ARTISAN_CC"))%></td>
					</tr>
					<tr>
						<td colspan="2">*Whether GF/ASF is re-imbursable from O/o DC
						(Handicrafts) Govt.of India</td>
						<td colspan="2">&nbsp;<%=Helper.correctNull((String)hshValues.get("CG_GF_ASF"))%></td>
					</tr>
					<tr id="idIssued">
						<td colspan="2">Details of Identity Card Number issued by DC</td>
						<td colspan="2">&nbsp;<%=Helper.correctNull((String)hshValues.get("CG_IDENTY_DC"))%></td>
					</tr>
					<tr id="idIssued2">
						<td colspan="2">Identity Card Number Issued Date</td>
						<td colspan="2">&nbsp;<%=Helper.correctNull((String)hshValues.get("CG_ISSUEDATE"))%></td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
			<tr>
				<td>
				<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable">
					<tr class="tblheader">
						<td width="80%" colspan="2"><b>Handloom</b></td>
						
					</tr>
					<tr>
						<td width="80%">Whether the credit is sanctioned under DC (Handloom) scheme for Handloom Weavers</td>
						<td >&nbsp;<%=Helper.correctNull((String)hshValues.get("CG_HANDLOOMSCHEME"))%></td>
					</tr>
				
				<%if(Helper.correctNull((String)hshValues.get("CG_HANDLOOMSCHEME")).equalsIgnoreCase("YES")) { %>
					
					<tr>
						<td width="80%">Name of the Scheme</td>
						<td >&nbsp;<%=Helper.correctNull((String)hshValues.get("CG_NAMESCHEME"))%></td>
					</tr>
					
					<tr>
						<!--<td colspan="2">[<%=Helper.correctNull((String)hshValues.get("CG_CHECKBX"))%>]We certify that the credit facility being
						covered under CGTMSE and for which reimbursement of GF/ASF in
						being availed adheres to all guidelines as issued by Office of
						DC(Handloom) from time to time for sanction of Credit under the
						respective schemes.</td>
					-->
					<td colspan="2"><input type="checkbox" name="checkBx" checked="checked">We certify that the credit facility being
						covered under CGTMSE and for which reimbursement of GF/ASF in
						being availed adheres to all guidelines as issued by Office of
						DC(Handloom) from time to time for sanction of Credit under the
						respective schemes.</td>
					
					</tr>
				<% } %>
					<tr>
						<td colspan="2">*Credit facilities above Rs.50 lakh and upto
						Rs.100 lakh will have to be rated internally by the MLI and should
						be of investment grade.For loan facility upto Rs.50 lakhs MLIs may
						indicate 'N.A.' if rating is not available.</td>

					</tr>
					<tr>
						
						<td >* Internal Rating</td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("CG_INTERNAL_RATING"))%></td>
						</tr>
					<%if(Helper.correctNull((String)hshValues.get("CG_INTERNAL_RATING")).equalsIgnoreCase("YES")) { %>	
						<tr>
						<td>Rating of the borrower:</td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("cre_weight"))%></td>
						</tr>
					<% } %>
				</table>
				</div>
				</td>
			</tr>
		<!--  	<tr>
				<td>
				<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable">
					<tr class="tblheader">
						<td colspan="3"><b><u>Guarantors</u></b></td>

					</tr>
					<tr>
						<td colspan="2" align="center" width="50%">Name</td>

						<td nowrap="nowrap">Net worth (as on date of Sanction of facility (<img src="<%=ApplicationParams.getAppUrl()%>img/INRsymbol.png" height="12px">)</td>
					</tr>
					
					<%
					if(arrGurdetails!=null&&arrGurdetails.size()>0)
					{
						arrayCol=new ArrayList();
						for(int j=0;j<arrGurdetails.size();j++)
						{
							arrayCol=(ArrayList)arrGurdetails.get(j);
					%>
					<tr>
						<td width="5%" ><%= j+1 %></td>
						<td><%=Helper.correctNull((String)arrayCol.get(0))%></td>
						<td nowrap="nowrap"><%=Helper.correctNull((String)arrayCol.get(1))%></td>
					</tr>
					 <%	} } else {	%>
					<tr>
					<td colspan="3" align="center"> - Nil -</td>
					</tr>
					<%} %>
					 
				</table>
				</div>
				</td>
			</tr> -->
		<!--  <tr>
				<td><b><span style="float: left;">&nbsp;&nbsp;Primary Security Details:</span></b></td>
			</tr> -->	
			
			
			
			<!--  <tr>
				<td>
				<div id="top">
				
				<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable">
					<tr class="tblheader">
						<td><b>Security Name</b></td>
						<td><b>Particulars</b></td>
						<td><b>Value (<img src="<%=ApplicationParams.getAppUrl()%>img/INRsymbol.png" height="12px">)</b></td>
					</tr>
					
					<tr>
						<td class="tblheader"  width="30%"  colspan="3">Land</td>
					</tr>
					<%
					if(arrAppSec_LandRow!=null&&arrAppSec_LandRow.size()>0)
					{
						arrayCol=new ArrayList();
						for(int j=0;j<arrAppSec_LandRow.size();j++)
						{
							arrAppSec_tempcol=(ArrayList)arrAppSec_LandRow.get(j);
							totalsec=totalsec + Double.parseDouble(Helper.correctDouble((String)arrAppSec_tempcol.get(2)));
					%>
					<tr>
						<td><%=Helper.correctNull((String)arrAppSec_tempcol.get(0))%></td>
						<td><%=Helper.correctNull((String)arrAppSec_tempcol.get(1))%></td>
						<td align="right"><%=Helper.correctNull((String)arrAppSec_tempcol.get(2))%></td>
					</tr>
					 <%	} } else {	%>
					<tr>
						<td colspan="3" align="center"> - Nil -</td>
					</tr>
					<%} %>
					
					<tr>
						<td class="tblheader"  width="30%"  colspan="3">Building</td>
					</tr>
					<%
					if(arrAppSec_BuildRow!=null&&arrAppSec_BuildRow.size()>0)
					{
						arrayCol=new ArrayList();
						for(int j=0;j<arrAppSec_BuildRow.size();j++)
						{
							arrAppSec_tempcol=(ArrayList)arrAppSec_BuildRow.get(j);
							totalsec=totalsec + Double.parseDouble(Helper.correctDouble((String)arrAppSec_tempcol.get(2)));
					%>
					<tr>
						<td><%=Helper.correctNull((String)arrAppSec_tempcol.get(0))%></td>
						<td><%=Helper.correctNull((String)arrAppSec_tempcol.get(1))%></td>
						<td align="right"><%=Helper.correctNull((String)arrAppSec_tempcol.get(2))%></td>
					</tr>
					 <%	} } else {	%>
					<tr>
						<td colspan="3" align="center"> - Nil -</td>
					</tr>
					<%} %>
					
					<tr>
						<td class="tblheader"  width="30%"  colspan="3">Plant & Machinery</td>
					</tr>
					<%
					if(arrAppSec_plantmachRow!=null&&arrAppSec_plantmachRow.size()>0)
					{
						arrayCol=new ArrayList();
						for(int j=0;j<arrAppSec_plantmachRow.size();j++)
						{
							arrAppSec_tempcol=(ArrayList)arrAppSec_plantmachRow.get(j);
							totalsec=totalsec + Double.parseDouble(Helper.correctDouble((String)arrAppSec_tempcol.get(2)));
					%>
					<tr>
						<td><%=Helper.correctNull((String)arrAppSec_tempcol.get(0))%></td>
						<td><%=Helper.correctNull((String)arrAppSec_tempcol.get(1))%></td>
						<td align="right"><%=Helper.correctNull((String)arrAppSec_tempcol.get(2))%></td>
					</tr>
					 <%	} } else {	%>
					<tr>
						<td colspan="3" align="center"> - Nil -</td>
					</tr>
					<%} %>
					
					
					<tr>
						<td class="tblheader"  width="30%"  colspan="3">Other Fixed/ Movable Assets</td>
					</tr>
					<%
					if(arrAppSec_vehicleFurRow!=null&&arrAppSec_vehicleFurRow.size()>0)
					{
						arrayCol=new ArrayList();
						for(int j=0;j<arrAppSec_vehicleFurRow.size();j++)
						{
							arrAppSec_tempcol=(ArrayList)arrAppSec_vehicleFurRow.get(j);
							totalsec=totalsec + Double.parseDouble(Helper.correctDouble((String)arrAppSec_tempcol.get(2)));
					%>
					<tr>
						<td><%=Helper.correctNull((String)arrAppSec_tempcol.get(0))%></td>
						<td><%=Helper.correctNull((String)arrAppSec_tempcol.get(1))%></td>
						<td align="right" nowrap="nowrap"><%=Helper.correctNull((String)arrAppSec_tempcol.get(2))%></td>
					</tr>
					 <%	} } else {	%>
					<tr>
						<td colspan="3" align="center"> - Nil -</td>
					</tr>
					<%} %>
					
					<tr>
						<td class="tblheader"  width="30%"  colspan="3">Current Assets</td>
					</tr>
					<%
					if(arrAppSec_stockbookRow!=null&&arrAppSec_stockbookRow.size()>0)
					{
						arrayCol=new ArrayList();
						for(int j=0;j<arrAppSec_stockbookRow.size();j++)
						{
							arrAppSec_tempcol=(ArrayList)arrAppSec_stockbookRow.get(j);
							totalsec=totalsec + Double.parseDouble(Helper.correctDouble((String)arrAppSec_tempcol.get(2)));
					%>
					<tr>
						<td><%=Helper.correctNull((String)arrAppSec_tempcol.get(0))%></td>
						<td><%=Helper.correctNull((String)arrAppSec_tempcol.get(1))%></td>
						<td align="right"><%=Helper.correctNull((String)arrAppSec_tempcol.get(2))%></td>
					</tr>
					 <%	} } else {	%>
					<tr>
						<td colspan="3" align="center"> - Nil -</td>
					</tr>
					<%} %>
					
					
					<tr>
						<td class="tblheader"  width="30%"  colspan="3">Others</td>
					</tr>
					<%
					if(arrAppSec_othersRow!=null&&arrAppSec_othersRow.size()>0)
					{
						arrayCol=new ArrayList();
						for(int j=0;j<arrAppSec_othersRow.size();j++)
						{
							arrAppSec_tempcol=(ArrayList)arrAppSec_othersRow.get(j);
							totalsec=totalsec + Double.parseDouble(Helper.correctDouble((String)arrAppSec_tempcol.get(2)));
					%>
					<tr>
						<td><%=Helper.correctNull((String)arrAppSec_tempcol.get(0))%></td>
						<td><%=Helper.correctNull((String)arrAppSec_tempcol.get(1))%></td>
						<td align="right" nowrap="nowrap"><%=Helper.correctNull((String)arrAppSec_tempcol.get(2))%></td>
					</tr>
					 <%	} } else {	%>
					<tr>
						<td colspan="3" align="center"> - Nil -</td>
					</tr>
					<%} %>
					
					<tr>
						<td align="center"><b>Total</b></td>
						<td colspan="2" align="right" nowrap="nowrap">&nbsp;<%= Math.round(totalsec) %></td>
					</tr>
				</table>
				</div>
				</td>
			</tr> -->
			<tr id="WCMF">
				<td>
				<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable">
					<tr class="tblheader">
						<td colspan="2" width="40%"><b>Means of Finance</b></td>
						</tr>
					<tr>
						<td colspan="2">*Working Capital Limit Sanctioned</td>
						</tr>
						
					<tr>
						<td  colspan="2">Fund Based limit in Rs. :&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("LOAN_RECMDAMT"))))%></td>
									</tr>
					<tr>
						<td  colspan="2">Non Fund based in Rs. :&nbsp;<!-- <%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("LOAN_RECMDAMT"))))%>  --> Nil</td>
					
					</tr>
					<tr>
						<td>Whether provided As margin money Term Loan&nbsp;</td>
						<td><%=Helper.correctNull((String)hshValues.get("CG_TL_MARGIN_MONEY"))%></td>
					</tr>
					<tr>
						<td width="25%"></td>
						<td align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/INRsymbol.png" height="12px"></td>
					</tr>
					<tr>
						<td>WC Promoters Contribution</td>
						<td nowrap="nowrap">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("CG_TC_PROMOTERS"))))%></td>
						</tr>
					<tr>
						<td>WC Subsidy/Equity Support</td>
						<td nowrap="nowrap">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("CG_TC_SUBSIDY"))))%></td>
						</tr>
					<tr>
						<td>WC Others</td>
						<td nowrap="nowrap">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("CG_TC_OTHERS"))))%></td>
						</tr>
				<!--	<tr>
						<td>Working Capital Assessed</td>
						<td nowrap="nowrap">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("CG_WC_ASSESSED"))))%></td>
						</tr>   -->
									
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						</tr>

				</table>
				</div>
				</td>
			</tr>
			
			<tr id="TLMF">
				<td>
				<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable">
					<tr class="tblheader">
						<td colspan="2" width="40%"><b>Means of Finance</b></td>
						</tr>
					<tr>
						<td colspan="2">* Term/DPN Loan Sanctioned</td>
						</tr>
					<tr>
						<td  colspan="2">Loan amount Rs. :&nbsp;<%=Helper.correctNull((String)hshValues.get("LOAN_RECMDAMT"))%></td>
						</tr>
					
					<tr>
						<td width="25%"></td>
						<td align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/INRsymbol.png" height="12px"></td>
					</tr>
					<tr>
						<td>TM Promoters Contribution</td>
						<td nowrap="nowrap">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("CG_TC_PROMOTERS"))))%></td>
						</tr>
					<tr>
						<td>TM Subsidy/Equity Support</td>
						<td nowrap="nowrap">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("CG_TC_SUBSIDY"))))%></td>
						</tr>
					<tr>
						<td>TM Others</td>
						<td nowrap="nowrap">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("CG_TC_OTHERS"))))%></td>
						</tr>
			        <%-- <tr>
						<td>Project Cost</td>
						<td nowrap="nowrap">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("CG_TC_PROJ_COST"))))%></td>
						</tr>
					<tr>
						<td>Project Outlay</td>
						<td nowrap="nowrap">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("CG_TC_PROJ_OUTLAY"))))%></td>
						</tr>	
 --%>
				</table>
				</div>
				</td>
			</tr>
			
			<tr id="TLDet">
				<td>
				<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable">
					<tr class="tblheader">
						<td colspan="4"><b>Term Loan Details</b></td>

					</tr>
					<tr>
						<td width="20%"></td>
						<td align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/INRsymbol.png" height="12px"></td>
						<td width="20%"></td>
						<td></td>
					</tr>
					<%--  <tr>
						<td >Amount Sanctioned</td>
						<td width="30%" nowrap="nowrap">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("LOAN_RECMDAMT"))))%></td>
						<td>* Date of sanction</td>
						<td> &nbsp;<%=Helper.correctNull((String)hshValues.get("APP_PROCESSDATE"))%></td>
					</tr>
					<tr>
						<td>*Credit amount to be Guaranteed</td>
						<td nowrap="nowrap">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("TXNDET_CRDT_AMT"))))%></td>
						<td>Date of first disbursement if already made </td>
						<td > &nbsp;<%=Helper.correctNull((String)hshValues.get("TXNDET_DT_FST_DISB"))%></td>
					</tr>
					<tr>
						<td>Amount Disbursed </td>
						<td nowrap="nowrap"> &nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("TXNDET_AMT_DISBURSED"))))%></td>
						<td>Date of last and final disbursement if already made</td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("TXNDET_DT_LST_DISB"))%></td>
					</tr> --%> 
					 <tr>
						<td >Amount Sanctioned</td>
						<td width="30%" nowrap="nowrap">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("LOAN_RECMDAMT"))))%></td>
						<td>* Date of sanction</td>
						<td> &nbsp;<%=Helper.correctNull((String)hshValues.get("APP_PROCESSDATE"))%></td>
					</tr>
					<tr>
						<td>TC Interest type</td>
						<%-- <td nowrap="nowrap">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("LOAN_INTTYPE"))))%></td> --%>
						<td nowrap="nowrap">&nbsp;<%=Helper.correctNull((String)hshValues.get("LOAN_INTTYPE"))%></td> 
						<td>Loan Termination date </td>
						<td > &nbsp;<%=Helper.correctNull((String)hshValues.get("APP_PROCESSDATE"))%></td>
					</tr>
					<tr>
						<td>TC Base Rate </td>
						<td nowrap="nowrap"> &nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("mclr_baseratespread"))))%></td>
						<td>TC Amount Disbursed (in Rs.)</td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("TXNDET_AMT_DISBURSED"))%></td>
					</tr>
                     <tr>
						<td>TC Interest Rate </td>
						<td nowrap="nowrap"> &nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("LOAN_INTRATE"))))%></td>
						<td>TC Date of first disbursement if already made</td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("TXNDET_DT_FST_DISB"))%></td>
					</tr>
                    <tr>
						<td>* Credit amount to be Guaranteed (in Rs.)  </td>
						<td nowrap="nowrap"> &nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("TXNDET_CRDT_AMT"))))%></td>
						<td>TC Date of last and final disbursement if already made</td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("TXNDET_DT_LST_DISB"))%></td>
					</tr> 
					<tr class="tblheader">
						<td colspan="4" width="90%"><b>Repayment Schedule</b></td>

					</tr>
					<tr>
						<td  colspan="2"width="30%">Moratorium (Holiday Period) in
						Months)</td>
						<td colspan="2"> &nbsp;<%=Helper.correctNull((String)hshValues.get("LOAN_NOOFINSTALLMENT"))%></td>
					</tr>
					<!-- 5th -->
					<tr>
						<td  colspan="2">First installment due date</td>
						<td  colspan="2">&nbsp;<%=Helper.correctNull((String)hshValues.get("TXNDET_FST_INS_DUE_DT"))%></td>
					</tr>
					<tr>
						<td  colspan="2">Periodicity (Monthly, Quarterly, Half-Yearly)</td>
						<td  colspan="2"> &nbsp;<%=Helper.correctNull((String)hshValues.get("LOAN_PERIODICITY"))%></td>
					</tr>
					<tr>
						<td  colspan="2">*No of instalments</td>
						<td  colspan="2">&nbsp;<%=Helper.correctNull((String)hshValues.get("loan_noofinstall"))%></td>
					</tr>
					<tr>
						<td  colspan="2">Outstanding Amount (<img src="<%=ApplicationParams.getAppUrl()%>img/INRsymbol.png" height="12px">) as on&nbsp;<%=Helper.correctNull((String)hshValues.get("TXNDET_OUTS_BAL_DT"))%></td>
						<td  colspan="2">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("TXNDET_OUTS_BAL_AMT"))))%></td>
					</tr>
					</table>
				</div>
				</td>
			</tr>

			<%-- <tr>
				<td>
				<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable">
					<tr>
						<td colspan="2" width="50%">Loan Account No (16 digits)</td>
						<td colspan="2" nowrap="nowrap">&nbsp;<%=Helper.correctNull((String)hshValues.get("CBS_ACCOUNTNO"))%></td>

					</tr>
					<tr>
						<td colspan="2">*Tenure (Period of loan) (in Months)</td>
						<td colspan="2" nowrap="nowrap"> &nbsp;<%=Helper.correctNull((String)hshValues.get("LOAN_REQTERMS"))%></td>

					</tr>
					<tr>
						<td  colspan="2">LAPS Application No</td>
						<td colspan="2" nowrap="nowrap"> &nbsp;<%=Helper.correctNull((String)hshValues.get("APP_NO"))%></td>

					</tr>
					<tr>
						<td colspan="2" >LAPS Borrower ID</td>
						<td colspan="2" nowrap="nowrap">&nbsp;<%=Helper.correctNull((String)hshValues.get("PERAPP_CBSID"))%> </td>

					</tr>
					<tr>
						<td colspan="2">Loan Due date in Finacle</td>
						<td colspan="2">&nbsp;<%=Helper.correctNull((String)hshValues.get("LOAN_DUEDATE"))%></td>

					</tr>
					<tr>
						<td >MCLR/EBLR</td>
						<td nowrap="nowrap">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("mclr_baseratespread"))))%>% (p.a.)</td>
						<td>* Interest rate</td>
						<td nowrap="nowrap">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("LOAN_MODINTRATE"))))%>% (p.a.)</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
 --%>
			<%-- <tr id="wcdtcgt1">
				<td>
				<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable" >
					<tr class="tblheader">
						<td colspan="2" width="70%"><b>Repayment Schedule</b></td>

					</tr>
					<tr>
						<td width="40%" >Moratorium (Holiday Period) in
						Months)</td>
						<td> &nbsp;<%=Helper.correctNull((String)hshValues.get("LOAN_NOOFINSTALLMENT"))%></td>
					</tr>
					<!-- 5th -->
					<tr>
						<td>First installment due date</td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("TXNDET_FST_INS_DUE_DT"))%></td>
					</tr>
					<tr>
						<td >Periodicity (Monthly, Quarterly, Half-Yearly)</td>
						<td> &nbsp;<%=Helper.correctNull((String)hshValues.get("LOAN_PERIODICITY"))%></td>
					</tr>
					<tr>
						<td>*No of instalments</td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("loan_noofinstall"))%></td>
					</tr>
					<tr>
						<td>Outstanding Amount (<img src="<%=ApplicationParams.getAppUrl()%>img/INRsymbol.png" height="12px">) as on&nbsp;<%=Helper.correctNull((String)hshValues.get("TXNDET_OUTS_BAL_DT"))%></td>
						<td nowrap="nowrap">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("TXNDET_OUTS_BAL_AMT"))))%></td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
 --%>			<%-- <tr id="WCDet2" >
				<td>
				<div id="top">
					<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable">
					<tr class="tblheader">
						<td colspan="2" ><b>Working Capital :</b></td>

					</tr>
					<tr>
						<td width="50%">*MCLR/EBLR</td>
						<td>&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("mclr_baseratespread"))))%>% (p.a.)</td>
					</tr>
					<tr>
						<td >Limit Sanctioned</td>
						<td> &nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("LOAN_RECMDAMT"))))%></td>
					</tr>
					<%if(Helper.correctNull((String)hshValues.get("Facilitytype")).equalsIgnoreCase("F")){%>
					<tr class="tblheader">
						<td>Fund Based</td>
						<td></td>
					</tr>
					<tr>
						<td >Date of Sanction</td>
						<td> &nbsp;<%=Helper.correctNull((String)hshValues.get("APP_PROCESSDATE"))%></td>
					</tr>
					<tr>
						<td>* Interest rate</td>
						<td>&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("LOAN_MODINTRATE"))))%>% (p.a.)</td>
					</tr>
					<%}else{ %>
					<tr class="tblheader">
						<td colspan="2"><b>Non Fund Based</b></td>
					</tr>
					<tr>
						<td width="50%">Commission</td>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;% (p.a.)</td>
					</tr>
					<tr>
						<td >Date of sanction</td>
						<td> &nbsp;<%=Helper.correctNull((String)hshValues.get("APP_PROCESSDATE"))%></td>
					</tr>
					<%} %>
					<!--<tr>
						<td>Loan account a/c No.(16 digits)</td>
						<td><%=Helper.correctNull((String)hshValues.get("CBS_ACCOUNTNO")) %>&nbsp;</td>
					</tr>
				--></table>
				</td>			
			</tr> --%>
			<tr id="WCDet2" >
				<td>
				<div id="top">
					<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable">
					<!-- <tr class="tblheader">
						<td colspan="2" ><b>Working Capital :</b></td>

					</tr> -->
					<tr class="tblheader">
						<td colspan="4"><b>Working Capital :</b></td>
					</tr>
					<%-- <tr>
						<td width="50%">*MCLR/EBLR</td>
						<% if(Helper.correctNull((String)hshValues.get("FACILITY_INTSUBTYPE")).equals("MCLR") || Helper.correctNull((String)hshValues.get("FACILITY_INTSUBTYPE")).equals("EBLEC") || Helper.correctNull((String)hshValues.get("FACILITY_INTSUBTYPE")).equals("EBLR")) { %>
							<td>&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("mclr_baseratespread"))))%>% (p.a.)</td>
						<%} else { %>
							<td>&nbsp; Not Applicable </td>
						<%} %>
					</tr> --%>
					<%-- <tr>
						<td >Limit Sanctioned</td>
						<td> &nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("FACILITY_SANCAMT"))))%></td>
					</tr> --%>
					
					<tr>
						<td >WC Interest Type</td>
						<td colspan="3"> &nbsp;<%=Helper.correctNull((String)hshValues.get("LOAN_INTTYPE"))%></td>
					</tr> 
					 <tr>
						<td >WC Base Rate</td>
						<td colspan="3"> &nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("mclr_baseratespread"))))%></td>
					</tr>
					 <tr>
						<td > WC amount disbursed</td>
						<td colspan="3"> &nbsp;<%=Helper.correctNull((String)hshValues.get("TXNDET_AMT_DISBURSEDWC"))%></td>
					</tr>
					 <tr>
						<td >WC Date of first disbursement if already made</td>
						<td colspan="3"> &nbsp;<%=Helper.correctNull((String)hshValues.get("TXNDET_DT_FST_DISBWC"))%></td>
					</tr>
					 <tr>
						<td > WC Date of last and final disbursement if already made</td>
						<td colspan="3"> &nbsp;<%=Helper.correctNull((String)hshValues.get("TXNDET_DT_LST_DISBWC"))%></td>
					</tr>
					<%if(Helper.correctNull((String)hshValues.get("Facilitytype")).equalsIgnoreCase("F")){%>
					<tr >
						<td>Fund Based</td>
						<td colspan="4"></td>
					</tr>
					<tr>
						<td>* Fund Based Interest rate</td>
						<td colspan="3">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("LOAN_INTRATE"))))%>% (p.a.)</td>
					</tr>
					<tr>
						<td >Fund Based Date of sanction</td>
						<td colspan="3"> &nbsp;<%=Helper.correctNull((String)hshValues.get("APP_PROCESSDATE"))%></td>
					</tr>
					<tr>
						<td width="35%">Credit amount to be guaranteed Fund based (<img src="<%=ApplicationParams.getAppUrl()%>img/INRsymbol.png" height="12px">)</td>
						<td colspan="3"> &nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("TXNDET_CRDT_FUNDBASED"))))%></td>

					</tr>
					<tr>
						<td> Outstanding Amount fund Based as on  date (<img src="<%=ApplicationParams.getAppUrl()%>img/INRsymbol.png" height="12px">)</td>
						<td width="20%">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("TXNDET_OUTSTD_FUND"))))%></td>
						<td width="20%">As on</td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("TXNDET_OUTFB_DT"))%></td>
					</tr>
					<%}else{ %>
					<tr >
						<td colspan="4"><b>Non Fund Based</b></td>
					</tr>
					<tr>
						<td>Non Fund Based Interest rate</td>
						<td colspan="3">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("LOAN_INTRATE"))))%>% (p.a.)</td>
					</tr>
					<tr>
						<td width="50%"> Non Fund Based Commission rate</td>
						<td colspan="3">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("LOAN_INTRATE"))))%>% (p.a.)</td>
					</tr>
					<tr>
						<td >Non Fund Based Date of sanction</td>
						<td colspan="3"> &nbsp;<%=Helper.correctNull((String)hshValues.get("APP_PROCESSDATE"))%></td>
					</tr>
					<tr>
						<td>Credit amount to be guaranteed Non Fund based (<img src="<%=ApplicationParams.getAppUrl()%>img/INRsymbol.png" height="12px">)</td>
						<td colspan="3">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("TXNDET_CRDT_NONFUNDBASED"))))%></td>

					</tr>
					<tr>
						<td>Outstanding Amount Non Fund Based as on date (<img src="<%=ApplicationParams.getAppUrl()%>img/INRsymbol.png" height="12px">)</td>
						<td width="20%">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("TXNDET_OUTSTD_NONFUND"))))%></td>
						<td width="20%">As on</td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("TXNDET_OUTNFB_DT"))%></td>
					</tr>
					<%} %>
					
				</table>
				</td>			
			</tr>
			<%if(facLoanType.equalsIgnoreCase("Enhancement in WC")){%>
			<tr id="WCDet3" >
				<td>
				<div id="top">
					<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable">
					<tr class="tblheader">
						<td colspan="2" ><b>Working Capital Enhancement Details :</b></td>
					</tr>	
                     <tr>
						<td >WCE Interest type</td>
						<td> &nbsp;<%=Helper.correctNull((String)hshValues.get("LOAN_INTTYPE"))%></td>
					 </tr>
					 <tr>
						<td >WCE Fund Based Interest</td>
						<td> &nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("LOAN_INTRATE"))))%></td>
					 </tr>
					 <tr>
						<td >WCE Non Fund Based Commission</td>
						<td> &nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("LOAN_INTRATE"))))%></td>
					 </tr>
					 <tr>
						<td >WCE date of enhancement</td>
						<td> &nbsp;<%=Helper.correctNull((String)hshValues.get("MONDATE"))%></td>
					 </tr>
					 <tr>
						<td >WCE spread over PLR</td>
						<td> &nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("FACILITY_SANCAMT"))))%></td>
					 </tr>
					 <tr>
						<td >WCE Tangible Networth</td>
						<td> &nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("FACILITY_SANCAMT"))))%></td>
					 </tr>
					 <tr>
						<td >WCE Fixed Asset coverage Ratio</td>
						<td> &nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("FACILITY_SANCAMT"))))%></td>
					 </tr>
					 <tr>
						<td >WCE Current Ratio</td>
						<td> &nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("FACILITY_SANCAMT"))))%></td>
					 </tr>
					 <tr>
						<td >WCE Minimum DSCR</td>
						<td> &nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("FACILITY_SANCAMT"))))%></td>
					 </tr>
					 <tr>
						<td >WCE Average DSCR</td>
						<td> &nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("FACILITY_SANCAMT"))))%></td>
					 </tr>
                    </table>
					
					</td>
			</tr> <%} %>
				<%if(facLoanType.equalsIgnoreCase("Enhancement in WC")){%>
			 <tr id="WCDet4" >
			<td>
			<div id="top">
					<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable">
					<tr class="tblheader">
						<td colspan="2" ><b>Working Capital Renewal of Cover Details :</b></td>
					</tr>	
                     
					 <tr>
						<td >WCR Interest type</td>
						<td> &nbsp;<%=Helper.correctNull((String)hshValues.get("LOAN_INTTYPE"))%></td>
					 </tr>
					 <tr>
						<td >WCR Fund Based Interest</td>
						<td> &nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("LOAN_INTRATE"))))%></td>
					 </tr>
					 <tr>
						<td >WCR Non Fund Based Commission</td>
						<td> &nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("LOAN_INTRATE"))))%></td>
					 </tr>
					 <tr>
						<td >WCR date of renewal</td>
						<td> &nbsp;<%=Helper.correctNull((String)hshValues.get("MONDATE"))%></td>
					 </tr>
					 <tr>
						<td >WCR spread over PLR</td>
						<td> &nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("FACILITY_SANCAMT"))))%></td>
					 </tr>
					 <tr>
						<td >WCR whether repayment in equal installments</td>
						<td> &nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("FACILITY_SANCAMT"))))%></td>
					 </tr>
					 <tr>
						<td >WCR Tangible Networth</td>
						<td> &nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("FACILITY_SANCAMT"))))%></td>
					 </tr>
					 <tr>
						<td >WCR Fixed Asset coverage Ratio</td>
						<td> &nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("FACILITY_SANCAMT"))))%></td>
					 </tr>
					 <tr>
						<td >WCR Current Ratio</td>
						<td> &nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("FACILITY_SANCAMT"))))%></td>
					 </tr>
					 <tr>
						<td >WCR Minimum DSCR</td>
						<td> &nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("FACILITY_SANCAMT"))))%></td>
					 </tr>
					 <tr>
						<td >WCR Average DSCR</td>
						<td> &nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("FACILITY_SANCAMT"))))%></td>
					 </tr>
                   </table>
					
				</td>
			</tr> <%} %>
			<%--<tr>
			<tr id="WCDet">
			 <td>
			<div id="top">
			<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable">
					<tr >
						<td colspan="4"><b>Credit to be Guaranteed</b></td>

					</tr>
					<tr>
						<td width="35%">Fund Based (<img src="<%=ApplicationParams.getAppUrl()%>img/INRsymbol.png" height="12px">)</td>
						<td colspan="3"> &nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("TXNDET_CRDT_FUNDBASED"))))%></td>

					</tr>
					<tr>
						<td>Non Fund Based (<img src="<%=ApplicationParams.getAppUrl()%>img/INRsymbol.png" height="12px">)</td>
						<td colspan="3">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("TXNDET_CRDT_NONFUNDBASED"))))%></td>

					</tr>
					<tr>
						<td colspan="4"><b>Outstanding Fund Based Facility</b></td>

					</tr>
					<tr>
						<td>Amount (<img src="<%=ApplicationParams.getAppUrl()%>img/INRsymbol.png" height="12px">)</td>
						<td width="20%">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("TXNDET_OUTSTD_FUND"))))%></td>
						<td width="20%">As on</td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("TXNDET_OUTFB_DT"))%></td>
					</tr>
					<tr>
						<td colspan="4"><b>Outstanding Non Fund Based Facility</b></td>

					</tr>
					<tr>
						<td>Amount (<img src="<%=ApplicationParams.getAppUrl()%>img/INRsymbol.png" height="12px">)</td>
						<td width="20%">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("TXNDET_OUTSTD_NONFUND"))))%></td>
						<td width="20%">As on</td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("TXNDET_OUTNFB_DT"))%></td>
					</tr>
				</table>
			
			</td>
			</tr> --%>
			
		  <%
		 int q=0,t=0;
		  for(int s=0;s<intSection_count;s++)
			{ 
			if(s==0)
			{p=0;t=5;
			if(sizeyearval<5)
				t=sizeyearval;
			}
			if (g2.size() >0){
		 %>
		<%if(!tempyear.equalsIgnoreCase("")){ %> 
		 <tr><td colspan="4" align="left"><b>Financial Data Report</b></td></tr>
			<tr><td colspan="4">
			<table width="100%" border="1" cellspacing="0" cellpadding="4"
	align="center">
	<tr>
		<td align="center" width="25%" align="center" colspan="4"><b>Particular</b></td>
		<td align="center" width="30%" colspan="14"><b>Input</b></td>
	</tr>
	         <%if(tempyear.equalsIgnoreCase("1")){%>
		            <tr> 
                        <td colspan="4" >&nbsp; </td>
                        <td width="15%" align="center" colspan=14"> <b><%=yearval[0]%></b>&nbsp;</td>
                      </tr>
	                <tr> 
                        <td colspan="4" >&nbsp; </td>
                        <td width="15%" align="center" colspan="14"><%=comboselect[0]%>&nbsp;</td>    	
                      </tr>
              <%}if(tempyear.equalsIgnoreCase("2")){%>
                       <tr> 
                         <td colspan="4" >&nbsp; </td>
                         <td width="15%" align="center" colspan="3"> <b><%=yearval[0]%></b>&nbsp;</td>
                         <td width="15%" align="center" colspan="3"> <b><%=yearval[1]%></b>&nbsp;</td>
                      </tr>
	                  <tr> 
                        <td colspan="4" >&nbsp; </td>
                        <td width="15%" align="center" colspan="3"><%=comboselect[0]%>&nbsp;</td>  
                        <td width="15%" align="center" colspan="3"><%=comboselect[1]%>&nbsp;</td>    	
                      </tr>
               <%}if(tempyear.equalsIgnoreCase("3")){%>
                      <tr> 
                      <td colspan="4" >&nbsp; </td>
                      <td width="15%" align="center" colspan="3"> <b><%=yearval[0]%></b>&nbsp;</td>
                      <td width="15%" align="center" colspan="3"> <b><%=yearval[1]%></b>&nbsp;</td>
                      <td width="15%" align="center" colspan="3"> <b><%=yearval[2]%></b>&nbsp;</td>    
                    </tr>
	              <tr> 
                      <td colspan="4" >&nbsp; </td>
                      <td width="15%" align="center" colspan="3"><%=comboselect[0]%>&nbsp;</td>  
                      <td width="15%" align="center" colspan="3"><%=comboselect[1]%>&nbsp;</td>  
                      <td width="15%" align="center" colspan="3"><%=comboselect[2]%>&nbsp;</td>    	
                    </tr>
               <%}if(tempyear.equalsIgnoreCase("4")){%>
                      <tr> 
                      <td colspan="4" >&nbsp; </td>
                      <td width="15%" align="center" colspan="3"> <b><%=yearval[0]%></b>&nbsp;</td>
                      <td width="15%" align="center" colspan="3"> <b><%=yearval[1]%></b>&nbsp;</td>
                      <td width="15%" align="center" colspan="3"> <b><%=yearval[2]%></b>&nbsp;</td>
                      <td width="15%" align="center" colspan="3"> <b><%=yearval[3]%></b>&nbsp;</td>
                      </tr>
	                <tr> 
                      <td colspan="4" >&nbsp; </td>
                      <td width="15%" align="center" colspan="3"><%=comboselect[0]%>&nbsp;</td>  
                      <td width="15%" align="center" colspan="3"><%=comboselect[1]%>&nbsp;</td>  
                      <td width="15%" align="center" colspan="3"><%=comboselect[2]%>&nbsp;</td>    	
                      <td width="15%" align="center" colspan="3"><%=comboselect[3]%>&nbsp;</td>    	
                    </tr>
                <%} if(tempyear.equalsIgnoreCase("5")){%>
                      <tr> 
                      <td colspan="4" >&nbsp; </td>
                      <td width="15%" align="center" colspan="3"> <b><%=yearval[0]%></b>&nbsp;</td>
                      <td width="15%" align="center" colspan="3"> <b><%=yearval[1]%></b>&nbsp;</td>
                      <td width="15%" align="center" colspan="3"> <b><%=yearval[2]%></b>&nbsp;</td>
                      <td width="15%" align="center" colspan="3"> <b><%=yearval[3]%></b>&nbsp;</td>
                      <td width="15%" align="center" colspan="3"> <b><%=yearval[4]%></b>&nbsp;</td>
                   </tr>
	               <tr> 
                      <td colspan="4" >&nbsp; </td>
                      <td width="15%" align="center" colspan="3"><%=comboselect[0]%>&nbsp;</td>  
                      <td width="15%" align="center" colspan="3"><%=comboselect[1]%>&nbsp;</td>  
                      <td width="15%" align="center" colspan="3"><%=comboselect[2]%>&nbsp;</td>    	
                      <td width="15%" align="center" colspan="3"><%=comboselect[3]%>&nbsp;</td>  
                      <td width="15%" align="center" colspan="3"><%=comboselect[4]%>&nbsp;</td>    	
                    </tr>
                  <%} %>
                    
                    <%
					ArrayList v = (ArrayList) hshVal.get("labeldetails");
                    
				   int z=0;
				   String col1 = "", col2 = "", col3 = "", col4 = "", col5 = "";
					String  colval1 = "";
					String colval2 = "", colval3 = "", colval4 = "", colval5 = "", strtype = "", selectdesc = "";
					int vecsize = 0,  yearsize = 0, finsize = 0, startsize = 0;
					String colid = "", rowid = "";
	    	if (v != null) {
				vecsize = v.size();
			}
			if (year1 != null) {
				yearsize = year1.size();
			}
			if (yearsize == vecsize) {
				finsize = vecsize;
			} else if (yearsize < vecsize) {
				finsize = yearsize;
			}
			if (finsize == 0) {
				finsize = vecsize;
			}
			   
				for(int l=0;l<VecRow.size();l++)
				{
					VecCol=(ArrayList)VecRow.get(l);
			    %>
			     <tr>
			     
			     <td colspan="4"><%=VecCol.get(1) %></td>
		  
		<%
			
				g1 = (ArrayList) v.get(l);
				colid = Helper.correctNull((String) g1.get(0));
				colid = colid.trim();
				
				if (year1 != null) {
					rowid = Helper.correctDouble(Helper.correctDouble((String) vecid1.get(l)));
					
					if (rowid.equals(colid)) {
						colval1 = Helper.correctDouble(Helper.correctDouble((String) year1.get(l)));
					} else {
						colval1 = "0.00";
					}
				} else {
					colval1 = "0.00";
				}
				if (year2 != null) {
					rowid = Helper.correctDouble(Helper.correctDouble((String) vecid2.get(l)));
					
					if (rowid.equals(colid)) {
						colval2 = Helper.correctDouble(Helper.correctDouble((String) year2.get(l)));
					} else {
						colval2 = "0.00";
					}
				} else {
					colval2 = "0.00";
				}
				if (year3 != null) {
					rowid = Helper.correctDouble((String) vecid3.get(l));
					if (rowid.equals(colid)) {
						colval3 = Helper.correctDouble((String) year3.get(l));
					} else {
						colval3 = "0.00";
					}
				} else {
					colval3 = "0.00";
				}
				if (year4 != null) {
					rowid = Helper.correctDouble((String) vecid4.get(l));
					if (rowid.equals(colid)) {
						colval4 = Helper.correctDouble((String) year4.get(l));
					} else {
						colval4 = "0.00";
					}
				} else {
					colval4 = "0.00";
				}
				if (year5 != null) {
					rowid = Helper.correctDouble((String) vecid5.get(l));
					if (rowid.equals(colid)) {
						colval5 = Helper.correctDouble((String) year5.get(l));
					} else {
						colval5 = "0.00";
					}
				} else {
					colval5 = "0.00";
				}
				
		
				selectdesc = "desc" + Helper.correctNull((String) g1.get(0));
				strtype = Helper.correctNull((String) g1.get(2));
				
				%>
				<%if(tempyear.equalsIgnoreCase("1")){%>
			         	<td width="15%" align="right" colspan="14"><%=colval1%></td>	
			    <%}if(tempyear.equalsIgnoreCase("2")){%>
			         	<td width="15%" align="right" colspan="3"><%=colval1%></td>	
						<td width="15%" align="right" colspan="3"><%=colval2%></td>	
				<%}if(tempyear.equalsIgnoreCase("3")){%>	
			        	<td width="15%" align="right" colspan="3"><%=colval1%></td>	
						<td width="15%" align="right" colspan="3"><%=colval2%></td>			
                        <td width="15%" align="right" colspan="3"><%=colval3%></td>  
                <%}if(tempyear.equalsIgnoreCase("4")){%>                   		
                        <td width="15%" align="right" colspan="3"><%=colval1%></td>	
						<td width="15%" align="right" colspan="3"><%=colval2%></td>			
                        <td width="15%" align="right" colspan="3"><%=colval3%></td> 
                        <td width="15%" align="right" colspan="3"><%=colval4%></td>
                 <%} if(tempyear.equalsIgnoreCase("5")){%>   
                         <td width="15%" align="right" colspan="3"><%=colval1%></td>	
						 <td width="15%" align="right" colspan="3"><%=colval2%></td>			
                         <td width="15%" align="right" colspan="3"><%=colval3%></td> 
                         <td width="15%" align="right" colspan="3"><%=colval4%></td>
                         <td width="15%" align="right" colspan="3"><%=colval5%></td>
					<%} %>	
			   	</tr>
			   	<%} %>
			   	<%} %>

<%
sizeyearval=sizeyearval-5;
p=p+5;
if(sizeyearval>5)
{
	t=t+5;
}
else
{
	t=t+sizeyearval;
}
}
		 }
 %>
	<%          List<String> list =new ArrayList();
	Double sampleval1 =  Double.parseDouble(hshVal.get("apploamamt").toString());
	   if(sampleval1>=5000001 && sampleval1<=10000000){
			    String strPrevCusID="",strCheifpro="";int j=0,k=1,x=0;
			   int arrSize=arrRowCIBIL.size()+1;
			   for(int i=0;i<arrRowCIBIL.size();i++) {
			   	arrColCIBIL	= (ArrayList)arrRowCIBIL.get(i);
			   	if(strPrevCusID.equalsIgnoreCase(Helper.correctNull((String)arrColCIBIL.get(0))))
			   	{
			   		continue;
			   	}
			   	else
			   	{
			   		strPrevCusID = Helper.correctNull((String)arrColCIBIL.get(0));	
			   		strCheifpro = Helper.correctNull((String)arrColCIBIL.get(14));	
			   	}j=j+1;
			    if(strCheifpro.equalsIgnoreCase("Y")){
			   		j=j+1;k=k+1;
			   %>
			  <tr><td>
			<div id="top">
			<table width="95%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable">
					<tr>
					<td>
			<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable">
			   	 <tr class="tblheader">
					<td align="center" width="20%"><b>Particular</b></td>
					<td align="center" width="30%" colspan="4"><b>Input</b></td>
				</tr>
			   <tr class="datagrid">
			   		<td align="center" width="30%" rowspan="2">Credit bureau score of promoter <%=j%> & credit bureau name</td>
			   		<td align="center" width="20%" ><b>Promoter Name</b></td>
			   		<td align="center" width="10%">CIBIL Refered</td>
			   	    <td align="center" width="15%" ><b>CIBIL Score</b></td>
			   		
			   </tr>
			   <tr class="datagrid">
			   		<td align="center" width="20%"><%=Helper.correctNull((String)arrColCIBIL.get(1))%></td>
			   			<td width="10%" align="center"><%=Helper.correctNull((String)arrColCIBIL.get(2))%></td>
			   		<%if(!Helper.correctNull((String)arrColCIBIL.get(4)).equalsIgnoreCase("")){ %>
			   			<td width="10%" align="center"><%=Helper.correctNull((String)arrColCIBIL.get(4))%></td>
			   		<%}else{ %>
			   			<td width="10%" align="center"><%=Helper.correctNull((String)arrColCIBIL.get(11))%></td>
			   		<%} %>
			   </tr>
			   <%}}}%>
		   </table>
				</td>
				</tr>
				</table>
				</div>
				</td>
				</tr>
				
				
			   <tr><td>
		
			<div id="">
			<table width="95%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="outertable">
					<tr>
					<td>
			<table width="100%" border="1" align="center" cellpadding="3"
					cellspacing="0" class="outertable">
			 <% 
			 if(sampleval1>=10000001){ 
			 %>
			   
<tr >
		<td align="center" width="30%" ><b>Particular</b></td>
		<td align="center" width="70%" colspan="4"><b>Input</b></td>
	</tr>

	<tr>
		<td align="center" width="20%">Is any of the Promoter(s)/Directors/Key management personnel in the CRILC/CIBIL/RBI list of defaulters ?</td>
		
<td align="center" width="30%" colspan="3">
	<table width="100%" align="center">
	<tr>
		<%if(Helper.correctNull((String) hshValues.get("CG_DEFAULTER")).equalsIgnoreCase("Y")){ %>
			<td align="center" width="15%">Yes</td>
			<%}else{ %>
			<td align="center" width="15%">No</td>
			<%} %>
		</tr>
	</table>
</td>
	</tr>
	
	
	<% String strPrevCusID="",strCheifpro=""; int j=0,k=1,x=0;
 int arrSize=arrRowCIBIL.size()+1;
for(int i=0;i<arrRowCIBIL.size();i++) {
	arrColCIBIL	= (ArrayList)arrRowCIBIL.get(i);
	if(strPrevCusID.equalsIgnoreCase(Helper.correctNull((String)arrColCIBIL.get(0))))
	{
		continue;
	}
	else
	{
		strPrevCusID = Helper.correctNull((String)arrColCIBIL.get(0));	
		strCheifpro = Helper.correctNull((String)arrColCIBIL.get(14));	
	}j=j+1;
	%>
	<%
	  if(arrRowCIBIL!=null&&arrRowCIBIL.size()>0)
	 {%>
	 <tr>
		<td align="center" width="30%" rowspan="2">Credit bureau score of promoter <%=j%> & credit bureau name</td>
		<td align="center" width="20%" ><b>Promoter Name</b></td>
		<td align="center" width="10%">CIBIL Refered</td>
	    <td align="center" width="15%" ><b>CIBIL Score</b></td>
		
</tr>

	<tr >
			<td width="20%" align="center"><%=Helper.correctNull((String)arrColCIBIL.get(1))%></td>
			<td width="10%" align="center"><%=Helper.correctNull((String)arrColCIBIL.get(2))%></td>
			<%if(!Helper.correctNull((String)arrColCIBIL.get(4)).equalsIgnoreCase("")){ %>
			<td width="10%" align="center"><%=Helper.correctNull((String)arrColCIBIL.get(4))%></td>
		<%}else{ %>
			<td width="10%" align="center"><%=Helper.correctNull((String)arrColCIBIL.get(11))%></td>
		<%} %>
		</tr>
		<%}else{ %>	
	<% if(!strCheifpro.equalsIgnoreCase("Y")){
		j=j+1;k=k+1;
%>
<tr>
		<td align="center" width="10%" rowspan="2">2.<%=j%></td>
		<td align="center" width="30%" rowspan="2">Credit bureau score of promoter <%=j%> & credit bureau name</td>
		<td align="center" width="15%" ><b>Promoter Name</b></td>
		<td align="center" width="10%">CIBIL Refered</td>
	    <td align="center" width="15%" ><b>CIBIL Score</b></td>
		
</tr>
<tr>
		<td align="center" width="20%"><%=Helper.correctNull((String)arrColCIBIL.get(1))%></td>
			<td width="10%" align="center"><%=Helper.correctNull((String)arrColCIBIL.get(2))%></td>
		<%if(!Helper.correctNull((String)arrColCIBIL.get(4)).equalsIgnoreCase("")){ %>
			<td width="10%" align="center"><%=Helper.correctNull((String)arrColCIBIL.get(4))%></td>
		<%}else{ %>
			<td width="10%" align="center"><%=Helper.correctNull((String)arrColCIBIL.get(11))%></td>
		<%} %>
</tr>
<%}}}%>

<!-- Added for Experian Score -->
<%
	  if(arrRowCIBIL!=null&&arrRowCIBIL.size()>0)
	 {
		  arrSize=arrRowCIBIL.size()+1;
			 strPrevCusID="";strCheifpro=""; j=0;
%>
<tr>
<td align="center" width="30%" rowspan=<%=arrSize%>>Experian Commercial score (if available,else put NA)</td>
<td align="center" width="20%" ><b>Promoter Sno</b></td>
<td align="center" width="15%" ><b>Promoter Name</b></td>
<td align="center" width="15%" ><b>Commercial score</b></td>
</tr>
<%for(int i=0;i<arrRowCIBIL.size();i++) {
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
	<td align="center" width="20%"><%=j%></td>
	<td align="center" width="15%"><%=Helper.correctNull((String)arrColCIBIL.get(1))%></td>
	<% if(!Helper.correctNull((String)arrColCIBIL.get(17)).equalsIgnoreCase(""))
			{
		%>
		<td align="center" width="15%"><%=Helper.correctNull((String)arrColCIBIL.get(17))%></td>

		<%} else {%>
		<td width="14%" align="center">NA</td>
		<%} %>
	
</tr>
<%}}%>
<tr></tr>

<!-- end -->

	<tr>
		<td align="center" width="30%">Networth of the key Promoter Or borrower in Rs Lakhs</td>
		
		<% if(!networth.equalsIgnoreCase(""))/* if(!Helper.correctNull((String) hshRecord2.get("PERAPP_NETWORTH")).equalsIgnoreCase("")) */
		{
		%>
		<td width="14%" colspan="3" align="center"><%=networth%> </td>
        <%} else {%>
		<td width="14%" colspan="3"  align="center">Not Available</td>
		<%} %>	
	</tr>
	<tr>
		<td align="center" width="30%">Promoter's contribution in the entity (in % terms)</td>
		<% if(!Helper.correctNull((String) hshRecord2.get("CG_TC_PROMOTERS")).equalsIgnoreCase(""))
			{
		%>
		<td width="14%" colspan="3" align="center"><%=Helper.correctNull((String) hshRecord2.get("CG_TC_PROMOTERS")) %>&nbsp;%</td>
		<%} else {%>
		<td width="14%" colspan="3" align="center">Not Available</td>
		<%}%>
	</tr>
	<%-- <%
			  if(arrRowCIBIL!=null&&arrRowCIBIL.size()>0)
			 {
	 strPrevCusID="";strCheifpro="";
		 arrSize=arrRowCIBIL.size()+1;
		for(int i=0;i<arrRowCIBIL.size();i++) 
		{
			arrColCIBIL	= (ArrayList)arrRowCIBIL.get(i);
			if(strPrevCusID.equalsIgnoreCase(Helper.correctNull((String)arrColCIBIL.get(0))))
			{
				continue;
			}
			else
			{
				strPrevCusID = Helper.correctNull((String)arrColCIBIL.get(0));	
				strCheifpro = Helper.correctNull((String)arrColCIBIL.get(14));	
			}
			if(!strCheifpro.equalsIgnoreCase("Y")){
				j=j+1;k=k+1;
		%>
	<tr>
<td align="center" width="30%" rowspan=<%=arrSize%>>Group/associate entities of promoter(s) have been into NPA category in past 1 year</td>
<td align="center" width="20%" ><b>Promoter Sno</b></td>
<td align="center" width="15%" ><b>Promoter Name</b></td>
<td align="center" width="15%" ><b>NPA Category</b></td>
</tr>
<%
for(i=0;i<arrRowCIBIL.size();i++) {
	x=i+1;
	arrColCIBIL	= (ArrayList)arrRowCIBIL.get(i);%>
	<tr>
	<td align="center" width="20%"><%=x%></td>
	<td align="center" width="15%"><%=Helper.correctNull((String)arrColCIBIL.get(1))%></td>
	<%
		if(!Helper.correctNull((String)arrColCIBIL.get(15)).equalsIgnoreCase(""))
		{%>

		<td align="center" width="15%"><%=Helper.correctNull((String)arrColCIBIL.get(15))%></td> 
		
		<%} else {%>
		<td width="14%" align="center">NA</td>
					<%} %>
	
</tr>
<%} }}}%> --%>
		<!-- end --> 
	<%
 int f=1;
for(int i=0;i<arrRowCIBIL.size();i++) {
	arrColCIBIL	= (ArrayList)arrRowCIBIL.get(i);
	if(strPrevCusID.equalsIgnoreCase(Helper.correctNull((String)arrColCIBIL.get(0))))
	{
		continue;
	}
	else
	{
		strPrevCusID = Helper.correctNull((String)arrColCIBIL.get(0));	
		strCheifpro = Helper.correctNull((String)arrColCIBIL.get(14));	
		f++;
	}
}
%>

<%
	  if(!strCheifpro.equalsIgnoreCase("Y"))
	 {
		  arrSize=f+1;
			 strPrevCusID="";strCheifpro=""; j=0;
%>
<tr class="datagrid">
<td align="center" width="30%" rowspan=<%=arrSize%>>Group/associate entities of promoter(s) have been into NPA category in past 1 year</td>
<td align="center" width="20%" ><b>Promoter Sno</b></td>
<td align="center" width="15%" ><b>Promoter Name</b></td>
<td align="center" width="15%" ><b>NPA Category</b></td>
</tr>
<% //out.print("arrRowCIBIL.size()"+arrRowCIBIL.size());
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
<tr class="datagrid">
	<td align="center" width="20%"><%=j%></td>
	<td align="center" width="15%"><%=Helper.correctNull((String)arrColCIBIL.get(1))%></td>
	<% if(!Helper.correctNull((String)arrColCIBIL.get(15)).equalsIgnoreCase(""))
			{
		%>
		<td align="center" width="15%"><%=Helper.correctNull((String)arrColCIBIL.get(15))%></td>

		<%} else {%>
		<td width="14%" align="center"> </td>
		<%} %>
	
</tr>
<%}}%>
	<tr>
		
		<td align="center" width="30%">Promoter's experience in current/related business (in years)</td>
			<%if(!Helper.correctNull((String) hshRecord2.get("PEREMP_EXPINYRS")).equalsIgnoreCase(""))
		{%>

		<td width="14%" colspan="3" align="center"><%=Helper.correctNull((String) hshRecord2.get("PEREMP_EXPINYRS"))%> </td>
		<%} else {%>
		<td width="14%" colspan="3" align="center">Not Available</td>
					<%} %>
	</tr>

			<%}  %>
	
	</table>
	</div>
	</td>
	</tr>
	</table>
	</td>
	</tr>
<tr>
				<td>
				<div id="">
				<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0">
             <tr>
				<td>
				<table width="95%" border="1" align="center" cellpadding="3"
					cellspacing="0">
				<tr>
				
				
				<td>CIBIL MSME Rank of the firm value between 1 and 10</td>
				<td>&nbsp;<%=Helper.correctNull((String) hshValues.get("CG_CIBIL_MSME_RANK"))%></td>
				</tr>
				
				<tr>
				
				<td>Repayments due within an Year in Rs </td>
				<td>&nbsp;<%=Helper.correctNull((String) hshValues.get("CG_REPAY_YEAR"))%></td>
				</tr>
				</table>
				</td>
				</tr>
				</table>
				</div>
				</td>
				</tr>

			
			<tr>
				<td colspan="4">
				<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0">
				<tr>
				
				<td>&nbsp;</td>
				
				</tr>
				<tr>
				<td>Remarks: </td>
				</tr>
				<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				</tr>
				<tr>
				<td>Terms & Conditions:</td>
				
				</tr>
				<tr>
				<td  colspan="2" >It has been ensured that the name of the company/firm, list of promoters, directors, partners or any of the group/associate concerns does not appear in the following list 
				 issued from time to time.</td>
				</tr>
				<tr>
				<td>&nbsp;</td>
				</tr>
				<tr>
				<td width="80%">1. Caution advices as advised by RBI and circulated to the Banks.</td>
				</tr>
				<tr>
				<td>2. RBI list of non-suit filed accounts of willful defaulters of Rs.25 lakh and above.</td>
				</tr>
				<tr>
				<td>3. RBI list of non-suit filed accounts of defaulters of Rs.100 lakh and above.</td>
				</tr>
				<tr>
				<td>4. CIBIL list of suit filed accounts of willful defaulters of Rs.25 lakh and above.</td>
				</tr>
				<tr>
				<td>5. CIBIL list of suit filed accounts of defaulters of Rs.100 lakh and above.</td>
				</tr>
				
				
				<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				</tr>
				<tr>
				<td>&nbsp;</td>
				
			
				</tr>
				<tr>
				<td >Date :</td>
				</tr>
				<tr>
				<td >Place :     </td>
				<td width="50%">BRANCH HEAD </td>
				</tr>
				<tr>
				<td >&nbsp;</td>
				</tr>
				<tr>
				<td ><u>Field marked as * are mandatory</u></td>
				</tr>
				<tr>
				<td>&nbsp;</td>
				
				</tr>	
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<h1><%=Helper.correctNull((String)hshValues.get("strnature"))%></h1>
<input type="hidden" name="hidnature" value="<%=Helper.correctNull((String)hshValues.get("strnature"))%>">
</body>

</html>