<%@include file="../share/directives.jsp"%>
<%
	ArrayList arrTermData=(ArrayList)hshValues.get("arrTerms");
	ArrayList arrTermId=(ArrayList)hshValues.get("arrTermsId");
	ArrayList arrTermsType=(ArrayList)hshValues.get("arrTermsType");
%>
<html>
<head>
<title>Terms and Conditions</title>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var grp = "<%=(String)session.getAttribute("strGroupRights")%>";

function setData()
{
	var len = document.forms[0].sno.length;
	
	if(len!=null)
	{
		for(i=0;i<len;i++)
		{
			if(document.forms[0].sno[i].checked == true)
			{
				document.forms[0].txttrmdesc.value = document.forms[0].hidText[i].value;
				document.forms[0].hidtermid.value = document.forms[0].sno[i].value;
				document.forms[0].hidterms.value = document.forms[0].hidtermtype[i].value;
			}
		}
	}
	else
	{
		document.forms[0].txttrmdesc.value = document.forms[0].hidText.value;
		document.forms[0].hidtermid.value = document.forms[0].sno.value;
		document.forms[0].hidterms.value = document.forms[0].hidtermtype.value;
	}
	document.forms[0].hidcomments.value="";
	if(document.forms[0].btnenable.value=="Y")
	{
		disableButton(true,false,true,false,false,true);
	}
}

function doAdd()
{
	document.forms[0].hidAction.value="insert";
	document.forms[0].hidtermid.value="";
	document.forms[0].txttrmdesc.value="";
	document.forms[0].txttrmdesc.readOnly=false;
	document.forms[0].txttrmdesc.focus();
	disableButton(true,true,false,false,true,true)	
}

function doEdit()
{
	document.forms[0].hidAction.value="update";
	document.forms[0].txttrmdesc.readOnly=false;
	var len = document.forms[0].sno.length;
	if(len != null)
	{
		for(i=0;i<len;i++)
		{
			document.forms[0].sno[i].disabled = true;
		}
	}
	else
	{
		document.forms[0].sno.disabled = true;
	}
	disableButton(true,true,false,false,true,true)
	document.forms[0].txttrmdesc.focus();
}

function doSave()
{
	if(trimtxt(document.forms[0].txttrmdesc.value)=="")
	{
		alert("Enter Terms Description");
		return false;
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="apptermscond";
	document.forms[0].hidBeanMethod.value="updateTerms";
	document.forms[0].hidBeanGetMethod.value="getTerms";		
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/apptermsandcondagr.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}
	
function doDelete()
{
	if(document.forms[0].hidtermid.value=="")
	{
		alert("Select Terms to delete");
		return false;
	}	
	if(trimtxt(document.forms[0].hidcomments.value)=="")
	{
		var url = "<%=ApplicationParams.getAppUrl()%>action/deletedtermremarks.jsp";
		var title1 = "";
		var prop = "scrollbars=no,width=600,height=450,menubar=no";
		var xpos = 20;
		var ypos = 20;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(url,title1,prop);		
	}
	else
	{
		document.forms[0].hidterms.value = "P";
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanId.value="apptermscond";
		document.forms[0].hidBeanMethod.value="updateTerms";
		document.forms[0].hidBeanGetMethod.value="getTerms";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/apptermsandcondagr.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}

function disableButton(b1,b2,b3,b4,b5,b6)
{
	document.forms[0].cmdadd.disabled = b1;
	document.forms[0].cmdedit.disabled = b2;
	document.forms[0].cmdsave.disabled = b3;
	document.forms[0].cmdcancel.disabled = b4;
	document.forms[0].cmddelete.disabled = b5;
	document.forms[0].cmdclose.disabled = b6;
}

function doCancel()
{
if(ConfirmMsg(102))
	{
	document.forms[0].hidBeanId.value="apptermscond";
	document.forms[0].hidBeanGetMethod.value="getTerms";
	document.forms[0].action=appURL+"action/apptermsandcondagr.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
	}
}

function doClose()
{
if(ConfirmMsg(100))
{
	document.forms[0].target="_parent";
	document.forms[0].action=appURL+"action/"+"retailpge.jsp";				
	document.forms[0].submit();
}
}

function callAppraisal()
{
	if(!document.forms[0].cmdsave.disabled)
	{
		ShowAlert('103');
		return;
	}
	else
	{
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/perappsanctionsanction.jsp";
		document.forms[0].submit();
	}	
}
function doDeletedTerms()
{
	var appno = document.forms[0].appno.value;
	var url = "<%=ApplicationParams.getAppUrl()%>action/apptermsandcondexcep_retail.jsp?appno="+appno+"&hidBeanId=apptermscond&hidBeanGetMethod=getDeletedTerms&hidAction=Retail";
	var title1 = "";
	var prop = "scrollbars=yes,width=775,height=300,menubar=yes";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title1,prop);
}
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
<form name="frm1" method="post" class="normal" > 
<table class="outertable border1" width="100%" border="0" align="center" cellspacing="0" cellpadding="5">
                            <tr> 
                              <td>
                          <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="5">
                            <tr> 
                              <td width="29%" align="center">Add 
                                Terms and Conditions</td>
                              <td width="71%"> 
                                <input type="hidden" name="hidtermid">
                                <input type="hidden" name="hidterms">
                                <textarea name="txttrmdesc" cols="100" readonly="readOnly"  onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" wrap="VIRTUAL" rows="5"></textarea>
                              </td>
                            </tr>
                          </table>
                        
                
                    <table class="outertable" width="100%" border="0" cellspacing="1" cellpadding="3" align="center">
                      <tr class="dataHeader"> 
                        <td width="3%">&nbsp;</td>
                        <td align="center" width="97%"> <b>Terms 
                          and Conditions Description</b></td>
                      </tr>
                      <%
					  for(int i=0;i<arrTermId.size();i++)
					  {
					  %>
                      <tr class="dataGrid"> 
                        <td width="3%"> 
                          <input type="radio" name="sno" style="border-style:none" value="<%=arrTermId.get(i)%>" onClick="setData()">
                        </td>
                        <td width="97%" align="left">
                          	<input type="hidden" name="hidsno" style="border-style:none" value="<%=arrTermId.get(i)%>">
                        	<input type="hidden" name="hidText" style="border-style:none" value="<%=Helper.correctDoubleQuotesHtml((String)arrTermData.get(i))%>">
                        	<input type="hidden" name="hidtermtype" style="border-style:none" value="<%=arrTermsType.get(i)%>">
                            <%=Helper.breakText((String)arrTermData.get(i),30)%>
                        </td>
                      </tr>
                      <%
					  }
					  %>
                    </table></td></tr></table>
  <br>
				<lapschoice:combuttonnew btnnames="Add_Edit_Save_Cancel_Delete_Deleted Terms" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />	
            
  <br>
 <lapschoice:agrihiddentag />
<input type="hidden" name="hidcomments">
<input type="hidden" name="hidLoanType">
<input type="hidden" name="rdtermid">
</form>
</body>
</html>
