<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
NumberFormat nf=NumberFormat.getInstance();
nf.setGroupingUsed(false);
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
String strAssessmentType= Helper.correctNull((String)hshValues.get("assessmenttype"));
			if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
			}
			ArrayList vecid1 = (ArrayList) hshValues.get("vecid1");
			ArrayList vecid2 = (ArrayList) hshValues.get("vecid2");
			ArrayList vecid3 = (ArrayList) hshValues.get("vecid3");
			ArrayList vecid4 = (ArrayList) hshValues.get("vecid4");
			ArrayList vecid5 = (ArrayList) hshValues.get("vecid5");

			String bgclr = "";
			String tagFlag = "";
			int p = 0, sizeyear = 0, from = 0, to = 0, vecModSize = 0;
			String temp = "", totcount = "", upto = "", pageval = "", strCurModule = "", identity = "", fromnext = "";
			totcount = Helper.correctNull((String) hshValues.get("totalyear"));
			upto = Helper.correctNull((String) hshValues.get("upto"));
			fromnext = Helper.correctNull((String) hshValues.get("from"));
			pageval = Helper.correctNull((String) hshValues.get("page"));
			identity = Helper.correctNull((String) hshValues.get("identity"));

			String strcat = "";
			if (!strCategoryType.equalsIgnoreCase(null)) {
				if (strCategoryType.equalsIgnoreCase("OPS")) {
					strcat = "Tertiary";
				} else {
					strcat = "Corporate";
				}
			}
			strCurModule = pageval;
			ArrayList g1 = new ArrayList();
			ArrayList g2 = new ArrayList();
			ArrayList g3 = new ArrayList();
			ArrayList year1 = new ArrayList();
			ArrayList year2 = new ArrayList();
			ArrayList year3 = new ArrayList();
			ArrayList year4 = new ArrayList();
			ArrayList year5 = new ArrayList();
			g2 = (ArrayList) hshValues.get("yearvalue");
			g3 = (ArrayList) hshValues.get("value");
			year1 = (ArrayList) hshValues.get("year1");
			year2 = (ArrayList) hshValues.get("year2");
			year3 = (ArrayList) hshValues.get("year3");
			year4 = (ArrayList) hshValues.get("year4");
			year5 = (ArrayList) hshValues.get("year5");
			ArrayList vecModule = (ArrayList) hshValues.get("tabdetails");
			if (vecModule != null) {
				vecModSize = vecModule.size();
			}
			String yearval[] = new String[5];
			String comboselect[] = new String[5];

			int y = 0, n = 0;

			if (g2!=null && g2.size() != 0) {
				sizeyear = g2.size();

				for (int k = 0; k <= g2.size() - 1; k++) {

					if ((k % 2) == 0) 
					{
						temp = Helper.correctNull((String) g2.get(k));
						yearval[y] = temp;
						y = y + 1;
					} 
					else if ((k % 2) == 1) 
					{
						temp = Helper.correctNull((String) g2.get(k));
						if (temp.trim().equals("fin_audit")) {
							temp = "a";
						} else if (temp.trim().equals("fin_unaudit")) {
							temp = "u";
						} else if (temp.trim().equals("fin_estimated")) {
							temp = "e";
						} else if (temp.trim().equals("fin_projection")) {
							temp = "p";
						}
						comboselect[n] = temp;
						n = n + 1;
					}
				}
				for (int d = 0; d <= 4; d++) 
				{
					if (comboselect[d] == null) {
						comboselect[d] = "S";

					}
					if (yearval[d] == null) {
						yearval[d] = "";
					}
				}
			} 
			else {
				for (p = 0; p <= 4; p++) {
					comboselect[p] = "S";
					yearval[p] = "";
				}
			}
			String strFinType1 = Helper.correctNull((String) comboselect[0]);
			String strFinType2 = Helper.correctNull((String) comboselect[1]);
			String strFinType3 = Helper.correctNull((String) comboselect[2]);
			String strFinType4 = Helper.correctNull((String) comboselect[3]);
			String strFinType5 = Helper.correctNull((String) comboselect[4]);

			String strYear1 = Helper.correctNull((String) yearval[0]);
			String strYear2 = Helper.correctNull((String) yearval[1]);
			String strYear3 = Helper.correctNull((String) yearval[2]);
			String strYear4 = Helper.correctNull((String) yearval[3]);
			String strYear5 = Helper.correctNull((String) yearval[4]);

			if (strFinType1.trim().equalsIgnoreCase("S")) {
				strFinType1 = Helper.correctNull((String) request.getParameter("type1"));
			}
			if (strFinType2.trim().equals("S")) {
				strFinType2 = Helper.correctNull((String) request.getParameter("type2"));
			}
			if (strFinType3.trim().equals("S")) {
				strFinType3 = Helper.correctNull((String) request.getParameter("type3"));
			}
			if (strFinType4.trim().equals("S")) {
				strFinType4 = Helper.correctNull((String) request.getParameter("type4"));
			}
			if (strFinType5.trim().equals("S")) {
				strFinType5 = Helper.correctNull((String) request.getParameter("type5"));
			}
			String strfintype = Helper.correctNull((String)hshValues.get("fintype"));
			String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();%>

<%@page import="java.text.NumberFormat"%><html>
<head>
<title>DSCR</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/com/finmain.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>	

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"><Script>

var appUrl = "<%=ApplicationParams.getAppUrl()%>";
 var varAction="<%=Helper.correctNull((String)hshValues.get("strAction"))%>";	
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var appno="<%=request.getParameter("appno")%>";
//Function Added for interface //by s.sathya moorthy
function  UploadtoRAM()
{		
	document.forms[0].hidBeanId.value="dscr"
	document.forms[0].hidBeanMethod.value="uploadtoRAM";
	document.forms[0].hidBeanGetMethod.value="getDataForDSCR";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/DSCR.jsp";
	document.forms[0].submit();	
}
function callCalender(fname)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
 		showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	}
}
function callLink12(page,method)
{		
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value="dscr";
	document.forms[0].pageval.value="RA";
	document.forms[0].action=appURL+"action/"+page;
	document.forms[0].submit();	 
}
function callCashFlow(page)
{	
	document.forms[0].hidBeanGetMethod.value="GetCashFlowData";
	document.forms[0].hidBeanId.value="comformula";
	document.forms[0].action=appURL+"action/"+page+"?flowtype=CA";
	document.forms[0].submit();	 
}
function comboselect()
{
	document.forms[0].combo1.value ="<%=strFinType1%>";
	document.forms[0].combo2.value ="<%=strFinType2%>";
	document.forms[0].combo3.value ="<%=strFinType3%>";
	document.forms[0].combo4.value ="<%=strFinType4%>";
	document.forms[0].combo5.value ="<%=strFinType5%>";
	
	document.forms[0].hidtype1.value ="<%=strFinType1%>";
	document.forms[0].hidtype2.value ="<%=strFinType2%>";
	document.forms[0].hidtype3.value ="<%=strFinType3%>";
	document.forms[0].hidtype4.value ="<%=strFinType4%>";
	document.forms[0].hidtype5.value ="<%=strFinType5%>";
}
function shownext(val)
{
	
	upto=<%=Integer.parseInt(upto)%>;
	page="<%=pageval%>";
	totcount=<%=totcount%>;
	fromnext=<%=Integer.parseInt(fromnext)%>;	
	if (val == "n")
	{
		if (upto == totcount)
		{
		from =1;
		}
		else
		{
			from = upto + 1;
		}
	}
	else if (val == "p")
	{
	     from = fromnext - 5;		
	}
	else if(val=="a")
	{
		from=upto+1;
	}
	document.forms[0].action=appURL+"action/DSCR.jsp?page="+page+"&from="+from;
	document.forms[0].hidBeanGetMethod.value="getDataForDSCR";
	document.forms[0].hidBeanId.value="dscr";
	document.forms[0].submit();
}
var xmlHttp=null;
function GetXmlHttpObject()
{	
	try
	{
		xmlHttp=new XMLHttpRequest();
	}
	catch(e)	
	{
		try
		{
			xmlHttp= new ActiveXObject("Msxml12.XMLHTTP");
		}
		catch(e)
		{
			xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
	}	
	return xmlHttp;	
}
//Function added for financial performance //by venu
function doCalculate()
{    
	var from=document.forms[0].fromnext.value;
	var seldivid="0";
    var pageval=document.forms[0].pageval.value;
    var cattype=document.forms[0].cattype.value;
    var ssitype="<%=strSSIType%>";
	var xmlHttp;
	var uri;
	xmlHttp=GetXmlHttpObject();
	if(xmlHttp==null)
	{
		alert("Browser Do Not Support Using Ajax....");
	}
	uri=appURL+"action/iframedscr.jsp?hidBeanGetMethod=updateDSCRFormula&hidBeanId=dscr&sel_divID="+seldivid+"&appno="+appno+"&pageval="+pageval+"&from="+from+"&cattype="+cattype+"&hidSSIType="+ssitype;
	uri = uri +"&sid="+Math.random();
	xmlHttp.onreadystatechange=loadCalculatedValues;
	xmlHttp.open("GET",uri,true);
	xmlHttp.send(null);
	//document.getElementById("progress").style.visibility="visible";
	document.forms[0].cmdcalculate.disabled=true;	
}
function loadCalculatedValues()
{
if(xmlHttp.readyState==4)
	{	
		var val4=xmlHttp.responseText;
		var chkVal = val4.split('&');
		for(var i=0;i<(chkVal.length);i++)
		{
			if(i==(chkVal.length-1))
			{
				
				 temp1=chkVal[i];
				document.forms[0].DscrAvg.value=temp1;
			}
			else
			{
		    temp1=chkVal[i];
		    var temp2=temp1.split(',');
		    if(temp2.length==2)
		    {
		   		for(j=0;j<(temp2.length-1);j++)
		   		{
		    		var k = i+1;
		    		document.forms[0].elements["calc"+k].value= temp2[j];
			    }
		   }
		   else
		   {
		  		for(j=0;j<(temp2.length-1);j++)
		   		{
		    		var k = i+1;
		    		document.forms[0].elements["calc"+k][j].value= temp2[j];
			   	}
		   }
			}
		}
		//document.getElementById("progress").style.visibility="hidden";
	}
}
function getFinType()
{
	
	<%if(!strCategoryType.equalsIgnoreCase("OPS") && (strfintype.equalsIgnoreCase(null) || strfintype.equalsIgnoreCase("")))
	{%>
	
	alert("Select the Financial Type");
	document.forms[0].hidBeanId.value="facilities"
	document.forms[0].hidBeanGetMethod.value="getFinancialtype";
	document.forms[0].action=appUrl+"action/comfintype.jsp";			
	document.forms[0].submit();
	
	<%}%>
}
function placeValues()
{	      
	disableFields(true);
	document.forms[0].combo1.disabled=true;
	document.forms[0].combo3.disabled=true;
	document.forms[0].combo2.disabled=true;
	document.forms[0].combo4.disabled=true;
	document.forms[0].combo5.disabled=true;			
	var sel_divID="<%=Helper.correctNull((String)hshValues.get("sel_divID"))%>";		
	document.forms[0].DscrAvg.value="<%=Helper.correctNull((String)hshValues.get("DscrAvg")) %>";
			
}
function doEdit()
{
	disableFields(false);
	enableButtons(true,false,false,false,false);
	document.forms[0].combo1.disabled=false;
	document.forms[0].combo3.disabled=false;
	document.forms[0].combo2.disabled=false;
	document.forms[0].combo4.disabled=false;
	document.forms[0].combo5.disabled=false;
	document.forms[0].cmdcalculate.disabled=true;
}
function doDelete()
{
	var frm=document.forms[0];	
	if(frm.chk1.checked==false && frm.chk2.checked==false && frm.chk3.checked==false && frm.chk4.checked==false &&frm.chk5.checked==false)
	{
		alert("Please select the year you want to delete");
		return;
	}
	else
	{
		if(ConfirmMsg(101))
		 {
			document.forms[0].combo1.disabled=false;
			document.forms[0].combo3.disabled=false;
			document.forms[0].combo2.disabled=false;
			document.forms[0].combo4.disabled=false;
			document.forms[0].combo5.disabled=false;
			document.forms[0].hidAction.value="delete"
			document.forms[0].hidBeanId.value="dscr"
			document.forms[0].hidBeanMethod.value="deleteData";
			document.forms[0].hidBeanGetMethod.value="getDataForDSCR";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].hidSourceUrl.value="/action/DSCR.jsp";
			document.forms[0].submit();
		 }
	}
}
function checkDesc()
{
	var len=document.forms[0].id.length.value;	
	for(var i=0;i<len;i++)
	{
		if (document.forms[0].type[i].value == "I")
		{
			var x="document.forms[0].desc"+i+".value";
			if (x == "")
			{
				var t = "document.forms[0].row"+id[i]+"c1".value
				t ="0.00"
			}
		}
	}
}
function doSave()
{
    var from=document.forms[0].fromnext.value;
	var frm=document.forms[0];
	var flag;	
	
  		disableFields(false);
		document.forms[0].combo1.disabled=false;
		document.forms[0].combo3.disabled=false;
		document.forms[0].combo2.disabled=false;
		document.forms[0].combo4.disabled=false;
		document.forms[0].combo5.disabled=false;			
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].hidAction.value="update"
		document.forms[0].hidBeanId.value="dscr"
		document.forms[0].hidBeanMethod.value="updateDSCRData";
		document.forms[0].hidBeanGetMethod.value="getDataForDSCR";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/DSCR.jsp?from="+from;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].submit();	

}
function doList()
{
	disableFields(false);
	document.forms[0].hidsel_divID.value="";
	document.forms[0].combo1.disabled=false;
	document.forms[0].combo3.disabled=false;
	document.forms[0].combo2.disabled=false;
	document.forms[0].combo4.disabled=false;
	document.forms[0].combo5.disabled=false;
	document.forms[0].hidBeanId.value="dscr"
	document.forms[0].hidBeanMethod.value="getDataList";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/DSCR.jsp";
	document.forms[0].submit();
}
function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="dscr"
		document.forms[0].hidBeanGetMethod.value="getDataForDSCR";
		document.forms[0].hidBeanMethod.value="getDataForDSCR";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/DSCR.jsp";
		document.forms[0].submit();
	 }	
}
function doClose()
{
 var cattype=document.forms[0].cattype.value;
 if((cattype=="ASSI")||(cattype=="ASBI") ||(cattype=="OPS"))
 {
        if(ConfirmMsg(100))
	 {
		 document.forms[0].action=appUrl+"action/agrborrowersearch.jsp";
		 document.forms[0].submit();
	 }
		}
		if((cattype=="SSI")||(cattype=="CORP")||(cattype=="SME"))
        {
        if(ConfirmMsg(100))
	 {
		 document.forms[0].action=appUrl+"action/comborrowersearch.jsp";
		 document.forms[0].submit();
	 }
		}  
}
function callLink(page,bean,method)
{	
	if (document.forms[0].cmdsave.disabled)
	{
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
	 }
	else
	{
		ConfirmMsg(103);
	}
}
function callLink1(page,bean)
{	
	if (document.forms[0].cmdsave.disabled)
	{
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
	 }
	else
	{
		ConfirmMsg(103);
	}
}
 function callApplicantTab(page)
  {    	
	if (document.forms[0].cmdsave.disabled)
	{
	  if(page=="company")
	  { 
		  document.forms[0].hidBeanGetMethod.value="getData";
		  document.forms[0].action=appURL+"action/comcompany.jsp";
	  }
	  if(page=="proposal")
	  {
		  document.forms[0].hidBeanGetMethod.value="getProposal";
		  document.forms[0].action=appURL+"action/comproposal.jsp";
	  }	 
	  document.forms[0].submit();
	 }
	else
	{
		ConfirmMsg(103);
	}	
  }  
function getSection(modid)
{	
    if(document.forms[0].cmdsave.disabled == false)
	{
		ShowAlert('103');
		return;
	}	
	if((varAction=="update") && (document.forms[0].cmdcalculate.disabled==false))
	{
	   alert("Press the Calculate Button");
	   return;
	}	
	document.forms[0].type1.value = document.forms[0].combo1.value;
	document.forms[0].type2.value = document.forms[0].combo2.value;
	document.forms[0].type3.value = document.forms[0].combo3.value;
	document.forms[0].type4.value = document.forms[0].combo4.value;
	document.forms[0].type5.value = document.forms[0].combo5.value;

	document.forms[0].pageval.value = modid;
	document.forms[0].hidBeanId.value="dscr";
	document.forms[0].hidBeanGetMethod.value="getDataForDSCR";
	document.forms[0].action = appUrl+"action/DSCR.jsp";
	document.forms[0].submit();
}
function enableButtons(bool1,bool2,bool3,bool4,bool5)
{	
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;	  	
	document.forms[0].cmdclose.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdcomments.disabled=bool5;
}
function getdivval()
{
    document.forms[0].type1.value = document.forms[0].combo1.value;
	document.forms[0].type2.value = document.forms[0].combo2.value;
	document.forms[0].type3.value = document.forms[0].combo3.value;
	document.forms[0].type4.value = document.forms[0].combo4.value;
	document.forms[0].type5.value = document.forms[0].combo5.value;
	
	document.forms[0].hidBeanId.value="dscr";
	document.forms[0].hidBeanGetMethod.value="getDataForDSCR";
	document.forms[0].action = appUrl+"action/DSCR.jsp";
	document.forms[0].submit();
}
function getInitial()
{
	page="<%=pageval%>";
	document.forms[0].hidBeanId.value="dscr";
	document.forms[0].hidBeanGetMethod.value="getDataForDSCR";
	document.forms[0].action = appUrl+"action/DSCR.jsp";
	document.forms[0].submit();
}
function callAssessment()
{
	document.forms[0].hidBeanId.value="combobassessment";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].action = appUrl+"action/bobassessment.jsp";
	document.forms[0].submit();
}

//Help function added by vino
var strvalue="corp_financial.htm";
function doPrint()
{
	appno = document.forms[0].appno.value;
	if (document.forms[0].identity.value == "")
	{
		upto = "<%=Integer.parseInt(upto)%>";
		page="DSCR";
		totcount="<%=totcount%>";
		var startfrom = totcount/4;
		
		startfrom = Math.floor(startfrom);
		if (upto == totcount && totcount <= 5)
		{
			from = 1;
		}
		else if(eval(upto % 5)==0) 
		{	
			
			from = upto - 4;
		}
		else if(eval(upto % 5)!=0)
		{
			from = (upto - 5);
			if(from < 5)
			{
				from = from + (5 - from)+1;
			}
			else if(from > 5 && upto == totcount)
			{
				from = (totcount - 1)+1;
			}
			else if(from > 5 && upto < totcount)
			{
				from = (upto - 5)+1;
			}
		}
		var purl = appUrl+"action/com_dscr_print.jsp?pageval="+page+"&from="+from+"&hidBeanGetMethod=getPrintValues&hidBeanId=dscr&appno="+appno;
		prop = "scrollbars=yes,width=700,height=450,statusbar=yes,menubar=yes";	
		xpos = (screen.width - 700) / 2;
		ypos = (screen.height - 650) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		var title = "Print";
	}
	else
	{
		page="<%=pageval%>";
		txtyear1=document.forms[0].txtyear1.value;
		txtyear2=document.forms[0].txtyear2.value;
		txtyear3=document.forms[0].txtyear3.value;
		combo1=document.forms[0].combo1.value;
		combo2=document.forms[0].combo2.value;
		combo3=document.forms[0].combo3.value;
		var purl = appUrl+"action/com_finprint.jsp?pageval="+page+"&hidBeanGetMethod=getDataList&hidBeanId=dscr&appno="+appno+"&txtyear1="+txtyear1+"&txtyear2="+txtyear2+"&txtyear3="+txtyear3+"&combo1="+combo1+"&combo2="+combo2+"&combo3="+combo3;
		prop = "scrollbars=yes,width=700,height=550,statusbar=yes";	
		xpos = (screen.width - 700) / 2;
		ypos = (screen.height - 550) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		var title = "Print";
	}
	window.open(purl,title,prop);
}
function doComments()
{
	var strAppno =appno;
	var pagetype = document.forms[0].hidCommentPage.value;
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/com_comments.jsp?hidBeanId=comproposal&hidBeanGetMethod=getDataComments&pagetype="+pagetype+"&strAppno="+strAppno;
	window.open(url,"Comments",prop);
}
</script>
<script language="JavaScript">
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);
// -->
</script>
</head>
<body onLoad="comboselect();placeValues();checkDesc()">
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
<form method="post" class="normal">
<%if(strSessionModuleType.equalsIgnoreCase("AGR")||strSessionModuleType.equalsIgnoreCase("CORP")){ %>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
			<td valign="top" colSpan="5">
              <jsp:include page="../com/proposallinks.jsp" flush="true"> 
              <jsp:param name="pageid" value="41" />
			   <jsp:param name="cattype" value="<%=strCategoryType%>" />
			  <jsp:param name="ssitype" value="<%=strSSIType%>" />			
              </jsp:include>
            </td>
          </tr>
          <tr>
          	<td class="page_flow">
          		Home -&gt; Corporate &amp; SME -&gt; Proposal -&gt; Financial Analysis -&gt; Assessment -&gt; DSCR
      			<span style="display:none"><lapschoice:borrowertype /></span> 
      			<lapschoice:application/>
          	</td>
          </tr>
  </table>	
		 <jsp:include page="../com/com_commentstab.jsp" flush="true">
						<jsp:param name="tabid" value="7" />
					</jsp:include>	

<table border="0" cellspacing="2" cellpadding="3" class="outertable" width="60%">
		<tr align="center">
				
					<td width="15%" nowrap align="center"   class="sub_tab_active"> <b> DSCR </b> </td>
					
					<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'dscr','getDataForDSCRSensitivitydata','Sensitivitydscr.jsp')">Sensitivity Analysis</a></b></td>
				
		</tr>
</table>
	<%}else{ %>	
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/Applurllinkper.jsp" flush="true">
			<jsp:param name="pageid" value="8" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
      <td class="page_flow">Home -> Retail -> Application -> Agriculture -> DSCR</td>
	</tr>
</table>
<span style="display:none;"> <lapschoice:borrowertype /> </span> <lapschoice:application />
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="7" />
		</jsp:include></td>
	</tr>
</table>
	<%} %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable linebor">
				<tr class="dataheader"><td align="right" colspan="7"><b>All Values are in <%=Helper.correctNull((String)hshValues.get("strValuesin")) %></b></td></tr>
					<tr class="dataheader">
						<td colspan="2" align="center"><b>Particulars</b></td>
						<td width="14%" align="center"><input type="text" name="txtyear1"
							size="13" maxlength="12"  border="1"
							 value="<%=strYear1%>"
							onBlur="checkDate(txtyear1)" readOnly="readonly"> <a
							alt="Select date from calender"
							href="javascript:callCalender('txtyear1')"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a>
							<input type="hidden" name="hidyear1" value="<%=strYear1 %>">
							<input type="hidden" name="hidtype1" value="">
							</td>
						<td width="13%" align="center"><input type="text" name="txtyear2"
							size="13" maxlength="12"  border="1"
							 value="<%=strYear2%>"
							onBlur="checkDate(txtyear2)" readOnly="readonly"> <a
							alt="Select date from calender"
							href="javascript:callCalender('txtyear2')"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a>
							<input type="hidden" name="hidyear2" value="<%=strYear2 %>">
							<input type="hidden" name="hidtype2" value="">
							</td>
						<td width="14%" align="center"><input type="text" name="txtyear3"
							size="13" maxlength="12"  border="1"
							 value="<%=strYear3%>"
							onBlur="checkDate(txtyear3)" readOnly="readonly"> <a
							alt="Select date from calender"
							href="javascript:callCalender('txtyear3')"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a>
							<input type="hidden" name="hidyear3" value="<%=strYear3 %>">
							<input type="hidden" name="hidtype3" value="">
							</td>
						<td width="14%" align="center"><input type="text" name="txtyear4"
							size="13" maxlength="12"  border="1"
							 value="<%=strYear4%>"
							onBlur="checkDate(txtyear4)" readOnly="readonly"> <a
							alt="Select date from calender"
							href="javascript:callCalender('txtyear4')"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a>
							<input type="hidden" name="hidyear4" value="<%=strYear4 %>">
							<input type="hidden" name="hidtype4" value="">
							</td>
						<td width="13%" align="center"><input type="text" name="txtyear5"
							size="13" maxlength="12" style=" border-style=groove" border="1"
							 value="<%=strYear5%>"
							onBlur="checkDate(txtyear5)" readOnly="readonly"> <a
							alt="Select date from calender"
							href="javascript:callCalender('txtyear5')"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a>
							<input type="hidden" name="hidyear5" value="<%=strYear5 %>">
							<input type="hidden" name="hidtype5" value="">
							</td>						
					</tr>
					<tr class="dataheader">
						<td colspan="2">&nbsp;</td>
						<td width="14%" align="center"><select name="combo1">
							<option value="S" selected="selected">--Select--</option>
							<option value="a">Audited</option>
							<option value="e">Estimated</option>
							<option value="u">Unaudited/Provisional</option>
							<option value="p">Projection</option>
						</select></td>
						<td width="13%" align="center"><select name="combo2">
							<option value="S" selected="selected">--Select--</option>
							<option value="a">Audited</option>
							<option value="e">Estimated</option>
							<option value="u">Unaudited/Provisional</option>
							<option value="p">Projection</option>
						</select></td>
						<td width="14%" align="center"><select name="combo3">
							<option value="S" selected="selected">--Select--</option>
							<option value="a">Audited</option>
							<option value="e">Estimated</option>
							<option value="u">Unaudited/Provisional</option>
							<option value="p">Projection</option>
						</select></td>
						<td width="14%" align="center"><select name="combo4">
							<option value="S" selected="selected">--Select--</option>
							<option value="a">Audited</option>
							<option value="e">Estimated</option>
							<option value="u">Unaudited/Provisional</option>
							<option value="p">Projection</option>
						</select></td>

						<td width="13%" align="center"><select name="combo5">
							<option value="S" selected="selected">--Select--</option>
							<option value="a">Audited</option>
							<option value="e">Estimated</option>
							<option value="u">Unaudited/Provisional</option>
							<option value="p">Projection</option>
						</select></td>
					</tr>
					<tr class="datagrid">
						<td colspan="2">&nbsp;<span class="mantatory"><b>For Deleting F.Y. click
						in the box and press delete button</b></span></td>
						<td width="14%" align="center"><input type="checkbox" name="chk1"
							value="y1" style="border-style:none"></td>
						<td width="13%" align="center"><input type="checkbox" name="chk2"
							value="y2" style="border-style:none"></td>
						<td width="14%" align="center"><input type="checkbox" name="chk3"
							value="y3" style="border-style:none"></td>
						<td width="14%" align="center"><input type="checkbox" name="chk4"
							value="y4" style="border-style:none"></td>
						<td width="13%" align="center"><input type="checkbox" name="chk5"
							value="y5" style="border-style:none"></td>
					</tr>
					<%ArrayList v = (ArrayList) hshValues.get("labeldetails");
			String col1 = "", col2 = "", col3 = "", col4 = "", col5 = "";
			String  colval1 = "";
			String colval2 = "", colval3 = "", colval4 = "", colval5 = "", strtype = "", selectdesc = "";
			int vecsize = 0,  yearsize = 0, finsize = 0, startsize = 0;
			String colid = "", rowid = "";
			if (v != null) {
				vecsize = v.size();
			}
			if (year1 != null) {
				yearsize = year1.size();
			}
			if (yearsize == vecsize) {
				finsize = vecsize;
			} else if (yearsize < vecsize) {
				finsize = yearsize;
			}
			if (finsize == 0) {
				finsize = vecsize;
			}
			for (int l = 0; l < finsize; l++) {
				g1 = (ArrayList) v.get(l);
				colid = Helper.correctNull((String) g1.get(0));
				colid = colid.trim();
				if (year1 != null) {
					rowid = Helper.correctDouble((String) vecid1.get(l));
					rowid = rowid.trim();
					if (rowid.equals(colid)) {
						colval1 = nf.format(Double.parseDouble(Helper.correctDouble((String) year1.get(l))));
					} else {
						colval1 = "0.00";
					}
				} else {
					colval1 = "0.00";
				}
				if (year2 != null) {
					rowid = Helper.correctDouble((String) vecid2.get(l));
					if (rowid.equals(colid)) {
						colval2 = nf.format(Double.parseDouble(Helper.correctDouble((String) year2.get(l))));
					} else {
						colval2 = "0.00";
					}
				} else {
					colval2 = "0.00";
				}
				if (year3 != null) {
					rowid = Helper.correctDouble((String) vecid3.get(l));
					if (rowid.equals(colid)) {
						colval3 = nf.format(Double.parseDouble(Helper.correctDouble((String) year3.get(l))));
					} else {
						colval3 = "0.00";
					}
				} else {
					colval3 = "0.00";
				}
				if (year4 != null) {
					rowid = Helper.correctDouble((String) vecid4.get(l));
					if (rowid.equals(colid)) {
						colval4 = nf.format(Double.parseDouble(Helper.correctDouble((String) year4.get(l))));
					} else {
						colval4 = "0.00";
					}
				} else {
					colval4 = "0.00";
				}
				if (year5 != null) {
					rowid = Helper.correctDouble((String) vecid5.get(l));
					if (rowid.equals(colid)) {
						colval5 = nf.format(Double.parseDouble(Helper.correctDouble((String) year5.get(l))));
					} else {
						colval5 = "0.00";
					}
				} else {
					colval5 = "0.00";
				}
				col1 = "row" + Helper.correctNull((String) g1.get(0)) + "c1";
				col2 = "row" + Helper.correctNull((String) g1.get(0)) + "c2";
				col3 = "row" + Helper.correctNull((String) g1.get(0)) + "c3";
				col4 = "row" + Helper.correctNull((String) g1.get(0)) + "c4";
				col5 = "row" + Helper.correctNull((String) g1.get(0)) + "c5";
				selectdesc = "desc" + Helper.correctNull((String) g1.get(0));
				strtype = Helper.correctNull((String) g1.get(2));%>
					<tr class="datagrid">
						<td width="3%" align="center">
						<input type="hidden" name="id" value="<%=Helper.correctNull((String)g1.get(0))%>"> 
						<input type="hidden" name="type" value="<%=Helper.correctNull((String)g1.get(2))%>"> 
						<%=Helper.correctNull((String) g1.get(3))%>&nbsp;
						</td>
						<td width="23%"><%if (strtype.trim().equals("I")) {%> 
						<input type="text" name="<%=selectdesc%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%= Helper.correctNull((String)g1.get(1))%>"> 
							<%} else {%>
						<div><b><font
							<%if (strtype.trim().equals("C") && !strtype.trim().equals("H") ) out.println("size=\"3\" color=\"blue\""); 
							else   out.println("size=\"1\"");%>><%=Helper.correctNull((String) g1.get(1))%></font></b></div><%}%>
							</td>
						<td width="14%" align="center">
						<%if (!strtype.trim().equals("C") && !strtype.trim().equals("H")) {%> 
						<input type="text" name="<%=col1%>" size="13" style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=colval1%>" onKeyPress="allowNegtiveNumber(this)"> 
							<%} else {%> 
							<input type="hidden" name="<%=col1%>" size="13" style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="0.00"> 
							<%if (!strtype.trim().equals("H")) {%>
						<div align="right" style="width:75">
						<b><font> <lapschoice:CurrencyTag name="calc1" size="13"
							style="color:#0000FF;border:none;font-color:#000000;text-align:right"
							value='<%=colval1%>' other="disabled" /> </font></b></div>
						<%}}%></td>
						<td width="13%" align="center">
						<%if (!strtype.trim().equals("C") && !strtype.trim().equals("H")) {%> 
						<input type="text" name="<%=col2%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=colval2%>"
							onKeyPress="allowNegtiveNumber(this)"> 
							<%} else {%> <input type="hidden" name="<%=col2%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="0.00"> 
							<%if (!strtype.trim().equals("H")) {%>
						<div align="right" style="width:75"><b><font> <lapschoice:CurrencyTag name="calc2" size="13"
							style="color:#000000;border:none;font-color:#000000;text-align:right"
							value='<%=colval2%>' other="disabled" /> </font></b></div>
						<%}}%></td>
						<td width="14%" align="center">
						<%if (!strtype.trim().equals("C") && !strtype.trim().equals("H")) {%> 
						<input type="text" name="<%=col3%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=colval3%>"
							onKeyPress="allowNegtiveNumber(this)"> 
							<%} else {%> 
							<input type="hidden" name="<%=col3%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="0.00"> <%if (!strtype.trim().equals("H")) {%>
						<div align="right" style="width:75"><b><font 
							> <lapschoice:CurrencyTag name="calc3" size="13"
							style="color:#000000;border:none;font-color:#000000;text-align:right"
							value='<%=colval3%>' other="disabled" /> </font></b></div>
						<%}}%></td>
						<td width="14%" align="center"><%if (!strtype.trim().equals("C") && !strtype.trim().equals("H")) {
					%> <input type="text" name="<%=col4%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=colval4%>" onKeyPress="allowNegtiveNumber(this)"> 
							<%} else {%> <input type="hidden" name="<%=col4%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="0.00"> <%if (!strtype.trim().equals("H")) {%>
						<div align="right" style="width:75"><b><font 
							> <lapschoice:CurrencyTag name="calc4" size="13"
							style="color:#000000;border:none;font-color:#000000;text-align:right"
							value='<%=colval4%>' other="disabled" /> </font></b></div>
						<%}}%></td>
						<td width="13%" align="center"><%if (!strtype.trim().equals("C") && !strtype.trim().equals("H")) {%> 
						<input type="text" name="<%=col5%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=colval5%>"
							onKeyPress="allowNegtiveNumber(this)"> 
							<%} else {%> <input type="hidden" name="<%=col5%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="0.00"> <%if (!strtype.trim().equals("H")) {%>
						<div align="right" style="width:75"><b><font 
							> <lapschoice:CurrencyTag name="calc5" size="13"
							style="color:#000000;border:none;font-color:#000000;text-align:right"
							value='<%=colval5%>' other="disabled" /> </font></b></div>
						<%}}%></td>
					</tr>
					<%}
			startsize = finsize;
			if (yearsize < vecsize) {
				for (int l = startsize; l < vecsize; l++) {
					g1 = (ArrayList) v.get(l);
					colval1 = "0.00";
					colval2 = "0.00";
					colval3 = "0.00";
					colval4 = "0.00";
					col1 = "row" + Helper.correctNull((String) g1.get(0)) + "c1";
					col2 = "row" + Helper.correctNull((String) g1.get(0)) + "c2";
					col3 = "row" + Helper.correctNull((String) g1.get(0)) + "c3";
					col4 = "row" + Helper.correctNull((String) g1.get(0)) + "c4";
					col5 = "row" + Helper.correctNull((String) g1.get(0)) + "c5";
					selectdesc = "desc" + Helper.correctNull((String) g1.get(0));
					strtype = Helper.correctNull((String) g1.get(2));%>
					<tr class="datagrid">
						<td width="3%" align="center">
						<input type="hidden" name="id" value="<%=Helper.correctNull((String)g1.get(0))%>"> 
						<input type="hidden" name="type" value="<%=Helper.correctNull((String)g1.get(2))%>">
						<%=Helper.correctNull((String) g1.get(3))%>&nbsp;
						</td>
						<td width="23%"><%if (strtype.trim().equals("I")) {%> 
						<input type="text" name="<%=selectdesc%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String)g1.get(1))%>"> 
							<%} else {%>
						<div><b><%=Helper.correctNull((String) g1.get(1))%></b></div>
						<%}%></td>
						<td width="14%" align="center">
						<%if (!strtype.trim().equals("C") && !strtype.trim().equals("H")) {%> 
						<input type="text" name="<%=col1%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=colval1%>"
							onKeyPress="allowNegtiveNumber(this)"> 
							<%} else {%> 
							<input type="hidden" name="<%=col1%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="0.00"> <%if (!strtype.trim().equals("H")) {%>
						<div align="right" style="width:75"><b><font 
							> <lapschoice:CurrencyTag name="calc1" size="13"
							style="color:#000000;border:none;font-color:#000000;text-align:right"
							value='<%=colval1%>' other="disabled" /></font></b></div>
						<%}}%></td>
						<td width="13%" align="center">
						<%if (!strtype.trim().equals("C") && !strtype.trim().equals("H")) {%> 
						<input type="text" name="<%=col2%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=colval2%>"
							onKeyPress="allowNegtiveNumber(this)"> 
							<%} else {%> <input type="hidden" name="<%=col2%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="0.00"> <%if (!strtype.trim().equals("H")) {%>
						<div align="right" style="width:75"><b><font 
							> <lapschoice:CurrencyTag name="calc2" size="13"
							style="color:#000000;border:none;font-color:#000000;text-align:right"
							value='<%=colval2%>' other="disabled" /> </font></b></div>
						<%}}%></td>
						<td width="14%" align="center">
						<%if (!strtype.trim().equals("C") && !strtype.trim().equals("H")) {%> 
						<input type="text" name="<%=col3%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=colval3%>"
							onKeyPress="allowNegtiveNumber(this)"> 
							<%} else {%> <input type="hidden" name="<%=col3%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="0.00"> <%if (!strtype.trim().equals("H")) {%>
						<div align="right" style="width:75"><b><font 
							> <lapschoice:CurrencyTag name="calc3" size="13"
							style="color:#000000;border:none;font-color:#000000;text-align:right"
							value='<%=colval3%>' other="disabled" /></font></b></div>
						<%}}%></td>
						<td width="14%" align="center">
						<%if (!strtype.trim().equals("C") && !strtype.trim().equals("H")) {%> 
						<input type="text" name="<%=col4%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=colval4%>"
							onKeyPress="allowNegtiveNumber(this)"> 
							<%} else {%> <input type="hidden" name="<%=col4%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="0.00"> <%if (!strtype.trim().equals("H")) {%>
						<div align="right" style="width:75"><b><font 
							> <lapschoice:CurrencyTag name="calc4" size="13"
							style="color:#000000;border:none;font-color:#000000;text-align:right"
							value='<%=colval4%>' other="disabled" /></font></b></div>
						<%}}%></td>
						<td width="13%" align="center">
						<%if (!strtype.trim().equals("C") && !strtype.trim().equals("H")) {%> 
						<input type="text" name="<%=col5%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=colval5%>"
							onKeyPress="allowNegtiveNumber(this)"> <%} else {%> 
							<input type="hidden" name="<%=col5%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="0.00"> <%if (!strtype.trim().equals("H")) {%>
						<div align="right" style="width:75"><b><font 
							> <lapschoice:CurrencyTag name="calc5" size="13"
							style="color:#000000;border:none;font-color:#000000;text-align:right"
							value='<%=colval5%>' other="disabled" /> </font></b></div>
						<%}}%></td>
					</tr>
					<%}}%>
					<tr class="datagrid">
						<td>&nbsp;
						</td>
						<td>
						Average DSCR
						</td>
						<td  align="center">
						<input type="text" name="DscrAvg" value="" size="13" style="text-align: right;border:none" disabled="disabled"/>
						</td>
						<td colspan="4">&nbsp;
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
<table border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
			<tr>
				<td> <%if ((Integer.parseInt(totcount) >= 5) && (Integer.parseInt(fromnext) != 1)) {

			%> &lt;&lt; <a href="javascript:shownext('p')"><b>Previous</b></a>
				<%}  %></td><td> &nbsp;&nbsp;</td>
			<td align="center"><input type="button" name="cmdadd" value="Add"
										class="buttonStyle" onClick="shownext('a')"></td> <td>&nbsp;&nbsp;</td>
				<td align="right">&nbsp; <%int y1 = Integer.parseInt(totcount);

			if ((y1 > 5) && (Integer.parseInt(upto) != y1)) {

			%> <a href="javascript:shownext('n')"><b>Next</b></a>&gt;&gt; <%}  %>
			</td>
			</tr>			
		</table>
		<table border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
			<tr>
			<td align="center"><br>
			<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Comments_Calculate_Print" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
			</td>
			</tr>			
		</table>
<input type="hidden" name="totvalue" value="<%=totcount%>"> 
<input type="hidden" name="uptovalue" value="<%=upto%>"> 
<input type="hidden" name="fromvalue" value="<%=Integer.parseInt(upto) + 1%>"> 
<INPUT TYPE="hidden"  name="pageval" value="DSCR"> 
<INPUT TYPE="hidden" value="10" name="hidTotal"> 
<input type="hidden" name="otherGenTable"> 
<input type="hidden" name="hidPageName" value="DSCR.jsp"> 
<INPUT TYPE="hidden" name="hidAudit" value="<%=Helper.correctNull((String)hshValues.get("oldVal"))%>"> 
<input type="hidden" name="type1"> 
<input type="hidden" name="type2"> 
<input type="hidden" name="type3"> 
<input type="hidden" name="type4"> 
<input type="hidden" name="type5"> 
<INPUT TYPE="hidden" NAME="hidsel_divID"> 
<input type="hidden" name="p_checkflag" value=""> 
<input type="hidden" name="BaseYearFlag" value="false"> 
<input type="hidden" name="cattype" value="<%=strCategoryType%>"> 
<INPUT TYPE="hidden" name="fromnext" value="<%=Helper.correctNull((String)hshValues.get("from"))%>">
<input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
<INPUT TYPE="hidden" value = "<%=identity%>" name="identity">
<input type="hidden" name="pagefrom">
<INPUT TYPE="hidden" name="strAssessment" value = "<%=request.getParameter("strAssessment")%>">
<input type="hidden" name="hidCommentPage" value="assdscr">
<lapschoice:hiddentag pageid="<%=PageId%>"/>
</form>
</body>

<script>
	var tagFlag="<%=tagFlag%>";
	var strCurModule ="<%=strCurModule%>";

	function disableFields(val)
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
			else if(document.forms[0].elements[i].type=="select-one")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
		}

	//added for disabling the textbox and combo box
	if(tagFlag == strCurModule)
	{		
		document.forms[0].txtyear1.readOnly = false;
		document.forms[0].txtyear2.readOnly = false;
		document.forms[0].txtyear3.readOnly = false;
		document.forms[0].txtyear4.readOnly = false;
		document.forms[0].txtyear5.readOnly = false;
		document.forms[0].combo1.disabled=false;
		document.forms[0].combo3.disabled=false;
		document.forms[0].combo2.disabled=false;
		document.forms[0].combo4.disabled=false;
		document.forms[0].combo5.disabled=false;
	}
	else
	{
//		document.forms[0].fromvalue.value ="0";
		//document.forms[0].txtyear1.readOnly = true;
		//document.forms[0].txtyear2.readOnly = true;
		//document.forms[0].txtyear3.readOnly = true;
		//document.forms[0].txtyear4.readOnly = true;
		//document.forms[0].txtyear5.readOnly = true;
		document.forms[0].combo1.disabled=true;
		document.forms[0].combo3.disabled=true;
		document.forms[0].combo2.disabled=true;
		document.forms[0].combo4.disabled=true;
		document.forms[0].combo5.disabled=true;
	}

	}

	</script>
</html>

