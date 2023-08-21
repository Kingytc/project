<%@ page import="java.util.*" %>

<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>

<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<lapschoice:handleerror />

<html>
<head>
<title>DEFAULTERS DETAILS</title>
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
  <div align="center"><font size="4" face="MS Sans Serif"><b><font color="#333399" size="3"><br>
    DEFAULTERS LIST</font></b></font><br>
 <br>
</div>
<table width="100%" border="1" cellspacing="0" cellpadding="5" bordercolorlight="#FFFFFF" bordercolordark="#8B8BD8" onMouseOver=" " align="center">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="1" cellspacing="1" cellpadding="5" align="center" bordercolor="#D0DCEA">
          <tr> 
            <td colspan="2"><b><i>Defaulter's Details from RBI</i></b></td>
          </tr>
	 <% for(int i =1;i<32;i++)
		 {
			 String strTemp = request.getParameter(Integer.toString(i));
			// out.println("strTemp---"+i+"---"+strTemp);
			 StringTokenizer strId = new StringTokenizer(strTemp,"^");
	
			 String strTemp1 ="" ;
			 String strTemp2 ="NOT AVAILABLE" ;
			 if(strId.hasMoreTokens())
			 {	  strTemp1 =(String)strId.nextToken();
			 }
			  if(strId.hasMoreTokens())
			 {	strTemp2 =(String)strId.nextToken();
			 }
	 %>
          <tr> 
            <td width="50%" bgcolor="#D0DCEA"><b><font size="1" face="MS Sans Serif"><%=strTemp1%>
              </font> </b></td>
            <td width="50%"><font size="1" face="MS Sans Serif" color="#0000FF"><B><%=strTemp2%></B></font></td>
          </tr>
	<%
		 }
	 %>
        </table>
        </td>
    </tr>
  </table>

</form>
</body>
</html>
