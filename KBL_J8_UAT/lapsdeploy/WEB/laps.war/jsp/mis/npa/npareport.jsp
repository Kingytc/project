<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<laps:handleerror />
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>NPA REPORTS</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script>
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var userid ="<%=(String)session.getAttribute("strUserId")%>";
/*function viewby()
{
	document.forms[0].sel_level.disabled=true;
	if(document.forms[0].sel_viewby.value=="org")
	{
		setorg();
	}
	else
	if(document.forms[0].sel_viewby.value=="state")
	{
		setstate();
	}
	else
	if(document.forms[0].sel_viewby.value=="city")
	{
		setcity();
	}
	else
	if(document.forms[0].sel_viewby.value=="statecity")
	{
		setstatecity();
	}
	else
	if(document.forms[0].sel_viewby.value=="district")
	{
		setdistrict();
	}
}

function setorg()
{
	document.forms[0].sel_level.disabled=false;
}

function setstate()
{
	alert("state");
}

function setcity()
{
	alert("city");
}

function setstatecity()
{
	alert("statecity");
}

function setdistrict()
{
	alert("district");
}*/

function doClose()
{
	if(ConfirmMsg(100))
	 {
		 document.forms[0].action=appUrl+"action/npa_mainlinknav.jsp";
		 document.forms[0].submit();
	 }
}

function selectValues()
{
	document.forms[0].sel_org.selectedIndex =-1;
	var bnkname = document.forms[0].sel_level.options[document.forms[0].sel_level.selectedIndex].value;
	document.all.ifrm.src=appUrl+"action/iframenpareport.jsp?hidBeanMethod=getData&hidMethod=getOrgnames&hidBeanId=repappper&bnklevel="+bnkname; 
}

function onLoading()
{
	// document.forms[0].sel_level.disabled=true;
	document.forms[0].txt_period.readOnly=true;
}

function checkfields()
{
	var i;
	if(document.forms[0].sel_level.value=="0")
	{
		alert("Select level");
		document.forms[0].sel_level.focus();
		return false;
	}
	if(document.forms[0].sel_processstatus.value=="0")
	{
		alert("Select Process Status");
		document.forms[0].sel_processstatus.focus();
		return false;
	}
	if(document.forms[0].sel_npatype.value=="0")
	{
		alert("Select NPA Type");
		document.forms[0].sel_npatype.focus();
		return false;
	}
	for(i=0;i<document.forms[0].sel_org.length;i++)
	{
		if(document.forms[0].sel_org.options[i].selected==true)
		{
			break;
		}
	}
	if(i==document.forms[0].sel_org.length)
	{
		alert("Select an Organisation");
		document.forms[0].sel_org.focus();
		return false;
	}
	for(i=0;i<document.forms[0].sel_select2.length;i++)
	{
		if(document.forms[0].sel_select2.options[i].selected==true)
		{
			break;
		}
	}
	if(i==document.forms[0].sel_select2.length)
	{
		alert("Select Output Field");
		document.forms[0].sel_select2.focus();
		return false;
	}
	if(document.forms[0].txt_period.value=="")
	{
		alert("Enter Period");
		document.forms[0].txt_period.focus();
		return false;
	}
	return true;
}

function runreport()
{
	setoutputfields();
	if(checkfields())
	{
	
	var status=document.forms[0].sel_processstatus.value;
	var code=document.forms[0].sel_org.value;
	for(var i=0;i<document.forms[0].sel_org.length;i++)
	{
		if(document.forms[0].sel_org.options[i].selected==true)
		{
			var orgname=document.forms[0].sel_org.options[i].text;
		}
	}
	var selfields;
	var npatype;
	var period;
	var level;
	for(var i=0,count=0;i<document.forms[0].sel_select2.length;i++)
	{
		if(document.forms[0].sel_select2.options[i].selected==true)
		{
			if(count==0)
			{
				selfields=document.forms[0].sel_select2.options[i].text;
			}
			else
			{
				selfields=selfields+",";
				selfields=selfields+document.forms[0].sel_select2.options[i].text;
			}
			count++;
		}
	}
	npatype=document.forms[0].sel_npatype.value;
	period=document.forms[0].txt_period.value;
	level=document.forms[0].sel_level.value;
	window.open(appUrl+"action/npareportgenerated.jsp?hidBeanId=npa&hidBeanMethod=getNpaReport&hidBeanGetMethod=getNpaReport&hidOrgName="+orgname+"&hidstatus="+status+"&hidcode="+code+"&hidselfields="+selfields+"&hidnpatype="+npatype+"&hidperiod="+period+"&hidlevel="+level,"stat","scrollbars=Yes,toolbars=No,menubar=no ,width=750 , height=550,top=10,left=10");
	}
}

function showPeriod()
{
	var purl = appUrl+"action/npareportdateselect.jsp";
	var title = "ListofPeriod";
	var prop = "scrollbars=no,width=350,height=320";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 320) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,title,prop);
}

function resetValues()
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].value="";
		}
		else
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].value=0;
		}
		else
		if(document.forms[0].elements[i].type=="select-multiple")
		{
			document.forms[0].elements[i].length=0;
		}
	}
	document.forms[0].sel_org.length=0;
}

function getoutputfields()
{
	if(document.forms[0].sel_level.value=='A')
	{
		document.forms[0].sel_select2.length=6;
	}
	else if(document.forms[0].sel_level.value!=0)
	{
		document.forms[0].sel_select2.length=7;
		document.forms[0].sel_select2.options[6].value="branch";
		document.forms[0].sel_select2.options[6].text="Branch";
	}
	
	if(document.forms[0].sel_processstatus.value==0)
	{
		document.forms[0].sel_select2.length=0;
	}
	else if(document.forms[0].sel_processstatus.value=="Pending")
	{
		document.forms[0].sel_select2.options[0].value="appno";
		document.forms[0].sel_select2.options[0].text="Application Number";
		document.forms[0].sel_select2.options[1].value="borrname";
		document.forms[0].sel_select2.options[1].text="Borrower Name";
		document.forms[0].sel_select2.options[2].value="amount";
		document.forms[0].sel_select2.options[2].text="Amount";
		document.forms[0].sel_select2.options[3].value="applieddate";
		document.forms[0].sel_select2.options[3].text="Applied Date";
		document.forms[0].sel_select2.options[4].value="pendingwith";
		document.forms[0].sel_select2.options[4].text="Pending With";
		document.forms[0].sel_select2.options[5].value="pendingsince";
		document.forms[0].sel_select2.options[5].text="Pending Since";
	}
	else if(document.forms[0].sel_processstatus.value=="Approved")
	{
		document.forms[0].sel_select2.options[0].value="appno";
		document.forms[0].sel_select2.options[0].text="Application Number";
		document.forms[0].sel_select2.options[1].value="borrname";
		document.forms[0].sel_select2.options[1].text="Borrower Name";
		document.forms[0].sel_select2.options[2].value="amount";
		document.forms[0].sel_select2.options[2].text="Amount";
		document.forms[0].sel_select2.options[3].value="applieddate";
		document.forms[0].sel_select2.options[3].text="Applied Date";
		document.forms[0].sel_select2.options[4].value="approvedby";
		document.forms[0].sel_select2.options[4].text="Approved By";
		document.forms[0].sel_select2.options[5].value="approveddate";
		document.forms[0].sel_select2.options[5].text="Approved Date";
	}
	else if(document.forms[0].sel_processstatus.value=="Rejected")
	{
		document.forms[0].sel_select2.options[0].value="appno";
		document.forms[0].sel_select2.options[0].text="Application Number";
		document.forms[0].sel_select2.options[1].value="borrname";
		document.forms[0].sel_select2.options[1].text="Borrower Name";
		document.forms[0].sel_select2.options[2].value="amount";
		document.forms[0].sel_select2.options[2].text="Amount";
		document.forms[0].sel_select2.options[3].value="applieddate";
		document.forms[0].sel_select2.options[3].text="Applied Date";
		document.forms[0].sel_select2.options[4].value="rejectedby";
		document.forms[0].sel_select2.options[4].text="Rejected By";
		document.forms[0].sel_select2.options[5].value="rejecteddate";
		document.forms[0].sel_select2.options[5].text="Rejected Date";
	}
	
	if(document.forms[0].sel_level.value==0)
	{
		document.forms[0].sel_select2.length=0;
	}
}

function setoutputfields()
{
	for(var i=0;i<4 && document.forms[0].sel_select2.length >= 4;i++)
	{
		document.forms[0].sel_select2.options[i].selected=true;
	}
}
</script>
</head>
<body bgcolor="#EEEAE3" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF" onload="onLoading()">
<form>
<iframe  height="0" width="0" id="ifrm" frameborder=0 style="border:0" ></iframe> 
<table width="100%" border="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
<tr>
	<td>
		 <font face="Times New Roman" size="3">
		<b><i>Home -> NPA -> NPA Reports</i></b>
		</font>
	</td>
</tr>
</table>
<table width="100%" border="0">
<tr>
<td>
&nbsp;
</td>
</tr>
<tr>
<td>
	<table width="100%" border="0" height="500" class="outertable border1">
		<tr>
			<td valign="middle">
			<table width="80%" align="center" valign="middle" border="0" >
			<tr>
			<td>
				<table width="100%" align="center" border="0">
					<!--  
					<tr>
					<td>
						<table width="100%" border="0">
							<tr>
								<td width="25%" align="center">
									 View By  
								</td>
								<td width="25%" align="center" >
									Level
								</td>
								<td width="25%" align="center" >
									Process Status
								</td>
								<td width="25%" align="center" >
									NPA Type
								</td>
							</tr>
						</table>
					</td>
					</tr>
					-->
					<tr>
					<td>
						<table width="100%" border="0">
							<tr>
								<td width="33%" align="center" >
									Level
								</td>
								<td width="33%" align="center" >
									NPA Type
								</td>
								<td width="33%" align="center" >
									Process Status
								</td>
							</tr>
						</table>
					</td>
					</tr>
					<tr>
					<td>
					<table width="100%" border="0">
					 <tr>
						<td width="33%" align="center">
							<select name="sel_level" onChange="selectValues();getoutputfields();">
								<option value="0"> --select-- </option>
								<laps:reptag beanid="setupreport" methodname="getLevels" param="" />
							</select>
						</td>
						<td width="33%" align="center">
							<select name="sel_npatype">
								<option value="0"> --select-- </option>
								<option value="OTSCO">Compromise Proposal</option>
								<option value="PAWO">Write Off</option>
								<option value="SUIT">Suite File</option>
								<option value="SARFI">SARFAESI Act</option>
							</select>
						</td>
						<td width="33%" align="center">
							<select name="sel_processstatus" onChange="getoutputfields()">
								<option value="0"> --select-- </option>
								<option value="Pending" >Pending</option>
								<option value="Approved">Approved</option>
								<option value="Rejected">Rejected</option>
							</select>
						</td>
					</tr>
				</table>
				</td>
				</tr>
				<tr>
				<td >
					<table width="100%" border="0">
						<tr>
							<td align="center" width="50%">
								Select Organisation
							</td>
							<td align="center" width="50%">
								Output Fields
							</td>
						</tr>
					</table>
				</td>
				</tr>
				<tr>
				<td >
					<table width="100%" border="0">
						<tr>
							<td align="center" width="50%">
								<select name="sel_org" size="10" style="width:250">
								</select>
							</td>
							<td align="center" width="50%">
								<select name="sel_select2" size="10" style="width:150" multiple>
								</select>
							</td>
						</tr>
					</table>
				</td>
				</tr>
				<tr>
				<td>
					<table width="30%" border="0" align="center">
						<tr>
							<td width="25%" align="center"> 
								Period 
							</td>
							<td width="75%" align="center"> 
								<input type="text" maxlength="21" name="txt_period" size="23">
								&nbsp;
								<a href="#" onClick="JavaScript:showPeriod()" class="blackfont"><b>?</b></a>
							</td>
						</tr>
					</table>
				</td>
				</tr>
				</table>
				</td>
				</tr>
				</table>
				
	</table>
	</td>
</tr>
<tr>
				<td>
				<table width="50%" align="center">
					<tr>
						<td width="100%" align="center">
							<table border="0">
							<tr>
							<td>
							<input type="button" name="cmdRunReport" value="Run Report" style="background-color:#8F8369;color:white;font-weight:bold;font-size=10;font-family:mssansserif;" onclick="runreport()">
							<input type="button" name="cmdReset" value="Reset" style="background-color:#8F8369;color:white;font-weight:bold;font-size=10;font-family:mssansserif;" onClick="resetValues()">
							<!-- <input type="button" name="cmdHelp" value="Help" style="background-color:#009966;cursor:help;;color:white;font-weight:bold;font-size=10;font-family:mssansserif;">  -->
							<input type="button" name="cmdClose" value="Close" style="background-color:#CC3300;color:white;font-weight:bold;font-size=10;font-family:mssansserif;" onClick="doClose()">
							</td>
							</tr>
							</table>
						</td>
					</tr>
				</table>	
			</td>
		</tr>
</table>
<input type="hidden" name="hidOrgCode">
</form>
</body>
</html>
