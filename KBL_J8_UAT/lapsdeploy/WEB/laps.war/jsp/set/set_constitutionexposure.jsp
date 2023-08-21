<%@ include file="../share/directives.jsp"%>
<%ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();%>
<html>
<head>
<title>Commercial-Applicant</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script langauge="Javascript">
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varexptype="<%=Helper.correctNull((String)hshValues.get("exposuretype"))%>";
var varexpcons="<%=Helper.correctNull((String)hshValues.get("exposurecons"))%>";
var varexppubtype="<%=Helper.correctNull((String)hshValues.get("exppublictype"))%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function loadVal()
{
	document.forms[0].hidBeanId.value="exposure";
	document.forms[0].hidBeanMethod.value="updateConsExp";
	document.forms[0].hidBeanGetMethod.value="getConsExp";
	if(varexptype!="")
	{
		document.forms[0].seltype.value=varexptype;
	}
	else
	{
		document.forms[0].seltype.value="S";
	}	
	if(varexpcons!="")
	{
		document.forms[0].selconstitution.value=varexpcons;
	}
	else
	{
		document.forms[0].selconstitution.value="0";
	}	
	if(varexppubtype!="")
	{
		document.forms[0].selpublictype.value=varexppubtype;
	}
	else
	{
		document.forms[0].selpublictype.value="0";
	}
	disableControls(true);
	disablebuttons(false,true,true,true,false);
	showpublictype();
}

function disablebuttons(flg1,flg2,flg3,flg4,flg5)
{
	document.forms[0].cmdedit.disabled=flg1;
	document.forms[0].cmdsave.disabled=flg2;
	document.forms[0].cmdcancel.disabled=flg3;
	document.forms[0].cmddelete.disabled=flg4;
	document.forms[0].cmdclose.disabled=flg5;
}

function disableControls(flag)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			  document.forms[0].elements[i].readOnly=flag;		  
		}
		if(document.forms[0].elements[i].type=="select-one")
		{
			  document.forms[0].elements[i].disabled=flag;		  
		}		
	}
}

function doSave()
{
	if(document.forms[0].seltype.value=="S")
	{
		ShowAlert(111,'Exposure Type');
		return;
	}
	if(document.forms[0].selconstitution.value=="0")
	{
		ShowAlert(111,'Constitution');
		return;
	}
	if(document.forms[0].selconstitution.value=="005" && document.forms[0].selpublictype.value=="S")
	{
		ShowAlert(111,'Public Type');
		return;
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidconstituition.value = document.forms[0].selconstitution.options[document.forms[0].selconstitution.selectedIndex].text;
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="exposure";
	document.forms[0].hidBeanMethod.value="updateConsExp";
	document.forms[0].hidBeanGetMethod.value="getConsExp";
	document.forms[0].hidSourceUrl.value="/action/set_constitutionexposure.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}

function doEdit()
{
	
		document.forms[0].hidAction.value="Insert";
		disablebuttons(true,false,false,false,true);
		disableControls(false);
	
}

function doDelete()
{
	if(ConfirmMsg(101)){
	document.forms[0].hidconstituition.value = document.forms[0].selconstitution.options[document.forms[0].selconstitution.selectedIndex].text;
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidAction.value="Delete";
	document.forms[0].hidBeanId.value="exposure";
	document.forms[0].hidBeanMethod.value="updateConsExp";
	document.forms[0].hidBeanGetMethod.value="getConsExp";
	document.forms[0].hidSourceUrl.value="/action/set_constitutionexposure.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
	}
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/setexposure.jsp";
		document.forms[0].submit();
	}
}

function doCancel()
{
	if(ConfirmMsg(102)){
	document.forms[0].hidBeanId.value="exposure";
	document.forms[0].hidBeanGetMethod.value="getConsExp";
	document.forms[0].action=appURL+"action/set_constitutionexposure.jsp";
	document.forms[0].submit();
	}
}

function showpublictype()
{
	if(document.forms[0].selconstitution.value=="006")
	{
		document.all.idpublictype.style.visibility="visible";
		document.all.idpublictype.style.position="relative";
	}
	else
	{
		document.all.idpublictype.style.visibility="hidden";
		document.all.idpublictype.style.position="absolute";
	}
}

function selectValues(exposurefor, constitution, publictype, amount)
{
	document.forms[0].seltype.value=exposurefor;
	document.forms[0].selconstitution.value=constitution;
	if(document.forms[0].selconstitution.value=="006")
	{
		document.all.idpublictype.style.visibility="visible";
		document.all.idpublictype.style.position="relative";
		document.forms[0].selpublictype.value=publictype;
	}
	else
	{
		document.all.idpublictype.style.visibility="hidden";
		document.all.idpublictype.style.position="absolute";
	}
	document.forms[0].txt_maxexp.value=amount;
	
	disablebuttons(false,true,false,true,false);
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="loadVal()">
<form name="appform" class="normal">
  <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td class="page_flow">Home -&gt; Corporate Products -&gt; Exposure -&gt; Constitution Exposure</td>
    </tr>
  </table>
  <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="5" align="center">
    <tr> 
      <td valign="top"> 
        <table class="outertable border1"  border="0" cellspacing="0" cellpadding="15" align="center"  >
          <tr> 
            <td> 
              <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="10"  align="center">
                <tr> 
                  <td valign="top"> 
                   
                    <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="10" align="center">
                      <tr> 
                        <td width="59%">Exposure For</td>
                        <td width="34%"> 
                          <select name="seltype">
                            <option value="S" selected>----Select----</option>
                            <option value="N">New</option>
                            <option value="E">Existing</option>
                          </select>
                        </td>
                      </tr>
                      <tr> 
                        <td width="59%">Constitution</td>
                        <td width="34%"> 
                          <select name="selconstitution" onChange="showpublictype();">
						  	<option value="0" Selected>---Select---</option>
                            <%String statid = "14";	%>
							<lapschoice:StaticDataNewTag apptype='<%=statid%>' />
						</select>
                        </td>
                      </tr>
                      <tr id="idpublictype"> 
                        <td width="59%">Public Type</td>
                        <td width="34%"> 
                          <select name="selpublictype">
                            <option value="S" selected>----Select----</option>
                            <option value="C">Closely Held</option>
                            <option value="W">Widely Held</option>
                          </select>
                        </td>
                      </tr>
                      <tr style="visibility:hidden;position:absolute"> 
                        <td width="59%">Based On</td>
                        <td width="34%"> 
                          <select name="select3">
                            <option value="S" selected>----Select----</option>
                            <option value="A">Amount</option>
                            <option value="E">Exposure Norms</option>
                          </select>
                        </td>
                      </tr>
                      <tr id="industry2"> 
                        <td width="59%">Maximum Exposure Limit&nbsp;in <b>(Rs in Crores)</b></td>
                        <td width="34%"> 
                          <input type="text" name="txt_maxexp" size="20" maxlength="12"   
                          style= "text-align:left;border-style:groove;text-align:right"
                          onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" 
                          value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("expmaxamount"))))%>">
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
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
 <br>
  <table class="outertable border1"  width="50%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr> 
      <td valign="top">
          <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="2" align="center" >
            <tr class="dataheader"> 
              <td width="3%"></td>
			  <td width="19%" align="center"> Exposure For</td>
              <td width="59%" align="center"> Constitution</td>
              <td width="19" align="center"> Maximum Exposure Limit</td>
             </tr>
            <%if(hshValues!=null)
	            arrRow=(ArrayList)hshValues.get("arrRow");            
            if (arrRow != null && arrRow.size() > 0 ) {
				for (int i = 0; i < arrRow.size(); i++) {
					arrCol = (ArrayList) arrRow.get(i);%>
            <tr class="datagrid"> 
              <td width="3%"> 
                <input type="radio" style="border:none"
					name="radiobutton" value="radiobutton"
					onClick="selectValues('<%=Helper.correctNull((String)arrCol.get(0))%>',
													'<%=Helper.correctNull((String)arrCol.get(1))%>','<%=Helper.correctNull((String)arrCol.get(2))%>'
                            	,'<%=Helper.correctDouble((String)arrCol.get(3))%>')">
              </td>
              <td width="19%" align="left"> <%=Helper.correctNull((String) arrCol.get(0)).equalsIgnoreCase("N")?"New":"Existing"%></td>
              <td width="59%" align="left"> <%=Helper.correctNull((String) arrCol.get(4))%> 
                <%=Helper.correctNull((String) arrCol.get(1)).equalsIgnoreCase("006")?Helper.correctNull((String) arrCol.get(2)).equalsIgnoreCase("C")?"- Closely Held":" - Widely Held":"" %> 
              </td>
              <td width="19%" align="right"> <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(3))))%> 
              </td>
              
            </tr>
            <%}} else {%>
            <tr class="datagrid"> 
              <td align="center" colspan="4">No Data Found</td>
            </tr>
            <%}%>
          </table>
      </td>
    </tr>
  </table>
   <lapschoice:hiddentag pageid='<%=PageId%>'/> 
   <input type ="hidden" name ="hidkeyid" value="set">
   <input type = "hidden" name = "hidconstituition" value="">
</form>
</body>
</html>