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
	String  d1="",d2="",d3="",d4="",d5="",d6="";
	String d7="",d8="",d9="",d10="",d11="",d12="";
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
function chkcentgunt() 
{
  if(document.forms[0].land_measurement.value == 'g')
		{
    for(var j=0;j<=1;j++)
     {
     var guntas1 = document.forms[0].txt_guntas1[j].value;
		
			if(eval(guntas1) > 39)
			{
			 alert("The Data you entered in Planted Area is not valid");
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
			 alert("The Data you entered in Bearing Area is not valid");
			document.forms[0].txt_guntas2[k].value="";
		    document.forms[0].txt_guntas2[k].focus();
	         return;
			}
		}
		 for(var i=0;i<=1;i++)
     {
     var guntas3 = document.forms[0].txt_guntas3[i].value;
		
			if(eval(guntas3) > 39)
			{
			 alert("The Data you entered in Non-Bearing Area is not valid");
			document.forms[0].txt_guntas3[i].value="";
		    document.forms[0].txt_guntas3[i].focus();
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
	document.forms[0].hidBeanId.value="agrcoffee";		
	document.forms[0].hidSourceUrl.value="/action/agrcropplantation.jsp";
	document.forms[0].hidBeanMethod.value="updatecoffeeplantdata";
	document.forms[0].hidBeanGetMethod.value="getcoffeeplantdata";
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
		document.forms[0].hidBeanGetMethod.value="getcoffeeplantdata";
		document.forms[0].action=appUrl +"action/agrcropplantation.jsp";
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
		document.forms[0].hidBeanMethod.value="updatecoffeeplantdata";
		document.forms[0].hidBeanGetMethod.value="getcoffeeplantdata";
		document.forms[0].hidBeanId.value="agrcoffee";
		document.forms[0].hidSourceUrl.value="action/agrcropplantation.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}	
}
function callCalender1(name)

{
	if(document.forms[0].cmdapply.disabled==false)

	{
	showCal(appUrl,name);
    }

}

function callCalender2(name)
{
	if(document.forms[0].cmdapply.disabled==false)
	{
		showCal(appUrl,name);
	}
}

function callCalender3(name)
{
	if(document.forms[0].cmdapply.disabled==false)
	{
		showCal(appUrl,name);
	}
}


</script>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css">
</head>
<body onload="onloading()">
	<form name="frmpri" method="post">
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
    <tr bgcolor="#71694F"> 
      <td><font	size="2" face="MS Sans Serif" color="#FFFFFF">Crop Name </font></td>
      <td colspan="2" align="center"><font color="#FFFFFF" size="2" face="MS Sans Serif">Planted 
        Area </font></td>
      <td colspan="2" align="center"><font color="#FFFFFF" size="2" face="MS Sans Serif">Bearing 
        Area </font></td>
      <td colspan="2" align="center"><font color="#FFFFFF" size="2" face="MS Sans Serif">Non-Bearing 
        Area </font></td>
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
                          
      <td width="12%">&nbsp;</td>
      <td width="15%" align="center"><font color="#FFFFFF" size="2" face="MS Sans Serif">(Acres)</font></td>
      <td width="11%" align="center"><font face="MS Sans Serif" size="1"
											color="#FFFFFF">(<%=measurementval%>)</font></td>
      <td width="15%" align="center"><font color="#FFFFFF" size="2" face="MS Sans Serif">(Acres)</font></td>
      <td width="15%" align="center"><font face="MS Sans Serif" size="1"
											color="#FFFFFF">(<%=measurementval%>)</font></td>
      <td width="17%" align="center"><font color="#FFFFFF" size="2" face="MS Sans Serif">(Acres)</font></td>
      <td width="15%" align="center"><font face="MS Sans Serif" size="1"
											color="#FFFFFF">(<%=measurementval%>)</font></td>
    </tr>
    <tr> 
      <%
						
				if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(0);
				
				if (arryCol.size() != 0) {
					 
					d1 = Helper.correctNull((String) arryCol.get(4));
					d2 = Helper.correctNull((String) arryCol.get(5));
					d3 = Helper.correctNull((String) arryCol.get(6));
					d4 = Helper.correctNull((String) arryCol.get(7));
					d5 = Helper.correctNull((String) arryCol.get(8));
					d6 = Helper.correctNull((String) arryCol.get(9));
					
				}
			
			} else if (arryRow.size() == 0) {
				d1 = "";
				d2 = "";
				d3 = "";
				d4 = "";
				d5= "";
				d6 = "";
				
			}

			%>
      <td>Arabica</td>
      <td><input type="text" name="txt_area1"  value="<%=d1%>"  size="15%" onKeyPress="allowInteger()" maxlength="4"></td>
      <td><input type="text" name="txt_guntas1"  value="<%=d2%>"  size="15%" onKeyPress="allowInteger()" maxlength="2" onBlur="chkcentgunt()"></td>
      <td><input type="text" name="txt_area2"  value="<%=d3%>"  size="15%" onKeyPress="allowInteger()" maxlength="4"></td>
      <td><input type="text" name="txt_guntas2"  value="<%=d4%>"  size="15%" onKeyPress="allowInteger()" maxlength="2" onBlur="chkcentgunt()"></td>
      <td><input type="text" name="txt_area3"  value="<%=d5%>"  size="15%" onKeyPress="allowInteger()" maxlength="4"></td>
      <td><input type="text" name="txt_guntas3"  value="<%=d6%>"  size="15%" onKeyPress="allowInteger()" maxlength="2" onBlur="chkcentgunt()"></td>
    </tr>
    <tr> 
      <% 	if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(1);

				if (arryCol.size() != 0) {

					d7 = Helper.correctNull((String) arryCol.get(4));
					d8 = Helper.correctNull((String) arryCol.get(5));
					d9= Helper.correctNull((String) arryCol.get(6));
					d10 = Helper.correctNull((String) arryCol.get(7));
					d11 = Helper.correctNull((String) arryCol.get(8));
					d12= Helper.correctNull((String) arryCol.get(9));
					
				}
				

			} else if (arryRow.size() == 0) {
				d7= "";
				d8 = "";
				d9= "";
				d10 = "";
				d11 = "";
				d12 = "";
				
			}

			%>
      <td height="54">Robusta </td>
      <td><input type="text" name="txt_area1"  value="<%=d7%>"  size="15%" onKeyPress="allowInteger()" maxlength="4"></td>
      <td><input type="text" name="txt_guntas1"  value="<%=d8%>"  size="15%" onKeyPress="allowInteger()" maxlength="2" onBlur="chkcentgunt()"></td>
      <td><input type="text" name="txt_area2"  value="<%=d9%>"  size="15%" onKeyPress="allowInteger()" maxlength="4"></td>
      <td><input type="text" name="txt_guntas2"  value="<%=d10%>"  size="15%" onKeyPress="allowInteger()" maxlength="2" onBlur="chkcentgunt()"></td>
      <td><input type="text" name="txt_area3"  value="<%=d11%>"  size="15%" onKeyPress="allowInteger()" maxlength="4"></td>
      <td><input type="text" name="txt_guntas3"  value="<%=d12%>"  size="15%" onKeyPress="allowInteger()" maxlength="2" onBlur="chkcentgunt()"></td>
    </tr>
  </table>

<br>
<br>
<lapschoice:combutton btntype="EO" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>

<lapschoice:agrihiddentag />
</form>
</body>
</html>


