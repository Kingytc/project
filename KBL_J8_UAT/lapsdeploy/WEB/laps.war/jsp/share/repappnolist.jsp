<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>

<laps:handleerror />

<html>
<head>
<title>LAPS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
select {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399}

-->
</style>

<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>

<script>
function display()
{
	if(document.forms[0].selProd.length == 0)
	{
		document.forms[0].selProd.disabled = true;
		document.all.dis.style.visibility="visible";
		document.all.unprod.style.visibility="hidden";
	}
	else
	{
		document.forms[0].selProd.disabled = false;
		document.all.dis.style.visibility="hidden";
		document.all.unprod.style.visibility="visible";
	}

}
function selectno()
{
	if (document.forms[0].selProd.length > 0)
	{
		if (document.forms[0].selProd.selectedIndex == -1)
		{
			ShowAlert("111","Application Number");
			document.forms[0].selProd.focus();
			return false;
		}
		else
		{
		window.opener.document.forms[0].txtAppno.value= document.forms[0].selProd.options[document.forms[0].selProd.selectedIndex].text;
		window.close();
		}
	}
	else
	{
		window.close();
	}
}
</script>



</head>
<%!
	String beanid = "";
   String meth = "";
   String strTagValue ="";
   HashMap h = new HashMap();
   HashMap hp1 = new HashMap();
   String strV="";
%>
<%

 try
 {
   
   beanid = (String)request.getParameter("beanid");
   meth = (String)request.getParameter("method");
   strV = (String)request.getParameter("orgcode");
   strTagValue = strV;
   h.put("org",strV);
   h.put("hidMethod","getAppno");

   hp1.put("BeanId",beanid);
   hp1.put("MethodName",meth);
   hp1.put("BeanParam",h);
 }
 catch(Exception e)
 {
	 out.println(e);
 }
%>
<body bgcolor="#EEEAE3" text="#000000" onLoad="display()">
<form name="purge" action="">
  <table width="300" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable border1">
    <tr> 
      <td valign="top"> 
        <table width="300" border="0" cellspacing="0" cellpadding="5" align="center">
          <tr> 
            <td align="left" bgcolor="#71694F" id="dis" ><font size="2" face="MS Sans Serif" color="#FFFFFF"><b> 
              <center>
                No Data Available 
              </center>
              </b></font></td>
          </tr>
          <tr id ="unprod" style="visibility:hidden"><b>
            <center>
              <font size="2" face="MS Sans Serif" color="#000000">Application Numbers</font>
            </center>
            </b> 
            <td align="center" > 
              <select name="selProd" size=10 style="width:180"  onDblClick="selectno()">
                <laps:selecttag value='<%=hp1%>' /> 
              </select>
            </td>
          </tr>
          <tr> 
            <td height="17">&nbsp;</td>
          </tr>
          <tr> 
            <td> 
              <table border="0" cellspacing="0" cellpadding="3" align="center">
                <tr> 
                  <td align="center"> 
                    <input type="button" name="cmdok" value="OK" style="background-color:#8F8369;color:white;font-size=10;font-family:mssansserif;width:50;font-weight:bold" onClick="selectno()"
							>
                  </td>
                  <td align="center"> 
                    <input type="reset" name="cmdCancel" value="Close" style="background-color:#CC3300;color:white;font-size=10;font-family:mssansserif;width:50;font-weight:bold" onClick="window.close()">
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</form>
</body>
</html>


