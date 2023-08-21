<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />

<%ArrayList arryCol = new ArrayList();
ArrayList arryRow = new ArrayList();
			
			arryRow = (ArrayList) hshValues.get("arryRow");
		
			if (arryRow == null) {
				arryRow = new ArrayList();
			}
	//String d3="",d5="",d7="",d9="",m3="",m5="",m9="",m7="",k3="",k5="",k7="",k9="",;
	String  d1="",d2="",d4="",d6="";
	String d8="",d10="",d11="",d12="";
	String  m1="",m2="",m4="",m6="";
	String m8="",m10="",m11="",m12="";
	String  k1="",k2="",k4="",k6="";
	String k8="",k10="",k11="",k12="";
	String  l1="",l2="",l4="",l6="";
	String l8="",l10="",l11="",l12="";
		%>
<html>
<head>
<title>Coffee Plantation  Details</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";

</script>

<script>
function callPlant(page,bean,method)
{	
	if (document.forms[0].cmdapply.disabled)
	{
		document.forms[0].hidAction.value="";
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		
		document.forms[0].action=appUrl+"action/"+page;
		document.forms[0].submit();
	}
	else
	{
		ShowAlert(103);
	}
}

function onloading()
{
	disableFields(true);
}

function enableButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdapply.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddel.disabled=bool5;
	document.forms[0].cmdclose.disabled = bool6;
}
function doSave()
{   
     callTotal();
     netincome();
    enableButtons(true, true, false, false, true);
	document.forms[0].hidBeanId.value="agrcoffee";		
	document.forms[0].hidSourceUrl.value="/action/agr_coffeeprevious.jsp";
	document.forms[0].hidBeanMethod.value="updatecoffeepreviousdata";
	document.forms[0].hidBeanGetMethod.value="getcoffeepreviousdata";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}
function doEdit()
{
 	disableFields(false);
	document.forms[0].hideditflag.value ="Y";
	document.forms[0].hidAction.value ="insert";
	for(var i=0;i<=3;i++)
 	{
 	document.forms[0].txt_netinc[i].readOnly =true;
 	}
	document.forms[0].txt_totnetincome.readOnly =true;
  document.forms[0].txt_totparacharb.readOnly =true;
    document.forms[0].txt_totcherryarb.readOnly =true;
   document.forms[0].txt_totparachrob.readOnly =true;
   document.forms[0].txt_totcherryrob.readOnly =true;
  
 
	enableButtons(true, true, false, false, false);		
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agrcoffee";
		document.forms[0].hidBeanGetMethod.value="getcoffeepreviousdata";
		document.forms[0].action=appUrl +"action/agr_coffeeprevious.jsp";
		document.forms[0].submit(); 		
	}	
}



function doClose()
{
	if( ConfirmMsg(100))
	{
		document.forms[0].target="_parent";
		document.forms[0].action=appUrl+"action/retailpge.jsp";	
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
		  
	}
}


function doDelete()
{
	if( ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
	 	document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updatecoffeepreviousdata";
		document.forms[0].hidBeanGetMethod.value="getcoffeepreviousdata";
		document.forms[0].hidBeanId.value="agrcoffee";
		document.forms[0].hidSourceUrl.value="action/agr_coffeeprevious.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}	
}
function netincome()
{
for(var m=0;m<=3;m++)
     {
var sur1 =  document.forms[0].txt_grossincome[m].value;
var sur2=document.forms[0].txt_maintexp[m].value;  
 if(sur1=="")
		{
			sur1=0.00;
			
		}
		if(sur2=="")
		{
			sur2=0.00;
			
		}
 document.forms[0].txt_netinc[m].value= eval(sur1)-eval(sur2);
 		
     }
 callTotal();
}
function callTotal()
{
var totalvalue1=0.00;var totalvalue2=0.00;var totalvalue3=0.00;
 var totalvalue4=0.00; var totalvalue5=0.00;
for(var m=0;m<=3;m++)
     {
    var value1 =  document.forms[0].txt_netinc[m].value;
      if( value1 =="")
		{
			 value1 =0.00;
			
		}
	totalvalue1 = eval(value1)+eval(totalvalue1)
	
	var value2 =  document.forms[0].txt_area1[m].value;
      if( value2 =="")
		{
			 value2 =0.00;
			
		}
	totalvalue2= eval(value2)+eval(totalvalue2)	
	
	var value3 =  document.forms[0].txt_area2[m].value;
      if( value3 =="")
		{
			 value3 =0.00;
			
		}
	totalvalue3= eval(value3)+eval(totalvalue3)	
	
	var value4 =  document.forms[0].txt_area3[m].value;
      if( value4 =="")
		{
			 value4 =0.00;
			
		}
	totalvalue4= eval(value4)+eval(totalvalue4)	
	var value5 =  document.forms[0].txt_area4[m].value;
      if( value5 =="")
		{
			 value5 =0.00;
			
		}
	totalvalue5= eval(value5)+eval(totalvalue5)					
     }
     totalvalue1 =(totalvalue1)/4; 
     totalvalue2=(totalvalue2)/4; 
     totalvalue3 =(totalvalue3)/4; 
     totalvalue4 =(totalvalue4)/4; 
	  totalvalue5 =(totalvalue5)/4; 
   document.forms[0].txt_totnetincome.value= eval(totalvalue1);
    document.forms[0].txt_totparacharb.value= eval(totalvalue2);
    document.forms[0].txt_totcherryarb.value= eval(totalvalue3);
   document.forms[0].txt_totparachrob.value= eval(totalvalue4);
   document.forms[0].txt_totcherryrob.value= eval(totalvalue5);
  
 
}
</script>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
DIV.cellContainer {	
  width: 100%; height: 250;
  overflow: auto;
}
</style>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css">
</head>
<body bgcolor="#EEEAE3" text="#000000" vlink="#330000" alink="#330000"
	leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="onloading(); callTotal()">
	<form name="frmpri" method="post">
	<%--
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
    <tr> 
      <td width="17%" align="center"><a
					href="javascript: callPlant('agr_coffeestate.jsp','agrcoffee','getCoffeeEstateData')"
					class="blackfont"><b>Coffee 
        Estate </b></a></td>
      <td width="11%" align="center" ><a
					href="javascript: callPlant('agrcropinter.jsp','agrcoffee','getcoffeeinterdata')"
					class="blackfont"><b>Inter 
        Crops </b></a></td>
      <td width="10%" align="center"><a
					href="javascript: callPlant('agrcropplantation.jsp','agrcoffee','getcoffeeplantdata')"
					class="blackfont"><b>Planted 
        Area </b></a></td>
      <td width="26%" bgcolor="#71694F" align="center"><a
					href="javascript: callPlant('agr_coffeeprevious.jsp','agrcoffee','getcoffeepreviousdata')"
					class="blackfont"><b>Coffee 
        Picked(Previous Seasons) </b></a></td>
      <td width="13%" align="center"><a
					href="javascript: callPlant('agr_coffeesources.jsp','agrcoffee','getcoffeesourcesdata')"
					class="blackfont"><b>Other 
        Agri. Lands</b></a></td>
      <td width="23%" align="center"><a
					href="javascript: callPlant('agrcoffeehypo.jsp','agrcrops','getcoffeehypo')"
					class="blackfont"><b>Coffee 
        Loan Required</b></a></td>
    </tr>
  </table>
--%>
	
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
    <tr bgcolor="#71694F"> 
      <td width="5%" rowspan="3" align="center"><font	color="#FFFFFF">Year</font></td>
      <td colspan="4" align="center"><font color="#FFFFFF" size="2" face="MS Sans Serif">Crop 
        Picked in tonnes</font></td>
      <td width="11%" rowspan="3" align="center"><font color="#FFFFFF" size="2" face="MS Sans Serif">Gross 
        Income(Rs.) </font></td>
      <td width="13%" rowspan="3" align="center"><font color="#FFFFFF" size="2" face="MS Sans Serif">Maintenance 
        Expenses(Rs.) </font></td>
      <td width="16%" rowspan="3" align="center"><font	color="#FFFFFF">Net 
        Income(Rs.)</font></td>
    </tr>
    <tr bgcolor="#71694F"> 
      <td colspan="2" align="center"><font	color="#FFFFFF">Arabica</font></td>
      <td colspan="2" align="center"><font	color="#FFFFFF">Robusta</font></td>
    </tr>
    <tr bgcolor="#71694F"> 
      <td align="center"><font	color="#FFFFFF">Parchment</font></td>
      <td align="center"><font	color="#FFFFFF">Cherry</font></td>
      <td align="center"><font	color="#FFFFFF">Parchment</font></td>
      <td align="center"><font	color="#FFFFFF">Cherry</font></td>
    </tr>
    <tr > 
      <%
						
				if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(0);
				
				if (arryCol.size() != 0) {
					 
					d1 = Helper.correctNull((String) arryCol.get(4));
					d2 = Helper.correctNull((String) arryCol.get(5));
					d4 = Helper.correctNull((String) arryCol.get(6));
					d6 = Helper.correctNull((String) arryCol.get(7));
					d8 = Helper.correctNull((String) arryCol.get(8));
					d10 = Helper.correctNull((String) arryCol.get(9));
					d11 = Helper.correctNull((String) arryCol.get(10));
					d12 = Helper.correctNull((String) arryCol.get(11));
					
				}
			
			} else if (arryRow.size() == 0) {
				d1 = "20";
				d2 = "";
				d4 = "";
				d6 = "";
				d8="";d10="";
				d11="";d12="";
			}

			%>
      <td align="center"><input type="text" name="txt_year"  value="<%=d1%>"  size="10%" onKeyPress="allowInteger()" maxlength="4"></td>
      <td width="5%" align="center"><input type="text" name="txt_area1"  value="<%=d2%>"  size="10%" onKeyPress="allowNumber(this)" maxlength="6" onBlur="callTotal()"></td>
      <td width="5%" align="center"><input type="text" name="txt_area2"  value="<%=d4%>"  size="10%" onKeyPress="allowNumber(this)" maxlength="6" onBlur="callTotal()"></td>
      <td width="6%" align="center"><input type="text" name="txt_area3"  value="<%=d6%>"  size="10%" onKeyPress="allowNumber(this)" maxlength="6" onBlur="callTotal()"></td>
      <td width="7%" align="center"><input type="text" name="txt_area4"  value="<%=d8%>"  size="10%" onKeyPress="allowNumber(this)" maxlength="6" onBlur="callTotal()"></td>
      <td align="center"><lapschoice:CurrencyTag name="txt_grossincome"  value='<%=d10%>'  size="10%"  maxlength="9" onBlur="callTotal()"/></td>
      <td align="center"><lapschoice:CurrencyTag name="txt_maintexp"  value='<%=d11%>'  size="10%" maxlength="9" onBlur="netincome()"/></td>
      <td align="center"><lapschoice:CurrencyTag name="txt_netinc"  value='<%=d12%>'  size="10%"  maxlength="9"/></td>
    </tr>
    <tr > 
      <%
						
				if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(1); 
				
				if (arryCol.size() != 0) {
					 
					m1 = Helper.correctNull((String) arryCol.get(4));
					m2 = Helper.correctNull((String) arryCol.get(5));
					m4 = Helper.correctNull((String) arryCol.get(6));
					m6 = Helper.correctNull((String) arryCol.get(7));
					m8 = Helper.correctNull((String) arryCol.get(8));
					m10 = Helper.correctNull((String) arryCol.get(9));
					m11 = Helper.correctNull((String) arryCol.get(10));
					m12 = Helper.correctNull((String) arryCol.get(11));
					
				}
			
			} else if (arryRow.size() == 0) {
				m1 = "20";
				m2 = "";
				m4 = "";
				m6 = "";
			m8="";m10="";
				m11="";m12="";
		
				
			}

			%>
      <td align="center"><input type="text" name="txt_year"  value="<%=m1%>"  size="10%" onKeyPress="allowInteger()" maxlength="4"></td>
      <td align="center"><input type="text" name="txt_area1"  value="<%=m2%>"  size="10%" onKeyPress="allowNumber(this)" maxlength="6" onBlur="callTotal()"></td>
      <td align="center"><input type="text" name="txt_area2"  value="<%=m4%>"  size="10%" onKeyPress="allowNumber(this)" maxlength="6" onBlur="callTotal()"></td>
      <td align="center"><input type="text" name="txt_area3"  value="<%=m6%>"  size="10%" onKeyPress="allowNumber(this)" maxlength="6" onBlur="callTotal()"></td>
      <td align="center"><input type="text" name="txt_area4"  value="<%=m8%>"  size="10%" onKeyPress="allowNumber(this)" maxlength="6" onBlur="callTotal()"></td>
      <td align="center"><lapschoice:CurrencyTag name="txt_grossincome"  value='<%=m10%>' size="10%"  maxlength="9"/></td>
      <td align="center"><lapschoice:CurrencyTag name="txt_maintexp"  value='<%=m11%>'  size="10%"  maxlength="9" onBlur="netincome()"/></td>
      <td align="center"><lapschoice:CurrencyTag name="txt_netinc"  value='<%=m12%>'  size="10%"  maxlength="9"/></td>
    </tr>
    <tr > 
      <%
						
				if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(2);
				
				if (arryCol.size() != 0) {
					 
					k1 = Helper.correctNull((String) arryCol.get(4));
					k2 = Helper.correctNull((String) arryCol.get(5));
					k4 = Helper.correctNull((String) arryCol.get(6));
					k6 = Helper.correctNull((String) arryCol.get(7));
					k8 = Helper.correctNull((String) arryCol.get(8));
					k10 = Helper.correctNull((String) arryCol.get(9));
					k11 = Helper.correctNull((String) arryCol.get(10));
					k12 = Helper.correctNull((String) arryCol.get(11));
					
				}
			
			} else if (arryRow.size() == 0) {
				k1 = "20";
				k2 = "";
				k4 = "";
				k6 = "";
				k8="";k10="";
				k11="";k12="";
		
				
			}

			%>
      <td align="center"><input type="text" name="txt_year" value="<%=k1%>"  size="10%" onKeyPress="allowInteger()" maxlength="4"></td>
      <td align="center"><input type="text" name="txt_area1" value="<%=k2%>"  size="10%" onKeyPress="allowNumber(this)" maxlength="6" onBlur="callTotal()"></td>
      <td align="center"><input type="text" name="txt_area2" value="<%=k4%>"  size="10%" onKeyPress="allowNumber(this)" maxlength="6" onBlur="callTotal()"></td>
      <td align="center"><input type="text" name="txt_area3" value="<%=k6%>"  size="10%" onKeyPress="allowNumber(this)" maxlength="6" onBlur="callTotal()"></td>
      <td align="center"><input type="text" name="txt_area4" value="<%=k8%>"  size="10%" onKeyPress="allowNumber(this)" maxlength="6" onBlur="callTotal()"></td>
      <td align="center"><lapschoice:CurrencyTag name="txt_grossincome"  value='<%=k10%>'  size="10%"  maxlength="9"/></td>
      <td align="center"><lapschoice:CurrencyTag name="txt_maintexp"  value='<%=k11%>'  size="10%"  maxlength="9" onBlur="netincome()"/></td>
      <td align="center"><lapschoice:CurrencyTag name="txt_netinc"  value='<%=k12%>'  size="10%"  maxlength="9"/></td>
    </tr>
    <tr > 
	 <%
						
				if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(3);
				
				if (arryCol.size() != 0) {
					 
					l1 = Helper.correctNull((String) arryCol.get(4));
					l2 = Helper.correctNull((String) arryCol.get(5));
					l4 = Helper.correctNull((String) arryCol.get(6));
				    l6 = Helper.correctNull((String) arryCol.get(7));
					l8 = Helper.correctNull((String) arryCol.get(8));
					l10 = Helper.correctNull((String) arryCol.get(9));
					l11 = Helper.correctNull((String) arryCol.get(10));
					l12 = Helper.correctNull((String) arryCol.get(11));
					
				}
			
			} else if (arryRow.size() == 0) {
				l1 = "20";
				l2 = "";
				l4 = "";
				l6 = "";
				l8="";l10="";
				l11="";l12="";
		
				
			}

			%>
     
      <td align="center"><input type="text" name="txt_year"  value="<%=l1%>"  size="10%" onKeyPress="allowInteger()" maxlength="4"></td>
      <td align="center"><input type="text" name="txt_area1"  value="<%=l2%>"  size="10%" onKeyPress="allowNumber(this)" maxlength="6" onBlur="callTotal()"></td>
      <td align="center"><input type="text" name="txt_area2"  value="<%=l4%>"  size="10%" onKeyPress="allowNumber(this)" maxlength="6" onBlur="callTotal()"></td>
      <td align="center"><input type="text" name="txt_area3"  value="<%=l6%>"  size="10%" onKeyPress="allowNumber(this)" maxlength="6" onBlur="callTotal()"></td>
      <td align="center"><input type="text" name="txt_area4"  value="<%=l8%>"  size="10%" onKeyPress="allowNumber(this)" maxlength="6" onBlur="callTotal()"></td>
      <td align="center"><lapschoice:CurrencyTag name="txt_grossincome"  value='<%=l10%>'  size="10%" maxlength="9"/></td>
      <td align="center"><lapschoice:CurrencyTag name="txt_maintexp"  value='<%=l11%>'  size="10%"  maxlength="9" onBlur="netincome()"/></td>
      <td align="center"><lapschoice:CurrencyTag name="txt_netinc"  value='<%=l12%>'  size="10%"  maxlength="9"/></td>
    </tr>
    <tr > 
      <td align="center" bgcolor="#71694F"><font color="#FFFFFF">Average</font></td>
      <td align="center" bgcolor="#71694F"><input type="text" name="txt_totparacharb"  value=""  size="10%" onKeyPress="allowNumber(this)" maxlength="4"></td>
      <td align="center" bgcolor="#71694F"><input type="text" name="txt_totcherryarb"  value=""  size="10%" onKeyPress="allowNumber(this)" maxlength="4"></td>
      <td align="center" bgcolor="#71694F"><input type="text" name="txt_totparachrob"  value=""  size="10%" onKeyPress="allowNumber(this)" maxlength="4"></td>
      <td align="center" bgcolor="#71694F"><input type="text" name="txt_totcherryrob"  value=""  size="10%" onKeyPress="allowNumber(this)" maxlength="4"></td>
      <td align="center" bgcolor="#71694F">&nbsp;</td>
      <td align="center" bgcolor="#71694F">&nbsp;</td>
      <td align="center" bgcolor="#71694F"><lapschoice:CurrencyTag name="txt_totnetincome"  value=''  size="10%" maxlength="4"/></td>
    </tr>
  </table>

<br>
<br>
<lapschoice:combutton btntype='EO' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>

<lapschoice:agrihiddentag />
</form>

</body>
</html>


