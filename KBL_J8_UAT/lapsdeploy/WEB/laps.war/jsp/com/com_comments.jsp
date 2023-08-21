<%@include file="../share/CKEditor.jsp"%>
<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />
<jsp:useBean id="strUserClass" class="java.lang.String" scope="session" />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
response.addHeader("P3P","CP=\"IDC DSP COR ADM DEVi TAIi PSA PSD IVAi IVDi CONi HIS OUR IND CNT\"");
response.addHeader("X-UA-Compatible","IE=EmulateIE8");

	java.text.NumberFormat nf = java.text.NumberFormat
			.getNumberInstance();
	nf.setGroupingUsed(false);
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);

	String strSSIType = Helper.correctNull((String) request
			.getParameter("hidSSIType"));
	String strCategoryType = Helper.correctNull((String) request
			.getParameter("hidCategoryType"));
	String strIndustryType = Helper.correctNull((String) session
			.getAttribute("IndustryType"));
	String strpagetype = Helper.correctNull((String) hshValues
			.get("pagetype"));
	if(strpagetype.equalsIgnoreCase(""))
		strpagetype = Helper.correctNull((String) request
				.getParameter("pagetype"));
	
	String strUsrClass = Helper.correctNull((String) strUserClass);
	if (strUsrClass.trim().equals("")) {
		strUsrClass = "0";
	}

%>
<html>
<head>
<title>Comments</title>
<!-- WYSWYG TEXTAREA -->
<script src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js">
</script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>ckeditor/ckeditor.js"></script>

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String) request
							.getParameter("appstatus"))%>";
var com_conduct="<%=Helper.correctNull((String) hshValues
									.get("com_conduct"))%>";
var varpage="<%=Helper.correctNull((String) hshValues.get("pagetype"))%>";
var Applicationfreeze_status="<%=Helper.correctNull((String) hshValues
							.get("Applicationfreeze_status"))%>";
var undoclassValue="<%=Helper.correctNull((String) hshValues
							.get("undoclassValue"))%>";
var updateclassValue="<%=Helper.correctNull((String) hshValues
							.get("updateclassValue"))%>";
var userclass=<%=strUsrClass%>;
var DescSno="<%=Helper.correctNull((String) hshValues.get("strDescSno"))%>";
var appno="<%=Helper.correctNull((String) hshValues.get("appno"))%>";
var btnenable="<%=Helper.correctNull((String) request.getParameter("btnenable"))%>";
function placevalues()
{
	disableFields(true);
	if(appstatus=="Open/Pending")
	{
		if(btnenable.toUpperCase()=="Y")
		{
			disableCommandButtons("load");
		}
		else
		{
			disableCommandButtons("disableall");
		}
		
	}
	
	else if(appstatus=="Processed/Rejected" || appstatus=="Processed/Approved" || appstatus=="Closed/Approved" || appstatus=="Closed/Rejected")	 
	{
	 		disableCommandButtons("disableall");
	 		disableFields(true);
	}
	if(Applicationfreeze_status != "")
	{
	if(Applicationfreeze_status == "Y")
	{
	 disableCommandButtons("freeze");
	}
	else if(Applicationfreeze_status == "N")
	{
	  disableCommandButtons("undo");
	}
	}
	if (varpage == "cop_mof")
	{
		if(DescSno!="")	
			document.forms[0].sel_description.value=DescSno;
		else
			document.forms[0].sel_description.value='s';
	}
			EditorEnableDisable("id_div","block","id_editor","none");
	<%if(!strpagetype.equalsIgnoreCase("compromoters")&&!strpagetype.equalsIgnoreCase("audit_significance")&&!strpagetype.equalsIgnoreCase("cop_mof")&&!strpagetype.equalsIgnoreCase("tleligibility")&&!strpagetype.equalsIgnoreCase("repaymentschedule")&&!strpagetype.equalsIgnoreCase("checklist")&&!strpagetype.equalsIgnoreCase("primcoverage")&&!strpagetype.equalsIgnoreCase("collcoverage")&&!strpagetype.equalsIgnoreCase("SecurityAnalysis")&&!strpagetype.equalsIgnoreCase("implement_sch")&&!strpagetype.equalsIgnoreCase("Termscond_Comments")&&!strpagetype.equalsIgnoreCase("determinelimit")&&!strpagetype.equalsIgnoreCase("interfirm")&&!strpagetype.equalsIgnoreCase("wccomm")&&!strpagetype.equalsIgnoreCase("IRMD Observation") &&!strpagetype.equalsIgnoreCase("Facilities")){ %>
	
			EditorEnableDisable("id_div1","block","id_editor1","none");
	<%}%>
	
}

function doEdit()
{ 	
	disableFields(false);
	disableCommandButtons("edit");	
	EditorEnableDisable("id_div1","none","id_editor1","block");
	editor_generate('txt_industryanalysis1');
	EditorEnableDisable("id_div","none","id_editor","block");
	editor_generate('txt_industryanalysis');
}

function doSave()
{
	document.forms[0].cmdsave.disabled=true;
    document.forms[0].pagetype.value = varpage;
    document.forms[0].hidAction.value ="update";
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidBeanMethod.value="updateDataComments";
	document.forms[0].hidBeanGetMethod.value="getDataComments";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/com_comments.jsp";
	document.forms[0].submit();
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
	document.forms[0].pagetype.value = varpage;
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidBeanGetMethod.value="getDataComments";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].action=appURL+"action/com_comments.jsp";	
	document.forms[0].submit();
	}	
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
	document.forms[0].hidAction.value="delete";
	document.forms[0].pagetype.value = varpage;
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidBeanMethod.value="updateDataComments";
	document.forms[0].hidBeanGetMethod.value="getDataComments";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/com_comments.jsp";
	document.forms[0].submit();
	}
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		window.close();
	}
}
function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;		 
	}
	if(val=="edit")
	{	 
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=false;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}
	if(val=="freeze")
	{	 
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=true;
		 document.forms[0].cmdsave.disabled=true;
		 document.forms[0].cmdcancel.disabled=true;		 
		 document.forms[0].cmdclose.disabled=true;
		 document.forms[0].cmdfreeze.disabled=true;	 
		 document.forms[0].cmdundo.disabled=false;
		 disableFields(false);
	}
	if(val=="undo")
	{	 
		disableFields(true);
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
		document.forms[0].cmdfreeze.disabled=false;	 
		document.forms[0].cmdundo.disabled=true;	 
	}
	if(val=="disableall")
	{
		//document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}
	
}  
function doFreeze()
	{
		if(confirm("Do You Want to Freeze the Application"))
		{
	
			if(parseInt(userclass)>=parseInt(updateclassValue))
			{
			disableCommandButtons("freeze");
			document.forms[0].pagetype.value = varpage;
			document.forms[0].hidAction.value ="Freeze";
			document.forms[0].hidBeanId.value="comproposal";
			document.forms[0].hidBeanMethod.value="updateDataComments";
			document.forms[0].hidBeanGetMethod.value="getDataComments";
			document.forms[0].hidSourceUrl.value="action/com_comments.jsp";	
			document.forms[0].method="post";
			document.forms[0].action=appURL+"action/controllerservlet";	
			document.forms[0].submit();
			}
			else
			{
				alert("You don't have Power to Freeze");
			}
		
		}
		
	}
function doUndo()
	{
		if(confirm("Do You Want to Undo the Application"))
		{
			if(parseInt(userclass)>=parseInt(undoclassValue))
			{
				disableCommandButtons("undo");
				document.forms[0].pagetype.value = varpage;
				document.forms[0].hidAction.value ="Undo";
				document.forms[0].hidBeanId.value="comproposal";
				document.forms[0].hidBeanMethod.value="updateDataComments";
				document.forms[0].hidBeanGetMethod.value="getDataComments";
				document.forms[0].hidSourceUrl.value="action/com_comments.jsp";	
				document.forms[0].method="post";
				document.forms[0].action=appURL+"action/controllerservlet";	
				document.forms[0].submit();
			}
			else
			{
				alert("You don't have Power to Undo");
			}
		}
		
	}	
function disableFields(val)
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
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].disabled=!val;
		}	 
	}
}

function callCalender(fname)
{
if(document.forms[0].cmdsave.disabled==false)
	{
	 showCal(appURL,fname);
	 }
}
function callApplicantTab(page)
  { 
  

   	if(document.forms[0].cmdsave.disabled)
	{

	  if(page=="company")
	  { 
	     document.forms[0].hidBeanId.value="commappmaster";
		 document.forms[0].hidBeanGetMethod.value="getData";
		 document.forms[0].action=appUrl+"action/comcompany.jsp";
	  }
	  if(page=="proposal")
	  {
	      document.forms[0].hidBeanId.value="facilities";
		  document.forms[0].hidBeanGetMethod.value="getFacilityData";
		  document.forms[0].action=appUrl+"action/facilities.jsp";
	  }
	 
	   if(page=="list")
	  {
	    document.forms[0].hidBeanId.value="comproposal";
		  document.forms[0].hidBeanGetMethod.value="getlistproposal";
		  document.forms[0].action=appUrl+"action/comlistproposal.jsp";
	  }
	  if(page=="specific")
	  {
	      document.forms[0].hidBeanId.value="facilities";
		  document.forms[0].hidBeanGetMethod.value="getfacilityspecific";
		  document.forms[0].action=appUrl+"action/com_facilityspecific.jsp";
	  }
	  document.forms[0].submit();
	}
	else
	{
		ShowAlert(103);
	}
 
}

function callLink(page,bean,method)
{
	if (document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidSourceUrl.value=page;
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
function getComments()
{	
	if(document.forms[0].sel_description.value!='s')
	{
		document.forms[0].pagetype.value = varpage;
		document.forms[0].method="post";
		document.forms[0].hidBeanId.value="comproposal";
		document.forms[0].hidBeanGetMethod.value="getDataComments";
		document.forms[0].action=appURL+"action/com_comments.jsp";
		document.forms[0].submit();
	}
}
</script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="placevalues()">

<form name="" method=post>

<table width="96%" border="0" cellspacing="0" cellpadding="3" align="center">
	
	<%if(strpagetype.equalsIgnoreCase("assdscr")){ %>
	<tr>
		<td class="dataheader">Comments on justification for accepting the sales, reasonableness of cost assessment, assumptions considered for profitability projection, ISCR and Net  Profit</td>
	</tr>
	<%}else{ %>
	<tr>
		<td class="dataheader" height="31">Comments</td>
	</tr>
	<%} %>

	<%
		if (strpagetype.equalsIgnoreCase("cop_mof")) {
	%>
	<tr>
		<td>Description&nbsp;<span class="mantatory">*</span>
		<select
			name="sel_description" onChange="getComments()">
			<option value="s" selected>-- Select --</option>
			<laps:StaticDataQuestionMastTag apptype="46" page="" />
		</select></td>
	</tr>
	<%
		}
	%>

</table>
<table width="96%" border="0" cellspacing="0" cellpadding="5" class="outertable border1" align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="datagrid">
			<tr>
				<td>
			<div id="id_div"><div class="EditorClassNew"> <%=Helper.correctNull((String)hshValues.get("fin_comments")) %></div></div>
				<div id="id_editor">
				<textarea name="txt_industryanalysis" cols="80"
					onkeyup="textlimitcorp1(this,200);" onkeydown="textlimitcorp1(this,200);" onKeyPress="checkEnter();textlimitcorp1(this,200)"
					wrap="VIRTUAL" rows="12"><%=Helper.correctNull((String) hshValues
									.get("fin_comments"))%>
					</textarea> </div></td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<%
			if(strpagetype.equalsIgnoreCase("assdscr")){ %>
				<tr>
					<td class="dataheader" height="31">Comments on DSCR</td>
				</tr>
				<%}%>
			<%if(!strpagetype.equalsIgnoreCase("compromoters")&&!strpagetype.equalsIgnoreCase("audit_significance")&&!strpagetype.equalsIgnoreCase("cop_mof")&&!strpagetype.equalsIgnoreCase("tleligibility")&&!strpagetype.equalsIgnoreCase("repaymentschedule")&&!strpagetype.equalsIgnoreCase("checklist")&&!strpagetype.equalsIgnoreCase("primcoverage")&&!strpagetype.equalsIgnoreCase("collcoverage")&&!strpagetype.equalsIgnoreCase("SecurityAnalysis")&&!strpagetype.equalsIgnoreCase("implement_sch")&&!strpagetype.equalsIgnoreCase("Termscond_Comments")&&!strpagetype.equalsIgnoreCase("determinelimit")&&!strpagetype.equalsIgnoreCase("interfirm")&&!strpagetype.equalsIgnoreCase("wccomm")&&!strpagetype.equalsIgnoreCase("IRMD Observation") &&!strpagetype.equalsIgnoreCase("Facilities")){ %>
			<tr>
			
			
				 <td>
					<div id="id_div1"><div class="EditorClassNew"> <%=Helper.correctNull((String)hshValues.get("fin_comments1")) %></div></div>
 					 <div id="id_editor1"> <textarea name="txt_industryanalysis1" cols="150" rows="12" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)">
   						<%=Helper.correctNull((String)hshValues.get("fin_comments1")) %>
 							</textarea></div>
  				</td>
			
			</tr>
			<%} %>
		</table>
		</td>
	</tr>
</table>
<br><br>
<table width="12%" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>

				<td>
				<lapschoice:combuttonnew btnnames="Edit_Save_Delete_Cancel" btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
				</td>

			</tr>
		</table>
		</td>
	</tr>
</table>

<input type="hidden" name="hidFacilityCode_COPMOF" value="<%=Helper.correctInt((String) request.getParameter("hidFacilityCode_COPMOF"))%>">
<input type="hidden" name="hidAction">
<input type="hidden" name="hidBeanId">
<input type="hidden" name="hidBeanMethod" value="">
<input type="hidden" name="hidBeanGetMethod" value="">
<input type="hidden" name="hidSourceUrl" value="">
<input type="hidden" name="hidsno"> 
<input type="hidden" name="hidappno" value="<%=Helper.correctNull((String) hshValues.get("appno"))%>">
<input type="hidden" name="appno" value="<%=Helper.correctNull((String) request.getParameter("appno"))%>">
<input type="hidden" name="pagetype">
</form>
</body>
<script language="JavaScript1.2">
var config = new Object(); // create new config object

config.width = "100%";
config.height = "220px";
config.bodyStyle = 'background-color: white; font-family: "Verdana"; font-size: x-small;';
config.debug = 0;

<%if(!strpagetype.equalsIgnoreCase("compromoters")&&!strpagetype.equalsIgnoreCase("audit_significance")&&!strpagetype.equalsIgnoreCase("cop_mof")&&!strpagetype.equalsIgnoreCase("tleligibility")&&!strpagetype.equalsIgnoreCase("repaymentschedule")&&!strpagetype.equalsIgnoreCase("checklist")&&!strpagetype.equalsIgnoreCase("primcoverage")&&!strpagetype.equalsIgnoreCase("collcoverage")&&!strpagetype.equalsIgnoreCase("SecurityAnalysis")&&!strpagetype.equalsIgnoreCase("implement_sch")&&!strpagetype.equalsIgnoreCase("Termscond_Comments")&&!strpagetype.equalsIgnoreCase("determinelimit")&&!strpagetype.equalsIgnoreCase("interfirm")&&!strpagetype.equalsIgnoreCase("wccomm")&&!strpagetype.equalsIgnoreCase("IRMD Observation")){ %>
var config1 = new Object(); // create new config object

config1.width = "100%";
config1.height = "220px";
config1.bodyStyle = 'background-color: white; font-family: "Verdana"; font-size: x-small;';
config1.debug = 0;
	
//editor_generate1('txt_industryanalysis1');
//setTimeout(function() { editor_modeUpdate("txt_industryanalysis1","disable") }, 100);
<%}%>
</script>

</html>
