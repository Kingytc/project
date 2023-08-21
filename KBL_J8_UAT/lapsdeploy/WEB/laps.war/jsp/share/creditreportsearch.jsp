<%@ page import="com.sai.laps.helper.*" %>
<jsp:useBean id="strOrgLevel" class="java.lang.String" scope="session" />
<jsp:useBean id="strGroupRights" class="java.lang.String" scope="session" />
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld" %>
<%@ page import="java.util.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />

<%
ArrayList arrValues = new ArrayList();
String strright="";
if (hshValues != null) {
	arrValues = (ArrayList) hshValues.get("arryRow");
}

if(strGroupRights.length() > 0)
{
	int len = strGroupRights.length();
	strright = strGroupRights.substring(18,19);
}

String strSaral = Helper.correctNull((String) request.getParameter("hidsaral"));
			%>

<html>
<head>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varOrgLevel="<%=strOrgLevel%>";
var varright="<%=strright%>";

function setValues(val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val12,val13,val14,val15,val16,val17,val18)
{

	window.opener.document.forms[0].txt_crname.value=val2;
	window.opener.document.forms[0].txt_fname.value=val3;
	window.opener.document.forms[0].txt_offadd.value=val5;
	window.opener.document.forms[0].txt_offtel.value=val6;
	window.opener.document.forms[0].txt_resadd.value=val7;
	window.opener.document.forms[0].txt_restel.value=val8;
	window.opener.document.forms[0].txt_permadd.value=val9;
	window.opener.document.forms[0].txt_permtel.value=val10;
	if(val12=='1')
	{
		window.opener.document.forms[0].chk_minor.checked=true;
		window.opener.document.forms[0].chk_scst.checked=false;
		window.opener.document.forms[0].chkMinor.value='1';
	}
	else if(val12=='2')
	{
		window.opener.document.forms[0].chk_scst.checked=true;
		window.opener.document.forms[0].chk_minor.checked=false;
		window.opener.document.forms[0].chkMinor.value='2';
	}
	else
	{
		window.opener.document.forms[0].chk_scst.checked=false;
		window.opener.document.forms[0].chk_minor.checked=false;
		window.opener.document.forms[0].chkMinor.value='0';
	}
	
	if(val13=='1')
	{
		window.opener.document.forms[0].chk_agr.checked=true;
		window.opener.document.forms[0].chk_nonagr.checked=false;
		window.opener.document.forms[0].chkAgri.value='1';
	}
	else if(val13=='2')
	{
	   window.opener.document.forms[0].chk_nonagr.checked=true;
	   window.opener.document.forms[0].chk_agr.checked=false;
	   window.opener.document.forms[0].chkAgri.value='2';
	}
	else
	{
		window.opener.document.forms[0].chk_nonagr.checked=false;
		window.opener.document.forms[0].chk_agr.checked=false;
		window.opener.document.forms[0].chkAgri.value='0';
	}
		
	window.opener.document.forms[0].hid_slno.value=val14;	
	window.opener.document.forms[0].txt_mainbussiness.value=val15;
	window.opener.document.forms[0].txt_sideline.value=val16;
	if(val17!="")
	{
		window.opener.document.forms[0].txt_constitution.value=val17;
	}
	window.opener.document.forms[0].txt_established.value=val18;

	<% if (strSaral.equalsIgnoreCase("saral")){ %>
	window.opener.document.forms[0].cmdnew.disabled=true;
	<%}else if(!strOrgLevel.equalsIgnoreCase("D")){ %>
	
	if(varOrgLevel=='A' && varright=='w'){	
	
		window.opener.document.forms[0].cmdedit.disabled=false;
	}
	else{ 
		  
		window.opener.document.forms[0].cmdedit.disabled=true;
	}
	<%}%>
	window.opener.varrecordflag="Y";
	window.close();
}

</SCRIPT>
	<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css" />
</head>
<body >
<form name="productlisthelp" method="post" class = "normal">
  <table width="100%" border="0" cellpadding="3" cellspacing="0"
	class="outertable border1">
	<tr>
		<td valign="top">
        <table width="100%" border="0" cellspacing="1" cellpadding="5" align="center" class="outertable">
          <tr> 
            <td> 
             <DIV class="cellcontainer">
						<table width="100%" border="0" cellspacing="1" cellpadding="2"
						class="outertable">
							<tr class="dataHeader">
								<td width="10%"><b>Sno</b></td>
								<td width="45%"><b>Name</b></td>
							</tr >
							<%if (arrValues != null) {
				int arrSize = arrValues.size();
				ArrayList arrCol = null;
				for (int i = 0; i < arrSize; i++) {
					arrCol = new ArrayList();
					if (arrCol != null) {
						arrCol = (ArrayList) arrValues.get(i);

						%>
							<tr class="dataGrid">

								<td width="10%"><%=i + 1%></td>
								<td width="45%"><a
									href="javascript:setValues(
								'<%= Helper.replaceForJavaScriptString((String)arrCol.get(0))%>','<%= Helper.replaceForJavaScriptString((String)arrCol.get(1))%>',
								'<%= Helper.replaceForJavaScriptString((String)arrCol.get(2))%>','<%= Helper.replaceForJavaScriptString((String)arrCol.get(3))%>',
								'<%= Helper.replaceForJavaScriptString(Helper.correctDoubleQuotesScript((String)arrCol.get(4)))%>','<%= Helper.replaceForJavaScriptString((String)arrCol.get(5))%>',
                                '<%= Helper.replaceForJavaScriptString(Helper.correctDoubleQuotesScript((String)arrCol.get(6)))%>','<%= Helper.replaceForJavaScriptString((String)arrCol.get(7))%>',
                                '<%= Helper.replaceForJavaScriptString(Helper.correctDoubleQuotesScript((String)arrCol.get(8)))%>','<%= Helper.replaceForJavaScriptString((String)arrCol.get(9))%>',
                                '<%= Helper.replaceForJavaScriptString((String)arrCol.get(10))%>','<%= Helper.replaceForJavaScriptString((String)arrCol.get(11))%>',
                                '<%= Helper.replaceForJavaScriptString((String)arrCol.get(12))%>','<%= Helper.replaceForJavaScriptString((String)arrCol.get(13))%>',
                                '<%= Helper.replaceForJavaScriptString((String)arrCol.get(14))%>','<%= Helper.replaceForJavaScriptString((String)arrCol.get(15))%>',                                
                                '<%= Helper.replaceForJavaScriptString((String)arrCol.get(16))%>','<%= Helper.replaceForJavaScriptString((String)arrCol.get(17))%>')">
                                 <%=Helper.correctNull((String) arrCol.get(1))%></a>
								</td>
							</tr>
							<%}
				}

			}

			%>
							<tr class="dataGrid">
								<td width="10%">&nbsp;</td>
								<td width="45%">&nbsp;</td>
								
							</tr>
							<tr class="dataGrid">
								<td width="10%">&nbsp;</td>
								<td width="45%">&nbsp;</td>
							
							</tr>
														
						</table>
						</div>
            </td>
          </tr>
          
        </table>
      </td>
	</tr>
</table>
  <input type="hidden" name="hidBeanMethod" value="">
  <input type="hidden" name="hidBeanId" value="">
  <input type="hidden" name="hidBeanGetMethod" value="">
  <input type="hidden" name="hidid">

  
</form>
</body>
</html>
