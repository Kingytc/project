<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />

<html>
<head>
<title>Setup(Corporate & Agriculture Products) - Other Details</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%
	String strProductType = Helper.correctNull((String) session.getAttribute("strProductType"));
	String strfacode=Helper.correctNull((String)session.getAttribute("hidcorp_faccode"));
	
	%>

	<%ArrayList vecMargin = new ArrayList();
			String strrangefrom1 = "";
			String strrangeto1 = "";
			String StrgrossIncime1 = "";
			String Strimmovablesec = "";
			String Strothersec = "";
			if (hshValues != null) {
				vecMargin = (ArrayList) hshValues.get("vecMarginRow");

				if (vecMargin != null && vecMargin.size() > 0) {
					ArrayList vec = new ArrayList();
					vec = (ArrayList) vecMargin.get(0);
					if (vec != null) {
						strrangefrom1 = Helper.correctNull((String) vec.get(3));
						strrangeto1 = Helper.correctNull((String) vec.get(4));
						StrgrossIncime1 = Helper.correctNull((String) vec.get(5));
								
						
					}

				}

			}
			
			String prdcodetype=Helper.correctNull((String)request.getParameter("prdcode"));
					String strgoldtype= Helper.correctNull((String) hshValues.get("prd_typeofloan"));
			
			String strproduct_type= Helper.correctNull((String) hshValues.get("product_type"));
		
			
%>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script>
var fac_id ="<%=Helper.correctNull(request.getParameter("fac_id"))%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var isnew="false";

var path ="<%=ApplicationParams.getAppUrl()%>";
var prdRangeTo = "<%=request.getParameter("prd_rng_to")%>";
var prdRangeFrom="<%=request.getParameter("prd_rng_from")%>";


var selindex;
var isnew="false";
<%
	int len = hshValues.size();
	out.println("var arrintr = new Array("+len+");");
	String keys[] = {"prd_inttype", "prd_intrate", "prd_addlint", "prd_totalint", "prd_collpass", "prd_liqpass", "prd_lvr", "prd_collweight", "prd_liqweight", "prd_creditbureau","prd_procfees1","prd_procfees2","prd_docfees1","prd_docfees2","prd_inspection","prd_procfees","prd_docfees"};
	int i=0;
	while( i < keys.length )
	{
		if( hshValues.get(keys[i]) != null )
		{
			out.println("arrintr["+i+"] = '"+hshValues.get(keys[i])+"';");
		}
		i++;
	}
%>
//-->

function disableButtons(cmdedit,cmdsave,cmdcancel,cmddelete,cmdclose)
{
	document.forms[0].cmdedit.disabled = cmdedit;
	document.forms[0].cmdsave.disabled = cmdsave;
	document.forms[0].cmdcancel.disabled = cmdcancel;
	document.forms[0].cmddelete.disabled = cmddelete;
	document.forms[0].cmdclose.disabled = cmdclose;
}

function DisableField(flag)
{
	document.forms[0].prd_procrangefrom.readOnly=flag;
	document.forms[0].prd_procrangeto.readOnly=flag;
	document.forms[0].prd_procfees.readOnly=flag;
}

function onloading()
{ 



	for(i=0;i<document.forms[0].selectmarginterm.length;i++)
		{	if(document.forms[0].hidColId.value == document.forms[0].selectmarginterm[i].value)
			{
				//document.forms[0].selectterm.selectedIndex=i; 
				if(document.forms[0].hidColId.value==0)
				{
					document.forms[0].selectmarginterm.selectedIndex=0;
				}
				else
				{
				document.forms[0].selectmarginterm.selectedIndex=i;
				}
			}
		}	
		selindex=document.forms[0].selectmarginterm[document.forms[0].selectmarginterm.selectedIndex].value;
		if(selindex=='')
		{
			disableButtons(true,true,true,true,false);
		}
		else
		{
			if(document.forms[0].checkApp.value=="No")
			{
				disableButtons(false,true,true,true,false);			
			}
			else
			{
				disableButtons(true,true,true,true,false);
			}
		}
		
		
		DisableField(true);
	
}

function doEdit()
{
	//document.prdinterestfrm.hidActionMode.value="UPDATE";
	//enableAll(false);
	DisableField(false);
	disableButtons(true,false,false,false,true);
}

function doSave()
{
	if((document.forms[0].prd_procrangefrom.value=="0.00")||(document.forms[0].prd_procrangefrom.value==""))
	{
		alert("Please enter the Range From");
		document.forms[0].prd_procrangefrom.value="";
		document.forms[0].prd_procrangefrom.focus();
		
		return;
	}
	if((document.forms[0].prd_procrangeto.value=="")||(document.forms[0].prd_procrangeto.value=="0.00"))
	{
		alert("Please enter the Range To");
		document.forms[0].prd_procrangeto.value="";
		document.forms[0].prd_procrangeto.focus();
		
		return;
	}
	if((document.forms[0].prd_procfees.value=="")||(document.forms[0].prd_procfees.value=="0.00")||(document.forms[0].prd_procfees.value=="."))
	{
		alert("Please enter the Percentage");
		document.forms[0].prd_procfees.value="";
		document.forms[0].prd_procfees.focus();
	
		return;
	}
	if(isnew=="true")
		{
		document.forms[0].hidActionMode.value="insert";
		}
		else
		{
		document.forms[0].hidActionMode.value="update";
		}
		
		//document.forms[0].hidColId.value = 
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].selectmarginterm[document.forms[0].selectmarginterm.selectedIndex].value;
		document.forms[0].hiddesc.value = document.forms[0].selectmarginterm[document.forms[0].selectmarginterm.selectedIndex].value;
		document.forms[0].action=path+"controllerservlet";
		
		document.forms[0].hidBeanId.value="setinterest";
		document.forms[0].hidBeanGetMethod.value="updateSetcorpcollateralSecurity";
		document.forms[0].action=appUrl+"action/set_corpcollateralsecurity.jsp";
		document.forms[0].submit();	
}

function onNew()
{
	isnew="true";
	if(document.forms[0].checkApp.value=="No" || document.forms[0].checkApp.value=="null" || document.forms[0].checkApp.value=="")
	{
	DisableField(false);
	disableButtons(true,false,false,true,true);
	}
	else
	{
		DisableField(true);
		document.forms[0].selectmarginterm.selectedIndex=0;
		ShowAlert(144);
	}
}

function doCancel()
{
	if(ConfirmMsg('102'))
	{
		
		if(document.forms[0].checkApp.value=="No")
			{	DisableField(false);
			}	
			document.forms[0].hidColId.value = 
			document.forms[0].selectmarginterm[document.forms[0].selectmarginterm.selectedIndex].value ;
			document.forms[0].hiddesc.value="";
			document.forms[0].action=path+"controllerservlet";
			document.forms[0].hidBeanId.value="setinterest";
			document.forms[0].hidBeanGetMethod.value="updateSetcorpcollateralSecurity";
			document.forms[0].hidSourceUrl.value="/action/set_corpcollateralsecurity.jsp";
			document.forms[0].submit();	
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidActionMode.value="delete";
		document.forms[0].hidColId.value =
			document.forms[0].selectmarginterm[document.forms[0].selectmarginterm.selectedIndex].value;
		document.forms[0].hiddesc.value = document.forms[0].selectmarginterm[document.forms[0].selectmarginterm.selectedIndex].value;
		document.forms[0].action=path+"controllerservlet";
		document.forms[0].hidBeanId.value="setinterest";
		document.forms[0].hidBeanMethod.value="updateSetcorpcollateralSecurity";
		document.forms[0].hidSourceUrl.value="/action/set_corpcollateralsecurity.jsp";
		document.forms[0].submit();
	}
}

function doClose()
{	
	if( ConfirmMsg(100) )
	{
		document.forms[0].action=appUrl+"action/comfacilityhome.jsp";
		document.forms[0].submit();
	}
}

function getMarginValue()
{
	
	selindex=document.forms[0].selectmarginterm[document.forms[0].selectmarginterm.selectedIndex].value;
	
	if(selindex=='')		
		{	
			marginpageClearValues();
			DisableField(true);
			disableButtons(true,true,true,true,false);

		}
	else if(selindex==0)
		{
			marginpageClearValues();
			DisableField(false);
			onNew();

		}
	else
	{

		if(document.forms[0].checkApp.value=="No")
			{	
			DisableField(false);
			}	
			document.forms[0].hidColId.value = 
			document.forms[0].selectmarginterm[document.forms[0].selectmarginterm.selectedIndex].value ;
			document.forms[0].hiddesc.value = document.forms[0].selectmarginterm[document.forms[0].selectmarginterm.selectedIndex].value;
			document.forms[0].action=appUrl+"controllerservlet";
			document.forms[0].hidBeanId.value="setinterest";
			document.forms[0].hidBeanMethod.value="getSet_corpcollateralSecurity";
			document.forms[0].hidSourceUrl.value="/action/set_corpcollateralsecurity.jsp";
			document.forms[0].submit();
	}
}

function marginpageClearValues()
{
	document.forms[0].prd_procrangefrom.value="";
	document.forms[0].prd_procrangeto.value="";
	document.forms[0].prd_procfees.value="";
}

function fn_Check_amountrangefrom()
{

	if(parseFloat(document.forms[0].prd_procrangefrom.value)!="")
	{
	if(parseFloat(document.forms[0].prd_procrangeto.value)==parseFloat(document.forms[0].prd_procrangefrom.value))
	{
	alert("The Amount from Range and Amount To Range Should not be equal");
	document.forms[0].prd_procrangefrom.value="";
	document.forms[0].prd_procrangefrom.focus();
	}
	else if(parseFloat(document.forms[0].prd_procrangeto.value) < parseFloat(document.forms[0].prd_procrangefrom.value))
	{
	alert("The Amount From Range Should Be Less Than Amount To Range");
	document.forms[0].prd_procrangefrom.value="";
	document.forms[0].prd_procrangefrom.focus();
	}
	else if(parseFloat(document.forms[0].prd_procrangefrom.value) > parseFloat(prdRangeTo) || parseFloat(document.forms[0].prd_procrangefrom.value) < parseFloat(prdRangeFrom) )
	{
	alert("Amount Range Should Be within the Product Amount Range");
	document.forms[0].prd_procrangefrom.value="";
	document.forms[0].prd_procrangefrom.focus();
	return;
	}
	return;
	}
}

function fn_Check_amountrangeto()
{
	if(parseFloat(document.forms[0].prd_procrangeto.value)!="")
	{
		if(parseFloat(document.forms[0].prd_procrangeto.value)==parseFloat(document.forms[0].prd_procrangefrom.value))
		{
		alert("The Amount from Range and Amount To Range Should not be equal");
		document.forms[0].prd_procrangeto.value="";
		document.forms[0].prd_procrangeto.focus();
		}
		else if(parseFloat(document.forms[0].prd_procrangeto.value) <  parseFloat(document.forms[0].prd_procrangefrom.value))
		{
		alert("The Amount To Range Should Be greater Than Amount from Range");
		document.forms[0].prd_procrangeto.value="";
		document.forms[0].prd_procrangeto.focus();
		}
		else if(parseFloat(document.forms[0].prd_procrangeto.value) > parseFloat(prdRangeTo ))
		{
			alert("Amount Range Should Be within the Product Amount Range");
			document.forms[0].prd_procrangeto.value="";
			document.forms[0].prd_procrangeto.focus();
		}
		return;
	}
}

function checkPercentage1(obj)
{	
	if(parseFloat(obj.value,10) > 150)
	{
		alert('Percentage cannot be greater than 150');
		obj.focus();
		obj.value = "";
		return false;
	}
}



</script>
</head>
<body  onLoad="onloading();">
<form name="documentsfrm1" method="post" class="normal">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td>
		<jsp:include page="../share/help.jsp" flush="true"></jsp:include>
		<jsp:include page="../share/menus.jsp" flush="true"></jsp:include>
	</td>
</tr>
</table>


<lapstab:setproductstabcorp tabid="18" />
 

<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
	<td class="page_flow">Home -&gt; Setup -&gt; Corporate &amp; Agri Products -&gt; Collateral Security</td>
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
					<td valign="top"><fieldset>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
								<tr>
									<td><lapschoice:facility /></td>
								</tr>
							</table>
							</td>
						</tr>
						</table></fieldset>
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

<table width="98%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable"
	 >
	<tr>
	  <td valign="top">
	  <fieldset> 
	  <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
               
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
              <tr>
                <td><table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
                    <tr>
                     <td colspan="5"><b>Collateral Security Percentage</b></td>
                     
                    </tr>
                    <tr >
                        <td width="23%">Loan Amount Range</td>
                      <td colspan="3"><select
											name="selectmarginterm" onChange="getMarginValue()"
											tabindex="10">
                          <lapschoice:Setcorpcollateralsecurity />
                        </select>
                      </td>
                    </tr>
                    <tr >
                      <td width="23%">Amount
                        Range From </td>
                      <td width="26%"><input type="text" name="prd_procrangefrom"
											size="25" tabindex="11" onKeyPress="allowNumber(this)"
											onBlur="roundtxt(this);fn_Check_amountrangefrom();" maxlength="12"
											value="<%=strrangefrom1%>" style="text-align:right" onPaste="window.event.returnValue=false"></td>
                      <td width="12%">Amount
                        Range To</td>
                      <td width="39%"><input type="text" name="prd_procrangeto"
											size="25" tabindex="12" onKeyPress="allowNumber(this)"
											onBlur="roundtxt(this);fn_Check_amountrangeto();" maxlength="12" value="<%=strrangeto1%>"
											style="text-align:right" onPaste="window.event.returnValue=false"></td>
                    </tr>
                   
                    <tr>
                    
                        <td id="idcoll4" width="23%" height="35">Collateral Security(%)</td>

                        <td colspan="3" height="35">
<input
											type="text" name="prd_procfees" size="8"
											onKeyPress="allowNumber(this)" maxlength="6" onBlur="roundtxt(this);checkPercentage1(this);"
											style="text-align:right" tabindex="13" onPaste="window.event.returnValue=false" 
											value="<%=StrgrossIncime1%>">
                      </td>
                    </tr>
          </table></td>
        </tr>
      </table>
      </td>
	</tr>
</table>

</fieldset>
<br>
<table border="0" cellspacing="0" cellpadding="0" align="center" bordercolordark="#B6C1D2" bordercolorlight="#FFFFFF"	 >
	<tr>
		<td>
		<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
		</td>
	</tr>
</table>
<br>
<input type=hidden name="hidBeanId" value="setinterest"> 
<input type=hidden name="hidBeanMethod" value="updateSetcorpcollateralSecurity">
<input type=hidden name="hidSourceUrl" value="/action/set_corpcollateralsecurity.jsp""> 
<input type=hidden name="hidBeanGetMethod" value="getSet_corpcollateralSecurity">
<input type="hidden" name="facility_id" value="<%=Helper.correctNull(request.getParameter("fac_id"))%>">
<input type="hidden" name="facility_code" value="<%=strfacode%>">
<input type="hidden" name="checkApp" value="No">
<input type="hidden" name="hidActionMode">
<input type="hidden"name="hiddesc" value="">
<input type="hidden" name="hidColId" value="<%=Helper.correctNull((String)hshValues.get("hidColId"))%>"> 
<input type="hidden" name="fac_id1" value="<%=Helper.correctNull(request.getParameter("fac_id"))%>">
<input type="hidden" name="hidProductType" value="<%=Helper.correctNull((String)request.getParameter("hidProductType"))%>">
<input type="hidden" name="hidAgrScheme" value="<%=Helper.correctNull((String)request.getParameter("hidAgrScheme"))%>">
</form>
</body>
</html>
	




