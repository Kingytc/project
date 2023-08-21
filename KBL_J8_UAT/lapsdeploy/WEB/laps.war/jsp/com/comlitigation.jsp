<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
   if(objValues instanceof java.util.HashMap)
  {
	  hshValues=(java.util.HashMap)objValues;
  }

ArrayList vec = null;
 int vecsize=0;
 
 if (hshValues != null)
 {
   vec = (ArrayList)hshValues.get("vecVal");
 }

if(vec!=null)
{
	vecsize =vec.size();
	
}

java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
jtn.setMaximumFractionDigits(2);
jtn.setMinimumFractionDigits(2);
jtn.setGroupingUsed(false);
 %>
<html>
<head>
<title>Proposal</title>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>

var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag="<%=Helper.correctNull((String)hshValues.get("recordflag"))%>";
function placeValues()
{
	disableFields(true);
}

function disableFields(val)
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
		}
	}
function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="compro"
		document.forms[0].hidBeanGetMethod.value="getLitigation";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comlitigation.jsp";
		document.forms[0].submit();
	 }
}
function doDelete()
{
	if(varRecordFlag=="Y")
		{
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete"
		document.forms[0].hidBeanId.value="compro"
		document.forms[0].hidBeanMethod.value="updateLitigation";
		document.forms[0].hidBeanGetMethod.value="getLitigation";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comlitigation.jsp";
		document.forms[0].submit();
	  }
	   }
	  else{
	 ShowAlert(158);
	 }
		
}
function enableButtons(bool1,bool2,bool3,bool4,bool5)
{

	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;

}
function doEdit()
{
	disableFields(false);
	document.forms[0].hideditflag.value="Y";
	enableButtons(true,false,false,false,true)

}
function doSave()
{
		var flag = validate();
		
		
	
if(flag ){
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidRecordflag.value=varRecordFlag;
		document.forms[0].hidAction.value="update"
		document.forms[0].hidBeanId.value="compro"
		document.forms[0].hidBeanMethod.value="updateLitigation";
		document.forms[0].hidBeanGetMethod.value="getLitigation";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comlitigation.jsp";
		document.forms[0].submit();
		}
else	{
			alert("Enter values in Bank Field");
		}
		

}


function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].action=appURL+"action/"+"corppge.jsp";
		document.forms[0].submit();
	}
	
}
function  validate()
{ 
	var flag;
	for (m=0;m<8;m++)
	{
		if(document.forms[0].bank[m].value != "")
		{
			
				return true ;
			
		}
		else
				flag = false; 
	}
	
return flag;

}


var strvalue="corp_otherinf_litig.htm";
function doHelp()     
{
  var hlpvar = appURL+"phlp/corp_otherinf_litig.htm";
  var title = "Litigations";
  var prop = "scrollbars=yes,width=600,height=450";	
  prop = prop + ",left=50,top=150";
  window.open(hlpvar,title,prop);
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body onload="placeValues()">
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
<form name="frmpri" method ="post" class="normal"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="top" colSpan="5"><jsp:include
			page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="8" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable border1">
	<tr>
		<td class="page_flow">
Home -&gt; Corporate &amp; SME -&gt; Application-&gt; Other Info.-&gt; Litigations 
</td>
</tr>
</table>
<span style="display:none"><lapschoice:borrowertype /></span><lapschoice:application/> 
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table border="0" cellspacing="1" cellpadding="3" class="outertable">
			<tr align="center">
				<td width="40%" class="sub_tab_inactive"><b><a href="#" onclick="javascript:gotoTab(appURL,'compro','getEquity','comequity.jsp')">Equity Invested</b></td>
				<td width="40%" class="sub_tab_active"><b>Litigations</b></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
    <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable border1">
      <tr> 
        <td valign="top"> 
          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
            <tr> 
              <td valign="top"> 
                <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
                  <tr> 
                    <td valign="top"> 
                      <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                        <tr> 
                          <td> 
                            <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
                              <tr class="dataheader"> 
                                <td width="6%" align="center"><b>S.No</b></td>
                                <td width="31%" align="center"><b>Name of the Bank / Financial Institution / Others</b></td>
                                <td width="14%" align="center"><b>Amount Claimed </b></td>
                                <td width="30%" align="center"><b>Reasons for litigation</b></td>
                                <td colspan="2" align="center" width="25%"><b>Remarks</b></td>
                              </tr>
                              <%
					ArrayList g1=null;
					
					 for (int l=0;l<8;l++)
					 {
						
							
							int colSize=0;
						 
						 if(l<vecsize)
						 {
							 g1 = (ArrayList)vec.get(l);

							if(g1!=null)
							{
							   colSize = g1.size();
       						}
						 }
						
											
						 if(colSize>0)	
						  {
						
					  %>
                              <tr> 
                                <td width="6%" align="center"><%=l+1%></td>
                                <td width="31%" align="center"> 
                                  <input type="text" name="bank" size="30" value="<%=Helper.correctNull((String)g1.get(2))%>" maxlength="99" onKeyPress="notAllowSplChar1(this)">
                                  </td>
                                <td width="14%" align="center"> 
                                  <input type="text" name="amount" size="15" value="<%=jtn.format(Double.parseDouble(Helper.correctDouble((String)g1.get(4))))%>" maxlength="12" style="text-align:right" onKeyPress="allowNumber(this)" onBlur="javascript:roundtxt(this)">
                                  </td>
                                <td width="30%" align="center"> 
                                  <input type="text" name="reasons" size="30" value="<%=Helper.correctNull((String)g1.get(3))%>" maxlength="99" onKeyPress="notAllowSplChar1(this)">
                                  </td>
                                <td colspan="2" align="center" width="25%"> 
                                  <input type="text" name="remarks" size="25" maxlength="199" value="<%=Helper.correctNull((String)g1.get(5))%>" onKeyPress="notAllowSplChar1(this)">
                                  <input type="hidden" name="type" size="25" value="bank">
                                  </td>
                              </tr>
                              <%
						
								}
						else
						 {
					%>
                              <tr> 
                                <td width="6%" align="center"><%=l+1%></td>
                                <td width="31%" align="center"> 
                                  <input type="text" name="bank" size="30" maxlength="49">
                                  </td>
                                <td width="14%" align="center"> 
                                  <input type="text" name="amount" size="15" maxlength="9" style="text-align:right" onKeyPress="allowNumber(this)" onBlur="javascript:roundtxt(this)">
                                  </td>
                                <td width="30%" align="center"> 
                                  <input type="text" name="reasons" size="30" maxlength="99">
                                  </td>
                                <td colspan="2" align="center" width="25%"> 
                                  <input type="text" name="remarks" size="25" maxlength="199">
                                  <input type="hidden" name="type" size="25" value="bank">
                                  </td>
                              </tr>
                              <%
						}
				}
		
			
		%>
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
             <lapschoice:combuttonnew btnnames="Edit_Save_Delete_Cancel_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
</form>
</body>
</html>
