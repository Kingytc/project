<%@include file="../share/directives.jsp"%>
<%

 ArrayList  vecdesc = (ArrayList)hshValues.get("vecdesc");
 ArrayList vectype=(ArrayList)hshValues.get("vectype");
 ArrayList vecCuryear = (ArrayList)hshValues.get("year");
 ArrayList vecCuryearHold  = (ArrayList)hshValues.get("yearhold");
 ArrayList vecPreyear = (ArrayList)hshValues.get("prevyear");
 ArrayList vecPreyearHold = (ArrayList)hshValues.get("prevyearhold");
 ArrayList vecNextyear = (ArrayList)hshValues.get("nextyear");
 ArrayList vecNextyearHold = (ArrayList)hshValues.get("nextyearhold");
 ArrayList vecNextyear2 = (ArrayList)hshValues.get("nextyear2");
 ArrayList vecNextyearHold2 = (ArrayList)hshValues.get("nextyearhold2");
 ArrayList vecPreyear1 = (ArrayList)hshValues.get("prevyear1");
 ArrayList vecPreyearHold1 = (ArrayList)hshValues.get("prevyearhold1");
 
 String strDesc =request.getParameter("pageval");
String strPage=Helper.correctNull((String)hshValues.get("page"));

String noteto11=Helper.correctNull((String)session.getAttribute("noteto"));
ArrayList arryCol=null;
ArrayList arryRow=(ArrayList)hshValues.get("arryRow");
ArrayList vecdata1=(ArrayList)hshValues.get("vecdata1");
ArrayList vecdata2=(ArrayList)hshValues.get("vecdata2");
ArrayList vecdata3=(ArrayList)hshValues.get("vecdata3");
ArrayList vecdata4=(ArrayList)hshValues.get("vecdata4");
ArrayList vecdata5=(ArrayList)hshValues.get("vecdata5");
ArrayList vecdata6=(ArrayList)hshValues.get("vecdata6");
ArrayList vecid=(ArrayList)hshValues.get("vecid");
ArrayList vecForcomment = null;
ArrayList vecSerialno   = null;
int p=0,sizeyear=0,from=0,to=0,vecModSize  =0,vecsize=0;
String temp="",totcount="",upto="",pageval="",strCurModule="";
String strid="",strvecid="",strvecid1="",strvecid2="",strvecid3="",strvecid4="",strvecid5="";

String curYear="",curYearDesc="",pervYear="",prevYearDesc="",nextYear="",nextYearDesc="",pervYear1="",prevYearDesc1="";
String nextYear2="",nextYearDesc2="";

 ArrayList yearval=new ArrayList();
 yearval=(ArrayList)hshValues.get("yearvalue");
 if(yearval.size()>0 && yearval!=null)
 {
	curYear= Helper.correctNull((String)yearval.get(0));
	curYearDesc= Helper.correctNull((String)yearval.get(1));
	pervYear= Helper.correctNull((String)yearval.get(2));
	prevYearDesc= Helper.correctNull((String)yearval.get(3));
	nextYear= Helper.correctNull((String)yearval.get(4));
	nextYearDesc= Helper.correctNull((String)yearval.get(5));
	pervYear1= Helper.correctNull((String)yearval.get(6));
	prevYearDesc1= Helper.correctNull((String)yearval.get(7));
	nextYear2= Helper.correctNull((String)yearval.get(8));
	nextYearDesc2= Helper.correctNull((String)yearval.get(9));
 }
 String a="",b="",c="",d="",e="";
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
 if(nextYearDesc2.trim().equals("a"))
 {
	 e="Audited";
 }
else if(nextYearDesc2.trim().equals("u"))
 {
	 e="Unaudited";
 }
 else if(nextYearDesc2.trim().equals("e"))
 {
	 e="Estimated";
 }
 else if(nextYearDesc2.trim().equals("p"))
 {
	 e="Projection";
 }
 int size=0;
 if(vecdesc!=null)
	{
		 size = vecdesc.size();
	}
 if ( (hshValues.get("forcomment")) != null)
 {
	 vecForcomment=(ArrayList)hshValues.get("forcomment");
	 vecSerialno=(ArrayList)hshValues.get("Serialno");
 }%>
<html>
<head>
<title>Financial</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/com/finmain.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">

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

<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js">
</script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<Script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var size = "<%=size%>";
var forcomment=new Array();
var intserialno=new Array();
<%
   for(int k1=0;k1<vecForcomment.size();k1++){
 %>
	 forcomment[<%=k1%>]="<%=vecForcomment.get(k1)%>";
   	 intserialno[<%=k1%>]="<%=vecSerialno.get(k1)%>";	
<%
 }
%>
function callLink1(page,bean,method)
{	
	
	if(document.forms[0].cmdsave.disabled==true)
	{
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appUrl+"action/"+page;
	 document.forms[0].submit();
	 }
	 else
	 {
	 	ShowAlert('103');
	 	return;
	 }
}

function callAssess(page,flowtype)
{		
	document.forms[0].action=appUrl+"action/"+page;
	document.forms[0].pageval.value=flowtype;
	document.forms[0].hidBeanId.value="executive";
	document.forms[0].hidBeanGetMethod.value="getData8";	
	document.forms[0].submit();	 
}

function callAssessment()
{
	document.forms[0].hidBeanId.value="combobassessment";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].pageval.value="MPBF1";
	document.forms[0].action = appUrl+"action/bobassessment.jsp";
	document.forms[0].submit();

}

function placevalues()
{	
	for(var j=0;j<size;j++)
	{
		 if(forcomment[j]=="Y"){
		 	
			document.forms[0].forcomment[j].checked=true;
		}else{
			
			document.forms[0].forcomment[j].checked=false;
		}
	}
	disableFields(true);
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
	
	}
	for(var k3=0;k3<document.forms[0].forcomment.length;k3++)
	{
		document.forms[0].forcomment[k3].disabled=val;	
	}
}
	
function doEdit()
{
	disableFields(false);
	enableButtons(true,false,false,false,false)
}

function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}

function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="executive"
		document.forms[0].hidBeanGetMethod.value="getData8";
		document.forms[0].action=appUrl+"action/exec_page8.jsp";
		document.forms[0].submit();
	 }
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";	
		document.forms[0].action=appUrl+"action/"+"corppge.jsp";
		document.forms[0].submit();
	}
}

function doSave()
{

	for(var j=0;j<document.forms[0].forcomment.length;j++)
	{
		if(document.forms[0].forcomment[j].checked==true)
		 {		 	
		 	document.forms[0].forcomment1[j].value="Y";		 	
		 }	
		 if(document.forms[0].forcomment[j].checked==false)
		 {		 	
		 	document.forms[0].forcomment1[j].value="N";		 	
		 }
		 document.forms[0].hidserialno[j].value = intserialno[j];	
	 }
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidEditMode.value="U";
	document.forms[0].hidBeanGetMethod.value="insertData";
	document.forms[0].hidBeanId.value="executive";
	document.forms[0].action=appURL+"action/exec_page8.jsp";	
	document.forms[0].submit();
}

function doDelete()
{
	var con=ConfirmMsg('152');
	if(con)
	{
		document.forms[0].hidEditMode.value="D";
		document.forms[0].hidBeanGetMethod.value="insertData";
		document.forms[0].hidBeanId.value="executive";
		document.forms[0].action=appURL+"action/exec_page8.jsp";	
		document.forms[0].submit();
	}
}

function getdivval()
{		
	document.forms[0].hidsel_divID.value=document.forms[0].sel_divID.value;
	document.forms[0].hidBeanId.value="executive";
	document.forms[0].hidBeanGetMethod.value="getData8";
	document.forms[0].action = appUrl+"action/exec_page8.jsp";
	document.forms[0].submit();
}

function gototab(beanid,methodname,pagename,flowtype)
{
	document.forms[0].hidBeanId.value=beanid;
	document.forms[0].hidBeanGetMethod.value=methodname;
	document.forms[0].flowtype.value=flowtype;
	document.forms[0].action=appURL+"action/"+pagename;
	document.forms[0].submit();
} 
</script>
</head>
<body onload="placevalues()">
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
<form method="post"name="frmpri" class="normal">
  <input type="hidden" name="access"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td> <jsp:include page="../com/proposallinks.jsp"
			flush="true">
			<jsp:param name="pageid" value="8" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Proposal -&gt; Financial Analysis -&gt; Financial Indicators -&gt; Financial Indicators
		<span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application />
		</td>
	</tr>
</table>
<lapschoice:FinAnalysisTag tabid="9" />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	<tr>
		<td valign="bottom">
		<table width="30%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="left">
			<tr align="center">
				<td class="sub_tab_active" WIDTH="15%">Financial Indicators</td>
				<td id="prin" class="sub_tab_inactive" WIDTH="15%"><a href="javascript:callLink1('com_finindicatorcomment.jsp','executive','getFinIndicatorComment')">Financial Indicator Comments</a></td>
       		</tr>
		</table>
		</td>
	</tr>
</table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">        
          <tr> 
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable linebor">
                <tr> 
                  <td valign="top"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="3" align="left" class="outertable">
                     <tr class="dataheader"> 
                        <td width="28%" align="center">Particulars&nbsp;</td>
                        <td align="center" width="15%"><%=pervYear%>&nbsp;</td>
                        <td align="center" width="15%"><%=pervYear1%></td>
                        <td align="center" width="12%"><%=curYear%>&nbsp;</td>
                        <td align="center" width="15%"><%=nextYear%>&nbsp;</td>
                        <td align="center" width="15%"><%=nextYear2%>&nbsp;</td>
                      </tr>
                      <tr class="datagrid"> 
                        <td width="28%">&nbsp;</td>
                        <td align="center" width="15%" ><%=b%>&nbsp;</td>
                        <td align="center" width="15%"><%=d%></td>
                        <td align="center" width="12%" ><%=a%>&nbsp;</td>
                        <td align="center" width="15%"><%=c%>&nbsp;</td>
                        <td align="center" width="15%"><%=e%>&nbsp;</td>
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
					String col1 =Helper.correctNull((String)vecCuryear.get(i));//3
					String col3 = Helper.correctNull((String)vecPreyear.get(i));//1
					String col5 =Helper.correctNull((String)vecNextyear.get(i));//4
					String col9 =Helper.correctNull((String)vecNextyear2.get(i));//5
					String col7 =Helper.correctNull((String)vecPreyear1.get(i));
					String col8 =Helper.correctNull((String)vecPreyearHold1.get(i));//2
			%>
                     
                        <% 
				if((type.trim().equals("HE")|| type.trim().equals("H")) && (strPage.trim().equals("MPBF1")))
				{ 				
				%>
					 <tr class="datagrid"> 
                        <td width="28%"><%=desc%></td>
                        <td width="15%" align="center">&nbsp;</td>
                        <td width="15%" align="right">&nbsp;</td>
                        <td width="12%" align="center">&nbsp;</td>
                        <td width="15%" align="center">&nbsp;</td>  
                        <td width="15%" align="right">&nbsp;</td> 
                      </tr>
                      <%
				}
				else if((type.trim().equals("HE")|| type.trim().equals("H")) && (!strPage.trim().equals("MPBF1")))
				{ 				
					%>
					<tr class="datagrid">
                      <td width="28%"><%=desc%></td>
                      <td width="15%" align="center">&nbsp;</td>
                      <td width="15%" align="right">&nbsp;</td>
                      <td width="12%" align="center">&nbsp;</td>
                      <td width="15%" align="center">&nbsp;</td>  
                      <td width="15%" align="right">&nbsp;</td>    
                     </tr>              
                    <% 
				}
				else
				{
				%>
				<tr class="datagrid">
                      <td width="28%">  <input type="hidden" name="forcomment1"> <input type="hidden" name="hidserialno">	<input type="checkbox" name="forcomment"  disabled="disabled" style="border:none">&nbsp;<%=desc%></td>
                      <td width="15%" align="center" > 
                        &nbsp;<%=col3%>
                      </td>
                      <td width="15%" align="right" > 
                        &nbsp;<%=col8%>
                      </td>
                      <td width="12%" align="center" > 
                        &nbsp;<%=col1%>
                      </td>
                      <td width="15%" align="center" > 
                        &nbsp;<%=col5%>
                      </td>
                      <td width="15%" align="center" > 
                        &nbsp;<%=col9%>
                      </td>
                      </tr>
                     <input type="hidden" name="hiddesc" value="<%=desc%>">
                     <input type="hidden" name="hidrowid" value="<%=vecid.get(i)%>">
                      <%}}%>                        
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
      <lapschoice:combuttonnew  btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' btnnames='Edit_Save_Cancel_Delete'/>
      <br>  
 <lapschoice:hiddentag pageid='<%=PageId%>'/>
  <input type="hidden" name="totvalue" value="<%//=totcount%>">
  <input type="hidden" name="uptovalue" value="<%//=upto%>">
  <input type="hidden" name="yearfrom" value="1">
  <INPUT TYPE="hidden" name="hidEditMode"  value="<%=Helper.correctNull((String)hshValues.get("hidEditMode"))%>">
  <input type="hidden" name="hidsel_divID">  
  <input type="hidden" name="flowtype" value="<%=Helper.correctNull((String)hshValues.get("page"))%>"> 
</form>
</body>
</html>
