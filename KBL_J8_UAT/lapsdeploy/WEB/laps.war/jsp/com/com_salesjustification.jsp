<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<%
ArrayList arrSalesAct=new ArrayList();
ArrayList arrSalesProj=new ArrayList();
ArrayList arrYear=new ArrayList();
ArrayList arrGrowth=new ArrayList();
ArrayList arrAchievement=new ArrayList();

arrSalesAct=(ArrayList)hshValues.get("arrSalesAct");
arrSalesProj=(ArrayList)hshValues.get("arrSalesProj");
arrYear=(ArrayList)hshValues.get("arrYear");
arrGrowth=(ArrayList)hshValues.get("arrGrowth");
arrAchievement=(ArrayList)hshValues.get("arrAchievement");
int intSize=0;

if(arrYear!=null)
	intSize=arrYear.size();
%>
<html>
<head>
<title>Sales Justification</title>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String) request.getParameter("appstatus"))%>";
var selcomments="<%=Helper.correctNull((String) hshValues.get("selcoment"))%>";
var appno="<%=request.getParameter("appno")%>";

function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].method="post";
        document.forms[0].hidBeanId.value="";
	    document.forms[0].action=appURL+"action/"+"corppge.jsp";	
		document.forms[0].submit();
	}
}
function doDelete()
{
	document.forms[0].hidAction.value ="delete";
	document.forms[0].hidBeanId.value="compro";
    document.forms[0].hidBeanMethod.value="updateFinancialComments";
	document.forms[0].hidBeanGetMethod.value="getFinancialComments";
	document.forms[0].hidSourceUrl.value="action/com_salesjustification.jsp";	
	document.forms[0].action=appURL+"action/controllerservlet";	
	document.forms[0].submit();
}
function doSave()
{ 	
	if(document.forms[0].sel_commentstype.value =="s")
	{
		alert("Please Select comment on");
		document.forms[0].sel_commentstype.focus();
		document.forms[0].txt_comments.value="";
		EditorEnableDisable("id_div","block","id_editor","none");
		return;
	}
	else if(document.forms[0].sel_commentstype.value =="2")
	{
		for(var i=0;i<3;i++)
		{
			if((document.forms[0].txt_estimated[i].value!="" && document.forms[0].txt_estimated[i].value!="0.00")||(document.forms[0].txt_accepted[i].value!="" && document.forms[0].txt_accepted[i].value!="0.00"))
			{
				if(document.forms[0].txt_yearfrom.value=="")
				{
					alert("Enter Current Financial Details");
					document.forms[0].txt_yearfrom.focus();
					return;
				}
				else if(document.forms[0].txt_yearto.value=="")
				{
					alert("Enter Current Financial Details");
					document.forms[0].txt_yearto.focus();
					return;
				}
			}
		}
		for(var i=0;i<3;i++)
		{
			if((document.forms[0].txt_nestimated[i].value!="" && document.forms[0].txt_nestimated[i].value!="0.00")||(document.forms[0].txt_naccepted[i].value!="" && document.forms[0].txt_naccepted[i].value!="0.00"))
			{
				if(document.forms[0].txt_nyearfrom.value=="")
				{
					alert("Enter Current Financial Details");
					document.forms[0].txt_nyearfrom.focus();
					return;
				}
				else if(document.forms[0].txt_nyearto.value=="")
				{
					alert("Enter Current Financial Details");
					document.forms[0].txt_nyearto.focus();
					return;
				}
			}
		}
		for(var i=0;i<3;i++)
		{
			if((document.forms[0].txt_IINestimated[i].value!="" && document.forms[0].txt_IINestimated[i].value!="0.00")||(document.forms[0].txt_IINaccepted[i].value!="" && document.forms[0].txt_IINaccepted[i].value!="0.00"))
			{
				if(document.forms[0].txt_IINyearfrom.value=="")
				{
					alert("Enter Current Financial Details");
					document.forms[0].txt_IINyearfrom.focus();
					return;
				}
				else if(document.forms[0].txt_IINyearto.value=="")
				{
					alert("Enter Current Financial Details");
					document.forms[0].txt_IINyearto.focus();
					return;
				}
			}
		}
	}

	if(document.forms[0].sel_commentstype.value=="1")
	{
		document.forms[0].hidRowSize.value="<%=intSize%>";
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hidBeanId.value="compro";
	document.forms[0].hidBeanMethod.value="updateFinancialComments";
	document.forms[0].hidBeanGetMethod.value="getFinancialComments";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/com_salesjustification.jsp";
	document.forms[0].submit();
}
function disableCommandButtons(val)
{
	if(val=="load")
	{
		if(appstatus=="Processed/Rejected" || appstatus=="Processed/Approved" || appstatus=="Closed/Approved" || appstatus=="Closed/Rejected")	 
	  	{
			if(document.forms[0].btnenable.value =='N')
		  	{
				document.forms[0].cmdnew.disabled=true;
			  	document.forms[0].cmdedit.disabled=true;
			  	document.forms[0].cmddelete.disabled=true;
			  	document.forms[0].cmdsave.disabled=true;
			  	document.forms[0].cmdcancel.disabled=true;
			  	document.forms[0].cmdclose.disabled=false;
		 	}
	  	}
	 	else
	 	{
	 		document.forms[0].cmdedit.disabled=false;
	 	  	document.forms[0].cmddelete.disabled=true;
		  	document.forms[0].cmdsave.disabled=true;
		  	document.forms[0].cmdcancel.disabled=true;
		  	document.forms[0].cmdclose.disabled=false;
	 	}
	}
	if(val=="edit")
	{
		if(document.forms[0].btnenable.value =='N')
	  	{
			document.forms[0].cmdnew.disabled=true;
		  	document.forms[0].cmdedit.disabled=true;
		  	document.forms[0].cmddelete.disabled=true;
		  	document.forms[0].cmdsave.disabled=true;
		  	document.forms[0].cmdcancel.disabled=true;
		  	document.forms[0].cmdclose.disabled=false;
	 	}
	 	else
	 	{
			document.forms[0].cmdedit.disabled=true;
			document.forms[0].cmddelete.disabled=false;
			document.forms[0].cmdsave.disabled=false;
			document.forms[0].cmdcancel.disabled=false;
			if(document.forms[0].appno.value != "new")
			{
				document.forms[0].cmdclose.disabled=true;
			}
			else
			{
				document.forms[0].cmdclose.disabled=false;
				document.forms[0].cmddelete.disabled=true;
				document.forms[0].cmdcancel.disabled=true;
			}
		}
		disableFields(false);
	}
}
function onLoading()
{
	if(selcomments=="")
	{
		document.forms[0].sel_commentstype.value="s";
	}
	else
	{
		document.forms[0].sel_commentstype.value=selcomments;
	}				
	 disableFields(true);
	 EditorEnableDisable("id_div","block","id_editor","none");

	 document.all.idRow1.style.display="none";
	 document.all.idRow2.style.display="none";
	 document.all.idRow3.style.display="none";
	 document.all.idRow4.style.display="none";
	 document.all.idRow5.style.display="none";
	 document.all.idRow6.style.display="none";
	 document.all.idRow7.style.display="none";
	 
	 if(selcomments=="2")
	 {
		 document.all.idRow1.style.display="table-row";
		 document.all.idRow2.style.display="table-row";
		 document.all.idRow3.style.display="table-row";
		 document.all.idRow4.style.display="table-row";
		 document.all.idRow5.style.display="table-row";
		 document.all.idRow6.style.display="table-row";
		 document.all.idRow7.style.display="table-row";
	 }
}
function doEdit()
{

	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");
	EditorEnableDisable("id_div","none","id_editor","block");
	editor_generate('txt_comments');

	<%if(arrYear!=null && arrYear.size()>0){
	for(int i=0;i<arrYear.size();i++){
	if(arrYear.size()>1){%>
	document.forms[0].txt_year[<%=i%>].readOnly=true;
	document.forms[0].txt_actual[<%=i%>].readOnly=true;
	<%}else{%>
	document.forms[0].txt_year.readOnly=true;
	document.forms[0].txt_actual.readOnly=true;
	<%}%>

	<%}
	}%>
}
function disableFields(val)
{
	  for(var i=0;i<document.forms[0].length;i++)
	  {
		  if(document.forms[0].elements[i].type=='textarea'  )
		  {
			document.forms[0].elements[i].readOnly=val;
		  }
		  if(document.forms[0].elements[i].type=='text'  )
		  {
			document.forms[0].elements[i].readOnly=val;
		  }
	  }
}
function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="compro";
		document.forms[0].hidBeanMethod.value="updateFinancialComments";
		document.forms[0].hidBeanGetMethod.value="getFinancialComments";
		document.forms[0].action=appURL+"action/com_salesjustification.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}

function getCollData()
{
	document.forms[0].hidBeanId.value="compro";
	document.forms[0].hidBeanGetMethod.value="getFinancialComments";
	document.forms[0].action=appURL+"action/com_salesjustification.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
	onLoading();
}
function doComments()
{
	var strAppno =appno;
	var pagetype = document.forms[0].hidCommentPage.value;
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/com_comments.jsp?hidBeanId=comproposal&hidBeanGetMethod=getDataComments&pagetype="+pagetype+"&strAppno="+strAppno;
	window.open(url,"Comments",prop);
}
function chkYearVal(obj,val)
{
	if(val=="txt_nyearfrom" || val=="txt_nyearto")
	{
		if(eval(document.forms[0].txt_nyearfrom.value)>eval(document.forms[0].txt_nyearto.value))
		{
			alert("From Year cannot be lesser than To Year");
			obj.value="";
			obj.focus();
			return;
		}
	}
	if(val=="txt_yearfrom" || val=="txt_yearto")
	{
		if(eval(document.forms[0].txt_yearfrom.value)>eval(document.forms[0].txt_yearto.value))
		{
			alert("From Year cannot be lesser than To Year");
			obj.value="";
			obj.focus();
			return;
		}
	}
	if(val=="txt_IINyearfrom" || val=="txt_IINyearto")
	{
		if(eval(document.forms[0].txt_IINyearfrom.value)>eval(document.forms[0].txt_IINyearto.value))
		{
			alert("From Year cannot be lesser than To Year");
			obj.value="";
			obj.focus();
			return;
		}
	}
}
function calTotal(val)
{
	if(val=="Current")
	{
		if(document.forms[0].txt_estimated[0].value=="")
			document.forms[0].txt_estimated[0].value="0.00";
		if(document.forms[0].txt_estimated[1].value=="")
			document.forms[0].txt_estimated[1].value="0.00";
		if(document.forms[0].txt_accepted[0].value=="")
			document.forms[0].txt_accepted[0].value="0.00";
		if(document.forms[0].txt_accepted[1].value=="")
			document.forms[0].txt_accepted[1].value="0.00";

		if(eval(document.forms[0].txt_estimated[0].value)<eval(document.forms[0].txt_accepted[0].value))
		{
			alert("Accepted should not be greater than estimated");
			document.forms[0].txt_accepted[0].value="";
			document.forms[0].txt_accepted[0].focus();
			return;
		}

		if(eval(document.forms[0].txt_estimated[1].value)<eval(document.forms[0].txt_accepted[1].value))
		{
			alert("Accepted should not be greater than estimated");
			document.forms[0].txt_accepted[1].value="";
			document.forms[0].txt_accepted[1].focus();
			return;
		}

		document.forms[0].txt_estimated[2].value=eval(document.forms[0].txt_estimated[0].value)+eval(document.forms[0].txt_estimated[1].value);
		document.forms[0].txt_accepted[2].value=eval(document.forms[0].txt_accepted[0].value)+eval(document.forms[0].txt_accepted[1].value);

		document.forms[0].txt_estimated[2].value=roundVal(document.forms[0].txt_estimated[2].value);
		document.forms[0].txt_accepted[2].value=roundVal(document.forms[0].txt_accepted[2].value);	

		
	}
	else if(val=="preYear")
	{
		if(document.forms[0].txt_IINestimated[0].value=="")
			document.forms[0].txt_IINestimated[0].value="0.00";
		if(document.forms[0].txt_IINestimated[1].value=="")
			document.forms[0].txt_IINestimated[1].value="0.00";
		if(document.forms[0].txt_IINaccepted[0].value=="")
			document.forms[0].txt_IINaccepted[0].value="0.00";
		if(document.forms[0].txt_IINaccepted[1].value=="")
			document.forms[0].txt_IINaccepted[1].value="0.00";

		if(eval(document.forms[0].txt_IINestimated[0].value)<eval(document.forms[0].txt_IINaccepted[0].value))
		{
			alert("Accepted should not be greater than estimated");
			document.forms[0].txt_IINaccepted[0].value="";
			document.forms[0].txt_IINaccepted[0].focus();
			return;
		}

		if(eval(document.forms[0].txt_IINestimated[1].value)<eval(document.forms[0].txt_IINaccepted[1].value))
		{
			alert("Accepted should not be greater than estimated");
			document.forms[0].txt_IINaccepted[1].value="";
			document.forms[0].txt_IINaccepted[1].focus();
			return;
		}

		document.forms[0].txt_IINestimated[2].value=eval(document.forms[0].txt_IINestimated[0].value)+eval(document.forms[0].txt_IINestimated[1].value);
		document.forms[0].txt_IINaccepted[2].value=eval(document.forms[0].txt_IINaccepted[0].value)+eval(document.forms[0].txt_IINaccepted[1].value);

		document.forms[0].txt_IINestimated[2].value=roundVal(document.forms[0].txt_IINestimated[2].value);
		document.forms[0].txt_IINaccepted[2].value=roundVal(document.forms[0].txt_IINaccepted[2].value);
		
	}
	else
	{
		if(document.forms[0].txt_nestimated[0].value=="")
			document.forms[0].txt_nestimated[0].value="0.00";
		if(document.forms[0].txt_nestimated[1].value=="")
			document.forms[0].txt_nestimated[1].value="0.00";
		if(document.forms[0].txt_naccepted[0].value=="")
			document.forms[0].txt_naccepted[0].value="0.00";
		if(document.forms[0].txt_naccepted[1].value=="")
			document.forms[0].txt_naccepted[1].value="0.00";

		if(eval(document.forms[0].txt_nestimated[0].value)<eval(document.forms[0].txt_naccepted[0].value))
		{
			alert("Accepted should not be greater than estimated");
			document.forms[0].txt_naccepted[0].value="";
			document.forms[0].txt_naccepted[0].focus();
			return;
		}

		if(eval(document.forms[0].txt_nestimated[1].value)<eval(document.forms[0].txt_naccepted[1].value))
		{
			alert("Accepted should not be greater than estimated");
			document.forms[0].txt_naccepted[1].value="";
			document.forms[0].txt_naccepted[1].focus();
			return;
		}

		document.forms[0].txt_nestimated[2].value=eval(document.forms[0].txt_nestimated[0].value)+eval(document.forms[0].txt_nestimated[1].value);
		document.forms[0].txt_naccepted[2].value=eval(document.forms[0].txt_naccepted[0].value)+eval(document.forms[0].txt_naccepted[1].value);

		document.forms[0].txt_nestimated[2].value=roundVal(document.forms[0].txt_nestimated[2].value);
		document.forms[0].txt_naccepted[2].value=roundVal(document.forms[0].txt_naccepted[2].value);

	}
	
}
</script>
</head>
<body onload="onLoading()">
<form method = post class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr>
	<td valign="top"><jsp:include page="../com/proposallinks.jsp"	flush="true">
		<jsp:param name="pageid" value="41" />
		<jsp:param name="cattype" value="<%=strCategoryType%>" />
		<jsp:param name="ssitype" value="<%=strSSIType%>" />
	</jsp:include></td>
</tr>          
<tr>
  	<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Proposal -&gt; Assessment -&gt; Assessment Comments</td>
</tr>         
</table>
<span style="display:none;"><lapschoice:borrowertype /></span><lapschoice:application />

<jsp:include page="../com/com_commentstab.jsp" flush="true">
<jsp:param name="tabid" value="33" />
</jsp:include>	

<table width="98%" align="center" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
<tr>
	<td><br>
	    <table width="90%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
		<tr> 
		    <td width="20%" nowrap="nowrap"><b>Comments On <span class="mantatory">*</span></b>&nbsp;
			    <select name="sel_commentstype" tabindex="1" onchange="getCollData()">
					<option value="s" selected>----select----</option>
					<option value="1">Estimates and actual for last three years</option>
					<option value="2">Estimates of sales for the current year & for the next year</option>
					<option value="3">Justification for sales</option>
				</select>
		    </td>
		</tr> 
			<tr><td>&nbsp;</td></tr>
			<%if(arrYear!=null && arrYear.size()>0){ %>
			<tr><td>Estimates and actual for the last 3 years</td></tr>
			 <tr class="dataheader"><td align="right"><b>All Values are in <%=Helper.correctNull((String)hshValues.get("strValuesin")) %></b></td></tr>
			<tr>
			<td>
			<table width="100%"  border="0"   cellpadding="4"  class="outertable" align="center"  style="border: 1px solid #bbb;">
			<tr class="dataheader"  align="center">
			<td width="25%" rowspan="2">As on/for the year end</td>
			<%for(int i=0;i<arrYear.size();i++){%>
			<td width="25%" colspan="2"><input type="text" name="txt_year" value="<%=Helper.correctNull((String)arrYear.get(i)) %>"></td>
			<%} %>
			</tr>
			<tr class="dataheader"  align="center">
			<%for(int i=0;i<arrYear.size();i++){%>
			<td width="15%">Proj</td>
			<td width="15%">Actual</td>
			<%} %>
			</tr>
			<tr class="datagrid">
			<%for(int i=0;i<arrSalesProj.size();i++){
			if(i==0){%>
			<td width="25%">Sales</td>
			<%} %>
			<td width="25%"  align="center"><input type="text" name="txt_proj" value="<%=Helper.correctNull((String)arrSalesProj.get(i)) %>" style="text-align: right;" onblur="roundtxt(this);" size="15" onkeypress="allowNumber(this)" maxlength="12"></td>
			<td width="25%" align="center"><input type="text" name="txt_actual" value="<%=Helper.correctNull((String)arrSalesAct.get(i)) %>" style="text-align: right;" onblur="roundtxt(this);" size="15" onkeypress="allowNumber(this)" maxlength="12"></td>
			<%} %>
			</tr>
			<tr class="datagrid">
			<%for(int i=0;i<arrAchievement.size();i++){
			if(i==0){%>
			<td width="25%">Achievement</td>
			<%} %>
			<td width="25%" colspan="2" align="center"><input type="text" name="txt_achievement" value="<%=Helper.correctNull((String)arrAchievement.get(i)) %>" style="text-align: right;" onblur="roundtxt(this);" size="15" onkeypress="allowNegativeNumber(this)" maxlength="12"></td>
			<%} %>
			</tr>
			<tr class="datagrid">
			<%for(int i=0;i<arrGrowth.size();i++){
			if(i==0){%>
			<td width="25%">Growth</td>
			<%} %>
			<td width="25%" colspan="2" align="center"><input type="text" name="txt_growth" value="<%=Helper.correctNull((String)arrGrowth.get(i)) %>" style="text-align: right;" onblur="roundtxt(this);" size="15" onkeypress="allowNegativeNumber(this)" maxlength="12"></td>
			<%} %>
			</tr>
			</table>
			</td>
			</tr>
			
			<%} %>
		<tr class="dataheader" id="idRow1">
		<td>Estimates of sales for the current year</td>
		</tr>
		 <tr class="dataheader"  id="idRow5"><td align="right"><b>All Values are in <%=Helper.correctNull((String)hshValues.get("strValuesin")) %></b></td></tr>
		<tr id="idRow2">
  <td>
  <table width="100%"  border="0"   cellpadding="4"  class="outertable" align="center"  style="border: 1px solid #bbb;">
							  <tr class="dataheader">
									<td width="20%" align="center"  rowspan="2"> Particulars</td>
									<td  width="25%" align="center" colspan="2"> Year <input type="text" name="txt_yearfrom" value="<%=Helper.correctNull((String)hshValues.get("strCYearFrom")) %>" size="6" onkeypress="allowWholeNumber(this)" maxlength="4" onblur="checkcurrentyear(this);chkYearVal(this,'txt_yearfrom');"> -
									<input type="text" name="txt_yearto" value="<%=Helper.correctNull((String)hshValues.get("strCYearTo")) %>" size="6" onkeypress="allowWholeNumber(this)" maxlength="4" onblur="checkcurrentyear(this);chkYearVal(this,'txt_yearto');"> </td>
							</tr>
							<tr class="dataheader" align="center">
							<td width="10%">Estimates</td>
							<td width="10%">Accepted</td>
							</tr>
							<tr class="datagrid">
							<td><input type="hidden" name="txt_desc" value="CEXPORT">Export </td>
							<td align="center"><input type="text" name="txt_estimated"  style="text-align: right;" value="<%=Helper.correctNull((String)hshValues.get("strEstimatedCEXPORT")) %>"  onblur="roundtxt(this);calTotal('Current');" size="15" onkeypress="allowNumber(this)" maxlength="12"></td>
							<td align="center"><input type="text" name="txt_accepted"  style="text-align: right;" value="<%=Helper.correctNull((String)hshValues.get("strAcceptedCEXPORT")) %>"  onblur="roundtxt(this);calTotal('Current');" size="15" onkeypress="allowNumber(this)" maxlength="12"></td>
							</tr>
							<tr class="datagrid">
							<td><input type="hidden" name="txt_desc" value="CDOMESTIC">Domestic</td>
							<td align="center"><input type="text" name="txt_estimated"  style="text-align: right;" value="<%=Helper.correctNull((String)hshValues.get("strEstimatedCDOMESTIC")) %>" onblur="roundtxt(this);calTotal('Current');" size="15" onkeypress="allowNumber(this)" maxlength="12"></td>
							<td align="center"><input type="text" name="txt_accepted"  style="text-align: right;" value="<%=Helper.correctNull((String)hshValues.get("strAcceptedCDOMESTIC")) %>"  onblur="roundtxt(this);calTotal('Current');" size="15" onkeypress="allowNumber(this)" maxlength="12"></td>
							</tr>
							<tr class="datagrid">
							<td><input type="hidden" name="txt_desc" value="CSALES">Total Sales</td>
							<td align="center"><input type="text" name="txt_estimated"  style="text-align: right;" value="<%=Helper.correctNull((String)hshValues.get("strEstimatedCSALES")) %>" onblur="roundtxt(this);" size="15" onkeypress="allowNumber(this)" maxlength="12"></td>
							<td align="center"><input type="text" name="txt_accepted"  style="text-align: right;" value="<%=Helper.correctNull((String)hshValues.get("strAcceptedCSALES")) %>" onblur="roundtxt(this);" size="15" onkeypress="allowNumber(this)" maxlength="12"></td>
							</tr>
							
							</table>
  </td>
  </tr> 
  <tr class="dataheader" id="idRow3">
		<td>Estimates of sales for the Next year-I</td>
		</tr>
		<tr id="idRow4">
  <td>
  <table width="100%"  border="0"   cellpadding="4"  class="outertable" align="center"  style="border: 1px solid #bbb;">
							  <tr class="dataheader">
									<td width="20%" align="center"  rowspan="2"> Particulars</td>
									<td  width="25%" align="center" colspan="2"> Year <input type="text" name="txt_nyearfrom" value="<%=Helper.correctNull((String)hshValues.get("strNYearFrom")) %>" size="6" onkeypress="allowWholeNumber(this)" maxlength="4" onblur="checkcurrentyear(this,'N');chkYearVal(this,'txt_nyearfrom');"> -
									<input type="text" name="txt_nyearto" value="<%=Helper.correctNull((String)hshValues.get("strNYearTo")) %>" size="6" onkeypress="allowWholeNumber(this)" maxlength="4" onblur="checkcurrentyear(this,'N');chkYearVal(this,'txt_nyearto');"> </td>
							</tr>
							<tr class="dataheader" align="center">
							<td width="10%">Estimates</td>
							<td width="10%">Accepted</td>
							</tr>
							<tr class="datagrid">
							<td><input type="hidden" name="txt_ndesc" value="NEXPORT">Export </td>
							<td align="center"><input type="text" name="txt_nestimated"  style="text-align: right;" value="<%=Helper.correctNull((String)hshValues.get("strEstimatedNEXPORT")) %>"  onblur="roundtxt(this);calTotal();" size="15" onkeypress="allowNumber(this)" maxlength="12"></td>
							<td align="center"><input type="text" name="txt_naccepted"  style="text-align: right;" value="<%=Helper.correctNull((String)hshValues.get("strAcceptedNEXPORT")) %>"  onblur="roundtxt(this);calTotal();" size="15" onkeypress="allowNumber(this)" maxlength="12"></td>
							</tr>
							<tr class="datagrid">
							<td><input type="hidden" name="txt_ndesc" value="NDOMESTIC">Domestic</td>
							<td align="center"><input type="text" name="txt_nestimated"  style="text-align: right;" value="<%=Helper.correctNull((String)hshValues.get("strEstimatedNDOMESTIC")) %>" onblur="roundtxt(this);calTotal();" size="15" onkeypress="allowNumber(this)" maxlength="12"></td>
							<td align="center"><input type="text" name="txt_naccepted"  style="text-align: right;" value="<%=Helper.correctNull((String)hshValues.get("strAcceptedNDOMESTIC")) %>"  onblur="roundtxt(this);calTotal();" size="15" onkeypress="allowNumber(this)" maxlength="12"></td>
							</tr>
							<tr class="datagrid">
							<td><input type="hidden" name="txt_ndesc" value="NSALES">Total Sales</td>
							<td align="center"><input type="text" name="txt_nestimated"  style="text-align: right;" value="<%=Helper.correctNull((String)hshValues.get("strEstimatedNSALES")) %>" onblur="roundtxt(this);" size="15" onkeypress="allowNumber(this)" maxlength="12"></td>
							<td align="center"><input type="text" name="txt_naccepted"  style="text-align: right;" value="<%=Helper.correctNull((String)hshValues.get("strAcceptedNSALES")) %>" onblur="roundtxt(this);" size="15" onkeypress="allowNumber(this)" maxlength="12"></td>
							</tr>
							
							</table>
  </td>
  </tr> 
  <tr class="dataheader" id="idRow6">
		<td>Estimates of sales for the Next year-II</td>
		</tr>
		<tr id="idRow7">
  <td>
  <table width="100%"  border="0"   cellpadding="4"  class="outertable" align="center"  style="border: 1px solid #bbb;">
							  <tr class="dataheader">
									<td width="20%" align="center"  rowspan="2"> Particulars</td>
									<td  width="25%" align="center" colspan="2"> Year <input type="text" name="txt_IINyearfrom" value="<%=Helper.correctNull((String)hshValues.get("strIINYearFrom")) %>" size="6" onkeypress="allowWholeNumber(this)" maxlength="4" onblur="checkcurrentyear(this,'N');chkYearVal(this,'txt_IINyearfrom');"> -
									<input type="text" name="txt_IINyearto" value="<%=Helper.correctNull((String)hshValues.get("strIINYearTo")) %>" size="6" onkeypress="allowWholeNumber(this)" maxlength="4" onblur="checkcurrentyear(this,'N');chkYearVal(this,'txt_IINyearto');"> </td>
							</tr>
							<tr class="dataheader" align="center">
							<td width="10%">Estimates</td>
							<td width="10%">Accepted</td>
							</tr>
							<tr class="datagrid">
							<td><input type="hidden" name="txt_IINdesc" value="IINEXPORT">Export </td>
							<td align="center"><input type="text" name="txt_IINestimated"  style="text-align: right;" value="<%=Helper.correctNull((String)hshValues.get("strEstimatedIINEXPORT")) %>"  onblur="roundtxt(this);calTotal('preYear');" size="15" onkeypress="allowNumber(this)" maxlength="12"></td>
							<td align="center"><input type="text" name="txt_IINaccepted"  style="text-align: right;" value="<%=Helper.correctNull((String)hshValues.get("strAcceptedIINEXPORT")) %>"  onblur="roundtxt(this);calTotal('preYear');" size="15" onkeypress="allowNumber(this)" maxlength="12"></td>
							</tr>
							<tr class="datagrid">
							<td><input type="hidden" name="txt_IINdesc" value="IINDOMESTIC">Domestic</td>
							<td align="center"><input type="text" name="txt_IINestimated"  style="text-align: right;" value="<%=Helper.correctNull((String)hshValues.get("strEstimatedIINDOMESTIC")) %>" onblur="roundtxt(this);calTotal('preYear');" size="15" onkeypress="allowNumber(this)" maxlength="12"></td>
							<td align="center"><input type="text" name="txt_IINaccepted"  style="text-align: right;" value="<%=Helper.correctNull((String)hshValues.get("strAcceptedIINDOMESTIC")) %>"  onblur="roundtxt(this);calTotal('preYear');" size="15" onkeypress="allowNumber(this)" maxlength="12"></td>
							</tr>
							<tr class="datagrid">
							<td><input type="hidden" name="txt_IINdesc" value="IINSALES">Total Sales</td>
							<td align="center"><input type="text" name="txt_IINestimated"  style="text-align: right;" value="<%=Helper.correctNull((String)hshValues.get("strEstimatedIINSALES")) %>" onblur="roundtxt(this);" size="15" onkeypress="allowNumber(this)" maxlength="12"></td>
							<td align="center"><input type="text" name="txt_IINaccepted"  style="text-align: right;" value="<%=Helper.correctNull((String)hshValues.get("strAcceptedIINSALES")) %>" onblur="roundtxt(this);" size="15" onkeypress="allowNumber(this)" maxlength="12"></td>
							</tr>
							
							</table>
  </td>
  </tr> 
	  	<tr><td>&nbsp;</td> </tr>  
	  	<tr class="dataheader"> 
	    	<td width="20%">&nbsp;Comments</td>
	    </tr>
	   	<tr class="datagrid"> 
	    	<td width="60%"> 
	      		<div id="id_div"><div class="EditorClassNew"> <%=Helper.correctNull((String)hshValues.get("comments")) %></div></div>
				<div id="id_editor">
	      		<textarea name="txt_comments" cols="100"  rows="8" tabindex="2" wrap="VIRTUAL" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("comments"))%></textarea></div>
	 		</td>
	 	</tr>
	 	</table>
	  <br>
	 </td>
 </tr>
</table>
<br> 
<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' btnnames='Edit_Save_Cancel_Delete_Audit Trail'/>
<input type="hidden" name="hidPage" value="salesjustify">
<input type="hidden" name="hidBeanId" value="">
 <input type="hidden" name="hidBeanMethod" value=""> 
 <input type="hidden" name="hidBeanGetMethod" value="">
<input type="hidden" name="hidAction" value="">
<input type="hidden" name="hidSourceUrl" value=""> 
<input type="hidden" name="hidCommentPage" value="">
<INPUT TYPE="hidden" name="strAssessment" value = "<%=request.getParameter("strAssessment")%>">
<input type="hidden" name="hidRowSize">
<br>
</form>
</body>
</html>