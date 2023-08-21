<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<% request.setAttribute("_cache_refresh", "true"); %>
<%
if(objValues instanceof java.util.HashMap)
   {
	   hshValues=(java.util.HashMap)objValues;
   }
	ArrayList vecid1 = (ArrayList)hshValues.get("vecid1");
  	ArrayList vecid2 = (ArrayList)hshValues.get("vecid2");
  	ArrayList vecid3 = (ArrayList)hshValues.get("vecid3");
  	ArrayList vecid4 = (ArrayList)hshValues.get("vecid4");
  	ArrayList vecid5 = (ArrayList)hshValues.get("vecid5");
 	String bgclr="";String tagFlag = "";
  	int p=0,sizeyear=0,from=0,to=0,vecModSize  =0;
   	String temp="",totcount="",upto="",pageval="",strCurModule="",identity="",strpagetype="";
	totcount = Helper.correctNull((String)hshValues.get("totalyear"));
	upto = Helper.correctNull((String)hshValues.get("upto"));
	pageval=Helper.correctNull((String)hshValues.get("page"));
	identity=Helper.correctNull((String)hshValues.get("identity"));	
	strpagetype=Helper.correctNull((String)hshValues.get("strPage"));	
	String strPrintCheck=Helper.correctNull((String)hshValues.get("printCheck"));
	String fromnext = Helper.correctInt((String) hshValues.get("from"));

	ArrayList arrPrintCheck = new ArrayList();
	StringTokenizer st = new StringTokenizer(strPrintCheck,"-");
	while (st.hasMoreTokens())
		arrPrintCheck.add(st.nextToken());
	strCurModule = pageval;	
	ArrayList g1= new ArrayList();
	ArrayList g2= new ArrayList();
	ArrayList g3= new ArrayList();
	ArrayList year1= new ArrayList();
	ArrayList year2= new ArrayList();
	ArrayList year3= new ArrayList();
	ArrayList year4= new ArrayList();
	ArrayList year5= new ArrayList();
	g2=(ArrayList) hshValues.get("yearvalue");
	g3  = (ArrayList) hshValues.get("value");
	year1 = (ArrayList) hshValues.get("year1");
	year2 = (ArrayList) hshValues.get("year2");
	year3 = (ArrayList) hshValues.get("year3");
	year4 = (ArrayList) hshValues.get("year4");
	year5 = (ArrayList) hshValues.get("year5");
	ArrayList	vecModule = (ArrayList)hshValues.get("tabdetails");
	if(vecModule!=null)
	{
		vecModSize = vecModule.size();
	}
	String yearval[] = new String[5];
	String comboselect[] = new String[5];	
	int y = 0,n=0;	
	 if (g2.size() != 0)
	 {
		 sizeyear=g2.size();		  
	for (int k=0;k<=g2.size()-1;k++)
	{	
			if ((k % 2 ) == 0)
				{				
				temp=Helper.correctNull((String)g2.get(k));
				yearval[y]=temp;
				y =y+1;
				}
			else if ((k % 2) == 1)
				{
				temp=Helper.correctNull((String)g2.get(k));
					if (temp.trim().equals("fin_audit"))
					{
						temp = "a";
					}
					else if (temp.trim().equals("fin_unaudit"))
					{
						temp = "u";
					}
					else if (temp.trim().equals("fin_estimated"))
					{
						temp = "e";
					}
					else if (temp.trim().equals("fin_projection"))
					{
					temp = "p";
					}
				comboselect[n]=temp;
				n = n+1;
				} 		
		}		
		for (int d = 0 ; d <= 4 ; d++)
		 {			
			if (comboselect[d] == null)
			 {
			comboselect[d] = "S";
			
			 }
			if (yearval[d] == null)
			 {
			yearval[d]="";			
			 }
			}
	 }
	 else
	 {		
		 for ( p=0;p<=4;p++)
		 {
			comboselect[p]= "S";
			yearval[p]= "";
		 }
	 }
	String strcmaindex=Helper.correctNull((String)request.getParameter("hidcmano1"));
	String strPageVal=Helper.correctNull((String)request.getParameter("pagetype1"));
	String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
	if(strcmaindex.equalsIgnoreCase(""))
		{
		strcmaindex=Helper.correctNull((String)hshValues.get("cma"));
		}	
	String valuesin=Helper.correctNull((String)hshValues.get("strValuesin"));
	if(valuesin.equalsIgnoreCase("C")){
		valuesin="Crores";
	}else if(valuesin.equalsIgnoreCase("L")){
		valuesin="Lacs";
	}else if(valuesin.equalsIgnoreCase("R")){
		valuesin="Rupees";
	}else{
		valuesin="";
	}
	String digiFLag = Helper.correctNull((String)hshValues.get("digiflag"));
			%>
<html>
<head>
<title>Financial</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script  src="<%=ApplicationParams.getAppUrl()%>js/com/finmain.js"></script>
<Script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var cma="<%=Helper.correctNull((String)hshValues.get("fintype"))%>";
var finaced_id="<%= Helper.correctNull((String)hshValues.get("finace_id"))%>";
var varPageVal = "<%=strPageVal%>";
var varAssLiabFlag="<%=Helper.correctNull((String)hshValues.get("AssetandLiab"))%>";

function getSection(modid)
{	

	document.forms[0].hidcmasno.value=cma;
	document.forms[0].hidfinanceid.value=finaced_id;
    
	document.forms[0].pageval.value = modid;
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].action = appUrl+"action/com_FinancialTemp.jsp";
	document.forms[0].submit();
}

function getonlyforrating()
{ 
     if(varAssLiabFlag=="")
     {
    	 alert("Before Proceeding to Only for Rating Assets and Liabilities Should tally"); 
     }
     else 
     {
		document.forms[0].hidcmasno.value=cma;
		document.forms[0].hidfinanceid.value=finaced_id;
		document.forms[0].hidBeanId.value="financial";	
		document.forms[0].hidBeanGetMethod.value="getFinRating";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/FinancialOFRating.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
     }
}

function comboselect()
{
	document.forms[0].combo1.value ="<%=comboselect[0]%>";
	document.forms[0].combo2.value ="<%=comboselect[1]%>";
	document.forms[0].combo3.value ="<%=comboselect[2]%>";
	document.forms[0].combo4.value ="<%=comboselect[3]%>";
	document.forms[0].combo5.value ="<%=comboselect[4]%>";
	<%
	String printCheck="";
	if(arrPrintCheck != null)
	{
		for(int i=0;i<arrPrintCheck.size();i++)
		{
			printCheck =  (String)arrPrintCheck.get(i);
			if(printCheck.equals("p1"))
			{ 
			%>document.forms[0].printchk1.checked='checked';<%
			}
			else if(printCheck.equals("p2"))
			{ 
			%>document.forms[0].printchk2.checked='checked';<%
			}
			else if(printCheck.equals("p3"))
			{ 
			%>document.forms[0].printchk3.checked='checked';<%
			}
			else if(printCheck.equals("p4"))
			{ 
			%>document.forms[0].printchk4.checked='checked';<%
			}
			else if(printCheck.equals("p5"))
			{ 
			%>document.forms[0].printchk5.checked='checked';<%
			}
		}
	}
	%>
}
function shownext(val)
{
	upto = <%=Integer.parseInt(upto)%>;
	
	page="<%=pageval%>";

	pageFrom="<%=strpagetype%>";
	fromnext=<%=Integer.parseInt(fromnext)%>;	
	totcount=<%=totcount%>;
	
	if (val == "n")
	{
	
			if (upto == totcount)
			{
			from =1;
			}
			else
			{
			from = upto + 1;
			}
			
	}
	else if (val == "p")
	{
		from = fromnext - 5;
	}	
	document.forms[0].action=appUrl+"action/finratio.jsp?page="+page+"&from="+from+"&pageFrom="+pageFrom+"&pagetype1="+varPageVal;;
	document.forms[0].hidBeanGetMethod.value="getDataRatio";
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].submit();
}
function doPrint()
{

	var hid_appid = document.forms[0].hid_appid.value;
	if (document.forms[0].identity.value == "")
	{
		upto = "<%=Integer.parseInt(upto)%>";
		page="<%=pageval%>";
		pagefr="<%=strpagetype%>"
		totcount="<%=totcount%>";
		var fromnext="<%=fromnext%>";
		var startfrom = totcount/4;
		
		startfrom = Math.floor(startfrom);
		if (upto == totcount && totcount <= 5)
		{
			from = 1;
		}
		else if(eval(upto % 5)==0) 
		{	
			
			from = upto - 4;
		}
		else if(eval(upto % 5)!=0)
		{
			from = (upto - 5);
			if(from < 5)
			{
				from = from + (5 - from)+1;
			}
			else if(from > 5 && upto == totcount)
			{
				from = (totcount - 1)+1;
			}
			else if(from > 5 && upto < totcount)
			{
				from = (upto - 5)+1;
			}
			from=fromnext;
		}
		var purl = appUrl+"action/finratioprint.jsp?page="+page+"&from="+from+"&hidBeanGetMethod=getDataRatio&hidBeanId=financial&pagefr="+pagefr+"&hidfinid="+finaced_id+"&hid_appid="+hid_appid;
		prop = "scrollbars=yes,width=700,height=450,statusbar=yes,menubar=yes";	
		xpos = (screen.width - 700) / 2;
		ypos = (screen.height - 650) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		var title = "Print";
	}
	else
	{
		page="<%=pageval%>";
		txtyear1=document.forms[0].txtyear1.value;
		txtyear2=document.forms[0].txtyear2.value;
		txtyear3=document.forms[0].txtyear3.value;
		txtyear4=document.forms[0].txtyear4.value;
		combo1=document.forms[0].combo1.value;
		combo2=document.forms[0].combo2.value;
		combo3=document.forms[0].combo3.value;
		combo4=document.forms[0].combo4.value;
		combo5=document.forms[0].combo5.value;
		var purl = appUrl+"action/finratioprint.jsp?page="+page+"&hidBeanGetMethod=getRatioList&hidBeanId=financial&txtyear1="+txtyear1+"&txtyear2="+txtyear2+"&txtyear3="+txtyear3+"&txtyear4="+txtyear4+"&combo1="+combo1+"&combo2="+combo2+"&combo3="+combo3+"&combo4="+combo4+"&combo5="+combo5+"&hidfinid="+finaced_id+"&hid_appid="+hid_appid;
		prop = "scrollbars=yes,width=700,height=550,statusbar=yes";	
		xpos = (screen.width - 700) / 2;
		ypos = (screen.height - 550) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		var title = "Print";
	}
	window.open(purl,title,prop);
}
function doList()
{
	document.forms[0].hidBeanId.value="financial"
	document.forms[0].hidBeanMethod.value="getRatioList";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/finratio.jsp";
	document.forms[0].submit();
}
function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].action=appUrl+"action/"+"comproposalsearch.jsp";
		document.forms[0].submit();
	}	
}
function getInitial()
{
	page="<%=pageval%>";
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].hidBeanGetMethod.value="getDataRatio";
	document.forms[0].action = appUrl+"action/finratio.jsp";
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
function dohlp()     
{
  var hlpvar = appURL+"phlp/corp_proporiskanaly.htm";
  var title = "Ratios";
  var prop = "scrollbars=yes,width=600,height=450";	
  prop = prop + ",left=50,top=150";
  window.open(hlpvar,title,prop);
}  
function callFlowtype(type)
{
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].hidBeanGetMethod.value="getDataRatio";
	document.forms[0].action = appUrl+"action/finratio.jsp?pagefrom="+type+"&pagetype1="+varPageVal;
	document.forms[0].submit();
}
function getdigirating()
{ 
    
		document.forms[0].hidcmasno.value=cma;
		document.forms[0].hidfinanceid.value=finaced_id;
		document.forms[0].hidBeanId.value="financial";	
		document.forms[0].hidBeanGetMethod.value="getDigiRating";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/digiRatingFin.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
}
</script>
</head>
<body onLoad="comboselect()">
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
<form method="post" class="normal">
<%
if(!strPageVal.equalsIgnoreCase("OFR")){
if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
class="outertable">
<tr>
	<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
		<jsp:param name="pageid" value="11" />
		<jsp:param name="cattype" value="<%=strCategoryType%>" />
		<jsp:param name="ssitype" value="<%=strSSIType%>" />
	</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
	</td>
</tr>
</table>
<%}else{%>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
			<td valign="top"> 
              <jsp:include page="../com/proposallinks.jsp" flush="true"> 
              <jsp:param name="pageid" value="8" />
			   <jsp:param name="cattype" value="<%=strCategoryType%>" />
			  <jsp:param name="ssitype" value="<%=strSSIType%>" />
              </jsp:include>
            </td>
          </tr>
          <tr>
          <%if(strSessionModuleType.equals("AGR")){%>
	         <td class="page_flow">
          	Home -&gt; Agriculture -&gt; Proposal -&gt; Financial Analysis -&gt; Ratios
          	</td>
	<%}else{ %>
		<td class="page_flow">
          	Home -&gt; Corporate & SME -&gt; Proposal -&gt; Financial Analysis -&gt; Ratios
          	</td>
		<%} %>	
          	
          </tr>
        </table>
        
<input type="hidden" name="flowtype" value="CA">
<input type="hidden" name="yearfrom" value="1">
 <span style="display:none"></span><lapschoice:borrowertype /><lapschoice:application/>
 <%} %>
 <lapschoice:FinAnalysisTag tabid="1" />  
 <jsp:include page="../com/finratiosublink.jsp" flush="true">
      	<jsp:param name="strpagetype" value='<%=Helper.correctNull((String)hshValues.get("strPage")) %>'/>
      </jsp:include>  
 <%}else{ %> 
 <table width="100%" border="0" cellspacing="0" cellpadding="0"class="outertable">
		<tr>
		<td class="page_flow">Home -&gt;Financial / Rating -&gt;Ratios</td>
	</tr>
</table>
<lapschoice:finapptype  appid='<%=Helper.correctNull((String)hshValues.get("hidapplicantid"))%>' financeid='<%=Helper.correctInt((String)hshValues.get("finace_id"))%>'/>
<table width="100%" cellspacing="0" cellpadding="0" class="outertable">				
					<tr>
						<td><%boolean pflag = false;
			boolean base_year = false;
			int strWidth;
			int tabWidth;
			strWidth = vecModSize;%>
						<table border="0" cellspacing="1" cellpadding="3" class="outertable">
							<tr>
								<%for (int i = 0; i < vecModSize; i++) {
				ArrayList vecVal = (ArrayList) vecModule.get(i);
					if(i==0)
					{
						tagFlag = Helper.correctNull((String)vecVal.get(0));
					}
				   String str1=Helper.correctNull((String)vecVal.get(0));					
				   String strClass;				  
     	 		 if(strWidth == 1)
					{
					tabWidth = 5;
					}
				else if(strWidth == 2)
				{
				tabWidth = 20;
				}
				else
				{
				   tabWidth=80/strWidth;
				}
				if(i==0 && strCurModule.trim().equals(""))
				{
					str1="";
				}
				   
				  strClass="sub_tab_inactive";
				   if (!Helper.correctNull((String) vecVal.get(0))
							.equals("Project Financial Input")) {
				  %> <td  align="center" class="<%=strClass%>">
				<a href="#" onclick="getSection('<%=Helper.correctNull((String)vecVal.get(0))%>')">
				<b><%=Helper.correctNull((String) vecVal.get(0))%></b></a>
								<%
					if (Helper.correctNull((String) hshValues.get("tabname"))
							.equalsIgnoreCase("Project Financial Input")
							|| Helper.correctNull(
									(String) hshValues.get("tabname"))
									.equalsIgnoreCase("INFRA STRUCTURE MODEL")
							|| Helper.correctNull(
									(String) hshValues.get("tabname"))
									.equalsIgnoreCase("OPERATIONS PHASE")) {
						/*if (Helper.correctNull(
								(String) hshValues.get("sel_divID"))
								.equalsIgnoreCase("0")) {
							pflag = true;
						}*/
					}
				}%>
				</td>
								<%}%>
							  	<td align="center" class="sub_tab_active" nowrap><b>FINANCIAL RATIOS</b></td>  
							  	<% if(digiFLag.equalsIgnoreCase("Y")){ %>
							  	<td align="center" class="sub_tab_inactive" nowrap><b><a href="#" onclick="getdigirating()">DIGI RATING</a></b></td>
							  	 <%} else{%>
							  	 <td align="center" class="sub_tab_inactive" nowrap><b><a href="#" onclick="getonlyforrating()">ONLY FOR RATING</a></b></td>
							  	 <%} %>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				<jsp:include page="../com/finratiosublink.jsp" flush="true">
      	<jsp:param name="strpagetype" value='<%=Helper.correctNull((String)hshValues.get("strPage")) %>'/>
      </jsp:include>
 <%} %>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
                <tr> 
                  <td valign="top"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
                    <tr class="dataheader"><td align="right" colspan="7"><b>All Values are in <%=valuesin %></b></td></tr>
                      <tr class="dataheader"> 
                        <td colspan="2" align="center">Particulars</td>
                        <td width="15%" align="center">&nbsp;</td>
                        <td width="15%" align="center">&nbsp;</td>
                        <td width="15%" align="center">&nbsp;</td>
                        <td width="15%" align="center">&nbsp;</td>
                        <td width="10%" align="center">&nbsp;</td>
                      </tr>
                      <tr class="dataheader"> 
                        <td colspan="2">&nbsp; </td>
                        <td width="15%" align="center"> 
                          <input type="text" name="txtyear1" size="13" maxlength="12" style= "border-style=groove" border="1" value="<%=yearval[0]%>" onBlur="checkDate(txtyear1)" readOnly="readonly">
                        </td>
                        <td width="15%" align="center"> 
                          <input type="text" name="txtyear2" size="13" maxlength="12" style= "border-style=groove"  border="1" value="<%=yearval[1]%>" onBlur="checkDate(txtyear2)" readOnly="readonly">
                        </td>
                        <td width="15%" align="center"> 
                          <input type="text" name="txtyear3" size="13" maxlength="12" style= "border-style=groove"  border="1" value="<%=yearval[2]%>" onBlur="checkDate(txtyear3)" readOnly="readonly">
                        </td>
                        <td width="15%" align="center"> 
                          <input type="text" name="txtyear4" size="13" maxlength="12" style=" border-style=groove"  border="1" value="<%=yearval[3]%>" onBlur="checkDate(txtyear4)" readOnly="readonly">
                        </td>
                        <td width="15%" align="center"> 
                          <input type="text" name="txtyear5" size="13" maxlength="12" style=" border-style=groove"  border="1" value="<%=yearval[4]%>" onBlur="checkDate(txtyear5)" readOnly="readonly">
                        </td>
                      </tr>
                      <tr class="dataheader"> 
                        <td colspan="2">&nbsp;</td>
                        <td width="15%" align="center"> 
                          <select name="combo1" disabled="disabled">
                            <option value="S" selected="selected">--Select--</option>
                            <option value="a">Audited</option>
                            <option value="e">Estimated</option>
                            <option value="u">Unaudited</option>
                            <option value="p">Projection</option>
                          </select>
                        </td>
                        <td width="15%" align="center"> 
                          <select name="combo2" disabled>
                            <option value="S" selected>--Select--</option>
                            <option value="a">Audited</option>
                            <option value="e">Estimated</option>
                            <option value="u">Unaudited</option>
                            <option value="p">Projection</option>
                          </select>
                        </td>
                        <td width="15%" align="center"> 
                          <select name="combo3" disabled>
                            <option value="S" selected>--Select--</option>
                            <option value="a">Audited</option>
                            <option value="e">Estimated</option>
                            <option value="u">Unaudited</option>
                            <option value="p">Projection</option>
                          </select>
                        </td>
                        <td width="15%" align="center"> 
                          <select name="combo4" disabled>
                            <option value="S" selected>--Select--</option>
                            <option value="a">Audited</option>
                            <option value="e">Estimated</option>
                            <option value="u">Unaudited</option>
                            <option value="p">Projection</option>
                          </select>
                        </td>
                        <td width="15%" align="center"> 
                          <select name="combo5" disabled>
                            <option value="S" selected>--Select--</option>
                            <option value="a">Audited</option>
                            <option value="e">Estimated</option>
                            <option value="u">Unaudited</option>
                            <option value="p">Projection</option>
                          </select>
                        </td>
                      </tr>     
                      <tr class="datagrid">
                  <td colspan="2" HEIGHT="22"><span class="mantatory"><b>Selected Checkbox to print 
                    the financial year</b></span></td>
	                   	<td align="center" HEIGHT="22" width="14%">
	                   		<input type="checkbox" name="printchk1" value="p1"
	                   		style="border-style:none" disabled="disabled">
	                   	</td>
	                  <td width="16%" align="center" HEIGHT="22">
	                    <input type="checkbox" name="printchk2" value="p2"
	                    style="border-style:none" disabled="disabled">
	                  </td>
                  <td width="16%" align="center" HEIGHT="22">
                    <input type="checkbox" name="printchk3" value="p3"
                   	style="border-style:none" disabled="disabled">
                  </td>
                  <td width="16%" align="center" HEIGHT="22">
                    <input type="checkbox" name="printchk4" value="p4" 
							style="border-style:none" disabled="disabled">
                  </td>
                  <td width="15%" align="center" HEIGHT="22">
                    <input type="checkbox" name="printchk5" value="p5"
							style="border-style:none" disabled="disabled">
					</td>
                </tr>                 
                      <%
					    ArrayList v = (ArrayList) hshValues.get("labeldetails");

						String col1="",col2="",col3="",col4="",col5="",finval="",colval1="";
						String colval2="",colval3="",colval4="",colval5="",strtype="",selectdesc="";
						int vecsize=0,count=1,yearsize=0,finsize=0,startsize=0;
						String colid="",rowid="";
							if(v!=null)
							{
								vecsize =v.size();

							}
							if (year1 != null)
							{
								yearsize = year1.size();
							}
							
							if (yearsize == vecsize)
							{
								finsize = vecsize;
							}
							else if(yearsize < vecsize)
							{
								finsize = yearsize;
							}


				for(int l=0;l<finsize;l++)
				{
					g1 = (ArrayList)v.get(l);
					colid = Helper.correctNull((String)g1.get(0));
					colid=colid.trim();
					
					
					if (year1 != null)
					{						
						rowid=Helper.correctDouble((String)vecid1.get(l));					
						rowid=rowid.trim();
						if (rowid.equals(colid))
						{							
							colval1=Helper.correctDouble((String)year1.get(l));						
						}
						else
						{
							colval1 = "0.00";
						}					
						
					}
					else
					{
						colval1="0.00";
					}
					
					if (year2 != null)
					{
						rowid=Helper.correctDouble((String)vecid2.get(l));
						if (rowid.equals(colid))
						{
														
						colval2=Helper.correctDouble((String)year2.get(l));
						}
						else
						{
						colval2="0.00";
						}
					}
					else
					{
						colval2="0.00";
					}
					
					if (year3 != null)
					{
						rowid=Helper.correctDouble((String)vecid3.get(l));
						if (rowid.equals(colid))
						{
														
						colval3=Helper.correctDouble((String)year3.get(l));
						}
						else
						{
						colval3="0.00";
						}
					}
					else
					{
						colval3="0.00";
					}

					if (year4 !=null)
					{
						rowid=Helper.correctDouble((String)vecid4.get(l));
						if (rowid.equals(colid))
						{
								
						colval4=Helper.correctDouble((String)year4.get(l));
						}
						else
						{
						colval4="0.00";
						}
					}
					else
					{
						colval4="0.00";
					}
					if (year5 !=null)
					{
						rowid=Helper.correctDouble((String)vecid5.get(l));
						if (rowid.equals(colid))
						{
								
						colval5=Helper.correctDouble((String)year5.get(l));
						}
						else
						{
						colval5="0.00";
						}
					}
					else
					{
						colval5="0.00";
					}

					col1="row"+Helper.correctNull((String)g1.get(0))+"c1";
					col2="row"+Helper.correctNull((String)g1.get(0))+"c2";
					col3="row"+Helper.correctNull((String)g1.get(0))+"c3";
					col4="row"+Helper.correctNull((String)g1.get(0))+"c4";
					col5="row"+Helper.correctNull((String)g1.get(0))+"c5";
					
					selectdesc="desc"+Helper.correctNull((String)g1.get(0));
					strtype=Helper.correctNull((String)g1.get(2));
			%>
                      <tr class="datagrid"> 
                        <td width="2%" align="center"> 
                          <INPUT TYPE="hidden" name="id" value="<%=Helper.correctNull((String)g1.get(0))%>">
                          <INPUT TYPE="hidden" name="type" value="<%=Helper.correctNull((String)g1.get(2))%>">                         			  
						  </td>
						  <%if(strtype.equalsIgnoreCase("HE")){
                      		 %>
                      		  <td width="28%" colspan="6"><B><%=Helper.correctNull((String)g1.get(1))%></B></td>
                        
                        <%    }
						  else
						  {
							  %>
							 <td width="28%"> <%=Helper.correctNull((String)g1.get(1))%></td>
							  <%
						  }
                        	// For Bank model cma no: 2,First year ratio is made 0.00
                        	// Modified by: Muralidharan
                        	// Date: 04/01/2008                        	
                        	String cma_no=Helper.correctNull((String)hshValues.get("cma_no"));
						   	int bankmodel_upto = Integer.parseInt(upto);
                        	int bankmodel_totcount = Integer.parseInt(totcount);                        	
                        	int first = bankmodel_upto + 1;
                        	int flag=0;                          
                        	
                        	if(bankmodel_totcount<=5)
                        	{                        		
                        		flag=1;                         		
                        	}
                        	
                        	if(bankmodel_totcount>5)
                        	{
                        		if(bankmodel_upto<=5)
                            	{                        		
                            		flag=1;                             		
                            	}                        		                        	
                        	}
                        	
                        	if(first == 1)
                        	{
                        		flag=0;                        		
                        	}
                        	if(!strtype.equalsIgnoreCase("HE")){%>
                    
                        <td width="15%" align="right"><%=colval1%></td>                    						
                        <td width="15%" align="right"><%=colval2%></td>								
                        <td width="15%" align="right"><%=colval3%></td>                        		
                        <td width="15%" align="right"><%=colval4%></td>
                         <td width="15%" align="right"><%=colval5%></td>                       
                      </tr>
                      <%}
				}
						  int endsize=0;
						  startsize = finsize ;
						 	 if(yearsize < vecsize)
							{
								for(int l=startsize;l<vecsize;l++)
								{									
								g1 = (ArrayList)v.get(l);
								colval1="0.00";
								colval2="0.00";
								colval3="0.00";
								colval4="0.00";
								colval5="0.00";
								col1="row"+Helper.correctNull((String)g1.get(0))+"c1";
								col2="row"+Helper.correctNull((String)g1.get(0))+"c2";
								col3="row"+Helper.correctNull((String)g1.get(0))+"c3";
								col4="row"+Helper.correctNull((String)g1.get(0))+"c4";
								col5="row"+Helper.correctNull((String)g1.get(0))+"c5";
								
								selectdesc="desc"+Helper.correctNull((String)g1.get(0));
								strtype=Helper.correctNull((String)g1.get(2));%>
                      <tr class="datagrid"> 
                        <td width="2%" align="center"> 
                          <INPUT TYPE="hidden" name="id" value="<%=Helper.correctNull((String)g1.get(0))%>">
                          <INPUT TYPE="hidden" name="type" value="<%=Helper.correctNull((String)g1.get(2))%>">
                         &nbsp;
						 </td>
						 <%
						 //added by s.sathya moorthy for splitting heading and formulae.
						 boolean boolflag=false;
						 String ratio_type=Helper.correctNull((String)g1.get(2));
						 if(ratio_type.equalsIgnoreCase("HE"))boolflag=true;%>
                        <td width="28%"><%if(boolflag){%><strong><%}%><%=Helper.correctNull((String)g1.get(1))%><%if(boolflag){%></strong><%}%></td>
                        <td width="15%" align="right"><%if(!boolflag)out.println(colval1);%></td>							
                        <td width="15%" align="right"><%if(!boolflag)out.println(colval2);%></td>								
                        <td width="15%" align="right"><%if(!boolflag)out.println(colval3);%></td>                        		
                        <td width="15%" align="right"><%if(!boolflag)out.println(colval4);%></td>
                        <td width="15%" align="right"><%if(!boolflag)out.println(colval5);%></td>                        
                      </tr>
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
  <table border="0" cellspacing="0" cellpadding="0" align="right" class="outertable">
    <tr> 
      <td width="90" align="center"><%if ((Integer.parseInt(totcount) > 5) && (Integer.parseInt(fromnext) != 1) ){%>
        &lt;&lt;<a href="javascript:shownext('p')">Previous</a> 
        <%}%>
      </td>
      <td width="72" align="center"> &nbsp; 
        <%int y1=Integer.parseInt(totcount);
 if ((y1 > 4) && (Integer.parseInt(upto)!= y1))
{%><a href="javascript:shownext('n')">Next</a> &gt;&gt;<%}%></td>
      <td width="1" align="center">&nbsp; </td>
      <td width="48"> &nbsp;</td>
    </tr>
  </table>	
  <br>
<lapschoice:combuttonnew btnnames='Print' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br> 
<input type="hidden" name="totvalue" value="<%=totcount%>">
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="uptovalue" value="<%=upto%>">
<input type="hidden" name="fromvalue" value="<%=Integer.parseInt(upto) + 1%>">
<INPUT TYPE="hidden" value = "<%=pageval%>" name="pageval">
<INPUT TYPE="hidden" value = "10" name="hidTotal">
<INPUT TYPE="hidden" value = "<%=identity%>" name="identity">
<input type="hidden" name="access" value ="B">
<input type="hidden" name="cmdsave" disabled>
<input type="hidden" name="hidcmano" value="<%=Helper.correctNull((String)hshValues.get("cma_index"))%>">
<input type="hidden" name="hidcmano1" value="<%=strcmaindex%>">
<INPUT TYPE="hidden" NAME="hidfinanceid" value="<%=Helper.correctInt((String)hshValues.get("finace_id"))%>">
<INPUT TYPE="hidden" NAME="hidfinid" value="<%=Helper.correctInt((String)hshValues.get("finace_id"))%>">
<INPUT TYPE="hidden" NAME="hidcmasno" value="<%=Helper.correctInt((String)hshValues.get("fintype"))%>">
<input type="hidden" name="hid_appid" value="<%=Helper.correctInt((String)hshValues.get("hidapplicantid"))%>">
<input type="hidden" name="AssetandLiab" value="<%=Helper.correctNull((String)hshValues.get("AssetandLiab"))%>">
</form>
</body>
</html>
