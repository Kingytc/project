<%@include file="../share/directives.jsp"%>

<%
	String appCheck = Helper.correctNull((String) request
			.getParameter("check"));

	//out.println("----hshValues----"+hshValues);

	ArrayList arrValues = null;
	int tothshsize = hshValues.size();
	int totarrsize = 0;
	String strRBITableName = "";
	String strTemp = "";
	String arrvaluesize = (String) hshValues.get("arrValueSize");
	if (hshValues.size() > 0 && hshValues != null && tothshsize > 0
			&& arrvaluesize != null) {
		totarrsize = Integer.parseInt(arrvaluesize);
		strRBITableName = (String) hshValues.get("strRBITableName");
		strTemp = (String) hshValues.get("strTemp");

	}
%>

<html>
<head>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var tablename ="<%=strRBITableName%>";
var criterias ="<%=strTemp%>"
var check = "<%=appCheck%>";

function doGotoSearch()
{
	if( ConfirmMsg(151) )
	{
		document.forms[0].action=appUrl+"action/"+"comrbidefaultersearch.jsp";
		document.forms[0].submit();
	}	
}
function callDefaultersDetails(var1,var2,var3,var4,var5,var6,var7,var8,var9,var10,var11,var12,var13,var14,var15,var16,var17,var18,var19,var20,var21,var22,var23,var24,var25,var26,var27,var28,var29,var30,var31)
{
	window.open(appUrl+"action/comrbidefaulterdetails.jsp?1=SCTG^"+var1+"&2=BANK NAME^"+var2+"&3=BRANCH NAME^"+var3+ "&4=STATE^"+var4+ "&5=SRNO^"+var5+ "&6=PARTY NAME^"+var6+ "&7=REGISTERED-ADDRESS^"+var7+ "&8=OUTSTANDING AMOUNT^"+var8+ "&9=SUIT FILED^"+var9+"&10=OTHER BANK^"+var10+ "&11=DIRECTOR1^"+var11+ "&12=DIRECTOR2^"+var12+ "&13=DIRECTOR3^"+var13+ "&14=DIRECTOR4^"+var14+ "&15=DIRECTOR5^"+var15+ "&16=DIRECTOR6^"+var16+"&17=DIRECTOR7^"+var17+ "&18=DIRECTOR8^" +var18+ "&19=DIRECTOR9^" +var19+ "&20=DIRECTOR10^"+ var20+ "&21=DIRECTOR11^" +var21+ "&22=DIRECTOR12^" +var22+ "&23=DIRECTOR13^"+ var23 + "&24=DIRECTOR14^"+var24+"&25=BIFR A/C^"+var25 +"&26=A/c in CDR^"+var26+"&27=A/c of Group in CDR^"+var27+"&28=Compromise/OTS^"+var28+"&29=Banks Caution^"+var29+"&30=RBI Defaulter(Non Suit File)^"+var30+"&31=RBI Defaulter(Willful)^"+var31,"DefaulterDetails" ,"scrollbars=yes ,toolbars=No ,menubar=no ,width=750 ,height=500 ,top=30 ,left=20,top=3");
}



function doClose()
{
   	if(ConfirmMsg(100))
	{
		if(check=="applevel")
		{
			window.close();
		}	
		else
		{
			document.forms[0].action=appUrl+"action/"+"mainnav.jsp";
			document.forms[0].submit();
		}	
	}
}
 
 function menuOptionDivMouseDown (url) {
		//if (! isMac) {
			document.currentMenu.style.display='none';
			document.currentMBarOpt.style.border='1px solid lightgrey';
			document.menuIsActive = false;
			//window.location=url;
			document.forms[0].action=url;
			document.forms[0].submit();
			//}
		}
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
<form name="srchform" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">List of Defaulters</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="5"
	class="outertable border1">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="2" cellpadding="3"
			class="outertable">
			<%
				if (hshValues.size() > 0 && hshValues != null && tothshsize > 0
						&& totarrsize > 0) {
			%>
			<tr class="dataheader" align="center">
				<td width="28%">Party</td>
				<td width="27%">Bank Name</td>
				<td width="25%">Branch Name</td>
				<td width="20%">State</td>
			</tr>
			<%
				}
			%>
			<%
				if (hshValues.size() > 0 && hshValues != null && tothshsize > 0
						&& totarrsize > 0) {
					for (int i = 0; i < totarrsize; i++) {
						arrValues = (ArrayList) hshValues.get(Integer
								.toString(i + 1));
			%>
			<tr class="datagrid">
				<td width="28%" valign="top"><a
					href="javascript:callDefaultersDetails('<%=arrValues.get(0)%>','<%=arrValues.get(1)%>','<%=arrValues.get(2)%>','<%=arrValues.get(3)%>','<%=arrValues.get(4)%>','<%=arrValues.get(5)%>','<%=arrValues.get(6)%>','<%=arrValues.get(7)%>','<%=arrValues.get(8)%>','<%=arrValues.get(9)%>','<%=arrValues.get(10)%>','<%=arrValues.get(11)%>','<%=arrValues.get(12)%>' ,'<%=arrValues.get(13)%>','<%=arrValues.get(14)%>','<%=arrValues.get(15)%>','<%=arrValues.get(16)%>','<%=arrValues.get(17)%>','<%=arrValues.get(18)%>','<%=arrValues.get(19)%>','<%=arrValues.get(20)%>','<%=arrValues.get(21)%>','<%=arrValues.get(22)%>','<%=arrValues.get(23)%>','<%=arrValues.get(24)%>','<%=arrValues.get(25)%>','<%=arrValues.get(26)%>','<%=arrValues.get(27)%>','<%=arrValues.get(28)%>','<%=arrValues.get(29)%>','<%=arrValues.get(30)%>')"
					class="blackfont"><b><%=arrValues.get(5)%></b></a></td>
				<td valign="top" width="27%">&nbsp;&nbsp;<%=arrValues.get(1)%></td>
				<td width="25%" valign="top">&nbsp;&nbsp;<%=arrValues.get(2)%></td>
				<td width="20%" valign="top">&nbsp;&nbsp;<%=arrValues.get(3)%></td>
			</tr>
			<%
				}
				} else {
			%>
			<tr>
				<td valign="top" width="28%">&nbsp;</td>
				<td valign="top" width="27%">NO RECORDS TO DISPLAY</td>
			</tr>
			<%
				}
			%>
		</table>

		</td>
	</tr>
</table>
<lapschoice:combuttonnew btnnames='Goto Search' btnenable='Y' /> <input
	type="hidden" name="check" value="<%=appCheck%>"></form>
</body>
</html>