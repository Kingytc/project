<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
<%ArrayList arryCol_grpcon = null;
			ArrayList operinfo = (ArrayList) hshValues.get("oper_info");
			ArrayList arrSubFac = new ArrayList();
			ArrayList arrSubFacRecords = new ArrayList();
			ArrayList arrRow = new ArrayList();
			ArrayList arrData = new ArrayList();

			String strOwnership = Helper.correctNull((String) hshValues
					.get("comapp_ownership"));
			String strProposalvalue = Helper.correctNull((String) hshValues
					.get("proposalvaluesin"));
			String strOwner = Helper.correctNull((String) hshValues
					.get("comapp_ownership"));
			if (strProposalvalue.equalsIgnoreCase("C"))
				strProposalvalue = "Crores";
			else
				strProposalvalue = "Lacs";

			String strSanctauth = Helper.correctNull((String) hshValues
					.get("exec_sancauth"));
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Short Review/Extension</title>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/executivereport.css"
	type="text/css">
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="25px"
	topmargin="25px" marginwidth="25px" marginheight="25px">
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td> 
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <%if (strSanctauth.equals("7")) {%>
        <tr align="right"> 
          <td colspan="4"> 
            <table border="0" cellspacing="0" cellpadding="3" width="">
              <tr> 
                <td align="left">Agenda Item No:<%=Helper.correctNull((String) hshValues
								.get("exec_agendano"))%> <br>
                  MCM of: <%=Helper.correctNull((String) hshValues
										.get("exec_mcm"))%></td>
              </tr>
            </table>
          </td>
        </tr>
        <%}

			%>
        <tr> 
          <td align="center" colspan="4"><img
					src="<%=ApplicationParams.getAppUrl()%>img/ubibilinguallogo.jpg"></td>
        </tr>
        <tr> 
          <td align="center" colspan="4">Branch / Office, <%=Helper.correctNull((String) hshValues.get("strOrgName"))%> 
            <hr>
          </td>
        </tr>
        <tr> 
          <td width="10%"><b>Ref No:</b></td>
          <td width="60%"><%=Helper.correctNull((String) hshValues.get("exec_refno"))%>&nbsp;</td>
          <td width="17%" align="right"><b>Date :&nbsp;</b></td>
          <td width="13%" align="right"><%=Helper.correctNull((String) hshValues.get("exec_date"))%>&nbsp;</td>
        </tr>
        <tr align="right"> 
          <td colspan="4"> 
            <table border="0" cellspacing="0" cellpadding="6">
              <tr> 
                <%if (strSanctauth.equals("4") || strSanctauth.equals("5")) {

				%>
                <td align="center"><img
							src="<%=ApplicationParams.getAppUrl()%>img/executive/GM.jpg"
							width="55" height="77"></td>
                <td>&nbsp;&nbsp;</td>
                <%}
			if (strSanctauth.equals("5") || strSanctauth.equals("6")
					|| strSanctauth.equals("7")) {

				%>
                <td align="center"><img
							src="<%=ApplicationParams.getAppUrl()%>img/executive/ED.jpg"
							width="55" height="77"></td>
                <td>&nbsp;&nbsp;</td>
                <%}
			if (strSanctauth.equals("6") || strSanctauth.equals("7")) {

				%>
                <td align="center"><img
							src="<%=ApplicationParams.getAppUrl()%>img/executive/CMD.jpg"
							width="55" height="77"></td>
                <%}

			%>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"	align="center">
  <tr> 
    <td> 
      <div id="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="3" >
          <tr> 
            <td align="center"> <b>Proposal For: Short Review / Extension in validity 
              of existing credit limits.</b> </td>
          </tr>
        </table>
      </div>
    </td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td colspan="4">&nbsp;</td>
  </tr>
  <tr> 
    <td> 
      <div id="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="3">
          <tr> 
            <td width="20%">GROUP</td>
            <td width="1%"><b>:</b></td>
            <td width="21%">&nbsp;<%=Helper.correctNull((String) hshValues.get("groupdesc"))%></td>
            <td colspan="4">&nbsp;</td>
          </tr>
          <tr> 
            <td width="20%">BANKING</td>
            <td width="1%"><b>:</b></td>
            <td width="21%">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("status_banking"))%></td>
            <td width="23%">LEAD BANK</td>
            <td width="1%"><b>:</b></td>
            <td colspan="2">&nbsp;<%=Helper.correctNull((String) hshValues
								.get("com_propleadbank"))%></td>
          </tr>
          <tr> 
            <td width="20%">MONTH OF REVIEW</td>
            <td width="1%"><b>:</b></td>
            <td width="21%">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("COM_PROPDEVREVDATE"))%></td>
            <td colspan="4"><b>OUR SHARE</b></td>
          </tr>
          <tr> 
            <td width="27%" rowspan="2">ASSET CLASSIFICATION</td>
            <td width="1%" rowspan="2"><b>:</b></td>
            <td width="29%" rowspan="2"><%=Helper.correctNull((String)hshValues.get("com_propassettype"))%></td>
            <td width="21%">Fund based</td>
            <td width="1%"><b>:</b></td>
            <td width="21%">&nbsp;<%=Helper.correctNull((String)hshValues.get("TOTAL_FUNDEDEXI"))%>&nbsp;%</td>
            <td width="21%">&nbsp;<%=Helper.correctNull((String)hshValues.get("TOTAL_FUNDEDPROP"))%>&nbsp;%</td>
          </tr>
          <tr> 
            <td width="21%">Non Fund based</td>
            <td width="1%"><b>:</b></td>
            <td width="21%">&nbsp;<%=Helper.correctNull((String)hshValues.get("TOTAL_NONFUNDEDEXI"))%>&nbsp;%</td>
            <td width="21%">&nbsp;<%=Helper.correctNull((String)hshValues.get("TOTAL_NONFUNDEDPROP"))%>&nbsp;%</td>
          </tr>
          <%ArrayList arrRating = new ArrayList();
			ArrayList arrCol = new ArrayList();
			int arrsize = 0;

			if (hshValues != null) {
				arrRating = (ArrayList) hshValues.get("arrVal");
			}

			if (arrRating != null) {
				arrsize = arrRating.size();

			}

			String[] strprevious = new String[8];
			String[] strcurrent = new String[8];

			for (int i = 0; i < strprevious.length; i++) {
				strprevious[i] = "";
				strcurrent[i] = "";
			}

			if (arrRating != null) {
				for (int i = 0; i < arrRating.size(); i++) {
					arrCol = (ArrayList) arrRating.get(i);

					strprevious[i] = Helper.correctNull((String) arrCol.get(0));
					strcurrent[i] = Helper.correctNull((String) arrCol.get(1));
				}
			}

			%>
          <tr> 
            <td width="20%" valign="top">INTERNAL CREDIT RATING</td>
            <td width="1%" valign="top"><b>:</b></td>
            <td colspan="5"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3">
                <tr align="center"> 
                  <td>&nbsp;</td>
                  <td><b>Grade</b></td>
                  <td><b>Score</b></td>
                  <td><b>Risk definition</b></td>
                </tr>
                <tr align="left"> 
                  <td><b>Previous Year</b></td>
                  <td><%=strprevious[1]%></td>
                  <td><%=strprevious[0]%></td>
                  <td><%=strprevious[2]%></td>
                </tr>
                <tr align="left"> 
                  <td><b>Current Year</b></td>
                  <td><%=strcurrent[1]%></td>
                  <td><%=strcurrent[0]%></td>
                  <td><%=strcurrent[2]%></td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td width="20%">EXTERNAL CREDIT RATING</td>
            <td width="1%"><b>:</b></td>
            <td colspan="5"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3">
                <tr> 
                  <td width="29%">RATING AGENCY</td>
                  <td width="28%">PREVIOUS YEAR</td>
                  <td width="43%">CURRENT YEAR</td>
                </tr>
                <tr> 
                  <td width="29%">&nbsp;<%=Helper.correctNull((String) hshValues.get("extagency"))%></td>
                  <td width="28%">&nbsp;<%=Helper.correctNull((String) hshValues
									.get("extlastrate"))%></td>
                  <td width="43%">&nbsp;<%=Helper.correctNull((String) hshValues.get("extcurrate"))%></td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td width="20%">STATUS OF ACCOUNT</td>
            <td width="1%"><b>:</b></td>
            <td colspan="5"><%=Helper.correctNull((String) hshValues.get("status_acc"))%>&nbsp;</td>
          </tr>
        </table>
      </div>
    </td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr> 
          <td width="4%"><b>1.&nbsp;</b></td>
          <td width="51%"><b>NAME OF THE ACCOUNT</b></td>
          <td width="2%"><b><b>:</b></b></td>
          <td width="43%"><%=Helper.correctNull((String) hshValues
							.get("comapp_companyname"))%></td>
        </tr>
        <tr> 
          <td width="4%" colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td width="4%" align="right"><b>b)</b></td>
          <td width="51%"><b>BRANCH / ZONE</b></td>
          <td width="2%"><b><b>:</b></b></td>
          <td width="43%"><%=Helper.correctNull((String) hshValues
							.get("appCreationBranch"))%></td>
        </tr>
        <tr> 
          <td colspan="4"><b>&nbsp;</b></td>
        </tr>
        <tr> 
          <td width="4%" align="right"><b>c)</b></td>
          <td width="51%"><b>DATE OF INCORPORATION</b></td>
          <td width="2%"><b><b>:</b></b></td>
          <td width="43%"><%=Helper.correctNull((String) hshValues
							.get("comapp_yrsinbusiness"))%></td>
        </tr>
        <tr> 
          <td width="4%" colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td width="4%"><b>2.&nbsp;</b></td>
          <td width="51%"><b>CONSTITUTION</b></td>
          <td width="2%"><b>:</b></td>
          <td width="43%"><%=Helper.correctNull((String) hshValues
									.get("strownership"))%></td>
        </tr>
        <tr> 
          <td width="4%" colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" width="4%"><b>3.&nbsp;</b></td>
          <td width="51%" valign="top"><b>LINE OF ACTIVITY</b></td>
          <td width="2%" valign="top"><b><b>:</b></b></td>
          <td width="43%"><%=Helper.formatTextAreaData((String) hshValues
							.get("comapp_businessnature"))%>&nbsp;</td>
        </tr>
        <tr> 
          <td width="4%" colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td width="4%"><b>4.&nbsp;</b></td>
          <td width="51%"><b> ADDRESS</b></td>
          <td width="2%">&nbsp;</td>
          <td width="43%">&nbsp;</td>
        </tr>
        <tr> 
          <td width="4%" colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" width="4%"><b>&nbsp;</b></td>
          <td width="51%" valign="top"><b>Regd./Admn.Office</b></td>
          <td width="2%" valign="top"><b><b>:</b></b></td>
          <td width="43%"><%=Helper.correctNull((String) hshValues
							.get("comapp_regadd1"))%>-<%=Helper.correctNull((String) hshValues
							.get("comapp_regadd2"))%><br>
            <%=Helper.correctNull((String) hshValues
									.get("Regcity_name"))%> <br>
            <%=Helper.correctNull((String) hshValues
							.get("Regstate_name"))%> <br>
            Pin:<%=Helper.correctNull((String) hshValues
							.get("comapp_regpin"))%><br>
          </td>
        </tr>
        <tr> 
          <td width="4%" colspan="4">&nbsp;</td>
        </tr>
        <%arrData = new ArrayList();
			arrRow = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrUnitsworks");
			if (arrRow != null && arrRow.size() > 0) {

				%>
        <tr> 
          <td valign="top" width="4%">&nbsp;</td>
          <td width="51%" valign="top"><b>Units/Works</b></td>
          <td width="2%" valign="top"><b><b>:</b></b></td>
          <td width="43%"> 
            <table border="0" width="100%">
              <%for (int i = 0; i < arrRow.size(); i++) {
					arrData = (ArrayList) arrRow.get(i);

					%>
              <tr> 
                <td><%=arrData.get(0)%>,<br>
                  <%=arrData.get(1)%>,<br>
                  <%=arrData.get(2)%>,<br>
                  <%=arrData.get(3)%>-<%=arrData.get(4)%>.<br>
                </td>
              </tr>
              <%}

			%>
            </table>
          </td>
        </tr>
        <%}

			%>
        <tr> 
          <td width="4%">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" width="4%"><b>5.&nbsp;</b></td>
          <td width="51%" valign="top"><b>NAMES OF PROPRIETORS / PARTNERS / DIRECTORS 
            &amp; THEIR MEANS</b></td>
          <td width="2%" valign="top"><b><b>:</b></b></td>
          <td width="43%" valign="top"> 
            <%arrRow = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrPromotors");
			if (arrRow != null && arrRow.size() != 0) {

				%>
          </td>
        </tr>
        <tr> 
          <td colspan="4"> 
            <div id="top"> 
              <table cellspacing="0" cellpadding="3">
                <tr class="tblhead"> 
                  <td><b>Sno</b></td>
                  <td><b>Name</b></td>
                  <td><b>Designation</b></td>
                  <td><b>Means&nbsp;(<%=ApplicationParams.getCurrency()%> In <%=strProposalvalue%>)</b></td>
                   <td><b>Means as On</b></td>
                </tr>
                <%for (int i = 0; i < arrRow.size(); i++) {
					arrData = (ArrayList) arrRow.get(i);

					%>
                <tr> 
                  <td><%=i + 1%>.</td>
                  <td><%=arrData.get(0)%>&nbsp;<%=arrData.get(2)%>&nbsp;<%=arrData.get(1)%></td>
                  <td><%=arrData.get(8)%>&nbsp;</td>
                  <td align="right"><%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrData
													.get(4))))%></td>
					<td><%=arrData.get(5)%>&nbsp;</td>
                </tr>
                <%}

			%>
              </table>
            </div>
            <%} else {

			%>
            Nil 
            <%}

			%>
          </td>
        </tr>
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" width="4%"><b>6.&nbsp;</b></td>
          <td valign="top" width="51%"> <b>BACKGROUND OF PROMOTERS / DIRECTORS 
            / PROPRIETOR / PARTNER</b> </td>
          <td valign="top" width="2%"><b>:</b></td>
          <td valign="top" width="2%">&nbsp;</td>
        </tr>
        <tr> 
          <%
           arrRow=new ArrayList();
			arrRow=(ArrayList)hshValues.get("arrProback");
           
           if(arrRow!=null && arrRow.size()!=0)
           { 
        	   %>
          <td colspan="4" class="just"> 
            <%
           	for(int i=0;i<arrRow.size();i++)
            {
            	arrData=(ArrayList)arrRow.get(i); 
            	if(!(Helper.correctNull((String)arrData.get(7)).equals(""))){
            %>
            <p><%=Helper.formatTextAreaData((String)arrData.get(7))%>&nbsp;</p>
            <%
            	}}
                    %>
          </td>
          <%}%>
        </tr>
        <tr> 
          <td width="4%">&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr> 
          <td colspan="3"> 
            <table width="75%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="8%"><b>7.&nbsp;</b></td>
                <td colspan="3"><b>CAPITAL STRUCTURE</b></td>
              </tr>
              <tr> 
                <td colspan="4"><em>In case of Companies</em></td>
              </tr>
              <tr> 
                <td align="right" width="8%">&nbsp;</td>
              </tr>
              <%if (strOwnership.trim().equals("OLP")
					|| strOwnership.trim().equals("OCC")) {%>
              <tr> 
                <td width="8%">&nbsp;</td>
                <td width="36%">Authorised Capital</td>
                <td width="1%"><b>:</b></td>
                <td align="left" width="55%">Rs&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hshValues
										.get("auth_captial"))))%>&nbsp;&nbsp;<%=strProposalvalue%></td>
              </tr>
              <tr> 
                <td width="8%">&nbsp;</td>
                <td width="36%">Issued/Subscribed Capital</td>
                <td width="1%"><b>:</b></td>
                <td align="left" width="55%">Rs&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hshValues
										.get("comapp_subcapital"))))%>&nbsp;&nbsp;<%=strProposalvalue%></td>
              </tr>
              <tr> 
                <td width="8%">&nbsp;</td>
                <td width="36%">Paid-up capital</td>
                <td width="1%"><b>:</b></td>
                <td align="left" width="55%">Rs&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hshValues
										.get("PaidupCapital"))))%>&nbsp;&nbsp;<%=strProposalvalue%></td>
              </tr>
              <tr> 
                <td width="8%">&nbsp;</td>
                <td width="36%">Book Value</td>
                <td width="1%"><b>:</b></td>
                <td align="left" width="55%"><%=Helper.correctDouble((String) hshValues
								.get("book_value"))%>&nbsp;&nbsp;</td>
              </tr>
              <tr> 
                <td width="8%">&nbsp;</td>
                <td width="36%">Market value</td>
                <td width="1%"><b>:</b></td>
                <td align="left" width="55%"><%=Helper.correctDouble((String) hshValues
								.get("market_value"))%>&nbsp;&nbsp;</td>
              </tr>
              <%} else {

			%>
              <tr> 
                <td width="8%">&nbsp;</td>
                <td width="36%">Authorised Capital</td>
                <td width="1%"><b>:</b></td>
                <td align="left" width="55%">&nbsp;</td>
              </tr>
              <tr> 
                <td width="8%">&nbsp;</td>
                <td width="36%">Issued/Subscribed Capital</td>
                <td width="1%"><b>:</b></td>
                <td align="left" width="55%">&nbsp;</td>
              </tr>
              <tr> 
                <td width="8%">&nbsp;</td>
                <td width="36%">Paid-up capital</td>
                <td width="1%"><b>:</b></td>
                <td align="left" width="55%">&nbsp;</td>
              </tr>
              <tr> 
                <td width="8%">&nbsp;</td>
                <td width="36%">Book Value</td>
                <td width="1%"><b>:</b></td>
                <td align="left" width="55%">&nbsp;</td>
              </tr>
              <tr> 
                <td width="8%">&nbsp;</td>
                <td width="36%">Market value</td>
                <td width="1%"><b>:</b></td>
                <td align="left" width="55%">&nbsp;</td>
              </tr>
              <%}

			%>
            </table>
          </td>
        <tr> 
          <td width="4%">&nbsp;</td>
        </tr>
        <tr> 
          <td width="4%"><b>7(a)</b></td>
          <td width="32%"><b>SHAREHOLDING PATTERN</b></td>
          <%if (strOwnership.trim().equals("OLP")
					|| strOwnership.trim().equals("OCC")) {

			%>
          <td width="24%">&nbsp;</td>
          <%} else {

			%>
          <td width="40%">N.A.</td>
          <%}

			%>
        </tr>
        <%if (strOwnership.trim().equals("OLP")
					|| strOwnership.trim().equals("OCC")) {

				%>
        <tr> 
          <td colspan="3"> 
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3">
                <tr class="tblhead"> 
                  <td width="40%" align="center"><b> Share Holder</b></td>
                  <td width="20%" align="center"><b> No of Shares </b></td>
                  <td width="20%" align="center"><b> Value </b></td>
                  <td width="20%" align="center"><b> Holding % </b></td>
                </tr>
                <%ArrayList arr = new ArrayList();
				ArrayList arr1 = new ArrayList();
				double dblshares = 0.0;
				long lngvalue = 0;
				double dblholding = 0.0;
				arr = (ArrayList) hshValues.get("arrRow");
				if (arr != null && arr.size() > 0) {
					int arrSize = arr.size();
					for (int i = 0; i < arrSize; i++) {
						arr1 = (ArrayList) arr.get(i);
						dblshares = dblshares
								+ Double.parseDouble(Helper
										.correctDouble((String) arr1.get(4)));
						lngvalue = lngvalue
								+ (long) Double.parseDouble(Helper
										.correctDouble((String) arr1.get(6)));
						dblholding = dblholding
								+ Double.parseDouble(Helper
										.correctDouble((String) arr1.get(3)));

						%>
                <tr> 
                  <td width="40%">&nbsp;<%=arr1.get(0)%>&nbsp;<%=arr1.get(2)%>&nbsp;<%=arr1.get(1)%></td>
                  <td width="20%" align="right">&nbsp;<%=arr1.get(4)%></td>
                  <td width="20%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double
										.parseDouble(Helper
												.correctDouble((String) arr1
														.get(6))))%></td>
                  <%String val_hold = Helper.correctNull((String) arr1
								.get(3));
						double dblval_hold = 0.00;
						if (!val_hold.equalsIgnoreCase("")) {
							dblval_hold = Double.parseDouble(val_hold);
						}

						%>
                  <td width="20%" align="right">&nbsp;<%=Helper.formatDoubleValue(dblval_hold)%></td>
                </tr>
                <%}%>
                <tr> 
                  <td width="40%"><b>Total</b></td>
                  <td width="20%" align="right"><%=Helper.formatDoubleValue(dblshares)%> 
                  </td>
                  <td width="20%" align="right"><%=lngvalue%>.00</td>
                  <td width="20%" align="right"><%=Helper.formatDoubleValue(dblholding)%> 
                  </td>
                </tr>
                <%}

			%>
              </table>
            </div>
          </td>
        </tr>
        <%}

			%>
      </table>
    </td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" width="3%"><b>8.&nbsp;</b></td>
          <td width="35%" valign="top"><b>SECTOR / BSR CODE</b></td>
          <td width="1%" valign="top"><b>:</b></td>
          <td width="21%"><%=Helper.correctNull((String) hshValues
							.get("comapp_companyid"))%></td>
        </tr>
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" width="3%"><b>9.&nbsp;</b></td>
          <td width="35%" valign="top"><b>COMMENTS ON LATEST CREDIT/SEARCH REPORT</b></td>
          <td width="1%" valign="top"><b>:</b></td>
          <%String cmd_searchreport = Helper.correctNull((String) hshValues
					.get("cmd_searchreport"));%>
          <%if (cmd_searchreport.trim().equals("")) {%>
          <td valign="top" width="21%">Nil &nbsp;</td>
          <%} else {%>
          <td valign="top" width="40%">&nbsp;</td>
        </tr>
        <tr> 
          <td width="3%" valign="top"><b>&nbsp;</b></td>
          <td colspan="3" class="just"><%=Helper.formatTextAreaData((String) hshValues
								.get("cmd_searchreport"))%></td>
          <%}%>
        </tr>
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3" align="center">
  <tr> 
    <td width="3%"><b>10.</b></td>
    <td width="3%"><b>(a)</b></td>
    <td width="32%"><b>DEALING WITH BANK SINCE </b></td>
    <td width="1%"><b>:</b></td>
    <td width="21%">&nbsp;<%=Helper.correctNull((String) hshValues.get("deal_bank"))%></td>
  </tr>
  <tr> 
    <td colspan="5"><b> </b>&nbsp;</td>
  </tr>
  <tr> 
    <td width="3%" align="right">&nbsp;</td>
    <td width="3%" align="right"><b>(b)</b></td>
    <td width="32%"><b>CREDIT FACILITIES SINCE</b></td>
    <td width="1%"><b>:</b></td>
    <%if (Helper.correctNull((String) hshValues.get("exec_borrowertype"))
					.equalsIgnoreCase("E")) {

				%>
    <td width="21%">&nbsp;<%=Helper.correctNull((String) hshValues
								.get("credit_since"))%></td>
    <%} else {

			%>
    <td width="40%">&nbsp;New Borrower</td>
    <%}

			%>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr valign="top"> 
    <td align="right" colspan="5">&nbsp;</td>
  </tr>
  <tr valign="top"> 
    <td width="2%"><b>11.&nbsp;</b></td>
    <td><b>TOTAL INDEBTEDNESS </b></td>
  </tr>
  <tr valign="top"> 
    <td align="right" colspan="5"><b>(Rs In <%=strProposalvalue%>)</b></td>
  </tr>
  <tr valign="top"> 
    <td height="82" colspan="5"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr> 
          <td colspan="2"> 
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3">
                <tr> 
                  <td width="24%">&nbsp;</td>
                  <td colspan="2" align="center"><b>NON-FUND BASED </b></td>
                  <td colspan="2" align="center"><b>FUND BASED </b></td>
                  <td colspan="2" align="center"><b>TOTAL </b></td>
                </tr>
                <tr> 
                  <td width="24%">&nbsp;</td>
                  <td width="13%" align="center"><b>Existing </b></td>
                  <td width="13%" align="center"><b>Proposed </b></td>
                  <td width="13%" align="center"><b>Existing </b></td>
                  <td width="13%" align="center"><b>Proposed </b></td>
                  <td width="13%" align="center"><b>Existing </b></td>
                  <td width="13%" align="center"><b>Proposed </b></td>
                </tr>
                <%
                    ArrayList arr2=new ArrayList();
                    ArrayList arr3=new ArrayList();
                    double nfundext=0.00;
                    double nfundext1=0.00;
                    double nfundpro=0.00;
                    double nfundpro1=0.00;
                    
                    double fundext=0.00;
                    double fundext1=0.00;
                    double fundpro=0.00;
                    double fundpro1=0.00;
                    
                    double tfundext=0.00;
                    double tfundext1=0.00;
                    double tfundpro=0.00;
                    double tfundpro1=0.00;
                    
                                        
                    int arrSize1=0;
                    arr2=(ArrayList)hshValues.get("arrRow1");
                    if(arr2!=null && arr2.size()>0)
                    {
	                    arrSize1=  arr2.size();
					
                  for(int i=0;i<arrSize1;i++)
                  {
                	  arr3=(ArrayList)arr2.get(i); 
                 
                	  nfundext=Double.parseDouble(Helper.correctDouble((String)arr3.get(0)));
                	  nfundext1=nfundext1+nfundext;
                	  nfundpro=Double.parseDouble(Helper.correctDouble((String)arr3.get(1)));
                	  nfundpro1=nfundpro1+nfundpro; 
                	  
                	  fundext=Double.parseDouble(Helper.correctDouble((String)arr3.get(2)));
                	  fundext1=fundext1+fundext;
                	  fundpro=Double.parseDouble(Helper.correctDouble((String)arr3.get(3)));
                	  fundpro1=fundpro1+fundpro;
                	  
                	  
                	  tfundext=Double.parseDouble(Helper.correctDouble((String)arr3.get(4)));
                	  tfundext1=tfundext1+tfundext;
                	  tfundpro=Double.parseDouble(Helper.correctDouble((String)arr3.get(5)));
                	  tfundpro1=tfundpro1+tfundpro;
                	  
                	  
                    %>
                <tr> 
                  <td width="24%">Working Capital-<%=arr3.get(6)%></td>
                  <td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arr3.get(2))))%></td>
                  <td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arr3.get(3))))%></td>
                  <td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arr3.get(0))))%></td>
                  <td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arr3.get(1))))%></td>
                  <td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arr3.get(4))))%></td>
                  <td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arr3.get(5))))%></td>
                </tr>
                <%
                  }
                    }
                    %>
                <tr> 
                  <td width="24%">&nbsp;</td>
                  <td width="13%">&nbsp;</td>
                  <td width="13%">&nbsp;</td>
                  <td width="13%">&nbsp;</td>
                  <td width="13%">&nbsp;</td>
                  <td width="13%">&nbsp;</td>
                  <td width="13%">&nbsp;</td>
                </tr>
                <%
                    ArrayList arr4=new ArrayList();
                    ArrayList arr5=new ArrayList();
                    int arrSize3=0;
                    arr4=(ArrayList)hshValues.get("arrRow2");
                    if(arr4!=null && arr4.size()>0){
                    	
                        arrSize3=  arr4.size();

                  for(int i=0;i<arrSize3;i++)
                  {
                	  arr5=(ArrayList)arr4.get(i); 
                 
                	  nfundext=Double.parseDouble(Helper.correctDouble((String)arr5.get(0)));
                	  nfundext1=nfundext1+nfundext;	
                	  nfundpro=Double.parseDouble(Helper.correctDouble((String)arr5.get(1)));
                	  nfundpro1=nfundpro1+nfundpro;
                	  
                	  fundext=Double.parseDouble(Helper.correctDouble((String)arr5.get(2)));
                	  fundext1=fundext1+fundext;
                	  fundpro=Double.parseDouble(Helper.correctDouble((String)arr5.get(3)));
                	  fundpro1=fundpro1+fundpro;
                	  
                	  tfundext=Double.parseDouble(Helper.correctDouble((String)arr5.get(4)));
                	  tfundext1=tfundext1+tfundext;
                	  tfundpro=Double.parseDouble(Helper.correctDouble((String)arr5.get(5)));
                	  tfundpro1=tfundpro1+tfundpro;
                	  
                	  
                    %>
                <tr> 
                  <td width="24%">Term Loan-<%=arr5.get(6)%></td>
                  <td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arr5.get(2))))%></td>
                  <td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arr5.get(3))))%></td>
                  <td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arr5.get(0))))%></td>
                  <td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arr5.get(1))))%></td>
                  <td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arr5.get(4))))%></td>
                  <td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arr5.get(5))))%></td>
                </tr>
                <%
                  }}
                    %>
                <tr> 
                  <td width="24%" align="right"><b> TOTAL</b></td>
                  <td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(fundext1) %></td>
                  <td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(fundpro1) %></td>
                  <td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(nfundext1) %></td>
                  <td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(nfundpro1) %></td>
                  <td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(tfundext1) %></td>
                  <td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(tfundpro1) %></td>
                </tr>
              </table>
            </div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr valign="top"> 
    <td align="right" colspan="5">&nbsp;</td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td width="3%" align="left"><b>&nbsp;11.1</b></td>
    <td width="29%"><b>BRIEF BACKGROUND</b></td>
    <td width="1%"><b>:</b></td>
    <%String companybackground = Helper.correctEditor((String) hshValues.get("companybackground"));
			if (companybackground.trim().equals("")|| companybackground.equalsIgnoreCase("<P>&nbsp;</P>")) {%>
    <td valign="top" width="27%">Nil &nbsp;</td>
    <%} else {%>
    <td valign="top" width="40%">&nbsp;</td>
  </tr>
  <tr> 
    <td width="3%">&nbsp;</td>
    <td colspan="5"><%=companybackground%></td>
    <%}%>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td colspan="5">&nbsp;</td>
  </tr>
  <tr> 
    <td width="3%"><b>12.&nbsp;</b></td>
    <td><b>FINANCIAL INDICATORS </b></td>
  </tr>
  <%ArrayList arr = null;
			arrsize = 0;

			if (hshValues != null) {
				arr = (ArrayList) hshValues.get("arrValFin");
			}
			if (arr != null) {
				arrsize = arr.size();
			}

			ArrayList g1 = null;

			for (int l = 0; l < 23; l++) {

				int arrSize = 0;

				if (l < arrsize) {
					g1 = (ArrayList) arr.get(l);

					if (g1 != null) {
						arrSize = g1.size();
					}
				}

				if (arrSize > 0) {
					if (l == 0) {

						%>
  <tr valign="top"> 
    <td align="right" colspan="5"><b>(Rs In <%=strProposalvalue%>)</b></td>
  </tr>
  <tr> 
    <td width="3%">&nbsp;</td>
    <td> 
      <div id="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="3">
          <tr class="tblhead"> 
            <td>&nbsp;</td>
            <td align="center">Year ended</td>
            <td align="center">Year ended</td>
            <td align="center">Year ended</td>
            <td align="center">Year ended</td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
            <td align="center"><%=Helper.correctNull((String) g1.get(0))%></td>
            <td align="center"><%=Helper.correctNull((String) g1.get(1))%></td>
            <td align="center"><%=Helper.correctNull((String) g1.get(2))%></td>
            <td align="center"><%=Helper.correctNull((String) g1.get(3))%></td>
          </tr>
          <%} else if (l == 1) {

						%>
          <tr> 
            <td>&nbsp;</td>
            <td align="center"><%=Helper.correctNull((String) g1.get(0))%></td>
            <td align="center"><%=Helper.correctNull((String) g1.get(1))%></td>
            <td align="center"><%=Helper.correctNull((String) g1.get(2))%></td>
            <td align="center"><%=Helper.correctNull((String) g1.get(3))%></td>
          </tr>
          <%} else {

						%>
          <tr> 
            <td><%=Helper.correctNull((String) g1.get(4))%></td>
            <td align="right"><%=Helper.correctNull((String) g1.get(0))%></td>
            <td align="right"><%=Helper.correctNull((String) g1.get(1))%></td>
            <td align="right"><%=Helper.correctNull((String) g1.get(2))%></td>
            <td align="right"><%=Helper.correctNull((String) g1.get(3))%></td>
          </tr>
          <%}
				}
			}

			%>
        </table>
      </div>
    </td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td colspan="4">&nbsp;</td>
  </tr>
  <tr> 
    <td width="3%" valign="top"><b>12.1</b></td>
    <td width="42%" valign="top"><b>COMMENTS ON FINANCIAL INDICATORS </b></td>
    <td width="1%" valign="top"><b>:</b></td>
    <%String financial = Helper.correctEditor((String) hshValues.get("comments"));
			if (financial.trim().equals("") || financial.equalsIgnoreCase("<P>&nbsp;</P>")) {%>
    <td width="53%" valign="top">Nil &nbsp;</td>
    <%} else {%>
    <td valign="top" width="1%">&nbsp;</td>
  </tr>
  <tr> 
    <td valign="top" width="3%"><b>&nbsp;</b></td>
    <td valign="top" colspan="3"><%=financial%></td>
    <%}%>
  </tr>
  <tr> 
    <td colspan="4">&nbsp;</td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="2%" valign="top"><b>13.&nbsp;</b></td>
          <td width="1%" valign="top"><b>A.</b></td>
          <td width="42%" valign="top"><b>CONDUCT OF THE ACCOUNT</b></td>
          <%String selstock0 = Helper.correctNull((String) hshValues
					.get("conduct_acc"));
			if (selstock0.equalsIgnoreCase("1")) {
				selstock0 = "Satisfactory";
			} else if (selstock0.equalsIgnoreCase("2")) {
				selstock0 = "Not Satisfactory";
			} else if (selstock0.equalsIgnoreCase("3")) {
				selstock0 = "Good";
			} else if (selstock0.equalsIgnoreCase("4")) {
				selstock0 = "Poor";
			} else if (selstock0.equalsIgnoreCase("5")) {
				selstock0 = "Not Healthy";
			} else {
				selstock0 = " ";
			}

			%>
          <td width="1%" valign="top"><b>:&nbsp;</b></td>
          <td valign="top" class="just" width="54%"><%=selstock0%></td>
        </tr>
        <tr> 
          <td colspan="3" valign="top">&nbsp;</td>
          <td width="1%" valign="top">&nbsp;</td>
          <td valign="top" class="just" > <%=Helper.formatTextAreaData((String) hshValues.get("conduct_no"))%> 
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr> 
          <td rowspan="11" valign="top" width="6%" align="right"><b>&nbsp;(i)</b></td>
          <td width="39%"><b>Regularity in submission of </b></td>
          <td width="1%">&nbsp;</td>
          <td width="54%">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" width="39%" class="subheading"><b>-Stock Statements 
            / Book Debt Statements</b></td>
          <%
				String selstock = Helper.correctNull((String) hshValues.get("conduct_accstock"));
				if (selstock.equalsIgnoreCase("1")) 
				{
					selstock = "Yes";
				}
				else if (selstock.equalsIgnoreCase("2")) 
				{
					selstock = "No";
				}
				else 
				{
					selstock = " ";
				}
			%>
          <td valign="top" width="1%"><b>:</b></td>
          <td valign="top" width="54%"><b><%=selstock%></b></td>
        </tr>
        <tr> 
          <td valign="top" width="39%" class="subheading">&nbsp;</td>
          <td valign="top" width="1%">&nbsp;</td>
          <td valign="top" width="54%" class="just"> <%=Helper.formatTextAreaData((String) hshValues.get("conduct_stockno"))%> 
          </td>
        </tr>
        <tr> 
          <td valign="top" width="39%" class="subheading"><b>-MSOD </b></td>
          <td valign="top" width="1%"><b>:</b></td>
          <%
				String selstock1 = Helper.correctNull((String) hshValues.get("conduct_msod"));
				if (selstock1.equalsIgnoreCase("1")) 
				{
					selstock1 = "Yes";
				}
				else if (selstock1.equalsIgnoreCase("2"))
				{
					selstock1 = "No";
				}
				else
				{
					selstock1 = " ";
				}
			%>
          <td valign="top" width="54%"><b><%=selstock1%></b></td>
        </tr>
        <tr> 
          <td valign="top" width="39%" class="subheading">&nbsp;</td>
          <td valign="top" width="1%">&nbsp;</td>
          <td valign="top" width="54%" class="just"> <%=Helper.formatTextAreaData((String) hshValues.get("conduct_msodno"))%> 
          </td>
        </tr>
        <tr> 
          <td valign="top" width="39%" class="subheading"><b>-QPR Statements / 
            Half Yearly Statements </b></td>
          <td valign="top" width="1%"><b>:</b></td>
          <%
					String selstock2 = Helper.correctNull((String) hshValues.get("conduct_qpr"));
					if (selstock2.equalsIgnoreCase("1")) 
					{
						selstock2 = "Yes";
					}
					else if (selstock2.equalsIgnoreCase("2")) 
					{
						selstock2 = "No";
					}
					else
					{
						selstock2 = " ";
					}
			%>
          <td valign="top" width="54%"><b><%=selstock2%></b></td>
        </tr>
        <tr> 
          <td valign="top" width="39%" class="subheading">&nbsp;</td>
          <td valign="top" width="1%">&nbsp;</td>
          <td valign="top" width="54%" class="just"> <%=Helper.formatTextAreaData((String) hshValues.get("conduct_qprno"))%> 
          </td>
        </tr>
        <tr> 
          <td valign="top" width="39%" class="subheading"><b>-Financial Statements</b></td>
          <td valign="top" width="1%"><b>:</b></td>
          <%
				String selstock3 = Helper.correctNull((String) hshValues.get("conduct_fin"));
				if (selstock3.equalsIgnoreCase("1")) 
				{
					selstock3 = "Yes";
				}
				else if (selstock3.equalsIgnoreCase("2")) 
				{
					selstock3 = "No";
				}
				else
				{
					selstock3 = " ";
				}
			%>
          <td valign="top" width="54%"><b><%=selstock3%></b></td>
        </tr>
        <tr> 
          <td valign="top" width="39%" class="subheading">&nbsp;</td>
          <td valign="top" width="1%">&nbsp;</td>
          <td valign="top" width="54%" class="just"> <%=Helper.formatTextAreaData((String) hshValues.get("conduct_finno"))%> 
          </td>
        </tr>
        <tr> 
          <td valign="top" width="39%" class="subheading"><b> -CMA Data</b></td>
          <td valign="top" width="1%"><b>:</b></td>
          <%
				String selstock4 = Helper.correctNull((String) hshValues.get("conduct_cma"));
				if (selstock4.equalsIgnoreCase("1")) 
				{
					selstock4 = "Yes";
				}
				else if (selstock4.equalsIgnoreCase("2")) 
				{
					selstock4 = "No";
				}
				else 
				{
					selstock4 = " ";
				}
			%>
          <td valign="top" width="54%"><b><%=selstock4%></b></td>
        </tr>
        <tr> 
          <td valign="top" width="39%" class="subheading">&nbsp;</td>
          <td valign="top" width="1%">&nbsp;</td>
          <td valign="top" width="54%" class="just"> <%=Helper.formatTextAreaData((String) hshValues.get("conduct_cmano"))%> 
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="6%">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" width="6%" rowspan="4" align="right"><b>(ii)&nbsp;</b></td>
          <td valign="top" width="37%" height="49"><b>Name of the Statement/return</b></td>
          <td valign="top" width="1%"> 
            <p><b><b>:</b></b></p>
            <p><b></b></p>
          </td>
          <td valign="top" width="29%" height="49" bgcolor="#E6E6E6"><b>No of 
            Statements/Return recd. during the year</b></td>
          <td valign="top" width="27%" height="49" bgcolor="#E6E6E6"><b>Last Stat. 
            / Return recd.</b></td>
        </tr>
        <tr> 
          <td valign="top" width="37%" class="subheading"><b>Stock Statement /BD 
            </b></td>
          <td valign="top" width="1%"><b><b>:</b></b></td>
          <td valign="top" width="29%" bgcolor="#F4F4F4">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("conduct_stockstamt"))%></td>
          <td valign="top" width="27%" bgcolor="#F4F4F4">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("conduct_stockdate"))%></td>
        </tr>
        <tr> 
          <td valign="top" width="37%" class="subheading"><b>MSOD </b></td>
          <td valign="top" width="1%"><b><b>:</b></b></td>
          <td valign="top" width="29%" bgcolor="#F4F4F4">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("conduct_msodstmt"))%></td>
          <td valign="top" width="27%" bgcolor="#F4F4F4">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("conduct_msoddate"))%></td>
        </tr>
        <tr> 
          <td valign="top" width="37%" class="subheading"><b>QPR / Half Yearly 
            Statement</b></td>
          <td valign="top" width="1%"><b><b>:</b></b></td>
          <td valign="top" width="29%" bgcolor="#F4F4F4">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("conduct_qprstmt"))%></td>
          <td valign="top" width="27%" bgcolor="#F4F4F4">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("conduct_qprdate"))%></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr> 
          <td width="3%">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" rowspan="2" align="right" width="3%"><b>B.&nbsp;</b></td>
          <td valign="top" width="46%"><b>COMMENTS ON OPERATIONS / OVERDUES </b></td>
          <td valign="top" width="0%"><b>:</b></td>
          <%String conduct_turn = Helper.formatTextAreaData((String) hshValues
					.get("conduct_turn"));
			if (conduct_turn.trim().equals("")) {%>
          <td valign="top" width="48%">Nil</td>
          <%} else {%>
          <td valign="top" width="3%">&nbsp;</td>
        </tr>
        <tr> 
          <td colspan="3" class="just"><%=conduct_turn%></td>
          <%}%>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="2%">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" width="2%"><b>14.&nbsp;</b></td>
          <td valign="top" colspan="4"><b> COMPLIANCE TO TERMS OF SANCTION </b></td>
        </tr>
        <tr> 
          <td width="2%">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" width="2%">&nbsp;</td>
          <td width="1%" valign="top"><b>a) </b></td>
          <td width="46%" valign="top"><b>Completion of Mortgage formalities</b></td>
          <%String selmort = Helper.correctNull((String) hshValues
					.get("exec_summ_mortage"));
			if (selmort.equalsIgnoreCase("1")) {
				selmort = "Yes";
			} else if (selmort.equalsIgnoreCase("2")) {
				selmort = "No";
			} else {
				selmort = " ";
			}

			%>
          <td valign="top" width="0%"><b>:</b></td>
          <td valign="top" width="51%"><b><%=selmort%></b></td>
        </tr>
        <tr> 
          <td valign="top" width="2%">&nbsp;</td>
          <td width="1%" valign="top">&nbsp;</td>
          <td width="46%" valign="top">&nbsp;</td>
          <td valign="top" width="0%"></td>
          <td width="51%" class="just"><%=Helper.formatTextAreaData((String) hshValues
							.get("exec_summ_mortageY"))%></td>
        </tr>
        <tr> 
          <td valign="top" width="2%">&nbsp;</td>
          <td valign="top" width="1%"><b>b) </b></td>
          <td valign="top" width="46%"><b>Registration of charges with RoC</b></td>
          <%String selroc = Helper.correctNull((String) hshValues
					.get("exec_summ_roc"));
			if (selroc.equalsIgnoreCase("1")) {
				selroc = "Yes";
			} else if (selroc.equalsIgnoreCase("2")) {
				selroc = "No";
			} else {
				selroc = " ";
			}

			%>
          <td valign="top" width="0%"><b>:</b></td>
          <td valign="top" width="51%"><b><%=selroc%></b></td>
        </tr>
        <tr> 
          <td valign="top" width="2%">&nbsp;</td>
          <td valign="top" width="1%">&nbsp;</td>
          <td valign="top" width="46%">&nbsp;</td>
          <td valign="top" width="0%">&nbsp;</td>
          <td width="51%" class="just"><%=Helper.formatTextAreaData((String) hshValues
							.get("exec_summ_rocY"))%></td>
        </tr>
        <tr> 
          <td valign="top" width="2%">&nbsp;</td>
          <td valign="top" width="1%"><b>c) </b></td>
          <td valign="top" width="46%"><b>Whether documents valid and in force</b></td>
          <%String selroc1 = Helper.correctNull((String) hshValues
					.get("exec_summ_validdoc"));
			if (selroc1.equalsIgnoreCase("1")) {
				selroc1 = "Yes";
			} else if (selroc1.equalsIgnoreCase("2")) {
				selroc1 = "No";
			} else {
				selroc1 = " ";
			}

			%>
          <td valign="top" width="0%"><b>:</b></td>
          <td valign="top" width="51%"><b><%=selroc1%></b></td>
        </tr>
        <tr> 
          <td valign="top" width="2%">&nbsp;</td>
          <td valign="top" width="1%">&nbsp;</td>
          <td valign="top" width="46%">&nbsp;</td>
          <td valign="top" width="0%">&nbsp;</td>
          <td width="51%" class="just"><%=Helper.formatTextAreaData((String) hshValues
							.get("exec_summ_validdocY"))%></td>
        </tr>
        <tr> 
          <td valign="top" width="2%">&nbsp;</td>
          <td valign="top" width="1%"><b>d)</b></td>
          <td valign="top" width="46%"><b>Compliance of RBI guidelines</b></td>
          <%String selroc3 = Helper.correctNull((String) hshValues
					.get("exec_summ_indlevelrbiY2"));
			if (selroc3.equalsIgnoreCase("1")) {
				selroc3 = "Yes";
			} else if (selroc3.equalsIgnoreCase("2")) {
				selroc3 = "No";
			} else {
				selroc3 = " ";
			}

			%>
          <td valign="top" width="0%"><b>:</b></td>
          <td valign="top" width="51%"><b><%=selroc3%> </b></td>
        </tr>
        <tr> 
          <td valign="top" width="2%">&nbsp;</td>
          <td valign="top" width="1%">&nbsp;</td>
          <td valign="top" width="46%">&nbsp;</td>
          <td valign="top" width="0%">&nbsp;</td>
          <td class="just" width="51%"> <%=Helper.formatTextAreaData((String) hshValues.get("exec_summ_indlevelrbiremarks2"))%> 
          </td>
        </tr>
        <tr> 
          <td valign="top" width="2%">&nbsp;</td>
          <td valign="top" width="1%"><b>e) </b></td>
          <td valign="top" width="46%"><b>Whether consortium meetings held at 
            prescribed periodic intervals where the Bank is the leader</b></td>
          <%String selroc4 = Helper.correctNull((String) hshValues
					.get("exec_summ_meetingheld"));
			if (selroc4.equalsIgnoreCase("1")) {
				selroc4 = "Yes";
			} else if (selroc4.equalsIgnoreCase("2")) {
				selroc4 = "No";
			} else {
				selroc4 = " ";
			}

			%>
          <td valign="top" width="0%"><b>:</b></td>
          <td valign="top" width="51%"><b><%=selroc4%></b></td>
        </tr>
        <tr> 
          <td valign="top" width="2%">&nbsp;</td>
          <td valign="top" width="1%">&nbsp;</td>
          <td valign="top" width="46%">&nbsp;</td>
          <td valign="top" width="0%">&nbsp;</td>
          <td class="just" width="51%"><%=Helper.formatTextAreaData((String) hshValues
							.get("exec_summ_meetingheldY"))%> &nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" width="3%"><b>15&nbsp;</b></td>
          <td valign="top" width="2%"><b>i) </b></td>
          <td valign="top" width="46%"><b>NATURE AND VALUE OF COLLATERAL SECURITY</b></td>
          <td valign="top" width="49%"><b>:</b></td>
        </tr>
        <tr> 
          <td valign="top" align="right" colspan="4"><b>(<%=ApplicationParams.getCurrency()%> 
            In <%=strProposalvalue%>)</b></td>
        </tr>
        <tr> 
          <td valign="top" colspan="4"> 
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3">
                <tr align="center" class="tblhead"> 
                  <td width="32%" align="left"><b>Nature / Description of collateral 
                    security indicating area &amp; location of property</b></td>
                  <td width="12%"><b> Value<BR>
                    </b></td>
                  <td width="19%" align="left"><b> Date of Valuation along with 
                    name of Valuer</b></td>
                  <td width="21%" align="left"><b>Insurance Amount &amp; Date 
                    of Expiry</b></td>
                </tr>
                <%ArrayList arrColldetails = new ArrayList();
			ArrayList arrValues = new ArrayList();
			arrColldetails = (ArrayList) hshValues.get("arrColldetails");
			double dbltotal=0.00;
			if (arrColldetails != null && arrColldetails.size() != 0) {
				for (int i = 0; i < arrColldetails.size(); i++) {
					arrValues = (ArrayList) arrColldetails.get(i);
					dbltotal = dbltotal+Double.parseDouble(Helper.correctDouble((String) arrValues.get(1)));
					%>
                <tr valign="top"> 
                  <td width="32%" class="just"><%=Helper.formatTextAreaData((String) arrValues
									.get(0))%> &nbsp;</td>
                  <td width="12%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrValues
													.get(1))))%></td>
                  <td width="19%">&nbsp;<%=Helper.correctNull((String) arrValues.get(2))%> 
                    - <%=Helper.correctNull((String) arrValues.get(3))%></td>
                  <td width="21%" align="center">&nbsp; 
                    <%if (Helper.formatDoubleValue(
							Double.parseDouble(Helper
									.correctDouble((String) arrValues.get(4))))
							.equals("0.00")) {
						out.println("-");
					} else {%>
                    <%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrValues
																		.get(4))))%> 
                    - <%=Helper.correctNull((String) arrValues
												.get(5))%></td>
                  <%}%>
                </tr>
                <%}%>
                <tr> 
                  <td><b>Total</b></td>
                  <td align="right"><%=Helper.formatDoubleValue(dbltotal)%></td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <%} else {

			%>
                <tr> 
                  <td width="32%">&nbsp;</td>
                  <td width="12%">&nbsp;</td>
                  <td width="19%">&nbsp;</td>
                  <td width="21%">&nbsp;</td>
                </tr>
                <%}

			%>
              </table>
            </div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<%
                    arrRow=new ArrayList();
                    arrData=new ArrayList();
                    arrRow=(ArrayList)hshValues.get("arrCollRemarks");
                    if(arrRow!=null && arrRow.size()!=0){
                
                    %>
<table width="90%" border="0" cellspacing="0" cellpadding="3" align="center">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <%  for(int i=0;i<arrRow.size();i++)
      {
    	  arrData=(ArrayList)arrRow.get(i); 
    	  if(!Helper.formatTextAreaData((String)arrData.get(0)).equalsIgnoreCase("")){ %>
        <tr> 
          <td width="3%">&nbsp;</td>
        </tr>
        <tr> 
          <td width="3%">&nbsp;</td>
          <td valign="top" class="just" width="97%"><%=Helper.formatTextAreaData((String)arrData.get(0))%>&nbsp;</td>
        </tr>
        <%}
	  } %>
      </table>
    </td>
  </tr>
</table>
<%   }
                    %>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td colspan="3">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" width="3%">&nbsp;</td>
          <td valign="top" width="2%">ii)</td>
          <td valign="top" width="95%"><b> PERSONAL GUARANTEE (with means) / CORPORATE 
            GUARANTEE (with TNW of company)</b></td>
        </tr>
        <tr> 
          <td valign="top" colspan="3"> 
            <div id="top"> 
              <table width="65%" border="0" cellspacing="0" cellpadding="3">
                <%boolean bolguarantee = false;
                boolean corpguarantee = false;
			arrRow = new ArrayList();
			arrData = new ArrayList();

			arrRow = (ArrayList) hshValues.get("arrGuarantors");

			if (arrRow != null && arrRow.size() != 0) {
				bolguarantee = true;

				%>
                <tr align="center" class="tblhead "> 
                  <td  align="center"><b>Name</b></td>
                  <td  align="center"><b>Means (<%=ApplicationParams.getCurrency()%> 
                    In <%=strProposalvalue%>)</b></td>
                 <td  align="center"><b>Means as on</b></td>
                </tr>
                <tr align="center"> 
                  <td align="left" colspan="3"><b>PERSONAL GUARANTEE</b></td>
                </tr>
                <%for (int i = 0; i < arrRow.size(); i++) {
					arrData = (ArrayList) arrRow.get(i);

					%>
                <tr> 
                  <td  align="left"><%=arrData.get(0)%>&nbsp;<%=arrData.get(2)%>&nbsp;<%=arrData.get(1)%></td>
                  <td  align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrData.get(4))))%></td>
                  <td  align="left"><%=arrData.get(5)%></td>
                </tr>
                <%}
			}

			%>
                <%
				if (Helper.correctNull(
						(String) hshValues.get("sel_applicantguarantee"))
						.equalsIgnoreCase("Y")) {
					if (!bolguarantee) {
						bolguarantee = true;%>
                <tr align="center" class="tblhead "> 
                  <td  align="center"><b>Name</b></td>
                  <td  align="center"><b>Means (<%=ApplicationParams.getCurrency()%> 
                    In <%=strProposalvalue%>)</b></td>
                  <td  align="center"><b>Means as on</b></td>
                </tr>
                <%}%>
                 <%if(!corpguarantee){
                	corpguarantee=true;%>
                <tr align="center"> 
                  <td align="left" colspan="3"><b>CORPORATE GUARANTEE</b></td>
                </tr>
                <%} %>
                <tr align="center"> 
                  <td  align="left"><%=Helper.correctNull((String) hshValues
									.get("comapp_companyname"))%>&nbsp;</td>
                  <td  align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("means"))))%>&nbsp;</td>
                  <td  align="left"><%=Helper.correctNull((String) hshValues
									.get("meansason"))%>&nbsp;</td>
                </tr>
                <%}%>
                
                <%arrRow = new ArrayList();
					arrData = new ArrayList();
					arrRow = (ArrayList) hshValues.get("arrCorpguarantee");
					if (arrRow != null && arrRow.size() > 0) {
						if (!bolguarantee) {
							bolguarantee = true;%>
                <tr align="center" class="tblhead "> 
                  <td  align="center"><b>Name</b></td>
                  <td  align="center"><b>Means (<%=ApplicationParams.getCurrency()%> 
                    In <%=strProposalvalue%>)</b></td>
                  <td  align="center"><b>Means as on</b></td>
                </tr>
                <%}%>
                <%if(!corpguarantee){
                	corpguarantee=true;%>
                <tr align="center"> 
                  <td align="left" colspan="3"><b>CORPORATE GUARANTEE</b></td>
                </tr>
                <%} %>
                <%for (int i = 0; i < arrRow.size(); i++) {
							arrData = (ArrayList) arrRow.get(i);

							%>
                <tr align="center"> 
                  <td  align="left"><%=Helper.correctNull((String) arrData
											.get(0))%>&nbsp;</td>
                  <td  align="right">&nbsp;<%=Helper
													.formatDoubleValue(Double
															.parseDouble(Helper
																	.correctDouble((String) arrData
																			.get(4))))%>&nbsp;</td>
				<td  align="left"><%=arrData.get(5)%></td>
                </tr>
                <%}
					}
				
			%>
              </table>
            </div>
            <%if (!bolguarantee) {
				out.print("Nil");
			}%>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td colspan="5">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" width="3%"><b>16.&nbsp;</b></td>
          <td valign="top" colspan="4"><b> AUDIT OBSERVATIONS :</b></td>
        </tr>
        <tr> 
          <td valign="top" width="3%"><b>&nbsp;</b></td>
          <td valign="top" width="3%"><b>a)&nbsp;</b></td>
          <td valign="top" colspan="3"><b> Internal 
            <%-- &nbsp;&nbsp;&nbsp; Date:<%=Helper.correctNull((String)hshValues.get("audit_internal_date"))%> --%>
            </b></td>
        </tr>
        <tr> 
          <td colspan="5" valign="top">&nbsp;&nbsp;<br />
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3">
                <%arrRow = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrInternal");%>
                <tr> 
                  <td width="50%" align="center"><b>Audit Remark </b></td>
                  <td width="50%" align="center"><b>Branch Reply</b></td>
                </tr>
                <%
			if (arrRow != null && arrRow.size() > 0) {

				%>
                <%for (int i = 0; i < arrRow.size(); i++) {
					arrCol = new ArrayList();
					arrCol = (ArrayList) arrRow.get(i);

					%>
                <tr> 
                  <td width="50%" valign="top"  class="just"><%=Helper.formatTextAreaData((String) arrCol
											.get(0))%>&nbsp;</td>
                  <td width="50%" valign="top" class="just"><%=Helper.formatTextAreaData((String) arrCol
											.get(1))%>&nbsp;</td>
                </tr>
                <%}
			}else {%>
                <tr> 
                  <td width="50%">&nbsp;</td>
                  <td width="50%">&nbsp;</td>
                </tr>
                <%} %>
              </table>
            </div>
          </td>
        </tr>
        <tr> 
          <td colspan="5">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" width="3%"><b>&nbsp;</b></td>
          <td valign="top" width="3%"><b>b)&nbsp;</b></td>
          <td valign="top" colspan="3"><b> Concurrent
            <%-- &nbsp;&nbsp;&nbsp; Date:<%=Helper.correctNull((String)hshValues.get("audit_concurrent_date"))%> --%>
            </b></td>
        </tr>
        <tr> 
          <td colspan="5" valign="top">&nbsp;&nbsp; <br />
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3">
                <%arrRow = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrConcurrent");%>
                <tr> 
                  <td width="50%" align="center"><b>Audit Remark </b></td>
                  <td width="50%" align="center"><b>Branch Reply</b></td>
                </tr>
                <%
			if (arrRow != null && arrRow.size() > 0) {

				%>
                <%for (int i = 0; i < arrRow.size(); i++) {
					arrCol = new ArrayList();
					arrCol = (ArrayList) arrRow.get(i);

					%>
                <tr> 
                  <td width="50%" valign="top"  class="just"><%=Helper.formatTextAreaData((String) arrCol
											.get(0))%>&nbsp;</td>
                  <td width="50%" valign="top" class="just"><%=Helper.formatTextAreaData((String) arrCol
											.get(1))%>&nbsp;</td>
                </tr>
                <%}
			} else {%>
                <tr> 
                  <td width="50%">&nbsp;</td>
                  <td width="50%">&nbsp;</td>
                </tr>
                <%} %>
              </table>
            </div>
          </td>
        </tr>
        <tr> 
          <td colspan="5">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" width="3%"><b>&nbsp;</b></td>
          <td valign="top" width="3%"><b>c)&nbsp;</b></td>
          <td valign="top" colspan="3"><b> Statutory 
            <%-- &nbsp;&nbsp;&nbsp; Date:<%=Helper.correctNull((String)hshValues.get("audit_statutory_date"))%> --%>
            </b></td>
        </tr>
        <tr> 
          <td colspan="5" valign="top">&nbsp;&nbsp; <br />
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3">
                <%arrRow = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrStatutory");%>
                <tr> 
                  <td width="50%" align="center"><b>Audit Remark </b></td>
                  <td width="50%" align="center"><b>Branch Reply</b></td>
                </tr>
                <%
			if (arrRow != null && arrRow.size() > 0) {

				%>
                <%for (int i = 0; i < arrRow.size(); i++) {
					arrCol = new ArrayList();
					arrCol = (ArrayList) arrRow.get(i);

					%>
                <tr> 
                  <td width="50%" valign="top"  class="just"><%=Helper.formatTextAreaData((String) arrCol
											.get(0))%>&nbsp;</td>
                  <td width="50%" valign="top" class="just"><%=Helper.formatTextAreaData((String) arrCol
											.get(1))%>&nbsp;</td>
                </tr>
                <%}
			} else {%>
                <tr> 
                  <td width="50%">&nbsp;</td>
                  <td width="50%">&nbsp;</td>
                </tr>
                <%} %>
              </table>
            </div>
          </td>
        </tr>
        <tr> 
          <td colspan="5">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" width="3%"><b>&nbsp;</b></td>
          <td valign="top" width="3%"><b>d)&nbsp;</b></td>
          <td valign="top" colspan="3"><b> RBI Inspection 
            <%-- &nbsp;&nbsp;&nbsp; Date:<%=Helper.correctNull((String)hshValues.get("audit_inspection_date"))%> --%>
            </b></td>
        </tr>
        <tr> 
          <td colspan="5" valign="top">&nbsp;&nbsp; <br />
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3">
                <%arrRow = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrRBI");
			%>
                <tr> 
                  <td width="50%" align="center"><b>Audit Remark </b></td>
                  <td width="50%" align="center"><b>Branch Reply</b></td>
                </tr>
                <%
			if (arrRow != null && arrRow.size() > 0) {

				%>
                <%for (int i = 0; i < arrRow.size(); i++) {
					arrCol = new ArrayList();
					arrCol = (ArrayList) arrRow.get(i);

					%>
                <tr> 
                  <td width="50%" valign="top"  class="just"><%=Helper.formatTextAreaData((String) arrCol
											.get(0))%>&nbsp;</td>
                  <td width="50%" valign="top" class="just"><%=Helper.formatTextAreaData((String) arrCol
											.get(1))%>&nbsp;</td>
                </tr>
                <%}
			} else {%>
                <tr> 
                  <td width="50%">&nbsp;</td>
                  <td width="50%">&nbsp;</td>
                </tr>
                <%} %>
              </table>
            </div>
          </td>
        </tr>
        <tr> 
          <td colspan="5">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" width="3%"><b>&nbsp;</b></td>
          <td valign="top" width="3%"><b>e)&nbsp;</b></td>
          <td valign="top" colspan="3"><b> Stock Audit 
            <%-- &nbsp;&nbsp;&nbsp; Date:<%=Helper.correctNull((String)hshValues.get("audit_stock_date"))%> --%>
            </b></td>
        </tr>
        <tr> 
          <td colspan="5">&nbsp;&nbsp; <br />
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3">
                <%arrRow = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrStock");%>
                <tr> 
                  <td width="50%" align="center"><b>Audit Remark </b></td>
                  <td width="50%" align="center"><b>Branch Reply</b></td>
                </tr>
                <%
			if (arrRow != null && arrRow.size() > 0) {

				%>
                <%for (int i = 0; i < arrRow.size(); i++) {
					arrCol = new ArrayList();
					arrCol = (ArrayList) arrRow.get(i);

					%>
                <tr> 
                  <td width="50%" valign="top"  class="just"><%=Helper.formatTextAreaData((String) arrCol
											.get(0))%>&nbsp;</td>
                  <td width="50%" valign="top" class="just"><%=Helper.formatTextAreaData((String) arrCol
											.get(1))%>&nbsp;</td>
                </tr>
                <%}
			} else {%>
                <tr> 
                  <td width="50%">&nbsp;</td>
                  <td width="50%">&nbsp;</td>
                </tr>
                <%} %>
              </table>
            </div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr> 
          <td valign="top" colspan="4">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" width="3%"><b>17.&nbsp;</b></td>
          <td width="37%" valign="top"><b> ANY IRREGULAR FEATURE OBSERVED IN THE 
            MONITORING REPORT</b></td>
          <td valign="top" width="2%"><b>:</b></td>
          <%String exec_summ_indlevelgenmanager = Helper
					.formatTextAreaData((String) hshValues
							.get("exec_summ_indlevelgenmanager"));
			if (exec_summ_indlevelgenmanager.trim().equals("")
					|| exec_summ_indlevelgenmanager
							.equalsIgnoreCase("<P>&nbsp;</P>")) {%>
          <td valign="top" width="20%">Nil &nbsp;</td>
          <%} else {%>
          <td valign="top" width="38%">&nbsp;</td>
        </tr>
        <tr> 
          <td width="3%" valign="top"><b>&nbsp;</b></td>
          <td colspan="3" class="just"><%=exec_summ_indlevelgenmanager%></td>
          <%}%>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td valign="top" colspan="3">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" width="3%"><b>18.&nbsp;</b></td>
          <td valign="top" width="2%"><b>a) </b></td>
          <td valign="top" width="95%"><b>EXPOSURE DETAILS FROM OUR BANK</b></td>
        </tr>
        <tr> 
          <td align="right" valign="top" colspan="3"><b>(Rs In <%=strProposalvalue%>)</b>&nbsp;&nbsp; 
            <br />
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3">
                <tr class="tblhead"> 
                  <td width="22%" align="center"><b> Nature of Facility</b></td>
                  <td width="12%" align="center"><b> Limits Existing</b></td>
                  <td width="11%" align="center"><b> Limits Recommended</b></td>
                  <td width="8%" align="center"><b> D.P.</b></td>
                  <td width="10%" align="center"><b> O/S as On&nbsp;<%=Helper.correctNull((String) hshValues
							.get("detailsasondate"))%></b></td>
                  <td width="12%" align="center"><b> Value of Securities </b></td>
                  <td width="19%" align="center"><b> Irregularities, if any</b></td>
                </tr>
                <tr> 
                  <td align="left" colspan="7"><b>A]FUND BASED LIMITS</b></td>
                </tr>
                <%String chkCategory = "", chkCategory1 = "";
			ArrayList OurBank_WC_Funded = new ArrayList();
			ArrayList WC_Funded = new ArrayList();

			int arrWC_Funded_Size = 0;

			OurBank_WC_Funded = (ArrayList) hshValues.get("OurBank_WC_Funded");

			if (OurBank_WC_Funded != null) {
				arrWC_Funded_Size = OurBank_WC_Funded.size();
			}

			for (int i = 0; i < arrWC_Funded_Size; i++) {
				WC_Funded = (ArrayList) OurBank_WC_Funded.get(i);

				if (Helper.correctNull((String) WC_Funded.get(12))
						.equalsIgnoreCase("A"))
					chkCategory = "<br> Adhoc Limit for "
							+ Helper.correctNull((String) WC_Funded.get(13))
							+ " Month";
				else
					chkCategory = "";

				%>
                <tr valign="top"> 
                  <td align="left">&nbsp;<%=Helper.correctNull((String) WC_Funded.get(0))%><%=chkCategory%></td>
                  <td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) WC_Funded.get(1))))%></td>
                  <td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) WC_Funded.get(2))))%></td>
                  <td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) WC_Funded.get(5))))%></td>
                  <td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) WC_Funded.get(6))))%></td>
                  <td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) WC_Funded.get(7))))%></td>
                  <td align="left" class="just">&nbsp;<%=Helper.correctNull((String) WC_Funded.get(8))%></td>
                </tr>
                <%//For the Sub-limits, under each one
				arrSubFac = new ArrayList();
				arrSubFac = (ArrayList) WC_Funded.get(9);
				int subFacSize = arrSubFac.size();
				if (arrSubFac != null && subFacSize > 0) {
					for (int j = 0; j < subFacSize; j++) {
						arrSubFacRecords = new ArrayList();
						arrSubFacRecords = (ArrayList) arrSubFac.get(j);

						if (Helper.correctNull(
								(String) arrSubFacRecords.get(11))
								.equalsIgnoreCase("A"))
							chkCategory = "<br> Adhoc Limit for "
									+ Helper
											.correctNull((String) arrSubFacRecords
													.get(12)) + " Month";
						else
							chkCategory = "";

						%>
                <%if (j == 0) {%>
                <tr> 
                  <td>&nbsp;<b>&gt;&gt;Sub-Limit</b></td>
                </tr>
                <%}%>
                <tr valign="top"> 
                  <td align="left">&nbsp;<%=Helper.correctNull((String) arrSubFacRecords
										.get(0))%><%=chkCategory%></td>
                  <td align="right">&nbsp;(<%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(1))))%>)</td>
                  <td align="right">&nbsp;(<%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(2))))%>)</td>
                  <td align="right">&nbsp;<%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(5))))%></td>
                  <td align="right">&nbsp;<%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(6))))%></td>
                  <td align="right">&nbsp;<%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(7))))%></td>
                  <td align="left" class="just">&nbsp;<%=Helper.correctNull((String) arrSubFacRecords
										.get(8))%></td>
                </tr>
                <%}
				}
				//End of 'Sub-Facilities' details               
			}

			%>
                <tr> 
                  <td align="right"><b>Sub-total [A]</b></td>
                  <td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("wc_funded_existing"))))%></td>
                  <td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("wc_funded_proposed"))))%></td>
                  <td align="center">&nbsp;</td>
                  <td align="center">&nbsp;</td>
                  <td align="center">&nbsp;</td>
                  <td align="center">&nbsp;</td>
                </tr>
                <tr> 
                  <td align="left" colspan="7"><b>B] NONFUND BASED LIMITS</b></td>
                </tr>
                <%ArrayList OurBank_WC_NonFunded = new ArrayList();
			ArrayList WC_NonFunded = new ArrayList();

			int arrWC_NonFunded_Size = 0;

			OurBank_WC_NonFunded = (ArrayList) hshValues
					.get("OurBank_WC_NonFunded");

			if (OurBank_WC_NonFunded != null) {
				arrWC_NonFunded_Size = OurBank_WC_NonFunded.size();
			}

			for (int i = 0; i < arrWC_NonFunded_Size; i++) {
				WC_NonFunded = (ArrayList) OurBank_WC_NonFunded.get(i);

				if (Helper.correctNull((String) WC_NonFunded.get(12))
						.equalsIgnoreCase("A"))
					chkCategory = "<br> Adhoc Limit for "
							+ Helper.correctNull((String) WC_NonFunded.get(13))
							+ " Month";
				else
					chkCategory = "";

				%>
                <tr valign="top"> 
                  <td align="left">&nbsp;<%=Helper.correctNull((String) WC_NonFunded
										.get(0))%><%=chkCategory%></td>
                  <td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) WC_NonFunded.get(1))))%></td>
                  <td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) WC_NonFunded.get(2))))%></td>
                  <td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) WC_NonFunded.get(5))))%></td>
                  <td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) WC_NonFunded.get(6))))%></td>
                  <td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) WC_NonFunded.get(7))))%></td>
                  <td align="left" class="just">&nbsp;<%=Helper.correctNull((String) WC_NonFunded
										.get(8))%></td>
                </tr>
                <%//For the Sub-limits, under each one
				arrSubFac = new ArrayList();
				arrSubFac = (ArrayList) WC_NonFunded.get(9);
				int subFacSize = arrSubFac.size();
				if (arrSubFac != null && subFacSize > 0) {
					for (int j = 0; j < subFacSize; j++) {
						arrSubFacRecords = new ArrayList();
						arrSubFacRecords = (ArrayList) arrSubFac.get(j);

						if (Helper.correctNull(
								(String) arrSubFacRecords.get(11))
								.equalsIgnoreCase("A"))
							chkCategory = "<br> Adhoc Limit for "
									+ Helper
											.correctNull((String) arrSubFacRecords
													.get(12)) + " Month";
						else
							chkCategory = "";

						%>
                <%if (j == 0) {%>
                <tr> 
                  <td>&nbsp;<b>&gt;&gt;Sub-Limit</b></td>
                </tr>
                <%}%>
                <tr valign="top"> 
                  <td align="left">&nbsp;<%=Helper.correctNull((String) arrSubFacRecords
										.get(0))%><%=chkCategory%></td>
                  <td align="right">&nbsp;(<%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(1))))%>)</td>
                  <td align="right">&nbsp;(<%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(2))))%>)</td>
                  <td align="right">&nbsp;<%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(5))))%></td>
                  <td align="right">&nbsp;<%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(6))))%></td>
                  <td align="right">&nbsp;<%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(7))))%></td>
                  <td align="left" class="just">&nbsp;<%=Helper.correctNull((String) arrSubFacRecords
										.get(8))%></td>
                </tr>
                <%}
				}
				//End of 'Sub-Facilities' details               
			}

			%>
                <tr> 
                  <td align="right"><b>Sub-total [B]</b></td>
                  <td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("wc_nonfunded_existing"))))%></td>
                  <td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("wc_nonfunded_proposed"))))%></td>
                  <td align="center">&nbsp;</td>
                  <td align="center">&nbsp;</td>
                  <td align="center">&nbsp;</td>
                  <td align="center">&nbsp;</td>
                </tr>
                <tr> 
                  <td align="left" colspan="7"><b>C] TERM LOAN</b></td>
                </tr>
                <%ArrayList OurBank_TL = new ArrayList();
			ArrayList TL_Funded_NonFunded = new ArrayList();

			int arrTL_Funded_NonFunded_Size = 0;

			OurBank_TL = (ArrayList) hshValues.get("OurBank_TL");

			if (OurBank_TL != null) {
				arrTL_Funded_NonFunded_Size = OurBank_TL.size();
			}

			for (int i = 0; i < arrTL_Funded_NonFunded_Size; i++) {
				TL_Funded_NonFunded = (ArrayList) OurBank_TL.get(i);

				if (Helper.correctNull((String) TL_Funded_NonFunded.get(12))
						.equalsIgnoreCase("A"))
					chkCategory = "<br> Adhoc Limit for "
							+ Helper.correctNull((String) TL_Funded_NonFunded
									.get(13)) + " Month";
				else
					chkCategory = "";

				%>
                <tr valign="top"> 
                  <td align="left">&nbsp;<%=Helper.correctNull((String) TL_Funded_NonFunded
								.get(0))%><%=chkCategory%></td>
                  <td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) TL_Funded_NonFunded
										.get(1))))%></td>
                  <td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) TL_Funded_NonFunded
										.get(2))))%></td>
                  <td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) TL_Funded_NonFunded
										.get(5))))%></td>
                  <td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) TL_Funded_NonFunded
										.get(6))))%></td>
                  <td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) TL_Funded_NonFunded
										.get(7))))%></td>
                  <td align="left" class="just">&nbsp;<%=Helper.correctNull((String) TL_Funded_NonFunded
								.get(8))%></td>
                </tr>
                <%//For the Sub-limits, under each one
				arrSubFac = new ArrayList();
				arrSubFac = (ArrayList) TL_Funded_NonFunded.get(9);
				int subFacSize = arrSubFac.size();
				if (arrSubFac != null && subFacSize > 0) {
					for (int j = 0; j < subFacSize; j++) {
						arrSubFacRecords = new ArrayList();
						arrSubFacRecords = (ArrayList) arrSubFac.get(j);
						if (Helper.correctNull(
								(String) arrSubFacRecords.get(11))
								.equalsIgnoreCase("A"))
							chkCategory = "<br> Adhoc Limit for "
									+ Helper
											.correctNull((String) arrSubFacRecords
													.get(12)) + " Month";
						else
							chkCategory = "";

						%>
                <%if (j == 0) {%>
                <tr> 
                  <td>&nbsp;<b>&gt;&gt;Sub-Limit</b></td>
                </tr>
                <%}%>
                <tr valign="top"> 
                  <td align="left">&nbsp;<%=Helper.correctNull((String) arrSubFacRecords
										.get(0))%><%=chkCategory%></td>
                  <td align="right">&nbsp;(<%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(1))))%>)</td>
                  <td align="right">&nbsp;(<%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(2))))%>)</td>
                  <td align="right">&nbsp;<%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(5))))%></td>
                  <td align="right">&nbsp;<%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(6))))%></td>
                  <td align="right">&nbsp;<%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(7))))%></td>
                  <td align="left" class="just">&nbsp;<%=Helper.correctNull((String) arrSubFacRecords
										.get(8))%></td>
                </tr>
                <%}
				}
				//End of 'Sub-Facilities' details               
			}

			%>
                <tr> 
                  <td align="right"><b>Sub-total [C]</b></td>
                  <td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("tl_total_existing"))))%></td>
                  <td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("tl_total_proposed"))))%></td>
                  <td align="center">&nbsp;</td>
                  <td align="center">&nbsp;</td>
                  <td align="center">&nbsp;</td>
                  <td align="center">&nbsp;</td>
                </tr>
                <tr> 
                  <td align="center"><b>TOTAL [A+B+C]</b></td>
                  <td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("total_existing"))))%></td>
                  <td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("total_proposed"))))%></td>
                  <td align="center">&nbsp;</td>
                  <td align="center">&nbsp;</td>
                  <td align="center">&nbsp;</td>
                  <td align="center">&nbsp;</td>
                </tr>
              </table>
            </div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td valign="top" width="3%">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" width="3%"><b>&nbsp;</b></td>
          <td valign="top" width="2%"><b>b)</b></td>
          <td valign="top" width="95%"><b>DETAILS OF EXCESS ALLOWED DURING THE 
            YEAR </b></td>
        </tr>
        <tr> 
          <td valign="top" colspan="3"> 
            <div id="top"> 
              <table width="50%" border="0" cellspacing="0" cellpadding="3">
                <tr> 
                  <td align="right" colspan="2"><b>(Rs In <%=strProposalvalue%>)</b></td>
                </tr>
                <tr> 
                  <td width="50%" align="center"><b>No. of occasions excesses 
                    allowed</b></td>
                  <td width="50%" align="center"><b> Maximum Excess Allowed</b></td>
                </tr>
                <tr> 
                  <td align="left"><%=Helper.correctNull((String) hshValues
							.get("EXEC_NOEXCESS"))%>&nbsp;</td>
                  <td align="left"><%=Helper.correctNull((String) hshValues
							.get("EXEC_MAXEXCESS"))%>&nbsp;</td>
                </tr>
              </table>
            </div>
          </td>
        </tr>
        <tr> 
          <td width="3%">&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td valign="top" colspan="2">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" width="3%"><b>19.</b></td>
          <td valign="top" width="3%" align="right"><b>a)</b></td>
          <td><b> EXPOSURE DETAILS FROM BANKING SYSTEM </b></td>
        </tr>
        <tr> 
          <td align="right" colspan="3"><b>(<%=ApplicationParams.getCurrency()%> 
            In <%=strProposalvalue%>)</b></td>
        </tr>
        <tr> 
          <td colspan="5" valign="top"> 
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3">
                <tr class="tblhead"> 
                  <td width="25%" rowspan="2" align="center"><b>Name of the Bank</b></td>
                  <td colspan="2" align="center"><b>Non-Fund Based</b></td>
                  <td colspan="2" align="center"><b>Fund Based</b></td>
                  <%-- %> <td width="16%" rowspan="2" align="center"><b>Term Loan</b></td>--%>
                  <td width="25%" rowspan="2" align="center"><b>Conduct of the 
                    Account</b></td>
                </tr>
                <tr class="tblhead"> 
                  <td width="12%" align="center"><b>%Share</b></td>
                  <td width="13%" align="center"><b>Amt.</b></td>
                  <td width="12%" align="center"><b>%Share </b></td>
                  <td width="13%" align="center"><b>Amt.</b></td>
                </tr>
                <%
              	 	ArrayList arrBankArrangement=(ArrayList)hshValues.get("arrBankArrangement");
               	  if(arrBankArrangement!=null && arrBankArrangement.size()!=0)
               	  {%>
                <tr>
                  <td colspan="6">Under Consortium</td>
                </tr>
                <% for(int i=0;i<arrBankArrangement.size();i++)
	                  {
	                	  arr3= new ArrayList();
	                	  arr3=(ArrayList)arrBankArrangement.get(i); 
	                    %>
                <tr> 
                  <td width="25%"><%=arr3.get(0)%>&nbsp;</td>
                  <td width="12%" valign="top" align="right">&nbsp;<%=Helper.correctNull((String)arr3.get(1))%></td>
                  <td width="13%" valign="top" align="right">&nbsp;<%=Helper.correctNull((String)arr3.get(2))%></td>
                  <td width="12%" valign="top" align="right">&nbsp;<%=Helper.correctNull((String)arr3.get(3))%></td>
                  <td width="13%" valign="top" align="right">&nbsp;<%=Helper.correctNull((String)arr3.get(4))%></td>
                  <td width="25%" align="left"><%=Helper.correctNull((String)arr3.get(5))%>&nbsp;</td>
                </tr>
                <%
	                  }
               	  }
               	  
               	  %>
                <%
              	 	arrBankArrangement=(ArrayList)hshValues.get("arrNonBankArrange");
               	  if(arrBankArrangement!=null && arrBankArrangement.size()!=0)
               	  {%>
                <tr>
                  <td colspan="6">Under Non Consortium</td>
                </tr>
                <% for(int i=0;i<arrBankArrangement.size();i++)
	                  {
	                	  arr3= new ArrayList();
	                	  arr3=(ArrayList)arrBankArrangement.get(i); 
	                    %>
                <tr> 
                  <td width="25%"><%=arr3.get(0)%>&nbsp;</td>
                  <td width="12%" valign="top" align="right">&nbsp;<%=Helper.correctNull((String)arr3.get(1))%></td>
                  <td width="13%" valign="top" align="right">&nbsp;<%=Helper.correctNull((String)arr3.get(2))%></td>
                  <td width="12%" valign="top" align="right">&nbsp;<%=Helper.correctNull((String)arr3.get(3))%></td>
                  <td width="13%" valign="top" align="right">&nbsp;<%=Helper.correctNull((String)arr3.get(4))%></td>
                  <td width="25%" align="left"><%=Helper.correctNull((String)arr3.get(5))%>&nbsp;</td>
                </tr>
                <%
	                  }
               	  }
               	  
               	  %>
              </table>
            </div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="6%">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" width="6%" align="right"><b>b)</b></td>
          <td valign="top" colspan="2"><b> EXPOSURE DETAILS FROM FINANCIAL INSTITUTIONS 
            :</b></td>
        </tr>
        <%arrBankArrangement = (ArrayList) hshValues
					.get("arrBankArrangementFI");
			if (arrBankArrangement != null && arrBankArrangement.size() != 0) {%>
        <tr> 
          <td valign="top" width="6%">&nbsp;</td>
          <td align="right"><b>(<%=ApplicationParams.getCurrency()%> in <%=strProposalvalue%>)</b></td>
          <td align="right" width="10%">&nbsp;</td>
        </tr>
        <tr> 
          <td colspan="2"> 
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3">
                <tr class="tblhead"> 
                  <td width="31%" align="center" rowspan="2"><b>Name of the Bank</b></td>
                  <td align="center" colspan="2"><b>Amount</b></td>
                  <td align="center" width="16%" rowspan="2"><b>Remarks</b></td>
                  <td align="center" width="15%" rowspan="2"><b>Over Due if any.</b></td>
                </tr>
                <tr class="tblhead"> 
                  <td width="14%"><b>Fund Based</b></td>
                  <td width="20%"><b>Non-Fund Based</b></td>
                </tr>
                <%
	      	for(int i=0;i<arrBankArrangement.size();i++)
	        {
	        	arr3= new ArrayList();
	            arr3=(ArrayList)arrBankArrangement.get(i); 
	       %>
                <tr> 
                  <td width="31%" valign="top"><%=arr3.get(0)%>&nbsp;</td>
                  <td width="14%" valign="top" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arr3.get(1))))%></td>
                  <td width="20%" valign="top" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arr3.get(2))))%></td>
                  <td width="16%" valign="top" ><%=Helper.formatTextAreaData((String)arr3.get(3))%></td>
                  <td width="15%" valign="top"><%=Helper.formatTextAreaData((String)arr3.get(4))%></td>
                </tr>
                <%
	        }%>
              </table>
            </div>
          </td>
        </tr>
        <%}
	       %>
      </table>
    </td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="6%">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" width="6%" align="right"><b>&nbsp;c)</b></td>
          <td width="94%"><b> VALUE OF ACCOUNT</b></td>
        </tr>
        <tr> 
          <td align="right" colspan="2"><b>(<%=ApplicationParams.getCurrency()%> 
            In <%=strProposalvalue%>)</b></td>
        </tr>
        <tr> 
          <td valign="top" colspan="2"> 
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3">
                <tr class="tblhead"> 
                  <td width="29%" valign="top">Advances:</td>
                  <td width="32%" valign="top" align="center" colspan="2">Previous 
                    Year<br>
                    From:<%=Helper.correctNull((String) hshValues.get("EXEC_PFROM"))%> 
                    &nbsp;&nbsp;&nbsp;&nbsp;To:<%=Helper.correctNull((String) hshValues.get("EXEC_PTO"))%></td>
                  <td width="39%" valign="top" align="center" colspan="2">Current 
                    Year<br>
                    From:<%=Helper.correctNull((String) hshValues.get("EXEC_CFROM"))
							.equals("") ? "__/__/____" : Helper
					.correctNull((String) hshValues.get("EXEC_CFROM"))%> &nbsp;&nbsp;&nbsp;&nbsp;To:<%=Helper.correctNull((String) hshValues.get("EXEC_CTO"))
							.equals("") ? "__/__/____" : Helper
					.correctNull((String) hshValues.get("EXEC_CTO"))%></td>
                </tr>
                <tr> 
                  <td width="29%" valign="top">- Interest Income</td>
                  <td width="32%" valign="top" align="right" colspan="2">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("EXEC_PINTINC"))))%></td>
                  <td width="39%" valign="top" align="right" colspan="2">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("EXEC_CINTINC"))))%></td>
                </tr>
                <tr> 
                  <td width="29%" valign="top">-Feebased Income</td>
                  <td width="32%" valign="top" align="right" colspan="2">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("EXEC_PFEEINC"))))%></td>
                  <td width="39%" valign="top" align="right" colspan="2">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("EXEC_CFEEINC"))))%></td>
                </tr>
                <tr> 
                  <td rowspan="2" valign="top">Retail / Consumer / Finance (to 
                    employees associates)</td>
                  <td width="16%" align="center" valign="top">No.of Accounts</td>
                  <td width="16%" align="center" valign="top">Amount</td>
                  <td width="19%" align="center" valign="top">No.of Accounts</td>
                  <td width="20%" align="center" valign="top">Amount</td>
                </tr>
                <tr> 
                  <td width="16%" valign="top" align="right">&nbsp;<%=Helper.correctNull((String) hshValues
									.get("EXEC_PNOACS"))%></td>
                  <td width="16%" valign="top" align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("EXEC_PRETAILAMT"))))%></td>
                  <td width="19%" valign="top" align="right"><%=Helper.correctNull((String) hshValues
									.get("EXEC_CNOACS"))%>&nbsp;</td>
                  <td width="20%" valign="top" align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("EXEC_CRETAILAMT"))))%></td>
                </tr>
                <tr> 
                  <td rowspan="3" valign="top"> 
                    <p>Deposit</p>
                    <p>-Own -</p>
                    <p>Third Party</p>
                  </td>
                  <td width="16%" align="center" valign="top">Amount</td>
                  <td width="16%" align="center" valign="top">Tenor &amp; due 
                    date</td>
                  <td width="19%" align="center" valign="top">Amount</td>
                  <td width="20%" align="center" valign="top">Tenor &amp; due 
                    date</td>
                </tr>
                <tr> 
                  <td width="16%" height="35" valign="top" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("EXEC_POWNAMT"))))%></td>
                  <td width="16%" height="35" valign="top" align="center">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("EXEC_POWNTENORDATE"))%></td>
                  <td width="19%" height="35" valign="top" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("EXEC_COWNAMT"))))%></td>
                  <td width="20%" height="35" valign="top" align="center">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("EXEC_COWNTENORDATE"))%></td>
                </tr>
                <tr> 
                  <td width="16%" height="43" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("EXEC_PTHIRDAMT"))))%></td>
                  <td width="16%" height="43" align="center">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("EXEC_PTHIRDTENORDATE"))%></td>
                  <td width="19%" height="43" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("EXEC_CTHIRDAMT"))))%></td>
                  <td width="20%" height="43" align="center">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("EXEC_CTHIRDTENORDATE"))%></td>
                </tr>
              </table>
            </div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td valign="top">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" width="3%"><b>20.&nbsp;a)</b></td>
          <td valign="top"><b>OPERATIONAL EXPERIENCE WITH REGARD TO SISTER / ALLIED 
            CONCERNS</b></td>
        </tr>
        <tr> 
          <td valign="top" colspan="2" align="right"><b>(Rs In <%=strProposalvalue%>)</b></td>
        </tr>
        <tr> 
          <td valign="top" colspan="2"> 
            <div id="top"> 
              <table border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td width="15%" rowspan="2" align="center">Name<br>
                    of the <br>
                    Concern</td>
                  <td rowspan="2" width="15%" align="center">Branch</td>
                  <td rowspan="2" width="10%" align="center">CoA</td>
                  <td colspan="2" align="center">Contin-gent</td>
                  <td colspan="3" align="center">FBWC</td>
                  <td colspan="2" align="center">Term Loan</td>
                  <td width="5%" rowspan="2" align="center">Investment</td>
                  <td width="5%" rowspan="2" align="center">MOR</td>
                  <td width="5%" rowspan="2" align="center">Irregularity,<br>
                    if any</td>
                </tr>
                <tr> 
                  <td width="5%">Limit</td>
                  <td width="5%">O/s</td>
                  <td width="5%">Limit</td>
                  <td width="5%">DP</td>
                  <td width="5%">O/s</td>
                  <td width="5%">Limit</td>
                  <td width="5%">O/s</td>
                </tr>
                <%if (operinfo != null && operinfo.size() > 0) {
				for (int j = 0; j < operinfo.size(); j++) {

					arryCol_grpcon = (ArrayList) operinfo.get(j);

					%>
                <tr> 
                  <td width="15%" align="left"><font size="1">&nbsp;<%=Helper.correctNull((String) arryCol_grpcon
									.get(13))%></font></td>
                  <td width="15%" align="left"><font size="1">&nbsp;<%=Helper
											.correctNull((String) arryCol_grpcon
													.get(1))%></font></td>
                  <td width="10%" align="left"><font size="1">&nbsp;<%=Helper
											.correctNull((String) arryCol_grpcon
													.get(2))%></font></td>
                  <td width="5%" align="right"><font size="1">&nbsp;<%=Helper
											.formatDoubleValue(Double
													.parseDouble(Helper
															.correctDouble((String) arryCol_grpcon
																	.get(3))))%></font></td>
                  <td width="5%" align="right"><font size="1">&nbsp;<%=Helper
											.formatDoubleValue(Double
													.parseDouble(Helper
															.correctDouble((String) arryCol_grpcon
																	.get(4))))%></font></td>
                  <td width="5%" align="right"><font size="1">&nbsp;<%=Helper
											.formatDoubleValue(Double
													.parseDouble(Helper
															.correctDouble((String) arryCol_grpcon
																	.get(5))))%></font></td>
                  <td width="5%" align="right"><font size="1">&nbsp;<%=Helper
											.formatDoubleValue(Double
													.parseDouble(Helper
															.correctDouble((String) arryCol_grpcon
																	.get(6))))%></font></td>
                  <td width="5%" align="right"><font size="1">&nbsp;<%=Helper
											.formatDoubleValue(Double
													.parseDouble(Helper
															.correctDouble((String) arryCol_grpcon
																	.get(7))))%></font></td>
                  <td width="5%" align="right"><font size="1">&nbsp;<%=Helper
											.formatDoubleValue(Double
													.parseDouble(Helper
															.correctDouble((String) arryCol_grpcon
																	.get(8))))%></font></td>
                  <td width="5%" align="right"><font size="1">&nbsp;<%=Helper
											.formatDoubleValue(Double
													.parseDouble(Helper
															.correctDouble((String) arryCol_grpcon
																	.get(9))))%></font></td>
                  <td width="5%" align="right"><font size="1">&nbsp;<%=Helper
											.formatDoubleValue(Double
													.parseDouble(Helper
															.correctDouble((String) arryCol_grpcon
																	.get(10))))%></font></td>
                  <td width="10%" align="left"><font size="1">&nbsp;<%=Helper.correctNull((String) arryCol_grpcon
									.get(11))%></font></td>
                  <td width="10%" align="left"><font size="1">&nbsp;<%=Helper.correctNull((String) arryCol_grpcon
									.get(12))%></font></td>
                </tr>
                <%}
			} else {

			%>
                <tr> 
                  <td width="15%">&nbsp;</td>
                  <td width="15%">&nbsp;</td>
                  <td width="10%">&nbsp;</td>
                  <td width="5%">&nbsp;</td>
                  <td width="5%">&nbsp;</td>
                  <td width="5%">&nbsp;</td>
                  <td width="5%">&nbsp;</td>
                  <td width="5%">&nbsp;</td>
                  <td width="5%">&nbsp;</td>
                  <td width="5%">&nbsp;</td>
                  <td width="5%">&nbsp;</td>
                  <td width="10%">&nbsp;</td>
                  <td width="10%">&nbsp;</td>
                </tr>
                <%}

			if (operinfo != null && operinfo.size() != 0) {

				%>
                <tr> 
                  <td width="15%"><b>Total Exposure</b></td>
                  <td width="15%">&nbsp;</td>
                  <td width="10%">&nbsp;</td>
                  <td width="5%" align="right"><font size="1"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hshValues
										.get("EXEC_GCCOMLIMIT"))))%></font></td>
                  <td width="5%" align="right"><font size="1"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hshValues
										.get("EXEC_GCCOMOS"))))%></font></td>
                  <td width="5%" align="right"><font size="1"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hshValues
										.get("EXEC_GCFBWCLT"))))%></font></td>
                  <td width="5%" align="right"><font size="1"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hshValues
										.get("EXEC_GCFBWCDP"))))%></font></td>
                  <td width="5%" align="right"><font size="1"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hshValues
										.get("EXEC_GCFBWCOS"))))%></font></td>
                  <td width="5%" align="right"><font size="1"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hshValues
										.get("EXEC_GCTLLT"))))%></font></td>
                  <td width="5%" align="right"><font size="1"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hshValues
										.get("EXEC_GCTLOS"))))%></font></td>
                  <td width="5%" align="right"><font size="1"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hshValues
										.get("EXEC_GCINS"))))%></font></td>
                  <td width="10%">&nbsp;</td>
                  <td width="10%">&nbsp;</td>
                </tr>
                <%}

			%>
              </table>
            </div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td width="3%" valign="top" align="right"><b>&nbsp;b)</b></td>
          <td width="41%" valign="top"><b>COMMENTS ON OTHER BANK'S CREDIT REPORT 
            ON SISTER CONCERNS</b></td>
          <td width="3%" valign="top"><b>:</b></td>
          <%String exec_comments = Helper.formatTextAreaData((String) hshValues
					.get("exec_comments"));
			if (exec_comments.trim().equals("")
					|| exec_comments.equalsIgnoreCase("<P>&nbsp;</P>")) {%>
          <td valign="top" width="8%">Nil &nbsp;</td>
          <%} else {%>
          <td valign="top" width="37%">&nbsp;</td>
        </tr>
        <tr> 
          <td width="3%" valign="top">&nbsp;</td>
          <td valign="top" width="52%" colspan="3"><%=exec_comments%></td>
          <%}%>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td width="3%" valign="top"><b>21.&nbsp;</b></td>
          <td width="41%" valign="top"><b>PRUDENTIAL EXPOSURE NORMS [inclusive 
            of Bank's exposure in the form of investments like shares, debentures, 
            CP, etc.]</b></td>
          <td width="3%" valign="top"><b><b>:</b></b></td>
          <td valign="top">&nbsp;</td>
        </tr>
        <tr> 
          <td width="3%" valign="top">&nbsp;</td>
          <td colspan="3"> 
            <div id="top"> 
              <table width="50%" border="0">
                <tr> 
                  <td>Constitution</td>
                  <td>Prudential Limit in <b>(<%=ApplicationParams.getCurrency()%> 
                    in <%=strProposalvalue%>)</b></td>
                </tr>
                <tr> 
                  <td><%=Helper.correctNull((String) hshValues
									.get("strownership"))%></td>
                  <td align="right"><%=Helper
							.formatDoubleValue(Double.parseDouble(Helper
									.correctDouble((String) hshValues
											.get("maxlimit"))))%></td>
                </tr>
              </table>
            </div>
          </td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td width="3%" valign="top">&nbsp;</td>
          <td colspan="3"> 
            <div id="top"> 
              <table width="75%" border="0">
                <tr> 
                  <td>Category</td>
                  <td>Ceiling as % to Bank's Capital Funds</td>
                  <td>Amount based on Capital Funds <b>(<%=ApplicationParams.getCurrency()%> 
                    in <%=strProposalvalue%>)</b></td>
                </tr>
                <tr> 
                  <td><%=Helper.correctNull((String) hshValues.get("label"))%></td>
                  <td><%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("capital_funds"))))%></td>
                  <td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("capital_amt"))))%></td>
                </tr>
              </table>
            </div>
          </td>
        </tr>
        <tr> 
          <td width="3%" valign="top">&nbsp;</td>
          <td colspan="4" valign="top" class="just"><%=Helper.formatTextAreaData((String) hshValues
							.get("exposure_norms"))%></td>
        </tr>
        <tr> 
          <td colspan="2" valign="top">&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr> 
          <td width="2%" valign="top"><b>22.&nbsp;</b></td>
          <td valign="top" width="31%"><b>JUSTIFICATION /REASONS FOR SEEKING EXTENSION/SHORT 
            REVIEW :</b></td>
          <%String sre_comments = Helper.correctEditor((String) hshValues
					.get("comsre_comments"));
			if (sre_comments.trim().equals("")
					|| sre_comments.equalsIgnoreCase("<P>&nbsp;</P>")) {%>
          <td valign="top" width="26%">Nil &nbsp;</td>
          <%} else {%>
          <td valign="top" width="41%">&nbsp;</td>
        </tr>
        <tr> 
          <td width="2%" valign="top"><b>&nbsp;</b></td>
          <td valign="top" width="31%" colspan="3"><%=sre_comments%></td>
          <%}%>
        </tr>
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="2%" valign="top"><b>23.&nbsp;</b></td>
          <td valign="top" width="20%"><b>ANY OTHER MATTERS :</b></td>
          <%String other_matters = Helper.correctEditor((String) hshValues
					.get("other_matters"));
			if (other_matters.trim().equals("")
					|| other_matters.equalsIgnoreCase("<P>&nbsp;</P>")) {%>
          <td valign="top" width="71%">Nil &nbsp;</td>
          <%} else {%>
          <td valign="top" width="7%">&nbsp;</td>
        </tr>
        <tr> 
          <td width="2%" valign="top"><b>&nbsp;</b></td>
          <td valign="top" colspan="2"><%=other_matters%></td>
          <%}%>
        </tr>
        <tr> 
          <td colspan="4">&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="2%" valign="top"><b>23.1&nbsp;</b></td>
          <td valign="top" colspan="3"><b>Justification for continuation of concession, 
            if any:</b></td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
          <td colspan="3"> 
            <div id="top"> 
              <table width="100%" border="0">
                <tr align="center"> 
                  <td><b>&nbsp;</b></td>
                  <td><b>Details</b></td>
                  <td><b>Justification</b></td>
                </tr>
                <%String strmatter = "";
			String strmatterdesc = "";
			int rowspan = 0;
			arrRow = new ArrayList();
			arrData = new ArrayList();
			arrRow = (ArrayList) hshValues.get("ConcessarrRow");
			int ratesize = 0;
			if (arrRow != null && arrRow.size() > 0) {
				ratesize = arrRow.size();
				for (int i = 0; i < ratesize; i++) {
					arrData = (ArrayList) arrRow.get(i);
					strmatterdesc = Helper.correctNull((String) arrData.get(1));
					if (strmatterdesc.equalsIgnoreCase("S")) {
						strmatterdesc = "";
					} else if (strmatterdesc.equalsIgnoreCase("1")) {
						strmatterdesc = "Rate of Interest";
					} else if (strmatterdesc.equalsIgnoreCase("2")) {
						strmatterdesc = "Commission on LG/LC";
					} else if (strmatterdesc.equalsIgnoreCase("3")) {
						strmatterdesc = "Processing Charges";
					} else if (strmatterdesc.equalsIgnoreCase("4")) {
						strmatterdesc = "Others (Specify)";
					}

					%>
                <tr valign="top"> 
                  <%if (!strmatter.equalsIgnoreCase(Helper
							.correctNull((String) arrData.get(1)))) {
						strmatter = Helper.correctNull((String) arrData.get(1));

						int introwspan = Integer.parseInt(Helper
								.correctInt((String) hshValues.get(strmatter
										+ "size")));

						%>
                  <td rowspan="<%=introwspan%>"><%=strmatterdesc%></td>
                  <td><%=Helper.formatTextAreaData((String) arrData
										.get(2))%></td>
                  <td><%=Helper.formatTextAreaData((String) arrData
										.get(3))%></td>
                  <%} else {

						%>
                  <td><%=Helper.formatTextAreaData((String) arrData
										.get(2))%></td>
                  <td><%=Helper.formatTextAreaData((String) arrData
										.get(3))%></td>
                  <%}%>
                </tr>
                <%}
			}%>
              </table>
            </div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td colspan="2" valign="top">&nbsp;</td>
        </tr>
        <tr> 
          <td width="3%" valign="top"><b>24.&nbsp;</b></td>
          <td width="97%" valign="top"><b>INTERAL CREDIT RATING :</b></td>
        </tr>
        <tr> 
          <td valign="top" width="3%"><b>a)</b></td>
          <td valign="top" width="97%"> 
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3">
                <tr> 
                  <td width="42%" align="center"><b>Year</b></td>
                  <td align="center">Previous Year&nbsp;</td>
                  <td align="center">Current Year&nbsp;</td>
                </tr>
                <tr align="center"> 
                  <td align="left">Total score obtained</td>
                  <td><%=strprevious[0]%></td>
                  <td><%=strcurrent[0]%></td>
                </tr>
                <tr align="center"> 
                  <td align="left">Grade</td>
                  <td><%=strprevious[1]%></td>
                  <td><%=strcurrent[1]%></td>
                </tr>
              </table>
            </div>
          </td>
        </tr>
        <tr> 
          <td colspan="2">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" width="3%"><b>b)</b></td>
          <td valign="top" width="97%"> 
            <div id="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3">
                <tr> 
                  <td width="42%" align="center"><b>Parameters</b></td>
                  <td align="center" colspan="2"><b>Marks obtained</b></td>
                </tr>
                <%--<tr> 
                  <td width="42%">&nbsp;</td>
                  <td width="29%" align="center"><b></b> </td>
                  <td width="29%" align="center"><b></b> </td>
                </tr>--%>
                <tr align="center"> 
                  <td align="left">Borrower rating</td>
                  <td><%=strprevious[3]%></td>
                  <td><%=strcurrent[3]%></td>
                </tr>
                <tr align="center"> 
                  <td align="left">Facility rating</td>
                  <td><%=strprevious[4]%></td>
                  <td><%=strcurrent[4]%></td>
                </tr>
                <tr align="center"> 
                  <td align="left">Cash flow related parameters</td>
                  <td><%=strprevious[5]%></td>
                  <td><%=strcurrent[5]%></td>
                </tr>
                <tr align="center"> 
                  <td align="left">Business aspects</td>
                  <td><%=strprevious[6]%></td>
                  <td><%=strcurrent[6]%></td>
                </tr>
                <tr align="center"> 
                  <td align="left">Total Marks with grade</td>
                  <td><%=strprevious[7]%></td>
                  <td><%=strcurrent[7]%></td>
                </tr>
              </table>
            </div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td valign="top" width="3%"><b>c)</b></td>
    <td valign="top" width="35%"><b>Reason for Migration, if any.</b></td>
    <td valign="top" width="1%"><b><b>:</b></b></td>
    <%String mig_remarks = Helper.formatTextAreaData(
					(String) hshValues.get("mig_remarks")).trim();
			if (mig_remarks.trim().equals("")
					|| mig_remarks.equalsIgnoreCase("<P>&nbsp;</P>")) {%>
    <td valign="top" width="8%">Nil</td>
    <%} else {%>
    <td valign="top" width="53%">&nbsp;</td>
  </tr>
  <tr> 
    <td valign="top" width="3%"><b>&nbsp;</b></td>
    <td class="just" colspan="3"><%=Helper.formatTextAreaData(
								(String) hshValues.get("mig_remarks")).trim()%></td>
    <%}%>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr> 
          <td valign="top" width="4%"><b>25.&nbsp;</b></td>
          <td valign="top" width="34%"><b>EXTERNAL CREDIT RATING </b></td>
          <td valign="top" align="center" width="1%"><b><b>:</b></b></td>
          <%String extrating = Helper.formatTextAreaData(
					(String) hshValues.get("extrating")).trim();
			if (extrating.trim().equals("")
					|| extrating.equalsIgnoreCase("<P>&nbsp;</P>")) {%>
          <td valign="top" width="8%">Nil &nbsp;</td>
          <%} else {%>
          <td valign="top" width="53%">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" width="4%"><b>&nbsp;</b></td>
          <td class="just" colspan="3"><%=Helper.formatTextAreaData(
								(String) hshValues.get("extrating")).trim()%></td>
          <%}%>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr> 
          <td valign="top" width="4%"><b>26.&nbsp;</b></td>
          <td valign="top" width="34%"><b>Delegated Authority</b></td>
          <td valign="top" align="center" width="1%"><b><b>:</b></b></td>
          <%String exec_delegated = Helper.formatTextAreaData(
					(String) hshValues.get("exec_delegated")).trim();
			if (exec_delegated.trim().equals("")
					|| exec_delegated.equalsIgnoreCase("<P>&nbsp;</P>")) {%>
          <td valign="top" width="8%">Nil</td>
          <%} else {%>
          <td valign="top" width="53%">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" width="4%"><b>&nbsp;</b></td>
          <td class="just" colspan="3"><%=Helper.formatTextAreaData(
								(String) hshValues.get("exec_delegated"))
								.trim()%></td>
          <%}%>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td valign="top" colspan="5">&nbsp;</td>
  </tr>
  <tr> 
    <td valign="top" width="3%"><b>27.&nbsp;</b></td>
    <td valign="top" colspan="4" width="97%"><b>RECOMMENDATIONS</b></td>
  </tr>
  <tr> 
    <td valign="top" width="3%">&nbsp;</td>
    <td valign="top" colspan="4" width="97%">&nbsp;</td>
  </tr>
  <tr> 
    <td valign="top" align="right" colspan="5"><b>(<%=ApplicationParams.getCurrency()%> 
      In <%=strProposalvalue%>)</b></td>
  </tr>
  <tr> 
    <td valign="top" rowspan="4" width="3%">&nbsp;</td>
    <td valign="top" colspan="4" width="97%"> 
      <div id="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="3">
          <tr class="tblhead"> 
            <td rowspan="2" width="27%"> 
              <div align="center">Nature of Limit</div>
            </td>
            <td colspan="2"> 
              <div align="center">Amount</div>
            </td>
            <td rowspan="2" width="8%"> 
              <div align="center">Margin (%)</div>
            </td>
            <td rowspan="2" width="8%"> 
              <div align="center">Int./ Comm.</div>
            </td>
            <td rowspan="2" width="31%"> 
              <div align="center">Security</div>
            </td>
          </tr>
          <tr class="tblhead"> 
            <td width="13%" align="center">Existing</td>
            <td width="13%" align="center">Proposed</td>
          </tr>
          <tr> 
            <td colspan="6"><b>A] NON-FUND BASED LIMITS</b></td>
          </tr>
          <%OurBank_WC_NonFunded = new ArrayList();
			WC_NonFunded = new ArrayList();

			arrWC_NonFunded_Size = 0;

			OurBank_WC_NonFunded = (ArrayList) hshValues
					.get("OurBank_WC_NonFunded");

			if (OurBank_WC_NonFunded != null) {
				arrWC_NonFunded_Size = OurBank_WC_NonFunded.size();
			}

			for (int i = 0; i < arrWC_NonFunded_Size; i++) {
				WC_NonFunded = (ArrayList) OurBank_WC_NonFunded.get(i);

				chkCategory = Helper.correctNull((String) WC_NonFunded.get(12));
				if (chkCategory.equals("A")) {
					chkCategory1 = "<br>(Adhoc Limit for "
							+ Helper.correctNull((String) WC_NonFunded.get(13))
							+ " Month ) ";
				} else {
					chkCategory1 = "";
				}
				int introwspan = Integer.parseInt(Helper
						.correctInt((String) WC_NonFunded.get(16)));

				%>
          <tr> 
            <td width="27%" align="left" valign="top"
							rowspan="<%=introwspan%>">&nbsp;<b><%=Helper.correctNull((String) WC_NonFunded
										.get(0))%> <%=chkCategory1%></b></td>
            <td width="13%" align="right" valign="top"
							rowspan="<%=introwspan%>">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) WC_NonFunded.get(1))))%></td>
            <td width="13%" align="right" valign="top"
							rowspan="<%=introwspan%>">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) WC_NonFunded.get(2))))%></td>
            <%ArrayList arrSecurities = new ArrayList();
				arrSecurities = (ArrayList) WC_NonFunded.get(15);
				if (arrSecurities != null && arrSecurities.size() > 0) {
					for (int j = 0; j < arrSecurities.size(); j++) {
						arrCol = new ArrayList();
						String strBorder = "";
						arrCol = (ArrayList) arrSecurities.get(j);
						if ((introwspan - 1) == j && j != 0) {
							strBorder = "style=\"border-top-width:0\";";
						} else if (j == 0) {
							strBorder = "style=\"border-bottom-width:0\";";
						} else {
							strBorder = "style=\"border-bottom-width:0;border-top-width:0\"";
						}
						if (j == 0) {

							%>
            <td width="8%" align="right" valign="top" <%=strBorder%>>&nbsp;<%=Helper
													.formatDoubleValue(Double
															.parseDouble(Helper
																	.correctDouble((String) arrCol
																			.get(1))))%></td>
            <td width="8%" align="right" valign="top"
							rowspan="<%=introwspan%>"><%=Helper.correctNull((String) WC_NonFunded
											.get(4))%>&nbsp;</td>
            <td width="31%" align="left" valign="top" <%=strBorder%>><%=Helper
													.correctNull((String) arrCol
															.get(0))%>&nbsp;</td>
            <%} else {%>
          </tr>
          <tr> 
            <td width="8%" align="right" valign="top" <%=strBorder%>>&nbsp;<%=Helper
													.formatDoubleValue(Double
															.parseDouble(Helper
																	.correctDouble((String) arrCol
																			.get(1))))%></td>
            <td width="31%" valign="top" align="left" <%=strBorder%>><%=Helper
													.correctNull((String) arrCol
															.get(0))%>&nbsp;</td>
            <%}
					}
				} else {%>
            <td valign="top">&nbsp;</td>
            <td width="8%" align="right" valign="top"
							rowspan="<%=introwspan%>"><%=Helper.correctNull((String) WC_NonFunded.get(4))%>&nbsp; 
            </td>
            <td width="31%" valign="top" align="left">&nbsp;</td>
            <%}

				%>
          </tr>
          <%//For the Sub-limits, under each one
				arrSubFac = new ArrayList();
				arrSubFac = (ArrayList) WC_NonFunded.get(9);
				int subFacSize = arrSubFac.size();
				if (arrSubFac != null && subFacSize > 0) {
					for (int j = 0; j < subFacSize; j++) {
						arrSubFacRecords = new ArrayList();
						arrSubFacRecords = (ArrayList) arrSubFac.get(j);

						chkCategory = Helper
								.correctNull((String) arrSubFacRecords.get(11));
						if (chkCategory.equals("A")) {
							chkCategory1 = "<br>(Adhoc Limit for "
									+ Helper
											.correctNull((String) arrSubFacRecords
													.get(12)) + " Month) ";
						} else {
							chkCategory1 = "";
						}
						int intsubrowspan = Integer.parseInt(Helper
								.correctInt((String) arrSubFacRecords.get(15)));

						%>
          <%if (j == 0) {%>
          <tr> 
            <td colspan="6" valign="top">&nbsp;<b>&gt;&gt;Sub-Limit</b></td>
          </tr>
          <%}%>
          <tr> 
            <td align="left" valign="top" rowspan="<%=intsubrowspan%>">&nbsp;<%=Helper.correctNull((String) arrSubFacRecords
										.get(0))%> <%=chkCategory1%></td>
            <td align="right" valign="top" rowspan="<%=intsubrowspan%>">&nbsp;(<%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(1))))%>)</td>
            <td align="right" valign="top" rowspan="<%=intsubrowspan%>">&nbsp;(<%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(2))))%>)</td>
            <%ArrayList arrsubSecurities = new ArrayList();
						arrsubSecurities = (ArrayList) arrSubFacRecords.get(14);
						if (arrSecurities != null
								&& arrsubSecurities.size() > 0) {
							for (int k = 0; k < arrsubSecurities.size(); k++) {
								arrCol = new ArrayList();
								String strBorder = "";
								arrCol = (ArrayList) arrsubSecurities.get(k);
								if ((intsubrowspan - 1) == k) {
									strBorder = "style=\"border-top-width:0\";";
								} else if (k == 0) {
									strBorder = "style=\"border-bottom-width:0\";";
								} else {
									strBorder = "style=\"border-bottom-width:0;border-top-width:0\"";
								}
								if (k == 0) {

									%>
            <td width="8%" align="right" valign="top" <%=strBorder%>>&nbsp;<%=Helper
															.formatDoubleValue(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrCol
																					.get(1))))%></td>
            <td width="8%" align="right" valign="top"
							rowspan="<%=intsubrowspan%>"><%=Helper
															.correctNull((String) arrSubFacRecords
																	.get(4))%>&nbsp;</td>
            <td width="31%" align="left" valign="top" <%=strBorder%>><%=Helper
															.correctNull((String) arrCol
																	.get(0))%>&nbsp;</td>
            <%} else {%>
          </tr>
          <tr> 
            <td width="8%" align="right" valign="top" <%=strBorder%>>&nbsp;<%=Helper
															.formatDoubleValue(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrCol
																					.get(1))))%></td>
            <td width="31%" align="left" valign="top" <%=strBorder%>><%=Helper
															.correctNull((String) arrCol
																	.get(0))%>&nbsp;</td>
            <%}
							}
						} else {%>
            <td valign="top">&nbsp;</td>
            <td width="8%" align="right" valign="top"><%=Helper
													.correctNull((String) arrSubFacRecords
															.get(4))%>&nbsp;</td>
            <td width="31%" align="left" valign="top">&nbsp;</td>
            <%}

					%>
          </tr>
          <%}
				}
				//End of 'Sub-Facilities' details               
			}

			%>
          <tr> 
            <td width="27%" align="left" valign="top"><b> Sub- Total [A]</b></td>
            <td width="13%" align="right" valign="top">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("wc_nonfunded_existing"))))%></td>
            <td width="13%" align="right" valign="top">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("wc_nonfunded_proposed"))))%></td>
            <td width="8%">&nbsp;</td>
            <td width="8%">&nbsp;</td>
            <td width="31%">&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="6"><b>B] FUND BASED LIMITS</b></td>
          </tr>
          <%OurBank_WC_Funded = new ArrayList();
			WC_Funded = new ArrayList();

			arrWC_Funded_Size = 0;

			OurBank_WC_Funded = (ArrayList) hshValues.get("OurBank_WC_Funded");
			if (OurBank_WC_Funded != null) {
				arrWC_Funded_Size = OurBank_WC_Funded.size();
			}
			for (int i = 0; i < arrWC_Funded_Size; i++) {
				WC_Funded = (ArrayList) OurBank_WC_Funded.get(i);

				chkCategory = Helper.correctNull((String) WC_Funded.get(12));
				if (chkCategory.equals("A")) {
					chkCategory1 = "<br>(Adhoc Limit for "
							+ Helper.correctNull((String) WC_Funded.get(13))
							+ " Month ) ";
				} else {
					chkCategory1 = "";
				}
				int introwspan = Integer.parseInt(Helper
						.correctInt((String) WC_Funded.get(16)));

				%>
          <tr> 
            <td width="27%" align="left" valign="top"
							rowspan="<%=introwspan%>">&nbsp;<b><%=Helper.correctNull((String) WC_Funded.get(0))%> 
              <%=chkCategory1%></b></td>
            <td width="13%" align="right" valign="top"
							rowspan="<%=introwspan%>">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) WC_Funded.get(1))))%></td>
            <td width="13%" align="right" valign="top"
							rowspan="<%=introwspan%>">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) WC_Funded.get(2))))%></td>
            <%ArrayList arrSecurities = new ArrayList();
				arrSecurities = (ArrayList) WC_Funded.get(15);
				if (arrSecurities != null && arrSecurities.size() > 0) {
					for (int j = 0; j < arrSecurities.size(); j++) {
						arrCol = new ArrayList();
						String strBorder = "";
						arrCol = (ArrayList) arrSecurities.get(j);
						if ((introwspan - 1) == j && j != 0) {
							strBorder = "style=\"border-top-width:0\";";
						} else if (j == 0) {
							strBorder = "style=\"border-bottom-width:0\";";
						} else {
							strBorder = "style=\"border-bottom-width:0;border-top-width:0\"";
						}
						if (j == 0) {

							%>
            <td width="8%" align="right" valign="top" <%=strBorder%>>&nbsp;<%=Helper
													.formatDoubleValue(Double
															.parseDouble(Helper
																	.correctDouble((String) arrCol
																			.get(1))))%></td>
            <td width="8%" align="right" valign="top"
							rowspan="<%=introwspan%>"><%=Helper.correctNull((String) WC_Funded
											.get(4))%>&nbsp;</td>
            <td width="31%" align="left" valign="top" <%=strBorder%>><%=Helper
													.correctNull((String) arrCol
															.get(0))%>&nbsp;</td>
            <%} else {%>
          </tr>
          <tr> 
            <td width="8%" align="right" valign="top" <%=strBorder%>>&nbsp;<%=Helper
													.formatDoubleValue(Double
															.parseDouble(Helper
																	.correctDouble((String) arrCol
																			.get(1))))%></td>
            <td width="31%" align="left" valign="top" <%=strBorder%>><%=Helper
													.correctNull((String) arrCol
															.get(0))%>&nbsp;</td>
            <%}
					}
				} else {%>
            <td>&nbsp;</td>
            <td width="8%" align="right" valign="top"><%=Helper.correctNull((String) WC_Funded.get(4))%>&nbsp; 
            </td>
            <td width="31%" align="left">&nbsp;</td>
            <%}

				%>
          </tr>
          <%//For the Sub-limits, under each one
				arrSubFac = new ArrayList();
				arrSubFac = (ArrayList) WC_Funded.get(9);
				int subFacSize = arrSubFac.size();
				if (arrSubFac != null && subFacSize > 0) {
					for (int j = 0; j < subFacSize; j++) {
						arrSubFacRecords = new ArrayList();
						arrSubFacRecords = (ArrayList) arrSubFac.get(j);

						ArrayList arrsubSecurities = new ArrayList();
						arrsubSecurities = (ArrayList) arrSubFacRecords.get(14);

						chkCategory = Helper
								.correctNull((String) arrSubFacRecords.get(11));
						if (chkCategory.equals("A")) {
							chkCategory1 = "<br>(Adhoc Limit for "
									+ Helper
											.correctNull((String) arrSubFacRecords
													.get(12)) + " Month )";
						} else {
							chkCategory1 = "";
						}
						int intsubrowspan = Integer.parseInt(Helper
								.correctInt((String) arrSubFacRecords.get(15)));

						%>
          <%if (j == 0) {%>
          <tr> 
            <td colspan="6">&nbsp;<b>&gt;&gt;Sub-Limit</b></td>
          </tr>
          <%}%>
          <tr> 
            <td align="left" valign="top" rowspan="<%=intsubrowspan%>">&nbsp;<%=Helper.correctNull((String) arrSubFacRecords
										.get(0))%> <%=chkCategory1%></td>
            <td align="right" valign="top" rowspan="<%=intsubrowspan%>">&nbsp;(<%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(1))))%>)</td>
            <td align="right" valign="top" rowspan="<%=intsubrowspan%>">&nbsp;(<%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(2))))%>)</td>
            <%arrsubSecurities = new ArrayList();
						arrsubSecurities = (ArrayList) arrSubFacRecords.get(14);
						if (arrSecurities != null
								&& arrsubSecurities.size() > 0) {
							for (int k = 0; k < arrsubSecurities.size(); k++) {
								arrCol = new ArrayList();
								String strBorder = "";
								arrCol = (ArrayList) arrsubSecurities.get(k);
								if ((intsubrowspan - 1) == k) {
									strBorder = "style=\"border-top-width:0\";";
								} else if (k == 0) {
									strBorder = "style=\"border-bottom-width:0\";";
								} else {
									strBorder = "style=\"border-bottom-width:0;border-top-width:0\"";
								}
								if (k == 0) {

									%>
            <td width="8%" align="right" valign="top" <%=strBorder%>>&nbsp;<%=Helper
															.formatDoubleValue(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrCol
																					.get(1))))%></td>
            <td width="8%" align="right" valign="top"
							rowspan="<%=intsubrowspan%>"><%=Helper
															.correctNull((String) arrSubFacRecords
																	.get(4))%>&nbsp;</td>
            <td width="31%" align="left" valign="top" <%=strBorder%>><%=Helper
															.correctNull((String) arrCol
																	.get(0))%>&nbsp;</td>
            <%} else {%>
          </tr>
          <tr> 
            <td width="8%" align="right" valign="top" <%=strBorder%>>&nbsp;<%=Helper
															.formatDoubleValue(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrCol
																					.get(1))))%></td>
            <td width="31%" align="left" valign="top" <%=strBorder%>><%=Helper
															.correctNull((String) arrCol
																	.get(0))%>&nbsp;</td>
            <%}
							}
						} else {%>
            <td valign="top">&nbsp;</td>
            <td width="8%" align="right" valign="top"><%=Helper
													.correctNull((String) arrSubFacRecords
															.get(4))%>&nbsp;</td>
            <td width="31%" align="left" valign="top">&nbsp;</td>
            <%}

					%>
          </tr>
          <%}
				}
				//End of 'Sub-Facilities' details               
			}

			%>
          <tr> 
            <td width="27%" align="left"><b>Sub- Total [B]</b></td>
            <td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("wc_funded_existing"))))%></td>
            <td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("wc_funded_proposed"))))%></td>
            <td width="8%">&nbsp;</td>
            <td width="8%">&nbsp;</td>
            <td width="31%">&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="6"><b>C] TERM LOAN / DPGL</b></td>
          </tr>
          <%OurBank_TL = new ArrayList();
			TL_Funded_NonFunded = new ArrayList();

			arrTL_Funded_NonFunded_Size = 0;

			OurBank_TL = (ArrayList) hshValues.get("OurBank_TL");

			if (OurBank_TL != null) {
				arrTL_Funded_NonFunded_Size = OurBank_TL.size();
			}

			for (int i = 0; i < arrTL_Funded_NonFunded_Size; i++) {
				TL_Funded_NonFunded = (ArrayList) OurBank_TL.get(i);
				chkCategory = Helper.correctNull((String) TL_Funded_NonFunded
						.get(12));
				if (chkCategory.equals("A")) {
					chkCategory1 = "<br>(Adhoc Limit for "
							+ Helper.correctNull((String) TL_Funded_NonFunded
									.get(13)) + " Month )";
				} else {
					chkCategory1 = "";
				}
				int introwspan = Integer.parseInt(Helper
						.correctInt((String) TL_Funded_NonFunded.get(16)));

				%>
          <tr> 
            <td width="27%" align="left" valign="top"
							rowspan="<%=introwspan%>">&nbsp;<b><%=Helper.correctNull((String) TL_Funded_NonFunded
								.get(0))%> <%=chkCategory1%><b></b></b></td>
            <td width="13%" align="right" valign="top"
							rowspan="<%=introwspan%>">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) TL_Funded_NonFunded
										.get(1))))%></td>
            <td width="13%" align="right" valign="top"
							rowspan="<%=introwspan%>">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) TL_Funded_NonFunded
										.get(2))))%></td>
            <%ArrayList arrSecurities = new ArrayList();
				arrSecurities = (ArrayList) TL_Funded_NonFunded.get(15);
				if (arrSecurities != null && arrSecurities.size() > 0) {
					for (int j = 0; j < arrSecurities.size(); j++) {
						arrCol = new ArrayList();
						String strBorder = "";
						arrCol = (ArrayList) arrSecurities.get(j);
						if ((introwspan - 1) == j && j != 0) {
							strBorder = "style=\"border-top-width:0\";";
						} else if (j == 0) {
							strBorder = "style=\"border-bottom-width:0\";";
						} else {
							strBorder = "style=\"border-bottom-width:0;border-top-width:0\"";
						}
						if (j == 0) {

							%>
            <td width="8%" align="right" valign="top" <%=strBorder%>>&nbsp;<%=Helper
													.formatDoubleValue(Double
															.parseDouble(Helper
																	.correctDouble((String) arrCol
																			.get(1))))%></td>
            <td width="8%" align="right" valign="top"
							rowspan="<%=introwspan%>"><%=Helper
													.correctNull((String) TL_Funded_NonFunded
															.get(4))%>&nbsp;</td>
            <td width="31%" align="left" valign="top" <%=strBorder%>><%=Helper
													.correctNull((String) arrCol
															.get(0))%>&nbsp;</td>
            <%} else {%>
          </tr>
          <tr> 
            <td width="8%" align="right" valign="top" <%=strBorder%>>&nbsp;<%=Helper
													.formatDoubleValue(Double
															.parseDouble(Helper
																	.correctDouble((String) arrCol
																			.get(1))))%></td>
            <td width="31%" align="left" valign="top" <%=strBorder%>><%=Helper
													.correctNull((String) arrCol
															.get(0))%>&nbsp;</td>
            <%}
					}
				} else {%>
            <td>&nbsp;</td>
            <td width="8%" align="right" valign="top"><%=Helper.correctNull((String) TL_Funded_NonFunded
									.get(4))%>&nbsp;</td>
            <td width="31%" align="left">&nbsp;</td>
            <%}

				%>
          </tr>
          <%//For the Sub-limits, under each one
				arrSubFac = new ArrayList();
				arrSubFac = (ArrayList) TL_Funded_NonFunded.get(9);
				int subFacSize = arrSubFac.size();
				if (arrSubFac != null && subFacSize > 0) {
					for (int j = 0; j < subFacSize; j++) {
						arrSubFacRecords = new ArrayList();
						arrSubFacRecords = (ArrayList) arrSubFac.get(j);

						chkCategory = Helper
								.correctNull((String) arrSubFacRecords.get(11));
						if (chkCategory.equals("A")) {
							chkCategory1 = "<br>(Adhoc Limit for "
									+ Helper
											.correctNull((String) arrSubFacRecords
													.get(12)) + " Month )";
						} else {
							chkCategory1 = "";
						}
						int intsubrowspan = Integer.parseInt(Helper
								.correctInt((String) arrSubFacRecords.get(15)));

						%>
          <%if (j == 0) {%>
          <tr> 
            <td colspan="6">&nbsp;<b>&gt;&gt;Sub-Limit</b></td>
          </tr>
          <%}%>
          <tr> 
            <td align="left" valign="top" rowspan="<%=intsubrowspan%>">&nbsp;<%=Helper.correctNull((String) arrSubFacRecords
										.get(0))%> <%=chkCategory1%></td>
            <td align="right" valign="top" rowspan="<%=intsubrowspan%>">&nbsp;(<%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(1))))%>)</td>
            <td align="right" valign="top" rowspan="<%=intsubrowspan%>">&nbsp;(<%=Helper
												.formatDoubleValue(Double
														.parseDouble(Helper
																.correctDouble((String) arrSubFacRecords
																		.get(2))))%>)</td>
            <%ArrayList arrsubSecurities = new ArrayList();
						arrsubSecurities = (ArrayList) arrSubFacRecords.get(14);
						if (arrSecurities != null
								&& arrsubSecurities.size() > 0) {
							for (int k = 0; k < arrsubSecurities.size(); k++) {
								arrCol = new ArrayList();
								String strBorder = "";
								arrCol = (ArrayList) arrsubSecurities.get(k);
								if ((intsubrowspan - 1) == k) {
									strBorder = "style=\"border-top-width:0\";";
								} else if (k == 0) {
									strBorder = "style=\"border-bottom-width:0\";";
								} else {
									strBorder = "style=\"border-bottom-width:0;border-top-width:0\"";
								}
								if (k == 0) {

									%>
            <td width="8%" align="right" valign="top" <%=strBorder%>>&nbsp;<%=Helper
															.formatDoubleValue(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrCol
																					.get(1))))%></td>
            <td width="8%" align="right" valign="top"
							rowspan="<%=intsubrowspan%>"><%=Helper
															.correctNull((String) arrSubFacRecords
																	.get(4))%>&nbsp;</td>
            <td width="31%" align="left" valign="top" <%=strBorder%>><%=Helper
															.correctNull((String) arrCol
																	.get(0))%>&nbsp;</td>
            <%} else {%>
          </tr>
          <tr> 
            <td width="8%" align="right" valign="top" <%=strBorder%>>&nbsp;<%=Helper
															.formatDoubleValue(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrCol
																					.get(1))))%></td>
            <td width="31%" align="left" valign="top" <%=strBorder%>><%=Helper
															.correctNull((String) arrCol
																	.get(0))%>&nbsp;</td>
            <%}
							}
						} else {%>
            <td valign="top">&nbsp;</td>
            <td width="8%" align="right" valign="top"><%=Helper
													.correctNull((String) arrSubFacRecords
															.get(4))%>&nbsp;</td>
            <td width="31%" align="left" valign="top">&nbsp;</td>
            <%}

					%>
          </tr>
          <%}
				}
				//End of 'Sub-Facilities' details               
			}

			%>
          <tr> 
            <td width="27%" align="left"><b>Sub- Total [C]</b></td>
            <td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("tl_total_existing"))))%></td>
            <td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("tl_total_proposed"))))%></td>
            <td width="8%">&nbsp;</td>
            <td width="8%">&nbsp;</td>
            <td width="31%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="27%"> 
              <div align="center"><b>TOTAL [A+B+C]</b></div>
            </td>
            <td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("total_existing"))))%></td>
            <td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("total_proposed"))))%></td>
            <td width="8%">&nbsp;</td>
            <td width="8%">&nbsp;</td>
            <td width="31%">&nbsp;</td>
          </tr>
        </table>
      </div>
    </td>
  </tr>
</table>
<%
                    arrRow=new ArrayList();
                    arrData=new ArrayList();
                    arrRow=(ArrayList)hshValues.get("arrSecRemarks");
                    if(arrRow!=null && arrRow.size()!=0){
                
                    %>
<table width="90%" border="0" cellspacing="0" cellpadding="3" align="center">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <%  for(int i=0;i<arrRow.size();i++)
      {
    	  arrData=(ArrayList)arrRow.get(i); 
    	  if(!Helper.formatTextAreaData((String)arrData.get(0)).equalsIgnoreCase("")){ %>
        <tr> 
          <td width="3%">&nbsp;</td>
        </tr>
        <tr> 
          <td width="3%">&nbsp;</td>
          <td valign="top" class="just" width="97%"><%=Helper.formatTextAreaData((String)arrData.get(0))%>&nbsp;</td>
        </tr>
        <%}
	  } %>
      </table>
    </td>
  </tr>
</table>
<%   }
                    %>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
			align="center">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="3%">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" width="3%"><b>&nbsp;</b></td>
          <td valign="top" width="97%"><b>TERMS AND CONDITIONS:</b></td>
        </tr>
        <%arrRow = new ArrayList();
			arrData = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrRow12");
			if (arrRow != null && arrRow.size() != 0) {
				for (int i = 0; i < arrRow.size(); i++) {
					arrData = (ArrayList) arrRow.get(i);

					%>
        <tr> 
          <td valign="top" width="3%">&nbsp;<%=i + 1%>.</td>
          <td valign="top" class="just" width="97%"><%=Helper
											.formatTextAreaData((String) arrData
													.get(0))%>&nbsp;</td>
        </tr>
        <%}
			}

			%>
      </table>
    </td>
  </tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
			align="center">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0"
					align="left">
        <tr> 
          <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;</td>
        </tr>
        <tr> 
          <td colspan="2">&nbsp;</td>
        </tr>
        <tr> 
          <td width="10%">&nbsp;</td>
          <td valign="top"><b><%=Helper.correctNull((String) hshValues
							.get("exec_signatures"))%></b></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
