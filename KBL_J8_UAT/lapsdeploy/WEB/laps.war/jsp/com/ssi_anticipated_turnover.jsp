<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="lapschoice"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<laps:handleerror />
<%
if (objValues instanceof java.util.HashMap) {
	hshValues = (java.util.HashMap) objValues;
}


String strCategoryType =Helper.correctNull((String)request.getParameter("cattype"));


%>
<html>
<head>
<title>Anticipated Turnover</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<STYLE>

DIV.cellContainer {	
  width: 100%; height: 250;
  overflow: auto;
}

</STYLE>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">

<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript"src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var genid = "<%//=strgenid%>";
function Help()
{
	  var varString = appUrl+"jsp/sethlp/hlp_ssiabove10expc.jsp"
	   var title = "Documents";
		var prop = "scrollbars=no,width=600,height=450";	
		prop = prop + ",left=50,top=150";
		window.open(varString,title,prop);
}


function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdapply.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;		 
	}
	
	if(val=="edit")
	{	 
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=false;
		 document.forms[0].cmdapply.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}
}


function onloading()
{	
	disableCommandButtons("load");
	
}
function onEdit()
{
	
	disableFields(false);
	document.forms[0].hidAction.value ="U";
	disableCommandButtons("edit");	
	

}
function disableFields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
	
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}	  
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}
		
	}	
}

function doSave()
{	
	disableCommandButtons("load");
	document.forms[0].hidBeanId.value="arrears";
	document.forms[0].hidSourceUrl.value="/action/ssi_anticipated_turnover.jsp";
	document.forms[0].hidBeanMethod.value="updateAnticipatedTurnover";
	document.forms[0].hidBeanGetMethod.value="getAnticipatedTurnover";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}

function OnDelete()
{
	document.forms[0].hidAction.value="D";
	if(!ConfirmMsg("101"))
	{
		return false;
	}
	document.forms[0].hidBeanId.value="arrears";
	document.forms[0].hidBeanMethod.value="updateAnticipatedTurnover";
	document.forms[0].hidSourceUrl.value="/action/ssi_anticipated_turnover.jsp";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();

}

function onCancel()
{	
	if(ConfirmMsg('102'))
	{
		document.forms[0].hidBeanId.value="arrears";
		document.forms[0].hidBeanGetMethod.value="getAnticipatedTurnover";		
		document.forms[0].action=appUrl+"action/ssi_anticipated_turnover.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
	disableCommandButtons("load");
}


function onClose()
{	
	 if(ConfirmMsg(100))
	 {
		window.close();
	 }
}


</script>

</head>

<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" class="bgcolor" onload="onloading()" bgcolor="#EEEAE3" >
<form name="fininc" method="post">

<jsp:include page="../share/help.jsp" flush="true"/> 

  
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr> 
            <td valign="top" colspan="5"><b><i><font face="Times New Roman, Times, serif" size="3"> 
 			</font></i></b></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
 
 <laps:application/> 

  <table width="100%" border="1" cellspacing="0" cellpadding="5" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" onMouseOver=" " height="350" class="outertablecolor">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF" height="100%" >
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="5">
                <tr> 
                  <td> 
                    <table width="100%" border="0" cellspacing="1" cellpadding="5">                     
                      <tr> 
                        <td colspan="3" align="left"><b>Working Capital Requirement for Anticipted 
                            Turnover </b>
                        </td>
                      </tr>                      
                  
                      <tr> 
                        <td bgcolor="#EEEAE3">Anticipated monthly turnover</td>
                        <td width="9%" align="center" bgcolor="#EEEAE3">Rs.</td>                        
                        <td width="29%" bgcolor="#EEEAE3"> 
                          <lapschoice:CurrencyTag  name="txt_MonthlyTurnover" size="15"  value='<%=Helper.correctNull((String)hshValues.get("MonthlyTurnover"))%>' maxlength="13" />
                        </td>
                      </tr>
                      <tr>                         
                        <td bgcolor="#EEEAE3" height="36">Cost of production per month
                        </td>
                        <td width="9%" align="center" bgcolor="#EEEAE3" height="36">Rs.</td>                        
                        <td width="29%" bgcolor="#EEEAE3" height="36"> 
                          <lapschoice:CurrencyTag name="txt_CostOfProduction"  size="15" value='<%=Helper.correctNull((String)hshValues.get("CostOfProduction"))%>' maxlength="13" />
                        </td>
                      </tr>
                      <tr>                       
                        <td bgcolor="#EEEAE3" height="36">Cost of raw-materials consumed per month</td>
                        <td width="9%" align="center" bgcolor="#EEEAE3" height="36">Rs.</td>                        
                        <td width="29%" bgcolor="#EEEAE3" height="36"> 
                          <lapschoice:CurrencyTag name="txt_CostOfRawConsumed"  size="15" value = '<%=Helper.correctNull((String)hshValues.get("CostOfRawConsumed"))%>' maxlength="13"/>
                        </td>
                      </tr>
                      <tr>                        
                        <td bgcolor="#EEEAE3" height="36">Average stocking of raw materials</td>
                        <td width="9%" align="center" bgcolor="#EEEAE3" height="36">&nbsp;</td>
                        <td bgcolor="#EEEAE3" height="36"> 
                          <input type="text" name="txt_AvgStockingOfRaw" onKeyPress="allowNumber(this)" size="15" maxlength="5" style="text-align:right" value ="<%=Helper.correctNull((String)hshValues.get("AvgStockingOfRaw"))%>" maxlength="10"/>month's requirement
                        </td>
                      </tr>
                      <tr>                        
                        <td bgcolor="#EEEAE3" height="36">Average period of processing</td>
                        <td width="9%" align="center" bgcolor="#EEEAE3" height="36">&nbsp;</td>
                        <td bgcolor="#EEEAE3" height="36"> 
                          <input type="text" name="txt_AvgPeriodOfProcessing" size="15" maxlength="5" onKeyPress="allowNumber(this)" style="text-align:right" value ="<%=Helper.correctNull((String)hshValues.get("AvgPeriodOfProcessing"))%>"/>weeks
                        </td>
                      </tr>                     
                      <tr> 
                        <td bgcolor="#EEEAE3">Average stocking of finished goods</td>
                        <td width="9%" align="center" bgcolor="#EEEAE3">&nbsp;</td>
                        <td bgcolor="#EEEAE3" height="36"> 
                          <input type="text" name="txt_AvgStockingOfFinishedGoods" onKeyPress="allowNumber(this)" size="15"  maxlength="5" style="text-align:right" value ="<%=Helper.correctNull((String)hshValues.get("AvgStockingOfFinishedGoods"))%>"/>week's production
                        </td>
                      </tr>
                      <tr>                        
                        <td bgcolor="#EEEAE3" height="36">Percentage of cash-sales in total sales</td>
                        <td width="9%" align="center" bgcolor="#EEEAE3" height="36">&nbsp;</td>
                        <td bgcolor="#EEEAE3" height="36"> 
                          <input type="text" name="txt_PercentOfCashInTotSales"  onKeyPress="allowNumber(this)" onBlur="checkPercentage(this)" style="text-align:right" size="15" value ="<%=Helper.correctNull((String)hshValues.get("PercentOfCashInTotSales"))%>" maxlength="11"/>%
                        </td>
                      </tr>
                      <tr>                        
                        <td bgcolor="#EEEAE3" height="36">Period in which payment is received, in respect of credit sales</td>
                        <td width="9%" align="center" bgcolor="#EEEAE3" height="36">&nbsp;</td>
                        <td bgcolor="#EEEAE3" height="36"> 
                          <input type="text" name="txt_PaymentPeriod" size="15" maxlength="5" onKeyPress="allowNumber(this)" style="text-align:right" value ="<%=Helper.correctNull((String)hshValues.get("PaymentPeriod"))%>"/>days
                        </td>
                      </tr>                     
                      <tr> 
                        <td bgcolor="#EEEAE3">Average credit available on purchase</td>
                        <td width="9%" align="center" bgcolor="#EEEAE3">&nbsp;</td>
                        <td bgcolor="#EEEAE3" height="36"> 
                          <input type="text" name="txt_AvgCreditAvailOnPurchase" size="15" maxlength="5" onKeyPress="allowNumber(this)" style="text-align:right" value ="<%=Helper.correctNull((String)hshValues.get("AvgCreditAvailOnPurchase"))%>"/>days
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
  <table border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center" class="outertablecolor">
    <tr  bordercolordark="#FFFFFB" bordercolorlight="#8F8369"> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="2" align="center" >
          <tr valign="top"> 
            <td width="14%"> 
              <div align="center"> 
                <input type="button" name="cmdedit" value="Edit" onClick="onEdit()" style="background-color:#8F8369;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50">
              </div>
            </td>
            <td width="14%"> 
              <div align="center"> 
                <input type="button" name="cmdapply" value="Save" onClick="doSave()" style="background-color:#8F8369;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50">
              </div>
            </td>
            <td width="14%"> 
              <div align="center"> 
                <input type="button" name="cmdcancel" value="Cancel" onClick="onCancel()" style="background-color:#8F8369;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50">
              </div>
            </td>
			 <td width="14%"> 
              <div align="center"> 
                <input type="button" name="cmddelete" value="Delete" onClick="OnDelete()" style="background-color:#8F8369;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50">
              </div>
            </td>            
            <td width="15%"> 
              <div align="center"> 
                <input type="button" name="cmdclose" value="Close" onClick="onClose()" style="background-color:#CC3300;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50">
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>

<input type="hidden" name="hidTabName" value="ExportDetails">
<input type="hidden" name="hidTotalDesc" value="10">
<input type="hidden" name="hidFieldPrefix" value="txt_exportproducts">
<INPUT TYPE="hidden" NAME="hidparam" value="">
<INPUT TYPE="hidden" NAME="hidMethod" value="">
<INPUT TYPE="hidden" NAME="hidGenID" value="">
<INPUT TYPE="hidden" NAME="hidAction" value="">
<input type="hidden" name="comapp_id" value="<%=request.getParameter("comapp_id")%>">
<INPUT TYPE="hidden" NAME="appno" value="<%=Helper.correctNull((String)hshValues.get("appno"))%>"> 
<INPUT TYPE="hidden" NAME="hidappno" value="<%=request.getParameter("appno")%>"> 


<input type="hidden" name="hidBeanId" >
<input type="hidden" name="hidBeanMethod">
<input type="hidden" name="hidBeanGetMethod" >
<input type="hidden" name="hidSourceUrl" >
<input type="hidden" name="otherGenTable" value="">
<input type="hidden" name="hidOtherMethod" >
 <input type="hidden" name="cattype" value="<%=strCategoryType%>"> 

</form>
</body>
</html>

