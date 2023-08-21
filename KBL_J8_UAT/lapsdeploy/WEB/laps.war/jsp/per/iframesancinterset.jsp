<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
<%
String strint="0.00";
String strslabintrate ="";
String strslabtoamt ="";
ArrayList arrSlabIntrstval =new ArrayList();
ArrayList arrSlabToAmt = new ArrayList();
String interesttype =(String)hshValues.get("interesttype");
String marginper=Helper.correctNull((String)hshValues.get("margin_perct"));
String strcategorytype = Helper.correctNull((String) request.getParameter("hidCategoryType"));
String strPurposeid = Helper.correctNull((String) request.getParameter("hidpurpose"));

if(interesttype.equals("fixedfloating") || interesttype.equals("slabrate") || interesttype.equals("Combo"))
{	
	if(!Helper.correctNull((String)hshValues.get("prd_interest")).equals(""))
	{
		strint = Helper.correctNull((String)hshValues.get("prd_interest"));
	}
	else
	{
		strint="0.00";
	}
	
	if( interesttype.equals("slabrate"))
	{
		arrSlabIntrstval = (ArrayList)hshValues.get("slab_Tointerest");
		arrSlabToAmt = (ArrayList)hshValues.get("slab_Toamt");	 
		for(int i=0;i<arrSlabIntrstval.size();i++)
		{
			strslabintrate = strslabintrate +arrSlabIntrstval.get(i)+"^";
			strslabtoamt =strslabtoamt +arrSlabToAmt.get(i)+"^";
		}
	}
}

%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script>
var path="<%=ApplicationParams.getAppUrl()%>";
var varProductType="<%=Helper.correctNull((String)request.getParameter("varProductType"))%>"
var varPurposeCode = "<%=strPurposeid%>";
var varProposalType="<%=Helper.correctNull((String)session.getAttribute("strAppType"))%>";
function loadValues()
{
	if(varProposalType=="P")
	{
		if(parent.frames.document.forms[0].sel_mclrtype.value!="")
		{

			parent.frames.document.forms[0].hidcreditrskpremium.value="<%=Helper.correctDouble((String)hshValues.get("prd_creditrskpremium"))%>";
			parent.frames.document.forms[0].hidbusstrategicpremium.value="<%=Helper.correctDouble((String)hshValues.get("prd_busstrategicpremium"))%>";

			if(parent.frames.document.forms[0].hidcreditrskpremium.value=="0.00" && parent.frames.document.forms[0].hidbusstrategicpremium.value=="0.00")
			{
				if(varProductType=="pR")
				{
					parent.frames.document.forms[0].txtloan_modintrate.value = "0.00";
					return;
				}
			}
			

			var varspread=0;
			var varvalue=parent.frames.document.forms[0].sel_mclrtype.value;
			var vararr=varvalue.split("@");
			if(vararr!=null)
			{
				varspread=vararr[1];
				parent.frames.document.forms[0].hidMCLRTableCode.value=vararr[2];
				parent.frames.document.forms[0].hidBaserate.value=vararr[1];
			}

			varspread=parseFloat(varspread)+
			parseFloat(parent.frames.document.forms[0].hidcreditrskpremium.value)
			+parseFloat(parent.frames.document.forms[0].hidbusstrategicpremium.value);

			parent.frames.document.forms[0].txtloan_modintrate.value = varspread;
		}
		
		parent.frames.document.forms[0].hidInterestIndexId.value="<%=Helper.correctNull((String)hshValues.get("prd_interestid"))%>";
	}
	else
	{
		var interesttype ="<%=interesttype%>";
	
	
	
			if(parent.frames.document.forms[0].hidInterestType.value!="Floating")
			{
	
				if(varProductType!="pR")
				{
					if("<%=strint%>"==0.00)
					{
						parent.frames.document.forms[0].txtloan_modintrate.value = "";
						alert("Interest for Selected Interest Type is not defined in the product");
						return;
					}
				}
				
				parent.frames.document.forms[0].txtloan_modintrate.value = "<%=strint%>";
				parent.frames.document.forms[0].hidcreditrskpremium.value="";
				parent.frames.document.forms[0].hidbusstrategicpremium.value="";	
				parent.frames.document.forms[0].hidmclrrate.value="<%=Helper.correctNull((String)hshValues.get("prd_baserate"))%>";
			}
			else
			{
				if(parent.frames.document.forms[0].sel_mclrtype.value!="")
				{
	
					parent.frames.document.forms[0].hidcreditrskpremium.value="<%=Helper.correctDouble((String)hshValues.get("prd_creditrskpremium"))%>";
					parent.frames.document.forms[0].hidbusstrategicpremium.value="<%=Helper.correctDouble((String)hshValues.get("prd_busstrategicpremium"))%>";
	
					if(parent.frames.document.forms[0].hidcreditrskpremium.value=="0.00" && parent.frames.document.forms[0].hidbusstrategicpremium.value=="0.00")
					{
						//alert("Credit Risk Premium & Business Strategic Premium values are zero");
						if(varProductType=="pR")
						{
							parent.frames.document.forms[0].txtloan_modintrate.value = "0.00";
							return;
						}
					}
					
					var varspread=0;
					var varvalue=parent.frames.document.forms[0].sel_mclrtype.value;
					var vararr=varvalue.split("@");
					if(vararr!=null)
					{
						varspread=vararr[1];
					}
	
					varspread=parseFloat(varspread)+
					parseFloat(parent.frames.document.forms[0].hidcreditrskpremium.value)
					+parseFloat(parent.frames.document.forms[0].hidbusstrategicpremium.value);
	
					parent.frames.document.forms[0].txtloan_modintrate.value = varspread;
				}
			}
			parent.frames.document.forms[0].hidInterestIndexId.value="<%=Helper.correctNull((String)hshValues.get("prd_interestid"))%>";
		} 

	parent.frames.document.all.id_interest.innerHTML=roundVal(parent.frames.document.forms[0].txtloan_modintrate.value);

	if(parent.frames.document.forms[0].hiddevintRate.value!="")
	{
		parent.frames.document.all.id_interest.innerHTML=roundVal(parent.frames.document.forms[0].hiddevintRate.value);
		parent.frames.document.forms[0].txtloan_modintrate.value=roundVal(parent.frames.document.forms[0].hiddevintRate.value);
	}
	parent.frames.calcemi();
		
}

</script>
</head>

<body bgcolor="#E4E2ED" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
</body>
</html>
