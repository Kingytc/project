<%@include file="../share/directives.jsp"%>
<%
ArrayList arryCol = new ArrayList();
ArrayList arryRow = new ArrayList();
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

function placeValues()
{
	
	<%for(int i =0;i<6;i++)
	{
	  	if(arryRow.size()!=0)
	  	{
	  		arryCol = ((ArrayList)arryRow.get(i));
	  	%>	
	  		
	  		document.forms[0].txt_ibatchiyear[<%=i%>].value="<%=arryCol.get(0)%>";
	  		document.forms[0].txt_ibatchifemaleyear[<%=i%>].value="<%=arryCol.get(1)%>";
	  		document.forms[0].txt_ibatchiiyear[<%=i%>].value="<%=arryCol.get(2)%>";
	  		document.forms[0].txt_ibatchiiyearfemale[<%=i%>].value="<%=arryCol.get(3)%>";
	  		document.forms[0].txt_ibatchiiiyear[<%=i%>].value="<%=arryCol.get(4)%>";
	  		document.forms[0].txt_ibatchviyear[<%=i%>].value="<%=arryCol.get(5)%>";
	  		
	  	<%}
	  	else
	  	{%>
	  		document.forms[0].txt_ibatchiyear[<%=i%>].value="0.00";
	  		document.forms[0].txt_ibatchifemaleyear[<%=i%>].value="0.00";
	  		document.forms[0].txt_ibatchiiyear[<%=i%>].value="0.00";
	  		document.forms[0].txt_ibatchiiyearfemale[<%=i%>].value="0.00";
	  		document.forms[0].txt_ibatchiiiyear[<%=i%>].value="0.00";
	  		document.forms[0].txt_ibatchviyear[<%=i%>].value="0.00";
	  	<%}
	  %>
	
	
		
	<%}%>
	
	
	
	
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
	document.forms[0].hidSourceUrl.value="/action/agr_sheep_expenses.jsp";
	document.forms[0].hidBeanMethod.value="updatesheepexpenses";
	document.forms[0].hidBeanGetMethod.value="getsheepexpenses";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doEdit()
{
 	disableFields(true);
	//document.forms[0].txt_totaliyearu1.readOnly=false;
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
		//document.forms[0].hidSourceUrl.value="/action/agr_sheep_expenses.jsp";
		document.forms[0].hidBeanId.value="agrpoultry";
		document.forms[0].hidBeanGetMethod.value="getsheepexpenses";
		document.forms[0].action=appURL+"action/agr_sheep_expenses.jsp";
		document.forms[0].submit(); 		
	}
}

function doDelete()
{
	if( ConfirmMsg(101))
	{
	document.forms[0].hidAction.value ="delete";
	document.forms[0].action=appURL+"action/ControllerServlet";		
	document.forms[0].hidBeanMethod.value="updatesheepexpenses";
	document.forms[0].hidBeanGetMethod.value="getsheepexpenses";
	document.forms[0].hidBeanId.value="agrpoultry";
	document.forms[0].hidSourceUrl.value="action/agr_sheep_expenses.jsp";	
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

	var totalvalue1=0.00;var totalvalue2=0.00;
	for(var i=0;i<6;i++)
	{
		var txt_ibatchiyear=document.forms[0].txt_ibatchiyear[i].value;
		var txt_ibatchifemaleyear =document.forms[0].txt_ibatchifemaleyear[i].value;
		var txt_ibatchiiyear  =document.forms[0].txt_ibatchiiyear[i].value;
		var txt_ibatchiiyearfemale=document.forms[0].txt_ibatchiiyearfemale[i].value;
		var txt_ibatchiiiyear=document.forms[0].txt_ibatchiiiyear[i].value;
		var txt_ibatchviyear=document.forms[0].txt_ibatchviyear[i].value;
		var txt_ibatchivyear=document.forms[0].txt_ibatchivyear[i].value;
		var txt_ibatchviiyear=document.forms[0].txt_ibatchviiyear[i].value;
		var txt_ibatchviiiyear=document.forms[0].txt_ibatchviiiyear[i].value;
		var txt_ibatchexpiyear=document.forms[0].txt_ibatchexpiyear[i].value;
		var txt_ibatchexpiiyear=document.forms[0].txt_ibatchexpiiyear[i].value;
		
		
		if(txt_ibatchiyear=="")
		txt_ibatchiyear ="0.00"
		
		if(txt_ibatchifemaleyear=="")
		txt_ibatchifemaleyear ="0.00";
		
		if(txt_ibatchiiyear=="")
		txt_ibatchiiyear ="0.00";
		
		if(txt_ibatchiiyearfemale=="")
		txt_ibatchiiyearfemale ="0.00";
		
		if(txt_ibatchiiiyear=="")
		txt_ibatchiiiyear="0.00";
		
		if(txt_ibatchviyear=="")
		txt_ibatchviyear="0.00";
		
		if(txt_ibatchivyear=="")
		txt_ibatchivyear="0.00";
		
		if(txt_ibatchviiyear=="")
		txt_ibatchviiyear="0.00";
		
		if(txt_ibatchviiiyear=="")
		txt_ibatchviiiyear="0.00";
		
		if(txt_ibatchexpiyear=="")
		txt_ibatchviiiyear="0.00";
		
		if(txt_ibatchexpiiyear=="")
		txt_ibatchexpiiyear="0.00";
		
		
	
		document.forms[0].txt_totiyearu[i].value=(eval(txt_ibatchiyear)+
		eval(txt_ibatchifemaleyear)+eval(txt_ibatchiiyear)+eval(txt_ibatchiiyearfemale)+
		eval(txt_ibatchiiiyear)+eval(txt_ibatchviyear)+eval(txt_ibatchivyear)+
		eval(txt_ibatchviiyear)+eval(txt_ibatchviiiyear)+eval(txt_ibatchexpiyear)+eval(txt_ibatchexpiiyear));
		
		roundtxt(document.forms[0].txt_totiyearu[i]);
		
		var totalExp="";
		if(i==0)
		{
			//totalExp = document.forms[0].txt_totaliyearu1.value;
			
			//if(totalExp=="")
			//totalExp = "0.00";
			
			document.forms[0].txt_totaliyearu2[i].value= eval(document.forms[0].txt_totiyearu[i].value);// - eval(totalExp);
			
			roundtxt(document.forms[0].txt_totaliyearu2[i]);
		}
		else
		{
			document.forms[0].txt_totaliyearu2[i].value = document.forms[0].txt_totiyearu[i].value;
		}
			
		

	}
	

}

function callfirst()
{
	/*var totalExp = document.forms[0].txt_totaliyearu1.value;
	
	if(totalExp=="")
	totalExp = "0.00";
	
	document.forms[0].txt_totaliyearu2[0].value= eval(document.forms[0].txt_totiyearu[0].value) - eval(totalExp);
	
	roundtxt(document.forms[0].txt_totaliyearu2[0]);*/
}


</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
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
                        <td> 
                          <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
                            <tr class="dataheader"> 
                              <td width="42%" rowspan="2" nowrap ><b>Expenditure 
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
                              <td>Cost 
                                of Feeding of Male Adults  </td>
                              <td width="5%" align="center" > 
                                <input name="txt_ibatchiyear" size="10"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;" /> </td>
                              <td width="11%" align="center" > 
                                <input name="txt_ibatchiyear" size="10"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/> </td>
                              <td width="7%" align="center"  > 
                                <input name="txt_ibatchiyear" size="10"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/> </td>
                              <td width="8%" align="center"  > 
                                <input name="txt_ibatchiyear" size="10"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/> </td>
                              <td width="9%" align="center"  > 
                                <input name="txt_ibatchiyear" size="10"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/> </td>
                              <td width="18%" align="center" > 
                                <input name="txt_ibatchiyear" size="10"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/> </td>
                            </tr>
							
							<tr> 
                              <td>Cost of 
                                Feeding of Female Adults  </td>
                              <td width="5%" align="center" > <input name="txt_ibatchifemaleyear" size="10"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;" /> </td>
                              <td width="11%" align="center"> <input name="txt_ibatchifemaleyear" size="10"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/> </td>
                              <td width="7%" align="center" > <input name="txt_ibatchifemaleyear" size="10"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/> </td>
                              <td width="8%" align="center" > <input name="txt_ibatchifemaleyear" size="10"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/> </td>
                              <td width="9%" align="center" > <input name="txt_ibatchifemaleyear" size="10"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/> </td>
                              <td width="18%" align="center" > <input name="txt_ibatchifemaleyear" size="10"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/> </td>
                            </tr>
                            <tr> 
                              <td>Cost of 
                                Feeding of Male Lambs/kids/piglets  </td>
                               
                              <td align="center">
                                <input type="text" name="txt_ibatchiiyear"size="10"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                              </td>
                              <td align="center">
                                <input type="text" name="txt_ibatchiiyear"size="10"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                              </td>
                              <td align="center">
                                <input type="text" name="txt_ibatchiiyear"size="10"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                              </td>
                              <td align="center">
                                <input type="text" name="txt_ibatchiiyear"size="10"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                              </td>
                              <td align="center">
                                <input type="text" name="txt_ibatchiiyear"size="10"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                              </td>
                              <td align="center">
                                <input type="text" name="txt_ibatchiiyear"size="10"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                              </td>
                            </tr>
							
							 <tr> 
                              <td>Cost of 
                                Feeding of Female Lambs/kids/piglets </td>
                               
                              <td align="center">
                                <input type="text" name="txt_ibatchiiyearfemale"size="10"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                              </td>
                              <td align="center">
                                <input type="text" name="txt_ibatchiiyearfemale"size="10"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                              </td>
                              <td align="center">
                                <input type="text" name="txt_ibatchiiyearfemale"size="10"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                              </td>
                              <td align="center">
                                <input type="text" name="txt_ibatchiiyearfemale"size="10"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                              </td>
                              <td align="center">
                                <input type="text" name="txt_ibatchiiyearfemale"size="10"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                              </td>
                              <td align="center">
                                <input type="text" name="txt_ibatchiiyearfemale"size="10"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                              </td>
                            </tr>
                            <tr> 
                              <td>Expenses 
                                on Veterinary Aid </td>
                              <td align="center">
                                <input type="text" name="txt_ibatchiiiyear"size="10"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                              </td>
                              <td align="center">
                                <input type="text" name="txt_ibatchiiiyear"size="10"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                              </td>
                              <td align="center">
                                <input type="text" name="txt_ibatchiiiyear"size="10" maxlength="15"
									value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                              </td>
                              <td align="center">
                                <input type="text" name="txt_ibatchiiiyear"size="10" maxlength="15"
									value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                              </td>
                              <td align="center">
                                <input type="text" name="txt_ibatchiiiyear"size="10" maxlength="15"
									value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                              </td>
                              <td align="center">
                                <input type="text" name="txt_ibatchiiiyear"size="10" maxlength="15"
									value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                              </td>
                            </tr>
                            <tr> 
                              <td>Expenses 
                                on Insurance Premium  </td>
                              <td align="center">
                                <input type="text" name="txt_ibatchviyear"size="10"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                              </td>
                              <td align="center">
                                <input type="text" name="txt_ibatchviyear"size="10"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                              </td>
                              <td align="center">
                                <input type="text" name="txt_ibatchviyear"size="10"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                              </td>
                              <td align="center">
                                <input type="text" name="txt_ibatchviyear"size="10"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                              </td>
                              <td align="center">
                                <input type="text" name="txt_ibatchviyear"size="10"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                              </td>
                              <td align="center">
                                <input type="text" name="txt_ibatchviyear"size="10"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                              </td>
                            </tr>
                            <tr> 
                              <td>Expenses 
                                on Labour </td>
                              <td align="center"> <lapschoice:CurrencyTag name="txt_ibatchivyear"size="10"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("labour"))%>' onKeyPress="allowInteger()"
									style="text-align:right;" /></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchivyear"size="10"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("labour"))%>' onKeyPress="allowInteger()"
									style="text-align:right;" /></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchivyear"size="10"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("labour"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchivyear"size="10"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("labour"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchivyear"size="10"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("labour"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchivyear"size="10"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("labour"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                            </tr>
                            <tr>
                              <td>Expenses 
                                on Electricity</td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchviiyear"size="10"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("dblelectricity"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchviiyear"size="10"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("dblelectricity"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchviiyear"size="10"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("dblelectricity"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchviiyear"size="10"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("dblelectricity"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchviiyear"size="10"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("dblelectricity"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchviiyear"size="10"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("dblelectricity"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                            </tr>
                            <tr>
                              <td>Expenses on Maintanence</td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchviiiyear"size="10"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("dblmaintain"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchviiiyear"size="10"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("dblmaintain"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchviiiyear"size="10"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("dblmaintain"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchviiiyear"size="10"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("dblmaintain"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchviiiyear"size="10"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("dblmaintain"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchviiiyear"size="10"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("dblmaintain"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                            </tr>
                            <tr> 
                              <td>
                                <input type="text" name="txt_specify3"size="25"
									maxlength="15" value="<%=Helper.correctNull((String)hshValues.get("txt_specify3"))%>" onKeyPress="allowInteger()"
									>
                              </td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchexpiyear"size="10"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("amountspec3"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchexpiyear"size="10"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("amountspec3"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchexpiyear" size="10"
									value='<%=Helper.correctNull((String)hshValues.get("amountspec3"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchexpiyear"size="10"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("amountspec3"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchexpiyear"size="10"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("amountspec3"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchexpiyear"size="10"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("amountspec3"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                            </tr>
                            <tr> 
                              <td>
                                <input type="text" name="txt_specify4"size="25"
									maxlength="15" value="<%=Helper.correctNull((String)hshValues.get("txt_specify4"))%>" onKeyPress="allowInteger()"
									>
                              </td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchexpiiyear"size="10"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("amountspec4"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchexpiiyear"size="10"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("amountspec4"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchexpiiyear"size="10"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("amountspec4"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchexpiiyear"size="10"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("amountspec4"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchexpiiyear"size="10"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("amountspec4"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchexpiiyear"size="10"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("amountspec4"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                            </tr>
                            <tr> 
                              <td><!--<b>Total</b>--></td>
                              <td align="center"><input type="hidden" name="txt_totiyearu" size="10"/></td>
                              <td align="center"><input type="hidden" name="txt_totiyearu" size="10"/></td>
                              <td align="center"><input type="hidden" name="txt_totiyearu" size="10"/></td>
                              <td align="center"><input type="hidden" name="txt_totiyearu" size="10" /></td>
                              <td align="center"><input type="hidden" name="txt_totiyearu" size="10"/></td>
                              <td align="center"><input type="hidden" name="txt_totiyearu" size="10" /></td>
                            </tr>
                            <%--<tr> 
                              <td height="27"><b>Capitalized 
                                Expenses</b></td>
                              <td align="center"><lapschoice:CurrencyTag  name="txt_totaliyearu1" size="10"
									 value='<//%=Helper.correctNull((String)hshValues.get("capitalizedExpenses"))%>' onBlur="callfirst()"
									 /></td>
                              <td align="center">&nbsp;</td>
                              <td align="center">&nbsp;</td>
                              <td align="center">&nbsp;</td>
                              <td align="center">&nbsp;</td>
                              <td align="center">&nbsp;</td>
                            </tr>--%>
                            <tr class="dataheader"> 
                              <td><b>Total(Expenses)</b></td>
                              <td align="center">
                                <input type="text" name="txt_totaliyearu2" size="10"
									maxlength="15" value="" onKeyPress="allowInteger()"
									readonly style="text-align:right;">
                              </td>
                              <td align="center">
                                <input type="text" name="txt_totaliyearu2" size="10"
									maxlength="15" value="" onKeyPress="allowInteger()"
									readonly style="text-align:right;">
                              </td>
                              <td align="center">
                                <input type="text" name="txt_totaliyearu2" size="10"
									maxlength="15" value="" onKeyPress="allowInteger()"
									readonly style="text-align:right;">
                              </td>
                              <td align="center">
                                <input type="text" name="txt_totaliyearu2" size="10"
									maxlength="15" value="" onKeyPress="allowInteger()"
									readonly style="text-align:right;">
                              </td>
                              <td align="center">
                                <input type="text" name="txt_totaliyearu2" size="10"
									maxlength="15" value="" onKeyPress="allowInteger()"
									readonly style="text-align:right;">
                              </td>
                              <td align="center">
                                <input type="text" name="txt_totaliyearu2" size="10"
									maxlength="15" value="" onKeyPress="allowInteger()"
									readonly style="text-align:right;">
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
</td>
</tr>
</table>
<br/>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:agrihiddentag pageid="<%=PageId%>"/>
<input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("auditFlag"))%>">
</form>
</body>
</html>