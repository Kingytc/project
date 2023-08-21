<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<lapschoice:handleerror />
<%if (objValues instanceof java.util.HashMap) {
	hshValues = (java.util.HashMap) objValues;
}

String strapptype = "";
String apptype = "";
String app_status = Helper.correctNull((String) hshValues.get("app_status"));
	ArrayList arrCol;
	ArrayList arrRow = new ArrayList();
	String PageType = Helper.correctNull((String) hshValues
			.get("PageType"));
	String prd_type = Helper.correctNull((String) session
			.getAttribute("strProductType"));
	java.text.NumberFormat nf = java.text.NumberFormat
			.getNumberInstance();
	nf.setGroupingUsed(false);
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
	
	String schemetype="";
	schemetype = Helper.correctNull((String) request.getParameter("schemetype"));
	
	
%>
<html>
<head>
<title>LAPS - Agriculture Repayment</title>
<style>
.divCellContainer {
	width: 100%;
	height: 100px;
	overflow: auto;
}
</style>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var varschemetype="<%=schemetype%>";
function selectValues(val1,val2,val3,val4)
{
	document.forms[0].selsno.value = val1;
	document.forms[0].txt_year.value = val2;  
	document.forms[0].txt_principal.value = val3;
	document.forms[0].txt_interest.value = val4;
	enableButton(true,false, true, true, false,false, false);
	// callbuttonStatus(document.forms[0].hidUsrMode, document.forms[0].hidWorkflowStatus, 'radio',document.forms[0].hidWorkflowId);
	//if(document.forms[0].hidMakerFlag.value=="Y")
	//{
	//	disableCommandButtons("radioselect");
	//}
	//else
	//{
	//	disableCommandButtons("disableall");
	//}
}

function enableButton(bool1, bool2, bool3, bool4, bool5,bool7)
{
	
		document.forms[0].cmdnew.disabled=bool1;
		document.forms[0].cmdedit.disabled=bool2;
		document.forms[0].cmdsave.disabled=bool3;
		document.forms[0].cmdcancel.disabled=bool4;
		document.forms[0].cmddelete.disabled=bool5;
		document.forms[0].cmdclose.disabled=bool7;
	
}
function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disabledFields(true);
		enableButton(false,true,true,true, true,false,false);
	
	}
	if(val=="edit")
	{	 
		 enableButton(true,true, false, false, true,false, true);	 
		 disabledFields(false);
	}
	if(val=="radioselect")
	{	 
		enableButton(true,false, true, true, false,false, false);
	}
	if(val=="disableall")
	{
		 enableButton(true,true,true,true, true,false,false);
		 disabledFields(true);
	}
	
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
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].disabled=!val;
		}	
	}
}

function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appUrl,name);
	}
}


function onloading()
{	  
	// callbuttonStatus(document.forms[0].hidUsrMode, document.forms[0].hidWorkflowStatus, 'New',document.forms[0].hidWorkflowId);
	disabledFields(true);
//	if(document.forms[0].hidMakerFlag.value=="Y")
	//{
	//	disableCommandButtons("load");
	//}
	//else
	//{
	//	disableCommandButtons("disableall");
	//}
	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value=varschemetype;
	
}
function doEdit()
{ for(var i=0;i<document.forms[0].length;i++){
    if(document.forms[0].elements[i].type=="radio")
    {
      document.forms[0].elements[i].disabled=true;		  
    }
}
disabledFields(false);
document.forms[0].hidAction.value ="update";
disableCommandButtons("edit");	
	
	
}


function doNew()
{
	disabledFields(false);
	disableCommandButtons("edit");
	document.forms[0].hidAction.value ="insert";
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].checked=false;
		}	  
	}
	
	
}

function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidBeanGetMethod.value="getPlantationRepayment";
		document.forms[0].hidBeanId.value="agrlandholdings";
		document.forms[0].action=appUrl+"action/agr_repayment.jsp";
		document.forms[0].submit(); 		
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanId.value="agrlandholdings";
		document.forms[0].hidSourceUrl.value="action/agr_repayment.jsp";	
		document.forms[0].hidBeanMethod.value="updatePlantationRepayment";
		document.forms[0].hidBeanGetMethod.value="getPlantationRepayment";
		document.forms[0].submit();		
	}

}	

function doSave()
{ 
	if(trim(document.forms[0].txt_principal.value) == "")
	{
	ShowAlert('121',"Principal");
    document.forms[0].txt_principal.focus();
    return;
	}  
	if(trim(document.forms[0].txt_interest.value) == "")
	{
	ShowAlert('121',"Interest");
    document.forms[0].txt_interest.focus();
    return;
	} 
	if(trim(document.forms[0].txt_year.value) == "")
	{
	ShowAlert('121',"Year");
    document.forms[0].txt_year.focus();
    return;
	} 
	document.forms[0].cmdsave.disabled=true;
  	document.forms[0].hidBeanId.value="agrlandholdings";
	document.forms[0].hidSourceUrl.value="/action/agr_repayment.jsp";
	document.forms[0].hidBeanMethod.value="updatePlantationRepayment";
	document.forms[0].hidBeanGetMethod.value="getPlantationRepayment";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
DIV.cellContainer {
	width: 100%;
	height: 250;
	overflow: auto;
}
</style>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="onloading()">
<form name="frmpri" method=post class="normal">
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
<lapschoice:borrowertype /> 
<lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
      <td class="page_flow">Home -> Agriculture -> Repayment</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="121" />
			<jsp:param name="pageid" value="<%=schemetype%>"/>
		</jsp:include></td>
	</tr>
</table>
<br>
<br>
<table width="98%" border="0" cellspacing="0" cellpadding="5"
	align="center" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
			<tr>
				<td>
				
              <table width="100%" border="0" cellspacing="3" cellpadding="3" class="outertable">
                <tr> 
                 <td width="18%">Year&nbsp;<span class="mantatory">*</span></td>
                  <td width="15%" valign="middle">
                    <input type="text" name="txt_year"
							size="11" 
							onBlur="checkDate(this);"
							maxlength="10" style="text-align: middle">
                  <a alt="Select date from calender" href="#" 
											onClick="callCalender('txt_year')"><img
											src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
											alt="Select date from calender" 
											border=0 ></a></td>
				   <td width="18%">Principal&nbsp;<span class="mantatory">*</span></td>
                  <td width="15%">
                   <input type="text" name="txt_principal"  onKeyPress="allowNumber(this)" maxlength="15" style="text-align: right">
                  </td>
				  <td width="18%">Interest&nbsp;<span class="mantatory">*</span></td>
                  <td width="15%">
                    <input type="text" name="txt_interest"  onKeyPress="allowNumber(this)" maxlength="15" style="text-align: right">
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
							btnnames='New_Edit_Save_Cancel_Delete_Audit Trail'
							btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
						<br>
<table width="80%" border="0" align="center" cellspacing="0"
	cellpadding="1">
	<tr>
		<td>
		<table width="98.3%" border="0" cellspacing="1" cellpadding="3">
			<tr class="dataheader">
				<td width="3%">&nbsp;</td>
				<td align="center" nowrap width="14%">Year</td>
				<td align="center" nowrap width="14%">Principal</td>
				<td align="center" nowrap width="14%">Interest</td>
				
			</tr>
		</table>
		
		<div class="divCellContainer">
		<table width="100%" border="0" cellspacing="1" cellpadding="3">
			<%
				arrCol = new ArrayList();
				if (hshValues != null) {
					arrRow = (ArrayList) hshValues.get("arrRow");
					//out.println("arrRow===="+arrRow);
				}
				if (arrRow != null && arrRow.size() > 0) {

					for (int i = 0; i < arrRow.size(); i++) {
						arrCol = (ArrayList) arrRow.get(i);
			%>
			<tr class="datagrid">
				<td width="3%" align="center"><input type="radio"
					style="border: none" name="radiobutton" value="radiobutton"
					onClick="javascript:selectValues('<%=Helper.correctNull((String) arrCol.get(1))%>',
												'<%=Helper.correctNull((String) arrCol.get(2))%>',
											    '<%=Helper.correctNull((String) arrCol.get(3))%>',
												'<%=Helper.correctNull((String) arrCol.get(4))%>')">
				</td>
				<td width="14%" align="center"><%=Helper.correctNull((String) arrCol.get(2))%></td>
				<td width="14%" align="right"><%=Helper.correctNull((String) arrCol.get(3))%></td>
				<td width="14%" align="right"><%=Helper.correctNull((String) arrCol.get(4))%></td>
				
			</tr>
			<%
				}
				}
				for (int j = 0; j < 6; j++) {
			%>
			<tr class="datagrid">
				<td width="3%">&nbsp;</td>
				<td width="14%">&nbsp;</td>
				<td width="14%">&nbsp;</td>
				<td width="14%">&nbsp;</td>
			</tr>
			<%
				}
			%>
		</table>
		</div>
		</td>
	</tr>
</table>
<input type="hidden" name="hidAction" value=""> 
<input type="hidden" name="hidBeanId" value=""> 
<input type="hidden" name="hidBeanMethod" value=""> 
<input type="hidden" name="hidBeanGetMethod" value=""> 
<input type="hidden" name="hidSourceUrl" value=""> 
<input type="hidden" name="hidApp_type" value="A"> 
<input type="hidden" name="selsno" value=""> 
<input type="hidden" name="page" value=""> 
<input type="hidden" name="hidpagetype" value="<%=PageType%>">
</form>
</body>
</html>
                