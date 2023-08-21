<%@include file="../share/directives.jsp"%>

<%
	String BranchCode=Helper.correctNull((String)hshValues.get("BranchCode"));
	String Solid=Helper.correctNull((String)hshValues.get("Solid"));
	String Branchname=Helper.correctNull((String)hshValues.get("Branchname"));
if(!BranchCode.equalsIgnoreCase(""))
{%>
	<%=BranchCode%>
	 #<%=Branchname%>#
<%}
if(!Solid.equalsIgnoreCase(""))
{%>
	<%=Solid%>
	#<%=Branchname%>#
<%}
%>