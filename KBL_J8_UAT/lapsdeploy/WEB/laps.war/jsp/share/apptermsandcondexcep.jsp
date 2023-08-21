
<%@include file="../share/directives.jsp"%>

<%
	ArrayList arrTerms = new ArrayList();
	ArrayList arrTermsComments = new ArrayList();
	ArrayList arrTermId = new ArrayList();
	ArrayList arrTermType = new ArrayList();

	if(hshValues.size()>1)
	{
	arrTerms = (ArrayList)hshValues.get("arrTerms");
	arrTermsComments = (ArrayList)hshValues.get("arrTermsComments");
	arrTermId = (ArrayList)hshValues.get("arrTermId");
	}

	String page_from=Helper.correctNull((String)hshValues.get("page_from"));

	if(!page_from.equalsIgnoreCase("documents"))
	{
		arrTermType = (ArrayList)hshValues.get("arrTermType");
	}


	String strHead = Helper.correctNull((String)request.getParameter("seltermvalue"));
	String strAction = Helper.correctNull(request.getParameter("hidAction"));
	String strTermid = Helper.correctNull(request.getParameter("seltermid"));



	
	
%>
<html>
<head>
<title>Deleted Data</title>
<script>
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var pgfrm= "<%= page_from %>";
function doUndelete()
{
	if(pgfrm=="documents")
	{
		var len = document.forms[0].rdtermid.length;
		var flag= "<%=strTermid%>";
		var termid;
		var hidterms;
		if(len==null)
		{
			if(document.forms[0].rdtermid.value==null)
			{
				alert("Select the terms to UnDelete");
				return;
			}
			else
			{
				termid = document.forms[0].rdtermid.value;
			}
		}
		else
		{
			boolval = false;
			for(i=0;i<len;i++)
			{
				if(document.forms[0].rdtermid[i].checked==true)
				{
					termid = document.forms[0].rdtermid[i].value;
					boolval=true;
				}
			}
			if(boolval==false)
			{
				alert("Select the terms to UnDelete");
				return;
			}
		}
		var hidComDocType=document.forms[0].hidComDocType.value;

		window.opener.document.forms[0].hidAction.value="undelete";
		window.opener.document.forms[0].hidBeanId.value="commdocument";
		window.opener.document.forms[0].hidBeanMethod.value="updateComFacilityDocuments";
		window.opener.document.forms[0].action=appUrl+"controllerservlet";
		window.opener.document.forms[0].hidComDocType.value=hidComDocType;
		if (flag=="0^0")
		{	
			window.opener.document.forms[0].hidBeanGetMethod.value="getComFacDocuments";
			window.opener.document.forms[0].hidSourceUrl.value="/action/comfacilitydocuments.jsp";
			window.opener.document.forms[0].general.value="general";
			window.opener.document.forms[0].hidtermid.value=termid;
			window.opener.document.forms[0].rdtermid.value=termid;
			window.opener.document.forms[0].seltermid.value=flag;
			window.opener.document.forms[0].appno.value="<%=request.getParameter("appno")%>";
		}
		else
		{
			window.opener.document.forms[0].hidBeanGetMethod.value="getComFacDocuments";
			window.opener.document.forms[0].hidSourceUrl.value="/action/comfacilitydocuments.jsp";
			window.opener.document.forms[0].hidtermid.value=termid;
			window.opener.document.forms[0].rdtermid.value=termid;
			window.opener.document.forms[0].seltermid.value=flag;
			window.opener.document.forms[0].appno.value="<%=request.getParameter("appno")%>";
		}
	}
	else
	{
		var len = document.forms[0].rdtermid.length;
		var flag= "<%=strTermid %>";
		var termid;
		var hidterms;
		if(len==null)
		{
			if(document.forms[0].rdtermid.value==null)
			{
				alert("Select the terms to UnDelete");
				return;
			}
			else
			{
				termid = document.forms[0].rdtermid.value;
				hidterms=document.forms[0].hidAllTerms.value;
			}
		}
		else
		{
			boolval = false;
			for(i=0;i<len;i++)
			{
				if(document.forms[0].rdtermid[i].checked==true)
				{
				termid = document.forms[0].rdtermid[i].value;
				hidterms=document.forms[0].hidAllTerms[i].value;
				boolval=true;
				}
			}
			if(boolval==false)
			{
				alert("Select the terms to UnDelete");
				return;
			}
		}
		window.opener.document.forms[0].hidAction.value="undelete";
		window.opener.document.forms[0].hidBeanId.value="apptermscond";
		window.opener.document.forms[0].hidBeanMethod.value="updateComFacilityTermData";
		window.opener.document.forms[0].action=appUrl+"controllerservlet";

		if (flag=="0^0")
		{	
		    //document.forms[0].action=appUrl+"action/apptermsandcondexcep.jsp";
			//window.opener.document.forms[0].hidSourceUrl.value=appUrl+"action/comtermsandcond.jsp?hidBeanGetMethod=getComFacilityTermData&general=general";
			window.opener.document.forms[0].hidBeanGetMethod.value="getComFacilityTermData";
			window.opener.document.forms[0].hidSourceUrl.value="/action/comtermsandcond.jsp";
			window.opener.document.forms[0].general.value="general";
			window.opener.document.forms[0].hidtermid.value=termid;
			window.opener.document.forms[0].rdtermid.value=termid;
			window.opener.document.forms[0].seltermid.value=flag;
			window.opener.document.forms[0].hidterms.value=hidterms;
			window.opener.document.forms[0].appno.value="<%=request.getParameter("appno")%>";
			window.opener.document.forms[0].hidAction.value="undelete";
			window.opener.document.forms[0].hidLoanType.value="Corporate";
		}
		else
		{
			window.opener.document.forms[0].hidBeanGetMethod.value="getComFacilityTermData";
			window.opener.document.forms[0].hidSourceUrl.value="/action/comtermsandcond.jsp";
			window.opener.document.forms[0].hidtermid.value=termid;
			window.opener.document.forms[0].rdtermid.value=termid;
			window.opener.document.forms[0].hidterms.value=hidterms;
			window.opener.document.forms[0].appno.value="<%=request.getParameter("appno")%>";
			window.opener.document.forms[0].hidAction.value="undelete";
			window.opener.document.forms[0].hidLoanType.value="Corporate";
		}
	}
	window.opener.document.forms[0].method="post";
	window.opener.document.forms[0].submit();
	window.close();
}

function loadData()
{
	if("<%=strAction%>"=="Corporate")
	{
		var idsplit = "<%=strTermid%>".split('^');
		document.forms[0].hidFacId.value=idsplit[0];
		document.forms[0].hidFacType.value=idsplit[1];
	}
	if("<%=strAction%>" == "undelete")
	{
		window.close();
	}
}

function enableUndelete()
{
if(document.forms[0].readFlag.value.toUpperCase()=="W")
	{
		if(document.forms[0].cmdundelete.disabled==true)
		document.forms[0].cmdundelete.disabled=false;
	}
}
function doClose(){
	window.close();
}
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/set/navigate.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
DIV.cellContainer {	
  width: 100%; height: 130;
  overflow: auto;
}
DIV.cellContainer2 {	
  width: 100%; height: 200;
  overflow: auto;
}
</style>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body  onblur="self.focus()" onLoad="loadData()">
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
<form name=amtfrm class="normal">
  
  
  <br>
  <table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable border1" align="center" style="margin:0 auto;">
  	<tr><td class="dataheader"><b>DELETED TERMS & CONDITIONS</b></td></tr>
    <tr> 
      <td class="datagrid"> 
        <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr class="main_tab_inactive "> 
           <td nowrap="nowrap" ><b style="color:#ffffff;"><%=strHead%></b></td>
			<td width="66%" style="color:#ffffff;" align="center"><b>Deleted Data</b>
            </td>
			<td style="color:#ffffff;" align="center"><b>Remarks</b></td>
          </tr>
          <%
		  if(arrTerms.size()>0)
		  {
			  int x=1;
			  for(int i=0;i<arrTerms.size();i++)
			  {
		%>
		  <tr > 
            <td width="10%"><input type="radio" name="rdtermid" value="<%=Helper.correctNull((String)arrTermId.get(i))%>" onClick="enableUndelete()" style="border:none;"></td>
			<td width="56%" align="left"><%=x++%>) <%=Helper.breakText((String)arrTerms.get(i),100)%></td>
			<td width="34%" align="left"><%=Helper.breakText((String)arrTermsComments.get(i),100)%></td>
			<%
				if(!page_from.equalsIgnoreCase("documents") && arrTermType != null  && arrTermType.size() >0)
				{
			%>
				<Input type="hidden" name="hidAllTerms" value="<%=Helper.correctNull((String)arrTermType.get(i))%>" >
			<%
				}
			%>
			

          </tr>
			<%
			  }
		  }else
		  {
		%>
			<tr >
			<td width="10%" align="right">&nbsp;</td>
            <td width="56%" align="right">&nbsp;</td>
			<td width="34%" align="right">&nbsp;</td>
          </tr>
			<%
		  }
		%>
        </table>
      </td>
    </tr>
  </table>
  <br>
   <%if(arrTerms.size()>0){%>
   <lapschoice:combuttonnew btnnames='UnDelete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
   <%}else{ %>
   <lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
   <%} %>
  
  <input type="hidden" name="hidFacId" value="">
  <input type="hidden" name="hidFacType" value="">
  <input type="hidden" name="hidLoanType" value="<%=Helper.correctNull((String)strAction)%>">
  <input type="hidden" name="appno" value="<%=Helper.correctNull((String)request.getParameter("appno"))%>">

  <input type="hidden" name="hidComDocType" value="<%=Helper.correctNull((String)request.getParameter("hidComDocType"))%>">
<input type="hidden" name="readFlag" value="<%=Helper.correctNull((String)session.getAttribute("strGroupRights")).charAt(18)%>">



  

</form>
</body>
</html>

