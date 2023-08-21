
function setGroupRights()
{
	//alert(grpRights);
	
	if(grpRights.charAt(0) == "1")
	{
		if(grpRights.charAt(8) == "w")
		{
		document.forms[0].cmdFormPerNew.disabled = false;
		document.forms[0].cmdFormPerRen.disabled = false;
		document.forms[0].cmdFormComNew.disabled = false;
		document.forms[0].cmdFormComRen.disabled = false;
		}
		else
		{
		document.forms[0].cmdFormPerNew.disabled = true;
		document.forms[0].cmdFormPerRen.disabled = true;
		document.forms[0].cmdFormComNew.disabled = true;
		document.forms[0].cmdFormComRen.disabled = true;
		}
		document.forms[0].cmdFormPerExt.disabled = false;
		document.forms[0].cmdPerRepApp.disabled  = false;
		document.forms[0].cmdFormComExt.disabled = false;
		document.forms[0].cmdPost.disabled = false;
		document.forms[0].cmdComRepApp.disabled = false;
		document.forms[0].cmdGraphical.disabled = false;
		document.forms[0].cmdPerApp.disabled=false;
		document.forms[0].cmdComApp.disabled=false;
	}
	if(grpRights.charAt(1) == "1")
	{
		document.forms[0].cmdGrps.disabled = false;
	}
	if(grpRights.charAt(2) == "1")
	{
		document.forms[0].cmdGlobal.disabled = false;
	}
	if(grpRights.charAt(3) == "1")
	{
		document.forms[0].cmdUsers.disabled = false;
	}
	if(grpRights.charAt(4) == "1")
	{
		document.forms[0].cmdIntIndex.disabled = false;
		document.forms[0].cmdDocs.disabled = false;
		document.forms[0].cmdBusiness.disabled = false;
		document.forms[0].cmdRskPer.disabled = false;
		document.forms[0].cmdOrgs.disabled = false;
		document.forms[0].cmdRskCom.disabled = false;
		document.forms[0].cmdBusiness.disabled = false;

		
	}
	if(grpRights.charAt(5) == "1")
	{
		document.forms[0].cmdPrds.disabled = false;
	}

	if(grpRights.charAt(6) == "1")
	{
		document.forms[0].cmdLoanPayOpt.disabled = false;
		document.forms[0].cmdLoanPay.disabled = false;
		document.forms[0].cmdLoanRep.disabled = false;
		document.forms[0].cmdLoanCan.disabled = false;
		document.forms[0].cmdLoanReports.disabled = false;
		document.forms[0].cmdLetters.disabled = false;
	}

	if(grpRights.charAt(7) == "1")
	{
		document.forms[0].cmdFormPerAdRep.disabled = false;
		document.forms[0].cmdFormComAdRep.disabled = false;
	}

	document.forms[0].cmdMail.disabled = false;
}