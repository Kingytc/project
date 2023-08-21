<%@include file="../share/directives.jsp"%>
<% 
String strBorrowerType =Helper.correctNull((String)request.getParameter("hidBorrowerType"));
String strAssessmentType= Helper.correctNull((String)hshValues.get("assessmenttype"));
%>
<html>
<head>
<title>Proposal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
	<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script><!--
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var assessmenttype="<%=strAssessmentType%>";   
var assessvalue="<%=Helper.correctNull((String)hshValues.get("finassessavailable"))%>";
var varcommentsavail="<%=Helper.correctNull((String)hshValues.get("commentsavailable"))%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
function enableButtons(bool1,bool2,bool3,bool4)
{	
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmdclose.disabled=bool4;
}
function callLink(page,bean,method)
{
	if (document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appUrl+"action/"+page;
		document.forms[0].submit();
	}
	else
	{
		ShowAlert(103);
	}
}

function doCancel()
{
	if (ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="comproposal";
		document.forms[0].hidBeanGetMethod.value="getAssessmentType";
		document.forms[0].action=appUrl+"action/com_assessmenttype.jsp";
		document.forms[0].submit();
	}
}
function doEdit()
{
	enableButtons(true,false,false,true,false);
	disableFields(false);
}

function doSave()
{
	if(assessmenttype!="" && varcommentsavail=="Y")
	{
		alert("Delete the comments in the selected assessment type and then change the assessment type");
		return;
	}
	else
	{
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].hidAction.value="insert";
		document.forms[0].hidBeanId.value="comproposal";
		document.forms[0].hidBeanMethod.value="updateAssessmentType";
		document.forms[0].hidBeanGetMethod.value="getAssessmentType";
		document.forms[0].hidSourceUrl.value="/action/com_assessmenttype.jsp";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();
	}
}


function callOnload()
{
	if(document.forms[0].btnenable.value=="Y")	 
	{
		enableButtons(false,true,true,false)	
	}
	else
	{
		enableButtons(true,true,true,false)	
	}
	
		disableFields(true)	
	
	if(assessmenttype!='')
	{
		document.forms[0].sel_assessment.value=assessmenttype;
		
	}
	else
	{
	document.forms[0].sel_assessment.value='0';
	}
	
	if(document.forms[0].sel_assessment.value=="0")
	{
	 document.all.assessment.style.visibility="hidden";
	}
	else
	{
	 document.all.assessment.style.visibility="visible";
	}
} 

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appUrl+"action/comsearch.jsp";
		document.forms[0].submit();
	}
}

function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appUrl,name);
	}
}

function getData()
{
	document.forms[0].hidBeanId.value="";
	document.forms[0].hidBeanGetMethod.value="";
	document.forms[0].hidSourceUrl.value="/action/";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
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

function gototab(beanid,methodname,pagename,flowtype)
{
	if((pagename=="com_loanreqcomment.jsp?type=1&pageval=TO" || pagename=="com_loanreqcomment.jsp?type=1&pageval=MPBF1" || pagename=="com_loanreqcomment.jsp?type=1&pageval=PBF2")&& assessvalue!="Y")
	{
		alert("Load the Financial Assessment Value");
		return;		
	}
	else
	{
		
		if(flowtype=="COP")
		{			 
			document.forms[0].hidBeanId.value=beanid;
			document.forms[0].hidBeanGetMethod.value=methodname;
			document.forms[0].action=appURL+"action/"+pagename+"?hidPageSource="+flowtype;
			document.forms[0].submit();
		}
		else
		{			
			document.forms[0].hidBeanId.value=beanid;
			document.forms[0].hidBeanGetMethod.value=methodname;
			document.forms[0].flowtype.value=flowtype;
			document.forms[0].action=appURL+"action/"+pagename;
			document.forms[0].submit();
		}		
	}
} 

function Loadassessment()
{
	document.forms[0].hidBeanId.value="combobassessment";
	document.forms[0].hidBeanGetMethod.value="UpdateAssessmentdatas";
	document.forms[0].action=appURL+"action/com_assessmenttype.jsp?pageval="+assessmenttype;
	document.forms[0].submit();
	
}
--></script>
</head>
<body onload="callOnload()">
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
<form name="frmpri" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="top"><jsp:include page="../com/proposallinks.jsp"
			flush="true">
			<jsp:param name="pageid" value="41" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<span class="page_flow">Home -&gt; Corporate &amp; SME -&gt;
Proposal -&gt; Financial Analysis -&gt; Assessment -&gt; Assessment of
Working capital limits -&gt; Assessment Type</span><br>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
 <jsp:include
	page="../com/com_commentstab.jsp" flush="true">
	<jsp:param name="tabid" value="1" />
</jsp:include> <lapschoice:ComAssessmentTab subtabid="1"
	assessmenttype="<%=strAssessmentType%>" />
<table width="98%" border="0" cellspacing="0" cellpadding="5"
	class="outertable" align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="1"
			class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="1" cellpadding="4"
					class="outertable">
					<Tr>
						<td>Type of Assessment <select name="sel_assessment"
							tabindex="1">
							<option value="0" selected="selected">--Select--</option>
							<option value="TO">Turn Over Method</option>
							<option value="MPBF1">Flexible Bank Finance</option>
							<option value="CBM">Cash Budget Method</option>
							<option value="PBF2">NBFC1</option>
						</select></td>
					</tr>
					<tr id="assessment">
						<td align="center"><input type="button" name="Loadassesment"
							value="Load Assessment" class="buttonStyle" style="width: 120"
							onClick="Loadassessment()"></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel'
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>' /> <input type="hidden"
	name="cattype" value="<%=strCategoryType%>"> <input
	type="hidden" name="ssitype" value="<%=strSSIType%>"> <input
	type="hidden" name="id" value="<%=strBorrowerType%>"> <input
	type="hidden" name="flowtype"> <input type="hidden"
	name="yearfrom" value="1">
	<input type="hidden" name="pagefrom">
	<INPUT TYPE="hidden" name="strAssessment" value = "<%=request.getParameter("strAssessment")%>">
	</form>
</body>
</html>
