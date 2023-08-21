<%@include file="../share/directives.jsp"%>
<%
	String strApplevel=Helper.correctNull((String)request.getParameter("applevel"));
	String strappliedfor=Helper.correctNull((String)request.getParameter("appliedfor"));
%>
<html>
<head>
<title>Notes</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript">
var editlockflag="<%=hshValues.get("editlock")%>";
var editflag = 1;
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";

function setData()
{
	if(document.forms[0].elements.type=='textarea'  )
	{
		document.forms[0].elements.readOnly=true;
	}
	if(document.forms[0].cmdedit.disabled)
	{
		editflag=0;
	}
	disableFields(true);
}
	
function disableFields(val)
{
	document.forms[0].presentcomments.readOnly = val;
}

	function disableCommandButtons(val)
	{
			if(val=="edit")
			{
				document.forms[0].cmdedit.disabled=true;
				document.forms[0].cmdsave.disabled=false;
				document.forms[0].cmdcancel.disabled=false;
				document.forms[0].cmdclose.disabled=true;
				document.forms[0].cmddelete.disabled=false;
			}
	}

	function doDelete()
	{
		document.forms[0].hidAction.value="Delete";
		//document.forms[0].hidBeanMethod.value="";
		document.forms[0].hidBeanGetMethod.value="updateData";		
		document.forms[0].hidBeanId.value="appnotes";
		document.forms[0].action=appURL+"action/appnotes.jsp";	
		document.forms[0].submit();
		
	}

	function doEdit()
	{
		disableCommandButtons("edit");
		document.forms[0].presentcomments.readOnly = false;
		document.forms[0].hideditflag.value = "yes";
	}

	function doSave()
	{
		document.forms[0].hidBeanGetMethod.value="updateData";
		document.forms[0].hidBeanId.value="appnotes";
		document.forms[0].hidMethod.value="getData";
		document.forms[0].action=appURL+"action/appnotes.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
	function doCancel()
	{
		if(ConfirmMsg(102))
		{
			document.forms[0].hidBeanId.value="appnotes";
			document.forms[0].hidBeanGetMethod.value = "getData";
			document.forms[0].action = appURL+"action/appnotes.jsp";
			document.forms[0].method = "post";
			document.forms[0].submit();
		}
	}
	function doClose()
	{
		if(ConfirmMsg(100))
	 	{
			document.forms[0].action=appURL+"action/agrpage.jsp";
		 	document.forms[0].submit();
	 	}
	}
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="setData()">
<form name="appnotesform" method="post" action="<%=ApplicationParams.getAppUrl()%>controllerservlet" class="normal">
  <table width="100%" border="1" cellspacing="0" cellpadding="0" class="outertable">
    <tr>
      <td> 
	 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
			<td valign="top" colSpan=5>               
              <jsp:include page="../share/applurllinkscom.jsp" flush="true"> 
              <jsp:param name="pageid" value="10" />
			   <jsp:param name="cattype" value="<%=strCategoryType%>" />
			  <jsp:param name="ssitype" value="<%=strSSIType%>" />			
              </jsp:include>
            </td>
          </tr>
          <tr> 
      <td class="page_flow"> Home -&gt; Tertiary -&gt;  Application -&gt; Reports -&gt; Technical Inspection</td>
    </tr>
        </table>
      </td>
    </tr> 
  </table>
  <lapschoice:borrowertype /> <lapschoice:application/>  
  <lapstab:TerReportTab tabid="4" applevel='<%=strApplevel%>' applied='<%=strappliedfor%>' />	  
  <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
    <tr> 
      <td valign="top">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td colspan="3" valign="top"> 
              <table width="100%" border="1" cellspacing="0" cellpadding="2" class="outertable">
                <tr> 
                  <td> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                      <tr> 
                        <td><b> Comments on Technical Report</b></td>
                      </tr>
                      <tr> 
                        <td align="center"> 
                            <textarea name="presentcomments" cols="95" rows="10" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("not_text"))%></textarea>
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
 <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>