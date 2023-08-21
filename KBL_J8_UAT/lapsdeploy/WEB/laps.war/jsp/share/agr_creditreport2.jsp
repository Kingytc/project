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

String strCons =Helper.correctNull((String)request.getParameter("chkCons"));
if(strCons.equalsIgnoreCase(""))
{
	strCons=Helper.correctNull((String)hshValues.get("chkCons"));
}

String strSaral = Helper.correctNull((String) request.getParameter("hidsaral"));
String strSector=Helper.correctNull((String)request.getParameter("hidsector"));
//Added by Zahoorunnisa.S for button functionality
String strstatus = Helper.correctNull((String) request.getParameter("hidstatus"));
	
if (strstatus.equals(""))
 strstatus = Helper.correctNull((String) hshValues.get("status"));

String strapplevel = Helper.correctNull((String)request.getParameter("applevel"));
//end
%>

<html>  
<head>
<title>Credit Information Report</title>

<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var apptype = "<%=Helper.correctNull((String) hshValues.get("strAppType"))%>";
var varsaral="<%=strSaral%>";
var currentdate= "<%=Helper.getCurrentDateTime()%>";
var varOrgLevel="<%=strOrgLevel%>";
var varstrapplevel = "<%=strapplevel%>";
function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
	 	document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdclose.disabled=false;
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

	//Added By Zahoorunnisa.S for Button Functionality after discussion with Suresh

	//If access through the Loan Application Register and its at Branch 
	if("<%=strSaral%>"=="saral" && "<%=strOrgLevel%>"=="A"){ 
		//If the Application is in open status
		if("<%=strstatus%>"=="O" && varright=="w"){
			disableCommandButtons(false,true,true,true,false,false);
		}else{
			disableCommandButtons(true,true,true,true,true,false);	
		}
			
	}else if("<%=strSaral%>"=="saral" && "<%=strapplevel%>" == ""){ 
		
		disableCommandButtons(true,true,true,true,true,false);	
		
    }else{
		
		if(varsaral  == '' && varOrgLevel  == 'D' && varstrapplevel=='S'){
			disableCommandButtons(true,true,true,true,true,false);
		}
	}
	//End

    
	
	disableFields(true);
}

function disableCommandButtons(cmdedit,cmdsave,cmddelete,cmdcancel,cmdclose)
{  
  document.forms[0].cmdedit.disabled=cmdedit;	  
  document.forms[0].cmdsave.disabled=cmdsave;
  document.forms[0].cmddelete.disabled=cmddelete;
  document.forms[0].cmdcancel.disabled=cmdcancel;
  document.forms[0].cmdclose.disabled=cmdclose;
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
		document.forms[0].action=appUrl +"action/agr_creditreport2.jsp";
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
	if(document.forms[0].txt_meansason.value=="")
	{
		alert('Enter Means as on');
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
	document.forms[0].hidSourceUrl.value="/action/agr_creditreport2.jsp";
	document.forms[0].hidBeanId.value="lapsReport";
	document.forms[0].hidBeanMethod.value="updateCreditreport2";
	document.forms[0].hidBeanGetMethod.value="getCreditreport2";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
	}
function doDelete()
{  
	
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="D";
		document.forms[0].hidSourceUrl.value="/action/agr_creditreport2.jsp";
		document.forms[0].hidBeanId.value="lapsReport";
		document.forms[0].hidBeanMethod.value="updateCreditreport2";
		document.forms[0].hidBeanGetMethod.value="getCreditreport2";
		document.forms[0].action=appUrl +"controllerservlet";
		document.forms[0].submit(); 		
	}
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;

		}
		if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].disabled=val;
		} 
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		} 

	}
	document.forms[0].txt_movtotal.readOnly=true;
	document.forms[0].txt_immovtotal.readOnly=true;
	document.forms[0].txt_total.readOnly=true;
}

function callLink(page,bean,method)
{
	document.forms[0].hidSourceUrl.value=page;
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].action=appUrl+"action/"+page;
	document.forms[0].submit();
}

function doClose()
	{
	if(ConfirmMsg('100'))
		{
			if(document.forms[0].hidsaral && document.forms[0].hidsaral.value=="saral")
			{
				document.forms[0].action=appUrl+"action/mainnav.jsp";
				document.forms[0].submit();
			}
			else
			{
				document.forms[0].target="_parent";	
				document.forms[0].action=appUrl+"action/retailpge.jsp";
				document.forms[0].submit();
			}
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
if(document.forms[0].cmdedit.disabled==true)
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
		var purl="<%=ApplicationParams.getAppUrl()%>action/CreditReportPrint_Ret2.jsp?hidBeanGetMethod=getCreditReportPrint1&hidBeanId=lapsReport&inwardno="+inwardno+"&slno="+slno+"&hidsaral="+varsaral+"&appname="+appname+"&hidsector="+hidsector+"&strAction="+strAction;
	}
	else
	{
		var appno=document.forms[0].appno.value;
		var AppType=document.forms[0].hid_appid.value;
		var strAction="Print";
		if(AppType=='' || AppType=='S')
		{
			alert("Select Name to Print");
			return;
		}
		var purl="<%=ApplicationParams.getAppUrl()%>action/CreditReportPrint_Ret2.jsp?hidBeanGetMethod=getCreditReportPrint1&hidBeanId=lapsReport&appno="+appno+"&AppType="+AppType+"&strAction="+strAction;
	}
		
		prop='scrollbars=yes,menubar=yes,width=750,height=520';
		xpos=(screen.width-750)/2;
		ypos=(screen.height-520)/2;
		prop=prop+",xpos="+xpos+",ypos="+ypos;
		window.open(purl,'title',prop);
}
function enableButtons(valnew,valattach,valdetach,valedit,valapply,valcancel,valdel,valclose)
{
	document.forms[0].cmdedit.disabled=valedit;	  	
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmddelete.disabled=valdel;
	document.forms[0].cmdclose.disabled=valclose;
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body onload="onLoading()">
<form name="frmcredit1" action="" method="post" class="normal">
<br>
  <%if (strSaral.equalsIgnoreCase("saral")) {%>
	 		 <lapschoice:saralreportTag tabid="2" sector="<%=strSector%>"/>
			<lapschoice:inward /> 
			<%}%>
			<table width="90%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable border1">
  
    <tr> <td>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
  
    <tr> 
   
      <td  colspan="4" >
      
      <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
  
    <tr>  <td width="25%"  >
      TOTAL MEANS Rs. (in Lacs)</td>
      <td width="25%"  >
        <input type="text" name="txt_total" style="text-align:right" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("CR_Total_MEANS"))))%>">
      </td>
    
      <td  width="25%" align="right">Means / TNW as on<span class="mantatory">*</span></td>
      <td align="left" width="25%" >
        <input type="text" name="txt_meansason" value="<%=Helper.correctNull((String)hshValues.get("CR_meansason"))%>"
        onBlur="checkDate(this);checkmaxdate(this,currentdate)" maxlength="10" size="12">
         <a href="#" onClick="callCalender('txt_meansason');"
			title="Click to view calender" border="0"><img
			src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
			width="0" border="0"></a>
      </td></tr></table></td>
    </tr>
   
    <tr> 
      <td colspan="3" align="left">GUARANTEES GIVEN IN DETAIL </td> <td colspan="2" align="left">
       <textarea cols="50" rows="5" name="txt_gurantdetail" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues.get("CR_Gurantor"))%></textarea>
      </td>
      
    </tr>
    <tr> 
     <td colspan="3" align="left">PARTICULARS OF LIABILITIES OF INDIVIDUAL 
        / PARTNERS / DIRECTORS / OTHERS<span class="mantatory">*</span></td>
      <td colspan="2" align="left"> 
     	 Rs.(in Lacs) <lapschoice:CurrencyTag name="txt_indlibpartner" value='<%=Helper.correctNull((String) hshValues.get("CR_Partner"))%>' maxlength="5"   onChange="total()"  onBlur="total()" />
      </td>
    </tr>
    <tr><td  colspan="5">&nbsp;</td></tr>
    <tr> 
      <td colspan="4"> 
        <table width="90%" align="center" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr  class="dataHeader"> 
            <td width="25%" align="center">BUSINESS ABILITY<span class="mantatory">*</span></td>
            <td width="22%" align="center">BUSINESS CONDUCTED<span class="mantatory">*</span></td>
            <td width="28%" align="center">BUSINESS REPUTATION<span class="mantatory">*</span></td>
            <td width="25%" align="center">CONDITION OF BUSINESS<span class="mantatory">*</span></td>
          </tr>
          <tr  class="dataGrid"> 
            <td width="25%" align="center"> 
              <select name="sel_busability" >
			  <option value="0">----Select----</option>
			  <option value="1">CAPABLE</option>
			  <option value="2">INCAPABLE</option>
			  <option value="3">EXPERIENCED</option>
			  <option value="4">INEXPERIENCED</option>
			   <option value="5">NOT APPLICABLE</option>
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
			   <option value="7">NOT APPLICABLE</option>
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
			   <option value="7">NOT APPLICABLE</option>
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
			   <option value="8">NOT APPLICABLE</option>
              </select>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr><td colspan="5">&nbsp;</td></tr>
    <tr> 
      <td colspan="3" align="left" nowrap="nowrap">NATURE AND EXTENT OF DEALINGS WITH BANK&#146;S 
        BRANCHES (WHAT LIMIT ENJOYED AT OTHER BRANCHES)<span class="mantatory">*</span></td>
      <td colspan="2" align="left"> 
        <textarea cols="50" rows="5" name="txt_enjoybranch" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues.get("CR_Enjoybranch"))%></textarea>
      </td>  </tr>
    <tr> 
      <td colspan="3" align="left">NAMES OF BANKERS / FINANCIAL INSTITUTIONS AND CREDIT FACILITIES 
        AT OTHER BANKS / FINANCIAL INSTITUTIONS AND SECURITIES CHARGED TO THEM<span class="mantatory">*</span></td>
  
      <td colspan="2" align="left"> 
        <textarea cols="50" rows="5" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" name="txt_othersecuritycharge"><%=Helper.correctNull((String) hshValues.get("CR_Othersecur"))%></textarea>
      </td>
    </tr>
    <tr><td colspan="5">&nbsp;</td></tr>
    <tr> 
      <td width="325" colspan="3" align="left">BRIEF REPORT ON THE MEANS OF INDIVIDUAL PROPRIETOR 
        OR PARTNER OR DIRECTOR<span class="mantatory">*</span></td><td width="325" valign="top"align="left"  colspan="2"> 
        <textarea cols="50" onKeyPress="textlimit(this,3999)"  onKeyUp="textlimit(this,3999)" rows="5" name="txt_indreport"><%=Helper.correctNull((String) hshValues.get("CR_IndReport"))%></textarea>
      </td>
     
    </tr>
    <tr>  <td colspan="5">DETAILS OF FIXED ASSETS ( GIVE NATURE AND LOCATION OF EACH 
        ASSETS AND INCASE OF IMMOVABLE PROPERTY THE NAMES IN WHICH IT IS HELD) 
        :</td></tr><tr>
      <td colspan="5"> 
        <table width="95%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable">
          <tr align="center" class="dataHeader"> 
            <td colspan="2">MOVABLE ASSETS</td>
            <td colspan="2">IMMOVABLE ASSETS</td>
          </tr>
          <tr align="center" class="dataHeader"> 
            <td width="30%">DESCRIPTION</td>
            <td width="21%">VALUE (in Lacs)</td>
            <td width="29%">DESCRIPTION</td>
            <td width="20%">VALUE (in Lacs)</td>
          </tr>
          <%
          for(int i=0;i<10;i++)
          { 
        	  String strMovValue=Helper.correctNull(MOV_VALUE[i]);
        	  if(strMovValue.equalsIgnoreCase(""))
        	  {
        		  strMovValue="0.00";
        	  }
        	  String strImMovValue=Helper.correctNull(IMMOV_VALUE[i]);
        	  if(strImMovValue.equalsIgnoreCase(""))
        	  {
        		  strImMovValue="0.00";
        	  }
        	  double MovValue=Double.parseDouble(strMovValue);
        	  double ImMovValue=Double.parseDouble(strImMovValue);
          %>
          <tr  class="dataGrid">
            <td width="30%"> 
              <input type="text" name="txt_movdesc" size="40" maxlength="40" value="<%=Helper.correctNull(MOV_DESCRIPTION[i])%>" >
            </td>
            <td width="21%"> 
              <input type="text" name="txt_movvalue" maxlength="5" value="<%=Helper.formatDoubleValue(MovValue)%>" style="text-align:right" onChange="movtotal();total()"  onBlur="movtotal();total();roundtxt(this);" onKeyPress="allowNumber(this)">
            </td>
            <td width="29%"> 
              <input type="text" name="txt_immovdesc" size="40" maxlength="40" value="<%=Helper.correctNull(IMMOV_DESCRIPTION[i])%>">
            </td>
            <td width="20%"> 
              <input type="text" name="txt_immovvalue" maxlength="5" value="<%=Helper.formatDoubleValue(ImMovValue)%>" style="text-align:right"  onChange="IMmovtotal();total()"  onBlur="movtotal();total();roundtxt(this);" onKeyPress="allowNumber(this)">
            </td>            
          </tr>
          <%
          }
          %>
         
          <tr  class="dataGrid"> 


            <td width="30%" align="center">TOTAL</td>
            <td width="21%"> 
              <input type="text" name="txt_movtotal" value="<%=Helper.formatDoubleValue(mov_total)%>" onChange="total()" onblur="roundtxt(this);" style="text-align:right">

            </td>
            <td width="29%" align="center">TOTAL</td>
            <td width="20%">
              <input type="text" name="txt_immovtotal" style="text-align:right" value="<%=Helper.formatDoubleValue(immov_total)%>" onChange="total()" onblur="roundtxt(this);">
            </td>
          </tr>
          
        </table>
      </td>
    </tr>
    <tr><td colspan="5">&nbsp;</td></tr>
    <tr>     
      <td colspan="5"> 
        <table width="100%" border="0" cellspacing="0" align="center"  cellpadding="3"  class="outertable">
          <tr> 
            <td width="9%">DATE :<span class="mantatory">*</span></td>
            <td width="8%">&nbsp; 
              <input type="text" name="txt_date" value="<%=Helper.correctNull((String) hshValues.get("CR_Date"))%>" onBlur="checkDate(this);checkmaxdate(this,'<%=Helper.getCurrentDateTime()%>');">
            </td>
            <td width="8%"><a
				href="#" onClick="callCalender('txt_date')"
				title="Click to view calender" border="0"><img
				src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
				width="0" border="0" tabindex="7"></a>
			</td>
            <td nowrap="nowrap" width="20%">CREDIT INVESTIGATOR <span class="mantatory">*</span></td>
            <td width="19%"><input type="text" name="txt_investigator" value="<%=Helper.correctNull((String) hshValues.get("CR_Investigator"))%>" ></td>
            <td width="16%">BRANCH MANAGER <span class="mantatory">*</span></td>
            <td width="19%"><input type="text" name="txt_brmanager" value="<%=Helper.correctNull((String) hshValues.get("CR_Brmanager"))%>" ></td>
          </tr>
        </table>
      </td>
    </tr>
   <%if(strCons.equalsIgnoreCase("INDIVIDUAL") || strCons.equalsIgnoreCase("PROPRIETORSHIP"))
			{%>
	<tr>
		<td colspan="4">
		<table width="100%" border="0" cellspacing="1" cellpadding="2"  class="outertable">
		  <tr> 
            <td colspan="4">&nbsp;</td>
          </tr>
          
       
			<tr>
				<td colspan="4"><b>Following factors may be taken into  account for computing the "NetWorth" or "Means",</b></td>
			</tr>
			<tr> 
            <td colspan="4">&nbsp;</td>
          </tr>
          
			 <tr> 
            <td colspan="4"><b>(i) Capital Investment in the business including </b></td>
          </tr>
           <tr> 
            <td colspan="4">&nbsp;</td>
          </tr>
          
           <tr> 
            <td colspan="4"><b>(ii) Movable Assets such as Bank Deposits, Gold ornaments/Jewelleries/Investment in Shares/Debentures/Securities,
				Company Deposits etc</b></td>
          </tr>
            <tr> 
            <td colspan="4">&nbsp;</td>
          </tr>
           <tr> 
            <td colspan="4"><b>(iii) Personal unencumbered immovable properities:-<br>
				-Self acquired properties of an individual.<br>
				-The Share in the ancestral properties acquired on division of HUF as per Hindu Succession Act/Indian Succession Act</b></td>
          </tr>
            <tr> 
            <td colspan="4">&nbsp;</td>
          </tr>
           <tr> 
            <td colspan="4"><b>Total of (i) (ii) &amp; (iii) will be "Total Worth" of the borrower.
				 Out of this figure, deduct the amount of existing borrowing, to arrive
				 at "NetWorth" or "Means" of an individual/proprietary concern.</b></td>
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
		<table width="100%" border="0" cellspacing="1" cellpadding="2"  class="outertable">
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
            <td colspan="4"><b>(iii) Drawing by the partners</b></td>
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
		  <%if(strCons.equalsIgnoreCase("PVT.LTD COMPANIES") || strCons.equalsIgnoreCase("PUB.LTD COMPANIES"))
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
    
  </table></td></tr></table>
 <br>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Print" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />				
<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
	<tr>
		<td width="33%">&nbsp; 
        <div align="left">&nbsp;<b><a href="javascript:callLink('agr_creditreport1.jsp','lapsReport','getCreditreportforRetail')" class="blackfont"> 
          &lt;&lt; Previous </a></b></div>
        </td>
        <td width="33%">&nbsp; 
        <div align="right"><b>Pg.2/2 &nbsp;</b></div>
        </td>
	</tr>
</table>
<br/>
<input type="hidden" name="hid_appid" value="<%=Helper.correctNull((String)request.getParameter("hid_appid"))%>"> 
<input type="hidden" name="hideditflag"> 
<input type="hidden" name="radLoan" value="Y"> 
<input type="hidden" name="hidValid" value = "Y">
<input type="hidden" name="hid_slno" value="<%=Helper.correctNull((String)request.getParameter("hid_slno"))%>">  

<%if(strSaral.equals("saral")){ %>
	<lapschoice:hiddentag /> 
<%}else{ %>
<lapschoice:agrihiddentag /> 
<%} %>
</form> 
</body>
</html>


