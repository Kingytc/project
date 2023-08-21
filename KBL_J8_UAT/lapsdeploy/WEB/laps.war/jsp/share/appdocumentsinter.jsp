<%@include file="../share/directives.jsp"%>
<%  int intSize=0;
   ArrayList arrIJSPName= (ArrayList)hshValues.get("arrIJSPName");
	ArrayList arrIDocCode=(ArrayList)hshValues.get("arrIDocCode");
	ArrayList arrIDocDesc=(ArrayList)hshValues.get("arrIDocDesc");
	ArrayList arrIDocStatus	=(ArrayList)hshValues.get("arrIDocStatus");
	ArrayList arrIDocDate=(ArrayList)hshValues.get("arrIDocDate");
	ArrayList arrIDocScan=(ArrayList)hshValues.get("arrIDocScan");
	ArrayList arrIRenDate=(ArrayList)hshValues.get("arrIRendate");
	ArrayList arrIDelDoc=(ArrayList)hshValues.get("arrIDelDoc");
	ArrayList arrIRemarks=(ArrayList)hshValues.get("arrIRemarks");
	ArrayList arrIPrdDocDate=(ArrayList)hshValues.get("arrIPrdDocDate");
	ArrayList arrILDOC=(ArrayList)hshValues.get("arrILDOC");
	ArrayList arrDocAttach=(ArrayList)hshValues.get("arrDocAttach");
	ArrayList arrDocPrintCount=(ArrayList)hshValues.get("arrDocPrintCount");

	if(arrIDocCode!=null)
	{
		intSize = arrIDocCode.size();
	}
	String strappno = request.getParameter("appno");
	String strPgDist=Helper.correctNull(request.getParameter("hiPgDist"));
	String strRenDate="";
	String strCategory=Helper.correctNull((String)request.getParameter("hidCategoryType"));
	String strIpAddress=Helper.correctNull((String)hshValues.get("ipaddress"));
	String GroupRights=Helper.correctNull((String)session.getAttribute("strGroupRights"));
	String strProductType=Helper.correctNull((String)session.getAttribute("strProductType"));	
	int postSancCount=Integer.parseInt(Helper.correctInt((String)hshValues.get("postSancCount")));
	int preSancCount=Integer.parseInt(Helper.correctInt((String)hshValues.get("preSancCount")));
	int maxallowedPrintCount=Integer.parseInt(Helper.correctInt((String)hshValues.get("maxallowedPrintCount")));
	String app_status=Helper.correctNull((String)request.getParameter("appstatus"));
	
	String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
	if(strCategory.equals(""))
	{
		strCategory=strSessionModuleType;
	}
	if(strCategory.equalsIgnoreCase("DIGI"))
	{
		strCategory="RET";	
	}
	String strFacRejectCheck=Helper.correctNull((String)hshValues.get("Fac_RejectCheck"));
  %>

<html>
<head>
<title>Documents</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script>
var appno="<%=strappno%>";
var editflag=1;
var editlockflag="<%=hshValues.get("editlock")%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var varipaddress="<%=strIpAddress%>";
var intarrsize="<%=intSize%>";
var varModuleType="<%=strCategory%>";
var varGuardetails="<%=Helper.correctNull((String)hshValues.get("strGuardetails"))%>";
var maxallowedPrintCount="<%=maxallowedPrintCount%>";
var varfacslno="<%=Helper.correctNull((String)hshValues.get("hidfacslno"))%>";
var varGrpRights="<%=GroupRights.charAt(18)%>";
var varapp_migration="<%=Helper.correctNull((String)hshValues.get("APP_MIGRATION"))%>";
var varappholder="<%=Helper.correctNull((String)hshValues.get("appholder"))%>";
var varSolid="<%=Helper.correctNull((String)hshValues.get("strSolid"))%>";
var varappstatus="<%= app_status %>";
var docAttCount="<%= Helper.correctInt((String)hshValues.get("docAttCount"))%>";
var varUserID="<%= Helper.correctNull((String)session.getAttribute("strUserId"))%>";
var strSessionModuleType="<%=strSessionModuleType %>";

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
	<%if(arrIDocCode.size() >0){%>
	var checkVar="<%=request.getParameter("hideditflag")%>";
	len="<%=arrIDocCode.size()%>";

	if(len>1)
	{	
		for(i=0;i<len;i++)
		{	
			if((document.forms[0].hidapdoc_del[i].value=="I")&&(checkVar=="yes"))
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
		if((document.forms[0].hidapdoc_del.value=="I")&&(checkVar=="yes"))
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

	if (document.forms[0].appstatus.value == "Processed/Approved" )
	{
		 document.all.row_cbsid.style.display="table-row";
		 if(intarrsize!=0)
		 {
			 if(intarrsize==1)
			 {
				 document.forms[0].apdoc_substatus1.disabled=false;
			 }
			 else
			 {
				for(i=0;i<intarrsize;i++)
				{
				  document.forms[0].apdoc_substatus1[i].disabled=false;
				}
			 }
		}

		 document.forms[0].cmdcoapp.disabled=false; 
		 document.forms[0].cmdprinthistory.disabled=false; 
	}
	else
	{
		
		document.all.row_cbsid.style.display="none";
		if(intarrsize!=0){
			 if(intarrsize==1)
			    {
			    	 document.forms[0].apdoc_substatus1.disabled=true;
			    }
			    else
			    {
					for(i=0;i<intarrsize;i++)
					{
						document.forms[0].apdoc_substatus1[i].disabled=true;
					}
			    }
		}
		 document.forms[0].cmdprinthistory.disabled=true; 
		 document.forms[0].cmdcoapp.disabled=true; 
	}
	
	
	onCall();
	if(document.forms[0].cmdedit.disabled)
	{
		editflag=0;
	}	
	doAfterEdit();	
	if (document.forms[0].appstatus.value != "Open/Pending" )
	{
		disableFields(true);
	}
	if(varapp_migration=='Y'&& (varappholder==varSolid) &&  varappstatus=='Processed/Approved')
	{
		document.forms[0].cmdadd.disabled  = false;
		document.forms[0].cmddelete.disabled = false;
	}
	else if(docAttCount!="0" && (varappstatus == "Open/Pending" || varappstatus=='Processed/Approved'))
	{
		document.forms[0].cmdadd.disabled    = false;
		document.forms[0].cmddelete.disabled    = false;
	}
	else
	{
		document.forms[0].cmdadd.disabled    = true;
		document.forms[0].cmdedit.disabled    = true;
		document.forms[0].cmddelete.disabled    = true;
	}

	if(varModuleType=="CORP" || varModuleType=="AGR")
	{
		document.forms[0].sel_facilitysno.value=varfacslno;
		if(document.forms[0].sel_facilitysno.value=="0")
		{
			disableCommandButtons(true,true,true,true,true,false);
		}
	}
	if(varGrpRights=="r")
	{
		document.forms[0].cmdprinthistory.disabled=true; 
		document.forms[0].cmdcoapp.disabled=true; 
		document.forms[0].cmdadd.disabled    = true;
	  	document.forms[0].cmdedit.disabled   = true;
	  	document.forms[0].cmddelete.disabled   = true;
	}
	if(varapp_migration=='Y')
	{
		if(intarrsize!=0)
		{
			 if(intarrsize==1)
			    {
			    	 document.forms[0].apdoc_substatus1.disabled=true;
			    	 document.forms[0].apdoc_view.disabled=true;
			    }
			    else
			    {
					for(i=0;i<intarrsize;i++)
					{
						document.forms[0].apdoc_substatus1[i].disabled=true;
						document.forms[0].apdoc_view[i].disabled=true;
					}
			    }
		} 
	}
	<%if(!strFacRejectCheck.equalsIgnoreCase("")){
		if(strFacRejectCheck.equalsIgnoreCase("Y")){%>
		if(intarrsize!=0){
			 if(intarrsize==1)
			    {
			    	 document.forms[0].apdoc_substatus1.disabled=true;
			    }
			    else
			    {
					for(i=0;i<intarrsize;i++)
					{
						document.forms[0].apdoc_substatus1[i].disabled=true;
					}
			    }
		}
	<%}}%>

	

	
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
}

function doEdit()
{
	document.forms[0].hidBeanId.value="commdocument";
	document.forms[0].hidSourceUrl.value="/action/appdocumentsinter.jsp";
	document.forms[0].hideditflag.value="yes";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].action=appUrl+"action/appdocumentsinter.jsp";
	document.forms[0].hidAppDoc.value="I";
	document.forms[0].method="post";
	document.forms[0].submit();
}

function doAdd()
{
	disableCommandButtons(true,true,true,false,false,true);
	document.forms[0].hidAction.value="New";
	document.all.t1.style.visibility="visible";
	callDocList('I');
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
	document.forms[0].app_no.value=document.forms[0].appno.value;
	document.forms[0].hidBeanId.value="commdocument";
	document.forms[0].hidSourceUrl.value="/action/appdocumentsinter.jsp";
	document.forms[0].hidBeanMethod.value="updateDocument";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidAppDoc.value="I";
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].submit();
}

function doAfterEdit()
{

	<%if(Helper.correctNull((String)request.getParameter("appstatus")).equalsIgnoreCase("Processed/Approved") || Helper.correctNull((String)request.getParameter("appstatus")).equalsIgnoreCase("pa")){ %>
	  document.forms[0].btnenable.value="Y" 
	<%}%>
  	var editcheck="<%=request.getParameter("hideditflag")%>";
  	if(editcheck=="yes")
  	{
	  		disableCommandButtons(true,true,true,false,false,true);
		  	for(i=0;i<document.forms[0].apdoc_rendate.length;i++)
		  	{
		  		document.forms[0].apdoc_rendate[i].readOnly = false;
		  	}
		  	for(i=0;i<document.forms[0].apdoc_remarks.length;i++)
		  	{
		  		document.forms[0].apdoc_remarks[i].readOnly = false;
		  	}	  
  	}
   	else if (document.forms[0].btnenable.value == "N" )
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
function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hideditflag.value="no";	
		document.forms[0].hidBeanId.value="commdocument";
		document.forms[0].hidSourceUrl.value="/action/appdocumentsinter.jsp";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action=appUrl+"action/appdocumentsinter.jsp";
		document.forms[0].hidAppDoc.value="I";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}
function doDelete()
{
	if((varapp_migration!='Y') && document.forms[0].appholder.value!=varUserID)
	{
		alert("You cannot delete the documents");
		return;
	}
	
	if(varapp_migration=='Y'&& (varappholder==varSolid) &&  varappstatus=='Processed/Approved')
	{

	}
	else
	{
		if(document.forms[0].strappstatus.value!="op" && document.forms[0].strappstatus.value!="ol")
		{
			alert("You are not allowed to delete documents after Sanction/Rejection");
			return;
		}
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
				document.forms[0].hidBeanId.value="commdocument";
				document.forms[0].hidSourceUrl.value="/action/appdocumentsinter.jsp";
				document.forms[0].app_no.value=document.forms[0].appno.value;
				document.forms[0].hidBeanMethod.value="updateDocument";
				document.forms[0].hidAppDoc.value="I";
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
			document.forms[0].hidSourceUrl.value="/action/appdocumentsinter.jsp";
			document.forms[0].app_no.value=document.forms[0].appno.value;
			document.forms[0].hidBeanMethod.value="updateDocument";
			document.forms[0].hidAppDoc.value="I";
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
	<%if(intSize>1)
	{%>
  		for(var i=0;i<document.forms[0].chkapdoc_substatus.length;i++)
  		{
			document.forms[0].chkapdoc_substatus[i].disabled=val;		  
  		}
	<%}else if(intSize==1){%>  
	document.forms[0].chkapdoc_substatus.disabled=val;		  
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
		var url="<%=ApplicationParams.getAppUrl()%>action/apprules.jsp?hidBeanGetMethod=getDocumentRules&doc_code="+doccode+"&sno="+sno;;
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
		document.forms[0].hidBeanId.value="commdocument";
		document.forms[0].doc_code.value=doccode;
		document.forms[0].doc_desc1.value=docdesc;
		document.forms[0].doc_type.value=dtype;
		document.forms[0].hidBeanGetMethod.value="getDocumentScan";
		document.forms[0].action=appUrl+"action/appdocscan.jsp";
		document.forms[0].submit();
	}
}
function callApplicant()
{
	if(document.forms[0].cmdedit.disabled == true && document.forms[0].cmdsave.disabled != true)
	{
		ShowAlert(103);
	}
	else
	{
		document.forms[0].hidBeanId.value="commdocument";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/appdocumentsappl.jsp?hidBeanGetMethod=getData";
		document.forms[0].hidAppDoc.value="A";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}
function callDocList(doctype)
{
	if(document.forms[0].cmdadd.disabled == true)
	{
		var prop = "scrollbars=no,width=700,height=350,top=100,left=80";
		var url=appUrl+"action/appdoclist.jsp?doc_type="+doctype+"&ModuleType="+varModuleType;
		window.open(url,"",prop);
	}
}

function callView(page,i,docid,appcbsid)
{
	var approvercbsid=appcbsid;
    var prefix="DOC_"
	var doc_id=docid;;
	var pagename=prefix+page;
	
	var i=0;
	var page1="";
	
	for(;i<pagename.length;i++)
	{
		if(pagename.charAt(i)==" ")
		{
		
		}
		else
		{
		  page1=page1+pagename.charAt(i);
		}
	} 
	if(varModuleType=="CORP" || varModuleType=="AGR")
	{
		var appUrl="<%=ApplicationParams.getAppUrl()%>";
		var prop = "scrollbars=yes,width=750,height=550,,top=10,left=20";
		var url=appUrl+"action/"+pagename+".jsp?appno="+appno+"&doc_id="+doc_id+"&hidBeanId=commdocument&hidBeanGetMethod=getDocTemplateFacility&document_code="+page1+"&hidapprovercbsid="+approvercbsid+"&docOpenType=view&hidfacslno="+document.forms[0].sel_facilitysno.value;
		window.open(url,"viewdoc",prop);
	}
	else
	{
		var appUrl="<%=ApplicationParams.getAppUrl()%>";
		var prop = "scrollbars=yes,width=750,height=550,,top=10,left=20";
		var url=appUrl+"action/"+pagename+".jsp?appno="+appno+"&doc_id="+doc_id+"&hidBeanId=commdocument&hidBeanGetMethod=getDocTemplate&document_code="+page1+"&hidapprovercbsid="+approvercbsid+"&docOpenType=view&hidfacslno=1";
		window.open(url,"viewdoc",prop);
	}
	
	
}

function callPrint(page,i,docid,appcbsid,docprintcount)
{
	var a=i;
	<%
	if(intSize==1){%>
	document.forms[0].hidcnt.value=parseInt(document.forms[0].hidcnt.value)+1;
	a=document.forms[0].hidcnt.value;
	<%}else{%>
	document.forms[0].hidcnt[a].value=parseInt(document.forms[0].hidcnt[a].value)+1;
	a=document.forms[0].hidcnt[a].value;
	<%}%>
	//if(varModuleType=="RET" || varModuleType=="LAD")
	{	
		if(varGuardetails!="Y")
		{
		 	alert("Kindly Give a Edit & Apply in Co - Applicant / Guarantor Print");
			document.forms[0].cmdcoapp.focus();
			return;
		}
	}
	
	if(appcbsid!="")
	{
		if(parseInt(a)>maxallowedPrintCount)
		{
			alert("You cannot take a print, Maximum Print Count Exceeds");
			return;
		}
		else
		{
			var temp=parseInt(maxallowedPrintCount)-parseInt(a);
			alert(temp+" Attempts Left to Print Document !");
		}
		
	var approvercbsid=appcbsid;
    var prefix="DOC_"
	var doc_id=docid;;
	var pagename=prefix+page;
	
	var i=0;
	var page1="";
	
	for(;i<pagename.length;i++)
	{
		if(pagename.charAt(i)==" ")
			{
			
			}
		else
			{
			
			  page1=page1+pagename.charAt(i);
			 	
			}
		
	} 
		if(varModuleType=="CORP" || varModuleType=="AGR")
		{
			var appUrl="<%=ApplicationParams.getAppUrl()%>";
			var prop = "scrollbars=yes,width=750,height=550,,top=10,left=20,menubar=yes";
			var url=appUrl+"action/"+pagename+".jsp?appno="+appno+"&doc_id="+doc_id+"&hidBeanId=commdocument&hidBeanGetMethod=getDocTemplateFacility&document_code="+page1+"&hidapprovercbsid="+approvercbsid+"&docOpenType=print&hidfacslno="+document.forms[0].sel_facilitysno.value;
			window.open(url,"viewdoc",prop);
		}
		else
		{
			var appUrl="<%=ApplicationParams.getAppUrl()%>";
			var prop = "scrollbars=yes,width=750,height=550,,top=10,left=20,menubar=yes";
			var url=appUrl+"action/"+pagename+".jsp?appno="+appno+"&doc_id="+doc_id+"&hidBeanId=commdocument&hidBeanGetMethod=getDocTemplate&document_code="+page1+"&hidapprovercbsid="+approvercbsid+"&docOpenType=print&hidfacslno=1";
			window.open(url,"viewdoc",prop);
		}
	}
	else
	{
		alert("Enter Branch Head Customer ID/Authorised Signatory Customer ID");
		return;
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


function callDescCBS()
{	
	if(intarrsize=="0")
	{
		alert("Add any Documents");
		return;
	}
	pagename="appdocumentsinter"
	var varQryString = appURL+"action/CBSIDhelp.jsp?pagename="+pagename;
	var title = "SelectCBSID";
	var prop = "scrollbars=yes,menubar=yes,status=yes,width=500,height=400";
	prop = prop + ",left=50,top=150";
    window.open(varQryString,title,prop);	
}

function fnreadOnly(){
	document.forms[0].txt_cbscustid.readOnly=false;
}
function callDocAttachment()
{
	if(document.forms[0].cmdedit.disabled == true && document.forms[0].cmdsave.disabled != true)
	{
		ShowAlert(103);
	}
	else
	{
		if(strSessionModuleType=="DIGI")
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
			document.forms[0].hidAppDoc.value="A";
			document.forms[0].hidBeanId.value="DmsDocument";
			document.forms[0].hidBeanMethod.value="getDocumentURLs";
			document.forms[0].hidBeanGetMethod.value="getDocumentDetails";
			document.forms[0].hidSourceUrl.value="/action/appdocumentattachment.jsp?docpagetype=pre";
			document.forms[0].action=appUrl+"controllerservlet";
			document.forms[0].submit(); 
			
			//shiva
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
		if(strSessionModuleType=="DIGI")
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
function initShowHideDivs()
{
	 
		var divs = document.getElementsByTagName('DIV');
		var divCounter = 1;
		for(var no=0;no<divs.length;no++){
			if(divs[no].className=='dhtmlgoodies_question'){
				divs[no].onclick = showHideContent;
				divs[no].id = 'dhtmlgoodies_q'+divCounter;
				var answer = divs[no].nextSibling;
				while(answer && answer.tagName!='DIV'){
					answer = answer.nextSibling;
				}
				answer.id = 'dhtmlgoodies_a'+divCounter;
				contentDiv = answer.getElementsByTagName('DIV')[0];
				contentDiv.style.top = 0 - contentDiv.offsetHeight + 'px';
				contentDiv.className='dhtmlgoodies_answer_content';
				contentDiv.id = 'dhtmlgoodies_ac' + divCounter;
				answer.style.display='none';
				answer.style.height='1px';
				divCounter++;
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
function calldocdetails()
{
		var varQryString = appURL+"action/com_documentprintdetails.jsp?hidBeanId=commdocument&hidBeanGetMethod=printDocumentDetails&appno="+document.forms[0].app_no.value+"&btnenable="+document.forms[0].btnenable.value+"&sel_facilitysno=0";
		var title = "SelectCBSID";
		var prop = "scrollbars=yes,menubar=yes,status=yes,width=800,height=400";
		prop = prop + ",left=50,top=150";
	    window.open(varQryString,title,prop);
}
function callPrintHistory()
{
		var varQryString = appURL+"action/Document_printHistory.jsp?hidBeanId=commdocument&hidBeanGetMethod=getDocumentPrintHistory&appno="+document.forms[0].app_no.value+"&btnenable="+document.forms[0].btnenable.value+"&hidfacslno="+document.forms[0].sel_facilitysno.value;
		var title = "SelectCBSID";
		var prop = "scrollbars=yes,menubar=yes,status=yes,width=800,height=400";
		prop = prop + ",left=50,top=150";
	    window.open(varQryString,title,prop);
}


function callIFrame()
{
	document.forms[0].app_no.value=document.forms[0].appno.value;
	document.forms[0].hidBeanMethod.value="updateDocument";
	document.forms[0].hidAppDoc.value="I";
	document.forms[0].hidBeanId.value = "commdocument";
	document.forms[0].hidBeanGetMethod.value = "getData";
	document.forms[0].action = appURL + "action/appdocumentsinter.jsp";
	document.forms[0].submit();
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
<body onLoad="placeValues()">
<form  method="post" action="" class="normal">

 <% if(strSessionModuleType.equals("RET") || strSessionModuleType.equals("LAD")) { %>

        <jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="5" />
        </jsp:include>

	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
    <tr> 
      <td class="page_flow"> Home -&gt;
      <%
        if(strCategory.equals("AGR"))
         { %>Agriculture <% }
        else if(strCategory.equals("LAD"))
         {
         %>  Loan Against Gold Ornaments &amp; Deposits  
       <%} 
        else { %> Retail <% }%> 
        
        -&gt; Documents -&gt; By Bank</td>
    </tr>
  </table>
  
    <% } else if(strSessionModuleType.equalsIgnoreCase("DIGI")) { %>
  
   <jsp:include page="../share/applurllinkerdigi.jsp" flush="true"> 
        <jsp:param name="pageid" value="5" />
      </jsp:include>
	 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	        <tr> 
	      <td class="page_flow">Home -&gt; Retail -&gt; Documents -&gt; By Bank</td>
	    </tr>    
	  </table>
  
  <% } else { %>
  
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
		 Home -&gt; Agriculture -&gt; Application  -&gt; Documents -&gt; By Bank
		 </td>
		</tr>
		</table><%} else {%>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
		    <tr>
		        
				<td class="page_flow">Home&nbsp;-&gt;Corporate &amp; SME -&gt; Application  -&gt; Documents -&gt; By Bank</td>
		    </tr>
		</table>
		<%} %>
  
  <% } %>
  
   <lapschoice:application/> 
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td> 
        <table width="70%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr> 
            <td width="10%"  align="center" class="sub_tab_inactive"><b><a href="javascript:callApplicant()" >By Applicant</a></b>
            </td>
            <%if(true){ %>
              <td width="15%"  align="center" class="sub_tab_inactive"><b><a href="javascript:callDocAttachment()">Pre Sanction Document Attachment</a></b> </td>
            <%} %>
            <td width="10%"  align="center" class="sub_tab_active"><b>By Bank </b></td>
            <%if(app_status.equalsIgnoreCase("Processed/Approved")||app_status.equalsIgnoreCase("Closed/Approved")|| strSessionModuleType.equalsIgnoreCase("DIGI")){ %>
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
  
   <% if(strSessionModuleType.equals("CORP") || strSessionModuleType.equals("AGR")) { %>
  
    <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
 		 <tr>
				<td align="center">
				Facility &nbsp; &nbsp;
				<select name="sel_facilitysno" tabindex="1" onchange="callIFrame();">
				<option value="0" selected="selected">--Select--</option>
                <lapschoice:ComMisDetailsTag apptype='<%=Helper.correctNull((String)request.getParameter("appno")) %>' page='mis'/>
				</select>
				</td>
		  </tr>
  	</table>
  	
  	<% } else { %>
  		<tr style="display: none;">
				<td>
				<input type="hidden" name="sel_facilitysno" value="1">
				</td>
			</tr>
  	
  	<% } %>
  
  <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                <tr> 
                  <td valign="top" > 
                      
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
                      <tr> 
                        <td width="50%" valign="top"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                            <tr> 
                            
                              <td valign="top">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                                  <tr> 
                                     
                                    <td colspan="6"> 
                                      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable linebor">
                                          <tr id="row_cbsid" class="dataheader">
                                          
                                          <td  colspan="6" align="center">Branch Head Customer ID/Authorised Signatory Customer ID<span class="mantatory">*</span>&nbsp;&nbsp;&nbsp;<input type="text" readonly="readonly"
													name="txt_cbscustid" size="12" maxlength="10"  
													value="<%=Helper.correctNull((String)hshValues.get("cbscustid"))%>">
												<b><span onClick="javascript:callDescCBS()" style="cursor: hand" id="idsearch"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0"></span></b></td>
                                      </tr>
                                        <tr class="dataheader"> 
                                          <td width="3%"><b>&nbsp;</b></td>
                                          <td width="65%" align="center">Documents</td>
                                          <!-- <td width="0%" align="center"></td> -->
                                          <td width="11%" align="center">Print</td>
                                          <td width="7%" align="center">Delete Document</td>
                                          <td width="14%" align="center">Remarks<b>&nbsp;&nbsp;</b></td>
                                        </tr>
                                       
                                        <% 
										  int i=0; 
											 for(int j=0;j<intSize;j++){
												%>
												 
                                        <tr class="datagrid"> 
                                          <input type="hidden" name="apdoc_doccode" value="<%=arrIDocCode.get(j)%>">
                                          <td width="3%"> 
 
                                            <input type="checkbox" name="chkapdoc_substatus" value="y"  <%if(((Helper.correctNull((String)arrIDocStatus.get(j))).equalsIgnoreCase("y")) || (Helper.correctNull((String)arrIDelDoc.get(j)).trim().equalsIgnoreCase("I"))){%> checked="checked" <%}%> onClick="putValue(<%=i%>)" style="border:none">
                                            <input type="hidden"  name="apdoc_substatus" value="<%=Helper.correctNull((String)arrIDocStatus.get(j))%>">
                                          </td>
                                          <td> 
                                            <input type="text" name="doc_desc"  readonly="readonly" style="cursor:hand;border:0;background-color:#ECF1F9" size="120" value="<%=Helper.correctNull((String)arrIDocDesc.get(j))%>" onClick="callRulePage('<%=arrIDocCode.get(j)%>',<%=j%>)">
                                             <input type="hidden" name="doc_desc1" >
                                            <input type="hidden" name="apdoc_subdate" value="<%=Helper.correctNull((String)arrIDocDate.get(j))%>" style="border:0;background-color: #DEDACF" readonly="readonly" size="12" >
                                          </td>
                                          <% if (arrIRenDate.size()>0)
														{
															strRenDate = Helper.correctNull((String)arrIRenDate.get(j));
														}
													%>
                                          <!-- <td width="0%" align="center"> 
                                            <input type="hidden" name="apdoc_rendate" style="border-style:groove"  size="12" readonly="readonly" onBlur="checkDate(this)">
                                          </td> -->
                                          <td width="5%"  align="center">                                           
                                              <% 
														String strPageName ="";
													    String docid="";
													    String DocPrintCount="";
													if (arrIRenDate.size()>0)
														{
															strPageName = Helper.correctNull((String)arrIJSPName.get(j));	
															docid = Helper.correctNull((String)arrIDocCode.get(j));
															DocPrintCount= Helper.correctNull((String)arrDocPrintCount.get(j));
														}
													%>
                                              <input type="button" name="apdoc_substatus1"  value=" Print " style="border:0;cursor:hand;font-weight:bold" class="buttonOthers" onClick="callPrint('<%=strPageName%>',<%=j%>,'<%=docid%>',document.forms[0].txt_cbscustid.value,'<%=DocPrintCount%>')">
                                              <input type="button" name="apdoc_view"  value=" View " style="border:0;cursor:hand;font-weight:bold" class="buttonOthers" onClick="callView('<%=strPageName%>',<%=j%>,'<%=docid%>',document.forms[0].txt_cbscustid.value)">                                               
                                               <input type="hidden" name="apdoc_scan_pages" size="30" style="border-style:groove" readOnly="readonly" value="0">
                                               <input type="hidden" name="hidcnt" size="30"  value="<%=DocPrintCount %>">
                                           </td>
                                          <td width="7%" align="center"> 
                                            <input type="hidden" name="hidapdoc_del" value="<%=Helper.correctNull((String)arrIDelDoc.get(j))%>">
                                            <% 
											if(Helper.correctNull((String)arrIDelDoc.get(j)).trim().equalsIgnoreCase("I"))
											{%>
                                            <input type="radio" name="apdoc_del"  value="<%=arrIDocCode.get(j)%>" onclick="chkFlag(this,'<%=arrDocAttach.get(i) %>')"  style="width:50;color:#CC3300; background-color:#C4ECFF;border:0;font-weight:bold;">
                                            <%
											}else
											{
											%>
                                            <input type="radio" name="apdoc_del"  value="<%=arrIDocCode.get(j)%>" style="width:50;color:#CC3300; background-color:#C4ECFF;border:0;font-weight:bold;visibility:hidden">
                                            <%
											}
											%>
                                          </td>
                                          <td width="12%" align="center"> 
                                              <input type="text" name="apdoc_remarks" size="30" style="border-style:groove" readOnly="readonly" value="<%=Helper.correctNull((String)arrIRemarks.get(j))%>">
											  <input type="hidden" name="apdoc_prddoc_date" size="30" style="border-style:groove" readOnly="readonly" value="<%=Helper.correctNull((String)arrIPrdDocDate.get(j))%>">
											  
                                            </td>
                                        </tr>
                                        <%i++;
											}%>
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
                    		<td><br><a href="#" onClick="openFolderView('<%=Helper.correctNull((String)request.getParameter("inwardno"))%>','')"><b>Link for DMS</b></a> </td>
                    	</tr>-->
                      <tr> 
                        <td> 
                          <div align="center"> 
                            <input type="hidden" name="print1"  value="Print DP Note " style="width:120;background-color:#8F8369;color:white;font-weight:bold" onClick="ShowReport('printdocument.jsp')">
                            <input type="hidden" name="print12"  value="Print Hypothecation " style="width:130;background-color:#8F8369;color:white;font-weight:bold" onClick="ShowReport('hypovehicle.jsp')">
                          </div>
                        </td>
                      </tr>
                      <tr>
                        <td>
                          <p>&nbsp;</p><table width="50%" border="0" cellspacing="0" cellpadding="0" align="center" id="t1" style="visibility:hidden" class="outertable">
                            <tr>
                              <td width="50%"><!-- Add 
                                Document --> 
                                <input type="hidden" name="hidNewDocCode">
								 <input type="hidden" name="hidNewDocDate">
                                </td>
                              <td width="58%"> 
                                <input type="hidden" name="txtDocuments" size="50" style="border-style:groove" readOnly="readonly">
                              </td>
                              <td width="2%"><b><!-- <a href="javascript:callDocList('I')" class="blackfont"><img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
												 border="0"></a> --></b></td>
                            </tr>
                          </table></td>
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
  
 	<table width="50%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
 	<tr>
 	<td>
    <lapschoice:combuttonnew btnnames='Add_Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
    </td>
    </tr>
    <tr>
    <td align="center"><input type="button" name="cmdcoapp" value="Co-Applicant / Guarantor Print" onClick="calldocdetails();" class="buttonOthers">
    <input type="button" name="cmdprinthistory" value="Print History" onClick="callPrintHistory();" class="buttonOthers"></td>
    </tr>
    </table>
  
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input  type="hidden" name="hidAppDoc">
  <input type="hidden" name="app_no" value="<%=strappno %>">
  <input type="hidden" name="strInsFlag" value="<%=hshValues.get("strInsFlag")%>" >
  <input type="hidden" name="doc_code">
  <input type="hidden" name="doc_type">
  <input type="hidden" name="doc_desc1">
  <input type="hidden" name="hidserverip" value="<%=ApplicationParams.getIP()%>">
  <INPUT TYPE="hidden" name="hidDemoId" value="<%=request.getParameter("hidDemoId")%>">
  <INPUT TYPE="hidden" name="radLoan" value="Y">
  <input type="hidden" name="hidAppDocType" value="I">
  <input type="hidden" name="hidAppDocCode">
  <input type="hidden" name="apdoc_scan_pages">
  <input type="hidden" name="hidRendate">
  <input type="hidden" name="hidRemarks">
  <input type="hidden" name="hidPrdDate">
  <input type="hidden" name="hidDocumentType1">
  <input type="hidden" name="hidDocumentType">
</form>
</body>
</html>
