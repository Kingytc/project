<%@ page import="com.sai.fw.management.utils.*"%>
<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<%@include file="../share/directives.jsp"%>
<% 
ArrayList arryCol=new ArrayList();
ArrayList arryRow = new ArrayList();
if(hshValues!=null)
{
 	arryRow=(ArrayList)hshValues.get("arrData"); 	
}
String schemetype = Helper.correctNull((String)request.getParameter("schemetype"));
if(schemetype. trim().equalsIgnoreCase(""))
{
	schemetype="0";
}
String strtotamt=Helper.correctNull((String)hshValues.get("agr_total"));

%>
<html>
<head>
<title>Sericulture</title>
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
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
</script>
<script>

function onloading()
{	
	disableFields(true);	
	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value="<%=schemetype%>";
	var strUserMode="";
	strUserMode=document.forms[0].hidUsrMode.value;
	document.forms[0].txt_yieldrear.disabled=true;
	document.forms[0].txt_yieldacre.disabled=true;
	document.forms[0].txt_grossinc.disabled=true;
	document.forms[0].txt_inccarry.disabled=true;
	document.forms[0].txt_expensecarry.disabled=true;
	document.forms[0].txt_netgrossinc.disabled=true;
//	document.forms[0].txt_nonrecexp.disabled=true;
	document.forms[0].txt_recexp.disabled=true;
	document.forms[0].txt_netinc.disabled=true;
	calculate();
}

function enableButtons(bool1, bool2, bool3, bool4, bool5, bool6)
{
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled = bool6;
}
function doSave()
{   

	document.forms[0].txt_yieldrear.disabled=false;
	document.forms[0].txt_yieldacre.disabled=false;
	document.forms[0].txt_grossinc.disabled=false;
	document.forms[0].txt_inccarry.disabled=false;
	document.forms[0].txt_expensecarry.disabled=false;
	document.forms[0].txt_netgrossinc.disabled=false;
	//document.forms[0].txt_nonrecexp.disabled=false;
	document.forms[0].txt_recexp.disabled=false;
	document.forms[0].txt_netinc.disabled=false;
	
	
	enableButtons(true, true, true, true, true, false);
	document.forms[0].hidBeanId.value="agreconomic";		
	document.forms[0].hidSourceUrl.value="/action/agr_sericultureincstatement.jsp";
	document.forms[0].hidBeanMethod.value="updateSericultureIncomeStatement";
	document.forms[0].hidBeanGetMethod.value="getSericultureIncomeStatement";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
	
}
function doEdit()
{
 	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	enableButtons(true, true, false, false, false, true);	
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agreconomic";
		document.forms[0].hidBeanGetMethod.value="getSericultureIncomeStatement";
		document.forms[0].action=appUrl+"action/agr_sericultureincstatement.jsp";
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
	 	if(document.forms[0].elements[i].type=='checkbox')
	 	{
			document.forms[0].elements[i].disabled=one;
	 	}
	 	if(document.forms[0].elements[i].type=='textarea')
	 	{
	 		document.forms[0].elements[i].readOnly=one;
	 	}
		  
	}
}


function doDelete()
{
	
		if(ConfirmMsg(101))
		{
			document.forms[0].hidAction.value ="delete";
			document.forms[0].action=appUrl+"action/ControllerServlet";	
			document.forms[0].hidBeanId.value="agreconomic";
			document.forms[0].hidBeanMethod.value="updateSericultureIncomeStatement";
			document.forms[0].hidBeanGetMethod.value="getSericultureIncomeStatement";
			document.forms[0].hidSourceUrl.value="/action/agr_sericultureincstatement.jsp";
			document.forms[0].method="post";			
			document.forms[0].submit();	
		}
	
}

function calculate()
{
	var vardisfree=document.forms[0].txt_disfree.value;
	if(vardisfree == "")
	{
		vardisfree=0;
	}

	var varyieldfl=document.forms[0].txt_yieldfl.value;
	if(varyieldfl == "")
	{
		varyieldfl=0;
	}

	var vartot=(parseFloat(vardisfree)/100)*parseFloat(varyieldfl);
	var varyieldrear = document.forms[0].txt_yieldrear.value;
	if(varyieldrear == "")
	{
		varyieldrear=0;
	}
	
	document.forms[0].txt_yieldrear.value=roundVal(parseFloat(vartot));
	var varnorear=document.forms[0].txt_norear.value;
	if(varnorear == "")
	{
		varnorear=0;
	}
	
	var vartotyield=parseFloat(vartot)*parseFloat(varnorear);
	document.forms[0].txt_yieldacre.value=roundVal(parseFloat(vartotyield));
	var varsalecocoon=document.forms[0].txt_pricecocoon.value;
	if(varsalecocoon == "")
	{
		varsalecocoon=0;
	}

	var vargrossinc = parseFloat(vartotyield)*parseFloat(varsalecocoon);
	document.forms[0].txt_grossinc.value=roundVal(parseFloat(vargrossinc));
	var vartotacre = document.forms[0].txt_totacres.value;
	if(vartotacre == "")
	{
		vartotacre=0;
	}

	var varinccarry = parseFloat(vartotacre) * parseFloat(vargrossinc);
	document.forms[0].txt_inccarry.value=roundVal(parseFloat(varinccarry));
	var vardlfamount = document.forms[0].txt_amount.value;
	if(vardlfamount == "")
	{
		vardlfamount=0;
	}
	
	var varmulcultivatexp=document.forms[0].txt_mulcultivatexp.value;

	if(varmulcultivatexp == "")
	{
		varmulcultivatexp=0;
	}

	var varsilkworm=document.forms[0].txt_silkworm.value;
	if(varsilkworm == "")
	{
		varsilkworm=0;
	}

	var vartotrear=document.forms[0].txt_norear.value;
	if(vartotrear == "")
	{
		vartotrear=0;
	}
	var varexp = ((parseFloat(vardisfree) * parseFloat(vardlfamount)) * parseFloat(vartotacre) * parseFloat(vartotrear)
	              +(parseFloat(vartotacre)*parseFloat(varmulcultivatexp))+(parseFloat(vartotacre)*parseFloat(varsilkworm)));

	
	document.forms[0].txt_expensecarry.value=roundVal(parseFloat(varexp));
	document.forms[0].txt_netgrossinc.value=roundVal(parseFloat(varinccarry));
    document.forms[0].txt_recexp.value=roundVal(parseFloat(varexp));

    //Net Income total

    var nonexp = 0;
    if(nonexp == '')
    {
        nonexp=0;
    }
    nettotal = parseFloat(varinccarry) - ( parseFloat(varexp));
    document.forms[0].txt_netinc.value=roundVal(parseFloat(nettotal));
    
}
</script>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading();">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5();"><script
	language="JavaScript1.2">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div>
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
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
      <td class="page_flow">Home -> Agriculture -> Project Cost</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="224" />
			<jsp:param name="schemetype" value="<%=schemetype%>" />
		</jsp:include></td>
	</tr>
</table>

 <table width="80%"  border="0" align="center" cellpadding="3" cellspacing="0"  class="outertable">
  <tr class="dataHeader">
  	  <td align="left" colspan="2">Recurring Expenditure Details</td>	 	
 </tr>
 </table>
 
    <table width="80%"  border="0" align="center" cellpadding="3" cellspacing="0"  class="outertable">
      <tr> 
        <td width="26%" nowrap="nowrap">Mulberry cultivation expenses <br>Per acres<b>*</b></td>
        <td width="23%"> 
          <lapschoice:CurrencyTag name="txt_mulcultivatexp" size="15" maxlength="15" onBlur="calculate();"
						style="text-align:right" value='<%=Helper.correctNull((String)hshValues.get("SERI_MULBERYEXP"))%>'/>
        </td>
        <td width="39%"> Silk Worm rearing expenses Per acres</td>
        <td width="12%"> 
          <lapschoice:CurrencyTag name="txt_silkworm" size="15" maxlength="15" onBlur="calculate();"
						style="text-align:right" 	value='<%=Helper.correctNull((String)hshValues.get("SERI_SILKWORM"))%>'/>
        </td>
      </tr>
      <tr> 
        <td width="26%">Cost of one DFL<br>
        </td>
        <td width="23%"> 
          <lapschoice:CurrencyTag name="txt_amount" size="15" maxlength="15"  onBlur="calculate();"
						style="text-align:right" value='<%=Helper.correctNull((String)hshValues.get("SERI_AMOUNT"))%>'/>
        </td>
        <td width="12%" style="visibility: hidden;"> 
          <lapschoice:CurrencyTag name="txt_expensecarry" size="15" maxlength="15" 
						style="text-align:right" value='<%=Helper.correctNull((String)hshValues.get("SERI_EXPCARRY"))%>'/>
        </td>
      </tr>
     
    </table>
    <br>
    <table width="80%"  border="0" align="center" cellpadding="3" cellspacing="0"  class="outertable">
  <tr class="dataHeader">
  	  <td align="left" colspan="2">Income Details</td>	 	
 </tr>
 </table>

  <table width="80%"  border="0" align="center" cellpadding="3" cellspacing="0"  class="outertable">
  
  <tr>
  	  <td width="26%">Total No. of acres<b>*</b></td>	
  	  <td width="23%"> 
        <lapschoice:CurrencyTag name="txt_totacres" size="15" maxlength="15" onBlur="calculate();"
						style="text-align:right" value='<%=Helper.correctNull((String)hshValues.get("SERI_TOTACRE"))%>'/>
      </td>
	  <td width="39%"> No. of Disease free layings / acre /per rearing <b>*</b> 
      </td>
	  <td width="12%"> 
        <lapschoice:CurrencyTag name="txt_disfree" size="15" maxlength="15"  onBlur="calculate();"
						style="text-align:right" 	value='<%=Helper.correctNull((String)hshValues.get("SERI_DISFREELAYING"))%>' />
      </td>	
 </tr>
 <tr>
  	  <td width="26%">Yield per 100 DFL<br>
      </td>	
  	  <td width="23%"> 
        <lapschoice:CurrencyTag name="txt_yieldfl" size="15" maxlength="15"  onBlur="calculate();"
						style="text-align:right" value='<%=Helper.correctNull((String)hshValues.get("SERI_YIELDDLF"))%>'/>
      </td>
	  <td width="39%"> Yield per rearing / acre </td>
	  <td width="12%"> 
        <lapschoice:CurrencyTag name="txt_yieldrear" size="15" maxlength="15" 
						style="text-align:right" value='<%=Helper.correctNull((String)hshValues.get("SERI_YIELDREARING"))%>'/>
      </td>	
 </tr>
 <tr>
  	  <td width="26%">No. of rearing per / year </td>	
  	  <td width="23%"> 
        <lapschoice:CurrencyTag  name="txt_norear" size="15" maxlength="15"  onBlur="calculate();"
						style="text-align:right" value='<%=Helper.correctNull((String)hshValues.get("SERI_NOREARING"))%>'/>
      </td>
	  <td width="39%"> Yield per acre</td>
	  <td width="12%"> 
        <lapschoice:CurrencyTag name="txt_yieldacre" size="15" maxlength="15" 
						style="text-align:right" value='<%=Helper.correctNull((String)hshValues.get("SERI_YIELDACRE"))%>'/>
      </td>	
 </tr>
 <tr>
  	  <td width="26%">Sale price of cocoon / kg</td>	
  	  <td width="23%"> 
        <lapschoice:CurrencyTag name="txt_pricecocoon" size="15"  maxlength="15"  onBlur="calculate();"
						style="text-align:right" value='<%=Helper.correctNull((String)hshValues.get("SERI_SALECOCOON"))%>'/>
      </td>
	  <td width="39%"> Gross income / acre</td>
	  <td width="12%"> 
        <lapschoice:CurrencyTag name="txt_grossinc" size="15" maxlength="15"  onBlur="calculate();"
						style="text-align:right" value='<%=Helper.correctNull((String)hshValues.get("SERI_CROSSINC"))%>'/>
      </td>	
 </tr>
 <tr>
 <td colspan="4" style="visibility: hidden;"> <lapschoice:CurrencyTag name="txt_inccarry" size="15" maxlength="15" onBlur="calculate();" 
						style="text-align:right" value='<%=Helper.correctNull((String)hshValues.get("SERI_INCCARRY"))%>'/></td>
 </tr>
 </table>
 <table width="80%"  border="0" align="center" cellpadding="3" cellspacing="0"  class="outertable">
  <tr class="dataHeader">
  	  <td align="left" colspan="2">Net Income Details</td>	 	
 </tr>
 </table>

    <table width="80%"  border="0" align="center" cellpadding="3" cellspacing="0"  class="outertable">
      <tr> 
        <td width="26%">Gross Income</td>
        <td width="23%"> 
          <lapschoice:CurrencyTag name="txt_netgrossinc" size="15" maxlength="15" 
						style="text-align:right" value='<%=Helper.correctNull((String)hshValues.get("SERI_INCCARRY"))%>' />
        </td>
       
      </tr>
      <tr> 
        <td width="26%">Recurring expenditure<br>
        </td>
        <td width="23%"> 
          <lapschoice:CurrencyTag name="txt_recexp" size="15" maxlength="15"  onBlur="calculate();"
						style="text-align:right" value='<%=Helper.correctNull((String)hshValues.get("SERI_EXPCARRY"))%>' />
        </td>
        <td width="39%">Net Income<br>
        </td>
        <td width="12%"> 
          <lapschoice:CurrencyTag name="txt_netinc" size="15" maxlength="15" 
						style="text-align:right" value='<%=Helper.correctNull((String)hshValues.get("SERI_NETINC"))%>' />
        </td>
      </tr>
     
    </table>
 
  	</td>	
  <br>
	<%String strappno =Helper.correctNull((String)hshValues.get("appno"));%> 
	<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete'	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
    <input type="hidden" name="hidBeanMethod" value="">
	<input type="hidden" name="hidBeanGetMethod" value="">
	<input type="hidden" name="hidBeanId" value="">
	<input type="hidden" name="hidSourceUrl" value="">
	<input type="hidden" name="hidAction" value="">
	<input type="hidden" name="hidUsrMode" value='<%=session.getAttribute("strUserMode")%>'>	
	
</form>
</body>
</html>
