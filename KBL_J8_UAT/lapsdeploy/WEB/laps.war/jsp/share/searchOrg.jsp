<%@include file="../share/directives.jsp"%>
<%	
	ArrayList arrValues=new ArrayList();
	if(hshValues!=null)
	{
		arrValues=(ArrayList)hshValues.get("arrBranch");
	}
	String strFldName = request.getParameter("forgname");
	String strFldCode = request.getParameter("forgscode");
	String strFldOrgCode = Helper.correctNull((String)request.getParameter("forgcode"));
	
	if(strFldOrgCode.equalsIgnoreCase(""))
		strFldOrgCode="txt_perbranch";
%>
<html>
<head>
<title>Branch Search</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
</style>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var state = "<%=Helper.correctNull((String)hshValues.get("strStatId"))%>";

function callSearch()
{
	if(document.forms[0].cat[0].checked)
	{
		cat=1;
	}
	else if (document.forms[0].cat[1].checked)
	{
		cat=2;
	}
	else
	{
		alert("Select a search criteria to search");
		return;
	}
	
	var txtval=document.forms[0].txt_branchname.value;
	var txtlen=txtval.length;	
	if (cat==2)
	{
		if(txtlen<=2)
		{
			alert("Enter atleast 3 characters");
			document.forms[0].txt_branchname.focus();
			return;
		}
	}
	else if(txtval=="")
	{
		alert("Enter Value to Search");
		document.forms[0].txt_branchname.focus();
		return;
	}
	document.forms[0].method="post";
	document.forms[0].hidBeanMethod.value="getBranchSearchList";
	document.forms[0].hidBeanId.value="mastapplicant";
	document.forms[0].action=appURL+"action/searchOrg.jsp";	
	document.forms[0].submit();
}

function callBranch()
{
	if(document.forms[0].txt_branchname.value=="")
	{
		alert("Enter minimum 3 characters");
		document.forms[0].action=appURL+"action/setorg.jsp";
		document.forms[0].submit();
	}
}

function ClearFields()
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
				  document.forms[0].elements[i].value="";		  
			}		
			
		}
	}

function setValues(value1,value2,value3,value4)
{
	if(document.forms[0].fpageFrom.value=="CBS")
	{
		if(window.opener.document.forms[0].hidForexFac.value=="Y" && value4!="4")
		{
			alert("Please select Forex Designated branch");
			return;
		}
	}
	window.opener.document.forms[0].<%=strFldName%>.value = value2;
	window.opener.document.forms[0].<%=strFldCode%>.value = value1;
	if(window.opener.document.forms[0].<%=strFldOrgCode%>){
	window.opener.document.forms[0].<%=strFldOrgCode%>.value = value3;
	}
	window.close();
}

/*function callReset()
{
	document.forms[0].txt_branchname.value=="";
	document.forms[0].txt_branchname.focus();
}*/
function callReset()
{	document.forms[0].reset();
	document.forms[0].txt_branchname.readOnly=false;
	document.all.txt_branchname.src=appURL+'action/blank.jsp';
}

function doSelect()
{
	document.forms[0].txt_branchname.value="";
	document.forms[0].txt_branchname.focus();
}
function callonLoad()
	{
	
	}
    
</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callonLoad()">
<form name="appform" method="post" class="normal">
<table width="98%" border="0" cellspacing="0" cellpadding="0"
	align="center">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>Organisation Search</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>

<table width="98%" border="0" cellpadding="5" cellspacing="0"
	class="outertable border1" align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="1"
			class="outertable">
			<tr>
				<td>

				<table width="100%" border="0" cellspacing="0" cellpadding="1"
					class="outertable">
					<tr>
						<td width="4%" nowrap><input type="radio" name="cat"
							value="1" onClick="doSelect()" style="border-style: none">
						</td>
						<td width="25%" nowrap>Branch Code</td>
						<td width="4%" nowrap><input type="radio" name="cat"
							value="2" onClick="doSelect()" style="border-style: none">
						</td>
						<td width="17%" nowrap>Branch Name</td>
						<td width="16%"><input type="text" name="txt_branchname"
							size="20" maxlength="25" value="" onClick="callReset()" onKeyPress="notAllowSplChar()">
						</td>
						<td width="16%" align="center"><input type="button"
							name="cmdsearch" value="Search" class="buttonStyle"
							onClick="callSearch()"></td>
						<td width="18%" align="center"><input type="button"
							name="cmdreset" value="Reset" class="buttonStyle"
							onClick="callReset()"></td>
					</tr>
					<tr>
						<td colspan="7" nowrap>&nbsp;</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="outertable">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="1" cellpadding="3"
							class="outertable">
							<tr class="dataheader" align="center">
								<td width="10%">Sno</td>
								<td width="45%">Branch Code</td>
								<td width="45%">BranchName</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td valign="top" align="center" height="230">
						<DIV class="cellcontainer">
						<table width="100%" border="0" cellspacing="1" cellpadding="2"
							class="outertable">
							<%
                                      if(arrValues!=null)
                                      {
                                    	  int arrSize=arrValues.size();
                                    	  ArrayList arrCol=null;
                                          for(int i=0;i<arrSize;i++)
                                    	  {
                                        	  arrCol=new ArrayList();
                                        	  arrCol=(ArrayList)arrValues.get(i);
                                       %>
							<tr class="datagrid">

								<td width="10%"><%=i+1%></td>
								<td width="45%"><a
									href="javascript:setValues('<%= Helper.correctNull((String)arrCol.get(0))%>','<%= Helper.correctNull((String)arrCol.get(1))%>','<%= Helper.correctNull((String)arrCol.get(2))%>','<%= Helper.correctNull((String)arrCol.get(3))%>')"><%= Helper.correctNull((String)arrCol.get(0))%></a></td>
								<td width="45%"><a
									href="javascript:setValues('<%= Helper.correctNull((String)arrCol.get(0))%>','<%= Helper.correctNull((String)arrCol.get(1))%>','<%= Helper.correctNull((String)arrCol.get(2))%>','<%= Helper.correctNull((String)arrCol.get(3))%>')"><%= Helper.correctNull((String)arrCol.get(1))%></a></td>
							</tr>
							<% 		  
                                    	  }
                                    	  
                                      }
                                      
                                   %>
							<tr>
								<td width="10%">&nbsp;</td>
								<td width="45%">&nbsp;</td>
								<td width="45%">&nbsp;</td>
							</tr>
							<tr>
								<td width="10%">&nbsp;</td>
								<td width="45%">&nbsp;</td>
								<td width="45%">&nbsp;</td>
							</tr>
							<tr>
								<td width="10%">&nbsp;</td>
								<td width="45%">&nbsp;</td>
								<td width="45%">&nbsp;</td>
							</tr>
							<tr>
								<td width="10%">&nbsp;</td>
								<td width="45%">&nbsp;</td>
								<td width="45%">&nbsp;</td>
							</tr>
							<tr>
								<td width="10%">&nbsp;</td>
								<td width="45%">&nbsp;</td>

								<td width="45%">&nbsp;</td>
							</tr>
							<tr>
								<td width="10%">&nbsp;</td>
								<td width="45%">&nbsp;</td>
								<td width="45%">&nbsp;</td>
							</tr>
							<tr>
								<td width="10%">&nbsp;</td>
								<td width="45%">&nbsp;</td>
								<td width="45%">&nbsp;</td>
							</tr>
						</table>
						</div>
						<table width="10%" border="0" cellspacing="0" cellpadding="3"
							align="center" class="outertable">
							<tr valign="top">
								<td width="20%"><input type=button class="buttonClose"
									value="Close" name="closebtn" tabindex="25"
									onClick=window.close()></td>
							</tr>
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

<input type="hidden" name="hidBranchCode"
	value="<%=Helper.correctNull((String)request.getParameter("hidBranchCode")) %>">
<input type="hidden" name="hidBeanMethod" value="getBranchSearchList">
<input type="hidden" name="hidBeanId" value="mastapplicant"> <input
	type="hidden" name="hidBeanGetMethod" value="getBranchSearchList">
<input type="hidden" name="forgname"
	value="<%=request.getParameter("forgname")%>"> <input
	type="hidden" name="forgscode"
	value="<%=request.getParameter("forgscode")%>"><input
	type="hidden" name="forgcode"
	value="<%=strFldOrgCode%>"><input
	type="hidden" name="fpageFrom"
	value="<%=request.getParameter("fpageFrom")%>">  <br>
</form>
</body>
</html>
