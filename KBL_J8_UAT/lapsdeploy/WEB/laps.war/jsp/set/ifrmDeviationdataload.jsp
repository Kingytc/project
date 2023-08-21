<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%
ArrayList arrRow=(ArrayList)hshValues.get("arrRow");
ArrayList arrCol=new ArrayList();
%>
<html>
<head>
<title>Security Classification</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>
var sectype="<%=Helper.correctNull((String)request.getParameter("sectype"))%>";
var pagefrom="<%=Helper.correctNull((String)request.getParameter("pagefrom"))%>";
function loadValues()
{
	if(pagefrom=="permParam1")
	{
	

	<%
	 if (arrRow!=null && arrRow.size() > 0)
	 {	%>	
	 	parent.frames.document.forms[0].sel_devSubType.length ="<%=arrRow.size()+1%>";	
		parent.frames.document.forms[0].sel_devSubType.options[0].text="----select----";
		parent.frames.document.forms[0].sel_devSubType.options[0].value="S";
			<%for(int i=0;i<arrRow.size();i++)
			{
				arrCol=new ArrayList();
				arrCol=(ArrayList)arrRow.get(i);
				String strCode=Helper.correctNull((String)arrCol.get(0));
				String strClassificationDesc=Helper.correctNull((String)arrCol.get(1));
			%>		
		    parent.frames.document.forms[0].sel_devSubType.options[<%=i+1%>].text="<%=strClassificationDesc%>";
			parent.frames.document.forms[0].sel_devSubType.options[<%=i+1%>].value="<%=strCode%>";
			
		<%	}if(!Helper.correctNull((String)request.getParameter("sectype")).equalsIgnoreCase("")){	%>
			parent.frames.document.forms[0].sel_devSubType.value="<%=Helper.correctNull((String)request.getParameter("sectype"))%>";

	  <%} } else	{ %>
	  parent.frames.document.forms[0].sel_devSubType.length ="1";	
		parent.frames.document.forms[0].sel_devSubType.options[0].text="----select----";
		parent.frames.document.forms[0].sel_devSubType.options[0].value="S";
		 
	 <%	 }	%>

	}

	if(pagefrom=="permParam2")
	{
		parent.frames.clearrows("tab_permParam");
		<%
		 if (arrRow!=null && arrRow.size() > 0)
		 {			
				for(int i=0;i<arrRow.size();i++)
				{
					arrCol=new ArrayList();
					arrCol=(ArrayList)arrRow.get(i);
					String strCode=Helper.correctNull((String)arrCol.get(0));
					String strClassificationDesc=Helper.correctNull((String)arrCol.get(1));
				%>	
				var table=parent.frames.document.getElementById("tab_permParam");
				var rowCount=table.rows.length; 
				var row=table.insertRow(rowCount++);
				row.id=""+rowCount;
				row.className="datagrid";
				var cell1=row.insertCell(0);
				cell1.innerHTML="<td align='center'><input type='checkbox' name='chkFac' onClick='callFacsnoChk()' style='border-style:none' value='<%=strCode%>'> </td><td colspan='3'><%=strClassificationDesc%></td>";

			<%	}	%>

		  <% } else	{ %>

		  parent.frames.clearrows("tab_permParam");	
			 
		 <%	 }	%>

	}

	
}

</script>
</head>

<body bgcolor="#E4E2ED" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="appfrm" method="post">
</form>
</body>
</html>
