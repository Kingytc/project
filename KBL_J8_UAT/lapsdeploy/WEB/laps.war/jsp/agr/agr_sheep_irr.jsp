<%@include file="../share/directives.jsp"%>
<%ArrayList arrCol = new ArrayList();
			ArrayList arrRow = new ArrayList();
			ArrayList vecData = (ArrayList) hshValues.get("vecData");

			arrRow = (ArrayList) hshValues.get("arrRow11");
			ArrayList arrIrrValues = (ArrayList) hshValues.get("arrIrrValues");
%>
<html>
<head>
<title>LAPS -Assesment Form Details</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/link.css" type="text/css">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/agr/agrassesment.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var id ="";
var apptype="";
var acre = "";var totalvalue=0.00;
 var centgunt = "";var len2=0;var centgunt_1 = "";

   
var varApptype=new Array();
var varAcctype=new Array();
var varAcctype1=new Array();
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var  strid="<%=Helper.correctNull((String)hshValues.get("strid"))%>";
var  strAction="<%=Helper.correctNull((String)hshValues.get("strAction"))%>";

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].target="_parent";
		document.forms[0].action=appURL+"action/retailpge.jsp";	
		document.forms[0].submit();
	}
}

function disableFields(one)
{	
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=one;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}		
	}	
}

function onloading()
{
	disableFields(true);
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="onloading()">
<form name="frmpri" method="post" class="normal">
<table width="100%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable">
	<tr class="dataheader">
		<td rowspan="2" width="9%"><b>Project
		Amount Rs. <input type="text" name="txt_loanamount" size="10"
			maxlength="15"
			value="<%=Helper.correctNull((String)hshValues.get("loan_begin"))%>"
			onKeyPress="allowNumber(this)" onBlur="" style="text-align:right;"> </b></td>
		<td colspan="9" align="center"><b>Years</b></td>
	</tr>
	<tr class="dataheader">
		<td align="CENTER" width="11%"><b>I</b></td>
		<td align="CENTER" width="9%"><b>II</b></td>
		<td align="CENTER" width="9%"><b>III</b></td>
		<td align="CENTER" width="9%"><b>IV</b></td>
		<td align="CENTER" width="9%"><b>V</b></td>
		<td align="CENTER" width="9%"><b>VI</b></td>
		<td align="CENTER" width="9%"><b>VII</b></td>
		<td align="CENTER" width="10%"><b>VIII</b></td>
		<td align="CENTER" width="16%"><b>Net
		present value (NPV)</b></td>
	</tr>
	<tr>
		<td width="9%" height="36"><b>CashFlow <input type="hidden"
			name="txt_iyear" size="10" maxlength="15" value="0"
			onKeyPress="allowNumber(this)" onBlur="" style="text-align:right;"> </b></td>

		<%if (vecData != null && vecData.size() > 0) {

				%>
		<td width="11%" height="36"><input type="text" name="txt_iyear"
			size="10" maxlength="15"
			value="<%=Helper.correctNull((String)vecData.get(0)) %>"
			style="text-align:right;"></td>
		<td width="9%" height="36"><input type="text" name="txt_iyear"
			size="10" maxlength="15"
			value="<%=Helper.correctNull((String)vecData.get(1)) %>"
			style="text-align:right;"></td>
		<td width="9%" height="36"><input type="text" name="txt_iyear"
			size="10" maxlength="15"
			value="<%=Helper.correctNull((String)vecData.get(2)) %>"
			style="text-align:right;"></td>
		<td width="9%" height="36"><input type="text" name="txt_iyear"
			size="10" maxlength="15"
			value="<%=Helper.correctNull((String)vecData.get(3)) %>"
			style="text-align:right;"></td>
		<td width="9%" height="36"><input type="text" name="txt_iyear"
			size="10" maxlength="15"
			value="<%=Helper.correctNull((String)vecData.get(4)) %>"
			style="text-align:right;"></td>
		<td width="9%" height="36"><input type="text" name="txt_iyear"
			size="10" maxlength="15"
			value="<%=Helper.correctNull((String)vecData.get(5)) %>"
			style="text-align:right;"></td>
		<td width="9%" height="36"><input type="text" name="txt_iyear"
			size="10" maxlength="15"
			value="<%=Helper.correctNull((String)vecData.get(6)) %>"
			style="text-align:right;"></td>
		<td width="10%" height="36"><input type="text" name="txt_iyear"
			size="10" maxlength="15"
			value="<%=Helper.correctNull((String)vecData.get(7)) %>"
			style="text-align:right;"></td>
		<td align="" width="16%" height="36"></td>
		<%}

			%>

	</tr>
	<%arrCol = new ArrayList();

			if (arrRow != null && arrRow.size() > 0) {
				for (int i = 0; i < arrRow.size(); i++) {
					arrCol = (ArrayList) arrRow.get(i);

					%>

	<tr bgcolor="">
		<td width="9%" nowrap bgcolor=""><b> <input type="text"
			name="txt_iiyear" size="5" maxlength="15"
			value="<%=Helper.correctNull((String)arrCol.get(16))%>"
			style="text-align:right;"> % DF</b></td>
		<td width="11%"><input type="text" size="10" maxlength="15"
			style="text-align:right;" name="txt_iiyear"
			value="<%=Helper.correctNull((String)arrCol.get(0))%>"></td>
		<td width="9%"><input type="text" name="txt_iiyear" size="10"
			maxlength="15" style="text-align:right;"
			value="<%=Helper.correctNull((String)arrCol.get(2))%>"></td>
		<td width="9%"><input type="text" name="txt_iiyear" size="10"
			maxlength="15" style="text-align:right;"
			value="<%=Helper.correctNull((String)arrCol.get(4))%>"></td>
		<td width="9%"><input type="text" name="txt_iiyear" size="10"
			maxlength="15" style="text-align:right;"
			value="<%=Helper.correctNull((String)arrCol.get(6))%>"></td>
		<td width="9%"><input type="text" name="txt_iiyear" size="10"
			maxlength="15" style="text-align:right;"
			value="<%=Helper.correctNull((String)arrCol.get(8))%>"></td>
		<td width="9%"><input type="text" name="txt_iiyear" size="10"
			maxlength="15" style="text-align:right;"
			value="<%=Helper.correctNull((String)arrCol.get(10))%>"></td>
		<td width="9%"><input type="text" name="txt_iiyear" size="10"
			maxlength="15" style="text-align:right;"
			value="<%=Helper.correctNull((String)arrCol.get(12))%>"></td>
		<td width="10%"><input type="text" name="txt_iiyear" size="10"
			maxlength="15" style="text-align:right;"
			value="<%=Helper.correctNull((String)arrCol.get(14))%>"></td>
		<td width="16%">&nbsp;</td>
	</tr>
	<tr class="dataheader">
		<td width="9%" nowrap><b>PV @ <input type="text"
			name="txt_iiiyear" size="5" maxlength="15"
			value="<%=Helper.correctNull((String)arrCol.get(16))%>"
			style="text-align:right;"> %DF</b></td>
		<td width="11%"><input type="text" name="txt_iiiyear" size="10"
			maxlength="15" style="text-align:right;"
			value="<%=Helper.correctNull((String)arrCol.get(1))%>"></td>
		<td width="9%"><input type="text" name="txt_iiiyear" size="10"
			maxlength="15" style="text-align:right;"
			value="<%=Helper.correctNull((String)arrCol.get(3))%>"></td>
		<td width="9%"><input type="text" name="txt_iiiyear" size="10"
			maxlength="15" style="text-align:right;"
			value="<%=Helper.correctNull((String)arrCol.get(5))%>"></td>
		<td width="9%"><input type="text" name="txt_iiiyear" size="10"
			maxlength="15" style="text-align:right;"
			value="<%=Helper.correctNull((String)arrCol.get(7))%>"></td>
		<td width="9%"><input type="text" name="txt_iiiyear" size="10"
			maxlength="15" style="text-align:right;"
			value="<%=Helper.correctNull((String)arrCol.get(9))%>"></td>
		<td width="9%"><input type="text" name="txt_iiiyear" size="10"
			maxlength="15" style="text-align:right;"
			value="<%=Helper.correctNull((String)arrCol.get(11))%>"></td>
		<td width="9%"><input type="text" name="txt_iiiyear" size="10"
			maxlength="15" style="text-align:right;"
			value="<%=Helper.correctNull((String)arrCol.get(13))%>"></td>
		<td width="10%"><input type="text" name="txt_iiiyear" size="10"
			maxlength="15" style="text-align:right;"
			value="<%=Helper.correctNull((String)arrCol.get(15))%>"></td>
		<td align="" width="16%"><input type="text" name="txt_iiiyeartotal"
			size="10" maxlength="15" style="text-align:right;"
			value="<%=Helper.correctNull((String)arrCol.get(17))%>"></td>
	</tr>
	<%}
			}

			%>
</table>
<br>

<%if (arrIrrValues != null && arrIrrValues.size() > 0) {

				%>
	<table width="100%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable">
	<tr>
	<td> 
	<b>IRR=</b> <input type="text"
	name="posvalper" size="3"
	value="<%=Helper.correctNull((String)arrIrrValues.get(3)) %>"> + <input
	type="text" name="interval" size="3"
	value="<%=Helper.correctNull((String)arrIrrValues.get(0)) %>"> *[ <input
	type="text" name="posval" size="10"
	value="<%=Helper.correctNull((String)arrIrrValues.get(2)) %>"> /( <input
	type="text" name="posval1" size="10"
	value="<%=Helper.correctNull((String)arrIrrValues.get(2)) %>"> + <input
	type="text" name="negval" size="10"
	value="<%=Helper.correctNull((String)arrIrrValues.get(1)) %>"> ) ]= <input
	type="text" name="irrval" size="10"
	value="<%=Helper.correctNull((String)arrIrrValues.get(4)) %>">
	</td>
	</tr>
	</table>
	 <%}

		%> <br>
<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<input type="hidden" name="cmdsave" disabled="disabled">
<input type="hidden" name="negvalper" size="3" value="">
</form>
</body>
</html>
