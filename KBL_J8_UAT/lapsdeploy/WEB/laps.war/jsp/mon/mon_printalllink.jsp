<%@ page import="com.sai.laps.helper.*"%>
<HTML>
<HEAD>
<TITLE>PRINTALL</TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css">
<script language="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function callFunction(page,mon,type)
{
	
	 //document.forms[0].hidBeanGetMethod.value="getMonitoringBorrower";
	 //document.forms[0].hidBeanId.value="borrowersearch";
	 document.forms[0].hidmontype.value = mon;
	  document.forms[0].hidprinttype.value = type;
	// alert("document.forms[0].hidmontype.value"+document.forms[0].hidmontype.value);
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
}

function gotoNavigation()
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/mainnav.jsp";
	document.forms[0].submit();
}




</script>
<style type="text/css">
<!--
a:hover {  color: #FF3300}
-->
</style>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
</HEAD>
<BODY BGCOLOR=#EEEAE3 leftmargin="0" topmargin="0" marginwidth="0"
	marginheight="0">
<form name="myform" method="post" action="">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	bgcolor="#DEDACF">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="top" colspan=5><b><i><font size="3" color="#000000"
					face="Times New Roman">Home -&gt; Monitoring</font></i></b></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	bgcolor="#DEDACF">
	<tr>
		<td></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="5">
	<tr>
		<td valign="top">&nbsp;</td>
		<td align="center">
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td align="center" colspan="4"><font size="3"></font></td>
			</tr>
			<tr>
				<td align="center" colspan="4">&nbsp;</td>
			</tr>
				<tr>
				<td align="center" colspan="4">&nbsp;</td>
			</tr>
				<tr>
				<td align="center" colspan="4">&nbsp;</td>
			</tr>
			<tr>
				<td align="center" colspan="4">
				<table width="60%" border="0" cellspacing="0" cellpadding="5"
					align="center" class="outertable border1">
					<tr>
						<td>

						<!--<table width="100%" border="0" cellspacing="1" cellpadding="3"
							align="center">
							<tr bgcolor="#EEEAE3">
								<td align="center" rowspan="2"><b><A
									HREF="javascript:callFunction('mon_borrowersearch.jsp','MONTHMONITREPORT','MMR')"
									CLASS="blackfont"><font face="MS Sans Serif" size="1">MMR </font></A> </b> &nbsp;</td>
							</tr>
						</table>
						--><table width="100%" border="0" cellspacing="1" cellpadding="3"
							align="center">
							<tr bgcolor="#EEEAE3">
								<td align="center" rowspan="2"><b>
								<A	HREF="javascript:callFunction('mon_borrowersearch.jsp','MONTHMONITREPORT','STOCK')"
									CLASS="blackfont"><font face="MS Sans Serif" size="1">STOCK </font></A> </b> &nbsp;</td>
							</tr>
						</table>
                        
                        <table width="100%" border="0" cellspacing="1" cellpadding="3"
							align="center">
							<tr bgcolor="#EEEAE3">
								<td align="center" rowspan="2"><b>
								<A	HREF="javascript:callFunction('mon_borrowersearch.jsp','MONTHMONITREPORT','BOOK DEBITS')"
									CLASS="blackfont"><font face="MS Sans Serif" size="1">BOOK DEBITS</font></A> </b> &nbsp;</td>
							</tr>
						</table><!--
						   <table width="100%" border="0" cellspacing="1" cellpadding="3"
							align="center">
							<tr bgcolor="#EEEAE3">
								<td align="center" rowspan="2"><b>
								<A	HREF="javascript:callFunction('mon_borrowersearch.jsp','MONTHMONITREPORT','LIMIT REPORT')"
									CLASS="blackfont"><font face="MS Sans Serif" size="1">LIMIT REPORT </font></A> </b> &nbsp;</td>
							</tr>
						</table>
						
						 <table width="100%" border="0" cellspacing="1" cellpadding="3"
							align="center">
							<tr bgcolor="#EEEAE3">
								<td align="center" rowspan="2"><b>
								<A	HREF="javascript:callFunction('mon_borrowersearch.jsp','MONTHMONITREPORT','DOCUMENT REPORT')"
									CLASS="blackfont"><font face="MS Sans Serif" size="1">DOCUMENT REPORT </font></A> </b> &nbsp;</td>
							</tr>
						</table>
						 --><table width="100%" border="0" cellspacing="1" cellpadding="3"
							align="center">
							<tr bgcolor="#EEEAE3">
								<td align="center" rowspan="2"><b>
								<A	HREF="javascript:callFunction('mon_borrowersearch.jsp','MONTHMONITREPORT','INSURANCE REPORT')"
									CLASS="blackfont"><font face="MS Sans Serif" size="1">INSURANCE REPORT </font></A> </b> &nbsp;</td>
							</tr>
						</table>
						<table width="100%" border="0" cellspacing="1" cellpadding="3"
							align="center">
							<tr bgcolor="#EEEAE3">
								<td align="center" rowspan="2"><b><A
									HREF="javascript:callFunction('mon_borrowersearch.jsp','MONTHMONITREPORT','INSPECTION REPORT')"
									CLASS="blackfont"><font face="MS Sans Serif" size="1">INSPECTION REPORT </font></A> </b> &nbsp;</td>
							</tr>
						</table><!--
						<table width="100%" border="0" cellspacing="1" cellpadding="3"
							align="center">
							<tr bgcolor="#EEEAE3">
								<td align="center" rowspan="2"><b>
								<A	HREF="javascript:callFunction('mon_borrowersearch.jsp','MONTHMONITREPORT','CONSORTIUM REPORT')"
									CLASS="blackfont"><font face="MS Sans Serif" size="1">CONSORTIUM REPORT </font></A> </b> &nbsp;</td>
							</tr>
						</table>
                        
                     
						
						
						--></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td colspan="4">&nbsp;</td>
			</tr>
			<tr>
				<td colspan="4">&nbsp;</td>
			</tr>
			<tr>
				<td colspan="4">&nbsp;</td>
			</tr>
			<tr>
				<td colspan="4"><font size="3"><b></b></font></td>
			</tr>
			<tr>
				<td colspan="4"><font size="3"><b><a
					href="javascript:gotoNavigation()"><img
					src="<%=ApplicationParams.getAppUrl()%>img/back.jpg" border=0></a></b></font></td>
			</tr>
		</table>
		</td>
		<td valign="top" align="right">&nbsp;</td>
	</tr>
</table>
	
	<input type="hidden" name="hidBeanId" /> 
	<input type="hidden" name="hidBeanMethod" value="" /> 
	<input type="hidden" name="hidBeanGetMethod" value="" /> 
	<input type="hidden" name="hidSourceUrl" value="" /> 
	<input type="hidden" name="hidmontype" /> 
	<input type="hidden" name="hidprinttype" /> 
</form>
</BODY>
</HTML>
