<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="HashMap" scope="request"></jsp:useBean>

<%
java.text.NumberFormat nf = java.text.NumberFormat
.getNumberInstance();
nf.setGroupingUsed(false);
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
	String years=Helper.correctNull((String)hshValues.get("years"));
double dblyears=Double.parseDouble(years);
if(years!="")
{%>
	<%=nf.format(dblyears)%>
<%}%>
