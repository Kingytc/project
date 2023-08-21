<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Commercial-Modification Sanction Term</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function showBlank()
{
	document.all.result.src=appURL+'action/blank.jsp';
}

function resetme()
{
	document.forms[0].reset();
	document.all.result.src=<%=ApplicationParams.getAppUrl()%>+'action/blank.jsp';
}
	

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/corppge.jsp";
		document.forms[0].submit();
	}
}

function doSearch()
{

	appno = document.forms[0].srchvalue.value;	
	document.all.result.src="<%=ApplicationParams.getAppUrl()%>action/commstresult.jsp?hidBeanGetMethod=getDataFinal&hidBeanId=modsancterms&id=<%=Helper.correctNull((String)request.getParameter("comapp_id"))%>&comapp_compname=<%=Helper.correctNull((String)request.getParameter("comapp_compname"))%>&hidPageType=<%=Helper.correctNull((String)request.getParameter("hidPageType"))%>";
}

function doNew()
{
	var id="<%=Helper.correctNull((String)request.getParameter("id"))%>";
	var appname="<%=Helper.correctNull((String)request.getParameter("comapp_compname"))%>";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/commst_facilities.jsp?hidBeanId=modsancterms&hidBeanGetMethod=getfacilityData&hidcatory=MST&appname="+appname+"&comapp_id="+id+"&appno=NEW&hidapplicantid="+document.forms[0].comapp_id.value+"&hidappoldid="+document.forms[0].comapp_oldid.value;
	document.forms[0].target="mainFrame";
	document.forms[0].submit();
}

</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">

</head>

<body>
<form name="exist" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr>
            <td class="page_flow"><b>Home&nbsp;-&gt;&nbsp;Corporate &amp; SME -&gt; Modifications in Sanction Terms</b></td>
          </tr>
        </table>		
      </td>
    </tr>
 </table>

  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1" align="center">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                <tr> 
                  <td valign="top"> <br>
                    <table width="80%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable border1">
                      <tr> 
                        <td valign="top"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                            <tr> 
                              <td> 
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                                  <tr> 
                                  <%
												if(strGroupRights.charAt(18) =='w' && (strOrgLevel.equals("A"))){
													%>

												<td align="center"><input type="button" name="cmdNew"
													value="New Modification in Sanction Terms" class="buttonStyle" style="width:200" onClick="doNew()">
												</td>
												<% }%>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
                    <br>
                    <table width="80%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
                      <tr> 
                        <td valign="top" id="searchheading"> 
                          <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
                            <tr align="center" class="dataheader"> 
                              <td width="24%">Application No.</td>
                              <td width="51%">Borrower Name</td>
                              <td width="25%">Process Status</td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr> 
                        <td valign="top"><iframe id="result" src="<%=ApplicationParams.getAppUrl()%>action/commstresult.jsp?hidBeanGetMethod=getDataFinal&hidBeanId=modsancterms&id=<%=Helper.correctNull((String)request.getParameter("comapp_oldid"))%>&comapp_compname=<%=Helper.correctNull((String)request.getParameter("comapp_compname"))%>&hidPageType=<%=Helper.correctNull((String)request.getParameter("hidPageType"))%>" width="100%" height=220 > </iframe> </td>
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
  <table border="0" cellspacing="0" cellpadding="0" align="center" class="outertable border1">
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
<input type="hidden" name="comapp_id" value="<%=request.getParameter("comapp_id")%>"> 
<input type="hidden" name="comapp_oldid" value="<%=request.getParameter("comapp_oldid")%>"> 
<input type="hidden" name="comapp_compname" value="<%=request.getParameter("comapp_compname")%>"> 
</form>
</body>
</html>
