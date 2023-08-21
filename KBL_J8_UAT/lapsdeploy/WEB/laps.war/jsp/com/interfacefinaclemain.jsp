<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Finacle Interface(LAPS)</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>

var appURL = "<%=ApplicationParams.getAppUrl()%>";
var nfiles="<%=Helper.correctNull((String)hshValues.get("filecount"))%>";
var type="<%=Helper.correctNull((String)hshValues.get("type"))%>";
var goodfile="<%=Helper.correctNull((String)hshValues.get("goodfile"))%>";
var badfile="<%=Helper.correctNull((String)hshValues.get("badfile"))%>";


function doClose()
{
if(confirm("Are you sure to close this window ?"))
{
document.forms[0].action="action/interfacenav.jsp";
document.forms[0].submit();

}
}

function Interfacemsg()
{
	if((!(nfiles=="" && type=="")) &&( goodfile!="" && badfile!=""))
	{
	if(nfiles=="0")nfiles="0"+" (No Files In The Folder To Import)";
	alert("\n\nFlat File Type :"+type+"\n\n"+"Total No Of Files :"+nfiles +" \n Read File(s) :"+goodfile +"\n  Bad File(s) :"+badfile );
	}
	if((!(nfiles=="" && type=="")) && (goodfile=="" && badfile=="") )
	{
	alert("\n\nFlat File Type :"+type+"\n\n"+"Total No Of Files :"+nfiles);
	}

}
function callFunction(pagename)
{
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].submit();
}

function readCCTLODdetails()
{
		if(confirm("Import CCTLOD DETAILS ?"))
		{
	    document.forms[0].hidBeanId.value="FinacleBean";
		//document.forms[0].hidBeanMethod.value="OneTime_CC_TL_OD_Details";
		document.forms[0].hidBeanGetMethod.value="OneTime_CC_TL_OD_Details";
		document.forms[0].hidSourceUrl.value="/action/interfacefinaclemain.jsp";
		document.forms[0].action=appURL+"controllerservlet";	
		document.forms[0].submit();
		}
}

function readGuranteedetails()
{
		if(confirm("Import GUARANTEE DETAILS ?"))
		{
		document.forms[0].hidBeanId.value="FinacleBean";
		//document.forms[0].hidBeanMethod.value="OneTime_Guarantee";
		document.forms[0].hidBeanGetMethod.value="OneTime_Guarantee";
		document.forms[0].hidSourceUrl.value="/action/interfacefinaclemain.jsp";
		document.forms[0].action=appURL+"controllerservlet";	
		document.forms[0].submit();
	 }

}
function readBillsdetails()
{
	if(confirm("Import BILLS DETAILS ?"))
	{
		document.forms[0].hidBeanId.value="FinacleBean";
		//document.forms[0].hidBeanMethod.value="OneTime_Guarantee";
		document.forms[0].hidBeanGetMethod.value="OneTime_Bills";
		document.forms[0].hidSourceUrl.value="/action/interfacefinaclemain.jsp";
		document.forms[0].action=appURL+"controllerservlet";	
		document.forms[0].submit();
	}	
}
function readletterofcreditdetails()
{
		if(confirm("Import LETTER OF CREDIT DETAILS ?"))
		{
		document.forms[0].hidBeanId.value="FinacleBean";
		document.forms[0].hidBeanGetMethod.value="OneTime_LC";
		document.forms[0].hidSourceUrl.value="/action/interfacefinaclemain.jsp";
		document.forms[0].action=appURL+"controllerservlet";	
		document.forms[0].submit();
		}


}
function readccttoddetails()
{

		if(confirm("Import CCTTOD DETAILS?"))
		{
		document.forms[0].hidBeanId.value="FinacleBean";
		document.forms[0].hidBeanGetMethod.value="daily_OD_CC_TL_Details";
		document.forms[0].hidSourceUrl.value="/action/interfacefinaclemain.jsp";
		document.forms[0].action=appURL+"controllerservlet";	
		document.forms[0].submit();
	}

}

function readdailyguarantee()
{
		if(confirm("Import Daily basis GuaranteeDetails ?"))
	{
		document.forms[0].hidBeanId.value="FinacleBean";
		document.forms[0].hidBeanGetMethod.value="daily_Guarantee";
		document.forms[0].hidSourceUrl.value="/action/interfacefinaclemain.jsp";
		document.forms[0].action=appURL+"controllerservlet";	
		document.forms[0].submit();
	}	


}
function readdailyCCPC()
{
			if(confirm("Import Daily basis CCPC Details ?"))
	{
	

		document.forms[0].hidBeanId.value="FinacleBean";
		document.forms[0].hidBeanGetMethod.value="daily_CCPC_Details";
		document.forms[0].hidSourceUrl.value="/action/interfacefinaclemain.jsp";
		document.forms[0].action=appURL+"controllerservlet";	
		document.forms[0].submit();
	}


}

function readdailybills()
{

			if(confirm("Import Daily basis BILLS Details ?"))
	{
	

		document.forms[0].hidBeanId.value="FinacleBean";
		document.forms[0].hidBeanGetMethod.value="daily_bills_Details";
		document.forms[0].hidSourceUrl.value="/action/interfacefinaclemain.jsp";
		document.forms[0].action=appURL+"controllerservlet";	
		document.forms[0].submit();
	}



}

function readdailyletterofcredit()
{

	if(confirm("Import Daily basis LETTER OF CREDIT Details ?"))
	{
	

		document.forms[0].hidBeanId.value="FinacleBean";
		document.forms[0].hidBeanGetMethod.value="daily_letterofcredit_Details";
		document.forms[0].hidSourceUrl.value="/action/interfacefinaclemain.jsp";
		document.forms[0].action=appURL+"controllerservlet";	
		document.forms[0].submit();
	}
}

function readnpapresent()
{
	if(confirm("Import NPA Present Position Details?"))
		{
			document.forms[0].hidBeanId.value="FinacleBean";
			document.forms[0].hidBeanGetMethod.value="NPAPresentPosition";
			document.forms[0].hidSourceUrl.value="/action/interfacefinaclemain.jsp";
			document.forms[0].action=appURL+"controllerservlet";	
			document.forms[0].submit();
		}
}

function readnpabasic()
{
	if(confirm("Import NPA Basic Details?"))
		{
			document.forms[0].hidBeanId.value="FinacleBean";
			document.forms[0].hidBeanGetMethod.value="NPABasic";
			document.forms[0].hidSourceUrl.value="/action/interfacefinaclemain.jsp";
			document.forms[0].action=appURL+"controllerservlet";	
			document.forms[0].submit();
		}
}

function readnpapromoter()
{
	if(confirm("Import NPA promoter Details ?"))
		{
			document.forms[0].hidBeanId.value="FinacleBean";
			document.forms[0].hidBeanGetMethod.value="NPAPromoter";
			document.forms[0].hidSourceUrl.value="/action/interfacefinaclemain.jsp";
			document.forms[0].action=appURL+"controllerservlet";	
			document.forms[0].submit();
		}
}
function readmondbc()
{
	if(confirm("Import DBC Details ?"))
		{
			document.forms[0].hidBeanId.value="FinacleBean";
			document.forms[0].hidBeanGetMethod.value="mondbcreader";
			document.forms[0].hidSourceUrl.value="/action/interfacefinaclemain.jsp";
			document.forms[0].action=appURL+"controllerservlet";	
			document.forms[0].submit();
		}
}

function readmoninterest()
{
	if(confirm("Import interest Details ?"))
		{
			document.forms[0].hidBeanId.value="FinacleBean";
			document.forms[0].hidBeanGetMethod.value="moninterestreader";
			document.forms[0].hidSourceUrl.value="/action/interfacefinaclemain.jsp";
			document.forms[0].action=appURL+"controllerservlet";	
			document.forms[0].submit();
		}
}

function readpackingcredit()
{
	if(confirm("Import packing credit Details ?"))
		{
			document.forms[0].hidBeanId.value="FinacleBean";
			document.forms[0].hidBeanGetMethod.value="monpackingcreditreader";
			document.forms[0].hidSourceUrl.value="/action/interfacefinaclemain.jsp";
			document.forms[0].action=appURL+"controllerservlet";	
			document.forms[0].submit();
		}
}

function readinstallment()
{
	if(confirm("Import installments Details ?"))
		{
			document.forms[0].hidBeanId.value="FinacleBean";
			document.forms[0].hidBeanGetMethod.value="moninstallmentsreader";
			document.forms[0].hidSourceUrl.value="/action/interfacefinaclemain.jsp";
			document.forms[0].action=appURL+"controllerservlet";	
			document.forms[0].submit();
		}
}

function readletterofcredit()
{
	if(confirm("Import letter of cr Details ?"))
		{
			document.forms[0].hidBeanId.value="FinacleBean";
			document.forms[0].hidBeanGetMethod.value="monletterofcreditreader";
			document.forms[0].hidSourceUrl.value="/action/interfacefinaclemain.jsp";
			document.forms[0].action=appURL+"controllerservlet";	
			document.forms[0].submit();
		}
}

function readdocumentregister()
{
	if(confirm("Import Document Register Details ?"))
		{
			document.forms[0].hidBeanId.value="FinacleBean";
			document.forms[0].hidBeanGetMethod.value="mondocumentregister";
			document.forms[0].hidSourceUrl.value="/action/interfacefinaclemain.jsp";
			document.forms[0].action=appURL+"controllerservlet";	
			document.forms[0].submit();
		}
}




function readnpadocument()
{
	if(confirm("Import NPA document Details ?"))
		{
			document.forms[0].hidBeanId.value="FinacleBean";
			document.forms[0].hidBeanGetMethod.value="NPADocument";
			document.forms[0].hidSourceUrl.value="/action/interfacefinaclemain.jsp";
			document.forms[0].action=appURL+"controllerservlet";	
			document.forms[0].submit();
		}
}

function readnpasecurity()
{
	if(confirm("Import NPA Security Details ?"))
	{
		document.forms[0].hidBeanId.value="FinacleBean";
		document.forms[0].hidBeanGetMethod.value="NPASecurities";
		document.forms[0].hidSourceUrl.value="/action/interfacefinaclemain.jsp";
		document.forms[0].action=appURL+"controllerservlet";	
		document.forms[0].submit();
	}
}
function readMonfundbased()
{
	if(confirm("Import Monitoring fund based Details ?"))
	{
		document.forms[0].hidBeanId.value="FinacleBean";
		document.forms[0].hidBeanGetMethod.value="MonFundBased";
		document.forms[0].hidSourceUrl.value="/action/interfacefinaclemain.jsp";
		document.forms[0].action=appURL+"controllerservlet";	
		document.forms[0].submit();
	}



}

function readmonbills()
{
	if(confirm("Import Monitoring bills Details ?"))
	{
		document.forms[0].hidBeanId.value="FinacleBean";
		document.forms[0].hidBeanGetMethod.value="MONBills";
		document.forms[0].hidSourceUrl.value="/action/interfacefinaclemain.jsp";
		document.forms[0].action=appURL+"controllerservlet";	
		document.forms[0].submit();
	}


}

function readmonguarantee()
{
	if(confirm("Import Monitoring Guarantee Details ?"))
	{
		document.forms[0].hidBeanId.value="FinacleBean";
		document.forms[0].hidBeanGetMethod.value="MONGuarantee";
		document.forms[0].hidSourceUrl.value="/action/interfacefinaclemain.jsp";
		document.forms[0].action=appURL+"controllerservlet";	
		document.forms[0].submit();
	}


}



function readmoninsurance()
{
	if(confirm("Import Monitoring Insurance Details ?"))
	{
		document.forms[0].hidBeanId.value="FinacleBean";
		document.forms[0].hidBeanGetMethod.value="MONInsurance";
		document.forms[0].hidSourceUrl.value="/action/interfacefinaclemain.jsp";
		document.forms[0].action=appURL+"controllerservlet";	
		document.forms[0].submit();
	}


}

function readpersonalinfo()
{

		if(confirm("Import Personal Info Details?"))
		{
		document.forms[0].hidBeanId.value="FinacleBean";
		document.forms[0].hidBeanGetMethod.value="MonPersonalProfile";
		document.forms[0].hidSourceUrl.value="/action/interfacefinaclemain.jsp";
		document.forms[0].action=appURL+"controllerservlet";	
		document.forms[0].submit();
	}

}
function readMonlimitregister()
{

		if(confirm("Import Limit Register Details?"))
		{
		document.forms[0].hidBeanId.value="FinacleBean";
		document.forms[0].hidBeanGetMethod.value="MonLimitRegister";
		document.forms[0].hidSourceUrl.value="/action/interfacefinaclemain.jsp";
		document.forms[0].action=appURL+"controllerservlet";	
		document.forms[0].submit();
	}

}

function readconsortium()
{

		if(confirm("Import Consortium Details?"))
		{
		document.forms[0].hidBeanId.value="FinacleBean";
		document.forms[0].hidBeanGetMethod.value="MonConsortium";
		document.forms[0].hidSourceUrl.value="/action/interfacefinaclemain.jsp";
		document.forms[0].action=appURL+"controllerservlet";	
		document.forms[0].submit();
	}

}

function AppStatus()
{
	var purl ="<%=ApplicationParams.getAppUrl()%>action/appstatus_flatfile.jsp";
	var prop = 'scrollbars=yes,menubar=yes,width=575,height=220';	
	var xpos = (screen.width - 575) / 2;
	var ypos = (screen.height - 220) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'title',prop);
}
function doPredisbursementDetails()
{
	var purl ="<%=ApplicationParams.getAppUrl()%>action/com_predisbursementflatfile.jsp";
	var prop = 'scrollbars=yes,menubar=yes,width=575,height=220';	
	var xpos = (screen.width - 575) / 2;
	var ypos = (screen.height - 220) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'title',prop);
}
function SuitFile()
{
	var purl ="<%=ApplicationParams.getAppUrl()%>action/suitefile_flatfile.jsp";
	var prop = 'scrollbars=yes,menubar=yes,width=575,height=220';	
	var xpos = (screen.width - 575) / 2;
	var ypos = (screen.height - 220) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'title',prop);
}

function banking()
{
	var purl ="<%=ApplicationParams.getAppUrl()%>action/mon_banktypeflatfile.jsp";
	var prop = 'scrollbars=yes,menubar=yes,width=575,height=220';	
	var xpos = (screen.width - 575) / 2;
	var ypos = (screen.height - 220) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'title',prop);
}
function AdvAccount()
{
	var purl ="<%=ApplicationParams.getAppUrl()%>action/advaccount_flatfile.jsp";
	var prop = 'scrollbars=yes,menubar=yes,width=575,height=220';	
	var xpos = (screen.width - 575) / 2;
	var ypos = (screen.height - 220) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'title',prop);
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
</head>

<body onLoad="Interfacemsg()">
<form name="form1" class="normal">
<br>
<br>
 <table class="outertable" width="75%" border="1" align="center" cellpadding="5" cellspacing="0" bordercolor="">
    <tr> 
      <td colspan="3" > 
        <div align="center"><b> FOR FINACLE INTERFACE</b></div>
      </td>
    </tr>
    <tr> 
      <td align="center" colspan="3"> 
        <b>Daily Basis Import</b> </td>
    </tr>
    <tr> 
      <td align="center" > 
      &nbsp;</td>
      <td align="center" >
        <input type="button" name="cmdAppStatus" value="Application Status " onClick="AppStatus()" class="buttonothers">
      </td>
      <td>&nbsp;</td>
    </tr>
	<tr>
      <td align="center"  > 
        <input type="button" name="cmdSuitFile"
			value="Suit Filed Details" onClick="SuitFile()" class="buttonothers"></td>
      <td align="center"  > 
        <input type="button" name="cmdPredisbursement" value="Pre-disbursement Details" onClick="doPredisbursementDetails()" class="buttonothers">
		</td>
      <td align="center"  > 
        <input type="button" name="cmdbank" value="Multiple/Consortium Details" onClick="banking()" class="buttonothers" style="width:165">
		</td>
	</tr>
	<tr>
      <td align="center" >
<input type="button" name="cmdAdvAcc"
			value="Advances Account" onClick="AdvAccount()" class="buttonothers"></td>
      <td >&nbsp;</td>
      <td >&nbsp;</td>
	</tr>
  </table>
  <br>
 <lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
</form>
</body>

</html>