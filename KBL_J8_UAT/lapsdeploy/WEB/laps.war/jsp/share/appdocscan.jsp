<%@include file="../share/directives.jsp"%>
<%
  String strPgDist=Helper.correctNull(request.getParameter("hiPgDist"));
  String strAppno = Helper.correctNull((String)hshValues.get("appscan_appno"));
  strAppno = (strAppno.trim().equals(""))?Helper.correctNull((String)request.getParameter("appscan_appno")):strAppno;
  strAppno = (strAppno.trim().equals(""))?Helper.correctNull((String)request.getParameter("appno")):strAppno;

%>
<html>
<head>
<title>Document Scanning</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
	
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<script>

 var appURL="<%=ApplicationParams.getAppUrl()%>";
 var appUrl="<%=ApplicationParams.getAppUrl()%>";
 var currentdate= "<%=Helper.getCurrentDateTime()%>";

 var varpageid="<%=Helper.correctNull((String) hshValues.get("PageId"))%>";
 var ftpurl="ftp://<%=ApplicationParams.getIP()%>/";
 var appno="<%=hshValues.get("appscan_appno")%>";
 var doccode="<%=Helper.correctNull((String)hshValues.get("appscan_doccode"))%>";
 var valfrom="<%=Helper.correctNull((String)hshValues.get("appscan_validfrom"))%>";
 var valto="<%=Helper.correctNull((String)hshValues.get("appscan_validto"))%>";
 var scanby="<%=Helper.correctNull((String)hshValues.get("appscan_scanby"))%>";
 var sdate="<%=Helper.correctNull((String)hshValues.get("appscan_scandate"))%>";
 var stime="<%=Helper.correctNull((String)hshValues.get("appscan_scantime"))%>";
 var verby="<%=Helper.correctNull((String)hshValues.get("appscan_verifyby"))%>";
 var verdate="<%=Helper.correctNull((String)hshValues.get("appscan_verifydate"))%>";
 var custody="<%=Helper.correctNull((String)hshValues.get("appscan_doccustody"))%>";
 var imgtype="<%=Helper.correctNull((String)hshValues.get("appscan_imgtype"))%>";
 var status="<%=Helper.correctNull((String)hshValues.get("appscan_status"))%>";
 var totpage="<%=Helper.correctNull((String)hshValues.get("apdoc_totpages"))%>";
 var scan_flag="<%=Helper.correctNull((String)hshValues.get("appscan_flag"))%>"; 
 var doc_name="<%=Helper.correctNull((String)hshValues.get("appscan_filename"))%>";
 var cmpname="<%=Helper.correctNull((String)request.getParameter("appname"))%>";
 var doctype="<%=Helper.correctNull((String)request.getParameter("doc_type"))%>";
 var docfile="<%=hshValues.get("docfile")%>";
 var imgfile="<%=hshValues.get("imgfile")%>";
 var doccode="<%=request.getParameter("doc_code")%>";



function checkvalidfrom()
{

 var validfrom=document.forms[0].appscan_validfrom.value;
 var validto=document.forms[0].appscan_validto.value;
 if(validfrom=="")
 {
 	alert("Valid from cannot be empty");
 	document.forms[0].appscan_validfrom.focus();
 	if(document.forms[0].appscan_validto.value != "")
 	{
 		document.forms[0].appscan_validto.value="";
 	}
 	
 }
 else
 {
	validto=(validto);
	validfrom=(validfrom);
		if(Date.parse(validto) < Date.parse(validfrom))
			{
				alert("Date cannot be less than " +validfrom );
				document.forms[0].appscan_validto.value="";
				document.forms[0].appscan_validto.focus();
			}
			
 }
}
 function callCalender(fname)
 {
	 if(document.forms[0].cmdedit.disabled)
		 showCal(appUrl,fname);
 }
 
 function placeValues()
 {
	 document.forms[0].doc_type.value=doctype;
	 document.forms[0].doc_code.value=doccode;
	 
	 if("<%=request.getParameter("hidscan")%>"=="yes")
	 {		
		 appno="<%=request.getParameter("appscan_appno")%>";
	 }
	 
	 if(appno=="null")
	 {
		 appno="<%=request.getParameter("appno")%>";
		 document.forms[0].appscan_appno.value=appno;
         document.forms[0].comapp_companyname.value=cmpname;
		 document.forms[0].appscan_scanby.value="<%=strUserId%>";
		 document.forms[0].cmdedit.disabled=false;
		 document.forms[0].cmdsave.disabled=true;
		 document.forms[0].cmdattachdocument.disabled=true;	
		 document.forms[0].cmdviewdocument.disabled=true;	
		 document.forms[0].cmdcancel.disabled=true;
		 //disableFields(true)
		 return;
	 }
	 document.forms[0].appscan_appno.value=appno;
	 document.forms[0].doc_code.value=doccode;
	 document.forms[0].appscan_validfrom.value=valfrom;
	 document.forms[0].appscan_validto.value=valto;
	 document.forms[0].appscan_scanby.value=scanby;
	 document.forms[0].appscan_scandate.value=sdate;
	 document.forms[0].appscan_scantime.value=stime;
	 document.forms[0].appscan_verifyby.value=verby;
	 document.forms[0].appscan_verifydate.value=verdate;
	 document.forms[0].comapp_companyname.value="<%=request.getParameter("comapp_companyname")%>";
	 
	 if(document.forms[0].comapp_companyname.value=="null")
	 {
	 document.forms[0].comapp_companyname.value=cmpname;
	 }
	 if(custody=="b")
	 {
		 document.forms[0].appscan_doccustody[0].checked=true;
	 }
	 else if(custody=="a")
	 {
		 document.forms[0].appscan_doccustody[1].checked=true;
	 }
	 else if(custody=="o")
	 {
		 document.forms[0].appscan_doccustody[2].checked=true;
	 }
	 if(imgtype=="o")
	 {
		 document.forms[0].appscan_imgtype[0].checked=true;
	 }
	 else if(imgtype=="c")
	 {
		 document.forms[0].appscan_imgtype[1].checked=true;
	 }
	 else if(imgtype=="n")
	 {
		 document.forms[0].appscan_imgtype[2].checked=true;
	 }
	 document.forms[0].appscan_status.value=status;
	 document.forms[0].apdoc_totpages.value=totpage;
	 document.forms[0].cmdedit.disabled=false;
	 document.forms[0].cmdsave.disabled=true;	 
	 document.forms[0].cmdcancel.disabled=true;
	 if("<%=request.getParameter("hidscan")%>"=="yes")
	 {
		 document.forms[0].comapp_companyid.value="<%=request.getParameter("comapp_companyid")%>";
		 document.forms[0].comapp_companyname.value="<%=request.getParameter("comapp_companyname")%>";
		 document.forms[0].appscan_scanby.value="<%=strUserId%>";
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmdsave.disabled=false;		
		 disableFields(false);
	 }
	 if(imgfile=="y")
	 {
		 document.forms[0].view.disabled=false;
	 }	
	 
	 if(scan_flag=="false")
	 {
	 	document.forms[0].cmdattachdocument.disabled=true;
	 	document.forms[0].cmdviewdocument.disabled=true;	 
	 }
	 else
	 {
	 	document.forms[0].cmdattachdocument.disabled=false;	
	 	
	 	if(doc_name=='')
	 	{
		 	document.forms[0].cmdviewdocument.disabled=true;
	 	}	
	 }
	 //disableFields(true)
	 
 }
 function doEdit()
 {
	 disableFields(false);
	 document.forms[0].cmdedit.disabled=true;
	 document.forms[0].cmdsave.disabled=false;
	 document.forms[0].cmdcancel.disabled=false;	 
	 if(imgfile=="y")
	 {
		 document.forms[0].view.disabled=false;
	 }
 }

 function disableFields(val)
 {

	 for(var i=0;i<document.forms[0].length;i++)
	 {
		 if(document.forms[0].elements[i].type=="text" || document.forms[0].elements[i].type=="textarea")
		 {
			document.forms[0].elements[i].readOnly=val;
			document.forms[0].comapp_companyid.readOnly=true;
			document.forms[0].doc_desc1.readOnly=true;
			document.forms[0].appscan_scanby.readOnly=true;
			document.forms[0].appscan_appno.readOnly=true;
			document.forms[0].comapp_companyname.readOnly=true;
			document.forms[0].appscan_verifyby.readOnly = true;
			document.forms[0].appscan_scandate.readOnly=true;			
		 }
	 }
	 for(var k=0;k<3;k++)
	 {
		 document.forms[0].appscan_imgtype[k].disabled=val;
		 document.forms[0].appscan_doccustody[k].disabled=val;
	 }
	 document.forms[0].appscan_status.disabled = val;
 }

 function createFile()
 {
	 if(document.forms[0].apdoc_totpages.value!="")
	 {

	 	 document.forms[0].hidSourceUrl.value="/action/appdocscan.jsp";
	 	 document.forms[0].hidBeanId.value="commdocument";
		 document.forms[0].hidBeanGetMethod.value="createFile";
		 document.forms[0].hidscan.value="yes";
		 document.forms[0].appno.value=appno;
		 document.forms[0].action=appUrl+"action/appdocscan.jsp";
		 document.forms[0].submit();
	 }
 }

 function doScan()
 {
	 var file=ftpurl+document.forms[0].hidserverip.value+"&"+appno+"&"+document.forms[0].doc_code.value+"&"+totpage+".sdc";
	 var prop = "scrollbars=no,width=400,height=300,,top=100,left=250";	 
	 window.open(file,"",prop);
 }

 function doSave()
 { 

	 document.forms[0].cmdsave.disabled = true;
 	 document.forms[0].appno.value=appno;
 	 document.forms[0].hidSourceUrl.value="/action/appdocscan.jsp";
 	 document.forms[0].hidBeanId.value="commdocument";
	 document.forms[0].hidBeanMethod.value="updateDocumentScan";	
	 document.forms[0].hidBeanGetMethod.value="getDocumentScan";
     document.forms[0].action=appUrl+"controllerservlet";
	 document.forms[0].submit();
 }

 function doView()
 {

 	 document.forms[0].hidBeanId.value="commdocument";
	var prop = "scrollbars=yes,width=750,height=550,,top=10,left=20";
	var url="<%=ApplicationParams.getAppUrl()%>action/docscanpreview.jsp?appscan_appno="+document.forms[0].appscan_appno.value+"&comapp_companyname="+cmpname+"&apdoc_totpages="+document.forms[0].apdoc_totpages.value+"&doc_desc1="+document.forms[0].doc_desc1.value+"&hidserverip="+document.forms[0].hidserverip.value+"&doc_code="+document.forms[0].doc_code.value;
	window.open(url,"viewdoc",prop);
 }

 function doCancel()
 {
	if(ConfirmMsg(102))
	 {
		placeValues();
		disableFields(true);
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
	 }
 }

function doClose()
{
	/*if(document.forms[0].hiPgDist.value=="P")
	{
		document.forms[0].action=appUrl+"action/persearch.jsp";
	}else
	{
		document.forms[0].action=appUrl+"action/comsearch.jsp";
	}*/

	if(ConfirmMsg(100))
		{ 
			
			if("<%=strPgDist%>"=="P")
			{
				//document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/mastersearchper.jsp";
				document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/appdocumentsappl.jsp?hidAppDoc=A";
			}else
			{
				document.forms[0].action ="<%=ApplicationParams.getAppUrl()%>action/comsearch.jsp";
			}
			document.forms[0].submit();
		}
}

function openUsersWindow()
{
 	 document.forms[0].hidBeanId.value="commdocument";
	if(document.forms[0].cmdedit.disabled)
	{
	var strUrl = appUrl+"action/docverifyusers.jsp"; 
	xpos = 175;
	ypos = 150;
	window.open(strUrl,"users","width=400,height=300,left="+xpos+",top="+ypos);
	}
	//window.open(strUrl);
}

function menuOptionDivMouseDown (url)
{
	if(!document.forms[0].cmdsave.disabled)
	{
		ShowAlert(103);
		return;
	}
	document.currentMenu.style.display='none';
	document.currentMBarOpt.style.border='1px solid lightgrey';
	document.menuIsActive = false;
	document.forms[0].action=url;
	document.forms[0].submit();
}

function doAttachDocument()
{

 	 document.forms[0].hidBeanId.value="commdocument";
	document.forms[0].cmdviewdocument.disabled=false;
    var ApplicationNo = document.forms[0].appno.value;
    var document_code = 	document.forms[0].doc_code.value;
    var hidType = "document";
    if(ApplicationNo!="" && document_code!="")
    {	    	
		var purl = appUrl+"action/ifrmapplicantphoto.jsp?&ApplicationNo="+ApplicationNo+"&hidType="+hidType+"&document_code="+document_code;
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
	var appno=document.forms[0].appno.value;
	var appname=document.forms[0].comapp_companyname.value;
	var document_code = document.forms[0].doc_code.value;
	var document_description = document.forms[0].doc_desc1.value;
 	 document.forms[0].hidBeanId.value="commdocument";
	
	var appUrl="<%=ApplicationParams.getAppUrl()%>";
	var prop = "scrollbars=yes,width=900,height=750,,top=10,left=20,menubar=yes";
	var url=appUrl+"action/docscanpreview.jsp?appno="+appno+"&comapp_companyname="+appname+"&document_code="+document_code+"&document_description="+document_description;
	window.open(url,"viewdoc",prop);
}

</script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="placeValues();">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td>
		  
      <table width="100%" border="0" cellspacing="0" cellpadding="0" >
        <tr> 
          <td valign="top" colSpan=5> 
            <jsp:include page="../share/help.jsp" flush="true"/>
           
          </td>
        </tr>
        <tr>
          <td valign="top" colSpan=5><b><i>Document Scanning</i></b></td>
        </tr>
      </table>		
      </td>
    </tr>
 </table>
<form name="docscan" method="post" class="normal">
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="1" height="400" class="outertable">
    <tr> 
      <td valign="top" height="123"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" height="400" class="outertable">
          <tr> 
            <td height="280" valign="top"> <br>
              <div align="center"></div>
              <div align="center"> 
                <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable  linebor">
                  <tr> 
                    <td width="22%">Document 
                      type</td>
                    <td colspan="2">  
                      <input type="text" name="doc_type" size="15" readonly >
                      </td>
                    <td width="10%">&nbsp;</td>
                    <td width="15%">No. of 
                      pages</td>
                    <td colspan="2">  
                      <input type="text" name="apdoc_totpages" value="" size="5" maxlength=1 readonly>
                      </td>
                    <td width="15%">&nbsp;</td>
                    <td width="22%">  </td>
                  </tr>
                  <tr> 
                    <td height="20" width="22%">Description</td>
                    <td colspan="6">  
                      <input type="text" name="doc_desc1"    readonly size="50"  value="<%=Helper.correctNull((String)hshValues.get("doc_desc1"))%>">
                      </td>
                    <td height="20" width="15%" align="right">Scan 
                      Status</td>
                    <td height="20" width="22%">  
                      <select name="appscan_status"  size="1" disabled>
                        <option value="" selected>---Select---</option>
                        <option value="c">Current</option>
                        <option value="e">Expired</option>
                        <option value="s">Superceded</option>
                      </select>
                      </td>
                  </tr>
                  <tr> 
                    <td width="22%">Applicant 
                      ID</td>
                    <td colspan="2">  
                      <input type="text" name="comapp_companyid"   value="<%=Helper.correctNull((String)hshValues.get("comappid"))%>" size="12" readonly >
                      </td>
                    <td width="10%">&nbsp;</td>
                    <td width="15%">Application 
                      No</td>
                    <td colspan="2">  
                      <input type="text" name="appscan_appno"   size="20" readonly >
                      </td>
                    <td width="15%" align="right">Name</td>
                    <td width="22%">  
                      <input type="text" name="comapp_companyname"   readonly size="20" >
                      </td>
                  </tr>
                  <tr> 
                    <td width="22%">Valid 
                      From</td>
                    <td> 
                      <input type="text" name="appscan_validfrom"   size="12" maxlength=10  readonly>
                    </td>
                    <td><a href="javascript:callCalender('appscan_validfrom')" border=0><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a></td>
                    <td width="10%">&nbsp;</td>
                    <td width="15%">Valid 
                      Till</td>
                    <td width="9%">  
                      <input type="text" name="appscan_validto"   size="12" maxlength=10 
                      onBlur="checkDate(this);checkvalidfrom()" readonly>
                      </td>
                    <td width="5%"><a href="javascript:callCalender('appscan_validto')" border=0>
                    <img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0></a></td>
                    <td width="15%"></td>
                    <td width="22%"></td>
                  </tr>
                  <tr> 
                    <td width="22%">Scanned 
                      by</td>
                    <td colspan="2">  
                      <input type="text" name="appscan_scanby" size="20" readonly value="" >
                      </td>
                    <td width="10%">&nbsp;</td>
                    <td width="15%">On</td>
                    <td>  
                      <input type="text" name="appscan_scandate"   size="12" maxlength=10  onBlur="checkDate(this);checkmaxdate(this,currentdate);" readonly >
                      </td>
                    <td width="5%"><a href="javascript:callCalender('appscan_scandate')" border=0><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0></a></td>
                    <td width="15%" align="right">At</td>
                    <td width="22%">  
                      <input type="text" name="appscan_scantime"   size="10"  >
                      </td>
                  </tr>
                  <tr> 
                    <td width="22%">Verified 
                      By</td>
                    <td colspan="2">  
                      <input type="text" name="appscan_verifyby"   size="15" maxlength="10" readonly>
                      <a href="javascript:openUsersWindow()" class="blackfont"><b><img
									src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
									border="0" tabindex="81"></b></a></td>
                    <td width="10%">&nbsp;</td>
                    <td width="15%">On</td>
                    <td width="9%">  
                      <input type="text" name="appscan_verifydate"    size="12" maxlength="10" onBlur="checkDate(this);checkmaxdate(this,currentdate);" readonly>
                      </td>
                    <td width="5%"><a href="javascript:callCalender('appscan_verifydate')" border=0><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0></a></td>
                    <td width="15%">&nbsp;</td>
                    <td width="22%">  
                      <input type="text" name="verifiedat"   size="10" maxlength="5" readonly style="visibility:hidden">
                      </td>
                  </tr>
                  <tr> 
                    <td width="22%">Document</td>
                    <td colspan="2"></td>
                    <td width="10%">&nbsp;</td>
                    <td width="15%">&nbsp;</td>
                    <td colspan="4">&nbsp; </td>
                  </tr>
                  <tr> 
                    <td colspan="5" valign="top"> 
                      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                        <tr> 
                          <td width="7%">  
                            <input type="radio" name="appscan_imgtype" value="o" checked disabled>
                            </td>
                          <td width="21%">Original</td>
                          <td width="8%">  
                            <input type="radio" name="appscan_imgtype" value="c" disabled>
                            </td>
                          <td width="26%">Copy</td>
                          <td width="5%">  
                            <input type="radio" name="appscan_imgtype" value="n"  disabled>
                            </td>
                          <td width="30%">Notarised</td>
                        </tr>
                      </table>
                      <br>
                      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                        <tr> 
                          <td colspan="2">Doc. 
                            Custodian</td>
                          <td width="8%">&nbsp;</td>
                          <td width="26%">&nbsp;</td>
                          <td width="5%">&nbsp;</td>
                          <td width="30%">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="7%">&nbsp;</td>
                          <td width="21%">&nbsp;</td>
                          <td width="8%">&nbsp;</td>
                          <td width="26%">&nbsp;</td>
                          <td width="5%">&nbsp;</td>
                          <td width="30%">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="7%">  
                            <input type="radio" name="appscan_doccustody" value="b" style="border-style:none" checked disabled>
                            </td>
                          <td width="21%">Bank</td>
                          <td width="8%">  
                            <input type="radio" name="appscan_doccustody" value="a" style="border-style:none" disabled>
                            </td>
                          <td width="26%">Applicant</td>
                          <td width="5%">  
                            <input type="radio" name="appscan_doccustody" value="o"style="border-style:none" disabled>
                            </td>
                          <td width="30%">Other</td>
                        </tr>
                      </table>
                    </td>
                    <td width="9%"> 
                      <div align="center">Notes</div>
                    </td>
                    <td colspan="3"> 
                      <textarea name="appscan_notes" rows="6" cols="30" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" readonly><%=Helper.correctNull((String)hshValues.get("appscan_notes"))%></textarea>
                    </td>
                  </tr>
                </table>
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <br>
  <table border="0" cellspacing="0" cellpadding="0" align="center" class="outertable linbor" >
    <tr> 
      <td> 
        <table border="0" cellspacing="0" cellpadding="2" align="center" class="outertable">
        <tr>
         <td> 
		<lapschoice:combuttonnew
			btnnames='Edit_Save_Cancel_Attach Document_View Document_Audit Trail'
			btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
		<lapschoice:hiddentag pageid='<%=PageId%>'/></td>
        </tr>
        </table>
      </td>
    </tr>
  </table>
<input type="hidden" name="appno" value = "<%=strAppno%>">  
<input type="hidden" name="doc_code">
<INPUT TYPE="hidden" name="hiPgDist" value="<%=Helper.correctNull(request.getParameter("hiPgDist"))%>">
<input type="hidden" name="hidscan">
</form>
</body>
</html>


