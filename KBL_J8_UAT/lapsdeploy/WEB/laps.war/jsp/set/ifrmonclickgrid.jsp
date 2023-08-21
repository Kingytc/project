<%@include file="../share/directives.jsp"%>

<%
//ArrayList arrRow=(ArrayList)hshValues.get("vecRow1");
//ArrayList arrCol=new ArrayList();

ArrayList arrRow=(ArrayList)hshValues.get("vecRow1");
ArrayList arrCol=new ArrayList();
String strJointlapsid="",strJointname="",strJointcbsid="",strJointsno="";
%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Securities</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>

function loadValues()
{
	//parent.frames.document.forms[0].sel_subsectcode.options[0].text="----select----";
	//parent.frames.document.forms[0].sel_subsectcode.options[0].value="0";
	//parent.frames.document.forms[0].sel_securityclassifcation.length ="<%=arrRow.size()+1%>";

<%

	 if (arrRow!=null && arrRow.size() > 0)
	 {			
			for(int i=0;i<arrRow.size();i++)
			{
				
				arrCol=new ArrayList();
				arrCol=(ArrayList)arrRow.get(i);
				strJointname=Helper.correctNull((String)arrCol.get(1));
				strJointlapsid=Helper.correctNull((String)arrCol.get(0));
				strJointcbsid=Helper.correctNull((String)arrCol.get(2));
				strJointsno=Helper.correctNull((String)arrCol.get(4));
			%>		
		  //  parent.frames.document.all.jointname[<%=i%>].innerText="<%=strJointname%>";
			///parent.frames.document.all.jointlapsid[<%=i%>].innerText="<%=strJointlapsid%>";
		//	parent.frames.document.all.jointcbsid[<%=i%>].innerText="<%=strJointcbsid%>";
			
<%	}
	 }
	else
	 {
%>
		
		//parent.frames.document.forms[0].jointname.innerText ="";
		// parent.frames.document.forms[0].jointlapsid.innerText="";
		//	parent.frames.document.forms[0].jointcbsid.innerText="";
<%	 }
%>
//if(parent.frames.varsancauthority!="")
//parent.frames.document.forms[0].sel_securityclassifcation.value=parent.frames.varsancauthority;
}
function selectValuesForJointSecurity(){

parent.frames.document.all.ownership.style.visibility = "visible";
parent.frames.document.all.ownership.style.position = "relative";
parent.frames.document.all.ownership1.style.visibility = "visible";
parent.frames.document.all.ownership1.style.position = "relative";
parent.frames.document.forms[0].txt_security_ownership.value="<%=strJointlapsid%>";
parent.frames.document.forms[0].hidsno.value="<%=strJointsno%>";	
}
</script>
</head>

<body bgcolor="#E4E2ED" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="appfrm" method="post">
	 <table width="100%" border="0" cellspacing="0" cellpadding="0"	class="outertable border1">
	<tr>
		<td valign="top">
			<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
				<tr class="dataheader">
					<td width="5%">&nbsp;</td>
					<td width="30%" align="center">Name</td>
					<td width="30%" align="center">Laps Id</td>			
            		<td width="30%" align="center">CBS Id</td>					
				</tr>	
				<% if (arrRow!=null && arrRow.size() > 0)
{			
	for(int i=0;i<arrRow.size();i++)
	{
		
		arrCol=new ArrayList();
		arrCol=(ArrayList)arrRow.get(i);
		strJointname=Helper.correctNull((String)arrCol.get(1));
		strJointlapsid=Helper.correctNull((String)arrCol.get(0));
		strJointcbsid=Helper.correctNull((String)arrCol.get(2));
		strJointsno=Helper.correctNull((String)arrCol.get(4));
	 %>
						<tr class="datagrid">
							<td width="5%"><input type="radio" name="radiobutton1" value="radiobutton" style="border-style:none" onClick="selectValuesForJointSecurity()"></td>
							<td width="30%" align="center" id="jointname">&nbsp;<%=strJointname%></td>
							<td width="30%" align="center" id="jointlapsid"><%=strJointlapsid%></td>
							<td width="30%" align="center" id="jointcbsid"><%=strJointcbsid%></td>				
						</tr>
						
	 <%} 
	 }%>
	 </table></td></tr></table>
<input type="hidden" name="lapsid" value=""> 
</form>
</body>
</html>
