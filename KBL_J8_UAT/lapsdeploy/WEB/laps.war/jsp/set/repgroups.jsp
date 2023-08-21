<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Reports - Groups</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/set/repgroups.js">
</script>
<script>
var path="<%=ApplicationParams.getAppUrl()%>";
var bnkname="";
var param="";
var userid ="<%=(String)session.getAttribute("strUserId")%>";
var rights ="<%=(String)session.getAttribute("strGroupRights")%>";
</script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>

<body onLoad="" >
<script language="JavaScript">
</script>
<form name="orgfrm" method="post" class="normal">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td class="page_flow">Home-&gt; 
         Setup -&gt; Reports  -&gt; Group Authority</td>
    </tr> 
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="20" class="outertable">
    <tr> 
      <td valign="middle"> 
        <div align="left"> 
          <table width="60%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable border1 tableBg">
            <tr> 
              <td> 
                <table width="100%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable">
                  <tr> 
                    <td>  
                      <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
                        <tr class="dataheader"> 
                          <td width="34%" align="center">Select 
                            Group Names</td>
                          <td width="34%" align="center">Select 
                            Output Fields</td>
                        </tr>
                        <tr> 
                          <td width="34%" align="center">  
                            <select name="rpselect1" size="11"  style="width:150" multiple style="margin-bottom: 15px; display:inline-block;">
                              <lapschoice:reptag beanid="repgroup" methodname="getGroupNames" param="" /> 
                            </select>
                            </td>
                          <td width="34%" align="center"> 
                            <select name="rpselect2" size="11"  style="width:150" multiple style="margin-bottom: 15px; display:inline-block;">
                              <option value="grp_name">Group Name</option>
                              <option value="navigational">Navigational Security</option>
                              <option value="data">Data Security</option>
                            </select>
                            </td>
                        </tr>
                      </table>
                       </td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </div>
      </td>
    </tr>
  </table>
  <br>
  <lapschoice:combuttonnew btnnames='Run Report_Reset' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
    <lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidGrpName" >
<input type="hidden" name="hidOpFields" >
<input type="hidden" name="hidSelFields" >
<input type="hidden" name="repname" value ="Group Authority Report">
<input type="hidden" name="hidPage" value="rungroupsrep.jsp">
<input type="hidden" name="txtDate" value='<%=Helper.getCurrentDateTime()%>'>
</form>
</body>
</html>
