<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld" %>
<%
	String strApptype=Helper.correctNull(request.getParameter("apptype"));
	String strUsrClass=Helper.correctNull((String)session.getAttribute("strUserClass"));
%>

<html>
<head>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<SCRIPT LANGUAGE="JavaScript">
var apptype="<%=strApptype%>";
var strUsrClass="<%=strUsrClass%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";

	function getSelectedValue()
	{
		
		
		var varproducthelp=document.forms[0].defaulthelp.selectedIndex;
		
		if(varproducthelp == -1)
		{
			ShowAlert(111,'Defaulter');
			return false;
		}
	
		
				if(varproducthelp!=-1 && varproducthelp!=null)
				{
					var varValue=document.forms[0].defaulthelp.value;
						
					window.opener.document.forms[0].txt_check.value=varValue;
						
					window.opener.document.forms[0].hidBeanGetMethod.value="getDefaulter";
				
					window.opener.document.forms[0].hidBeanId.value="cad";
					
					window.opener.document.forms[0].action=appUrl+"/action/defaulter.jsp";
					//window.opener.document.forms[0].hidSourceUrl.value="/action/defaulter.jsp";
					
					window.opener.document.forms[0].submit();
				
										
					
					window.close();
				}
				else
				{
					ShowAlert(111,'Defaulter');
					return false;
					//ShowAlert(121,'Name of the Business');
				}
		
		
		
		
	}
	
	</SCRIPT>
<style type="text/css">
<!--
select {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399; border-style: groove}
-->
</style>
</head>
<body bgcolor="#EEEAE3" onLoad="">
	<form name="productlisthelp" method="post">
  <table width="30%" border="1" cellspacing="0" cellpadding="0" align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="5" align="center">
          <tr> 
            <td bgcolor="#71694F"><font size="2" face="MS Sans Serif" color="#FFFFFF"><b>Select 
              Defaulter</b></font></td>
          </tr>
          <tr> 
            <td> 
              <select name="defaulthelp" size="20" onDblClick="getSelectedValue()" style="width:550">
                 <laps:defaulter /> 
              </select>
            </td>
          </tr>
          <tr> 
            <td> 
              <table width="10%" border="0" cellspacing="0" cellpadding="3" align="center">
                <tr valign="top"> 
                  <td width="20%"> 
                    <input type=button style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" value="OK" name="createbtn" tabindex="21" onClick="getSelectedValue()">
                  </td>
                  <td width="20%"> 
                    <input type=button style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" value="Close" name="closebtn" tabindex="25"  onClick=window.close()>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <!--These hidden variable need to be  in the parent form -->
</form>
</body>
</html>
