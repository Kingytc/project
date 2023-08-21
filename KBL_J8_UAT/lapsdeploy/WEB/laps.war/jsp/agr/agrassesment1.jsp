<%@include file = "../share/directives.jsp"%>
<%
	String measurementtype = Helper.correctNull((String) hshValues.get("land_measurement"));
	String measurementval = "";
	if (measurementtype.equalsIgnoreCase("c")) {
		measurementval = "Cents";
	} else {
		measurementval = "Guntas";
	}
	ArrayList arryCol = new ArrayList();
	ArrayList arryRowkh = new ArrayList();
	arryRowkh = (ArrayList) hshValues.get("arryRowkh");
	if (arryRowkh == null) {
		arryRowkh = new ArrayList();
	}
%>
<html>
<head>
<title>LAPS -Assesment Form Details</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/agr/agrassesment.js"></script>

<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var id ="";
var apptype="";
var acre = "";var totalvalue=0.00;
var centgunt = "";
var len2=0;
var centgunt_1 = "";

   
var varApptype=new Array();
var varAcctype=new Array();
var varAcctype1=new Array();
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var  strid="<%=Helper.correctNull((String)hshValues.get("strid"))%>";
var  strAction="<%=Helper.correctNull((String)hshValues.get("strAction"))%>";

function callCalender(name,size)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		if(size==1)
			showCal(appUrl,'txt_date');
		else
			showCal(appUrl,name);
		
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

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].target="_parent";
		document.forms[0].action=appUrl+"action/"+"retailpge.jsp";				
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
  	enableButtons( true, true, true, true, false);	
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hidBeanId.value="agrcrops";
	document.forms[0].hidSourceUrl.value="/action/agrassesment1.jsp";
	document.forms[0].hidBeanMethod.value="updateAssesmentData";
	document.forms[0].hidBeanGetMethod.value="getAssesmentData";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}

function doEdit()
{
 	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	enableButtons(true, false, false, false, true);	
}
 
function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agrcrops";
		document.forms[0].hidBeanGetMethod.value="getAssesmentData";
		document.forms[0].action=appUrl+"action/agrassesment1.jsp";
		document.forms[0].submit(); 		
	}
	
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
	document.forms[0].hidAction.value ="delete";
	document.forms[0].action=appUrl+"action/ControllerServlet";		
	document.forms[0].hidBeanMethod.value="updateAssesmentData";
	document.forms[0].hidBeanGetMethod.value="getAssesmentData";
	document.forms[0].hidBeanId.value="agrcrops";
	document.forms[0].hidSourceUrl.value="action/agrassesment1.jsp";	
	document.forms[0].method="post";			
	document.forms[0].submit();		
	}
}

function onloading()
{	
	disableFields(true);
}

function calculateTotal(i,size)
{
	var vararea=0;
	var varscalefin=0.0;
	var varmargin=0.0;
	var varaverageyield=0.0;
	 var varproducevalue=0.0;
	if(i<1 && size==1)
	{
		vararea = document.forms[0].txt_area.value;
   	 	varscalefin = document.forms[0].txt_finance.value;
    	varmargin=document.forms[0].txt_marginamount.value;
    	varaverageyield=document.forms[0].txt_yield.value;
   		varproducevalue=document.forms[0].txt_produce.value;
	}
	else
	{
		vararea = document.forms[0].txt_area[i].value;
    	varscalefin = document.forms[0].txt_finance[i].value;
    	varmargin=document.forms[0].txt_marginamount[i].value;
    	varaverageyield=document.forms[0].txt_yield[i].value;
   		varproducevalue=document.forms[0].txt_produce[i].value;
	}
	
	var varlength=vararea.indexOf(".");
    var varacre=parseFloat(vararea.substring(0,varlength));
    var varcents=parseFloat(vararea.substring(varlength,vararea.length))*100;
    var guntarate=0.0;
    var acrerate=0.0;
    var totalrate=0.0;
    
    var guntayield=0.0;
    var acreyield=0.0;
    var totyield=0.0;
    var totincome=0.0;
    var loanamount=0.0;
    
    var measurementtype = document.forms[0].measurement.value;
    
    if(measurementtype == 'g')
   		{
  		guntarate = varcents / 40;
  		guntayield=guntarate * varaverageyield;
  		guntarate = varscalefin * guntarate;
  		acrerate = 	varscalefin* varacre; 
  		acreyield =varaverageyield*varacre;
  		totalrate = acrerate + guntarate;
  		totyield = acreyield + guntayield;
   		}
   if(measurementtype == 'c')
   		{
  		totalrate = eval(vararea) * eval(varscalefin);
  		totyield = eval(vararea) * eval(varaverageyield);
		}
	
	
	loanamount=totalrate-varmargin;
	
	totincome=eval(totyield)*eval(varproducevalue);
	if(i<1 && size==1)
		{
		document.forms[0].txt_surplus.value=NanNumber(parseFloat(totincome)-parseFloat(loanamount));
		document.forms[0].txt_amount1.value=NanNumber(loanamount);
		document.forms[0].txt_eligibility.value=NanNumber(totalrate);
		}
	else
		{
		document.forms[0].txt_surplus[i].value=NanNumber(parseFloat(totincome)-parseFloat(loanamount));
		document.forms[0].txt_amount1[i].value=NanNumber(loanamount);
		document.forms[0].txt_eligibility[i].value=NanNumber(totalrate);
		}
	}

</script>

</head>
<body onLoad="onloading();">
<form name="frmpri" method=post>
<table width="100%" border="0" cellspacing="0" cellpadding="1" class="normal">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable border1">
			<tr>
				<td height="0" colspan="13">
				<table width="100%" border="0" cellspacing="2" cellpadding="1"
					class="outertable">
					<tr class="dataheader" BORDER="1">
						<td  width="16%" colspan="2"><b><font size="1"
							face="MS Sans Serif" >Season-Crop Name </font></b></td>
						<td align="center" width="9%"><b><font
							 size="1" face="MS Sans Serif">Date of planting</font></b></td>
						<td align="center"  width="6%"><b><font size="1"
							face="MS Sans Serif" >Area <br>
						in Acre/<%=measurementval%></font></b></td>
						
                  <td align="center"  width="10%"><b><font face="MS Sans Serif" size="1" >Cost 
                    of Cultivation / Acre</font></b></td>
						
                  <td align="center"  width="6%"><b><font size="1" face="MS Sans Serif" >Total 
                    Cost of Cultivation</font></b></td>
						
                  <td align="center"  width="6%"><b><font size="1" face="MS Sans Serif" >Margin</font><font size="1" face="MS Sans Serif" ><br>
						Amount </font></b></td>
						
                  <td align="center"  width="6%"><b><font size="1" face="MS Sans Serif" >Eligible 
                    Loan Amount </font></b></td>
						<td align="center"  width="7%"><b><font
							face="MS Sans Serif" size="1" >Average Yield/acre
						</font></b></td>
						<td align="center"  width="8%"><b><font size="1"
							face="MS Sans Serif" >Value of <br>
						Produce<br>
						<font face="MS Sans Serif" size="1" >/acre/unit(Rs)</font></font></b></td>
						<td align="center"  width="6%"><b><font size="1"
							face="MS Sans Serif" >Net <br>
						Surplus </font></b></td>
						<td align="center"  width="8%"><b><font size="1"
							face="MS Sans Serif" >Repayment(in Months)</font></b></td>
						<td align="center"  width="12%"><b><font size="1"
							face="MS Sans Serif" >&nbsp; Remarks</font></b></td>
					</tr>
					<tr class="dataheader">
						<td  width="16%" colspan="2"><b><font size="1"
							face="MS Sans Serif" > SEASON </font></b></td>
						<td colspan="11" align="center" ><b></b><b><font
							size="1" face="MS Sans Serif" > </font></b><b></b><b></b><b></b><b></b><b></b><b></b><b></b><b></b><b><font
							size="1" face="MS Sans Serif" > </font></b><b><font
							size="1" face="MS Sans Serif" > </font></b></td>
					</tr>
					<tr>
						<%if (arryRowkh != null && arryRowkh.size() != 0) {
				String temp = "";
				for (int i = 0; i < arryRowkh.size(); i++) {
					arryCol = (ArrayList) arryRowkh.get(i);

					%>
						<td width="8%"><input type="hidden" name="hidseqno"
							value="<%=Helper.correctNull((String) arryCol.get(0))%>"> <input
							type="hidden" name="hidsno"
							value="<%=Helper.correctNull((String) arryCol.get(1))%>"> <input
							type="hidden" name="hidcroptype"
							value="<%=Helper.correctNull((String) arryCol.get(2))%>"> &nbsp;<b><font
							size="1" face="MS Sans Serif" color="#000000"> 
							<%if (!(temp.equals(Helper.correctNull((String) arryCol
							.get(2))))) {
						temp = Helper.correctNull((String) arryCol.get(2));
						if (temp.equals("k1")) {
							out.println("Kharif");
						} else if (temp.equals("r1")) {
							out.println("Rabi");
						} else if (temp.equals("s1")) {
							out.println("Summer");
						} else if (temp.equals("a1")) {
							out.println("Annual");
						} else if (temp.equals("p1")) {
							out.println("Perrenial");
						}
					}

					%></font></b></td>
						
                  <td width="8%">
                    <input type="text" name="txt_crop" size="30"
							maxlength="200"
							value="<%=Helper.correctNull((String) arryCol.get(13))%>"
							onKeyPress="">
                  </td>
						<td width="9%">
						<table width="40%" border="0" cellspacing="0" cellpadding="1">
							<tr>
								<td><input type="text" name="txt_date" size="10" maxlength="10"
									value="<%=Helper.correctNull((String) arryCol.get(3))%>"
									onKeyPress="" style="text-align:right;"></td>
								<td><a href="#" onClick="callCalender('txt_date[<%=i%>]',<%=arryRowkh.size()%>)"
									title="Click to view calender" border=0><img
									src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
									width="0" height="23" border="0"></a></td>
							</tr>
						</table>
						</td>
						<td width="6%"><input type="text" name="txt_area" size="10"
							maxlength="15"
							value="<%=Helper.correctNull((String) arryCol.get(4))%>"
							onKeyPress="" onBlur="" style="text-align:right;"></td>
						<td width="10%">
						<table width="40%" border="0" cellspacing="0" cellpadding="1">
							<tr>
								<td><input type="text" name="txt_finance" readOnly size="10"
									maxlength="15"
									value="<%=Helper.correctNull((String) arryCol.get(5))%>"
									onKeyPress="allowNumber(this)"
									onBlur="calculateTotal(<%=i%>,<%=arryRowkh.size()%>)"
									style="text-align:right;"></td>
								<td>&nbsp;</td>
							</tr>
						</table>
						</td>
						<td width="6%"><input type="text" name="txt_eligibility" readOnly
							size="10" maxlength="15"
							value="<%=Helper.correctNull((String) arryCol.get(6))%>"
							onKeyPress="allowNumber(this)" onBlur=""
							style="text-align:right;"> <input type="hidden" name="txt_cult2"
							size="10" maxlength="15" value="" style="text-align:right;"></td>
						<td width="6%"><input type="hidden" name="txt_amount"  
									value='<%=Helper.correctNull((String) arryCol.get(7))%>'>
									<input type="text" name="txt_marginamount" size="10"
							maxlength="15"
							value="<%=Helper.correctNull((String) arryCol.get(15))%>"
							onKeyPress="allowNumber(this)" onBlur="calculateTotal(<%=i%>,<%=arryRowkh.size()%>)"
							style="text-align:right;"></td>
						<td width="6%"><input type="text" name="txt_amount1" size="10"
							maxlength="15" value="<%=Helper.correctNull((String) arryCol.get(8))%>" onKeyPress="allowNumber(this)" onBlur=""
							style="text-align:right;"></td>
						<td width="7%"><input type="text" name="txt_yield" size="10"
							maxlength="15"
							value="<%=Helper.correctNull((String) arryCol.get(9))%>"
							onKeyPress="allowNumber(this)" onBlur="calculateTotal(<%=i%>,<%=arryRowkh.size()%>)"
							 style="text-align:right">
						</td>
						<td width="8%"><input type="text" name="txt_produce" size="10"
							maxlength="15"
							value="<%=Helper.correctNull((String) arryCol.get(10))%>"
							onKeyPress="allowNumber(this)" onBlur="calculateTotal(<%=i%>,<%=arryRowkh.size()%>)"
							style="text-align:right;"></td>
						<td width="6%"><input type="text" name="txt_surplus" size="10"
							maxlength="15"
							value="<%=Helper.correctNull((String) arryCol.get(11))%>"
							onKeyPress="allowNumber(this)" onBlur=""
							style="text-align:right;"></td>
						<td width="8%"><input type="text" name="txt_repay" size="10"
							maxlength="4"
							value="<%=Helper.correctNull((String) arryCol.get(12))%>"
							onKeyPress="allowNumber(this)" onBlur=""
							style="text-align:right;"></td>
						<td width="12%"><textarea name="txt_remarks" cols="15" rows="2"
							onKeyPress="notAllowSingleQuote();textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) arryCol
											.get(14))%></textarea></td>
					</tr>
					<%}
			}

			%>

					<tr>
						<td colspan="13"><br>
	<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
   					

						<br>
						<b><font size="3" face="MS Sans Serif" color="">B=Bunches,N=Nuts</font></b>
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
		<input type="hidden" name="hid_sno" value="<%=Helper.correctNull((String)hshValues.get("strid"))%>">
		<input type="hidden" name="measurement" value="<%=Helper.correctNull((String)hshValues.get("land_measurement"))%>">

</form>
</body>
</html>