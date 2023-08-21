<%@include file="../share/directives.jsp"%>
<%String hidmontype1=Helper.correctNull((String)request.getParameter("strhidmontype"));%>
<html>
<head>
<title>Commercial-Existing Application form</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/menudropdown.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var varmontype="<%=Helper.correctNull((String)request.getParameter("strhidmontype"))%>";
function authenticateUser()
{	
}
function showBlank()
{
document.all.result.src=appUrl+'action/blank.jsp';
}

function resetme()
	{
		document.forms[0].reset();
		toggleState();
		document.all.result.src=appUrl+'action/blank.jsp';
	}	

function doClose()
{
	if(ConfirmMsg(100))
	{
		 if(document.forms[0].hidmontype.value=='MONIT')
		 {
		 	document.forms[0].action=appUrl+"action/mainnav.jsp";
		 	document.forms[0].submit();
		 }
		 else if(document.forms[0].hidmontype.value=='MONITREVIEW')
		 {
		 	document.forms[0].action=appUrl+"action/mon_borrowersearch.jsp";
			document.forms[0].submit();
		 }
		 else if(document.forms[0].hidmontype.value=='POSTINSPEC')
		 {
		 	document.forms[0].action=appUrl+"action/mon_borrowersearch.jsp";
			document.forms[0].submit();
		 }
	}
}

function doSearch()
{
	var strOpt="";
	var strForm="";
	var strSrch="";
	var strMailbox="";
   hidmontype = document.forms[0].hidmontype.value;   
	appno = document.forms[0].srchvalue.value;	
	document.all.result.src="<%=ApplicationParams.getAppUrl()%>action/monresult.jsp?hidBeanGetMethod=getMonitoringData&hidBeanId=borrowersearch&hidmontype=<%=Helper.correctNull((String)request.getParameter("id"))%>&id=<%=Helper.correctNull((String)request.getParameter("id"))%>";	
	}
/* modification end */
function repTable()
{
	if(document.forms[0].srchoption.checked==true)
	{
	document.all.searchheading.innerHTML='<table width="100%" border="0" cellspacing="2" cellpadding="1"><tr bgcolor="#71694F" bordercolordark="#82829F" bordercolorlight="#EBEBF8">         <td width="25%" bgcolor="#71694F"><b> Application No</b></td><td width="25%"> <b>Process Status</b></td><td width="25%" bgcolor="#71694F"><b> Sent By</b></td><td width="25%" bgcolor="#71694F"><b> Application No</b></td></tr></table> '
	}
}

</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="">
<form name="exist" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr>
            <td valign="top" class="page_flow">Home -&gt; Monitoring Register -&gt; Accountwise Search</td>
          </tr>
        </table>
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="4" class="outertable">
                <tr> 
                  <td valign="top"> 
                    <br>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
                      <tr valign="top"> 
                        <td> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
                            <tr align="center" class="dataheader">                            
                              <td width="9%">Account No.</td>
                              <td width="18%">CBS ID</td>								
                              <td width="20%">Nature of Limit</td>                             
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr> 
                        <td valign="top">
                        <iframe id="result" src="<%=ApplicationParams.getAppUrl()%>action/monresult.jsp?hidBeanGetMethod=getMonitoringData&hidprinttype=<%=Helper.correctNull((String)request.getParameter("hidprinttype"))%>&hidmontype=<%=Helper.correctNull((String)request.getParameter("hidmontype"))%>&id=<%=Helper.correctNull((String)request.getParameter("id"))%>&cbsname=<%=Helper.correctNull((String)request.getParameter("cbsname"))%>&custorgscode=<%=Helper.correctNull((String)request.getParameter("custorgscode"))%>" width="100%" height="220" > </iframe> </td>
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
 <lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
 <br>  
 <lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="comapp_id" value="<%=request.getParameter("comapp_id")%>"> 
<input type="hidden" name="comapp_compname" value="<%=request.getParameter("comapp_compname")%>"> 
<input type="hidden" name="comapp_compid" value="<%=request.getParameter("comapp_compid")%>"> 
<input type="hidden" name="cbsid" value="<%=Helper.correctNull((String)request.getParameter("id"))%>">
<input type="hidden" name="hidmontype" value="<%=request.getParameter("hidmontype")%>">
<input type="hidden" name="hidprinttype" value="<%=request.getParameter("hidprinttype")%>">  
</form>
</body>
</html>
