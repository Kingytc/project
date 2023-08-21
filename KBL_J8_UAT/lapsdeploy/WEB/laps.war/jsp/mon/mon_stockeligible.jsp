<%@include file="../share/directives.jsp"%>
<%
java.text.NumberFormat nf=java.text.NumberFormat.getInstance();
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
nf.setGroupingUsed(false);


double totalvaluepage1=Double.parseDouble(Helper.correctDouble((String)hshValues.get("totalvalue")));

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
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var selpackingcredit="<%=Helper.correctNull((String)hshValues.get("stock_selpackingcredit"))%>";
var totalvaluepage1="<%=totalvaluepage1%>";
function disablebutton(){

var check=document.forms[0].sel_packingcredit.value;


		if(check=="1") {
		
			document.forms[0].cmddpexcludingpc.disabled=false;
			document.forms[0].cmddpincludingpc.disabled=true;	
			
		}else if(check=="2"){
		
			document.forms[0].cmddpexcludingpc.disabled=true;
			document.forms[0].cmddpincludingpc.disabled=false;	
			
		}else if(check=="0") {
			
			document.forms[0].cmddpexcludingpc.disabled=true;
			document.forms[0].cmddpincludingpc.disabled=true;	
		}
}
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
		 
		 document.forms[0].cmddpexcludingpc.disabled=true;
		document.forms[0].cmddpincludingpc.disabled=true;
		 disableFields(false);
	}
}
function callCalender(fname)
 {
	 showCal("<%=ApplicationParams.getAppUrl()%>",fname);
 }


function onLoading()
{
		if(selpackingcredit=="1") {
		
			document.forms[0].cmddpexcludingpc.disabled=false;
			document.forms[0].cmddpincludingpc.disabled=true;	
			
		}else if(selpackingcredit=="2"){
		
			document.forms[0].cmddpexcludingpc.disabled=true;
			document.forms[0].cmddpincludingpc.disabled=false;	
			
		}else if(selpackingcredit=="0") {
			
			document.forms[0].cmddpexcludingpc.disabled=true;
			document.forms[0].cmddpincludingpc.disabled=true;	
		}

   if(selpackingcredit!="")
	{
	  document.forms[0].sel_packingcredit.value=selpackingcredit;
	}
	else
	{
		document.forms[0].sel_packingcredit.value="0";	
	}
	disableCommandButtons("load");
	
}



function doPrint(page)
  {

	var accno = document.forms[0].mon_accno.value;
	var cbsid = document.forms[0].cbsid.value;
	var month = document.forms[0].mon_month.value;
	var year = document.forms[0].mon_year.value;
	var varmmrno = document.forms[0].mmrno.value;
	var url = "<%=ApplicationParams.getAppUrl()%>action/"+page+"?hidBeanId=mmrcommon&hidBeanGetMethod=getstockReport&cbsid="+cbsid+"&accno="+accno+"&month="+month+"&year="+year+"&mmrno="+varmmrno;
	var title = "stockReport";
	var prop = "scrollbars=yes,width=800,height=550,menubar=yes";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);

	/*var url = "</=ApplicationParams.getAppUrl()%>action/"+page;
	var title = "Deviationreport";
	var prop = "scrollbars=yes,width=850,height=550,menubar=yes";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);*/
}
function doDpIncludingPc()
  {

	var accno = document.forms[0].mon_accno.value;
	var cbsid = document.forms[0].cbsid.value;
	var month = document.forms[0].mon_month.value;
	var year = document.forms[0].mon_year.value;
	var varmmrno = document.forms[0].mmrno.value;
	var url = "<%=ApplicationParams.getAppUrl()%>action/mon_dpincludingpc.jsp?hidBeanId=mmrcommon&hidBeanGetMethod=getDPexcludingPC&cbsid="+cbsid+"&accno="+accno+"&month="+month+"&year="+year+"&mmrno="+varmmrno;
	var title = "stockReport";
	var prop = "scrollbars=yes,width=850,height=600,menubar=yes";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);

}


function doDpExcludingPc()
  {

	var accno = document.forms[0].mon_accno.value;
	var cbsid = document.forms[0].cbsid.value;
	var month = document.forms[0].mon_month.value;
	var year = document.forms[0].mon_year.value;
	var varmmrno = document.forms[0].mmrno.value;
	
	var url = "<%=ApplicationParams.getAppUrl()%>action/mon_dpexcludingpc.jsp?hidBeanId=mmrcommon&hidBeanGetMethod=getDPexcludingPC&cbsid="+cbsid+"&accno="+accno+"&month="+month+"&year="+year+"&mmrno="+varmmrno;
	var title = "stockReport";
	var prop = "scrollbars=yes,width=850,height=600,menubar=yes";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);

	/*var url = "</=ApplicationParams.getAppUrl()%>action/"+page;
	var title = "Deviationreport";
	var prop = "scrollbars=yes,width=850,height=550,menubar=yes";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);*/
}

/*function doExcludingDP()
{		
	var accno = document.forms[0].mon_accno.value;
	var cbsid = document.forms[0].cbsid.value;
	var month = document.forms[0].mon_month.value;
	var year = document.forms[0].mon_year.value;
	
		var url = "<%=ApplicationParams.getAppUrl()%>action//"+page+"?hidBeanId=mmrcommon&hidBeanGetMethod=getDPexcludingPC&cbsid="+cbsid+"&accno="+accno+"&month="+month+"&year="+year;						
		var purl ="<%=ApplicationParams.getAppUrl()%>action/34PointsFormat_print.jsp?hidBeanGetMethod=getDPexcludingPC&hidBeanId=mmrcommon&npa_appno="+npa_appno+"&borrowername="+CompanyName+"&hidmoduletype="+hidmoduletype+"&cbsid="+document.forms[0].cbsid.value+"&selPrint="+selPrint;
		var prop = 'scrollbars=yes,menubar=yes,width=750,height=520';	
		var xpos = (screen.width - 750) / 2;
		var ypos = (screen.height - 520) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,'title',prop);
}	*/

function doDelete()
{
	if(ConfirmMsg(101))
		{	
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";		
		document.forms[0].hidBeanMethod.value="updateStockeligible";
		document.forms[0].hidBeanGetMethod.value="getstockeligible";
		document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].hidSourceUrl.value="action/mon_stockeligible.jsp";	
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
		document.forms[0].hidSourceUrl.value="mon_stockeligible.jsp";
		document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].hidBeanGetMethod.value="getstockeligible";
		document.forms[0].action=appUrl +"action/mon_stockeligible.jsp";
	    document.forms[0].submit();	
	}	
	
	disableCommandButtons("load");
}
function doSave()
	{
	   document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].hidBeanMethod.value="updateStockeligible";
		document.forms[0].hidBeanGetMethod.value="getstockeligible";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/mon_stockeligible.jsp";
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
	document.forms[0].txt_totalunpaidstock.readOnly=true;
	document.forms[0].txt_totalstock.readOnly=true;
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

function allTotal()
	{

	
	var stocklc=document.forms[0].txt_stocklc.value;
	var stockcreditor=document.forms[0].txt_stockcreditor.value;
	//var factor=document.forms[0].txt_totalunpaidstock.value;
	var stocknotdp=document.forms[0].txt_stocknotdp.value;
	
	var otherasset=document.forms[0].txt_otherasset.value;
	var packingcredit=document.forms[0].txt_packingcredit.value;
	var stockearmarked=document.forms[0].txt_stockearmarked.value;
	
	//var totalvalue=document.forms[0].txt_stockeligible.value;
	
	var totalamount=0.00;
	var totalunpaid=0.00;
	
	if (stocklc=="")
	{
	   stocklc=0;
	}
	if (stockcreditor=="")
	{
	   stockcreditor=0;
	}
	if (stocknotdp=="")
	{
	   stocknotdp=0;
	}
	if (otherasset=="")
	{
	   otherasset=0;
	}
	if (packingcredit=="")
	{
	   packingcredit=0;
	}
	if (stockearmarked=="")
	{
	   stockearmarked=0;
	}
	
	
	
	totalamount=eval(stocklc)+eval(stockcreditor)+eval(stocknotdp)+eval(otherasset)+eval(packingcredit)+eval(stockearmarked);
	document.forms[0].txt_totalstock.value=NanNumber(totalamount);
	
	totalunpaid=eval(stocklc)+eval(stockcreditor);
	document.forms[0].txt_totalunpaidstock.value=NanNumber(totalunpaid);
	
	//document.forms[0].txt_stockeligible.value=Math.abs((totalvaluepage1-totalamount));
	roundtxt(document.forms[0].txt_totalunpaidstock);
	roundtxt(document.forms[0].txt_totalstock);
	

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
						<td class="Page_Flow">Home 
        	-&gt; Monthly Monitoring Reports-&gt; Monthly Monitoring -&gt;Accountwise 
      		  Details -&gt;MSOD-&gt;Stock Eligible
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
            <td width="20%"  class="sub_tab_inactive"  align="center"  id="prin" ><b><a href="javascript:call_page('mon_accountwisedetails.jsp','getAccountwise')" >Account-Wise Details</a></b> </td>
            <%if(Helper.correctNull((String)hshValues.get("mon_msod")).equalsIgnoreCase("y"))
		 				 {%>
            <td width="20%"  class="sub_tab_active"  align="center" id="prin"><b>MSOD
               </b></td>
            <%} 
              if( Helper.correctNull((String)hshValues.get("mon_qpr")).equalsIgnoreCase("y")){%>
            <td width="20%" class="sub_tab_inactive"   align="center"  id="prin"><b><a href="javascript:call_page('mon_qprperformance.jsp','getQprPerformance')" >QPR
              </a></b></td>
              <%}
		  %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
						<lapschoice:MonMSODTag msod='<%=strmsod%>' stock='<%=strstock%>' bookdebts='<%=strbkdebts%>' pageid="4"/>
						<lapschoice:Monitor strSource="MMR"/>
  <table width="79%" border="0" cellspacing="0" cellpadding="4" align="center" class="outertable border1" height="406">
    <tr> 
            
      <td> 
      <table width="100%" border="0" cellspacing="0" cellpadding="4" align="center" class="outertable" height="389">
          <tr>
		    <td width="4%" height="38"><font size="1" face="MS Sans Serif"><b>A</b></font> 
            <td width="76%" height="38"><font size="1" face="MS Sans Serif">Value of stock procured under LC/ LG but not paid. Stocks against devolved LC's and invoked guarantees</font> 
            </td>
            <td colspan="" height="38" width="20%">&nbsp; 
             <lapschoice:CurrencyTag name="txt_stocklc" size="20" maxlength="15"  onBlur="allTotal()" value='<%=Helper.correctNull((String)hshValues.get("mmr_stocklc"))%>'/>
            </td>
          </tr>
          <tr> 
		    <td width="4%" height="38"><font size="1" face="MS Sans Serif"><b>B</b></font> 
            <td width="76%" height="38"><font size="1" face="MS Sans Serif">Value of unpaid stock (under creditors / supplier credit / co acceptance) user defined.</font> 
            </td>
            <td colspan="" height="38" width="20%">&nbsp; 
              <lapschoice:CurrencyTag name="txt_stockcreditor" size="20" maxlength="15"  onBlur="allTotal()" value='<%=Helper.correctNull((String)hshValues.get("mmr_stockcreditor"))%>'/>
            </td>
            
          </tr>
	   <tr> 
		    <td width="4%" height="38"><font size="1" face="MS Sans Serif"><b></b></font> 
            <td width="76%" height="38"><font size="1" face="MS Sans Serif">Total of Unpaid Stocks (A+B) 
</font> 
            </td>
            <td colspan="" height="38" width="20%">&nbsp; 
              <lapschoice:CurrencyTag name="txt_totalunpaidstock" size="20" maxlength="15"  onBlur="allTotal()" value='<%=Helper.correctNull((String)hshValues.get("mmr_totalunpaidstock"))%>'/>
            </td>
            
          </tr>
          <tr> 
		    <td width="4%" height="38"><font size="1" face="MS Sans Serif"><b>C</b></font> 
            <td width="76%" height="38"><font size="1" face="MS Sans Serif">Value of Stock not consider for Drawing Power (Stocks older than<input type="text" name="txt_days" size="20" maxlength="15" onKeyPress="allowNumber(document.forms[0].txt_days)" value="<%=Helper.correctNull((String)hshValues.get("mmrdays"))%>">  days)    </font> </td>
            <td colspan="" height="38" width="20%">&nbsp; 
              <lapschoice:CurrencyTag name="txt_stocknotdp" size="20" maxlength="15"  onBlur="allTotal()" value='<%=Helper.correctNull((String)hshValues.get("mmr_stocknotdp"))%>'/>
            </td>
         
          </tr>
          <tr> 
		    <td width="4%" height="38"><font size="1" face="MS Sans Serif"><b>D</b></font> 
            <td width="76%" height="38"><font size="1" face="MS Sans Serif">Value of other assets (not reckoned for Drawing Power) ie. Slow moving /obsolete item / user defined.</font> </td>
            <td colspan="" height="38" width="20%">&nbsp; 
              <lapschoice:CurrencyTag name="txt_otherasset" size="20" maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("mmr_otherasset"))%>'/>
            </td>
             </tr>
          <tr> 
		    <td width="4%" height="38"><font size="1" face="MS Sans Serif"><b>E</b></font> 
            <td width="76%" height="38"><font size="1" face="MS Sans Serif">Value of Stock meant for pre-shipment finance (Packing Credit)</font> </td>
            <td colspan="" height="38" width="20%">&nbsp; 
             <lapschoice:CurrencyTag name="txt_packingcredit" size="20" maxlength="15"  onBlur="allTotal()" value='<%=Helper.correctNull((String)hshValues.get("mmr_packingcredit"))%>'/>
            </td>
              </tr>
          <tr> 
		    <td width="4%" height="38"><font size="1" face="MS Sans Serif"><b>F</b></font> 
            <td width="76%" height="38"><font size="1" face="MS Sans Serif">Value of stock earmarked for other banks/financing agencies</font> </td>
            <td colspan="" height="38" width="20%">&nbsp; 
             <lapschoice:CurrencyTag name="txt_stockearmarked" size="20" maxlength="15"  onBlur="allTotal()" value='<%=Helper.correctNull((String)hshValues.get("mmr_stockearmarked"))%>'/>
            </td>
          </tr>
          <tr> 
		    <td width="4%" height="38"><font size="1" face="MS Sans Serif"><b>I</b></font> 
            <td width="76%" height="38"><font size="1" face="MS Sans Serif">Total Stock to be excluded for calculation of Drawing Power for Cash Credit/Demand Loan (A+B+C+D+E+F)
              </font> </td>
            <td colspan="" height="38" width="20%">&nbsp; 
              <lapschoice:CurrencyTag name="txt_totalstock" size="20" maxlength="15"  onBlur="allTotal()" value='<%=Helper.correctNull((String)hshValues.get("mmr_totalstock"))%>'/>
            </td>
          </tr><!--
	   <tr> 
		    <td width="4%" height="38"><font size="1" face="MS Sans Serif"><b>III</b></font> 
            <td width="76%" height="38"><font size="1" face="MS Sans Serif">Stock eliglible for calculation of Drawing Power for CASH CREDIT/DEMAND LOAN ACCOUNTS (I-II)</font> </td>
            <td colspan="" height="38" width="20%">&nbsp; 
             <lapschoice:CurrencyTag name="txt_stockeligible" size="20" maxlength="15"  value='<%//=Helper.correctNull((String)hshValues.get("mmr_stockeligible"))%>'/>
            </td>
          </tr>
		  
		  --><tr> 
		    <td width="4%" height="38"><font size="1" face="MS Sans Serif"><b></b></font> 
            <td width="76%" height="38"><font size="1" face="MS Sans Serif">Whether packing credit is excluded</font> </td>
            <td colspan="" height="38" width="20%">&nbsp; 
            <select name="sel_packingcredit" onchange="disablebutton()">
                          <option value="0">select</option>
                          <option value="1">Yes</option>
                          <option value="2">No</option>
                        </select></td>
          </tr>
        </table>
            </td>
          </tr>
          
        </table>
	<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trial_DP Excluding PC_DP Including PC' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
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

