<%@include file="../share/directives.jsp"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>

<% 
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
//out.print(hshValues);
String strLastMonthYear1=Helper.correctNull((String)hshValues.get("lastmonth1"));
String strLastMonthYear2=Helper.correctNull((String)hshValues.get("lastmonth2"));
String strLastMonthYear3=Helper.correctNull((String)hshValues.get("lastmonth3"));
String strLastMonthYear4=Helper.correctNull((String)hshValues.get("lastmonth4"));
String strLastMonthYear5=Helper.correctNull((String)hshValues.get("lastmonth5"));
String strLastMonthYear6=Helper.correctNull((String)hshValues.get("lastmonth6"));
String strLastMonthYear7=Helper.correctNull((String)hshValues.get("lastmonth7"));
String strLastMonthYear8=Helper.correctNull((String)hshValues.get("lastmonth8"));
String strLastMonthYear9=Helper.correctNull((String)hshValues.get("lastmonth9"));
String strLastMonthYear10=Helper.correctNull((String)hshValues.get("lastmonth10"));
String strLastMonthYear11=Helper.correctNull((String)hshValues.get("lastmonth11"));
String strLastMonthYear12=Helper.correctNull((String)hshValues.get("lastmonth12"));

%>
<%
String strwhtdigiprd=Helper.correctNull((String)hshValues.get("com_whtdigiprd"));
String strwhtdigiprdRat=Helper.correctNull((String)hshValues.get("com_whtdigiprdRat"));
String strPrdType=Helper.correctNull((String)hshValues.get("APP_LOANSUBTYPE_DIGI"));
String strAppno=Helper.correctNull((String)hshValues.get("strAppno"));

%>
<html>


<head>
<title>CBS Data </title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script>
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var url="<%=ApplicationParams.getAppUrl()%>";
var varappno="<%=strAppno%>";
function otherDetails()
{
	 document.forms[0].action=appURL+"action/comratingotherdetails.jsp";
	 document.forms[0].hidBeanId.value = "perapplicant";
	 document.forms[0].hidBeanGetMethod.value = "getotherratingParameters";
	 document.forms[0].submit();
}
function corporaterating()
{

	 document.forms[0].action=appURL+"action/comrating.jsp?strFromN=T";
	 document.forms[0].hidBeanId.value="perapplicant";	
	 document.forms[0].hidBeanGetMethod.value="getRetailrating";
	 document.forms[0].submit();
}
function enableButtons(bool2,bool5)
{	
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdclose.disabled=bool5;
}
function doClose()
{
	var con = ConfirmMsg('100');
	if(con)
	{
		document.forms[0].target="_parent";
		document.forms[0].action=appURL+"action/"+"corppge.jsp";
		document.forms[0].submit();
	}
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
		else if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=val;		
		}
	}

}
function scorecardDetails()
{
	 document.forms[0].action=appURL+"action/msmeScoreCard.jsp";
	 document.forms[0].hidBeanId.value = "MsmeDigitalAppInterface";
	 document.forms[0].hidBeanGetMethod.value = "getScorecardDetails";
	 document.forms[0].submit();

}
function doLoad()
{
disableFields(true);
document.forms[0].cmdsave.disabled = true;
}
function showsecAttached()
{
	var prop = "scrollbars=yes,width=950,height=500,top=100,left=250";
	var url = appURL+"action/ratinghistory.jsp?hidBeanGetMethod=getRatingHistory&hidBeanId=MsmeDigitalAppInterface&AppNO="+varappno;
	window.open(url,"",prop);
	
}
</script>
</head>
<body onload="doLoad()">
<form name="misdet" method="post" class="normal">

<%if (strPrdType.equalsIgnoreCase("PR")){
 if(strCategoryType.equals("DIGI")){  %>
      
    <table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../share/applurllinkerdigi.jsp" flush="true" > 
        <jsp:param name="pageid" value="1" />
        </jsp:include></td>
	</tr>
    <tr> 
		 <td class="page_flow">Home -&gt; Digi Retail -&gt; Application -&gt; Loan Particulars -&gt; Digi Rating</td>
    </tr>
    </table>  
      <lapschoice:application />
      <jsp:include page="../per/applicantTabDigi.jsp" flush="true"> 
             			<jsp:param name="linkid" value="26" />
                        </jsp:include><br>
	</tr>
</table>
 <%} }else if(!strPrdType.equalsIgnoreCase("PR")){
if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
class="outertable">
<tr>
	<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
		<jsp:param name="pageid" value="13" />
		<jsp:param name="subpageid" value="134" />
		<jsp:param name="cattype" value="<%=strCategoryType%>" />
		<jsp:param name="ssitype" value="<%=strSSIType%>" />
	</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
	</td>
</tr>
</table>
<%}else{%>
<%if(strCategoryType.equalsIgnoreCase("CORP") || strCategoryType.equalsIgnoreCase("SME")|| strCategoryType.equalsIgnoreCase("AGR") ){ %>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"  class="outertable"> 
			<tr> 
				<td valign="top" colSpan="5"> 
					<jsp:include page="../com/proposallinks.jsp" flush="true"> 
						<jsp:param name="pageid" value="21" /> 
						<jsp:param name="cattype" value="<%=strCategoryType%>" /> 
						<jsp:param name="ssitype" value="<%=strSSIType%>" /> 
					</jsp:include> 
				</td>
			</tr> 
		</table>
		<%}
 else if (strCategoryType.equalsIgnoreCase("SRE") || strCategoryType.equalsIgnoreCase("OPS") || strCategoryType.equals("STL")){ %>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	    <tr> 
	      <td valign="top"> 
	        <jsp:include page="../share/applurllinkscom.jsp" flush="true">         
	        <jsp:param name="pageid" value="14" />
	        <jsp:param name="cattype" value="<%=strCategoryType%>" />
	        <jsp:param name="ssitype" value="<%=strSSIType%>" />
	        </jsp:include>
	      </td>
	    </tr>
  </table>
  <% }%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"class="outertable">
		<tr>
		 <%if(strSessionModuleType.equals("AGR")){%>
		<td class="page_flow">Home -&gt; Agriculture -&gt; Proposal -&gt; Rating </td>
	<%}else{%>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Proposal -&gt; Rating </td> 
		<%} %>		
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<%} %>
<br>
 <%if(strwhtdigiprd.equals("N") && strwhtdigiprdRat.equals("Y")){%>
 <table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable"><tr>
  <td width="15%" class="sub_tab_inactive"><a href="javascript:scorecardDetails();" <b>Digi Rating</b></a></td>
                  </tr>
   </table> 
  <%} else {%>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
    <tr> 
      <td >
         <table border="0" cellspacing="1" cellpadding="3" align="left" class="outertable" width="30%">
                <tr align="center">                
                 <%if(!strPrdType.equalsIgnoreCase("PC")) {%>  
                   <td width="20%" align="center" class="sub_tab_inactive"><a
					href="javascript:corporaterating();"
					onMouseOut="window.status='';return true;"
					onMouseOver="window.status='Applicant';return true;"> <b>
				Corporate Rating </b></a></td>
				<%} %>
                   <td width="20%" align="center" class="sub_tab_inactive"><a
					href="javascript:otherDetails();"
					onMouseOut="window.status='';return true;"
					onMouseOver="window.status='Applicant';return true;"> <b>
				Previous Rating </b></a></td>
                  <td width="15%" class="sub_tab_active">Digi Rating</td>
                  </tr>
              </table>
        </td>
    </tr>
  </table>     
  <%} }%>
<br>
<iframe height="0" width="0" name="ifrmsubcode" frameborder="0" style="border:0"></iframe>
<iframe height="0" width="0" id="ifrm" frameborder="0" style="border:0" ></iframe>
<iframe height="0" width="0" id="ifrm1" frameborder="0" style="border:0" ></iframe>

<!--  
<table width="98%"  class="outertable" >
<tr>
<td >MSME Digital Scorecard Score: <b><span class="mantatory" ></span></b></td>
<td>
				<input type="text"  name="score" size="15"  value="">
			</td>		
<tr>
<td >Remarks: <b><span class="mantatory" ></span></b></td>
<td>
				<input type="textarea"  name="remarks" size="60"  value="">
			</td>			
</tr>
</table>

<table width="98%"  class="outertable" >
<tr>

<td  <b><span class="mantatory"></span></b></td>
<td><%=Helper.correctNull((String)hshValues.get("prevYear"))%></td> 
</tr>
<tr>
<td >Net Income: <b><span class="mantatory" ></span></b></td>
<td>
				<input type="text" name="net_income" size="15"  value="<%=Helper.correctNull((String)hshValues.get("strNetIncome"))%>">
			</td>
</tr>
<tr>
<td width="15%">Total Operational Revenue: <b><span class="mantatory"></span></b></td>

<td>
				<input type="text"  name="revenue" size="15"  value="<%=Helper.correctNull((String)hshValues.get("strRevenue"))%>">
			</td>

</tr>
<tr>
<td >Total Operational Expenditure: <b><span class="mantatory"></span></b></td>
<td>
		<input type="text"  name="expenditure" size="15"  value="<%=Helper.correctNull((String)hshValues.get("strExpenditure"))%>">
		</td>

</tr>

</table>
<table width="100%"  class="outertable" align="center">
<tr align="center">
<td>
</td>
<td>
<%=strLastMonthYear1%>
</td>
<td>
<%=strLastMonthYear2%>
</td>
<td>
<%=strLastMonthYear3%>
</td>
<td>
<%=strLastMonthYear4%>
</td>
<td>
<%=strLastMonthYear5%>
</td>
<td>
<%=strLastMonthYear6%>
</td>
<td>
<%=strLastMonthYear7%>
</td>
<td>
<%=strLastMonthYear8%>
</td>
<td>
<%=strLastMonthYear9%>
</td>
<td>
<%=strLastMonthYear10%>
</td>
<td>
<%=strLastMonthYear11%>
</td>
<td>
<%=strLastMonthYear12%>
</td>
</tr>
<tr>
<td width="20%">Business Credits <b><span class="mantatory"></span></b></td>
	
			<td>
				<input type="text" tabindex="5" name="business_credit1" size="15"  value="<%=Helper.correctNull((String)hshValues.get("business_credit1"))%>">
			</td>
			<td>
			<input type="text" tabindex="5" name="business_credit2" size="15"  value="<%=Helper.correctNull((String)hshValues.get("business_credit2"))%>">
		</td>
		<td>
		<input type="text" tabindex="5" name="business_credit3" size="15"  value="<%=Helper.correctNull((String)hshValues.get("business_credit3"))%>">
	</td>
	<td>
	<input type="text" tabindex="5" name="business_credit4" size="15"  value="<%=Helper.correctNull((String)hshValues.get("business_credit4"))%>">
</td>
<td>
<input type="text" tabindex="5" name="business_credit5" size="15"  value="<%=Helper.correctNull((String)hshValues.get("business_credit5"))%>">
</td>
<td>
<input type="text" tabindex="5" name="business_credit6" size="15"  value="<%=Helper.correctNull((String)hshValues.get("business_credit6"))%>">
</td>
<td>
	
<input type="text" tabindex="5" name="business_credit7" size="15"  value="<%=Helper.correctNull((String)hshValues.get("business_credit7"))%>">
</td>
<td>
<input type="text" tabindex="5" name="business_credit8" size="15"  value="<%=Helper.correctNull((String)hshValues.get("business_credit8"))%>">
</td>
<td>
<input type="text" tabindex="5" name="business_credit9" size="15"  value="<%=Helper.correctNull((String)hshValues.get("business_credit9"))%>">
</td>
<td>
<input type="text" tabindex="5" name="business_credit10" size="15"  value="<%=Helper.correctNull((String)hshValues.get("business_credit10"))%>">
</td>
<td>
<input type="text" tabindex="5" name="business_credit11" size="15"  value="<%=Helper.correctNull((String)hshValues.get("business_credit11"))%>">
</td>
<td>
<input type="text" tabindex="5" name="business_credit12" size="15"  value="<%=Helper.correctNull((String)hshValues.get("business_credit12"))%>">
</td>
</tr>	
<tr>
<td width="20%">Business Debits <b><span class="mantatory"></span></b></td>

			<td>
				<input type="text" tabindex="5" name="Business_Debits1" size="15"  value="<%=Helper.correctNull((String)hshValues.get("Business_Debits1"))%>">
			</td>
			<td>
			<input type="text" tabindex="5" name="Business_Debits2" size="15"  value="<%=Helper.correctNull((String)hshValues.get("Business_Debits2"))%> ">
		</td>
		<td>
		<input type="text" tabindex="5" name="Business_Debits3" size="15"  value="<%=Helper.correctNull((String)hshValues.get("Business_Debits3"))%> ">
	</td>
	<td>
	<input type="text" tabindex="5" name="Business_Debits4" size="15"  value="<%=Helper.correctNull((String)hshValues.get("Business_Debits4"))%> ">
</td>
<td>
<input type="text" tabindex="5" name="Business_Debits5" size="15"  value="<%=Helper.correctNull((String)hshValues.get("Business_Debits5"))%>">
</td>
<td>
<input type="text" tabindex="5" name="Business_Debits6" size="15"  value="<%=Helper.correctNull((String)hshValues.get("Business_Debits6"))%>">
</td>
<td>
<input type="text" tabindex="5" name="Business_Debits7" size="15"  value="<%=Helper.correctNull((String)hshValues.get("Business_Debits7"))%> ">
</td>
<td>
<input type="text" tabindex="5" name="Business_Debits8" size="15"  value="<%=Helper.correctNull((String)hshValues.get("Business_Debits8"))%>">
</td>
	
<td>
<input type="text" tabindex="5" name="Business_Debits9" size="15"  value="<%=Helper.correctNull((String)hshValues.get("Business_Debits9"))%>">
</td>
<td>
<input type="text" tabindex="5" name="Business_Debits10" size="15"  value="<%=Helper.correctNull((String)hshValues.get("Business_Debits10"))%> ">
</td>
<td>
<input type="text" tabindex="5" name="Business_Debits11" size="15"  value="<%=Helper.correctNull((String)hshValues.get("Business_Debits11"))%>">
</td>
<td>
<input type="text" tabindex="5" name="Business_Debits12" size="15"  value="<%=Helper.correctNull((String)hshValues.get("Business_Debits12"))%>">
</td>
</tr>	
<tr>
<td width="20%">Credit Counts <b><span class="mantatory"></span></b></td>
		
			<td>
				<input type="text" tabindex="5" name="Credit_Counts1" size="15"  value="<%=Helper.correctNull((String)hshValues.get("Credit_Counts1"))%> ">
			</td>
			<td>
			<input type="text" tabindex="5" name="Credit_Counts2" size="15"  value="<%=Helper.correctNull((String)hshValues.get("Credit_Counts2"))%>">
		</td>
		<td>
		<input type="text" tabindex="5" name="Credit_Counts3" size="15"  value="<%=Helper.correctNull((String)hshValues.get("Credit_Counts3"))%>">
	</td>
	<td>
	<input type="text" tabindex="5" name="Credit_Counts4" size="15"  value="<%=Helper.correctNull((String)hshValues.get("Credit_Counts4"))%> ">
</td>
<td>
	<input type="text" tabindex="5" name="Credit_Counts5" size="15"  value="<%=Helper.correctNull((String)hshValues.get("Credit_Counts5"))%> ">
</td>
<td>
	<input type="text" tabindex="5" name="Credit_Counts6" size="15"  value="<%=Helper.correctNull((String)hshValues.get("Credit_Counts6"))%>">
</td>
	
		
</tr>	
<tr>
<td width="20%">Credits <b><span class="mantatory"></span></b></td>
			

			
			<td>
				<input type="text" tabindex="5" name="Credits1" size="15"  value="<%=Helper.correctNull((String)hshValues.get("Credits1"))%> ">
			</td>
			<td>
			<input type="text" tabindex="5" name="Credits2" size="15"  value="<%=Helper.correctNull((String)hshValues.get("Credits2"))%>">
		</td>
		<td>
		<input type="text" tabindex="5" name="Credits3" size="15"  value="<%=Helper.correctNull((String)hshValues.get("Credits3"))%>">
	</td>
	<td>
	<input type="text" tabindex="5" name="Credits4" size="15"  value="<%=Helper.correctNull((String)hshValues.get("Credits4"))%> ">
</td>
<td>
	<input type="text" tabindex="5" name="Credits5" size="15"  value="<%=Helper.correctNull((String)hshValues.get("Credits5"))%>">
</td>
<td>
	<input type="text" tabindex="5" name="Credits6" size="15"  value="<%=Helper.correctNull((String)hshValues.get("Credits6"))%>">
</td>

</tr>			
<tr>
<td width="20%">Debit Counts <b><span class="mantatory"></span></b></td>
	
		 	
			<td>
				<input type="text" tabindex="5" name="Debit_Counts1" size="15"  value="<%=Helper.correctNull((String)hshValues.get("Debit_Counts1"))%>">
			</td>
			<td>
			<input type="text" tabindex="5" name="Debit_Counts2" size="15"  value="<%=Helper.correctNull((String)hshValues.get("Debit_Counts2"))%>">
		</td>
		<td>
		<input type="text" tabindex="5" name="Debit_Counts3" size="15"  value="<%=Helper.correctNull((String)hshValues.get("Debit_Counts3"))%>">
	</td>
	<td>
	<input type="text" tabindex="5" name="Debit_Counts4" size="15"  value="<%=Helper.correctNull((String)hshValues.get("Debit_Counts4"))%>">
</td>
<td>
	<input type="text" tabindex="5" name="Debit_Counts5" size="15"  value="<%=Helper.correctNull((String)hshValues.get("Debit_Counts5"))%>">
</td>
<td>
	<input type="text" tabindex="5" name="Debit_Counts6" size="15"  value="<%=Helper.correctNull((String)hshValues.get("Debit_Counts6"))%>">
</td>

</tr>			
<tr>
<td width="20%">Debits <b><span class="mantatory"></span></b></td>
	
			<td>
				<input type="text" tabindex="5" name="Debits1" size="15"  value="<%=Helper.correctNull((String)hshValues.get("Debits1"))%>">
			</td>
			<td>
			<input type="text" tabindex="5" name="Debits2" size="15"  value="<%=Helper.correctNull((String)hshValues.get("Debits2"))%>">
		</td>
		<td>
		<input type="text" tabindex="5" name="Debits3" size="15"  value="<%=Helper.correctNull((String)hshValues.get("Debits3"))%> ">
	</td>
	<td>
	<input type="text" tabindex="5" name="Debits4" size="15"  value="<%=Helper.correctNull((String)hshValues.get("Debits4"))%>">
</td>
<td>
	<input type="text" tabindex="5" name="Debits5" size="15"  value="<%=Helper.correctNull((String)hshValues.get("Debits5"))%> ">
</td>
<td>
	<input type="text" tabindex="5" name="Debits6" size="15"  value="<%=Helper.correctNull((String)hshValues.get("Debits6"))%> ">
</td>

</tr>					
</table>
<table class="outertable" >
<tr>
<td width="38%">Credits Count Last 12 Months <b><span class="mantatory"></span></b></td>
			

			
			<td>
				<input type="text" tabindex="5" name="credit_count_12month" size="15"  value="<%=Helper.correctNull((String)hshValues.get("credit_count_12month"))%> ">
			</td>
			</tr>
<tr>
<td width="38%">Debits Count Last 12 Months <b><span class="mantatory"></span></b></td>
			

			
			<td>
				<input type="text" tabindex="5" name="debit_Count_12months" size="15"  value="<%=Helper.correctNull((String)hshValues.get("debit_Count_12months"))%>">
			</td>
			</tr>
			
<tr>
<td width="38%">Inwards return Count Last 9 Months <b><span class="mantatory"></span></b></td>
			

			
			<td>
				<input type="text" tabindex="5" name="inward_return" size="15"  value="<%=Helper.correctNull((String)hshValues.get("inward_return"))%>">
			</td>
			</tr>		
			
<tr>
<td></td>

<td><%=Helper.correctNull((String)hshValues.get("earningYear"))%></td>
</tr>
<tr>
<td width="38%">Earning Before Interest and Tax(EBIT) <b><span class="mantatory"></span></b></td>
			
			<td>                                                                                                                                                                                                                                                                                     
				<input type="text" tabindex="5" name="Earining3" size="15"  value="<%=Helper.correctNull((String)hshValues.get("Earining1"))%>">
			</td>
			
			</tr>				
			
</table> -->

<table align="center" width="55%" border="1" cellspacing="0" cellpadding="0">
<tr class="datagrid">
<td  >CIBIL Commercial Bureau Score: <b><span class="mantatory" ></span></b></td>
<td>
				<input type="text"  name="score" size="15"  value="<%=Helper.correctNull((String)hshValues.get("COMMERCIAL_BUREAU_SCORE"))%>">
			</td>		
<tr>

<tr class="datagrid">
<td >CIBIL Consumer Individual Score: <b><span class="mantatory" ></span></b></td>
<td>
				<input type="text"  name="score" size="15"  value="<%=Helper.correctNull((String)hshValues.get("CONSUMER_IND_SCORE"))%>">
			</td>		
<tr>

<tr class="datagrid">
<td >CIBIL Consumer Related Party Score: <b><span class="mantatory" ></span></b></td>
<td>
				<input type="text"  name="score" size="15"  value="<%=Helper.correctNull((String)hshValues.get("CONSUMER_PARTY_SCORE"))%>">
			</td>		
<tr>

<tr class="datagrid">
<td >OD Account Score: <b><span class="mantatory" ></span></b></td>
<td>
				<input type="text"  name="score" size="15"  value="<%=Helper.correctNull((String)hshValues.get("OD_ACCOUNT_SCORE"))%>">
			</td>		
<tr>

<tr class="datagrid">
<td >Current Account Score: <b><span class="mantatory" ></span></b></td>
<td>
				<input type="text"  name="score" size="15"  value="<%=Helper.correctNull((String)hshValues.get("CURRENT_ACCOUNT_SCORE"))%>">
			</td>		
<tr>

<tr class="datagrid">
<td >FSA Score: <b><span class="mantatory" ></span></b></td>
<td>
				<input type="text"  name="score" size="15"  value="<%=Helper.correctNull((String)hshValues.get("FSA_SCORE"))%>">
			</td>		
<tr>

<tr class="datagrid">
<td >Band Rating: <b><span class="mantatory" ></span></b></td>
<td>
				<input type="text"  name="score" size="15"  value="<%=Helper.correctNull((String)hshValues.get("BAND_RATING"))%>">
			</td>		
<tr>

<tr class="datagrid">
<td >Band Path: <b><span class="mantatory" ></span></b></td>
<td>
				<input type="text"  name="score" size="60"  value="<%=Helper.correctNull((String)hshValues.get("BAND_PATH"))%>">
			</td>		
<tr>

<tr class="datagrid">
<td > KB Rating: <b><span class="mantatory" ></span></b></td>
<td>
				<input type="text"  name="score" size="15"  value="<%=Helper.correctNull((String)hshValues.get("KB_RATING"))%>">
			</td>		
<tr>

<tr class="datagrid">
<td > Financial Type: <b><span class="mantatory" ></span></b></td>
<td>
				<input type="text"  name="score" size="15"  value="<%=Helper.correctNull((String)hshValues.get("FINANCIAL_TYPE"))%>">
			</td>		
<tr>

<tr class="datagrid">
<td > Financial Year: <b><span class="mantatory" ></span></b></td>
<td>
				<input type="text"  name="score" size="15"  value="<%=Helper.correctNull((String)hshValues.get("FINANCIAL_YEAR"))%>">
			</td>		
<tr>
</table>


</br>
<div align="center">
<input type="button" size="5" name="btnsecModHis" value="Rating History" class="buttonOthers" onclick="showsecAttached()"> 
<input type="button" name="cmdclose" value="Close" class="buttonClose" onClick="doClose()">
<input type="hidden" name="cmdsave"></div>
<lapschoice:hiddentag pageid='<%=PageId%>'/>

</form>
</body>
</html>