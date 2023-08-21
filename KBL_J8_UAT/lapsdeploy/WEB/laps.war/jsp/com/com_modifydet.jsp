<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<% request.setAttribute("_cache_refresh", "true"); %>
<laps:handleerror />
<%
String strSSIType  =Helper.correctNull((String)request.getParameter("hidSSIType"));
String strCategoryType =Helper.correctNull((String)request.getParameter("hidCategoryType"));
String strBorrowerType =Helper.correctNull((String)request.getParameter("hidBorrowerType"));


ArrayList vec = null;
 int vecsize=0;
 ArrayList vecConf = null;
 int vecsize1=0;
 
 if (hshValues != null)
 {
   
   vec = (ArrayList)hshValues.get("vecVal");
   vecConf = (ArrayList)hshValues.get("vecDoc");
  

 }

if(vec!=null)
{
	vecsize =vec.size();
	
}
if(vecConf!=null)
{
	vecsize1 =vecConf.size();
	
}
%>
<html>
<head>
<title>Proposal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
-->
</style>
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 150;
  overflow: auto;
}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
a:hover {  color: #FF3300}
textarea {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
</STYLE>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>jsp/htm/link.css" type="text/css">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
function enableButtons(bool1,bool2,bool3,bool4)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdapply.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmdclose.disabled=bool4;
	
}

function call_page(url)
{
	
	document.forms[0].action=appURL+"action/"+url;
	document.forms[0].submit();
	
}



function show_details()
{
	

	
	

}

function placevalues()
{
	show_details();
	enableButtons(false,true,true,false);
	for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text" || document.forms[0].elements[i].type=="textarea" )
			{
			  document.forms[0].elements[i].readOnly=true;
			  
			}
			
		}
}


function oncancel(url,method)
{
	if (ConfirmMsg(102))
	{
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].action=appURL+"action/"+url;
	document.forms[0].submit();
	}
}

function callClose()
{
	var cattype=document.forms[0].cattype.value;
	var id=document.forms[0].id.value;
 if((cattype=="ASSI")||(cattype=="ASBI"))
        {
       if(ConfirmMsg(100))
	 { 
		document.forms[0].action=appURL+"action/agrsearch.jsp?&id="+document.forms[0].id.value;
		document.forms[0].submit();
	 }
		}
		if((cattype=="SSI")||(cattype=="CORP")||(cattype=="SME"))
        {
        if(ConfirmMsg(100))
	 {
		document.forms[0].action=appURL+"action/comsearch.jsp?&id="+document.forms[0].id.value;
		document.forms[0].submit();
	 }
		}
}


function onedit()
{
		
	for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text" || document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=false;
			  
			}
			
		}
	enableButtons(true,false,false,true);
}

function apply()
{
	
   
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidBeanMethod.value="updateConfirm";
	document.forms[0].hidBeanGetMethod.value="getDataConfirm";
	document.forms[0].hidSourceUrl.value="/action/com_confirmdet.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function call_page(url,method,type)
{
	
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url+"?type="+type;
	document.forms[0].submit();
	
}


function callDocuments()
{
	document.forms[0].action=appUrl+"action/comfacilitydocuments.jsp?hidComDocType=a";
	document.forms[0].method="post";
	document.forms[0].submit();
}

function callTerms()
{
	document.forms[0].action=appUrl+"action/comtermsandcond.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}
</script>

</head>


<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#EEEAE3" >
<jsp:include page="../share/help.jsp" flush="true"/> 

<form name="frmpri" method = post>
 <table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr> 
			<td valign="top" colSpan=5> 
              <jsp:include page="../share/menus.jsp" flush="true"/> 
              <jsp:include page="../com/proposallinks.jsp" flush="true"> 
              <jsp:param name="pageid" value="9" />
			   <jsp:param name="cattype" value="<%=strCategoryType%>" />
			  <jsp:param name="ssitype" value="<%=strSSIType%>" />
			
              </jsp:include>
            </td>
          </tr>
        </table>
  <b><i>Home-&gt; Corporate-&gt; 
  Proposal-&gt; Modification in Documents and Terms &amp; Cond.</i></b><br>
      <span style="display:none"><laps:borrowertype /></span> <laps:application/>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr> 
      <td valign="bottom"> 
        <table width="50%" border="0" cellspacing="3" cellpadding="3">
          <tr align="center"> 
            <!-- <td width="20%" bgcolor="#EEEAE3"><font face="MS Sans Serif" size="1"><b><font color="#000000"><a href="javascript:showpage('com_operdet.jsp','getDataOper')" class="blackfont">Banking 
              Details </a></font></b></font></td>
            <td width="21%" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif"><b><a href="javascript:showpage('com_confirmdet.jsp','getDataConfirm')" class="blackfont">Confirmation 
              of Action</a></b></font></td> -->
            <td width="30%" bgcolor="#EEEAE3"><font face="MS Sans Serif"
					size="1"><b><a href="javascript:callTerms()" class="blackfont"><font
					size="1" face="MS Sans Serif"><b>Terms and Conditions</b></font></a></b></font></td>
			<td width="25%" bgcolor="#EEEAE3"><a href="javascript:callDocuments()" class="blackfont"><font size="1" face="MS Sans Serif"><b>Documents</b></font></a></td>           
			 <td width="45%" bgcolor="#71694F"><font face="MS Sans Serif" size="1"><b><font color="#FFFFFF">Modification 
              in Documents and Terms &amp; Cond.</font></b></font></td>
           <!--   <td width="28%" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif"><b><font size="1" face="MS Sans Serif"><a href="javascript:call_page('com_auditobserv.jsp','getDataComment','7')" class="blackfont">Auditor 
              Observation / Major Inspection Irregularities</a></font></b></font></td>-->
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <table width="100%" border="1" cellspacing="0" cellpadding="5" height="257" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
    <tr> 
      <td valign="top" height="262"> 
        <table width="100%" border="0" cellspacing="1" cellpadding="3">
          <tr> 
            <td colspan="3"><font size="1" face="MS Sans Serif"><b> Modifications 
              in Terms &amp; Conditions</b></font></td>
          </tr>
          <tr bgcolor="#B1AA8F"> 
            <td width="23%" align="center" bgcolor="#B1AA8F"><font color="#000000" size="1" face="MS Sans Serif">Facility 
              Type</font></td>
            <td width="29%" align="center"><font color="#000000" size="1" face="MS Sans Serif">Terms 
              &amp; Conditions</font></td>
            <td width="48%" align="center"><font color="#000000" size="1" face="MS Sans Serif">Comments 
              </font></td>
          </tr>
          <%
String prevTerm="";
String nextTerm="";
							ArrayList g1=null;
					
				if(vec !=null)
				{
					 vecsize =vec.size();
					 for (int l=0;l<vecsize;l++)
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
						
						if (prevTerm.trim().equals(""))
						{
							nextTerm=nextTerm;
						}
						else
						{
							nextTerm=prevTerm;
						}					
						if(colSize>0)	
						 {
						    String check=Helper.correctNull((String)g1.get(4));
						  	if (!check.trim().equals("A"))
							{
								String strTermsandcond="";

								if(Helper.correctNull((String)g1.get(1)).trim().equals(nextTerm))
								{
									strTermsandcond="";
								}
								else
								{
									strTermsandcond = Helper.correctNull((String)g1.get(1));
								}
								prevTerm=strTermsandcond;
								//out.println("prevTerm"+prevTerm);
							   %>
          <tr bgcolor="#EEEAE3"> 
            <td width="23%" bgcolor="#EEEAE3"> <font size="1" face="MS Sans Serif"><b><%=strTermsandcond%></b><br>
              -- <%=Helper.correctNull((String)g1.get(2))%> </font></td>
            <td width="29%"> <font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)g1.get(3))%> 
              </font></td>
            <td width="48%"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)g1.get(5))%></font></td>
          </tr>
          <% }
						   else
							{
									%>
          <tr bgcolor="#EEEAE3"> 
            <td width="23%"> <font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)g1.get(1))%>-- 
              <%=Helper.correctNull((String)g1.get(2))%> </font></td>
            <td width="29%"> <font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)g1.get(3))%> 
              </font></td>
            <td width="48%"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)g1.get(5))%></font></td>
          </tr>
          <%
							}
						}
					 }
				 }
				
					 %>
        </table>
                                    
        <table width="100%" border="0" cellspacing="1" cellpadding="3">
          <tr> 
            <td colspan="3"><font size="1" face="MS Sans Serif"><b> Modifications 
              in Documents</b></font></td>
          </tr>
          <tr bgcolor="#B1AA8F"> 
            <td width="23%" align="center" bgcolor="#B1AA8F"><font color="#000000" size="1" face="MS Sans Serif"> 
              Type</font></td>
            <td width="29%" align="center"><font color="#000000" size="1" face="MS Sans Serif">Documents</font></td>
            <td width="48%" align="center"><font color="#000000" size="1" face="MS Sans Serif">Comments 
              </font></td>
          </tr>
          <%
String prevDoc="";
String nextDoc="";
							ArrayList g2=null;
					
				if(vecConf !=null)
				{
					 vecsize1=vecConf.size();
					 for (int k=0;k<vecsize1;k++)
					 {
						 int colSize1=0;
						 if(k<vecsize1)
						 {
							 g2 = (ArrayList)vecConf.get(k);
							 if(g2!=null)
							 {
							    colSize1 = g2.size();
       						 }
						 }
						
						if (prevDoc.trim().equals(""))
						{
							nextDoc=nextDoc;
						}
						else
						{
							nextDoc=prevDoc;
						}					
						if(colSize1>0)	
						 {
						    String check1=Helper.correctNull((String)g2.get(4));
						  	if (!check1.trim().equals("A"))
							{
								String strTermsandcond1="";

								if(Helper.correctNull((String)g2.get(1)).trim().equals(nextDoc))
								{
									strTermsandcond1="";
								}
								else
								{
									strTermsandcond1 = Helper.correctNull((String)g2.get(1));
								}
								prevDoc=strTermsandcond1;
								//out.println("prevTerm"+prevTerm);
							   %>
          <tr bgcolor="#EEEAE3"> 
            <td width="23%" bgcolor="#EEEAE3"> <font size="1" face="MS Sans Serif"><b><%=strTermsandcond1%></b><br>
              -- <%=Helper.correctNull((String)g2.get(2))%> </font></td>
            <td width="29%"> <font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)g2.get(3))%> 
              </font></td>
            <td width="48%"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)g2.get(4))%></font></td>
          </tr>
          <% }
						   else
							{
									%>
          <tr bgcolor="#EEEAE3"> 
            <td width="23%"> <font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)g2.get(1))%>-- 
              <%=Helper.correctNull((String)g2.get(2))%> </font></td>
            <td width="29%"> <font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)g2.get(3))%> 
              </font></td>
            <td width="48%"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)g2.get(4))%></font></td>
          </tr>
          <%
							}
						}
					 }
				 }
				
					 %>
        </table>
      </td>
    </tr>
  </table>
  <br>
  <table width="12%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"  align="center">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="2">
          <tr valign="top">
          
            <td width="0"> 
              <div align="center"> 
                <input type="button" name="cmdclose" value="Close"  style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"  onClick="callClose()">
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <input type=hidden name="hidBeanId" >
<input type=hidden name="hidBeanMethod"  >
<input type=hidden name="hidBeanGetMethod" >
<input type=hidden name="hidSourceUrl">
<input type="hidden" name="cattype" value="<%=strCategoryType%>"> 
<input type="hidden" name="ssitype" value="<%=strSSIType%>"> 
<input type="button" name="cmdapply" disabled style="visibility:hidden"/>
 <input type="hidden" name="id" value="<%=strBorrowerType%>">	
</form>
</body>
</html>
