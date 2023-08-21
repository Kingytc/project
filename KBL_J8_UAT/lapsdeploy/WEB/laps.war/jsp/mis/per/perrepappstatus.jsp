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
<title>Application Status</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/per/perrepappstatus.js">
</script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<script>
var path="<%=ApplicationParams.getAppUrl()%>";
var param="";
var userid ="<%=(String) session.getAttribute("strUserId")%>";
var rights ="<%=(String) session.getAttribute("strGroupRights")%>";
var report = "<%=str_report%>";
function doRunReport()
{
	var param = setParam();
	var outf =document.forms[0].hidOpFields.value;
	var dbf =document.forms[0].hidSelFields.value;	 
	var code =document.forms[0].hidOrgCode.value;
	var stat =document.forms[0].hidStatus.value;
	var orglevel=document.forms[0].sellevel.value;
	var dt=document.forms[0].txtDate.value;
	var sdt=document.forms[0].txtSaveDate.value;
	var txtfromamt=document.forms[0].txtfromamt.value;
	var txttoamt=document.forms[0].txttoamt.value;
	var orgname = document.forms[0].hidOrgName.value;
	var loantype = document.forms[0].selprodtype.value;
	
	if(document.forms[0].txtfromamt.value=="")
	{
		alert("Enter From Amount");
		document.forms[0].txtfromamt.focus();
		return false;
	}
	else if(document.forms[0].txttoamt.value=="")
	{
		alert("Enter To Amount");
		document.forms[0].txttoamt.focus();
		return false;
	}
	
	else if (document.forms[0].txtDate.value == "")
	{
		ShowAlert('121',"Period");
		document.forms[0].txtDate.focus();
		return false;
	}
	
	
	if (param !="")
	{
		window.open(path+"action/perrunappstatus.jsp?hidBeanId=perrepappstatus&hidBeanMethod=getData&hidMethod=getRepDetails&hidStatus="+stat+"&txtDate="+dt+"&txtSaveDate="+sdt+"&txtfromamt="+txtfromamt+"&txttoamt="+txttoamt+"&hidOrgCode="+code+"&hidOpFields="+outf+"&hidSelFields="+dbf+"&orglevel="+orglevel+"&hidOrgName="+orgname+"&loantype="+loantype,"stat","scrollbars=Yes,toolbars=No,menubar=no ,width=750 , height=550,top=10,left=10");
	}
		
	
}

function setParam()
{


	var opfields="";
	var dbfields="";
	var orgcode="";
	var orgname="";
	var count=0;
	var org="";
	var org_name="";
	param="";
	
	if(document.forms[0].sellevel.selectedIndex != 0 
		&& document.forms[0].cmbstatus.selectedIndex != 0  
		&&	document.forms[0].rpselect1.selectedIndex != -1 
		&&	document.forms[0].selprodtype.selectedIndex != 0) 
	{
	//if (document.forms[0].txtDate.value == "")
//	{
	//	document.forms[0].txtDate.value="All";
//	}
   var dt =document.forms[0].txtDate.value;

	var stat =document.forms[0].cmbstatus.options[document.forms[0].cmbstatus.selectedIndex].value;
		

	for (i=0;i<document.forms[0].rpselect2.length;i++)
        {
			if (document.forms[0].rpselect2.options[i].selected == true)
			{
				count++;
			}		
        }
	

		if(count == 0)
		{
			for(i=0;i<=8;i++)
			{
				document.forms[0].rpselect2.options[i].selected = true;
			}
		}
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
				
		
   
    param =orgcode+";"+org+";"+stat+";"+dt+";";
	
		 count =0;
		for(x=0;x<document.forms[0].rpselect2.length;x++)
		{
			if (document.forms[0].rpselect2[x].selected)
			{
				count++;
				if(document.forms[0].rpselect2.options[x].text=='Date')
				{
					if(document.forms[0].cmbstatus.value=='A')
					{
					dbfields =dbfields + "Approved Date,";
					}
					else if(document.forms[0].cmbstatus.value=='R')
					{
					dbfields =dbfields + "Rejected Date,";
					}
					else if(document.forms[0].cmbstatus.value=='P')
					{
					dbfields =dbfields;
					}
				}
				else if(document.forms[0].rpselect2.options[x].text=='Branch')
				{
				    if(document.forms[0].sellevel.value!='A')
					{
					dbfields =dbfields + "Branch,";
					}
					else if(document.forms[0].sellevel.value=='A')
					{
					dbfields =dbfields;
					}
				}
				
				else
				{
					
					dbfields =dbfields +document.forms[0].rpselect2.options[x].text+",";
				}
					opfields =opfields +document.forms[0].rpselect2.options[x].value+",";
			}
		}
		if(document.forms[0].cmbstatus.value=='A')
		{
		dbfields =dbfields + "Approved By,";
		}
		else if(document.forms[0].cmbstatus.value=='R')
		{
		dbfields =dbfields + "Rejected By,";
		}
		else if(document.forms[0].cmbstatus.value=='P' || document.forms[0].cmbstatus.value=='L')
		{
		dbfields =dbfields + "Pending with,";
		}
		if(document.forms[0].cmbstatus.value!='L'){
		dbfields =dbfields + "Proposal Type,";
		}
		if(document.forms[0].cmbstatus.value=='A')
		{
		opfields =opfields + "usr_fname,";
		}
		else if(document.forms[0].cmbstatus.value=='R')
		{
		opfields =opfields + "usr_fname,";
		}
		else if(document.forms[0].cmbstatus.value=='P'|| document.forms[0].cmbstatus.value=='L')
		{
		opfields =opfields + "usr_fname as createdby,";
		}
		if(document.forms[0].cmbstatus.value!='L'){
		opfields =opfields + "app_renew_flag,";
		}
		if (count > 0)
		{
			dbfields= dbfields.substring(0,dbfields.length-1);
			opfields= opfields.substring(0,opfields.length-1);
		}
	param +=opfields+";";
	param +=dbfields;
	document.forms[0].hidParam.value=param;
	document.forms[0].hidOrgCode.value =org;	
	document.forms[0].hidOpFields.value =opfields;	
	document.forms[0].hidSelFields.value =dbfields;	
	document.forms[0].hidStatus.value =stat;	
	document.forms[0].hidOrgName.value =org_name;	
	}
	else if(document.forms[0].sellevel.selectedIndex == 0)
	{
		ShowAlert('111',"Organisation Level");
		document.forms[0].sellevel.focus();
		return false;
	}
	else if(document.forms[0].cmbstatus.selectedIndex == 0)
	{
		ShowAlert('111',"Process Status");
		document.forms[0].cmbstatus.focus();
		return false;
	}
	else if(document.forms[0].selprodtype.selectedIndex == 0)
	{
		ShowAlert('111','Loan Type');
		document.forms[0].selprodtype.focus();
		return false;
	}
	else if(document.forms[0].rpselect1.selectedIndex == -1)
	{
		ShowAlert('111','Organisation');
		document.forms[0].rpselect1.focus();
		return false;
	}
	
	return param;
}

</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">

</head>

<body onload="callonLoad()">
<form name="perappstat" method="post" class="normal"><iframe
	height="0" width="0" id="ifrm" frameborder=0 style="border: 0"></iframe>
<br>
<table class="outertable" width="100%" border="0" cellspacing="0"
	cellpadding="0">
	<tr>
		<td class="page_flow">Home -&gt; Retail -&gt; Reports -&gt;
		Application Status Pending / Approved / Rejected / Lodged</td>
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
								<td width="22%" align="center">Loan Type</td>
								<td width="39%" align="center">Process Status</td>
							</tr>
							<tr>
								<%
									if ("C".equals((String) request.getParameter("report"))) {
								%>
								<td width="36%" align="center"><select name="sellevel"
									style="width: 120" onChange="LoadValues()">
									<option value="" selected>---Select---</option>
									<option value="State">State</option>
									<option value="City">City</option>
									<option value="S/C">City within a State</option>
								</select></td>
								<%
									} else {
								%>
								<td width="39%" align="center"><select name="sellevel"
									style="width: 100" onChange="selectValues()" tabindex="1">
									<option selected>---Select---</option>
									<laps:reptag beanid="setupreport" methodname="getLevels"
										param="" />
								</select></td>
								<%
									}
								%>
								<td width="22%" align="center"><select name="selprodtype"
									style="width: 100" tabindex="1">
									<option selected value="S">---Select---</option>
									<option value="P">Retail</option>
								</select></td>
								<td width="39%" align="center"><select name="cmbstatus"
									style="width: 100" tabindex="2">
									<option selected>---Select---</option>
									<option value="P">Pending</option>
									<option value="A">Approved</option>
									<option value="R">Rejected</option>
									<option value="L">Lodged</option>
								</select></td>
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
								<td width="4%" style="visibility: hidden"><select
									name="rpselect2" size="11" style="width: 10" tabindex="4"
									multiple id="acctclass">
									<option value="app_no">Proposal Number</option>
									<option value="perapp_fname,perapp_lname">Applicant
									Name</option>
									<option value="loan_recmdamt as  loan_recmdamt">Amount</option>
									<option
										value="to_char(loan_receivedate,'DD/MM/YYYY') as app_date,to_char(inward_docreceivedon,'DD/MM/YYYY') as inward_date">Applied
									Date</option>
									<!--<option value="app_status">Application Status</option>-->
									<option value="cat2.cat_name,cat1.cat_name as scatname,prd_desc">Product
									Name</option>
									<option value="to_char(app_processdate,'DD/MM/YYYY') as app_processdate">Date</option>
									<option value="(case when LOAN_PERTAINS_BRANCH is not null then (case when app_orglevel='C' then (select org_name from organisations where org_scode=LOAN_PERTAINS_BRANCH) when app_orglevel='D' then (select org_name from organisations where org_scode=LOAN_PERTAINS_BRANCH) else org_name end) else organisations.org_name end )as org_name">Branch</option>
								     <!-- <option value="app_renew_flag">Proposal Type</option> -->
								   
								
								</select> <!-- <option value="convert(varchar,mail_date,103) as mail_date">Flowpoint 
                            Received Date</option>
                            <option value="wrk_flowname">Current Flowpoint Action</option>  -->
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
												<td width="21%" align="center">Period</td>
												<td width="79%" align="center">&nbsp; <input
													type="text" name="txtDate" maxlength="21" readonly
													size="27" onFocus="document.forms[0].cmdrunreport.focus();">
												<a href="#" onClick="showPeriod()" tabindex="5">?</a></td>
											</tr>
											<tr>
												<td width="21%" align="center" nowrap>Amount From</td>
												<td width="79%" align="center"><laps:CurrencyTag
													name="txtfromamt" maxlength="15" size="18" tabindex="6" />
												To &nbsp;<laps:CurrencyTag name="txttoamt" maxlength="15"
													size="18" tabindex="7" /></td>
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
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames="Run Report_Reset"
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
   <lapschoice:hiddentag pageid='<%=PageId%>'/> 
 <input	type="hidden" name="hidOrgCode"> <input type="hidden"
	name="hidOpFields"> <input type="hidden" name="hidSelFields">
<input type="hidden" name="hidStatus"> <input type="hidden"
	name="userid"> <input type="hidden" name="repname"
	value="Personal Application Status Report"> <input
	type="hidden" name="txtprofile_name"> <input type="hidden"
	name="hidParam"> <input type="hidden" name="hidPage"
	value="perrunappstatus.jsp"> <input type="hidden"
	name="hidusr_id"> <input type="hidden" name="txtSaveDate"
	value='<%=Helper.getCurrentDateTime()%>'> <input type="hidden"
	name="hidOrgName"></form>
</body>
</html>
