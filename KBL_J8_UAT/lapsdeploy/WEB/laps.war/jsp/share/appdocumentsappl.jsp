<%@include file="../share/directives.jsp"%>
<%	int intSize=0;
    ArrayList arrADocCode=(ArrayList)hshValues.get("arrADocCode");
	ArrayList arrADocDesc=(ArrayList)hshValues.get("arrADocDesc");
	ArrayList arrADocStatus=(ArrayList)hshValues.get("arrADocStatus");
	ArrayList arrADocDate=(ArrayList)hshValues.get("arrADocDate");
	ArrayList arrADocScan=(ArrayList)hshValues.get("arrADocScan");
	ArrayList arrARenDate=(ArrayList)hshValues.get("arrARendate");
	ArrayList arrADelDoc=(ArrayList)hshValues.get("arrADelDoc");
	ArrayList arrARemarks=(ArrayList)hshValues.get("arrARemarks");
	ArrayList arrAPrdDocDate=(ArrayList)hshValues.get("arrAPrdDocDate");	
	ArrayList arrTotPages=(ArrayList)hshValues.get("arrTotPages");
	ArrayList arrDocAttach=(ArrayList)hshValues.get("arrDocAttach");
	ArrayList arrASubType=(ArrayList)hshValues.get("arrASubType");
	
	if(arrADocCode!=null)
	{
		intSize = arrADocCode.size();		
	}
	String strDate1="";
	String strPgDist=Helper.correctNull(request.getParameter("hiPgDist"));
	String strCategory=Helper.correctNull((String)request.getParameter("hidCategoryType"));
	String strIpAddress=Helper.correctNull((String)hshValues.get("ipaddress"));
	String strProductType=Helper.correctNull((String)session.getAttribute("strProductType"));
	String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
	if(strCategory.equals(""))
	{
		strCategory=strSessionModuleType;
	}
	if(strCategory.equalsIgnoreCase("DIGI"))
	{
		strCategory="RET";	
	}
	
	String app_status=Helper.correctNull((String)request.getParameter("appstatus"));
	String StrDigiLoanType=Helper.correctNull((String)session.getAttribute("StrDigiLoanType")).trim();

	%>
<html>
<head>
<title>Documents</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script>
var editflag=1;
var editlockflag="<%=hshValues.get("editlock")%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var varipaddress="<%=strIpAddress%>";
var varModuleType="<%=strCategory%>";
var SessionModuleType="<%= strSessionModuleType %>";
var docAttCount="<%= Helper.correctInt((String)hshValues.get("docAttCount"))%>";
var varUserID="<%= Helper.correctNull((String)session.getAttribute("strUserId"))%>";
var StrDigiLoanType="<%= StrDigiLoanType%>";

function ShowReport(page)
{
	var appno = document.forms[0].appno.value;
	var url = "<%=ApplicationParams.getAppUrl()%>action/"+page+"?appno="+appno;
	var title = "FairReport";
	var prop = "scrollbars=yes,width=775,height=550,menubar=yes";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
}
 
function onCall()
{
    <%if(arrADocCode.size() >0){%>
	var checkVar="<%=request.getParameter("hideditflag")%>";
	len="<%=arrADocCode.size()%>";
	if(len>1)
	{
		for(i=0;i<len;i++)
		{
			if((document.forms[0].hidapdoc_del[i].value=="A")&&(checkVar=="yes"))
			{
				document.forms[0].apdoc_del[i].disabled=true;	
				document.forms[0].chkapdoc_substatus[i].disabled=true;	
			}
			else
			{
				document.forms[0].apdoc_del[i].disabled=false;	
				document.forms[0].chkapdoc_substatus[i].disabled=true;	
			}
		}
	}
	else
	{
		if((document.forms[0].hidapdoc_del.value=="A")&&(checkVar=="yes"))
		{
			document.forms[0].apdoc_del.disabled=true;	
			document.forms[0].chkapdoc_substatus.disabled=true;	
		}
		else
		{
			document.forms[0].apdoc_del.disabled=false;	
			document.forms[0].chkapdoc_substatus.disabled=true;	
		}
	}
<%}%>
}

function placeValues()
{	
	onCall();
	if(document.forms[0].cmdedit.disabled)
	{
		editflag=0;
	}
	
	if (document.forms[0].appstatus.value != "Open/Pending" )
	{
		document.forms[0].cmdadd.disabled    = true;
	  	document.forms[0].cmdedit.disabled   = true;
	  	document.forms[0].cmddelete.disabled    = true;
	  	document.forms[0].cmdsave.disabled  = true;
	  	document.forms[0].cmdcancel.disabled = true;
	 	document.forms[0].cmdclose.disabled  = false;
		disableFields(true);
	}
	doAfterEdit();
	if(docAttCount!="0" && document.forms[0].appstatus.value == "Open/Pending")
	{
		document.forms[0].cmdadd.disabled    = false;
		document.forms[0].cmddelete.disabled    = false;
	}
}

function putValue(i)
{
	document.forms[0].hidDocumentType1.value=document.forms[0].doc_desc[i].value;
	if(document.forms[0].chkapdoc_substatus[i].checked)
	{
		document.forms[0].apdoc_substatus[i].value="y";
	}
	else 
	{
		document.forms[0].apdoc_substatus[i].value="n";
	}
	if (document.forms[0].appstatus.value == "Processed/Approved")
	{
		document.forms[0].chkapdoc_substatus[i].disabled = true;
	}
}

function doAdd()
{
	disableCommandButtons(true,true,true,false,false,true);
	document.forms[0].hidAction.value="New";
	document.all.t1.style.visibility="visible";
	callDocList('A');
}

function doEdit()
{
	document.forms[0].hideditflag.value="yes";
	document.forms[0].hidSourceUrl.value="appdocumentsappl.jsp";
	document.forms[0].hidBeanId.value="commdocument";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].action=appUrl+"action/appdocumentsappl.jsp";
	document.forms[0].hidAppDoc.value="A";
	document.forms[0].method="post";
	document.forms[0].submit();
}

function doSave()
{
	if(document.forms[0].hidAction.value=="New" && document.forms[0].hidNewDocCode.value=="")
	{	
		alert("Select New Document");
		return false;
	}
	if(document.forms[0].hidAction.value!="New")
	{
		document.forms[0].hidAction.value = "update";
	}
	document.forms[0].cmdsave.disabled = true;
 	document.forms[0].app_no.value = document.forms[0].appno.value;
	document.forms[0].hidSourceUrl.value="appdocumentsappl.jsp";
	document.forms[0].hidBeanId.value="commdocument";
	document.forms[0].hidBeanMethod.value="updateDocument";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].action=appUrl+"action/controllerservlet";
	document.forms[0].hidAppDoc.value="A";
	document.forms[0].cmdsave.disabled=true;
 	document.forms[0].submit();
}

function doAfterEdit()
{

	<%if(Helper.correctNull((String)request.getParameter("appstatus")).equalsIgnoreCase("Processed/Approved") || Helper.correctNull((String)request.getParameter("appstatus")).equalsIgnoreCase("pa")){ %>
	  //document.forms[0].btnenable.value="Y" 
	<%}%>
	var doclen="<%=arrADocCode.size()%>";	
  var editcheck="<%=request.getParameter("hideditflag")%>";
  if(editcheck=="yes")
  {
	  disableCommandButtons(true,true,true,false,false,true);
	  for(i=0;i<document.forms[0].apdoc_rendate.length;i++)
	  {
	  	document.forms[0].apdoc_rendate[i].readOnly = false;
	  }

	if(doclen>1)
	{
	  for(i=0;i<document.forms[0].apdoc_remarks.length;i++)
	  {
	  	document.forms[0].apdoc_remarks[i].readOnly = false;
	  }
	}
	else
	{
	  	document.forms[0].apdoc_remarks.readOnly = false;
	}
  }
  else if (document.forms[0].btnenable.value== "N")
	{	  
	  	document.forms[0].cmdadd.disabled    = true;
	  	document.forms[0].cmdedit.disabled   = true;
	  	document.forms[0].cmddelete.disabled    = true;
	  	document.forms[0].cmdsave.disabled  = true;
	  	document.forms[0].cmdcancel.disabled = true;
	 	document.forms[0].cmdclose.disabled  = false;	  
    }
  	else 
  	{
	  	disableFields(true);
	  	if(document.forms[0].btnenable.value=="Y")
	  	{
			disableCommandButtons(false,false,false,true,true,false);
	  	}
  	} 
}
function doDelete()
{
	if(document.forms[0].appholder.value!=varUserID)
	{
		alert("You cannot delete the documents");
		return;
	}
	if(document.forms[0].strappstatus.value!="op" && document.forms[0].strappstatus.value!="ol")
	{
		alert("You are not allowed to delete documents after Sanction/Rejection");
		return;
	}
	var doclen = document.forms[0].apdoc_del.length;
	var bool = false;
	if(document.forms[0].apdoc_del.length!=undefined)
	{
		for(i=0;i<doclen;i++)
		{
			if(document.forms[0].apdoc_del[i].checked == true)
			{
				bool = true;
				if(ConfirmMsg(101))
		        {	
					document.forms[0].hidAction.value = "delete";
					document.forms[0].app_no.value=document.forms[0].appno.value;
					document.forms[0].hidSourceUrl.value="/action/appdocumentsappl.jsp";
					document.forms[0].hidBeanId.value="commdocument";
					document.forms[0].hidBeanMethod.value="updateDocument";
					document.forms[0].hidBeanGetMethod.value="getData";
					document.forms[0].hidAppDoc.value="A";
					document.forms[0].action=appUrl+"action/controllerservlet";
					document.forms[0].cmdsave.disabled=true;
					document.forms[0].submit();	
				}		
			}
		}
	}
	else
	{
		bool = true;
		if(ConfirmMsg(101))
        {	
			document.forms[0].hidAction.value = "delete";
			document.forms[0].hidBeanId.value="commdocument";
			document.forms[0].hidSourceUrl.value="/action/appdocumentsappl.jsp";
			document.forms[0].app_no.value=document.forms[0].appno.value;
			document.forms[0].hidBeanMethod.value="updateDocument";
			document.forms[0].hidAppDoc.value="A";
			document.forms[0].action=appUrl+"action/controllerservlet";
			document.forms[0].cmdsave.disabled=true;
			document.forms[0].submit();
		}
	}
	if(bool == false)
	{
		alert("Select Documents to delete");
		return false;
	}
}
function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hideditflag.value="no";
		document.forms[0].hidSourceUrl.value="appdocumentsappl.jsp";
		document.forms[0].hidBeanId.value="commdocument";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action=appUrl+"action/appdocumentsappl.jsp";
		document.forms[0].hidAppDoc.value="A";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}
function doClose()
{
	if("<%=strPgDist%>"=="P")
	{
		document.forms[0].action=appUrl+"action/persearch.jsp";
	}
	else
	{
		document.forms[0].action=appUrl+"action/comsearch.jsp";
	}
	document.forms[0].method="post";
	document.forms[0].submit();
}
function disableFields(val)
{
	<%if(intSize>0)
	{%>
	  	for(var i=0;i<document.forms[0].chkapdoc_substatus.length;i++)
	  	{
			document.forms[0].chkapdoc_substatus[i].disabled=val;	 
	  	}
  <%}%>
}
function disableCommandButtons(cmdadd,cmdedit,cmddelete,cmdsave,cmdcancel,cmdclose)
{
  	document.forms[0].cmdadd.disabled=cmdadd;
  	document.forms[0].cmdedit.disabled=cmdedit;
  	document.forms[0].cmddelete.disabled=cmddelete;
  	document.forms[0].cmdsave.disabled=cmdsave;
  	document.forms[0].cmdcancel.disabled=cmdcancel;
	document.forms[0].cmdclose.disabled=cmdclose;
}
function callRulePage(doccode,sno)
{
	if(document.forms[0].cmdedit.disabled==true)
	{
		return;
		document.forms[0].hidBeanId.value="commdocument";
		var url="<%=ApplicationParams.getAppUrl()%>action/apprules.jsp?hidBeanGetMethod=getDocumentRules&doc_code="+doccode+"&sno="+sno;
		var title = "";
		var prop = "scrollbars=no,width=600,height=300";
		var xpos = 120;
		var ypos = 100;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(url,title,prop);
	}	
}
function callScanPage(doccode,dtype,docdesc,docno)
{
	if(document.forms[0].chkapdoc_substatus[docno].checked == true && document.forms[0].chkapdoc_substatus[docno].disabled == true)
	{
		document.forms[0].doc_code.value=doccode;
		document.forms[0].doc_desc1.value=docdesc;
		document.forms[0].doc_type.value=dtype;
		document.forms[0].hidBeanId.value="commdocument";
		document.forms[0].hidBeanGetMethod.value="getDocumentScan";
		document.forms[0].action=appUrl+"action/appdocscan.jsp";
		document.forms[0].submit();
	}
}
function changeScanColor()
{
	<%if(intSize>0)
	{%>
		for(i=0;i<document.forms[0].apdoc_substatus12.length;i++)
		{
			if(document.forms[0].apdoc_substatus12[i].value == "Yes")
			{
				document.forms[0].apdoc_substatus12[i].style.color="green";
			}
			else
			{
				document.forms[0].apdoc_substatus12[i].style.color="red";
			}
		}
	<%}%>
}
function callInternal()
{
	if(document.forms[0].cmdedit.disabled == true && document.forms[0].cmdsave.disabled != true)
	{
		ShowAlert(103);
	}
	else
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/appdocumentsinter.jsp?hidBeanGetMethod=getData";
		document.forms[0].hidAppDoc.value="I";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}
function callDocList(doctype)
{
	if(document.forms[0].cmdadd.disabled == true)
	{
		var prop = "scrollbars=no,width=700,height=350,top=100,left=80";
		var url=appUrl+"action/appdoclist.jsp?doc_type="+doctype+"&ModuleType="+varModuleType+"&strSubType=pre";
		window.open(url,"",prop);
	}
}
function callRBIGuidelines()
{
	if(document.forms[0].cmdedit.disabled == true && document.forms[0].cmdsave.disabled != true)
	{
		ShowAlert(103);
	}
	else
	{
		document.forms[0].hidBeanId.value="comproposal";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/com_rbi_guidelines_restr.jsp?hidBeanGetMethod=getRBIGuidelines_restr&strPageType=G";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}
function callDocAttachment()
{
	if(document.forms[0].cmdedit.disabled == true && document.forms[0].cmdsave.disabled != true)
	{
		ShowAlert(103);
	}
	else
	{
		if(SessionModuleType=="DIGI" || StrDigiLoanType=="PC")
		{
			document.forms[0].hidAppDoc.value="A";
			document.forms[0].hidBeanId.value="DigitalAppInterface";
			document.forms[0].hidBeanMethod.value="getDocumentURLs";
			document.forms[0].hidBeanGetMethod.value="getDocumentDetailsdigi";
			document.forms[0].hidSourceUrl.value="/action/appdocumentattachment.jsp?docpagetype=pre";
			document.forms[0].action=appUrl+"controllerservlet";
			document.forms[0].submit();					
		}
		else
		{
			//shiva
			 document.forms[0].hidAppDoc.value="A";
			document.forms[0].hidBeanId.value="DmsDocument";
			document.forms[0].hidBeanMethod.value="getDocumentURLs";
			document.forms[0].hidBeanGetMethod.value="getDocumentDetails";
			document.forms[0].hidSourceUrl.value="/action/appdocumentattachment.jsp?docpagetype=pre";
			document.forms[0].action=appUrl+"controllerservlet";
			document.forms[0].submit(); 
			
			<%-- document.forms[0].hidBeanId.value="commdocument";
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/appdocumentattachment.jsp?hidBeanGetMethod=getdmsdoc&docpagetype=pre";
			document.forms[0].hidAppDoc.value="A";
			document.forms[0].method="post";
			document.forms[0].submit(); --%>
			
			<%-- document.forms[0].hidBeanId.value="commdocument";
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/appdocumentattachment.jsp?hidBeanGetMethod=getDocumentDetails&docpagetype=pre";
			document.forms[0].hidAppDoc.value="A";
			document.forms[0].method="post";
			document.forms[0].submit(); --%>

		}
	}
}
function callpostsancDocAttachment()
{
	if(document.forms[0].cmdedit.disabled == true && document.forms[0].cmdsave.disabled != true)
	{
		ShowAlert(103);
	}
	else
	{
		if(SessionModuleType=="DIGI" || StrDigiLoanType=="PC")
		{
			document.forms[0].hidAppDoc.value="A";
			document.forms[0].hidBeanId.value="DigitalAppInterface";
			document.forms[0].hidBeanMethod.value="getDocumentURLs";
			document.forms[0].hidBeanGetMethod.value="getDocumentDetailsdigi";
			document.forms[0].hidSourceUrl.value="/action/apppostsancDocattachment.jsp?docpagetype=post";
			document.forms[0].action=appUrl+"controllerservlet";
			document.forms[0].submit();					
		}
		else
		{
			document.forms[0].hidBeanId.value="commdocument";
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/apppostsancDocattachment.jsp?hidBeanGetMethod=getDocumentDetails&docpagetype=post";
			document.forms[0].hidAppDoc.value="A";
			document.forms[0].method="post";
			document.forms[0].submit();
		}
	}
}
function chkFlag(obj,valcnt)
{
	if(valcnt!=0)
	{
		alert("Delete the relevant documents in Document Attachment tab before deleting the document");
		obj.checked=false;
		return;
	}
}

function callBureauRep()
{
	if(document.forms[0].cmdedit.disabled == true && document.forms[0].cmdsave.disabled != true)
	{
		ShowAlert(103);
	}
	else
	{
		document.forms[0].hidBeanId.value="perapplicant";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/appcibilinterface.jsp?hidBeanGetMethod=getCIBILReport";	
		document.forms[0].method="post";
 		document.forms[0].submit();	
	}
}


</script>
</head>
<body onLoad="placeValues();">
<form name="docForm" method="post" class="normal">

 <% if(strSessionModuleType.equals("RET") || strSessionModuleType.equals("LAD")) { %>

        <jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="5" />
        </jsp:include>
 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
        <tr> 
      <td class="page_flow">Home -&gt;
      <%if(strCategory.equals("AGR"))
      { %>Agriculture <% }
      else if(strCategory.equals("LAD"))
      {
      %> Loan Against Gold Ornaments &amp; Deposits  
      <%} 
      else { %> Retail <%} %>
       -&gt; Documents -&gt; By Applicant</td>
    </tr>    
  </table>
  
  <% } else if(strSessionModuleType.equalsIgnoreCase("DIGI")) {%>
  
   <jsp:include page="../share/applurllinkerdigi.jsp" flush="true"> 
        <jsp:param name="pageid" value="5" />
        </jsp:include>
 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
        <tr> 
      <td class="page_flow">Home -&gt; Retail -&gt; Documents -&gt; By Applicant</td>
    </tr>    
  </table>
  
  <% } else  { %>
  
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr>
		<td><jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="77" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
	</table>

		<%if(strSessionModuleType.equalsIgnoreCase("AGR")){ %>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
		<tr> 
		 <td class="page_flow">
		 Home -&gt; Agriculture -&gt; Application  -&gt; Documents -&gt; By Applicant
		 </td>
		</tr>
		</table><%} else {%>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
		    <tr>
		        
				<td class="page_flow">Home&nbsp;-&gt;Corporate &amp; SME -&gt; Application  -&gt; Documents -&gt; By Applicant</td>
		    </tr>
		</table>
		<%} %>

  <% }  %>
  
    <lapschoice:application/> 
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr>
      <td>
        <table width="70%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr> 
            <td align="center" width="10%" class="sub_tab_active"><b>By Applicant</b>
            </td>
            <%if(true){ %>
            <td width="15%"  align="center" class="sub_tab_inactive"><b><a href="javascript:callDocAttachment()" >Pre Sanction Document Attachment</a></b> </td>
            <%} %>
            <td align="center" width="10%" class="sub_tab_inactive"><b><a href="javascript:callInternal()">By Bank</a></b>
            </td>
            <%if(app_status.equalsIgnoreCase("Processed/Approved")||app_status.equalsIgnoreCase("Closed/Approved") || strSessionModuleType.equalsIgnoreCase("DIGI")){ %>
            <td width="15%"  align="center" class="sub_tab_inactive"><b><a href="javascript:callpostsancDocAttachment()">Post Sanction Document Attachment</a></b> </td>
            <%} %>
            <%if((strCategory.equals("RET") || strCategory.equals("LAD") )&&(Helper.correctNull((String)hshValues.get("strAppType")).equalsIgnoreCase("S"))){ %>
            <td align="center" width="10%" class="sub_tab_inactive"><b><a href="javascript:callRBIGuidelines()">RBI Guidelines</a></b>
            </td>
            <%} %>
            <%if(Helper.correctNull(ApplicationParams.getCIBILENABLE()).equalsIgnoreCase("TRUE")) { %>
            <td align="center" width="10%" class="sub_tab_inactive"><b><a href="javascript:callBureauRep()">Bureau Report</a></b> </td>
            <% } %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                <tr> 
                  <td valign="top" align="left"><br>                      
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
                      <tr> 
                        <td width="50%" valign="top"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                            <tr> 
                              <td valign="top">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                                  <tr> 
                                    <td colspan="7"> 
                                      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable linebor">
                                        <tr class="dataheader"> 
                                          <td width="5%">&nbsp;</td>
                                          <td align="center">Documents<!--Received 
                                            Date --></td>
                                          <td width="0%" align="center"><!-- Renewal 
                                            Date --></td>
                                          <%-- <td width="15%" align="center">Scan 
                                            Status</td>--%>
                                          <td width="7%" align="center">Delete 
                                            Document </td>
                                          <td width="7%" align="center">Remarks<b></b>&nbsp;&nbsp;</td>
                                        </tr>
                                        <%
										    int i=0;boolean bflag=true;
										    for(i=0;i<intSize;i++){
										    if(Helper.correctNull((String)arrASubType.get(i)).equalsIgnoreCase("Pre")){
												if(bflag)
												{
													bflag=false;%>
													<tr class="dataheader">
												<td colspan="6"> Pre Sanction Documents </td>
											</tr>
													
												<%}%>
                                        <tr class="datagrid"> 
                                          <input type="hidden" name="apdoc_doccode" value="<%=arrADocCode.get(i)%>">
                                          <td width="5%"> 
                                            <input type="checkbox" name="chkapdoc_substatus" value="y"  <%if(((Helper.correctNull((String)arrADocStatus.get(i))).equalsIgnoreCase("Y"))  || (Helper.correctNull((String)arrADelDoc.get(i)).trim().equalsIgnoreCase("A"))
											)
											{%> checked="checked" <%}%> onclick="putValue(<%=i%>)" style="border:0">
                                            <input type="hidden"  name="apdoc_substatus" value="<%=Helper.correctNull((String)arrADocStatus.get(i))%>">
                                          </td>
                                          <td> 
                                            <input type="text" name="doc_desc"  readonly="readonly" style="cursor:hand;border:0;background-color:#ECF1F9" size="90" value="<%=Helper.correctNull((String)arrADocDesc.get(i))%>" onClick="callRulePage('<%=arrADocCode.get(i)%>',<%=i%>)">
                                            <input type="hidden" name="doc_desc1" value="">
                                           <input type="hidden" name="apdoc_subdate" value="<%=Helper.correctNull((String)arrADocDate.get(i))%>" style="border:0;background-color: #DEDACF" readonly="readonly" size="12" >
                                          </td>
                                          <% if (arrARenDate.size()>0)
											{
												 strDate1 = Helper.correctNull((String)arrARenDate.get(i));
											}
											%>
                                          <td width="0%" align="center"> 
                                            <input type="hidden" name="apdoc_rendate" style="border:0"  size="12" value="<%//=strDate1%>" readonly="readonly" onBlur="checkDate(this)">
                                          </td>
                                           <%-- <td width="15%" align="center">
                                              <input type="hidden" name="apdoc_scan_pages" style="border:0"  size="12" value="<%=Helper.correctNull((String)arrTotPages.get(i))%>" readonly="readonly" >
                                             <input type="button" name="apdoc_substatus12"  value="<%=Helper.correctNull((String)arrADocScan.get(i))%>" style="width:50;cursor:hand;" class="buttonOthers" onClick="callScanPage('<%=arrADocCode.get(i)%>','Applicant','<%=arrADocDesc.get(i)%>','<%=i%>')">
                                           </td>--%>
                                          <td width="7%"> 
                                            <input type="hidden" name="hidapdoc_del" value="<%=Helper.correctNull((String)arrADelDoc.get(i))%>">
                                            <% 
 										if(Helper.correctNull((String)arrADelDoc.get(i)).trim().equalsIgnoreCase("A"))
											{%>
                                            <input type="radio" name="apdoc_del"  value="<%=arrADocCode.get(i)%>" onclick="chkFlag(this,'<%=arrDocAttach.get(i) %>')"   style="width:50;color:#CC3300;border:0;">
                                            <%}else{%>
                                            <input type="radio" name="apdoc_del"  value="<%=arrADocCode.get(i)%>"  style="width:50;color:#CC3300;border:0;visibility:hidden">
                                            <%}%>
                                          </td>
                                          <td width="7%" align="center"> 
                                              <input type="text" name="apdoc_remarks" size="30" style="border-style:groove;" readonly="readonly" maxlength="4000" value="<%=Helper.correctNull((String)arrARemarks.get(i))%>">
                                          	<input type="hidden" name="apdoc_prddoc_date" size="30" style="border-style:groove" readonly="readonly" value="<%=Helper.correctNull((String)arrAPrdDocDate.get(i))%>">
                                           </td>
                                        </tr>
                                        <%}}bflag=true;
                                        
                                        for(i=0;i<intSize;i++){
										    if(Helper.correctNull((String)arrASubType.get(i)).equalsIgnoreCase("Post")){
												if(bflag)
												{
													bflag=false;%>
													<tr class="dataheader">
												<td colspan="6"> Post Sanction Documents </td>
											</tr>
													
												<%}%>
                                        <tr class="datagrid"> 
                                          <input type="hidden" name="apdoc_doccode" value="<%=arrADocCode.get(i)%>">
                                          <td width="5%"> 
                                            <input type="checkbox" name="chkapdoc_substatus" value="y"  <%if(((Helper.correctNull((String)arrADocStatus.get(i))).equalsIgnoreCase("Y"))  || (Helper.correctNull((String)arrADelDoc.get(i)).trim().equalsIgnoreCase("A"))
											)
											{%> checked="checked" <%}%> onclick="putValue(<%=i%>)" style="border:0">
                                            <input type="hidden"  name="apdoc_substatus" value="<%=Helper.correctNull((String)arrADocStatus.get(i))%>">
                                          </td>
                                          <td> 
                                            <input type="text" name="doc_desc"  readonly="readonly" style="cursor:hand;border:0;background-color:#ECF1F9" size="90" value="<%=Helper.correctNull((String)arrADocDesc.get(i))%>" onClick="callRulePage('<%=arrADocCode.get(i)%>',<%=i%>)">
                                            <input type="hidden" name="doc_desc1" value="">
                                           <input type="hidden" name="apdoc_subdate" value="<%=Helper.correctNull((String)arrADocDate.get(i))%>" style="border:0;background-color: #DEDACF" readonly="readonly" size="12" >
                                          </td>
                                          <% if (arrARenDate.size()>0)
											{
												 strDate1 = Helper.correctNull((String)arrARenDate.get(i));
											}
											%>
                                          <td width="0%" align="center"> 
                                            <input type="hidden" name="apdoc_rendate" style="border:0"  size="12" value="<%//=strDate1%>" readonly="readonly" onBlur="checkDate(this)">
                                          </td>
                                          <td width="7%"> 
                                            <input type="hidden" name="hidapdoc_del" value="<%=Helper.correctNull((String)arrADelDoc.get(i))%>">
                                            <% 
 										if(Helper.correctNull((String)arrADelDoc.get(i)).trim().equalsIgnoreCase("A"))
											{%>
                                            <input type="radio" name="apdoc_del"  value="<%=arrADocCode.get(i)%>" onclick="chkFlag(this,'<%=arrDocAttach.get(i) %>')"   style="width:50;color:#CC3300;border:0;">
                                            <%}else{%>
                                            <input type="radio" name="apdoc_del"  value="<%=arrADocCode.get(i)%>"  style="width:50;color:#CC3300;border:0;visibility:hidden">
                                            <%}%>
                                          </td>
                                          <td width="7%" align="center"> 
                                              <input type="text" name="apdoc_remarks" size="30" style="border-style:groove;" readonly="readonly" maxlength="4000" value="<%=Helper.correctNull((String)arrARemarks.get(i))%>">
                                          	<input type="hidden" name="apdoc_prddoc_date" size="30" style="border-style:groove" readonly="readonly" value="<%=Helper.correctNull((String)arrAPrdDocDate.get(i))%>">
                                           </td>
                                        </tr>
                                        <%}}%>
                                      </table>
                                      </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                    	<!-- <tr align="center">
                    		<td><a href="#" onClick="openFolderView('<%=Helper.correctNull((String)request.getParameter("inwardno"))%>','')"><b>Link for DMS</b></a></td>
                    	</tr> -->
                      <tr> 
                        <td align="center"> 
                            <input type="hidden" name="print1"  value="Print DP Note " style="width:120;background-color:#8F8369;color:white;font-weight:bold" onClick="ShowReport('printdocument.jsp')">
                            <input type="hidden" name="print12"  value="Print Hypothecation " style="width:130;background-color:#8F8369;color:white;font-weight:bold" onClick="ShowReport('hypovehicle.jsp')">
                        </td>
                      </tr>
                      <tr>
                        <td>
                          <table width="50%" border="0" cellspacing="0" cellpadding="0" align="center" id="t1" style="visibility:hidden" class="outertable">
                            <tr> 
                               <td width="50%"><!--Add 
                                Document  -->
                                <input type="hidden" name="hidNewDocCode">
								 <input type="hidden" name="hidNewDocDate">
                                </td>
                              <td width="58%"> 
                                <input type="hidden" name="txtDocuments" size="50" style="border-style:groove" readonly="readonly">
                              </td>
                              <td width="2%">&nbsp;</td>
                           </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <br>
 	<lapschoice:combuttonnew btnnames='Add_Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
	<lapschoice:hiddentag pageid='<%=PageId%>'/>
	  <input  type="hidden" name="hidAppDoc">
	  <input type="hidden" name="app_no">
	  <input type="hidden" name="strInsFlag" value="<%=hshValues.get("strInsFlag")%>" >
	  <input type="hidden" name="doc_code">
	  <input type="hidden" name="doc_type">
	  <input type="hidden" name="doc_desc1">
	  <input type="hidden" name="hidserverip" value="<%=ApplicationParams.getIP()%>">
	  <input type="hidden" name="hidimgpath" value="<%=request.getRealPath("img")%>" >
	  <INPUT TYPE="hidden" name="hidDemoId" value="<%=request.getParameter("hidDemoId")%>">
	  <INPUT TYPE="hidden" name="radLoan" value="Y">
	  <input type="hidden" name="hidAppDocType" value="A">
	  <input type="hidden" name="hidAppDocCode">
	  <input type="hidden" name="hidAppDocDate">
	  <input type="hidden" name="hidRendate">
	  <input type="hidden" name="hidRemarks">
	  <input type="hidden" name="hidPrdDate">
      <input type="hidden" name="hidDocumentType1">
      <input type="hidden" name="hidDocumentType">
</form>
</body>
</html>
