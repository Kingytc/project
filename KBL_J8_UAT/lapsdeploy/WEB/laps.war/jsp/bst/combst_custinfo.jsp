<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
			}

String strdelflag=Helper.correctNull((String)hshValues.get("delflag"));
%>
<html>
<head>
<title>Broad Terms of the Proposal - Customer Information</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"> </script>
<script	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>

var appURL = "<%=ApplicationParams.getAppUrl()%>";
var id="<%=Helper.correctNull((String)hshValues.get("combst_companyid"))%>";
var appstatus="<%=Helper.correctNull((String)hshValues.get("appstatus"))%>";
var vartype="<%=Helper.correctNull((String)hshValues.get("bst_custype"))%>";

function onloading()
{
	if(id=='')
	{
		document.forms[0].hid_comappid.value="New";
		enableButtons(true,false,false,true,false,true);
		document.forms[0].hidAction.value="Insert";
		disableFields(false);
	}
	else
	{
		if(appstatus=='true')
		{
		alert("Cannot Modify the Profile since application has been approved or rejected");
		enableButtons(true,true,true,true,false,false);
		}
		else
		{
		enableButtons(false,true,true,true,false,true);
		}
		disableFields(true);
	}
	if(vartype!='')
	{
		document.forms[0].sel_type.value=vartype;
	}
	else
	{
		document.forms[0].sel_type.value='0';
	}
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
		  document.forms[0].elements[i].readOnly=val;		  
		}
		if(document.forms[0].elements[i].type=='select-one'  )
		{
			document.forms[0].elements[i].disabled=val;
		}
	}
}
function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="broadsancterms"
		document.forms[0].hidBeanGetMethod.value="getBSTCustomerDetailsData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/combst_custinfo.jsp";
		document.forms[0].submit();
	 }
	
}
function doDelete()
{
	if(document.forms[0].delflag.value=='N')
	{
		if(ConfirmMsg(101))
		 {
			document.forms[0].hidAction.value="Delete"
		 	document.forms[0].hidBeanId.value="broadsancterms"
			document.forms[0].hidBeanMethod.value="updateBSTCustomerDetailsData";
			document.forms[0].hidBeanGetMethod.value="getBSTCustomerDetailsData";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].hidSourceUrl.value="/action/combst_custinfo.jsp";
	 		document.forms[0].submit();
		 }
	}
	else
	{
		alert("Yon Cannot delete this Customer Profile");
		enableButtons(false,true,true,true,false,true);
		return true;
	}
}
function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{

	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
	document.forms[0].cmdrenew.disabled=bool6;
	

}
function doEdit()
{
	disableFields(false);
	enableButtons(true,false,false,false,true,true)
	document.forms[0].hidAction.value="Update";
}
function doSave()
{
	if(document.forms[0].txt_customername.value=="")
	{
	   document.forms[0].txt_customername.focus();
	   ShowAlert('112','Company Name');
	   return;
	}
	else if(document.forms[0].comapp_orgname.value=="")
	{
	  document.forms[0].comapp_orgname.focus();
	  ShowAlert('112','Application Recd. From');
	  return;
	}
	document.forms[0].cmdsave.disabled=true;
		document.forms[0].hidBeanId.value="broadsancterms"
		document.forms[0].hidBeanGetMethod.value="updateBSTCustomerDetailsData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/combst_custinfo.jsp";
		document.forms[0].submit();
}

function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].action=appURL+"action/"+"combstmastersearch.jsp";
		document.forms[0].submit();
	}
	
}

function openGroup()
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var prop = "scrollbars=no,width=450,height=300,,top=100,left=250";
		var url="<%=ApplicationParams.getAppUrl()%>action/grouphelp.jsp";
		window.open(url,"grouphelp",prop);
	}
}

function doRenew()
{
	
	document.forms[0].hidAction.value="Renew"
 	document.forms[0].hidBeanId.value="broadsancterms"
	document.forms[0].hidBeanGetMethod.value="updateBSTCustomerDetailsData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/combst_custinfo.jsp";
	document.forms[0].submit();
}
</script>

<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>
<body  onload="onloading()">
<form name="appform" class="normal">

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
	<tr>
		<td class="page_flow"><b>Home
		-&gt; Commercial(Applicant Master) -&gt; Customer Master Details -&gt;
		Company Details</b></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			height="100%" class="outertable">
			<tr>
				<td>

				<table width="100%" border="0" cellspacing="0" cellpadding="3"
					class="outertable border1">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
								<td colspan="6">

								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
									<tr>
										<td>Company Name <b><span class="mantatory">*&nbsp;</span></b></td>
										<td><input type="text" name="txt_customername" size="40"
											maxlength="80" style="border-style=groove"
											value="<%=Helper.correctNull((String)hshValues.get("combst_customername"))%>"
											onKeyPress="notAllowedDouble()" tabindex="3"></td>
									</tr>
									<tr>
										<td>Group</td>
										<td><input type="hidden" name="comapp_groupid" value="<%=Helper.correctNull((String)hshValues.get("combst_companygroup"))%>"/>
										<input type="text" name="comapp_group" size="30"
											maxlength="20" style="text-align:left;border-style=groove" value="<%=Helper.correctNull((String)hshValues.get("combst_groupdesc"))%>"
											readOnly="readonly"> <b><span onClick="openGroup()" style="cursor:hand"><img
											src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
											border="0"></span></b></td>
									</tr>
									<tr>
										<td nowrap="nowrap">Application Recd. From <b><span class="mantatory">*&nbsp;</span></b>
										</td>
										<td colspan="2"><INPUT type="hidden" name="comapp_scode"
											style="width:200" value="<%=Helper.correctNull((String)hshValues.get("combst_brlocation"))%>"> <input type="text" name="comapp_orgname"
											size="25"
											value="<%=Helper.correctNull((String)hshValues.get("combst_brnlocationdesc"))%>">
											<b><a href="#" onClick="showOrgSearch('<%=ApplicationParams.getAppUrl()%>','comapp_scode','comapp_orgname')"
											style="cursor:hand">
											<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0"></a></b>
										</td>
									</tr>
									<tr>
									 <td>Type of Borrower</td>
								      <td>
								        <select name="sel_type">
								          <option value="0" selected="selected">&lt;---Select---&gt;</option>
								          <option value="1">Existing connection</option>
								          <option value="2">New connection</option>
								        </select>
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
		</td>
	</tr>
</table>
<br>

		<lapschoice:combuttonnew btnnames=' Edit_Save_Cancel_Delete_Renew_Audit Trail'
		btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
	
<input type="hidden" name="exist"/> 
<input type="hidden" name="delflag" value="<%=strdelflag%>"/>
<input type="hidden" name="readFlag" value="<%=Helper.correctNull((String)session.getAttribute("strGroupRights")).charAt(18)%>"/>
<input type="hidden" name="hid_comappid" value="<%=Helper.correctNull((String)hshValues.get("combst_companyid"))%>"/> 
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
</form>
</body>
</html>

