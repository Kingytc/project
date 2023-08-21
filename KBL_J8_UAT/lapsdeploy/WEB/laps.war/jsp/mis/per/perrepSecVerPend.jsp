<%@ include file="../../share/directives.jsp"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%
	String str_report = Helper.correctNull((String) request.getParameter("report"));
	String str_multiple = "";
	if (str_report.equalsIgnoreCase("C")) {
		str_multiple = "multiple";
	} else {
		str_multiple = "";
	}
%>
<html>
<head>
<title>Security Verification Pending</title>
<script><!--
var path="<%=ApplicationParams.getAppUrl()%>";
var param="";
var userid ="<%=(String) session.getAttribute("strUserId")%>";
var rights ="<%=(String) session.getAttribute("strGroupRights")%>";
var report = "<%=str_report%>";

function callonLoad()
{
		document.forms[0].hidBeanId.value="perrepappstatus";
}
function selectValues()
{
	document.forms[0].rpselect1.selectedIndex =-1;
	var bnkname = document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].value;
	document.all.ifrm.src=path+"action/iframeapprep.jsp?hidBeanMethod=getData&hidMethod=getOrgnames&hidBeanId=repappper&bnklevel="+bnkname;
}

function showPeriod()
{
	var purl = path+"jsp/share/repdateselect.jsp";
	var title = "ListofPeriod";
	var prop = "scrollbars=no,width=400,height=400";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 320) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,title,prop);
}
function doRunReport()
{
	var param = setParam();
	var code =document.forms[0].hidOrgCode.value;
	var orglevel=document.forms[0].sellevel.value;
	
	var orgname = document.forms[0].hidOrgName.value;
	
	if(document.forms[0].sellevel.selectedIndex == 0)
	{
		ShowAlert('111',"Organisation Level");
		document.forms[0].sellevel.focus();
		return;
	}
	if(document.forms[0].rpselect1.selectedIndex == -1)
	{
		ShowAlert('111','Organisation');
		document.forms[0].rpselect1.focus();
		return;
	}
 /*	if(orglevel=="C")
	{
		if(document.forms[0].seldepartment.value=="S")
		{
			ShowAlert('111','Department');
			document.forms[0].seldepartment.focus();
			return;
		}
	}
	if(orglevel!="A")
	{
		if(document.forms[0].seldesignaion.value=="S")
		{
			ShowAlert('111','Designation');
			document.forms[0].seldesignaion.focus();
			return;
		}
	}*/
	window.open(path+"action/perrepSecVerPend_disp.jsp?hidBeanId=perrepappstatus&hidBeanMethod=getData&hidMethod=getSecVerifPendingdata&hidOrgCode="+code+"&orglevel="+orglevel+"&hidOrgName="+orgname,"stat","scrollbars=Yes,toolbars=No,menubar=yes ,width=900 , height=600,top=10,left=10");
	
}
function setParam()
{
	var orgcode="";
	var orgname="";
	var count=0;
	var org="";
	var org_name="";
	
	if(document.forms[0].sellevel.selectedIndex != 0 
		&&	document.forms[0].rpselect1.selectedIndex != -1) 
	{
		
		orgcode =document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].text;
		   count =0;
				for(x=0;x<document.forms[0].rpselect1.length;x++)
				{
					if (document.forms[0].rpselect1[x].selected)
					{
						count++;
						var c = document.forms[0].rpselect1.options[x].value;
						if(report!='C')
						{
						c = c.substring(2,c.length);
						}
						org =org + "'"+c+"'"+",";
						c = document.forms[0].rpselect1.options[x].text;
						org_name =org_name + "," + c ;				
					}
				}
				if (count > 0)
				{
					org= org.substring(0,org.length-1);
					org_name= org_name.substring(1,org_name.length);
				}
	
	document.forms[0].hidOrgCode.value =org;	
	document.forms[0].hidOrgName.value =org_name;	
	}
	return;
}
function doReset()
{
	document.forms[0].sellevel.options[0].selected =true;
	document.forms[0].rpselect1.length =0;

}
function doClose()
{
	if (ConfirmMsg("100"))
	{
	document.forms[0].hidBeanId.disabled=true;
	document.forms[0].action=path+"action/repnav.jsp";
	document.forms[0].submit();
	}
}
function callCalender(cmdname) {
		showCal(appURL, cmdname);
}

--></script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">

</head>

<body onload="callonLoad();">
<form name="perappstat" method="post" class="normal"><iframe
	height="0" width="0" id="ifrm" frameborder=0 style="border: 0"></iframe>
<br>
<table class="outertable" width="100%" border="0" cellspacing="0"
	cellpadding="0">
	<tr>
		<td class="page_flow">Home  -&gt; Reports -&gt;
		 Security Verification pending Report </td>
	</tr>
	<tr>
		<td align="right">&nbsp;</td>
	</tr>
</table>

<table class="outertable" width="100%" border="0" cellspacing="0"
	cellpadding="20">
	<tr>
		<td valign="middle">
		<table class="outertable border1 tableBg" border="0" cellspacing="0" cellpadding="3"
			align="center" width="65%">
			<tr>
				<td>
				<table class="outertable" width="100%" border="0" cellspacing="0"
					cellpadding="5" align="center">
					<tr>
						<td colspan="2" height="30">
						<table class="outertable" width="100%" border="0" cellspacing="0"
							cellpadding="3">
							<tr>
								<td width="39%" align="center">Organisation Level</td>
							</tr>
							<tr>
								
								<td width="39%" align="center"><select name="sellevel"
									style="width: 100px;" onChange="selectValues();" tabindex="1">
									<option selected>---Select---</option>
									<laps:reptag beanid="setupreport" methodname="getOrgLevels"
										param="" />
								</select></td>
								
							</tr>
							
						</table>
						</td>
					</tr>
					<tr>
						<td width="75%" valign="top" colspan="2">
						<table class="outertable" width="100%" border="0" cellspacing="0"
							cellpadding="4">
							<tr align="center">
								<td align="center" width="96%">Select Organisation</td>
								<td align="center" width="4%">&nbsp;</td>
							</tr>
							<tr align="center">
								<td width="96%"><select name="rpselect1" size="11"
									style="width: 230" tabindex="3" <%=str_multiple%>>
								</select></td>
								</tr>
							
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
<lapschoice:combuttonnew btnnames="Run Report_Reset" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
 <input	type="hidden" name="hidOrgCode"> 
 <input type="hidden"
	name="userid">  <input type="hidden"
	name="hidusr_id"> <input type="hidden" name="txtSaveDate"
	value='<%=Helper.getCurrentDateTime()%>'> <input type="hidden"
	name="hidOrgName">
	<iframe height="0" width="0" name="ifrmsancauthority" frameborder="0" style="border:0"></iframe>
	
	</form>
</body>
</html>
