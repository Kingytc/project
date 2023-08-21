<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%String strAppno = "";
			if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
			}
			String applicantid = "";
			String appstatus = "";
			String appname = "";
			String Valuesin = "";
			String strValuesin = "";
			String hidcatory = "";
			String strappstatus = "";
			String strBtnenable="";
			strAppno = Helper.correctNull((String) hshValues.get("appno"));
			applicantid = Helper.correctNull((String) hshValues.get("applicantid"));
			appstatus = Helper.correctNull((String) hshValues.get("appstatus"));
			appname = Helper.correctNull((String) hshValues.get("appname"));
			Valuesin = Helper.correctNull((String) hshValues.get("valuesin"));
			strBtnenable= Helper.correctNull((String) hshValues.get("btnenable"));
			if (strAppno.equalsIgnoreCase(""))
			{
				strAppno = Helper.correctNull((String) request.getParameter("appno"));
			}
			if (appstatus.equalsIgnoreCase("op") || strAppno.equalsIgnoreCase("new")) 
			{
				strappstatus = "Open/Pending";
			}
			else if (appstatus.equalsIgnoreCase("pa"))
			{
				strappstatus = "Processed/Approved";
			}
			else if (appstatus.equalsIgnoreCase("pr"))
			{
				strappstatus = "Processed/Rejected";
			}
			else if (appstatus.equalsIgnoreCase("ca")) 
			{
				strappstatus = "Closed/Approved";
			} 
			else if (appstatus.equalsIgnoreCase("cr"))
			{
				strappstatus = "Closed/Rejected";
			}
			if (appname.equalsIgnoreCase("")) 
			{
				appname = Helper.correctNull((String) request.getParameter("appname"));
			}
			if (applicantid.equalsIgnoreCase("")) 
			{
				applicantid = Helper.correctNull((String) request.getParameter("com_id"));
			}
			hidcatory = Helper.correctNull((String) request.getParameter("hidcatory"));
			ArrayList arrRow = new ArrayList();
			ArrayList arrCol = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrRow");			
			if (Valuesin.equals("L")) 
			{
				strValuesin = " in Lacs";
			}
			else if(Valuesin.equals("C"))
			{
				strValuesin = " in Crores";
			}			
			String strAppOrgName = Helper.correctNull((String)hshValues.get("org_name"));
			String strAppHolder = Helper.correctNull((String)hshValues.get("applnholder"));%>
<html>
<head>
<title>Broad Terms Facility</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varOrgLevel="<%=strOrgLevel%>";
var varAppno ="<%=Helper.correctNull((String)hshValues.get("appno"))%>";
var varappstatus ="<%=Helper.correctNull((String)hshValues.get("checkappln"))%>";
var varValuesin="<%=Valuesin%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function selectValues(varsno, vargrp)
{
var strheadid=0,strfacid=0,strsubheadid=0,strsubfacid=0;
len = document.forms[0].facility_head.length;
	if(vargrp=="0")
	{
		strheadid=document.forms[0].elements["hidfachead"+varsno].value;
		strfacid=document.forms[0].elements["hidfacility"+varsno].value;
		document.forms[0].txt_limitexist.value=document.forms[0].elements["hidlimitexist"+varsno].value;
		document.forms[0].txt_limitproposed.value=document.forms[0].elements["hidlimitproposed"+varsno].value;
		document.forms[0].txt_limitcreditint.value=document.forms[0].elements["hidlimitcreditint"+varsno].value;
		document.forms[0].txt_limitproposedint.value=document.forms[0].elements["hidlimitproposedint"+varsno].value;
		document.forms[0].txt_limitmargin.value=document.forms[0].elements["hidlimitmargin"+varsno].value;
		document.forms[0].txt_limitperiod.value=document.forms[0].elements["hidlimitperiod"+varsno].value;
		document.forms[0].txt_limitpurpose.value=document.forms[0].elements["hidlimitpurpose"+varsno].value;
		document.forms[0].txt_limitintreset.value=document.forms[0].elements["hidlimitintreset"+varsno].value;
		document.forms[0].subfacility_head.value="-";
		document.forms[0].subfacility.value="";
		document.forms[0].txt_sublimitexist.value="";
		document.forms[0].txt_sublimitproposed.value="";
		document.forms[0].txt_sublimitcreditint.value="";
		document.forms[0].txt_sublimitproposedint.value="";
		document.forms[0].txt_sublimitmargin.value="";
		document.forms[0].txt_sublimitperiod.value="";
		document.forms[0].txt_sublimitpurpose.value="";
		document.forms[0].txt_sublimitintreset.value="";
		document.forms[0].chksublimit.checked=false;
		document.forms[0].chksublimit.value="N";
		document.forms[0].hidfactype.value="limit";
	}
	else
	{
		strheadid=document.forms[0].elements["hidfachead"+vargrp].value;
		strfacid=document.forms[0].elements["hidfacility"+vargrp].value;
		document.forms[0].txt_limitexist.value=document.forms[0].elements["hidlimitexist"+vargrp].value;
		document.forms[0].txt_limitproposed.value=document.forms[0].elements["hidlimitproposed"+vargrp].value;
		document.forms[0].txt_limitcreditint.value=document.forms[0].elements["hidlimitcreditint"+vargrp].value;
		document.forms[0].txt_limitproposedint.value=document.forms[0].elements["hidlimitproposedint"+vargrp].value;
		document.forms[0].txt_limitmargin.value=document.forms[0].elements["hidlimitmargin"+vargrp].value;
		document.forms[0].txt_limitperiod.value=document.forms[0].elements["hidlimitperiod"+vargrp].value;
		document.forms[0].txt_limitpurpose.value=document.forms[0].elements["hidlimitpurpose"+vargrp].value;
		document.forms[0].txt_limitintreset.value=document.forms[0].elements["hidlimitintreset"+vargrp].value;
		strsubheadid=document.forms[0].elements["hidfachead"+varsno].value;
		strsubfacid=document.forms[0].elements["hidfacility"+varsno].value;
		document.forms[0].txt_sublimitexist.value=document.forms[0].elements["hidlimitexist"+varsno].value;
		document.forms[0].txt_sublimitproposed.value=document.forms[0].elements["hidlimitproposed"+varsno].value;
		document.forms[0].txt_sublimitcreditint.value=document.forms[0].elements["hidlimitcreditint"+varsno].value;
		document.forms[0].txt_sublimitproposedint.value=document.forms[0].elements["hidlimitproposedint"+varsno].value;
		document.forms[0].txt_sublimitmargin.value=document.forms[0].elements["hidlimitmargin"+varsno].value;
		document.forms[0].txt_sublimitperiod.value=document.forms[0].elements["hidlimitperiod"+varsno].value;
		document.forms[0].txt_sublimitpurpose.value=document.forms[0].elements["hidlimitpurpose"+varsno].value;
		document.forms[0].txt_sublimitintreset.value=document.forms[0].elements["hidlimitintreset"+varsno].value;
		document.forms[0].chksublimit.checked=true;
		document.forms[0].chksublimit.value="Y";
		document.forms[0].hidfactype.value="sublimit";
	}
	document.forms[0].hidsno.value=varsno;
	document.forms[0].hidfacgrp.value=vargrp;
	for(k=0;k<len;k++)
	{
		arr = document.forms[0].facility_head.options[k].value.split("-");
		if(arr!=null)
		{
			if(arr[0]==strheadid)
			{
				document.forms[0].elements["facility_head"].options[k].selected=true;
				break;
			}
		}
	}
	if(strheadid!="")
	{
		document.all.ifrm1.src=appURL+"action/iframefacility.jsp?hidBeanId=facilitymaster&parent="+strheadid+"&value=subsel&hidMethod=getFacility&factid="+strfacid+"&strtype=facility";
	}
	for(k=0;k<len;k++)
	{
		arr = document.forms[0].subfacility_head.options[k].value.split("-");
		if(arr!=null)
		{
			if(arr[0]==strsubheadid)
			{
				document.forms[0].elements["subfacility_head"].options[k].selected=true;
				break;
			}
		}
	}
	if(strsubheadid!="")
	{
		if(!isNaN(strsubheadid))
		{
			document.forms[0].chksublimit.checked=true;
		}
		else
		{
			document.forms[0].chksublimit.checked=false;
		}
		document.all.ifrm2.src=appURL+"action/iframefacility.jsp?hidBeanId=facilitymaster&parent="+strsubheadid+"&value=subsel&hidMethod=getFacility&factid="+strsubfacid+"&strtype=sublimit";
	}
	else
	{
		document.forms[0].chksublimit.checked=false;
	}
	if(vargrp=="0")
	{
		if(document.forms[0].btnenable.value.toUpperCase()=="Y")
		{
			disableCommandButtons(false,false,true,true,false,true);
		}
		else
		{
			disableCommandButtons(true,true,true,true,true,false);
		}
	}
	else
	{
		
		if(document.forms[0].btnenable.value.toUpperCase()=="Y")
		{
			disableCommandButtons(true,false,true,true,false,true);
		}
		else
		{
			disableCommandButtons(true,true,true,true,true,false);
		}
	}
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text'  )
		{
			document.forms[0].elements[i].readOnly=val;
		}	 
		if(document.forms[0].elements[i].type=='textarea'  )
		{
			document.forms[0].elements[i].readOnly=val;
		}	 
		if(document.forms[0].elements[i].type=='select-one'  )
		{
			document.forms[0].elements[i].disabled=val;
		}
	}
}
function onloading()
{	  
	if(varAppno=='NEW')
	{
		if(varappstatus=='false' || varappstatus=='')
		{	
			disableCommandButtons(true,true,false,true,true,false);
			disableFields(false);
			document.forms[0].hidfactype.value="limit";
		}
		else
		{
			alert("You can not create a new Broad terms of proposal, Since Old Broad terms of proposal is not closed");
			document.forms[0].action=appURL+"action/combstpge.jsp";
		 	document.forms[0].submit();
		}
	}
	else
	{
		disableFields(true);
	}

	if(varValuesin!="")
	{
		document.forms[0].sel_valuesin.value=varValuesin;
	}
	else
	{
		document.forms[0].sel_valuesin.value="";
	}
}
function doSave()
{
	if(document.forms[0].sel_valuesin.value == "")
	{
		ShowAlert(111,'All Values are in');
		document.forms[0].sel_valuesin.focus();
		return false;
	}
	if(document.forms[0].hidfactype.value=="limit")
	{
		if(document.forms[0].facility_head.selectedIndex == "0")
		{
			ShowAlert(111,'Facility Head');
			document.forms[0].facility_head.focus();
			return false;
		}
		else if(document.forms[0].facility.value == "-")
		{
			ShowAlert(111,'Facility Type');
			document.forms[0].facility.focus();
			return false;
		}
		else if(document.forms[0].txt_limitexist.value == "")
		{
			ShowAlert(112,'Existing Limits');
			document.forms[0].txt_limitexist.focus();
			return false;
		}
		else if(document.forms[0].txt_limitproposed.value == "")
		{
			ShowAlert(112,'Proposed Limit');
			document.forms[0].txt_limitproposed.focus();
			return false;
		}
	}
	else
	{
		if(document.forms[0].subfacility_head.selectedIndex == "0")
		{
			ShowAlert(111,'Facility Head for Sublimit');
			document.forms[0].subfacility_head.focus();
			return false;
		}
		else if(document.forms[0].subfacility.value == "-")
		{
			ShowAlert(111,'Facility Type for Sublimit');
			document.forms[0].subfacility.focus();
			return false;
		}
		else if(document.forms[0].txt_sublimitexist.value == "")
		{
			ShowAlert(112,'Existing Limits for Sublimit');
			document.forms[0].txt_sublimitexist.focus();
			return false;
		}
		else if(document.forms[0].txt_sublimitproposed.value == "")
		{
			ShowAlert(112,'Proposed Limit for Sublimit');
			document.forms[0].txt_sublimitproposed.focus();
			return false;
		}
		else if(eval(document.forms[0].txt_sublimitexist.value)>eval(document.forms[0].txt_limitexist.value))
		{
			alert('Sublimit Existing amount cannot be greater than Main limit Existing amount');
			return false;
		}
		else if(eval(document.forms[0].txt_sublimitproposed.value)>eval(document.forms[0].txt_limitproposed.value))
		{
			alert('Sublimit Proposed amount cannot be greater than Main limit Proposed amount');
			return false;
		}
	}
	document.forms[0].sel_valuesin.disabled=false;
	assignData();
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="broadsancterms";		
	document.forms[0].hidSourceUrl.value="/action/combst_facility.jsp";
	document.forms[0].hidBeanGetMethod.value="updateBSTfacility";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doDelete()
{
	if(varRecordFlag=="Y")
	{
		
	if(ConfirmMsg(101))
	{
		assignData();
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidBeanGetMethod.value="updateBSTfacility";	
		document.forms[0].hidBeanId.value="broadsancterms";
		document.forms[0].hidSourceUrl.value="action/combst_facility.jsp";	
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();	
	}	
	}
	else
	{
		ShowAlert(158);
	}
	
}
function doNew()
{
	disableFields(false);
	document.forms[0].sel_valuesin.disabled=true;
    document.forms[0].hidAction.value ="insert";
    document.forms[0].hideditflag.value="Y";
    disableCommandButtons(true,true,false,true,false,true);
    if(document.forms[0].hidfactype.value=="sublimit")
    {
   		document.forms[0].hidfacgrp.value=document.forms[0].hidsno.value;
    	document.forms[0].subfacility_head.focus();
    }
    else
    {
  		document.forms[0].facility_head.value="-";
  		document.forms[0].facility.value="0";
		document.forms[0].txt_limitexist.value="";
		document.forms[0].txt_limitproposed.value="";
		document.forms[0].txt_limitcreditint.value="";
		document.forms[0].txt_limitproposedint.value="";
		document.forms[0].txt_limitmargin.value="";
		document.forms[0].txt_limitperiod.value="";
		document.forms[0].txt_limitpurpose.value="";
		document.forms[0].txt_limitintreset.value="";
		document.forms[0].hidfactype.value="limit";
	}
}
function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	document.forms[0].hideditflag.value="Y";
	disableCommandButtons(true,true,false,false,false,true);
	document.forms[0].facility_head.focus();
}
function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="";
		document.forms[0].hidBeanId.value="broadsancterms";
		document.forms[0].hidBeanGetMethod.value="getBSTfacility";
		document.forms[0].action=appURL+"action/combst_facility.jsp";
		document.forms[0].submit();
	}
}
 function disableCommandButtons(cmdnew,cmdedit,cmdsave,cmddel,cmdcancel,cmdclose)
 {  
	  document.forms[0].cmdnew.disabled =cmdnew;
	  document.forms[0].cmdedit.disabled=cmdedit;	  
	  document.forms[0].cmdsave.disabled=cmdsave;
	  document.forms[0].cmddelete.disabled=cmddel;
	  document.forms[0].cmdcancel.disabled=cmdcancel;
	  document.forms[0].cmdclose.disabled=cmdclose;
 }
 function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/combstpge.jsp";
		document.forms[0].submit();
	}
}
function callSublimit()
{
	if(document.forms[0].chksublimit.checked && document.forms[0].hideditflag.value=="Y")
	{
		document.forms[0].chksublimit.checked=false;
		alert("Can't check in edit mode or add mode");			
		return;
	}
	if(document.forms[0].chksublimit.checked==false && document.forms[0].hideditflag.value=="Y")
	{
		document.forms[0].chksublimit.checked=true;
		alert("Can't uncheck");			
		return;
	}
	if(document.forms[0].chksublimit.checked==false && document.forms[0].hidfacgrp.value!="0")
	{
		document.forms[0].chksublimit.checked=true;
		alert("Can't uncheck sublimit exists");			
		return;
	}
	if(document.forms[0].hidsno.value=="")
	{
		document.forms[0].chksublimit.checked=false;
		alert("Select Main Limit");
		return;
	}
	if(document.forms[0].chksublimit.checked)
	{
		document.forms[0].hidfactype.value="sublimit";
		disableCommandButtons(false,true,true,true,true,false);
	}
	else
	{
		document.forms[0].hidfactype.value="limit";
		disableCommandButtons(false,false,true,true,true,false);
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
 }
function selectSublimit()
{
	if(document.forms[0].chksublimit.checked==false)
	{
		alert("Check sublimit option");
		document.forms[0].subfacility_head.selectedIndex=0;
 		return;
	}
}
function opendisfixed(field)
{
	if (document.forms[0].cmdsave.disabled == false)
	{
	var num="-";
	
	  var purl = appURL+"action/fixedselect.jsp?val=fixedselect&num="+num+"&baserate="+field+"&identity=floating";
	  var prop = "scrollbars=no,width=450,height=360";	
	  var title = "InterestRate";
	  var xpos = (screen.width - 350) / 2;
	  var ypos = (screen.height - 320) / 2;
	  prop = prop + ",left="+xpos+",top="+ypos;
      window.open(purl,title,prop);
	}
}
function callvalues()
{
	if(document.forms[0].sel_valuesin.value=="L")
	{
		document.all.idvalues.innerHTML='<FONT SIZE=\"1\" color=\"red\"><b>(Amount Rs. in Lacs) </b>';
	}
	else if(document.forms[0].sel_valuesin.value=="C")
	{
		document.all.idvalues.innerHTML='<FONT SIZE=\"1\" color=\"red\"><b>(Amount Rs. in Crores) </b>';
	}
}

function assignData()
{
try
{
	document.forms[0].hid_facility_head.value=document.forms[0].facility_head.options[document.forms[0].facility_head.selectedIndex].text;
	document.forms[0].hid_facility.value=document.forms[0].facility.options[document.forms[0].facility.selectedIndex].text;
	document.forms[0].hid_subfacility_head.value=document.forms[0].facility_head.options[document.forms[0].subfacility_head.selectedIndex].text;
	document.forms[0].hid_subfacility.value=document.forms[0].subfacility.options[document.forms[0].subfacility.selectedIndex].text;
}
catch(rr)
{
}
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading();callvalues()">
<form method="post" name="facility" class="normal"><lapstab:applurllinkbst pageid='1'
	category='bst' valuesin='<%=Valuesin%>' />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Corporate &amp; SME -&gt; Broad Terms of Proposal -&gt; Facilities</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable linebor">
	<tr class="applicationheader">
		<td width="10%"><b>Application No</b></td>
		<td width="12%"><b><%=strAppno%></b></td>
		<td width="12%"><b>Applicant Name</b></td>
	<td width="25%"><b><%=appname%></b>&nbsp;</td>
		<td width="6%"><b>Status</b></td>
	<td width="12%">
		<b><%=strappstatus%></b>
	</td>
	</tr>
	<tr class="applicationheader">
	<td><b>Application Holder</b></td>
		<td><b><%= strAppHolder%></b>&nbsp;</td>
	<td><b>App. Recd. from</b></td>
		<td><b><%=strAppOrgName %></b>&nbsp;</td>	
		
		<td colspan="2">
		<input type="hidden" name="appstatus"	value="<%=appstatus%>">
			<input type="hidden" name="readFlag" value="<%=Helper.correctNull((String)session.getAttribute("strGroupRights")).charAt(18)%>">
			<input type="hidden" name="com_id" value="<%=applicantid%>"> 
			<input type="hidden" name="valuesin" value="<%=Valuesin%>">
			<input type="hidden" name="hidcatory" value="<%=hidcatory%>">
			<input type="hidden" name="btnenable" value="<%=strBtnenable%>">
			<input type="hidden" name="apporgname" value="<%=strAppOrgName%>">
			<input type="hidden" name="applnholder" value="<%=strAppHolder%>">
			<input type="hidden" name="appno" value="<%=strAppno%>">
			<input type="hidden" name="appname" value="<%=appname%>"></td>	
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
					<tr>
						<td valign="top">
						<table width="80%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable border1">
							<tr>
								<td>								
                          <table width="100%" border="0" cellspacing="3" cellpadding="3" class="outertable">
                            <tr> 
                              <td colspan="2">&nbsp;</td>
                              <td><b>All Values are in </b><span class="mantatory"><b>*</b></span></td>
                              <td> 
                                <select name="sel_valuesin" onchange="callvalues()">
                                 <option value="">&lt;---Select---&gt;</option>
                                  <option value="L">Lacs</option>
                                  <option value="C">Crores</option>
                                </select>
                              </td>
                            </tr>
                            <tr> 
                              <td width="23%">Facility Head</td>
                              <td  width="30%" > 
                                <%HashMap hp1 = new HashMap();%>
                                <select name="facility_head"
											onChange="javascript:getFacility('facility')">
                                  <option selected="selected" value="-">----Select----</option>
                                  <%HashMap h = new HashMap();
			h.put("value", "parent");
			h.put("parent", "0");
			h.put("hidMethod", "getFacility");

			hp1 = new HashMap();
			hp1.put("BeanId", "facilitymaster");
			hp1.put("MethodName", "getData");
			hp1.put("BeanParam", h);

			%>
                                  <lapschoice:selecttag value='<%= hp1%>' /> 
                                </select>
                                <input type="hidden" name="hid_facility_head">
                              </td>
                              <td   width="27%">Facility</td>
                              <td   width="20%"> 
                                <select
											name="facility">
                                  <option selected="selected">----Select----</option>
                                </select>
                                <input type="hidden" name="hid_facility">
                              </td>
                            </tr>
                            <tr> 
                              <td width="23%" nowrap="nowrap">Existing Limits <span class="mantatory"><b>*</b></span></td>
                              <td width="30%"><lapschoice:CurrencyTag name="txt_limitexist"
											size="13" maxlength="10" /></td>
                              <td width="27%" nowrap="nowrap">Proposed Limit <span class="mantatory"><b>*</b></span></td>
                              <td width="20%"> 
                                <input type="text" name="txt_limitproposed"
											size="13" maxlength="10" style="text-align:right"
											onBlur="roundtxt(this)" onKeyPress="allowNumber(this)">
                              </td>
                            </tr>
                            <tr> 
                              <td width="23%" nowrap="nowrap">Interest as per Credit Rating / Commission</td>
                              <td width="30%"> 
                                <input type="text" name="txt_limitcreditint"
											size="40" maxlength="40" onKeyPress="notAllowSplChar">
                              </td>
                              <td width="27%" nowrap="nowrap">Interest/Commission Proposed</td>
                              <td width="20%"> 
                                <input type="text" name="txt_limitproposedint"
											size="40" maxlength="40" onKeyPress="notAllowSplChar">
                              </td>
                            </tr>
                            <tr> 
                              <td width="27%" nowrap="nowrap">Margin(%)</td>
                              <td width="20%"> 
                                <input type="text" name="txt_limitmargin"
											size="12" maxlength="8" style="text-align:right"
											onBlur="roundtxt(this)" onKeyPress="allowNumber(this)">
                              </td>
                              <td width="23%" >Period (in Months)</td>
                              <td  width="30%"> 
                                <input type="text"
											name="txt_limitperiod" size="6" maxlength="4"
											style="text-align:right" onKeyPress="allowNumber(this)">
                              </td>
                            </tr>
                            <tr> 
                              <td width="27%" nowrap="nowrap">Purpose</td>
                              <td width="20%"> 
                                <input type="text" name="txt_limitpurpose"
											size="50" maxlength="150" onKeyPress="notAllowSplChar(this)">
                              </td>
                              <td width="23%">Interest reset</td>
                              <td width="30%"> 
                                <textarea name="txt_limitintreset"
											wrap="VIRTUAL" cols="40" onKeyPress="notAllowSplChar(this);textlimit(this,3999)" onKeyUp="textlimit(this,3999)"></textarea>
                              </td>
                            </tr>
                            <tr> 
                              <td width="23%" nowrap="nowrap"> 
                                <input type="checkbox"
											name="chksublimit" value="N" style="border:none"
											onClick="callSublimit()">
                                Sub-Limits</td>
                              <td colspan="3">&nbsp;</td>
                            </tr>
                            <tr> 
                              <td width="23%"  nowrap="nowrap">Sub-Limit Head</td>
                              <td  width="30%"> 
                                <select name="subfacility_head"
											onChange="javascript:getFacility('sublimit');selectSublimit()">
                                  <option selected="selected" value="-">----Select----</option>
                                  <%h = new HashMap();
			h.put("value", "parent");
			h.put("parent", "0");
			h.put("hidMethod", "getFacility");
			hp1 = new HashMap();
			hp1.put("BeanId", "facilitymaster");
			hp1.put("MethodName", "getData");
			hp1.put("BeanParam", h);%>
                                  <lapschoice:selecttag value='<%= hp1%>'/> 
                                </select>
                                <input type="hidden" name="hid_subfacility_head">
                              </td>
                              <td width="27%" >Sub-Limit</td>
                              <td width="20%" > 
                                <select name="subfacility">
                                  <option selected="selected">----Select----</option>
                                </select>
                                <input type="hidden" name="hid_subfacility">
                              </td>
                            </tr>
                            <tr> 
                              <td width="23%" nowrap="nowrap">Existing Limits <span class="mantatory"><b>*</b></span></td>
                              <td width="30%"><lapschoice:CurrencyTag name="txt_sublimitexist" size="13" maxlength="10" /></td>
                              <td width="27%" nowrap="nowrap">Proposed Limit <span class="mantatory"><b>*</b></span></td>
                              <td width="20%"><lapschoice:CurrencyTag name="txt_sublimitproposed" size="13" maxlength="10" /></td>
                            </tr>
                            <tr> 
                              <td width="23%" nowrap="nowrap">Interest as per Credit Rating / Commission</td>
                              <td width="30%"> 
                                <input type="text" name="txt_sublimitcreditint" size="40" maxlength="40">
                              </td>
                              <td width="27%" nowrap="nowrap">Interest/Commission Proposed</td>
                              <td width="20%"> 
                                <input type="text"
											name="txt_sublimitproposedint" size="40" maxlength="40">
                              </td>
                            </tr>
                            <tr> 
                              <td width="27%" nowrap="nowrap">Margin(%)</td>
                              <td width="20%"><lapschoice:CurrencyTag name="txt_sublimitmargin"
											size="12" maxlength="8" /></td>
                              <td width="23%" >Period (in Months)</td>
                              <td  width="30%"> 
                                <input type="text"
											name="txt_sublimitperiod" size="6" maxlength="4"
											style="text-align:right" onKeyPress="allowNumber(this)">
                              </td>
                            </tr>
                            <tr> 
                              <td width="27%" nowrap="nowrap">Purpose</td>
                              <td width="20%"> 
                                <input type="text" name="txt_sublimitpurpose" size="50" maxlength="80" onKeyPress="notAllowSplChar(this)">
                              </td>
                              <td width="23%">Interest reset</td>
                              <td width="30%"> 
                                <textarea name="txt_sublimitintreset" wrap="VIRTUAL" cols="40" onKeyPress="notAllowSplChar(this);textlimit(this,3999)" onKeyUp="textlimit(this,3999)"></textarea>
                              </td>
                            </tr>
                          </table>
								</td>
							</tr>
						</table>
						<br>
						<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
						<br> 
						<table width="90%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
									<tr class="dataheader">
										<td width="5%">&nbsp;</td>
										<td align="center" width="20%"><b>Facility Head</b></td>
										<td align="center" width="18%"><b>Facility</b></td>
										<td align="center" width="14%"><b>Existing Limits</b></td>
										<td align="center" width="20%"><b>Proposed Limits</b></td>
										<td align="center" width="12%"><b>Interest</b></td>
										<td align="center" width="11%"><b>Margin(%)</b></td>
									</tr>
				<%String strSno = "";
			double dblamtexist = 0.0;
			double dblamtproposed = 0.0;
			if (arrRow != null && arrRow.size() > 0) {
				if (arrRow.size() > 0) {
					int count = 0;
					for (int i = 0; i < arrRow.size(); i++) {
						arrCol = (ArrayList) arrRow.get(i);
						strSno = Helper.correctNull((String) arrCol.get(13));
						if (Helper.correctNull((String) arrCol.get(12))
								.equalsIgnoreCase("0")) {
							dblamtexist = dblamtexist
									+ Double.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(3)));
							dblamtproposed = dblamtproposed
									+ Double.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(4)));
							count = 0;%>
									<tr class="datagrid">
										<td width="5%" align="center"><input type="radio"
											style="border:none" name="rdoUser"
											onClick="javascript:selectValues('<%=strSno%>','<%=Helper.correctNull((String)arrCol.get(12))%>')">
										<input type="hidden" name="hidfachead<%=strSno%>"
											value="<%=Helper.correctNull((String)arrCol.get(1))%>" /> <input
											type="hidden" name="hidfacility<%=strSno%>"
											value="<%=Helper.correctNull((String)arrCol.get(2))%>" /> <input
											type="hidden" name="hidlimitexist<%=strSno%>"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(3))))%>" />
										<input type="hidden" name="hidlimitproposed<%=strSno%>"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(4))))%>" />
										<input type="hidden" name="hidlimitcreditint<%=strSno%>"
											value="<%=Helper.correctNull((String)arrCol.get(5))%>" /> <input
											type="hidden" name="hidlimitproposedint<%=strSno%>"
											value="<%=Helper.correctNull((String)arrCol.get(6))%>" /> <input
											type="hidden" name="hidlimitmargin<%=strSno%>"
											value="<%=Helper.correctNull((String)arrCol.get(7))%>" /> <input
											type="hidden" name="hidlimitperiod<%=strSno%>"
											value="<%=Helper.correctNull((String)arrCol.get(8))%>" /> <input
											type="hidden" name="hidlimitpurpose<%=strSno%>"
											value="<%=Helper.correctNull((String)arrCol.get(9))%>" /> <input
											type="hidden" name="hidlimitintreset<%=strSno%>"
											value="<%=Helper.replaceForJavaScriptString(Helper.correctNull((String)arrCol.get(10)))%>" />
										<input type="hidden" name="hidfacsno<%=strSno%>"
											value="<%=Helper.correctNull((String)arrCol.get(13))%>" /> <input
											type="hidden" name="hidfacgroup<%=strSno%>"
											value="<%=Helper.correctNull((String)arrCol.get(12))%>" /></td>
										<td width="20%" >&nbsp; <%=Helper.correctNull((String) arrCol
											.get(14))%></td>
										<td width="18%" >&nbsp;<%=Helper.correctNull((String) arrCol
											.get(15))%></td>
										<td width="14%" align="right">&nbsp;<%=Helper
													.formatDoubleValue(Double
															.parseDouble(Helper
																	.correctDouble((String) arrCol
																			.get(3))))%></td>
										<td width="20%" align="right">&nbsp;<%=Helper
													.formatDoubleValue(Double
															.parseDouble(Helper
																	.correctDouble((String) arrCol
																			.get(4))))%></td>
										<td  width="12%">&nbsp;<%=Helper
													.correctNull((String) arrCol
															.get(6))%></td>
										<td align="right" width="11%">&nbsp;<%=Helper
													.correctNull((String) arrCol
															.get(7))%></td>
									</tr>
									<%} else if (!Helper.correctNull((String) arrCol.get(12))
								.equalsIgnoreCase("0")) {%>
									<tr class="dataheader">
										<%if (count == 0) {%>
										<td width="5%">&nbsp;</td>
										<td colspan="6"><b>&gt;&gt;Sub Limit</b></td>
									</tr>									
										<%}%>
										<tr class="datagrid">
										<td width="5%" align="center"><input type="radio"
											style="border:none" name="rdoUser"
											onClick="javascript:selectValues('<%=strSno%>','<%=Helper.correctNull((String)arrCol.get(12))%>')">
										<input type="hidden" name="hidfachead<%=strSno%>"
											value="<%=Helper.correctNull((String)arrCol.get(1))%>" /> <input
											type="hidden" name="hidfacility<%=strSno%>"
											value="<%=Helper.correctNull((String)arrCol.get(2))%>" /> <input
											type="hidden" name="hidlimitexist<%=strSno%>"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(3))))%>" />
										<input type="hidden" name="hidlimitproposed<%=strSno%>"
											value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(4))))%>" />
										<input type="hidden" name="hidlimitcreditint<%=strSno%>"
											value="<%=Helper.correctNull((String)arrCol.get(5))%>" /> <input
											type="hidden" name="hidlimitproposedint<%=strSno%>"
											value="<%=Helper.correctNull((String)arrCol.get(6))%>" /> <input
											type="hidden" name="hidlimitmargin<%=strSno%>"
											value="<%=Helper.correctNull((String)arrCol.get(7))%>" /> <input
											type="hidden" name="hidlimitperiod<%=strSno%>"
											value="<%=Helper.correctNull((String)arrCol.get(8))%>" /> <input
											type="hidden" name="hidlimitpurpose<%=strSno%>"
											value="<%=Helper.correctNull((String)arrCol.get(9))%>" /> <input
											type="hidden" name="hidlimitintreset<%=strSno%>"
											value="<%=Helper.correctNull((String)arrCol.get(10))%>" /> <input
											type="hidden" name="hidfacsno<%=strSno%>"
											value="<%=Helper.correctNull((String)arrCol.get(13))%>" /> <input
											type="hidden" name="hidfacgroup<%=strSno%>"
											value="<%=Helper.correctNull((String)arrCol.get(12))%>" /></td>
										<td width="20%" ><%=Helper.correctNull((String) arrCol
											.get(14))%>&nbsp;</td>
										<td width="18%" ><%=Helper.correctNull((String) arrCol
											.get(15))%>&nbsp;</td>
										<td width="14%" align="right">&nbsp;(<%=Helper
													.formatDoubleValue(Double
															.parseDouble(Helper
																	.correctDouble((String) arrCol
																			.get(3))))%>)</td>
										<td width="20%" align="right">&nbsp;(<%=Helper
													.formatDoubleValue(Double
															.parseDouble(Helper
																	.correctDouble((String) arrCol
																			.get(4))))%>)</td>
										<td  width="12%"><%=Helper
													.correctNull((String) arrCol
															.get(6))%>&nbsp;</td>
										<td align="right" width="11%">&nbsp;<%=Helper
													.correctNull((String) arrCol
															.get(7))%></td>
									</tr>
									<%count++;}}}%>
									<tr class="dataheader">
										<td colspan="2">&nbsp;</td>
										<td align="right"><b>Total</b></td>
										<td align="right">&nbsp;<%=Helper.formatDoubleValue(dblamtexist)%></td>
										<td align="right" width="20%">&nbsp;<%=Helper.formatDoubleValue(dblamtproposed)%></td>
										<td width="12%">&nbsp;</td>
										<td align="right" width="11%">&nbsp;</td>
									</tr>
									<%} else {%>
									<tr class="datagrid">
										<td align="center" colspan="7">No Data Found</td>
									</tr>
									<%}%>
								</table>
								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
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
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="hidsno" value=""> 
<input type="hidden" name="hidfacgrp" value=""> 
<input type="hidden" name="hidfactype"> 
<input type="hidden" name="hidGrpList">
<input type="hidden" name="hidvaluesin" value="<%=Helper.correctNull((String) hshValues.get("valuesin"))%>">
<iframe	height="0" width="0" id="ifrm1" frameborder="0" style="border:0"></iframe>
<iframe height="0" width="0" id="ifrm2" frameborder="0" style="border:0"></iframe>
<script>
						     var msg ="<%=Helper.correctNull((String) hshValues.get("msg"))%>";
						     if(msg!="")
						     {
						   	  alert(msg);
						     }						      
						     </script>
</form>
</body>
</html>
