<%@include file="../share/directives.jsp"%>
<%
	ArrayList arrRow = new ArrayList();
	ArrayList arrCol = new ArrayList();
	
	arrRow = ((ArrayList)hshValues.get("arrRow"));
	
	String[] strIncurred1= new String[24];
	String[] strIncurred2= new String[24];
	String[] strIncurred3= new String[24];
	String[] strIncurred4= new String[24];
	
	for(int i=0;i<strIncurred1.length;i++)
	{
		strIncurred1[i]="";
		strIncurred2[i]="";
		strIncurred3[i]="";
		strIncurred4[i]="";
	}
	
	if(arrRow!=null)
	{
		for(int i =0;i<arrRow.size();i++)
		{	
			arrCol = (ArrayList) arrRow.get(i);
			
			strIncurred1[i] = Helper.correctNull((String)arrCol.get(0));
			strIncurred2[i] = Helper.correctNull((String)arrCol.get(1));
			strIncurred3[i] = Helper.correctNull((String)arrCol.get(2));
			strIncurred4[i] = Helper.correctNull((String)arrCol.get(3));
		}	
	}
%>

<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css" />
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
	<script language="Javascript1.2"><!-- // load htmlarea
_editor_url = "<%=ApplicationParams.getAppUrl()%>";                     // URL to htmlarea files
var win_ie_ver = parseFloat(navigator.appVersion.split("MSIE")[1]);
if (navigator.userAgent.indexOf('Mac')        >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Windows CE') >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Opera')      >= 0) { win_ie_ver = 0; }
if (win_ie_ver >= 5.5) {
  document.write('<scr' + 'ipt src="' +_editor_url+ 'editor.js"');
  document.write(' language="Javascript1.2"></scr' + 'ipt>');  
} else { document.write('<scr'+'ipt>function editor_generate() { return false; }</scr'+'ipt>'); }
// --></script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js">
</script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var strReviewYear = "<%=Helper.correctNull((String)hshValues.get("strReviewYear"))%>";
var strUserId='<%=(String)session.getAttribute("strUserId")%>';
var strprocessby="<%=Helper.correctNull((String)hshValues.get("MON_TERMLOANREVIEW_TOUSRID"))%>";
var strstatus="<%=Helper.correctNull((String)hshValues.get("review_status"))%>";
var comobo1 = "<%=strIncurred1[23]%>";
var comobo2 = "<%=strIncurred2[23]%>";
var comobo3 = "<%=strIncurred3[23]%>";
var comobo4 = "<%=strIncurred4[23]%>";
function onLoading()
{
	
	//disableCommandButtons("load");
	
	if(comobo1!="")
	{
		document.forms[0].combo1.value =comobo1;
	}
	else
	{
		document.forms[0].combo1.value = "S"
	}	
	if(comobo2!="")
	{
		document.forms[0].combo2.value =comobo2;
	}
	else
	{
		document.forms[0].combo2.value = "S"
	}
	if(comobo3!="")
	{
		document.forms[0].combo3.value =comobo3;
	}
	else
	{
		document.forms[0].combo3.value = "S"
	}
	if(comobo4!="")
	{
		document.forms[0].combo4.value =comobo4;
	}
	else
	{
		document.forms[0].combo4.value = "S"
	}

	disableFields(true);
}

function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;	
	}
	
	if(val=="edit")
	{	 
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=false;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}
	if(val=="new")
	{	 
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=true;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}
}

function callCalender(fname)
 {
	 if(document.forms[0].cmdsave.disabled==false)
	 {
	 	showCal("<%=ApplicationParams.getAppUrl()%>",fname);
 	 }	
 }

function doDelete()
{
	if(ConfirmMsg(101))
	{	
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appURL+"action/ControllerServlet";		
		document.forms[0].hidBeanMethod.value="updateReviewFinancial";
		document.forms[0].hidBeanGetMethod.value="getReviewFinancial";
		document.forms[0].hidBeanId.value="reviewtermloan";
		document.forms[0].hidSourceUrl.value="action/reviewnotecorporatefinancial.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}
}

function doEdit()
{ 	
    document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");
	
	document.forms[0].txt_incurred1[4].readOnly=true;
	document.forms[0].txt_incurred2[4].readOnly=true;
	document.forms[0].txt_incurred3[4].readOnly=true;
	document.forms[0].txt_incurred4[4].readOnly=true;
	
	document.forms[0].txt_incurred1[6].readOnly=true;
	document.forms[0].txt_incurred2[6].readOnly=true;
	document.forms[0].txt_incurred3[6].readOnly=true;
	document.forms[0].txt_incurred4[6].readOnly=true;
	
	document.forms[0].txt_incurred1[10].readOnly=true;
	document.forms[0].txt_incurred2[10].readOnly=true;
	document.forms[0].txt_incurred3[10].readOnly=true;
	document.forms[0].txt_incurred4[10].readOnly=true;
	
	document.forms[0].txt_incurred1[13].readOnly=true;
	document.forms[0].txt_incurred2[13].readOnly=true;
	document.forms[0].txt_incurred3[13].readOnly=true;
	document.forms[0].txt_incurred4[13].readOnly=true;
	
	document.forms[0].txt_incurred1[14].readOnly=true;
	document.forms[0].txt_incurred2[14].readOnly=true;
	document.forms[0].txt_incurred3[14].readOnly=true;
	document.forms[0].txt_incurred4[14].readOnly=true;
	
	document.forms[0].txt_incurred1[15].readOnly=true;
	document.forms[0].txt_incurred2[15].readOnly=true;
	document.forms[0].txt_incurred3[15].readOnly=true;
	document.forms[0].txt_incurred4[15].readOnly=true;
	
	document.forms[0].txt_incurred1[21].readOnly=true;
	document.forms[0].txt_incurred2[21].readOnly=true;
	document.forms[0].txt_incurred3[21].readOnly=true;
	document.forms[0].txt_incurred4[21].readOnly=true;
}

function doNew()
{ 	
	disableFields(false);
    document.forms[0].hidAction.value ="insert";
	disableCommandButtons("new");	
	document.forms[0].reviewYear.disabled = true;
	clearAll();
}
function calculate()
{
	var v1=document.forms[0].txt_incurred1[1].value;
	var v2=document.forms[0].txt_incurred1[2].value;
	var v3=document.forms[0].txt_incurred1[3].value;
	if(v1=="")
		v1=0;
	if(v2=="")
		v2 =0;
	if(v3=="")
		v3 =0;		
	document.forms[0].txt_incurred1[4].value=(eval(v1)+eval(v2))- eval(v3);
	roundtxt(document.forms[0].txt_incurred1[4]);
	
	var v4=document.forms[0].txt_incurred1[4].value;
	var v5=document.forms[0].txt_incurred1[5].value;
	if(v4=="")
		v4=0;
	if(v5=="")
		v5=0;	
	document.forms[0].txt_incurred1[6].value= eval(v4)+eval(v5);
	roundtxt(document.forms[0].txt_incurred1[6]);
		
	var v6 = document.forms[0].txt_incurred1[6].value;
	var v7 = document.forms[0].txt_incurred1[7].value;
	var v8 = document.forms[0].txt_incurred1[8].value;
	var v9 = document.forms[0].txt_incurred1[9].value;
	if(v6=="")
		v6=0;
	if(v7=="")
		v7=0;
	if(v8=="")
		v8=0;
	if(v9=="")
		v9=0;		
	document.forms[0].txt_incurred1[10].value= eval(v6) - (eval(v7)+eval(v8)+eval(v9));
	roundtxt(document.forms[0].txt_incurred1[10]);
	
	var v11 = document.forms[0].txt_incurred1[11].value;
	var v12 = document.forms[0].txt_incurred1[12].value;
	
	if(v11=="")
		v11=0;
	if(v12=="")
		v12=0;
	if(v12!=0)
	{
		document.forms[0].txt_incurred1[13].value= eval(v11) / eval(v12);
	}
	else
	{
		document.forms[0].txt_incurred1[13].value=0.0;
	}
		
	roundtxt(document.forms[0].txt_incurred1[13]);
		
	if(v4!=0)
	{
		document.forms[0].txt_incurred1[14].value = eval(v5) / eval(v4);
	}
	else
	{
		document.forms[0].txt_incurred1[14].value =0.0;
	}
	roundtxt(document.forms[0].txt_incurred1[14]);
	
	if(v4!=0)
	{	
		document.forms[0].txt_incurred1[15].value = (eval(v5) + eval(v12)) / eval(v4);
	}
	else
	{
		document.forms[0].txt_incurred1[15].value = 0.0;
	}
	roundtxt(document.forms[0].txt_incurred1[15]);
	
	var v19 = document.forms[0].txt_incurred1[19].value;
	var v20 = document.forms[0].txt_incurred1[20].value;
	if(v19=="")
		v19=0;
	if(v20=="")
		v20=0;	
	
	document.forms[0].txt_incurred1[21].value = eval(v19) + eval(v20);
	roundtxt(document.forms[0].txt_incurred1[21]);
}

function calculate1()
{
	var v1=document.forms[0].txt_incurred2[1].value;
	var v2=document.forms[0].txt_incurred2[2].value;
	var v3=document.forms[0].txt_incurred2[3].value;
	if(v1=="")
		v1=0;
	if(v2=="")
		v2 =0;
	if(v3=="")
		v3 =0;		
	document.forms[0].txt_incurred2[4].value=(eval(v1)+eval(v2))- eval(v3);
	roundtxt(document.forms[0].txt_incurred2[4]);
	
	var v4=document.forms[0].txt_incurred2[4].value;
	var v5=document.forms[0].txt_incurred2[5].value;
	if(v4=="")
		v4=0;
	if(v5=="")
		v5=0;	
	document.forms[0].txt_incurred2[6].value= eval(v4)+eval(v5);
	roundtxt(document.forms[0].txt_incurred2[6]);
	
	var v6 = document.forms[0].txt_incurred2[6].value;
	var v7 = document.forms[0].txt_incurred2[7].value;
	var v8 = document.forms[0].txt_incurred2[8].value;
	var v9 = document.forms[0].txt_incurred2[9].value;
	if(v6=="")
		v6=0;
	if(v7=="")
		v7=0;
	if(v8=="")
		v8=0;
	if(v9=="")
		v9=0;		
	document.forms[0].txt_incurred2[10].value= eval(v6) - (eval(v7)+eval(v8)+eval(v9));
	roundtxt(document.forms[0].txt_incurred2[10]);
	
	var v11 = document.forms[0].txt_incurred2[11].value;
	var v12 = document.forms[0].txt_incurred2[12].value;
	
	if(v11=="")
		v11=0;
	if(v12=="")
		v12=0;
	if(v12!=0)
	{
		document.forms[0].txt_incurred2[13].value= eval(v11) / eval(v12);
	}
	else
	{
		document.forms[0].txt_incurred2[13].value=0.0;
	}
	
	roundtxt(document.forms[0].txt_incurred2[13]);
	
	if(v4!=0)
	{
		document.forms[0].txt_incurred2[14].value = eval(v5) / eval(v4);
	}
	else
	{
		document.forms[0].txt_incurred2[14].value =0.0;
	}
	roundtxt(document.forms[0].txt_incurred2[14]);
	
	if(v4!=0)
	{	
		document.forms[0].txt_incurred2[15].value = (eval(v5) + eval(v12)) / eval(v4);
	}
	else
	{
		document.forms[0].txt_incurred2[15].value = 0.0;
	}
	roundtxt(document.forms[0].txt_incurred2[15]);
	
	var v19 = document.forms[0].txt_incurred2[19].value;
	var v20 = document.forms[0].txt_incurred2[20].value;
	if(v19=="")
		v19=0;
	if(v20=="")
		v20=0;	
	
	document.forms[0].txt_incurred2[21].value = eval(v19) + eval(v20);
	
	
	//roundtxt(document.forms[0].txt_incurred2[16]);
	roundtxt(document.forms[0].txt_incurred2[21]);
		
}
function calculate2()
{
	var v1=document.forms[0].txt_incurred3[1].value;
	var v2=document.forms[0].txt_incurred3[2].value;
	var v3=document.forms[0].txt_incurred3[3].value;
	if(v1=="")
		v1=0;
	if(v2=="")
		v2 =0;
	if(v3=="")
		v3 =0;		
	document.forms[0].txt_incurred3[4].value=(eval(v1)+eval(v2))- eval(v3);
	roundtxt(document.forms[0].txt_incurred3[4]);
	
	var v4=document.forms[0].txt_incurred3[4].value;
	var v5=document.forms[0].txt_incurred3[5].value;
	if(v4=="")
		v4=0;
	if(v5=="")
		v5=0;	
	document.forms[0].txt_incurred3[6].value= eval(v4)+eval(v5);
	roundtxt(document.forms[0].txt_incurred3[6]);
	
	var v6 = document.forms[0].txt_incurred3[6].value;
	var v7 = document.forms[0].txt_incurred3[7].value;
	var v8 = document.forms[0].txt_incurred3[8].value;
	var v9 = document.forms[0].txt_incurred3[9].value;
	if(v6=="")
		v6=0;
	if(v7=="")
		v7=0;
	if(v8=="")
		v8=0;
	if(v9=="")
		v9=0;		
	document.forms[0].txt_incurred3[10].value= eval(v6) - (eval(v7)+eval(v8)+eval(v9));
	roundtxt(document.forms[0].txt_incurred3[10]);
	
	var v11 = document.forms[0].txt_incurred3[11].value;
	var v12 = document.forms[0].txt_incurred3[12].value;
	
	if(v11=="")
		v11=0;
	if(v12=="")
		v12=0;
	if(v12!=0)
	{
		document.forms[0].txt_incurred3[13].value= eval(v11) / eval(v12);
	}
	else
	{
		document.forms[0].txt_incurred3[13].value=0.0;
	}
	
	roundtxt(document.forms[0].txt_incurred3[13]);
	
	if(v4!=0)
	{
		document.forms[0].txt_incurred3[14].value = eval(v5) / eval(v4);
	}
	else
	{
		document.forms[0].txt_incurred3[14].value =0.0;
	}
	roundtxt(document.forms[0].txt_incurred3[14]);
	
	if(v4!=0)
	{	
		document.forms[0].txt_incurred3[15].value = (eval(v5) + eval(v12)) / eval(v4);
	}
	else
	{
		document.forms[0].txt_incurred3[15].value = 0.0;
	}
	roundtxt(document.forms[0].txt_incurred3[15]);
	
	var v19 = document.forms[0].txt_incurred3[19].value;
	var v20 = document.forms[0].txt_incurred3[20].value;
	if(v19=="")
		v19=0;
	if(v20=="")
		v20=0;	
	
	document.forms[0].txt_incurred3[21].value = eval(v19) + eval(v20);
	
	
	roundtxt(document.forms[0].txt_incurred3[21]);
}

function calculate3()
{
	var v1=document.forms[0].txt_incurred4[1].value;
	var v2=document.forms[0].txt_incurred4[2].value;
	var v3=document.forms[0].txt_incurred4[3].value;
	if(v1=="")
		v1=0;
	if(v2=="")
		v2 =0;
	if(v3=="")
		v3 =0;		
	document.forms[0].txt_incurred4[4].value=(eval(v1)+eval(v2))- eval(v3);
	roundtxt(document.forms[0].txt_incurred4[4]);
	
	var v4=document.forms[0].txt_incurred4[4].value;
	var v5=document.forms[0].txt_incurred4[5].value;
	if(v4=="")
		v4=0;
	if(v5=="")
		v5=0;	
	document.forms[0].txt_incurred4[6].value= eval(v4)+eval(v5);
	roundtxt(document.forms[0].txt_incurred4[6]);
	
	var v6 = document.forms[0].txt_incurred4[6].value;
	var v7 = document.forms[0].txt_incurred4[7].value;
	var v8 = document.forms[0].txt_incurred4[8].value;
	var v9 = document.forms[0].txt_incurred4[9].value;
	if(v6=="")
		v6=0;
	if(v7=="")
		v7=0;
	if(v8=="")
		v8=0;
	if(v9=="")
		v9=0;		
	document.forms[0].txt_incurred4[10].value= eval(v6) - (eval(v7)+eval(v8)+eval(v9));
	roundtxt(document.forms[0].txt_incurred4[10]);
	
	var v11 = document.forms[0].txt_incurred4[11].value;
	var v12 = document.forms[0].txt_incurred4[12].value;
	
	if(v11=="")
		v11=0;
	if(v12=="")
		v12=0;
	if(v12!=0)
	{
		document.forms[0].txt_incurred4[13].value= eval(v11) / eval(v12);
	}
	else
	{
		document.forms[0].txt_incurred4[13].value=0.0;
	}
	
	roundtxt(document.forms[0].txt_incurred4[13]);
	
	if(v4!=0)
	{
		document.forms[0].txt_incurred4[14].value = eval(v5) / eval(v4);
	}
	else
	{
		document.forms[0].txt_incurred4[14].value =0.0;
	}
	roundtxt(document.forms[0].txt_incurred4[14]);
	
	if(v4!=0)
	{	
		document.forms[0].txt_incurred4[15].value = (eval(v5) + eval(v12)) / eval(v4);
	}
	else
	{
		document.forms[0].txt_incurred4[15].value = 0.0;
	}
	roundtxt(document.forms[0].txt_incurred4[15]);
	
	var v19 = document.forms[0].txt_incurred4[19].value;
	var v20 = document.forms[0].txt_incurred4[20].value;
	if(v19=="")
		v19=0;
	if(v20=="")
		v20=0;	
	
	document.forms[0].txt_incurred4[21].value = eval(v19) + eval(v20);
	
	
	roundtxt(document.forms[0].txt_incurred4[21]);
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidSourceUrl.value="";
		document.forms[0].hidBeanId.value="reviewtermloan";
		document.forms[0].hidBeanGetMethod.value="getReviewFinancial";
		document.forms[0].action=appURL +"action/reviewnotecorporatefinancial.jsp";
	    document.forms[0].submit();	
	}	
	
	disableCommandButtons("load");
}


	function doSave()
	{
		 
		document.forms[0].hidBeanId.value="reviewtermloan";
		document.forms[0].hidBeanMethod.value="updateReviewFinancial";
		document.forms[0].hidBeanGetMethod.value="getReviewFinancial";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/reviewnotecorporatefinancial.jsp";
		document.forms[0].submit();
	}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].disabled=val;
		}		  
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].disabled=val;
		}
		 
	}
	
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/mon_borrowersearch.jsp?hidmontype=MONITREVIEW";
		document.forms[0].submit();
		
	}
}
function callLink(page,bean,method)
{
	
	 if (document.forms[0].cmdapply.disabled)
		{
			document.forms[0].hidSourceUrl.value=page;
			document.forms[0].hidBeanGetMethod.value=method;
			document.forms[0].hidBeanId.value=bean;
			document.forms[0].action=appURL+"action/"+page;
			document.forms[0].submit();
		}
	else
		{
			ShowAlert(103);
		}
}
function callOtherLink(page,bean,method)
{
	if(!document.forms[0].reviewYear.value=="")
	{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appURL+"action/"+page;
		document.forms[0].submit();
	}
	else
	{
		alert("Select Review Year");
	}
}


function showReviewYear()
{
	var strcbsid = "<%=Helper.correctNull((String)hshValues.get("strCBSCustid"))%>";
	if(strcbsid=="")
		{
			strcbsid=document.forms[0].strcbsid.value;
		}
	var cbsaccno = "<%=Helper.correctNull((String)hshValues.get("strCBSCustAccno"))%>";
	if(cbsaccno=="")
		{
			cbsaccno=document.forms[0].cbsappno.value;
		}
	var reviewYear = document.forms[0].reviewYear.value;
	if(reviewYear!="")
	{
	document.all.ifrm.src=appURL+"action/ifrmReviewYear.jsp?hidBeanId=reviewtermloan&hidBeanGetMethod=getReviewNoteTermLoan&strcbsid="+strcbsid+"&cbsaccno="+cbsaccno+"&reviewYear="+reviewYear;
	}
		
}




</script>

</head>

<body onload="onLoading()">
<form name="safaeri3" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
			<lapschoice:tlrtag pageid="6" reviewof='<%=Helper.correctNull((String)request.getParameter("reviewOf"))%>' valuesin='<%=Helper.correctNull((String)request.getParameter("valuesin"))%>'/>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>

		<td valign="top" colspan="5" class="page_flow">Home -&gt; Monitoring -&gt;Term Loan - Review -&gt; Finacial</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
			<tr>
				<td><lapschoice:MonitorReview /></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable border1">
	<tr>
		<td>
		  <table width="98%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable">
          <tr>
				<td width="32%" align="center"><b>Year Ended / Ending</b></td>
				<td width="17%"><input type="text" name="txt_incurred1" size="13"
					maxlength="12" 
					value="<%=strIncurred1[0]%>"
					onBlur="checkDate(txt_incurred1[0])" readOnly="readonly"> <a
					alt="Select date from calender"
					href="javascript:callCalender('txt_incurred1[0]')"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a></td>
				<td width="17%"><input type="text" name="txt_incurred2" size="13"
					maxlength="12" 
					value="<%=strIncurred2[0]%>"
					onBlur="checkDate(txt_incurred2[0])" readOnly="readonly"> <a
					alt="Select date from calender"
					href="javascript:callCalender('txt_incurred2[0]')"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a></td>
				<td width="18%"><input type="text" name="txt_incurred3" size="13"
					maxlength="12"
					value="<%=strIncurred3[0]%>"
					onBlur="checkDate(txt_incurred3[0])" readOnly="readonly"> <a
					alt="Select date from calender"
					href="javascript:callCalender('txt_incurred3[0]')"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a></td>
				<td width="17%"><input type="text" name="txt_incurred4" size="13"
					maxlength="12" 
					value="<%=strIncurred4[0]%>"
					onBlur="checkDate(txt_incurred4[0])" readOnly="readonly"> <a
					alt="Select date from calender"
					href="javascript:callCalender('txt_incurred4[0]')"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a></td>
			</tr>
			<tr>
				<td width="32%">&nbsp;</td>
				<td width="17%"><select name="combo1">
					<option value="S" selected="selected">--Select--</option>
					<option value="a">Audited</option>
					<option value="e">Estimated</option>
					<option value="u">Unaudited</option>
					<option value="p">Projection</option>
				</select></td>
				<td width="17%"><select name="combo2">
					<option value="S" selected="selected">--Select--</option>
					<option value="a">Audited</option>
					<option value="e">Estimated</option>
					<option value="u">Unaudited</option>
					<option value="p">Projection</option>
				</select></td>
				<td width="18%"><select name="combo3">
					<option value="S" selected="selected">--Select--</option>
					<option value="a">Audited</option>
					<option value="e">Estimated</option>
					<option value="u">Unaudited</option>
					<option value="p">Projection</option>
				</select></td>
				<td width="17%"><select name="combo4">
					<option value="S" selected="selected">--Select--</option>
					<option value="a">Audited</option>
					<option value="e">Estimated</option>
					<option value="u">Unaudited</option>
					<option value="p">Projection</option>
				</select></td>
			</tr>
			<tr>
				<td width="32%">1. Paid-Up Capital</td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred1"
					size="12" value='<%=strIncurred1[1]%>' maxlength="11"
					onBlur="calculate()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred2"
					size="12" value='<%=strIncurred2[1]%>' maxlength="11"
					onBlur="calculate1()" /></td>
				<td width="18%"><lapschoice:CurrencyTag name="txt_incurred3"
					size="12" value='<%=strIncurred3[1]%>' maxlength="11"
					onBlur="calculate2()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred4"
					size="12" value='<%=strIncurred4[1]%>' maxlength="11"
					onBlur="calculate3()" /></td>
			</tr>
			<tr>
				<td width="32%">2. Reserves &amp; Surplus</td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred1"
					size="12" value='<%=strIncurred1[2]%>' maxlength="11"
					onBlur="calculate()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred2"
					size="12" value='<%=strIncurred2[2]%>' maxlength="11"
					onBlur="calculate1()" /></td>
				<td width="18%"><lapschoice:CurrencyTag name="txt_incurred3"
					size="12" value='<%=strIncurred3[2]%>' maxlength="11"
					onBlur="calculate2()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred4"
					size="12" value='<%=strIncurred4[2]%>' maxlength="11"
					onBlur="calculate3()" /></td>
			</tr>
			<tr>
				<td width="32%">3. Intangible assets</td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred1"
					size="12" value='<%=strIncurred1[3]%>' maxlength="11"
					onBlur="calculate()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred2"
					size="12" value='<%=strIncurred2[3]%>' maxlength="11"
					onBlur="calculate1()" /></td>
				<td width="18%"><lapschoice:CurrencyTag name="txt_incurred3"
					size="12" value='<%=strIncurred3[3]%>' maxlength="11"
					onBlur="calculate2()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred4"
					size="12" value='<%=strIncurred4[3]%>' maxlength="11"
					onBlur="calculate3()" /></td>
			</tr>
			<tr>
				<td width="32%">4. Tangible Net Worth</td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred1"
					size="12" value='<%=strIncurred1[4]%>' maxlength="11"
					onBlur="calculate()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred2"
					size="12" value='<%=strIncurred2[4]%>' maxlength="11"
					onBlur="calculate1()" /></td>
				<td width="18%"><lapschoice:CurrencyTag name="txt_incurred3"
					size="12" value='<%=strIncurred3[4]%>' maxlength="11"
					onBlur="calculate2()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred4"
					size="12" value='<%=strIncurred4[4]%>' maxlength="11"
					onBlur="calculate3()" /></td>
			</tr>
			<tr>
				<td width="32%">5. Long Term Liabilities</td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred1"
					size="12" value='<%=strIncurred1[5]%>' maxlength="11"
					onBlur="calculate()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred2"
					size="12" value='<%=strIncurred2[5]%>' maxlength="11"
					onBlur="calculate1()" /></td>
				<td width="18%"><lapschoice:CurrencyTag name="txt_incurred3"
					size="12" value='<%=strIncurred3[5]%>' maxlength="11"
					onBlur="calculate2()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred4"
					size="12" value='<%=strIncurred4[5]%>' maxlength="11"
					onBlur="calculate3()" /></td>
			</tr>
			<tr>
				<td width="32%">6. Capital Employed</td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred1"
					size="12" value='<%=strIncurred1[6]%>' maxlength="11"
					onBlur="calculate()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred2"
					size="12" value='<%=strIncurred2[6]%>' maxlength="11"
					onBlur="calculate1()" /></td>
				<td width="18%"><lapschoice:CurrencyTag name="txt_incurred3"
					size="12" value='<%=strIncurred3[6]%>' maxlength="11"
					onBlur="calculate2()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred4"
					size="12" value='<%=strIncurred4[6]%>' maxlength="11"
					onBlur="calculate3()" /></td>
			</tr>
			<tr>
				<td width="32%">7. Net Block</td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred1"
					size="12" value='<%=strIncurred1[7]%>' maxlength="11"
					onBlur="calculate()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred2"
					size="12" value='<%=strIncurred2[7]%>' maxlength="11"
					onBlur="calculate1()" /></td>
				<td width="18%"><lapschoice:CurrencyTag name="txt_incurred3"
					size="12" value='<%=strIncurred3[7]%>' maxlength="11"
					onBlur="calculate2()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred4"
					size="12" value='<%=strIncurred4[7]%>' maxlength="11"
					onBlur="calculate3()" /></td>
			</tr>
			<tr>
				<td width="32%">8. Investments</td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred1"
					size="12" value='<%=strIncurred1[8]%>' maxlength="11"
					onBlur="calculate()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred2"
					size="12" value='<%=strIncurred2[8]%>' maxlength="11"
					onBlur="calculate1()" /></td>
				<td width="18%"><lapschoice:CurrencyTag name="txt_incurred3"
					size="12" value='<%=strIncurred3[8]%>' maxlength="11"
					onBlur="calculate2()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred4"
					size="12" value='<%=strIncurred4[8]%>' maxlength="11"
					onBlur="calculate3()" /></td>
			</tr>
			<tr>
				<td width="32%">9. Non Current Assets</td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred1"
					size="12" value='<%=strIncurred1[9]%>' maxlength="11"
					onBlur="calculate()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred2"
					size="12" value='<%=strIncurred2[9]%>' maxlength="11"
					onBlur="calculate1()" /></td>
				<td width="18%"><lapschoice:CurrencyTag name="txt_incurred3"
					size="12" value='<%=strIncurred3[9]%>' maxlength="11"
					onBlur="calculate2()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred4"
					size="12" value='<%=strIncurred4[9]%>' maxlength="11"
					onBlur="calculate3()" /></td>
			</tr>
			<tr>
				<td width="32%">10. Net Working Capital (Tally with Item 11 - item
				12)</td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred1"
					size="12" value='<%=strIncurred1[10]%>' maxlength="11"
					onBlur="calculate()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred2"
					size="12" value='<%=strIncurred2[10]%>' maxlength="11"
					onBlur="calculate1()" /></td>
				<td width="18%"><lapschoice:CurrencyTag name="txt_incurred3"
					size="12" value='<%=strIncurred3[10]%>' maxlength="11"
					onBlur="calculate2()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred4"
					size="12" value='<%=strIncurred4[10]%>' maxlength="11"
					onBlur="calculate3()" /></td>
			</tr>
			<tr>
				<td width="32%">11. Current Assets</td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred1"
					size="12" value='<%=strIncurred1[11]%>' maxlength="11"
					onBlur="calculate()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred2"
					size="12" value='<%=strIncurred2[11]%>' maxlength="11"
					onBlur="calculate1()" /></td>
				<td width="18%"><lapschoice:CurrencyTag name="txt_incurred3"
					size="12" value='<%=strIncurred3[11]%>' maxlength="11"
					onBlur="calculate2()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred4"
					size="12" value='<%=strIncurred4[11]%>' maxlength="11"
					onBlur="calculate3()" /></td>
			</tr>
			<tr>
				<td width="32%">12. Current Liabilities</td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred1"
					size="12" value='<%=strIncurred1[12]%>' maxlength="11"
					onBlur="calculate()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred2"
					size="12" value='<%=strIncurred2[12]%>' maxlength="11"
					onBlur="calculate1()" /></td>
				<td width="18%"><lapschoice:CurrencyTag name="txt_incurred3"
					size="12" value='<%=strIncurred3[12]%>' maxlength="11"
					onBlur="calculate2()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred4"
					size="12" value='<%=strIncurred4[12]%>' maxlength="11"
					onBlur="calculate3()" /></td>
			</tr>
			<tr>
				<td width="32%">13. Currnet Ratio</td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred1"
					size="12" value='<%=strIncurred1[13]%>' maxlength="11"
					onBlur="calculate()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred2"
					size="12" value='<%=strIncurred2[13]%>' maxlength="11"
					onBlur="calculate1()" /></td>
				<td width="18%"><lapschoice:CurrencyTag name="txt_incurred3"
					size="12" value='<%=strIncurred3[13]%>' maxlength="11"
					onBlur="calculate2()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred4"
					size="12" value='<%=strIncurred4[13]%>' maxlength="11"
					onBlur="calculate3()" /></td>
			</tr>
			<tr>
				<td width="32%">14. DER(TL/TNW)</td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred1"
					size="12" value='<%=strIncurred1[14]%>' maxlength="11"
					onBlur="calculate()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred2"
					size="12" value='<%=strIncurred2[14]%>' maxlength="11"
					onBlur="calculate1()" /></td>
				<td width="18%"><lapschoice:CurrencyTag name="txt_incurred3"
					size="12" value='<%=strIncurred3[14]%>' maxlength="11"
					onBlur="calculate2()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred4"
					size="12" value='<%=strIncurred4[14]%>' maxlength="11"
					onBlur="calculate3()" /></td>
			</tr>
			<tr>
				<td width="32%">15. TOL/TNW Ratio</td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred1"
					size="12" value='<%=strIncurred1[15]%>' maxlength="11"
					onBlur="calculate()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred2"
					size="12" value='<%=strIncurred2[15]%>' maxlength="11"
					onBlur="calculate1()" /></td>
				<td width="18%"><lapschoice:CurrencyTag name="txt_incurred3"
					size="12" value='<%=strIncurred3[15]%>' maxlength="11"
					onBlur="calculate2()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred4"
					size="12" value='<%=strIncurred4[15]%>' maxlength="11"
					onBlur="calculate3()" /></td>
			</tr>
			<tr>
				<td width="32%">16. Net Sales</td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred1"
					size="12" value='<%=strIncurred1[16]%>' maxlength="11"
					onBlur="calculate()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred2"
					size="12" value='<%=strIncurred2[16]%>' maxlength="11"
					onBlur="calculate1()" /></td>
				<td width="18%"><lapschoice:CurrencyTag name="txt_incurred3"
					size="12" value='<%=strIncurred3[16]%>' maxlength="11"
					onBlur="calculate2()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred4"
					size="12" value='<%=strIncurred4[16]%>' maxlength="11"
					onBlur="calculate3()" /></td>
			</tr>
			<tr>
				<td width="32%">17. Other Income</td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred1"
					size="12" value='<%=strIncurred1[17]%>' maxlength="11"
					onBlur="calculate()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred2"
					size="12" value='<%=strIncurred2[17]%>' maxlength="11"
					onBlur="calculate1()" /></td>
				<td width="18%"><lapschoice:CurrencyTag name="txt_incurred3"
					size="12" value='<%=strIncurred3[17]%>' maxlength="11"
					onBlur="calculate2()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred4"
					size="12" value='<%=strIncurred4[17]%>' maxlength="11"
					onBlur="calculate3()" /></td>
			</tr>
			<tr>
				<td width="32%">18. Net Profit Before Tax</td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred1"
					size="12" value='<%=strIncurred1[18]%>' maxlength="11"
					onBlur="calculate()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred2"
					size="12" value='<%=strIncurred2[18]%>' maxlength="11"
					onBlur="calculate1()" /></td>
				<td width="18%"><lapschoice:CurrencyTag name="txt_incurred3"
					size="12" value='<%=strIncurred3[18]%>' maxlength="11"
					onBlur="calculate2()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred4"
					size="12" value='<%=strIncurred4[18]%>' maxlength="11"
					onBlur="calculate3()" /></td>
			</tr>
			<tr>
				<td width="32%">19. Net Profit After Tax</td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred1"
					size="12" value='<%=strIncurred1[19]%>' maxlength="11"
					onBlur="calculate()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred2"
					size="12" value='<%=strIncurred2[19]%>' maxlength="11"
					onBlur="calculate1()" /></td>
				<td width="18%"><lapschoice:CurrencyTag name="txt_incurred3"
					size="12" value='<%=strIncurred3[19]%>' maxlength="11"
					onBlur="calculate2()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred4"
					size="12" value='<%=strIncurred4[19]%>' maxlength="11"
					onBlur="calculate3()" /></td>
			</tr>
			<tr>
				<td width="32%">20. Depreciation</td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred1"
					size="12" value='<%=strIncurred1[20]%>' maxlength="11"
					onBlur="calculate()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred2"
					size="12" value='<%=strIncurred2[20]%>' maxlength="11"
					onBlur="calculate1()" /></td>
				<td width="18%"><lapschoice:CurrencyTag name="txt_incurred3"
					size="12" value='<%=strIncurred3[20]%>' maxlength="11"
					onBlur="calculate2()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred4"
					size="12" value='<%=strIncurred4[20]%>' maxlength="11"
					onBlur="calculate3()" /></td>
			</tr>
			<tr>
				<td width="32%">21. Cash Accruals</td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred1"
					size="12" value='<%=strIncurred1[21]%>' maxlength="11"
					onBlur="calculate()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred2"
					size="12" value='<%=strIncurred2[21]%>' maxlength="11"
					onBlur="calculate1()" /></td>
				<td width="18%"><lapschoice:CurrencyTag name="txt_incurred3"
					size="12" value='<%=strIncurred3[21]%>' maxlength="11"
					onBlur="calculate2()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred4"
					size="12" value='<%=strIncurred4[21]%>' maxlength="11"
					onBlur="calculate3()" /></td>
			</tr>
			<tr>
				<td width="32%">22. DSCR</td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred1"
					size="12" value='<%=strIncurred1[22]%>' maxlength="11"
					onBlur="calculate()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred2"
					size="12" value='<%=strIncurred2[22]%>' maxlength="11"
					onBlur="calculate1()" /></td>
				<td width="18%"><lapschoice:CurrencyTag name="txt_incurred3"
					size="12" value='<%=strIncurred3[22]%>' maxlength="11"
					onBlur="calculate2()" /></td>
				<td width="17%"><lapschoice:CurrencyTag name="txt_incurred4"
					size="12" value='<%=strIncurred4[22]%>' maxlength="11"
					onBlur="calculate3()" /></td>
			</tr>
			<tr>
				<td colspan="5"><b>Comments on Financial Highlights</b>&nbsp;</td>
			</tr>
			<tr>
				
				<td colspan="5">
				 <textarea name="txt_fincomments" cols="120" rows="10" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%= Helper.correctNull((String)hshValues.get("comments"))%></textarea>
                   </td>
			</tr>
		</table>
		</td>
	</tr>
</table><br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="mail_touserclass">
<iframe id="ifrm" src="" width="100%" height="0" border="no"> </iframe>
 <input type="hidden" name="org_code" value="<%=strOrgCode%>"> 
 <input type="hidden" name="remarksFlag" value="false"> 
 <input type="hidden" name="hideditoption" value="N"> 
 <input type="hidden" name="txt_usrid" 	value="<%=session.getAttribute("strUserId") %>"> 
 <input type="hidden" name="Stateflag"> 
 <input type="hidden" name="reviewOf" value="<%=request.getParameter("reviewOf")%>">
</form>
</body>
<script language="javascript1.2">
editor_generate('txt_fincomments');
</script>
</html>

