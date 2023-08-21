<%@ include file="../share/directives.jsp"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>TARGET MASTER REPORT</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<script>
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var userid ="<%=(String)session.getAttribute("strUserId")%>";
function doClose()
{
	if(ConfirmMsg(100))
	 {
		 document.forms[0].action=appUrl+"action/mainnav.jsp";
		 document.forms[0].submit();
	 }
}

function selectValues()
{
	var i=0,j=0;
	document.forms[0].sel_select1.selectedIndex =-1;
	var bnkname = document.forms[0].sel_level.options[document.forms[0].sel_level.selectedIndex].value;
	document.all.ifrm.src=appUrl+"action/iframetargetreport.jsp?hidBeanMethod=getData&hidMethod=getOrgnames&hidBeanId=repappper&bnklevel="+bnkname; 
	// document.all.ifrm.src=appUrl+"action/iframenpareport.jsp?hidBeanMethod=getData&hidMethod=getOrgnames&hidBeanId=repappper&bnklevel=A"; 
	// document.all.ifrm.src=appUrl+"action/iframetargetmasterbranch.jsp?hidBeanMethod=getData&hidMethod=getOrgnames&hidBeanId=repappper&bnklevel="+bnkname; 
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
	for(i=0;i<document.forms[0].sel_select1.length;i++)
	{
		if(document.forms[0].sel_select1.options[i].selected==true)
		{
			break;
		}
	}
	if(i==document.forms[0].sel_select1.length)
	{
		alert("Select an Organisation");
		document.forms[0].sel_select1.focus();
		return false;
	}
	if(!(document.forms[0].sel_monthfrom.value>0 && document.forms[0].sel_monthto.value>0 && document.forms[0].txt_yearfrom.value.length==4 && document.forms[0].txt_yearto.value.length==4))
	{
		alert("Select Period");
		
		if(document.forms[0].sel_monthfrom.value==0)
		document.forms[0].sel_monthfrom.focus();
		else if(document.forms[0].txt_yearfrom.value.length<4)
		document.forms[0].txt_yearfrom.focus();
		else if(document.forms[0].sel_monthto.value==0)
		document.forms[0].sel_monthto.focus();
		else if(document.forms[0].txt_yearto.value.length<4)
		document.forms[0].txt_yearto.focus();
		
		return false;
	}
	if(document.forms[0].txt_yearto.value>document.forms[0].txt_yearfrom.value && document.forms[0].sel_monthfrom.value<=document.forms[0].sel_monthto.value)
	{
		alert("Maximum 12 month data");
		return false;
	}
	return checkperiod();
}

function doRunReport()
{
	if(checkfields())
	{
	var code=document.forms[0].sel_select1.value;
	for(var i=0;i<document.forms[0].sel_select1.length;i++)
	{
		if(document.forms[0].sel_select1.options[i].selected==true)
		{
			var orgname=document.forms[0].sel_select1.options[i].text;
		}
	}
	for(var i=0;i<document.forms[0].sel_select1.options.length;i++)
	{
		if(document.forms[0].sel_select1.options[i].selected==true)
		{
			var branchname=document.forms[0].sel_select1.options[i].text;3
			break;
		}
	}
	
	 window.open(appUrl+"action/targetreportgenerated.jsp?hidBeanId=targetmaster&hidBeanMethod=getTargetDataPrint&hidBeanGetMethod=getTargetDataPrint&branchcode="+document.forms[0].sel_select1.value+"&branch="+branchname+"&frommonth="+document.forms[0].sel_monthfrom.value+"&fromyear="+document.forms[0].txt_yearfrom.value+"&tomonth="+document.forms[0].sel_monthto.value+"&toyear="+document.forms[0].txt_yearto.value,"stat","scrollbars=Yes,toolbars=No,menubar=yes ,width=1000 , height=550,top=10,left=10");
	
	}
}

function selectLevels()
{	
	for(i=0,j=1;i<document.forms[0].sel_level.options.length && document.forms[0].sel_level.options.length>2;i++)
	{
		if(document.forms[0].sel_level.options[i].text=="REGIONAL" || document.forms[0].sel_level.options[i].text=="BRANCH")
		{
			document.forms[0].sel_level.options[j].text=document.forms[0].sel_level.options[i].text;
			document.forms[0].sel_level.options[j].value=document.forms[0].sel_level.options[i].value;
			j++;
		}
	}
	if(document.forms[0].sel_level.options.length>3)
	{
		document.forms[0].sel_level.options.length=3;
	}
}

/* function showPeriod()
{
	var purl = appUrl+"action/targetdateselect.jsp";
	var title = "ListofPeriod";
	var prop = "scrollbars=no,width=350,height=320";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 320) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,title,prop);
} */

function checksize_year(obj)
{
	if(obj.value.length<4)
	{
		alert("not a valid year");
		obj.value="";
	}
}

function checkperiod()
{
	if(document.forms[0].sel_monthfrom.value>0 && document.forms[0].sel_monthto.value>0 && document.forms[0].txt_yearfrom.value.length==4 && document.forms[0].txt_yearto.value.length==4)
	{
		if((parseInt(document.forms[0].txt_yearfrom.value)>parseInt(document.forms[0].txt_yearto.value)) || ((parseInt(document.forms[0].txt_yearfrom.value)==parseInt(document.forms[0].txt_yearto.value)) && (parseInt(document.forms[0].sel_monthfrom.value)>parseInt(document.forms[0].sel_monthto.value))))
		{	
			alert("not a valid period");
			return false;
		}
		else
		{
			return true;
		}
	}
}

function checkfuturevalues()
{
	<%Calendar cal = Calendar.getInstance();%>
	var currentMonth=<%=String.valueOf(cal.get(Calendar.MONTH) + 1)%>;
	var currentYear=<%=String.valueOf(cal.get(Calendar.YEAR))%>;
	<%cal=null;%>
	if(currentMonth>3)
	{
		currentYear++;
		currentMonth=3;
	}
	
	if(document.forms[0].sel_monthfrom.value>0 && document.forms[0].txt_yearfrom.value.length==4)
	{
		if((document.forms[0].txt_yearfrom.value>currentYear) || (document.forms[0].txt_yearfrom.value==currentYear && document.forms[0].sel_monthfrom.value>currentMonth))
		{
			alert("Period cannot be in future financial year");
			document.forms[0].sel_monthfrom.value=0;
			document.forms[0].txt_yearfrom.value="";
			return;
		}
	}
	if(document.forms[0].sel_monthto.value>0 && document.forms[0].txt_yearto.value.length==4)
	{
		if((document.forms[0].txt_yearto.value>currentYear) || (document.forms[0].txt_yearto.value==currentYear && document.forms[0].sel_monthto.value>currentMonth))
		{
			alert("Period cannot be in future financial year");
			document.forms[0].sel_monthto.value=0;
			document.forms[0].txt_yearto.value="";
			return;
		}
	}
}

</script>
</head>
<body onLoad="selectValues();selectLevels()">
<form class="normal">
<iframe  height="0" width="0" id="ifrm" frameborder=0 style="border:0" ></iframe> 
<table width="100%" border="0" class="outertable">
<tr>
	<td class="page_flow">Home -&gt; Master -&gt; Target 
          Master -&gt; Target Report
	</td>
</tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
		<tr>
			<td>
				<jsp:include page="../set/mastertab.jsp" flush="true">
				<jsp:param name="tabid" value="10" />
				</jsp:include>
			</td>
		</tr>
	</table>
	<table width="100%" class="outertable">
	<tr>
	<td>
<table width="35%" border="0" cellspacing="1" cellpadding="3" class="outertable">

				<tr> 
					<td  width="50%" class="sub_tab_inactive" align="center" nowrap>
      					<b><a class="navigationLinks" href="JavaScript:gotoTab('','','targetmasterbranch.jsp')">Target Data</a></b>
      				</td>
       				<td width="50%" align="center" class="sub_tab_active" nowrap><b>Target Report</b></td>					
       			</tr>      			
     </table>
     </td>
     </tr>
     </table>

<table width="100%" border="0" class="outertable">
<tr>
<td>
	<table width="100%" border="0" class="outertable">
		<tr>
			<td valign="middle">
			<table width="50%" align="center" valign="middle" border="1" cellpadding="0" cellspacing="0" class="outertable">
			<tr>
			<td>
				<table width="100%" align="center" border="0" class="outertable">					
				<tr>
					<td>
						<table width="100%" border="0" class="outertable">
							<tr>
								<td width="50%" align="center" >
									Level
								</td>
						</table>
					</td>
					</tr> 
					<tr>
					<td>
					<table width="100%" border="0" class="outertable">
					 <tr>
						<td width="50%" align="center">
							<select name="sel_level" onChange="selectValues()">
								<option value="0"> --Select-- </option>
								<laps:reptag beanid="setupreport" methodname="getLevels" param="" />
							</select>
						</td>
					</tr>
				</table>
				</td>
				</tr> 
				<tr>
				<td >
					<table width="100%" border="0" class="outertable">
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
					<table width="100%" border="0" class="outertable">
						<tr>
							<td align="center" width="100%">
								<select name="sel_select1" size="10" style="width:250" >
								</select>
							</td>
							
						</tr>
					</table>
				</td>
				</tr>
				
				<tr>
				<td >
					<table width="100%" border="0" class="outertable">
						<tr>
							<td align="center" width="100%">
								Period
							</td>
							
						</tr>
					</table>
				</td>
				</tr>
				
				<tr>
				<td align="center">
					<table width="60%" border="0" class="outertable">
						<tr>
							<td align="center" width="45%">
								<select name="sel_monthfrom" onChange="checkperiod();checkfuturevalues()">
								<option value="0" selected>--Select--</option>
								<option value="1" >January</option>
								<option value="2">February</option>
								<option value="3">March</option>
								<option value="4">April</option>
								<option value="5">May</option>
								<option value="6">June</option>
								<option value="7">July</option>
								<option value="8">August</option>
								<option value="9">September</option>
								<option value="10">October</option>
								<option value="11">November</option>
								<option value="12">December</option>
								</select>
								&nbsp; 						
								<input type="text" name="txt_yearfrom" size="4" maxlength="4" onBlur="checksize_year(this);checkperiod();checkfuturevalues()">
							</td>
							<td align="center" width="10%">
								to
							</td>
							<td align="center" width="45%">
								<select name="sel_monthto" onChange="checkperiod();checkfuturevalues()">
								<option value="0" selected>--Select--</option>
								<option value="1">January</option>
								<option value="2">February</option>
								<option value="3">March</option>
								<option value="4">April</option>
								<option value="5">May</option>
								<option value="6">June</option>
								<option value="7">July</option>
								<option value="8">August</option>
								<option value="9">September</option>
								<option value="10">October</option>
								<option value="11">November</option>
								<option value="12">December</option>
								</select>
								&nbsp; 
								<input type="text" name="txt_yearto" size="4" maxlength="4" onBlur="checksize_year(this);checkperiod();checkfuturevalues()">
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
		</table>		
				<lapschoice:combuttonnew btnnames="Run Report"
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
			

<input type="hidden" name="hidOrgCode">
<input type="hidden" name="cmdsave" disabled>
 <lapschoice:hiddentag pageid='<%=PageId%>'/> 
</form>
</body>
</html>
