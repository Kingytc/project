 <%@ page import="com.sai.laps.helper.*,java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<% request.setAttribute("_cache_refresh", "true"); %>
<laps:handleerror />
<%
if(objValues instanceof java.util.HashMap)
   {
	   hshValues=(java.util.HashMap)objValues;
   }


String strSSIType  =Helper.correctNull((String)request.getParameter("hidSSIType"));
String strCategoryType =Helper.correctNull((String)request.getParameter("hidCategoryType"));
  ArrayList vecid1 = (ArrayList)hshValues.get("vecid1");
  ArrayList vecid2 = (ArrayList)hshValues.get("vecid2");
  ArrayList vecid3 = (ArrayList)hshValues.get("vecid3");
  ArrayList vecid4 = (ArrayList)hshValues.get("vecid4");
  ArrayList vecid5 = (ArrayList)hshValues.get("vecid5");
  String fromnext = Helper.correctNull((String) hshValues.get("from"));
  String bgclr="";

  int p=0,sizeyear=0,from=0,to=0,vecModSize  =0;
   String temp="",totcount="",upto="",pageval="",strCurModule="",identity="";
  
	totcount = Helper.correctNull((String)hshValues.get("totalyear"));
	upto = Helper.correctNull((String)hshValues.get("upto"));
	pageval=Helper.correctNull((String)hshValues.get("page"));
	identity=Helper.correctNull((String)hshValues.get("identity"));

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
				if (temp.equals("fin_audit"))
					{
					temp = "Audited";
					}
					else if (temp.equals("fin_unaudit"))
					{
						temp = "Unaudited";
					}
					else if (temp.equals("fin_estimated"))
					{
						temp="Estimated";
					}
					else if (temp.equals("fin_projection"))
					{
                          temp = "Projected";
					}

					
				comboselect[n]=temp;
				n = n+1;
				}
	 		
		}
		
		for (int d = 0 ; d <= 4 ; d++)
		 {
			
			if (comboselect[d] == null)
			 {
			comboselect[d] = " ";
			
			 }
			if (yearval[d] == null)
			 {
			yearval[d]=" ";
			
			 }
			
			 
		 }
		 
	 }
	 else
	 {
		
		 for ( p=0;p<=4;p++)
		 {

			comboselect[p]= " ";
		
			yearval[p]= " ";
			

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


function callLink12(page,method)
{	
	
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].pageval.value="RA";
	document.forms[0].action=appUrl+"action/"+page;
	document.forms[0].submit();	 
}

function callCashFlow(page)
{	
	document.forms[0].hidBeanGetMethod.value="GetCashFlowData";
	document.forms[0].hidBeanId.value="comformula";
	document.forms[0].action=appUrl+"action/"+page+"?flowtype=CA";
	document.forms[0].submit();
	 
}


function shownext(val)
{
	upto = <%=Integer.parseInt(upto)%>;
	fromnext=<%=Integer.parseInt(fromnext)%>;
	page="<%=pageval%>";
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
	

	document.forms[0].action=appUrl+"action/com_finprop.jsp?page="+page+"&from="+from;
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].submit();
}


function doList()
{
		
		disableFields(false);
		document.forms[0].combo1.disabled=false;
		document.forms[0].combo3.disabled=false;
		document.forms[0].combo2.disabled=false;
		document.forms[0].combo4.disabled=false;
		document.forms[0].hidBeanId.value="financial"
		document.forms[0].hidBeanMethod.value="getDataList";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_finprop.jsp";
		document.forms[0].submit();
		

}




function callClose()
{
 
	 var cattype=document.forms[0].cattype.value;
 if((cattype=="ASSI")||(cattype=="ASBI"))
        {
        if(ConfirmMsg(100))
	 {
		 document.forms[0].action=appUrl+"action/agrborrowersearch.jsp";
		 document.forms[0].submit();
	 }
		}
		if((cattype=="SSI")||(cattype=="CORP")||(cattype=="SME"))
        {
        if(ConfirmMsg(100))
	 {
		 document.forms[0].action=appUrl+"action/comborrowersearch.jsp";
		 document.forms[0].submit();
	 }
		}
	
}




function callLink(page,bean,method)
{	
	if (document.forms[0].cmdapply.disabled)
	{
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appUrl+"action/"+page;
	 document.forms[0].submit();
	 }
	else
	{
		ConfirmMsg(103);
	}
}
function callLink1(page,bean)
{	
	if (document.forms[0].cmdapply.disabled)
	{
	// document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appUrl+"action/"+page;
	 document.forms[0].submit();
	 }
	else
	{
		ConfirmMsg(103);
	}
}

 function callApplicantTab(page)
  { 
   	
	if (document.forms[0].cmdapply.disabled)
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
	else
	{
		ConfirmMsg(103);
	}
	
	
  }
  
  function getSection(modid)
{
	document.forms[0].pageval.value = modid;
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].action = appUrl+"action/com_finprop.jsp";
	document.forms[0].submit();
}

  function printreport()
{

	appno = document.forms[0].appno.value;
	if (document.forms[0].identity.value == "")
	{
		upto = "<%=Integer.parseInt(upto)%>";
		page="<%=pageval%>";
		totcount="<%=totcount%>";
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
			
			
		}
		
		
		
			var purl = appUrl+"action/com_finprint.jsp?pageval="+page+"&from="+from+"&hidBeanGetMethod=getData&hidBeanId=financial&appno="+appno;
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
		//txtyear4=document.forms[0].txtyear4.value;
		combo1=document.forms[0].combo1.value;
		combo2=document.forms[0].combo2.value;
		combo3=document.forms[0].combo3.value;
		//combo4=document.forms[0].combo4.value;
		var purl = appUrl+"action/com_finprint.jsp?pageval="+page+"&hidBeanGetMethod=getDataList&hidBeanId=financial&appno="+appno+"&txtyear1="+txtyear1+"&txtyear2="+txtyear2+"&txtyear3="+txtyear3+"&combo1="+combo1+"&combo2="+combo2+"&combo3="+combo3;
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
<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#EEEAE3" >

<jsp:include page="../share/help.jsp" flush="true"/>
<form method="post" >
  <table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr> 
			<td valign="top" colSpan=5> 
              <jsp:include page="../share/menus.jsp" flush="true"/>
              <jsp:include page="../com/proposallinks.jsp" flush="true"> 
              <jsp:param name="pageid" value="13" />
			   <jsp:param name="cattype" value="<%=strCategoryType%>" />
			  <jsp:param name="ssitype" value="<%=strSSIType%>" />
			
              </jsp:include>
            </td>
          </tr>
        </table>
<br> <b><i>Home-&gt; Corporate-&gt; 
  Proposal-&gt; Financial </i></b><br>
      <span style="display:none"><laps:borrowertype /></span> <laps:application/>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
        <tr> 
          <td> 
		  <table width="100%" cellspacing=0 cellpadding=0><tr>
                  <td> 
                    <%
int strWidth;
int tabWidth;
int tableWidth;
 strWidth=vecModSize;
if(strWidth == 1)
{
	tableWidth = 15;
}
else if(strWidth == 2)
{
tableWidth = 30;
}
else
{
tableWidth=60;
}
%>
                    <table border="0" cellspacing="2" cellpadding="2" width="100%">
                      <tr> 
                        <%
for(int i=0;i<vecModSize;i++)
{
 	ArrayList vecVal =(ArrayList)vecModule.get(i);
%>
                       
				  <% 
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
				   tabWidth=100/strWidth;
				}

				if(i==0 && strCurModule.trim().equals(""))
				{
					str1="";
				}
				   if(str1.equals(strCurModule))
				   {
				   strClass="whitefont";
				    bgclr="#71694F";
				  
				  }
				  else
				  {
				  strClass="blackfont";
				   bgclr="#EEEAE3";
				  
				   }
				   if(!str1.equalsIgnoreCase("Project Financial Input")){
				  %>
				   
				    <td  width="<%=tabWidth%>%" align="center" bgcolor="<%=bgclr%>"> 
                          <%
				   if(str1.equals(strCurModule))
				   {
				   %>
                          <b class="<%=strClass%>"><%=Helper.correctNull((String)vecVal.get(0))%></b> 
                          <%
				   }
				   else
				   {
				   %>
                          <a href="javascript:getSection('<%=Helper.correctNull((String)vecVal.get(0))%>')" class="<%=strClass%>"><b><%=Helper.correctNull((String)vecVal.get(0))%></b></a> 
                          <%
				   }
				   %>
                        </td>
                        <%}}%>
                      </tr>
                    </table>
                  </td>
        </tr>
      </table></td></tr></table>
      <table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" onMouseOver=" ">
        <tr> 
          <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
                <tr> 
                  <td> 
                    <table width="100%" border="1" cellspacing="0" cellpadding="5" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF" height="100%">
                      <tr> 
                        <td valign="top"> 
                          <table width="100%" border="1" cellspacing="0" cellpadding="1" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF"  height="157" align="left" >
                            <tr bgcolor="#9C9372"> 
                              <td colspan="2" align="center" height="25"><font color="#000000"><b></b></font><font color="#FFFFFF"><b>Particulars</b></font> 
                              </td>
                              <td width="15%" align="center" height="25"><font color="#FFFFFF"><b></b></font></td>
                              <td width="15%" align="center" height="25"><font color="#FFFFFF"><b></b></font></td>
                              <td width="15%" align="center" height="25"><font color="#FFFFFF"><b></b></font></td>
                              <td width="15%" align="center" height="25"><font color="#FFFFFF"><b></b></font></td>
                              <td width="15%" align="center" height="25"><font color="#FFFFFF"><b></b></font></td>
                            </tr>
                            <tr> 
                              <td colspan="2">&nbsp; </td>
                              <td width="15%" align="center">&nbsp;<%=yearval[0]%>
                              </td>
                              <td width="15%" align="center">&nbsp; <%=yearval[1]%> 
                              </td>
                              <td width="15%" align="center">&nbsp; <%=yearval[2]%> 
                              </td>
                             <td width="15%" align="center">&nbsp; <%=yearval[3]%> 
                              </td>
                              <td width="15%" align="center">&nbsp; <%=yearval[4]%> 
                              </td> 
                            </tr>
                            <tr> 
                              <td colspan="2">&nbsp;</td>
                              <td width="15%" align="center">&nbsp;<%=comboselect[0]%> 
                              </td>
                              <td width="15%" align="center">&nbsp; <%=comboselect[1]%>
                              </td>
                              <td width="15%" align="center">&nbsp; <%=comboselect[2]%> 
                              </td>
                            <td width="15%" align="center">&nbsp; <%=comboselect[3]%> 
                              </td>
                              <td width="15%" align="center">&nbsp; <%=comboselect[4]%> 
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

							if(finsize==0)
							{
								finsize = vecsize;
								
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
                            <tr> 
                              <td bgcolor="#B3AB93" width="4%" align="center"> 
                                <font  color="#FFFFFF"><%=Helper.correctNull((String)g1.get(3))%>&nbsp;</font> 
                              </td>
                              <td bgcolor="#EEEAE3" width="28%"> 
                                <%
							  if (strtype.trim().equals("I") )
								{
					
							  %>
                                <div align="left"><%=Helper.correctNull((String)g1.get(1))%></div>
                                <%
								}
						  else 
								{
							  %>
                                 <%
	                                if (strtype.trim().equals("C") )
	                                {                                	
	                                %>     
	                                		<div align="left"><font color="blue"><%=Helper.correctNull((String)g1.get(1))%> </font></div>
	                                	<%                            	
	                                }
	                                else if(strtype.trim().equals("H"))
	                            	{
	                            		   %>
	                            		  <div align="left"><b><%=Helper.correctNull((String)g1.get(1))%></b></div>
	                            	<%
	                            	}
	                                else
	                                {%> 
	                                	<div align="left"><%=Helper.correctNull((String)g1.get(1))%></div>
	                                <%
	                                }
								}
								%>
							  
                              </td>
                              <td bgcolor="#EEEAE3" width="15%" align="center"> 
                                <%
							if (!strtype.trim().equals("C") && !strtype.trim().equals("H") )
								{
													  
							  %>
                                <div align="right" style="width:75"><%=colval1%></div>
                                <%
								}
						  else 
								{
							  
							  %>
                                <%if (!strtype.trim().equals("H"))
                                {%>
                                <div align="right" style="width:75"><%=colval1%></div>
                                <%
								}
								}
									   %>
                              </td>
                              <td bgcolor="#EEEAE3" width="15%" align="center"> 
                                <%
							if (!strtype.trim().equals("C") && !strtype.trim().equals("H") )
								{
													  
							  %>
                                <div align="right" style="width:75"><%=colval2%></div>
                                <%
								}
						  else 
								{
							  %>
                                <%if (!strtype.trim().equals("H")){%>
                                <div align="right" style="width:75"><%=colval2%></div>
                                <%
							}
								}   %>
                              </td>
                              <td bgcolor="#EEEAE3" width="15%" align="center"> 
                                <%
							if (!strtype.trim().equals("C") && !strtype.trim().equals("H") )
								{
													  
							  %>
                                <div align="right" style="width:75"><%=colval3%></div>
                                <%
								}
						  else 
								{
							  %>
                                <%if (!strtype.trim().equals("H")){%>
                                <div align="right" style="width:75"><%=colval3%></div>
                                <%
							}
								}	   %>
                              </td>
                               <td bgcolor="#EEEAE3" width="15%" align="center"> 
                                <%
							if (!strtype.trim().equals("C") && !strtype.trim().equals("H") )
								{
													  
							  %>
                                <div align="right" style="width:75"><%=colval4%></div>
                                <%
								}
						  else 
								{
							  %>
                                <%if (!strtype.trim().equals("H")){%>
                                <div align="right" style="width:75"><%=colval4%></div>
                                <%
							}
								}
									   %>
                              </td> 
                               <td bgcolor="#EEEAE3" width="15%" align="center"> 
                                <%
							if (!strtype.trim().equals("C") && !strtype.trim().equals("H") )
								{
													  
							  %>
                                <div align="right" style="width:75"><%=colval5%></div>
                                <%
								}
						  else 
								{
							  %>
                                <%if (!strtype.trim().equals("H")){%>
                                <div align="right" style="width:75"><%=colval5%></div>
                                <%
							}
								}
									   %>
                              </td>
                            </tr>
                            <%
						
						  }
						  int endsize=0;
						  startsize = finsize ;
						 	 if(yearsize < vecsize)
							{
														
							//	 g1 = (ArrayList)v.get(7);
								
								
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
								strtype=Helper.correctNull((String)g1.get(2));
						%>
                            <tr> 
                              <td bgcolor="#B3AB93" width="4%" align="center"> 
                                <font  color="#FFFFFF"><%=Helper.correctNull((String)g1.get(3))%>&nbsp;</font> 
                              </td>
                              <td bgcolor="#EEEAE3" width="28%"> 
                                <%
							  if (strtype.trim().equals("I") )
								{
							  
							  
							  %>
                                <div align="left"><%=Helper.correctNull((String)g1.get(1))%></div>
                                <%
								}
						  else 
								{
							  %>
                                <div align="left"><%=Helper.correctNull((String)g1.get(1))%></div>
                                <%
							}
									   %>
                              </td>
                              <td bgcolor="#EEEAE3" width="15%" align="center"> 
                                <%
							if (!strtype.trim().equals("C") && !strtype.trim().equals("H") )
								{
													  
							  %>
                                <div align="right" style="width:75"><%=colval1%></div>
                                <%
								}
						  else 
								{
							  
							  %>
                                <%if (!strtype.trim().equals("H")){%>
                                <div align="right" style="width:75"><%=colval1%></div>
                                <%
							}
								}
									   %>
                              </td>
                              <td bgcolor="#EEEAE3" width="15%" align="center"> 
                                <%
							if (!strtype.trim().equals("C") && !strtype.trim().equals("H") )
								{
													  
							  %>
                                <div align="right" style="width:75"><%=colval2%></div>
                                <%
								}
						  else 
								{
							  %>
                                <%if (!strtype.trim().equals("H")){%>
                                <div align="right" style="width:75"><%=colval2%></div>
                                <%
							}
								}   %>
                              </td>
                              <td bgcolor="#EEEAE3" width="15%" align="center"> 
                                <%
							if (!strtype.trim().equals("C") && !strtype.trim().equals("H") )
								{
													  
							  %>
                                <div align="right" style="width:75"><%=colval3%></div>
                                <%
								}
						  else 
								{
							  %>
                                <%if (!strtype.trim().equals("H")){%>
                                <div align="right" style="width:75"><%=colval3%></div>
                                <%
							}
								}	   %>
                              </td>
                              <td bgcolor="#EEEAE3" width="15%" align="center"> 
                                <%
							if (!strtype.trim().equals("C") && !strtype.trim().equals("H") )
								{
													  
							  %>
                                <div align="right" style="width:75"><font size="1" face="MS Sans Serif"><%=colval4%></font></div>
                                <%
								}
						  else 
								{
							  %>
                                <%if (!strtype.trim().equals("H")){%>
                                <div align="right" style="width:75"><font size="1" face="MS Sans Serif"><%=colval4%></font></div>
                                <%
							}
								}
									   %>
                              </td> 
                             <td bgcolor="#EEEAE3" width="15%" align="center"> 
                                <%
							if (!strtype.trim().equals("C") && !strtype.trim().equals("H") )
								{
													  
							  %>
                                <div align="right" style="width:75"><font size="1" face="MS Sans Serif"><%=colval5%></font></div>
                                <%
								}
						  else 
								{
							  %>
                                <%if (!strtype.trim().equals("H")){%>
                                <div align="right" style="width:75"><font size="1" face="MS Sans Serif"><%=colval5%></font></div>
                                <%
							}
								}
									   %>
                              </td>
                            </tr>
                            <%
						
						  }

							}

							  %>
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
      <table border="0" cellspacing="0" cellpadding="0" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF" align="center">
        <tr> 
            <td> <font face="MS Sans Serif">
              <%
 if ((Integer.parseInt(upto) > 4) && (Integer.parseInt(upto) != 0) )
{
	  %>
              <font size="1">&lt;&lt;</font></font> <a href="javascript:shownext('p')" class="blackfont"><b>Previous</b></a> 
              <%
	  }  %>
            </td>  
            <td> &nbsp; 
              <%
	  int y1=Integer.parseInt(totcount);
 if ((y1 > 4) && (Integer.parseInt(upto)!= y1))
{
	  %>
              <a href="javascript:shownext('n')" class="blackfont"><b>Next</b></a> 
              <font size="1" face="MS Sans Serif">&gt;&gt;</font> 
              <%
	  }  %>
            </td>
          <td>&nbsp; </td>
          <td> &nbsp; 
            <%
	/*   y1=Integer.parseInt(totcount);
	  int y2 =Integer.parseInt(upto);
 if ((y1 == y2) && (identity.equals("list")))
{*/
	  %>
            <!-- <a href="javascript:getInitial()">Refresh</a> -->
            <%
	//  }  %>
          </td>
        </tr>
      </table>
      <br>
        <table border="1" cellspacing="0" cellpadding="3" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
          <tr> 
            <td width="0"> 
              <div align="center"> 
                <input type="button" name="cmdclose" value="Close"  style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"  onClick="callClose()">
              </div>
            </td>
			<td width="0"> 
              <div align="center"> 
                <input type="button" name="cmdPrint" value="Print" style="background-color:#8F8369;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="printreport()">
              </div>
            </td>

          </tr>
        </table>
      <input type="hidden" name="hidAction" >
      <input type="hidden" name="hidBeanId">
      <input type="hidden" name="hidBeanMethod" value="">
      <input type="hidden" name="hidBeanGetMethod" value="" >
      <input type="hidden" name="hidSourceUrl">
      <input type="hidden" name="totvalue" value="<%=totcount%>">
      <input type="hidden" name="uptovalue" value="<%=upto%>">
      <input type="hidden" name="fromvalue" value="<%=Integer.parseInt(upto) + 1%>">
        <INPUT TYPE="hidden" value = "<%=pageval%>" name="pageval">
      <INPUT TYPE="hidden" value = "10" name="hidTotal">
	  <INPUT TYPE="hidden" value = "<%=identity%>" name="identity">
	  <input type="hidden" name="cattype" value="<%=strCategoryType%>"> 
	  <input type="hidden" name="cmdapply" style="visibility:hidden" disabled> 
	  <INPUT TYPE="hidden" name="fromnext" value="<%=Helper.correctNull((String)hshValues.get("from"))%>">

</table>

</form>
</body>
</html>
