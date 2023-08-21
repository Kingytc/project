<%@include file="../share/directives.jsp"%>

<%			
int rowcount = Integer.parseInt(Helper.correctInt((String)request.getParameter("rowcount")));
int rowIndex = Integer.parseInt(Helper.correctInt((String)request.getParameter("rowIndex")));
String temp = Helper.correctNull((String) request.getParameter("temp1"));

 %>
<html>
<head>
<title>SearchSecurity_Details</title>
<SCRIPT LANGUAGE="JavaScript">
var appURL="<%=ApplicationParams.getAppUrl()%>";
var rowcount="<%=rowcount%>";
var rowIndex="<%=rowIndex%>";
var vartemp="<%=temp%>";

function callSearch()
{
	
	var txtval=document.forms[0].sec_name.value;
	var txtlen=txtval.length;	
	if(txtval=="")
	{
		 alert("Enter Value to Search");
	     document.forms[0].sec_name.focus();
	     return;
	}
	else if(txtlen<=2)
	 {
		alert("Enter atleast 3 charcters");
		document.forms[0].sec_name.focus();
		return;
	 }
	
	document.forms[0].hidBeanGetMethod.value="getsecuritydet";
	document.forms[0].hidBeanId.value="mastapplicant";
	document.forms[0].action=appURL+"action/searchSecurityDet.jsp?rowcount="+rowcount+"&rowIndex="+rowIndex+"&temp1="+vartemp;
	document.forms[0].submit();
}

function doClose()
{
 	window.close();
} 
function onRadioClick()
{
	document.forms[0].sec_name.readOnly=false;			
	document.forms[0].sec_name.value="";
	document.forms[0].sec_name.focus();
}

function enableSearch(myform)
{
	if(window.event && window.event.keyCode==13)
		callSearch();
	else
		return true;
}
function setValues(val1,val2,val3,val4)
{
	if(rowcount==1)
	{
		window.opener.document.forms[0].txt_secur_id.value = val1;
		window.opener.document.forms[0].txt_secur_appname.value = val2;
		window.opener.document.forms[0].txt_secur_desp.value = val3;
		window.opener.document.forms[0].txt_secur_val.value = val4;
	}else
	{
		var temp1=vartemp.split("@");
		 var valuerlen=temp1.length;
			 for(var i=0;i<valuerlen;i++)
		     {  
				if(temp1 [i]==val1)
				{
					alert("Selected Applicant is already attached for this Application");
					return;
				}
		     }
		window.opener.document.forms[0].txt_secur_id[<%=(rowIndex-1)%>].value = val1;
		window.opener.document.forms[0].txt_secur_appname[<%=(rowIndex-1)%>].value = val2;
		window.opener.document.forms[0].txt_secur_desp[<%=(rowIndex-1)%>].value = val3;
		window.opener.document.forms[0].txt_secur_val[<%=(rowIndex-1)%>].value = val4;
	}
	window.close();
}
</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
<form name="appform" method="post" class="normal">
<table width="98%" border="0" cellpadding="5" cellspacing="0" class="outertable" align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable">
			<tr class="datagrid">
				<td width="16%" nowrap="nowrap"> 
					<input type="radio" name="category" value="LAPSID" style="border-style:none" onClick="onRadioClick()">LAPS ID</td>
				<td width="16%" nowrap="nowrap"> 
					<input type="radio" name="category" value="CBSID" style="border-style:none" onClick="onRadioClick()">CBS Applicant ID</td>
	            <td width="16%">
					<input type="text" name="sec_name" onKeypress="enableSearch(this.form)"></td>
				<td>&nbsp;&nbsp;&nbsp;
					<input type="button" name="Submit" value="Search" class="buttonStyle" onClick="callSearch();"></td>
			</tr>
		</table>
		<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable linebor">
			<tr class="dataheader">
				<td width="5%" ><b>S.No</b></td>
				<td width="20%"><b>Security Code</b></td>
				<td width="20%"><b>Applicant Name</b></td>
				<td width="35%"><b>Security Description</b></td>
				<td width="20%"><b>Security Value</b></td>
			</tr>
		</table>
	  	<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable linebor">
	  	<%	
						ArrayList arrRow=new ArrayList();
	  					int e=0;
						if(hshValues!=null)
						{
							arrRow = (ArrayList)hshValues.get("arryRow1");
						}		
						ArrayList arrCol=new ArrayList();
						if (arrRow != null && arrRow.size() > 0)							
						{
						for (int i = 0; i < arrRow.size(); i++) 
						{
							arrCol = (ArrayList) arrRow.get(i);
							e=e+1;
						%>
						
					 <tr class="datagrid">
							<td width="5%"><%=e%></td>
							<td width="20%"><a href="javascript:setValues('<%= Helper.correctNull((String)arrCol.get(0))%>','<%= Helper.correctNull((String)arrCol.get(1))%>','<%= Helper.replaceForJavaScriptString(Helper.correctNull((String)arrCol.get(2)))%>','<%= Helper.correctNull((String)arrCol.get(3))%>')"><%= Helper.correctNull((String)arrCol.get(0))%></a></td>
							<td width="20%"><%= Helper.correctNull((String)arrCol.get(1))%></td>
							<td width="35%"><%= Helper.correctNull((String)arrCol.get(2))%></td>
							<td width="20%"><%= Helper.correctNull((String)arrCol.get(3))%></td>
					</tr>
					<% 	 }
                       } else { %>
                      <tr class="datagrid">
							<td colspan="5" align="center"> No Data Found</td>
						</tr>
                    <%} %>
                                   
			</table>
		</td>
	</tr>
	<tr>
		<td>
			<table width="10%" border="0" cellspacing="0" cellpadding="3" align="center">
				<tr valign="top">
					<td width="20%"><lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' /></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<lapschoice:hiddentag /> 


<br>
</form>
</body>
</html>
