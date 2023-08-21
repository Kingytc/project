<%@include file="../share/directives.jsp"%>
<%
java.text.NumberFormat nf=java.text.NumberFormat.getInstance();
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
nf.setGroupingUsed(false);

String stryear=Helper.correctNull((String)request.getParameter("mon_year"));
if(!stryear.equalsIgnoreCase(""))
{
	stryear=Helper.correctNull((String)hshValues.get("mon_year"));
}
String strmonth=Helper.correctNull((String)request.getParameter("mon_month"));

if(!strmonth.equalsIgnoreCase(""))
{
	strmonth=Helper.correctNull((String)hshValues.get("mon_month"));
}
String strmsod=Helper.correctNull((String)request.getParameter("mon_msod"));
if(strmsod.equalsIgnoreCase(""))
{
	strmsod=Helper.correctNull((String)hshValues.get("mon_msod"));
}			
String strstock=Helper.correctNull((String)request.getParameter("mon_stock"));
if(strstock.equalsIgnoreCase(""))
{
	strstock=Helper.correctNull((String)hshValues.get("mon_stock"));
}
String strbkdebts=Helper.correctNull((String)request.getParameter("mon_bkdebts"));
if(strbkdebts.equalsIgnoreCase(""))
{
	strbkdebts=Helper.correctNull((String)hshValues.get("mon_bkdebts"));
}
String strqpr=Helper.correctNull((String)request.getParameter("mon_qpr"));
if(strqpr.equalsIgnoreCase(""))
{
	strqpr=Helper.correctNull((String)hshValues.get("mon_qpr"));
}
%>
<html>
<head>
<title>ubi</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";


function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdedit.disabled=false;
		//document.forms[0].cmddel.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;	
	}
	
	if(val=="edit")
	{	 
		 document.forms[0].cmdedit.disabled=true;
		// document.forms[0].cmddel.disabled=false;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(true);
	}
}
function callCalender(fname)
 {
	 showCal("<%=ApplicationParams.getAppUrl()%>",fname);
 }


function onLoading()
{
	//disableCommandButtons("load");
	
		
	
	
}
function doDelete()
{
	if(ConfirmMsg(101))
		{	
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";		
		document.forms[0].hidBeanMethod.value="updateCurrentAssetfinanced";
		document.forms[0].hidBeanGetMethod.value="getCurrentAssetfinanced";
		document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].hidSourceUrl.value="action/mon_currentassetfinanced.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
		}
}
function doEdit()
{ 	
	
    document.forms[0].hidAction.value ="insert";
	disableCommandButtons("edit");	
	disableFields(false);
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidSourceUrl.value="mon_currentassetfinanced.jsp";
		document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].hidBeanGetMethod.value="getCurrentAssetfinanced";
		document.forms[0].action=appUrl +"action/mon_currentassetfinanced.jsp";
	    document.forms[0].submit();	
	}	
	
	disableCommandButtons("load");
}
function doSave()
	{
	   document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].hidBeanMethod.value="updateCurrentAssetfinanced";
		document.forms[0].hidBeanGetMethod.value="getCurrentAssetfinanced";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/mon_currentassetfinanced.jsp";
		document.forms[0].submit();
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
		 
	}
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/mainnav.jsp";
		document.forms[0].submit();
		
	}
}
function callLink(page,bean,method)
{
	
	 //if (document.forms[0].cmdsave.disabled)
		//{
			document.forms[0].hidSourceUrl.value=page;
			document.forms[0].hidBeanGetMethod.value=method;
			document.forms[0].hidBeanId.value=bean;
			document.forms[0].action=appUrl+"action/"+page;
			document.forms[0].submit();
		//}
	/*else
		{
			ShowAlert(103);
		}*/
}


function call_page(url,method)
{
	
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].method="post";

	if(url=="mon_currentassetfinanced.jsp")
	{
		document.forms[0].hidBeanId.value="mmrcommon";
	}
	/*else if(url=="com_takeoverworking.jsp")
	{
		document.forms[0].hidBeanId.value="comproposal";
	}*/
	else if(url=="mon_accountwisedetails.jsp")
	{
		document.forms[0].hidBeanId.value="mmrcommon";
	}
	
	else
	{
		document.forms[0].hidBeanId.value="mmrcommon";
	}
	document.forms[0].action=appUrl+"action/"+url;
	document.forms[0].submit();
	
	
	
}

	function allTotal()
	{
	
	var banklast=document.forms[0].txt_banklast.value;
	var sundrylast=document.forms[0].txt_sundrylast.value;
	var otherlast=document.forms[0].txt_otherlast.value;
	var nwclast=document.forms[0].txt_nwclast.value;
	var totalamount=0.00;
	if (banklast=="")
	{
	   banklast=0;
	}
	if (sundrylast=="")
	{
	   sundrylast=0;
	}
	if (otherlast=="")
	{
	   otherlast=0;
	}
	if (nwclast=="")
	{
	   nwclast=0;
	}
	totalamount=eval(banklast)+eval(sundrylast)+eval(otherlast)+eval(nwclast);
	document.forms[0].txt_totallast.value=NanNumber(totalamount);
	roundtxt(document.forms[0].txt_totallast);
	
	var bankquater=document.forms[0].txt_bankquater.value;
	var sundryquater=document.forms[0].txt_sundryquater.value;
	var otherquater=document.forms[0].txt_otherquater.value;
	var nwcquater=document.forms[0].txt_nwcquater.value;
	var totalamountquater=0.00;
	if (bankquater=="")
	{
	   bankquater=0;
	}
	if (sundryquater=="")
	{
	   sundryquater=0;
	}
	if (otherquater=="")
	{
	   otherquater=0;
	}
	if (nwcquater=="")
	{
	   nwcquater=0;
	}
	totalamountquater=eval(bankquater)+eval(sundryquater)+eval(otherquater)+eval(nwcquater);
	document.forms[0].txt_totalquater.value=NanNumber(totalamountquater);
	roundtxt(document.forms[0].txt_totalquater);
	
	var bankestimate=document.forms[0].txt_bankestimate.value;
	var sundryestimate=document.forms[0].txt_sundryestimate.value;
	var otherestimate=document.forms[0].txt_otherestimate.value;
	var nwcestimate=document.forms[0].txt_nwcestimate.value;
	var totalamountestimate=0.00;
	if (bankestimate=="")
	{
	   bankestimate=0;
	}
	if (sundryestimate=="")
	{
	   sundryestimate=0;
	}
	if (otherestimate=="")
	{
	   otherestimate=0;
	}
	if (nwcestimate=="")
	{
	   nwcestimate=0;
	}
	totalamountestimate=eval(bankestimate)+eval(sundryestimate)+eval(otherestimate)+eval(nwcestimate);
	document.forms[0].txt_totalestimate.value=NanNumber(totalamountestimate);
	roundtxt(document.forms[0].txt_totalestimate);
	}

</script>

</head>

<body onload="onLoading()">
<form name="safaeri3" method="post" class="normal">

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
				<tr>
					<td>
						<lapschoice:monthlymonitortag pageid="5"/>
					</td>
				</tr>
				<tr>
					<td class="Page_Flow">
						Home -&gt; Monitoring-&gt; 
  Monthly Monitoring -&gt;Accountwise Details -&gt;QPR-&gt; Current Assets
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
						<lapschoice:MonthlyMonitor />

 <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
    <tr> 
      <td valign="bottom"> 
        <table width="60%" border="0" cellspacing="3" cellpadding="3" align="left" class="outertable">
          <tr> 
            <td width="20%" class="sub_tab_inactive" align="center"   id="prin" ><b><a href="javascript:call_page('mon_accountwisedetails.jsp','getAccountwise')" >Account-Wise Details</a></b> </td>
            <%if(Helper.correctNull((String)hshValues.get("mon_msod")).equalsIgnoreCase("y"))
		 				 {%>
            <td width="20%" class="sub_tab_inactive" align="center"  id="prin"><b><a href="javascript:call_page('mon_msodestimates.jsp','getmsodestimate')" >MSOD</a>
               </b></td>
            <%} 
              if( Helper.correctNull((String)hshValues.get("mon_qpr")).equalsIgnoreCase("y")){%>
            <td width="20%" class="sub_tab_active" align="center" id="prin"><b><a href="javascript:call_page('mon_qprperformance.jsp','getQprPerformance')" >QPR
              </a></b></td>
              <%}

		  %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
						<lapschoice:MonQPRTag  pageid="3"/>
						<lapschoice:Monitor strSource="MMR"/>
  <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
  <tr class="dataHeader"> 
    <td>CURRENT ASSETS-HOW FINANCED</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr class="dataHeader"> 
    <td>&nbsp;</td>
    <td>At the end of last year</td>
    <td>At the current quarter ending</td>
    <td>Estimates at the end of current year</td>
  </tr>
  <tr class="datGrid"> 
    <td>k.Bank Borrowings(e/d%)</td>
    <td>
     
	<input type="text" name="txt_banklast"
									onKeyPress="allowInteger()" size="15" maxlength="12" style="text-align:right" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("current_banklast"))))%>">						
								
    </td>
    <td>
     
	  <input type="text"  name="txt_bankquater"
									onKeyPress="allowInteger()" size="15" maxlength="12" style="text-align:right" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("current_bankquater"))))%>">						
			
    </td>
    <td>
    
	  <input type="text"  name="txt_bankestimate"
									onKeyPress="allowInteger()" size="15" maxlength="12" style="text-align:right" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("current_bankestimate"))))%>">						
			
    </td>
  </tr>
  <tr  class="datGrid"> 
    <td>l.Sundry Creditors(f/d%)</td>
    <td>
     
	  <input type="text"  name="txt_sundrylast"
									onKeyPress="allowInteger()" size="15" maxlength="12" style="text-align:right" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("current_sundrylast"))))%>">						
			
    </td>
    <td>
    
	 <input type="text" name="txt_sundryquater"
									onKeyPress="allowInteger()" size="15" maxlength="12" style="text-align:right" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("current_sundryquater"))))%>">						
			
    </td>
    <td>
      
	 <input type="text"  name="txt_sundryestimate"
									onKeyPress="allowInteger()" size="15" maxlength="12" style="text-align:right" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("current_sundryestimate"))))%>">						
			
    </td>
  </tr>
  <tr  class="datGrid"> 
    <td>m.Other CLs(g/d%)</td>
    <td>
     
	  <input type="text"  name="txt_otherlast"
									onKeyPress="allowInteger()" size="15" maxlength="12" style="text-align:right" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("current_otherlast"))))%>">						
			
    </td>
    <td>
     
	  <input type="text"  name="txt_otherquater"
									onKeyPress="allowInteger()" size="15" maxlength="12" style="text-align:right" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("current_otherquater"))))%>">						
			
    </td>
    <td>
   
	 <input type="text"  name="txt_otherestimate"
									onKeyPress="allowInteger()" size="15" maxlength="12" style="text-align:right" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("current_otherestimate"))))%>">						
			
    </td>
  </tr>
  <tr  class="datGrid"> 
    <td>n.NWC (i/d%)</td>
    <td>
   
	  <input type="text"  name="txt_nwclast"
									onKeyPress="allowInteger()" size="15" maxlength="12" style="text-align:right" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("current_nwclast"))))%>">						
			
    </td>
    <td>
      
	  <input type="text"  name="txt_nwcquater"
									onKeyPress="allowInteger()" size="15" maxlength="12" style="text-align:right" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("current_nwcquater"))))%>">						
			
    </td>
    <td>
     
	 <input type="text"  name="txt_nwcestimate"
									onKeyPress="allowInteger()" size="15" maxlength="12" style="text-align:right" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("current_nwcestimate"))))%>">						
			
    </td>
  </tr>
  <tr  class="datGrid"> 
    <td>Total</td>
    <td>
      
	  <input type="text" name="txt_totallast"
									 onKeyPress="allowInteger()" size="15" maxlength="12" style="text-align:right" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("current_totallast"))))%>">						
			
    </td>
    <td>
     
	  <input type="text" name="txt_totalquater"
									onKeyPress="allowInteger()" size="15" maxlength="12" style="text-align:right" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("current_totalquater"))))%>">						
			
    </td>
    <td>
      
	  <input type="text" name="txt_totalestimate"
									onKeyPress="allowInteger()" size="15" maxlength="12" style="text-align:right" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("current_totalestimate"))))%>">						
			
    </td>
  </tr>
 
</table>

	<!--<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Audit Trial' btnenable='<%//=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>-->
	<!-- Changes done by Subha as per sureshkumar said on 09/04/2012 -->
	<lapschoice:combuttonnew  btnenable='<%//=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
	
	<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="mon_accno" value="<%=Helper.correctNull((String)request.getParameter("mon_accno")) %>">
<input type="hidden" name="cbsaccno" value="<%=request.getParameter("cbsaccno")%>">

<input type="hidden" name="cbsid" value="<%=Helper.correctNull((String)request.getParameter("cbsid"))%>">
<input type="hidden" name="mon_year" value="<%=Helper.correctNull((String)request.getParameter("mon_year"))%>">
<input type="hidden" name="mon_month" value="<%=Helper.correctNull((String)request.getParameter("mon_month"))%>">
<input type="hidden" name="cbsname" value="<%=Helper.correctNull((String)request.getParameter("cbsname"))%>">
<input type="hidden" name="mon_msod" value="<%=strmsod%>">
<input type="hidden" name="mon_stock" value="<%=strstock%>">
<input type="hidden" name="mon_bkdebts" value="<%=strbkdebts%>">
<input type="hidden" name="mon_qpr" value="<%=strqpr%>">
<input type="hidden" name="mon_checkqpr" value="<%=strqpr%>">
<input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("recordflag"))%>">
</form>
</body>
</html>

