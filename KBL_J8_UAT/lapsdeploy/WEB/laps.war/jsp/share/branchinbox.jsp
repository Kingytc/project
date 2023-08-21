<%@include file="../share/directives.jsp"%>
<%
String strFormType = Helper.correctNull(request.getParameter("optformtype"));


ArrayList vecVal = (ArrayList)hshValues.get("vecVal");
ArrayList vecR = null;
String strColor=null;
String strcorpval=null;

if(strFormType.equals("P"))
{
	strColor = "#003399";
}
else if(strFormType.equals("C"))
{
	strColor = "#CC0000";
}
else if(strFormType.equals("N"))
{
	strColor = "#003399";
}

else if(strFormType.equals("M"))
{
	strColor = "#003399";
}
else if(strFormType.equals("TL"))
{
	strColor = "#003399";
}
else 
{
	strColor="#d14428";
}
session.setAttribute("pgeLabel", "Existing");

boolean boolmailavail=false;
%>

<html>
<head>
<title>Application - MailBox</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 400;
  overflow: auto;
}
.purpleFont {
    color: #942188 !important;
    font-family: "Trebuchet MS";
    font-size: 12px;
    text-decoration: none;
}
.purpleFont:hover {
    color: #fd6a15 !important;
    text-decoration: underline;
}
</STYLE>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script>
var varOrgShortCode = "<%=Helper.correctNull((String)session.getAttribute("strOrgShortCode"))%>";
var varUserid = "<%=Helper.correctNull((String)session.getAttribute("strUserId"))%>";
function doClose()
{
	document.forms[0].optformtype.value="";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/branchinboxhome.jsp";
	document.forms[0].submit();
}

function callPerLink(appno,compname,id,mailtype,prdtype,cbsstatus,proptype,createdate)
{
		var rights = "<%=session.getAttribute("strGroupRights")%>"
		if(cbsstatus !="Y")
		{
			alert("Customer Profile is not filled completely");
			return;
		}
		
        <%if(strFormType.equals("P")){%>
        	document.forms[0].hidCategoryType.value="RET";
        <% }else if(strFormType.equals("A")){%>
            document.forms[0].hidCategoryType.value="AGR";
        <% }else if(strFormType.equals("J")){%>
        document.forms[0].hidCategoryType.value="LAD";
        <%}%>
    	document.forms[0].radLoan.value="Y";
		document.forms[0].page.value="ep";
		document.forms[0].appno.value=appno;
		if(proptype!="P")
		{
			document.forms[0].hidBeanId.value="perapplicant";
			document.forms[0].hidBeanGetMethod.value="getLoanProducts";		
			if(prdtype=="pR" || prdtype=="pG")
			{
			
			if(mailtype != "CC")
				document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/ladloandetails.jsp?compname="+compname+"&appid="+id+"&appholder=Y&varGLdate=Y";
			else
				document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/ladloandetails.jsp?compname="+compname+"&appid="+id+"&appholder=N";
			}
			else
			{
				
				if(mailtype != "CC")
					document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/perloandetails.jsp?compname="+compname+"&appid="+id+"&appholder=Y";
				else
					document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/perloandetails.jsp?compname="+compname+"&appid="+id+"&appholder=N";
			}
		}
		else
		{
			document.forms[0].hidBeanId.value="commworkflow";
			document.forms[0].hidBeanGetMethod.value="getHistory";		
			if(mailtype != "CC")
				document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/appworkflowhistory.jsp?compname="+compname+"&appid="+id+"&appholder=Y";
			else
				document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/appworkflowhistory.jsp?compname="+compname+"&appid="+id+"&appholder=N";
		}
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
}

	
function callLink(appno,cname,status,type,valuesin,varproptype,appid)
{
	var rights = "<%=session.getAttribute("strGroupRights")%>"
	var SFT = "<%=strFormType%>";
	
	if(SFT=="P")
	{
		var stat = status.split('/');
		appstat = stat[0];
		compstat = stat[1];
		callPerLink(appno,appstat,compstat,type);
	}
	if(SFT=="C" || SFT=="A")
	{
		var stat = status.split(' ');
		document.forms[0].hidCategoryType.value =cname;
		document.forms[0].hidSSIType.value =status;

		appstat = stat[0];
		compstat = stat[1];
		callComLink(appno,cname,appstat,compstat,type,valuesin,varproptype,appid);
	}
}

function callLinksol(hidappno,applname,org,sendby,senton,appid)
{
	document.forms[0].hidDemoId.value=appid;
	document.forms[0].hidapplno.value=hidappno;
	document.forms[0].hidBeanId.value="comsolvency";
	document.forms[0].hidBeanGetMethod.value="getSolvencyData";	
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/com_solvency.jsp";
	document.forms[0].target="mainFrame";
	document.forms[0].submit();
}

function callLinkkpow(hidappno,applname,org,sendby,senton,appid)
{
	document.forms[0].hidDemoId.value=appid;
	document.forms[0].hidapplno.value=hidappno;
	document.forms[0].hidBeanId.value="comsolvency";
	document.forms[0].hidBeanGetMethod.value="getKpowerdetailsData";	
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/com_addkpowerdetails.jsp";
	document.forms[0].target="mainFrame";
	document.forms[0].submit();
}


function callLinkFin(hidappno,applname,org,sendby,senton,date,hidfinid,hidbusid)
{
	document.forms[0].hidRatAppNo.value=hidappno;
	document.forms[0].hidfinanceid.value=hidfinid;
	document.forms[0].hidbussID.value=hidbusid;
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].hidBeanGetMethod.value="getFinRating";	
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/FinancialOFRating.jsp";
	document.forms[0].target="mainFrame";
	document.forms[0].submit();
}

function onloading()
{

}

function getMailBox(strFormType)
{
	document.mails.optformtype.value=strFormType;
	document.forms[0].hidBeanGetMethod.value="getBranchMailBox";
	document.mails.action="<%=ApplicationParams.getAppUrl()%>action/branchinbox.jsp?fromlink=Branchmailbox";
	document.mails.submit();
}

function changeLabel()
{
	<%if(vecVal!=null && vecVal.size()>0){%>
		if(("<%=strFormType%>"=="P")||("<%=strFormType%>"=="J"))
		{
		document.all.dataid.innerHTML='<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable"><tr class="dataheader"><td width="5%" height="22" align="center"> Sl No.</td><td width="10%" height="22" align="center"> Proposal No.</td><td width="15%" height="22" id="nameid" align="center"> Applicant Name </td><td width="20%" height="22" id="orgid" align="center"> Product Name</td><td width="15%" height="22" align="center"> Process Status</td> <td width="8%" id="sentbytd" style="visibility:visible" height="22" align="center"> Sent by</td><td width="10%" id="sentontd" style="visibility:visible" height="22" align="center">Sent on</td><td width="15%" height="22" align="center"> Type</td> </tr></table>';
		}
		if(("<%=strFormType%>"=="C")||("<%=strFormType%>"=="A"))
		{
		document.all.dataid.innerHTML='<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable"><tr class="dataheader"><td width="5%" height="22" align="center"> Sl No.</td><td width="12%" height="22" align="center"> Proposal No</td><td width="15%" height="22" id="nameid" align="center"> Applicant Name </td><td width="18%" height="22" align="center"> Process Status</td> <td width="20%" id="sentbytd" style="visibility:visible" height="22" align="center"> Sent by</td><td width="10%" id="sentontd" style="visibility:visible" height="22" align="center">Sent on</td> <td width=20%" height="22" align="center"> Type</td> </tr></table>';
		}
		if("<%=strFormType%>"=="S")
		{
			document.all.dataid.innerHTML='<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable"><tr class="dataheader"><td width="5%" height="22" align="center"> Sl No.</td><td width="18%" height="22" align="center">Application No.</td> <td width="18%" height="22" align="center">Applicant Name</td><td width="24%" height="22" align="center">Organization</td><td width="12%" height="22" align="center">Status</td><td width="8%" height="22" align="center">Sent By</td><td width="12%" height="22" align="center">Sent On</td></tr></table>';
		}
		if("<%=strFormType%>"=="K")
		{
			document.all.dataid.innerHTML='<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable"><tr class="dataheader"><td width="5%" height="22" align="center"> Sl No.</td><td width="18%" height="22" align="center">Application No.</td> <td width="18%" height="22" align="center">Applicant Name</td><td width="24%" height="22" align="center">Organization</td><td width="12%" height="22" align="center">Status</td><td width="8%" height="22" align="center">Sent By</td><td width="12%" height="22" align="center">Sent On</td></tr></table>';
		}
		if("<%=strFormType%>"=="F")
		{
			document.all.dataid.innerHTML='<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable"><tr class="dataheader"><td width="5%" height="22" align="center"> Sl No.</td><td width="18%" height="22" align="center">Application No.</td> <td width="18%" height="22" align="center">Applicant Name</td><td width="24%" height="22" align="center">Organization</td><td width="12%" height="22" align="center">Status</td><td width="8%" height="22" align="center">Sent By</td><td width="12%" height="22" align="center">Sent On</td></tr></table>';
		}
		if("<%=strFormType%>"=="D")
		{
			document.all.dataid.innerHTML='<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable"><tr class="dataheader"><td width="5%" height="22" align="center"> Sl No.</td><td width="12%" height="22" align="center"> Proposal No</td><td width="15%" height="22" id="nameid" align="center"> Applicant Name </td><td width="15%" id="sentbytd" style="visibility:visible" height="22" align="center"> Send By</td><td width=15%" id="sentontd" style="visibility:visible" height="22" align="center">Send On</td> <td width="15%" id="org_name" style="visibility:visible" height="22" align="center"> Organisation</td><td width="15%" id="sentontd" style="visibility:visible" height="22" align="center">Status</td></tr></table>';
		}
	<%}%>
}
function callComLink(appno,cname,appstat,compstat,mailtype,valuesin,varproptype,appid)
{
		document.forms[0].appno.value=appno;
		document.forms[0].appname.value=cname;
		document.forms[0].appstatus.value=appstat+"/"+compstat;
		
		<%
		if(strFormType.equalsIgnoreCase("A")){%>
       document.forms[0].hidCategoryType.value="AGR";
       <% 
       session.setAttribute("sessionModuleType","AGR");
   }else if(strFormType.equalsIgnoreCase("P")){
   	session.setAttribute("sessionModuleType","RET");
   }
   else if(strFormType.equalsIgnoreCase("C"))
   {%>
   	 document.forms[0].hidCategoryType.value="CORP";
   <%session.setAttribute("sessionModuleType","CORP");
	}
	%>
	document.forms[0].valuesin.value=valuesin;
	if(varproptype=="P")
	{
		document.forms[0].hidBeanId.value="bankapp";
		document.forms[0].hidBeanGetMethod.value="getPostSanctionParameters";
  		 if(mailtype != "CC")
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/postsancparameters.jsp?comappid="+appid;
		else
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/postsancparameters.jsp";
	}
	else
	{
		document.forms[0].hidBeanGetMethod.value="";
		document.forms[0].hidBeanId.value="";
		document.forms[0].hidBeanMethod.value="";
		if(mailtype != "CC")
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/com_companydet.jsp?hidPageType=PROP&appholder=Y"
		else
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/com_companydet.jsp?hidPageType=PROP&appholder=N"
	}
		document.forms[0].hidSourceUrl.value="";
		document.forms[0].target="mainFrame"
		document.forms[0].submit();
}
function callDEVLink(varappno)
{
	document.mails.action="<%=ApplicationParams.getAppUrl()%>action/permission_gist.jsp?hidBeanId=perDeviation&hidBeanGetMethod=getPermissionGistData&strPageFrom=inbox&hidAppno="+varappno;
	document.mails.submit();
}

</script>
</head>

<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0"
	onload="javascript:onloading();changeLabel();txtLoad('Mailbox')">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div></div>

<form name="mails" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1" >
	<tr>
		<%if((vecVal!=null && vecVal.size()>0)){ %>
		<td width="90%" valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="top" id="dataid">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" id="gridcontrols" style="width:120%;height:70px">
				<div class="cellContainer">
				<table width="100%" border="0" cellspacing="1" cellpadding="3"
					 class="outertable border2" align="">
					<%
  if(vecVal!=null)
  {
	  for(int i=0;i<vecVal.size();i++)
	  {
			vecR = new ArrayList();
			vecR  =(ArrayList)vecVal.get(i);
			String strCompType="",strSsiType="";
			if(strFormType.trim().equals("C"))
			{
			  strCompType = Helper.correctNull((String)vecR.get(7));
			  if(strCompType.trim().equals("CORP"))
				{
					strCompType="CORPORATE";
				}
		   }
  %>
					<tr>
						<%
                                  if(strFormType.trim().equals("C")  || strFormType.trim().equals("A"))
								  {
								  %>
								  <td width="5%"><%=i+1 %></td>
						<td width="12%" align="center" ><b><a
							href="javascript:callLink('<%=vecR.get(0)%>','<%=strCompType%>','<%=strSsiType%>','<%=vecR.get(10)%>','<%=vecR.get(11)%>','<%=Helper.correctNull((String)vecR.get(13))%>','<%=Helper.correctNull((String)vecR.get(9))%>')"
							class="purpleFont"><%=vecR.get(0)%>&nbsp;</a></b></td>
						<td width="15%" ><%=vecR.get(1)%>&nbsp;</td>
						<td width="18%" align="center" >&nbsp;<%=vecR.get(4)%>&nbsp;</td>
						<td width="20" >&nbsp;<%=vecR.get(5)%>&nbsp;</td>
						<td width="10%" >&nbsp;<%=vecR.get(6)%>&nbsp;</td>
						<td width="20%" ><%=vecR.get(12)%>&nbsp;</td>
						<%
								  }
                                  else if(strFormType.trim().equals("P")||strFormType.trim().equals("J")){%>
                                  <td width="5%"><%=i+1 %></td>
						<td width="10%" align="center" ><b><a
							href="javascript:callPerLink('<%=vecR.get(0)%>','<%=Helper.encodeAmpersand(Helper.correctDoubleQuotesScript(Helper.replaceForJavaScriptString((String)vecR.get(1))))%>','<%=vecR.get(7)%>','<%=vecR.get(8)%>','<%=vecR.get(9)%>','<%=vecR.get(10)%>','<%=Helper.correctNull((String)vecR.get(12))%>','<%=Helper.correctNull((String)vecR.get(13))%>')"
							class="purpleFont"><%=vecR.get(0)%>&nbsp;</a></b></td>
						<td width="15%" ><%=vecR.get(1)%>&nbsp;</td>
						<td width="20%" ><%=vecR.get(2)%>&nbsp;</td>
						<td width="15%"  >&nbsp;<%=vecR.get(4)%>&nbsp;</td>
						<td width="8%" >&nbsp;<%=vecR.get(5)%>&nbsp;</td>
						<td width="11%" >&nbsp;<%=vecR.get(6)%>&nbsp;</td>
						<td width="14%" ><%=vecR.get(11)%>&nbsp;</td>
						<%
					    }else 
							 if(strFormType.trim().equals("K"))
							  {
							  %>
							  <td width="5%"><%=i+1 %></td>
							  <td width="19%" align="center" ><b><a
								href="javascript:callLinkkpow('<%=vecR.get(0)%>','<%=Helper.encodeAmpersand(Helper.correctDoubleQuotesScript(Helper.replaceForJavaScriptString((String)vecR.get(1))))%>','<%=vecR.get(2)%>','<%=vecR.get(3)%>','<%=vecR.get(4)%>','<%=vecR.get(5)%>','<%=vecR.get(6)%>')"
								class="purpleFont"><%=vecR.get(0)%>&nbsp;</a></b></td>
								<td width="19%" ><%=vecR.get(1)%>&nbsp;</td>
								<td width="25%" align="center" >&nbsp;<%=vecR.get(2)%>&nbsp;</td>
								<td width="12%" >&nbsp;<%=vecR.get(6)%>&nbsp;</td>
								<td width="8" >&nbsp;<%=vecR.get(4)%>&nbsp;</td>
								<td width="12%" align="center">&nbsp;<%=vecR.get(3)%>&nbsp;</td>
					        <%
							  } else if(strFormType.trim().equals("S"))
							  {%>
							  <td width="5%"><%=i+1 %></td>
							   <td width="19%" align="center" ><b><a
								href="javascript:callLinkFin('<%=vecR.get(0)%>','<%=Helper.encodeAmpersand(Helper.correctDoubleQuotesScript(Helper.replaceForJavaScriptString((String)vecR.get(1))))%>','<%=vecR.get(2)%>','<%=vecR.get(3)%>','<%=vecR.get(4)%>','<%=vecR.get(5)%>','<%=vecR.get(6)%>','<%=vecR.get(7)%>')"
								class="purpleFont"><%=vecR.get(0)%>&nbsp;</a></b></td>
								<td width="19%" ><%=vecR.get(1)%>&nbsp;</td>
								<td width="25%" align="center" >&nbsp;<%=vecR.get(2)%>&nbsp;</td>
								<td width="12%" >&nbsp;<%=vecR.get(6)%>&nbsp;</td>
								<td width="8" >&nbsp;<%=vecR.get(4)%>&nbsp;</td>
								<td width="12%" align="center">&nbsp;<%=vecR.get(3)%>&nbsp;</td>
							  <%}else if(strFormType.trim().equals("D"))
								 {
									%>
								<td width="5%"><%=i+1 %></td>
								<td width="12%" align="center" ><b><a
									href="javascript:callDEVLink('<%=Helper.correctNull((String)vecR.get(0))%>')"
									class="purpleFont"><%=vecR.get(0)%>&nbsp;</a></b></td>
								<td width="15%" ><%=vecR.get(1)%>&nbsp;</td>
								<td width="15%" ><%=vecR.get(2)%>&nbsp;</td>
								<td width="15%" ><%=vecR.get(3)%>&nbsp;</td>
								<td width="15%" ><%=vecR.get(5)%>&nbsp;</td>
								<td width="15%" ><%=vecR.get(4)%>&nbsp;</td>
							
								<%	 }
							  else if(strFormType.trim().equals("F"))
								  
							  {%>
							  <td width="5%"><%=i+1 %></td>
							   <td width="19%" align="center" ><b><a
								href="javascript:callLinkFin('<%=vecR.get(0)%>','<%=Helper.encodeAmpersand(Helper.correctDoubleQuotesScript(Helper.replaceForJavaScriptString((String)vecR.get(1))))%>','<%=vecR.get(2)%>','<%=vecR.get(3)%>','<%=vecR.get(4)%>','<%=vecR.get(5)%>','<%=vecR.get(6)%>','<%=vecR.get(7)%>')"
								class="purpleFont"><%=vecR.get(0)%>&nbsp;</a></b></td>
								<td width="19%" ><%=vecR.get(1)%>&nbsp;</td>
								<td width="25%" align="center" >&nbsp;<%=vecR.get(2)%>&nbsp;</td>
								<td width="12%" >&nbsp;<%=vecR.get(3)%>&nbsp;</td>
								<td width="8" >&nbsp;<%=vecR.get(4)%>&nbsp;</td>
								<td width="12%" align="center">&nbsp;<%=vecR.get(5)%>&nbsp;</td>
							  <%}
                                  }
                                  }
                                  %>
					</tr>
				</table>
				</div> 
				</td>
				<%}else{ %>
				<td>
					<font face="Tahoma" size="3" color="red"><b>No Pending Activities</b>
				</td>
				<%} %>
			</tr>
		</table>
		</td>
	</tr>
</table>
		<table border="0" cellspacing="0" cellpadding="2" align="center">
			<tr valign="middle">
				<td align="center"><lapschoice:combuttonnew btnenable="Y"/>
				</td>
			</tr>
		</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="optformtype"> 
<input type="hidden" name="appno"> 
<input type="hidden" name="appstatus"> 
<input type="hidden" name="appname"> 
<input type="hidden" name="radLoan"> 
<input type="hidden" name="page"> 
<input type="hidden" name="hidCategoryType" value="<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>">
<input type="hidden" name="hidSSIType" value="<%=Helper.correctNull((String)request.getParameter("hidSSIType"))%>">
<input type="hidden" name="valuesin"> 
<input type="hidden" name="hidRatAppNo">
<input type="hidden" name="hidfinanceid">
<input type="hidden" name="hidbussID">
<input type="hidden" name="hidDemoId">
<input type="hidden" name="hidapplno">
</form>
</body>
</html>
