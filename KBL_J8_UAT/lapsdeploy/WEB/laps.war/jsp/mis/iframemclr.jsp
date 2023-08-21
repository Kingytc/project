<%@include file="../share/directives.jsp"%>
<%
String strType=Helper.correctNull((String)hshValues.get("strtype"));
String strValue=Helper.correctDouble((String)hshValues.get("strmclrspread"));
String strID=Helper.correctNull((String)hshValues.get("strID"));
int intSize=Integer.parseInt(Helper.correctInt((String)hshValues.get("strSize")));
%>
<lapschoice:handleerror />
<html>
<head>
<script>
function callOnLoad()
{
	var varCRPTot=0.0,varBSP=0.0;
	<%if(intSize>1)
	{
		if(strType.equalsIgnoreCase("CRP"))
		{%>
			parent.frames.document.forms[0].txt_crpspreadval[<%=strID%>].value="<%=strValue%>";
			for(var i=0;i<(parent.frames.document.forms[0].txt_crpspreadval.length);i++)
			{
				varCRPTot=varCRPTot+parseFloat(NanNumber(parent.frames.document.forms[0].txt_crpspreadval[i].value));
			}

			if(parseFloat(varCRPTot)<0)
			{
				varCRPTot=0.0;
			}
			parent.frames.document.forms[0].hidcrptotal.value=varCRPTot;
			parent.frames.document.forms[0].hidcrptotal.value=roundtxt(parent.frames.document.forms[0].hidcrptotal);
					
		<%}
		else if(strType.equalsIgnoreCase("BSP"))
		{%>
			parent.frames.document.forms[0].txt_bspspreadval[<%=strID%>].value="<%=strValue%>";
			for(var i=0;i<(parent.frames.document.forms[0].txt_bspspreadval.length);i++)
			{
				varBSP=varBSP+parseFloat(NanNumber(parent.frames.document.forms[0].txt_bspspreadval[i].value));
			}

			if(parseFloat(varBSP)<0)
			{
				varBSP=0.0;
			}
					
			parent.frames.document.forms[0].hidbsptotal.value=varBSP;
			parent.frames.document.forms[0].hidbsptotal.value=roundtxt(parent.frames.document.forms[0].hidbsptotal);
		<%}
	%>
	<%}else{
		if(Double.parseDouble(Helper.correctDouble(strValue))<0){
			strValue="0.0";
		}
		if(strType.equalsIgnoreCase("CRP"))
		{%>
			parent.frames.document.forms[0].txt_crpspreadval.value="<%=strValue%>";
			varCRPTot=varCRPTot+parseFloat(NanNumber(parent.frames.document.forms[0].txt_crpspreadval.value));
			if(parseFloat(varCRPTot)<0)
			{
				varCRPTot=0.0;
			}
			parent.frames.document.forms[0].hidcrptotal.value=varCRPTot;
			parent.frames.document.forms[0].hidcrptotal.value=roundtxt(parent.frames.document.forms[0].hidcrptotal);
					
		<%}
		else if(strType.equalsIgnoreCase("BSP"))
		{%>
			parent.frames.document.forms[0].txt_bspspreadval.value="<%=strValue%>";

			varBSP=varBSP+parseFloat(NanNumber(parent.frames.document.forms[0].txt_bspspreadval.value));
			if(parseFloat(varBSP)<0)
			{
				varBSP=0.0;
			}
					
			parent.frames.document.forms[0].hidbsptotal.value=varBSP;
			parent.frames.document.forms[0].hidbsptotal.value=roundtxt(parent.frames.document.forms[0].hidbsptotal);
		<%}
	%>
	<%}%>	

	
	
	parent.frames.document.forms[0].hidtotalIntRate.value=parseFloat(NanNumber(parent.frames.document.forms[0].hidMCLRSpread.value))+
	parseFloat(NanNumber(parent.frames.document.forms[0].hidcrptotal.value))+parseFloat(NanNumber(parent.frames.document.forms[0].hidbsptotal.value));
	
	parent.frames.document.forms[0].hidtotalIntRate.value=roundtxt(parent.frames.document.forms[0].hidtotalIntRate);
}
</script>
</head>
<body onload="callOnLoad();">
<form></form>
</body>
</html>