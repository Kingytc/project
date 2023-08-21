<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
			}
			ArrayList vecid1 = (ArrayList) hshValues.get("vecid1");
			ArrayList vecid2 = (ArrayList) hshValues.get("vecid2");
			ArrayList vecid3 = (ArrayList) hshValues.get("vecid3");
			ArrayList vecid4 = (ArrayList) hshValues.get("vecid4");
			ArrayList vecPercent=(ArrayList)hshValues.get("vecPercent1");
			String bgclr = "";
			String tagFlag = "";
            String COM_ASSESSMENTTYPE=Helper.correctNull((String)session.getAttribute("COM_ASSESSMENTTYPE"));
			int p = 0, sizeyear = 0, from = 0, to = 0, vecModSize = 0;
			String temp = "", totcount = "", upto = "", pageval = "", strCurModule = "", identity = "", fromnext = "";
    		totcount = Helper.correctNull((String) hshValues.get("totalyear"));
    		upto = Helper.correctNull((String) hshValues.get("upto"));
			fromnext = Helper.correctNull((String) hshValues.get("from"));
			pageval = Helper.correctNull((String) hshValues.get("page"));
			identity = Helper.correctNull((String) hshValues.get("identity"));
			java.text.NumberFormat nf=java.text.NumberFormat.getInstance();
			nf.setMaximumFractionDigits(2);
			nf.setMinimumFractionDigits(2);
			nf.setGroupingUsed(false);
			strCurModule = pageval;

			ArrayList g1 = new ArrayList();
			ArrayList g2 = new ArrayList();
			ArrayList g3 = new ArrayList();
			ArrayList year1 = new ArrayList();
			ArrayList year2 = new ArrayList();
			ArrayList year3 = new ArrayList();
			ArrayList year4 = new ArrayList();
			ArrayList finyear1 = new ArrayList();
			ArrayList finyear2 = new ArrayList();
			ArrayList finyear3 = new ArrayList();
			ArrayList finyear4 = new ArrayList();
			g2 = (ArrayList) hshValues.get("yearvalue");
			g3 = (ArrayList) hshValues.get("value");
			year1 = (ArrayList) hshValues.get("year1");
			year2 = (ArrayList) hshValues.get("year2");
			year3 = (ArrayList) hshValues.get("year3");
			year4 = (ArrayList) hshValues.get("year4");
			finyear1 = (ArrayList) hshValues.get("finyear1");
			finyear2 = (ArrayList) hshValues.get("finyear2");
			finyear3 = (ArrayList) hshValues.get("finyear3");
			finyear4 = (ArrayList) hshValues.get("finyear4");
			ArrayList vecModule = (ArrayList) hshValues.get("tabdetails");
			if (vecModule != null) {
				vecModSize = vecModule.size();
			}
			String yearval[] = new String[5];
			String comboselect[] = new String[5];
			int y = 0, n = 0;
			if (g2.size() != 0) {
				sizeyear = g2.size();
				for (int k = 0; k <= g2.size() - 1; k++) {
					if ((k % 2) == 0) {
						temp = Helper.correctNull((String) g2.get(k));
						yearval[y] = temp;
						y = y + 1;
					} else if ((k % 2) == 1) {
						temp = Helper.correctNull((String) g2.get(k));
						 if (temp.trim().equals("fin_projection")) {
							temp = "p";
						}else if (temp.trim().equals("fin_stress_projection")) {
							temp = "p";
						}						
						comboselect[n] = temp;
						n = n + 1;
					}
				}
				for (int d = 0; d <= 3; d++) {
					if (comboselect[d] == null) {
						comboselect[d] = "S";
					}
					if (yearval[d] == null) {
						yearval[d] = "";
					}
				}
			} else {
				for (p = 0; p <= 3; p++) {
					comboselect[p] = "S";
					yearval[p] = "";
				}
			}
			String strFinType1 = Helper.correctNull((String) comboselect[0]);
			String strFinType2 = Helper.correctNull((String) comboselect[1]);
			String strFinType3 = Helper.correctNull((String) comboselect[2]);
			String strFinType4 = Helper.correctNull((String) comboselect[3]);

			String strYear1 = Helper.correctNull((String) yearval[0]);
			String strYear2 = Helper.correctNull((String) yearval[1]);
			String strYear3 = Helper.correctNull((String) yearval[2]);
			String strYear4 = Helper.correctNull((String) yearval[3]);			

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
			ArrayList v = (ArrayList) hshValues.get("labeldetails");
			String col1 = "", col2 = "", col3 = "", col4 = "", col5 = "";
			String finval = "", colval1 = "";
			String colval2 = "", colval3 = "", colval4 = "", colval5 = "", strtype = "", selectdesc = "";
			int vecsize = 0, count = 1, yearsize = 0, finsize = 0, startsize = 0;
			String colid = "", rowid = "",rowpercent="";
			
			String fincolval1 = "", fincolval2 = "", fincolval3 = "", fincolval4 ="";
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
			}%>
<html>
<head>
<title>Financial</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/com/finmain.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>ckeditor/ckeditor.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>	
<Script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
 var varAction="<%=Helper.correctNull((String)hshValues.get("strAction"))%>";	
 var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
 var appno="<%=request.getParameter("appno")%>";
var varBaseYear="<%=Helper.correctNull((String)hshValues.get("com_baseyear"))%>";
var varYear1="<%=strYear1%>";	
var varYear2="<%=strYear2%>";
var varYear3="<%=strYear3%>";
var varYear4="<%=strYear4%>";
function callCalender(fname)
{
	 showCal("<%=ApplicationParams.getAppUrl()%>",fname);
}
function comboselect()
{
			document.forms[0].combo1.value ="<%=strFinType1.trim()%>";
			document.forms[0].combo2.value ="<%=strFinType2%>";
			document.forms[0].combo3.value ="<%=strFinType3%>";
			document.forms[0].combo4.value ="<%=strFinType4%>";
}
function shownext(val)
{
	upto = <%=Integer.parseInt(upto)%>;
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
			from = fromnext - 4;
	}	
	document.forms[0].action=appURL+"action/com_dynamicstresscashflow.jsp?page="+page+"&from="+from;
	document.forms[0].hidBeanGetMethod.value="getSensitiveData";
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].submit();
}
function placeValues()
{
			disableFields(true);
			document.forms[0].combo1.disabled=true;
			document.forms[0].combo3.disabled=true;
			document.forms[0].combo2.disabled=true;
			document.forms[0].combo4.disabled=true;
			EditorEnableDisable("id_div","block","id_editor","none");
			if(appstatus=="Processed/Rejected" || appstatus=="Processed/Approved" || appstatus=="Closed/Approved" || appstatus=="Closed/Rejected")	 
		  		{
		  		//	enableButtons(true,true,true,false);
		  		//	document.forms[0].cmddelete.disabled=true;
		  			document.forms[0].cmdcalculate.disabled=true;
		  		}
		  		else
		  		{
		  		//  enableButtons(false,true,true,false);		  			
				}
}
function doEdit()
{
	disableFields(false);
	enableButtons(true,false,false,false,true,false)
	EditorEnableDisable("id_div","none","id_editor","block");
	editor_generate('txt_sensitivecomments');
}
function doDelete()
{
	var frm=document.forms[0];
	
	if(frm.chk1.checked==false && frm.chk2.checked==false && frm.chk3.checked==false && frm.chk4.checked==false)
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

			document.forms[0].hidAction.value="delete"
			document.forms[0].hidBeanId.value="financial"
			document.forms[0].hidBeanMethod.value="deleteData";
			document.forms[0].hidBeanGetMethod.value="getData";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].hidSourceUrl.value="/action/financial.jsp";
			document.forms[0].submit();
		 }
	}
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
    var pageval=document.forms[0].pageval.value;
	var xmlHttp;
	var uri;
	xmlHttp=GetXmlHttpObject();
	if(xmlHttp==null)
	{
		alert("Browser Do Not Support Using Ajax....");
	}
	uri=appURL+"action/iframfinancial.jsp?hidBeanGetMethod=updateSensitiveFinancialData&hidBeanId=financial&appno="+appno+"&pageval="+pageval+"&from="+from;
	uri = uri +"&sid="+Math.random();
	xmlHttp.onreadystatechange=loadCalculatedValues;
	xmlHttp.open("GET",uri,true);
	xmlHttp.send(null);
	document.getElementById("progress").style.visibility="visible";
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
		    temp1=chkVal[i];
		    var temp2=temp1.split(',');
		    
		    if(temp2.length==2)
		     {
		     for(var j1=0;j1<(temp2.length-1);j1++)
		     {
		      var k = i+1;
		      document.forms[0].elements["calc"+k].value= temp2[j1];
		      }
		     }
		     else{
		       for(var j1=0;j1<(temp2.length-1);j1++)
		       {
		        var k = i+1;
		        document.forms[0].elements["calc"+k][j1].value= temp2[j1];
		       }
		     }
		}
		document.getElementById("progress").style.visibility="hidden";
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
	
  		disableFields(false);
		document.forms[0].combo1.disabled=false;
		document.forms[0].combo3.disabled=false;
		document.forms[0].combo2.disabled=false;
		document.forms[0].combo4.disabled=false;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].hidAction.value="update"
		document.forms[0].hidBeanId.value="financial"
		document.forms[0].hidBeanMethod.value="updateSensitiveData";
		document.forms[0].hidBeanGetMethod.value="getSensitiveData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_dynamicstresscashflow.jsp?from="+from;
		document.forms[0].submit();	
}

function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="financial"
		document.forms[0].hidBeanGetMethod.value="getSensitiveData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_dynamicstresscashflow.jsp";
		document.forms[0].submit();
	 }	
}
function callCashFlow(page,flowtype)
{	
	if(flowtype=="CA")
	{
		 document.forms[0].flowtype.value="CA";
		 document.forms[0].yearfrom.value="1";
		 document.forms[0].action = appUrl+"action/"+page;
	     document.forms[0].hidBeanId.value="comformula";
	     document.forms[0].hidBeanGetMethod.value="GetCashFlowData";	
	     document.forms[0].submit();	 
	}
	else if (flowtype=="SA")
	{
		document.forms[0].flowtype.value="SA";
		document.forms[0].action = appUrl+"action/"+page;
	    document.forms[0].hidBeanId.value="financial";
	    document.forms[0].hidBeanGetMethod.value="getSensitiveData";	
	    document.forms[0].submit();	 
	}
	else
	{
        document.forms[0].flowtype.value="FU";
		document.forms[0].yearfrom.value="1";
		document.forms[0].action = appUrl+"action/"+page;
	    document.forms[0].hidBeanId.value="comformula";
	    document.forms[0].hidBeanGetMethod.value="GetCashFlowData";	
	    document.forms[0].submit();	 
	}	
}
function callBenchMark()
{
    document.forms[0].hidBeanId.value="financial";
	document.forms[0].hidBeanGetMethod.value="getBenchMarkParam";
	document.forms[0].action = appUrl+"action/com_benchmarkparam.jsp";
	document.forms[0].submit();
}
function callAssessment()
{
	document.forms[0].hidBeanId.value="combobassessment";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].action = appUrl+"action/bobassessment.jsp?pageval=MPBF1";
	document.forms[0].submit();
}
function ratinganalysis()
{
	document.forms[0].hidBeanId.value="comratingana";
	document.forms[0].hidBeanGetMethod.value = "";
	document.forms[0].access.value = "B";
	document.forms[0].action=appUrl+"action/comratinganalysis.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}

function ratingmodel()
{
	document.forms[0].hidBeanId.value="comratingana";
	document.forms[0].hidBeanGetMethod.value = "getRatingModel";
	document.forms[0].action=appUrl+"action/comratingmodel.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}

function callLink12(page,method)
{	
	
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].action=appUrl+"action/"+page+"?pageval=RA";
	document.forms[0].submit();	 
}

function callLinkCAN(page,method)
{	
	
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].action=appUrl+"action/"+page+"?pageval=CAN";
	document.forms[0].submit();	 
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

	document.forms[0].pageval.value = modid;
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].action = appUrl+"action/financial.jsp";
	document.forms[0].submit();
}
function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
	document.forms[0].cmdcomments.disabled=bool6;
}
function callSensitive(value,name)
{
for(var i=1;i< 5;i++)
 {
     if(value=="")
     {
      alert("Enter Stress %");
      return;
     }      
     var val= document.forms[0].elements["fin"+name+"c"+i].value    
     var result=eval(val)+(eval(val)*eval(value)/100)
     document.forms[0].elements[name+"c"+i].value=result;
 }
}
function gototab(beanid,methodname,pagename,flowtype)
{
	document.forms[0].hidBeanId.value=beanid;
	document.forms[0].hidBeanGetMethod.value=methodname;
	document.forms[0].flowtype.value=flowtype;
	document.forms[0].action=appURL+"action/"+pagename;
	document.forms[0].submit();
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
</head>
<body onLoad="comboselect();placeValues();">
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
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td valign="top">
		<jsp:include page="../com/proposallinks.jsp" flush="true">
			<jsp:param name="pageid" value="41" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />			
		</jsp:include></td>
	</tr>
</table>
<input type="hidden" name="flowtype">
<div id="progress"
	style="position:absolute; width:106px; visibility:hidden; height:19px; z-index:1; left: 521px; top: 300px">
<img src="<%=ApplicationParams.getAppUrl()%>img/finloader.gif"></div>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="page_flow">Home -&gt; Corporate & SME -&gt; Proposal -&gt; Assessment -&gt; Sensitivity Analysis
		<span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application />
		</td>
	</tr>
</table>
 <jsp:include
	page="../com/com_commentstab.jsp" flush="true">
	<jsp:param name="tabid" value="33" />
</jsp:include>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td>
				<table width="100%" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td><%boolean base_year = false;
			int strWidth;
			int tabWidth;
			int tableWidth;
			strWidth = vecModSize;
			if (strWidth == 1) {
				tableWidth = 15;
			} else if (strWidth == 2) {
				tableWidth = 30;
			} else {
				tableWidth = 60;
			}%>
						<table border="0" cellspacing="2" cellpadding="2" width="100%" class="outertable">
							<tr>
								<%for (int i = 0; i < vecModSize; i++) {
				ArrayList vecVal = (ArrayList) vecModule.get(i);%>
								<td
									<%if(i==0)
					{
						tagFlag = Helper.correctNull((String)vecVal.get(0));
					}
				   String str1=Helper.correctNull((String)vecVal.get(0));					
				   String strClass;				  
     	 		 if(strWidth == 1)
				{
				tabWidth = 5;
				}
				else if(strWidth == 2)
				{
				tabWidth = 20;
				}
				else
				{
				   tabWidth=80/strWidth;
				}

				if(i==0 && strCurModule.trim().equals(""))
				{
					str1="";
				}
				   if(str1.equals(strCurModule))
				   {
				   strClass="whitefont";
				    bgclr="#71694F"; %>
									<%
				  }
				  else
				  {
				  strClass="blackfont";
				   bgclr="#EEEAE3";
				  %>
									<%
				   }
				  %> width="<%=tabWidth%>%" align="center"
									bgcolor="<%=bgclr%>"><%if (str1.equals(strCurModule)) {

					%> <b class="<%=strClass%>"><%=Helper.correctNull((String) vecVal.get(0))%></b>
								<%} else {

					%> <a
									href="javascript:getSection('<%=Helper.correctNull((String)vecVal.get(0))%>')"
									class="<%=strClass%>"><b><%=Helper.correctNull((String) vecVal.get(0))%></b></a>
								<%}

			%></td>
								<%}%>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable linebor" align="left">
					<tr class="dataheader">
						<td colspan="2" align="center"><b>Particulars</b></td>
						<td width="5%" align="center"><b>Stress (%)</b>&nbsp;</td>
						<td width="14%" align="center">&nbsp;</td>
						<td width="13%" align="center">&nbsp;</td>
						<td width="14%" align="center">&nbsp;</td>
						<td width="14%" align="center">&nbsp;</td>
					</tr>
					<tr class="dataheader">
						<td colspan="3">&nbsp;</td>
						<td width="14%" align="center"><input type="text" name="txtyear1"
							size="13" maxlength="12" style="border-style=groove" border="1"
							class="" value="<%=strYear1%>"
							onBlur="checkDate(txtyear1)" readOnly="readonly"></td>
						<td width="13%" align="center"><input type="text" name="txtyear2"
							size="13" maxlength="12" style="border-style=groove" border="1"
							class="" value="<%=strYear2%>"
							onBlur="checkDate(txtyear2)" readOnly="readonly"></td>
						<td width="14%" align="center"><input type="text" name="txtyear3"
							size="13" maxlength="12" style="border-style=groove" border="1"
							class="" value="<%=strYear3%>"
							onBlur="checkDate(txtyear3)" readOnly="readonly"></td>
						<td width="14%" align="center"><input type="text" name="txtyear4"
							size="13" maxlength="12" style=" border-style=groove" border="1"
							class="" value="<%=strYear4%>"
							onBlur="checkDate(txtyear4)" readOnly="readonly"></td>
					</tr>
					<tr class="dataheader">
						<td colspan="3">&nbsp;</td>
						<td width="14%" align="center"><select name="combo1">
							<option value="">--Select--</option>
							<option value="a">Audited</option>
							<option value="e">Estimated</option>
							<option value="u">Unaudited</option>
							<option value="p">Projection</option>
						</select></td>
						<td width="13%" align="center"><select name="combo2">
							<option value="">--Select--</option>
							<option value="a">Audited</option>
							<option value="e">Estimated</option>
							<option value="u">Unaudited</option>
							<option value="p">Projection</option>
						</select></td>
						<td width="14%" align="center"><select name="combo3">
							<option value="">--Select--</option>
							<option value="a">Audited</option>
							<option value="e">Estimated</option>
							<option value="u">Unaudited</option>
							<option value="p">Projection</option>
						</select></td>
						<td width="14%" align="center"><select name="combo4">
							<option value="">--Select--</option>
							<option value="a">Audited</option>
							<option value="e">Estimated</option>
							<option value="u">Unaudited</option>
							<option value="p">Projection</option>
						</select></td>
					</tr>
					<%			
			for (int l = 0; l < finsize; l++) {
				g1 = (ArrayList) v.get(l);

				colid = Helper.correctNull((String) g1.get(0));
				colid = colid.trim();

				if (year1 != null) {

					rowid = Helper.correctDouble((String) vecid1.get(l));
					rowid = rowid.trim();
					if (rowid.equals(colid)) {

						colval1 = Helper.correctDouble((String) year1
								.get(l));
					} else {
						colval1 = "0.00";
					}

				} else {
					colval1 = "0.00";
				}
				
				if (finyear1 != null) {

					rowid = Helper.correctDouble((String) vecid1.get(l));
					rowid = rowid.trim();
					if (rowid.equals(colid)) {

						fincolval1 = Helper.correctDouble((String)finyear1
								.get(l));
					} else {
						fincolval1 = "0.00";
					}
				} else {
					fincolval1 = "0.00";
				}
				if (year2 != null) {
					rowid = Helper.correctDouble((String) vecid2.get(l));
					if (rowid.equals(colid)) {
						colval2 = Helper.correctDouble((String) year2
								.get(l));
					} else {
						colval2 = "0.00";
					}
				} else {
					colval2 = "0.00";
				}				
				if (finyear2 != null) {
					rowid = Helper.correctDouble((String) vecid2.get(l));
					if (rowid.equals(colid)) {

						fincolval2 = Helper.correctDouble((String) finyear2.get(l));
					} else {
						fincolval2 = "0.00";
					}
				} else {
					fincolval2 = "0.00";
				}

				if (year3 != null) {
					rowid = Helper.correctDouble((String) vecid3.get(l));
					if (rowid.equals(colid)) {
						colval3 = Helper.correctDouble((String) year3.get(l));
					} else {
						colval3 = "0.00";
					}
				} else {
					colval3 = "0.00";
				}
				
				if (finyear3 != null) {
					rowid = Helper.correctDouble((String) vecid3.get(l));
					if (rowid.equals(colid)) {
						fincolval3 = Helper.correctDouble((String) finyear3.get(l));
					} else {
						fincolval3 = "0.00";
					}
				} else {
					fincolval3 = "0.00";
				}

				if (year4 != null) {
					rowid = Helper.correctDouble((String) vecid4.get(l));
					if (rowid.equals(colid)) {
						colval4 = Helper.correctDouble((String) year4.get(l));
					} else {
						colval4 = "0.00";
					}
				} else {
					colval4 = "0.00";
				}
				
				if (finyear4 != null) {
					rowid = Helper.correctDouble((String) vecid4.get(l));
					if (rowid.equals(colid)) {
						fincolval4 = Helper.correctDouble((String) finyear4.get(l));
					} else {
						fincolval4 = "0.00";
					}
				} else {
					fincolval4 = "0.00";
				}			
				col1 = "row" + Helper.correctNull((String) g1.get(0)) + "c1";
				col2 = "row" + Helper.correctNull((String) g1.get(0))	+ "c2";
				col3 = "row" + Helper.correctNull((String) g1.get(0))	+ "c3";
				col4 = "row" + Helper.correctNull((String) g1.get(0)) + "c4";			
				selectdesc = "desc"	+ Helper.correctNull((String) g1.get(0));
				strtype = Helper.correctNull((String) g1.get(2));%>
					<tr class="datagrid">
						<td width="3%" align="center"><input
							type="hidden" name="id"
							value="<%=Helper.correctNull((String)g1.get(0))%>"> <input
							type="hidden" name="type"
							value="<%=Helper.correctNull((String)g1.get(2))%>"> <font
							size="1" face="Tahoma" color="#FFFFFF"><%=Helper.correctNull((String) g1.get(3))%>&nbsp;</font>
						</td>
						<td width="23%"><%if (strtype.trim().equals("I")) {%> 
						<input type="text" name="<%=selectdesc%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12"
							value="<%=Helper.correctNull((String)g1.get(1))%>"> <%} else {%>
						<b><font
							<%if (strtype.trim().equals("C") && !strtype.trim().equals("H") ) out.println("size=\"2\" color=\"blue\""); else   out.println("size=\"1\"");%>
							face="Tahoma"><%=Helper.correctNull((String) g1
											.get(1))%></font></b>
						<%}%></td>
						<td width="5%" align="center"><%
						if (!strtype.trim().equals("C") && !strtype.trim().equals("H")) { 
						
						%> <INPUT TYPE="text" NAME="row<%=rowid %>" SIZE="13"
							STYLE="text-align:right;border-style=groove;color:blue"
							MAXLENGTH="12"
							VALUE="<%=Helper.correctDouble((String) vecPercent.get(l)) %>"
							ONKEYPRESS="allowNegtiveNumber(this)"
							onBlur="callSensitive(this.value,this.name)"> <%}else{
							%> <INPUT TYPE="hidden" NAME="row<%=rowid %>" SIZE="13"
							STYLE="text-align:right;border-style=groove;color:blue"
							MAXLENGTH="12"
							VALUE="<%=Helper.correctDouble((String) vecPercent.get(l))%>"
							ONKEYPRESS="allowNegtiveNumber(this)" onBlur=""> <%} %>&nbsp;</td>
						<td width="14%" align="center"><%if (!strtype.trim().equals("C") && !strtype.trim().equals("H")) {

					  %> <input type="text" name="<%=col1%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=colval1%>"
							onKeyPress="allowNegtiveNumber(this)"> <input
							type="hidden" name="fin<%=col1%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=fincolval1%>"
							onKeyPress="allowNegtiveNumber(this)"> <%} else {

					%> <input type="hidden" name="<%=col1%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="0.00"> <%if (!strtype.trim().equals("H")) { %>
						<div align="right" style="width:75"><b><font size="1"
							face="Tahoma"> <lapschoice:CurrencyTag name="calc1" size="13"
							style="color:#0000FF;border:none;font-color:#000000;text-align:right"
							value='<%=colval1%>' other="disabled" /> </font></b></div>
						<div align="right" style="width:75"><b><font size="1"
							face="Tahoma"> <input type="hidden" name="fincalc1"
							value='<%=fincolval1%>'> </font></b></div>
						<%}
				}

				%></td>
						<td width="13%" align="center"><%if (!strtype.trim().equals("C") && !strtype.trim().equals("H")) {

					%> <input type="text" name="<%=col2%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=colval2%>"
							onKeyPress="allowNegtiveNumber(this)"> <!-- old value --> <input
							type="hidden" name="fin<%=col2%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=fincolval2%>"
							onKeyPress="allowNegtiveNumber(this)"> <%} else {

					%> <input type="hidden" name="<%=col2%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="0.00"> <%if (!strtype.trim().equals("H")) {%>
						<div align="right" style="width:75"><b><font size="1"
							face="Tahoma"> <lapschoice:CurrencyTag name="calc2" size="13"
							style="color:#000000;border:none;font-color:#000000;text-align:right"
							value='<%=colval2%>' other="disabled" /> </font></b></div>
						<!-- old value -->
						<div align="right" style="width:75"><b><font size="1"
							face="Tahoma"> <input type="hidden" name="fincalc2"
							value='<%=fincolval2%>'> </font></b></div>
						<%}
				}

				%></td>
						<td width="14%" align="center"><%if (!strtype.trim().equals("C") && !strtype.trim().equals("H")) {

					%> <input type="text" name="<%=col3%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=colval3%>"
							onKeyPress="allowNegtiveNumber(this)"> <!-- old value --> <input
							type="hidden" name="fin<%=col3%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=fincolval3%>"
							onKeyPress="allowNegtiveNumber(this)"> <%} else {

					%> <input type="hidden" name="<%=col3%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="0.00"> <%if (!strtype.trim().equals("H")) {%>
						<div align="right" style="width:75"><b><font size="1"
							face="Tahoma"> <lapschoice:CurrencyTag name="calc3" size="13"
							style="color:#000000;border:none;font-color:#000000;text-align:right"
							value='<%=colval3%>' other="disabled" /> </font></b></div>
						<div align="right" style="width:75"><b><font size="1"
							face="Tahoma"><input type="hidden" name="fincalc3"
							value='<%=fincolval3%>'> </font></b></div>
						<%}
				}

				%></td>
						<td width="14%" align="center"><%if (!strtype.trim().equals("C") && !strtype.trim().equals("H")) {

					%> <input type="text" name="<%=col4%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=colval4%>"
							onKeyPress="allowNegtiveNumber(this)"> <!-- old value --> <input
							type="hidden" name="fin<%=col4%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=fincolval4%>"
							onKeyPress="allowNegtiveNumber(this)"> <%} else {

					%> <input type="hidden" name="<%=col4%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="0.00"> <%if (!strtype.trim().equals("H")) {%>
						<div align="right" style="width:75"><b><font size="1"
							face="Tahoma"> <lapschoice:CurrencyTag name="calc4" size="13"
							style="color:#000000;border:none;font-color:#000000;text-align:right"
							value='<%=colval4%>' other="disabled" /> </font></b></div>

						<!-- old value -->
						<div align="right" style="width:75"><b><font size="1"
							face="Tahoma"><input type="hidden" name="fincalc4"
							value='<%=fincolval4%>'> </font></b></div>
						<%}}%></td>
						
					</tr>
					<%}
			int endsize = 0;
			startsize = finsize;
			if (yearsize < vecsize) {			
				for (int l = startsize; l < vecsize; l++) {
					g1 = (ArrayList) v.get(l);
					colval1 = "0.00";
					colval2 = "0.00";
					colval3 = "0.00";
					colval4 = "0.00";
					
					fincolval1 = "0.00";
					fincolval2 = "0.00";
					fincolval3 = "0.00";
					fincolval4 = "0.00";
					col1 = "row" + Helper.correctNull((String) g1.get(0))
							+ "c1";
					col2 = "row" + Helper.correctNull((String) g1.get(0))
							+ "c2";
					col3 = "row" + Helper.correctNull((String) g1.get(0))
							+ "c3";
					col4 = "row" + Helper.correctNull((String) g1.get(0))
							+ "c4";
					
					selectdesc = "desc"
							+ Helper.correctNull((String) g1.get(0));
					strtype = Helper.correctNull((String) g1.get(2));

					%>
					<tr class="datagrid">
						<td width="3%" align="center"><input
							type="hidden" name="id"
							value="<%=Helper.correctNull((String)g1.get(0))%>"> <input
							type="hidden" name="type"
							value="<%=Helper.correctNull((String)g1.get(2))%>"> <font
							size="1" face="Tahoma" color="#FFFFFF"><%=Helper.correctNull((String) g1
											.get(3))%>&nbsp;</font></td>
						<td width="23%"><%if (strtype.trim().equals("I")) {

						%> <input type="text" name="<%=selectdesc%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12"
							value="<%=Helper.correctNull((String)g1.get(1))%>"> <%} else {

						%>
						<%=Helper.correctNull((String) g1.get(1))%>
						<%}

					%></td>
						<td width="5%" align="center"><%
						if (!strtype.trim().equals("C") && !strtype.trim().equals("H")) { 
							
						%> <INPUT TYPE="text" NAME="row<%=rowid %>" SIZE="13"
							STYLE="text-align:right;border-style=groove;color:blue"
							MAXLENGTH="12" VALUE="" ONKEYPRESS="allowNegtiveNumber(this)"
							onBlur="callSensitive(this.value,this.name)"> <%}else{ %> <INPUT
							TYPE="hidden" NAME="row<%=rowid %>" SIZE="13"
							STYLE="text-align:right;border-style=groove;color:blue"
							MAXLENGTH="12" VALUE="" ONKEYPRESS="allowNegtiveNumber(this)"
							onBlur=""> <%} %>&nbsp;</td>
						<!-- end -->
						<td width="14%" align="center"><%if (!strtype.trim().equals("C")
							&& !strtype.trim().equals("H")) {

						%> <!-- New value --> <input type="text" name="<%=col1%>"
							size="13" style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=colval1%>"
							onKeyPress="allowNegtiveNumber(this)"> <!-- Old value --> <input
							type="hidden" name="fin<%=col1%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=fincolval1%>"
							onKeyPress="allowNegtiveNumber(this)"> <%} else {

						%> <input type="hidden" name="<%=col1%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="0.00"> <%if (!strtype.trim().equals("H")) { %>
						<!-- New value -->
						<div align="right" style="width:75"><b><font size="1"
							face="Tahoma"> <lapschoice:CurrencyTag name="calc1" size="13"
							style="color:#000000;border:none;font-color:#000000;text-align:right"
							value='<%=colval1%>' other="disabled" /> </font></b></div>
						<!-- Old Value -->
						<div align="right" style="width:75"><input type="hidden" name="fincalc1"
							value='<%=fincolval1 %>'></div>

						<%}
					}

					%></td>
						<td width="13%" align="center"><%if (!strtype.trim().equals("C")
							&& !strtype.trim().equals("H")) {

						%> <!-- new value --> <input type="text" name="<%=col2%>"
							size="13" style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=colval2%>"
							onKeyPress="allowNegtiveNumber(this)"> <!-- Old value --> <input
							type="hidden" name="fin<%=col2%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=fincolval2%>"
							onKeyPress="allowNegtiveNumber(this)"> <%} else {

						%> <input type="hidden" name="<%=col2%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="0.00"> <%if (!strtype.trim().equals("H")) {%>
						<div align="right" style="width:75"><b> <lapschoice:CurrencyTag name="calc2" size="13"
							style="color:#000000;border:none;font-color:#000000;text-align:right"
							value='<%=colval2%>' other="disabled" /> </b></div>
						<!-- old value -->
						<div align="right" style="width:75"><b> <input type="hidden" name="fincalc2"
							value='<%=fincolval2%>'></b></div>
						<%}
					}

					%></td>
						<td width="14%" align="center"><%if (!strtype.trim().equals("C")
							&& !strtype.trim().equals("H")) {

						%> <input type="text" name="<%=col3%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=colval3%>"
							onKeyPress="allowNegtiveNumber(this)"> <!-- old value --> <input
							type="hidden" name="fin<%=col3%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=fincolval3%>"
							onKeyPress="allowNegtiveNumber(this)"> <%} else {

						%> <input type="hidden" name="<%=col3%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="0.00"> <%if (!strtype.trim().equals("H")) {%>
						<div align="right" style="width:75"><b><font size="1"
							face="Tahoma"> <lapschoice:CurrencyTag name="calc3" size="13"
							style="color:#000000;border:none;font-color:#000000;text-align:right"
							value='<%=colval3%>' other="disabled" /> </font></b></div>
						<!-- old value -->
						<div align="right" style="width:75"><b><input type="hidden" name="fincalc3"
							value='<%=fincolval3%>'></b></div>
						<%}
					}

					%></td>
						<td  width="14%" align="center"><%if (!strtype.trim().equals("C")
							&& !strtype.trim().equals("H")) {

						%> <input type="text" name="<%=col4%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=colval4%>"
							onKeyPress="allowNegtiveNumber(this)"> <!-- old value --> <input
							type="hidden" name="fin<%=col4%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=fincolval4%>"
							onKeyPress="allowNegtiveNumber(this)"> <%} else {

						%> <input type="hidden" name="<%=col4%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="0.00"> <%if (!strtype.trim().equals("H")) {%>
						<div align="right" style="width:75"><b><lapschoice:CurrencyTag name="calc4" size="13"
							style="color:#000000;border:none;font-color:#000000;text-align:right"
							value='<%=colval4%>' other="disabled" /></b></div>
						<!-- old value -->
						<div align="right" style="width:75"><b><input type="hidden" name="fincalc4"
							value='<%=fincolval4%>'></b></div>
						<%}}%></td>						
					</tr>
					<%}}%>
				</table>
				</td>
			</tr>
		</table>
		<br>
		<table border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
			<tr>
				<td><%if ((Integer.parseInt(totcount) > 4)
					&& (Integer.parseInt(fromnext) != 1)) {

			%> &lt;&lt;<a
					href="javascript:shownext('p')" class="blackfont"><b>Previous</b></a>
				<%}

			%></td>
				<td>&nbsp; <%int y1 = Integer.parseInt(totcount);
			if ((y1 > 4) && (Integer.parseInt(upto) != y1)) {

			%> <a href="javascript:shownext('n')"><b>Next</b></a>
				&gt;&gt;<%}%></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
		</table>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr>
		<td valign="top">
		<table width="90%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
			<tr>
				<td><b>Comments :
              </b></td>
			</tr>
			<tr>
				<td>
					<div id="id_div"><div class="EditorClassNew"> <%=Helper.correctNull((String)hshValues.get("notes")) %></div></div>
					<div id="id_editor">
						<textarea name="txt_sensitivecomments" cols="100" rows="10" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues.get("notes"))%></textarea>
					</div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
		<br>
		<%String strappno = request.getParameter("appno");

			%>
			<lapschoice:hiddentag pageid='<%=PageId%>'/>
			 <input type="hidden" name="totvalue" value="<%=totcount%>"> <input
			type="hidden" name="uptovalue" value="<%=upto%>"> <input
			type="hidden" name="fromvalue"
			value="<%=Integer.parseInt(upto) + 1%>"> <INPUT TYPE="hidden"
			name="fromnext"
			value="<%=Helper.correctNull((String)hshValues.get("from"))%>"> <INPUT
			TYPE="hidden" value="<%=pageval%>" name="pageval"> <INPUT
			TYPE="hidden" value="10" name="hidTotal"> <input type="hidden"
			name="comapp_compname"
			value="<%=request.getParameter("comapp_compname")%>"> <input
			type="hidden" name="comapp_compid"
			value="<%=request.getParameter("comapp_compid")%>"> <input
			type="hidden" name="comapp_id"
			value="<%=Helper.correctNull((String)request.getParameter("comapp_id"))%>">
		<INPUT TYPE="hidden" NAME="hidTabName" VALUE=""> <INPUT TYPE="hidden"
			NAME="hidMethod" VALUE=""> <INPUT TYPE="hidden" NAME="hidparam"
			VALUE=""> <input type="hidden" name="otherGenTable" value=""> <input
			type="hidden" name="hidOtherMethod" value=""> <input type="hidden"
			name="type1"> <input type="hidden" name="type2"> <input type="hidden"
			name="type3"> <input type="hidden" name="type4"> <input type="hidden"
			name="type5"> <input type="hidden" name="BaseYearFlag"
			value="<%=base_year%>"> <input type="hidden" name="yearfrom">
			<input type="hidden" name="hidCommentPage" value="sensitivity"> 
			<INPUT TYPE="hidden" name="strAssessment" value = "<%=COM_ASSESSMENTTYPE%>">
		<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Comments_Calculate' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
		</td>
	</tr> 
</table>
</form>
</body>
<!--<script language="javascript1.2">editor_generate('txt_sensitivecomments');</script>-->
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

	//Added for disabling the textbox and combo box
	
	if(tagFlag == strCurModule)
	{		
		document.forms[0].txtyear1.readOnly = false;
		document.forms[0].txtyear2.readOnly = false;
		document.forms[0].txtyear3.readOnly = false;
		document.forms[0].txtyear4.readOnly = false;
	
		document.forms[0].combo1.disabled=false;
		document.forms[0].combo3.disabled=false;
		document.forms[0].combo2.disabled=false;
		document.forms[0].combo4.disabled=false;
		//document.forms[0].combo5.disabled=false;
		/** Added by venu for base year selection*/		
	}
	else
	{
		document.forms[0].txtyear1.readOnly = true;
		document.forms[0].txtyear2.readOnly = true;
		document.forms[0].txtyear3.readOnly = true;
		document.forms[0].txtyear4.readOnly = true;
		
		document.forms[0].combo1.disabled=true;
		document.forms[0].combo3.disabled=true;
		document.forms[0].combo2.disabled=true;
		document.forms[0].combo4.disabled=true;		
	}
	}
	</script>
</html>
