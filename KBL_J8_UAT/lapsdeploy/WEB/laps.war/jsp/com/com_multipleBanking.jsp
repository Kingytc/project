<%@include file="../share/directives.jsp"%>
<%
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
String strCategory=Helper.correctNull((String)request.getParameter("hidCategoryType"));	

String strBATypeWC		= Helper.correctNull((String)hshValues.get("com_wc_bnkarg"));
String strConsTypeWC	= Helper.correctNull((String)hshValues.get("com_wc_type"));
String strBATypeTL		= Helper.correctNull((String)hshValues.get("com_tl_bnkarg"));
String strConsTypeTL	= Helper.correctNull((String)hshValues.get("com_tl_type"));

ArrayList vecCol = new ArrayList();
ArrayList vecRow = new ArrayList();
int vecsize = 0;
if (hshValues != null)
{		vecRow = (ArrayList) hshValues.get("vecRow");				
}
java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
nf.setGroupingUsed(false);
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);


%>
<html>
<head>
<title>Working Capital - Existing exposure</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/com/com_multipleBanking.js"> </script>
<script type="text/javascript">

var varBan_Type="<%=Helper.correctNull((String)hshValues.get("com_wc_type"))%>";

var RowCount="<%=Helper.correctInt((String)hshValues.get("RowCount"))%>";
var FbSum="<%=Helper.correctDouble((String)hshValues.get("FbSum"))%>";
var NfbSum="<%=Helper.correctDouble((String)hshValues.get("NfbSum"))%>";
var ExistSum="<%=Helper.correctDouble((String)hshValues.get("ExistSum"))%>";
var ProFbSum="<%=Helper.correctDouble((String)hshValues.get("ProFbSum"))%>";
var ProNfbSum="<%=Helper.correctDouble((String)hshValues.get("ProNfbSum"))%>";
var ProSum="<%=Helper.correctDouble((String)hshValues.get("ProSum"))%>";
//var proposalnoteCheck="<%=Helper.correctDouble((String)hshValues.get("com_proposalnote"))%>";
//var annexureCheck="<%=Helper.correctDouble((String)hshValues.get("com_annexure"))%>";

function getConsValue()
{
	document.forms[0].hidGetFLAG.value="Yes";
	document.forms[0].hidBeanId.value="bankapp";
	document.forms[0].hidBeanGetMethod.value="getMultipleBanking";
	document.forms[0].action=appURL+"action/com_multipleBanking.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}
function setBankmaster(v1,v2,v3)
{
	document.forms[0].txt_bankName.value	= v2;			
}
function FBExposure()
{
	//if(document.forms[0].hidAction.value!="update")
	//{
	var TotDenominatorExistFB="100";
	var TotDenominatorExistNFb="100";
	var TotDenominatorPropFb="100";
	var TotDenominatorPropNfb="100";
	var TotDenominatorProp="100";
	var TotDenominatorExist="100";
	
	var ExistFb=eval(document.forms[0].txt_existFb.value);
	var ExistNfb=eval(document.forms[0].txt_existNfb.value);
	var ExistTot=roundVal(ExistFb+ExistNfb);
	var PropFb=eval(document.forms[0].txt_PropFb.value);
	var PropNfb=eval(document.forms[0].txt_PropNfb.value);
	var PropTot=roundVal(PropFb+PropNfb);

	var ExistFbExpo="0.00";
	var ExistNfbExpo="0.00";
	var ExistExpoTot="0.00";
	var PropNfbExpo="0.00";
	var PropTotExpo="0.00";
	var PropFbExpo="0.00";
	if(RowCount=="0")
	{
		if(ExistFb!="0")
		{
			TotDenominatorExistFB=eval(ExistFb); 
		}
		if(ExistNfb!="0")
		{
		TotDenominatorExistNFb=eval(ExistNfb);
		}
		if(PropFb!="0")
		{
		TotDenominatorPropFb=eval(PropFb);
		}
		if(PropNfb!="0")
		{
		TotDenominatorPropNfb=eval(PropNfb);
		}
		if(ExistTot!="0")
		{
		TotDenominatorExist=roundVal(eval(ExistTot));
		}
		else
		{
			TotDenominatorExist="100";
		}
		if(PropTot!="0")
		{
		TotDenominatorProp=roundVal(eval(PropTot));
		}
		else
		{
			TotDenominatorProp="100";
		}
	}
	else //if(document.forms[0].hidAction.value=="insert")
	{
		TotDenominatorExistFB=roundVal(eval(FbSum)+eval(ExistFb));
		TotDenominatorExistNFb=roundVal(eval(NfbSum)+eval(ExistNfb));
		TotDenominatorPropFb=roundVal(eval(ProFbSum)+eval(PropFb));
		TotDenominatorPropNfb=roundVal(eval(ProNfbSum)+eval(PropNfb));

		TotDenominatorExist=eval(ExistSum)+eval(ExistTot);
		TotDenominatorProp=eval(ProSum)+eval(PropTot);
	}

	if(TotDenominatorExistFB!=0)
	 ExistFbExpo=roundVal(ExistFb*100/TotDenominatorExistFB);
	if(TotDenominatorExistNFb!=0)
	 ExistNfbExpo=roundVal(ExistNfb*100/TotDenominatorExistNFb);
	if(TotDenominatorExist!=0)
	 ExistExpoTot=roundVal(ExistTot*100/TotDenominatorExist);

	if(TotDenominatorPropFb!=0)
	 PropFbExpo=roundVal(PropFb*100/TotDenominatorPropFb);
	if(TotDenominatorPropNfb!=0)
	 PropNfbExpo=roundVal(PropNfb*100/TotDenominatorPropNfb);
	if(TotDenominatorProp!=0)
	 PropTotExpo=roundVal(PropTot*100/TotDenominatorProp);
	
	document.forms[0].txt_existTot.value=ExistTot;
	document.forms[0].txt_existFbExpo.value=ExistFbExpo;
	document.forms[0].txt_existNfbExpo.value=ExistNfbExpo;
	if((TotDenominatorExist!="0")&&(ExistExpoTot!="N.aN"))
	{		
			 document.forms[0].txt_existTotExpo.value=ExistExpoTot;
		
	}
	else
	{
		document.forms[0].txt_existTotExpo.value="0.00";
	}
	document.forms[0].txt_PropTot.value=PropTot;
	document.forms[0].txt_PropFbExpo.value=PropFbExpo;
	document.forms[0].txt_PropNfbExpo.value=PropNfbExpo;
	
	
	if((TotDenominatorProp!="0")&&(PropTotExpo!="N.aN"))
	{		
	   document.forms[0].txt_PropTotExpo.value=PropTotExpo;
	}
	else
	{
		document.forms[0].txt_PropTotExpo.value="0.00";
	}
	//}
}
function callNew()
{
	var varConsType	= '<%=Helper.correctNull((String)hshValues.get("com_cons_sno"))%>';

	if(varConsType=="")
	{
		varConsType	= '<%=Helper.correctNull((String)hshValues.get("sel_ConsType"))%>';
	}
	
	var varConsType1	= '<%=Helper.correctNull((String)hshValues.get("com_tl_type"))%>';

	if(varConsType1 == "M" && varBan_Type=="M")
	{
		document.forms[0].sel_ConsType.value	= varConsType;
		document.forms[0].sel_ConsType.disabled	= true;
	}
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=="radio")
		{
			document.forms[0].elements[i].disabled=true;		  
		} 
		 
	}
}
function callEdit()
{
	var varConsType	= '<%=Helper.correctNull((String)hshValues.get("com_cons_sno"))%>';

	if(varConsType=="")
	{
		varConsType	= '<%=Helper.correctNull((String)hshValues.get("sel_ConsType"))%>';
	}
	
	var varConsType1	= '<%=Helper.correctNull((String)hshValues.get("com_wc_type"))%>';

	if(varConsType1 == "M")
	{
		document.forms[0].sel_ConsType.value	= varConsType;
		document.forms[0].sel_ConsType.disabled	= true;
	}
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=="radio")
		{
			document.forms[0].elements[i].disabled=true;		  
		} 
		 
	}
}
function callLoad()
{
	var varGetFlag	= '<%=Helper.correctNull((String)hshValues.get("hidGetFLAG"))%>';
	var varConsType	= '<%=Helper.correctNull((String)hshValues.get("com_cons_sno"))%>';

	var varBAVal	= '<%=Helper.correctNull((String)hshValues.get("com_wc_bnkarg"))%>';
	var varConsType1= '<%=Helper.correctNull((String)hshValues.get("com_wc_type"))%>';

	if(varConsType=="")
	{
		varConsType	= '<%=Helper.correctNull((String)hshValues.get("sel_ConsType"))%>';
	}
	document.forms[0].hidGetFLAG.value	= varGetFlag;

	if(document.forms[0].hidGetFLAG.value!="Yes" && varConsType1 == "M")
	{
		document.forms[0].cmdnew.disabled 		= true;
		document.forms[0].sel_ConsType.disabled = false;
	}
	else
	{
		if(varConsType1 == "M")
		{
			document.forms[0].sel_ConsType.value	= varConsType;
			document.forms[0].sel_ConsType.disabled	= false;
		}
	}
}
function callSave()
{
	var varConsType1= '<%=Helper.correctNull((String)hshValues.get("com_wc_type"))%>';
	
	if((document.forms[0].hidGetFLAG.value!="Yes" && varConsType1 == "M")||varConsType1 == "M")
	{
		document.forms[0].sel_ConsType.disabled	= false;
	}
	
}
</script>
</head>
<body onload="onloading();callLoad();">
<form name="appform" method="post" class="normal">
<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ 
  if(!strSessionModuleType.equalsIgnoreCase("RET")){%>
  <table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="3" />
			<jsp:param name="subpageid" value="104" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<table border="0" cellspacing="2" cellpadding="3" class="outertable" width="60%">
          <tr align="center">
          
       <td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'bankappfi','getData','combankingfi.jsp')">Existing Facilities</a></b></td>
		            
					<td  width="15%" nowrap align="center" class="sub_tab_inactive"><b>
          <a href="#" onclick="javascript:gotoTab(appURL,'bankapp','getBankingdetailsData','com_bankingdetails.jsp')">Asset Classification / Comments on Arrears</a></b></td> 
          <td  width="15%" nowrap align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'bankapp','getBankingArrangement','comBankingArrgnmentNew.jsp')">Banking Arrangement</a></b></td>             
			<%if((!strBATypeTL.equalsIgnoreCase("")||!strConsTypeTL.equalsIgnoreCase(""))&&!strBATypeTL.equalsIgnoreCase("S")){ %>

					<%if(strBATypeTL.equalsIgnoreCase("C")){ %>
								<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'bankappfi','getBAConsDataTL','com_BAConsortium_TL.jsp')">Consortium Details for TL</a></b></td>
					<%}else if(strBATypeTL.equalsIgnoreCase("M")){ %> 
								<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'bankappfi','getBAConsDataTL','com_BAConsortium_TL.jsp')">Multiple Banking Details for TL</a></b></td>
					<%} %>
			
			<%}if((!strBATypeWC.equalsIgnoreCase("")||!strConsTypeWC.equalsIgnoreCase(""))&&!strBATypeWC.equalsIgnoreCase("S")){%>

					<%if(strBATypeWC.equalsIgnoreCase("C")){ %>
								<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'bankappfi','getBAConsData','com_BAConsortium.jsp')">Consortium Details for WC</a></b></td>
					<%}else if(strBATypeWC.equalsIgnoreCase("M")){ %> 
								<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'bankappfi','getBAConsData','com_BAConsortium.jsp')">Multiple Banking Details for WC</a></b></td>
					<%} %>
			
			<%} %>
			
			<%if((!strBATypeWC.equalsIgnoreCase("")||!strConsTypeWC.equalsIgnoreCase(""))&&(strBATypeWC.equalsIgnoreCase("C")
			||strBATypeWC.equalsIgnoreCase("M"))){%>
			<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_active"><b>
						Existing and Proposed Exposure
			</b></td>
			<%} %>
        </table>
<%}}else{%>
	 <%if(strCategory.equalsIgnoreCase("RET")){ %> 
        <jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="12" />
        </jsp:include>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center"  class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt;  Retail -&gt; Application -&gt; Banking Arrangement -&gt; Existing Banking Details </td>
    </tr>
  </table>
  <%}
	 else
	 { %>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top" colSpan="5">
					<jsp:include page="../share/applurllinkscom.jsp" flush="true">
		        	<jsp:param name="pageid" value="3" />
		        	<jsp:param name="cattype" value="<%=strCategoryType%>" />
		        	<jsp:param name="ssitype" value="<%=strSSIType%>" /></jsp:include>
		       </td>
	    </tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	 <%if (strSessionModuleType.equalsIgnoreCase("AGR")) {
			%>
			<tr>
				<td class="page_flow">Home -&gt;Agriculture -&gt;Application -&gt; Banking Arrangement -&gt; Existing Facilities</td>
			</tr>
			<%
			}else if(strCategoryType.equalsIgnoreCase("SRE"))
		{%>
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Short Review/Extension  -&gt; Banking Arrangement -&gt; Existing Facilities</td>
	</tr>
	
	<%} else {
				%>
	<tr>
		<td class="page_flow">
	   Home	-&gt; Corporate &amp; SME -&gt; Application -&gt; Banking Arrangement -&gt; Existing Facilities<%} %>	</td>
	  </tr>
	</table>
	<%} %>
  <span style="display:none;"><lapschoice:borrowertype /></span><lapschoice:application />
  <table width="100%" border="0" cellspacing="0" cellpadding="0"	align="center" class="outertable">
	<tr align="center">
		<td valign="bottom">
		 <%if(strCategory.equalsIgnoreCase("RET")){   %> 
		  <table border="0" cellspacing="2" cellpadding="3"
			align="left" class="outertable">
			<tr>
			<td class="sub_tab_inactive" id="prin" nowrap><b>Existing  Banking Details </b></td>
			<td class="sub_tab_inactive" id="prin"><b><b><a
					href="#" onclick="javascript:callLink('comgroupcompanies.jsp','executive','getData7')">Guarantor / Group concern</a></b></b></td>
			</tr>
			</table>
		 <%}else { %>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr>
      <td><table border="0" cellspacing="2" cellpadding="3" class="outertable" width="60%">
          <tr align="center">
          
       <td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'bankappfi','getData','combankingfi.jsp')">Existing Facilities</a></b></td>
						
            <td  width="15%" nowrap align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'bankapp','getBankingdetailsData','com_bankingdetails.jsp')">Asset Classification / Comments on Arrears </a></b></td>
			<td  width="15%" nowrap align="center" class="sub_tab_inactive"><b><a href="#" onclick="javascript:gotoTab(appURL,'compro','getFinancialComments','com_bankcomments.jsp')">Other Comments</a></b></td>
		            <td  width="15%" nowrap align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'bankapp','getBankingArrangement','comBankingArrgnmentNew.jsp')">Banking Arrangement</a></b></td>
					              
			<%if((!strBATypeTL.equalsIgnoreCase("")||!strConsTypeTL.equalsIgnoreCase(""))&&!strBATypeTL.equalsIgnoreCase("S")){ %>

					<%if(strBATypeTL.equalsIgnoreCase("C")){ %>
								<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'bankappfi','getBAConsDataTL','com_BAConsortium_TL.jsp')">Consortium Details for TL</a></b></td>
					<%}else if(strBATypeTL.equalsIgnoreCase("M")){ %> 
								<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'bankappfi','getBAConsDataTL','com_BAConsortium_TL.jsp')">Multiple Banking Details for TL</a></b></td>
					<%} %>
			
			<%}if((!strBATypeWC.equalsIgnoreCase("")||!strConsTypeWC.equalsIgnoreCase(""))&&!strBATypeWC.equalsIgnoreCase("S")){%>

					<%if(strBATypeWC.equalsIgnoreCase("C")){ %>
								<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'bankappfi','getBAConsData','com_BAConsortium.jsp')">Consortium Details for WC</a></b></td>
					<%}else if(strBATypeWC.equalsIgnoreCase("M")){ %> 
								<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'bankappfi','getBAConsData','com_BAConsortium.jsp')">Multiple Banking Details for WC</a></b></td>
					<%} %>
			
			<%} %>
			
			<%if((!strBATypeWC.equalsIgnoreCase("")||!strConsTypeWC.equalsIgnoreCase(""))&&(strBATypeWC.equalsIgnoreCase("C")
			||strBATypeWC.equalsIgnoreCase("M"))){%>
			<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_active"><b>
						Existing and Proposed Exposure
			</b></td>
			<%} %>
        </table></td>
    </tr>
  </table>
  <%} %>
  </td>
  </tr>
  </table>
  <%} %>
  <table width="98%"  border="0" cellspacing="0" cellpadding="0"	align="center" class="outertable">
  	<tr>
  		<td><br>
	  		<table width="80%" border="0" cellspacing="0" cellpadding="3"	align="center" class="outertable">
	  		 <%if(Helper.correctNull((String)hshValues.get("com_wc_type")).equalsIgnoreCase("M")){ %>
				<tr class="dataheader">
					<td align="center">Consortium Type &nbsp;&nbsp;
						<select name="sel_ConsType" onchange="getConsValue();">
							<option value="" selected="selected">&lt;----Select----&gt;</option>
							<lapschoice:BAConsortiumTag contype="WC"/>
						</select>
					</td>
				 </tr>
				 <%} %>
	  		</table>
  			 <table width="80%" border="0" cellspacing="1" cellpadding="3"	align="center" class="outertable">
  			 <tr class="dataheader" >
  			  <td> &nbsp;&nbsp;	Name of the Bank  </td>
  			  <td colspan="6" align="center"> 	Existing Exposure  </td>
  			  <td colspan="6" align="center">  Proposed Exposure </td>
  			  </tr>
  			<tr align="center" class="dataheader">
  			  	<td >&nbsp;</td>
  			  	<td >FB</td>
  			  	<td >% FB exposure</td>
  			  	<td >NFB</td>
  			  	<td >% NFB Exposure</td>
  			  	<td >Total</td>
  			  	<td >% Total exposure</td>
  				<td >FB</td>
  			  	<td >% FB exposure</td>
  			  	<td >NFB</td>
  			  	<td >% NFB Exposure</td>
  			  	<td >Total</td>
  			  	<td >% Total exposure</td>
  			  </tr>
  			  <tr class="datagrid">
  			  	<td nowrap="nowrap">
  			  		<input type="text" name="txt_bankName" size="20" Maxlength="20" readonly="readonly">
										<span onClick="callBankmaster('147','0')" style="cursor: hand">
										<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0"></span>
  			  		
  			  		<input type="hidden" name="hid_sno">
  			  	</td>
  			  	<td>
  			  			<lapschoice:CurrencyTag name="txt_existFb"
											maxlength="10" size="10" 
											onKeyPress="allowDecimals(this)" style="text-align:right"
											onBlur="roundtxt(this);FBExposure()" other="readOnly" value="0.00" />
  			  	</td>
  			  		<td>
  			  				  		<lapschoice:CurrencyTag name="txt_existFbExpo"
											maxlength="5" size="10" 
											onKeyPress="allowDecimals(this)" style="text-align:right"
											onBlur="roundtxt(this);FBExposure()" other="readOnly" value="0.00"/>
  			  	</td>
  			  	<td>
  			  		<lapschoice:CurrencyTag name="txt_existNfb"
											maxlength="10" size="10" 
											onKeyPress="allowDecimals(this)" style="text-align:right"
											onBlur="roundtxt(this);FBExposure()" other="readOnly" value="0.00"/>
  			  	</td>
  			  	<td>
  			  		<lapschoice:CurrencyTag name="txt_existNfbExpo"
											maxlength="5" size="10" 
											onKeyPress="allowDecimals(this)" style="text-align:right"
											onBlur="roundtxt(this);FBExposure()" other="readOnly" value="0.00"/>
  			  	</td>
  			  		<td>
  			  		<lapschoice:CurrencyTag name="txt_existTot"
											maxlength="10" size="10" 
											onKeyPress="allowDecimals(this)" style="text-align:right"
											onBlur="roundtxt(this);FBExposure()" other="readOnly" value="0.00"/>
  			  	</td>
  			  	<td>
  			  			<lapschoice:CurrencyTag name="txt_existTotExpo"
											maxlength="5" size="10" 
											onKeyPress="allowDecimals(this)" style="text-align:right"
											onBlur="roundtxt(this);FBExposure()" other="readOnly" value="0.00"/>
  			  	</td>
  			  	<td>
  			  		<lapschoice:CurrencyTag name="txt_PropFb"
											maxlength="10" size="10" 
											onKeyPress="allowDecimals(this)" style="text-align:right"
											onBlur="roundtxt(this);FBExposure()" other="readOnly" value="0.00"/>
  			  	</td>
  			  		<td>
  			  			<lapschoice:CurrencyTag name="txt_PropFbExpo"
											maxlength="5" size="10" 
											onKeyPress="allowDecimals(this)" style="text-align:right"
											onBlur="roundtxt(this);FBExposure()" other="readOnly" value="0.00"/>
  			  	</td>
  			  	<td>
  			  		<lapschoice:CurrencyTag name="txt_PropNfb"
											maxlength="10" size="10" 
											onKeyPress="allowDecimals(this)" style="text-align:right"
											onBlur="roundtxt(this);FBExposure()" other="readOnly" value="0.00"/>
  			  	</td>
  			  	<td>
  			  			<lapschoice:CurrencyTag name="txt_PropNfbExpo"
											maxlength="5" size="10" 
											onKeyPress="allowDecimals(this)" style="text-align:right"
											onBlur="roundtxt(this);FBExposure()" other="readOnly" value="0.00"/>
  			  	</td>
  			  		<td>
  			  		<lapschoice:CurrencyTag name="txt_PropTot"
											maxlength="10" size="10" 
											onKeyPress="allowDecimals(this)" style="text-align:right"
											onBlur="roundtxt(this);FBExposure()" other="readOnly" value="0.00" />
  			  	</td>
  			  	<td>
  			  		<lapschoice:CurrencyTag name="txt_PropTotExpo"
											maxlength="5" size="10" 
											onKeyPress="allowDecimals(this)" style="text-align:right"
											onBlur="roundtxt(this)" other="readOnly" value="0.00"/>
  			  	</td>
  			  </tr>
  			</table>
  		</td>
  	</tr>
  	<!-- Commented by Kishan
  	<tr>
  		<td>
  			<table width="70%" class="outertable"  border="0" cellspacing="0" cellpadding="2" align="center">
  				<tr>
  					<td nowrap="nowrap" align="right">
  						<input type="checkbox" name="proposalNote" border="0" style="border: none;"><span>Whether to be displayed in Proposal Note</span>
  				    </td>
  					<td  nowrap="nowrap">
  						<input type="checkbox" name="Annexure3" border="0" style="border: none;"><span>Whether to be displayed in Annexure III</span>
  					</td>
  				</tr>
  			</table>
  		</td>
  	</tr>
  	 -->
  	<tr>
  		<td>
  		<br/>
  		<lapschoice:combuttonnew btnnames="New_Edit_Save_Delete_Cancel_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
  		<br/>
  		</td>
  	</tr>
  	<tr>
  		<td>
  			  <table width="98%" border="0" cellspacing="1" cellpadding="3"	align="center" class="outertable">
  				<tr align="center" class="dataheader">
  			  <td>&nbsp;</td>
  			  <td> 	Name of the Bank  </td>
  			  <td colspan="6"> 	Existing Exposure  </td>
  			  <td colspan="6">  Proposed exposure </td>
  			  </tr>
  			 <tr align="center" class="dataheader" >
  			  	<td width="1%">&nbsp;</td>
  			  	<td width="9%">&nbsp;</td>
  			  	<td width="8%">FB</td>
  			  	<td width="7%">% FB exposure</td>
  			  	<td width="8%">NFB</td>
  			  	<td width="7%">% NFB Exposure</td>
  			  	<td width="8%">Total</td>
  			  	<td width="7%">% Total exposure</td>
  			  	<td width="8%">FB</td>
  			  	<td width="7%">% FB exposure</td>
  			  	<td width="8%">NFB</td>
  			  	<td width="7%">% NFB Exposure</td>
  			  	<td width="8%">Total</td>
  			  	<td width="7%">% Total exposure</td>
  			  </tr>
  			  <%
  			if (vecRow != null && vecRow.size()>0)
			{
				vecsize = vecRow.size();
		
		for(int i=0;i<vecsize;i++)
		{
			vecCol=(ArrayList)vecRow.get(i);
  			  %>
  			 <tr class="datagrid">
  			  	<td>
  			  		<input type="radio" name="rd_Select"  style="border-style:none" onClick="selectValues('<%=Helper.correctNull((String)vecCol.get(0))%>',
  			  		'<%=Helper.correctNull((String)vecCol.get(1))%>',
  			  		'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(2))))%>',
  			  		'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(3))))%>',
  			  		'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(4))))%>',
  			  		'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(5))))%>',
  			  		'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(6))))%>',
  			  		'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(7))))%>',
  			  		'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(8))))%>',
  			  		'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(9))))%>',
  			  		'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(10))))%>',
  			  		'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(11))))%>',
  			  		'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(12))))%>',
  			  		'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(13))))%>')">
  			  	</td>
  			  	<td>
  			  		  		<%=Helper.correctInt((String)vecCol.get(1))%>
  			  	</td>
  			  	<td style="text-align: right">
  			  	<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(2))))%>
  			  	</td>
  			  	<td style="text-align: right">
  			  	<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(3))))%>
  			  	</td>
  			  	<td style="text-align: right">
  			  	<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(4))))%>
  			  	</td>
  			  	<td style="text-align: right">
  			  	<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(5))))%>
  			  	</td>
  			  	<td style="text-align: right">
  			  	<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(6))))%>
  			  	</td>
  			  	<td style="text-align: right">
  			  	<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(7))))%>
  			  	</td>
  			  	<td style="text-align: right">
  			  	<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(8))))%>
  			  	</td>
  			  	<td style="text-align: right">
  			  	<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(9))))%>
  			  	</td>
  			  	<td style="text-align: right">
  			  	<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(10))))%>
  			  	</td>
  			  	<td style="text-align: right">
  			  	<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(11))))%>
  			  	</td>
  			  	<td style="text-align: right">
  			  	<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(12))))%>
  			  	</td>
  			  	<td style="text-align: right">
  			  	<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(13))))%>
  			  	</td>
  			  </tr>
  			 <%} %>
  			 
  			 <%if(vecsize>0){ %>
			<tr class="dataheader">
			<td>&nbsp;</td>
  				<td>  Total </td>
  			  	<td style="text-align: right">  <%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("FbSum"))))%></td>
  			  	<td style="text-align: right">  100.00 </td>
  			  	<td style="text-align: right"> <%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("NfbSum"))))%> </td>
  			  	<td style="text-align: right">  100.00 </td>
  			  	<td style="text-align: right">  <%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("ExistSum"))))%> </td>
  			  	<td style="text-align: right">  100.00 </td>
  			  	<td style="text-align: right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("ProFbSum"))))%> </td>
  			  	<td style="text-align: right">100.00 </td>
  			  	<td style="text-align: right"> <%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("ProNfbSum"))))%></td>
  			  	<td style="text-align: right">  100.00 </td>
  			  	<td style="text-align: right"> <%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("ProSum"))))%> </td>
  			  	<td style="text-align: right">  100.00</td>
  			  </tr>
			<%} } else { %>
			<tr class="datagrid"><td colspan="14" align="center">No Data Found</td></tr>
			<% } %>
  			</table>
  		</td>
  	</tr>
  </table>
  	<lapschoice:hiddentag pageid='<%=PageId%>'/>
  	
  	<input type="hidden" name="hidsno" value="">
	<input type="hidden" name="hidGetFLAG" value="">
	<input type="hidden" name="hidFBSum" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("FbSum"))))%>">
	<input type="hidden" name="hidNfbSum" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("NfbSum"))))%>">
	<input type="hidden" name="hidExistSum" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("ExistSum"))))%>">
	<input type="hidden" name="hidProFbSum" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("ProFbSum"))))%>">
	<input type="hidden" name="hidProNfbSum" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("ProNfbSum"))))%>">
	<input type="hidden" name="hidProSum" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("ProSum"))))%>">
  </form>
  </body>
  </html>