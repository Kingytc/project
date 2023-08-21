<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<lapschoice:handleerror />
<%	
ArrayList arrRow=(ArrayList)hshValues.get("arrRow");
ArrayList arrCol= null;

String strOrgLevel=Helper.correctNull((String)hshValues.get("strOrgLevel"));
String strBranchHeadflag=Helper.correctNull((String)hshValues.get("strBranchHead"));
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varUserId = "<%=Helper.correctNull((String) session.getAttribute("strUserId"))%>";

function callclose()
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/mainnav.jsp";
	document.forms[0].submit();
}

function callOnLoad()
{

}

function callcbsid()
{
	//document.forms[0].hidApplicantId.value = Id;
	var	varQryString = appURL+"action/PSB59InboxCBSID.jsp";	
	var title = "";
	var prop = "scrollbars=yes,width=1050,height=550";
	window.open(varQryString,title,prop);
}

function callloandetails(appRefNo,appid,schemeName,compname)
{
	var ExistingCustId="";
	var branch_refno="";
	var comappid=appid;
	var varpagetype="";
	varpagetype="NP";

	/*if(varemploy !="10")
	{
		alert("Please change the Applicant Employment status to 'Student'");
		return;
	}*/
	//if(varappIDs=="")
		//{
		document.forms[0].page1.value="nr";
		document.forms[0].hidPageType.value="New";
		document.forms[0].hidappno1.value="New";
	 	document.forms[0].hidBeanId.value="NationalPortal";
		document.forms[0].hidBeanGetMethod.value="getLoanProducts";
		document.forms[0].action = appURL + "action/NP_Perloandetails.jsp?appid="+comappid+"&page_type="+varpagetype+"&hidRefno="+appRefNo+"&compname="+compname+"&appno=new";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	/*	}
		else
		{
			alert(' Customer Profile Status is Partial  for this ID('+ varappIDs +'). Please Complete');
			return;
		} */
}
function callapprove(appStatus,refId,lapStatus,schName,ApplicationNo)
{
	//document.forms[0].hidAppStatus.value = appStatus;
	//alert(ApplicationNo);
	document.forms[0].hidApplicantId.value = refId;
	document.forms[0].hidUserId.value = varUserId;
	document.forms[0].hidlapstatus.value = lapStatus;
	document.forms[0].hidschemeName.value = schName;
	document.forms[0].hidApplicationNo.value = ApplicationNo;
	
	var varQryString=appURL+"action/np_approvredisp.jsp?hidBeanId=PSB59&hidApplicantId="+refId+"&hidBeanGetMethod=PSB59getHoldRejStatus&hidUserId="+document.forms[0].hidUserId.value+"&HidLapsStatus="+lapStatus+"&hidApplicationNo="+ApplicationNo;
	var title = "RejectStatus";
	var prop = "scrollbars=yes,width=1150,height=450";
	var xpos = (screen.width - 500) / 2;
	var ypos = (screen.height - 400) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(varQryString,title,prop);
}

</script>
<style>
.mailbox_container
{
	width: 100%;
	height: 350px;
	overflow: auto;
}
</style>
<link rel="stylesheet"	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"	type="text/css">
</head>
<body onload = "callOnLoad();">
<form name="appform" method="post" action=""> 
<table width="98%" border="1" cellpadding="3" cellspacing="0" bordercolorlight="#cccccc" bordercolordark="#FFFFFB" class="shadow" align="center">
<tr>
 <td class="bredcrumb" align="center">
   <h3>Create Application Screen</h3>
 </td>
</tr>
<tr><td>
<table width="98%" border="0" cellspacing="0" cellpadding="5" align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">	
			<tr class="tabactive">
				<td width="11%" align="center" nowrap>Reference ID</td>
				<td width="6%" align="center">Applicant ID</td>
				<td width="15%" align="center">Applicant Name</td>
				<td width="10%" align="center">PAN No</td>
				<td width="10%" align="center">Scheme Name</td>
				<td width="12%" align="center">Organisation Name</td>
				<td width="5%" align="center">Status</td>
				<td width="6%" align="center">App Status</td>
				<td width="6%" align="center">CBS ID</td>
				<td width="6%" align="center" nowrap>Create Application</td>
				<td width="6%" align="center" nowrap> Application No</td>
			</tr>
			<% if(arrRow.size()>0)
					{
						for(int i=0;i<arrRow.size();i++)
						{
						arrCol = (ArrayList)arrRow.get(i);
							
					%>
               	<tr class="datagrid">
				<td width="11%" align="center" nowrap><%=Helper.correctNull((String) arrCol.get(3))%>&nbsp;</td>
				<td width="6%" align="center" nowrap><%=Helper.correctNull((String) arrCol.get(6))%>&nbsp;</td>
				<td width="15%" align="center" nowrap><%=Helper.correctNull((String) arrCol.get(8))%>&nbsp;</td>
				<td width="10%" align="center" nowrap><%=Helper.correctNull((String) arrCol.get(9))%>&nbsp;</td>
				<td width="10%" align="center" nowrap><%=Helper.correctNull((String) arrCol.get(5))%>&nbsp;</td>
				<td width="12%" align="center" nowrap><%=Helper.correctNull((String) arrCol.get(10))%>&nbsp;</td>
				<td width="5%" align="center" nowrap><%=Helper.correctNull((String) arrCol.get(11))%>&nbsp;</td>
				<td align="center" width="10%"><input type="button" name="createapp" style="background-color:#00aedf;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:70" 
				value="Status" onclick="javascript:callapprove('','<%=Helper.correctNull((String) arrCol.get(3))%>','<%=Helper.correctNull((String) arrCol.get(11))%>','<%=Helper.correctNull((String) arrCol.get(5))%>','<%=Helper.correctNull((String) arrCol.get(12))%>')"></td>
				<td width="5%" align="center" nowrap><%=Helper.correctNull((String) arrCol.get(7))%>&nbsp;</td>
				<!-- <td width="6%" align="center">
				<a href="#" onClick="javascript:callcbsid()">CBS ID</a></td> -->
				<%if(!Helper.correctNull((String) arrCol.get(12)).equalsIgnoreCase("") || strOrgLevel.equalsIgnoreCase("R") || strOrgLevel.equalsIgnoreCase("C") || (strOrgLevel.equalsIgnoreCase("A") && strBranchHeadflag.equalsIgnoreCase("Y"))){%>
				<td align="center" width="10%"><input type="button" name="createapp" disabled="disabled" style="background-color:#00aedf;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:70" 
				value="Create App." onclick="javascript:callloandetails('<%=Helper.correctNull((String) arrCol.get(3))%>',
'<%=Helper.correctNull((String) arrCol.get(6))%>','<%=Helper.correctNull((String) arrCol.get(5))%>','<%=Helper.correctNull((String) arrCol.get(8))%>')"></td>
				<%}else{ %>
				<td align="center" width="10%"><input type="button" name="createapp" style="background-color:#00aedf;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:70" 
				value="Create App." onclick="javascript:callloandetails('<%=Helper.correctNull((String) arrCol.get(3))%>',
'<%=Helper.correctNull((String) arrCol.get(6))%>','<%=Helper.correctNull((String) arrCol.get(5))%>','<%=Helper.correctNull((String) arrCol.get(8))%>')"></td>
				<%} %>
                <td width="5%" align="center" nowrap><%=Helper.correctNull((String) arrCol.get(12))%>&nbsp;</td>
				</tr>
             <%}} else {%>
                <tr>
                <td><input type="hidden" name="hidVal" value=""></td>
                </tr>
             <%} %>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
    <input type="hidden" name="hidBeanId" value="">
    <input type="hidden" name="hidBeanGetMethod" value="">
    <input type="hidden" name="hidUserId" value="">
    <input type="hidden" name="page1" value="">
<input type="hidden" name="hidPageType" value="">
<input type="hidden" name="hidappno1" value="">
  <input type="hidden" name="hidId" value="">
    <input type="hidden" name="hidrefId" value="">
    <input type="hidden" name="hidRefId" value="">
    <input type="hidden" name="hidappCode" value="">
    <input type="hidden" name="hidschId" value="">
    <input type="hidden" name="hidschName" value="">
      <input type="hidden" name="hidApplicantId" value="">
      <input type="hidden" name="hidlapstatus" value="">
      <input type="hidden" name="hidschemeName" value="">
      <input type="hidden" name="hidApplicationNo" value="">
</form>
</body>
</html>

