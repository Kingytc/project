<%@include file="../share/directives.jsp"%>
<%String strSessionModule="";
 strSessionModule=Helper.correctNull((String)session.getAttribute("sessionModuleType"));
 String strAppno = Helper.correctNull((String)request.getParameter("appno"));
 if(strAppno.equalsIgnoreCase(""))
 {
	 strAppno = Helper.correctNull((String)hshValues.get("appno"));
 }
 String strProposedLoanAmt = Helper.correctDouble((String)hshValues.get("proposedamt"));
 String strFacSno = Helper.correctDouble((String)hshValues.get("strFacSno"));

ArrayList arrCol = new ArrayList();
ArrayList arrRow = new ArrayList();

arrRow = (ArrayList)hshValues.get("arrRow");

String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
%>
<html>
<head>
<title>SHG Members loan share</title>

<script>
var appstatus="<%=Helper.correctNull((String) request.getParameter("appstatus"))%>";
var btnenable="<%=Helper.correctNull((String) request.getParameter("btnenable"))%>";
var varProposedAmt = "<%=strProposedLoanAmt%>";
var varFacSno = "<%=strFacSno%>";

function doClose()
{
	if( ConfirmMsg(100) )
	{
		window.close();
	}
}

function disableCommandButtons(val1,val2,val3,val4,val5)
{
	document.forms[0].cmdedit.disabled=val1;
	document.forms[0].cmddelete.disabled=val2;
  	document.forms[0].cmdsave.disabled=val3;
  	document.forms[0].cmdcancel.disabled=val4;
  	document.forms[0].cmdclose.disabled=val5;
}

function onLoading()
{
	disableFields(true);
	disableCommandButtons(false,true,true,true,false);

	if(varFacSno!="0")
		document.forms[0].sel_facilitysno.value = varFacSno;
	else
		document.forms[0].sel_facilitysno.value = "";
	
	<%if(arrRow!=null && arrRow.size()>0){
		for(int i=0;i<arrRow.size();i++){ 
		arrCol = (ArrayList)arrRow.get(i); %>
		document.forms[0].sel_capacity[<%=i%>].value = "<%=Helper.correctNull((String)arrCol.get(4))%>";
		document.forms[0].sel_lendingbank[<%=i%>].value = "<%=Helper.correctNull((String)arrCol.get(6))%>";
	<%}}%>
	shareCalc();
	document.forms[0].sel_facilitysno.disabled=false;
	if(btnenable=="N")
	{
		document.forms[0].cmdedit.disabled=true;
	}
}

function doEdit()
{
	if(document.forms[0].sel_facilitysno.value=="")
	{
		alert("Select a facility");
		document.forms[0].sel_facilitysno.focus();
		return;
	}
	disableFields(false);
	disableCommandButtons(true,false,false,false,true);
	IndvCapacity();
	document.forms[0].sel_facilitysno.disabled=true;
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	   
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].disabled=!val;
		}	
	}
	document.forms[0].txt_proposedamt.readOnly = true;
	document.forms[0].txt_sharedamt.readOnly = true;
}

function IndvCapacity()
{
	for(var i=0;i<document.forms[0].txt_sno.length;i++)
	{
		if(document.forms[0].sel_capacity[i].value == "Y")
		{
			document.forms[0].txt_loanamt[i].readOnly = false;
			document.forms[0].sel_lendingbank[i].disabled = false;
		}
		else
		{
			document.forms[0].txt_loanamt[i].value = "";
			document.forms[0].sel_lendingbank[i].value = "s";
			document.forms[0].txt_loanamt[i].readOnly = true;
			document.forms[0].sel_lendingbank[i].disabled = true;
		}
	}
}

function shareCalc()
{
	var TotalShare=0;
	if(document.forms[0].txt_sno)
	{
		for(var i=0;i<document.forms[0].txt_sno.length;i++)
		{
			document.forms[0].txt_share[i].value = roundVal(document.forms[0].txt_share[i].value);
			TotalShare = eval(TotalShare) + eval(document.forms[0].txt_share[i].value);
		}
	}
	document.forms[0].txt_proposedamt.value = roundVal(varProposedAmt);
	document.forms[0].txt_sharedamt.value = roundVal(TotalShare);

	if(eval(TotalShare) == eval(varProposedAmt))
	{
		document.all.tally_flag.innerHTML = "<font color=\"green\">Amount Tallied</font>";
	}
	else
	{
		document.all.tally_flag.innerHTML = "<font color=\"red\">Amount Not Tallied</font>";
	}
}

function doSave()
{
	for(var i=0;i<document.forms[0].txt_sno.length;i++)
	{
		if(document.forms[0].txt_share[i].value == "")
		{
			alert("Please Enter the Share of the Member");
			document.forms[0].txt_share[i].focus();
			return;
		}
		if(document.forms[0].sel_capacity[i].value == "s")
		{
			alert("Please Select the individual loan capacity from other sources");
			document.forms[0].sel_capacity[i].focus();
			return;
		}
		if(document.forms[0].sel_capacity[i].value == "Y")
		{
			if(document.forms[0].txt_loanamt[i].value == "")
			{
				alert("Please Enter the Loan amount capacity");
				document.forms[0].txt_loanamt[i].focus();
				return;
			}
			if(document.forms[0].sel_lendingbank[i].value == "s")
			{
				alert("Please select the Institution");
				document.forms[0].sel_lendingbank[i].focus();
				return;
			}
		}
	}
	disableFields(false);
	document.forms[0].sel_facilitysno.disabled=false;
	document.forms[0].hidAction.value="insert";
	document.forms[0].hidBeanId.value="facilities";
	document.forms[0].hidBeanMethod.value="updateSHGmembershare";
	document.forms[0].hidBeanGetMethod.value="getSHGmembershare";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/fac_shg_membershare.jsp";
	document.forms[0].submit();
}
function doCancel()
{
	if(ConfirmMsg('102'))
	{
		document.forms[0].hidBeanGetMethod.value="getSHGmembershare";
		document.forms[0].hidBeanId.value="facilities";
		document.forms[0].action=appURL+"action/fac_shg_membershare.jsp";	
		document.forms[0].submit();
	}
}
function doDelete()
{
	if(document.forms[0].sel_facilitysno.value=="")
	{
		alert("Select a facility");
		document.forms[0].sel_facilitysno.focus();
		return;
	}
	if(ConfirmMsg('101'))
	{
		disableFields(false);
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanId.value="facilities";
		document.forms[0].hidBeanMethod.value="updateSHGmembershare";
		document.forms[0].hidBeanGetMethod.value="getSHGmembershare";
		document.forms[0].hidSourceUrl.value="/action/fac_shg_membershare.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}

function LoadValues()
{
	document.forms[0].hidBeanGetMethod.value="getSHGmembershare";
	document.forms[0].hidBeanId.value="facilities";
	document.forms[0].action=appURL+"action/fac_shg_membershare.jsp";	
	document.forms[0].submit();
}

</script>
</head>
<body onLoad="onLoading()">
<form name="comments" method="post" class="normal">
<br>
<table width="98%" border="0" cellpadding="3" cellspacing="3" class="outertable" align="center">
<tr>
	<td>
		<table width="100%" border="0" cellpadding="3" cellspacing="0" class="outertable border1" align="center">
		<%if(strSessionModuleType.equalsIgnoreCase("RET")){ %>
		<tr style="display: none;">
				<td colspan="7">
				<input type="hidden" name="sel_facilitysno" value="1">
				</td>
			</tr>
		<%}else{ %>
			<tr class="datagrid">
				<td colspan="7">
				Facility &nbsp; &nbsp;
				<select name="sel_facilitysno" tabindex="1" onchange="LoadValues()">
				<option value="" selected="selected">--Select--</option>
		        <lapschoice:ComMisDetailsTag apptype='<%=Helper.correctNull((String)request.getParameter("appno")) %>' page='mis'/>
				</select>
				</td>
			</tr>
		<%} %>
		<tr class="dataheader">
			<td colspan="7" align="center">SHG Member wise loan share</td>
		</tr>
		<tr class="datagrid">
		<td colspan="2">Proposed Loan Amount</td>
		<td><input type="text" name="txt_proposedamt" style="text-align:right"></td>
		<td colspan="2">Amount Shared among the Members of SHG</td>
		<td><input type="text" name="txt_sharedamt" style="text-align:right"></td>
		<td align="center"><b><span id="tally_flag">&nbsp;</span></b></td>
		</tr>
		<tr class="dataheader" align="center">
		<td width="5%" rowspan="2">S.no</td>
		<td width="10%" rowspan="2">CBS ID</td>
		<td width="20%" rowspan="2">Member Name</td>
		<td width="10%" rowspan="2">Share in the Proposed Loan</td>
		<td width="15%" rowspan="2">Whether loans taken by the member in individual capacity from other sources</td>
		<td width="40%" colspan="2">Details</td>
		</tr>
		<tr class="dataheader" align="center">
		<td width="15%">Loan Amount</td>
		<td width="25%">Institution</td>
		</tr>
		<%if(arrRow!=null && arrRow.size()>0){
			for(int i=0;i<arrRow.size();i++){ 
			arrCol = (ArrayList)arrRow.get(i); %>
		<tr class="datagrid">
		<td align="center"><input type="hidden" name="txt_sno" value="<%=Helper.correctInt((String)arrCol.get(0))%>"><%=Helper.correctInt((String)arrCol.get(0))%>&nbsp;</td>
		<td align="center"><%=Helper.correctNull((String)arrCol.get(1))%>&nbsp;</td>
		<td align="left"><%=Helper.correctNull((String)arrCol.get(2))%>&nbsp;</td>
		<td align="center"><input type="text" name="txt_share" onblur="shareCalc()" style="text-align:right" onKeyPress="allowNumber(this)" value="<%=Helper.correctDouble((String)arrCol.get(3))%>">&nbsp;</td>
		<td align="center"><select name="sel_capacity" onchange="IndvCapacity();"><option value="s">--Select--</option><option value="Y">Yes</option><option value="N">No</option></select>&nbsp;</td>
		<td align="center"><input type="text" name="txt_loanamt" style="text-align:right" onKeyPress="allowNumber(this)" value="<%=Helper.correctDouble((String)arrCol.get(5))%>">&nbsp;</td>
		<td align="center">
			<select name="sel_lendingbank">
			<option value="s">--Select--</option>
			<lapschoice:StaticDataTag apptype="147"/>
			</select>&nbsp;
		</td>
		</tr>
		<%}} %>
		</table>
	</td>
</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
<input type="hidden" name="hidCommentPage" value="<%=Helper.correctNull((String)request.getParameter("hidCommentPage"))%>">
<input type="hidden" name="appno" value="<%=strAppno%>">
<input type="hidden" name="hidAction" value="">
<input type="hidden" name="hidBeanId">
<input type="hidden" name="hidBeanMethod">
<input type="hidden" name="hidBeanGetMethod">
<input type="hidden" name="hidSourceUrl">
<input type="hidden" name="hidPageType" value="<%=Helper.correctNull((String)request.getParameter("hidCommentPage"))%>">
<INPUT TYPE="hidden" name="hidDemoId"	value="<%=Helper.correctNull((String) request.getParameter("hidDemoId"))%>">
<input type="hidden" name="hidPage">
<input type="hidden" name="hidPageId">
<input type="hidden" name="btnenable" value="<%=Helper.correctNull((String) request.getParameter("btnenable"))%>">
</form>
</body>
</html>