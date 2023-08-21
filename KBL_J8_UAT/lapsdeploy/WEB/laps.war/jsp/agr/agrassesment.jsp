<%@include file = "../share/directives.jsp"%>

<%String measurementtype = Helper.correctNull((String) hshValues
					.get("land_measurement"));
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
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/agr/agrassesment.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
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

function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,name);
		
	}
}

function showfinance(i,j)
{
	if(document.forms[0].hideditflag.value == "Y")
	{ 
		var action=document.forms[0].hidAction.value;
		var prop = "scrollbars=no,width=650,height=400,top=100,left=250";
		var url=appURL+"action/scalefinancemasterlist.jsp?&strfrom=DistrictMasterCrop1&txtid="+i+"&size="+j;
		window.open(url,"",prop);
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
		document.forms[0].action=appURL+"action/"+"retailpge.jsp";				
		document.forms[0].submit();


	}
}

function disableFields(one)
{	
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			if(document.forms[0].elements[i].name=='txt_finance' || document.forms[0].elements[i].name=='txt_eligibility' || document.forms[0].elements[i].name=='txt_amount' 
			|| document.forms[0].elements[i].name=='txt_yield' || document.forms[0].elements[i].name=='txt_produce' || document.forms[0].elements[i].name=='txt_surplus' 
			|| document.forms[0].elements[i].name=='txt_amount1' || document.forms[0].elements[i].name=='txt_eligibility' || document.forms[0].elements[i].name=='txt_area' 
			|| document.forms[0].elements[i].name=='txt_crop' )
			{
			document.forms[0].elements[i].readOnly=true;
			}
			else
			{			
			document.forms[0].elements[i].readOnly=one;
			}
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
	document.forms[0].hidSourceUrl.value="/action/agrassesment.jsp";
	document.forms[0].hidBeanMethod.value="updateAssesmentData";
	document.forms[0].hidBeanGetMethod.value="getAssesmentData"; 
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doEdit()
{
 	disableFields(false);
 	document.forms[0].hideditflag.value="Y";
	document.forms[0].hidAction.value="insert";
	enableButtons(true, false, false, true, true);	
	
}

function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agrcrops";
		document.forms[0].hidBeanGetMethod.value="getAssesmentData";
		document.forms[0].action=appURL+"action/agrassesment.jsp";
		document.forms[0].submit(); 		
	}
}

function doDelete()
{
	document.forms[0].hidAction.value ="delete";
	document.forms[0].action=appURL+"action/ControllerServlet";		
	document.forms[0].hidBeanMethod.value="updateAssesmentData";
	document.forms[0].hidBeanId.value="agrcrops";
	document.forms[0].hidSourceUrl.value="action/agrassesment.jsp";	
	document.forms[0].method="post";			
	document.forms[0].submit();		
}

function onloading()
{	
	disableFields(true);
	<%if (arryRowkh != null && arryRowkh.size() != 0) {%>
	document.forms[0].txt_crop.readOnly=true;	
	<%}%>
}

function call_page(url)
{
	document.forms[0].action=appURL+"action/"+url;
	document.forms[0].submit();	
}

function calculateTotal(i,size)
{
	var vararea=0;
	var varscalefin=0.0;
	var varloanrequired=0.0;
	var varaverageyield=0.0;
	 var varproducevalue=0.0;
	if(i<1 && size==1)
		{
		vararea = document.forms[0].txt_area.value;
   	 	varscalefin = document.forms[0].txt_finance.value;
    	varloanrequired=document.forms[0].txt_amount.value;
    	varaverageyield=document.forms[0].txt_yield.value;
   		varproducevalue=document.forms[0].txt_produce.value;
		}
	else
		{
		vararea = document.forms[0].txt_area[i].value;
    	varscalefin = document.forms[0].txt_finance[i].value;
    	varloanrequired=document.forms[0].txt_amount[i].value;
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
    var leastamount=0.0;
    
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
	
	

	if(parseFloat(totalrate)<parseFloat(varloanrequired))
		{
		leastamount=totalrate;
		}
	else
		{
		leastamount=varloanrequired;
		}
	totincome=eval(totyield)*eval(varproducevalue);
	if(i<1 && size==1)
		{
		document.forms[0].txt_surplus.value=NanNumber(parseFloat(totincome)-parseFloat(leastamount));
		document.forms[0].txt_amount1.value=leastamount;
		document.forms[0].txt_eligibility.value=totalrate;
		}
	else
		{
		document.forms[0].txt_surplus[i].value=NanNumber(parseFloat(totincome)-parseFloat(leastamount));
		document.forms[0].txt_amount1[i].value=leastamount;
		document.forms[0].txt_eligibility[i].value=totalrate;
		}
	}

</script>

</head>
<body onLoad="onloading()" >
<form name="frmpri" method=post class="normal">


<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable border1">
	<tr>
		<td>
		
		<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
			<tr>
				<td colspan="13">
				<table width="100%" border="0" cellspacing="1" cellpadding="1"
					class="outertable">
					<tr class="dataheader">
						<td  width="16%" colspan="2"><b>Season-Crop Name </b></td>
						<td align="center"  width="9%"><b>Date of planting</b></td>
						<td align="center"  width="6%"><b>Area <br>
						in Acre / <%=measurementval%></b></td>
						<td align="center" width="10%"><b>Scale of <br>
						Finance</b></td>
						<td align="center"  width="6%"><b>Eligibile Limit As Per DCC Scale</b></td>
						<td align="center"  width="6%"><b>Loan <br>
						Amount </b></td>
						<td align="center" width="6%"><b>Least Amount </b></td>
						<td align="center"  width="7%"><b>Yield/acre (in Units) </b></td>
						<td align="center"  width="8%"><b>Value / Unit<br>
						/acre/unit (Rs)</b></td>
						<td align="center"  width="6%"><b>Net <br>
						Surplus </b></td>
						<td align="center"  width="8%"><b>Repayment (in Months)</b></td>
						<td align="center"  width="12%"><b>&nbsp; Remarks</b></td>
					</tr>
					<tr class="dataheader">
						<td  width="16%" colspan="2"><b> SEASON </b></td>
						<td colspan="11" align="center" ><b></b><b></b><b></b><b></b><b></b><b></b><b></b><b></b><b></b><b></b><b> </b><b> </b></td>
					</tr>
					
						<%if (arryRowkh != null && arryRowkh.size() != 0) {
				String temp = "";
				int arrLength = arryRowkh.size();
				for (int i = 0; i < arryRowkh.size(); i++) {
					arryCol = (ArrayList) arryRowkh.get(i);

					%>
					<tr >
						<td width="8%"><input type="hidden" name="hidseqno"
							value="<%=Helper.correctNull((String) arryCol.get(0))%>"> <input
							type="hidden" name="hidsno"
							value="<%=Helper.correctNull((String) arryCol.get(1))%>"> <input
							type="hidden" name="hidcroptype"
							value="<%=Helper.correctNull((String) arryCol.get(2))%>"> &nbsp;<b><font
							color="#000000"> <%if (!(temp.equals(Helper.correctNull((String) arryCol
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

					%></b></td>
						<td width="8%"><input type="text" name="txt_crop" size="25"
							maxlength="50"
							value="<%=Helper.correctNull((String) arryCol.get(13))%>"></td>
						<td width="9%">
						<table width="40%" border="0" cellspacing="0" cellpadding="1">
							<tr>
								<td><input type="text" name="txt_date" size="10" maxlength="10"
									value="<%=Helper.correctNull((String) arryCol.get(3))%>"
									onBlur="checkDate(this)" style="text-align:right;"></td>
								<td><%if (arrLength == 1) {%> <a href="#"
									onClick="callCalender('txt_date')"
									title="Click to view calender" border=0><img
									src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
									width="0" height="23" border="0"></a> <%} else {

						%> <a href="#"
									onClick="callCalender('txt_date[<%=i%>]')"
									title="Click to view calender" border=0><img
									src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
									width="0" height="23" border="0"></a> <%}

					%></td>
							</tr>
						</table>
						</td>
						<td width="6%"><input type="text" name="txt_area" size="7"
							maxlength="6"
							value="<%=Helper.correctNull((String) arryCol.get(4))%>"
							onKeyPress="" onBlur="" style="text-align:right;"></td>
						<td width="10%">
						<table width="40%" border="0" cellspacing="0" cellpadding="1">
							<tr>
								<td><lapschoice:CurrencyTag name="txt_finance" size="10"
									maxlength="8"
									value='<%=Helper.correctNull((String) arryCol.get(5))%>'
									onBlur="" /></td>
								<td><span onClick="showfinance(<%=i%>,<%=arryRowkh.size()%>)"
									style="cursor:hand"><img
									src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
									border="0"></span></td>
							</tr>
						</table>
						</td>
						<td width="6%"><lapschoice:CurrencyTag name="txt_eligibility"
							size="15" maxlength="12"
							value='<%=Helper.correctNull((String) arryCol.get(6))%>' /> <input
							type="hidden" name="txt_cult2" size="10" maxlength="8" value=""
							style="text-align:right;"></td>
						<td width="6%"><lapschoice:CurrencyTag name="txt_amount" size="10"
							maxlength="8"
							value='<%=Helper.correctNull((String) arryCol.get(7))%>' /> <input
							type="hidden" name="txt_marginamount"></td>
						<td width="6%"><lapschoice:CurrencyTag name="txt_amount1"
							size="8" maxlength="6"
							value='<%=Helper.correctNull((String) arryCol.get(8))%>' /></td>
						<td width="7%"><input type="text" name="txt_yield" size="10"
							maxlength="15"
							value="<%=Helper.correctNull((String) arryCol.get(9))%>"
							onKeyPress="allowNumber(this)" onBlur="" style="text-align:right">
						</td>
						<td width="8%"><lapschoice:CurrencyTag name="txt_produce"
							size="10" maxlength="8"
							value='<%=Helper.correctNull((String) arryCol.get(10))%>' /></td>
						<td width="6%"><lapschoice:CurrencyTag name="txt_surplus"
							size="12" maxlength="15"
							value='<%=Helper.correctNull((String) arryCol.get(11))%>' /></td>
						<td width="8%"><input type="text" name="txt_repay" size="8"
							maxlength="3"
							value="<%=Helper.correctNull((String) arryCol.get(12))%>"
							onKeyPress="allowNumber(this)" onBlur=""
							style="text-align:right;"></td>
						<td width="12%"><%if (arrLength == 1) {%> <textarea name="txt_remarks" cols="15" rows="2"
							onKeyPress="notAllowSingleQuote();textlimit(txt_remarks,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) arryCol.get(14))%></textarea>
						<%} else {

						%> <textarea name="txt_remarks" cols="15" rows="2"
							onKeyPress="notAllowSingleQuote();textlimit(txt_remarks[<%=i%>],3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) arryCol.get(14))%></textarea>
						<%}

				%></td>
					</tr>
					<%}
			}

			%>
					 <lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
 
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<lapschoice:agrihiddentag pageid='<%=PageId%>'/> <input type="hidden" name="hid_sno"
	value="<%=Helper.correctNull((String)hshValues.get("strid"))%>"> <input
	type="hidden" name="measurement"
	value="<%=Helper.correctNull((String)hshValues.get("land_measurement"))%>">

</form>
</body>
</html>
