<%@include file="../share/directives.jsp"%>
<%

ArrayList arr = null;
int arrsize = 0;

if (hshValues != null) {
	arr = (ArrayList) hshValues.get("arrVal");
}

if (arr != null) {
	arrsize = arr.size();

}
String Valuesin=Helper.correctNull((String) request.getParameter("valuesin"));
String[] strdesc = { "Interest Income","Fee Based Income"};
%>
<html>
<head>
<title>Modification in Sanction Terms</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>

var appURL = "<%=ApplicationParams.getAppUrl()%>";
function onloading()
{
	disableFields(true);
}

function disableFields(val)
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
		}
	}
function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="modsancterms"
		document.forms[0].hidBeanGetMethod.value="getValueofAccountData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/commst_valueofaccount.jsp";
		document.forms[0].submit();
	 }
	
}
function doDelete()
{
	
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete"
	 	document.forms[0].hidBeanId.value="modsancterms"
		document.forms[0].hidBeanMethod.value="updateValueofAccountData";
		document.forms[0].hidBeanGetMethod.value="getValueofAccountData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/commst_valueofaccount.jsp";
 		document.forms[0].submit();
	 }
}
function enableButtons(bool1,bool2,bool3,bool4,bool5)
{

	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;

}
function doEdit()
{
	disableFields(false);
	enableButtons(true,false,false,false,true)
}
function doSave()
{
		
		document.forms[0].hidAction.value="update"
	 	document.forms[0].hidBeanId.value="modsancterms"
		document.forms[0].hidBeanMethod.value="updateValueofAccountData";
		document.forms[0].hidBeanGetMethod.value="getValueofAccountData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/commst_valueofaccount.jsp";
		document.forms[0].submit();
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/corppge.jsp";
		document.forms[0].submit();
	}
	
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body onload="onloading()">
<form name="valueofaccount" method="post" class="normal">
<lapstab:applurllinksmst pageid="5"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1"><tr><td class="page_flow">
Corporate &amp; SME -&gt; Modification in Sanction Terms  -&gt; Valueofaccount
</td>
</tr>
</table>
<lapschoice:MSTApplications/>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
      <tr> 
      <td align="center">
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
      <tr> 
      <td align="center">
          <table width="75%" border="0" cellspacing="1" cellpadding="3" class="outertable"> 
          <tr class="dataheader"> 
            <td colspan="2">&nbsp;</td>
            <td width="25%"><b>Previous Financial Year</b></td>
            <td width="33%"><b>Current Financial Year</b></td>
          </tr>
          <%ArrayList g1 = null;

			for (int l = 0; l < 2; l++) 
			{

				int arrSize = 0;

				if (l < arrsize) 
				{
					g1 = (ArrayList) arr.get(l);

					if (g1 != null) 
					{
						arrSize = g1.size();
					}
				}

				if (arrSize > 0) 
				{

						%>
          <tr> 
            <td colspan="2"><%=strdesc[l]%></td>
            <td width="25%"><lapschoice:CurrencyTag name="txt_previous" size="13" maxlength='10'
								 	value='<%=Helper.correctNull((String)g1.get(0))%>'/> 
            </td>
            <td width="33%"><lapschoice:CurrencyTag name="txt_current" size="13" maxlength='10'
								 	value='<%=Helper.correctNull((String)g1.get(1))%>'/> 
            </td>
          </tr>
          <%}
				else
				{
				%>
          <tr> 
            <td colspan="2"><%=strdesc[l]%></td>
            <td width="25%"><lapschoice:CurrencyTag name="txt_previous" size="13" maxlength='10'
								 	value=''/> 
            </td>
            <td width="33%"><lapschoice:CurrencyTag name="txt_current" size="13" maxlength='10'
								 	value=''/> 
            </td>
          </tr>
          <%} }%>
        </table>
        </td>
        </tr></table>
      </td>
    </tr>
  </table><br>
<lapschoice:combuttonnew btnnames="Edit_Save_Delete_Cancel" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
</form>
</body>
</html>

