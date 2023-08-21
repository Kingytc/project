<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%@page import="com.sai.fw.management.utils.FwHelper"%>
<%request.setAttribute("_cache_refresh", "true");%>
<laps:handleerror />
<%
	String prd_type = Helper.correctNull((String) session
			.getAttribute("strProductType"));
	String strorgcode = Helper.correctNull((String) session
			.getAttribute("strOrgCode"));
	String appstatus = Helper.correctNull((String) session
			.getAttribute("appstatus"));
	String strappno = Helper.correctNull((String) session
			.getAttribute("strappno"));
	int yield_period=0;
			
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
	int arrSize=0;
	ArrayList arrCol = new ArrayList();
	ArrayList arrRow = new ArrayList();
	HashMap hshParticulars = new HashMap();
	String landdevelopinch="";
	landdevelopinch=Helper.correctNull((String)hshValues.get("agr_landdevelop_inches"));

	if(hshValues!=null)
	{
		arrRow=(ArrayList)hshValues.get("arrSand");
		
	}
	if(arrRow!=null )
	{
		arrSize=arrRow.size();
	}
	
	String strDesc[]={"One acre unit (in sq.mts)","% of extent reserved for stocking",
			" of the extent sand to be removed",
			"Quantity of sand to be removed/soil to be filled","Rate per cu.m for removal of rs",
			"Add<b>:</b>Contingencies",
			"Cost per acre"};
	
	if(hshValues!=null)
	{
		hshParticulars=(HashMap)hshValues.get("hshParticulars");
	}
	
	java.text.DecimalFormat nf = new java.text.DecimalFormat();
	nf.setGroupingUsed(false);
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
	java.text.DecimalFormat nf1 = new java.text.DecimalFormat();
	nf1.setGroupingUsed(false);
	nf1.setMaximumFractionDigits(0);
	nf1.setMinimumFractionDigits(0);
	
	
String schemetype="";
schemetype = Helper.correctNull((String) request.getParameter("schemetype"));
String strschemetypeno=Helper.getfacilitySno(schemetype);
%>

<html>
<head>
<title>Sand Casting</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript1.2"	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
 
<Script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var varmaintenance = "<%=Helper.correctNull((String)hshValues.get("maintenance"))%>";
var varlanddevelopinch="<%=landdevelopinch%>";
var varschemetype="<%=schemetype%>";
function disableEditButtons(bool1, bool2, bool3, bool4,  bool6)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	
	document.forms[0].cmdclose.disabled=bool6;
}
function disabledFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	   
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].disabled=!val;
		}	
	}
}
function onloading()
{	  
	// callbuttonStatus(document.forms[0].hidUsrMode, document.forms[0].hidWorkflowStatus, 'Edit',document.forms[0].hidWorkflowId);
	fillFirstRow();
	//document.all.idunit.innerText = (NanNumber(eval(document.forms[0].txt_particulars[2].value)));
	disabledFields(true);
	document.all.sel_scheme.readOnly=false;
	document.all.sel_scheme.value=varschemetype;
	
		disableEditButtons(false,true,true,true,false);	

		document.forms[0].txt_particulars[2].readOnly=true;

		if(varlanddevelopinch=="")
		{
			alert("Please Fill the Land Development Details ");
		}
	
}
function fillFirstRow()
{
	document.forms[0].txt_sixInches[0].value="4046";
}
function computeStocking()
{
	
	document.forms[0].txt_sixInches[1].value	=	roundVal(4046*NanNumber(eval(document.forms[0].txt_particulars[0].value)/100));
	
	document.forms[0].txt_particulars[1].value	=	roundVal(100-NanNumber(eval(document.forms[0].txt_particulars[0].value)));

	document.forms[0].txt_sixInches[2].value	=	roundVal(4046*NanNumber(eval(document.forms[0].txt_particulars[1].value)/100));
	
	document.forms[0].txt_sixInches[3].value	=	roundVal(0.23*NanNumber(eval(document.forms[0].txt_sixInches[2].value)));
	
	if(parseFloat(document.forms[0].txt_particulars[2].value)!=0)
	{
		
		document.forms[0].txt_sixInches[4].value	=	roundVal(NanNumber((NanNumber(eval(document.forms[0].txt_particulars[3].value)))/(NanNumber(eval(document.forms[0].txt_particulars[2].value)))
														*NanNumber(eval(document.forms[0].txt_sixInches[3].value))));
		
	}
	else
	{
		document.forms[0].txt_sixInches[4].value="0.00";
		
	}
	if(trim(document.forms[0].txt_sixInches[5].value)=="")
		document.forms[0].txt_sixInches[5].value="0.00";
	

	var varSixInchestotal=parseFloat(document.forms[0].txt_sixInches[5].value)+parseFloat(document.forms[0].txt_sixInches[4].value);
	document.forms[0].txt_sixInches[6].value	=	roundVal(varSixInchestotal);

	

	//document.getElementById('idunit').innerHTML = NanNumber(parseFloat(document.forms[0].txt_particulars[2].value));
	//computeQtyOfSoilReq();
	
}

function doSave()
{  
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="agrlandholdings";
	document.forms[0].hidBeanMethod.value="updateSandCasting";
	document.forms[0].hidBeanGetMethod.value="getSandCasting";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/agr_sandcasting.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();	
}
function doEdit()
{
	
	document.forms[0].hidAction.value="Edit";
	disabledFields(false);
	disableEditButtons(true, false, false, false,  false);	

	for(var i=0;i<document.forms[0].txt_sixInches.length;i++)
	{
		if(i==5||i==7||i==8||i==9||i==10||i==11||i==12)
		{
			document.forms[0].txt_sixInches[i].readOnly=false;
			
		}
		else
		{
			document.forms[0].txt_sixInches[i].readOnly=true;
			
		}
	}
	document.forms[0].txt_particulars[1].readOnly=true;
	document.forms[0].txt_particulars[2].readOnly=true;
	//document.forms[0].txt_totqtyofsoil.readOnly=true;
	//document.forms[0].txt_totCostPerAcre.readOnly=true;
//	document.forms[0].txt_overallTot.readOnly=true;
}



function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidBeanGetMethod.value="getSandCasting";
		document.forms[0].hidBeanId.value="agrlandholdings";
		document.forms[0].action=appUrl+"action/agr_sandcasting.jsp";
		document.forms[0].submit(); 		
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanId.value="agrlandholdings";
		document.forms[0].hidSourceUrl.value="action/agr_sandcasting.jsp";	
		document.forms[0].hidBeanMethod.value="updateSandCasting";
		document.forms[0].hidBeanGetMethod.value="getSandCasting";
		document.forms[0].submit();		
	}
}	




</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
	</head>
<body onload="onloading()">
<form name="frmsan" method=post class="normal">
<<div id="ie5menu" class="skin0" onMouseover="highlightie5()" onMouseout="lowlightie5()" onClick="jumptoie5()"> 
  <div class="menuitems" >
   <script language="JavaScript1.2">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div>
  </div>

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
<table width="100%" border="0" cellspacing="0" cellpadding="0" >
	<tr>
	<td class="page_flow">Home -> Agriculture ->  Application -> Sand Casting/Soil Filling </td>
	
	</tr>
	</table>
<span style="display:none;"> <lapschoice:borrowertype /> </span> <lapschoice:application />
 
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="87" />
			<jsp:param name="schemetype" value="<%=schemetype%>" />
		</jsp:include></td>
	</tr>
</table>

<br>


<table width="70%" border="0" cellspacing="0" cellpadding="5"  align="center" class="outertable border1">

  <tr> 
      <td height="24" valign="top"> 
        <table width="100%" border="0" cellspacing="1" cellpadding="3"  class="outertable">
       
       	<tr>
      		 <td colspan="4"><b>Reclamation Of Sand Casting/Soil filling</b></td>
       </tr>
          <tr align="center"   class="dataheader"> 
           <%if(landdevelopinch !=null){
          if(landdevelopinch.equalsIgnoreCase("1"))
        	  {
        	  landdevelopinch=" 6 to 12 inches";
        	  }
        	  else if(landdevelopinch.equalsIgnoreCase("2"))
        	  {
        		  landdevelopinch="12 to 18 inches";
        	  }
        	  else if(landdevelopinch.equalsIgnoreCase("3"))
        	  {
        		  landdevelopinch="18 to 24 inches";
        	  }
        	  else 
        	  {
        		  landdevelopinch="";
        	  }
        	  }%>
            <td>Particulars</td>
            <td ><%=landdevelopinch%></td>
            
          </tr>
          
          <%//out.println("arrRow====>"+arrRow);
          for(int i=0;i<7;i++)
				{ 
        	  
        	  	int arrColSize=0;
				if(i<arrSize)
				{
					arrCol=(ArrayList)arrRow.get(i);
					if(arrCol!=null)
						arrColSize=arrCol.size();
				}
        	  if(arrColSize>0)
        	  { %>
        		  
          
       
          <tr class="dataGridColor" align="center"> 
             
           <% if(i==1){%>
           		<td align="left" ><input type="text" maxlength="6" name="txt_particulars" size="6" onKeyPress="allowNumber(this)" 
						onBlur="roundtxt(this);checkPercentage(this);computeStocking()"
						style="text-align: right" value="<%=Helper.checkPercentageDecimalPoint((String) hshParticulars.get("stocking"))%>"><%= strDesc[i]%> </td>
			<%} else if(i==2){%>
           		<td align="left" >Remaining &nbsp;<input type="text" maxlength="6" name="txt_particulars" size="6" onKeyPress="allowNumber(this)" 
						onBlur="roundtxt(this);checkPercentage(this);"
						style="text-align: right" value="<%=Helper.checkPercentageDecimalPoint((String) hshParticulars.get("remaining"))%>">%<%= strDesc[i]%> </td>
			
			<%}else if(i==4){ %>
				<td align="left" >Rate per &nbsp;<input type="text" maxlength="10" name="txt_particulars" size="6" onKeyPress="allowNumber(this)" 
						onBlur="roundtxt(this);computeStocking();"
						style="text-align: right" value="1">
						&nbsp;cu.m for removal @ Rs&nbsp;
						<input type="text" maxlength="12" name="txt_particulars" size="15" onKeyPress="allowNumber(this)" 
						onBlur="roundtxt(this);computeStocking()"
						style="text-align: right" value="<%=Helper.checkDecimal((String) hshParticulars.get("rateamt"))%>"></td>
            
			
			
           <%}else{ %>
	            <td nowrap align="left" ><%= strDesc[i]%> 
	              <input type="hidden" name="txt_desc" value="<%= strDesc[i]%>"> </td>
            <%} %>		
           	<td> 
              <input type="text" maxlength="12" name="txt_sixInches" onKeyPress="allowNumber(this)" 
				<%if(i==0|| i==6){ %> size="13"  onBlur="roundtxt(this);computeStocking();"  style="text-align: right;background-color:#e7edf8;border-style:none; color:#000000;font-weight:bold;"
				value="<%=Helper.checkDecimal((String)arrCol.get(2))%>"
				 <%}else{ %>size="15"  style="text-align: right"  onBlur="roundtxt(this);computeStocking();" 
				 value="<%=Helper.checkDecimal((String)arrCol.get(2))%>"
				 <%} %>
				
				>
            </td>
            
          </tr>
          
          <%}else{
        %>
        <tr class="dataGridColor" align="center"> 
         	
           
           <% if(i==1){%>
           		<td align="left" ><input type="text" maxlength="6" name="txt_particulars" size="6" onKeyPress="allowNumber(this)" 
						onBlur="roundtxt(this);checkPercentage(this);computeStocking()"
						style="text-align: right" value=""><%= strDesc[i]%> </td>
			<% }else if(i==2){%>
           		<td align="left" >Remaining &nbsp;<input type="text" maxlength="6" name="txt_particulars" size="6" onKeyPress="allowNumber(this)" 
						onBlur="roundtxt(this);checkPercentage(this);"
						style="text-align: right" value="">%<%= strDesc[i]%> </td>
			
			<%}else if(i==4){ %>
				<td align="left" >Rate per &nbsp;<input type="text" maxlength="10" name="txt_particulars" size="6" onKeyPress="allowNumber(this)" 
						onBlur="roundtxt(this);computeStocking()"
						style="text-align: right" value="1">
						&nbsp;cu.m for removal @ Rs&nbsp;
						<input type="text" maxlength="12" name="txt_particulars" size="15" onKeyPress="allowNumber(this)" 
						onBlur="roundtxt(this);computeStocking()"
						style="text-align: right" value=""></td>
            
			
			
           <%}else{ %>
	            <td nowrap align="left"><%= strDesc[i]%> 
	              <input type="hidden" name="txt_desc" value="<%= strDesc[i]%>"> </td>
            <%} %>
           	 
            <td > 
              <input type="text" maxlength="12" name="txt_sixInches"  onKeyPress="allowNumber(this)"
				
				 <%if(i==0|| i==6){ %> size="13"  onBlur="roundtxt(this);computeStocking();"  style="text-align: right;background-color:#e7edf8;border-style:none; color:#000000;font-weight:bold;"
				 <%}else if(i==7){%>size="15"  style="text-align: left" 
				 <%}else{ %>size="15"  style="text-align: right"  onBlur="roundtxt(this);computeStocking();" <%} %>
				 value="">
            </td>
            </tr>
            
            <%} %>
           
          <%}
       %>
       <!-- <tr class="dataHeadColor">
	   <td colspan="4">
	   Refixing Of Soil On Eroded Lands
	   </td>
	   </tr>
        </table>
      </td>
      </tr>
        <tr class="dataGridColor">
        <td>
                <table width="35%" border="0" cellspacing="1" cellpadding="3" align="center">
        	 <tr>
			       		   
            <td width="48%">One acre unit</td>
					       
            <td align="left" width="52%"><b>4046</b> 
              sq.mts</td>
				  </tr>
			       <tr class="dataGridColor">
					       	
            <td width="48%">Average depth to be refixed</td>
					       	
            <td width="52%"> 
              <input type="text" maxlength="10" name="txt_avgDepth"  onKeyPress="allowNumber(this)"
							 onBlur="roundtxt(this);computeQtyOfSoilReq();"
							  size="10"  
							  style="text-align: right" 
							 value="<%=Helper.correctNull((String) hshParticulars.get("avgdepth"))%>">&nbsp;mts</td>
				    </tr>
			       <tr class="dataGridColor">
					       	
            <td width="48%">Total quantity of soil required</td>
					       	
            <td width="52%"> 
              <input type="text" maxlength="12" name="txt_totqtyofsoil"  onKeyPress="allowNumber(this)"
							 onBlur="roundtxt(this);"
							  size="13"  
							 style="text-align: right;background-color:#e7edf8;border-style:none; color:#000000;font-weight:bold;"
							 value="<%=Helper.correctNull((String) hshParticulars.get("totqty"))%>">
              cu.mts</td>
                  </tr>
			        <tr class="dataGridColor">
					       	<td colspan="3"><b>Earth work excavation in loose land per <span id="idunit"></span>&nbsp;cu.mts</b></td>
			       </tr>
			       <tr class="dataGridColor">
					       	
            <td width="48%">Cost per acre</td>
					       	
            <td width="52%"> 
              <input type="text" maxlength="12" name="txt_totCostPerAcre"  onKeyPress="allowNumber(this)"
							 onBlur="roundtxt(this);"
							  size="15"  
							  style="text-align: right"
							 value="<%=nf.format(FwHelper.parseDouble(Helper.correctNull((String) hshParticulars.get("totcostperacre"))))%>"></td>
				   </tr>
			       <tr class="dataGridColor">
					       	
            <td width="48%">Add<b>:</b> Contingencies</td>
					       	
            <td width="52%"> 
              <input type="text" maxlength="12" name="txt_contingencies"  onKeyPress="allowNumber(this)"
							 onBlur="roundtxt(this);computeQtyOfSoilReq()"
							  size="15"  
							  style="text-align: right" 
							 value="<%=nf.format(FwHelper.parseDouble(Helper.correctNull((String) hshParticulars.get("contingencies"))))%>"></td>
				   </tr>
			       <tr class="dataGridColor">
					       	
            <td width="48%">Total cost per acre</td>
					       	
            <td width="52%"> 
              <input type="text" maxlength="10" name="txt_overallTot"  onKeyPress="allowNumber(this)"
							 onBlur="roundtxt(this);"
							  size="13"  
							  style="text-align: right;background-color:#e7edf8;border-style:none; color:#000000;font-weight:bold;"
							 value="<%=nf.format(FwHelper.parseDouble(Helper.correctDouble((String) hshParticulars.get("overalltot"))))%>"></td>
				  </tr>
        		</table>
        	</td>
        	</tr>
      </table> -->
   </table>
   </td>
   </tr>
   </table>
  
<br>


<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' btnnames='Edit_Save_Cancel_Delete'/>
	<br>
  <input type=hidden name="hidBeanId">
  <input type=hidden name="hidBeanMethod">
  <input type=hidden name="hidBeanGetMethod">
  <input type=hidden name="hidSourceUrl">
  <input type="hidden" name="hidAction">
<input type="hidden" name="hid_pagename" value=""> 
<input type="hidden" name="hidAppType" value="<%=Helper.correctNull((String) hshValues.get("hidAppType"))%>">
<input type="hidden" name="landdevelopinches" value="<%=Helper.correctNull((String) hshValues.get("agr_landdevelop_inches"))%>">
 <input type="hidden" name="strschemetypeno" value="<%=strschemetypeno%>"> 
 </form>
</body>
</html>