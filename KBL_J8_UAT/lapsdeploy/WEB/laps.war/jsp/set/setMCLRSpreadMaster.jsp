<%@include file="../share/directives.jsp"%>
<%
String strspreadtype="",strspreadoption="",strspreadvalue="",strspreadcaption="";
strspreadtype=Helper.correctNull((String)hshValues.get("strspreadtype"));
strspreadoption=Helper.correctNull((String)hshValues.get("strspreadoption"));
strspreadcaption=Helper.correctNull((String)hshValues.get("strspreadcaption"));
strspreadvalue=Helper.correctNull((String)hshValues.get("strspreadvalue"));
String strLevel=Helper.correctNull((String)hshValues.get("strLevel"));
%>
<html>
<head>
<title>MCLR Spread Master</title>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varspreadType="<%=strspreadtype%>";
var varspreadoption="<%=strspreadoption%>";
var varspreadcaption="<%=strspreadcaption%>";
var varActiveFlag="<%=Helper.correctNull((String)hshValues.get("strActiveFlag"))%>";

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
	if(document.forms[0].hidLevel.value!="" && document.forms[0].hidLevel.value!="SO")
	{
		if(document.forms[0].txtvalue.value=="")
		{
			alert("Please Enter the description");
			document.forms[0].txtvalue.focus();
			return;
		}
	}
	if(document.forms[0].hidLevel.value=="SO")
	{
		if(document.forms[0].txt_spreadvalue.value=="")
		{
			alert("Please Enter the spread value");
			document.forms[0].txt_spreadvalue.focus();
			return;
		}	
	}
	document.forms[0].cmdsave.disabled=true;
	disablefields(false);
	document.forms[0].hidBeanId.value="setinterest";
	document.forms[0].hidBeanMethod.value="updateMCLRSpreadMaster";
	document.forms[0].hidBeanGetMethod.value="getMCLRSpreadMaster";
	document.forms[0].hidSourceUrl.value="/action/setMCLRSpreadMaster.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doEdit()
{
	document.all.iddescription.style.display="inline";
	document.all.iddesc.innerText="Description";
	document.forms[0].hidAction.value="update";
	callDisableControls(true,true,false,false,false);
	disablefields(true);
	if(document.forms[0].hidLevel.value=="" || document.forms[0].hidLevel.value=="SO")
	{
		document.all.iddesc.innerText="Spread Option Description";
	}
	if(document.forms[0].hidLevel.value=="SC" || document.forms[0].hidLevel.value=="SO")
	{
		document.all.idactive.style.display="inline";
		document.forms[0].sel_active.disabled=false;
	}
	document.forms[0].txt_spreadvalue.readOnly=false;
	document.forms[0].txtvalue.readOnly=false;
}
function doNew()
{
	document.forms[0].hidAction.value="insert";
	callDisableControls(true,true,false,false,false);
	disablefields(false);
	document.all.iddescription.style.display="inline";
	disablefields(true);
	if(document.forms[0].hidLevel.value=="" || document.forms[0].hidLevel.value=="SO")
	{
		document.forms[0].txt_spreadvalue.readOnly=false;
		document.all.iddescription.style.display="none";
	}
	document.forms[0].txtvalue.value="";
	document.forms[0].txtvalue.readOnly=false;
	document.forms[0].sel_active.disabled=false;
}
function doCancel()
{
	disablefields(false);
	document.forms[0].hidAction.value="";
	document.forms[0].hidBeanId.value="setinterest";
	document.forms[0].hidBeanGetMethod.value="getMCLRSpreadMaster";
	document.forms[0].action=appURL+"action/setMCLRSpreadMaster.jsp";
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

	if(varspreadType!="")
	{
		document.forms[0].sel_spreadtype.value=varspreadType;
	}
	else
	{
		document.forms[0].sel_spreadtype.value="0-0";
	}
	if(varspreadcaption!="")
	{
		document.forms[0].sel_spreadcaption.value=varspreadcaption;
	}
	else
	{
		document.forms[0].sel_spreadcaption.value="-";
	}
	if(varspreadoption!="")
	{
		document.forms[0].sel_spreadoption.value=varspreadoption;
	}
	else
	{
		document.forms[0].sel_spreadoption.value="-";
	}
	if(varActiveFlag!="")
	{
		document.forms[0].sel_active.value=varActiveFlag;
	}
	else
	{
		document.forms[0].sel_active.value="N";
	}
	if(document.forms[0].hidLevel.value=="SC" || document.forms[0].hidLevel.value=="SO")
	{
		document.all.idactive.style.display="inline";
	}
	disablefields(true);
	document.forms[0].sel_spreadtype.disabled=false;
	if(document.forms[0].sel_spreadtype.value!="0-0" && document.forms[0].sel_spreadtype.value!="")
	{
		document.all.idspreadcaption.style.display="inline";
		document.forms[0].sel_spreadcaption.disabled=false;

		if(document.forms[0].sel_spreadcaption.value!="-")
		{
			document.all.idspreadoption.style.display="inline";
			document.forms[0].sel_spreadoption.disabled=false;

			if(document.forms[0].sel_spreadoption.value!="-")
			{
				document.all.idspreadvalue.style.display="inline";
				if(document.forms[0].txt_spreadvalue.value=="")
				{
					callDisableControls(false,true,true,true,false);
				}
				else
				{
					callDisableControls(true,false,true,true,false);
				}
			}
			else
			{
				document.all.idspreadvalue.style.display="none";
				callDisableControls(false,false,true,true,false);
			}
		}
		else
		{
			document.all.idspreadoption.style.display="none";
			document.all.idspreadvalue.style.display="none";
		}
	}
	else
	{
		document.all.idspreadcaption.style.display="none";
		document.all.idspreadoption.style.display="none";
		document.all.idspreadvalue.style.display="none";
	}

	
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
function callspreadfunction1()
{
	if(document.forms[0].sel_spreadtype.value=="0-0")
	{
		alert("select spread type");
		document.forms[0].sel_spreadcaption.value="-";
		document.forms[0].sel_spreadoption.value="-";
		document.forms[0].txt_spreadvalue.value="";
		document.forms[0].sel_spreadtype.focus();
		return;
	}
		disablefields(false);
		document.forms[0].sel_spreadcaption.value="-";
		document.forms[0].sel_spreadoption.value="-";
		document.forms[0].txt_spreadvalue.value="";
		document.forms[0].hidAction.value="getcaption";
		document.forms[0].hidBeanId.value="setinterest";
		document.forms[0].hidBeanGetMethod.value="getMCLRSpreadMaster";
		document.forms[0].action=appURL+"action/setMCLRSpreadMaster.jsp";
		document.forms[0].submit();
}
function callspreadfunction2()
{
	if(document.forms[0].sel_spreadcaption.value=="-")
	{
		alert("select spread caption");
		document.forms[0].sel_spreadoption.value="-";
		document.forms[0].txt_spreadvalue.value="";
		document.forms[0].sel_spreadcaption.focus();
		
		return;
	}
		disablefields(false);
		document.forms[0].sel_spreadoption.value="-";
		document.forms[0].txt_spreadvalue.value="";
		document.forms[0].hidAction.value="getoption";
		document.forms[0].hidBeanId.value="setinterest";
		document.forms[0].hidBeanGetMethod.value="getMCLRSpreadMaster";
		document.forms[0].action=appURL+"action/setMCLRSpreadMaster.jsp";
		document.forms[0].submit();
}
function callspreadfunction3()
{
	if(document.forms[0].sel_spreadoption.value=="-")
	{
		alert("select spread option");
		document.forms[0].txt_spreadvalue.value="";
		document.forms[0].sel_spreadoption.focus();
		return;
		
	}
	disablefields(false);
	document.forms[0].txt_spreadvalue.value="";
	document.forms[0].hidAction.value="getvalue";
	document.forms[0].hidBeanId.value="setinterest";
	document.forms[0].hidBeanGetMethod.value="getMCLRSpreadMaster";
	document.forms[0].action=appURL+"action/setMCLRSpreadMaster.jsp";
	document.forms[0].submit();
}
</SCRIPT>
</head>
<body onload="callOnLoad();">
<form method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Setup -&gt; Corp &amp; Agri -  MCLR Spread Master</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable">
	<tr>
		<td valign="top">
		<br/>
		<table width="70%" border="0" cellspacing="0" cellpadding="3"
			class="outertable border1 tableBg" align="center">
			<tr>
			<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
			class="outertable" align="center">
			<tr>
			<td colspan="2" class="dataheader" align="center"> Interest Spread Master</td>
			</tr>
			<tr>
			<td width="30%"> Spread Type</td>
			<td width="40%"> 
				<select name="sel_spreadtype" onchange="callspreadfunction1();">
				<option value="0-0"><-- select --></option>
				<lapschoice:StaticDataTag apptype="224" tagType="child"/>
				</select>
			</td>
			</tr>
			<tr id="idspreadcaption">
			<td> Spread Captions</td>
			<td> 
				<select name="sel_spreadcaption"  onchange="callspreadfunction2();">
				<option value="-"> <-- select --></option>
				<lapschoice:MCLRMaster value='<%=strspreadtype%>' />
				</select>
			</td>
			</tr>
			<tr id="idspreadoption">
			<td> Spread Options</td>
			<td> 
				<select name="sel_spreadoption"  onchange="callspreadfunction3();">
				<option value="-"> <-- select --></option>
				<lapschoice:MCLRMaster value='<%=strspreadcaption%>' />
				</select>
			</td>
			</tr>
			<tr id="idspreadvalue">
			<td> Spread Value</td>
			<td> 
				<input type="text" name="txt_spreadvalue"  value='<%=strspreadvalue %>'  onBlur="checkPercentage(this);" onkeypress="allowNegativeNumber(this);" style="text-align: right;" size="7"/>
			</td>
			</tr>
			<tr id="idactive" style="display: none;">
			<td>Active Flag</td>
			<td> 
				<select name="sel_active">
				<option value="Y"> Yes</option>
				<option value="N"> No</option>
				</select>
			</td>
			</tr>
			<tr id="iddescription" style="display: none;">
			<td><span id="iddesc"> Description</span></td>
			<td> 
				<input type="text" name="txtvalue" size="75" maxlength="75" value="<%=Helper.correctNull((String)hshValues.get("strDescription")) %>">
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
	<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
	</table>
	</td>
	</tr>
</table>

<br>
<input type="hidden" name="hidLevel" value="<%=strLevel %>">
<lapschoice:hiddentag pageid='<%=PageId%>' /></form>
</body>
</html>

