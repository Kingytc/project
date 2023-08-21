<%@ include file="../share/directives.jsp"%>
<%ArrayList arrRow=new ArrayList(); 
ArrayList arrCol=new ArrayList();

arrRow=(ArrayList)hshValues.get("arryRow");
%>
<html>
<head>
<title>LAPS-Setup Reports Navigation</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varGrpRights="<%=(Helper.correctNull((String)session.getAttribute("strGroupRights"))).charAt(18)%>";

function doClose()
{
	if (ConfirmMsg("100"))
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/cusgrp_managementnav.jsp";
		document.forms[0].submit();
	}	
}
function doNew()
{
	document.forms[0].hidAction.value="insert";
	disableCommandButtons(true,true,true,false,false,false);
	document.forms[0].txt_groupname.readOnly=false;
	document.forms[0].txt_groupname.value="";
	document.forms[0].hidgroupID.value="";
}
function doEdit()
{
	document.forms[0].hidAction.value="update";
	disableCommandButtons(true,true,true,false,false,false);
	document.forms[0].txt_groupname.readOnly=false;
}
function doSave()
{
	if(document.forms[0].txt_groupname.value=="")
	{
		alert("Enter Group Name");
		return;
	}
	document.forms[0].txt_groupname.readOnly=false;
	document.forms[0].hidBeanId.value="mastapplicant";
	document.forms[0].action=appURL+"action/setcusgroupcreation.jsp";
	document.forms[0].hidBeanGetMethod.value="updateCusGroupMgmt";		
	document.forms[0].submit();
}
function doDelete()
{
	if(document.forms[0].hidDeleteFlag.value=="")
	{
		if(document.forms[0].hidMemcount.value=="0" || document.forms[0].hidMemcount.value=="")
		{
			if(document.forms[0].hidUpdateFlag.value=="Y")
			{
				alert("Please Update customer profile for this group");
				return;
			}
			else
			{				
				document.forms[0].txt_groupname.readOnly=false;
				document.forms[0].hidAction.value="delete";
				document.forms[0].hidBeanId.value="mastapplicant";
				document.forms[0].action=appURL+"action/setcusgroupcreation.jsp";
				document.forms[0].hidBeanGetMethod.value="updateCusGroupMgmt";		
				document.forms[0].submit();
			}
		}
		else if(document.forms[0].hidMemcount.value=="1")
		{
			alert("There is "+document.forms[0].hidMemcount.value+" member in this Group so you cannot delete this group.");
			return;
		}
		else 
		{
			alert("There are "+document.forms[0].hidMemcount.value+" members in this Group so you cannot delete this group.");
			return;
		}
	}
	else
	{
		alert("The Group members ("+document.forms[0].hidDeleteFlag.value+") have some approved applications. so you cannot remove this group. Please Modify their Profile");
		return;
	}
}
function disableCommandButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdnew.disabled=bool1;
  	document.forms[0].cmdedit.disabled=bool2;
  	document.forms[0].cmddelete.disabled=bool3;
  	document.forms[0].cmdsave.disabled=bool4;
  	document.forms[0].cmdcancel.disabled=bool5;
  	document.forms[0].cmdclose.disabled=bool6;
}
function callOnLoad()
{
	if(varGrpRights=='r')
		disableCommandButtons(true,true,true,true,true,false);
	else
		disableCommandButtons(false,true,true,true,true,false);
	
	document.forms[0].txt_groupname.readOnly=true;
	
}
function doCancel()
{
	document.forms[0].hidBeanId.value="mastapplicant";
	document.forms[0].action=appURL+"action/setcusgroupcreation.jsp";
	document.forms[0].hidBeanGetMethod.value="getCusGroupMgmt";	
	document.forms[0].submit();
}
function selectValues(val1,val2,val3,val4,val5)
{
	if(varGrpRights=='r')
		disableCommandButtons(true,true,true,true,true,false);
	else
		disableCommandButtons(true,false,false,true,true,false);
	
	document.forms[0].hidgroupID.value=val1;
	document.forms[0].txt_groupname.value=val2;
	document.forms[0].hidDeleteFlag.value=val3;
	document.forms[0].hidMemcount.value=val5;
	document.forms[0].hidUpdateFlag.value=val4;
}

</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<link rel="stylesheet" 	href="<%=ApplicationParams.getAppUrl()%>css/style_tab.css" type="text/css">
</head>
<body onload="callOnLoad();">
<form class="normal">
<table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td class="page_flow">Home -&gt; Customer Group Management -&gt; Customer Group Creation  <br> <br></td>
   </tr>
</table>
  <table class="outertable"  width="50%" border="0" cellspacing="0" cellpadding="3" class="outertable border1" align="center">
    <tr> 
      <td valign="top"> 
      <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor" align="center">
       <tr><td class="dataheader">Customer Group Creation</td></tr>
       <tr><td>&nbsp;</td></tr>
      <tr>
      <td>
        <table class="outertable"  width="50%" border="0" cellspacing="0" cellpadding="4" class="outertable" align="center">
          <tr> 
            <td align="center">Group Name</td>
            <td><input type="text" name="txt_groupname">
            <input type="hidden" name="hidgroupID" ></td>
          </tr>
        </table>
      </td>
    </tr>
    <tr><td>&nbsp;</td></tr>
    <tr>
    <td>
    <lapschoice:combuttonnew btnnames='New_Edit_Save_Delete_Cancel' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
    </td>
    </tr>
  </table><br>
  </td>
  </tr>
  </table>
  <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
    <tr> 
      <td valign="top"> 
      <table class="outertable"  width="50%" border="0" cellspacing="1" cellpadding="4" class="outertable" align="center">
       <tr class="dataheader" align="center">
       <td width="5%">&nbsp;</td>
       <td width="45%">Group ID&nbsp;</td>
       <td  width="50%">Group Name&nbsp;</td>
       </tr>
       <%if(arrRow!=null && arrRow.size()>0){ 
       for(int i=0;i<arrRow.size();i++){
       arrCol=(ArrayList)arrRow.get(i);%>
        <tr class="datagrid">
       <td align="center"><input type="radio" name="rad" onclick="selectValues('<%=Helper.correctNull((String)arrCol.get(0)) %>','<%=Helper.correctNull((String)arrCol.get(1)) %>','<%=Helper.correctNull((String)arrCol.get(2)) %>','<%=Helper.correctNull((String)arrCol.get(3)) %>','<%=Helper.correctNull((String)arrCol.get(4)) %>');" style="border: none;"></td>
       <td align="center"><%=Helper.correctNull((String)arrCol.get(0)) %>&nbsp;</td>
       <td align="center"><%=Helper.correctNull((String)arrCol.get(1)) %>&nbsp;</td>
       <%}} %>
       </tr>
  </table>
  </td>
  </tr>
  </table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
  <input type="hidden" name="hidPage">
  <input type="hidden" name="hidusr_id">
  <input type="hidden" name="hidDeleteFlag">
  <input type="hidden" name="hidMemcount">
  <input type="hidden" name="hidUpdateFlag">
</form>
</body>
</html>
