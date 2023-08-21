<%@include file="../share/directives.jsp"%>

<%	
	String strRefNo6 =Helper.correctNull((String)hshValues.get("refno6"));
	String strRefNo7 =Helper.correctNull((String)hshValues.get("refno7"));
	String strRefNo8 =Helper.correctNull((String)hshValues.get("refno8"));
	String strParentLevel = Helper.correctNull((String)hshValues.get("strParentLevel"));
	String strLevelAdd = "";
	int i1 = 0;
	if(strParentLevel != ""){
		i1 = Integer.parseInt(strParentLevel);
		i1++;
		strLevelAdd = Integer.toString(i1++);	
	}
	String strParentReferenceNo=Helper.correctNull((String)hshValues.get("strParentReferenceNo"));
	String strReferenceNo=Helper.correctNull((String)hshValues.get("strReferenceNo"));
%>
<html>
<head>
<title>Personal - Applicant </title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script type="text/javascript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function onloading()
{
	document.forms[0].txt_code.readOnly=true;
	document.forms[0].txt_desc.readOnly=true;
	var ReffNocode6 = "<%=strRefNo6%>";
	var ReffNocode7 = "<%=strRefNo7%>";
	var ReffNocode8 = "<%=strRefNo8%>";
	if(ReffNocode6 == "")
	{
		document.forms[0].sel_freecode6.value = "";
		document.forms[0].sel_freecode7.disabled=true;
		document.forms[0].sel_freecode8.disabled=true;
		disableButtons(true,true,true,true,true,false);
	}
	else
	{
		document.forms[0].txt_code.value =  "<%=Helper.correctNull((String)hshValues.get("strCode"))%>";
		document.forms[0].hidRefNo6.value = ReffNocode6;
		document.forms[0].sel_freecode6.value = ReffNocode6;
		document.forms[0].txt_desc.value = "<%=Helper.correctNull((String)hshValues.get("strDesc"))%>";
		document.forms[0].sel_freecode7.disabled=false;
		document.forms[0].sel_freecode7.value = "";
		document.forms[0].txt_code.readOnly=true;
		document.forms[0].txt_desc.readOnly=true;
		disableButtons(false,true,true,true,true,false);
	}
	if(ReffNocode7 == "")
	{
		document.forms[0].sel_freecode7.value = "";
		document.forms[0].sel_freecode8.disabled = true;
	}
	else
	{
		document.forms[0].txt_code.value =  "<%=Helper.correctNull((String)hshValues.get("strCode"))%>";
		document.forms[0].sel_freecode6.value = document.forms[0].hidRefNo6.value;
		document.forms[0].sel_freecode7.value = ReffNocode7;
		document.forms[0].txt_desc.value = "<%=Helper.correctNull((String)hshValues.get("strDesc"))%>";
		document.forms[0].txt_code.readOnly=true;
		document.forms[0].txt_desc.readOnly=true;
		document.forms[0].sel_freecode8.disabled = false;
		document.forms[0].sel_freecode8.value = "";
		disableButtons(false,false,true,true,true,false);
	}
	if(ReffNocode8 == "")
	{
		document.forms[0].sel_freecode8.value = "";
	}
	else
	{
		document.forms[0].txt_code.value =  "<%=Helper.correctNull((String)hshValues.get("strCode"))%>";
		document.forms[0].sel_freecode6.value = "<%=strRefNo6%>";
		document.forms[0].sel_freecode7.value = "<%=strRefNo7%>";
		document.forms[0].sel_freecode8.value = ReffNocode8;
		document.forms[0].txt_desc.value = "<%=Helper.correctNull((String)hshValues.get("strDesc"))%>";
		document.forms[0].txt_code.readOnly=true;
		document.forms[0].txt_desc.readOnly=true;
		disableButtons(true,false,true,true,true,false);
	}
}
function doNew()
{
	document.forms[0].hidAction.value = "insert";
	document.forms[0].hidCommonLevel.value="<%=strLevelAdd%>";
	document.forms[0].hidCommonRefNo.value="<%=strReferenceNo%>";
	if(document.forms[0].sel_freecode6.value == "")
	{
		ShowAlert("111","Free Code6");
		document.forms[0].sel_freecode6.focus();
		return;
	}
	disableFields(true);
	disableButtons(true,true,false,false,true,true);
	document.forms[0].txt_code.readOnly=false;
	document.forms[0].txt_desc.readOnly=false;
	document.forms[0].txt_code.value="";
	document.forms[0].txt_desc.value="";
}
function doEdit()
{
	if(document.forms[0].txt_code.value == "")
	{
		ShowAlert("121","Code");
		document.forms[0].txt_code.focus();
		return;
	}
	if(document.forms[0].txt_desc.value == "")
	{
		ShowAlert("121","Description");
		document.forms[0].txt_desc.focus();
		return;
	}
	document.forms[0].hidAction.value = "update";
	document.forms[0].hidCommonLevel.value="<%=strParentLevel%>";
	document.forms[0].hidCommonRefNo.value="<%=strReferenceNo%>";
	document.forms[0].hidRefNo.value = document.forms[0].hidRefNo6.value;
	document.forms[0].hidParentLevel.value = "<%=strParentLevel%>";
	disableFields(true);
	disableButtons(true,true,false,false,false,true);
	document.forms[0].txt_code.readOnly=false;
	document.forms[0].txt_desc.readOnly=false;
}
function doSave()
{
	if(document.forms[0].sel_freecode6.value == "")
	{
		ShowAlert("111","Free Code6");
		document.forms[0].sel_freecode6.focus();
		return;
	}
	if(document.forms[0].txt_code.value == "")
	{
		ShowAlert("121","Code");
		document.forms[0].txt_code.focus();
		return;
	}
	if(document.forms[0].txt_desc.value == "")
	{
		ShowAlert("121","Description");
		document.forms[0].txt_desc.focus();
		return;
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidRefNo.value = document.forms[0].hidRefNo6.value;
	document.forms[0].hidParentLevel.value = document.forms[0].hidCommonLevel.value;
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidBeanMethod.value="updateFreeCode";
	document.forms[0].hidBeanGetMethod.value="getFreeCode";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/freecode.jsp"; 
	document.forms[0].submit();
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidCommonLevel.value="<%=strParentLevel%>";
		document.forms[0].hidCommonRefNo.value="<%=strReferenceNo%>";
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidBeanId.value="staticdata";
		document.forms[0].hidBeanMethod.value="updateFreeCode";
		//document.forms[0].hidBeanGetMethod.value="getFreeCode";
		document.forms[0].hidSourceUrl.value="action/freecode.jsp";	
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();	
	}
}
function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].cmdcancel.disabled = true;
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].cmddelete.disabled = true;
		document.forms[0].cmdedit.disabled = false;
		document.forms[0].cmdclose.disabled = false;
		document.forms[0].cmdnew.disabled = false;
		document.forms[0].action=appURL+"action/freecode.jsp";
		document.forms[0].submit();
	}
}
function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/setupnav.jsp";
		document.forms[0].submit();
	}
}
function callfreecode6()
{
	var varfreecode6 = document.forms[0].sel_freecode6.value;
	//document.forms[0].sel_freecode6.s;
	if(varfreecode6 != "")
	{
		var varfreecode7 = document.forms[0].sel_freecode7.value;
		var varfreecode8 = document.forms[0].sel_freecode8.value;
		if(varfreecode7 != "" || varfreecode8 != "")
		{
			document.forms[0].hidParentLevel.value = "";

			document.forms[0].sel_freecode7.value = "";
			document.forms[0].sel_freecode8.value = "";
		}

		var ParentRefno= document.forms[0].sel_freecode6.value;	
		document.forms[0].hidfreecode6.value = ParentRefno;
		document.forms[0].hidfreecode6desc1.value = document.forms[0].sel_freecode6.text;
		document.forms[0].hidBeanId.value="staticdata";
		document.forms[0].hidParentLevel.value = "0";
		document.forms[0].hidRefNo6.value = ParentRefno;
		document.forms[0].hidBeanGetMethod.value="getFreeCode";	
		document.forms[0].action=appURL+"action/freecode.jsp";
		document.forms[0].submit();	
	}
	else
	{
		document.forms[0].txt_code.value="";
		document.forms[0].txt_desc.value="";
		document.forms[0].cmdedit.disabled = true;
		document.forms[0].sel_freecode7.disabled=true;
		document.forms[0].sel_freecode7.value="";
		document.forms[0].sel_freecode8.disabled=true;
		document.forms[0].sel_freecode8.value="";
	}
}
function callfreecode7()
{
	var varfreecode7 = document.forms[0].sel_freecode7.value;
	
	if(varfreecode7 != "")
	{
		var varfreecode8 = document.forms[0].sel_freecode8.value;
		if(varfreecode8 != "")
		{
			document.forms[0].hidParentLevel.value = "";

			document.forms[0].sel_freecode8.value = "";
		}
		
		var ParentRefno= document.forms[0].sel_freecode7.value;	
		document.forms[0].hidfreecode6.value = ParentRefno;
		document.forms[0].hidBeanId.value="staticdata";
		document.forms[0].hidParentLevel.value = "1";
		document.forms[0].hidParentLevel7.value = "1";
		document.forms[0].hidRefNo7.value = ParentRefno;
		document.forms[0].hidBeanGetMethod.value="getFreeCode";
		document.forms[0].action=appURL+"action/freecode.jsp";
		document.forms[0].submit();	
	}
	else if(varfreecode7 == "")
	{
		document.forms[0].txt_code.value="";
		document.forms[0].txt_desc.value="";

		document.forms[0].sel_freecode8.value = "";
		document.forms[0].sel_freecode8.disabled=true;
	}
}

function callfreecode8(){
	var varfreecode8 = document.forms[0].sel_freecode8.value;
	if(varfreecode8 != "")
	{
		var ParentRefno= document.forms[0].sel_freecode7.value;	
		document.forms[0].sel_freecode6.value = "<%=strRefNo6%>";
		document.forms[0].sel_freecode7.value = "<%=strRefNo7%>";
		document.forms[0].hidRefNo6.value = "<%=strRefNo6%>";
		document.forms[0].hidRefNo7.value = "<%=strRefNo7%>";
		document.forms[0].hidBeanId.value="staticdata";
		document.forms[0].hidParentLevel.value = "2";
		document.forms[0].hidParentLevel8.value = "2";
		document.forms[0].hidRefNo8.value = ParentRefno;
		document.forms[0].hidBeanGetMethod.value="getFreeCode";
		document.forms[0].action=appURL+"action/freecode.jsp";
		document.forms[0].submit();	
	}
	else if(varfreecode8 == "")
	{
		document.forms[0].txt_code.value="";
		document.forms[0].txt_desc.value="";
	}
}
function disableButtons(add,edit,save,cancel,delet,close)
{
	document.forms[0].cmdnew.disabled=add;
	document.forms[0].cmdedit.disabled=edit;
	document.forms[0].cmdsave.disabled=save;
	document.forms[0].cmdcancel.disabled=cancel;
	document.forms[0].cmddelete.disabled=delet;	
	document.forms[0].cmdclose.disabled=close;	
}
function disableFields(val)
{
	for(i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type == "text")
		{
			document.forms[0].elements[i].readOnly = val;
		}
		if(document.forms[0].elements[i].type == "select-one")
		{			
			document.forms[0].elements[i].disabled = val;
		}
	}
}
</script>
<style>
DIV.cellContainer {	
  width: 100%; height: 200;
  overflow: auto;
}
</style>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
<form name="appform" method="post" action="" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="page_flow">Home -&gt;  Setup -&gt; Other Setup -&gt; Free Codes</td>
	</tr>
</table>
	<table width="98%" align="center" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr>
		<td>
		<table width="98%" align="center" border="0" cellspacing="0" cellpadding="3" class="outertable border1 tableBg">
		<tr>
			<td width="50%">
			<table width="100%" align="center" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
			<td>Code<b><span class="mantatory">*&nbsp;</span></b></td>
			<td><input type="text" name="txt_code" value="">&nbsp;</td>
			</tr>
			<tr>
			<td>Description<b><span class="mantatory">*&nbsp;</span></b></td>
			<td><input type="text" name="txt_desc" value="">&nbsp;</td>
			</tr>
			</table>
			</td>
			<td width="50%">
			<table width="100%" align="center" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
			<td valign="top">
			<table width="100%" align="center" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
			<td>Free code6</td>
			</tr>
			
			<tr>
			<td> <select name="sel_freecode6" onchange="callfreecode6()">
                          <option value="" selected="selected" >---Select---</option>
                          <lapschoice:StaticDataTag apptype="127" />
              </select>
			</td>
			</tr>
			<tr>
			<td>Free code7</td>
			</tr>
			<tr>
			<td> <select name="sel_freecode7" onchange="callfreecode7()">
                          <!-- choiceTagFreeCode -->
                          <option value="" selected="selected" >----Select----</option>
						<%
							String s2 = "1" + "^"+strRefNo6;
						 //FC_LEVEL='^' and FC_REFNO='^'
						%>
						<lapschoice:choiceTagFreeCode value='<%=s2%>' />
              </select>
			</td>
			</tr>
			
			<tr>
			<td>Free code8</td>
			</tr>
			<tr>
			<td> <select name="sel_freecode8" onchange="callfreecode8()">
                          <option value="" selected="selected" >---Select---</option>
                          <%
							String s3 = "2" + "^"+strRefNo7;
						 //FC_LEVEL='^' and FC_REFNO='^'
						%>
						<lapschoice:choiceTagFreeCode value='<%=s3%>' />
              </select>
			</td>
			</tr>
			</table>
			</td>
		</tr>
		</table>
</td></tr></table>

</td></tr></table>
<br>
<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail'	btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
<input type="hidden" name="hidfreecode6" value=""> 
<input type="hidden" name="hidfreecode6desc1" value=""> 
<input type="hidden" name="hidfreecode7" value=""> 
<input type="hidden" name="hidfreecode7desc1" value=""> 
<input type="hidden" name="hidfreecode8" value=""> 
<input type="hidden" name="hidfreecode8desc1" value=""> 
<input type="hidden" name="hidAction"> 
<input type="hidden" name="hidBeanId">
<input type="hidden" name="hidBeanMethod"> 
<input type="hidden" name="hidBeanGetMethod" value=""> 
<input type="hidden" name="hidSourceUrl"> 
<input type="hidden" name="hidParentLevel">

<input type="hidden" name="hidParentLevel6">
<input type="hidden" name="hidParentLevel7">
<input type="hidden" name="hidParentLevel8">

<input type="hidden" name="hidRefNo" value="">
<input type="hidden" name="hidRefNo6" value="">
<input type="hidden" name="hidRefNo7" value="">
<input type="hidden" name="hidRefNo8" value="">
<input type="hidden" name="hidCommonLevel">
<input type="hidden" name="hidCommonRefNo">
<input type="hidden" name="hidPageId">
</form>
</body>
</html>