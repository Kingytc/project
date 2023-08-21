<%@ include file="../share/directives.jsp"%>
<%
ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();
arrRow=(ArrayList)hshValues.get("arrRow");
int intLen=0;
if(arrRow!=null)
	intLen=arrRow.size();
String strClassrights=Helper.correctNull((String)session.getAttribute("strUserClass"));

%>
<html>
<head>
<title>Application Transfer</title>
<script  LANGUAGE="JavaScript">
var appURL ="<%=ApplicationParams.getAppUrl()%>";
var arrLen="<%=intLen%>";
var varStatus="<%=Helper.correctNull((String)hshValues.get("status"))%>";
var varProposal="<%=Helper.correctNull((String)hshValues.get("strPendingProp"))%>";
var strClassrights="<%= strClassrights%>";
function loadPage()
{
	if(varProposal!="")
	{
		alert(varProposal+" Proposals are Pending in Kalypto.You can't transfer these proposals");
	}
	else if(varStatus.toUpperCase()=="SUCCESS")
	{
		alert("Applications has been Transfered successfully");
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}
	if(parseFloat(arrLen)>0)
	{
		document.forms[0].cmdgetapplication.disabled=true;
		document.forms[0].cmdtransfer.disabled=false;
		document.all.ifrmtab.style.visibility="visible";
		document.all.ifrmtab.style.position="relative";
	}
	else
	{
		document.forms[0].cmdgetapplication.disabled=false;
		document.forms[0].cmdtransfer.disabled=true;
		document.all.ifrmtab.style.visibility="hidden";
		document.all.ifrmtab.style.position="absolute";
	}
	document.forms[0].txtFromUserId.readOnly=true;
	document.forms[0].txtFromUsername.readOnly=true;
	document.forms[0].txttousrid.readOnly=true;
	document.forms[0].txttousrname.readOnly=true;
	document.forms[0].txtapplicationno.readOnly=true;
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		if(document.forms[0].strLinkFrom.value=="Home")
		{
			document.forms[0].action=appURL+"action/mainnav.jsp";
			document.forms[0].submit();
		}
		else
		{
			document.forms[0].action=appURL+"action/setupnav.jsp";
			document.forms[0].submit();
		}
	}	
}

function doGetApplication()
{
	if(document.forms[0].txtFromUserId.value=="")
	{
		alert("Select From User ID");
		return;
	}
	document.forms[0].action=appURL+"action/setapplicationtransfer.jsp";
	document.forms[0].hidBeanId.value="staticdata";
    document.forms[0].hidBeanGetMethod.value="getUserApplicationCount";
	document.forms[0].submit();
}
function callUsersTo()
{
	if(document.forms[0].cmdtransfer.disabled==false)
	{
		var varQryString = appURL+"action/setUserSearch.jsp?pagefrom=apptransferto";
		var title = "Users";
		var prop = "scrollbars=yes,width=650,height=400,menubar=no";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	}
}
function callUsersFrom()
{
	if(document.forms[0].cmdgetapplication.disabled==false)
	{
		var varQryString = appURL+"action/setUserSearch.jsp?pagefrom=apptransferfrom";
		var title = "Users";
		var prop = "scrollbars=yes,width=650,height=400,menubar=no";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	}
	else
	{
		if(document.forms[0].txtFromUserId.value!="")
		{
			alert("Please click reset button to reselect the User");
			return;
		}
	}
}
function doTransfer()
{
	if(document.forms[0].txtFromUserId.value=="")
	{
		alert("Select From User ID");
		return;
	}
	if(document.forms[0].txttousrid.value=="")
	{
		alert("Select To User ID");
		return;
	}
	if(document.forms[0].txtFromUserId.value==document.forms[0].txttousrid.value)
	{
		alert("From User ID and To User ID should not be same");
		return;
	}
	
	if((document.forms[0].hidfromorgcode.value.substring(0,6)==document.forms[0].hidtoorgcode.value.substring(0,6))&&(document.forms[0].hidfromorgcode.value.substring(9,15)==document.forms[0].hidtoorgcode.value.substring(9,15)))
	{
		//With in RO/RLPC can forward the proposal	
	}
	else if(document.forms[0].hidfromorgcode.value!=document.forms[0].hidtoorgcode.value)
	{
		alert("Users Organisation differs, From user and To User should be in same organisation");
		return;
	}
	document.forms[0].hidAction.value="Transfer";
	document.forms[0].action=appURL+"action/setapplicationtransfer.jsp";
	document.forms[0].hidBeanId.value="staticdata";
    document.forms[0].hidBeanGetMethod.value="updateUserApplicationTransfer";
	document.forms[0].submit();
}
function doReset()
{
	document.forms[0].action=appURL+"action/setapplicationtransfer.jsp";
	document.forms[0].submit();
}
function callUsersApplications()
{
	var varUserID=document.forms[0].txtFromUserId.value;
	if(document.forms[0].cmdgetapplication.disabled==false)
	{
		if(document.forms[0].txtFromUserId.value!="")
		{
				var varQryString = appURL+"action/ifrmuserapplicationlisthelp.jsp?hidBeanId=staticdata&hidBeanGetMethod=getUserApplicationList&strFromUser="+varUserID;
				var title = "ProductsSearch";
				var prop = "scrollbars=yes,width=300,height=300,status=yes";	
				prop = prop + ",left=50,top=50";		
				window.open(varQryString,title,prop);
			 
		}
		else
		{
			alert("Select User ID");
			return;
		}
	}
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad ="loadPage()" >
<form method="post" class="normal">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr>
            <td class="page_flow">Home -&gt; Setup -&gt; Admin Level Controls -&gt;  Application Transfer</td>
          </tr>
        </table>
        <br><br>
        <table width="80%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
        <tr>
        <td>
         <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center">
          <tr  class="datagrid">
          <td width="30%">Select From User ID &nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="txtFromUserId" size="10" value="<%=Helper.correctNull((String)hshValues.get("txtFromUserId")) %>">&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="txtFromUsername" value="<%=Helper.correctNull((String)hshValues.get("txtFromUsername")) %>"  size="20">&nbsp;<a
																	href="#" onClick="javascript:callUsersFrom()"><img
																	src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
																	border="0"> </a></td>
          <td width="20%" align="center"><input type="text" name="txtapplicationno" value="<%=Helper.correctNull((String)hshValues.get("strproposalno")) %>">
          &nbsp;<a href="#" onClick="javascript:callUsersApplications()">
          <img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0"> </a>
          </td>
          <td width="20%" align="center"><input type="button" name="cmdgetapplication" value="Get Applications" class="buttonOthers" onclick="doGetApplication()"></td>
          </tr>
        </table>
         <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center" style="border-left: 0px;border-right: 0px;border-bottom: 0px;">
          <tr align="center" class="dataheader">
          <td align="center" width="50%">Application Type</td>
          <td align="center">Application Count</td>
          </tr>
          <%if(arrRow!=null && arrRow.size()>0){ 
          for(int i=0;i<arrRow.size();i++){
          arrCol=(ArrayList)arrRow.get(i);%>
          <tr>
          <td><%=Helper.correctNull((String)arrCol.get(0)) %>&nbsp;</td>
          <td align="center" style="border-bottom: 0px;"><%=Helper.correctNull((String)arrCol.get(1)) %>&nbsp;</td>
          </tr>
          <%}}else{ %>
          <tr  class="datagrid">
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          </tr>
          <tr  class="datagrid">
          <td colspan="2" align="center"> - No Record Found - &nbsp;</td>
          </tr>
          <tr  class="datagrid">
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          </tr>
          <%} %>
        </table>
        <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center"style="border-left: 0px;border-right: 0px;border-bottom: 0px;" id="ifrmtab">
          <tr  class="datagrid">
          <td width="30%">Select To User ID  &nbsp;&nbsp;&nbsp;&nbsp; <input type="text" name="txttousrid" size="10">&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="txttousrname" value=""  size="20">&nbsp;<a
																	href="#" onClick="javascript:callUsersTo()"><img
																	src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
																	border="0"> </a></td>
          <td width="30%" align="center"><input type="button" name="cmdtransfer" value="Transfer" class="buttonOthers" onclick="doTransfer()"></td>
          </tr>
        </table>
        </td>
        </tr>
        </table>
  

  <lapschoice:combuttonnew btnnames='Reset'
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
	  <lapschoice:hiddentag pageid="<%=PageId%>"/> 
	  <input type="hidden" name="hidfromorgcode" value="<%=Helper.correctNull((String)hshValues.get("hidfromorgcode"))%>">
	  <input type="hidden" name="hidtoorgcode" value="<%=Helper.correctNull((String)hshValues.get("hidtoorgcode"))%>">
	  <input type="hidden" name="strLinkFrom" value="<%=Helper.correctNull((String)request.getParameter("strLinkFrom"))%>">
</form>
</body>
</html>