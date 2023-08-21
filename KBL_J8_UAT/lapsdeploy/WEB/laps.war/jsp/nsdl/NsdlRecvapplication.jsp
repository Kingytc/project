<%@include file="../share/directives.jsp"%>
<%
ArrayList arrRecvRow = (ArrayList)hshValues.get("arrRecvRow"); 
ArrayList arrRecvCol=new ArrayList();

ArrayList arrRow = (ArrayList)hshValues.get("arrRow"); 
ArrayList arrCol=new ArrayList();
String strorgCode	=	Helper.correctNull((String)hshValues.get("strOrgCode"));
String strRadioButValue	=	Helper.correctNull((String)hshValues.get("strRadioButValue"));
%>

<html>
<head>
<SCRIPT LANGUAGE="JavaScript">
var varRadButVal	="<%=strRadioButValue%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var varappholdername="<%=Helper.correctNull((String)hshValues.get("strAppHoldername"))%>";
var varappholderOrgName="<%=Helper.correctNull((String)hshValues.get("strAppHolderOrgName"))%>";
var varSearchFlag="<%=Helper.correctNull((String)hshValues.get("strSearchValue"))%>";

function doCreateInward(appRefNo,appname,appdob)
{
	document.forms[0].action=appURL+"action/appinwardreg.jsp?new=Y&strPageFromnsdl=Y&strRefNo="+appRefNo+"&strAppname="+appname+"&strAppDOB="+appdob;
	document.forms[0].submit();
}
function callclose()
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/mainnav.jsp";
	document.forms[0].submit();
}
function onRadioClick()
{
	for(var i=0;i<document.forms[0].radiobutton.length;i++)
	{
		if(document.forms[0].radiobutton[1].checked==true)
		{
			document.forms[0].hid_nsdl_refid.value="nsdl_appid";
			 
		}
		else if(document.forms[0].radiobutton[0].checked==true)
		{
			document.forms[0].hid_nsdl_refid.value="nsdl_refid";
			 
		}
		document.forms[0].txt_nsdl_refid.value="";
		document.forms[0].txt_nsdl_refid.readOnly=false;
		document.forms[0].txt_nsdl_refid.focus();
		 
	}
}

function doSearch()
{
	var varID	=document.forms[0].txt_nsdl_refid.value;
	if(varID=="")
	{
		alert('Please Enter Search ID');
		return;
	}
	document.forms[0].hidBeanId.value="nsdl";
	document.forms[0].action = appURL+"action/NsdlRecvapplication.jsp";
	document.forms[0].hidBeanGetMethod.value="getNsdlRecvApplication";
	document.forms[0].submit();
}
function doLoadPage()
{
	document.forms[0].hidBeanId.value="nsdl";
	document.forms[0].hidBeanGetMethod.value="getNsdlRecvApplication";
	document.forms[0].action=appURL+"action/NsdlRecvapplication.jsp"
	document.forms[0].submit();
}
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function callOnLoad()
{
	if(varRadButVal!="")
	{
		if(varRadButVal=="nsdl_appid")
		{
			document.forms[0].radiobutton[1].checked=true;
		}
		else if(varRadButVal=="nsdl_refid")
		{
			document.forms[0].radiobutton[0].checked=true;
		}
		if(document.forms[0].radiobutton[1].checked==true)
		{
			document.forms[0].hid_nsdl_refid.value="nsdl_appid";
		}
		else if(document.forms[0].radiobutton[0].checked==true)
		{
			document.forms[0].hid_nsdl_refid.value="nsdl_refid";
		}

		if(document.forms[0].txt_nsdl_refid.value!="")
		{
			if(varappholdername!="")
			{
				alert("The Request has been forwarded to "+varappholderOrgName+" branch and taken by "+varappholdername);
			}
		}
	}
}
function doSendtoHO(varrefID,appid)
{
	if(confirm("Do you want to send the application back to the Head office?"))
	{
		document.all.ifrm.src=appURL+"action/ifrmNsdlRecvAppl.jsp?hidBeanId=nsdl&hidBeanGetMethod=updateNSDLApplicationReallocation&refid="+varrefID+"&appid="+appid+"&hidReallocationFlag=SendtoHO";
	}
}
function callAppStatusPopUp(varrefId)
{
		var	varQryString = appURL+"action/nsdlShowAppDetails.jsp?hidBeanId=nsdl&hidBeanGetMethod=getNsdlShowApplicationDetails&strRefId="+varrefId;	
		var title = "ApplicantionStatus";
		var prop = "scrollbars=yes,width=850,height=550";	
		var xpos = (screen.width - 500) / 2;
		var ypos = (screen.height - 400) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(varQryString,title,prop);
}
function callDocument(varrefId)
{
	var	varQryString = appURL+"action/nsdlViewDocument.jsp?hidBeanId=nsdl&hidBeanGetMethod=getDocumentList&strRefId="+varrefId;	
	var title = "ApplicantionStatus";
	var prop = "scrollbars=yes,width=850,height=550";	
	var xpos = (screen.width - 500) / 2;
	var ypos = (screen.height - 400) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(varQryString,title,prop);
}
</script>
<style>
.mailbox_container
{
	width: 100%;
	height: 350px;
	overflow: auto;
}
</style>

<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>
<body  onload="callOnLoad()">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr> 
        <td  class="page_flow">Home -&gt; NSDL Applications -&gt; NSDL Application MailBox </td>
      </tr>
    </table>

<form name="nsdlrecvapp" method="post"> 

<table width="95%"  border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
<tr class="datagrid" style="border: none">
	<td><input type="radio" name="radiobutton" style="border-style: none" 	onClick="onRadioClick()">&nbsp; &nbsp;<b>Reference ID</b></td>
	<td><input type="radio" name="radiobutton"  style="border-style: none" 	onClick="onRadioClick()">&nbsp; &nbsp;<b>Applicant ID</b></td>
	<td><input type="text" name="txt_nsdl_refid" size="40" value="<%=Helper.correctNull((String)hshValues.get("strSearchValue")) %>">&nbsp;</td>
	<td><input type="button" name="Search" value="Search" onClick="doSearch()" class="buttonstyle">&nbsp;</td>
 
</tr>
<tr>
<!-- <td colspan="4" class="datagrid">&nbsp;</td> -->
</tr>
</table>
<table width="95%"  border="0" cellspacing="1" cellpadding="3" align="center">
<tr class="dataheader">
<td width="10%" nowrap="nowrap"  align="center"> Reference ID</td>
<td width="10%" nowrap="nowrap"  align="center"> Applicant ID</td>
<td width="20%" nowrap="nowrap"  align="center"> Application Name</td>
<td width="10%" nowrap="nowrap"  align="center">PAN No</td>
<td width="10%" nowrap="nowrap"  align="center">Aadhar Card</td>
<td width="10%"   nowrap="nowrap"  align="center"  style="cursor:hand;">Sent by</td>
<td width="10%"  nowrap="nowrap"  align="center"  style="cursor:hand;">Sent on</td>
<td width="15%" nowrap="nowrap" align="center" style="cursor:hand;">Action&nbsp;</td>
</tr>
<%if(arrRecvRow!=null && arrRecvRow.size()>0)
{ 
for(int k=0;k<arrRecvRow.size();k++)
{
	arrRecvCol=(ArrayList)arrRecvRow.get(k);
%>
<tr class="datagrid">
<td align="center"><%=Helper.correctNull((String)arrRecvCol.get(0)) %>&nbsp;<a href="#"
							onClick="javascript:callAppStatusPopUp('<%=Helper.correctNull((String)arrRecvCol.get(0)) %>')"> <img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"> </a>&nbsp;&nbsp;
							<a href="#"
							onClick="javascript:callDocument('<%=Helper.correctNull((String)arrRecvCol.get(0)) %>')"> <img
							src="<%=ApplicationParams.getAppUrl()%>/img/nsdl_docview.png"
							border="0"> </a></td>
<td align="center"><%=Helper.correctNull((String)arrRecvCol.get(1)) %>&nbsp;</td>
<td><%=Helper.correctNull((String)arrRecvCol.get(2)) %>&nbsp;</td>
<td align="center"><%=Helper.correctNull((String)arrRecvCol.get(3)) %>&nbsp;</td>
<td align="center"><%=Helper.correctNull((String)arrRecvCol.get(4)) %>&nbsp;</td>
<td align="center"><%=Helper.correctNull((String)arrRecvCol.get(5)) %>&nbsp;</td>
<td align="center"><%=Helper.correctNull((String)arrRecvCol.get(6)) %>&nbsp;</td>
<td align="center"><input type="button" value="Create Inward" name="cmdCreateInward" onclick="doCreateInward('<%=Helper.correctNull((String)arrRecvCol.get(0)) %>',
																							 '<%=Helper.correctNull((String)arrRecvCol.get(2)) %>','<%=Helper.correctNull((String)arrRecvCol.get(12)) %>')" class="buttonStyle">&nbsp;
				<input type="button" value="Proposal pertaining to other branch (Send Back to HO)" name="cmdsendtoHO" onclick="doSendtoHO('<%=Helper.correctNull((String)arrRecvCol.get(0)) %>',
																							 '<%=Helper.correctNull((String)arrRecvCol.get(1)) %>')"  class="buttonStyle"></td>

</tr>
<%}}else{ %>
<%for(int i=0;i<3;i++){ %>
<tr class="datagrid">
<td align="center">&nbsp;</td>
<td align="center">&nbsp;</td>
<td>&nbsp;</td>
<td align="center">&nbsp;</td>
<td align="center">&nbsp;</td>
<td align="center">&nbsp;</td>
<td align="center">&nbsp;</td>
<td align="center">&nbsp;</td>
</tr>
<%if(i==1) {%>
<tr class="datagrid">
<td colspan="8" align="center">&nbsp;-- No Record Found --&nbsp;</td>
</tr>
<%} %>
<%}} %>
</table>
<br>


 

<table width="100%" border="0" cellspacing="0" cellpadding="0"  >
      <tr valign="middle"> 
       <td align="center">  
            <input type="button" name="cmdclose" value="Close" class="buttonClose" onClick="callclose()"> 
        </td>
      </tr>
      <tr align="center">
    <table width="50%" align="center">
    <tr>
     
<td>
<b>
<p>i)For rejecting the NSDL Application ,kindly use create In ward option.</p>
<p>ii)For processing/rejecting the education loan applications received through NSDL vidyalakshmiportal,kindly refer</p>
<p>HO:CREDIT :CIRCULAR:GF:7:18:2018-19 dated 13.07.2018</p>
<p>HO:CREDIT :CIRCULAR LETTER:GF:62:28:2018-19 date 03.10.2018</p>
</b>
<br>
<br>
</td>
</tr>
</table>


</tr>
</table>
    <input type="hidden" name="hidBeanId" value="">
    <input type="hidden" name="hid_nsdl_refid" value="">
    <input type="hidden" name="hidBeanGetMethod" value="">
    <iframe height="0" width="0" id="ifrm" frameborder=0 style="border:0"></iframe>
    
    </form>
    </body>
    </html>