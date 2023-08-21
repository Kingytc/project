<%@ page import="com.sai.laps.helper.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix="lapstab" uri="/WEB-INF/lapstab.tld"%>

<lapschoice:handleerror />
<%//out.print(hshValues);
			String strCategoryType = Helper.correctNull((String) request
					.getParameter("hidtype"));

			String strCons_Owner = Helper.correctNull((String) request
					.getParameter("hidCostitution"));

			if (strCategoryType == "") {
				strCategoryType = Helper.correctNull((String) hshValues
						.get("strCategoryType"));
			}
			java.text.NumberFormat nf = java.text.NumberFormat
					.getNumberInstance();
			nf.setGroupingUsed(false);
			nf.setMinimumFractionDigits(2);
			nf.setMaximumFractionDigits(2);

			String[] Nature = new String[5];
			String[] Present = new String[5];
			String[] Dateupto = new String[5];
			String[] Amountdbc = new String[5];
			String[] Datedbc = new String[5];
			Nature = (String[]) hshValues.get("fil_Nature");
			Present = (String[]) hshValues.get("fil_Present");
			Dateupto = (String[]) hshValues.get("fil_Dateupto");
			Amountdbc = (String[]) hshValues.get("fil_Amountdbc");
			Datedbc = (String[]) hshValues.get("fil_Datedbc");

			%>

<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<style>
.td,tr{font-family: "MS Sans Serif";
	font-size: 11px;
	}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/link.css" type="text/css"/>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>

<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";

function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddel.disabled=true;
		document.forms[0].cmdapply.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;	
	}
	
	if(val=="edit")
	{	 
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddel.disabled=false;
		 document.forms[0].cmdapply.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}
}

function onLoading()
{
	disableCommandButtons("load");
	
	<%for(int b=0;b<5;b++)
	{
		Nature[b]=Helper.correctNull((String)Nature[b]);
		Present[b]=Helper.correctNull((String)Present[b]);
		Dateupto[b]=Helper.correctNull((String)Dateupto[b]);
		Amountdbc[b]=Helper.correctDouble((String)Amountdbc[b]);
		Datedbc[b]=Helper.correctNull((String)Datedbc[b]);
		
		if(!Nature[b].equalsIgnoreCase(""))
		{
		%>
			var Nature="<%=Nature[b]%>";
			var Present="<%=Present[b]%>";
			var Dateupto="<%=Dateupto[b]%>";
			var Amountdbc="<%=Helper.formatDoubleValue(Double.parseDouble(Amountdbc[b]))%>";
			var Datedbc="<%=Datedbc[b]%>";
			var sel="<%=b%>";
			
			document.forms[0].txt_nature[sel].value=Nature;
			document.forms[0].txt_present[sel].value=Present;
			document.forms[0].txt_dateupto[sel].value=Dateupto;
			document.forms[0].txt_amountdbc[sel].value=Amountdbc;
			document.forms[0].txt_datedbc[sel].value=Datedbc;
		<%}
	}%>
	
	
	
}
function doEdit()
{ 	
	disableFields(false);
	
	disableCommandButtons("edit");	
	document.forms[0].hidAction.value ="insert";
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
	    document.forms[0].hidSourceUrl.value="/action/34PointsFormat_page5.jsp";
		document.forms[0].hidBeanId.value="npa";
		document.forms[0].hidBeanGetMethod.value="get34pointspage5Data";
		document.forms[0].hidBeanMethod.value="get34pointspage5Data";
		document.forms[0].action=appUrl +"controllerservlet"; 
		document.forms[0].submit(); 		
	}	
	
	disableCommandButtons("load");
}

function doSave()
	{
	document.forms[0].hidSourceUrl.value="/action/34PointsFormat_page5.jsp";
	document.forms[0].hidBeanId.value="npa";
	document.forms[0].hidBeanMethod.value="update34pointspage5Data";
	document.forms[0].hidBeanGetMethod.value="get34pointspage5Data";
	document.forms[0].action=appUrl+"controllerservlet"; 
	document.forms[0].submit();
	}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}  
		  if(document.forms[0].elements[i].type=='select-one' )
		  {
 				document.forms[0].elements[i].disabled=val;
		  }
		 
	}
	for(var i=0;i<5;i++)
	{
	document.forms[0].txt_dateupto[i].readOnly=true;
	document.forms[0].txt_datedbc[i].readOnly=true;
	}
	
	
}
function doClose()
	{
	if(ConfirmMsg('100'))
		{
		document.forms[0].method="post";	
		document.forms[0].action=appUrl+"action/"+"mainnav.jsp";
		document.forms[0].submit();
		}
	}
	
function doDelete()
{
if(ConfirmMsg(101))
		{	
			document.forms[0].hidAction.value="delete";
			document.forms[0].hidSourceUrl.value="/action/34PointsFormat_page5.jsp";
			document.forms[0].hidBeanId.value="npa";
			document.forms[0].hidBeanMethod.value="update34pointspage5Data";
			document.forms[0].hidBeanGetMethod.value="get34pointspage5Data";
			document.forms[0].action=appUrl +"controllerservlet";
			document.forms[0].submit(); 
		}


}	
	

function callLink(page,bean,method)
		{
		if (document.forms[0].cmdapply.disabled)
	{
		document.forms[0].hidSourceUrl.value=page;
		//alert(document.forms[0].hidSourceUrl);
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appUrl+"action/"+page;
		document.forms[0].submit();
			 }
	else
	{
		ShowAlert(103);
	}
		}
		
function callCalender(name)
{
	
	if(document.forms[0].cmdapply.disabled==false)
	{
		showCal(appUrl,name);
		
	}
}		

</script>
</head>
<body text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" font-family="arial" font-size="11px" onload="onLoading()">
<form name="34pointsFormatpage5" method="post">

<table width="100%" border="0" class="outertable border1" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left">
				<tr>
					<td>
						<lapstab:suiturltag pageid="6"/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><lapschoice:npaapplication />
		<INPUT type="hidden" name="npa_appno" value="<%=(String)request.getParameter("npa_appno")%>" />
		</td>
	</tr>
</table>

<table width="100%" border="0" class="outertable border1" cellspacing="0" cellpadding="2">
  <tr> 
    <td valign="top">
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr> 
          <td> 
          <!--  <table width="100%" border="1" cellspacing="0" cellpadding="5">
              <tr> 
                <td colspan="3"> 29.Present position of the account: -<br>
                </td>
                <td align="right"> <b>(Rs. inactuals)</b></td>
              </tr>
              <tr> 
                <td width="25%">Nature</td>
                <td width="25%">Outstanding in R/L As on _______________ </td>
                <td width="25%">Interest in Dummy Ledger From 
                  <input type="text" name="textfield" size="5">
                  To 
                  <input type="text" name="textfield2" size="5">
                </td>
                <td width="25%">&nbsp;</td>
              </tr>
              <tr> 
                <td width="25%">&nbsp;</td>
                <td width="25%">&nbsp;</td>
                <td width="25%">&nbsp;</td>
                <td width="25%">&nbsp;</td>
              </tr>
              <tr> 
                <td width="25%">&nbsp;</td>
                <td width="25%">&nbsp;</td>
                <td width="25%">&nbsp;</td>
                <td width="25%">&nbsp;</td>
              </tr>
              <tr> 
                <td width="25%">&nbsp;</td>
                <td width="25%">&nbsp;</td>
                <td width="25%">&nbsp;</td>
                <td width="25%">&nbsp;</td>
              </tr>
              <tr> 
                <td width="25%">&nbsp;</td>
                <td width="25%">&nbsp;</td>
                <td width="25%">&nbsp;</td>
                <td width="25%">&nbsp;</td>
              </tr>
              <tr> 
                <td width="25%">&nbsp;</td>
                <td width="25%">&nbsp;</td>
                <td width="25%">&nbsp;</td>
                <td width="25%">&nbsp;</td>
              </tr>
            </table>-->
          </td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td> 
            
          </td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td> 
            
          </td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td> 
           <table width="100%" border="0" class="outertable border1" cellspacing="0" cellpadding="5">
					<tr>
						<td colspan="5">30) Present rate of interest applicable to the 
                  facilities:</td>
					</tr>
					<tr align="center">
						<td width="5%">Present Nature</td>
						<td>Present rate of interst</td>
						<td width="15%">Date up to which interest is charged </td>
						<td width="20%"> Amount of DBC</td>
						<td width="10%">Date of DBC</td>
					</tr>
					<%for (int i = 0; i < 5; i++) {

				if (Nature[i] != null && Nature[i] != "") {
					//System.out.println("==-=-=-=-=-=-0=-=" + Nature[i]);

					%>
					<tr>
						<td width="20%"><input type="text" name="txt_nature" size="35"
							maxlength="50" value="<%//=Helper.correctNull(location[i])%>""></td>
						<td width="20%"><input type="text" name="txt_present" size="35"
							maxlength="9" value="<%//=Helper.correctNull(descript[i])%>""></td>
						<td width="20%"><input type="text" name="txt_dateupto" size="15"
							maxlength="25" value="<%//=Helper.correctNull(date[i])%>"">
							<a href="#" onClick="callCalender('txt_dateupto[<%=i%>]')"
							TITLE="Click to view calender" BORDER=0><IMG
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							BORDER="0" TABINDEX="23"></a></td>
							<td width="20%"><input type="text" name="txt_amountdbc" size="35" style="text-align:right"
							maxlength="9" value="<%//=Helper.correctNull(descript[i])%>""></td>
						<td width="20%"><input type="text" name="txt_datedbc" size="15"
							maxlength="25" value="<%//=Helper.correctNull(date[i])%>"">
							<a href="#" onClick="callCalender('txt_datedbc[<%=i%>]')"
							TITLE="Click to view calender" BORDER=0><IMG
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							BORDER="0" TABINDEX="23"></a></td>
					</tr>
					<%}

				else {%>
					<tr>
						<td width="20%"><input type="text" name="txt_nature" size="35"
							maxlength="50" value="<%//=Helper.correctNull(location[i])%>""></td>
						<td width="20%"><input type="text" name="txt_present" size="35"
							maxlength="9" value="<%//=Helper.correctNull(descript[i])%>""></td>
						<td width="20%"><input type="text" name="txt_dateupto" size="15"
							maxlength="25" value="<%//=Helper.correctNull(date[i])%>"">
							<a href="#" onClick="callCalender('txt_dateupto[<%=i%>]')"
							TITLE="Click to view calender" BORDER=0><IMG
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							BORDER="0" TABINDEX="23"></a></td>
							<td width="20%"><input type="text" name="txt_amountdbc" size="35" style="text-align:right"
							maxlength="9" value="<%//=Helper.correctNull(descript[i])%>""></td>
						<td width="20%"><input type="text" name="txt_datedbc" size="15"
							maxlength="25" value="<%//=Helper.correctNull(date[i])%>"" >
							<a href="#" onClick="callCalender('txt_datedbc[<%=i%>]')"
							TITLE="Click to view calender" BORDER=0><IMG
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							BORDER="0" TABINDEX="23"></a></td>
					</tr>
					<%}
			}

			%>
				</table>
          </td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
      <!--  <tr> 
          <td>32.<u>Please elaborate the actions taken by your branch for the 
            safeguard of the securities held and the recovery of the outstanding 
            advance granted to the borrower:</u></td>
        </tr>
        <tr> 
           <td> 
             <textarea rows="8" name="txt_elaboratedbc" cols="70" onkeypress="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("fil_elaboratedbc"))%></textarea>
          </td>
        </tr>-->
      </table>
    </td>
  </tr>
</table>

<table width="12%" border="0" class="outertable border1" cellspacing="0" cellpadding="0" align="center">
	<tr> 
    	<td> 
        	<table width="100%" border="0" cellspacing="0" cellpadding="2">
        	<tr>
				<td align="center"><input type="button" name="cmdedit" value="Edit"
					class="buttonStyle"
					onclick="doEdit()"></td>
				<td align="center"><input type="button" name="cmdapply"
					value="Save"
					class="buttonStyle"
					onclick="doSave()"></td>
				<td align="center"><input type="button" name="cmdcancel"
					value="Cancel"
					class="buttonStyle"
					onclick="doCancel()"></td>
					<td align="center"><input type="button" name="cmddel"
					value="Delete"
					class="buttonStyle"
					onclick="doDelete()"></td>
				<!-- <td align="center"><input type="button" name="cmdhelp" value="Help"
					style="background-color:#009966;cursor:help;;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
					onclick="doHelp()"></td> -->
				<td align="center"><input type="button" name="cmdclose"
					value="Close"
					style="background-color:#CC3300;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
					onclick="doClose()"></td>
					</tr>
			</table>
		</td>
	</tr>
</table>
<input type="hidden" name="hidAction" />
<input type="hidden" name="hidBeanId" />
<input type="hidden" name="hidBeanMethod" value="" />
<input type="hidden" name="hidBeanGetMethod" value="" />
<input type="hidden" name="hidSourceUrl" />
<input	type="hidden" name="hidCostitution" value="<%=strCons_Owner%>" />
<input type="hidden" name="hidappno" value="<%=(String)request.getParameter("npa_appno")%>">
<input type="hidden" name="comapp_id" value="<%=(String)request.getParameter("comapp_id")%>">
<input type="hidden" name="hidmoduletype" value="SUIT" />
</form>
</body>
</html>
