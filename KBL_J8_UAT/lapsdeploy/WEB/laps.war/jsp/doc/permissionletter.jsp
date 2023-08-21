    <%@include file="../share/directives.jsp"%>
    
    <%
ArrayList arrRow=new ArrayList();

ArrayList arrCol = new ArrayList();
arrRow = (ArrayList) hshValues.get("arrRow");
String strSubType=Helper.correctNull((String)hshValues.get("DEV_SUBTYPE"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Permission Letter</title>
<style type="text/css">
body,table td {
	FONT-SIZE: 16px !important;
	COLOR: #000000 !important;
	FONT-FAMILY: "Book Antiqua" !important;
}
</style>
</head>

<body>

<table width="98%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
		  <tr>
	  <td>
	  <table width="95%" border="0" cellspacing="1" cellpadding="3"	class="outertable" align="center">
	  <tr>
		<td>
			<table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
				<tr><td align="center"><br><img src="<%=ApplicationParams.getAppUrl()%>img/kbl_newlogo.jpg"></td></tr>
				<tr><td align="center"><b><u>Permission Letter</u></b></td></tr>
			</table>
		</td>
	</tr>
	 <tr>
	<td align="right">Date: <%=Helper.getCurrentDateTime()%></td>
    <tr>
    <td>The Branch Head,</td>
    </tr>
    <tr>
    <td>&nbsp;<%=Helper.correctNull((String)hshValues.get("strDEV_ORGSNAME")) %>  Branch.</td>
    </tr>
    <tr>
    <td> &nbsp;</td> 
    </tr>
    <tr>
    <td><b>Dear Sir,</b></td> 
    </tr>
    <tr>
    <td>Reg:<%=Helper.correctNull((String)hshValues.get("strComments1")).replace("<p>","") %></td>
	</tr>
	<tr>
	<tr>
    <td>Ref:<%=Helper.correctNull((String)hshValues.get("borrowername"))%> <%if(!Helper.correctNull((String)hshValues.get("strCBSID")).equalsIgnoreCase("")){ %>- Customer ID : <%=Helper.correctNull((String)hshValues.get("strCBSID"))%>&nbsp;<%} %></td>
	</tr>
	<tr>
	
    <td align="center"> **********</td></tr>
    <tr align="justify">
    <td >In terms of  <b><%=Helper.correctNull((String) hshValues.get("sanctionrefno"))%></b> Dated  <b><%=Helper.correctNull((String) hshValues.get("DEV_PROCESSDATE"))%></b>, <%=Helper.correctNull((String)hshValues.get("strComments2")) %></td>
        </tr>
        <tr>
        <td><b>Other conditions:</b></td>
        </tr>
        
        <tr>
        <td>
        <ol type="i">
         <%
							if (arrRow != null && arrRow.size() > 0) {
								for (int i = 0; i < arrRow.size(); i++) {
									arrCol = (ArrayList) arrRow.get(i);
									
						%>
        &emsp;<li><%=Helper.correctNull((String) arrCol.get(0))%></li>
		
		<%}%>
		<%} %>
		<li>Collect handling charges of Rs.<%=Helper.correctDouble((String)hshValues.get("PERM_HANDLING_CHARGE")) %> plus applicable taxes.</li>
		</ol>
		</td>
		</tr>
		
		<tr>
		<td><b>Yours faithfully,</b></td>
		</tr>
		<tr>
		<td><b>Authorised Signatory </b></td>
		</tr>
		<tr>
		<td><b>Cc to :The Assistant General Manager, <%=Helper.correctNull((String)hshValues.get("strorg_region")) %>.</b></td></tr>
		</table>
		</td>
		</tr>
		</table>
		
</body>
</html>