<%
/*
	Module Name :	Presanction Appraisal - Credit Information
					This page is used within CreditInformation screen to load 
					the promoters list using iFrame
	Page Name   :	promoters.jsp
	Created By  :	Chitra
	Modified By :   Harini.V
*/
%>
<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>

<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />

<HTML>
<HEAD>
<TITLE> New Document </TITLE>
<style type="text/css">
<!--
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
textarea {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
-->

DIV.cellContainer {	
  width: 100%; height: 64;
  overflow: auto;
}
DIV.cellSecond {	
  width: 100%; height: 254;
  overflow: auto;
}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
</STYLE>


<script language="JavaScript">
var flag = '<%= hshValues.get("flag") %>';
<%
	ArrayList vecValues = (ArrayList) hshValues.get("Data");
	//System.out.println("haiiiiiiiiiiiiiiiiiii");
	//System.out.println("vecValues.size()--------"+vecValues.size());
	out.println("var size ="+(vecValues.size())+";");
	out.println("var pname = new Array(size);");
	out.println("var paddr = new Array(size);");
	out.println("var pposi = new Array(size);");

	out.println("function setData()");
	out.println("{");
	HashMap hshRecord=null;
	for(int i=0;i<vecValues.size();i++)
	{
		hshRecord = (HashMap) vecValues.get(i);
		out.println("pname["+i+"] = '"+hshRecord.get("prom_promname")+"';");
		out.println("paddr["+i+"] = '"+hshRecord.get("prom_promaddress")+"';");
		out.println("pposi["+i+"] = '"+hshRecord.get("prom_promposition")+"';");
	}
	out.println("}");
%>

function populateData()
{	
}

</script>
</HEAD>

<BODY bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" background="" onload="populateData()">
<form name = "promofrm">
<div class="cellContainer"> 
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
	<% for (int i=0;i<(vecValues.size());i++)
	{
		hshRecord = (HashMap) vecValues.get(i);
	%>
        <tr> 
        <td width="3%" height="17"><b><font size="1" face="MS Sans Serif"> </font></b></td>
        <td width="26%" height="17"><b><font size="1" face="MS Sans Serif"> 
          <input type="text" name="pname" size="25" maxlength="40" value="<%=hshRecord.get("prom_promname")%>" readOnly>
          </font></b></td>
        <td width="33%" height="17"> 
          <div align="left"><b><font size="1" face="MS Sans Serif"> 
            <input type="text" name="paddr" size="35" maxlength="50" value="<%=hshRecord.get("prom_promaddress")%>" readOnly>
            </font></b></div>
        </td>
        <td width="36%" height="17"> 
          <div align="left"><b><font size="1" face="MS Sans Serif"> 
            <input type="text" name="pposi" size="30" maxlength="30" value="<%=hshRecord.get("prom_promposition")%>" readOnly>
            </font></b></div>
        </td>
      </tr>
	<%
	}
	%>
    </table>
</div>
</form>
</BODY>
</HTML>
