<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%
	ArrayList arrRow=new ArrayList();
	ArrayList arrCol=new ArrayList();
	if(hshValues!=null)
	{
		arrRow=(ArrayList)hshValues.get("arrRow");
	}
	String strDocCode=Helper.correctNull((String)hshValues.get("strDocCode"));
	String strsno=Helper.correctNull((String)hshValues.get("strsno"));
%>
<html>
<head>
<title>Applicant Documents / Application Forms - Commercial</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script>
var appUrl="<%=ApplicationParams.getAppUrl()%>";
function addRemarks()
{
	var sno="<%=strsno%>";
	var remark=document.forms[0].rulesDescA.options[document.forms[0].rulesDescA.selectedIndex].text;
	window.opener.document.forms[0].apdoc_remarks[<%=strsno%>].value=remark;
	window.close();
}
</script>
</head>

<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css">
<body bgcolor="#EEEAE3" text="#000000">
<form name="ruleForm" method="post" action="">
  <table width="78%" border="0" cellspacing="0" cellpadding="0" class="outertable border1" height="100" align="center" >
    <tr> 
      <td height="250"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="3" height="259" align="center">
          <tr bgcolor="#71694F"> 
            <td><b><font  color="#FFFFFF">Rule(s) 
              for </font></b></td>
            <td> 
              <div align="left"><b></b></div>
            </td>
          </tr>
          <tr> 
            <td valign="top" align="center"> 
              <p><font size="2" face="MS Sans Serif" color="#993333"><b><font size="1" color="#666633">Primary 
                Documents</font></b></font><font size="2" face="MS Sans Serif"><br>
                </font> 
                <textarea cols="30" rows="13" name="rulesDescP" style="color: #003399;width=250" onKeyPress="textlimit(this,299)" onKeyUp="textlimit(this,299)"  readOnly><%=hshValues.get("strPrimRule")%></textarea>
              </p>
            </td>
            <td valign="top" align="center"> <font size="2" face="MS Sans Serif" color="#993333"><b><font size="1" color="#666633">Alternate 
              Document</font></b></font><font size="1" face="MS Sans Serif" color="#666633"><b>s</b></font><br>
             <!--  <textarea cols="10" rows="13" name="rulesDescA" style="color: #003399;width=250" readOnly ><%//=hshValues.get("strAltRule")%></textarea> -->
                <select name="rulesDescA" size="13" ondblclick="addRemarks()" style="width:250">
			<%if(arrRow!=null && arrRow.size()>0)
			{
				for(int i=0;i<arrRow.size();i++)
				{
					arrCol=(ArrayList)arrRow.get(i);%>
					
            
            <%  if(arrCol!=null && arrCol.size()>0)
					{%>
                <option value=<%=arrCol.get(0)%>><%=arrCol.get(0)%></option>
             
              <%	}
				}%>
				
			<%}%>
			 </select>
            </td>
          </tr>
          <tr> 
            <td colspan="2"> 
              <div align="center"> 
                <input type="button" name="cmdOk" value="Close" style="background-color:#CC3300;color:white;font-size=10;font-family:mssansserif;width:50;font-weight:bold" onClick="window.close()">
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <input type="hidden" name="hidAction" />
<input type="hidden" name="hidBeanId" />
<input type="hidden" name="hidBeanMethod" value="" />
<input type="hidden" name="hidBeanGetMethod" value="" />
<input type="hidden" name="hidSourceUrl" />
</form>
</body>
</html>

