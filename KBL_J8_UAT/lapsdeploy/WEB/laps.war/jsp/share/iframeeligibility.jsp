<%@include file="../share/directives.jsp"%>
<lapschoice:handleerror />
<%
	String strStatus = Helper.correctNull((String)hshValues.get("Status"));
	String strStaffFlag = Helper.correctNull((String)hshValues.get("StaffFlag"));
	String strEMI = Helper.correctNull((String)hshValues.get("EMI"));
	String strInterestEMI = Helper.correctNull((String)hshValues.get("InterestEMI"));
	String strRepaycapcity = Helper.correctNull((String)hshValues.get("repaycapacity"));
	String strMessage ="";
	
	ArrayList arrMessage = new ArrayList();
	
	if(hshValues.get("Message")!=null)
	{
		arrMessage = (ArrayList)hshValues.get("Message");
	}
	
	if(arrMessage!=null && arrMessage.size()>0)
	{
		for(int i=0; i<arrMessage.size(); i++)
			strMessage += Helper.correctNull((String)arrMessage.get(i)) + "\\n";
		
	}
	String hidPage=Helper.correctNull((String)request.getParameter("hidPage"));
	String catgeryType = Helper.correctNull((String) request
			.getParameter("hidCategoryType"));
%>

<html>
<head>
<title>Eligibility Check</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script>

var path="<%=ApplicationParams.getAppUrl()%>";
var varStatus = "<%=strStatus%>";
var varEMI = "<%=strEMI%>";
var varInterestEMI = "<%=strInterestEMI%>";
var varStaffFlag = "<%=strStaffFlag%>";
var varrepaycapacity="<%=strRepaycapcity%>";
var hidPage="<%=hidPage%>";
var categorytype="<%=catgeryType%>";
var varMessage="<%=strMessage%>";
function loadValues()
{
	if(hidPage!="Y")
	{
		if(varStatus.toUpperCase()!="SUCCESS")
		{
			if(varMessage!="")
			{			
			alert("<%=strMessage%>");
			}
			parent.frames.document.forms[0].hidValid.value = "N";
			parent.frames.document.forms[0].cmdsave.disabled=true;
		}
		else
		{
			//Populate the updated EMI values
			parent.frames.document.forms[0].hidValid.value = "Y";
			if(varStaffFlag=="Y" && varInterestEMI!="")
			{
				parent.frames.document.forms[0].txt_interest_EMI.value = varInterestEMI;
			}
			//parent.frames.document.forms[0].txt_EMI.value = NanNumber(Math.floor(varEMI));
			if(categorytype=="AGR")
			{
				 parent.frames.document.forms[0].txt_repaycapacity.value=varrepaycapacity;
			}
			
			if(parent.frames.document.forms[0].cmdedit.disabled!=false
					&&parent.frames.document.forms[0].btnenable.value=="Y" && parent.frames.strSessionModuleType!="DIGI")
			{
				parent.frames.document.forms[0].cmdsave.disabled=false;
			}
		}
	}
	else
	{
		
		if("<%=strMessage%>"=="")
		{
			parent.frames.document.forms[0].hidValid.value = "N";
		}
		else
		{
			alert("<%=strMessage%>");
			parent.frames.document.forms[0].hidValid.value = "Y";
		}
		
	}	
	if(parent.frames.interest=="0.00")
	{
		parent.frames.document.forms[0].cmdsave.disabled=true;
	}
}

</script>
</head>
<body  leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="bfrm" method="post" class="normal"></form>
</body>
</html>
