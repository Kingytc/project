
<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />

<%if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
			}
			
			int vecsize = 0;
			int vecsize1 = 0;
			
			String strapptype = "";
			String apptype = "";
			String app_status = Helper.correctNull((String) hshValues
					.get("app_status"));
			 	String measurementtype = Helper.correctNull((String)hshValues.get("land_measurement"));
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
<%ArrayList arryCol = new ArrayList();
ArrayList arryRow= new ArrayList();
arryRow = (ArrayList) hshValues.get("arryRow");

if (arryRow == null) {
	arryRow = new ArrayList();
}

String l1="",l2="",l3="",l4="",l5="",l6="",l7="",l8="",l9="",l10="",l11="",l12="",i1="";
String a1="",a2="",a3="",a4="",a5="",a6="",a7="",a8="",a9="",a10="",a11="",a12="";
String b1="",b2="",b3="",b4="",b5="",b6="",b7="",b8="",b9="",b10="",b11="",b12="";
String c1="",c2="",c3="",c4="",c5="",c6="",c7="",c8="",c9="",c10="",c11="",c12="";
String d1="",d2="",d3="",d4="",d5="",d6="",d7="",d8="",d9="",d10="",d11="",d12="";
String e1="",e2="",e3="",e4="",e5="",e6="",e7="",e8="",e9="",e10="",e11="",e12="";
String f1="",f2="",f3="",f4="",f5="",f6="",f7="",f8="",f9="",f10="",f11="",f12="";
String g1="",g2="",g3="",g4="",g5="",g6="",g7="",g8="",g9="",g10="",g11="",g12="";
String h1="",h2="",h3="",h4="",h5="",h6="",h7="",h8="",h9="",h10="",h11="",h12="";
java.text.NumberFormat nf = java.text.NumberFormat
		.getNumberInstance();
nf.setGroupingUsed(false);
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
%>
<html>
<head>
<title>LAPS -Assesment Form Details</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>

<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var id ="";
var apptype="";
   
var varApptype=new Array();
var varAcctype=new Array();
var varAcctype1=new Array();
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var  strid="<%=Helper.correctNull((String)hshValues.get("strid"))%>";
var  strAction="<%=Helper.correctNull((String)hshValues.get("strAction"))%>";
function enableButtons( bool2, bool3, bool4, bool5, bool6)
{	
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdapply.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddel.disabled=bool5;
	//document.forms[0].cmdclose.disabled = bool6;
}


function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/"+"perresult.jsp";
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
}


function doEdit()
{
 	disableFields(false);
    for(var i=0;i<=11;i++)
	{
	document.forms[0].txt_netinc[i].readOnly=true;
	document.forms[0].txt_totincome[i].readOnly=true;
	}
	document.forms[0].hideditflag.value ="Y";
	document.forms[0].hidAction.value ="insert";
	enableButtons(true, false, false, true, true);	
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
		document.forms[0].hidSourceUrl.value="/action/agr_coffee_economics.jsp";
		document.forms[0].hidBeanId.value="agrcoffee";
		document.forms[0].hidBeanGetMethod.value="getcoffeeeconomicsdata";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit(); 		
	}
	//disableCommandButtons("load");
}

function doDelete()
{
if(ConfirmMsg(101))
	{
	document.forms[0].hidAction.value ="delete";
	document.forms[0].action=appUrl+"action/ControllerServlet";		
	document.forms[0].hidBeanMethod.value="updatecoffeeeconomicsdata";
	document.forms[0].hidBeanGetMethod.value="getcoffeeeconomicsdata";
	document.forms[0].hidBeanId.value="agrcoffee";
	document.forms[0].hidSourceUrl.value="action/agr_coffee_economics.jsp";	
	document.forms[0].method="post";			
	document.forms[0].submit();		
	
	}
}

function onloading()
{	  

	disableFields(true);
	enableButtons( false, true, true, false, false);
}

function callSurplus()
{

for(var m=0;m<=11;m++)
{

var sur1 =  document.forms[0].txt_yield[m].value;
var sur2=document.forms[0].txt_cult[m].value;
     if(sur1=="")
		{
			sur1=0.00;
			
		}
		if(sur2=="")
		{
			sur2=0.00;
			
		}
		
		
	   
   
  document.forms[0].txt_netinc[m].value= eval(sur1)-eval(sur2);
  roundtxt(document.forms[0].txt_netinc[m]);
   var cost_val= document.forms[0].txt_netinc[m].value;
	
  if(document.forms[0].txt_netinc[m].value=="NaN")
	{
	document.forms[0].txt_netinc[m].value= "0.00" ;
	}
}

 
}
function callincome()
{

for(var m=0;m<=11;m++)
{

var sur1 =  document.forms[0].txt_netinc[m].value;
var sur2=document.forms[0].txt_amount[m].value;
     if(sur1=="")
		{
			sur1=0.00;
			
		}
		if(sur2=="")
		{
			sur2=0.00;
			
		}
		
		
	   
   
  document.forms[0].txt_totincome[m].value= eval(sur1)+eval(sur2);
   roundtxt(document.forms[0].txt_totincome[m]);
 
   var cost_val= document.forms[0].txt_totincome[m].value;
	
  if(document.forms[0].txt_totincome[m].value=="NaN")
	{
	document.forms[0].txt_totincome[m].value= "0.00" ;
	}
}
}
function doSave()
{	
   callSurplus();callincome();
  	enableButtons( true, true, false, true, true);	
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hidBeanId.value="agrcoffee";
	document.forms[0].hidSourceUrl.value="/action/agr_coffee_economics.jsp";
	document.forms[0].hidBeanMethod.value="updatecoffeeeconomicsdata";
	document.forms[0].hidBeanGetMethod.value="getcoffeeeconomicsdata";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
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
<body onLoad="onloading();callSurplus();callincome()">
<form name="frmpri" method="post">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td valign="top">		
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="1"
					bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
					<tr>
						
                  <td> 
<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable border1">
                      <tr> 
                        <td  colspan="13">
						 <table width="100%" border="0" cellspacing="2" cellpadding="1"
									bgcolor="#DEDACF">
                            <tr bgcolor="#71694F" BORDER="1"> 
							<% measurementtype = Helper.correctNull((String)hshValues.get("land_measurement"));
          	 measurementval="";
        	if(measurementtype.equalsIgnoreCase("c"))
  	  		{
  	 
  	  			 measurementval = "Cents";
  	 		 }
  	 		 else
  	  			{
  					measurementval = "Guntas";
  	 			}
           
			%>
                              <td rowspan="2" bgcolor="#71694F"><b>Year/season</b></td>
                              <td rowspan="2" align="center" bgcolor="#71694F"><b>Area 
                                (acres/<%=	measurementval%>)in a (Bearing)</b></td>
                              <td colspan="2" align="center" bgcolor="#71694F"><b>Yield 
                                in tonnes/kgs</b></td>
                              <td rowspan="2" align="center" bgcolor="#71694F"><b>Value 
                                of yield</b></td>
                              <td rowspan="2" align="center" bgcolor="#71694F"><b>Cultivation 
                                Expenses </b></td>
                              <td rowspan="2" align="center" bgcolor="#71694F"><b>Net 
                                Income </b></td>
                              <td rowspan="2" align="center" bgcolor="#71694F"><b>Net 
                                Income from other sources *</b></td>
                              <td rowspan="2" align="center" bgcolor="#71694F"><b>Total of 
                                net income</b></td>
                            </tr>
                            <tr bgcolor="#71694F" BORDER="1"> 
                              <td width="4%" align="center" bgcolor="#71694F"><b>Arabica</b></td>
                              <td width="12%" align="center" bgcolor="#71694F"><b>Robusta</b></td>
                            </tr>
                            <tr> 
                              <td bgcolor="#71694F"><b>(1)</b></td>
                              <td align="center" bgcolor="#71694F"><b>(2) 
                                </b></td>
                              <td align="center" bgcolor="#71694F"><b>(3a)</b></td>
                              <td align="center" bgcolor="#71694F"><b>(3b)</b></td>
                              <td align="center" bgcolor="#71694F"><b>(4)</b></td>
                              <td align="center" bgcolor="#71694F"><b>(5)</b></td>
                              <td align="center" bgcolor="#71694F"><b>(6)=(4-5)</b></td>
                              <td align="center" bgcolor="#71694F"><b>(7)</b></td>
                              <td align="center" bgcolor="#71694F"><b>(8)=(6+7)</b></td>
                            </tr>
                            <tr> 
                            <%

                    if(arryRow.size()!=0){
	                    arryCol = (ArrayList)arryRow.get(0);
	                   
						if(arryCol.size()!=0)
						{

						 l1=Helper.correctNull((String)arryCol.get(3)); 
						a1=Helper.correctNull((String)arryCol.get(4));
					    b1=Helper.correctNull((String)arryCol.get(5));
					    c1=Helper.correctNull((String)arryCol.get(6));
					    d1=Helper.correctNull((String)arryCol.get(7));
					   e1=Helper.correctNull((String)arryCol.get(8));
					   f1=Helper.correctNull((String)arryCol.get(9));
					   g1=Helper.correctNull((String)arryCol.get(10));
					    h1=Helper.correctNull((String)arryCol.get(11));
					  
					}
					}
                   
                  
                    else if(arryRow.size()==0){
                    	//l1="0";
                    	a1="";
                    	b1="";
                    	c1="";
                    	d1="";
                        e1="";
                        f1="0.00";
						g1="";
						h1="";
						
                    	
                    }
                    
                    %>
                              
                              <td width="23%" > 
                                <input type="text" name="txt_year" size="30"	maxlength="20" value='<%=l1%>' 	onKeyPress=""	>
                              </td>
                              <td width="9%"> <table width="40%" border="0" cellspacing="0" cellpadding="1">
                                  <tr> 
                                    <td><lapschoice:CurrencyTag name="txt_area" size="10"
											maxlength="5" value='<%=a1%>'
											/></td>
                                    <td>&nbsp;</td>
                                  </tr>
                                </table></td>
                              <td > <lapschoice:CurrencyTag name="txt_arabica" size="10" maxlength="5"
									value='<%=b1%>' /> </td>
                              <td ><lapschoice:CurrencyTag name="txt_robusta" size="10" maxlength="5"
									value='<%=c1%>' /></td>
                              <td width="7%"> <table width="40%" border="0" cellspacing="0" cellpadding="1">
                                  <tr> 
                                    <td> <lapschoice:CurrencyTag name="txt_yield"  size="10"
											maxlength="10" value='<%=d1%>' 
											onBlur="callSurplus()" /> 
                                    </td>
                                    <td>&nbsp;</td>
                                  </tr>
                                </table></td>
                              <td width="8%" > <lapschoice:CurrencyTag name="txt_cult" size="10"
									maxlength="10" value='<%=e1%>' 
									onBlur="callSurplus()" /></td>
                              <td width="8%" > <lapschoice:CurrencyTag name="txt_netinc"  size="10" maxlength="10"
									value='<%=f1%>' /></td>
                              <td width="8%"> <lapschoice:CurrencyTag name="txt_amount"  size="10" maxlength="10" value="<%=g1%>" onBlur="callincome()" /></td>
                              <td width="13%" > <lapschoice:CurrencyTag name="txt_totincome"  size="10" maxlength="15"
									value='<%=h1%>' 
									onBlur="" /></td>
                            </tr>
                            <tr> 
                    <%

                    if(arryRow.size()!=0){
	                    arryCol = (ArrayList)arryRow.get(1);
	                   
						if(arryCol.size()!=0)
						{

						 l2=Helper.correctNull((String)arryCol.get(3)); 
						a2=Helper.correctNull((String)arryCol.get(4));
					   b2=Helper.correctNull((String)arryCol.get(5));
					    c2=Helper.correctNull((String)arryCol.get(6));
					    d2=Helper.correctNull((String)arryCol.get(7));
					   e2=Helper.correctNull((String)arryCol.get(8));
					   f2=Helper.correctNull((String)arryCol.get(9));
					   g2=Helper.correctNull((String)arryCol.get(10));
					   h2=Helper.correctNull((String)arryCol.get(11));
					    
					}
					}
                   
                  
                    else if(arryRow.size()==0){
                    
                        a2="";
                        b2="";
                    	c2="";
                    	d2="";
                        e2="";
                        f2="";
					    g2="";
						h2="";
						
                    	
                    }
                    
                    %>
                              
                              <td><input type="text" name="txt_year" size="30"	maxlength="20"
									value='<%=l2%>' 	onKeyPress=""	></td>
                              <td> <table width="40%" border="0" cellspacing="0" cellpadding="1">
                                  <tr> 
                                    <td><lapschoice:CurrencyTag name="txt_area" size="10"
											maxlength="5" value='<%=a2%>' 		
											/></td>
                                    <td>&nbsp;</td>
                                  </tr>
                                </table></td>
                              <td><lapschoice:CurrencyTag name="txt_arabica" size="10" maxlength="5"
									value='<%=b2%>' 	/> </td>
                              <td><lapschoice:CurrencyTag name="txt_robusta" size="10" maxlength="5"
									value='<%=c2%>' 	/></td>
                              <td> <table width="40%" border="0" cellspacing="0" cellpadding="1">
                                  <tr> 
                                    <td><lapschoice:CurrencyTag name="txt_yield"  size="10"
											maxlength="10" value='<%=d2%>'
											 onBlur="callSurplus()"
											/></td>
                                    <td>&nbsp;</td>
                                  </tr>
                                </table></td>
                              <td><lapschoice:CurrencyTag name="txt_cult" size="10"
									maxlength="10" value='<%=e2%>' 
									onBlur="callSurplus()" /></td>
                              <td><lapschoice:CurrencyTag name="txt_netinc"  size="10" maxlength="10"
									value='<%=f2%>' /></td>
                              <td><lapschoice:CurrencyTag name="txt_amount"  size="10"
									maxlength="10" value='<%=g2%>' 
									onBlur="callincome()" /></td>
                              <td><lapschoice:CurrencyTag name="txt_totincome"  size="10" maxlength="10"
									value='<%=h2%>' 
									/></td>
                            </tr>
                            <tr> 
                 <%

                    if(arryRow.size()!=0){
	                    arryCol = (ArrayList)arryRow.get(2);
	                   
						if(arryCol.size()!=0)
						{

						 l3=Helper.correctNull((String)arryCol.get(3)); 
						a3=Helper.correctNull((String)arryCol.get(4));
					    b3=Helper.correctNull((String)arryCol.get(5));
					    c3=Helper.correctNull((String)arryCol.get(6));
					    d3=Helper.correctNull((String)arryCol.get(7));
					   e3=Helper.correctNull((String)arryCol.get(8));
					   f3=Helper.correctNull((String)arryCol.get(9));
					   g3=Helper.correctNull((String)arryCol.get(10));
					    h3=Helper.correctNull((String)arryCol.get(11));
					  
					}
					}
                   
                  
                    else if(arryRow.size()==0){
                    	//l1="0";
                    	a3="";
                        b3="";
                    	c3="";
                    	d3="";
                        e3="";
                    	f3="";
						g3="";
						h3="";
						
                    	
                    }
                    
                    %>
                              
                              <td><input type="text" name="txt_year" size="30"	maxlength="20"
									value='<%=l3%>' 	onKeyPress=""	> </td>
                              <td> <table width="40%" border="0" cellspacing="0" cellpadding="1">
                                  <tr> 
                                    <td><lapschoice:CurrencyTag name="txt_area" size="10"
											maxlength="5" value='<%=a3%>' 		
											/></td>
                                    <td>&nbsp;</td>
                                  </tr>
                                </table></td>
                              <td> <lapschoice:CurrencyTag name="txt_arabica" size="10" maxlength="5"
									value='<%=b3%>' 	/> 
                              </td>
                              <td><lapschoice:CurrencyTag name="txt_robusta" size="10" maxlength="5"
									value='<%=c3%>' 	/></td>
                              <td> <table width="40%" border="0" cellspacing="0" cellpadding="1">
                                  <tr> 
                                    <td> <lapschoice:CurrencyTag name="txt_yield"  size="10"
											maxlength="10" value='<%=d3%>'
											 onBlur="callSurplus()"
											/> </td>
                                    <td>&nbsp;</td>
                                  </tr>
                                </table></td>
                              <td><lapschoice:CurrencyTag name="txt_cult" size="10"
									maxlength="10" value='<%=e3%>' 
									onBlur="callSurplus()" /></td>
                              <td><lapschoice:CurrencyTag name="txt_netinc" size="10" maxlength="10"
									value='<%=f3%>' /></td>
                              <td><lapschoice:CurrencyTag name="txt_amount"  size="10"
									maxlength="10" value='<%=g3%>' 
									onBlur="callincome()" /></td>
                              <td><lapschoice:CurrencyTag name="txt_totincome"  size="10" maxlength="10"
									value='<%=h3%>' /></td>
                            </tr>
                            <tr> 
                             <%

                    if(arryRow.size()!=0){
	                    arryCol = (ArrayList)arryRow.get(3);
	                   
						if(arryCol.size()!=0)
						{

						 l4=Helper.correctNull((String)arryCol.get(3)); 
						a4=Helper.correctNull((String)arryCol.get(4));
					    b4=Helper.correctNull((String)arryCol.get(5));
					    c4=Helper.correctNull((String)arryCol.get(6));
					    d4=Helper.correctNull((String)arryCol.get(7));
					   e4=Helper.correctNull((String)arryCol.get(8));
					   f4=Helper.correctNull((String)arryCol.get(9));
					   g4=Helper.correctNull((String)arryCol.get(10));
					    h4=Helper.correctNull((String)arryCol.get(11));
					  
					}
					}
                   
                  
                    else if(arryRow.size()==0){
                    	//l1="0";
                    	a4="";
                        b4="";
                    	c4="";
                    	d4="";
                        e4="";
                    	f4="";
						g4="";
						h4="";
						
                    	
                    }
                    
                    %>
                              <td><input type="text" name="txt_year" size="30"	maxlength="20"
									value='<%=l4%> ' 	onKeyPress=""	></td>
                              <td> <table width="40%" border="0" cellspacing="0" cellpadding="1">
                                  <tr> 
                                    <td><lapschoice:CurrencyTag name="txt_area" size="10"
											maxlength="5" value='<%=a4%>' 		
											/></td>
                                    <td>&nbsp;</td>
                                  </tr>
                                </table></td>
                              <td> <lapschoice:CurrencyTag name="txt_arabica" size="10" maxlength="5"
									value='<%=b4%>' 		
									onBlur=""/> 
                              </td>
                              <td><lapschoice:CurrencyTag name="txt_robusta" size="10" maxlength="5"
									value='<%=c4%>' 	/></td>
                              <td> <table width="40%" border="0" cellspacing="0" cellpadding="1">
                                  <tr> 
                                    <td> <lapschoice:CurrencyTag name="txt_yield"  size="10"
											maxlength="10" value='<%=d4%>'
											 onBlur="callSurplus()"
											/> </td>
                                    <td>&nbsp;</td>
                                  </tr>
                                </table></td>
                              <td><lapschoice:CurrencyTag name="txt_cult" size="10"
									maxlength="10" value='<%=e4%>' 
									onBlur="callSurplus()" /></td>
                              <td><lapschoice:CurrencyTag name="txt_netinc" size="10" maxlength="10"
									value='<%=f4%>' /></td>
                              <td><lapschoice:CurrencyTag name="txt_amount"  size="10"
									maxlength="10" value='<%=g4%>' 
									onBlur="callincome()" /></td>
                              <td><lapschoice:CurrencyTag name="txt_totincome"  size="10" maxlength="10"
									value='<%=h4%>' /></td>
                            </tr>
                            <tr> 
							 <%

                    if(arryRow.size()!=0){
	                    arryCol = (ArrayList)arryRow.get(4);
	                   
						if(arryCol.size()!=0)
						{

						 l5=Helper.correctNull((String)arryCol.get(3)); 
						a5=Helper.correctNull((String)arryCol.get(4));
					    b5=Helper.correctNull((String)arryCol.get(5));
					    c5=Helper.correctNull((String)arryCol.get(6));
					    d5=Helper.correctNull((String)arryCol.get(7));
					   e5=Helper.correctNull((String)arryCol.get(8));
					   f5=Helper.correctNull((String)arryCol.get(9));
					   g5=Helper.correctNull((String)arryCol.get(10));
					    h5=Helper.correctNull((String)arryCol.get(11));
					  
					}
					}
                   
                  
                    else if(arryRow.size()==0){
                    	//l1="0";
                    	a5="";
                        b5="";
                    	c5="";
                    	d5="";
                        e5="";
                    	f5="";
						g5="";
						h5="";
						
                    	
                    }
                    
                    %>
			 <td><input type="text" name="txt_year" size="30"	maxlength="20"
									value='<%=l5%> ' 	onKeyPress=""	></td>
                              <td> <table width="40%" border="0" cellspacing="0" cellpadding="1">
                                  <tr> 
                                    <td><lapschoice:CurrencyTag name="txt_area" size="10"
											maxlength="5" value='<%=a5%>' 		
											/></td>
                                    <td>&nbsp;</td>
                                  </tr>
                                </table></td>
                              <td> <lapschoice:CurrencyTag name="txt_arabica" size="10" maxlength="5"
									value='<%=b5%>' 		
									onBlur=""/> 
                              </td>
                              <td><lapschoice:CurrencyTag name="txt_robusta" size="10" maxlength="5"
									value='<%=c5%>' 	/></td>
                              <td> <table width="40%" border="0" cellspacing="0" cellpadding="1">
                                  <tr> 
                                    <td><lapschoice:CurrencyTag name="txt_yield"  size="10"
											maxlength="10" value='<%=d5%>' 
											onBlur="callSurplus()" /></td>
                                    <td>&nbsp;</td>
                                  </tr>
                                </table></td>
                              <td><lapschoice:CurrencyTag name="txt_cult" size="10"
									maxlength="10" value='<%=e5%>' 
									onBlur="callSurplus()" /></td>
                              <td><lapschoice:CurrencyTag name="txt_netinc" size="10" maxlength="10"
									value='<%=f5%>' /></td>
                              <td><lapschoice:CurrencyTag name="txt_amount"  size="10"
									maxlength="10" value='<%=g5%>' 
									onBlur="callincome()" /></td>
                              <td><lapschoice:CurrencyTag name="txt_totincome"  size="10" maxlength="10"
									value='<%=h5%>' /></td>
                            </tr>
                            <tr> 
                                        <%

                    if(arryRow.size()!=0){
	                    arryCol = (ArrayList)arryRow.get(5);
	                   
						if(arryCol.size()!=0)
						{

						 l6=Helper.correctNull((String)arryCol.get(3)); 
						a6=Helper.correctNull((String)arryCol.get(4));
					    b6=Helper.correctNull((String)arryCol.get(5));
					    c6=Helper.correctNull((String)arryCol.get(6));
					    d6=Helper.correctNull((String)arryCol.get(7));
					   e6=Helper.correctNull((String)arryCol.get(8));


					   f6=Helper.correctNull((String)arryCol.get(9));
					   g6=Helper.correctNull((String)arryCol.get(10));
					    h6=Helper.correctNull((String)arryCol.get(11));
					  
					}
					}
                   
                  
                    else if(arryRow.size()==0){
                    	//l1="0";
                    	a6="";
                        b6="";
                    	c6="";
                    	d6="";
                        e6="";
                    	f6="";
						g6="";
						h6="";
						
                    	
                    }
                    
                    %>
                              <td><input type="text" name="txt_year" size="30"	maxlength="20"
									value='<%=l6%>' 	onKeyPress=""	></td>
                              <td> <table width="40%" border="0" cellspacing="0" cellpadding="1">
                                  <tr> 
                                    <td><lapschoice:CurrencyTag name="txt_area" size="10"
											maxlength="5" value='<%=a6%>' 		
											/></td>
                                    <td>&nbsp;</td>
                                  </tr>
                                </table></td>
                              <td><lapschoice:CurrencyTag name="txt_arabica" size="10" maxlength="5"
									value='<%=b6%>'		

									onBlur=""/> 
                              </td>
                              <td><lapschoice:CurrencyTag name="txt_robusta" size="10" maxlength="5"
									value='<%=c6%>' 	/></td>
                              <td> <table width="40%" border="0" cellspacing="0" cellpadding="1">
                                  <tr> 
                                    <td><lapschoice:CurrencyTag name="txt_yield"  size="10"
											maxlength="10" value='<%=d6%>'
											 onBlur="callSurplus()"
											/></td>
                                    <td>&nbsp;</td>
                                  </tr>
                                </table></td>
                              <td><lapschoice:CurrencyTag name="txt_cult" size="10"
									maxlength="10" value='<%=e6%>' 
									onBlur="callSurplus()" /></td>
                              <td><lapschoice:CurrencyTag name="txt_netinc" size="10" maxlength="10"
									value='<%=f6%>' /></td>
                              <td><lapschoice:CurrencyTag name="txt_amount"  size="10"
									maxlength="10" value='<%=g6%>' 
									onBlur="callincome()" /></td>
                              <td><lapschoice:CurrencyTag name="txt_totincome"  size="10" maxlength="10"
									value='<%=h6%>' /></td>
                            </tr>
                            <tr> 
                                        <%

                    if(arryRow.size()!=0){
	                    arryCol = (ArrayList)arryRow.get(6);
	                   
						if(arryCol.size()!=0)
						{

						 l7=Helper.correctNull((String)arryCol.get(3)); 
						a7=Helper.correctNull((String)arryCol.get(4));
					    b7=Helper.correctNull((String)arryCol.get(5));
					    c7=Helper.correctNull((String)arryCol.get(6));
					    d7=Helper.correctNull((String)arryCol.get(7));
					   e7=Helper.correctNull((String)arryCol.get(8));
					   f7=Helper.correctNull((String)arryCol.get(9));
					   g7=Helper.correctNull((String)arryCol.get(10));
					    h7=Helper.correctNull((String)arryCol.get(11));
					  
					}
					}
                   
                  
                    else if(arryRow.size()==0){
                    	//l1="0";
                    	a7="";
                        b7="";
                    	c7="";
                    	d7="";
                        e7="";
                    	f7="";
						g7="";
						h7="";
						
                    	
                    }
                    
                    %>
                       
			 <td><input type="text" name="txt_year" size="30"	maxlength="20"
									value='<%=l7%>' 	onKeyPress=""	></td>
                              <td> <table width="40%" border="0" cellspacing="0" cellpadding="1">
                                  <tr> 
                                    <td><lapschoice:CurrencyTag name="txt_area" size="10"
											maxlength="5" value='<%=a7%>' 		
											/></td>
                                    <td>&nbsp;</td>
                                  </tr>
                                </table></td>
                              <td><lapschoice:CurrencyTag name="txt_arabica" size="10" maxlength="5"
									value='<%=b7%>' 	/> 
                              </td>
                              <td><lapschoice:CurrencyTag name="txt_robusta" size="10" maxlength="5"
									value='<%=c7%>' 	/></td>
                              <td> <table width="40%" border="0" cellspacing="0" cellpadding="1">
                                  <tr> 
                                    <td><lapschoice:CurrencyTag name="txt_yield"  size="10"
											maxlength="15" value='<%=d7%>'
											 onBlur="callSurplus()"
											/></td>
                                    <td>&nbsp;</td>
                                  </tr>
                                </table></td>
                              <td><lapschoice:CurrencyTag name="txt_cult" size="10"
									maxlength="10" value='<%=e7%>' 
									onBlur="callSurplus()" /></td>
                              <td><lapschoice:CurrencyTag name="txt_netinc" size="10" maxlength="10"
									value='<%=f7%>' /></td>
                              <td><lapschoice:CurrencyTag name="txt_amount"  size="10"
									maxlength="10" value='<%=g7%>' 
									onBlur="callincome()" /></td>
                              <td><lapschoice:CurrencyTag name="txt_totincome"  size="10" maxlength="10"
									value='<%=h7%>' /></td>
                            </tr>
                            <tr> 
                                          <%

                    if(arryRow.size()!=0){
	                    arryCol = (ArrayList)arryRow.get(7);
	                   
						if(arryCol.size()!=0)
						{

						 l8=Helper.correctNull((String)arryCol.get(3)); 
						a8=Helper.correctNull((String)arryCol.get(4));
					    b8=Helper.correctNull((String)arryCol.get(5));
					    c8=Helper.correctNull((String)arryCol.get(6));
					    d8=Helper.correctNull((String)arryCol.get(7));
					   e8=Helper.correctNull((String)arryCol.get(8));
					   f8=Helper.correctNull((String)arryCol.get(9));
					   g8=Helper.correctNull((String)arryCol.get(10));
					    h8=Helper.correctNull((String)arryCol.get(11));
					  
					}
					}
                   
                  
                    else if(arryRow.size()==0){
                    	//l1="0";
                    	a8="";
                        b8="";
                    	c8="";
                    	d8="";
                        e8="";
                    	f8="";
						g8="";
						h8="";
						
                    	
                    }
                    
                    %>
                                    <td><input type="text" name="txt_year" size="30"	maxlength="20"
									value='<%=l8%>'	onKeyPress=""	></td>
                              <td> <table width="40%" border="0" cellspacing="0" cellpadding="1">
                                  <tr> 
                                    <td><lapschoice:CurrencyTag name="txt_area" size="10"
											maxlength="5" value='<%=a8%>'		
											/></td>
                                    <td>&nbsp;</td>
                                  </tr>
                                </table></td>
                              <td><lapschoice:CurrencyTag name="txt_arabica" size="10" maxlength="5"
									value='<%=b8%>' 	/> 
                              </td>
                              <td><lapschoice:CurrencyTag name="txt_robusta" size="10" maxlength="5"
									value='<%=c8%>' 	/></td>
                              <td> <table width="40%" border="0" cellspacing="0" cellpadding="1">
                                  <tr> 
                                    <td><lapschoice:CurrencyTag name="txt_yield"  size="10"
											maxlength="10" value='<%=d8%>'
											 onBlur="callSurplus()"
											/></td>
                                    <td>&nbsp;</td>
                                  </tr>
                                </table></td>
                              <td><lapschoice:CurrencyTag name="txt_cult" size="10"
									maxlength="10" value='<%=e8%>' 
									onBlur="callSurplus()" /></td>
                              <td><lapschoice:CurrencyTag name="txt_netinc" size="10" maxlength="10"
									value='<%=f8%>' /></td>
                              <td><lapschoice:CurrencyTag name="txt_amount"  size="10"
									maxlength="10" value='<%=g8%>' 
									onBlur="callincome()" /></td>
                              <td><lapschoice:CurrencyTag name="txt_totincome"  size="10" maxlength="10"
									value='<%=h8%>' /></td>
                            </tr>
                            <tr> 
                                          <%

                    if(arryRow.size()!=0){
	                    arryCol = (ArrayList)arryRow.get(8);
	                   
						if(arryCol.size()!=0)
						{

						 l9=Helper.correctNull((String)arryCol.get(3)); 
						a9=Helper.correctNull((String)arryCol.get(4));
					    b9=Helper.correctNull((String)arryCol.get(5));
					    c9=Helper.correctNull((String)arryCol.get(6));
					    d9=Helper.correctNull((String)arryCol.get(7));
					   e9=Helper.correctNull((String)arryCol.get(8));
					   f9=Helper.correctNull((String)arryCol.get(9));
					   g9=Helper.correctNull((String)arryCol.get(10));
					    h9=Helper.correctNull((String)arryCol.get(11));
					  
					}
					}
                   
                  
                    else if(arryRow.size()==0){
                    	//l1="0";
                    	a9="";
                        b9="";
                    	c9="";
                    	d9="";
                        e9="";
                    	f9="";
						g9="";
						h9="";
						
                    	
                    }
                    
                    %>
                       
			  <td><input type="text" name="txt_year" size="30"	maxlength="20"
									value='<%=l9%>' 	onKeyPress=""	></td>
                              <td> <table width="40%" border="0" cellspacing="0" cellpadding="1">
                                  <tr> 
                                    <td><lapschoice:CurrencyTag name="txt_area" size="10"
											maxlength="5" value='<%=a9%>' 		
											/></td>
                                    <td>&nbsp;</td>
                                  </tr>
                                </table></td>
                              <td><lapschoice:CurrencyTag name="txt_arabica" size="10" maxlength="5"
									value='<%=b9%>' 	/> 
                              </td>
                              <td><lapschoice:CurrencyTag name="txt_robusta" size="10" maxlength="5"
									value='<%=c9%>' 	/></td>
                              <td> <table width="40%" border="0" cellspacing="0" cellpadding="1">
                                  <tr> 
                                    <td><lapschoice:CurrencyTag name="txt_yield"  size="10"
											maxlength="10" value='<%=d9%>'
											 onBlur="callSurplus()"
											/></td>
                                    <td>&nbsp;</td>
                                  </tr>
                                </table></td>
                              <td><lapschoice:CurrencyTag name="txt_cult" size="10"
									maxlength="10" value='<%=e9%>' 
									onBlur="callSurplus()" /></td>
                              <td><lapschoice:CurrencyTag name="txt_netinc" size="10" maxlength="10"
									value='<%=f9%>' /></td>
                              <td><lapschoice:CurrencyTag name="txt_amount"  size="10"
									maxlength="10" value='<%=g9%>' 
									onBlur="callincome()" /></td>
                              <td><lapschoice:CurrencyTag name="txt_totincome"  size="10" maxlength="10"
									value='<%=h9%>' /></td>
                            </tr>
                            <tr> 
							  <%

                    if(arryRow.size()!=0){
	                    arryCol = (ArrayList)arryRow.get(9);
	                   
						if(arryCol.size()!=0)
						{

						 l10=Helper.correctNull((String)arryCol.get(3)); 
						a10=Helper.correctNull((String)arryCol.get(4));
					    b10=Helper.correctNull((String)arryCol.get(5));
					    c10=Helper.correctNull((String)arryCol.get(6));
					    d10=Helper.correctNull((String)arryCol.get(7));
					   e10=Helper.correctNull((String)arryCol.get(8));
					   f10=Helper.correctNull((String)arryCol.get(9));
					   g10=Helper.correctNull((String)arryCol.get(10));
					    h10=Helper.correctNull((String)arryCol.get(11));
					  
					}
					}
                   
                  
                    else if(arryRow.size()==0){
                    	//l1="0";
                    	a10="";
                        b10="";
                    	c10="";
                    	d10="";
                        e10="";
                    	f10="";
						g10="";
						h10="";
						
                    	
                    }
                    
                    %>
                       
                              <td><input type="text" name="txt_year" size="30"	maxlength="20"
									value='<%=l10%> ' 	onKeyPress=""	></td>
                              <td> <table width="40%" border="0" cellspacing="0" cellpadding="1">
                                  <tr> 
                                    <td><lapschoice:CurrencyTag name="txt_area" size="10"
											maxlength="5" value='<%=a10%>' 		
											/></td>
                                    <td>&nbsp;</td>
                                  </tr>
                                </table></td>
                              <td><lapschoice:CurrencyTag name="txt_arabica" size="10" maxlength="5"
									value='<%=b10%>'	/> 
                              </td>
                              <td><lapschoice:CurrencyTag name="txt_robusta" size="10" maxlength="5"
									value='<%=c10%>' 	/></td>
                              <td> <table width="40%" border="0" cellspacing="0" cellpadding="1">
                                  <tr> 
                                    <td><lapschoice:CurrencyTag name="txt_yield" size="10"
											maxlength="10" value='<%=d10%>'
											 onBlur="callSurplus()"
											/></td>
                                    <td>&nbsp;</td>
                                  </tr>
                                </table></td>
                              <td><lapschoice:CurrencyTag name="txt_cult" size="10"
									maxlength="10" value='<%=e10%>' 
									onBlur="callSurplus()" /></td>
                              <td><lapschoice:CurrencyTag name="txt_netinc" size="10" maxlength="10"
									value='<%=f10%>' /></td>
                              <td><lapschoice:CurrencyTag name="txt_amount"  size="10"
									maxlength="10" value='<%=g10%>' 
									onBlur="callincome()" /></td>
                              <td><lapschoice:CurrencyTag name="txt_totincome"  size="10" maxlength="10"
									value='<%=h10%>' /></td>
                            </tr>
                            <tr> 
                                          <%

                    if(arryRow.size()!=0){
	                    arryCol = (ArrayList)arryRow.get(10);
	                   
						if(arryCol.size()!=0)
						{

						 l11=Helper.correctNull((String)arryCol.get(3)); 
						a11=Helper.correctNull((String)arryCol.get(4));
					    b11=Helper.correctNull((String)arryCol.get(5));
					    c11=Helper.correctNull((String)arryCol.get(6));
					    d1=Helper.correctNull((String)arryCol.get(7));
					   e11=Helper.correctNull((String)arryCol.get(8));
					   f11=Helper.correctNull((String)arryCol.get(9));
					   g11=Helper.correctNull((String)arryCol.get(10));
					    h11=Helper.correctNull((String)arryCol.get(11));
					  
					}
					}
                   
                  
                    else if(arryRow.size()==0){
                    	//l1="0";
                    	a11="";
                        b11="";
                    	c11="";
                    	d11="";
                        e11="";
                    	f11="";
						g11="";
						h11="";
						
                    	
                    }
                    
                    %>
                       
                              <td><input type="text" name="txt_year" size="30"	maxlength="20"
									value='<%=l11%> ' 	onKeyPress=""	></td>
                              <td> <table width="40%" border="0" cellspacing="0" cellpadding="1">
                                  <tr> 
                                    <td><lapschoice:CurrencyTag name="txt_area" size="10"
											maxlength="5" value='<%=a11%>' 		
											/></td>
                                    <td>&nbsp;</td>
                                  </tr>
                                </table></td>
                              <td> <lapschoice:CurrencyTag name="txt_arabica" size="10" maxlength="5"
									value='<%=b11%>' 	/> 
                              </td>
                              <td><lapschoice:CurrencyTag name="txt_robusta" size="10" maxlength="5"
									value='<%=c11%>' 	/></td>
                              <td> <table width="40%" border="0" cellspacing="0" cellpadding="1">
                                  <tr> 
                                    <td><lapschoice:CurrencyTag name="txt_yield" size="10"
											maxlength="10" value='<%=d1%>'
											 onBlur="callSurplus()"
											/></td>
                                    <td>&nbsp;</td>
                                  </tr>
                                </table></td>
                              <td><lapschoice:CurrencyTag name="txt_cult" size="10"
									maxlength="10" value='<%=e11%>' 
									onBlur="callSurplus()" /></td>
                              <td><lapschoice:CurrencyTag name="txt_netinc" size="10" maxlength="10"
									value='<%=f11%>' /></td>
                              <td><lapschoice:CurrencyTag name="txt_amount"  size="10"
									maxlength="10" value='<%=g11%>' 
									onBlur="callincome()" /></td>
                              <td><lapschoice:CurrencyTag name="txt_totincome"  size="10" maxlength="10"
									value='<%=h11%>' /></td>
                            </tr>
                            <tr> 
                                            <%

                    if(arryRow.size()!=0){
	                    arryCol = (ArrayList)arryRow.get(11);
	                   
						if(arryCol.size()!=0)
						{

						 l12=Helper.correctNull((String)arryCol.get(3)); 
						a12=Helper.correctNull((String)arryCol.get(4));
					    b12=Helper.correctNull((String)arryCol.get(5));
					    c12=Helper.correctNull((String)arryCol.get(6));
					    d12=Helper.correctNull((String)arryCol.get(7));
					   e12=Helper.correctNull((String)arryCol.get(8));
					   f12=Helper.correctNull((String)arryCol.get(9));
					   g12=Helper.correctNull((String)arryCol.get(10));
					    h12=Helper.correctNull((String)arryCol.get(11));
					  
					}
					}
                   
                  
                    else if(arryRow.size()==0){
                    	//l1="0";
                    	a12="";
                        b12="";
                    	c12="";
                    	d12="";
                        e12="";
                    	f12="";
						g12="";
						h12="";
						
                    	
                    }
                    
                    %>
                       
                              <td height="29">
<input type="text" name="txt_year" size="30"	maxlength="20"
									value='<%=l12%>' 	onKeyPress=""	></td>
                              <td height="29"> 
                                <table width="40%" border="0" cellspacing="0" cellpadding="1">
                                  <tr> 
                                    <td><lapschoice:CurrencyTag name="txt_area" size="10"
											maxlength="5" value='<%=a12%>' 		
											/></td>
                                    <td>&nbsp;</td>
                                  </tr>
                                </table></td>
                              <td height="29"> <lapschoice:CurrencyTag name="txt_arabica" size="10" maxlength="5"
									value='<%=b12%>' 	/> </td>
                              <td height="29"><lapschoice:CurrencyTag name="txt_robusta" size="10" maxlength="5"
									value='<%=c12%>' 	/></td>
                              <td height="29"> 
                                <table width="40%" border="0" cellspacing="0" cellpadding="1">
                                  <tr> 
                                    <td><lapschoice:CurrencyTag name="txt_yield"  size="10"
											maxlength="10" value='<%=d12%>'
											 onBlur="callSurplus()"
											/></td>
                                    <td>&nbsp;</td>
                                  </tr>
                                </table></td>
                              <td height="29"><lapschoice:CurrencyTag name="txt_cult" size="10"
									maxlength="10" value='<%=e12%>' 
									onBlur="callSurplus()" /></td>
                              <td height="29"><lapschoice:CurrencyTag name="txt_netinc" size="10" maxlength="10"
									value='<%=f12%>' /></td>
                              <td height="29"><lapschoice:CurrencyTag name="txt_amount"  size="10"
									maxlength="10" value='<%=g12%>' 
									onBlur="callincome()" /></td>
                              <td height="29"><lapschoice:CurrencyTag name="txt_totincome"  size="10" maxlength="10"
									value='<%=h12%>' /></td>
                            </tr>
                          </table><br>
                          <table width="100%" border="0" cellspacing="0" cellpadding="3">
                            <tr>
							 <%

                    if(arryRow.size()!=0){
	                    arryCol = (ArrayList)arryRow.get(0);
	                   
						if(arryCol.size()!=0)
						{

						 i1=Helper.correctNull((String)arryCol.get(12)); 
						
					  
					}
					}
                   
                  
                    else if(arryRow.size()==0){
                    i1="";
						
                    	
                    }
                    
                    %>
                              <td width="34%">* Other Sources</td>
                              <td width="66%"><textarea
											name="txr_sources" cols="60" style="text-align:left"
											wrap="VIRTUAL" rows="4" onKeyPress="textlimit(txr_sources,600);notAllowSingleAndDoubleQuote()"  onKeyUp="textlimit(this,600)"><%=i1%></textarea></td>
                            </tr>
                          </table> </td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td><br>
				<table width="12%" border="0" cellpadding="0" cellspacing="0"
					align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"
					class="outertable border1">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="2">
							<tr valign="top">
								
                        <td><input type="button" name="cmdedit" value="Edit"
									style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
									class="buttoncolor" onClick="doEdit()"></td>
								<td><input type="button" name="cmdapply" value="Save"
									style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
									class="buttoncolor" onClick="doSave()"></td>
								<td><input type="button" name="cmdcancel" value="Cancel"
									style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
									class="buttoncolor" onClick="doCancel()"></td>
								<td width="0"><input type="button" name="cmddel" value="Delete"
									style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
									class="buttoncolor" onClick="doDelete()"></td>
								<td width="0"><input type="button" name="cmdhelp2" value="Help"
									style="background-color:#009966;cursor:help;;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
									onClick="callhelp()"></td>
								<!--<td width="0"><input type="button" name="cmdclose" value="Close"
									style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
									onClick="doClose()"></td>-->
							</tr>
						</table>
						</td>
					</tr>
				</table>
				<br>
                  </td>
			</tr>
			<tr>
				<td></td>
			</tr>
		</table>
		</td>
	</tr>

</table></td>
</tr>
<table></table>
	<tr>
		<%String strappno = request.getParameter("appno");%>

		<td><input type="hidden" name="hidAction">
		<input type="hidden" name="hidAction1"> <input type="hidden"
			name="hidBeanId" value=""> <input type="hidden"
			name="hidBeanMethod" value=""> <input type="hidden"
			name="hidBeanGetMethod" value=""> <input type="hidden"
			name="hidSourceUrl" value=""> <input type="hidden" name="hidApp_type"
			value="A"> <input type="hidden" name="hidflag" value=""> <input
			type="hidden" name="hideditflag"> <input type="hidden" name="selsno"
			value=""> <input type="hidden" name="hidval">  <input
			type="hidden" name="page">  
		 <input
			type="hidden" name="radLoan" value="Y">  <input
			type="hidden" name="app_status" value="<%=app_status%>"><input type="hidden"
			name="hid_sno"
			value="<%=Helper.correctNull((String)hshValues.get("strid"))%>">
			<input type="hidden" name="measurement" value="<%=Helper.correctNull((String)hshValues.get("land_measurement"))%>">
			<input type="hidden" name="txt_year1" value="<%=Helper.correctNull((String)hshValues.get("coffee_year1"))%>">
            <input type="hidden" name="txt_year2" value="<%=Helper.correctNull((String)hshValues.get("coffee_year2"))%>">

			</td>
	</tr>
</table>
  </form>
</body>
</html>





