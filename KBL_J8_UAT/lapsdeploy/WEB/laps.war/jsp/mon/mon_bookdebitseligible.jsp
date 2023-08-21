<%@include file="../share/directives.jsp"%>
<%
double	dblgranttotal=Double.parseDouble(Helper.correctDouble((String)hshValues.get("grant_total")));

String strmsod=Helper.correctNull((String)request.getParameter("mon_msod"));
if(!strmsod.equalsIgnoreCase(""))
{
	strmsod=Helper.correctNull((String)hshValues.get("mon_msod"));
}			
String strstock=Helper.correctNull((String)request.getParameter("mon_stock"));
if(!strstock.equalsIgnoreCase(""))
{
	strstock=Helper.correctNull((String)hshValues.get("mon_stock"));
}
String strbkdebts=Helper.correctNull((String)request.getParameter("mon_bkdebts"));
if(!strbkdebts.equalsIgnoreCase(""))
{
	strbkdebts=Helper.correctNull((String)hshValues.get("mon_bkdebts"));
}
String strqpr=Helper.correctNull((String)request.getParameter("mon_qpr"));
if(strqpr.equalsIgnoreCase(""))
{
	strbkdebts=Helper.correctNull((String)hshValues.get("mon_qpr"));
}
%>
<html>
<head>
<title>ubi</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var dblgranttotal=<%=dblgranttotal%>
function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;	
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
function callCalender(fname)
 {
	 showCal("<%=ApplicationParams.getAppUrl()%>",fname);
 }


function onLoading()
{
	disableCommandButtons("load");
}

function doPrint()
  {
	var accno = document.forms[0].mon_accno.value;
	var cbsid = document.forms[0].cbsid.value;
	var month = document.forms[0].mon_month.value;
	var year = document.forms[0].mon_year.value;
	var cbsname=document.forms[0].cbsname.value;
	var varmmrno = document.forms[0].mmrno.value;
	
	var url = "<%=ApplicationParams.getAppUrl()%>action/mon_printbookstatement.jsp?hidBeanId=mmrcommon&hidBeanGetMethod=getBookprint&cbsid="+cbsid+"&accno="+accno+"&month="+month+"&year="+year+"&cbsname="+cbsname+"&mmrno="+varmmrno;
	var title = "BookReport";
	var prop = "scrollbars=yes,width=850,height=550,menubar=yes";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
}

function doDelete()
{
	if(ConfirmMsg(101))
		{	
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";		
		document.forms[0].hidBeanMethod.value="updateBookdebitseligible";
		document.forms[0].hidBeanGetMethod.value="getBookdebitseligible";
		document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].hidSourceUrl.value="action/mon_bookdebitseligible.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
		}
		
}
function doEdit()
{ 	
	disableFields(false);
    document.forms[0].hidAction.value ="insert";
	disableCommandButtons("edit");	
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidSourceUrl.value="mon_bookdebitseligible.jsp";
		document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].hidBeanGetMethod.value="getBookdebitseligible";
		document.forms[0].action=appUrl +"action/mon_bookdebitseligible.jsp";
	    document.forms[0].submit();	
	}	
	
	disableCommandButtons("load");
}
function doSave()
	{
	   document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].hidBeanMethod.value="updateBookdebitseligible";
		document.forms[0].hidBeanGetMethod.value="getBookdebitseligible";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/mon_bookdebitseligible.jsp";
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
	document.forms[0].txt_bkdbtolderamount.readOnly=true;
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/mainnav.jsp";
		document.forms[0].submit();
		
	}
}
function call_page(url,method)
{
	
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].method="post";

	if(url=="mon_stockstatement.jsp")
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

function allTotal()
	{
	
	
	var tolder=document.forms[0].txt_bkdbtolderamount.value;
	var discount=document.forms[0].txt_bkdbdiscountamount.value;
	var factor=document.forms[0].txt_bkdbfactoramount.value;
	var doubtful=document.forms[0].txt_bkdbdoubtfulamount.value;
	
	var associate=document.forms[0].txt_bkdbassociateamount.value;
	var finance=document.forms[0].txt_bkdbfinanceamount.value;
	var totalamount=0.00;
	if (tolder=="")
	{
	   tolder=0;
	}
	if (discount=="")
	{
	   discount=0;
	}
	if (factor=="")
	{
	   factor=0;
	}
	if (doubtful=="")
	{
	   doubtful=0;
	}
	if (associate=="")
	{
	   associate=0;
	}
	if (finance=="")
	{
	   finance=0;
	}
	if (dblgranttotal=="")
	{
	   dblgranttotal=0;
	}
	
	totalamount=eval(tolder)+eval(discount)+eval(factor)+eval(doubtful)+eval(associate)+eval(finance);
	
//	document.forms[0].txt_bkdbtotaleligibleamount.value=Math.abs((dblgranttotal-totalamount));
		
}

</script>

</head>

<body onload="onLoading();allTotal()">
<form name="monbookdebts" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left"  class="outertable">
				<tr>
					<td>
						<lapschoice:monthlymonitortag pageid="5"/>
					</td>
				</tr>
				<tr>
					<td class="Page_Flow">
						Home -&gt; Monitoring-&gt; 
  Monthly Monitoring -&gt;Accountwise Details -&gt;MSOD -&gt;BookDebts Eligible
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
            <td width="20%"  class="sub_tab_inactive"  align="center" id="prin" ><b><a href="javascript:call_page('mon_accountwisedetails.jsp','getAccountwise')" >Account-Wise Details</a></b> </td>
            	<%if(Helper.correctNull((String)hshValues.get("mon_msod")).equalsIgnoreCase("y"))
		 				 {%>
            <td width="20%" class="sub_tab_active"  align="center"  id="prin"><b>MSOD
               </b></td>
               <%} 
              if( Helper.correctNull((String)hshValues.get("mon_qpr")).equalsIgnoreCase("y")){%>
            <td width="20%" class="sub_tab_inactive"   align="center" id="prin"><b><a href="javascript:call_page('mon_qprperformance.jsp','getQprPerformance')" >QPR
              </a></b></td>
              <%}

		  %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
						<lapschoice:MonMSODTag msod='<%=strmsod%>' stock='<%=strstock%>' bookdebts='<%=strbkdebts%>' pageid="6"/>
						<lapschoice:Monitor strSource="MMR"/>
  <table width="79%" border="0" cellspacing="0" cellpadding="4" align="center" class="outertable border1" height="406">
    <tr> 
            
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="4" align="center" class="outertable" height="389">
          <tr>
		    <td width="4%" height="38"><b>A</b>
            <td width="76%" height="38">Book 
              debts older than user defined period. (older then 90 days) 
            </td>
            <td colspan="" height="38" width="20%">&nbsp; 
              <lapschoice:CurrencyTag name="txt_bkdbtolderamount" size="20" maxlength="15"  onBlur="allTotal()" value='<%=Helper.correctNull((String)hshValues.get("oldernintyvalue"))%>'/>
            </td>
          </tr>
          <tr> 
		    <td width="4%" height="38"><b>B</b>
            <td width="76%" height="38">Bills 
              Negotiated / discounted with bank/Financial institution,
            </td>
            <td colspan="" height="38" width="20%">&nbsp; 
              <lapschoice:CurrencyTag name="txt_bkdbdiscountamount" size="20" maxlength="15"   onBlur="allTotal()" value='<%=Helper.correctNull((String)hshValues.get("mmr_bkdbdiscountamount"))%>'/>
            </td>
            
          </tr>
          <tr> 
		    <td width="4%" height="38"><b>C</b>
            <td width="76%" height="38">Books 
              Debts assigned to factors. </td>
            <td colspan="" height="38" width="20%">&nbsp; 
              <lapschoice:CurrencyTag name="txt_bkdbfactoramount" size="20" maxlength="15"  onBlur="allTotal()" value='<%=Helper.correctNull((String)hshValues.get("mmr_bkdbfactoramount"))%>'/>
            </td>
         
          </tr>
          <tr> 
		    <td width="4%" height="38"><b>D</b>
            <td width="76%" height="38">Debts 
              considered doubtful of recovery. </td>
            <td colspan="" height="38" width="20%">&nbsp; 
              <lapschoice:CurrencyTag name="txt_bkdbdoubtfulamount" size="20" maxlength="15"   onBlur="allTotal()" value='<%=Helper.correctNull((String)hshValues.get("mmr_bkdbdoubtfulamount"))%>'/>
            </td>
             </tr>
          <tr> 
		    <td width="4%" height="38"><b>E</b>
            <td width="76%" height="38">Book 
              Debts arising out of Bills Drawn on Associate concerns. </td>
            <td colspan="" height="38" width="20%">&nbsp; 
              <lapschoice:CurrencyTag name="txt_bkdbassociateamount" size="20" maxlength="15"  onBlur="allTotal()" value='<%=Helper.correctNull((String)hshValues.get("mmr_bkdbassociateamount"))%>'/>
            </td>
              </tr>
          <tr> 
		    <td width="4%" height="38"><b>F</b></font> 
            <td width="76%" height="38">Book 
              Debts arising out of Activity other than for which bank finance 
              is extended. </td>
            <td colspan="" height="38" width="20%">&nbsp; 
              <lapschoice:CurrencyTag name="txt_bkdbfinanceamount" size="20" maxlength="15"  onBlur="allTotal()" value='<%=Helper.correctNull((String)hshValues.get("mmr_bkdbfinanceamount"))%>'/>
            </td>
          </tr><!--
          <tr> 
		    <td width="4%" height="38"><font size="1" face="MS Sans Serif"><b>G</b></font> 
            <td width="76%" height="38"><font size="1" face="MS Sans Serif">Eligible 
              Book Debts for calculation of DP Amount= Grand Total-(A+B+C+D+E+F)) 
              </font> </td>
            <td colspan="" height="38" width="20%">&nbsp; 
              <input type="text" name="txt_bkdbtotaleligibleamount" onkeypress="allowNumber(this)" onBlur="allTotal()"  size="20" maxlength="15" value="<%//=Helper.correctNull((String)hshValues.get("mmr_bkdbtotaleligibleamount"))%>">
            </td>
          </tr>
        --></table>
      </td>
          </tr>
          
        </table>
    <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail_Print' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
		<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="mon_accno" value="<%=Helper.correctNull((String)request.getParameter("mon_accno")) %>">
<input type="hidden" name="cbsid" value="<%=Helper.correctNull((String)request.getParameter("cbsid"))%>">
<input type="hidden" name="mon_year" value="<%=Helper.correctNull((String)request.getParameter("mon_year"))%>">
<input type="hidden" name="mon_month" value="<%=Helper.correctNull((String)request.getParameter("mon_month"))%>">
<input type="hidden" name="cbsname" value="<%=Helper.correctNull((String)request.getParameter("cbsname"))%>">
<input type="hidden" name="mon_msod" value="<%=strmsod%>">
<input type="hidden" name="mon_stock" value="<%=strstock%>">
<input type="hidden" name="mon_bkdebts" value="<%=strbkdebts%>">
<input type="hidden" name="mon_qpr" value="<%=strqpr%>">

</form>
</body>
</html>

