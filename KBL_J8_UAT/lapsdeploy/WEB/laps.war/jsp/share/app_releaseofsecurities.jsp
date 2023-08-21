<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	String strAppno = "", strFacCategory = "";
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
	ArrayList vecData = new ArrayList();
	ArrayList vecRow = new ArrayList();
	ArrayList vecFacID = new ArrayList();
	ArrayList arrColFacID = new ArrayList();
	ArrayList arrFacID = new ArrayList();
	ArrayList arrFacCol=new ArrayList();
	ArrayList arrFacRow=new ArrayList();
	String hidposition= Helper.correctNull((String)hshValues.get("hidposition"));
	String hidFacID= Helper.correctNull((String)hshValues.get("hidFacID"));
	String Securitycount=Helper.correctNull((String)request.getParameter("Securitycount"));
	if (hshValues != null) 
	{
		vecData = (ArrayList) hshValues.get("vecData");
		arrColFacID = (ArrayList) hshValues.get("arrColFacID");
		arrFacRow= (ArrayList) hshValues.get("arrFacRow");
	}
	String str_Existing= Helper.correctNull((String)hshValues.get("Existing"));
	String str_Proposed= Helper.correctNull((String)hshValues.get("Proposed"));
%>

<html>
<head>
<title>Securities Attach</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varCategoryType="<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>";
var vecSize = "<%=vecData.size()%>";
var hidFacID = "<%=hidFacID%>";
function onload()
{
	<%
	if(arrColFacID!=null && arrColFacID.size()>0)
	{
		for(int l=0;l<arrColFacID.size();l++)
		{
			ArrayList arraySec=(ArrayList)arrColFacID.get(l);
			//not null
			if(Helper.correctNull((String)arraySec.get(7)).equalsIgnoreCase("R"))
			{
				if(arrColFacID.size()==1)
				{
					%>
					document.forms[0].chk_facility.checked=true;
					<%
				}
				else
				{
					%>
					document.forms[0].chk_facility["<%=l%>"].checked=true;
					<%
				}
			}
		}
	}
	else
	{%>
		document.forms[0].cmdrelease.disabled=true;
	<%}%>
}
function doClose()
{	
	var con=ConfirmMsg('100');
	if(con)
	{
		window.close();
	}
}
function doRelease()
{var flag=true;
	if(document.forms[0].chk_facility.length==1)
	{
		if(document.forms[0].chk_facility.checked==false)
		{
			alert("Select Facility");
			document.forms[0].chk_facility.focus();
			return;
		}
	}
	else
	{
		var i=0,u=0;
		for(i=0;i<document.forms[0].chk_facility.length;i++)
		{
			if(document.forms[0].chk_facility[i].checked==true)
			{
				flag=false;
				break;
			}
		}
		if(flag)
		{
			if(i==document.forms[0].chk_facility.length)
			{
				alert("Select Facility");
				document.forms[0].chk_facility[0].focus();
				return;
			}
			else
			{
				alert("Select Facility");
				document.forms[0].chk_facility[i].focus();
				return;
			}
		}
	}
	var var_hidchk="";
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=="checkbox")
		{
			if(document.forms[0].elements[i].checked)
			{
				var_hidchk=var_hidchk+"1@";
			}
			else
			{
				var_hidchk=var_hidchk+"0@";
			}
		}
	}
	document.forms[0].hidchk.value=var_hidchk;
	document.forms[0].hidAction.value="release";
	document.forms[0].hidBeanId.value="securitymaster"
	document.forms[0].hidBeanMethod.value="updateReleaseofSecurity";
	document.forms[0].hidBeanGetMethod.value="getReleaseofSecurity";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/app_releaseofsecurities.jsp";
	document.forms[0].submit();
	window.close();
}
</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>
<%
	String strLink=Helper.correctNull((String)request.getParameter("linkFrom"));
%>
<body onload="onload();">
<form name="persearchMast" method="post" class="normal">

<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable"  align="center">	
						
						<%boolean flag=true;
						int vecsize = 0,n=0;
						if(str_Existing.equalsIgnoreCase("Y"))
						{
						%>
						<tr class="dataheader">
							<td width="5%"  align="center">&nbsp;</td>
							<td align="center">Facility</td>
							<td align="center">Security ID</td>
							<td align="center">Security Type</td>
							<td align="center">Security Value</td>
							<td align="center">Type</td>
							<td align="center">Amount</td>
							<td align="center">Margin (%)</td>
						</tr>
						<tr class="dataheader"><td width="100%" align="left" colspan="8"><b>Existing Facilities</b></td></tr>
						<%
						if (vecData != null && vecData.size()>0) 
						{
							vecsize = vecData.size();
						for (int i = 0; i < vecsize; i++) 
						{
							vecRow = (ArrayList) vecData.get(i);
							if (vecRow != null) 
							{
								if(Helper.correctNull((String) vecRow.get(8)).equalsIgnoreCase("E")){
									int o=vecRow.size();
								//add comment
									for(int g=12;g<o;g++)
									{flag=false;
								 arrFacCol = (ArrayList) vecRow.get(g);
								 ArrayList arrcol=(ArrayList)arrColFacID.get(n);
					%>		<tr class="datagrid">
							<td width="5%"><input type="checkbox" name="chk_facility" value="<%=Helper.correctNull((String) vecRow.get(4))%>" style="border-style: none"></td>
							<td><%=Helper.correctNull((String) vecRow.get(0))%> <input type="hidden" name="txt_facilitysno" value="<%=Helper.correctNull((String) arrcol.get(6))%>"> </td>
							<td><%=Helper.correctNull((String) arrFacCol.get(1))%> <input type="hidden" name="txt_secid" value="<%=Helper.correctNull((String)  arrFacCol.get(1))%>"> </td>
							<td><%=Helper.correctNull((String) arrFacCol.get(2))%> - <%=Helper.correctNull((String) arrFacCol.get(3)) %> </td>
							<td align="right"><%=Helper.checkDecimal(Helper.correctDouble((String) arrFacCol.get(4)))%>  </td>
							<td align="center">
								<input type="hidden" name="hidparentappno" value="<%=Helper.correctNull((String) vecRow.get(10))%>">
								<input type="hidden" name="hidparentsno" value="<%=Helper.correctNull((String) vecRow.get(11))%>">
								<%if(Helper.correctNull((String) arrcol.get(2)).equalsIgnoreCase("1"))
									{
									out.println("Primary");
									}else
									{
										out.println("Collateral");	
									} %>
								<input type="hidden" name="txt_type" value="<%=Helper.correctNull((String) vecRow.get(1))%>"></td>
							<td align="right"><%=Helper.correctNull((String) vecRow.get(1))%><input type="hidden" name="txt_amount" value="<%=Helper.checkDecimal(Helper.correctNull((String) vecRow.get(1)))%>"></td>
							<td  align="right"><%=Helper.correctNull((String) arrcol.get(1)) %></td>
						</tr>
					<%	n++;}}	} }
					} if(flag) {
					%>
					<tr class="datagrid"><td width="100%" align="center" colspan="5">&nbsp;NO FACILITIES &nbsp;</td></tr>
					<%}} 
					if(flag) {
					%>
					<tr class="datagrid"><td width="100%" align="center" colspan="5">&nbsp;NO FACILITIES &nbsp;</td></tr>
					<%}%>
					</table>
					</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
	</td>
	</tr>
</table>
<table width="15%" border='1' cellspacing='0' cellpadding='0' class='outertable' align="center">
	<tr>
		<td>
			<table border='0' cellspacing='0' cellpadding='3' >
			<tr>
				<td width="7%"><input type="button" name="cmdrelease" value="Release" class="buttonOthers" onClick="doRelease()"> </td>
				<td width="8%"><input id="attachbtn" type="button" name="cmdclose" value="Close" class="buttonClose" onClick="doClose()"></td>
			</tr>
			</table>
		</td>
	</tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidchk" value="">  
<input type="hidden" name="hidSecID" value="">  
<input type="hidden" name="hidFacSno" value="">  
<input type="hidden" name="hid_count" value="<%=n%>">
<input type="hidden" name="hidappno" value="<%=Helper.correctNull((String)request.getParameter("appno")) %>">
</form>
</body>
</html>
