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
function doClose()
{
	if(ConfirmMsg(100))
	 {
		 document.forms[0].action=appUrl+"action/npareplist.jsp";
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
	if(checkfields())
	{
	var code=document.forms[0].sel_org.value;
	for(var i=0;i<document.forms[0].sel_org.length;i++)
	{
		if(document.forms[0].sel_org.options[i].selected==true)
		{
			var orgname=document.forms[0].sel_org.options[i].text;
		}
	}
	var selfields;
	var npatypedesc;
	var npatype;
	var period;
	var level;
	for(var i=0,count=0;i<document.forms[0].sel_npatype.length;i++)
	{
		if(document.forms[0].sel_npatype.options[i].selected==true)
		{
			if(count==0)
			{
				selfields=document.forms[0].sel_npatype.options[i].value;
				npatypedesc=document.forms[0].sel_npatype.options[i].text;
			}
			else
			{
				selfields=selfields+",";
				selfields=selfields+document.forms[0].sel_npatype.options[i].value;
				npatypedesc=npatypedesc+",";
				npatypedesc=npatypedesc+document.forms[0].sel_npatype.options[i].text;
			}
			count++;
		}
	}
	period=document.forms[0].txt_period.value;
	level=document.forms[0].sel_level.value;
	window.open(appUrl+"action/npaproposalreportgenerated.jsp?hidBeanId=npa&hidBeanMethod=getNpaProposalReport&hidBeanGetMethod=getNpaProposalReport&hidOrgName="+orgname+"&hidcode="+code+"&hidselfields="+selfields+"&hidperiod="+period+"&hidlevel="+level+"&hidnpatypedesc="+npatypedesc,"stat","scrollbars=Yes,toolbars=No,menubar=no ,width=750 , height=550,top=10,left=10");
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
	}
	document.forms[0].sel_org.length=0;
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
		<b><i>Home -> NPA -> Disposal of NPA Application</i></b>
		</font>
	</td>
</tr>
</table>
<table width="100%" border="0">
<tr>
<td>
</td>
</tr>
</table>
<table width="100%" border="0">
<tr>
<td>
	<table width="100%" border="0" class="outertable border1" height="500">
		<tr>
			<td valign="middle">
			<table width="50%" align="center" valign="middle" border="0" class="outertable border1">
			<tr>
			<td>
				<table width="100%" align="center" border="0" >
					
					<tr>
					<td>
						<table width="100%" border="0">
							<tr>
								<td width="50%" align="center" >
									Level
								</td>
								<td width="50%" align="center" >
									NPA Type
								</td>
							</tr>
						</table>
					</td>
					</tr>
					<tr>
					<td>
					<table width="100%" border="0">
					 <tr>
						<td width="50%" align="center">
							<select name="sel_level" onChange="selectValues()">
								<option value="0"> --select-- </option>
								<laps:reptag beanid="setupreport" methodname="getLevels" param="" />
							</select>
						</td>
						<td width="50%" align="center">
							<select name="sel_npatype">
								<option value="0"> --select-- </option>
								<option value="OTSCO">Compromise Proposal</option>
								<option value="PAWO">Write Off</option>
								<option value="SUIT">Suite File</option>
								<option value="SARFI">SARFAESI Act</option>
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
							<td align="center" width="100%">
								Select Organisation
							</td>
							
						</tr>
					</table>
				</td>
				</tr>
				<tr>
				<td >
					<table width="100%" border="0">
						<tr>
							<td align="center" width="100%">
								<select name="sel_org" size="10" style="width:250" >
								</select>
							</td>
							
						</tr>
					</table>
				</td>
				</tr>
				<tr>
				<td>
					<table width="40%" border="0" align="center">
						<tr>
							<td width="15%" align="center"> 
								Period 
							</td>
							<td width="85%" align="center"> 
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
				
							<table border="0" align="center">
							<tr>
							<td width="100%" align="center">
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
<input type="hidden" name="hidOrgCode">
</form>
</body>
</html>
