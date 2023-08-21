<%@include file="../share/directives.jsp"%>
<%
	ArrayList vecData = new ArrayList();
	String eduyear1[] = new String[27];
	String eduyear2[] = new String[27];
	String eduyear3[] = new String[27];
	String eduyear4[] = new String[27];
	String eduyear5[] = new String[27];
	String eduyear6[] = new String[27];
	String comments[] = new String[27];

	int vecsize = 0;
	if (hshValues != null & vecData != null) {
		vecData = (ArrayList) hshValues.get("vecCol");
		vecsize = vecData.size();

		ArrayList g1 = new ArrayList();

		int k = 0;

		//System.out.println("0" + vecsize);
		for (int i = 0; i < vecsize; i++) {
			g1 = (ArrayList) vecData.get(i);

			if (Helper.correctNull((String) g1.get(7))
					.equals("e")) {
				eduyear1[k] = (String) g1.get(0);
				eduyear2[k] = (String) g1.get(1);
				eduyear3[k] = (String) g1.get(2);
				eduyear4[k] = (String) g1.get(3);
				eduyear5[k] = (String) g1.get(4);
				eduyear6[k] = (String) g1.get(5);
				//totalexpenses[i] = (String) g1.get(6);
				comments[k] = (String) g1.get(6);

				k++;
			}

		}

		for (int i = 0; i < vecsize; i++) {
			g1 = (ArrayList) vecData.get(i);

			if (Helper.correctNull((String) g1.get(7))
					.equals("s")) {
				//System.out.println("1" + k);
				eduyear1[k] = (String) g1.get(0);
				eduyear2[k] = (String) g1.get(1);
				eduyear3[k] = (String) g1.get(2);
				eduyear4[k] = (String) g1.get(3);
				eduyear5[k] = (String) g1.get(4);
				eduyear6[k] = (String) g1.get(5);
				//totalexpenses[i] = (String) g1.get(6);
				comments[k] = (String) g1.get(6);

				k++;
				//System.out.println("2" + k);
			}

		}
	}
%>

<html>
<head>
<title>Commercial-Principal (s)</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/per/educourse.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var length = "<%=vecsize%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";


function gototab(beanid,methodname,pagename)
{
	if(document.forms[0].hideditflag.value=="N")
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
</script>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body
	onload="onloading(),total1year(),total2year(),total3year(),total4year(),total5year(),total6year(),totalexp1year(),totalexp2year(),totalexp3year(),totalexp4year(),totalexp5year(),totalexp6year();totexpval();totalexpval();totalexpensesvalue();totsourceval();totalexpensesvalue1()">
<form name="frmpri" method="post" class="normal">
<table width="100%" border="1" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td valign="top"><jsp:include
					page="../share/Applurllinkper.jsp" flush="true">
					<jsp:param name="pageid" value="1" />
				</jsp:include></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="99%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Retail(including schematic) -&gt; Application -&gt;
		Loan Particulars -&gt; Details for Educational Loan -&gt; Course
		Expenses</td>
		<lapschoice:application />
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="bottom">
		<table width="93%" border="0" cellspacing="0" cellpadding="0"
			class="outertable" align="left">
			<tr align="center">
				<td><jsp:include page="../per/applicanttab.jsp" flush="true">
					<jsp:param name="linkid" value="7" />
				</jsp:include></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="3"
			class="outertable" align="left">
			<tr>
				<!-- <td width="20%" align="center" id="prm" class="sub_tab_inactive"><b><a
					href="javascript:callLink('edustudent.jsp','edustudent','getData')">Particulars
				of Student</a></b></td> -->
				<td width="20%" align="center" id="com2" class="sub_tab_inactive"><a
					href="javascript:callLink('edueducational.jsp','edudetails','getData')"><b>Educational
				Details</b></a></td>
				<td width="20%" align="center" id="com2" class="sub_tab_inactive"><a
					href="javascript:callLink('eduscholarship.jsp','eduscholar','getData')">
				<b>Scholarship </b></a></td>
				<td width="20%" align="center" id="com2" class="sub_tab_inactive"><a
					href="javascript:callLink('eduparticulars.jsp','eduparticulars','getData')"><b>Course
				Details</b></a></td>
				<td width="20%" align="center" id="com2" class="sub_tab_active"><b>Course
				Expenses</b></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="98%" border="0" cellspacing="0" cellpadding="5"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="1" cellspacing="0" cellpadding="2"
			class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="outertable">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="3"
							class="outertable">
							<tr>
								<td><font color="#CC0000">All values are in <%=ApplicationParams.getCurrency()%></font></td>
							</tr>
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="2"
									class="outertable">
									<tr class="dataheader">
										<td colspan='2' align='center'>Cost of Estimates</td>
										<td colspan='7' align="center">Year of Study</td>
									</tr>
									<tr class="dataheader">
										<td width="4%">S No.</td>
										<td width="20%">Item of Expenses</td>
										<td width="10%" align="center">I</td>
										<td width="10%" align="center">II</td>
										<td width="10%" align="center">III</td>
										<td width="10%" align="center">IV</td>
										<td width="10%" align="center">V</td>
										<td width="10%" align="center">VI</td>
										<td width="20%" align="center">Total Expenses</td>
									</tr>
									<tr align="center" class="datagrid">
										<td>1</td>
										<td align='left'>College Fees <input name="description"
											type="hidden" size="2" maxlength="2" value="College Fees"></td>
										<td align="center" valign="middle"><lapschoice:CurrencyTag
											name="txt_Iyear" size="16" maxlength="12"
											value='<%=Helper.correctNull((String) eduyear1[0])%>'
											onBlur="getTotalValue(this, document.forms[0].txt_2year[0], document.forms[0].txt_3year[0], document.forms[0].txt_4year[0], document.forms[0].txt_5year[0], document.forms[0].txt_6year[0],document.forms[0].txt_totalexpenses[0],document.forms[0].txt_TotalExpensesValue);total1year()" />
										</td>
										<td><lapschoice:CurrencyTag name="txt_2year" size="16"
											maxlength="12"
											value='<%=Helper.correctNull((String) eduyear2[0])%>'
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[0], document.forms[0].txt_3year[0], document.forms[0].txt_4year[0], document.forms[0].txt_5year[0], document.forms[0].txt_6year[0], document.forms[0].txt_totalexpenses[0],document.forms[0].txt_TotalExpensesValue);total2year();" />
										</td>
										<td><lapschoice:CurrencyTag name="txt_3year" size="16"
											maxlength="12"
											value='<%=Helper.correctNull((String) eduyear3[0])%>'
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[0], document.forms[0].txt_2year[0], document.forms[0].txt_4year[0], document.forms[0].txt_5year[0], document.forms[0].txt_6year[0], document.forms[0].txt_totalexpenses[0],document.forms[0].txt_TotalExpensesValue);total3year();" />
										</td>
										<td><lapschoice:CurrencyTag name="txt_4year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[0], document.forms[0].txt_2year[0], document.forms[0].txt_3year[0], document.forms[0].txt_5year[0], document.forms[0].txt_6year[0], document.forms[0].txt_totalexpenses[0],document.forms[0].txt_TotalExpensesValue);total4year();"
											value='<%=Helper.correctNull((String) eduyear4[0])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_5year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[0], document.forms[0].txt_2year[0], document.forms[0].txt_3year[0], document.forms[0].txt_4year[0], document.forms[0].txt_6year[0], document.forms[0].txt_totalexpenses[0],document.forms[0].txt_TotalExpensesValue);total5year();"
											value='<%=Helper.correctNull((String) eduyear5[0])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_6year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[0], document.forms[0].txt_2year[0], document.forms[0].txt_3year[0], document.forms[0].txt_4year[0], document.forms[0].txt_5year[0], document.forms[0].txt_totalexpenses[0],document.forms[0].txt_TotalExpensesValue);total6year();"
											value='<%=Helper.correctNull((String) eduyear6[0])%>' /></td>
										<td><input type="text" name="txt_totalexpenses"
											onKeyPress="allowNumber(this)" size="16" maxlength="12"
											style="text-align: right" readOnly="readonly" value=""></td>
									</tr>
									<tr align="center" class="datagrid">
										<td>2</td>
										<td align="left">Books/Equipments/Instruments/Uniforms<input
											name="description" type="hidden" size="2" maxlength="2"
											value="Books/Equipments/instruments/uniforms"></td>
										<td valign="middle" align="center"><lapschoice:CurrencyTag
											name="txt_Iyear" size="16" maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_2year[1], document.forms[0].txt_3year[1], document.forms[0].txt_4year[1], document.forms[0].txt_5year[1], document.forms[0].txt_6year[1],document.forms[0].txt_totalexpenses[1],document.forms[0].txt_TotalExpensesValue);total1year();"
											value='<%=Helper.correctNull((String) eduyear1[1])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_2year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[1], document.forms[0].txt_3year[1], document.forms[0].txt_4year[1], document.forms[0].txt_5year[1], document.forms[0].txt_6year[1], document.forms[0].txt_totalexpenses[1],document.forms[0].txt_TotalExpensesValue);total2year();"
											value='<%=Helper.correctNull((String) eduyear2[1])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_3year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[1], document.forms[0].txt_2year[1], document.forms[0].txt_4year[1], document.forms[0].txt_5year[1], document.forms[0].txt_6year[1], document.forms[0].txt_totalexpenses[1],document.forms[0].txt_TotalExpensesValue);total3year();"
											value='<%=Helper.correctNull((String) eduyear3[1])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_4year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[1], document.forms[0].txt_2year[1], document.forms[0].txt_3year[1], document.forms[0].txt_5year[1], document.forms[0].txt_6year[1], document.forms[0].txt_totalexpenses[1],document.forms[0].txt_TotalExpensesValue);total4year();"
											value='<%=Helper.correctNull((String) eduyear4[1])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_5year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[1], document.forms[0].txt_2year[1], document.forms[0].txt_3year[1], document.forms[0].txt_4year[1], document.forms[0].txt_6year[1], document.forms[0].txt_totalexpenses[1],document.forms[0].txt_TotalExpensesValue);total5year();"
											value='<%=Helper.correctNull((String) eduyear5[1])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_6year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[1], document.forms[0].txt_2year[1], document.forms[0].txt_3year[1], document.forms[0].txt_4year[1], document.forms[0].txt_5year[1], document.forms[0].txt_totalexpenses[1],document.forms[0].txt_TotalExpensesValue);total6year();"
											value='<%=Helper.correctNull((String) eduyear6[1])%>' /></td>
										<td><input type="text" name="txt_totalexpenses"
											onKeyPress="allowNumber(this)" size="16" maxlength="12"
											style="text-align: right" ReadOnly="readonly" value=""></td>
									</tr>
									<tr align="center" class="datagrid">
										<td height="23">3</td>
										<td align="left">Cost of Computer  <input
											name="description" type="hidden" size="2" maxlength="2"
											value="Cost of Computer"></td>
										<td valign="middle" align="center"><lapschoice:CurrencyTag
											name="txt_Iyear" size="16" maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_2year[2], document.forms[0].txt_3year[2], document.forms[0].txt_4year[2], document.forms[0].txt_5year[2], document.forms[0].txt_6year[2],document.forms[0].txt_totalexpenses[2],document.forms[0].txt_TotalExpensesValue);total1year()"
											value='<%=Helper.correctNull((String) eduyear1[2])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_2year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[2], document.forms[0].txt_3year[2], document.forms[0].txt_4year[2], document.forms[0].txt_5year[2], document.forms[0].txt_6year[2], document.forms[0].txt_totalexpenses[2],document.forms[0].txt_TotalExpensesValue);total2year()"
											value='<%=Helper.correctNull((String) eduyear2[2])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_3year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[2], document.forms[0].txt_2year[2], document.forms[0].txt_4year[2], document.forms[0].txt_5year[2], document.forms[0].txt_6year[2], document.forms[0].txt_totalexpenses[2],document.forms[0].txt_TotalExpensesValue);total3year();"
											value='<%=Helper.correctNull((String) eduyear3[2])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_4year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[2], document.forms[0].txt_2year[2], document.forms[0].txt_3year[2], document.forms[0].txt_5year[2], document.forms[0].txt_6year[2], document.forms[0].txt_totalexpenses[2],document.forms[0].txt_TotalExpensesValue);total4year();"
											value='<%=Helper.correctNull((String) eduyear4[2])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_5year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[2], document.forms[0].txt_2year[2], document.forms[0].txt_3year[2], document.forms[0].txt_4year[2], document.forms[0].txt_6year[2], document.forms[0].txt_totalexpenses[2],document.forms[0].txt_TotalExpensesValue);total5year();"
											value='<%=Helper.correctNull((String) eduyear5[2])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_6year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[2], document.forms[0].txt_2year[2], document.forms[0].txt_3year[2], document.forms[0].txt_4year[2], document.forms[0].txt_5year[2], document.forms[0].txt_totalexpenses[2],document.forms[0].txt_TotalExpensesValue);total6year();"
											value='<%=Helper.correctNull((String) eduyear6[2])%>' /></td>
										<td><input type="text" name="txt_totalexpenses"
											onKeyPress="allowNumber(this)" size="16" maxlength="12"
											style="text-align: right" readOnly="readonly" value=""></td>
									</tr>
									<tr align="center" class="datagrid">
										<td>4</td>
										<td align="left">Examination Fees <input
											name="description" type="hidden" size="2" maxlength="2"
											value="Examination Fees "></td>
										<td valign="middle" align="center"><lapschoice:CurrencyTag
											name="txt_Iyear" size="16" maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_2year[3], document.forms[0].txt_3year[3], document.forms[0].txt_4year[3], document.forms[0].txt_5year[3], document.forms[0].txt_6year[3],document.forms[0].txt_totalexpenses[3],document.forms[0].txt_TotalExpensesValue);total1year();"
											value='<%=Helper.correctNull((String) eduyear1[3])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_2year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[3], document.forms[0].txt_3year[3], document.forms[0].txt_4year[3], document.forms[0].txt_5year[3], document.forms[0].txt_6year[3], document.forms[0].txt_totalexpenses[3],document.forms[0].txt_TotalExpensesValue);total2year();"
											value='<%=Helper.correctNull((String) eduyear2[3])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_3year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[3], document.forms[0].txt_2year[3], document.forms[0].txt_4year[3], document.forms[0].txt_5year[3], document.forms[0].txt_6year[3], document.forms[0].txt_totalexpenses[3],document.forms[0].txt_TotalExpensesValue);total3year();"
											value='<%=Helper.correctNull((String) eduyear3[3])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_4year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[3], document.forms[0].txt_2year[3], document.forms[0].txt_3year[3], document.forms[0].txt_5year[3], document.forms[0].txt_6year[3], document.forms[0].txt_totalexpenses[3],document.forms[0].txt_TotalExpensesValue);total4year();"
											value='<%=Helper.correctNull((String) eduyear4[3])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_5year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[3], document.forms[0].txt_2year[3], document.forms[0].txt_3year[3], document.forms[0].txt_4year[3], document.forms[0].txt_6year[3], document.forms[0].txt_totalexpenses[3],document.forms[0].txt_TotalExpensesValue);total5year();"
											value='<%=Helper.correctNull((String) eduyear5[3])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_6year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[3], document.forms[0].txt_2year[3], document.forms[0].txt_3year[3], document.forms[0].txt_4year[3], document.forms[0].txt_5year[3], document.forms[0].txt_totalexpenses[3],document.forms[0].txt_TotalExpensesValue);total6year();"
											value='<%=Helper.correctNull((String) eduyear6[3])%>' /></td>
										<td><input type="text" name="txt_totalexpenses"
											onKeyPress="allowNumber(this)" size="16" maxlength="12"
											style="text-align: right" readOnly="readonly" value=""></td>
									</tr>
									<tr align="center" class="datagrid">
										<td>5</td>
										<td align="left">Library / Laboratory Fee<input name="description"
											type="hidden" size="2" maxlength="2" value="Library  / Laboratory Fee "></td>
										<td valign="middle" align="center"><lapschoice:CurrencyTag
											name="txt_Iyear" size="16" maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_2year[4], document.forms[0].txt_3year[4], document.forms[0].txt_4year[4], document.forms[0].txt_5year[4], document.forms[0].txt_6year[4],document.forms[0].txt_totalexpenses[4],document.forms[0].txt_TotalExpensesValue);total1year();"
											value='<%=Helper.correctNull((String) eduyear1[4])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_2year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[4], document.forms[0].txt_3year[4], document.forms[0].txt_4year[4], document.forms[0].txt_5year[4], document.forms[0].txt_6year[4], document.forms[0].txt_totalexpenses[4],document.forms[0].txt_TotalExpensesValue);total2year();"
											value='<%=Helper.correctNull((String) eduyear2[4])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_3year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[4], document.forms[0].txt_2year[4], document.forms[0].txt_4year[4], document.forms[0].txt_5year[4], document.forms[0].txt_6year[4], document.forms[0].txt_totalexpenses[4],document.forms[0].txt_TotalExpensesValue);total3year();"
											value='<%=Helper.correctNull((String) eduyear3[4])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_4year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[4], document.forms[0].txt_2year[4], document.forms[0].txt_3year[4], document.forms[0].txt_5year[4], document.forms[0].txt_6year[4], document.forms[0].txt_totalexpenses[4],document.forms[0].txt_TotalExpensesValue);total4year();"
											value='<%=Helper.correctNull((String) eduyear4[4])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_5year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[4], document.forms[0].txt_2year[4], document.forms[0].txt_3year[4], document.forms[0].txt_4year[4], document.forms[0].txt_6year[4], document.forms[0].txt_totalexpenses[4],document.forms[0].txt_TotalExpensesValue);total5year();"
											value='<%=Helper.correctNull((String) eduyear5[4])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_6year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[4], document.forms[0].txt_2year[4], document.forms[0].txt_3year[4], document.forms[0].txt_4year[4], document.forms[0].txt_5year[4], document.forms[0].txt_totalexpenses[4],document.forms[0].txt_TotalExpensesValue);total6year();"
											value='<%=Helper.correctNull((String) eduyear6[4])%>' /></td>
										<td><input type="text" name="txt_totalexpenses"
											onKeyPress="allowNumber(this)" size="16" maxlength="12"
											style="text-align: right" readOnly="readonly" value=""></td>
									</tr>
									<tr align="center" class="datagrid">
										<td height="25">6</td>
										<td align="left">Travel Expenses <input
											name="description" type="hidden" size="2" maxlength="2"
											value="Travel Expenses "></td>
										<td valign="middle" align="center"><lapschoice:CurrencyTag
											name="txt_Iyear" size="16" maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_2year[5], document.forms[0].txt_3year[5], document.forms[0].txt_4year[5], document.forms[0].txt_5year[5], document.forms[0].txt_6year[5],document.forms[0].txt_totalexpenses[5],document.forms[0].txt_TotalExpensesValue);total1year();"
											value='<%=Helper.correctNull((String) eduyear1[5])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_2year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[5], document.forms[0].txt_3year[5], document.forms[0].txt_4year[5], document.forms[0].txt_5year[5], document.forms[0].txt_6year[5], document.forms[0].txt_totalexpenses[5],document.forms[0].txt_TotalExpensesValue);total2year();"
											value='<%=Helper.correctNull((String) eduyear2[5])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_3year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[5], document.forms[0].txt_2year[5], document.forms[0].txt_4year[5], document.forms[0].txt_5year[5], document.forms[0].txt_6year[5], document.forms[0].txt_totalexpenses[5],document.forms[0].txt_TotalExpensesValue);total3year();"
											value='<%=Helper.correctNull((String) eduyear3[5])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_4year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[5], document.forms[0].txt_2year[5], document.forms[0].txt_3year[5], document.forms[0].txt_5year[5], document.forms[0].txt_6year[5], document.forms[0].txt_totalexpenses[5],document.forms[0].txt_TotalExpensesValue);total4year();"
											value='<%=Helper.correctNull((String) eduyear4[5])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_5year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[5], document.forms[0].txt_2year[5], document.forms[0].txt_3year[5], document.forms[0].txt_4year[5], document.forms[0].txt_6year[5], document.forms[0].txt_totalexpenses[5],document.forms[0].txt_TotalExpensesValue);total5year();"
											value='<%=Helper.correctNull((String) eduyear5[5])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_6year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[5], document.forms[0].txt_2year[5], document.forms[0].txt_3year[5], document.forms[0].txt_4year[5], document.forms[0].txt_5year[5], document.forms[0].txt_totalexpenses[5],document.forms[0].txt_TotalExpensesValue);total6year();"
											value='<%=Helper.correctNull((String) eduyear6[5])%>' /></td>
										<td><input type="text" name="txt_totalexpenses"
											onKeyPress="allowNumber(this)" size="16" maxlength="12"
											style="text-align: right" readOnly="readonly" value=""></td>
									</tr>
									<tr align="center" class="datagrid">
										<td>7</td>
										<td align="left">Building Fund / Refundable Deposit<input name="description"
											type="hidden" size="2" maxlength="2" value="Refundable Deposit"></td>
										<td valign="middle" align="center"><lapschoice:CurrencyTag
											name="txt_Iyear" size="16" maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_2year[6], document.forms[0].txt_3year[6], document.forms[0].txt_4year[6], document.forms[0].txt_5year[6], document.forms[0].txt_6year[6],document.forms[0].txt_totalexpenses[6],document.forms[0].txt_TotalExpensesValue);total1year();"
											value='<%=Helper.correctNull((String) eduyear1[6])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_2year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[6], document.forms[0].txt_3year[6], document.forms[0].txt_4year[6], document.forms[0].txt_5year[6], document.forms[0].txt_6year[6], document.forms[0].txt_totalexpenses[6],document.forms[0].txt_TotalExpensesValue);total2year();"
											value='<%=Helper.correctNull((String) eduyear2[6])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_3year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[6], document.forms[0].txt_2year[6], document.forms[0].txt_4year[6], document.forms[0].txt_5year[6], document.forms[0].txt_6year[6], document.forms[0].txt_totalexpenses[6],document.forms[0].txt_TotalExpensesValue);total3year();"
											value='<%=Helper.correctNull((String) eduyear3[6])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_4year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[6], document.forms[0].txt_2year[6], document.forms[0].txt_3year[6], document.forms[0].txt_5year[6], document.forms[0].txt_6year[6], document.forms[0].txt_totalexpenses[6],document.forms[0].txt_TotalExpensesValue);total4year();"
											value='<%=Helper.correctNull((String) eduyear4[6])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_5year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[6], document.forms[0].txt_2year[6], document.forms[0].txt_3year[6], document.forms[0].txt_4year[6], document.forms[0].txt_6year[6], document.forms[0].txt_totalexpenses[6],document.forms[0].txt_TotalExpensesValue);total5year();"
											value='<%=Helper.correctNull((String) eduyear5[6])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_6year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[6], document.forms[0].txt_2year[6], document.forms[0].txt_3year[6], document.forms[0].txt_4year[6], document.forms[0].txt_5year[6], document.forms[0].txt_totalexpenses[6],document.forms[0].txt_TotalExpensesValue);total6year();"
											value='<%=Helper.correctNull((String) eduyear6[6])%>' /></td>
										<td><input type="text" name="txt_totalexpenses"
											onKeyPress="allowNumber(this)" size="16" maxlength="12"
											style="text-align: right" readOnly="readonly" value=""></td>
									</tr>
									<tr align="center" class="datagrid">
										<td>8</td>
										<td align="left">Boarding Fee/Expenses &nbsp; <input
											name="description" type="hidden" size="2" maxlength="2"
											value="Boarding	Fee/Expenses"></td>
										<td valign="middle" align="center"><lapschoice:CurrencyTag
											name="txt_Iyear" size="16" maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_2year[7], document.forms[0].txt_3year[7], document.forms[0].txt_4year[7], document.forms[0].txt_5year[7], document.forms[0].txt_6year[7],document.forms[0].txt_totalexpenses[7],document.forms[0].txt_TotalExpensesValue);total1year();"
											value='<%=Helper.correctNull((String) eduyear1[7])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_2year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[7], document.forms[0].txt_3year[7], document.forms[0].txt_4year[7], document.forms[0].txt_5year[7], document.forms[0].txt_6year[7], document.forms[0].txt_totalexpenses[7],document.forms[0].txt_TotalExpensesValue);total2year();"
											value='<%=Helper.correctNull((String) eduyear2[7])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_3year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[7], document.forms[0].txt_2year[7], document.forms[0].txt_4year[7], document.forms[0].txt_5year[7], document.forms[0].txt_6year[7], document.forms[0].txt_totalexpenses[7],document.forms[0].txt_TotalExpensesValue);total3year();"
											value='<%=Helper.correctNull((String) eduyear3[7])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_4year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[7], document.forms[0].txt_2year[7], document.forms[0].txt_3year[7], document.forms[0].txt_5year[7], document.forms[0].txt_6year[7], document.forms[0].txt_totalexpenses[7],document.forms[0].txt_TotalExpensesValue);total4year();"
											value='<%=Helper.correctNull((String) eduyear4[7])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_5year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[7], document.forms[0].txt_2year[7], document.forms[0].txt_3year[7], document.forms[0].txt_4year[7], document.forms[0].txt_6year[7], document.forms[0].txt_totalexpenses[7],document.forms[0].txt_TotalExpensesValue);total5year();"
											value='<%=Helper.correctNull((String) eduyear5[7])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_6year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[7], document.forms[0].txt_2year[7], document.forms[0].txt_3year[7], document.forms[0].txt_4year[7], document.forms[0].txt_5year[7], document.forms[0].txt_totalexpenses[7],document.forms[0].txt_TotalExpensesValue);total6year();"
											value='<%=Helper.correctNull((String) eduyear6[7])%>' /></td>
										<td><input type="text" name="txt_totalexpenses"
											onKeyPress="allowNumber(this)" size="16" maxlength="12"
											style="text-align: right" readOnly="readonly" value=""></td>
									</tr>
									<tr align="center" class="datagrid">
										<td>9</td>
										<td align="left">Hostel Fees or Lodge Rent <input
											name="description" type="hidden" size="2" maxlength="2"
											value="Hostel Fees or Lodge Rent"></td>
										<td valign="middle" align="center"><lapschoice:CurrencyTag
											name="txt_Iyear" size="16" maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_2year[8], document.forms[0].txt_3year[8], document.forms[0].txt_4year[8], document.forms[0].txt_5year[8], document.forms[0].txt_6year[8],document.forms[0].txt_totalexpenses[8],document.forms[0].txt_TotalExpensesValue);total1year();"
											value='<%=Helper.correctNull((String) eduyear1[8])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_2year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[8], document.forms[0].txt_3year[8], document.forms[0].txt_4year[8], document.forms[0].txt_5year[8], document.forms[0].txt_6year[8], document.forms[0].txt_totalexpenses[8],document.forms[0].txt_TotalExpensesValue);total2year();"
											value='<%=Helper.correctNull((String) eduyear2[8])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_3year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[8], document.forms[0].txt_2year[8], document.forms[0].txt_4year[8], document.forms[0].txt_5year[8], document.forms[0].txt_6year[8], document.forms[0].txt_totalexpenses[8],document.forms[0].txt_TotalExpensesValue);total3year();"
											value='<%=Helper.correctNull((String) eduyear3[8])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_4year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[8], document.forms[0].txt_2year[8], document.forms[0].txt_3year[8], document.forms[0].txt_5year[8], document.forms[0].txt_6year[8], document.forms[0].txt_totalexpenses[8],document.forms[0].txt_TotalExpensesValue);total4year();"
											value='<%=Helper.correctNull((String) eduyear4[8])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_5year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[8], document.forms[0].txt_2year[8], document.forms[0].txt_3year[8], document.forms[0].txt_4year[8], document.forms[0].txt_6year[8], document.forms[0].txt_totalexpenses[8],document.forms[0].txt_TotalExpensesValue);total5year();"
											value='<%=Helper.correctNull((String) eduyear5[8])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_6year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[8], document.forms[0].txt_2year[8], document.forms[0].txt_3year[8], document.forms[0].txt_4year[8], document.forms[0].txt_5year[8], document.forms[0].txt_totalexpenses[8],document.forms[0].txt_TotalExpensesValue);total6year();"
											value='<%=Helper.correctNull((String) eduyear6[8])%>' /></td>
										<td><input type="text" name="txt_totalexpenses"
											onKeyPress="allowNumber(this)" size="16" maxlength="12"
											style="text-align: right" readOnly="readonly" value=""></td>
									</tr>
									
									<tr align="center" class="datagrid">
										<td>10</td>
										<td align="left">Caution Deposit <input
											name="description" type="hidden" size="2" maxlength="2"
											value="Caution Deposit"></td>
										<td valign="middle" align="center"><lapschoice:CurrencyTag
											name="txt_Iyear" size="16" maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_2year[9], document.forms[0].txt_3year[9], document.forms[0].txt_4year[9], document.forms[0].txt_5year[9], document.forms[0].txt_6year[9],document.forms[0].txt_totalexpenses[9],document.forms[0].txt_TotalExpensesValue);total1year();"
											value='<%=Helper.correctNull((String) eduyear1[9])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_2year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[9], document.forms[0].txt_3year[9], document.forms[0].txt_4year[9], document.forms[0].txt_5year[9], document.forms[0].txt_6year[9], document.forms[0].txt_totalexpenses[9],document.forms[0].txt_TotalExpensesValue);total2year();"
											value='<%=Helper.correctNull((String) eduyear2[9])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_3year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[9], document.forms[0].txt_2year[9], document.forms[0].txt_4year[9], document.forms[0].txt_5year[9], document.forms[0].txt_6year[9], document.forms[0].txt_totalexpenses[9],document.forms[0].txt_TotalExpensesValue);total3year();"
											value='<%=Helper.correctNull((String) eduyear3[9])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_4year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[9], document.forms[0].txt_2year[9], document.forms[0].txt_3year[9], document.forms[0].txt_5year[9], document.forms[0].txt_6year[9], document.forms[0].txt_totalexpenses[9],document.forms[0].txt_TotalExpensesValue);total4year();"
											value='<%=Helper.correctNull((String) eduyear4[9])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_5year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[9], document.forms[0].txt_2year[9], document.forms[0].txt_3year[9], document.forms[0].txt_4year[9], document.forms[0].txt_6year[9], document.forms[0].txt_totalexpenses[9],document.forms[0].txt_TotalExpensesValue);total5year();"
											value='<%=Helper.correctNull((String) eduyear5[9])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_6year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[9], document.forms[0].txt_2year[9], document.forms[0].txt_3year[9], document.forms[0].txt_4year[9], document.forms[0].txt_5year[9], document.forms[0].txt_totalexpenses[9],document.forms[0].txt_TotalExpensesValue);total6year();"
											value='<%=Helper.correctNull((String) eduyear6[9])%>' /></td>
										<td><input type="text" name="txt_totalexpenses"
											onKeyPress="allowNumber(this)" size="16" maxlength="12"
											style="text-align: right" readOnly="readonly" value=""></td>
									</tr>
									
									
									
									<tr align="center" class="datagrid">
										<td>11</td>
										<td align="left">Insurance Premium <input
											name="description" type="hidden" size="2" maxlength="2"
											value="Insurance Premium"></td>
										<td valign="middle" align="center"><lapschoice:CurrencyTag
											name="txt_Iyear" size="16" maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_2year[10], document.forms[0].txt_3year[10], document.forms[0].txt_4year[10], document.forms[0].txt_5year[10], document.forms[0].txt_6year[10],document.forms[0].txt_totalexpenses[10],document.forms[0].txt_TotalExpensesValue);total1year();"
											value='<%=Helper.correctNull((String) eduyear1[10])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_2year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[10], document.forms[0].txt_3year[10], document.forms[0].txt_4year[10], document.forms[0].txt_5year[10], document.forms[0].txt_6year[10], document.forms[0].txt_totalexpenses[10],document.forms[0].txt_TotalExpensesValue);total2year();"
											value='<%=Helper.correctNull((String) eduyear2[10])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_3year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[10], document.forms[0].txt_2year[10], document.forms[0].txt_4year[10], document.forms[0].txt_5year[10], document.forms[0].txt_6year[10], document.forms[0].txt_totalexpenses[10],document.forms[0].txt_TotalExpensesValue);total3year();"
											value='<%=Helper.correctNull((String) eduyear3[10])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_4year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[10], document.forms[0].txt_2year[10], document.forms[0].txt_3year[10], document.forms[0].txt_5year[10], document.forms[0].txt_6year[10], document.forms[0].txt_totalexpenses[10],document.forms[0].txt_TotalExpensesValue);total4year();"
											value='<%=Helper.correctNull((String) eduyear4[10])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_5year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[10], document.forms[0].txt_2year[10], document.forms[0].txt_3year[10], document.forms[0].txt_4year[10], document.forms[0].txt_6year[10], document.forms[0].txt_totalexpenses[10],document.forms[0].txt_TotalExpensesValue);total5year();"
											value='<%=Helper.correctNull((String) eduyear5[10])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_6year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[10], document.forms[0].txt_2year[10], document.forms[0].txt_3year[10], document.forms[0].txt_4year[10], document.forms[0].txt_5year[10], document.forms[0].txt_totalexpenses[10],document.forms[0].txt_TotalExpensesValue);total6year();"
											value='<%=Helper.correctNull((String) eduyear6[10])%>' /></td>
										<td><input type="text" name="txt_totalexpenses"
											onKeyPress="allowNumber(this)" size="16" maxlength="12"
											style="text-align: right" readOnly="readonly" value=""></td>
									</tr>
									
									
									<tr align="center" class="datagrid">
										<td>12</td>
										<td align="left"><input name="description" type="text"
											size="45" maxlength="45"
											value="<%=Helper.correctNull((String) comments[11])%>"></td>
										<td valign="middle" align="center"><lapschoice:CurrencyTag
											name="txt_Iyear" size="16" maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_2year[11], document.forms[0].txt_3year[11], document.forms[0].txt_4year[11], document.forms[0].txt_5year[11], document.forms[0].txt_6year[11],document.forms[0].txt_totalexpenses[11],document.forms[0].txt_TotalExpensesValue);total1year();"
											value='<%=Helper.correctNull((String) eduyear1[11])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_2year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[11], document.forms[0].txt_3year[11], document.forms[0].txt_4year[11], document.forms[0].txt_5year[11], document.forms[0].txt_6year[11], document.forms[0].txt_totalexpenses[11],document.forms[0].txt_TotalExpensesValue);total2year();"
											value='<%=Helper.correctNull((String) eduyear2[11])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_3year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[11], document.forms[0].txt_2year[11], document.forms[0].txt_4year[11], document.forms[0].txt_5year[11], document.forms[0].txt_6year[11], document.forms[0].txt_totalexpenses[11],document.forms[0].txt_TotalExpensesValue);total3year();"
											value='<%=Helper.correctNull((String) eduyear3[11])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_4year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[11], document.forms[0].txt_2year[11], document.forms[0].txt_3year[11], document.forms[0].txt_5year[11], document.forms[0].txt_6year[11], document.forms[0].txt_totalexpenses[11],document.forms[0].txt_TotalExpensesValue);total4year();"
											value='<%=Helper.correctNull((String) eduyear4[11])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_5year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[11], document.forms[0].txt_2year[11], document.forms[0].txt_3year[11], document.forms[0].txt_4year[11], document.forms[0].txt_6year[11], document.forms[0].txt_totalexpenses[11],document.forms[0].txt_TotalExpensesValue);total5year();"
											value='<%=Helper.correctNull((String) eduyear5[11])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_6year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[11], document.forms[0].txt_2year[11], document.forms[0].txt_3year[11], document.forms[0].txt_4year[11], document.forms[0].txt_5year[11], document.forms[0].txt_totalexpenses[11],document.forms[0].txt_TotalExpensesValue);total6year();"
											value='<%=Helper.correctNull((String) eduyear6[11])%>' /></td>
										<td><input type="text" name="txt_totalexpenses"
											onKeyPress="allowNumber(this)" size="16" maxlength="12"
											style="text-align: right" readOnly="readonly" value=""></td>
									</tr>
									<tr align="center" class="datagrid">
										<td>13</td>
										<td align="left"><input type="text" name="description"
											size="45" maxlength="50"
											value="<%=Helper.correctNull((String) comments[12])%>"></td>
										<td align="center" valign="middle"><lapschoice:CurrencyTag
											name="txt_Iyear" size="16" maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_2year[12], document.forms[0].txt_3year[12], document.forms[0].txt_4year[12], document.forms[0].txt_5year[12], document.forms[0].txt_6year[12],document.forms[0].txt_totalexpenses[12],document.forms[0].txt_TotalExpensesValue);total1year();"
											value='<%=Helper.correctNull((String) eduyear1[12])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_2year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[12], document.forms[0].txt_3year[12], document.forms[0].txt_4year[12], document.forms[0].txt_5year[12], document.forms[0].txt_6year[12], document.forms[0].txt_totalexpenses[12],document.forms[0].txt_TotalExpensesValue);total2year();"
											value='<%=Helper.correctNull((String) eduyear2[12])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_3year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[12], document.forms[0].txt_2year[12], document.forms[0].txt_4year[12], document.forms[0].txt_5year[12], document.forms[0].txt_6year[12], document.forms[0].txt_totalexpenses[12],document.forms[0].txt_TotalExpensesValue);total3year();"
											value='<%=Helper.correctNull((String) eduyear3[12])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_4year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[12], document.forms[0].txt_2year[12], document.forms[0].txt_3year[12], document.forms[0].txt_5year[12], document.forms[0].txt_6year[12], document.forms[0].txt_totalexpenses[12],document.forms[0].txt_TotalExpensesValue);total4year();"
											value='<%=Helper.correctNull((String) eduyear4[12])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_5year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[12], document.forms[0].txt_2year[12], document.forms[0].txt_3year[12], document.forms[0].txt_4year[12], document.forms[0].txt_6year[12], document.forms[0].txt_totalexpenses[12],document.forms[0].txt_TotalExpensesValue);total5year();"
											value='<%=Helper.correctNull((String) eduyear5[12])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_6year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[12], document.forms[0].txt_2year[12], document.forms[0].txt_3year[12], document.forms[0].txt_4year[12], document.forms[0].txt_5year[12], document.forms[0].txt_totalexpenses[12],document.forms[0].txt_TotalExpensesValue);total6year();"
											value='<%=Helper.correctNull((String) eduyear6[12])%>' /></td>
										<td><input type="text" name="txt_totalexpenses"
											onKeyPress="allowNumber(this)" size="16" maxlength="12"
											style="text-align: right" readOnly="readonly" value=""></td>
									</tr>
									<tr align="center" class="datagrid">
										<td>14</td>
										<td align="left"><input type="text" name="description"
											size="45" maxlength="50"
											value="<%=Helper.correctNull((String) comments[13])%>"></td>
										<td align="center" valign="middle"><lapschoice:CurrencyTag
											name="txt_Iyear" size="16" maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_2year[13], document.forms[0].txt_3year[13], document.forms[0].txt_4year[13], document.forms[0].txt_5year[13], document.forms[0].txt_6year[13],document.forms[0].txt_totalexpenses[13],document.forms[0].txt_TotalExpensesValue);total1year();"
											value='<%=Helper.correctNull((String) eduyear1[13])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_2year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[13], document.forms[0].txt_3year[13], document.forms[0].txt_4year[13], document.forms[0].txt_5year[13], document.forms[0].txt_6year[13], document.forms[0].txt_totalexpenses[13],document.forms[0].txt_TotalExpensesValue);total2year();"
											value='<%=Helper.correctNull((String) eduyear2[13])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_3year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[13], document.forms[0].txt_2year[13], document.forms[0].txt_4year[13], document.forms[0].txt_5year[13], document.forms[0].txt_6year[13], document.forms[0].txt_totalexpenses[13],document.forms[0].txt_TotalExpensesValue);total3year();"
											value='<%=Helper.correctNull((String) eduyear3[13])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_4year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[13], document.forms[0].txt_2year[13], document.forms[0].txt_3year[13], document.forms[0].txt_5year[13], document.forms[0].txt_6year[13], document.forms[0].txt_totalexpenses[13],document.forms[0].txt_TotalExpensesValue);total4year();"
											value='<%=Helper.correctNull((String) eduyear4[13])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_5year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[13], document.forms[0].txt_2year[13], document.forms[0].txt_3year[13], document.forms[0].txt_4year[13], document.forms[0].txt_6year[13], document.forms[0].txt_totalexpenses[13],document.forms[0].txt_TotalExpensesValue);total5year();"
											value='<%=Helper.correctNull((String) eduyear5[13])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_6year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[13], document.forms[0].txt_2year[13], document.forms[0].txt_3year[13], document.forms[0].txt_4year[13], document.forms[0].txt_5year[13], document.forms[0].txt_totalexpenses[13],document.forms[0].txt_TotalExpensesValue);total6year();"
											value='<%=Helper.correctNull((String) eduyear6[13])%>' /></td>
										<td><input type="text" name="txt_totalexpenses"
											onKeyPress="allowNumber(this)" size="16" maxlength="12"
											style="text-align: right" readOnly="readonly" value=""></td>
									</tr>
									
									
									<tr align="center" class="datagrid">
										<td>15</td>
										<td align="left"><input type="text" name="description"
											size="45" maxlength="50"
											value="<%=Helper.correctNull((String) comments[14])%>"></td>
										<td align="center" valign="middle"><lapschoice:CurrencyTag
											name="txt_Iyear" size="16" maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_2year[14], document.forms[0].txt_3year[14], document.forms[0].txt_4year[14], document.forms[0].txt_5year[14], document.forms[0].txt_6year[14],document.forms[0].txt_totalexpenses[14],document.forms[0].txt_TotalExpensesValue);total1year();"
											value='<%=Helper.correctNull((String) eduyear1[14])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_2year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[14], document.forms[0].txt_3year[14], document.forms[0].txt_4year[14], document.forms[0].txt_5year[14], document.forms[0].txt_6year[14], document.forms[0].txt_totalexpenses[14],document.forms[0].txt_TotalExpensesValue);total2year();"
											value='<%=Helper.correctNull((String) eduyear2[14])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_3year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[14], document.forms[0].txt_2year[14], document.forms[0].txt_4year[14], document.forms[0].txt_5year[14], document.forms[0].txt_6year[14], document.forms[0].txt_totalexpenses[14],document.forms[0].txt_TotalExpensesValue);total3year();"
											value='<%=Helper.correctNull((String) eduyear3[14])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_4year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[14], document.forms[0].txt_2year[14], document.forms[0].txt_3year[14], document.forms[0].txt_5year[14], document.forms[0].txt_6year[14], document.forms[0].txt_totalexpenses[14],document.forms[0].txt_TotalExpensesValue);total4year();"
											value='<%=Helper.correctNull((String) eduyear4[14])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_5year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[14], document.forms[0].txt_2year[14], document.forms[0].txt_3year[14], document.forms[0].txt_4year[14], document.forms[0].txt_6year[14], document.forms[0].txt_totalexpenses[14],document.forms[0].txt_TotalExpensesValue);total5year();"
											value='<%=Helper.correctNull((String) eduyear5[14])%>' /></td>
										<td><lapschoice:CurrencyTag name="txt_6year" size="16"
											maxlength="12"
											onBlur="getTotalValue(this, document.forms[0].txt_Iyear[14], document.forms[0].txt_2year[14], document.forms[0].txt_3year[14], document.forms[0].txt_4year[14], document.forms[0].txt_5year[14], document.forms[0].txt_totalexpenses[14],document.forms[0].txt_TotalExpensesValue);total6year();"
											value='<%=Helper.correctNull((String) eduyear6[14])%>' /></td>
										<td><input type="text" name="txt_totalexpenses"
											onKeyPress="allowNumber(this)" size="16" maxlength="12"
											style="text-align: right" readOnly="readonly" value=""></td>
									</tr>
									
									<tr align="center" class="dataheader">
										<td>&nbsp;</td>
										<td align="right"><strong>Total Expenses:</strong>&nbsp;&nbsp;</td>
										<td align="center" valign="middle"><input type="text"
											name="total_1year" value="" size="16" maxlength="12"
											style="text-align: right"></td>
										<td><input type="text" name="total_2year"
											onKeyPress="allowNumber(this)" size="16" maxlength="12"
											style="text-align: right" readOnly="readonly"></td>
										<td><input type="text" name="total_3year"
											onKeyPress="allowNumber(this)" size="16" maxlength="12"
											style="text-align: right"></td>
										<td><input type="text" name="total_4year"
											onKeyPress="allowNumber(this)" size="16" maxlength="12"
											style="text-align: right"></td>
										<td><input type="text" name="total_5year"
											onKeyPress="allowNumber(this)" size="16" maxlength="12"
											style="text-align: right"></td>
										<td><input type="text" name="total_6year"
											onKeyPress="allowNumber(this)" size="16" maxlength="12"
											style="text-align: right"></td>
										<td><input type="text" name="txt_TotalExpensesValue"
											onKeyPress="allowNumber(this)" size="16" maxlength="12"
											style="text-align: right" value=""></td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="2"
									class="outertable">
									<tr class="dataheader">
										<td colspan='2' align='center'>Means of finance</td>
										<td colspan='7' align="center">Year of Study</td>
									</tr>
									<tr class="dataheader">
										<td width="3%">S No.</td>
										<td width="32%">Sources</td>
										<td width="9%" align="center">I</td>
										<td width="9%" align="center">II</td>
										<td width="9%" align="center">III</td>
										<td width="9%" align="center">IV</td>
										<td width="9%" align="center">V</td>
										<td width="9%" align="center">VI</td>
										<td width="11%" align="center">Total Means</td>
									</tr>
									<tr align="center" class="datagrid">
										<td width="3%">1</td>
										<td align='left' width="32%">Loan Amount from Karnataka Bank <input
											name="expenses" type="hidden" size="2" maxlength="2"
											value="Loan Amount from UBI Bank"></td>
										<td align="center" valign="middle" width="9%"><lapschoice:CurrencyTag
											name="exp_1year" size="16" maxlength="12"
											value='<%=Helper.correctNull((String) eduyear1[15])%>'
											onBlur="getTotalValue1(this,document.forms[0].exp_2year[0],document.forms[0].exp_3year[0], document.forms[0].exp_4year[0],document.forms[0].exp_5year[0],document.forms[0].exp_6year[0],document.forms[0].txt_newexpenses[0],document.forms[0].txt_totalnewexpenses);totalexp1year();totalexpensesvalue1()" /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_2year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[0],document.forms[0].exp_3year[0], document.forms[0].exp_4year[0],document.forms[0].exp_5year[0],document.forms[0].exp_6year[0],document.forms[0].txt_newexpenses[0],document.forms[0].txt_totalnewexpenses);totalexp2year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear2[15])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_3year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[0],document.forms[0].exp_2year[0], document.forms[0].exp_4year[0],document.forms[0].exp_5year[0],document.forms[0].exp_6year[0],document.forms[0].txt_newexpenses[0],document.forms[0].txt_totalnewexpenses);totalexp3year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear3[15])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_4year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[0],document.forms[0].exp_2year[0], document.forms[0].exp_3year[0],document.forms[0].exp_5year[0],document.forms[0].exp_6year[0],document.forms[0].txt_newexpenses[0],document.forms[0].txt_totalnewexpenses);totalexp4year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear4[15])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_5year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[0],document.forms[0].exp_2year[0], document.forms[0].exp_3year[0],document.forms[0].exp_4year[0],document.forms[0].exp_6year[0],document.forms[0].txt_newexpenses[0],document.forms[0].txt_totalnewexpenses);totalexp5year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear5[15])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_6year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[0],document.forms[0].exp_2year[0], document.forms[0].exp_3year[0],document.forms[0].exp_4year[0],document.forms[0].exp_5year[0],document.forms[0].txt_newexpenses[0],document.forms[0].txt_totalnewexpenses);totalexp6year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear6[15])%>' /></td>
										<td WIDTH="11%"><input type="text" name="txt_newexpenses"
											onKeyPress="allowNumber(this)" size="16" maxlength="12"
											style="text-align: right" readOnly="readonly"></td>
									</tr>
									<tr align="center" class="datagrid">
										<td WIDTH="3%">2</td>
										<td align="left" WIDTH="32%">Own Savings <input
											name="expenses" type="hidden" size="2" maxlength="2"
											value="Own Savings"></td>
										<td valign="middle" align="center" WIDTH="9%"><lapschoice:CurrencyTag
											name="exp_1year" size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_2year[1],document.forms[0].exp_3year[1], document.forms[0].exp_4year[1],document.forms[0].exp_5year[1],document.forms[0].exp_6year[1],document.forms[0].txt_newexpenses[1],document.forms[0].txt_totalnewexpenses);totalexp1year();totalexpensesvalue1()"
											value="<%=Helper.correctNull((String) eduyear1[16])%>" /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_2year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[1],document.forms[0].exp_3year[1], document.forms[0].exp_4year[1],document.forms[0].exp_5year[1],document.forms[0].exp_6year[1],document.forms[0].txt_newexpenses[1],document.forms[0].txt_totalnewexpenses);totalexp2year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear2[16])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_3year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[1],document.forms[0].exp_2year[1], document.forms[0].exp_4year[1],document.forms[0].exp_5year[1],document.forms[0].exp_6year[1],document.forms[0].txt_newexpenses[1],document.forms[0].txt_totalnewexpenses);totalexp3year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear3[16])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_4year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[1],document.forms[0].exp_2year[1], document.forms[0].exp_3year[1],document.forms[0].exp_5year[1],document.forms[0].exp_6year[1],document.forms[0].txt_newexpenses[1],document.forms[0].txt_totalnewexpenses);totalexp4year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear4[16])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_5year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[1],document.forms[0].exp_2year[1], document.forms[0].exp_3year[1],document.forms[0].exp_4year[1],document.forms[0].exp_6year[1],document.forms[0].txt_newexpenses[1],document.forms[0].txt_totalnewexpenses);totalexp5year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear5[16])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_6year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[1],document.forms[0].exp_2year[1], document.forms[0].exp_3year[1],document.forms[0].exp_4year[1],document.forms[0].exp_5year[1],document.forms[0].txt_newexpenses[1],document.forms[0].txt_totalnewexpenses);totalexp6year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear6[16])%>' /></td>
										<td WIDTH="11%"><input type="text" name="txt_newexpenses"
											onKeyPress="allowNumber(this)" size="16" maxlength="12"
											style="text-align: right" readOnly="readonly"></td>
									</tr>
									<tr align="center" class="datagrid">
										<td WIDTH="3%">3</td>
										<td align="left" WIDTH="32%">Provident Fund Withdrawal <input
											name="expenses" type="hidden" size="2" maxlength="2"
											value="Provident Fund Withdrawal"></td>
										<td valign="middle" align="center" WIDTH="9%"><lapschoice:CurrencyTag
											name="exp_1year" size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_2year[2],document.forms[0].exp_3year[2], document.forms[0].exp_4year[2],document.forms[0].exp_5year[2],document.forms[0].exp_6year[2],document.forms[0].txt_newexpenses[2],document.forms[0].txt_totalnewexpenses);totalexp1year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear1[17])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_2year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[2],document.forms[0].exp_3year[2], document.forms[0].exp_4year[2],document.forms[0].exp_5year[2],document.forms[0].exp_6year[2],document.forms[0].txt_newexpenses[2],document.forms[0].txt_totalnewexpenses);totalexp2year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear2[17])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_3year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[2],document.forms[0].exp_2year[2], document.forms[0].exp_4year[2],document.forms[0].exp_5year[2],document.forms[0].exp_6year[2],document.forms[0].txt_newexpenses[2],document.forms[0].txt_totalnewexpenses);totalexp3year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear3[17])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_4year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[2],document.forms[0].exp_2year[2], document.forms[0].exp_3year[2],document.forms[0].exp_5year[2],document.forms[0].exp_6year[2],document.forms[0].txt_newexpenses[2],document.forms[0].txt_totalnewexpenses);totalexp4year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear4[17])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_5year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[2],document.forms[0].exp_2year[2], document.forms[0].exp_3year[2],document.forms[0].exp_4year[2],document.forms[0].exp_6year[2],document.forms[0].txt_newexpenses[2],document.forms[0].txt_totalnewexpenses);totalexp5year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear5[17])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_6year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[2],document.forms[0].exp_2year[2], document.forms[0].exp_3year[2],document.forms[0].exp_4year[2],document.forms[0].exp_5year[2],document.forms[0].txt_newexpenses[2],document.forms[0].txt_totalnewexpenses);totalexp6year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear6[17])%>' /></td>
										<td WIDTH="11%"><input type="text" name="txt_newexpenses"
											onKeyPress="allowNumber(this)" size="16" maxlength="12"
											style="text-align: right" readOnly="readonly"></td>
									</tr>
									<tr align="center" class="datagrid">
										<td WIDTH="3%">4</td>
										<td align="left" WIDTH="32%">Disposal of Investments <input
											name="expenses" type="hidden" size="2" maxlength="2"
											value="Disposal of Investments"></td>
										<td valign="middle" align="center" WIDTH="9%"><lapschoice:CurrencyTag
											name="exp_1year" size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_2year[3],document.forms[0].exp_3year[3], document.forms[0].exp_4year[3],document.forms[0].exp_5year[3],document.forms[0].exp_6year[3],document.forms[0].txt_newexpenses[3],document.forms[0].txt_totalnewexpenses);totalexp1year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear1[18])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_2year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[3],document.forms[0].exp_3year[3], document.forms[0].exp_4year[3],document.forms[0].exp_5year[3],document.forms[0].exp_6year[3],document.forms[0].txt_newexpenses[3],document.forms[0].txt_totalnewexpenses);totalexp2year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear2[18])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_3year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[3],document.forms[0].exp_2year[3], document.forms[0].exp_4year[3],document.forms[0].exp_5year[3],document.forms[0].exp_6year[3],document.forms[0].txt_newexpenses[3],document.forms[0].txt_totalnewexpenses);totalexp3year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear3[18])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_4year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[3],document.forms[0].exp_2year[3], document.forms[0].exp_3year[3],document.forms[0].exp_5year[3],document.forms[0].exp_6year[3],document.forms[0].txt_newexpenses[3],document.forms[0].txt_totalnewexpenses);totalexp4year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear4[18])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_5year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[3],document.forms[0].exp_2year[3], document.forms[0].exp_3year[3],document.forms[0].exp_4year[3],document.forms[0].exp_6year[3],document.forms[0].txt_newexpenses[3],document.forms[0].txt_totalnewexpenses);totalexp5year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear5[18])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_6year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[3],document.forms[0].exp_2year[3], document.forms[0].exp_3year[3],document.forms[0].exp_4year[3],document.forms[0].exp_5year[3],document.forms[0].txt_newexpenses[3],document.forms[0].txt_totalnewexpenses);totalexp6year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear6[18])%>' /></td>
										<td WIDTH="11%"><input type="text" name="txt_newexpenses"
											onKeyPress="allowNumber(this)" size="16" maxlength="12"
											style="text-align: right" readOnly="readonly"></td>
									</tr>
									<tr align="center" class="datagrid">
										<td WIDTH="3%">5</td>
										<td align="left" WIDTH="32%">FDs <input name="expenses"
											type="hidden" size="2" maxlength="2" value="FDs"></td>
										<td valign="middle" align="center" WIDTH="9%"><lapschoice:CurrencyTag
											name="exp_1year" size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_2year[4],document.forms[0].exp_3year[4], document.forms[0].exp_4year[4],document.forms[0].exp_5year[4],document.forms[0].exp_6year[4],document.forms[0].txt_newexpenses[4],document.forms[0].txt_totalnewexpenses);totalexp1year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear1[19])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_2year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[4],document.forms[0].exp_3year[4], document.forms[0].exp_4year[4],document.forms[0].exp_5year[4],document.forms[0].exp_6year[4],document.forms[0].txt_newexpenses[4],document.forms[0].txt_totalnewexpenses);totalexp2year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear2[19])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_3year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[4],document.forms[0].exp_2year[4], document.forms[0].exp_4year[4],document.forms[0].exp_5year[4],document.forms[0].exp_6year[4],document.forms[0].txt_newexpenses[4],document.forms[0].txt_totalnewexpenses);totalexp3year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear3[19])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_4year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[4],document.forms[0].exp_2year[4], document.forms[0].exp_3year[4],document.forms[0].exp_5year[4],document.forms[0].exp_6year[4],document.forms[0].txt_newexpenses[4],document.forms[0].txt_totalnewexpenses);totalexp4year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear4[19])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_5year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[4],document.forms[0].exp_2year[4], document.forms[0].exp_3year[4],document.forms[0].exp_4year[4],document.forms[0].exp_6year[4],document.forms[0].txt_newexpenses[4],document.forms[0].txt_totalnewexpenses);totalexp5year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear5[19])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_6year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[4],document.forms[0].exp_2year[4], document.forms[0].exp_3year[4],document.forms[0].exp_4year[4],document.forms[0].exp_5year[4],document.forms[0].txt_newexpenses[4],document.forms[0].txt_totalnewexpenses);totalexp6year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear6[19])%>' /></td>
										<td WIDTH="11%"><input type="text" name="txt_newexpenses"
											onKeyPress="allowNumber(this)" size="16" maxlength="12"
											style="text-align: right" readOnly="readonly"></td>
									</tr>
									<tr align="center" class="datagrid">
										<td height="25" WIDTH="3%">6</td>
										<td align="left" WIDTH="32%">Shares <input
											name="expenses" type="hidden" size="2" maxlength="2"
											value="Shares"></td>
										<td valign="middle" align="center" WIDTH="9%"><lapschoice:CurrencyTag
											name="exp_1year" size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_2year[5],document.forms[0].exp_3year[5], document.forms[0].exp_4year[5],document.forms[0].exp_5year[5],document.forms[0].exp_6year[5],document.forms[0].txt_newexpenses[5],document.forms[0].txt_totalnewexpenses);totalexp1year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear1[20])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_2year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[5],document.forms[0].exp_3year[5], document.forms[0].exp_4year[5],document.forms[0].exp_5year[5],document.forms[0].exp_6year[5],document.forms[0].txt_newexpenses[5],document.forms[0].txt_totalnewexpenses);totalexp2year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear2[20])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_3year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_2year[5],document.forms[0].exp_3year[5], document.forms[0].exp_4year[5],document.forms[0].exp_5year[5],document.forms[0].exp_6year[5],document.forms[0].txt_newexpenses[5],document.forms[0].txt_totalnewexpenses);totalexp3year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear3[20])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_4year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[5],document.forms[0].exp_2year[5], document.forms[0].exp_3year[5],document.forms[0].exp_5year[5],document.forms[0].exp_6year[5],document.forms[0].txt_newexpenses[5],document.forms[0].txt_totalnewexpenses);totalexp4year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear4[20])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_5year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[5],document.forms[0].exp_2year[5], document.forms[0].exp_3year[5],document.forms[0].exp_4year[5],document.forms[0].exp_6year[5],document.forms[0].txt_newexpenses[5],document.forms[0].txt_totalnewexpenses);totalexp5year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear5[20])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_6year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[5],document.forms[0].exp_2year[5], document.forms[0].exp_3year[5],document.forms[0].exp_4year[5],document.forms[0].exp_5year[5],document.forms[0].txt_newexpenses[5],document.forms[0].txt_totalnewexpenses);totalexp6year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear6[20])%>' /></td>
										<td WIDTH="11%"><input type="text" name="txt_newexpenses"
											onKeyPress="allowNumber(this)" size="16" maxlength="12"
											style="text-align: right" readOnly="readonly"></td>
									</tr>
									<tr align="center" class="datagrid">
										<td WIDTH="3%">7</td>
										<td align="left" WIDTH="32%">LIC Policies <input
											name="expenses" type="hidden" size="2" maxlength="2"
											value="LIC Policies"></td>
										<td valign="middle" align="center" WIDTH="9%"><lapschoice:CurrencyTag
											name="exp_1year" size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_2year[6],document.forms[0].exp_3year[6], document.forms[0].exp_4year[6],document.forms[0].exp_5year[6],document.forms[0].exp_6year[6],document.forms[0].txt_newexpenses[6],document.forms[0].txt_totalnewexpenses);totalexp1year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear1[21])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_2year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[6],document.forms[0].exp_3year[6], document.forms[0].exp_4year[6],document.forms[0].exp_5year[6],document.forms[0].exp_6year[6],document.forms[0].txt_newexpenses[6],document.forms[0].txt_totalnewexpenses);totalexp2year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear2[21])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_3year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[6],document.forms[0].exp_2year[6], document.forms[0].exp_4year[6],document.forms[0].exp_5year[6],document.forms[0].exp_6year[6],document.forms[0].txt_newexpenses[6],document.forms[0].txt_totalnewexpenses);totalexp3year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear3[21])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_4year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_2year[6],document.forms[0].exp_3year[6], document.forms[0].exp_4year[6],document.forms[0].exp_5year[6],document.forms[0].exp_6year[6],document.forms[0].txt_newexpenses[6],document.forms[0].txt_totalnewexpenses);totalexp4year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear4[21])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_5year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[6],document.forms[0].exp_2year[6], document.forms[0].exp_3year[6],document.forms[0].exp_4year[6],document.forms[0].exp_6year[6],document.forms[0].txt_newexpenses[6],document.forms[0].txt_totalnewexpenses);totalexp5year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear5[21])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_6year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[6],document.forms[0].exp_2year[6], document.forms[0].exp_3year[6],document.forms[0].exp_4year[6],document.forms[0].exp_5year[6],document.forms[0].txt_newexpenses[6],document.forms[0].txt_totalnewexpenses);totalexp6year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear6[21])%>' /></td>
										<td WIDTH="11%"><input type="text" name="txt_newexpenses"
											onKeyPress="allowNumber(this)" size="16" maxlength="12"
											style="text-align: right" readOnly="readonly"></td>
									</tr>
									<tr align="center" class="datagrid">
										<td WIDTH="3%">8</td>
										<td align="left" WIDTH="32%">Non Repayable Scholarship <input
											type="text" name="expenses" size="45" maxlength="50"
											value="<%=Helper.correctNull((String) comments[22])%>"></td>
										<td valign="middle" align="center" WIDTH="9%"><lapschoice:CurrencyTag
											name="exp_1year" size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_2year[7],document.forms[0].exp_3year[7], document.forms[0].exp_4year[7],document.forms[0].exp_5year[7],document.forms[0].exp_6year[7],document.forms[0].txt_newexpenses[7],document.forms[0].txt_totalnewexpenses);totalexp1year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear1[22])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_2year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[7],document.forms[0].exp_3year[7], document.forms[0].exp_4year[7],document.forms[0].exp_5year[7],document.forms[0].exp_6year[7],document.forms[0].txt_newexpenses[7],document.forms[0].txt_totalnewexpenses);totalexp2year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear2[22])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_3year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[7],document.forms[0].exp_2year[7], document.forms[0].exp_4year[7],document.forms[0].exp_5year[7],document.forms[0].exp_6year[7],document.forms[0].txt_newexpenses[7],document.forms[0].txt_totalnewexpenses);totalexp3year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear3[22])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_4year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[7],document.forms[0].exp_2year[7], document.forms[0].exp_3year[7],document.forms[0].exp_5year[7],document.forms[0].exp_6year[7],document.forms[0].txt_newexpenses[7],document.forms[0].txt_totalnewexpenses);totalexp4year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear4[22])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_5year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[7],document.forms[0].exp_2year[7], document.forms[0].exp_3year[7],document.forms[0].exp_4year[7],document.forms[0].exp_6year[7],document.forms[0].txt_newexpenses[7],document.forms[0].txt_totalnewexpenses);totalexp5year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear5[22])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_6year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[7],document.forms[0].exp_2year[7], document.forms[0].exp_3year[7],document.forms[0].exp_4year[7],document.forms[0].exp_5year[7],document.forms[0].txt_newexpenses[7],document.forms[0].txt_totalnewexpenses);totalexp6year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear6[22])%>' /></td>
										<td WIDTH="11%"><input type="text" name="txt_newexpenses"
											onKeyPress="allowNumber(this)" size="16" maxlength="12"
											style="text-align: right" readOnly="readonly"></td>
									</tr>
									<tr align="center" class="datagrid">
										<td WIDTH="3%">9</td>
										<td align="left" WIDTH="32%">Repayable Scholarship <input
											type="text" name="expenses" size="45" maxlength="50"
											value="<%=Helper.correctNull((String) comments[23])%>"></td>
										<td valign="middle" align="center" WIDTH="9%"><lapschoice:CurrencyTag
											name="exp_1year" size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_2year[8],document.forms[0].exp_3year[8], document.forms[0].exp_4year[8],document.forms[0].exp_5year[8],document.forms[0].exp_6year[8],document.forms[0].txt_newexpenses[8],document.forms[0].txt_totalnewexpenses);totalexp1year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear1[23])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_2year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[8],document.forms[0].exp_3year[8], document.forms[0].exp_4year[8],document.forms[0].exp_5year[8],document.forms[0].exp_6year[8],document.forms[0].txt_newexpenses[8],document.forms[0].txt_totalnewexpenses);totalexp2year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear2[23])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_3year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[8],document.forms[0].exp_2year[8], document.forms[0].exp_4year[8],document.forms[0].exp_5year[8],document.forms[0].exp_6year[8],document.forms[0].txt_newexpenses[8],document.forms[0].txt_totalnewexpenses);totalexp3year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear3[23])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_4year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[8],document.forms[0].exp_2year[8], document.forms[0].exp_3year[8],document.forms[0].exp_5year[8],document.forms[0].exp_6year[8],document.forms[0].txt_newexpenses[8],document.forms[0].txt_totalnewexpenses);totalexp4year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear4[23])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_5year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[8],document.forms[0].exp_2year[8], document.forms[0].exp_3year[8],document.forms[0].exp_4year[8],document.forms[0].exp_6year[8],document.forms[0].txt_newexpenses[8],document.forms[0].txt_totalnewexpenses);totalexp5year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear5[23])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_6year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[8],document.forms[0].exp_2year[8], document.forms[0].exp_3year[8],document.forms[0].exp_4year[8],document.forms[0].exp_5year[8],document.forms[0].txt_newexpenses[8],document.forms[0].txt_totalnewexpenses);totalexp6year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear6[23])%>' /></td>
										<td WIDTH="11%"><input type="text" name="txt_newexpenses"
											onKeyPress="allowNumber(this)" size="16" maxlength="12"
											style="text-align: right" readOnly="readonly"></td>
									</tr>
									<tr align="center" class="datagrid">
										<td WIDTH="3%">10</td>
										<td align="left" WIDTH="32%">Sponsorship by close
										relatives <input type="text" name="expenses" size="45"
											maxlength="50"
											value="<%=Helper.correctNull((String) comments[22])%>"></td>
										<td valign="middle" align="center" WIDTH="9%"><lapschoice:CurrencyTag
											name="exp_1year" size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_2year[9],document.forms[0].exp_3year[9], document.forms[0].exp_4year[9],document.forms[0].exp_5year[9],document.forms[0].exp_6year[9],document.forms[0].txt_newexpenses[9],document.forms[0].txt_totalnewexpenses);totalexp1year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear1[24])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_2year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[9],document.forms[0].exp_3year[9], document.forms[0].exp_4year[9],document.forms[0].exp_5year[9],document.forms[0].exp_6year[9],document.forms[0].txt_newexpenses[9],document.forms[0].txt_totalnewexpenses);totalexp2year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear2[24])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_3year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[9],document.forms[0].exp_2year[9], document.forms[0].exp_4year[9],document.forms[0].exp_5year[9],document.forms[0].exp_6year[9],document.forms[0].txt_newexpenses[9],document.forms[0].txt_totalnewexpenses);totalexp3year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear3[24])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_4year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[9],document.forms[0].exp_2year[9], document.forms[0].exp_3year[9],document.forms[0].exp_5year[9],document.forms[0].exp_6year[9],document.forms[0].txt_newexpenses[9],document.forms[0].txt_totalnewexpenses);totalexp4year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear4[24])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_5year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[9],document.forms[0].exp_2year[9], document.forms[0].exp_3year[9],document.forms[0].exp_4year[9],document.forms[0].exp_6year[9],document.forms[0].txt_newexpenses[9],document.forms[0].txt_totalnewexpenses);totalexp5year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear5[24])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_6year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[9],document.forms[0].exp_2year[9], document.forms[0].exp_3year[9],document.forms[0].exp_4year[9],document.forms[0].exp_5year[9],document.forms[0].txt_newexpenses[9],document.forms[0].txt_totalnewexpenses);totalexp6year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear6[24])%>' /></td>
										<td WIDTH="11%"><input type="text" name="txt_newexpenses"
											onKeyPress="allowNumber(this)" size="16" maxlength="12"
											style="text-align: right" readOnly="readonly"></td>
									</tr>
									<tr align="center" class="datagrid">
										<td WIDTH="3%">11</td>
										<td align="left" WIDTH="32%">If Advance Payment <input
											type="text" name="expenses" size="45" maxlength="50"
											value="<%=Helper.correctNull((String) comments[25])%>"></td>
										<td valign="middle" align="center" WIDTH="9%"><lapschoice:CurrencyTag
											name="exp_1year" size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_2year[10],document.forms[0].exp_3year[10], document.forms[0].exp_4year[10],document.forms[0].exp_5year[10],document.forms[0].exp_6year[10],document.forms[0].txt_newexpenses[10],document.forms[0].txt_totalnewexpenses);totalexp1year();totalexpensesvalue1()"
											value="<%=Helper.correctNull((String) eduyear1[25])%>" /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_2year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[10],document.forms[0].exp_3year[10], document.forms[0].exp_4year[10],document.forms[0].exp_5year[10],document.forms[0].exp_6year[10],document.forms[0].txt_newexpenses[10],document.forms[0].txt_totalnewexpenses);totalexp2year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear2[25])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_3year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[10],document.forms[0].exp_2year[10], document.forms[0].exp_4year[10],document.forms[0].exp_5year[10],document.forms[0].exp_6year[10],document.forms[0].txt_newexpenses[10],document.forms[0].txt_totalnewexpenses);totalexp3year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear3[25])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_4year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[10],document.forms[0].exp_2year[10], document.forms[0].exp_3year[10],document.forms[0].exp_5year[10],document.forms[0].exp_6year[10],document.forms[0].txt_newexpenses[10],document.forms[0].txt_totalnewexpenses);totalexp4year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear4[25])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_5year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[10],document.forms[0].exp_2year[10], document.forms[0].exp_3year[10],document.forms[0].exp_4year[10],document.forms[0].exp_6year[10],document.forms[0].txt_newexpenses[10],document.forms[0].txt_totalnewexpenses);totalexp5year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear5[25])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_6year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[10],document.forms[0].exp_2year[10], document.forms[0].exp_3year[10],document.forms[0].exp_4year[10],document.forms[0].exp_5year[10],document.forms[0].txt_newexpenses[10],document.forms[0].txt_totalnewexpenses);totalexp6year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear6[25])%>' /></td>
										<td WIDTH="11%"><input type="text" name="txt_newexpenses"
											onKeyPress="allowNumber(this)" size="16" maxlength="12"
											style="text-align: right" readOnly="readonly"></td>
									</tr>
									<tr align="center" class="datagrid">
										<td WIDTH="3%">12</td>
										<td align="left" WIDTH="32%">Others (Specify) <input
											type="text" name="expenses" size="45" maxlength="50"
											value="<%=Helper.correctNull((String) comments[26])%>"></td>
										<td valign="middle" align="center" WIDTH="9%"><lapschoice:CurrencyTag
											name="exp_1year" size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_2year[11],document.forms[0].exp_3year[11], document.forms[0].exp_4year[11],document.forms[0].exp_5year[11],document.forms[0].exp_6year[11],document.forms[0].txt_newexpenses[11],document.forms[0].txt_totalnewexpenses);totalexp1year();totalexpensesvalue1()"
											value="<%=Helper.correctNull((String) eduyear1[26])%>" /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_2year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[11],document.forms[0].exp_3year[11], document.forms[0].exp_4year[11],document.forms[0].exp_5year[11],document.forms[0].exp_6year[11],document.forms[0].txt_newexpenses[11],document.forms[0].txt_totalnewexpenses);totalexp2year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear2[26])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_3year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[11],document.forms[0].exp_2year[11], document.forms[0].exp_4year[11],document.forms[0].exp_5year[11],document.forms[0].exp_6year[11],document.forms[0].txt_newexpenses[11],document.forms[0].txt_totalnewexpenses);totalexp3year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear3[26])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_4year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[11],document.forms[0].exp_2year[11], document.forms[0].exp_3year[11],document.forms[0].exp_5year[11],document.forms[0].exp_6year[11],document.forms[0].txt_newexpenses[11],document.forms[0].txt_totalnewexpenses);totalexp4year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear4[26])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_5year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[11],document.forms[0].exp_2year[11], document.forms[0].exp_3year[11],document.forms[0].exp_4year[11],document.forms[0].exp_6year[11],document.forms[0].txt_newexpenses[11],document.forms[0].txt_totalnewexpenses);totalexp5year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear5[26])%>' /></td>
										<td WIDTH="9%"><lapschoice:CurrencyTag name="exp_6year"
											size="16" maxlength="12"
											onBlur="getTotalValue1(this,document.forms[0].exp_1year[11],document.forms[0].exp_2year[11], document.forms[0].exp_3year[11],document.forms[0].exp_4year[11],document.forms[0].exp_5year[11],document.forms[0].txt_newexpenses[11],document.forms[0].txt_totalnewexpenses);totalexp6year();totalexpensesvalue1()"
											value='<%=Helper.correctNull((String) eduyear6[26])%>' /></td>
										<td WIDTH="11%"><input type="text" name="txt_newexpenses"
											onKeyPress="allowNumber(this)" size="16" maxlength="12"
											style="text-align: right" readOnly="readonly"></td>
									</tr>
									<tr align="center" class="dataheader">
										<td WIDTH="3%">&nbsp;</td>
										<td align="right" WIDTH="32%"><strong>Total
										Means:&nbsp;&nbsp; </strong></td>
										<td align="center" valign="middle" WIDTH="9%"><input
											type="text" name="total_exp1year"
											onKeyPress="allowNumber(this)" size="16" maxlength="12"
											style="text-align: right"></td>
										<td WIDTH="9%"><input type="text" name="total_exp2year"
											value="" onKeyPress="allowNumber(this)" size="16"
											maxlength="12" style="text-align: right"></td>
										<td WIDTH="9%"><input type="text" name="total_exp3year"
											value="" onKeyPress="allowNumber(this)" size="16"
											maxlength="12" style="text-align: right"></td>
										<td WIDTH="9%"><input type="text" name="total_exp4year"
											value="" onKeyPress="allowNumber(this)" size="16"
											maxlength="12" style="text-align: right"></td>
										<td WIDTH="9%"><input type="text" name="total_exp5year"
											value="" onKeyPress="allowNumber(this)" size="16"
											maxlength="12" style="text-align: right"></td>
										<td WIDTH="9%"><input type="text" name="total_exp6year"
											value="" onKeyPress="allowNumber(this)" size="16"
											maxlength="12" style="text-align: right"></td>
										<td WIDTH="11%"><input type="text"
											name="txt_totalnewexpenses" onKeyPress="allowNumber(this)"
											size="16" maxlength="12" style="text-align: right"
											readOnly="readonly"></td>
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
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail'
	btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
<br>
<lapschoice:hiddentag pageid="<%=PageId%>" /> <INPUT TYPE="hidden"
	name="radLoan" value="Y"></form>
</body>
</html>


