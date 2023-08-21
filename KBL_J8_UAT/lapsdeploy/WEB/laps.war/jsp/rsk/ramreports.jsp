<%@include file="../share/directives.jsp"%>
<%
			String strcomappappno = Helper.correctNull((String) session.getAttribute("comm_appno"));
			String nfiles = "";
			String type = "";
			String goodfile = "";
			String badfile = "";
			String badrow = "";
			if (hshValues != null && hshValues.size() > 0) {
				nfiles = Helper.correctNull((String) hshValues.get("nofiles"));
				type = Helper.correctNull((String) hshValues.get("type"));
				goodfile = Helper.correctNull((String) hshValues.get("goodfile"));
				badfile = Helper.correctNull((String) hshValues.get("badfile"));
				badrow = Helper.correctNull((String) hshValues.get("badrow"));
			}%>
<html>
<head>
<title>Interface</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>	
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var nfiles="<%=nfiles%>";
var type="<%=type%>";
var goodfile="<%=goodfile%>";
var badfile="<%=badfile%>";
var badrow="<%=badrow%>";

function callonLoad()
{
	
	if((!(nfiles=="" && type=="")) &&(goodfile!="" && badfile!=""))
	{
		if(nfiles=="0")
		nfiles="0"+" (No Files In The Folder To Import)";
		if(badfile=="0")badrow="0";			
		if(goodfile=="1")
		{
			alert("Uploaded Sucessfully");
		}
		if(badfile=="1")
		{
			alert("Problem in Uploading the file please contact the adminstrator");
		}
		if(goodfile=="0" && badfile=="0")
		{
			alert("No Flat file found contact administrator");
		}
	}
}	

function doClose()
{
	document.forms[0].action="action/corppge.jsp";
	document.forms[0].submit();
}

function Report105()
{
	var varAppno="<%=strcomappappno%>";
	if(varAppno=="")
	{
		varAppno=document.forms[0].appno.value;
	}
	if(varAppno=="")
	{
		varAppno=document.forms[0].ApplicationNo.value;
	}
	if(varAppno=="")
	{
		alert("Technical problem please log out and then try for downloading");
	}
	else
	{
		varAppno=document.forms[0].appno.value;
		var varQryString = appURL+"action/ram105rep.jsp?hidBeanGetMethod=getram105rep&hidBeanId=ramratingreports&appno="+varAppno;
		var title = "Print";
		var prop = "scrollbars=yes,width=900,height=550,menubar=yes";
		prop = prop + ",left=50,top=150";
	    window.open(varQryString,title,prop);	
	}
}
function ImportReport()
{
	document.forms[0].hidBeanId.value="RAMTOLAPS";
	document.forms[0].hidBeanGetMethod.value="RAMtoLAPS_REPORT";			
	document.forms[0].action=appUrl+"action/ramreports.jsp";			
	document.forms[0].submit();	
}

function IRBRatingData()
{
	document.forms[0].hidBeanId.value="RAMTOLAPS";
	document.forms[0].hidBeanGetMethod.value="ramtolaps_IRBRating";			
	document.forms[0].action=appUrl+"action/ramreports.jsp";			
	document.forms[0].submit();
}

function ImportIRBIDReport()
{
	document.forms[0].hidBeanId.value="RAMTOLAPS";
	document.forms[0].hidBeanGetMethod.value="RAMtoLAPS_REPORT_IRBID";			
	document.forms[0].action=appUrl+"action/ramreports.jsp";			
	document.forms[0].submit();	
}

function IRBIDRatingData()
{
	document.forms[0].hidBeanId.value="RAMTOLAPS";
	document.forms[0].hidBeanGetMethod.value="ramtolaps_IRBRating_IRBID";			
	document.forms[0].action=appUrl+"action/ramreports.jsp";			
	document.forms[0].submit();
}

function gototab(beanid,methodname,pagename,flowtype)
{
	document.forms[0].hidBeanId.value=beanid;
	document.forms[0].hidBeanGetMethod.value=methodname;
	document.forms[0].flowtype.value=flowtype;
	document.forms[0].action=appURL+"action/"+pagename;
	document.forms[0].submit();
} 
</script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callonLoad()">
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
<form method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top" colSpan=5><jsp:include
			page="../com/proposallinks.jsp" flush="true">
			<jsp:param name="pageid" value="8" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<tr>
		<td class="page_flow">
			Home -&gt;
Corporate & SME -&gt; Proposal -&gt; Risk Analysis -&gt; IRB Rating
		</td>
	</tr>
</table>
<span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application />
<lapschoice:FinAnalysisTag tabid="6" />
<br>
<br>
<table width="38%" border="0" align="center" cellpadding="0" cellspacing="0" class="outertable linebor">

	<tr>
		<td align="center">
		<b><font color="red"><strong><u>RATING REPORTS</u></strong></font>
		</b>
		</td>
	</tr>	
    <tr>
		<td align="center"><b><a
			href="javascript:ImportIRBIDReport()">IMPORT RATING	DETAILS (IRBID)</a></b></td>
	</tr>
	<tr>
		<td align="center"><b><a
			href="javascript:IRBIDRatingData()">IMPORT IRB RATING (IRBID)</a></b></td>
	</tr>
	
	<tr>
		<td align="center"><b><a
			href="javascript:Report105()">RATING DETAILS</a></b>
		</td>
	</tr>	
</table>
<br>
<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<input type="hidden" name="hidcmano1"value="<%=Helper.correctNull((String)request.getParameter("hidcmano1"))%>">
<input type="button" name="cmdsave" disabled style="visibility:hidden" />
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="flowtype" value="CA"> 
<input type="hidden" name="yearfrom" value="1"> 
<input type="hidden" name="pageval" value=""> 
<input type="hidden" name="ApplicationNo" value="<%=strcomappappno%>">

</form>
</body>
</html>
