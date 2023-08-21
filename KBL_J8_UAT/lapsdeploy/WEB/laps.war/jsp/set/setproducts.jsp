<%@ include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
	String IncomeFlag = Helper.correctNull((String) hshValues.get("prd_incomeflag"));
	session.setAttribute("IncomeFlag", IncomeFlag);
	java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
	nf.setMinimumFractionDigits(2);
	nf.setMaximumFractionDigits(2);
	nf.setGroupingUsed(false);
	
	ArrayList arrRow=new ArrayList();
	ArrayList arrCol=new ArrayList();
	
	int size=0;
	int sizeNew=1;
	
	if(hshValues!=null)
	{
		arrRow=(ArrayList)hshValues.get("arrRow");
		if(arrRow!=null)
		{
		size=size+arrRow.size();
		sizeNew=sizeNew+size;
		}
		
	}
session.setAttribute("strmaxresttenure",Helper.correctNull((String)hshValues.get("PRD_TERM_REST")));
	
	%>
<html>
<head>
<title>Setup(Products)</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/set/setproducts.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var strprd_code="<%=Helper.correctNull((String) hshValues.get("prd_code"))%>";
var strprd_type="<%=hshValues.get("prd_type")%>";
var strprd_stop="<%=hshValues.get("prd_stop")%>";
var strsec_unsecfl="<%=hshValues.get("sec_unsecfl")%>";
var strint_tenorfl="<%=hshValues.get("int_tenorfl")%>";
var strint_amtfl="<%=hshValues.get("int_amtfl")%>";
var strrepay_schefl="<%=hshValues.get("repay_schefl")%>";
var curDate="<%=Helper.getCurrentDateTime()%>";
var prd_choose = "<%=request.getParameter("prd_choose")%>";
var val = '<%=request.getParameter("val")%>';  
var terms_id = '<%=hshValues.get("terms_id")%>';
var buss_id = '<%=hshValues.get("buss_id")%>';  
var strloantype= '<%=hshValues.get("prd_loantype")%>';
var varprd_loan_type = '<%=Helper.correctNull((String) hshValues.get("prd_loan_type"))%>';  
var strscheme_code= '<%=Helper.correctNull((String) hshValues.get("scheme_code"))%>';
var strincomeflag= '<%=Helper.correctNull((String) hshValues.get("prd_incomeflag"))%>';
var strnsccheck= '<%=Helper.correctNull((String) hshValues.get("nscloan_check"))%>';
var strStaffloancheck= '<%=Helper.correctNull((String) hshValues.get("staffproduct_check"))%>';
var strhomepluscheck= '<%=Helper.correctNull((String) hshValues.get("homeplus_check"))%>';
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varselinternet="<%=Helper.correctNull((String) hshValues.get("prd_internet"))%>";
var strSchemeType="<%=Helper.correctNull((String) hshValues.get("prd_schemetype"))%>";
var strWhetherAgri="<%=Helper.correctNull((String) hshValues.get("prd_whetheragri"))%>";
var sel_bankscheme_name = '<%=Helper.correctNull((String) hshValues.get("prd_bankscheme"))%>'; 
var sel_intrate='<%=Helper.correctNull((String) hshValues.get("prd_intrate"))%>';
var varpurpose = '<%=Helper.correctNull((String) hshValues.get("prd_purpose"))%>';
var staff_under = '<%=Helper.correctNull((String) hshValues.get("staff_under"))%>';
var buss_ruleid = '<%=Helper.correctNull((String) hshValues.get("buss_ruleid"))%>';
var vardeposittype = '<%=Helper.correctNull((String) hshValues.get("prd_deposittype"))%>';
var vardepositloanfor = '<%=Helper.correctNull((String) hshValues.get("prd_depositloanfor"))%>';
var varProAvailablefor='<%=Helper.correctNull((String) hshValues.get("prd_applicablefor"))%>';
var varProVehiType='<%=Helper.correctNull((String) hshValues.get("prd_vehitype"))%>';

var varPrdShareType='<%=Helper.correctNull((String) hshValues.get("PRD_SHARETYPE"))%>';
var varPRDWHTDIGIPRD='<%=Helper.correctNull((String) hshValues.get("PRD_WHTDIGIPRD"))%>';
var varPRDCGTMSEFALG='<%=Helper.correctNull((String) hshValues.get("PRD_CGTMSEFALG"))%>';
function doRenew()
{
	if(ConfirmMsg(174))
	{
		document.forms[0].method="post";
		document.forms[0].hidOldPrdId.value=document.forms[0].prd_code.value;
		document.forms[0].hidSourceUrl.value="/action/setsearchproducts.jsp";
		document.forms[0].hidBeanId.value="setproducts";
		document.forms[0].hidBeanMethod.value="renewProduct";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}

function loadRenew()
{
	if(document.forms[0].checkApp.value=="Yes" && '<%=request.getParameter("prd_choose")%>'=="Existing")
	{
		document.forms[0].cmdrenew.disabled=false;
	}
}
function doStaffLoanParameters()
{
	var prop = "scrollbars=yes,width=575,height=300,menubar=no";
	var title = "";
	var xpos = 4;
	var ypos = 4;
	prop = prop + ",left="+xpos+",top="+ypos;
	var url=appURL+"action/staffloanparameter.jsp?hidBeanId=setproducts&hidBeanGetMethod=getStaffloan&prd_code="+strprd_code;
	window.open(url,title,prop);
}
function showHouseBox()
{	
	if(document.forms[0].prd_type1.value =="p")
	 {
		 if(document.forms[0].prd_type2.value == "E")
		 {
			 document.all.id_edu_lbl.style.visibility = "visible";
			 document.all.id_edu_lbl.style.position	 = "relative";
			 document.all.id_edu_txt.style.visibility = "visible";
			 document.all.id_edu_txt.style.position = "relative";

			 document.all.edupurid1.style.visibility = "visible";
			 document.all.edupurid1.style.position	 = "relative";
			 document.all.edupurid2.style.visibility = "visible";
			 document.all.edupurid2.style.position	 = "relative";
		 }
		 else
		 {
			 document.all.id_edu_lbl.style.visibility = "hidden";
			 document.all.id_edu_lbl.style.position	 = "absolute";
			 document.all.id_edu_txt.style.visibility = "hidden";
			 document.all.id_edu_txt.style.position = "absolute";

			 document.all.edupurid1.style.visibility="hidden";
			 document.all.edupurid1.style.position="absolute";
			 document.all.edupurid2.style.visibility="hidden";
			 document.all.edupurid2.style.position="absolute";
		 }
		if(document.forms[0].prd_type2.value=="H")
		{
			document.all.idhomeloan.style.visibility="hidden";
			document.all.idhomeloan.style.position="absolute";
			//Added by Arsath on 19/12/2013 for Purpose of Loan/Type of Vehicle included in product page(Given by Prakash.N)
			document.all.homepurid1.style.visibility = "visible";
			document.all.homepurid1.style.position	 = "relative";
			document.all.homepurid2.style.visibility = "visible";
			document.all.homepurid2.style.position	 = "relative";
			//End of Arsath
		}
		else
		{
		    document.all.homepurid1.style.visibility="hidden";
		    document.all.homepurid1.style.position="absolute";
		    document.all.homepurid2.style.visibility="hidden";
		    document.all.homepurid2.style.position="absolute";
		    document.forms[0].maxnonmetro.value="";
			document.forms[0].maxmetro.value="";
			document.forms[0].sel_homeplus.value="N";		
			document.all.idhomeloan.style.visibility="hidden";
			document.all.idhomeloan.style.position="absolute";
     	}
		 if(document.forms[0].prd_type2.value == "R")
		 {
			 document.all.iddeposittype1.style.display="table-row";
			 document.all.iddeposittype2.style.display="table-row";
		 }
		 else
		 {
			document.all.iddeposittype1.style.display="none";
			document.all.iddeposittype2.style.display="none";
		 }
	}
	else
	{
		document.forms[0].maxnonmetro.value="";
		document.forms[0].maxmetro.value="";
		document.forms[0].sel_homeplus.value="N";
		document.all.idhomeloan.style.visibility="hidden";		
		document.all.idhomeloan.style.position="absolute";
	}
	if(document.forms[0].prd_type2.value=="A")
	{
		document.all.vehtypeid1.style.visibility = "visible";
		document.all.vehtypeid1.style.position	 = "relative";
		document.all.vehtypeid2.style.visibility = "visible";
		document.all.vehtypeid2.style.position	 = "relative";
	}
	else
	{
		document.all.vehtypeid1.style.visibility="hidden";
	    document.all.vehtypeid1.style.position="absolute";
	    document.all.vehtypeid2.style.visibility="hidden";
	    document.all.vehtypeid2.style.position="absolute";
	}
	if(document.forms[0].prd_type2.value=="U")
	{
		document.all.App1.style.visibility = "visible";
		document.all.App1.style.position	 = "relative";
		document.all.App2.style.visibility = "visible";
		document.all.App2.style.position	 = "relative";
	}
	else
	{
		document.all.App1.style.visibility="hidden";
	    document.all.App1.style.position="absolute";
	    document.all.App2.style.visibility="hidden";
	    document.all.App2.style.position="absolute";
	    document.all.App3.style.visibility="hidden";
	    document.all.App3.style.position="absolute";
	    document.all.App4.style.visibility="hidden";
	    document.all.App4.style.position="absolute";
	}
	selstaffstatus();
}
function showratios()
{
	if(document.forms[0].prd_type1.value =="p")
	{
		/*if(document.forms[0].sel_staffloan.value=="Y")
		{
			document.all.s1.style.visibility="visible";
        	document.all.s1.style.position="relative";
	        document.all.cmdstaffloanparameters.style.visibility="visible";
	        document.all.cmdstaffloanparameters.style.position="relative";
	        //document.all.s3.style.visibility="visible";
	        //document.all.s3.style.position="relative";
		}
		else
		{*/
	        document.all.s1.style.visibility="hidden";
	        document.all.s1.style.position="absolute";
	        //document.all.cmdstaffloanparameters.style.visibility="hidden";
	        //document.all.cmdstaffloanparameters.style.position="absolute";
	        document.all.s3.style.visibility="hidden";
	        document.all.s3.style.position="absolute";
    	//}
    }
    else
    {
    	document.forms[0].maxnonmetro.value="";
		document.forms[0].maxmetro.value="";
	    document.all.s1.style.visibility="hidden";
	    document.all.s1.style.position="absolute";
	    //document.all.cmdstaffloanparameters.style.visibility="hidden";
	    //document.all.cmdstaffloanparameters.style.position="absolute";
    }
}
function checkValidmindate()
{
	var prddt   = changeDateformat(document.forms[0].prd_eff_date.value);
	var validdt = changeDateformat(document.forms[0].prd_validupto_date.value);

			if(Date.parse(prddt) > Date.parse(validdt))
			{
				alert("Product effective Date cannot be greater than Valid upto");
				document.forms[0].prd_eff_date.value="";
				document.forms[0].prd_eff_date.focus();
				return;
			}
		
}
//Added By Zahoorunnisa.s to copy the product
function doCopy()
{
	if(ConfirmMsg(173))
	{
		document.forms[0].method="post";
		document.forms[0].hidOldPrdId.value=document.forms[0].prd_code.value;
		document.forms[0].hidSourceUrl.value="/action/setsearchproducts.jsp";
		document.forms[0].hidBeanId.value="setproducts";
		document.forms[0].hidBeanMethod.value="copyProduct";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}
//End
function selectValues()
{
	if(document.forms[0].prd_loantype.value!="")
	{
		document.all.id_schemecodelbl.style.display="table-cell";
		document.all.id_schemecodetxt.style.display="table-cell";
		var varloantype = document.forms[0].prd_loantype.options[document.forms[0].prd_loantype.selectedIndex].value;
		document.all.ifrmscheme.src=appURL+"action/iframeschemecode.jsp?hidBeanGetMethod=getSchemeCodeData&hidBeanId=setproducts&loantype="+varloantype;
	}
	else
	{
		document.all.id_schemecodelbl.style.display="none";
		document.all.id_schemecodetxt.style.display="none";
	}
}
function selstaffstatus()
{
	if(document.forms[0].sel_staffloan.value == "Y")
	{
		document.all.staff_loan.style.display="table-cell";
		if(strprd_type=="pA" || document.forms[0].prd_type2.value=="A" ||strprd_type=="pH" || document.forms[0].prd_type2.value=="H")
		{
			document.all.idstaffloan.style.visibility="visible";
			document.all.idstaffloan.style.position="relative";
		}else{
			document.all.idstaffloan.style.visibility="hidden";
			document.all.idstaffloan.style.position="absolute";
		}
	}
	else
	{
		document.all.staff_loan.style.display="none";
		document.all.idstaffloan.style.visibility="hidden";
		document.all.idstaffloan.style.position="absolute";
	}

}

function businruleid()
{
	if(document.forms[0].selid.value=="Y")
	{
		document.all.busrule.style.visibility="visible";
		document.all.busrule.style.position="relative";
		document.all.busrule1.style.visibility="visible";
		document.all.busrule1.style.position="relative";
		
	}
	else
	{
		document.all.busrule.style.visibility="hidden";
		document.all.busrule.style.position="absolute";
		document.all.busrule1.style.visibility="hidden";
		document.all.busrule1.style.position="absolute";
		
	}
}	

function selstaffloanlimit()
{
	if(document.forms[0].prd_type2.value == "H" && document.forms[0].sel_staffloan.value == "Y" && document.forms[0].checkApp.value=="Yes")
	{
		document.all.staffloanlimit.style.display="table";
	}
	else
	{
		document.all.staffloanlimit.style.display="none";
	}
		
}

function staffloanlimitchange()
{
	var varprdcode=document.forms[0].prdCode.value;
	var varQryString = appURL+"action/restr_remove_accts.jsp?hidBeanId=setproducts&hidBeanGetMethod=getnewSancLimit&pageFrm=P&prdCode="+varprdcode;
	var title1 = "Staffloanlimitchange";
	var prop1 = "scrollbars=yes,width=700,height=430,status=yes,left=50,top=50";	
	window.open(varQryString,title1,prop1);
}
function funforsuvidha(flag)
{
	if(document.forms[0].prd_type2.value=="V")
	{
		document.forms[0].prd_loantype.value="OD";
		document.forms[0].prd_loantype.disabled=true;
		if(flag=="Y")
		{
			selectValues();
		}
	}
	else
	{
		document.forms[0].prd_loantype.disabled=false;
	}
}
function callVehiReq()
{
	if(document.forms[0].prd_type2.value=="U")
	{
		if(document.forms[0].sel_ProAppFor.value=="V")
		{
			document.all.App3.style.visibility="visible";
			document.all.App3.style.position="relative";
			document.all.App4.style.visibility="visible";
			document.all.App4.style.position="relative";
		}
		else
		{
			 document.all.App3.style.visibility="hidden";
			 document.all.App3.style.position="absolute";
			 document.all.App4.style.visibility="hidden";
			 document.all.App4.style.position="absolute";
		}
	}
}

function callProductAvailValues()
{
	if(document.forms[0].prd_type2.value=="U")
	{
		if(varProAvailablefor!="")
		{
			document.forms[0].sel_ProAppFor.value=varProAvailablefor;
		}
		else
		{
			document.forms[0].sel_ProAppFor.value="S";
		}
		
		if(document.forms[0].sel_ProAppFor.value=="V")
		{
			if(varProVehiType!="")
			{
				
			document.forms[0].sel_VehiType.value=varProVehiType;
			}
			else
			{
			document.forms[0].sel_VehiType.value="S";
			}
		}
	}
	
}

function checkloanshare()
{
if(document.forms[0].prd_type2.value=="S")
{
	document.all.loan1.style.display = "table-cell";
	document.all.loan2.style.display = "table-cell";
	
}else
{
	document.all.loan1.style.display = "none";
	document.all.loan2.style.display = "none";
	document.all.loan_again_share.value = "";
	
}
}

</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
</head>
<body onLoad="placeValues();callNew();loadUsedApp();loadRenew();showHouseBox();showratios();showhidevehhomefields();businruleid();selstaffstatus();selstaffloanlimit();enabledepositdetails();callProductAvailValues();">
<form name="documentsfrm" method="post" class="normal">
<iframe id="bussframe" width="0" height="0"> </iframe>
<lapstab:setproductstab tabid="1" prdtype='<%=Helper.correctNull((String) hshValues.get("prd_type"))%>'/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Setup -&gt; Retail Products -&gt; Products</td>
	</tr>
</table>
<br>
<table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable border1" align="center">
	<tr>
		<td valign="top">
		<span style="visibility: hidden; position: absolute"><lapschoice:products /></span>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
					<tr>
						<td>Creation Date&nbsp;</td>
						<td><input type="text" name="prd_intro_date" size="12"
							readonly="readonly"
							value="<%=Helper.correctNull((String) hshValues.get("prd_intro_date"))%>">
						</td>
						<td>Modified Date&nbsp;</td>
						<td><input type="text" name="prd_mod_date" size="12"
							readonly="readonly"
							value="<%=Helper.correctNull((String) hshValues.get("prd_mod_date"))%>">
						</td>
						<td>Product Code</td>
						<td><input type="text" name="prd_code" size="12"
							value="<%=Helper.correctNull((String) hshValues.get("prd_code"))%>"
							readonly="readonly"></td>
					</tr>
					<tr>
						<td>Product For&nbsp;<b><span class="mantatory">*</span>
						</b></td>
						<td><select name="prd_type1" onChange="changeLoanType()"
							tabindex="1">
							<option value="p" selected="selected">Retail</option>
							<!--  <option value="a">Agriculture</option>-->
						</select></td>
						<td>Under Which</td>
						<td><select name="prd_type2" onclick="checkloanshare();" style="width: 150"
							onChange="selstaffstatus();showHouseBox();showGoldDepFields(document.forms[0].prd_type1.value,this.value);funforsuvidha('Y');" tabindex="2">
							<option selected="selected">----- Select ------</option>
						</select></td>
						<td>Type of Loan &nbsp;<b><span class="mantatory">*</span></b></td>
						<td><select name="prd_loantype" tabindex="3" onChange="selectValues();">
							<option value="" selected="selected">&lt;---Select---&gt;</option>
							<option value="TL">Term Loan</option>
							<option value="DL">Demand Loan</option>
							<option value="OD">Over Draft</option>
						</select></td>
					</tr>
					<tr>
						<td>Bank's Scheme&nbsp;<b><span class="mantatory">*</span>
						</b></td>
						<td colspan="3"><select name="sel_bankscheme" style="width:465px;">
							<option value="" selected="selected">&lt;----Select----&gt;</option>
                            <lapschoice:BanksSchemeStaticDataNewTag apptype="1" /> 
						</select></td>
						
					    <!-- Added by Arsath on 19/12/2013 for Purpose of Loan/Type of Vehicle included in product page(Given by Prakash.N)-->
						<td id="homepurid1">Purpose of Loan<b><span class="mantatory">*</span></b></td>
						<td id="homepurid2">
			              <select name="sel_purpose_of_loan" onchange="" style="width:120px;">
			              <option value="0" selected="selected">--Select--</option>
			              <option value="G">Purchase of Site</option>
			              <option value="C">Construction of House</option>
			              <option value="S">Purchase of Site & Construction of House</option>
			              <option value="H">Purchase of Ready Built House/Flat</option>
			              <option value="R">Renovation</option>
			              <option value="F">Home Comfort</option>
			              <option value="T">Top up Loan</option>
			              <option value="HC">Home Connect</option>
			              </select>
						</td>
						
						<td id="loan1">Type of Share &nbsp;<span class="mantatory">*</span></td>
						<td id="loan2"><select name="loan_again_share" >
							<option value="" selected>--Select--</option>
							<option value="P">Physical Form</option>
							<option value="D">Demat Form</option>
							</select>
						</td>
													
						<td id="vehtypeid1">Type of Vehicle<b><span class="mantatory">*</span></b></td>
						<td id="vehtypeid2">
		              	<select name="sel_vehicletype" onchange="">
						<option value="0" selected>------Select-----</option>
						<option value="T">Two Wheeler</option>
						<option value="A">Three Wheeler</option>
						<option value="N">Four Wheeler - New</option>
						<option value="U">Four Wheeler - Used</option>
						</select>
						</td>
						<!-- End of Arsath-->
						
						<td id="edupurid1">Purpose of Loan<b><span class="mantatory">*</span></b></td>
						<td id="edupurid2">
			              <select name="sel_edu_loan" onchange="" style="width:120px;">
			              <option value="0" selected="selected">--Select--</option>
			              <option value="I">Studies in India</option>
			              <option value="A">Studies in Abroad</option>
			              </select>
						</td>
						
						
					</tr>
					<tr>
						<td>Category&nbsp;&nbsp;<b><span class="mantatory">*</span></b></td>
						<td colspan="3">
						<table width="75%" border="0" cellspacing="0" cellpadding="1"
							class="outertable">
							<tr>
								<td><input type="text" name="catname" size="90"
									maxlength="99" readonly="readonly"
									value="<%=Helper.correctNull((String) hshValues.get("catname"))%>">
								<input type="hidden" name="prd_catid"
									value="<%=Helper.correctNull((String) hshValues.get("prd_catid"))%>">
								</td>
								<td><b><span style="cursor: hand"
									onClick="callCategoryHelp('0')"><img
									src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
									border="0" tabindex="5"></span></b></td>
							</tr>
						</table>
						</td>
						<td>Min. Repayment Period (In Months) &nbsp;<b><span
							class="mantatory">*</span></b></td>
						<td><input type="text" align="top" name="prd_minterm"
							size="12" maxlength="4" style="text-align: right"
							onKeyPress="allowInteger()" tabindex="9"
							value="<%=Helper.correctNull((String) hshValues
									.get("prd_minterm"))%>">
						</td>
					</tr>
					<tr>
						<td>Sub Category&nbsp;&nbsp;<b><span class="mantatory">*</span></b></td>
						<td colspan="3">
						<table width="75%" border="0" cellspacing="0" cellpadding="1"
							class="outertable">
							<tr>
								<td><b> <input type="text" name="scatname" size="90"
									maxlength="50" readonly="readonly"
									value="<%=Helper.correctNull((String) hshValues.get("scatname"))%>">
								</b> <input type="hidden" name="cat_id"
									value="<%=Helper.correctNull((String) hshValues
									.get("cat_id"))%>">
								</td>
								<td><b><span
									onClick="callCategoryHelp(document.forms[0].cat_id.value)"
									style="cursor: hand"><img
									src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
									border="0" tabindex="6"></span></b></td>
							</tr>
						</table>
						</td>
						<td>Max. Repayment Period (In Months) &nbsp;<b><span
							class="mantatory">*</span></b></td>
						<td><input type="text" align="top" name="prd_term" size="12"
							maxlength="4" style="text-align: right"
							onKeyPress="allowInteger()" tabindex="10"
							value="<%=Helper.correctNull((String) hshValues.get("prd_term"))%>">
						</td>
					</tr>
					<tr>
						<td id="id_schemecodelbl">Scheme Code &nbsp;<b><span class="mantatory">*</span>
						</b></td>
						<td id="id_schemecodetxt">
							<select name="schemecodeid1" maxlength="4" tabindex="4">
								<option value="S">-----select------</option>
							</select>
						</td>
						<td>Staff Loan</td>
						<td><select name="sel_staffloan" onchange="selstaffstatus()">
							<option value="Y">Yes</option>
							<option value="N" selected="selected">No</option>
						</select></td>
						<td colspan="2"><div id="staff_loan">
						<select name="selstaffloan_under">
							<option value="S"><---Select---></option>
							<option value="1">Under Staff</option>
							<option value="2">Outside Staff</option>
						</select>
						</div></td>
					</tr>
					<tr id="idstaffloan">
					<td colspan="2">Max. period for Repay the Principal (In Months) <b><span
							class="mantatory">*</span></b></td>
					<td><input type="text" name="txt_repaytprincipal_staff" value="<%=Helper.correctNull((String) hshValues.get("prd_staff_maxterm_prin"))%>" size="12"
							maxlength="4" style="text-align: right"
							onKeyPress="allowInteger()"></td>
					<td>Max.period for Repay the Interest (In Months) <b><span
							class="mantatory">*</span></b></td>
					<td colspan="2">&nbsp;<input type="text" name="txt_repaytinterest_staff" value="<%=Helper.correctNull((String) hshValues.get("prd_staff_maxterm_intr"))%>" size="12"
							maxlength="4" style="text-align: right;position:relative;left:-5px;"
							onKeyPress="allowInteger()"></td>					
					</tr>
					<tr id="idhomeloan">
						<td >Union home plus</td>
						<td><select name="sel_homeplus" onChange="">
							<option value="Y">Yes</option>
							<option value="N" selected="selected">No</option>
						</select></td>
						<td>Maximum Loan for Metro</td>
						<td><lapschoice:CurrencyTag name="maxmetro" maxlength="10"
							tabindex="9"
							value='<%=Helper
							.formatDoubleValue(Double.parseDouble(Helper
									.correctDouble((String) hshValues
											.get("maxmetro"))))%>' /></td>
						<td>Maximum Loan for Non-Metro</td>
						<td><lapschoice:CurrencyTag name="maxnonmetro"
							maxlength="10" tabindex="9"
							value='<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("maxnon_metro"))))%>' /></td>
					</tr>
					<tr>
						<td>Range From <b> <%
 	//=ApplicationParams.getCurrency()
 %>
						</b><b><span class="mantatory">*</span></b></td>
						<td><lapschoice:CurrencyTag name="prd_rng_from"
							maxlength="13" tabindex="7" size="14"
							value='<%=Helper.correctNull((String) hshValues
									.get("prd_rng_from"))%>' /></td>
						<td>Range To&nbsp;<b><span class="mantatory">*</span></b></td>
						<td><lapschoice:CurrencyTag name="prd_rng_to" maxlength="13"
							tabindex="8" size="14"
							value='<%=Helper.correctNull((String) hshValues.get("prd_rng_to"))%>' /></td>
						<td id="id_schemetypelbl">Scheme Type</td>
						<td id="id_schemetypetxt">
							<select name="sel_schemetype">
								<option value="" selected="selected">--Select--</option>
								<option value="Q">GL Quick</option>
								<option value="C">GL Classic</option>
								<option value="T">GL Comfort</option>
								<option value="S">GL Staff</option>
								<option value="M">GL Smart</option>
							</select>
						</td>
						<td id="id_adintratelbl" width="20%">Additional Interest Rate to be accumulated over the existing Deposits<b><span class="mantatory">*</span>&nbsp;(%)</b></td>
						<td id="id_adintratetxt">
							<lapschoice:CurrencyTag name="prd_addintrate" maxlength="5"
							tabindex="8" size="14" onBlur="checkPercentage(this);"
							value='<%=Helper.correctNull((String) hshValues.get("prd_addintrate"))%>' />
						</td>
						<!--<td>NSC Loan</td>
						<td><input type="checkbox" name="nsc_check" value="0"
							style="border: none"></td>
					--><input type="hidden" name="nsc_check" value="0"></tr>
					<tr>
						<td colspan="3" id="id_whetheragrilbl">Whether this product comes under Agriculture scheme<b><span class="mantatory">*</span></b></td>
						<td id="id_whetheragritxt">
							<select name="sel_whetheragri">
								<option value="" selected="selected">--Select--</option>
								<option value="Y">Yes</option>
								<option value="N">No</option>
							</select>
						</td>
						<td id="id_edu_lbl">Spl. scheme&nbsp;<b><span class="mantatory">*</span></b></td>
						<td id="id_edu_txt"> <select name="sel_splscheme" onChange="">
							<option value="Y">Yes</option>
							<option value="N" selected="selected">No</option>
						</select></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr id="s1">
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="outertable">
					<tr>
						<td colspan="11"><b>For Staff Loan</b></td>
					</tr>
					<tr>
						<td>Repayment Ratio(Principal:Interest)<b><span
							class="mantatory">*</span></b></td>
						<td><input type="text" align="top" name="prd_principal"
							size="2" maxlength="1" style="text-align: right"
							onKeyPress="allowNumber(this)" tabindex="9"
							value="<%=Helper.correctNull((String) hshValues
							.get("prd_principal"))%>">
						<b>:</b> <input type="text" align="top" name="prd_interest"
							size="2" maxlength="1" style="text-align: right"
							onKeyPress="allowNumber(this)" tabindex="9"
							value="<%=Helper.correctNull((String) hshValues
									.get("prd_interest"))%>"></td>
						<td width="22%">&nbsp;</td>
						<td width="24%">&nbsp;</td>
						<td width="12%">&nbsp;</td>
						<td width="13%">&nbsp;</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
			class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="3"
					class="outertable">
					<tr>
						<td id="iddeposittype1">Deposit Type&nbsp;<b><span class="mantatory">*</span></b></td>
						<td id="iddeposittype2"><select name="sel_deposittype" onchange="enabledepositdetails()">
						<option value="s"><--select--></option>
						<option value="G">General</option>
						<option value="H">Honey deposit</option>
						<option value="F">FCNR deposit</option>
						</select></td>
						<td id="iddeposittype3">Deposit Loan for&nbsp;</td>
						<td id="iddeposittype4"><select name="sel_loanfor">
						<option value="s"><--select--></option>
						<option value="O">Own Deposit</option>
						<option value="T">Third Party Deposit</option>
						</select></td>
					</tr>
					<tr>
						<td>Description&nbsp;<b><span class="mantatory">*</span></b></td>
						<td><input type="text" name="prd_desc" size="75"
							maxlength="100"
							value="<%=Helper.correctDoubleQuote((String) hshValues
							.get("prd_desc"))%>"
							tabindex="11"></td>
						<td>Maximum Holiday Period</td>
						<td><input type="text" name="txtprd_holiday" size="6" maxlength="3" onKeyPress="allowInteger();"
							value="<%=Helper.correctDoubleQuote((String) hshValues.get("prd_holiday"))%>" tabindex="12"></td>
						<!--<td>Eligibility based on</td>
						<td><select name="prd_incomeflag" tabindex="12">
							<option value="0" selected="selected">------- Gross Income -----</option>
							<option value="1">----- Net Income -----</option>
							<option value="2">----- Both (Gross Income &amp; Net
							Income) -----</option>
						</select></td>-->
						<input type="hidden" name="prd_incomeflag" value="1">
						
					</tr>
					<tr>
						<td>Stop the product for current users</td>
						<td><select name="prd_stop" tabindex="14">
							<option value="y">Yes</option>
							<option value="n" selected="selected">No</option>
						</select></td>
						<td id="bus1">Whether Rating&nbsp;<b><span
							class="mantatory">*</span></b></td>
						<td id="bus2"><select name="selid" tabindex="16" onchange="businruleid();">
							<option value="0" selected="selected" tabindex="15">---- Select	----</option>
							<option value="Y">Yes</option>							
							<option value="NR">No</option>							
						</select></td>
					</tr>	
					<tr>
						<td id="busrule">Rating Business Rule&nbsp;<b><span class="mantatory">*</span>
						</b></td>
						<td id="busrule1"><select name="sel_busruleid" style="width:465px;">
							<option value="S" selected="selected">&lt;----Select----&gt;</option>
                            <lapschoice:BusinessRule_RatingTag/> 
						</select></td>
						<td>Select Repayment Type<b><span
							class="mantatory">*</span></b></td>
						<td>
						<select multiple="multiple" name="sel_repaymenttype" size="6">
						<option value="1">EMI</option>
						<option value="2">Non-EMI</option>
						<option value="12">On Demand</option>
						<option value="8">On Due Date</option>
						<option value="13">Equal Monthly Installment</option>
						<option value="14">2 Yearly Equal Installment</option>
						</select>
						</td>
					
					</tr>
					<tr>
						<td>Product effective date&nbsp;<b><span
							class="mantatory">*</span></b></td>
						<td>
						<table width="40%" border="0" cellspacing="0" cellpadding="3"
							class="outertable">
							<tr>
								<td><input type="text" name="prd_eff_date" maxlength="10"
									size="12"
									onBlur="checkDate(this);checkmindate(this,currentDate);checkValidmindate();"
									value="<%=Helper.correctNull((String) hshValues
									.get("prd_eff_date"))%>">
								</td>
								<td><a alt="Select date from calender" href="#"
									onClick="callCalender()"
									onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"><img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0" alt="Select date from calender"
									tabindex="17"></a></td>
							</tr>
						</table>
						</td>
						<td>Select Terms and Conditions&nbsp;<b><span
							class="mantatory">*</span></b></td>
						<td><select name="seltermid" tabindex="18">
							<option value="-" selected="selected">---- Select ----</option>
							<lapschoice:prodtermcond />
						</select></td>
					</tr>
					<tr>
						<td>Valid upto&nbsp;<b><span class="mantatory">*</span></b></td>
						<td>
						<table width="40%" border="0" cellspacing="0" cellpadding="3"
							class="outertable">
							<tr>
								<td><input type="text" name="prd_validupto_date"
									maxlength="10" size="12"
									onBlur="checkDate(this);checkmindate(this,currentDate)"
									value="<%=Helper.correctNull((String) hshValues
							.get("prd_validupto_date"))%>">
								</td>
								<td><a alt="Select date from calender" href="#"
									onClick="callCalender1('prd_validupto_date')"
									onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"><img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0" alt="Select date from calender"
									tabindex="19"></a></td>
							</tr>
						</table>
						</td>
						<!--<td>
				Internet Product
				</td>
				<td><select name="sel_internet" onChange="">
				<option value="S" selected="selected">--Select--</option>
							<option value="Y">Yes</option>
							<option value="N" >No</option>
						</select>
				</td>
					-->
				<td>Select Interest rate frequency&nbsp;</td>
						<td><select name="selintrate" tabindex="18">
							<option value="M" selected="selected">Monthly</option>
								<option value="Q">Quartely</option>
								<option value="H">Half-yearly</option>
								<option value="Y">Yearly</option>
						</select></td>	
					</tr>
					<input type="hidden" name="sel_internet" value="N">
					<tr>
					<td id="App1">Product Applicable For&nbsp;<b><span class="mantatory">*</span></b></td>
					<td id="App2"><select name="sel_ProAppFor" tabindex="18" onchange="callVehiReq()">
							<option value="S" selected="selected">Select</option>
							<option value="V">Vehicle</option>
							<option value="O">Other than vehicle</option>
						</select>
						</td>
					<td id="App3">Whether Old or New Vehicle is required&nbsp;<b><span class="mantatory">*</span></b></td>
					<td id="App4"><select name="sel_VehiType" tabindex="18">
							<option value="0" selected="selected">Select</option>
							<option value="1">New Vehicle</option>
							<option value="2">Old Vehicle</option>
							</select></td>
					</tr>
					<tr>
						<td>whether Digi Product</td>
						<td><select name="sel_whtDigiProduct" onChange="">
									<option value="N" selected="selected" >No</option>
									<option value="Y">Yes</option>
								</select>
						</td>
						
						<td>Interest type</td>
						<td><select name="sel_interesttype" multiple="multiple">
							<lapschoice:StaticDataTag apptype="219" />		
								</select>
						</td>
					</tr>
					<tr>
					<td nowrap="nowrap">Min. Restructure Repayment Period (In Months) &nbsp;<b><span
							class="mantatory">*</span></b></td>
						<td><input type="text" align="top" name="prd_mintermrest"
							size="12" maxlength="4" style="text-align: right"
							onKeyPress="allowInteger()" tabindex="19"
							value="<%=Helper.correctNull((String) hshValues
									.get("PRD_MINTERM_REST"))%>">
						</td>
						
						<td nowrap="nowrap">Max. Restructure Repayment Period (In Months) &nbsp;<b><span
							class="mantatory">*</span></b></td>
						<td><input type="text" align="top" name="prd_termrest" size="12"
							maxlength="4" style="text-align: right"
							onKeyPress="allowInteger()" tabindex="20"
							value="<%=Helper.correctNull((String) hshValues.get("PRD_TERM_REST"))%>">
						</td>
						</tr>
						<tr>
						<td nowrap="nowrap">Maximum Restructure Holiday Period</td>
						<td><input type="text" name="txtprd_holidayrest" size="6" maxlength="3" onKeyPress="allowInteger();"
							value="<%=Helper.correctDoubleQuote((String) hshValues.get("PRD_HOLIDAY_REST"))%>" tabindex="21"></td>
							
						<td>Mandatory CGTMSE</td>
						<td><select name="sel_CGTMSE" onchange="">
							<option value="S" selected="selected"><--Select--</option>
							<option value="Y">Yes</option>
							<option value="N" >No</option>
						</select></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		<br>
	<!--  -->	<table width="100%" border="0" cellspacing="0" cellpadding="1"
			class="outertable">
			<tr id="s3">
				<td>&nbsp;Note:
				<ul>
					<li>
					<p>For compound interest put Repayment
					Ratio(Principal:Interest) as 0:0</p>
					</li>
					<li>
					<p>For simple interest put actual ratio in repayment
					ratio(Principal:Interest)</p>
					</li>
				</ul>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<iframe height="0" width="0" id="ifrmscheme" frameborder="0" style="border: 0"></iframe>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Copy_Renew_Audit Trail"
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<table width="15%" border="0" cellspacing="0" cellpadding="1" class="outertable border1" align="center" id="staffloanlimit">
	<tr><td><input type="button" name="cmdstaffLimit" value="Staff loan Limit Change" onclick="staffloanlimitchange()" class="buttonStyle"></td></tr>
</table>		
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="renew1" value="Renew">
<input type="hidden" name="selid1"> 
<input type="hidden" name="prd_type"> 
<input type="hidden" name="prd_type3">
<input type="hidden" name="prd_saveflag" value="<%=Helper.correctNull((String) hshValues.get("prd_saveflag"))%>"> 
<input type="hidden" name="schemeCode">
<input type="hidden" name="secured"> 
<input type="hidden" name="inttenor"> 
<input type="hidden" name="intamt"> 
<input type="hidden" name="repayment"> 
<input type="hidden" name="hidselid"> 
<input type="hidden" name="hidtermid">
<input type="hidden" name="hidProductType" value="<%=Helper.correctNull((String) hshValues.get("prd_type"))%>">
<input type="hidden" name="checkApp" value="<%=(String) hshValues.get("checkApp")%>"> 
<input type="hidden" name="hidOldPrdId" value="">
<input type="hidden" name="hidSchemeCode" value="<%=Helper.correctNull((String)hshValues.get("scheme_code"))%>">
<input type="hidden" name="hidRepaymentType" value="<%=Helper.correctNull((String)hshValues.get("prd_repaytype")) %>">
<input type="hidden" name="hidInterestType" value="<%=Helper.correctNull((String)hshValues.get("prd_interesttype")) %>">
</form>
</body>
</html>
