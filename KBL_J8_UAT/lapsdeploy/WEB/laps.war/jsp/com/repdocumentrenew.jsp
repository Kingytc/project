<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request"/>
<jsp:useBean id="strUserId" class="java.lang.String" scope="session"/>

<laps:handleerror />
<%
	ArrayList arryRow=(ArrayList)hshValues.get("vecData");	
	ArrayList arryCol;
%>
<html>
<head>
<title>Report - Housing</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 150;
  overflow: auto;
}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #605FAF}
a:hover {  color: #FF3300}
input {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399; border-style: groove}
.fontstyle {  font-family: "MS Sans Serif"; font-size: 10px; font-weight: bold; color: #000000; text-decoration: none}
</STYLE>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="javascript">
	var path="<%=ApplicationParams.getAppUrl()%>";
</script>
</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<div align="center">
  <table width="98%" border="0" cellspacing="1" cellpadding="2">
    <tr> 
      <td colspan="2" align="center" bgcolor="#999999"><font size="2"><b><font size="3" color="#FFFFFF"><i>Documents 
        Renewal LIST AS ON <%=Helper.getCurrentDateTime()%> </i></font></b> </font></td>
    </tr>
    <tr> 
      <td height="26" colspan="2"> 
        <hr align="center" style="color:#EEEEEE">
      </td>
    </tr>
  </table>  
  <table width="98%" border="1" cellspacing="0" cellpadding="3" bordercolordark="#DEDEEF" bordercolorlight="#ffffff">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="1" cellpadding="4">
          <tr> 
            <td width="14%" bgcolor="#E6E6E6"><b><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><b>Generated 
              On </b></font></b></td>
            <td width="40%"><font size="1" face="MS Sans Serif"><font size="1" face="MS Sans Serif"><%=Helper.getCurrentDateTime()%></font></font></td>
            <td width="12%"><font size="1" face="Verdana, Arial, Helvetica, sans-serif"></font></td>
            <td width="34%"><font size="1" face="MS Sans Serif"><b></b></font></td>
          </tr>
          <tr>
            <td width="14%" bgcolor="#E6E6E6"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="1">Generated 
              By </font></b></td>
            <td width="40%"><font size="1" face="MS Sans Serif"><%=strUserId%></font></td>
            <td width="12%">&nbsp;</td>
            <td width="34%">&nbsp;</td>
          </tr>
        </table>
      </td>
    </tr>
  </table><br>
</div>
<table width="98%" border="1" cellspacing="0" cellpadding="5" bordercolordark="#DEDEEF" bordercolorlight="#ffffff" align="center">
     
  <tr> 	
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="1" cellpadding="0">
        <tr> 
          <td colspan="4"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="3">
              <tr> 
                <td colspan="6"> 
                  <table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolordark="#cccccc" bordercolorlight="#ffffff">
                    <tr> 
                      <td width="12%" align="center" height="15" bgcolor="#999999"> 
                        <font color="#FFFFFF" face="Verdana, Arial, Helvetica, sans-serif"><b><font size="1">Aplication. 
                        No.</font></b></font></td>
                      <td width="11%" align="center" height="15" bgcolor="#999999"><font color="#FFFFFF" face="Verdana, Arial, Helvetica, sans-serif"><b><font size="1">Branch 
                        name</font></b></font></td>
                      <td width="13%" align="center" height="15" bgcolor="#999999"><font color="#FFFFFF" face="Verdana, Arial, Helvetica, sans-serif"><b><font size="1">Customer 
                        Name </font></b></font></td>
                      <td width="10%" align="center" height="15" bgcolor="#999999"> 
                        <div align="center"><font color="#FFFFFF" face="Verdana, Arial, Helvetica, sans-serif"><b><font size="1">Company 
                          Id </font></b></font></div>
                      </td>
                      <td width="16%" align="center" height="15" bgcolor="#999999"><font size="1" face="Verdana, Arial, Helvetica, sans-serif" color="#FFFFFF"><b>Document 
                        Description </b></font></td>
                      <td width="11%" align="center" height="15" bgcolor="#999999"><b><font size="1" face="Verdana, Arial, Helvetica, sans-serif" color="#FFFFFF">Document 
                        type </font></b></td>
                      <td width="11%" align="center" height="15" bgcolor="#999999"><b><font size="1" face="Verdana, Arial, Helvetica, sans-serif" color="#FFFFFF">Submitted</font><font size="1" face="Verdana, Arial, Helvetica, sans-serif" color="#FFFFFF"> 
                        Date </font></b></td>
                      <td width="12%" align="center" height="15" bgcolor="#999999"><b><font color="#FFFFFF" size="1" face="Verdana, Arial, Helvetica, sans-serif">Renewal 
                        Date </font></b></td>
                    </tr>
                    <% 
					String strType;
	   			     if(arryRow!=null)
					   {  
					    for(int i=0;i<arryRow.size();i++)
						 {
						  arryCol=new ArrayList();
					      arryCol=(ArrayList)arryRow.get(i); 

						  if(arryCol.get(7).equals("I"))
							 {
							   strType = "Internal";
							 }
							 else
							 {
								 strType = "Applicant";
							 }
				   %>
                    <tr> 
                      <td width="12%" align="left" bgcolor="#F5F5F5"><font size="1" face="MS Sans Serif"><%=arryCol.get(0)%></font></td>
                      <td width="11%" bgcolor="#F5F5F5"><font size="1" face="MS Sans Serif"><%=arryCol.get(3)%></font></td>
                      <td width="13%" bgcolor="#F5F5F5"><font size="1" face="MS Sans Serif"><%=arryCol.get(5)%></font></td>
                      <td width="10%" align="center" bgcolor="#F5F5F5"><font size="1" face="MS Sans Serif"><%=arryCol.get(4)%></font></td>
                      <td width="16%" bgcolor="#F5F5F5"><font size="1" face="MS Sans Serif"><%=arryCol.get(6)%></font></td>
                      <td width="11%" bgcolor="#F5F5F5"><font size="1" face="MS Sans Serif"><%=strType%></font></td>
                      <td width="11%" align="center" bgcolor="#F5F5F5"><font size="1" face="MS Sans Serif"><%=arryCol.get(2)%></font></td>
                      <td width="12%" align="center" bgcolor="#F5F5F5"><font size="1" face="MS Sans Serif"><%=arryCol.get(8)%></font></td>
                    </tr>
                    <%
					    }
					  }   
					%>
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
</body>
</html>