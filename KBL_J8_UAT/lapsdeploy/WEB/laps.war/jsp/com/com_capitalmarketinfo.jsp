<%@include file="../share/directives.jsp"%>
<%
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();
arrRow=(ArrayList)hshValues.get("arrRow");
%>
<html>
<head>
<title>Capital Market Infomation</title>

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varStockSE="<%=Helper.correctNull((String)hshValues.get("strListedinSE"))%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
function doSave()
{
	if(document.forms[0].sel_listedinse.value=="")
	{
		alert("Select Whether listed in S.E Quotation Value");
		document.forms[0].sel_listedinse.focus();
		return;
	}

	if(document.forms[0].txt_particulars[6].value=="" && ((document.forms[0].txt_BSE[6].value!="" && document.forms[0].txt_BSE[6].value!="0.00")||(document.forms[0].txt_NSE[6].value!="" && document.forms[0].txt_NSE[6].value!="0.00")))
	{
		alert("Enter Year 1");
		return;
	}
	else if(document.forms[0].txt_particulars[7].value=="" && ((document.forms[0].txt_BSE[7].value!="" && document.forms[0].txt_BSE[7].value!="0.00")||(document.forms[0].txt_NSE[7].value!="" && document.forms[0].txt_NSE[7].value!="0.00")))
	{
		alert("Enter Year 2");
		return;
	}
	else if(document.forms[0].txt_particulars[8].value=="" && ((document.forms[0].txt_BSE[8].value!="" && document.forms[0].txt_BSE[8].value!="0.00")||(document.forms[0].txt_NSE[8].value!="" && document.forms[0].txt_NSE[8].value!="0.00")))
	{
		alert("Enter Year 3");
		return;
	}
	document.forms[0].hidAction.value ="insert";
	document.forms[0].cmdsave.disabled = true;	
	document.forms[0].hidBeanId.value="executive";
	document.forms[0].hidSourceUrl.value="/action/com_capitalmarketinfo.jsp";
	document.forms[0].hidBeanMethod.value="updCaptialMarketInfo";
	document.forms[0].hidBeanGetMethod.value="getCaptialMarketInfo";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doEdit()
{
	disableFields(false);
	disableCommandButtons(true,false,false,false,true);
	for(var i=0;i<5;i++)
	{
		document.forms[0].txt_particulars[i].readOnly=true;
	}
	document.forms[0].txt_date.readOnly=true;
}
function disableCommandButtons(valedit,valapply,valcancel,valdel,valclose)
{
	document.forms[0].cmdedit.disabled=valedit;
	document.forms[0].cmddelete.disabled=valdel;
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmdclose.disabled=valclose;
}
function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="executive";
		document.forms[0].hidBeanGetMethod.value="getCaptialMarketInfo";
		document.forms[0].action=appURL+"action/com_capitalmarketinfo.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
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
		if(document.forms[0].elements[i].type=="radio")
		{
			document.forms[0].elements[i].disabled=(!val);		  
		} 
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=val;		  
		} 
	}
	
}
function doDelete()
{

		if(ConfirmMsg(101))
		{
			
		   	document.forms[0].hidAction.value ="delete";		
			document.forms[0].hidBeanMethod.value="updCaptialMarketInfo";
			document.forms[0].hidBeanId.value="executive";
			document.forms[0].hidBeanGetMethod.value="getCaptialMarketInfo";
			document.forms[0].action=appURL+"action/ControllerServlet";	
			document.forms[0].hidSourceUrl.value="/action/com_capitalmarketinfo.jsp";			
			document.forms[0].method="post";			
			document.forms[0].submit();	
		}	
}
function onloading()
{
	disableFields(true);
	if(varStockSE!="")
	{
		document.forms[0].sel_listedinse.value=varStockSE;
	}
	enablestockdetails();
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/corppge.jsp";
		document.forms[0].submit();
	}
}

function callLink(page,bean,method)
{ 
	if (document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidAction.value="";
	 	document.forms[0].hidBeanGetMethod.value=method;
	 	document.forms[0].hidBeanId.value=bean;
	 	document.forms[0].action=appURL+"action/"+page;
	 	document.forms[0].submit();
	}
	else 
	{
		ShowAlert(103);
	}
}

function enablestockdetails()
{
	if(document.forms[0].sel_listedinse.value=="Y")
	{
		document.all.tabid_valuerlist.style.display="table";
		document.all.idSE1.style.display="table-row";
	}
	else
	{
		document.all.tabid_valuerlist.style.display="none";
		document.all.idSE1.style.display="none";
	}
}
function Addvaluer(){

	if(document.forms[0].cmdedit.disabled==true)
	{	
	var tab  = document.getElementById("tabid_valuerlist");
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
					new_RowCell.childNodes[j].readOnly=false;
				}
				if(new_RowCell.childNodes[j].type=="checkbox")
				{
					new_RowCell.childNodes[j].disabled=false;
				}
				if(new_RowCell.childNodes[j].name=="txt_particulars")
				{
					new_RowCell.align="left";
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
	if(document.forms[0].cmdedit.disabled==true)
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
					 if(tabid=="tabid_valuerlist" && rowsLength=="1")
					{
						document.forms[0].txt_domestic.value="";  
						document.forms[0].txt_domesticplace.value="";
						document.forms[0].txt_overseas.value="";  
						document.forms[0].txt_overseasplace.value="";    
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
function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,name);
	}
}
function funShareMovementcmts()
{
	var btnenable=document.forms[0].btnenable.value;
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/comments.jsp?hidBeanId=perfinancial&hidBeanGetMethod=getComments&hidAppNo="+document.forms[0].appno.value+"&hidCommentPage=MovementShares"+"&appstatus="+appstatus+"&btnenable="+btnenable;
	window.open(url,"Comments",prop);
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body onLoad="onloading();">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div></div>
<form name="frmpri" method="post" class="normal">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top"><jsp:include page="../share/applurllinkscom.jsp"
			flush="true">
			<jsp:param name="pageid" value="2" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">
		<%
			if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%> Home -&gt; Agriculture -&gt; Application-&gt;Co-Applicant / Guarantor-&gt;
		Share Holding Pattern <%
 	}else
 	{%>
 		Home -&gt; Corporate &amp; SME -&gt; Application-&gt;Co-Applicant / Guarantor-&gt; Share Holding Pattern 
 	<%}
 %>
		</td>
	</tr>
</table>
<span style="display: none;"><lapschoice:borrowertype /></span> <lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	align="center" class="outertable">
	<tr align="center">
		<td valign="bottom">
		<table border="0" cellspacing="2" cellpadding="3"
			align="left" class="outertable">
			<tr>
				<td class="sub_tab_inactive" id="prin"><b> <a
					href="#" onclick="javascript:callLink('compromoters.jsp','compro','getProData')">Co-Applicant / Guarantor
				</a></b></td>
					<td class="sub_tab_inactive" nowrap="nowrap"><b><b><a href="javascript:callLink('comgroupcompanies.jsp','executive','getData7')">Group
				Concerns</a></b></b></td>
								
				<td class="sub_tab_active" id="prin" nowrap><b>Share Holding Pattern</b></td>
				<td class="sub_tab_inactive" nowrap="nowrap"><b><b><a href="javascript:callLink('com_promocomments.jsp','compro','getgroupcomments')">Comments</a></b></b></td>
				</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="40%" border="0" cellspacing="1" cellpadding="3"
			class="outertable">
			<tr align="center">
			    <td align="center" class="sub_tab_inactive"><a
							href="javascript:callLink('com_shareholdpattern.jsp','executive','getDataShareHoldPattern')"><b>Share Holders</b></a></td>			    
				<td class="sub_tab_inactive" align="center"><a
							href="javascript:callLink('com_natureofshares.jsp','executive','getDataNatureOfShares')"><b>Nature of Shares</b></a></td>
				<td align="center" class="sub_tab_active"><b>Capital Market info</b></td>				
		      
			</tr>
		</table>
		</td>
	</tr>
</table>
<br/>
<table width="60%" border="0" cellspacing="0" cellpadding="3"
	class="outertable" align="center">
	<tr>
		<td>Whether Listed in S.E Quotation Value</td>
		<td><select name="sel_listedinse" onchange="enablestockdetails();">
		<option value=""><--select--></option>
		<option value="Y">Yes</option>
		<option value="N">No</option>
		<option value="NA">Not Applicable</option>
		</select></td>
	</tr>
	<tr id="idSE1">
	<td>Share Quotation Data in BSE and NSE as on </td>
	<td><input type="text" name="txt_date" onBlur="checkDate(this);checkmaxdate(this,currentDate);" value="<%=Helper.correctNull((String)hshValues.get("strShareAson")) %>">&nbsp; <a alt="Select date from calender" href="#"
													onClick="callCalender('txt_date')"
													onMouseOver="window.status='Date Picker';return true;"
													onMouseOut="window.status='';return true;"><img
													src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
													border="0" alt="Select date from calender"></a></td>
	</tr>
</table>

<table width="90%" border="0"   class="outertable"  align="center" cellpadding="3"  id="tabid_valuerlist">
			<tr class="dataheader"  >
						<td width="5%" align="center"><span style=""><a onClick="Addvaluer();"><img
							src="<%=ApplicationParams.getAppUrl()%>img/add.png"
							border="0" tabindex="38"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					 		<a onClick="deleteRow1('tabid_valuerlist','0');"><img
							src="<%=ApplicationParams.getAppUrl()%>img/cancel.png"
							border="0"></a> </span> </td>
						<td width="20%" align="center"> Domestic</td>
						<td  width="20%" align="center"> BSE</td>
						<td  width="20%" align="center"> NSE</td>
				</tr>
				<tr>	
					<td width="5%" class="datagrid"  align="center"><input type="checkbox" name="chk1" style="border: none;" disabled="disabled"></td>	
					<td width="20%" class="datagrid"><input type="text" name="txt_particulars" onkeypress="allowAlphabetsForName()" value="Face Value" size="50"> </td>
					<td width="20%" class="datagrid" align="center"><input type="text" name="txt_BSE" onkeypress="allowNumber(this)"  value="<%=Helper.correctNull((String)hshValues.get("strCapitalBSE1")) %>" style="text-align: right;" onblur="roundtxt(this);"></td>
					<td width="20%" class="datagrid" align="center"><input type="text" name="txt_NSE" onkeypress="allowNumber(this)"  value="<%=Helper.correctNull((String)hshValues.get("strCapitalNSE1")) %>" style="text-align: right;" onblur="roundtxt(this);"></td>
				
				</tr>
				<tr>	
					<td width="5%" class="datagrid"  align="center"><input type="checkbox" name="chk1" style="border: none;" disabled="disabled"></td>	
					<td width="20%" class="datagrid"><input type="text" name="txt_particulars" onkeypress="" value="52 week High" size="50"> </td>
					<td width="20%" class="datagrid" align="center"><input type="text" name="txt_BSE" onkeypress="allowNumber(this)" value="<%=Helper.correctNull((String)hshValues.get("strCapitalBSE2")) %>" style="text-align: right;" onblur="roundtxt(this);"></td>
					<td width="20%" class="datagrid" align="center"><input type="text" name="txt_NSE" onkeypress="allowNumber(this)"  value="<%=Helper.correctNull((String)hshValues.get("strCapitalNSE2")) %>" style="text-align: right;" onblur="roundtxt(this);"></td>
				
				</tr>
				<tr>	
					<td width="5%" class="datagrid"  align="center"><input type="checkbox" name="chk1" style="border: none;" disabled="disabled"></td>	
					<td width="20%" class="datagrid"><input type="text" name="txt_particulars" onkeypress="allowAlphabetsForName()" value="52 Week Low" size="50"> </td>
					<td width="20%" class="datagrid" align="center"><input type="text" name="txt_BSE" onkeypress="allowNumber(this)" value="<%=Helper.correctNull((String)hshValues.get("strCapitalBSE3")) %>" style="text-align: right;" onblur="roundtxt(this);"></td>
					<td width="20%" class="datagrid" align="center"><input type="text" name="txt_NSE" onkeypress="allowNumber(this)" value="<%=Helper.correctNull((String)hshValues.get("strCapitalNSE3")) %>"  style="text-align: right;" onblur="roundtxt(this);"></td>
				
				</tr>
				<tr>	
					<td width="5%" class="datagrid"  align="center"><input type="checkbox" name="chk1" style="border: none;" disabled="disabled"></td>	
					<td width="20%" class="datagrid">As on<input type="text" name="txt_particulars"  value="<%=Helper.correctNull((String)hshValues.get("strCapitalPart4")) %>" onBlur="checkDate(this);checkmaxdate(this,currentDate);">&nbsp; <a alt="Select date from calender" href="#"
													onClick="callCalender('txt_particulars[3]')"
													onMouseOver="window.status='Date Picker';return true;"
													onMouseOut="window.status='';return true;"><img
													src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
													border="0" alt="Select date from calender"></a> </td>
					<td width="20%" class="datagrid" align="center"><input type="text" name="txt_BSE" onkeypress="allowNumber(this)" value="<%=Helper.correctNull((String)hshValues.get("strCapitalBSE4")) %>" style="text-align: right;" onblur="roundtxt(this);"></td>
					<td width="20%" class="datagrid" align="center"><input type="text" name="txt_NSE" onkeypress="allowNumber(this)"  value="<%=Helper.correctNull((String)hshValues.get("strCapitalNSE4")) %>" style="text-align: right;" onblur="roundtxt(this);"></td>
				
				</tr>
				<tr>	
					<td width="5%" class="datagrid"  align="center"><input type="checkbox" name="chk1" style="border: none;" disabled="disabled"></td>	
					<td width="20%" class="datagrid"><input type="text" name="txt_particulars" onkeypress="allowAlphabetsForName()" value="Market Capitalisation" size="50"> </td>
					<td width="20%" class="datagrid" align="center"><input type="text" name="txt_BSE" onkeypress="allowNumber(this)" value="<%=Helper.correctNull((String)hshValues.get("strCapitalBSE5")) %>" style="text-align: right;" onblur="roundtxt(this);"></td>
					<td width="20%" class="datagrid" align="center"><input type="text" name="txt_NSE" onkeypress="allowNumber(this)" value="<%=Helper.correctNull((String)hshValues.get("strCapitalNSE5")) %>"  style="text-align: right;" onblur="roundtxt(this);"></td>
				
				</tr>
				<tr>	
					<td width="5%" class="datagrid"  align="center"><input type="checkbox" name="chk1" style="border: none;" disabled="disabled"></td>	
					<td width="20%" class="datagrid"><input type="text" name="txt_particulars" onkeypress="allowAlphabetsForName()" value="Price to Book ratio" size="50"> </td>
					<td width="20%" class="datagrid" align="center"><input type="text" name="txt_BSE" onkeypress="allowNumber(this)" value="<%=Helper.correctNull((String)hshValues.get("strCapitalBSE6")) %>" style="text-align: right;" onblur="roundtxt(this);"></td>
					<td width="20%" class="datagrid" align="center"><input type="text" name="txt_NSE" onkeypress="allowNumber(this)" value="<%=Helper.correctNull((String)hshValues.get("strCapitalNSE6")) %>"  style="text-align: right;" onblur="roundtxt(this);"></td>
				
				</tr>
				<tr  class="datagrid">
				<td>&nbsp;</td>
				<td colspan="3">Dividend payment for last three Years</td>
				</tr>
				<tr>	
					<td width="5%" class="datagrid"  align="center"><input type="checkbox" name="chk1" style="border: none;" disabled="disabled"></td>	
					<td width="20%" class="datagrid">Year 1 <input type="text" name="txt_particulars" onkeypress="allowWholeNumber(this)" value="<%=Helper.correctNull((String)hshValues.get("strCapitalPart7")) %>" size="8" maxlength="4" onblur="checkcurrentyear(this,'document.forms[0].txt_particulars[6]');"> </td>
					<td width="20%" class="datagrid" align="center"><input type="text" name="txt_BSE" onkeypress="allowNumber(this)" value="<%=Helper.correctNull((String)hshValues.get("strCapitalBSE7")) %>" style="text-align: right;" onblur="roundtxt(this);"></td>
					<td width="20%" class="datagrid" align="center"><input type="text" name="txt_NSE" onkeypress="allowNumber(this)" value="<%=Helper.correctNull((String)hshValues.get("strCapitalNSE7")) %>"  style="text-align: right;" onblur="roundtxt(this);"></td>
				
				</tr>
				<tr>	
					<td width="5%" class="datagrid"  align="center"><input type="checkbox" name="chk1" style="border: none;" disabled="disabled"></td>	
					<td width="20%" class="datagrid">Year 2 <input type="text" name="txt_particulars" onkeypress="allowWholeNumber(this)" value="<%=Helper.correctNull((String)hshValues.get("strCapitalPart8")) %>" size="8" maxlength="4" onblur="checkcurrentyear(this,'document.forms[0].txt_particulars[7]');"> </td>
					<td width="20%" class="datagrid" align="center"><input type="text" name="txt_BSE" onkeypress="allowNumber(this)" value="<%=Helper.correctNull((String)hshValues.get("strCapitalBSE8")) %>" style="text-align: right;" onblur="roundtxt(this);"></td>
					<td width="20%" class="datagrid" align="center"><input type="text" name="txt_NSE" onkeypress="allowNumber(this)" value="<%=Helper.correctNull((String)hshValues.get("strCapitalNSE8")) %>"  style="text-align: right;" onblur="roundtxt(this);"></td>
				
				</tr>
				<tr>	
					<td width="5%" class="datagrid"  align="center"><input type="checkbox" name="chk1" style="border: none;" disabled="disabled"></td>	
					<td width="20%" class="datagrid">Year 3 <input type="text" name="txt_particulars" onkeypress="allowWholeNumber(this)" value="<%=Helper.correctNull((String)hshValues.get("strCapitalPart9")) %>" size="8" maxlength="4" onblur="checkcurrentyear(this,'document.forms[0].txt_particulars[8]');"> </td>
					<td width="20%" class="datagrid" align="center"><input type="text" name="txt_BSE" onkeypress="allowNumber(this)" value="<%=Helper.correctNull((String)hshValues.get("strCapitalBSE9")) %>" style="text-align: right;" onblur="roundtxt(this);"></td>
					<td width="20%" class="datagrid" align="center"><input type="text" name="txt_NSE" onkeypress="allowNumber(this)"  value="<%=Helper.correctNull((String)hshValues.get("strCapitalNSE9")) %>" style="text-align: right;" onblur="roundtxt(this);"></td>
				
				</tr>
			 <%if(arrRow!=null && arrRow.size()>0){ 
					for(int i=0;i<arrRow.size();i++){
					arrCol=(ArrayList)arrRow.get(i);%>
				<tr id="0">	
					<td width="5%" class="datagrid"  align="center"><input type="checkbox" name="chk1" style="border: none;"></td>	
					<td width="20%" class="datagrid"><input type="text" name="txt_particulars" onkeypress="allowAlphabetsForName()" size="50" value="<%=Helper.correctNull((String)arrCol.get(0)) %>"> </td>
					<td width="20%" class="datagrid" align="center"><input type="text" name="txt_BSE" onkeypress="allowNumber(this)" value="<%=Helper.correctNull((String)arrCol.get(1)) %>" style="text-align: right;" onblur="roundtxt(this);"></td>
					<td width="20%" class="datagrid" align="center"><input type="text" name="txt_NSE" onkeypress="allowNumber(this)" value="<%=Helper.correctNull((String)arrCol.get(2)) %>"  style="text-align: right;" onblur="roundtxt(this);"></td>
				
				</tr>
				<%}} %>
				
</table>


<lapschoice:combuttonnew btnnames='Edit_Save_Delete_Cancel'  
						btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>

<br/>
<table width="100%" align="center" border="0" cellpadding="2" cellspacing="0">
	<tr>
	
		<td align="center">
		<input type="button" name="cmdsharecmts" class="buttonstyle" 
		value="Comments on Large Movement of Shares" onClick="funShareMovementcmts()">
		</td>
		
		
	</tr>
</table>
	<lapschoice:hiddentag pageid='<%=PageId%>'/> 
</form>
</body>
</html>