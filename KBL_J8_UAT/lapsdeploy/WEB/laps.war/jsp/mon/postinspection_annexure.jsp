<%@include file="../share/directives.jsp"%>
<%ArrayList arrRow = new ArrayList();
			ArrayList arrCol = null;
			ArrayList arrCol1 = null;
			String strReviewtype = Helper.correctNull((String) request.getParameter("hidreviewtype"));%>
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
	disableFields(true);
}

function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,name);
	}
}
function doEdit()
{ 	
	if(document.forms[0].hid_sno.value!="")
	{	
		document.forms[0].hidAction.value ="update";
		disableCommandButtons("edit");
		disableFields(false);
		if(document.forms[0].checkbox.checked==true)
		{
			document.forms[0].factype.value="sublimit"
			document.forms[0].checkSublimit.value="";
		}
		else
		{
			document.forms[0].factype.value="facility";
			document.forms[0].checkSublimit.value="no";
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
		if(document.forms[0].txt_sanclimit.value=="")
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
		if(document.forms[0].txt_sanclimit.value=="")
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
		if(document.forms[0].txt_subsanclimit.value=="")
		{
			alert("Amount of Limit for Sub Limit cannot be empty")
			return;
		}
		if(eval(document.forms[0].txt_subsanclimit.value) > eval(document.forms[0].txt_sanclimit.value))
		{
			alert("The Sublimit 'Amount of Limit' exceeds the Parent facility 'Amount of Limit'");
			return;
		}
	}
	disableFields(false);
	document.forms[0].hidBeanId.value="postinspection";
	document.forms[0].hidSourceUrl.value="/action/postinspection_annexure.jsp";
	document.forms[0].hidBeanMethod.value="updatePostInspectionAnnexure";
	document.forms[0].hidBeanGetMethod.value="getPostInspectionAnnexure";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();	
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

function selectValues(val1,val2,val3,val4,val5,val6,val7,val8,val9)
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
	document.forms[0].hidgrpno.value=val3;
	if(val4=="a")
	{
		document.forms[0].category[1].checked=true;
	}
	else
	{
		document.forms[0].category[0].checked=true;
	}
	document.forms[0].txt_sanclimit.value=val5;
	document.forms[0].txt_outstanding.value=val6;
	document.forms[0].txt_overdue.value=val7;
	document.forms[0].txt_desc.value=val8;
	document.forms[0].hid_sno.value=val9;	
	document.forms[0].hidsublimitno.value=document.forms[0].elements["sublimitno"+val9].value
	if(document.forms[0].btnenable.value=="Y")
	{
		disableCommandButtons("selectvalue");
	}		
	document.forms[0].subfacility_head.selectedIndex=0;
	document.forms[0].subfacility.length=1;
	document.forms[0].subfacility.selectedIndex=0;
	document.forms[0].txt_subsanclimit.value="";
	document.forms[0].txt_sub_outstanding.value="";
	document.forms[0].txt_sub_overdue.value="";
	document.forms[0].txt_remarks.value="";
	document.forms[0].checkbox.checked=false;
	document.forms[0].factype.value="facility";
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
	document.forms[0].hidgrpno.value=val3;
	if(val4=="a")
	{
		document.forms[0].category[1].checked=true;
	}
	else
	{
		document.forms[0].category[0].checked=true;
	}
	document.forms[0].txt_subsanclimit.value=val5;
	document.forms[0].txt_sub_outstanding.value=val6;
	document.forms[0].txt_sub_overdue.value=val7;
	document.forms[0].txt_remarks.value=val8;
	document.forms[0].hid_sno.value=val9;
	document.forms[0].subLimitSno.value=val9;
	document.forms[0].factype.value="sublimit";
	document.forms[0].cmdnew.disabled =true;
	if(document.forms[0].btnenable.value=="Y")
	{
		disableCommandButtons("selectvalue");
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
	if((factype=="facility") && (document.forms[0].hid_sno.value==""))
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
		document.forms[0].hidBeanId.value="postinspection";
		document.forms[0].hidSourceUrl.value="/action/postinspection_annexure.jsp";
		document.forms[0].hidBeanMethod.value="updatePostInspectionAnnexure";
		document.forms[0].hidBeanGetMethod.value="getPostInspectionAnnexure";	
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
			document.forms[0].txt_subsanclimit.value="";
			document.forms[0].txt_sub_outstanding.value="";
			document.forms[0].txt_sub_overdue.value="";
			document.forms[0].txt_remarks.value="";
			if(document.forms[0].hid_sno.value=="")
			{
				document.forms[0].checkSublimit.value="yes";
			}
	  }
	  else
	  {
			document.forms[0].facility_head.selectedIndex=0;
			document.forms[0].facility.length=1;
			document.forms[0].facility.selectedIndex=0;
			document.forms[0].txt_sanclimit.value="";
			document.forms[0].txt_outstanding.value="";
			document.forms[0].txt_overdue.value="";
			document.forms[0].txt_desc.value="";
			
			document.forms[0].subfacility_head.selectedIndex=0;
			document.forms[0].subfacility.length=1;
			document.forms[0].subfacility.selectedIndex=0;
			document.forms[0].txt_subsanclimit.value="";
			document.forms[0].txt_sub_outstanding.value="";
			document.forms[0].txt_sub_overdue.value="";
			document.forms[0].txt_remarks.value="";
			
			document.forms[0].subfacility.disabled=true;
			document.forms[0].subfacility_head.disabled=true;
			document.forms[0].txt_subsanclimit.readOnly=true;
			document.forms[0].txt_sub_outstanding.readOnly=true;
			document.forms[0].txt_sub_overdue.readOnly=true;
			document.forms[0].txt_remarks.readOnly=true;
			document.forms[0].checkSublimit.value="yes";
	 } 
}   
function findtype()
{
	var hidAction = document.forms[0].hidAction.value;
	var subno=0;
	var factype =document.forms[0].factype.value;	
	var varsno=document.forms[0].hid_sno.value;
	if(varsno=="")
	{
		ShowAlert(111,'facility');
		document.forms[0].checkbox.checked=false;
		return;
	}
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
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="postinspection";
		document.forms[0].hidBeanGetMethod.value="getPostInspectionAnnexure";
		document.forms[0].action=appURL+"action/postinspection_annexure.jsp";	
		document.forms[0].submit();
	}
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/mon_borrowersearch.jsp?hidmontype=POSTINSPEC";
		document.forms[0].submit();
	}
}
function disableCommandButtons(val)
{
	   
    if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
		document.forms[0].cmddelete.disabled=true;
	}
	if(val=="edit")
	{  
		disableFields(true);
		document.forms[0].cmdnew.disabled=true;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmdsave.disabled=false;
		document.forms[0].cmdcancel.disabled=false;
		document.forms[0].cmdclose.disabled=false;		 
	}
	if(val=="selectvalue")
	{
		disableFields(true);
		document.forms[0].cmdnew.disabled=false;
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=false;
		document.forms[0].cmdclose.disabled=false;
		document.forms[0].cmddelete.disabled=false;		 
	}	
	if(val=="selectvalue1")
	{
		disableFields(true);
		document.forms[0].cmdnew.disabled=true;
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=false;
		document.forms[0].cmdclose.disabled=false;
		document.forms[0].cmddelete.disabled=false;			 
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
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td>
				<table width="45%" border="0" cellspacing="1" cellpadding="3" class="outertable">
					<tr>
						<td align="center" class="sub_tab_inactive"><a
							href="JavaScript:callLink('mon_inspectionreport.jsp','postinspection','getPostInspectionReport')"><b>Inspection
						Report</b></a></td>
						<td align="center" class="sub_tab_inactive"><a
							href="JavaScript:callLink('postinspection_facility.jsp','postinspection','getPostInspectionFaclity')"><b>Facility
						Enjoyed</b></a></td>
						<td align="center" class="sub_tab_active"><b>Facility Annexure</b></td>
							<td align="center" class="sub_tab_inactive"><a
							href="JavaScript:callLink('postinspection_history.jsp','postinspection','getPostInspectionHistory')"><b>Workflow</b></a></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
		<td class="page_flow">Home -&gt; Post/ Followup Inspection -&gt; Facility Annexure</td>
		</tr>
		</table>
		<lapschoice:PostInspection />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
				<td width="2%"><input type="radio" name="category" style="border-style:none" value="r" checked onClick="showNom();"></td>
				<td width="64%">Main Limit</td>
				<td width="2%"><input type="radio" name="category" style="border-style:none" value="a"></td>
				<td width="2%">Adhoc</td>
				<td width="30%">&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
					<tr class="datagrid">						
                  <td width="11%">Facility Head <span class="mantatory">*</span></td>
						<td width="38%"><%HashMap hp1 = new HashMap();%>
						<select name="facility_head"
							onChange="javascript:getFacility('facility')">
							<option selected value="-">----Select----</option>
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
						
                  <td>Facility <span class="mantatory">*</span></td>
						<td><select
							name="facility">
							<option value="0" selected>----Select----</option>
						</select> <input type="hidden" name="hid_facility"></td>
					</tr>
					<tr class="datagrid">						
                  <td>Amount of Limit </td>
						<td width="38%"><lapschoice:CurrencyTag
							name="txt_sanclimit" size="16" onBlur="javascript:roundtxt(this)"
							value='' onKeyPress="allowNumber(this)" maxlength="15"
							style="text-align:right" /></td>
						
                  <td nowrap>Outstanding</td>
						<td><lapschoice:CurrencyTag
							name="txt_outstanding" value='' size="16" maxlength="15"
							style="text-align:right" /></td>
					</tr>
					<tr class="datagrid">
						
                  <td width="11%" nowrap>Excess 
                    / Overdue</td>
						<td width="40%"><lapschoice:CurrencyTag
							name="txt_overdue" value='' size="16"
							onKeyPress="allowNumber(this)" maxlength="15"
							style="text-align:right" /></td>
						
                  <td nowrap>Remarks</td>
						<td><textarea name="txt_desc" wrap="VIRTUAL" cols="40"><%=Helper.correctNull((String) hshValues.get("facdesc"))%></textarea>
						</td>
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
					<tr valign="middle" class="dataheader">						
                  <td colspan="4">Sub - Limits&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                    <input type="checkbox" name="checkbox" value="checkbox" style="border-style:none"
							onClick="javascript:findtype()"></td>
					</tr>
					<tr class="datagrid">						
                  <td width="11%">Sub-Limit Head</td>
						<td><select
							name="subfacility_head"
							onChange="javascript:selectSublimit();getFacility('sublimit');">
							<option selected value="-">----Select----</option>
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
						
                  <td width="11%">Sub-Limit </td>
						<td width="27%"><select name="subfacility">
							<option value='0' selected>----Select----</option>
						</select> <input type="hidden" name="hid_subfacility"></td>
					</tr>
					<tr class="datagrid">
						<td>Amount of Limit</td>
						<td><lapschoice:CurrencyTag
							name="txt_subsanclimit" size="16" value='' maxlength="15"
							style="text-align:right" /></td>
						
                  <td nowrap>Outstanding</td>
						<td><lapschoice:CurrencyTag
							name="txt_sub_outstanding" value='' size="16" maxlength="15"
							style="text-align:right" /></td>
					</tr>
					<tr class="datagrid">						
                  <td nowrap>Excess / Overdue</td>
						<td width="27%"><lapschoice:CurrencyTag
							name="txt_sub_overdue" value='' size="16"
							onKeyPress="allowNumber(this)" maxlength="15"
							style="text-align:right" /></td>
						<td nowrap>Remarks</td>
						<td><textarea name="txt_remarks"
							wrap="VIRTUAL" cols="40"><%=Helper.correctNull((String) hshValues.get("subdesc"))%></textarea>
						</td>
					</tr>
					<tr>
						<td colspan="4" nowrap><b></b></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		<br>
		<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trial' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
		<br> 
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
			<tr class="dataheader">
				<td>&nbsp;</td>
				<td  align="center">Facility Head</td>
				<td align="center">Facility</td>				
            	<td align="center">Amount of Limit</td>
				<td  align="center">Outstanding</td>
				<td  align="center">Excess / Overdue</td>
			</tr>
			<%int mainfacility = 0, adhocfacility = 0, subFacility = 0, mainfacilityid = 0;
			String tempmainfacility = "0";
			arrRow = (ArrayList) hshValues.get("arrRow");
			if (arrRow != null) {
				for (int i = 0; i < arrRow.size(); i++) {
					arrCol = (ArrayList) arrRow.get(i);
					if (arrCol != null) {%>
              <%if (Integer.parseInt(Helper.correctInt((String) arrCol.get(4))) == (Integer.parseInt(Helper.correctInt((String) arrCol.get(10))))) {
							if (i != 0) {%>
              <input type="hidden" name="sublimitno<%=tempmainfacility%>"
					value="<%=subFacility%>">
			<%}		tempmainfacility = Helper.correctNull((String) arrCol.get(10));
							subFacility = 0;
							mainfacilityid = i;%>
			<tr class="datagrid">
				<td><input type="radio" name="sno"
					style="border-style:none"
					onClick="selectValues('<%=Helper.correctNull((String)arrCol.get(0))%>','<%=Helper.correctNull((String)arrCol.get(2))%>','<%=Helper.correctNull((String)arrCol.get(4))%>','<%=Helper.correctNull((String)arrCol.get(5))%>','<%=Helper.correctNull((String)arrCol.get(6))%>','<%=Helper.correctNull((String)arrCol.get(7))%>','<%=Helper.correctNull((String)arrCol.get(8))%>','<%=Helper.correctNull((String)arrCol.get(9))%>','<%=Helper.correctNull((String)arrCol.get(10))%>')">
				</td>
				<td><b><%=Helper
													.correctNull((String) arrCol
															.get(1))%>&nbsp;
				<%if(Helper.correctNull((String) arrCol.get(5)).equals("a")) {%>
				(Adhoc)
				<% }%>
															</b></td>
				<td><%=Helper
													.correctNull((String) arrCol
															.get(3))%>&nbsp;</td>
				<td align="right">&nbsp;<%=Helper
													.correctNull((String) arrCol
															.get(6))%></td>
				<td align="right">&nbsp;<%=Helper
													.correctNull((String) arrCol
															.get(7))%></td>
				<td align="right">&nbsp;<%=Helper
													.correctNull((String) arrCol
															.get(8))%></td>
			</tr>
			<%} else {
							arrCol1 = (ArrayList) arrRow.get(mainfacilityid);
							if (subFacility == 0) {%>
			<tr class="datagrid">
				<td >&nbsp;</td>
				<td colspan="7"><b>&gt;&gt;</b> <b>Sub-Limit</b></td>
			</tr>
			<%}%>
			<tr class="datagrid">
				<td ><input type="radio" name="sno"
					style="border-style:none"
					onClick="selectValues('<%=Helper.correctNull((String)arrCol1.get(0))%>','<%=Helper.correctNull((String)arrCol1.get(2))%>','<%=Helper.correctNull((String)arrCol1.get(4))%>','<%=Helper.correctNull((String)arrCol1.get(5))%>','<%=Helper.correctNull((String)arrCol1.get(6))%>','<%=Helper.correctNull((String)arrCol1.get(7))%>','<%=Helper.correctNull((String)arrCol1.get(8))%>','<%=Helper.correctNull((String)arrCol1.get(9))%>','<%=Helper.correctNull((String)arrCol1.get(10))%>');
									selectValues1('<%=Helper.correctNull((String)arrCol.get(0))%>','<%=Helper.correctNull((String)arrCol.get(2))%>','<%=Helper.correctNull((String)arrCol.get(4))%>','<%=Helper.correctNull((String)arrCol.get(5))%>','<%=Helper.correctNull((String)arrCol.get(6))%>','<%=Helper.correctNull((String)arrCol.get(7))%>','<%=Helper.correctNull((String)arrCol.get(8))%>','<%=Helper.correctNull((String)arrCol.get(9))%>','<%=Helper.correctNull((String)arrCol.get(10))%>')">
				</td>
				<td><%=Helper.correctNull((String) arrCol.get(1))%>
		<%if(Helper.correctNull((String) arrCol.get(5)).equals("a")) {%>
				(Adhoc)
				<% }%></td>
				<td align="left"  ><%=Helper.correctNull((String) arrCol.get(3))%></td>
				<td align="right"  >(<%=Helper.correctNull((String) arrCol.get(6))%>)&nbsp;</td>
				<td   align="right">(<%=Helper.correctNull((String) arrCol.get(7))%>)</td>
				<td   align="right">(<%=Helper.correctNull((String) arrCol.get(8))%>)</td>
			</tr>
			<%subFacility++;
						}%>
			<%}}}%>
			<tr class="dataheader">
				<td colspan="3" align="right"><b>Total</b></td>
				<td align="right"><%=Helper.correctNull((String) hshValues.get("totalSanction"))%>&nbsp;</td>
				<td align="right"><%=Helper.correctNull((String) hshValues.get("totalOS"))%>&nbsp;</td>
				<td align="right"><%=Helper.correctNull((String) hshValues.get("totalOverDue"))%>&nbsp; 
				<input type="hidden" name="sublimitno<%=tempmainfacility%>" value="<%=subFacility%>"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="hidgrpno"> 
<input type="hidden" name="checkSublimit"> 
<input type="hidden" name="factype"> 
<input type="hidden" name="hidsublimitno">
<input type="hidden" name="subLimitSno"> 
<input type="hidden" name="hidreviewtype" value="<%=strReviewtype%>" /> 
<input type="hidden" name="hid_sno" value="">
<iframe height="0" width="0" id="ifrm1" frameborder=0 style="border:0"> </iframe> 
<iframe height="0" width="0" id="ifrm2" frameborder=0 style="border:0"></iframe>
</form>
</body>
</html>
