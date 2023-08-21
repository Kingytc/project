<%@include file="../share/directives.jsp"%>
<%ArrayList vecRow = (ArrayList) hshValues.get("vecRow");
ArrayList vecCol = new ArrayList();%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";

function call_page(url)
{
	document.location=appURL+"action/"+url;
}
function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdnew.disabled =false;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;		 
	}
	
	if(val=="edit")
	{	 
		 document.forms[0].cmdnew.disabled =true;
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=true;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}
	if(val=="radioselect")
	{	 
		document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=false;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=false;
		document.forms[0].cmdclose.disabled=false;
	}	
}	
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		
		document.forms[0].hidSourceUrl.value="/action/Realisible_value.jsp";
		document.forms[0].hidBeanId.value="npasetup";
		document.forms[0].hidBeanGetMethod.value="getRealisible";
		document.forms[0].hidBeanMethod.value="getRealisible";
		document.forms[0].action=appURL +"controllerservlet";
		document.forms[0].submit(); 
	}	
	disableCommandButtons("load");
}
function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");	
}

function doNew()
{	
	disableFields(false);
	disableCommandButtons("edit");
	document.forms[0].hidAction.value ="insert";
	document.forms[0].txt_minpercentage.value="";
	document.forms[0].txt_maxpercentage.value="";
	document.forms[0].txt_points.value="";
	 for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='radio')
	 	{
			document.forms[0].elements[i].checked=false;
		}	  
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
		if(document.forms[0].elements[i].type=='radio')
	 	{
	 		document.forms[0].elements[i].disabled=(!val);
		}	 
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
	}
}
function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if (ConfirmMsg("101"))
		{
			document.forms[0].hidAction.value="Delete";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].hidBeanId.value="npasetup";
			document.forms[0].hidSourceUrl.value="/action/Realisible_value.jsp";
			document.forms[0].hidBeanMethod.value="updateRealisible";
			document.forms[0].hidBeanGetMethod.value="getRealisible";	
			document.forms[0].submit();
		}
	}
	else
	{
		ShowAlert(158);
	}
}
function selectValues(val1,val2,val3,val4,val5)
{	
	 document.forms[0].hidRealisible_ID.value=val1;
	 document.forms[0].sel_marketability.value=val2;
	 document.forms[0].txt_minpercentage.value=val3;
	 document.forms[0].txt_maxpercentage.value=val4;
	 document.forms[0].txt_points.value=val5;
	 disableCommandButtons("radioselect");	
}
function placevalues()
{	
	disableFields(true);
	document.forms[0].sel_marketability.value="0";
	document.forms[0].txt_minpercentage.value="";
	document.forms[0].txt_maxpercentage.value="";
	document.forms[0].txt_points.value="";
	disableCommandButtons("load");
	
}
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
	if(trim(document.forms[0].sel_marketability.value)=="0" )
	{
		alert("Select Marketability of Security");
			document.forms[0].sel_marketability.focus();
			return;
	}

	if(trim(document.forms[0].txt_minpercentage.value)=="" )
	{
		alert("Enter Minimum Percentage");
			document.forms[0].txt_minpercentage.focus();
			return;
	}
	
	if(trim(document.forms[0].txt_maxpercentage.value)=="")
	{
		alert("Enter Maximum Percentage");
 		document.forms[0].txt_maxpercentage.focus();
 		return;
	}
	
	
	if(eval(document.forms[0].txt_minpercentage.value)>eval(document.forms[0].txt_maxpercentage.value))
	{
		ShowAlert(115,"Maximum Percentage","Minimum Percentage");
		document.forms[0].txt_maxpercentage.value="";
		document.forms[0].txt_maxpercentage.focus();
		return;
	}
	
	var len = document.forms[0].sel_marketability.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_marketability.options[i].selected==true)
		 {
			 document.forms[0].sel_marketability1.value = document.forms[0].sel_marketability.options[i].text; 
			break;
		 }
	}	
	document.forms[0].hidRecordflag.value=varRecordFlag;
	document.forms[0].hidSourceUrl.value="/action/Realisible_value.jsp";
	document.forms[0].hidBeanId.value="npasetup";
	document.forms[0].hidBeanMethod.value="updateRealisible";
	document.forms[0].hidBeanGetMethod.value="getRealisible";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();	
}
function callValues()
{
	if(!document.forms[0].cmdnew.disabled){
	document.forms[0].hidRealisible_ID.value = document.forms[0].sel_marketability.value;
	document.forms[0].hidBeanId.value="npasetup";
	document.forms[0].hidBeanGetMethod.value="getRealisible";
	document.forms[0].action=appURL+"action/Realisible_value.jsp";
	//document.forms[0].hidSourceUrl.value="/action/Realisible_value.jsp";
	document.forms[0].submit();
	}	
}
</script>
</head>
<body onload="placevalues()">
<form name="realisible_means" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>		
      <td class="page_flow">Home -&gt; Setup -&gt; NPA -&gt; Realisible values</td>
	</tr>
</table><br>
<table width="75%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" class="outertable border1" cellspacing="0" cellpadding="0" 	align="center" onload="placevalues()">
			<tr>
				<td>
					<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr class="dataheader">
				<td colspan="3" align="center"><b>Realisible Value of Security</b></td>
			</tr>
			<tr>
				<td width="11%" height="30" align="center">1</td>
				<td width="54%" height="30">Marketability of Security</td>
				<td width="35%" height="30"><select name="sel_marketability"
					tabindex="1" onChange="callValues()">
					<option value="0">--select--</option>
					<%String apptype = "28";%>
					<lapschoice:StaticDataNewTag apptype='<%=apptype%>' />
				</select></td>
			</tr>
			<tr>
				<td width="11%" height="35" align="center">2</td>
				<td width="54%" height="35">Minimum Percentage of Crystallised dues</td>
				<td width="35%" height="35"><input type="text" name="txt_minpercentage"
					value="<%=Helper.correctNull((String)hshValues.get("min_percentage"))%>"
					size="5" maxlength="3" style="text-align:left;border-style=groove"
					onKeyPress="allowDecimals(this)"></td>
			</tr>
			<tr>
				<td height="33" align="center" width="11%">3</td>
				<td height="33" width="54%">Maximum Percentage of Crystallised dues</td>
				<td width="35%" height="33"><input type="text" name="txt_maxpercentage"
					value="<%=Helper.correctNull((String)hshValues.get("max_percentage"))%>"
					size="5" maxlength="3" style="text-align:left;border-style=groove"
					onKeyPress="allowDecimals(this)"></td>
			</tr>
			<tr>
				<td height="33" align="center" width="11%">4</td>
				<td height="33" width="54%">Points to be given</td>
				<td width="35%" height="33"><input type="text" name="txt_points"
					value="<%=Helper.correctNull((String)hshValues.get("points"))%>"
					size="5" maxlength="3" style="text-align:left;border-style=groove"
					onKeyPress="allowDecimals(this)"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</td>
</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br>
<table width="70%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="2" align="center" class="outertable linebor">
			<tr class="dataheader">
				<td width="4%"></td>
				<td width="24%" align="center">Marketability of Security</td>
				<td width="29%" align="center">Min. Percentage of Crystallised Dues</td>
				<td width="30%" align="center">Max. Percentage of Crystallised Dues </td>
				<td align="center" colspan="2" width="13%">Points</td>
			</tr>
			<%if (vecRow != null && vecRow.size() > 0) {
				for (int i = 0; i < vecRow.size(); i++) {
					vecCol = (ArrayList) vecRow.get(i);%>
			<tr class="datagrid">
				<td width="4%"> <input type="radio" style="border:none" name="radiobutton" value="radiobutton"
					onClick="selectValues('<%=Helper.correctNull((String)vecCol.get(0))%>',
													'<%=Helper.correctNull((String)vecCol.get(1))%>','<%=Helper.correctNull((String)vecCol.get(2))%>'
                            	,'<%=Helper.correctDouble((String)vecCol.get(3))%>','<%=Helper.correctDouble((String)vecCol.get(4))%>')">
				</td>
				<td width="24%" align="center"><%=Helper.correctNull((String) vecCol.get(5))%></td>
				<td width="29%" align="center"><%=Helper.correctNull((String) vecCol.get(2))%></td>
				<td width="30%" align="center"><%=Helper.correctNull((String) vecCol.get(3))%></td>
				<td align="center" colspan="2" width="13%"><%=Helper.correctNull((String) vecCol.get(4))%></td>
			</tr>
			<%}} else {%>
			<tr class="datagrid">
				<td align="center" colspan="6">No Data Found</td>
			</tr>
			<%}%>
		</table>
		</td>
	</tr>
</table>
  <lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="sel_marketability1" />
 <input type="hidden" name="hidRealisible_ID" value="" />
 <input type ="hidden" name ="hidkeyid" value="set">
 </form>
</body>
</html>
