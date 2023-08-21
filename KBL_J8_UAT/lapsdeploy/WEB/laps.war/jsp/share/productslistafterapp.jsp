<!-- Added by Zahoorunnisa.S on july 10th 3:28 PM to change the product even after application created-->
<%@include file="../share/directives.jsp"%>
<%
	String strApptype = ""; //= Helper.correctNull(request.getParameter("apptype"));
	if (strApptype.equalsIgnoreCase("")) {
		strApptype = Helper.correctNull((String) hshValues.get("apptype"));
	}
	ArrayList v = (ArrayList) hshValues.get("arryRow");
 	ArrayList arryCol = new ArrayList();
	String strStaffFlag = Helper.correctNull((String) request.getParameter("hidStaffFlag"));
	String appage = Helper.correctNull((String) request.getParameter("perapp_age"));
	String strApplId = Helper.correctNull((String) request.getParameter("comappid"));
	
%>

<html>
<head>
<style type="text/css">
DIV.cellContainer 
{	
  width: 100%; height: 325;
  overflow: auto;
}
</style>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>

<SCRIPT LANGUAGE="JavaScript">
var appURL="<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var apptype="<%=strApptype%>";


function getSelectedValue(val)
{	
	var varproducthelp=val;
	/*if(varproducthelp == -1)
	{
		ShowAlert(111,'Product');
		return false;
	}*/
	//if(apptype.toUpperCase()=='P' || apptype.toUpperCase()=='A')
	{
		//if(varproducthelp!=-1 && varproducthelp!=null)
		{	
			var varValue=val;
			var varArr= varValue.split("$");
			
			window.opener.document.forms[0].hidProductID.value=varArr[0];
			window.opener.document.forms[0].prd_type.value=varArr[2];
			window.opener.document.forms[0].minterm.value=varArr[9];	
			if(varArr[2].charAt(0)=="a")
			{
				window.opener.document.forms[0].hidApploanType.value="A";
			}
			else
			{
				window.opener.document.forms[0].hidApploanType.value="P";
			}
			
			if(varArr[8]!="" && document.forms[0].hidappage.value !="")
			{
				if(parseInt(document.forms[0].hidappage.value) <= parseInt(varArr[7]))
				{
					alert("The applicant is not eligible based on age");
					return;
				}
			}
						
			window.opener.document.forms[0].txtloan_modintrate.readOnly=true;
			window.opener.document.forms[0].txtprd_desc.value=varArr[3];
			window.opener.document.forms[0].hidPrincipalRatio.value=varArr[4];
			window.opener.document.forms[0].hidInterestRatio.value=varArr[5];
			window.opener.document.forms[0].hidStaffProduct.value=varArr[6];
			if(document.forms[0].hidStaffFlag.value=="Y" && document.forms[0].hidCategoryType.value=="RET" && 
				NanNumber(parseFloat(varArr[4]))>0 && NanNumber(parseFloat(varArr[5]))>0)
			{
				window.opener.document.all.interestEMI1.style.visibility="visible";
				window.opener.document.all.interestEMI2.style.visibility="visible";
				window.opener.document.all.interestEMI3.style.visibility="visible";
				window.opener.document.all.idcooperative.style.visibility="visible";
				window.opener.document.forms[0].co_operative.value="2";
				
				if(NanNumber(parseInt(document.forms[0].hidServiceLeft.value))>0  && NanNumber(parseInt(document.forms[0].hidServiceLeft.value))>=NanNumber(parseFloat(varArr[1])))
				{
					window.opener.document.forms[0].repayperiod.value=varArr[1];
					window.opener.document.forms[0].periods.value=varArr[1];	
					window.opener.document.forms[0].txtloan_reqterms.value=varArr[1];
				}
				else if(NanNumber(parseInt(document.forms[0].hidServiceLeft.value))==0)
				{
					window.opener.document.forms[0].repayperiod.value=varArr[1];
					window.opener.document.forms[0].periods.value=varArr[1];	
					window.opener.document.forms[0].txtloan_reqterms.value=varArr[1];
				}
				else
				{
					if(parseInt(document.forms[0].hidServiceLeft.value)<0)
					{
						alert("The applicant is retired, so not eligible for this product");
						return;
					}
					else
					{
						window.opener.document.forms[0].repayperiod.value=document.forms[0].hidServiceLeft.value;
						window.opener.document.forms[0].periods.value=document.forms[0].hidServiceLeft.value;
						window.opener.document.forms[0].txtloan_reqterms.value=document.forms[0].hidServiceLeft.value;
					}
				}


				
			}
			else
			{
				window.opener.document.all.interestEMI1.style.visibility="hidden";
				window.opener.document.all.interestEMI2.style.visibility="hidden";
				window.opener.document.all.interestEMI3.style.visibility="hidden";
				window.opener.document.forms[0].repayperiod.value=varArr[1];	
				//window.opener.document.forms[0].periods.value=varArr[1];
				window.opener.document.forms[0].txtloan_reqterms.value=varArr[1];
			}
			if(varArr[9]=="1")
			{
					document.all.ifrms.src=appURL+"action/ifrm_nscloancheck.jsp?&hidBeanGetMethod=getNSCloancheck&hidBeanId=perapplicant&currdate="+currdate+"&strApplicantid="+<%=strApplId%>;
			}
			
			window.opener.document.forms[0].txtloan_amtreqd.value="";
			window.opener.document.forms[0].txtloan_costloanprd.value="";
			//window.opener.document.forms[0].txtloan_tradein.value="";
			//window.opener.document.forms[0].txtloan_loantrade.value="";
			//window.opener.document.forms[0].txtnetTradeIn.value="";
			window.opener.document.forms[0].txtloan_downpay.value="";
			//window.opener.document.forms[0].actLoanValRatio.value="";
			//window.opener.document.forms[0].txtloan_recmdamt.value="";
			window.opener.document.forms[0].txtmonPay.value="0.00";
			if(document.forms[0].hidCategoryType.value=="AGR")
			{
				window.opener.document.all.measurementtype.style.visibility="visible";
				window.opener.document.all.Measurementtype1.style.visibility="visible";
			}
			else
			{
				window.opener.document.all.measurementtype.style.visibility="hidden";
				window.opener.document.all.Measurementtype1.style.visibility="hidden";
			}
			window.opener.document.forms[0].txtloan_amtreqd.focus();
			
			if(document.forms[0].hidCategoryType.value=="LAD")
			{
				window.opener.document.forms[0].selectinttype.value="1";
				window.opener.document.forms[0].sel_peridicity.value="n";
				window.opener.document.forms[0].txtloan_reqterms.value="12";
				window.opener.getrepayment();
				window.opener.document.forms[0].txt_installments.value="0";
				window.opener.document.forms[0].selrepaymenttype.value="12";
				window.opener.document.all.idinttype1.style.visibility="hidden";
				window.opener.document.all.idinttype2.style.visibility="hidden";
				window.opener.document.all.idint1.style.visibility="hidden";
				window.opener.document.all.idint2.style.visibility="hidden";
				window.opener.document.all.idperiod.style.visibility="hidden";
				window.opener.document.all.idperiod1.style.visibility="hidden";
				window.opener.document.all.idperiod2.style.visibility="hidden";
				window.opener.document.all.idmargin.style.visibility="hidden";
			}
			if(document.forms[0].hidCategoryType.value=="LAD" && varArr[2]=="aR")
			{
				window.opener.document.forms[0].selectinttype.value="1";
				window.opener.document.forms[0].sel_peridicity.value="n";
				window.opener.document.forms[0].txtloan_reqterms.value="12";
				window.opener.getrepayment();
				window.opener.document.forms[0].txt_installments.value="0";
				window.opener.document.forms[0].selrepaymenttype.value="12";
			}
			
			/*if(varArr[21]=="1")
			{
				
			}
			else
			{*/
			window.close();
			//}
		}
		/*else
		{
			ShowAlert(111,'Product');
		}*/
			
		
	}
	
	
}

function producttype()
{
	document.forms[0].prd_name.value="";
	document.forms[0].prd_name.focus();
}

function callonload()
{
	/*if(apptype=="p")
	{
		document.forms[0].prd_producttype[0].checked=true;
		document.forms[0].prd_name.focus();
	}
	else if (apptype="a")
	{
		document.forms[0].prd_producttype[1].checked=true;
		document.forms[0].prd_name.focus();
	}*/
}
function doSearch()
{
	var prdtype="";
	/*if(document.forms[0].prd_producttype[0].checked==true )
	{
		if(document.forms[0].prd_name.value=="")
		{
			alert("Enter data for retail search criteria");
			document.forms[0].prd_name.focus();
			return;
		}
		else
		{
			prdtype="p";
		}
	}
	else if(document.forms[0].prd_producttype[1].checked==true )
	{
		if( document.forms[0].prd_name.value=="")
		{
			alert("Enter data for agriculture search criteria");
			document.forms[0].prd_name.focus();
			return;
		}
		else
		{
		prdtype="a";
		}
	}*/
	if(document.forms[0].prd_name.value=="")
		{
			alert("Enter data for search criteria");
			document.forms[0].prd_name.focus();
			return;
		}
	var bowid=document.forms[0].comappid.value;
	var orgscode1 = document.forms[0].orgscode1.value;
	var orgcode1 = document.forms[0].orgcode1.value;
	var orglevel1 = document.forms[0].orglevel1.value;

	prdname=document.forms[0].prd_name.value;
	document.forms[0].hidBeanId.value="appeditlock";
	document.forms[0].hidBeanGetMethod.value="getProductAppList";
	document.forms[0].action=appURL+"action/productslistafterapp.jsp?prdtype="+prdtype+"&prdname="+prdname+"&orgscode="+orgscode1+"&orgcode="+orgcode1+"&orglevel="+orglevel1;
	document.forms[0].submit();

}

</SCRIPT>
<body onload="callonload()">
<form name="productlisthelp" method="post" class="normal">

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellpadding="3" cellspacing="0" class="outertable">
			<tr>
				<td colspan="2" align="right"><b>Products</b>
				</td>
				<td width="20%"><input type="text" name="prd_name" size="20"
							onKeyPress="allowAlphaNumericSpace()"></td>
				<td width="35%"><input type="button" name="search" value="Search"
							class="buttonStyle"
							onClick="doSearch()"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<div class="cellcontainer">
<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
	<%String inside = "N";
			String strStaffproduct = "";
			if (v != null) {
				int vecsize = v.size();
				int intRowNumber = 1;
				//out.println(v);
				for (int l = 0; l < vecsize; l++) {
					inside = "Y";
					arryCol = (ArrayList) v.get(l);
					String strConcat = "";
					String val = "$";
					String val1 = "-";
					strConcat = (String) arryCol.get(1) + val1
							+ (String) arryCol.get(2) + val1
							+ (String) arryCol.get(3) + val1
							+ (String) arryCol.get(4)+ val1
							+ (String) arryCol.get(12);

					//Hide Staff loans for non staff customers
					strStaffproduct = Helper.correctNull(
							(String) arryCol.get(9)).trim();
					if (!(strStaffFlag.trim().equalsIgnoreCase("N") && strStaffproduct
							.equalsIgnoreCase("Y"))) {

						%>
	<tr valign="top">
		<td width="3%"><b><%=intRowNumber++%>.</b></td>
		<td width="97%" align="left"><a
			href="javascript:getSelectedValue('<%=(String)arryCol.get(0)%><%=val%>
												<%=(String)arryCol.get(5)%><%=val%>
												<%//=(String)arryCol.get(6)%><%//=val%>
												<%=(String)arryCol.get(6)%><%=val%>
												<%=strConcat%><%=val%>
												<%=(String)arryCol.get(7)%><%=val%>
												<%=(String)arryCol.get(8)%><%=val%>
												<%=(String)arryCol.get(9)%><%=val%>
												<%=(String)arryCol.get(10)%><%=val%>
												<%=(String)arryCol.get(11)%><%=val%>
												<%=(String)arryCol.get(13)%>')"
			class="blackfont" align="center"><b><%=(String) arryCol.get(1)%><%=val1%><%=(String) arryCol.get(2)%><%=val1%><%=(String) arryCol.get(3)%><%=val1%><%=(String) arryCol.get(4)%>
		<%=val1%><%=(String) arryCol.get(12)%></b></a></td>
	</tr>
	<%}
				}
			}

			%>

	<%if (inside.equals("N")) {

			%>

	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr valign="top">
		<td colspan="2" width="15%" align="center"><b>No Data Found for the
		selected criteria</b></td>
	</tr>
	<%}%>
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td width="3%">&nbsp;</td>
		<td width="97%">&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>

</table>
</div>
<br>
<table width="10%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
	<tr valign="top">
		<!--<td width="20%"><input type="button" class="buttonStyle" value="OK"
			name="createbtn" tabindex="21" onClick="getSelectedValue()"></td>-->
	<td width="20%"><input type="button" class="buttonClose" value="Close"
			name="closebtn" tabindex="25" onClick="window.close()"></td>
	</tr>
</table>
<input type="hidden" name="comappid" value="<%=Helper.correctNull((String) request.getParameter("comappid"))%>">
<input type="hidden" name="apptype" value="<%=Helper.correctNull((String)request.getParameter("apptype"))%>">
<input type="hidden" name="hidBeanId" value="appeditlock"> 
<input type="hidden" name="hidBeanGetMethod" value="getProductAppList"> 
<input type="hidden" name="orgscode1" value="<%=Helper.correctNull((String)session.getAttribute("strOrgShortCode"))%>">
<input type="hidden" name="orgcode1" value="<%=Helper.correctNull((String)session.getAttribute("strOrgCode"))%>">
<input type="hidden" name="orglevel1" value="<%=Helper.correctNull((String)session.getAttribute("strOrgLevel"))%>">
<input type="hidden" name="hidStaffFlag" value="<%=Helper.correctNull((String)request.getParameter("hidStaffFlag"))%>">
<input type="hidden" name="hidServiceLeft" value="<%=Helper.correctNull((String)request.getParameter("hidServiceLeft"))%>">
<input type="hidden" name="hidCategoryType" value="<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>"> 
<INPUT TYPE="hidden" name="bowid" value="<%//=bowid%>"> 
<input type="hidden" name="hidappage" value="<%=appage%>"> 
<iframe height="0" width="0" id="ifrms" frameborder="0" style="border:0"></iframe>
</form>
</body>
</html>
