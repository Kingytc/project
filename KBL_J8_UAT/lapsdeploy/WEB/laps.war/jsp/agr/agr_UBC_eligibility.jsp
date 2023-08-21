<%@include file="../share/directives.jsp"%>
<html>
<head>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function onLoading()
{
	disableFields(true);
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{	
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].disabled=val;
		}		  
		 
	}
}

function doClose()
{
var con=ConfirmMsg('100');
if(con)
{
	document.forms[0].target="_parent";
	document.forms[0].action=appURL+"action/retailpge.jsp";				
	document.forms[0].submit();

}
}

</script>
</head>

<body  onload="onLoading()">
<form name="ugcc" class="normal">
<br/>
<table width="50%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center">
<tr align="center">
<td>Eligibility Calculation</td>
</tr>
<tr>
<td>
<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable border1" align="center">
  <tr> 
    <td width="52%">Maximum Eligible Loan Amount</td>
    <td width="48%" align="center"> 
     <input type="text" name="txt_eligiblesingle" style="text-align:right" maxlength="10" value="25000.00">
    </td>
  </tr>
  <tr> 
    <td width="52%">Contigency Limit</td>
    <td width="48%"  align="center"> 
     <input type="text" name="txt_eligiblesingle" style="text-align:right" maxlength="10" value="2500.00">
    </td>
  </tr>
 </table>
</td>
</tr>
</table>
<br/>
<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<input type="hidden" name="cmdsave" disabled>
<lapschoice:agrihiddentag />
</form>
</body>
</html>
