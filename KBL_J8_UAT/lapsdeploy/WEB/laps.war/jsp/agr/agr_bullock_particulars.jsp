<%@include file="../share/directives.jsp"%>
<%
String schemetype = Helper.correctNull((String)request.getParameter("schemetype"));
if(schemetype. trim().equalsIgnoreCase(""))
{
	schemetype="0";
}

ArrayList arryCol=null;
ArrayList arryRow=(ArrayList)hshValues.get("arrData");	
ArrayList arryRow1=(ArrayList)hshValues.get("arrPart");


%>

<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>
var appUrl  ="<%=ApplicationParams.getAppUrl()%>"; 
var CurrentDate="<%=Helper.getCurrentDateTime()%>";
var curryear=CurrentDate.substring(6,10);
var varunit=new Array();
var varyear=new Array();
var varage=new Array();
var varnumber=new Array();
var varrate=new Array();
var varcost=new Array();
var varbreed=new Array();
var arrSize = '<%=arryRow.size()%>';
var thisValidationErrors=null;
 <%
for(int i=1;i<3;i++)
{
	if(arryRow!=null && arryRow.size()>=i)
		{

		arryCol=(ArrayList)arryRow.get(i-1);
		if(arryCol!=null)
		{	
																			
%>  
		
		varunit["<%=i-1%>"]="<%=Helper.correctNull((String)arryCol.get(0))%>";
		varage["<%=i-1%>"]="<%=Helper.correctNull((String)arryCol.get(1))%>";
		varyear["<%=i-1%>"]="<%=Helper.correctNull((String)arryCol.get(2))%>";
		
<%
			}
		}
}

%>

<%
arryCol = null;
for(int i=1;i<6;i++)
{
	if(arryRow1!=null && arryRow1.size()>=i)
		{

		arryCol=(ArrayList)arryRow1.get(i-1);
		if(arryCol!=null)
		{	
																			
%>  
		varnumber["<%=i-1%>"]="<%=Helper.correctNull((String)arryCol.get(0))%>";
		varcost["<%=i-1%>"]="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arryCol.get(2))))%>";
		varrate["<%=i-1%>"]="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arryCol.get(1))))%>";
		varbreed["<%=i-1%>"]="<%=Helper.correctNull((String)arryCol.get(3))%>";
<%

			}
		}
}

%>

function callfilldata()
{

	for(var i=0;i<varunit.length;i++)
	{
		document.forms[0].txt_bull_unit[i].value=varunit[i];
		document.forms[0].txt_bull_age[i].value=varage[i];
		document.forms[0].txt_bull_year[i].value=varyear[i];	
	}
	for(i=0;i<varbreed.length;i++)
	{
		document.forms[0].txt_bull_amt[i].value=varcost[i];
		document.forms[0].txt_bull_no[i].value=varnumber[i];
		document.forms[0].txt_bull_breed[i].value=varbreed[i];
		document.forms[0].txt_bull_rate[i].value=varrate[i];
	}

}

function doEdit()
{
 	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	enableButtons(true, false, false, false, true);	
	settabindex();
		
}
function showMessage(thisValidationErrors)
{
	var displayMsg="";
	for(j=0;j<thisValidationErrors.length;j++){
		desc = thisValidationErrors[j];
		displayMsg+="\n"+" - "+desc;
	}
	alert(displayMsg);
}

function groupAlerts()
{
	var args = groupAlerts.arguments;	
	var errMsg = getErrorMessage(args);	
	thisValidationErrors.push(errMsg);
}
function doSave()
{  
	    thisValidationErrors=new Array();
	    
		if(document.forms[0].txt_bull_unit[1].value=="")
		{
			ShowAlert('121','Proposed to be purchased/replacement - Number');
			return false;
		}
		if(document.forms[0].txt_bull_age[1].value=="")
		{
			ShowAlert('121','Proposed to be purchased/replacement - Age');
			return false;
		}
		if(document.forms[0].txt_bull_year[1].value=="")
		{
			ShowAlert('121','Proposed to be purchased/replacement -  Year');
			return false;
		}
		for(var i=0;i<document.forms[0].txt_bull_breed.length;i++)
		{
			if(document.forms[0].txt_bull_breed[i].value != "")
				calculate_costval(i);
		}
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].action=appUrl+"action/ControllerServlet";		
		document.forms[0].hidBeanGetMethod.value="getBullockParticulars";
		document.forms[0].hidBeanMethod.value="updateBullockParticulars";
		document.forms[0].hidBeanId.value="agriculture";
		document.forms[0].hidSourceUrl.value="action/agr_bullock_particulars.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	    
	
}

function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agriculture";
		document.forms[0].hidBeanGetMethod.value="getBullockParticulars";
		document.forms[0].action=appUrl+"action/agr_bullock_particulars.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();	
	}	
}

function doDelete()
{
   if(arrSize == 0){
		ShowAlert('167');
		return;
   }
   if(ConfirmMsg(101))
   {
	document.forms[0].hidAction.value ="delete";
	document.forms[0].action=appUrl+"action/ControllerServlet";		
	document.forms[0].hidBeanGetMethod.value="getBullockParticulars";
	document.forms[0].hidBeanMethod.value="updateBullockParticulars";
	document.forms[0].hidBeanId.value="agriculture";
	document.forms[0].hidSourceUrl.value="action/agr_bullock_particulars.jsp";	
	document.forms[0].method="post";			
	document.forms[0].submit();		
}	
}

function onloading()
{	  
	disableFields(true);
	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value="<%=schemetype%>";
	callfilldata();
	
}

function enableButtons( bool2, bool3, bool4, bool5, bool6)
{	
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled = bool6;
}

function disableFields(flag)
{	
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
		  document.forms[0].elements[i].readOnly=flag;		  
		}
		
		if(document.forms[0].elements[i].type=="textarea")
		{
		  document.forms[0].elements[i].readOnly=flag;		  
		}
		if(document.forms[0].elements[i].type=="select-one")
		{
		  document.forms[0].elements[i].disabled=flag;		  
		}
	}
	for(var i=0;i<document.forms[0].txt_bull_amt.length;i++)
	{
		document.forms[0].txt_bull_amt[i].readOnly=true;	
	}
}

function doClose()
{
if( ConfirmMsg(100))
	{
		parent.menuFrame.doWindowClose();
	}
}


function min_nos(no,index)
{
	var min_len=document.forms[0].txt_bull_year[index].value.length;
	
		if(document.forms[0].txt_bull_year[index].value !="" && min_len<eval(no))
		{
			alert("Enter all "+no+" digits");
			document.forms[0].txt_bull_year[index].value="";
			document.forms[0].txt_bull_year[index].focus();
		}
	
}
function since(index)
{
 	var year=document.forms[0].txt_bull_year[index].value;
 	if(document.forms[0].txt_bull_year[index].value !="" && curryear<year)
	{
 		alert("Year cannot be greater than Current year");
 	 	document.forms[0].txt_bull_year[index].value="";
 	 	document.forms[0].txt_bull_year[index].focus();
 	}
}
function calculate_cost(obj)
{
	var index=obj.breed;
	var unit = document.forms[0].txt_bull_no[index].value;
	var rate = document.forms[0].txt_bull_rate[index].value;
	if(unit=="")
	{
		unit = 0;
		document.forms[0].txt_bull_no[index].value=unit;
	}
	if(rate=="")
	{
		rate = 0.00;
		document.forms[0].txt_bull_rate[index].value=rate;
	}
	var cost= eval(unit) * eval(rate);
	document.forms[0].txt_bull_amt[index].value = cost;
}
function settabindex()
{	var tab = 8;
	for(var i=0;i<document.forms[0].txt_bull_breed.length;i++)
	{	
		tab = tab+1;
		document.forms[0].txt_bull_breed[i].tabIndex = tab;
		tab=tab+1;
		document.forms[0].txt_bull_no[i].tabIndex = tab;	
		tab=tab+1;
		document.forms[0].txt_bull_rate[i].tabIndex =  tab;
		tab=tab+1;
		document.forms[0].txt_bull_amt[i].tabIndex =  tab;
	}

}


function calculate_costval(val)
{
	var unit = document.forms[0].txt_bull_no[val].value;
	var rate = document.forms[0].txt_bull_rate[val].value;
	if(unit!="" && rate !="")
	{
		var cost= eval(unit) * eval(rate);
		document.forms[0].txt_bull_amt[val].value = cost;
	}
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
<form method="post" class="normal" name="bullpart">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="999" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt;Agriculture -&gt; Application -&gt; Particulars</td>
	</tr>
</table>
<lapschoice:borrowertype /> 
<lapschoice:application />
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="151" />
			<jsp:param name="schemetype" value="<%=schemetype%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">	
<tr>
<td>&nbsp;</td>
</tr>	
<tr>
<td align="center">

<table width="100%" border="0" cellspacing="1" cellpadding="3"  class="outertable">	
	<tr class="dataheader">		
            <td width="4%" align="center">S.No</td>		
            <td width="32%" align="center">Particulars</td>
			<td width="22%" align="center">Number</td>		
            <td width="20%" align="center">Age</td>		
            <td width="20%" align="center">Year</td>
	 </tr>
	
	<tr class="datagrid">		
            <td width="4%" align="center">1.</td>		
            <td width="32%">Presently owned</td>
            <td width="22%" align="center"> 
               <input type="text" name="txt_bull_unit" size="15" maxlength="5" tabindex="1" onKeyPress="allowInteger(this)" style="text-align: right"></td>		
            <td width="20%" align="center"> 
              <input type="text" name="txt_bull_age" size="15" maxlength="3" tabindex="2" onKeyPress="allowInteger(this)" style="text-align: right"></td>
		
            <td width="20%" align="center"> 
              <input type="text" name="txt_bull_year" size="15" maxlength="4"   onKeyPress="allowNumber(this)" onBlur="min_nos(4,0);since(0)" tabindex="3" style="text-align: right"></td>
		
	</tr>
	<tr class="datagrid">
		
            <td width="4%" align="center">2.</td>
		
            <td width="32%">Proposed to be purchased/replacement <b><span class="mantatory">*</span></b></td>
		    <td width="22%" align="center"> 
                <input type="text" name="txt_bull_unit" size="15" maxlength="5" tabindex="4" onKeyPress="allowInteger(this)" style="text-align: right"></td>
            <td width="20%" align="center"> 
              <input type="text" name="txt_bull_age" size="15" maxlength="3" tabindex="5" onKeyPress="allowInteger(this)" style="text-align: right" ></td>
		
   
		
            <td width="20%" align="center"> 
              <input type="text" name="txt_bull_year" size="15" maxlength="4"   onKeyPress="allowNumber(this)" onBlur="min_nos(4,1);since(1)" tabindex="6" style="text-align: right">
            </td>
		
	</tr>
</table>
<br/>
<table width="100%" border="0" cellspacing="1" cellpadding="3"  class="outertable">	
	<tr class="dataheader">
		<td width="4%" align="center">S.No</td>
		    <td width="49%" align="center">Particulars</td>
		    <td width="47%" align="center">Details</td>
	</tr>
	<tr class="datagrid">
	        <td width="4%" align="center">1.</td>
		
            <td width="49%">Reasons for purchase/replacement (if any)</td>
		
            <td width="47%" align="center" > 
              <textarea name="txtarea_reason" cols=60 rows=6 tabindex="7" onKeyPress="textlimit(this,199)" onKeyUp="textlimit(this,'199')"><%=Helper.correctNull((String)hshValues.get("Reason"))%></textarea>
            </td>
	</tr>
	<tr class="datagrid">
	        <td width="4%" align="center">2.</td>
		
            <td width="49%">Is infrastructure required for the project available?specify 
              any information if necessary for the project.</td>
		
            <td width="47%" align="center" > 
              <textarea name="txtarea_infra" cols=60 rows=6 tabindex="8" onKeyPress="textlimit(this,199)" onKeyUp="textlimit(this,'199')"><%=Helper.correctNull((String)hshValues.get("Infrastructure"))%></textarea>
            </td>
	</tr>
</table>
<br/>
<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">	
	<tr class="dataheader">		
            <td width="4%" align="center">S.No</td>		
            <td width="33%" align="center">Breed</td>		
            <td width="20%" align="center">Number</td>		
      		
	        
	</tr>
	<%for(int i=0;i<5;i++) {%>
	<tr class="datagrid">		
            <td width="4%" align="center"><%=i+1%>.</td>		
            <td width="33%" align="center"> 
              <input type="text" name="txt_bull_breed" size="30" maxlength="50"   onKeyPress="allowAlphabets()" ></td>		
            <td width="20%" align="center"> 
              <input type="text" name="txt_bull_no" size="15" maxlength="5"  onKeyPress="allowInteger(this)" style="text-align: right"></td>
		     <input type="hidden" name="txt_bull_rate" size="15" maxlength="5" breed="<%=i%>" onblur="roundtxt(this);calculate_cost(this)" onKeyPress="allowDecimals(this)" style="text-align: right" ></td>
      	      <input type="hidden" name="txt_bull_amt" size="15" maxlength="15" onblur="roundtxt(this)" onKeyPress="allowDecimals(this)" style="text-align: right" ></td>
	</tr>
	<%}%>
	
	<tr class="datagrid">
		<td colspan="2" align="right"><b>Total</b></td>
		<td align="center" width="20%"><b><%=Helper.correctInt((String)hshValues.get("total_estimate_unit"))%></b></td>
	</tr>
</table>
</td>
</tr>
<tr>
<td>&nbsp;</td>
</tr>
</table>
<br>
<%String strappno =Helper.correctNull((String) request.getParameter("appno"));

			if (strappno.equalsIgnoreCase("new")) {
				strappno = "";
			}			
%> 
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:hiddentag pageid="<%=PageId%>"/>
</form>
</body>
</html>
