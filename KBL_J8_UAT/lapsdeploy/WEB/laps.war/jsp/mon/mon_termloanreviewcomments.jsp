<%@include file="../share/directives.jsp"%>
<%
	String strComment="";
	HashMap hshRecord = new HashMap();
	String str=request.getParameter("cbsaccno");
%>
<html>
<head>
<title>Workflow Comments</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/set/navigate.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script>
var path ="<%=ApplicationParams.getAppUrl()%>";
var editoption = '<%=request.getParameter("editoption").trim()%>';
var strUserId='<%=(String)session.getAttribute("strUserId")%>';

function onloading()
{
	if(editoption=="N")
	{
		document.forms[0].cmdedit.disabled=true;
	}
	else
	{
		document.forms[0].cmdedit.disabled=false;
	}
	document.forms[0].comments.disabled=true;
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].cmdcancel.disabled=true;

}

function doEdit()
{	
	document.forms[0].comments.disabled=false;
	//document.forms[0].txt_pano.readOnly=false;
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
		return;
	}
	else
	{
	    window.opener.document.forms[0].remarksFlag.value ="true";
	  	document.forms[0].action=path+"controllerservlet";
		document.forms[0].hidBeanId.value="mailboxcomments";
		document.forms[0].hidBeanMethod.value="updateReviewTermLoanData";
		document.forms[0].hidBeanGetMethod.value="getReviewTermLoanData";
		document.forms[0].hidSourceUrl.value="/action/mon_termloanreviewcomments.jsp";
		document.forms[0].submit();
	}

	alert("Close the window and then click send");

}

function doCancel()
{	
	appno = document.forms[0].hidappno.value;
	if(ConfirmMsg('102'))
	{
		document.forms[0].comments.value="";
		document.forms[0].comments.readOnly=true;
		//document.forms[0].txt_pano.readOnly=true;
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
<form name="auditpage" method="post" class="normal"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
				<tr>
					<td>
						<lapschoice:MonitorReview />
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>    
    <i><b>Workflow Comments</b></i><br>
  <table width="100%" border="0" cellspacing="0" cellpadding="1"  align="center" class="outertable border1">
    <tr> 
      <td valign="top"> 
         <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
          <tr> 
            <td colspan="6"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                <tr> 
                  <td> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                      <tr> 
                        <td> Enter Current Recommendations</td>
                      </tr>
                      <tr> 
                        <td align="center"> 
                            <textarea name="comments" cols="100" wrap="VIRTUAL" rows="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" disabled="disabled"></textarea>
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
              <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                <tr> 
                  <td> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                      <tr> 
                        <td>Earlier Recommendations</td>
                      </tr>
                      <tr> 
                        <td align="center"> 
						<% for (int i=1;i<=hshValues.size();i++)
						{	
							hshRecord = (HashMap) hshValues.get(Integer.toString(i));
							if(hshRecord != null){
							strComment=strComment+Helper.correctNull((String)hshRecord.get("mail_usrname"))+"  -  "+
							hshRecord.get((String) Helper.correctNull("mail_usrdesign"))+"  -  "+
							hshRecord.get((String) Helper.correctNull("mail_pano"))+"  -   sends to "+ 
							hshRecord.get("mail_touser")+" on "+ hshRecord.get("mail_date")+" ---\n"+
							hshRecord.get("mail_comments")+"\n"+"\n"+
							"-----------------------------------------------------------------------------"+
							"----------------------------------------------\n";
							}
						}

						%>
					 <textarea name="txtearaud_text" cols="100"  rows="10" readOnly="readonly"> <%=strComment%> </textarea>
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
  <table width="0%" border="0" cellspacing="0" cellpadding="0"  align="center" class="outertable">
    <tr> 
      <td> 
        <table width="0%" border="0" cellspacing="0" cellpadding="2" class="outertable">
          <tr valign="top"> 
            <td align="center"> 
                <input type="button" name="cmdedit" value="Edit"  onClick="doEdit()" class="buttonStyle">
            </td>
            <td align="center"> 
                <input type="button" name="cmdsave" value="Save" onClick="doSave()" class="buttonStyle">
            </td>
            <td align="center"> 
                <input type="button" name="cmdcancel" value="Cancel" onClick="doCancel()" class="buttonStyle">
            </td>
            <td align="center"> 
                <input type="button" name="cmdclose" value="Close" onClick="doClose()" class="buttonClose">
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidappno" value="<%=request.getParameter("hidappno")%>" >
<input type="hidden" name="hiduserid" value="<%=request.getParameter("hiduserid")%>" >
<input type="hidden" name="hiddate" value="<%=request.getParameter("hiddate")%>">
<input type="hidden" name="hidtoUser" value="<%=request.getParameter("hidtoUser")%>">
<input type="hidden" name="editoption" value="<%=request.getParameter("editoption")%>">
</form>
</body>
</html>
