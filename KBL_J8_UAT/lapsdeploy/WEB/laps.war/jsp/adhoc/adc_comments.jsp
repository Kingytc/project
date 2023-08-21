<%@include file="../share/directives.jsp"%>
<%
ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();
arrRow=(ArrayList)hshValues.get("arrRow");
%>
<html>
<head>
<title>Modification in Sanction Terms</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<script>

var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varsancauth="<%=Helper.correctNull((String)hshValues.get("adccom_sanctauth"))%>";

function placeValues()
{
	disableFields(true);
}

function disableFields(val)
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			 if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
			else if(document.forms[0].elements[i].type=="select-one")
			{
			  document.forms[0].elements[i].disabled=val;		  
			}
		}
	}
function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="adhoc"
		document.forms[0].hidBeanGetMethod.value="getComments";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/adc_comments.jsp";
		document.forms[0].submit();
	 }
	
}
function doDelete()
{
	
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete"
	 	document.forms[0].hidBeanId.value="adhoc"
		document.forms[0].hidBeanMethod.value="updateComments";
		document.forms[0].hidBeanGetMethod.value="getComments";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/adc_comments.jsp";
 		document.forms[0].submit();
	 }
}
function enableButtons(bool2,bool3,bool4,bool5,bool6)
{
	
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;

}

function doEdit()
{
	disableFields(false);
	enableButtons(true,false,false,false,true)
	document.forms[0].hidAction.value="insert";
}


function doSave()
{
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="adhoc"
	document.forms[0].hidBeanMethod.value="updateComments";
	document.forms[0].hidBeanGetMethod.value="getComments";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/adc_comments.jsp";
	document.forms[0].submit();
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/corppge.jsp";
		document.forms[0].submit();
	}
	
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>

<body onload="placeValues()">
<form name="recommendation" method="post" class="normal">

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr> 
	      <td valign="top"> 
	        <jsp:include page="../share/applurllinkscom.jsp" flush="true">         
	        <jsp:param name="pageid" value="5" />
	        <jsp:param name="cattype" value="<%=strCategoryType%>" />
	        <jsp:param name="ssitype" value="<%=strSSIType%>" />
	        </jsp:include>
	      </td>
	</tr>
	<tr>
      <td class="page_flow"> Home -&gt; Corporate &amp; SME  -&gt; Ad hoc Limit -&gt; Comments</td>
</tr>
</table>
  <lapschoice:borrowertype /><lapschoice:application/>

  <table width="100%" border="0" cellspacing="2" cellpadding="3" class="outertable">
    <tr> 
      <td width="52%">Value of Account</td>
      </tr>
    <tr> 
      <td width="52%"> 
        <textarea name="txt_valueacc" cols="80" rows="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("adccom_valueaccount"))%></textarea>
      </td>
     </tr>
    <tr> 
      <td colspan="2">&nbsp;</td>
    </tr>
     <tr> 
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td>&nbsp; </td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="2">&nbsp;</td>
    </tr>
   <lapschoice:combuttonnew btnnames="Edit_Save_Delete_Cancel"
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
    </table>
                              
<br>
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
 <input type="hidden" name="hidsno" />
 </form>
</body>
</html>

