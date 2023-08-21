<%@include file="../share/directives.jsp"%>
<%
String strAvailableFiles="";
String strFileList[]= null;
String strFileID="";
int i=0;
	if(hshValues != null)
	{
		strAvailableFiles = Helper.correctNull((String) hshValues.get("NSDLFileIds"));
	}

	/*out.print("strAvailableFiles"+strAvailableFiles);
	strAvailableFiles = strAvailableFiles.substring(1, strAvailableFiles.length()-1);
	strFileList = strAvailableFiles.split(",");
	
	out.print("strAvailableFiles lenght"+strAvailableFiles.length());
	out.print("-------" + strAvailableFiles.substring(1, strAvailableFiles.length()-1));
	out.print("======"+strFileList);
	out.print("======+++++++++"+strFileList.length);
	for(i=0;i<strFileList.length;i++)
	{
		out.print("======iiiii"+i);
		strFileID = strFileList[i].substring(1, strFileList[i].length()-1);
		out.print("======strFileID---------------"+strFileID);
	}*/
%>
<html>
<head>
<title>MY GENERATED FILES</title>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function fnDownloadFile(fileid)
{
	document.all.ifrm.src = appURL+"action/iframeNSDLreportView.jsp?hidBeanId=nsdl&hidBeanGetMethod=downloadByFileID&fileid="+fileid+"&specificfDownload=N";
}


function selectAll(){
	var chkall = document.getElementById("chkAll");
	if(chkall.checked == true){ 
		var chkbox = document.forms[0].chkBox;
		if(chkbox != null && chkbox != "" ){
			var chkLen = chkbox.length;
			for(i=0;i<chkLen;i++){
				chkbox[i].checked = true;
			}
		}
	}else if(chkall.checked == false){
		var chkbox = document.forms[0].chkBox;
		var chkLen = chkbox.length;
		for(i=0;i<chkLen;i++){
			chkbox[i].checked = false;
		}
	}
}


function doDownload(){
	var chkbox = document.forms[0].chkBox;
	var chkLen = chkbox.length;
	var varChecked = "0";
	if(chkbox != null && chkbox != "" ){
		var chkValue = "";
		for(i=0;i<chkLen;i++){
			if(chkbox[i].checked == true)
			{
				varChecked = "1";
				if(chkValue == "")
				{
					chkValue = chkbox[i].value;
				}else{
					chkValue = chkValue+","+chkbox[i].value;
				}
			}
		}
		if(chkValue != ""){
			document.all.ifrm.src = appURL+"action/iframeNSDLreportView.jsp?hidBeanId=nsdl&hidBeanGetMethod=downloadByFileID&chkBoxValue="+chkValue+"&specificfDownload=N";
		}
	}

	if(varChecked == "0")
	{
		alert("Please select file to download");
	}
}

function Loadpage()
{
	//alert("Flushfresh");
	document.forms[0].hidBeanId.value="nsdl";
	document.forms[0].hidBeanGetMethod.value="downloadRequestFiles";
	document.forms[0].action=appURL+"action/nsdl_download.jsp";
	document.forms[0].submit();
}
function doClose()
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/mainnav.jsp";
	document.forms[0].submit();
}

</script>
</head>
<body>
<form method="post" class="normal">
<br/>
<table width="95%" border="0" cellspacing="1" cellpadding="3"
	align="center" class="shadow" >
<tr class="dataheader" >
	<td colspan="5" align="center" >NSDL Vidya Lakshmi Files Download</td>
</tr>

<tr class="dataheader" >
	 <td  nowrap="nowrap" align="center">&nbsp;&nbsp;<%if(strAvailableFiles.length() > 2)
		{ %><input type="checkbox" id="chkAll" value="<%=strFileID%>" onclick="selectAll();" style="border: none;"/>&nbsp;&nbsp;<%} %></td>
	<td width="7%" nowrap="nowrap" align="center">&nbsp;&nbsp;<b>S.No</b>&nbsp;&nbsp;</td>
	<td width="47%" nowrap="nowrap" align="center">&nbsp;<b>File Id</b>&nbsp;</td>
	<td width="47%" nowrap="nowrap" align="center">&nbsp;<b>Download</b>&nbsp;</td>
</tr>

<%
	String bckColor = "";
	if(strAvailableFiles.length() > 2)
	{
		
		strAvailableFiles = strAvailableFiles.substring(1, strAvailableFiles.length()-1);
		strFileList = strAvailableFiles.split(",");
		if(strFileList.length >= 1){
		for(i=0;i<strFileList.length;i++)
		{
			strFileID = strFileList[i].substring(1, strFileList[i].length()-1);
	
if(bckColor.equals("")){
	bckColor = "white";

}else{ 
	bckColor = "";
} %>
<tr  class="datagrid">
    <td align="center">&nbsp;&nbsp;<input type="checkbox" id="chkBox" name="chkBox" value="<%=strFileID%>" style="border: none;" />&nbsp;&nbsp;</td>
	<td  width="7%" align="center"><%=i+1%></td>
	<td width="47%" align="center"><%=strFileID%></td>
	<td width="47%" align="center"><a href="javascript:fnDownloadFile('<%=strFileID%>')">Download</a></td>
</tr>
<%   }}else{%>
<tr class="datagrid">
	<td colspan="4" align="center">--No Records Found--</td>
</tr>
  
<%}
  }else{%>

<tr class="datagrid">
	<td colspan="4" align="center">--No Records Found--</td>
</tr>
  
<%}%>
<br/> 
<br/> 


<%if(strAvailableFiles.length() > 2){ %>
	<tr>
		<td colspan="5" align="center"><input type="button" value="Download" name="cmddownload" onclick="doDownload()" class="buttonStyle">&nbsp;</td>
	</tr>
	<%} %>
</table>
<iframe id="ifrm" style="visibility: hidden;" width="0%"></iframe>

<input type="hidden" name="hidCategoryType" /> 
<input type="hidden" name="hidBeanId" /> 
<input type="hidden" name="hidBeanGetMethod" /> 

</form>
</body>
</html>
