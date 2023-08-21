<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	if (objValues instanceof java.util.HashMap) 
	{
		hshValues = (java.util.HashMap) objValues;
	}	
	String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
	java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
	nf.setGroupingUsed(false);
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
	String strCategory=Helper.correctNull((String)request.getParameter("hidCategoryType"));
	ArrayList vecRow=new ArrayList();
	ArrayList vecCol=new ArrayList();
	if(hshValues!=null)
	{
		vecRow=(ArrayList)hshValues.get("vecData");
	}
	long lngtotshares = 0;
	double dbltotfaceval = 0.00;
	double dbltotamount = 0.00;
	
	String strValuesIn="";
	strValuesIn=Helper.correctNull((String)hshValues.get("strValuesIn"));
%>
<html>
<head>
<title>Commercial-Principal (s)</title>

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var varStrValuesin="<%=strValuesIn%>";

function selectValues(val1,val2,val3,val4,val5,val0,val6,val8)
{	document.forms[0].sel_sharesheldby.value=val6;
	document.forms[0].txt_noofshares.value=val2;
	document.forms[0].txt_facevalue.value=val3;
	document.forms[0].txt_amount.value=val4;
	document.forms[0].txt_perc.value=val5;
	document.forms[0].hidsno.value=val0;
	document.forms[0].txt_name.value=val8;


	if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
		disableCommandButtons(true,false,true,false,false,false);
	}
	
	
}
function doSave()
{
	if(document.forms[0].sel_sharesheldby.value=="0")
	{
		alert("Select Shares Held by");
		document.forms[0].sel_sharesheldby.focus();
		return;
	}
	if(document.forms[0].txt_name.value=="")
	{
		alert("Enter name");
		document.forms[0].txt_name.focus();
		return;
	}
	if(document.forms[0].txt_noofshares.value=="0.00" || document.forms[0].txt_noofshares.value=="")
	{
		alert("Enter No. of Shares held");
		document.forms[0].txt_noofshares.focus();
		return;
	}
	if(document.forms[0].txt_facevalue.value=="0.00" || document.forms[0].txt_facevalue.value=="")
	{
		alert("Enter Face Value");
		document.forms[0].txt_facevalue.focus();
		return;
	}
	if(document.forms[0].txt_amount.value=="0.00" || document.forms[0].txt_amount.value=="")
	{
		alert("Enter Amount");
		document.forms[0].txt_amount.focus();
		return;
	}
	if(document.forms[0].txt_perc.value=="0.00" || document.forms[0].txt_perc.value=="")
	{
		alert("Enter % of Holding");
		document.forms[0].txt_perc.focus();
		return;
	}	

	document.forms[0].cmdsave.disabled = true;	
	document.forms[0].hidBeanId.value="executive";
	document.forms[0].hidSourceUrl.value="/action/com_shareholdpattern.jsp";
	document.forms[0].hidBeanMethod.value="updateShareHoldPattern";
	document.forms[0].hidBeanGetMethod.value="getDataShareHoldPattern";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function disableCommandButtons(valnew,valedit,valapply,valcancel,valdel,valclose)
{
	document.forms[0].cmdnew.disabled =valnew;
	document.forms[0].cmdedit.disabled=valedit;
	document.forms[0].cmddelete.disabled=valdel;
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmdclose.disabled=valclose;
	document.forms[0].cmdcomments.disabled=false;
}
function doEdit()
{
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons(true,true,false,false,false,true);
	document.forms[0].txt_amount.readOnly = true;
	document.forms[0].txt_perc.readOnly = true;	
}

function doNew()
{
	disableFields(false);
	disableCommandButtons(true,true,false,false,true,true);	
	document.forms[0].hidAction.value ="insert";
	document.forms[0].txt_amount.readOnly = true;
	document.forms[0].txt_perc.readOnly = true;
}
function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="executive";
		document.forms[0].hidBeanGetMethod.value="getDataShareHoldPattern";
		document.forms[0].action=appURL+"action/com_shareholdpattern.jsp";
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
		if(document.forms[0].elements[i].type=='textarea')
		{
			document.forms[0].elements[i].readOnly=val;
		}	 
		if(document.forms[0].elements[i].type=="radio")
		{
			document.forms[0].elements[i].disabled=(!val);		  
		} 
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=val;		  
		} 
	}
	
}
function doDelete()
{

		if(ConfirmMsg(101))
		{
			
		   	document.forms[0].hidAction.value ="delete";		
			document.forms[0].hidBeanMethod.value="updateShareHoldPattern";
			document.forms[0].hidBeanId.value="executive";
			document.forms[0].hidBeanGetMethod.value="getDataShareHoldPattern";
			document.forms[0].action=appURL+"action/ControllerServlet";	
			document.forms[0].hidSourceUrl.value="/action/com_shareholdpattern.jsp";			
			document.forms[0].method="post";			
			document.forms[0].submit();	
		}	
}
function onloading()
{
	disableFields(true);
	document.forms[0].cmdcomments.disabled=false;
	document.forms[0].txt_mktvalofshares.value = "<%=hshValues.get("MrktValOfShares")%>";	
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/corppge.jsp";
		document.forms[0].submit();
	}
}

function callCalender(fname)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	}
}
function callLink(page,bean,method)
{ 
	if (document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidAction.value="";
	 	document.forms[0].hidBeanGetMethod.value=method;
	 	document.forms[0].hidBeanId.value=bean;
	 	document.forms[0].action=appURL+"action/"+page;
	 	document.forms[0].submit();
	}
	else 
	{
		ShowAlert(103);
	}
}

function doComments()
{
	var btnenable=document.forms[0].btnenable.value;
	var hidAppNo=document.forms[0].hidappno.value;
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/comments.jsp?hidBeanId=perfinancial&hidBeanGetMethod=getComments&hidAppNo="+hidAppNo+"&hidCommentPage=shareholdpattern&appstatus="+appstatus+"&btnenable="+btnenable;
	window.open(url,"Comments",prop);
}

function calculateAmount()
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var vartxt_facevalue = document.forms[0].txt_facevalue.value;
		var vartxt_noofshares = document.forms[0].txt_noofshares.value;
		var varAmount=eval(vartxt_facevalue*vartxt_noofshares);
		if(varStrValuesin=="R")
		{
			varAmount=varAmount;
		}
		else if(varStrValuesin=="L")
		{
			varAmount=varAmount/100000;
		}
		else if(varStrValuesin=="C")
		{
			varAmount=varAmount/10000000;
		}
		else
		{
			varAmount=varAmount;
		}
		document.forms[0].txt_amount.value =  eval(varAmount);
	}
}

function calculatePercentHolding()
{
	var vartxt_perc = "";
	if(document.forms[0].cmdsave.disabled==false)
	{
		var vartxt_noofshares1 = document.forms[0].txt_noofshares.value;
		var vartotalShares = document.forms[0].totShares.value;
		vartotalShares = eval(vartotalShares) + eval(vartxt_noofshares1);  
		vartxt_perc = eval((vartxt_noofshares1*100)/vartotalShares);
		document.forms[0].txt_perc.value = vartxt_perc;
	    roundtxt(document.forms[0].txt_perc); 
	}
}


</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<style>
.selectwidth
{
	width: 150px;
}
</style>
</head>
<body onLoad="onloading();">
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
<form name="frmpri" method="post" class="normal">
  <iframe height="0" width="0" id="ifrm" frameborder="0"
	style="border:0"></iframe>
	 <%if(strCategory.equalsIgnoreCase("RET")){ %> 
        <jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="12" />
        </jsp:include>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center"  class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt; 
       Retail -&gt; Application -&gt; Banking Arrangement-&gt;Group Concerns </td>
    </tr>
  </table>
  <%}
	 else
	 { %>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top"><jsp:include page="../share/applurllinkscom.jsp"
			flush="true">
			<jsp:param name="pageid" value="2" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">
		<%
			if (strCategoryType.equalsIgnoreCase("SRE")) {
		%> Home -&gt;Corporate &amp; SME -&gt; Short Review/Extension -&gt;
		Group Concerns <%
			} else if (strCategoryType.equalsIgnoreCase("STL")) {
		%> Home -&gt;Corporate &amp; SME -&gt; Short Term Loan -&gt; Group
		Concerns <%
			} else if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%> Home -&gt; Agriculture -&gt; Application-&gt;Co-Applicant / Guarantor-&gt;
		Share Holding Pattern <%
 	}else
 	{%>
 		Home -&gt; Corporate &amp; SME -&gt; Application-&gt;Co-Applicant / Guarantor-&gt; Share Holding Pattern 
 	<%}
 %>
		</td>
	</tr>
</table>
<%} %>
<span style="display: none;"><lapschoice:borrowertype /></span> <lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	align="center" class="outertable">
	<tr align="center">
		<td valign="bottom">
		 <%if(strCategory.equalsIgnoreCase("RET")){ 
		 %> 
		 <table border="0" cellspacing="2" cellpadding="3"
			align="left" class="outertable">
			<tr>
			<td class="sub_tab_inactive" id="prin"><b><b><a
					href="#" onclick="javascript:callLink('combankingfi.jsp','bankappfi','getData')">  Existing  Banking Details</a></b></b></td>
		    <td class="sub_tab_active" id="prin" nowrap><b>  Group Concerns </b></td>
			</tr>
			</table>
		 <%}else { %>
		<table border="0" cellspacing="2" cellpadding="3"
			align="left" class="outertable">
			<tr>
				<td class="sub_tab_inactive" id="prin"><b> <a
					href="#" onclick="javascript:callLink('compromoters.jsp','compro','getProData')">Co-Applicant / Guarantor
				</a></b></td>
				<%
					if (strCategoryType.equalsIgnoreCase("CORP")
							|| strCategoryType.equalsIgnoreCase("SME")) {
				%>
				<!-- <td class="sub_tab_inactive" id="prin"><b><b><a
					href="#" onclick="javascript:callLink('com_companybackground.jsp','compro','getCompanyBackground')">Promoter
				Company / Group Companies Background</a></b></b></td> -->
				<%
					}
				%>
					<td class="sub_tab_inactive" nowrap="nowrap"><b><b><a href="javascript:callLink('comgroupcompanies.jsp','executive','getData7')">Group
				Concerns</a></b></b></td>
								
				<td class="sub_tab_active" id="prin" nowrap><b>Share Holding Pattern</b></td>
				<td class="sub_tab_inactive" nowrap="nowrap"><b><b><a href="javascript:callLink('com_promocomments.jsp','compro','getgroupcomments')">Comments</a></b></b></td>
				</tr>
		</table>
		<%} %>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="40%" border="0" cellspacing="1" cellpadding="3"
			class="outertable">
			<tr align="center">
			    <td align="center" class="sub_tab_active"><b>Share Holders</b></td>			    
				<td class="sub_tab_inactive" align="center"><a
							href="javascript:callLink('com_natureofshares.jsp','executive','getDataNatureOfShares')"><b>Nature of Shares</b></a></td>
				<td align="center" class="sub_tab_inactive"><a
							href="javascript:callLink('com_capitalmarketinfo.jsp','executive','getCaptialMarketInfo')"><b>Capital Market info</b></a></td>				
		      
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable border1">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
								
									<tr>
										<td>&nbsp;</td>
										<td>
											Market value of the shares&nbsp;
										</td>
										<td align="left">
											<input type="text" name="txt_mktvalofshares" size="30" maxlength="20" onkeypress="allowNumber(this)" onblur="roundtxt(this);" style="text-align: right"/>
										</td>
										<td colspan="2">&nbsp;</td>
									</tr>
									<tr align="center" class="dataheader">									
									 <td width="20%">Shares Held by&nbsp;<b><span class="mantatory">*</span></b></td>
									 <td width="15%">Name&nbsp;<b><span class="mantatory">*</span></b></td>
									 <td width="15%">No. of Shares held&nbsp;<b><span class="mantatory">*</span></b></td>
									  <td width="20%">Face Value(in Rs.)&nbsp;<b><span class="mantatory">*</span></b></td>
									   <td width="20%">Amount&nbsp;<b><span class="mantatory">*</span></b></td>
									    <td width="10%">% of Holding&nbsp;<b><span class="mantatory">*</span></b></td>									
									</tr>
									<tr align="center" class="datagrid">
																	
								     <td width="20%"><select name="sel_sharesheldby">
								      <option value="0" selected="selected" >--Select--</option>
                      				 <lapschoice:StaticDataTag apptype="139"/> 
								     </select></td>
								     <td width="15%"><input type="text" name="txt_name" size="20" maxlength="50" onkeypress="allowAlphabetsForName()"></td>
								     <td width="15%"><input type="text" name="txt_noofshares" size="18" maxlength="15" onkeypress="allowInteger()" onblur="calculateAmount();calculatePercentHolding()"></td>
								     <td width="20%"><input type="text" name="txt_facevalue" size="30" maxlength="20" onkeypress="allowNumber(this)" onblur="roundtxt(this);calculateAmount()" style="text-align: right"></td>
								      <td width="20%"><input type="text" name="txt_amount" size="30" maxlength="20" onkeypress="allowNumber(this)" onblur="roundtxt(this)" style="text-align: right"></td>	
								      <td width="10%"><input type="text" name="txt_perc" size="15" maxlength="12" onkeypress="allowNumber(this)" onblur="roundtxt(this);checkPercentage(this)" style="text-align: right"></td>																	
									</tr>
								</table>
							</td>
						</tr>
						<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Comments_Audit Trail'  
						btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
						
								<br>
							<tr><td>&nbsp;&nbsp;</td></tr>
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
									<tr class="dataheader">
									<td width="5%">&nbsp;</td>
								     <td width="20%" align="center">Shares Held by</td>
								     <td width="20%" align="center">Name</td>
								     <td width="20%"  align="center">No. of Shares held</td>
									   <td width="20%"  align="center">Amount</td>
									    <td width="15%"  align="center">% of Holding</td>
									</tr>	
									<%if(vecRow!=null && vecRow.size()>0){
									  for(int i=0;i<vecRow.size();i++){
										  
										  vecCol=(ArrayList)vecRow.get(i);
									  
									  %>	
									 <tr class="datagrid">
									 <td><input type="radio" style="border:none" name="selradio" onclick="javascript:selectValues('<%=Helper.correctNull((String)vecCol.get(0))%>',
									 '<%=Helper.correctNull((String)vecCol.get(2))%>','<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(3))))%>',
									 '<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(4))))%>','<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(5))))%>',									
									 '<%=Helper.correctNull((String)vecCol.get(0))%>','<%=Helper.correctNull((String)vecCol.get(7))%>','<%=Helper.correctNull((String)vecCol.get(8))%>')"></td>
									 <td><%=Helper.correctNull((String)vecCol.get(1))%></td>
									  <td><%=Helper.correctNull((String)vecCol.get(8))%></td>
									 <td><%=Helper.correctNull((String)vecCol.get(2))%></td>
									 <td style="text-align: right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(4))))%></td>
									 <td style="text-align: right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(5))))%></td>
									<%
									lngtotshares = lngtotshares + Integer.parseInt(Helper.correctDouble((String)vecCol.get(2)));
									dbltotfaceval = dbltotfaceval + Double.parseDouble(Helper.correctDouble((String)vecCol.get(3)));
									dbltotamount = dbltotamount + Double.parseDouble(Helper.correctDouble((String)vecCol.get(4)));
									%>
									</tr>	
									
									<%}%>
									<tr class="datagrid">
										<td colspan="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Total</b></td>
										<td ><%=lngtotshares%></td>
										<td style="text-align: right"><%=nf.format(dbltotamount)%></td>
										<td>&nbsp;</td>
									</tr>
									<%}else{ %>
									
									 <tr class="datagrid">
									 <td colspan="8" align="center">---No Data Found--</td>
									 </tr>
									
									<%} %>						
									
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
	<lapschoice:hiddentag pageid='<%=PageId%>'/> 
	<input type="hidden" name="hidappno" value="<%=Helper.correctNull((String)request.getParameter("appno")) %>">
	<input type="hidden" name="hidsno">
	<input type="hidden" name="totShares" value="<%=lngtotshares%>"/>
</form>
</body>
</html>