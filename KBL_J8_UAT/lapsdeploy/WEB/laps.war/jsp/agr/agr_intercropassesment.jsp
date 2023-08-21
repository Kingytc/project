<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%
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
 	ArrayList arryCol = new ArrayList();
	ArrayList arryRow = new ArrayList();
	
	arryRow = (ArrayList) hshValues.get("arryRow");
	if (arryRow == null) {
		arryRow = new ArrayList();
	}
	ArrayList arryCol1 = new ArrayList();
	ArrayList arryRow1 = new ArrayList();
						
	arryRow1 = (ArrayList) hshValues.get("arryRow1");
			
	if (arryRow1 == null) {
		arryRow1 = new ArrayList();
	}		
	String l1 = "", l2 = "", l3 = "", l4 = "", l5 = "";
	String f1 = "", f2 = "", f3 = "", f4 = "", f5 = "";
	String s1 = "", s2 = "", s3 = "",s4 = "", s5 = "";
	String e1 = "", e2 = "", e3 = "", e4 = "",e5 = "";
	String g1 = "", g2 = "", g3 = "", g4 = "", g5 = "";
%>
<html>
<head>
<title>LAPS -Assesment Form Details</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/per/agrassesment.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var id ="";
var apptype="";
var acre = "";
var totalvalue=0.00;
var centgunt = "";
var len2=0;
var centgunt_1 = "";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var  strid="<%=Helper.correctNull((String)hshValues.get("strid"))%>";
var  strAction="<%=Helper.correctNull((String)hshValues.get("strAction"))%>";
function callhelp()
{
}

function showfinance()
{
        
   if(document.forms[0].cmdedit.disabled)
	{ 
	var action=document.forms[0].hidAction.value;
	var prop = "scrollbars=no,width=500,height=400,top=100,left=250";
	var url=appUrl+"action/scalefinancemasterlist.jsp?&strfrom=DistrictMasterintercrop1";
	window.open(url,"",prop);
	
	}else{
		alert('kindly click the edit button');
	}
}
function showfinance1()
{
        
   if(document.forms[0].cmdedit.disabled)
	{ 
	var action=document.forms[0].hidAction.value;
	var prop = "scrollbars=no,width=500,height=400,top=100,left=250";
	var url=appUrl+"action/scalefinancemasterlist.jsp?&strfrom=DistrictMasterintercrop2";
	window.open(url,"",prop);
	
	}else{
		alert('kindly click the edit button');
	}
}
function showfinance2()
{
        
   if(document.forms[0].cmdedit.disabled)
	{ 
	var action=document.forms[0].hidAction.value;
	var prop = "scrollbars=no,width=500,height=400,top=100,left=250";
	var url=appUrl+"action/scalefinancemasterlist.jsp?&strfrom=DistrictMasterintercrop3";
	window.open(url,"",prop);
	
	}else{
		alert('kindly click the edit button');
	}
}
function showfinance3()
{
        
   if(document.forms[0].cmdedit.disabled)
	{ 
	var action=document.forms[0].hidAction.value;
	var prop = "scrollbars=no,width=500,height=400,top=100,left=250";
	var url=appUrl+"action/scalefinancemasterlist.jsp?&strfrom=DistrictMasterintercrop4";
	window.open(url,"",prop);
	
	}else{
		alert('kindly click the edit button');
	}
}
function showfinance4()
{
        
   if(document.forms[0].cmdedit.disabled)
	{ 
	var action=document.forms[0].hidAction.value;
	var prop = "scrollbars=no,width=500,height=400,top=100,left=250";
	var url=appUrl+"action/scalefinancemasterlist.jsp?&strfrom=DistrictMasterintercrop5";
	window.open(url,"",prop);
	
	}else{
		alert('kindly click the edit button');
	}
}
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
    calculateTotal();
	leastamt();
  	enableButtons( true, true, false, true, true);	
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hidBeanId.value="agrcoffee";
	document.forms[0].hidSourceUrl.value="/action/agr_intercropassesment.jsp";
	document.forms[0].hidBeanMethod.value="updateinterassesment";
	document.forms[0].hidBeanGetMethod.value="getinterassesment";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}

function doEdit()
{
 	disableFields(false);
 	for(var i=0;i<=4;i++)
 	{
 	document.forms[0].txt_crop[i].readOnly =true;
 	document.forms[0].txt_eligibility[i].readOnly =true;
 	document.forms[0].txt_finance[i].readOnly =true;
 	document.forms[0].txt_amount1[i].readOnly =true;
	
	}
 	
	document.forms[0].txt_total_amount.readOnly =true;
	document.forms[0].hideditflag.value ="Y";
	document.forms[0].hidAction.value ="insert";
	
	enableButtons(true, false, false, false, true);	
}

function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agrcoffee";
		document.forms[0].hidBeanGetMethod.value="getinterassesment";
		document.forms[0].action=appUrl+"action/agr_intercropassesment.jsp";
		document.forms[0].submit(); 		
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
	document.forms[0].hidAction.value ="delete";
	document.forms[0].action=appUrl+"action/ControllerServlet";		
	document.forms[0].hidBeanMethod.value="updateinterassesment";
	document.forms[0].hidBeanGetMethod.value="getinterassesment";
	document.forms[0].hidBeanId.value="agrcoffee";
	document.forms[0].hidSourceUrl.value="action/agr_intercropassesment.jsp";	
	document.forms[0].method="post";			
	document.forms[0].submit();		
	}
}

function onloading()
{	  

	disableFields(true);
	enableButtons( false, true, true, true, false);
}

function leastamt()
{
	for(var j=0;j<=4;j++)
	{
  		var eligibility = document.forms[0].txt_eligibility[j].value;
  		var amount=document.forms[0].txt_amount[j].value;
  		if(eligibility=="")
		{
			eligibility=0.00;
		}
		if(amount=="")
		{
			amount=0.00;
		}
		if(eval(eligibility)!=eval(amount))
		{
			if((eval(eligibility)<eval(amount)))
		  	{
				document.forms[0].txt_amount1[j].value=eligibility;
			}
		}
		if(eval(eligibility)!=eval(amount))
		{
			if((eval(amount)<eval(eligibility)))
		  	{
				document.forms[0].txt_amount1[j].value=amount;
			}
		}
		if((eval(eligibility)==eval(amount)))
		{
			document.forms[0].txt_amount1[j].value=amount;
		}      
	}	
}

function callEligibility()
{
	leastamt();
	var bool=false;var bool1=false;
	var str3,str2,str1,str;
	var i;
	var measurementtype = document.forms[0].measurement.value;

	var guntarate ="";
	var acrerate = "";
	var totalrate = 0;
	
	for(var j=0;j<=4;j++)
   	{
    	var area = document.forms[0].txt_area[j].value;
 		var val2=document.forms[0].txt_finance[j].value;
    	var totalval1=0.00;
		var totalval2=0.00;
		var val2=document.forms[0].txt_finance[j].value;
    
		if(val2=="")
		{
			val2=0.00;
			
		}
		if(area=="")
		{
			area=0.00;
			
		}
		var len=area.length;
	    var len1=len-1;
	   	for(var k=0;k<=len;k++)
	  	{
	   		if((area.charAt(k)=="."))
	   		{
	     		i = area.indexOf(".");
	     		str1=area.substring(0,i);
	     		str = area.substring(i+1,len);
	   		}
		} 
	    
		if(measurementtype == 'g')
	   	{
	   		guntarate = val2 / 40;
	  		guntarate = str * guntarate;
	  		acrerate = 	str1* val2; 
	  		totalrate = acrerate + guntarate;
		}
	   	if(measurementtype == 'c')
	   	{
	  		totalrate = eval(area) * eval(val2);
		}
		
		document.forms[0].txt_eligibility[j].value= totalrate ;
		if(document.forms[0].txt_eligibility[j].value=="NaN")
		{
			document.forms[0].txt_eligibility[j].value= "0" ;
		}
	}
}
  


function calculateTotal()
{
    
  leastamt();
 callEligibility();
   
	var totalvalue1=0.00;

	for(var i=0;i<=4;i++)
	{
    	var value_amount1=document.forms[0].txt_amount1[i].value;
		
		if(value_amount1=="")
		{
			value_amount1=0.00;
		}
	
		totalvalue1 = eval(value_amount1)+eval(totalvalue1)
		
	}          
  	document.forms[0].txt_total_amount.value= totalvalue1;
	}


</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css">
</head>
<body onLoad="onloading();callEligibility();calculateTotal();leastamt()">
<form name="frmpri" method=post>
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
                        <td colspan="13"> 
<table width="100%" border="0" cellspacing="2" cellpadding="1"
									bgcolor="#DEDACF">
                            <tr bgcolor="#71694F" border="0"> 
                              <td bgcolor="#71694F"><b>Name 
                                of the crop</b></td>
                              <td align="center" bgcolor="#71694F"><b>Area 
                                <br>
                                in Acre/<%=measurementval%></b></td>
                              <td align="center" bgcolor="#71694F"><b>Scale 
                                of <br>
                                Finance</b></td>
                              <td align="center" bgcolor="#71694F"><b>Eligibile 
                                Limit As Per DCC Scale(A)</b></td>
                              <td align="center" bgcolor="#71694F"><b>Loan 
                                <br>
                                Amount Requested(B)</b></td>
                              <td align="center" bgcolor="#71694F"><b>Least 
                                Amount (Rs.)<br>
                                (of A and B)</b></td>
                            </tr>
                            <tr> 
                              <%
						if (arryRow1.size() >0) {
					arryCol1 = (ArrayList) arryRow1.get(0);
				l1 = Helper.correctNull((String) arryCol1.get(3));
				f1=Helper.correctNull((String)arryCol1.get(6));
				}
				if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(0);
				
				if (arryCol.size() != 0) {
					 
					l1 = Helper.correctNull((String) arryCol.get(3));
			    	f1 = Helper.correctNull((String) arryCol.get(4));
					s1 = Helper.correctNull((String) arryCol.get(5));
					g1 = Helper.correctNull((String) arryCol.get(7));
					
				}
			 
			} else if (arryRow.size() == 0) {
				s1="";
				g1="";

			}

			%>
                              <td width="24%" > <input type="text" name="txt_crop" size="30"
									maxlength="200" value="<%=l1%>" onKeyPress=""></td>
                              <td width="13%" > <input type="text" name="txt_area" size="10" maxlength="15"
									value="<%=f1%>" onKeyPress=""
									onBlur="calculateTotal();callEligibility()" style="text-align:right;"> 
                              </td>
                              <td width="16%"> <table width="40%" border="0" cellspacing="0" cellpadding="1">
                                  <tr> 
                                    <td> <input type="text" name="txt_finance" readonly  size="10"
											maxlength="15" value="<%=s1%>" onKeyPress="allowNumber(this)"
											onBlur=""  style="text-align:right;"> 
                                    </td>
                                    <td><span onClick="showfinance()" style="cursor:hand"><img
											src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
											border="0"></span></td>
                                  </tr>
                                </table></td>
                              <td width="16%" > <input type="text" name="txt_eligibility"   readonly size="10"
									maxlength="15" value="<%=e1%>" onKeyPress="allowNumber(this)"
									onBlur="" style="text-align:right;"></td>
                              <td width="14%"> <input type="text" name="txt_amount"  size="10"
									maxlength="15" value="<%=g1%>" onKeyPress="allowNumber(this)"
									onBlur="calculateTotal();leastamt()" style="text-align:right;"></td>
                              <td width="17%" > <input type="text" name="txt_amount1"  size="10"
									maxlength="15" value="" onKeyPress="allowNumber(this)"
									onBlur="calculateTotal()" style="text-align:right;"></td>
                            </tr>
                            <tr> 
                              <%
						if (arryRow1.size() >0) {
					arryCol1 = (ArrayList) arryRow1.get(1);
				l2 = Helper.correctNull((String) arryCol1.get(3));
				f2=Helper.correctNull((String)arryCol1.get(6));
				}
				if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(1);
				
				if (arryCol.size() != 0) {
					 
					l2 = Helper.correctNull((String) arryCol.get(3));
			    	f2 = Helper.correctNull((String) arryCol.get(4));
					s2 = Helper.correctNull((String) arryCol.get(5));
					g2 = Helper.correctNull((String) arryCol.get(7));
					
				}
			 
			} else if (arryRow.size() == 0) {
				s2="";
				g2="";

			}

			%>
                              <td><input type="text" name="txt_crop" size="30" maxlength="200"
									value="<%=l2%>" onKeyPress=""></td>
                              <td><input type="text" name="txt_area" size="10" maxlength="15"
									value="<%=f2%>" onKeyPress=""
									onBlur="calculateTotal();callEligibility()" style="text-align:right;"> 
                              </td>
                              <td> <table width="40%" border="0" cellspacing="0" cellpadding="1">
                                  <tr> 
                                    <td><input type="text" name="txt_finance" readonly  size="10"
											maxlength="15" value="<%=s2%>"
											onKeyPress="allowNumber(this)" onBlur=""
											style="text-align:right;"></td>
                                    <td><span onClick="showfinance1()" style="cursor:hand"><img
											src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
											border="0"></span></td>
                                  </tr>
                                </table></td>
                              <td><input type="text" name="txt_eligibility"  readonly size="10"
									maxlength="15" value="<%=e2%>" onKeyPress="allowNumber(this)"
									onBlur="" style="text-align:right;"></td>
                              <td><input type="text" name="txt_amount"  size="10"
									maxlength="15" value="<%=g2%>" onKeyPress="allowNumber(this)"
									onBlur="calculateTotal();leastamt()" style="text-align:right;"></td>
                              <td><input type="text" name="txt_amount1"  size="10"
									maxlength="15" value="" onKeyPress="allowNumber(this)"
									onBlur="calculateTotal()" style="text-align:right;"></td>
                            </tr>
                            <tr> 
                              <%
						if (arryRow1.size() >0) {
					arryCol1 = (ArrayList) arryRow1.get(2);
				l3 = Helper.correctNull((String) arryCol1.get(3));
				f3=Helper.correctNull((String)arryCol1.get(6));
				}
				if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(2);
				
				if (arryCol.size() != 0) {
					 
					l3 = Helper.correctNull((String) arryCol.get(3));
			    	f3 = Helper.correctNull((String) arryCol.get(4));
					s3 = Helper.correctNull((String) arryCol.get(5));
					g3 = Helper.correctNull((String) arryCol.get(7));
					
				}
			 
			} else if (arryRow.size() == 0) {
				s3="";
				g3="";

			}

			%>
                              <td><input type="text" name="txt_crop" size="30" maxlength="200"
									value="<%=l3%> " onKeyPress=""> </td>
                              <td> <input type="text" name="txt_area" size="10" maxlength="15"
									value="<%=f3%>" onKeyPress=""
									onBlur="callEligibility();calculateTotal()" style="text-align:right;"> 
                              </td>
                              <td> <table width="40%" border="0" cellspacing="0" cellpadding="1">
                                  <tr> 
                                    <td> <input type="text" name="txt_finance" readonly  size="10"
											maxlength="15" value="<%=s3%>"
											onKeyPress="allowNumber(this)" onBlur=""
											style="text-align:right;"></td>
                                    <td><span onClick="showfinance2()" style="cursor:hand"><img
											src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
											border="0"></span></td>
                                  </tr>
                                </table></td>
                              <td><input type="text" name="txt_eligibility"  readonly size="10"
									maxlength="15" value="<%=e3%>" onKeyPress="allowNumber(this)"
									onBlur="" style="text-align:right;"></td>
                              <td><input type="text" name="txt_amount"  size="10"
									maxlength="15" value="<%=g3%>" onKeyPress="allowNumber(this)"
									onBlur="calculateTotal();leastamt()" style="text-align:right;"></td>
                              <td><input type="text" name="txt_amount1"  size="10"
									maxlength="15" value="" onKeyPress="allowNumber(this)"
									onBlur="calculateTotal()" style="text-align:right;"></td>
                            </tr>
                            <tr> 
                              <%
						if (arryRow1.size() >0) {
					arryCol1 = (ArrayList) arryRow1.get(3);
				l4 = Helper.correctNull((String) arryCol1.get(3));
				f4=Helper.correctNull((String)arryCol1.get(6));
				}
				if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(3);
				
				if (arryCol.size() != 0) {
					 
					l4 = Helper.correctNull((String) arryCol.get(3));
			    	f4 = Helper.correctNull((String) arryCol.get(4));
					s4 = Helper.correctNull((String) arryCol.get(5));
					g4 = Helper.correctNull((String) arryCol.get(7));
					
				}
			 
			} else if (arryRow.size() == 0) {
				s4="";
				g4="";

			}

			%>
                              <td><input type="text" name="txt_crop" size="30" maxlength="200"
									value="<%=l4%>" onKeyPress=""></td>
                              <td><input type="text" name="txt_area" size="10" maxlength="15"
									value="<%=f4%>" onKeyPress=""
									onBlur="calculateTotal();callEligibility()" style="text-align:right;"> 
                              </td>
                              <td> <table width="40%" border="0" cellspacing="0" cellpadding="1">
                                  <tr> 
                                    <td><input type="text" name="txt_finance" readonly  size="10"
											maxlength="15" value="<%=s4%>"
											onKeyPress="allowNumber(this)" onBlur=""
											style="text-align:right;"></td>
                                    <td><span onClick="showfinance3()" style="cursor:hand"><img
											src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
											border="0"></span></td>
                                  </tr>
                                </table></td>
                              <td><input type="text" name="txt_eligibility"  readonly size="10"
									maxlength="15" value="<%=e4%>" onKeyPress="allowNumber(this)"
									onBlur="" style="text-align:right;"></td>
                              <td><input type="text" name="txt_amount"  size="10"
									maxlength="15" value="<%=g4%>" onKeyPress="allowNumber(this)"
									onBlur="calculateTotal();leastamt()" style="text-align:right;"></td>
                              <td><input type="text" name="txt_amount1"  size="10"
									maxlength="15" value="" onKeyPress="allowNumber(this)"
									onBlur="calculateTotal()" style="text-align:right;"></td>
                            </tr>
                            <tr> 
                              <%
						if (arryRow1.size() >0) {
					arryCol1 = (ArrayList) arryRow1.get(4);
				l5 = Helper.correctNull((String) arryCol1.get(3));
				f5=Helper.correctNull((String)arryCol1.get(6));
				}
				if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(4);
				
				if (arryCol.size() != 0) {
					 
					l5 = Helper.correctNull((String) arryCol.get(3));
			    	f5 = Helper.correctNull((String) arryCol.get(4));
					s5 = Helper.correctNull((String) arryCol.get(5));
					g5 = Helper.correctNull((String) arryCol.get(7));
					
				}
			 
			} else if (arryRow.size() == 0) {
				s5="";
				g5="";

			}

			%>
                              <td><input type="text" name="txt_crop" size="30" maxlength="200"
									value="<%=l5%>"onKeyPress=""></td>
                              <td><input type="text" name="txt_area" size="10" maxlength="15"
									value="<%=f5%>" onKeyPress=""
									onBlur="calculateTotal();callEligibility()" style="text-align:right;"> 
                              </td>
                              <td> <table width="40%" border="0" cellspacing="0" cellpadding="1">
                                  <tr> 
                                    <td><input type="text" name="txt_finance" readonly  size="10"
											maxlength="15" value="<%=s5%>"
											onKeyPress="allowNumber(this)" onBlur=""
											style="text-align:right;"></td>
                                    <td><span onClick="showfinance4()" style="cursor:hand"><img
											src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
											border="0"></span></td>
                                  </tr>
                                </table></td>
                              <td><input type="text" name="txt_eligibility"  readonly size="10"
									maxlength="15" value="<%=e5%>" onKeyPress="allowNumber(this)"
									onBlur="" style="text-align:right;"></td>
                              <td><input type="text" name="txt_amount"  size="10"
									maxlength="15" value="<%=g5%>" onKeyPress="allowNumber(this)"
									onBlur="calculateTotal();leastamt()" style="text-align:right;"></td>
                              <td><input type="text" name="txt_amount1"  size="10"
									maxlength="15" value="" onKeyPress="allowNumber(this)"
									onBlur="calculateTotal()" style="text-align:right;"></td>
                            </tr>
                            <tr bgcolor="#71694F"> 
                              <td ><b><font  color="#FFFFFF">Total(Rs.)</b></td>
                              <td colspan="4">&nbsp; </td>
                              <td><input type="text" name="txt_total_amount"  size="10"
									maxlength="15" value="" onKeyPress="allowNumber(this)"
									onBlur="" style="text-align:right;"></td>
                            </tr>
                          </table>
						  </td>
					</tr>
				</table>
				</td>
			</tr>
<lapschoice:combutton btntype="EO" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
			
		</table>
		</td>
	</tr>

</table></td>
</tr>
</table>
<lapschoice:agrihiddentag />
</form>
</body>
</html>