<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Proposal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>ckeditor/ckeditor.js">
</script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";

var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";

function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmdclose.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
}

function call_page(url,method,type)
{
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url+"?type="+type;
	document.forms[0].submit();
}

function placevalues()
{
	disableFields(true);
}

function doCancel(url,method,type)
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="comproposal"
		document.forms[0].hidpagedesc.value="norms','bplr";
		document.forms[0].hidBeanGetMethod.value="getDataComment"
		document.forms[0].hidSourceUrl.value="/action/comstl_comments.jsp"
		document.forms[0].action=appURL+"controllerservlet?type=9";
		document.forms[0].submit();
	 }
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/corppge.jsp";
		document.forms[0].submit();
	}
	
}

function doEdit()
{
	disableFields(false);
	enableButtons(true,false,false,true,false);
	document.forms[0].hidAction.value ="update";
}

function doSave()
{
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidpagedesc.value="norms','bplr";
	document.forms[0].hidBeanMethod.value="updateGeneralComment";
	document.forms[0].hidBeanGetMethod.value="getDataComment";
	document.forms[0].hidSourceUrl.value="/action/comstl_comments.jsp"
	document.forms[0].action=appURL+"controllerservlet?type=9";
	document.forms[0].submit();
}
function gototab(beanid,methodname,pagename,type)
{
		
		document.forms[0].hidBeanId.value=beanid;
		document.forms[0].hidBeanGetMethod.value=methodname;
		document.forms[0].action=appURL+"action/"+pagename;
		document.forms[0].flowtype.value=type;
		document.forms[0].submit();
	
}   
function callLink(page,bean,method)
{	
	document.forms[0].hidSourceUrl.value=page;
	document.forms[0].hidSourceUrl.value=page;
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].hidCategoryType.value="STL";
	document.forms[0].action=appUrl+"action/"+page;
	document.forms[0].submit(); 
}

function doDelete()
{
	document.forms[0].hidAction.value ="delete";
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidpagedesc.value="norms','bplr";
	document.forms[0].hidBeanMethod.value="updateGeneralComment";
	document.forms[0].hidBeanGetMethod.value="getDataComment";
	document.forms[0].hidSourceUrl.value="/action/comstl_comments.jsp"
	document.forms[0].action=appURL+"controllerservlet?type=9";
	document.forms[0].submit();
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=val;		  
		}
	}
}

</script>
</head>

<body onload="placevalues()">
<form name="frmprojectedsales" method = "post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td valign="top" > 
        <jsp:include page="../share/applurllinkscom.jsp" flush="true">         
        <jsp:param name="pageid" value="8" />
        <jsp:param name="cattype" value="<%=strCategoryType%>" />
        <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
    </tr>
    <tr>
	      <td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Short Term Loan  -&gt; Processnote -&gt; Page 3</td>
	</tr>
  </table>
    <span style="display:none;"><lapschoice:borrowertype /></span> <lapschoice:application/>
    <b></b><br>
  <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable border1" align="center">
    <tr> 
      <td valign="top"> 
        <div align="left"> </div>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%" class="outertable">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="3" cellpadding="3" class="outertable border1">
                <tr> 
                  <td valign="top"> 
                    <table width="100%" border="0" cellspacing="3" cellpadding="3" class="outertable">
                      <tr> 
                        <td width="60%" valign="top"><b>Exposure Norms For Unsecured Advances</b></td>
                      </tr>
                      <tr> 
                        <td width="60%" valign="top" > 
                          <textarea name="txt_comments[0]" width="550" cols="110" wrap="VIRTUAL" rows="25" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("comstl_norms"))%>
						</textarea>
                        </td>
                      </tr>
                      <tr> 
                        <td width="60%" valign="top"><b>Umbrella Limit For Sub-BPLR Lending</b></td>
                      </tr>
                     <tr> 
                        <td width="60%" valign="top" > 
                          <textarea name="txt_comments[1]" width="550" cols="110" wrap="VIRTUAL" rows="25" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("comstl_bplr"))%>
						</textarea>
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
  <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
          <tr> 
            <td colspan="3"> <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
            </td>
          </tr>
          <tr> 
            <td colspan="3"></td>
          </tr>
          <tr> 
            <td width="33%">&nbsp; 
              <div align="left"><b> <a href="javascript:callLink('exec_page10.jsp','executive','getData10')" > 
                &lt;&lt;&nbsp; Previous</a></b> </div>
            </td>
            <td width="33%" align="center"><b> 
              <jsp:include page="../com/link1.jsp" flush="true"> 
              <jsp:param name="cattype" value="<%=strCategoryType%>" />
              <jsp:param name="tabid" value="2"/>
              </jsp:include>
              </b></td>
            <td width="33%">&nbsp; 
              <div align="right"><b>Pg.3/5&nbsp;<a href="javascript:callLink('comsre_rating.jsp','executive','getDataSRERatingDetails')" > 
                Next &gt;&gt; </a></b> </div>
            </td>
          </tr>
        </table>
  <br>
  <lapschoice:hiddentag pageid='<%=PageId%>'/>
   <input type="hidden" name="cattype" value="<%=strCategoryType%>"> 
   <input type="hidden" name ="hidpagedesc" value = "">
</form>
</body>
<script language="javascript1.2">
editor_generate('txt_comments[0]');
</script> 
<script language="javascript1.2">
editor_generate('txt_comments[1]');
</script> 
</html>
