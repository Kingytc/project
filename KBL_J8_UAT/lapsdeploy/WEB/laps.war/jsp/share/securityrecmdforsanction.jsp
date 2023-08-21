<%@include file="../share/directives.jsp"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%ArrayList arrRow = new ArrayList();
			ArrayList arrCol = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrRow");
			String strSector = Helper.correctNull((String) request.getParameter("hidsector"));
			String strSaral = Helper.correctNull((String) request.getParameter("hidsaral"));
			String strApploantype = Helper.correctNull((String) request	.getParameter("apploantype"));
			String strApplevel = Helper.correctNull((String) request.getParameter("applevel"));
			String strValuesin = Helper.correctNull((String) request.getParameter("valuesin"));
			if (strValuesin.equals("L")) {
				strValuesin = " in Lacs";
			} else {
				strValuesin = "";
			}
			String strappholder = Helper.correctNull((String) request.getParameter("appholder"));
			String strappliedfor = Helper.correctNull((String) request	.getParameter("appliedfor"));
			String strProposal= Helper.correctNull(request.getParameter("hidproposal"));
			
			//Added by Zahoorunnisa.S for button functionality
			String strapplevel = Helper.correctNull((String)request.getParameter("applevel"));
			String strstatus = Helper.correctNull((String) request.getParameter("hidstatus"));
			if (strstatus.equals(""))
				strstatus = Helper.correctNull((String) hshValues.get("status"));
						
				//end	
%>

<html>
<head>
<title>Security Master</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>

<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varright= "<%=Helper.correctNull((String) session.getAttribute("strGroupRights")).charAt(18)%>";
function selectValues(val1,val2,val3,val4)
{
	document.forms[0].selsectype.value=val1;
	document.forms[0].txt_presentval.value=val2;
	document.forms[0].txt_secdesc.value=document.getElementById("hiddesc"+val3).value;
	document.forms[0].hidsno.value=val4;
   //Added By Zahoorunnisa.S for Button Functionality after discussion with Suresh
	
	if("<%=strSaral%>"=="saral" && "<%=strOrgLevel%>"=="A"){
		
		if("<%=strstatus%>"=="O" && varright=="w"){
		    enableButtons(true,false,true,true,true,false);
		}else{
			enableButtons(true,true,true,true,true,false);	
		}
			
	}else if("<%=strSaral%>"=="saral" && "<%=strapplevel%>" == ""){ 
		enableButtons(true,true,true,true,true,false);	
    }else{
		
		//Access through Branch Users
		if("<%=strapplevel%>" == "S"){
			enableButtons(true,true,true,true,true,false);
		}
	}

	
	
	//End

}
 function disableFields(val)
  {
	  for(var i=0;i<document.forms[0].length;i++)
	  {
		  if(document.forms[0].elements[i].type=='text'  )
		  {
			document.forms[0].elements[i].readOnly=val;
		  }	 
		   if(document.forms[0].elements[i].type=='textarea'  )
		  {
			document.forms[0].elements[i].readOnly=val;
		  }	 
		  if(document.forms[0].elements[i].type=='select-one'  )
		  {
			document.forms[0].elements[i].disabled=val;
		  }	 
	  }
  }

 function onloading(){
	
	//Added By Zahoorunnisa.S for Button Functionality after discussion with Suresh
		
	//If access through the Loan Application Register and its at Branch 
		if("<%=strSaral%>"=="saral" && "<%=strOrgLevel%>"=="A"){ 
			//If the Application is in open status
			if("<%=strstatus%>"=="O"  &&  varright=="w"){
			    enableButtons(false,true,true,true,true,false);
			}else{
				enableButtons(true,true,true,true,true,false);	
			}
				
		} else if("<%=strSaral%>"=="saral" && "<%=strapplevel%>" == ""){ 
			
			enableButtons(true,true,true,true,true,false);
				
	    }else{
			
			if("<%=strapplevel%>" == "S"){
				enableButtons(true,true,true,true,true,false);
			}
		}

		//End

		disableFields(true);
}


function callDisable(one)
{
for(var i=0;i<document.forms[0].elements.length;i++)
	{
	if(document.forms[0].elements[i].type=="radio")
{
		document.forms[0].elements[i].disabled=one;
}
	}
}


 function doEdit()
 { 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons(true,true,false,false,false,true);
	document.forms[0].selsectype.focus();
 }
function doSave()
{
	if(document.forms[0].selsectype.selectedIndex == "0")
	{
		ShowAlert(111,'Type of Security');
	  	return false;
	}
	else if(document.forms[0].txt_presentval.value == "")
	{
		ShowAlert(112,'Present Value');
	  	return false;
	}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="inwardRegister";		
	document.forms[0].hidSourceUrl.value="/action/securityrecmdforsanction.jsp";
	document.forms[0].hidBeanMethod.value="updatebrrecmdsecurity";
	document.forms[0].hidBeanGetMethod.value="getbrrecmdsecurity";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doDelete()
{
	if(document.forms[0].hidsno.value!="")
	{
		if(ConfirmMsg(101))
		{
			document.forms[0].hidAction.value ="delete";
			document.forms[0].action=appURL+"action/ControllerServlet";	
			document.forms[0].hidBeanMethod.value="updatebrrecmdsecurity";
			document.forms[0].hidBeanGetMethod.value="getbrrecmdsecurity";	
			document.forms[0].hidBeanId.value="inwardRegister";
			document.forms[0].hidSourceUrl.value="action/securityrecmdforsanction.jsp";	
			document.forms[0].method="post";			
			document.forms[0].submit();	
		}
	}
	else
	{
		alert("Select Security to delete");
		return;
	}	
}
 function doNew()
  {

    disableFields(false);
    document.forms[0].hidAction.value ="insert";
    disableCommandButtons(true,true,false,true,false,true);
  	document.forms[0].selsectype.value="0";
	document.forms[0].txt_presentval.value="";
	document.forms[0].txt_secdesc.value="";
	document.forms[0].selsectype.focus();
   }
 function doCancel()
  {
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="";
		document.forms[0].hidBeanId.value="inwardRegister";
		document.forms[0].hidBeanGetMethod.value="getbrrecmdsecurity";
		document.forms[0].action=appURL+"action/securityrecmdforsanction.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
  }
   
 function disableCommandButtons(cmdnew,cmdedit,cmdapply,cmddel,cmdcancel,cmdclose)
 {  
	  document.forms[0].cmdnew.disabled =cmdnew;
	  document.forms[0].cmdedit.disabled=cmdedit;	  
	  document.forms[0].cmdsave.disabled=cmdapply;
	  document.forms[0].cmddelete.disabled=cmddel;
	  document.forms[0].cmdcancel.disabled=cmdcancel;
	  document.forms[0].cmdclose.disabled=cmdclose;
 }
 function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}
}

function enableButtons(valnew,valedit,valapply,valcancel,valdel,valclose)
{
	document.forms[0].cmdnew.disabled=valnew;
	document.forms[0].cmdedit.disabled=valedit;	  	
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmddelete.disabled=valdel;
	document.forms[0].cmdclose.disabled=valclose;
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<STYLE>

DIV.cellContainer {	
  width: 100%; height: 200;
  overflow: auto;
}
</STYLE>
<!--<link rel="stylesheet"-->
<!--	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"-->
<!--	type="text/css">-->
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>
<body onload="onloading()">
<form method="post" class="normal">
<%if (strSaral.equalsIgnoreCase("saral")) {%> <laps:saralreportTag
	tabid="7" sector='<%=strSector%>' applied='<%=strappliedfor%>' proposal='<%=strProposal%>'/> <laps:inward />
<%} else if (strApploantype.equalsIgnoreCase("c")) {%> <lapstab:ComReportTab
	tabid="4"
	applevel='<%=Helper.correctNull((String)request.getParameter("applevel"))%>'
	applied="<%=strappliedfor%>" /> <span style="display:none"><laps:borrowertype /></span>
<laps:application /> <%}
else if (strApploantype.equalsIgnoreCase("T")) {%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable ">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkscom.jsp"
			flush="true">
			<jsp:param name="pageid" value="10" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Tertiary -&gt; Application -&gt;
		Reports -&gt; Credit Report</td>
	</tr>
</table>
<span
	style="visibility:hidden"><laps:borrowertype /></span> <laps:application />
<lapstab:TerReportTab tabid="3" applevel="<%=strApplevel%>"
	applied="<%=strappliedfor%>" /> <%} else if (strApploantype.equalsIgnoreCase("P")) {%>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable border1">
	<tr>
		<td id="mainlnk1"><jsp:include page="../share/Applurllinkper.jsp"
			flush="true">
			<jsp:param name="pageid" value="10" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Retail
		-&gt; <%=(String) session.getAttribute("pgeLabel")%> -&gt; Appraisal
		-&gt; Recommendation by Branch</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td id="mainlnk1"><laps:application /></td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable border1">
	<tr>
		<td><jsp:include page="../share/apprlinktab.jsp" flush="true">
			<jsp:param name="tabid" value="12" />
		</jsp:include></td>
	</tr>
</table>
<%}
    
    else if((strCategoryType.equals("ADC") ||strCategoryType.equals("STL")||strCategoryType.equals("SRE"))  &&(strApplevel.equals("S")) )
	{
	%>
	<table border="0" width="100%" class="outertable">
	<tr>
	 <td valign="top">
    <jsp:include page="../share/applurllinkscom.jsp" flush="true">         
    <jsp:param name="pageid" value="16" />
    <jsp:param name="cattype" value="<%=strCategoryType%>" />
    <jsp:param name="ssitype" value="<%=strSSIType%>" />
    </jsp:include>
     </td>
	</tr> 
	<tr>
	 <%if(strCategoryType.equals("ADC")) {%>
		 <td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Adhoc Limit -&gt; Saral -&gt; Securities
		 </td>
		 <%}
	     else if(strCategoryType.equals("STL")) {%>
	       <td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Short Term Loan -&gt; Saral -&gt; Securities
		 </td>
		  <%}
	     else if(strCategoryType.equals("SRE")) {%>
	       <td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Short Review Extension -&gt; Saral -&gt; Securities
		 </td>
		 <%} %>
	</tr>
	<tr>
	<td>
	<span style="visibility:hidden">
	<laps:borrowertype /></span> <laps:application/>
	<laps:saralappinwardtag tabid="7" sector="<%=strCategoryType%>"	applied="<%=strappliedfor%>"  />
	</td></tr>
	  </table>
	<%} %>

			
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable border1">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
					<tr>
						<td valign="top">
						<table width="80%" border="0" cellspacing="0" cellpadding="0"
							align="center" class="outertable border1">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="3"
								class="outertable">
									<tr>
										<td width="25%">&nbsp;</td>
									</tr>
									<tr>
										<td width="25%" >Type of Security <b>*</b></td>

										<td width="36%"><select name="selsectype" tabindex="1">
											<option value="0" selected="selected">&lt;----Select----&gt;</option>
											<option value="1">Primary</option>
											<option value="2">Collateral</option>
										</select></td>

										<td width="25%" >Present Value (<%=ApplicationParams.getCurrency()%>
										<%=strValuesin%>) <b>*</b></td>

										<td width="36%"><input type="text" name="txt_presentval"
											size="15" maxlength="12" tabindex="2"
											style="text-align:right" onBlur="roundtxt(this)"
											onKeyPress="allowNumber(this)"></td>
									</tr>
									<tr>
										<td width="25%">Nature/Description of Prime/collateral
										security indicating area &amp; location of property</td>

										<td width="36%" colspan="3"><textarea name="txt_secdesc"
											tabindex="3" cols="50" rows="3"
											onKeyPress="textlimit(this,400)" onkeyup="checkTextArealimit(this,400);"></textarea></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
<br/>
						<laps:combuttonnew btnnames="New_Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<br/>
						<table width="80%" border="0" cellspacing="0" cellpadding="0"
							align="center" class="outertable border1">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="3"
								class="outertable">
									<tr class="dataHeader">
										<td width="5%" class="tabactivenew">&nbsp;</td>
										<td align="center" width="15%" class="tabactivenew"><b>Type of
										Security</b></td>

										<td align="center" width="15%" class="tabactivenew"><b>Present
										Value (<%=ApplicationParams.getCurrency()%><%=strValuesin%>)</b>
										</td>

										<td align="center" width="70%" class="tabactivenew"><b>Nature/Description
										of Prime/collateral security indicating area &amp; location of
										property</b></td>

									</tr>
								</table>
								<table width="100%" border="0" cellspacing="1" cellpadding="0"
								class="outertable">
									<%String sel_val = null;
			if (arrRow != null && arrRow.size() > 0) {
				if (arrRow.size() > 0) {
					for (int i = 0; i < arrRow.size(); i++) {
						arrCol = (ArrayList) arrRow.get(i);
						sel_val = "";

						%>
									<tr class="dataGridColor">
										<td width="5%" align="center"><input type="radio"
											style="border:none" name="rdoUser"
											onClick="javascript:selectValues('<%=Helper.correctNull((String)arrCol.get(0))%>','<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1))))%>'
                            	,'<%=i%>','<%=Helper.correctNull((String)arrCol.get(3))%>')">
										<input type="hidden" name="hiddesc<%=i%>"
											value="<%=Helper.correctNull((String)arrCol.get(2))%>"></td>

										<%if (Helper.correctNull((String) arrCol.get(0)).equals(
								"1"))
							sel_val = "Primary";
						else if (Helper.correctNull((String) arrCol.get(0))
								.equals("2"))
							sel_val = "Collateral";

						%>
										<td width="15%" align="left">&nbsp; <%=sel_val%></td>

										<td width="15%" align="left">&nbsp;<%=Helper.formatDoubleValue(Double
										.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(1))))%></td>
										<td width="70%" align="left">&nbsp;<%=Helper.correctNull((String) arrCol.get(2))%></td>


									</tr>
									<%}
				}
			} else {
			%>
									<tr class="dataGridColor">
										<td align="center" colspan="6">No Data Found</td>
									</tr>
									<%}
		%>
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
		</td>
	</tr>
</table>

<br>
<laps:hiddentag pageid='<%=PageId %>'/>
 <input type="hidden"
	name="hidsno" value=""> <input type="hidden" name="valuesin" value="">
</form>
</body>
</html>