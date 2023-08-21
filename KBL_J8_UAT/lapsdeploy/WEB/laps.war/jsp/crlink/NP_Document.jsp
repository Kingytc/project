<%@include file="../share/directives.jsp"%>      
<lapschoice:handleerror />
<%
session.setAttribute("CURRENT_TAB","DOC_DETAILS");
ArrayList arrRow = (ArrayList)hshValues.get("arrRow"); 
ArrayList arrCol=new ArrayList();
%>

<html>
<head>
<title>National Portal - Documents</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/NationalPortal.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
	
	<script>

	
	
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function callclose()
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/mainnav.jsp";
	document.forms[0].submit();
}

function callOnLoad()
{

}
function SelectValues(sno,docType)
{
	 var refid = document.forms[0].hidApplicantId.value;
	var appUrl="<%=ApplicationParams.getAppUrl()%>";
	var url = appURL+"action/ifrmnsdllViewDocument.jsp?hidBeanId=NationalPortal&hidBeanGetMethod=NP_viewAttachedDocument&strRefId="+refid+"&hidSno="+sno;
	var title = "Documents";
	var prop = "scrollbars=yes,width=750,height=550,menubar=yes";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
}
function gotoTab( beanid,getmethod, page)
{

		document.forms[0].hidBeanId.value=beanid;		
		document.forms[0].hidBeanGetMethod.value=getmethod;
		document.forms[0].action=appURL+"action/"+page;	
		document.forms[0].submit();

}
function SelectValuesview(sno,docType)
{
	 var refid = document.forms[0].hidApplicantId.value;
	var appUrl="<%=ApplicationParams.getAppUrl()%>";
	var url = appURL+"action/ifrmnsdllViewDocument.jsp?hidBeanId=NationalPortal&hidBeanGetMethod=Nationalportaldocdownload&hidAction=DownloadExcelNP&strRefId="+refid+"&hidSno="+sno+"&download=Y";
	var title = "Documents";
	var prop = "scrollbars=yes,width=750,height=550,menubar=yes";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<style>
.mailbox_container
{
	width: 100%;
	height: 350px;
	overflow: auto;
}
</style>

</head>
<body onload="callOnLoad()">
<form name="docVerForm" method="post" action="" class="normal">
<table width="85%" border="0" cellspacing="1" cellpadding="3" class="outertable">
	<tr>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getNP_ApplicantDeatis','NP_applicantDetails.jsp')" onMouseOut="window.status='';return true;" >Applicant's Details</a></b></td>		
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getNP_CoApplicantDeatils','NP_coapplicantDetails.jsp')" onMouseOut="window.status='';return true;" >Co-Applicant's Details</a></b></td>		
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getNP_Education','NP_Education.jsp')" onMouseOut="window.status='';return true;" >Education Details</a></b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getNP_CourseDetails','NP_CourseDeatils.jsp')" onMouseOut="window.status='';return true;" >Course Details</a></b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getFinancialITRDetails','NP_Financial.jsp')" onMouseOut="window.status='';return true;" >Financial & ITR Details</a></b></td>
		<td class="sub_tab_active" align="center"><b>Documents</b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getBREmatch','NP_Brematch.jsp')" onMouseOut="window.status='';return true;" >BRE Match</a></b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getNP_EligibilityDeatils','NP_EligibilityDeatils.jsp')" onMouseOut="window.status='';return true;" >Eligibility Details</a></b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('NationalPortal','getInprincipleDetails','NP_Inprincipaldet.jsp')" onMouseOut="window.status='';return true;" >Inprinciple Details</a></b></td>		
		</tr>
</table> 
<table width="98%" border="0" cellpadding="3" cellspacing="0" bordercolorlight="#cccccc" bordercolordark="#FFFFFB" class="shadow" align="center">
<tr><td>     
<table width="100%" cellspacing="0" cellpadding="3" align="center" class="shadow">        
<tr class="dataheader" align="center">
	<td >
	<font size="2"><b>DOCUMENT DETAILS</b></font></td></tr>
	<tr></tr>
	<tr>
	<td>
	<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
		<tr class="dataheader">
		    <td width="10%"   align="center"> Document List</td>
			<td width="10%"   align="center"> Document Type</td>
        <td width="10%" nowrap="nowrap"  align="center"> Type</td>
			<!-- <td width="10%" nowrap="nowrap"  align="center"> Document View</td> -->
			<td width="10%" nowrap="nowrap"  align="center"> Download Document </td>
	  </tr>
	 <% if(arrRow != null && arrRow.size() > 0){
       for(int i = 0; i < arrRow.size(); i++){
			arrCol = (ArrayList) arrRow.get(i);
			if (arrCol != null && arrCol.size() > 0) {
				String extension = Helper.correctNull((String)arrCol.get(3));
			%>
		<tr height="30px">
		    <td align="center"><%=Helper.correctNull((String)arrCol.get(0)) %></td>
			<td align="center"><%=Helper.correctNull((String)arrCol.get(2)) %></td>
			<td align="center"><%=Helper.correctNull((String)arrCol.get(3)) %></td>
			<%if(extension.equalsIgnoreCase("pfd")) { %>
			<td align="center" width="4%"><img src="<%=ApplicationParams.getAppUrl()%>/img/printer.png" alt="Save" name="img_save" onClick="SelectValues('<%=Helper.correctNull((String)arrCol.get(0))%>','<%=Helper.correctNull((String)arrCol.get(2))%>')">
					      </td><%}else{ %>
		 <td align="center" width="4%"><img src="<%=ApplicationParams.getAppUrl()%>/img/printer.png" alt="Save" name="img_save" onClick="SelectValuesview('<%=Helper.correctNull((String)arrCol.get(0))%>','<%=Helper.correctNull((String)arrCol.get(2))%>')">
					      </td>
					      
		</tr>
		<%}}}%>
			<%}else{ %>
			<tr  height="50px">
				<td colspan="10" align="center">-- No Record Found --&nbsp;</td>
			</tr>
			<%} %>
	</table>
	</td>
	</tr>
</table>
</td></tr>
</table>
  <lapschoice:hiddentag pageid="<%=PageId%>"/>
<input type="hidden" name="hidUserId" value="">
<table border="0" cellspacing="0" cellpadding="0"  align="center">
      <tr valign="middle"> 
       <td> 
		<input type="button" name="cmdclose" value="Close" class="buttonClose" onClick="callclose();">
	
        <input type="hidden" name="hidApplicantId" value="<%=Helper.correctNull((String)hshValues.get("hidApplicantId")) %>">    
        </td></tr></table>
</table>
</form>
</body>
</html>