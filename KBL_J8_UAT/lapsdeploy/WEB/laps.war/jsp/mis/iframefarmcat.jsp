<%@include file="../share/directives.jsp"%>
<%
	ArrayList arrRow=new ArrayList();
	if(hshValues!=null&&hshValues.size()>0)
	{
		arrRow=(ArrayList)hshValues.get("arrRow");
	}
	
%>
<lapschoice:handleerror />
<html>
<head>
<script>
var varPage = "<%=Helper.correctNull((String)request.getParameter("hidBeanId"))%>";
function callOnLoad()
{
	<%
		if(arrRow!=null&&arrRow.size()>0)
		{
	%>
			parent.frames.document.forms[0].sel_FarmerCategory.options.length=0;
			parent.frames.document.forms[0].sel_FarmerCategory.length="<%=arrRow.size()+1%>";
			parent.frames.document.forms[0].sel_FarmerCategory.options[0].value="";
			parent.frames.document.forms[0].sel_FarmerCategory.options[0].text="--Select--";
			parent.frames.document.forms[0].hid_FarmCat.value="Y";
	<%
			for(int i=0;i<arrRow.size();i++)
			{
				ArrayList arrCol=new ArrayList();
				arrCol=(ArrayList)arrRow.get(i);
	%>
				parent.frames.document.forms[0].sel_FarmerCategory.options[<%=i+1%>].value="<%=arrCol.get(0)%>";
				parent.frames.document.forms[0].sel_FarmerCategory.options[<%=i+1%>].text="<%=arrCol.get(1)%>";
	<%
			}
		} if(arrRow!=null&&arrRow.size()==1){%>
		parent.frames.document.forms[0].sel_FarmerCategory.options[1].selected=true;
		<%}
		else {%> 
		parent.frames.document.forms[0].sel_FarmerCategory.options[0].selected=true;
		
		<%}
		if(arrRow!=null&&arrRow.size()>0)
		{
	%>
			if(parent.frames.document.forms[0].cmdsave.disabled==false&&(parent.frames.document.forms[0].txt_TotLandHold.value=="0.00"||parent.frames.document.forms[0].txt_TotLandHold.value=="0"))
			{
				parent.frames.document.forms[0].sel_FarmerCategory.disabled=false;
			}
	<%		
		}
	%>

	if(varPage != "mis")
	{
		if(parent.frames.document.forms[0].sel_FarmerCategory.value != "021")
		{
			parent.frames.document.all.llt1.style.display = "none";
		}
		else
		{
			parent.frames.document.all.llt1.style.display = "table-row";
		}
	}
}
</script>
</head>
<body onload="callOnLoad();">
<form>
</form>
</body>
</html>