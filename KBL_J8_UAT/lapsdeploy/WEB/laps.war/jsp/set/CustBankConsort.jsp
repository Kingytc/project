<%@include file="../share/directives.jsp"%>
<%
ArrayList arrRow	= new ArrayList();
ArrayList arrCol	= new ArrayList();
if(hshValues!=null)
{
	arrRow	= (ArrayList)hshValues.get("arrRow");
}
int intSize=0;
if(arrRow!=null&&arrRow.size()>0)
{ intSize	= arrRow.size();}
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
String strProfilestatus = Helper.correctNull((String) hshValues
		.get("strProfilestatus"));
String strEmployment=(String)session.getAttribute("strEmployment");
String facname=Helper.correctNull((String)hshValues.get("facname"));
String hidfacname=Helper.correctNull(request.getParameter("hidfacname"));
%>
<html>
<head>
<title>Proposal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">

<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var appstatus="<%=Helper.correctNull((String) request.getParameter("appstatus"))%>";
var intSize	= '<%=intSize%>';
var strappno = "<%=Helper.correctNull((String) request.getParameter("appno"))%>";
var strexisting = "<%=Helper.correctNull((String) hshValues.get("existing"))%>"
var strproposed = "<%=Helper.correctNull((String) hshValues.get("proposed"))%>"

function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmddelete.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;	
}

function doCancel()
{
	if (ConfirmMsg(102))
	{
	document.forms[0].hidBeanGetMethod.value="getConsBankdetail";
	document.forms[0].hidBeanId.value="mastapplicant";
	document.forms[0].action=appURL+"action/CustBankConsort.jsp";
	document.forms[0].submit();
	}
}

function callclose()
{
	var cattype=document.forms[0].cattype.value;
 	if((cattype=="ASSI")||(cattype=="ASBI"))
    {
    	if(ConfirmMsg(100))
	 	{
			document.forms[0].action=appURL+"action/agrborrowersearch.jsp";
		 	document.forms[0].submit();
	 	}
	}
	else
	{
    	if(ConfirmMsg(100))
	 	{
			document.forms[0].action=appURL+"action/corppge.jsp";
		 	document.forms[0].submit();
	 	}
	}
}

function doEdit()
{	
	document.forms[0].txt_FacilityType.disabled = true;
	document.forms[0].txt_Facilitydesc.disabled = true;
	document.forms[0].txt_FacilityCreditType.disabled = true;
	document.forms[0].txt_BankName.disabled = true;
	document.forms[0].txt_BankingArrangement.disabled = true;
	document.forms[0].hidAction.value ="update";
	enableButtons(true,false,false,false);
	disableFields(false);
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";		
		document.forms[0].hidBeanMethod.value="updateConsBankdetail";
		document.forms[0].hidBeanId.value="mastapplicant";
		document.forms[0].hidBeanGetMethod.value="getConsBankdetail";
		document.forms[0].action=appURL+"action/ControllerServlet";	
		document.forms[0].hidSourceUrl.value="/action/CustBankConsort.jsp";			
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}
}

function doSave()
{
	document.forms[0].txt_FacilityType.disabled = false;
	document.forms[0].txt_Facilitydesc.disabled = false;
	document.forms[0].txt_FacilityCreditType.disabled = false;
	document.forms[0].txt_BankName.disabled = false;
	document.forms[0].txt_BankingArrangement.disabled = false;
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="mastapplicant";
	document.forms[0].hidSourceUrl.value="/action/CustBankConsort.jsp";
	document.forms[0].hidBeanMethod.value="updateConsBankdetail";
	document.forms[0].hidBeanGetMethod.value="getConsBankdetail";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function callLink(page,bean,method)
{
	if (document.forms[0].cmdsave.disabled)
	{
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
	 }
	else
	{
		ShowAlert(103);
	}
}



function fnOnload()
{
	document.forms[0].txt_FacilityType.readonly = true;
	document.forms[0].txt_Facilitydesc.readonly = true;
	document.forms[0].txt_FacilityCreditType.readonly = true;
	document.forms[0].txt_BankName.readonly = true;
	document.forms[0].txt_BankingArrangement.readonly = true;
	document.forms[0].txt_LeadBankName.readonly = false;
	document.forms[0].sel_Exewhetherconmul.readonly = true;
	document.forms[0].sel_Exewhetherconmu2.readonly = true;
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
		if(document.forms[0].elements[i].type=="radio")
		{
			document.forms[0].elements[i].disabled=(!val);		  
		} 
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=val;		  
		} 
	}
	
}
function selectValues(val0,val1,val2,val3,val4,val5,val6,val7,val8,val9)
{
	document.forms[0].txt_FacilityType.value = val1;
	document.forms[0].txt_Facilitydesc.value=val2;
	document.forms[0].txt_FacilityCreditType.value=val3;
	document.forms[0].txt_BankName.value=val4;
	document.forms[0].txt_BankingArrangement.value=val5;
	document.forms[0].txt_LeadBankName.value=val6;
	document.forms[0].sel_Exewhetherconmul.value=val7;
	document.forms[0].sel_Exewhetherconmu2.value=val8;
	document.forms[0].hid_sno.value=val0;
	document.forms[0].hid_Bankcode.value=val9;
	enableButtons(false,true,true,true,false);
	
}
function callotherscredit()
{
	var hidDemoId=document.forms[0].hidDemoId.value;
	var varQryString = appURL+"action/creditfacilityOtherBank.jsp?hidBeanGetMethod=getourBankcreditDetails&hidBeanId=comproposal&appstatus="+appstatus+"&strAppno="+hidDemoId+"&bank=cust";
	var title = "Credit_Facilities";
	var prop = "scrollbars=yes,width=850,height=600";
	var xpos = "50";
	var ypos = "50";
	prop = prop+","+xpos+","+ypos+",left=50,top=50";
	window.open(varQryString,title,prop);
}
</script>
</head>
<body onload="fnOnload();">

<form name="frmpri" method="post" class="normal">
 
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Customer
		Profile -&gt;Other Bank Details</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="98%" border="0" cellspacing="1" cellpadding="3"
			align="left" class="outertable">
			<tr>
		<td><jsp:include page="../share/Cusurllink.jsp" flush="true">
			<jsp:param name="pageid" value="13" />
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="strProfilestatus" value="<%=strProfilestatus%>" />
			<jsp:param name="strfacdata" value="<%=facname%>" />
		</jsp:include></td>
	</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable border1">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
								<td>
								
							<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
							  <tr>
							   <td>&nbsp;</td>
							   <td>Existing Facilties</td>
							   <td>Proposed Facilties</td>
							   
								
								</tr>
								<tr align="center">
								<td >Whether Single Consortium or Multiple</td>
								<td><select name="sel_Exewhetherconmul">
								<option value="0">---Select---</option>
								<option value="1">Single </option>
								<option value="2">Multiple</option>
								</select>
								</td>
								
								<td><select name="sel_Exewhetherconmu2">
								<option value="0">---Select---</option>
								<option value="1">Single </option>
								<option value="2">Multiple</option>
								</select>
								</td>
								</tr>
								</table>
								<tr>
								<td>
								
							<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
							  <tr class="dataheader" align="center">
							  
								<td>Facility Type</td>
								<td>Facility Name</td>
								<td>Type of Credit</td>
								<td>Bank</td>
								<td>Banking Arrangement</td>
								<td>Lead Bank</td>
								
								<tr>
								<td>
								<input type="text" name="txt_FacilityType" value="" readonly="readonly" size="20">
								</td>
								
								
								<td>
								<input type="text" name="txt_Facilitydesc" value="" readonly="readonly" size="20">
								</td>
								
								
								<td>
								<input type="text" name="txt_FacilityCreditType" value="" readonly="readonly" size="20">
								</td>
								
								
								<td>
								<input type="text" name="txt_BankName" value="" readonly="readonly" size="20">
								<input type="hidden" name="hid_Bankcode" value="">
								</td>
								
							
								<td>
									<input type="text" name="txt_BankingArrangement" value="" readonly="readonly" size="20">
								</td>
								
								
								<td>
									<input type="text" name="txt_LeadBankName" value="" readonly="readonly" size="20">
								</td>
								</tr>
								</table>
								<br>
								<tr>
								<td>
									<table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
									<tr align="center" class="dataheader">
									<td align="center"></td>
									<td align="center">Facility Type</td>
									<td align="center">Facility Name</td>
									<td align="center">Bank</td>
									<td align="center">Banking Arrangement</td>
									<td align="center">Lead Bank</td>
									</tr>
											<%if(arrRow!=null && arrRow.size()>0) {
										for(int i=0;i<arrRow.size();i++){
											arrCol	= (ArrayList)arrRow.get(i);
											
											String strfactype=Helper.correctInt((String)arrCol.get(0));
											String strtypecredit=Helper.correctInt((String)arrCol.get(3));
											String strbnkarrn=Helper.correctInt((String)arrCol.get(5));
											if(strfactype.equalsIgnoreCase("1"))
											{
												strfactype="Working Capital";
											}
											else if(strfactype.equalsIgnoreCase("2"))
											{
												strfactype="Term Loan";
											}
											if(strtypecredit.equalsIgnoreCase("F"))
											{
												strtypecredit="Funded";
											}
											else if(strtypecredit.equalsIgnoreCase("N"))
											{
												strtypecredit="Non Funded";
											}
											if(strbnkarrn.equalsIgnoreCase("C"))
											{
												strbnkarrn="Consortium";
											}
											else if(strbnkarrn.equalsIgnoreCase("M"))
											{
												strbnkarrn="Multiple";
											}
									%>
									
									
									
									<tr class="datagrid">
										<td align="center">
											<input type="radio" name="sno" style="border-style:none"
												onClick="selectValues('<%=Helper.correctInt((String)arrCol.get(0))%>',
														'<%=strfactype%>',
														'<%=Helper.correctNull((String)arrCol.get(2))%>',
														'<%=strtypecredit%>',
														'<%=Helper.correctNull((String)arrCol.get(4))%>',
														'<%=strbnkarrn%>',
														'<%=Helper.correctNull((String)arrCol.get(6))%>',
														'<%=Helper.correctNull((String)arrCol.get(7))%>',
														'<%=Helper.correctNull((String)arrCol.get(8))%>','<%=Helper.correctNull((String)arrCol.get(9))%>')">
											</td>
										<td align="left">&nbsp;<%=strfactype%></td>
										<td align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(2))%></td>
										<td align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(4))%></td>
										<td align="left">&nbsp;<%=strbnkarrn%></td>
										<td align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(6))%></td>
										
									</tr>
									<%	}
									}
									if(arrRow.size()<=0)
									{
									%>
									<tr class="datagrid">
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
									</tr>
									<tr class="datagrid">
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td align="center">--No Records Found--</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
									</tr>
									<tr class="datagrid">
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
									</tr>
									<%
									}
									%>
									
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
									</td>
									</tr>
									</table>
									
<br>
<table width="50%" align="center" >
							
	<tr><td width="40%" >
	
<lapschoice:combuttonnew btnnames="Edit_Save_Delete_Cancel_Audit Trail"
								btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' /><br>
</td>		<td>						
	<table border="0" class="outertable border1" width="10%">
	<tr>
	</tr></table></td>
	</tr>
					
					</table>
				         
							<br>
							<table width="50%" align="center" border="0" cellpadding="2" cellspacing="0">
							
							<tr>
							 <td><input type="button" name="other_bank" class="buttonstyle" 
							value="Details of Credit Facilities from Other bank" onClick="callotherscredit()"></td>
							</tr>
							</table>
<lapschoice:hiddentag pageid='<%=PageId%>' />
<input type="hidden" name="hid_RowSize" value="">
<input type="hidden" name="hidDemoId"	value="<%=Helper.correctNull((String) request.getParameter("hidDemoId"))%>">
 <input type="hidden" name="hid_sno"	value="">
 <input type="hidden" name="txtperapp_appid" value="<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>">
<input type="hidden" name="hidappstatus" value="<%=Helper.correctNull((String)hshValues.get("appstatus"))%>">
 <input type="hidden" name="hidfac" value="<%=Helper.correctNull((String)hshValues.get("facname"))%>">
  <input type="hidden" name="hidfacname"	value="<%=hidfacname%>">
</form>
</body>
</html>
