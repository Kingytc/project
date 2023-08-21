<%@ page import="com.sai.laps.helper.*,java.util.HashMap" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request"/>
<laps:handleerror/>


<html>
<head>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/per/perloanhist.js">
</script>
<script>
  var appUrl = "<%=ApplicationParams.getAppUrl()%>";
  var varstat = "<%=(String)hshValues.get("strStatus")%>";
  var varappno="<%=Helper.correctNull((String)hshValues.get("strAppno"))%>";
	if(varstat ="op")
	{
		varstat = "Open/Pending";
	}
	
  function callAppPageNew(appno,cname,pstatus)
  {
	  document.forms[0].hidprinDtls.value = "<%=Helper.correctNull(request.getParameter("hidprinDtls"))%>";
		document.forms[0].hidcollDtls.value = "<%=Helper.correctNull(request.getParameter("hidcollDtls"))%>";
		document.forms[0].hidfinDtls.value = "<%=Helper.correctNull(request.getParameter("hidfinDtls"))%>";

	  if(varappno != "")
	  {
	  document.forms[0].appno.value=appno;
	  document.forms[0].appname.value=cname;
	  document.forms[0].appstatus.value=pstatus;
	  document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/comloanproduct.jsp";
	  document.forms[0].submit();
	  }
	  else
	  {
	  alert("Not a valid ID");
  	  document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/comloanhistroy.jsp";
	  document.forms[0].submit();

	  }


  }

</script>
  
</head>
<body onLoad = "callAppPageNew(varappno,'<%=(String)hshValues.get("strCompany")%>',varstat)">

<form method="post" action="">
<input type="hidden" name="hidBeanGetMethod" value="getLoanProducts">
<input type="hidden" name="hidpge"  value="newpge">

<input type="hidden" name="appno" >
<input type="hidden" name="appname">
<input type="hidden" name="appstatus">

<input type ="hidden" name ="hidprinDtls">
<input type ="hidden" name ="hidcollDtls">
<input type ="hidden" name ="hidfinDtls">

</form>

</body>
</html>