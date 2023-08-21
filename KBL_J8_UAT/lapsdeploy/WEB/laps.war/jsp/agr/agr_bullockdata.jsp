<%@include file="../share/directives.jsp"%>
<%
String schemetype = Helper.correctNull((String)request.getParameter("schemetype"));
if(schemetype. trim().equalsIgnoreCase(""))
{
	schemetype="0";
}
%>
<html>
<head>
<title>Untitled Document</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var txt_others= "<%=Helper.correctNull((String)hshValues.get("txt_others"))%>"
var txt_manufacture = "<%=Helper.correctNull((String)hshValues.get("txt_manufacture"))%>" 
var sel_cart = "<%=Helper.correctNull((String)hshValues.get("sel_cart" ))%>" 
var txt_distance= "<%=Helper.correctNull((String)hshValues.get("txt_distance"))%>" 
var txt_costcart = "<%=Helper.correctNull((String)hshValues.get("txt_costcart"))%>" 
var txt_unitsize = "<%=Helper.correctNull((String)hshValues.get("txt_unitsize"))%>"  //chk
var txt_costbullock = "<%=Helper.correctNull((String)hshValues.get("txt_costbullock"))%>" 
var sel_scope = "<%=Helper.correctNull((String)hshValues.get("sel_scope"))%>" 
var txt_earnings1 = "<%=Helper.correctNull((String)hshValues.get("txt_earnings1"))%>"  
var txt_acre1 = "<%=Helper.correctNull((String)hshValues.get("txt_acre1"))%>"  
var txt_guntas1 = "<%=Helper.correctNull((String)hshValues.get("txt_guntas1"))%>"  
var txt_acre2 = "<%=Helper.correctNull((String)hshValues.get("txt_acre2"))%>"  
var txt_guntas2 = "<%=Helper.correctNull((String)hshValues.get("txt_guntas2"))%>"   
var txt_earnings2 = "<%=Helper.correctNull((String)hshValues.get("txt_earnings2"))%>"   
var txt_earnings3 = "<%=Helper.correctNull((String)hshValues.get("txt_earnings3"))%>";
var txt_noofcart="<%=Helper.correctNull((String)hshValues.get("txt_noofcart"))%>";
var txt_workdays="<%=Helper.correctNull((String)hshValues.get("txt_workdays"))%>";

</script>
<script>

function check()
{
	if(document.forms[0].sel_cart.value == "4")
	{
		document.all.r1.style.visibility="visible";
		document.all.r2.style.visibility="visible";
	}
	else
	{
		document.all.r1.style.visibility="hidden";
		document.all.r2.style.visibility="hidden";
		document.forms[0].txt_others.value="";
	}
}

function checkdays()
{
//var days=document.forms[0].txt_workdays.value;
//alert(days);
if(document.forms[0].txt_workdays.value > 365 || document.forms[0].txt_workdays.value < 0)
{
alert("No. of days cannot be greater than 365");
document.forms[0].txt_workdays.value="";
document.forms[0].txt_workdays.focus();
return;
}

}

function onloading()
{	  

	disableFields(true);
	
	if(sel_cart!="")
	{
		document.forms[0].sel_cart.value=sel_cart;
	}
	if(sel_scope!="")
	{
		document.forms[0].sel_scope.value=sel_scope;
	}
	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value="<%=schemetype%>";
	check();
	check1();	
	
		
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
//if(document.forms[0].txt_unitsize.value=="")
//{
//alert("Enter No. of Bullocks/Camels/Horses/Donkeys");
//document.forms[0].txt_unitsize.focus();
//return;
//}
var len = document.forms[0].sel_cart.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_cart.options[i].selected==true)
		 {
			 document.forms[0].sel_cart_text.value = document.forms[0].sel_cart.options[i].text; 
			break;
		 }
	}
    enableButtons(true, true, false, false, true, true);
	document.forms[0].hidBeanId.value="agriculture";		
	document.forms[0].hidSourceUrl.value="/action/agr_bullockdata.jsp";
	document.forms[0].hidBeanMethod.value="updatebullockdata";
	document.forms[0].hidBeanGetMethod.value="getbullockdata";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doEdit()
{
 	disableFields(false);
	document.forms[0].hideditflag.value ="Y";
	document.forms[0].hidAction.value ="insert";
	enableButtons(true, true, false, false, false, true);		
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agriculture";
		document.forms[0].hidBeanGetMethod.value="getbullockdata";
		document.forms[0].action=appURL+"action/agr_bullockdata.jsp";
		document.forms[0].submit(); 		
	}	
}



function doClose()
{
	if( ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
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
		  
	}
}

function check1()
{
 if(document.forms[0].sel_scope.value == "2" || document.forms[0].sel_scope.value == "3" || document.forms[0].sel_scope.value == "4")
	{
		document.all.r3.style.visibility="visible";
		
	}
	 else
	{
	  document.all.r3.style.visibility="hidden";
	  document.forms[0].txt_earnings1.value="";
	}
}
function doDelete()
{
var len = document.forms[0].sel_cart.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_cart.options[i].selected==true)
		 {
			 document.forms[0].sel_cart_text.value = document.forms[0].sel_cart.options[i].text; 
			break;
		 }
	}
	
	if( ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appURL+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updatebullockdata";
		document.forms[0].hidBeanGetMethod.value="getbullockdata";
		document.forms[0].hidBeanId.value="agriculture";
		document.forms[0].hidSourceUrl.value="action/agr_bullockdata.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}	
}


</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
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
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt;Agriculture -&gt; Application -&gt; Technical Data</td>
	</tr>
</table>
<lapschoice:borrowertype /> 
<lapschoice:application />
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="150" />
			<jsp:param name="schemetype" value="<%=schemetype%>" />
		</jsp:include></td>
	</tr>
</table>
<table  width="100%"  border="0" cellpadding="3" cellspacing="1s" align="center" class="outertable border1">
<tr>
<td>
  <table width="100%"  border="0" cellpadding="3" cellspacing="1" align="center" class="outertable">
    <tr> 
      <td width="45%">Type/Model of cart</td>
      <td> 
        <select name="sel_cart" onChange="check();check1()">
          <option value="0" selected="selected">select</option>
          <option value="1">Conventional</option>
          <option value="2">Pneumatic Tyre</option>
          <option value="3">Wooden / Iron Rimmed Wheels</option>
          <option value="4">Others</option>
        </select>
      </td>
      <td width="13%" nowrap="nowrap" id="r1">If Others Specify </td>
	  <td nowrap="nowrap"  id="r2"><input type="text" name="txt_others"  value="<%=Helper.correctNull((String)hshValues.get("txt_others"))%>"  size="20%" onKeyPress="notAllowSplChar()" maxlength="15"></td>
    </tr>
    
   <!--  <tr> 
      <td width="45%">Place of Manufacture of Cart</td>
      <td><input type="text" name="txt_manufacture"  value="<%=Helper.correctNull((String)hshValues.get("txt_manufacture"))%>"  size="20%" onKeyPress="notAllowSplChar()" maxlength="15"></td>
      <td nowrap="nowrap" width="13%">Distance From Branch <br></td>
	  <td><input type="text" name="txt_distance"  value="<%=Helper.correctNull((String)hshValues.get("txt_distance"))%>"  size="12%" onKeyPress="allowNumber(this)" maxlength="6">&nbsp;Km</td>
    </tr>
    <tr> 
      <td width="45%"> No. of Carts</td>
      <td><input type="text" name="txt_noofcart"  value='<%=Helper.correctNull((String)hshValues.get("txt_unitsize"))%>'  size="15%"  onKeyPress="allowInteger()" maxlength="8" /></td>
      <td width="13%" >Unit Cost of Cart</td>
      <td width="34%"><lapschoice:CurrencyTag name="txt_costcart"  value='<%=Helper.correctDouble((String)hshValues.get("txt_costcart"))%>'  size="15%" onKeyPress="allowNumber(this)" maxlength="8" onBlur="roundtxt(this);" /></td>
    </tr>
    <tr> 
      <td width="45%" >No. of Bullocks/Camels/Horses/Donkeys<b class="mantatory">*</b></td>
      <td><input type="text" name="txt_unitsize" size="15%" value="<%=Helper.correctNull((String)hshValues.get("txt_noofcart"))%>"  onKeyPress="allowInteger()" maxlength="8"></td>
      <td width="13%"> Cost per Bullock/Camel/Horse/Donkey</td>
      <td width="22%"><lapschoice:CurrencyTag name="txt_costbullock"  value='<%=Helper.correctDouble((String)hshValues.get("txt_costbullock"))%>'  size="15%"  maxlength="8"  onBlur="roundtxt(this);"/></td>
    </tr>
    <tr> 
      <td width="45%" > Other requirement if any specify <input type="text" name="sel_requirement" value="<%=Helper.correctNull((String)hshValues.get("cart_requirement"))%>" size="25" onKeyPress="" maxlength="49"/></td>
      <td><input type="text" name="txt_unit"  value="<%=Helper.correctDouble((String)hshValues.get("cart_unit"))%>"  size="15%" onKeyPress="allowNumber(this)" maxlength="8"/>&nbsp;(Units)</td>
      <td width="13%">Amount</td>
      <td width="22%"><lapschoice:CurrencyTag name="txt_amount"  value='<%=Helper.correctNull((String)hshValues.get("cart_amount"))%>'  size="15%"  maxlength="8" onBlur="roundtxt(this);"/></td>
   
    </tr>
     -->
  </table>
  
  <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
    <tr class="dataheader"> 
      <td colspan="3"><b>Techno-Economic Data </b></td>
    </tr>
    <tr> 
      <td width="50%" nowrap="nowrap"> Scope for utilising cart for transportation of own/others ,Commodities</td>
      <td width="11%"> 
        <select name="sel_scope" onChange="check();check1()">
          <option value="0" selected="selected">select</option>
          <option value="2">Own</option>
          <option value="3">Other</option>
          <option value="4">Both</option>
          <option value="1">Not Applicable</option>
        </select>
      </td>
      <td width="51%" id="r3">&nbsp;Expected earning per year<lapschoice:CurrencyTag name="txt_earnings1"  value='<%=Helper.correctDouble((String)hshValues.get("txt_earnings1"))%>'  size="15%" onKeyPress="allowNumber(this)" maxlength="8"/> 
        </td>
    </tr>
    <tr> 
      <td width="38%">Total lands to be put 
        to Bullocks/Camels/Horses/Donkeys [ Own Land]</td>
      <td colspan="2"> 
        <input type="text" name="txt_acre1"  value="<%=Helper.correctNull((String)hshValues.get("txt_acre1"))%>"  size="15%" onKeyPress="allowInteger()" maxlength="3">
        (Acres) 
        <% 	String measurementtype = Helper.correctNull((String)hshValues.get("land_measurement"));
                              	String measurementval="";
                            	if(measurementtype.equalsIgnoreCase("c"))
                      	  		{
                      	 
                      	  			 measurementval = "Cents";
                      	 		 }
                      	 		 else
                      	  			{
                      					measurementval = "Guntas";
                      	 			}
                                %>
     <!--    <input type="text" name="txt_guntas1"  value="<%=Helper.correctNull((String)hshValues.get("txt_guntas1"))%>"  size="15%" onKeyPress="allowInteger()" maxlength="2">
        <font color="#000000"><%=measurementval%></font></td> -->
    </tr>
    <tr> 
      <td width="38%">Total lands to be put 
        to Bullocks/Camels/Horses/Donkeys [Other's Land]]</td>
      <td colspan="2"> 
        <input type="text" name="txt_acre2"  value="<%=Helper.correctNull((String)hshValues.get("txt_acre2"))%>"  size="15%" onKeyPress="allowInteger()" maxlength="3">
        (Acres) 
        <% 	String measurementtype1 = Helper.correctNull((String)hshValues.get("land_measurement"));
                              	String measurementval1="";
                            	if(measurementtype1.equalsIgnoreCase("c"))
                      	  		{
                      	 
                      	  			 measurementval1 = "Cents";
                      	 		 }
                      	 		 else
                      	  			{
                      					measurementval1 = "Guntas";
                      	 			}
                                %>
    <!--       <input type="text" name="txt_guntas2"  value="<%=Helper.correctNull((String)hshValues.get("txt_guntas2"))%>"  size="15%" onKeyPress="allowInteger()" maxlength="2">
        <font color="#000000"><%=measurementval1%> </font>-->
      </td>
    </tr>
    <tr> 
      <td width="38%">Expected earning from ploughing per year [ Own Land]</td>
      <td colspan="2"><lapschoice:CurrencyTag name="txt_earnings2"  value='<%=Helper.correctDouble((String)hshValues.get("txt_earnings2"))%>'  maxlength="8" onBlur="roundtxt(this)"/> 
        (per year) </td>
    </tr>
    <tr> 
      <td width="38%">Expected earning from ploughing per year [Other's Land]</td>
      <td colspan="2"><lapschoice:CurrencyTag name="txt_earnings3"  value='<%=Helper.correctDouble((String)hshValues.get("txt_earnings3"))%>'  maxlength="8"  onBlur="roundtxt(this)"/> 
        (per year) </td>
    </tr>
    <tr> 
      <td width="38%">No. of days Bullocks/Camels/Horses/Donkeys put into work </td>
      <td colspan="2"> 
        <input type="text" name="txt_workdays"  maxlength="3" value= '<%=Helper.correctNull((String)hshValues.get("txt_workdays"))%>'  size="15%" onKeyPress="allowNumber(this)" onBlur="checkdays()" />
        ( days per year) </td>
    </tr>
  </table>
  </td>
  </tr>
  </table>
  <br>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br>
<input type ="hidden" name="sel_cart_text" value="">
<lapschoice:hiddentag pageid="<%=PageId%>"/>
<input  type="hidden" name="audit_flag" value='<%=Helper.correctNull((String)hshValues.get("audit_flag"))%>'>
</form>
</body>
</html>

