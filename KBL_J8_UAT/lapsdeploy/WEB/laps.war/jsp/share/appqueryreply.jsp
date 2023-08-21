<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Query/Reply</title>
<script>
var varStatus="<%=Helper.correctNull((String)hshValues.get("strStatus"))%>";
var varRaisedby="<%=Helper.correctNull((String)hshValues.get("aq_raisedby"))%>";
var strUserId="<%=Helper.correctNull((String)hshValues.get("strUserId"))%>";
var varhidType="<%=Helper.correctNull((String)request.getParameter("hidType"))%>";


function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/com_permission.jsp";
		document.forms[0].submit();
	}
}
function doSendReply()
{
	document.forms[0].hidAction.value="reply";
	document.forms[0].hidBeanId.value="documentsupport";
	document.forms[0].hidBeanGetMethod.value="UpdateQueryDetails";
	document.forms[0].action=appURL+"action/appqueryreply.jsp";
	document.forms[0].submit();
}
function doCloseQuery()
{
	document.forms[0].hidAction.value="CloseQuery";
	document.forms[0].hidBeanId.value="documentsupport";
	document.forms[0].hidBeanGetMethod.value="UpdateQueryDetails";
	document.forms[0].action=appURL+"action/appqueryreply.jsp";
	document.forms[0].submit();
}
function callOnLoad()
{
	if(varhidType=="REQ")
	{
		if(varRaisedby==strUserId)
		{
			document.forms[0].cmdsendreply.disabled=true;
		}
	}
	
	if(varhidType=="RES")
	{
		//if(varRaisedby!=strUserId)
		{
			document.forms[0].cmdclosequery.disabled=true;
		}
	}		
	if(varStatus!="")
	{
		document.forms[0].action = appURL + "action/querySearch_dev.jsp";
		document.forms[0].submit();
	}
}
</script>
</head>
<body onload="callOnLoad();">
<form name="frm" method="post" class="normal">
<br><br/>
<table  width="70%" border="0" cellspacing="0" cellpadding="3" class="outertable border1" align="center">
<tr>
<td>
<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center">
<tr class="dataheader">
<td colspan="2">Query Details</td>
</tr>
  <tr class="datagrid"> 
    <td width="10%" nowrap="nowrap">Proposal No</td>
    <td width="20%"><%=Helper.correctNull((String)hshValues.get("aq_appno")) %>&nbsp;</td>
  </tr>
  <tr class="datagrid">
   <td width="10%" nowrap="nowrap">Sent By</td>
    <td width="20%"><%=Helper.correctNull((String)hshValues.get("aq_raisedby")) %>&nbsp;</td>
  </tr> 
  <tr class="datagrid">
   <td width="10%" nowrap="nowrap">Sent On</td>
    <td width="20%"><%=Helper.correctNull((String)hshValues.get("aq_raisedon")) %>&nbsp;</td>
  </tr>
  <%if(Helper.correctNull((String)request.getParameter("hidType")).equalsIgnoreCase("RES")){ %>  
  <tr class="datagrid">
   <td width="10%" nowrap="nowrap">Replied By</td>
    <td width="20%"><%=Helper.correctNull((String)hshValues.get("aq_repliedby")) %>&nbsp;</td>
  </tr> 
  <tr class="datagrid">
   <td width="10%" nowrap="nowrap">Replied On</td>
    <td width="20%"><%=Helper.correctNull((String)hshValues.get("aq_repliedon")) %>&nbsp;</td>
  </tr>
  <%} %>
  <tr>
  <td class="datagrid"><b>Query</b></td>
  <td><span style="color: red;"><%=Helper.correctNull((String)hshValues.get("aq_query")) %></span>&nbsp;</td>
  </tr>
  <%if(Helper.correctNull((String)request.getParameter("hidType")).equalsIgnoreCase("REQ")){ %>  
  <tr class="datagrid">
  <td class="datagrid"><b>Reply</b></td>
  <td><textarea name="txt_response" cols="100"  rows="13" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" tabindex="4"></textarea>&nbsp;</td>
  </tr>
  <%}else{ %>
  <tr height="100">
  <td class="datagrid"><b>Reply</b></td>
  <td><span style="color: green;"><%=Helper.correctNull((String)hshValues.get("aq_reply")) %></span>&nbsp;</td>
  </tr>
  <%} %>
</table> 
</td>
</tr>
</table>
<br>   
<%if(Helper.correctNull((String)request.getParameter("hidType")).equalsIgnoreCase("REQ")){ %>                          
<lapschoice:combuttonnew btnnames="Send Reply" btnenable='Y'/>
<%}else{ %>
<lapschoice:combuttonnew btnnames="Close Query" btnenable='Y'/>
<%} %>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidsno" value="<%=Helper.correctNull((String)hshValues.get("aq_sno")) %>">
<input type="hidden" name="appno" value="<%=Helper.correctNull((String)hshValues.get("aq_appno")) %>">
<input type="hidden" name="hidType" value="<%=Helper.correctNull((String)request.getParameter("hidType")) %>">
</form>
</body>
</html>
