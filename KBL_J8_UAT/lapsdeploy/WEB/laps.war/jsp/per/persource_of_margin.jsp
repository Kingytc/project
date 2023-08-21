<%@include file="../share/directives.jsp"%>
<%
	java.text.NumberFormat nf=java.text.NumberFormat.getInstance();
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
	nf.setGroupingUsed(false);

String strFreeze=Helper.correctNull((String)request.getParameter("hidFreeze"));
String strCostLoan=Helper.correctNull((String)hshValues.get("COST_LOAN"));
String strTotalFund=Helper.correctNull((String)hshValues.get("PER_MARGIN_TOTAL_FUND"));
String strProductType1 = Helper.correctNull((String) hshValues.get("strProductType"));%>

<html>
<head>
<title>Personal - CoApplicant/Guarantor</title>
<script>
var amtReq="<%=Helper.correctNull((String)hshValues.get("PER_MARGIN_REQAMT"))%>";
var varstrFreeze="<%=strFreeze%>";
var varProductType="<%=strProductType1%>";
var varCostLoan="<%=strCostLoan%>";
var varTotalFund="<%=strTotalFund%>";
var totalFundValue=0.0;
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var varGvtScheme="<%=Helper.correctNull((String)hshValues.get("str_govt_scheme"))%>";
var varAHPSavings="<%=Helper.correctNull((String)hshValues.get("AHP_SAVINGS"))%>";

function gototab(beanid,methodname,pagename)
{
	if(document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidBeanId.value=beanid;
		document.forms[0].hidBeanGetMethod.value=methodname;
		document.forms[0].action=appURL+"action/"+pagename;
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}
function doEdit()
{
	calldisable(false);
	document.forms[0].cmdedit.disabled = true;
	document.forms[0].cmddelete.disabled = false;
	document.forms[0].cmdcancel.disabled = false;
	document.forms[0].cmdsave.disabled = false;
	getAHPValue();
}
function doSave()
{
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].cmdcancel.disabled=true;
	document.forms[0].hidAction.value="update";
	if(varProductType=="pP")
	{
	document.forms[0].hidBeanId.value="perapplicant";
	document.forms[0].hidBeanMethod.value="updateSourceOfMargin";
	document.forms[0].hidBeanGetMethod.value="getSourceOfMargin";
	document.forms[0].hidSourceUrl.value="/action/persource_of_margin.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
	}
	else 
	{
		
		if(varCostLoan==totalFundValue){
		document.forms[0].hidBeanId.value="perapplicant";
		document.forms[0].hidBeanMethod.value="updateSourceOfMargin";
		document.forms[0].hidBeanGetMethod.value="getSourceOfMargin";
		document.forms[0].hidSourceUrl.value="/action/persource_of_margin.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
		}
		else
		{
			alert("Cost of Project amount("+varCostLoan+") and  Source of Margin amount("+totalFundValue+") are not equal");
			document.forms[0].cmdsave.disabled=false;
			document.forms[0].cmdcancel.disabled=false;
		}
	}
}

function doDelete()
{
	
		if(ConfirmMsg(101))
		{	
			document.forms[0].hidBeanId.value="perapplicant";
			document.forms[0].hidAction.value="delete";
			document.forms[0].hidBeanMethod.value="updateSourceOfMargin";
			document.forms[0].hidBeanGetMethod.value="getSourceOfMargin";
			document.forms[0].hidSourceUrl.value="/action/persource_of_margin.jsp";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].submit();
		}
	else
	{
		
		ShowAlert(158);
	}	
		
}
function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanId.value="perapplicant";
		document.forms[0].hidBeanGetMethod.value="getSourceOfMargin";
		document.forms[0].action=appURL+"action/persource_of_margin.jsp";	
		document.forms[0].submit();
	}
}

function onloading()
{
	
	totalFunds();
	calldisable(true);
	
	//if(varstrFreeze=='Y')
	//{
		//document.forms[0].cmdedit.disabled=true;
		//document.forms[0].cmdsave.disabled=true;
	//}
	

	if(appstatus=="Open/Pending")
	{
		if(document.forms[0].btnenable.value.toUpperCase()=="Y")
		{
			document.forms[0].cmdedit.disabled = false;
			document.forms[0].cmddelete.disabled = true;
			document.forms[0].cmdcancel.disabled = true;
			document.forms[0].cmdsave.disabled = true;
		}
		else
		{
			document.forms[0].cmdedit.disabled = true;
			document.forms[0].cmddelete.disabled = true;
			document.forms[0].cmdcancel.disabled = true;
			document.forms[0].cmdsave.disabled = true;
		}
		
	}
	else
	{
		document.forms[0].cmdedit.disabled = true;
		document.forms[0].cmddelete.disabled = true;
		document.forms[0].cmdcancel.disabled = true;
		document.forms[0].cmdsave.disabled = true;
	}
	
	
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/retailpge.jsp";	
		document.forms[0].submit();
	}
}
function calldisable(val)
{
	for(i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type == "text" )
		{
			document.forms[0].elements[i].disabled = val;
		}
		if(document.forms[0].elements[i].type == "textarea" )
		{
			document.forms[0].elements[i].disabled = val;
		}
		if(document.forms[0].elements[i].type == "select-one" )
		{
			document.forms[0].elements[i].disabled = val;
		}
    }
}
function totalFunds(){
	var reqVal=0.0;
	var incuredVal=0.0;
	var savingsVal=0.0;
	var othersVal1=0.0;
	var othersVal2=0.0;
	var othersVal3=0.0;

	if(amtReq !=""){
		
		reqVal=amtReq;
	}else{
		reqVal=0.0;
	}
	if(document.forms[0].txt_costincured.value !=""){
		
		incuredVal=document.forms[0].txt_costincured.value;
	}else{
		incuredVal=0.0;
	}
	if(document.forms[0].txt_ownsavings.value !=""){
		
		savingsVal=document.forms[0].txt_ownsavings.value;
	}else{
		savingsVal=0.0;
	}
	if(document.forms[0].txt_others_value1.value !=""){
	
		othersVal1=document.forms[0].txt_others_value1.value;
	}else{

		othersVal1=0.0;
	}
	if(document.forms[0].txt_others_value2.value !=""){
	
		othersVal2=document.forms[0].txt_others_value2.value;
	}else{
		othersVal2=0.0;
	}
	if(document.forms[0].txt_others_value3.value !=""){
	
		othersVal3=document.forms[0].txt_others_value3.value;
	}else{
		othersVal3=0.0;
	}
	totalFundValue=parseFloat(reqVal) + parseFloat(incuredVal) + parseFloat(savingsVal) + parseFloat(othersVal1) + parseFloat(othersVal2) + parseFloat(othersVal3);
	document.forms[0].txt_total_fund.value=parseFloat(totalFundValue);
		
}
function getAHPValue(){
	if(varProductType=="pH")
	{
		if(varGvtScheme=="080" || varGvtScheme=="081" ){

			document.forms[0].txt_ownsavings.value=varAHPSavings;
			document.forms[0].txt_ownsavings.readOnly=true;
			totalFunds();
			
		}
			
		
	}
}
</script>
</head>
<body onload="onloading(); getAHPValue()">
<form name="appform" method="post" action="" class="normal">

      <% if(strCategoryType.equals("DIGI")){  %>
      
         <jsp:include page="../share/applurllinkerdigi.jsp" flush="true" > 
        <jsp:param name="pageid" value="1" />
        </jsp:include>
        
         <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
		 <td class="page_flow">Home -&gt; Digi Retail -&gt; Application -&gt; Loan Particulars -&gt; Source of Margin</td>
    </tr>
  </table>
      
      <lapschoice:application />
<jsp:include page="../per/applicantTabDigi.jsp" flush="true"> 
             			<jsp:param name="linkid" value="111" />
                        </jsp:include><br>
      <% } else { %>

        <jsp:include page="../share/Applurllinkper.jsp" flush="true" > 
        <jsp:param name="pageid" value="1" />
        </jsp:include>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <% if(strCategoryType.equals("AGR")){  %>
		<td class="page_flow">Home -&gt; Retail(including schematic) -&gt; Application -&gt; Loan Particulars -&gt; Co-Applicant / Guarantor</td>
		 <%}else{%> <td class="page_flow">Home -&gt; Retail(including schematic) -&gt; Application -&gt; Loan Particulars -&gt; Source of Margin</td>
	       <%} %>
    </tr>
  </table>
  <lapschoice:application />
<jsp:include page="../per/applicanttab.jsp" flush="true"> 
             			<jsp:param name="linkid" value="111" />
                        </jsp:include><br>
                        
     <% } %>                   
                        <%if(!strProductType1.equals("pP")){ %>
                        <%if(strCostLoan.equals(strTotalFund)){ %>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable" >
                        <tr align="center">
                        <td style="color:green;font:normal 12px "Trebuchet MS";">Cost of Project and Source of Margin values are equal
                        </td>
                        </tr>
                        </table>
                        <%}else {%>
                      
                        <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" >
                        <tr align="center">
                        <td style="color:red;font:normal 12px "Trebuchet MS";">Cost of Project and Source of Margin values are not equal</td>
                        </tr>
                        </table>
                        <%} }%>
                       
  <table width="98%" border="0" cellspacing="0" cellpadding="3"  align="center" class="outertable">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
          <tr> 
            <td> 
              <table width="60%" border="0" cellspacing="0" align="center" cellpadding="3" class="outertable border1 tableBg">
                <tr align="center"> 
                  <td colspan="2">
                    <table border="0" align="center" cellspacing="0" cellpadding="0"
					width="100%" class="outertable">
					<tr class="dataheader">
						<td width="5%">Sl.No</td>
						<td width="65%">Estimate of Sources</td>
						<td width="20%"><%=ApplicationParams.getCurrency()%></td>
					</tr>
					<tr>
						<td align="center" width="5%">1</td>
						<td width="65%">Loans requested from the Bank </td>
						<td width="20%"><input type="text"	name="txt_amtrequested" size="15" maxlength="12" readonly="readonly""
													value='<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("PER_MARGIN_REQAMT"))))%>' onKeyPress="allowNumber(document.forms[0].txt_amtrequested)" onBlur="roundtxt(document.forms[0].txt_amtrequested);totalFunds()" tabindex="9" style="text-align:right"></td>
					</tr>
					<tr><td>&nbsp;</td></tr>
					<tr>
						<td align="center" width="5%">2</td>
						<td width="65%">Cost already incurred</td>
						<td width="20%"><input type="text"	name="txt_costincured" size="15" maxlength="12"
													value='<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("PER_MARGIN_COSTINCURED"))))%>' onKeyPress="allowNumber(document.forms[0].txt_costincured)" onBlur="roundtxt(document.forms[0].txt_costincured);totalFunds()" tabindex="9" style="text-align:right"></td>
					</tr>
					<tr><td>&nbsp;</td></tr>
					<tr>
						<td align="center" width="5%">3</td>
						<td width="65%">Own Savings and Disposal of Investments(FD's,Shares,NSC,LICP,Provident Fund)</td>
						<td width="20%"><input type="text"	name="txt_ownsavings" size="15" maxlength="12"
													value='<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("PER_MARGIN_OWNSAVINGS"))))%>' onKeyPress="allowNumber(document.forms[0].txt_ownsavings)" onBlur="roundtxt(document.forms[0].txt_ownsavings);totalFunds()" tabindex="9" style="text-align:right"></td>
					</tr>
					<tr><td>&nbsp;</td></tr>
					<tr>
						<td align="center" width="5%">4</td>
						<td width="65%">Others (Specify)</td>
						<td width="20%">&nbsp;</td>
					</tr>
					<tr><td>&nbsp;</td></tr>
					<tr>
					<td align="center" width="5%"></td>
					<td><input type="text"	name="txt_others_desc1" size="50" maxlength="20"
													value='<%=Helper.correctNull((String)hshValues.get("PER_MARGIN_OTHERS_DESC1"))%>'  tabindex="9">
					</td>
					<td><input type="text"	name="txt_others_value1" size="15" maxlength="12"
													value='<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("PER_MARGIN_OTHERS_VALUE1"))))%>' onKeyPress="allowNumber(document.forms[0].txt_others_value1)"  onBlur="roundtxt(document.forms[0].txt_others_value1);totalFunds()" tabindex="9" style="text-align:right">
					</td>
					</tr>
					<tr><td>&nbsp;</td></tr>
					<tr>
					<td width="5%"></td>
					<td><input type="text"	name="txt_others_desc2" size="50" maxlength="20"
													value='<%=Helper.correctNull((String)hshValues.get("PER_MARGIN_OTHERS_DESC2"))%>'  tabindex="9" >
					</td>
					<td><input type="text"	name="txt_others_value2" size="15" maxlength="12"
													value='<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("PER_MARGIN_OTHERS_VALUE2"))))%>' onKeyPress="allowNumber(document.forms[0].txt_others_value2)" onBlur="roundtxt(document.forms[0].txt_others_value2);totalFunds()" tabindex="9" style="text-align:right">
					</td>
					</tr>
					<tr><td>&nbsp;</td></tr>
					<tr>
					<td width="5%"></td>
					<td><input type="text"	name="txt_others_desc3" size="50" maxlength="20"
													value='<%=Helper.correctNull((String)hshValues.get("PER_MARGIN_OTHERS_DESC3"))%>' tabindex="9">
					</td>
					<td><input type="text"	name="txt_others_value3" size="15" maxlength="12"
													value='<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("PER_MARGIN_OTHERS_VALUE3"))))%>' onKeyPress="allowNumber(document.forms[0].txt_others_value3)" onBlur="roundtxt(document.forms[0].txt_others_value3);totalFunds()" tabindex="9" style="text-align:right">
					</td>
					</tr>
					<tr><td>&nbsp;</td></tr>
					<tr>
						<td width="5%"></td>
						<td width="65%">Total Fund</td>
						<td width="20%"><input type="text"	name="txt_total_fund" size="15" maxlength="12" readonly="readonly""
													value='<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("PER_MARGIN_TOTAL_FUND"))))%>' onKeyPress="allowNumber(document.forms[0].txt_total_fund)" onBlur="roundtxt(document.forms[0].txt_total_fund)" tabindex="9" style="text-align:right"></td>
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
<lapschoice:combuttonnew btnnames='Edit _Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
  <lapschoice:hiddentag pageid='<%=PageId%>'/>
<INPUT TYPE="hidden" name="radLoan" value="Y">
<INPUT TYPE="hidden" name="hidCoDemoId" value="">
<INPUT TYPE="hidden" name="hidCreditIDCheck" value="">
<input type="hidden" name="hidCommentPage" value="C">
<input type="hidden" name="prd_type" value="<%=session.getAttribute("strProductType")%>">
<input type="hidden" name="hidAppNo" value="<%=Helper.correctNull((String)hshValues.get("strAppNo"))%>">
<iframe src="" id="ifrcoapp" style="visibility:hidden"></iframe>
</form>
</body>
</html>
 