<%@ include file="../share/directives.jsp"%>
<%String IncomeFlag = Helper.correctNull((String)session.getAttribute("IncomeFlag"));%>
<%ArrayList arrRow=new ArrayList();
	ArrayList arrCol=new ArrayList();
	if(hshValues!=null&&hshValues.size()>0)
	{
		arrRow=(ArrayList)hshValues.get("arrRelRow");
	}
	%>
<html>
<head>
<title>Setup(Products - Interest)</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/set/prdInterest.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<script language="JavaScript">
var val = "<%=request.getParameter("val")%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";

function opendisfixed(num,field)
{
	if (document.forms[0].cmdedit.disabled == true)
	{
	  var purl = appURL+"action/fixedselect.jsp?val=fixedselect&num="+num+"&prd_inttype="+field+"&identity=floating";
	  var prop = "scrollbars=no,width=450,height=360";	
	  var title = "InterestRate";
	  var xpos = (screen.width - 350) / 2;
	  var ypos = (screen.height - 320) / 2;
	  prop = prop + ",left="+xpos+",top="+ypos;
      window.open(purl,title,prop);
	}
	else
	{
	  alert("Click Edit/New To change");
	}
	
}

function checkAge()
{
	if(parseInt(trim(document.forms[0].prd_selfretireage.value)) >=  '100'){
		alert("Retirement Age (Self Employed) should be less than 100");
		document.forms[0].prd_selfretireage.value="";
		document.forms[0].prd_selfretireage.focus();
	}
}
function callOtherTab1(url)
{
	if(!document.forms[0].cmdsave.disabled)
	{
		ShowAlert(103);
	}
	else
	{
		document.forms[0].hidBeanId.value="setinterest";
		document.forms[0].hidBeanGetMethod.value="getSpecificEligiblity";
		document.forms[0].action=appUrl+"action/"+url;
		document.forms[0].submit();
	}
}

function setrelation()
{
	var select=document.getElementById("multiselectId");
	<%if(arrRow!=null && arrRow.size()>0){
		for(int i=0;i<arrRow.size();i++){
			arrCol=new ArrayList();
			arrCol=(ArrayList)arrRow.get(i);%>
	var varvalue="<%=Helper.correctNull((String)arrCol.get(0))%>";
			for(var j=0;j<select.options.length;j++)
			{
				if(select.options[j].value== varvalue)
				{
					select.options[j].selected ="selected";
				}
			}
	<%}}%>
}
function funApplicant()
{

	document.forms[0].sel_incjoinapplicant.value ="<%=Helper.correctNull((String)hshValues.get("prd_JointApplicant"))%>";
	document.forms[0].sel_coobligantincome.value  ="<%=Helper.correctNull((String)hshValues.get("prd_CoObligant"))%>";
	document.forms[0].sel_guarantorincome.value  ="<%=Helper.correctNull((String)hshValues.get("prd_Guarantor"))%>";
    document.forms[0].sel_soleproperiterincome.value="<%=Helper.correctNull((String)hshValues.get("prd_sole_properiter"))%>";
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="callonload();loadUsedApp();setrelation();funApplicant()">
<form name="prdinterestfrm" method="post" action="<%=ApplicationParams.getAppUrl()%>controllerservlet" class="normal">  
<lapstab:setproductstab tabid="9" prdtype='<%=Helper.correctNull((String)request.getParameter("hidProductType"))%>'/>  
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
  <tr> 
    <td class="page_flow">Home -&gt; Setup -&gt; Retail &amp; Agriculture Products -&gt; Products -&gt; Repayment Capacity -&gt; Eligibility Parameters </td>
  </tr>
</table><br>
              <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                <tr> 
                  <td> <fieldset> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                      <tr> 
                        <td> <lapschoice:products/> </td>
                      </tr>
                    </table>
                    </fieldset> 
                    </td>
                    </tr>
                    </table><br>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">                    
                      <tr> 
                        <td> 
                          <table width="60%" border="0" cellspacing="1" cellpadding="3" class="outertable">
									<tr>
										<td align="center" class="sub_tab_inactive"><b><a href="JavaScript:callOtherTab('prodrepaycapacity.jsp')">Repayment Capacity</a></b></td>
										<td align="center" class="sub_tab_inactive"><a href="JavaScript:callOtherTab('prodCollateralSecurity.jsp')"><b>Collateral Security</b></a></td>
										<td align="center" class="sub_tab_active"><b>Eligibility Parameters</b></td>
										<td align="center" class="sub_tab_inactive"><a href="JavaScript:callOtherTab1('prodspeceligible.jsp')"><b>Specific Eligibility Parameters</b></a></td>
									</tr>
							</table>
                        </td>
                      </tr>
                      </table><br>
                      <table width="100%" border="1" cellspacing="0" cellpadding="5" class="outertable">
                            <tr> 
                              <td>
                          <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
                            <tr> 
                              <td>Max. Limit for Loan (Employed)</td>
                              <td colspan="2"> 
                                <input type="text" name="prd_collpass" size="8" onKeyPress="allowNumber(this)"  
                                value="<%=Helper.correctNull((String)hshValues.get("prd_collpass"))%>" 
                                onBlur="" maxlength="2" style="text-align:left" tabindex="2">
                                <%if(IncomeFlag.equalsIgnoreCase("0") || IncomeFlag.equalsIgnoreCase("2")){%>
                                times of Gross Annual Income<%}else if(IncomeFlag.equalsIgnoreCase("1")){%>
                                times of Net Monthly Income<%} %></td>
                              <td> Max. Limit for Loan (Self Employed)</td>
                              <td> 
                                <input type="text" name="prd_liqpass" size="8" 
                                value="<%=Helper.correctNull((String)hshValues.get("prd_liqpass"))%>" 
                                onKeyPress="allowNumber(this)" onBlur="" maxlength="2" style="text-align:left" tabindex="3">
                                <%if(IncomeFlag.equalsIgnoreCase("0") || IncomeFlag.equalsIgnoreCase("2")){%>
                                times of Gross Annual Income<%}else if(IncomeFlag.equalsIgnoreCase("1")){%>
                                times of Net Annual Income<%} %>
                                </td>
                            </tr>                            
                            <%if(IncomeFlag.equalsIgnoreCase("2")){%>
                            <tr> 
                              <td>Max. Limit for Loan (Employed)</td>
                              <td colspan="2"> 
                                <input type="text" name="prd_netemp" size="8" onKeyPress="allowNumber(this)"  
                                value="<%=Helper.correctNull((String)hshValues.get("prd_netemp"))%>" onBlur="" 
                                maxlength="2" style="text-align:left" tabindex="2">
                                times of Net Monthly Income </td>
                              <td> Max. Limit for Loan (Self Employed)</td>
                              <td> 
                                <input type="text" name="prd_netselfemp" size="8" 
                                value="<%=Helper.correctNull((String)hshValues.get("prd_netselfemp"))%>" 
                                onKeyPress="allowNumber(this)" onBlur="" maxlength="2" style="text-align:left" tabindex="3">
                                times of Net Annual Income</td>
                            </tr>
                            <%} %>
                            <tr>
                              <td>Minimum Completed Age for Applicant(s)</td>
                              <td colspan="2"> 
                                <input type="text" name="prd_appminage" size="8" onBlur=""
								value="<%=Helper.correctNull((String)hshValues.get("prd_appminage"))%>" 
								maxlength="2"  tabindex="6"> Years </td>
								<!--<td>Eligible loan limit for the assessment based on cost<b><span class="mantatory">*&nbsp;</span></b></td>
								<td>
								<input type="text" name="txtprd_loanlimit" size="8"
									value="<%=Helper.correctDouble((String)hshValues.get("prd_loanlimit"))%>"   
									maxlength="6"   tabindex="7" onKeyPress="allowDecimals(this);" onBlur="checkPercentage(this);"> %
								</td>
                            -->
                            </tr>
                            <tr> 
                             
                              <td>Max. Permissible age for salaried</td>
                              <td colspan="2"> 
                                <input type="text" name="prd_selfretireage" size="8"
								value="<%=Helper.correctNull((String)hshValues.get("prd_selfretireage"))%>"   
								maxlength="2"   tabindex="9" onkeypress="allowInteger();" onBlur = "checkAge();">
                                Years</td>
                                 <td>Max. Permissible age for other than salaried</td>
                              <td > 
                                <input type="text" name="prd_empretireage" size="8" onBlur="checkRetirementAge(this);"
								value="<%=Helper.correctNull((String)hshValues.get("prd_empretireage"))%>" 
								maxlength="2"  tabindex="8"> Years </td>
                            </tr>
                            <tr>
								<td>Prepayment Charge for Fixed Interest Rate</td>
								<td colspan="2">
									<input type="text" name="txtprd_prepayfixed" value="<%=Helper.correctDouble((String)hshValues.get("prd_prepayfixed"))%>"
									onKeyPress="allowDecimals(this);" size="15" maxlength="10" tabindex="10" onBlur="roundtxt(this);" style="text-align: right">
								</td>
								<td>Prepayment Charge for Floating Interest Rate</td>
								<td>
									<input type="text" name="txtprd_prepayfloating" value="<%=Helper.correctDouble((String)hshValues.get("prd_prepayfloating"))%>"
									onKeyPress="allowDecimals(this);" size="15" maxlength="10" tabindex="11" onBlur="roundtxt(this);" style="text-align: right">
								</td>
							</tr>
							<tr>
								<td>Minimum Monthly income for salaried (Resident)</td>
								<td colspan="2">
									<input type="text" name="txtprd_salincres" value="<%=Helper.correctDouble((String)hshValues.get("prd_salincres"))%>"
									onKeyPress="allowDecimals(this);" size="15" maxlength="10" tabindex="12" onBlur="roundtxt(this);" style="text-align: right">
								</td>
								<td>Minimum Monthly income for salaried (NRI)</td>
								<td>
									<input type="text" name="txtprd_salincnri" value="<%=Helper.correctDouble((String)hshValues.get("prd_salincnri"))%>"
									onKeyPress="allowDecimals(this);" size="15" maxlength="10" tabindex="13" onBlur="roundtxt(this);" style="text-align: right">
								</td>
							</tr>
							<tr>
								<td>Minimum Annual income for other than salaried (Resident)</td>
								<td colspan="2">
									<input type="text" name="txtprd_nonsalincres" value="<%=Helper.correctDouble((String)hshValues.get("prd_nonsalincres"))%>"
									onKeyPress="allowDecimals(this);" size="15" maxlength="10" tabindex="14" onBlur="roundtxt(this);" style="text-align: right">
								</td>
								<td>Minimum Annual income for other than salaried (NRI)</td>
								<td>
									<input type="text" name="txtprd_nonsalincnri" value="<%=Helper.correctDouble((String)hshValues.get("prd_nonsalincnri"))%>"
									onKeyPress="allowDecimals(this);" size="15" maxlength="10" tabindex="15" onBlur="roundtxt(this);" style="text-align: right">
								</td>
							</tr>
							<tr>
								<td>Upfront Fee</td>
								<td colspan="2">
									<input type="text" name="txtprd_upfrontfee" value="<%=Helper.correctDouble((String)hshValues.get("prd_upfrontfee"))%>"
									onKeyPress="allowDecimals(this);" size="15" maxlength="10" tabindex="16" onBlur="roundtxt(this);" style="text-align: right">
								</td>
								<td>Loan Period for Take over loan</td>
								<td>
									<input type="text" name="txtprd_takeoverloan" value="<%=Helper.correctNull((String)hshValues.get("prd_takeoverloan"))%>"
									onKeyPress="allowInteger();"  size="8" maxlength="3" tabindex="17">
								</td>
                            </tr>
             
						  <tr>
                           <td>Include Joint Applicant Income   for Eligibility</td>
                         
	                           <td colspan="2"><select name="sel_incjoinapplicant" >
	                            <option value="">---Select---</option>
	                            <option value="1">No</option>
	                            <option value="2">Yes</option>
	                            </select></td>
                          
                           <td>Include Co-Obligant Income   for Eligibility</td>
                         
		                        <td ><select name="sel_coobligantincome" >
		                         <option value="">---Select---</option>
		                            <option value="1">No</option>
		                            <option value="2">Yes</option>
		                          </select></td>
                      	</tr>  
                      	 <tr>
                      	   <td>Include Guarantor Income   for Eligibility</td>
                         
	                           <td colspan="2"><select name="sel_guarantorincome" >
	                            <option value="">---Select---</option>
	                            <option value="1">No</option>
	                            <option value="2">Yes</option>
	                            </select></td>
	                            
	                            <td>Include Sole Properitier  for Eligibility</td>
	                            <td><select name="sel_soleproperiterincome" >
	                            <option value="">---Select---</option>
	                            <option value="1">No</option>
	                            <option value="2">Yes</option>
	                            </select></td>
	                        </tr>
							<tr>
                            <td>Relationship to be added as Guarantor/ Co-Obligant/ Joint Applicant</td>
                            <td>
                            <select id="multiselectId"  multiple size="3">
                            	<lapschoice:CBSStaticDataNewTag apptype="32" />
                            </select>
                            </td>
                            </tr>
                        </table>
                        </td>
                      </tr>
                    </table>
<br>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
  <lapschoice:hiddentag pageid='<%=PageId%>'/>
  <input type=hidden name="hidSeldInsti" value="">
  <input type=hidden name="hidselrelation" value="">
  <input type="hidden" name="checkApp" value="<%=request.getParameter("checkApp")%>">
  <input type="hidden" name="prd_code" value="<%=request.getParameter("prdCode")%>">
  <input type="hidden" name="hidProductType" value="<%=Helper.correctNull((String)request.getParameter("hidProductType"))%>">
  <input type="hidden" name="txtprd_loanlimit">
</form>
</body>
</html>
  




