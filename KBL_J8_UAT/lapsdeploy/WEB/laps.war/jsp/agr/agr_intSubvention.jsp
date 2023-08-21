<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
	
	String prd_type = Helper.correctNull((String) session.getAttribute("strProductType"));
	
	String schemetype="",strCropFlag="";
	String maxROI="";
	schemetype = Helper.correctNull((String) request.getParameter("schemetype"));
	strCropFlag = Helper.correctNull((String) hshValues.get("strCropFlag"));
	if(strCropFlag.equalsIgnoreCase("Y"))
		maxROI = Helper.correctNull((String) hshValues.get("maxCropROI"));
	else
		maxROI = Helper.correctNull((String) hshValues.get("maxOtherCropROI"));
	
	ArrayList arrRow=new ArrayList();
	ArrayList arrCol=new ArrayList();
	ArrayList arrCol1 = new ArrayList();
	ArrayList arrCol2 = new ArrayList();
	ArrayList arrCol3 = new ArrayList();
	ArrayList arrCol4 = new ArrayList();
	
	if(hshValues!=null)
	{
		arrRow = (ArrayList)hshValues.get("arrRow");
	}
	if (arrRow != null && arrRow.size() > 0) 
	{
		arrCol = (ArrayList) arrRow.get(0);
		arrCol1 = (ArrayList) arrRow.get(1);
		arrCol2 = (ArrayList) arrRow.get(2);
		arrCol3 = (ArrayList) arrRow.get(3);
		arrCol4 = (ArrayList) arrRow.get(4);
	}
	
out.println("!@@"+Helper.correctNull((String)request.getParameter("btnenable")));	
out.println("!@@"+Helper.correctNull((String)request.getParameter("hid_subvention")));	
out.println("!@@"+strCropFlag);	
%>
<html>
<head>
<title>Interest Subvention Details</title>
<STYLE>
DIV.cellContainer {	
  width: 100%; height: 150;
  overflow: auto;
}
</STYLE>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var varschemetype="<%=schemetype%>";
var maxLimit="<%=Helper.correctNull((String) hshValues.get("maxCropLimit"))%>";
var croploanstatus="<%=Helper.correctNull((String) hshValues.get("croploanstatus"))%>";
var varhidsubvention="<%=Helper.correctNull((String)request.getParameter("hid_subvention"))%>";
var varCropFlag="<%=strCropFlag%>";
function callonLoad()
{	
	
	if(appstatus=="Processed/Rejected" || appstatus=="Processed/Approved" || appstatus=="Closed/Approved" || appstatus=="Closed/Rejected")	 
	{
	 	disableFields(true);
	 	enableButtons(true,true,true,true,false);
	}	
	if(appstatus=="Open/Pending")
	{
		if(document.forms[0].btnenable.value=="Y" && varhidsubvention!="Y" && varCropFlag=="Y")
		{
			document.forms[0].cmdedit.disabled=true;
		}
	}
	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value=varschemetype;

	disableFields(true);
	for(var i=0;i<document.forms[0].txt_year.length;i++)
	{
		document.forms[0].txt_sublimitSOF_roi[i].value=<%=maxROI%>;
	}
}

function doSave()
{		
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="agrcrops";
	document.forms[0].hidBeanMethod.value="updInterestSubventionDetails";
	document.forms[0].hidBeanGetMethod.value="getInterestSubventionDetails";
	document.forms[0].hidSourceUrl.value="/action/agr_intSubvention.jsp";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}

function doCancel()
{
	if (ConfirmMsg(102))
	{
		document.forms[0].hidBeanGetMethod.value="getInterestSubventionDetails";
		document.forms[0].hidBeanId.value="agrcrops";
		document.forms[0].action=appUrl+"action/agr_intSubvention.jsp";	
		document.forms[0].submit();	
	}
}

function enableButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	   
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
	}
}

function doEdit() 
{
		disableFields(false);
		enableButtons(true,false,false,false,true);
   		document.forms[0].hidAction.value="update";
   	
   		for(var i=0;i<document.forms[0].txt_year.length;i++)
		{
			document.forms[0].txt_sublimitSOF_roi[i].readOnly=true;
			document.forms[0].txt_limitsanctioned[i].readOnly=true;
			document.forms[0].txt_sublimitIneligible_amt[i].readOnly=true;
			document.forms[0].txt_sublimitIneligible_roi[i].readOnly=true;
		}
}

function doDelete() 
{
	 if( ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updInterestSubventionDetails";
		document.forms[0].hidBeanGetMethod.value="getInterestSubventionDetails";
		document.forms[0].hidBeanId.value="agrcrops";
		document.forms[0].hidSourceUrl.value="action/agr_intSubvention.jsp";	
		document.forms[0].submit();	
	}
}  

function calculation()
{
	var sublimtSOF_amt=0;
	for(var i=0;i<document.forms[0].txt_year.length;i++)
	{
		var limitsanctioned = NanNumber(parseFloat(document.forms[0].txt_limitsanctioned[i].value)-parseFloat(document.forms[0].txt_sublimitSOF_amt[i].value));
		document.forms[0].txt_sublimitIneligible_amt[i].value = roundVal(limitsanctioned);
		  
	}
}




function doPrint()
{
		appno = document.forms[0].strAppno.value;
		upto = "";
		page="";
		pagefr=""
		totcount="";
		var from="";
		var purl = appUrl+"action/intrest_subvention_print.jsp?page="+page+"&from="+from+"&hidBeanGetMethod=getInterestSubventionDetails&hidBeanId=agrcrops&appno="+appno+"&pagefr="+pagefr;
		var title = "CBS_DATAS_HELP";
		var prop = "scrollbars=no,width=550,height=550";	
		prop = prop + ",left=500,top=700";
		window.open(purl,title,prop);

}
function checktxtamount(val1,val2,val3)
{
	var pcsamount=NanNumber(parseFloat(val1.value));
	var jgsudamount=NanNumber(parseFloat(val2.value));
	var eligible=maxLimit;
	var amountval=val3.value;
	var amountrecmd=parseFloat(eligible)-(parseFloat(pcsamount)+parseFloat(jgsudamount));
	if(varCropFlag=="N")
	{
		amountrecmd="<%=Helper.correctNull((String) hshValues.get("maxOtherCropLimit"))%>";
	}
	if(eval(amountrecmd)<0)
	{
		amountrecmd="0.0";
	}
	if(parseFloat(amountval)>parseFloat(amountrecmd))
	{
		alert("The amount should not exceeds Rs. "+amountrecmd);
		val3.value="";
		val3.focus();
	}
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">

<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>

</head>
<body  onload="callonLoad();calculation();">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems"><script language="JavaScript1.2">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div>
</div>

<form name="frmpri" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="999" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<lapschoice:borrowertype /> 
<lapschoice:application />
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">	
	<tr>
		<td class="page_flow">Home -&gt; Agriculture -&gt; Interest Subvention Details </td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="213" />
			<jsp:param name="schemetype" value="<%=schemetype%>" />
		</jsp:include></td>
	</tr>
	<%if(strCropFlag.equalsIgnoreCase("Y")){ %>
	<tr>
	<td align="center"> </br><span class="mantatory"> Note:- Please fill the details in the Assessment---->Assessment of Limit page before proceeding with the interest subvention details</span>
	</td>
</tr>
<%} %>
</table>
<br>
<table width="60%" border="1" cellspacing="0" cellpadding="3" class="" align="center" >
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="1" cellpadding="3">
				<tr class="dataHeader">
	               <td align="center" rowspan="2" width="15%">Year</td>
	               <td align="center" rowspan="2" width="15%">Limit Sanctioned </td>
	               <td align="center" colspan="2" width="35%">Sub limit as per SOF and post harvest expenses eligible for interest subvention</td>
	               <td align="center" colspan="2" width="35%">Sub limit for ineligible amount for interest subvention</td>
	            </tr>
	            <tr class="dataHeader">
                   <td align="center">Amount</td>
                   <td align="center">ROI %</td>
                   <td align="center">Amount</td>
                   <td align="center">ROI %</td>
                </tr>
                <tr class="dataGrid">
                   <td align="center"><b>I Year</b><input type="hidden" name="txt_year" value="I Year"></td>
                   <%if (arrRow != null && arrRow.size() > 0) {%>
                   <td align="center"><input type="text" name="txt_limitsanctioned" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="12" onBlur="roundtxt(this);calculation();" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(0)))%>">
                   <input type="hidden" name="txt_pcsamt" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="12" onBlur="roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(1)))%>">
                   <input type="hidden" name="txt_jgsudamt" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="12" onBlur="roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(2)))%>">
                   </td>
                   <td align="center"><input type="text" name="txt_sublimitSOF_amt" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="12" onBlur="roundtxt(this);calculation();checktxtamount(document.forms[0].txt_pcsamt[0],document.forms[0].txt_jgsudamt[0],this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(3)))%>"></td>
                   <td align="center"><input type="text" name="txt_sublimitSOF_roi" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="6" onBlur="roundtxt(this);checkPercentage(this);" value="<%=maxROI%>"></td>
                   <td align="center"><input type="text" name="txt_sublimitIneligible_amt" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="12" onBlur="roundtxt(this);calculation();" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(5)))%>"></td>
                   <td align="center"><input type="text" name="txt_sublimitIneligible_roi" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="6" onBlur="roundtxt(this);checkPercentage(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(6)))%>"></td>
                   <%}else {%>
                   <td align="center"><input type="text" name="txt_limitsanctioned" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="12" onBlur="roundtxt(this);calculation();" value=""></td>
                   <td align="center"><input type="text" name="txt_sublimitSOF_amt" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="12" onBlur="roundtxt(this);calculation();" value=""></td>
                   <td align="center"><input type="text" name="txt_sublimitSOF_roi" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="6" onBlur="roundtxt(this);checkPercentage(this);" value=""></td>
                   <td align="center"><input type="text" name="txt_sublimitIneligible_amt" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="12" onBlur="roundtxt(this);calculation();" value=""></td>
                   <td align="center"><input type="text" name="txt_sublimitIneligible_roi" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="6" onBlur="roundtxt(this);checkPercentage(this);" value=""></td>
                   <%}%>
                </tr>
                <tr class="dataGrid">
                   <td align="center"><b>II Year</b><input type="hidden" name="txt_year" value="II Year"></td>
                   <%if (arrRow != null && arrRow.size() > 0) {%>
                   <td align="center"><input type="text" name="txt_limitsanctioned" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="12" onBlur="roundtxt(this);calculation();" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(0)))%>">
                   <input type="hidden" name="txt_pcsamt" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="12" onBlur="roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(1)))%>">
                   <input type="hidden" name="txt_jgsudamt" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="12" onBlur="roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(2)))%>">
                   </td>
                   <td align="center"><input type="text" name="txt_sublimitSOF_amt" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="12" onBlur="roundtxt(this);calculation();checktxtamount(document.forms[0].txt_pcsamt[1],document.forms[0].txt_jgsudamt[1],this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(3)))%>"></td>
                   <td align="center"><input type="text" name="txt_sublimitSOF_roi" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="6" onBlur="roundtxt(this);checkPercentage(this);" value="<%=maxROI%>"></td>
                   <td align="center"><input type="text" name="txt_sublimitIneligible_amt" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="12" onBlur="roundtxt(this);calculation();" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(5)))%>"></td>
                   <td align="center"><input type="text" name="txt_sublimitIneligible_roi" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="6" onBlur="roundtxt(this);checkPercentage(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1.get(6)))%>"></td>
                   <%}else {%>
                   <td align="center"><input type="text" name="txt_limitsanctioned" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="12" onBlur="roundtxt(this);calculation();" value=""></td>
                   <td align="center"><input type="text" name="txt_sublimitSOF_amt" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="12" onBlur="roundtxt(this);calculation();" value=""></td>
                   <td align="center"><input type="text" name="txt_sublimitSOF_roi" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="6" onBlur="roundtxt(this);checkPercentage(this);" value=""></td>
                   <td align="center"><input type="text" name="txt_sublimitIneligible_amt" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="12" onBlur="roundtxt(this);calculation();" value=""></td>
                   <td align="center"><input type="text" name="txt_sublimitIneligible_roi" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="6" onBlur="roundtxt(this);checkPercentage(this);" value=""></td>
                   <%}%>
                </tr>
                <tr class="dataGrid">
                   <td align="center"><b>III Year</b><input type="hidden" name="txt_year" value="III Year"></td>
                   <%if (arrRow != null && arrRow.size() > 0) {%>
                   <td align="center"><input type="text" name="txt_limitsanctioned" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="12" onBlur="roundtxt(this);calculation();" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(0)))%>">
                   <input type="hidden" name="txt_pcsamt" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="12" onBlur="roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(1)))%>">
                   <input type="hidden" name="txt_jgsudamt" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="12" onBlur="roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(2)))%>">
                   </td>
                   <td align="center"><input type="text" name="txt_sublimitSOF_amt" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="12" onBlur="roundtxt(this);calculation();checktxtamount(document.forms[0].txt_pcsamt[2],document.forms[0].txt_jgsudamt[2],this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(3)))%>"></td>
                   <td align="center"><input type="text" name="txt_sublimitSOF_roi" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="6" onBlur="roundtxt(this);checkPercentage(this);" value="<%=maxROI%>"></td>
                   <td align="center"><input type="text" name="txt_sublimitIneligible_amt" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="12" onBlur="roundtxt(this);calculation();" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(5)))%>"></td>
                   <td align="center"><input type="text" name="txt_sublimitIneligible_roi" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="6" onBlur="roundtxt(this);checkPercentage(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2.get(6)))%>"></td>
                   <%}else {%>
                   <td align="center"><input type="text" name="txt_limitsanctioned" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="12" onBlur="roundtxt(this);calculation();" value=""></td>
                   <td align="center"><input type="text" name="txt_sublimitSOF_amt" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="12" onBlur="roundtxt(this);calculation();" value=""></td>
                   <td align="center"><input type="text" name="txt_sublimitSOF_roi" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="6" onBlur="roundtxt(this);checkPercentage(this);" value=""></td>
                   <td align="center"><input type="text" name="txt_sublimitIneligible_amt" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="12" onBlur="roundtxt(this);calculation();" value=""></td>
                   <td align="center"><input type="text" name="txt_sublimitIneligible_roi" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="6" onBlur="roundtxt(this);checkPercentage(this);" value=""></td>
                   <%}%>
                </tr>
                <tr class="dataGrid">
                   <td align="center"><b>IV Year</b><input type="hidden" name="txt_year" value="IV Year"></td>
                   <%if (arrRow != null && arrRow.size() > 0) {%>
                   <td align="center"><input type="text" name="txt_limitsanctioned" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="12" onBlur="roundtxt(this);calculation();" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(0)))%>">
                   <input type="hidden" name="txt_pcsamt" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="12" onBlur="roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(1)))%>">
                   <input type="hidden" name="txt_jgsudamt" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="12" onBlur="roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(2)))%>">
                   </td>
                   <td align="center"><input type="text" name="txt_sublimitSOF_amt" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="12" onBlur="roundtxt(this);calculation();checktxtamount(document.forms[0].txt_pcsamt[3],document.forms[0].txt_jgsudamt[3],this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(3)))%>"></td>
                   <td align="center"><input type="text" name="txt_sublimitSOF_roi" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="6" onBlur="roundtxt(this);checkPercentage(this);" value="<%=maxROI%>"></td>
                   <td align="center"><input type="text" name="txt_sublimitIneligible_amt" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="12" onBlur="roundtxt(this);calculation();" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(5)))%>"></td>
                   <td align="center"><input type="text" name="txt_sublimitIneligible_roi" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="6" onBlur="roundtxt(this);checkPercentage(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3.get(6)))%>"></td>
                   <%}else {%>
                   <td align="center"><input type="text" name="txt_limitsanctioned" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="12" onBlur="roundtxt(this);calculation();" value=""></td>
                   <td align="center"><input type="text" name="txt_sublimitSOF_amt" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="12" onBlur="roundtxt(this);calculation();" value=""></td>
                   <td align="center"><input type="text" name="txt_sublimitSOF_roi" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="6" onBlur="roundtxt(this);checkPercentage(this);" value=""></td>
                   <td align="center"><input type="text" name="txt_sublimitIneligible_amt" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="12" onBlur="roundtxt(this);calculation();" value=""></td>
                   <td align="center"><input type="text" name="txt_sublimitIneligible_roi" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="6" onBlur="roundtxt(this);checkPercentage(this);" value=""></td>
                   <%}%>
                </tr>
                <tr class="dataGrid">
                   <td align="center"><b>V Year</b><input type="hidden" name="txt_year" value="V Year"></td>
                   <%if (arrRow != null && arrRow.size() > 0) {%>
                   <td align="center"><input type="text" name="txt_limitsanctioned" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="12" onBlur="roundtxt(this);calculation();" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(0)))%>">
                   <input type="hidden" name="txt_pcsamt" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="12" onBlur="roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(1)))%>">
                   <input type="hidden" name="txt_jgsudamt" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="12" onBlur="roundtxt(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(2)))%>">
                   </td>
                   <td align="center"><input type="text" name="txt_sublimitSOF_amt" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="12" onBlur="roundtxt(this);calculation();checktxtamount(document.forms[0].txt_pcsamt[4],document.forms[0].txt_jgsudamt[4],this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(3)))%>"></td>
                   <td align="center"><input type="text" name="txt_sublimitSOF_roi" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="6" onBlur="roundtxt(this);checkPercentage(this);" value="<%=maxROI%>"></td>
                   <td align="center"><input type="text" name="txt_sublimitIneligible_amt" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="12" onBlur="roundtxt(this);calculation();" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(5)))%>"></td>
                   <td align="center"><input type="text" name="txt_sublimitIneligible_roi" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="6" onBlur="roundtxt(this);checkPercentage(this);" value="<%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4.get(6)))%>"></td>
                   <%}else {%>
                   <td align="center"><input type="text" name="txt_limitsanctioned" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="12" onBlur="roundtxt(this);calculation();" value=""></td>
                   <td align="center"><input type="text" name="txt_sublimitSOF_amt" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="12" onBlur="roundtxt(this);calculation();" value=""></td>
                   <td align="center"><input type="text" name="txt_sublimitSOF_roi" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="6" onBlur="roundtxt(this);checkPercentage(this);" value=""></td>
                   <td align="center"><input type="text" name="txt_sublimitIneligible_amt" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="12" onBlur="roundtxt(this);calculation();" value=""></td>
                   <td align="center"><input type="text" name="txt_sublimitIneligible_roi" size="15" onKeyPress="allowNumber(this)" style="text-align: right;" maxlength="6" onBlur="roundtxt(this);checkPercentage(this);" value=""></td>
                   <%}%>
                </tr>
			</table>
		</td>
	</tr>
	
</table>

<br>

<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Print" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>

<br>
<input type="hidden" name="hidorg_code" value="<%=Helper.correctNull((String) hshValues.get("ORG_CODE"))%>">
<input type="hidden" name="hidsno" value=""> 
<input type="hidden" name="hidAction"> 
<input type="hidden" name="hidBeanMethod" value=""> 
<input type="hidden" name="hidBeanId"> 
<input type="hidden" name="hidSourceUrl">
<input type="hidden" name="hidBeanGetMethod"> 
<input type="hidden" name="strAppno" value="<%=Helper.correctNull((String) hshValues.get("strAppno1"))%>">
<input type="hidden" name="hidschemetype" value="<%=schemetype%>">
<input type="hidden" name="hid_subvention" value="<%=Helper.correctNull((String)request.getParameter("hid_subvention"))%>">
</form>
</body>
</html>

