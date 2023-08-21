<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.rmi.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />

<% 

	String strColor1="";
	String strColor2="";
	String strColor3="";
	String strColor4="";
	String strColor5="";
	String strColor6="";

	if(hshValues.get("workflow").equals("Completed"))
	{
		strColor1 = "#0000FF";
	}
	else
	{
		strColor1 = "#CC0000";
	}

	if(hshValues.get("strIdocStatus").equals("Generated"))
	{
		strColor2 = "#0000FF";
	}
	else
	{
		strColor2 = "#CC0000";
	}
	
	if(hshValues.get("strAdocStatus").equals("Submitted"))
	{
		strColor3 = "#0000FF";
	}
	else
	{
		strColor3 = "#CC0000";
	}

	if(hshValues.get("groupexposure").equals("Within Limit"))
	{
		strColor4 = "#0000FF";
	}
	else if(hshValues.get("groupexposure").equals("Exceeded"))
	{
		strColor4 = "#CC0000";
	}
	else
	{
		strColor4 = "#009900";
	}

	if(hshValues.get("industryexposure").equals("Within Limit"))
	{
		strColor5 = "#0000FF";
	}
	else if(hshValues.get("industryexposure").equals("Exceeded"))
	{
		strColor5 = "#CC0000";
	}
	else
	{
		strColor5 = "#009900";
	}

	if(hshValues.get("loantoratio").equals("Within Limit"))
	{
		strColor6 = "#0000FF";
	}
	else
	{
		strColor6 = "#CC0000";
	}

	
%>


<html>
<head>
<title>Check List</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
textarea {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}

-->
</style>
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 250;
  overflow: auto;
}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
.tabfont {  font-family: "MS Sans Serif"; font-size: 10px; color: #000000; text-decoration: none}
a:hover {  color: #FF3300}
</STYLE>
</head>
<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#FFFFFF"  onBlur="self.focus()">
<form name="fininc" method="post">
  <div align="center"><font size="4" face="MS Sans Serif"><b><font color="#333399" size="5">Check 
    List</font></b></font><br>
    <br>
    <table width="100%" border="0" cellspacing="0" cellpadding="5">
      <tr> 
        <td> 
          <table width="100%" border="0" cellspacing="1" cellpadding="0" align="center">
            <tr> 
              <td width="35%" bgcolor="#C2C7ED"><b><font size="1" face="MS Sans Serif">Application 
                No.</font></b></td>
              <td width="30%"><font size="1" face="MS Sans Serif"><%=hshValues.get("appno")%></font><b></b></td>
              <td><b></b> 
                <table width="100%" border="0" cellspacing="1" cellpadding="3" bordercolor="#D0DCEA">
                  <tr> 
                    <td width="42%" bgcolor="#C2C7ED"><font size="1" face="MS Sans Serif"><b><font size="1" face="MS Sans Serif">Date 
                      </font></b></font></td>
                    <td width="58%" align="center"><font size="1" face="MS Sans Serif"><%=Helper.getCurrentDateTime()%></font></td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr> 
              <td width="35%" bgcolor="#C2C7ED"><b><font size="1" face="MS Sans Serif">Applicant 
                Name</font></b></td>
              <td width="30%"><font size="1" face="MS Sans Serif"><%=hshValues.get("appname")%></font></td>
              <td> 
                <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable border1"> 
                    <td width="50%" bgcolor="#D0DCEA"><font size="1" face="MS Sans Serif"><b><a href="javascript:window.print()" style="text-decoration:none"><font color="#990000">Print</font></a></b></font></td>
                    <td width="50%"><font size="1" face="MS Sans Serif"><b><a href="javascript:window.close()" style="text-decoration:none"><font color="#990000">Close</font></a></b></font></td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
    <br>
  </div>
  <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable border1" onMouseOver=" " align="center">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="1" cellpadding="5" align="center" class="outertable border1">
          <tr> 
            <td colspan="2"><b><i>Final Checklist</i></b></td>
          </tr>
          <tr> 
            <td width="50%" bgcolor="#D0DCEA"><b><font size="1" face="MS Sans Serif">Work 
              Flow </font></b></td>
            <td width="50%"><font size="1" face="MS Sans Serif" color="<%=strColor1%>"><%=hshValues.get("workflow")%></font></td>
          </tr>
          <tr>
            <td width="50%" bgcolor="#D0DCEA"><b><font size="1" face="MS Sans Serif" color="#000000">Document 
              - </font></b></td>
            <td width="50%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="50%" bgcolor="#D0DCEA"><b><font size="1" face="MS Sans Serif"> 
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></b><font size="1" face="MS Sans Serif">Customer</font></td>
            <td width="50%"><font size="1" face="MS Sans Serif" color="<%=strColor2%>"><%=hshValues.get("strAdocStatus")%></font></td>
          </tr>
          <tr> 
            <td width="50%" bgcolor="#D0DCEA"><b><font size="1" face="MS Sans Serif"> 
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></b><font size="1" face="MS Sans Serif">Internal</font></td>
            <td width="50%"><font size="1" face="MS Sans Serif" color="<%=strColor3%>"><%=hshValues.get("strIdocStatus")%></font></td>
          </tr>
          <tr> 
            <td width="50%" bgcolor="#D0DCEA"><b><font size="1" face="MS Sans Serif">Group 
              Exposure </font></b></td>
            <td width="50%"><font size="1" face="MS Sans Serif" color="<%=strColor4%>"><%=hshValues.get("groupexposure")%></font></td>
          </tr>
          <tr> 
            <td width="50%" bgcolor="#D0DCEA"><b><font size="1" face="MS Sans Serif">Industry 
              Exposure</font></b></td>
            <td width="50%"><font size="1" face="MS Sans Serif" color="<%=strColor5%>"><%=hshValues.get("industryexposure")%></font></td>
          </tr>
          <tr> 
            <td width="50%" bgcolor="#D0DCEA"><b><font size="1" face="MS Sans Serif">Loan 
              to Value Ratio</font></b></td>
            <td width="50%"><font size="1" face="MS Sans Serif" color="<%=strColor6%>"><%=hshValues.get("loantoratio")%></font></td>
          </tr>
          <tr align="center"> 
            <td colspan="2"><b><font size="2" face="MS Sans Serif" color="#CC0000">&gt;&gt;</font><font size="2" face="MS Sans Serif"> 
              Application is under process for <%=hshValues.get("processtime")%> 
              day[s]</font><font size="2" face="MS Sans Serif" color="#CC0000"> 
              &lt;&lt;</font></b></td>
          </tr>
        </table>
        </td>
    </tr>
  </table>

</form>
</body>
</html>
