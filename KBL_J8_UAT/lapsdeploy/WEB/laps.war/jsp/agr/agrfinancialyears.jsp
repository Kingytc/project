<%@include file="../share/directives.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%
    String schemetype = Helper.correctNull((String) request.getParameter("schemetype"));
	ArrayList arrRow = (ArrayList)hshValues.get("arrRow");
	ArrayList arrCol=new ArrayList();
    %>
<html>
<head>
<script	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var schemetype="<%=schemetype%>";
function onloading()
{	
	disabledFields(true);
	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value=schemetype;
}
function callCalender(val)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		 showCal(appUrl,val);
	}
}
function doSave()
{
	if(document.forms[0].txt_fromdate.value == "")
	{
		var varError = "Enter From Date";
		document.forms[0].txt_fromdate.value = "";
		document.forms[0].txt_fromdate.focus();
		return;
	}
	if(trim(document.forms[0].txt_todate.value) == "")
	{
		var varError = "Enter To Date";
		document.forms[0].txt_todate.value = "";
		document.forms[0].txt_todate.focus();
		return;
	}
	var fromdate=document.forms[0].txt_fromdate.value;
	var pgdt1 = fromdate.substring(0,2);
	var pgmon1 = fromdate.substring(3,5);
	var pgyr1 = fromdate.substring(6,10);
	var from_date = pgmon1+"/"+pgdt1+"/"+pgyr1;		

	var todate = document.forms[0].txt_todate.value;
	var pgdt = todate.substring(0,2);
	var pgmon = todate.substring(3,5);
	var pgyr = todate.substring(6,10);
	var to_date = pgmon+"/"+pgdt+"/"+pgyr;		
	if (Date.parse(to_date) < Date.parse(from_date))
	{
		alert("To Date cannot be lesser than From date");
		//obj.value="";
		document.forms[0].txt_todate.value="";
		document.forms[0].txt_todate.focus();
		return;
	}
	disableEditButtons(true, true, true, true, true,true,false);
	document.forms[0].hidBeanId.value="agrnursery";
	document.forms[0].hidSourceUrl.value="/action/agrfinancialyears.jsp";
	document.forms[0].hidBeanMethod.value="updateAgriFinancialYear";
	document.forms[0].hidBeanGetMethod.value="getAgriFinancialYear";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}
function doCancel()
{
	if(ConfirmMsg('102'))
	{
		document.forms[0].hidBeanId.value="agrnursery";
		document.forms[0].hidBeanGetMethod.value="getAgriFinancialYear";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agrfinancialyears.jsp";
		document.forms[0].submit();
	}
}
function doDelete()
{
	if(document.forms[0].hid_availableflag.value=="Y")
	{
		if(ConfirmMsg('182'))
		{
			document.forms[0].hidAction.value="delete";
			document.forms[0].hidBeanId.value="agrnursery";
			document.forms[0].hidSourceUrl.value="/action/agrfinancialyears.jsp";
			document.forms[0].hidBeanMethod.value="updateAgriFinancialYear";
			document.forms[0].hidBeanGetMethod.value="getAgriFinancialYear";
			document.forms[0].action=appUrl+"controllerservlet";
			document.forms[0].submit();
		}
	}
	else
	{
		if(ConfirmMsg('101'))
		{
			document.forms[0].hidAction.value="delete";
			document.forms[0].hidBeanId.value="agrnursery";
			document.forms[0].hidSourceUrl.value="/action/agrfinancialyears.jsp";
			document.forms[0].hidBeanMethod.value="updateAgriFinancialYear";
			document.forms[0].hidBeanGetMethod.value="getAgriFinancialYear";
			document.forms[0].action=appUrl+"controllerservlet";
			document.forms[0].submit();
		}
	}
}
function doEdit()
{
	disabledFields(false);
	document.forms[0].hidAction.value ="update";
	disableEditButtons(true, true, false, false, false,false,true);
}
function selectvalues(val1,val2,val3,val4)
{
	document.forms[0].hid_sno.value=val1;
	document.forms[0].txt_fromdate.value=val2;
	document.forms[0].txt_todate.value=val3;
	document.forms[0].hid_availableflag.value=val4;
	
	disableEditButtons(false, false, true, true, false,false,false);
}
function doClose()
{
	if( ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/"+"comsearch.jsp";
		document.forms[0].submit();
	}
}
function doNew()
{
	document.forms[0].hidAction.value="insert";
	clearFields();
	disabledFields(false);
	disableEditButtons(true, true, false, false, true,false,false);
}
function disabledFields(val)
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
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].disabled=!val;
		}	
	}
}
function disableEditButtons(bool1, bool2, bool3, bool4, bool5, bool6, bool7)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	//document.forms[0].cmdhelp.disabled=bool6;
	document.forms[0].cmdclose.disabled=bool7;
}
function clearFields()
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].value="";
		}	
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].value="";
		}	   
	}
}
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	onload="onloading()">
<form name="frmpri" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="999" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
      <td class="page_flow">Home -> Agriculture -> Financial Year</td>
	</tr>
</table>
<span style="display:none;"> <lapschoice:borrowertype /> </span> <lapschoice:application />
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td valign="top"><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="207" />
			<jsp:param name="pageid" value="<%=schemetype%>"/>
		</jsp:include></td>
	</tr>
</table>
<br>
<table width="50%" border="0" cellspacing="0" cellpadding="5" align="center"  class="outertable border1">
<tr>
		<td valign="middle">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
		<tr>
				<td valign="top">
					<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
					<tr>
						<td>From Date</td>
						<td>
						<table width="100%" border="0">
											<tr>
												<td width="21%"><input type="text" name="txt_fromdate"
													size="16"
													onBlur="checkDate(this);"
													value="<%=Helper.correctNull((String) hshValues.get("asondate"))%>">
												</td>
												<td width="79%"><a alt="Select date from calender"
													href="#" onClick="callCalender('txt_fromdate')"
													onMouseOver="window.status='Date Picker';return true;"
													onMouseOut="window.status='';return true;"><img
													src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
													border="0" alt="Select date from calender"></a></td>
											</tr>
										</table>
						</td>
						
						<td>To Date</td>
						<td>
						<table width="100%" border="0">
											<tr>
												<td width="21%"><input type="text" name="txt_todate"
													size="16"
													onBlur="checkDate(this);"
													value="<%=Helper.correctNull((String) hshValues.get("asondate"))%>">
												</td>
												<td width="79%"><a alt="Select date from calender"
													href="#" onClick="callCalender('txt_todate')"
													onMouseOver="window.status='Date Picker';return true;"
													onMouseOut="window.status='';return true;"><img
													src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
													border="0" alt="Select date from calender"></a></td>
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
<lapschoice:combuttonnew
	btnnames="New_Edit_Save_Cancel_Delete_Audit Trail"
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<br>
<table width="50%" border="1" cellspacing="0" cellpadding="3" align="center" class="outertable">
	<tr class="dataheader">
		<td width="5%" align="center">&nbsp;</td>
		<td width="47.5%" align="center">&nbsp;From Date</td>
		<td width="47.5%" align="center">&nbsp;To Date</td>
	</tr>
	<%if(arrRow !=null && arrRow.size()>0){ 
		for(int i=0;i<arrRow.size();i++){
			arrCol=new ArrayList();
			arrCol=(ArrayList)arrRow.get(i);%>
	<tr class="datagrid">
		<td width="5%" align="center">&nbsp;<INPUT TYPE="radio" NAME="rd_butt" VALUE="" border="0" style="border: none;"
		onclick="selectvalues('<%=Helper.correctNull((String)arrCol.get(0))%>','<%=Helper.correctNull((String)arrCol.get(1))%>',
		'<%=Helper.correctNull((String)arrCol.get(2))%>','<%=Helper.correctNull((String)arrCol.get(3))%>')"></td>
		<td width="47.5%" align="center">&nbsp;<%=Helper.correctNull((String)arrCol.get(1))%></td>
		<td width="47.5%" align="center">&nbsp;<%=Helper.correctNull((String)arrCol.get(2))%></td>
	</tr>
	<%} }%>
</table>
<br>
<lapschoice:hiddentag pageid="<%=PageId%>"/>
<input type="hidden" name="hid_sno" >
<input type="hidden" name="hid_availableflag" >
</form> 
</body>
</html>