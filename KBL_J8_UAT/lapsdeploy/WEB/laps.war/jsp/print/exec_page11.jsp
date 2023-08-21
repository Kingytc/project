<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Executive Summary</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";

function callLink(page,bean,method)
{	
	if (document.forms[0].hideditflag.value=="N")
	{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
	 	document.forms[0].action=appURL+"action/"+page;
		document.forms[0].submit(); 
	}
	else
	{
		ShowAlert('103');
	}	
}

function placevalues()
{
	disableFields(true);
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
	}
}

function doEdit()
{
	disableFields(false);
	document.forms[0].hideditflag.value="Y";
	document.forms[0].hidAction.value="edit";
	enableButtons(true,false,false,false,false);
}

function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="executive";
		document.forms[0].hidBeanGetMethod.value="getData11";
		document.forms[0].action=appURL+"action/exec_page11.jsp";
		document.forms[0].submit();
	 }
}

function doClose()
{	
	if( ConfirmMsg(100) )
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/corppge.jsp";
		document.forms[0].submit();
	}	
}

function doSave()
{
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="executive";
	document.forms[0].hidBeanMethod.value="updateData11";
	document.forms[0].hidBeanGetMethod.value="getData11";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/exec_page11.jsp";
	document.forms[0].submit();
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanId.value="executive";
		document.forms[0].hidBeanMethod.value="updateData11";
		document.forms[0].hidBeanGetMethod.value="getData11";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/exec_page11.jsp";
		document.forms[0].submit();
	 }
}


function doPrint()
{		
	var appno="<%=request.getParameter("appno")%>";
	var CompanyName="<%=request.getParameter("appname")%>";	
	var comappid ="<%=request.getParameter("hidapplicantid")%>";
	<%if(strCategoryType.equalsIgnoreCase("SRE")){%>
	var purl ="<%=ApplicationParams.getAppUrl()%>action/comsre_printout.jsp?hidBeanGetMethod=getShortReveiwPrint&hidBeanId=executive&appno="
													+appno+"&CompanyName="+CompanyName;
	<%}else if(strCategoryType.equalsIgnoreCase("ADC")){%>
	var purl ="<%=ApplicationParams.getAppUrl()%>action/adc_printout.jsp?hidBeanGetMethod=getADCApprovalprint&hidBeanId=adhoc&appno="
													+appno+"&comappid="+comappid;
	<%}else if(strCategoryType.equalsIgnoreCase("STL")){%>
	var purl ="<%=ApplicationParams.getAppUrl()%>action/comstl_printout.jsp?hidBeanGetMethod=getShortTermLoanPrint&hidBeanId=executive&appno="
													+appno+"&CompanyName="+CompanyName;
	<%}else{%>
	var purl ="<%=ApplicationParams.getAppUrl()%>action/executiveprint.jsp?hidBeanGetMethod=getExecutivePrint&hidBeanId=executive&appno="+appno+"&CompanyName="+CompanyName;
	<%} %>
	var prop = 'scrollbars=yes,menubar=yes,status=yes,width=750,height=520';	
	var xpos = (screen.width - 750) / 2;
	var ypos = (screen.height - 520) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'<%=strCategoryType%>',prop);
}


</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
</head>

<body onload="placevalues()">
<form name="frmpri" method ="post" class="normal">

<%if(strCategoryType.equalsIgnoreCase("SRE") || strCategoryType.equalsIgnoreCase("STL") || strCategoryType.equalsIgnoreCase("ADC")){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="8" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>

<table width="100%" border="1" cellspacing="0" cellpadding="0" class="outertable">
		<%if (strCategoryType.equalsIgnoreCase("SRE")) {%>
		<tr>
			<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Short Review/Extension -&gt; Process Note </td>
		</tr>
		<%} else if (strCategoryType.equalsIgnoreCase("STL")) {%>
		<tr>
			<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Short Term Loan -&gt; Process Note </td>
		</tr>
		<%} else if (strCategoryType.equalsIgnoreCase("ADC")) {%>
		<tr>
			<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Adhoc Limit -&gt; Process Note -&gt; Page 2 </td>
		</tr>
		
		<%}%>
	</table>


<%}else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top"><jsp:include page="../com/proposallinks.jsp"
			flush="true">
			<jsp:param name="pageid" value="10" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />

		</jsp:include></td>
	</tr>
	<tr>
		<td class="page_flow">
			Home -&gt; Corporate &amp; SME -&gt; Proposal -&gt; Executive Summary -&gt; Page 8
		</td>
	</tr>
</table>
<%} %>
<span style="display:none;"> <lapschoice:borrowertype /> 
              </span> <lapschoice:application/>
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
	<tr> 
    	<td valign="top"> 
        	
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
        
          <tr> 
            <td valign="top" colspan="2"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
                <tr> 
                  <td width="30%"> Signatures</td>
                  </tr>
                  <tr>
                  <td width="70%"> 
                    <textarea name="txt_signatures" cols="95" rows="10" 
                  					onKeyUp="textlimit(this,3999)" onKeyPress="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("exec_signatures"))%></textarea>
                  </td>
                </table>
            </td>
          </tr>
          <%if(!strCategoryType.equalsIgnoreCase("SRE")){ %>
         	 <%if(!strCategoryType.equalsIgnoreCase("ADC")){ %>
          <tr> 
            <td valign="top" colspan="2"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
                <tr> 
                  <td width="30%"> MCM Resolution  </td>
                </tr>
                <tr> 
                  <td width="70%"> 
                    <textarea name="txt_mcmresolution" cols="95" 
                				  rows="7" onKeyUp="textlimit(this,3999)" onKeyPress="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("exec_mcmresolution"))%></textarea>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <%} %>
          <tr> 
            <td valign="top" width="30%"> Grid Resolution</td>
            </tr>
          <tr>
           <td valign="top" width="70%"> 
              <textarea name="txt_gridcomments" cols="95" rows="5" 
              							onKeyUp="textlimit(this,3999)" onKeyPress="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("exec_gridcomments"))%></textarea>
            </td>
          </tr>
          
          <%} %>
		  <tr> 
            <td valign="top" width="30%"> Delegated Authority</td>
          </tr>
          <tr>
          <td valign="top" width="70%"> 
              <textarea name="txt_delegated" cols="95" rows="5" 
              							onKeyUp="textlimit(this,3999)" onKeyPress="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("exec_delegated"))%></textarea>
            </td>
            </tr>
        </table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">

	<tr> 
    	<td colspan="3"> 
       <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Print' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
        </td>
    </tr>

    <tr> 
      <td width="33%">&nbsp; 
      <%if(strCategoryType.equalsIgnoreCase("SRE") || strCategoryType.equalsIgnoreCase("STL") ){ %>
      <div align="left"><a href="#" onclick="javascript:callLink('comsre_rating.jsp','executive','getDataSRERatingDetails')" >&lt;&lt;&nbsp; Previous</a></div>
      <%}else if(strCategoryType.equalsIgnoreCase("ADC")){ %>
      <div align="left"><a href="#" onclick="javascript:callLink('exec_page1.jsp','executive','getData')" >&lt;&lt;&nbsp; Previous</a></div>
      <%} else{%>
        <div align="left"><a href="#" onclick="javascript:callLink('exec_page9.jsp','executive','getData9')" >&lt;&lt;&nbsp; Previous</a></div>
        <%} %>
      </td>
      <td width="33%" align="center">
        <jsp:include page="../com/link1.jsp" flush="true">
         <jsp:param name="cattype" value="<%=strCategoryType%>" />
         <jsp:param name="tabid" value="9"/>
         </jsp:include>
        </td>
      <td width="33%">&nbsp; 
        <div align="right">
        <%if(strCategoryType.equalsIgnoreCase("SRE")){ %>
        Pg.9/9
        <%}else if(strCategoryType.equalsIgnoreCase("STL")){ %>
        Pg.5/5
        <%}else if(strCategoryType.equalsIgnoreCase("ADC")){ %>
        Pg.2/2
        <%}else{ %>
        Pg.8/8
        <%} %>
        &nbsp; </div>
    </td>
    </tr>
</table>
  <lapschoice:hiddentag pageid='<%=PageId%>'/>
   </form>  
 </body></html>
