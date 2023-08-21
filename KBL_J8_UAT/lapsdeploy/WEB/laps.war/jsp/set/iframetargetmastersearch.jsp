<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%ArrayList arrValues = new ArrayList();

	if (hshValues != null) {
		arrValues = (ArrayList) hshValues.get("arrCust");
	}
	java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
	nf.setMinimumFractionDigits(2);
	nf.setMaximumFractionDigits(2);
	nf.setGroupingUsed(false);
%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/set/targetmasterbranch.js"></script>
<script>

function loadValues()
{
	<% 
		if(arrValues.size()>0){
		for(int j=0;j<arrValues.size();j++)
		{
			ArrayList arrVal = (ArrayList) arrValues.get(j);
			if(arrVal.size()>0){%> 
				
					 parent.frames.document.forms[0].txt_target_noofaccounts["<%=j%>"].value = "<%=(String)arrVal.get(0)%>";
					 parent.frames.document.forms[0].txt_target_amount["<%=j%>"].value = "<%=nf.format(Double.parseDouble((String)arrVal.get(1))/100000.00)%>";
					
					 parent.frames.document.forms[0].txt_sanctioned_noofaccounts["<%=j%>"].value = "<%=(String)arrVal.get(2)%>";
					 parent.frames.document.forms[0].txt_sanctioned_amount["<%=j%>"].value = "<%=nf.format(Double.parseDouble((String)arrVal.get(3))/100000.00)%>";
					
					 parent.frames.document.forms[0].txt_outstanding_noofaccounts["<%=j%>"].value = "<%=(String)arrVal.get(4)%>";
					 parent.frames.document.forms[0].txt_outstanding_amount["<%=j%>"].value = "<%=nf.format(Double.parseDouble((String)arrVal.get(5))/100000.00)%>";
				
		<%}}%>
	<%}
		else{%>
		/* parent.frames.document.forms[0].txt_periodfrom.value="";
		 parent.frames.document.forms[0].txt_periodto.value=""; */
		// parent.frames.document.forms[0].sel_branch.disabled=true;
		// parent.frames.document.forms[0].txt_yearfrom.readOnly=true;
		 // parent.frames.document.forms[0].txt_yearto.value="";
		// parent.frames.document.forms[0].sel_type.disabled=true;
		// parent.frames.document.forms[0].cmdNew.disabled=false;
		 parent.frames.document.forms[0].cmdEdit.disabled=true;
		 parent.frames.document.forms[0].cmdApply.disabled=true;
		 parent.frames.document.forms[0].cmdCancel.disabled=false;
		 parent.frames.document.forms[0].cmdDelete.disabled=true;
		 parent.frames.document.forms[0].cmdClose.disabled=false;
		 
		 for(var i=0;i<parent.frames.document.forms[0].txt_target_noofaccounts.length;i++)
		{
			parent.frames.document.forms[0].txt_target_noofaccounts[i].value="";
			parent.frames.document.forms[0].txt_target_amount[i].value="";
			parent.frames.document.forms[0].txt_sanctioned_noofaccounts[i].value="";
			parent.frames.document.forms[0].txt_sanctioned_amount[i].value="";
			parent.frames.document.forms[0].txt_outstanding_noofaccounts[i].value="";
			parent.frames.document.forms[0].txt_outstanding_amount[i].value="";
		}
		 alert("No Data Found");
		 
	<%}%>
		 parent.frames.document.forms[0].sel_branch.disabled=true;
		 parent.frames.document.forms[0].txt_yearfrom.readOnly=true;
		
	
}

 
</script>
</head>

<body bgcolor="#E4E2ED" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues();calculate()">
<form name="appfrm" method="post">
</form>
</body>
</html>