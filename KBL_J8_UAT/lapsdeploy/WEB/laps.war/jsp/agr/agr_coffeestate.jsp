<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />

<%
			ArrayList vecData = new ArrayList();
			ArrayList vecRow = new ArrayList();
			int vecsize = 0;
			int vecsize2 = 0;
			if (hshValues != null) {
				vecData = (ArrayList) hshValues.get("vecData");

			}
			//--------------------
			double acreval = 0.00;
			double centguntval = 0.00;
			double totalacreval = 0.00;
			double totalcentgunt =0.00; 
			double guntasrealq = 0.00; 
			double guntasrealr = 0.00; 
			//-----------
%>

<html>
<head>
<title>LAPS - Agriculture Coffee Estate</title>
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

function chkcentgunt() 
{
		if(document.forms[0].land_measurement.value == 'g')
		{
			if(document.forms[0].txt_acreage1.value > 39)
			{
			 alert("The Data you entered is not valid");
			 document.forms[0].txt_acreage1.value = "";
			 document.forms[0].txt_acreage1.focus();
			}
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
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=one;		  
		}		
	}		
	
}

function selectValues(val1, val2, val3, val4, val5, val6, val7, val8, val9, val10, val11, val12)
{
	document.forms[0].selsno.value = val3;
	document.forms[0].txt_estate.value = val2;  
	document.forms[0].txt_coffeeregno.value = val4;
	document.forms[0].txt_village.value = val5;
	document.forms[0].txt_taluk.value = val6;
	document.forms[0].txt_district.value = val7;
	document.forms[0].txt_survey.value = val8;
	document.forms[0].txt_location.value = val9;
	document.forms[0].txt_value.value = val10;
	document.forms[0].txt_acreage.value = val11;
	document.forms[0].txt_acreage1.value = val12;
	disableCommandButtons("radioselect");
    
}

function doSave()
{
  
     
     if(document.forms[0].txt_acreage.value == "")
     {
     alert('Please enter the acreage value in acres');
     document.forms[0].txt_acreage.focus();
     return;
     }
     if(document.forms[0].txt_acreage1.value == "")
     {
      document.forms[0].txt_acreage1.value="0";
   
     }
	disableCommandButtons("load");
	document.forms[0].hidBeanId.value="agrcoffee";
	document.forms[0].hidSourceUrl.value="/action/agr_coffeestate.jsp";
	document.forms[0].hidBeanMethod.value="updateCoffeeEstateData";
	document.forms[0].hidBeanGetMethod.value="getCoffeeEstateData";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}

function disableCommandButtons(val)
{

	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdnew.disabled =false;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddel.disabled=true;
		document.forms[0].cmdapply.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}	 
	if(val=="edit")
	{		  
		document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddel.disabled=true;
		document.forms[0].cmdapply.disabled=false;
		document.forms[0].cmdcancel.disabled=false;		 
		document.forms[0].cmdclose.disabled=true;	 
		disableFields(false);
	}
	if(val=="radioselect")
	{	  
		document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddel.disabled=false;
		document.forms[0].cmdapply.disabled=true;
		document.forms[0].cmdcancel.disabled=false;
		document.forms[0].cmdclose.disabled=false;
	}	  
}  

function doEdit()
{
 	disableFields(false);
 	document.forms[0].hideditflag.value ="Y";
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");
}

function callhelp()
{
	var varQryString = appUrl+"/jsp/perhlp/hlp_edueducational.jsp"
	var title = "ApplicantDemographics";
	var prop = "scrollbars=no,width=600,height=450";	
	prop = prop + ",left=200,top=150";
	window.open(varQryString,title,prop);
}

function doNew()
{
	disableFields(false);
	disableCommandButtons("edit");
	document.forms[0].hideditflag.value ="Y";
	document.forms[0].hidAction.value ="insert";
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].checked=false;
		}	  
	}
}

function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agrcoffee";
		document.forms[0].hidBeanGetMethod.value="getCoffeeEstateData";
		document.forms[0].action=appUrl+"action/agr_coffeestate.jsp";
		document.forms[0].submit(); 		
	}
}

function doDelete()
{
   if( ConfirmMsg(101))
	{
	document.forms[0].hidAction.value ="delete";
	document.forms[0].action=appUrl+"action/ControllerServlet";		
	document.forms[0].hidBeanMethod.value="updateCoffeeEstateData";
	document.forms[0].hidBeanGetMethod.value="getCoffeeEstateData";
	document.forms[0].hidBeanId.value="agrcoffee";
	document.forms[0].hidSourceUrl.value="action/agr_coffeestate.jsp";	
	document.forms[0].method="post";			
	document.forms[0].submit();		
	}
}
	
function onloading()
{	  
	disableFields(true);
}

function call_page(url)
{	
	document.forms[0].action=appUrl+"action/"+url;
	document.forms[0].submit();	
}


</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css">
</head>
<body onLoad="onloading()">
<form name="frmpri" method="post">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellpadding="5" cellspacing="0"
			class="outertable border1">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="3"
							bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
							<tr>
								
                        <td > 
<table width="100%" border="0" cellspacing="3" cellpadding="0">
                            <tr> 
                              <td height="54" bgcolor="#71694F" colspan="4" nowrap="nowrap"><font  color="#FFFFFF"><strong>Particulars 
                                of Estate Owned</strong></font></td>
                            </tr>
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
                            <tr> 
                              <td nowrap="nowrap"><font 
											color="#000000">Name of the Estate(s) 
                                Owned </font></td>
                              <td  nowrap="nowrap"><input type="text" name="txt_estate" value=""
											maxlength="40" size="15" onKeyPress="notAllowSplChar()"></td>
                              <td  nowrap="nowrap"><font color="#000000" >Coffee 
                                Registration No.</font></td>
                              <td  nowrap="nowrap"><input type="text" name="txt_coffeeregno" size="15"
											onKeyPress=""
											style="text-align:left" maxlength="18"></td>
                            </tr>
                            <tr> 
                              <td  nowrap="nowrap"><font color="#000000" >Village</font></td>
                              <td  nowrap="nowrap"><font color="#000000"> 
                                <input type="text" name="txt_village" value="" onKeyPress="notAllowSplChar()"
											maxlength="20" size="15">
                                </font></td>
                              <td  nowrap="nowrap" ><font color="#000000" >Location(Zone)</font></td>
                              <td  nowrap="nowrap" ><input type="text" name="txt_location" size="15"
											onKeyPress="notAllowSplChar()"
											style="text-align:left" maxlength="20"></td>
                            </tr>
                            <tr> 
                              <td  nowrap="nowrap"><font color="#000000" >Taluk</font></td>
                              <td  nowrap="nowrap"><font color="#000000"> 
                                <input type="text" name="txt_taluk" value="" onKeyPress="notAllowSplChar()"
											maxlength="20" size="15">
                                </font></td>
                              <td  nowrap="nowrap" ><font color="#000000" >Survey 
                                No. </font></td>
                              <td  nowrap="nowrap" ><input type="text" name="txt_survey" size="15"
											onKeyPress=""
											style="text-align:left" maxlength="50"></td>
                            </tr>
                            <tr> 
                              <td  nowrap="nowrap"><font color="#000000" >District</font></td>
                              <td  nowrap="nowrap"><font color="#000000"> 
                                <input type="text" name="txt_district" value="" onKeyPress="notAllowSplChar()"
											maxlength="20" size="15">
                                </font></td>
                              <td  nowrap="nowrap" ><font color="#000000" >Value 
                                of Land(Rs. in Lakhs)</font></td>
                              <td  nowrap="nowrap" ><lapschoice:CurrencyTag name="txt_value" size="15"
											
											 maxlength="8"/></td>
                            </tr>
                            <tr> 
                              <td  nowrap="nowrap"><font 
											color="#000000">Extent</font><font 
											color="#000000"><b><font 
													color="#FF0000">*</font></b><br>
                                <b></b></font></td>
                              <td  nowrap="nowrap"><font color="#000000"> 
                                <input type="text"
											name="txt_acreage" value="" size="15" maxlength="3"
											onKeyPress="allowInteger()"
											style="text-align:right">
                                </font><font 
											color="#000000"> Acre</font><font color="#000000">&nbsp; 
                                </font><font color="#000000">&nbsp; </font></td>
                              <td  nowrap="nowrap"><font color="#000000"> 
                                <input type="text"
											name="txt_acreage1" value="" size="15" maxlength="2"
											onKeyPress="allowInteger()"
											style="text-align:right" onBlur="chkcentgunt()">
                                </font><font 
											color="#000000"><%=measurementval%></font><font color="#000000">&nbsp; 
                                </font><font color="#000000">&nbsp; </font></td>
                              <td  nowrap="nowrap" >&nbsp;</td>
                            </tr>
                            <tr>
                              <td  nowrap="nowrap"><font color="#000000" >Total 
                                Acreage </font></td>
								   
                        
                              <td  nowrap="nowrap">
                                <%
                              vecsize2 = vecData.size();
                  			for (int j = 0; j < vecsize2; j++) {
                  				vecRow = (ArrayList) vecData.get(j);
                  				if (vecRow != null) {
								
                      acreval = Double.parseDouble(Helper.correctDouble((String) vecRow.get(10)));
					centguntval = Double.parseDouble(Helper.correctDouble((String)vecRow.get(11)));
					totalacreval = totalacreval + acreval;
					totalcentgunt = totalcentgunt + centguntval;	
					}
                  			}
                  			 %>
                                <%
                                if(measurementtype.equalsIgnoreCase("g"))
                      	  		{
                      	 
                      	  		                    	 		        
					guntasrealq  = totalcentgunt % 40;
					guntasrealr   = totalcentgunt / 40 ;
					if(guntasrealr >= 1)
					{
						totalacreval = 	totalacreval + guntasrealr;
					}
					totalacreval = Math.floor(totalacreval);
					
         	  		}
                   else 
                   {
                   	guntasrealq  = totalcentgunt % 100;
   					guntasrealr   = totalcentgunt / 100 ;
   					if(guntasrealr >= 1)
   					{
   						totalacreval = 	totalacreval + guntasrealr;
   					}
   					totalacreval = Math.floor(totalacreval);
                   }					
					%>
                                <%=totalacreval%><font  color="#000000">&nbsp;&nbsp;Acres&nbsp;&nbsp;&nbsp;<%=guntasrealq%>&nbsp;&nbsp;<%=measurementval%></font></td>
                              <td  nowrap="nowrap" >&nbsp;</td>
                              <td  nowrap="nowrap" >&nbsp;</td>
                            </tr>
                          </table>
						  </td>
							</tr>
						</table>
						
                  </td>
					</tr>
					<tr>
						<td>
<lapschoice:combutton btntype='NO' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
			
						<br>
						</td>
					</tr>
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="1" cellpadding="2">
							<tr class="tabactive">
								
                        <td width="10%" align="center" bgcolor="#71694F"><font
									 color="#FFFFFF">Particulars 
                          of Estate Owned</font></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="1" cellpadding="2">
                      <%if (vecData != null) {
				%>
                      <tr bgcolor="#71694F" class="tabactive"> 
                        <td width="5%" align="center"><font 
									color="#FFFFFF">&nbsp;</font></td>
                        <td width="6%" align="center"><font 
									color="#FFFFFF">Estate Owned</font></td>
                        <td width="4%" align="center"><font 
									color="#FFFFFF">Village/Taluk/District</font></td>
                        <td width="5%" align="center"><font 
									color="#FFFFFF">Survey No.</font></td>
                        <td width="7%" align="center"><font 
									color="#FFFFFF"> Acreage(Acres/
											<%=measurementval%>)</font></td>
                        <td width="8%" align="center"><font 
									color="#FFFFFF">Value of Land</font></td>
                      </tr>
                      <%vecsize = vecData.size();
				//out.println("vecsize"+vecsize);
			}
			String strSno = "";

			for (int i = 0; i < vecsize; i++) {
				vecRow = (ArrayList) vecData.get(i);
				//out.println("VecRow"+vecRow);
				if (vecRow != null) {
					strSno = Helper.correctNull((String) vecRow.get(2));
			
					acreval = Double.parseDouble(Helper.correctDouble((String) vecRow.get(10)));
					centguntval = Double.parseDouble(Helper.correctDouble((String)vecRow.get(11)));
					totalacreval = totalacreval + acreval;
					totalcentgunt = totalcentgunt + centguntval;
					
					
					%>
                      <tr align="center"> 
                        <td bgcolor="#FFFFFF"><input type="radio" name="sno"
									style="border-style:none"
									onClick="selectValues('<%=Helper.correctNull((String) vecRow.get(0))%>', '<%=Helper.correctNull((String) vecRow.get(1)) %>','<%=Helper.correctNull((String) vecRow.get(2))%>','<%=Helper.correctNull((String) vecRow.get(3))%>', '<%=Helper.correctNull((String) vecRow.get(4))%>','<%=Helper.correctNull((String) vecRow.get(5))%>','<%=Helper.correctNull((String) vecRow.get(6))%>','<%=Helper.correctNull((String) vecRow.get(7))%>','<%=Helper.correctNull((String) vecRow.get(8))%>',
											'<%=Helper.correctNull((String) vecRow.get(9)) %>','<%=Helper.correctNull((String) vecRow.get(10))%>','<%=Helper.correctNull((String) vecRow.get(11))%>')"> 
                          <input type="hidden" name="hid" value="<%=strSno%>"></td>
                        <td align="center" valign="middle" bgcolor="#FFFFFF"><%=Helper.correctNull((String) vecRow.get(1))%></td>
                        <td align="center" valign="middle" bgcolor="#FFFFFF">&nbsp;<%=Helper.correctNull((String) vecRow.get(4))%>/ 
						<%=Helper.correctNull((String) vecRow.get(5))%>/<%=Helper.correctNull((String) vecRow.get(6))%>
                          &nbsp; &nbsp; &nbsp; &nbsp;</td>
                        <td valign="middle" bgcolor="#FFFFFF">&nbsp; <%=Helper.correctNull((String) vecRow.get(7))%></td>
                        <td align="right" bgcolor="#FFFFFF"> &nbsp; <%=Helper.correctNull((String) vecRow
											.get(10))%>.<%=Helper.correctNull((String) vecRow
											.get(11))%> </td>
                        <td valign="middle" bgcolor="#FFFFFF"><%=Helper.correctNull((String) vecRow
											.get(9))%></td>
                      </tr>
                      <%}
			                    }%>
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
<lapschoice:agrihiddentag />
<input type="hidden" name="selsno">
</form>
</body>
</html>






