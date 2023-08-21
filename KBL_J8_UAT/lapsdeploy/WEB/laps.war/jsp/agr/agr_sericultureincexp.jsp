<%@ page import="com.sai.fw.management.utils.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<%@include file="../share/directives.jsp"%>
<%
String[] strDesc = {"No.of Disease Free Layings","Yield of cocoons( Kgs)","Gross income @ "+ApplicationParams.getCurrency(),"Rearing cost","Maintenance of mulberry","","","","",""};
String schemetype = Helper.correctNull((String)request.getParameter("schemetype"));
if(schemetype. trim().equalsIgnoreCase(""))
{
	schemetype="0";
}
String appno=Helper.correctNull((String)hshValues.get("appno"));
String agr_schemeSno=Helper.correctNull((String)hshValues.get("agr_schemeSno"));
%>

<html>
<head>
<title>Loan Requirements</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<STYLE>
	DIV.cellContainer 
		{	
		width: 100%; height: 100%;
		overflow: auto;
		}
</STYLE>

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">

<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>

<SCRIPT LANGUAGE="JavaScript">
var appURL="<%=ApplicationParams.getAppUrl()%>";  
var appno="<%=appno%>";
var agr_schemeSno="<%=agr_schemeSno%>";
var schemetype="<%=schemetype%>";
function onloading()
{	var strUserMode="";
	
	strUserMode=document.forms[0].hidUsrMode.value;
	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value="<%=schemetype%>";
	if(strUserMode=='MAKER_MODE')
	{
		disabledFields(true);
		disableEditButtons(false, true, true, true, false, false);
	}
	else if(strUserMode=='CHECKER_MODE')
	{
		disabledFields(true);
		disableEditButtons(true, true, true, true, false, false);
	}
	else if(strUserMode=='VIEW_MODE')
	{
		disabledFields(true);
		disableEditButtons(true, true, true, true, false, false);
	}
	disabledFields(true);	
}

function show()
{
	var type = document.forms[0].sel_rear_system.value; 
	document.all.ifrm.src=appURL+"action/iframesericultureincome_exp.jsp?hidBeanGetMethod=getSericultureIncomeExp&hidBeanId=agreconomic&reartype="+type+"&appno="+appno+"&agr_schemeSno="+agr_schemeSno+"&schemetype="+schemetype; 
}

function doSave()
{
	if(document.forms[0].txt_acre.value  == "")
	{
		ShowAlert('121','Unit area');
		document.forms[0].txt_acre.focus();
		return;
	}
	if(document.forms[0].txt_space1.value  == "" && document.forms[0].txt_space2.value =="")
	{
		ShowAlert('121','Spacing');
		document.forms[0].txt_space1.focus();
		return;
	}
	if(document.forms[0].txt_population.value  == "" )
	{
		ShowAlert('121','Plant population');
		document.forms[0].txt_population.focus();
		return;	
	}
	if(document.forms[0].sel_rear_system.value  == "0" )
	{
		ShowAlert('111','Plant population');
		document.forms[0].sel_rear_system.focus();
		return;	
	}
	for(index=0;index<document.forms[0].txt_rate1.length;index++)
	{	
		if(index !=2)
			calculate_allcost(index);
	}
	perkgcal();
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="agreconomic";
	document.forms[0].hidBeanGetMethod.value="getSericultureIncomeExp";	
	document.forms[0].hidBeanMethod.value="updateSericultureIncomeExp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/agr_sericultureincexp.jsp";
	document.forms[0].submit();		
}
function doClose()
{
	if( ConfirmMsg(100))
	{
		parent.menuFrame.doWindowClose();
	}
}


function disableCommandButtons(val)
{	 
	if(val=="edit")
	{
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=false;
		document.forms[0].cmdsave.disabled=false;
		document.forms[0].cmdcancel.disabled=false;		 
		document.forms[0].cmdclose.disabled=false;	 
		disabledFields(false);
		
	}
	
}  

function disabledFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=val;
		}	  
		/*if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}*/	
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].disabled=!val;
		}	 
	}
	for(i=0;i<document.forms[0].txt_total1.length;i++)
	{
		document.forms[0].txt_total1[i].readOnly=true;
		document.forms[0].txt_total2[i].readOnly=true;
	}
	for(i=0;i<5;i++)
	{
		document.forms[0].txt_desc[i].readOnly=true;
		
	}
	document.forms[0].sel_rear_system.readOnly=false;
	document.forms[0].txt_rate1[2].readOnly=true;
	document.forms[0].txt_rate2[2].readOnly=true;	  
}

function doEdit()
{
	if(document.forms[0].sel_rear_system.value!="0")
	{
	   document.forms[0].hidAction.value = "insert";	
	   disableCommandButtons("edit");    
	   settabindex(); 
	 }
	 else
	 {
	 	alert("Please select Rearing System");
	 }
}

function doDelete()
{     
 	if(ConfirmMsg(101))
	{
        document.forms[0].hidAction.value = "delete";		
        document.forms[0].hidBeanId.value="agreconomic";
		document.forms[0].hidBeanGetMethod.value="getSericultureIncomeExp";	
	    document.forms[0].hidBeanMethod.value="updateSericultureIncomeExp";
		document.forms[0].action=appURL+"controllerservlet";
	    document.forms[0].hidSourceUrl.value="/action/agr_sericultureincexp.jsp";
		document.forms[0].submit();	
	}	
		
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="";
		document.forms[0].hidBeanId.value="agreconomic";
		document.forms[0].hidBeanGetMethod.value="getSericultureIncomeExp";
		document.forms[0].action=appURL+"action/agr_sericultureincexp.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}
function calculate_cost(obj)
{
	var unit = obj.value;
	var index = obj.rate1;
	var rate = document.forms[0].txt_acre.value;
	if(unit=="")
	{
		unit = 0.00;
		obj.value=unit;
	}
	
	var cost= eval(unit) * eval(rate);
	document.forms[0].txt_total1[index].value = cost;
}
function calculate_cost1(obj)
{
	var unit = obj.value;
	var index = obj.rate2;
	var rate = document.forms[0].txt_acre.value;
	if(unit=="")
	{
		unit = 0.00;
		obj.value=unit;
	}
	
	var cost= eval(unit) * eval(rate);
	document.forms[0].txt_total2[index].value = cost;
}
function perkg(obj)
{
	var rate = obj.value;
	var kg = document.forms[0].txt_kg.value;
	if(rate !="" && kg !="")
	{
		var cost= eval(rate) * eval(kg);
		document.forms[0].txt_rate1[2].value = cost;
		var acre = document.forms[0].txt_acre.value
		if(acre !="")
		{
			var total = eval(document.forms[0].txt_rate1[2].value) * eval(acre)
			document.forms[0].txt_total1[2].value = total;
		}
	}
	
}
function perkg1(obj)
{
	var rate = obj.value;
	var kg = document.forms[0].txt_kg.value;
	if(rate !="" && kg !="")
	{
		var cost= eval(rate) * eval(kg);
		document.forms[0].txt_rate2[2].value = cost;
		var acre = document.forms[0].txt_acre.value
		if(acre !="")
		{
			var total = eval(document.forms[0].txt_rate2[2].value) * eval(acre)
			document.forms[0].txt_total2[2].value = total;
		}
	}
	
}
function perkgcal()
{
	var kg = document.forms[0].txt_kg.value;
	var rate = document.forms[0].txt_rate1[1].value;
	if(rate !="" && kg !="")
	{
		var cost= eval(rate) * eval(kg);
		document.forms[0].txt_rate1[2].value = cost;
		var acre = document.forms[0].txt_acre.value
		if(acre !="")
		{
			var total = eval(document.forms[0].txt_rate1[2].value) * eval(acre)
			document.forms[0].txt_total1[2].value = total;
		}
	}
	
	rate = document.forms[0].txt_rate2[1].value;
	if(rate !="" && kg !="")
	{
		var cost= eval(rate) * eval(kg);
		document.forms[0].txt_rate2[2].value = cost;
		var acre = document.forms[0].txt_acre.value
		if(acre !="")
		{
			var total = eval(document.forms[0].txt_rate2[2].value) * eval(acre)
			document.forms[0].txt_total2[2].value = total;
		}
	}
	
}
function calculate_allcost(index)
{
	
	var unit = document.forms[0].txt_rate1[index].value;
	var rate = document.forms[0].txt_acre.value;
	if(unit=="")
	{
		unit = 0.00;
		document.forms[0].txt_rate1[index].value=unit;
	}
	
	var cost= eval(unit) * eval(rate);
	document.forms[0].txt_total1[index].value = cost;
	
	unit = document.forms[0].txt_rate2[index].value;
	rate = document.forms[0].txt_acre.value;
	if(unit=="")
	{
		unit = 0.00;
		document.forms[0].txt_rate2[index].value=unit;
	}
	
	var cost= eval(unit) * eval(rate);
	document.forms[0].txt_total2[index].value = cost;
}
function settabindex()
{	var tab = 5;
	for(var i=0;i<document.forms[0].txt_rate1.length;i++)
	{	
		if(i!=2)
		{
			tab = tab+1;
			if(document.forms[0].txt_desc[i].readOnly==false)
			{	
				document.forms[0].txt_desc[i].tabIndex = tab;
				tab = tab+1;
			}
			
			document.forms[0].txt_rate1[i].tabIndex = tab;
			tab = tab+1;
			document.forms[0].txt_rate2[i].tabIndex = tab;	
			
		}
		else
		{	tab=tab+1;
			document.forms[0].txt_kg.tabIndex = tab;
		}
	
	}

}
</script>


</head>
<body onload="onloading()">	
 <div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems"><script language="JavaScript1.2">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div>
</div>
<form name="appform" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="999" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<lapschoice:borrowertype /> 
<lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
      <td class="page_flow">Home -> Agriculture -> Income And Expenses</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="77" />
			<jsp:param name="schemetype" value="<%=schemetype%>" />
		</jsp:include></td>
	</tr>
</table>	
<table width="98%" border="0" cellspacing="0" cellpadding="2" class="outertable">
<tr>
<td>							
<table width="98%" border="0" cellspacing="0" cellpadding="2" class="outertable">
  <tr> 
    <td> 
    <table width="98%" border="0" align="center" cellspacing="1" cellpadding="2" class="outertable border1">
		<tr> 
	 		      <td width="11%">Unit area <b><span class="mantatory">*</span></b></td>
                  <td width="89%"> 
                    <input type="text" name="txt_acre" tabindex="1" size="15" maxlength="5"  onKeyPress="allowDecimals(this)" style="text-align: right" value="<%=FwHelper.correctNull((String)hshValues.get("unitarea"))%>" > acre
            </td>
			</tr>	 	
		<tr> 
	 		      <td width="11%">Spacing <b><span class="mantatory">*</span></b></td>
                  <td width="89%"> 
                    <input type="text" name="txt_space1" tabindex="2" size="10" maxlength="8"  onKeyPress="allowDecimals(this)" style="text-align: right" value="<%=FwHelper.correctNull((String)hshValues.get("spacing1"))%>" >
                    cm &nbsp;X &nbsp;<input type="text" name="txt_space2" tabindex="3" size="10" maxlength="8"  onKeyPress="allowDecimals(this)" style="text-align: right" value="<%=FwHelper.correctNull((String)hshValues.get("spacing2"))%>" > cm</td>
		</tr>
		<tr> 
	 		      <td width="11%" nowrap="nowrap">Plant population <b><span class="mantatory">*</span></b></td>
                  <td width="89%"> 
                    <input type="text" name="txt_population" tabindex="4" size="15" maxlength="8"  onKeyPress="allowInteger(this)" style="text-align: right" value="<%=FwHelper.correctNull((String)hshValues.get("population"))%>">
            </td>
			</tr>
	 	
	 		<tr> 
	 		      <td width="11%">Rearing System <b><span class="mantatory">*</span></b></td>
                  <td width="89%"> 
                    <select  name="sel_rear_system" onChange="show()" tabindex="5">
					<option value="0" selected>--Select--</option>
					<option value="leaf">Leaf rearing system</option>
					<option value="shoot">Shoot rearing system</option>
              		</select>
            		</td>
			</tr>
		</table>
		<br>
     <table width="98%" border="0" align="center" cellspacing="0" cellpadding="2" class="outertable border1">
	 	
          <tr class="dataHeader"> 
                  <td width="30%" align="center">Particulars</td>
                  <td width="35%"  align="center"colspan="2">I Year (<%=ApplicationParams.getCurrency()%>)</td>
                  <td width="35%"  align="center" colspan="2">II Year onwards (<%=ApplicationParams.getCurrency()%>)</td>
                      
          </tr>
		   <tr class="dataHeader"> 
                  <td width="30%">&nbsp;</td>
                  <td width="15%"  align="center">Rate / acre</td>
                  <td width="20%"  align="center">Total </td>
				  <td width="15%"  align="center">Rate / acre</td>
                  <td width="20%"  align="center">Total </td>
                      
          </tr>
          <%for(int i=0;i<10;i++) {%>
          	
          		<% if(!strDesc[i].equals("")&& i!=2){%>
          		<tr> 
          		 <td width="30%"><input type="text" name="txt_desc" size="30" maxlength="70"
					value="<%=strDesc[i]%>" style="color:'#000000';background-color:'#FFF2F1';border:0" readOnly></td>
                  <td width="15%"  align="center"><input type="text" name="txt_rate1"  size="15" maxlength="8"  onKeyPress="allowDecimals(this)" style="text-align: right" rate1="<%=i%>" onblur="roundtxt(this);calculate_cost(this)"></td>
                  <td width="20%"  align="center"><input type="text" name="txt_total1"  size="15" maxlength="8"  onKeyPress="allowDecimals(this)" style="text-align: right" ></td>
				  <td width="15%"  align="center">
                    <input type="text" name="txt_rate2"  size="15" maxlength="8"  onKeyPress="allowDecimals(this)" style="text-align: right" rate2="<%=i%>" onblur="roundtxt(this);calculate_cost1(this)">
                  </td>
                  <td width="20%"  align="center"><input type="text" name="txt_total2"  size="15" maxlength="8"  onKeyPress="allowDecimals(this)" style="text-align: right" ></td>
                  </tr>	
                  <%}else if(strDesc[i].equals("")&& i!=2){ %>
                  	 <tr> 
	                  <td width="30%"><input type="text" name="txt_desc" size="30" maxlength="70"
						value="" ></td>
	                  <td width="15%"  align="center"><input type="text" name="txt_rate1"  size="15" maxlength="8"  onKeyPress="allowDecimals(this)" style="text-align: right" rate1="<%=i%>" onblur="roundtxt(this);calculate_cost(this)"></td>
	                  <td width="20%"  align="center"><input type="text" name="txt_total1" size="15" maxlength="8"  onKeyPress="allowDecimals(this)" style="text-align: right" ></td>
					  <td width="15%"  align="center"><input type="text" name="txt_rate2"  size="15" maxlength="8"  onKeyPress="allowDecimals(this)" style="text-align: right" rate2="<%=i%>" onblur="roundtxt(this);calculate_cost1(this)"></td>
	                  <td width="20%"  align="center"><input type="text" name="txt_total2"  size="15" maxlength="8"  onKeyPress="allowDecimals(this)" style="text-align: right" ></td>
                     </tr>
         			 <%} %>
                  <% if(i==2){%>
                  <tr> 
                  <td width="30%"><input type="text" name="txt_desc" size="20"
					value="Gross income @ <%=ApplicationParams.getCurrency()%>" style="color:'#000000';background-color:'#FFF2F1';border:0" readOnly>
					<input type="text" name="txt_kg"  size="10" maxlength="8"  onKeyPress="allowDecimals(this)" style="text-align: right" onblur="perkgcal()">/kg</td>
                  <td width="15%"  align="center"><input type="text" name="txt_rate1"  size="15" maxlength="8"  onKeyPress="allowDecimals(this)" style="text-align: right" onblur="roundtxt(this)"></td>
                  <td width="20%"  align="center"><input type="text" name="txt_total1"  size="15" maxlength="8"  onKeyPress="allowDecimals(this)" style="text-align: right" ></td>
				  <td width="15%"  align="center"><input type="text" name="txt_rate2"  size="15" maxlength="8"  onKeyPress="allowDecimals(this)" style="text-align: right" onblur="roundtxt(this)"></td>
                  <td width="20%"  align="center"><input type="text" name="txt_total2"  size="15" maxlength="8"  onKeyPress="allowDecimals(this)" style="text-align: right" ></td>
                </tr>
                  <%}%>
              <%}%>
	     </table>
    </td>
  </tr>
 </table>	
 </td></tr></table>
 <br/>
 
  
       <%String strappno =FwHelper.correctNull((String) request.getParameter("appno"));

			if (strappno.equalsIgnoreCase("new")) {
				strappno = "";
			}
			
			%> 
			<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete'	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
   

<INPUT TYPE="hidden" name="type" value=""> 
<input type="hidden" name="hidAction">
<input type="hidden" name="hidBeanId">
<input type="hidden" name="hidBeanMethod">
<input type="hidden" name="hidBeanGetMethod">
<input type="hidden" name="hidSourceUrl">
<input type="hidden" name="hidapplicantid" value ="<%=session.getAttribute("comappid")%>">
<INPUT TYPE="hidden" name="hidAppType" value=""> 
<INPUT TYPE="hidden" name="hidvalue" value=""> 
<input type="hidden" name="hidUsrMode" value="<%=session.getAttribute("strUserMode")%>">
<input type="hidden" name="hidAppno" value="<%=session.getAttribute("strappno")%>">
<iframe height="0" width="0" id="ifrm" frameborder=0 style="border:0"></iframe>

</form>
</body>
</html>