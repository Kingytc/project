 <%@ page import="com.sai.laps.helper.*,java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<% request.setAttribute("_cache_refresh", "true"); %>
<laps:handleerror />
<%
	//out.println(hshValues);
ArrayList  vecid=new ArrayList();
 ArrayList  vecdesc=new ArrayList();
 ArrayList  vectype=new ArrayList();
 ArrayList  vecCuryear=new ArrayList();
 ArrayList  vecCuryearHold=new ArrayList();
 ArrayList  vecPreyear=new ArrayList();
 ArrayList  vecPreyearHold=new ArrayList();
 ArrayList  vecNextyear=new ArrayList();
 ArrayList  vecNextyearHold=new ArrayList();

 if (hshValues!=null)
{
  vecid=(ArrayList)hshValues.get("vecid");
 
  vecdesc = (ArrayList)hshValues.get("vecdesc");
  vectype=(ArrayList)hshValues.get("vectype");
  vecCuryear = (ArrayList)hshValues.get("year");
  vecCuryearHold  = (ArrayList)hshValues.get("yearhold");
  vecPreyear = (ArrayList)hshValues.get("prevyear");
  vecPreyearHold = (ArrayList)hshValues.get("prevyearhold");
  vecNextyear = (ArrayList)hshValues.get("nextyear");
  vecNextyearHold = (ArrayList)hshValues.get("nextyearhold");
}
 String strDesc =request.getParameter("pageval");
 String strSSIType  =Helper.correctNull((String)request.getParameter("hidSSIType"));
	String strCategoryType =Helper.correctNull((String)request.getParameter("hidCategoryType"));

	
	
	 int p=0,sizeyear=0,from=0,to=0,vecModSize  =0,vecsize=0;
   String temp="",totcount="",upto="",pageval="",strCurModule="",strvecid="",strvecid1="",strvecid2="",strvecid3="",strvecid4="";
   String strid="";
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

if (yearval!=null)
{
 curYear= Helper.correctNull((String)yearval.get(0));
 curYearDesc= Helper.correctNull((String)yearval.get(1));
 pervYear= Helper.correctNull((String)yearval.get(2));
 prevYearDesc= Helper.correctNull((String)yearval.get(3));
 nextYear= Helper.correctNull((String)yearval.get(4));
 nextYearDesc= Helper.correctNull((String)yearval.get(5));
}
 //out.println(yearval);
 String a="",b="",c="";
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
  if(nextYearDesc.trim().equals(""))
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
%>
<html>
<head>
<title>Financial</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
textarea {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}

-->
</style>
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 250;
  overflow: auto;
}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
.tabfont {  font-family: "MS Sans Serif"; font-size: 10px; color: #000000; text-decoration: none}
a:hover {  color: #FF3300}
</STYLE>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/com/finmain.js">
</script>
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

 function callApplicantTab(page)
  { 
   	
	
	  if(page=="company")
	  { 
		  document.forms[0].hidBeanGetMethod.value="getData";
		  document.forms[0].action=appUrl+"action/comcompany.jsp";
	  }
	  if(page=="proposal")
	  {
		  document.forms[0].hidBeanGetMethod.value="getProposal";
		  document.forms[0].action=appUrl+"action/comproposal.jsp";
	  }
	 
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

function callTab(str)
{

	document.forms[0].hidBeanId.value="combobassessment";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].action = appUrl+"action/bobassessment.jsp?pageval="+str;
	document.forms[0].submit();

}  

function callAssessment(strAss)
{
	document.forms[0].hidBeanId.value="combobassessment";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].pageval.value=strAss;
	document.forms[0].action = appUrl+"action/bobassessment.jsp";
	document.forms[0].submit();

}
function doClose()
{
	    document.forms[0].action=appUrl+"action/comproposalsearch.jsp";
		document.forms[0].method="post";
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

</script>
</head>
<body>
<form method="post" >
<input type="hidden" name="access">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr> 
			
      <td valign="middle" colSpan=5 height="16" align="center"> 
  <FONT SIZE="4" COLOR="" face="MS Sans Serif">   Assessment Type&nbsp;-&nbsp;<%=request.getParameter("pageval")%></FONT>
            </td>
          </tr>
        </table>
  <br>
          <span style="display:none"><laps:borrowertype /></span> <laps:application/>

  <table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" onMouseOver=" ">
    <tr> 
      <td valign="top" bgcolor="#FFFFFF"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
        
            
          <tr> 
            <td> 
              <table width="100%" border="1" cellspacing="0" cellpadding="5" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF" height="100%">
                <tr> 
                  <td valign="top"> 
                    <table width="100%" border="0" cellspacing="1" cellpadding="5"   height="157" align="left" bordercolor="#FFFFFF" >
                      <tr> 
                        <td width="30%" align="center" height="25" bgcolor="#CCCCCC"><font color="#000000"><b>Particulars</b></font> 
                        </td>
                        <td colspan="2" align="center" height="25" bgcolor="#CCCCCC"><font color="#000000" ><b>Previous 
                          Year </b></font></td>
                        <td colspan="2" align="center" height="25" bgcolor="#CCCCCC"><font color="#000000" ><b>Current 
                          Year </b></font></td>
                        <td colspan="2" align="center" height="25" bgcolor="#CCCCCC"><font color="#000000" ><b>Next 
                          Year </b></font></td>
                      </tr>
                      <tr bgcolor="#BCB7A0"> 
                        <td width="30%" bgcolor="#F3F3F3"><font color="#000000"></font></td>
                        <td colspan="2" align="center" bgcolor="#F3F3F3"><b><font color="#000000"><%=pervYear%>&nbsp;</font></b></td>
                        <td colspan="2" align="center" bgcolor="#F3F3F3"><b><font color="#000000"><%=curYear%>&nbsp;</font></b></td>
                        <td colspan="2" align="center" bgcolor="#F3F3F3"><b><font color="#000000"><%=nextYear%>&nbsp;</font></b></td>
                      </tr>
                      <tr bgcolor="#BCB7A0"> 
                        <td width="30%" bgcolor="#F3F3F3"><font  color="#000000"></font></td>
                        <td colspan="2" align="center" bgcolor="#F3F3F3"><b><font  color="#000000">&nbsp;<%=b%></font></b></td>
                        <td colspan="2" align="center" bgcolor="#F3F3F3"><b><font  color="#000000"><%=a%>&nbsp;</font></b></td>
                        <td colspan="2" align="center" bgcolor="#F3F3F3"><b><font  color="#000000"><%=c%>&nbsp;</font></b></td>
                      </tr>
                      <tr bgcolor="#EEEAE3"> 
                        <td width="30%" bgcolor="#FFFFFF">&nbsp; </td>
                        <td width="13%" align="center" bgcolor="#FFFFFF"><font >Holding 
                          (Months)</font></td>
                        <td width="10%" align="center" bgcolor="#FFFFFF"><font >Amount</font></td>
                        <td width="13%" align="center" bgcolor="#FFFFFF"><font >Holding 
                          (Months) </font></td>
                        <td width="10%" align="center" bgcolor="#FFFFFF"><font >Amount</font></td>
                        <td width="13%" align="center" bgcolor="#FFFFFF"><font >Holding 
                          (Months) </font></td>
                        <td width="10%" align="center" bgcolor="#FFFFFF"><font >Amount</font></td>
                      </tr>
                      <%
				if(vecdesc!=null)
				{
					vecsize = vecdesc.size();
				}
//out.println("vecdesc="+vecdesc);
//out.println("size ="+vecsize);
				for(int i=0;i<vecsize;i++)
				{
					String desc =Helper.correctNull((String)vecdesc.get(i));
					String type =Helper.correctNull((String)vectype.get(i));
					String col1 =Helper.correctNull((String)vecCuryear.get(i));
					String col2 =Helper.correctNull((String)vecCuryearHold.get(i));
					String col3 = Helper.correctNull((String)vecPreyear.get(i));
					String col4 =Helper.correctNull((String)vecPreyearHold.get(i));
					String col5 =Helper.correctNull((String)vecNextyear.get(i));
					String col6 =Helper.correctNull((String)vecNextyearHold.get(i));

					//	To delete row NO 7 in Applicant -Proposal-Assessment-PBF1)Ref.. Issue 27 
				    if (desc.equalsIgnoreCase("Less: Trade Creditors & Other CL excluding bank borrowing for Working Capital")) 
					{
						continue;
					}
			%>
                      <tr bgcolor="#FFFFFF"> 
                        <% if(type.trim().equals("HE")){ %>
                        <td width="30%"><font ><%=desc%></font></td>
                        <td width="13%" align="center"><font >&nbsp;</font></td>
                        <td width="10%" align="right"><font >&nbsp;</font></td>
                        <td width="13%" align="center"><font >&nbsp;</font></td>
                        <td width="10%" align="right"><font >&nbsp;</font></td>
                        <td width="13%" align="center"><font >&nbsp;</font></td>
                        <td width="10%" align="right"><font >&nbsp;</font></td>
                        <% 
					}
				   else
					{
				%>
                        <td width="30%"><font ><%=desc%></font></td>
                        
                        
                          <%
                          if(request.getParameter("pageval").equalsIgnoreCase("MPBF2"))
                          {
							strid=(String)vecid.get(26);
                         
                          if((strid.equals("716"))&&(col4.startsWith("-")))
                                {
                                %>
                                <td width="7%" align="center"><font face="MS Sans Serif" size="1"><%="0.00"%><%//=col1A%>&nbsp;</font></td>
                                <%
                                }
                               
                            else
                            {
                            %>
                            <td width="7%" align="center"><font face="MS Sans Serif" size="1"><%=col4%><%//=col1A%>&nbsp;</font></td>
                            <%
                            }
                         
                          if((strid.equals("716"))&&(col3.startsWith("-")))
                                {
                                %>
                                <td width="7%" align="center"><font face="MS Sans Serif" size="1"><%="0.00"%><%//=col1A%>&nbsp;</font></td>
                                <%
                                }
                               
                            else
                            {
                            %>
                            <td width="10%" > 
                          <div align="right" style="width:75"><font ><%=col3%></font></div>
                        </td>
                            <%
                            }
                          
                          if((strid.equals("716"))&&(col2.startsWith("-")))
                          {
                          %>
                          <td width="7%" align="center"><font face="MS Sans Serif" size="1"><%="0.00"%><%//=col1A%>&nbsp;</font></td>
                          <%
                          }
                         
                    	  else
                    	  {
                      %>
                      <td width="10%" > 
                    <div align="right" style="width:75"><font ><%=col2%></font></div>
                  </td>
                      <%
                      }
                          
                          
                          
                          if((strid.equals("716"))&&(col1.startsWith("-")))
                          {
                          %>
                          <td width="7%" align="center"><font face="MS Sans Serif" size="1"><%="0.00"%><%//=col1A%>&nbsp;</font></td>
                          <%
                          }
                         
                    	  else
                    	  {
                      %>
                      <td width="10%" > 
                    <div align="right" style="width:75"><font ><%=col1%></font></div>
                  </td>
                      <%
                      }   
                          
                          
                          if((strid.equals("716"))&&(col6.startsWith("-")))
                          {
                          %>
                          <td width="7%" align="center"><font face="MS Sans Serif" size="1"><%="0.00"%><%//=col1A%>&nbsp;</font></td>
                          <%
                          }
                         
                    	  else
                    	  {
                      %>
                      <td width="10%" > 
                    <div align="right" style="width:75"><font ><%=col6%></font></div>
                  </td>
                      <%
                      } 
                          
                          
                          
                          if((strid.equals("716"))&&(col5.startsWith("-")))
                          {
                          %>
                          <td width="7%" align="center"><font face="MS Sans Serif" size="1"><%="0.00"%><%//=col1A%>&nbsp;</font></td>
                          <%
                          }
                         
                    	  else
                    	  {
                      %>
                      <td width="10%" > 
                    <div align="right" style="width:75"><font ><%=col5%></font></div>
                  </td>
                      <%
                      } 
                      }
                          else
                          {
                      %>
                      
                         <td width="7%" align="center"><font face="MS Sans Serif" size="1"><%=col4%><%//=col1A%>&nbsp;</font></td>
                      
                       <td width="10%" > 
                          <div align="right" style="width:75"><font ><%=col3%></font></div>
                        </td>
                           
                           <td width="10%" > 
                    <div align="right" style="width:75"><font ><%=col2%></font></div>
                  </td> 
                     <td width="10%" > 
                    <div align="right" style="width:75"><font ><%=col1%></font></div>
                  </td> 
                            
                       <td width="10%" > 
                    <div align="right" style="width:75"><font ><%=col6%></font></div>
                  </td>        
                             <td width="10%" > 
                    <div align="right" style="width:75"><font ><%=col5%></font></div>
                  </td> 
                           <%
                           }
                           %>  
                     
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
  <br>
 
  <input type="hidden" name="hidAction" >
  <input type="hidden" name="hidBeanId">
  <input type="hidden" name="hidBeanMethod" value="">
  <input type="hidden" name="hidBeanGetMethod" value="" >
  <input type="hidden" name="hidSourceUrl">
  <input type="hidden" name="totvalue" value="<%//=totcount%>">
  <input type="hidden" name="uptovalue" value="<%//=upto%>">
  <!-- for cashflow-->
<input type="hidden" name="flowtype" value="CA">
<input type="hidden" name="yearfrom" value="1">
  <input type="hidden" name="cmdapply" disabled>
<!-- -->
</form>
</body>
</html>
