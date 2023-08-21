<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>

<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />

<%
	String value = (String)request.getParameter("value");
	String mode = (String)request.getParameter("mode");
	//System.out.println("List Values:"+hshValues);
	ArrayList vecValues = (ArrayList) hshValues.get("Data");
	//session.setAttribute("strMode",mode);
%>

<html>
<head>
	<title> </title>
	<script language="JavaScript">

		function gotoPage(appno, daterange)
		{
			if(daterange=='')
			{
				var myval= '<%=value%>';
				var myval1 = myval.split("~");
				daterange=myval1[0]+myval1[1];
			}
			document.forms[0].target="mainFrame";
			document.forms[0].action = "<%=ApplicationParams.getAppUrl()%>action/controlinternal1.jsp?hidBeanId=searchpostdisb&hidBeanGetMethod=getInternalData&appno="+appno+"&daterange="+daterange+"&page=page1&mode=<%=mode%>&appstatus=Closed/Approved";
			document.forms[0].submit();
		}
	</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>
<body bgcolor="#EEEAE3" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="postdisblist" method="post" action="<%=ApplicationParams.getAppUrl()%>controllerservlet">
<% 
if(mode.equalsIgnoreCase("create"))
{
%>
<div class="cellcontainer">
    <table width="100%" border="0" cellspacing="2" cellpadding="3" bordercolorlight="#EBEBF8" bordercolordark="#82829F">
      <%
	//System.out.println("inside create page "+vecValues);
	HashMap hshTmp = null;
	if(vecValues.size() > 0)
	{
		for(int i=0;i<vecValues.size();i++)
		{
			hshTmp = (HashMap)vecValues.get(i);
%>
      <tr> 
        <td width="23%" align="left"><a href="javascript:gotoPage('<%=hshTmp.get("app_no")%>','')" class="blackfont"><font size="1" face="MS Sans Serif"><b><%= hshTmp.get("app_no") %></b></font></a></td>
        <td width="49%"><font size="1" face="MS Sans Serif"><%= hshTmp.get("comapp_companyname") %></font></td>
        <td width="28%" align="center"><font size="1" face="MS Sans Serif"><%= hshTmp.get("comapp_companyid") %></font></td>
      </tr>
      <%
		}
	}
%>
    </table>
</div>
<%
}
else if(mode.equalsIgnoreCase("view"))
{
%>
<div class="cellcontainer"> 
    <table width="100%" border="0" cellspacing="2" cellpadding="3" bordercolorlight="#EBEBF8" bordercolordark="#82829F">
      <%
	HashMap hshTmp = null;
	if(vecValues.size() > 0)
	{
		for(int i=0;i<vecValues.size();i++)
		{
			hshTmp = (HashMap)vecValues.get(i);
%>
      <tr> 
        <td width="23%" align="left"><a href="javascript:gotoPage('<%=hshTmp.get("app_no")%>','<%=hshTmp.get("postdisb_fromdate")%>-<%=hshTmp.get("postdisb_todate")%>')" class="blackfont"><font size="1" face="MS Sans Serif"><b><%= hshTmp.get("app_no")%></b></font></a></td>
        <td width="29%"><font face="MS Sans Serif" size="1"><%= hshTmp.get("comapp_companyname")%> 
          </font></td>
        <td width="20%"><font size="1" face="MS Sans Serif"><%= hshTmp.get("comapp_companyid")%> 
          </font></td>
        <td width="24%" align="center"><font size="1" face="MS Sans Serif"><%= hshTmp.get("postdisb_fromdate")%> 
          - <%= hshTmp.get("postdisb_todate")%></font></td>
      </tr>
      <%
		}
	}
%>
    </table>
</div>
<%
}
%>
<input type=hidden name="hidBeanId" value="searchpostdisb" >
<input type=hidden name="hidBeanMethod" value="" >
<input type=hidden name="hidSourceUrl" value="/action/postdisbapplist.jsp" >
<input type=hidden name="hidBeanGetMethod" value="getApplications">

</form>
</body>

</html>






