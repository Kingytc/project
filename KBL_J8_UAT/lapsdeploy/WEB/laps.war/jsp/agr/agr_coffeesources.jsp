
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
			ArrayList arryCol1 = new ArrayList();
ArrayList arryRow1 = new ArrayList();
			
			arryRow1 = (ArrayList) hshValues.get("arryRow1");
		
			if (arryRow1 == null) {
				arryRow1 = new ArrayList();
			}
	String  d1="",d2="",d3="",d4="",d5="";
	String  m1="",m2="",m3="",m4="",m5="";
	String  l1="",l2="",l3="",l4="",l5="";
	String  k1="",k2="",k3="",k4="",k5="",k6="";
	String  g1="",g2="",g3="",g4="",g5="",g6="";
	String  kk1="",kk2="",kk3="",kk4="",kk5="",kk6="";
	String  gg1="",gg2="",gg3="",gg4="",gg5="",gg6="";
	String r1="",r2="";
	String  rr1="",rr2="",rr4="";
	String  rrr1="",rrr2="";
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


function onloading()
{	  

	disableFields(true);
    callTotal();
	callTotalsource();		
}
function chkcentgunt() 
{
  if(document.forms[0].land_measurement.value == 'g')
		{
    for(var j=0;j<=1;j++)
     {
     var guntas1 = document.forms[0].txt_guntas1[j].value;
		
			if(eval(guntas1) > 39)
			{
			 alert("The Data you entered is not valid");
			document.forms[0].txt_guntas1[j].value="";
		    document.forms[0].txt_guntas1[j].focus();
	         return;
			}
		}
		 for(var k=0;k<=1;k++)
     {
     var guntas2 = document.forms[0].txt_guntas2[k].value;
		
			if(eval(guntas2) > 39)
			{
			 alert("The Data you entered  is not valid");
			document.forms[0].txt_guntas2[k].value="";
		    document.forms[0].txt_guntas2[k].focus();
	         return;
			}
		}
		
    }
}

function enableButtons(bool1, bool2, bool3, bool4, bool5, bool6)
{
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdapply.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddel.disabled=bool5;
	document.forms[0].cmdclose.disabled = bool6;
}
function doSave()
{   
    enableButtons(true, true, false, false, true, true);
	callTotal();
	callTotalsource();
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hidAction1.value ="insert1";
	document.forms[0].hidBeanId.value="agrcoffee";		
	document.forms[0].hidSourceUrl.value="/action/agr_coffeesources.jsp";
	document.forms[0].hidBeanMethod.value="updatecoffeesourcesdata";
	document.forms[0].hidBeanGetMethod.value="getcoffeesourcesdata";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}
function doEdit()
{
 	disableFields(false);
	document.forms[0].txt_totnetinc.readOnly=true;
	document.forms[0].txt_totgrossinc.readOnly=true;
	document.forms[0].txt_totnetincome.readOnly=true;
	document.forms[0].txt_totnetsurplus.readOnly=true;
	document.forms[0].txt_annincome.readOnly=true;
	document.forms[0].txt_totnetincomean.readOnly=true;
	document.forms[0].hideditflag.value ="Y";
	document.forms[0].hidAction.value ="insert";
	enableButtons(true, true, false, false, false, true);		
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agrcoffee";
		document.forms[0].hidBeanGetMethod.value="getcoffeesourcesdata";
		document.forms[0].action=appUrl +"action/agr_coffeesources.jsp";
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
	    document.forms[0].hidBeanId.value="agrcoffee";
	    document.forms[0].hidBeanMethod.value="updatecoffeesourcesdata";
		document.forms[0].hidBeanGetMethod.value="getcoffeesourcesdata";
		document.forms[0].hidAction.value ="delete";
	 	document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidSourceUrl.value="action/agr_coffeesources.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}	
}
function callTotal()
{
var totalvalue1=0.00;var totalvalue2=0.00;
for(var m=0;m<=3;m++)
     {
var value1 =document.forms[0].txt_netinc[m].value;
var value2=document.forms[0].txt_grossinc[m].value;
      if( value1 =="")
		{
			 value1 =0.00;
			
		}
		 if( value2 =="")
		{
			 value2 =0.00;
			
		}
	totalvalue1 = eval(value1)+eval(totalvalue1)
	totalvalue2= eval(value2)+eval(totalvalue2)	
     }
     
   document.forms[0].txt_totnetinc.value= eval(totalvalue1);
   document.forms[0].txt_totgrossinc.value= eval(totalvalue2);
   roundtxt(document.forms[0].txt_totnetinc);
    roundtxt(document.forms[0].txt_totgrossinc);
   }
   function callannual()
{

  var value1 =document.forms[0].coffee_prev.value;
     if( value1 =="")
		{
			 value1 =0.00;
			
		}
 var value2 =document.forms[0].coffee_inter.value;
      if( value2 =="")
		{
			 value2 =0.00;
			
		}
		var value3 =document.forms[0].txt_totnetinc.value;
      if( value3=="")
		{
			 value3 =0.00;
			
		}

document.forms[0].txt_annincome.value= eval(value1)+eval(value2)+eval(value3);	
 roundtxt(document.forms[0].txt_annincome);

}
   function callTotalsource()
{
callannual();
var totalvalue1=0.00;
var txt_annincome=document.forms[0].txt_annincome.value;
if(txt_annincome =="")
		{
	txt_annincome =0.00;
			
		}
for(var m=0;m<=2;m++)
     {
var value1 =document.forms[0].txt_netincome[m].value;
      if( value1 =="")
		{
			 value1 =0.00;
			
		}
		
	totalvalue1 = eval(value1)+eval(totalvalue1)
		
     }
     
   document.forms[0].txt_totnetincome.value= eval(totalvalue1);
   document.forms[0].txt_totnetincomean.value= eval(totalvalue1)+eval(txt_annincome);
   var total= document.forms[0].txt_totnetincomean.value;
    if(eval(total) =="")
		{
			total =0.00;
			
		}
  var valueexp=document.forms[0].txt_familyexp.value;
   if(valueexp =="")
		{
		valueexp =0.00;
			
		}
	document.forms[0].txt_totnetsurplus.value= eval(total)-eval(valueexp);	
}
 
</script>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css">
</head>
<body bgcolor="#EEEAE3" text="#000000" vlink="#330000" alink="#330000"
	leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="onloading();callannual()">
	<form name="frmpri" method="post">
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
    <tr bgcolor="#71694F"> 
      <td colspan="6"><font	color="#FFFFFF">Particulars 
        of Other Landed Properties Owned</font></td>
    </tr>
    <tr bgcolor="#71694F"> 
      <td align="center"><font	color="#FFFFFF">Village</font></td>
      <td colspan="2" align="center"><font color="#FFFFFF" size="2" face="MS Sans Serif">Taluk</font></td>
      <td align="center"><font color="#FFFFFF" size="2" face="MS Sans Serif">Survey 
        No. </font></td>
      <td colspan="2" align="center"><font color="#FFFFFF" size="2" face="MS Sans Serif">Extent</font></td>
    </tr>
    <tr bgcolor="#71694F"> 
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
      <td width="17%" align="center">&nbsp;</td>
      <td colspan="2" align="center">&nbsp;</td>
      <td align="center">&nbsp;</td>
      <td align="center"><font color="#FFFFFF" size="2" face="MS Sans Serif">Acres</font></td>
      <td align="center"><font face="MS Sans Serif" size="1"
											color="#FFFFFF"><%=measurementval%></font></td>
    </tr>
    <tr> 
      <%
						
				if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(0);
				
				if (arryCol.size() != 0) {
					 
					d1 = Helper.correctNull((String) arryCol.get(2));
					d2 = Helper.correctNull((String) arryCol.get(3));
					d3 = Helper.correctNull((String) arryCol.get(4));
					d4 = Helper.correctNull((String) arryCol.get(5));
					d5 = Helper.correctNull((String) arryCol.get(6));
					
				}
			
			} else if (arryRow.size() == 0) {
				d1 = "";
				d2 = "";
				d3 = "";
				d4 = "";
				d5= "";
			
			}

			%>
      <td align="center"><input type="text" name="txt_village"  value="<%=d1%>"  size="15%" onKeyPress="notAllowSplChar()" maxlength="20" onBlur=""></td>
      <td width="19%" colspan="2" align="center"> <input type="text" name="txt_taluk"  value="<%=d2%>"  size="15%" onKeyPress="notAllowSplChar()" maxlength="20" onBlur="chkcentgunt()"></td>
      <td width="20%" align="center"> <input type="text" name="txt_syno"  value="<%=d3%>"  size="15%" onKeyPress="" maxlength="20"></td>
      <td width="22%" align="center"> <input type="text" name="txt_acres1"  value="<%=d4%>"  size="15%" onKeyPress="allowInteger()" maxlength="4"></td>
      <td width="22%" align="center"><input type="text" name="txt_guntas1"  value="<%=d5%>"  size="15%" onKeyPress="allowInteger()" maxlength="2"></td>
    </tr>
    <tr> 
	 <%
						
				if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(1);
				
				if (arryCol.size() != 0) {
					 
					m1 = Helper.correctNull((String) arryCol.get(2));
					m2 = Helper.correctNull((String) arryCol.get(3));
					m3 = Helper.correctNull((String) arryCol.get(4));
					m4 = Helper.correctNull((String) arryCol.get(5));
					m5 = Helper.correctNull((String) arryCol.get(6));
					
				}
			
			} else if (arryRow.size() == 0) {
				m1 = "";
				m2 = "";
				m3 = "";
				m4 = "";
				m5= "";
				
				
			}

			%>
    
      <td height="30" align="center"><input type="text" name="txt_village"  value="<%=m1%>"  size="15%" onKeyPress="notAllowSplChar()" maxlength="20" onBlur="chkcentgunt()"></td>
      <td colspan="2" align="center"><input type="text" name="txt_taluk"  value="<%=m2%>"  size="15%" onKeyPress="notAllowSplChar()" maxlength="20" onBlur="chkcentgunt()"></td>
      <td align="center"><input type="text" name="txt_syno"  value="<%=m3%>"  size="15%" onKeyPress="" maxlength="20" onBlur=""></td>
      <td align="center"><input type="text" name="txt_acres1"  value="<%=m4%>"  size="15%" onKeyPress="allowInteger()" maxlength="2" onBlur="chkcentgunt()"></td>
      <td align="center"><input type="text" name="txt_guntas1"  value="<%=m5%>"  size="15%" onKeyPress="allowInteger()" maxlength="2" onBlur="chkcentgunt()"></td>
    </tr>
    <tr> 
	 <%
						
				if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(2);
				
				if (arryCol.size() != 0) {
					 
					l1 = Helper.correctNull((String) arryCol.get(2));
					l2 = Helper.correctNull((String) arryCol.get(3));
					l3 = Helper.correctNull((String) arryCol.get(4));
					l4 = Helper.correctNull((String) arryCol.get(5));
					l5 = Helper.correctNull((String) arryCol.get(6));
					
				}
			
			} else if (arryRow.size() == 0) {
				l1 = "";
				l2 = "";
				l3 = "";
				l4 = "";
				l5= "";
				
				
			}

			%>
    
      <td height="30" align="center"><input type="text" name="txt_village"  value="<%=l1%>"  size="15%" onKeyPress="notAllowSplChar()" maxlength="20" onBlur="chkcentgunt()"></td>
      <td colspan="2" align="center"><input type="text" name="txt_taluk"  value="<%=l2%>"  size="15%" onKeyPress="notAllowSplChar()" maxlength="20" onBlur="chkcentgunt()"></td>
      <td align="center"><input type="text" name="txt_syno"  value="<%=l3%>"  size="15%" onKeyPress="" maxlength="20"></td>
      <td align="center"><input type="text" name="txt_acres1"  value="<%=l4%>"  size="15%" onKeyPress="allowInteger()" maxlength="4" onBlur="chkcentgunt()"></td>
      <td align="center"><input type="text" name="txt_guntas1"  value="<%=l5%>"  size="15%" onKeyPress="allowInteger()" maxlength="2" onBlur="chkcentgunt()"></td>
    </tr>
    <tr> 
      <td height="30" rowspan="2" align="center" bgcolor="#71694F"><font	color="#FFFFFF">Type 
        of crops</font></td>
      <td colspan="2" align="center" bgcolor="#71694F"><font	color="#FFFFFF">Area</font></td>
      <td rowspan="2" align="center" bgcolor="#71694F"><font	color="#FFFFFF">Average 
        Yield </font></td>
      <td rowspan="2" align="center" bgcolor="#71694F"><font	color="#FFFFFF">Gross 
        Income(Rs.)</font></td>
      <td rowspan="2" align="center" bgcolor="#71694F"><font color="#FFFFFF" size="2" face="MS Sans Serif">Net 
        Income(Rs.) </font></td>
    </tr>
    <tr> 
      <td align="center" bgcolor="#71694F"><font color="#FFFFFF" size="2" face="MS Sans Serif">Acres</font></td>
      <td width="9%" align="center" bgcolor="#71694F"><font face="MS Sans Serif" size="1"
											color="#FFFFFF"><%=measurementval%></font></td>
    </tr>
    <tr> 
	 <%
						
				if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(3);
				
				if (arryCol.size() != 0) {
					 
					k1 = Helper.correctNull((String) arryCol.get(7));
					k2 = Helper.correctNull((String) arryCol.get(8));
					k3 = Helper.correctNull((String) arryCol.get(9));
					k4 = Helper.correctNull((String) arryCol.get(10));
					k5 = Helper.correctNull((String) arryCol.get(11));
					k6 = Helper.correctNull((String) arryCol.get(12));
				}
			
			} else if (arryRow.size() == 0) {
				k1 = "";
				k2 = "";
				k3 = "";
				k4 = "";
				k5= "";
				k6 = "";
				
			}

			%>
    
      <td align="center"><input type="text" name="txt_cropname"  value="<%=k1%>"  size="15%" onKeyPress="notAllowSplChar()" maxlength="20" onBlur=""></td>
      <td align="center"><input type="text" name="txt_acres2"  value="<%=k2%>"  size="15%" onKeyPress="allowInteger()" maxlength="4" onBlur="chkcentgunt()"></td>
      <td align="center"><input type="text" name="txt_guntas2"  value="<%=k3%>"  size="15%" onKeyPress="allowInteger()" maxlength="2" onBlur="chkcentgunt()"></td>
      <td align="center"><input type="text" name="txt_yield"  value="<%=k4%>"  size="15%" onKeyPress="allowNumber(this)" maxlength="6" onBlur=""></td>
      <td align="center"><lapschoice:CurrencyTag name="txt_grossinc"  value='<%=k5%>'  size="15%"  maxlength="10" onBlur="callTotal();callannual()"/></td>
      <td align="center"><lapschoice:CurrencyTag name="txt_netinc"  value='<%=k6%>'  size="15%"  maxlength="10" onBlur="callTotal();callannual()"/></td>
    </tr>
    <tr> 
	 <%
						
				if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(4);
				
				if (arryCol.size() != 0) {
					 
					kk1 = Helper.correctNull((String) arryCol.get(7));
					kk2 = Helper.correctNull((String) arryCol.get(8));
					kk3 = Helper.correctNull((String) arryCol.get(9));
					kk4 = Helper.correctNull((String) arryCol.get(10));
					kk5 = Helper.correctNull((String) arryCol.get(11));
					kk6 = Helper.correctNull((String) arryCol.get(12));
					
				}
			
			} else if (arryRow.size() == 0) {
				kk1 = "";
				kk2 = "";
				kk3 = "";
				kk4 = "";
				kk5= "";
				kk6 = "";
				
			}

			%>
    
      <td align="center"><input type="text" name="txt_cropname"  value="<%=kk1%>"  size="15%" onKeyPress="notAllowSplChar()" maxlength="20" onBlur=""></td>
      <td align="center"><input type="text" name="txt_acres2"  value="<%=kk2%>"  size="15%" onKeyPress="allowInteger()" maxlength="4" onBlur="chkcentgunt()"></td>
      <td align="center"><input type="text" name="txt_guntas2"  value="<%=kk3%>"  size="15%" onKeyPress="allowInteger()" maxlength="2" onBlur="chkcentgunt()"></td>
      <td align="center"><input type="text" name="txt_yield"  value="<%=kk4%>"  size="15%" onKeyPress="allowNumber(this)" maxlength="6" onBlur=""></td>
      <td align="center"><lapschoice:CurrencyTag name="txt_grossinc"  value='<%=kk5%>'  size="15%"  maxlength="10" onBlur="callTotal();callannual()"/></td>
      <td align="center"><lapschoice:CurrencyTag name="txt_netinc"  value='<%=kk6%>'  size="15%"  maxlength="10" onBlur="callTotal();callannual()"/></td>
    </tr>
    <tr> 
	 <%
						
				if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(5);
				
				if (arryCol.size() != 0) {
					 
					g1 = Helper.correctNull((String) arryCol.get(7));
					g2 = Helper.correctNull((String) arryCol.get(8));
					g3 = Helper.correctNull((String) arryCol.get(9));
					g4 = Helper.correctNull((String) arryCol.get(10));
					g5 = Helper.correctNull((String) arryCol.get(11));
					g6 = Helper.correctNull((String) arryCol.get(12));
					
				}
			
			} else if (arryRow.size() == 0) {
				g1 = "";
				g2 = "";
				g3 = "";
				g4 = "";
				g5= "";
				g6 = "";
				
			}

			%>
    
      <td align="center"><input type="text" name="txt_cropname"  value="<%=g1%>"  size="15%" onKeyPress="notAllowSplChar()" maxlength="20" onBlur=""></td>
      <td align="center"><input type="text" name="txt_acres2"  value="<%=g2%>"  size="15%" onKeyPress="allowInteger()" maxlength="4" onBlur="chkcentgunt()"></td>
      <td align="center"><input type="text" name="txt_guntas2"  value="<%=g3%>"  size="15%" onKeyPress="allowInteger()" maxlength="2" onBlur="chkcentgunt()"></td>
      <td align="center"><input type="text" name="txt_yield"  value="<%=g4%>"  size="15%" onKeyPress="allowNumber(this)" maxlength="6" onBlur="chkcentgunt()"></td>
      <td align="center"><lapschoice:CurrencyTag name="txt_grossinc"  value='<%=g5%>'  size="15%"  maxlength="10" onBlur="callTotal();callannual()"/></td>
      <td align="center"><lapschoice:CurrencyTag name="txt_netinc"  value='<%=g6%>'  size="15%"  maxlength="10" onBlur="callTotal();callannual()"/></td>
    </tr>
    <tr> 
	 <%
						
				if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(6);
				
				if (arryCol.size() != 0) {
					 
					gg1 = Helper.correctNull((String) arryCol.get(7));
					gg2 = Helper.correctNull((String) arryCol.get(8));
					gg3 = Helper.correctNull((String) arryCol.get(9));
					gg4 = Helper.correctNull((String) arryCol.get(10));
					gg5 = Helper.correctNull((String) arryCol.get(11));
					gg6 = Helper.correctNull((String) arryCol.get(12));
					
				}
			
			} else if (arryRow.size() == 0) {
				gg1 = "";
				gg2 = "";
				gg3 = "";
				gg4 = "";
				gg5= "";
				gg6 = "";
				
			}

			%>
    
      <td align="center"><input type="text" name="txt_cropname"  value="<%=gg1%>"  size="15%" onKeyPress="notAllowSplChar()" maxlength="20" onBlur=""></td>
      <td align="center"><input type="text" name="txt_acres2"  value="<%=gg2%>"  size="15%" onKeyPress="allowInteger()" maxlength="4" onBlur="chkcentgunt()"></td>
      <td align="center"><input type="text" name="txt_guntas2"  value="<%=gg3%>"  size="15%" onKeyPress="allowInteger()" maxlength="2" onBlur="chkcentgunt()"></td>
      <td align="center"><input type="text" name="txt_yield"  value="<%=gg4%>"  size="15%" onKeyPress="allowNumber(this)" maxlength="6"></td>
      <td align="center"><lapschoice:CurrencyTag name="txt_grossinc"  value='<%=gg5%>'  size="15%"  maxlength="10" onBlur="callTotal();callannual()"/></td>
      <td align="center"><lapschoice:CurrencyTag name="txt_netinc"  value='<%=gg6%>'  size="15%"  maxlength="10" onBlur="callTotal();callannual()"/></td>
    </tr>
    <tr> 
    
      <td colspan="4" align="" bgcolor="#71694F"><font	color="#FFFFFF">Total(in 
        Rs.)</font></td>
      <td width="22%" align="center" bgcolor="#71694F"><lapschoice:CurrencyTag name="txt_totgrossinc"  value=''  size="15%"  maxlength=""/> 
      </td>
      <td width="22%" align="center" bgcolor="#71694F"><lapschoice:CurrencyTag name="txt_totnetinc"  value=''  size="15%"  maxlength=""/></td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
    <tr bgcolor="#71694F"> 
      <td colspan="2"><font color="#FFFFFF" size="2" face="MS Sans Serif">Total 
        Annual Net Income(Rs.) 
        <lapschoice:CurrencyTag name="txt_annincome"  value=''  size="15%"  maxlength=""/>
        (A) </font></td>
    </tr>
    <tr bgcolor="#71694F"> 
      <td colspan="2"><font color="#FFFFFF" size="2" face="MS Sans Serif">Net 
        Income From Sources Other than Above(A)</font></td>
    </tr>
    <tr bgcolor="#71694F"> 
      <td><font	color="#FFFFFF">Sources</font></td>
      <td><font	color="#FFFFFF">Net Income(Rs.) 
        </font></td>
    </tr>
    <tr > 
      <%
						
				if (arryRow1.size() != 0) {
				arryCol1 = (ArrayList) arryRow1.get(0);
				
				if (arryCol1.size() != 0) {
					 
					r1 = Helper.correctNull((String) arryCol1.get(2));
					r2 = Helper.correctNull((String) arryCol1.get(3));
					
				}
			
			} else if (arryRow1.size() == 0) {
				r1 = "";
				r2 = "";
				
			}

			%>
      <td width="54%"><input type="text" name="txt_source"  value="<%=r1%>"  size="50%" onKeyPress="notAllowSplChar()" maxlength="35" onBlur=""></td>
      <td width="46%"><lapschoice:CurrencyTag name="txt_netincome"  value='<%=r2%>'  size="20%"  maxlength="10" onBlur="callTotalsource()"/></td>
    </tr>
    <tr > 
      <%
						
				if (arryRow1.size() != 0) {
				arryCol1 = (ArrayList) arryRow1.get(1);
				
				if (arryCol1.size() != 0) {
					 
					rr1 = Helper.correctNull((String) arryCol1.get(2));
					rr2 = Helper.correctNull((String) arryCol1.get(3));
					
				}
			
			} else if (arryRow1.size() == 0) {
				rr1 = "";
				rr2 = "";
				
			}

			%>
      <td><input type="text" name="txt_source"  value="<%=rr1%>"  size="50%" onKeyPress="notAllowSplChar()" maxlength="35" onBlur=""></td>
      <td><lapschoice:CurrencyTag name="txt_netincome"  value='<%=rr2%>'  size="20%"  maxlength="10" onBlur="callTotalsource()"/></td>
    </tr>
    <tr > 
      <%
						
				if (arryRow1.size() != 0) {
				arryCol1 = (ArrayList) arryRow1.get(2);
				
				if (arryCol1.size() != 0) {
					 
					rrr1 = Helper.correctNull((String) arryCol1.get(2));
					rrr2 = Helper.correctNull((String) arryCol1.get(3));
					
				}
			
			} else if (arryRow1.size() == 0) {
				rrr1 = "";
				rrr2 = "";
			
			}

			%>
      <td><input type="text" name="txt_source"  value="<%=rrr1%>"  size="50%" onKeyPress="notAllowSplChar()" maxlength="35" onBlur=""></td>
      <td><lapschoice:CurrencyTag name="txt_netincome"  value='<%=rrr2%>'  size="20%"  maxlength="10" onBlur="callTotalsource()"/></td>
    </tr>
    <tr bgcolor="#71694F">
      <td><font	color="#FFFFFF">Total(B)</font></td>
      <td><lapschoice:CurrencyTag name="txt_totnetincome"  value=''  size="20%"  maxlength="" onBlur=""/></td>
    </tr>
    <tr bgcolor="#71694F"> 
      <td><font	color="#FFFFFF">Total(A+B)(Rs.)</font></td>
      <td><lapschoice:CurrencyTag name="txt_totnetincomean"  value=''  size="20%"  maxlength="" onBlur=""/></td>
    </tr>
    <tr bgcolor="#71694F"> 
      <td><font	color="#FFFFFF">Family &amp; Household 
        Expenses per Annum(in Rs.)(C)</font></td>
      <%
						
				if (arryRow1.size() != 0) {
				arryCol1 = (ArrayList) arryRow1.get(3);
				
				if (arryCol1.size() != 0) {
					 
					rr4 = Helper.correctNull((String) arryCol1.get(4));
					
				}
			
			} else if (arryRow1.size() == 0) {
				rr4= "";
				
			}

			%>
      <td><lapschoice:CurrencyTag  name="txt_familyexp"  value='<%=rr4%>'  size="20%"  maxlength="10" onBlur="callTotalsource()"/></td>
    </tr>
    <tr bgcolor="#71694F"> 
      <td><font	color="#FFFFFF">Net Surplus(in Rs.)(A+B)-C</font></td>
      <td><lapschoice:CurrencyTag name="txt_totnetsurplus"  value=''  size="20%"  maxlength="" onBlur=""/></td>
    </tr>
  </table>

<br>
<br>
<lapschoice:combutton btntype='EO' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>

		
		<lapschoice:agrihiddentag />
		<input type ="hidden" name="coffee_prev" value ="<%=Helper.correctNull((String)hshValues.get("coffee_netinc"))%>">
		<input type ="hidden" name="coffee_inter" value ="<%=Helper.correctNull((String)hshValues.get("coffee_internetinc"))%>">

</form>

</body>
</html>



