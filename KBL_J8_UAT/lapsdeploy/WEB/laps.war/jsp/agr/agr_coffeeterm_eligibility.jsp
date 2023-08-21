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
ArrayList arryCol1 = new ArrayList();
ArrayList arryRow1= new ArrayList();
arryRow1 = (ArrayList) hshValues.get("arryRow1");

if (arryRow1 == null) {
	arryRow1 = new ArrayList();
}
String l1="",l2="",l3="",l4="",l5="",l6="",l7="",l8="",l9="",l10="",l11="",l12="";
String d1="",d2="",d3="",d4="",d5="",d6="",d7="",d8="",d9="",d10="",d11="",d12="";
String f1="",f2="",f3="",f4="",f5="",f6="",f7="",f8="",f9="",f10="",f11="",f12="",loanamount="";
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
	document.forms[0].cmdclose.disabled = bool6;
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
 	disableFields(true);
   document.forms[0].txt_totalloanamounte.readOnly=false;
	document.forms[0].hideditflag.value ="Y";
	document.forms[0].hidAction.value ="insert";
	enableButtons(true, false, false, true, true);	
}

 
function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidSourceUrl.value="/action/agr_coffeeterm_eligibility.jsp";
		document.forms[0].hidBeanId.value="agrcoffee";
		document.forms[0].hidBeanGetMethod.value="getcoffeetermeligibility";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit(); 		
	}
	disableCommandButtons("load");
}

function doDelete()
{
	document.forms[0].hidAction.value ="delete";
	document.forms[0].action=appUrl+"action/ControllerServlet";		
	document.forms[0].hidBeanMethod.value="updatecoffeetermeligibility";
	document.forms[0].hidBeanGetMethod.value="getcoffeetermeligibility";
	document.forms[0].hidBeanId.value="agrcoffee";
	document.forms[0].hidSourceUrl.value="action/agr_coffeeterm_eligibility.jsp";	
	document.forms[0].method="post";			
	document.forms[0].submit();		
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

var sur1 =  document.forms[0].txt_cost[m].value;
var sur2=document.forms[0].txt_loanamount[m].value;
     if(sur1=="")
		{
			sur1=0.00;
			
		}
		if(sur2=="")
		{
			sur2=0.00;
			
		}
		
		
	   
   
  document.forms[0].txt_margin[m].value= eval(sur1)-eval(sur2);
  if(document.forms[0].txt_margin[m].value=="NaN")
	{
	document.forms[0].txt_margin[m].value= "0" ;
	}
}

 
}

function doSave()
{	
   callSurplus();
   var loanamount=document.forms[0].txt_totalloanamount.value;
   if(document.forms[0].txt_totalloanamounte.value=="")
   {
   document.forms[0].txt_totalloanamounte.value=eval(loanamount);
   }
  	enableButtons( true, true, true, true, false);	
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hidBeanId.value="agrcoffee";
	document.forms[0].hidSourceUrl.value="/action/agr_coffeeterm_eligibility.jsp";
	document.forms[0].hidBeanMethod.value="updatecoffeetermeligibility";
	document.forms[0].hidBeanGetMethod.value="getcoffeetermeligibility";
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
<body onLoad="onloading();callSurplus()">
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
                            <tr bgcolor="#71694F" BORDER="0"> 
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
                              <td bgcolor="#71694F" width="30%"><b><font color="#FFFFFF">Items/development</font></b></td>
                              <td align="" bgcolor="#71694F" width="21%"><b><font
											color="#FFFFFF">Cost(Rs.)</font></b></td>
                              <td align="" bgcolor="#71694F" width="18%"><b><font color="#FFFFFF" Margin(Rs.)</font></b></td>
                              <td align="" bgcolor="#71694F" width="31%"><b><font
											color="#FFFFFF">Loan 
                                Amount (Rs.)</font></b></td>
                            </tr>
                            <tr> 
                              <td bgcolor="#71694F" width="30%"><b><font color="#FFFFFF">(1)</font></b></td>
                              <td align="" bgcolor="#71694F" width="21%"><b><font color="#FFFFFF">(2)</font></b></td>
                              <td align="" bgcolor="#71694F" width="18%"><b><font color="#FFFFFF">(3)=(2-4)</font></b></td>
                              <td align="" bgcolor="#71694F" width="31%"><b><font color="#FFFFFF">(4)</font></b></td>
                            </tr>
                            <tr> 
                               <%

                    if(arryRow.size()!=0){
	                    arryCol = (ArrayList)arryRow.get(1);
	                   
						if(arryCol.size()!=0)
						{

						l1=Helper.correctNull((String)arryCol.get(4)); 
						d1=Helper.correctNull((String)arryCol.get(19));
					    f1=Helper.correctNull((String)arryCol.get(20));
					   
					}
					}
                   
                  
                    else if(arryRow.size()==0){
                    
                        l1="";
                        d1="";
                    	f1="";
                                        	
                    }
                    
                    %>
                              <td width="30%" > 
                                <input type="text" name="txt_item" size="30"	maxlength="20" value="<%=l1%>" 	onKeyPress=""	></td>
                              <td width="21%"> 
                                <table width="40%" border="0" cellspacing="0" cellpadding="1">
                                  <tr> 
                                    <td  > <input type="text" name="txt_cost" readOnly="readonly"  size="10"
											maxlength="15" value="<%=d1%>" onKeyPress="allowNumber(this)"
											onBlur="callSurplus()"  style="text-align:right;"> 
                                    </td>
                                    <td>&nbsp;</td>
                                  </tr>
                                </table></td>
                              <td width="18%" > 
                                <input type="text" name="txt_margin"   readOnly="readonly" size="10"
									maxlength="15" value="" onKeyPress="allowNumber(this)"
									onBlur="callSurplus()" style="text-align:right;"></td>
                              <td width="31%" > 
                                <input type="text" name="txt_loanamount" onFocus=""  size="10" maxlength="15"
									value="<%=f1%>" onKeyPress="allowNumber(this)"
									onBlur="" style="text-align:right;"></td>
                            </tr>
                            <tr> 
                             <%

                    if(arryRow.size()!=0){
	                    arryCol = (ArrayList)arryRow.get(2);
	                   
						if(arryCol.size()!=0)
						{

						l2=Helper.correctNull((String)arryCol.get(4)); 
						d2=Helper.correctNull((String)arryCol.get(19));
					    f2=Helper.correctNull((String)arryCol.get(20));
					   
					}
					}
                   
                  
                    else if(arryRow.size()==0){
                    
                        l2="";
                        d2="";
                    	f2="";
                                        	
                    }
                    
                    %>
                              <td width="30%"> 
                                <input type="text" name="txt_item" size="30"	maxlength="20"
									value="<%=l2%> " 	onKeyPress=""	></td>
                              <td width="21%"> 
                                <table width="40%" border="0" cellspacing="0" cellpadding="1">
                                  <tr> 
                                    <td><input type="text" name="txt_cost" readOnly="readonly"  size="10"
											maxlength="15" value="<%=d2%>"
											onKeyPress="allowNumber(this)" onBlur="callSurplus()"
											style="text-align:right;"></td>
                                    <td>&nbsp;</td>
                                  </tr>
                                </table></td>
                              <td width="18%"> 
                                <input type="text" name="txt_margin"  readOnly="readonly" size="10"
									maxlength="15" value="" onKeyPress="allowNumber(this)"
									onBlur="callSurplus()" style="text-align:right;"></td>
                              <td width="31%">
<input type="text" name="txt_loanamount" onFocus=""  size="10" maxlength="15"
									value="<%=f2%>" onKeyPress="allowNumber(this)"
									onBlur="" style="text-align:right;"></td>
                            </tr>
                            <tr> 
                              <%

                    if(arryRow.size()!=0){
	                    arryCol = (ArrayList)arryRow.get(3);
	                   
						if(arryCol.size()!=0)
						{

						l3=Helper.correctNull((String)arryCol.get(4)); 
						d3=Helper.correctNull((String)arryCol.get(19));
					    f3=Helper.correctNull((String)arryCol.get(20));
					   
					}
					}
                   
                  
                    else if(arryRow.size()==0){
                    
                        l3="";
                        d3="";
                    	f3="";
                                        	
                    }
                    
                    %>
                              <td width="30%"> 
                                <input type="text" name="txt_item" size="30"	maxlength="20"
									value="<%=l3%>" 	onKeyPress=""	> </td>
                              <td width="21%"> 
                                <table width="40%" border="0" cellspacing="0" cellpadding="1">
                                  <tr> 
                                    <td > <input type="text" name="txt_cost" readOnly="readonly"  size="10"
											maxlength="15" value="<%=d3%>"
											onKeyPress="allowNumber(this)" onBlur="callSurplus()"
											style="text-align:right;"> </td>
                                    <td>&nbsp;</td>
                                  </tr>
                                </table></td>
                              <td width="18%"> 
                                <input type="text" name="txt_margin"  readOnly="readonly" size="10"
									maxlength="15" value="" onKeyPress="allowNumber(this)"
									onBlur="callSurplus()" style="text-align:right;"></td>
                              <td width="31%">
<input type="text" name="txt_loanamount" onFocus=""  size="10" maxlength="15"
									value="<%=f3%>" onKeyPress="allowNumber(this)"
									onBlur="" style="text-align:right;"></td>
                            </tr>
                            <tr> 
                              <%

                    if(arryRow.size()!=0){
	                    arryCol = (ArrayList)arryRow.get(4);
	                   
						if(arryCol.size()!=0)
						{

						l4=Helper.correctNull((String)arryCol.get(4)); 
						d4=Helper.correctNull((String)arryCol.get(19));
					    f4=Helper.correctNull((String)arryCol.get(20));
					   
					}
					}
                   
                  
                    else if(arryRow.size()==0){
                    
                        l4="";
                        d4="";
                    	f4="";
                                        	
                    }
                    
                    %>         
                              <td width="30%"> 
                                <input type="text" name="txt_item" size="30"	maxlength="20"
									value="<%=l4%> " 	onKeyPress=""	></td>
                              <td width="21%"> 
                                <table width="40%" border="0" cellspacing="0" cellpadding="1">
                                  <tr> 
                                    <td  > <input type="text" name="txt_cost" readOnly="readonly"  size="10"
											maxlength="15" value="<%=d4%>"
											onKeyPress="allowNumber(this)" onBlur="callSurplus()"
											style="text-align:right;"> </td>
                                    <td>&nbsp;</td>
                                  </tr>
                                </table></td>
                              <td width="18%"> 
                                <input type="text" name="txt_margin"  readOnly="readonly" size="10"
									maxlength="15" value="" onKeyPress="allowNumber(this)"
									onBlur="callSurplus()" style="text-align:right;"></td>
                              <td width="31%">
<input type="text" name="txt_loanamount" onFocus=""  size="10" maxlength="15"
									value="<%=f4%>" onKeyPress="allowNumber(this)"
									onBlur="" style="text-align:right;"></td>
                            </tr>
                            <tr> 
                              <%

                    if(arryRow.size()!=0){
	                    arryCol = (ArrayList)arryRow.get(5);
	                   
						if(arryCol.size()!=0)
						{

						l5=Helper.correctNull((String)arryCol.get(4)); 
						d5=Helper.correctNull((String)arryCol.get(19));
					    f5=Helper.correctNull((String)arryCol.get(20));
					   
					}
					}
                   
                  
                    else if(arryRow.size()==0){
                    
                        l5="";
                        d5="";
                    	f5="";
                                        	
                    }
                    
                    %>
					          <td width="30%"> 
                                <input type="text" name="txt_item" size="30"	maxlength="20"
									value="<%=l5%> " 	onKeyPress=""	></td>
                              <td width="21%"> 
                                <table width="40%" border="0" cellspacing="0" cellpadding="1">
                                  <tr> 
                                    <td><input type="text" name="txt_cost" readOnly="readonly"  size="10"
											maxlength="15" value="<%=d5%>" onKeyPress="allowNumber(this)"
											onBlur="callSurplus()" style="text-align:right;"></td>
                                    <td>&nbsp;</td>
                                  </tr>
                                </table></td>
                              <td width="18%"> 
                                <input type="text" name="txt_margin"  readOnly="readonly" size="10"
									maxlength="15" value="" onKeyPress="allowNumber(this)"
									onBlur="callSurplus()" style="text-align:right;"></td>
                              <td width="31%">
<input type="text" name="txt_loanamount" onFocus=""  size="10" maxlength="15"
									value="<%=f5%>" onKeyPress="allowNumber(this)"
									onBlur="" style="text-align:right;"></td>
                            </tr>
                            <tr> 
                            <%

                    if(arryRow.size()!=0){
	                    arryCol = (ArrayList)arryRow.get(6);
	                   
						if(arryCol.size()!=0)
						{

						l6=Helper.correctNull((String)arryCol.get(4)); 
						d6=Helper.correctNull((String)arryCol.get(19));
					    f6=Helper.correctNull((String)arryCol.get(20));
					   
					}
					}
                   
                  
                    else if(arryRow.size()==0){
                    
                        l6="";
                        d6="";
                    	f6="";
                                        	
                    }
                    
                    %>
                              <td width="30%"> 
                                <input type="text" name="txt_item" size="30"	maxlength="20"
									value="<%=l6%>" 	onKeyPress=""	></td>
                              <td width="21%"> 
                                <table width="40%" border="0" cellspacing="0" cellpadding="1">
                                  <tr> 
                                    <td><input type="text" name="txt_cost" readOnly="readonly"  size="10"
											maxlength="15" value="<%=d6%>"
											onKeyPress="allowNumber(this)" onBlur="callSurplus()"
											style="text-align:right;"></td>
                                    <td>&nbsp;</td>
                                  </tr>
                                </table></td>
                              <td width="18%"> 
                                <input type="text" name="txt_margin"  readOnly="readonly" size="10"
									maxlength="15" value="" onKeyPress="allowNumber(this)"
									onBlur="callSurplus()" style="text-align:right;"></td>
                              <td width="31%">
<input type="text" name="txt_loanamount" onFocus=""  size="10" maxlength="15"
									value="<%=f6%>" onKeyPress="allowNumber(this)"
									onBlur="" style="text-align:right;"></td>
                            </tr>
                            <tr> 
                             <%

                    if(arryRow.size()!=0){
	                    arryCol = (ArrayList)arryRow.get(7);
	                   
						if(arryCol.size()!=0)
						{

						l7=Helper.correctNull((String)arryCol.get(4)); 
						d7=Helper.correctNull((String)arryCol.get(19));
					    f7=Helper.correctNull((String)arryCol.get(20));
					   
					}
					}
                   
                  
                    else if(arryRow.size()==0){
                    
                        l7="";
                        d7="";
                    	f7="";
                                        	
                    }
                    
                    %>
					          <td width="30%"> 
                                <input type="text" name="txt_item" size="30"	maxlength="20"
									value="<%=l7%> " 	onKeyPress=""	></td>
                              <td width="21%"> 
                                <table width="40%" border="0" cellspacing="0" cellpadding="1">
                                  <tr> 
                                    <td><input type="text" name="txt_cost" readOnly="readonly"  size="10"
											maxlength="15" value="<%=d7%>"
											onKeyPress="allowNumber(this)" onBlur="callSurplus()"
											style="text-align:right;"></td>
                                    <td>&nbsp;</td>
                                  </tr>
                                </table></td>
                              <td width="18%"> 
                                <input type="text" name="txt_margin"  readOnly="readonly" size="10"
									maxlength="15" value="" onKeyPress="allowNumber(this)"
									onBlur="callSurplus()" style="text-align:right;"></td>
                              <td width="31%">
<input type="text" name="txt_loanamount" onFocus=""  size="10" maxlength="15"
									value="<%=f7%>" onKeyPress="allowNumber(this)"
									onBlur="" style="text-align:right;"></td>
                            </tr>
                            <tr> 
                             <%

                    if(arryRow.size()!=0){
	                    arryCol = (ArrayList)arryRow.get(8);
	                   
						if(arryCol.size()!=0)
						{

						l8=Helper.correctNull((String)arryCol.get(4)); 
						d8=Helper.correctNull((String)arryCol.get(19));
					    f8=Helper.correctNull((String)arryCol.get(20));
					   
					}
					}
                   
                  
                    else if(arryRow.size()==0){
                    
                        l8="";
                        d8="";
                    	f8="";
                                        	
                    }
                    
                    %>
					          <td width="30%"> 
                                <input type="text" name="txt_item" size="30"	maxlength="20"
									value="<%=l8%> "	onKeyPress=""	></td>
                              <td width="21%"> 
                                <table width="40%" border="0" cellspacing="0" cellpadding="1">
                                  <tr> 
                                    <td><input type="text" name="txt_cost" readOnly="readonly"  size="10"
											maxlength="15" value="<%=d8%>"
											onKeyPress="allowNumber(this)" onBlur="callSurplus()"
											style="text-align:right;"></td>
                                    <td>&nbsp;</td>
                                  </tr>
                                </table></td>
                              <td width="18%"> 
                                <input type="text" name="txt_margin"  readOnly="readonly" size="10"
									maxlength="15" value="" onKeyPress="allowNumber(this)"
									onBlur="callSurplus()" style="text-align:right;"></td>
                              <td width="31%">
<input type="text" name="txt_loanamount" onFocus=""  size="10" maxlength="15"
									value="<%=f8%>" onKeyPress="allowNumber(this)"
									onBlur="" style="text-align:right;"></td>
                            </tr>
                            <tr> 
                            <%

                    if(arryRow.size()!=0){
	                    arryCol = (ArrayList)arryRow.get(9);
	                   
						if(arryCol.size()!=0)
						{

						l9=Helper.correctNull((String)arryCol.get(4)); 
						d9=Helper.correctNull((String)arryCol.get(19));
					    f9=Helper.correctNull((String)arryCol.get(20));
					   
					}
					}
                   
                  
                    else if(arryRow.size()==0){
                    
                        l9="";
                        d9="";
                    	f9="";
                                        	
                    }
                    
                    %>
					
                              <td width="30%"> 
                                <input type="text" name="txt_item" size="30"	maxlength="20"
									value="<%=l9%> " 	onKeyPress=""	></td>
                              <td width="21%"> 
                                <table width="40%" border="0" cellspacing="0" cellpadding="1">
                                  <tr> 
                                    <td><input type="text" name="txt_cost" readOnly="readonly"  size="10"
											maxlength="15" value="<%=d9%>"
											onKeyPress="allowNumber(this)" onBlur="callSurplus()"
											style="text-align:right;"></td>
                                    <td>&nbsp;</td>
                                  </tr>
                                </table></td>
                              <td width="18%"> 
                                <input type="text" name="txt_margin"  readOnly="readonly" size="10"
									maxlength="15" value="" onKeyPress="allowNumber(this)"
									onBlur="callSurplus()" style="text-align:right;"></td>
                              <td width="31%">
<input type="text" name="txt_loanamount" onFocus=""  size="10" maxlength="15"
									value="<%=f9%>" onKeyPress="allowNumber(this)"
									onBlur="" style="text-align:right;"></td>
                            </tr>
                            <tr> 
                             <%

                    if(arryRow.size()!=0){
	                    arryCol = (ArrayList)arryRow.get(10);
	                   
						if(arryCol.size()!=0)
						{

						l10=Helper.correctNull((String)arryCol.get(4)); 
						d10=Helper.correctNull((String)arryCol.get(19));
					    f10=Helper.correctNull((String)arryCol.get(20));
					   
					}
					}
                   
                  
                    else if(arryRow.size()==0){
                    
                        l10="";
                        d10="";
                    	f10="";
                                        	
                    }
                    
                    %>
					
                              <td width="30%"> 
                                <input type="text" name="txt_item" size="30"	maxlength="20"
									value="<%=l10%> " 	onKeyPress=""	></td>
                              <td width="21%"> 
                                <table width="40%" border="0" cellspacing="0" cellpadding="1">
                                  <tr> 
                                    <td><input type="text" name="txt_cost" readOnly="readonly"  size="10"
											maxlength="15" value="<%=d10%>"
											onKeyPress="allowNumber(this)" onBlur="callSurplus()"
											style="text-align:right;"></td>
                                    <td>&nbsp;</td>
                                  </tr>
                                </table></td>
                              <td width="18%"> 
                                <input type="text" name="txt_margin"  readOnly="readonly" size="10"
									maxlength="15" value="" onKeyPress="allowNumber(this)"
									onBlur="callSurplus()" style="text-align:right;"></td>
                              <td width="31%">
<input type="text" name="txt_loanamount" onFocus=""  size="10" maxlength="15"
									value="<%=f10%>" onKeyPress="allowNumber(this)"
									onBlur="" style="text-align:right;"></td>
                            </tr>
                            <tr> 
                            <%

                    if(arryRow.size()!=0){
	                    arryCol = (ArrayList)arryRow.get(11);
	                   
						if(arryCol.size()!=0)
						{

						l11=Helper.correctNull((String)arryCol.get(4)); 
						d11=Helper.correctNull((String)arryCol.get(19));
					    f11=Helper.correctNull((String)arryCol.get(20));
					   
					}
					}
                   
                  
                    else if(arryRow.size()==0){
                    
                        l11="";
                        d11="";
                    	f11="";
                                        	
                    }
                    
                    %>
                              <td width="30%"> 
                                <input type="text" name="txt_item" size="30"	maxlength="20"
									value="<%=l11%> " 	onKeyPress=""	></td>
                              <td width="21%"> 
                                <table width="40%" border="0" cellspacing="0" cellpadding="1">
                                  <tr> 
                                    <td><input type="text" name="txt_cost" readOnly="readonly"  size="10"
											maxlength="15" value="<%=d11%>"
											onKeyPress="allowNumber(this)" onBlur="callSurplus()"
											style="text-align:right;"></td>
                                    <td>&nbsp;</td>
                                  </tr>
                                </table></td>
                              <td width="18%"> 
                                <input type="text" name="txt_margin"  readOnly="readonly" size="10"
									maxlength="15" value="" onKeyPress="allowNumber(this)"
									onBlur="callSurplus()" style="text-align:right;"></td>
                              <td width="31%">
<input type="text" name="txt_loanamount" onFocus=""  size="10" maxlength="15"
									value="<%=f11%>" onKeyPress="allowNumber(this)"
									onBlur="" style="text-align:right;"></td>
                            </tr>
                            <tr> 
                              <%

                    if(arryRow.size()!=0){
	                    arryCol = (ArrayList)arryRow.get(12);
	                   
						if(arryCol.size()!=0)
						{

						l12=Helper.correctNull((String)arryCol.get(4)); 
						d12=Helper.correctNull((String)arryCol.get(19));
					    f12=Helper.correctNull((String)arryCol.get(20));
					   
					}
					}
                   
                  
                    else if(arryRow.size()==0){
                    
                        l12="";
                        d12="";
                    	f12="";
                                        	
                    }
                    
                    %>
                              <td width="30%"> 
                                <input type="text" name="txt_item" size="30"	maxlength="20"
									value="<%=l12%>" 	onKeyPress=""	></td>
                              <td width="21%"> 
                                <table width="40%" border="0" cellspacing="0" cellpadding="1">
                                  <tr> 
                                    <td><input type="text" name="txt_cost" readonly="readonly"  size="10"
											maxlength="15" value="<%=d12%>"
											onKeyPress="allowNumber(this)" onBlur="callSurplus()"
											style="text-align:right;"></td>
                                    <td>&nbsp;</td>
                                  </tr>
                                </table></td>
                              <td width="18%"> 
                                <input type="text" name="txt_margin"  readOnly="readonly" size="10"
									maxlength="15" value="" onKeyPress="allowNumber(this)"
									onBlur="callSurplus()" style="text-align:right;"></td>
                              <td width="31%">
<input type="text" name="txt_loanamount" onFocus=""  size="10" maxlength="15"
									value="<%=f12%>" onKeyPress="allowNumber(this)"
									onBlur="" style="text-align:right;"></td>
                            </tr>
                            <tr bgcolor="#71694F">
                              <td height="35" width="30%"><b><font color="#FFFFFF">Total</font></b></td>
                              <td width="21%"> 
                                <input type="text" name="txt_totalcost" readOnly="readonly"  size="10"
											maxlength="15" value="<%=Helper.correctNull((String)hshValues.get("totalcost"))%>"
											onKeyPress="allowNumber(this)" onBlur=""
											style="text-align:right;"></td>
                              <td width="18%"> 
                                <input type="text" name="txt_totalmargin" readOnly="readonly"  size="10"
											maxlength="15" value="<%=Helper.correctNull((String)hshValues.get("totalmarginamount"))%>"
											onKeyPress="allowNumber(this)" onBlur=""
											style="text-align:right;"></td>
                              <td nowrap="nowrap" width="31%"> 
                                <%

                    if(arryRow1.size()!=0){
	                    arryCol1 = (ArrayList)arryRow1.get(0);
	                   
						if(arryCol1.size()!=0)
						{

						loanamount=Helper.correctNull((String)arryCol1.get(0)); 
					
					}
					}
                   
                  
                    else if(arryRow1.size()==0){
                    
                        loanamount="";
                        
                                        	
                    }
                    
                    %>
                                <input type="text" name="txt_totalloanamount" readOnly="readonly"  size="10"
											maxlength="15" value="<%=Helper.correctNull((String)hshValues.get("totalloanamount"))%>"
											onKeyPress="allowNumber(this)" onBlur=""
											style="text-align:right;">
                                <b><font color="#FFFFFF">or 
                                say loan Amount
                                <input type="text" name="txt_totalloanamounte" readOnly="readonly"  size="10"
											maxlength="9" value="<%=loanamount%>"
											onKeyPress="allowNumber(this)" onBlur=""
											style="text-align:right;">
                                (Editable) </font></b></td>
                            </tr>
                          </table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td><br>
				<table width="12%" border="0" cellpadding="0" cellspacing="0"
					align="center"
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
								<td width="0"><input type="button" name="cmdclose" value="Close"
									style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
									onClick="doClose()"></td>
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
			value=""> <input type="hidden" name="hidval"> <input
			type="hidden" name="page">
		<input
			type="hidden" name="radLoan" value="Y">   <input
			type="hidden" name="app_status" value="<%=app_status%>">  <input type="hidden"
			name="hid_sno"
			value="<%=Helper.correctNull((String)hshValues.get("strid"))%>">
			<input type="hidden" name="measurement" value="<%=Helper.correctNull((String)hshValues.get("land_measurement"))%>">
			</td>
	</tr>
</table>
  </form>
</body>
</html>





