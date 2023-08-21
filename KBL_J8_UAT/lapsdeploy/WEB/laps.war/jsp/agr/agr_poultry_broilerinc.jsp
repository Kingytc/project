<%@include file="../share/directives.jsp"%>

<%
	String strappno = Helper.correctNull((String) request.getParameter("appno"));
	ArrayList arryCol1 = new ArrayList();
	ArrayList arryRow1 = new ArrayList();
	arryRow1 = (ArrayList) hshValues.get("arryRow1");
	ArrayList arrSalBird = (ArrayList) hshValues.get("arrSalebirds");
	ArrayList arrSaleManure = (ArrayList) hshValues.get("arrSalemanure");
	ArrayList arrSaleBag = (ArrayList) hshValues.get("arrSalebag");
	ArrayList arrSalesEgg = (ArrayList) hshValues.get("arrSalesEgg");
	ArrayList arrSaleprManur = (ArrayList) hshValues.get("arrSaleprManur");
	ArrayList arrSaleprEmpty = (ArrayList) hshValues.get("arrSaleprEmpty");
	

	double expyear1 = Double.parseDouble(Helper.correctDouble((String) hshValues.get("totiyearlastexp")));
	double expyear2 = Double.parseDouble(Helper.correctDouble((String) hshValues.get("totiiyearlastexp")));
	double expyear3 = Double.parseDouble(Helper.correctDouble((String) hshValues.get("totiiiyearlastexp")));
	double expyear4 = Double.parseDouble(Helper.correctDouble((String) hshValues.get("totivyearlastexp")));
	double expyear5 = Double.parseDouble(Helper.correctDouble((String) hshValues.get("totvyearlastexp")));

	String exp1 = "";
	String exp2 = "";
	String exp3 = "";
	String exp4 = "";
	String exp5 = "";
	String exp6 = "";

	String exp11 = "";
	String exp12 = "";
	String exp13 = "";
	String exp14 = "";
	String exp15 = "";
	String exp16 = "";

	String exp21 = "";
	String exp22 = "";
	String exp23 = "";
	String exp33 = "";
	String exp34 = "";
	String exp35 = "";
	String strTypePoultry =Helper.correctNull((String)hshValues.get("poultry_poultrytype"));	
%>

<%
	//double totincome=

	if (arryRow1 != null && arryRow1.size() > 0) {
		arryCol1 = (ArrayList) arryRow1.get(0);

		if (arryCol1 != null && arryCol1.size() != 0) {
			exp1 = Helper.correctNull((String) arryCol1.get(0));
			exp2 = Helper.correctNull((String) arryCol1.get(1));
			exp3 = Helper.correctNull((String) arryCol1.get(2));
			exp4 = Helper.correctNull((String) arryCol1.get(3));
			exp5 = Helper.correctNull((String) arryCol1.get(5));
			exp6 = Helper.correctNull((String) arryCol1.get(6));
		}
	}

	else {
		exp1 = "";
		exp2 = "";
		exp3 = "";
		exp4 = "";
		exp5 = "";
		exp6 = "";
	}

	if (arryRow1 != null && arryRow1.size() > 1) {
		arryCol1 = (ArrayList) arryRow1.get(1);

		if (arryCol1 != null && arryCol1.size() > 0) {
			exp11 = Helper.correctNull((String) arryCol1.get(0));
			exp12 = Helper.correctNull((String) arryCol1.get(1));
			exp13 = Helper.correctNull((String) arryCol1.get(2));
			exp14 = Helper.correctNull((String) arryCol1.get(3));
			exp15 = Helper.correctNull((String) arryCol1.get(5));
			exp16 = Helper.correctNull((String) arryCol1.get(6));
		}
	}

	else {
		exp11 = "";
		exp12 = "";
		exp13 = "";
		exp14 = "";
		exp15 = "";
		exp16 = "";
	}

	if (arryRow1 != null && arryRow1.size() > 2) {
		arryCol1 = (ArrayList) arryRow1.get(2);

		if (arryCol1 != null && arryCol1.size() > 0) {
			exp21 = Helper.correctNull((String) arryCol1.get(0));
			exp22 = Helper.correctNull((String) arryCol1.get(1));
			exp23 = Helper.correctNull((String) arryCol1.get(2));
			exp33 = Helper.correctNull((String) arryCol1.get(3));
			exp34 = Helper.correctNull((String) arryCol1.get(5));
			exp35 = Helper.correctNull((String) arryCol1.get(6));
		}
	}
	else {
		exp21 = "";
		exp22 = "";
		exp23 = "";
		exp33 = "";
		exp34 = "";
		exp35 = "";
	}
	
	String schemetype = Helper.correctNull((String)request.getParameter("schemetype"));
	if(schemetype. trim().equalsIgnoreCase(""))
		{
			schemetype="0";
		}
	String strFacSNo=Helper.getfacilitySno(schemetype);
	
	java.text.NumberFormat nf = java.text.NumberFormat
	.getNumberInstance();
	nf.	setGroupingUsed(false);
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
%>

<html>
<head>
<title>Broiler Income</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>

var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var  nodata="<%=Helper.correctNull((String) hshValues.get("nodata"))%>";
var strUserMode="<%=Helper.correctNull((String) hshValues.get("strUserMode"))%>";
var schemetype="<%=schemetype%>";

function loading()
{	
	document.forms[0].cmdclose.disabled=false;
	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value=schemetype;
	disableFields(true);
}
function disableFields(one)
{	
	for(var s=0;s<document.forms[0].length;s++)
	{
		if(document.forms[0].elements[s].type=="text")
		{
			document.forms[0].elements[s].readOnly=one;
		}	  
	   if(document.forms[0].elements[s].type=="textarea")
		{
			document.forms[0].elements[s].readOnly=one;		  
		}		
	}	
	
	
}
function doEdit()
{   
    enableButtons(true,false,false,false);	
}

function enableButtons(bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdapply.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddel.disabled=bool5;
	
}

function doApply()
{
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hidBeanId.value="agriloanassessment";
	document.forms[0].hidBeanMethod.value="updatepoultrybroiincomeflowData";
	document.forms[0].hidBeanGetMethod.value="getpoultrybroiincomeflowData";
	document.forms[0].hidSourceUrl.value="action/agr_poultry_broilerinc.jsp";
	document.forms[0].action=appUrl+"action/ControllerServlet";
	document.forms[0].submit();	
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agriloanassessment";
		document.forms[0].hidBeanGetMethod.value="getpoultrybroiincomeflowData";
		document.forms[0].action=appUrl +"action/agr_poultry_broilerinc.jsp";
		document.forms[0].submit(); 		
	}		
}

function doClose()
{
	if( ConfirmMsg(100))
	{
		parent.menuFrame.doWindowClose();
	}
}

</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="loading()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()" onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" ><script language="JavaScript1.2">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div>
</div>
<form name="frminc" method="post" class="normal">

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
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
      <td class="page_flow">Home -> Agriculture -> State of Income</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="103" />
			<jsp:param name="pageid" value="<%=schemetype%>"/>
		</jsp:include></td>
	</tr>
</table>

<table width="98%" border="0" cellspacing="0" cellpadding="5" class="shadow outertable border1" align="center" >
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table width="90%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable border1">
			<tr>
				<td width="43%" rowspan="2" nowrap class="dataheader"><b>Income
				On</b></td>
				<td colspan="5" align="center" height="20" class="dataheader"><b>(Amount
				in <%=ApplicationParams.getCurrency()%>)</b></td>
			</tr>
			<tr>
				<td align="center" width="22%" height="9" class="dataheader"><b>
				I Year</b></td>
				<td align="center" width="20%" height="9" class="dataheader"><b>
				II Year</b></td>
				<td align="center" width="20%" height="9" class="dataheader"><b>
				III Year</b></td>
				<td align="center" width="20%" height="9" class="dataheader"><b>
				IV Year</b></td>
				<td align="center" width="15%" height="9" class="dataheader"><b>
				V Year(Onwards)</b></td>
			</tr>
			<%if(arrSalBird!=null && arrSalBird.size()>0){ %>
			<tr class="datagrid">
				<td width="43%">Sale of Birds</td>
				<td width="22%" align="center"><input type="text"
					name="txt_broiler1" size="20" readonly
					value="<%=Helper.correctNull((String) arrSalBird.get(0))%>"
					style="text-align: right"></td>
				<td width="20%" align="center"><input type="text"
					name="txt_broiler2" size="20" readonly
					value="<%=Helper.correctNull((String) arrSalBird.get(1))%>"
					style="text-align: right"></td>
				<td width="15%" align="center"><input type="text"
					name="txt_broiler3" size="20" readonly
					value="<%=Helper.correctNull((String) arrSalBird.get(2))%>"
					style="text-align: right"></td>
					<td width="15%" align="center"><input type="text"
					name="txt_broiler3" size="20" readonly
					value="<%=Helper.correctNull((String) arrSalBird.get(3))%>"
					style="text-align: right"></td>
					<td width="15%" align="center"><input type="text"
					name="txt_broiler3" size="20" readonly
					value="<%=Helper.correctNull((String) arrSalBird.get(4))%>"
					style="text-align: right"></td>
			</tr>
			<%} %>
			
			<%
			if(!strTypePoultry.equalsIgnoreCase("1")){	
				if(arrSaleManure!=null && arrSaleManure.size()>0){
	        %>
			
			<tr class="datagrid">
				<td width="43%">Sale Price of Manure</td>
				<td width="22%" align="center"><input type="text"
					name="txt_manure1" size="20" readonly
					value="<%=Helper.correctNull((String) arrSaleManure.get(0))%>"
					style="text-align: right"></td>
				<td width="20%" align="center"><input type="text"
					name="txt_manure2" size="20" readonly
					value="<%=Helper.correctNull((String) arrSaleManure.get(1))%>"
					style="text-align: right"></td>
				<td width="15%" align="center"><input type="text"
					name="txt_manure3" size="20" readonly
					value="<%=Helper.correctNull((String) arrSaleManure.get(2))%>"
					style="text-align: right"></td>
					<td width="15%" align="center"><input type="text"
					name="txt_manure3" size="20" readonly
					value="<%=Helper.correctNull((String) arrSaleManure.get(3))%>"
					style="text-align: right"></td>
					<td width="15%" align="center"><input type="text"
					name="txt_manure3" size="20" readonly
					value="<%=Helper.correctNull((String) arrSaleManure.get(4))%>"
					style="text-align: right"></td>
			</tr>
			<%}
				if(arrSaleBag!=null && arrSaleBag.size()>0){%>
			<tr class="datagrid">
				<td width="43%">Sale Price of Empty Bags</td>
				<td width="22%" align="center"><input type="text"
					name="txt_gunny1" size="20" readonly
					value="<%=Helper.correctNull((String) arrSaleBag.get(0))%>"
					style="text-align: right"></td>
				<td width="20%" align="center"><input type="text"
					name="txt_gunny2" size="20" readonly
					value="<%=Helper.correctNull((String) arrSaleBag.get(1))%>"
					style="text-align: right"></td>
				<td width="15%" align="center"><input type="text"
					name="txt_gunny3" size="20" readonly
					value="<%=Helper.correctNull((String) arrSaleBag.get(2))%>"
					style="text-align: right"></td>
				<td width="15%" align="center"><input type="text"
					name="txt_gunny3" size="20" readonly
					value="<%=Helper.correctNull((String) arrSaleBag.get(3))%>"
					style="text-align: right"></td>
				<td width="15%" align="center"><input type="text"
					name="txt_gunny3" size="20" readonly
					value="<%=Helper.correctNull((String) arrSaleBag.get(4))%>"
					style="text-align: right"></td>
			</tr>
			<%} }%>
			<!--arrSalesEgg  -->
			<%
				if(arrSalesEgg!=null && arrSalesEgg.size()>0){
	        %>
			<tr class="datagrid">
				<td width="43%">Sale of Eggs</td>
				<td width="22%" align="center"><input type="text"
					name="txt_saleofeggs1" size="20" readonly
					value="<%=Helper.correctNull((String) arrSalesEgg.get(0))%>"
					style="text-align: right"></td>
				<td width="20%" align="center"><input type="text"
					name="txt_saleofeggs2" size="20" readonly
					value="<%=Helper.correctNull((String) arrSalesEgg.get(1))%>"
					style="text-align: right"></td>
				<td width="15%" align="center"><input type="text"
					name="txt_saleofeggs3" size="20" readonly
					value="<%=Helper.correctNull((String) arrSalesEgg.get(2))%>"
					style="text-align: right"></td>
				<td width="15%" align="center"><input type="text"
					name="txt_saleofeggs3" size="20" readonly
					value="<%=Helper.correctNull((String) arrSalesEgg.get(3))%>"
					style="text-align: right"></td>
				<td width="15%" align="center"><input type="text"
					name="txt_saleofeggs3" size="20" readonly
					value="<%=Helper.correctNull((String) arrSalesEgg.get(4))%>"
					style="text-align: right"></td>
			</tr>
			<%} %>
			<!--  -->
			<tr class="datagrid">
				<td width="43%">&nbsp;<%=exp1%></td>
				<td width="22%" align="center"><input type="text"
					name="txt_other1year1" size="20" readonly
					value="<%=Helper.checkDecimal(exp2)%>" style="text-align: right">
				</td>
				<td width="20%" align="center"><input type="text"
					name="txt_other1year2" size="20" readonly
					value="<%=Helper.checkDecimal(exp3)%>" style="text-align: right">
				</td>
				<td width="15%" align="center"><input type="text"
					name="txt_other1year3" size="20" readonly
					value="<%=Helper.checkDecimal(exp4)%>" style="text-align: right">
				</td>
				<td width="15%" align="center"><input type="text"
					name="txt_other1year3" size="20" readonly
					value="<%=Helper.checkDecimal(exp5)%>" style="text-align: right">
				</td>
				<td width="15%" align="center"><input type="text"
					name="txt_other1year3" size="20" readonly
					value="<%=Helper.checkDecimal(exp6)%>" style="text-align: right">
				</td>
			</tr>
			<tr class="datagrid">
				<td width="43%">&nbsp;<%=exp11%></td>
				<td width="22%" align="center"><input type="text"
					name="txt_other2year1" size="20" readonly
					value="<%=Helper.checkDecimal(exp12)%>" style="text-align: right">
				</td>
				<td width="20%" align="center"><input type="text"
					name="txt_other2year2" size="20" readonly
					value="<%=Helper.checkDecimal(exp13)%>" style="text-align: right">
				</td>
				<td width="15%" align="center"><input type="text"
					name="txt_other2year3" size="20" readonly
					value="<%=Helper.checkDecimal(exp14)%>" style="text-align: right">
				</td>
				<td width="15%" align="center"><input type="text"
					name="txt_other2year3" size="20" readonly
					value="<%=Helper.checkDecimal(exp15)%>" style="text-align: right">
				</td>
				<td width="15%" align="center"><input type="text"
					name="txt_other2year3" size="20" readonly
					value="<%=Helper.checkDecimal(exp16)%>" style="text-align: right">
				</td>
			</tr>
			<tr class="datagrid">
				<td width="43%">&nbsp;<%=exp21%></td>
				<td width="22%" align="center"><input type="text"
					name="txt_other3year1" size="20" readonly
					value="<%=Helper.checkDecimal(exp22)%>" style="text-align: right">
				</td>
				<td width="20%" align="center"><input type="text"
					name="txt_other3year2" size="20" readonly
					value="<%=Helper.checkDecimal(exp23)%>" style="text-align: right">
				</td>
				<td width="15%" align="center"><input type="text"
					name="txt_other3year3" size="20" readonly
					value="<%=Helper.checkDecimal(exp33)%>" style="text-align: right">
				</td>
				<td width="15%" align="center"><input type="text"
					name="txt_other3year3" size="20" readonly
					value="<%=Helper.checkDecimal(exp34)%>" style="text-align: right">
				</td>
				<td width="15%" align="center"><input type="text"
					name="txt_other3year3" size="20" readonly
					value="<%=Helper.checkDecimal(exp35)%>" style="text-align: right">
				</td>
			</tr>
			
		
			
			<tr >
				<td width="43%" class="dataheader" align="center"><b>Total(Income)</b></td>
				<td width="22%" align="center" class="dataheader"><input
					type="text" name="txt_inc1" size="20" readonly
					value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("totalIncome1"))))%>"
					maxlength="12" style="text-align: right" /></td>
				<td width="20%" align="center" class="dataheader"><input
					type="text" name="txt_inc2" size="20" readonly
					value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("totalIncome2"))))%>"
					style="text-align: right"></td>
				<td width="15%" align="center" class="dataheader"><input
					type="text" name="txt_inc3" size="20" readonly
					value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("totalIncome3"))))%>"
					style="text-align: right"></td>
				<td width="15%" align="center" class="dataheader"><input
					type="text" name="txt_inc3" size="20" readonly
					value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("totalIncome4"))))%>"
					style="text-align: right"></td>
				<td width="15%" align="center" class="dataheader"><input
					type="text" name="txt_inc3" size="20" readonly
					value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("totalIncome5"))))%>"
					style="text-align: right"></td>
			</tr>
			<tr>
				<td width="43%" class="dataheader" align="center"><b>Total(Expenses)</b></td>
				<td width="22%" align="center" class="dataheader"><input
					type="text" name="txt_exp1" size="20" readonly
					style="text-align: right"
					value="<%=nf.format(Double.parseDouble(Helper.correctDouble(String.valueOf(expyear1))))%>">
				</td>
				<td width="20%" align="center" class="dataheader"><input
					type="text" name="txt_exp2" size="20" readonly
					style="text-align: right"
					value="<%=nf.format(Double.parseDouble(Helper.correctDouble(String.valueOf(expyear2))))%>">
				</td>
				<td width="15%" align="center" class="dataheader"><input
					type="text" name="txt_exp3" size="20" readonly
					style="text-align: right"
					value="<%=nf.format(Double.parseDouble(Helper.correctDouble(String.valueOf(expyear3))))%>">
				</td>
				<td width="15%" align="center" class="dataheader"><input
					type="text" name="txt_exp3" size="20" readonly
					style="text-align: right"
					value="<%=nf.format(Double.parseDouble(Helper.correctDouble(String.valueOf(expyear3))))%>">
				</td>
				<td width="15%" align="center" class="dataheader"><input
					type="text" name="txt_exp3" size="20" readonly
					style="text-align: right"
					value="<%=nf.format(Double.parseDouble(Helper.correctDouble(String.valueOf(expyear3))))%>">
				</td>
			</tr>
			<tr>
				<td width="43%" class="dataheader" align="center"><b>Surplus</b></td>
				<td width="22%" align="center" class="dataheader"><input
					type="text" name="txt_sur1" size="20" readonly
					style="text-align: right"
					value="<%=nf.format(Double.parseDouble(Helper.correctDouble(Helper.checkDecimal((String) hshValues.get("surplus1")))))%>">
				</td>
				<td width="20%" align="center" class="dataheader"><input
					type="text" name="txt_sur2" size="20" readonly
					style="text-align: right"
					value="<%=nf.format(Double.parseDouble(Helper.correctDouble(Helper.checkDecimal((String) hshValues.get("surplus2")))))%>">
				</td>
				<td width="15%" align="center" class="dataheader"><input
					type="text" name="txt_sur3" size="20" readonly
					style="text-align: right"
					value="<%=nf.format(Double.parseDouble(Helper.correctDouble(Helper.checkDecimal((String) hshValues.get("surplus3")))))%>">
				</td>
				<td width="15%" align="center" class="dataheader"><input
					type="text" name="txt_sur3" size="20" readonly
					style="text-align: right"
					value="<%=nf.format(Double.parseDouble(Helper.correctDouble(Helper.checkDecimal((String) hshValues.get("surplus4")))))%>">
				</td>
				<td width="15%" align="center" class="dataheader"><input
					type="text" name="txt_sur3" size="20" readonly
					style="text-align: right"
					value="<%=nf.format(Double.parseDouble(Helper.correctDouble(Helper.checkDecimal((String) hshValues.get("surplus5")))))%>">
				</td>
			</tr>
		</table>
		</td>
	</tr>	
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>

<br>

<table width="100%">
	<tr align="center">
		<td><input type="button" name="cmdclose" value="Close" class="buttonClose" onClick="doClose()"></td>
	</tr>
</table>

<input type="hidden" name="cmdsave" disabled>
<input
	type="hidden" name="hidBeanId" value=""> 
	 <input type="hidden"
	name="hidBeanGetMethod" value="">
	<input type="hidden" name="hidFacSNo" value="<%=strFacSNo%>">
</form>
</body>
</html>