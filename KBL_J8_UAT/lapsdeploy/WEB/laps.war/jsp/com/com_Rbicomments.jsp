<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<%String strappliedfor=Helper.correctNull((String)request.getParameter("appliedfor"));
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
String strAppno=Helper.correctNull((String)request.getParameter("appno"));

ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();

arrRow=(ArrayList)hshValues.get("arrRow");%>
<html>
<head>
<title>ROC Details</title>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var varOrgLevel="<%=strOrgLevel%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varright= "<%=Helper.correctNull((String) session.getAttribute("strGroupRights")).charAt(18)%>";	
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var varOpt="<%=Helper.correctNull((String)hshValues.get("strOptVal"))%>";
var varModule="<%=strSessionModuleType%>";
function placevalues()
{
	
	if(document.forms[0].btnenable.value=="Y")
	{
	if(document.forms[0].appstatus.value=="Open/Pending")
	{
		
				disableButtons(false,true,true,true,false);
	}
	else
	{
		disableButtons(true,true,true,true,false);
	}
	
		
	}
	disableFields(true);
	
	EditorEnableDisable("id_div","block","id_editor","none");

	if(varModule=="AGR"||varModule=="CORP")
	{
		document.forms[0].sel_option.disabled=false;
		if(varOpt!="")
		{
			document.forms[0].sel_option.value=varOpt;
		}
		enableTables();
	}
}
function enableTables()
{
	if(document.forms[0].sel_option.value=="3")
	{
		document.all.idTable.style.display="table";
	}
	else
	{
		document.all.idTable.style.display="none";
	}
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
		if(document.forms[0].elements[i].type=='checkbox')
		  {
			document.forms[0].elements[i].disabled=val;
		  }
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=val;		  
		}
	}
}

function doEdit()
{
	disableFields(false);
	disableButtons(true,false,false,false,true)
	EditorEnableDisable("id_div","none","id_editor","block");
	editor_generate('exec_summ_company');
}

function disableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="compro"
		document.forms[0].hidBeanGetMethod.value="getcom_Rbicommentsdata";
		document.forms[0].action=appUrl+"action/com_Rbicomments.jsp";
		document.forms[0].submit();
	 }
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/corppge.jsp";
		document.forms[0].submit();
	}
}

function doSave()
{

	var tab  = document.getElementById("tab_FTP");
	var rowsLength = tab.rows.length;
	if(rowsLength>1)
	{
		for(var i=0;i<document.forms[0].txt_fromyear.length;i++)
		{
				if(document.forms[0].txt_fromyear[i].value=="" && ((document.forms[0].txt_toyear[i].value!="" ||(document.forms[0].txt_ftppl[i].value!="" && document.forms[0].txt_ftppl[i].value!="0.00")||
				(document.forms[0].txt_ftpyield[i].value!="" && document.forms[0].txt_ftpyield[i].value!="0.00")||(document.forms[0].txt_rorac[i].value!="" && document.forms[0].txt_rorac[i].value!="0.00"))))
				{
					alert("Enter Year From");
					document.forms[0].txt_fromyear[i].value="";
					document.forms[0].txt_fromyear[i].focus();
					return;
				}
		}
	}
	else
	{
		if(document.forms[0].txt_fromyear.value=="" && (document.forms[0].txt_toyear.value!="" ||(document.forms[0].txt_ftppl.value!="" && document.forms[0].txt_ftppl.value!="0.00")||
				(document.forms[0].txt_ftpyield.value!="" && document.forms[0].txt_ftpyield.value!="0.00")||(document.forms[0].txt_rorac.value!="" && document.forms[0].txt_rorac.value!="0.00")))
		{
			alert("Enter Year From");
			document.forms[0].txt_fromyear.value="";
			document.forms[0].txt_fromyear.focus();
			return;
		}
	}
	
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidAction.value="update";
	document.forms[0].hidBeanId.value="compro";
	document.forms[0].hidBeanMethod.value="updatecom_Rbicommentsdata";
	document.forms[0].hidBeanGetMethod.value="getcom_Rbicommentsdata";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/com_Rbicomments.jsp";
	document.forms[0].submit();
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value="delete"
		document.forms[0].hidBeanId.value="compro"
		document.forms[0].hidBeanMethod.value="updatecom_Rbicommentsdata";
		document.forms[0].hidBeanGetMethod.value="getcom_Rbicommentsdata";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_Rbicomments.jsp";
		document.forms[0].submit();
	 }
}
function Addvaluer(){

	if(document.forms[0].cmdsave.disabled==false)
	{	
	var tab  = document.getElementById("tab_FTP");
	var rowsLength = tab.rows.length;
	if(rowsLength<=200)
	{
		var new_Row    = tab.insertRow(rowsLength);
		
		var rwlength=rowsLength;
		new_Row.id=""+rowsLength;
		var previous_RowCells=tab.rows[rowsLength-1].cells; 
		for(i=0;i<previous_RowCells.length;i++)
		{
			var new_RowCell=new_Row.insertCell(i);
			new_RowCell.innerHTML=previous_RowCells[i].innerHTML;
			new_RowCell.className="datagrid";
			new_RowCell.align="center";
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
		alert("Cannot add more rows");
	}
	
}
}

function deleteRow1(tabid,tdcount)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var tab = document.getElementById(tabid);
		var rowsLength = tab.rows.length;
		var varCheckedFlag=false;
		
		if(rowsLength>=1)
		{
			for(var i=0;i<rowsLength;i++)
			{
				var current_row = tab.rows[i];
				var chkbox = current_row.cells[tdcount].childNodes[0];
				if(chkbox != null && chkbox.checked == true)
				{
					 if(tabid=="tab_FTP" && rowsLength=="1")
					{
						document.forms[0].txt_fromyear.value="";  
						document.forms[0].txt_toyear.value="";  
						document.forms[0].txt_ftppl.value="";  
						document.forms[0].txt_ftpyield.value="";
						document.forms[0].txt_rorac.value="";  
					    chkbox.checked=false; 
					    return;
					}
					else
					{
						tab.deleteRow(i);
						rowsLength--;
						i--;
					}

					if(!varCheckedFlag)
					{
						varCheckedFlag=true;
					}
				}
			}
			if(!varCheckedFlag)
			{
				alert("Please select the check box for deletion");
			}
		}
	}
}
function chkYearVal(obj,val)
{
	var tab  = document.getElementById("tab_FTP");
	var rowsLength = tab.rows.length;
	if(rowsLength>1)
	{
		for(var i=0;i<document.forms[0].txt_fromyear.length;i++)
		{
			if(obj==document.forms[0].txt_fromyear[i]||obj==document.forms[0].txt_toyear[i])
			{
				if(eval(document.forms[0].txt_fromyear[i].value)>eval(document.forms[0].txt_toyear[i].value))
				{
					alert("From Year cannot be lesser than To Year");
					obj.value="";
					obj.focus();
					return;
				}
			}
		}
	}
	else
	{
		if(eval(document.forms[0].txt_fromyear.value)>eval(document.forms[0].txt_toyear.value))
		{
			alert("From Year cannot be lesser than To Year");
			obj.value="";
			obj.focus();
			return;
		}
	}
}
function getValues()
{
	document.forms[0].hidBeanId.value="compro"
	document.forms[0].hidBeanGetMethod.value="getcom_Rbicommentsdata";
	document.forms[0].action=appUrl+"action/com_Rbicomments.jsp";
	document.forms[0].submit();
}
</script>

</head>
<body onload="placevalues()">
<form method="post" class="normal">
<%
if((strSessionModuleType.equals("CORP"))||(strSessionModuleType.equals("AGR"))){

if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
class="outertable">
<tr>
	<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
		<jsp:param name="pageid" value="4" />
		<jsp:param name="subpageid" value="131" />
		<jsp:param name="cattype" value="<%=strCategoryType%>" />
		<jsp:param name="ssitype" value="<%=strSSIType%>" />
	</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
	</td>
</tr>
</table>
<%}else{%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="top"><jsp:include page="../com/proposallinks.jsp"
			flush="true">
			<jsp:param name="pageid" value="20" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<%if(strSessionModuleType.equals("AGR")){%>
	<tr>
		<td class="page_flow">Home -&gt; Agriculture -&gt; Proposal -&gt;Audit Observations -&gt; Comments</td>
	</tr>
	<%}else{ %>
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Proposal -&gt; Audit Observations -&gt;Comments</td>
	</tr>
	<%} %>	
</table>
<span style="display: none"><lapschoice:borrowertype /></span><lapschoice:application />
<%} %>
<lapstab:Rbisubpage tabid="2" applevel='<%=Helper.correctNull((String)request.getParameter("applevel"))%>' applied='<%=strappliedfor%>' appno='<%=strAppno %>'/>

<%} else{
if(!Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>
<jsp:include page="../share/Applurllinkper.jsp" flush="true">
<jsp:param name="pageid" value="10" /></jsp:include>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Retail(including schematic) -&gt; Appraisal -&gt;Assessment-R/C</td>
	</tr>
</table>
<lapschoice:application />
<jsp:include page="../share/apprlinktab.jsp" flush="true">
			<jsp:param name="tabid" value="117" />
</jsp:include>
<%}else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="7" />
			<jsp:param name="subpageid" value="111" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<jsp:include page="../share/postsanctionapprlinktab.jsp" flush="true">
			<jsp:param name="tabid" value="117" />
		</jsp:include>
<%} %>
<%}%>
<br>
<table width="90%" border="0" cellspacing="0" cellpadding="0" class="outertable border1" align="center">
<tr><td>&nbsp;</td></tr>
<%if((strSessionModuleType.equals("CORP"))||(strSessionModuleType.equals("AGR"))){ %>
<tr>
<td>Comments on <select name="sel_option" onchange="getValues();">
<option value=""><--select--></option>
<option value="1">Others</option>
<option value="2">Conduct of the account: (How many times (in days),the account was in S1/S2/S3/NPA/Irregular Status/Regular Status etc) </option>
<option value="3">Customer Profitability (FTP) and RAROC (Risk Adjusted Return on Capital - Data provided by Risk Management Department)</option>
</select>
</td>
</tr>
<%} %>
<tr><td>&nbsp;</td></tr>
<tr id="idTable" style="display: none;">
<td>
<table width="100%"  border="0"   cellpadding="4"  class="outertable" align="center"  style="border: 1px solid #bbb;" >
<tr>
<td colspan="5">Comment on Customer Profitability (FTP) and RAROC (Risk Adjusted Return on Capital - Data provided by Risk Management Department)</td>
</tr>
 <tr class="dataheader">
	<td width="5%" align="center" rowspan="2"><span style=""><a onClick="Addvaluer();"><img
		src="<%=ApplicationParams.getAppUrl()%>img/add.png"
		border="0" tabindex="38"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 		<a onClick="deleteRow1('tab_FTP','0');"><img
		src="<%=ApplicationParams.getAppUrl()%>img/cancel.png"
			border="0"></a> </span> </td>
		<td width="20%" align="center" colspan="2"> Particulars</td>
		<td  width="25%" align="center" rowspan="2"> FTP - Profit/(Loss)</td>
		<td  width="25%" align="center" rowspan="2"> FTP Yield</td>
		<td  width="25%" align="center" rowspan="2"> RAROC</td>
</tr>
<tr class="dataheader">
<td align="center" width="10%">From</td>
<td align="center" width="10%">To</td>
</tr>
</table>
<table width="100%" border="0"   class="outertable"  align="center" cellpadding="3" style="border: 1px solid #bbb;" id="tab_FTP">
 <%if(arrRow!=null && arrRow.size()>0){ 
	for(int i=0;i<arrRow.size();i++){
	arrCol=(ArrayList)arrRow.get(i);%>
<tr id="0"  align="center">	
	<td width="5%" class="datagrid"><input type="checkbox" name="chk1" style="border: none;"></td>	
	<td width="10%" class="datagrid"><input type="text" name="txt_fromyear" size="6" onkeypress="allowWholeNumber(this)" value="<%=Helper.correctNull((String)arrCol.get(0)) %>" title="From Year" maxlength="4" onblur="checkcurrentyear(this);chkYearVal(this,'txt_fromyear');"></td>
	<td width="10%" class="datagrid"><input type="text" name="txt_toyear" size="6" onkeypress="allowWholeNumber(this)"  value="<%=Helper.correctNull((String)arrCol.get(1)) %>"  title="To Year" maxlength="4" onblur="checkcurrentyear(this);chkYearVal(this,'txt_toyear');"></td>
	<td width="25%" class="datagrid"><input type="text" name="txt_ftppl" size="15" onkeypress="allowNegativeNumber(this)"  value="<%=Helper.correctNull((String)arrCol.get(2)) %>" maxlength="12" style="text-align: right;" onblur="roundtxt(this)"></td>
	<td width="25%" class="datagrid"><input type="text" name="txt_ftpyield" size="15" onkeypress="allowNumber(this)"  value="<%=Helper.correctNull((String)arrCol.get(3)) %>" maxlength="12" style="text-align: right;" onblur="roundtxt(this)"></td>
	<td width="25%" class="datagrid"><input type="text" name="txt_rorac" size="15" onkeypress="allowNumber(this)"   value="<%=Helper.correctNull((String)arrCol.get(4)) %>" maxlength="12" style="text-align: right;" onblur="roundtxt(this)"></td>
</tr>
<%}}else{ %>
<tr id="0"  align="center">	
	<td width="5%" class="datagrid"><input type="checkbox" name="chk1" style="border: none;"></td>	
	<td width="10%" class="datagrid"><input type="text" name="txt_fromyear" size="6" onkeypress="allowWholeNumber(this)" title="From Year" maxlength="4" onblur="checkcurrentyear(this);chkYearVal(this,'txt_fromyear');"></td>
	<td width="10%" class="datagrid"><input type="text" name="txt_toyear" size="6" onkeypress="allowWholeNumber(this)" title="To Year" maxlength="4" onblur="checkcurrentyear(this);chkYearVal(this,'txt_toyear');"></td>
	<td width="25%" class="datagrid"><input type="text" name="txt_ftppl" size="15" onkeypress="allowNegativeNumber(this)" maxlength="12" style="text-align: right;" onblur="roundtxt(this)"></td>
	<td width="25%" class="datagrid"><input type="text" name="txt_ftpyield" size="15" onkeypress="allowNumber(this)" maxlength="12" style="text-align: right;" onblur="roundtxt(this)"></td>
	<td width="25%" class="datagrid"><input type="text" name="txt_rorac" size="15" onkeypress="allowNumber(this)" maxlength="12" style="text-align: right;" onblur="roundtxt(this)"></td>

</tr>
<%} %>
</table>
<table width="100%"  border="0"   cellpadding="4"  class="outertable" align="center"  style="border: 1px solid #bbb;">
<tr>
<td colspan="2">The breakup of FTP for the period (Latest available)</td>
</tr>
  <tr class="dataheader">
		<td width="20%" align="center"> Description</td>
		<td  width="25%" align="center"> Amount</td>
</tr>
<tr class="datagrid">
<td><input type="hidden" name="txt_desc" value="AM">Asset Margin</td>
<td align="center"><input type="text" name="txt_amt"  style="text-align: right;" value="<%=Helper.correctNull((String)hshValues.get("strAmtAM")) %>"  onblur="roundtxt(this);" size="15" onkeypress="allowNumber(this)" maxlength="12"></td>
</tr>
<tr class="datagrid">
<td><input type="hidden" name="txt_desc" value="LM">Liability Margin</td>
<td align="center"><input type="text" name="txt_amt"  style="text-align: right;" value="<%=Helper.correctNull((String)hshValues.get("strAmtLM")) %>" onblur="roundtxt(this);" size="15" onkeypress="allowNumber(this)" maxlength="12"></td>
</tr>
<tr class="datagrid">
<td><input type="hidden" name="txt_desc" value="OI">Other Income</td>
<td align="center"><input type="text" name="txt_amt" style="text-align: right;" value="<%=Helper.correctNull((String)hshValues.get("strAmtOI")) %>"  onblur="roundtxt(this);" size="15" onkeypress="allowNumber(this)" maxlength="12"></td>
</tr>
<tr class="datagrid">
<td><input type="hidden" name="txt_desc" value="OE">Other Expenditure</td>
<td align="center"><input type="text" name="txt_amt" style="text-align: right;" value="<%=Helper.correctNull((String)hshValues.get("strAmtOE")) %>"  onblur="roundtxt(this);" size="15" onkeypress="allowNegativeNumber(this)" maxlength="12"></td>
</tr>
<tr style="display: none;"  class="datagrid">
<td>Total</td>
<td><input type="text" name="txt_amt1" value="" style="text-align: right;"></td>
</tr>
</table>
</td>
</tr>
<tr><td>&nbsp;</td></tr>
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable" align="center">
		<tr> 
                                   <td>
            <div id="id_div"><div class="EditorClassNew"> <%=Helper.correctNull((String)hshValues.get("COM_COMMENTS")) %></div></div>
             <div id="id_editor"> <textarea name="exec_summ_company" cols="65" rows="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" >
         		     <%=Helper.correctNull((String)hshValues.get("COM_COMMENTS")) %>
              </textarea></div>
            </td>
         </tr>
</table>
</td>
</tr>
</table>
<br>
<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' btnnames='Edit_Save_Cancel_Delete_Audit Trail'/>
<input type="hidden" name="cattype" value="<%=strCategoryType%>">
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidpagetype" value='RBICOM'>
</form>
</body>
</html>
