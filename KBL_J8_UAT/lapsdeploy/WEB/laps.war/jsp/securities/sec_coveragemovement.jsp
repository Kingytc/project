<%@include file="../share/directives.jsp"%>
<%
	String strSessionModuleType=Helper.correctNull(
			(String)session.getAttribute("sessionModuleType")).trim();


ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();

arrRow=(ArrayList) hshValues.get("arrRow");
%>
<html>
<head>
<title>Security Coverage Movement</title>

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function doClose()
{
	if( ConfirmMsg(100) )
	{
        document.forms[0].hidBeanId.value="facilities";
	    document.forms[0].action=appURL+"action/"+"corppge.jsp";	
		document.forms[0].submit();
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
	document.forms[0].hidAction.value ="delete";
	document.forms[0].hidBeanId.value="securitymaster";
	document.forms[0].hidBeanMethod.value="updateSecurityMovement";
	document.forms[0].hidBeanGetMethod.value="getSecurityMovement";
	document.forms[0].hidSourceUrl.value="action/sec_coveragemovement.jsp";	
	document.forms[0].action=appURL+"action/controllerservlet";	
	document.forms[0].submit();
	}
}
function doSave()
{ 	
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].hidAction.value="update"
	    document.forms[0].hidBeanId.value="securitymaster";
		document.forms[0].hidBeanMethod.value="updateSecurityMovement";
		document.forms[0].hidBeanGetMethod.value="getSecurityMovement"
		document.forms[0].hidSourceUrl.value="/action/sec_coveragemovement.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
}

function doEdit()
{
	disableFields(false);
	callDisableControls(true,false,false,false,true);
}
function callDisableControls(cmdEdit,cmdSave,cmdDelete,cmdCancel,cmdClose)
{
	document.forms[0].cmdedit.disabled=cmdEdit;
	document.forms[0].cmdsave.disabled=cmdSave;
	document.forms[0].cmddelete.disabled=cmdDelete;
	document.forms[0].cmdcancel.disabled=cmdCancel;
	document.forms[0].cmdclose.disabled=cmdClose;
}


function onLoading()
{
	 disableFields(true);
}

function disableFields(val)
{
	  for(var i=0;i<document.forms[0].length;i++)
	  {
		  
		  if(document.forms[0].elements[i].type=='text')
		  {
			document.forms[0].elements[i].readOnly=val;
		  }
		  if(document.forms[0].elements[i].type=='checkbox')
		  {
			document.forms[0].elements[i].disabled=val;
		  }
		  if(document.forms[0].elements[i].name=='txt_extimes')
		  {
			document.forms[0].elements[i].readOnly=true;
		  }
		  
	  }
	  
}

function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="securitymaster";
		document.forms[0].hidBeanGetMethod.value="getSecurityMovement";
		document.forms[0].action=appURL+"action/sec_coveragemovement.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}
function calTotal(obj)
{

	var tab  = document.getElementById("tab_coverage");
	var rowsLength = tab.rows.length;
	if(rowsLength>1)
	{
		for(var i=0;i<document.forms[0].txt_exposure.length;i++)
		{
			if(obj==document.forms[0].txt_exposure[i]||obj==document.forms[0].txt_networth[i])
			{
				if(document.forms[0].txt_exposure[i].value=="")
					document.forms[0].txt_exposure[i].value="0";
				if(document.forms[0].txt_networth[i].value=="")
					document.forms[0].txt_networth[i].value="0";


				if(roundVal(document.forms[0].txt_networth[i].value)!="0.00")
				{
					document.forms[0].txt_extimes[i].value=eval(document.forms[0].txt_exposure[i].value)/eval(document.forms[0].txt_networth[i].value);
					roundtxt(document.forms[0].txt_extimes[i])
				}
			}
		}
	}
	else
	{
		if(document.forms[0].txt_exposure.value=="")
			document.forms[0].txt_exposure.value=="0";
		if(document.forms[0].txt_networth.value=="")
			document.forms[0].txt_networth.value=="0";


		if(roundVal(document.forms[0].txt_networth.value)!="0.00")
		{
			document.forms[0].txt_extimes.value=eval(document.forms[0].txt_exposure.value)/eval(document.forms[0].txt_networth.value);
			roundtxt(document.forms[0].txt_extimes)
		}
	}
	

	
}
function AddRows(){

	if(document.forms[0].cmdsave.disabled==false)
	{	
	var tab  = document.getElementById("tab_coverage");
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
					 if(tabid=="tab_coverage" && rowsLength=="1")
					{
						document.forms[0].txt_fromyear.value="";  
						document.forms[0].txt_toyear.value="";  
						document.forms[0].txt_exposure.value="";  
						document.forms[0].txt_seccoverage.value="";
						document.forms[0].txt_networth.value="";
						document.forms[0].txt_extimes.value="";  
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
	var tab  = document.getElementById("tab_coverage");
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
			else
			{
				if(val=="txt_fromyear")
				{
					if(obj.value==document.forms[0].txt_fromyear[i].value)
					{
						alert("Year already exist");
						obj.value="";
					}
				}
				else
				{
					if(obj.value==document.forms[0].txt_toyear[i].value)
					{
						alert("Year already exist");
						obj.value="";
					}
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
</script>

</head>
<body onload="onLoading()">
<form method=post class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="top"><jsp:include page="../share/applurllinkscom.jsp"
			flush="true">
			<jsp:param name="pageid" value="33" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />


		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<%
			if(strSessionModuleType.equals("AGR"))
			{
		%>
		<td class="page_flow">Home -&gt; Agriculture -&gt;Application
		-&gt; Security Master -&gt; Additional securities offered for the
		proposed facilities</td>
		<%
			}
			else
			{
		%>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt;
		Application -&gt; Security Master -&gt; Additional securities offered
		for the proposed facilities</td>
		<%
			}
		%>
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="top"><jsp:include page="../set/appurlsectabs.jsp"
			flush="true">
			<jsp:param name="pageid" value="103" />
		</jsp:include></td>
	</tr>
</table>

<table  width="100%" border="0" cellpadding="4" class="outertable"
			align="center" style="border: 1px solid #bbb;">
	<tr class="dataheader">
		<td>Analysis of Movement of Security Coverage (excluding Stock & Book Debts) and Analysis of Movement of Credit Exposure against the Networth for last 5 years</td>
	</tr>
	<tr class="dataheader"><td align="right">(Amount in Rs.)&nbsp;</td></tr>
	<tr>
		<td>
		<table width="100%" border="0" cellpadding="4" class="outertable"
			align="center" style="border: 1px solid #bbb;">
			<tr class="dataheader">
			<td width="5%"><span style=""><a onClick="AddRows();"><img
										src="<%=ApplicationParams.getAppUrl()%>img/add.png"
										border="0" tabindex="38"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								 		<a onClick="deleteRow1('tab_coverage','0');"><img
										src="<%=ApplicationParams.getAppUrl()%>img/cancel.png"
										border="0"></a> </span></td>
				<td width="15%" align="center">Year </td>
				<td width="20%" align="center">Total Exposure</td>
				<td width="20%" align="center">Security Coverage (%)</td>
				<td width="20%" align="center">Networth of the Borrower</td>
				<td width="20%" align="center"> (Exposure/NW)(Times)</td>
			</tr>
		</table>
		<table width="100%" border="0" cellpadding="4" class="outertable"
			align="center" style="border: 1px solid #bbb;"  id="tab_coverage">
			
			<%if(arrRow!=null && arrRow.size()>0){
				for(int i=0;i<arrRow.size();i++)
				{
				arrCol=(ArrayList)arrRow.get(i);%>
			<tr class="datagrid">
			<td width="5%" align="center"><input type="checkbox" name="chk1" style="border: none;"></td>
				<td width="15%"  align="center"><input type="text" name="txt_fromyear" value="<%=Helper.correctNull((String)arrCol.get(0))%>" size="6" onkeypress="allowWholeNumber(this)" title="From Year" maxlength="4" onblur="chkYearVal(this,'txt_fromyear');">
				 - <input type="text" name="txt_toyear" value="<%=Helper.correctNull((String)arrCol.get(1))%>" size="6" onkeypress="allowWholeNumber(this)"  title="To Year" maxlength="4" onblur="chkYearVal(this,'txt_toyear');"></td>
				<td align="center" width="20%"><input type="text" name="txt_exposure"
					style="text-align: right;"
					value="<%=Helper.correctNull((String)arrCol.get(2))%>"
					onblur="roundtxt(this);calTotal(this);" size="15"
					onkeypress="allowNumber(this)" maxlength="12"></td>
				<td align="center" width="20%"><input type="text" name="txt_seccoverage"
					style="text-align: right;"
					value="<%=Helper.correctNull((String)arrCol.get(3))%>"
					onblur="roundtxt(this);" size="15"
					onkeypress="allowNumber(this)" maxlength="12"></td>
				<td align="center" width="20%"><input type="text" name="txt_networth"
					style="text-align: right;"
					value="<%=Helper.correctNull((String)arrCol.get(4))%>"
					onblur="roundtxt(this);calTotal(this);" size="15"
					onkeypress="allowNumber(this)" maxlength="12"></td>
				<td align="center" width="20%"><input type="text" name="txt_extimes"
					style="text-align: right;"
					value="<%=Helper.correctNull((String)arrCol.get(5))%>"
					onblur="roundtxt(this);" size="15"
					onkeypress="allowNumber(this)" maxlength="12"></td>
			</tr>
			<%}}else{ %>
			<tr class="datagrid">
			<td width="5%" align="center"><input type="checkbox" name="chk1" style="border: none;"></td>
				<td width="15%"  align="center"><input type="text" name="txt_fromyear" value="" size="6" onkeypress="allowWholeNumber(this)" title="From Year" maxlength="4" onblur="chkYearVal(this,'txt_fromyear');">
				 - <input type="text" name="txt_toyear" value="" size="6" onkeypress="allowWholeNumber(this)"  title="To Year" maxlength="4" onblur="chkYearVal(this,'txt_toyear');"></td>
				<td align="center" width="20%"><input type="text" name="txt_exposure"
					style="text-align: right;"
					value=""
					onblur="roundtxt(this);calTotal(this);" size="15"
					onkeypress="allowNumber(this)" maxlength="12"></td>
				<td align="center" width="20%"><input type="text" name="txt_seccoverage"
					style="text-align: right;"
					value=""
					onblur="roundtxt(this);" size="15"
					onkeypress="allowNumber(this)" maxlength="12"></td>
				<td align="center" width="20%"><input type="text" name="txt_networth"
					style="text-align: right;"
					value=""
					onblur="roundtxt(this);calTotal(this);" size="15"
					onkeypress="allowNumber(this)" maxlength="12"></td>
				<td align="center" width="20%"><input type="text" name="txt_extimes"
					style="text-align: right;"
					value=""
					onblur="roundtxt(this);" size="15"
					onkeypress="allowNumber(this)" maxlength="12"></td>
			</tr>
			<%} %>
		</table>
		</td>
	</tr>
</table>

<lapschoice:combuttonnew
	btnenable='<%=Helper.correctNull((String)request
							.getParameter("btnenable"))%>'
	btnnames='Edit_Save_Cancel_Delete_Audit Trail' /> <lapschoice:hiddentag
	pageid='<%=PageId%>' /></form>
</body>
</html>