<%@include file="../share/directives.jsp"%>
<%			ArrayList arr = null;
			int arrsize = 0;
			if (hshValues != null) {
				arr = (ArrayList) hshValues.get("arrVal");
			}
			if (arr != null) {
				arrsize = arr.size();
			}
			String[] strdesc = { "&nbsp;","&nbsp;", "Net Sales", "PAT", "TNW","CURRENT RATIO", "TOL/TNW RATIO" };
			String Valuesin=Helper.correctNull((String) request.getParameter("valuesin"));
			%>
<html>
<head>
<title>Proposal</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="Javascript1.2"><!-- // load htmlarea
_editor_url = "<%=ApplicationParams.getAppUrl()%>";                     // URL to htmlarea files
var win_ie_ver = parseFloat(navigator.appVersion.split("MSIE")[1]);
if (navigator.userAgent.indexOf('Mac')        >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Windows CE') >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Opera')      >= 0) { win_ie_ver = 0; }
if (win_ie_ver >= 5.5) {
  document.write('<scr' + 'ipt src="' +_editor_url+ 'editor.js"');
  document.write(' language="Javascript1.2"></scr' + 'ipt>');  
} else { document.write('<scr'+'ipt>function editor_generate() { return false; }</scr'+'ipt>'); }
// --></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag="<%=Helper.correctNull((String)hshValues.get("recordflag"))%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
function placeValues()
{
	disableFields(true);
}
function callCalender(val)
{
	if(document.forms[0].cmdapply.disabled==false)
	{
		 showCal(appURL,val);
	}
}
function disableFields(val)
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
			else if(document.forms[0].elements[i].type=="select-one")
			{
			 document.forms[0].elements[i].disabled=val;
			}
			else if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
		}
	}
function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="broadsancterms"
		document.forms[0].hidBeanGetMethod.value="getBroadTermsProposalFinancial";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_broadtermfin.jsp";
		document.forms[0].submit();
	 }	
}
function doDelete()
{	
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete"
	 	document.forms[0].hidBeanId.value="broadsancterms"
		document.forms[0].hidBeanMethod.value="updateBroadTermsProposalFinancial";
		document.forms[0].hidBeanGetMethod.value="getBroadTermsProposalFinancial";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_broadtermfin.jsp";
 		document.forms[0].submit();
	 }
}
function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}
function doEdit()
{
	disableFields(false);
	enableButtons(true,false,false,false,true);
}
function doSave()
{
		if(document.forms[0].txt_firstyear[1].value!='S')
		{
			if(document.forms[0].txt_firstyear[0].value=="")
			{
			alert("Enter the Year");
			document.forms[0].txt_firstyear[0].focus();
			return;
			}	
		}		
		if(document.forms[0].txt_secondyear[1].value!='S')
		{
			if(document.forms[0].txt_secondyear[0].value=="")
			{
			alert("Enter the Year");
			document.forms[0].txt_secondyear[0].focus();
			return;
			}	
		}		
		if(document.forms[0].txt_thirdyear[1].value!='S')
		{
			if(document.forms[0].txt_thirdyear[0].value=="")
			{
			alert("Enter the Year");
			document.forms[0].txt_thirdyear[0].focus();
			return;
			}	
		}	
	for(var i=2;i<6;i++)
	{	
		if(document.forms[0].txt_firstyear[i].value!='0.00' && document.forms[0].txt_firstyear[i].value!='')
		{
			if(document.forms[0].txt_firstyear[0].value=="")
			{
			alert("Enter the Year");
			document.forms[0].txt_firstyear[0].focus();
			return;
			}	
		}
	}	
	for(var i=2;i<6;i++)
	{	
		if(document.forms[0].txt_secondyear[i].value!='0.00' && document.forms[0].txt_secondyear[i].value!='')
		{
			if(document.forms[0].txt_secondyear[0].value=="")
			{
			alert("Enter the Year");
			document.forms[0].txt_secondyear[0].focus();
			return;
			}	
		}
	}	
	for(var i=2;i<6;i++)
	{	
		if(document.forms[0].txt_thirdyear[i].value!='0.00' && document.forms[0].txt_thirdyear[i].value!='')
		{
			if(document.forms[0].txt_thirdyear[0].value=="")
			{
			alert("Enter the Year");
			document.forms[0].txt_thirdyear[0].focus();
			return;
			}	
		}
	}	
	enableButtons(true,true,true,true,false);		
		document.forms[0].hidAction.value="update"
		document.forms[0].hidBeanId.value="broadsancterms"
		document.forms[0].hidBeanMethod.value="updateBroadTermsProposalFinancial";
		document.forms[0].hidBeanGetMethod.value="getBroadTermsProposalFinancial";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_broadtermfin.jsp";
		document.forms[0].submit();
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/combstpge.jsp";
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
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="placeValues()">
<form name="frmcombstfinancial" method="post" class="normal">
<lapstab:applurllinkbst pageid='5' category='bst' valuesin='<%=Valuesin%>'/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr>
<td class="page_flow">Corporate &amp; SME -&gt; Broad Terms of Proposal -&gt; Financials</td>
</tr>
</table>
<lapschoice:BST/>
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable linebor">
          <tr class="dataheader"> 
            <td width="30%">&nbsp;</td>
            <td align="center" width="23%">Year ended</td>
            <td align="center" width="24%">Year ended</td>
            <td align="center" width="23%">Year ended</td>
          </tr>         
          <%ArrayList g1 = null;
			for (int l = 0; l < 7; l++) 
			{
				int arrSize = 0;
				if (l < arrsize) 
				{
					g1 = (ArrayList) arr.get(l);
					if (g1 != null) 
					{
						arrSize = g1.size();
					}
				}
				if (arrSize > 0) 
				{
					if (l == 0) 
					{%>
						
						<tr class="datagrid"> 
            <td width="30%"><%=strdesc[l]%>
              <input type="hidden" name="hid_desc" value="<%=strdesc[l]%>">
            </td>
            <td width="23%" > 
              <table width="100%" border="0">
                <tr> 
                  <td width="72%"  align="right"> 
                    <input type="text" name="txt_firstyear" size="15"
					value="<%=Helper.correctNull((String)g1.get(0))%>"  maxlength="10" style="text-align:right"
					onBlur="checkDate(this)">
                  </td>
                  <td width="28%"> <a
					alt="Select date from calender" href="#"
					onClick="callCalender('txt_firstyear[<%=l%>]')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
					alt="Select date from calender"></a></td>
                </tr>
              </table>
            </td>
            <td width="24%" align="center">
              <table width="100%" border="0" class="outertable">
                <tr> 
                  <td width="72%"  align="right"> 
                    <input type="text" name="txt_secondyear" size="15"
					value="<%=Helper.correctNull((String)g1.get(1))%>"  maxlength="10" style="text-align:right"
					onBlur="checkDate(this)">
                  </td>
                  <td width="28%"> <a
					alt="Select date from calender" href="#"
					onClick="callCalender('txt_secondyear[<%=l%>]')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
					alt="Select date from calender">&nbsp;</a></td>
                </tr>
              </table>
            </td>
            <td width="23%" align="center">
              <table width="100%" border="0" class="outertable">
                <tr> 
                  <td width="72%"  align="right"> 
                    <input type="text" name="txt_thirdyear" size="15"
					value="<%=Helper.correctNull((String)g1.get(2))%>"  maxlength="10" style="text-align:right"
					onBlur="checkDate(this)">
                  </td>
                  <td width="28%"> <a
					alt="Select date from calender" href="#"
					onClick="callCalender('txt_thirdyear[<%=l%>]')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
					alt="Select date from calender"></a></td>
                </tr>
              </table>
            </td>
          </tr>					 
				<%}else if(l == 1){%>
		  <tr class="dataheader">
            <td width="30%"><%=strdesc[l]%>
              <input type="hidden" name="hid_desc" value="<%=strdesc[l]%>">
            </td>
            <td align="center" width="23%"><select name="txt_firstyear"  >
            <%if(Helper.correctNull((String)g1.get(0)).equalsIgnoreCase(""))
            { %>
                      <option value="" selected>--Select--</option>
                      <%}else{%>
                    	    <option value="">--Select--</option>
                      <%} %>
             <%if(Helper.correctNull((String)g1.get(0)).equalsIgnoreCase("Audited"))
            { %>       	    
                      <option value="Audited" selected>Audited</option>
                        <%}else{%>
                            <option value="Audited">Audited</option>
                      <%} %>
                      
                      <%if(Helper.correctNull((String)g1.get(0)).equalsIgnoreCase("Estimated"))
            { %>       	    
                        <option value="Estimated" selected>Estimated</option>
                        <%}else{%>
                             <option value="Estimated">Estimated</option>
                      <%} %>
                      
                      <%if(Helper.correctNull((String)g1.get(0)).equalsIgnoreCase("Unaudited"))
            { %>       	    
                      <option value="Unaudited" selected>Unaudited</option>
                        <%}else{%>
                           <option value="Unaudited">Unaudited</option>
                      <%} %>
                      
                      <%if(Helper.correctNull((String)g1.get(0)).equalsIgnoreCase("Projection"))
            { %>       	    
                       <option value="Projection" selected>Projection</option>
                        <%}else{%>
                           <option value="Projection">Projection</option>
                      <%} %>
                    </select></td>
            <td align="center" width="24%"><select name="txt_secondyear"  >
                      <%if(Helper.correctNull((String)g1.get(1)).equalsIgnoreCase(""))
            { %>
                      <option value="" selected>--Select--</option>
                      <%}else{%>
                    	    <option value="">--Select--</option>
                      <%} %>
             <%if(Helper.correctNull((String)g1.get(1)).equalsIgnoreCase("Audited"))
            { %>       	    
                      <option value="Audited" selected>Audited</option>
                        <%}else{%>
                            <option value="Audited">Audited</option>
                      <%} %>
                      
                      <%if(Helper.correctNull((String)g1.get(1)).equalsIgnoreCase("Estimated"))
            { %>       	    
                        <option value="Estimated" selected>Estimated</option>
                        <%}else{%>
                             <option value="Estimated">Estimated</option>
                      <%} %>
                      
                      <%if(Helper.correctNull((String)g1.get(1)).equalsIgnoreCase("Unaudited"))
            { %>       	    
                      <option value="Unaudited" selected>Unaudited</option>
                        <%}else{%>
                           <option value="Unaudited">Unaudited</option>
                      <%} %>
                      
                      <%if(Helper.correctNull((String)g1.get(1)).equalsIgnoreCase("Projection"))
            { %>       	    
                       <option value="Projection" selected>Projection</option>
                        <%}else{%>
                           <option value="Projection">Projection</option>
                      <%} %>
                    </select></td>
            <td align="center" width="23%"><select name="txt_thirdyear"  >
                      <%if(Helper.correctNull((String)g1.get(2)).equalsIgnoreCase(""))
            { %>
                      <option value="" selected>--Select--</option>
                      <%}else{%>
                    	    <option value="">--Select--</option>
                      <%} %>
             <%if(Helper.correctNull((String)g1.get(2)).equalsIgnoreCase("Audited"))
            { %>       	    
                      <option value="Audited" selected>Audited</option>
                        <%}else{%>
                            <option value="Audited">Audited</option>
                      <%} %>
                      
                      <%if(Helper.correctNull((String)g1.get(2)).equalsIgnoreCase("Estimated"))
            { %>       	    
                        <option value="Estimated" selected>Estimated</option>
                        <%}else{%>
                             <option value="Estimated">Estimated</option>
                      <%} %>
                      
                      <%if(Helper.correctNull((String)g1.get(2)).equalsIgnoreCase("Unaudited"))
            { %>       	    
                      <option value="Unaudited" selected>Unaudited</option>
                        <%}else{%>
                           <option value="Unaudited">Unaudited</option>
                      <%} %>
                      
                      <%if(Helper.correctNull((String)g1.get(2)).equalsIgnoreCase("Projection"))
            { %>       	    
                       <option value="Projection" selected>Projection</option>
                        <%}else{%>
                           <option value="Projection">Projection</option>
                      <%} %>
                    </select></td>
          </tr><%}else{%>
          <tr class="dataheader"> 
            <td width="30%"><%=strdesc[l]%>
              <input type="hidden" name="hid_desc" value="<%=strdesc[l]%>">
            </td>
            <td width="23%" align="center">
				
					<lapschoice:CurrencyTag name="txt_firstyear" size="13" maxlength='18'
								 	value='<%=Helper.correctNull((String)g1.get(0))%>'/> 
            </td>
            <td width="24%" align="center">
			<lapschoice:CurrencyTag name="txt_secondyear" size="13" maxlength='18'
								 	value='<%=Helper.correctNull((String)g1.get(1))%>'/> 
			
            </td>
            <td width="23%" align="center">
			<lapschoice:CurrencyTag name="txt_thirdyear" size="13" maxlength='18'
								 	value='<%=Helper.correctNull((String)g1.get(2))%>'/> 
			</td>
          </tr>
          <%}} else {if (l == 0) {%>
						 <tr class="dataheader"> 
            <td width="30%"><%=strdesc[l]%>
              <input type="hidden" name="hid_desc" value="<%=strdesc[l]%>">
            </td>
            <td width="23%" align="center">
              <table width="100%" border="0" class="outertable">
                <tr> 
                  <td width="71%"  align="right"> 
                    <input type="text" name="txt_firstyear" size="15"
					value=""  maxlength="10" style="text-align:right"
					onBlur="checkDate(this)">
                  </td>
                  <td width="29%"> <a
					alt="Select date from calender" href="#"
					onClick="callCalender('txt_firstyear[<%=l%>]')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
					alt="Select date from calender"></a></td>
                </tr>
              </table>
            </td>
            <td width="24%" align="center">
              <table width="100%" border="0" class="outertable">
                <tr> 
                  <td width="70%"  align="right"> 
                    <input type="text" name="txt_secondyear" size="15"
					value=""  maxlength="10" style="text-align:right"
					onBlur="checkDate(this)">
                  </td>
                  <td width="30%"> <a
					alt="Select date from calender" href="#"
					onClick="callCalender('txt_secondyear[<%=l%>]')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
					alt="Select date from calender"></a></td>
                </tr>
              </table>
            </td>
            <td width="23%" align="center">
              <table width="100%" border="0" class="outertable">
                <tr> 
                  <td width="71%"  align="right"> 
                    <input type="text" name="txt_thirdyear" size="15"
					value=""  maxlength="10" style="text-align:right"
					onBlur="checkDate(this)">
                  </td>
                  <td width="29%"> <a
					alt="Select date from calender" href="#"
					onClick="callCalender('txt_thirdyear[<%=l%>]')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
					alt="Select date from calender"></a></td>
                </tr>
              </table>
            </td>
          </tr>					
		  <%}else if(l==1){%>
		  <tr class="dataheader">
            <td width="30%"><%=strdesc[l]%>
              <input type="hidden" name="hid_desc" value="<%=strdesc[l]%>">
            </td>
            <td align="center" width="23%"><select name="txt_firstyear"  >
                      <option value="" selected>--Select--</option>
                      <option value="Audited">Audited</option>
                      <option value="Estimated">Estimated</option>
                      <option value="Unaudited">Unaudited</option>
                      <option value="Projection">Projection</option>
                    </select></td>
            <td align="center" width="24%"><select name="txt_secondyear"  >
                      <option value="" selected>--Select--</option>
                      <option value="Audited">Audited</option>
                      <option value="Estimated">Estimated</option>
                      <option value="Unaudited">Unaudited</option>
                      <option value="Projection">Projection</option>
                    </select></td>
            <td align="center" width="23%"><select name="txt_thirdyear"  >
                      <option value="" selected>--Select--</option>
                      <option value="Audited">Audited</option>
                      <option value="Estimated">Estimated</option>
                      <option value="Unaudited">Unaudited</option>
                      <option value="Projection">Projection</option>
                    </select></td>
          </tr>		  
          <%} else {%>
          <tr class="datagrid"> 
            <td width="30%"><%=strdesc[l]%><input type="hidden" name="hid_desc" value="<%=strdesc[l]%>"></td>
            <td width="23%" align="center">
			<lapschoice:CurrencyTag name="txt_firstyear" size="13" maxlength='10' value=''/> 
			</td>
            <td width="24%" align="center"> 
						<lapschoice:CurrencyTag name="txt_secondyear" size="13" maxlength='10' value=''/> 
            </td>
            <td width="23%" align="center">
						<lapschoice:CurrencyTag name="txt_thirdyear" size="13" maxlength='10' value=''/> 
            </td>
          </tr>
          <%}}}%>
        </table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr>
      <td>&nbsp;</td>
</tr>
<tr>
<td>
Comments
</td>
</tr>
                                <tr> 
                                    <td> 
                                      <textarea name="comments" cols="120" wrap="VIRTUAL" rows="24" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("comments"))%></textarea>
                                    </td>
                                  </tr>
                                </table>
                              
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="sel_level" value="0"> 
</form>
</body>
<script language="javascript1.2">editor_generate('comments');</script>
</html>

