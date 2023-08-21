<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<jsp:useBean id="hshValues" type="java.util.HashMap" scope="request" />
<%
HashMap hsh1=null;
HashMap hsh2=null;
HashMap hsh3=null;
HashMap hsh4=null;
HashMap hsh5=null;
HashMap hsh8=null;
HashMap hsh9=null;
HashMap hsh10=null;
HashMap hsh11=null;
HashMap hsh12=null;
HashMap hsh13=null;
HashMap hsh14=null;
HashMap hsh15=null;
HashMap hsh16=null;
HashMap hsh17=null;
HashMap hsh18=null;
//HashMap hsh19=null;
HashMap hsh20=null;
HashMap hsh21=null;
HashMap hsh22=null;
HashMap hsh23=null;
HashMap hsh24=null;
HashMap hsh25=null;

hsh1=(HashMap)hshValues.get("hsh1");
hsh2=(HashMap)hshValues.get("hsh2");
hsh3=(HashMap)hshValues.get("hsh3");
hsh4=(HashMap)hshValues.get("hsh4");
hsh5=(HashMap)hshValues.get("hsh5");
hsh8=(HashMap)hshValues.get("hsh8");
hsh9=(HashMap)hshValues.get("hsh9");
hsh10=(HashMap)hshValues.get("hsh10");
hsh11=(HashMap)hshValues.get("hsh11");
hsh12=(HashMap)hshValues.get("hsh12");
hsh13=(HashMap)hshValues.get("hsh13");
hsh14=(HashMap)hshValues.get("hsh14");
hsh15=(HashMap)hshValues.get("hsh15");
hsh16=(HashMap)hshValues.get("hsh16");
hsh17=(HashMap)hshValues.get("hsh17");
hsh18=(HashMap)hshValues.get("hsh18");
//hsh19=(HashMap)hshValues.get("hsh19");
hsh20=(HashMap)hshValues.get("hsh20");
hsh21=(HashMap)hshValues.get("hsh21");
hsh22=(HashMap)hshValues.get("hsh22");
hsh23=(HashMap)hshValues.get("hsh23");
hsh24=(HashMap)hshValues.get("hsh24");
hsh25=(HashMap)hshValues.get("hsh25");

java.text.NumberFormat nf1=java.text.NumberFormat.getInstance();
nf1.setMaximumFractionDigits(0);
nf1.setMinimumFractionDigits(0);
nf1.setGroupingUsed(false);

ArrayList arrRow=new ArrayList(); 
ArrayList arrCol=new ArrayList();
ArrayList arrRowCollateral=new ArrayList();
ArrayList arrMailboxComments=new ArrayList();
ArrayList vecRow=null;
ArrayList vecCol=new ArrayList();


String strstock=Helper.correctNull((String)hsh20.get("advcom_stock"));
if(strstock.equalsIgnoreCase("1"))
{
strstock="Yes";
}
else
{
strstock="No";
}
String strpenalinterest=Helper.correctNull((String)hsh20.get("advcom_penalinterest"));
if(strpenalinterest.equalsIgnoreCase("1"))
{
strpenalinterest="Yes";
}
else
{
strpenalinterest="No";
}
String strsanctionadvice=Helper.correctNull((String)hsh20.get("advcom_sanctionadvice"));
if(strsanctionadvice.equalsIgnoreCase("1"))
{
strsanctionadvice="Yes";
}
else
{
strsanctionadvice="No";
}
String strlimitdrawing=Helper.correctNull((String)hsh20.get("advcom_limitdrawing"));
if(strlimitdrawing.equalsIgnoreCase("1"))
{
strlimitdrawing="Yes";
}
else
{
strlimitdrawing="No";
}
String strwithdrwlextent=Helper.correctNull((String)hsh20.get("advcom_withdrwlextent"));
if(strwithdrwlextent.equalsIgnoreCase("1"))
{
strwithdrwlextent="Frequently";
}
if(strwithdrwlextent.equalsIgnoreCase("2"))
{
strwithdrwlextent="Never";
}
if(strwithdrwlextent.equalsIgnoreCase("3"))
{
strwithdrwlextent="Rarely";
}
if(strwithdrwlextent.equalsIgnoreCase("4"))
{
strwithdrwlextent="No Occasion";
}
String strpurposewithdrawl=Helper.correctNull((String)hsh20.get("advcom_purposewithdrawl"));
if(strpurposewithdrawl .equalsIgnoreCase("1"))
{
	strpurposewithdrawl = "For Payment of Govt. dues";
}
if(strpurposewithdrawl .equalsIgnoreCase("2"))
{
	strpurposewithdrawl = "For disbursement of wages/salaries";
}
if(strpurposewithdrawl .equalsIgnoreCase("3"))
{
	strpurposewithdrawl = "Purchase of raw materials";
}
if(strpurposewithdrawl .equalsIgnoreCase("4"))
{
	strpurposewithdrawl = "Any Other purpose (specify )";
}
	
String bowpayment=Helper.correctNull((String)hsh13.get("adv_bowpayment"));
	if(bowpayment.equalsIgnoreCase("1"))
	{
		bowpayment ="NORMAL";
	}
	else if(bowpayment.equalsIgnoreCase("2"))
	{
		bowpayment ="PROMPT";
	}
	else if(bowpayment.equalsIgnoreCase("3"))
	{
		bowpayment ="TRADY";
	}
	
String sellocal=Helper.correctNull((String)hsh13.get("adv_local"));
if(sellocal .equalsIgnoreCase("0"))
{
	sellocal=" ";
}
else if(sellocal.equalsIgnoreCase("1"))
{
	sellocal="AT SIGHT";
}
else if(sellocal.equalsIgnoreCase("2"))
{
	sellocal="AFTER";
}

String selcommit=Helper.correctNull((String)hsh13.get("adv_commit"));

if(selcommit.equalsIgnoreCase("0"))
{
	selcommit=" ";
}
else if(selcommit.equalsIgnoreCase("1"))
{
	selcommit="YES";
}
else if(selcommit.equalsIgnoreCase("2"))
{
	selcommit="NO";
}

String paidupto=Helper.correctNull((String)hsh15.get("adv_othpaidupto"));

if(paidupto.equalsIgnoreCase("1"))
{
paidupto="Yes";
}
else
{
paidupto="No";
}


String select1=Helper.correctNull((String)hsh1.get("borrpow_activity"));
if(select1 .equalsIgnoreCase("1"))
{
select1="Yes";
}
else
{
select1="No";
}
String noOfDays = Helper.correctNull((String)hsh13.get("adv_status_days"));
String select2=Helper.correctNull((String)hsh1.get("borrpow_totalborrowing"));
if(select2 .equalsIgnoreCase("1"))
{
select2="Yes";
}
else
{
select2="No";
}


String select3=Helper.correctNull((String)hsh1.get("borrpow_resolution"));

if(select3 .equalsIgnoreCase("1"))
{
select3="Yes";
}
else
{
select3="No";
}

String scale=Helper.correctNull((String)hshValues.get("scale"));
if(scale.equalsIgnoreCase("1"))
{
	scale="Services";
}
if(scale.equalsIgnoreCase("2"))
{
	scale="Exports";
}
if(scale.equalsIgnoreCase("3"))
{
	scale="Agriculture";
}
if(scale.equalsIgnoreCase("4"))
{
	scale="Infrastructure";
}
if(scale.equalsIgnoreCase("Trading"))
{
	scale="Trading";
}
if(scale.equalsIgnoreCase("Manufacturing"))
{
	scale="Manufacturing";
}	

String renewal=Helper.correctNull((String)hsh10.get("ADV_GUARANTORSRENEWAL"));
if(renewal.equalsIgnoreCase("1"))
{
	renewal="Yes";
}
else
{
	renewal="No";
}


String strsectorcode=Helper.correctNull((String)hshValues.get("ops_accountsectorcategory"));
	if(strsectorcode.equalsIgnoreCase("1"))
		{
			strsectorcode="import";
		}
	if(strsectorcode.equalsIgnoreCase("2"))
			{
				strsectorcode="industry";
			}
	if(strsectorcode.equalsIgnoreCase("3"))
			{
				strsectorcode="export";
			}
	if(strsectorcode.equalsIgnoreCase("4"))
			{
				strsectorcode="Small scale";
			}
	if(strsectorcode.equalsIgnoreCase("5"))
			{
				strsectorcode="Trade & COM";
			}
	if(strsectorcode.equalsIgnoreCase("6"))
			{
				strsectorcode="Agriculture";
			}
	if(strsectorcode.equalsIgnoreCase("7"))
			{
				strsectorcode="Transport operator";
			}
	if(strsectorcode.equalsIgnoreCase("8"))
			{
				strsectorcode="SM Trader other than Fert";
			}
	if(strsectorcode.equalsIgnoreCase("9"))
			{
				strsectorcode="Trader in Fert";
			}
	if(strsectorcode.equalsIgnoreCase("10"))
			{
				strsectorcode="Self Employed";
			}
	if(strsectorcode.equalsIgnoreCase("11"))
			{
				strsectorcode="SM Business";
			}
	if(strsectorcode.equalsIgnoreCase("12"))
			{
				strsectorcode="Others";
			}
	//FOR TAKE OVERNORMS
	String strtakeover=Helper.correctNull((String)hshValues.get("istakeover"));
	if(strtakeover.equalsIgnoreCase("1"))
	{
		strtakeover="Yes";
	}
	if(strtakeover.equalsIgnoreCase("2"))
	{
		strtakeover="No";
	}
	
	String strflag="";	
	arrRowCollateral=(ArrayList)hshValues.get("arrCollateral");	
	
		if(arrRowCollateral!=null && arrRowCollateral.size()>0)
		{
			strflag="Yes";
		}
		else
		{
			strflag="No";
		}
	 arrMailboxComments=(ArrayList)hshValues.get("mailcomments");
	%>
	
	
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>ADV1151 - Report</title>
<link rel="stylesheet"	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form method="" action="post">
  <table width="85%" border="0" cellspacing="0" cellpadding="3" bordercolor="#999999" align="center">
    <tr> 
      <td colspan="3"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td align="center"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td align="center" colspan="2" ><img
									src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg"> 
                  </td>
                </tr>
                <tr> 
                  <td align="center" colspan="2"><b>KARNATAKA BANK LTD.</b></td>
                </tr>
                <tr> 
                  <td align="right" width="49%"><b>BRANCH:</b></td>
                  <td width="51%"> <b><%=Helper.correctNull((String) hshValues.get("RespectiveBranch"))%></b> 
                  </td>
                </tr>
                <tr> 
                  <td align="right" width="49%"><b>REGION :</b></td>
                  <td width="51%"> <b> <%=Helper.correctNull((String) hshValues.get("RespectiveRegion"))%></b> 
                  </td>
                </tr>
                <tr> 
                  <td align="right" width="49%"><b>ZONE :</b></td>
                  <td><b><%=Helper.correctNull((String) hshValues.get("RespectiveZone"))%></b></td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr> 
      <td colspan="3"> 
        <div id="top"> 
          <table width="100%" border="0" cellspacing="0" cellpadding="3" >
            <tr> 
              <td colspan="4" align="center"><b>I) LIMIT APPLICATION</b> </td>
            </tr>
            <tr> 
              <td colspan="4" align="center"><%=Helper.correctNull((String)hshValues.get("flag"))%> 
              </td>
            </tr>
             <tr> 
              <td width="12%"><b>DATE</b></td>
              <td width="23%">&nbsp;<%=Helper.correctNull((String)hshValues.get("app_createdate"))%></td>
              <td width="8%"><b>MONTH OF REVIEW </b></td>
              <td width="5%"><%=Helper.correctNull((String)hshValues.get("REVIEW"))%>&nbsp;</td>
            </tr>
            <tr> 
              <td width="12%"><b>TITLE OF THE ACCOUNT</b></td>
              <td ><%=Helper.correctNull((String)hshValues.get("strappname"))%></td>
           	  <td rowspan="2" width="5%">&nbsp;<b>RATING</b></td>
			  <td rowspan="2" width="5%" nowrap="nowrap">&nbsp;<b>  
			  <%if(Helper.correctNull((String)hsh3.get("rate_check")).equals("1"))
			  { %>
			  <%=Helper.correctNull((String)hsh3.get("rating_grade"))%>&nbsp;/&nbsp;<%=Helper.correctNull((String)hsh3.get("rating"))%>
			  <%}
			  else if(Helper.correctNull((String)hsh3.get("rate_check")).equals("2"))
			  { %>
			   NOT APPLICABLE
			   <%}else{} %>
			  </b></td>
		    </tr>
		    <tr> <td width="12%" nowrap="nowrap"><b>COMPANY IDENTIFICATION <br> NUMBER(CIN)</b></td>
              <td ><%=Helper.correctNull((String)hshValues.get("perapp_cin"))%></td></tr>
            
            <tr> 
              <td width="12%"><b>ADDRESS</b></td>
              <td colspan="3"><%=Helper.correctNull((String)hshValues.get("perapp_address1"))%><br>
                <%=Helper.correctNull((String)hshValues.get("perapp_address2"))%><br>
                <%=Helper.correctNull((String)hshValues.get("comapp_regcity"))%><br>
                <%=Helper.correctNull((String)hshValues.get("comapp_regstate"))%> 
                <%=Helper.correctNull((String)hshValues.get("perapp_zip"))%></td>
            </tr>
            <tr> 
              <td width="12%"><b>BRANCH AT :</b></td>
              <td colspan="3"><%=Helper.correctNull((String) hshValues.get("RespectiveBranch"))%></td>
            </tr>
            <tr> 
              <td width="12%"><b>SECTORAL CODE:</b></td>
              <td width="13%"><%=strsectorcode%></td>
              <td width="12%"><b>CONSTITUTION</b></td>
              <td width="13%"><%=Helper.correctNull((String)hshValues.get("constitution"))%></td>
            </tr>
            <tr> 
              <td colspan="2"><b>GROUP IF ANY TO WHICH THE ACCOUNT BELONGS</b></td>
              <td colspan="2">&nbsp;</td>
            </tr>
          </table>
        </div>
      </td>
    </tr>
    <tr> 
      <td colspan="3"> 
        <div id="top"> 
          <table width="100%" border="0" cellspacing="0" cellpadding="3">
            <tr> 
              <td colspan="4"><b>II) OUT OF THE TOTAL LIMIT</b></td>
            </tr>
            <tr> 
              <td colspan="2"><b>FUNDED EXPOSURE (<%=ApplicationParams.getCurrency()%>)</b></td>
              <td colspan="2"><b>NON-FUNDED EXPOSURE (<%=ApplicationParams.getCurrency()%>)</b></td>
            </tr>
            <tr> 
              <td colspan="2" align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("facility_proposedforfund"))))%></td>
              <td colspan="2" align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("facility_proposedfornonfund"))))%></td>
            </tr>
            <tr> 
              <td width="12%"><b>DATE OF ESTABLISHMENT</b> </td>
              <td width="13%">&nbsp;<%=Helper.correctNull((String)hshValues.get("perapp_dob"))%></td>
              <td width="12%"><b>BANKING WITH US SINCE </b></td>
              <td width="13%">&nbsp;<%=Helper.correctNull((String)hshValues.get("perapp_banksince"))%></td>
            </tr>
            <tr> 
              <td width="12%"><b>CLASSIFICATION</b> </td>
              <td width="13%">&nbsp;<%=Helper.correctNull((String)hshValues.get("asset_classification"))%></td>
              <td width="12%"><b>ADVANCE SINCE</b></td>
              <td width="13%">&nbsp;</td>
            </tr>
            <tr> 
              <td colspan="2"><b>TAKE OVER NORMS-WHETHER TAKE OVER NORMS COMPLIED 
                WITH</b></td>
              <td colspan="2"><%=strtakeover%></td>
            </tr>
          </table>
        </div>
      </td>
    </tr>
    <tr> 
      <td colspan="3"> 
        <div id="top"> 
          <table width="100%" border="0" cellspacing="1" cellpadding="3">
            <tr> 
              <td><b>NAME(S) OF PROPRIETOR/PARTNERS/DIRECTORS</b></td>
            </tr>
            <tr> 
              <td> 
                <%
			ArrayList arrDir=new ArrayList();
			arrDir=(ArrayList)hshValues.get("arrDircol");
			if(arrDir!=null )
			{
				for(int i=0;i<arrDir.size();i++)
				{
					
				
			%>
                <%=arrDir.get(i) %><br>
                <%}
        } 
        %>
              </td>
            </tr>
          </table>
        </div>
      </td>
    </tr>
    <tr> 
      <td colspan="3"> 
        <div id="top"> 
          <table width="100%" border="0" cellspacing="1" cellpadding="3">
            <tr> 
              <td><b>III) NATURE OF BUSINESS</b></td>
            </tr>
            <tr> 
              <td><%=Helper.correctNull((String)hshValues.get("ops_accountbusinessnature"))%></td>
            </tr>
          </table>
        </div>
      </td>
    </tr>
    <tr> 
      <td colspan="3"> 
        <div id="top"> 
          <table border="0" width="100%" align="center" cellspacing="0" cellpadding="3">
           <tr> 
              <td colspan="5"><b>IV (a) MEANS :INDIVIDUAL/FIRM/DIRECTORS (Amount 
                in Lacs)</b> </td>
            </tr>
            <tr> 
              <td width="30%" align="center"><b>NAME</b></td>
              <td width="5%" align="center"><b>DIN</b></td>
              <td width="20%" align="center"><b>AMOUNT</b></td>
              <td width="20%" align="center"><b>SOURCE</b></td>
              <td width="25%" align="center"><b>DATE</b></td>
            </tr>
            <%ArrayList arrColmeans = new ArrayList();
			ArrayList arrRowmeans = new ArrayList();

			arrRowmeans = (ArrayList) hsh3.get("arrRow5");
			
			if (arrRowmeans != null && arrRowmeans.size() > 0) {
				for (int i = 0; i < arrRowmeans.size(); i++) {
					arrColmeans = (ArrayList) arrRowmeans.get(i);	
						if(arrColmeans!=null)
						{
					
					%>
            <tr> 
              <td width="30%" align="left">&nbsp;<%=Helper.correctNull((String) arrColmeans.get(0))%></td>
               <td width="5%" align="left">&nbsp;<%=Helper.correctNull((String) arrColmeans.get(3))%></td>
              <td width="20%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrColmeans.get(2))))%></td>
              <%if(!(Helper.correctNull((String)arrColmeans.get(2)).equalsIgnoreCase("0.00")) && !(Helper.correctNull((String) arrColmeans.get(1)).equalsIgnoreCase(""))) {%>
              <td width="20%" align="center">Credit Report</td>
              <%}else{%>
              <td width="20%" align="center">&nbsp;</td>
              <%} %>
              <td width="25%" align="center">&nbsp;<%=Helper.correctNull((String) arrColmeans.get(1))%></td>
            </tr>
            <%}}
			}%>
            <%//String strconstitution=Helper.correctNull((String)hsh3.get("PERAPP_CONSTITUTION"));
										//if((strconstitution.equalsIgnoreCase("005"))||(strconstitution.equalsIgnoreCase("006")))
										//{
										%>
            <tr> 
              <td colspan="5"><b>(b) CAPITAL : COMPANY (Amount in Lacs)</b> </td>
            </tr>
            <tr> 
              <td width="30%"><b>Authorised</b></td>
              <td width="5%"><b>Subscribed</b></td>
              <td width="20%"><b>Paid-up</b></td>
              <td width="20%" colspan="2"><b>Reserve</b></td>
            </tr>
            <tr> 
              <td width="30%">&nbsp;<%=Helper.correctNull((String) hsh3
									.get("PERAPP_AUTHORISED"))%></td>
              <td width="25%">&nbsp;<%=Helper.correctNull((String) hsh3
							.get("PERAPP_SUBSCRIBED"))%></td>
              <td width="23%">&nbsp;<%=Helper.correctNull((String) hsh3
							.get("PERAPP_PAIDUP"))%></td>
              <td width="20%" colspan="2">&nbsp;<%=Helper.correctNull((String) hsh3
							.get("PERAPP_RESERVE"))%></td>
            </tr>
            <%//}%>
            <tr> 
              <td colspan="5"><b> SANCTION OFFICE COMMENTS</b></td>
            </tr>
            <tr> 
              <td colspan="5"><%=Helper.correctNull((String) hsh3.get("advcap_sanctioncomments"))%>&nbsp;</td>
            </tr>
          </table>
        </div>
      </td>
    </tr>
    <tr> 
      <td colspan="3"> 
        <div id="top"> 
          <table border="0" width="100%" cellspacing="0" cellpadding="3">
            <tr> 
              <td colspan="2"><B>(c) BORROWING POWERS (As per clause No. of Memorandum 
                Articles of Association) </b></td>
            </tr>
            <tr> 
              <td width="57%">I) Whether the activities for which limits are applied 
                for are covered by provisions in the Memorandum of Association 
              </td>
              <td width="43%"> <%=select1%> </td>
            </tr>
            <tr> 
              <td width="57%">II) Whether total borrowings (excluding temporary 
                overdraft not under limit) of the company exceed the total of 
                paid-up capital and reserves.</td>
              <td width="43%"> <%=select2%> </td>
            </tr>
            <%if(select2.equalsIgnoreCase("Yes")){%>
            <tr> 
              <td width="57%"> If so, whether the resolution of the general body 
                obtained:</td>
              <td width="43%"> <%=select3%> </td>
            </tr>
            <%}%>
            <tr> 
              <td width="57%"><b>(d) COMMENTS ON SEARCH REPORT(BRIEF DETAILS INDICATING 
                DATE CHARGE CREATED, AMOUNT, NAME OF PARTY/BANK, NATURE OF CHARGE 
                AND DESCRIPTION OF ASSETS) </b> </td>
              <td width="43%"> <%=Helper.correctNull((String)hsh1.get("borrpow_comments"))%> 
              </td>
            </tr>
            <tr> 
              <td colspan="2"> <b>SANCTION OFFICE COMMENTS</b></td>
            </tr>
            <tr> 
              <td colspan="2"> <%=Helper.correctNull((String)hsh1.get("borrpow_sanction"))%>&nbsp; 
              </td>
            </tr>
          </table>
        </div>
      </td>
    </tr>
    <tr> 
      <td colspan="3"> 
        <div id="top"> 
          <table border="0" width="100%" cellspacing="0" cellpadding="3">
            <tr> 
              <td colspan="2"><b>(e) COMMENTS ON STATUS REPORTS </b> </td>
            </tr>
            <tr> 
              <td width="50%"><b>I) BORROWERS PAYMENTS</b></td>
              <td width="50%"> <%=bowpayment%> </td>
            </tr>
            <tr> 
              <td width="50%"><b>LOCAL PRACTICE </b></td>
              <td width="50%"> <%=sellocal%> </td>
            </tr>
            <%if(sellocal.equals("AFTER")){%>
            <tr> 
              <td width="50%"><b>No of days</b></td>
              <td width="50%"> <%=noOfDays%> </td>
            </tr>
            <%}%>
            <tr> 
              <td width="50%"><b>WHETHER MEETING THE COMMITMENT</b></td>
              <td width="50%"> <%=selcommit%> </td>
            </tr>
            <tr> 
              <td width="50%"><B>II) EXTENT OF CREDIT AVAILABLE FROM SUPPLIERS</B></td>
              <td width="50%"> <%=Helper.correctNull((String)hsh13.get("adv_suppliers"))%>DAYS 
              </td>
            </tr>
            <tr> 
              <td width="50%"><b> EXTENT OF CREDIT EXTENDED TO CUSTOMER </b></td>
              <td width="50%"> <%=Helper.correctNull((String)hsh13.get("adv_customer"))%> 
                DAYS </td>
            </tr>
            <tr> 
              <td width="50%"><b>III) EXTENT OF MARKET BORROWINGS</b></td>
              <td width="50%"> <%=Helper.correctNull((String)hsh13.get("extent"))%></td>
            </tr>
            <tr> 
              <td width="50%"><b> NATURE OF MARKET BORROWINGS</b></td>
              <td width="50%"> <%=Helper.correctNull((String)hsh13.get("nature"))%> 
              </td>
            </tr>
            <tr> 
              <td colspan="2"><b>Comments</b></td>
            </tr>
            <tr> 
              <td colspan="2"> <%=Helper.correctNull((String)hsh13.get("sanction"))%> 
                &nbsp; </td>
            </tr>
          </table>
        </div>
      </td>
    </tr>
    <tr> 
      <td colspan="3"> 
        <div id="top"> 
          <table width="100%" border="0" cellspacing="0" cellpadding="3">
            <tr> 
              <td ><b>IV) COMMENTS ON MANAGEMENT OF BUSINESS</b></td>
            </tr>
            <tr> 
              <td width="50%" align="center"><b>Branch Comments</b></td>
              <!--<td width="50%" align="center"><b>Sanction Office Comments</b></td>-->
            </tr>
            <tr> 
              <td width="50%"><%=Helper.correctNull((String)hshValues.get("branchcomment1"))%>&nbsp;</td>
              <%--<td width="50%"><%=Helper.correctNull((String)hshValues.get("sanctionofficecomment1"))%></td>--%>
            </tr>
          </table>
        </div>
      </td>
    </tr>
    <tr> 
      <td colspan="3"> 
        <div id="top"> 
          <table width="100%" border="0" cellspacing="0" cellpadding="3">
            <tr> 
              <td ><b>V) OPINION ABOUT BORROWER IN MARKET CIRCLES </b></td>
            </tr>
            <tr> 
              <td width="50%" align="center"><b>Branch Comments</b></td>
              <!-- <td width="50%" align="center"><b>Sanction Office Comments</b></td>-->
            </tr>
            <tr> 
              <td width="50%"><%=Helper.correctNull((String)hshValues.get("branchcomment2"))%>&nbsp;</td>
              <%--<td width="50%"><%=Helper.correctNull((String)hshValues.get("sanctionofficecomment2"))%></td>--%>
            </tr>
          </table>
        </div>
      </td>
    </tr>
    <tr> 
      <td colspan="3"> 
        <div id="top"> 
          <table width="100%" border="0" cellspacing="0" cellpadding="3">
            <tr> 
              <td ><b>VI) Income Tax/Wealth Tax-Assessment Extents Statutory Dues 
                such as PF/61/TDS. etc.</b></td>
            </tr>
            <tr> 
              <td width="50%" align="center"><b>Branch Comments</b></td>
              <!--<td width="50%" align="center"><b>Sanction Office Comments</b></td>-->
            </tr>
            <tr> 
              <td width="50%"><%=Helper.correctNull((String)hshValues.get("branchcomment3"))%></td>
              <%-- <td width="50%"><%=Helper.correctNull((String)hshValues.get("sanctionofficecomment3"))%></td>--%>
            </tr>
          </table>
        </div>
      </td>
    </tr>
    <tr> 
      <td align="center" colspan="3"> </td>
    </tr>
    <tr> 
      <%	
	
	
	String selhundi=Helper.correctNull((String)hsh12.get("adv_dishundi"));
	if(selhundi.equalsIgnoreCase("1"))
	{
	selhundi="Yes";
	}
	else
	{
	selhundi="No";
	}
	String seltype1=Helper.correctNull((String)hsh12.get("adv_distype"));
	
	if(seltype1.equalsIgnoreCase("1"))
	{
	seltype1="Regularly";
	}	
	else
	{
	seltype1="Occasionaly";
	}
	
	%>
      <td colspan="3"> 
        <div id="top"> 
          <table width="100%" border="0" cellspacing="0" cellpadding="3">
            <tr> 
              <td colspan="2"><b>V) a) Does the borrower borrow on Hundi</b></td>
              <td colspan="2"> <%=selhundi%> </td>
            </tr>
            <%if(selhundi.equalsIgnoreCase("Yes")){%>
            <tr> 
              <td height="20" colspan="2">If yes</td>
              <td height="20" colspan="2"> <%=seltype1%> </td>
            </tr>
            <%}%>
            <tr> 
              <td height="20" colspan="4"><b>Details of cheques &amp; or acceptances 
                dishonored for lack of funds &amp; Bills purchased returned unpaid 
                during past one year </b></td>
            </tr>
            <tr> 
              <td height="20" width="40%">&nbsp;</td>
              <td height="20" align="center" width="20%"><b>No. of DISHONOURS</b></td>
              <td height="20" align="center" width="20%"><b>RANGE OF AMOUNT</b></td>
              <td height="20" align="center" width="20%"><b>REASONS</b></td>
            </tr>
            <%
		 	ArrayList dishon=new ArrayList();
			ArrayList dishoncol=new ArrayList();
			dishon=(ArrayList)hshValues.get("arrhon");
			int disize=dishon.size();
			if(dishon!=null)
			{
				for(int i=0;i<disize;i++)
				{
					dishoncol=(ArrayList)dishon.get(i);
		 	
		 %>
            <tr> 
              <td height="20" width="40%"><b><%=Helper.correctNull((String) dishoncol.get(0))%>&nbsp;</b></td>
              <td height="20"align="center" width="20%"><%=Helper.correctNull((String) dishoncol.get(1))%> 
              </td>
              <td height="20"align="center" width="20%"> <%=Helper.correctNull((String) dishoncol.get(2))%> 
              </td>
              <td height="20"align="center" width="20%"><%=Helper.correctNull((String) dishoncol.get(3))%> 
              </td>
            </tr>
            <%         
		  
		   }}%>
            <tr> 
              <td colspan="4"> <b>Sanction Office Comments</b></td>
            </tr>
            <tr> 
              <td colspan="4"><%=Helper.correctNull((String)hsh12.get("adv_discomments"))%>&nbsp;</td>
            </tr>
          </table>
        </div>
      </td>
    </tr>
    <tr> 
      <td colspan="3"> 
        <div id="top"> 
          <table width="100%" border="0" cellspacing="1" cellpadding="3">
            <tr> 
              <td colspan="7"><b>VI. a)PARTICULARS OF LIMITS</b></td>
            </tr>
            <tr> 
              <td rowspan="2" align="center" width="25%"><b>Nature of limit</b></td>
              <td colspan="2" align="center" width="20%"><b>Existing</b></td>
              <td rowspan="2" align="center" width="10%"><b>Recommended</b></td>
              <td align="center" rowspan="2" width="8%"><b>Int/Comm</b></td>
              <td align="center" rowspan="2" width="7%"><b>Margin</b></td>
              <td align="center" rowspan="2" width="30%"><b>Security</b></td>
            </tr>
            <tr> 
              <td align="center" width="10%">Limit </td>
              <td align="center" width="10%">O/S</td>
            </tr>
            <%  int arrTL_Funded_NonFunded_Size=0;
                   ArrayList OurBank_TL = new ArrayList();
                   ArrayList TL_Funded_NonFunded=new ArrayList();
                    
                    arrTL_Funded_NonFunded_Size=0;
                    
                    OurBank_TL=(ArrayList)hshValues.get("OurBank_TL");
               
                    if(OurBank_TL!=null)
                    {                    	
                    	arrTL_Funded_NonFunded_Size = OurBank_TL.size();
                    }

                    for(int i=0;i<arrTL_Funded_NonFunded_Size;i++)
                    {
                    	TL_Funded_NonFunded=(ArrayList)OurBank_TL.get(i);

                    	int introwspan=Integer.parseInt(Helper.correctInt((String)TL_Funded_NonFunded.get(9)));
		  %>
            <tr> 
              <td align="left" valign="top" rowspan="<%=introwspan%>"><%=Helper.correctNull((String)TL_Funded_NonFunded.get(7))%>-<%=Helper.correctNull((String)TL_Funded_NonFunded.get(1))%></td>
              <td align="right" valign="top" rowspan="<%=introwspan%>"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)TL_Funded_NonFunded.get(2))))%></td>
              <td align="right" valign="top" rowspan="<%=introwspan%>"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)TL_Funded_NonFunded.get(6))))%></td>
              <td align="right" valign="top" rowspan="<%=introwspan%>"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)TL_Funded_NonFunded.get(3))))%></td>
              <td align="left" valign="top" rowspan="<%=introwspan%>"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)TL_Funded_NonFunded.get(5))))%></td>
              <%
                        ArrayList arrSecurity=new ArrayList();
              			arrSecurity=(ArrayList)TL_Funded_NonFunded.get(8);
                        if(arrSecurity!=null && arrSecurity.size()>0)
                        {
                        	for(int j=0; j<arrSecurity.size(); j++)
                          	{
                          		arrCol=new ArrayList();
                          		arrCol=(ArrayList)arrSecurity.get(j);
                        
                          		%>
    	        	    <td width="8%" align="right" valign="top">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1))))%></td>
        	            <td width="31%" align="left" valign="top"><%=Helper.correctNull((String)arrCol.get(0))%>&nbsp;</td>
               			</tr><tr>
               			<%}
                          	}else{%>
                          	<td align="right" valign="top">&nbsp;</td>
                          	<td width="31%" valign="top" align="left">&nbsp;</td>
                          	</tr>
                          	<%} }%>
          </table>
        </div>
      </td>
    </tr>
    <tr> 
      <td colspan="3"> 
        <div id="top"> 
          <table border="0" width="100%" cellspacing="0" cellpadding="1" >
            <tr> 
              <td width="40%" colspan="2"><b>COLLATERAL SECURITY OFFERED:</b></td>
              <td width="60%" colspan="3"><%=strflag%></td>
            </tr>
            <%if(strflag.equalsIgnoreCase("yes")){ %>
            <tr> 
              <td width="25%"><b>DESCRIPTION &amp; LOCATION OF PROPERTY</b></td>
              <td width="20%"><b>PROPERTY OWNED BY</b></td>
              <td width="10%"><b>MARKET VALUE OF PROPERTY(In Lacs)</b></td>
              <td width="21%"><b>ENCUMBRANCE IF ANY</b></td>
              <td width="24%"><b>WHETHER LEGAL OPINION OBTAINED GIVE DETAILS</b></td>
            </tr>
            <%
            		ArrayList arrColCollateral=new ArrayList();
					if(arrRowCollateral!=null && arrRowCollateral.size()>0)
					{
						for(int i=0;i<arrRowCollateral.size();i++)
						{
							arrColCollateral = (ArrayList)arrRowCollateral.get(i);
					%>
            <tr> 
              <td width="25%">&nbsp;<%=Helper.correctNull((String)arrColCollateral.get(0))%></td>
              <td width="20%">&nbsp;<%=Helper.correctNull((String)arrColCollateral.get(1))%></td>
              <td align="right" width="10%">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrColCollateral.get(2))))%>&nbsp;</td>
              <td width="21%" >&nbsp;<%=Helper.correctNull((String)arrColCollateral.get(3))%></td>
              <td width="24%" >&nbsp;<%=Helper.correctNull((String)arrColCollateral.get(4))%></td>
            </tr>
            <%
					 }
					 }
				  
               %>
            <%
                	}
                %>
          </table>
        </div>
      </td>
    </tr>
    <tr> 
      <td colspan="3"> 
        <div id="top"> 
          <table width="100%" border="0" cellspacing="0" cellpadding="3">
            <tr> 
              <td colspan="5"><b>PARTICULARS OF LEGAL HEIRS OF OWNERS:</b></td>
            </tr>
            <tr> 
              <td width="20%"><b>NAME</b></td>
              <td width="17%"><b>GENDER</b></td>
              <td width="18%"><b>AGE (Years)</b></td>
              <td width="16%"><b>RELATIONSHIP</b></td>
              <td width="29%"><b>MARITAL STATUS</b></td>
            </tr>
            <%
		ArrayList arrCollegal = new ArrayList();
		ArrayList arrRowlegal = new ArrayList();
										arrCollegal=new ArrayList();
										arrRowlegal=(ArrayList)hsh2.get("arrRow");
										if(arrRowlegal!=null && arrRowlegal.size()>0)
										{
 							    			for(int i=0;i<arrRowlegal.size();i++)
											{
 							    				arrCollegal=(ArrayList)arrRowlegal.get(i);
									%>
            <tr> 
              <td width="20%" align="left">&nbsp;<%=Helper.correctNull((String)arrCollegal.get(2))%></td>
              <td width="17%" align="left">&nbsp; 
                <%if(Helper.correctNull((String)arrCollegal.get(3)).equalsIgnoreCase("M")){
            	out.println("Male");}else if(Helper.correctNull((String)arrCollegal.get(3)).equalsIgnoreCase("F")){ 
            	out.println("Female");} %>
              </td>
              <td width="18%" align="left">&nbsp;<%=Helper.correctNull((String)arrCollegal.get(4))%></td>
              <td width="16%" align="left">&nbsp;<%=Helper.correctNull((String)arrCollegal.get(5))%></td>
              <td width="29%" align="left">&nbsp;<%=Helper.correctNull((String)arrCollegal.get(6))%></td>
            </tr>
            <%
									}
									}
									%>
            <tr> 
              <td width="40%" colspan="2"><b>Restrictions, conditions to be imposed 
                on borrower</b></td>
              <td width="60%" colspan="3"><%=Helper.correctNull((String)hsh9.get("Borrowerrestriction"))%> 
              </td>
            </tr>
          </table>
        </div>
      </td>
    </tr>
    <tr> 
      <td colspan="3"> 
        <div id="top"> 
          <table width="100%" border="0" cellspacing="0" cellpadding="2">
            <%
			  arrRow=(ArrayList)hsh10.get("arrRowgua");
									if(arrRow!=null && arrRow.size()>0)
									{%>
            <tr> 
              <td width="40%"><b>Guarantee offered</b></td>
              <td colspan="2"> Yes </td>
            </tr>
            <tr> 
              <td colspan="3"> 
                <table width="100%" border="0">
                  <tr> 
                    <td width="39%"><B>Name of the Guarantors</B></td>
                    <td width="38%"><b>Address</b></td>
                    <td width="23%"><b>Total Means</b></td>
                  </tr>
                  <%for(int i=0;i<arrRow.size();i++)
								{%>
                  <%arrCol=(ArrayList)arrRow.get(i);
									if(arrCol!=null && arrCol.size()>0)
									{%>
                  <tr> 
                    <td height="15" width="39%"><%=Helper.correctNull((String)arrCol.get(0))%></td>
                    <td height="15" width="38%"><%=Helper.correctNull((String)arrCol.get(2))%><br>
                      <%if(!Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("")){ %>
                      <%=Helper.correctNull((String)arrCol.get(3))%><br>
                      <%} %>
                      <%if(!Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("")){ %>
                      <%=Helper.correctNull((String)arrCol.get(4))%><br>
                      <%} %>
                      <%=Helper.correctNull((String)arrCol.get(5))%><br>
                      <%=Helper.correctNull((String)arrCol.get(6))%><br>
                      <%=Helper.correctNull((String)arrCol.get(7))%><br>
                      <%=Helper.correctNull((String)arrCol.get(8))%></td>
                    <td height="15" width="23%"><%=ApplicationParams.getCurrency()%><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1))))%></td>
                  </tr>
                  <%}}%>
                </table>
              </td>
            </tr>
            <%
                }else {%>
            <tr> 
              <td width="40%"><b>Guarantee offered</b></td>
              <td colspan="2"> No </td>
            </tr>
            <%} %>
            <tr> 
              <td>If renewal</td>
              <td colspan="2"><%=renewal%></td>
            </tr>
            <%if(renewal.equalsIgnoreCase("Yes")){%>
            <tr> 
              <td width="20%"><b>Date of letter of guarantee</b></td>
              <td width="20%"><b>Amount</b></td>
              <td width="20%"><b>Name of the guarantor(s)</b></td>
            </tr>
            <tr> 
              <td width="20%"> <%=Helper.correctNull((String)hsh10.get("adv_guaranteedate")) %></td>
              <td width="20%"> <%=Helper.correctNull((String)hsh10.get("adv_amount")) %></td>
              <td width="40%"> <%=Helper.correctNull((String)hsh10.get("adv_guarantors")) %> 
              </td>
            </tr>
            <%}%>
            <tr> 
              <td colspan="3">Sanction office Comments</td>
            </tr>
            <tr> 
              <td colspan="3"> <%=Helper.correctNull((String)hsh10.get("adv_sanction")) %> 
              </td>
            </tr>
          </table>
        </div>
      </td>
    </tr>
    <tr> 
      <td colspan="3"> 
        <div id="top"> 
          <table width="100%" border="0" cellspacing="0" cellpadding="3">
            <tr> 
              <td colpan="2"><b>Purpose and Period for which accommodation required 
                (for Working Capital requirement)</b></td>
            </tr>
            <tr> 
              <td colpan="2"> <%=Helper.correctNull((String)hshValues.get("advnotesMPBF"))%> 
              </td>
            </tr>
          </table>
        </div>
      </td>
    </tr>
    <tr> 
      <td colspan="3"> 
        <div id="top"> 
          <table width="100%" border="0" cellspacing="0" cellpadding="3">
            <tr> 
              <td colpan="2"><b>Sources of Repayments (in case of term loans)</b></td>
            </tr>
            <tr> 
              <td colpan="2"> <%=Helper.correctNull((String)hshValues.get("advnotesFUA"))%> 
              </td>
            </tr>
          </table>
        </div>
      </td>
    </tr>
    <tr> 
      <td colspan="3"> 
        <div id="top"> 
          <table width="100%" border="0" cellspacing="0" cellpadding="3">
            <tr> 
              <td colspan="6"><b>Facilities enjoyed with other banks /Financial 
                Institutions.</b></td>
            </tr>
            <tr> 
              <td width="35%"><b>Bank/Financial Institution</b></td>
              <td width="25%"><b>Nature of limit</b></td>
              <td width="12%"><b>Amount (<%=ApplicationParams.getCurrency()%>)</b></td>
              <td width="10%"><b>Whether instalments paid up to date</b></td>
              <td width="6%"><b>No. of instalments</b></td>
              <td width="12%"><b>Total amount overdue (<%=ApplicationParams.getCurrency()%>)</b></td>
            </tr>
            <%
          if(hsh15!=null)
          {
          	vecRow=(ArrayList)hsh15.get("vecRow");
          	if(vecRow!=null && vecRow.size()>0)
          	{
          		for(int i=0;i<vecRow.size();i++)
          		{
          		vecCol=(ArrayList)vecRow.get(i);
          		if(vecCol!=null)
          		{
          %>
            <tr> 
              <td> <%=Helper.correctNull((String)vecCol.get(1))%> </td>
              <td> <%=Helper.correctNull((String)vecCol.get(2))%> </td>
              <td align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(3))))%> 
              </td>
              <td align="center"> 
                <%if(Helper.correctNull((String)vecCol.get(4)).equalsIgnoreCase("1")){
            	out.println("Yes"); } else if(Helper.correctNull((String)vecCol.get(4)).equalsIgnoreCase("2")){
            		out.println("No");	
            	}
            %>
              </td>
              <td> <%=Helper.correctNull((String)vecCol.get(5))%> </td>
              <td align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(6))))%> 
              </td>
            </tr>
            <%}
          		}
          }} %>
          </table>
        </div>
      </td>
    </tr>
    <tr> 
      <td colspan="3"> 
        <div id="top"> 
          <table border="0" width="100%" cellspacing="0" cellpadding="3">
            <tr> 
              <td colspan="3"><b>Turnover Particulars Corresponding to the Financial 
                year of the firm/company.</b></td>
            </tr>
            <tr> 
              <td width="20%" align="center" height="1" rowspan="2"><b>Particulars 
                </b></td>
              <td width="24%" align="center" height="1" rowspan="2"><b>Credit</b></td>
            </tr>
            <tr> 
              <td width="24%" align="center" height="1" ><strong>Debit</strong></td>
            </tr>
            <tr> 
              <td width="23%" height="44">Turnover:From <%=Helper.correctNull((String)hsh5.get("ADV_turnoverfrom"))%> 
                To <%=Helper.correctNull((String)hsh5.get("ADV_turnoverto"))%> 
              </td>
              <%
	  	    ArrayList vecrowturnover= new ArrayList();
       		//ArrayList veccolturnover= new ArrayList();
	   		ArrayList vecCol1turnover= new ArrayList();
			ArrayList vecCol2turnover= new ArrayList();
			ArrayList vecCol3turnover= new ArrayList();
			ArrayList vecCol4turnover= new ArrayList();
			ArrayList vecCol5turnover= new ArrayList();
			vecrowturnover =(ArrayList)hsh5.get("vecData");
			
			ArrayList vecRow1turnover= new ArrayList();
			ArrayList veccol1turnover= new ArrayList();
			ArrayList veccol2turnover= new ArrayList();
			ArrayList veccol3turnover= new ArrayList();
			ArrayList veccol4turnover= new ArrayList();
			ArrayList veccol5turnover= new ArrayList();
			ArrayList veccol6turnover= new ArrayList();
			ArrayList veccol7turnover= new ArrayList();
			ArrayList veccol8turnover= new ArrayList();
			ArrayList veccol9turnover= new ArrayList();
			ArrayList veccol10turnover= new ArrayList();
			ArrayList veccol11turnover= new ArrayList();
			ArrayList veccol12turnover= new ArrayList();
			vecRow1turnover =(ArrayList)hsh5.get("vecData1");
	   
	   if(vecrowturnover!=null && vecrowturnover.size()>0)
                            {
		  // out.println("------------------------------------------------------"+vecrowturnover.size());
                            	for(int i=0;i<vecrowturnover.size();i++)
                            	{
                            		vecCol1turnover =(ArrayList)vecrowturnover.get(0);
                            		vecCol2turnover =(ArrayList)vecrowturnover.get(1);
                            		vecCol3turnover =(ArrayList)vecrowturnover.get(2);
                            		vecCol4turnover =(ArrayList)vecrowturnover.get(3);
                            		vecCol5turnover =(ArrayList)vecrowturnover.get(4);
                            	}
                            }
     
                            	%>
              <td width="20%" height="44"> <%=Helper.correctNull((String) vecCol1turnover.get(0))%> 
                Amount (In Lacs) </td>
              <td width="24%" height="44"> <%=Helper.correctNull((String) vecCol1turnover.get(1))%> 
                Amount (In Lacs) </td>
            </tr>
            <%
	 vecrowturnover = (ArrayList) hsh5.get("vecData");
                                	 
                                	  if(vecrowturnover!=null && vecrowturnover.size()>0)
                 						{
                   
                     				%>
            <tr> 
              <td width="23%" height="19">Minimum Balance</td>
              <td width="20%" height="19"> <%=Helper.correctNull((String) vecCol2turnover.get(0))%> 
                Amount (In Lacs) </td>
              <td width="24%" height="19"> <%=Helper.correctNull((String) vecCol2turnover.get(1))%> 
                Amount (In Lacs) </td>
            </tr>
            <tr> 
              <td width="23%" height="19">Average Balance</td>
              <td width="20%" height="19"> <%=Helper.correctNull((String) vecCol3turnover.get(0))%> 
                Amount (In Lacs) </td>
              <td width="24%" height="19"> <%=Helper.correctNull((String) vecCol3turnover.get(1))%> 
                Amount (In Lacs) </td>
            </tr>
            <tr> 
              <td width="23%" height="19">Maximum Balance</td>
              <td width="20%" height="19"> <%=Helper.correctNull((String) vecCol4turnover.get(0))%> 
                Amount (In Lacs) </td>
              <td width="24%" height="19"> <%=Helper.correctNull((String) vecCol4turnover.get(1))%> 
                Amount (In Lacs) </td>
            </tr>
            <tr> 
              <td width="23%" height="38" >No of Days Account was showing Balance</td>
              <td width="20%" height="38"> 
                <% String strdays=Helper.correctNull((String) vecCol5turnover.get(0));
    
    double crdays=Double.parseDouble(strdays);%>
                <%=nf1.format(crdays)%> Days </td>
              <% String strdays1=Helper.correctNull((String) vecCol5turnover.get(1));
    
    double crdays1=Double.parseDouble(strdays1);%>
              <td width="24%" height="19"> <%=nf1.format(crdays1)%> Days </td>
            </tr>
            <%}else{%>
            <tr> </tr>
            <%}%>
          </table>
          <%if(vecRow1turnover!=null && vecRow1turnover.size()>0)
                            {
                            	for(int i=0;i<vecRow1turnover.size();i++)
                            	{
                            		veccol1turnover =(ArrayList)vecRow1turnover.get(0);
                            		veccol2turnover =(ArrayList)vecRow1turnover.get(1);
                            		veccol3turnover =(ArrayList)vecRow1turnover.get(2);
                            		veccol4turnover =(ArrayList)vecRow1turnover.get(3);
                            		veccol5turnover =(ArrayList)vecRow1turnover.get(4);
                            		veccol6turnover =(ArrayList)vecRow1turnover.get(5);
                            		veccol7turnover =(ArrayList)vecRow1turnover.get(6);
                            		veccol8turnover =(ArrayList)vecRow1turnover.get(7);
                            		veccol9turnover =(ArrayList)vecRow1turnover.get(8);
                            		veccol10turnover =(ArrayList)vecRow1turnover.get(9);
                            		veccol11turnover =(ArrayList)vecRow1turnover.get(10);
                            		veccol12turnover =(ArrayList)vecRow1turnover.get(11);
                            	}
                            }
     
                            	%>
          <table border="0" width="100%" cellspacing="0" cellpadding="3">
            <tr> 
              <td colspan="10"><b>(b) Balance Maintained during last 12 months 
                &quot;<%=ApplicationParams.getCurrency()%> in lacs&quot; </b></td>
            </tr>
            <tr> 
              <td width="10%" align="center">&nbsp;</td>
              <td colspan="2" align="center"><b>Credit</b></td>
              <td colspan="2" align="center"><b>Debit</b></td>
              <td width="10%" align="center">&nbsp;</td>
              <td colspan="2" align="center"><b>Credit</b></td>
              <td colspan="2" align="center"><b>Debit</b></td>
            </tr>
            <tr> 
              <td width="10%"><b>Months</b></td>
              <td width="10%" align="center"><b>Amount</b> </td>
              <td width="10%" align="center"><b>Days</b></td>
              <td width="10%" align="center"><b>Amount</b> </td>
              <td width="10%" align="center"><b>Days</b></td>
              <td width="10%"><b>Months</b></td>
              <td width="10%" align="center"><b>Amount</b> </td>
              <td width="10%" align="center"><b>Days</b></td>
              <td width="10%" align="center"><b>Amount </b></td>
              <td width="10%" align="center"><b>Days</b></td>
            </tr>
            <tr> 
              <td width="10%">Jan</td>
              <td width="10%" align="right">&nbsp; <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) veccol1turnover.get(0))))%></td>
              <% String strjan1=Helper.correctNull((String) veccol1turnover.get(1));
     
     double jan1=Double.parseDouble(strjan1);
     %>
              <td width="10%"> <%=nf1.format(jan1)%> </td>
              <td width="10%" align="right"> &nbsp; <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) veccol1turnover.get(2))))%> 
              </td>
              <% String strjan2=Helper.correctNull((String) veccol1turnover.get(3));
     
     double jan2=Double.parseDouble(strjan2);
     %>
              <td width="10%"> <%=nf1.format(jan2)%> </td>
              <td width="10%">July</td>
              <td width="10%" align="right"> &nbsp; <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) veccol2turnover.get(0))))%> 
              </td>
              <% String strjuly1=Helper.correctNull((String) veccol2turnover.get(1));
     
     double july1=Double.parseDouble(strjuly1);
     %>
              <td width="10%"> <%=nf1.format(july1)%> </td>
              <td width="10%" align="right"> &nbsp; <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) veccol2turnover.get(2))))%> 
              </td>
              <% String strjuly2=Helper.correctNull((String) veccol2turnover.get(3));
     
     double july2=Double.parseDouble(strjuly2);
     %>
              <td width="10%"> <%=nf1.format(july2)%> </td>
            </tr>
            <tr> 
              <td width="10%">Feb</td>
              <td width="10%"align="right"> &nbsp; <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) veccol3turnover.get(0))))%> 
              </td>
              <% String strfeb1=Helper.correctNull((String) veccol3turnover.get(1));
     
     double feb1=Double.parseDouble(strfeb1);
     %>
              <td width="10%"> <%=nf1.format(feb1)%> </td>
              <td width="10%" align="right"> &nbsp; <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) veccol3turnover.get(2))))%> 
              </td>
              <% String strfeb2=Helper.correctNull((String) veccol3turnover.get(3));
     
     double feb2=Double.parseDouble(strfeb2);
     %>
              <td width="10%"> <%=nf1.format(feb2)%> </td>
              <td width="10%">Aug.</td>
              <td width="10%" align="right"> &nbsp; <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) veccol4turnover.get(0))))%> 
              </td>
              <% String straug1=Helper.correctNull((String) veccol4turnover.get(1));
     
     double aug1=Double.parseDouble(straug1);
     %>
              <td width="10%"> <%=nf1.format(aug1)%> </td>
              <td width="10%" align="right"> &nbsp; <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) veccol4turnover.get(2))))%> 
              </td>
              <% String straug2=Helper.correctNull((String) veccol4turnover.get(3));
     
     double aug2=Double.parseDouble(straug2);
     %>
              <td width="10%"> <%=nf1.format(aug2)%> </td>
            </tr>
            <tr> 
              <td width="10%">March</td>
              <td width="10%" align="right"> &nbsp; <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) veccol5turnover.get(0))))%> 
              </td>
              <% String strmar1=Helper.correctNull((String) veccol5turnover.get(1));
     
     double mar1=Double.parseDouble(strmar1);
     %>
              <td width="10%"> <%=nf1.format(mar1)%> </td>
              <td width="10%"align="right"> &nbsp; <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) veccol5turnover.get(2))))%> 
              </td>
              <% String strmar2=Helper.correctNull((String) veccol5turnover.get(3));
     
     double mar2=Double.parseDouble(strmar2);
     %>
              <td width="10%"> <%=nf1.format(mar2)%> </td>
              <td width="10%">Sept.</td>
              <td width="10%" align="right"> &nbsp; <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) veccol6turnover.get(0))))%> 
              </td>
              <% String strsep1=Helper.correctNull((String) veccol6turnover.get(1));
     
     double sep1=Double.parseDouble(strsep1);
     %>
              <td width="10%"> <%=nf1.format(sep1)%> </td>
              <td width="10%" align="right"> &nbsp; <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) veccol6turnover.get(2))))%> 
              </td>
              <% String strsep2=Helper.correctNull((String) veccol6turnover.get(3));
     
     double sep2=Double.parseDouble(strsep2);
     %>
              <td width="10%"> <%=nf1.format(sep2)%> </td>
            </tr>
            <tr> 
              <td width="10%">April</td>
              <td width="10%" align="right"> &nbsp; <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) veccol7turnover.get(0))))%> 
              </td>
              <% String strapril1=Helper.correctNull((String) veccol7turnover.get(1));
     
     double april1=Double.parseDouble(strapril1);
     %>
              <td width="10%"> <%=nf1.format(april1)%> </td>
              <td width="10%" align="right"> &nbsp; <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) veccol7turnover.get(2))))%> 
              </td>
              <% String strapril2=Helper.correctNull((String) veccol7turnover.get(3));
     
     double april2=Double.parseDouble(strapril2);
     %>
              <td width="10%"> <%=nf1.format(april2)%> </td>
              <td width="10%">Oct.</td>
              <td width="10%"align="right"> &nbsp; <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) veccol8turnover.get(0))))%> 
              </td>
              <% String stroct1=Helper.correctNull((String) veccol8turnover.get(1));
     
     double oct1=Double.parseDouble(stroct1);
     %>
              <td width="10%"> <%=nf1.format(oct1)%> </td>
              <td width="10%" align="right"> &nbsp; <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) veccol8turnover.get(2))))%> 
              </td>
              <% String stroct2=Helper.correctNull((String) veccol8turnover.get(3));
     
     double oct2=Double.parseDouble(stroct2);
     %>
              <td width="10%"> <%=nf1.format(oct2)%> </td>
            </tr>
            <tr> 
              <td width="10%">May</td>
              <td width="10%" align="right"> &nbsp; <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) veccol9turnover.get(0))))%> 
              </td>
              <% String strmay1=Helper.correctNull((String) veccol9turnover.get(1));
     
     double may1=Double.parseDouble(strmay1);
     %>
              <td width="10%"> <%=nf1.format(may1)%> </td>
              <td width="10%" align="right"> &nbsp; <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) veccol9turnover.get(2))))%> 
              </td>
              <% String strmay2=Helper.correctNull((String) veccol9turnover.get(3));
     
     double may2=Double.parseDouble(strmay2);
     %>
              <td width="10%"> <%=nf1.format(may2)%> </td>
              <td width="10%">Nov.</td>
              <td width="10%" align="right"> &nbsp; <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) veccol10turnover.get(0))))%> 
              </td>
              <% String strnov1=Helper.correctNull((String) veccol10turnover.get(1));
     
     double nov1=Double.parseDouble(strnov1);
     %>
              <td width="10%"> <%=nf1.format(nov1)%> </td>
              <td width="10%" align="right"> &nbsp; <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) veccol10turnover.get(2))))%> 
              </td>
              <% String strnov2=Helper.correctNull((String) veccol10turnover.get(3));
     
     double nov2=Double.parseDouble(strnov2);
     %>
              <td width="10%"> <%=nf1.format(nov2)%> </td>
            </tr>
            <tr> 
              <td width="10%">Jun</td>
              <td width="10%" align="right"> &nbsp; <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) veccol11turnover.get(0))))%> 
              </td>
              <% String strjun1=Helper.correctNull((String) veccol11turnover.get(1));
     
     double jun1=Double.parseDouble(strjun1);
     %>
              <td width="10%"> <%=nf1.format(jun1)%> </td>
              <td width="10%" align="right"> &nbsp; <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) veccol11turnover.get(2))))%> 
              </td>
              <% String strjun2=Helper.correctNull((String) veccol11turnover.get(3));
     
     double jun2=Double.parseDouble(strjun2);
     %>
              <td width="10%"> <%=nf1.format(jun2)%> </td>
              <td width="10%">Dec.</td>
              <td width="10%" align="right"> &nbsp; <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) veccol12turnover.get(0))))%> 
              </td>
              <% String strdec1=Helper.correctNull((String) veccol12turnover.get(1));
     
     double dec1=Double.parseDouble(strdec1);
     %>
              <td width="10%"> <%=nf1.format(dec1)%> </td>
              <td width="10%" align="right"> &nbsp; <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) veccol12turnover.get(2))))%> 
              </td>
              <% String strdec2=Helper.correctNull((String) veccol12turnover.get(1));
     
     double dec2=Double.parseDouble(strdec2);
     %>
              <td width="10%"> <%=nf1.format(dec2)%> </td>
            </tr>
            <tr> 
              <td colspan="10"><b> Sanction Office Comments</b></td>
            </tr>
            <tr> 
              <td colspan="10"><%=Helper.correctNull((String)hsh5.get("ADV_sanction"))%></td>
            </tr>
          </table>
        </div>
      </td>
    </tr>
    <tr> 
      <td colspan="3"> 
        <div id="top"> 
          <table width="100%" border="0" cellspacing="0" cellpadding="3">
            <tr> 
              <td colspan="6"><b>Deposit accounts</b> (Including Family Members)</td>
            </tr>
            <tr> 
              <td colspan="6"><b>(a) Savings</b></td>
            </tr>
            <tr> 
              <td colspan="2"><b>Name</b></td>
              <td colspan="2"><b>S.B A/c no.</b></td>
              <td width="15%"><b>Avg Bal. maintained for the previous 12 months 
                (<%=ApplicationParams.getCurrency()%>)</b></td>
              <td width="25%"><b>Present balance (<%=ApplicationParams.getCurrency()%>)</b></td>
            </tr>
            <%
					ArrayList vecRowdeposit=new ArrayList();
					ArrayList vecColdeposit=new ArrayList();
					vecRowdeposit =(ArrayList)hsh17.get("vecRow");
					if(vecRowdeposit!=null && vecRowdeposit.size()>0)
						{                          	
                            	for(int i=0;i<vecRowdeposit.size();i++)
                            	{
                            		vecColdeposit =(ArrayList)vecRowdeposit.get(i);
                            		
                            		
                    %>
            <tr> 
              <td colspan="2"><%=Helper.correctNull((String)vecColdeposit.get(1))%></td>
              <td colspan="2"><%=Helper.correctNull((String)vecColdeposit.get(2))%></td>
              <td width="15%" align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecColdeposit.get(3))))%></td>
              <td width="25%" align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecColdeposit.get(4))))%></td>
            </tr>
            <%}
                  	} 
                            else 
                            {	%>
            <tr > 
              <td colspan="6">&nbsp;</td>
            </tr>
            <%}

				%>
            <tr> 
              <td colspan="6"><b>(b) Term Deposits</b></td>
            </tr>
            <tr> 
              <td width="15%"><b>Date</b></td>
              <td width="15%"><b>Name</b></td>
              <td width="15%"><b>Amount (<%=ApplicationParams.getCurrency()%>)</b></td>
              <td width="15%"><b>Maturing on</b></td>
              <td width="15%"><b>Unencumbered/Encumbered</b></td>
              <td width="25%"><b>If Encumbered , Explain How</b></td>
            </tr>
            <%
		ArrayList arrColterm = new ArrayList();
		ArrayList arrRowterm = new ArrayList();
										arrColterm=new ArrayList();
										arrRowterm=(ArrayList)hsh4.get("arrRow");
										if(arrRowterm!=null && arrRowterm.size()>0)
										{
 							    			for(int i=0;i<arrRowterm.size();i++)
											{
 							    				arrColterm=(ArrayList)arrRowterm.get(i);
											String Unencumbered=Helper.correctNull((String)arrColterm.get(6));
											
												if(Unencumbered.equalsIgnoreCase("1"))
												{
													Unencumbered="Yes";
												}
												else
												{
													Unencumbered="No";
												}
									%>
            <tr> 
              <td width="15%" align="center">&nbsp;<%=Helper.correctNull((String)arrColterm.get(2))%></td>
              <td width="15%" align="left">&nbsp;<%=Helper.correctNull((String)arrColterm.get(3))%>&nbsp;</td>
              <td width="15%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrColterm.get(4))))%></td>
              <td width="15%" align="center">&nbsp;<%=Helper.correctNull((String)arrColterm.get(5))%></td>
              <td width="15%" align="center">&nbsp;<%=Unencumbered%></td>
              <td width="25%" align="left">&nbsp;<%=Helper.correctNull((String)arrColterm.get(7))%>&nbsp;</td>
            </tr>
            <%
									}
									}
									%>
          </table>
        </div>
      </td>
    </tr>
    <tr > 
      <td colspan="3"> 
        <div id="top"> 
          <table width="100%" border="0" cellspacing="0" cellpadding="3">
            <tr> 
              <td colspan="6"><b>Connected accounts</b>(Other trade names, sister 
                concerns etc)</td>
            </tr>
            <tr> 
              <td width="15%"><b>Name</b></td>
              <td width="15%"><b>Branch</b></td>
              <td width="15%"><b>Limit</b></td>
              <td width="16%"><b>Amount (<%=ApplicationParams.getCurrency()%>)</b></td>
              <td width="20%"><b>Bal. in CD A/C (<%=ApplicationParams.getCurrency()%>)</b></td>
              <td width="19%"><b>Other Deposits , if any</b></td>
            </tr>
            <%
                     ArrayList vecRowconnected=new ArrayList();
					ArrayList vecColconnected=new ArrayList();
                  vecRowconnected=(ArrayList)hsh21.get("vecRow");
					if(vecRowconnected!=null && vecRowconnected.size()>0)
					{
						for(int i=0;i<vecRowconnected.size();i++)
						{
						vecColconnected = (ArrayList)vecRowconnected.get(i);
					%>
            <tr> 
              <td width="15%">&nbsp;<%=Helper.correctNull((String)vecColconnected.get(1))%></td>
              <td width="15%">&nbsp;<%=Helper.correctNull((String)vecColconnected.get(2))%></td>
              <td width="15%">&nbsp;<%=Helper.correctNull((String)vecColconnected.get(3))%>&nbsp;</td>
              <td width="16%" align="right" >&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecColconnected.get(4))))%></td>
              <td width="20%" align="right" >&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecColconnected.get(5))))%></td>
              <td width="19%" align="right" >&nbsp;<%=Helper.correctNull((String)vecColconnected.get(6))%></td>
            </tr>
            <%
					 }
					 }
				  	else
                	{
               %>
            <tr> 
              <td width="15%">&nbsp;</td>
              <td width="15%">&nbsp;</td>
              <td width="15%">&nbsp;</td>
              <td width="16%" align="right" >&nbsp;</td>
              <td width="20%" align="right" >&nbsp;</td>
              <td width="19%" align="right" >&nbsp;</td>
            </tr>
            <%
                	}
                %>
          </table>
        </div>
      </td>
    </tr>
    <tr> 
      <%

String stryears[]={"(i)Limit","(ii)TurnOver","(iii)Maximum Debit","(iv)Minimum Debit","(v)No of Days A/C in Debit",
		"(vi)Avg Debit Balance(Only of last 12 Months)"};


String strmonth[]={"Jan","Feb","March","April","May","June"};
String strmonth1[]={"July","Aug","Sep","Oct","Nov","Dec"};

String stryears1[]={"(vii)Present O/S","(viii)Overdue","(ix)Stocks Last Inspected","(x)Stock Stmt Last received"};
String[] costOfProjectLabel={"Land including development","Building & Other Civil Works ","Plant & Machinery","a) Indigenous","b) Imported","Essential Tools, Spares & Accessories","Testing Equipment ","Miscellaneous Fixed Assets","Erection / Installation charges","Preliminary Expenses","Pre-Operative Expenses ","Provision for Contingencies","a) Building ","b) Plant & Machinery","c) Other Fixed Assets","Margin for Working Capital Required","Total"};

String[] meansOfFinance={"Capital (Specify resources contributin capital)","Reserves","Term Loans (give full articulars)","Unsecured Loans and Deposits (indicate sources, rate of interest, repayment period etc.)","Deferred Payment Arrangements including Supplier's Credit","Subsidy Central Govt. State Govt.","Seed Capital (indicate source)","Internal Cash Accruals","Other Sources (Specify)","Total"};

	ArrayList vecrow1 = new ArrayList();
	ArrayList veccol1 = new ArrayList();
	ArrayList vecrow2 = new ArrayList();
	ArrayList veccol2 = new ArrayList();
	
	ArrayList vecrow = new ArrayList();
	ArrayList veccol = new ArrayList();
%>
      <td colspan="3"> 
        <div id="top"> 
          <table border="0" width="100%" height="100%" cellspacing="0" cellpadding="3">
            <tr> 
              <td width="10%"  align="center" ><b>Working Capital</b></td>
              <td  align="center" colspan="4" ><b>Cash Credit (Pledge)</b></td>
              <td  align="center" colspan="4" ><b>Cash Credit (Hyp)</b></td>
            </tr>
            <tr> 
              <td width="10%"  align="center">&nbsp;</td>
              <td  colspan="2" align="center"><b>Last 12 Month</b></td>
              <td  colspan="2" align="center"><b>Previous 12 Month</b></td>
              <td  colspan="2" align="center"><b>Last 12 Month</b></td>
              <td  colspan="2" align="center"><b>Previous 12 Month</b></td>
            </tr>
            <%
                                	  vecrow = (ArrayList) hsh11.get("vecData");
                                	 
                                	  if(vecrow!=null && vecrow.size()>0)
                 						{
                                		 
                 						
                   							for(int i=0;i<6;i++)
                   							{
                   							
                   							
                   							if(6<=vecrow.size())
                   								
                         					{	
                     							veccol = (ArrayList) vecrow.get(i);
                     				%>
            <tr> 
              <td width="10%"  ><b><%=stryears[i] %></b></td>
              <td colspan="2" align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)veccol.get(0))))%> 
              </td>
              <td colspan="2" align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)veccol.get(1))))%> 
              </td>
              <td colspan="2" align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)veccol.get(2))))%> 
              </td>
              <td colspan="2" align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)veccol.get(3))))%> 
              </td>
            </tr>
            <%}else{%>
            <tr> 
              <td width="10%"  ><b><%=stryears[i] %></b></td>
              <td align="center" colspan="2" >&nbsp; </td>
              <td  align="center"colspan="2" >&nbsp; </td>
              <td  align="center"colspan="2" >&nbsp; </td>
              <td align="center" colspan="2" >&nbsp; </td>
            </tr>
            <%} }}%>
            <tr> 
              <td width="20%" rowspan="7">&nbsp;</td>
              <td width="10%"  align="center" ><b>Month</b></td>
              <td width="10%"  align="center" ><b>Amount</b></td>
              <td width="10%"  align="center" ><b>Month</b></td>
              <td width="10%"  align="center" ><b>Amount</b></td>
              <td width="10%"  align="center" ><b>Month</b></td>
              <td width="10%"  align="center" ><b>Amount</b></td>
              <td width="10%"  align="center" ><b>Month</b></td>
              <td width="10%"  align="center" ><b>Amount</b></td>
            </tr>
            <%
                                	  vecrow1 = (ArrayList) hsh11.get("vecData1");
                                	 
                                	  if(vecrow1!=null && vecrow1.size()>0)
                 						{
                                		 
                 						
                   							for(int i=0;i<6;i++)
                   							{
                   							
                   							
                   							if(6<=vecrow1.size())
                   								
                         					{	
                     							veccol1 = (ArrayList) vecrow1.get(i);
                     				%>
            <tr> 
              <td width="10%"><b><%=strmonth[i] %></b></td>
              <td width="10%" align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)veccol1.get(0))))%> 
              </td>
              <td width="10%"><b><%=strmonth1[i] %></b></td>
              <td width="10%" align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)veccol1.get(1))))%> 
              </td>
              <td width="10%"><b><%=strmonth[i] %></b></td>
              <td width="10%" align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)veccol1.get(2))))%> 
              </td>
              <td width="10%"><b><%=strmonth1[i]%></b></td>
              <td width="10%" align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)veccol1.get(3))))%> 
              </td>
            </tr>
            <%}else{%>
            <tr> 
              <td width="10%"><%=strmonth[i] %></td>
              <td width="10%">&nbsp; </td>
              <td width="10%"><%=strmonth1[i] %></td>
              <td width="10%">&nbsp; </td>
              <td width="10%"><%=strmonth[i] %></td>
              <td width="10%">&nbsp; </td>
              <td width="10%"><%=strmonth1[i] %></td>
              <td width="10%">&nbsp; </td>
            </tr>
            <%} }}%>
            <tr> 
              <td width="10%" ></td>
              <td  colspan="2" align="center"><b>Amount</b></td>
              <td  colspan="2" align="center"><b>Date</b></td>
              <td  colspan="2" align="center"><b>Amount</b></td>
              <td  colspan="2" align="center" width="25%"><b>Date</b></td>
            </tr>
            <%
                                	  vecrow2 = (ArrayList) hsh11.get("vecData2");
                                	 
                                	  if(vecrow2!=null && vecrow2.size()>0)
                 						{
                                		 
                 						
                   							for(int i=0;i<4;i++)
                   							{
                   							
                   							
                   							if(4<=vecrow2.size())
                   								
                         					{	
                     							veccol2 = (ArrayList) vecrow2.get(i);
                     							
                     				%>
            <tr> 
              <td width="10%"><b><%=stryears1[i]%></b></td>
              <td colspan="2" align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)veccol2.get(0))))%> 
              </td>
              <td align="center" colspan="2" > <%=Helper.correctNull((String)veccol2.get(1))%> 
              </td>
              <td colspan="2" align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)veccol2.get(2))))%> 
              </td>
              <td align="center" colspan="2"  width="25%"> <%=Helper.correctNull((String)veccol2.get(3))%> 
              </td>
            </tr>
            <%}else{%>
            <tr> 
              <td width="10%"  ><%=stryears1[i]%></td>
              <td  colspan="2" >&nbsp; </td>
              <td  colspan="2" >&nbsp; </td>
              <td  colspan="2" >&nbsp; </td>
              <td  colspan="2"  width="25%">&nbsp; </td>
            </tr>
            <%} }}%>
          </table>
        </div>
      </td>
    </tr>
    <tr> 
      <td colspan="3"> 
        <div id="top"> 
          <table border="0" width="100%" cellspacing="0" cellpadding="3">
            <tr> 
              <td width="20%" colspan="5"><b>Bill Purchase </b></td>
            </tr>
            <tr> 
              <td align="middle" width="20%">&nbsp;</td>
              <td align="middle" width="20%"><b>Limit</b></td>
              <td align="middle" width="20%"><b>Business</b></td>
              <td align="middle" width="20%"><b>Present O/S</b></td>
              <td align="middle" width="20%"><b>OverDue</b></td>
            </tr>
            <%
                 ArrayList vecRowbill= new ArrayList();
       			 ArrayList vecColbill=null;
                 vecRowbill=(ArrayList)hsh18.get("vecRow");
					if(vecRowbill!=null && vecRowbill.size()>0)
					{
						for(int i=0;i<6;i++)
						{
						vecColbill = (ArrayList)vecRowbill.get(i);
						
					%>
            <tr> 
              <td align="left" widt="20%"><b><%=Helper.correctNull((String)vecColbill.get(5))%></b></td>
              <td widt="20%" align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecColbill.get(1))))%> 
              </td>
              <td widt="20%" align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecColbill.get(2))))%> 
              </td>
              <td widt="20%" align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecColbill.get(3))))%> 
              </td>
              <td widt="20%" align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecColbill.get(4))))%> 
              </td>
            </tr>
            <%
						}
					
					}
							
    %>
            <tr> 
              <td align="left" colspan="5"><b>Sanctioning office comments</b></td>
            </tr>
            <tr> 
              <td  colspan="5"> <%=Helper.correctNull((String)hsh18.get("bill_officeuse"))%> 
              </td>
            </tr>
          </table>
        </div>
      </td>
    </tr>
    <tr > 
      <td colspan="3"> 
        <div id="top"> 
          <table border="0" width="100%" cellspacing="0" cellpadding="3">
            <%
		 	ArrayList disliab=new ArrayList();
			ArrayList disliabcol=new ArrayList();
			disliab=(ArrayList)hshValues.get("listrow");
			
			if(disliab!=null && disliab.size()>0)
			{
				for(int i=0;i<disliab.size();i++)
				{
					disliabcol=(ArrayList)disliab.get(i);
		 			if(Helper.correctNull((String)disliabcol.get(5)).equalsIgnoreCase("0") &&
		 					Helper.correctNull((String)disliabcol.get(4)).equalsIgnoreCase("1")	){
		 	%>
            <tr> 
              <td align="center" width="12%"><b>Liabilities</b></td>
              <td align="center" colspan="4"><b> Guarantees</b> </td>
            </tr>
            <tr> 
              <td align="center">&nbsp;</td>
              <td align="center">&nbsp; </td>
              <td align="center" colspan="2"><b>OutStanding</b></td>
              <td align="center" rowspan="2"><b>Total</b></td>
            </tr>
            <tr> 
              <td align="center">&nbsp; </td>
              <td align="center"><b>Limit</b></td>
              <td align="center"><b>UnSecured</b></td>
              <td align="center"><b>Secured</b></td>
            </tr>
            <tr> 
              <td align="left">INLAND</td>
              <td align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)disliabcol.get(0))))%> 
              </td>
              <td align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)disliabcol.get(1))))%> 
              </td>
              <td align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)disliabcol.get(2))))%> 
              </td>
              <td align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)disliabcol.get(3))))%> 
              </td>
            </tr>
            <%}else if(Helper.correctNull((String)disliabcol.get(5)).equalsIgnoreCase("1") &&
        		  Helper.correctNull((String)disliabcol.get(4)).equalsIgnoreCase("1")){ %>
            <tr> 
              <td align="left" >FOREIGN</td>
              <td align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)disliabcol.get(0))))%> 
              </td>
              <td align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)disliabcol.get(1))))%> 
              </td>
              <td align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)disliabcol.get(2))))%> 
              </td>
              <td align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)disliabcol.get(3))))%> 
              </td>
            </tr>
            <%}else if(Helper.correctNull((String)disliabcol.get(5)).equalsIgnoreCase("2") &&
        		  Helper.correctNull((String)disliabcol.get(4)).equalsIgnoreCase("1")){  %>
            <tr> 
              <td align="left"><b>TOTAL</b></td>
              <td align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)disliabcol.get(0))))%> 
              </td>
              <td align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)disliabcol.get(1))))%> 
              </td>
              <td align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)disliabcol.get(2))))%> 
              </td>
              <td align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)disliabcol.get(3))))%> 
              </td>
            </tr>
            <%} 
		 			if(Helper.correctNull((String)disliabcol.get(5)).equalsIgnoreCase("0") &&
		 					Helper.correctNull((String)disliabcol.get(4)).equalsIgnoreCase("2")	){
		 	%>
            <tr> 
              <td colspan="5">&nbsp;</td>
            </tr>
            <tr> 
              <td align="center" width="12%"><b>Liabilities</b></td>
              <td align="center" colspan="4"><b>D.P. Guarantees</b> </td>
            </tr>
            <tr> 
              <td align="center">&nbsp;</td>
              <td align="center">&nbsp; </td>
              <td align="center" colspan="2"><b>OutStanding</b></td>
              <td align="center" rowspan="2"><b>Total</b></td>
            </tr>
            <tr> 
              <td align="center">&nbsp; </td>
              <td align="center"><b>Limit</b></td>
              <td align="center"><b>UnSecured</b></td>
              <td align="center"><b>Secured</b></td>
            </tr>
            <tr> 
              <td align="left">INLAND</td>
              <td align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)disliabcol.get(0))))%> 
              </td>
              <td align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)disliabcol.get(1))))%> 
              </td>
              <td align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)disliabcol.get(2))))%> 
              </td>
              <td align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)disliabcol.get(3))))%> 
              </td>
            </tr>
            <%}else if(Helper.correctNull((String)disliabcol.get(5)).equalsIgnoreCase("1") &&
        		  Helper.correctNull((String)disliabcol.get(4)).equalsIgnoreCase("2")){ %>
            <tr> 
              <td align="left" >FOREIGN</td>
              <td align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)disliabcol.get(0))))%> 
              </td>
              <td align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)disliabcol.get(1))))%> 
              </td>
              <td align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)disliabcol.get(2))))%> 
              </td>
              <td align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)disliabcol.get(3))))%> 
              </td>
            </tr>
            <%}else if(Helper.correctNull((String)disliabcol.get(5)).equalsIgnoreCase("2") &&
        		  Helper.correctNull((String)disliabcol.get(4)).equalsIgnoreCase("2")){  %>
            <tr> 
              <td align="left" >TOTAL</td>
              <td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)disliabcol.get(0))))%></td>
              <td align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)disliabcol.get(1))))%> 
              </td>
              <td align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)disliabcol.get(2))))%> 
              </td>
              <td align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)disliabcol.get(3))))%> 
              </td>
            </tr>
            <%} 
          %>
            <%}
			} %>
          </table>
        </div>
      </td>
    </tr>
    <tr > 
      <td colspan="3">&nbsp;</td>
    </tr>
    <tr > 
      <td colspan="3"> 
        <div id="top"> 
          <table  width="100%" border="0" cellspacing="0" cellpadding="3">
            <tr> 
              <td width="48%" height="1">Whether Stock/Book Debts/QIS Statement 
                are submitted in time </td>
              <td width="52%" height="1"><%=strstock%></td>
            </tr>
            <tr id="d1"> 
              <td width="48%" >If not,Give Details</td>
              <td width="52%"><%=Helper.correctNull((String)hsh20.get("advcom_details"))%> 
              </td>
            </tr>
            <tbody> 
            <tr> 
              <td width="48%" height="1">Whether Penal interest is charged</td>
              <td width="52%" height="1"><%=strpenalinterest%><br>
              </td>
            </tr>
            <tr> 
              <td width="48%">Whether all stipulations of previous sanction advice 
                have been complied with and the limits utilised accordingly. </td>
              <td width="52%"><%=strsanctionadvice%> </td>
            </tr>
            </tbody> 
            <tr id="d2"> 
              <td width="48%"><br>
                If not, give details with justification. <br>
              </td>
              <td width="52%" ><%=Helper.correctNull((String)hsh20.get("advcom_detailjust"))%></td>
            </tr>
            <tr> 
              <td width="48%">Are limits or drawing power exceeded ? </td>
              <td width="52%"><%=strlimitdrawing%> </td>
            </tr>
            <tr id="d3"> 
              <td width="48%" ><br>
                If Yes, When and to what extent ?<br>
              </td>
              <td width="52%"><%=Helper.correctNull((String)hsh20.get("advcom_drawingextent"))%> 
              </td>
            </tr>
            <tr> 
              <td width="48%"> Sanction Office Comments </td>
              <td width="52%"><%=Helper.correctNull((String)hsh20.get("advcom_sanctionoffuse"))%> 
              </td>
            </tr>
            <tr> 
              <td width="48%"> Whether Cash Withdrawals are frequently made&nbsp;</td>
              <td width="52%"><%=strwithdrwlextent%> </td>
            </tr>
            <tr> 
              <td width="48%" >IF SO, TO WHAT EXTENT ? </td>
              <td width="52%" ><%=Helper.correctNull((String)hsh20.get("advcom_withdrwlextent"))%> 
              </td>
            </tr>
            <tr> 
              <td width="48%" >Purpose of cash withdrawal</td>
              <td width="52%" > <%=strpurposewithdrawl%><br>
                <%=Helper.correctNull((String)hsh20.get("advcom_purposedetails"))%> 
              </td>
            </tr>
          </table>
        </div>
      </td>
    </tr>
    <tr > 
      <td colspan="3"> 
        <div id="top"> 
          <table   border="0" width="100%" cellspacing="0" cellpadding="3">
            <% 
		ArrayList arrayRow = new ArrayList();
			ArrayList arrayCol = new ArrayList();
			arrayRow =(ArrayList)hsh8.get("arrayRow");
		if(arrayRow!=null && arrayRow.size()>0)
				{%>
            <tr> 
              <td colspan="3"><b>Whether the documents stipulated have been obtained, 
                properly executed &amp; valid ?(If yes ,Give the following Details)</b> 
              </td>
              <td colspan="2">Yes </td>
            </tr>
            <tr> 
              <td width="20%" rowspan="2"><b>Nature of limit</b></td>
              <td width="60%" colspan="3" align="center"><b>Documents Obtained</b></td>
              <td width="20%" rowspan="2" align="center"><b>Remarks</b></td>
            </tr>
            <tr> 
              <td width="20%" align="center"><b>Name</b></td>
              <td width="20%" align="center"><b>Amount </b></td>
              <td width="20%" align="center"><b>Date</b></td>
            </tr>
            <%
                  for(int i=0;i<arrayRow.size();i++)
                  {
                   arrayCol =(ArrayList)arrayRow.get(i);
                            	%>
            <tr> 
              <td width="20%"><%=Helper.correctNull((String)arrayCol.get(2))%></td>
              <td width="20%"><%=Helper.correctNull((String)arrayCol.get(3))%></td>
              <td width="20%" align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrayCol.get(4))))%></td>
              <td width="20%"><%=Helper.correctNull((String)arrayCol.get(5))%></td>
              <td width="20%"><%=Helper.correctNull((String)arrayCol.get(6))%></td>
            </tr>
            <%}
                  		} 
				else 
				{%>
            <tr> 
              <td width="47%"><b>Whether the documents stipulated have been obtained, 
                properly executed &amp; valid ?</b> </td>
              <td width="53%">No </td>
            </tr>
            <%}%>
          </table>
        </div>
      </td>
    </tr>
    <tr > 
      <td colspan="3"> 
        <div id="top"> 
          <table width="100%" border="0" cellspacing="0" cellpadding="3">
            <tr> 
              <td width="47%"><b>Experience of borrowers dealings and operation</b></td>
              <td width="53%"> <%=Helper.correctNull((String)hsh9.get("BorrowerExp")) %> 
              </td>
            </tr>
          </table>
        </div>
      </td>
    </tr>
    <tr>
    <td colspan="3"> 
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="top"><b> AUDIT OBSERVATIONS</b></td>
			</tr>
			<tr>
				<td valign="top"><b> Internal Audit<%=Helper.correctNull((String) hshValues
							.get("audit_internal_date"))%>
				</b></td>
			</tr>
			<tr>

				<%arrRow = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrInternal");
			if (arrRow != null && arrRow.size() > 0) {

				%>
				<td valign="top">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">


					<tr>
						<td width="33%" align="center"><b>Auditors Observations</b></td>
						<td width="33%" align="center"><b>Branch Comments</b></td>
						<td width="33%" align="center"><b>Replies/Action Taken/ PresentPosition</b></td>
						
					</tr>
					<%for (int i = 0; i < arrRow.size(); i++) {
					arrCol = new ArrayList();
					arrCol = (ArrayList) arrRow.get(i);

					%>
					<tr>
						<td width="33%" valign="top"><%=Helper.formatTextAreaData((String) arrCol
											.get(0))%>&nbsp;</td>
						<td width="33%" valign="top"><%=Helper.formatTextAreaData((String) arrCol
											.get(1))%>&nbsp;</td>
						<td width="33%" valign="top"><%=Helper.formatTextAreaData((String) arrCol
											.get(2))%>&nbsp;</td>
					</tr>


					<%}%>
				</table>
				</div>
				</td>
				<%} else {%>
				<%=Helper.correctNull((String)hshValues.get("notapplicable"))%>
				<%}

			%>

			</tr>

			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td valign="top"><b> Concurrent Audit<%=Helper.correctNull((String) hshValues
							.get("audit_concurrent_date"))%></b></td>
			</tr>
			<tr>
				<%arrRow = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrConcurrent");
			if (arrRow != null && arrRow.size() > 0) {

				%>
				<td colspan="5" valign="top">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">

					<tr>
						<td width="33%" align="center"><b>Auditors Observations</b></td>
						<td width="33%" align="center"><b>Branch Comments</b></td>
						<td width="33%" align="center"><b>Replies/Action Taken/ PresentPosition</b></td>
						
					</tr>
					<%for (int i = 0; i < arrRow.size(); i++) {
					arrCol = new ArrayList();
					arrCol = (ArrayList) arrRow.get(i);

					%>
					<tr>
						<td width="33%" valign="top"><%=Helper.formatTextAreaData((String) arrCol
											.get(0))%>&nbsp;</td>
						<td width="33%" valign="top"><%=Helper.formatTextAreaData((String) arrCol
											.get(1))%>&nbsp;</td>
						<td width="33%" valign="top"><%=Helper.formatTextAreaData((String) arrCol
											.get(2))%>&nbsp;</td>
					</tr>

					<%}%>
				</table>
				</div>
				</td>
				<%} else {%>
				<%=Helper.correctNull((String)hshValues.get("notapplicable"))%>
				<%}
			%>
			</tr>
			<tr>
				<td colspan="5">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top"><b> Statutory Audit<%=Helper.correctNull((String)hshValues.get("audit_statutory_date"))%></b></td>
			</tr>
			<tr>
			<%arrRow = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrStatutory");
			if (arrRow != null && arrRow.size() > 0) {

				%>
				<td valign="top">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					
					<tr>
						<td width="33%" align="center"><b>Auditors Observations</b></td>
						<td width="33%" align="center"><b>Branch Comments</b></td>
						<td width="33%" align="center"><b>Replies/Action Taken/ PresentPosition</b></td>
						
					</tr>
					<%for (int i = 0; i < arrRow.size(); i++) {
					arrCol = new ArrayList();
					arrCol = (ArrayList) arrRow.get(i);

					%>
					<tr>
						<td width="33%" valign="top"><%=Helper.formatTextAreaData((String) arrCol
											.get(0))%>&nbsp;</td>
						<td width="33%" valign="top"><%=Helper.formatTextAreaData((String) arrCol
											.get(1))%>&nbsp;</td>
						<td width="33%" valign="top"><%=Helper.formatTextAreaData((String) arrCol
											.get(2))%>&nbsp;</td>
					</tr>
					<%}%>
				</table>
				</div>
				</td>
				<%} else {%>
				<%=Helper.correctNull((String)hshValues.get("notapplicable"))%>
				<%}
			%>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td valign="top"><b> RBI Inspection Audit <%=Helper.correctNull((String)hshValues.get("audit_inspection_date"))%></b></td>
			</tr>
			<tr>
			<%arrRow = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrRBI");
			if (arrRow != null && arrRow.size() > 0) {

				%>
				<td valign="top">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					
					<tr>
						<td width="33%" align="center"><b>Auditors Observations</b></td>
						<td width="33%" align="center"><b>Branch Comments</b></td>
						<td width="33%" align="center"><b>Replies/Action Taken/ PresentPosition</b></td>
						
					</tr>
					<%for (int i = 0; i < arrRow.size(); i++) {
					arrCol = new ArrayList();
					arrCol = (ArrayList) arrRow.get(i);

					%>
					<tr>
						<td width="33%" valign="top"><%=Helper.formatTextAreaData((String) arrCol
											.get(0))%>&nbsp;</td>
						<td width="33%" valign="top"><%=Helper.formatTextAreaData((String) arrCol
											.get(1))%>&nbsp;</td>
						<td width="33%" valign="top"><%=Helper.formatTextAreaData((String) arrCol
											.get(2))%>&nbsp;</td>
					</tr>
					<%}%>
				</table>
				</div>
				</td>
				<%} else {%>
				<%=Helper.correctNull((String)hshValues.get("notapplicable"))%>
				<%}
			%>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td valign="top"><b> Stock Audit<%=Helper.correctNull((String)hshValues.get("audit_stock_date"))%></b></td>
			</tr>
			<tr>
			<%arrRow = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrStock");
			if (arrRow != null && arrRow.size() > 0) {

				%>
				<td>
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					
					<tr>
						<td width="33%" align="center"><b>Auditors Observations</b></td>
						<td width="33%" align="center"><b>Branch Comments</b></td>
						<td width="33%" align="center"><b>Replies/Action Taken/ PresentPosition</b></td>
						
					</tr>
					<%for (int i = 0; i < arrRow.size(); i++) {
					arrCol = new ArrayList();
					arrCol = (ArrayList) arrRow.get(i);

					%>
					<tr>
						<td width="33%" valign="top"><%=Helper.formatTextAreaData((String) arrCol
											.get(0))%>&nbsp;</td>
						<td width="33%" valign="top"><%=Helper.formatTextAreaData((String) arrCol
											.get(1))%>&nbsp;</td>
						<td width="33%" valign="top"><%=Helper.formatTextAreaData((String) arrCol
											.get(2))%>&nbsp;</td>
					</tr>
					<%}%>
				</table>
				</div>
				</td>
				<%} else {%>
				<%=Helper.correctNull((String)hshValues.get("notapplicable"))%>
				<%}
			%>
			</tr>
		</table>
    	</td>
    </tr>
    
    <tr > 
      <td colspan="3">&nbsp;</td>
    </tr>
    <tr >
      <td colspan="3"><b>Remarks and recommendation (in every case recommendation 
        must be made quantum recommended)</b></td>
    </tr>
    <tr >
      <td colspan="3"><%=Helper.correctNull((String)hshValues.get("branchcomments")) %></td>
    </tr>
	<tr > 
      <td colspan="3">&nbsp;</td>
    </tr>
     <tr> 
              <td colspan="3"><b>Financial data at a glance</b></td>
            </tr>
    <tr> 
      <td colspan="3"> 
        <div id="top"> 
          <table width="100%" border="0" cellspacing="0" cellpadding="3">
           
            <%
            HashMap hshValueFinancial=new HashMap();
            hshValueFinancial=(HashMap)hshValues.get("hshValueFinancial");
            arrRow = (ArrayList) hshValueFinancial.get("arrRow");
			if (arrRow != null && arrRow.size() > 0) {

				%>
				<%for (int i = 0; i < arrRow.size(); i++) {
				arrCol = new ArrayList();
				arrCol = (ArrayList) arrRow.get(i);
				String strBgcolor = "";
				String strAlign = "";
				if (i < 2) {
					strBgcolor = "#EEEAE3";
					strAlign = "center";
				} else {
					strBgcolor = "";
					strAlign = "right";
				}
				
				%>
				<tr bgcolor="<%=strBgcolor%>">
					<td><%=Helper.correctNull((String) arrCol.get(0))%>&nbsp;</td>
					<%if(!Helper.correctNull((String) arrCol.get(1)).equals("")){ %>
					<td width="13%" align="<%=strAlign%>"><%=Helper.correctNull((String) arrCol.get(1))%>&nbsp;</td>
					<%}if(!Helper.correctNull((String) arrCol.get(2)).equals("")){ %>
					<td width="13%" align="<%=strAlign%>"><%=Helper.correctNull((String) arrCol.get(2))%>&nbsp;</td>
					<%}if(!Helper.correctNull((String) arrCol.get(3)).equals("")){ %>
					<td width="13%" align="<%=strAlign%>"><%=Helper.correctNull((String) arrCol.get(3))%>&nbsp;</td>
					<%}if(!Helper.correctNull((String) arrCol.get(4)).equals("")){ %>
					<td width="13%" align="<%=strAlign%>"><%=Helper.correctNull((String) arrCol.get(4))%>&nbsp;</td>
					<%}if(!Helper.correctNull((String) arrCol.get(5)).equals("")){ %>
					<td width="13%" align="<%=strAlign%>"><%=Helper.correctNull((String) arrCol.get(5))%>&nbsp;</td>
					<%} %>
				</tr>
				<%}
				}
				
				%>
            <%--
	HashMap hshValueFinancial=new HashMap();
	hshValueFinancial=(HashMap)hshValues.get("hshValueFinancial");
	
			 
		 ArrayList vecdesc = (ArrayList)hshValueFinancial.get("vecdesc");
		 ArrayList vectype=(ArrayList)hshValueFinancial.get("vectype");
		 ArrayList vecCuryear = (ArrayList)hshValueFinancial.get("year");
		 //ArrayList vecCuryearHold  = (ArrayList)hshValueFinancial.get("yearhold");
		 ArrayList vecPreyear = (ArrayList)hshValueFinancial.get("prevyear");
		 //ArrayList vecPreyearHold = (ArrayList)hshValueFinancial.get("prevyearhold");
		 ArrayList vecNextyear = (ArrayList)hshValueFinancial.get("nextyear");
		 //ArrayList vecNextyearHold = (ArrayList)hshValueFinancial.get("nextyearhold");
		 ArrayList vecNextyear2 = (ArrayList)hshValueFinancial.get("nextyear2");
		 //ArrayList vecNextyearHold2 = (ArrayList)hshValueFinancial.get("nextyearhold2");
		 //ArrayList vecPreyear1 = (ArrayList)hshValueFinancial.get("prevyear1");
		 ArrayList vecPreyearHold1 = (ArrayList)hshValueFinancial.get("prevyearhold1");
		 
			
		int vecsizeFI=0;

		ArrayList yearval=new ArrayList();
		yearval=(ArrayList)hshValueFinancial.get("yearvalue");
		if(yearval!=null && yearval.size()>0)
		{
		String curYear= Helper.correctNull((String)yearval.get(0));
		String curYearDesc= Helper.correctNull((String)yearval.get(1));
		String pervYear= Helper.correctNull((String)yearval.get(2));
		String prevYearDesc= Helper.correctNull((String)yearval.get(3));
		String nextYear= Helper.correctNull((String)yearval.get(4));
		String nextYearDesc= Helper.correctNull((String)yearval.get(5));
		String pervYear1= Helper.correctNull((String)yearval.get(6));
		String prevYearDesc1= Helper.correctNull((String)yearval.get(7));
		String nextYear2= Helper.correctNull((String)yearval.get(8));
		String nextYearDesc2= Helper.correctNull((String)yearval.get(9));
		
		 String a="",b="",c="",d="",e="";
		 if(curYearDesc.trim().equals("a"))
		 {
			 a="Audited";
		 }
		else if(curYearDesc.trim().equals("u"))
		 {
			 a="Unaudited";
		 }
		 else if(curYearDesc.trim().equals("e"))
		 {
			 a="Estimated";
		 }
		 else if(curYearDesc.trim().equals("p"))
		 {
			 a="Projection";
		 }
		 if(prevYearDesc.trim().equals("a"))
		 {
			 b="Audited";
		 }
		else if(prevYearDesc.trim().equals("u"))
		 {
			 b="Unaudited";
		 }
		 else if(prevYearDesc.trim().equals("e"))
		 {
			 b="Estimated";
		 }
		 else if(prevYearDesc.trim().equals("p"))
		 {
			 b="Projection";
		 }
		  if(nextYearDesc.trim().equals("a"))
		 {
			 c="Audited";
		 }
		else if(nextYearDesc.trim().equals("u"))
		 {
			 c="Unaudited";
		 }
		 else if(nextYearDesc.trim().equals("e"))
		 {
			 c="Estimated";
		 }

		 else if(nextYearDesc.trim().equals("p"))
		 {
			 c="Projection";
		 }
		 if(prevYearDesc1.trim().equals("a"))
		 {
			 d="Audited";
		 }
		else if(prevYearDesc1.trim().equals("u"))
		 {
			 d="Unaudited";
		 }
		 else if(prevYearDesc1.trim().equals("e"))
		 {
			 d="Estimated";
		 }
		 else if(prevYearDesc1.trim().equals("p"))
		 {
			 d="Projection";
		 }
		 if(nextYearDesc2.trim().equals("a"))
		 {
			 e="Audited";
		 }
		 else if(nextYearDesc2.trim().equals("u"))
		 {
			 e="Unaudited";
		 }
		 else if(nextYearDesc2.trim().equals("e"))
		 {
			 e="Estimated";
		 }
		 else if(nextYearDesc2.trim().equals("p"))
		 {
			 e="Projection";
		 }
		 
		 if((!pervYear.trim().equalsIgnoreCase("")) || (!pervYear1.trim().equalsIgnoreCase(""))) {
%>
            <tr class="tblhead"> 
              <td width="28%" align="center">Particulars 
              </td>
              <td colspan="2" align="center" width="30%">Last 
                2 Years</td>
              <td align="center" width="12%" >Current 
                Year </td>
              <td  colspan="2" align="center" width="30%">Next 
                2 Years </td>
            </tr>
            <tr> 
              <td width="28%">&nbsp;</td>
              <td align="center" width="15%"><b><%=pervYear%>&nbsp;</b></td>
              <td align="center" width="15%"><b><%=pervYear1%>&nbsp;</b></td>
              <td align="center" width="12%"><b><%=curYear%>&nbsp;</b></td>
              <td align="center" width="15%"><b><%=nextYear%>&nbsp;</b></td>
              <td align="center" width="15%"><b><%=nextYear2%>&nbsp;</b></td>
            </tr>
            <tr> 
              <td width="28%">&nbsp;</td>
              <td align="center" width="15%" ><b><%=b%>&nbsp;</b></td>
              <td align="center" width="15%"><b><%=d%>&nbsp;</b></td>
              <td align="center" width="12%" ><b><%=a%>&nbsp;</b></td>
              <td align="center" width="15%"><b><%=c%>&nbsp;</b></td>
              <td align="center" width="15%"><b><%=e%>&nbsp;</b></td>
            </tr>
            <%
	  

				if(vecdesc!=null)
				{
					vecsizeFI = vecdesc.size();
				}

				for(int i=0;i<vecsizeFI;i++)
				{
					String desc =Helper.correctNull((String)vecdesc.get(i));
					String type =Helper.correctNull((String)vectype.get(i));
					String col1 =Helper.correctNull((String)vecCuryear.get(i));//3
					//String col2 =Helper.correctNull((String)vecCuryearHold.get(i));
					String col3 = Helper.correctNull((String)vecPreyear.get(i));//1
					//String col4 =Helper.correctNull((String)vecPreyearHold.get(i));
					String col5 =Helper.correctNull((String)vecNextyear.get(i));//4
					//String col6 =Helper.correctNull((String)vecNextyearHold.get(i));
					String col9 =Helper.correctNull((String)vecNextyear2.get(i));//5
					//String col10 =Helper.correctNull((String)vecNextyearHold2.get(i));
					//String col7 =Helper.correctNull((String)vecPreyear1.get(i));
					String col8 =Helper.correctNull((String)vecPreyearHold1.get(i));//2
					
			%>
            <% if(type.trim().equals("HE")|| type.trim().equals("H"))
                  { %>
            <tr> 
              <td width="28%"><%=desc%></td>
              <td width="15%" align="center">&nbsp;</td>
              <td width="15%" align="right">&nbsp;</td>
              <td width="12%" align="center">&nbsp;</td>
              <td width="15%" align="center">&nbsp;</td>
              <td width="15%" align="right">&nbsp;</td>
            </tr>
            <% 
					}
				   else
					{
				%>
            <tr> 
              <td width="28%"><%=desc%></td>
              <td width="15%" align="center">&nbsp;<%=col3%> </td>
              <td width="15%" align="right">&nbsp;<%=col8%> </td>
              <td width="12%" align="center">&nbsp;<%=col1%> </td>
              <td width="15%" align="center">&nbsp;<%=col5%> </td>
              <td width="15%" align="center">&nbsp;<%=col9%> </td>
            </tr>
            <%}
				%>
            <%}	}}							
                --%>
          </table>
        </div>
      </td>
    </tr>
    <tr> 
      <td colspan="3"> 
       <b>Comments on Financials : </b>
    </tr>
    <tr> 
      <td colspan="3"> 
       <%=(Helper.correctNull((String)hshValues.get("advnotesFI")).equals("")?"NIL":Helper.correctNull((String)hshValues.get("advnotesFI")))%>
    </tr>
	<tr>
		<td colspan="3"><b>Comments for Term loan:</b></td>
	</tr>
	<tr>
		<td colspan="3"><b>Cost of project</b></td>
	</tr>
	<tr>
		<td colspan="3">
		<div id="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<%
				int vecrowsize=0;
			vecRow = new ArrayList();
			String costOfProject1="",costOfProject2="",costOfProject3="";
			if(hsh24.size()>0 && hshValues != null)
			{
				vecRow = (ArrayList)hsh24.get("vecRow");
				vecrowsize = vecRow.size();
			
			}
				 int tempJ=0;
			 	if(vecRow!=null)
			 	{	
					for(int tempInt=0;tempInt<costOfProjectLabel.length;tempInt++)
					{
						
						if(tempInt!=2 && tempInt!=11)
						{ 
							
							if(tempJ<vecrowsize)
							{
									vecCol =(ArrayList)vecRow.get(tempJ);
									
									costOfProject1 = Helper.correctNull((String)vecCol.get(2));
									costOfProject2 = Helper.correctNull((String)vecCol.get(3));
									costOfProject3 = Helper.correctNull((String)vecCol.get(4));
									
							}
							else
							{
								costOfProject1 ="0.00";
								costOfProject2 ="0.00";
								costOfProject3 ="0.00";
							}
							tempJ++;
						}
					
					%>
					<tr>
						<%if(tempInt==2 || tempInt==11)
			{%>
						<td colspan="4"><b><%=costOfProjectLabel[tempInt]%></b></td>
						<%}
			else
			{%>
						<td width="40%"><%=costOfProjectLabel[tempInt]%></td>
						<td width="20%"><%=costOfProject1%></td>
						<td width="20%"><%=costOfProject2%></td>
						<td width="20%"><%=costOfProject3%></td>
						<%}%>
					</tr>
					<%}} %>
				</table>
				</div>
				</td>
			</tr>
			<tr>
				<td colspan="3"><b>Comments</b></td>
				
			</tr>
			<tr>
				<td>&nbsp;<%=(Helper.correctNull((String)hsh14.get("adv_costofpro")).equals("")?"NIL":Helper.correctNull((String)hsh14.get("adv_costofpro")))%>
				</td>
			</tr>
			<tr>
				<td colspan="3"><b>Means of finance</b></td>
			</tr>
			<%
				 vecrowsize=0;
			vecRow = new ArrayList();
			 String meansOfProject1="",meansOfProject2="",meansOfProject3="";
			if(hsh25.size()>0 && hshValues != null)
			{
				vecRow = (ArrayList)hsh25.get("vecRow");
				vecrowsize = vecRow.size();
			
			}%>
			<tr>
				<td colspan="3">
				<div  id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<%
				tempJ=0;
			 	
			 	String[] labelText ={"comm1","comm2","comm3","comm4","comm5"};
				for(int tempInt=0;tempInt<meansOfFinance.length;tempInt++)
				{
						
						if(tempInt==2  || tempInt==3 || tempInt==6 || tempInt==8)
						{
							tempJ++;
						}
					 
						
						if(tempInt<vecrowsize)
						{
								vecCol =(ArrayList)vecRow.get(tempInt);
								
								meansOfProject1 = Helper.correctNull((String)vecCol.get(2));
								meansOfProject2 = Helper.correctNull((String)vecCol.get(3));
								meansOfProject3 = Helper.correctNull((String)vecCol.get(4));
								
						}
						else
						{
							meansOfProject1 ="0.00";
							meansOfProject2 ="0.00";
							meansOfProject3 ="0.00";
						}
						
					
					%>
					<tr>
						<td width="30%"><%=meansOfFinance[tempInt]%></td>
						<%if(tempInt==0  || tempInt==2  || tempInt==3 || tempInt==6 || tempInt==8){%>
						<td width="31%"><%=Helper.correctNull((String)hsh25.get(labelText[tempJ]))%></td>
						<%}else{ %>
						<td width="31%">&nbsp;</td>
						<%}%>
						<td width="13%"><%=meansOfProject1%></td>
						<td width="13%"><%=meansOfProject2%></td>
						<td width="13%"><%=meansOfProject3%></td>
					</tr>
					<%} %>
				</table>
				</div>
				</td>
			</tr>
			<tr>
				<td colspan="3"><b>Comments</b></td>
			</tr>
			<tr>
				<td colspan="3"><%=Helper.correctNull((String)hsh14.get("adv_termfinance")).equals("")?"NIL":Helper.correctNull((String)hsh14.get("adv_termfinance"))%>
				</td>
			</tr>
			<tr>
				<td colspan="3"><b>Debt service coverage ratio</b></td>
			</tr>
			<tr>
				<td colspan="3"><%=Helper.correctNull((String)hsh14.get("adv_termcoverage")).equals("")?"NIL":Helper.correctNull((String)hsh14.get("adv_termcoverage"))%>
				</td>
			</tr>
			<tr> 
              <td colspan="3"><b>Comments for Working capital loan</b></td>
            </tr>
	<tr > 
      <td colspan="3"> 
        <div id="top"> 
          <table width="100%" border="0" cellspacing="0" cellpadding="3">
            
            <tr> 
              <td width="47%"> Whether inventory holdings are as per norms. Give 
                actuals vis a vis prescribe norms </td>
              <td width="53%"><%=Helper.correctNull((String)hsh16.get("adv_workinventory")) %> 
              </td>
            </tr>
            <tr> 
              <td width="47%">Deviations in inventory norms. If to be permitted 
                reasons to be given</td>
              <td width="53%"> <%=Helper.correctNull((String)hsh16.get("adv_workdeviation")) %></td>
            </tr>
            <tr> 
              <td width="47%">Method of lending to be applied</td>
              <td width="53%"> <%=Helper.correctNull((String)hsh16.get("adv_worklending")) %></td>
            </tr>
            <tr> 
              <td width="47%">Computation of Permissible bank finance</td>
              <td width="53%"><%=Helper.correctNull((String)hsh16.get("adv_workcomputation")) %> 
              </td>
            </tr>
            <tr> 
              <td width="47%">General observations Recommendations</td>
              <td width="53%"><%=Helper.correctNull((String)hsh16.get("adv_workrecommendation")) %> 
              </td>
            </tr>
          </table>
        </div>
      </td>
    </tr>
    <tr > 
      <td colspan="3">&nbsp;</td>
    </tr>
    <tr>
      	<td>
      		<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0">
      			
       			<%if(arrMailboxComments!=null && arrMailboxComments.size()>0)
          				{%>
          			<tr>
            		<td colspan="3" align="center" class="td_bg"><strong>Recommended for Sanction</strong></td>
       			</tr>	
       				<%
          				for(int i=0; i<arrMailboxComments.size();i++)
          					{
          					ArrayList arrMailBoxCol=new ArrayList();
          					arrMailBoxCol=(ArrayList)arrMailboxComments.get(i);
       					%>
   					 <tr>
			            <td valign="top"><%=arrMailBoxCol.get(0)%>&nbsp;</td>
            			<td valign="top">:&nbsp;</td>
			            <td valign="top"><P><%=arrMailBoxCol.get(1)%>&nbsp;</P></td>
			         </tr>
			          <% 
            			}%>
			            <%}
          				%>
          				</table>
          				</td>
          				</tr>
    <tr > 
      <td colspan="3"> </td>
    </tr>
    <tr > 
      <td colspan="3">&nbsp;</td>
    </tr>
    <tr > 
      <td colspan="3" align="center">SANCTIONED / DECLINED</td>
    </tr>
    <tr > 
      <td colspan="3">&nbsp;</td>
    </tr>
    <tr > 
      <td width="47%"><b>Sanctioning Authority Comments</b></td>
      <td width="53%">&nbsp;</td>
    </tr>
    <tr > 
      <td width="53%" colspan="2"><%=Helper.correctNull((String)hshValues.get("app_sanctioningcomments")) %></td>
    </tr>
    <tr > 
      <td colspan="3">&nbsp;</td>
    </tr>
    <tr > 
      <td colspan="3">&nbsp;</td>
    </tr>
    <tr > 
      <td colspan="3">&nbsp;</td>
    </tr>
    <tr > 
      <td colspan="3">&nbsp;</td>
    </tr>
    <tr > 
      <td colspan="3">&nbsp;</td>
    </tr>
    <tr > 
      <td colspan="3"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td>Regional Manager/Chief Manager </td>
            <td>A.G.M. </td>
            <td>D.G.M. </td>
          </tr>
          <tr> 
            <td colspan="3">&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="3">&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="3">&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="3">&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="3">&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="3">&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="3">&nbsp;</td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</form>
</body>
</html>
