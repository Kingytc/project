<%@include file="../share/directives.jsp"%>
<%			ArrayList arryCol = null;
			ArrayList arryRow = (ArrayList) hshValues.get("arryRow");

			
			
			String txt_ostock="",txt_ostock2="",txt_ostock3="",txt_ostock4="";
			String txt_addlambs="",txt_addlambs2="",txt_addlambs3="",txt_addlambs4="";
			String txt_mortalityadults="",txt_mortalityadults2="",txt_mortalityadults3="",txt_mortalityadults4="";
			String txt_mortalitylambs="",txt_mortalitylambs2="",txt_mortalitylambs3="",txt_mortalitylambs4="";
			String txt_clostock="",txt_clostock2="",txt_clostock3="",txt_clostock4="";
			String txt_sale="",txt_sale2="",txt_sale3="",txt_sale4="";
		
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
var  varkidsval="<%=Helper.correctNull((String)hshValues.get("kidsvalue"))%>";




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
	
	document.forms[0].txt_ostock[0].readOnly=true;
	document.forms[0].txt_ostock2[0].readOnly=true;
	document.forms[0].txt_ostock3[0].readOnly=true;
	document.forms[0].txt_ostock4[0].readOnly=true;	
	
	for(var i=0;i<6;i++)
	{
		document.forms[0].txt_sale[i].readOnly=true;
		document.forms[0].txt_sale2[i].readOnly=true;
		document.forms[0].txt_sale3[i].readOnly=true;
		document.forms[0].txt_sale4[i].readOnly=true;
		
	}
	
	
}

function checkLamb(i , obj1)
{
	
	var varStock = document.forms[0].txt_ostock2[i].value;
	
	if(eval(varStock)<= 0)
	{
		alert("Opening stock of female is nil,  Lambing / Kidding / Pigletting is also nil")
		obj1.value="0";
	
	}
	
}

function doSave()
{	
   enableButtons( true, true, true, true, false);	
	document.forms[0].hidAction.value ="insert";
    document.forms[0].hidBeanId.value="agrpoultry";
	document.forms[0].hidSourceUrl.value="/action/agr_sheep_flockrep.jsp";
	document.forms[0].hidBeanMethod.value="updateagrsheepflock";
	document.forms[0].hidBeanGetMethod.value="getagrsheepflock";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doEdit()
{
 	disableFields(false);
 	checkkidsvalue();
	document.forms[0].txt_sale[0].readOnly=false;
	document.forms[0].txt_mortalityadults[0].readOnly=false;
	document.forms[0].txt_mortalitylambs[0].readOnly=false;
	document.forms[0].txt_addlambs[0].readOnly=false;
    document.forms[0].hideditflag.value ="Y";
	document.forms[0].hidAction.value ="insert";
    enableButtons(true, false, false, false, true);	
}

/* for enabling or disabling field based on the 
 selection in economic date(only male are sold)  
  */
function checkkidsvalue()
	{
	
	if(varkidsval=='1')
	{ 
		for(var i=0;i<6;i++)
		{  
		
		document.forms[0].txt_mortalitylambs2[i].readOnly=true;		
		document.forms[0].txt_mortalitylambs4[i].readOnly=true;

		document.forms[0].txt_mortalitylambs2[i].value='';
		document.forms[0].txt_mortalitylambs4[i].value='';
		
		}
	}	
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
		document.forms[0].hidBeanId.value="agrpoultry";
		document.forms[0].hidBeanGetMethod.value="getagrsheepflock";
		document.forms[0].action=appURL+"action/agr_sheep_flockrep.jsp";
		document.forms[0].submit(); 		
	}
	
}

function doDelete()
{
	if( ConfirmMsg(101))
	{
	document.forms[0].hidAction.value ="delete";
	document.forms[0].action=appURL+"action/ControllerServlet";		
	document.forms[0].hidBeanMethod.value="updateagrsheepflock";
	document.forms[0].hidBeanGetMethod.value="getagrsheepflock";
	document.forms[0].hidBeanId.value="agrpoultry";
	document.forms[0].hidSourceUrl.value="action/agr_sheep_flockrep.jsp";	
	document.forms[0].method="post";			
	document.forms[0].submit();
	}	
}

function onloading()
{	  
	disableFields(true);
		
	document.forms[0].txt_ostock[0].value="<%=Helper.correctNull((String)hshValues.get("txt_maleno"))%>";
	document.forms[0].txt_ostock2[0].value="<%=Helper.correctNull((String)hshValues.get("txt_femaleno"))%>";
	document.forms[0].txt_ostock3[0].value="0";
	document.forms[0].txt_ostock4[0].value="0";
	
	closingBal();
}

function closingBal()
{
	/*for(var i=0;i<5;i++)
	{
		document.forms[0].txt_ostock[i+1].value=document.forms[0].txt_sale[i].value;
		document.forms[0].txt_ostock2[i+1].value=document.forms[0].txt_sale2[i].value;
		document.forms[0].txt_ostock3[i+1].value=document.forms[0].txt_sale3[i].value;
		document.forms[0].txt_ostock4[i+1].value=document.forms[0].txt_sale4[i].value;
	}*/
}

function calculateBal(var2)
{
	
	for(var var1=0; var1<6;var1++)
	{
		var txt_ostock = document.forms[0].txt_ostock[var1].value;
		var txt_ostock2 = document.forms[0].txt_ostock2[var1].value;
		var txt_ostock3 = document.forms[0].txt_ostock3[var1].value;
		var txt_ostock4 = document.forms[0].txt_ostock4[var1].value;
		
		var txt_addlambs = document.forms[0].txt_addlambs[var1].value;
		var txt_addlambs2 = document.forms[0].txt_addlambs2[var1].value;
		var txt_addlambs3 = document.forms[0].txt_addlambs3[var1].value;
		var txt_addlambs4 = document.forms[0].txt_addlambs4[var1].value;
		
		var txt_mortalityadults = document.forms[0].txt_mortalityadults[var1].value;
		var txt_mortalityadults2 = document.forms[0].txt_mortalityadults2[var1].value;
		var txt_mortalityadults3 = document.forms[0].txt_mortalityadults3[var1].value;
		var txt_mortalityadults4 = document.forms[0].txt_mortalityadults4[var1].value;
		
		var txt_mortalitylambs = document.forms[0].txt_mortalitylambs[var1].value;
		var txt_mortalitylambs2 = document.forms[0].txt_mortalitylambs2[var1].value;
		var txt_mortalitylambs3 = document.forms[0].txt_mortalitylambs3[var1].value;
		var txt_mortalitylambs4 = document.forms[0].txt_mortalitylambs4[var1].value;
		
		var txt_clostock = document.forms[0].txt_clostock[var1].value;
		var txt_clostock2 = document.forms[0].txt_clostock2[var1].value;
		var txt_clostock3 = document.forms[0].txt_clostock3[var1].value;
		var txt_clostock4 = document.forms[0].txt_clostock4[var1].value;
		
		
		
		if(txt_ostock=="")
		txt_ostock ="0"
		if(txt_ostock2=="")
		txt_ostock2="0";
		if(txt_ostock3=="")
		txt_ostock3="0";
		if(txt_ostock4=="")
		txt_ostock4="0";
		
		if(txt_addlambs=="")
		txt_addlambs="0";
		if(txt_addlambs2=="")
		txt_addlambs2="0";
		if(txt_addlambs3=="")
		txt_addlambs3="0";
		if(txt_addlambs4=="")
		txt_addlambs4="0";
		
		if(txt_mortalityadults=="")
		txt_mortalityadults="0";
		if(txt_mortalityadults2=="")
		txt_mortalityadults2="0";
		if(txt_mortalityadults3=="")
		txt_mortalityadults3="0";
		if(txt_mortalityadults4=="")
		txt_mortalityadults4="0";
		
		if(txt_mortalitylambs=="")
		txt_mortalitylambs="0";
		if(txt_mortalitylambs2=="")
		txt_mortalitylambs2="0";
		if(txt_mortalitylambs3=="")
		txt_mortalitylambs3="0";
		if(txt_mortalitylambs4=="")
		txt_mortalitylambs4="0";
		
		if(txt_clostock=="")
		txt_clostock="0";
		if(txt_clostock2=="")
		txt_clostock2="0";
		if(txt_clostock3=="")
		txt_clostock3="0";
		if(txt_clostock4=="")
		txt_clostock4="0";
		
		if(txt_sale=="")
		txt_sale="0";
		if(txt_sale2=="")
		txt_sale2="0";
		if(txt_sale3=="")
		txt_sale3="0";
		if(txt_sale4=="")
		txt_sale4="0";
		
		var txt_sale = "";
		var txt_sale2 = "";
		var txt_sale3 = "";
		var txt_sale4 = "";
		
		txt_sale = (eval(txt_ostock)+eval(txt_addlambs)+eval(txt_clostock))-(eval(txt_mortalityadults)+eval(txt_mortalitylambs));
		txt_sale2 = (eval(txt_ostock2)+eval(txt_addlambs2)+eval(txt_clostock2))-(eval(txt_mortalityadults2)+eval(txt_mortalitylambs2));
		txt_sale3 = (eval(txt_ostock3)+eval(txt_addlambs3)+eval(txt_clostock3))-(eval(txt_mortalityadults3)+eval(txt_mortalitylambs3))
		txt_sale4 = (eval(txt_ostock4)+eval(txt_addlambs4)+eval(txt_clostock4))-(eval(txt_mortalityadults4)+eval(txt_mortalitylambs4))
		
		document.forms[0].txt_sale[var1].value=txt_sale;
		document.forms[0].txt_sale2[var1].value=txt_sale2;
		document.forms[0].txt_sale3[var1].value=txt_sale3;
		document.forms[0].txt_sale4[var1].value=txt_sale4;
		
		closingBal();
	}	
}






function enableButtons( bool2, bool3, bool4, bool5, bool6)
{	
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled = bool6;
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="onloading()">
<form name="frmpri" method="post" class="normal">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td valign="top">		
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td>
					<table width="100%" border="0" cellspacing="0" cellpadding="1"  class="outertable">
						<tr>
                  			<td> 
								<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
									<tr> 
                        				<td> 
											<table width="100%" border="0" cellspacing="0" cellpadding="0"  class="outertable border1" align="center">
												<tr>
													<td valign="top">
														<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                            								<tr> 
                              									<td> 
                              										
                                      <table width="100%" border="0" cellspacing="1" cellpadding="1" class="outertable">
                                        <tr class="dataheader"> 
                  
                                          <td width="4%" rowspan="2" align="center">Project 
                                            Year<br>
                                            (1)</td>
                                          <td align="center" colspan="4">OPENSTOCK 
                                            (O)</td>
                                          <td align="center" colspan="2">Lambing 
                                            / Kidding / Pigletting (A)</td>
                                          <td colspan="3" align="center"> 
                                            MORTALITY (B)</td>
                                          <td colspan="4" align="center"> 
                                            CULLINGSALE (C)</td>
                                          <td colspan="2" align="center"> 
                                            PURCHASE (D)</td>
                                          <td colspan="4" align="center">
                                            Closing 
                                              stock(O+A-B-C+D)
                                            </td>
                                          
                                        </tr>
                                        <tr class="dataheader"> 
                                          <td width="3%" align="center">MALE</td>
                                          <td width="4%" align="center">FEMALE</td>
                                          <td width="3%" align="center">MALE 
                                            lambs /<br>kids /<br>piglets</td>
                                          <td width="6%" align="center">FEMALE 
                                            lambs /<br>kids /<br>piglets</td>
                                          <td width="3%" align="center" style="display:none">MALE</td>
                                          <td width="4%" align="center" style="display:none">FEMALE</td>
                                          <td width="3%" align="center">MALE 
                                            lambs /<br>kids /<br>piglets</td>
                                          <td width="5%" align="center">FEMALE 
                                            lambs /<br>kids /<br>piglets</td>
                                          <td width="3%" align="center" style="display:none">MALE</td>
                                          <td width="4%" align="center">FEMALE</td>
                                          <td width="3%" align="center">MALE 
                                            lambs /<br>kids /<br>piglets</td>
                                          <td width="5%" align="center">FEMALE 
                                            lambs /<br>kids /<br>piglets</td>
                                          <td width="3%" align="center">MALE</td>
                                          <td width="4%" align="center">FEMALE</td>
                                          <td width="3%" align="center">MALE 
                                            lambs /<br>kids /<br>piglets</td>
                                          <td width="6%" align="center">FEMALE 
                                            lambs /<br>kids /<br>piglets</td>
                                          <td width="3%" align="center"> 
                                            <table width="99%" border="0" cellspacing="1" cellpadding="2" dwcopytype="CopyTableCell">
                                              <tr class="dataheader"> 
                                                <td width="5%" align="center">MALE</td>
                                              </tr>
                                              <%for (int i = 1; i <7; i++) {
                                            	  
                                            	  
				                         %>
                                              <%}
					%>
                                            </table>
                                          </td>
                                          <td width="4%" align="center">FEMALE</td>
                                          <td width="3%" align="center" style="display:none">MALE 
                                            lambs /<br>kids /<br>piglets</td>
                                          <td width="5%" align="center" style="display:none">FEMALE 
                                            lambs /<br>kids /<br>piglets</td>
                                          <td width="3%" align="center">MALE</td>
                                          <td width="4%" align="center">FEMALE</td>
                                          <td width="3%" align="center">MALE 
                                            lambs /<br>kids /<br>piglets</td>
                                          <td width="4%" align="center">FEMALE 
                                            lambs /<br>kids /<br>piglets</td>
                                        </tr>
                                        <%for (int i = 0; i <6; i++) {
                                        	
                                        	if(arryRow!=null)
                                      	  {
                                      		 
                                      		if(arryRow.size()!=0)
                                      		{	
                                          		arryCol = ((ArrayList) arryRow.get(i)); 
                                          		
                                          		txt_ostock=Helper.correctNull((String)arryCol.get(0));
                                        			txt_ostock2=Helper.correctNull((String)arryCol.get(1));
                                        			txt_ostock3=Helper.correctNull((String)arryCol.get(2));
                                        			txt_ostock4=Helper.correctNull((String)arryCol.get(3));
                                        			
                                        			
                                        			
                                        			txt_addlambs=Helper.correctNull((String)arryCol.get(4));
                                        			txt_addlambs2=Helper.correctNull((String)arryCol.get(5));
                                        			txt_addlambs3=Helper.correctNull((String)arryCol.get(6));
                                        			txt_addlambs4=Helper.correctNull((String)arryCol.get(7));
                                        			
                                        			txt_mortalityadults=Helper.correctNull((String)arryCol.get(8));
                                        			txt_mortalityadults2=Helper.correctNull((String)arryCol.get(9));
                                        			txt_mortalityadults3=Helper.correctNull((String)arryCol.get(10));
                                        			txt_mortalityadults4=Helper.correctNull((String)arryCol.get(11));
                                        			
                                        		
                                        			
                                        			txt_mortalitylambs=Helper.correctNull((String)arryCol.get(12));
                                        			txt_mortalitylambs2=Helper.correctNull((String)arryCol.get(13));
                                        			txt_mortalitylambs3=Helper.correctNull((String)arryCol.get(14));
                                        			txt_mortalitylambs4=Helper.correctNull((String)arryCol.get(15));
                                        			
                                        			
                                        			
                                        			
                                        			txt_clostock=Helper.correctNull((String)arryCol.get(16));
                                        			txt_clostock2=Helper.correctNull((String)arryCol.get(17));
                                        			txt_clostock3=Helper.correctNull((String)arryCol.get(18));
                                        			txt_clostock4=Helper.correctNull((String)arryCol.get(19));
                                        			
                                        			txt_sale=Helper.correctNull((String)arryCol.get(20));
                                        			txt_sale2=Helper.correctNull((String)arryCol.get(21));
                                        			txt_sale3=Helper.correctNull((String)arryCol.get(22));
                                        			txt_sale4=Helper.correctNull((String)arryCol.get(23));
                                      		}
                                    		
                                      	  }
				                         %>
                                        <tr align="center"> 
                                          <td width="4%" class="dataheader"><%=i+1%> 
                                            year </td>
                                          <td width="3%"> 
                                            <input type="text" name="txt_ostock"
									value="<%=txt_ostock%>" size="6" onKeyPress="allowInteger()" maxlength="4">
                                          </td>
                                          <td width="4%"> 
                                            <input type="text" name="txt_ostock2"
									value="<%=txt_ostock2%>" size="6" onKeyPress="allowInteger()" maxlength="4">
                                          </td>
                                          <td width="3%"> 
                                            <input type="text" name="txt_ostock3"
									value="<%=txt_ostock3%>" size="6" onKeyPress="allowInteger()" maxlength="4">
                                          </td>
                                          <td width="6%"> 
                                            <input type="text" name="txt_ostock4"
									value="<%=txt_ostock4%>" size="6" onKeyPress="allowInteger()" maxlength="4">
                                          </td>
                                          <td width="3%" style="display:none"> 
                                            <input type="text" name="txt_addlambs"
									value="<%=txt_addlambs%>" size="6" onBlur ="calculateBal('<%=i%>');checkLamb('<%=i%>',this)" onKeyPress="allowInteger()" maxlength="4">
                                          </td>
                                          <td width="4%" style="display:none"> 
                                            <input type="text" name="txt_addlambs2"
									value="<%=txt_addlambs2%>" size="6" onKeyPress="allowInteger()" maxlength="4" onBlur ="calculateBal('<%=i%>');checkLamb('<%=i%>',this)">
                                          </td>
                                          <td width="3%"> 
                                            <input type="text" name="txt_addlambs3"
									value="<%=txt_addlambs3%>" size="6" onKeyPress="allowInteger()" 
									onBlur ="calculateBal('<%=i%>');checkLamb('<%=i%>',this);" maxlength="4">
                                          </td>
                                          <td width="5%"> 
                                            <input type="text" name="txt_addlambs4"
									value="<%=txt_addlambs4%>" size="6" onKeyPress="allowInteger()" maxlength="4" onBlur ="calculateBal('<%=i%>');checkLamb('<%=i%>',this);">
                                          </td>
                                          <td width="3%" style="display:none"> 
                                            <input type="text" name="txt_mortalityadults" size="6"
									value="<%=txt_mortalityadults%>" onKeyPress="allowInteger()" maxlength="4" onBlur ="calculateBal('<%=i%>')">
                                          </td>
                                          <td width="4%"> 
                                            <input type="text" name="txt_mortalityadults2" size="6"
									value="<%=txt_mortalityadults2%>" onKeyPress="allowInteger()" maxlength="4" onBlur ="calculateBal('<%=i%>')">
                                          </td>
                                          <td width="3%"> 
                                            <input type="text" name="txt_mortalityadults3" size="6"
									value="<%=txt_mortalityadults3%>" onKeyPress="allowInteger()" maxlength="4" onBlur ="calculateBal('<%=i%>')">
                                          </td>
                                          <td width="5%"> 
                                            <input type="text" name="txt_mortalityadults4" size="6"
									value="<%=txt_mortalityadults4%>" onKeyPress="allowInteger()" maxlength="4" onBlur ="calculateBal('<%=i%>')">
                                          </td>
                                          <td width="3%"> 
                                            <input type="text" name="txt_mortalitylambs" size="6"
									value="<%=txt_mortalitylambs%>" onKeyPress="allowInteger()" maxlength="4" onBlur ="calculateBal('<%=i%>')">
                                          </td>
                                          <td width="4%"> 
                                            <input type="text" name="txt_mortalitylambs2" size="6"
									value="<%=txt_mortalitylambs2%>" onKeyPress="allowInteger()" maxlength="4" onBlur ="calculateBal('<%=i%>')">
                                          </td>
                                          <td width="3%"> 
                                            <input type="text" name="txt_mortalitylambs3" size="6"
									value="<%=txt_mortalitylambs3%>" onKeyPress="allowInteger()" maxlength="4" onBlur ="calculateBal('<%=i%>')">
                                          </td>
                                          <td width="6%"> 
                                            <input type="text" name="txt_mortalitylambs4" size="6"
									value="<%=txt_mortalitylambs4%>" onKeyPress="allowInteger()" maxlength="4" onBlur ="calculateBal('<%=i%>')">
                                          </td>
                                          <td width="3%"> 
                                           <input type="text" name="txt_clostock" size="6"
									value="<%=txt_clostock%>" onKeyPress="allowInteger()"
									style="text-align:right" maxlength="4" onBlur ="calculateBal('<%=i%>')">
                                          </td>
                                          <td width="4%"> 
                                            <input type="text" name="txt_clostock2" size="6"
									value="<%=txt_clostock2%>" onKeyPress="allowInteger()" maxlength="4" onBlur ="calculateBal('<%=i%>')">
                                          </td>
                                          <td width="3%" style="display:none"> 
                                            <input type="text" name="txt_clostock3" size="6"
									value="<%=txt_clostock3%>" onKeyPress="allowInteger()" maxlength="4" onBlur ="calculateBal('<%=i%>')">
                                          </td>
                                          <td width="5%" style="display:none"> 
                                            <input type="text" name="txt_clostock4" size="6"
									value="<%=txt_clostock4%>" onKeyPress="allowInteger()" maxlength="4" onBlur ="calculateBal('<%=i%>')">
                                          </td>
                                          <td width="3%"> 
                                            <input type="text" name="txt_sale" size="6"
									value="<%=txt_sale%>" onKeyPress="allowInteger()"
									style="text-align:right" maxlength="4" onBlur ="calculateBal('<%=i%>')">
                                          </td>
                                          <td width="4%"> 
                                            <input type="text" name="txt_sale2" size="6"
									value="<%=txt_sale2%>" onKeyPress="allowInteger()"
									style="text-align:right" maxlength="4" onBlur ="calculateBal('<%=i%>')">
                                          </td>
                                          <td width="3%"> 
                                            <input type="text" name="txt_sale3" size="6"
									value="<%=txt_sale3%>" onKeyPress="allowInteger()"
									style="text-align:right" maxlength="4" onBlur ="calculateBal('<%=i%>')">
                                          </td>
                                          <td width="4%"> 
                                            <input type="text" name="txt_sale4" size="6"
									value="<%=txt_sale4%>" onKeyPress="allowInteger()"
									style="text-align:right" maxlength="4" onBlur ="calculateBal('<%=i%>')">
                                          </td>
                                         </tr>
                                        <%}
					%>
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
</td>
</tr>
</table>
</td>
</tr>
</table>
<br/>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<p class="mantatory"> 
<b>Note<b class="mantatory">*</b>:</b> The cost of purchase of adult 
  will be compensated with selling of old animals</p> 
<lapschoice:agrihiddentag pageid='<%=PageId%>' />
<input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("auditFlag"))%>">
</form>
</body>
</html>


