<%@include file="../share/CKEditor.jsp"%>
<%@include file="../../share/directives.jsp"%>
<%
			ArrayList arr = null;
			int arrsize = 0;

			if (hshValues != null) {
				arr = (ArrayList) hshValues.get("arrVal");
			}

			if (arr != null) {
				arrsize = arr.size();

			}
			String[] strdesc = { "&nbsp;","&nbsp;", "Paid-Up Capital","Reserves & Surplus","Intangible assets","Tangible Net Worth",
			"Long Term Liabilities","Capital Employed","Net Block","Investments","Non Current Assets","Net Working Capital ",
			"Current Assets","Current Liabilities","Currnet Ratio","Debt Equity Ratio","DER(TL/TNW)","Net Sales",
			"Other Income","Profit Before Tax","Profit After Tax","Depreciation","Cash Accruals","% NP to Net Sales","% NP to TNW"
	};

			%>
<html>
<head>
<title>Proposal</title>
<script	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script><script language="javascript" src="<%=ApplicationParams.getAppUrl()%>ckeditor/ckeditor.js">
</script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>

var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
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
	}
function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="executive"
		document.forms[0].hidBeanGetMethod.value="getDataFinancial";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comsre_financial.jsp";
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
		document.forms[0].hidSourceUrl.value="/action/comsre_financial.jsp";
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
	document.forms[0].cmdsave.disabled=true;
		document.forms[0].hidAction.value="update"
		document.forms[0].hidBeanId.value="executive"
		document.forms[0].hidBeanMethod.value="updateFinancial";
		document.forms[0].hidBeanGetMethod.value="getDataFinancial";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comsre_financial.jsp";
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

<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>

<body onload="placeValues()">
<form name="frmcombstfinancial" method="post" class="normal">

	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td valign="top"> 
        <jsp:include page="../../share/applurllinkscom.jsp" flush="true">         
        <jsp:param name="pageid" value="10" />
        <jsp:param name="cattype" value="<%=strCategoryType%>" />
        <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
    </tr>
      <%if(strCategoryType.equalsIgnoreCase("SRE")){ %>
	    <tr>
			<td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Short Review/Extension  -&gt; Financial </td>
		</tr>
    <%} else if(strCategoryType.equalsIgnoreCase("STL")){ %>
		<tr>
			<td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Short Term Loan  -&gt; Financial </td>
		</tr>
	<%} %>
    </table>
    
    
  <span style="display:none;"><lapschoice:borrowertype /></span> <lapschoice:application/>
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable border1"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" class="outertable">
          <tr> 
            <td width="30%">&nbsp;</td>
            <td align="center" width="23%">Year ended</td>
            <td align="center" width="24%">Year ended</td>
            <td align="center" width="23%">Year ended</td>
			<td align="center" width="23%">Year ended</td>
          </tr>
         
          <%ArrayList g1 = null;
			int n=0;
          if(strCategoryType.equalsIgnoreCase("STL"))
          {
        	  n=25;
          }
          else
          {
        	  n=23;
          }
          
			for (int l = 0; l < n; l++) 
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
            <td width="30%"><input type="hidden" name="desc" value="<%=strdesc[l]%>"></td>
            <td width="23%" > 
              <table width="100%" border="0" class="outertable">
                <tr> 
                  <td width="72%"  align="right"> 
                    <input type="text" name="txt_firstyear" size="15"
					value="<%=Helper.correctNull((String)g1.get(0))%>"  maxlength="10" style="text-align:right"
					onBlur="checkDate(this)">
                  </td>
                  <td width="28%" align="left"> <a
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
                  <td width="28%" align="left"> <a
					alt="Select date from calender" href="#"
					onClick="callCalender('txt_secondyear[<%=l%>]')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
					alt="Select date from calender"></a></td>
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
                  <td width="28%" align="left"> <a
					alt="Select date from calender" href="#"
					onClick="callCalender('txt_thirdyear[<%=l%>]')"
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
                  <td width="72%"  align="right"> 
                    <input type="text" name="txt_fourthyear" size="15"
					value="<%=Helper.correctNull((String)g1.get(3))%>"  maxlength="10" style="text-align:right"
					onBlur="checkDate(this)">
                  </td>
                  <td width="28%" align="left"> <a
					alt="Select date from calender" href="#"
					onClick="callCalender('txt_fourthyear[<%=l%>]')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
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
            <td width="30%"><input type="hidden" name="desc" value="<%=strdesc[l]%>"></td>
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
                      <option value="u" selected>Unaudited</option>
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
				<td align="center" width="23%"><select name="txt_fourthyear"  >
                      <%if(Helper.correctNull((String)g1.get(3)).equalsIgnoreCase(""))
            { %>
                      <option value="" selected>--Select--</option>
                      <%}else{%>
                    	    <option value="">--Select--</option>
                      <%} %>
             <%if(Helper.correctNull((String)g1.get(3)).equalsIgnoreCase("Audited"))
            { %>       	    
                      <option value="Audited" selected>Audited</option>
                        <%}else{%>
                            <option value="Audited">Audited</option>
                      <%} %>
                      
                      <%if(Helper.correctNull((String)g1.get(3)).equalsIgnoreCase("Estimated"))
            { %>       	    
                        <option value="Estimated" selected>Estimated</option>
                        <%}else{%>
                             <option value="Estimated">Estimated</option>
                      <%} %>
                      
                      <%if(Helper.correctNull((String)g1.get(3)).equalsIgnoreCase("Unaudited"))
            { %>       	    
                      <option value="Unaudited" selected>Unaudited</option>
                        <%}else{%>
                           <option value="Unaudited">Unaudited</option>
                      <%} %>
                      
                      <%if(Helper.correctNull((String)g1.get(3)).equalsIgnoreCase("Projection"))
            { %>       	    
                       <option value="Projection" selected>Projection</option>
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
            <td width="30%"><input type="hidden" name="desc" value="<%=strdesc[l]%>"><%=strdesc[l]%></td>
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
			<td width="23%" align="center">
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
            <td width="30%"><input type="hidden" name="desc" value="<%=strdesc[l]%>"></td>
            <td width="23%" align="center">
              <table width="100%" border="0" class="outertable">
                <tr> 
                  <td width="71%"  align="right"> 
                    <input type="text" name="txt_firstyear" size="15"
					value=""  maxlength="10" style="text-align:right"
					onBlur="checkDate(this)">
                  </td>
                  <td width="29%" align="left"> <a
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
                  <td width="30%" align="left"> <a
					alt="Select date from calender" href="#"
					onClick="callCalender('txt_secondyear[<%=l%>]')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
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
                  <td width="29%" align="left"> <a
					alt="Select date from calender" href="#"
					onClick="callCalender('txt_thirdyear[<%=l%>]')"
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
                    <input type="text" name="txt_fourthyear" size="15"
					value=""  maxlength="10" style="text-align:right"
					onBlur="checkDate(this)">
                  </td>
                  <td width="29%" align="left"> <a
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
		  else if(l==1){%>
		  <tr>
            <td width="30%"><input type="hidden" name="desc" value="<%=strdesc[l]%>"></td>
            <td align="center" width="23%"><select name="txt_firstyear"  >
                      <option value="" selected>--Select--</option>
                      <option value="Audited">Audited</option>
                      <option value="Estimated">Estimated</option>
                      <option value="Unaudited">Unaudited</option>
                      <option value="Projection">Projection</option>
                    </select></td>
            <td align="center" width="24%"><select name="txt_secondyear"  >
                      <option value="S" selected>--Select--</option>
                      <option value="Audited">Audited</option>
                      <option value="Estimated">Estimated</option>
                      <option value="Unaudited">Unaudited</option>
                      <option value="Projection">Projection</option>
                    </select></td>
            <td align="center" width="23%"><select name="txt_thirdyear"  >
                      <option value="S" selected>--Select--</option>
                      <option value="Audited">Audited</option>
                      <option value="Estimated">Estimated</option>
                      <option value="Unaudited">Unaudited</option>
                      <option value="Projection">Projection</option>
                    </select></td>
					<td align="center" width="23%"><select name="txt_fourthyear"  >
                      <option value="S" selected>--Select--</option>
                      <option value="Audited">Audited</option>
                      <option value="Estimated">Estimated</option>
                      <option value="Unaudited">Unaudited</option>
                      <option value="Projection">Projection</option>
                    </select></td>
          
          </tr>
		  
		  
          <%} else {

						%>
          <tr> 
            <td width="30%"> <input type="hidden" name="desc" value="<%=strdesc[l]%>"><%=strdesc[l]%> </td>
            <td width="23%" align="center">
			<lapschoice:CurrencyTag name="txt_firstyear" size="13" maxlength='10'
								 	value=''/> 
			</td>
            <td width="24%" align="center"> 
						<lapschoice:CurrencyTag name="txt_secondyear" size="13" maxlength='10'
								 	value=''/> 
            </td>
            <td width="23%" align="center">
						<lapschoice:CurrencyTag name="txt_thirdyear" size="13" maxlength='10'
								 	value=''/> 
            </td>
			<td width="23%" align="center">
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
Comments
</td>
</tr>

                                  <tr> 
                                    <td> 
                                      <textarea name="comments" cols="120" wrap="VIRTUAL" rows="24"><%=Helper.correctNull((String)hshValues.get("comments"))%></textarea>
                                    </td>
                                  </tr>
                                </table>
                              
<br>

	<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="sel_level" value="0"> 
</form>
</body>
<script language="javascript1.2">
editor_generate('comments');
</script> 
</html>

