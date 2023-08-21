<%@include file="../share/directives.jsp"%>
<%ArrayList arrRow = new ArrayList();
			ArrayList arrCol = null;
			ArrayList arrCol1 = null;
			String stryear = Helper.correctNull((String) request.getParameter("mon_year"));
			if (!stryear.equalsIgnoreCase("")) {
				stryear = Helper.correctNull((String) hshValues.get("mon_year"));
			}
			String strmonth = Helper.correctNull((String) request.getParameter("mon_month"));

			if (!strmonth.equalsIgnoreCase("")) {
				strmonth = Helper.correctNull((String) hshValues.get("mon_month"));
			}%>
<html>
<head>
<title>Annexure</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js" type="text/javascript"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function placevalues()
{
	showNom();		
	disableFields(true);	
}
function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,name);
		
	}
}
function showNom()
{

  if(document.forms[0].category[1].checked==true)
  {
         document.all["facadhoc"].style.visibility="visible";
        
  }
  else
  {
		document.all["facadhoc"].style.visibility="hidden";
		 document.forms[0].txt_adhocdate.value="";
  }

}
function doEdit()
{ 	
	if(document.forms[0].headSno.value!="")
	{	
		document.forms[0].hidAction.value ="update";
		disableFields(false);
		disableCommandButtons(true,true,false,false,false,false);
		if(document.forms[0].checkbox.checked==true)
		{
			document.forms[0].factype.value="sublimit"
		}
		else
		{
			document.forms[0].factype.value="facility";
		}
	}
	else
	{
		 ShowAlert(111,'facility');
	}	
}
function doSave()
{	
	
	if(document.forms[0].checkbox.checked==false)
	{
		if(document.forms[0].facility_head.value=="-")
		{
			alert("Select Facility Head");
			return;
		}
		if(document.forms[0].facility.value=="-")
		{
			alert("Select Facility");
			return;
		}	
		if(document.forms[0].txt_exist_limit.value=="")
		{
			alert("Amount of Limit for Facilty cannot be empty")
		}
		
	}	
	else
	{
		if(document.forms[0].facility_head.value=="-")
		{
			alert("Select Facility Head");
			return;
		}
		if(document.forms[0].facility.value=="-")
		{
			alert("Select Facility");
			return;
		}	
		if(document.forms[0].txt_exist_limit.value=="")
		{
			alert("Amount of Limit for Facilty cannot be empty");
				return;
		}		
		if(document.forms[0].subfacility_head.value=="-")
		{
			alert("Select Sub Limit Head");
			return;
		}
		if(document.forms[0].subfacility.value=="-")
		{
			alert("Select Sub Limit");
			return;
		}	
		if(document.forms[0].txt_subexist_limit.value=="")
		{
			alert("Amount of Limit for Sub Limit cannot be empty")
			return;
		}
		if(eval(document.forms[0].txt_subexist_limit.value) > eval(document.forms[0].txt_exist_limit.value))
		{
			alert("The Sublimit 'Amount of Limit' exceeds the Parent facility 'Amount of Limit'");
			return;
		}
	}
	disableFields(false);
	document.forms[0].hidBeanId.value="mmrcommon";
	document.forms[0].hidSourceUrl.value="/action/monannexurefacilities.jsp";
	document.forms[0].hidBeanMethod.value="updateAnnexureFacility";
	document.forms[0].hidBeanGetMethod.value="getAnnexureFacility";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();	
}

function doPrint()
{
	var purl ="<%=ApplicationParams.getAppUrl()%>action/annexuremmrprint.jsp?hidBeanGetMethod=getAnnexureFacility&hidBeanId=mmrcommon&cbsid="+document.forms[0].hidcbsid.value+"&mon_year="+document.forms[0].strYear.value+"&mon_month=<%=strmonth%>&strcbsname="+document.forms[0].strcbsname.value+"&checkPrint=yes"+"&mmrno="+document.forms[0].mmrno.value;
	var prop = 'scrollbars=yes,menubar=yes,width=750,height=520';	
	var xpos = (screen.width - 750) / 2;
	var ypos = (screen.height - 520) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'title',prop);
}

function selectSublimit()
{
	if(document.forms[0].checkbox.checked==false)
	{
		alert("Check sublimit option");
		document.forms[0].subfacility_head.selectedIndex=0;
 		return;
	}
}

function selectValues(val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11)
{
	for(k=0;k<document.forms[0].facility_head.length;k++)
	{
		arr = document.forms[0].facility_head.options[k].value.split("-");
		if(arr!=null)
		{
			if(arr[0]==val1)
			{
				document.forms[0].facility_head.options[k].selected=true;
				break;
			}
		}
	}
	
	if(val1!="")
	{	
		document.all.ifrm1.src=appURL+"action/iframefacility.jsp?hidBeanId=facilitymaster&parent="+val1+"&value=subsel&hidMethod=getFacility&factid="+val2+"&strtype=facility";
	}	
	document.forms[0].txt_exist_limit.value=val3;
	document.forms[0].txt_dp.value=val4;
	document.forms[0].txt_outstanding.value=val5;
	document.forms[0].txt_overdue.value=val6;
	document.forms[0].txt_desc.value=val7;
	document.forms[0].headSno.value=val8;
	document.forms[0].txt_adhocdate.value=val10;
	document.forms[0].hidgrpno.value=val11;
	
	document.forms[0].hidsublimitno.value=document.forms[0].elements["sublimitno"+val8].value
	if(document.forms[0].btnenable.value=="Y")
	{
		disableFields(true);
		disableCommandButtons(false,false,true,false,false,false);
	}
		
	document.forms[0].subfacility_head.selectedIndex=0;
	document.forms[0].subfacility.length=1;
	document.forms[0].subfacility.selectedIndex=0;
	document.forms[0].txt_subexist_limit.value="";
	document.forms[0].txt_sub_dp.value="";
	document.forms[0].txt_sub_outstanding.value="";
	document.forms[0].txt_sub_overdue.value="";
	document.forms[0].txt_remarks.value="";
	document.forms[0].checkbox.checked=false;
	document.forms[0].factype.value="facility";
	if(val9=="a")
	{
		document.forms[0].category[1].checked=true;
	}
	else
	{
		document.forms[0].category[0].checked=true;
	}
	showNom();
}	

function selectValues1(val1,val2,val3,val4,val5,val6,val7,val8,val9)
{
	for(k=0;k<document.forms[0].subfacility_head.length;k++)
	{
		arr = document.forms[0].subfacility_head.options[k].value.split("-");
		if(arr!=null)
		{
			if(arr[0]==val1)
			{
				document.forms[0].subfacility_head.options[k].selected=true;
				break;
			}
		}
	}
	
	if(val1!="")
	{	
		document.all.ifrm2.src=appURL+"action/iframefacility.jsp?hidBeanId=facilitymaster&parent="+val1+"&value=subsel&hidMethod=getFacility&factid="+val2+"&strtype=sublimit";
	}
	document.forms[0].checkbox.checked = true;
	document.forms[0].txt_subexist_limit.value=val3;
	document.forms[0].txt_sub_dp.value=val4;
	document.forms[0].txt_sub_outstanding.value=val5;
	document.forms[0].txt_sub_overdue.value=val6;
	document.forms[0].txt_remarks.value=val7;
	document.forms[0].subLimitSno.value=val8;
	document.forms[0].factype.value="sublimit";
	document.forms[0].hidgrpno.value=val9;
	document.forms[0].cmdnew.disabled =true;
	if(document.forms[0].statusflag.value=="O" && document.forms[0].readFlag.value.toUpperCase()=="W")
	{
		disableFields(true);
		disableCommandButtons(true,false,true,false,false,false);
	}	
}

function doDelete()
{	
	var factype="";	
	if(document.forms[0].checkbox.checked==true)
	{
		document.forms[0].factype.value ="sublimit";
		factype="sublimit"
	}
	else
	{
		document.forms[0].factype.value ="facility";
		factype="facility"
	}
	if((factype=="facility") && (document.forms[0].headSno.value==""))
	{
		ShowAlert(111,'facility');	
		return;
	}
	else if((factype=="sublimit") && (document.forms[0].subLimitSno.value==""))
	{
		ShowAlert(111,'Sub-limit');	
		return;
	}	
	if(factype=="facility")
	{
		if(document.forms[0].hidsublimitno.value!="0")
		{
			alert("You can't delete the facility, sub-limit exists");
			return;
		}
	}
	if(ConfirmMsg(101))
	{		
		document.forms[0].hidAction.value="delete";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].hidSourceUrl.value="/action/monannexurefacilities.jsp";
		document.forms[0].hidBeanMethod.value="updateAnnexureFacility";
		document.forms[0].hidBeanGetMethod.value="getAnnexureFacility";	
		document.forms[0].submit();
	}
}
 function doNew()
  {	
	  disableFields(false);
	  document.forms[0].hidAction.value ="insert";
	  document.forms[0].cmdnew.disabled=true;
	  document.forms[0].cmdedit.disabled=true;
	  document.forms[0].cmddelete.disabled=true;
	  document.forms[0].cmdsave.disabled=false;
	  document.forms[0].cmdcancel.disabled=false;
	  document.forms[0].cmdclose.disabled=true;
	  
	  if(document.forms[0].checkbox.checked==true)
		{
			document.forms[0].factype.value="sublimit"
		}
		else
		{
			document.forms[0].factype.value="facility";
		}
	  
	  if(document.forms[0].checkbox.checked==true)
	  {
	  		document.forms[0].subfacility_head.selectedIndex=0;
			document.forms[0].subfacility.length=1;
			document.forms[0].subfacility.selectedIndex=0;
			document.forms[0].txt_subexist_limit.value="";
			document.forms[0].txt_sub_dp.value="";
			document.forms[0].txt_sub_outstanding.value="";
			document.forms[0].txt_sub_overdue.value="";
			document.forms[0].txt_remarks.value="";
			if(document.forms[0].headSno.value=="")
			{
				document.forms[0].checkSublimit.value="yes";
			}
	  }
	  else
	  {
			document.forms[0].facility_head.selectedIndex=0;
			document.forms[0].facility.length=1;
			document.forms[0].facility.selectedIndex=0;
			document.forms[0].txt_exist_limit.value="";
			document.forms[0].txt_dp.value="";
			document.forms[0].txt_outstanding.value="";
			document.forms[0].txt_overdue.value="";
			document.forms[0].txt_desc.value="";
			
			document.forms[0].subfacility_head.selectedIndex=0;
			document.forms[0].subfacility.length=1;
			document.forms[0].subfacility.selectedIndex=0;
			document.forms[0].txt_subexist_limit.value="";
			document.forms[0].txt_sub_dp.value="";
			document.forms[0].txt_sub_outstanding.value="";
			document.forms[0].txt_sub_overdue.value="";
			document.forms[0].txt_remarks.value="";
			document.forms[0].checkSublimit.value="yes";
	 }
   }   
   function findtype()
{
	var hidAction = document.forms[0].hidAction.value;
	var subno=0;
	var factype =document.forms[0].factype.value;
	
	if(document.forms[0].cmdnew.disabled==true)
	{
		if(document.forms[0].checkbox.checked==true)
		{
			document.forms[0].checkbox.checked=false;
			alert("Can't check in edit mode or add mode");			
			return;
		}
	}
	if((document.forms[0].cmdedit.disabled==true) && (hidAction=="update") && (factype=="sublimit"))
	{
		alert("Can't uncheck");
		document.forms[0].checkbox.checked=true;
		return;
	}
	 else if((document.forms[0].factype.value=="sublimit"))
	 {
		alert("Can't uncheck,because sub-limit exists");
		document.forms[0].checkbox.checked=true;
		return;
	 }

	if(document.forms[0].checkbox.checked==true)
	{
		document.forms[0].cmdedit.disabled=true;
	}
	else
	{
		document.forms[0].cmdedit.disabled=false;
	}
}
  function doCancel()
  {
	var factype = document.forms[0].factype.value;
	var hidAction = document.forms[0].hidAction.value;
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].hidSourceUrl.value="/action/monannexurefacilities.jsp";
		document.forms[0].hidBeanGetMethod.value="getAnnexureFacility";
		document.forms[0].action=appURL+"action/monannexurefacilities.jsp";	
		document.forms[0].submit();		
	}
  }
function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}
}
function disableCommandButtons(cmdnew,cmdedit,cmdsave,cmdcancel,cmddelete,cmdclose)
{
		document.forms[0].cmdnew.disabled=cmdnew;
		document.forms[0].cmdedit.disabled=cmdedit;
		document.forms[0].cmdsave.disabled=cmdsave;
		document.forms[0].cmdcancel.disabled=cmdcancel;
		document.forms[0].cmddelete.disabled=cmddelete;
		document.forms[0].cmdclose.disabled=cmdclose;	
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
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].disabled=val;
		}		
	}	
}
function callLink(page,bean,method)
{
	 if (document.forms[0].cmdsave.disabled)
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
function getFacility(strtype)
{	
	if(strtype=="facility")
	{
		document.forms[0].hidGrpList.value="";
		arr1=document.forms[0].facility_head.value.split("~");		
		var facilityhead = document.forms[0].elements["facility_head"].value;		
		arr = facilityhead.split("-");		
		var parentparam =arr[0];
		if(parentparam)
		{	document.all.ifrm1.src=appURL+"action/iframefacility.jsp?hidBeanId=facilitymaster&parent="+parentparam+"&value=subsel&hidMethod=getFacility&strtype=facility";
		}
	}
	else if(strtype=="sublimit")
	{		
		var subfacilityhead = document.forms[0].elements["subfacility_head"].value;
		arr = subfacilityhead.split("-");
		var parentparam =arr[0];			
		if(parentparam)
		{
		document.all.ifrm1.src=appURL+"action/iframefacility.jsp?hidBeanId=facilitymaster&parent="+parentparam+"&value=subsel&hidMethod=getFacility&strtype=sublimit";
		}
		else
		{			
			document.forms[0].subfacility.length=1;
			document.forms[0].subfacility.selectedIndex=1;
		}
	} 
	return true;
 }
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="placevalues()">
<form name="facility" method="post" action="" class="normal">
<lapschoice:monthlymonitortag pageid="1" />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Monitoring-&gt; Monthly Monitoring Reports-&gt; Facilities Enjoyed-&gt; Annexure</td>
	</tr>
</table>
<lapschoice:MonthlyMonitor />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	<tr>
		<td width="50%" valign="bottom">
		<table width="60%" border="0" cellspacing="1" cellpadding="3" class="outertable">
			<tr align="center">
				<td width="20%" class="sub_tab_inactive"><b><a href="javascript:callLink('mon_facilitiesenjoyed.jsp','mmrcommon','getMMRFacility')">Facilities Enjoyed </a></b></td>
				<td width="20%" id="action" class="sub_tab_inactive"><b><a href="javascript:callLink('reasons_excess.jsp','mmrcommon','getReasonsExcessData')">Reasons for excess </a></b></td>
				<td width="20%" id="action" class="sub_tab_active"><b>Annexure</b></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
				<td width="2%"><input type="radio" name="category"
					style="border-style:none" value="r" checked="checked" onClick="showNom();"></td>
				<td width="64%">Main Limit</td>
				<td width="2%"><input type="radio" name="category"
					style="border-style:none" value="a" onClick="showNom()"></td>
				<td width="2%">Adhoc</td>
				<td width="30%">
				<table width="80%" id="facadhoc">
					<tr>
						<td width="31%">Valid upto</td>
						<td width="34%"><input type="text" name="txt_adhocdate"
							tabindex="16" value="" size="15" maxlength="10"></td>
						<td width="35%">&nbsp;<a alt="Select date from calender"
							href="javascript:callCalender('txt_adhocdate')"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1" >
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
					<tr>
						<td width="14%">Facility Head</td>						
                  <td width="49%"> 
                    <%HashMap hp1 = new HashMap();%>
                    <select
							name="facility_head"
							onChange="javascript:getFacility('facility')">
							<option selected="selected" value="-">----Select----</option>
							<%HashMap h = new HashMap();
			h.put("value", "parent");
			h.put("parent", "0");
			h.put("hidMethod", "getFacility");

			hp1 = new HashMap();
			hp1.put("BeanId", "facilitymaster");
			hp1.put("MethodName", "getData");
			hp1.put("BeanParam", h);%>
							<lapschoice:selecttag value='<%= hp1%>' />
						</select> <input type="hidden" name="hid_facility_head"></td>						
                  <td width="10%">Facility</td>
						<td width="27%">
						<select name="facility">
							<option value="0" selected="selected">----Select----</option>
						</select> <input type="hidden" name="hid_facility">
                  </td>
					</tr>
					<tr>
						<td width="14%">Amount of Limit</td>
						<td width="49%"><lapschoice:CurrencyTag
							name="txt_exist_limit" size="16"
							onBlur="javascript:roundtxt(this)" value=''
							onKeyPress="allowNumber(this)" maxlength="15"
							style="text-align:right" /></td>
						<td width="10%">D.P.</td>
						<td width="27%"><lapschoice:CurrencyTag
							name="txt_dp" size="16" value='' maxlength="15"
							style="text-align:right" /> <input type="hidden"
							name="hidproposed" value=''></td>
					</tr>
					<tr>
						<td width="14%" nowrap="nowrap">Outstanding</td>

						<td width="49%"><lapschoice:CurrencyTag
							name="txt_outstanding" value='' size="16" maxlength="15"
							style="text-align:right" /></td>
						<td width="10%" nowrap="nowrap">Excess / Overdue</td>

						<td width="27%"><lapschoice:CurrencyTag
							name="txt_overdue" value='' size="16"
							onKeyPress="allowNumber(this)" maxlength="15"
							style="text-align:right" /></td>
					</tr>
					<tr>
						<td width="14%" nowrap="nowrap">Remarks</td>
						<td width="49%"><textarea
							name="txt_desc" wrap="VIRTUAL" cols="40"><%=Helper.correctNull((String) hshValues.get("facdesc"))%></textarea>
						</td>
						<td width="10%" nowrap="nowrap">&nbsp;</td>
						<td width="27%">&nbsp;</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="1" cellpadding="1" class="outertable">
					<tr valign="middle">
						<td colspan="4">Sub - Limits
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="checkbox"
							name="checkbox" value="checkbox" style="border-style:none"
							onClick="javascript:findtype()">
                  </td>
					</tr>
					<tr>
						<td width="15%">Sub-Limit Head</td>

						<td width="48%"><select
							name="subfacility_head"
							onChange="javascript:selectSublimit();getFacility('sublimit');">
							<option selected="selected" value="-">----Select----</option>
							<%h = new HashMap();
			h.put("value", "parent");
			h.put("parent", "0");
			h.put("hidMethod", "getFacility");
			hp1 = new HashMap();
			hp1.put("BeanId", "facilitymaster");
			hp1.put("MethodName", "getData");
			hp1.put("BeanParam", h);

			%>
							<lapschoice:selecttag value='<%= hp1%>' />
						</select> <input type="hidden" name="hid_subfacility_head"></td>
						<td width="10%"><font
							color="#000000">Sub-Limit </font></td>
						<td width="27%"><select
							name="subfacility">
							<option value='0' selected="selected">----Select----</option>
						</select> <input type="hidden" name="hid_subfacility"></td>
					</tr>
					<tr>
						<td width="15%">Amount of Limit</td>
						<td width="48%"><lapschoice:CurrencyTag
							name="txt_subexist_limit" size="16" value='' maxlength="15"
							style="text-align:right" /></td>
						<td width="10%"><font
							color="#000000">D.P.</font></td>
						<td width="27%"><lapschoice:CurrencyTag
							name="txt_sub_dp" value='' size="16"
							onBlur="javascript:roundtxt(this)" onKeyPress="allowNumber(this)"
							maxlength="15" style="text-align:right" /></td>
					</tr>
					<tr>
						<td width="15%" nowrap="nowrap"><font
							color="#000000">Outstanding</font></td>
						<td width="48%"><lapschoice:CurrencyTag
							name="txt_sub_outstanding" value='' size="16" maxlength="15"
							style="text-align:right" /></td>
						<td width="10%" nowrap="nowrap"><font
							color="#000000">Excess / Overdue</font></td>

						<td width="27%"><lapschoice:CurrencyTag
							name="txt_sub_overdue" value='' size="16"
							onKeyPress="allowNumber(this)" maxlength="15"
							style="text-align:right" /></td>
					</tr>
					<tr>
						<td width="15%" nowrap="nowrap">Remarks</td>
						<td width="48%"><textarea
							name="txt_remarks" wrap="VIRTUAL" cols="40"><%=Helper.correctNull((String) hshValues.get("subdesc"))%></textarea>
						</td>
						<td width="10%" nowrap="nowrap">&nbsp;</td>
						<td width="27%">&nbsp;</td>
					</tr>
					<tr>
						<td colspan="4" nowrap="nowrap"><b><font
							color="red">Note : - 1. All Debit balances should be indicated
						with - (minus) sign</font></b></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		<br>		
		<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Print' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
		<br>
		</td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
			<tr class="dataheader">
				<td  width="6%" >&nbsp;</td>

				
            <td width="15%" align="center"  > Facility 
              Head</td>
				
            <td align="center"  width="15%" >Facility 
            </td>
				<td align="center"  width="15%" >Amount of Limit</td>
				<td width="7%" align="center"  >D.P.<br>
				</td>
				<td width="8%" align="center"  >Outstanding</td>
				<td width="10%" align="center"  >Excess
				/ Overdue</td>
			</tr>
			<%int mainfacility = 0, adhocfacility = 0, subFacility = 0, mainfacilityid = 0;
			String tempmainfacility = "0";
			arrRow = (ArrayList) hshValues.get("arrRow");

			if (arrRow != null) {
				for (int i = 0; i < arrRow.size(); i++) {
					arrCol = (ArrayList) arrRow.get(i);

					if (arrCol != null) {

						if (mainfacility == 0
								&& Helper.correctNull((String) arrCol.get(5))
										.equals("r")) {%>
			<tr class="dataheader">
				<td colspan="7"><b>Main Limit Facilities :</b></td>
			</tr>

			<%mainfacility++;
						}%>

			<%if (adhocfacility == 0
								&& Helper.correctNull((String) arrCol.get(5))
										.equals("a")) {%>
			<tr class="dataheader">
				<td colspan="7"><b>Adhoc facilities :</b></td>
			</tr>
			<%adhocfacility++;
						}%>


			<%if (Integer.parseInt(Helper.correctInt((String) arrCol
								.get(4))) == (Integer.parseInt(Helper
								.correctInt((String) arrCol.get(12))))) {

							if (i != 0) {

								%>
			<!-- this helps us to give count of sublimit for facility and also same done when u r closing the for loop which helps to give 
				last count of facility, tempmainfacility give facility sno of prevous iterrate arraylist and subfacilty give 
				the count of the facility done by paul -->
			<input type="hidden" name="sublimitno<%=tempmainfacility%>"
				value="<%=subFacility%>">
			<%}
							tempmainfacility = Helper
									.correctNull((String) arrCol.get(12));
							subFacility = 0;
							mainfacilityid = i;

							%>

			<tr class="datagrid">
				<td  width="6%"><input type="radio" name="sno"
					style="border-style:none"
					onClick="selectValues('<%=Helper.correctNull((String)arrCol.get(2))%>','<%=Helper.correctNull((String)arrCol.get(3))%>','<%=Helper.correctNull((String)arrCol.get(6))%>','<%=Helper.correctNull((String)arrCol.get(9))%>','<%=Helper.correctNull((String)arrCol.get(7))%>','<%=Helper.correctNull((String)arrCol.get(8))%>','<%=Helper.replaceForJavaScriptString((String)arrCol.get(11))%>','<%=Helper.correctNull((String)arrCol.get(12))%>','<%=Helper.correctNull((String)arrCol.get(5))%>','<%=Helper.correctNull((String)arrCol.get(10))%>','<%=Helper.correctNull((String)arrCol.get(4))%>')">
				</td>
				<td width="15%" ><b><%=Helper
													.correctNull((String) arrCol
															.get(0))%> <%if (Helper.correctNull((String) arrCol.get(5))
									.equals("a")) {%><br>
				(upto <%=Helper.correctNull((String) arrCol
												.get(13))%>) <%}%> </b></td>
				<td  width="15%"><%=Helper
													.correctNull((String) arrCol
															.get(1))%></td>
				<td align="right"  width="15%"><%=Helper
													.correctNull((String) arrCol
															.get(6))%>&nbsp;</td>
				<td width="7%"  align="right">
				<div style="width:100"><%=Helper
													.correctNull((String) arrCol
															.get(9))%></div>
				</td>
				<td width="8%"  align="right">
				<div align="right" style="width:100"><%=Helper
													.correctNull((String) arrCol
															.get(7))%></div>
				</td>
				<td width="10%"  align="right">
				<div align="right" style="width:100"><%=Helper
													.correctNull((String) arrCol
															.get(8))%></div>
				</td>
			</tr>
			<%} else {
							arrCol1 = (ArrayList) arrRow.get(mainfacilityid);
							if (subFacility == 0) {%>

			<tr>
				<td width="6%">&nbsp;</td>
				<td colspan="8" ><b>&gt;&gt;</b> <b>Sub-Limit</b></td>
			</tr>
			<%}%>

			<tr class="datagrid">
				<td  width="6%"><input type="radio" name="sno"
					style="border-style:none"
					onClick="selectValues('<%=Helper.correctNull((String)arrCol1.get(2))%>','<%=Helper.correctNull((String)arrCol1.get(3))%>','<%=Helper.correctNull((String)arrCol1.get(6))%>','<%=Helper.correctNull((String)arrCol1.get(9))%>','<%=Helper.correctNull((String)arrCol1.get(7))%>','<%=Helper.correctNull((String)arrCol1.get(8))%>','<%=Helper.replaceForJavaScriptString((String)arrCol1.get(11))%>','<%=Helper.correctNull((String)arrCol1.get(12))%>','<%=Helper.correctNull((String)arrCol1.get(5))%>','<%=Helper.correctNull((String)arrCol1.get(10))%>','<%=Helper.correctNull((String)arrCol1.get(4))%>');
									selectValues1('<%=Helper.correctNull((String)arrCol.get(2))%>','<%=Helper.correctNull((String)arrCol.get(3))%>','<%=Helper.correctNull((String)arrCol.get(6))%>','<%=Helper.correctNull((String)arrCol.get(9))%>','<%=Helper.correctNull((String)arrCol.get(7))%>','<%=Helper.correctNull((String)arrCol.get(8))%>','<%=Helper.replaceForJavaScriptString((String)arrCol.get(11))%>','<%=Helper.correctNull((String)arrCol.get(12))%>','<%=Helper.correctNull((String)arrCol.get(4))%>')">
				</td>
				<td width="15%" ><%=Helper
													.correctNull((String) arrCol
															.get(0))%></td>
				<td  width="15%"><%=Helper
													.correctNull((String) arrCol
															.get(1))%></td>
				<td align="right"  width="15%">(<%=Helper
													.correctNull((String) arrCol
															.get(6))%>)&nbsp;</td>
				<td width="7%"  align="right">
				<div style="width:100">(<%=Helper
													.correctNull((String) arrCol
															.get(9))%>)</div>
				</td>
				<td width="8%"  align="right">
				<div align="right" style="width:100">(<%=Helper
													.correctNull((String) arrCol
															.get(7))%>)</div>
				</td>
				<td width="10%"  align="right">
				<div align="right" style="width:100">(<%=Helper
													.correctNull((String) arrCol
															.get(8))%>)</div>
				</td>
			</tr>


			<%subFacility++;
						}%>
			<%}
				}
			}%>
			<tr class="dataheader">
				<td colspan="3" align="right"><b>Total</b></td>
				<td align="right"><%=Helper.correctNull((String) hshValues
							.get("totalSanction"))%>&nbsp;</td>
				<td align="right">&nbsp;</td>
				<td align="right"><%=Helper.correctNull((String) hshValues.get("totalOS"))%>&nbsp;</td>
				<td align="right"><%=Helper.correctNull((String) hshValues
									.get("totalOverDue"))%>&nbsp;</td>
			<input type="hidden" name="sublimitno<%=tempmainfacility%>" value="<%=subFacility%>">
			</tr>
			
		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="cbsid" value="<%=Helper.correctNull((String)hshValues.get("cbsid"))%>"> 
<input type="hidden" name="mon_year" value="<%=Helper.correctNull((String)hshValues.get("mon_year"))%>"> 
<input type="hidden" name="mon_month" value="<%=Helper.correctNull((String)hshValues.get("mon_month"))%>"> 
<input type="hidden" name="cbsname" value="<%=Helper.correctNull((String)hshValues.get("cbsname"))%>"> 
<input type="hidden" name="applyflag" value="<%=Helper.correctNull((String)hshValues.get("applyflag"))%>" />

<input type="hidden" name="headSno"> 
<input type="hidden" name="hidgrpno">
<input type="hidden" name="subLimitSno"> 
<input type="hidden" name="checkSublimit"> 
<input type="hidden" name="factype"> 
<input type="hidden" name="hidsublimitno"> 
<input type="hidden" name="hidGrpSize"> 
<input type="hidden" name="hidGrpList"> 
<input type="hidden" name="addflag"> 
<iframe height="0" width="0" id="ifrm1" frameborder="0" style="border:0"></iframe> 
<iframe height="0" width="0" id="ifrm2" frameborder="0" style="border:0"></iframe> 
</form>
</body>
</html>
