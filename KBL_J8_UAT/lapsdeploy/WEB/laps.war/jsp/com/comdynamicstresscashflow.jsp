<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%	
	ArrayList vecData =null;
	String []strCurrYear = new String[4];
	String []strPrevYear = new String[4];
	String []strCurrFinancialType = new String[4];
	String []strPrevFinancialType = new String[4];
	int totnoofyears =0;
	String strSSIType  =Helper.correctNull((String)request.getParameter("hidSSIType"));
String strCategoryType =Helper.correctNull((String)request.getParameter("hidCategoryType"));

	int totalsize =0;
	if(hshValues.size()>0 && hshValues != null)
	{
		totalsize = Integer.parseInt((String)hshValues.get("totvalue"));
		totnoofyears = Integer.parseInt((String)hshValues.get("totalnoofyears"));
	}
	if(hshValues.size()>0 && hshValues != null)	
	{
		for(int j=0; j<4;j++)
		{
			strCurrYear[j]= Helper.correctNull((String)hshValues.get("fincurryear"+Integer.toString(j+1)));	
			strPrevYear[j]= Helper.correctNull((String)hshValues.get("finprevyear"+Integer.toString(j+1)));	
			if(Helper.correctNull((String)hshValues.get("fincurrtype"+Integer.toString(j+1))).equals("A"))
			{
			strCurrFinancialType[j]= "Audited";
			}
			else if(Helper.correctNull((String)hshValues.get("fincurrtype"+Integer.toString(j+1))).equals("U"))
			{
			strCurrFinancialType[j]= "Unaudited";
			}
			else if(Helper.correctNull((String)hshValues.get("fincurrtype"+Integer.toString(j+1))).equals("E"))
			{
			strCurrFinancialType[j]= "Estimated";
			}
			else if(Helper.correctNull((String)hshValues.get("fincurrtype"+Integer.toString(j+1))).equals("P"))
			{
			strCurrFinancialType[j]= "Projection";
			}
			else
			{
			strCurrFinancialType[j]= "";
			}

			strPrevFinancialType[j]= Helper.correctNull((String)hshValues.get("finprevtype"+Integer.toString(j+1)));	
		}
	}
	else
	{
		for(int j=0; j<4;j++)
		{
			strCurrYear[j]="";
			strPrevYear[j] = "";
			strCurrFinancialType[j] ="";
			strPrevFinancialType[j] ="";
		}
	}
%>

<html>
<head>
<title>Cash Flow</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var varyearfrom = "<%=totnoofyears%>";
function onloading()
{ //alert("varyearfrom====="+varyearfrom);
	
	if(eval(document.forms[0].yearfrom.value) >1 )
	{
		//document.forms[0].cmdprev.disabled= false;
	}	

	if(eval(document.forms[0].yearfrom.value)+3 <varyearfrom)
	{
		//document.forms[0].cmdnext.disabled= false;
	}


}

function onPrev()
{
	var var1 = document.forms[0].yearfrom.value;
	if((eval(var1)-3) <varyearfrom)
	{	
		document.forms[0].yearfrom.value = eval(var1)-3;
		document.forms[0].action = appUrl+"action/comdynamicstresscashflow.jsp";
		document.forms[0].hidBeanId.value="comformula";
		document.forms[0].hidBeanGetMethod.value="GetCashFlowData";	
		document.forms[0].submit();	 
	}
}


function onNext()
{
	var var1 = document.forms[0].yearfrom.value;
	if((eval(var1)+3) <varyearfrom)
	{	
		document.forms[0].yearfrom.value = eval(var1)+3;
		document.forms[0].action = appUrl+"action/comdynamicstresscashflow.jsp";
		document.forms[0].hidBeanId.value="comformula";
		document.forms[0].hidBeanGetMethod.value="GetCashFlowData";	
		document.forms[0].submit();	 
	}
}

function onClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].action=appUrl+"action/"+"comproposalsearch.jsp";
		document.forms[0].submit();
	}	
}


function callCashFlow(page,flowtype)
{	
	if(flowtype=="CA")
	{
		document.forms[0].flowtype.value="CA";
	}
	else if (flowtype=="SCA")
	{
		document.forms[0].flowtype.value="SCA";
	}
	else
	{
		document.forms[0].flowtype.value="FU";
	}

	document.forms[0].action = appUrl+"action/"+page;
	document.forms[0].hidBeanId.value="comformula";
	document.forms[0].hidBeanGetMethod.value="GetCashFlowData";	
	document.forms[0].submit();	 
}

function callAssessment()
{
	document.forms[0].hidBeanId.value="combobassessment";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].action = appUrl+"action/bobassessment.jsp?pageval=MPBF1";
	document.forms[0].submit();

}
function ratinganalysis()
{
	document.forms[0].hidBeanId.value="comratingana";
	document.forms[0].hidBeanGetMethod.value = "";
	document.forms[0].access.value = "B";
	document.forms[0].action=appUrl+"action/comratinganalysis.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}

function ratingmodel()
{
	document.forms[0].hidBeanId.value="comratingana";
	document.forms[0].hidBeanGetMethod.value = "getRatingModel";
	document.forms[0].action=appUrl+"action/comratingmodel.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}

function callLink12(page,method)
{	
	
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].action=appUrl+"action/"+page+"?pageval=RA";
	document.forms[0].submit();	 
}

function printreport()
{
	appno = document.forms[0].appno.value;
	yearfrom=document.forms[0].yearfrom.value;
	


	if(document.forms[0].identity.value == "")
	{
		var purl = appUrl+"action/comstresscashflowprint.jsp?hidBeanGetMethod=GetCashFlowData&hidBeanId=comformula&flowtype=SCA&appno="+appno+"&yearfrom="+yearfrom;
			prop = "scrollbars=yes,width=700,height=450,statusbar=yes,menubar=yes";	
			xpos = (screen.width - 700) / 2;
			ypos = (screen.height - 650) / 2;
			prop = prop + ",left="+xpos+",top="+ypos;
			var title = "Print";
			
			
		
		
	}
	else
	{
		
		var purl = appUrl+"action/comstresscashflowprint.jsp?hidBeanGetMethod=GetCashFlowData&hidBeanId=comformula&flowtype=SCA&appno="+appno;
		prop = "scrollbars=yes,width=700,height=550,statusbar=yes";	
			xpos = (screen.width - 700) / 2;
			ypos = (screen.height - 550) / 2;
			prop = prop + ",left="+xpos+",top="+ypos;
			var title = "Print";
			
		
	}

	
		
			window.open(purl,title,prop);


}
function fincomments()
{
	document.forms[0].hidBeanId.value="qisanalysisresult";
	document.forms[0].hidBeanGetMethod.value ="getDataList";
	document.forms[0].hidBeanMethod.value="";
	document.forms[0].action=appUrl+"action/qis_analysis_result.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}
</script>
<style type="text/css">
<!--
select {  font-family: "MS Sans Serif"; font-size: 9px; font-style: normal; color: #003399}
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
textarea {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}

-->
</style>

</head>

<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#EEEAE3" onload="onloading()">
<jsp:include page="../share/help.jsp" flush="true"/>
<form name="frm" method="post" >
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
  <br> <b><i>Home 
              -&gt; Commercial Proposal  -&gt; Risk Analysis </i></b><br>
      <span style="display:none"><laps:borrowertype /></span> <laps:application/>

   <table width="100%" border=0 cellspacing=0 cellpadding=0>
    <tr>
      <td valign="top" colspan="2">
        <table width="95%" border="0" cellspacing="3" cellpadding="2">
          <tr> 
            <td width="8%" height="20" bgcolor="#EEEAE3"> 
              <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#000000" face="MS Sans Serif" size="1"><a href="javascript:callLink12('finratio.jsp','getDataRatio')" class="blackfont">Ratios 
                </a></font></b></font></div>
            </td>
            <td width="10%" height="20" bgcolor="#EEEAE3"> 
              <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#000000" face="MS Sans Serif" size="1"><a href="javascript:callCashFlow('comdynamiccashflow.jsp','CA')" class="blackfont">Cash 
                Flow </a></font></b></font></div>
            </td>
            <td width="15%" bgcolor="#71694F" height="20"> 
              <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><b><font face="MS Sans Serif" size="1" color="#FFFFFF"> 
                Stress Cash Flow </font></b></font></div>
            </td>
            <td width="10%" height="20" bgcolor="#EEEAE3"> 
              <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><b><font face="MS Sans Serif" size="1"><a href="javascript:callCashFlow('comdynamicfundflow.jsp','FU')" class="blackfont">Fund 
                Flow </a></font></b></font></div>
            </td>
            <td width="11%" height="20" bgcolor="#EEEAE3"> 
              <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><b><font face="MS Sans Serif" size="1"><a href="javascript:callAssessment('bobassessment.jsp')" class="blackfont">Assessment</a></font></b></font></div>
            </td>
         <!--    <td width="15%" height="20" bgcolor="#EEEAE3"> 
              <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><b><font face="MS Sans Serif" size="1"><a href="Javascript:ratinganalysis()" class="blackfont">Rating 
                Analysis </a></font></b></font></div>
            </td>
            <td width="13%" height="20" bgcolor="#EEEAE3" align="center"><font face="Arial, Helvetica, sans-serif" size="2"><b><font face="MS Sans Serif" size="1"><a href="Javascript:ratingmodel()" class="blackfont">Rating 
              Model </a> </font> </b> </font> </td> 
            <td width="18%" height="20" bgcolor="#EEEAE3" align="center"><font face="Arial, Helvetica, sans-serif" size="2"><b><font face="MS Sans Serif" size="1"><a href="Javascript:fincomments()" class="blackfont">Financial 
              Comments</a></font></b></font> </td>-->
          </tr>
        </table>
      </td>
    </tr>
  </table>

 <td width="20%"> 
	<div align="center"> 
      <table width="100%" border="1" cellspacing="0" cellpadding="5" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
        <tr> 
          <td> 
            <table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
              <tr> 
                <td>
                  <table border="0" cellspacing="1" cellpadding="3" width="100%">
                    <tr bgcolor="#A49A7B"> 
                      <%
		if( totalsize >0)
		{
		%>
                      <td width="40%" align="center"><font face="MS Sans Serif" size="1" color="#FFFFFF"><b>Particulars</b></font></td>
                      <%
		}
		else
		{
		%>
                      <%
		}
		%>
                      <td width="15%" align="center" valign="bottom"><b><font  color="#FFFFFF">&nbsp;<%=strCurrYear[0]%> 
                        </font></b></td>
                      <td width="15%" align="center" valign="bottom"><b><font  color="#FFFFFF">&nbsp;<%=strCurrYear[1]%> 
                        </font></b></td>
                      <td width="15%" align="center" valign="bottom"><b><font  color="#FFFFFF">&nbsp;<%=strCurrYear[2]%> 
                        </font></b></td>
                      <td width="15%" align="center" valign="bottom"><b><font  color="#FFFFFF">&nbsp;<%=strCurrYear[3]%></font></b></td>
                    </tr>
                    <tr> 
                      <td width="40%" align="center"><font face="MS Sans Serif" size="1">&nbsp;</font></td>
                      <td align="center" valign="bottom" width="15%"><font size="1" face="MS Sans Serif">&nbsp;<%=strCurrFinancialType[0]%></font></td>
                      <td align="center" valign="bottom" width="15%"><font size="1" face="MS Sans Serif">&nbsp;<%=strCurrFinancialType[1]%> 
                        </font></td>
                      <td align="center" valign="bottom" width="15%"><font size="1" face="MS Sans Serif">&nbsp;<%=strCurrFinancialType[2]%> 
                        </font></td>
                      <td align="center" valign="bottom" width="15%"><font size="1" face="MS Sans Serif">&nbsp;<%=strCurrFinancialType[3]%> 
                        </font></td>
                    </tr>
                    <%
		if(hshValues.size()>0 && hshValues != null && totalsize >0)
		{
		 for(int i=0;i<totalsize;i++)
			{
			  if( hshValues.get("RowType"+Integer.toString(i+1)).equals("HE"))
				{
		%>
                    <tr> 
                      <td width="40%" bgcolor="#CEC8B9"><font size="1" face="MS Sans Serif"><b><%=hshValues.get("Label"+Integer.toString(i+1))%></b> 
                        </font></td>
                      <td height="5" bgcolor="#CEC8B9" valign="bottom" align="center" width="15%">&nbsp;</td>
                      <td height="5" bgcolor="#CEC8B9" valign="bottom" align="center" width="15%">&nbsp;</td>
                      <td height="5" bgcolor="#CEC8B9" valign="bottom" align="center" width="15%">&nbsp;</td>
                      <td height="5" bgcolor="#CEC8B9" valign="bottom" align="center" width="15%">&nbsp;</td>
                    </tr>
                    <%
				}
		 else if(hshValues.get("RowType"+Integer.toString(i+1)).equals("LTS"))
				{
				}
		 else
				{
				vecData =(ArrayList)hshValues.get("vecData"+Integer.toString(i+1));
				
		%>
                    <tr bgcolor="#EEEAE3"> 
                      <td width="40%" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif"><%=hshValues.get("Label"+Integer.toString(i+1))%> 
                        </font></td>
                      <td  width="15%"><div align="right" style="width:75"><font size="1" face="MS Sans Serif"><%=vecData.get(0)%></font></div></td>
                      <td  width="15%"><div align="right" style="width:75"><font size="1" face="MS Sans Serif"><%=vecData.get(1)%></font></div></td>
                      <td width="15%"><div align="right" style="width:75"><font size="1" face="MS Sans Serif"><%=vecData.get(2)%></font></div></td>
                      <td width="15%"><div align="right" style="width:75"><font size="1" face="MS Sans Serif"><%=vecData.get(3)%></font></div></td>
                    </tr>
                    <%
				}
			}
		}
		else
		{
		%>
                    <tr> 
                      <td align="center"  bgcolor="" colspan="5"><font size="1" face="MS Sans Serif">NO 
                        DATA FOUND</font>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    </tr>
                    <%
		}
		%>
                  </table>
                </td>
              </tr>
            </table>
            
          </td>
        </tr>
      </table>
      <br>
      <table border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
        <tr> 
          <td> 
            <table border="0" cellspacing="0" cellpadding="3">
              <tr> 
                <!--<td> 
                  <input type="button" name="cmdprev" value="Prev" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:60" onClick="onPrev()" disabled >
                </td>-->
			   <!--<td align="center"> 
                  <input type="button" name="cmdnext" value="Next" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:60" onClick="onNext()" disabled >
                </td> -->
			 <td> <font face="MS Sans Serif">
			 <%	
				if (Integer.parseInt((String)hshValues.get("yearfrom")) > 1  )
				{
			%>
				<font size="1">&lt;&lt;</font></font> <a href="javascript:onPrev()" class="blackfont"><b>Previous</b></a> 
			<%
			   }
			%>
            </td> 

			<td> &nbsp; 
             <%
				if ((Integer.parseInt((String)hshValues.get("yearfrom"))+3) < totnoofyears  )
				{
			 %>
				<a href="javascript:onNext()" class="blackfont"><b>Next</b></a> 
				<font size="1" face="MS Sans Serif">&gt;&gt;</font> 
             <%
				}
			 %>
            </td>

                <td align="right"> 
                  <input type="button" name="cmdclose" value="Close" style='font-weight:bold;background-color:#CC3300;color:white;font-size=10;font-family:mssansserif;width:50'onClick="onClose()" >
                </td>
				<td>
				 <div align="center"> 
                <input type="button" name="cmdPrint" value="Print" style="background-color:#8F8369;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="printreport()">
              </div>
			  </td> 
              </tr>
            </table>
          </td>
        </tr>
      </table>
      
    </div>
 </td>
   <td width="20%"> 
	<div align="center"> </div>
 </td>
  <td width="20%"> 
	<div align="center"> </div>
 </td>
 <td width="20%"> 
	<div align="center"> </div>
 </td>
<!--<input type="hidden" name="appno" value="ABCIABCI0000003">-->
<input type="hidden" name="yearfrom" value="<%=hshValues.get("yearfrom")%>">
<input type="hidden" name="flowtype" value="SCA">
<!--<input type="hidden" name="formulaid" value="12">
<input type="hidden" name="curryear" value="31/03/2001">
<input type="hidden" name="currfinancialtype" value="A">
<input type="hidden" name="prevyear" value="31/03/2000">
<input type="hidden" name="prevfinancialtype" value="A">-->

<input type="hidden" name="hidBeanId" value="">
<input type="hidden" name="hidBeanMethod" value="">
<input type="hidden" name="hidBeanGetMethod" value="">
<input type="hidden" name="hidSourceUrl" value="">

<input type="hidden" name="totvalue" value="">
<input type="hidden" name="uptovalue" value="">
<input type="hidden" name="fromvalue" value="">
<input TYPE="hidden" value = "10" name="hidTotal">
<input TYPE="hidden" value = "" name="identity">
<input type="hidden" name="access" value ="B">
<input type="hidden" name="cmdapply" disabled>

</form>

</body>
</html>
