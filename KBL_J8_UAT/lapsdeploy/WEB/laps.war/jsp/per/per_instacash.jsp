<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	String stroptions = " ";
	String strappnonew = request.getParameter("appno");
	request.setAttribute("_cache_refresh", "true");
	String strFreeze=Helper.correctNull((String)request.getParameter("hidFreeze"));
	String prd_typecheck = Helper.correctNull((String) session.getAttribute("strProductType"));	
	if (objValues instanceof java.util.HashMap) 
	{
		hshValues = (java.util.HashMap) objValues;
	}
	ArrayList arrRow = new ArrayList();
	ArrayList arrCol = new ArrayList();
	arrRow=(ArrayList)hshValues.get("ArrRow");
	java.text.NumberFormat jtn= java.text.NumberFormat.getInstance();
	jtn.setMaximumFractionDigits(2);
	jtn.setMinimumFractionDigits(2);
	jtn.setGroupingUsed(false);	
	
	String strPageParam = Helper.correctNull(
			(String) session.getAttribute("strModifyterms")).trim();
	%>
<html>
<head>
<title>Insta Cash</title>
<script language="JavaScript1.2">
var currdate = "<%=Helper.getCurrentDateTime()%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
function callCalender(fname)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	}
}

function disablefields(val)
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
	document.forms[0].txt_margin.readOnly=true;
	document.forms[0].txt_marginamt.readOnly=true;
	document.forms[0].txt_eligibleamt.readOnly=true;
}
function disableCommandButtons(valnew,valedit,valapply,valcancel,valdel,valclose)
{
	document.forms[0].cmdnew.disabled =valnew;
	document.forms[0].cmdedit.disabled=valedit;
	document.forms[0].cmddelete.disabled=valdel;
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmdclose.disabled=valclose;
}
function doNew()
{
	disablefields(false);
	disableCommandButtons(true,true,false,false,true,true);
	document.forms[0].hidAction.value ="insert";
}
function doEdit()
{
	disablefields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons(true,true,false,false,true,true);
}
function doSave()
{
	calculmargin();
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="perapplicant";
	document.forms[0].hidBeanMethod.value="updateinstacash";
	document.forms[0].hidBeanGetMethod.value="getinstacash";
	document.forms[0].hidSourceUrl.value="/action/per_instacash.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}


function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="perapplicant";
		document.forms[0].hidBeanGetMethod.value="getinstacash";
		document.forms[0].action=appURL+"action/per_instacash.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";		
		document.forms[0].hidBeanMethod.value="updateinstacash";
		document.forms[0].hidBeanGetMethod.value="getinstacash";
		document.forms[0].hidBeanId.value="perapplicant";
		document.forms[0].action=appURL+"action/ControllerServlet";	
		document.forms[0].hidSourceUrl.value="/action/per_instacash.jsp";			
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}	
}

function callonLoad(){
	if(appstatus=="Open/Pending"){
		disableCommandButtons(false,true,true,true,true,false);
	}else{
		disableCommandButtons(true,true,true,true,true,false)
	}
	disablefields(true);

	<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>
	document.forms[0].cmdnew.disabled = true;
	var varPSterms = document.forms[0].hidPSterms.value.split("@");
	for(var i=0;i<varPSterms.length;i++)
	{
		if((varPSterms[i] == "SEC") || (varPSterms[i] == "MODSEC"))
		{
			document.forms[0].cmdnew.disabled = false;
		}
	}
	<%}%>
}
function selValues(val1,val2,val3,val4,val5,val6,val7){
	document.forms[0].hidSno.value=val1;
	document.forms[0].txt_amount.value=val2;
	document.forms[0].txt_maturitydate.value=val3;
	document.forms[0].txt_margin.value=val4;
	document.forms[0].txt_marginamt.value=val5;
	document.forms[0].txt_eligibleamt.value=val6;
	document.forms[0].sel_sectype.value=val7;
	if(document.forms[0].btnenable.value=="Y")
	{
		disableCommandButtons(true,false,true,false,false,false);
	}
	else
	{
		disableCommandButtons(true,true,true,false,true,false);
	}
	<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>
	document.forms[0].cmdedit.disabled = true;
	var varPSterms = document.forms[0].hidPSterms.value.split("@");
	for(var i=0;i<varPSterms.length;i++)
	{
		if((varPSterms[i] == "SEC") || (varPSterms[i] == "MODSEC"))
		{
			document.forms[0].cmdedit.disabled = false;
		}
	}
	<%}%>
}
function calculmargin()
{
	var sel_sectype=document.forms[0].sel_sectype.value;
	var maturitydate=document.forms[0].txt_maturitydate.value;
	var currentdate=currdate;
	var maturitydt=maturitydate.substring(0,2);
	var maturitymon=maturitydate.substring(3,5);
	var maturityyr=maturitydate.substring(6,10);
	var currdt=currentdate.substring(0,2);
	var currmon=currentdate.substring(3,5);
	var curryr=currentdate.substring(6,10);
	var currdatenew=new Date(curryr,currmon,currdt);
	var maturitydatenew=new Date(maturityyr,maturitymon,maturitydt);
	var datediff=maturitydatenew - currdatenew;
	var yrsdiff=datediff/(60*60*24*1000*365);
	if(sel_sectype=="fv")
	{
		if(maturitydate!=""){
			if(yrsdiff>3 && yrsdiff<=4)
			{
				document.forms[0].txt_margin.value="30";
			}
			else if(yrsdiff>4 && yrsdiff<=5)
			{
				document.forms[0].txt_margin.value="40";
			}
			else if(yrsdiff>5)
			{
				document.forms[0].txt_margin.value="100";
			}
			else
			{
				document.forms[0].txt_margin.value="0";
			}
		}
	}else if(sel_sectype=="sv")
	{
		document.forms[0].txt_margin.value="10";
	}
	else{
		document.forms[0].txt_margin.value="0";
	}
	document.forms[0].txt_marginamt.value=((NanNumber(parseFloat(document.forms[0].txt_amount.value))*NanNumber(parseFloat(document.forms[0].txt_margin.value)))/100);
	document.forms[0].txt_eligibleamt.value=NanNumber(parseFloat(document.forms[0].txt_amount.value))-NanNumber(parseFloat(document.forms[0].txt_marginamt.value));

}
function callLink(url,bean,method)
{
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url;
	document.forms[0].submit();
}
</script>
</head>
<body onload="callonLoad()">
 <div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div></div>
<form class="normal" >
<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>
	<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="subpageid" value="101" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<table width="100%">
  		
  		<tr>
  			<td>
  			<table border="0" cellspacing="2" cellpadding="3" align="left" class="outertable">
			<tr>
			<td class="sub_tab_inactive" nowrap width="150px;" align="center">
			<a
					href="#" onclick="javascript:callLink('perloandetails.jsp','perapplicant','getLoanProducts')">
					<b>Loan Product</b></a></td>
			<td class="sub_tab_active" id="prin">Insta Cash</td>
			<%//if (strPageParam.contains("@GUAR@"))
			{ %>
			<td class="sub_tab_inactive"><b><b><a
					href="#" onclick="javascript:callLink('percoappguarantor.jsp','perapplicant','getCoAppGuarantor')">
					Co-Applicant / Guarantor</a></b></b></td>
					<%} %>
			</tr>
			</table>
  			</td>
  		</tr>
  </table>
	<%}else{ %>
  <table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable">
    <tr> 
      <td>
        <jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="1" />
        </jsp:include>
      </td>
    </tr>
    <tr> 
      <td class="page_flow">Home -&gt; Retail -&gt; Application -&gt; Loan Particulars -&gt; Insta cash</td>
    </tr>
  </table>
  <lapschoice:application /> 
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td valign="bottom"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0"
			align="left" class="outertable">
          <tr align="center"> 
            <td>
              <jsp:include page="../per/applicanttab.jsp" flush="true"> 
              <jsp:param name="linkid" value="24" />
              </jsp:include>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <%} %>
  <table width="100%" border="1" cellspacing="0" cellpadding="5" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td>
						</td>
					</tr>
					<tr><td align="center">
					<table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
					<tr class="dataheader">
					<td align="center">Type of Security</td>
					<td align="center">Amount</td>
					<td align="center">Maturity Date</td>
					<td align="center">Margin (%)</td>
					<td align="center">Margin Amount</td>
					<td align="center">Eligible Amount</td>
					</tr>
					<tr>
						<td align="center"><select name="sel_sectype">
						<option value="s"><---select---></option>
						<option value="fv">Face Value of NSC/KVP</option>
						<option value="sv">Surrender Value of Life Policies / Post Office TD</option>
						</td>
						<td align="center"><input type="text" name="txt_amount" size="15" onkeypress="allowInteger()" onblur="roundtxt(this);calculmargin();" style="text-align: right">
						</td>
						<td align="center"><input type="text"  name="txt_maturitydate"  onblur="checkDate(this);checkmindate(this,currdate);calculmargin();">&nbsp;<a alt="Select date from calender" tabindex="3"
												href="javascript:callCalender('txt_maturitydate')"><img
												src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
												border="0"></a>
						</td>
						<td align="center"><input type="text"  name="txt_margin"  size="5" onkeypress="allowInteger()" onblur="checkPercentage(this);roundtxt(this);" style="text-align: right">
						</td>
						<td align="center"><input type="text"  name="txt_marginamt"  size="15" onkeypress="allowInteger()" onblur="roundtxt(this);" style="text-align: right">
						</td>
						<td align="center"><input type="text"  name="txt_eligibleamt" size="15" onkeypress="allowInteger()" onblur="roundtxt(this);" style="text-align: right">
						</td>
					</tr>
					</table>
					</td></tr>
					
			<tr><td>&nbsp;</td></tr>		
			<lapschoice:combuttonnew btnnames="New_Edit_Save_Delete_Cancel_Audit Trail"
								btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/><br>
	</table>
	</td>
	</tr>
	<tr><td align="center">
					<table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
					<tr class="dataheader">
					<td align="center"></td>
					<td align="center">Type of Security</td>
					<td align="center">Amount</td>
					<td align="center">Maturity Date</td>
					<td align="center">Margin (%)</td>
					<td align="center">Margin Amount</td>
					<td align="center">Eligible Amount</td>
					</tr>
					<%double totaleligibleamt=0.00;
					if(arrRow!=null && arrRow.size()>0){
						for(int i=0;i<arrRow.size();i++){
							arrCol = (ArrayList)arrRow.get(i);%>
					<tr  class="datagrid">
					<td align="center"><input type="radio" name="sno" style="border-style:none" onclick="selValues('<%=Helper.correctNull((String) arrCol.get(0))%>','<%=Helper.checkDecimal((String) arrCol.get(2))%>','<%=Helper.correctNull((String) arrCol.get(3))%>','<%=Helper.checkDecimal((String) arrCol.get(4))%>','<%=Helper.checkDecimal((String) arrCol.get(5))%>','<%=Helper.checkDecimal((String) arrCol.get(6))%>','<%=Helper.correctNull((String) arrCol.get(7))%>')"></td>
					<td align="center"><%=Helper.correctNull((String) arrCol.get(1))%></td>
					<td align="right"><%=Helper.checkDecimal((String) arrCol.get(2))%></td>
					<td align="center"><%=Helper.correctNull((String) arrCol.get(3))%></td>
					<td align="right"><%=Helper.checkDecimal((String) arrCol.get(4))%></td>
					<td align="right"><%=Helper.checkDecimal((String) arrCol.get(5))%></td>
					<%double amount=Double.parseDouble(Helper.checkDecimal((String) arrCol.get(6)));
					totaleligibleamt=totaleligibleamt+amount; %>
					<td align="right"><%=Helper.checkDecimal((String) arrCol.get(6))%></td>
					</tr>
					<%}} %>
					<tr class="datagrid">
						<td colspan="6" align="right">Total Eligible Loan Amount
						</td>
						<td align="right"><%=jtn.format(totaleligibleamt) %>
						</td>
					</tr>
					</table>
					</td></tr>
	</table>
	</td>
	</tr>
	</table>
	<lapschoice:hiddentag pageid='<%=PageId%>'/>
	<input type="hidden" name="hidSno" value="">
	<input type="hidden" name="hidGrossRent" value="<%=Helper.correctNull((String)hshValues.get("dblMonthlyRent"))%>">	
	<input type="hidden" name="hidTotalRent" value="<%=Helper.correctNull((String)hshValues.get("dblTotalMonthRent"))%>">
	<input type="hidden" name="hidSelectedRent" value="">
	<input type="hidden" name="hidPSterms" value="<%=Helper.correctNull((String) hshValues.get("strModifyterms"))%>">
  </form>
</body>
</html>