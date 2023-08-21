<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<laps:handleerror />


<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<style>
.td,tr{font-family: "MS Sans Serif";
	font-size: 11px;
	}


</style>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/link.css" type="text/css"/>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>

<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";

/*function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddel.disabled=true;
		document.forms[0].cmdapply.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;		 
	}
	
	if(val=="edit")
	{	 
		document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddel.disabled=false;
		 document.forms[0].cmdapply.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}
}

function onLoading()
{
	disableCommandButtons("load");
}
function doEdit()
{ 	
	disableFields(false);
	//document.forms[0].hidAction.value ="insert";
	disableCommandButtons("edit");	
}
function doDelete()
{
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidSourceUrl.value="/action/.jsp";
		document.forms[0].hidBeanId.value="";
		document.forms[0].hidBeanGetMethod.value="";
		document.forms[0].hidBeanMethod.value="";
		document.forms[0].action=appUrl +"controllerservlet";
		document.forms[0].submit(); 		
	}	
	
	disableCommandButtons("load");
}

function doSave()
	{
	document.forms[0].hidSourceUrl.value="/action/.jsp";
	document.forms[0].hidBeanId.value="";
	document.forms[0].hidBeanMethod.value="";
	document.forms[0].hidBeanGetMethod.value="";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
	}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	  
		 
	}
}
function doClose()
	{
	}*/
function callLink(page,bean,method)
		{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appUrl+"action/"+page;
		document.forms[0].submit();
		}
		
	function PrintReport()
{		
		
		var appno="<%=session.getAttribute("comm_appno")%>";
		var CompanyName="<%=request.getParameter("appname")%>";						
		var purl ="<%=ApplicationParams.getAppUrl()%>action/SarfaeriProposal_print.jsp?hidBeanGetMethod=printgetSarfaeri&hidBeanId=npa&appno="+appno+"&CompanyName="+CompanyName;
		var prop = 'scrollbars=yes,menubar=yes,width=750,height=520';	
		var xpos = (screen.width - 750) / 2;
		var ypos = (screen.height - 520) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,'title',prop);
}		
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/corppge.jsp";
		document.forms[0].submit();
		
	}
}		


</script>

</head>
<body text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" font-family="arial" font-size="11px">
<form name="safaeri4" method="post">
<table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
    <tr> 
      <td id="mainlnk1"> 
        <jsp:include page="../npa/npa_tablink.jsp" flush="true" > 
        <jsp:param name="page_id" value="3" />
        </jsp:include>
      </td>
    </tr>
  </table>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr> 
           <td valign="top" colspan=5><b><i><font face="Times New Roman, Times, serif" size="3">Home 
				-&gt; NPA-&gt; Filing Of Suit   -&gt;History
 
 </font></i></b></td>
          </tr>
        </table>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><lapschoice:application /></td>
	</tr>
</table>
<table width="100%" border="1" cellspacing="0" cellpadding="2">
  <tr> 
    <td valign="top">
      <table width="100%" border="0" cellspacing="0" cellpadding="4">
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td>Submitted for approval to issue the Notice as per Section 13 of 
            the Securitisation for Reconstruction of Financial Asset and Enforcement 
            of Securities Interest Act in 2002.</td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td> 
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr> 
                <td width="71%">&nbsp;</td>
                <td width="29%">&nbsp;</td>
              </tr>
              <tr> 
                <td width="71%"><b>(M.V. TANKSALE)</b></td>
                <td width="29%"><b>(R. VENKATARAMANI)</b></td>
              </tr>
              <tr> 
                <td width="71%"><b>DY. GENERAL MANAGER</b></td>
                <td width="29%"><b>GENERAL MANAGER</b></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td align="center"><b>RECOMMENDED/ NOT RECOMMENDED</b></td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td align="center"><b>(M. VENUGOPALAN)<br>
            EXECUTIVE DIRECTOR</b></td>
        </tr>
        <tr>
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td align="center"><b>APPROVED/NOT APPROVED</b></td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td align="center"><b>(V. LEELADHAR)<br>
            MANAGING DIRECTOR</b></td>
        </tr>
      </table>
    </td>
  </tr>
</table>

<table width="12%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"  align="center">
	<tr> 
    	<td> 
        	<table width="100%" border="0" cellspacing="0" cellpadding="2">
        	<tr>
			
				<td align="center"><input type="button" name="cmdclose"
					value="Close"
					style="background-color:#CC3300;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
					onclick="doClose()"></td>
					
					<td> 
          <input type="button" value="Print" name="Print" onclick="PrintReport()" style="background-color:#009966;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"/>
        </td>
					
					
					</tr>
			</table>
		</td>
	</tr>
</table>
<br/>

<input type="hidden" name="hidappno" value="<%=(String)request.getParameter("appno")%>">
<input type="hidden" name="hidAction" />
<input type="hidden" name="hidBeanId" />
<input type="hidden" name="hidBeanMethod" value="" />
<input type="hidden" name="hidBeanGetMethod" value="" />
<input type="hidden" name="hidSourceUrl" />
<table width="100%" border="0" cellspacing="0" cellpadding="3">
	<tr> 
      <td width="33%" align="left"><b><font size="1" face="MS Sans Serif">&nbsp;
        <a href="javascript:callLink('SarfaeriProposal_page3.jsp','npa','getsarfaeripage3Data')" class="blackfont"> 
           &lt;&lt; Prev </a>&nbsp;Pg.4/4 </font></b></td>
      <td width="33%" align="left"><b><font size="1" face="MS Sans Serif"> 
        <jsp:include page="../npa/SarfaeriProposallink.jsp" flush="true"/> 
        </font></b></td>
  <!--    <td width="33%">&nbsp; 
        <div align="right"><b><font size="1" face="MS Sans Serif">Pg.5/5  &nbsp;<a href="javascript:callLink('TechnicalInspectionpage4.jsp','Inspection','getTechnicalpage4')" class="blackfont"> 
          Prev &lt;&lt; </a></font></b></div>
      </td> --> 
    </tr>
</table>

</form>
</body>
</html>