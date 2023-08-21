<%@include file="../share/directives.jsp"%>

<html>
<head>
<title>Welcome to Interface</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function crisilram()
{
document.forms[0].action="action/interfacerammain.jsp";
document.forms[0].submit();


}
function finacle()
{
document.forms[0].action="action/interfacefinaclemain.jsp";
document.forms[0].submit();
}

function alpm()
{
document.forms[0].action="action/interfacealpmmain.jsp";
document.forms[0].submit();

}
function doClose()
{
document.forms[0].action="action/setupnav.jsp";
document.forms[0].submit();

 }

function cibil()
{
		document.forms[0].hidBeanId.value="setstatecity";
		document.forms[0].hidBeanGetMethod.value="getDataCibilDetails";
		document.forms[0].action=appURL+"action/set_cibilinterface.jsp";
		document.forms[0].submit();
}

function updateUser() {
	
	document.forms[0].hidBeanId.value        = "setstatecity";
	document.forms[0].hidBeanMethod.value    = "updateUserOnlDetails";
	document.forms[0].hidBeanGetMethod.value = "getData";
	document.forms[0].hidSourceUrl.value     = "action/interfacenav.jsp";
	document.forms[0].action                 = appURL+"controllerservlet";
	document.forms[0].submit();

}

function updateOrg() {
	
	document.forms[0].hidBeanId.value         = "setstatecity";
	document.forms[0].hidBeanMethod.value     = "updateOrgOnlDetails";
	document.forms[0].hidBeanGetMethod.value  = "getData";
	document.forms[0].hidSourceUrl.value      = "action/interfacenav.jsp";
	document.forms[0].action                  = appURL+"controllerservlet";
	document.forms[0].submit();
}

function updateCity() {
	
	document.forms[0].hidBeanId.value        = "setstatecity";
	document.forms[0].hidBeanMethod.value    = "updateCityOnlDetails";
	document.forms[0].hidBeanGetMethod.value = "getData";
	document.forms[0].hidSourceUrl.value     = "action/interfacenav.jsp";
	document.forms[0].action                 = appURL+"controllerservlet";
	document.forms[0].submit();
}

function updateState() {
	
	document.forms[0].hidBeanId.value         = "setstatecity";
	document.forms[0].hidBeanMethod.value     = "updateStateOnlDetails";
	document.forms[0].hidBeanGetMethod.value  = "getData";
	document.forms[0].hidSourceUrl.value      = "action/interfacenav.jsp";
	document.forms[0].action                  = appURL+"controllerservlet";
	document.forms[0].submit();
}

</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>

<body >

<form name=form1 class="normal">

  <table class="outertable" width="20%" border="0" align="center" cellpadding="5" cellspacing="0" >
    <tr>
      <td > 
        <div align="center"><b><span class="mantatory"><strong><u>EXPORT AND IMPORT</u></strong></span> </b></div>
      </td>
    </tr>
    <tr> 
      <td  align="center"> 
        <input type="button" name="cmdcrisilram" value="IRB" onClick="crisilram()" class="buttonothers">
</td>
    </tr>
    <tr> 
      <td  align="center">
      <input type="button" name="cmdfinacle" value="FINACLE" onClick="finacle()" class="buttonothers">
        </td>
          
    </tr>

    <tr>
        <tr> 
      <td align="center">
      <input type="button" name="cmdfinacle" value="CIBIL Interface" onClick="cibil()" 
      class="buttonothers">
        </td>
    </tr>
  </table>
  </br>
   <table class="outertable border1 tableBg" width="50%" border="0" align="center" cellpadding="0" cellspacing="0" >
  
     <tr> <td>
  <table class="outertable" width="100%" border="0" align="center" cellpadding="3" cellspacing="0" >
  
     <tr> 
      <td align="center">
	      <input type="button" name="cmdUser" value="USER ONLINE UPDATE" onClick="updateUser()" 
	      class="buttonothers">
       </td>
        
      <td align="center">
	      <input type="button" name="cmdOrg" value="  ORG ONLINE UPDATE" onClick="updateOrg()" 
	      class="buttonothers">
       </td>
    </tr>
    
   
    <tr> 
      <td align="center">
	      <input type="button" name="cmdCity" value="CITY ONLINE UPDATE" onClick="updateCity()" 
	      class="buttonothers">
       </td>
    
       <td align="center">
	      <input type="button" name="cmdState" value="STATE ONLINE UPDATE" onClick="updateState()" 
	      class="buttonothers">
       </td>
    </tr>
 
  </table><td>
  </tr>
  </table>
   </br>
<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
 
</form>
</body>
</html>
