<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />

<%ArrayList arrValues = new ArrayList();

			if (hshValues != null) {
				arrValues = (ArrayList) hshValues.get("arrRow");
			}

			%>
<html>
<head>
<title>Static Data Master Search</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 200;
  overflow: auto;
}
</STYLE>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript">

var appURL = "<%=ApplicationParams.getAppUrl()%>";


function setValues(value1,value2, value3, value4, value5)
{
	
	window.opener.document.forms[0].hidsecid.value=value1;
	window.opener.document.forms[0].txtsecdesc.value=value2;
	window.opener.document.forms[0].txt_nature.value=value3;
	window.opener.document.forms[0].txt_value.value=value4;
	
	window.close();
}



</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css">
</head>
<body bgcolor="#EEEAE3" text="#000000" vlink="#330000" alink="#330000"
	leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<jsp:include page="../share/help.jsp" flush="true"/>

<form name="appform" method="post">
<table width="98%" border="0" cellpadding="5" cellspacing="0"
	 class="outertable border1"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="1">
			
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					bordercolorlight="#EBEBF8" bordercolordark="#82829F">
					<tr>
						<td valign="top">

						<table width="100%" border="0" cellspacing="1" cellpadding="3"
							bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
							<tr bgcolor="#71694F">
								<td width="45%"><font color="#FFFFFF"><b> Security</b></font></td>
								
							</tr>
						</table>
						</td>
					</tr>
					<tr>

						<td valign="top" align="center">
						<DIV class="cellcontainer">

						
                      <table width="100%" border="0" cellspacing="1" cellpadding="2"
							bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
                        <%if (arrValues != null) {
				int arrSize = arrValues.size();
				ArrayList arrCol = null;
				for (int i = 0; i < arrSize; i++) {
					arrCol = new ArrayList();
					arrCol = (ArrayList) arrValues.get(i);

					%>
                        <tr> 
                          <td width="45%"><a
									href="javascript:setValues('<%= Helper.correctNull((String)arrCol.get(0))%>',
                          												'<%= Helper.correctNull((String)arrCol.get(1))%>',
                          												'<%= Helper.correctNull((String)arrCol.get(2))%>',
                          												'<%= Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(3))))%>',
                          												'<%= Helper.correctNull((String)arrCol.get(4))%>',)"><%=Helper.correctNull((String) arrCol.get(1))%></a></td>
                        </tr>
                        <%}

			}

			%>
                        <tr> 
                          <td width="45%">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="45%">&nbsp;</td>
                        </tr>
                      </table>
						</div>
						<table width="10%" border="0" cellspacing="0" cellpadding="3"
							align="center">
							<tr valign="top">
								<td width="20%"><input type=button
									style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
									value="Close" name="closebtn" tabindex="25"
									onClick=window.close()></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

</form>
</body>
</html>
