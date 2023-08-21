<%@include file="../share/directives.jsp"%>
<%
	ArrayList arryCol = new ArrayList();
	ArrayList arryRow = null;
	
	arryRow = new ArrayList();
	arryRow  = (ArrayList) hshValues.get("arryRow");
%>
<html>
<head>
<title>LAPS -Assesment Form Details</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var id ="";
var apptype="";

var currentDate = "<%=Helper.getCurrentDateTime()%>";
var  strid="<%=Helper.correctNull((String)hshValues.get("strid"))%>";
var  strAction="<%=Helper.correctNull((String)hshValues.get("strAction"))%>";



function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].target="_parent";
		document.forms[0].action=appURL+"action/retailpge.jsp";	
		document.forms[0].submit();
	}
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

function doSave()
{	
   
	enableButtons( true, true, true, true, false);	
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hidBeanId.value="agrpoultry";
	document.forms[0].hidSourceUrl.value="/action/agr_sheep_income.jsp";
	document.forms[0].hidBeanMethod.value="updatesheepincome";
	document.forms[0].hidBeanGetMethod.value="getsheepincome";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doEdit()
{
 	disableFields(true);
   document.forms[0].hidAction.value ="insert";
   enableButtons(true, false, false, false, true);	
}

function callhelp()
{
	var varQryString = appURL+"/jsp/perhlp/hlp_edueducational.jsp"
	var title = "ApplicantDemographics";
	var prop = "scrollbars=no,width=600,height=450";	
	prop = prop + ",left=200,top=150";
	window.open(varQryString,title,prop);
}
 
function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="cancel";
		document.forms[0].hidBeanId.value="agrpoultry";
		document.forms[0].hidBeanGetMethod.value="getsheepincome";
		document.forms[0].action=appURL+"action/agr_sheep_income.jsp";
		document.forms[0].submit(); 		
	}
}

function doDelete()
{
	if( ConfirmMsg(101))
	{
	document.forms[0].hidAction.value ="delete";
	document.forms[0].action=appURL+"action/ControllerServlet";		
	document.forms[0].hidBeanMethod.value="updatesheepincome";
	document.forms[0].hidBeanGetMethod.value="getsheepincome";
	document.forms[0].hidBeanId.value="agrpoultry";
	document.forms[0].hidSourceUrl.value="action/agr_sheep_income.jsp";	
	document.forms[0].method="post";			
	document.forms[0].submit();	
	}	
}

function onloading()
{	  
	disableFields(true);
}

function enableButtons( bool2, bool3, bool4, bool5, bool6)
{	
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled = bool6;
}
function calculate()
{

	for(var i=0;i<6;i++)
	{
		var txt_ibatchiyear=document.forms[0].txt_ibatchiyear[i].value;
		var txt_ibatchiiiyear=document.forms[0].txt_ibatchiiiyear[i].value;
		var txt_ibatchviyear=document.forms[0].txt_ibatchviyear[i].value;
		var txt_ibatchexpiyear=document.forms[0].txt_ibatchexpiyear[i].value;
		var txt_ibatchexpiiyear=document.forms[0].txt_ibatchexpiiyear[i].value;
		
		if(txt_ibatchiyear=="")
		txt_ibatchiyear ="0.00";
		
		if(txt_ibatchiiiyear=="")
		txt_ibatchiiiyear ="0.00";
		
		if(txt_ibatchviyear=="")
		txt_ibatchviyear ="0.00";
		
		if(txt_ibatchexpiyear=="")
		txt_ibatchexpiyear ="0.00";
		
		if(txt_ibatchexpiiyear=="")
		txt_ibatchexpiiyear ="0.00";
		
		
		
		
		document.forms[0].txt_totiyearu[i].value=eval(txt_ibatchiyear)+eval(txt_ibatchiiiyear)+eval(txt_ibatchviyear)+eval(txt_ibatchexpiyear)+eval(txt_ibatchexpiiyear);
		roundtxt(document.forms[0].txt_totiyearu[i]);
		
		
		
		var netExpenses = document.forms[0].txt_totaliyeare[i].value;
		
		if(netExpenses=="")
		netExpenses = "0.00";
		
		document.forms[0].txt_totaliyears[i].value =  eval(document.forms[0].txt_totiyearu[i].value) - eval(netExpenses);
		roundtxt(document.forms[0].txt_totaliyears[i]);
		
	}

}

function placeValues()
{
	<%for(int i =0;i<6;i++)
	{
	  	if(arryRow.size()!=0)
	  	{
	  		arryCol = ((ArrayList)arryRow.get(i));
	  	%>	
	  		
	  		document.forms[0].txt_ibatchiyear[<%=i%>].value="<%=arryCol.get(0)%>";
	  		document.forms[0].txt_ibatchiiiyear[<%=i%>].value="<%=arryCol.get(1)%>";
	  		document.forms[0].txt_ibatchviyear[<%=i%>].value="<%=arryCol.get(2)%>";
	  		
	  	<%}
	  	else
	  	{%>
	  		document.forms[0].txt_ibatchiyear[<%=i%>].value="0.00";
	  		document.forms[0].txt_ibatchiiiyear[<%=i%>].value="0.00";
	  		document.forms[0].txt_ibatchviyear[<%=i%>].value="0.00";
	  		<%}
	  %>
	
	
		
	<%}%>
}


function callsurplus()
{
var txt_totiyearu=document.forms[0].txt_totiyearu.value;
var txt_totaliyeare=document.forms[0].txt_totaliyeare.value;
var txt_totiiyearu=document.forms[0].txt_totaliiyearu.value;
var txt_totaliiyeare=document.forms[0].txt_totaliiyeare.value;
var txt_totiiiyearu=document.forms[0].txt_totaliiiyearu.value;
var txt_totaliiiyeare=document.forms[0].txt_totaliiiyeare.value;
var txt_totivyearu=document.forms[0].txt_totalivyearu.value;
var txt_totalivyeare=document.forms[0].txt_totalivyeare.value;
var txt_totvyearu=document.forms[0].txt_totalvyearu.value;
var txt_totalvyeare=document.forms[0].txt_totalvyeare.value;
var txt_totviyearu=document.forms[0].txt_totalviyearu.value;
var txt_totalviyeare=document.forms[0].txt_totalviyeare.value;
document.forms[0].txt_totaliyears.value=NanNumber(eval(txt_totiyearu)-eval(txt_totaliyeare));
roundtxt(document.forms[0].txt_totaliyears);
if(document.forms[0].txt_totaliyears.value=="NaN")
{
document.forms[0].txt_totaliyears.value="0";
}
document.forms[0].txt_totaliiyears.value=NanNumber(eval(txt_totiiyearu)-eval(txt_totaliiyeare));
roundtxt(document.forms[0].txt_totaliiyears);
if(document.forms[0].txt_totaliiyears.value=="NaN")
{
document.forms[0].txt_totaliiyears.value="0";
}
document.forms[0].txt_totaliiiyears.value=NanNumber(eval(txt_totiiiyearu)-eval(txt_totaliiiyeare));
roundtxt(document.forms[0].txt_totaliiiyears);
if(document.forms[0].txt_totaliiiyears.value=="NaN")
{
document.forms[0].txt_totaliiiyears.value="0";
}
document.forms[0].txt_totalivyears.value=NanNumber(eval(txt_totivyearu)-eval(txt_totalivyeare));
roundtxt(document.forms[0].txt_totalivyears);
if(document.forms[0].txt_totalivyears.value=="NaN")
{
document.forms[0].txt_totalivyears.value="0";
}
document.forms[0].txt_totalvyears.value=NanNumber(eval(txt_totvyearu)-eval(txt_totalvyeare));
roundtxt(document.forms[0].txt_totalvyears);
if(document.forms[0].txt_totalvyears.value=="NaN")
{
document.forms[0].txt_totalvyears.value="0";
}
document.forms[0].txt_totalviyears.value=NanNumber(eval(txt_totviyearu)-eval(txt_totalviyeare));
roundtxt(document.forms[0].txt_totalviyears);
if(document.forms[0].txt_totalviyears.value=="NaN")
{
document.forms[0].txt_totalviyears.value="0";
}
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="placeValues();onloading();calculate();">
<form name="frmpri" method="post" class="normal">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td valign="top">		
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
				<tr>
				 <td> 
<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable border1">
                      <tr> 
                        <td > 
<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
                            <tr class="dataheader"> 
                              <td rowspan="2" nowrap ><b>Income 
                                on </b></td>
                              <td colspan="6" align="center"><b>(Amount 
                                in Rs.) </b></td>
                            </tr>
                            <tr class="dataheader"> 
                              <td align="center"><b>I 
                                Year</b></td>
                              <td align="center"><b>II 
                                Year </b></td>
                              <td align="center"><b>III 
                                Year</b></td>
                              <td align="center"><b>IV 
                                Year</b></td>
                              <td align="center"><b>V 
                                Year</b></td>
                              <td align="center"><b>VI 
                                Year</b></td>
                            </tr>
                            <tr> 
                              <td >Income 
                                from sale of Animals 
                                 </td>
                              <td width="8%" align="center" > <lapschoice:CurrencyTag name="txt_ibatchiyear" size="10"
									maxlength="15" value='' 
									/> </td>
                              <td width="12%" align="center"><lapschoice:CurrencyTag name="txt_ibatchiyear" size="10"
									/> </td>
                              <td width="8%" align="center" > <lapschoice:CurrencyTag name="txt_ibatchiyear" size="10"
									/> </td>
                              <td width="9%" align="center" ><lapschoice:CurrencyTag name="txt_ibatchiyear" size="10"
									/> </td>
                              <td width="10%" align="center" ><lapschoice:CurrencyTag name="txt_ibatchiyear" size="10"
									/> </td>
                              <td width="16%" align="center" > <lapschoice:CurrencyTag name="txt_ibatchiyear" size="10"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/> </td>
                            </tr>
                            <tr> 
                              <td>Income 
                                from sale of by-products </td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchiiiyear"size="10" maxlength="15"
									/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchiiiyear"size="10" maxlength="15"
									/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchiiiyear"size="10" maxlength="15"
									/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchiiiyear"size="10" maxlength="15"
									/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchiiiyear"size="10" maxlength="15"
									/> </td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchiiiyear"size="10" maxlength="15"
									/></td>
                            </tr>
                            <tr> 
                              <td>Income 
                                from sale of manure/penning </td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchviyear"size="10"
									maxlength="15" /></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchviyear"size="10"
									maxlength="15" /></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchviyear"size="10"
									maxlength="15" /></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchviyear"size="10"
									maxlength="15"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchviyear"size="10"
									maxlength="15" /></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchviyear"size="10"
									maxlength="15" /></td>
                            </tr>
                            <tr> 
                              <td><input type="text" name="txt_specify"size="30"
									maxlength="15" value="<%=Helper.correctNull((String)hshValues.get("txt_specify1"))%>" onKeyPress=""
									>
                              </td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchexpiyear"size="10"
									maxlength="15" value='<%=Helper.correctDouble((String)hshValues.get("txt_amountspec1"))%>' /></td>
                              <td align="center">
                              <lapschoice:CurrencyTag name="txt_ibatchexpiyear" maxlength="15" size="10"
									value='<%=Helper.correctDouble((String)hshValues.get("txt_amountspec1"))%>' /></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchexpiyear"  size="10" maxlength="15"
									value='<%=Helper.correctDouble((String)hshValues.get("txt_amountspec1"))%>' /></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchexpiyear" size="10" maxlength="15"
									 value='<%=Helper.correctDouble((String)hshValues.get("txt_amountspec1"))%>' /></td>
                              <td align="center">
                              <lapschoice:CurrencyTag name="txt_ibatchexpiyear" size="10" maxlength="15"
									 value='<%=Helper.correctDouble((String)hshValues.get("txt_amountspec1"))%>' /></td>
                              <td align="center">
                              <lapschoice:CurrencyTag name="txt_ibatchexpiyear" size="10" maxlength="15"
									 value='<%=Helper.correctDouble((String)hshValues.get("txt_amountspec1"))%>' /></td>
                            </tr>
                            <tr> 
                              <td><input type="text" name="txt_specify2"size="30"
									maxlength="15" value="<%=Helper.correctNull((String)hshValues.get("txt_specify2"))%>" onKeyPress=""
									>
                              </td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchexpiiyear"size="10"
									 value='<%=Helper.correctDouble((String)hshValues.get("txt_amountspec2"))%>' /></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchexpiiyear"size="10"
									 value='<%=Helper.correctDouble((String)hshValues.get("txt_amountspec2"))%>' /></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchexpiiyear"size="10"
									 value='<%=Helper.correctNull((String)hshValues.get("txt_amountspec2"))%>' /></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchexpiiyear"size="10"
									 value='<%=Helper.correctDouble((String)hshValues.get("txt_amountspec2"))%>' /></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchexpiiyear"size="10"
									 value='<%=Helper.correctDouble((String)hshValues.get("txt_amountspec2"))%>' /></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchexpiiyear"size="10"
									 value='<%=Helper.correctDouble((String)hshValues.get("txt_amountspec2"))%>' /></td>
                            </tr>
                            <tr class="dataheader"> 
                              <td><b>Total(Income)</b></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_totiyearu" size="10"
									maxlength="15" value='' /></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_totiyearu" size="10"
									maxlength="15" value='' /></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_totiyearu" size="10"
									maxlength="15" value='' /></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_totiyearu" size="10"
									maxlength="15" value='' /></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_totiyearu" size="10"
									maxlength="15" value='' /></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_totiyearu" size="10"
									maxlength="15" value='' /></td>
                            </tr>
                            <tr class="dataheader"> 
                              <td><b>Total(Expenses)</b></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_totaliyeare" size="10"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("totiyearexpenses"))%>' /></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_totaliyeare" size="10"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("totiiyearexpenses"))%>' /></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_totaliyeare" size="10"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("totiiiyearexpenses"))%>' /></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_totaliyeare" size="10"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("totivyearexpenses"))%>' /></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_totaliyeare" size="10"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("totvyearexpenses"))%>' /></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_totaliyeare" size="10"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("totviyearexpenses"))%>'/></td>
                            </tr>
                            <tr class="dataheader"> 
                              <td><b>Total(Net 
                                Income)</b></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_totaliyears" size="10"
									maxlength="15" value='' /></td>
                              <td align="center"><input type="text" name="txt_totaliyears" size="10"
									maxlength="15" value="" onKeyPress="allowInteger()"
									readonly style="text-align:right;"></td>
                              <td align="center"><input type="text" name="txt_totaliyears" size="10"
									maxlength="15" value="" onKeyPress="allowInteger()"
									readonly style="text-align:right;"></td>
                              <td align="center"><input type="text" name="txt_totaliyears" size="10"
									maxlength="15" value="" onKeyPress="allowInteger()"
									readonly style="text-align:right;"></td>
                              <td align="center"><input type="text" name="txt_totaliyears" size="10"
									maxlength="15" value="" onKeyPress="allowInteger()"
									readonly style="text-align:right;"></td>
                              <td align="center"><input type="text" name="txt_totaliyears" size="10"
									maxlength="15" value="" onKeyPress="allowInteger()"
									readonly style="text-align:right;"></td>
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
<br/>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:agrihiddentag/>
</form>
</body>
</html>

