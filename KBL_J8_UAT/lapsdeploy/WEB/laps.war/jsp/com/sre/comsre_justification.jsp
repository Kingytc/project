<%@include file="../../share/CKEditor.jsp"%>
<%@include file="../../share/directives.jsp"%>
<html>
<head>
<title>Proposal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/stylet.css" type="text/css">
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
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="textarea")
		{
			 document.forms[0].elements[i].readOnly=true;
		}
	}
}

function doCancel(url,method,type)
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="comproposal"
		document.forms[0].hidBeanGetMethod.value="getDataComment"
		document.forms[0].hidSourceUrl.value="/action/comsre_justification.jsp"
		document.forms[0].action=appURL+"controllerservlet?type=8";
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
for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="textarea")
		{
		  document.forms[0].elements[i].readOnly=false;
		  
		}
		
	}
	enableButtons(true,false,false,true,false);
	document.forms[0].hidAction.value ="insert";
}

function doSave()
{
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidBeanMethod.value="updateGeneralComment";
	document.forms[0].hidBeanGetMethod.value="getDataComment";
	document.forms[0].hidSourceUrl.value="/action/comsre_justification.jsp"
	document.forms[0].action=appURL+"controllerservlet?type=8";
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
	document.forms[0].hidCategoryType.value="SRE";
	document.forms[0].action=appUrl+"action/"+page;
	document.forms[0].submit(); 
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidBeanId.value="comproposal";
		document.forms[0].hidBeanMethod.value="updateGeneralComment";
		document.forms[0].hidBeanGetMethod.value="getDataComment";
		document.forms[0].hidSourceUrl.value="/action/comsre_justification.jsp"
		document.forms[0].action=appURL+"controllerservlet?type=8";
		document.forms[0].submit();
	}
}

</script>
</head>

<body onload="placevalues()">
<form name="frmprojectedsales" method = "post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td valign="top"> 
        <jsp:include page="../../share/applurllinkscom.jsp" flush="true">         
        <jsp:param name="pageid" value="8" />
        <jsp:param name="cattype" value="<%=strCategoryType%>" />
        <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
    </tr>
  </table>
  <span style="display:none;"><lapschoice:borrowertype /></span> <lapschoice:application/>
    <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable border1" align="center">
    <tr> 
      <td valign="top"> 
        <div align="left"> </div>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%" class="outertable">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="3" cellpadding="3"  class="outertable border1">
                <tr > 
                  <td valign="top"> 
                    <table width="100%" border="0" cellspacing="3" cellpadding="3" class="outertable">
                      <tr class="dataheader"> 
                        <td width="60%" valign="top" ><b>Justifications for Seeking 
                          Extention/Short Review</b></td>
                      </tr>
                      <tr> 
                        <td width="60%" valign="top" > 
                          <textarea name="txt_srecomments" width="550" cols="110" wrap="VIRTUAL" rows="25"><%=Helper.correctNull((String)hshValues.get("comsre_comments"))%>
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
            <td colspan="3"> <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/><lapschoice:hiddentag pageid='<%=PageId%>'/>
            </td>
          </tr>
          <tr> 
            <td colspan="3"></td>
          </tr>
          <tr> 
            <td width="33%">&nbsp; 
              <div align="left"><b> <a href="javascript:callLink('comsre_othermatters.jsp','modsancterms','getModsoughtData')"> 
                &lt;&lt;&nbsp; Previous</a></b> </div>
            </td>
            <td width="33%" align="center"><b> 
              <jsp:include page="../../com/link1.jsp" flush="true"> 
              <jsp:param name="cattype" value="<%=strCategoryType%>" />
              <jsp:param name="tabid" value="7"/>
              </jsp:include>
              </b></td>
            <td width="33%">&nbsp; 
              <div align="right"><b>Pg.7/9&nbsp;<a href="javascript:callLink('comsre_rating.jsp','executive','getDataSRERatingDetails')" > 
                Next &gt;&gt; </a></b> </div>
            </td>
          </tr>
        </table>
  <br>

   <input type="hidden" name="flowtype"/>
   <input type="hidden" name="cattype" value="<%=strCategoryType%>"> 
   <input type="hidden" name="yearfrom" value="1">
</form>
</body>
<script language="javascript">
editor_generate('txt_srecomments');
</script> 
</html>
