<%@ page import="com.sai.fw.management.utils.*"%>
<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<%@include file="../share/directives.jsp"%>
<%
ArrayList arryIncome = (ArrayList)hshValues.get("arryIncomeType");	
ArrayList arryIncomeDescription = (ArrayList)hshValues.get("arryIncomeDescription");	
ArrayList arryIncomeAmount = (ArrayList)hshValues.get("arryIncomeAmount");	

int arryIncomeDescriptionSize = 0;
if(arryIncomeDescription!=null && arryIncomeDescription.size()>0)
	arryIncomeDescriptionSize = arryIncomeDescription.size();
String schemetype = Helper.correctNull((String)request.getParameter("schemetype"));
if(schemetype. trim().equalsIgnoreCase(""))
{
	schemetype="0";
}
%>


<html>
<head>
<title>Gobar Gas tech/economic data</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var txt_acreage = "<%=FwHelper.correctNull((String)hshValues.get("txt_acreage"))%>" 
var txt_taluk= "<%=FwHelper.correctNull((String)hshValues.get("txt_taluk"))%>" 
var txt_ownership = "<%=FwHelper.correctNull((String)hshValues.get("txt_ownership"))%>" 
var txt_distance = "<%=FwHelper.correctNull((String)hshValues.get("txt_distance"))%>"  
var txt_sizeplant = "<%=FwHelper.correctNull((String)hshValues.get("txt_sizeplant"))%>" 
var sel_design = "<%=FwHelper.correctNull((String)hshValues.get("sel_design"))%>" 
var txt_specify = "<%=FwHelper.correctNull((String)hshValues.get("txt_specify"))%>"  
var txt_investment= "<%=FwHelper.correctNull((String)hshValues.get("txt_investment"))%>"  
var txt_animalsnorms = "<%=FwHelper.correctNull((String)hshValues.get("txt_animalsnorms"))%>"   
var txt_persons = "<%=FwHelper.correctNull((String)hshValues.get("txt_persons"))%>"  
var txt_purpose1 = "<%=FwHelper.correctNull((String)hshValues.get("txt_purpose1"))%>"   
var txt_hrs1 = "<%=FwHelper.correctNull((String)hshValues.get("txt_hrs1"))%>"   
var txt_purpose2= "<%=FwHelper.correctNull((String)hshValues.get("txt_purpose2"))%>"
var txt_hrs2 = "<%=FwHelper.correctNull((String)hshValues.get("txt_hrs2"))%>"   
var txt_purpose3= "<%=FwHelper.correctNull((String)hshValues.get("txt_purpose3"))%>"
var txt_hrs3 = "<%=FwHelper.correctNull((String)hshValues.get("txt_hrs3"))%>"  
var txt_savings= "<%=FwHelper.correctNull((String)hshValues.get("txt_savings"))%>";
var txt_netannualincome = "<%=FwHelper.correctNull((String)hshValues.get("txt_netannualincome"))%>"  


</script>

<script>

var varincometype=new Array();
var varincomeamount=new Array();
var varincomedetail=new Array();
var varIncomeDescriptionSize = "<%=arryIncomeDescriptionSize%>";

<%
for(int i=1;i<6;i++)
{
	if(arryIncomeAmount!=null && arryIncomeAmount.size()>=i)
		{
%>  
		varincomeamount["<%=i-1%>"]="<%=FwHelper.formatDoubleValue(FwHelper.parseDouble(FwHelper.correctDouble((String)arryIncomeAmount.get(i-1))))%>";
<%
		}
	else
	{%>
	varincomeamount["<%=i-1%>"]="0.00";
	<%
}}
%>

<%
for(int i=3;i<6;i++)
{
	if(arryIncomeDescription!=null && arryIncomeDescription.size()>=i)
		{
%>  
		varincomedetail["<%=i-1%>"]="<%=FwHelper.correctNull((String)arryIncomeDescription.get(i-1))%>";
<%
		}else{%>
		varincomedetail["<%=i-1%>"]="";
		
		<%
}}
%>

		

function callfilldata()
{
	for(var i=0;i<5;i++)
	{
		if((i==0) || (i==1))
		{
			document.forms[0].txt_incomedescription[0].value='Income from allied activities';
			document.forms[0].txt_incomedescription[1].value='Income from Employment';
		}
		else
		{
			document.forms[0].txt_incomedescription[i].value=varincomedetail[i];
		}
		
		document.forms[0].txt_incomeamount[i].value=varincomeamount[i];
		
	}
	if(varIncomeDescriptionSize==0)
	{
	
		for(var i=0;i<5;i++)
		{

			if((i==0) || (i==1))
			{
				document.forms[0].txt_incomedescription[0].value='Income from allied activities';
				document.forms[0].txt_incomedescription[1].value='Income from Employment';
			}
			else
			{
				document.forms[0].txt_incomedescription[i].value=varincomedetail[i];
			}
			
			document.forms[0].txt_incomeamount[i].value="0.00";
			
		}	
	
	}
	
}

function callCalender(name)
{
	if(document.forms[0].hideditflag.value=="Y")
	{
		showCal(appUrl,name);
	}
}
function callLink(page,bean,method)
{	
	 document.forms[0].hidAction.value="";
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
}



function onloading()
{	
	disableFields(true);	
	if(sel_design!="")
	{
		document.forms[0].sel_design.value=sel_design;
	}
	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value="<%=schemetype%>";
	var strUserMode="";
	strUserMode=document.forms[0].hidUsrMode.value;
	if(strUserMode=='MAKER_MODE')
	{
		disabledFields(true);
		disableEditButtons(false, true, true, false, false, false);
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
	document.forms[0].cmddelete.disabled=true;
	callfilldata();
	calculatetotalincome();
}
function enableButtons(bool1, bool2, bool3, bool4, bool5, bool6)
{
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled = bool6;
}
function doSave()
{   
    enableButtons(true, true, false, false, true, true);
	document.forms[0].hidBeanId.value="agreconomic";		
	document.forms[0].hidSourceUrl.value="/action/agr_gobartechdata.jsp";
	document.forms[0].hidBeanMethod.value="updategobartechdata";
	document.forms[0].hidBeanGetMethod.value="getgobartechdata";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}
function doEdit()
{
 	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	enableButtons(true, true, false, false, false, true);		
	for(var i=0;i<2;i++)
	{
			document.forms[0].txt_incomedescription[i].readOnly = true;
	}
	document.forms[0].txt_netannualincome.readOnly = true;
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agreconomic";
		document.forms[0].hidBeanGetMethod.value="getgobartechdata";
		document.forms[0].action=appUrl+"action/agr_gobartechdata.jsp";
		document.forms[0].submit(); 		
	}	
}



function doClose()
{
	if( ConfirmMsg(100))
	{
		parent.menuFrame.doWindowClose();
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
	 	if(document.forms[0].elements[i].type=='checkbox')
	 	{
			document.forms[0].elements[i].disabled=one;
	 	}
		  
	}
}


function doDelete()
{

var len = document.forms[0].sel_design.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_design.options[i].selected==true)
		 {
			 document.forms[0].sel_designtext.value = document.forms[0].sel_design.options[i].text; 
			break;
		 }
	}
	
	if( ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updategobartechdata";
		document.forms[0].hidBeanGetMethod.value="getgobartechdata";
		document.forms[0].hidBeanId.value="agreconomic";
		document.forms[0].hidSourceUrl.value="action/agr_gobartechdata.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}	
}




function calculatetotalincome()
{
	var resultantsum = 0.00;
	for(var i=0;i<document.forms[0].txt_incomeamount.length;i++)  
	{
		var incomeamt = document.forms[0].txt_incomeamount[i].value;
	    if(incomeamt =="")
			{
				 incomeamt =0.00;
			}
		resultantsum = eval(resultantsum)+eval(incomeamt);
	}
	document.forms[0].txt_netannualincome.value= eval(resultantsum);
	roundtxt(document.forms[0].txt_netannualincome);
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
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>
<body onload="onloading();">
  <div id="ie5menu" class="skin0" onMouseover="highlightie5()" onMouseout="lowlightie5()" onClick="jumptoie5();">
<script language="JavaScript1.2">
if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div>
	<form name="frmpri" method="post" class="normal">
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
      <td class="page_flow">Home -> Agriculture -> Gobar Gas Plant Details</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="53" />
			<jsp:param name="schemetype" value="<%=schemetype%>" />
		</jsp:include></td>
	</tr>
</table>
	<table width="98%" border="0" align="center" cellpadding="3" cellspacing="0" class="outertable border1">
   
				    <tr> 
				      <td colspan="6" align="center" class="dataHeader">Location 
				        of Gobar Gas Plant </td>
				    </tr>
				    <tr> 
				      <td>Survey No.</td>
				      <td> <input type="text" name="txt_syno" OnkeyPress="notAllowSplChar()" value="<%=FwHelper.correctNull((String)hshValues.get("txt_syno"))%>"  size="15%" maxlength="20"></td>
				      <td >Extend Land</td>
				      <td ><input type="text" name="txt_acreage" size="15%" value="<%=FwHelper.correctNull((String)hshValues.get("txt_acreage"))%>"  onKeyPress="allowNumber(this)" maxlength="6">
				        (Acres)/ 
				        <% 	String measurementtype =FwHelper.correctNull((String)hshValues.get("land_measurement"));
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
				        <font color="#000000"><%=measurementval%></font> 
				      </td>
				      <td>Ownership</td>
				      <td><input type="text" name="txt_ownership"  value="<%=FwHelper.correctNull((String)hshValues.get("txt_ownership"))%>"  size="15%" onKeyPress="" maxlength="18">
				        </td>
				    </tr>
				    <tr> 
				      <td> Village</td>
				      <td> <input type="text" name="txt_village" OnkeyPress="allowAlphabets()" value="<%=FwHelper.correctNull((String)hshValues.get("txt_village"))%>"  size="15%" maxlength="29"></td>
				      <td >Taluk </td>
				      <td>
				        <input type="text" name="txt_taluk" OnkeyPress="allowAlphabets()" value="<%=FwHelper.correctNull((String)hshValues.get("txt_taluk"))%>"  size="15%"  maxlength="29">
				        </td>
				      <td colspan="2">&nbsp; </td>
				    </tr>
				   
				  </table>

	
  <table width="98%" border="0" align="center" cellspacing="0" cellpadding="3" class="outertable border1" >
    <tr> 
      <td width="24%"> Distance from the Branch 
        to Plant</td>
      <td width="18%"> <input type="text" name="txt_distance"  value="<%=FwHelper.correctNull((String)hshValues.get("txt_distance"))%>"  size="15%" onKeyPress="allowNumber(this)" maxlength="3">
        (KM)</td>
      <td width="28%"  nowrap  >Size of the 
        Plant</td>
      <td width="30%"  nowrap   > <input type="text" name="txt_sizeplant"  value="<%=FwHelper.correctNull((String)hshValues.get("txt_sizeplant"))%>"  size="15%" onKeyPress="allowInteger()" maxlength="8">
        (cu ft)</td>
    </tr>
    
    <tr> 
      <td width="24%"> Distance of the Plant from the Kitchen
        to Plant</td>
      <td width="18%"> <input type="text" name="txt_distancefrom_kitchen"  value="<%=FwHelper.correctNull((String)hshValues.get("txt_distancefrom_kitchen"))%>"  size="15%" onKeyPress="allowNumber(this)" maxlength="3">
        (KM)</td>    
      <td> Design of the Plant</td>
      <td><select name="sel_design" onChange="">
          <option value="0" selected>-- Select --</option>
          <option value="1">KVK/KVIB</option>
          <option value="2">Agriculture Dept/University</option>
          <option value="3">Others</option>
        </select></td>    
    </tr>
    
    <tr> 
      <td rowspan="2"> Cost of Investment&nbsp;&nbsp;(<%=ApplicationParams.getCurrency()%>)</td>
      <td rowspan="2"> 
        <lapschoice:CurrencyTag name="txt_investment"  value='<%=FwHelper.correctNull((String)hshValues.get("txt_investment"))%>'  size="15" maxlength="6"/>
        </td>
      </tr>
      
      </table>
 
<br>

    		<table width="98%" border="0" align="center" cellspacing="1" cellpadding="3" class="dataHeader">
    			<tr class="dataHeader">
    			      <td colspan="2" align="center">No. of Cattle Available</td>
				      <td align="center">Adults</td>
     					<td align="center">Calf</td>
     				</tr>
     				<tr>
    			      <td align="center" colspan="2">Buffaloes</td>
				      <td align="center"> 
				        <input type="text" name="txt_buffalo_adult"  value="<%=FwHelper.correctNull((String)hshValues.get("txt_buffalo_adult"))%>"  size="15%" onKeyPress="allowNumber(this)" maxlength="4" onBlur="">
				        </td>
     					<td align="center"><input type="text" name="txt_buffalo_calf"  value="<%=FwHelper.correctNull((String)hshValues.get("txt_buffalo_calf"))%>"  size="15%" onKeyPress="allowNumber(this)" maxlength="4" onBlur="">&nbsp;</td>
     				</tr>
     				<tr>
    			      <td align="center" colspan="2">Cows</td>
				      <td align="center"> 
				        <input type="text" name="txt_cows_adult"  value="<%=FwHelper.correctNull((String)hshValues.get("txt_cows_adult"))%>"  size="15%" onKeyPress="allowNumber(this)" maxlength="4" onBlur="">
				        </td>
     					<td align="center"><input type="text" name="txt_cows_calf"  value="<%=FwHelper.correctNull((String)hshValues.get("txt_cows_calf"))%>"  size="15%" onKeyPress="allowNumber(this)" maxlength="4" onBlur="">&nbsp;</td>
     				</tr>
     				<tr>
    			      <td align="center" colspan="2">Draught</td>
				      <td align="center"> 
				        <input type="text" name="txt_draught_adult"  value="<%=FwHelper.correctNull((String)hshValues.get("txt_draught_adult"))%>"  size="15%" onKeyPress="allowNumber(this)" maxlength="4" onBlur="">
				        </td>
     					<td align="center"><input type="text" name="txt_draught_calf"  value="<%=FwHelper.correctNull((String)hshValues.get("txt_draught_calf"))%>"  size="15%" onKeyPress="allowNumber(this)" maxlength="4" onBlur="">&nbsp;</td>
     				</tr>
     		</table>
     	
   <br>
 
    		<table width="98%" border="0" align="center" cellspacing="1" cellpadding="3" class="outertable border1">
    <tr> 
      <td>No. of Animals as per Norms</td>
      <td> 
        <input type="text" name="txt_animalsnorms"  value="<%=FwHelper.correctNull((String)hshValues.get("txt_animalsnorms"))%>"  size="15%" onKeyPress="allowNumber(this)" maxlength="6" onBlur="">
        </td>
     <td>No. of family members including regular labourers</td>
     <td><input type="text" name="txt_membersinvolved"  value="<%=FwHelper.correctNull((String)hshValues.get("txt_membersinvolved"))%>"  size="15%" onKeyPress="allowNumber(this)" maxlength="4" onBlur=""></td>
    </tr>
  
    <tr> 
      <td rowspan="3">No. of persons benefited by the construction of proposed plant</td>
      <td rowspan="3"> 
        <input type="text" name="txt_persons"  value="<%=FwHelper.correctNull((String)hshValues.get("txt_persons"))%>"  size="15%" onKeyPress="allowNumber(this)" maxlength="10">
        </td>
      <td rowspan="3" nowrap="nowrap">Purpose and No. of 
        Hrs. gas is used for</td>
      <td nowrap="nowrap"><input type="text" name="txt_purpose1"  value="<%=FwHelper.correctNull((String)hshValues.get("txt_purpose1"))%>"  size="25%" onKeyPress="notAllowSingleAndDoubleQuote()" maxlength="50"> 
         
        <input type="text" name="txt_hrs1"  value="<%=FwHelper.correctNull((String)hshValues.get("txt_hrs1"))%>"  size="5%" onKeyPress="allowNumber(this)" maxlength="10">
        Hrs. </td>
    </tr>
    <tr> 
      <td colspan="3" nowrap="nowrap"><input type="text" name="txt_purpose2"  value="<%=FwHelper.correctNull((String)hshValues.get("txt_purpose2"))%>"  size="25%" onKeyPress="notAllowSingleAndDoubleQuote()" maxlength="50"> 
         
        <input type="text" name="txt_hrs2"  value="<%=FwHelper.correctNull((String)hshValues.get("txt_hrs2"))%>"  size="5%" onKeyPress="allowNumber(this)" maxlength="10">
        Hrs. </td>
        
    </tr>
    <tr> 
      <td colspan="3"><input type="text" name="txt_purpose3"  value="<%=FwHelper.correctNull((String)hshValues.get("txt_purpose3"))%>"  size="25%" onKeyPress="notAllowSingleAndDoubleQuote()" maxlength="50"> 
         
        <input type="text" name="txt_hrs3"  value="<%=FwHelper.correctNull((String)hshValues.get("txt_hrs3"))%>"  size="5%" onKeyPress="allowNumber(this)" maxlength="10">
        Hrs. </td>
    </tr>
    <tr> 
      <td nowrap="nowrap">Savings on fuel due to implementation 
        of G.G Plant</td>
      <td colspan="2"> 
        <lapschoice:CurrencyTag name="txt_savings"  value='<%=FwHelper.correctNull((String)hshValues.get("txt_savings"))%>'  size="15"  maxlength="10"/>
        <%=ApplicationParams.getCurrency()%>/Month</td>
    </tr>
    </table>
   
    <br>
    
    		<table width="98%" border="0" align="center" cellspacing="1" cellpadding="3" class="outertable border1">
    <tr class="dataheader" ><td colspan="4" align="center"> Net Annual Income</td></tr>
    <%for(int i=0;i<=4;i++){ %>
    <tr>
     <td width="20%" align="center" colspan="3"><input type="text" name="txt_incomedescription" onKeyPress="allowAlphabets()" value="" size="30" maxlength="100"></td>	
     <td width="20%" align="center"><input type="text" name="txt_incomeamount" onKeyPress="allowDecimals(this)"
         onBlur="roundtxt(this);calculatetotalincome();" style="text-align: right" value="" size="20" maxlength="15"></td>	
    </tr>
    <%}%>
    <tr>
    	 <td align="center" colspan="3">Net Annual Income &nbsp; &nbsp; (<%=ApplicationParams.getCurrency()%>)</td>
    	 <td align="center"><input type="text" size="20" name="txt_netannualincome" 
    	 onKeyPress="allowDecimals(this)" 
    	 value='<%=FwHelper.correctNull((String)hshValues.get("txt_netannualincome"))%>'
    	 style="text-align: right"   readOnly/>
        </td>
    </tr>
    </table>
   
 

	<%String strappno =FwHelper.correctNull((String)hshValues.get("appno"));%> 
	<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete'	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
    <input type="hidden" name="hidBeanMethod" value="">
	<input type="hidden" name="hidBeanGetMethod" value="">
	<input type="hidden" name="hidBeanId" value="">
	<input type="hidden" name="hidSourceUrl" value="">
	<input type="hidden" name="hidAction" value="">
	<input type="hidden" name="hidUsrMode" value="<%=session.getAttribute("strUserMode")%>">	
	<input type ="hidden" name="sel_designtext" value="">
	
	

</form>

</body>
</html>
