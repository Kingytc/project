<%@include file="../share/directives.jsp"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>

<%
ArrayList arrRow = new ArrayList();
			ArrayList arrCol = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrRow");
			String strSector = Helper.correctNull((String) request.getParameter("hidsector"));
			String strSaral = Helper.correctNull((String) request.getParameter("hidsaral"));
			String strApploantype = Helper.correctNull((String) request.getParameter("apploantype"));
			String strApplevel = Helper.correctNull((String) request.getParameter("applevel"));
			
			String strValuesin = Helper.correctNull((String) request.getParameter("valuesin"));

			if (strValuesin.equals("L")) {
				strValuesin = " in Lacs";
			} else {
				strValuesin = "";
			}
			String strappholder = Helper.correctNull((String) request.getParameter("appholder"));
			/*  
			for select borrower type when coming through saral application. 
			while comming saral inwardregister session will not available			
			*/
			String strappliedfor = Helper.correctNull((String) request.getParameter("appliedfor"));
			 if(strappliedfor.equals(""))
			 {
				 strappliedfor = Helper.correctNull((String) hshValues.get("appliedfor")); 
			 }
			String strProposal= Helper.correctNull((String)request.getParameter("hidproposal"));
			
			//String requesttype=Helper.correctNull((String)session.getAttribute("hidproposal"));
			//Added by Zahoorunnisa.S for button functionality
           String strstatus = Helper.correctNull((String) request.getParameter("hidstatus"));
			
	    if (strstatus.equals(""))
		    strstatus = Helper.correctNull((String) hshValues.get("status"));
	   
	    String strapplevel = Helper.correctNull((String)request.getParameter("applevel"));
		//end
	
		%>

<html>
<head>
<title>Facility For Recommendation</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<!--<link rel="stylesheet"-->
<!--	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"-->
<!--	type="text/css">-->
	<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
<script>

var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varOrgLevel="<%=strOrgLevel%>";
var varright= "<%=Helper.correctNull((String) session.getAttribute("strGroupRights")).charAt(18)%>";
function selectValues(varsno, vargrp)
{
	if(vargrp=="0")
	{
		document.forms[0].selnaturefac.value=document.forms[0].elements["hidfacnature"+varsno].value;
		document.forms[0].txt_facility.value=document.forms[0].elements["hidfacility"+varsno].value;
		document.forms[0].txt_limitapplied.value=document.forms[0].elements["hidappamt"+varsno].value;
		document.forms[0].txt_purpose.value=document.forms[0].elements["hidpupose"+varsno].value;
		document.forms[0].txt_limitrecomd.value=document.forms[0].elements["hidrecmdamt"+varsno].value;
		document.forms[0].txt_limitexist.value=document.forms[0].elements["hidexistamt"+varsno].value;		
		
		document.forms[0].selsubnaturefac.value="0";
		document.forms[0].txt_subfacility.value="";
		document.forms[0].txt_sublimitapplied.value="";
		document.forms[0].txt_subpurpose.value="";
		document.forms[0].txt_sublimitrecomd.value="";
		document.forms[0].chksublimit.checked=false;
		document.forms[0].chksublimit.value="N";
		document.forms[0].txt_sublimitexist.value="";
		document.forms[0].hidfactype.value="limit";
		
	}
	else
	{
		document.forms[0].selnaturefac.value=document.forms[0].elements["hidfacnature"+vargrp].value;
		document.forms[0].txt_facility.value=document.forms[0].elements["hidfacility"+vargrp].value;
		document.forms[0].txt_limitapplied.value=document.forms[0].elements["hidappamt"+vargrp].value;
		document.forms[0].txt_purpose.value=document.forms[0].elements["hidpupose"+vargrp].value;
		document.forms[0].txt_limitrecomd.value=document.forms[0].elements["hidrecmdamt"+vargrp].value;
		document.forms[0].txt_limitexist.value=document.forms[0].elements["hidexistamt"+vargrp].value;		
		
		document.forms[0].selsubnaturefac.value=document.forms[0].elements["hidfacnature"+varsno].value;
		document.forms[0].txt_subfacility.value=document.forms[0].elements["hidfacility"+varsno].value;
		document.forms[0].txt_sublimitapplied.value=document.forms[0].elements["hidappamt"+varsno].value;
		document.forms[0].txt_subpurpose.value=document.forms[0].elements["hidpupose"+varsno].value;
		document.forms[0].txt_sublimitrecomd.value=document.forms[0].elements["hidrecmdamt"+varsno].value;
		document.forms[0].txt_sublimitexist.value=document.forms[0].elements["hidexistamt"+varsno].value;
		
		document.forms[0].chksublimit.checked=true;
		document.forms[0].chksublimit.value="Y";
		document.forms[0].hidfactype.value="sublimit";
	}
	document.forms[0].hidsno.value=varsno;
	document.forms[0].hidfacgrp.value=vargrp;
	
	
	//Added By Zahoorunnisa.S for Button Functionality after discussion with Suresh

	//If access through the Loan Application Register and its at Branch 
	if("<%=strSaral%>"=="saral" && "<%=strOrgLevel%>"=="A"){ 
		//If the Application is in open status
		if("<%=strstatus%>"=="O"  &&  varright=="w"){
		    enableButtons(true,false,true,true,true,false);
		}else{
			enableButtons(true,true,true,true,true,false);	
		}
			
	} else if("<%=strSaral%>"=="saral" && "<%=strapplevel%>" == ""){ 
		
		enableButtons(true,true,true,true,true,false);	
		
    }else{
		
		if("<%=strapplevel%>" == "S"){
			enableButtons(true,true,true,true,true,false);
		}
	}

	//End

	
	//End

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
	
	if(document.forms[0].hidfactype.value=="sublimit")
	{	
		document.forms[0].txt_facility.readOnly=true;
		document.forms[0].txt_limitapplied.readOnly=true;
		document.forms[0].txt_purpose.readOnly=true;
		document.forms[0].txt_limitrecomd.readOnly=true;
		document.forms[0].txt_limitexist.readOnly=true;
	}
}

	  
	function onloading()
	{	 
		
		//Added By Zahoorunnisa.S for Button Functionality after discussion with Suresh
		
		//If access through the Loan Application Register and its at Branch 
		if("<%=strSaral%>"=="saral" && "<%=strOrgLevel%>"=="A"){ 
			//If the Application is in open status
			if("<%=strstatus%>"=="O"  &&  varright=="w"){
			    enableButtons(false,true,true,true,true,false);
			}else{
				enableButtons(true,true,true,true,true,false);	
			}
				
		} else if("<%=strSaral%>"=="saral" && "<%=strapplevel%>" == ""){ 
			
			enableButtons(true,true,true,true,true,false);
				
	    }else{
			
			if("<%=strapplevel%>" == "S"){
				enableButtons(true,true,true,true,true,false);
			}
		}

		//End

		disableFields(true);
	}


function callDisable(one)
{
for(var i=0;i<document.forms[0].elements.length;i++)
	{
	if(document.forms[0].elements[i].type=="radio")
{
		document.forms[0].elements[i].disabled=one;
}
	}
}

function doSave()
{
	if(document.forms[0].hidfactype.value=="limit")
	{
		if(document.forms[0].selnaturefac.selectedIndex == "0")
		{
			ShowAlert(111,'Nature of Facility');
			return false;
		}
		else if(document.forms[0].txt_limitapplied.value == "")
		{
			ShowAlert(112,'Limits Applied for');
			return false;
		}
		else if(document.forms[0].txt_limitrecomd.value == "")
		{
			ShowAlert(112,'Limits recommending for');
			return false;
		}
		else if(document.forms[0].txt_limitexist.value == "")
		{
			ShowAlert(112,'Existing limits');
			return false;
		}
		else if(eval(document.forms[0].txt_limitrecomd.value)>eval(document.forms[0].txt_limitapplied.value))
		{
			alert('Recommended Amount cannot be greater than applied amount');
			return false;
		}
	}
	else
	{
		if(document.forms[0].selsubnaturefac.selectedIndex == "0")
		{
			ShowAlert(111,'Nature of Facility for Sublimit');
			return false;
		}
		else if(document.forms[0].txt_sublimitapplied.value == "")
		{
			ShowAlert(112,'Limits Applied for sublimit');
			return false;
		}
		else if(document.forms[0].txt_sublimitrecomd.value == "")
		{
			ShowAlert(112,'Limits recommending for sublimit');
			return false;
		}
		else if(document.forms[0].txt_sublimitexist.value == "")
		{
			ShowAlert(112,'Existing limits for sublimit');
			return false;
		}
		else if(eval(document.forms[0].txt_sublimitapplied.value)>eval(document.forms[0].txt_limitapplied.value))
		{
			alert('Sublimit applied amount cannot be greater than Main limit applied amount');
			return false;
		}
		else if(eval(document.forms[0].txt_sublimitrecomd.value)>eval(document.forms[0].txt_limitrecomd.value))
		{
			alert('Sublimit Recommended amount cannot be greater than Main limit Recommended amount');
			return false;
		}
		else if(eval(document.forms[0].txt_sublimitexist.value)>eval(document.forms[0].txt_limitexist.value))
		{
			alert('Sublimit Existing amount cannot be greater than Main limit Existing amount');
			return false;
		}
		else if(eval(document.forms[0].txt_sublimitrecomd.value)>eval(document.forms[0].txt_sublimitapplied.value))
		{
			alert('Recommended Amount cannot be greater than applied amount');
			return false;
		}
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="inwardRegister";		
	document.forms[0].hidSourceUrl.value="/action/facilityrecmdforsanc.jsp";
	document.forms[0].hidBeanMethod.value="updatebrrecmdfacility";
	document.forms[0].hidBeanGetMethod.value="getbrrecmdfacility";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doDelete()
{
	if(document.forms[0].hidsno.value!="")
	{
		if(ConfirmMsg(101))
		{
			document.forms[0].hidAction.value ="delete";
			document.forms[0].hidBeanMethod.value="updatebrrecmdfacility";
			document.forms[0].hidBeanGetMethod.value="getbrrecmdfacility";	
			document.forms[0].hidBeanId.value="inwardRegister";
			document.forms[0].hidSourceUrl.value="action/facilityrecmdforsanc.jsp";	
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].submit();	
		}	
	}
	else
	{
		alert("Select Facility to delete");
		return;
	}
}

function doNew()
{
	disableFields(false);
    document.forms[0].hidAction.value ="insert";
    document.forms[0].hideditflag.value="Y";
    disableCommandButtons(true,true,false,true,false,true);
    if(document.forms[0].hidfactype.value=="sublimit")
    {
   		document.forms[0].hidfacgrp.value=document.forms[0].hidsno.value;
    	document.forms[0].selsubnaturefac.focus();
    }
    else
    {
  		document.forms[0].selnaturefac.value="0";
		document.forms[0].txt_facility.value="";
		document.forms[0].txt_purpose.value="";
		document.forms[0].txt_limitapplied.value="";
		document.forms[0].txt_limitrecomd.value="";
		document.forms[0].hidfactype.value="limit";
		document.forms[0].txt_limitexist.value="";
		document.forms[0].selnaturefac.focus();
	}
	
}

function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	document.forms[0].hideditflag.value="Y";
	disableCommandButtons(true,true,false,false,false,true);
	document.forms[0].selnaturefac.focus();
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="";
		document.forms[0].hidBeanId.value="inwardRegister";
		document.forms[0].hidBeanGetMethod.value="getbrrecmdfacility";
		document.forms[0].action=appURL+"action/facilityrecmdforsanc.jsp";
		document.forms[0].submit();
	}
}
   
 function disableCommandButtons(cmdnew,cmdedit,cmdapply,cmddel,cmdcancel,cmdclose)
 {  
	  document.forms[0].cmdnew.disabled =cmdnew;
	  document.forms[0].cmdedit.disabled=cmdedit;	  
	  document.forms[0].cmdsave.disabled=cmdapply;
	  document.forms[0].cmddelete.disabled=cmddel;
	  document.forms[0].cmdcancel.disabled=cmdcancel;
	  document.forms[0].cmdclose.disabled=cmdclose;
 }
 function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}
}
function enableButtons(valnew,valedit,valapply,valcancel,valdel,valclose)
{
	document.forms[0].cmdnew.disabled=valnew;
	document.forms[0].cmdedit.disabled=valedit;	  	
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmddelete.disabled=valdel;
	document.forms[0].cmdclose.disabled=valclose;
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
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>
DIV.cellContainer {	
  width: 100%; height: 140;
  overflow: auto;
}
</STYLE>

</head>
<body  onload="onloading()">
<form method="post" name="frmbrrecmd" class="normal">
<%if (strSaral.equalsIgnoreCase("saral")) {%>
<lapschoice:saralreportTag tabid="6" sector='<%=strSector%>'	applied='<%=strappliedfor%>'  proposal='<%=strProposal%>' /> <lapschoice:inward /> <%}

else if (strApploantype.equalsIgnoreCase("c")) {%>

<lapstab:ComReportTab tabid="4"
	applevel="<%=Helper.correctNull((String)request.getParameter("applevel"))%>"
	applied="<%=strappliedfor%>" /> <span style="display:none"><lapschoice:borrowertype /></span>
<lapschoice:application /> <%} else if (strApploantype.equalsIgnoreCase("T")) {%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td valign="top"><jsp:include page="../share/applurllinkscom.jsp"
			flush="true">
			<jsp:param name="pageid" value="10" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<b><i> Home -&gt;
Tertiary -&gt; Application -&gt; Reports -&gt; Recommendation by Branch</i></b>
 <span
	style="visibility:hidden"><lapschoice:borrowertype /></span> <lapschoice:application />
<lapstab:TerReportTab tabid="3" applevel='<%=strApplevel%>'
	applied='<%=strappliedfor%>' /> <%} else if (strApploantype.equalsIgnoreCase("P")) {%>
<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable border1">
	<tr>
		<td id="mainlnk1"><jsp:include page="../share/Applurllinkper.jsp"
			flush="true">
			<jsp:param name="pageid" value="10" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Retail
		 -&gt; Appraisal
		-&gt; Recommendation by Branch</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td id="mainlnk1"><lapschoice:application /></td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable border1">
	<tr>
		<td><jsp:include page="../share/apprlinktab.jsp" flush="true">
			<jsp:param name="tabid" value="12" />
		</jsp:include></td>
	</tr>

  <% }
	 else if((strCategoryType.equals("ADC") ||strCategoryType.equals("STL")||strCategoryType.equals("SRE")) &&(strApplevel.equals("S"))) 
			{
			%>
			<tr>
			 <td valign="top"> 
	        <jsp:include page="../share/applurllinkscom.jsp" flush="true">         
	        <jsp:param name="pageid" value="16" />
	        <jsp:param name="cattype" value="<%=strCategoryType%>" />
	        <jsp:param name="ssitype" value="<%=strSSIType%>" />
	        </jsp:include>
	         </td>	</tr> <tr>
	 <%if(strCategoryType.equals("ADC")) {%>
		 <td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Adhoc Limit -&gt; Saral -&gt; Facilities
		 </td>
		 <%}
	     else if(strCategoryType.equals("STL")) {%>
	       <td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Short Term Loan -&gt; Saral -&gt; Facilities
		 </td>
		  <%}
	     else if(strCategoryType.equals("SRE")) {%>
	       <td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Short Review Extension -&gt; Saral -&gt; Facilities
		 </td>
		 <%} %>
	</tr>
			<tr>
			<td>
			<lapschoice:borrowertype /> <lapschoice:application/>
			<lapschoice:saralappinwardtag tabid="6" sector="<%=strCategoryType%>"	applied="<%=strappliedfor%>"  />
			</td></tr>
			
			
			<%} %>
			</table>
<%-- 
<table width="40%" border="0" cellspacing="3" cellpadding="5"
	bgcolor="#DEDACF">
	<tr>
		<td class="tabactivenew" align="center"><b> Facility </b></td>
		<td class="tabinactivenew" align="center"><b> <a
			href="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','inwardRegister','getbrrecmdsecurity','securityrecmdforsanction.jsp')"
			onMouseOut="window.status='';return true;" class="blackfont">Security</a>
		</b></td>

		<td class="tabinactivenew" align="center"><b> <a
			href="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','inwardRegister','getbrrecmd','recmdforsanction.jsp')"
			onMouseOut="window.status='';return true;" class="blackfont">Comments</a>
		</b></td>
	</tr>
</table>
--%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable ">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable border1">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="5"
					class="outertable">
					<tr>
						<td valign="top">
						<table width="80%" border="0" cellspacing="0" cellpadding="0"
							align="center" class="outertable border1">
							<tr>
								<td>
								
                          <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                            <tr> 
                              <td width="24%" nowrap="nowrap">Nature of Facility <b>*</b></td>
                              <td width="25%"> 
                                <select name="selnaturefac" tabindex="1">
                                  <option value="0" selected="selected">&lt;----Select----&gt;</option>
                                  <option value="1">Contingent Limits</option>
                                  <option value="2">Working capital Limits</option>
                                  <option value="3">Term Loan/DPGL Limits</option>
                                </select>
                              </td>
                              <td width="21%" nowrap="nowrap">Facility Type</td>
                              <td width="30%"> 
                                <input type="text" name="txt_facility"
											size="25" maxlength="50" tabindex="2">
                              </td>
                            </tr>
                            <tr> 
							<td width="21%" nowrap="nowrap">Existing Limits (<%=ApplicationParams.getCurrency()%><%=strValuesin%>)<font
											color="#FF0000"><b>*</b></td>
                              <td width="30%"> 
                                <input type="text" name="txt_limitexist"
											size="15" maxlength="20" tabindex="3"
											style="text-align:right" onBlur="roundtxt(this)"
											onKeyPress="allowNumber(this)">
                              </td>
                              <td width="24%" nowrap="nowrap">Limits Applied for (<%=ApplicationParams.getCurrency()%><%=strValuesin%>)<font
											color="#FF0000"><b>*</b></td>
                              <td width="25%"> 
                                <input type="text" name="txt_limitapplied"
											size="15" maxlength="20" tabindex="4"
											style="text-align:right" onBlur="roundtxt(this)"
											onKeyPress="allowNumber(this)">
                              </td>
                              
                            </tr>
                            <tr>
							<td width="21%">Purpose</td>
                              <td width="30%"> 
                                <input type="text" name="txt_purpose"
											size="25" maxlength="50" tabindex="5">
                              </td>
                             
                              <td width="24%" nowrap="nowrap">Limits recommended (<%=ApplicationParams.getCurrency()%><%=strValuesin%>)<font
											color="#FF0000"><b>*</b></td>
                              <td width="25%"> 
                                <input type="text"
											name="txt_limitrecomd" size="15" tabindex="6" maxlength="20"
											style="text-align:right" onBlur="roundtxt(this)"
											onKeyPress="allowNumber(this)">
                              </td>
                              </tr>
                            <tr> 
                              <td width="24%" nowrap="nowrap">&nbsp;</td>
                              <td colspan="3">&nbsp;</td>
                            </tr>
                            <tr> 
                              <td width="24%" nowrap="nowrap"> 
                                <input type="checkbox"
											name="chksublimit" value="N" style="border:none"
											onClick="callSublimit()" tabindex="6">
                                Sub-Limits</td>
                              <td colspan="3">&nbsp;</td>
                            </tr>
                            <tr> 
                              <td width="24%" nowrap="nowrap">Nature of Facility <b>*</b></td>
                              <td width="25%"> 
                                <select name="selsubnaturefac" tabindex="7">
                                  <option value="0" selected="selected">&lt;----Select----&gt;</option>
                                  <option value="1">Contingent Limits</option>
                                  <option value="2">Working capital Limits</option>
                                  <option value="3">Term Loan/DPGL Limits</option>
                                </select>
                              </td>
                              <td width="21%" nowrap="nowrap">Facility Type</td>
                              <td width="30%"> 
                                <input type="text" name="txt_subfacility"
											size="25" maxlength="50" tabindex="8">
                              </td>
                            </tr>
                            <tr> 
							<td width="21%" nowrap="nowrap">Existing Limits (<%=ApplicationParams.getCurrency()%><%=strValuesin%>)<font
											color="#FF0000"><b>*</b></td>
                              <td width="30%"> 
                                <input type="text" name="txt_sublimitexist"
											size="15" maxlength="20" tabindex="9"
											style="text-align:right" onBlur="roundtxt(this)"
											onKeyPress="allowNumber(this)">
                              </td>
                            
                              <td width="24%" nowrap="nowrap">Limits Applied for (<%=ApplicationParams.getCurrency()%><%=strValuesin%>)<font
											color="#FF0000"><b>*</b></td>
                              <td width="25%"> 
                                <input type="text" name="txt_sublimitapplied"
											size="15" maxlength="20" tabindex="10"
											style="text-align:right" onBlur="roundtxt(this)"
											onKeyPress="allowNumber(this)">
                              </td>
                              </tr>
                            <tr> 
							<td>Purpose</td>
                              <td> 
                                <input type="text" name="txt_subpurpose"
											size="25" maxlength="50" tabindex="11">
                              </td>
                            
                              <td width="24%" nowrap="nowrap">Limits recommended (<%=ApplicationParams.getCurrency()%><%=strValuesin%>)<font
											color="#FF0000"><b>*</b></td>
                              <td> 
                                <input type="text"
											name="txt_sublimitrecomd" size="15" tabindex="12"
											maxlength="20" style="text-align:right"
											onBlur="roundtxt(this)" onKeyPress="allowNumber(this)">
                              </td>
                              </tr>
                          </table>
								</td>
							</tr>
						</table>
					</td>
					</tr>
						<lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
	
						
					<tr>
						<td>
						<table width="90%" border="0" cellspacing="0" cellpadding="0"
							align="center" class="outertable border1">
							<tr>
								<td>
								
                          <table width="100%" border="0" cellspacing="1" cellpadding="3"
								class="outertable ">
                            <tr class="dataHeader"> 
                              <td width="5%" >&nbsp;</td>
                              <td align="center" width="20%"><b>Nature 
                                of Facility</b></td>
                              <td align="center" width="12%" ><b>Facility 
                                Type</b></td>
                              <td align="center" width="13%" ><b>Existing Limits (<%=ApplicationParams.getCurrency()%><%=strValuesin%>)</b></td>
                              <td align="center" width="10%"><b>Limits 
                                Applied for (<%=ApplicationParams.getCurrency()%><%=strValuesin%>)</b></td>
                              <td align="center" width="27%" ><b>Purpose</b></td>
                              <td align="center" width="13%"><b>Limits 
                                recommended (<%=ApplicationParams.getCurrency()%><%=strValuesin%>)</b></td>
                            </tr>
                          </table>
						<!--<div class="cellContainer">	-->
                          <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
                            <%
                            String sel_val;
                            String strSno="";
                            double dblamtapplied=0.0;
                            double dblamtrecmd=0.0;
			if (arrRow != null && arrRow.size() > 0) {
				if (arrRow.size() > 0) {
					int count=0;
					for (int i = 0; i < arrRow.size(); i++) {
						arrCol = (ArrayList) arrRow.get(i);
						sel_val = "";
						if (Helper.correctNull((String) arrCol.get(0)).equals("1"))
							sel_val = "Contingent Limits";
						else if (Helper.correctNull((String) arrCol.get(0)).equals("2"))
							sel_val = "Working capital Limits";
						else if (Helper.correctNull((String) arrCol.get(0)).equals("3"))
							sel_val = "Term Loan/DPGL Limits";
						strSno=Helper.correctNull((String)arrCol.get(5));
						if(Helper.correctNull((String)arrCol.get(6)).equalsIgnoreCase("0")){
							dblamtapplied=dblamtapplied+Double.parseDouble(Helper.correctDouble((String)arrCol.get(2)));
							dblamtrecmd=dblamtrecmd+Double.parseDouble(Helper.correctDouble((String)arrCol.get(4)));
							count=0;
						%>
                            <tr class="dataGridcolor"> 
                              <td width="5%" align="center"> 
                                <input type="radio"
											style="border:none" name="rdoUser"
											onClick="javascript:selectValues('<%=strSno%>','<%=Helper.correctNull((String)arrCol.get(6))%>')">
                                <input type="hidden" name="hidfacnature<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(0))%>"/>
                                <input type="hidden" name="hidfacility<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(1))%>"/>
                                <input type="hidden" name="hidappamt<%=strSno%>" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(2))))%>"/>
                                <input type="hidden" name="hidpupose<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(3))%>"/>
                                <input type="hidden" name="hidrecmdamt<%=strSno%>" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(4))))%>"/>
                                <input type="hidden" name="hidfacsno<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(5))%>"/>
                                <input type="hidden" name="hidfacgroup<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(6))%>"/>
                                 <input type="hidden" name="hidexistamt<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(7))%>"/>
                              </td>
                              <td width="20%" align="left">&nbsp; <%=sel_val%></td>
                              <td width="12%" align="left">&nbsp;<%=Helper.correctNull((String) arrCol.get(1))%></td>
                              <td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(7))))%></td>
                              <td width="10%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(2))))%></td>
                              <td align="left" width="27%">&nbsp;<%=Helper.correctNull((String) arrCol.get(3))%></td>
                              <td align="right" width="13%">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(4))))%></td>
                            </tr>
                            <%}else if(!Helper.correctNull((String)arrCol.get(6)).equalsIgnoreCase("0")){ 
							
						%>
                            <tr class="dataGridcolor"> 
                              <%if(count==0){ %>
                              <td >&nbsp;</td>
                              <td colspan="6"  ><b>&gt;&gt;Sub 
                                Limit</b></td>
                            </tr>
                            <tr class="dataGridcolor"> 
                              <%} %>
                              <td width="5%" align="center"> 
                                <input type="radio"
											style="border:none" name="rdoUser"
											onClick="javascript:selectValues('<%=strSno%>','<%=Helper.correctNull((String)arrCol.get(6))%>')">
                                <input type="hidden" name="hidfacnature<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(0))%>"/>
                                <input type="hidden" name="hidfacility<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(1))%>"/>
                                <input type="hidden" name="hidappamt<%=strSno%>" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(2))))%>"/>
                                <input type="hidden" name="hidpupose<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(3))%>"/>
                                <input type="hidden" name="hidrecmdamt<%=strSno%>" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(4))))%>"/>
                                <input type="hidden" name="hidfacsno<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(5))%>"/>
                                <input type="hidden" name="hidfacgroup<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(6))%>"/>
                                 <input type="hidden" name="hidexistamt<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(7))%>"/>
                              </td>
                              <td width="20%" align="left"><%=sel_val%>&nbsp;</td>
                              <td width="12%" align="left"><%=Helper.correctNull((String) arrCol.get(1))%>&nbsp;</td>
                              <td width="13%" align="right">&nbsp;(<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(7))))%>)</td>
                              <td width="10%" align="right">&nbsp;(<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(2))))%>)</td>
                              <td align="left" width="27%"><%=Helper.correctNull((String) arrCol.get(3))%>&nbsp;</td>
                              <td align="right" width="13%">&nbsp;(<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(4))))%>)</td>
                            </tr>
                            <%
						count++;
						}
						}
				}
			 %>
                            <tr class="dataGridcolor"> 
                              <td colspan="2">&nbsp;</td>
                              <td align="right" colspan="2"><b>Total</b></td>
                              <td align="right">&nbsp;<%=Helper.formatDoubleValue(dblamtapplied)%></td>
                              <td>&nbsp;</td>
                              <td align="right">&nbsp;<%=Helper.formatDoubleValue(dblamtrecmd)%></td>
                            </tr>
                            <%}else {

			%>
                            <tr> 
                              <td align="center" colspan="7">No Data Found</td>
                            </tr>
                            <%}

		%>
                          </table>
								<!--</div>-->
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
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="hidsno" value="">
<input type="hidden" name="hidfacgrp" value="">
<input type="hidden" name="hidfactype">

							
</form>
</body>
</html>
