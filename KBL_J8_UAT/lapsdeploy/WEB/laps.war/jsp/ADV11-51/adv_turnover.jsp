<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%java.text.NumberFormat nf=java.text.NumberFormat.getInstance();
nf.setMaximumFractionDigits(0);
nf.setMinimumFractionDigits(0);
nf.setGroupingUsed(false);
String appno=Helper.correctNull((String)request.getParameter("appno"));
if(appno.equalsIgnoreCase(""))
{
	appno=Helper.correctNull((String)hshValues.get("appno"));
}
if (objValues instanceof java.util.HashMap) {
	hshValues = (java.util.HashMap) objValues;
}
ArrayList vecRow= new ArrayList();
ArrayList vecCol1= new ArrayList();
ArrayList vecCol2= new ArrayList();
ArrayList vecCol3= new ArrayList();
ArrayList vecCol4= new ArrayList();
ArrayList vecCol5= new ArrayList();
vecRow =(ArrayList)hshValues.get("vecData");
ArrayList vecRow1= new ArrayList();
ArrayList veccol1= new ArrayList();
ArrayList veccol2= new ArrayList();
ArrayList veccol3= new ArrayList();
ArrayList veccol4= new ArrayList();
ArrayList veccol5= new ArrayList();
ArrayList veccol6= new ArrayList();
ArrayList veccol7= new ArrayList();
ArrayList veccol8= new ArrayList();
ArrayList veccol9= new ArrayList();
ArrayList veccol10= new ArrayList();
ArrayList veccol11= new ArrayList();
ArrayList veccol12= new ArrayList();
vecRow1 =(ArrayList)hshValues.get("vecData1");
%>
<html>
<head>
<title>TurnOver Details</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function disableCommandButtons(val)
{	
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
function dateDiff()
{
	var ddiff=0;
	ddiff=dayscalc(document.forms[0].txt_overfrom.value,document.forms[0].txt_overto.value)
   
   if (ddiff<0)
   {
	alert("From Date cannot be greater than To Date");
	document.forms[0].txt_overfrom.value = "";
	return false;
   }
     else
	{
	  return true;
	}
	
}
function dayscalc(fromdt,todt)
{
	var fmonth = eval(fromdt.substring(0, 2));

	var fday = eval(fromdt.substring(3, 5));

	var fyear = eval(fromdt.substring(6, 10));

	var tmonth = eval(todt.substring(0, 2));

	var tday = eval(todt.substring(3, 5));

	var tyear = eval(todt.substring(6, 10));

var totdays = (((eval(tmonth) + (eval(tday) * 30)) + (eval(tyear) * 365)) - ((eval(fmonth) + (eval(fday) * 30)) + (eval(fyear) * 365)));

	return totdays;
}

function doEdit()
{ 	
	disableFields(false);
    document.forms[0].hidAction.value ="insert";
    document.forms[0].hideditflag.value="Y";
	disableCommandButtons("edit");	
}
function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(ConfirmMsg(101))
			{	
				document.forms[0].hidAction.value ="delete";
				document.forms[0].action=appUrl+"action/ControllerServlet";		
				document.forms[0].hidBeanMethod.value="updateTurnover";
				document.forms[0].hidBeanGetMethod.value="getTurnover";
				document.forms[0].hidBeanId.value="ADV1151";
				document.forms[0].hidSourceUrl.value="action/adv_turnover.jsp";	
				document.forms[0].method="post";			
				document.forms[0].submit();	
			}
	}
	else
	{
		
		ShowAlert(158);
	}
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="ADV1151";
		document.forms[0].hidBeanGetMethod.value="getTurnover";
		document.forms[0].action=appUrl +"action/adv_turnover.jsp";
		document.forms[0].hidSourceUrl.value="adv_turnover.jsp";
	    document.forms[0].submit();	
	}	
}
function doSave()
{
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].hidRecordflag.value = varRecordFlag;
	  	document.forms[0].hidBeanId.value="ADV1151";
		document.forms[0].hidBeanMethod.value="updateTurnover";
		document.forms[0].hidBeanGetMethod.value="getTurnover";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/adv_turnover.jsp";
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
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/agrpage.jsp";
		document.forms[0].submit();		
	}
}
function callCalender(fname)
 {
 if(document.forms[0].cmdsave.disabled==false)
	 {
	 showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	 }
 }
function onLoading()
{
	disableFields(true);	
}	
function callLink(page,bean,method)
		{		
			document.forms[0].hidSourceUrl.value=page;
			document.forms[0].hidBeanGetMethod.value=method;
			document.forms[0].hidBeanId.value=bean;
			document.forms[0].action=appUrl+"action/"+page;
			document.forms[0].submit();
		}
function noofdays(obj)
{
var days=obj.value;
	if(days>365)
	{
	alert("No of Days cannot exceed 365");
	obj.value="";
	obj.focus();
	}
}
function MonthValidation(monthName,obj)
{
if(document.forms[0].cmdsave.disabled==false)
	 {
	   var strMonth=new String(monthName);
	   var tempVar=new String(obj.value);
	   if(tempVar!="")
	   {
		   var MONTH=0;
		   if(tempVar=="")MONTH=parseInt(0.00);
		   else
		   MONTH=parseInt(tempVar);
		   if(strMonth=="JAN" &&( MONTH > 31 ||MONTH < 1)){alert("Please Enter the Valid days for JAN Month");obj.value=""; obj.focus();return false;}
		   if(strMonth=="FEB" &&( MONTH > 29 ||MONTH < 1)){alert("Please Enter the Valid days for FEB Month");obj.value=""; obj.focus();return false;}
		   if(strMonth=="MAR" &&( MONTH > 31 ||MONTH < 1)){alert("Please Enter the Valid days for MAR Month");obj.value=""; obj.focus();return false;}      
		   if(strMonth=="APR" &&( MONTH > 30 ||MONTH < 1)){alert("Please Enter the Valid days for APR Month");obj.value=""; obj.focus();return false;}    
		   if(strMonth=="MAY" &&( MONTH > 31 ||MONTH < 1)){alert("Please Enter the Valid days for MAY Month");obj.value=""; obj.focus();return false;}   
		   if(strMonth=="JUN" &&( MONTH > 30 ||MONTH < 1)){alert("Please Enter the Valid days for JUN Month");obj.value=""; obj.focus();return false;}
		   if(strMonth=="JUL" &&( MONTH > 31 ||MONTH < 1)){alert("Please Enter the Valid days for JUL Month");obj.value=""; obj.focus();return false;}
		   if(strMonth=="AUG" &&( MONTH > 31 ||MONTH < 1)){alert("Please Enter the Valid days for AUG Month");obj.value=""; obj.focus();return false;}
		   if(strMonth=="SEP" &&( MONTH > 30 ||MONTH < 1)){alert("Please Enter the Valid days for SEP Month");obj.value=""; obj.focus();return false;}
		   if(strMonth=="OCT" &&( MONTH > 31 ||MONTH < 1)){alert("Please Enter the Valid days for OCT Month");obj.value=""; obj.focus();return false;}
		   if(strMonth=="NOV" &&( MONTH > 30 ||MONTH < 1)){alert("Please Enter the Valid days for NOV Month");obj.value=""; obj.focus();return false;}
		   if(strMonth=="DEC" &&( MONTH > 31 ||MONTH < 1)){alert("Please Enter the Valid days for DEC Month");obj.value=""; obj.focus();return false;}
	   }  
	  }            
}
</script>
</head>
<body onload="onLoading()">
<form name="borrowing" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td><jsp:include page="../share/applurllinkscom.jsp"
			flush="true">
			<jsp:param name="pageid" value="19" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<tr>
		<td class="page_flow">Home -&gt; Tertiary -&gt; Proposal -&gt; ADV1151 -&gt; Turnover Details
		</td>
	</tr>
</table>
<span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application /><br>
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable border1" align="center">
<tr>
<td>
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
							<tr class="dataheader">
								<td align="center"><b>TURNOVER DETAILS</b>
								</td>
							</tr>
						</table>

 <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
 <tr class="dataheader">
 <td align="center"><b>Turnover Particulars Corresponding to the Financial year of the firm/company.</b></td>
 </tr>
 </table>
  <table border="0" width="100%" cellspacing="0" cellpadding="3" class="outertable linebor">    
    <tr class="dataheader"> 
      <td width="20%" align="center"  rowspan="2"><strong>Particulars</strong></td>
      <td width="24%" align="center"  rowspan="2"><strong>Credit</strong></td>      
     </tr>
     <tr class="dataheader">
      <td width="24%" align="center" ><strong>Debit</strong></td>      
    </tr>
    <tr class="datagrid"> 
      <td width="23%" >Turn Over:From 
        <input
            type="text" name="txt_overfrom" size="13" value="<%=Helper.correctNull((String)hshValues.get("ADV_turnoverfrom"))%>" onBlur="checkDate(this);checkmaxdate(this,currentDate);dateDiff()">
        <a alt="Select date from calender" href="#" onClick="callCalender('txt_overfrom')" onMouseOver="window.status='Date Picker';return true;"	onMouseOut="window.status='';return true;"><img	src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" alt="Select date from calender" tabindex="1"></a> 
        To 
        <input
            type="text" name="txt_overto" size="13" value="<%=Helper.correctNull((String)hshValues.get("ADV_turnoverto"))%>" onBlur="checkDate(this);dateDiff()">
        <a alt="Select date from calender" href="#" onClick="callCalender('txt_overto')" onMouseOver="window.status='Date Picker';return true;"	onMouseOut="window.status='';return true;"><img	src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" alt="Select date from calender" tabindex="2"></a> 
      </td>
      
       <%if(vecRow!=null && vecRow.size()>0)
                            {
                            	for(int i=0;i<vecRow.size();i++)
                            	{
                            		vecCol1 =(ArrayList)vecRow.get(0);
                            		vecCol2 =(ArrayList)vecRow.get(1);
                            		vecCol3 =(ArrayList)vecRow.get(2);
                            		vecCol4 =(ArrayList)vecRow.get(3);
                            		vecCol5 =(ArrayList)vecRow.get(4);
                            	}
                            }
     
                            	%>
      <td width="20%" > 
        <lapschoice:CurrencyTag name="txtCredit_amt" tabindex="3" maxlength="15" value='<%=Helper.correctNull((String) vecCol1.get(0))%>' onKeyPress="CheckDecimal(this.value)"/>
        Amount (In Lacs) </td>
        
      <td width="24%" > 
        <lapschoice:CurrencyTag name="txtDebit_amt" tabindex="4" maxlength="15" value='<%=Helper.correctNull((String) vecCol1.get(1))%>' onKeyPress="allowWholeNumber(this)"/>
        Amount (In Lacs) </td>
    </tr>
    <tr class="datagrid"> 
      <td width="23%" >Minimum Balance</td>
      <td width="20%" >
        <lapschoice:CurrencyTag name="txtCredit_amt"  tabindex="5" maxlength="15" value='<%=Helper.correctNull((String) vecCol2.get(0))%>' onKeyPress="allowWholeNumber(this)"/>
        Amount (In Lacs) </td>
      <td width="24%" >
        <lapschoice:CurrencyTag name="txtDebit_amt" tabindex="6" maxlength="15" value='<%=Helper.correctNull((String) vecCol2.get(1))%>' onKeyPress="allowWholeNumber(this)"/>
        Amount (In Lacs) </td>
    </tr>
    <tr class="datagrid"> 
      <td width="23%" >Average Balance</td>
      <td width="20%" >
        <lapschoice:CurrencyTag name="txtCredit_amt" tabindex="7" maxlength="15" value='<%=Helper.correctNull((String) vecCol3.get(0))%>' onKeyPress="allowWholeNumber(this)"/>
        Amount (In Lacs) </td>
      <td width="24%" >
        <lapschoice:CurrencyTag name="txtDebit_amt"  tabindex="8" maxlength="15" value='<%=Helper.correctNull((String) vecCol3.get(1))%>' onKeyPress="allowWholeNumber(this)"/>
        Amount (In Lacs) </td>
    </tr>
    <tr class="datagrid"> 
      <td width="23%" >Maximum Balance</td>
      <td width="20%" >
        <lapschoice:CurrencyTag name="txtCredit_amt" tabindex="9" maxlength="15" value='<%=Helper.correctNull((String) vecCol4.get(0))%>' onKeyPress="allowWholeNumber(this)"/>
        Amount (In Lacs) </td>
      <td width="24%" >
        <lapschoice:CurrencyTag name="txtDebit_amt" tabindex="10"  maxlength="15" value='<%=Helper.correctNull((String) vecCol4.get(1))%>' onKeyPress="allowWholeNumber(this)"/>
        Amount (In Lacs) </td>
    </tr>
    <tr class="datagrid"> 
      <td width="23%" rowspan="2">No of Days Account was showing Balance</td>
      <td width="20%" >
    <% String strdays=Helper.correctNull((String) vecCol5.get(0));
    
    double crdays=Double.parseDouble(strdays);%>
        <input type="text" name="txtCredit_amt" tabindex="11" maxlength="15" value="<%=nf.format(crdays)%>" onKeyPress="allowInteger()" onblur="noofdays(this)">
        Days </td>
        <% String strdays1=Helper.correctNull((String) vecCol5.get(1));
    
    double crdays1=Double.parseDouble(strdays1);%>
        
      <td width="24%" >
        <input type="text" name="txtDebit_amt" tabindex="12"  maxlength="15" value="<%=nf.format(crdays1)%>" onKeyPress="allowInteger()" onblur="noofdays(this)">
        Days </td>
    </tr>
    
  </table>
  
   <%if(vecRow1!=null && vecRow1.size()>0)
                            {
                            	for(int i=0;i<vecRow1.size();i++)
                            	{
                            		veccol1 =(ArrayList)vecRow1.get(0);
                            		veccol2 =(ArrayList)vecRow1.get(1);
                            		veccol3 =(ArrayList)vecRow1.get(2);
                            		veccol4 =(ArrayList)vecRow1.get(3);
                            		veccol5 =(ArrayList)vecRow1.get(4);
                            		veccol6 =(ArrayList)vecRow1.get(5);
                            		veccol7 =(ArrayList)vecRow1.get(6);
                            		veccol8 =(ArrayList)vecRow1.get(7);
                            		veccol9 =(ArrayList)vecRow1.get(8);
                            		veccol10 =(ArrayList)vecRow1.get(9);
                            		veccol11 =(ArrayList)vecRow1.get(10);
                            		veccol12 =(ArrayList)vecRow1.get(11);
                            	}
                            }
     
                            	%>
  
  <p class="dataheader">(b) Balance Maintained during last 12 months &quot;<%=ApplicationParams.getCurrency()%> in lacs&quot;</p>
  <table border="0" width="100%" cellspacing="0" cellpadding="3" class="outertable linebor">
    <tr class="dataheader"> 
      <td width="10%" align="center">&nbsp;</td>
      <td width="17%" colspan="2" align="center">Credit</td>
      <td width="20%" colspan="2" align="center">Debit</td>
      <td width="12%" align="center">&nbsp;</td>
      <td width="20%" colspan="2" align="center">Credit</td>
      <td width="35%" colspan="2" align="center">Debit</td>
    </tr>
    <tr class="dataheader"> 
      <td width="10%">Month-Year</td>
      <td width="9%" align="center">Amount </td>
      <td width="8%" align="center">Days</td>
      <td width="10%" align="center">Amount </td>
      <td width="10%" align="center">Days</td>
      <td width="12%">Month-Year</td>
      <td width="10%" align="center">Amount </td>
      <td width="10%" align="center">Days</td>
      <td width="12%" align="center">Amount </td>
      <td width="23%" align="center">Days</td>
    </tr>
    <tr class="datagrid"> 
      <td width="10%">Jan</td>
      <td width="9%"> 
        <lapschoice:CurrencyTag name="txt_Cramt" tabindex="13" maxlength="15" value='<%=Helper.correctNull((String) veccol1.get(0))%>' onKeyPress="allowWholeNumber(this)"/>
      </td>
     <% String strjan1=Helper.correctNull((String) veccol1.get(1));     
     double jan1=Double.parseDouble(strjan1);%>      
      <td width="8%"> 
        <input type="text" name="txt_Crdays" tabindex="14" maxlength="15"value="<%=nf.format(jan1)%>" onKeyPress="allowInteger()" onBlur="MonthValidation('JAN',this);">
      </td>	  
      <td width="10%"> 
        <lapschoice:CurrencyTag name="txt_Dramt" tabindex="15" maxlength="15" value='<%=Helper.correctNull((String) veccol1.get(2))%>' onKeyPress="allowWholeNumber(this)"/>
      </td>
	  <% String strjan2=Helper.correctNull((String) veccol1.get(3));     
     double jan2=Double.parseDouble(strjan2);%>
      <td width="10%"> 
        <input type="text" name="txt_Drdays" tabindex="16" maxlength="15" value="<%=nf.format(jan2)%>" onKeyPress="allowInteger()" onBlur="MonthValidation('JAN',this);">
      </td>
      <td width="12%">July</td>
      <td width="10%"> 
        <lapschoice:CurrencyTag name="txt_Cramt" tabindex="37" maxlength="15" value='<%=Helper.correctNull((String) veccol2.get(0))%>' onKeyPress="allowWholeNumber(this)"/>
      </td>
	  <% String strjuly1=Helper.correctNull((String) veccol2.get(1));     
     double july1=Double.parseDouble(strjuly1);%>
      <td width="10%"> 
        <input type="text" name="txt_Crdays" tabindex="38" maxlength="15" value="<%=nf.format(july1)%>" onKeyPress="allowInteger()" onBlur="MonthValidation('JUL',this);">
      </td>
      <td width="12%"> 
        <lapschoice:CurrencyTag name="txt_Dramt" tabindex="39" maxlength="15"  value='<%=Helper.correctNull((String) veccol2.get(2))%>' onKeyPress="allowWholeNumber(this)"/>
      </td>
	  <% String strjuly2=Helper.correctNull((String) veccol2.get(3));     
     double july2=Double.parseDouble(strjuly2);%>
      <td width="23%"> 
        <input type="text" name="txt_Drdays" tabindex="40"  maxlength="15" value="<%=nf.format(july2)%>" onKeyPress="allowInteger()" onBlur="MonthValidation('JUL',this);">
      </td>
    </tr>
    <tr class="datagrid"> 
      <td width="10%">Feb</td>
      <td width="9%"> 
        <lapschoice:CurrencyTag name="txt_Cramt" tabindex="17" maxlength="15" value='<%=Helper.correctNull((String) veccol3.get(0))%>' onKeyPress="allowWholeNumber(this)"/>
      </td>
	  <% String strfeb1=Helper.correctNull((String) veccol3.get(1));     
     double feb1=Double.parseDouble(strfeb1);%>
      <td width="8%"> 
        <input type="text" name="txt_Crdays" tabindex="18" maxlength="15" value="<%=nf.format(feb1)%>" onKeyPress="allowInteger()" onBlur="MonthValidation('FEB',this);">
      </td>
      <td width="10%"> 
        <lapschoice:CurrencyTag name="txt_Dramt" tabindex="19" maxlength="15" value='<%=Helper.correctNull((String) veccol3.get(2))%>' onKeyPress="allowWholeNumber(this)"/>
      </td>
	  <% String strfeb2=Helper.correctNull((String) veccol3.get(3));     
     double feb2=Double.parseDouble(strfeb2);%>
      <td width="10%"> 
        <input type="text" name="txt_Drdays" tabindex="20" maxlength="15" value="<%=nf.format(feb2)%>" onKeyPress="allowInteger()" onBlur="MonthValidation('FEB',this);">
      </td>
      <td width="12%">Aug.</td>
      <td width="10%"> 
        <lapschoice:CurrencyTag name="txt_Cramt" tabindex="41" maxlength="15" value='<%=Helper.correctNull((String) veccol4.get(0))%>' onKeyPress="allowWholeNumber(this)"/>
      </td>
	  <% String straug1=Helper.correctNull((String) veccol4.get(1));
     
     double aug1=Double.parseDouble(straug1);
     %>
      <td width="10%"> 
        <input type="text" name="txt_Crdays" tabindex="42" maxlength="15" value="<%=nf.format(aug1)%>" onKeyPress="allowInteger()"onBlur="MonthValidation('AUG',this);">
      </td>
      <td width="12%"> 
        <lapschoice:CurrencyTag name="txt_Dramt" tabindex="43" maxlength="15" value='<%=Helper.correctNull((String) veccol4.get(2))%>' onKeyPress="allowWholeNumber(this)"/>
      </td>
	  <% String straug2=Helper.correctNull((String) veccol4.get(3));
     
     double aug2=Double.parseDouble(straug2);
     %>
      <td width="23%"> 
        <input type="text" name="txt_Drdays" tabindex="44"  maxlength="15" value="<%=nf.format(aug2)%>" onKeyPress="allowInteger()" onBlur="MonthValidation('AUG',this);">
      </td>
    </tr>
    <tr class="datagrid"> 
      <td width="10%">March</td>
      <td width="9%"> 
        <lapschoice:CurrencyTag name="txt_Cramt" tabindex="21" maxlength="15"  value='<%=Helper.correctNull((String) veccol5.get(0))%>' onKeyPress="allowWholeNumber(this)"/>
      </td>
	  <% String strmar1=Helper.correctNull((String) veccol5.get(1));
     
     double mar1=Double.parseDouble(strmar1);
     %>
      <td width="8%"> 
        <input type="text" name="txt_Crdays" tabindex="22" maxlength="15" value="<%=nf.format(mar1)%>" onKeyPress="allowInteger()" onBlur="MonthValidation('MAR',this);">
      </td>
      <td width="10%"> 
        <lapschoice:CurrencyTag name="txt_Dramt" tabindex="23" maxlength="15" value='<%=Helper.correctNull((String) veccol5.get(2))%>' onKeyPress="allowWholeNumber(this)"/> 
      </td>
	  <% String strmar2=Helper.correctNull((String) veccol5.get(3));
     
     double mar2=Double.parseDouble(strmar2);
     %>
      <td width="10%"> 
        <input type="text" name="txt_Drdays" tabindex="24" maxlength="15" value="<%=nf.format(mar2)%>" onKeyPress="allowInteger()" onBlur="MonthValidation('MAR',this);">
      </td>
      <td width="12%">Sept.</td>
      <td width="10%"> 
       <lapschoice:CurrencyTag name="txt_Cramt" tabindex="45" maxlength="15" value='<%=Helper.correctNull((String) veccol6.get(0))%>' onKeyPress="allowWholeNumber(this)"/>
      </td>
	  <% String strsep1=Helper.correctNull((String) veccol6.get(1));
     
     double sep1=Double.parseDouble(strsep1);
     %>
      <td width="10%"> 
        <input type="text" name="txt_Crdays" tabindex="46"  maxlength="15" value="<%=nf.format(sep1)%>" onKeyPress="allowInteger()"onBlur="MonthValidation('SEP',this);">
      </td>
      <td width="12%"> 
        <lapschoice:CurrencyTag name="txt_Dramt" tabindex="47" maxlength="15" value='<%=Helper.correctNull((String) veccol6.get(2))%>' onKeyPress="allowWholeNumber(this)"/>
      </td>
	  <% String strsep2=Helper.correctNull((String) veccol6.get(3));
     
     double sep2=Double.parseDouble(strsep2);
     %>
      <td width="23%"> 
        <input type="text" name="txt_Drdays" tabindex="48" maxlength="15" value="<%=nf.format(sep2)%>" onKeyPress="allowInteger()" onBlur="MonthValidation('SEP',this);">
      </td>
    </tr>
    <tr class="datagrid"> 
      <td width="10%">April</td>
      <td width="9%"> 
        <lapschoice:CurrencyTag name="txt_Cramt" tabindex="25" maxlength="15" value='<%=Helper.correctNull((String) veccol7.get(0))%>' onKeyPress="allowWholeNumber(this)"/>
      </td>
	  <% String strapril1=Helper.correctNull((String) veccol7.get(1));
     
     double april1=Double.parseDouble(strapril1);
     %>
      <td width="8%"> 
        <input type="text" name="txt_Crdays" tabindex="26" maxlength="15" value="<%=nf.format(april1)%>" onKeyPress="allowInteger()" onBlur="MonthValidation('APR',this);">
      </td>
      <td width="10%"> 
        <lapschoice:CurrencyTag name="txt_Dramt" tabindex="27" maxlength="15" value='<%=Helper.correctNull((String) veccol7.get(2))%>' onKeyPress="allowWholeNumber(this)"/>
      </td>
	  <% String strapril2=Helper.correctNull((String) veccol7.get(3));
     
     double april2=Double.parseDouble(strapril2);
     %>
      <td width="10%"> 
        <input type="text" name="txt_Drdays" tabindex="28" maxlength="15" value="<%=nf.format(april2)%>" onKeyPress="allowInteger()" onBlur="MonthValidation('APR',this);">
      </td>
      <td width="12%">Oct.</td>
      <td width="10%"> 
        <lapschoice:CurrencyTag name="txt_Cramt" tabindex="49" maxlength="15" value='<%=Helper.correctNull((String) veccol8.get(0))%>' onKeyPress="allowWholeNumber(this)"/>
      </td>
	  <% String stroct1=Helper.correctNull((String) veccol8.get(1));
     
     double oct1=Double.parseDouble(stroct1);
     %>
      <td width="10%"> 
        <input type="text" name="txt_Crdays" tabindex="50" maxlength="15" value="<%=nf.format(oct1)%>" onKeyPress="allowInteger()" onBlur="MonthValidation('OCT',this);">
      </td>
      <td width="12%"> 
        <lapschoice:CurrencyTag name="txt_Dramt" tabindex="51" maxlength="15" value='<%=Helper.correctNull((String) veccol8.get(2))%>' onKeyPress="allowWholeNumber(this)"/>
      </td>
	  <% String stroct2=Helper.correctNull((String) veccol8.get(3));
     
     double oct2=Double.parseDouble(stroct2);
     %>
      <td width="23%"> 
        <input type="text" name="txt_Drdays" tabindex="52" maxlength="15" value="<%=nf.format(oct2)%>" onKeyPress="allowInteger()" onBlur="MonthValidation('OCT',this);">
      </td>
    </tr>
    <tr class="datagrid"> 
      <td width="10%">May</td>
      <td width="9%"> 
        <lapschoice:CurrencyTag name="txt_Cramt" tabindex="29" maxlength="15"  value='<%=Helper.correctNull((String) veccol9.get(0))%>' onKeyPress="allowWholeNumber(this)"/>
      </td>
	  <% String strmay1=Helper.correctNull((String) veccol9.get(1));
     
     double may1=Double.parseDouble(strmay1);
     %>
      <td width="8%"> 
        <input type="text" name="txt_Crdays" tabindex="30" maxlength="15" value="<%=nf.format(may1)%>" onKeyPress="allowInteger()" onBlur="MonthValidation('MAY',this);">
      </td>
      <td width="10%"> 
        <lapschoice:CurrencyTag name="txt_Dramt" tabindex="31" maxlength="15" value='<%=Helper.correctNull((String) veccol9.get(2))%>' onKeyPress="allowWholeNumber(this)"/>
      </td>
	  <% String strmay2=Helper.correctNull((String) veccol9.get(3));
     
     double may2=Double.parseDouble(strmay2);
     %>
      <td width="10%"> 
        <input type="text" name="txt_Drdays" tabindex="32" maxlength="15" value="<%=nf.format(may2)%>" onKeyPress="allowInteger()" onBlur="MonthValidation('MAY',this);">
      </td>
      <td width="12%">Nov.</td>
      <td width="10%"> 
        <lapschoice:CurrencyTag name="txt_Cramt" tabindex="53" maxlength="15" value='<%=Helper.correctNull((String) veccol10.get(0))%>' onKeyPress="allowWholeNumber(this)"/>
      </td>
	  <% String strnov1=Helper.correctNull((String) veccol10.get(1));
     
     double nov1=Double.parseDouble(strnov1);
     %>
      <td width="10%"> 
        <input type="text" name="txt_Crdays" tabindex="54" maxlength="15" value="<%=nf.format(nov1)%>" onKeyPress="allowInteger()" onBlur="MonthValidation('NOV',this);">
      </td>
      <td width="12%"> 
        <lapschoice:CurrencyTag name="txt_Dramt" tabindex="55" maxlength="15"  value='<%=Helper.correctNull((String) veccol10.get(2))%>' onKeyPress="allowWholeNumber(this)"/>
      </td>
	  <% String strnov2=Helper.correctNull((String) veccol10.get(3));
     
     double nov2=Double.parseDouble(strnov2);
     %>
      <td width="23%"> 
        <input type="text" name="txt_Drdays" tabindex="56" maxlength="15" value="<%=nf.format(nov2)%>" onKeyPress="allowInteger()" onBlur="MonthValidation('NOV',this);">
      </td>
    </tr>
    <tr class="datagrid"> 
      <td width="10%">Jun</td>
      <td width="9%"> 
        <lapschoice:CurrencyTag name="txt_Cramt" tabindex="33" maxlength="15" value='<%=Helper.correctNull((String) veccol11.get(0))%>' onKeyPress="allowWholeNumber(this)"/> 
      </td>
	  <% String strjun1=Helper.correctNull((String) veccol11.get(1));
     
     double jun1=Double.parseDouble(strjun1);
     %>
      <td width="8%"> 
        <input type="text" name="txt_Crdays" tabindex="34"maxlength="15" value="<%=nf.format(jun1)%>" onKeyPress="allowInteger()" onBlur="MonthValidation('JUN',this);">
      </td>
      <td width="10%"> 
        <lapschoice:CurrencyTag name="txt_Dramt" tabindex="35" maxlength="15"value='<%=Helper.correctNull((String) veccol11.get(2))%>' onKeyPress="allowWholeNumber(this)"/>
      </td>
	  <% String strjun2=Helper.correctNull((String) veccol11.get(3));
     
     double jun2=Double.parseDouble(strjun2);
     %>
      <td width="10%"> 
        <input type="text" name="txt_Drdays" tabindex="36" maxlength="15" value="<%=nf.format(jun2)%>" onKeyPress="allowInteger()" onBlur="MonthValidation('JUN',this);">
      </td>
      <td width="12%">Dec.</td>
      <td width="10%"> 
        <lapschoice:CurrencyTag name="txt_Cramt" tabindex="57"  maxlength="15" value='<%=Helper.correctNull((String) veccol12.get(0))%>' onKeyPress="allowWholeNumber(this)"/>
      </td>
	  <% String strdec1=Helper.correctNull((String) veccol12.get(1));
     
     double dec1=Double.parseDouble(strdec1);
     %>
      <td width="10%"> 
        <input type="text" name="txt_Crdays" tabindex="58" maxlength="15" value="<%=nf.format(dec1)%>" onKeyPress="allowInteger()" onBlur="MonthValidation('DEC',this);">
      </td>
      <td width="12%"> 
        <lapschoice:CurrencyTag name="txt_Dramt" tabindex="59" maxlength="15"  value='<%=Helper.correctNull((String) veccol12.get(2))%>' onKeyPress="allowWholeNumber(this)"/>
      </td>
	  <% String strdec2=Helper.correctNull((String) veccol12.get(3));
     
     double dec2=Double.parseDouble(strdec2);
     %>
      <td width="23%"> 
        <input type="text" name="txt_Drdays" tabindex="60" maxlength="15" value="<%=nf.format(dec2)%>" onKeyPress="allowInteger()" onBlur="MonthValidation('DEC',this);">
      </td>
    </tr>
  </table>
  <table width="100%" class="outertable">
  	<tr>
		<td>
			For sanction office use
		</td>
		<td>			
        <textarea name="text_sanction" cols="80" rows="5" tabindex="61" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("ADV_sanction"))%></textarea>
		</td>
	</tr>
  </table>
  </td>
  </tr>
  </table>
  <br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br> 
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr> 
      <td width="20%" ><b>&nbsp;
        <a href="javascript:callLink('adv_otherbank.jsp','ADV1151','getotherbank')"> 
           &lt;&lt; Previous </a>&nbsp;</b>
      </td>
      <td width="60%" align="center"><b> 
        <jsp:include page="../ADV11-51/adv_links.jsp" flush="true" /> 
        </b></td>
      <td width="20%">&nbsp; 
        <div align="right"><b>Pg.8/19  &nbsp;<a href="javascript:callLink('adv_depositaccounts.jsp','ADV1151','getDepositAccounts')"> 
          Next &gt;&gt; </a></b></div>
      </td>
    </tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="pageval" value="FIA">
 </form>
</body>
</html>
