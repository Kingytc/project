<%@include file="../share/directives.jsp"%>
<%	
	ArrayList vecData =null;
	String []strCurrYear = new String[4];
	String []strPrevYear = new String[4];
	String []strCurrFinancialType = new String[4];
	String []strPrevFinancialType = new String[4];
	int totnoofyears =0;
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
<title>Fund Flow</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/report.css" type="text/css">
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var varyearfrom = "<%=totnoofyears%>";
function onloading()
{ 	
}

function onPrev()
{
	var var1 = document.forms[0].yearfrom.value;
	if((eval(var1)-3) <varyearfrom)
	{	
		document.forms[0].yearfrom.value = eval(var1)-3;
		document.forms[0].action = appUrl+"action/comdynamiccashflow.jsp";
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
		document.forms[0].action = appUrl+"action/comdynamiccashflow.jsp";
		document.forms[0].hidBeanId.value="comformula";
		document.forms[0].hidBeanGetMethod.value="GetCashFlowData";	
		document.forms[0].submit();	 
	}
}

function doClose()
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
function fincomments()
{
	document.forms[0].hidBeanId.value="qisanalysisresult";
	document.forms[0].hidBeanGetMethod.value ="getDataList";
	document.forms[0].hidBeanMethod.value="";
	document.forms[0].action=appUrl+"action/qis_analysis_result.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}
function printreport()
{
	appno = document.forms[0].appno.value;
	yearfrom=document.forms[0].yearfrom.value;
	


	if(document.forms[0].identity.value == "")
	{
		var purl = appUrl+"action/comstresscashflowprint.jsp?hidBeanGetMethod=GetCashFlowData&hidBeanId=comformula&flowtype=FU&appno="+appno+"&yearfrom="+yearfrom;
			prop = "scrollbars=yes,width=700,height=450,statusbar=yes,menubar=yes";	
			xpos = (screen.width - 700) / 2;
			ypos = (screen.height - 650) / 2;
			prop = prop + ",left="+xpos+",top="+ypos;
			var title = "Print";		
	}
	else
	{		
		var purl = appUrl+"action/comstresscashflowprint.jsp?hidBeanGetMethod=GetCashFlowData&hidBeanId=comformula&flowtype=FU&appno="+appno;
		prop = "scrollbars=yes,width=700,height=550,statusbar=yes";	
			xpos = (screen.width - 700) / 2;
			ypos = (screen.height - 550) / 2;
			prop = prop + ",left="+xpos+",top="+ypos;
			var title = "Print";
	}
			window.open(purl,title,prop);
}
</script>
</head>
<body onload="onloading()">
<form name="frm" method="post" >
  <table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr> 
			<td valign="middle" colSpan=5 align="center"> 
              <FONT SIZE="4" face="Tahoma" COLOR="">  Fund Flow</FONT>
            </td>
          </tr>
        </table>

        <span style="visibility:hidden;position:absolute"><lapschoice:borrowertype /></span><div id="top"> <lapschoice:application/>   </div>
      <table width="100%" border="0" cellspacing="0" cellpadding="5" >
        <tr> 
          <td > 
            <table width="100%" border="0" cellspacing="0" cellpadding="3">
              <tr> 
                <td><div id="top">
                  <table border="0" cellspacing="1" cellpadding="3" width="100%">
                    <tr > 
                      <%
		if( totalsize >0)
		{
		%>
                      <td width="40%" align="center"><b>Particulars</b></td>
                      <td width="15%" align="center" valign="bottom"><b>&nbsp;<%=strCurrYear[0]%> 
                        </b></td>
                      <td width="15%" align="center" valign="bottom"><b>&nbsp;<%=strCurrYear[1]%> 
                        </b></td>
                      <td width="15%" align="center" valign="bottom"><b>&nbsp;<%=strCurrYear[2]%> 
                        </b></td>
                      <td width="15%" align="center" valign="bottom"><b>&nbsp;<%=strCurrYear[3]%></b></td>
                    </tr>
                    <tr> 
                      <td width="40%" align="center">&nbsp;</td>
                      <td align="center" valign="bottom" width="15%">&nbsp;<%=strCurrFinancialType[0]%></td>
                      <td align="center" valign="bottom" width="15%">&nbsp;<%=strCurrFinancialType[1]%> 
                        </td>
                      <td align="center" valign="bottom" width="15%">&nbsp;<%=strCurrFinancialType[2]%> 
                        </td>
                      <td align="center" valign="bottom" width="15%">&nbsp;<%=strCurrFinancialType[3]%> 
                        </td>
                    </tr>
                    <%
		}
		else
		{
		%>
                    <%
		}
		%>
                    <%
		if(hshValues.size()>0 && hshValues != null && totalsize >0)
		{
		 for(int i=0;i<totalsize;i++)
			{
			  if( hshValues.get("RowType"+Integer.toString(i+1)).equals("HE"))
				{
		%>
                    <tr > 
                      <td width="40%"><b><%=hshValues.get("Label"+Integer.toString(i+1))%></b> 
                        </td>
                      <td height="5" valign="bottom" align="center" width="15%">&nbsp;</td>
                      <td height="5" valign="bottom" align="center" width="15%">&nbsp;</td>
                      <td height="5" valign="bottom" align="center" width="15%">&nbsp;</td>
                      <td height="5" valign="bottom" align="center" width="15%">&nbsp;</td>
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
                    <tr > 
                      <td width="40%"><%=hshValues.get("Label"+Integer.toString(i+1))%> 
                        </td>
                      <td  width="15%"> 
                        <div align="right" style="width:75"><%=vecData.get(0)%></div>
                      </td>
                      <td  width="15%"> 
                        <div align="right" style="width:75"><%=vecData.get(1)%></div>
                      </td>
                      <td width="15%"> 
                        <div align="right" style="width:75"><%=vecData.get(2)%></div>
                      </td>
                      <td width="15%"> 
                        <div align="right" style="width:75"><%=vecData.get(3)%></div>
                      </td>
                    </tr>
                    <%
				}
			}
		}
		else
		{
		%>
                    <tr> 
                      <td align="center"  bgcolor="" colspan="5">NO 
                        DATA FOUND&nbsp;&nbsp;&nbsp;&nbsp;</td>
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
			 <!-- <td> <font face="MS Sans Serif">
			 <%	
		
				if( totalsize >0)
				{
		
				if (Integer.parseInt((String)hshValues.get("yearfrom")) > 1  )
				{
			%>
				<font size="1">&lt;&lt; <a href="javascript:onPrev()" class="blackfont"><b>Previous</b></a> 
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
				&gt;&gt; 
             <%
				}
				}
			 %>
            </td> -->

                
              </tr>
            </table>
          </td>
        </tr>
      </table>      
    </div>   
<input type="hidden" name="yearfrom" value="<%=hshValues.get("yearfrom")%>">
<input type="hidden" name="flowtype" value="FU">
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="totvalue" value="">
<input type="hidden" name="uptovalue" value="">
<input type="hidden" name="fromvalue" value="">
<input TYPE="hidden" value = "10" name="hidTotal">
<input TYPE="hidden" value = "" name="identity">
<input type="hidden" name="access" value ="B">
<input type="hidden" name="cmdsave" disabled>
</form>
</body>
</html>
