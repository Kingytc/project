<%@include file="../share/directives.jsp"%>
<%
String flag=Helper.correctNull((String)hshValues.get("flag"));
%>
<html>
<head>
<title>Executive Summary</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate="<%=Helper.getCurrentDateTime()%>";
var flag="<%=flag%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";

function callCalender(fname)
 {
 	if(document.forms[0].cmdsave.disabled==false)
 	{
	 	showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	}
 }

function callLink(page,bean,method)
{	
	document.forms[0].hidSourceUrl.value=page;
	document.forms[0].hidSourceUrl.value=page;
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	<%if(strCategoryType.equalsIgnoreCase("SRE")){%>
	 document.forms[0].hidCategoryType.value="SRE";
	 <%}else{%> 
	 document.forms[0].hidCategoryType.value="CORP"; 
	 	 <%}%>
	document.forms[0].action=appUrl+"action/"+page;
	document.forms[0].submit(); 
}

function placevalues()
{	
	disableFields(true);
	<%if(!strCategoryType.equalsIgnoreCase("SRE")){%>
	if(flag=='true')
	{
		document.forms[0].sel_foreign.value='YES'	
		document.all.foreign.style.visibility="visible";	
		document.all.foreign.style.position="relative";
	}
	else
	{
		document.forms[0].sel_foreign.value='NO'	
		document.all.foreign.style.visibility="hidden";
		document.all.foreign.style.position="absolute";
	}
	<%}%>
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
		  document.forms[0].elements[i].readOnly=val;		  
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
		  document.forms[0].elements[i].readOnly=val;		  
		}
		if(document.forms[0].elements[i].type=="select-one")
		{
		  document.forms[0].elements[i].disabled=val;		  
		}
	}
}

function doEdit()
{
	disableFields(false);
	enableButtons(true,false,false,false,false,true)
}

function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}

function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="executive";
		document.forms[0].hidBeanMethod.value="getData6";
		document.forms[0].hidBeanGetMethod.value="getData6";		
		document.forms[0].hidSourceUrl.value="/action/exec_page6.jsp";
		document.forms[0].submit();
	 }
}

function doClose()
{	
	if( ConfirmMsg(100) )
	{
		document.forms[0].method="post";
		document.forms[0].action=appUrl+"action/corppge.jsp";
		document.forms[0].submit();
	}	
}

function doSave()
{	
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidAction.value="edit";		
	document.forms[0].hidBeanId.value="executive";
	document.forms[0].hidBeanMethod.value="updateData6";
	document.forms[0].hidBeanGetMethod.value="getData6";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/exec_page6.jsp";
	document.forms[0].submit();		
}

function doDelete()
{
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanId.value="executive";
		document.forms[0].hidBeanMethod.value="updateData6";
		document.forms[0].hidBeanGetMethod.value="getData6";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/exec_page6.jsp";
		document.forms[0].submit();
	 }
}

function call_foreign()
{
	if(document.forms[0].sel_foreign.value=='YES')
	{
		document.all.foreign.style.visibility="visible";	
		document.all.foreign.style.position="relative";	
	}
	else
	{
		document.all.foreign.style.visibility="hidden";	
		document.all.foreign.style.position="absolute";	
	}
}

function checkfromtodate(fromdate,todate)
{
	if(fromdate!="" && todate.value!="")
	{
		var pagedate=fromdate;
		var pgdt=pagedate.substring(0,2);
		var pgmon=pagedate.substring(3,5);
		var pgyear=pagedate.substring(6,10);
		var pgdt=pgmon+"/"+pgdt+"/"+pgyear;
		var maxdt1=todate.value;
		var maxdt=maxdt1.substring(0,2);
		var maxmon=maxdt1.substring(3,5);
		var maxyear=maxdt1.substring(6,10);
		var maxdt=maxmon+"/"+maxdt+"/"+maxyear;
		if(Date.parse(pgdt) > Date.parse(maxdt))
		{
			alert("Date cannot be less than " +fromdate );
			todate.value="";
			todate.focus();
		}
	}
	else
	{
		alert("Enter date in both from and to date");
		todate.value="";
	}
}
</script>
</head>
<body  onload="placevalues();call_foreign()">
<form name="frmpri" method="post" class="normal">
  <%if(strCategoryType.equalsIgnoreCase("SRE")){ %>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td valign="top"> 
        <jsp:include page="../share/applurllinkscom.jsp" flush="true"> 
        <jsp:param name="pageid" value="8" />
        <jsp:param name="cattype" value="<%=strCategoryType%>" />
        <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
    </tr>
  </table>
  <%}else{ %>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top"><jsp:include page="../com/proposallinks.jsp"
			flush="true">
			<jsp:param name="pageid" value="10" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />

		</jsp:include></td>
	</tr>
	<tr>
		<td class="page_flow">
			Home -&gt; Corporate &amp; SME -&gt; Proposal -&gt; Executive Summary -&gt; Page 6
		</td>
	</tr>
</table>
  <%} %>
<span style="display:none;"><lapschoice:borrowertype /></span> 
        <lapschoice:application/> 
  
  <table width="100%" border="1" cellspacing="0" cellpadding="5" align="center" class="outertable">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td valign="top" colspan="2"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
                <tr> 
                  <td colspan="2">DETAILS OF EXCESS ALLOWED DURING THE YEAR</td>
                </tr>
                <tr> 
                  <td width="30%">No Of Occasions excesses allowed </td>
                  <td width="70%"> 
                    <input type="text" name="txt_nofoccasions" onKeyPress="allowNumber(this)" maxlength="12" value="<%=Helper.correctNull((String)hshValues.get("EXEC_NOEXCESS"))%>"  size="25" >
                  </td>
                </tr>
                <tr> 
                  <td width="30%">Maximum Excess allowed </td>
                  <td width="70%"> 
                    <input type="text" name="txt_maxexcess" onKeyPress="allowNumber(this)"  maxlength="12" value="<%=Helper.correctNull((String)hshValues.get("EXEC_MAXEXCESS"))%>" size="25">
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          
          <tr> 
            <td valign="top" colspan="2"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
              <%if(!strCategoryType.equalsIgnoreCase("SRE")){ %>
                <tr> 
                  <td width="30%" valign="top">Other exposure ,if any,including 
                    investments </td>
                  <td width="70%"> 
                    <textarea name="exec_othexposure" cols="80" rows="3" 
                    onKeyPress="textlimit(document.forms[0].exec_othexposure,250)" onKeyUp="textlimit(this,250)"><%=Helper.correctNull((String)hshValues.get("EXEC_OTHEXP"))%></textarea>
                  </td>
                </tr>
                <tr> 
                  <td width="30%" valign="top"> Other liabilities of Directors/partners[in 
                    their individual capacity] </td>
                  <td width="70%"> 
                    <textarea name="txt_othliabilities" cols="80" rows="3" 
              onKeyPress="textlimit(document.forms[0].txt_othliabilities,250)" onKeyUp="textlimit(this,250)"><%=Helper.correctNull((String)hshValues.get("EXEC_OTHLIAB"))%></textarea>
                  </td>
                </tr>
                 <%} %>
                
              </table>
            </td>
          </tr>
         
          <tr> 
            <td colspan="2">&nbsp;</td>
          </tr>
          <tr> 
            <td valign="top" colspan="2">VALUE OF ACCOUNT</td>
          </tr>
          <tr> 
            <td align="right" colspan="2">(Rs. In lacs)</td>
          </tr>
          <tr> 
            <td valign="top" colspan="2"> 
              <table width="100%" border="1" class="outertable">
                <tr> 
                  <td width="33%" rowspan="2" align="left">Advances: </td>
                  <td width="37%" colspan="2" align="center">Previous year </td>
                  <td width="30%" colspan="2" align="center">Current year </td>
                </tr>
                <tr> 
                  <td width="37%" colspan="2" align="center">From: 
                    <input type="text" name="txt_pfrom" size="11" onBlur="checkDate(this);checkmaxdate(this,currentDate)" value="<%=Helper.correctNull((String)hshValues.get("EXEC_PFROM"))%>">
                    <a alt="Select date from calender"  href="javascript:callCalender('txt_pfrom')"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a>/To: 
                    <input type="text" name="txt_pto" size="11" onBlur="checkDate(this);checkfromtodate(document.forms[0].txt_pfrom.value,this);checkmaxdate(this,currentDate)" value="<%=Helper.correctNull((String)hshValues.get("EXEC_PTO"))%>">
                    <a alt="Select date from calender"  href="javascript:callCalender('txt_pto')"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a> 
                  </td>
                  <td width="30%" colspan="2" align="center">From: 
                    <input type="text" name="txt_cfrom" size="11" onBlur="checkDate(this);checkmaxdate(this,currentDate)" value="<%=Helper.correctNull((String)hshValues.get("EXEC_CFROM"))%>" >
                    <a alt="Select date from calender"  href="javascript:callCalender('txt_cfrom')"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a> 
                    /To: 
                    <input type="text" name="txt_cto" size="11" onBlur="checkDate(this);checkfromtodate(document.forms[0].txt_cfrom.value,this);checkmaxdate(this,currentDate)" value="<%=Helper.correctNull((String)hshValues.get("EXEC_CTO"))%>">
                    <a alt="Select date from calender"  href="javascript:callCalender('txt_cto')"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0" nowrap></a> 
                  </td>
                </tr>
                <tr> 
                  <td width="33%">Interest Income </td>
                  <td width="37%" colspan="2" align="center"> <lapschoice:CurrencyTag name="txt_pintincome" size="20" 
						value='<%=Helper.correctNull((String)hshValues.get("EXEC_PINTINC"))%>' 
						maxlength="9" /> </td>
                  <td width="30%" colspan="2" align="center"> <lapschoice:CurrencyTag name="txt_cintincome" size="20" 
                      value='<%=Helper.correctNull((String)hshValues.get("EXEC_CINTINC"))%>' maxlength="9"/> 
                  </td>
                </tr>
                <tr> 
                  <td width="33%">Feebased Income </td>
                  <td width="37%" colspan="2" align="center"> <lapschoice:CurrencyTag name="txt_pfeebasedinc" size="20" 
						value='<%=Helper.correctNull((String)hshValues.get("EXEC_PFEEINC"))%>' maxlength="9"/> 
                  </td>
                  <td width="30%" colspan="2" align="center"> <lapschoice:CurrencyTag name="txt_cfeebasedinc" size="20" 
                      value='<%=Helper.correctNull((String)hshValues.get("EXEC_CFEEINC"))%>' maxlength="9"/> 
                  </td>
                </tr>
                <tr> 
                  <td rowspan="2" width="33%" align="left">Retail/Consumer/Finance(to 
                    employees associates) </td>
                  <td width="18%" align="center">No.of accounts </td>
                  <td width="19%" align="center">Amount</td>
                  <td width="15%" align="center"> No.of accounts </td>
                  <td width="15%" align="center">Amount</td>
                </tr>
                <tr> 
                  <td width="18%" align="center"> 
                    <input type="text" name="txt_pnoas" size="20" onKeyPress="allowNumber(this)" 
                      value="<%=Helper.correctNull((String)hshValues.get("EXEC_PNOACS"))%>" 
                      maxlength="9">
                  </td>
                  <td width="19%" align="center"> <lapschoice:CurrencyTag name="txt_pretailamt" size="20" 
                  	value='<%=Helper.correctNull((String)hshValues.get("EXEC_PRETAILAMT"))%>' maxlength="9"/> 
                  </td>
                  <td width="15%" align="center"> 
                    <input type="text" name="txt_cnoas" size="20" onKeyPress="allowNumber(this)" 
                     value="<%=Helper.correctNull((String)hshValues.get("EXEC_CNOACS"))%>" 
                      maxlength="9">
                  </td>
                  <td width="15%" align="center"> <lapschoice:CurrencyTag name="txt_cretailamt" size="20" 
                    value='<%=Helper.correctNull((String)hshValues.get("EXEC_CRETAILAMT"))%>' maxlength="9"/> 
                  </td>
                </tr>
                <tr> 
                  <td width="33%">Deposits</td>
                  <td width="18%" align="center">Amount </td>
                  <td width="19%" align="center">Tenor &amp; due date</td>
                  <td width="15%" align="center">Amount </td>
                  <td width="15%" align="center">Tenor &amp; due date</td>
                </tr>
                <tr> 
                  <td width="33%">-Own</td>
                  <td width="18%" align="center"> <lapschoice:CurrencyTag name="txt_poamt" size="20" 
                      value='<%=Helper.correctNull((String)hshValues.get("EXEC_POWNAMT"))%>' maxlength="9"/> 
                  </td>
                  <td width="19%" align="center"> 
                    <input type="text" name="txt_powntenordate" size="30" 
                      value="<%=Helper.correctNull((String)hshValues.get("EXEC_POWNTENORDATE"))%>" maxlength="25">
                  </td>
                  <td width="15%" align="center"> <lapschoice:CurrencyTag name="txt_coamt" size="20" 
                      value='<%=Helper.correctNull((String)hshValues.get("EXEC_COWNAMT"))%>' maxlength="9"/> 
                  </td>
                  <td width="15%" align="center"> 
                    <input type="text" name="txt_cowntenordate" size="30" 
                      value="<%=Helper.correctNull((String)hshValues.get("EXEC_COWNTENORDATE"))%>" maxlength="25">
                  </td>
                </tr>
                <tr> 
                  <td width="33%">-Third Party </td>
                  <td width="18%" align="center"> <lapschoice:CurrencyTag name="txt_poamt1" size="20" 
                      value='<%=Helper.correctNull((String)hshValues.get("EXEC_PTHIRDAMT"))%>' maxlength="9"/> 
                  </td>
                  <td width="19%" align="center"> 
                    <input type="text" name="txt_pthirdtenordate" size="30" 
                      value="<%=Helper.correctNull((String)hshValues.get("EXEC_PTHIRDTENORDATE"))%>" maxlength="25">
                  </td>
                  <td width="15%" align="center"> <lapschoice:CurrencyTag name="txt_coamt1" size="20" 
                      value='<%=Helper.correctNull((String)hshValues.get("EXEC_CTHIRDAMT"))%>' maxlength="9"/> 
                  </td>
                  <td width="15%" align="center"> 
                    <input type="text" name="txt_cthirdtenordate" size="30" 
                      value="<%=Helper.correctNull((String)hshValues.get("EXEC_CTHIRDTENORDATE"))%>" 
                      maxlength="25">
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td colspan="2">&nbsp;</td>
          </tr>
          <tr> 
          <td colspan="2">
          	 <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
          	 <tr>
		         <td width="30%"> RAROC</td>
		            <td width="70%">
		            <input type="text" name="txt_raroc" size="50" 
		                      value="<%=Helper.correctNull((String)hshValues.get("EXEC_RAROC"))%>" 
		                      maxlength="100"></td>
             </tr>
             </table>
             </td>
          </tr>
          <tr> 
            <td colspan="2">&nbsp;</td>
          </tr>
          
          <%if(!strCategoryType.equalsIgnoreCase("SRE")){ %>
          <tr> 
            <td width="50%">DETAILS OF THE FOREIGN CURRENCY EXPOSURE COMMITMENTS 
              AND UNHEDGED PORTION IF ANY  </td>
            <td width="50%"> 
              <select name="sel_foreign" onChange="call_foreign()">
                <option value="YES">YES</option>
                <option value="NO" SELECTED>NO</option>
              </select>
            </td>
          </tr>
          <tr><td colspan="2" id="foreign" style="visibility:hidden;position: absolute">
        <table >
          <tr > 
            <td valign="top" colspan="2" > 
              <table width="100%" border="1" class="outertable">
                <tr> 
                  <td align="right" colspan="5">(Amt. in USD, 000' omitted)</td>
                </tr>
                <tr> 
                  <td width="5%" align="center">Sr No </td>
                  <td width="35%" align="center">Name of the Corporate </td>
                  <td width="20%" align="center">Amount of Exposure </td>
                  <td width="20%" align="center">Unhedged portion </td>
                  <td width="20%" align="center">Due dates for payment(Range) 
                  </td>
                </tr>
                <tr> 
                  <td width="5%" align="center">1. </td>
                  <td width="35%">External Commerical Borrowings</td>
                  <td width="20%" align="center"> <lapschoice:CurrencyTag name="txt_exp1" size="18" maxlength="9" value='<%=Helper.correctNull((String)hshValues.get("EXEC_EXPAMT1"))%>' /> 
                  </td>
                  <td width="20%" align="center"> 
                    <input type="text" name="txt_unheld1" size="18" value="<%=Helper.correctNull((String)hshValues.get("EXEC_UNHEDPOS1"))%>" maxlength="20">
                  </td>
                  <td width="20%" align="center"> 
                    <textarea name="txt_duedate1" cols="40" rows="5" 
              		onKeyPress="textlimit(document.forms[0].txt_duedate1,1000)" onKeyUp="textlimit(this,1000)"><%=Helper.correctNull((String)hshValues.get("EXEC_DUEDATE1"))%></textarea>
                  </td>
                </tr>
                <tr> 
                  <td width="5%" align="center">2. </td>
                  <td width="35%">Import usance bills received on collection basis 
                    duly accepted and outstanding </td>
                  <td width="20%" align="center"> <lapschoice:CurrencyTag name="txt_exp2" size="18" maxlength="9" value='<%=Helper.correctNull((String)hshValues.get("EXEC_EXPAMT2"))%>'/> 
                  </td>
                  <td width="20%" align="center"> 
                    <input type="text" name="txt_unheld2" size="18" value="<%=Helper.correctNull((String)hshValues.get("EXEC_UNHEDPOS2"))%>" maxlength="20">
                  </td>
                  <td width="20%" align="center"> 
                    <textarea name="txt_duedate2" cols="40" rows="5" 
              		onKeyPress="textlimit(document.forms[0].txt_duedate2,1000)" onKeyUp="textlimit(this,1000)"><%=Helper.correctNull((String)hshValues.get("EXEC_DUEDATE2"))%></textarea>
                  </td>
                </tr>
                <tr> 
                  <td width="5%" align="center">3. </td>
                  <td width="35%">O/s.L/Cs &amp; PADs for import of goods/capital 
                    equipment.</td>
                  <td width="20%" align="center"> <lapschoice:CurrencyTag name="txt_exp3" size="18" maxlength="9" value='<%=Helper.correctNull((String)hshValues.get("EXEC_EXPAMT3"))%>'/> 
                  </td>
                  <td width="20%" align="center"> 
                    <input type="text" name="txt_unheld3" size="18" value="<%=Helper.correctNull((String)hshValues.get("EXEC_UNHEDPOS3"))%>" maxlength="20">
                  </td>
                  <td width="20%" align="center"> 
                    <textarea name="txt_duedate3" cols="40" rows="5" 
              		onKeyPress="textlimit(document.forms[0].txt_duedate3,1000)" onKeyUp="textlimit(this,1000)"><%=Helper.correctNull((String)hshValues.get("EXEC_DUEDATE3"))%></textarea>
                  </td>
                </tr>
                <tr> 
                  <td width="5%" align="center">4. </td>
                  <td width="35%">Outstanding in packing credit for which the 
                    corporate is committed to submit export bills</td>
                  <td width="20%" align="center"> <lapschoice:CurrencyTag name="txt_exp4" size="18" maxlength="9" value='<%=Helper.correctNull((String)hshValues.get("EXEC_EXPAMT4"))%>'/> 
                  </td>
                  <td width="20%" align="center"> 
                    <input type="text" name="txt_unheld4" size="18" maxlength="20" value="<%=Helper.correctNull((String)hshValues.get("EXEC_UNHEDPOS4"))%>">
                  </td>
                  <td width="20%" align="center"> 
                    <textarea name="txt_duedate4" cols="40" rows="5" 
              		onKeyPress="textlimit(document.forms[0].txt_duedate4,1000)" onKeyUp="textlimit(this,1000)"><%=Helper.correctNull((String)hshValues.get("EXEC_DUEDATE4"))%></textarea>
                  </td>
                </tr>
                <tr> 
                  <td width="5%" align="center">5. </td>
                  <td width="35%">Others Export Receivables</td>
                  <td width="20%" align="center"> <lapschoice:CurrencyTag name="txt_exp5" size="18" maxlength="9" value='<%=Helper.correctNull((String)hshValues.get("EXEC_EXPAMT5"))%>'/> 
                  </td>
                  <td width="20%" align="center"> 
                    <input type="text" name="txt_unheld5" size="18" value="<%=Helper.correctNull((String)hshValues.get("EXEC_UNHEDPOS5"))%>" maxlength="20">
                  </td>
                  <td width="20%" align="center"> 
                    <textarea name="txt_duedate5" cols="40" rows="5" 
              		onKeyPress="textlimit(document.forms[0].txt_duedate5,1000)" onKeyUp="textlimit(this,1000)"><%=Helper.correctNull((String)hshValues.get("EXEC_DUEDATE5"))%></textarea>
                  </td>
                </tr>
                <tr> 
                  <td width="5%" align="center">6. </td>
                  <td width="35%">Others Import Obligations</td>
                  <td width="20%" align="center"> <lapschoice:CurrencyTag name="txt_exp6" size="18" maxlength="9" value='<%=Helper.correctNull((String)hshValues.get("EXEC_EXPAMT6"))%>'/> 
                  </td>
                  <td width="20%" align="center"> 
                    <input type="text" name="txt_unheld6" size="18" maxlength="20" value="<%=Helper.correctNull((String)hshValues.get("EXEC_UNHEDPOS6"))%>">
                  </td>
                  <td width="20%" align="center"> 
                    <textarea name="txt_duedate6" cols="40" rows="5" 
              		onKeyPress="textlimit(document.forms[0].txt_duedate6,1000)" onKeyUp="textlimit(this,1000)"><%=Helper.correctNull((String)hshValues.get("EXEC_DUEDATE6"))%></textarea>
                  </td>
                </tr>
                <tr> 
                  <td width="5%" align="center">7. </td>
                  <td width="35%">Foreign currency loans availed from Authorised 
                    dealers in India</td>
                  <td width="20%" align="center"> <lapschoice:CurrencyTag name="txt_exp7" size="18" maxlength="9" value='<%=Helper.correctNull((String)hshValues.get("EXEC_EXPAMT7"))%>'/> 
                  </td>
                  <td width="20%" align="center"> 
                    <input type="text" name="txt_unheld7" size="18" maxlength="20" value="<%=Helper.correctNull((String)hshValues.get("EXEC_UNHEDPOS7"))%>">
                  </td>
                  <td width="20%" align="center"> 
                    <textarea name="txt_duedate7" cols="40" rows="5" 
              		onKeyPress="textlimit(document.forms[0].txt_duedate7,1000)" onKeyUp="textlimit(this,1000)"><%=Helper.correctNull((String)hshValues.get("EXEC_DUEDATE7"))%></textarea>
                  </td>
                </tr>
                <tr> 
                  <td width="5%" align="center">8. </td>
                  <td width="35%">Any others exposure :please specify</td>
                  <td width="20%" align="center"> <lapschoice:CurrencyTag name="txt_exp8" maxlength="9" size="18" value='<%=Helper.correctNull((String)hshValues.get("EXEC_EXPAMT8"))%>'/> 
                  </td>
                  <td width="20%" align="center"> 
                    <input type="text" name="txt_unheld8"  size="18" maxlength="20" value="<%=Helper.correctNull((String)hshValues.get("EXEC_UNHEDPOS8"))%>">
                  </td>
                  <td width="20%" align="center"> 
                    <textarea name="txt_duedate8" cols="40" rows="5" 
              		onKeyPress="textlimit(document.forms[0].txt_duedate8,1000)" onKeyUp="textlimit(this,1000)"><%=Helper.correctNull((String)hshValues.get("EXEC_DUEDATE8"))%></textarea>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
         </table> 
          </td>
          </tr>
          
          <%} %>
        </table>
      </td>
    </tr>
  </table>
 <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
    <tr> 
      <td colspan="3"></td>
    </tr>
    <tr> 
      <td width="33%">&nbsp; 
        <div align="left"> <a href="javascript:callLink('exec_page10.jsp','executive','getData10')"> 
          &lt;&lt;&nbsp; Previous</a> </div>
      </td>
      <td width="33%" align="center"> 
        <jsp:include page="../com/link1.jsp" flush="true"> 
        <jsp:param name="cattype" value="<%=strCategoryType%>" />
        <jsp:param name="tabid" value="5"/>
        </jsp:include>
        </td>
      <%if(strCategoryType.equalsIgnoreCase("SRE")){%>
      <td width="33%">&nbsp; 
        <div align="right">Pg.5/9&nbsp;<a href="javascript:callLink('comsre_othermatters.jsp','modsancterms','getModsoughtData')"> 
          Next &gt;&gt; </a> </div>
      </td>
      <%}else{ %>
      <td width="33%">&nbsp; 
        <div align="right">Pg.6/8&nbsp;<a href="javascript:callLink('exec_page9.jsp','executive','getData9')"> 
          Next &gt;&gt; </a> </div>
      </td>
      <%} %>
    </tr>
  </table>
  <lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>



