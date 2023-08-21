<%@include file="../share/directives.jsp"%>
<%String Valuesin=Helper.correctNull((String) request.getParameter("valuesin"));%>
<html>
<head>
<title>Proposal</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varbrn_level="<%=Helper.correctNull((String)hshValues.get("branch_level"))%>";
var varOrgLevel="<%=strOrgLevel%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";

function placeValues()
{
	disableFields(true);
	if(varbrn_level!="")
	{
		document.forms[0].sel_level.value=varbrn_level;
	}
	else
	{
		document.forms[0].sel_level.value="S";
	}
	/*if(varOrgLevel==varbrn_level && document.forms[0].btnenable.value=="Y")
	{
		enableButtons(false,true,true,true,false);
	}
	else
	{
	  enableButtons(true,true,true,true,false);
	}*/
}
function disableFields(val)
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=='text')
		 	{
				document.forms[0].elements[i].readOnly=val;
			}
			 if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
		}
	}
function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="broadsancterms"
		document.forms[0].hidpagedesc.value="branchcomments";
		document.forms[0].hidBeanGetMethod.value="getOrgrecmds";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_bstbranchcomments.jsp";
		document.forms[0].submit();
	 }	
}
function doDelete()
{
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete"
	 	document.forms[0].hidBeanId.value="broadsancterms"
	    document.forms[0].hidpagedesc.value="branchcomments";
		document.forms[0].hidBeanMethod.value="updateOrgrecmds";
		document.forms[0].hidBeanGetMethod.value="getOrgrecmds";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_bstbranchcomments.jsp";
 		document.forms[0].submit();
	 }
}
function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}
function doEdit()
{
	disableFields(false);
	enableButtons(true,false,false,false,true)
}
function doSave()
{		
	enableButtons(true,true,true,true,false);
	document.forms[0].hidAction.value="update"
	document.forms[0].hidBeanId.value="broadsancterms"
	document.forms[0].hidpagedesc.value="branchcomments";
	document.forms[0].hidBeanMethod.value="updateOrgrecmds";
	document.forms[0].hidBeanGetMethod.value="getOrgrecmds";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/com_bstbranchcomments.jsp";
	document.forms[0].submit();
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/combstpge.jsp";
		document.forms[0].submit();
	}
}
function callCalender(val)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		 showCal(appURL,val);
	}
}
function callLink1(page,bean,method)
{	
	 document.forms[0].hidAction.value="";
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].hidpagedesc.value="creditrating~promotorsbackground~projectnature~loanpolicy~guarantee";
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
}
function getValues()
{
		document.forms[0].hidBeanId.value="broadsancterms"
		document.forms[0].hidpagedesc.value="branchcomments";
		document.forms[0].hidBeanGetMethod.value="getOrgrecmds";
		document.forms[0].action=appURL+"action/com_bstbranchcomments.jsp";
		document.forms[0].submit();
}
function doPrint()
{		
	var appno="<%=request.getParameter("appno")%>";
	var CompanyName="<%=request.getParameter("appname")%>";	
	var varvaluesin="<%=Valuesin%>";
	var purl ="<%=ApplicationParams.getAppUrl()%>action/com_bstapprovalprintout.jsp?hidBeanGetMethod=getBSTApprovalprint&hidBeanId=broadsancterms&appno="+appno+"&CompanyName="+CompanyName+"&comid="+document.forms[0].com_id.value+"&valuesin="+varvaluesin;
	var prop = 'scrollbars=yes,menubar=yes,status=yes,width=750,height=520';	
	var xpos = (screen.width - 750) / 2;
	var ypos = (screen.height - 520) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'BroadTermsProposal',prop);
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="placeValues()">
<form name="frmpri" method="post" class="normal">
<lapstab:applurllinkbst pageid='8' category='bst' valuesin='<%=Valuesin%>' />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr>
<td class="page_flow">Corporate &amp; SME -&gt; Broad Terms of Proposal -&gt; Recommending Office Comments</td>
</tr>
</table>
<lapschoice:BST/><br>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
    <tr> 
    <td>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td colspan="5">&nbsp;</td>
    </tr>
    <tr> 
      <td>Select Organisation</td>
      <td colspan="4"> 
        <select name="sel_level" onchange="getValues()">
          <option value="S" selected>&lt;---Select---&gt;</option>
          <option value="C">Central Office</option>
          <option value="R">FGMO</option>
          <option value="D">Region</option>
          <option value="A">Branch</option>
        </select>
      </td>
    </tr>
    <tr> 
      <td  colspan="5">&nbsp;</td>
    </tr>
    <tr> 
      <td width="15%">Reference No</td>
      <td width="20%" > 
        <input type="text" name="txt_orgrefno" size="35" maxlength='30' value="<%=Helper.correctNull((String)hshValues.get("refno"))%>">
      </td>
      <td width="20%" >Date of Broad Terms Proposal</td>
      <td width="22%" > 
        <input type="text" name="txt_orgbstdate" size="12" maxlength='10' value="<%=Helper.correctNull((String)hshValues.get("datebst"))%>"
        onBlur="checkDate(this);checkmaxdate(this,currentDate)">
        <a alt="Select date from calender" href="#"
					onClick="callCalender('txt_orgbstdate')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
					alt="Select date from calender"></a> </td>
      <td width="23%" >&nbsp;</td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td colspan="2">&nbsp;</td>
    </tr>
    <tr> 
      <td  colspan="2"> Comments</td>
      <td>&nbsp;</td>
      <td colspan="2">Signatories</td>
    </tr>
    <tr> 
      <td  colspan="2"> 
        <textarea name="txt_orgcomments" cols="80" wrap="VIRTUAL" rows="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("orgcomments"))%></textarea>
      </td>
      <td>&nbsp; </td>
      <td  colspan="2"> 
        <textarea name="txt_orgsignatories" cols="95" rows="10" 
           onKeyUp="textlimit(this,3999)" onKeyPress="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("signatures"))%></textarea>
      </td>
    </tr>
    <tr> 
      <td  colspan="5">&nbsp;</td>
    </tr>
  </table>  
  </td>
  </tr>
  </table>                            
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Print' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidpagedesc" > 
</form>
</body>
</html>

