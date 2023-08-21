<%@include file="../share/directives.jsp"%>
<%ArrayList arryRow = (ArrayList) hshValues.get("arrRow");
			ArrayList arryCol = new ArrayList();
			 	
	%>
	<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
	 <%String appnoval = Helper.correctNull((String)request.getParameter("appno"));%>
<html>
<head>
<title>Proposal</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var appstatus="<%=Helper.correctNull((String) request.getParameter("appstatus"))%>";
var Facilityid="<%=Helper.correctNull((String) hshValues.get("facilityid"))%>";
var varPostSanc="<%=Helper.correctNull((String)session.getAttribute("strAppType"))%>";
function placeValues()
{
	if(Facilityid=="")
	{
		document.forms[0].sel_facility.value ="s";
		enableButtons1(true,true,true,true,true,false);
	}
	else
	{		
		 	document.forms[0].sel_facility.value =Facilityid;
			disableFields(true);
			if(document.forms[0].btnenable.value =='Y')
		  	{

			enableButtons1(false,true,true,true,true,false);
		  	}
	}	
	disableFields(true);
	if(appstatus=="Processed/Rejected" || appstatus=="Processed/Approved" || appstatus=="Closed/Approved" || appstatus=="Closed/Rejected")	 
  	{
	enableButtons1(true,true,true,true,true,false);
  	}	
	if(document.forms[0].hidNonPoolFlag.value=="Y")
	{
		enableButtons1(true,true,true,true,true,false);
	}

	if(document.forms[0].btnenable.value=="Y")
	{
		if(varPostSanc=="P")
		{
			var boolflag=false;
			var varPSterms = document.forms[0].hidPostSancParams.value.split("@");
			for(var i=0;i<varPSterms.length;i++)
			{
				if(varPSterms[i] == "CHDCCO"||varPSterms[i] == "DCCO")
				{
					boolflag=true;
				}
				
			}
			if( document.forms[0].hidPostSancParams.value=="" && document.forms[0].sel_facility.value!="s")
			{
				boolflag=true;
			}
			if(boolflag)
			{
				enableButtons1(false,true,true,true,true,false);
			}
			else
			{
				enableButtons1(true,true,true,true,true,false);
			}
		}
	}
}


function callCalender()
{
	if(document.forms[0].hidAction.value=="insert" || document.forms[0].hidAction.value=="update")
	{
		showCal(appURL,'txt_commencementdate');
	}	
}
function callCalender1()
{
	if(document.forms[0].hidAction.value=="insert" || document.forms[0].hidAction.value=="update")
	{
		showCal(appURL,'txt_completiondate');
	}	
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
	document.forms[0].sel_facility.disabled=false;  
}
function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="executive"
		document.forms[0].hidBeanGetMethod.value="getImplnScheduleData";
		document.forms[0].action=appURL+"action/com_implnschedule.jsp"; 
		document.forms[0].submit();
	 }
	
}
function doDelete()
{
	
	if(ConfirmMsg(101))
	 {
		disableFields(false);
		document.forms[0].hidAction.value="delete"
	 	document.forms[0].hidBeanId.value="executive"
		document.forms[0].hidBeanMethod.value="updateImplnScheduleData";
		document.forms[0].hidBeanGetMethod.value="getImplnScheduleData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_implnschedule.jsp";
 		document.forms[0].submit();
	 }
	  
		
}
function enableButtons1(bool1,bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;

}
function doEdit()
{
	disableFields(false);
	enableButtons1(true,true,false,false,true);
	document.forms[0].sel_facility.disabled=true;
	document.forms[0].hidAction.value ="update";
	
}
function doSave()
{
		if(document.forms[0].sel_facility.value=="s")
		{
			alert("Please select faciliy");
			document.forms[0].sel_facility.focus();
			return;
		}	
		if(document.forms[0].txt_desc.value=="")
		{
			alert("Please Enter the Description");
			document.forms[0].txt_desc.focus();
			return;
		}
		enableButtons1(true,true,true,true,true,false);
		document.forms[0].sel_facility.disabled=false;
		//document.forms[0].hidAction.value="update"
		document.forms[0].hidBeanId.value="executive"
		document.forms[0].hidBeanMethod.value="updateImplnScheduleData";
		document.forms[0].hidBeanGetMethod.value="getImplnScheduleData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_implnschedule.jsp";
		document.forms[0].submit();


}
function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].action=appURL+"action/"+"corppge.jsp";
		document.forms[0].submit();
	}
	
}
function callLink(page,bean,method)
{

	if (document.forms[0].cmdsave.disabled)
	{
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
	}
	else
	{
		Alert(103);
	}
}

var strvalue="corp_otherinf.htm";
function doHelp()     
{
  var hlpvar = appURL+"phlp/corp_otherinf.htm";
  var title = "OtherInformation";
  var prop = "scrollbars=yes,width=600,height=450";	
  prop = prop + ",left=50,top=150";
  window.open(hlpvar,title,prop);
}
function doNew()
{
	disableFields(false);
	enableButtons1(true,true,false,false,true,false);
	
	document.forms[0].txt_desc.value="";
	document.forms[0].txt_commencementdate.value="";
	document.forms[0].txt_completiondate.value="";
	document.forms[0].txt_presentstat.value="";

	document.forms[0].hidAction.value ="insert";

}
function selectValues(val1, val2, val3, val4,val5)
{
	document.forms[0].hidsno.value=val1;
	document.forms[0].txt_desc.value=val2;
	
	document.forms[0].txt_commencementdate.value=val3;
	document.forms[0].txt_completiondate.value=val4;
	document.forms[0].txt_presentstat.value=val5;
	
	disableFields(true);

	
	document.forms[0].sel_facility.disabled=true;
	if(document.forms[0].btnenable.value=="Y")
	{
	enableButtons1(true,false,true,false,false,false);
		if(varPostSanc=="P")
		{
			var boolflag=false;
			var varPSterms = document.forms[0].hidPostSancParams.value.split("@");
			for(var i=0;i<varPSterms.length;i++)
			{
				if(varPSterms[i] == "CHDCCO"||varPSterms[i] == "DCCO")
				{
					boolflag=true;
				}
				
			}
			if( document.forms[0].hidPostSancParams.value=="" && document.forms[0].sel_facility.value!="s")
			{
				boolflag=true;
			}
			if(boolflag)
			{
				enableButtons1(false,true,true,true,true,false);
			}
			else
			{
				enableButtons1(true,true,true,true,true,false);
			}
		}
	}

}
function comparedate(date1,date2)
{	
	var pgdt=changeDateformat(date1);
	var maxdt=changeDateformat(date2);
	if(pgdt.value!="")
	{
		if(Date.parse(pgdt) > Date.parse(maxdt))
		{
			alert("Completion Date cannot be lesser than Commencement Date");
			document.forms[0].txt_completiondate.value="";
			document.forms[0].txt_completiondate.focus();								
		}			
	}
}
function getvalues()
{
	if(document.forms[0].sel_facility.value!="s")
	{
			document.forms[0].hidBeanId.value="executive"
			//document.forms[0].hidBeanMethod.value="updateImplnScheduleData";
			document.forms[0].hidBeanGetMethod.value="getImplnScheduleData";
			document.forms[0].action=appURL+"action/action/com_implnschedule.jsp"; 
			document.forms[0].submit();
			disableFields(true);
			enableButtons1(false,true,true,true,true,false);	
	}		
	else
	{
		clearFields();
		enableButtons1(true,true,true,true,false);
		disableFields(true);
		document.forms[0].hidSourceUrl.value="/action/com_implnschedule.jsp";
		document.forms[0].submit();
	}
}	
function clearFields()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].value="";		  
		}
	}		
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
	<STYLE>
DIV.cellContainer {	

  width: 100%; height: 150;
  overflow: auto;
}
</STYLE>
</head>

<body onload="placeValues()">
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
<%
if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
class="outertable">
<tr>
	<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
		<jsp:param name="pageid" value="14" />
		<jsp:param name="cattype" value="<%=strCategoryType%>" />
		<jsp:param name="ssitype" value="<%=strSSIType%>" />
	</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
	</td>
</tr>
</table>
<%}else{%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top" colSpan=5><jsp:include
			page="../com/proposallinks.jsp" flush="true">
			<jsp:param name="pageid" value="99" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />

		</jsp:include></td>
	</tr>
	<tr>
	    <%
	    String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
	    if(strSessionModuleType.equals("AGR")){%>
		<td class="page_flow">Home&nbsp;-&gt;&nbsp;Agriculture -&gt;&nbsp;Proposal&nbsp;-&gt;&nbsp;Implementation Schedule</td>
	<%}else{%>
		<td class="page_flow">Home&nbsp;-&gt;&nbsp;Corporate&nbsp; &amp; SME -&gt;&nbsp;Proposal&nbsp;-&gt;&nbsp;Implementation Schedule</td>
		<%} %>				
	</tr>
</table>
<span style="display:none"><lapschoice:borrowertype /></span><lapschoice:application />
<%} %>
<br>
	<table width="60%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center">
			<tr>
			    <td width="30%" align="center">Facility<span class="mantatory">*</span></td>
				<td width="70%" align="left">
					<SELECT NAME="sel_facility" onchange="getvalues();" TABINDEX="1" STYLE="width: 500">
						<OPTION VALUE="s" selected>--Select--</OPTION>
						<laps:TermLoanFund appno='<%=appnoval%>' />
					</SELECT>
				</td>				
			</tr>		
</table>	

<table width="100%" border="0" cellspacing="0" cellpadding="3"
	align="center" class="outertable">
	
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3"
					class="outertable">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="3"
							class="outertable border1">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="3"
									class="outertable">
									<tr class="dataheader">
									
										<td width="30%" align="center"><b>Description</b><span class="mantatory">*</span></td>
										<td width="15%" align="center"><b>Date of Commencement</b></td>
										<td width="15%" align="center"><b>Date of Completion</b></td>
										<td width="25%" align="center"><b>Present status</b></td>
										
									</tr>
							
									<tr>
									
										<td width="30%" align="center"><input type="text" name="txt_desc" size="60" onKeyPress="notAllowSingleAndDoubleQuote();notallowInteger()"
											value="" maxlength="200"></td>
										
										<td width="14%" align="center" nowrap="nowrap"><input
											type="text" name="txt_commencementdate" size="11"
											value="" maxlength="10" style="text-align: right"
											onBlur="dateDOBCheck(document.forms[0].txt_commencementdate);">
                                           <a style="vertical-align: middle"  alt="Select date from calender" href="#"
											onClick="callCalender('txt_commencementdate')"
											onMouseOver="window.status='Date Picker';return true;"
											onMouseOut="window.status='';return true;"><img
											src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
											border=0 alt="Select date from calender"></a></td>
											
											<td width="14%" align="center" nowrap="nowrap"><input
											type="text" name="txt_completiondate" size="11"
											value="" maxlength="10" style="text-align: right"
											onBlur="dateDOBCheck(document.forms[0].txt_completiondate);comparedate(document.forms[0].txt_commencementdate.value,document.forms[0].txt_completiondate.value)">
                                           <a style="vertical-align: middle"  alt="Select date from calender" href="#"
											onClick="callCalender1('txt_completiondate')"
											onMouseOver="window.status='Date Picker';return true;"
											onMouseOut="window.status='';return true;"><img
											src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
											border=0 alt="Select date from calender"></a></td>
										
										<td colspan="2" align="center" width="25%"><input
											type="text" name="txt_presentstat" size="45"
											onKeyPress="notAllowSingleAndDoubleQuote();"
											value="" maxlength="200"> </td>
									</tr>
									
								
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
		</table>
		</td>
	</tr>
</table>
<lapschoice:combuttonnew btnnames="New_Edit_Save_Delete_Cancel_Audit Trail"
	btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
	<br>
	<DIV class="cellContainer"> 
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
	<tr class="dataheader">
		<td>&nbsp;</td>
		
		<td align="center" style="width:30%;"><b>Description</b></td>
		<td align="center" style="width:16%;"><b>Date of Commencement</b></td>
		<td align="center" style="width:12%;"><b>Date of Completion</b></td>
		<td align="center"style="width:30%;"><b>Present Status</b></td>
	</tr>
	   <%
						//ArrayList arryRow=new ArrayList();
						String strSno = "";
			if(hshValues!=null)
			{
				arryRow=(ArrayList)hshValues.get("arrRow");
				
			}
			if(arryRow!=null && arryRow.size()>0)
					{
							for(int i=0;i<arryRow.size();i++)
							{
								arryCol=(ArrayList)arryRow.get(i); 
								
									
		%>
	
	<tr valign="top"  class="datagrid">
		<td width="3%"><input type="radio" name="radio_impln"
			onclick="selectValues('<%=Helper.correctNull((String)arryCol.get(5))%>',
					'<%=Helper.correctNull((String)arryCol.get(1))%>',
					'<%=Helper.correctNull((String)arryCol.get(2))%>',
						'<%=Helper.correctNull((String)arryCol.get(3))%>',
						'<%=Helper.correctNull((String)arryCol.get(4))%>')"
			style="border: none"> 
			 
		<td style="width:30%; m" ><%=Helper.correctNull((String)arryCol.get(1))%></td>
		<td style="width:16%;"><%=Helper.correctNull((String)arryCol.get(2))%></td>
		<td style="width:12%;"><%=Helper.correctNull((String)arryCol.get(3))%></td>
		<td style="width:30%;"><%=Helper.correctNull((String)arryCol.get(4))%></td>
	</tr>
	<%}}%>
	<tr class="datagrid">
	
	  <td  style="width:3%;">&nbsp;</td>
			   <td  style="width:30%;">&nbsp;</td>
			    <td  style="width:16%;">&nbsp;</td>
			   <td style="width:12%;">&nbsp;</td>
			   <td  style="width:30%;">&nbsp;</td>
 </tr>
</table>
</DIV>
<input type="hidden" name="hidsno" value="">
<input type="hidden" name="hidPostSancParams" value="<%=Helper.correctNull((String)hshValues.get("strPostSancParam"))%>">
<lapschoice:hiddentag pageid='<%=PageId%>' />
</form>
</body>
</html>

