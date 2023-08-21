<%@include file="../share/directives.jsp"%>
<%
	String struserid = Helper.correctNull((String) hshValues
			.get("struserid"));
	ArrayList arrRow = new ArrayList();
	ArrayList arrCol = new ArrayList();
	ArrayList arrApp = new ArrayList();
	int arrsize = 0, arrsize1 = 0, arrsize2 = 0;
	if (hshValues != null) {
		arrRow = (ArrayList) hshValues.get("arrval1");
		arrCol = (ArrayList) hshValues.get("arrval2");
		arrApp = (ArrayList) hshValues.get("arrval3");
	}
%>
<html>
<head>
<title>Import Excel data</title>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var varExp="<%=Helper.correctNull((String) hshValues
									.get("strExp"))%>";
var varStatus="<%=Helper.correctNull((String) hshValues
							.get("upload_status"))%>";
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
	else if(varExp=="$Invalid To Upload Staus.......Please Check the template")
	{
		 alert("Invalid To Upload Status, Please Check the template!");
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
			
			document.forms[0].action=appUrl+"action/exceluploader.jsp?strFinUpload=NO&hidFileType=MULTIPART&hidBeanId=excelfunction&hidBeanGetMethod=getExcelData";
			showMessage();
			document.forms[0].submit();
		 }
	}
}
</script>
</head>
<body onload="hideMessage()">
<form name="myfrm"  class="normal" method="post" enctype="multipart/form-data"
	action="<%=ApplicationParams.getAppUrl()%>action/exceluploader.jsp?strFinUpload=NO&hidFileType=MULTIPART&hidBeanId=excelfunction&hidBeanGetMethod=getExcelData">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="top" colSpan=5 class="page_flow">Home -&gt;Gold Ornaments & Deposits-&gt;Excel
		Data Upload</td>
	</tr>
</table>
<br />
<table width="75%" border="0" cellspacing="0" cellpadding="10"
	align="center" class="outertable">
	<tr>
		<td>
		<table width="75%" border="1" cellspacing="0" cellpadding="0"
			align="center" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="5"
					 class="outertable">
					<tr  class="dataheader">
						<td align="center" colspan="2"><b>Gold Ornaments & Deposits Excel Data Upload</b></td>
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
			<tr>
			<td>
			<table width="75%" border="0" cellspacing="0" cellpadding="10"
			align="center">
			<%
				if (arrRow != null && arrRow.size() > 0 && arrCol != null
						&& arrCol.size() > 0 && arrApp != null && arrApp.size() > 0) {
			%>


			<tr>
				<td>
				<table width="100%" border="1" cellspacing="0" cellpadding="10"
					align="center" class="outertable">

					<tr class="dataheader">
						<td align="center">Sno</font></td>
						<td align="center" nowrap="nowrap">Applicant CBSID</font></td>
						<td align="center" nowrap="nowrap">Applicant Inward No</font></td>
						<td align="center" nowrap="nowrap">Application No</font></td>
					</tr>

					<%
						if (arrRow != null && arrRow.size() > 0 && arrCol != null
									&& arrCol.size() > 0 && arrApp != null
									&& arrApp.size() > 0) {

								arrsize = arrRow.size();
								arrsize1 = arrCol.size();
								arrsize2 = arrApp.size();
								for (int i = 0; i < arrsize && i < arrsize1 && i < arrsize2; i++) {
									String strCBSId = Helper.correctNull((String) arrRow.get(i));
									String strInwNo = Helper.correctNull((String) arrCol.get(i));
									String strAppNo = Helper.correctNull((String) arrApp.get(i));
					%>
					<tr class="datagrid">
						<td align="center"><%=i + 1%>)</td>
						<td align="center" nowrap="nowrap"><%=strCBSId%></td>
						<td align="center" nowrap="nowrap"><%=strInwNo%></td>
						<td align="center" nowrap="nowrap"><%=strAppNo%></td>
					</tr>
					<%
						}
							}
					%>
				</table>
				<td>
			</tr>
			<%
				}
			%>
						
		</table>
		</td>
		</tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>' /> 
</form>
</body>
</html>