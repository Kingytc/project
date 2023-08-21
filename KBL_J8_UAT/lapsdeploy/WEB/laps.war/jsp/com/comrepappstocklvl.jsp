<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
<%
	ArrayList arryRow=(ArrayList)hshValues.get("arrRow");	
	ArrayList arryCol;
%>
<html>
<head>
<title>Stock Level Report</title>
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
function closeWindow()
{
	if (ConfirmMsg("100"))
	{
	document.forms[0].hidBeanId.disabled=true;
	document.forms[0].action=path+"action/comrepappnav.jsp";
	document.forms[0].submit();
	}
}
function loadval()
{
	var size="<%=arryRow.size()%>";
	if (size==0)
	{
		alert("No information to display");
		window.close();
	}
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="javascript:loadval()">
<form name="orgfrm" method="post">
<iframe  height="0" width="0" id="ifrm" frameborder=0 style="border:0" ></iframe> 
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#E6E6E6" align="center"><font face="Times New Roman" size="3"><b><i>STOCK 
        LEVEL REPORT</i></b></font></td>
    </tr>
  </table>
  <table width="98%" border="1" cellspacing="0" cellpadding="3" bordercolordark="#DEDEEF" bordercolorlight="#ffffff">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="1" cellpadding="4">
          <tr> 
            <td width="20%" bgcolor="#E6E6E6"><b><font size="1" face="Verdana, Arial, Helvetica, sans-serif">Generated 
              On</font></b></td>
            <td width="80%" bgcolor="#F5F5F5"><font size="1" face="MS Sans Serif"><%=Helper.getCurrentDateTime()%></font></td>
          </tr>
          <tr> 
            <td width="20%" bgcolor="#E6E6E6"><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><b>Generated 
              By</b></font></td>
            <td width="80%" bgcolor="#F5F5F5"><font size="1" face="MS Sans Serif"><%=session.getAttribute("strUserId")%></font></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <table width="100%" border="1" cellspacing="0" cellpadding="20" bordercolordark="#cccccc" bordercolorlight="#ffffff">
    <tr> 
      <td valign="middle"> 
        <div align="left"> 
          <table border="1" cellspacing="0" cellpadding="5" align="center" bordercolordark="#cccccc" bordercolorlight="#ffffff" width="100%">
            <tr> 
              <td> 
                <table width="100%" border="0" cellspacing="1" cellpadding="5" align="center">
                  <tr> 
                    <td colspan="4" ><font size="1" face="MS Sans Serif"> <b>1. 
                      Whether the movement of stock is satisfactory? </b></font></td>
                  </tr>
                  <tr bgcolor="#999999"> 
                    <td width="16%" align="center"><b><font  color="#FFFFFF"> 
                      Application No </font></b></td>
                    <td width="41%" bgcolor="#999999" align="center"><b><font  color="#FFFFFF"> 
                      Applicant Name </font></b></td>
                    <td width="17%" align="center"><b><font  color="#FFFFFF"> 
                      Location </font></b></td>
                    <td align="center" width="26%"><b><font  color="#FFFFFF"> 
                      Period </font></b></td>
                  </tr>
                  <% 
						if(arryRow!=null)
						{  
							for(int i=0;i<arryRow.size();i++)
							{
								arryCol=(ArrayList)arryRow.get(i);
								//out.println(arryCol);
								String qno = (String)arryCol.get(5);
								qno=qno.trim();
								if (qno.equalsIgnoreCase("04a"))
								{

						%>
                  <tr bgcolor="#E6E6E6"> 
                    <td width="16%" align="center"><font size="1" face="MS Sans Serif"> 
                      <%=arryCol.get(0)%> </font></td>
                    <td width="41%" bgcolor="#E6E6E6"><font size="1" face="MS Sans Serif"> 
                      <%=arryCol.get(1)%> </font></td>
                    <td width="17%"><font size="1" face="MS Sans Serif"> <%=arryCol.get(2)%> 
                      </font></td>
                    <td width="26%" align="center"><font size="1" face="MS Sans Serif"> 
                      <%=arryCol.get(3) + "-" + arryCol.get(4)%> </font></td>
                  </tr>
                  <%
								}
							}		
						}
					%>
                </table>
              </td>
            </tr>
            <tr> 
              <td> 
                <table width="100%" border="0" cellspacing="1" cellpadding="5" align="center">
                  <tr> 
                    <td colspan="4"><font size="1" face="MS Sans Serif"> <b>2. 
                      Whether company is maintaining sufficient stocks for meeting 
                      its orders? </b></font></td>
                  </tr>
                  <tr bgcolor="#999999"> 
                    <td width="16%" align="center"><b><font  color="#FFFFFF"> 
                      Application No </font></b></td>
                    <td width="41%" align="center" bgcolor="#999999"><b><font  color="#FFFFFF"> 
                      Applicant Name </font></b></td>
                    <td width="17%" align="center"><b><font  color="#FFFFFF"> 
                      Location </font></b></td>
                    <td align="center" width="26%"><b><font  color="#FFFFFF"> 
                      Period </font></b></td>
                  </tr>
                  <% 
						if(arryRow!=null)
						{
							for(int i=0;i<arryRow.size();i++)
							{
								arryCol=(ArrayList)arryRow.get(i);
								String qno = (String)arryCol.get(5);									qno=qno.trim();
								if (qno.equals("05a"))
								{

						%>
                  <tr bgcolor="#E6E6E6"> 
                    <td width="16%" align="center"><font size="1" face="MS Sans Serif"> 
                      <%=arryCol.get(0)%> </font></td>
                    <td width="41%" bgcolor="#E6E6E6"><font size="1" face="MS Sans Serif"> 
                      <%=arryCol.get(1)%> </font></td>
                    <td width="17%"><font size="1" face="MS Sans Serif"> <%=arryCol.get(2)%> 
                      </font></td>
                    <td width="26%" align="center"><font size="1" face="MS Sans Serif"> 
                      <%=arryCol.get(3) + "-" + arryCol.get(4)%> </font></td>
                  </tr>
                  <%
								}
							}		
						}
					%>
                </table>
              </td>
            </tr>
            <tr> 
              <td> 
                <table width="100%" border="0" cellspacing="1" cellpadding="5" align="center">
                  <tr> 
                    <td colspan="4"><font size="1" face="MS Sans Serif"> <b>3. 
                      Whether the stocks are adequetly insured? </b></font></td>
                  </tr>
                  <tr> 
                    <td width="16%" align="center" bgcolor="#999999"><b><font  color="#FFFFFF"> 
                      Application No </font></b></td>
                    <td width="41%" align="center" bgcolor="#999999"><b><font  color="#FFFFFF"> 
                      Applicant Name </font></b></td>
                    <td width="17%" align="center" bgcolor="#999999"><b><font  color="#FFFFFF"> 
                      Location </font></b></td>
                    <td align="center" width="26%" bgcolor="#999999"><b><font  color="#FFFFFF"> 
                      Period </font></b></td>
                  </tr>
                  <% 
						if(arryRow!=null)
						{
							for(int i=0;i<arryRow.size();i++)
							{
								arryCol=(ArrayList)arryRow.get(i);
								String qno = (String)arryCol.get(5);
								qno=qno.trim();
								if (qno.equals("06a"))
								{

						%>
                  <tr bgcolor="#E6E6E6"> 
                    <td width="16%" align="center"><font size="1" face="MS Sans Serif"> 
                      <%=arryCol.get(0)%> </font></td>
                    <td width="41%"><font size="1" face="MS Sans Serif"> <%=arryCol.get(1)%> 
                      </font></td>
                    <td width="17%"><font size="1" face="MS Sans Serif"> <%=arryCol.get(2)%> 
                      </font></td>
                    <td width="26%" bgcolor="#E6E6E6" align="center"><font size="1" face="MS Sans Serif"> 
                      <%=arryCol.get(3) + "-" + arryCol.get(4)%> </font></td>
                  </tr>
                  <%
								}
							}		
						}
					%>
                </table>
              </td>
            </tr>
          </table>
        </div>
      </td>
    </tr>
  </table>
  <br>
  <table width="1%" border="1" cellspacing="0" cellpadding="0" align="center" bordercolordark="#cccccc" bordercolorlight="#ffffff">
    <tr> 
      <td> 
        <table border="0" cellspacing="0" cellpadding="3">
          <tr valign="top"> 
            <td> 
              <div align="center"> 
                <input type="button" name="rpclose" value="Close" class="buttonClose" onClick="JavaScript:window.close()">
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</form>
</body>
</html>
