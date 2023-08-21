<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>

<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%
int modulesize=0,secsize=0,paramsize=0;
ArrayList vecModule = new ArrayList();
ArrayList vecModList = new ArrayList();
vecModule = (ArrayList)hshValues.get("module");
vecModList = (ArrayList)hshValues.get("modulelist");
ArrayList vecWCModList = (ArrayList)hshValues.get("wcmodulelist");
ArrayList vecTFModList = (ArrayList)hshValues.get("tfmodulelist");
String strSSIType  =Helper.correctNull((String)request.getParameter("hidSSIType"));
String strCategoryType =Helper.correctNull((String)request.getParameter("hidCategoryType"));
 // out.println("hshvalues===>"+hshValues);
String strDiffWt=Helper.correctNull((String)hshValues.get("wtdiff"));
String strLoanType1=Helper.correctNull((String)hshValues.get("strLoanType"));
 
%>

<html>
<head>
<title>Credit Rating Model</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
a:hover {  color: #FF6600}
-->
</style>
<script>
var appUrl="<%=ApplicationParams.getAppUrl()%>";

function menuOptionDivMouseDown (url)
		{
		
			if(!document.forms[0].cmdApply.disabled)
			{
				ShowAlert(103);
				return;
			}
			document.currentMenu.style.display='none';
			document.currentMBarOpt.style.border='1px solid lightgrey';
			document.menuIsActive = false;
			document.forms[0].action=url;
			document.forms[0].submit();
					
		}

 
function doClose()
{
	document.forms[0].action =appUrl+"action/comproposalsearch.jsp";
	document.forms[0].submit();
}

function callLink12(page,method)
{	
	
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].action=appUrl+"action/"+page+"?pageval=RA";
	document.forms[0].submit();	 
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
function ratingmodel()
{
	document.forms[0].hidBeanId.value="comratingana";
	document.forms[0].hidBeanGetMethod.value = "getRatingModel";
	document.forms[0].action=appUrl+"action/comratingmodel.jsp";
	document.forms[0].method="post";
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
function fincomments()
{
	document.forms[0].hidBeanId.value="qisanalysisresult";
	document.forms[0].hidBeanGetMethod.value ="getDataList";
	document.forms[0].action=appUrl+"action/qis_analysis_result.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}
function printreport()
{
	appno = document.forms[0].appno.value;
	yearfrom=document.forms[0].yearfrom.value;
	pageval="<%=request.getParameter("pageval")%>";


	if(document.forms[0].identity.value == "")
	{
		var purl = appUrl+"action/comratingmodelprint.jsp?hidBeanGetMethod=getRatingModel&hidBeanId=comratingana&appno="+appno;
			prop = "scrollbars=yes,width=700,height=450,statusbar=yes,menubar=yes";	
			xpos = (screen.width - 700) / 2;
			ypos = (screen.height - 650) / 2;
			prop = prop + ",left="+xpos+",top="+ypos;
			var title = "Print";
			
			
		
		
	}
	else
	{
		
		var purl = appUrl+"action/comratingmodelprint.jsp?hidBeanGetMethod=getRatingModel&hidBeanId=comratingana&appno="+appno;
		prop = "scrollbars=yes,width=700,height=550,statusbar=yes";	
			xpos = (screen.width - 700) / 2;
			ypos = (screen.height - 550) / 2;
			prop = prop + ",left="+xpos+",top="+ypos;
			var title = "Print";
			
		
	}

	
		
			window.open(purl,title,prop);


}
</script>
<style>
DIV.cellContainer {	
  width: 100%; height: 375;
  overflow: auto;}
.fontcolor {  font-family: "MS Sans Serif"; font-size: 10px; color: #000000; text-decoration: none}
</style>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >
<jsp:include page="../share/help.jsp" flush="true"/> 
<form name="ratingmodel" method="post" >
  <table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr> 
			<td valign="middle" colSpan=5 align="center"> 
          <FONT SIZE="4" COLOR="" face="MS Sans Serif">   Rating Model</FONT>
            </td>

          </tr>
		  
        </table>
  <br>
        <span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application/>
  <table width="100%" border="1" cellspacing="0" cellpadding="3" height="380" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
    <tr> 
      <td valign="top" bgcolor="#FFFFFF"> 
        <table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF" height="100%" bgcolor="#FFFFFF">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center">
                      <tr align="center"> 
                        <td height="20" colspan="3"><b><font size="1" face="MS Sans Serif"  >Rating 
                          Model : <%=Helper.correctNull((String)hshValues.get("ratingdesc"))%> 
                          </font></b></td>
                      </tr>
                      <tr> 
                        <td   align="left" width="6%">&nbsp;</td>
                        <td   align="left" colspan="2"> 
                          <table width="100%" cellpadding="3" cellspacing="0">
                            <tr align="center" bgcolor="#CCCCCC"> 
                              <td width="10%"><b><font size="1" face="MS Sans Serif" color="#000000">S.No</font></b></td>
                              <td width="34%"><b><font size="1" face="MS Sans Serif" color="#000000">Parameter</font></b></td>
                              <td width="10%"><b><font size="1" face="MS Sans Serif" color="#000000"> 
                                C/R</font></b></td>
                              <td width="18%"><b><font size="1" face="MS Sans Serif" color="#000000"> 
                                Particulars</font></b></td>
                              <td width="10%"><font color="#000000"><b><font size="1" face="MS Sans Serif">Score</font></b> 
                                </font>
                          </table>
                        </td>
                      </tr>
                      <%
	if(vecModule!=null)
	{
		modulesize = vecModule.size();
	}
	for(int i=0;i<modulesize;i++)
	{
		ArrayList vecVal = (ArrayList)vecModule.get(i);
		String strIsDiffWt ="";
		ArrayList vecWC = new ArrayList();
		ArrayList vecTF = new ArrayList();
		
		if(vecVal!=null)
		{
//			String modscore = (String)vecVal.get(1);
			ArrayList vecSec = (ArrayList)vecVal.get(2);
			strIsDiffWt = Helper.correctNull((String)vecVal.get(3));
			 vecWC = (ArrayList)vecVal.get(4);
			 vecTF = (ArrayList)vecVal.get(5);
			 if(strIsDiffWt.trim().equalsIgnoreCase("Y"))
			{
%>
                      <tr bgcolor="#F3F3F3"> 
                        <td   align="left" colspan="2" bgcolor="#F3F3F3"><font size="1" color="#FFFFFF"><b><font face="MS Sans Serif" color="#000000"> 
                          Module : </font></b><font face="MS Sans Serif" color="#000000"><%=Helper.correctNull((String)vecVal.get(0))%> 
                          </font></font></td>
                        <td   align="left" width="11%"><font size="1" color="#FFFFFF"></font></td>
                      </tr>
                      <tr bgcolor="#FFFFFF"> 
                        <td   align="left" colspan="2"><b><font size="1" face="MS Sans Serif"  > 
                          </font></b><font size="1" face="MS Sans Serif"  >For 
                          Working Capital</font></td>
                        <td   align="right" width="11%"><font size="1" face="MS Sans Serif"><%=(String)vecVal.get(1)%></font></td>
                      </tr>
                      <tr bgcolor="#FFFFFF"> 
                        <td   align="left" colspan="2"><b><font size="1" face="MS Sans Serif"  > 
                          </font></b><font size="1" face="MS Sans Serif"  >For 
                          Term Loan</font></td>
                        <td   align="right" width="11%"><font size="1" face="MS Sans Serif"><%=(String)vecVal.get(6)%></font></td>
                      </tr>
                      <%			}
else
			{
%>
                      <tr bgcolor="#FFFFFF"> 
                        <td   align="left" colspan="2"><font color="#FFFFFF"><b><font size="1" face="MS Sans Serif"  > 
                          Module : </font></b><font size="1" face="MS Sans Serif"  ><%=Helper.correctNull((String)vecVal.get(0))%></font></font></td>
                        <td   align="right" width="11%"><font color="#FFFFFF" size="1" face="MS Sans Serif"><b><%=(String)vecVal.get(1)%></b></font></td>
                      </tr>
                      <%}
		if(vecSec!=null)
			{
				secsize = vecSec.size();
			}
					String wtdiff="",wcmaxcomp="",wcmaxrel="",tfmaxcomp="",tfmaxrel="";	

			for(int j=0;j<secsize;j++)
			{
				ArrayList vecVal1 = (ArrayList)vecSec.get(j);

				if(vecVal1!=null)
				{
//out.println("wt ="+(String)vecVal1.get(5));
   					   	wtdiff	= Helper.correctNull((String)vecVal1.get(5));
						if(wtdiff.trim().equalsIgnoreCase("Y"))
					    {
							wcmaxcomp	= Helper.correctNull((String)vecVal1.get(6));
							wcmaxrel	= Helper.correctNull((String)vecVal1.get(7));
							tfmaxcomp	= Helper.correctNull((String)vecVal1.get(8));
							tfmaxrel	= Helper.correctNull((String)vecVal1.get(9));
					    }
						else
					   {
							wcmaxcomp	= Helper.correctNull((String)vecVal1.get(6));
							wcmaxrel	= Helper.correctNull((String)vecVal1.get(7));
					   }

					ArrayList vecParam = (ArrayList)vecVal1.get(3);

%>
                      <tr> 
                        <td width="6%" height="10"   align="left">&nbsp; </td>
                        <td height="10"   align="left" colspan="2"><font size="1" face="MS Sans Serif"  > 
                          </font> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="3">
                            <tr> 
                              <td width="40%" bgcolor="#F3F3F3"><font size="1" face="MS Sans Serif"><b>Section 
                                :</b> <%=Helper.correctNull((String)vecVal1.get(1))%></font></td>
                              <td width="37%" bgcolor="#F3F3F3">&nbsp;</td>
                              <td width="10%" align="right" bgcolor="#F3F3F3"><font size="1" face="MS Sans Serif"><%=Helper.checkDecimal((String)vecVal1.get(2))%></font></td>
                            </tr>
                            <tr> 
                              <td width="40%"><font size="1" face="MS Sans Serif"><b> 
                                <%   						if(wtdiff.trim().equalsIgnoreCase("Y"))
					    {
%>
                                Working Capital 
                                <%}%>
                                </b>(Compulsory :<%=wcmaxcomp%>&nbsp;&nbsp;&nbsp;Relevant 
                                :<%=wcmaxrel%>)</font></td>
                              <%   						if(wtdiff.trim().equalsIgnoreCase("Y"))
					    {
%>
                              <td width="37%"><font size="1" face="MS Sans Serif"><b>Term 
                                Loan </b>(Compulsory :<%=tfmaxcomp%>&nbsp;&nbsp;&nbsp;Relevant 
                                :<%=tfmaxrel%>)</font></td>
                              <%}%>
                              <td width="10%" align="right">&nbsp;</td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr> 
                        <td   align="center" valign="top" width="6%">&nbsp; </td>
                        <td height="10"   align="left" colspan="2"> 
                          <table width="100%" cellpadding="3" cellspacing="1">
                            <%								
					if(vecParam!=null)
					{	paramsize = vecParam.size();
						for(int k=0;k<paramsize;k++)
						{
							ArrayList vecVal2 = (ArrayList)vecParam.get(k);
%>
                            <tr bgcolor="#FFFFFF"> 
                              <td width="10%" align="center"><font size="1" face="MS Sans Serif"><%=k+1%>.</font></td>
                              <td width="34%"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)vecVal2.get(0))%></font></td>
                              <td width="10%" align="center"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)vecVal2.get(1))%></font></td>
                              <!--							  <td width="18%" bgcolor="#F5F3EF"><font size="1" face="MS Sans Serif"><%//=Helper.correctNull((String)vecVal2.get(2))%></font></td>
    -->
                              <td width="18%" align="center"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)vecVal2.get(4))%></font></td>
                              <td width="10%" align="right"><font size="1" face="MS Sans Serif"><%=Helper.checkDecimal((String)vecVal2.get(3))%></font></td>
                            </tr>
                            <% 					ArrayList vecSubParam = (ArrayList)vecVal2.get(5);
					int subparamsize=0;
					if(vecSubParam!=null)
					{	subparamsize = vecSubParam.size();
						for(int m=0;m<subparamsize;m++)
						{
							ArrayList vecVal3 = (ArrayList)vecSubParam.get(m);
//out.println("subparamsize="+subparamsize+"m ="+m +":vecVal3="+vecVal3);
%>
                            <tr bgcolor="#F3F3F3"> 
                              <td align="right">&nbsp;</td>
                              <td width="34%" bgcolor="#F3F3F3"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)vecVal3.get(0))%></font> 
                              </td>
                              <td width="10%">&nbsp;</td>
                              <td align="center" width="18%"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)vecVal3.get(3))%></font></td>
                              <td align="right" width="10%"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)vecVal3.get(2))%></font></td>
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
                      <%	
				}
			}

		}
		if(strIsDiffWt.trim().equals("Y"))
		{
%>
                      <tr> 
                        <td   align="center" valign="top" width="6%">&nbsp;</td>
                        <td height="10"   align="left" colspan="2"><font size="1" face="MS Sans Serif"><b>Weights 
                          of <%=Helper.correctNull((String)vecVal.get(0))%> 
                          for Working Capital</b></font></td>
                      </tr>
                      <tr> 
                        <td   align="center" valign="top" width="6%">&nbsp;</td>
                        <td height="10"   align="left" colspan="2"> 
                          <table width="80%" border="1" cellspacing="0" cellpadding="2" align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
                            <tr> 
                              <td> 
                                <table width="100%" border="0" cellspacing="1" cellpadding="2">
                                  <tr bgcolor="#CCCCCC" align="center"> 
                                    <td width="32%"><b><font size="1" face="MS Sans Serif" color="#000000">Section</font></b></td>
                                    <td width="20%"><b><font size="1" face="MS Sans Serif" color="#000000">Marks 
                                      Obtained </font></b></td>
                                    <td width="18%"><b><font size="1" face="MS Sans Serif" color="#000000">Max. 
                                      Marks </font></b></td>
                                    <td width="14%"><b><font size="1" face="MS Sans Serif" color="#000000">Weights</font></b></td>
                                    <td width="16%"><b><font size="1" face="MS Sans Serif" color="#000000"> 
                                      Score </font></b></td>
                                  </tr>
                                  <% int vecWCsize=0,vecTFsize=0;
if(vecWC!=null)
{
	vecWCsize= vecWC.size();
}
if(vecTF!=null)
{
	vecTFsize= vecTF.size();
}
							for (int n=0;n<vecWCsize;n++)
							{
								ArrayList vecWCval = (ArrayList)vecWC.get(n);
								if(vecWCval!=null)
								{
							%>
                                  <tr bgcolor="#FFFFFF"> 
                                    <td width="32%"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)vecWCval.get(0))%></font></td>
                                    <td width="20%" align="right"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)vecWCval.get(1))%></font></td>
                                    <td width="18%" align="right"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)vecWCval.get(2))%></font></td>
                                    <td width="14%" align="right"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)vecWCval.get(3))%></font></td>
                                    <td width="16%" align="right"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)vecWCval.get(4))%></font></td>
                                  </tr>
                                  <%}}
								%>
                                </table>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr> 
                        <td   align="center" valign="top" width="6%">&nbsp;</td>
                        <td height="10"   align="left" colspan="2"><font size="1" face="MS Sans Serif"><b>Weights 
                          of <%=Helper.correctNull((String)vecVal.get(0))%> 
                          for Term Loan</b></font></td>
                      </tr>
                      <tr> 
                        <td   align="center" valign="top" width="6%">&nbsp;</td>
                        <td height="10"   align="left" colspan="2"> 
                          <table width="80%" border="1" cellspacing="0" cellpadding="2" align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
                            <tr> 
                              <td> 
                                <table width="100%" border="0" cellspacing="1" cellpadding="2">
                                  <tr bgcolor="#CCCCCC" align="center"> 
                                    <td width="32%"><b><font size="1" face="MS Sans Serif" color="#000000">Section</font></b></td>
                                    <td width="20%"><b><font size="1" face="MS Sans Serif" color="#000000">Marks 
                                      Obtained </font></b></td>
                                    <td width="18%"><b><font size="1" face="MS Sans Serif" color="#000000">Max. 
                                      Marks </font></b></td>
                                    <td width="14%"><b><font size="1" face="MS Sans Serif" color="#000000">Weights</font></b></td>
                                    <td width="16%"><b><font size="1" face="MS Sans Serif" color="#000000"> 
                                      Score </font></b></td>
                                  </tr>
                                  <%     for (int p=0;p<vecTFsize;p++)
							{
								ArrayList vecTFval = (ArrayList)vecTF.get(p);
								if(vecTFval!=null)
								{
							%>
                                  <tr bgcolor="#FFFFFF"> 
                                    <td width="32%"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)vecTFval.get(0))%></font></td>
                                    <td width="20%" align="right"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)vecTFval.get(1))%></font></td>
                                    <td width="18%" align="right"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)vecTFval.get(2))%></font></td>
                                    <td width="14%" align="right"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)vecTFval.get(3))%></font></td>
                                    <td width="16%" align="right"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)vecTFval.get(4))%></font></td>
                                  </tr>
                                  <%}}
								%>
                                </table>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr> 
                        <td   align="center" valign="top" width="6%">&nbsp;</td>
                        <td height="10"   align="left" colspan="2"><font size="1" face="MS Sans Serif">&nbsp;</font></td>
                      </tr>
                      <tr> 
                        <td   align="center" valign="top" width="6%">&nbsp;</td>
                        <td height="10"   align="left" colspan="2"> 
                          <table width="100%" border="1" cellspacing="0" cellpadding="2" align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
                            <tr> 
                              <td> 
                                <table width="100%" border="0" cellspacing="1" cellpadding="2">
                                  <tr bgcolor="#CCCCCC" align="center"> 
                                    <td width="20%"><b><font size="1" face="MS Sans Serif" color="#000000">Marks 
                                      Obtained </font></b></td>
                                    <td width="32%"><b><font size="1" face="MS Sans Serif" color="#000000">Multiplication 
                                      Factor </font></b></td>
                                    <td width="48%"><b><font size="1" face="MS Sans Serif" color="#000000"> 
                                      Net Marks for Term Loan</font></b></td>
                                  </tr>
                                  <tr bgcolor="#FFFFFF"> 
                                    <td width="20%" align="center"><font size="1" face="MS Sans Serif" > 
                                      <%=(String)vecVal.get(6)%></font></td>
                                    <td width="32%">&nbsp;</td>
                                    <td width="48%">&nbsp;</td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                          </table>
                        </td>
                        <%}%>
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
          <tr> 
            <td valign="top"> 
              <table width="75%" border="1" cellspacing="0" cellpadding="5" align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
	<%
	if(!strDiffWt.trim().equalsIgnoreCase("Y"))
	{
	%>
                  <td> 
                    <table width="100%" border="0" cellspacing="1" cellpadding="3" align="center">
                      <tr bgcolor="#CCCCCC" align="center"> 
                        <td width="32%"><b><font size="1" face="MS Sans Serif" color="#000000">Module</font></b></td>
                        <td width="20%"><b><font size="1" face="MS Sans Serif" color="#000000">Marks 
                          Obtained </font></b></td>
                        <td width="18%"><b><font size="1" face="MS Sans Serif" color="#000000">Max. 
                          Marks </font></b></td>
                        <td width="14%"><b><font size="1" face="MS Sans Serif" color="#000000">Weights</font></b></td>
                        <td width="16%"><b><font size="1" face="MS Sans Serif" color="#000000">Net 
                          Score </font></b></td>
                      </tr>
                      <tr bgcolor="#F5F3EF" align="center"> 
                        <td width="32%" bgcolor="#F5F3EF"><font size="1" face="MS Sans Serif"></font></td>
                        <td width="20%" bgcolor="#F5F3EF"><font size="1" face="MS Sans Serif">(A)</font></td>
                        <td width="18%"><font size="1" face="MS Sans Serif">(B)</font></td>
                        <td width="14%"><font size="1" face="MS Sans Serif">(C)</font></td>
                        <td width="16%"><font size="1" face="MS Sans Serif">D=(A/B) 
                          x C</font></td>
                      </tr>
                      <% int modlistsize=0;
if(vecModList!=null)
	{
		modlistsize = vecModList.size();
	}
 	for(int i=0;i<modlistsize;i++)
	{
		ArrayList vecList = (ArrayList)vecModList.get(i);
 		if(vecList!=null)
		{

%>
                      <tr bgcolor="#F5F3EF" align="center"> 
                        <td width="32%"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)vecList.get(0))%></font></td>
                        <td width="20%" bgcolor="#F5F3EF" align="right"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)vecList.get(1))%></font></td>
                        <td width="18%" align="right"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)vecList.get(2))%></font></td>
                        <td width="14%" align="right"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)vecList.get(3))%></font></td>
                        <td width="16%" align="right"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)vecList.get(4))%></font></td>
                      </tr>
                      <%
		}
	}


	%>
                      <tr bgcolor="#FFFFFF" align="center"> 
                        <td width="32%"><font size="1" face="MS Sans Serif">Total</font></td>
                        <td width="20%">&nbsp;</td>
                        <td width="18%"><font size="1" face="MS Sans Serif"></font></td>
                        <td width="14%" align="right"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)hshValues.get("ratingwt"))%></font></td>
                        <td width="16%" align="right"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)hshValues.get("ratingscore"))%></font></td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
<%}%>
    
	
	
	   <br>
        <table width="75%" border="1" cellspacing="0" cellpadding="3"  height="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center" >
          <%
		if(strDiffWt.trim().equals("Y"))
		{
int wcmodlistsize=0,tfmodlistsize=0;
%>
          <tr>
                  
            <td><font size="1" face="MS Sans Serif"><b>For Working Capital</b></font></td>
                </tr>
				<tr> 
                  <td> 
                    
              <table width="100%" border="0" cellspacing="1" cellpadding="3" align="center">
                <tr bgcolor="#CCCCCC" align="center"> 
                  <td width="32%"><b><font size="1" face="MS Sans Serif" color="#000000">Module</font></b></td>
                  <td width="20%"><b><font size="1" face="MS Sans Serif" color="#000000">Marks 
                    Obtained </font></b></td>
                  <td width="18%"><b><font size="1" face="MS Sans Serif" color="#000000">Max. 
                    Marks </font></b></td>
                  <td width="14%"><b><font size="1" face="MS Sans Serif" color="#000000">Weights</font></b></td>
                  <td width="16%"><b><font size="1" face="MS Sans Serif" color="#000000">Net 
                    Score </font></b></td>
                </tr>
                <tr bgcolor="#FFFFFF" align="center"> 
                  <td width="32%"><font size="1" face="MS Sans Serif"></font></td>
                  <td width="20%"><font size="1" face="MS Sans Serif">(A)</font></td>
                  <td width="18%"><font size="1" face="MS Sans Serif">(B)</font></td>
                  <td width="14%"><font size="1" face="MS Sans Serif">(C)</font></td>
                  <td width="16%"><font size="1" face="MS Sans Serif">D=(A/B) 
                    x C</font></td>
                </tr>
                <%  
if(vecWCModList!=null)
	{
		wcmodlistsize = vecWCModList.size();
	}
 	for(int i=0;i<wcmodlistsize;i++)
	{
		ArrayList vecList = (ArrayList)vecWCModList.get(i);
//out.println("wc=="+vecList);
 		if(vecList!=null)
		{

%>
                <tr bgcolor="#FFFFFF" align="center"> 
                  <td width="32%"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)vecList.get(0))%></font></td>
                  <td width="20%" align="right"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)vecList.get(1))%></font></td>
                  <td width="18%" align="right"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)vecList.get(2))%></font></td>
                  <td width="14%" align="right"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)vecList.get(3))%></font></td>
                  <td width="16%" align="right"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)vecList.get(4))%></font></td>
                </tr>
                <%
		}
	}


	%>
                <tr bgcolor="#F3F3F3" align="center"> 
                  <td width="32%"><font size="1" face="MS Sans Serif">Total</font></td>
                  <td width="20%">&nbsp;</td>
                  <td width="18%"><font size="1" face="MS Sans Serif"></font></td>
                  <td width="14%" align="right"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)hshValues.get("ratingwcwt"))%></font></td>
                  <td width="16%" align="right"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)hshValues.get("ratingwcscore"))%></font></td>
                </tr>
              </table>
                  </td>
                </tr>
              </table>
<%//}%>
<%
if( strLoanType1.trim().equalsIgnoreCase("both") || strLoanType1.trim().equalsIgnoreCase("TF")) 
						{

  %>
              <table width="75%" border="1" cellspacing="0" cellpadding="5" align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
                <tr>
                  <td><font size="1" face="MS Sans Serif"><b>For Term Loan</b></font></td>
                </tr>
                <tr> 
                  
            <td> 
              <table width="100%" border="0" cellspacing="1" cellpadding="2">
                <tr bgcolor="#CCCCCC" align="center"> 
                  <td width="32%"><b><font size="1" face="MS Sans Serif" color="#000000">Module</font></b></td>
                  <td width="20%"><b><font size="1" face="MS Sans Serif" color="#000000">Marks 
                    Obtained </font></b></td>
                  <td width="18%"><b><font size="1" face="MS Sans Serif" color="#000000">Max. 
                    Marks </font></b></td>
                  <td width="14%"><b><font size="1" face="MS Sans Serif" color="#000000">Weights</font></b></td>
                  <td width="16%"><b><font size="1" face="MS Sans Serif" color="#000000"> 
                    Score </font></b></td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                  <td width="32%">&nbsp;</td>
                  <td width="20%" align="center"><font size="1" face="MS Sans Serif">(A)</font></td>
                  <td width="18%" align="center"><font size="1" face="MS Sans Serif">(B)</font></td>
                  <td width="14%" align="center"><font size="1" face="MS Sans Serif">(C)</font></td>
                  <td width="16%" align="center"><font size="1" face="MS Sans Serif">D=(A/B) 
                    x C</font></td>
                </tr>
                <% 
if(vecTFModList!=null)
	{
		tfmodlistsize = vecTFModList.size();
	}
 	for(int i=0;i<tfmodlistsize;i++)
	{
		ArrayList vecList = (ArrayList)vecTFModList.get(i);
 		if(vecList!=null)
		{

%>
                <tr bgcolor="#FFFFFF" align="center"> 
                  <td width="32%"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)vecList.get(0))%></font></td>
                  <td width="20%" align="right"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)vecList.get(1))%></font></td>
                  <td width="18%" align="right"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)vecList.get(2))%></font></td>
                  <td width="14%" align="right"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)vecList.get(3))%></font></td>
                  <td width="16%" align="right"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)vecList.get(4))%></font></td>
                </tr>
                <%
		}
	}


	%>
                <tr bgcolor="#FFFFFF" align="center"> 
                  <td width="32%"><font size="1" face="MS Sans Serif">Total</font></td>
                  <td width="20%">&nbsp;</td>
                  <td width="18%"><font size="1" face="MS Sans Serif"></font></td>
                  <td width="14%" align="right"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)hshValues.get("ratingtfwt"))%></font></td>
                  <td width="16%" align="right"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)hshValues.get("ratingtfscore"))%></font></td>
                </tr>
              </table>
            </td>
                </tr>
              </table>
       <%
         }
       %>
               
                  
  <%
     }
  %>
	       
  <br>
              
        <table width="75%" border="1" cellspacing="0" cellpadding="3" align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
          <%
//out.println("strDiffWt=="+strDiffWt);
		if(strDiffWt.trim().equals("Y"))
		{

%>
          <tr>
                  
      <td bgcolor="#CCCCCC" colspan="6"><font size="1" face="MS Sans Serif"><b>Grading For 
        Working Capital</b></font></td>
                </tr>
<%}%>
               <!-- <tr> 
                  <td bgcolor="#F5F3EF"> 
                    
        <table width="100%" border="0" cellspacing="1" cellpadding="3">-->
          <tr bgcolor="#F3F3F3"> 
            <td width="15%"><font size="2" face="MS Sans Serif">Nature of Grade</font></td>
                        
            <td width="4%"><font size="2" face="MS Sans Serif"><b><%=Helper.correctNull((String)hshValues.get("rating"))%></b></font></td>
                        
            <td width="22%"><font size="2" face="MS Sans Serif">Scores relating 
              to Grade</font></td>
                        
            <td width="9%"><font size="2" face="MS Sans Serif"><b><%=Helper.correctNull((String)hshValues.get("ratingrange"))%></b></font></td>
                        
            <td width="19%"><font size="2" face="MS Sans Serif">Definition fo 
              the grade</font></td>
                        
            <td width="31%"><font size="2" face="MS Sans Serif"><b><%=Helper.correctNull((String)hshValues.get("ratingremarks"))%></b></font></td>
                      </tr>
                   <!-- </table>
                  </td>
                </tr>-->
              </table>  
<%
		if(strDiffWt.trim().equals("Y"))
		{

%>
             <% 
					  String strLoanType2=Helper.correctNull((String)hshValues.get("strLoanType"));
			  //out.println("d;ofkjdkjfsdlk;jfsdjflk; jl;ksjdflksdjf lkjlkj ========="+strLoanType2);
					  if( strLoanType2.trim().equalsIgnoreCase("both") || strLoanType2.trim().equalsIgnoreCase("TF")) 
						{

			%>  
        <table width="75%" border="1" cellspacing="0" cellpadding="3" align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
          <tr>
                  
      <td bgcolor="#CCCCCC" colspan="6"><font size="1" face="MS Sans Serif"><b>Grading For 
        Term Loan</b></font></td>
                </tr>
               <!-- <tr> 
                  <td bgcolor="#F5F3EF"> 
                    
        <table width="100%" border="0" cellspacing="1" cellpadding="3">-->
          <tr bgcolor="#F3F3F3"> 
            <td width="15%"><font size="2" face="MS Sans Serif">Nature of Grade</font></td>
                        
            <td width="4%"><font size="2" face="MS Sans Serif"><b><%=Helper.correctNull((String)hshValues.get("tfrating"))%></b></font></td>
                        
            <td width="22%"><font size="2" face="MS Sans Serif">Scores relating 
              to Grade</font></td>
                        
            <td width="9%"><font size="2" face="MS Sans Serif"><b><%=Helper.correctNull((String)hshValues.get("tfratingrange"))%></b></font></td>
                        
            <td width="19%"><font size="2" face="MS Sans Serif">Definition fo 
              the grade</font></td>
                        
            <td width="31%"><font size="2" face="MS Sans Serif"><b><%=Helper.correctNull((String)hshValues.get("tfratingremarks"))%></b></font></td>
                      </tr>
                  <!--  </table>
                  </td>
                </tr>-->
              </table>
           
<%}%>
<%
	}
%>
  <table width="12%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"  align="center">
    <tr> 
      <td>&nbsp;<input type="button" name="cmdClose" value="Close" onClick="self.close()"></td>
    </tr>
  </table>
  <INPUT TYPE="hidden" name="hidBeanGetMethod">
  <input type="hidden" name="hidBeanId" value="comratingana">

  

<input type="hidden" name="cmdapply" disabled>
<input type="hidden" name="access" value ="B">

<!-- for cashflow-->
<input type="hidden" name="flowtype" value="CA">
<input type="hidden" name="yearfrom" value="1">
<!-- -->
</form>
</body>
</html>
