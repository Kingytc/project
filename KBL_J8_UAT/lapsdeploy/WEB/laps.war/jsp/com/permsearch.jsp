<%@include file="../share/directives.jsp"%>
<%
String strhidmoduletype="";
strhidmoduletype=Helper.correctNull((String)request.getParameter("hidModuleType"));
%>

<html>
<head>
<title>Permission Search</title>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/com_permission.jsp";
		document.forms[0].submit();
	}
}


</script>
</head>
<body>
<form name="exist" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr>
            <td class="page_flow">Home&nbsp;-&gt;&nbsp;Permission</td>
          </tr>


        </table>		
      </td>
    </tr>
 </table>

  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable border1">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                <tr> 
                  <td valign="top"> <br>
                    <br>
                    <table width="80%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
                      <tr> 
                        <td valign="top" id="searchheading"> 
                          <table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
                            <tr align="center" class="dataheader"> 
                              <td width="15%">Proposal No.</td>
                              <td width="32%">Borrower Name</td>
                              <td width="23%">Process Status</td>
                              <td width="25%">Proposal Type</td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr> 
                        <td valign="top"><iframe id="result" src="<%=ApplicationParams.getAppUrl()%>action/permResult.jsp?hidBeanGetMethod=getPermDataFinal&hidBeanId=perDeviation&appno=<%=Helper.correctNull((String)request.getParameter("id"))%>&name=<%=Helper.correctNull((String)request.getParameter("name"))%>&cbsid=<%=Helper.correctNull((String)request.getParameter("cbsid"))%>&select_cat=<%=Helper.correctNull((String)request.getParameter("select_cat"))%>" width="100%" height=220 > </iframe> </td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
             </table>
      </td>
    </tr>
  </table>
  <br>
  <table border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
    <tr> 
      <td> 
        <table width="0%" border="0" cellspacing="0" cellpadding="2" class="outertable">
          <tr valign="middle"> 
            <td> 
              <div align="center"> 
                <input type="button" name="cmdclose" value="Close" class="buttonClose" onClick="doClose()">
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
<input type="hidden" name="hidPageType" value="<%=request.getParameter("hidPageType")%>"> 
<input type="hidden" name="hidPage" value="<%=request.getParameter("hidPage")%>"> 
<input type="hidden" name="comapp_id" value="<%=request.getParameter("comapp_id")%>"> 
<input type="hidden" name="comapp_compname" value="<%=request.getParameter("comapp_compname")%>"> 
<input type="hidden" name="comapp_compid" value="<%=request.getParameter("comapp_compid")%>"> 
<input type="hidden" name="hidCategoryType" value="<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>"> 
<input type="hidden" name="From_date" value="<%=Helper.correctNull((String)request.getParameter("From_date"))%>"> 
<input type="hidden" name="To_date" value="<%=Helper.correctNull((String)request.getParameter("To_date"))%>"> 
<input type="hidden" name="applevel" value=""/>
<input type="hidden" name="srchvalue" value="<%=Helper.correctNull((String)request.getParameter("srch_txtval"))%>"/>
</form>
</body>
</html>
