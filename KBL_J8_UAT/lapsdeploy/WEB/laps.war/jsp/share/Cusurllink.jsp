<%@ page import="com.sai.laps.helper.*"%>
<%@include file="../share/directives.jsp"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<jsp:useBean id="objValues1" class="java.lang.Object" scope="request" />


<%
if (objValues1 instanceof java.util.HashMap) {
	HashMap hshVal = (java.util.HashMap) objValues1;
}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customer Details</title>
</head>
<%
	String employment = request.getParameter("employmenttype");
	String pageid = request.getParameter("pageid");
	String strProfilestatus=request.getParameter("strProfilestatus");
	String strConstitution=(String)session.getAttribute("strConstitution");
	String Status="";
	String strfacdata=Helper.correctNull((String)hshValues.get("hidfacname"));
	String strIncompletedPageName=request.getParameter("hidincompletedpagename");
	if(strfacdata.equalsIgnoreCase(""))
	{
		strfacdata=Helper.correctNull(request.getParameter("hidfacname"));
					
	}
	String strfacdatanew = "";
	if(strfacdata.equalsIgnoreCase(""))
	{
		strfacdatanew = "N";
	}
	else
	{
		strfacdatanew = "Y";
	}
	
	if(strProfilestatus.equalsIgnoreCase("Y"))
	{
		Status="Completed";
	}
	else
	{
		Status="Not Completed";
	}
	

%>
<script type="text/javascript">
function callDemographics()
{
	if(document.forms[0].hideditflag.value=="N")
	{
	if(isNaN(document.forms[0].txtperapp_appid.value))
	{
			ShowAlert('103');
	}
	else
	{
	document.forms[0].hidBeanId.value="mastapplicant";
	document.forms[0].hidBeanGetMethod.value="getDemographics";
	document.forms[0].action=appURL+"action/perapplicant.jsp";
	document.forms[0].submit();
		}
	}
	else
	{
		ShowAlert('103');
	}
}
function callKYCNorms()
{
	if(document.forms[0].hideditflag.value=="N")
	{
		if(isNaN(document.forms[0].txtperapp_appid.value))
		{
			ShowAlert('103');
		}
		else
		{
			document.forms[0].hidBeanId.value="mastapplicant";
			document.forms[0].hidBeanGetMethod.value="getKYCNormsdetails";
			document.forms[0].action=appURL+"action/set_KYCNorms.jsp";
			document.forms[0].submit();
		}
	}
	else
	{
		ShowAlert('103');
	}
}
function callEmployer()
{
	if(document.forms[0].hideditflag.value=="N")
	{
		if(isNaN(document.forms[0].txtperapp_appid.value))
		{
			ShowAlert('103');
		}
		else
		{
			document.forms[0].hidBeanId.value="mastapplicant";
			document.forms[0].hidBeanGetMethod.value="getEmployer";
			document.forms[0].action=appURL+"action/peremployer.jsp";
			document.forms[0].submit();
		}
	}
	else
	{
		ShowAlert('103');
	}
}
function callIncomeExpenses()
{
	if(document.forms[0].hideditflag.value=="N")
	{
		if(isNaN(document.forms[0].txtperapp_appid.value))
		{
			ShowAlert('103');
		}
		else
		{
			document.forms[0].hidBeanId.value="mastapplicant";
			document.forms[0].hidBeanGetMethod.value="getIncome";
			document.forms[0].action=appURL+"action/perincexpenses.jsp?applnt=P";
			document.forms[0].submit();
		}
	}
	else
	{
		ShowAlert('103');
	}
}
/*function callBranch()
{
	if(document.forms[0].hideditflag.value=="N")
	{
		if(isNaN(document.forms[0].txtperapp_appid.value))
		{
			ShowAlert('103');
		}
		else
		{
			document.forms[0].hidBeanId.value="commappmaster";
			document.forms[0].hidBeanGetMethod.value="getFactoryDetails";
			document.forms[0].action=appURL+"action/comappFactoryDetails.jsp?applnt=P";
			document.forms[0].submit();
		}
	}
	else
	{
		ShowAlert('103');
	}
}*/

function callRating()
{
	if(document.forms[0].hideditflag.value=="N")
	{
		if(isNaN(document.forms[0].txtperapp_appid.value))
		{
			ShowAlert('103');
		}
		else
		{
			document.forms[0].hidBeanId.value="mastapplicant";
			document.forms[0].hidBeanGetMethod.value="getRating";
			document.forms[0].action=appURL+"action/customerRating.jsp";
			document.forms[0].submit();
		}
	}
	else
	{
		ShowAlert('103');
	}
}
function callCommunicationDetails()
{
	if(document.forms[0].hideditflag.value=="N")
	{
		if(isNaN(document.forms[0].txtperapp_appid.value))
		{
			ShowAlert('103');
		}
		else
		{
			document.forms[0].hidBeanId.value="mastapplicant";
			document.forms[0].hidBeanGetMethod.value="getAddressDetails";
			document.forms[0].action=appURL+"action/per_address.jsp";
			document.forms[0].submit();
		}
	}
	else
	{
		ShowAlert('103');
	}
}
function callBranch()
{
	if(document.forms[0].hideditflag.value=="N")
	{
		if(isNaN(document.forms[0].txtperapp_appid.value))
		{
			ShowAlert('103');
		}
		else
		{
			document.forms[0].hidBeanId.value="commappmaster";
			document.forms[0].hidBeanGetMethod.value="getFactoryDetails";
			document.forms[0].action=appURL+"action/comappFactoryDetails.jsp";
			document.forms[0].submit();
		}
	}
	else
	{
		ShowAlert('103');
	}
}
function callLink(page,bean,method)
{ 
	if (document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidAction.value="";
	 	document.forms[0].hidBeanGetMethod.value=method;
	 	document.forms[0].hidBeanId.value=bean;
	 	document.forms[0].action=appURL+"action/"+page;
	 	document.forms[0].submit();
	}
	else 
	{
		ShowAlert(103);
	}
}
function callSisterConcern()
{
	if(document.forms[0].hideditflag.value=="N")
	{
		if(isNaN(document.forms[0].txtperapp_appid.value))
		{
			ShowAlert('103');
		}
		else
		{
			document.forms[0].hidBeanId.value="commappmaster";
			document.forms[0].hidBeanGetMethod.value="getDivisionDetails";
			document.forms[0].action=appURL+"action/comappdivision.jsp?applnt=P";
			document.forms[0].submit();
		}
	}
	else
	{
		ShowAlert('103');
	}
}
function callLand()
{
	if(document.forms[0].hideditflag.value=="N")
	{
		if(isNaN(document.forms[0].txtperapp_appid.value))
		{
			ShowAlert('103');
		}
		else
		{
			document.forms[0].hidBeanId.value="mastapplicant";
			document.forms[0].hidBeanGetMethod.value="getLandbuild";
			document.forms[0].action=appURL+"action/agr_landholdingscust.jsp";
			document.forms[0].submit();
		}
	}
	else
	{
		ShowAlert('103');
	}
}

function callBank()
{
	if(document.forms[0].hideditflag.value=="N")
	{
	
			document.forms[0].hidBeanId.value="mastapplicant";
			document.forms[0].hidBeanGetMethod.value="getBankdetail";
			document.forms[0].action=appURL+"action/perotherbankdetail.jsp";
			document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
	
}
function callShg()
{
	if(document.forms[0].hideditflag.value=="N")
	{
	document.forms[0].hidBeanId.value="perapplicant";
	document.forms[0].hidBeanGetMethod.value="getShgdetails";
	document.forms[0].action=appURL+"action/agr_appshg.jsp";
	document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
	
}

function callSvanidhi()
{
	if(document.forms[0].hideditflag.value=="N")
	{
	document.forms[0].hidBeanId.value="mastapplicant";
	document.forms[0].hidBeanGetMethod.value="getSvanidhiDetails";
	document.forms[0].action=appURL+"action/per_svanidhiDetails.jsp";
	document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
	
}
function callFinancial()
{
	if(document.forms[0].hideditflag.value=="N")
	{
	document.forms[0].hidBeanId.value="mastapplicant";
	document.forms[0].hidBeanGetMethod.value="getBankdetail";
	document.forms[0].action=appURL+"action/perotherbankdetail.jsp";
	document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}

function callFin()
{

	if(document.forms[0].hideditflag.value=="N")
	{
	document.forms[0].hidBeanId.value="commappmaster";
	document.forms[0].hidBeanGetMethod.value="getComfinancialparticularsdata";
	document.forms[0].action=appURL+"action/com_Financialparticulars.jsp";
	document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}		
}
function callMembers()
{
	if(document.forms[0].hideditflag.value=="N")
	{
		document.forms[0].hidBeanId.value="commappmaster";
		document.forms[0].hidBeanGetMethod.value="getSHGmembersDetail";
		document.forms[0].action=appURL+"action/per_shgmembersinfo.jsp";
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}
function callConstBank()
{
	if(document.forms[0].hideditflag.value=="N")
	{
	
			document.forms[0].hidBeanId.value="mastapplicant";
			document.forms[0].hidBeanGetMethod.value="getConsBankdetail";
			document.forms[0].action=appURL+"action/CustBankConsort.jsp";
			document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
	
}

</script>
<body>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable"> 
<tr>
<td align="center"><b><span class="mantatory">(Amount in Rs.)</span></b></td>
</tr>
	
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable"> 
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="1" cellpadding="3"
				align="left" class="outertable">
					<tr align="center">
					<%if((pageid.equalsIgnoreCase("1")))	
					{ %>
						<td class="sub_tab_active" nowrap="nowrap">Demographics</td>
					<% } 
					else
					{%>
						<td class="sub_tab_inactive" nowrap="nowrap"><a
					href="JavaScript:callDemographics()"><b>Demographics</b></a></td>
					<% }
					if((pageid.equalsIgnoreCase("2")))	{
					%>
				<td class="sub_tab_active" nowrap="nowrap">Communication Details</td>
					<%}else{ %>
					<td class="sub_tab_inactive" nowrap="nowrap"><a
					href="JavaScript:callCommunicationDetails()"><b>Communication Details</b></a></td>
					<%
					}
					if((pageid.equalsIgnoreCase("3")))	{
					%>
					<td class="sub_tab_active" nowrap="nowrap">KYC Norms</td>
					<%}
					else{
						%>
					<td class="sub_tab_inactive" nowrap="nowrap"><a
					href="JavaScript:callKYCNorms()"><b>KYC Norms</b></a></td>
					<%
					}
					if((pageid.equalsIgnoreCase("4")))	{
					%>
				<td class="sub_tab_active" nowrap="nowrap">Rating / Defaulter</td>
					<%}else
						{ %>
						<td class="sub_tab_inactive" nowrap="nowrap"><a
					href="JavaScript:callRating()"><b>Rating / Defaulter</b></a></td>
						<%
						}%>

			<%
				if(!(employment.equalsIgnoreCase("6")|| employment.equalsIgnoreCase("7") || employment.equalsIgnoreCase("8") || employment.equalsIgnoreCase("10")))
				{
				if((pageid.equalsIgnoreCase("5")))	
				{
			%>
					<td width="15%" class="sub_tab_active" nowrap="nowrap">Employment Details </td>
			<%		
				}else
				{
			%>
			<td class="sub_tab_inactive" nowrap="nowrap"><a
					href="JavaScript:callEmployer()"><b>Employment Details</b></a></td>
			
			<%}} %>
			<%
			if(!(employment.equalsIgnoreCase("10")))
				{
				if((pageid.equalsIgnoreCase("6")))	
				{
			%>
			<td class="sub_tab_active" nowrap="nowrap">Income / Expenses</td>
			<%		
				}else
				{
				%>
				<td class="sub_tab_inactive" nowrap="nowrap"><a
					href="JavaScript:callIncomeExpenses()"><b>Income / Expenses</b></a></td>
			<%	
				}
				}
			%>
			<%
			if((employment.equalsIgnoreCase("6")|| employment.equalsIgnoreCase("7") || employment.equalsIgnoreCase("8")|| employment.equalsIgnoreCase("11")))
				{
				if((pageid.equalsIgnoreCase("8")))	
				{
			%>
			<td class="sub_tab_active" nowrap="nowrap" >Branches</td>
			<%		
				}
				else
				{ %>
				<td class="sub_tab_inactive" nowrap="nowrap" ><a
					href="JavaScript:callBranch()"><b>Branches</b></a></td>
				<%
					}
				
				}
			%>
			<%
			//if((employment.equalsIgnoreCase("6")|| employment.equalsIgnoreCase("7") || employment.equalsIgnoreCase("8")))
				//{
				if((pageid.equalsIgnoreCase("9")))	
				{
			%>
			<td class="sub_tab_active" nowrap="nowrap">Groups / Management Peoples</td>
			<%		
				}else
				{  %>
			<td class="sub_tab_inactive" nowrap="nowrap"><a
					href="JavaScript:callSisterConcern()"><b>Groups / Management Peoples</b></a></td>
			<%
					
				}
				//}
			%>
			<%
				if((pageid.equalsIgnoreCase("10")))	
				{
			%>
			<td class="sub_tab_active" nowrap="nowrap">Land Holdings</td>
			<%		
				}
				else
				{ %>
				<td class="sub_tab_inactive" nowrap="nowrap" ><a href="JavaScript:callLand()"><b>Land Holdings</b></a></td>
				<%
				}
			%>
			<%
				if((pageid.equalsIgnoreCase("11")))	
				{
			%>
			<td class="sub_tab_active" nowrap="nowrap">Facilities with Other Bank </td>
			<%		
				}
				else
				{ %>
				<td class="sub_tab_inactive" nowrap="nowrap" ><a href="JavaScript:callBank()"><b>Facilities with Other Bank </b></a></td>
				<%
				}
			%>

			
			</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
			<table width="40%" border="0" cellspacing="1" cellpadding="3"
				align="left" class="outertable">
				<tr align="center">
			<%
			int intSHGConstitution = Integer.parseInt(Helper.correctInt(strConstitution));
			if(intSHGConstitution>=183 && intSHGConstitution<=191)
			{
			if((pageid.equalsIgnoreCase("12")))	
				{	 %>
			<td class="sub_tab_active" nowrap="nowrap">SHG Details</td>
			<%}else{ %>
				<td class="sub_tab_inactive" nowrap="nowrap" align="center"><a href="JavaScript:callShg()"><b>SHG Details</b></a></td>
				<%} }
			if((pageid.equalsIgnoreCase("13")))	
			{
		%>
		<td class="sub_tab_active" nowrap="nowrap">SVANidhi Details </td>
		<%		
			}
			else
			{ %>
			<td class="sub_tab_inactive" nowrap="nowrap" ><a href="JavaScript:callSvanidhi();"><b>SVANidhi Details</b></a></td>
			<%
			}
				%>
			<td class="sub_tab_active" nowrap="nowrap" style="text-align: center"><b>Status : <%=Status%>
			<%if(!strIncompletedPageName.equalsIgnoreCase("")) {%>
			( <%=strIncompletedPageName %> )
			<%} %>
			</b></td>
			</tr>
			</table>
			</td>
			</tr>
</table>
</body>
</html>