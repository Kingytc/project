<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript1.2"> 
	 var appURL = "<%=ApplicationParams.getAppUrl()%>";
	 </script>
<script>
var nfiles="<%=Helper.correctNull((String)hshValues.get("nofiles"))%>";
var type="<%=Helper.correctNull((String)hshValues.get("type"))%>";
var goodfile="<%=Helper.correctNull((String)hshValues.get("goodfile"))%>";
var badfile="<%=Helper.correctNull((String)hshValues.get("badfile"))%>";
var badrow="<%=Helper.correctNull((String)hshValues.get("badrow"))%>";
var varexported="<%=Helper.correctNull((String)hshValues.get("strexported"))%>";

function Interfacemsg()
{
	if((!(nfiles=="" && type=="")) &&(goodfile!="" && badfile!=""))
	{
	if(nfiles=="0")
	nfiles="0"+" (No Files In The Folder To Import)";
	if(badfile=="0")badrow="0";
	
	
	alert("\n\nFlat File Type :"+type+"\n\n"+"Total No Of Files :"+nfiles +" \n Readed File(s) :"+goodfile +"\n  Bad File(s) :"+badfile+"\n Bad Row No:"+badrow);
	}

	 if(varexported == 'Y'){
	        alert(" All User's Password is Reset, while Login Please change the Password ");
	 }
}


function doClose()
{
if(confirm("Are you sure to close this window ?"))
{
document.forms[0].action="action/interfacenav.jsp";
document.forms[0].submit();

}
}


function createIndustryMasterFile()
{
if(confirm("Export Industry Master?"))
{
		document.forms[0].hidBeanId.value="LapsToRam";
		document.forms[0].hidBeanGetMethod.value="industryMaster";
		document.forms[0].hidSourceUrl.value="/action/interfacerammain.jsp";
		document.forms[0].action=appURL+"controllerservlet";	
		document.forms[0].submit();
}

}

function createGroupMasterFile()
{
if(confirm("Export Group Master?"))
{
		document.forms[0].hidBeanId.value="LapsToRam";
		document.forms[0].hidBeanGetMethod.value="groupMaster";
		document.forms[0].hidSourceUrl.value="/action/interfacerammain.jsp";
		document.forms[0].action=appURL+"controllerservlet";	
		document.forms[0].submit();
		}
}

function readSectorMasterFile()
{
	if(confirm("Import Sector Master?"))
{
		document.forms[0].hidBeanId.value="RAMTOLAPS";
		document.forms[0].hidBeanGetMethod.value="ramtolaps_sectormaster";
		document.forms[0].hidSourceUrl.value="/action/interfacerammain.jsp";
		document.forms[0].action=appURL+"controllerservlet";	
		document.forms[0].submit();
		}
}

function readCountryMasterFile()
{
		if(confirm("Import Country Master?"))
{
		document.forms[0].hidBeanId.value="RAMTOLAPS";
		document.forms[0].hidBeanGetMethod.value="ramtolaps_countrymaster";
		document.forms[0].hidSourceUrl.value="/action/interfacerammain.jsp";
		document.forms[0].action=appURL+"controllerservlet";	
		document.forms[0].submit();
	}
}

function readSegmentMasterFile()
{
	if(confirm("Import Market Segment Master?"))
{
		document.forms[0].hidBeanId.value="RAMTOLAPS";
		document.forms[0].hidBeanGetMethod.value="ramtolaps_marketsegmentmaster";
		document.forms[0].hidSourceUrl.value="/action/interfacerammain.jsp";
		document.forms[0].action=appURL+"controllerservlet";	
		document.forms[0].submit();
}
}

function readClassificationMaster()
{
		if(confirm("Import Asset Classification Master?"))
{
		document.forms[0].hidBeanId.value="RAMTOLAPS";
		document.forms[0].hidBeanGetMethod.value="ramtolaps_assetclassmaster";
		document.forms[0].hidSourceUrl.value="/action/interfacerammain.jsp";
		document.forms[0].action=appURL+"controllerservlet";	
		document.forms[0].submit();
		}
}

function readRBIIndustryMaster()
{
		if(confirm("Import RBI Industry Master?"))
{
		document.forms[0].hidBeanId.value="RAMTOLAPS";
		document.forms[0].hidBeanGetMethod.value="ramtolaps_RBIindustrymaster";
		document.forms[0].hidSourceUrl.value="/action/interfacerammain.jsp";
		document.forms[0].action=appURL+"controllerservlet";	
		document.forms[0].submit();
		}
}

function readretailscoring()
{
		if(confirm("Import Retail Scoring?"))
{

		document.forms[0].hidBeanId.value="RAMTOLAPS";
		document.forms[0].hidBeanGetMethod.value="ramtolaps_retailscoring";
		document.forms[0].hidSourceUrl.value="/action/interfacerammain.jsp";
		document.forms[0].action=appURL+"controllerservlet";	
		document.forms[0].submit();
}
}

function createChargeMasterFile()
{
	if(confirm("Export Charge Master?"))
	{
		document.forms[0].hidBeanId.value="LapsToRam";
		document.forms[0].hidBeanGetMethod.value="createChargeMaster";
		document.forms[0].hidSourceUrl.value="/action/interfacerammain.jsp";
		document.forms[0].action=appURL+"controllerservlet";	
		document.forms[0].submit();
	}
}

function createSecurityMasterFile()
{
	if(confirm("Export Security Master?"))
	{
		document.forms[0].hidBeanId.value="LapsToRam";
		document.forms[0].hidBeanGetMethod.value="createSecurityMaster";
		document.forms[0].hidSourceUrl.value="/action/interfacerammain.jsp";
		document.forms[0].action=appURL+"controllerservlet";	
		document.forms[0].submit();
	}
}

function createFacilityMasterFile()
{
	if(confirm("Export Facility Master?"))
	{
		document.forms[0].hidBeanId.value="LapsToRam";
		document.forms[0].hidBeanGetMethod.value="createFacilityMaster";
		document.forms[0].hidSourceUrl.value="/action/interfacerammain.jsp";
		document.forms[0].action=appURL+"controllerservlet";	
		document.forms[0].submit();
	}
}
function createExportIRBUsers() {
	
	if(confirm("Export IRB Users")) {

		document.forms[0].hidBeanId.value="LapsToRam";
		document.forms[0].hidBeanGetMethod.value="updateIRBData";
		document.forms[0].hidSourceUrl.value="/action/interfacerammain.jsp";
		document.forms[0].action=appURL+"controllerservlet";	
		document.forms[0].submit();
   
	}		
}
</script>
</head>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<body onLoad="Interfacemsg()">

<form name=form1 class="normal">
<br><br><br>
<table class="outertable border1" width="60%" border="0" align="center" cellpadding="5" cellspacing="0" >
  <tr> 
    <td  colspan="2"> 
      <div align="center"><b>INTERFACE FOR IRB</b></div>
    </td>
  </tr>
  
  <td width="30%" align=center><strong>IMPORT FROM IRB </strong></td><td width="30%" align="center"><strong>EXPORT TO IRB</strong></td>
  </tr>
 
                  <tr align=center> 
                    <td><b>
                      <input type="button" class="buttonothers" name="cmdsectormaster" value="Sector Master" onClick="readSectorMasterFile()" >
                      </b></td>
                      <td>&nbsp;
                      </td>
                  </tr>
                  <tr align=center> 
                    <td height="0" nowrap><b>
                      <input type="button" class="buttonothers" name="Submit4" value="Market Segment Master" onClick="readSegmentMasterFile()" >
                      </b></td><td>                      <input type="button" class="buttonothers" name="cmdgroupmaster" value="Group Master" onClick="createGroupMasterFile()" ></td>
                  </tr>
                  
                  <tr align=center> 
                    <td height="0"><b>
                      <input type="button" class="buttonothers" name="Submit5" value="Asset Classification Master" onClick="readClassificationMaster()" >
                      </b></td><td>                      <input type="button" class="buttonothers" name="cmdchargemaster" value="Charge Master" onClick="createChargeMasterFile()" ></td>
                  
                  </tr>
				  
				  <tr align=center> 
                    <td height="0"><b>
                      <input type="button" class="buttonothers" name="cmdcountrymaster" value="Country Master" onClick="readCountryMasterFile()" >
                      </b></td><td>                      <input type="button" class="buttonothers" name="cmdsecuritymaster" value="Security Master" onClick="createSecurityMasterFile()" ></td>
                  
                  </tr>
                  
				  <tr align=center> 
                    <td height="0"><b>
                      <input type="button" class="buttonothers" name="cmdrbiindustrymaster" value="RBI Industry Master" onClick="readRBIIndustryMaster()" >
                      </b></td><td>                      <input type="button" class="buttonothers" name="cmdfacilitymaster" value="Facility Master" onClick="createFacilityMasterFile()" ></td>
                  
                  </tr>
				
				  
                  
  
  </table>
  <br>
   <lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
  
  <lapschoice:hiddentag pageid='<%=PageId%>'/> 
</form>
</body>
</html>
