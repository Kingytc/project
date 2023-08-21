<%@include file="../share/directives.jsp"%>
<lapschoice:handleerror />
<%
ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();
String strFacilitySno="",strPromotorID="";
if(hshValues!=null&&hshValues.size()>0)
{
	arrRow=(ArrayList)hshValues.get("arrRow");
	strFacilitySno=Helper.correctNull((String)hshValues.get("strFacilitysno"));
	strPromotorID=Helper.correctNull((String)hshValues.get("strPromotorID"));
}
%>
<html>
<head>
<script>
var varPostSanc="<%=Helper.correctNull((String)hshValues.get("strPostSancFlag"))%>";
var varPostSancParam="<%=Helper.correctNull((String)hshValues.get("strPostSancParam"))%>";
var varFACILITY_WHT_CGTMSEAPPLY="<%=Helper.correctNull((String)hshValues.get("FACILITY_WHT_CGTMSEAPPLY"))%>";
var varfacility_group="<%=Helper.correctNull((String)hshValues.get("facility_group"))%>";

function callOnLoad()
{
	parent.frames.document.forms[0].txt_prd_cgtmse.value=varFACILITY_WHT_CGTMSEAPPLY;
	parent.frames.document.forms[0].hidFacgroup.value=varfacility_group;		
	<%
	if(arrRow!=null&&arrRow.size()>0)
	{
	%>
		parent.frames.document.forms[0].cho_promoter.length="<%=arrRow.size()+1%>";
		<%
			for(int i=0;i<arrRow.size();i++)
			{
				arrCol=(ArrayList)arrRow.get(i);
				String strCode=Helper.correctNull((String)arrCol.get(0));
				String strDesc=Helper.correctNull((String)arrCol.get(1));
			%>
				parent.frames.document.forms[0].cho_promoter.options["<%=i+1%>"].value="<%=strCode%>";
				parent.frames.document.forms[0].cho_promoter.options["<%=i+1%>"].text="<%=strDesc%>";
				
			<%
			}
	}
	else
	{%>
	parent.frames.document.forms[0].cho_promoter.length="1";
	parent.frames.document.forms[0].cho_promoter.options[0].value="S";
	parent.frames.document.forms[0].cho_promoter.options[0].text="-- Select --";
	<%}
	if(!strFacilitySno.equalsIgnoreCase("0"))
	{
		%>
		parent.frames.document.forms[0].sel_facility.value="<%=strFacilitySno%>";
		//parent.frames.document.forms[0].sel_facility.disabled=true;
		<%
		
	}
	else
	{
		%>
		parent.frames.document.forms[0].sel_facility.value="0";
		<%
	}
	
	if(!(strPromotorID.equalsIgnoreCase("")|| strPromotorID.equalsIgnoreCase("S")))
	{%>
	parent.frames.document.forms[0].cho_promoter.value="<%=strPromotorID%>";
	<%	}
	if(Helper.correctNull((String)request.getParameter("strChange")).equalsIgnoreCase("Y"))
	{%>
		parent.frames.document.forms[0].cho_promoter.value="S";
	<%}
	%>
	parent.frames.document.forms[0].cho_promoter.disabled=false;

	if(parent.frames.document.forms[0].hidFacgroup.value!="0")
	{
		parent.frames.document.forms[0].cmdnew.disabled=true;
		parent.frames.document.forms[0].cmdedit.disabled=true;
		parent.frames.document.forms[0].cmddelete.disabled=true;
	}
	else
	{
		if(parent.frames.document.forms[0].cmdfreeze.disabled==false && parent.frames.document.forms[0].btnenable.value=="Y")
		{
			parent.frames.document.forms[0].cmdnew.disabled=false;
		}
	}

	if(varPostSanc=="Y")
	{
		var boolflag=false;
		var varPSterms = varPostSancParam.split("@");
		for(var i=0;i<varPSterms.length;i++)
		{
			if(varPSterms[i] == "GUAR")
			{
				boolflag=true;
			}
			
		}
		if(boolflag)
		{
			<%if(!(strPromotorID.equalsIgnoreCase("")|| strPromotorID.equalsIgnoreCase("S")))
			{%>
			parent.frames.document.forms[0].cmdnew.disabled=true;
			parent.frames.document.forms[0].cmdedit.disabled=false;
			parent.frames.document.forms[0].cmddelete.disabled=false;
			<%}
			else
			{%>
			parent.frames.document.forms[0].cmdnew.disabled=false;
			parent.frames.document.forms[0].cmdedit.disabled=true;
			parent.frames.document.forms[0].cmddelete.disabled=true;
			<%}%>

			if((parent.frames.varPromotorsFreeze=="Y") || (parent.frames.varSecFreeze=="Y"))
			{
				parent.frames.document.forms[0].cmdnew.disabled=true;
				parent.frames.document.forms[0].cmdedit.disabled=true;
				parent.frames.document.forms[0].cmddelete.disabled=true;
			}
		}
	}
}
</script>
<title>Iframe - Promotors </title>
</head>
<body onload="callOnLoad();">

</body>
</html>