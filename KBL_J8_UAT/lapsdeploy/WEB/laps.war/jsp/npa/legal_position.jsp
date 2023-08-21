<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>

var varlegalposition="<%=Helper.correctNull((String)hshValues.get("legalposition"))%>";
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
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;	
	}
	
	if(val=="edit")
	{	 
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=false;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	
		 disableFields(false);
	}
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidSourceUrl.value="/action/legal_position.jsp";
		document.forms[0].hidBeanId.value="npasetup";
		document.forms[0].hidBeanGetMethod.value="getLegalPosition";
		document.forms[0].action=appURL +"controllerservlet";
		document.forms[0].submit(); 
	}	
}
function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");	
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
	}
}
function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if (ConfirmMsg("101"))
		{
			document.forms[0].hidAction.value="Delete";
			document.forms[0].hidSourceUrl.value="/action/legal_position.jsp";
			document.forms[0].hidBeanId.value="npasetup";
			document.forms[0].hidBeanMethod.value="updateLegalPosition";
			document.forms[0].hidBeanGetMethod.value="getLegalPosition";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].submit();
		}
	}
	else
	{
		ShowAlert(158);
	}
}

function placevalues()
{
	if(varlegalposition!="")
	{
		document.forms[0].sel_legalposition.value=varlegalposition;
	}
	disableCommandButtons("load");
}
function doClose()
{
	if (ConfirmMsg(100))
	{
		call_page('setupnav.jsp');
	}	
}
function doSave()
{
	if(document.forms[0].sel_legalposition.value=="0")
	{
		alert("Select Legal Position");
		return;
	}
	if(document.forms[0].txt_points.value=="")
	{
		alert("Enter Points");
		return;
	}
	var len = document.forms[0].sel_legalposition.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_legalposition.options[i].selected==true)
		 {
			 document.forms[0].sel_legalposition1.value = document.forms[0].sel_legalposition.options[i].text; 
			  break;
		 }
	}	
	document.forms[0].hidRecordflag.value=varRecordFlag;	
	document.forms[0].hidSourceUrl.value="/action/legal_position.jsp";
	document.forms[0].hidBeanId.value="npasetup";
	document.forms[0].hidBeanMethod.value="updateLegalPosition";
	document.forms[0].hidBeanGetMethod.value="getLegalPosition";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();	
}
function getpoints()
{
	//document.forms[0].hidSourceUrl.value="/action/legal_position.jsp";
	document.forms[0].hidBeanId.value="npasetup";
	document.forms[0].hidBeanGetMethod.value="getLegalPosition";
	document.forms[0].action=appURL+"action/legal_position.jsp";
	document.forms[0].submit();
}
</script>
</head>
<body onload="placevalues()">
<form name="realisible_means" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>		
      <td class="page_flow">Home -&gt; Setup -&gt; NPA -&gt; Legal Position</td>
	</tr>
</table>
<br>
<br>
<table width="50%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable border1">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
          <tr class="dataheader">
				<td colspan="3" align="center"><b>Legal Position of the Bank</b></td>
			</tr>
			<tr>				
            <td  align="center">1.&nbsp;</td>				
            <td>Legal Position</td>
				<td width="35%" height="30"><select name="sel_legalposition"
					tabindex="1" onchange="getpoints()">
					<option value="0">--select--</option>
					<%String apptype = "29";%>
					<lapschoice:StaticDataNewTag apptype='<%=apptype%>' />
				</select></td>
			</tr>
			<tr>				
            <td  align="center">2.&nbsp;</td>
				
            <td>Points to be given <span class="mantatory">*</span></td>
				<td width="35%" height="33"><input type="text" name="txt_points"
					value="<%=Helper.correctNull((String)hshValues.get("point"))%>"
					size="5" maxlength="3" style="text-align:left;border-style=groove"
					onKeyPress="allowDecimals(this)"></td>
			</tr>
		</table>
		</td>
		</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br>
  <lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="sel_legalposition1"/>
 <input type="hidden" name="hidRealisible_ID" value="" />
 <input type ="hidden" name ="hidkeyid" value="set">
 </form>
</body>
</html>
