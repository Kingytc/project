<%@include file="../share/directives.jsp"%>
<% request.setAttribute("_cache_refresh", "true"); %>
<%	
	String apptype=Helper.correctNull((String)request.getParameter("apptype"));
	if(apptype.equalsIgnoreCase(""))
	{
		apptype=Helper.correctNull((String)hshValues.get("apptype"));
	}
	if(apptype.equalsIgnoreCase(""))
	{
		apptype=Helper.correctNull((String)request.getParameter("hidborrowertype"));
	}
	String appname=Helper.correctNull((String)request.getParameter("borrowername"));
	if(appname.equalsIgnoreCase(""))
	{
		appname=Helper.correctNull((String)hshValues.get("borrowername"));
	}
	

	String cbsid=Helper.correctNull((String)request.getParameter("cbsid"));
	if(cbsid.equalsIgnoreCase(""))
	{
		cbsid=Helper.correctNull((String)hshValues.get("cbsid"));
	}
	ArrayList arrRow=new ArrayList();
	ArrayList arrCol=null;
	
	
	String sta_undersarfaesia=Helper.correctNull((String)hshValues.get("sta_undersarfaesia"));
	String sta_positionnotice=Helper.correctNull((String)hshValues.get("sta_positionnotice"));
	String sta_positiontaken=Helper.correctNull((String)hshValues.get("sta_positiontaken"));
	String sta_approached=Helper.correctNull((String)hshValues.get("sta_approached"));
	
	
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var var_undersarfaesia="<%=sta_undersarfaesia%>";
var var_positionnotice="<%=sta_positionnotice%>";
var var_positiontaken="<%=sta_positiontaken%>";
var var_approached="<%=sta_approached%>";
function showsarf()
{
	if(document.forms[0].sel_undersarfaesia.value=="1")
	{
		document.all.idsarf1.style.visibility="visible";
		document.all.idsarf1.style.position="relative";
		document.all.idsarf2.style.visibility="visible";
		document.all.idsarf2.style.position="relative";
		showpossessnotice();
	}
	else
	{
		document.all.idsarf1.style.visibility="hidden";
		document.all.idsarf1.style.position="absolute";
		document.all.idsarf2.style.visibility="hidden";
		document.all.idsarf2.style.position="absolute";
		document.forms[0].sel_postionnotice.value="0";
		document.forms[0].txt_demandnoticedate.value="";
		showpossessnotice();
	}
}

function showpossessnotice()
{
	if(document.forms[0].sel_postionnotice.value=="1")
	{
		document.all.a2.style.visibility="visible";
		document.all.a2.style.position="relative";
		document.all.a3.style.visibility="visible";
		document.all.a3.style.position="relative";
		document.all.a1.style.visibility="hidden";
		document.all.a1.style.position="absolute";
		/*document.forms[0].sel_positiontaken.value="0";*/
		document.forms[0].txt_notpositionreason.value="";
		showpossesstaken();
	}
	else if(document.forms[0].sel_postionnotice.value=="2")
	{
		document.all.a1.style.visibility="visible";
		document.all.a1.style.position="relative";
		document.all.a2.style.visibility="hidden";
		document.all.a2.style.position="absolute";
		document.all.a3.style.visibility="hidden";
		document.all.a3.style.position="absolute";
		document.forms[0].sel_positiontaken.value="0";
		document.forms[0].txt_positionnoticedate.value="";
		showpossesstaken();
	}
	else
	{
		document.all.a1.style.visibility="hidden";
		document.all.a1.style.position="absolute";
		document.all.a2.style.visibility="hidden";
		document.all.a2.style.position="absolute";
		document.all.a3.style.visibility="hidden";
		document.all.a3.style.position="absolute";
		document.forms[0].sel_positiontaken.value="0";
		document.forms[0].txt_notpositionreason.value="";
		document.forms[0].txt_positionnoticedate.value="";
		showpossesstaken();
	}
}
function showpossesstaken()
{
	if(document.forms[0].sel_positiontaken.value=="1")
	{
		document.all.a5.style.visibility="visible";
		document.all.a5.style.position="relative";
		document.all.a4.style.visibility="hidden";
		document.all.a4.style.position="absolute";
		document.forms[0].sel_approached.value="0";
		showdmcmm();
	}
	else if(document.forms[0].sel_positiontaken.value=="2")
	{
		document.all.a4.style.visibility="visible";
		document.all.a4.style.position="relative";
		document.all.a5.style.visibility="hidden";
		document.all.a5.style.position="absolute";
		
		<% arrRow=(ArrayList)hshValues.get("arrRow");
    	if(arrRow!=null && arrRow.size()>0)
    	{
    		for(int i=0;i<arrRow.size();i++)
    		{
    			arrCol=(ArrayList)arrRow.get(i);
    			if(arrCol!=null && arrCol.size()>0)
    			{
    			int size=arrRow.size();%>
    			var j="<%=i%>";
    			if(j==0)
    			{
    			document.forms[0].txt_dateofsale.value="";
    			document.forms[0].txt_dateofauction.value="";
    			document.forms[0].txt_saleamount.value="";
    			document.forms[0].txt_saleconfirmationdate.value="";
    			document.forms[0].txt_appropriatedacountdate.value="";
    			}
    			else
    			{
    			document.forms[0].txt_dateofsale[j].value="";
    			document.forms[0].txt_dateofauction[j].value="";
    			document.forms[0].txt_saleamount[j].value="";
    			document.forms[0].txt_saleconfirmationdate[j].value="";
    			document.forms[0].txt_appropriatedacountdate[j].value="";
    			}
    			<%
    			}
    		}
    	}		
    	%>
    			
		showdmcmm();
	}
	else
	{
		document.all.a4.style.visibility="hidden";
		document.all.a4.style.position="absolute";
		document.all.a5.style.visibility="hidden";
		document.all.a5.style.position="absolute";
		document.forms[0].sel_approached.value="0";
		<% arrRow=(ArrayList)hshValues.get("arrRow");
    	if(arrRow!=null && arrRow.size()>0)
    	{
    		for(int i=0;i<arrRow.size();i++)
    		{
    			arrCol=(ArrayList)arrRow.get(i);
    			if(arrCol!=null && arrCol.size()>0)
    			{
    			int size=arrRow.size();%>
    			var j="<%=i%>";
    			if(j==0)
    			{
    			document.forms[0].txt_dateofsale.value="";
    			document.forms[0].txt_dateofauction.value="";
    			document.forms[0].txt_saleamount.value="";
    			document.forms[0].txt_saleconfirmationdate.value="";
    			document.forms[0].txt_appropriatedacountdate.value="";
    			}
    			else
    			{
    			document.forms[0].txt_dateofsale[j].value="";
    			document.forms[0].txt_dateofauction[j].value="";
    			document.forms[0].txt_saleamount[j].value="";
    			document.forms[0].txt_saleconfirmationdate[j].value="";
    			document.forms[0].txt_appropriatedacountdate[j].value="";
    			}
    			<%
    			}
    		}
    	}	
    	%>
		showdmcmm();
	}
}
function showdmcmm()
{
	if(document.forms[0].sel_approached.value=="1")
	{
		document.all.a6.style.visibility="visible";
		document.all.a6.style.position="relative";
		document.all.a7.style.visibility="hidden";
		document.all.a7.style.position="absolute";
		document.forms[0].txt_nottakingposition.value="";
		
	}
	else if(document.forms[0].sel_approached.value=="2")
	{
		document.all.a7.style.visibility="visible";
		document.all.a7.style.position="relative";
		document.all.a6.style.visibility="hidden";
		document.all.a6.style.position="absolute";
		document.forms[0].txt_detailofapplication.value="";
	}
	else
	{
		document.all.a6.style.visibility="hidden";
		document.all.a6.style.position="absolute";
		document.all.a7.style.visibility="hidden";
		document.all.a7.style.position="absolute";
		document.forms[0].txt_nottakingposition.value="";
		document.forms[0].txt_detailofapplication.value="";
	}
}
function disableCommandButtons(val)
{
	if(val=="load")
	{  
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;	
		disableFields(true);	 
	}
	
	if(val=="edit")
	{	 
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=false;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="";
		document.forms[0].hidSourceUrl.value="/action/npastatusnote_sarfaesia.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanGetMethod.value="getStatusNoteSarfaesia";
		document.forms[0].hidBeanMethod.value="updateStatusNoteSarfaesia";
		document.forms[0].action=appUrl +"controllerservlet";
		document.forms[0].submit(); 		
	}	
	disableCommandButtons("load");
	
}

function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	disableCommandButtons("edit");	
	document.forms[0].sel_undersarfaesia.focus();
}
function doSave()
{
	if(document.forms[0].sel_undersarfaesia.value=="1" && document.forms[0].txt_demandnoticedate.value=="")
	{
		alert("Enter the Date of Demand Notice");
		document.forms[0].txt_demandnoticedate.focus();
		return;
	}
	if(document.forms[0].sel_undersarfaesia.value=="1" && document.forms[0].sel_postionnotice.value=="0")
	{
		alert("Select whether the possession Notice given");
		document.forms[0].sel_postionnotice.focus();
		return;
	}
	if(document.forms[0].sel_postionnotice.value=="1" && document.forms[0].txt_positionnoticedate.value=="")
	{
		alert("Enter the date of possession Notice");
		document.forms[0].txt_positionnoticedate.focus();
		return;
	}
	if(document.forms[0].sel_postionnotice.value=="1" && document.forms[0].sel_positiontaken.value=="0")
	{
		alert("Select whether Possession notice Taken");
		document.forms[0].sel_positiontaken.focus();
		return;
	}
	document.forms[0].hidSourceUrl.value="/action/npastatusnote_sarfaesia.jsp";
	document.forms[0].hidBeanId.value="npacommon";
	document.forms[0].hidBeanMethod.value="updateStatusNoteSarfaesia";
	document.forms[0].hidBeanGetMethod.value="getStatusNoteSarfaesia";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidSourceUrl.value="/action/npastatusnote_sarfaesia.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanMethod.value="updateStatusNoteSarfaesia";
		document.forms[0].hidBeanGetMethod.value="getStatusNoteSarfaesia";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();
	}
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
		if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].disabled=val;
		}
	}
	
}

function callCalender(name,size,i)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		if(size==1)
		{
			var name1=name.indexOf('[')
			var tempname=name.substring(0,name1);
			showCal(appUrl,tempname);
		}
		else
		{
			showCal(appUrl,name);
		}
		
	}
}
function callLink(page,bean,method)
	{
		if (document.forms[0].cmdsave.disabled)
		{
		document.forms[0].hidSourceUrl.value=page;
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
 function doClose()
 {
 if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/npa_mainlinknav.jsp";
		document.forms[0].submit();
		
	}
}	
function onLoading()
{
	if(var_undersarfaesia!="")
	{
		document.forms[0].sel_undersarfaesia.value=var_undersarfaesia;
	}
	else
	{
		document.forms[0].sel_undersarfaesia.value="0";
	}
	if(var_positionnotice!="")
	{
		document.forms[0].sel_postionnotice.value=var_positionnotice;
	}
	else
	{
		document.forms[0].sel_postionnotice.value="0";
	}
	if(var_positiontaken!="")
	{
		document.forms[0].sel_positiontaken.value=var_positiontaken;
	}
	else
	{
		document.forms[0].sel_positiontaken.value="0";
	}
	if(var_approached!="")
	{
		document.forms[0].sel_approached.value=var_approached;
	}
	else
	{
		document.forms[0].sel_approached.value="0";
	}
	showsarf();
	disableFields(true);
	
}
</script>
</head>
<body onload="onLoading()">
<form name="form1" method="post" action="" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
				<tr>
					<td>
						<lapstab:staturltag pageid="8"/>
					</td>
				</tr>
				<tr> 
           <td valign="top" class="page_flow">Home 
				-&gt; NPA-&gt; Status Note -&gt;Sarfaesia Comments
				</td>
          </tr>
			</table>
		</td>
	</tr>
</table>
<lapschoice:npaapplication />
<br>
		<INPUT type="hidden" name="npa_appno" value="<%=request.getParameter("npa_appno")%>" />
  <table width="45%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable border1">
    <tr> 
    <td>
    <table width="60%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
    <tr> 
      <td width="44%">Action Under sarfaesia</td>
      <td width="56%"> 
        <select name="sel_undersarfaesia" onchange="showsarf()" tabindex="1">
          <option value="0">&lt;----Select----&gt;</option>
          <option value="1">Yes</option>
          <option value="2">No</option>
        </select>
      </td>
    </tr>
    <tr > 
      <td colspan="2"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr id="idsarf1"> 
            <td width="44%">Date of Demand notice<span class="mantatory">*</span></td>
            <td width="56%"> 
              <input type="text" name="txt_demandnoticedate" value="<%=Helper.correctNull((String)hshValues.get("sta_demandnoticedate"))%>" tabindex="2"  onBlur="checkDate(this);checkmaxdate(this,currentDate)">
              <a href="#" onClick="callCalender('txt_demandnoticedate')"
				title="Click to view calender" border=0 tabindex="2"><img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
				width="0" border="0" tabindex="2"></a> </td>
          </tr>
		  <tr>
		    <td width="44%">&nbsp;</td>
		    <td width="56%">&nbsp;</td>
		  </tr>
          <tr id="idsarf2"> 
            <td width="44%">Whether possession Notice given<span class="mantatory">*</span></td>
            <td width="56%"> 
              <select name="sel_postionnotice" onchange="showpossessnotice()" tabindex="3">
                <option value="0">&lt;----Select----&gt;</option>
                <option value="1">Yes</option>
                <option value="2">No</option>
              </select>
            </td>
          </tr>
          <tr id="a1"> 
            <td width="44%">Reasons for not issuing possession notice</td>
            <td width="56%"> 
              <textarea name="txt_notpositionreason" tabindex="4" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("sta_notpositionreason"))%></textarea>
            </td>
          </tr>
          <tr > 
            <td colspan="2"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                <tr id="a2"> 
                  <td width="44%">Date of possession Notice <span class="mantatory">*</span></td>
                  <td width="56%"> 
                    <input type="text" name="txt_positionnoticedate" value="<%=Helper.correctNull((String)hshValues.get("sta_positionnoticedate"))%>" tabindex="5" onBlur="checkDate(this);checkmaxdate(this,currentDate)">
                    <a href="#" onClick="callCalender('txt_positionnoticedate')"
				title="Click to view calender" border=0 tabindex="5"><img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
				width="0" border="0" tabindex="5"></a> </td>
                </tr>
                <tr id="a3"> 
                  <td width="44%" >Whether Possession taken<span class="mantatory">*</span></td>
                  <td width="56%" > 
                    <select name="sel_positiontaken" onchange="showpossesstaken()" tabindex="6">
                      <option value="0">&lt;----Select----&gt;</option>
                      <option value="1">Yes</option>
                      <option value="2">No</option>
                    </select>
                  </td>
                </tr>
				
                <tr > 
                  <td colspan="2">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" dwcopytype="CopyTableRow" class="outertable">
                      <tr id="a4"> 
                        <td width="44%">Whether DM / CMM approached</td>
                        <td width="56%"> 
                          <select name="sel_approached" onChange="showdmcmm()" tabindex="7">
                            <option value="0">&lt;----Select----&gt;</option>
                            <option value="1">Yes</option>
                            <option value="2">No</option>
                          </select>
                        </td>
                      </tr>
                      <tr id="a6"> 
                        <td width="44%">Details of status of application</td>
                        <td width="56%"> 
                          <textarea name="txt_detailofapplication" tabindex="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("sta_detailsofapplication"))%></textarea>
                        </td>
                      </tr>
                      <tr id="a7"> 
                        <td width="44%">Reasons for not taking possession</td>
                        <td width="56%"> 
                          <textarea name="txt_nottakingposition" tabindex="9" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("sta_nottakingposition"))%></textarea>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  </td>
  </tr>
  </table>
  <br>
  <br>
  <br>
  <table width="100%" border="0" cellspacing="1" cellpadding="0" id="a5" class="outertable">
    <tr class="dataheader" align="center"> 
      <td rowspan="2" width="23%">Nature of Security</td>
      <td colspan="2" align="center">Present Position</td>
      <td rowspan="2" width="11%">Date of Sale Notice</td>
      <td rowspan="2" width="11%">Date of Auction</td>
      <td rowspan="2" width="11%">Sale Amount</td>
      <td rowspan="2" width="11%">Date of Sale Confirmation</td>
      <td rowspan="2" width="11%">Date sale amount appropriated to account</td>
    </tr>
    <tr class="dataheader"> 
      <td width="11%">Valuation Date</td>
      <td width="11%">Valuation Amount</td>
    </tr>
    <% arrRow=(ArrayList)hshValues.get("arrRow");
    	if(arrRow!=null && arrRow.size()>0)
    	{
    		for(int i=0;i<arrRow.size();i++)
    		{
    			int size=arrRow.size();
    			arrCol=(ArrayList)arrRow.get(i);
    			if(arrCol!=null && arrCol.size()>0)
    			{%>
    <tr class="datagrid"> 
      <td width="23%"> 
        <input type="hidden" name="txt_security"  tabindex="9"
		value="<%=Helper.correctNull((String)arrCol.get(0))%>" 
		onKeyPress="notAllowSplChar()">
		<%=Helper.correctNull((String)arrCol.get(0))%>
      </td>
      <td width="11%"> 
	 	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
		<tr>
		<td>
        	<input type="hidden" name="txt_valuationdate" size="12"
				maxlength="10" tabindex="10" 
				value="<%=Helper.correctNull((String)arrCol.get(1))%>" onBlur="checkDate(this)">
				<%=Helper.correctNull((String)arrCol.get(1))%>
		</td>
		<td>
        </td>
		</tr>
		</table>
      <td width="11%">&nbsp;
	  <input type="hidden" name="txt_valuationamount" size="15" maxlength="12" tabindex="11" value="<%=Helper.correctNull((String)arrCol.get(2))%>"/>
        <%=Helper.correctNull((String)arrCol.get(2))%></td>
      <td width="11%"> 
	  	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
		<tr>
		<td>
        <input type="text" name="txt_dateofsale" size="12"
				maxlength="10" tabindex="12" 
				value="<%=Helper.correctNull((String)arrCol.get(3))%>" onBlur="checkDate(this);checkmaxdate(this,currentDate)">
		</td>
		<td>
        <a href="#" onClick="callCalender('txt_dateofsale[<%=i%>]','<%=size%>','<%=i%>')"
				title="Click to view calender" border=0 tabindex="12"><img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
				width="0" border="0" tabindex="12"></a> </td>
		</tr>
		</table>
      <td width="11%"> 
	  	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
		<tr>
		    <td> 
              <input type="text" name="txt_dateofauction" size="12"
				maxlength="10" tabindex="13" 
				value="<%=Helper.correctNull((String)arrCol.get(4))%>" onBlur="checkDate(this);checkmaxdate(this,currentDate)">
            </td>
            <td>
        <a href="#" onClick="callCalender('txt_dateofauction[<%=i%>]','<%=size%>','<%=i%>')"
				title="Click to view calender" border=0 tabindex="13"><img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
				width="0" border="0" tabindex="13"></a> </td>
	</tr>
	</table>
      <td width="11%">&nbsp;
	  <lapschoice:CurrencyTag name="txt_saleamount" tabindex="14" maxlength="15" value='<%=Helper.correctNull((String)arrCol.get(5))%>'/></td>
      <td width="11%"> 
	  	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
		<tr>
		<td>
        <input type="text" name="txt_saleconfirmationdate" size="12"
				maxlength="10" tabindex="15" 
				value="<%=Helper.correctNull((String)arrCol.get(6))%>" onBlur="checkDate(this);checkmaxdate(this,currentDate)">
	</td>
	<td>
        <a href="#" onClick="callCalender('txt_saleconfirmationdate[<%=i%>]','<%=size%>','<%=i%>')"
				title="Click to view calender" border=0 tabindex="15"><img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
				width="0" border="0" tabindex="15"></a> </td>
	</tr>
	</table>
      <td width="11%"> 
	  	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
		<tr>
		<td>
        <input type="text" name="txt_appropriatedacountdate" size="12"
				maxlength="10" tabindex="16" 
				value="<%=Helper.correctNull((String)arrCol.get(7))%>" onBlur="checkDate(this);checkmaxdate(this,currentDate)">
	</td>
	<td>
        <a href="#" onClick="callCalender('txt_appropriatedacountdate[<%=i%>]','<%=size%>','<%=i%>')"
				title="Click to view calender" border=0 tabindex="16"><img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
				width="0" border="0" tabindex="16"></a> </td>
	</tr>
	</table>
    </tr>
    		<%}
    			
    	  }
    		
    	}	%>

  </table>

<br>
	 <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trial' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
	 <br> 
 <lapschoice:hiddentag pageid='<%=PageId%>'/>
 <input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("AuditFlag"))%>">
</form>
</body>
</html>

