<%@include file = "../share/directives.jsp"%>

<%
String PageType = Helper.correctNull((String) hshValues.get("PageType"));
		
ArrayList vecrow = new ArrayList();
ArrayList veccol = new ArrayList();
int vecsize = 0;
String tractortype = "";
String tractorreason = "";
String machinerytype = "";
String machineryreason = "";
if (hshValues != null) {
	vecrow = (ArrayList) hshValues.get("vecData");
	vecsize = vecrow.size();
	}
%>
<html>
<head>
<title>Live Stock Details</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var seltract = "<%=Helper.correctNull((String)hshValues.get("seltractor"))%>";
var selmachin = "<%=Helper.correctNull((String)hshValues.get("selmachinery"))%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function callhelp()
{
	var varQryString = appURL+"/jsp/perhlp/hlp_educourse.jsp";
	var title = "ApplicantDemographics";
	var prop = "scrollbars=no,width=600,height=450";	
	prop = prop + ",left=200,top=150";
	window.open(varQryString,title,prop);
}

function enableButtons(bool1, bool2, bool3, bool4, bool5)
{	
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled = bool5;
}

function doClose()
{
	if( ConfirmMsg(100))
	{
		/* document.forms[0].target="_parent";
		document.forms[0].action=appURL+"action/persearch.jsp";				
		document.forms[0].submit(); */
		document.forms[0].target="_parent";
		document.forms[0].action=appURL+"action/"+"retailpge.jsp";				
		document.forms[0].submit();
		
	}
}

function doSave()
{
	
   if (document.forms[0].txt_particulars[0].value == "") {
	   alert("Enter Particulars");
	   document.forms[0].txt_particulars[0].focus();
	   return;
    }   
	
  for(i=0;i<7;i++)
  {
   if(document.forms[0].txt_particulars[i].value!="")
   {
   		if(document.forms[0].txt_hp[i].value==""){
   		alert("Enter Quotation no & Date");
   		document.forms[0].txt_hp[i].focus();
   		return;
   	 }
   }
  }
  
  document.forms[0].cmdsave.disabled=true;
    document.forms[0].hidRecordflag.value=varRecordFlag;
	document.forms[0].hidBeanId.value="agreconomic";		
	document.forms[0].hidSourceUrl.value="/action/agr_farmMechParticulars.jsp";
	document.forms[0].hidBeanMethod.value="updatefarmMechData";
	document.forms[0].hidBeanGetMethod.value="getfarmMechData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();	
}

function doEdit()
{
 	disableFields(false);
	document.forms[0].hidAction.value ="update"; 
	document.forms[0].hideditflag.value="Y";
	enableButtons(true, false, false, false, true);
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="";
		document.forms[0].hidBeanId.value="agreconomic";
		document.forms[0].hidBeanGetMethod.value="getfarmMechData";
		document.forms[0].action=appURL+"action/agr_farmMechParticulars.jsp";
		document.forms[0].submit(); 	
	}
}

function doDelete()
{
	if( ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appURL+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updatefarmMechData";
		document.forms[0].hidBeanGetMethod.value="getfarmMechData";
		document.forms[0].hidBeanId.value="agreconomic";
		document.forms[0].hidSourceUrl.value="/action/agr_farmMechParticulars.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	} 
}
	
function disableFields(one)
{	
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
		 if(document.forms[0].elements[i].name=='txt_loanamt')continue;
		  if( document.forms[0].elements[i].name=='txt_totloanamt')continue;
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

function onloading()
{
	document.all.r1.style.visibility="hidden";
	document.all.r2.style.visibility="hidden";
	document.all.r3.style.visibility="hidden";
	document.all.r4.style.visibility="hidden";	
	if(seltract!="")
	{	
		document.forms[0].sel_tractor.value=seltract;
	}
	if(selmachin!="")
	{
		document.forms[0].sel_machinery.value=selmachin;
	}
	if(seltract=="2")
	{
		document.all.r1.style.visibility="visible";
		document.all.r2.style.visibility="visible";
	}
	else if(seltract=="1")
	{
		document.all.r1.style.visibility="hidden";
		document.all.r2.style.visibility="hidden";
	}
	if(selmachin=="2")
	{
		document.all.r3.style.visibility="visible";
		document.all.r4.style.visibility="visible";
	}
	else if(selmachin=="1")
	{
		document.all.r3.style.visibility="hidden";
		document.all.r4.style.visibility="hidden";
	}
	disableFields(true);
}

function tractormeth()
{
	if(document.forms[0].sel_tractor.value=="2")
	{
		document.all.r1.style.visibility="visible";
		document.all.r2.style.visibility="visible";
	}
	else
	{
		document.all.r1.style.visibility="hidden";
		document.all.r2.style.visibility="hidden";
		document.forms[0].txt_tractorreason.value="";
	}
	
	
}

function machinerymeth()
{
	if(document.forms[0].sel_machinery.value=="2")
	{
		document.all.r3.style.visibility="visible";
		document.all.r4.style.visibility="visible";
	}
	else
	{
		document.all.r3.style.visibility="hidden";
		document.all.r4.style.visibility="hidden";
		document.forms[0].txt_machineryreason.value="";
	}
}


function totloanamtmeth()
{
	var totloanamt=0;
	document.forms[0].txt_totloanamt.value="";
	for(var i=0; i<7; i++)
	{
		var temp = document.forms[0].txt_loanamt[i].value;
		
		if(temp == "")
		{
			temp=0;
		}
		totloanamt = eval(totloanamt) + eval(temp);
	}
	document.forms[0].txt_totloanamt.value=totloanamt;
	
}

function doCal()
	{
   var unit=0.00,cost=0.00;
   for(i=0;i<7;i++)
	{
 	
   var unit=document.forms[0].txt_estimcost[i].value;
   var cost=document.forms[0].txt_margin[i].value;
   var total=0;
   if(unit==""){
      unit="1";
     
   }
   if(cost==""){
      cost="0";
   }
        
   total=eval(cost)*eval(unit);
   document.forms[0].txt_loanamt[i].value=total;
   roundtxt(document.forms[0].txt_loanamt[i]); 
   roundtxt(document.forms[0].txt_margin[i]); 
   
    
}
}

</script>

</head>
<body class="outertable" onload="onloading()">
<form name="frmpri" method="post" class="normal"> <table width="100%" border="0" cellpadding="5" cellspacing="0" class="outertable border1"> 
<tr> <td> <table width="100%" border="0" cellspacing="1" cellpadding="2"
			class="outertable"> <tr> <td> <table width="100%" border="0" cellspacing="0" cellpadding="3"
					class="outertable"> <tr> <td> <table width="100%" border="0" cellspacing="1" cellpadding="3"
							class="outertable"> <tr class="dataheader"> 
<td colspan="6" align="center" ><b>Particulars of Investment</b></td></tr> <tr class="dataheader"> 
<td width="14%" align="center" > Particulars <span class="mantatory">*</span></td><td width="12%" align="center" >Name 
of the supplier</td><td width="12%" align="center" >Quotation no &amp; Date<b><font size="1" face="MS Sans Serif"
													color="#FF0000">*</font></b></td><td width="12%" align="center">No. 
of Units </td><td width="12%" align="center">Rate per unit(Rs.)</td><td width="12%" align="center" >Total 
Cost(Rs.)</td></tr> <%if(vecsize>0){
							for (int i = 0; i < vecsize; i++) {
								veccol = (ArrayList) vecrow.get(i);
								tractortype = Helper.correctNull((String)veccol.get(10));
								tractorreason = Helper.correctNull((String)veccol.get(11));
								machinerytype = Helper.correctNull((String)veccol.get(12));
								machineryreason = Helper.correctNull((String)veccol.get(13));
							%> <tr > <td align="center"><input type="text" name="txt_particulars"
									value="<%=Helper.correctNull((String)veccol.get(1))%>" size="53" maxlength="99" style="text-align:left"></td><td align="center"> 
<input type="text"
									name="txt_make" value="<%=Helper.correctNull((String)veccol.get(2))%>" size="20" maxlength="49"
									onKeyPress="" style="text-align:left"> 
</td><td align="center"><input type="text" name="txt_hp" value="<%=Helper.correctNull((String)veccol.get(3))%>"
									size="15" maxlength="30" onKeyPress="notAllowSingleQuote()"
									style="text-align:left"></td><td align="center"><input type="text" name="txt_estimcost"
									value="<%=Helper.correctNull((String)veccol.get(4))%>" size="8" maxlength="5" onKeyPress="allowNumber(this)" onBlur="doCal();;totloanamtmeth();"
									style="text-align:right"></td><td align="center"><input type="text" name="txt_margin" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)veccol.get(5))))%>"
									size="12" maxlength="8" onKeyPress="allowDecimals(this)" onBlur="doCal();roundtxt(this);totloanamtmeth()"
									style="text-align:right"></td><td align="center"><input type="text" name="txt_loanamt" 
									value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)veccol.get(6))))%>" size="12" maxlength="9"
									onKeyPress="allowDecimals(this)" onBlur="doCal();totloanamtmeth();roundtxt(this)" style="text-align:right" readOnly="true"></td></tr> 
<%}}else{
							for (int i = 0; i < 7; i++) {%> 
<tr> <td align="center"><input type="text" name="txt_particulars"
									value="" size="53" maxlength="99" style="text-align:left"></td><td align="center"> 
<input type="text"
									name="txt_make" value="" size="20" maxlength="49"
									onKeyPress="allowDecimals()" style="text-align:right"> 
</td><td align="center"><input type="text" name="txt_hp" value=""
									size="15" maxlength="30" onKeyPress="notAllowSingleQuote()"
									style="text-align:right"></td><td align="center"><input type="text" name="txt_estimcost"
									value="" size="8" maxlength="5" onKeyPress="allowNumber(this)"onBlur="doCal();totloanamtmeth();"
									style="text-align:right"></td><td align="center"><input type="text" name="txt_margin" value=""
									size="12" maxlength="8" onKeyPress="allowDecimals(this)" onBlur="doCal();;totloanamtmeth();roundtxt(this)"
									style="text-align:right"></td><td align="center"><input type="text" name="txt_loanamt" onBlur="doCal();totloanamtmeth();roundtxt(this)"
									value="" size="12" maxlength="9"
									onKeyPress="allowDecimals(this)" style="text-align:right" readOnly></td></tr> 
<%}} %> <tr > <td colspan="3" align="right">&nbsp;</td><td align="center">&nbsp;</td><td align="center"><b>Total 
Cost&nbsp;</b></td><td align="center"><input type="text" readOnly name="txt_totloanamt"
									value="<%if(Helper.correctNull((String)hshValues.get("totloanamt")).equalsIgnoreCase("0.00"))
									{
										out.println("");
										
									}
									else
									{
											out.println(Helper.correctNull((String)hshValues.get("totloanamt")));
									}
									%>" size="12" maxlength="9"
									onKeyPress="allowDecimals(this)" style="text-align:right"></td></tr> 
<tr > <td colspan="3" align="left">Whether the machinery proposed to be purchased 
as per BIS code of CF MT T I &nbsp;(Commercial Test Report)</td><td align="center">&nbsp; 
<select name="sel_tractor" onChange="tractormeth()"> <option value="1" selected <%if(tractortype.equalsIgnoreCase("1")){ out.println("Selected");}%>>Yes</option> 
<option value="2" <%if(tractortype.equalsIgnoreCase("2")){ out.println("Selected");}%>>No</option> 
</select></td><td  align="center" id="r1">&nbsp;Give Reason </td><td align="center" id="r2">&nbsp;<textarea name="txt_tractorreason" rows="2"
									cols="20" onKeyPress="textlimit(this,399)" onKeyUp="textlimit(this,399)"><%=tractorreason%> 
</textarea></td></tr> <tr > <td colspan="3" align="left">Whether the other farm 
machinery / implements meets BIS standard</td><td align="center">&nbsp;<select name="sel_machinery" onChange="machinerymeth()"> 
<option value="1" selected <%if(machinerytype.equalsIgnoreCase("1")){ out.println("Selected");}%>>Yes</option> 
<option value="2" <%if(machinerytype.equalsIgnoreCase("2")){ out.println("Selected");}%>>No</option> 
</select></td><td align="center" id="r3">&nbsp;Give Reason </td><td align="center" id="r4">&nbsp;<textarea name="txt_machineryreason" rows="2"
									cols="20" onKeyPress="textlimit(this,399)" onKeyUp="textlimit(this,399)"><%=machineryreason%></textarea></td></tr> 
</table></td></tr> <lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
</table></td></tr> </table></td></tr> </table><lapschoice:agrihiddentag pageid="<%=PageId%>"/> 
<input type="hidden" name="hidRecordflag" > </form>
</body>
</html>
