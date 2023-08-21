<%@include file="../share/directives.jsp"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%response.setHeader("X-Frame-Options","SAMEORIGIN");%>
<html>
<head>
<title>Document Attach</title>
<STYLE>
DIV.cellContainer {	
  width: 100%; height: 300;
  overflow: auto;
}
</STYLE>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>

<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<% 
	String strSaral = Helper.correctNull((String) request.getParameter("hidsaral"));
	String inwardno = Helper.correctNull((String) hshValues.get("inwardno"));
	if(inwardno.equalsIgnoreCase(""))
	{
		inwardno=Helper.correctNull((String) request.getParameter("inwardno"));
	}
	String strAccepted=Helper.correctNull((String) session.getAttribute("inward_acceptedby"));
	String strProposal = Helper.correctNull((String) hshValues.get("inward_proptype"));
	if (strProposal.equals("")) {
		strProposal = Helper.correctNull((String) request.getParameter("hidproposal"));
	}
	String strApplnProcess=Helper.correctNull((String)session.getAttribute("strApplnProcess"));
	
	String strSector = Helper.correctNull((String) request.getParameter("hidsector"));
	if (strSector.equals(""))
	{
		strSector = Helper.correctNull((String) hshValues.get("sectordesc"));
	}
	
	String strappliedfor = Helper.correctNull((String) hshValues.get("borrowertype"));
	if (strappliedfor.equals(""))
		strappliedfor = Helper.correctNull((String) request.getParameter("appliedfor"));
	
	String strCoapplicant = Helper.correctNull((String)request.getParameter("hidCoapp"));
	String strstatus = Helper.correctNull((String) request.getParameter("hidstatus"));
	String income_status = Helper.correctNull((String)hshValues.get("income_status"));
	int intDocTypeSize = 0;
	
	ArrayList arrDocId = null;
	ArrayList arrDocDesc = null;
	
	arrDocId = (ArrayList) hshValues.get("arrDocId");
	arrDocDesc = (ArrayList) hshValues.get("arrDocDesc");
	if (arrDocId != null && arrDocId.size() > 0) {
		intDocTypeSize = arrDocId.size();
	}
	String strOnlineRefNo = Helper.correctNull((String) session.getAttribute("strOnlineRefNo"));//3
	session.setAttribute("strOnlineRefNo",strOnlineRefNo);
	
	 strApplnProcess = Helper.correctNull((String) hshValues.get("processedat"));//3
	if(strApplnProcess.equalsIgnoreCase(""))
	{
		strApplnProcess=Helper.correctNull((String) request.getParameter("hidprocessedat"));
	}
	
	String strFromLink = Helper.correctNull((String)request.getParameter("fromlink"));
	
	if(strFromLink.equals(""))
	{
		strFromLink = Helper.correctNull((String) hshValues.get("strfromlink"));
	}
	String strTabdataflag = Helper.correctNull((String) hshValues.get("strTabdataflag"));
	
	String strhidflag = Helper.correctNull((String) hshValues.get("hidflag"));
	
%>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varincome_status = "<%=income_status%>"
var strCatName="<%=Helper.correctNull((String) hshValues.get("catname"))%>";
var varinwardno="<%=inwardno%>";
var varhidflag="<%=strhidflag%>";

function runrep()
	{
		if(varincome_status=="Y")
		{
			
			//var varinwardno = document.forms[0].inwardno.value;
			var varsector = document.forms[0].hidsector.value;
			var varappname = document.forms[0].appname.value;
			if(varsector=="Retail")
			{
				str_sector="p";
			}
			else if(varsector=="Agri")
			{
				str_sector="a";
			}
			else if(varsector="Corp")
			{
				str_sector="c";
			}
			else if(varsector="Tertiary")
			{
				str_sector="t";
			}
			callLAPSPDF("pdfaction/ack.pdf?hidBeanId=corpexecutivesummarypdf&hidBeanGetMethod=getacknowledgement&inwardno="+varinwardno+"&hidsector="+varsector+"&appname="+varappname+"&strSector="+str_sector+"&catname="+strCatName);
		}
		else
		if(varincome_status=="N")
		{
			alert("Please Enter the Income details in Income and Expenses Page");
		}
	}
	function callLAPSPDF(strPDFNAME)
	{
		  var CONTEXT_PARAM="/laps/";
		  var PDF_CONTROLLER_PATTERN="pdfaction/";
		  var PDF_URL = CONTEXT_PARAM+PDF_CONTROLLER_PATTERN+strPDFNAME;
		  var PAGE_PROPERTIES= "scrollbars=yes,width=1015,height=800,fullscreen=no,resizable=1,status=yes,menubar=yes";	
		  PAGE_PROPERTIES = PAGE_PROPERTIES + ",left=0,top=0";
		  window.open(PDF_URL,"",PAGE_PROPERTIES);
		 }
function onLoad()
{	
	<%if(strhidflag.equalsIgnoreCase("Y"))
	{%>
	//alert("okk");
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].name == 'radio')
			{
				document.forms[0].elements[i].checked=false;
			}
				
		}
	<%}%>

	
	if("<%=strstatus%>"!="C")
	{
		
	}

	
}
function getSelectedDocument(docId)
{
	if(document.forms[0].cmdsave.disabled != true)
	{
		ShowAlert(103);
	}
	else
	{
		document.forms[0].hidDocId.value=docId;
		document.all.ifrm2.src=appURL+"action/iframeDocDescription.jsp?hidBeanId=commdocument&hidBeanGetMethod=getDocDescByDocIdandAppNo&varInwardno="+varinwardno+"&hidDocId="+docId;
		/*document.all.ifrm2.src=appURL+"action/iframeDocDescription.jsp?hidBeanId=commdocument&hidBeanGetMethod=getDocDescByDocIdandAppNo&varInwardno="
				+document.forms[0].inwardno.value+"&hidDocId="+docId+"&pagefrm=LV";*/
	}	
}

function uploaddocuments()
{
	var prop = 'scrollbars=no,width=700,height=240,menubar=no';	
	var url = appURL+"action/iframattachfile.jsp?hidBeanId=commdocument&hidBeanGetMethod=doUploadBulkData";	
	var xpos = (screen.width - 800) / 2;
	var ypos = (screen.height - 800) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,'AttachFile',prop);		
}

function viewSelectedDocument(docId)
{
		document.forms[0].hidBeanId.value="commdocument"
		document.forms[0].hidBeanGetMethod.value="getBulkDocView";
		document.forms[0].action=appURL+"action/setBulkDocuments.jsp";
		document.forms[0].submit();		
}

function deselectChild()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].name == 'rad_inner_doc')
		{
			document.forms[0].elements[i].checked=false;
		}
			
	}
}
function doAttach()
{ 
	var varnbfc ="";// val.value;
	//alert("val===="+varnbfc);
	var prop = 'scrollbars=no,width=700,height=240,menubar=no';	
	var url = appURL+"action/set_bulkupload.jsp?strnbfc="+varnbfc;	
	var xpos = (screen.width - 800) / 2;
	var ypos = (screen.height - 800) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,'AttachFile',prop);	
}

function callClose()
{
	document.forms[0].hidBeanId.value="";
	document.forms[0].hidBeanGetMethod.value="";
	document.forms[0].action=appURL+"action/appinwardno_search.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}

function callCancel()
{	

		document.forms[0].hidBeanId.value="commdocument"
		document.forms[0].hidBeanGetMethod.value="getDocDescByAppNoDocType";
		document.forms[0].action=appURL+"action/docVerification.jsp";
		document.forms[0].submit();
}

function callApplicant()
{
		document.forms[0].hidBeanId.value="commdocument";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/appdocumentsappl.jsp?hidBeanGetMethod=getData";
		document.forms[0].hidAppDoc.value="A";
		document.forms[0].method="post";
		document.forms[0].submit();
}

function callInternal()
{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/appdocumentsinter.jsp?hidBeanGetMethod=getData";
		document.forms[0].hidAppDoc.value="I";
		document.forms[0].method="post";
		document.forms[0].submit();
}

</script>
</head>
<link rel="stylesheet"href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<body onload="onLoad();">
<form name="docVerForm" method="post" action="" class="normal">
<input type="hidden" name="hidformlink" value="<%=strFromLink %>"> 

<br><br><br><br>
<table width="50%" align="center"  cellspacing="0" cellpadding="0" class ="outertable">
	<tr>
		<td>
			<table width="100%" align="center" cellspacing="0" cellpadding="0" class ="outertable">
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
<!-- 							<tr> -->
<!-- 								<td>Select NBFC</td> -->
<!-- 								<td><select name="sel_nbfc"> -->
<!-- 									<option value="0">&lt;----select----&gt;</option> -->
<%-- 									<lapschoice:StaticDataNewTag apptype="263" /> --%>
<!-- 								</select> -->
<!-- 							</td> -->
<!-- 							</tr> -->
<!-- 							<tr>	 -->
<!-- 								<td><b>Document Download </b>&nbsp;</td> -->
<!-- 								<td><input type='button' name='Document' value='Download' onClick="viewSelectedDocument()" class="buttonStyle"></td> -->
<!-- 							</tr> -->
							<tr>
								<td><b>SHG Document to Upload </b>&nbsp;</td>
								<td><input type='button' name='rprunreport' value='Upload' onClick="doAttach()" class="buttonPrint"></td>
							</tr>
						</table>
					</td>
				</tr>		
			</table>
		</td>				
	</tr>
</table>
<input type="hidden" name="hidBeanId" value="commdocument"> 
<input type="hidden" name="hidBeanGetMethod" value="getDocDescByAppNoDocType">
<INPUT TYPE="hidden" name="radLoan" value="Y">
<input type="hidden" name="hidSourceUrl" value="docVerification.jsp">
<input type="hidden" name="hidAppDoc">  
<input type="hidden" name="hidDocId"> 
<input type="hidden" name="hidAction">
<input type="hidden" name="hidAppType"> 
<input type="hidden" name="hidCoapp" value="<%=strCoapplicant%>">
<input type="hidden" name="applino" value="<%=Helper.correctNull((String)request.getParameter("applino"))%>">
<input type="hidden" name ="hidstatus">

</form>
</body>
</html>