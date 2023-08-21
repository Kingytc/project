<%@include file="../share/directives.jsp"%>
<%
	String strSector = Helper.correctNull((String) request.getParameter("hidsector"));
	String strappliedfor = Helper.correctNull((String) request.getParameter("appliedfor"));
	String strSaral = Helper.correctNull((String) request.getParameter("hidsaral"));
	String strProposal=Helper.correctNull((String)request.getParameter("hidproposal"));
	String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
    //Added by Zahoorunnisa.S for button functionality
    String strapplevel = Helper.correctNull((String)request.getParameter("applevel"));
    
	String strstatus = Helper.correctNull((String) request.getParameter("hidstatus"));
	if (strstatus.equals(""))
		strstatus = Helper.correctNull((String) hshValues.get("status"));
	//end
	%>
<html>
<head>
<title>Proposal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var seltype="<%=Helper.correctNull((String)hshValues.get("seltype"))%>";
var varOrgLevel="<%=strOrgLevel%>";
var varright= "<%=Helper.correctNull((String) session.getAttribute("strGroupRights")).charAt(18)%>";
function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,name);
	}
}

function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;
}

function calGetData()
{
	if(document.forms[0].sel_audittype.value=="0")
	{
		document.forms[0].txt_auditorsobservations.value="";
		document.forms[0].txt_branchcomments.value="";
		return;
	}
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidBeanGetMethod.value="getAuditorComments";
	document.forms[0].action=appURL+"action/com_auditobserv.jsp";
    document.forms[0].submit();
}

function show_details()
{
	if(seltype=="0")
		document.forms[0].sel_audittype.selectedIndex=0;
	else
		document.forms[0].sel_audittype.selectedIndex=seltype;
}

function placevalues()
{
	show_details();
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="textarea")
		{
		  document.forms[0].elements[i].readOnly=true;
		}
	}
	if((document.forms[0].sel_audittype.value=="0")||(document.forms[0].sel_audittype.value==""))
	{
		document.forms[0].sel_audittype.selectedIndex=0;
		document.forms[0].txt_auditorsobservations.value="";
		document.forms[0].txt_branchcomments.value="";
	}
	else
	{
		document.forms[0].sel_audittype.value=seltype;
	}
}

function doCancel()
{
	if (ConfirmMsg(102))
	{
		document.forms[0].hidBeanGetMethod.value="getAuditorComments";
		document.forms[0].hidBeanId.value="comproposal";
		document.forms[0].action=appURL+"action/com_auditobserv.jsp";
		document.forms[0].submit();
	}
}

function doClose()
{
   	if(ConfirmMsg(100))
 	{
		document.forms[0].action=appURL+"action/corppge.jsp";
		document.forms[0].submit();
 	}
}

function doEdit()
{
	if((document.forms[0].sel_audittype.selectedIndex == 0) ||(document.forms[0].sel_audittype.value== ""))
	{
		alert("Select the Audit type");
		document.forms[0].txt_auditorsobservations.value="";
		document.forms[0].txt_branchcomments.value="";
		document.forms[0].sel_audittype.focus();
		return;
	}
	else
	{
		document.forms[0].sel_audittype.disabled=false;
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=false;
			}
		}
	}
	document.forms[0].hidAction.value="update";
	document.forms[0].hideditflag.value="Y";
	enableButtons(true,true,false,false,false,true);
	
}

function doNew()
{
	if((document.forms[0].sel_audittype.selectedIndex == 0) ||(document.forms[0].sel_audittype.value== ""))
	{
		alert("Select the Audit type");
		document.forms[0].sel_audittype.focus();
		return;
	}
	else
	{
		document.forms[0].hidAction.value="insert";
		document.forms[0].txt_auditorsobservations.value="";
		document.forms[0].txt_branchcomments.value="";
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=false;
			}
		}
		enableButtons(true,true,false,false,true,true);
		document.forms[0].hideditflag.value="Y";
	}
}

function doSave()
{	
	if(document.forms[0].auditdate.value=="")
	{
		ShowAlert('121','Audit Date');
		document.forms[0].auditdate.focus();
		return;
	}
	if(document.forms[0].txt_auditorsobservations.value=="")
	{
		ShowAlert('121','Auditors Observations');
		document.forms[0].txt_auditorsobservations.focus();
		return;
	}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidBeanMethod.value="updateAuditorObser";
	document.forms[0].hidBeanGetMethod.value="getAuditorComments";
	document.forms[0].hidSourceUrl.value="/action/com_auditobserv.jsp"
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doDelete()
{	
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanId.value="comproposal";
		document.forms[0].hidBeanMethod.value="updateAuditorObser";
		document.forms[0].hidBeanGetMethod.value="getAuditorComments";
		document.forms[0].hidSourceUrl.value="/action/com_auditobserv.jsp"
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}

function onloading()
{
	//Added By Zahoorunnisa.S for Button Functionality after discussion with Suresh
	 	
	//If access through the Loan Application Register and its at Branch 
	if("<%=strSaral%>"=="saral" && "<%=strOrgLevel%>"=="A"){ 
		//If the Application is in open status
		if("<%=strstatus%>"=="O" && varright=="w"){
		    enableButtons(false,true,true,true,false,false);
		}else{
			enableButtons(true,true,true,true,true,true);	
		}
			
	}else if("<%=strSaral%>"=="saral" && "<%=strapplevel%>" == ""){ 
		
		enableButtons(true,true,true,true,true,true);
			
    }else{
		
		if("<%=strapplevel%>" == "S"){
			<%if(!strCategoryType.equalsIgnoreCase("OPS"))
			{
				%>
			enableButtons(true,true,true,true,true,true);
		<%	}
			else
			{%>
				  enableButtons(false,true,true,true,true,true);
		<%	}%>
		}else{
			if(document.forms[0].btnenable.value=="Y"){
				enableButtons(false,true,true,true,true,false);
				
			}else {
				
				enableButtons(true,true,true,true,true,false);
			}
		}
	}

  
	
	//End

}
function selectvalues(val1, val2)
{
	document.forms[0].hidsno.value=val1;
	document.forms[0].txt_auditorsobservations.value=document.getElementById("hidauditcomments"+val2).value;
	document.forms[0].txt_branchcomments.value=document.getElementById("hidbranchreplies"+val2).value;


	//Added By Zahoorunnisa.S for Button Functionality after discussion with Suresh
	
	//If access through the Loan Application Register and its at Branch 
	if("<%=strSaral%>"=="saral" && "<%=strOrgLevel%>"=="A"){ 
		//If the Application is in open status
		if("<%=strstatus%>"=="O" && varright=="w"){
		    enableButtons(true,false,true,true,false,true);
		}else{
			enableButtons(true,true,true,true,true,true);	
		}
			
	}else{
		
		if("<%=strapplevel%>" == "S"){
			<%if(!strCategoryType.equalsIgnoreCase("OPS"))
			{
				%>
			enableButtons(true,true,true,true,true,true);
		<%	}
			else
			{%>
			enableButtons(true,false,true,true,true,false);
		<%	}%>
		}
		else if(document.forms[0].btnenable.value=="Y")
		{
			enableButtons(true,false,true,true,true,false);
		}
		else
		{
			enableButtons(true,true,true,true,true,true);
		}
	}

    
	//End

  }
</script>
</head>

<body onload="placevalues();onloading()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div></div>
<form name="frmpri" method ="post" class="normal">
<%
if (strSaral.equalsIgnoreCase("saral")) {
%> 
<lapschoice:saralreportTag tabid="10" sector='<%=strSector%>' applied='<%=strappliedfor%>'  proposal='<%=strProposal%>'/> 
<lapschoice:inward/>
<%
}else if(strSessionModuleType.equals("AGR")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
        <tr> 
				<td valign="top"> 
					<jsp:include page="../com/proposallinks.jsp" flush="true"> 
						<jsp:param name="pageid" value="3" /> 
						<jsp:param name="cattype" value="<%=strCategoryType%>" /> 
						<jsp:param name="ssitype" value="<%=strSSIType%>" /> 
					</jsp:include> 
				</td>
			</tr> 
	    <tr> 
        <td class="page_flow">
			Home &nbsp; -&gt; &nbsp; Agriculture &nbsp; -&gt; &nbsp; Application &nbsp; -&gt; &nbsp; Audit Observation
	   </td>
</tr> </table>
<%}
else if(strCategoryType.equalsIgnoreCase("CORP") || strCategoryType.equalsIgnoreCase("SME") ){ %>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"  class="outertable"> 
			<tr> 
				<td valign="top" colSpan="5"> 
					<jsp:include page="../com/proposallinks.jsp" flush="true"> 
						<jsp:param name="pageid" value="3" /> 
						<jsp:param name="cattype" value="<%=strCategoryType%>" /> 
						<jsp:param name="ssitype" value="<%=strSSIType%>" /> 
					</jsp:include> 
				</td>
			</tr> 
			<tr>
				<td class="page_flow">
					Home&nbsp;-&gt;&nbsp;Corporate&nbsp;&amp; SME -&gt;Proposal&nbsp;-&gt;&nbsp;Audit Observation
				</td>
			</tr>
		</table>
		<%}
 else if (strCategoryType.equalsIgnoreCase("SRE") || strCategoryType.equalsIgnoreCase("OPS") || strCategoryType.equals("STL")){ %>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	    <tr> 
	      <td valign="top"> 
	        <jsp:include page="../share/applurllinkscom.jsp" flush="true">         
	        <jsp:param name="pageid" value="14" />
	        <jsp:param name="cattype" value="<%=strCategoryType%>" />
	        <jsp:param name="ssitype" value="<%=strSSIType%>" />
	        </jsp:include>
	      </td>
	    </tr>
	     <%if(strCategoryType.equalsIgnoreCase("SRE")){ %>
	    <tr>
		<td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Short Review/Extension  -&gt; Audit Observations </td>
	</tr><%}
	else if(strCategoryType.equals("STL")) {%>
	<tr>
	       <td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Short Term Loan -&gt; Saral -&gt; Audit Observation
		 </td></tr>
		 
	<%} else{%>
		 <tr>
		<td class="page_flow">
					Home &nbsp; -&gt; &nbsp; Tertiary &nbsp; -&gt; &nbsp; Application &nbsp; -&gt; &nbsp; Audit Observation
				</td>
	</tr>
	<%} %>
  </table>
  <% }%>
 <span style="display:none;"><lapschoice:borrowertype /></span> 
  		<% if ( !(strSaral.equalsIgnoreCase("saral"))){ %>
		<lapschoice:application/> 
		<%}else{ %>
		<lapschoice:saralappinwardtag tabid="11" sector='<%=strCategoryType%>'	applied='<%=strappliedfor%>'/>
		<%} %>
	<table width="100%" border="0" cellspacing="0" cellpadding="3"
	align="center" class="outertable">
	<tr>
		<td valign="top" align="left">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="5"
					height="100%" class="outertable border1">
					<tr>
						<td valign="top">

						<TABLE WIDTH="77%" BORDER="0" CELLSPACING="1" CELLPADDING="3"
							ALIGN="center" class="outertable">
							<tr>
								<td>Type </td>
								<td><SELECT NAME="sel_audittype" tabindex="3"
									onChange="calGetData()">
									<option value="0" selected="selected">----Select----</option>
									<option value="1">Internal Audit</option>
									<option value="2">Concurrent Audit</option>
									<option value="3">RBI Inspection</option>
									<option value="4">Statutory Audit</option>
									<option value="5">Stock Audit</option>
								</SELECT></td>
								<td width="20%">&nbsp;</td>
								<td>Date of Audit</td>
								<td><input type="text" name="auditdate" size="12" tabindex="2"
									maxlength="10"
									value="<%=Helper.correctNull((String)hshValues.get("auditdate"))%>"
									onBlur="checkDate(this);" readOnly="readonly"> <a
									alt="Select date from calender"
									href="javascript:callCalender('auditdate')"><img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
									width="21" height="18" border="0"></a></td>
							</tr>
							<tr class="dataheader" align="center">
								<td colspan="2">Auditors Comments</td>
								<td width="20%">&nbsp;</td>
								<td colspan="2">Officers Comments</td>
							</tr>
							<tr>
								<td colspan="2"><textarea
									NAME="txt_auditorsobservations" COLS="75" ROWS="10"
									WRAP="VIRTUAL"
									onKeyPress="textlimit(document.forms[0].txt_auditorsobservations,3999)" onKeyUp="textlimit(this,3999)"></textarea>
								</td>
								<td width="20%">&nbsp;</td>
								<td colspan="2"><textarea NAME="txt_branchcomments"
									COLS="75" ROWS="10" WRAP="VIRTUAL"
									onKeyPress="textlimit(document.forms[0].txt_branchcomments,3999)" onKeyUp="textlimit(this,3999)"></textarea>
								</td>
							</tr>
							<%if( strCategoryType.equalsIgnoreCase("OPS")){ %>
							<tr>
								<td colsapn="2">Replies/ Action Taken/ Present Position</td>
								<td colspan="3">&nbsp;</td>
							</tr>
							<tr>
								<td colspan="2"><textarea NAME="txt_replies"
									COLS="75" ROWS="10" WRAP="VIRTUAL"
									onKeyPress="textlimit(document.forms[0].txt_replies,3999)" onKeyUp="textlimit(this,3999)"></textarea>
								</td>
								
							</tr>
							<%} %>
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
<br>
 <lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
 <br>
 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable" >
									<tr>
										<td>
<table width="100%" border="0" cellspacing="1" cellpadding="1">
<tr class="dataheader" align="center">
	<td width="2%">&nbsp;</td>
	<td width="49%">Auditors Comments</td>
	<td width="49%">Officers Comments</td>
</tr>
 <tr>
					  <td colspan="3"><%ArrayList arrRow=new ArrayList();
						arrRow=(ArrayList)hshValues.get("arrRow");
						if(arrRow!=null ){
						if(arrRow.size()>6){ %><div class="cellContainer"><%}} %>
                      <table width="100%" border="0" cellspacing="1" cellpadding="1">
<%
	
	if(arrRow!=null && arrRow.size()>0)
	{
		for(int i=0;i<arrRow.size();i++)
		{
			ArrayList arrCol=new ArrayList();
			arrCol=(ArrayList)arrRow.get(i);
%>	
<tr class="datagrid">
	<td>
		<input type="radio" style="border:none" name="radiobutton" value="radiobutton"
		onclick="selectvalues('<%=Helper.correctNull((String)arrCol.get(3))%>',<%=i%>)">
		<input type="hidden" name="hidauditcomments<%=i%>" value="<%=Helper.correctNull((String)arrCol.get(0))%>">
		<input type="hidden" name="hidbranchreplies<%=i%>" value="<%=Helper.correctNull((String)arrCol.get(1))%>">
		<input type="hidden" name="hidactiontaken<%=i%>" value="<%=Helper.correctNull((String)arrCol.get(2))%>">
	</td>
	<td width="49%"><%=Helper.correctNull((String)arrCol.get(0))%></td>
	<td width="49%"><%=Helper.correctNull((String)arrCol.get(1))%></td>
</tr>	
<%
		}
	}
%>	</table><%if(arrRow!=null ){
if(arrRow.size()>6){ %></div><%}} %>
</td></tr>
</table>
</td></tr>
</table>
<input type="hidden" name="hidsno" value="">
	 <lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>

