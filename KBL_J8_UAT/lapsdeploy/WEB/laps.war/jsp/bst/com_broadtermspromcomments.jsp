<%@include file="../share/directives.jsp"%>
<%String Valuesin=Helper.correctNull((String) request.getParameter("valuesin"));
java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
nf.setGroupingUsed(false);
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
%>
<html>
<head>
<title>BST - Comments</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag="<%=Helper.correctNull((String)hshValues.get("recordflag"))%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
function placeValues()
{
	disableFields(true);
}
function disableFields(val)
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
			else if(document.forms[0].elements[i].type=="select-one")
			{
			 document.forms[0].elements[i].disabled=val;
			}
			else if(document.forms[0].elements[i].type=="textarea")
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
		document.forms[0].hidpagedesc.value="creditrating','procfees','promotorsbackground','loanpolicy','projectnature','guarantee";
		document.forms[0].hidBeanGetMethod.value="getBroadTermsProposalComments";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_broadtermspromcomments.jsp";
		document.forms[0].submit();
	 }	
}
function doDelete()
{
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete"
	 	document.forms[0].hidBeanId.value="broadsancterms"
	 	document.forms[0].hidpagedesc.value="creditrating','procfees','promotorsbackground','loanpolicy','projectnature','guarantee";
		document.forms[0].hidBeanMethod.value="updateBroadTermsProposalComments";
		document.forms[0].hidBeanGetMethod.value="getBroadTermsProposalComments";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_broadtermspromcomments.jsp";
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
	document.forms[0].hidpagedesc.value="creditrating','procfees','promotorsbackground','loanpolicy','projectnature','guarantee";
	document.forms[0].hidBeanMethod.value="updateBroadTermsProposalComments";
	document.forms[0].hidBeanGetMethod.value="getBroadTermsProposalComments";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/com_broadtermspromcomments.jsp";
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
function callLink1(page,bean,method)
{	
	 document.forms[0].hidAction.value="";
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].hidpagedesc.value="loanpolicy','customerprofitability";
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="placeValues()">
<form name="frmbstcomments" method="post" class="normal">
<lapstab:applurllinkbst pageid='6' category='bst' valuesin='<%=Valuesin%>'/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr>
<td class="page_flow">
	Corporate &amp; SME -&gt; Broad Terms of Proposal -&gt; Comments
</td>
</tr>
</table>
<lapschoice:BST/><br>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
    <tr>
    <td>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">    
    <tr> 
      <td width="20%">Credit Rating</td>
      <td> 
        <input type="text" name="comments" size="13" maxlength='10' value="<%=Helper.correctNull((String)hshValues.get("creditrating"))%>">
      </td>
	  <td>Upfront/ Processing Fees</td>
	  <td>
	  	<input type="text" name="comments" size="40" maxlength='20' style="text-align:right" onBlur="roundtxt(this)" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("procfees"))))%>">
	  </td>
    </tr>
    <tr> 
      <td colspan="4">&nbsp;</td>
    </tr>
    <tr> 
      <td width="40%" colspan="2">Background of promotors</td>
      <td width="5%">&nbsp;</td>
      <td width="40%">Whether conforms to Loan policy </td>
    </tr>
    <tr> 
      <td width="40%" colspan="2" > 
        <textarea name="comments" cols="80" wrap="VIRTUAL" rows="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" ><%=Helper.correctNull((String)hshValues.get("promotorsbackground_comments"))%></textarea>
      </td>
      <td width="5%">&nbsp;</td>
      <td width="40%" > 
        <textarea name="comments" cols="80" wrap="VIRTUAL" rows="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("loanpolicy_comments"))%></textarea>
      </td>
    </tr>
    <tr> 
      <td  colspan="4">&nbsp;</td>
    </tr>
    <tr> 
      <td width="40%" colspan="2" >Nature of the Project</td>
      <td width="5%">&nbsp;</td>
      <td width="40%">Personal Guarantee/Corporate Guarantee</td>
    </tr>
    <tr> 
      <td width="40%" colspan="2"> 
        <textarea name="comments" cols="80" wrap="VIRTUAL" rows="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("projectnature_comments"))%></textarea>
      </td>
      <td width="10%">&nbsp;</td>
      <td width="40%"  > 
        <textarea name="comments" cols="80" wrap="VIRTUAL" rows="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("guarantee_comments"))%></textarea>
      </td>
    </tr>
  </table>
  </td>
  </tr>
  </table>
 <br>                             
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidpagedesc" > 
<input type="hidden" name="sel_level" value="0"> 
</form>
</body>
</html>