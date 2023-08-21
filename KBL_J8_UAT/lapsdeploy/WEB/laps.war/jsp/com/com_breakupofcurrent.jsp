<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<% request.setAttribute("_cache_refresh", "true"); %>
<laps:handleerror />
<%
String strSSIType  =Helper.correctNull((String)request.getParameter("hidSSIType"));
String strCategoryType =Helper.correctNull((String)request.getParameter("hidCategoryType"));
ArrayList arrRow = new ArrayList();
String dat2="",dat3="",dat4="",dat5="",dat6="",dat7="",dat8="";

HashMap hash=(HashMap)hshValues.get("hshresult");

arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();

arrRow=(ArrayList)hash.get("arrRow");

if (arrRow != null && arrRow.size() > 0)
 {
  //for (int i = 0; i < arrRow.size(); i++) {
				// arrCol = new ArrayList();
				arrCol = (ArrayList) arrRow.get(0); 


  //String val1=Helper.correctNull((String) arrCol.get(1));
   dat3=Helper.correctNull((String) arrCol.get(3));
   dat4=Helper.correctNull((String) arrCol.get(4));
   dat5=Helper.correctNull((String) arrCol.get(5));
   dat6=Helper.correctNull((String) arrCol.get(6));
   dat7=Helper.correctNull((String) arrCol.get(7));
   dat8=Helper.correctNull((String) arrCol.get(8));
  //}
  }
%>
<html>
<head>
<title>Proposal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>jsp/htm/link.css" type="text/css">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">

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
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";

var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var currentDate="<%=Helper.getCurrentDateTime()%>";
function htmlView()
{
  var hlpvar = appURL+"action/com/htmlView.jsp?hidBeanId=comproposal&hidBeanGetMethod=getDataComment&type=1&appno="+"<%=Helper.correctNull((String)hshValues.get("appno"))%>";
  var title = "HTMLVIEW";
  var prop = "scrollbars=yes,width=600,height=450";	
  prop = prop + ",left=50,top=150";

  //alert(hlpvar);
  window.open(hlpvar,title,prop);

}


function gototab(beanid,methodname,pagename,flowtype)
{

	if(flowtype=="COP")
	{
		document.forms[0].hidBeanId.value=beanid;
		document.forms[0].hidBeanGetMethod.value=methodname;
		document.forms[0].action=appURL+"action/"+pagename+"?hidPageSource="+flowtype;
		document.forms[0].submit();
	}
	else
	{
		document.forms[0].hidBeanId.value=beanid;
		document.forms[0].hidBeanGetMethod.value=methodname;
		document.forms[0].action=appURL+"action/"+pagename+"?type="+flowtype;
		document.forms[0].submit();
	}
}   
function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdapply.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmdclose.disabled=bool4;
	document.forms[0].cmddel.disabled=bool5;
	
}

 function enablefields()
    {
	 document.forms[0].textfield1.disabled=false;
	  
     if('<%=dat3%>' !='')	 
	 {
		 document.forms[0].textfield2.disabled=false;	
	 }
     if('<%=dat4%>' !='')	 
	 {
		 document.forms[0].textfield3.disabled=false;	
	 }
     if('<%=dat5%>' !='')	 
	 {
		 document.forms[0].textfield4.disabled=false;	
	 }
     if('<%=dat6%>' !='')	 
	 {
		 document.forms[0].textfield5.disabled=false;	
	 }
     if('<%=dat7%>' !='')	 
	 {
		 document.forms[0].textfield6.disabled=false;	
	 }
     if('<%=dat8%>' !='')	 
	 {
		 document.forms[0].textfield7.disabled=false;	
	 }
			 
    }
 
function call_page(url,method,type)
{
	
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url+"?type="+type;
	document.forms[0].submit();
	
}
  function selectvalues(val0,val1,val2,val3,val4,val5,val6,val7)
  {
   
	enableButtons(false,true,false,true,false);
	      
	document.forms[0].hidslno.value=val0;
	document.forms[0].textfield1.value=val1; 
	document.forms[0].textfield2.value=val2;


	document.forms[0].textfield3.value=val3;
	document.forms[0].textfield4.value=val4;
	document.forms[0].textfield5.value=val5;
	document.forms[0].textfield6.value=val6;
	document.forms[0].textfield7.value=val7; 

   }

function placevalues()
{
	
	if(document.forms[0].btnenable.value=="N")	 
	{
	 	document.forms[0].cmdnew.disabled=true;
	 	enableButtons(true,true,true,false,true);
	 	
	}
	else
		{
		enableButtons(false,true,true,false,false);
		
		for(var i=0;i<document.forms[0].elements.length;i++)
				{		
					if(document.forms[0].elements[i].type=="text")
					{
					 document.forms[0].elements[i].disabled=true;			  
					  
					}		
					
				}
		}
}


function doCancel()
{
	if (ConfirmMsg(102))
	{
	
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidBeanGetMethod.value="getBreakUpofNoncurrent";
	document.forms[0].action=appURL+"action/com_breakupofcurrent.jsp";
	document.forms[0].submit();
	}
}

function callclose()
{
	var cattype=document.forms[0].cattype.value;
 if((cattype=="ASSI")||(cattype=="ASBI"))
        {
        if(ConfirmMsg(100))
	 {
		 document.forms[0].action=appURL+"action/agrborrowersearch.jsp";
		 document.forms[0].submit();
	 }
		}
		if((cattype=="SSI")||(cattype=="CORP")||(cattype=="SME"))
        {
        if(ConfirmMsg(100))
	 {
		 document.forms[0].action=appURL+"action/comborrowersearch.jsp";
		 document.forms[0].submit();
	 }
		}
}

function doEdit()
{
    enablefields();
	document.forms[0].hidAction.value ="update"
	enableButtons(true,false,false,true,true);
	
}

function doSave()
{
	enableButtons(true,true,true,false,true);
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidBeanMethod.value="updateBreakUpofNoncurrent";
	document.forms[0].hidBeanGetMethod.value="getBreakUpofNoncurrent";
	document.forms[0].hidSourceUrl.value="/action/com_breakupofcurrent.jsp"
	document.forms[0].action=appURL+"controllerservlet?type=5";
	document.forms[0].submit();
}


//Help function added by vino
function dohlp()     
{
  var hlpvar = appURL+"phlp/corp_propocoment.htm";
  var title = "Comment1";
  var prop = "scrollbars=yes,width=600,height=450";	
  prop = prop + ",left=50,top=150";
  window.open(hlpvar,title,prop);
}
function holdinglevels()
{
	document.forms[0].hidBeanId.value="combobassessment";
	document.forms[0].hidBeanGetMethod.value="updateHoldingLevels";
	document.forms[0].action=appURL+"action/com_holdinglevels.jsp?pageval=HL";
	document.forms[0].submit();
	
}
function callCalender(fname)
 {
	if(document.forms[0].cmdapply.disabled==false)
	{
	 showCal("<%=ApplicationParams.getAppUrl()%>",fname);
 	}
 }
 
 function doDelete()
 {
	 if (ConfirmMsg(101))
		{
 	document.forms[0].hidAction.value ="delete";
 	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidBeanMethod.value="updateBreakUpofNoncurrent";
	document.forms[0].hidBeanGetMethod.value="getBreakUpofNoncurrent";
	document.forms[0].hidSourceUrl.value="/action/com_breakupofcurrent.jsp"
	document.forms[0].action=appURL+"controllerservlet?type=5";
	document.forms[0].submit();
		}
 }
         //document.forms[0].hidSourceUrl.value="/action/com_auditobserv.jsp"
		//document.forms[0].action=appURL+"controllerservlet";

 function doNew()
 {
	    enablefields();
	    
	    document.forms[0].textfield1.value=''; 
		document.forms[0].textfield2.value='';
		document.forms[0].textfield3.value='';
		document.forms[0].textfield4.value='';
		document.forms[0].textfield5.value='';
		document.forms[0].textfield6.value='';
		document.forms[0].textfield7.value=''; 
	 
	 enableButtons(true,false,false,true,true);	 
	 document.forms[0].cmdnew.disabled =true;
	 document.forms[0].hidAction.value ="insert";
	 
 }
	 
</script>
</head>

<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#EEEAE3"
onload="placevalues()">
<jsp:include page="../share/help.jsp" flush="true"/> 

<form name="frmpri" method = post>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr> 
			<td valign="top" colSpan=5> 
              <jsp:include page="../share/menus.jsp" flush="true"/> 
              <jsp:include page="../com/proposallinks.jsp" flush="true"> 
              <jsp:param name="pageid" value="8" />
			   <jsp:param name="cattype" value="<%=strCategoryType%>" />
			  <jsp:param name="ssitype" value="<%=strSSIType%>" />
			
              </jsp:include>
            </td>
          </tr>
        </table>
  <b><i>Home-&gt; Corporate-&gt; 
  Proposal-&gt; Financial Analysis -&gt; Assessment -&gt; Holding Levels -&gt;Break up of Non Current Asset </i></b>
      <span style="display:none"><laps:borrowertype /></span> <laps:application/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
    	<tr> 
	      <td valign="bottom" bgcolor="#DEDACF">  
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
      <td valign="bottom" bgcolor="#DEDACF"> 
        <table width="100%" border="0" cellspacing="3" cellpadding="0" align="left">
          <tr>
			<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left">
				
					<tr>
						<td><jsp:include page="../com/com_commentstab.jsp" flush="true">
						<jsp:param name="tabid" value="5" />
					</jsp:include></td>
					</tr>
					<tr><td>
					<jsp:include page="../com/holdingpage.jsp" flush="true">
					  <jsp:param name="tab" value="2"/>
					  </jsp:include>
					  </td></tr>
				</table>
			</td>
		</tr>
        </table>
      </td>
    </tr>
  </table>
  <table width="80%" border="0" cellspacing="1" cellpadding="7" align="center" >
  <% 
    hash=(HashMap)hshValues.get("hshresult");
   
    arrRow=new ArrayList();
    arrCol=new ArrayList();
   
    arrRow=(ArrayList)hash.get("arrRow");
	
	if (arrRow != null && arrRow.size() > 0)
	 {
  for (int i = 0; i < arrRow.size(); i++) {
					 arrCol = new ArrayList();
					arrCol = (ArrayList) arrRow.get(i); %>
  
  
   <tr bgcolor="#DEDACF">
      <td width="10%" align="center"><%=Helper.correctNull((String) arrCol.get(1))%>&nbsp;</td>
      <td width="6%" align="center"><%=Helper.correctNull((String) arrCol.get(3))%>&nbsp;</td>
      <td width="6%" align="center"><%=Helper.correctNull((String) arrCol.get(4))%>&nbsp;</td>
      <td width="7%" align="center"><%=Helper.correctNull((String) arrCol.get(5))%>&nbsp;</td>
      <td width="6%" align="center"><%=Helper.correctNull((String) arrCol.get(6))%>&nbsp;</td>
      <td width="8%" align="center"><%=Helper.correctNull((String) arrCol.get(7))%>&nbsp;</td>
	  <%if(i==1)
	  { %>
      <td width="23%" align="center" >Accepted</td>
	 <% }
	  else
	  { %>
	  <td width="34%" align="center" ><%=Helper.correctNull((String) arrCol.get(8))%></td>
	  <%}%>
	</tr>
    <%  } } %>
	
    <tr> 
      <td width="10%"> 
        <input type="text" name="textfield1"  size="12" onKeyPress="allowAlphaNumeric()">
      </td>
      <td width="6%"> <laps:CurrencyTag name="textfield2"  maxlength="14" /> </td>
      <td width="6%"> <laps:CurrencyTag name="textfield3"  maxlength="14"  /> 
      </td>
      <td width="7%"> <laps:CurrencyTag name="textfield4"  maxlength="14"  /> 
      </td>
      <td width="6%"> <laps:CurrencyTag name="textfield5"  maxlength="14"  /> 
      </td>
      <td width="8%"> <laps:CurrencyTag name="textfield6"  maxlength="14"  /> 
      </td>
      <td width="23%"> <laps:CurrencyTag name="textfield7"  maxlength="14"  /> 
      </td>
    </tr>
    <tr> 
      <td width="10%">&nbsp;</td>
      <td width="6%">&nbsp;</td>
      <td width="6%">&nbsp;</td>
      <td width="7%">&nbsp;</td>
      <td width="6%">&nbsp;</td>
      <td width="8%">&nbsp;</td>
      <td width="23%">&nbsp;</td>
    </tr>
    <tr> 
      <td width="10%">&nbsp;</td>
      <td colspan=5><laps:combutton btntype="NO" btnenable='Y'/> </td>
      <td width="23%">&nbsp;</td>
    </tr>
  </table>
  <br>
  <table width="80%" border="0" cellspacing="0" cellpadding="7" align="center" class="datagrid">
  <tr class="dataHeadColor" align="center">
      <td>&nbsp;</td>
      <td>field1</td>
      <td>Year1</td>  
      <td>Year2</td>  
      <td>Year3</td>  
      <td>Year4</td>  
      <td>Year5</td>  
      <td>Year6</td>  
      
  </tr>
  <%
   ArrayList arrValues=new ArrayList();
  ArrayList arrcolums=new ArrayList();
   arrValues=(ArrayList)hshValues.get("arrValues");
   if(arrValues!=null)
   {
	   int size1=arrValues.size();
	   for(int i=0;i<size1;i++)
	   {
		   arrcolums=(ArrayList)arrValues.get(i);
		   if(arrcolums!=null)
				   { 
				   
					   %>
			  <tr>		   
			  <td><input type="radio" style="border:none" name="radioselect" onclick="selectvalues(
			                                             '<%=Helper.correctNull((String)arrcolums.get(0)) %>','<%=Helper.correctNull((String)arrcolums.get(1)) %>',
			                                             '<%=Helper.correctNull((String)arrcolums.get(2)) %>','<%=Helper.correctNull((String)arrcolums.get(3)) %>',
			                                             '<%=Helper.correctNull((String)arrcolums.get(4)) %>','<%=Helper.correctNull((String)arrcolums.get(5)) %>',
			                                             '<%=Helper.correctNull((String)arrcolums.get(6)) %>','<%=Helper.correctNull((String)arrcolums.get(7)) %>')"/></td>
		      <td><%=Helper.correctNull((String)arrcolums.get(1)) %></td>
		      <td><%=Helper.correctNull((String)arrcolums.get(2)) %></td>  
		      <td><%=Helper.correctNull((String)arrcolums.get(3)) %></td>  
		      <td><%=Helper.correctNull((String)arrcolums.get(4)) %></td>  
		      <td><%=Helper.correctNull((String)arrcolums.get(5)) %></td>  
		      <td><%=Helper.correctNull((String)arrcolums.get(6)) %></td>  
		      <td><%=Helper.correctNull((String)arrcolums.get(7)) %></td>  
		      </tr>
					   <% 
				   }
		}	   
	   }
	   
  
  %>
</table>
  <input type=hidden name="hidslno" >
  <input type=hidden name="hidBeanId" >
  <input type=hidden name="hidBeanMethod"  >
  <input type=hidden name="hidBeanGetMethod" >
  <input type=hidden name="hidSourceUrl">
   <input type="hidden" name="flowtype"/>
   <input type="hidden" name="hidAction" value=""/>
   <input type="hidden" name="yearfrom" value="1">
   <input type="hidden" name="cattype" value="<%=strCategoryType%>"> 
</form>
</body>