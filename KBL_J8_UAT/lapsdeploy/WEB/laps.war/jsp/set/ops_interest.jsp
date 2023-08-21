<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%String strintid = "";
			String strWrkflowtype = Helper.correctNull(request
					.getParameter("wrk_flowtype1"));
			if (strWrkflowtype.equals("")) {
				strWrkflowtype = "fixed";
			}
			if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
			}
			if (hshValues != null) 
			{
				strintid =   Helper.correctNull((String) hshValues.get("PRDINT_SNO"));				
			}			
			String strprdtype=Helper.correctNull((String)request.getParameter("prdtype"));%>
<html>
<head>
<title>Setup(Products)</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script>
var val = "<%=request.getParameter("hidval")%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var button;
var workid   = new Array();
var termfrom = new Array();
var termto   = new Array();
var termint  = new Array();
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";

function loadUsedApp()
{
	document.forms[0].cmdedit.disabled=true;
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].cmdcancel.disabled=true;
	document.forms[0].cmddelete.disabled=true;
	document.forms[0].cmdclose.disabled=false;
	if(val=="existing")
	{
		ShowAlert(144);
	}	
}

function enableButtons(bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
	document.forms[0].cmddelete.disabled=bool6;
}
function totalInt(val)
{
	var baserate = parseFloat(document.forms[0].baserate.value);
	var adjrate  = parseFloat(document.forms[0].adjust.value);
	if(baserate == null || isNaN(baserate))
	{
		baserate = 0.00;
	}
	if(adjrate == null || isNaN(adjrate))
	{
		adjrate = 0.00;
	}
	document.forms[0].total.value = roundVal(baserate + adjrate);
}

function callFlowtype(type)
{
	if(!document.forms[0].cmdsave.disabled)
	{
		ShowAlert(103);
	}
	else
	{
		document.forms[0].wrk_flowtype1.value=type;
		document.forms[0].action=appUrl+"action/ops_interest.jsp?wrk_flowtype1="+type;
		document.forms[0].submit();
	}
}	

function loadValues()
{
	for(i=0;i<document.forms[0].prdCode.length;i++)
	{
		if(document.forms[0].hidId.value == document.forms[0].prdCode[i].value)
		{
			if(document.forms[0].hidId.value==0)
			{
				document.forms[0].prdCode.selectedIndex=0;
			}
			else
			{
				document.forms[0].prdCode.selectedIndex=i;
			}
		}	
	}	
	selindex=document.forms[0].prdCode[document.forms[0].prdCode.selectedIndex].value;
	if(selindex=='')
	{
		enableButtons(true,true,true,false,true);
	}
	else
	{
		enableButtons(false,true,true,false,true);
	}
	document.forms[0].amtfrom.readOnly="true";
   	document.forms[0].amtto.readOnly="true";
}

function doEdit()
{
	if(document.forms[0].prdCode[document.forms[0].prdCode.selectedIndex].value == "")
	{
		alert("Select Interest Range");
		return;
	}
	button="e";
	enableButtons(true,false,false,true,false);
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].readOnly=false;
		}
	}
	for(var i=0;i<document.forms[0].baserate.length;i++)
	{
		document.forms[0].baserate[i].readOnly=true;
	}
	document.forms[0].prdCode.disabled=false;
	document.forms[0].prdCode.readOnly=true;
	document.forms[0].total.readOnly=true;
}

function doSave()
{
	var flag = true;
	if (document.forms[0].wrk_flowtype1.value == "" )
	{
		document.forms[0].wrk_flowtype1.value = "fixed"
	}
	work="<%=strWrkflowtype%>";
	if (work == "")
	{
		work="fixed";
	}	
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].total.readOnly=false;	
	document.forms[0].hidRecordflag.value=varRecordFlag;
	document.forms[0].hidBeanId.value="setinterest";
	document.forms[0].hidAction.value="update";
	document.forms[0].hidBeanMethod.value="updateInterestData";
	document.forms[0].hidBeanGetMethod.value="getInterestData";
	document.forms[0].hidSourceUrl.value="/action/ops_interest.jsp";
	document.forms[0].action=appUrl+"controllerservlet?work="+work;
	document.forms[0].submit();
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
		work="<%=strWrkflowtype%>";
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanId.value="setinterest";
		document.forms[0].hidBeanMethod.value="updateInterestData";
		document.forms[0].hidBeanGetMethod.value="getInterestData";
		document.forms[0].hidSourceUrl.value="/action/ops_interest.jsp";
		document.forms[0].action=appUrl+"controllerservlet?work="+work;	
		document.forms[0].submit();
	}
}
function opendis(num)
{
	var purl = appUrl+"jsp/set/floatselect?identity=floating&num="+num;
	var prop = "scrollbars=no,width=350,height=320";	
	var title = "InterestRate";
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 320) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,title,prop);
}

function opendisfixed(num,field)
{
	if (document.forms[0].cmdsave.disabled == false)
	{
		var flag="ops";
		var purl = appUrl+"action/fixedselect.jsp?val=fixedselect&num="+num+"&baserate="+field+"&flag="+flag+"&identity=floating";
		var prop = "scrollbars=no,width=450,height=360";	
		var title = "InterestRate";
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 320) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,title,prop);
	}
}

function doCancel()
{
	if (ConfirmMsg(102))
	{
		work="<%=strWrkflowtype%>";
	    document.forms[0].hidBeanId.value="setinterest";
		document.forms[0].hidBeanMethod.value="getInterestData";
		document.forms[0].hidSourceUrl.value="/action/ops_interest.jsp";
		document.forms[0].action=appUrl+"controllerservlet?work="+work;
		document.forms[0].submit();		
		document.forms[0].prdCode.value="";
		enableButtons(false,true,true,false,true);
	}
}

function doClose()
 {
	 if(ConfirmMsg(100))
	 {
		 document.forms[0].action=appUrl+"action/setupnav.jsp";
		 document.forms[0].submit();
	 }
 }

function showdata()
{
	var flag="";
	selindex=document.forms[0].prdCode[document.forms[0].prdCode.selectedIndex].value;
	work="<%=strWrkflowtype%>";
	if (work == "")
	{
		work="fixed";
	}
	document.forms[0].hidId.value = document.forms[0].prdCode[document.forms[0].prdCode.selectedIndex].value ;
	document.forms[0].hidBeanId.value="setinterest";
	document.forms[0].hidBeanGetMethod.value="getInterestData";
	//document.forms[0].hidSourceUrl.value="/action/ops_interest.jsp";
	document.forms[0].action=appUrl+"action/ops_interest.jsp?work="+work+"&flag=yes";;
	document.forms[0].submit();
	
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
</head>
<body onLoad="loadValues()">
<form name="documentsfrm" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Setup -&gt; Tertiary Products -&gt; Interest</td>
	</tr>
</table><br>
<table width="90%" border="0" cellspacing="0" cellpadding="3" class="outertable border1" align="center">
	<tr>
		<td valign="middle">
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">					
					<tr>
						<td colspan="4">						
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
							<tr>
								<td width="25%">Select Interest Range</td>
								<td width="75%"><select name="prdCode"
									onChange="javascript:showdata()">
									<option  selected>-------Select-------</option>
									<lapschoice:productcode />
								</select></td>
							</tr>
						</table>
						<br>
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
							<tr>
								<td width="25%">Amount Range From &nbsp;<b><%=ApplicationParams.getCurrency()%></b></td>
								<td width="24%"><lapschoice:CurrencyTag name="amtfrom" maxlength="18"
									tabindex="2" size="18" value='<%=Helper.correctNull((String) hshValues.get("PRD_AMTRANGEFROM"))%>'/></td>
						 <td width="24%">Amount Range To &nbsp; <b><%=ApplicationParams.getCurrency()%></b></td>
								<td width="27%"><lapschoice:CurrencyTag name="amtto" maxlength="18"
									tabindex="3" size="18" value='<%=Helper.correctNull((String) hshValues.get("PRD_AMTRANGETO"))%>'/></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				<br>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td width="17%" >Reference Rate</td>						
						<td width="13%"><input type="text" name="baserate"
							maxlength="8" readonly onKeyPress="allowInteger()" size="12"
							value="<%=Helper.correctNull((String) hshValues.get("PRD_BASERATE"))%>"> <span onClick="opendisfixed('0','baserate')"
							style="cursor:hand" tabindex=><b><img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"></b></span></td>							
						<td width="14%" >Adjustments (+/-)
						</td>
						<td width="18%"><input type="text" name="adjust"
							maxlength="8" size="12" tabindex="" onBlur="totalInt('0')"
							value="<%=Helper.correctNull((String) hshValues.get("PRD_ADJUST"))%>"></td>
					</tr>
					<tr>
						<td width="17%" >Interest Rate (%)</td>
						<td width="16%">
						<input type="text" name="total" maxlength="8"
							onKeyPress="allowNumber(this)" size="12" style="text-align: right"
							onBlur="checkPercentage(this),roundtxt(this)" value="<%=Helper.correctNull((String) hshValues.get("PRD_INTEREST"))%>"></div>
							<input type="hidden" name="interestid" maxlength="8" readonly >
						</td>
					</tr>
				</table>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="prd_code1" value="<%=request.getParameter("prdCode")%>"> 
<input type="hidden" name="wrk_flowtype1" value="fixed">
<input type=hidden name="hidId" value="<%=Helper.correctNull((String)hshValues.get("strPrdCode"))%>"> 
 <input type=hidden name="prdtype" value="<%=strprdtype%>">
 <input type=hidden name="prdsno" value="<%=strintid%>"> 
 <input type ="hidden" name ="hidkeyid" value="set">
</form>
</body>
</html>
