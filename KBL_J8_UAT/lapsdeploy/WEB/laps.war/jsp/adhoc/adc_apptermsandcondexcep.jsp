
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />

<%
	ArrayList arrTerms = new ArrayList();
	ArrayList arrTermsComments = new ArrayList();
	ArrayList arrTermId = new ArrayList();
	ArrayList arrTermType = new ArrayList();
	//out.println("hss"+hshValues);

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
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 120;
  overflow: auto;
}
td{
	color:black;
	font-family:"Ms sans serif";
	/* font-size:10; */
}
</style>
<script>
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var pgfrm= "<%= page_from %>";
function undeleteTerms()
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
			window.opener.document.forms[0].hidSourceUrl.value="/action/adc_termscond.jsp";
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
			//window.opener.document.forms[0].hidSourceUrl.value=appUrl+"action/comtermsandcond.jsp?hidBeanGetMethod=getComFacilityTermData&seltermid="+flag;
			window.opener.document.forms[0].hidBeanGetMethod.value="getComFacilityTermData";
			window.opener.document.forms[0].hidSourceUrl.value="/action/adc_termscond.jsp";
			//window.opener.document.forms[0].general.value="general";
			window.opener.document.forms[0].hidtermid.value=termid;
			window.opener.document.forms[0].rdtermid.value=termid;
			//window.opener.document.forms[0].seltermid.value=flag;
			window.opener.document.forms[0].hidterms.value=hidterms;
			window.opener.document.forms[0].appno.value="<%=request.getParameter("appno")%>";
			window.opener.document.forms[0].hidAction.value="undelete";
			window.opener.document.forms[0].hidLoanType.value="Corporate";
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
</script>
</head>
<body bgcolor="#EEEAE3" text="#000000" onblur="self.focus()" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadData()">
<form name="amtfrm">
  
  <br>
  <b>ANNEXURE</b><br>
  <table width="100%" border="0" class="outertable border1" cellspacing="0" cellpadding="3">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="1" cellpadding="3">
          <tr> 
            <td>&nbsp;
			</td>
			<td width="66%" bgcolor="#71694F"> 
              <div align="center"><b>Deleted 
                Data</b></div>
            </td>
			<td bgcolor="#71694F">
              <div align="center"><b>Remarks</b></div>
            </td>
          </tr>
		  <tr> <td colspan="2"><b><%=strHead%></b></td></tr>
          <%
		  if(arrTerms.size()>0)
		  {
			  int x=1;
			  for(int i=0;i<arrTerms.size();i++)
			  {
		%>
		  <tr bgcolor="#EEEAE3"> 
            <td width="10%"><input type="radio" name="rdtermid" value="<%=Helper.correctNull((String)arrTermId.get(i))%>" onClick="enableUndelete()"></td>
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
			<tr bgcolor="#EEEAE3">
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
  <table width="1%" border="0" class="outertable border1" cellspacing="0" cellpadding="0" align="center">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" >
          <tr valign="top"> 
            <td width="15%" align="center"> 
                <input type="button" name="cmdundelete" value="UnDelete" onClick="undeleteTerms()" class="buttonStyle" style="width:100" disabled="disabled"/>
            </td>

            <td width="15%" align="center"> 
                <input type="button" name="cmdclose" value="Close" class="buttonClose" onClick="window.close()">
            </td>
          </tr>
        </table>
        </td>
    </tr>
  </table>
  <input type="hidden" name="hidBeanId" value="">
  <input type="hidden" name="hidBeanMethod" value="">
  <input type="hidden" name="hidBeanGetMethod" value="">
  <input type="hidden" name="hidSourceUrl" value="">
  <input type="hidden" name="hidAction" value="">
  <input type="hidden" name="hidFacId" value="">
  <input type="hidden" name="hidFacType" value="">
  <input type="hidden" name="hidLoanType" value="<%=Helper.correctNull((String)strAction)%>">
  <input type="hidden" name="appno" value="<%=Helper.correctNull((String)request.getParameter("appno"))%>">

  <input type="hidden" name="hidComDocType" value="<%=Helper.correctNull((String)request.getParameter("hidComDocType"))%>">
<input type="hidden" name="readFlag" value="<%=Helper.correctNull((String)session.getAttribute("strGroupRights")).charAt(18)%>">



  

</form>
</body>
</html>

