<%@ include file="../share/directives.jsp"%>
<%
	ArrayList g1 = new ArrayList();
	String strFromLink = Helper.correctNull((String) request.getParameter("strfrom"));
	String strvalue = Helper.correctNull((String) hshValues.get("svalue"));
	//out.println("=============================="+hshValues);
%>
<html>
<title>Specifications</title>
<head>
<style type="text/css">
DIV.cellContainer 
{	
  width: 100%; height: 200;
  overflow: auto;
}
</style>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>

<SCRIPT LANGUAGE="JavaScript">	
var from_link = "<%=strFromLink%>";	
var appUrl="<%=ApplicationParams.getAppUrl()%>";
	
function onselect1()
	{
	if (document.forms[0].selradio[0].checked==true)
		{
		document.forms[0].stype.value = document.forms[0].selradio[0].value
		}		
	document.forms[0].txt_ser.disabled = false
	document.forms[0].txt_ser.focus();		
	}
	
function searchData()
	{
	if(trim(document.forms[0].txt_ser.value)=="")
		{
		ShowAlert(121,'Name');
		document.forms[0].txt_ser.focus();
		return;
		}	
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidAction.value="search";
	document.forms[0].hidBeanGetMethod.value="getActivitySpecificationbtdetails";
	document.forms[0].stype.value ="specifications"; 
	document.forms[0].svalue.value = document.forms[0].txt_ser.value; 
	
	document.forms[0].action=appUrl+"action/Specificationmasterlist.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
	}
	
function getSelectedValue(val1, val2)
{
	if(from_link == "specifications")
	{
		
		if(window.opener.document.forms[0].sel_specifications.value==val1)
		{
			alert("both the value remains same!!!")
		}
		else
			{
			
			//window.opener.document.forms[0].sel_specifications.value = val1;
			
			window.opener.document.forms[0].sel_specifications.options[0].text=val2;
			window.opener.document.forms[0].sel_specifications.options[0].value=val1;
		window.opener.document.forms[0].sel_specifications.value = val1;
			}
			
			
			window.close();
		}
		
	
		
}
function doClose()
{
	window.close();
}
</SCRIPT>
</head>
<body >
<form name="productlisthelp" method="post" class="normal">
<div>
<table width="95%" border="0" cellspacing="0" cellpadding="3"
	align="center" class="outertable">
	<tr>
		<td><br>
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
			class="outertable" align="center">
			<tr>
				<td><b>Search </b>
				<table border="0" cellspacing="0" cellpadding="3" width="100%" align="center" class="outertable">
					<tr>
						<td width="30%">Specification Name
						<td width="30%"><input type="text" name="txt_ser" maxlength="40"
							size="40" value="<%=strvalue%>" tabindex="1"
							onKeyPress="notAllowSplChar()"></td>
						<td width="40%" align="center"><input type=button
							class="buttonStyle" value="Search" name="search" tabindex="2"
							onClick="searchData()"></td>
					</tr>
				</table>
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
				class="outertable">
					<tr>
						<td>
						<table width="97%" border="0" cellspacing="1" cellpadding="3"
							class="outertable">
							<tr class="dataheader">
								<td width="15%"><b>Sl. No.</b></td>
								<td width="85%"><b>Specification Name </b></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				<%ArrayList v = (ArrayList) hshValues.get("vecRow");
				 %>
				<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
					<%
			String inside = "N";
			int i=0;
			if (v != null) 
			{
				int vecsize = v.size();
				for (int l = 0; l < vecsize; l++) 
				{
					inside = "Y";
					g1 = (ArrayList) v.get(l);
					if(strFromLink.equalsIgnoreCase("specifications"))
					{
					%>
					<tr valign="top" class="datagrid">
						<td width="15%" align="left"><%=l + 1%>&nbsp;</td>
						<td width="85%" align="left"><a
							href="javascript:getSelectedValue(
		                    '<%=Helper.correctNull((String)g1.get(0))%>','<%=Helper.correctNull((String)g1.get(1))%>'
		                    
		                    )"
							 align="center"><b><%=Helper.correctNull((String) g1
											.get(1))%></b></a></td>
					</tr>
					<%
					}
			
				}
			}
			%>

					<%if (inside.equals("N")) {

			%>
					
					<tr valign="top" class="datagrid">
						<td colspan="2" width="15%" align="center"><b>No Data Found </b>
					</tr>

					<%}%>
				</table>
				
		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew 
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
</div>
<input type="hidden" name="svalue" value="<%=Helper.correctNull((String)hshValues.get("svalue"))%>"> 
<input type="hidden" name="stype" value="<%=Helper.correctNull((String)hshValues.get("scode"))%>"> 
<input type="hidden" name="strfrom" value="<%=strFromLink%>"> 
<input type="hidden" name="org_name" value="<%=session.getAttribute("strOrgName")%>"> 
<input type="hidden" name="org_code" value="<%=session.getAttribute("strOrgCode")%>">
<input type="hidden" name="namevalue" value="<%=session.getAttribute("strnamevalue")%>">

<input type="hidden" name="hidscheme" value="<%=Helper.correctNull((String)hshValues.get("selScheme"))%>"> 
<input type="hidden" name="hidstate" value="<%=Helper.correctNull((String)hshValues.get("sel_state"))%>"> 
<input type="hidden" name="hidactivity" value="<%=Helper.correctNull((String)hshValues.get("sel_actname"))%>"> 

 <lapschoice:hiddentag pageid='<%=PageId%>'/> 
</form>
</body>
</html>

