<%@ include file="../share/directives.jsp"%>
<%
ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();
int arrSize=0;
if(hshValues!=null)
{
	arrRow=(ArrayList)hshValues.get("arrRow");
	if(arrRow!=null)
	arrSize=arrRow.size();
}
%>
<html>
<head>
<title>LAPS-Setup Reports Navigation</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varstatus="<%=Helper.correctNull((String)hshValues.get("updateprofile"))%>";
var varupdatecusprofile="<%=Helper.correctNull((String)hshValues.get("updatecusprofile"))%>";
var varstrProcessedAppID="<%=Helper.correctNull((String)hshValues.get("strProcessedAppID"))%>";
var varsize="<%=arrSize%>";
var varGrpRights="<%=(Helper.correctNull((String)session.getAttribute("strGroupRights"))).charAt(18)%>";
function doClose()
{
	if (ConfirmMsg("100"))
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/cusgrp_managementnav.jsp";
		document.forms[0].submit();
	}	
}
function doRemove(varsno)
{
	if(varGrpRights=='r')
	{
		return;
	}
	if(varstrProcessedAppID=="")
	{
		if(ConfirmMsg(193))
		{
			document.forms[0].hidLAPSID.value=varsno;
			document.forms[0].hidAction.value="remove";
			document.forms[0].hidBeanId.value="mastapplicant";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].hidBeanMethod.value="updateCusGroupMembersMgmt";		
			document.forms[0].hidBeanGetMethod.value="getCusGroupMembersMgmt";
			document.forms[0].hidSourceUrl.value="/action/setcusgroupmem_mgt.jsp";		
			document.forms[0].submit();
		}
	}
	else
	{
		alert("Group members have some approved applications. so you cannot remove members from this group. please modify this customer profile ("+varstrProcessedAppID+").");
		return;
	}
}
function  doAddMembersToThisGroup()
{
	if(document.forms[0].txt_groupname.value!="")
	{
			var	varQryString = appURL+"action/cusgroup_applicantidhelp.jsp";
			var title = "ApplicantIDHelp";
			var prop = "scrollbars=yes,width=600,height=400,status=yes";	
			prop = prop + ",left=50,top=50";		
			window.open(varQryString,title,prop);
	}
	else
	{
		alert("Please select the group");
		return;
	}
}
function showGroup()
{
	var varQryString = appURL+"action/cusgrouplist.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getCusGroupMgmt";
	var title = "ProductsSearch";
	var prop = "scrollbars=no,width=450,height=350,status=yes";	
	prop = prop + ",left=350,top=150";		
	window.open(varQryString,title,prop);
}
function callOnLoad()
{
	document.forms[0].txt_groupname.readOnly=true;
	if(document.forms[0].txt_groupname.value=="")
	{
		document.forms[0].cmdaddmemberstothisgroup.disabled=true;
	}
	document.forms[0].cmdupdatecustomerprofile.disabled=true;
	if(varstatus=="SUCCESS")
	{
		alert("Customer Profile Updated Successfully");
	}
	if(varupdatecusprofile=="Y")
	{
		alert("Please Click Update Customer Profile");
		document.forms[0].cmdupdatecustomerprofile.disabled=false;
	}
	if(varGrpRights=='r')
	{
		document.forms[0].cmdaddmemberstothisgroup.disabled=true;
		document.forms[0].cmdupdatecustomerprofile.disabled=true;
	}
}
function doUpdateCustomerProfile()
{
	if(varstrProcessedAppID=="")
	{
		document.forms[0].hidAction.value="profileupdate";
		document.forms[0].hidBeanId.value="mastapplicant";
		document.forms[0].action=appURL+"action/setcusgroupmem_mgt.jsp";
		document.forms[0].hidBeanGetMethod.value="updateCustomerProfileGroupMembers";
		document.forms[0].submit();
	}
	else
	{
		alert(varstrProcessedAppID+" member have some approved applications. Please Modify their Customer Profile before proceeding");
		return;
	}
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<link rel="stylesheet" 	href="<%=ApplicationParams.getAppUrl()%>css/style_tab.css" type="text/css">
</head>
<body onload="callOnLoad();">
<form class="normal" method="post">
<table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td class="page_flow">Home -&gt; Customer Group Management -&gt; Addition &amp; Deletion of Group Members</td>
  </tr>
</table>
  <table class="outertable"  width="70%" border="0" cellspacing="0" cellpadding="5" class="outertable border1" align="center">
    <tr> 
      <td valign="top"> 
      <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="4" class="outertable">
       <tr><td class="dataheader">Addition &amp; Deletion of Group Members</td></tr>
       <tr><td>&nbsp;</td></tr>
      <tr>
      <td>
        <table class="outertable"  width="50%" border="0" cellspacing="0" cellpadding="4" class="outertable" align="center">
          <tr> 
            <td align="center">Group Name</td>
            <td><input type="hidden" name="hidgroupID" id="hidgroupID" value="<%=Helper.correctNull((String)hshValues.get("strGroupID")) %>">
            <input type="text" name="txt_groupname" id="txt_groupname" value="<%=Helper.correctNull((String)hshValues.get("strGroupName")) %>">
            <span onClick="showGroup()" style="cursor:hand"><img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
												 border="0"></span>
          </tr>
        </table>
      </td>
    </tr>
    <tr><td>&nbsp;</td></tr>
    <tr>
    <td>
    <lapschoice:combuttonnew btnnames='Add Members to this Group_Update Customer Profile' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
    </td>
    </tr>
  </table><br>
  </td>
  </tr>
  </table>
  <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
    <tr> 
      <td valign="top"> 
      <table class="outertable"  width="70%" border="0" cellspacing="1" cellpadding="4" class="outertable" align="center">
       <tr class="dataheader" align="center">
       <td width="5%">&nbsp;S.No</td>
       <td width="20%">Member LAPS ID&nbsp;</td>
       <td width="25%">Member CBS ID&nbsp;</td>
       <td  width="35%">Member Name&nbsp;</td>
       <td  width="15%">Remove&nbsp;</td>
       </tr>
       <%if(arrRow!=null && arrRow.size()>0){
    	   for(int i=0;i<arrRow.size();i++){
    		   arrCol=(ArrayList)arrRow.get(i);
    		   
    	   %>
        <tr class="datagrid">
       <td align="center">&nbsp;<%=i+1 %></td>
       <td>&nbsp;<%=Helper.correctNull((String)arrCol.get(1)) %></td>
       <td>&nbsp;<%=Helper.correctNull((String)arrCol.get(2)) %></td>
       <td>&nbsp;<%=Helper.correctNull((String)arrCol.get(3)) %></td>
       <td align="center"><img alt="Click to Delete Member" 
			src="<%=ApplicationParams.getAppUrl()%>img/delete.png" 
			onclick="doRemove('<%=Helper.correctNull((String)arrCol.get(1)) %>')" style="cursor:hand"/>&nbsp;</td>
       </tr>
       <%}}else{ %>
       <tr class="datagrid">
       <td colspan="5">&nbsp;</td>
       </tr>
       <tr class="datagrid" align="center">
       <td colspan="5"> -- No Record Found --&nbsp;</td>
       </tr>
       <tr class="datagrid">
       <td colspan="5">&nbsp;</td>
       </tr>
       <%} %>
  </table>
  </td>
  </tr>
  </table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
  <input type="hidden" name="hidPage">
  <input type="hidden" name="hidAppID">
<input type="hidden" name="hidAppOLDID">
<input type="hidden" name="hidAppCBSID">
<input type="hidden" name="hidAppName">
<input type="hidden" name="hidLAPSID">
</form>
</body>
</html>
