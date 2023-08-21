<%@include file="../share/directives.jsp"%>
<%
String strFormType = Helper.correctNull(request.getParameter("optformtype"));



String ib="I";
session.setAttribute("Inbox",ib);
session.setAttribute("sessionModuleType","");



ArrayList vecVal = (ArrayList)hshValues.get("vecVal");
ArrayList vecR = null;
String strColor=null;
String strcorpval=null;

if(strFormType.equals("P") || (strFormType.equals("DIGI")) )
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

String strsesUserClass=Helper.correctInt((String)session.getAttribute("strUserClass"));


%>

<html>
<head>
<title>Application - MailBox</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>

DIV.cellContainer {	
  width: 100%; 
  /* height: 400; */
  height: 385px;
  overflow: auto;
}
.blackfont{
    color: #942188 !important; 
    /* font-size: 12px; */
    text-decoration: none;
}
.blackfont:hover{
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
var strUserClass = "<%= Helper.correctNull((String)session.getAttribute("strUserClass"))%>";
var strFormType = "<%= strFormType%>";
function doClose()
{
	document.forms[0].optformtype.value="";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/mainnav.jsp";
	document.forms[0].submit();
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
	else if(strFormType.equalsIgnoreCase("DIGICORP"))
    {%>
    	 document.forms[0].hidCategoryType.value="CORP";
	    <%session.setAttribute("sessionModuleType","CORP");
	}
	//shiva
	else if(strFormType.equalsIgnoreCase("A"))
    {%>
    	 document.forms[0].hidCategoryType.value="AGRI";
    <%session.setAttribute("sessionModuleType","AGRI");
	}
	else if(strFormType.equalsIgnoreCase("DIGIAGRI"))
	 {%>
	 document.forms[0].hidCategoryType.value="AGRI";
    <%session.setAttribute("sessionModuleType","AGRI");
	}%>
	

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
function callLodgedPropComLink(appno,cname,appstat,compstat,mailtype,valuesin)
 {
		document.forms[0].appno.value=appno;
		document.forms[0].appname.value=cname;
		document.forms[0].appstatus.value=appstat+"/"+compstat;
		document.forms[0].hidBeanGetMethod.value="";
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].hidBeanGetMethod.value="getHistory";
		<%
		if(strFormType.equalsIgnoreCase("A")||strFormType.equalsIgnoreCase("AGR_OL")){%>
        document.forms[0].hidCategoryType.value="AGR";
        <% 
        session.setAttribute("sessionModuleType","AGR");
    }else if(strFormType.equalsIgnoreCase("P")){
    	session.setAttribute("sessionModuleType","RET");
    }
    else if(strFormType.equalsIgnoreCase("C")||strFormType.equalsIgnoreCase("COM_OL"))
    {%>
    	 document.forms[0].hidCategoryType.value="CORP";
    <%session.setAttribute("sessionModuleType","CORP");
}
%>
document.forms[0].valuesin.value=valuesin;
    if(mailtype != "CC")
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/appworkflowhistory.jsp?hidPageType=PROP&appholder=Y"
		else
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/appworkflowhistory.jsp?hidPageType=PROP&appholder=N"
		document.forms[0].hidSourceUrl.value="";
		document.forms[0].target="mainFrame"
		document.forms[0].submit();
 }
function callNPALink(appno,modname,id,apptype,appname)
{
	document.forms[0].appno.value=appno;
	document.forms[0].hidBeanId.value="npacommon";
	document.forms[0].hidBeanGetMethod.value="getGeneralinfoData";
	if(modname=="OTSCO")
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/CompromiseProposal_generalinfo.jsp?cbsid="+id+"&hidmoduletype="+modname+"&apptype="+apptype+"&borrowername="+appname;
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(modname=="SUIT")
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/34PointsFormat_page1.jsp?cbsid="+id+"&hidmoduletype="+modname+"&apptype="+apptype+"&borrowername="+appname;
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(modname=="STAT")
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/StatusNote_page1.jsp?cbsid="+id+"&hidmoduletype="+modname+"&apptype="+apptype+"&borrowername="+appname;
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(modname=="PAWO")
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/prudential_general.jsp?cbsid="+id+"&hidmoduletype="+modname+"&apptype="+apptype+"&borrowername="+appname;
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(modname=="SARFI")
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/SarfaeriProposal_page1.jsp?cbsid="+id+"&hidmoduletype="+modname+"&apptype="+apptype+"&borrowername="+appname;
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
}

function callDigiLink(appno,compname,id,mailtype,prdtype,cbsstatus,proptype,createdate)
{

	var rights = "<%=session.getAttribute("strGroupRights")%>"
	/*if(cbsstatus !="Y")
	{
		alert("Customer Profile is not filled completely");
		return;
	}*/
	
    document.forms[0].hidCategoryType.value="DIGI";

	document.forms[0].radLoan.value="Y";
	document.forms[0].page.value="ep";
	document.forms[0].appno.value=appno;
	document.forms[0].hidBeanId.value="perapplicant";
	document.forms[0].hidBeanGetMethod.value="getLoanProducts";		
	if(mailtype != "CC")
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/perDigiLoandetails.jsp?compname="+compname+"&appid="+id+"&appholder=Y";
	else
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/perDigiLoandetails.jsp?compname="+compname+"&appid="+id+"&appholder=N";
	document.forms[0].target="mainFrame";
	document.forms[0].submit();	
}

function callRevalLink(appno,prdtype,proptype)
{
	if(proptype=="P" && (prdtype=="pG" || prdtype=="pR"))
	{
		 document.forms[0].hidCategoryType.value="LAD";
	}
	else if(proptype=="P"){
		 document.forms[0].hidCategoryType.value="RET";
	}
	else if(proptype=="A"){
		 document.forms[0].hidCategoryType.value="AGR";
	}
	else if(proptype=="C"){
   		document.forms[0].hidCategoryType.value="CORP";
   	}
	document.forms[0].appno.value=appno;
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanGetMethod.value="getHistory";	
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/appworkflowhistory.jsp";
	document.forms[0].target="mainFrame";
	document.forms[0].submit();	
}
function callPerLink(appno,compname,id,mailtype,prdtype,cbsstatus,proptype,createdate)
{
		var rights = "<%=session.getAttribute("strGroupRights")%>"
		if(cbsstatus !="Y")
		{
			//alert("Customer Profile is not filled completely");
			//return;
		}
		
        <%if(strFormType.equals("P")||strFormType.equals("PER_OL")){%>
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
				document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/ladloandetails.jsp?compname="+compname+"&appid="+id+"&strAppType="+proptype+"&appholder=Y&varGLdate=Y";
			else
				document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/ladloandetails.jsp?compname="+compname+"&appid="+id+"&strAppType="+proptype+"&appholder=N";
			}
			else
			{
				
				if(mailtype != "CC")
					document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/perloandetails.jsp?compname="+compname+"&appid="+id+"&strAppType="+proptype+"&appholder=Y";
				else
					document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/perloandetails.jsp?compname="+compname+"&appid="+id+"&strAppType="+proptype+"&appholder=N";
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

function callDigiGoldLink(appno,compname,id,mailtype,prdtype,cbsstatus,proptype,createdate)
{
		var rights = "<%=session.getAttribute("strGroupRights")%>"
		if(cbsstatus !="Y")
		{
			alert("Customer Profile is not filled completely");
			return;
		}
		
        <%if(strFormType.equals("P")||strFormType.equals("PER_OL")){%>
        	document.forms[0].hidCategoryType.value="RET";
        <% }else if(strFormType.equals("A")){%>
            document.forms[0].hidCategoryType.value="AGR";
        <% }else if(strFormType.equals("J")){%>
        document.forms[0].hidCategoryType.value="LAD";
        <%}else if(strFormType.equals("DIGIGOLD")){%>
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
				document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/ladloandetails.jsp?compname="+compname+"&appid="+id+"&strAppType="+proptype+"&appholder=Y&varGLdate=Y";
			else
				document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/ladloandetails.jsp?compname="+compname+"&appid="+id+"&strAppType="+proptype+"&appholder=N";
			}
			else
			{
				
				if(mailtype != "CC")
					document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/perloandetails.jsp?compname="+compname+"&appid="+id+"&strAppType="+proptype+"&appholder=Y";
				else
					document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/perloandetails.jsp?compname="+compname+"&appid="+id+"&strAppType="+proptype+"&appholder=N";
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
function callLinkbanker(hidappno,applname,org,sendby,senton,appid)
{
	
	document.forms[0].hidDemoId.value=appid;
	document.forms[0].hidapplno.value=hidappno;
	document.forms[0].hidBeanId.value="comsolvency";
	document.forms[0].hidBeanGetMethod.value="getBankersData";	
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/com_bankers.jsp";
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



function callOPSLink(appno,compname,id,mailtype)
{
		var rights = "<%=session.getAttribute("strGroupRights")%>"
		document.forms[0].appno.value=appno;
		document.forms[0].hidBeanId.value="facilities";
		document.forms[0].hidBeanGetMethod.value="getOPSFacilityData";
		if(mailtype !="CC")
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/ops_facilities.jsp?compname="+compname+"&comapp_id="+id+"&cattype=OPS&appholder=Y";
		else
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/ops_facilities.jsp?compname="+compname+"&comapp_id="+id+"&cattype=OPS&appholder=N";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
}

function callMONLink(appno,month,year,name,org_code,mmrno,mmrorgname,mmrholder)
{

	if(org_code==varOrgShortCode)			
	{
		statusflag = 'O';
	}
	else
	{
		statusflag = 'P';
	}
	document.forms[0].npa_appno.value=appno;
	document.forms[0].hidBeanId.value="mmrcommon";
	document.forms[0].hidBeanGetMethod.value="getMMRFacility";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/mon_facilitiesenjoyed.jsp?mon_month="+month+"&mon_year="+year+"&cbsname="+name+"&cbsid="+appno+"&statusflag="+statusflag+"&mmrno="+mmrno+"&mmrapporgname="+mmrorgname+"&mmrappholder="+mmrholder;
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
	if(SFT=="DIGICORP")
	{
		var stat = status.split(' ');
		document.forms[0].hidCategoryType.value =cname;
		document.forms[0].hidSSIType.value =status;

		appstat = stat[0];
		compstat = stat[1];
		callComLink(appno,cname,appstat,compstat,type,valuesin,varproptype,appid);
	}
	
	//shiva
	if(SFT=="DIGIAGRI")
	{
		var stat = status.split(' ');
		document.forms[0].hidCategoryType.value =cname;
		document.forms[0].hidSSIType.value =status;

		appstat = stat[0];
		compstat = stat[1];
		callComLink(appno,cname,appstat,compstat,type,valuesin,varproptype,appid);
	}
}
function callLodgedLink(appno,cname,status,type,valuesin)
{
	var rights = "<%=session.getAttribute("strGroupRights")%>"
	var SFT = "<%=strFormType%>";
	
	if(SFT=="AGR_OL" || SFT=="COM_OL")
	{
		var stat = status.split(' ');
		document.forms[0].hidCategoryType.value =cname;
		document.forms[0].hidSSIType.value =status;

		appstat = stat[0];
		compstat = stat[1];
		callLodgedPropComLink(appno,cname,appstat,compstat,type,valuesin);
	}
}


function callSreLink(appno,cname,pstatus,cstatus,mailtype)
{
	
		document.forms[0].appno.value=appno;
		document.forms[0].appname.value=cname;
		<%if(strFormType.equalsIgnoreCase("E")){%>
			document.forms[0].hidCategoryType.value="SRE";
			txtLoad('SHORT REVIEW EXTENSION');
		<%}else if(strFormType.equalsIgnoreCase("H")){%>
			document.forms[0].hidCategoryType.value="ADC";	
			txtLoad('ADHOC LIMIT');
		<%} else {%>
			document.forms[0].hidCategoryType.value="STL";
			txtLoad('SHORT TERM LOAN');
		<%}%>		
		document.forms[0].appstatus.value=pstatus+"/"+cstatus;
		document.forms[0].hidBeanId.value="facilities";
		document.forms[0].hidBeanGetMethod.value="getFacilityData";
		if(mailtype!="CC")
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/facilities.jsp?hidPageType="+document.forms[0].hidCategoryType.value+"&appholder=Y";
		else
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/facilities.jsp?hidPageType="+document.forms[0].hidCategoryType.value+"&appholder=N";
		document.forms[0].target="mainFrame"
		document.forms[0].submit();
}

function onloading()
{

}

function getMailBox(strFormType)
{
	var strFlag=false;

	document.mails.optformtype.value=strFormType;
	document.mails.action="<%=ApplicationParams.getAppUrl()%>action/inboxmails.jsp?fromlink=mailbox";
	document.mails.submit();
}

function changeLabel()
{

	if(("<%=strFormType%>"=="P"))
	{
	document.all.dataid.innerHTML='<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable"><tr class="dataheader"><td width="11%" height="22" align="center"> Proposal No.</td><td width="8%" height="22" id="nameid" align="center"> Applicant Name </td><td width="13%" height="22" id="orgid" align="center"> Product Name</td><td width="7%" height="22" align="center"> Total<br> Proposal <br> Limit</td><td width="8%" height="22" align="center">NP RefNo</td><td width="9%" height="22" align="center"> Type</td><td width="8%" height="22" align="center"> Whether Take Over</td> <td width="8%" id="sentbytd" style="visibility:visible" height="22" align="center"> Sent by</td><td width="9%" id="sentontd" style="visibility:visible" height="22" align="center">Sent on</td><td width="15%" height="22" align="center"> Process Status</td> <td width="10%" height="22" align="center">Query Pending Since from</td> </tr></table>';
	/* document.all.dataid.innerHTML='<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable"><tr class="dataheader"><td width="12%" height="22" align="center"> Proposal No.</td><td width="10%" height="22" id="nameid" align="center"> Applicant Name </td><td width="10%" height="22" id="orgid" align="center"> Product Name</td><td width="10%" height="22" align="center"> Total Proposal Limit</td><td width="15%" height="22" align="center"> Type</td><td width="10%" height="22" align="center"> Whether Take Over</td> <td width="8%" id="sentbytd" style="visibility:visible" height="22" align="center"> Sent by</td><td width="10%" id="sentontd" style="visibility:visible" height="22" align="center">Sent on</td><td width="15%" height="22" align="center"> Process Status</td> </tr></table>'; */
	}
	if("<%=strFormType%>"=="J")
	{
	document.all.dataid.innerHTML='<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable"><tr class="dataheader"><td width="12%" height="22" align="center"> Proposal No.</td><td width="20%" height="22" id="nameid" align="center"> Applicant Name </td><td width="20%" height="22" id="orgid" align="center"> Product Name</td><td width="15%" height="22" align="center"> Type</td><td width="8%" id="sentbytd" style="visibility:visible" height="22" align="center"> Sent by</td><td width="10%" id="sentontd" style="visibility:visible" height="22" align="center">Sent on</td><td width="15%" height="22" align="center"> Process Status</td>  </tr></table>';
	}
	if("<%=strFormType%>"=="C")
	{
	document.all.dataid.innerHTML='<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable"><tr class="dataheader"><td width="8%" height="22" align="center"> Proposal No</td><td width="10%" height="22" id="nameid" align="center"> Applicant Name </td> <td width="10%" height="22" align="center"> Total Proposal Limit</td> <td width="10%" height="22" align="center"> NP RefNo</td> <td width="10%" height="22" align="center"> Type</td><td width="10%" height="22" align="center"> Whether Take Over</td><td width="10%" id="sentbytd" style="visibility:visible" height="22" align="center"> Sent by</td><td width="10%" id="sentontd" style="visibility:visible" height="22" align="center">Sent on</td> <td width="18%" height="22" align="center"> Process Status</td> <td width="10%" height="22" align="center">Query Pending Since from</td> </tr></table>';
	}
	if("<%=strFormType%>"=="A")
	{
		document.all.dataid.innerHTML='<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable"><tr class="dataheader"><td width="8%" height="22" align="center"> Proposal No</td><td width="10%" height="22" id="nameid" align="center"> Applicant Name </td> <td width="10%" height="22" align="center"> Total Proposal Limit</td> <td width="10%" height="22" align="center"> NP RefNo</td> <td width="10%" height="22" align="center"> Type</td><td width="10%" height="22" align="center"> Whether Take Over</td><td width="10%" id="sentbytd" style="visibility:visible" height="22" align="center"> Sent by</td><td width="10%" id="sentontd" style="visibility:visible" height="22" align="center">Sent on</td> <td width="18%" height="22" align="center"> Process Status</td> <td width="10%" height="22" align="center">Query Pending Since from</td> </tr></table>';
	}
	if("<%=strFormType%>"=="N")
	{
	document.all.dataid.innerHTML='<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable"><tr class="dataheader"> <td width="15%" height="22" align="center">Proposal No</td> <td width="20%" height="22" align="center">Applicant Name</td> <td width="17%" height="22" align="center">Module Type</td> <td width="13%" id="sentbytd" style="visibility:visible" height="22" align="center"> Sent by</td><td width="16%" id="sentontd" style="visibility:visible" height="22" align="center">Sent on</td> <td width="14%" id="sentontd" style="visibility:visible" height="22" align="center">Organisations</td> <td width="15%" id="sentontd" style="visibility:visible" height="22" align="center">Process Status </td></tr></table>';
	}
	if("<%=strFormType%>"=="M")
	{
	document.all.dataid.innerHTML='<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable"><tr class="dataheader"> <td width="10%" height="22" align="center">CBS ID</td> <td width="30%" height="22" align="center">Applicant Name</td> <td width="10%" height="22" align="center">Month</td> <td width="5%" id="sentontd" style="visibility:visible" height="22" align="center">Year </td> <td width="20%" height="22" align="center">Organisation</td><td width="10%" id="sentbytd" height="22" align="center"> Sent by</td><td width="15%" id="sentontd" style="visibility:visible" height="22" align="center">Sent on</td></tr></table>';
	}
	if("<%=strFormType%>"=="TL")
	{
		document.all.dataid.innerHTML='<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable"><tr class="dataheader"> <td width="15%" height="22" align="center">Term Loan Review No.</td> <td width="30%" height="22" align="center">Applicant Name</td><td width="22%" height="22" align="center">Organization</td> <td width="10%" height="22" align="center">Status</td> <td width="10%" id="sentontd" style="visibility:visible" height="22" align="center">Sent By </td> <td width="15%" id="sentbytd" style="visibility:visible" height="22" align="center"> Sent on</td><td width="16%" id="sentontd" style="visibility:visible" height="22" align="center">Review Year</td> <td width="12%" id="sentontd" style="visibility:visible" height="22" align="center"></td></tr></table>';
	}
	if("<%=strFormType%>"=="PI")
	{
		document.all.dataid.innerHTML='<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable"><tr class="dataheader"> <td width="15%" height="22" align="center">Application No.</td> <td width="20%" height="22" align="center">Applicant Name</td><td width="20%" height="22" align="center">Organization</td><td width="10%" height="22" align="center">Status</td><td width="10%" height="22" align="center">Sent By</td><td width="10%" height="22" align="center">Sent On</td></tr></table>';
	}
	if(("<%=strFormType%>"=="SOL")||("<%=strFormType%>"=="BANKER"))
	{
		document.all.dataid.innerHTML='<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable"><tr class="dataheader"><td width="18%" height="22" align="center">Application No.</td> <td width="23%" height="22" align="center">Applicant Name</td><td width="24%" height="22" align="center">Organization</td><td width="12%" height="22" align="center">Status</td><td width="8%" height="22" align="center">Sent By</td><td width="12%" height="22" align="center">Sent On</td></tr></table>';
	}
	if("<%=strFormType%>"=="KPOW")
	{
		document.all.dataid.innerHTML='<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable"><tr class="dataheader"><td width="18%" height="22" align="center">Application No.</td> <td width="23%" height="22" align="center">Applicant Name</td><td width="24%" height="22" align="center">Organization</td><td width="12%" height="22" align="center">Status</td><td width="8%" height="22" align="center">Sent By</td><td width="12%" height="22" align="center">Sent On</td></tr></table>';
	}
	if("<%=strFormType%>"=="FIN")
	{
		document.all.dataid.innerHTML='<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable"><tr class="dataheader"><td width="18%" height="22" align="center">Application No.</td> <td width="23%" height="22" align="center">Applicant Name</td><td width="24%" height="22" align="center">Organization</td><td width="12%" height="22" align="center">Status</td><td width="8%" height="22" align="center">Sent By</td><td width="12%" height="22" align="center">Sent On</td></tr></table>';
	}
	if(("<%=strFormType%>"=="PER_OL")||("<%=strFormType%>"=="JL_OL"))
	{
	document.all.dataid.innerHTML='<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable"><tr class="dataheader"><td width="12%" height="22" align="center"> Proposal No.</td><td width="20%" height="22" id="nameid" align="center"> Applicant Name </td><td width="20%" height="22" id="orgid" align="center"> Product Name</td><td width="15%" height="22" align="center"> Organisation</td>    <td width="15%" height="22" align="center"> Process Status</td> <td width="8%" id="sentbytd" style="visibility:visible" height="22" align="center"> Sent by</td><td width="10%" id="sentontd" style="visibility:visible" height="22" align="center">Sent on</td> </tr></table>';
	}
	if("<%=strFormType%>"=="COM_OL")
	{
	document.all.dataid.innerHTML='<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable"><tr class="dataheader"><td width="12%" height="22" align="center"> Proposal No</td><td width="20%" height="22" id="nameid" align="center"> Applicant Name </td><td width=20%" height="22" align="center"> Organisation</td> <td width="18%" height="22" align="center"> Process Status</td> <td width="20%" id="sentbytd" style="visibility:visible" height="22" align="center"> Sent by</td><td width="10%" id="sentontd" style="visibility:visible" height="22" align="center">Sent on</td> </tr></table>';
	}
	if("<%=strFormType%>"=="AGR_OL")
	{
	document.all.dataid.innerHTML='<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable"><tr class="dataheader"><td width="12%" height="22" align="center"> Proposal No</td><td width="20%" height="22" id="nameid" align="center"> Applicant Name </td><td width=20%" height="22" align="center"> Organisation</td>    <td width="18%" height="22" align="center"> Process Status</td> <td width="20%" id="sentbytd" style="visibility:visible" height="22" align="center"> Sent by</td><td width="10%" id="sentontd" style="visibility:visible" height="22" align="center">Sent on</td> </tr></table>';
	}
	if("<%=strFormType%>"=="SOC")
	{
	document.all.dataid.innerHTML='<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable"><tr class="dataheader"><td width="12%" height="22" align="center"> Security ID</td><td width="20%" height="22" id="nameid" align="center"> Applicant Name </td><td width=20%" height="22" align="center"> Security Type</td>    <td width="18%" height="22" align="center"> Security Classification</td> <td width="10%" id="sentbytd" style="visibility:visible" height="22" align="center"> Created by</td><td width="10%" id="sentontd" style="visibility:visible" height="22" align="center">Created on</td> <td width="10%" id="sentontd" style="visibility:visible" height="22" align="center">Status</td></tr></table>';
	}
	if("<%=strFormType%>"=="SCM")
	{
		document.all.dataid.innerHTML='<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable"><tr class="dataheader"><td width="12%" height="22" align="center"> Security ID</td><td width="20%" height="22" id="nameid" align="center"> Applicant Name </td><td width=20%" height="22" align="center"> Security Type</td>    <td width="18%" height="22" align="center"> Security Classification</td> <td width="10%" id="sentbytd" style="visibility:visible" height="22" align="center"> Created by</td><td width="10%" id="sentontd" style="visibility:visible" height="22" align="center">Created on</td> <td width="10%" id="sentontd" style="visibility:visible" height="22" align="center">Status</td></tr></table>';
	}
	if("<%=strFormType%>"=="DEV")
	{
		document.all.dataid.innerHTML='<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable"><tr class="dataheader"><td width="12%" height="22" align="center"> Proposal No</td><td width="20%" height="22" id="nameid" align="center"> Applicant Name </td><td width="15%" id="sentbytd" style="visibility:visible" height="22" align="center"> Send By</td><td width=15%" id="sentontd" style="visibility:visible" height="22" align="center">Send On</td> <td width="15%" id="org_name" style="visibility:visible" height="22" align="center"> Organisation</td><td width="15%" id="sentontd" style="visibility:visible" height="22" align="center">Status</td></tr></table>';
	}
	if("<%=strFormType%>"=="REQ")
	{
		document.all.dataid.innerHTML='<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable"><tr class="dataheader"><td width="12%" height="22" align="center"> Proposal No</td><td width="25%" height="22" align="center"> Applicant Name</td><td width="21%" id="sentbytd" style="visibility:visible" height="22" align="center"> Created by</td><td width="21%" id="sentontd" style="visibility:visible" height="22" align="center">Created on</td> <td width="21%" id="sentontd" style="visibility:visible" height="22" align="center">Module</td></tr></table>';
	}
	if("<%=strFormType%>"=="RES")
	{
		document.all.dataid.innerHTML='<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable"><tr class="dataheader"><td width="12%" height="22" align="center"> Proposal No</td><td width="25%" height="22" align="center"> Applicant Name</td><td width="21%" id="sentbytd" style="visibility:visible" height="22" align="center"> Replied by</td><td width="21%" id="sentontd" style="visibility:visible" height="22" align="center">Replied on</td> <td width="21%" id="sentontd" style="visibility:visible" height="22" align="center">Module</td></tr></table>';
	}
	if("<%=strFormType%>"=="DIGI")
	{
		document.all.dataid.innerHTML='<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable"><tr class="dataheader"><td width="10%" height="22" align="center"> Proposal No.</td><td width="20%" height="22" id="nameid" align="center"> Applicant Name </td><td width="20%" height="22" id="orgid" align="center"> Product Name</td><td width="15%" height="22" align="center"> Process Status</td> <td width="8%" id="sentbytd" style="visibility:visible" height="22" align="center"> Sent by</td><td width="10%" id="sentontd" style="visibility:visible" height="22" align="center">Sent on</td><td width="15%" height="22" align="center"> Type</td> </tr></table>';
	}
	if("<%=strFormType%>"=="REVAL")
	{
		document.all.dataid.innerHTML='<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable"><tr class="dataheader"><td width="10%" height="22" align="center"> Proposal No.</td><td width="20%" height="22" id="nameid" align="center"> Applicant Name </td><td width="15%" height="22" align="center"> Organisation name</td><td width="15%" height="22" align="center"> Process status</td><td width="15%" height="22" align="center"> Module Type</td> <td width="10%" id="sentbytd" style="visibility:visible" height="22" align="center"> Sent by</td><td width="15%" id="sentontd" style="visibility:visible" height="22" align="center">Sent on</td> </tr></table>';
	}
	if("<%=strFormType%>"=="DIGICORP")
	{
	document.all.dataid.innerHTML='<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable"><tr class="dataheader"><td width="12%" height="22" align="center"> Proposal No</td><td width="20%" height="22" id="nameid" align="center"> Applicant Name </td><td width="18%" height="22" align="center"> Process Status</td> <td width="20%" id="sentbytd" style="visibility:visible" height="22" align="center"> Sent by</td><td width="10%" id="sentontd" style="visibility:visible" height="22" align="center">Sent on</td> <td width=20%" height="22" align="center"> Type</td> </tr></table>';
	}
	//shiva
	if("<%=strFormType%>"=="DIGIAGRI")
	{
	document.all.dataid.innerHTML='<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable"><tr class="dataheader"><td width="12%" height="22" align="center"> Proposal No</td><td width="20%" height="22" id="nameid" align="center"> Applicant Name </td><td width="18%" height="22" align="center"> Process Status</td> <td width="20%" id="sentbytd" style="visibility:visible" height="22" align="center"> Sent by</td><td width="10%" id="sentontd" style="visibility:visible" height="22" align="center">Sent on</td> <td width=20%" height="22" align="center"> Type</td> </tr></table>';
	}
	if("<%=strFormType%>"=="MSME")
	{
		document.all.dataid.innerHTML='<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable"><tr class="dataheader"><td width="7%" height="22" align="center"> Proposal No</td><td width="10%" height="22" id="nameid" align="center"> Applicant Name </td><td width=10%" height="22" align="center"> Customer CBSID</td> <td width="7%"  style="visibility:visible" height="22" align="center"> Created by</td><td width="7%"  style="visibility:visible" height="22" align="center">Created on</td><td width="7%"  style="visibility:visible" height="22" align="center">Sent By</td><td width="7%"  style="visibility:visible" height="22" align="center">Sent on</td><td width="7%"  style="visibility:visible" height="22" align="center">Received By</td><td width="7%"  style="visibility:visible" height="22" align="center">Received on</td><td width="10%"  style="visibility:visible" height="22" align="center">Process Status</td> <td width="10%"  style="visibility:visible" height="22" align="center">Status</td></tr></table>';
	}
	if("<%=strFormType%>"=="DIGIGOLD")
	{
		document.all.dataid.innerHTML='<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable"><tr class="dataheader"><td width="12%" height="22" align="center"> Proposal No.</td><td width="20%" height="22" id="nameid" align="center"> Applicant Name </td><td width="20%" height="22" id="orgid" align="center"> Product Name</td><td width="15%" height="22" align="center"> Type</td><td width="8%" id="sentbytd" style="visibility:visible" height="22" align="center"> Sent by</td><td width="10%" id="sentontd" style="visibility:visible" height="22" align="center">Sent on</td><td width="15%" height="22" align="center"> Process Status</td>  </tr></table>';
	}
}

function callTLReviewLink(accno,cbsid,year,toid,name,status)
{
		document.forms[0].hidBeanId.value="reviewtermloan";
		document.forms[0].hidBeanGetMethod.value="getReviewNoteTermLoan";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/reviewnotetypeofreview.jsp?hidBeanId=reviewtermloantwo&hidBeanGetMethod=getTypeReviewTermLoan&cbsid="+cbsid+"&hidtlrno="+accno+"&reviewYear="+year+"&cbsname="+name+"&appstatus="+status;
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
}	

function callSaralReviewLink(inwardno,appname,sector,status,appassign,appatached,valuesin,appliedfor,issaralhead,isorghead)
{
	document.forms[0].hidBeanId.value="inwardRegister";
	document.forms[0].hidBeanGetMethod.value="getdata";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/appinwardreg.jsp?hidBeanId=inwardRegister&hidBeanGetMethod=getdata&inwardno="+inwardno+"&hidsaral=saral&appname="+appname+"&issaralhead="+issaralhead+"&hidsector="+sector+"&hidstatus="+status+"&hidappassign="+appassign+"&hidappatached="+appatached+"&valuesin="+valuesin+"&isorghead="+isorghead+"&appliedfor="+appliedfor;
	document.forms[0].target="mainFrame";
	document.forms[0].submit();
}
function callBSTLink(appno,comp_name,comp_id,status)
{
	document.forms[0].appno.value=appno;
	document.forms[0].appname.value=comp_name;
	document.forms[0].hidBeanId.value="broadsancterms";
	document.forms[0].hidBeanGetMethod.value="getBSTfacility";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/combst_facility.jsp?hidBeanId=broadsancterms&hidBeanGetMethod=getBSTfacility&appname="+comp_name+"&com_id="+comp_id+"&appstatus="+status+"&hidcatory=bst";
	document.forms[0].target="mainFrame";
	document.forms[0].submit();
}

function callMSTLink(appno,comp_name,status)
{

	document.forms[0].appno.value=appno;
	document.forms[0].appname.value=comp_name;
	document.forms[0].hidBeanId.value="modsancterms";
	document.forms[0].hidBeanGetMethod.value="getfacilityData";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/commst_facilities.jsp?appstatus="+status+"&hidcatory=MST";
	document.forms[0].target="mainFrame";
	document.forms[0].submit();
}
function callPostInspection(postinsno, instype)
{
	document.forms[0].hidBeanId.value="postinspection";
	document.forms[0].hidBeanGetMethod.value="getPostInspectionReport";
	if(instype=="R")
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/postinspection_retail_report.jsp?&hidpostins_no="+postinsno+"&hidreviewtype="+instype;
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(instype=="A")
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/followupInspectionReport.jsp?&hidpostins_no="+postinsno+"&hidreviewtype="+instype;
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(instype=="C")
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/mon_inspectionreport.jsp?hidpostins_no="+postinsno+"&hidreviewtype="+instype;
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
}

function getMonMailBox(strFormType)
{
	var strFlag=false;

	document.mails.optformtype.value=strFormType;
	document.mails.action="<%=ApplicationParams.getAppUrl()%>action/inboxmails.jsp?fromlink=mailbox&hidBeanGetMethod=getMonData";
	document.mails.submit();
}
function callSocLink(varsecid)
{
	document.mails.action="<%=ApplicationParams.getAppUrl()%>action/setsecurityownerchange.jsp?hidBeanId=securitymaster&hidBeanGetMethod=getSecurityOwnerChange&strPageFrom=inbox&hidSecurityId="+varsecid;
	document.mails.submit();
}
function callSCMLink(varsecid,varUserFlag,varflag1)
{
	if(varUserFlag=="" && varflag1=="false")
	{
		alert("If security needs to be verified click on Receive button");
		return;
	}
	document.mails.action="<%=ApplicationParams.getAppUrl()%>action/setSecurityApprove.jsp?hidBeanId=securitymaster&hidBeanGetMethod=getSecurityApproval&strPageFrom=inbox&hidSecurityId="+varsecid;
	document.mails.submit();
}

function callDEVLink(varappno)
{
	document.mails.action="<%=ApplicationParams.getAppUrl()%>action/permission_gist.jsp?hidBeanId=perDeviation&hidBeanGetMethod=getPermissionGistData&strPageFrom=inbox&hidAppno="+varappno;
	document.mails.submit();
}
function callQUELink(varappno,varQueryID,varType)
{
	document.forms[0].appno.value=varappno;
	document.mails.action="<%=ApplicationParams.getAppUrl()%>action/appqueryreply.jsp?hidBeanId=documentsupport&hidBeanGetMethod=getQueryDetails&strPageFrom=inbox&hidsno="+varQueryID+"&hidType="+varType;
	document.mails.submit();
}

function callSecurity(varsecid1)
{
	document.forms[0].hidAction.value="receive";
	document.forms[0].hidBeanId.value="securitymaster";
	document.forms[0].hidBeanGetMethod.value="updateSecurityOwnerChange";
	document.forms[0].action=appURL+"action/setsecurityownerchange.jsp?hidSecurityId="+varsecid1;
	document.forms[0].target="mainFrame";
	document.forms[0].submit();
}

function callSecurityVerify(varsecid1)
{
	document.forms[0].hidAction.value="receive";
	document.forms[0].hidBeanId.value="securitymaster";
	document.forms[0].hidBeanGetMethod.value="updateSecurityApproval";
	document.forms[0].action=appURL+"action/setSecurityApprove.jsp?hidSecurityId="+varsecid1;
	document.forms[0].target="mainFrame";
	document.forms[0].submit();
}
function callMsmeVerify(varmsmeappno,varstrappid)
{
	document.forms[0].hidAction.value="receive";
	document.forms[0].hidBeanId.value="inwardRegister";
	document.forms[0].hidBeanGetMethod.value="updateMsmeApproval";
	document.forms[0].action=appURL+"action/msme_proposalapprove.jsp?hidappno="+varmsmeappno+"&hidappid="+varstrappid;
	document.forms[0].target="mainFrame";
	document.forms[0].submit();
}
function callMsmeRollback(varmsmeappno,varstrappid)
{
	document.forms[0].hidAction.value="rollback";
	document.forms[0].hidBeanId.value="inwardRegister";
	document.forms[0].hidBeanGetMethod.value="updateMsmeApproval";
	document.forms[0].action=appURL+"action/msme_proposalapprove.jsp?hidappno="+varmsmeappno+"&hidappid="+varstrappid;
	document.forms[0].target="mainFrame"; 
	document.forms[0].submit();
}

function callMSMELink(varmsmeappno,varUserFlag,varflag1,varinitiate,varstrappid,varStatus)
{
	
	if(varUserFlag=="" && varflag1=="false")
	{
		alert("If proposal needs to be verified click on Receive button");
		return;
	}
	if(varinitiate=="" || varStatus=="rb"){
		document.mails.action="<%=ApplicationParams.getAppUrl()%>action/msme_proposalsearch.jsp?hidBeanId=inwardRegister&hidBeanGetMethod=getmsmeproposalresult&strPageFrom=inbox&hidappno="+varmsmeappno+"&strinitiate="+varinitiate+"&hidappid="+varstrappid;
		document.mails.submit();
	}else{
		document.mails.action="<%=ApplicationParams.getAppUrl()%>action/msme_proposalapprove.jsp?hidBeanId=inwardRegister&hidBeanGetMethod=getMsmeApproval&strPageFrom=inbox&hidappno="+varmsmeappno+"&strinitiate="+varinitiate+"&hidappid="+varstrappid;
		document.mails.submit();
	}
	
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
<table width="95%" border="0" align="center" cellspacing="0" cellpadding="5" class="outertable border1 mt30 tableBg" >
	<tr>
		<%if(!strFormType.equals("S")){ %>
		<td width="20%" valign="top" class="bdrRight inboxNav">
			
		<table width="100%" border="0" cellspacing="0" cellpadding="5"  class="outertable">
	
	<%if(Helper.correctNull((String)hshValues.get("server")).equals("one")){ %>
	
			<%if(!Helper.correctNull((String)hshValues.get("strMailBoxPer")).equals("0")){ %>
			<tr>
				<td nowrap="nowrap"><a href="javascript:getMailBox('P')">
					<span class="iconCircle">
						<img class="inboxicon-normal" src="<%=ApplicationParams.getAppUrl()%>img/mailbox/retail.png" alt="">
						<img class="inboxicon-hover" src="<%=ApplicationParams.getAppUrl()%>img/mailbox/retail-h.png" alt="">

					</span>
					<b>Retail</b>
				<%boolmailavail=true; %> <span class="redfont notifySec"><%=Helper.correctNull((String)hshValues.get("strMailBoxPer"))%></span>
				</a></td>
			</tr>
			<%} %>
			<%if(!Helper.correctNull((String)hshValues.get("strMailBoxAgr")).equals("0")){ %>

			<tr>
				<td nowrap="nowrap"><a href="javascript:getMailBox('A')">
					<span class="iconCircle">
						<img class="inboxicon-normal" src="<%=ApplicationParams.getAppUrl()%>img/mailbox/agriculture.png" alt="">
						<img class="inboxicon-hover" src="<%=ApplicationParams.getAppUrl()%>img/mailbox/agriculture-h.png" alt="">

					</span>
					<b>Agriculture Agri</b>
				<%boolmailavail=true; %> <span class="redfont notifySec"><%=Helper.correctNull((String)hshValues.get("strMailBoxAgr"))%></span>
				</a></td>
			</tr>
			<%} %>
			<%if(!Helper.correctNull((String)hshValues.get("strMailBoxCom")).equals("0")){ %>
			<tr>
				<td nowrap="nowrap"><a href="javascript:getMailBox('C')">
					<span class="iconCircle">
						<img class="inboxicon-normal" src="<%=ApplicationParams.getAppUrl()%>img/mailbox/corporate.png" alt="">
						<img class="inboxicon-hover" src="<%=ApplicationParams.getAppUrl()%>img/mailbox/corporate-h.png" alt="">

					</span>
					<b>Corporate</b>
				<%boolmailavail=true; %> <span class="redfont notifySec"><%=Helper.correctNull((String)hshValues.get("strMailBoxCom"))%></span>
				</a></td>
			</tr>
			<%} %>
			
			<%if(!Helper.correctNull((String)hshValues.get("strMailBoxGold")).equals("0")){ %>
			<tr>
				<td nowrap="nowrap"><a href="javascript:getMailBox('J')">
					<span class="iconCircle">
						<img class="inboxicon-normal" src="<%=ApplicationParams.getAppUrl()%>img/mailbox/gold&deposit.png" alt="">
						<img class="inboxicon-hover" src="<%=ApplicationParams.getAppUrl()%>img/mailbox/gold&deposit-h.png" alt="">

					</span>
					<b>Gold &amp; Deposit</b>
				<%boolmailavail=true; %> <span class="redfont notifySec"><%=Helper.correctNull((String)hshValues.get("strMailBoxGold"))%></span>
				</a></td>
			</tr>
			<%} %>
				<%if(!Helper.correctNull((String)hshValues.get("strMailBoxSol")).equals("0")){ %>
			<tr>
				<td nowrap="nowrap"><a href="javascript:getMailBox('SOL')">
				<span class="iconCircle">
						<img class="inboxicon-normal" src="<%=ApplicationParams.getAppUrl()%>img/mailbox/solvency-certificate.png" alt="">
						<img class="inboxicon-hover" src="<%=ApplicationParams.getAppUrl()%>img/mailbox/solvency-certificate-h.png" alt="">

					</span>
				<b>Solvency</b>
				<%boolmailavail=true; %> <span class="redfont notifySec"><%=Helper.correctNull((String)hshValues.get("strMailBoxSol"))%></span>
				</a></td>
			</tr>
			<%} %>
			
			<%if(!Helper.correctNull((String)hshValues.get("strMailBoxKpow")).equals("0")){ %>
			<tr>
				<td nowrap="nowrap"><a href="javascript:getMailBox('KPOW')">
					<span class="iconCircle">
						<img class="inboxicon-normal" src="<%=ApplicationParams.getAppUrl()%>img/mailbox/k-power.png" alt="">
						<img class="inboxicon-hover" src="<%=ApplicationParams.getAppUrl()%>img/mailbox/k-power-h.png" alt="">

					</span>
					<b>K-Power </b>
				<%boolmailavail=true; %> <span class="redfont notifySec"><%=Helper.correctNull((String)hshValues.get("strMailBoxKpow"))%></span>
				</a></td>
			</tr>
			<%} %>
			
			<%if(!Helper.correctNull((String)hshValues.get("strMailBoxFin")).equals("0")){ %>
			<tr>
				<td nowrap="nowrap"><a href="javascript:getMailBox('FIN')">
					<span class="iconCircle">
						<img class="inboxicon-normal" src="<%=ApplicationParams.getAppUrl()%>img/mailbox/financial-rating.png" alt="">
						<img class="inboxicon-hover" src="<%=ApplicationParams.getAppUrl()%>img/mailbox/financial-rating-h.png" alt="">

					</span>
					<b>Financial/ Rating </b>
				<%boolmailavail=true; %> <span class="redfont notifySec"><%=Helper.correctNull((String)hshValues.get("strMailBoxFin"))%></span>
				</a></td>
			</tr>
			<%} %>
			
			<%if(!Helper.correctNull((String)hshValues.get("strMailBoxSOC")).equals("0") && (Helper.correctNull((String)hshValues.get("strSOCFlag")).equalsIgnoreCase("Y")) && strGroupRights.charAt(18) == 'w'){ %>
			<tr>
				<td nowrap="nowrap"><a href="javascript:getMailBox('SOC')"><b>Security Owner </br>Change Request</b>
				<%boolmailavail=true; %> <span class="redfont notifySec"><%=Helper.correctNull((String)hshValues.get("strMailBoxSOC"))%></span>
				</a></td>
			</tr>
			<%} %>
			<%if(!Helper.correctNull((String)hshValues.get("strMailBoxBANKER")).equals("0")){ %>
			<tr>
				<td nowrap="nowrap"><a href="javascript:getMailBox('BANKER')">
					<span class="iconCircle">
						<img class="inboxicon-normal" src="<%=ApplicationParams.getAppUrl()%>img/mailbox/bankers-certificate-mail.png" alt="">
						<img class="inboxicon-hover" src="<%=ApplicationParams.getAppUrl()%>img/mailbox/bankers-certificate-mail-h.png" alt="">

					</span>
					<b>Banker Certificate</b>
				<%boolmailavail=true; %> <span class="redfont notifySec"><%=Helper.correctNull((String)hshValues.get("strMailBoxBANKER"))%></span>
				</a></td>
			</tr>
			<%} %>
			
			<%if((Integer.parseInt(strsesUserClass)) >= (Integer.parseInt(Helper.correctInt((String)hshValues.get("strMinClassSCM")))) ){ %>
			<%if(!Helper.correctNull((String)hshValues.get("strMailBoxSCM")).equals("0")){ %>
			<tr>
				<td nowrap="nowrap"><a href="javascript:getMailBox('SCM')">
					<span class="iconCircle">
						<img class="inboxicon-normal" src="<%=ApplicationParams.getAppUrl()%>img/mailbox/Security-creation-modification.png" alt="">
						<img class="inboxicon-hover" src="<%=ApplicationParams.getAppUrl()%>img/mailbox/Security-creation-modification-h.png" alt="">

					</span>
					<b>Security <br>Creation /Modification</b>
				<%boolmailavail=true; %> <span class="redfont notifySec"><%=Helper.correctNull((String)hshValues.get("strMailBoxSCM"))%></span>
				</a></td>
			</tr>
			<%} } %>
			<%if(!Helper.correctNull((String)hshValues.get("strMailBoxDEV")).equals("0")){ %>			
			<tr>
				<td nowrap="nowrap"><a href="javascript:getMailBox('DEV')">
					<span class="iconCircle">
						<img class="inboxicon-normal" src="<%=ApplicationParams.getAppUrl()%>img/mailbox/permission.png" alt="">
						<img class="inboxicon-hover" src="<%=ApplicationParams.getAppUrl()%>img/mailbox/permission-h.png" alt="">

					</span>
					<b>Permission</b>
				<%boolmailavail=true; %> <span class="redfont notifySec"><%=Helper.correctNull((String)hshValues.get("strMailBoxDEV"))%></span>
				</a></td>
			</tr>	
			<%} %>
			
			<%if(!Helper.correctNull((String)hshValues.get("strMailBoxDigi")).equals("0")){ %>			
			<tr>
				<td nowrap="nowrap"><a href="javascript:getMailBox('DIGI')">
					<span class="iconCircle">
						<img class="inboxicon-normal" src="<%=ApplicationParams.getAppUrl()%>img/mailbox/digi-retail-mon.png" alt="">
						<img class="inboxicon-hover" src="<%=ApplicationParams.getAppUrl()%>img/mailbox/digi-retail-mon-h.png" alt="">

					</span>
					<b>Digi-Retail</b>
				<%boolmailavail=true; %> <span class="redfont notifySec"><%=Helper.correctNull((String)hshValues.get("strMailBoxDigi"))%></span>
				</a></td>
			</tr>	
			<%} %>
			<!-- shiva Corporate -->
			<%if(!Helper.correctNull((String)hshValues.get("strMailBoxCORPDigi")).equals("0")){ %>			
			<tr>
				<td  nowrap="nowrap"><a href="javascript:getMailBox('DIGICORP')">
					<span class="iconCircle">
						<img class="inboxicon-normal" src="<%=ApplicationParams.getAppUrl()%>img/mailbox/digi-corporate-mon.png" alt="">
						<img class="inboxicon-hover" src="<%=ApplicationParams.getAppUrl()%>img/mailbox/digi-corporate-mon-h.png" alt="">

					</span>
					<b>Digi-Corporate</b>
				<%boolmailavail=true; %> <span class="redfont notifySec"><%=Helper.correctNull((String)hshValues.get("strMailBoxCORPDigi"))%></span>
				</a></td>
			</tr>	
			<%} %>
			<!-- shiva Digi-corporate end -->
			<!-- shiva Digi-Agriculture Start -->
			<%if(!Helper.correctNull((String)hshValues.get("strMailBoxAgriDigi")).equals("0")){ %>			
			<tr>
				<td  nowrap="nowrap"><a href="javascript:getMailBox('DIGIAGRI')">
					<span class="iconCircle">
					 	<img class="inboxicon-normal" src="<%=ApplicationParams.getAppUrl()%>img/home/agriculture.png" alt=""> 
					    <img class="inboxicon-hover" src="<%=ApplicationParams.getAppUrl()%>img/home/agriculture.png" alt=""> 

					</span>
					<b>Digi-Agriculture</b>
				<%boolmailavail=true; %> <span class="redfont notifySec"><%=Helper.correctNull((String)hshValues.get("strMailBoxAgriDigi"))%></span>
				</a></td>
			</tr>	
			<%} %>
			
			<!-- shiva Digi-Agriculture end -->
			<%if(!Helper.correctNull((String)hshValues.get("strMailBoxReval")).equals("0")){ %>		
			<tr>
				<td nowrap="nowrap"><a href="javascript:getMailBox('REVAL')"><b>Revalidation</b>
				<%boolmailavail=true; %> <span class="redfont notifySec"><%=Helper.correctNull((String)hshValues.get("strMailBoxReval"))%></span>
				</a></td>
			</tr>	
			<%} %>
			<%//if(!Helper.correctNull((String)hshValues.get("strMBSentQuery")).equals("0")){ %>	
			<%--<tr>
				<td nowrap="nowrap"><a href="javascript:getMailBox('REQ')">Query</b>
				<%boolmailavail=true; %> <span class="redfont notifySec"><%=Helper.correctNull((String)hshValues.get("strMBSentQuery"))%></span>
				</a></td>
			</tr>	 --%>
			<%//}if(!Helper.correctNull((String)hshValues.get("strMBRepliedQuery")).equals("0")){ %>	
			<%--<tr>
				<td nowrap="nowrap"><a href="javascript:getMailBox('RES')">Query Reply</b>
				<%boolmailavail=true; %> <span class="redfont notifySec"><%=Helper.correctNull((String)hshValues.get("strMBRepliedQuery"))%></span>
				</a></td>
			</tr>	 --%>
			<%//} %>	
						
			<%if(!Helper.correctNull((String)hshValues.get("strMailBoxPerOL")).equals("0")||!Helper.correctNull((String)hshValues.get("strMailBoxAgrOL")).equals("0")||!Helper.correctNull((String)hshValues.get("strMailBoxComOL")).equals("0")){ %>
			<tr>
				<td nowrap="nowrap"><b>Lodged Proposal</b></td>
			</tr>
			<%if(!Helper.correctNull((String)hshValues.get("strMailBoxPerOL")).equals("0")){ %>
			<tr>
				<td nowrap="nowrap"><a href="javascript:getMailBox('PER_OL')"><b>Retail</b>
				<%boolmailavail=true; %> <span class="redfont notifySec"><%=Helper.correctNull((String)hshValues.get("strMailBoxPerOL"))%></span>
				</a></td>
			</tr>
			<%} %>
			<%if(!Helper.correctNull((String)hshValues.get("strMailBoxAgrOL")).equals("0")){ %>

			<tr>
				<td nowrap="nowrap"><a href="javascript:getMailBox('AGR_OL')"><b>Agriculture</b>
				<%boolmailavail=true; %> <span class="redfont notifySec"><%=Helper.correctNull((String)hshValues.get("strMailBoxAgrOL"))%></span>
				</a></td>
			</tr>
			<%} %>
			<%if(!Helper.correctNull((String)hshValues.get("strMailBoxComOL")).equals("0")){ %>
			<tr>
				<td nowrap="nowrap"><a href="javascript:getMailBox('COM_OL')"><b>Corporate</b>
				<%boolmailavail=true; %> <span class="redfont notifySec"><%=Helper.correctNull((String)hshValues.get("strMailBoxComOL"))%></span>
				</a></td>
			</tr>
			<%} %>
			<%if(!Helper.correctNull((String)hshValues.get("strMailBoxGoldOL")).equals("0")){ %>
			<tr>
				<td nowrap="nowrap"><a href="javascript:getMailBox('JL_OL')"><b>Gold &amp; Deposit</b>
				<%boolmailavail=true; %> <span class="redfont notifySec"><%=Helper.correctNull((String)hshValues.get("strMailBoxGoldOL"))%></span>
				</a></td>
			</tr>
			<%} %>
			
			<%} %>
			
			
	<%
		if(!Helper.correctNull((String)hshValues.get("strMailBoxMSME")).equals("0")){ %>
			<tr>
				<td nowrap="nowrap"><a href="javascript:getMailBox('MSME')">
					<span class="iconCircle">
						<img class="inboxicon-normal" src="<%=ApplicationParams.getAppUrl()%>img/mailbox/MSME.png" alt="">
						<img class="inboxicon-hover" src="<%=ApplicationParams.getAppUrl()%>img/mailbox/MSME-h.png" alt="">

					</span>
					<b>MSME Reclassification</b>
				<%boolmailavail=true; %> <span class="redfont notifySec"><%=Helper.correctNull((String)hshValues.get("strMailBoxMSME"))%></span>
				</a></td>
			</tr>
			<%}
	
	if(!Helper.correctNull((String)hshValues.get("strMailBoxGoldDigi")).equals("0")){ %>
		<tr>
				<td nowrap="nowrap"><a href="javascript:getMailBox('DIGIGOLD')">
					<span class="iconCircle">
						<img class="inboxicon-normal" src="<%=ApplicationParams.getAppUrl()%>img/mailbox/gold&deposit.png" alt="">
						<img class="inboxicon-hover" src="<%=ApplicationParams.getAppUrl()%>img/mailbox/gold&deposit-h.png" alt="">

					</span>
					<b>Digi-Gold &amp; Deposit</b>
				<%boolmailavail=true; %> <span class="redfont notifySec"><%=Helper.correctNull((String)hshValues.get("strMailBoxGoldDigi"))%></span>
				</a></td>
			</tr>
		<%}
	}
	
	else if(Helper.correctNull((String)hshValues.get("server")).equals("two")){ %>
			
			
			<%if(!Helper.correctNull((String)hshValues.get("strMailBoxMON")).equals("0")){ %>
			<tr>
				<td nowrap="nowrap"><a href="javascript:getMonMailBox('M')"><b>Monthly
				Monitoring Report</b> <%boolmailavail=true; %> <span class="redfont notifySec"><%=Helper.correctNull((String)hshValues.get("strMailBoxMON"))%></span>
				</a></td>
			</tr>
			<%} %>
			<%if(!Helper.correctNull((String)hshValues.get("strMailBoxNPA")).equals("0")){ %>
			<tr>
				<td nowrap="nowrap"><a href="javascript:getMonMailBox('N')"><b>NPA</b>
				<%boolmailavail=true; %> <span class="redfont notifySec"><%=Helper.correctNull((String)hshValues.get("strMailBoxNPA"))%></span>
				</a></td>
			</tr>
			<%} %>
			<%if(!Helper.correctNull((String)hshValues.get("strMailBoxTL")).equals("0")){ %>
			<tr>
				<td nowrap="nowrap"><a href="javascript:getMonMailBox('TL')"><b>Term
				Loan Review</b> <%boolmailavail=true; %> <span class="redfont notifySec"><%=Helper.correctNull((String)hshValues.get("strMailBoxTL"))%></span>
				</a></td>
			</tr>
			<%} %>
			<%if(!Helper.correctNull((String)hshValues.get("strMailBoxINS")).equals("0")){ %>
			<tr>
				<td nowrap="nowrap"><a href="javascript:getMonMailBox('PI')"><b>Post/
				Followup Inspection</b> <%boolmailavail=true; %> <span
					class="redfont notifySec"><%=Helper.correctNull((String)hshValues.get("strMailBoxINS"))%></span>
				</a></td>
			</tr>
			<%} %>
			<%} %>
		</table>
		</td>
		<%} %>
		
		<%if(boolmailavail || strFormType.trim().equals("S")){ %>
		<td width="80%" valign="top" class="outertable inboxright">
		<table width="95%" align="center" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="top" id="dataid">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" id="gridcontrols" style="width:120%;height:70px">
				<div class="cellContainer">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					 class="outertable border2" align="" style="border-collapse:collapse ;">
					<%
  if(vecVal!=null && vecVal.size()>0)
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
				else if(strCompType.trim().equalsIgnoreCase("SSI"))
				{
					strSsiType=Helper.correctNull((String)vecR.get(8));
				}
		   }
  %>
					<tr>
						<%
						
						if(strFormType.trim().equals("C")  || strFormType.trim().equals("A"))
						  {
						  %>
				<td width="12%" align="center" ><b><a
					href="javascript:callLink('<%=vecR.get(0)%>','<%=strCompType%>','<%=strSsiType%>','<%=vecR.get(10)%>','<%=vecR.get(11)%>','<%=Helper.correctNull((String)vecR.get(13))%>','<%=Helper.correctNull((String)vecR.get(9))%>')"
					class="blackfont"><%=vecR.get(0)%>&nbsp;</a></b></td>
				<td width="10%" ><%=vecR.get(1)%>&nbsp;</td>
				<td width="10%" ><%=vecR.get(15)%>&nbsp;</td>
				<td width="10%" ><%=vecR.get(17)%>&nbsp;</td>
				<td width="10%" ><%=vecR.get(12)%>&nbsp;</td>
				<td width="10%" ><%=vecR.get(16)%>&nbsp;</td>
				<td width="10%" >&nbsp;<%=vecR.get(5)%>&nbsp;&nbsp;<%=" - " +vecR.get(3)%>&nbsp;</td>
				<td width="10%" >&nbsp;<%=vecR.get(6)%>&nbsp;</td>
				<td width="17%" align="center" >&nbsp;<%=vecR.get(4)%>&nbsp;</td>
				<td width="10%" ><%=vecR.get(18)%>&nbsp;</td>
				
				<%
						  }
				
                        else if(strFormType.trim().equals("P")){
                       %>
						<td width="11%" height="22" align="center" ><b><a
							href="javascript:callPerLink('<%=vecR.get(0)%>','<%=Helper.encodeAmpersand(Helper.correctDoubleQuotesScript(Helper.replaceForJavaScriptString((String)vecR.get(1))))%>','<%=vecR.get(7)%>','<%=vecR.get(8)%>','<%=vecR.get(9)%>','<%=vecR.get(10)%>','<%=Helper.correctNull((String)vecR.get(12))%>','<%=Helper.correctNull((String)vecR.get(13))%>')"
							class="blackfont"><%=vecR.get(0)%></a></b></td>
						<td width="8%" height="22" align="center"><%=vecR.get(1)%>&nbsp;</td>
						<td width="13%" height="22" align="center" ><%=vecR.get(2)%>&nbsp;</td>
						<td width="7%" height="22" align="center" ><%=vecR.get(16)%>&nbsp;</td>
						<td width="8%" height="22" align="center" >&nbsp;<%=vecR.get(17)%>&nbsp;</td>
						<td width="9%" height="22" align="center" ><%=vecR.get(11)%>&nbsp;</td>
						<td width="8%" height="22" align="center" ><%=vecR.get(15)%>&nbsp;</td>
						<td width="8%" height="22" align="center" >&nbsp;<%=vecR.get(5)%>&nbsp;&nbsp;<%=" - " +vecR.get(3)%>&nbsp;</td>
						<td width="9%" height="22" align="center" >&nbsp;<%=vecR.get(6)%>&nbsp;</td>
						<td width="15%"  height="22" align="center">&nbsp;<%=vecR.get(4)%>&nbsp;</td>
					    <td width="16%" height="22" align="center" >&nbsp;<%=vecR.get(18)%>&nbsp;</td>
						<%
					    }
                        else if(strFormType.trim().equals("J")){%>
				<td width="12%" align="center" ><b><a
					href="javascript:callPerLink('<%=vecR.get(0)%>','<%=Helper.encodeAmpersand(Helper.correctDoubleQuotesScript(Helper.replaceForJavaScriptString((String)vecR.get(1))))%>','<%=vecR.get(7)%>','<%=vecR.get(8)%>','<%=vecR.get(9)%>','<%=vecR.get(10)%>','<%=Helper.correctNull((String)vecR.get(12))%>','<%=Helper.correctNull((String)vecR.get(13))%>')"
					class="blackfont"><%=vecR.get(0)%>&nbsp;</a></b></td>
				<td width="20%" ><%=vecR.get(1)%>&nbsp;</td>
				<td width="20%" ><%=vecR.get(2)%>&nbsp;</td>
				<td width="15%" ><%=vecR.get(11)%>&nbsp;</td>
				<td width="8%" >&nbsp;<%=vecR.get(5)%>&nbsp;&nbsp;<%=" - " +vecR.get(3)%>&nbsp;</td>
				<td width="10%" >&nbsp;<%=vecR.get(6)%>&nbsp;</td>
				<td width="14%"  >&nbsp;<%=vecR.get(4)%>&nbsp;</td>
				<%
							  }
						      else if(strFormType.trim().equals("DIGIGOLD")){%>
						<td width="12%" align="center" ><b><a
							href="javascript:callDigiGoldLink('<%=vecR.get(0)%>','<%=Helper.encodeAmpersand(Helper.correctDoubleQuotesScript(Helper.replaceForJavaScriptString((String)vecR.get(1))))%>','<%=vecR.get(7)%>','<%=vecR.get(8)%>','<%=vecR.get(9)%>','<%=vecR.get(10)%>','<%=Helper.correctNull((String)vecR.get(12))%>','<%=Helper.correctNull((String)vecR.get(13))%>')"
							class="blackfont"><%=vecR.get(0)%>&nbsp;</a></b></td>
						<td width="20%" ><%=vecR.get(1)%>&nbsp;</td>
						<td width="20%" ><%=vecR.get(2)%>&nbsp;</td>
						<td width="15%" ><%=vecR.get(11)%>&nbsp;</td>
						<td width="8%" >&nbsp;<%=vecR.get(5)%>&nbsp;&nbsp;<%=" - " +vecR.get(3)%>&nbsp;</td>
						<td width="10%" >&nbsp;<%=vecR.get(6)%>&nbsp;</td>
						<td width="14%"  >&nbsp;<%=vecR.get(4)%>&nbsp;</td>
						<%
						}
                         else     
						 if(strFormType.trim().equals("SOL"))
						  {
						  %>
						  <td width="19%" align="center" ><b><a
							href="javascript:callLinksol('<%=vecR.get(0)%>','<%=Helper.encodeAmpersand(Helper.correctDoubleQuotesScript(Helper.replaceForJavaScriptString((String)vecR.get(1))))%>','<%=vecR.get(2)%>','<%=vecR.get(3)%>','<%=vecR.get(4)%>','<%=vecR.get(5)%>','<%=vecR.get(6)%>')"
							class="blackfont"><%=vecR.get(0)%>&nbsp;</a></b></td>
							<td width="24%" ><%=vecR.get(1)%>&nbsp;</td>
							<td width="25%" align="center" >&nbsp;<%=vecR.get(2)%>&nbsp;</td>
							<td width="12%" >&nbsp;<%=vecR.get(6)%>&nbsp;</td>
							<td width="8" >&nbsp;<%=vecR.get(4)%>&nbsp;</td>
							<td width="12%" align="center">&nbsp;<%=vecR.get(3)%>&nbsp;</td>
				        <%
						  } 
						 else     
							 if(strFormType.trim().equals("BANKER"))
							  {
								 
							  %>
							  <td width="19%" align="center" ><b><a
								href="javascript:callLinkbanker('<%=vecR.get(0)%>','<%=Helper.encodeAmpersand(Helper.correctDoubleQuotesScript(Helper.replaceForJavaScriptString((String)vecR.get(1))))%>','<%=vecR.get(2)%>','<%=vecR.get(3)%>','<%=vecR.get(4)%>','<%=vecR.get(5)%>','<%=vecR.get(6)%>')"
								class="blackfont"><%=vecR.get(0)%>&nbsp;</a></b></td>
								<td width="24%" ><%=vecR.get(1)%>&nbsp;</td>
								<td width="25%" align="center" >&nbsp;<%=vecR.get(2)%>&nbsp;</td>
								<td width="12%" >&nbsp;<%=vecR.get(6)%>&nbsp;</td>
								<td width="8" >&nbsp;<%=vecR.get(4)%>&nbsp;</td>
								<td width="12%" align="center">&nbsp;<%=vecR.get(3)%>&nbsp;</td>
					        <%
							  } else 
						 if(strFormType.trim().equals("KPOW"))
						  {
						  %>
						  <td width="19%" align="center" ><b><a
							href="javascript:callLinkkpow('<%=vecR.get(0)%>','<%=Helper.encodeAmpersand(Helper.correctDoubleQuotesScript(Helper.replaceForJavaScriptString((String)vecR.get(1))))%>','<%=vecR.get(2)%>','<%=vecR.get(3)%>','<%=vecR.get(4)%>','<%=vecR.get(5)%>','<%=vecR.get(6)%>')"
							class="blackfont"><%=vecR.get(0)%>&nbsp;</a></b></td>
							<td width="24%" ><%=vecR.get(1)%>&nbsp;</td>
							<td width="25%" align="center" >&nbsp;<%=vecR.get(2)%>&nbsp;</td>
							<td width="12%" >&nbsp;<%=vecR.get(6)%>&nbsp;</td>
							<td width="8" >&nbsp;<%=vecR.get(4)%>&nbsp;</td>
							<td width="12%" align="center">&nbsp;<%=vecR.get(3)%>&nbsp;</td>
				        <%
						  } else if(strFormType.trim().equals("FIN"))
						  
						  {%>
						   <td width="19%" align="center" ><b><a
							href="javascript:callLinkFin('<%=vecR.get(0)%>','<%=Helper.encodeAmpersand(Helper.correctDoubleQuotesScript(Helper.replaceForJavaScriptString((String)vecR.get(1))))%>','<%=vecR.get(2)%>','<%=vecR.get(3)%>','<%=vecR.get(4)%>','<%=vecR.get(5)%>','<%=vecR.get(6)%>','<%=vecR.get(7)%>')"
							class="blackfont"><%=vecR.get(0)%>&nbsp;</a></b></td>
							<td width="24%" ><%=vecR.get(1)%>&nbsp;</td>
							<td width="25%" align="center" >&nbsp;<%=vecR.get(2)%>&nbsp;</td>
							<td width="12%" >&nbsp;<%=vecR.get(3)%>&nbsp;</td>
							<td width="8" >&nbsp;<%=vecR.get(4)%>&nbsp;</td>
							<td width="12%" align="center">&nbsp;<%=vecR.get(5)%>&nbsp;</td>
						  <%}else if(strFormType.trim().equals("PER_OL")||strFormType.trim().equals("JL_OL"))
						  
						  {%>
						   <td width="12%" align="center" ><b><a
							href="javascript:callPerLink('<%=vecR.get(0)%>','<%=Helper.encodeAmpersand(Helper.correctDoubleQuotesScript(Helper.replaceForJavaScriptString((String)vecR.get(1))))%>','<%=vecR.get(7)%>','<%=vecR.get(8)%>','<%=vecR.get(9)%>','<%=vecR.get(10)%>','<%=Helper.correctNull((String)vecR.get(11))%>','<%=Helper.correctNull((String)vecR.get(12))%>')"
							class="blackfont"><%=vecR.get(0)%>&nbsp;</a></b></td>
						<td width="20%" ><%=vecR.get(1)%>&nbsp;</td>
						<td width="20%" ><%=vecR.get(2)%>&nbsp;</td>
						<td width="15%" ><%=vecR.get(3)%>&nbsp;</td>
						<td width="15%"  >&nbsp;<%=vecR.get(4)%>&nbsp;</td>
						<td width="8%" >&nbsp;<%=vecR.get(5)%>&nbsp;</td>
						<td width="10%" >&nbsp;<%=vecR.get(6)%>&nbsp;</td>
						  <%}else if(strFormType.trim().equals("AGR_OL")||strFormType.trim().equals("COM_OL"))
						  
						  {%>
						   <td width="12%" align="center" ><b><a
							href="javascript:callLodgedLink('<%=vecR.get(0)%>','<%=strCompType%>','<%=strSsiType%>','<%=vecR.get(10)%>','<%=vecR.get(11)%>')"
							class="blackfont"><%=vecR.get(0)%>&nbsp;</a></b></td>
						<td width="20%" ><%=vecR.get(1)%>&nbsp;</td>
						<td width="20%" ><%=vecR.get(3)%>&nbsp;</td>
						<td width="18%" align="center" >&nbsp;<%=vecR.get(4)%>&nbsp;</td>
						<td width="20" >&nbsp;<%=vecR.get(5)%>&nbsp;</td>
						<td width="10%" >&nbsp;<%=vecR.get(6)%>&nbsp;</td>
						  <%}
						  else if(strFormType.trim().equals("SOC"))
							  
						  {%>
						   <td width="12%" align="center" ><b><a
							href="javascript:callSocLink('<%=Helper.correctNull((String)vecR.get(0))%>')"
							class="blackfont"><%=vecR.get(0)%>&nbsp;</a></b></td>
						<td width="20%" ><%=vecR.get(1)%>&nbsp;</td>
						<td width="20%" ><%=vecR.get(2)%>&nbsp;</td>
						<td width="18%" align="center" >&nbsp;<%=vecR.get(3)%>&nbsp;</td>
						<td width="20" >&nbsp;<%=vecR.get(4)%>&nbsp;</td>
						<td width="10%" >&nbsp;<%=vecR.get(5)%>&nbsp;</td>
						<td width="10%" align="center">
						<%if((Helper.correctNull((String)vecR.get(6)).equalsIgnoreCase(strUserId))||(Helper.correctNull((String)vecR.get(7)).equalsIgnoreCase(strUserId))){
							if(vecR.size()==1){%>
							<input type="button" name="cmdreceive"  value="Receive" class="buttonStyle" disabled>
							<%}else{ %>
							<input type="button" name="cmdreceive[<%=i %>]"  value="Receive" class="buttonStyle" disabled>
						  <%}}else{%>
						  <input type="button" name="cmdreceive" value="Receive"  class="buttonStyle" onclick="callSecurity('<%=Helper.correctNull((String)vecR.get(0))%>')">
						  <%} %>
							  </td>
							  <%}
						
                            else if(strFormType.trim().equals("N"))
                                  {
                                	 String npatype =Helper.correctNull((String)vecR.get(2));
                                	 
                                	 if(npatype.equalsIgnoreCase("OTSCO"))
                                	 {
                                		 npatype="COMPROMISE PROPOSAL";
                                	 }
                                	 else if(npatype.equalsIgnoreCase("SARFI"))
                                	 {
                                		 npatype="SARFAESI PROPOSAL";
                                	 }
                                	 else if(npatype.equalsIgnoreCase("PAWO"))
                                	 {
                                		 npatype="PRUDENTIAL WRITE OFF";
                                	 }
                                	 else if(npatype.equalsIgnoreCase("SUIT"))
                                	 {
                                		 npatype="FILING OF SUIT";
                                	 }
                                	 else if(npatype.equalsIgnoreCase("STAT"))
                                	 {
                                		 npatype="STATUS NOTE";
                                	 }
                                	 %>
						<td width="15%" align="center"><b><a
							href="javascript:callNPALink('<%=vecR.get(0)%>','<%=vecR.get(2)%>','<%=vecR.get(5)%>','<%=vecR.get(8)%>','<%=Helper.encodeAmpersand((String)vecR.get(9))%>')"
							class="blackfont"><%=vecR.get(0)%>&nbsp;</a></b></td>
						<td width="20%" align="left">&nbsp;<%=vecR.get(9)%>&nbsp;</td>
						<td width="17%" align="left">&nbsp;<%=npatype%>&nbsp;</td>
						<td width="13%">&nbsp;<%=vecR.get(3)%>&nbsp;</td>
						<td width="16%" align="center">&nbsp;<%=vecR.get(1)%>&nbsp;</td>
						<td width="14%" align="left">&nbsp;<%=vecR.get(7)%>&nbsp;</td>
						<td width="15%" align="center">&nbsp;<%=vecR.get(4)%>&nbsp;</td>

						<%}
                                  else if(strFormType.trim().equals("M"))
                                  {
                                  %>
						<td width="10%" align="center"><b><a
							href="javascript:callMONLink('<%=vecR.get(0)%>','<%=vecR.get(3)%>','<%=vecR.get(4)%>','<%=Helper.replaceForJavaScriptString((String)vecR.get(6))%>','<%=vecR.get(7)%>','<%=vecR.get(8)%>','<%=vecR.get(5)%>','<%=vecR.get(9)%>')"
							class="blackfont"><%=vecR.get(0)%>&nbsp;</a></b></td>
						<td width="30%" align="left">&nbsp;<%=vecR.get(6)%>&nbsp;</td>
						<td width="10%" align="left">&nbsp;<%=Helper.getMonths(Integer.parseInt((String)vecR.get(3)))%></td>
						<td width="5%">&nbsp;<%=vecR.get(4)%>&nbsp;</td>
						<td width="20%">&nbsp;<%=vecR.get(5)%>&nbsp;</td>
						<td width="10%" align="center">&nbsp;<%=vecR.get(2)%>&nbsp;</td>
						<td width="15%" align="left">&nbsp;<%=vecR.get(1)%>&nbsp;</td>
						<%} 	 		
  
 						 else if(strFormType.trim().equals("TL"))
 							 {
 							 %>
						<td width="15%" align="center"><b>
						<a href="javascript:callTLReviewLink('<%=vecR.get(0)%>','<%=vecR.get(1)%>','<%=vecR.get(5)%>','<%=vecR.get(8)%>','<%=vecR.get(9)%>','<%=vecR.get(11)%>')"><%=vecR.get(0)%>&nbsp;</a>
							</b></td>
						<td width="20%" align="left">&nbsp;<%=vecR.get(9)%>&nbsp;</td>
						<td width="15%" align="left">&nbsp;<%=vecR.get(10)%>&nbsp;</td>
						<td width="7%" align="left">&nbsp;<%=vecR.get(2)%></td>
						<td width="9%">&nbsp;<%=vecR.get(3)%>&nbsp;</td>
						<td width="12%" align="center">&nbsp;<%=vecR.get(4)%>&nbsp;</td>
						<td width="8%" align="left">&nbsp;<%=vecR.get(5)%>&nbsp;</td>
						<%}
 						 else if(strFormType.trim().equals("PI"))
						 {
						 %>
						<td width="15%" align="center"><b><a
							href="javascript:callPostInspection('<%=vecR.get(0)%>', '<%=vecR.get(7)%>')"
							class="blackfont"> <%=vecR.get(0)%>&nbsp;</a></b></td>
						<td width="20%">&nbsp;<%=vecR.get(1)%>&nbsp;</td>
						<td width="15%">&nbsp;<%=vecR.get(2)%>&nbsp;</td>
						<td width="10%">&nbsp;<%=vecR.get(3)%>&nbsp;</td>
						<td width="10%">&nbsp;<%=vecR.get(5)%>&nbsp;</td>
						<td width="10%">&nbsp;<%=vecR.get(6)%>&nbsp;</td>
						<%}
						 else if(strFormType.trim().equals("REVAL"))
						 {%>
						<td width="10%" align="center" ><b><a
							href="javascript:callRevalLink('<%=vecR.get(0)%>','<%=vecR.get(8)%>','<%=vecR.get(7)%>')"
							class="blackfont"><%=vecR.get(0)%>&nbsp;</a></b></td>
							<td width="20%" ><%=vecR.get(1)%>&nbsp;</td>
							<td width="15%" ><%=vecR.get(2)%>&nbsp;</td>
							<td width="15%"  >&nbsp;<%=vecR.get(3)%>&nbsp;</td>
							<td width="15%" >&nbsp;<%=vecR.get(6)%>&nbsp;</td>
							<td width="10%" >&nbsp;<%=vecR.get(4)%>&nbsp;</td>
							<td width="15%" >&nbsp;<%=vecR.get(5)%>&nbsp;</td>
 						<%}
 						else if(strFormType.trim().equals("SCM"))
						 {
 							boolean bflag=false;
 							if((Helper.correctNull((String)vecR.get(6)).equalsIgnoreCase(strUserId))||(Helper.correctNull((String)vecR.get(7)).equalsIgnoreCase(strUserId)))
 								bflag=true;
						 %>
						<td width="12%" align="center" ><b><a
							href="javascript:callSCMLink('<%=Helper.correctNull((String)vecR.get(0))%>','<%=Helper.correctNull((String)vecR.get(6)) %>','<%=bflag %>')"
							class="blackfont"><%=vecR.get(0)%>&nbsp;</a></b></td>
						<td width="20%" ><%=vecR.get(1)%>&nbsp;</td>
						<td width="20%" ><%=vecR.get(2)%>&nbsp;</td>
						<td width="18%" align="center" >&nbsp;<%=vecR.get(3)%>&nbsp;</td>
						<td width="20" >&nbsp;<%=vecR.get(4)%>&nbsp;</td>
						<td width="10%" >&nbsp;<%=vecR.get(5)%>&nbsp;</td>
						<td width="10%" align="center">
						<%if(bflag){
							%>
							<input type="button" name="cmdreceive"  value="Receive" class="buttonStyle" disabled>
							<%}else{%>
						  <input type="button" name="cmdreceive" value="Receive"  class="buttonStyle" onclick="callSecurityVerify('<%=Helper.correctNull((String)vecR.get(0))%>')">
						  <%} %>
							  </td>
							  <%}
 						else if(strFormType.trim().equals("DEV"))
						 {
							%>
						
						<td width="12%" align="center" ><b><a
							href="javascript:callDEVLink('<%=Helper.correctNull((String)vecR.get(0))%>')"
							class="blackfont"><%=vecR.get(0)%>&nbsp;</a></b></td>
						<td width="20%" ><%=vecR.get(1)%>&nbsp;</td>
						<td width="15%" ><%=vecR.get(2)%>&nbsp;</td>
						<td width="15%" ><%=vecR.get(3)%>&nbsp;</td>
						<td width="15%" ><%=vecR.get(5)%>&nbsp;</td>
						<td width="15%" ><%=vecR.get(4)%>&nbsp;</td>
					
						<%	 } 						
						else if(strFormType.trim().equalsIgnoreCase("DIGI"))
						  {
						  %>
						 	 <td width="12%" align="center" ><b><a
							href="javascript:callDigiLink('<%=vecR.get(0)%>','<%=Helper.encodeAmpersand(Helper.correctDoubleQuotesScript(Helper.replaceForJavaScriptString((String)vecR.get(1))))%>','<%=vecR.get(7)%>','<%=vecR.get(8)%>','<%=vecR.get(9)%>','<%=vecR.get(10)%>','<%=Helper.correctNull((String)vecR.get(12))%>','<%=Helper.correctNull((String)vecR.get(13))%>')"
							class="blackfont"><%=vecR.get(0)%>&nbsp;</a></b></td>
							<td width="20%" ><%=vecR.get(1)%>&nbsp;</td>
							<td width="20%" ><%=vecR.get(2)%>&nbsp;</td>
							<td width="15%"  >&nbsp;<%=vecR.get(4)%>&nbsp;</td>
							<td width="8%" >&nbsp;<%=vecR.get(5)%>&nbsp;&nbsp;<%=" - " +vecR.get(3)%>&nbsp;</td>
							<td width="10%" >&nbsp;<%=vecR.get(6)%>&nbsp;</td>
							<td width="15%" ><%=vecR.get(11)%>&nbsp;</td>
							<%
						 }
						else if(strFormType.trim().equalsIgnoreCase("DIGICORP"))
						  {
						  %>
						 	<td width="12%" align="center" ><b><a
							href="javascript:callLink('<%=vecR.get(0)%>','<%=strCompType%>','<%=strSsiType%>','<%=vecR.get(10)%>','<%=vecR.get(11)%>','<%=Helper.correctNull((String)vecR.get(13))%>','<%=Helper.correctNull((String)vecR.get(9))%>')"
							class="blackfont"><%=vecR.get(0)%>&nbsp;</a></b></td>
							<td width="20%" ><%=vecR.get(1)%>&nbsp;</td>
							<td width="18%" align="center" >&nbsp;<%=vecR.get(4)%>&nbsp;</td>
							<td width="20" >&nbsp;<%=vecR.get(5)%>&nbsp;&nbsp;<%=" - " +vecR.get(3)%>&nbsp;</td>
							<td width="10%" >&nbsp;<%=vecR.get(6)%>&nbsp;</td>
							<td width="20%" ><%=vecR.get(12)%>&nbsp;</td>
						 	  
						 	  
							<%
						 }
						
						//shiva
						
						else if(strFormType.trim().equalsIgnoreCase("DIGIAGRI"))
						  {
						  %>
						 	<td width="12%" align="center" ><b><a
							href="javascript:callLink('<%=vecR.get(0)%>','<%=strCompType%>','<%=strSsiType%>','<%=vecR.get(10)%>','<%=vecR.get(11)%>','<%=Helper.correctNull((String)vecR.get(13))%>','<%=Helper.correctNull((String)vecR.get(9))%>')"
							class="blackfont"><%=vecR.get(0)%>&nbsp;</a></b></td>
							<td width="20%" ><%=vecR.get(1)%>&nbsp;</td>
							<td width="18%" align="center" >&nbsp;<%=vecR.get(4)%>&nbsp;</td>
							<td width="20" >&nbsp;<%=vecR.get(5)%>&nbsp;&nbsp;<%=" - " +vecR.get(3)%>&nbsp;</td>
							<td width="10%" >&nbsp;<%=vecR.get(6)%>&nbsp;</td>
							<td width="20%" ><%=vecR.get(12)%>&nbsp;</td>
						 	  
						 	  
							<%
						 }
 						//else if(strFormType.trim().equals("REQ")||strFormType.trim().equals("RES"))
						
						else if(strFormType.equalsIgnoreCase("MSME"))
						 {
							boolean bflag=false;
 							if((Helper.correctNull((String)vecR.get(4)).equalsIgnoreCase(strUserId))||(Helper.correctNull((String)vecR.get(6)).equalsIgnoreCase(strUserId))||(Helper.correctNull((String)vecR.get(11)).equalsIgnoreCase("")) || (Helper.correctNull((String)vecR.get(8)).equalsIgnoreCase("rb")))
 								bflag=true;
						 %>
						 <td width="7%" align="center" ><b><a
							href="javascript:callMSMELink('<%=Helper.correctNull((String)vecR.get(0))%>','<%=Helper.correctNull((String)vecR.get(6)) %>','<%=bflag %>','<%=Helper.correctNull((String)vecR.get(11))%>','<%=Helper.correctNull((String)vecR.get(13))%>','<%=Helper.correctNull((String)vecR.get(8)) %>')"
							class="blackfont"><%=vecR.get(0)%>&nbsp;</a></b></td>
						<td width="10%"> <%=vecR.get(5)%>&nbsp;</td>
						<td width="7%"><%=vecR.get(1)%>&nbsp;</td>
						<td align="center" width="10%">&nbsp;<%=vecR.get(2)%>&nbsp;</td>
						<td width="7%">&nbsp;<%=vecR.get(3)%>&nbsp;</td>
						<td width="7%">&nbsp;<%=vecR.get(4)%>&nbsp;</td>
						<td width="7%">&nbsp;<%=vecR.get(7)%>&nbsp;</td>
						<td width="7%">&nbsp;<%=vecR.get(6)%>&nbsp;</td>
						<td width="7%">&nbsp;<%=vecR.get(10)%>&nbsp;</td>
						<td width="10%">&nbsp;<%=vecR.get(9)%>&nbsp;</td>
						<td width="10%" align="center">
						<%if(bflag){
							%>
							<input type="button" name="cmdreceive"  value="Receive" class="buttonStyle" disabled>
							<%}else{%>
						   	<%if((Integer.parseInt(Helper.correctInt((String)session.getAttribute("strUserClass")))>=Integer.parseInt(Helper.correctInt((String)vecR.get(12))))
						   			&& (Integer.parseInt(Helper.correctInt((String)vecR.get(12)))!=0)&&(Helper.correctNull((String)vecR.get(6)).equalsIgnoreCase(""))
						   			&&(Helper.correctNull((String)vecR.get(14)).equalsIgnoreCase("Y")) && !(Helper.correctNull((String)vecR.get(2)).equalsIgnoreCase(Helper.correctNull((String)session.getAttribute("strUserId")))) ){ %>
						    <input type="button" name="cmdreceive" value="Receive"  class="buttonStyle" onclick="callMsmeVerify('<%=Helper.correctNull((String)vecR.get(0))%>','<%=Helper.correctNull((String)vecR.get(13))%>')">
						    <%}else{%>
						        
							<input type="button" name="cmdreceive"  value="Receive" class="buttonStyle" disabled>
							<%if(Integer.parseInt(Helper.correctInt((String)session.getAttribute("strUserClass")))< Integer.parseInt(Helper.correctInt((String)vecR.get(12)))){ %>						    
							    <br> <input type="button" name="cmdrollback"  value="Rollback" class="buttonStyle"  onclick="callMsmeRollback('<%=Helper.correctNull((String)vecR.get(0))%>','<%=Helper.correctNull((String)vecR.get(13))%>')">
							    <%} %>
							<%} %>
							  </td>
							  <%}}
							%>
						
						<%-- <td width="12%" align="center" ><b><a href="javascript:callQUELink('<%=Helper.correctNull((String)vecR.get(0))%>','<%=Helper.correctNull((String)vecR.get(1))%>','<%=strFormType %>')"
							class="blackfont"><%=vecR.get(0)%>&nbsp;</a></b></td>
						<td width="25%" ><%=vecR.get(5)%>&nbsp;</td>
						<td width="21%" ><%=vecR.get(2)%>&nbsp;</td>
						<td width="21%" ><%=vecR.get(3)%>&nbsp;</td>
						<td width="21%" ><%=vecR.get(4)%>&nbsp;</td>--%>
					
						<%	// }
						
                                  }
                                  }else{
                                	  if(strFormType.trim().equals("C")  || strFormType.trim().equals("A") || strFormType.trim().equals("P")||strFormType.trim().equals("J")
                                			  ||strFormType.trim().equals("PER_OL")||strFormType.trim().equals("JL_OL")||strFormType.trim().equals("AGR_OL")||strFormType.trim().equals("COM_OL"))
                                	  {
                                  %>
                     <td colspan="7" align="center">No Record Found
				</td>
                                  <%}} %>
                 </tr>
				</table>
				</div> 
				</td>
				<%}else{ %>
				<td>
					<span class="red"><b>No Pending Activities</span></b>
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
<input type="hidden" name="appname"> 
<input type="hidden" name="appstatus"> 
<input type="hidden" name="radLoan"> 
<input type="hidden" name="page"> 
<input type="hidden" name="hidCategoryType" value="<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>">
<input type="hidden" name="hidSSIType" value="<%=Helper.correctNull((String)request.getParameter("hidSSIType"))%>">
<input type="hidden" name="npa_appno"> 
<input type="hidden" name="valuesin"> 
<input type="hidden" name="hidDemoId">
<input type="hidden" name="hidapplno" value="<%=Helper.correctNull((String)request.getParameter("hidapplno"))%>">
<input type="hidden" name="hidRatAppNo">
<input type="hidden" name="hidfinanceid">
<input type="hidden" name="hidbussID">
</form>
</body>
</html>
