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
	String  d1="",d2="",d3="",d4="",d5="";
	String m1="",m2="",m3="",m4="",m5="";
	String k1="",k2="",k3="",k4="",k5="";
	String l1="",l2="",l3="",l4="",l5="";
	String g1="",g2="",g3="",g4="",g5="";
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
<STYLE>
DIV.cellContainer {	
  width: 100%; height: 100;
  overflow: auto;
}
</STYLE>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";

</script>

<script>


function onloading()
{	  
	disableFields(true);
}
function chkcentgunt() 
{
  if(document.forms[0].land_measurement.value == 'g')
		{
    for(var j=0;j<=1;j++)
     {
     var guntas = document.forms[0].txt_guntas[j].value;
		
			if(eval(guntas) > 39)
			{
			 alert("The Data you entered is not valid");
			document.forms[0].txt_guntas[j].value="";
		    document.forms[0].txt_guntas[j].focus();
	         return;
			}
		}
	}	 
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
    enableButtons(true, true, true, true, false);
	callTotal();calculate();check();
	document.forms[0].hidBeanId.value="agrcoffee";		
	document.forms[0].hidSourceUrl.value="/action/agrcropinter.jsp";
	document.forms[0].hidBeanMethod.value="updatecoffeeinterdata";
	document.forms[0].hidBeanGetMethod.value="getcoffeeinterdata";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}
function doEdit()
{
 	disableFields(false);
	document.forms[0].hideditflag.value ="Y";
	document.forms[0].hidAction.value ="insert";
	enableButtons(true, true, false, false, false);		
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agrcoffee";
		document.forms[0].hidBeanGetMethod.value="getcoffeeinterdata";
		document.forms[0].action=appUrl +"action/agrcropinter.jsp";
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
	document.forms[0].txt_total_area.readOnly=true;
	document.forms[0].txt_totnetinc.readOnly=true;
}


function doDelete()
{
	if( ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
	 	document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updatecoffeeinterdata";
		document.forms[0].hidBeanGetMethod.value="getcoffeeinterdata";
		document.forms[0].hidBeanId.value="agrcoffee";
		document.forms[0].hidSourceUrl.value="action/agrcropinter.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}	
}
function callTotal()
{
var totalvalue1=0.00;
for(var m=0;m<=4;m++)
     {
var value1 =  document.forms[0].txt_netinc[m].value;
      if( value1 =="")
		{
			 value1 =0.00;
			
		}
	totalvalue1 = eval(value1)+eval(totalvalue1)	
     }
     
   document.forms[0].txt_totnetinc.value= eval(totalvalue1);
   roundtxt(document.forms[0].txt_totnetinc);
   
 
}
function check()
{
  calculate();
   var acreageval;var areaval;
   var acreval;
    for(var m=0;m<5;m++)
     {
	 areaval=document.forms[0].txt_area[m].value;
	acreval=document.forms[0].txt_guntas[m].value;
	
	var meas=document.forms[0].land_measurement.value;
	if(areaval=="")
	{
		areaval=0;
	}
	if(acreval=="")
	{
		acreval=0;
	}
	if(meas=="g")
	{
		if(acreval.length==1)
		{
		 	acreageval= areaval+".0"+acreval;
		}
		else
		{
		
			acreageval= areaval+"."+acreval;
		}
	}
	if(meas=="c")
	{
	 	if(acreval.length==1)
		{
	 		acreageval= areaval+".0"+acreval;
		}
		else
		{
	 		acreageval= areaval+"."+acreval;
		}
	}
	document.forms[0].txt_total_area1[m].value=acreageval;
		}
	
}

function calculate()
{

var totalvalue1=0.00;	var totalvalue2=0.00;
var measurementtype=document.forms[0].land_measurement.value;
var txt_totarea=document.forms[0].txt_total_area.value;	
 if(txt_totarea=="")
		{
		 txt_totarea =0.00;
			
		}
		
for(var m=0;m<5;m++)
     {
     var value1 =  document.forms[0].txt_guntas[m].value;
      if( value1 =="")
		{
			 value1 =0;
			
		}
		var value2= document.forms[0].txt_area[m].value;
		 if( value2 =="")
		{
			 value2 =0;
			
		}
	totalvalue1 = eval(value1)+eval(totalvalue1)
	totalvalue2 = eval(value2)+eval(totalvalue2)
   
     }
    
   		//-------------------------------------------
  document.forms[0].txt_total_area.value= eval(totalvalue1);
  document.forms[0].txt_total_area2.value= eval(totalvalue2);
   document.forms[0].txt_total_area.value=totalvalue2+"."+totalvalue1;
   if(measurementtype == 'c')
             {
   				 
   				var total_value1=document.forms[0].txt_total_area.value;
				
   				var len2 =total_value1.length;
   				var g=0;
  				for(var t=0;t<=len2;t++){
  				if((total_value1.charAt(t)=="."))
  				 {
     				g  =  total_value1.indexOf(".");
     				acre = total_value1.substring(0,g);
     				centgunt = total_value1.substring(g+1,len2);
     				centgunt = centgunt.substring(0,2);
     				document.forms[0].txt_total_area.value=acre+"."+centgunt;	
     				
   				}
  		}
  		
   }
   if(measurementtype == 'g')
   {
          		var centgunt2="";var len3="";
    			var total_value2=document.forms[0].txt_total_area.value;
				len3 =total_value2.length;
    			var g1=0;
   				var acre1=0;var cent_gunt="";
   				var count = 0;
   				var centgunt1=0;
   				
  				for(var t1=0;t1<=len3;t1++){
  			    
  				if((total_value2.charAt(t1)=="."))
  				 {
  				  
     				g1  =  total_value2.indexOf(".");
     				acre1 = total_value2.substring(0,g1);
     				if(len3>3)
     				{
     				centgunt1 = total_value2.substring(g1+1,5);
					
     				}
     				else{
     				centgunt1 = total_value2.substring(g1+1,len3);
     				
     				}
                  				
     			 }
     				while(centgunt1 >= 40)
     				{
     				   
     				 	centgunt1 = centgunt1 - 40;
     				 		count = count + 1;
     	 		     centgunt1 = "0"+centgunt1;
				 	if((centgunt1.length)>2){
     				centgunt1=centgunt1.substring(1,centgunt1.length);
     				}
     				}
     			    
   			  		 
     		      }
     		       acre1 = eval(acre1) + eval(count);
     		       if(eval(count)>0)
   			       {
   			        
   			     document.forms[0].txt_total_area.value=acre1+"."+centgunt1;
   			     }
     			 
     		  	 }
   				 
 
 
}
</script>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css">
</head>
<body onload="onloading();check();callTotal();calculate()">
	<form name="frmpri" method="post">
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
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
      <td><font	size="2" face="MS Sans Serif" color="#FFFFFF">Crop Name </font></td>
      <td colspan="2" align="center"><font color="#FFFFFF" size="2" face="MS Sans Serif">Area 
        </font></td>
      <td align="center"><font color="#FFFFFF" size="2" face="MS Sans Serif">Average 
        Yield(Kgs) </font></td>
      <td align="center"><font color="#FFFFFF" size="2" face="MS Sans Serif">Net 
        Income Realised(Rs.)</font></td>
    </tr>
    <tr bgcolor="#71694F"> 
      <td width="19%">&nbsp;</td>
      <td align="center"><font color="#FFFFFF" size="2" face="MS Sans Serif">(Acres)</font></td>
      <td align="center"><font face="MS Sans Serif" size="1"
											color="#FFFFFF">(<%=measurementval%>)</font></td>
      <td align="center">&nbsp;</td>
      <td align="center">&nbsp;</td>
    </tr>
    <tr> 
      <%
						
				if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(0);
				
				if (arryCol.size() != 0) {
					 
					d1 = Helper.correctNull((String) arryCol.get(3));
					d2 = Helper.correctNull((String) arryCol.get(4));
					d3 = Helper.correctNull((String) arryCol.get(5));
					d4 = Helper.correctNull((String) arryCol.get(6));
					d5 = Helper.correctNull((String) arryCol.get(7));
					
				}
			
			} else if (arryRow.size() == 0) {
				d1 = "";
				d2 = "";
				d3 = "";
				d4 = "";
				d5= "";
				
			}

			%>
      <td height="38" align="center"> <input type="text" name="txt_cropname"  value="<%=d1%>"  size="20%" onKeyPress="notAllowSplChar()" maxlength="25" onBlur=""></td>
      <td width="19%" align="center"> <input type="text" name="txt_area"  value="<%=d2%>"  size="15%" onKeyPress="allowInteger()" maxlength="4" onBlur="chkcentgunt();check();calculate()"></td>
      <td width="19%" align="center"> <input type="text" name="txt_guntas"  value="<%=d3%>"  size="15%" onKeyPress="allowInteger()" maxlength="2" onBlur="chkcentgunt();check();calculate()"> 
        <input type="hidden" name="txt_total_area1" value=""></td>
      <td width="20%" align="center"> <input type="text" name="txt_yield"  value="<%=d4%>"  size="15%" onKeyPress="allowNumber(this)" maxlength="4" onBlur=""></td>
      <td width="23%" align="center"> <lapschoice:CurrencyTag name="txt_netinc"  value='<%=d5%>'  size="15"  maxlength="10" onBlur="callTotal()"/></td>
    </tr>
    <tr> 
      <% 	if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(1);

				if (arryCol.size() != 0) {

					m1 = Helper.correctNull((String) arryCol.get(3));
					m2 = Helper.correctNull((String) arryCol.get(4));
					m3= Helper.correctNull((String) arryCol.get(5));
					m4 = Helper.correctNull((String) arryCol.get(6));
					m5 = Helper.correctNull((String) arryCol.get(7));
					
					
				}
				

			} else if (arryRow.size() == 0) {
				m1= "";
				m2 = "";
				m3= "";
				m4 = "";
				m5 = "";
				
				
			}

			%>
      <td height="47" align="center"> <input type="text" name="txt_cropname"  value="<%=m1%>"  size="20%" onKeyPress="notAllowSplChar()" maxlength="25" onBlur=""></td>
      <td align="center"><input type="text" name="txt_area"  value="<%=m2%>"  size="15%" onKeyPress="allowInteger()" maxlength="4" onBlur="chkcentgunt();check();calculate()"></td>
      <td align="center"><input type="text" name="txt_guntas"  value="<%=m3%>"  size="15%" onKeyPress="allowInteger()" maxlength="2" onBlur="chkcentgunt();check();calculate()"> 
        <input type="hidden" name="txt_total_area1" value=""></td>
      <td align="center"><input type="text" name="txt_yield"  value="<%=m4%>"  size="15%" onKeyPress="allowNumber(this)" maxlength="4" onBlur=""></td>
      <td align="center"><lapschoice:CurrencyTag name="txt_netinc" 	 value='<%=m5%>'  size="15%"  maxlength="10" onBlur="callTotal()"/></td>
    </tr>
    <tr> 
      <% 	if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(2);

				if (arryCol.size() != 0) {

					k1 = Helper.correctNull((String) arryCol.get(3));
					k2 = Helper.correctNull((String) arryCol.get(4));
					k3= Helper.correctNull((String) arryCol.get(5));
					k4 = Helper.correctNull((String) arryCol.get(6));
					k5 = Helper.correctNull((String) arryCol.get(7));
				
				}
				

			} else if (arryRow.size() == 0) {
				k1= "";
				k2= "";
				k3="";
				k4= "";
				k5= "";
			
			}

			%>
      <td height="39" align="center"> <input type="text" name="txt_cropname"  value="<%=k1%>"  size="20%" onKeyPress="notAllowSplChar()" maxlength="25" onBlur=""></td>
      <td align="center"><input type="text" name="txt_area"  value="<%=k2%>"  size="15%" onKeyPress="allowInteger()" maxlength="4" onBlur="chkcentgunt();check();calculate()"></td>
      <td align="center"><input type="text" name="txt_guntas"  value="<%=k3%>"  size="15%" onKeyPress="allowInteger()" maxlength="2" onBlur="chkcentgunt();check();calculate()"> 
        <input type="hidden" name="txt_total_area1" value=""></td>
      <td align="center"><input type="text" name="txt_yield"  value="<%=k4%>"  size="15%" onKeyPress="allowNumber(this)" maxlength="4" onBlur=""></td>
      <td align="center"><lapschoice:CurrencyTag name="txt_netinc"  value='<%=k5%>'  size="15%"  maxlength="9" onBlur="callTotal()"/></td>
    </tr>
    <tr> 
      <% 	if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(3);

				if (arryCol.size() != 0) {

					l1 = Helper.correctNull((String) arryCol.get(3));
					l2 = Helper.correctNull((String) arryCol.get(4));
					l3= Helper.correctNull((String) arryCol.get(5));
					l4= Helper.correctNull((String) arryCol.get(6));
					l5 = Helper.correctNull((String) arryCol.get(7));
					
				}
				

			} else if (arryRow.size() == 0) {
				l1= "";
				l2= "";
				l3= "";
				l4 = "";
				l5 = "";
				
			}

			%>
      <td height="54" align="center"><input type="text" name="txt_cropname"  value="<%=l1%>"  size="20%" onKeyPress="notAllowSplChar()" maxlength="25" onBlur=""></td>
      <td align="center"><input type="text" name="txt_area"  value="<%=l2%>"  size="15%" onKeyPress="allowInteger()" maxlength="4" onBlur="chkcentgunt();check();calculate()"></td>
      <td align="center"><input type="text" name="txt_guntas"  value="<%=l3%>"  size="15%" onKeyPress="allowInteger()" maxlength="2" onBlur="chkcentgunt();check();calculate()"> 
        <input type="hidden" name="txt_total_area1" value=""></td>
      <td align="center"><input type="text" name="txt_yield"  value="<%=l4%>"  size="15%" onKeyPress="allowNumber(this)" maxlength="4" onBlur=""></td>
      <td align="center"><lapschoice:CurrencyTag name="txt_netinc" 	 value='<%=l5%>'  size="15%"  maxlength="10" onBlur="callTotal()"/></td>
    </tr>
    <tr> 
	
      <% 	if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(4);

				if (arryCol.size() != 0) {

					g1 = Helper.correctNull((String) arryCol.get(3));
					g2 = Helper.correctNull((String) arryCol.get(4));
					g3= Helper.correctNull((String) arryCol.get(5));
					g4 = Helper.correctNull((String) arryCol.get(6));
					g5 = Helper.correctNull((String) arryCol.get(7));
					
				}
				

			} else if (arryRow.size() == 0) {
				g1= "";
				g2 = "";
				g3= "";
				g4 = "";
				g5 = "";
			
			}

			%>
      <td height="54" align="center"><input type="text" name="txt_cropname"  value="<%=g1%>"  size="20%" onKeyPress="notAllowSplChar()" maxlength="25" onBlur=""></td>
      <td align="center"><input type="text" name="txt_area"  value="<%=g2%>"  size="15%" onKeyPress="allowInteger()" maxlength="4" onBlur="chkcentgunt();check();calculate()"></td>
      <td align="center"><input type="text" name="txt_guntas"  value="<%=g3%>"  size="15%" onKeyPress="allowInteger()" maxlength="2" onBlur="chkcentgunt();check();calculate()"> 
        <input type="hidden" name="txt_total_area1" value=""></td>
      <td align="center"><input type="text" name="txt_yield"  value="<%=g4%>"  size="15%" onKeyPress="allowNumber(this)" maxlength="4" onBlur=""></td>
      <td align="center"><lapschoice:CurrencyTag name="txt_netinc" 	 value='<%=g5%>'  size="15%"  maxlength="10" onBlur="callTotal()"/></td>
    </tr>
    <tr> 
      <td bgcolor="#71694F" height="54" align="center"><font	size="2" face="MS Sans Serif" color="#FFFFFF">Total 
        </font></td>
      <td colspan="2" bgcolor="#71694F" align="center"><font	size="2" face="MS Sans Serif" color="#FFFFFF">
        <input type="hidden" name="txt_total_area2"  value=""  size="15%" onKeyPress="allowInteger()" maxlength="" onBlur="">
        <input type="text" name="txt_total_area" value=""  size="15%" onKeyPress="allowInteger()" maxlength="" onBlur="">
        (Acreage)</font> </td>
      <td align="center" bgcolor="#71694F">&nbsp;</td>
      <td align="center" bgcolor="#71694F"><lapschoice:CurrencyTag name="txt_totnetinc"  value=''  size="15"  onBlur="chkcentgunt()"/>
        <font	size="2" face="MS Sans Serif" color="#FFFFFF">(Net Income)</font> 
      </td>
    </tr>
  </table>

<br>
<br>
<lapschoice:combutton btntype="EO" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>

			<lapschoice:agrihiddentag />
    </form>

</body>
</html>


