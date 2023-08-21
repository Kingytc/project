<%@include file="../share/directives.jsp"%>

<%			
int rowcount = Integer.parseInt(Helper.correctInt((String)request.getParameter("rowcount")));
int rowIndex = Integer.parseInt(Helper.correctInt((String)request.getParameter("rowIndex")));
String temp = Helper.correctNull((String) request.getParameter("temp"));

 %>
<html>
<head>
<title>SearchSecurity_Details</title>
<SCRIPT LANGUAGE="JavaScript">
var appURL="<%=ApplicationParams.getAppUrl()%>";
var rowcount="<%=rowcount%>";
var rowIndex="<%=rowIndex%>";
var vartemp="<%=temp%>";

function callExisting()
{
	if(document.forms[0].radiobutton.checked)
	{
		cat=1;
	}
	else
	{
		alert("Select a search criteria to search");   
		return;
	}
	if(document.forms[0].radiobutton.checked==true)
	{
		if(trim(document.forms[0].txtsearch.value) == "")
		{
			ShowAlert(121,'Search Criteria');
			document.forms[0].txtsearch.focus();
			return false;
		}
	}
	var txtval=document.forms[0].txtsearch.value;
	if(document.forms[0].radiobutton.checked == true && txtval == "")
	{
		ShowAlert('121','CBS Custemer ID');
		return false;
	}
	document.forms[0].hidBeanGetMethod.value="getdepositdet";
	document.forms[0].hidBeanId.value="mastapplicant";
	document.forms[0].action=appURL+"action/searchDepositDet.jsp?rowcount="+rowcount+"&rowIndex="+rowIndex+"&temp="+vartemp;
	document.forms[0].submit();
}


function onRadioClick()
{
	document.forms[0].txtsearch.value="";
	document.forms[0].txtsearch.readOnly=false;
	document.forms[0].txtsearch.focus();
}
function doClose()
{
 	window.close();
} 

function setValues(val1,val2,val3,val4,val5,val6)
{

	if(rowcount==1)
	{
		window.opener.document.forms[0].txt_dep_name.value = val1;
		window.opener.document.forms[0].txt_dep_accno.value = val2;
		window.opener.document.forms[0].txt_dep_depamt.value = val3;
		window.opener.document.forms[0].txt_dep_presbal.value = val4;
		window.opener.document.forms[0].txt_dep_maturdate.value = val5;
		window.opener.document.forms[0].txt_dep_roi.value = val6;
	}else if(rowcount>1)
	{
		
		 var temp1=vartemp.split("@");
		 var valuerlen=temp1.length;
			 for(var i=0;i<valuerlen;i++)
		     {  
				if(temp1 [i]==val2)
				{
					alert("Selected Customer is already attached for this Application");
					return;
				}
		     }
		window.opener.document.forms[0].txt_dep_name[<%=(rowIndex-1)%>].value = val1;
		window.opener.document.forms[0].txt_dep_accno[<%=(rowIndex-1)%>].value = val2;
		window.opener.document.forms[0].txt_dep_depamt[<%=(rowIndex-1)%>].value = val3;
		window.opener.document.forms[0].txt_dep_presbal[<%=(rowIndex-1)%>].value = val4;
		window.opener.document.forms[0].txt_dep_maturdate[<%=(rowIndex-1)%>].value = val5;
		window.opener.document.forms[0].txt_dep_roi[<%=(rowIndex-1)%>].value = val6;
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
					<td width="15%" align="right"><input type="radio" name="radiobutton" value="CBSID" style="border-style:none" onClick="onRadioClick()"></td>
					<td width="20%">CBS Customer ID</td>
					<td width="25%"><input type="text" name="txtsearch" size="20" maxlength="20" readOnly="readonly" onKeyPress="notAllowSplChar();" tabindex="2"></td>
					<td width="40%" align="left"><input type="button" name="cmdOK2" value="Search" class="buttonStyle" style="width:75" onClick="callExisting()" tabindex="3"></td>
			</tr>
		</table>
		<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable linebor">
			<tr class="dataheader">
				<td width="5%" ><b>S.No</b></td>
				<td width="18%"><b>Name</b></td>
				<td width="17%"><b>Account No.</b></td>
				<td width="15%"><b>Deposit Amt (Rs.)</b></td>
				<td width="20%"><b>Present balance (Rs.)</b></td>
				<td width="13%"><b>Maturity Date</b></td>
				<td width="12%"><b>Rate of Int (%)</b></td>
			</tr>
		</table>
	  	<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable linebor">
	  	<%	
						ArrayList arrRow=new ArrayList();
	  					int e=0;
						if(hshValues!=null)
						{
							arrRow = (ArrayList)hshValues.get("arryRow2");
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
							<td width="18%"><a href="javascript:setValues('<%= Helper.correctNull((String)arrCol.get(0))%>','<%= Helper.correctNull((String)arrCol.get(1))%>','<%= Helper.correctNull((String)arrCol.get(2))%>','<%= Helper.correctNull((String)arrCol.get(3))%>','<%= Helper.correctNull((String)arrCol.get(4))%>','<%= Helper.correctNull((String)arrCol.get(5))%>')"><%= Helper.correctNull((String)arrCol.get(0))%></a></td>
							<td width="17%"><%= Helper.correctNull((String)arrCol.get(1))%></td>
							<td width="15%"><%= Helper.correctNull((String)arrCol.get(2))%></td>
							<td width="20%"><%= Helper.correctNull((String)arrCol.get(3))%></td>
							<td width="13%"><%= Helper.correctNull((String)arrCol.get(4))%></td>
							<td width="12%"><%= Helper.correctNull((String)arrCol.get(5))%></td>
					</tr>
					<% 	 }
                       } else { %>
                      <tr class="datagrid">
							<td colspan="7" align="center"> No Data Found</td>
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
