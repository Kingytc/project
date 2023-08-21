<%@include file="../share/directives.jsp"%>
<%
	String bowid = Helper.correctNull((String) session.getAttribute("bowid"));
	String appno = Helper.correctNull((String) request.getParameter("appno"));
	if(appno.equalsIgnoreCase(""))
	{
		appno = Helper.correctNull((String) hshValues.get("appno"));
	}
	String strWCNF = Helper.correctNull((String) hshValues.get("strWCNF"));
	ArrayList vec = null;
	int vecsize=0;
	if(hshValues != null)
	{
		vec = (ArrayList)hshValues.get("vecVal");
	}
	if(vec!=null)
	{
		vecsize =vec.size();
	}
	String orglevel = Helper.correctNull((String) hshValues.get("strorglevel"));
%>
<html>
<head>
<title>Setup(Corporate & Agriculture Products) - Range Deviation</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var boreccomend=new Array();
var boreccomend2=new Array();
var doreccomend=new Array();
var doreccomend2=new Array();
var coreccomend=new Array();
var coreccomend2=new Array();
var deviation=new Array();
<%
	if((!vec.equals(null)))
	{
		if(vec.size()>0)
		{
			for(int i=0;i<vec.size();i++)
			{
				ArrayList newvec=(ArrayList) vec.get(i);
%>	
				boreccomend["<%=i%>"] ="<%=Helper.correctDouble((String)newvec.get(1))%>";
				boreccomend2["<%=i%>"] ="<%=Helper.correctDouble((String)newvec.get(2))%>";
				doreccomend["<%=i%>"] ="<%=Helper.correctDouble((String)newvec.get(3))%>";
				doreccomend2["<%=i%>"] ="<%=Helper.correctDouble((String)newvec.get(4))%>";
				coreccomend["<%=i%>"] ="<%=Helper.correctDouble((String)newvec.get(5))%>";
				coreccomend2["<%=i%>"] ="<%=Helper.correctDouble((String)newvec.get(6))%>";
				deviation["<%=i%>"] ="<%=Helper.correctNull((String)newvec.get(7))%>";
<%
			}
		}
	}
	else
	{
%>
		onloading();
<%
	}
%>
function roundtxt_3(trate)
{
	var temp2="";
	if(trate.value==".") trate.value=0;
	var temp1= new Number(trate.value);
	var floc=0;
	temp=new String(Math.round(temp1*1000));
	temp2=String(temp/1000);
	if (temp==0)
	{
		temp2="0.000";
	}
	if (temp2.substr(0,1)==".") temp2="0"+temp2;
	if (temp2.substr(temp2.length-3,1)==".") temp2=temp2+"0";
	if (parseInt(temp2.lastIndexOf("."))<0)
	{	
		temp2 = temp2+".000";
	}
	trate.value = temp2;
	return trate.value;
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=val
		}
		if(document.forms[0].elements[i].type=='select-one' )
		{
			document.forms[0].elements[i].disabled=val;
		}
	}
}
function onloading()
{
	for(var i=0;i<deviation.length;i++)
	{
		if(deviation[i]!="")
		{
			document.forms[0].usr_class[i].value=deviation[i];
		}
		else
		{
			document.forms[0].usr_class[i].value="";
		}
	}
	for(var i=0;i<boreccomend.length;i++)
	{
		document.forms[0].txt_borec[i].value=boreccomend[i];
	}
	for(var i=0;i<boreccomend2.length;i++)
	{
		document.forms[0].txt_borec2[i].value=boreccomend2[i];
	}
	for(var i=0;i<doreccomend.length;i++)
	{
		document.forms[0].txt_dorec[i].value=doreccomend[i];
	}
	for(var i=0;i<doreccomend2.length;i++)
	{
		document.forms[0].txt_dorec2[i].value=doreccomend2[i];
	}
	for(var i=0;i<coreccomend.length;i++)
	{
		document.forms[0].txt_corec[i].value=coreccomend[i];
	}
	for(var i=0;i<coreccomend2.length;i++)
	{
		document.forms[0].txt_corec2[i].value=coreccomend2[i];
	}
	enableButtons1(false,true,true,false);
	disableFields(true);
}
function enableButtons1(bool1,bool2,bool3,bool4)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmdclose.disabled=bool4;
}
function doEdit()
{
	disableFields(false);
	enableButtons1(true,false,false,false)
	if(("<%=orglevel%>"=="C"))	  
  	{
		for(var i = 1; i <= '<%=vecsize%>'; i++)
		{
			var selNamebo = "txt_borec";
			var selNamedo = "txt_dorec";
			var selnewvalbo = "txt_bonewval";
			var selnewvaldo= "txt_donewval";
			for(var j = 0; j<document.forms[0].length; j++)
			{
				if(document.forms[0].elements[j].name == selNamebo)
				{
					document.forms[0].elements[j].readOnly = true;
				}
				if(document.forms[0].elements[j].name == selNamedo)
				{
					document.forms[0].elements[j].readOnly = true;
				}
				if(document.forms[0].elements[j].name == selnewvalbo)
				{
					document.forms[0].elements[j].readOnly = true;
				}
				if(document.forms[0].elements[j].name == selnewvaldo)
				{
					document.forms[0].elements[j].readOnly = true;
				}
			}
		}
	}
 	if(("<%=orglevel%>"=="A")||("<%=orglevel%>"=="D"))
	{
		for(var i = 1; i <= '<%=vecsize%>'; i++)
		{
			var selNameco = "txt_corec";
			var selNamedo = "txt_dorec";
			var selnewvalco = "txt_conewval";
			var selnewvaldo= "txt_donewval";
			for(var j = 0; j<document.forms[0].length; j++)
			{
				if(document.forms[0].elements[j].name == selNameco)
				{
					document.forms[0].elements[j].disabled = true;
				}
				if(document.forms[0].elements[j].name == selNamedo)
				{
					document.forms[0].elements[j].disabled = true;
				}
				if(document.forms[0].elements[j].name == selnewvalco)
				{
					document.forms[0].elements[j].readOnly = true;
				}
				if(document.forms[0].elements[j].name == selnewvaldo)
				{
					document.forms[0].elements[j].readOnly = true;
				}
			}
		} 	
	}
	if(("<%=orglevel%>"=="R"))	  
	{
		for(var i = 1; i <= '<%=vecsize%>'; i++)
		{
			var selNamebo = "txt_borec";
			var selNameco = "txt_corec";
			var selnewvalco = "txt_conewval";
			var selnewvalbo= "txt_bonewval";
			for(var j = 0; j<document.forms[0].length; j++)
			{
				if(document.forms[0].elements[j].name == selNamebo)
				{
					document.forms[0].elements[j].disabled = true;
				}
				if(document.forms[0].elements[j].name == selNameco)
				{
					document.forms[0].elements[j].disabled = true;
				}
				if(document.forms[0].elements[j].name == selnewvalbo)
				{
					document.forms[0].elements[j].readOnly = true;
				}
				if(document.forms[0].elements[j].name == selnewvalco)
				{
					document.forms[0].elements[j].readOnly = true;
				}
			}
		}
	}
}
function doSave()
{
	if(("<%=orglevel%>"=="C"))	  
	{
		for(var i = 1; i <= '<%=vecsize%>'; i++)
		{
			var selNamebo = "txt_borec";
			var selNamedo = "txt_dorec";
			var selnewvalbo = "txt_bonewval";
			var selnewvaldo= "txt_donewval";
			for(var j = 0; j<document.forms[0].length; j++)
			{
				if(document.forms[0].elements[j].name == selNamebo)
				{
					document.forms[0].elements[j].readOnly = false;
				}
				if(document.forms[0].elements[j].name == selNamedo)
				{
					document.forms[0].elements[j].readOnly = false;
				}
				if(document.forms[0].elements[j].name == selnewvalbo)
				{
					document.forms[0].elements[j].readOnly = false;
				}
				if(document.forms[0].elements[j].name == selnewvaldo)
				{
					document.forms[0].elements[j].readOnly = false;
				}
			}
		}
	}
 	if(("<%=orglevel%>"=="A")||("<%=orglevel%>"=="D"))	  
	{
		for (var i = 1; i <= '<%=vecsize%>'; i++)
		{
			var selNameco = "txt_corec";
			var selNamedo = "txt_dorec";
			var selnewvalco = "txt_conewval";
			var selnewvaldo= "txt_donewval";
			for(var j = 0; j<document.forms[0].length; j++)
			{
				if(document.forms[0].elements[j].name == selNameco)
				{
					document.forms[0].elements[j].disabled = false;
				}
				if(document.forms[0].elements[j].name == selNamedo)
				{
					document.forms[0].elements[j].disabled = false;
				}
				if(document.forms[0].elements[j].name == selnewvalco)
				{
					document.forms[0].elements[j].readOnly = false;
				}
				if(document.forms[0].elements[j].name == selnewvaldo)
				{
					document.forms[0].elements[j].readOnly = false;
				}
			}
		}
	}
	if(("<%=orglevel%>"=="R"))	  
  	{
		for(var i = 1; i <= '<%=vecsize%>'; i++)
		{
			var selNamebo = "txt_borec";
			var selNameco = "txt_corec";
			var selnewvalco = "txt_conewval";
			var selnewvalbo= "txt_bonewval";
			for(var j = 0; j<document.forms[0].length; j++)
			{
				if(document.forms[0].elements[j].name == selNamebo)
				{
					document.forms[0].elements[j].disabled = false;
				}
				if(document.forms[0].elements[j].name == selNameco)
				{
					document.forms[0].elements[j].disabled = false;
				}
				if(document.forms[0].elements[j].name == selnewvalbo)
				{
					document.forms[0].elements[j].readOnly = false;
				}
				if(document.forms[0].elements[j].name == selnewvalco)
				{
					document.forms[0].elements[j].readOnly = false;
				}
			}
		} 	
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidAction.value = "update";
	document.forms[0].hidBeanId.value="combanking";
	document.forms[0].hidBeanMethod.value="updaterangedeviation";
	document.forms[0].hidBeanGetMethod.value="getrangedeviation";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/set_rangedeviation.jsp";
	document.forms[0].submit();
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/"+"comfacilityhome.jsp";
		document.forms[0].submit();
	}
}
function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanGetMethod.value="getrangedeviation";
		document.forms[0].hidBeanId.value="combanking";
		document.forms[0].action=appURL+"action/set_rangedeviation.jsp";	
		document.forms[0].submit();
	}	
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
</head>
<body onLoad="onloading()">
<form method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td><jsp:include page="../share/help.jsp" flush="true"/>
 <jsp:include page="../share/menus.jsp" flush="true"/>
	</td>
</tr>
</table>
<lapstab:setproductstabcorp tabid="6" />
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
	<td class="page_flow">Home -&gt; Setup -&gt; Corporate &amp; Agri Products -&gt; Facility Creation -&gt; Range Deviation</td>
</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
	<td> 
		<table width="100%" border="0" cellspacing="0" cellpadding="5">
		<tr>
			<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="5">
				<tr>
					<td valign="top">
						<table width="100%" border="0" class="outertable border1" cellspacing="0" cellpadding="0">
						<tr>
							<td valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
								<tr>
									<td><lapschoice:facility /></td>
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
<table width="98%" border="0" class="outertable border1" cellspacing="0" cellpadding="0" align="center">
<tr>
	<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
		<tr> 
        	<td colspan="2" valign="top"> 
            	<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
                <tr> 
                	<td valign="top"> 
	                    <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
						<tr class="dataheader"> 
							<td width="24%" height="47" rowspan="2" nowrap="nowrap">Deviation Parameters</td>
							<td colspan="2" height="23">
								<div align="center">Branch</div>
							</td>
							<td colspan="2" height="23"> 
								<div align="center">Hub</div>
							</td>
							<td colspan="2" height="23"> 
								<div align="center">RO/HO</div>
							</td>
							<td width="19%" nowrap="nowrap" height="47" rowspan="2"> 
								<div align="center">Class Value</div>
							</td>
						</tr>
						<tr class="dataheader"> 
							<td width="10%" height="23"> 
								<div align="center">From</div>
							</td>
							<td width="11%" height="23"> 
								<div align="center">To</div>
							</td>
							<td width="9%" height="23"> 
								<div align="center">From</div>
							</td>
							<td width="9%" height="23"> 
								<div align="center">To</div>
							</td>
							<td width="9%" height="23"> 
								<div align="center">From</div>
							</td>
							<td width="9%" nowrap="nowrap" height="23"> 
								<div align="center">To</div>
							</td>
						</tr>
						<tr> 
							<td width="24%">Repayment Period </td>
							<td width="10%"> 
								<div align="center"> 
								<input type="text" name="txt_borec" size="15" maxlength="10" 
									style="text-align:right" value="" onKeyPress="allowInteger()">
								</div>
							</td>
							<td width="11%"> 
								<div align="center"> 
								<input type="text" name="txt_borec2" size="15" maxlength="10"
									style="text-align:right" value="" onKeyPress="allowInteger()">
								</div>
							</td>
							<td width="9%"> 
								<input type="text" name="txt_dorec" size="15" maxlength="10"
									style="text-align:right" onKeyPress="allowInteger()" value="">
							</td>
							<td width="9%"> 
								<input type="text" name="txt_dorec2" size="15" maxlength="10"
									style="text-align:right" onKeyPress="allowInteger()" value="">
							</td>
							<td width="9%"> 
								<input type="text" name="txt_corec" size="15" maxlength="10"
									style="text-align:right" onKeyPress="allowInteger()" value="">
							</td>
							<td width="9%"> 
								<input type="text" name="txt_corec2" size="15" maxlength="10"
									style="text-align:right" onKeyPress="allowInteger()" value="">
							</td>
							<td width="19%"> 
								<div align="center"> 
									<select name="usr_class">
										<option value="0">Select </option>
										<lapschoice:usersclass /> 
									</select>
								</div>
							</td>
						</tr>
						<%if(strWCNF.equalsIgnoreCase("WCNF")){%>
						<tr>
							<td width="24%">Commission %</td>
							<td width="10%">
								<div align="center">
								<input type="text" name="txt_borec" size="15" maxlength="10" style="text-align:right"
									value="" onBlur="checkPercentage(this);roundtxt_3(this);" onKeyPress="allowDecimals(this)">
								</div>
							</td>
							<td width="11%">
								<div align="center">
								<input type="text" name="txt_borec2" size="15" maxlength="10" style="text-align:right"
									value="" onBlur="checkPercentage(this);roundtxt_3(this);"  onKeyPress="allowDecimals(this)">
								</div>
							</td>
							<td width="9%">
								<input type="text" name="txt_dorec" size="15"  maxlength="10"  style="text-align:right"
									onBlur="checkPercentage(this);roundtxt_3(this);"  onKeyPress="allowDecimals(this)" value="">
							</td>
							<td width="9%">
								<input type="text" name="txt_dorec2" size="15"  maxlength="10"  style="text-align:right"
									onBlur="checkPercentage(this);roundtxt_3(this);"  onKeyPress="allowDecimals(this)" value="">
							</td>
							<td width="9%">
								<input type="text" name="txt_corec" size="15"  maxlength="10"  style="text-align:right"
									onBlur="checkPercentage(this);roundtxt_3(this);" onKeyPress="allowDecimals(this)" value="">
							</td>
							<td width="9%">
								<input type="text" name="txt_corec2" size="15"  maxlength="10"  style="text-align:right"
									onBlur="checkPercentage(this);roundtxt_3(this);" onKeyPress="allowDecimals(this)" value="">
							</td>
							<td width="19%">
								<div align="center">
									<select name="usr_class">
										<option value="0">Select </option>
										<lapschoice:usersclass />
									</select>
								</div>
							</td>
						</tr>
						<%}else{%>
						<tr>
							<td width="24%">Rate of Interest</td>
							<td width="10%">
								<div align="center">
								<input type="text" name="txt_borec" size="15" maxlength="10" style="text-align:right" value="" 
									onKeyPress="allowDecimals(this)" onBlur="roundtxt(this);checkPercentage(this)">
								</div>
							</td>
							<td width="11%">
								<div align="center">
								<input type="text" name="txt_borec2" size="15" maxlength="10" style="text-align:right" value=""
									onBlur="roundtxt(this);checkPercentage(this)" onKeyPress="allowDecimals(this)">
								</div>
							</td>
							<td width="9%">
								<input type="text" name="txt_dorec" size="15" maxlength="10" style="text-align:right"
									onBlur="roundtxt(this);checkPercentage(this)" onKeyPress="allowDecimals(this)" value="">
							</td>
							<td width="9%">
								<input type="text" name="txt_dorec2" size="15" maxlength="10" style="text-align:right" 
									onBlur="roundtxt(this);checkPercentage(this)" onKeyPress="allowDecimals(this)" value="">
							</td>
							<td width="9%">
								<input type="text" name="txt_corec" size="15" maxlength="10" style="text-align:right"
									onBlur="roundtxt(this);checkPercentage(this)" onKeyPress="allowDecimals(this)" value="">
							</td>
							<td width="9%">
								<input type="text" name="txt_corec2" size="15" maxlength="10" style="text-align:right"
									onBlur="roundtxt(this);checkPercentage(this)" onKeyPress="allowDecimals(this)" value="">
							</td>
							<td width="19%">
								<div align="center">
								<select name="usr_class">
									<option value="0">Select </option>
									<lapschoice:usersclass />
								</select>
								</div>
							</td>
						</tr>
						<%}%>
						<tr>
							<td width="24%">Holiday Period </td>
							<td width="10%">
								<div align="center">
								<input type="text" name="txt_borec" size="15"  maxlength="10"
									style="text-align:right" value="" onKeyPress="allowInteger()">
								</div>
							</td>
							<td width="11%">
								<div align="center">
								<input type="text" name="txt_borec2" size="15"  maxlength="10"
									style="text-align:right" value="" onKeyPress="allowInteger()">
								</div>
							</td>
							<td width="9%">
								<input type="text" name="txt_dorec" size="15"  maxlength="10"
									style="text-align:right" onKeyPress="allowInteger()" value="">
							</td>
							<td width="9%">
								<input type="text" name="txt_dorec2" size="15"  maxlength="10"
									style="text-align:right" onKeyPress="allowInteger()" value="">
							</td>
							<td width="9%">
								<input type="text" name="txt_corec" size="15"  maxlength="10"
									style="text-align:right" onKeyPress="allowInteger()" value="">
							</td>
							<td width="9%">
								<input type="text" name="txt_corec2" size="15"  maxlength="10"
									style="text-align:right" onKeyPress="allowInteger()" value="">
							</td>
							<td width="19%">
								<div align="center">
								<select name="usr_class">
									<option value="0">Select</option>
									<lapschoice:usersclass />
								</select>
								</div>
							</td>
						</tr>
						<tr>
							<td width="24%">Processing Charges %</td>
							<td width="10%">
								<div align="center">
								<input type="text" name="txt_borec" size="15"  maxlength="10" style="text-align:right"
									value="" onBlur="checkPercentage(this);roundtxt_3(this);" onKeyPress="allowDecimals(this)">
								</div>
							</td>
							<td width="11%">
								<div align="center">
								<input type="text" name="txt_borec2" size="15"  maxlength="10" style="text-align:right"
									value="" onBlur="checkPercentage(this);roundtxt_3(this);" onKeyPress="allowDecimals(this)">
								</div>
							</td>
							<td width="9%">
								<input type="text" name="txt_dorec" size="15"  maxlength="10" style="text-align:right"
									onBlur="checkPercentage(this);roundtxt_3(this);" onKeyPress="allowDecimals(this)" value="">
							</td>
							<td width="9%">
								<input type="text" name="txt_dorec2" size="15"  maxlength="10" style="text-align:right"
									onBlur="checkPercentage(this);roundtxt_3(this);"  onKeyPress="allowDecimals(this)" value="">
							</td>
							<td width="9%">
								<input type="text" name="txt_corec" size="15"  maxlength="10" style="text-align:right"
									onBlur="checkPercentage(this);roundtxt_3(this);" onKeyPress="allowDecimals(this)" value="">
							</td>
							<td width="9%">
								<input type="text" name="txt_corec2" size="15"  maxlength="10" style="text-align:right"
									onBlur="checkPercentage(this);roundtxt_3(this);" onKeyPress="allowDecimals(this)" value="">
							</td>
							<td width="19%">
								<div align="center">
								<select name="usr_class">
									<option value="0">Select </option>
									<lapschoice:usersclass />
								</select>
								</div>
							</td>
						</tr>
						<tr>
							<td width="24%">Documentation Charges %</td>
							<td width="10%">
								<div align="center">
								<input type="text" name="txt_borec" size="15"  maxlength="10"  style="text-align:right"
									value="" onBlur="checkPercentage(this);roundtxt_3(this);" onKeyPress="allowDecimals(this)">
								</div>
							</td>
							<td width="11%">
								<div align="center">
								<input type="text" name="txt_borec2" size="15"  maxlength="10"  style="text-align:right"
									value="" onBlur="checkPercentage(this);roundtxt_3(this);" onKeyPress="allowDecimals(this)">
								</div>
							</td>
							<td width="9%">
								<input type="text" name="txt_dorec" size="15"  maxlength="10"  style="text-align:right"
									onBlur="checkPercentage(this);roundtxt_3(this);" onKeyPress="allowDecimals(this)" value="">
							</td>
							<td width="9%">
								<input type="text" name="txt_dorec2" size="15"  maxlength="10"  style="text-align:right"
									onBlur="checkPercentage(this);roundtxt_3(this);" onKeyPress="allowDecimals(this)" value="">
							</td>
							<td width="9%">
								<input type="text" name="txt_corec" size="15"  maxlength="10"  style="text-align:right"
									onBlur="checkPercentage(this);roundtxt_3(this);" onKeyPress="allowDecimals(this)" value="">
							</td>
							<td width="9%">
								<input type="text" name="txt_corec2" size="15"  maxlength="10"  style="text-align:right"
									onBlur="checkPercentage(this);roundtxt_3(this);" onKeyPress="allowDecimals(this)" value="">
							</td>
							<td width="19%">
								<div align="center">
								<select name="usr_class">
								<option value="0">Select </option>
								<lapschoice:usersclass />
								</select>
								</div>
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
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Audit Trial' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidSeqno" value="">
<input type="hidden" name="appno" value="<%=Helper.correctNull((String)request.getParameter("fac_id"))%>">
<input type="hidden" name="facdesc" value="">
<input type="hidden" name="fac_id1" value="<%=Helper.correctNull(request.getParameter("fac_id"))%>">
<input type="hidden" name="hidAgrScheme" value="<%=Helper.correctNull((String)request.getParameter("hidAgrScheme"))%>">
</form>
</body>
</html>