<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<%request.setAttribute("_cache_refresh", "true");

			%>

<%if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues; 
			}
			double effetivenetworth = 0.00;
		
			java.text.NumberFormat nf = java.text.NumberFormat
					.getNumberInstance();
			nf.setGroupingUsed(false);
			nf.setMaximumFractionDigits(2);
			nf.setMinimumFractionDigits(2);


			String totappmov = nf.format(Double.parseDouble(Helper
						.correctDouble((String) hshValues.get("totmova1")))
					+Double.parseDouble(Helper
						.correctDouble((String) hshValues.get("totmova2")))
					+ Double.parseDouble(Helper
							.correctDouble((String) hshValues.get("mov3a")))
					+ Double.parseDouble(Helper
							.correctDouble((String) hshValues.get("permova"))));
			
			String totappimov = nf.format(Double.parseDouble(Helper
					.correctDouble((String) hshValues.get("perimova"))));
			
			String totassapp = nf.format(Double.parseDouble(totappmov)
					+ Double.parseDouble(totappimov));
			
			String liaapp = nf.format(Double.parseDouble(Helper
					.correctDouble((String) hshValues.get("totliaa"))));
			String netapp = nf.format(Double.parseDouble(totassapp)
					- Double.parseDouble(liaapp));
			effetivenetworth = Double.parseDouble(netapp);
	%>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>

<script language="JavaScript">
var appURL="<%=ApplicationParams.getAppUrl()%>";
function callBankAccounts()
{
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].action=appURL+"action/perfinancialbnkacc.jsp";
	document.forms[0].submit();
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/persearch.jsp";
		document.forms[0].submit();
	}
}

function callInsurancePolicy()
{
	document.forms[0].hidBeanGetMethod.value="getPolicy";
	document.forms[0].action=appURL+"action/perfinancialinspol.jsp";
	document.forms[0].submit();	
}

function callPersonalProp()
{
	document.forms[0].hidBeanGetMethod.value="getProperty";
	document.forms[0].action=appURL+"action/perfinancialperpro.jsp";
	document.forms[0].submit();	
}

function callLiabilities()
{	
	document.forms[0].hidBeanGetMethod.value="getLiability";
	document.forms[0].action=appURL+"action/perfinancialliab.jsp";
	document.forms[0].submit();	
}

function callLifeStyle()
{	
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].action=appURL+"action/perlifestyle.jsp";
	document.forms[0].submit();
}

function callInvestment()
{
	document.forms[0].hidBeanGetMethod.value="getInvestMent";
	document.forms[0].action=appURL+"action/perfinancialinvst.jsp";
	document.forms[0].submit();	
}

</script>
</head>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
<body bgcolor="#EEEAE3" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="finForm" action="" method="post">
<table width="100%" border="1" cellspacing="0" cellpadding="0"
	bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
	<tr>
		<td id="mainlnk" colspan="2"><jsp:include
			page="../share/Applurllinkper.jsp" flush="true">
			<jsp:param name="pageid" value="3" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		
      <td><font face="Times New Roman" size="3"><b><i>Home -&gt; Retail -&gt; 
        <%=(String) session.getAttribute("pgeLabel")%> -&gt; Credit Information 
        -&gt; Networth</i></b></font></td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><lapschoice:application /></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	bgcolor="#DEDACF">
	<tr>
		<td width="90%" valign="bottom">
		<table width="100%" border="0" cellspacing="3" cellpadding="3"
			align="left">
			<tr>
				<td width="20%" align="center" bgcolor="#EEEAE3"><font
					face="MS Sans Serif" size="1"><b><a
					href="JavaScript:callBankAccounts()" class="blackfont">Saving/Current 
              Account maintained with Banks</a></b></font></td>
				<td width="20%" align="center" bgcolor="#EEEAE3"><b><font size="1"
					face="MS Sans Serif"><a href="JavaScript:callInvestment()"
					class="blackfont">Investments/Term Deposits</a></font></b></td>
				<td width="15%" align="center" bgcolor="#EEEAE3"><b><font size="1"
					face="MS Sans Serif"><a href="JavaScript:callInsurancePolicy()"
					class="blackfont">Insurance Policies</a></font></b></td>
				<td width="20%" align="center" bgcolor="#EEEAE3"><b><font size="1"
					face="MS Sans Serif"><a href="JavaScript:callPersonalProp()"
					class="blackfont">Movable/Immovable Assets </a></font></b></td>
				<td width="10%" align="center" bgcolor="#EEEAE3"><b><font size="1"
					face="MS Sans Serif"><a href="JavaScript:callLiabilities()"
					class="blackfont">Liabilities</a></font></b></td>
				<td width="7%" align="center" bgcolor="#EEEAE3"><b><font size="1"
					face="MS Sans Serif"><a href="JavaScript:callLifeStyle()"
					class="blackfont">LifeStyle</a></font></b></td>
				<td width="8%" align="center" bgcolor="#71694F" nowrap><b><font
					color="#FFFFFF" size="1" face="MS Sans Serif">Net Worth</font></b></td>
			</tr>
		</table>
		</td>
		<td width="10%">&nbsp;</td>
	</tr>
</table>
<table width="100%" border="1" cellspacing="0" cellpadding="5"
	bgcolor="#DEDACF" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"
	height="380">
	<tr>
		<td valign="top">
		<div align="left"></div>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			height="100%">
			<tr>
				<td>
				<table width="100%" border="1" cellspacing="0" cellpadding="5"
					height="100%" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="3">
                      <tr> 
                        <td colspan="2" valign="top"> <table width="100%" border="1" cellspacing="0" cellpadding="2"
									bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
                            <tr bgcolor="#71694F"> 
                              <td width="15%" height="30" valign="middle"><font size="1"
											color="#FFFFFF" face="MS Sans Serif">Name</font></td>
                              <td align="center" valign="middle"><font color="#FFFFFF"
											size="1" face="MS Sans Serif"> Bank 
                                Accounts</font></td>
                              <td align="center" valign="middle"><font size="1"
											color="#FFFFFF" face="MS Sans Serif">Investments</font></td>
                              <td align="center" valign="middle"><font size="1"
											color="#FFFFFF" face="MS Sans Serif">Insurance 
                                Policies</font></td>
                              <td align="center" valign="middle"><font size="1"
											color="#FFFFFF" face="MS Sans Serif"> 
                                Movable Properties</font></td>
                              <td align="center" valign="middle"><font size="1"
											color="#FFFFFF" face="MS Sans Serif">Total 
                                Movable </font></td>
                              <td align="center" valign="middle"><font size="1"
											color="#FFFFFF" face="MS Sans Serif">Total 
                                Immovable </font></td>
                              <td align="center" valign="middle"><font size="1"
											color="#FFFFFF" face="MS Sans Serif">Total 
                                Assets </font></td>
                              <td align="center" valign="middle"><font size="1"
											color="#FFFFFF" face="MS Sans Serif"> 
                                Total Liabilities </font></td>
                              <td align="right" valign="middle"><font size="1"
											color="#FFFFFF" face="MS Sans Serif"> 
                                Net Worth </font></td>
                            </tr>
                            <tr> 
                              <td height='30'><font size="1" face="MS Sans Serif"><b>Applicant&nbsp;<br>
                                <%=Helper.correctNull((String) hshValues.get("appname"))%></b></font></td>
                              <td align="right"><font size="1" face="MS Sans Serif">&nbsp;<%=nf.format(Double.parseDouble(Helper
						.correctDouble((String) hshValues.get("totmova1"))))%> </font></td>
                              <td align="right"><font size="1" face="MS Sans Serif">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("mov3a"))))%></font></td>
                              <td align="right"><font size="1" face="MS Sans Serif">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("totmova2"))))%></font></td>
                              <td align="right"><font size="1" face="MS Sans Serif">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("permova"))))%></font></td>
                              <td align="right"><font size="1" face="MS Sans Serif">&nbsp;<%=totappmov%></font></td>
                              <td align="right"><font size="1" face="MS Sans Serif">&nbsp;<%=totappimov%></font></td>
                              <td align="right"><font size="1" face="MS Sans Serif">&nbsp;<%=totassapp%></font></td>
                              <td align="right"><font size="1" face="MS Sans Serif">&nbsp;<%=liaapp%></font></td>
                              <td align="right"><font size="1" face="MS Sans Serif"><b>&nbsp;<%=netapp%></b></font></td>
                            </tr>
                            <%ArrayList vecReport = new ArrayList();
			int vecRsize = 0;

			if (hshValues != null) {
				vecReport = (ArrayList) hshValues.get("vecReport");
			}
			if (vecReport != null) {
				vecRsize = vecReport.size();

			}
			ArrayList b1 = null;
			for (int l = 0; l < vecRsize; l++) {

				int colSize = 0;
				if (l < vecRsize) {
					b1 = (ArrayList) vecReport.get(l);
					if (b1 != null) {
						colSize = b1.size();
					}
				}

				if (colSize > 0) {

					%>
                            <tr> 
                              <td height='30'><font face="MS Sans Serif" size="1"><b><%=Helper.correctNull((String) b1
											.get(0))%>&nbsp;<br>
                                <%=Helper.correctNull((String) b1
											.get(1))%>&nbsp;</b></font></td>
                              <td align="right"><font face="MS Sans Serif" size="1">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String) b1
											.get(2))))%></font></td>
                              <td align="right"><font face="MS Sans Serif" size="1"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) b1
											.get(3))))%>&nbsp;</font></td>
                              <td align="right"><font face="MS Sans Serif" size="1"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) b1
											.get(4))))%>&nbsp;</font></td>
                              <td align="right"><font face="MS Sans Serif" size="1"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) b1
											.get(5))))%>&nbsp;</font></td>
                              <td align="right"><font face="MS Sans Serif" size="1"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) b1
											.get(8))))%>&nbsp;</font></td>
                              <td align="right"><font face="MS Sans Serif" size="1">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String) b1
											.get(6))))%></font></td>
                              <td align="right"><font face="MS Sans Serif" size="1">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String) b1
											.get(9))))%> </font></td>
                              <td align="right"><font face="MS Sans Serif" size="1"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) b1
											.get(7))))%>&nbsp; </font></td>
                              <%double networthofcoapp = Double.parseDouble(Helper.correctDouble((String) b1.get(10)));
										effetivenetworth = effetivenetworth + networthofcoapp ;%>
                              <td align="right"><font face="MS Sans Serif" size="1"><b><%=nf.format(Double.parseDouble(Helper.correctDouble((String) b1.get(10))))%> 
                                </b> </font></td>
                            </tr>
                            <%}
			}
			%>
                          </table></td>
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
<br>
<table width="5%" border="1" align="center" cellpadding="0"
	cellspacing="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"
	class="outertablecolor">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="2">
			<tr valign="top">
				<td width="0"><input type="button" name="cmdclose" value="Close"
					style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
					onClick="doClose()"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<INPUT TYPE="hidden" name="hidappno" value="<%=Helper.correctNull((String)request.getParameter("appno"))%>"> 
<INPUT TYPE="hidden" name="radLoan" value="Y"> 
<input type="hidden" name="cmdapply" disabled>
</form>
</body>
</html>
