<%@include file="../share/directives.jsp"%>
<%ArrayList vecMargin = new ArrayList();
String strrangefrom = "";
String strrangeto = "";
String strpercentcharge = "";
if (hshValues != null) 
	{
	vecMargin = (ArrayList) hshValues.get("vecMarginRow");
	if (vecMargin != null && vecMargin.size() > 0) 
		{
		ArrayList vec = new ArrayList();
		vec = (ArrayList) vecMargin.get(0);
		if (vec != null) 
			{
			strrangefrom = Helper.correctNull((String) vec.get(2));
			strrangeto = Helper.correctNull((String) vec.get(3));
			strpercentcharge = Helper.correctNull((String) vec.get(4));
			}
		}
	}
String strprdtype=Helper.correctNull((String)request.getParameter("prdtype"));%>
<html>
<head>
<title>Setup(Products - Margin Amount)</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript">
var selperiod="<%=Helper.correctNull((String)hshValues.get("prd_inspection"))%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var selindex;
var isnew="false";
var path      ="<%=ApplicationParams.getAppUrl()%>";
var appURL ="<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
//
function onloading()
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
	
	if(document.forms[0].prdCode.value ==""){
		document.forms[0].cmdaudittrail.disabled = true;  
		}
			
			
		
	selindex=document.forms[0].prdCode[document.forms[0].prdCode.selectedIndex].value;
	if(selindex=='')
		{
					DisableButtons(true,true,true,false);
		}
	else
		{
					DisableButtons(false,false,false,true);
		}
	DisableButtons(false,true,true,false);
	DisableField(true);
	}

function DisableField(flag)
	{
	document.forms[0].prd_procrangefrom.readOnly=true;
	document.forms[0].prd_procrangeto.readOnly=true;
	document.forms[0].prd_procfees.readOnly=flag;
	}

function DisableButtons(cmdedit,cmdsave,cmdcancel,cmdclose)
{
	document.forms[0].cmdedit.disabled = cmdedit;
	document.forms[0].cmdsave.disabled = cmdsave;
	document.forms[0].cmdcancel.disabled = cmdcancel;
	document.forms[0].cmdclose.disabled = cmdclose;
}
function doCancel()
	{
	if(ConfirmMsg('102'))
		{
		if(document.forms[0].checkApp.value=="No")
			{	
			DisableField(false);
			}	
		document.forms[0].hidId.value = 
		document.forms[0].prdCode[document.forms[0].prdCode.selectedIndex].value ;
		document.forms[0].hiddesc.value="";
		document.forms[0].action=path+"controllerservlet";
		document.forms[0].hidBeanId.value="setinterest";
		document.forms[0].hidBeanMethod.value="getMarginData";
		document.forms[0].hidSourceUrl.value="/action/ops_margin.jsp";
		document.forms[0].submit();	
		}
	}

function doSave()
	{
	if(document.forms[0].prd_procfees.value=="")
		{
		alert("Please enter the Margin Percentage");
		return;
		}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidAction.value="update";
	document.forms[0].hidRecordflag.value=varRecordFlag;	
	document.forms[0].hidId.value =
	document.forms[0].prdCode[document.forms[0].prdCode.selectedIndex].value;
	document.forms[0].hiddesc.value ="1";
	document.forms[0].action=path+"controllerservlet";
	document.forms[0].hidBeanId.value="setinterest";
	document.forms[0].hidBeanMethod.value="updateMarginData";
	document.forms[0].hidBeanGetMethod.value="getMarginData";
	document.forms[0].hidSourceUrl.value="/action/ops_margin.jsp";
	document.forms[0].submit();	
	}

function showdata()
{
	document.forms[0].cmdaudittrail.disabled = false;
	selindex=document.forms[0].prdCode[document.forms[0].prdCode.selectedIndex].value;
	if(selindex!='')		
		{	
		DisableField(false);
		DisableButtons(false,false,false,true);
		}
	else if(selindex=='')
		{
		DisableField(false);
		DisableButtons(true,true,true,false);
		}
	
		document.forms[0].hidId.value = document.forms[0].prdCode[document.forms[0].prdCode.selectedIndex].value ;
		document.forms[0].hiddesc.value = "1";
		document.forms[0].method="post";
		document.forms[0].hidBeanId.value="setinterest";
		document.forms[0].hidBeanGetMethod.value="getMarginData";
		//document.forms[0].hidSourceUrl.value="/action/ops_margin.jsp";
		document.forms[0].action=appUrl+"action/ops_margin.jsp";
		document.forms[0].submit();
	}
function setButtons()
{
	document.prdinterestfrm.cmdedit.disabled = false;
	document.prdinterestfrm.cmdsave.disabled = true;
	document.prdinterestfrm.cmdcancel.disabled = true;
	document.prdinterestfrm.cmdclose.disabled = false;
	disableAll();
}
function disableFields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=one;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}		
	}
}
function enableButtons(bool1, bool2, bool3, bool4)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmdclose.disabled=bool4;
}
function doEdit()
{
	if(document.forms[0].prdCode.value != ''){
	document.prdinterestfrm.hidAction.value="UPDATE";
	DisableField(false);
	enableButtons(true, false, false, true);
	document.forms[0].prd_procfees.focus();
	}else{
		alert("Select Processing Amount Range ");
	}
}
function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].action=appUrl+"action/ops_margin.jsp";
		document.forms[0].hidBeanId.value="setinterest";
		document.forms[0].hidBeanGetMethod.value="getMarginData";
	//	document.forms[0].hidSourceUrl.value="/action/ops_margin.jsp";		
		document.forms[0].submit();
	}
}
function doClose()
{	
	if( ConfirmMsg(100) )
	{
		document.forms[0].action=appUrl+"action/setupnav.jsp";
		document.forms[0].submit();
	}
}
</script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="onloading()">
<form name="prdinterestfrm" method="post" action="<%=ApplicationParams.getAppUrl()%>controllerservlet" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Setup -&gt; Tertiary Products -&gt; Margin</td>
	</tr>
</table>
<br>
<table width="68%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
	<tr>
		<td valign="top">
		<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="3" ALIGN="center" class="outertable">
			<TR>
				<TD VALIGN="top">
				<TABLE WIDTH="93%" BORDER="0" CELLSPACING="0" CELLPADDING="0" cellspacing="0" class="outertable border1">
					<TR>
						<TD>
						<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="2" class="outertable">
							<TR>
							</TR>
							<TR>
								<TD COLSPAN="4">								
                          <TABLE WIDTH="97%" BORDER="0" CELLSPACING="0" CELLPADDING="5" ALIGN="center" class="outertable">
                            <TR class="dataheader"> 
                              <TD colspan="6"><B>Margin Amount Percentage</B></TD>
                            </TR>
                            <TR> 
                              <TD WIDTH="19%">Select Processing Amount Range</TD>
                              <TD WIDTH="3%"></TD>
                              <TD WIDTH="23%"> 
                                <SELECT NAME="prdCode" ONCHANGE="javascript:showdata()">
                                  <OPTION VALUE="" selected>-------Select-------</OPTION>
                                  <lapschoice:productcode /> 
                                </SELECT>
                              </TD>
                              <TD WIDTH="18%">&nbsp;</TD>
                              <TD WIDTH="3%"></TD>
                              <TD WIDTH="34%"></TD>
                            </TR>
                            <TR> 
                              <TD WIDTH="19%">Amount Range From </TD>
                              <TD WIDTH="3%"><b><%=ApplicationParams.getCurrency()%></b></TD>
                              <TD WIDTH="23%"> 
                                <INPUT TYPE="text" NAME="prd_procrangefrom"
											SIZE="15" TABINDEX="11" ONKEYPRESS="allowNumber(this)"
											ONBLUR="roundtxt(this)" MAXLENGTH=""
											VALUE="<%=strrangefrom%>" STYLE=text-align:"right">
                              </TD>
                              <TD WIDTH="18%">Amount Range To</TD>
                              <TD WIDTH="3%"><b><%=ApplicationParams.getCurrency()%></b></TD>
                              <TD WIDTH="34%"> 
                                <INPUT TYPE="text" NAME="prd_procrangeto"
											SIZE="15" TABINDEX="12" ONKEYPRESS="allowNumber(this)"
											ONBLUR="roundtxt(this)" MAXLENGTH="" VALUE="<%=strrangeto%>"
											STYLE=text-align:"right">
                              </TD>
                            </TR>
                            <TR> 
                              <TD WIDTH="19%">Margin Amount Percentage (%)<span class='mantatory'>*</span></TD>
                              <TD WIDTH="3%">&nbsp;</TD>
                              <TD WIDTH="23%"> 
                                <INPUT
											TYPE="text" NAME="prd_procfees" SIZE="8"
											ONKEYPRESS="allowNumber(this)" MAXLENGTH="5"
											STYLE="text-align:right" TABINDEX="13"
											VALUE="<%=strpercentcharge%>" ONBLUR="checkPercentage(this)">
                                </TD>
                              <TD WIDTH="18%">&nbsp;</TD>
                              <TD WIDTH="3%"></TD>
                              <TD WIDTH="34%"> 
                                </TD>
                            </TR>
                          </TABLE>
								</TD>
							</TR>
						</TABLE>
						</TD>
					</TR>
				</TABLE>
				</TD>
			</TR>
		</TABLE>
		</td>
	</tr>
</table><br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="hidSeldInsti" value="">
<input type="hidden" name="prd_code" value="<%=Helper.correctNull((String)hshValues.get("strPrdCode"))%>"> 
<input type="hidden" name="selperiod" value=""> 
<input type="hidden" name="hidId" value="<%=Helper.correctNull((String)hshValues.get("strPrdCode"))%>"> 
<input type="hidden" name="prdtype" value="<%=strprdtype%>">
<input type="hidden" name="hiddesc" value="1">
<input type="hidden" name="selectmarginterm" value="1">
<!--<input type ="hidden" name ="hidkeyid" value="set">-->
</form>

</body>
</html>






