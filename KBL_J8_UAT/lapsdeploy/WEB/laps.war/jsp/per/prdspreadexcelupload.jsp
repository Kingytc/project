<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Import Excel data</title>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var varStatus="<%=Helper.correctNull((String) hshValues
							.get("msg"))%>";
var varExp="<%=Helper.correctNull((String) hshValues
								.get("strExp"))%>";
document.write("<div id='loading' style='width:120px;height:45px;position: absolute;left: 45%;top: 35%;'><img src='/laps/img/finloader.gif'></div>");
function showMessage()
{
	document.getElementById("loading").style.display="block";
}
function hideMessage()
{
	if(varStatus=="Success")
	{ 
		alert("Excel Upload Successfully Completed!");
	}
	else if(varExp=="$Not a Valid Sheet.......Please Check the template")
	{
		 alert("Invalid Excel Sheet, Please Check the template!");
	}
	
	document.getElementById("loading").style.display="none"; 
	 document.forms[0].cmdimportdata.disabled=true;
}
function doClose()
{
	if(ConfirmMsg(100))
	 {
		 document.forms[0].action=appUrl+"action/mainnav.jsp";
		 document.forms[0].submit();
	 }
}
function check1()
{
    alert("Please avoid re-uploading the same exceldata.");
    document.forms[0].cmdimportdata.disabled=false;
}

function doImportData()
{
	if(document.forms[0].fileUpload.value=="")
	{
		alert("Please choose the File");
		return;
	}
	else
	{
		if(ConfirmMsg(198))
		 {
			
			document.forms[0].action=appUrl+"action/prdspreadexcelupload.jsp?strExcelUpload=YES&hidFileType=MULTIPART&hidBeanId=excelfunction&hidBeanGetMethod=updateProductSpread";
			showMessage();
			document.forms[0].submit();
		 }
	}
}
</script>
</head>
<body onload="hideMessage()">
<form name="myfrm"  class="normal" method="post" enctype="multipart/form-data"
	action="<%=ApplicationParams.getAppUrl()%>action/prdspreadexcelupload.jsp?strFinUpload=NO&hidFileType=MULTIPART&hidBeanId=excelfunction&hidBeanGetMethod=updateProductSpread">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="top" colSpan=5 class="page_flow">Setup -&gt; Retail/Agriculture/Corporate Spread -&gt;Excel
		Data Upload</td>
	</tr>
</table>
<br />
<table width="75%" border="0" cellspacing="0" cellpadding="10"
	align="center" class="outertable">
	<tr>
		<td>
		<table width="75%" border="0" cellspacing="0" cellpadding="0"
			align="center" class="outertable border1 tableBg">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="5"
					 class="outertable">
					<tr  class="dataheader">
						<td align="center" colspan="2"><b>Retail/Agriculture/Corporate Spread Excel Data Upload</b></td>
					</tr>
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr>
						<td width="20%"><b>Import File</b>&nbsp;</td>
						<td align="center"><input type="file"
							name="fileUpload" onClick="check1()" size="45"></td>
					</tr>
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr>
						<td colspan="2" align="center"> 
							<lapschoice:combuttonnew btnnames='Import Data' btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
							</td>
					</tr>
				</table>
				</td>
			</tr>
			</table>
			</td>
			</tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>' /> 
</form>
</body>
</html>