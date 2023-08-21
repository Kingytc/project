<%@ include file="../share/directives.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var ucicprocess="<%=Helper.correctNull((String)hshValues.get("ucicprocess"))%>";

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/setupnav.jsp";
		document.forms[0].submit();
	}	
}
function doReset()
{
	document.forms[0].action=appURL+"action/set_ucic.jsp";
	document.forms[0].submit();
}
function callDescCBS()
{	
	var varQryString = appURL+"action/CBSapplHelp.jsp?pagename=UCIC";
	var title = "SelectCBSID";
	var prop = "scrollbars=yes,menubar=yes,status=yes,width=500,height=400";
	prop = prop + ",left=50,top=150";
    window.open(varQryString,title,prop);	
}

function getapplication()
{
	var cbsid=document.forms[0].hidoldId.value;
	document.all.existAppl.src=appURL+"action/iframe_ucicExstCustomerAppl.jsp?hidBeanGetMethod=getCBSapplHelp&hidBeanId=inwardRegister&cbsid="+cbsid;
}

function doValidateCBS()
{
	if(document.forms[0].txt_extcustid.value=="")
	{
		alert("Enter Existing customer id");
		return;
	}
	if(document.forms[0].txt_newcustid.value=="")
	{
		alert("Enter New customer id");
		return;
	}
	var applStatusCount=document.forms[0].statuscount.value;
	var applcount=document.forms[0].applcount.value;
	if(applcount==0)
	{
		alert("Customer does not have any Proposal");
		return;
	}
	if(applStatusCount>0)
	{
		alert("Customer has open / pending Proposal");
		return;
	}

	var oldcbsid=document.forms[0].txt_extcustid.value;
	var txt_cbsid=document.forms[0].txt_newcustid.value;
	document.all.validateUCIC.src=appURL+"action/iframe_validateUCIC.jsp?hidBeanGetMethod=getCBSValidateData&hidBeanId=inwardRegister&pageaction=validate&txt_cbsid="+txt_cbsid+"&oldcbsid="+oldcbsid;
}

function callonload()
{
	document.forms[0].cmdchange.disabled=true;
	document.all.idremarks.style.visibility="hidden";
	document.all.idremarks.style.position="relative";

	if(ucicprocess=="Y")
	{
		alert("Successfully changed");
	}
}

function doChange()
{
	if(document.forms[0].ucicremarks.value=="")
	{
		alert("Enter Remarks");
		document.forms[0].ucicremarks.focus();
		return;
	}
		document.forms[0].pageaction.value="change";
	 	document.forms[0].hidBeanId.value="inwardRegister";
		document.forms[0].hidBeanGetMethod.value="updateUCICcustid";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/set_ucic.jsp";
		document.forms[0].submit();
}

</script>
</head>
<body onload="callonload()">
<form method="post" class="normal">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr>
            <td class="page_flow">Home -&gt; Setup -&gt; Admin Level Controls -&gt;  UCIC </td>
          </tr>
        </table>
        <br><br>
         <table width="80%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
         <tr>
         <td>
          <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center">
          <tr  class="datagrid">
          <td width="30%">Existing Customer ID &nbsp;&nbsp;&nbsp;&nbsp;
          <input type="text" name="txt_extcustid" value="" readonly="readonly"  size="20">&nbsp;<a
																	href="#" onClick="javascript:callDescCBS()"><img
																	src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
																	border="0"> </a></td>
		  <td width="20%"><input type="text" name="txt_name" readonly="readonly" size="25"></td>
          <td width="20%" align="center">New Customer ID &nbsp;&nbsp;&nbsp;&nbsp; 
		          <input type="text" name="txt_newcustid"  value="">
		  </td>
          <td width="20%" align="center"><input type="button" name="cmdValidate" value="Validate" class="buttonOthers" onclick="doValidateCBS()"></td>
          </tr>
        </table>
         
         <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1" align="center" style="border-left: 0px;border-right: 0px;border-bottom: 0px;">
          <tr align="center" class="dataheader">
      	  		<td align="center" width="10%">Proposal Number</td>
         	 	<td align="center" width="5%">S. No</td>
         	 	<td align="center" width="10%">CBS ACCOUNTNO </td>
         	 	<td align="center" width="10%">Description</td>
         	 	<td align="center" width="10%">Sanctioned Limit </td>
         	 	<td align="center" width="10%">Module Type </td>
         	 	<td align="center" width="10%">Sanction Date </td>
         	 	<td align="center" width="10%">Facility Type </td>
         	 	<td align="center" width="12%">STATUS</td>
          </tr>
          
          <tr class="datagrid">
          		<td colspan="9"><iframe id="existAppl" src="" width="100%"	height="240" border="no"></iframe></td>
          </tr>         
          
          </table>
         
         </td>
         </tr>
		</table>  
        <table width="80%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center" style="border-left: 0px;border-right: 0px;border-bottom: 0px;">
		<tr id="idremarks">
			<td>
		   <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable" >
			<tr>
			<td>Remarks </td>
			<td><textarea rows="3" cols="50" name="ucicremarks" onkeypress="checkTextArealimit(this,500)" onKeyUp="textlimit(this,500)"></textarea> </td>
			</tr>
			</table>
			</td>
		</tr>
		</table>
		 <lapschoice:combuttonnew btnnames='Change_Reset'
			btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
	  	<lapschoice:hiddentag pageid="<%=PageId%>"/>      
	  	
	  	<input type="hidden" name="hidoldId"> 
	  	<input type="hidden" name="statuscount"> 
	  	<input type="hidden" name="applcount"> 
	  	<input type="hidden" name="pageaction"> 
	  	
	  	<iframe id="validateUCIC" src="" width="0"	height="0" border="no"></iframe>
</form>
</body>
</html>