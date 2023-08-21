<%@include file="../share/directives.jsp"%>
<%
ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();
arrRow = (ArrayList) hshValues.get("arrRow");
%>
<html>
<head>
<title>Deviation Assessment Master</title>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varAssessment="<%= Helper.correctNull((String)hshValues.get("PERM_TYPE_ID"))%>"
var varAssessmentType="<%= Helper.correctNull((String)hshValues.get("PERM_TYPE_ASSESSMENT"))%>"

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/setupnav.jsp";
		document.forms[0].submit();
	}
}
function doSave()
{
	if(document.forms[0].hidAction.value=="insert")
	{
		if(document.forms[0].txt_description.value=="")
		{
			alert("Enter Description");
			document.forms[0].txt_description.focus();
			return;
		}
		else if(document.forms[0].sel_asstype.value=="0")
		{
			alert("Select Assessment Type");
			document.forms[0].sel_asstype.focus();
			return;
		}
	}

	if(document.forms[0].sel_asstype.value=="V" && document.forms[0].txt_value.value=="")
	{
		alert("Enter Max Score");
		document.forms[0].txt_value.focus();
		return;
	}
	else if(document.forms[0].sel_asstype.value=="R")
	{
		if(document.forms[0].txt_range.length==undefined)
		{
			if(document.forms[0].txt_range.value=="")
			{
				alert("Enter Range parameter");
				document.forms[0].txt_range.focus();
				return;
			}
			if(document.forms[0].txt_value1.value=="")
			{
				alert("Enter Range Value");
				document.forms[0].txt_value1.focus();
				return;
			}
		}
		else
		{
			for(var i=0;i<document.forms[0].txt_range.length;i++)
			{
				if(document.forms[0].txt_range[i].value=="")
				{
					alert("Enter Range parameter");
					document.forms[0].txt_range[i].focus();
					return;
				}
				if(document.forms[0].txt_value1[i].value=="")
				{
					alert("Enter Range Value");
					document.forms[0].txt_value1[i].focus();
					return;
				}
			}
		}
	}
	document.forms[0].cmdsave.disabled=true;
	disablefields(false);
	document.forms[0].hidBeanId.value="perDeviation";
	document.forms[0].hidBeanMethod.value="updateAssessmentMaster";
	document.forms[0].hidBeanGetMethod.value="getAssessmentMaster";
	document.forms[0].hidSourceUrl.value="/action/setdeviationassmaster.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doEdit()
{
	document.forms[0].hidAction.value="update";
	callDisableControls(true,true,false,false,false);
	disablefields(false);
	document.forms[0].sel_asstype.disabled=true;
	document.forms[0].sel_assessment.disabled=true;
}
function doNew()
{
	document.forms[0].hidAction.value="insert";
	callDisableControls(true,true,false,false,false);
	disablefields(false);
	document.all.id_asstype.style.display="table-row";
	document.all.id_description.style.display="table-row";
}
function doCancel()
{
	document.forms[0].hidBeanId.value="perDeviation";
	document.forms[0].hidBeanGetMethod.value="getAssessmentMaster";
	document.forms[0].action=appURL+"action/setdeviationassmaster.jsp";
	document.forms[0].submit();
}
function callDisableControls(cmdNew,cmdEdit,cmdSave,cmdCancel,cmdClose)
{
	document.forms[0].cmdnew.disabled=cmdNew;
	document.forms[0].cmdedit.disabled=cmdEdit;
	document.forms[0].cmdsave.disabled=cmdSave;
	document.forms[0].cmdcancel.disabled=cmdCancel;
	document.forms[0].cmdclose.disabled=cmdClose;
}
function callOnLoad()
{
	disablefields(true);
	document.forms[0].sel_assessment.disabled=false;
	if(varAssessment!="")
	{
		document.forms[0].sel_assessment.value=varAssessment;
		document.all.id_asstype.style.display="table-row";
		callDisableControls(true,false,true,true,false);
	}
	if(varAssessmentType!="")
	{
		document.forms[0].sel_asstype.value=varAssessmentType;
	}
	callChange();
	
}
function disablefields(bool)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=bool;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
		document.forms[0].elements[i].disabled=bool;
		}
	}
}
function callChange()
{	
	if(document.forms[0].sel_asstype.value=="V")
	{
		document.all.id_value.style.display="table-row";
		document.all.id_range.style.display="none";
	}
	else if(document.forms[0].sel_asstype.value=="R")
	{
		document.all.id_range.style.display="table-row";
		document.all.id_value.style.display="none";
	}
}
function getValues()
{
	document.forms[0].hidBeanId.value="perDeviation";
	document.forms[0].hidBeanGetMethod.value="getAssessmentMaster";
	document.forms[0].action=appURL+"action/setdeviationassmaster.jsp";
	document.forms[0].submit();
}
function processActionNewMember(type)
{
	if (document.forms[0].cmdsave.disabled == false)
	{
		var table='',rowsLength='';

		table = document.getElementById("idMember");
		rowsLength =table.rows.length;
	
		var new_Row  = table.insertRow(rowsLength);
		new_Row.id="row_"+rowsLength;
		var previous_RowCells=table.rows[rowsLength-1].cells;
		for(i=0;i<previous_RowCells.length;i++)
		{
			var new_RowCell=new_Row.insertCell(i);
			new_RowCell.innerHTML=previous_RowCells[i].innerHTML;
			new_RowCell.align="center";
			new_RowCell.className="datagrid";
			var new_CellElement=new_RowCell.childNodes[0];
			
			for(var j=0;j<new_RowCell.childNodes.length;j++)
			{
				if(new_RowCell.childNodes[j].type=="text")
				{
					new_RowCell.childNodes[j].value="";
				}
			}
		}
	}
	else
	{
		alert('Please click Edit button');
	}
}
function doButtonDeleteMember(type)
{
	if (document.forms[0].cmdsave.disabled == false)
	{
		var varHidMemberSeqID=5;
	    var varCheckedFlag=false;
		var table='',rowsLength='';
		table = document.getElementById("idMember");
		rowsLength =table.rows.length;
		var rowsLength = table.rows.length;
		var count = 0;
		if(rowsLength>2){
			table.deleteRow(rowsLength-1);
		}
	}
	else
	{
		alert('Please click Edit button');
	}
}
</SCRIPT>
</head>
<body onload="callOnLoad();">
<form method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Setup -&gt; General Master</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable">
	<tr>
		<td valign="top">
		<br/>
		<table width="40%" border="0" cellspacing="0" cellpadding="3"
			class="outertable border1 tableBg" align="center" height="auto">
			<tr>
			<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
			class="outertable" align="center">
			<tr>
			<td colspan="2" class="dataheader" align="center"> General Master</td>
			</tr>
			<tr id="subtype">
			<td width="20%">Assessment Parameter <b><span class="mantatory">*&nbsp;</span></b></td>
			<td width="40%"> 
				<select name="sel_assessment" onchange="getValues();">
				<option value=""> &lt;---Select---&gt;</option>
				<lapschoice:DevAssessmentTag/>
				</select>
			</td>
			</tr>
			<tr id="id_asstype" style="display: none;">
			<td width="20%">Assessment Type<b><span class="mantatory">*&nbsp;</span></b></td>
			<td width="40%"> 
				<select name="sel_asstype" onchange="callChange();">
				<option value="0"> &lt;---Select---&gt;</option>
				<option value="V"> Value </option>
				<option value="R"> Range </option>
				</select>
			</td>
			</tr>
			<tr id="id_description" style="display: none;">
			<td>Description <b><span class="mantatory">*&nbsp;</span></b></td>
			<td><input type="text" name="txt_description" onkeypress="allowAlphabetsForName();" /></td>
			</tr>
			
			<tr id="id_value" style="display: none;">
			<td>Max Score <b><span class="mantatory">*&nbsp;</span></b></td>
			<td><input type="text" name="txt_value"  onkeypress="allowNumber(this);"   value="<%=Helper.correctNull((String)hshValues.get("PERM_TYPE_VALUE")) %>"/></td>
			</tr>
			<tr id="id_range" style="display: none;">
			<td colspan="2">
			<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1" id="idMember">
			<tr class="dataheader">
			<td align="center" width="45%">Range</td>
			<td align="center" width="45%"><span style="float: left;">Value</span> <span style="float: right;"><img alt="Click to Add new row" 
					src="<%=ApplicationParams.getAppUrl()%>img/add.png" 
					onclick="processActionNewMember()" style="cursor:hand"/>
					&nbsp;
					<img alt="Click to Delete row" 
					src="<%=ApplicationParams.getAppUrl()%>img/cancel.png" 
					onclick="doButtonDeleteMember()" style="cursor:hand"/></span></td>
			</tr>
			<%if(arrRow!=null && arrRow.size()>0){ 
			for(int i=0;i<arrRow.size();i++){
			arrCol=(ArrayList)arrRow.get(i);%>
			<tr align="center"  class="datagrid">
			 			
					<td><input type="text" name="txt_range" value="<%=Helper.correctNull((String)arrCol.get(1)) %>"> </td>	
					<td colspan="2"><input type="text" name="txt_value1" onkeypress="allowNumber(this);"  value="<%=Helper.correctNull((String)arrCol.get(2)) %>"> </td>	
					</tr>
					<%}}else{ %>
			<tr align="center"  class="datagrid">	
					<td><input type="text" name="txt_range"> </td>	
					<td colspan="2"><input type="text" name="txt_value1" onkeypress="allowNumber(this);"> </td>	
					</tr>
					<%} %>
			</table>
			</td>
			</tr>
			
		
		</table>
		</td>
		</tr>
		</table>
		</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
	<td>
	<table width="60%" border="0" cellspacing="0" cellpadding="3"
			class="outertable" align="center">
			<tr>
			</tr>
	 <lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel'
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
	</table>
	</td>
	</tr>
</table>
<br>

<lapschoice:hiddentag pageid='<%=PageId%>' />
<input type="hidden" name="hidsno" value="">
<input type="hidden" name="hidsubtype" value="">
</form>
</body>
</html>

