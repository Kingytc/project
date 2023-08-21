<%@include file="../share/directives.jsp"%>
<%ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();
if(hshValues!=null)
{
	arrRow=(ArrayList)hshValues.get("arrRow");
}
String strRRM = Helper.correctNull((String)session.getAttribute("RRM"));
%>
<html>
<head>
<title>MCLR Master</title>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function doClose()
{
	
	
	if(ConfirmMsg(100))
	{
		
		<%if(strRRM.equalsIgnoreCase("Y")){%>
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/mainnav.jsp";
		<%} else{%>
		document.forms[0].action=appURL+"action/setupnav.jsp";
		<%}%>
		document.forms[0].submit();
	}
	
}
function doSave()
{
	if(document.forms[0].sel_referencetype.value=="")
	{
		ShowAlert('111',"Reference Type");
		document.forms[0].sel_referencetype.focus();
		return;
	}
	if(document.forms[0].txt_spreadvalue.value=="")
	{
		ShowAlert('121',"Reference Spread Value");
	 	document.forms[0].txt_spreadvalue.focus();
	 	return;
	}
	if(document.forms[0].txt_tablecodeforoverdraft.value=="")
	{
		ShowAlert('121',"Table Code For Loan");
	 	document.forms[0].txt_tablecodeforoverdraft.focus();
	 	return;
	}
	if(document.forms[0].txt_overdraft.value=="")
	{
		ShowAlert('121',"Table Code For over Draft");
	 	document.forms[0].txt_overdraft.focus();
	 	return;
	}
	if(document.forms[0].txt_effectivefrom.value=="")
	{
		ShowAlert('111',"Effect From Date");
		document.forms[0].txt_effectivefrom.focus();
		return;
	}
	if(document.forms[0].hidAction.value=="update")
	{
		if((document.forms[0].hid_spreadvalue.value!=document.forms[0].txt_spreadvalue.value)&& document.forms[0].hideffectivedate.value!="" && document.forms[0].txt_effectivefrom.value==document.forms[0].hideffectivedate.value)
		{
			if(confirm("Effective Date is "+document.forms[0].txt_effectivefrom.value+".If you want to change click Ok"))
			{
				document.forms[0].txt_effectivefrom.value="";
				document.forms[0].hideffectivedate.value="";
				return;
			}
		}
		
		if(document.forms[0].txt_overdraft.value!="NMD07" && document.forms[0].txt_overdraft.value!="NMD14" && document.forms[0].txt_overdraft.value!="NMM01"
				&& document.forms[0].txt_overdraft.value!="NMD02" && document.forms[0].txt_overdraft.value!="NMM03" )
			{
		if(!ConfirmMsg(199))
			return;
			}
	}
	showProgress('imgloading');
	document.forms[0].cmdsave.disabled=true;
	disablefields(false);
	document.forms[0].hidBeanId.value="setinterest";
	document.forms[0].hidBeanMethod.value="updateMCLRMaster";
	document.forms[0].hidBeanGetMethod.value="getMCLRMaster";
	document.forms[0].hidSourceUrl.value="/action/setMCLRMaster.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doEdit()
{
	document.forms[0].hidAction.value="update";
	document.all.idcalender.style.display="inline";
	callDisableControls(true,true,false,false,false);
	disablefields(false);
	document.forms[0].sel_referencetype.disabled=true;
}
function doNew()
{
	document.forms[0].hidAction.value="insert";
	document.all.idcalender.style.display="inline";
	callDisableControls(true,true,false,false,false);
	disablefields(false);
}
function doCancel()
{
	document.forms[0].hidBeanId.value="setinterest";
	document.forms[0].hidBeanGetMethod.value="getMCLRMaster";
	document.forms[0].action=appURL+"action/setMCLRMaster.jsp";
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
	<%if(!strRRM.equalsIgnoreCase("Y")){%>
	callDisableControls(false,true,true,true,false);
	<%}else{%>
	callDisableControls(true,true,true,true,false);
	<%}%>
	disablefields(true);
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
function selectValues(val1,val2,val3,val4,val5,val6,val7,val8)
{
	document.all.idcalender.style.display="inline";
	document.forms[0].hidsno.value=val1;
	document.forms[0].sel_referencetype.value=val2;
	document.forms[0].txt_spreadvalue.value=val3;
	document.forms[0].txt_tablecodeforoverdraft.value=val4;
	document.forms[0].txt_overdraft.value=val5;
	document.forms[0].hid_spreadvalue.value=val3;
	document.forms[0].hid_tablecodeforoverdraft.value=val4;
	document.forms[0].hid_overdraft.value=val5;
	document.forms[0].txt_effectivefrom.value=val6;
	document.forms[0].hideffectivedate.value=val6;
	document.forms[0].sel_mclr_active.value=val8;
	<%if(!strRRM.equalsIgnoreCase("Y")){%>
	callDisableControls(true,false,true,true,false);
	<%}else{%>
	callDisableControls(true,true,true,true,false);
	<%}%>
	disablefields(true);
}
function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,name);
	}
}
function ROITypeChk()
{
	if(document.forms[0].hidAction.value=="insert")
	{
	<%
	if(arrRow!=null && arrRow.size()>0)
	{
		for(int i=0;i<arrRow.size();i++)
		{
			arrCol=(ArrayList)arrRow.get(i);
			String strRefType=Helper.correctNull((String)arrCol.get(1));
			%>
			
			if(document.forms[0].sel_referencetype.value=='<%=strRefType%>')
			{
				alert("Reference Type is already defined in Reference Rate Master, Kindly Modify the defined Reference Rate");
				document.forms[0].sel_referencetype.value="";
				return;
			}
		
	<%}}%>
	}
}
function chkmibor(num) {
	if(num.value!="")
		{
		if(parseFloat(num.value)<=0)
		{
			alert("number should more than 0");
			num.focus();
			num.value = "";
			return false;
		}
		else
			{
	var test= num.value;
	  var s = test.split('.');
	  if (s[0].length > 2) {
		  alert("only two digits");
		  num.focus();
		  num.value = "";
		  return false;
	  }
	  if (s[1].length > 2) {
		  alert("only two digits");
		  num.focus();
		  num.value = "";
		  return false;
	  }
			}
		}
	}
	
	
function doExcelUpload()
	{
	        var pagefield="excel";
			var varQryString = appURL+"action/fbilexcelupload.jsp";
			var title = "excel";
			var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
			var xpos = (screen.width - 350) / 2;
			var ypos = (screen.height - 120) / 2;
			prop = prop + ",left=50,top=50";
			window.open(varQryString,title,prop);
	}
	function doExcelDownload()
	{
		var FileName="excelforfbill_";
		var qryString=appURL+"action/"+FileName+".xlsx?hidBeanId=excelfunction&hidBeanGetMethod=dodownloadxslforfbill";
		var prop="scrollbars=yes,menubar=yes,width=20, height=20";
		window.open(qryString,"NPAprovisioning",prop);
	}
</SCRIPT>
</head>
<body onload="callOnLoad();">
<div id='imgloading' style="display:none;">
<img src="<%=ApplicationParams.getAppUrl()%>img/processing2.gif"></div>

<form method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<%if(strRRM.equalsIgnoreCase("Y")){%>
	<tr>
		<td class="page_flow">Home -&gt; MCLR Master</td>
	</tr>
	<%}else{ %>
	<tr>
		<td class="page_flow">Home -&gt; Setup -&gt; MCLR Master</td>
	</tr>
	<%} %>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable">
	<tr>
		<td valign="top">
		<br/>
		<table width="50%" border="0" cellspacing="0" cellpadding="3"
			class="outertable border1 tableBg" align="center">
			<tr>
			<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
			class="outertable" align="center">
			<tr>
			<td colspan="2" class="dataheader" align="center"> Reference Rate Master</td>
			</tr>
			<tr>
			<td width="20%"> Reference Type</td>
			<td width="40%"> 
				<select name="sel_referencetype" onChange="ROITypeChk()">
				<option value=""> <-- select --></option>
				<lapschoice:CBSStaticDataNewTag apptype="34" />
				</select>
			</td>
			</tr>
			<tr>
			<td> Reference Spread Value</td>
			<td><input type="text" name="txt_spreadvalue" onBlur="checkPercentage(this);chkmibor(this);" onkeypress="allowNegativeNumber(this);" style="text-align: right;"/>&nbsp;<input type="hidden" name="hidsno"></td>
			</tr>
			<tr>
			<td> Table Code For Loans</td>
			<td><input type="text" name="txt_tablecodeforoverdraft"  onkeypress="allowAlphaNumeric();" maxlength="20"></td>
			</tr>
			<tr>
			<td>Table Code For OverDraft</td>
			<td><input type="text" name="txt_overdraft" maxlength="30"></td>
			</tr>
			<tr>
			<td>Effective From</td>
			<td><input type="text" name="txt_effectivefrom" onblur="checkDate(this);checkmindate(this,currentDate);"> &nbsp; <span id="idcalender"><a alt="Select date from calender" href="#"
																	onClick="callCalender('txt_effectivefrom')"
																	onMouseOver="window.status='Date Picker';return true;"
																	onMouseOut="window.status='';return true;"><img
																	src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
																	border="0" alt="Select date from calender"
																	></a></span></td>
			</tr>
			<tr>
			<td>Available</td>
			<td> 
				<select name="sel_mclr_active">
				<option value="Y">Yes</option>
				<option value="N">No</option>
				</select>
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
	<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Excel upload_Excel download'
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
	</table>
	</td>
	</tr>
</table>

<br>

<table width="80%" border="0" cellspacing="1" cellpadding="3"
			class="outertable" align="center">
			<tr class="dataheader" align="center">
				<td width="2%"> &nbsp;</td> 
				<td width="18%"> Reference Type</td>
				<td width="20%"> Reference Spread Value</td>
				<td width="20%"> Table Code For Loan</td>
				<td width="20%"> Table Code For OverDraft</td>
				<td width="20%"> Effective From</td>
				<td width="20%"> Available</td>
			</tr>
			<%if(arrRow!=null && arrRow.size()>0)
				{
				for(int i=0;i<arrRow.size();i++)
				{
					arrCol=(ArrayList)arrRow.get(i);
				%>
				<tr class="datagrid">
				<td align="center"><input type="radio" name="sno" style="border-style: none" onclick="selectValues('<%=Helper.correctNull((String)arrCol.get(0)) %>',
				'<%=Helper.correctNull((String)arrCol.get(1)) %>','<%=Helper.correctNull((String)arrCol.get(2)) %>',
				'<%=Helper.correctNull((String)arrCol.get(3)) %>','<%=Helper.correctNull((String)arrCol.get(7))%>',
				'<%=Helper.correctNull((String)arrCol.get(4)) %>','<%=Helper.correctNull((String)arrCol.get(5))%>','<%=Helper.correctNull((String)arrCol.get(6))%>');"></td>
				
				<td><%=Helper.correctNull((String)arrCol.get(5)) %> &nbsp;</td>
				<td align="center"><%=Helper.correctNull((String)arrCol.get(2)) %> &nbsp;</td>
				<td><%=Helper.correctNull((String)arrCol.get(3)) %> &nbsp;</td>
				<td align="center"><%=Helper.correctNull((String)arrCol.get(7)) %> &nbsp;</td>
				<td align="center"><%=Helper.correctNull((String)arrCol.get(4)) %> &nbsp;</td>
				<%if(Helper.correctNull((String)arrCol.get(6)).equalsIgnoreCase("Y")){ %>
				<td align="center">Yes</td>
				<%}else{ %>
				<td align="center">No</td>
				<%} %>
				</tr>
				<%}}else{ 
				for(int i=0;i<4;i++){%>
				<%if(i==2){ %>
				<tr class="datagrid">
				<td colspan="5" align="center">-- No Record Found --</td>
				<%} %>
				<tr class="datagrid">
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				</tr>
				
				<%}}%>
	</table>
		<input type="hidden" name="hid_spreadvalue">
		<input type="hidden" name="hid_tablecodeforoverdraft">
		<input type="hidden" name="hid_overdraft">
		<input type="hidden" name="hideffectivedate">
<lapschoice:hiddentag pageid='<%=PageId%>' /></form>
</body>
</html>

