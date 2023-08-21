<%@include file="../share/directives.jsp"%>
<%String[] Label1 = { "a) Lactation Days ", "b) Dry Days",
					"Expenses on Labour", "Expenses on rearing female calves",
					"Expenses on Veterinary Aid", "Electrical Expenses ",
					"Insurance", "Others", "Total", "From sale of Milk",
					"From sale of cow dung", "Others", "<b>Total</b>",
					"<b>Income - Expenses</b>" };

			ArrayList arrDatacattle = (ArrayList) hshValues
					.get("arrDatacattle");
			ArrayList arrRow = null;
			String[] firstYear = new String[7];

			String strValueofAnimal = Helper.correctNull((String) hshValues
					.get("totalvalueOfAnimal"));
%>
<html>
<head>
<title>Lease Particulars</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>htm/link.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL  ="<%=ApplicationParams.getAppUrl()%>"; 

var currdate = "<%=Helper.getCurrentDateTime()%>";

function doEdit()
{
	enableButtons(true, false, false, true);	
}

function onload()
{
	disableFields(true);
}

function disableFields(one)
{	
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}
	}		
}

function enableButtons(bool1, bool2, bool3, bool4)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmdclose.disabled = bool4;
}

function doSave()
{
	disableFields(false);
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="agriapprisal";
	document.forms[0].hidSourceUrl.value="/action/dairyfarmingappraisal.jsp";
	document.forms[0].hidBeanMethod.value="updatedairyfarmingData";
	document.forms[0].hidBeanGetMethod.value="getDatadairyfindata";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agriapprisal";
		document.forms[0].hidBeanGetMethod.value="getDatadairyfindata";
		document.forms[0].action=appURL+"action/dairyfarmingappraisal.jsp";
		document.forms[0].submit(); 		
	}
}

function doClose()
{
if( ConfirmMsg(100))
	{
		document.forms[0].target="_parent";
		document.forms[0].action=appURL+"action/retailpge.jsp";				
		document.forms[0].submit();
	}
}
</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onload()">
<form name="appform" method="post" class="normal">
<table width="98%" border="0" cellpadding="1" cellspacing="0" class="outertable" align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable border1">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center">
					<tr class="dataheader">
						<td width="30%"><b>Expenditure</b></td>
						<td width="10%" align="center"><b>I year</b></td>
						<td width="10%" align="center"><b>II year</b></td>
						<td width="10%" align="center"><b>III year </b></td>
						<td width="10%" align="center"><b>IV year </b></td>
						<td width="10%" align="center"><b>V year</b></td>
						<td width="10%" align="center"><b>VI year</b></td>
						<td width="10%" align="center"><b>VII year</b></td>
					<tr class="dataheader">

						<td>&nbsp;(All Values are in Rupees)</td>
						<td align="left">&nbsp;</td>
						<td align="left">&nbsp;</td>
						<td align="left">&nbsp;</td>
						<td align="left">&nbsp;</td>
						<td align="left">&nbsp;</td>
						<td align="left">&nbsp;</td>
						<td align="left">&nbsp;</td>
					</tr>

					<tr class="dataheader">
						<td colspan="8">Expenses on Feeding</td>
					</tr>

					<%for (int i = 0; i < 9; i++) {
				if (arrDatacattle.size() != 0) {

					for (int j = 0; j < arrDatacattle.size(); j++) {
						arrRow = (ArrayList) arrDatacattle.get(j);
						firstYear[j] = Helper.correctNull(((String) arrRow
								.get(i)));
					}
				} else {
					for (int j = 0; j < firstYear.length; j++) {
						firstYear[j] = "";
					}
				}%>
					<tr>
						<td><%=Label1[i]%></td>
						<td align="right"><%=firstYear[0]%>&nbsp;</td>
						<td align="right"><%=firstYear[1]%>&nbsp;</td>
						<td align="right"><%=firstYear[2]%>&nbsp;</td>
						<td align="right"><%=firstYear[3]%>&nbsp;</td>
						<td align="right"><%=firstYear[4]%>&nbsp;</td>
						<td align="right"><%=firstYear[5]%>&nbsp;</td>
						<td align="right"><%=firstYear[6]%>&nbsp;</td>
					</tr>
					<%}%>

					<tr>
						<td>&nbsp;</td>
						<td align="right" align="right">&nbsp;</td>
						<td align="right" align="right">&nbsp;</td>
						<td align="right" align="right">&nbsp;</td>
						<td align="right" align="right">&nbsp;</td>
						<td align="right" align="right">&nbsp;</td>
						<td align="right" align="right">&nbsp;</td>
						<td align="right" align="left">&nbsp;</td>
					</tr>
					<tr class="dataheader">
						<td><b>Income</b></td>
						<td align="center"><b>I year</b></td>
						<td align="center"><b>II year</b></td>
						<td align="center"><b>III year </b></td>
						<td align="center"><b>IV year </b></td>
						<td align="center"><b>V year</b></td>
						<td align="center"><b>VI year</b></td>
						<td align="center"><b>VII year</b>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td align="right">&nbsp;</td>
						<td align="right">&nbsp;</td>
						<td align="right">&nbsp;</td>
						<td align="right">&nbsp;</td>
						<td align="right">&nbsp;</td>
						<td align="right">&nbsp;</td>
						<td align="left">&nbsp;</td>
					</tr>
					<%for (int i = 9; i < Label1.length; i++) {
				if (arrDatacattle.size() != 0) {

					for (int j = 0; j < arrDatacattle.size(); j++) {
						arrRow = (ArrayList) arrDatacattle.get(j);
						firstYear[j] = Helper.correctNull(((String) arrRow
								.get(i)));
					}
				} else {
					for (int j = 0; j < firstYear.length; j++) {
						firstYear[j] = "";
					}
				}%>
					<tr>
						<td><%=Label1[i]%></td>
						<td align="right"><%=firstYear[0]%>&nbsp;</td>
						<td align="right"><%=firstYear[1]%>&nbsp;</td>
						<td align="right"><%=firstYear[2]%>&nbsp;</td>
						<td align="right"><%=firstYear[3]%>&nbsp;</td>
						<td align="right"><%=firstYear[4]%>&nbsp;</td>
						<td align="right"><%=firstYear[5]%>&nbsp;</td>
						<td align="right"><%=firstYear[6]%>&nbsp;</td>
					</tr>

					<%if (i == 12) {%>
					<tr>
						<td><b>Value of animals at the end of project</b></td>
						<td align="right">&nbsp;</td>
						<td align="right">&nbsp;</td>
						<td align="right">&nbsp;</td>
						<td align="right">&nbsp;</td>
						<td align="right">&nbsp;</td>
						<td align="right">&nbsp;</td>
						<td align="right"><b>&nbsp;<%=strValueofAnimal%></b></td>
					</tr>

					<%}
			}%>

				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>

<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:agrihiddentag />
</form>
</body>
</html>
