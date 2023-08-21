<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>General Comments</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var varCommenttype="<%=Helper.correctNull((String)hshValues.get("commenttype"))%>";
function doEdit()
{
	disableFields(false);
	if(document.forms[0].sel_commenttype.value=="0")
	{
		ShowAlert(111,'Comments');
		document.forms[0].sel_commenttype.focus();
	}
	else
	{
		
		document.forms[0].hidAction.value ="insert";
		disableCommandButtons("edit");	
		document.forms[0].txt_branchcomments.focus();
	}
}
function changeCommentType()
{	
	document.forms[0].hidBeanId.value="ADV1151";
	document.forms[0].hidBeanGetMethod.value="getGeneralComments";
	document.forms[0].hidSourceUrl.value="/action/adv_generalcomments.jsp"
	document.forms[0].submit();
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidSourceUrl.value="/action/adv_generalcomments.jsp";
		document.forms[0].hidBeanId.value="ADV1151";
		document.forms[0].hidBeanMethod.value="getGeneralComments";
		document.forms[0].hidBeanGetMethod.value="getGeneralComments";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();
	}	
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidSourceUrl.value="/action/adv_generalcomments.jsp";
		document.forms[0].hidBeanId.value="ADV1151";
		document.forms[0].hidBeanMethod.value="updateGeneralComments";
		document.forms[0].hidBeanGetMethod.value="getGeneralComments";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();
	}
}
function doSave()
{
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="ADV1151";
	document.forms[0].hidBeanMethod.value="updateGeneralComments";
	document.forms[0].hidBeanGetMethod.value="getGeneralComments";
	document.forms[0].hidSourceUrl.value="/action/adv_generalcomments.jsp";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}		  
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=val;
		}
	}	
}
function doClose()
{
	if(ConfirmMsg('100'))
	{
		document.forms[0].action=appUrl+"action/agrborrowersearch.jsp";
		document.forms[0].submit();
	}
}
function disableCommandButtons(val)
{	
	if(val=="edit")
	{	 
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;
		 document.forms[0].cmddelete.disabled=false;		 		 
		 document.forms[0].cmdclose.disabled=true;	
		 disableFields(false);
	}
}
function onLoading()
{
	if(varCommenttype!="")
	{
		document.forms[0].sel_commenttype.value=varCommenttype;
	}
	disableFields(true);	
}

function callLink(page,bean,method)
{		
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appUrl+"action/"+page;
		document.forms[0].submit();
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onLoading()">
<form name="form1" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td><jsp:include page="../share/applurllinkscom.jsp"
			flush="true">
			<jsp:param name="pageid" value="19" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<tr>
		<td class="page_flow">Home -&gt; Tertiary -&gt; Application -&gt; ADV1151 -&gt; General Comments</td>
	</tr>
</table>
<span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application /><br>
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center" >
    <tr class="dataheader"> 
    <td align="center"><b>GENERAL COMMENTS</b>
    </td>
    </tr>
    </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor" align="center" >
    <tr class="datagrid">      	
      <td width="33%">Comments</td> 	
   		<td width="25%"> 
   			<select name="sel_commenttype" tabindex="1" onChange="changeCommentType()">
    			<option value="0" selected="selected">----Select----</option>
    			<option value="1">Comments on management of business</option>
    			<option value="2">Opinion about borrower in market circles</option>
    			<option value="3">Income / wealth tax assessment extents statuatory 
          			dues such as PF/61/TDS. etc</option>				
    		</select>
    	</td>
    </tr>
    <tr class="datagrid">    	
      <td width="33%">Branch Comments</td>
   		<td width="67%">
    		<textarea rows="5" name="txt_branchcomments" tabindex="2" cols="50" maxlength="4000" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("branchcomment"))%></textarea>
    	</td>
    </tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr> 
      <td width="20%" ><b>&nbsp; 
        <a href="javascript:callLink('adv_commentsonstatus.jsp','ADV1151','getcommentsonstatus')"> 
        &lt;&lt; Previous </a>&nbsp;</b> </td>
      <td width="60%" align="center"><b> 
        <jsp:include page="../ADV11-51/adv_links.jsp" flush="true" /> 
        </b></td>
      <td width="20%">&nbsp; 
        <div align="right"><b>Pg.3/19 &nbsp;<a href="javascript:callLink('adv_dishonours.jsp','ADV1151','getdishonours')"> 
          Next &gt;&gt; </a></b></div>
      </td>
    </tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="pageval" value="FIA">
</form>
</body>
</html>
