<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />        
<lapschoice:handleerror />
<%
response.addHeader("P3P","CP=\"IDC DSP COR ADM DEVi TAIi PSA PSD IVAi IVDi CONi HIS OUR IND CNT\"");
response.addHeader("X-UA-Compatible","IE=EmulateIE8");

java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
nf.setGroupingUsed(false);
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
ArrayList arrRow = (ArrayList)hshValues.get("ApplDetails"); 
ArrayList arrCol=new ArrayList();
ArrayList arrRowrcv = (ArrayList)hshValues.get("RcvApplDetails"); 
ArrayList arrColrcv=new ArrayList();
String strOrglevel = Helper.correctNull((String) hshValues.get("strOrgLevel"));
String NPSegment=Helper.correctNull((String) hshValues.get("NPSegment"));
session.setAttribute("SegType",NPSegment);

/*
String producttype=NPSegment;
if(producttype.equalsIgnoreCase("HL")){
	producttype="RETAIL";
}else if(producttype.equalsIgnoreCase("EDU")){
	producttype="RETAIL";
}else if(producttype.equalsIgnoreCase("AGRI")){
	producttype="AGRI";
}else if(producttype.equalsIgnoreCase("BS")){
	producttype="CORP";
}else if(producttype.equalsIgnoreCase("LHD")){
	producttype="AGRI";
}
*/
String producttype="RETAIL";


%>
<html>
<head>
<title>NSDL Application - MailBox</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
	
<script>
var varUserId = "<%=Helper.correctNull((String) session.getAttribute("strUserId"))%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varsegment = "<%=Helper.correctNull((String) hshValues.get("NPSegment"))%>";
var varinwardno = "<%=Helper.correctNull((String) hshValues.get("INWARDNOCR"))%>";
var varrefidcr = "<%=Helper.correctNull((String) hshValues.get("REFERENCEIDCR"))%>";
function onload()
{
	
	if(varsegment!="")
	{
		document.forms[0].selsegment.value=varsegment;
	}
	else
	{
		document.forms[0].selsegment.value="0";		
	}
	if(varinwardno!="")
	{
		alert("Loan Application Register successfully created for Reference Id: "+varrefidcr+" with Inward No. :"+varinwardno)
	}
}

function callclose()
{
	if (ConfirmMsg("100"))
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/mainnav.jsp";
		document.forms[0].submit();
	}
}

function callCancel()
{
	document.forms[0].hidsegtype.value=document.forms[0].selsegment.value;
	document.forms[0].action=appUrl+"action/NP_Mailbox.jsp";
	document.forms[0].hidBeanGetMethod.value="getNpMailbox";
	document.forms[0].hidBeanId.value="NationalPortal";
	document.forms[0].submit();
}

function dochange()
{

	document.forms[0].hidsegtype.value=document.forms[0].selsegment.value;
	document.forms[0].action=appUrl+"action/NP_Mailbox.jsp";
	document.forms[0].hidBeanGetMethod.value="getNpMailbox";
	document.forms[0].hidBeanId.value="NationalPortal";
	document.forms[0].submit();
}
function callstatusupd(refid,statval)
{
	var segType="<%=NPSegment%>";
	var status = statval;
	var Refno = refid;
	var statusrecv = confirm('Do you want to '+status+' this application?');
	if(statusrecv)
	{
		
		document.forms[0].hidApplicantId.value = refid;
		document.forms[0].hidRefId.value=Refno;
		document.forms[0].hidaction.value=status;
		document.forms[0].hidBeanId.value="NationalPortal";
		document.forms[0].hidBeanGetMethod.value="getNPStatusUpdate";
		document.forms[0].action=appUrl+"action/NP_Mailbox.jsp";
		document.forms[0].submit();
	}
}

function callApplication(refid,varPopSchemeId)
{

		// var varsegment=document.forms[0].selsegment.value;
		var varsegment = "<%=Helper.correctNull((String) hshValues.get("NPSegment"))%>";
		 	var Refno = refid;
		 	if(varsegment=="EDU"  ){
		 	document.forms[0].hidRefId.value=Refno;
		 	document.forms[0].hidBeanId.value="NationalPortal";
		 	document.forms[0].hidBeanGetMethod.value="getNP_ApplicantDeatis";
		 	document.forms[0].action=appUrl+"action/NP_applicantDetails.jsp";
		 	document.forms[0].submit();
		 	}else if(varsegment == "HL")
		 	{		
		 	document.forms[0].hidRefId.value=Refno;
		 	document.forms[0].hidApplicantId.value = Refno;
		 	document.forms[0].hidBeanId.value="NationalPortal";
		 	document.forms[0].hidBeanGetMethod.value="getPSB59ApplicantListDtls";
		 	document.forms[0].action=appUrl+"action/psb59ApplicantDetails.jsp";
		 	document.forms[0].submit();
		 	}else if(varsegment == "AGRI")
		 		{
		 		document.forms[0].hidRefId.value=Refno;
		 		document.forms[0].hidrefId.value=Refno;
		 		document.forms[0].hidApplicantId.value = Refno;
		 		document.forms[0].hidBeanId.value="NationalPortal";
		 		document.forms[0].hidBeanGetMethod.value="getAGRIPersonalDetails";
		 		document.forms[0].action=appUrl+"action/PSB59PersonalDetails_Agri.jsp";
		 		document.forms[0].submit();
		 		}
		 		else if(varsegment == "BS")
		 		{
		 		document.forms[0].hidRefId.value=Refno;
		 		document.forms[0].hidApplicantId.value = Refno;
		 		document.forms[0].hidpopSchemeId.value = varPopSchemeId;
		 		document.forms[0].hidBeanId.value="NationalPortal";
		 		document.forms[0].hidBeanGetMethod.value="getBusmudrapersdetails";
		 		document.forms[0].action = appURL+"action/PSB59PersonalDetails_Mudra.jsp";
		 		document.forms[0].submit();
		 		}
		 		/*else if(varsegment == "BS" && varPopSchemeId == "SWMS")
		 		{
		 			
		 			document.forms[0].hidRefId.value=Refno;
		 			document.forms[0].hidApplicantId.value = Refno;
		 			document.forms[0].hidpopSchemeId.value = varPopSchemeId;
		 		document.forms[0].hidBeanId.value="NationalPortal";
		 		document.forms[0].hidBeanGetMethod.value="getBusSWMSpersonaldetails";
		 		document.forms[0].action = appURL+"action/PSB59PersonalDetails_SWMS.jsp";
		 		document.forms[0].submit();
		 		}
		 		else if(varsegment == "BS" && varPopSchemeId == "SRMS")
		 		{
		 			
		 		document.forms[0].hidRefId.value=Refno;
		 		document.forms[0].hidApplicantId.value = Refno;
		 		document.forms[0].hidpopSchemeId.value = varPopSchemeId;
		 		document.forms[0].hidBeanId.value="NationalPortal";
		 		document.forms[0].hidBeanGetMethod.value="getPSB59ApplicantListDtls";
		 		document.forms[0].action = appURL+"action/PSB59PersonalDetails_SRMS.jsp";
		 		document.forms[0].submit();
		 		}
		 		else if(varsegment == "BS" && (varPopSchemeId == "STANDUP"||varPopSchemeId == "STD"))
		 		{
		 		document.forms[0].hidRefId.value=Refno;
		 		document.forms[0].hidApplicantId.value = Refno;
		 		document.forms[0].hidpopSchemeId.value = varPopSchemeId;
		 		document.forms[0].hidBeanId.value="NationalPortal";
		 		document.forms[0].hidBeanGetMethod.value="getBusstandindiapersonaldet";
		 		document.forms[0].action = appURL+"action/PSB59PersonalDetails_STANDUP.jsp";
		 		document.forms[0].submit();
		 		}
		 		else if(varsegment == "LHD" ) 
		 		{
		 			
		 		document.forms[0].hidRefId.value=Refno;
		 		document.forms[0].hidpopSchemeId.value = varPopSchemeId;
		 		document.forms[0].hidApplicantId.value = Refno;
		 		document.forms[0].hidBeanId.value="NationalPortal";
		 		document.forms[0].hidBeanGetMethod.value="getNULMPersonalDetails";
		 		document.forms[0].action = appURL+"action/PSB59PersonalDetails.jsp";
		 		document.forms[0].submit();
		 		}*/
}


function callCreateLAR(refid,statval)
{
	var status = statval;
	var Refno = refid;
	var statusrecv = confirm("If you click on Create LAR you can't Hold and Reject ");
	if(statusrecv)
	{
	document.forms[0].hidApplicantId.value = Refno;
	document.forms[0].hidRefId.value=Refno;
	document.forms[0].hidaction.value=status;
	document.forms[0].hidBeanId.value="NationalPortal";
	 if(varsegment == "BS" ) 
	{
	document.forms[0].hidBeanGetMethod.value="getNPBSInwardCreation";			
	}else if(varsegment == "LHD" ) 
	{
	document.forms[0].hidBeanGetMethod.value="getNPALiveliwoodInwardCreation";			
	}else if(varsegment == "AGRI" ) 
	{
	document.forms[0].hidBeanGetMethod.value="getNPAgriInwardCreation";			
	}else{
	document.forms[0].hidBeanGetMethod.value="getNPInwardCreation";	
	} 
	document.forms[0].action=appUrl+"action/NP_Mailbox.jsp";
	document.forms[0].submit();
	}
}


function callCreateApplication(refid,statval,dedupe)
{
	var status = statval;
	var Refno = refid;
	var dedupeck=dedupe;
	if(dedupeck=="N")
	{
		alert("Kindly do the dedupe and then Proceed!!");
		return;
	}
	document.forms[0].hidRefId.value=Refno;
	document.forms[0].hidApplicantId.value = Refno;
	document.forms[0].hidaction.value=status;
	document.forms[0].hidBeanId.value="NationalPortal";
	 if(varsegment == "BS" ) 
	{
	document.forms[0].hidBeanGetMethod.value="getNPCustProfileCreation_BS";	
			
	}else if(varsegment == "LHD" ) 
	{
	document.forms[0].hidBeanGetMethod.value="getNPCustProfileCreation_BS";			
	}else if(varsegment == "AGRI" ) 
	{
	document.forms[0].hidBeanGetMethod.value="getNPAgriCustProfileCreation";			
	}else{
	document.forms[0].hidBeanGetMethod.value="getNPCustProfileCreation";
	}
	document.forms[0].action=appUrl+"action/NP_Mailbox.jsp";
	document.forms[0].submit();
}
function callDedup(val,val1)
{
	var inwardst = val1;
	if(varsegment =! "BS" ) 
	{
	if(inwardst=="O")
	{
		alert("Kindly Submit the LAR and then Proceed!!");
	return;
	}
	}
	var FileName='NP_Dedupe.jsp';
	var prop = "scrollbars=yes,width=1200,height=500,top=25,left=25";
	var url=appURL+"action/"+FileName+"?hidBeanGetMethod=getNPDedupeChk&hidBeanId=NationalPortal&refID="+val+"&varsegment="+varsegment;
	window.open(url,"DEDUPE PAGE",prop);
}

function callupdate(refId,schId,schName)
{
	var varQryString = appURL+"action/psb59Sanction.jsp?hidBeanId=NationalPortal&hidBeanGetMethod=getPSB59SanctionDetails&hidApplicantId="+refId+"&hidschemeId="+schId+"&hidschemeName="+schName;
	var title = "UpdateDetails";
	var prop = "scrollbars=yes,width=850,height=400";
	var xpos = (screen.width - 500) / 2;
	var ypos = (screen.height - 400) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(varQryString,title,prop);
}
function callreject(appStatus,refId,lapStatus)
{
	
	var varQryString=appURL+"action/psb59HoldReject.jsp?hidBeanId=NationalPortal&hidApplicantId="+refId+"&hidBeanGetMethod=PSB59getHoldRejStatus&hidUserId="+document.forms[0].hidUserId.value+"&HidLapsStatus="+lapStatus;
	var title = "RejectStatus";
	var prop = "scrollbars=yes,width=1000,height=800";
	var xpos = (screen.width - 900) / 2;
	var ypos = (screen.height - 700) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(varQryString,title,prop);
}
function showSystem(val,glpsize,rowindex)
{

		var table="";
		var rowCount=0; 
		prop = "scrollbars=yes,width=500,height=355,statusbar=yes";	
		xpos = (screen.width - 700) / 2;
		ypos = (screen.height - 550) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		var levels="0";
		var purl = appURL+"jsp/com/comborrowerselect.jsp?val=66&valsys=67&glpsize=67&rowindex=&rowcount=";
		title="help";
		window.open(purl,title,prop);

}

function doReallocate()
{
	var varFacility_Flag=false;
	var checkbox_len=document.forms[0].chkbox;
	var checkbox_length=checkbox_len.length;

	if(document.forms[0].chkbox.checked==true)
	{
		varFacility_Flag=true;
	}
	for(var k=0;k<checkbox_length;k++)
	{
		if(document.forms[0].chkbox[k].checked==true)
		{
			varFacility_Flag=true;
		}
	}
	if(varFacility_Flag)
	{
		chkAppcount();
		if(document.forms[0].org_code.value!="")
		{
			document.forms[0].hidBeanId.value="NationalPortal";
		    document.forms[0].hidBeanMethod.value="updateNPReallocation";
			document.forms[0].hidBeanGetMethod.value="getNpMailbox";
			document.forms[0].action=appUrl+"controllerservlet";
			document.forms[0].hidSourceUrl.value="/action/NP_Mailbox.jsp";
			document.forms[0].submit();
		}
		else
		{
			alert("Please Select Organisation");
			return;
			
		}
	}
	else
	{
		alert("Please select the particular Application for proceeding Reallocation.");
		return;	
	}
	alert("Reallocated Successfully.");
}
function chkAppcount()
{
	var varRefID="";
	<%
	if(Helper.ArrNullCheck(arrRow))
	{
		if(arrRow.size()>1)
		{
			for(int i=0;i<arrRow.size();i++)
			{%>
				if(document.forms[0].chkbox["<%=i%>"].checked==true)
				{
					<%arrCol=(ArrayList)arrRow.get(i);
					if(arrCol!=null && arrCol.size()>0)
					{%>
					varRefID=varRefID+"<%=Helper.correctNull((String)arrCol.get(0))%>"+"@";
					<%}%>
				}
			<%}
		}
		else if(arrRow.size()==1)
		{%>
			if(document.forms[0].chkbox.checked==true)
			{
				<%arrCol=(ArrayList) arrRow.get(0);
				if(arrCol!=null && arrCol.size()>0)
				{%>
				varRefID=varRefID+"<%=Helper.correctNull((String)arrCol.get(0))%>"+"@";
				<%}%>
			}
		<%}}%>
		varRefID= varRefID.substring(0,varRefID.length-1);
		document.forms[0].hidRefIdnew.value=varRefID;
}
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/NationalPortal.css"
	type="text/css">
</head>
<body onLoad="onload()">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="page_flow">Home -&gt; National Portal Leads -&gt; Group Mailbox </td>
	</tr>
</table>

<form name="national_portal" metdod="post">
<table width="95%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable">
<tr>
	<td colspan="8" align="center">
	<table width="95%" border="0" cellspacing="1" cellpadding="3" align="center">
		<tr>
	<td width="50%" colspan="8" align="center">National Portal Segment &nbsp;&nbsp;&nbsp;&nbsp;
			
			<select name="selsegment" onchange="dochange()">
	    <option value="S">--Select--</option>
	    <option value="EDU">Educational Loan</option>
	    <option value="BS">Business Loan </option>
	    <option value="AGRI">Agricultural Loan</option>
	 <!--    <option value="HL">Housing Loan</option>
	    <option value="LHD">Livelihood Loan</option> -->
	</select>
	</td>	
	</tr>
	</table>
	</td>
	</tr>
	<tr><td colspan="8">&nbsp;</td></tr>
	<tr class="dataheader">		
		<td width="15%" nowrap="nowrap" align="center">Application Reference Id</td>
		<td width="10%" nowrap="nowrap" align="center">Application Code</td>
		<td width="15%" nowrap="nowrap" align="center">Scheme Id</td>
		<td width="10%" nowrap="nowrap" align="center">Scheme Name</td>
		<td width="10%" nowrap="nowrap" align="center">Application Date</td>
		<td width="10%" nowrap="nowrap" align="center">Applicant Name</td>
		<td width="10%" nowrap="nowrap" align="center">Actions</td>
		<td width="15%" nowrap="nowrap" align="center">Received By</td>
		<td width="10%" nowrap="nowrap" align="center">Inward/Application NO</td>
	</tr>
	<%if(arrRow!=null && arrRow.size()>0)
		{ 
			int k=0;
			for(int i=0;i<arrRow.size();i++)
			{
				arrCol=(ArrayList)arrRow.get(i);
				k=k+1;
	%>
	<tr>
	<td width="15%" align="left">
	<%if(strOrglevel.equalsIgnoreCase("C")){
		        if(Helper.correctNull((String)arrCol.get(6)).equalsIgnoreCase("")){ %>
			    <input type="checkbox" name="chkbox" style="border: none;">&nbsp;&nbsp;
			    <%}else{ %>
					<input type="checkbox" name="chkbox" style="border: none;"disabled>&nbsp;&nbsp;
				<%}} %>
		<b><a href="#" onClick="javascript:callApplication('<%=Helper.correctNull((String)arrCol.get(0)) %>','<%=Helper.correctNull((String)arrCol.get(11)) %>')" ><%=Helper.correctNull((String)arrCol.get(0)) %>&nbsp;</a></b></td>
		<td width="10%" align="center"><%=Helper.correctNull((String)arrCol.get(1)) %>&nbsp;</td>
		<td width="15%" align="center"><%=Helper.correctNull((String)arrCol.get(2)) %>&nbsp;</td>
		<td width="15%" align="center"><%=Helper.correctNull((String)arrCol.get(3)) %>&nbsp;</td>
		<td width="10%" align="center"><%=Helper.correctNull((String)arrCol.get(4)) %>&nbsp;</td>
		<td width="10%" align="center"><%=Helper.correctNull((String)arrCol.get(5)) %>&nbsp;</td>
		<%if(!strOrglevel.equalsIgnoreCase("C")){
			if(Helper.correctNull((String)arrCol.get(6)).equalsIgnoreCase("")){ %>
		<td width="10%" align="center"><input type="button"  value="Receive" class="buttonStyle" onClick="javascript:callstatusupd('<%=Helper.correctNull((String)arrCol.get(0))%>','Receive')"/></td>
		<%}else{ %>
			<td width="10%" align="center">-</td>
		<%}} else{%>
		<td width="10%" align="center">-</td>
		<%} %>
		<td width="15%" align="center"><%=Helper.correctNull((String)arrCol.get(6)) %>&nbsp;</td>
		<td width="10%" nowrap="nowrap" align="center"><%=Helper.correctNull((String)arrCol.get(12)) %>&nbsp;</td>
	</tr>
	<%}}else{%>
	<tr>
		<td colspan="8" align="center">&nbsp;-- No Record Found --&nbsp;</td>
	</tr>
	<%} %>
	<tr>
		<td colspan="8" align="Left"><b>Received Applications</b>&nbsp;</td>
	</tr>
	<tr class="dataheader">		
		<td width="15%" nowrap="nowrap" align="center">Application Reference Id</td>
		<td width="10%" nowrap="nowrap" align="center">Application Code</td>
		<td width="15%" nowrap="nowrap" align="center">Scheme Id</td>
		<td width="10%" nowrap="nowrap" align="center">Scheme Name</td>
		<td width="10%" nowrap="nowrap" align="center">Application Date</td>
		<td width="10%" nowrap="nowrap" align="center">Applicant Name</td>
		<td width="15%" nowrap="nowrap" align="center" colspan="3">Actions</td>
		
	</tr>
	<%if(arrRowrcv!=null && arrRowrcv.size()>0)
		{ 
		
			int k=0;
			for(int i=0;i<arrRowrcv.size();i++)
			{
				arrColrcv=(ArrayList)arrRowrcv.get(i);
				k=k+1;
String refid="";
refid=Helper.correctNull((String)arrColrcv.get(0));
				
	%>
	<%if(Helper.correctNull((String)arrColrcv.get(11)).equalsIgnoreCase("")){%>
	<tr>
	
		<td width="15%" align="center"><b><a href="#" onClick="javascript:callApplication('<%=Helper.correctNull((String)arrColrcv.get(0)) %>','<%=Helper.correctNull((String)arrColrcv.get(13)) %>')" ><%=Helper.correctNull((String)arrColrcv.get(0)) %>&nbsp;</a></b></td>
		<td width="10%" align="center"><%=Helper.correctNull((String)arrColrcv.get(1)) %>&nbsp;</td>
		<td width="15%" align="center"><%=Helper.correctNull((String)arrColrcv.get(2)) %>&nbsp;</td>
		<td width="15%" align="center"><%=Helper.correctNull((String)arrColrcv.get(3)) %>&nbsp;</td>
		<td width="10%" align="center"><%=Helper.correctNull((String)arrColrcv.get(4)) %>&nbsp;</td>
		<td width="10%" align="center"><%=Helper.correctNull((String)arrColrcv.get(5)) %>&nbsp;</td>
		<!--<td width="10%" align="center"><%=Helper.correctNull((String)arrColrcv.get(11)) %>&nbsp;</td>
	
	--><%if(Helper.correctNull((String)arrColrcv.get(13)).equalsIgnoreCase("") && Helper.correctNull((String)arrColrcv.get(7)).equalsIgnoreCase("")){%>
	<td width="15%" align="center" colspan="3">
&nbsp;<a href="#" onClick="javascript:callreject('R','<%=Helper.correctNull((String)arrColrcv.get(0))%>',
													 '<%=Helper.correctNull((String)arrColrcv.get(11))%>')">Status</a>&emsp;
													 
 <a href="#" onClick="javascript:callupdate('<%=Helper.correctNull((String)arrColrcv.get(0))%>',
										   '<%=Helper.correctNull((String)arrColrcv.get(2))%>',
										   '<%=Helper.correctNull((String)arrColrcv.get(3))%>')">Update</a>&emsp;
										   
										  <%--  <input type="button" value="Dedupe" class="buttonStyle" 
		onClick="javascript:callDedup('<%=Helper.correctNull((String)arrColrcv.get(0))%>','<%=Helper.correctNull((String)arrColrcv.get(9))%>')">&nbsp;&nbsp;&nbsp; --%>
		
										   
										   <input type="button" value="Create LAR" class="buttonStyle" 
		onClick="callCreateLAR('<%=Helper.correctNull((String)arrColrcv.get(0))%>','CrLAR')">&nbsp;&nbsp;&nbsp;	</td>
		
				<%}	
				
	     else if(Helper.correctNull((String)arrColrcv.get(13)).equalsIgnoreCase("Hold") ){%>
		
		 <td width="15%" align="center" colspan="2"> Hold
			</td>
			<%-- <td width="15%" align="center" colspan="3">
&nbsp;<a href="#" onClick="javascript:callreject('R','<%=Helper.correctNull((String)arrColrcv.get(0))%>',
													 '<%=Helper.correctNull((String)arrColrcv.get(11))%>')">Hold</a>&emsp;
													 </td> --%>
		<%}
	     else if(Helper.correctNull((String)arrColrcv.get(13)).equalsIgnoreCase("Rejection") ){%>
	     
	     <td width="15%" align="center" colspan="2">Rejected </td>
			<%}
	
	 else if(Helper.correctNull((String)arrColrcv.get(13)).equalsIgnoreCase("Sanctioned")|| Helper.correctNull((String)arrColrcv.get(13)).equalsIgnoreCase("Disbursed")){%>
	     
	     <td width="15%" align="center" colspan="2"><a href="#" onClick="javascript:callupdate('<%=Helper.correctNull((String)arrColrcv.get(0))%>',
										   '<%=Helper.correctNull((String)arrColrcv.get(2))%>',
										   '<%=Helper.correctNull((String)arrColrcv.get(3))%>')">Update</a>&emsp; </td>
			<%}%>			    
		
		<%if(Helper.correctNull((String)arrColrcv.get(7)).equalsIgnoreCase("") && Helper.correctNull((String)arrColrcv.get(8)).equalsIgnoreCase("H")){%>
		<td width="15%" align="center" colspan="2">
		
		<!-- <input type="button" value="Create LAR" class="buttonStyle" 
		onClick="callCreateLAR('<%=refid%>','CrLAR')">&nbsp;&nbsp;&nbsp; -->
		
		<!--<input type="button" value="Hold" class="buttonStyle" onClick="callstatusupd('<%=refid%>','Hold')" disabled/>
		&nbsp;&nbsp;&nbsp;
		
		<input type="button" value="Reject" class="buttonStyle" 
		onClick="callstatusupd('<%=refid%>','Reject')"/>&nbsp;&nbsp;&nbsp;</td> -->
		<%}  
		
		
		else if(Helper.correctNull((String)arrColrcv.get(7)).equalsIgnoreCase("") && Helper.correctNull((String)arrColrcv.get(8)).equalsIgnoreCase("R")){%>
		
		<!--<td width="15%" align="center" colspan="2">Rejected</td>
		--><%}
        
		
		else if(Helper.correctNull((String)arrColrcv.get(7)).equalsIgnoreCase("") && Helper.correctNull((String)arrColrcv.get(8)).equalsIgnoreCase("")) {%>
		<%-- <td width="15%" align="center" colspan="2">
		
			<input type="button" value="Create LAR" class="buttonStyle" 
		onClick="callCreateLAR('<%=Helper.correctNull((String)arrColrcv.get(0))%>','CrLAR')">&nbsp;&nbsp;&nbsp;
		
		<input type="button" value="Dedupe" class="buttonStyle" 
		onClick="javascript:callDedup('<%=Helper.correctNull((String)arrColrcv.get(0))%>','<%=Helper.correctNull((String)arrColrcv.get(9))%>')">&nbsp;&nbsp;&nbsp;
		
		  <input type="button" value="Hold" class="buttonStyle" onClick="callstatusupd('<%=refid%>','Hold')"/>
		&nbsp;&nbsp;&nbsp;
		
		<input type="button" value="Reject" class="buttonStyle" 
		onClick="callstatusupd('<%=refid%>','Reject')"/>&nbsp;&nbsp;&nbsp; </td>  --%>
		
<%} 
		
		else if(!Helper.correctNull((String)arrColrcv.get(7)).equalsIgnoreCase("")){%>
		<td width="15%" align="center" colspan="2">
		
		<input type="button" value="Dedupe" class="buttonStyle" 
		onClick="javascript:callDedup('<%=Helper.correctNull((String)arrColrcv.get(0))%>','<%=Helper.correctNull((String)arrColrcv.get(9))%>')">&nbsp;&nbsp;&nbsp;
		
		<input type="button" value="Create Application" class="buttonStyle" 
		 onClick="callCreateApplication('<%=Helper.correctNull((String)arrColrcv.get(0))%>','CrApp','<%=Helper.correctNull((String)arrColrcv.get(10))%>')"/>
		 
		 </td>		
		<%}else{%>
		<%} %>
	</tr>
	<%}}}else{%>
	<tr>
		<td colspan="8" align="center">&nbsp;-- No Record Found --&nbsp;</td>
	</tr>
	<%}%>
	<tr>
		<td colspan="8" >&nbsp;</td>
	</tr>
	<%if(strOrglevel.equalsIgnoreCase("C")){ %>
	<tr>
		<td colspan="8">
				<table width="70%" border="0" cellspacing="0" cellpadding="3" align="center">
					<tr>
						<td width="10%">&nbsp;</td>
						<td width="20%" align="center">Select Organisation</td>
						<td width="25%" align="left"><input type="text" name="org_name" size="35" readonly value=""></td>
						<td width="5%" id="org" align="left">
									<a href="#" onClick="javascript:showSystem('66','66',this.id)"> 
									<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0"> </a></td>
						<td width="40%" align="left"><input type="button" value="Reallocate" name="cmdReceive" onclick="doReallocate()" class="buttonStyle">&nbsp;</td>				
					</tr>
				</table>
		</td>
	</tr>
	<%} %>
	
	</table>
<table border="0" cellspacing="0" cellpadding="0" align="center">
	<tr valign="middle">
		<td><input type="button" name="cmdclose" value="Close" class="buttonClose" onClick="callclose();"></td>
	</tr>
</table>

<input type="hidden" name="hidRefId" value="">
<input type="hidden" name="hidrefId" value="">
<input type="hidden" name="hidApplicantId" value="">
<input type="hidden" name="hidaction" value="">
<input type="hidden" name="hidBeanGetMethod" value="">
<input type="hidden" name="hidBeanId" value=""> 
<input type="hidden" name="hidBeanMethod" value=""> 
<input type="hidden" name="hidSourceUrl" value="">
<input type="hidden" name="SchemeName" value="<%=producttype%>">
<input type="hidden" name="hidloanapptype" value="P">
<input type="hidden" name="hidschemeId" value="">
<input type="hidden" name="hidpopSchemeId" value="">
<input type="hidden" name="hidschemeName" value="">
<input type="hidden" name="hidUserId" value="">
<input type="hidden" name="hidlapstatus" value="">
<input type="hidden" name="hidAppStatus" value="">
<input type="hidden" name="hidsegtype" value="">
<input type="hidden" name="org_code" value="">
<input type="hidden" name="hidRefIdnew" value="" id="hidRefIdnew">

</form>
</body>
</html>
