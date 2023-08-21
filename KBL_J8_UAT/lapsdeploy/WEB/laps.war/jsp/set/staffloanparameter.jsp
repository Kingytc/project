<%@include file = "../share/directives.jsp"%>
<%
ArrayList vecRow=(ArrayList)hshValues.get("vecRow");
ArrayList vecCol=new ArrayList();	
java.text.NumberFormat nf=java.text.NumberFormat.getInstance();
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
nf.setGroupingUsed(false);
String range_from=Helper.correctNull((String)hshValues.get("range_from"));
String range_to=Helper.correctNull((String)hshValues.get("range_to"));
%>
<html>
<head>
<title>StaffLoan Parameter</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>

<script>

var appURL="<%=ApplicationParams.getAppUrl()%>";

function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdnew.disabled =false;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;		 
	}
	
	if(val=="edit")
	{	 
		 document.forms[0].cmdnew.disabled =true;
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=true;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}
	if(val=="radioselect")
	{	 
		document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=false;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=false;
		document.forms[0].cmdclose.disabled=false;
	}	  
	if(val=="disableall")
	{
		document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}
}  

function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");	
}

function doHelp()
{
	var title = "ApplicantDemographics";
	var prop = "scrollbars=no,width=600,height=450";	
	prop = prop + ",left=200,top=150";
	window.open(varQryString,title,prop);
}

function doNew()
{	
	disableFields(false);
	disableCommandButtons("edit");
	document.forms[0].hidAction.value ="insert";
	document.forms[0].txt_maxamount.value="";
	document.forms[0].txt_minservice.value="";
	 document.forms[0].txt_maxservice.value="";
	 for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='radio')
	 	{
			document.forms[0].elements[i].checked=false;
		}	  
	}
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="setproducts";
		document.forms[0].action=appURL+"action/staffloanparameter.jsp";	
		document.forms[0].hidBeanGetMethod.value="getStaffloan";	
		document.forms[0].submit();
	}	
	disableCommandButtons("load");
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].type=='radio')
	 	{
	 		
			document.forms[0].elements[i].disabled=(!val);
		}	 	  
	}
}

function doDelete()
{
if (ConfirmMsg("101"))
		{
	document.forms[0].hidAction.value="Delete";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="setproducts";
	document.forms[0].hidSourceUrl.value="/action/staffloanparameter.jsp";
	document.forms[0].hidBeanMethod.value="updateStaffLoan";
	document.forms[0].hidBeanGetMethod.value="getStaffloan";	
	document.forms[0].submit();
	}
}
function doClose()
    {
	var con=ConfirmMsg('100');
	if(con)
	{
		window.close();
	}
	}
	
function selectValues(val1,val2,val3,val4)
{	
	
	 document.forms[0].hidstaff_id.value=val1;
	 document.forms[0].txt_minservice.value=val2;
	 document.forms[0].txt_maxservice.value=val3;
	 document.forms[0].txt_maxamount.value=val4;
	 disableCommandButtons("radioselect");
	
}
function placevalues()
{

	disableCommandButtons("load");
}
function doSave()
{
var range_from="<%=range_from%>";
var range_to="<%=range_to%>";
if(trim(document.forms[0].txt_minservice.value)=="" )
	{
	alert("Enter Minimum Service");
 		document.forms[0].txt_minservice.focus();
 		return;
	}
	
	if(trim(document.forms[0].txt_maxservice.value)=="")
	{
	alert("Enter Maximum service");
 		document.forms[0].txt_maxservice.focus();
 		return;
	}
	
	if(trim(document.forms[0].txt_maxamount.value)=="" ||  document.forms[0].txt_maxamount.value=="0.00")
	{
	alert("Enter Eligible loan amount");
 		document.forms[0].txt_maxamount.focus();
 		return;
	}
	if(eval(range_from) >eval(document.forms[0].txt_maxamount.value))
	{
		alert("Eligible Loan Amount Should be given with in Product Range");
		document.forms[0].txt_maxamount.value="";
		document.forms[0].txt_maxamount.focus();
		return;
	}
	if(eval(document.forms[0].txt_maxamount.value)>(eval(range_to)))
	{
		alert("Eligible Loan Amount Should be given with in Product Range");
		document.forms[0].txt_maxamount.value="";
		document.forms[0].txt_maxamount.focus();
		return;
	}
	if(eval(document.forms[0].txt_minservice.value)>eval(document.forms[0].txt_maxservice.value))
	{
		ShowAlert(115,"Maximum Service","Minimum Service");
		document.forms[0].txt_maxservice.value="";
		document.forms[0].txt_maxservice.focus();
		return;
	}
	
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="setproducts";
	document.forms[0].hidSourceUrl.value="/action/staffloanparameter.jsp";
	document.forms[0].hidBeanMethod.value="updateStaffLoan";
	document.forms[0].hidBeanGetMethod.value="getStaffloan";	
	document.forms[0].submit();
	
	
}

function checkValue(obj)
{
	if(parseFloat(obj.value) > 100) {
		alert("Service Should be less than 100");
		obj.value="";
		obj.focus();
		return;
	}	
	
}

</script>

<body onload="placevalues()" >
<!--  <div id="ie5menu" class="skin0" onMouseover="highlightie5()" onMouseout="lowlightie5()" onClick="jumptoie5()"> 
 <div class="menuitems" url="">
   <script language="JavaScript1.2">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div>
  </div>-->
<jsp:include page="../share/help.jsp" flush="true"/> 
<form name="appform" class="normal" method="post" action="">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td> <b><i>Setup -&gt; Product -&gt; 
        Staff Loan parameter</i></b></td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
    <tr> 
      <td colspan="2" valign="bottom"> </td>
    </tr>
  </table>
  <table width="100%" border="1" cellspacing="0" cellpadding="3" class="outertable" align="center">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
          <tr> 
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                <tr align="center"> 
                  <td colspan="2"> 
                    <p>&nbsp;</p>
                    <table width="90%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
                      <tr> 
                        <td width="15%"> 
                          <div align="left">Minimum 
                            Service <b>*</b> </div>
                        </td>
                        <td width="15%"> 
                          <div align="left"> 
                            <input type="text" name="txt_minservice" value="" size="10" maxlength="5"  style="text-align:left;border-style=groove" onKeyPress="allowDecimals(this)" onBlur="checkValue(this)">
                          </div>
                        </td>
                        <td width="15%"> 
                          <div align="left">Maximum 
                            Service  <b>*</b></div>
                        </td>
                        <td width="15%"> 
                          <div align="left"> 
                            <input type="text" name="txt_maxservice" value="" size="10" maxlength="5"  style="text-align:left;border-style=groove" onKeyPress="allowDecimals(this)" onBlur="checkValue(this)" >
                          </div>
                        </td>
                        <td width="15%"> 
                          <div align="left">Eligible 
                            Loan Amount <b>*</b></div>
                        </td>
                        <td width="15%" align="left"> <lapschoice:CurrencyTag name="txt_maxamount" value=""   maxlength="20"    /> 
                        </td>
                      </tr>
                    </table>
                    <br>
                    <br>
                    <br>
                    <lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Delete_Help_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
                        </td>
                      </tr>
                    </table>
                    <br>
                    <br>
                  </td>
                </tr>
                <tr align="center"> 
                  <td colspan="2"> 
                   
                      <table width="100%" border="1" cellspacing="0" cellpadding="3"  align="center">
                        <tr> 
                          <td valign="top"> 
                           
                              <table width="100%" border="0" cellspacing="1" cellpadding="2">
                                <tr class="dataheader"> 
                                  <td width="4%" class="tabactive">&nbsp;</td>
                                  <td width="32%" class="tabactive" align="center"><b>Minimum 
                                      Service</b>
                                  </td>
                                  <td width="32%" class="tabactive" align="center"><b>Maximum 
                                      Service</b>
                                  </td>
                                  <td width="32%" class="tabactive" align="center"> 
                                   <b> Eligible Loan Amount </b></td>
                                </tr>
                                </table>
                                 
                                   <div class="cellContainer"> 
                                <%
                              
					if(vecRow.size()>0 && vecRow!=null)
					{
						for(int i=0;i<vecRow.size();i++)
						{
						vecCol = (ArrayList)vecRow.get(i);
					%>
					
					  <table width="100%" border="0" cellspacing="1" cellpadding="2">
                                <tr class="datagrid"> 
                                  <td width="4%" align=center>
                                    <input type="radio" 
													style="border:none" name="radiobutton" value="radiobutton"
													onClick="selectValues('<%=Helper.correctNull((String)vecCol.get(0))%>',
													'<%=Helper.correctNull((String)vecCol.get(1))%>','<%=Helper.correctNull((String)vecCol.get(2))%>'
                            	,'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(3))))%>')">
                                   </td>
                                  <td width="32%"><%=Helper.correctNull((String)vecCol.get(1))%></td>
                                  <td width="32%"><%=Helper.correctNull((String)vecCol.get(2))%></td>
                                  <td width="32%" align="right"><%=nf.format(Double.parseDouble(Helper
						.correctDouble((String) vecCol.get(3))))%></td>
                                </tr>
                                <%
					 }
					 }
				  	else
                	{
               %>
                                <tr> 
                                  <td align center colspan="6">No 
                                    Data Found</td>
                                </tr>
                                <%
                	}
                %>
                </table>
               
                              
                          
                          </td>
                        </tr>
                      </table>
                    
                  </td>
                </tr>
              </table>
           
    
  <br>
  <lapschoice:hiddentag pageid='<%=PageId%>'/> 
 
  <input type="hidden" name="hidstaff_id">
  <input type="hidden" name="prd_code" value="<%=Helper.correctNull((String)request.getParameter("prd_code"))%>">
  
</form>
</body>
</html>
 