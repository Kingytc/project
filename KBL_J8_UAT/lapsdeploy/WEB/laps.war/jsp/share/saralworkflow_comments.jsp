<%@include file="../share/directives.jsp"%>
<%String strComment="";%>
<html>
<head>
<title>Workflow Comments</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL      ="<%=ApplicationParams.getAppUrl()%>";
var strUserId='<%=(String)session.getAttribute("strUserId")%>';
var Hidflag = "<%=Helper.correctNull((String)hshValues.get("Hidflag"))%>";
var editoption = '<%=request.getParameter("editoption").trim()%>';
var varaction = '<%=Helper.correctNull((String)hshValues.get("strAction"))%>';
function onloading()
{
	if(editoption=="N")
	{
		document.forms[0].cmdedit.disabled=true;
	}
	else
	{
		document.forms[0].cmdedit.disabled=false;
		if(varaction=="edit")
		{
			window.opener.document.forms[0].hidconfirm.value="Y";
			document.forms[0].cmdedit.disabled=true;
		}
	}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].cmdcancel.disabled=true;
}
function doEdit()
{	
	document.forms[0].comments.disabled=false;
	document.forms[0].comments.readOnly=false;
	document.forms[0].cmdedit.disabled=true;
	document.forms[0].cmdsave.disabled=false;
	document.forms[0].cmdcancel.disabled=false;
	document.forms[0].cmdclose.disabled=true;
}
function doSave()
{
	if(checktrim(document.forms[0].comments.value)=="")
	{	
		ShowAlert(121,"Current Remarks");
		document.forms[0].comments.focus();
	}
	else
	{
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].hidAction.value="edit";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="inwardRegister";
		document.forms[0].hidBeanMethod.value="updateInwardremarks";
		document.forms[0].hidBeanGetMethod.value="getInwardremarks";
		document.forms[0].hidSourceUrl.value="/action/saralworkflow_comments.jsp";
		document.forms[0].submit();
		
	}
	if(window.opener.document.forms[0].hidAction.value=='send')
	{
		alert("Close the window and then click SEND");
	}
	else if(window.opener.document.forms[0].hidAction.value=='reject')
	{
		alert("Close the window and then click RESEND");
	}
}
function doCancel()
{	
	if(ConfirmMsg('102'))
	{
		document.forms[0].comments.value="";
		document.forms[0].comments.readOnly=true;
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}
}
function doClose()
{	
	if(ConfirmMsg('100'))
	{
		window.close();
	}
}
</script>

</head>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<body onload="onloading()">
<form name="frmsaralremarks" method="post" class="normal"> 
	<lapschoice:inward /> 
<b>Workflow Comments</b><br>
  	<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable" align="center">
    <tr> 
      <td valign="top"> 
         <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
          <tr> 
            <td colspan="6"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
                <tr> 
                  <td> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                      <tr> 
                        <td>Enter Current Recommendations</td>
                      </tr>
                      <tr> 
                        <td align="center"> 
                            <textarea name="comments" cols="110" wrap="VIRTUAL" rows="8" onKeyPress="textlimit(this,1950)" onKeyUp="textlimit(this,1950)" disabled="disabled"></textarea>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td valign="top" colspan="6"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
                <tr> 
                  <td> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                      <tr> 
                        <td>Earlier Recommendations</td>
                      </tr>
                      <tr> 
                        <td align="center">
                        <%
                        ArrayList arrRow= new ArrayList();
                        ArrayList arrCol= new ArrayList();
                        arrRow =(ArrayList)hshValues.get("arrRow");
                        if(arrRow!=null && arrRow.size() > 0)
                        {
                			if (arrRow.size() > 0) 
                			{
	                			for (int i = 0; i < arrRow.size(); i++) 
	                			{
	                				arrCol = (ArrayList) arrRow.get(i);	                				
	                				strComment=strComment + Helper.correctNull((String)arrCol.get(2))+ " - " +
	                				Helper.correctNull((String)arrCol.get(5))+" - " +
	                				Helper.correctNull((String)arrCol.get(7))+" - "+" -  sends to "+ 
	                				Helper.correctNull((String)arrCol.get(4))+" - " +
	                				Helper.correctNull((String)arrCol.get(6))+" - " +
	                				Helper.correctNull((String)arrCol.get(8))+" - " 
	                				+" on "+
	                				Helper.correctNull((String)arrCol.get(3))+" ---\n"+
	                				Helper.correctNull((String)arrCol.get(1))+"\n"+
	    							"-----------------------------------------------------------------------------"+
	    							"-----------------------------------------------------------\n";	                				
	                				;
	                			}
                			}
                		}%>
					 <textarea name="txtearaud_text" cols="110"  rows="12" readOnly="readonly"> <%=strComment%> </textarea>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <br>
  <lapschoice:combuttonnew btnnames='Edit_Save_Cancel' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<lapschoice:hiddentag/>
<input type="hidden" name="hidorghead" value="<%=Helper.correctNull((String)hshValues.get("orghead"))%>">
<input type="hidden" name="hidsaralhead" value="<%=Helper.correctNull((String)hshValues.get("saralhead"))%>">
<input type="hidden" name="hidflag">
<input type="hidden" name="editoption" value="<%=Helper.correctNull((String)request.getParameter("editoption")).trim()%>">
<input type="hidden" name="hidmail_tousrid" value="<%=Helper.correctNull((String)request.getParameter("hidmail_tousrid")).trim()%>">


</form>
</body>
</html>
