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

<% ArrayList ArrRow=new ArrayList();
ArrayList ArrCol=new ArrayList();
ArrRow=(ArrayList)hshValues.get("ArrValues");
ArrayList ArrSolRow=(ArrayList)hshValues.get("ArrRow");
ArrayList ArrKpowRow=(ArrayList)hshValues.get("ArrKpowerRow");
int arrsize=0,arrSolsize=0,arrKpowersize=0;
if(ArrRow !=null)
{
	arrsize=ArrRow.size();
}
if(ArrSolRow!=null)
arrSolsize=ArrSolRow.size();
if(ArrKpowRow!=null)
	arrKpowersize=ArrKpowRow.size();
java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
jtn.setMaximumFractionDigits(2);
jtn.setMinimumFractionDigits(2);
jtn.setGroupingUsed(false);
%>

<html>
<head>
<title>CGTMSER</title>

<script>
var path="<%=ApplicationParams.getAppUrl()%>";
var param="";
var userid ="<%=(String) session.getAttribute("strUserId")%>";
var rights ="<%=(String) session.getAttribute("strGroupRights")%>";
var report = "<%=str_report%>";
//alert(report);
</script>
<script>
	function callonLoad()
	{
			document.forms[0].hidBeanId.value="perrepappstatus";
			if(report=='C')
			{
			document.all.state.style.visibility="hidden";
			document.all.state.style.position="absolute";
			}

	}

	function selectValues()
	{
		document.forms[0].rpselect1.selectedIndex =-1;
		var bnkname = document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].value;
		document.all.ifrm.src=path+"action/iframeapprep.jsp?hidBeanMethod=getData&hidMethod=getOrgnames&hidBeanId=repappper&bnklevel="+bnkname;
	}
	function enabledept()
	{
		var reportType = document.forms[0].report.value;
		if(reportType=="CGTMSEEnhancement")
		{
			document.all.hiddesignaion1.style.visibility="hidden";
			document.all.hiddesignaion1.style.position="absolute";
			
			document.all.hiddept1.style.visibility="hidden";
			document.all.hiddept1.style.position="absolute";
			
			document.all.hiddept.style.visibility="hidden";
			document.all.hiddept.style.position="absolute";
			
			document.all.hiddesignaion.style.visibility="hidden";
			document.all.hiddesignaion.style.position="absolute";
		}
		else{
			var orglevel = document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].value;
		if(orglevel=="C")
		{
			document.all.hiddept.style.visibility="visible";
			document.all.hiddept.style.position="relative";
			document.all.hiddept1.style.visibility="visible";
			document.all.hiddept1.style.position="relative";
		}else{
			document.all.hiddept.style.visibility="hidden";
			document.all.hiddept.style.position="absolute";
			document.all.hiddept1.style.visibility="hidden";
			document.all.hiddept1.style.position="absolute";
		}
		if(orglevel!="A" && orglevel!="")
		{
			document.all.hiddesignaion.style.visibility="hidden";
			document.all.hiddesignaion.style.position="absolute";
			document.all.hiddesignaion1.style.visibility="hidden";
			document.all.hiddesignaion1.style.position="absolute";
		}else{
			document.all.hiddesignaion.style.visibility="hidden";
			document.all.hiddesignaion.style.position="absolute";
			document.all.hiddesignaion1.style.visibility="hidden";
			document.all.hiddesignaion1.style.position="absolute";
		}
		
		var varsancdept="";
		if(orglevel=="R")
		{
			varsancdept="006";
		}
		else if(orglevel=="C")
		{
			if(document.forms[0].seldepartment.value=="S")
			{
				alert("Select Department");
				document.forms[0].seldepartment.focus();
				return;
			}
			if(document.forms[0].seldepartment.value=="001")
				varsancdept="008";
			else if(document.forms[0].seldepartment.value=="002")
				varsancdept="010";
			else if(document.forms[0].seldepartment.value=="009")
				varsancdept="013";
			else if(document.forms[0].seldepartment.value=="010")
				varsancdept="014";
			else
				varsancdept="000";
		}
		else if(orglevel=="CPC")
			varsancdept="011";
		else if(orglevel=="A")
			varsancdept="007";
		else if(orglevel=="D")
			varsancdept="012";
		document.all.ifrmsancauthority.src=appURL+"action/iframedesignauthority.jsp?hidBeanGetMethod=getSancAuthority&hidBeanId=comproposal&sancdept="+varsancdept;
		
		}

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
		
		var fromdt=document.forms[0].txtFromDate.value;
		var todt=document.forms[0].txtToDate.value;
		var sdt=document.forms[0].txtSaveDate.value;
		var orgname = document.forms[0].hidOrgName.value;
		var vardepartment=document.forms[0].seldepartment.value;
		var vardesignation=document.forms[0].seldesignaion.value;
		var reportType = document.forms[0].report.value;
		
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
		if(document.forms[0].txtFromDate.value=="")
		{
			ShowAlert('111','From Date');
			document.forms[0].txtFromDate.focus();
			return;
		}
		if(document.forms[0].txtToDate.value=="")
		{
			ShowAlert('111','To Date');
			document.forms[0].txtToDate.focus();
			return;
		}
		//alert(document.forms[0].rpselect1.value);
		if(report=="enchancement"){
			var prop = "scrollbars=yes,width=1100,height=700,top=25,left=180";
			var url=appURL+"action/cgtmse_Enhancement_run_report.jsp?hidBeanId=perrepappstatus&hidBeanMethod=getData&hidMethod=getCGTMSEReport&txtFromDate="+fromdt+"&txtToDate="+todt+"&txtSaveDate="+sdt+"&hidOrgCode="+code+"&orglevel="+orglevel+"&report="+report+"&hidOrgName="+orgname+"&seldepartment="+vardepartment+"&seldesignation="+vardesignation;
			window.open(url,"CGTMSE_Enhancement",prop);
			}
		else if(report=="guarant_rep"){
			var prop = "scrollbars=yes,width=1100,height=700,top=25,left=180";
			var url=appURL+"action/cgtmse_Enhancement_run_report.jsp?hidBeanId=perrepappstatus&hidBeanMethod=getData&hidMethod=getCGTMSEReport&txtFromDate="+fromdt+"&txtToDate="+todt+"&txtSaveDate="+sdt+"&hidOrgCode="+code+"&orglevel="+orglevel+"&report="+report+"&hidOrgName="+orgname+"&seldepartment="+vardepartment+"&seldesignation="+vardesignation;
			window.open(url,"CGTMSE_Enhancement",prop);
			}
		else if(report=="register_rep"){
			var prop = "scrollbars=yes,width=1100,height=700,top=25,left=180";
			var url=appURL+"action/cgtmse_Enhancement_run_report.jsp?hidBeanId=perrepappstatus&hidBeanMethod=getData&hidMethod=getCGTMSEReport&txtFromDate="+fromdt+"&txtToDate="+todt+"&txtSaveDate="+sdt+"&hidOrgCode="+code+"&orglevel="+orglevel+"&report="+report+"&hidOrgName="+orgname+"&seldepartment="+vardepartment+"&seldesignation="+vardesignation;
			window.open(url,"CGTMSE_Enhancement",prop);
			}
		else if(report=="od"){
			var prop = "scrollbars=yes,width=1100,height=700,top=25,left=180";
			var url=appURL+"action/cgtmse_Enhancement_run_report.jsp?hidBeanId=perrepappstatus&hidBeanMethod=getData&hidMethod=getCGTMSEReport&txtFromDate="+fromdt+"&txtToDate="+todt+"&txtSaveDate="+sdt+"&hidOrgCode="+code+"&orglevel="+orglevel+"&report="+report+"&hidOrgName="+orgname+"&seldepartment="+vardepartment+"&seldesignation="+vardesignation;
			window.open(url,"CGTMSE_Enhancement",prop);
			}
		else if(report=="ca"){
			var prop = "scrollbars=yes,width=1100,height=700,top=25,left=180";
			var url=appURL+"action/cgtmse_Enhancement_run_report.jsp?hidBeanId=perrepappstatus&hidBeanMethod=getData&hidMethod=getCGTMSEReport&txtFromDate="+fromdt+"&txtToDate="+todt+"&txtSaveDate="+sdt+"&hidOrgCode="+code+"&orglevel="+orglevel+"&report="+report+"&hidOrgName="+orgname+"&seldepartment="+vardepartment+"&seldesignation="+vardesignation;
			window.open(url,"CGTMSE_Ac",prop);
			}
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
			var fromdt =document.forms[0].txtFromDate.value;
			var todt =document.forms[0].txtToDate.value;
			
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
	function doExcelExport()
	{
		var param = setParam();
		var code =document.forms[0].hidOrgCode.value;
		var orglevel=document.forms[0].sellevel.value;
		
		var fromdt=document.forms[0].txtFromDate.value;
		var todt=document.forms[0].txtToDate.value;
		var sdt=document.forms[0].txtSaveDate.value;
		var orgname = document.forms[0].hidOrgName.value;
		var vardepartment=document.forms[0].seldepartment.value;
		var vardesignation=document.forms[0].seldesignaion.value;
		var reportType = document.forms[0].report.value;
		//alert(reportType);
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
		if(document.forms[0].txtFromDate.value=="")
		{
			ShowAlert('111','From Date');
			document.forms[0].txtFromDate.focus();
			return;
		}
		if(document.forms[0].txtToDate.value=="")
		{
			ShowAlert('111','To Date');
			document.forms[0].txtToDate.focus();
			return;
		}
		if (report=="enchancement")
		{
			var FileName='EnchancementExcelReport';
			var prop="scrollbars=no,menubar=no,width=1400, height=650, top=10, left=10";
	      window.open(path+"action/"+FileName+".xls?hidBeanId=perrepappstatus&hidBeanMethod=getData&hidMethod=getCGTMSEExcel&txtFromDate="+fromdt+"&txtToDate="+todt+"&txtSaveDate="+sdt+"&hidOrgCode="+code+"&orglevel="+orglevel+"&report="+report+"&hidOrgName="+orgname+"&seldepartment="+vardepartment+"&seldesignation="+vardesignation,"BuilderReport",prop);    	
		}
		else if(report=="od"){
			var FileName='ODExcelReport';
			var prop="scrollbars=yes,menubar=yes,width=1400, height=650, top=10, left=10";
	      window.open(path+"action/"+FileName+".xls?hidBeanId=perrepappstatus&hidBeanMethod=getData&hidMethod=getCGTMSEExcel&txtFromDate="+fromdt+"&txtToDate="+todt+"&txtSaveDate="+sdt+"&hidOrgCode="+code+"&orglevel="+orglevel+"&report="+report+"&hidOrgName="+orgname+"&seldepartment="+vardepartment+"&seldesignation="+vardesignation,"BuilderReport",prop);    	
			
		}
		else if(report=="register_rep"){
			var FileName='CreditSaleExcelReport';
			var prop="scrollbars=yes,menubar=yes,width=1400, height=650, top=10, left=10";
		    window.open(path+"action/"+FileName+".xls?hidBeanId=perrepappstatus&hidBeanMethod=getData&hidMethod=getCGTMSEExcel&txtFromDate="+fromdt+"&txtToDate="+todt+"&txtSaveDate="+sdt+"&hidOrgCode="+code+"&orglevel="+orglevel+"&report="+report+"&hidOrgName="+orgname+"&seldepartment="+vardepartment+"&seldesignation="+vardesignation,"BuilderReport",prop);    	
		}
		
		else if(report=="guarant_rep"){
			var FileName='GuaranteedReport';
			var prop="scrollbars=yes,menubar=yes,width=1400, height=650, top=10, left=10";
		    window.open(path+"action/"+FileName+".xls?hidBeanId=perrepappstatus&hidBeanMethod=getData&hidMethod=getCGTMSEExcel&txtFromDate="+fromdt+"&txtToDate="+todt+"&txtSaveDate="+sdt+"&hidOrgCode="+code+"&orglevel="+orglevel+"&report="+report+"&hidOrgName="+orgname+"&seldepartment="+vardepartment+"&seldesignation="+vardesignation,"BuilderReport",prop);    	
		}
		else if(report=="ca"){
			var FileName='CAExcelReport';
			var prop="scrollbars=yes,menubar=yes,width=1400, height=650, top=10, left=10";
	      window.open(path+"action/"+FileName+".xls?hidBeanId=perrepappstatus&hidBeanMethod=getData&hidMethod=getCGTMSEExcel&txtFromDate="+fromdt+"&txtToDate="+todt+"&txtSaveDate="+sdt+"&hidOrgCode="+code+"&orglevel="+orglevel+"&report="+report+"&hidOrgName="+orgname+"&seldepartment="+vardepartment+"&seldesignation="+vardesignation,"BuilderReport",prop);    	
			
		}
	}
	function doReset()
	{
		document.forms[0].sellevel.options[0].selected =true;
		document.forms[0].rpselect1.length =0;
		document.forms[0].txtFromDate.value="";
		document.forms[0].txtToDate.value="";
		document.forms[0].seldepartment.value="S";
		document.forms[0].seldesignaion.value="S";

	}
	function doClose()
	{
		if (ConfirmMsg("100"))
		{
		document.forms[0].hidBeanId.disabled=true;
		document.forms[0].action=path+"action/comrepappnav.jsp?hidreportmis=CGTMSE";
		document.forms[0].submit();
		}
	}
	function callCalender(cmdname) {
			showCal(appURL, cmdname);
	}
</script>	
</head>
<body onload="callonLoad();enabledept();">
<form name="perappstat" method="post" class="normal"><iframe
	height="0" width="0" id="ifrm" frameborder=0 style="border: 0"></iframe>
<br>
<table class="outertable" width="100%" border="0" cellspacing="0"
	cellpadding="0">
	<tr>
		<td class="page_flow">Home  -&gt; Reports -&gt;
		CGTMSE Reports </td>
	</tr>
	<tr>
		<td align="right">&nbsp;</td>
	</tr>
</table>
<table class="outertable" width="100%" border="0" cellspacing="0"
	cellpadding="20">
	<tr>
		<td valign="middle">
		<table class="outertable border1" border="0" cellspacing="0" cellpadding="3"
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
								<td width="39%" align="center" id="hiddept">Department</td>
								<td width="39%" align="center" id="hiddesignaion">Designation</td>
							</tr>
							<tr>
								
								<td width="39%" align="center"><select name="sellevel"
									style="width: 100px;" onChange="selectValues();enabledept();" tabindex="1">
									<option selected>---Select---</option>
									<laps:reptag beanid="setupreport" methodname="getOrgLevels"
										param="" />
								</select></td>
								<td width="39%" align="center" id="hiddept1"><select name="seldepartment"
									style="width: 125px;" onchange="enabledept();">
									<option value="S"><-- Select --> </option>
                          				<lapschoice:CBSStaticDataNewTag apptype="20" /></td>
								<td width="39%" align="center" id="hiddesignaion1"><select name="seldesignaion"
									style="width: 200px">
									<option value="S"><-- Select --> </option>
									<lapschoice:CBSStaticDataNewTag apptype="15"/>
							</tr>
							<%
								if ("C".equals((String) request.getParameter("report"))) {
							%>
							<tr id="state">
								<td width="36%" align="center" height="35"><select
									name="sel_state" onchange="LoadcityValues()">
									<option value="0" selected>--Select--</option>
									<laps:stateflexmaster />
								</select></td>
							</tr>
							<%
								}
							%>
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
					<tr align="center">
								<td align="center" colspan="2">
								<table class="outertable border1" width="69%" border="0" cellspacing="0"
									cellpadding="3" align="center">
									<tr>
										<td>
										<table class="outertable" width="100%" border="0"
											cellspacing="0" cellpadding="0" align="center">
											<tr>
												<td width="35%" align="center">Period From</td>
												<td width="20%" align="center">&nbsp; <input
													type="text" name="txtFromDate" maxlength="21" readonly
													size="20" onBlur="checkDate(this);checkmaxdate(this,currentDate);checkmaxdate(this,document.forms[0].txtToDate.value);">&nbsp;
													<a alt="Select date from calender" href="#"
																	onClick="callCalender('txtFromDate')"
																	onMouseOver="window.status='Date Picker';return true;"
																	onMouseOut="window.status='';return true;"><img
																	src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
																	border="0" alt="Select date from calender"
																	tabindex="29"></a></td>
													<td width="21%" align="center">To</td>
												<td width="20%" align="center">&nbsp; <input
													type="text" name="txtToDate" maxlength="21" readonly
													size="20" onBlur="checkDate(this);checkmaxdate(this,currentDate);checkmindate(this,document.forms[0].txtFromDate.value);">&nbsp;
													<a alt="Select date from calender" href="#"
																	onClick="callCalender('txtToDate')"
																	onMouseOver="window.status='Date Picker';return true;"
																	onMouseOut="window.status='';return true;"><img
																	src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
																	border="0" alt="Select date from calender"
																	tabindex="29"></a></td>
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
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames="Run Report_Excel Export_Reset" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
 <input	type="hidden" name="hidOrgCode"> 
 <input type="hidden"
	name="userid">  <input type="hidden"
	name="hidusr_id"> <input type="hidden" name="txtSaveDate"
	value='<%=Helper.getCurrentDateTime()%>'> <input type="hidden"
	name="hidOrgName">
	<iframe height="0" width="0" name="ifrmsancauthority" frameborder="0" style="border:0"></iframe>
	<input type="hidden" name="CGTMSEEnhancement">
	<input type="hidden" name="ODWithReduction">
	<input	type="hidden" name="report" value="<%=str_report %>"> 
	</form>
</body>
</html>
