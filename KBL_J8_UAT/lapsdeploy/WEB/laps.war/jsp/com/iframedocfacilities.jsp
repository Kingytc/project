<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
<%
   
   java.util.ArrayList arrAppDocCode=(java.util.ArrayList)hshValues.get("appdoccode");
   java.util.ArrayList arrAppDocDesc=(java.util.ArrayList)hshValues.get("appdocdesc");
   java.util.ArrayList arrIntDocCode=(java.util.ArrayList)hshValues.get("intdoccode");
   java.util.ArrayList arrIntDocDesc=(java.util.ArrayList)hshValues.get("intdocdesc");
   
%>


<script>

var appdoccode=new Array();
 var appdocdesc=new Array();
 var intdoccode=new Array();
 var intdocdesc=new Array();
 var applen="<%=arrAppDocCode.size()%>";
 var intlen="<%=arrIntDocCode.size()%>";
 <%
   for(int k1=0;k1<arrAppDocCode.size();k1++){
 %>
	 appdoccode[<%=k1%>]="<%=arrAppDocCode.get(k1)%>";
	 appdocdesc[<%=k1%>]="<%=arrAppDocDesc.get(k1)%>";
<%
 }
%>
<%
   for(int k2=0;k2<arrIntDocCode.size();k2++){
 %>
	 intdoccode[<%=k2%>]="<%=arrIntDocCode.get(k2)%>";
     intdocdesc[<%=k2%>]="<%=arrIntDocDesc.get(k2)%>";
<%
 }
%>


function onloading()
{	
	for(var i=0;i<applen;i++)
	{
		parent.document.forms[0].elements["adoc_desc"][i].value=appdocdesc[i];
		parent.document.forms[0].elements["adoc_code"][i].value=appdoccode[i];
	}
	for(var i1=applen;i1<parent.document.forms[0].adoc_desc.length;i1++)
	{
		parent.document.forms[0].elements["adoc_desc"][i1].value="";
		parent.document.forms[0].elements["adoc_code"][i1].value="";
	}
	for(var j=0;j<intlen;j++)
	{
		parent.document.forms[0].idoc_desc[j].value=intdocdesc[j];
		parent.document.forms[0].idoc_code[j].value=intdoccode[j];
	}
	for(var j1=intlen;j1<parent.document.forms[0].idoc_desc.length;j1++)
	{
		parent.document.forms[0].elements["idoc_desc"][j1].value="";
		parent.document.forms[0].elements["idoc_code"][j1].value="";
	}	
	
	
}

</script>
<style type="text/css">
<!--
input {  font-family: "MS Sans Serif"; font-size: 10px; border-style: groove; font-weight: bold}
-->
</style>

<body onload="onloading()" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >
<form name="frm1" method="post">
</form>
</body>