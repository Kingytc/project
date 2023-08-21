<%@include file="../share/directives.jsp"%>
<%

String[] MOV_DESCRIPTION=new String[10];
String[] IMMOV_DESCRIPTION=new String[10];
String[] MOV_VALUE=new String[10];
String[] IMMOV_VALUE=new String[10];


String MOV_TOTAL=Helper.correctDouble((String)hshValues.get("CR_MOV_TOTAL"));
double mov_total=Double.parseDouble(MOV_TOTAL);
String IMMOV_TOTAL=Helper.correctDouble((String)hshValues.get("CR_IMMOV_TOTAL"));
double immov_total=Double.parseDouble(IMMOV_TOTAL);

MOV_DESCRIPTION=(String[])hshValues.get("CR_MOV_DESCRIPTION");
MOV_VALUE=(String[])hshValues.get("CR_MOV_VALUE");
IMMOV_DESCRIPTION=(String[])hshValues.get("CR_IMMOV_DESCRIPTION");
IMMOV_VALUE=(String[])hshValues.get("CR_IMMOV_VALUE");

String Busability=Helper.correctNull((String)hshValues.get("CR_Busability"));
String BusConducted=Helper.correctNull((String)hshValues.get("CR_BusConducted"));
String BusReputation=Helper.correctNull((String)hshValues.get("CR_BusReputation"));
String BusCondition=Helper.correctNull((String)hshValues.get("CR_BusCondition"));

String comapp_compname=Helper.correctNull((String)hshValues.get("comapp_compname1"));
String strCons =Helper.correctNull((String)request.getParameter("chkCons"));
if(strCons.equalsIgnoreCase(""))
{
	strCons=Helper.correctNull((String)hshValues.get("chkCons"));
}

String appstatus=(String)request.getParameter("appstatus");
String strSaral=Helper.correctNull((String)request.getParameter("hidsaral"));
String strSector=Helper.correctNull((String)request.getParameter("hidsector"));
String strappholder =Helper.correctNull((String)request.getParameter("appholder"));
String strappliedfor=Helper.correctNull((String)request.getParameter("appliedfor"));
%>

<html>
<head>
<title>Credit Information Report</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=appstatus%>";
var varsaral="<%=strSaral%>";
var currentdate= "<%=Helper.getCurrentDateTime()%>";
var varOrgLevel="<%=strOrgLevel%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function disableCommandButtons(val)
{
	if(val=="load")
	{  
		if(appstatus=="op")
			{
				disableFields(true);
				document.forms[0].cmdedit.disabled=false;
				document.forms[0].cmddelete.disabled=true;
				document.forms[0].cmdsave.disabled=true;
				document.forms[0].cmdcancel.disabled=true;
				document.forms[0].cmdclose.disabled=false;	
			}
			else if(appstatus=="ca"  || appstatus=="pa")
			{
				disableFields(true);
				document.forms[0].cmdedit.disabled=true;
				document.forms[0].cmddelete.disabled=true;
				document.forms[0].cmdsave.disabled=true;
				document.forms[0].cmdcancel.disabled=true;
				document.forms[0].cmdclose.disabled=false;	
			}	 	 
			else
			{
				disableFields(true);
				document.forms[0].cmdedit.disabled=false;
				document.forms[0].cmddelete.disabled=true;
				document.forms[0].cmdsave.disabled=true;
				document.forms[0].cmdcancel.disabled=true;
				document.forms[0].cmdclose.disabled=false;	
			}
	}
	
	if(val=="edit")
	{	 
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=false;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}
}
function enableButtons(valnew,valattach,valdetach,valedit,valapply,valcancel,valdel,valclose)
{
	document.forms[0].cmdedit.disabled=valedit;	  	
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmddelete.disabled=valdel;
	document.forms[0].cmdclose.disabled=valclose;
}
function onLoading()
{	
	var Busability="<%=Busability%>";
	var BusConducted="<%=BusConducted%>";
	var BusReputation="<%=BusReputation%>";
	var BusCondition="<%=BusCondition%>";
	
	if(Busability!="")
	{
		document.forms[0].sel_busability.value=Busability;
	}
	else
	{
		document.forms[0].sel_busability.value="0";
	}
	if(BusConducted!="")
	{
		document.forms[0].sel_busconduct.value=BusConducted;
	}
	else
	{
		document.forms[0].sel_busconduct.value="0";
	}
	if(BusReputation!="")
	{
		document.forms[0].sel_busreputation.value=BusReputation;
	}
	else
	{
		document.forms[0].sel_busreputation.value="0";
	}
	if(BusCondition!="")
	{
		document.forms[0].sel_buscondtion.value=BusCondition;
	}
	else
	{
		document.forms[0].sel_buscondtion.value="0";
	}
		
	if (("<%=strSaral%>"=="saral"))
	{ //For Saral Application , Branch User Through Mail
		if(varOrgLevel=='A' && document.forms[0].hid_slno.value!="")
		{
			enableButtons(false,true,true,false,true,true,true,false);
		}
		else if(varOrgLevel=='A')
		{
			enableButtons(false,true,true,true,true,true,true,false);
		}
		else 
		{
			enableButtons(true,true,true,true,true,true,true,false);
		}
	}
	else if((varOrgLevel=='D') && (document.forms[0].applevel.value=='S'))
	{ //For Saral Application , Saral User Link
			enableButtons(true,true,true,true,true,true,true,false);
	}
	else 
	{  //For all others
		if(varOrgLevel==document.forms[0].applevel.value && document.forms[0].btnenable.value=="Y")
		{//For the users, in the application created organisation other than SARAL throgh link
			enableButtons(true,true,true,false,true,true,true,false);
		}
		else
		{//For the users, other than application created organisation other than SARAL throgh link
			enableButtons(true,true,true,true,true,true,true,false);
		}
	}
	disableFields(true);
}
function doEdit()
{ 	
	if(varsaral != "saral")
	{
		if(document.forms[0].hid_appid.value!='S')
		{
			disableFields(false);
			document.forms[0].hidAction.value ="U";
			disableCommandButtons("edit");	
		}
		else
		{
			alert("Select Name to Edit");
		}	
	}
	else
	{
		disableFields(false);
		document.forms[0].hidAction.value ="U";
		disableCommandButtons("edit");	
	}
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="lapsReport";
		document.forms[0].hidBeanGetMethod.value="getCreditreport2";
		document.forms[0].action=appUrl +"action/creditreport4.jsp";
		document.forms[0].submit(); 		
	}	
}

function doSave()
{
	if(document.forms[0].txt_indlibpartner.value=='')
	{
		alert("Enter Particulars of Liabilities");
		document.forms[0].txt_indlibpartner.focus();
		return;
	}
	if(document.forms[0].sel_busability.value=='0')
	{
		alert("Select Business Ability");
		document.forms[0].sel_busability.focus();
		return;
	}
	if(document.forms[0].sel_busconduct.value=='0')
	{
		alert("Select Business Conducted");
		document.forms[0].sel_busconduct.focus();
		return;
	}
	if(document.forms[0].sel_busreputation.value=='0')
	{
		alert("Select Business Reputation");
		document.forms[0].sel_busreputation.focus();
		return;
	}
	if(document.forms[0].sel_buscondtion.value=='0')
	{
		alert("Select Condition of Business");
		document.forms[0].sel_buscondtion.focus();
		return;
	}
	if(document.forms[0].txt_meansason.value=="")
	{
		alert('Enter Means as on');
		return;
	}
	for(var i=0;i<10;i++)
	{	
		if(document.forms[0].txt_movdesc[i].value!="")
		{	
			if(document.forms[0].txt_movvalue[i].value=="")
			{
				alert("Enter Movable Assets value for " +document.forms[0].txt_movdesc[i].value);
				document.forms[0].txt_movvalue[i].focus();
				return;
			}
		}
	}
	for(var i=0;i<10;i++)
	{	
		if(document.forms[0].txt_immovdesc[i].value!="")
		{	
			if(document.forms[0].txt_immovvalue[i].value=="")
			{
				alert("Enter Movable Assets value for " +document.forms[0].txt_immovdesc[i].value);
				document.forms[0].txt_immovvalue[i].focus();
				return;
			}
		}
	}
	if(document.forms[0].txt_enjoybranch.value=='')
	{
		ShowAlert('121','Select Nature and extent of dealings');
		document.forms[0].txt_enjoybranch.focus();
		return;
	}
	if(document.forms[0].txt_othersecuritycharge.value=='')
	{
		ShowAlert('121','Names of bankers / Financial institutions and credit facilities at other banks');
		document.forms[0].txt_othersecuritycharge.focus();
		return;
	}
	if(document.forms[0].txt_indreport.value=='')
	{
		ShowAlert('121','Brief report on the means of individual Proprietor or Partner or Director');
		document.forms[0].txt_indreport.focus();
		return;
	}
	if(document.forms[0].txt_date.value=='')
	{
		ShowAlert('121','Date');
		document.forms[0].txt_date.focus();
		return;
	}
	if(document.forms[0].txt_investigator.value=='')
	{
		ShowAlert('121','Credit Investigator');
		document.forms[0].txt_investigator.focus();
		return;
	}
	if(document.forms[0].txt_brmanager.value=='')
	{
		ShowAlert('121','Branch Manager');
		document.forms[0].txt_brmanager.focus();
		return;
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidSourceUrl.value="/action/creditreport4.jsp";
	document.forms[0].hidBeanId.value="lapsReport";
	document.forms[0].hidBeanMethod.value="updateCreditreport2";
	document.forms[0].hidBeanGetMethod.value="getCreditreport2";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].disabled=val;
		} 
	}
	document.forms[0].txt_total.readOnly=true;
	document.forms[0].txt_date.readOnly=true;
}

function callLink(page,bean,method)
		{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appUrl+"action/"+page+"?hidAction=Get&hid_appid="+document.forms[0].hid_appid.value;
		document.forms[0].submit();
		}

function doClose()
	{
	if(ConfirmMsg('100'))
		{
		
		document.forms[0].method="post";	
		if(document.forms[0].hidsaral && document.forms[0].hidsaral.value=="saral")
		{
			document.forms[0].action=appUrl+"action/mainnav.jsp";
			document.forms[0].submit();
		}
		else
		{
			document.forms[0].action=appURL+"action/corppge.jsp";
		}
		document.forms[0].submit();
		}
	}
	
function doDelete()
{  
	if(varRecordFlag=="Y")
	{
		if(ConfirmMsg(101))
		{
			document.forms[0].hidAction.value ="D";
			document.forms[0].hidSourceUrl.value="/action/creditreport4.jsp";
			document.forms[0].hidBeanId.value="lapsReport";
			document.forms[0].hidBeanMethod.value="updateCreditreport2";
			document.forms[0].hidBeanGetMethod.value="getCreditreport2";
			document.forms[0].action=appUrl +"controllerservlet";
			document.forms[0].submit(); 		
		}
     }
	else
	{
		ShowAlert(158);
	}
}	

function movtotal()
{		
	var Total=0;
	for(var i=0;i<10;i++)
	{	
		if(document.forms[0].txt_movdesc[i].value!="")
		{	
			if(document.forms[0].txt_movvalue[i].value=="")
			{
				document.forms[0].txt_movvalue[i].value="0";
			}
			Total=eval(Total) + eval(document.forms[0].txt_movvalue[i].value);
			if(document.forms[0].txt_movvalue[i].value=="0")
			{
				document.forms[0].txt_movvalue[i].value="";
			}
			roundtxt(document.forms[0].txt_movvalue[i]);
		}
	}
	
	document.forms[0].txt_movtotal.value=NanNumber(Total);
	roundtxt(document.forms[0].txt_movtotal);
	total();	
	
}
		
function IMmovtotal()
{
	var Total=0.00;
	for(var i=0;i<10;i++)
	{
		if(document.forms[0].txt_immovdesc[i].value!="")
		{		
			if(document.forms[0].txt_immovvalue[i].value=="")
			{
				document.forms[0].txt_immovvalue[i].value="0";
			}
			Total=eval(Total) + eval(document.forms[0].txt_immovvalue[i].value);
			if(document.forms[0].txt_immovvalue[i].value=="0")
			{
				document.forms[0].txt_immovvalue[i].value="";
			}
			roundtxt(document.forms[0].txt_immovvalue[i]);
		}
	}
	document.forms[0].txt_immovtotal.value=NanNumber(Total);
	roundtxt(document.forms[0].txt_immovtotal);
	total();
}
function total()
{
	var tot=0.00;
	var movtotal=document.forms[0].txt_movtotal.value;
	var Immovtotal=document.forms[0].txt_immovtotal.value;
	tot=((eval(tot)+eval(movtotal)+eval(Immovtotal))-document.forms[0].txt_indlibpartner.value);
	document.forms[0].txt_total.value=NanNumber(tot);
	roundtxt(document.forms[0].txt_total);
}
function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
	showCal(appUrl,name);
	}
}
function doPrint()
{
	if(("<%=strSaral%>"=="saral"))
	{
		var inwardno=document.forms[0].inwardno.value;
		var slno=document.forms[0].hid_slno.value;
		var varsaral="<%=strSaral%>";
		var appname=document.forms[0].appname.value;
		var hidsector=document.forms[0].hidsector.value;
		var strAction="Print";
		var purl=appUrl+"action/CreditReportPrint_Ret4.jsp?hidBeanGetMethod=getCreditReportPrint2&hidBeanId=lapsReport&inwardno="+inwardno+"&slno="+slno+"&strAction="+strAction+"&hidsaral="+varsaral+"&appname="+appname+"&hidsector="+hidsector;
	}
	else
	{
		var appno="<%=request.getParameter("appno")%>";
		var AppType=document.forms[0].hid_appid.value;
		var varvaluesin=document.forms[0].valuesin.value;
		var strAction="Print";
		if(AppType=='' || AppType=='S')
		{
			alert("Select Name to Print");
		}
		else
		{
		var purl=appUrl+"action/CreditReportPrint_Ret4.jsp?hidBeanGetMethod=getCreditReportPrint2&hidBeanId=lapsReport&appno="+appno+"&AppType="+AppType+"&strAction="+strAction+"&valuesin="+varvaluesin;
		}
	}	
	prop='scrollbars=yes,menubar=yes,width=750,height=520';
	xpos=(screen.width-750)/2;
	ypos=(screen.height-520)/2;
	prop=prop+",xpos="+xpos+",ypos="+ypos;
	window.open(purl,'title',prop);
}
</script>
</head>

<body onload="onLoading()">
<form name="frmcredit1" method="post" class="normal">
<%if (strSaral.equalsIgnoreCase("saral")) {%>
	<lapschoice:saralreportTag tabid="2" sector='<%=strSector%>'  applied='<%=strappliedfor%>'/>
	<lapschoice:inward /> 
<%} else {%> 
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td valign="top"> 
        <jsp:include page="../com/proposallinks.jsp" flush="true"> 
        <jsp:param name="pageid" value="14" />
        <jsp:param name="cattype" value="<%=strCategoryType%>" />
        <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
    </tr>
  <tr> 
   <td valign="top" class="page_flow">Home-&gt; Corporate-&gt; 
  Proposal -&gt; Credit / Inspection Report -&gt; Credit Report</td></tr>
  </table>
  <span style="display:none"><lapschoice:borrowertype /></span>
	<lapschoice:application /> 
	<lapstab:ComReportTab tabid="3" applevel='<%=Helper.correctNull((String)request.getParameter("applevel"))%>' applied='<%=strappliedfor%>'/>
	
<%}%>
  <table width="96%" border="0" cellspacing="2" cellpadding="2" align="center" class="outertable">
    <tr> 
      <td>Total Means</td>
      <td>
        <input type="text"  name="txt_total" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("CR_Total_MEANS"))))%>" style="text-align:right">
      </td>
      <td width="3">&nbsp;</td>
    </tr>
    <tr> 
      <td nowrap>Means / TNW as on <span class="mantatory"><b>*</b></span></td>
      <td>
        <input type="text" name="txt_meansason" value="<%=Helper.correctNull((String)hshValues.get("CR_meansason"))%>"
        onBlur="checkDate(this);checkmaxdate(this,currentdate)" maxlength="10" size="12">
         <a href="#" onClick="callCalender('txt_meansason');"
			title="Click to view calender" border="0"><img
			src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
			width="0" border="0"></a>
      </td>
      <td width="3">&nbsp;</td>
    </tr>
    <tr><td>&nbsp;</td></tr>
    <tr> 
      <td colspan="2" align="center">GUARANTEES GIVEN IN DETAIL </td>
      <td colspan="2" align="center">PARTICULARS OF LIABILITIES OF INDIVIDUAL / PARTNERS / DIRECTORS /OTHERS <span class="mantatory"><b>*</b></span>
</td>
    </tr>
    <tr> 
      <td colspan="2" align="center"> 
        <textarea cols="50" name="txt_gurantdetail" rows="5" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues.get("CR_Gurantor"))%></textarea>
      </td>
      <td colspan="2" align="center"> 
     	 &nbsp;<input type="text" name="txt_indlibpartner" size="20" onkeypress="allowNumber(this)" value="<%=Helper.correctNull((String) hshValues.get("CR_Partner"))%>" maxlength="40" onBlur="roundtxt(document.forms[0].txt_indlibpartner);total()" style="text-align:right">
      </td>
    </tr>
    <tr><td>&nbsp;</td></tr>
    <tr> 
      <td colspan="4"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable border1">
          <tr> 
            <td width="25%" align="center">BUSINESS ABILITY <span class="mantatory"><b>*</b></span></td>
            <td width="22%" align="center">BUSINESS CONDUCTED <span class="mantatory"><b>*</b></span></td>
            <td width="28%" align="center">BUSINESS REPUTATION<span class="mantatory"><b>*</b></span> </td>
            <td width="25%" align="center">CONDITION OF BUSINESS<span class="mantatory"><b>*</b></span></td>
          </tr>
          <tr> 
            <td width="25%" align="center"> 
              <select name="sel_busability" >
			  <option value="0">----Select----</option>
			  <option value="1">CAPABLE</option>
			  <option value="2">INCAPABLE</option>
			  <option value="3">EXPERIENCED</option>
			  <option value="4">INEXPERIENCED</option>
			  <option value="5">Not Applicable</option>
              </select>
            </td>
            <td width="22%" align="center"> 
              <select name="sel_busconduct" >
			  <option value="0">----Select----</option>
			  <option value="1">SPECULATIVE</option>
			  <option value="2">OVERTRADE</option>
			  <option value="3">CONSERVATIVE</option>
			  <option value="4">PRUDENT</option>
			  <option value="5">CAUTIOUS</option>
			  <option value="6">STEADY</option>
			  <option value="7">Not Applicable</option>
              </select>
            </td>
            <td width="28%" align="center"> 
              <select name="sel_busreputation" >
			  <option value="0">----Select----</option>
			  <option value="1">HONEST</option>
			  <option value="2">DISHONEST</option>
			  <option value="3">STRAIGHT-FORWARD</option>
			  <option value="4">TRICKY</option>
			  <option value="5">SHARP</option>
			  <option value="6">SHREWD</option>
			  <option value="7">Not Applicable</option>
              </select>
            </td>
            <td width="25%" align="center"> 
              <select name="sel_buscondtion" >
			  <option value="0">----Select----</option>
			  <option value="1">PROGRESSIVE</option>
			  <option value="2">DECLINING</option>
			  <option value="3">STAGNANT</option>
			  <option value="4">THRIVING</option>
			  <option value="5">HEALTHY</option>
			  <option value="6">SOUND</option>
			  <option value="7">LIQUID</option>
			  <option value="8">Not Applicable</option>
              </select>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr><td>&nbsp;</td></tr>
    <tr> 
      <td colspan="2" align="center">NATURE AND EXTENT OF DEALINGS WITH BANK&#146;S 
        BRANCHES (WHAT LIMIT ENJOYED AT OTHER BRANCHES)<span class="mantatory"><b>*</b></span>
</td>
      <td colspan="2" align="center">NAMES OF BANKERS / FINANCIAL INSTITUTIONS AND CREDIT FACILITIES 
        AT OTHER BANKS / <br>FINANCIAL INSTITUTIONS AND SECURITIES CHARGED TO THEM <span class="mantatory"><b>*</b></span>
</td>
    </tr>
    <tr> 
      <td colspan="2" align="center"> 
        <textarea cols="50" rows="5" name="txt_enjoybranch" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues.get("CR_Enjoybranch"))%></textarea>
      </td>
      <td colspan="2" align="center"> 
        <textarea cols="50" rows="5" name="txt_othersecuritycharge" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues.get("CR_Othersecur"))%></textarea>
      </td>
    </tr>
    <tr><td>&nbsp;</td></tr>
    <tr> 
      <td width="325" colspan="2">BRIEF REPORT ON THE MEANS OF INDIVIDUAL PROPRIETOR 
        OR PARTNER OR DIRECTOR <span class="mantatory"><b>*</b></span>
	</td>
      <td colspan="2">DETAILS OF FIXED ASSETS ( GIVE NATURE AND LOCATION OF EACH 
        ASSETS AND INCASE OF IMMOVABLE PROPERTY THE NAMES IN WHICH IT IS HELD) 
        :</td>
    </tr>
    <tr> 
      <td width="325" valign="top" colspan="2"> 
        <textarea cols="50" rows="5" name="txt_indreport" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues.get("CR_IndReport"))%></textarea>
      </td>
      <td colspan="2"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable border1">
          <tr align="center"> 
            <td colspan="2">MOVABLE ASSETS</td>
            <td colspan="2">IMMOVABLE ASSETS</td>
          </tr>
          <tr align="center"> 
            <td width="30%">DESCRIPTION</td>
            <td width="21%">VALUE</td>
            <td width="29%">DESCRIPTION</td>
            <td width="20%">VALUE</td>
          </tr>
          <%
          for(int i=0;i<10;i++)
          { 
        	  String strMovValue=Helper.correctDouble(MOV_VALUE[i]);
        	  String strImMovValue=Helper.correctDouble(IMMOV_VALUE[i]);
        	  double MovValue=Double.parseDouble(strMovValue);
        	  double ImMovValue=Double.parseDouble(strImMovValue);
          %>
          <tr> 
            <td width="30%"> 
              <input type="text"  name="txt_movdesc" size="40" value="<%=Helper.correctNull(MOV_DESCRIPTION[i])%>" maxlength="40">
            </td>
            <td width="21%"> 
            <input type="text"   name="txt_movvalue" value="<%=Helper.formatDoubleValue(MovValue)%>" onChange="movtotal()" onKeyPress="allowNumber(this)" maxlength="12" onBlur="movtotal();total()" style="text-align:right">
            </td>            
            <td width="29%"> 
              <input type="text"  name="txt_immovdesc" size="40" value="<%=Helper.correctNull(IMMOV_DESCRIPTION[i])%>" maxlength="40">
            </td>
            <td width="20%">
              <input type="text"  name="txt_immovvalue" value="<%=Helper.formatDoubleValue(ImMovValue)%>" onChange="IMmovtotal()" onKeyPress="allowNumber(this)" maxlength="12" onBlur="IMmovtotal();total()" style="text-align:right">
            </td>            
          </tr>
          <%
          }
          %>
         
          <tr> 


            <td width="30%" align="center">TOTAL</td>
            <td width="21%">
              <input type="text" name="txt_movtotal" value="<%=Helper.formatDoubleValue(mov_total)%>" onChange="total()" onKeyPress="allowNumber(this)" style="text-align:right"> 
            </td>
            <td width="29%" align="center">TOTAL</td>
            <td width="20%">
              <input type="text" name="txt_immovtotal" value="<%=Helper.formatDoubleValue(immov_total)%>" onChange="total()" onKeyPress="allowNumber(this)" style="text-align:right">
            </td>
          </tr>
          
        </table>
      </td>
    </tr>
    <tr><td>&nbsp;</td></tr>
    <tr>     
      <td colspan="4"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable border1">
          <tr> 
            <td width="9%">DATE :<span class="mantatory"><b>*</b></span></td>
            <td width="8%">&nbsp; 
              <input type="text" name="txt_date" value="<%=Helper.correctNull((String) hshValues.get("CR_Date"))%>" onBlur="checkDate(this);checkmaxdate(this,currentdate)">
            </td>
            
            <td width="8%">
            <a href="#" onClick="callCalender('txt_date');"
			title="Click to view calender" border="0"><img
			src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
			width="0" border="0" tabindex="7"></a>
			</td>
			
            <td nowrap="nowrap" width="20%">CREDIT INVESTIGATOR <span class="mantatory"><b>*</b></span>
</td>
            <td width="19%"><input type="text" name="txt_investigator" maxlength="75" value="<%=Helper.correctNull((String) hshValues.get("CR_Investigator"))%>" ></td>
            <td width="16%">BRANCH MANAGER <span class="mantatory"><b>*</b></span></td>
            <td width="19%"><input type="text" name="txt_brmanager" maxlength="75" value="<%=Helper.correctNull((String) hshValues.get("CR_Brmanager"))%>" ></td>
          </tr>
        </table>
      </td>
    </tr>
    <%if(strCons.equalsIgnoreCase("Private Limited Company") ||strCons.equalsIgnoreCase("Public Limited Company"))
			{%>
	<tr>
		<td colspan="4">
		<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
		 <tr> 
            <td colspan="4">&nbsp;</td>
          </tr>
           <tr> 
            <td colspan="4">&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="4"><b>Following factors may be taken into account for 
              computing the "NetWorth" or "Means",</b></td>
          </tr>
          <tr> 
            <td colspan="4">&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="4"><b>(i) Paid-upCapital</b></td>
          </tr>
          <tr> 
            <td colspan="4">&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="4"><b>(ii) Free Reserves-(including balance in share 
              premium account, capital and debenture redemption reserves and any 
              other reserves not being created for repayment of any future liability 
              or for depreciation in assets or for bad debts or a reserve created 
              by the revaluation of the assets).</b></td>
          </tr>
          <tr> 
            <td colspan="4">&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="4"><b>(iii) Accumulated balance of loss, balance of deferred 
              revenue expenditure as also other intangible assets.</b></td>
          </tr>
          <tr> 
            <td colspan="4">&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="4"><b>(iv) Investment in subsidiary or branch companies 
              and loan/advances due from subsidiary companies/affiliates,other 
              than those of a trading nature.Net estimated worth of the company 
              will be -Total of (i) &amp; (ii)less total of (iii) &amp; (iv)</b></td>
          </tr>
          <tr> 
            <td colspan="4">&nbsp;</td>
          </tr>
          <tr> 
            <td width="30%">&nbsp;</td>
            <td width="30%">&nbsp;</td>
            <td width="25%">&nbsp;</td>
            <td width="25%"><b>&nbsp; </b></td>
          </tr>
        </table>
		</td>
	</tr>
		<%} %>
		<%if(strCons.equalsIgnoreCase("INDIVIDUAL"))
			{%>
	<tr>
		<td colspan="4">
		<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
		 <tr> 
            <td colspan="4">&nbsp;</td>
          </tr>
           
          <tr> 
            <td colspan="4"><b>Following factors may be taken into account for 
              computing the "NetWorth" or "Means",</b></td>
          </tr>
          <tr> 
            <td colspan="4">&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="4"><b>(i) Capital Investment in the business including 
              -The share in the ancestral properties acquired on division of HUF 
              as per Hindu Succession Act/Indian Succession Act</b></td>
          </tr>
          <tr> 
            <td colspan="4">&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="4"><b>(ii) Movable Assets such as Bank Deposits, Gold 
              ornaments/Jewelleries/Investment in Shares/Debentures/Securities, 
              Company Deposits etc.</b></td>
          </tr>
          <tr> 
            <td colspan="4">&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="4"><b>iii)Personal unencumbered immovable properities:- 
              -Self acquired properties of an individual.</b></td>
          </tr>
          <tr> 
            <td colspan="4">&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="4"><b>Total of (i) (ii) &amp; (iii) will be "Total Worth" 
              of the borrower. Out of this figure, deduct the amount of existing 
              borrowing, to arrive at "NetWorth" or "Means" of an individual/proprietary 
              concern.</b></td>
          </tr>
          <tr> 
            <td colspan="4">&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="4">&nbsp;</td>
          </tr>
         
           <tr> 
            <td colspan="4">&nbsp;</td>
          </tr>
            <tr> 
            <td colspan="4">&nbsp;</td>
          </tr>
         
        </table>
		</td>
	</tr>
		<%} %>
		<%if(strCons.equalsIgnoreCase("H.U.F") || strCons.equalsIgnoreCase("Partnership"))
			{%>
	<tr>
		<td colspan="4">
		<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
		 <tr> 
            <td colspan="4">&nbsp;</td>
          </tr>
          
          <tr> 
            <td colspan="4"><b>Following factors may be taken into account for 
              computing the "NetWorth" or "Means",</b></td>
          </tr>
          <tr> 
            <td colspan="4">&nbsp;</td>
          </tr>
           <tr> 
            <td colspan="4">&nbsp;</td>
          </tr>
          
          <tr> 
            <td colspan="4"><b>(i) Capital Investment in the business by all the Partners(figures to be obtained 
									from the Balance Sheet of the firm)</b></td>
          </tr>
          <tr> 
            <td colspan="4">&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="4"><b>(ii) Undivided Profits </b></td>
          </tr>
          <tr> 
            <td colspan="4">&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="4"><b>(iii)Drawing by the partners</b></td>
          </tr>
          <tr> 
            <td colspan="4">&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="4"><b>(iv) Investment in subsidiary firms</b></td>
          </tr>
          <tr> 
            <td colspan="4">&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="4"><b>(v) Accumulated losses-Net estimated worth of the firms will be-Total of (i) &amp; (ii) less total of (iii) (iv) (v)</b></td>
          </tr>
          <tr>
           
            <td colspan="4">&nbsp;</td>
         
          </tr>
          
          <tr> 
            <td colspan="4">&nbsp;</td>
          </tr>
          
        </table>
		</td>
	</tr>
		<%} %>
		
  </table>
  

<lapschoice:combuttonnew
	btnnames="Edit_Save_Delete_Cancel_Audit Trail_Print"
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />

<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
	<tr>
	
		<td width="33%">&nbsp; 
	        <div align="right"><b>Pg.2/2  &nbsp;<a href="javascript:callLink('creditreport3.jsp','lapsReport','getCreditreport1')" > 
	          &lt;&lt; Previous </a></b></div>
	      </td>
	</tr>
</table>
<br/>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hid_appid" value="<%=(String)request.getParameter("hid_appid")%>"> 
<input type="hidden" name="applicationnumber" value="<%=(String)request.getParameter("appno")%>"> 
<input type="hidden" name="radLoan" value="Y"> 
<input type="hidden" name="bowid" value="<%=Helper.correctNull((String)session.getAttribute("bowid"))%>">
<!--<input type="hidden" name="hidDemoId" value="<%=Helper.correctNull((String)session.getAttribute("hidDemoId"))%>">-->
<input type="hidden" name="hidValid" value = "Y">
<input type="hidden" name="comapp_compname" value="<%=comapp_compname%>">
<input type="hidden" name="hidCons" value="<%=strCons%>">
<input type="hidden" name="hid_slno" value="<%=Helper.correctNull((String)request.getParameter("hid_slno"))%>">  
<%-- 
<input type="hidden" name="hid_pagename" value=""> 
<input type="hidden" name="txt_comappid" value="<%=Helper.correctNull((String)hshValues.get("applicantid"))%>">
--%>
</form> 
</body>
</html>



