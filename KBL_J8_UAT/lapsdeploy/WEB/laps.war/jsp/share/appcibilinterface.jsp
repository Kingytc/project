<%@include file="../share/directives.jsp"%>

<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />

<%	if (objValues instanceof java.util.HashMap) {

		hshValues = (java.util.HashMap) objValues;

	}

	ArrayList arrRow = new ArrayList();

	ArrayList arrCol = null;

	int intArrSize=0;

	if (hshValues != null) {

		arrRow = (ArrayList) hshValues.get("arrRow");

		if(arrRow!=null  && !arrRow.isEmpty())
		{ 
			intArrSize = arrRow.size();
		}		

	}	

	String inwardno = Helper.correctNull((String) hshValues.get("inwardno"));

	String strCategory=Helper.correctNull((String)request.getParameter("hidCategoryType"));

	String strCompleted= Helper.correctNull((String)hshValues.get("initStatus"));

	String strFTPPath=ApplicationParams.getFtpPath().replace("\\","\\\\");

	String strStatusBut = "",strStatus="",strFetchBut="",strGenerateBut="",strChkFlag="",strErrorDesc="",strFetchGenFlag="";

	String strGenAppStatus = Helper.correctNull((String) hshValues.get("gen_appstatus"));
	
	String app_status=Helper.correctNull((String)request.getParameter("appstatus"));
	
	if(strCategory.equals(""))
		strCategory=Helper.correctNull((String) session.getAttribute("sessionModuleType"));
	if(strCategory.equals(""))
		strCategory=Helper.correctNull((String) hshValues.get("hidCategoryType"));
%>

<html>

<head>

<title>Appraisal - LoanDetails</title>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">

<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>

<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>

<script  src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>

<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>

<SCRIPT LANGUAGE="JavaScript">

var appUrl = "<%=ApplicationParams.getAppUrl()%>";

var appUrl1 = "<%=strFTPPath%>";

var currdate = "<%=Helper.getCurrentDateTime()%>";

var strper_appid="<%=Helper.correctNull((String) hshValues.get("strper_appid"))%>";

var appstatus="<%=Helper.correctNull((String) request.getParameter("appstatus"))%>";

var comments="<%=Helper.correctNull((String) hshValues.get("Pagename"))%>";

var varpageid="<%=Helper.correctNull((String) hshValues.get("PageId"))%>";

var varSize = "<%=intArrSize %>";


function callonload()

{

	disabledFields(true);

	if("<%=strGenAppStatus %>" !="")

		alert("<%=strGenAppStatus %>");

	if(varSize==1)
	{
		document.forms[0].rad_inner_doc.disabled=false;
	}
	else
	{
		for(var i=0;i<varSize;i++)
		{
			document.forms[0].rad_inner_doc[i].disabled=false;
		}
	}

}



function doClose()

{

	var con = ConfirmMsg('100');

	if(con)

	{

	 document.forms[0].action=appUrl+"action/retailpge.jsp";

	  document.forms[0].submit();

	}

}

function fnCibilReportPDF(varappid,varstatus,varrefno,varStatusErr,varSno,varFetchBut,val1,val2,val3)

{

	if(document.forms[0].btnenable.value=="Y")
	{
		if(varSize > 1)
		{

			for(var i=0;i<varSize;i++)
			{
				if(document.forms[0].rad_inner_doc[i].checked!=true)
				{
					eval("document.forms[0].radcibil"+i+"[0]").checked=false;
					eval("document.forms[0].radcibil"+i+"[0]").disabled=true;
					eval("document.forms[0].radcibil"+i+"[1]").checked=false;
					eval("document.forms[0].radcibil"+i+"[1]").disabled=true;
					document.forms[0].cmd_fetch[i].disabled=true;
					document.forms[0].cmd_cibil[i].disabled=true;
					document.forms[0].cmd_Regenerate[i].disabled=true;
					document.all.idGen[i].style.display="none";
					document.all.idReg[i].style.display="none";
		
				}
				else
				{
					if(val2=="CRIFHighMark")
					{
						eval("document.forms[0].radcibil"+i+"[0]").checked=true;
						eval("document.forms[0].radcibil"+i+"[0]").disabled=false;
						eval("document.forms[0].radcibil"+i+"[1]").checked=false;
						eval("document.forms[0].radcibil"+i+"[1]").disabled=false;
					}
					else if(val2=="CIBIL")
					{
						eval("document.forms[0].radcibil"+i+"[0]").checked=false;
						eval("document.forms[0].radcibil"+i+"[0]").disabled=false;
						eval("document.forms[0].radcibil"+i+"[1]").checked=true;
						eval("document.forms[0].radcibil"+i+"[1]").disabled=false;
					}
					else
					{
						eval("document.forms[0].radcibil"+i+"[0]").checked=false;
						eval("document.forms[0].radcibil"+i+"[0]").disabled=false;
						eval("document.forms[0].radcibil"+i+"[1]").checked=false;
						eval("document.forms[0].radcibil"+i+"[1]").disabled=false;
					}
					if(val1=="I"||val1=="P")
					{
						document.all.idGen[i].style.display="table-row";
						document.all.idReg[i].style.display="none";
						document.forms[0].cmd_fetch[i].disabled=true;
						document.forms[0].cmd_cibil[i].disabled=true;
						document.forms[0].cmd_Regenerate[i].disabled=true;
					}
					else if(val1=="PS")
					{
						document.all.idGen[i].style.display="table-row";
						document.all.idReg[i].style.display="none";
						document.forms[0].cmd_fetch[i].disabled=false;
						document.forms[0].cmd_cibil[i].disabled=true;
						document.forms[0].cmd_Regenerate[i].disabled=true;
					}
					else if(val1=="S")
					{
						if(val3=="Y")
						{
							document.all.idGen[i].style.display="none";
							document.all.idReg[i].style.display="table-row";
							document.forms[0].cmd_fetch[i].disabled=true;
							document.forms[0].cmd_cibil[i].disabled=true;
							document.forms[0].cmd_Regenerate[i].disabled=false;
							eval("document.forms[0].radcibil"+i+"[0]").checked=false;
							eval("document.forms[0].radcibil"+i+"[0]").disabled=false;
							eval("document.forms[0].radcibil"+i+"[1]").checked=false;
							eval("document.forms[0].radcibil"+i+"[1]").disabled=false;
						}
						else
						{
							document.all.idGen[i].style.display="table-row";
							document.all.idReg[i].style.display="none";
							document.forms[0].cmd_fetch[i].disabled=true;
							document.forms[0].cmd_cibil[i].disabled=false;
							document.forms[0].cmd_Regenerate[i].disabled=true;
						}
					}
					else
					{
						document.all.idGen[i].style.display="table-row";
						document.all.idReg[i].style.display="none";
						document.forms[0].cmd_fetch[i].disabled=false;
						document.forms[0].cmd_cibil[i].disabled=true;
						document.forms[0].cmd_Regenerate[i].disabled=true;
					}
				}
			}

		}

		else

		{
			if(document.forms[0].rad_inner_doc.checked==true)
			{
				if(val2=="CRIFHighMark")
				{
					document.forms[0].radcibil0[0].checked=true;
					document.forms[0].radcibil0[0].disabled=false;
					document.forms[0].radcibil0[1].checked=false;
					document.forms[0].radcibil0[1].disabled=false;
				}
				else if(val2=="CIBIL")
				{
					document.forms[0].radcibil0[0].checked=false;
					document.forms[0].radcibil0[0].disabled=false;
					document.forms[0].radcibil0[1].checked=true;
					document.forms[0].radcibil0[1].disabled=false;
				}
				else
				{
					document.forms[0].radcibil0[0].checked=false;
					document.forms[0].radcibil0[0].disabled=false;
					document.forms[0].radcibil0[1].checked=false;
					document.forms[0].radcibil0[1].disabled=false;
				}
				if(val1=="I"||val1=="P")
				{
					document.all.idGen.style.display="table-row";
					document.all.idReg.style.display="none";
					document.forms[0].cmd_fetch.disabled=true;
					document.forms[0].cmd_cibil.disabled=true;
					document.forms[0].cmd_Regenerate.disabled=true;
				}
				else if(val1=="PS")
				{
					document.all.idGen.style.display="table-row";
					document.all.idReg.style.display="none";
					document.forms[0].cmd_fetch.disabled=false;
					document.forms[0].cmd_cibil.disabled=true;
					document.forms[0].cmd_Regenerate.disabled=true;
				}
				else if(val1=="S")
				{
					if(val3=="Y")
					{
						document.all.idGen.style.display="none";
						document.all.idReg.style.display="table-row";
						document.forms[0].cmd_fetch.disabled=true;
						document.forms[0].cmd_cibil.disabled=true;
						document.forms[0].cmd_Regenerate.disabled=false;
						document.forms[0].radcibil0[0].checked=false;
						document.forms[0].radcibil0[0].disabled=false;
						document.forms[0].radcibil0[1].checked=false;
						document.forms[0].radcibil0[1].disabled=false;
					}
					else
					{
						document.all.idGen.style.display="table-row";
						document.all.idReg.style.display="none";
						document.forms[0].cmd_fetch.disabled=true;
						document.forms[0].cmd_cibil.disabled=false;
						document.forms[0].cmd_Regenerate.disabled=true;
					}
				}
				else
				{
					document.all.idGen.style.display="table-row";
					document.all.idReg.style.display="none";
					document.forms[0].cmd_fetch.disabled=false;
					document.forms[0].cmd_cibil.disabled=true;
					document.forms[0].cmd_Regenerate.disabled=true;
				}
				
				
			}

		}
	}

/*	if(varFetchBut == "")

	{

		if(varSize > 1)

		{

			document.forms[0].chk_cibil[varSno].disabled=false;

			document.forms[0].chk_crif[varSno].disabled=false;

			document.forms[0].chk_equifax[varSno].disabled=false;

		}

		else

		{

			document.forms[0].chk_cibil.disabled=false;

			document.forms[0].chk_crif.disabled=false;

			document.forms[0].chk_equifax.disabled=false;

		}

	} */

	var varappno = document.forms[0].appno.value;	

	document.forms[0].hidAppIdVal.value = varappid;	

	document.forms[0].hidstatusVal.value = varstatus;	

	document.forms[0].hidstatusErr.value = varStatusErr;	

	if(varstatus == "S"){

		document.all.ifrm3.src=appUrl+"action/iframeDocView.jsp?hidBeanId=perfinancial&hidBeanGetMethod=getCIBILView&varrefno="+varrefno;	 	 

	}else{

		document.all.ifrm3.src=""; 

	}	



	/*

	document.all.statusIdHeader.innerHTML = "<font color='Black'><b>CIBIL Status :</b></font>";

	if(varstatus == "P"){

	  document.all.statusId.innerHTML = "<font color='Blue'><b>Pending</b></font>";

	}else if(varstatus == "S"){

	  document.all.statusId.innerHTML = "<font color='Green'><b>Success</b></font>";

	}else if(varstatus == "PS"){

	  document.all.statusId.innerHTML = "<font color='Red'><b>Partial Success -"+varStatusErr+"</b></font>";

	}else if(varstatus == "I"){

	  document.all.statusId.innerHTML = "Initiated";

	}else{

	  document.all.statusId.innerHTML = "Not Initiated";	

	}

	*/

}

function invokeProcCall(val,val2,varappid,varstatus,varapptype)

{
	document.forms[0].hidAppIdVal.value = varappid;	

	document.forms[0].hidstatusVal.value = varstatus;

	document.forms[0].hidBorrowerType.value = varapptype;

	if(val == "GenReport" && document.forms[0].hidAppIdVal.value == "")

	{

		alert("Select Applicant/Co-Applicant");

		return false;

	}
	if(varSize==1)
	{
		if(!document.forms[0].rad_inner_doc.checked)
		{
			alert("Select Applicant");
			return false;
		}
	}
	else
	{
		if(!document.forms[0].rad_inner_doc[val2].checked)
		{
			alert("Select Applicant/Co-Applicant");
			return false;
		}
	}

	if(val == "procCall" || val == "ReGenReport")
	{

		var varfield=eval("document.forms[0].radcibil"+val2);
		if(varfield[0].checked||varfield[1].checked)
		{
			if(varfield[0].checked)
				document.forms[0].hidRequest.value=varfield[0].value;
			else
				document.forms[0].hidRequest.value=varfield[1].value;
		}
		if(document.forms[0].hidRequest.value=="")
		{
			alert("Select Report type CRIF/CIBIL");
			return;
		}
	}

	

	/*

	if(document.forms[0].hidstatusVal.value == "P"){

		alert("Pending With CIBIL.");

		return false;

	}

	if(document.forms[0].hidstatusVal.value == "S"){

		alert("Already CIBIL generated.");

		return false;

	}

	if(document.forms[0].hidstatusVal.value == "PS"){

	

		alert("Partially Success: "+document.forms[0].hidstatusErr.value);

		return false;

	}

	

	

	if(varSize > 1)

	{

		if(document.forms[0].chk_cibil[val2].checked || document.forms[0].chk_crif[val2].checked || document.forms[0].chk_equifax[val2].checked)

		{

		}

		else

		{

			alert("Atleast one should be selected!!");

			return;

		}

		

		if(document.forms[0].chk_cibil[val2].checked)

			document.forms[0].chk_cibil[val2].value="Y";

		else

			document.forms[0].chk_cibil[val2].value="N";

		if(document.forms[0].chk_crif[val2].checked)

			document.forms[0].chk_crif[val2].value="Y";

		else

			document.forms[0].chk_crif[val2].value="N";

		if(document.forms[0].chk_equifax[val2].checked)

			document.forms[0].chk_equifax[val2].value="Y";

		else

			document.forms[0].chk_equifax[val2].value="N"; 

		

		document.forms[0].hidSelChk.value = document.forms[0].chk_cibil[val2].value + "@" + document.forms[0].chk_crif[val2].value + "@" + document.forms[0].chk_equifax[val2].value;

	}

	else

	{

		if(document.forms[0].chk_cibil.checked || document.forms[0].chk_crif.checked || document.forms[0].chk_equifax.checked)

		{

		}

		else

		{

			alert("Atleast one should be selected!!");

			return;

		}

		

		if(document.forms[0].chk_cibil.checked)

			document.forms[0].chk_cibil.value="Y";

		else

			document.forms[0].chk_cibil.value="N";

		if(document.forms[0].chk_crif.checked)

			document.forms[0].chk_crif.value="Y";

		else

			document.forms[0].chk_crif.value="N";

		if(document.forms[0].chk_equifax.checked)

			document.forms[0].chk_equifax.value="Y";

		else

			document.forms[0].chk_equifax.value="N";



		document.forms[0].hidSelChk.value = document.forms[0].chk_cibil.value + "@" + document.forms[0].chk_crif.value + "@" + document.forms[0].chk_equifax.value;

	} */

        document.forms[0].hidSelChk.value = "Y@N@N";

	if(val == "ReGenReport")
	{
		document.forms[0].hidAction.value=val;

		document.forms[0].hidBeanId.value="perapplicant";

		document.forms[0].hidBeanGetMethod.value="getCIBILRegenerate";	

		document.forms[0].action=appURL+"action/appcibilinterface.jsp";


		document.forms[0].submit();
	}else{

	document.forms[0].hidAction.value=val;

	document.forms[0].hidBeanId.value="perfinancial";

	document.forms[0].hidBeanGetMethod.value="invokeProcedureCIBIL";	

	document.forms[0].action=appURL+"action/appcibilinterface.jsp";


	document.forms[0].submit();
	}

}

function disabledFields(flag)

{

	for(var i=0;i<document.forms[0].length;i++)

	{

		if(document.forms[0].elements[i].type=="checkbox")

		{

			document.forms[0].elements[i].disabled=flag;	  

		}
		if(document.forms[0].elements[i].type=="radio")

		{

			document.forms[0].elements[i].disabled=flag;	  

		}
		if(document.forms[0].elements[i].type=="button")

		{

			document.forms[0].elements[i].disabled=flag;	  

		}
		

	}

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

function callDocAttachment()
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
function callpostsancDocAttachment()
{
	document.forms[0].hidBeanId.value="commdocument";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/apppostsancDocattachment.jsp?hidBeanGetMethod=getDocumentDetails&docpagetype=post";
	document.forms[0].hidAppDoc.value="A";
	document.forms[0].method="post";
	document.forms[0].submit();
}
function funDownload(varstatus,varrefno,val1)
{
	if(varSize==1)
	{
		if(!document.forms[0].rad_inner_doc.checked)
		{
			alert("Select Applicant");
			return false;
		}
	}
	else
	{
		if(!document.forms[0].rad_inner_doc[val1].checked)
		{
			alert("Select Applicant/Co-Applicant");
			return false;
		}
	}
	if(varstatus == "S")
	{
		var qryString=appURL+"action/"+varrefno+".html?&hidBeanId=perfinancial&hidBeanGetMethod=getCIBILView&varrefno="+varrefno;
		var prop="scrollbars=yes,menubar=yes,width=20, height=20";
		window.open(qryString,"BUREAUREPORT",prop);	 	 
	}
	else
	{
		document.all.ifrm3.src=""; 
	}	
}
</SCRIPT>
<style type="text/css">
#ifrm3{
    zoom: 0.83;
    -moz-transform:scale(5);
    -moz-transform-origin: 0 0;
    -o-transform: scale(5);
    -o-transform-origin: 0 0;   
    -webkit-transform: scale(5);
    -webkit-transform-origin: 0 0;
}
</style>
</head>

<body onload="callonload();">

<form name="appform" method="post" class="normal">

 <% if(strCategory.equals("RET") || strCategory.equals("LAD")) { %>

<%

String strPath="";
strPath="Home -> Retail -> Documents -> Bureau Report";

%>
    <jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="5" />
        </jsp:include>
     
   <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">     
		<tr> 
			<td class="page_flow">Home -&gt; Documents -&gt; Bureau Report</td>
		</tr>
	</table>

 <lapschoice:application/> 
 
   <% } else if(strCategory.equalsIgnoreCase("DIGI")) {%>
 
  
   <jsp:include page="../share/applurllinkerdigi.jsp" flush="true"> 
        <jsp:param name="pageid" value="5" />
       </jsp:include>
 	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
        <tr> 
    		 <td class="page_flow">Home -&gt; Retail -&gt; Documents -&gt; Bureau Report</td>
    	</tr>    
 	 </table>
  
  <lapschoice:application/> 
 
 
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

		<%if(strCategory.equalsIgnoreCase("AGR")){ %>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
		<tr> 
		 <td class="page_flow">
		 Home -&gt; Agriculture -&gt; Application  -&gt; Documents -&gt; Bureau Report
		 </td>
		</tr>
		</table><%} else {%>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
		    <tr>
		        
				<td class="page_flow">Home&nbsp;-&gt;Corporate &amp; SME -&gt; Application  -&gt; Documents -&gt; Bureau Report</td>
		    </tr>
		</table>
		<%} %>
	<lapschoice:application/> 
  <% }  %>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr>
      <td>
        <table width="70%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr> 
            <td width="10%" align="center" class="sub_tab_inactive"><b><a href="javascript:callApplicant()">By Applicant</a></b></td>
            </td>
            <%if(true){ %>
            <td width="15%"  align="center" class="sub_tab_inactive"><b><a href="javascript:callDocAttachment()" >Pre Sanction Document Attachment</a></b> </td>
            <%} %>
            <td align="center" width="10%" class="sub_tab_inactive"><b><a href="javascript:callInternal()">By Bank</a></b>
            </td>
            <%if(app_status.equalsIgnoreCase("Processed/Approved")||app_status.equalsIgnoreCase("Closed/Approved")){ %>
            <td width="15%"  align="center" class="sub_tab_inactive"><b><a href="javascript:callpostsancDocAttachment()">Post Sanction Document Attachment</a></b> </td>
            <%} %>
            <%if((strCategory.equals("RET") || strCategory.equals("LAD") )&&(Helper.correctNull((String)hshValues.get("strAppType")).equalsIgnoreCase("S"))){ %>
            <td align="center" width="10%" class="sub_tab_inactive"><b><a href="javascript:callRBIGuidelines()">RBI Guidelines</a></b>
            </td>
            <%} %>
            <td align="center" width="10%" class="sub_tab_active"><b>Bureau Report</b> </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">

	<tr>

		<td valign="top" align="center">

		<table width="98%" border="0" cellspacing="0" cellpadding="0"  class="outertable tblbdr">

			<tr>

				<td>

				<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable border1">

					<tr>

						<td width="17%" valign="top">

   						<table  class="outertable" width="100%"  border="0" cellpadding="2" cellspacing="0">

   						<tr>

   							<td colspan="3" class="dataHeader" align="center">App & Co-App:</td>

   						</tr>		

   						<%if(arrRow!=null && arrRow.size()>0){

   						  for(int i=0;i<arrRow.size();i++){	

   							strStatusBut = strFetchBut = strGenerateBut = strChkFlag = strErrorDesc = "";

   						  arrCol = new ArrayList();

   						  arrCol = (ArrayList)arrRow.get(i);

   						  String strApp = Helper.correctNull((String)arrCol.get(2));

   						  if(strApp.equalsIgnoreCase("a")){

   							strApp = "App - ";

   						  }else if(strApp.equalsIgnoreCase("c")){

   							strApp = "Co App - ";  

   						  }else if(strApp.equalsIgnoreCase("g")){

   							strApp = "Gua - ";  

   						  }else if(strApp.equalsIgnoreCase("SP")){

     							strApp = "Sole Proprietor - ";  

   						  }else if(strApp.equalsIgnoreCase("CO")){

     							strApp = "Co-Obligant - ";  

     						}
   						else if(strApp.equalsIgnoreCase("p")){

   							strApp = "Sole Proprietor - ";  

   						  }

   						  strStatus =  Helper.correctNull((String) arrCol.get(9));
   						strErrorDesc = Helper.correctNull((String) arrCol.get(11));

	   						  if("P".equals(strStatus))

	   						  {

	   							strStatusBut = "<font color='Blue'><b>Under Process</b></font>";

	   							strFetchBut = "disabled";

								strGenerateBut = "disabled";

	   						  }

	 						  else if("S".equals(strStatus))

							  {
	 							 if(!"Y".equals(Helper.correctNull((String) arrCol.get(13))))

	 							 {

									  strStatusBut = "<font color='Green'><b>Success</b></font>";

									  if("Y".equals(Helper.correctNull((String) arrCol.get(12))))

									  {
									  	strFetchBut = "style='display: none;'";

		 							  	strGenerateBut = "style='display: none;'";
		 							  	
		 							  	strFetchGenFlag = "Y";

									  }

									  else

									  {
										  strFetchBut = "disabled";

		 							  	strGenerateBut = "";
		 							  	strFetchGenFlag = "";

									  }

	 							 }

	 							 else

	 							 {
	 								strStatusBut = "<font color='Green'><b>Renew</b></font>";

	 								strFetchBut = "";

		   							strGenerateBut = "disabled";
		   							
		   							strFetchGenFlag = "";

	 							 }

							  }

	   						  else if("PS".equals(strStatus))

	   							{

	   							  strStatusBut = "<font color='Red'><b>"+strErrorDesc+"</b></font>";

	   								strFetchBut = "";

								  strGenerateBut = "disabled";
								  
								  strFetchGenFlag = "";

	   							}

	   						  else if("I".equals(strStatus))

	   							{

	   							  strStatusBut = "<b>Initiated</b>";

	   								strFetchBut = "disabled";

	 							  strGenerateBut = "disabled";
	 							  
	 							 strFetchGenFlag = "";

	   							}

	   						  else

	   							{

	   							  strStatusBut = "<font color='Red'><b>Not Initiated</b></font>";

	   							  strFetchBut = "";

	   							  strGenerateBut = "disabled";
	   							  
	   							strFetchGenFlag = "";

	   							}

	   						  if(strFetchBut.startsWith("style"))

	   						  {

	   								strChkFlag = "Generated";

	   						  }

	   						  else

	   						  {

	   							strChkFlag = strFetchBut;

	   						  }

	   					%>					

						<tr>				

							<td width="3%"><input type="radio" name="rad_inner_doc" style="border:0" onClick="fnCibilReportPDF('<%=Helper.correctNull((String)arrCol.get(0))%>','<%=Helper.correctNull((String)arrCol.get(9))%>','<%=Helper.correctNull((String)arrCol.get(10))%>','<%=Helper.correctNull((String)arrCol.get(11))%>','<%=i %>','<%=strChkFlag %>','<%=strStatus%>','<%=Helper.correctNull((String) arrCol.get(15))%>','<%=Helper.correctNull((String) arrCol.get(12))%>')"></td>

							<td style='background-color: #FFFFFF; color: #003399;' ><%=strApp + Helper.correctNull((String)arrCol.get(1))%> 
							<br>
							<% if(!"".equals(strStatusBut)) { %>

							(<%=strStatusBut %>)

							<% } %>

							</td>
							<td>&nbsp;<%if(strStatus.equalsIgnoreCase("S") && strFetchGenFlag.equalsIgnoreCase("Y")){ %>
							<span onClick="funDownload('<%=Helper.correctNull((String)arrCol.get(9))%>','<%=Helper.correctNull((String)arrCol.get(10))%>','<%=i %>')"
								style="cursor:hand;" ><img src="<%=ApplicationParams.getAppUrl()%>/img/download.png" border="0"></span><%} %>
							</td>

						</tr>
						<%
						String strEnable1="",strEnable2="";
						if(strStatus.equalsIgnoreCase("S")&& "".equals(Helper.correctNull((String) arrCol.get(12))))
						{ 
							if(Helper.correctNull((String) arrCol.get(15)).equalsIgnoreCase("CRIFHighMark"))
							{
								//strEnable1="checked='checked' disabled";
								//strEnable2="disabled";
							}
							else if(Helper.correctNull((String) arrCol.get(15)).equalsIgnoreCase("CIBIL"))
							{
								//strEnable1="disabled";
								//strEnable2="checked='checked' disabled";
							}
						} %>

						<tr>

							<td>&nbsp;</td>

							<td colspan="2">

							<input type="radio" name="radcibil<%=i %>" style="border: none;" value="CRIFHighMark" <%=strEnable1 %>>&nbsp;CRIF&nbsp;</input>

							<input type="radio" name="radcibil<%=i %>" style="border: none;" value="CIBIL" <%=strEnable2 %>>&nbsp;CIBIL&nbsp;</input>

							<!--<input type="checkbox" name="chk_equifax" checked="checked" 

							>&nbsp;EQUIFAX&nbsp;</input>-->

							</td>

						</tr> 

						<tr id="idGen" style="display: none;">

							<td <% if("S".equals(strStatus) && !"Y".equals(Helper.correctNull((String) arrCol.get(13))) && "Y".equals(Helper.correctNull((String) arrCol.get(12)))) { %>

							style="display: none;"

							<% } %>>&nbsp;</td>

							<td><input type="button" name="cmd_fetch" value="Fetch" onClick="invokeProcCall('procCall',<%=i %>,'<%=Helper.correctNull((String)arrCol.get(0))%>','<%=Helper.correctNull((String)arrCol.get(9))%>','<%=Helper.correctNull((String)arrCol.get(2))%>')" class="buttonStyle"

							<%=strFetchBut %>></td>

							<td><input type="button" name="cmd_cibil" value="Generate" onClick="invokeProcCall('GenReport',<%=i %>,'<%=Helper.correctNull((String)arrCol.get(0))%>','<%=Helper.correctNull((String)arrCol.get(9))%>','<%=Helper.correctNull((String)arrCol.get(2))%>')" class="buttonStyle"

							<%=strGenerateBut %>></td>
							
							
							

						</tr>
						<%
							//if(("Y").equalsIgnoreCase(strFetchGenFlag) && !("").equals(Helper.correctNull((String) hshValues.get("appholder")))){ %>
						<tr id="idReg" style="display: none;">
							<td></td>
							<td colspan="2"><input type="button" name="cmd_Regenerate" value="Re-Generate" onClick="invokeProcCall('ReGenReport',<%=i %>,'<%=Helper.correctNull((String)arrCol.get(0))%>','<%=Helper.correctNull((String)arrCol.get(9))%>')" class="buttonStyle" width="2%"></td>
						</tr>
							<% //}%>

						<%}}%>

						<tr><td>&nbsp;</td></tr>

						</table>

						</td>

					  <td width="75%">

						<table align="center" border="0" cellspacing="0" cellpadding="3" class="outertable border1" width="100%">																	

						  <tr>

		          			<td>

		          			    <iframe height="600px"  frameborder="0" width="100%" id="ifrm3" frameborder="1" style="border:1"></iframe>

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

		<lapschoice:hiddentag pageid='<%=PageId%>'/> 

		<input type="hidden" name="radLoan" value="Y">

		<input type="hidden" name="inwardno">

		<input type="hidden" name="hidAppid">


		<input type="hidden" name="hidApptype">

		<input type="hidden" name="hidAppIdVal" value = "">

		<input type="hidden" name="hidstatusVal" value = "">

		<input type="hidden" name="hidstatusErr" value = "">

		<input type="hidden" name="hidSelChk" value = "">
		
	 	<input type="hidden" name="hidBorrowerType" value = "">
		

<table style="visibility: hidden;position: absolute;"><tr><td><input type="button" name ="cmdsave" disabled="disabled"/></td></tr></table>		
<input type="hidden" name="hidAppDoc">
<input type="hidden" name="hidRequest" value="">
</form>

</body>

</html>

