<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />

<laps:handleerror />
<%
   if(objValues instanceof java.util.HashMap)
   {
	   hshValues=(java.util.HashMap)objValues;
	   //System.out.println("hshValues..in jsp.."+hshValues);
   }

//System.out.println("iframeshowgraph");
String strserverIP=(String)hshValues.get("strIP");
String strfileName=(String)hshValues.get("strFile");
//System.out.println("strIP==="+strserverIP);
//System.out.println("strfileName==="+strfileName);

%>
<HTML>
<HEAD>
<TITLE> New Document </TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
</HEAD>
<script>
function onloading()
{ var server="ftp://"+'<%=strserverIP%>'+"/";
  document.location.href=server+'<%=strfileName%>';

}
</script>
<BODY onload="onloading()" method="post">
<form name="frmshowgraph">
<iframe id="idfrm1" width="100" height="130" scrolling="no" frameborder=no></iframe> 
</form>
</BODY>
</HTML>
