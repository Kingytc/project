<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.sai.laps.helper.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customer Details</title>
</head>
<%
	String employment = request.getParameter("employmenttype");
	if(employment.equalsIgnoreCase(""))
	{
		employment=Helper.correctNull((String)request.getParameter("hidEmployment"));
	}
	if(employment.equalsIgnoreCase(""))
	{
		employment=Helper.correctNull((String)session.getAttribute("strNewEmployment"));
	}
	String pageid = Helper.correctNull((String)request.getParameter("pageid"));
	String strConstitution=(String)session.getAttribute("strConstitution");
	if(pageid.equalsIgnoreCase(""))
		pageid = Helper.correctNull((String)request.getParameter("subsubpageid"));
	String demoid = request.getParameter("demoid");
%>
<script type="text/javascript">
var demoid= "<%=demoid%>";
function callDemographics()
{
	if(demoid=="C" || document.forms[0].hidDemoId.value!="")
	{
		document.forms[0].hidBeanId.value="mastapplicant";		
		document.forms[0].hidBeanGetMethod.value="getDemographics";
		if(demoid=="C")
		document.forms[0].action=appURL+"action/perapplicantdispco.jsp?corp=C";
		else
		document.forms[0].action=appURL+"action/perapplicantdispco.jsp?corp=R";
		document.forms[0].submit();
	}
	else
	{
		alert("Select Applicant");
	}
	
}
function callKYCNorms()
{

	if(demoid=="C" || document.forms[0].hidDemoId.value!="")
	{		
			document.forms[0].hidBeanId.value="mastapplicant";
			document.forms[0].hidBeanGetMethod.value="getKYCNormsdetails";
			if(demoid=="C")
			document.forms[0].action=appURL+"action/set_KYCNorms.jsp?corp=C";
			else
			document.forms[0].action=appURL+"action/set_KYCNorms.jsp?corp=R";
			document.forms[0].submit();
	}
	else
	{
		alert("Select Applicant");
	}
	
}
function callEmployer()
{
	if(demoid=="C" || document.forms[0].hidDemoId.value!="")
	{		
			document.forms[0].hidBeanId.value="mastapplicant";
			document.forms[0].hidBeanGetMethod.value="getEmployer";
			if(demoid=="C")
			document.forms[0].action=appURL+"action/peremployer.jsp?corp=C";
			else
			document.forms[0].action=appURL+"action/peremployer.jsp?corp=R";
			document.forms[0].submit();
	}
	else
	{
		alert("Select Applicant");
	}
}
function callIncomeExpenses()
{
	if(demoid=="C" || document.forms[0].hidDemoId.value!="")
	{		
			document.forms[0].hidBeanId.value="mastapplicant";
			document.forms[0].hidBeanGetMethod.value="getIncome";
			if(demoid=="C")
			document.forms[0].action=appURL+"action/perincexpenses.jsp?corp=C";
			else
			document.forms[0].action=appURL+"action/perincexpenses.jsp?corp=R";
			document.forms[0].submit();

	}
	else
	{
		alert("Select Applicant");
	}
}
function callBank()
{
	if(demoid=="C" || document.forms[0].hidDemoId.value!="")
	{
			document.forms[0].hidBeanId.value="mastapplicant";
			document.forms[0].hidBeanGetMethod.value="getBankdetail";
			if(demoid=="C")
				document.forms[0].action=appURL+"action/perotherbankdetail.jsp?corp=C";
		    else
				document.forms[0].action=appURL+"action/perotherbankdetail.jsp?corp=R";
			document.forms[0].submit();
	}
	else
	{
		alert("Select Applicant");
	}
	
}
function callRating()
{
	if(demoid=="C" || document.forms[0].hidDemoId.value!="")
	{		
			document.forms[0].hidBeanId.value="mastapplicant";
			document.forms[0].hidBeanGetMethod.value="getRating";
			if(demoid=="C")
			document.forms[0].action=appURL+"action/customerRating.jsp?corp=C";
			else
			document.forms[0].action=appURL+"action/customerRating.jsp?corp=R";
			document.forms[0].submit();

	}
	else
	{
		alert("Select Applicant");
	}
}

function callLink(page,bean,method)
{ 
	if(demoid=="C" || document.forms[0].hidDemoId.value!="")
	{
		document.forms[0].hidAction.value="";
	 	document.forms[0].hidBeanGetMethod.value=method;
	 	document.forms[0].hidBeanId.value=bean;
	 	if(demoid=="C")
	 		document.forms[0].action=appURL+"action/"+page+"?corp=C";
		else
	 		document.forms[0].action=appURL+"action/"+page+"?corp=R";
		document.forms[0].submit();
	}
	else 
	{
		alert("Select Applicant");
	}
}
function callCommunicationDetails()
{
	if(demoid=="C" || document.forms[0].hidDemoId.value!="")
	{		
			document.forms[0].hidBeanId.value="mastapplicant";
			document.forms[0].hidBeanGetMethod.value="getAddressDetails";
			if(demoid=="C")
				document.forms[0].action=appURL+"action/per_address.jsp?corp=C";
			else
				document.forms[0].action=appURL+"action/per_address.jsp?corp=R";
			document.forms[0].submit();

	}
	else
	{
		alert("Select Applicant");
	}
}
function callSecurities()
{
	if(document.forms[0].hidDemoId.value!="")
	{		
			alert("Securities");
			/*document.forms[0].hidBeanId.value="mastapplicant";
			document.forms[0].hidBeanGetMethod.value="getIncome";
			document.forms[0].action=appURL+"action/perincexpenses.jsp?applnt=P";
			document.forms[0].submit();*/
	}
	else
	{
		alert("Select Applicant");
	}
}
function callBranch()
{
	if(demoid=="C" || document.forms[0].hidDemoId.value!="")
	{
			document.forms[0].hidBeanId.value="commappmaster";
			document.forms[0].hidBeanGetMethod.value="getFactoryDetails";
			if(demoid=="C")
			document.forms[0].action=appURL+"action/comappFactoryDetailsdisp.jsp?corp=C";
			else 
			document.forms[0].action=appURL+"action/comappFactoryDetailsdisp.jsp?corp=R";
			document.forms[0].submit();
	}
	else
	{
		alert("Select Applicant");
	}
}

function callSisterConcern()
{
	if(demoid=="C" || document.forms[0].hidDemoId.value!="")
	{
			document.forms[0].hidBeanId.value="commappmaster";
			document.forms[0].hidBeanGetMethod.value="getDivisionDetails";
			if(demoid=="C")
			document.forms[0].action=appURL+"action/comappdivision.jsp?corp=C&applnt=P";
			else
			document.forms[0].action=appURL+"action/comappdivision.jsp?corp=R&applnt=P";
			document.forms[0].submit();
	}
	else
	{
		alert("Select Applicant");
	}
}
function callMembers()
{
	if(demoid=="C" || document.forms[0].hidDemoId.value!="")
	{
		document.forms[0].hidBeanId.value="commappmaster";
		document.forms[0].hidBeanGetMethod.value="getSHGmembersDetail";
		if(demoid=="C")
			document.forms[0].action=appURL+"action/per_shgmembersinfo.jsp?corp=C";
		 else
			document.forms[0].action=appURL+"action/per_shgmembersinfo.jsp?corp=R";
		document.forms[0].submit();
	}
	else
	{
		alert("Select Applicant");
	}
}

function callFin()
{
	if(demoid=="C" || document.forms[0].hidDemoId.value!="")
	{
	document.forms[0].hidBeanId.value="commappmaster";
	document.forms[0].hidBeanGetMethod.value="getComfinancialparticularsdata";
	if(demoid=="C")
		document.forms[0].action=appURL+"action/com_Financialparticulars.jsp?corp=C";
	else
		document.forms[0].action=appURL+"action/com_Financialparticulars.jsp?corp=R";
	document.forms[0].submit();
	}
	else
	{
		alert("Select Applicant");
	}		
}
function callShg()
{
	if(demoid=="C" || document.forms[0].hidDemoId.value!="")
	{
	document.forms[0].hidBeanId.value="perapplicant";
	document.forms[0].hidBeanGetMethod.value="getShgdetails";
	if(demoid=="C")
		document.forms[0].action=appURL+"action/agr_appshg.jsp?corp=C";
	else
		document.forms[0].action=appURL+"action/agr_appshg.jsp?corp=R";
	document.forms[0].submit();
	}
	else
	{
		alert("Select Applicant");
	}
	
}
function callSvanidhi()
{
	if(demoid=="C" || document.forms[0].hidDemoId.value!="")
	{
	document.forms[0].hidBeanId.value="mastapplicant";
	document.forms[0].hidBeanGetMethod.value="getSvanidhiDetails";
	if(demoid=="C")
		document.forms[0].action=appURL+"action/per_svanidhiDetails.jsp?corp=C";
	else
		document.forms[0].action=appURL+"action/per_svanidhiDetails.jsp?corp=R";
	document.forms[0].submit();
	}
	else
	{
		alert("Select Applicant");
	}
	
}
function callLand()
{
	
	if(demoid=="C" || document.forms[0].hidDemoId.value!="")
	{		
			document.forms[0].hidBeanId.value="agrlandholdings";
			document.forms[0].hidBeanMethod.value="getLandHoldingDataDisp";
			document.forms[0].hidBeanGetMethod.value="getLandHoldingDataDisp";
			if(demoid=="C")
			document.forms[0].hidSourceUrl.value="/action/agr_landholdingscust.jsp?corp=C";
			else
			document.forms[0].hidSourceUrl.value="/action/agr_landholdingscust.jsp?corp=R";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].submit();

	}
	else
	{
		alert("Select Applicant");
	}
}
</script>
<body>
<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable"> 
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="1" cellpadding="3"
				align="left" class="outertable">
					<tr align="center">
					<%if((pageid.equalsIgnoreCase("21")))	
					{ %>
						<td class="sub_tab_active" nowrap="nowrap">Demographics</td>
					<% } 
					else
					{%>
						<td class="sub_tab_inactive" nowrap="nowrap"><a
					href="JavaScript:callDemographics()"><b>Demographics</b></a></td>
					<% }
					if((pageid.equalsIgnoreCase("22")))	{
					%>
				<td class="sub_tab_active" nowrap="nowrap">Communication Details</td>
					<%}else{ %>
					<td class="sub_tab_inactive" nowrap="nowrap"><a
					href="JavaScript:callCommunicationDetails()"><b>Communication Details</b></a></td>
					<%
					}
					if((pageid.equalsIgnoreCase("23")))	{
					%>
					<td class="sub_tab_active" nowrap="nowrap">KYC Norms</td>
					<%}
					else{
						%>
					<td class="sub_tab_inactive" nowrap="nowrap"><a
					href="JavaScript:callKYCNorms()"><b>KYC Norms</b></a></td>
					<%
					}
					if((pageid.equalsIgnoreCase("24")))	{
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
				if((pageid.equalsIgnoreCase("25")))	
				{
			%>
					<td class="sub_tab_active" nowrap="nowrap">Employment Details </td>
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
				if((pageid.equalsIgnoreCase("26")))	
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
			<!--<td class="sub_tab_inactive" nowrap="nowrap"><a
					href="JavaScript:callSecurities()"><b>Securities</b></a></td>-->
			<%
			if((employment.equalsIgnoreCase("6")|| employment.equalsIgnoreCase("7") || employment.equalsIgnoreCase("8")|| employment.equalsIgnoreCase("11")))
				{
				if((pageid.equalsIgnoreCase("28")))	
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
				if((pageid.equalsIgnoreCase("29")))	
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
				
				<td class="sub_tab_inactive" nowrap="nowrap" ><a
					href="JavaScript:callLand()"><b>Land Holdings</b></a></td>
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
			}%>
			
			
			
			</tr>
			</table>
		</td>
	</tr>
</table>
</body>
</html>