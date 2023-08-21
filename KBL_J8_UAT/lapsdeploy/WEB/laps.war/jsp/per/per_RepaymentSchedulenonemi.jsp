<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
nf.setGroupingUsed(false);
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
	if (objValues instanceof java.util.HashMap) 
	{
		hshValues = (java.util.HashMap) objValues;
	}
	//out.println(hshValues);
	String strfacility = Helper.correctNull((String) hshValues
			.get("strfacility"));
	String facilit="";
	if(!strfacility.equalsIgnoreCase(""))
	{
		facilit=strfacility;
	}
	else
	{
		facilit="0";
	}
	
	ArrayList arrCol = new ArrayList();
	ArrayList arrRow = new ArrayList();
	//ArrayList arrtlfac = new ArrayList();
	ArrayList arrtlrec = new ArrayList();
	String strAppno = Helper.correctNull((String) hshValues.get("strAppno"));
	String strstrfacamt = Helper.correctNull((String) hshValues.get("strfacamt"));
	
	if(hshValues!=null)
	{
		//arrtlfac =(ArrayList)hshValues.get("arrtlfac");
		arrtlrec =(ArrayList)hshValues.get("arrtlrec");
	}
	
	double dblTotalInstAmt=0.000,dblTotalInstPeriod=0.00;
String strCatName="";
%>
<html>
<head>
<title>Repayment Schedule for Non EMI</title>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>

var appURL = "<%=ApplicationParams.getAppUrl()%>";
var path ="<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String) request.getParameter("appstatus"))%>";
var varRepaymentfor="<%=Helper.correctNull((String) hshValues.get("strRepaymentfor"))%>";
var varRepaymentType="<%=Helper.correctNull((String)hshValues.get("strRepaymentType"))%>";
var varPrdType="<%=Helper.correctNull((String) session.getAttribute("strProductType"))%>";
var varFacInstall="";
var varRepayFlag="<%=Helper.correctNull((String)hshValues.get("strRepayFlag"))%>";
var varAppType="<%=Helper.correctNull((String)session.getAttribute("strAppType"))%>";
function onloading()
{
	document.forms[0].txt_noofinst.disabled = true;
	document.forms[0].txt_instamt.disabled = true;
	document.forms[0].txt_totamt.readOnly = true;

	if(varRepaymentfor!="")
	{
		document.forms[0].selRepaymentFor.value=varRepaymentfor;
	}
	if(document.forms[0].appstatus.value=="Open/Pending")
	{
		if(document.forms[0].btnenable.value.toUpperCase()=="Y")
		{
			enableButtons(false,true,true,true,true,false);
		}
		else
		{
			enableButtons(true,true,true,true,true,false);
		}
		
	}
	else
	{	
		
		enableButtons(true,true,true,true,true,false);
	}
	varFacInstall=document.forms[0].hidfacinstall.value;
	if(varFacInstall!="")
	{
		document.forms[0].sel_frequency.value = varFacInstall.toUpperCase();
	}else
	{
		document.forms[0].sel_frequency.value ="S";
	}
	disableFields(true);
	/*if(varFACILITY_WHETHEREMI=="3" || varFACILITY_WHETHEREMI=="4")
	{
		document.all.idnoofins.innerText="*";
		document.all.idinsamt.innerText="*";
	}
	else
	{
		document.all.idnoofins.innerText="";
		document.all.idinsamt.innerText="";
	}*/
	if(varPrdType=="pG" && varRepaymentType=="14")
	{
		document.forms[0].sel_frequency.length=2;
		document.forms[0].sel_frequency.options[0].value="S";
		document.forms[0].sel_frequency.options[0].text="<-------- Select -------->";
		document.forms[0].sel_frequency.options[1].value="Y";
		document.forms[0].sel_frequency.options[1].text="Yearly";

		document.forms[0].hidStaffPrincipalRepay.value="2";
	}
	document.forms[0].sel_frequency.disabled = true;


	if(varAppType=="P")
	{
		var boolflag=false;
		enableButtons(true,true,true,true,true,false);
		var varPSterms = document.forms[0].hidPSterms.value.split("@");
		for(var i=0;i<varPSterms.length;i++)
		{
			if(varPSterms[i] == "MRS"||varPSterms[i] == "SLILA")
			{
				boolflag=true;
			}
		}

		if(varRepayFlag=="Y")
		{
			boolflag=true;
		}

		if(boolflag)
		{
			if(document.forms[0].appstatus.value=="Open/Pending")
			{
				if(document.forms[0].btnenable.value.toUpperCase()=="Y")
				{
					enableButtons(false,true,true,true,true,false);
				}
				else
				{
					enableButtons(true,true,true,true,true,false);
				}
				
			}
		}
	}
}

function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6,bool7)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;
	document.forms[0].cmdannexture.disabled=bool7;

	//document.forms[0].cmdhelp.disabled=true;
}

function doNew()
{
	varFacInstall=document.forms[0].hidfacinstall.value
	if(!(varPrdType=="pG" && varRepaymentType=="14") && varFacInstall!="")
	{
		document.forms[0].sel_frequency.value = varFacInstall.toUpperCase();
	}else
	{
		document.forms[0].sel_frequency.value ="S";
	}
	disableCommandButtons("edit");
	document.forms[0].txt_totamt.readOnly = true;
	if(!(varPrdType=="pG" && varRepaymentType=="14"))
	{
		document.forms[0].sel_frequency.disabled=true;
	}
	else
	{
		document.forms[0].sel_frequency.disabled=false;
	}
	document.forms[0].hidAction.value ="insert";
	document.forms[0].txt_noofinst.disabled = false;
	document.forms[0].txt_instamt.disabled = false;
	//document.forms[0].select_facility.value="s";

	
	document.forms[0].txt_instamt.value="0.00";
}

function doEdit()
{ 	
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");
	document.forms[0].sel_frequency.disabled = true;	
	document.forms[0].txt_totamt.readOnly = true;
	document.forms[0].txt_noofinst.disabled = false;
	document.forms[0].txt_instamt.disabled = false;
}


function doSave()
{
	document.forms[0].selRepaymentFor.disabled=false;
	document.forms[0].sel_frequency.disabled = false;
	if(document.forms[0].sel_frequency.value=="S")
	{
		alert("Select Frequency");
		document.forms[0].sel_frequency.focus();
		return;
	}
	
	if(document.forms[0].txt_noofinst.value=="" || document.forms[0].txt_noofinst.value=="0" || document.forms[0].txt_noofinst.value=="0.00")
	{
		alert("Enter No. of Installments");
		document.forms[0].txt_noofinst.value="";
		document.forms[0].txt_noofinst.focus();
		return false;
	}
	if(document.forms[0].txt_instamt.value=="" || document.forms[0].txt_instamt.value=="0" || document.forms[0].txt_instamt.value=="0.00")
	{
		alert("Enter Installment Amount");
		document.forms[0].txt_instamt.value="";
		document.forms[0].txt_instamt.focus();
		return false;
	}
	var Sancamt=document.forms[0].hidFacsancamt.value;
	var Total= parseFloat(document.forms[0].hidTotalAmt.value)+parseFloat(document.forms[0].txt_totamt.value);
	var varalert="Sanction amount";
	if(document.forms[0].selRepaymentFor.value=="I")
	{
		Sancamt=document.forms[0].hidInterestAmt.value;
		varalert="Interest Amount";
	}
	if(parseFloat(Total)>parseFloat(Sancamt))
	{
		alert("Total value cannot be greater than "+varalert);
		return false;
	}

	var varvalue=parseFloat(document.forms[0].txt_noofinst.value)+eval(document.forms[0].hidNoofInstallments.value);
	if(document.forms[0].sel_frequency.value=="Q")
	{
		varvalue=eval(varvalue)*3;
		if(eval(document.forms[0].hidStaffPrincipalRepay.value)%3!=0)
		{
			document.forms[0].hidStaffPrincipalRepay.value=eval(document.forms[0].hidStaffPrincipalRepay.value)-eval(eval(document.forms[0].hidStaffPrincipalRepay.value)%3)+3;
		}
		else
		{
			document.forms[0].hidStaffPrincipalRepay.value=eval(document.forms[0].hidStaffPrincipalRepay.value);
		}
	}
	else if(document.forms[0].sel_frequency.value=="H")
	{
		varvalue=eval(varvalue)*6;
		if(eval(document.forms[0].hidStaffPrincipalRepay.value)%6!=0)
		{
			document.forms[0].hidStaffPrincipalRepay.value=eval(document.forms[0].hidStaffPrincipalRepay.value)-eval(eval(document.forms[0].hidStaffPrincipalRepay.value)%6)+6;
		}
		else
		{
			document.forms[0].hidStaffPrincipalRepay.value=eval(document.forms[0].hidStaffPrincipalRepay.value);
		}
	}
	else if(document.forms[0].sel_frequency.value=="Y")
	{
		varvalue=eval(varvalue)*12;
		if(eval(document.forms[0].hidStaffPrincipalRepay.value)%12!=0)
		{
			document.forms[0].hidStaffPrincipalRepay.value=eval(document.forms[0].hidStaffPrincipalRepay.value)-eval(eval(document.forms[0].hidStaffPrincipalRepay.value)%12)+12;
		}
		else
		{
			document.forms[0].hidStaffPrincipalRepay.value=eval(document.forms[0].hidStaffPrincipalRepay.value);
		}
	}

	if(parseFloat(varvalue)>parseFloat(document.forms[0].hidStaffPrincipalRepay.value))
	{
		alert("Total no of Installments cannot be greater than "+document.forms[0].hidStaffPrincipalRepay.value);
		return false;
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="comrepayschedule";
	document.forms[0].hidSourceUrl.value="/action/per_RepaymentSchedulenonemi.jsp";
	document.forms[0].hidBeanMethod.value="updateFacNonEMIRepayment";
	document.forms[0].hidBeanGetMethod.value="getFacNonEMIRepayment";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].selRepaymentFor.disabled=false;
		document.forms[0].hidBeanGetMethod.value="getFacNonEMIRepayment";
		document.forms[0].hidBeanId.value="comrepayschedule";
		document.forms[0].action=appURL+"action/per_RepaymentSchedulenonemi.jsp";	
		document.forms[0].submit();
	}	
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
	document.forms[0].hidAction.value="Delete";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="comrepayschedule";
	document.forms[0].hidSourceUrl.value="/action/per_RepaymentSchedulenonemi.jsp";
	document.forms[0].hidBeanMethod.value="updateFacNonEMIRepayment";
	document.forms[0].hidBeanGetMethod.value="getFacNonEMIRepayment";	
	document.forms[0].submit();
	}
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}
}


function selectValues(val1,val2,val3,val4,val5,val6,val7,val8)
{	
	document.forms[0].hidsno.value =val1;
	//document.forms[0].select_facility.value = val2;
	document.forms[0].sel_frequency.value = val3;
	document.forms[0].txt_noofinst.value = val4;
	document.forms[0].txt_instamt.value = val5;
	document.forms[0].txt_totamt.value = val6;
	document.forms[0].hidTotalAmt.value=parseFloat(document.forms[0].hidTotalAmt.value)-parseFloat(val6);
	document.forms[0].hidNoofInstallments.value=parseFloat(document.forms[0].hidNoofInstallments1.value)-parseFloat(val4);
	document.forms[0].selRepaymentFor.value=val8;
	if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
	if(appstatus=="Open/Pending")
	{
		disableCommandButtons("radioselect");
	}
	else if(appstatus=="Processed/Rejected" || appstatus=="Processed/Approved" || appstatus=="Closed/Approved" || appstatus=="Closed/Rejected")	 
	{
	 	disableCommandButtons("disableall");
	 	disableFields(true);	 	
	}
	}


	if(varAppType=="P")
	{
		var boolflag=false;
		enableButtons(true,true,true,true,true,false);
		var varPSterms = document.forms[0].hidPSterms.value.split("@");
		for(var i=0;i<varPSterms.length;i++)
		{
			if(varPSterms[i] == "MRS"||varPSterms[i] == "SLILA")
			{
				boolflag=true;
			}
		}

		if(varRepayFlag=="Y")
		{
			boolflag=true;
		}

		if(boolflag)
		{
			if(document.forms[0].appstatus.value=="Open/Pending")
			{
				if(document.forms[0].btnenable.value.toUpperCase()=="Y")
				{
					enableButtons(true,false,true,true,false,false);
				}
				else
				{
					enableButtons(true,true,true,true,true,false);
				}
				
			}
		}
	}
}

function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		enableButtons(false,true,true,true,true,true,false);
	}
	if(val=="edit")
	{	 
		enableButtons(true,true,false,false,true,true,true);
		 disableFields(false);
	}
	if(val=="radioselect")
	{	 
		enableButtons(true,false,true,false,false,true,true);
	}	  
	if(val=="disableall")
	{
		enableButtons(true,true,true,true,true,true,true);
		disableFields(true);

	}
}  
	
function disableFields(val)
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

function calltotal()
{
	var tot=0.00;
	tot=document.forms[0].txt_noofinst.value*document.forms[0].txt_instamt.value;
	document.forms[0].txt_totamt.value=tot;
}

function getValues()
{
	document.forms[0].hidBeanGetMethod.value="getFacNonEMIRepayment";
	document.forms[0].hidBeanId.value="comrepayschedule";
	document.forms[0].action=appURL+"action/per_RepaymentSchedulenonemi.jsp";	
	document.forms[0].submit();
}
function doAnnexture()
{
	var varQryString = appURL+"action/Amortization_NonEmi.jsp?hidBeanGetMethod=getFacNonEMIRepayment&hidBeanId=comrepayschedule&hidrepaymenttype=amort&hiPgDist=P&pageFrom=Nonemi&appno="+document.forms[0].appno.value;
	var title = "Amortization";
	var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 120) / 2;
	prop = prop + ",left=50,top=50";
	window.open(varQryString,title,prop);
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
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
<% String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim(); %>   
<form name="frmpri" method = "post" class="normal">
<%if(!Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>
         <table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable">
	
	<% if(strSessionModuleType.equalsIgnoreCase("DIGI")) { %>
<jsp:include page="../share/applurllinkerdigi.jsp" flush="true">
<jsp:param name="pageid" value="10" /></jsp:include>
	<tr>
		<td class="page_flow">Home -&gt; Digi Retail -&gt; Appraisal -&gt; Repayment Schedule for Non EMI</td>
	</tr>
<% } else { %>
	<tr>
		<td><jsp:include page="../share/Applurllinkper.jsp" flush="true">
			<jsp:param name="pageid" value="10" />
		</jsp:include></td>
	</tr>   
	<tr>       
  <td class="page_flow">Home -&gt; Retail  -&gt; Appraisal  -&gt;Repayment Schedule for Non EMI</td>
		</tr>
		<%} %>
  <span style="display:none;"><lapschoice:borrowertype /></span> <lapschoice:application/>
  <jsp:include page="../share/apprlinktab.jsp" flush="true">
			<jsp:param name="tabid" value="50" />
</jsp:include>
  </table>

<%} else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="10" />
			<jsp:param name="subpageid" value="" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%} %>			

<TABLE WIDTH="98%" BORDER="0" CELLSPACING="0" CELLPADDING="5"
	ALIGN="center" CLASS="outertable border1">
	<TR>
		<TD VALIGN="top">
		<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="5" CLASS="outertable">
		<tr><td class="mantatory"><b>Note : Enter all values in Rupees</b></td></tr>
			<TR>
				<TD>
				<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="1"
					CLASS="outertable border1">
					
					<TR>
						
                  <TD> 
                    <table width="100%" border="0" cellspacing="1" cellpadding="3" CLASS="outertable">
                    <%if(Helper.correctNull((String) hshValues.get("strstaffProduct")).equalsIgnoreCase("Y")){ %>
                    <tr>
                    <td colspan="2"><input type="hidden" name="selRepaymentFor" value="P"></td>
                    </tr>
                    <%}else{ %>
                    <input type="hidden" name="selRepaymentFor">
                    <%} %>
                      <tr> 
                        
                        <td width="13%" nowrap>Frequency <span class="mantatory">*</span></td>
                        <td width="30%"> 
                        <select name="sel_frequency">
                            <option value="S">--Select--</option>
                            <option value="M">Monthly</option>
                            <option value="Q">Quarterly</option>
                             <option value="H">Half Yearly</option>
                            <option value="Y">Yearly</option>
                          </select>
                        </td>
                         <td>No of Installments(Excluding Holiday Period)&nbsp;<span class="mantatory">*</span></td>
                        <td><input type="text" name="txt_noofinst"
									size="15" style="text-align: right" 
									onKeyPress="allowNumber(this)" onBlur="calltotal();"></td>
						
                      </tr>
                      <tr> 
                       <td>Installment amount &nbsp;<span class="mantatory">*</span></td>
						<td>
                          <input type="text" name="txt_instamt"
									size="15" style="text-align: right" 
									onKeyPress="allowNumber(this)" onBlur="roundtxt(this);calltotal();">
                        </td>
                         <td>
					  Total
					  </td>
					  <td>
					      <input type="text" name="txt_totamt"
									size="15" style="text-align: right" 
									onKeyPress="allowNumber(this)"  onBlur="roundtxt(this)">
                        </td>
                      </tr>
					 
					 
					 
                    </table>
                  </TD>
					</TR>
				</TABLE>
				</TD>
			</TR>
			<tr>
				<td>
	<table border="0" cellspacing="0" cellpadding="0" align="center" CLASS="outertable">
	<tr>
		<!--  <td align="center">
			<input type="button" name="Annexture" value="Annexture" class="buttonStyle"  onClick="doAnnexture();">
		 </td> -->
	</tr>
    <tr> 
      <td> 
        <lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail_Annexture' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
     </td>
    </tr>
  </table>
				
				</td>
			</tr>
			<TR>
				<TD>
				<TABLE WIDTH="80%" BORDER="0" align="center" CELLSPACING="0" CELLPADDING="1"
					CLASS="outertable border1">
					<TR>
						<TD>
						
                    <TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="2" CLASS="outertable">
                      <TR CLASS="dataheader"> 
                       <TD WIDTH="5%">&nbsp;</TD>
                        <TD WIDTH="20%" ALIGN="center">Frequency</TD>
                        <TD WIDTH="15%" ALIGN="center">No of Installments</TD>
                        <TD ALIGN="center" colspan="2">Total</TD>
                      </TR>
                      <%
							if(arrtlrec!=null)
							{
							for(int i=0;i<arrtlrec.size();i++)
								{
								arrCol=new ArrayList();
								arrCol=(ArrayList)arrtlrec.get(i);
								//out.println("arrCol"+arrCol);
								
							%>
                      <TR CLASS="datagrid"> 
                        <TD ALIGN="center"> 
                          <INPUT TYPE="radio"
									STYLE="border: none" NAME="radiobutton" VALUE="radiobutton"
									ONCLICK="javascript:selectValues(
												'<%=Helper.correctNull((String) arrCol.get(0))%>',
												'<%=Helper.correctNull((String) arrCol.get(1))%>',
												'<%=Helper.correctNull((String) arrCol.get(2))%>',
												'<%=Helper.correctNull((String) arrCol.get(3))%>',
												'<%=Helper.correctNull((String) arrCol.get(4))%>',
												'<%=Helper.correctNull((String) arrCol.get(5))%>',
												'<%=Helper.correctNull((String) arrCol.get(6))%>',
												'<%=Helper.correctNull((String) arrCol.get(7))%>')">
                        </TD>
                      
                        <%String frq=Helper.correctNull((String) arrCol.get(2));
								if(frq.equalsIgnoreCase("M"))
									frq="Monthly";
								else if(frq.equalsIgnoreCase("Y"))
									frq="Yearly";
								else if(frq.equalsIgnoreCase("Q"))
									frq="Quarterly";
								else if(frq.equalsIgnoreCase("H"))
									frq="Half Yearly";
								else
									frq="";
								%>
                        <TD align="center"><%=frq%></TD>
                            <TD align="right"><%=Helper.correctNull((String) arrCol.get(3))%></TD>
                        <TD align="right" colspan="2"><%=Helper.correctNull((String) arrCol.get(5))%></TD>
                      </TR>
                      <%
							dblTotalInstAmt+=Double.parseDouble(Helper.correctDouble((String)arrCol.get(5)));
                        dblTotalInstPeriod += Double.parseDouble(Helper.correctDouble((String)arrCol.get(3)));
                        //System.out.println("aaa="+dblTotalInstAmt);
								}
								}
							%>
                      <TR> 
                        <TD COLSPAN="3" ALIGN="right">&nbsp;</TD>
                        <TD ALIGN="right" width="15%"><b>Total</b></TD>
                        <TD ALIGN="right" width="15%"><input type="hidden" name="hidTotalAmt" value="<%=nf.format(dblTotalInstAmt)%>"><b><%=nf.format(dblTotalInstAmt)%></b></TD>
                      </TR>
                    </TABLE>
						</TD>
					</TR>
				</TABLE>
				</TD>
			</TR>
		</TABLE>
		</TD>
	</TR>
</TABLE>
<br>
<lapschoice:hiddentag pageid='<%=PageId%>' /> 
<input type="hidden" name="hid_option" value="<%=Helper.correctNull((String) hshValues.get("strOption"))%>">
<INPUT TYPE="hidden" name="strAssessment" value = "<%=request.getParameter("strAssessment")%>">
<INPUT TYPE="hidden" name="hidFacsancamt" value = "<%=strstrfacamt%>">
<INPUT TYPE="hidden" name="hidStaffLoan" value = "<%=Helper.correctNull((String) hshValues.get("strstaffProduct"))%>">
<INPUT TYPE="hidden" name="hidStaffPrincipalRepay" value = "<%=Helper.correctNull((String) hshValues.get("strMaxRepaymentperiodPrin"))%>">
<INPUT TYPE="hidden" name="hidStaffInterestRepay" value = "<%=Helper.correctNull((String) hshValues.get("strMaxRepaymentperiodIntr"))%>">
<input type="hidden" name="hidInterestAmt" value="<%=Helper.correctNull((String) hshValues.get("strInterestAmt"))%>">
<input type="hidden" name="hidNoofInstallments" value="<%=dblTotalInstPeriod%>">
<input type="hidden" name="hidNoofInstallments1" value="<%=dblTotalInstPeriod%>">
<input type="hidden" name="hidfacinstall" value="<%=Helper.correctNull((String) hshValues.get("strFacinstallment"))%>">
<input type="hidden" name="hidsno" value="">
<input type="hidden" name="hidPSterms" value="<%=Helper.correctNull((String) hshValues.get("strModifyterms"))%>">
</form>
</body>
</html>