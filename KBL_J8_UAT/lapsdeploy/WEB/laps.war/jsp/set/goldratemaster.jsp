<%@ include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	ArrayList arrRow=new ArrayList();
	ArrayList arrCol=new ArrayList();
	String strRetGLQuick="", strAgriGLQuick="", strRetGLClassic="", strAgriGLClassic="";
	String strRetGLComfort="", strAgriGLComfort="", strRetGLStaff="", strAgriGLStaff="";
	String strComments="", strMaxNetWeight="", strMaxGoldLoans="",strAvgMargin="",strLatestMargin="";
	String strRecurrexpMargin="",stragridevelopMargin="",strAgriAvgMargin="",strAgriLatestMargin="";
	if(hshValues!=null&&hshValues.size()>0)
	{
		arrRow=(ArrayList)hshValues.get("arrRow");
	}
	if(arrRow!=null&&arrRow.size()>0)
	{
		for(int i=0;i<arrRow.size();i++)
		{
			arrCol=(ArrayList)arrRow.get(i);
			strRetGLQuick=Helper.checkDecimal((String)arrCol.get(2));
			strAgriGLQuick=Helper.checkDecimal((String)arrCol.get(3));
			strRetGLClassic=Helper.checkDecimal((String)arrCol.get(4));
			strAgriGLClassic=Helper.checkDecimal((String)arrCol.get(5));
			strRetGLComfort=Helper.checkDecimal((String)arrCol.get(6));
			strAgriGLComfort=Helper.checkDecimal((String)arrCol.get(7));
			strRetGLStaff=Helper.checkDecimal((String)arrCol.get(8));
			strAgriGLStaff=Helper.checkDecimal((String)arrCol.get(9));
			strComments=Helper.correctNull((String)arrCol.get(10));
			strMaxNetWeight=Helper.correctNull((String)arrCol.get(11));
			strMaxGoldLoans=Helper.correctNull((String)arrCol.get(12));
			strAvgMargin=Helper.correctNull((String)arrCol.get(13));
			strLatestMargin=Helper.correctNull((String)arrCol.get(14));
			strRecurrexpMargin=Helper.correctNull((String)arrCol.get(15));
			stragridevelopMargin=Helper.correctNull((String)arrCol.get(16));
			strAgriAvgMargin=Helper.correctNull((String)arrCol.get(17));
			strAgriLatestMargin=Helper.correctNull((String)arrCol.get(18));
		}
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/set/goldratemaster.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script>
</script>
</head>
<body onload="callOnLoad()">
<form name="frmgoldrate" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr>
	<td class="page_flow">Home -&gt; Master -&gt; Gold Rate Master</td>
</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
<tr>
	<td>
		<jsp:include page="../set/mastertab.jsp" flush="true">
		<jsp:param name="tabid" value="11" />
		</jsp:include>
	</td>
</tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1 tableBg" align="center">
<tr>
	<td>
		<table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
		<!--<tr>
			<td width="25%">
				Value of gold for Retail Customer as per bank scheme GL Quick
			</td>
			<td width="25%" >
				<input type="text" name="txt_retglquick" tabindex="1" size="20" maxlength="15" value="<%=strRetGLQuick%>"
				onKeyPress="allowNumber(this)" onBlur="roundtxt(this);" style="text-align: right">
			</td>
			<td width="20%">
				Value of gold for Agri Customer as per bank scheme GL Quick
			</td>
			<td width="30%" >
				<input type="text" name="txt_agriglquick" tabindex="2" size="20" maxlength="15" value="<%=strAgriGLQuick%>"
				onKeyPress="allowNumber(this)" onBlur="roundtxt(this);" style="text-align: right">
			</td>
		</tr>
		<tr>
			<td>
				Value of gold for Retail Customer as per bank scheme GL Classic
			</td>
			<td>
				<input type="text" name="txt_retglclassic" tabindex="3" size="20" maxlength="15" value="<%=strRetGLClassic%>"
				onKeyPress="allowNumber(this)" onBlur="roundtxt(this);" style="text-align: right">
			</td>
			<td>
				Value of gold for Agri Customer as per bank scheme GL Classic
			</td>
			<td>
				<input type="text" name="txt_agriglclassic" tabindex="4" size="20" maxlength="15" value="<%=strAgriGLClassic%>"
				onKeyPress="allowNumber(this)" onBlur="roundtxt(this);" style="text-align: right">
			</td>
		</tr>
		<tr>
			<td>
				Value of gold for Retail Customer as per bank scheme GL Comfort
			</td>
			<td>
				<input type="text" name="txt_retglcomfort" tabindex="5" size="20" maxlength="15" value="<%=strRetGLComfort%>"
				onKeyPress="allowNumber(this)" onBlur="roundtxt(this);" style="text-align: right">
			</td>
			<td>
				Value of gold for Agri Customer as per bank scheme GL Comfort
			</td>
			<td>
				<input type="text" name="txt_agriglcomfort" tabindex="6" size="20" maxlength="15" value="<%=strAgriGLComfort%>"
				onKeyPress="allowNumber(this)" onBlur="roundtxt(this);" style="text-align: right">
			</td>
		</tr>
		<tr>
			<td>
				Value of gold for Retail Customer as per bank scheme GL Staff
			</td>
			<td>
				<input type="text" name="txt_retglstaff" tabindex="7" size="20" maxlength="15" value="<%=strRetGLStaff%>"
				onKeyPress="allowNumber(this)" onBlur="roundtxt(this);" style="text-align: right">
			</td>
			<td>
				Value of gold for Agri Customer as per bank scheme GL Smart
			</td>
			<td>
				<input type="text" name="txt_agriglstaff" tabindex="8" size="20" maxlength="15" value="<%=strAgriGLStaff%>"
				onKeyPress="allowNumber(this)" onBlur="roundtxt(this);" style="text-align: right">
			</td>
		</tr>
		-->
		<tr>
			<td  width="35%">
				Market Rate as per IBJA
			</td>
			<td  width="10%" nowrap="nowrap">
				<input type="text" name="txt_latestrate" tabindex="11" size="15"  value="<%=Helper.correctDouble((String)hshValues.get("strGoldRate"))%>"
				onKeyPress="allowNumber(this)" style="text-align: right" class="finaclefieldsbgcolor" readonly>&nbsp;
			</td>
			<td  width="25%" nowrap="nowrap">
				Average of previous 30 days Gold Rate as per IBJA 
			</td>
			<td  width="25%" nowrap="nowrap">
				<input type="text" name="txt_avgrate" tabindex="11" size="15"  value="<%=Helper.correctDouble((String)hshValues.get("strAvgGoldRate"))%>"
				onKeyPress="allowNumber(this)" style="text-align: right" class="finaclefieldsbgcolor" readonly>&nbsp;
			</td>
		</tr>
		<tr>
			<td  width="35%">
				Margin percentage of previous 30 days closing gold rates as per IBJA (Personal)
			</td>
			<td  width="10%" nowrap="nowrap">
				<input type="text" name="txt_avgmargin" tabindex="11" size="7" maxlength="5" value="<%=strAvgMargin%>"
				onKeyPress="allowNumber(this)" onBlur="checkPercentage(this);roundtxt(this);" style="text-align: right">&nbsp;(%)
			</td>
			<td  width="25%" nowrap="nowrap">
				Margin percentage of last market rate as per IBJA (Personal)
			</td>
			<td  width="25%" nowrap="nowrap">
				<input type="text" name="txt_latestmargin" tabindex="11" size="7" maxlength="5" value="<%=strLatestMargin%>"
				onKeyPress="allowNumber(this)" onBlur="checkPercentage(this);roundtxt(this);" style="text-align: right">&nbsp;(%)
			</td>
		</tr>
			<tr>
			<td  width="35%">
				Margin percentage of previous 30 days closing gold rates as per IBJA (Agri)
			</td>
			<td  width="10%" nowrap="nowrap">
				<input type="text" name="txt_avgmargin_agri" tabindex="11" size="7" maxlength="5" value="<%=strAgriAvgMargin%>"
				onKeyPress="allowNumber(this)" onBlur="checkPercentage(this);roundtxt(this);" style="text-align: right">&nbsp;(%)
			</td>
			<td  width="25%" nowrap="nowrap">
				Margin percentage of last market rate as per IBJA (Agri)
			</td>
			<td  width="25%" nowrap="nowrap">
				<input type="text" name="txt_latestmargin_agri" tabindex="11" size="7" maxlength="5" value="<%=strAgriLatestMargin%>"
				onKeyPress="allowNumber(this)" onBlur="checkPercentage(this);roundtxt(this);" style="text-align: right">&nbsp;(%)
			</td>
		</tr>
		<tr>
			<td>
				Maximum net weightage of Gold coins (per borrower) is
			</td>
			<td>
				<input type="text" name="txt_MaxNetWeight" tabindex="10" size="5" maxlength="15" value="<%=strMaxNetWeight%>"
				onKeyPress="allowNumber(this)" style="text-align: right">
			</td>
			
			<td>
				Maximum number of Gold Loans (per borrower) is
			</td>
			<td>
				<input type="text" name="txt_MaxGoldLoans" tabindex="11" size="5" maxlength="2" value="<%=strMaxGoldLoans%>"
				onKeyPress="allowNumber(this)" style="text-align: right">
			</td>
		</tr>
		<tr>
			<td>
				Margin percentage of the recurring expenses
			</td>
			<td>
				<input type="text" name="txt_recurexpmargin" tabindex="10" size="5" maxlength="15" value="<%=strRecurrexpMargin%>"
				onKeyPress="allowNumber(this)" style="text-align: right" onBlur="checkPercentage(this);roundtxt(this);">
			</td>
			
			<td>
				Margin percentage for Allied Activities
			</td>
			<td>
				<input type="text" name="txt_maragridevelop" tabindex="11" size="5" maxlength="2" value="<%=stragridevelopMargin%>"
				onKeyPress="allowNumber(this)" style="text-align: right" onBlur="checkPercentage(this);roundtxt(this);">
			</td>
		</tr>
		<tr>
			
			<td>
				Comments
			</td>
			<td colspan="2">
				<textarea name="txtarea_comments" rows="5" cols="50" tabindex="9" onKeyPress="textlimit(this,299);" onKeyUp="textlimit(this,299);"><%=strComments%></textarea>
			</td>
			<td>&nbsp;</td>
		</tr>
		</table>
	</td>
</tr>
</table>
<br>
<table width="12%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
<tr>
	<td>
	<lapschoice:combuttonnew btnnames="New_Save_Cancel_History" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
	</td>
</tr>
</table>
<input type="hidden" name="hidorg_code" value="<%=Helper.correctNull((String) hshValues.get("ORG_CODE"))%>">
<input type="hidden" name="hidsno" value="<%=Helper.correctNull((String) hshValues.get("BUILDER_CODE"))%>">
<input type="hidden" name="hidmastid"/>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidreputedstatus">
<input type="hidden" name="hidzip">
<input type="hidden" name="hidSNo">
<input type="hidden" name="hidModDate">
</form>
</body>
</html>