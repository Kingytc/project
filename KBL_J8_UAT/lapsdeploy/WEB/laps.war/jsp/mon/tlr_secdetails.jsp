<%@include file="../share/directives.jsp"%>
<%
ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();

arrRow=(ArrayList)hshValues.get("arrRow");

%>
<html>
<head>
<title>Security Details</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate="<%=Helper.getCurrentDateTime()%>";
function enableButtons(valnew,valedit,valapply,valcancel,valdel,valclose)
{
	document.forms[0].cmdnew.disabled=valnew;
	document.forms[0].cmdedit.disabled=valedit;
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmddelete.disabled=valdel;
	document.forms[0].cmdclose.disabled=valclose;
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
		else if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=val;		
		}
	}
	
	
}

function onLoad()
{
	disableFields(true);
	
}

function doNew()
{
	document.forms[0].hidAction.value="Insert";
	disableFields(false);
	enableButtons(true,true,false,false,true,true);
}

function doEdit()
{
	document.forms[0].hidAction.value="Update";
	disableFields(false);
	enableButtons(true,true,false,false,true,true);
}

function doSave()
{
	
	if(document.forms[0].selsectype.value=="S")
	{
		ShowAlert(111,'Security Type');
		document.forms[0].selsectype.focus();
		return true;
	}
	if(trim(document.forms[0].txtsecdetails.value)=="")
	{
		ShowAlert(121,'Security Details');
		document.forms[0].txtsecdetails.focus();
		return true;
	}
	
	if(document.forms[0].selsectype.value=="Primary" && document.forms[0].selfacility.value=="S")
	{
		ShowAlert(111,'Facility Details');
		document.forms[0].selfacility.focus();
		return true;
	}
	if(trim(document.forms[0].txtsecremarks.value) == "")
	{
		ShowAlert(111,'Security Remarks');
		document.forms[0].txtsecremarks.focus();
		return true;
	}
	document.forms[0].hidFacility.value = document.forms[0].selfacility[document.forms[0].selfacility.selectedIndex].text;
	document.forms[0].hidBeanId.value="reviewtermloan";
	document.forms[0].hidBeanMethod.value="updateSecuritiesData";
	document.forms[0].hidBeanGetMethod.value="getSecuritiesData";
	document.forms[0].hidSourceUrl.value="/action/tlr_secdetails.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doCancel()
{
	if(ConfirmMsg(102)){
	document.forms[0].hidBeanId.value="reviewtermloan";
	document.forms[0].hidBeanGetMethod.value="getSecuritiesData";
	document.forms[0].action=appURL+"action/tlr_secdetails.jsp";
	document.forms[0].submit();
	}
}

function doDelete()
{
	if(ConfirmMsg(101)){
	document.forms[0].hidAction.value="Delete";
	document.forms[0].hidBeanId.value="reviewtermloan";
	document.forms[0].hidBeanMethod.value="updateSecuritiesData";
	document.forms[0].hidBeanGetMethod.value="getSecuritiesData";
	document.forms[0].hidSourceUrl.value="/action/tlr_secdetails.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
	}
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/mon_borrowersearch.jsp?hidmontype=MONITREVIEW";
		document.forms[0].submit();
	}
}
function callDescHelp(id)
{	
	if(document.forms[0].cmdedit.disabled &&  document.forms[0].readFlag.value.toUpperCase()=="W")
	{
		var varQryString = appUrl+"action/staticdatahelp.jsp?id="+id;
		var title = "IndustryHelp";
		var prop = "scrollbars=no,width=650,height=400";	
		prop = prop + ",left=200,top=200";
		window.open(varQryString,title,prop);	
	}
}

function palceValues(val1,val2,val3,val4,val5,val6,val7,val8)
{
	document.forms[0].hidsno.value=val1;
	document.forms[0].txtsecdetails.value=val4;
	document.forms[0].txtsecremarks.value=val5;
	document.forms[0].txtsecvalue.value=val6;
	document.forms[0].txt_lastvaluationdate.value=val7;
	document.forms[0].selsectype.value=val2;
	
	if(val2=="Primary")
	{
		document.all.idfacility.style.visibility="visible";
		document.all.idfacility.style.position="relative";
		document.forms[0].selfacility.value=val3;
		document.forms[0].txt_secmargin.value=val8;
	}
	else
	{
		document.all.idfacility.style.visibility="hidden";
		document.all.idfacility.style.position="absolute";
		document.forms[0].selfacility.value="S";

	}
	
	if(document.forms[0].btnenable.value=="Y")
	{
		enableButtons(true,false,true,true,false,false);
	}
}

function callFacilities()
{
	if(document.forms[0].selsectype.value=="Primary")
	{
		document.all.idfacility.style.visibility="visible";
		document.all.idfacility.style.position="relative";
	}
	else
	{
		document.all.idfacility.style.visibility="hidden";
		document.all.idfacility.style.position="absolute";
		document.forms[0].selfacility.value="S";

	}
}
function callOtherLink(page,bean,method)
{
	if(!document.forms[0].reviewYear.value=="")
	{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appURL+"action/"+page;
		document.forms[0].submit();
	}
	else
	{
		alert("Select Review Year");
	}
}

function callCalender(val)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		 showCal(appURL,val);
	}
}

</script>
</head>
<body onload="onLoad();callFacilities()">
<form name="frmpri" method=post class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
			<lapschoice:tlrtag pageid="4" reviewof='<%=Helper.correctNull((String)request.getParameter("reviewOf"))%>' valuesin='<%=Helper.correctNull((String)request.getParameter("valuesin"))%>'/>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>

		<td valign="top" colspan="5" class="page_flow">Home -&gt; Term Loan - Review -&gt; Securities</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
			<tr>
				<td><lapschoice:MonitorReview /></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<table width="78%" border="0" cellspacing="1" cellpadding="3" align="center"  class="outertable border1">
<tr align="center">
 <td valign="top">

    <table width="78%" border="0" cellspacing="1" cellpadding="3" align="center"  class="outertable">
      <tr> 
        <td>Security Type <span class="mantatory">&nbsp;*</span></td>
        <td colspan="3"> 
          <select name="selsectype" onChange="callFacilities()">
            <option value="S" selected>&lt;---Select---&gt;</option>
            <option value="Primary">Primary</option>
            <option value="Collateral">Collateral</option>
          </select>
            </td>
       
      </tr>
         <tr id="idfacility"> 
        <td >Facility<span class="mantatory">&nbsp;*</span></td>
        <td> 
          <select name="selfacility">
            <option value="S" selected>&lt;---Select---&gt;</option>
            <lapschoice:tlrfacilities /> 
          </select>
         </td>
         <td>Margin (%)</td>
                  <td><lapschoice:CurrencyTag name="txt_secmargin" size="7"
							maxlength="5" onBlur="checkPercentage(this)"/></td>
        </tr>
  
      <tr> 
        <td valign="top" nowrap>Security Details  <span class="mantatory">&nbsp;*</span></td>
        <td valign="top" nowrap> 
          <textarea name="txtsecdetails" cols="25" rows="3" onKeyPress="textlimit(this,999)" onKeyUp="textlimit(this,999)"
							wrap="VIRTUAL"></textarea>
        </td>
        <td valign="top" nowrap>Security Remarks <span class="mantatory">&nbsp;*</span></td>
        <td nowrap> 
          <textarea name="txtsecremarks" cols="50" rows="5" onKeyPress="textlimit(this,999)" onKeyUp="textlimit(this,999)"
							wrap="VIRTUAL"></textarea>
        </td>
      </tr>
      <tr> 
        <td valign="middle" nowrap>Security Value</td>
        <td valign="top" nowrap><lapschoice:CurrencyTag name="txtsecvalue" size="15"
							maxlength="12" /></td>
        <td nowrap>Date of Last Valuation</td>
        <td nowrap> 
          <input type="text" name="txt_lastvaluationdate" size="12"
							maxlength="10"
							onBlur="checkDate(this);checkmaxdate(this,currentDate)">
          <a
							alt="Select date from calender" href="#"
							onClick="callCalender('txt_lastvaluationdate')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
							alt="Select date from calender"></a></td>
      </tr>
    </table>
    </td>
   </tr>
   </table>
   <br>
   <table class="outertable">
      <tr> 
	<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
      
      </tr>
    </table>
<br>
  <table width="97%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable linebor">
    <tr class="dataheader">
		<td >&nbsp;</td>
		<td ><b>Security Details </b></td>
		<td ><b>Security Remarks</b></td>
		<td ><b>Security Value</b></td>
		<td ><b>Date of Last Valuation</b></td>
	
	</tr>
	<%
		if(arrRow!=null && arrRow.size()>0)
		{
			for(int i=0; i<arrRow.size();i++)
			{
				arrCol=(ArrayList)arrRow.get(i);
	%>
	<tr valign="top" class="datagrid">
		<td width="3%"><input type="radio" name="rdosec"
			onclick="palceValues('<%=Helper.correctNull((String)arrCol.get(0))%>',
			'<%=Helper.correctNull((String)arrCol.get(1))%>','<%=Helper.correctNull((String)arrCol.get(2))%>',
		    '<%=Helper.correctDoubleQuotesScript(Helper.replaceForJavaScriptString((String)arrCol.get(3)))%>',
			'<%=Helper.correctDoubleQuotesScript(Helper.replaceForJavaScriptString((String)arrCol.get(4)))%>',
			'<%=Helper.correctNull((String)arrCol.get(5))%>',
			'<%=Helper.correctNull((String)arrCol.get(6))%>','<%=Helper.correctNull((String)arrCol.get(7))%>')"
			style="border: none"></td>
		<td width="31%"><%=Helper.correctNull((String)arrCol.get(3))%>&nbsp;</td>
		<td width="34%" class="jsut"><%=Helper.correctNull((String)arrCol.get(4))%>&nbsp;</td>
		<td width="10%"><%=Helper.correctNull((String)arrCol.get(5))%>&nbsp;</td>
		<td width="10%"><%=Helper.correctNull((String)arrCol.get(6))%>&nbsp;</td>
		
	</tr>
	<%
			}
		}else{
	%>
		<tr class="datagrid">
		   <td colspan="5" align="center">No Data</td>
		</tr>
	<%} %>	
</table><br>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidsno" />
<input type="hidden" name="reviewOf" value="<%=request.getParameter("reviewOf")%>">
<input type="hidden" name="hidFacility">
</form>
</body>
</html>

