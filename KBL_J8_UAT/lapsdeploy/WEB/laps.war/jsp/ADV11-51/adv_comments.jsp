<%@include file="../share/directives.jsp"%>
<%
java.text.NumberFormat nf=java.text.NumberFormat.getInstance();
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
nf.setGroupingUsed(false);
String strstock=Helper.correctNull((String)hshValues.get("advcom_stock"));
String strpenalinterest=Helper.correctNull((String)hshValues.get("advcom_penalinterest"));
String strsanctionadvice=Helper.correctNull((String)hshValues.get("advcom_sanctionadvice"));
String strlimitdrawing=Helper.correctNull((String)hshValues.get("advcom_limitdrawing"));
String strwithdrwlextent=Helper.correctNull((String)hshValues.get("advcom_cashwithdrawl"));
String strpurposewithdrawl=Helper.correctNull((String)hshValues.get("advcom_purposewithdrawl"));
%>
<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var stock="<%=strstock%>";
var penalinterest="<%=strpenalinterest%>";
var sanctionadvice="<%=strsanctionadvice%>";
var limitdrawing="<%=strlimitdrawing%>";
var withdrwlextent="<%=strwithdrwlextent%>";
var purposewithdrawl="<%=strpurposewithdrawl%>";
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
function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hideditflag.value="Y";
	disableCommandButtons("edit");	
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="";
		document.forms[0].hidSourceUrl.value="/action/adv_comments.jsp";
		document.forms[0].hidBeanId.value="ADV1151";
		document.forms[0].hidBeanGetMethod.value="getComments";
		document.forms[0].action=appUrl +"controllerservlet";
		document.forms[0].submit(); 		
	}	
}

function doSave()
{
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].hidRecordflag.value= varRecordFlag;
		document.forms[0].hidSourceUrl.value="/action/adv_comments.jsp";
		document.forms[0].hidBeanId.value="ADV1151";
		document.forms[0].hidBeanMethod.value="updateComments";
		document.forms[0].hidBeanGetMethod.value="getComments";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();
}
function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(ConfirmMsg(101))
		{
			document.forms[0].hidAction.value ="delete";
			document.forms[0].hidSourceUrl.value="/action/adv_comments.jsp";
			document.forms[0].hidBeanId.value="ADV1151";
			document.forms[0].hidBeanMethod.value="updateComments";
			document.forms[0].hidBeanGetMethod.value="getCommnets";
			document.forms[0].action=appUrl+"controllerservlet";
			document.forms[0].submit();
		}
	}
	else
	{
		
		ShowAlert(158);
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
function onLoading()
{
	var stock="<%=strstock%>";
	var penalinterest="<%=strpenalinterest%>";
	var sanctionadvice="<%=strsanctionadvice%>";
	var limitdrawing="<%=strlimitdrawing%>";
	var withdrwlextent="<%=strwithdrwlextent%>";
	var purposewithdrawl="<%=strpurposewithdrawl%>";	
	if(stock!="")
	{
		document.forms[0].sel_stock.value=stock;
	}
	else
	{
		document.forms[0].sel_stock.value="0";
	}
	if(penalinterest!="")
	{
		document.forms[0].sel_penalinterest.value=penalinterest;
	}
	else
	{
		document.forms[0].sel_penalinterest.value="0";
	}
	if(sanctionadvice!="")
	{
		document.forms[0].sel_sanctionadvice.value=sanctionadvice;
	}
	else
	{
		document.forms[0].sel_sanctionadvice.value="0";
	}
	if(limitdrawing!="")
	{
		document.forms[0].sel_limitdrawing.value=limitdrawing;
	}
	else
	{
		document.forms[0].sel_limitdrawing.value="0";
	}
	if(withdrwlextent!="")
	{
		document.forms[0].sel_cashwithdrawl.value=withdrwlextent;
	}
	else
	{
		document.forms[0].sel_cashwithdrawl.value="1";
	}
	if(purposewithdrawl!="")
	{
		document.forms[0].sel_purposewithdrawl.value=purposewithdrawl;
	}
	else
	{
		document.forms[0].sel_purposewithdrawl.value="0";
	}
	selectStock();selectSanctionadvice();selectLimitdrawing();
	disableFields(true);
}
function doClose()
	{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/agrpage.jsp";
		document.forms[0].submit();		
	}
}	
function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appUrl,name);		
	}
}
function callLink(page,bean,method)
	{
	
		if (document.forms[0].cmdsave.disabled)
		{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appUrl+"action/"+page;
		document.forms[0].submit();
		}
		else
		{
		ShowAlert(103);
		}
	}
function selectStock()
{
	if(document.forms[0].sel_stock.value=="2")
	{
		document.all.d1.style.visibility="visible";
		document.all.d1.style.position="relative";
	}
	else
	{
		document.all.d1.style.visibility="hidden";
		document.all.d1.style.position="absolute";
	}
}
function selectSanctionadvice()
{
	if(document.forms[0].sel_sanctionadvice.value=="2")
	{
		document.all.d2.style.visibility="visible";
		document.all.d2.style.position="relative";
	}
	else
	{
		document.all.d2.style.visibility="hidden";
		document.all.d2.style.position="absolute";
	}
}
function selectLimitdrawing()
{
	if(document.forms[0].sel_limitdrawing.value=="1")
	{
		document.all.d3.style.visibility="visible";
		document.all.d3.style.position="relative";
	}
	else
	{
		document.all.d3.style.visibility="hidden";
		document.all.d3.style.position="absolute";
	}
} 
</script>
</head>

<body onload="onLoading()">
<form name="form1" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td> <jsp:include page="../share/applurllinkscom.jsp"
			flush="true">
			<jsp:param name="pageid" value="19" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<tr>
		<td class="page_flow">Home -&gt; Tertiary -&gt; Proposal -&gt; ADV1151 -&gt; Comments</td>
	</tr>
</table>
<lapschoice:borrowertype /> <lapschoice:application /><br>
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
	<TR class="dataheader">
		<TD ALIGN="CENTER">
			<B>COMMENTS</B>
		</TD>
	</TR>
</table>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable datagrid">
    <tr> 
      <td width="54%">Whether Stock/Book Debts/QIS Statement are submitted 
        in time </td>
      <td width="46%"> 
        <select name="sel_stock" onChange="selectStock()" tabindex="1">
          <option value="0" selected="selected">&lt;---Select---&gt;</option>
          <option value="1">YES</option>
          <option value="2">NO</option>
        </select>
      </td>
    </tr>
    <tr id="d1"> 
      <td width="54%" >If no,Give Details</td>
      <td width="46%"> 
        <textarea name="txt_details" rows="6" cols="50" tabindex="2" maxlength="4000" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("advcom_details"))%></textarea>
      </td>
    </tr>
    <tbody> 
    <tr> 
      <td width="54%">Whether Penal interest is charged<O:P><br></O:P>
        <br>
      </td>
      <td width="46%"><br>
        <select name="sel_penalinterest" tabindex="3">
          <option value="0" selected="selected">&lt;---Select---&gt;</option>
          <option value="1">YES</option>
          <option value="2">NO</option>
        </select>
      </td>
    </tr>
    <tr> 
      <td width="54%" >Whether all stipulations of previous sanction 
        advice have been complied with and the limits utilised accordingly. </td>
      <td width="46%" > 
        <select name="sel_sanctionadvice" onChange="selectSanctionadvice()" tabindex="4">
          <option value="0" selected="selected">&lt;---Select---&gt;</option>
          <option value="1">YES</option>
          <option value="2">NO</option>
        </select>
      </td>
    </tr>
    </tbody> 
    <tr id="d2"> 
      <td width="54%" ><br>
        If not, give details with justification. <br>
      </td>
      <td width="46%"  > 
        <textarea name="txt_detailjust" rows="6" cols="50" tabindex="5" maxlength="4000" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("advcom_detailjust"))%></textarea>
      </td>
    </tr>
    <tr> 
      <td width="54%" >Are limits or drawing power exceeded ? <O:P></O:P> 
      </td>
      <td width="46%" > 
        <select name="sel_limitdrawing" onChange="selectLimitdrawing()" tabindex="6">
          <option value="0" selected="selected">&lt;---Select---&gt;</option>
          <option value="1">YES</option>
          <option value="2">NO</option>
        </select>
      </td>
    </tr>
    <tr id="d3"> 
      <td width="54%"  ><br>
        If Yes, When and to what extent ?<br>
      </td>
      <td width="46%" > 
        <textarea name="txt_drawingextent" rows="6" cols="50" tabindex="7" maxlength="4000" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("advcom_drawingextent"))%></textarea>
      </td>
    </tr>
    <tr> 
      <td >For Sanctioning Office use 
        
      </td>
      <td ><textarea rows="8" name="txt_sanctionoffuse" cols="60" tabindex="8" maxlength="4000" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("advcom_sanctionoffuse"))%></textarea></td>
    </tr>
    <tr> 
      <td width="54%" > Whether Cash Withdrawals are frequently made&nbsp;</td>
      <td width="46%" > 
        <select name="sel_cashwithdrawl" tabindex="9">
          <option value="1" selected="selected">Frequently</option>
          <option value="2">Never</option>
          <option value="3">Rarely</option>
          <option value="4">No Occasion</option>
        </select>
      </td>
    </tr>
    <tr> 
      <td width="54%" >If so, to what extent ? </td>
      <td width="46%" > 
        <input type="text" name="txt_withdrwlextent" tabindex="10" value="<%=Helper.correctNull((String)hshValues.get("advcom_withdrwlextent"))%>" maxlength="100">
      </td>
    </tr>
    <tr> 
      <td width="54%" >Purpose of cash withdrawal</td>
      <td width="46%" > 
        <select name="sel_purposewithdrawl" tabindex="11">
          <option value="0" selected="selected">Select</option>
          <option value="1">For Payment of Govt. dues</option>
          <option value="2">For disbursement of wages/salaries</option>
          <option value="3">Purchase of raw materials</option>
          <option value="4">Any Other purpose (specify )</option>
        </select>
        <input type="text" name="txt_purposedetails" tabindex="12" value="<%=Helper.correctNull((String)hshValues.get("advcom_purposedetails"))%>" maxlength="15">
      </td>
    </tr>
  </table>
  <br>
   <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr> 
      <td width="20%" ><b>&nbsp; 
        <a href="javascript:callLink('adv_liabilities.jsp','ADV1151','getADVLiabilities')"> 
        &lt;&lt; Previous </a>&nbsp; </b> </td>
      <td width="60%" align="center"><b> 
        <jsp:include page="../ADV11-51/adv_links.jsp" flush="true"> </jsp:include>
        </b></td>
      <td width="20%">&nbsp; 
        <div align="right"><b>Pg.15/19&nbsp;&nbsp;
        <a href="javascript:callLink('adv_document.jsp','ADV1151','getADVDocument')"> 
          Next &gt;&gt;</a></b></div>
      </td>
    </tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>
