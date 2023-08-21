<%@include file="../share/directives.jsp"%>
<%request.setAttribute("_cache_refresh", "true");%>
<html>
<head>
<title>Audit Observations</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var seltype="<%=Helper.correctNull((String)hshValues.get("seltype"))%>";
function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,name);
	}
}
function callOtherLink(page,bean,method)
{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appURL+"action/"+page;
		document.forms[0].submit();
	
}
function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;
}

function calGetData()
{
	if(document.forms[0].sel_audittype.value=="0")
	{
		document.forms[0].txt_auditorsobservations.value="";
		document.forms[0].txt_branchcomments.value="";
		return;
	}
	document.forms[0].hidBeanId.value="reviewtermloan";
	document.forms[0].hidBeanGetMethod.value="getAuditorObservationData";
	document.forms[0].action=appURL+"action/tlr_auditobservation.jsp";
    document.forms[0].submit();
}

function show_details()
{
	if(seltype=="0")
		document.forms[0].sel_audittype.selectedIndex=0;
	else
		document.forms[0].sel_audittype.selectedIndex=seltype;
}

function placevalues()
{
	show_details();
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="textarea")
		{
		  document.forms[0].elements[i].readOnly=true;
		}
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].disabled=false;
		}
	}
	if((document.forms[0].sel_audittype.value=="0")||(document.forms[0].sel_audittype.value==""))
	{
		document.forms[0].sel_audittype.selectedIndex=0;
		document.forms[0].txt_auditorsobservations.value="";
		document.forms[0].txt_branchcomments.value="";
	}
	else
	{
		document.forms[0].sel_audittype.value=seltype;
	}
}

function doCancel()
{
	if (ConfirmMsg(102))
	{
		document.forms[0].hidBeanGetMethod.value="getAuditorObservationData";
		document.forms[0].hidBeanId.value="reviewtermloan";
		document.forms[0].action=appURL+"action/tlr_auditobservation.jsp";
		document.forms[0].submit();
	}
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/mon_borrowersearch.jsp?hidmontype=MONITREVIEW";
		document.forms[0].submit();
	}
}

function doEdit()
{
	if((document.forms[0].sel_audittype.selectedIndex == 0) ||(document.forms[0].sel_audittype.value== ""))
	{
		alert("Select the Audit type");
		document.forms[0].txt_auditorsobservations.value="";
		document.forms[0].txt_branchcomments.value="";
		document.forms[0].sel_audittype.focus();
		return;
	}
	else
	{
		document.forms[0].sel_audittype.disabled=false;
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=false;
			}
			if(document.forms[0].elements[i].type=='radio')
			{
				document.forms[0].elements[i].disabled = true;
			}
		}
	}
	document.forms[0].hidAction.value="update";
	document.forms[0].hideditflag.value="Y";
	enableButtons(true,true,false,false,true,true);
}

function doNew()
{
	if((document.forms[0].sel_audittype.selectedIndex == 0) ||(document.forms[0].sel_audittype.value== ""))
	{
		alert("Select the Audit type");
		document.forms[0].sel_audittype.focus();
		return;
	}
	else
	{
		document.forms[0].hidAction.value="insert";
		document.forms[0].txt_auditorsobservations.value="";
		document.forms[0].txt_branchcomments.value="";
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=false;
			}
			if(document.forms[0].elements[i].type=='radio')
			{
				document.forms[0].elements[i].disabled=true;
			}
		}
		enableButtons(true,true,false,false,true,true);
		document.forms[0].hideditflag.value="Y";
	}
}

function doSave()
{	
	if(document.forms[0].auditdate.value=="")
	{
		ShowAlert('121','Audit Date');
		document.forms[0].auditdate.focus();
		return;
	}
	if(document.forms[0].txt_auditorsobservations.value=="")
	{
		ShowAlert('121','Auditors Observations');
		document.forms[0].txt_auditorsobservations.focus();
		return;
	}
	document.forms[0].hidBeanId.value="reviewtermloan";
	document.forms[0].hidBeanMethod.value="updateAuditorObservationData";
	document.forms[0].hidBeanGetMethod.value="getAuditorObservationData";
	document.forms[0].hidSourceUrl.value="/action/tlr_auditobservation.jsp"
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doDelete()
{	
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanId.value="reviewtermloan";
		document.forms[0].hidBeanMethod.value="updateAuditorObservationData";
		document.forms[0].hidBeanGetMethod.value="getAuditorObservationData";
		document.forms[0].hidSourceUrl.value="/action/tlr_auditobservation.jsp"
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}
function selectvalues(val1, val2)
{
	document.forms[0].hidsno.value=val1;
	document.forms[0].txt_auditorsobservations.value=document.getElementById("hidauditcomments"+val2).value;
	document.forms[0].txt_branchcomments.value=document.getElementById("hidbranchreplies"+val2).value;
	
	if(document.forms[0].btnenable.value=="Y")
	{
		enableButtons(true,false,true,false,false,true);
	}
	else
	{
		enableButtons(true,true,true,true,true,true);
	}
}
</script>
</head>
<body onload="placevalues()">
<form name="frmpri" method ="post" class="normal"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
			<lapschoice:tlrtag pageid="9" reviewof='<%=Helper.correctNull((String)request.getParameter("reviewOf"))%>' valuesin='<%=Helper.correctNull((String)request.getParameter("valuesin"))%>'/>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top" colspan="5" class="page_flow">Home -&gt; Term Loan - Review -&gt; Audit Observations</td>
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
   <table width="95%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable">
      <tr> 
        <td width="3%" nowrap>Type</td>
        <td width="38%" nowrap> 
          <select name="sel_audittype" tabindex="3"
									onChange="calGetData()">
            <option value="0" selected>----Select----</option>
            <option value="1">Internal Audit</option>
            <option value="2">Concurrent Audit</option>
            <option value="3">RBI Inspection</option>
            <option value="4">Statutory Audit</option>
            <option value="5">Stock Audit</option>
          </select>
        </td>
        <td width="12%" nowrap>&nbsp;</td>
        <td width="7%" nowrap>Date of Audit<span class="mantatory">*</span></td>
        <td width="40%" nowrap> 
          <input type="text" name="auditdate" size="12" tabindex="2"
									maxlength="10"
									value="<%=Helper.correctNull((String)hshValues.get("auditdate"))%>"
									onBlur="checkDate(this);" readOnly>
          <a
									alt="Select date from calender"
									href="javascript:callCalender('auditdate')"><img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
									width="21" height="18" border="0"></a></td>
      </tr>
      <tr class="dataheader"> 
        <td colspan="2" nowrap>Auditors Comments</td>
        <td width="12%" nowrap>&nbsp;</td>
        <td colspan="2" nowrap>Officers Comments</td>
      </tr>
      <tr> 
        <td colspan="2" nowrap> 
          <textarea name="txt_auditorsobservations" cols="75" rows="10" wrap="VIRTUAL"
				onKeyPress="textlimit(document.forms[0].txt_auditorsobservations,3999)" onKeyUp="textlimit(this,3999)"></textarea>
        </td>
        <td width="12%" nowrap>&nbsp;</td>
        <td colspan="2" nowrap> 
          <textarea name="txt_branchcomments" cols="75" rows="10" wrap="VIRTUAL"
				onKeyPress="textlimit(document.forms[0].txt_branchcomments,3999)" onKeyUp="textlimit(this,3999)"></textarea>
        </td>
      </tr>
      <tr> 
       <lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
      </tr>
    </table>
<br>

  <table width="95%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable linebor">
    <tr class="dataheader">
	<td width="2%" >&nbsp;</td>
	<td width="49%" >Auditors Comments</td>
	<td width="49%" >Officers Comments</td>
</tr>
<%
	ArrayList arrRow=new ArrayList();
	arrRow=(ArrayList)hshValues.get("arrRow");
	if(arrRow!=null && arrRow.size()>0)
	{
		for(int i=0;i<arrRow.size();i++)
		{
			ArrayList arrCol=new ArrayList();
			arrCol=(ArrayList)arrRow.get(i);
%>	
<tr class="datagrid">
	<td>
		<input type="radio" style="border:none" name="radiobutton" value="radiobutton"
		onclick="selectvalues('<%=Helper.correctNull((String)arrCol.get(2))%>',<%=i%>)">
		<input type="hidden" name="hidauditcomments<%=i%>" value="<%=Helper.correctNull((String)arrCol.get(0))%>">
		<input type="hidden" name="hidbranchreplies<%=i%>" value="<%=Helper.correctNull((String)arrCol.get(1))%>">
		
	</td>
	<td width="49%"><%=Helper.correctNull((String)arrCol.get(0))%></td>
	<td width="49%"><%=Helper.correctNull((String)arrCol.get(1))%></td>
</tr>	
<%
		}
	}else{
%>
<tr class="datagrid">
  <td colspan="3" align="center">No Data</td>
</tr>
<%} %>	
</table>
<input type="hidden" name="hidsno" value="">
<input type="hidden" name="reviewOf" value="<%=request.getParameter("reviewOf")%>">
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>

