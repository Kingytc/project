<%@ include file="../share/directives.jsp"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<%
   String strType=request.getParameter("wrk_flowtype");
   if(strType.equalsIgnoreCase("p"))
   {
	   strType="In Process";
   }
   else if(strType.equalsIgnoreCase("a"))
   {
	   strType="Post Approval";
   }
   else
   {
	   strType="Post Rejection";
   }
%>
<html>
<head>
<title>Setup - Product</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<script>
 function doOk()
 {
	idx=<%=request.getParameter("idx")%>;
	if(document.forms[0].workflow.selectedIndex==-1)
	{
		ShowAlert(111,"Flow points");
		return;
	}
	var txt=document.forms[0].workflow.options[document.forms[0].workflow.selectedIndex].text;
	for(var i=0;i<window.opener.document.forms[0].wrk_flowname.length;i++)
	{
		
		if(window.opener.document.forms[0].wrk_flowname[i].value==txt)
		{
			ShowAlert(130);
			return;
		}
	}

	window.opener.document.forms[0].prd_workid[idx].value=document.forms[0].workflow.value;
	window.opener.document.forms[0].wrk_flowname[idx].value=txt;
	window.close();
}

function doClose()
{
	window.close();
}
</script>

<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>

<form name="myfrm" class="normal">
  <table width="90%" border="0" cellspacing="0" cellpadding="2" align="center" class="outertable" >
    <tr> 
      <td valign="top" > 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
          <tr> 
            <td class="dataheader"><b>
              Flow Point Actions - <%=strType%></b> </td>
          </tr>
          <tr> 
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                <tr> 
                  <td colspan="4"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                      <tr> 
                        <td colspan="10"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                            <tr> 
                              <td> 
                                <table width="100%" border="0" cellspacing="0" cellpadding="4" class="outertable">
                                  <tr> 
                                    <td colspan="2"> 
                                      <div align="center"> 
                                        <select name="workflow" size="20" style="width:400" onclick="document.forms[0].cmdok.disabled=false" onDblClick="doOk()">
                                          <laps:workflows /> 
                                        </select>
                                      </div>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="50%"> 
                                      <lapschoice:combuttonnew btnnames="Ok"
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
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
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <br>
</form>
</body>
</html>
