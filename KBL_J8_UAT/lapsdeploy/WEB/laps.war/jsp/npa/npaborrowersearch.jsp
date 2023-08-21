<%@include file="../share/directives.jsp"%>
<%
	String strCategorytype = Helper.correctNull((String) request
			.getParameter("hidCategoryType"));
    session.removeAttribute("strExecSno");
    session.removeAttribute("strExec_Date");
    session.removeAttribute("strisGlobal");
    session.setAttribute("strExecSno",Helper.correctNull((String) hshValues
    		.get("strSno")));
    session.setAttribute("strExec_Date",Helper.correctNull((String) hshValues
    		.get("strdate")));
    if(("GlobalSearch").equalsIgnoreCase(Helper.correctNull((String) hshValues
    		.get("strGlobalSearch")))){
    	session.setAttribute("strisGlobal","Y");
    	
    }else{
    	session.setAttribute("strisGlobal","N");
    	
    }
    

%>
<html>
<head>
<title>NPA Account Search</title>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript">
</SCRIPT>
<script>

var appURL="<%=ApplicationParams.getAppUrl()%>";
var currentDate="<%=Helper.getCurrentDateTime()%>";
var RecordFlag="<%=Helper.correctNull((String) hshValues
			.get("RecordFlag"))%>";
var varSno="<%=Helper.correctNull((String) hshValues
	.get("strSno"))%>";
var varId="<%=Helper.correctNull((String) hshValues
	.get("strId"))%>";
var varSearch="<%=Helper.correctNull((String) hshValues
	.get("strSearch"))%>";
var varDate="<%=Helper.correctNull((String) hshValues
	.get("strdate"))%>";
var varGlobal="<%=Helper.correctNull((String) hshValues
		.get("strGlobalSearch"))%>";	
		
function onRadioClick()
{
	document.forms[0].txtsearch.value="";
	document.forms[0].txtsearch.readOnly=false;
	document.forms[0].txtsearch.focus();
}
function doReset()
{
	document.forms[0].reset();
	document.forms[0].txtsearch.focus();
	document.all.result.src=appURL+"action/blank.jsp";

}
function doSearch()
{
	var search;
	var moc_date;
	var exec_sno;
	
	
   if(document.forms[0].txtsearch.value=="")
	{
		alert("Enter data in any of the search criteria");
		return;
	}
   if(document.forms[0].txt_date.value=="")
   {
	   alert("Enter MOC date");
	   return; 
   } 
   for(var i=0;i<document.forms[0].radiobutton.length;i++)
	{
		
	if(document.forms[0].radiobutton[i].checked==true)
		{
		
			rdovalue=document.forms[0].radiobutton[i].value;
		}
	}
   // for searching

   if(document.forms[0].chk_search.checked==true)
   {
	   search="GlobalSearch"; 
   }
	txtsearch =  document.forms[0].txtsearch.value;
	
	hidCategoryType= document.forms[0].hidCategoryType.value;
	moc_date= document.forms[0].txt_date.value;
	exec_sno= document.forms[0].txtexecutionno.value;
	
	document.all.result.src=appURL+"action/npaborrowersearchresult.jsp?hidBeanId=borrowersearch&hidBeanGetMethod=getNPAAccountSearchData&rdovalue="+rdovalue+"&txtsearch="+txtsearch+"&hidCategoryType="+hidCategoryType+"&strSearch="+search+"&moc_date="+moc_date+"&exec_sno="+exec_sno;
		   
}
function doClose()
{
	document.forms[0].action=appURL+"action/mainnav.jsp";
	document.forms[0].submit();
}
function callCalender(val)
{
	
		 showCal(appURL,val);
	
}
function callExecutionNo(val)
{
	var search;
	 if(document.forms[0].txtsearch.value=="")
		{
			alert("Enter data in any of the search criteria");
			return;
		}
	

	   for(var i=0;i<document.forms[0].radiobutton.length;i++)
		{
			
		if(document.forms[0].radiobutton[i].checked==true)
			{
			
			document.forms[0].rdovalue.value=document.forms[0].radiobutton[i].value;
			}
		}
	   // for searching

	   if(document.forms[0].chk_search.checked==true)
	   {
		   document.forms[0].strSearch.value="GlobalSearch"; 
	   }
	   document.forms[0].hidsearch.value =  document.forms[0].txtsearch.value;		
		
	   document.forms[0].hid_date.value= document.forms[0].txt_date.value;
		
	document.forms[0].hidBeanGetMethod.value="getExecMOCDetails";
	document.forms[0].hidBeanId.value="borrowersearch";
	document.forms[0].hidSourceUrl.value="/action/npaborrowersearch.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();	
}
function onloading(){
	if(RecordFlag=='Y'){
	 document.forms[0].txtexecutionno.value=varSno;	
	 document.forms[0].txt_date.value=varDate;
	 document.forms[0].txtsearch.value=varSearch;
	 if(varId=="CBSID"){
		 document.forms[0].radiobutton[1].checked=true;
	 }else if(varId=="NAME"){
		 document.forms[0].radiobutton[0].checked=true;
	 }
	 if(varGlobal=="GlobalSearch") {
		 document.forms[0].chk_search.checked=true;
	 }
     	
	}
	document.forms[0].txtexecutionno.readOnly=true;
	document.forms[0].txt_date.readOnly=true;
	
}
</script>

<STYLE>
DIV.cellContainer {
	width: 100%;
	height: 100%;
	overflow: auto;
}
</STYLE>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading();">
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
<form name="loanHistory" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td valign="top" class="page_flow">Home -&gt; NPA - Account Details (Search)
 				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	height="400" align="center" class="outertable">
	<tr>
		<td valign="top" height="397">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			height="100%" class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="5"
					height="100%" class="outertable border1 tableBg">
					<tr>
						<td valign="top" align="left"><b>Borrower Search</b><br>
						<table width="100%" border="0" cellspacing="0" cellpadding="3"
							height="100%" class="outertable">
									<tr><td>&nbsp;</td></tr>
									<tr>
										<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="1"
											class="outertable">
											<tr>
											<td colspan="6"><input type="checkbox" name="chk_search" style="border: none;"> Global Search</td>
											</tr>
										<tr>
												<td ><input type="radio" name="radiobutton"
													value="NAME" style="border-style:none"
													tabindex="1" onClick="onRadioClick()"></td>
												<td  nowrap="nowrap">Borrower Name</td>

												
												<td ><input type="radio" name="radiobutton"
													value="CBSID" style="border-style:none"
													onClick="onRadioClick()" checked="checked"></td>
												<td nowrap="nowrap">CBS Customer ID</td>
												
												<td width="13%"><input type="text" name="txtsearch"
													size="20" maxlength="20"
													onKeyPress="notAllowSplChar();" tabindex="2"></td>
													
												<td >MOC Date:</td>
                                                   <td> 
                                                  <input type="text" name="txt_date" size="12" maxlength="10" value="" onBlur="checkDate(this);checkmaxdate(this,'<%=Helper.getCurrentDateTime()%>');callExecutionNo('txt_date');" tabindex="3">
                                                   <a
					                                alt="Select date from calender" href="#"
					                                 onClick="callCalender('txt_date')"
					                                 onMouseOver="window.status='Date Picker';return true;"
					                                 onMouseOut="window.status='';return true;">&nbsp;<img
					                                 src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
					                                  alt="Select date from calender"></a></td>	
					                                
					                                 <td >Execution Number</td>
					                                <td ><input type="text" name="txtexecutionno" ></td>
					 
												
												<td width="10%"><input type="button" name="cmdOK2"
													value="Search" class="buttonStyle" style="width:75"
													onClick="doSearch()" tabindex="3"></td>
													<td width="18%">&nbsp;</td>
											</tr>
											</table>
										</td>
									</tr>
									<tr>
										<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="3"
											align="center" class="outertable">
											<tr class="dataheader">

												<td width="33%" align="center">Borrower Name</td>
												<td width="26%" align="center">CBS Customer Id</td>
												<td width="41%" align="center">Organisation</td>
											</tr>
										</table>
										</td>
									</tr>


									<tr align="center" valign="top">
										<td><iframe id="result" src="" width="100%"
											height="240" border="no"></iframe></td>
									</tr>
									<tr align="center">
										<td colspan="6">&nbsp;</td>
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
		</td>
	</tr>
</table>

<lapschoice:combuttonnew btnnames='Reset' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />

<lapschoice:hiddentag pageid='<%=PageId%>' /> 
<input type="hidden" name="hidCategoryType" value="<%=Helper.correctNull((String) request.getParameter("hidCategoryType"))%>">
<input type="hidden" name="hidBeanMethod" value="getNPAAccountSearchData" />
<input type="hidden" name="hid_rowcount" value="" />
<input type="hidden" name="rdovalue" value="">
<input type="hidden" name="strSearch" value="" >
<input type="hidden" name="hidsearch" value="">
<input type="hidden" name="hid_date" value="" >

</form>
</body>
</html>
