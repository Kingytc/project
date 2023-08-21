<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />

<%


String strEmployment=(String)session.getAttribute("strEmployment");
String strProfilestatus = Helper.correctNull((String) hshValues.get("strProfilestatus"));
String strPageName=Helper.correctNull((String)hshValues.get("strIncompletepage"));

String strParticulars[]={"Savings from Members","Seed Money from SHPI/NGO/VA, if any","Borrowing Outstanding","Loans Outstanding Against Members",
		"Amount in Default if any Against Members","Recovery Percentage","Cash/Bank Balance"};
String strhidfield[]={"SFM","SMFS","BOSS","LOAM","AIDA","RPER","CABB"};

String pageid = request.getParameter("pageid");
String strapptype = Helper.correctNull((String)request.getParameter("corp"));
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();

%>	
	
<html>
<head>
<title>Financial particulars  </title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var appstatus ="<%=Helper.correctNull((String) hshValues.get("appstatus"))%>";

function disableEditButtons(bool1, bool2, bool3, bool4,  bool6)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool6;
}

function disabledFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	   
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].disabled=!val;
		}	
	}
	
}

function doSave()
{  
	
	//document.forms[0].hidRecordflag.value = varRecordFlag;
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidAction.value="update";
	document.forms[0].hidBeanId.value="commappmaster";
	document.forms[0].hidBeanMethod.value="updateComfinancialparticularsdata";
	document.forms[0].hidBeanGetMethod.value="getComfinancialparticularsdata";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/com_Financialparticulars.jsp";
	document.forms[0].submit();

}


function doEdit()
{
	
	disabledFields(false);
	disableEditButtons(true, false, false, false, false);
		
}

function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidBeanGetMethod.value="getComfinancialparticularsdata";
		document.forms[0].hidBeanId.value="commappmaster";
		document.forms[0].action=appUrl+"action/com_Financialparticulars.jsp";
		document.forms[0].submit(); 		
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanId.value="commappmaster";
		document.forms[0].hidSourceUrl.value="action/com_Financialparticulars.jsp";	
		document.forms[0].hidBeanMethod.value="updateComfinancialparticularsdata";
		document.forms[0].hidBeanGetMethod.value="getComfinancialparticularsdata";
		document.forms[0].submit();	
			
	}
}	


function onloading()
{
	disabledFields(true);
	if(appstatus=="true")
  	{
		disableEditButtons(true, true, true, true,false);
  	}
  	else
  	{
  		disableEditButtons(false, true, true, true,false);
  	}
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
<form name="Financial" method="post" class="normal">

<%if(Helper.correctNull((String)session.getAttribute("sessionModuleType")).equals("")) { %>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	
	<tr>
		<td class="page_flow">Home -&gt; Customer Profile -&gt; Financial particulars </td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		 <table width="98%" border="0" cellspacing="1" cellpadding="3" align="left" class="outertable">
			
			<tr>
				<td><jsp:include page="../share/Cusurllink.jsp" flush="true">
					<jsp:param name="pageid" value="12"/>
					<jsp:param name="employmenttype" value="<%=strEmployment%>" />
					<jsp:param name="strProfilestatus" value="<%=strProfilestatus%>" />
					<jsp:param name="hidincompletedpagename" value="<%=strPageName%>" />
					</jsp:include>
				</td>
			</tr>
		 </table>
		</td>
	</tr>
</table>

<% } else {  %>

<%
if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ 
if(!strSessionModuleType.equalsIgnoreCase("RET")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="subpageid" value="115" />
			<jsp:param name="subsubpageid" value="12" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<% }else{%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="2" />
			<jsp:param name="subsubpageid" value="12"/>
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%} %>
<jsp:include page="../share/Cusurllinkdisp.jsp" flush="true">
			<jsp:param name="pageid" value=""/>
			<jsp:param name="subsubpageid" value="12"/>
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="demoid" value="<%=strapptype%>" />
		</jsp:include>
<%}else{ %>
<%if(strapptype.equalsIgnoreCase("C")){ %>
 <table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="cattype" value="CORP" />
			<jsp:param name="ssitype" value="" />
			<jsp:param name="applevel" value="A" />
		</jsp:include>
		</td>
	</tr>
</table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Application -&gt; Applicant -&gt; Customer Profile -&gt; SHG </td>
	</tr>
  </table>
  <%} else if(strapptype.equalsIgnoreCase("R")){ %>
 <jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="<%=pageid%>" />
        </jsp:include>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center"  class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt; 
       Retail -&gt; Application -&gt; Applicant/Guarantor -&gt; SHG </td>
    </tr>
  </table> 
  <%} %>
<lapschoice:application />
	
 <table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="98%" border="0" cellspacing="1" cellpadding="3"
			align="left" class="outertable">
	<%if(strapptype.equalsIgnoreCase("C")){ %>
		<tr>
		<lapstab:ComfacilityTab tabid="2" />
		</tr>
		<%}%>
		<%if(strapptype.equalsIgnoreCase("C") || strapptype.equalsIgnoreCase("R")){ %>
			<tr>
		<td><jsp:include page="../share/Cusurllinkdisp.jsp" flush="true">
			<jsp:param name="pageid" value="12"/>
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="demoid" value="<%=strapptype%>" />
		</jsp:include></td>
			</tr>
			<%} %>
		</table>
		</td>
	</tr>
</table>
<%} %>

<% } %>

<table width="50%" border="0" cellspacing="1" cellpadding="3" class="outertable">
	<tr>
		<td>
		<table width="40%" border="0" cellspacing="1" cellpadding="3"
			align="left" class="outertable">
			<tr>
		<td class="sub_tab_inactive" nowrap align="center"><a href="#" onclick="callShg()"
							onMouseOut="window.status='';return true;" onMouseOver="window.status='SHG Details';return true;"> SHG Group info.</a></td>
		 <td class="sub_tab_inactive" nowrap align="center"><a href="#" onclick="callMembers()"
					onMouseOut="window.status='';return true;" onMouseOver="window.status='Members Details';return true;"> Members Detail</a>
           </td>
         <td class="sub_tab_active" nowrap align="center">Financial Particulars</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<table width="50%" border="0" cellspacing="0" cellpadding="5" class="outertable border1" align="center">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable" align="center">
				<tr class="dataheader" align="center">
					<td>Sl No.</td>
					<td>Particulars</td>  
					<td>Amount (Rs)</td>	
			    </tr>
			    <%
			    int count=strParticulars.length;
			    if(hshValues!=null)
			    {
			    for(int i=0;i<count;i++)
			    {
			  %>
			    <tr>
			         <td><%=i+1%></td>
			         <td><%=strParticulars[i]%></td>
			          <td><input type="hidden" name="hidfield" value="<%=strhidfield[i]%>">
			          <input type="text" name="txt_particular" size="20" maxlength="15" onKeyPress="allowDecimals(this);" onBlur="roundtxt(this);" style="text-align: right"
			          value="<%=Helper.checkDecimal(Helper.correctDouble((String) hshValues.get("amount"+strhidfield[i])))%>"></td>
			    </tr>
			  <%}} else{ 
			       for(int i=0;i<count;i++)
			    {
			     %>
			    <tr>
			         <td><%=i+1%></td>
			         <td><%=strParticulars[i]%></td>
			          <td><input type="hidden" name="hidfield" value="<%=strhidfield[i]%>">
			          <input type="text" name="txt_particular" size="20" maxlength="15"  onKeyPress="allowDecimals(this)" onBlur="roundtxt(this);" style="text-align: right"></td>
			    </tr>
			    <%}} %>
			  </table>
		</td>
      </tr>
   </table>
			   <br>
			  <table width="50%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
				<tr>
					<td>			  	
		 	<%if(Helper.correctNull((String)session.getAttribute("sessionModuleType")).equals("")) { %>	
					 <lapschoice:combuttonnew btnnames='Edit _Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
			<% }  else { %>
				<span style="display: none; "><div >
					 <lapschoice:combuttonnew btnnames='Edit _Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
				</div> </span>
					<lapschoice:combuttonnew  btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
	    	<% } %>	
				
					
					  </td>
			    </tr>
			 </table>
				
				
				<br>
<lapschoice:hiddentag pageid='<%=PageId%>'/> 


<input type="hidden" name="hidDemoId" value="<%=Helper.correctNull((String)request.getParameter("hidDemoId"))%>"> 
<input type="hidden" name="txtperapp_appid" value="<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>">
<input type="hidden" name="hidappstatus" value="<%=Helper.correctNull((String)hshValues.get("appstatus"))%>">
</form>
</body>
</html>


