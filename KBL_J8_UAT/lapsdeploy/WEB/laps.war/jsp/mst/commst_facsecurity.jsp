<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<%@ taglib prefix="lapstab" uri="/WEB-INF/lapstab.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<lapschoice:handleerror />
<html>
<head>
<title> Modification in Sanction Terms</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
<script	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script>

var appURL = "<%=ApplicationParams.getAppUrl()%>";
var path      ="<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var facility = "<%=Helper.correctNull((String)hshValues.get("facility"))%>";
var security = "<%=Helper.correctNull((String)hshValues.get("security"))%>";


function placevalues()
{
if(facility !="")
	{
	document.forms[0].selfacility.value=facility;
	}
	
if(security!="")
	{
		varsecurity=security.split("@");	
		for(var i=0;i<security.length-1;i++)
		{
			var selValue=varsecurity[i];
			for(var j=0;j<document.forms[0].selsecurity.length;j++)
			{
				if(document.forms[0].selsecurity.options[j].value==selValue)
				{
					document.forms[0].selsecurity.options[j].selected=true
				}
			}
		}
	}
	disableFields(true);
	disableCommandButtons("load");
}

function doEdit()
{ 	
	if(document.forms[0].selfacility.value=="0")
	{
		alert("Select a Facility type");
		document.forms[0].selfacility.focus();
		return;
	}
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");	
}

function doSave()
{
	var varsec="";
		for(var i=0;i<document.forms[0].selsecurity.options.length;i++)
		{
			if(document.forms[0].selsecurity.options[i].selected)
			{				
			varsec=varsec+document.forms[0].selsecurity.options[i].value+"@";
			}		
		}
		
	document.forms[0].hidsecurity.value = varsec;
	document.forms[0].hidAction.value="insert";
	document.forms[0].hidBeanId.value="modsancterms";
	document.forms[0].hidSourceUrl.value="/action/commst_facsecurity.jsp";
	document.forms[0].hidBeanMethod.value="updateFacSecurityData";
	document.forms[0].hidBeanGetMethod.value="getFacSecurityData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanGetMethod.value="getFacSecurityData";
		document.forms[0].hidBeanId.value="modsancterms";
		document.forms[0].action=appURL+"action/commst_facsecurity.jsp";
		document.forms[0].submit();
	}	
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value="Delete";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="modsancterms";
		document.forms[0].hidSourceUrl.value="/action/commst_facsecurity.jsp";
		document.forms[0].hidBeanMethod.value="updateFacSecurityData";
		document.forms[0].hidBeanGetMethod.value="getFacSecurityData";	
		document.forms[0].submit();
	}
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/corppge.jsp";
		document.forms[0].submit();
	}
}

function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddel.disabled=true;
		document.forms[0].cmdapply.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;		 
	}
	if(val=="edit")
	{	 
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddel.disabled=false;
		 document.forms[0].cmdapply.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}
	if(val=="radioselect")
	{	 
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddel.disabled=false;
		document.forms[0].cmdapply.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}	  
	if(val=="disableall")
	{
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddel.disabled=true;
		document.forms[0].cmdapply.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
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
		else if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
		else if(document.forms[0].elements[i].type=="select-multiple")
		{
			document.forms[0].elements[i].disabled=val;
		}	 
	}
	document.forms[0].selfacility.disabled=false;    
}

function callCalender(fname)
{
	if(document.forms[0].cmdapply.disabled==false)
	{
	 showCal(appURL,fname);
	 }
}

function callLink(page,bean,method)
{
	if (document.forms[0].cmdapply.disabled)
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


function displayData()
{		
	
    	document.forms[0].hidBeanGetMethod.value="getFacSecurityData";
		document.forms[0].hidBeanId.value="modsancterms";
		document.forms[0].action=appURL+"action/commst_facsecurity.jsp";
		document.forms[0].submit();
}
</script>
</head>
<body onload="placevalues()">
<form name="MSTFacSecurity" method=post>
<lapstab:applurllinksmst pageid="2"/>
<table width="100%" border="1" cellpadding="5" cellspacing="0"	bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class=page_flow>Corporate &amp; SME -&gt; Modification in
				Sanction Terms -&gt; Charges on Security</td>
			</tr>
		</table>
		<lapschoice:MSTApplications />
		<lapstab:MSTSecuritytab tabid="2"/>
	  </td>
	</tr>
	</table>
<table width="100%" border="1" cellpadding="5" cellspacing="0"	bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
	<tr>
		<td>
	<tr>
		<td>
		<table width="100%" border="1" cellspacing="0" cellpadding="2"
			bordercolorlight="#FFFFFB" bordercolordark="#DEDACF"
			bgcolor="#DEDACF">
			<tr>
				<td>

				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="19%">&nbsp;&nbsp;Facility</td>
						<td><select name="selfacility" tabindex="2"
							onchange="displayData()">
							<option value="0">---Select-----</option>
							<lapschoice:mstfacility />
						</select></td>
					</tr>
					<tr>
						<td colspan="2">&nbsp;</td>
					</tr>
					<tr>
						<td width="19%">&nbsp;&nbsp;Security</td>
						<td colspan="2"><select name="selsecurity" style="width:150"
							size="10" multiple>
							<lapschoice:mstsecurity />
						</select></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
</table>
<lapschoice:combutton btntype="EO"
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag /> <input type="hidden" name="hidsno"> <input
	type="hidden" name="hidsecurity" /></form>
</body>
</html>
