<%@include file="../share/directives.jsp"%>
<% int size=0;
ArrayList vecData=new ArrayList();
ArrayList vecDatag=new ArrayList();
if(hshValues!=null)
{
	vecData = (ArrayList) hshValues.get("vecData");
	if(vecData!=null)  
	{
		size=vecData.size();
	}
	vecDatag = (ArrayList) hshValues.get("vecDatagroup");
}
%>
<html>
<head>
<title>Setup(Products - Sanction Limit)</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript">
 var val = "<%=request.getParameter("val")%>";
var path="<%=ApplicationParams.getAppUrl()%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varSchemeCode="<%=Helper.correctNull((String) hshValues.get("strBankScheme"))%>";
var varPrdCode="<%=Helper.correctNull((String) hshValues.get("strPrdCode"))%>";
function callload()
{
if(varPrdCode!=""||varPrdCode!="0"){
	document.forms[0].sel_prd.value=varPrdCode;
}
}
function setData()
{
	doAfterEdit();
}
function doAfterEdit()
{		
	disableCommandButtons("load");
	disableFields(true);
}
function disableCommandButtons(val)
{
  if(val=="load")
  {		 
	  document.forms[0].cmdedit.disabled=false;
	  document.forms[0].cmdsave.disabled=true;
	  document.forms[0].cmdcancel.disabled=true;
	  document.forms[0].cmdclose.disabled=false;
  }
  if(val=="edit")
  {
	 document.forms[0].cmdedit.disabled=true;
	 document.forms[0].cmdsave.disabled=false;
	 document.forms[0].cmdcancel.disabled=false;
	 document.forms[0].cmdclose.disabled=true;
  }
}	
function doEdit()
{
	document.forms[0].hidAction.value="INSERT";
	disableCommandButtons("edit");
	disableFields(false);
}	
function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].name=="txtsanc_limit")
		{
		  document.forms[0].elements[i].readOnly=val;		  
		}
	}
}
function doSave()
{
	
		document.forms[0].hidAction.value="update";
      	document.forms[0].hidBeanId.value="comsolvency";
		document.forms[0].hidBeanMethod.value="updateDelegate";
		document.forms[0].hidBeanGetMethod.value ="getDelegateData"
		document.forms[0].hidSourceUrl.value="/action/solvencydelegatedpower.jsp";
		document.forms[0].action=path+"controllerservlet";
		document.forms[0].submit();
	
}
function doCancel()
{	
	
	   document.forms[0].hidBeanId.value="comsolvency";
		document.forms[0].hidBeanGetMethod.value ="getDelegateData"
		document.forms[0].hidSourceUrl.value="/action/setupnav.jsp";
		document.forms[0].action=path+"controllerservlet";
		document.forms[0].submit();
	
}

function doClose()
{
	
		document.forms[0].action =path+"action/setupnav.jsp";
		document.forms[0].submit();
	
}
function allowSPInteger(n,i)
{
	if (isNaN(n) && n!="")
	{
		ShowAlert("121","Integer");
		document.forms[0].txtnpa_workclass[i].select();
		document.forms[0].txtnpa_workclass[i].focus();
		return;
	}
}
function loadUsedApp()
{
if(document.forms[0].checkApp.value=="Yes")
{
	document.forms[0].cmdedit.disabled=true;
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].cmdcancel.disabled=true;
	document.forms[0].cmdclose.disabled=false;
}
}

function prodcharges(){
	var varprdcode=document.forms[0].sel_prd.value;
	document.forms[0].hidBeanId.value="comsolvency";
	document.forms[0].hidBeanGetMethod.value="getDelegateData";
	document.forms[0].action=appURL+"action/solvencydelegatedpower.jsp";
	document.forms[0].submit();
}
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="setData();loadUsedApp();callload()">
<form name="prdsanclimit" method="post"
	action="<%=ApplicationParams.getAppUrl()%>controllerservlet"
	class="normal">

<table width="100%" border="0" cellspacing="0" cellpadding="1"
	align="center" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Setup -&gt; Solvency and Banker
		Certificate Charges & Delegated Power</td>
	</tr>
</table>
<table width="95%" border="0" cellspacing="0" cellpadding="0"
	class="outertable" align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="1"
			class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="1" cellpadding="3"
					class="outertable">
					<tr>
						<td width="47%">Product code</td>
						<td width="29%"><select name="sel_prd" onchange="prodcharges()">
							<option value="0">&lt;---Select---&gt;</option>
							<option value="1">Solvency</option>
							<option value="6">Banker Certificate</option>
						</select></td>
						<td width="24%"></td>
					</tr>
					<tr>
						<td width="25%"> Range From <span class="mantatory">*</span></td>
						<td width="20%"><lapschoice:CurrencyTag
							name="prdRangeFrom" maxlength="14" value='<%=Helper.correctNull((String) hshValues.get("STATIC_DATA_RANGE_FROM"))%>'
							tabindex="11" size="15" onBlur="roundtxt(this);" /></td>
						<td width="19%"> Range To<span class="mantatory">*</span></td>
						<td width="29%"><lapschoice:CurrencyTag
							name="prdRangeTo" maxlength="14" value='<%=Helper.correctNull((String) hshValues.get("STATIC_DATA_RANGE_TO"))%>'
							tabindex="12" size="15" onBlur="roundtxt(this);" /></td>
					</tr>

				</table>
				</td>
			</tr>
			</table>
			</td>
			</tr>
		</table>		<table width="37%" border="0" cellspacing="1" cellpadding="3"
			class="outertable">

			<tr>
				<jsp:include page="../set/solvencyurltab.jsp" flush="true">
					<jsp:param name="tabid" value="06" />
				</jsp:include>
			</tr>
		</table>



<table width="100%" border="0" cellspacing="0" cellpadding="5"
	align="center" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellpadding="3" cellspacing="1"
			align="center" class="outertable">
			<tr class="dataheader" align="center">
				<td width="5%">S.No</td>
				<td width="40%">User Designation</td>
				<td width="47%">Powers(Rs.)</td>
			</tr>
			<%if(size>0){
							if(vecData!=null)
							{
								for(int i=0;i<size;i++)
								{
									ArrayList vecVal = (ArrayList)vecData.get(i);
									String strSancClass=Helper.correctNull((String)vecVal.get(0));
									String strSancLimit=Helper.correctNull((String)vecVal.get(1));
									String strSancDesig=Helper.correctNull((String)vecVal.get(2));%>
                                        <tr class="datagrid"> 
                                          <td width="5%"  align="center"> 
                                            <%=i+1%>
                                          </td>
                                          <td width="40%" align="center">
                                              <input type="hidden" name="txtsanc_class" size="15" readonly value="<%=strSancClass%>">
										      <input type="text" name="txtsanc_desig" size="50"  value="<%=strSancDesig%>" readOnly>
                                          </td>
                                          <td width="47%" align="center"> 
                                           	<lapschoice:CurrencyTag name="txtsanc_limit" 	maxlength="13" size="15" value='<%=strSancLimit%>' onBlur="roundtxt(this);"/>
                                          </td>
                                       </tr>
                                 <%}}}else{	 						
							if(vecDatag!=null)
							{
								for(int i=0;i<vecDatag.size();i++)
								{
									ArrayList vecVal = (ArrayList)vecDatag.get(i);
									String strSancClass=Helper.correctNull((String)vecVal.get(0));
									String strSancDesig=Helper.correctNull((String)vecVal.get(1));%>
                                        <tr class="datagrid"> 
                                          <td width="13%" align="center"> 
                                            <%=i+1%> 
                                          </td>
                                          <td width="40%" align="center">
                                              <input type="hidden" name="txtsanc_class" size="15" readonly value="<%=strSancClass%>">
										      <input type="text" name="txtsanc_desig" size="50"  value="<%=strSancDesig%>" readOnly>
                                          </td>
                                          <td width="47%" align="center"> 
										   <lapschoice:CurrencyTag name="txtsanc_limit" maxlength="13"
											size="15" onBlur="roundtxt(this);"/>
										  </td>
                                        </tr>
                                        <%}}}%>	
		</table>
		</td>
	</tr>
</table>

<br>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Audit Trail"
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>' /> <input type=hidden
	name="hidSeldInsti" value=""> <input type="hidden"
	name="checkApp" value="<%=request.getParameter("checkApp")%>">
<input type="hidden" name="hideditflag"> <input type="hidden"
	name="hidPage" value="Delegate"> <input type="hidden"
	name="prd_code"
	value="<%=Helper.correctNull((String)request.getParameter("prdCode")) %>" />

</form>
</body>
</html>
