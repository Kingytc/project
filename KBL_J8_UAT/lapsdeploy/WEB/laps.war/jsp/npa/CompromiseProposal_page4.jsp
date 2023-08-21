<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<laps:handleerror />

<html>
<head>
<title>ubi</title>

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

function disableCommandButtons(val)
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
	document.forms[0].hidAction.value ="insert";
	disableCommandButtons("edit");	
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidSourceUrl.value="/action/CompromiseProposal_page4.jsp";
		document.forms[0].hidBeanId.value="npa";
		document.forms[0].hidBeanGetMethod.value="getcompromisepage4Data";
		document.forms[0].hidBeanMethod.value="updatecompromisepage4Data";
		document.forms[0].action=appUrl +"controllerservlet";
		document.forms[0].submit(); 		
	}	
	
	disableCommandButtons("load");
}
function doDelete()
{
if(ConfirmMsg(101))
	{	
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidSourceUrl.value="/action/CompromiseProposal_page4.jsp";
		document.forms[0].hidBeanId.value="npa";
		document.forms[0].hidBeanMethod.value="updatecompromisepage4Data";
		document.forms[0].hidBeanGetMethod.value="getcompromisepage4Data";
		document.forms[0].action=appUrl +"controllerservlet";
		document.forms[0].submit(); 
	}


}
function doSave()
	{
	document.forms[0].hidSourceUrl.value="/action/CompromiseProposal_page4.jsp";
	document.forms[0].hidBeanId.value="npa";
	document.forms[0].hidBeanMethod.value="updatecompromisepage4Data";
	document.forms[0].hidBeanGetMethod.value="getcompromisepage4Data";
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
		if(ConfirmMsg('100'))
		{
		document.forms[0].method="post";	
		document.forms[0].action=appUrl+"action/"+"mainnav.jsp";
		document.forms[0].submit();
		}
		
	}
function callLink(page,bean,method)
		{
		
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appUrl+"action/"+page;
		document.forms[0].submit();
		}


</script>

</head>


<body text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" font-family="arial" font-size="11px" onload="onLoading()">
<form name="proposalpage4" method="post">
<table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
    <tr> 
      <td id="mainlnk1"> 
        <jsp:include page="../npa/npa_tablink.jsp" flush="true" > 
        <jsp:param name="page_id" value="2" />
        </jsp:include>
      </td>
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
          <td><b><u>CMRD, C.O. RECOMMENDATIONS:</u></b></td>
        </tr>
        <tr> 
          <td> 
            <textarea name="cmrd_recommendations" rows="10" cols="60"><%=Helper.correctNull((String)hshValues.get("cmrd_recommendations"))%></textarea>
          </td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td><b><U>TERMS AND CONDITIONS:</u></b></td>
        </tr>
        <tr> 
          <td> 
            <textarea name="terms_condts" rows="10" cols="60"><%=Helper.correctNull((String)hshValues.get("terms_condts"))%></textarea>
          </td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td>If approved, the Management Committee is requested following resolution: 
            to adopt the following resolution:</td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td>&quot;RESOLVED THAT in the account of 
            <input type="text" name="textfield" size="5">
            with Branch, as per the terms and conditions mentioned in the note, 
            the Bank do accept a sum of Rs. 
            <input type="text" name="textfield2" size="5">
            in full and final settlement of the total dues of Rs. 
            <input type="text" name="textfield3" size="5">
            (inclusive of Legal Expenses of Rs. 
            <input type="text" name="textfield4" size="5">
            debited to Expenditure Account) AND THAT Rs. 
            <input type="text" name="textfield5" size="5">
            being the interest held in Dummy Ledger from 
            <input type="text" name="textfield6" size="5">
            to 
            <input type="text" name="textfield7" size="5">
            and further accruals thereon till final closure of the account be 
            waived.&quot; Dt.- 2002 MODULE/jp 4 </td>
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
                <td width="71%"><b>CHIEF MANAGER</b></td>
                <td width="29%"> <b>DY. GENERAL MANAGER</b></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
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
				<td align="center"><input type="button" name="cmdedit" value="Edit"
					class="buttonStyle"
					onclick="doEdit()"></td>
				<td align="center"><input type="button" name="cmdapply"
					value="Save"
					class="buttonStyle"
					onclick="doSave()"></td>
				<td align="center"><input type="button" name="cmdcancel"
					value="Cancel"
					class="buttonStyle"
					onclick="doCancel()"></td>
					<td align="center"><input type="button" name="cmddel"
					value="Delete"
					class="buttonStyle"
					onclick="doDelete()"></td>
				<!-- <td align="center"><input type="button" name="cmdhelp" value="Help"
					style="background-color:#009966;cursor:help;;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
					onclick="doHelp()"></td> -->
				<td align="center"><input type="button" name="cmdclose"
					value="Close"
					style="background-color:#CC3300;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
					onclick="doClose()"></td>
					</tr>
			</table>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="3">
	<tr> 
      <td width="33%" align="left"><b><font size="1" face="MS Sans Serif">&nbsp;
        <a href="javascript:callLink('CompromiseProposal_page3.jsp','npa','getcompromisepage3Data')" class="blackfont"> 
           &lt;&lt; Prev </a>&nbsp;Pg.4/5 </font></b>
      </td>
      <td width="33%" align="center"><b><font size="1" face="MS Sans Serif"> 
        <jsp:include page="../npa/CompromiseProposallink.jsp" flush="true"/> 
        </font></b></td>
      <td width="33%">&nbsp; 
        <div align="right"><b><font size="1" face="MS Sans Serif">Pg.4/5  &nbsp;<a href="javascript:callLink('CompromiseProposal_page5.jsp','npa','getcompromisepage5Data')" class="blackfont"> 
          Next &gt;&gt; </a></font></b></div>
      </td>
    </tr>
</table>
<input type="hidden" name="hidAction" />
<input type="hidden" name="hidBeanId" />
<input type="hidden" name="hidBeanMethod" value="" />
<input type="hidden" name="hidBeanGetMethod" value="" />
<input type="hidden" name="hidSourceUrl" />
<input type="hidden" name="hidmoduletype" value="OTSCO" />
</form>
</body>
</html>
