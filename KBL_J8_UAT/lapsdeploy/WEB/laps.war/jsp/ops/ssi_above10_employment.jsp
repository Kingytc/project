<%@include file="../share/directives.jsp"%>
<%
ArrayList vecRow=(ArrayList)hshValues.get("vecRow");
ArrayList vecCol=new ArrayList();
String strBorrowerType =Helper.correctNull((String)request.getParameter("hidBorrowerType"));
String strcat="";
if(!strCategoryType.equalsIgnoreCase(null))
{
	if(strCategoryType.equalsIgnoreCase("OPS"))
	{
		strcat="Tertiary";
	}
	else 
	{
		strcat="Corporate";
	}
		
}
java.text.NumberFormat nf = java.text.NumberFormat
.getNumberInstance();
nf.setGroupingUsed(false);
nf.setMinimumFractionDigits(2);
nf.setMaximumFractionDigits(2);
double presenttotal=0.0,presenttot=0.0;
double proposedtotal=0.0;
double proposedtot=0.0;
%>
<html>
<head>
<title>Small Scale Industries</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript"src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";

function disableCommandButtons(bcmdNew,bcmdEdit,bcmdApply,bcmdCancel,bcmddel,bcmdClose)
{	
	 document.forms[0].cmdnew.disabled =bcmdNew;
	 document.forms[0].cmdedit.disabled=bcmdEdit;
	 document.forms[0].cmddelete.disabled=bcmddel;
	 document.forms[0].cmdsave.disabled=bcmdApply;
	 document.forms[0].cmdcancel.disabled=bcmdCancel;		 
	 document.forms[0].cmdclose.disabled=bcmdClose;
}
function callDisable(one)
{
	for( i=1;i<=6;i++)		
	{	
		document.forms[0].elements["txt_employment"+i+"1"].readOnly=one;	
		document.forms[0].elements["txt_employment"+i+"2"].readOnly=one;	
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
	}	
}
function onloading()
{	
	disableFields(true);	
	document.forms[0].hidTabName.value="Employment";
	document.forms[0].hidMethod.value="getProjectDetails";
}

function doEdit()
{

	disableFields(false);	
	document.forms[0].hidAction.value ="update";
	document.forms[0].hideditflag.value="Y";
	disableCommandButtons(true,true,false,false,false,true);
}

function doSave()
{	
		if(document.forms[0].txt_designation.value=="")
		{
			ShowAlert('121',"Designation");
			document.forms[0].txt_designation.focus();
			return;
		}
		if(document.forms[0].txt_proposed.value=="")
		{
			ShowAlert('121',"Proposed Value");
			document.forms[0].txt_proposed.focus();
			return;
		}
		else
		{
		document.forms[0].hidSourceUrl.value="/action/ssi_above10_employment.jsp";
		document.forms[0].hidBeanId.value="comssiaboveten";
		document.forms[0].hidBeanMethod.value="updateProjectData";
		document.forms[0].hidBeanGetMethod.value="getProjectDetails";
		document.forms[0].action=appUrl +"controllerservlet";
		document.forms[0].submit();
		}
}

 function doDelete()
{
	document.forms[0].hidAction.value ="delete";
	if(!ConfirmMsg("101"))
    {
		return false;
	}
	document.forms[0].hidBeanId.value="comssiaboveten";
	document.forms[0].hidBeanMethod.value="updateProjectData";
	document.forms[0].hidBeanGetMethod.value="getProjectDetails";
	document.forms[0].hidSourceUrl.value="/action/ssi_above10_employment.jsp";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}
function doNew()
{
	disableFields(false);
	disableCommandButtons(true,true,false,false,false,true);	
	document.forms[0].hideditflag.value="Y";
	document.forms[0].hidAction.value ="insert";   
}
function doCancel()
{	
	if(ConfirmMsg('102'))
	{
		document.forms[0].hidSourceUrl.value="/action/ssi_above10_employment.jsp";
		document.forms[0].hidBeanMethod.value="getProjectDetails";
		document.forms[0].hidBeanId.value="comssiaboveten";
		document.forms[0].action=appUrl +"controllerservlet";
		document.forms[0].submit();
	}
}

function selectValues(val1,val2,val3,val4)
{
	document.forms[0].hid_strsno.value=val1;
	document.forms[0].txt_designation.value=val2;
	document.forms[0].txt_present.value=val3;
	document.forms[0].txt_proposed.value=val4;
	if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
		disableCommandButtons("radioselect");
	}
}
function doClose()
{
	if(ConfirmMsg(100))
	{ 
		document.forms[0].action=appUrl+"action/agrpage.jsp";
		document.forms[0].submit();
	 }
}
</script>
</head>
<body onload="onloading()"><form name="fininc" method="post" class="normal"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
  <tr> 
    <td> 
      <jsp:include page="../share/applurllinkscom.jsp" flush="true"> 
      <jsp:param name="pageid" value="4" />
      <jsp:param name="cattype" value="<%=strCategoryType%>" />
      <jsp:param name="ssitype" value="<%=strSSIType%>" />
      </jsp:include>
    </td>
  </tr>
   <tr> 
          <td class="page_flow">Home -&gt; <%=strcat %> -&gt; Application -&gt; Ind. Activity -&gt; Human Resources</td>
        </tr>
</table>
<span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application/> 
<lapschoice:Activitytab tabid="6" ssitype='<%=strSSIType%>' />
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
  <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
                <tr> 
                  <td> 
                    <table width="100%" border="1" cellspacing="0" cellpadding="5" class="outertable linebor" align="center">
                      <tr class="dataheader"> 
                        <td width="16%" align="center">Designation <span class="mantatory">*&nbsp;</span></td>
                        <td width="17%"align="center">Present</td>
                        <td width="16%"align="center">Proposed <span class="mantatory">*&nbsp;</span></td>
                      </tr>
                      <tr class="datagrid"> 
                        <td width="16%" align="center"> 
                          <input type="text" name="txt_designation" tabindex="1" onKeyPress="notAllowSplChar()" maxlength="50" >
                        </td>
                        <td width="17%" align="center">                       
                            <lapschoice:CurrencyTag name="txt_present" tabindex="2" maxlength="20"/> 
                        </td>
                        <td width="16%" align="center">                          
                            <lapschoice:CurrencyTag name="txt_proposed" tabindex="3" maxlength="20"/> 
                        </td>
                      </tr>
                    </table>
                    </td>
                    </tr>
                    </table>
                    <br>
                    <lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
                    <br>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable linebor">
                      <tr class="dataheader"> 
                        <td width="4%" rowspan="2">&nbsp;</td>
                        <td rowspan="2"   align="center" width="32%"><strong>Designation</strong></td>
                        <td rowspan="2"  align="center" width="32%"><strong>Present</strong></td>
                        <td   rowspan="2" align="center" width="32%"><strong>Proposed</strong></td>
                      </tr>
                      <tr class="datagrid"> 
                        <td width="4%" >&nbsp;</td>
                      </tr>
                      <%                     
                  vecRow=(ArrayList)hshValues.get("vecRow");
					if(vecRow!=null && vecRow.size()>0)
					{
						int size=vecRow.size();
						for(int i=0;i<vecRow.size();i++)
						{
							vecCol = (ArrayList)vecRow.get(i);%>
                      <tr class="datagrid"> 
                        <td width="4%" align="center"> 
                          <input type="radio" 
						style="border:none" name="radiobutton" value="radiobutton"
						onClick="selectValues('<%=Helper.correctNull((String)vecCol.get(0))%>',
						'<%=Helper.correctNull((String)vecCol.get(1))%>',
						'<%=Helper.correctNull((String)vecCol.get(2))%>',
						'<%=Helper.correctNull((String)vecCol.get(3))%>')">
                        </td>
                        <td width="32%">&nbsp;<%=Helper.correctNull((String)vecCol.get(1))%></td>
                        <td width="32%" align="right">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(2))))%></td>
                        <td width="32%" align="right">&nbsp;<%=Helper.correctNull((String)vecCol.get(3))%></td>
                      </tr>
                      <%
					       presenttotal=Double.parseDouble(Helper.correctDouble((String) vecCol.get(2)));
					       presenttot=presenttot+presenttotal;
					       
					       proposedtotal=Double.parseDouble(Helper.correctDouble((String) vecCol.get(3)));
					       proposedtot=proposedtot+proposedtotal;
					       
						 }
					
					 	%>
                      <tr class="dataheader"> 
                        <td width="4%" align="center">&nbsp;</td>
                        <td width="32%" align="right"><b>Total :</b></td>
                        <td width="32%" align="right"><b>&nbsp;<%=nf.format(presenttot) %></b></td>
                        <td width="32%" align="right"><b>&nbsp;<%=nf.format(proposedtot) %></b></td>
                      </tr>
					  <%}%>
                    </table>
                    <br>
                      </td>
              </tr>
              </table>
              <br>          
			  <input type="hidden" name="otherGetMethod" value="">
              <input type="hidden" name="hid_strsno"/>
              </td>
              </tr>
        </table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>
