<%@ include file="../share/directives.jsp"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>

<html>
<head>
<title>Application Status Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 150;
  overflow: auto;
}

</STYLE>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/mis/per/perrepappstillopen.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<script>

var path="<%=ApplicationParams.getAppUrl()%>";
var param="";
var userid ="<%=(String)session.getAttribute("strUserId")%>";
var rights ="<%=(String)session.getAttribute("strGroupRights")%>";

function menuOptionDivMouseDown (url) {
		//if (! isMac) {
			document.currentMenu.style.display='none';
			document.currentMBarOpt.style.border='1px solid lightgrey';
			document.menuIsActive = false;
			//window.location=url;
			document.forms[0].action=url;
			document.forms[0].submit();
			//}
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
		&& document.forms[0].selloantype.selectedIndex != 0   
		&& document.forms[0].rpselect1.selectedIndex != -1 
		&& document.forms[0].txtfromamt.value !=""
		&& document.forms[0].txttoamt.value !=""
		&& document.forms[0].txtDate.value !=""
		) 
	{
  		var dt =document.forms[0].txtDate.value;	
		//if (document.forms[0].txtDate.value == "")
		//{
		//	document.forms[0].txtDate.value="All";
	//	}
 
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
			for(i=0;i<10;i++)
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
				c = c.substring(2,c.length);
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
				else if(document.forms[0].rpselect2.options[x].text=='Actual Time taken(Days)')
				{
					if(document.forms[0].cmbstatus.value=='P'||document.forms[0].cmbstatus.value=='L')
					{
					dbfields =dbfields + "No of Days Pending,";
					}
					else
					{
					dbfields =dbfields + "Actual Time taken(Days),";
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
				else if(document.forms[0].rpselect2.options[x].text=='Application with')
				{
					if(document.forms[0].cmbstatus.value=='A')
					{
					dbfields =dbfields + "Application Approved By,";
					}
					else if(document.forms[0].cmbstatus.value=='R')
					{
					dbfields =dbfields + "Application Rejected By,";
					}
					else if(document.forms[0].cmbstatus.value=='P' || document.forms[0].cmbstatus.value=='L')
					{
					dbfields =dbfields + "Application Pending with,";
					}
				}
				else
				{
				dbfields =dbfields +document.forms[0].rpselect2.options[x].text+",";
				}
				opfields =opfields +document.forms[0].rpselect2.options[x].value+",";
				
							
			}
		}
		dbfields =dbfields + "Proposal Type,";
		opfields =opfields + "app_renew_flag,";
		if (count > 0)
		{
			dbfields= dbfields.substring(0,dbfields.length-1);
			opfields= opfields.substring(0,opfields.length-1);
		}
	
	param +=opfields+";";
	param +=dbfields+";P";

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
	else if(document.forms[0].selloantype.selectedIndex == 0)
	{
		ShowAlert('111',"Loan Type");
		document.forms[0].selloantype.focus();
		return false;
	}
	else if(document.forms[0].rpselect1.selectedIndex == -1)
	{
		ShowAlert('111','Organisation');
		document.forms[0].rpselect1.focus();
		return false;
	}
	else if(document.forms[0].txtfromamt.value == "")
	{
		ShowAlert('121','From Amount');
		document.forms[0].txtfromamt.focus();
		return false;
	}
	else if(document.forms[0].txttoamt.value == "")
	{
		ShowAlert('121','To Amount');
		document.forms[0].txttoamt.focus();
		return false;
	}
	else if (document.forms[0].txtDate.value == "")
	{
	ShowAlert('121',"Period");
	document.forms[0].txtDate.focus();
	return false;
	}
	return param;
}

//-->
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>

<body>

<form name="repappstill" method="post" class="normal"><iframe height="0" width="0"
	id="ifrm" frameborder=0 style="border:0"></iframe> <br>
<table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="page_flow">Home -&gt; Retail
		-&gt;Reports -&gt;Turnaround time Report</td>
	</tr>
	<tr>
		<td align="right">&nbsp;</td>
	</tr>
</table>
<table class="outertable"  width="100%" border="1" cellspacing="0" cellpadding="20"
	height="400" >
	<tr>
		<td valign="middle">
		<div align="left">
		<table class="outertable"  border="1" cellspacing="0" cellpadding="3" align="center" width="65%">
			<tr>
				<td>
				<table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="5"
					align="center">
					<tr>
						<td width="69%" valign="top">
						<table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="3">
							<tr align="center">
								<td>Organisation Level</td>
								<td>Loan Type</td>
								<td>Process Status</td>
							</tr>
							<tr align="center">
								<td><select name="sellevel" style="width:100"
									onChange="selectValues()" tabindex="1">
									<option selected>---Select---</option>
									<laps:reptag beanid="setupreport" methodname="getLevels"
										param="" />
								</select></td>
								<td><select name="selloantype" style="width:100" tabindex="1">
									<option selected value="S">---Select---</option>
									<option value="P">Retail</option>
								</select></td>
								<td><select name="cmbstatus" style="width:100" tabindex="2">
									<option selected>---Select---</option>
									<option value="P">Pending</option>
									<option value="A">Approved</option>
									<option value="R">Rejected</option>
									<option value="L">Lodged</option>
								</select></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td width="69%" valign="top">
						<table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="5">
							<tr align="center">
								
                          <td align="center" width="96%">Select Organisation</td>
								
                          <td align="center" width="4%">&nbsp;</td>
							</tr>
							<tr align="center" >
								
                          <td width="96%"> 
                            <select name="rpselect1" size="11"
									style="width:250" tabindex="3">
								</select></td>
								
                          <td width="4%" style="visibility: hidden;"> 
                            <select name="rpselect2" size="11"
									style="width:10" multiple tabindex="4">
									<option value="app_no">Proposal Number</option>
									  <option value="perapp_fname,perapp_lname">Applicant 
                      Name</option>
									<!-- option value="app_status">Application Status</option>-->
									<option
										value="to_char(loan_receivedate,'DD/MM/YYYY') as app_createdate,to_char(inward_docreceivedon,'DD/MM/YYYY') as inward_date">Applied
									Date</option>
									<option value="loan_recmdamt as loan_recmdamt">Amount</option>
									<option
										value="to_char(app_processdate,'DD/MM/YYYY') as app_processdate,to_char(app_deldate,'DD/MM/YYYY') as app_deldate">Date</option>
									<option value="sum(prd_duration) as prd_duration">Assured
									Turnaround Time(Days)</option>
									<!--   <option value="datediff(hh,app_createdate,getdate())-sum(prd_duration) as exception_hours">Exception 
                        Hours</option>-->
									<option
										value="round(to_date(app_processdate,'dd/mm/yyyy')-to_date(loan_receivedate,'dd/mm/yyyy')) as exception_hours,
											   round(to_date(app_processdate,'dd/mm/yyyy')-to_date(INWARD_DOCRECEIVEDON,'dd/mm/yyyy'))as inwardexception_hours,
										       round(to_date(sysdate,'dd/mm/yyyy')-to_date(loan_receivedate,'dd/mm/yyyy')) as pending_hours,
										       round(to_date(sysdate,'dd/mm/yyyy')-to_date(INWARD_DOCRECEIVEDON,'dd/mm/yyyy'))as inwardpending_hours,
										       round(nvl((to_date(sysdate,'dd/mm/yyyy')-to_date(app_lodgeddate,'dd/mm/yyyy')),0))as app_lodged_hours"
										       >Actual Time taken(Days)</option>
									<option value="(case when LOAN_PERTAINS_BRANCH is not null then (case when app_orglevel='C' then (select org_name from organisations where org_scode=LOAN_PERTAINS_BRANCH) when app_orglevel='D' then (select org_name from organisations where org_scode=LOAN_PERTAINS_BRANCH) else org_name end) else organisations.org_name end )as  rorg_name">Branch</option>
									<option value="usr_lname,usr_fname">Application with</option>
									<!-- <option value="mail_toflowpoint">Current Flowpoint</option> -->
									<option value="organisations.org_name as org_name1">Office</option>
								</select></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td width="69%" valign="top">
						<table class="outertable"  width="60%" border="1" cellspacing="0" cellpadding="3"
							align="center" >
							<tr>
								<td height="37">
								<table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0"
									align="center">
									<tr>
										<td width="21%" align="center">Amont</td>
										 <td width="79%" align="center"> 
                                        <laps:CurrencyTag name="txtfromamt" maxlength="15" size="18"  tabindex="6"/> 
                                      	To &nbsp; <laps:CurrencyTag name="txttoamt" maxlength="15" size="18"  tabindex="7"/>
                                      </td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td height="37">
								<table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0"
									align="center">
									<tr>
										<td width="21%" align="center">Period</td>
										<td width="79%" align="center"><input type="text"
											name="txtDate" maxlength="21" readonly size="25"
											onFocus="document.forms[0].cmdrunreport.focus();"> <a href="#"
											onClick="showPeriod()" class="blackfont" tabindex="5">?</a>
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
		</div>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames="Run Report_Reset"
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
   <lapschoice:hiddentag pageid='<%=PageId%>'/> 
<script language="javascript">
	function disp()
	{
	  var hidValue=document.forms[0].hidOpFields.value;
	  //alert(hidValue);
	}
  </script>  <input type="hidden" name="hidOrgCode"> <input
	type="hidden" name="hidOpFields"> <input type="hidden"
	name="hidSelFields"> <input type="hidden" name="hidStatus"> <input
	type="hidden" name="userid"> <input type="hidden" name="repname"
	value="Personal Application Still Open Report"> <input type="hidden"
	name="txtprofile_name"> <input type="hidden" name="hidParam"> <input
	type="hidden" name="hidPage" value="perrunappstillopen.jsp"> <input
	type="hidden" name="txtSaveDate"
	value='<%=Helper.getCurrentDateTime()%>'>
	<input type="hidden" name="hidOrgName">
	</form>
</body>
</html>
