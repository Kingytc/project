<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>

<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />

<lapschoice:handleerror />

<%
ArrayList vecVal=(ArrayList)hshValues.get("vecVal");
ArrayList vecRec=new ArrayList();
%>


<script>
function onloading()
{ <%
	if(vecVal.size()>0)
	{
		int i=0;
	%>
	parent.frames.document.forms[0].selfacility.length ="<%=vecVal.size()+1%>";
	parent.frames.document.forms[0].selfacility.options['<%=i%>'].text= '-Select-';
    parent.frames.document.forms[0].selfacility.options['<%=i%>'].value= '';
	<%
	for(i=0;i<vecVal.size();i++)
	{
	  vecRec= (ArrayList) vecVal.get(i);

  %>   
	   parent.frames.document.forms[0].selfacility.options['<%=i+1%>'].text= '<%=vecRec.get(1)%>';
	   parent.frames.document.forms[0].selfacility.options['<%=i+1%>'].value= '<%=vecRec.get(0)%>';
	   
    <%
	}
  }
	%>
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