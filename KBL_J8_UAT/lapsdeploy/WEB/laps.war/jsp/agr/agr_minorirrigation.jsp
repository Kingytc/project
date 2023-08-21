<%@include file="../share/directives.jsp"%>
<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>

<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />

<%if (objValues instanceof java.util.HashMap) {
	hshValues = (java.util.HashMap) objValues;
}

String strapptype = "";
String apptype = "";
String app_status = Helper.correctNull((String) hshValues.get("app_status"));
String prd_type = Helper.correctNull((String)session.getAttribute("strProductType"));
String schemetype = Helper.correctNull((String)request.getParameter("schemetype"));
if(schemetype. trim().equalsIgnoreCase(""))
{
	schemetype="0";
}
int pageid = Integer.parseInt(request.getParameter("pageid"));

%><%=prd_type %>
<html>
<head>
<title>Minor Irrigation</title>

<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var type="<%=Helper.correctNull((String)hshValues.get("am_type"))%>";
var selsurveydept = "<%=Helper.correctNull((String)hshValues.get("am_feasibility"))%>";
var selclearence = "<%=Helper.correctNull((String)hshValues.get("am_clearanceriverdpt"))%>";
var selelectricity = "<%=Helper.correctNull((String)hshValues.get("am_electricity"))%>";
var selcropping = "<%=Helper.correctNull((String)hshValues.get("am_croppingpattern"))%>";
var selirrigation = "<%=Helper.correctNull((String)hshValues.get("am_watersuitableirrig"))%>";
var agr_electricitydoc = "<%=Helper.correctNull((String)hshValues.get("am_elecdocs"))%>";
var selwaterpropose = "<%=Helper.correctNull((String)hshValues.get("am_waterproposed"))%>";
var selnetamt = "<%=Helper.correctNull((String)hshValues.get("am_netamt"))%>";
var schemetype="<%=schemetype%>"
var sourceofwater="<%=Helper.correctNull((String)hshValues.get("am_watersource"))%>";
</script>

<script>
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
function callLoad()
{	

	if(selsurveydept!="")
	{
		document.forms[0].sel_surveydept.value=selsurveydept;
	}
	else
	{
		document.forms[0].sel_surveydept.value="0";
	}
	if(selclearence!="")
	{
		document.forms[0].sel_clearence.value=selclearence;
	}
	else
	{
		document.forms[0].sel_clearence.value="0";
	}
	if(selelectricity!="")
	{
		document.forms[0].sel_electricity.value=selelectricity;
	}
	else
	{
		document.forms[0].sel_electricity.value="0";
	}
	if(selcropping!="")
	{
		document.forms[0].sel_cropping.value=selcropping;
	}
	if(selirrigation!="")
	{
		document.forms[0].sel_irrigation.value=selirrigation;
	}
	if(agr_electricitydoc!="")
	{
		document.forms[0].sel_document.value=agr_electricitydoc;
	}
	else
	{
		document.forms[0].sel_document.value="0";
	}
	
	onchangeFCGW();
	onchangeCCSR();
	onchangeFCEB();
	onchangeCPF();
	onchangeWSI();
	disableFields(true);
	
	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value=schemetype;

	if(appstatus=="Open/Pending")
	{
		if(document.forms[0].btnenable.value.toUpperCase()=="Y")
		{
	     disableCommandButtons(false, true, true, true, true, false);
		}
		else
		{
			disableCommandButtons(true, true, true, true, true, false);
		}
	}
	else
	{
		disableCommandButtons(true, true, true, true, true, false);
	}
	//callbuttonStatus(document.forms[0].hidUsrMode, document.forms[0].hidWorkflowStatus, 'Edit',document.forms[0].hidWorkflowId);
}
function disableCommandButtons(cmdEdit,cmdSave,cmdCancel,cmdDelete,cmdClose)
{
	  document.forms[0].cmdedit.disabled=cmdEdit;
  	  document.forms[0].cmdsave.disabled=cmdSave;
	  document.forms[0].cmdcancel.disabled=cmdCancel;
	  document.forms[0].cmddelete.disabled=cmdDelete;	
	  document.forms[0].cmdclose.disabled=cmdClose; 
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
	    if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].disabled=val;
		}	  
		if(document.forms[0].elements[i].type=='textarea')
		{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}	  
	}	
	
}

function doEdit()
{		
	document.forms[0].hidAction.value ="insert";
	disableFields(false);
	disableCommandButtons(true,false,false,false,false);
}
	
function doSave()
{
	disableCommandButtons(true,true,true,true,false);
	document.forms[0].hidBeanId.value="agrcrops";
	document.forms[0].hidSourceUrl.value="/action/agr_minorirrigation.jsp?tabid=P";
	document.forms[0].hidBeanMethod.value="updatefarmMechMinorIrrig";
	document.forms[0].hidBeanGetMethod.value="getfarmMechMinorIrrig";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();	
}
function doDelete() 
{
   	if( ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updatefarmMechMinorIrrig";
		document.forms[0].hidBeanGetMethod.value="getfarmMechMinorIrrig";
		document.forms[0].hidBeanId.value="agrcrops";
		document.forms[0].hidSourceUrl.value="/action/agr_minorirrigation.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	} 
}
function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value="cancel";
		document.forms[0].hidBeanId.value="agrcrops";
		document.forms[0].hidBeanGetMethod.value="getfarmMechMinorIrrig";
		document.forms[0].action=appUrl+"action/agr_minorirrigation.jsp?tabid=P";
		document.forms[0].submit();
	}
}

function onchangeFCGW()
{
	if(document.forms[0].sel_surveydept.value=="2")
	{
		document.all.FCGW1.style.visibility="visible";
		document.all.FCGW2.style.visibility="visible";
	}
	else
	{
		document.all.FCGW1.style.visibility="hidden";
		document.all.FCGW2.style.visibility="hidden";
	}
}

function onchangeFCEB()
{
	if(document.forms[0].sel_electricity.value=="1")
	{
		document.all.FCEB1.style.visibility="visible";
		document.all.FCEB2.style.visibility="visible";
	}
	else
	{
		document.all.FCEB1.style.visibility="hidden";
		document.all.FCEB2.style.visibility="hidden";
	}
}

function onchangeCCSR()
{
	if(document.forms[0].sel_clearence.value=="2")
	{
		document.all.CCSR1.style.visibility="visible";
		document.all.CCSR2.style.visibility="visible";
	}
	else
	{
		document.all.CCSR1.style.visibility="hidden";
		document.all.CCSR2.style.visibility="hidden";
	}
}

function onchangeCPF()
{
	if(document.forms[0].sel_cropping.value=="2")
	{
		document.all.CPF1.style.visibility="visible";
		document.all.CPF2.style.visibility="visible";
	}
	else
	{
		document.all.CPF1.style.visibility="hidden";
		document.all.CPF2.style.visibility="hidden";
	}
}
function onchangeWSI()
{
	if(document.forms[0].sel_irrigation.value=="2")
	{
		document.all.WSI1.style.visibility="visible";
		document.all.WSI2.style.visibility="visible";
	}
	else
	{
		document.all.WSI1.style.visibility="hidden";
		document.all.WSI2.style.visibility="hidden";
	}
}
function clearFields()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text" )
		{
			document.forms[0].elements[i].value="";
		}
	}
	document.forms[0].txa_tubewaterexcessusage.value="";
}
function calculateRepairsTotal()
{
	var deepcost=document.forms[0].txt_deepeningcost.value;
	var wallscost=document.forms[0].txt_wallscost.value;
	var othercost=document.forms[0].txt_othercost.value;

	if(deepcost=="")deepcost=0.00;
	if(wallscost=="")wallscost=0.00;
	if(othercost=="")othercost=0.00;
	document.forms[0].txt_totalcost.value=eval(deepcost)+eval(wallscost)+eval(othercost);
}

function callPage()
{
	document.forms[0].hidBeanGetMethod.value="getfarmMechMinorIrrig";
	document.forms[0].hidBeanId.value="agrcrops";
	document.forms[0].action=appURL+"action/agr_minorirrigation.jsp?tabid=P";	
	document.forms[0].submit();	
}
function callPage1()
{
	document.forms[0].hidBeanGetMethod.value="getfarmMechMinorIrrig";
	document.forms[0].hidBeanId.value="agrcrops";
	document.forms[0].action=appURL+"action/agr_sprinkler.jsp?tabid=S";	
	document.forms[0].submit();	
}
function callPage2()
{
	document.forms[0].hidBeanGetMethod.value="getfarmMechMinorIrrig";
	document.forms[0].hidBeanId.value="agrcrops";
	document.forms[0].action=appURL+"action/agr_dripirrigation.jsp?tabid=I";	
	document.forms[0].submit();	
}
function callPage3(){

	document.forms[0].hidBeanGetMethod.value="getfarmMechMinorIrrig";
	document.forms[0].hidBeanId.value="agrcrops";
	document.forms[0].action=appURL+"action/agr_sinknewell.jsp?tabid=N";	
	document.forms[0].submit();	
}
function callPage4(){

	document.forms[0].hidBeanGetMethod.value="getfarmMechMinorIrrig";
	document.forms[0].hidBeanId.value="agrcrops";
	document.forms[0].action=appURL+"action/agr_constructpond.jsp?tabid=T";	
	document.forms[0].submit();	
}
function callPage5(){

	document.forms[0].hidBeanGetMethod.value="getfarmMechMinorIrrig";
	document.forms[0].hidBeanId.value="agrcrops";
	document.forms[0].action=appURL+"action/agr_constructdam.jsp?tabid=D";	
	document.forms[0].submit();	
}
function callPage6(){

	document.forms[0].hidBeanGetMethod.value="getfarmMechMinorIrrig";
	document.forms[0].hidBeanId.value="agrcrops";
	document.forms[0].action=appURL+"action/agr_repairwell.jsp?tabid=R";	
	document.forms[0].submit();	
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>
<body onload="callLoad()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div></div>
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
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
      <td class="page_flow">Home -&gt; Agriculture -&gt; Minor Irrigation -&gt; Purchase of Pumpset
      				</td>
	</tr>
</table>
<lapschoice:borrowertype /> 
<lapschoice:application />

<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="93" />
			<jsp:param name="pageid" value="<%=schemetype%>"/>
			
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center">
		<tr>
		<td align="center" nowrap class="sub_tab_active">Purchase of Pumpset</td>
		<td width="20%" align="center" nowrap class="sub_tab_inactive"><a
			href="javascript:callPage1()">Purchase of Sprinkler</a></td>
		<td align="center" nowrap class="sub_tab_inactive"><a
			href="javascript:callPage2()">Drip Irrigation</a></td>
		<td align="center" nowrap class="sub_tab_inactive"><a
			href="javascript:callPage3()">Sinking of new Well</a></td>
		<td align="center" nowrap class="sub_tab_inactive"><a
			href="javascript:callPage4()">Construction of Bore Well/Tube Well</a></td>
		<td align="center" nowrap class="sub_tab_inactive"><a
			href="javascript:callPage5()">Construction of check Dam</a></td>
		<td align="center" nowrap class="sub_tab_inactive"><a
			href="javascript:callPage6()">Repair of Well</a></td>
		</tr>
		</table>
		<br>
<table width="98%" border="0" cellspacing="0" cellpadding="5"  align="center" class="outertable border1">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
            

       <!--    <tr><td>Margin %</td>
         <td><input type="text" name="txt_margin" size="15" maxlength="5" onKeyPress="allowNumber(this)" onblur="checkPercentage(this)" style="text-align: right" 
								value="<%=Helper.correctNull((String)hshValues.get("agr_margin"))%>"></td></tr>-->
    
                <tr class="dataheader"> 
                  <td colspan="2"> <b>Particulars of the pumpset proposed to be 
                    purchased</b> </td>
                </tr>
                <tr> 
                  <td width="40%">Item </td>
                  <td> 
                    <input type="text" name="txt_pumpitem" size="30" maxlength="100" 
                    onKeyPress="notAllowSingleAndDoubleQuote()" value="<%=Helper.correctNull((String)hshValues.get("am_pump_item"))%>">
                  </td>
                  <td width="20%">Tentative time required for completion of the proposed work </td>
                  <td> 
                    <input type="text" name="txt_timereq" size="30" maxlength="50" 
                    onKeyPress="notAllowSingleAndDoubleQuote()" value="<%=Helper.correctNull((String)hshValues.get("am_timereq"))%>">
                  </td>
                </tr>
                     <tr> 
                  <td width="40%">Diesel/Electric</td>
                  <td> 
                    <input type="text" name="txt_diesel" size="30" maxlength="50" 
                    onKeyPress="notAllowSingleAndDoubleQuote()" value="<%=Helper.correctNull((String)hshValues.get("am_diesel"))%>">
                  </td>
                </tr>
                <tr> 
                  <td>Make </td>
                  <td> 
                    <input type="text" name="txt_pumpmake" size="30" maxlength="30" onKeyPress=""
								value="<%=Helper.correctNull((String)hshValues.get("am_pump_make"))%>">
                  </td>
                  <td>Indicate level of water during summer in well /tube well</td>
                  <td> 
                    <input type="text" name="txt_indlevelofwater" size="30" maxlength="50" onKeyPress="notAllowSingleAndDoubleQuote()"
								value="<%=Helper.correctNull((String)hshValues.get("am_indlevelofwater"))%>">
                  </td>
                </tr>
                <tr> 
                  <td>H.P. </td>
                  <td> 
                    <input type="text" name="txt_pumphp" size="30" maxlength="20" onKeyPress="notAllowSingleAndDoubleQuote()"
								value="<%=Helper.correctNull((String)hshValues.get("am_pump_hp"))%>">
                  </td>
                </tr>
                <tr > 
                  <td width="39%">Source of Water</td>
                  <td align="left" > 
                  
                  <!-- Added by Arsath on 24/02/2014 as per the given requirements -->
                  
<!--                    <input type="text"-->
<!--								name="txt_sourcewater" size="30"  onKeyPress="notAllowSingleAndDoubleQuote()"-->
<!--								value="<%=Helper.correctNull((String)hshValues.get("am_watersource"))%>"-->
<!--								maxlength="50">-->

				<select name="sel_sourcewater" style="width: 70px" >
				<option value="s">--Select--</option>
				<option value="we">Well</option>
				<option value="ta">Tank</option>
				<option value="ca">Canal</option>
				<option value="st">Stream</option>
				<option value="ot">Others</option>
				</select>
                </td>
                </tr>
          
          <tr id="tr_area"> 
            <td> Area to be Benefited </td>
            <td> 
              <input type="text" name="txt_benefitarea" size="30" maxlength="95" onKeyPress="notAllowSingleAndDoubleQuote()"
					value="<%=Helper.correctNull((String)hshValues.get("am_areabenefited"))%>">
            </td>
          </tr>
        </table>
		<!-- Common Block Starts -->
		<table width="100%" border="0" cellspacing="1" cellpadding="3"  class="outertable">
			<tr>
				<td width="40%">Feasibility
				Certificate obtained from Ground Water Survey Department</td>
				<td > <select
					name="sel_surveydept" onChange="onchangeFCGW()">
					<option value="0" selected>-- Select --</option>
					<option value="1">Yes</option>
					<option value="2">No</option>
					<option value="3">NA</option>
				</select> </td>
				<td  id="FCGW1">Reason</td>
				<td  id="FCGW2"><textarea name="txt_surveydeptRsn" 
					rows="2" cols="20" onKeyPress="textlimit(this,99);notAllowSingleAndDoubleQuote()" onKeyUp="textlimit(this,99)"><%=Helper.correctNull((String) hshValues
							.get("am_feasibilityreason"))%></textarea></td>
			</tr>
			<tr>
				<td >Clearance
				certificate from stream / River development</td>
				<td > <select
					name="sel_clearence" onChange="onchangeCCSR()">
					<option value="0" selected>-- Select --</option>
					<option value="1">Yes</option>
					<option value="2">No</option>
					<option value="3">NA</option>
				</select> </td>
				<td  id="CCSR1">Reason</td>
				<td  id="CCSR2"><textarea name="txt_clearenceRsn" 
					rows="2" cols="20" onKeyPress="textlimit(this,99);notAllowSingleAndDoubleQuote()" onKeyUp="textlimit(this,99)"><%=Helper.correctNull((String) hshValues
							.get("am_clearancereason"))%></textarea></td>
			</tr>
			<tr>
				<td >Whether
				Electricity Board agree to give the electricity Connection</td>
				<td > <select
					name="sel_electricity" onChange="onchangeFCEB()">
					<option value="0" selected>-- Select --</option>
					<option value="1">Yes</option>
					<option value="2">No</option>
					<option value="3">NA</option>
				</select> </td>
				<td  id="FCEB1" align="left">Documents enclosed </td>
				<td  id="FCEB2"> <select
					name="sel_document">
					<option value="0" selected>-- Select --</option>
					<option value="1">Yes</option>
					<option value="2">No</option>
					<option value="3">NA</option>
				</select> </td>
			</tr>
			<tr>
				<td >Whether cropping
				pattern propose after development is feasible with reference water
				availability</td>
				<td > <select
					name="sel_cropping" onChange="onchangeCPF()">
					<option value="0" selected>-- Select --</option>
					<option value="1">Yes</option>
					<option value="2">No</option>
					<option value="3">NA</option>
				</select> </td>
				<td  id="CPF1">Reason</td>
				<td  id="CPF2"><textarea name="txt_croppingRsn" rows="2"
					cols="20" onKeyPress="textlimit(this,99);notAllowSingleAndDoubleQuote()" onKeyUp="textlimit(this,99)"><%=Helper.correctNull((String) hshValues
							.get("am_cropppingreason"))%></textarea></td>
			</tr>
			<tr>
				<td >Whether the
				water is suitable for irrigation </td>
				<td > <select
					name="sel_irrigation" onChange="onchangeWSI()">
					<option value="0" selected>-- Select --</option>
					<option value="1">Yes</option>
					<option value="2">No</option>
					<option value="3">NA</option>
				</select> </td>
				<td  id="WSI1">Reason
				</td>
				<td  id="WSI2"><textarea name="txt_irrigationRsn"
					rows="2" cols="20" onKeyPress="textlimit(this,99);notAllowSingleAndDoubleQuote()" onKeyUp="textlimit(this,99)"><%=Helper.correctNull((String) hshValues
							.get("am_waterirrigreason"))%></textarea></td>
			</tr>
			
			<tr class="dataheader">
				<td colspan="4"> <b>Cost of Electricity Connection </b> </td>
			</tr>
			<tr>
				<td width="40%">For drawing
				power lines to Farm </td>
				<td align="left" width="20%"><lapschoice:CurrencyTag
					name="txt_elecDrawing" size="15"
					value='<%=Helper.correctDouble((String)hshValues.get("am_elecDrawing"))%>'
					maxlength="9" /></td>
				<td width="20%">Deposit to the
				Power Supplier&nbsp;</td>
				<td width="20%"> <lapschoice:CurrencyTag
					name="txt_elecDeposit" size="15"
					value='<%=Helper.correctDouble((String)hshValues.get("am_elecDeposit"))%>'
					maxlength="9" /> </td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<%
	String strappno =Helper.correctNull((String) request.getParameter("appno"));

	if (strappno.equalsIgnoreCase("new")) {
	}
%> 

<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail'
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />	

<br>
<input type="hidden" name="hidAction" value=""> 
<INPUT TYPE="hidden" name="hidBeanId" value=""> 
<input type="hidden" name="hidBeanMethod" value=""> 
<INPUT TYPE="hidden" name="hidBeanGetMethod" value=""> 
<input type="hidden" name="hidSourceUrl" value="">
<input type="hidden" name="hidAppType">
<input type="hidden" name="txt_tabid" value="P">
</form>
</body>
</html>