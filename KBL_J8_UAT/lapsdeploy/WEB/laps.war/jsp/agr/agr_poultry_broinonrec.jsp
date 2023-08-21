<%@ page import="com.sai.fw.management.utils.*"%>
<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@include file="../share/directives.jsp"%>

<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<%ArrayList arryCol = new ArrayList();
			ArrayList arryRow = new ArrayList();
			arryRow = (ArrayList) hshValues.get("arryRow");
			

			String l7 = "", l8 = "", l9 = "", l10 = "";//l1 = "", l2 = "", l3 = "", l4 = "", l5 = "", l6 = "",
			String l11 = "", l12 = "", l13 = "", l14 = "", l15 = "", l16 = "", l17 = "", l18 = "";
			String m1 = "", m2 = "", m3 = "", m4 = "", m5 = "", m6 = "", k1 = "", k2 = "", k3 = "", k4 = "", k5 = "", k6 = "";
			String r1 = "", r2 = "", r3 = "", r4 = "", r5 = "", r6 = "", r7 = "", r8 = "", r9 = "", r10 = "", r11 = "", r12 = "";
			String strOneEquipmentItem = "", strTwoEquipmentItem = "", strThreeEquipmentItem = "", strFourEquipmentItem = "";
			String strOneEquipmentItem1 = "", strTwoEquipmentItem2 = "", strThreeEquipmentItem3 = "", strFourEquipmentItem4 = "";
			String strappno = FwHelper.correctNull((String) request
					.getParameter("appno"));
			if (strappno.equalsIgnoreCase("new")) {
				strappno = "";
			}
			
			String schemetype = Helper.correctNull((String)request.getParameter("schemetype"));
			if(schemetype. trim().equalsIgnoreCase(""))
				{
					schemetype="0";
				}
			String strFacSNo=Helper.getfacilitySno(schemetype);

%>
<html>
<head>
<title>LAPS -Assesment Form Details</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>

<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var id ="";
var apptype="";

var currentDate = "<%=Helper.getCurrentDateTime()%>";
var  strid="<%=FwHelper.correctNull((String) hshValues.get("strid"))%>";
var  strAction="<%=FwHelper.correctNull((String) hshValues
									.get("strAction"))%>";
var strUserMode="<%=FwHelper.correctNull((String) hshValues
							.get("strUserMode"))%>";
var schemetype="<%=schemetype%>";

function doClose()
{
if( ConfirmMsg(100))
	{
		parent.menuFrame.doWindowClose();
	}
}

function disableFields(one)
{	
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=one;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}		
	}	
}

function doSave()
{	
   amount();amount1();callTotal();
	enableButtons( true, true, true, true, false);	
	
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hidBeanId.value="agriloanassessment";
	document.forms[0].hidSourceUrl.value="/action/agr_poultry_broinonrec.jsp";
	document.forms[0].hidBeanMethod.value="updatebroinonrecurringData";
	document.forms[0].hidBeanGetMethod.value="getbroinonrecurringData";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}

function doEdit()
{
 	disableFields(false);
 	for(var i=0;i<=5;i++)
 	{
	document.forms[0].txt_loanamount[i].readOnly =true;
   
	
	  document.forms[0].txt_cost[i].readOnly =true;
 	}
 	
	 document.forms[0]. txt_totalloanamount.readOnly =true; 
	 document.forms[0].hidAction.value ="insert";
	
	 enableButtons(true, false, false, false, false);	
}

function callhelp()
{
	var varQryString = appUrl+"/jsp/perhlp/hlp_edueducational.jsp"
	var title = "ApplicantDemographics";
	var prop = "scrollbars=no,width=600,height=450";	
	prop = prop + ",left=200,top=150";
	window.open(varQryString,title,prop);
}
 
function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agriloanassessment";
		document.forms[0].hidBeanGetMethod.value="getbroinonrecurringData";
		document.forms[0].action=appUrl+"action/agr_poultry_broinonrec.jsp";
		document.forms[0].submit(); 		
	}
}

function doDelete()
{
if(ConfirmMsg(101))
	{
	document.forms[0].hidAction.value ="delete";
	document.forms[0].action=appUrl+"action/ControllerServlet";		
	document.forms[0].hidBeanMethod.value="updatebroinonrecurringData";
	document.forms[0].hidBeanGetMethod.value="getbroinonrecurringData";
	document.forms[0].hidBeanId.value="agriloanassessment";
	document.forms[0].hidSourceUrl.value="action/agr_poultry_broinonrec.jsp";	
	document.forms[0].method="post";			
	document.forms[0].submit();		
	}
}

function onloading()
{	  
	enableButtons(false, true, true, true, false);
	disableFields(true);
	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value=schemetype;
	
}

function enableButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}

function amount()
{

for(var m=0;m<=5;m++)
{
var sqft=document.forms[0].txt_sq[m].value;
var value=document.forms[0].txt_value[m].value;
var unit=document.forms[0].txt_unit[m].value;
 if(sqft=="")
		{
	sqft=0;
			
		}
	if(value=="")
	{
	value=0;
		
	}
	if(unit=="")
	{
	unit=0;
		
	}
	
var amount=eval(sqft)*eval(value)
document.forms[0].txt_cost[m].value= Math.round(eval(amount));

document.forms[0].txt_loanamount[m].value=Math.round(eval(amount)*eval(unit));	
roundtxt(document.forms[0].txt_loanamount[m]);
}

}
function amount1()
{
for(var m=6;m<=9;m++)
     {
var val1 =document.forms[0].txt_unit[m].value;	 
var val2 =document.forms[0].txt_cost[m].value;	
  if( val1 =="")
		{
			 val1 =0.00;
			
		}
		 if( val2 =="")
		{
			 val2 =0.00;
			
		}
	 document.forms[0].txt_loanamount[m].value=eval(val1)*eval(val2);
	 roundtxt(document.forms[0].txt_loanamount[m]);
	 if(document.forms[0].txt_loanamount[m].value=="NaN")
	 {
	 document.forms[0].txt_loanamount[m].value=="0";
	 }	
	 }
}
function callTotal()
{

var totalvalue1=0.00;var totalvalue2=0.00;var totalvalue3=0.00;
for(var m=0;m<=9;m++)
     {
var value1 =document.forms[0].txt_loanamount[m].value;

      if( value1 =="")
		{
			 value1 =0.00;
			
		}
		
	totalvalue1 = eval(value1)+eval(totalvalue1)
	
     }

   document.forms[0].txt_totalloanamount.value= eval(totalvalue1);
   roundtxt(document.forms[0].txt_totalloanamount);
   
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
DIV.cellContainer {
	width: 100%;
	height: 250;
	overflow: auto;
}
</style>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="onloading();amount();amount1();callTotal()">
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
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
      <td class="page_flow">Home -> Agriculture -> Non Recurring Expense</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="99" />
			<jsp:param name="pageid" value="<%=schemetype%>"/>
		</jsp:include></td>
	</tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td valign="top">
		<table width="98%" border="0" cellspacing="0" cellpadding="5" class="shadow outertable border1" align="center" >

			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="1">
							<tr>
								<td colspan="13">
								<table width="100%" border="0" cellspacing="0" cellpadding="2">
									<tr>
										<td width="64%" class="dataheader" align="center"><b>Particulars</b></td>
										<td width="13%" align="center" class="dataheader"><b>No. of
										units</b></td>
										<td width="10%" align="center" class="dataheader"><b>Cost</b></td>
										<td width="13%" align="center" class="dataheader"><b>Amount
										</b></td>
									</tr>
									<tr>
										<td colspan="4" class="dataheader"><b>Other Civil Works</b></td>
									</tr>
									<tr class="datagrid">
										<%if (arryRow != null && arryRow.size() > 1) {
				arryCol = (ArrayList) arryRow.get(0);
				if (arryCol != null && arryCol.size() > 0) {
					l7 = FwHelper.correctNull((String) arryCol.get(2));
					l8 = FwHelper.correctNull((String) arryCol.get(3));
					m1 = FwHelper.correctNull((String) arryCol.get(1));
					k1 = FwHelper.correctNull((String) arryCol.get(4));
				}
			}
			/*else if (arryRow.size() == 0) 
			 {
			 l7 = "";
			 l8 = "";
			 m1 = "";
			 k1 = "";
			 }*/

			%>
										
										<td WIDTH="64%">Construction of <input type="text"
											name="txt_specify" size="15" maxlength="50" value="<%=m1%>"
											onKeyPress="">  measuring <input type="text"
											name="txt_sq" size="10" maxlength="6" value="<%=l7%>"
											onKeyPress="allowInteger()" onBlur="amount();callTotal()"
											style="text-align: left;"> sq ft @ <lapschoice:CurrencyTag
											name="txt_value" size="10" maxlength="6" value='<%=l8%>'
											onBlur="amount();callTotal()" /> per sq ft</td>
										<td WIDTH="13%" align="center"><input type="text"
											name="txt_unit" onFocus="" size="10" maxlength="3"
											value="<%=k1%>" onKeyPress="allowInteger()"
											onBlur="amount();callTotal()" style="text-align: left;"></td>
										<td WIDTH="10%" align="center"><input type="text"
											name="txt_cost" size="10" maxlength="15" value="0"
											onKeyPress="allowInteger()" style="text-align: right;"></td>
										<td WIDTH="13%" align="center"><lapschoice:CurrencyTag
											name="txt_loanamount" size="10" maxlength="15" value=""
											onKeyPress="allowInteger()" style="text-align:right;" /></td>
									    <td ><input type="hidden" name="txt_equipmentname"
											size="20" maxlength="50" ></td>
									</tr>
									<tr class="datagrid">
										<%if (arryRow != null && arryRow.size() > 2) {
				arryCol = (ArrayList) arryRow.get(1);

				if (arryCol!=null && arryCol.size() != 0) {

					l9 = FwHelper.correctNull((String) arryCol.get(2));
					l10 = FwHelper.correctNull((String) arryCol.get(3));
					m2 = FwHelper.correctNull((String) arryCol.get(1));
					k2 = FwHelper.correctNull((String) arryCol.get(4));
				}

			}

			%>
										<td WIDTH="64%">Construction of <input type="text"
											name="txt_specify" size="15" maxlength="50" value="<%=m2%>"
											onKeyPress="">  measuring <input type="text"
											name="txt_sq" size="10" maxlength="6" value="<%=l9%>"
											onKeyPress="allowInteger()" onBlur="amount();callTotal()"
											style="text-align: left;"> sq ft @ <lapschoice:CurrencyTag
											name="txt_value" size="10" maxlength="6" value='<%=l10%>'
											onBlur="amount();callTotal()" /> per sq ft</td>
										<td WIDTH="13%" align="center"><input type="text"
											name="txt_unit" onFocus="" size="10" maxlength="3"
											value="<%=k2%>" onKeyPress="allowInteger()"
											onBlur="amount();callTotal()" style="text-align: left;"></td>
										<td WIDTH="10%" align="center"><input type="text"
											name="txt_cost" size="10" maxlength="15" value="0"
											onKeyPress="allowInteger()" style="text-align: right;"></td>
										<td WIDTH="13%" align="center"><lapschoice:CurrencyTag
											name="txt_loanamount" size="10" maxlength="15" value=''
											onKeyPress="allowInteger()" style="text-align:right;" /></td>
									    <td><input type="hidden" name="txt_equipmentname" size="20" maxlength="50" ></td>
									</tr>
									<tr class="datagrid">
										<%if (arryRow != null && arryRow.size() > 3) {
				arryCol = (ArrayList) arryRow.get(2);
				if (arryCol!=null && arryCol.size() != 0) {
					l11 = FwHelper.correctNull((String) arryCol.get(2));
					l12 = FwHelper.correctNull((String) arryCol.get(3));
					m3 = FwHelper.correctNull((String) arryCol.get(1));
					k3 = FwHelper.correctNull((String) arryCol.get(4));
				}
			}

			%>
										<td WIDTH="64%">Construction of <input type="text"
											name="txt_specify" size="15" maxlength="50" value="<%=m3%>"
											onKeyPress="">  measuring <input type="text"
											name="txt_sq" size="10" maxlength="6" value="<%=l11%>"
											onKeyPress="allowInteger()" onBlur="amount();callTotal()"
											style="text-align: left;"> sq ft @ <lapschoice:CurrencyTag
											name="txt_value" size="10" maxlength="6" value='<%=l12%>'
											onBlur="amount();callTotal()" /> per sq ft</td>
										<td WIDTH="13%" align="center"><input type="text"
											name="txt_unit" size="10" maxlength="3" value="<%=k3%>"
											onKeyPress="allowInteger()" onBlur="amount();callTotal()"
											style="text-align: left;"></td>
										<td WIDTH="10%" align="center"><input type="text"
											name="txt_cost" size="10" maxlength="15" value="0"
											onKeyPress="allowInteger()" style="text-align: right;"></td>
										<td WIDTH="13%" align="center"><lapschoice:CurrencyTag
											name="txt_loanamount" size="10" maxlength="15" value=""
											onKeyPress="allowInteger()" style="text-align:right;" /></td>
										<td><input type="hidden" name="txt_equipmentname" size="20" maxlength="50" ></td>
									</tr>
									<tr class="datagrid">
										<%if (arryRow != null && arryRow.size() > 4) {
				arryCol = (ArrayList) arryRow.get(3);

				if (arryCol!=null && arryCol.size() != 0) {

					l13 = FwHelper.correctNull((String) arryCol.get(2));
					l14 = FwHelper.correctNull((String) arryCol.get(3));
					m4 = FwHelper.correctNull((String) arryCol.get(1));
					k4 = FwHelper.correctNull((String) arryCol.get(4));
				}

			}

			%>
										<td WIDTH="64%">Construction of <input type="text"
											name="txt_specify" size="15" maxlength="50" value="<%=m4%>"
											onKeyPress="">  measuring <input type="text"
											name="txt_sq" size="10" maxlength="6" value="<%=l13%>"
											onKeyPress="allowInteger()" onBlur="amount();callTotal()"
											style="text-align: left;"> sq ft @ <lapschoice:CurrencyTag
											name="txt_value" size="10" maxlength="6" value='<%=l14%>'
											onBlur="amount();callTotal()" /> per sq ft</td>
										<td WIDTH="13%" align="center"><input type="text"
											name="txt_unit" size="10" maxlength="3" value="<%=k4%>"
											onKeyPress="allowInteger()" onBlur="amount();callTotal()"
											style="text-align: left;"></td>
										<td WIDTH="10%" align="center"><input type="text"
											name="txt_cost" size="10" maxlength="15" value="0"
											onKeyPress="allowInteger()" style="text-align: right;"></td>
										<td WIDTH="13%" align="center"><lapschoice:CurrencyTag
											name="txt_loanamount" size="10" maxlength="15" value=""
											onKeyPress="allowInteger()" style="text-align:right;" /></td>
										<td><input type="hidden" name="txt_equipmentname" size="20" maxlength="50" ></td>
									</tr>
									<tr class="datagrid">
										<%if (arryRow != null && arryRow.size() > 5) {
				arryCol = (ArrayList) arryRow.get(4);

				if (arryCol!=null && arryCol.size() != 0) {

					l15 = FwHelper.correctNull((String) arryCol.get(2));
					l16 = FwHelper.correctNull((String) arryCol.get(3));
					m5 = FwHelper.correctNull((String) arryCol.get(1));
					k5 = FwHelper.correctNull((String) arryCol.get(4));
				}

			} /*else if (arryRow.size() == 0) {
			 l15 = "";
			 l16 = "";
			 m5 = "";
			 k5 = "";
			 }*/

			%>
										<td WIDTH="64%">Construction of <input type="text"
											name="txt_specify" size="15" maxlength="50" value="<%=m5%>"
											onKeyPress="">  measuring <input type="text"
											name="txt_sq" size="10" maxlength="6" value="<%=l15%>"
											onKeyPress="allowInteger()" onBlur="amount();callTotal()"
											style="text-align: left;"> sq ft @ <lapschoice:CurrencyTag
											name="txt_value" size="10" maxlength="6" value='<%=l16%>'
											onBlur="amount();callTotal()" /> per sq ft</td>
										<td WIDTH="13%" align="center"><input type="text"
											name="txt_unit" onFocus="" size="10" maxlength="5"
											value="<%=k5%>" onKeyPress="allowInteger()"
											onBlur="amount();callTotal()" style="text-align: left;"></td>
										<td WIDTH="10%" align="center"><input type="text"
											name="txt_cost" size="10" maxlength="15" value="0"
											onKeyPress="allowInteger()" style="text-align: right;"></td>
										<td WIDTH="13%" align="center"><lapschoice:CurrencyTag
											name="txt_loanamount" size="10" maxlength="15" value=""
											onKeyPress="allowInteger()" style="text-align:right;" /></td>
										<td><input type="hidden" name="txt_equipmentname" size="20" maxlength="50" ></td>
									</tr>
									<tr class="datagrid">
										<%if (arryRow != null && arryRow.size() > 6) {
				arryCol = (ArrayList) arryRow.get(5);

				if (arryCol!=null && arryCol.size() != 0) {

					l17 = FwHelper.correctNull((String) arryCol.get(2));
					l18 = FwHelper.correctNull((String) arryCol.get(3));
					m6 = FwHelper.correctNull((String) arryCol.get(1));
					k6 = FwHelper.correctNull((String) arryCol.get(4));
				}
			} /*else if (arryRow.size() == 0) {
			 l17 = "";
			 l18 = "";
			 m6 = "";
			 k6 = "";
			 }*/

			%>
										<td WIDTH="64%">Construction of <input type="text"
											name="txt_specify" size="15" maxlength="50" value="<%=m6%>"
											onKeyPress="">  measuring <input type="text"
											name="txt_sq" size="10" maxlength="6" value="<%=l17%>"
											onKeyPress="allowInteger()" onBlur="amount();callTotal()"
											style="text-align: left;"> sq ft @ <lapschoice:CurrencyTag
											name="txt_value" size="10" maxlength="6" value='<%=l18%>'
											onBlur="amount();callTotal()" /> per sq ft</td>
										<td WIDTH="13%" align="center"><input type="text"
											name="txt_unit" onFocus="" size="10" maxlength="5"
											value="<%=k6%>" onKeyPress="allowInteger()"
											onBlur="amount();callTotal()" style="text-align: left;"></td>
										<td WIDTH="10%" align="center"><input type="text"
											name="txt_cost" size="10" maxlength="15" value="0"
											onKeyPress="allowInteger()" style="text-align: right;"></td>
										<td WIDTH="13%" align="center"><lapschoice:CurrencyTag
											name="txt_loanamount" size="10" maxlength="15" value=""
											onKeyPress="allowInteger()" style="text-align:right;" /></td>
										<td><input type="hidden" name="txt_equipmentname" size="20" maxlength="50" ></td>
									</tr>
								</table>
								<table width="100%" border="0" cellspacing="1" cellpadding="2"
									class="outertable border1">
									<tr>
										<td colspan="5" class="dataheader"><b>Purchase of
										Equipments</b></td>
									</tr>
									<tr>
										<td width="33%" class="dataheader" align="center"><b>Name
										of Equipments</b></td>
										<td width="31%" class="dataheader" align="center"><b>Specifications</b></td>
										<td width="13%" class="dataheader" align="center"><b>No of
										units</b></td>
										<td width="10%" class="dataheader" align="center"><b>Cost
										per unit</b></td>
										<td width="13%" class="dataheader" align="center"><b>Amount</b></td>
									</tr>
									<tr class="datagrid">
										<%
										
				if (arryRow!=null && arryRow.size() != 0) {

				arryCol = (ArrayList) arryRow.get(6);

				if (arryCol!=null && arryCol.size() != 0) {

					r1 = FwHelper.correctNull((String) arryCol.get(4));
					r2 = FwHelper.correctNull((String) arryCol.get(5));
					r3 = FwHelper.correctNull((String) arryCol.get(6));
					strOneEquipmentItem = FwHelper
							.correctNull((String) arryCol.get(7));
					strOneEquipmentItem1 = FwHelper
					.correctNull((String) arryCol.get(1));
				}
			} else if (arryRow!=null && arryRow.size() == 0) {

				r1 = "";
				r2 = "";
				r3 = "";
			}

			%>
										<td WIDTH="33%" align="center"><input type="text" name="txt_equipmentname"
											size="20" maxlength="50" value="<%=strOneEquipmentItem%>"
											onKeyPress="" style="text-align: left;"></td>
										<td WIDTH="31%" align="center"><input type="text"
											name="txt_specify" size="20" maxlength="50" value="<%=strOneEquipmentItem1%>"
											onKeyPress="" style="text-align: left;"> <input type="hidden"
											name="txt_sq" size="10" maxlength="3" value=""
											onKeyPress="allowInteger()" onBlur="amount();callTotal()"
											style="text-align: left;"> <input type="hidden"
											name="txt_value" size="10" maxlength="15" value=""
											onKeyPress="allowInteger()" onBlur="amount();callTotal()"
											style="text-align: right;"></td>
										<td WIDTH="13%" align="center"><input type="text"
											name="txt_unit" size="10" maxlength="5" value="<%=r1%>"
											onKeyPress="allowInteger()" onBlur="amount1();callTotal()"
											style="text-align: left;"></td>
										<td WIDTH="10%" align="center"><input type="text"
											name="txt_cost" size="10" maxlength="10" value="<%=r2%>"
											onKeyPress="allowInteger()" onBlur="amount1();callTotal()"
											style="text-align: right;"></td>
										<td WIDTH="13%" align="center"><lapschoice:CurrencyTag
											name="txt_loanamount" size="10" maxlength="10" value="<%=r3%>" /></td>
									</tr>
									<tr class="datagrid">
										<%if (arryRow!=null && arryRow.size() != 0) {

				arryCol = (ArrayList) arryRow.get(7);

				if (arryCol!=null && arryCol.size() != 0) {

					r4 = FwHelper.correctNull((String) arryCol.get(4));
					r5 = FwHelper.correctNull((String) arryCol.get(5));
					r6 = FwHelper.correctNull((String) arryCol.get(6));
					strTwoEquipmentItem = FwHelper
							.correctNull((String) arryCol.get(7));
					strTwoEquipmentItem2 = FwHelper
					.correctNull((String) arryCol.get(1));

				}
			} else if (arryRow!=null && arryRow.size() == 0) {

				r4 = "";
				r5 = "";
				r6 = "";
			}

			%>
										<td WIDTH="33%" align="center"><input type="text" name="txt_equipmentname"
											size="20" maxlength="50" value="<%=strTwoEquipmentItem%>"
											onKeyPress="" style="text-align: left;"></td>
										<td WIDTH="31%" align="center"><input type="text"
											name="txt_specify" size="20" maxlength="50" value="<%=strTwoEquipmentItem2%>"
											onKeyPress="" style="text-align: left;"> <input type="hidden"
											name="txt_sq" size="10" maxlength="3" value=""
											onKeyPress="allowInteger()" onBlur="amount();callTotal()"
											style="text-align: left;"> <input type="hidden"
											name="txt_value" size="10" maxlength="15" value=""
											onKeyPress="allowInteger()" onBlur="amount();callTotal()"
											style="text-align: right;"></td>
										<td WIDTH="13%" align="center"><input type="text"
											name="txt_unit" size="10" maxlength="5" value="<%=r4%>"
											onKeyPress="allowInteger()" onBlur="amount1();callTotal()"
											style="text-align: left;"></td>
										<td WIDTH="10%" align="center"><input type="text"
											name="txt_cost" size="10" maxlength="10" value="<%=r5%>"
											onKeyPress="allowInteger()" onBlur="amount1();callTotal()"
											style="text-align: right;"></td>
										<td WIDTH="13%" align="center"><lapschoice:CurrencyTag
											name="txt_loanamount" size="10" maxlength="10" value="<%=r6%>" /></td>
									</tr>
									<tr class="datagrid">
										<%if (arryRow!=null && arryRow.size() != 0) {

				arryCol = (ArrayList) arryRow.get(8);

				if (arryCol!=null &&  arryCol.size() != 0) {

					r7 = FwHelper.correctNull((String) arryCol.get(4));
					r8 = FwHelper.correctNull((String) arryCol.get(5));
					r9 = FwHelper.correctNull((String) arryCol.get(6));
					strThreeEquipmentItem = FwHelper
							.correctNull((String) arryCol.get(7));
					strThreeEquipmentItem3 = FwHelper
					.correctNull((String) arryCol.get(1));

				}
			} else if (arryRow!=null && arryRow.size() == 0) {

				r7 = "";
				r8 = "";
				r9 = "";
			}

			%>
										<td WIDTH="33%" align="center"><input type="text" name="txt_equipmentname"
											size="20" maxlength="50" value="<%=strThreeEquipmentItem%>"
											onKeyPress="" style="text-align: left;"></td>
										<td WIDTH="31%" align="center"><input type="text"
											name="txt_specify" size="20" maxlength="50" value="<%=strThreeEquipmentItem3%>"
											onKeyPress="" style="text-align: left;"> <input type="hidden"
											name="txt_sq" size="10" maxlength="3" value=""
											onKeyPress="allowInteger()" onBlur="amount();callTotal()"
											style="text-align: left;"> <input type="hidden"
											name="txt_value" size="10" maxlength="15" value=""
											onKeyPress="allowInteger()" onBlur="amount();callTotal()"
											style="text-align: right;"></td>
										<td WIDTH="13%" align="center"><input type="text"
											name="txt_unit" size="10" maxlength="5" value="<%=r7%>"
											onKeyPress="allowInteger()" onBlur="amount1();callTotal()"
											style="text-align: left;"></td>
										<td WIDTH="10%" align="center"><input type="text"
											name="txt_cost" size="10" maxlength="10" value="<%=r8%>"
											onKeyPress="allowInteger()" onBlur="amount1();callTotal()"
											style="text-align: right;"></td>
										<td WIDTH="13%" align="center"><lapschoice:CurrencyTag
											name="txt_loanamount" size="10" maxlength="10" value="<%=r9%>" /></td>
									</tr>
									<tr class="datagrid">
										<%if (arryRow!=null && arryRow.size() != 0) {

				arryCol = (ArrayList) arryRow.get(9);

				if (arryCol!=null && arryCol.size() != 0) {

					r10 = FwHelper.correctNull((String) arryCol.get(4));
					r11 = FwHelper.correctNull((String) arryCol.get(5));
					r12 = FwHelper.correctNull((String) arryCol.get(6));
					strFourEquipmentItem = FwHelper.correctNull((String) arryCol.get(7));
					strFourEquipmentItem4 = FwHelper.correctNull((String) arryCol.get(1));
				}
			} else if (arryRow!=null && arryRow.size() == 0) {

				r10 = "";
				r11 = "";
				r12 = "";
			}

			%>
										<td WIDTH="33%" align="center"><input type="text" name="txt_equipmentname"
											size="20" maxlength="50" value="<%=strFourEquipmentItem%>"
											onKeyPress="" style="text-align: left;"></td>
										<td WIDTH="31%" align="center"><input type="text"
											name="txt_specify" size="20" maxlength="50" value="<%=strFourEquipmentItem4%>"
											onKeyPress="" style="text-align: left;"> <input type="hidden"
											name="txt_sq" size="10" maxlength="3" value=""
											onKeyPress="allowInteger()" onBlur="amount();callTotal()"
											style="text-align: left;"> <input type="hidden"
											name="txt_value" size="10" maxlength="15" value=""
											onKeyPress="allowInteger()" onBlur="amount();callTotal()"
											style="text-align: right;"></td>
										<td WIDTH="13%" align="center"><input type="text"
											name="txt_unit" size="10" maxlength="5" value="<%=r10%>"
											onKeyPress="allowInteger()" onBlur="amount1();callTotal()"
											style="text-align: left;"></td>
										<td WIDTH="10%" align="center"><input type="text"
											name="txt_cost" size="10" maxlength="10" value="<%=r11%>"
											onKeyPress="allowInteger()" onBlur="amount1();callTotal()"
											style="text-align: right;"></td>
										<td WIDTH="13%" align="center"><lapschoice:CurrencyTag
											name="txt_loanamount" size="10" maxlength="10" value="<%=r12%>" /></td>
									</tr>
									<tr class="dataheader">
										<td WIDTH="33%" align="center"><b>Total</b></td>
										<td WIDTH="31%">&nbsp;</td>
										<td WIDTH="13%">&nbsp;</td>
										<td WIDTH="10%" align="center">&nbsp;</td>
										<td><lapschoice:CurrencyTag name="txt_totalloanamount"
											size="15" maxlength="15" value="" onKeyPress="allowInteger()"
											style="text-align:right;" /></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
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
    <lapschoice:combuttonnew btnnames="Edit_Save_Delete_Cancel_Audit Trail"
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<input type="hidden" name="measurement"
	value="">
<input type="hidden" name="hidAction">
<input type="hidden" name="hidBeanId">
<input type="hidden" name="hidBeanMethod"> 
<input type="hidden" name="hidBeanGetMethod"> 
<input type="hidden" name="hidSourceUrl"> 
<input type="hidden" name="hidUsrMode"
	value="<%=session.getAttribute("strUserMode")%>">
<input type="hidden" name="hidFacSNo" value="<%=strFacSNo%>">
</form>
</body>
</html>
