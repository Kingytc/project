<%@include file="../share/directives.jsp"%>

<%
	String grpRights = (String)session.getAttribute("strGroupRights");
%>
<html>
<head>
<title>LAPS-Setup Reports Navigation</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	

</script>
<script language="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
<!--
function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
var grpRights = '<%=session.getAttribute("strGroupRights")%>';

function callFunction(pagename)
{
  document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+pagename;
  document.forms[0].submit();
}

function closeWindow()
{
	if (ConfirmMsg("100"))
	{
	document.forms[0].hidPage.value="Navigation";
	document.forms[0].hidusr_id.value="<%=session.getAttribute("strUserid")%>";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/setupnav.jsp";
	document.forms[0].submit();
	}
	
}
function doClose()
{
	document.forms[0].action=appURL+"action/setupnav.jsp";
	document.forms[0].submit();
}

</script>

<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>

<form class="normal" name="frmsepnav" method="post">
  <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td> 
        <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr> 
            <td valign="top" colSpan=5> 
              <jsp:include page="../share/help.jsp" flush="true"/> 
            </td>
          </tr>
          <tr>
            <td class="page_flow" valign="top" colSpan=5>Home -&gt;
              Setup -&gt; 
              Reports</td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <br>
  <br>
        
               <table class="outertable border1" width="20%" border="0" cellspacing="0" cellpadding="0" align="center">
          <tr> <td align="center" class="dataheader">
                Setup 
                Reports</td> </tr></table>
                <table class="outertable border1 tableBg" width="20%" border="0" cellspacing="0" cellpadding="4" align="center">
             
                  <tr> 
                  <td>
                <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="4" align="center">
             
                  <tr> 
                    <td align="center" ><b> 
                      <%
					if(true)
					{
					%>
                      <a href="JavaScript:callFunction('reporgdetails.jsp')" class="blackfont">Organisation 
                      Details</a> 
                      <%
	}
	else
	{
	%>
                      Organisation 
                      Details 
                      <%
	}
	%>
                      </b></td>
                  </tr>
                  <tr> 
                    <td align="center" ><b> 
                      <%
					if(grpRights.charAt(5) == '1')
					{
				%>
                      <a href="JavaScript:callFunction('repprodavail.jsp')" class="blackfont">Product 
                      Availability</a> 
                      <%
	}
	else
	{
	%>
                      Product 
                      Availability 
                      <%
	}
	%>
                      </b></td>
                  </tr>
                  <tr> 
                    <td align="center" ><b> 
                      <%
					if(grpRights.charAt(5) == '1')
					{
				%>
                      <a href="JavaScript:callFunction('repprodflowpoint.jsp')" class="blackfont">Product 
                      Flowpoints</a> 
                      <%
	}
	else
	{
	%>
                      Product 
                      Flowpoints 
                      <%
	}
	%>
                      </b></td>
                  </tr>
                  <tr> 
                    <td align="center" ><b> 
                      <% 
					if(grpRights.charAt(3) == '1')
					{ 
					%>
                      <a href="JavaScript:callFunction('repuserdef.jsp')" class="blackfont">User 
                      Definition</a> 
                      <%
	}
	else
	{
	%>
                      Users 
                      Definition 
                      <%
	}
	%>
                      </b></td>
                  </tr>
                 
                  <tr> 
                    <td align="center" ><b> 
                      <%if(grpRights.charAt(1) == '1')
					{
					%>
                      <a href="JavaScript:callFunction('repgroups.jsp')" class="blackfont">Group 
                      Authority</a> 
                      <%
					  }
					  else
					  {
					  %>
                      Group 
                      Authority 
                      <%
					  }
					  %>
                      </b></td>
                  </tr>
                  
                  <tr> 
                    <td align="center" ><b> 
                      <%if(grpRights.charAt(1) == '1')
					{
					%>
                      <a href="JavaScript:callFunction('perrepuserpass.jsp')" class="blackfont">User Details Reports</a> 
                      <%
					  }
					  else
					  {
					  %>
                      User Details Reports 
                      <%
					  }
					  %>
                      </b></td>
                  </tr>
               
                </table>
               </td>
                  </tr>
                </table>
               
           
         
      </td>
    </tr>
  </table>
  <br>
  <lapschoice:combuttonnew  btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>

  <br>
  <input type="hidden" name="hidPage">
  <input type="hidden" name="hidusr_id">
</form>
</body>
</html>
