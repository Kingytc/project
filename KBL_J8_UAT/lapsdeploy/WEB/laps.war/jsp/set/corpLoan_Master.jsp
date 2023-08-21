<%@ include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
	ArrayList arr=new ArrayList();
	if(hshValues!=null)
	{
		arr=(ArrayList)hshValues.get("vec");
	}
	int arrSize=0;
	if(arr!=null)
	{
		arrSize=arr.size();
	}

	java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
	nf.setMinimumFractionDigits(2);
	nf.setMaximumFractionDigits(2);
	nf.setGroupingUsed(false);
%>
<html>
<head>
<title>Personal - Applicant</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>
DIV.cellContainer {
	width: 100%;
	height: 100%;
	overflow: auto;
}
</STYLE>


<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>

<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var action = "<%=Helper.correctNull((String) hshValues
							.get("LAWYER_ACTIVE"))%>";
var blacklist = "<%=Helper.correctNull((String) hshValues
							.get("lawyer_blacklist"))%>";
var vartrapedit="<%=Helper.correctNull((String) hshValues.get("trapedit"))%>";
var arrSize='<%=arrSize%>';


function enableButtons(bool1,bool2,bool3,bool4)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmdclose.disabled=bool4;	
}
function doCancel()
{
	if (ConfirmMsg(102))
	{
	document.forms[0].hidBeanGetMethod.value="getCorpMasterList";
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].action=appURL+"action/corpLoan_Master.jsp";
	document.forms[0].submit();
	}
}
function doClose()
{
	 var cattype=document.forms[0].cattype.value;
	if((cattype=="SSI")||(cattype=="CORP")||(cattype=="SME")||(cattype=="STL"))
    {
	    if(ConfirmMsg(100))
		{
			document.forms[0].action=appUrl+"action/corppge.jsp";
		 	document.forms[0].submit();
	 	}
	}
}
function Load()
{
	document.forms[0].hidPageId.value="croploan";
	//alert("arrSize:"+arrSize);
	//out.println("Array Size:"+arr.size());
	
	<%
	for(int i=0;i<arrSize;i++)
	{
		out.println("document.forms[0].txt_value["+i+"].value='"+nf.format(Double.parseDouble((Helper.correctDouble((String)arr.get(i)))))+"'");
	}
	%>
}
function doEdit()
{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=false;
			  
			}
			if(document.forms[0].elements[i].type=="text")
			{
				  document.forms[0].elements[i].readOnly=false;		  
			}	
			if(document.forms[0].elements[i].type=="text")
			{
				  document.forms[0].elements[i].readOnly=false;		  
			}	
		}
	enableButtons(true,false,false,true);
}
function doSave()
{
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidBeanMethod.value="updateCorpMasterList";
	document.forms[0].hidBeanGetMethod.value="getCorpMasterList";
	document.forms[0].hidSourceUrl.value="/action/corpLoan_Master.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="Load()">
<form method="post" class="normal">
<div align="center">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Master -&gt; Crop / Poultry / Fisheries Loan Master</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/mastertab.jsp" flush="true">
			<jsp:param name="tabid" value="13" />
		</jsp:include></td>
	</tr>
</table>
<!-- <table width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable">
	<tr>
		<td align="center" class="dataheader">For other than Coffee Crop Loan</td>
	</tr>
</table>-->
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable">
	<tr>
	<td>
	<table align='center' class="outertable" width="40%">
	<tr>
		<td align="center" class="dataheader" colspan='2'>For other than Coffee Crop Loan</td>
	</tr>
	<tr>
		<td class="datagrid">&nbsp;
		 Post  harvest expenses
		</td>
		<td class="datagrid">
			<input type="text" style="text-align: right;" name="txt_value" size='6' onBlur="checkPercentage(this)" maxlength="5" /> %
		</td>
	</tr>
	<tr>
		<td class="datagrid">&nbsp;
			Farm maintenance
		</td>
		<td class="datagrid">
			<input type="text" style="text-align: right;" name="txt_value" size='6' onBlur="checkPercentage(this)" maxlength="5"/> %
		</td>
	</tr>
	<tr>
		<td class="datagrid">&nbsp;
		 Second year eligibility
		</td>
		<td class="datagrid">
			<input type="text" style="text-align: right;" name="txt_value" size='6' onBlur="checkPercentage(this)" maxlength="5"/> %
		</td>
	</tr>
	<tr>
		<td class="datagrid">&nbsp;
		Third year eligibility
		</td>
		<td class="datagrid">
			<input type="text" style="text-align: right;" name="txt_value" size='6' onBlur="checkPercentage(this)" maxlength="5"/> %
		</td>
	</tr>
	<tr>
		<td class="datagrid">&nbsp;
			Fourth year eligibility
		</td>
		<td class="datagrid">
			<input type="text" style="text-align: right;" name="txt_value" size='6' onBlur="checkPercentage(this)" maxlength="5"/> %
		</td>
	</tr>
	<tr>
		<td class="datagrid">&nbsp;
		Fifth year and above eligibility
		</td>
		<td class="datagrid">
			<input type="text" style="text-align: right;" name="txt_value" size='6' onBlur="checkPercentage(this)" maxlength="6"/> %
		</td>
	</tr>
	<tr>
		<td class="datagrid">&nbsp;
		Maximum Interest subvention limit eligible for Crops (in Rs.)
		</td>
		<td class="datagrid">
			<input type="text" style="text-align: right;" name="txt_value" size='15' onBlur="roundtxt(this);" maxlength="12"/> 
		</td>
	</tr>
	<tr>
		<td class="datagrid">&nbsp;
		Rate of Interest for Crop subvention
		</td>
		<td class="datagrid">
			<input type="text" style="text-align: right;" name="txt_value" size='6' onBlur="checkPercentage(this)" maxlength="6"/> %
		</td>
	</tr>
	<tr>
		<td class="datagrid">&nbsp;
		Maximum Interest subvention limit eligible for Other than Crops (in Rs.)
		</td>
		<td class="datagrid">
			<input type="text" style="text-align: right;" name="txt_value" size='15' onBlur="roundtxt(this);" maxlength="12"/> 
		</td>
	</tr>
	<tr>
		<td class="datagrid">&nbsp;
		Rate of Interest for Other than Crop subvention
		</td>
		<td class="datagrid">
			<input type="text" style="text-align: right;" name="txt_value" size='6' onBlur="checkPercentage(this)" maxlength="6"/> %
		</td>
	</tr>
	</table>
	</td>
 </tr>
</table>
<input type="hidden" name="hidorg_code"
	value="<%=Helper.correctNull((String) hshValues.get("ORG_CODE"))%>">
<input type="hidden" name="hidsno"
	value="<%=Helper.correctNull((String) hshValues
									.get("LAWYER_CODE"))%>">
<input type="hidden" name="hidseqno"
	value="<%=Helper.correctNull((String) hshValues
									.get("lawyer_seqno"))%>">
									
<lapschoice:hiddentag pageid="<%=PageId%>" />
 <input type="hidden" name="hidzip">
  <table width="12%" border="0" cellspacing="0" cellpadding="0"
	align="center" class="outertable">
	<tr>
		<td><lapschoice:combuttonnew
			btnnames="Edit_Save_Cancel_Audit Trial"
			btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
		</td>
	</tr>
</table>
<input type="hidden" name="hidkeyid" value="croploan">
 </form>

</body>
</html>
