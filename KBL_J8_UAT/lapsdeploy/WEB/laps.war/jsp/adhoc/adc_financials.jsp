<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<%
			ArrayList arr = null;
			int arrsize = 0;

			if (hshValues != null) {
				arr = (ArrayList) hshValues.get("arrVal");
			}

			if (arr != null) {
				arrsize = arr.size();

			}
			String[] strdesc = { "&nbsp;","&nbsp;","TANGIBLE NET WORTH","CURRENT RATIO","TOL/TNW RATIO","NET SALES","NPAT","CASH ACCRUALS"};
%>
<html>
<head>
<title>Proposal</title>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>ckeditor/ckeditor.js">
</script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var varRecordflag = "<%=Helper.correctNull((String)hshValues.get("recordflag"))%>";
function placeValues()
{
	disableFields(true);
}

function callCalender(val)
{
	if(document.forms[0].cmdsave.disabled==false)
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
		for(var i=0;i<document.forms[0].desc.length;i++)
		{
			document.forms[0].desc[i].readOnly=true;
		}
		
	}
function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="executive"
		document.forms[0].hidBeanGetMethod.value="getDataFinancial";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/adc_financials.jsp";
		document.forms[0].submit();
	 }
	
}
function doDelete()
{
	
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete"
	 	document.forms[0].hidBeanId.value="executive"
		document.forms[0].hidBeanMethod.value="updateFinancial";
		document.forms[0].hidBeanGetMethod.value="getDataFinancial";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/adc_financials.jsp";
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
	enableButtons(true,false,false,false,true)
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
		if(document.forms[0].txt_fourthyear[1].value!='S')
		{
			if(document.forms[0].txt_fourthyear[0].value=="")
			{
			alert("Enter the Year");
			document.forms[0].txt_fourthyear[0].focus();
			return;
			}	
		}
	
	for(var i=2;i<8;i++)
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
	
	
	for(var i=2;i<8;i++)
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
	
	
	for(var i=2;i<8;i++)
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
	for(var i=2;i<8;i++)
	{	
		if(document.forms[0].txt_fourthyear[i].value!='0.00' && document.forms[0].txt_fourthyear[i].value!='')
		{
			if(document.forms[0].txt_fourthyear[0].value=="")
			{
			alert("Enter the Year");
			document.forms[0].txt_fourthyear[0].focus();
			return;
			}	
		}
	}		
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].hidRecordflag.value = varRecordflag;
		document.forms[0].hidAction.value="update"
		document.forms[0].hidBeanId.value="executive"
		document.forms[0].hidBeanMethod.value="updateFinancial";
		document.forms[0].hidBeanGetMethod.value="getDataFinancial";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/adc_financials.jsp";
		document.forms[0].submit();
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/corppge.jsp";
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

<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>

<body onload="placeValues()">
<form name="frmcombstfinancial" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" class="outertable" cellpadding="0" >
<tr> 
      <td valign="top" > 
         <jsp:include page="../share/applurllinkscom.jsp" flush="true">         
        <jsp:param name="pageid" value="3" />
        <jsp:param name="cattype" value="<%=strCategoryType%>" />
        <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
</tr>
<tr>
      <td class="page_flow"> Home -&gt; Corporate &amp; SME  -&gt; Ad hoc Limit -&gt; Financial</td>
</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">

</table>
  <lapschoice:borrowertype /> <lapschoice:application/>
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable border1"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" class="outertable">
          <%ArrayList g1 = null;

			for (int l = 0; l < 8; l++) 
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
					{

						%>
						
						<tr> 
            <td width="20%"><input type="text" name="desc" size="30"
					value="<%=strdesc[l]%>"   style="background-color:#F2F9FF;width:100%;border:none" readOnly="readonly" ></td>
            <td width="20%" align="center"> 
              <table  border="0" class="outertable">
                <tr> 
                  <td   align="right"> 
                    <input type="text" name="txt_firstyear" size="15"
					value="<%=Helper.correctNull((String)g1.get(0))%>"  maxlength="10" style="text-align:right"
					onBlur="checkDate(this)">
                  </td>
                  <td  align="left"> <a
					alt="Select date from calender" href="#"
					onClick="callCalender('txt_firstyear[<%=l%>]')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
					alt="Select date from calender"></a></td>
                </tr>
              </table>
            </td>
            <td width="20%" align="center">
              <table  border="0" class="outertable">
                <tr> 
                  <td   align="right"> 
                    <input type="text" name="txt_secondyear" size="15"
					value="<%=Helper.correctNull((String)g1.get(1))%>"  maxlength="10" style="text-align:right"
					onBlur="checkDate(this)">
                  </td>
                  <td  align="left"> <a
					alt="Select date from calender" href="#"
					onClick="callCalender('txt_secondyear[<%=l%>]')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
					alt="Select date from calender"></a></td>
                </tr>
              </table>
            </td>
            <td width="20%" align="center">
              <table  border="0" class="outertable">
                <tr> 
                  <td   align="right"> 
                    <input type="text" name="txt_thirdyear" size="15"
					value="<%=Helper.correctNull((String)g1.get(2))%>"  maxlength="10" style="text-align:right"
					onBlur="checkDate(this)">
                  </td>
                  <td  align="left"> <a
					alt="Select date from calender" href="#"
					onClick="callCalender('txt_thirdyear[<%=l%>]')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
					alt="Select date from calender"></a></td>
				</tr>
              </table>
            </td>
			<td width="20%" align="center">
              <table  border="0" class="outertable">
                <tr> 
                  <td   align="right"> 
                    <input type="text" name="txt_fourthyear" size="15"
					value="<%=Helper.correctNull((String)g1.get(3))%>"  maxlength="10" style="text-align:right"
					onBlur="checkDate(this)">
                  </td>
                  <td  align="left"> <a
					alt="Select date from calender" href="#"
					onClick="callCalender('txt_fourthyear[<%=l%>]')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
					alt="Select date from calender"></a></td>
                </tr>
              </table>
            </td>
          </tr>
				<%}
				else if(l == 1)
				{
				%>		
		  <tr>
            <td width="20%">
              <input type="text" name="desc2" size="30"
					value="<%=strdesc[l]%>"   style="background-color:#F2F9FF;width:100%;border:none" readonly="readonly">
            </td>
            <td align="center" width="20%"><select name="txt_firstyear"  >
            <%if(Helper.correctNull((String)g1.get(0)).equalsIgnoreCase(""))
            { %>
                      <option value="" selected="selected">--Select--</option>
                      <%}else{%>
                    	    <option value="">--Select--</option>
                      <%} %>
             <%if(Helper.correctNull((String)g1.get(0)).equalsIgnoreCase("Audited"))
            { %>       	    
                      <option value="Audited" selected="selected">Audited</option>
                        <%}else{%>
                            <option value="Audited">Audited</option>
                      <%} %>
                      
                      <%if(Helper.correctNull((String)g1.get(0)).equalsIgnoreCase("Estimated"))

            { %>       	    
                        <option value="Estimated" selected="selected">Estimated</option>
                        <%}else{%>
                             <option value="Estimated">Estimated</option>
                      <%} %>
                      
                      <%if(Helper.correctNull((String)g1.get(0)).equalsIgnoreCase("Unaudited"))
            { %>       	    
                      <option value="Unaudited" selected="selected">Unaudited</option>
                        <%}else{%>
                           <option value="Unaudited">Unaudited</option>
                      <%} %>
                      
                      <%if(Helper.correctNull((String)g1.get(0)).equalsIgnoreCase("Projection"))
            { %>       	    
                       <option value="Projection" selected="selected">Projection</option>
                        <%}else{%>
                           <option value="Projection">Projection</option>
                      <%} %>
                    </select></td>
            <td align="center" width="20%"><select name="txt_secondyear"  >
                      <%if(Helper.correctNull((String)g1.get(1)).equalsIgnoreCase(""))
            { %>
                      <option value="" selected="selected">--Select--</option>
                      <%}else{%>
                    	    <option value="">--Select--</option>
                      <%} %>
             <%if(Helper.correctNull((String)g1.get(1)).equalsIgnoreCase("Audited"))
            { %>       	    
                      <option value="Audited" selected="selected">Audited</option>
                        <%}else{%>
                            <option value="Audited">Audited</option>
                      <%} %>
                      
                      <%if(Helper.correctNull((String)g1.get(1)).equalsIgnoreCase("Estimated"))
            { %>       	    
                        <option value="Estimated" selected="selected">Estimated</option>
                        <%}else{%>
                             <option value="Estimated">Estimated</option>
                      <%} %>
                      
                      <%if(Helper.correctNull((String)g1.get(1)).equalsIgnoreCase("Unaudited"))
            { %>       	    
                      <option value="Unaudited" selected="selected">Unaudited</option>
                        <%}else{%>
                           <option value="Unaudited">Unaudited</option>
                      <%} %>
                      
                      <%if(Helper.correctNull((String)g1.get(1)).equalsIgnoreCase("Projection"))
            { %>       	    
                       <option value="Projection" selected="selected">Projection</option>
                        <%}else{%>
                           <option value="Projection">Projection</option>
                      <%} %>
                    </select></td>
                    <td align="center" width="20%"><select name="txt_thirdyear"  >
                      <%if(Helper.correctNull((String)g1.get(2)).equalsIgnoreCase(""))
            { %>
                      <option value="" selected="selected">--Select--</option>
                      <%}else{%>
                    	    <option value="">--Select--</option>
                      <%} %>
             <%if(Helper.correctNull((String)g1.get(2)).equalsIgnoreCase("Audited"))
            { %>       	    
                      <option value="Audited" selected="selected">Audited</option>
                        <%}else{%>
                            <option value="Audited">Audited</option>
                      <%} %>
                      
                      <%if(Helper.correctNull((String)g1.get(2)).equalsIgnoreCase("Estimated"))
            { %>       	    
                        <option value="Estimated" selected="selected">Estimated</option>
                        <%}else{%>
                             <option value="Estimated">Estimated</option>
                      <%} %>
                      
                      <%if(Helper.correctNull((String)g1.get(2)).equalsIgnoreCase("Unaudited"))
            { %>       	    
                      <option value="Unaudited" selected="selected">Unaudited</option>
                        <%}else{%>
                           <option value="Unaudited">Unaudited</option>
                      <%} %>
                      
                      <%if(Helper.correctNull((String)g1.get(2)).equalsIgnoreCase("Projection"))
            { %>       	    
                       <option value="Projection" selected="selected">Projection</option>
                        <%}else{%>
                           <option value="Projection">Projection</option>
                      <%} %>
                    </select></td>
                    
            <td align="center" width="20%"><select name="txt_fourthyear"  >
                      <%if(Helper.correctNull((String)g1.get(3)).equalsIgnoreCase(""))
            { %>
                      <option value="" selected="selected">--Select--</option>
                      <%}else{%>
                    	    <option value="">--Select--</option>
                      <%} %>
             <%if(Helper.correctNull((String)g1.get(3)).equalsIgnoreCase("Audited"))
            { %>       	    
                      <option value="Audited" selected="selected">Audited</option>
                        <%}else{%>
                            <option value="Audited">Audited</option>
                      <%} %>
                      
                      <%if(Helper.correctNull((String)g1.get(3)).equalsIgnoreCase("Estimated"))
            { %>       	    
                        <option value="Estimated" selected="selected">Estimated</option>
                        <%}else{%>
                             <option value="Estimated">Estimated</option>
                      <%} %>
                      
                      <%if(Helper.correctNull((String)g1.get(3)).equalsIgnoreCase("Unaudited"))
            { %>       	    
                      <option value="Unaudited" selected="selected">Unaudited</option>
                        <%}else{%>
                           <option value="Unaudited">Unaudited</option>
                      <%} %>
                      
                      <%if(Helper.correctNull((String)g1.get(3)).equalsIgnoreCase("Projection"))
            { %>       	    
                       <option value="Projection" selected="selected">Projection</option>
                        <%}else{%>
                           <option value="Projection">Projection</option>
                      <%} %>
                    </select></td>
                    
          </tr>
          <%
			}
					else 
					{%>
          <tr> 
            <td width="20%"> <input type="text" name="desc" size="30"
					value="<%=strdesc[l]%>"  readOnly="readonly"></td>
            <td width="20%" align="center">
				
					<lapschoice:CurrencyTag name="txt_firstyear" size="13" maxlength='18'
								 	value='<%=Helper.correctNull((String)g1.get(0))%>'/> 
            </td>
            <td width="20%" align="center">
			<lapschoice:CurrencyTag name="txt_secondyear" size="13" maxlength='18'
								 	value='<%=Helper.correctNull((String)g1.get(1))%>'/> 
			
            </td>
            <td width="20%" align="center">
			<lapschoice:CurrencyTag name="txt_thirdyear" size="13" maxlength='18'
								 	value='<%=Helper.correctNull((String)g1.get(2))%>'/> 
			</td>
			<td width="20%" align="center">
			<lapschoice:CurrencyTag name="txt_fourthyear" size="13" maxlength='18'
								 	value='<%=Helper.correctNull((String)g1.get(3))%>'/> 
			</td>
          </tr>
          <%
				}
					} else {
					if (l == 0) {

						%>
						 <tr> 
            <td width="20%"><input type="text" name="desc" size="30"
					value="<%=strdesc[l]%>"  style="background-color:#F2F9FF;width:100%;border:none" readOnly="readonly" ></td>
            <td width="20%" align="center">
              <table  border="0" class="outertable">
                <tr> 
                  <td   align="right"> 
                    <input type="text" name="txt_firstyear" size="15"
					value=""  maxlength="10" style="text-align:right"
					onBlur="checkDate(this)">
                  </td>
                  <td  align="left"> <a
					alt="Select date from calender" href="#"
					onClick="callCalender('txt_firstyear[<%=l%>]')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
					alt="Select date from calender"></a></td>
                </tr>
              </table>
            </td>
            <td width="20%" align="center">
              <table  border="0">
                <tr> 
                  <td   align="right"> 
                    <input type="text" name="txt_secondyear" size="15"
					value=""  maxlength="10" style="text-align:right"
					onBlur="checkDate(this)">
                  </td>
                  <td  align="left"> <a
					alt="Select date from calender" href="#"
					onClick="callCalender('txt_secondyear[<%=l%>]')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
					alt="Select date from calender"></a></td>
                </tr>
              </table>
            </td>
            <td width="20%" align="center">
              <table  border="0" class="outertable">
                <tr> 
                  <td   align="right"> 
                    <input type="text" name="txt_thirdyear" size="15"
					value=""  maxlength="10" style="text-align:right"
					onBlur="checkDate(this)">
                  </td>
                  <td  align="left"> <a
					alt="Select date from calender" href="#"
					onClick="callCalender('txt_thirdyear[<%=l%>]')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
					alt="Select date from calender"></a></td>
				</tr>
				</table>
			</td>
				<td width="20%" align="center">
              <table  border="0" class="outertable">
                <tr> 
                  <td   align="right"> 
                    <input type="text" name="txt_fourthyear" size="15"
					value=""  maxlength="10" style="text-align:right"
					onBlur="checkDate(this)">
                  </td>
                  <td  align="left"> <a
					alt="Select date from calender" href="#"
					onClick="callCalender('txt_fourthyear[<%=l%>]')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
					alt="Select date from calender"></a></td>
                </tr>
              </table>
            </td>
          </tr>
						
		  <%}
		  else if(l==1){ %>
		  <tr>
            <td width="20%"><input type="text" name="desc" size="30"
					value="<%=strdesc[l]%>"   style="background-color:#F2F9FF;width:100%;border:none" readOnly="readonly"></td>
            <td align="center" width="20%"><select name="txt_firstyear"  >
                      <option value="" selected="selected">--Select--</option>
                      <option value="Audited">Audited</option>
                      <option value="Estimated">Estimated</option>
                      <option value="Unaudited">Unaudited</option>
                      <option value="Projection">Projection</option>
                    </select></td>
            <td align="center" width="20%"><select name="txt_secondyear"  >
                      <option value="" selected="selected">--Select--</option>
                      <option value="Audited">Audited</option>
                      <option value="Estimated">Estimated</option>
                      <option value="Unaudited">Unaudited</option>
                      <option value="Projection">Projection</option>
                    </select></td>
            <td align="center" width="20%"><select name="txt_thirdyear"  >
                      <option value="" selected="selected">--Select--</option>
                      <option value="Audited">Audited</option>
                      <option value="Estimated">Estimated</option>
                      <option value="Unaudited">Unaudited</option>
                      <option value="Projection">Projection</option>
                    </select></td>
                   <td align="center" width="20%"><select name="txt_fourthyear"  >
                      <option value="" selected="selected">--Select--</option>
                      <option value="Audited">Audited</option>
                      <option value="Estimated">Estimated</option>
                      <option value="Unaudited">Unaudited</option>
                      <option value="Projection">Projection</option>
                    </select></td>
          </tr>
          <%} else {

						%>
          <tr> 
            <td width="20%"><input type="text" name="desc" size="30" value="<%=strdesc[l]%>" readOnly="readonly" ></td>
            <td width="20%" align="center">
			<lapschoice:CurrencyTag name="txt_firstyear" size="13" maxlength='10'
								 	value=''/> 
			</td>
            <td width="20%" align="center"> 
						<lapschoice:CurrencyTag name="txt_secondyear" size="13" maxlength='10'
								 	value=''/> 
            </td>
            <td width="20%" align="center">
						<lapschoice:CurrencyTag name="txt_thirdyear" size="13" maxlength='10'
								 	value=''/> 
            </td>
            <td width="20%" align="center">
						<lapschoice:CurrencyTag name="txt_fourthyear" size="13" maxlength='10'
								 	value=''/> 
            </td>
          </tr>
          <%}
				}
			}

			%>
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
		<b>Comments</b>
	</td>
</tr>
<tr> 
   <td> 
     <textarea name="comments" cols="120" wrap="VIRTUAL" rows="24" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("comments"))%></textarea>
    </td>
  </tr>
</table>
<br>

		<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="sel_level" value="0"> 
</form>
</body>
<script language="javascript">
editor_generate('comments');
</script> 
</html>

