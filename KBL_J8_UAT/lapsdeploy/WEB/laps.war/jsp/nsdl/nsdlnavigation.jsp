<%@include file="../share/directives.jsp"%>
<%
	String grpRights = (String)session.getAttribute("strGroupRights");
	session.setAttribute("pageType","New");
	
	session.setAttribute("strAppid","");
	session.removeAttribute("strAppid");
	String strFormType=Helper.correctNull((String)request.getParameter("strFormType"));
	if(!strFormType.equals(""))
	{
			session.setAttribute("strFormType",strFormType);
	}
	String strloanname=strFormType;
%>

<HTML>
<HEAD>
<link rel="stylesheet" type="text/css" href="<%=ApplicationParams.getAppUrl()%>css/anylinkmenu.css" />
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style_tab.css" type="text/css">
<script language="JavaScript">
var grpRights = "<%=session.getAttribute("strGroupRights")%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var formtype ="<%=Helper.correctNull((String)session.getAttribute("strFormType"))%>";

function callNSDLApplication(pagename,param)
{
	document.forms[0].hidparam.value=param;
	document.forms[0].hidBeanId.value="nsdl";
	document.forms[0].hidBeanGetMethod.value="getNSDLApplications";
  	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+pagename+"?report="+param;
	document.forms[0].submit();
}


function callNSDLReallocation(pagename)
{
	document.forms[0].hidBeanId.value="nsdl";
	document.forms[0].hidBeanGetMethod.value="getNSDLApplications";
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].submit();
}
</script>
<script type="text/JavaScript">

function onLoading()
{
	
}
function callclose()
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/mainnav.jsp";
	document.forms[0].submit();
}
function generateXMLResponseFiles()
{
	document.all.downloadresponse.src = appURL+"action/iframeNSDLDownloadCheck.jsp?hidBeanGetMethod=generateXMLResponseFiles&hidBeanId=nsdl";
}
function callStatusAlert(val)
{	
	if(val.length>0){
		alert(val);
	}else{
		alert("Response Download Failed");
	}
}
function gotoTab(path, beanid, getmethod, page)
{
	if(document.forms[0].cmdsave)
	{
		if(document.forms[0].cmdsave.disabled==true)
		{
			document.forms[0].hidBeanId.value=beanid;		
			document.forms[0].hidBeanGetMethod.value=getmethod;
			document.forms[0].action=path+"action/"+page;	
			document.forms[0].submit();
		}
		else
		{
			ShowAlert(103);
			return;
		}
	}
	else
	{
		document.forms[0].hidBeanId.value=beanid;		
		document.forms[0].hidBeanGetMethod.value=getmethod;
		document.forms[0].action=path+"action/"+page;	
		document.forms[0].submit();
	}
}

function fnUploadResponse()
{
	var hidType = "upload";
 	var purl = appURL+"action/iframeNSDLResponseUpload.jsp";
    var prop = 'scrollbars=no,width=300,height=250,menubar=no';	
	var xpos = (screen.width - 800) / 2;
	var ypos = (screen.height - 800) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'UploadResponse',prop);
	
}
</script>
<style>
.announce_container
{
	width: 100%;
	height: 80px;
	overflow: auto;
}
</style>
</HEAD>

<BODY onLoad="onLoading()">
<form name="navigation"  class="normal" method="post">
<table width="60%" border="0" cellspacing="0" cellpadding="0"
	class="outertable;" align="center">
	<tr>
	<td>
  <table width="40%" height="150px" border="0" cellspacing="0" cellpadding="1" align="center" class="outertable ">
    <tr> 
      <td> 
        <table width="96" border="0" cellspacing="0" cellpadding="0"  align="center" class="outertable border1 tableBg">
          <tr> 
            <td> 
              <TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="4"  class="outertable">
					
					<tr>
					<td>&nbsp;</td>
					</tr>
					
					<TR>
					<td align="center" class="menubackflow" nowrap="nowrap"><b><a href="javascript:gotoTab(appURL,'nsdl','downloadRequestFiles','nsdl_download.jsp')"><b>Download Files From NSDL Site</b></a></b></td>
					</TR> 
					
					
<!--					<TR>-->
<!--					<td align="center" class="menubackflow" nowrap="nowrap"><b><a href="javascript:fnUploadResponse()"><b>Upload Response to NSDL</b></a></b></td>-->
<!--					</TR> -->
					
					<TR>
					<td valign="top" class="menubackflow" nowrap="nowrap"><b><a  href="javascript:generateXMLResponseFiles();"><b>NSDL Response File Download & Upload</b></a></b></td>
					</TR>
					
					<TR>
					<td valign="top" class="menubackflow" nowrap="nowrap"><b><a href="javascript:callNSDLApplication('NsdlReallocation.jsp','Realloc')"><b>NSDL Application Reallocation</b></a></b></td>
					</TR>
					
					<TR>
					<td valign="top" class="menubackflow" nowrap="nowrap"><b><a href="javascript:callNSDLApplication('NsdlReallocation.jsp','Update_App')"><b>NSDL Uploaded Application Details</b></a></b></td>
					</TR> 
					 
					
					</TABLE>
             <br>  </td>
            
         
           
          </tr>
        </table>
      </td>
    </tr>
   
  </table>
  <br>
  <table border="0" cellspacing="0" cellpadding="0" align="center">
	<tr valign="middle">
		<td><input type="button" name="cmdclose" value="Close"
			class="buttonClose" onClick="callclose();"
></td>
	</tr>
</table>
</td>
</tr>
</table>
<iframe height="0" width="0" id="downloadresponse" frameborder=0 style="border: 0"></iframe> 
<input type="hidden" name="hidPage" value=""> 
<input type="hidden" name="hidusr_id" value=""> 
<input type="hidden" name="hidPageType" value="">
<input type="hidden" name="hidBeanId" value="">
<input type="hidden" name="hidBeanMethod" value="">
<input type="hidden" name="hidBeanGetMethod" value="">
<input type="hidden" name="hidSourceUrl" value ="">
<input type="hidden" name="NSDL" value ="Y">
<input type="hidden" name="hidparam"/>
</form>
</BODY>
</HTML>
