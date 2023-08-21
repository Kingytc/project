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

function loadValues()
{
	parent.frames.document.forms[0].hidifrminterestrates.value="";
	parent.frames.document.forms[0].hidifrmtoamt.value="";	
	var interesttype ="<%=interesttype%>";
	parent.frames.document.forms[0].hidifrminteresttype.value = interesttype;

	
	parent.frames.document.forms[0].txtMarginpercent.value="<%=marginper%>";
	callCalculate();	
	parent.frames.calculateLoanAmount();
	parent.frames.Eligibility_check();
}

function callnetTrade()
{

}

function callCalculate()
{	
	var varterm=trim(parent.frames.document.forms[0].txtloan_reqterms.value);
	var varcostofloan=parseFloat(roundVal(parent.frames.document.forms[0].txtloan_costloanprd.value));
	var varamtreqst=parseFloat(parent.frames.document.forms[0].txtloan_amtreqd.value);		
	if(varterm!="")
	{
		var varrecomlvr=parseFloat(parent.frames.document.forms[0].txtMarginpercent.value);
		var vardownpay;
		var varminmargin;// added by suresh for calculating minimum magin
		var varAmtrecomd;
		
		if(varamtreqst!="0.00" && !isNaN(varamtreqst))
		{
			if(varcostofloan!="0.00" && !isNaN(varcostofloan))
			{
				if(varcostofloan==varamtreqst)
				{
					
					varAmtrecomd=(100-varrecomlvr)*varamtreqst/100;
				}
				else if(varcostofloan > varamtreqst)
				{
					var costLoan = (varcostofloan * (100-varrecomlvr)/100);
					if(costLoan < varamtreqst)
					{
						varAmtrecomd = costLoan;
						vardownpay = (varcostofloan - varAmtrecomd);// + vartradein;
						varminmargin=varcostofloan*varrecomlvr/100;
					}
					else
					{
						varAmtrecomd = varamtreqst;
						vardownpay = (varcostofloan - varAmtrecomd);// + vartradein;
						varminmargin=varcostofloan*varrecomlvr/100;
					}


				}
				//parent.frames.document.forms[0].txtloan_downpay.value=roundVal(vardownpay);
				parent.frames.document.forms[0].txtloan_downpay.value=NanNumber(roundVal(varminmargin));
				//if(varActuallvr=="")
				//parent.frames.document.forms[0].actLoanValRatio.value=NanNumber(roundVal(varActuallvr));
				parent.frames.document.forms[0].txtloan_recmdamt.value=NanNumber(roundVal(varAmtrecomd));
		callStepSanc();
				
			}
			else
			{
				//alert(document.forms[0].hidCategoryType.value);
				if(document.forms[0].hidCategoryType.value=="LAD")
				{
						
				}	
				else
				  {
						if(parent.frames.document.forms[0].txtloan_costloanprd.value == "")
						{
							//ShowAlert('121',"Cost of the Project");
							parent.frames.document.forms[0].txtloan_costloanprd.value="";
							parent.frames.document.forms[0].txtloan_costloanprd.focus();
							return;
						}
				  }
			}
			
		}
		else
		{
			ShowAlert('121'," amount requested");
			parent.frames.document.forms[0].txtloan_amtreqd.value="";
			parent.frames.document.forms[0].txtloan_amtreqd.focus();
			return;
		}
	}	
	
}

function callStepUpCalculate()
{	
	
}

function callStepSanc()
{
	var costPrd = roundVal(parent.frames.document.forms[0].txtloan_costloanprd.value);
	var margin = parent.frames.document.forms[0].txtMarginpercent.value;
	
	
	parent.frames.document.forms[0].txtloan_recmdamt.value=NanNumber(roundVal(parseFloat(costPrd) - (parseFloat(costPrd)*(parseFloat(margin)/100))));
	
}
</script>
</head>

<body bgcolor="#E4E2ED" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="bfrm" method="post">
<input type="hidden" name="hidCategoryType">
 </form>
</body>
</html>
