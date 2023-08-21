 <%@ page import="com.sai.laps.helper.*,java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<% request.setAttribute("_cache_refresh", "true"); %>
<laps:handleerror />
<%
//ArrayList  vecid=new ArrayList();
 ArrayList  vecdesc=new ArrayList();
 ArrayList  vectype=new ArrayList();
 ArrayList  vecCuryear=new ArrayList();
 //ArrayList  vecCuryearHold=new ArrayList();
 ArrayList  vecPreyear=new ArrayList();
 //ArrayList  vecPreyearHold=new ArrayList();
 ArrayList  vecNextyear=new ArrayList();
 ArrayList vecPrevYear1=new ArrayList();
 ArrayList vecNextYear1=new ArrayList();
 //ArrayList  vecNextyearHold=new ArrayList();
 //String strid="";

 if (hshValues!=null)
{
  vecdesc = (ArrayList)hshValues.get("vecdesc");
  vectype=(ArrayList)hshValues.get("vectype");
  vecCuryear = (ArrayList)hshValues.get("year");
  //vecCuryearHold  = (ArrayList)hshValues.get("yearhold");
  vecPreyear = (ArrayList)hshValues.get("prevyear");
  //vecPreyearHold = (ArrayList)hshValues.get("prevyearhold");
  vecNextyear = (ArrayList)hshValues.get("nextyear");
  //vecNextyearHold = (ArrayList)hshValues.get("nextyearhold");
  vecPrevYear1= (ArrayList)hshValues.get("prevyear1");
  vecNextYear1= (ArrayList)hshValues.get("nextyear1");
}
 String strDesc =request.getParameter("pageval");
 String strSSIType  =Helper.correctNull((String)request.getParameter("hidSSIType"));
 String strCategoryType =Helper.correctNull((String)request.getParameter("hidCategoryType"));
 int vecsize=0;
 // String temp="",totcount="",upto="",pageval="",strCurModule="",strvecid="",strvecid1="",strvecid2="",strvecid3="",strvecid4="";
 ArrayList yearval=new ArrayList();
 if (hshValues!=null)
{
 yearval=(ArrayList)hshValues.get("yearvalue");
}
String curYear="";
String curYearDesc="";
String pervYear="";
String prevYearDesc="";
String nextYear="";
String nextYearDesc="";
String pervYear1="";
String prevYearDesc1="";
String nextYear1="";
String nextYearDesc1="";
if (yearval!=null)
{
 curYear= Helper.correctNull((String)yearval.get(0));
 curYearDesc= Helper.correctNull((String)yearval.get(1));
 pervYear= Helper.correctNull((String)yearval.get(2));
 prevYearDesc= Helper.correctNull((String)yearval.get(3));
 nextYear= Helper.correctNull((String)yearval.get(4));
 nextYearDesc= Helper.correctNull((String)yearval.get(5));
 pervYear1= Helper.correctNull((String)yearval.get(6));
 prevYearDesc1= Helper.correctNull((String)yearval.get(7));
 nextYear1= Helper.correctNull((String)yearval.get(8));
 nextYearDesc1= Helper.correctNull((String)yearval.get(9));
}
 
 String a="",b="",c="",d="",e="";
 if (!curYearDesc.trim().equals(""))
 {
	 if(curYearDesc.trim().equals("a"))
	 {
		 a="Audited";
	 }
	else if(curYearDesc.trim().equals("u"))
	 {
		 a="Unaudited";
	 }
	 else if(curYearDesc.trim().equals("e"))
	 {
		 a="Estimated";
	 }
	 else if(curYearDesc.trim().equals("p"))
	 {
		 a="Projection";
	 }
 }
 if(!prevYearDesc.trim().equals(""))
 {
	 if(prevYearDesc.trim().equals("a"))
	 {
		 b="Audited";
	 }
	else if(prevYearDesc.trim().equals("u"))
	 {
		 b="Unaudited";
	 }
	 else if(prevYearDesc.trim().equals("e"))
	 {
		 b="Estimated";
	 }
	 else if(prevYearDesc.trim().equals("p"))
	 {
		 b="Projection";
	 }
 }
 
  if(!nextYearDesc.trim().equals(""))
 {
	  if(nextYearDesc.trim().equals("a"))
	 {
		 c="Audited";
	 }
	else if(nextYearDesc.trim().equals("u"))
	 {
		 c="Unaudited";
	 }
	 else if(nextYearDesc.trim().equals("e"))
	 {
		 c="Estimated";
	 }
	 else if(nextYearDesc.trim().equals("p"))
	 {
		 c="Projection";
	 }
 }
  
  if(!prevYearDesc1.trim().equals(""))
  {
 	 if(prevYearDesc1.trim().equals("a"))
 	 {
 		 d="Audited";
 	 }
 	else if(prevYearDesc1.trim().equals("u"))
 	 {
 		 d="Unaudited";
 	 }
 	 else if(prevYearDesc1.trim().equals("e"))
 	 {
 		 d="Estimated";
 	 }
 	 else if(prevYearDesc1.trim().equals("p"))
 	 {
 		 d="Projection";
 	 }
  }
  
   if(!nextYearDesc1.trim().equals(""))
  {
 	  if(nextYearDesc1.trim().equals("a"))
 	 {
 		 e="Audited";
 	 }
 	else if(nextYearDesc1.trim().equals("u"))
 	 {
 		 e="Unaudited";
 	 }
 	 else if(nextYearDesc1.trim().equals("e"))
 	 {
 		 e="Estimated";
 	 }
 	 else if(nextYearDesc1.trim().equals("p"))
 	 {
 		 e="Projection";
 	 }
  }
  String strcmaindex=Helper.correctNull((String)request.getParameter("hidcmano1"));
	if(strcmaindex.equalsIgnoreCase(""))
	{
	strcmaindex=Helper.correctNull((String)hshValues.get("cma_index"));
	}
%>
<html>
<head>
<title>Financial</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<STYLE>

DIV.cellContainer {	
  width: 100%; height: 250;
  overflow: auto;
}

</STYLE>


<script language="Javascript1.2"><!-- // load htmlarea
_editor_url = "<%=ApplicationParams.getAppUrl()%>";                     // URL to htmlarea files
var win_ie_ver = parseFloat(navigator.appVersion.split("MSIE")[1]);
if (navigator.userAgent.indexOf('Mac')        >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Windows CE') >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Opera')      >= 0) { win_ie_ver = 0; }
if (win_ie_ver >= 5.5) {
  document.write('<scr' + 'ipt src="' +_editor_url+ 'editor.js"');
  document.write(' language="Javascript1.2"></scr' + 'ipt>');  
} else { document.write('<scr'+'ipt>function editor_generate() { return false; }</scr'+'ipt>'); }
// --></script>


<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/blackfont.css" type="text/css">
<Script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";


function callLink(page,bean,method)
{	
	
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appUrl+"action/"+page;
	 document.forms[0].submit();
}

function printreport()
{
	appno = document.forms[0].appno.value;
	yearfrom=document.forms[0].yearfrom.value;
	pageval="<%=request.getParameter("pageval")%>";


	
		var purl = appUrl+"action/bobassessmentprint.jsp?hidBeanGetMethod=getData&hidBeanId=combobassessment&appno="+appno+"&pageval="+pageval;
			prop = "scrollbars=yes,width=700,height=450,statusbar=yes,menubar=yes";	
			xpos = (screen.width - 700) / 2;
			ypos = (screen.height - 650) / 2;
			prop = prop + ",left="+xpos+",top="+ypos;
			var title = "Print";
	
		
			window.open(purl,title,prop);


}

function gototab(beanid,methodname,pagename,flowtype)
{
	document.forms[0].hidBeanId.value=beanid;
	document.forms[0].hidBeanGetMethod.value=methodname;
	document.forms[0].flowtype.value=flowtype;
	document.forms[0].action=appURL+"action/"+pagename;
	document.forms[0].submit();
	
} 


function onedit()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=false;
		}
	}
	enableButtons(true,false,false,false,true);
	document.forms[0].hidAction.value ="insert";
}
function doSave()
{
	enableButtons(true,true,true,true,false);
	document.forms[0].hidBeanId.value="combobassessment";
	document.forms[0].hidBeanMethod.value="UpdateAssessmentoflimit";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].hidSourceUrl.value="/action/bobassessment.jsp?pageval="+"<%=strDesc%>";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdapply.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}
function onloading()
{
	if(document.forms[0].appstatus.value=="Open/Pending")
	{
		enableButtons(false,true,true,true,false);	
	}
	else
	{
		enableButtons(true,true,true,true,false);	
	}
}
function oncancel()
{
	document.forms[0].hidBeanId.value="combobassessment";
	//document.forms[0].hidBeanMethod.value="UpdateAssessmentoflimit";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].action=appURL+"action/bobassessment.jsp?pageval="+"<%=strDesc%>";
	//document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function onDelete()
{
	document.forms[0].hidBeanId.value="combobassessment";
	document.forms[0].hidBeanMethod.value="UpdateAssessmentoflimit";
	document.forms[0].hidAction.value ="delete";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].hidSourceUrl.value="/action/bobassessment.jsp?pageval="+"<%=strDesc%>"
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

</script>
</head>
<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#EEEAE3" onload="onloading()">
<form method="post" >
<input type="hidden" name="access">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr> 
			
      <td valign="top" colSpan=5 height="16"> 
              <jsp:include page="../com/proposallinks.jsp" flush="true"> 
              <jsp:param name="pageid" value="8" />
			   <jsp:param name="cattype" value="<%=strCategoryType%>" />
			  <jsp:param name="ssitype" value="<%=strSSIType%>" />
			
              </jsp:include>
            </td>
          </tr>
        </table>
  <b><i>Home-&gt; Corporate-&gt; 
  Proposal-&gt; Risk Analysis -&gt;Assessment</i></b><br>
          <span style="display:none"><laps:borrowertype /></span> <laps:application/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
    	<tr> 
	      <td valign="bottom">  
	        <table width="95%" border="0" cellspacing="3" cellpadding="0" align="left">
	          <tr>
				<td> 
					<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left">
						<tr>
							<td>
								<laps:FinAnalysisTag tabid="5" />
							</td>
						</tr>
					</table>
				</td>
			</tr>
	        </table>
	       </td>
	    </tr>
	  </table> 
   <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr> 
      <td valign="bottom"> 
        <table width="100%" border="0" cellspacing="3" cellpadding="3" align="left">
          <tr>
			<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left">
					<tr>
						<td><jsp:include page="../com/com_commentstab.jsp" flush="true">
						<jsp:param name="tabid" value="1" />
					</jsp:include></td>
					</tr>
				</table>
			</td>
		</tr>
        </table>
      </td>
    </tr>
  </table>   
  
  <table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" onMouseOver=" ">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr>
            <td>
              <table width="100%" border="0" cellspacing="3" cellpadding="2">
                 <tr> 
				<td>
			<table width="40%" border="1" cellspacing="0" cellpadding="0" align="left" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
				<tr>
					<td>
						<laps:ComAssessmentTab  subtabid='2' assessmenttype='<%=strDesc%>' />
					</td>
				</tr>
			</table>
		</td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td> 
              <table width="100%" border="1" cellspacing="0"  cellpadding="5" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF" height="100%">
                <tr> 
                  <td valign="top"> 
                    <table width="100%" border="0" cellspacing="1" cellpadding="5"   height="157" align="left" >
                      <tr> 
                        <td width="30%" align="center" bgcolor="#9C9372"><font color="#FFFFFF"><b>Particulars</b></font> 
                        </td>
                        <td  align="center" bgcolor="#9C9372" colspan="2"><b>Previous 
                          Year </b></td>
                        <td  align="center" bgcolor="#9C9372"><b>Current 
                          Year </b></td>
                        <td  align="center" bgcolor="#9C9372" colspan="2"><b>Next 
                          Year </b></td>
                      </tr>
                      <tr bgcolor="#BCB7A0"> 
                        <td width="30%">&nbsp;</td>
                        <td align="center"><b><%=pervYear%>&nbsp;</b></td>
                        <td align="center"><b><%=pervYear1%>&nbsp;</b></td>
                        <td align="center"><b><%=curYear%>&nbsp;</b></td>
                        <td align="center"><b><%=nextYear1%>&nbsp;</b></td>
                        <td align="center"><b><%=nextYear%>&nbsp;</b></td>
                      </tr>
                      <tr bgcolor="#BCB7A0"> 
                        <td width="30%">&nbsp;</td>
                        <td align="center"><b>&nbsp;<%=b%></b></td>
                        <td align="center"><b><%=d%>&nbsp;</b></td>
                        <td align="center"><b><%=a%>&nbsp;</b></td>
                        <td align="center"><b><%=e%>&nbsp;</b></td>
                        <td align="center"><b><%=c%>&nbsp;</b></td>
                      </tr>
                      <tr bgcolor="#EEEAE3"> 
                        <td width="30%">&nbsp; </td>
                       <td width="10%" align="center">Amount</td>
                        <td width="10%" align="center">Amount</td>
                        <td width="10%" align="center">Amount</td>
                        <td width="10%" align="center">Amount</td>
                       <td width="10%" align="center">Amount</td>
                      </tr>
                      <%
	  

				if(vecdesc!=null)
				{
					vecsize = vecdesc.size();
				}
				for(int i=0;i<vecsize;i++)
				{
					String desc =Helper.correctNull((String)vecdesc.get(i));
					String type =Helper.correctNull((String)vectype.get(i));
					String col1 =Helper.correctNull((String)vecCuryear.get(i));
					String col3 = Helper.correctNull((String)vecPreyear.get(i));
					String col5 =Helper.correctNull((String)vecNextyear.get(i));
					String col2 = Helper.correctNull((String)vecPrevYear1.get(i));
					String col4=Helper.correctNull((String)vecNextYear1.get(i));
			%>
                      
				<% if(type.trim().equals("HE"))
				{ %>
						<tr bgcolor="#BCB7A0"> 
						<td width="30%"><B><%=desc%></B></td>
                        <td width="10%" align="right">&nbsp;</td>
                        <td width="10%" align="right">&nbsp;</td>
                       <td width="10%" align="right">&nbsp;</td>
                       <td width="10%" align="right">&nbsp;</td>
                       <td width="10%" align="right">&nbsp;</td>

				<% 
					}
				   else
					{
					 
				%>
						<tr bgcolor="#FFFFFF"> 
                        <td width="30%"><%=desc%></td>
                        <td width="10%" align="right" style="width:75"><%=col3%></td>
                        <td width="10%" align="right" style="width:75"><%=col2%></td>
                          <td width="10%" align="right" style="width:75"><%=col1%></td>
                          <td width="10%" align="right" style="width:75"><%=col4%></td>
                          <td width="10%" align="right" style="width:75"><%=col5%></td>
                          
                       
				<%  }
				%>
                      </tr>
                      <%}%>
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
  
   <table width="100%" border="0" cellspacing="0" cellpadding="3">
                      <tr> 
                        <td width="50%" valign="top"> 
                          <textarea name="txt_assessmentoflimit" cols="110" wrap="VIRTUAL" rows="25" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("com_limitassessmnent_comments"))%></textarea>
                        </td>
                        <%if(strDesc.equals("TO")){ %>
                        <td valign="top" align="left" width="50%"><font size="4" color="red" face="MS Sanf Serif">Note:
                        	<ul>
                        		
          <li> The &quot;Eligible Working Capital Finance Limit&quot; (Col. No. 
            7) is the value under Col. 5. or Col. 6. whichever is lower. </li>
                        		
          <li> However in case the &quot;Actual/ Projected NWC&quot; (Col. No. 
            4) is negative, the eligible working capital finance limit can be 
            sanctioned only if the borrower inducts the sufficient margin in the 
            business. </li>
                        		
          <li>Please make a note of it before sanctioning the credit limits to 
            the customer in such cases.</li>
                        	</ul></font>
                        </td>
                        <%} %>
                        
                      </tr>
                    </table>

 <table width="12%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"  align="center">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="2">
          <tr valign="top"> 
            <td width="0" align="center"> 
                <input type="button" name="cmdedit" value="Edit" 
                class="buttonStyle" onClick="onedit()">
            </td>
            <td width="0" align="center"> 
                <input type="button" name="cmdapply" value="Save"
                class="buttonStyle" onClick="doSave()" >
            </td>
            <td width="0" align="center"> 
                <input type="button" name="cmdcancel" value="Cancel"  
                class="buttonStyle" onClick="oncancel()">
            </td>
             <td width="0" align="center"> 
                <input type="button" name="cmddelete" value="Delete"  
                class="buttonStyle" onClick="onDelete()">
            </td>
            <td width="0" align="center"> 
                <input type="button" name="cmdhelp" value="Help"  
                class="buttonHelp" onClick="dohlp()">
            </td>
            <td width="0" align="center"> 
                <input type="button" name="cmdclose" value="Close" 
                 class="buttonClose" onClick="doClose()">
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>





 <!-- <table border="1" cellspacing="0" cellpadding="3" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
    <tr> 
      <td> <input type="button" name="cmdclose" value="Close" onClick="doClose()" style='font-weight:bold;background-color:#CC3300;color:white;font-size=10;font-family:mssansserif;width:50' >
 </td>
 <td>
				 <div align="center"> 
                <input type="button" name="cmdPrint" value="Print" style="background-color:#8F8369;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="printreport()">
              </div>
			  </td> 
    </tr>
  </table>-->
  <input type="hidden" name="hidAction" >
  <input type="hidden" name="hidBeanId">
  <input type="hidden" name="hidBeanMethod" value="">
  <input type="hidden" name="hidBeanGetMethod" value="">
  <input type="hidden" name="hidSourceUrl">
  <input type="hidden" name="totvalue" value="<%//=totcount%>">
  <input type="hidden" name="uptovalue" value="<%//=upto%>">
  <!-- for cashflow-->
<input type="hidden" name="flowtype" value="CA">
<input type="hidden" name="yearfrom" value="1">
<input type="hidden" name="hidcmano1" value="<%=strcmaindex%>">
<!-- -->
</form>
<script language="javascript1.2">
editor_generate('txt_assessmentoflimit');
</script> 
</body>
</html>
