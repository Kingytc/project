<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />

<%
/**
*@author: S.SATHYA MOORTHY
*@purpose : FOR DUEDILIGENCE 
*@since : 08/05/2009
*/
%>
<html>
<head>
<title>Application Upload</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";

</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/menudropdown.js"></script>
<SCRIPT LANGUAGE="JavaScript"><!--

function callFunction(pagename)
{
if(ConfirmMsg(100))
	{
		location.href=pagename;
	}
}

function call()
{
	document.forms[0].action=appURL+"action/agr_excelupload.jsp?hidFileType=MULTIPART&hidBeanGetMethod=excelCustomerParser&hidBeanId=exceltolaps";
	document.forms[0].submit(); 
}
function callpro()
{
	document.forms[0].action=appURL+"action/agr_excelupload.jsp?hidBeanMethod=exceltoLaps&hidBeanGetMethod=exceltoLaps&hidBeanId=exceltolaps";
	document.forms[0].submit(); 
}
function moveExistCust()
{
	document.forms[0].action=appURL+"action/agr_excelupload.jsp?hidBeanMethod=exceltoLaps&hidBeanGetMethod=exceltoLapsExistCustomer&hidBeanId=exceltolaps";
	document.forms[0].submit(); 
}

</SCRIPT>
<style>

</style>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body>
<form  method="POST" enctype="multipart/form-data" class="normal">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="page_flow">Home -&gt; Excel Upload</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<p>&nbsp;</p>
  <p align="center"><font size="2"><strong> Upload Excel sheet 
    here!</strong></font></p>
  <p><strong></strong></p>
  <table width="90%" border="0" cellspacing="0" cellpadding="5"
	class="shadow" align="center">
    <tr>
      <td>
        <table width="40%" border="0" cellspacing="0" cellpadding="5"
	 align="center">
          <tr> 
            <td> 
              <table width="98%" cellpadding="1" cellspacing="0" border="0">
                
                <tr> 
                  <td valign="top"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable border1">
					
                      <tr> 
                       <td align="center">File :<input type="file" name="fileUpload" size="80">
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td align="center" height="53"> 
				  <input type="button" value="Proceed" class="buttonStyle" style="width:100" name="proceed"  onClick="call()">
				  <input type="button" name="cmdproc" value="Move to LAS New"
					class="buttonStyle" style="width:150" onClick="callpro()">
				   <input type="button" name="cmdproc" value="Move to LAS Existing"
					class="buttonStyle" style="width:150" onClick="moveExistCust()">
                    <input type="button" name="cmdexit" value="Close"
					class="buttonClose" onClick="callFunction('mainnav.jsp')">
					
                 </td>
                </tr>
                </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <table width="90%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
      <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0"
	 align="center">
          <tr> 
            <td> 
              <table width="98%" cellpadding="0" cellspacing="2" border="0">
               <% 
               if(!Helper.correctNull((String)hshValues.get("errorstatus")).trim().equals(""))
               { 
            	   String[] errStatus=Helper.correctNull((String)hshValues.get("errorstatus")).split("@");
               %>
                <tr> 
                  <td align="left"> 
				  <font color="red" size="3"><strong>Upload Failed for Invalid Data :-</strong></font>
				  </td>
                </tr>
                  <%
				for(int i=0;i<errStatus.length;i++)
				{
					%>        
                <tr> 
                  <td align="left"> 
				 <font color="red" size="3"><strong><%=errStatus[i]%></strong></font>
					
                 </td>
                </tr>
                <%}
               } %>
                 <tr> 
                  <td align="center"> 
				 <font color=red size="3"><strong><%=Helper.correctNull((String)hshValues.get("status"))%></strong></font>
					
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

