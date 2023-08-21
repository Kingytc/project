<%@include file="../share/directives.jsp"%>
<html>
<%
ArrayList arrRow = new ArrayList();
ArrayList arrCol = new ArrayList();
%>
<head>
<title>Re Appraiser Details</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varappdate="<%=Helper.correctNull((String)hshValues.get("ja_appraiseon"))%>";
var currentDate="<%=Helper.getCurrentDateTime()%>";
var varuserclass = "<%=Helper.correctNull((String)hshValues.get("strUserClass"))%>";
var varuserClassMaker = "<%=Helper.correctNull((String)hshValues.get("GOLD_MAKER"))%>";
var varuserClassChecker = "<%=Helper.correctNull((String)hshValues.get("GOLD_CHEKER"))%>";
var varappdone =  "<%=Helper.correctNull((String)hshValues.get("GOLD_REAPPBY"))%>";

var alreadyCbsId = "<%=Helper.correctNull((String)hshValues.get("ja_appraisercbsid"))%>";

var appnon="<%=Helper.correctNull((String)hshValues.get("strappno"))%>";
var strappstatus="<%=Helper.correctNull((String)hshValues.get("strappstatus"))%>";
var date="<%=Helper.correctNull((String)hshValues.get("date"))%>";
var apprainame="<%=Helper.correctNull((String)hshValues.get("ja_appraisercbsid"))%>";
var gold_userid="<%=Helper.correctNull((String)hshValues.get("GOLD_USERID"))%>";
var userid="<%=Helper.correctNull((String)hshValues.get("strUserId"))%>";
var checkid="<%=Helper.correctNull((String)hshValues.get("checkid"))%>";
var appraisernamecurrent="<%=Helper.correctNull((String)hshValues.get("appraisernamecurrent"))%>";
var cbsid="<%=Helper.correctNull((String)hshValues.get("cbsid"))%>";
var STATUS = "<%=Helper.correctNull((String)hshValues.get("STATUS"))%>";
var appno = "<%=Helper.correctNull((String)hshValues.get("appno"))%>";
var appstatus="<%=Helper.correctNull((String)hshValues.get("appstatus"))%>";
var rejectremarks= "<%=Helper.correctNull((String)hshValues.get("REASON_FOR_REJECT"))%>";
function doClose()
{
 	window.close();
} 
function callCalender(fname)
{
	if(document.forms[0].cmdsave.disabled == false)
	{
	 showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	}
}
function doEdit()
{
	disableFields(false);	
	//document.forms[0].hidAction.value ="insert";
	enableButtons(true,false,false,false,true,true,true);	

}
function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6,bool7)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;	
	document.forms[0].cmddelete.disabled=bool4;  	
	document.forms[0].cmdclose.disabled=bool5;
	document.forms[0].cmdapprove.disabled=bool6;
	document.forms[0].cmdreject.disabled=bool7;
}

function doSave()
{
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	//var le = document.forms[0].txt_comments.length;
	//for(var i=0;i<le;i++)
	//{
	//	if(checktrim(document.forms[0].txt_comments[i].value) == "")
	//	{
	//		alert("Please Enter comments !!");
	//		document.forms[0].txt_comments[i].focus();
	//		return false;
	//	}
	//}
	if(document.forms[0].txt_appraisername.value=="")
	{
		alert("Please Enter Re - Appraiser Name");
	 	document.forms[0].txt_appraisername.focus();
	 	return false;
	}
	if(document.forms[0].txt_appraisedon.value=="")
	{
		alert("Please Choose Re - Appraised on");
	 	document.forms[0].txt_appraisedon.focus();
	 	return false;
	}
	if(validateSameAppraisal())
	{
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="agrotherassets";
		document.forms[0].hidBeanMethod.value="updateGoldReAppraiserdet";
		document.forms[0].hidBeanGetMethod.value="getGoldReAppraiserdet";
		document.forms[0].hidSourceUrl.value="/action/gold_reappraisal.jsp";
		document.forms[0].submit();
	}

}
function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="agrotherassets";
		document.forms[0].hidBeanGetMethod.value="getGoldReAppraiserdet";
		document.forms[0].action=appURL+"action/gold_reappraisal.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	 }
	
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=val;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}	
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
	}	
}
function onloading()
{
	
	disableFields(true);
    if(parseInt(varuserclass) >= parseInt(varuserClassChecker)&&checkid=="Y")
	{
		document.forms[0].cmdedit.disabled = false;	
		document.forms[0].cmdapprove.disabled=false;
		document.forms[0].cmdreject.disabled=false;
	}
    else if (parseInt(varuserclass) >= parseInt(varuserClassMaker)&&checkid=="Y")
    {
      document.forms[0].cmdedit.disabled = false;	
  	  document.forms[0].cmdapprove.disabled=true;
  	  document.forms[0].cmdreject.disabled=true;
    }
    
	else
	{
		document.forms[0].cmdedit.disabled = true;	
		document.forms[0].cmdapprove.disabled=true;
		document.forms[0].cmdreject.disabled=true;
	}
	if(varappdone!="")
	{
		document.forms[0].cmdedit.disabled = true;	
		document.forms[0].cmdapprove.disabled=true;
		document.forms[0].cmdreject.disabled=true;
	}
	
}
function checkuserid()
{
	if(gold_userid==userid)
	{
		
		document.forms[0].cmdedit.disabled = false;	
		document.forms[0].cmdapprove.disabled=true;
		document.forms[0].cmdreject.disabled=true;
	}
	if(STATUS=="pa")
	{
		document.forms[0].cmdedit.disabled = true;
		document.all.certificateofgold.style.visibility="visible";
		document.all.certificateofgold.style.position="relative";
	}
	if(STATUS!="pr")
	{
		document.forms[0].cmdnew.style.visibility="hidden";
		document.forms[0].cmdnew.style.position="absolute";
		document.all.idRejectremark.style.visibility="hidden";
		document.all.idRejectremark.style.position="absolute";
		
			
	}
	else
	{
		document.forms[0].cmdnew.disabled = false;	
		document.forms[0].cmdedit.disabled = true;
		document.all.idRejectremark.style.visibility="visible";
		document.all.idRejectremark.style.position="relative";	
		document.forms[0].remarks.value  =	rejectremarks;
	}
}
function doNew()
{
	document.forms[0].cmdnew.disabled = true; 

	var le = document.forms[0].txt_comments.length;
	for(var i=0;i<le;i++)
	{
		document.forms[0].txt_comments[i].value = "";
	}
	document.forms[0].txt_comments.value="";
	document.forms[0].txt_appraisername.value="";
	document.forms[0].txt_appraisedon.value="";
	document.all.idRejectremark.style.visibility="hidden";
	document.all.idRejectremark.style.position="absolute";
	document.forms[0].remarks.value="";
	
	disableFields(false);	
	enableButtons(true,false,false,false,true,true,true);	
}

function doDelete()
{
	if(ConfirmMsg(101))
	{	
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="agrotherassets";
		document.forms[0].hidBeanMethod.value="updateGoldReAppraiserdet";
		document.forms[0].hidBeanGetMethod.value="getGoldReAppraiserdet";
		document.forms[0].hidSourceUrl.value="/action/gold_reappraisal.jsp";
		document.forms[0].submit();
	
	}
}
function showAppraiserName()
{	
	//alert(apprainame);
	//alert(ValuersMaster);
	//alert(reappraiser);
	if(document.forms[0].cmdsave.disabled == false)
	{
		
		var action=document.forms[0].hidAction.value;	
		var prop = "scrollbars=yes,width=500,height=400,top=100,left=250";
		var url=appURL+"action/valuerslist.jsp?hidBeanId=staticdata&hidBeanGetMethod=getValuerMasterListList&apprainame="+apprainame+"&hidAction=search&strfrom=ValuersMaster&hidAppVal="+"J&appraiser="+"reappraiser";
		window.open(url,"",prop);
	}
}
function allowalwysOldDate(obj,mindate)
{
	var pagedate=obj.value;
	var pgdt=changeDateformat(pagedate);
	var mindt=changeDateformat(mindate);
	var varc = changeDateformat(currentDate);
	if(obj.value!="")
	{
		if(Date.parse(pgdt) <= Date.parse(mindt))
		{
			alert("Re-Appraisal Date Can not be less than or equal to previous appraisal date as " + mindate);
			obj.value="";
			obj.focus();
			return false;
		}
	}
	if(Date.parse(pgdt) > Date.parse(varc))
	{
		alert("Re-Appraisal Date Can not be future date");
		obj.value="";
		obj.focus();
		return false;
	}
		
		
	return true;
}
function doApprove()
{
	disableFields(false);
	//var le = document.forms[0].txt_comments.length;
	//for(var i=0;i<le;i++)
	//{
	//	if(checktrim(document.forms[0].txt_comments[i].value) == "")
	//	{
	//		alert("Please send proposal to maker for enter comments !!");
	//		return false;
	//	}
	//}
	if(document.forms[0].txt_appraisername.value=="")
	{
		alert("Please send proposal to maker Enter Re - Appraiser Name");
	 	return false;
	}
	if(document.forms[0].txt_appraisedon.value=="")
	{
		alert("Please send proposal to maker for Choose Re - Appraised on");
	 	return false;
	}
	document.forms[0].cmdapprove.disabled = true;
	document.forms[0].hidAction.value ="approve";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="agrotherassets";
	document.forms[0].hidBeanMethod.value="updateGoldReAppraiserdet";
	document.forms[0].hidBeanGetMethod.value="getGoldReAppraiserdet";
	document.forms[0].hidSourceUrl.value="/action/gold_reappraisal.jsp";
	document.forms[0].submit();
	
}

function validateSameAppraisal()
{
	if(document.forms[0].txt_appraisernameid.value == apprainame )
	{
		alert("Jewel appraiser who has originally done appraisal cannot reappraise");
		document.forms[0].txt_appraisernameid.value="";
		document.forms[0].txt_appraisername.value="";
		document.forms[0].txt_appraisedon.value=""		
		return false;
	}
	else
	{
		return true;
	}
}

function callReject()
{
	
	if(document.forms[0].txt_appraisername.value=="")
	{
		alert("Please send proposal to maker Enter Re - Appraiser Name");
		return false;
	}
	if(document.forms[0].txt_appraisedon.value=="")
	{
		alert("Please send proposal to maker for Choose Re - Appraised on");
	 	return false;
	}
	document.all.idRejectremark.style.visibility="visible";
	document.all.idRejectremark.style.position="relative";
	document.forms[0].remarks.readOnly=false;
	if(document.forms[0].remarks.value=="")
	{
		alert("Please Enter Remarks");
	}
	else 
	{
		document.forms[0].cmdapprove.disabled = true;
		document.forms[0].cmdreject.disabled = true;
		document.forms[0].hidAction.value ="reject";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="agrotherassets";
		document.forms[0].hidBeanMethod.value="updateGoldReAppraiserdet";
		document.forms[0].hidBeanGetMethod.value="getGoldReAppraiserdet";
		document.forms[0].hidSourceUrl.value="/action/gold_reappraisal.jsp";
		document.forms[0].submit();
	}
	
}
function certificate()
{
	var appraname=document.forms[0].txt_appraisername.value;
	var title = "Upload";
	var prop = "scrollbars=yes,width=1050,height=600,top=25,left=180";
	var url=appURL+"action/certificatereportof_goldornaments.jsp?hidBeanId=agrotherassets&hidBeanGetMethod=getcertificateforpa&appno="+document.forms[0].appnoforcert.value+"&appraname="+appraname;
	//?hidBeanId=agrotherassets&hidBeanGetMethod=getcertificateforpa&appno="+appno+"&appstatus="+document.forms[0].appstatus.value;
	window.open(url,title,prop);

	
}
function newbuttonfun()
{
	 if(parseInt(varuserclass) >= parseInt(varuserClassChecker)&&checkid=="Y")
		{
		 document.forms[0].cmdnew.disabled = false;	
		}
	    else if (parseInt(varuserclass) >= parseInt(varuserClassMaker)&&checkid=="Y")
	    {
	    	document.forms[0].cmdnew.disabled = false;	
	    }
	    
	else
	{	
			document.forms[0].cmdnew.disabled = true;	
		}
}


</SCRIPT>
<style>
select::-ms-expand {
    display: none;
    
}
</style>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading();checkuserid();newbuttonfun();">
<form name="appform" method="post" class="normal">
<table width="98%" border="0" cellpadding="5" cellspacing="0" class="outertable" align="center">

	<tr>
	<td>
	
<table width="90%" border="0" cellpadding="5" cellspacing="0" class="outertable" align="center">
	<tr>
		<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
				<tr class="dataheader" style="background-color:white;color:white;font-size=30;font-family:mssansserif;width:50;height:50px;font-weight:bold"> 
				<td align="center" style="font-size: 20px;">Re-Appraisal Status:<%String status=Helper.correctNull((String)hshValues.get("STATUS"));
                  if(status.trim().equalsIgnoreCase("pr"))
                  {
                  %>
                  Process Rejected
                   <%}else if(status.trim().equalsIgnoreCase("pa"))
                  {
                  %>
                  Processed/Approved
                  <%}else if(status.trim().equalsIgnoreCase("op"))
                  {
                  %>
                  Open Pending
                  <%} else
                  {
                      %>
                       <%} %>
                  
                  </td>
                  
				</tr>
			<tr class="dataheader">
				<td align="center">Orginal - Appraiser Details
				
				
				</td>
				</tr>
				<tr>
				<td>

				<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
			
			<tr class="dataheader">
			<td align="center"> Appraiser Name</td>
			<td align="center"> Appraised on</td>
			<td align="center"> CBS ID </td>
			<td align="center"> Remarks by Appraiser</td>
			</tr><tr class="dataheader">
			<td align="center"><%=Helper.correctNull((String)hshValues.get("ja_name"))%></td>
			<td align="center"><%=Helper.correctNull((String)hshValues.get("ja_appraiseon"))%></td>
			<td align="center"><%=Helper.correctNull((String)hshValues.get("ja_appraisercbsid"))%></td>
			<td align="center"><%=Helper.correctNull((String)hshValues.get("ja_comments"))%></td>
			</tr>
			</table>
			<br><br>	
			<tr>
		</table>
		<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
			<tr class="dataheader">
				<td align="center">Re - Appraiser Details
				
				
				</td>
				</tr>
				<tr>
				<td>

				<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
			
			<tr class="dataheader">
			<td align="center"> Sl No</td>
			<td align="center"> Description of Articles</td>
			<td align="center"> Quantity</td>
			<td align="center"> Gross Weight in Gms</td>
			<td align="center"> Net Weight in Gms</td>
			<td align="center"> Latest Market Value</td>
			<td align="center"> Remarks by Re Appraiser</td>
			</tr>
			<% if(hshValues!=null&&hshValues.size()>0)
			{
				arrRow = (ArrayList) hshValues.get("ArrRow");
				if (arrRow != null && arrRow.size() > 0) {
					
					for (int l = 0; l < arrRow.size(); l++) {
						arrCol = (ArrayList) arrRow.get(l);
			%><TR valign="top" class="dataheader">
			<td align="center"><%=Helper.correctNull((String)arrCol.get(0))%><input type="hidden" name="appraisal_id" value="<%=Helper.correctNull((String)arrCol.get(0))%>"></td>
			<td align="center"><%=Helper.correctNull((String)arrCol.get(1))%><input type="hidden" name="appraisal_desc" value="<%=Helper.correctNull((String)arrCol.get(1))%>"></td>
			<td align="center"><%=Helper.correctNull((String)arrCol.get(2))%><input type="hidden" name="appraisal_quantity" value="<%=Helper.correctNull((String)arrCol.get(2))%>"></td>
			<td align="center"><%=Helper.correctNull((String)arrCol.get(3))%><input type="hidden" name="appraisal_grs" value="<%=Helper.correctNull((String)arrCol.get(3))%>"></td>
			<td align="center"><%=Helper.correctNull((String)arrCol.get(4))%><input type="hidden" name="appraisal_nth" value="<%=Helper.correctNull((String)arrCol.get(4))%>"></td>
			<td align="center"><%=Helper.correctNull((String)arrCol.get(5))%><input type="hidden" name="appraisal_rate" value="<%=Helper.correctNull((String)arrCol.get(5))%>"></td>
			<td align="center"><textarea id="textcomments" name="txt_comments" rows="6" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" cols="40"> <%=Helper.replaceForJavaScriptString(Helper.correctNull((String)arrCol.get(6)))%></textarea></td>
			<%}}} %>
				</table>
			<br><br>	
			<tr>
			
			<td >Re - Appraiser Name 
			<input type="text" name="txt_appraisername" value="<%=Helper.correctNull((String)hshValues.get("GOLD_REAPRNAME")) %>" size="25">	&nbsp;
			<a href="#" onClick="showAppraiserName();" style="cursor:hand" tabindex="22">
			<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0" ></a>
			<input type ="hidden" name="hidAppraiserID" value="">
			</td>
			</tr><tr>
			<td> Re - Appraised on &nbsp;&nbsp;&nbsp;
			<input type="text" name="txt_appraisedon"  onblur="checkDate(this);allowalwysOldDate(this,varappdate);" value="<%=Helper.correctNull((String)hshValues.get("GOLD_REAPPDATE")) %>" size="12">			
			<a alt="Select date from calender"
									href="#" onClick="callCalender('txt_appraisedon')"
									onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"><img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
									alt="Select date from calender"></a></td>
			</tr>	
			<tr height="50">
			<td>
			
			<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Approve'	btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
			</td>
			
			</tr>
			<tr id="certificateofgold" align="center" style="visibility: hidden; position: absolute;">
			<td align="center" >
			<input type="button" name="Certificategold" onClick="certificate()" value="Certificate of Reappraisal of Gold Ornaments" class="buttonStyle">
			</td>
			</tr>
			<tr align="center">
			<td align="center" >
			<input type="button" name="cmdreject" onClick="callReject()" value="Reject" class="buttonStyle">		
			</td>
			</tr>
			
             <tr align="center">
				<td align="center" id="idRejectremark" style="visibility: hidden;" width="100%" align="center">Remarks <font color="red"
					align="center">*</font> <textarea maxlength="3900" name="remarks" rows="2"cols="70"></textarea></td>
			</tr>

	

</table>
</td>
</tr>
</table>
<input type ="hidden" name="txt_appraisernameid" value="<%=Helper.correctNull((String)hshValues.get("GOLD_REAPRCUSTID")) %>">
<input type ="hidden" name="appnoforcert" value="<%=Helper.correctNull((String)hshValues.get("strappno")) %>">
<lapschoice:hiddentag  pageid="<%=PageId%>"/> 
</form>
</body>
</html>
