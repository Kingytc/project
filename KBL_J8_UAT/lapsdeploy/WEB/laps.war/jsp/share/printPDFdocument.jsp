<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>

</head>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
function doAttachDocument()
{
 	var document_code = document.forms[0].txtdoc_docsp.value; 	
    var hidType = "pdfdocument";
    if(document_code!="")
    {	    	
		var purl = appUrl+"action/ifrmapplicantphoto.jsp?&document_code="+document_code+"&hidType="+hidType;
	    var prop = 'scrollbars=no,width=300,height=250,menubar=no';	
		var xpos = (screen.width - 800) / 2;
		var ypos = (screen.height - 800) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,'AttachPhoto',prop);
	}
	else
	{
		alert("Please Select Correct Document");
	}	
}

function doViewDocument()
{
	 var document_code = document.forms[0].txtdoc_docsp.value; 	
	if(document_code!="" && document_code!="0" )
    {
	    var document_code = document.forms[0].txtdoc_docsp.value; 
	 	var appUrl="<%=ApplicationParams.getAppUrl()%>";
		var prop = "scrollbars=yes,width=700,height=600,,top=10,left=20,menubar=yes";
		var url=appUrl+"action/printpdfviewdocument.jsp?&document_code="+document_code;
		window.open(url,"viewdoc",prop);
    }
	else
	{
		alert("Please Select Document");
	}
}

function doEdit()
{ 	
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");	
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="";
		document.forms[0].hidSourceUrl.value="/action/printPDFdocument.jsp";
		document.forms[0].hidBeanId.value="commdocument";
		document.forms[0].hidBeanMethod.value="updateAttachedPdfDocument";
		document.forms[0].hidBeanGetMethod.value="viewDocumentPdfImage";
		document.forms[0].action=appUrl +"controllerservlet";
		document.forms[0].submit(); 		
	}	
	
}
function doSave()
{
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].hidSourceUrl.value="/action/printPDFdocument.jsp";
		document.forms[0].hidBeanId.value="commdocument";
		document.forms[0].hidBeanMethod.value="updateAttachedPdfDocument";
		document.forms[0].hidBeanGetMethod.value="viewDocumentPdfImage";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();
		
}
function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appUrl+"action/setupnav.jsp";
		document.forms[0].submit();
	}
}

function onloading()
{
	disableCommandButtons("load");	
}

function disableCommandButtons(val)
{
	if(val=="load")
	{  
		
		document.forms[0].cmdedit.disabled=true;		
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdattachdocument.disabled=true;
		document.forms[0].cmdviewdocument.disabled=false;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;		 
	}
	
	if(val=="edit")
	{	 
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdattachdocument.disabled=false;
			document.forms[0].cmdviewdocument.disabled=true;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
	}
}
function editEnable()
{
 if(document.forms[0].txtdoc_docsp.value=="0")
 {
	 document.forms[0].cmdedit.disabled=true;
 }
 else
 {
	 document.forms[0].cmdedit.disabled=false;
 }
	
}
</script>
<body onload="onloading()">
<form name="pdfdocument" method="post" class="normal">
<table width="100%" cellpadding="0" cellspacing="0" border="0" class="outertable">
<tr>
	<td class="page_flow">Home -&gt; Setup -&gt; Attach Document for Print</td>
</tr>
</table>
<br>
<br>
<br>
<table width="75%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
  <tr>
  		
      <td width="85%"> 
        <select name="txtdoc_docsp" tabindex="3" style="width:625" onchange="editEnable()">
        <option value="0" selected="selected">&lt;---Select---&gt;</option>
        <lapschoice:StaticDataNewTag apptype="40"/>
      </select>
        </td>   
  </tr>
  
</table>
<br>
<br>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Attach Document_View Document' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>




