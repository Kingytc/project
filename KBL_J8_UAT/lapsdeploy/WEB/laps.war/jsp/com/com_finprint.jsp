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
  int p=0,sizeyear=0,from=0,to=0,vecModSize  =0;
   String temp="",totcount="",upto="",pageval="",strCurModule="",identity="";
  
	totcount = Helper.correctNull((String)hshValues.get("totalyear"));
	upto = Helper.correctNull((String)hshValues.get("upto"));
	pageval=Helper.correctNull((String)hshValues.get("page"));
	
	identity=Helper.correctNull((String)hshValues.get("identity"));
	
	String moduletype=Helper.correctNull((String)hshValues.get("sessionModuleType"));
	if(moduletype.equals(""))
	{
		moduletype=Helper.correctNull((String)hshValues.get("cattype"));
	}
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
						temp = "Audited";
					}
					else if (temp.trim().equals("fin_unaudit"))
					{
						temp = "Unaudited";
					}
					else if (temp.trim().equals("fin_estimated"))
					{
						temp = "Estimated";
					}
					else if (temp.trim().equals("fin_projection"))
					{
						temp = "Projection";
					}
					comboselect[n]=temp;
					n = n+1;
				}	 		
		}		
		for (int d = 0 ; d <= 4 ; d++)
		 {
			
			if (comboselect[d] == null)
			 {
			comboselect[d] = "";
			
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
	java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
	jtn.setMaximumFractionDigits(2);
	jtn.setMinimumFractionDigits(2);
	jtn.setGroupingUsed(false);
	 %>
<html>
<head>
<title>Financial</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/com/finmain.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body>
<form class="normal" method="post" >
 <span style="display:none"><lapschoice:borrowertype /></span>
 
 <% if(moduletype.equals("")){ %> 
  <lapschoice:finapptype  appid='<%=Helper.correctNull((String)hshValues.get("appidnew"))%>' financeid='<%=Helper.correctInt((String)hshValues.get("finace_id"))%>'/>
 <% } else { %>
  <lapschoice:application/> <br>  
 <% }   %>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
    <tr> 
      <td valign="top"> <%=request.getParameter("pageval")%><br>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
                <tr> 
                  <td valign="top"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
                      <tr class="dataheader"> 
                        <td colspan="2" align="center"><b>Particulars</b> 
                        </td>
                        <% if(!yearval[0].equalsIgnoreCase("")){ %> 
                       <td width="15%" align="center" ><b></b></td>
                        <%} if(!yearval[1].equalsIgnoreCase("")){ %>
                           <td width="15%" align="center" ><b></b></td>
                        <%}if(!yearval[2].equalsIgnoreCase("")){%>
                        
                           <td width="15%" align="center" ><b></b></td>
                        <%}if(!yearval[3].equalsIgnoreCase("")){ %>
                        
                           <td width="15%" align="center" ><b></b></td> 
                        <%}if(!yearval[4].equalsIgnoreCase("")){ %>
                        
                            <td width="15%" align="center" ><b></b></td>
                        <%} %>
                      </tr>
                      <tr class="dataheader"> 
                        <td colspan="2">&nbsp; </td>
                        <% if(!yearval[0].equalsIgnoreCase("")){ %> 
                        <td width="15%" align="center"> <%=yearval[0]%>&nbsp;</td>
                        <%} if(!yearval[1].equalsIgnoreCase("")){ %>
                        
                        <td width="15%" align="center"> <%=yearval[1]%>&nbsp;</td>
                        
                        <%}if(!yearval[2].equalsIgnoreCase("")){%>
                        
                        <td width="15%" align="center"> <%=yearval[2]%>&nbsp;</td>
                        
                        <%}if(!yearval[3].equalsIgnoreCase("")){ %>
                        
                        <td width="15%" align="center"> <%=yearval[3]%>&nbsp;</td>
                        
                        <%}if(!yearval[4].equalsIgnoreCase("")){ %>
                        
                        <td width="15%" align="center"> <%=yearval[4]%>&nbsp;</td>
                        
                        <%} %>
                      </tr>
                      <tr class="dataheader"> 
                        <td colspan="2">&nbsp; </td>
                         <% if(!yearval[0].equalsIgnoreCase("")){ %> 
                         <td width="15%" align="center"> <%=comboselect[0]%>&nbsp;</td>
                        <%} if(!yearval[1].equalsIgnoreCase("")){ %>
                        
                          <td width="15%" align="center"> <%=comboselect[1]%>&nbsp;</td>
                        <%}if(!yearval[2].equalsIgnoreCase("")){%>
                        
                          <td width="15%" align="center"> <%=comboselect[2]%>&nbsp;</td>
                        <%}if(!yearval[3].equalsIgnoreCase("")){ %>
                        
                          <td width="15%" align="center"> <%=comboselect[3]%>&nbsp;</td>
                        <%}if(!yearval[4].equalsIgnoreCase("")){ %>
                        
                           <td width="15%" align="center"> <%=comboselect[4]%>&nbsp;</td>
                        <%} %>    
                      </tr>
                      <%
                      ArrayList v = (ArrayList) hshValues.get("labeldetails");
						String col1="",col2="",col3="",col4="",col5="";
						String finval="",colval1="";
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
							colval1=jtn.format(Double.parseDouble(Helper.correctDouble((String)year1.get(l))));
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
							colval2=jtn.format(Double.parseDouble(Helper.correctDouble((String)year2.get(l))));
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
							colval3=jtn.format(Double.parseDouble(Helper.correctDouble((String)year3.get(l))));
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
							colval4=jtn.format(Double.parseDouble(Helper.correctDouble((String)year4.get(l))));								
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
							colval5=jtn.format(Double.parseDouble(Helper.correctDouble((String)year5.get(l))));
							
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
					strtype=Helper.correctNull((String)g1.get(2));%>
					<%if(true){ %>
                      <tr class="datagrid"> 
                        <td width="4%" align="center">  
                          <INPUT TYPE="hidden" name="id" value="<%=Helper.correctNull((String)g1.get(0))%>">
                          <INPUT TYPE="hidden" name="type" value="<%=Helper.correctNull((String)g1.get(2))%>">
                          <%=Helper.correctNull((String)g1.get(3))%>&nbsp; 
                        </td>
                        <td width="28%"> 
                          <%=Helper.correctNull((String)g1.get(1))%>
                        </td>
                        <%if(l >= 0){ %>
                         <% if(!yearval[0].equalsIgnoreCase("")){ %> 
                        <td width="15%" align="center"> 
                          <div align="right" style="width:75"><%=colval1%></div>
                        </td>
                          <%} if(!yearval[1].equalsIgnoreCase("")){ %>
                        <td width="15%" align="center"> 
                          <div align="right" style="width:75"><%=colval2%></div>
                        </td>
                          <%} if(!yearval[2].equalsIgnoreCase("")){ %>
                        <td width="15%" align="center"> 
                          <div align="right" style="width:75"><%=colval3%></div>
                        </td>
                          <%} if(!yearval[3].equalsIgnoreCase("")){ %>
                      <td width="15%" align="center"> 
                          <div align="right" style="width:75"><%=colval4%></div>
                        </td>
                          <%} if(!yearval[4].equalsIgnoreCase("")){ %>
                        <td width="15%" align="center"> 
                          <div align="right" style="width:75"><%=colval5%></div>
                        </td>
                        <%} %>
                        <%}else{ %>
                         <% if(!yearval[0].equalsIgnoreCase("")){ %> 
                         <td width="15%" align="center"> 
                          <div align="right" style="width:75">&nbsp;</div>
                        </td>
                         <%} if(!yearval[1].equalsIgnoreCase("")){ %>
                        <td width="15%" align="center"> 
                          <div align="right" style="width:75">&nbsp;</div>
                        </td>
                         <%} if(!yearval[2].equalsIgnoreCase("")){ %>
                        <td width="15%" align="center"> 
                          <div align="right" style="width:75">&nbsp;</div>
                        </td>
                         <%} if(!yearval[3].equalsIgnoreCase("")){ %>
                      <td width="15%" align="center"> 
                          <div align="right" style="width:75">&nbsp;</div>
                        </td>
                         <%} if(!yearval[4].equalsIgnoreCase("")){ %>
                        <td width="15%" align="center"> 
                          <div align="right" style="width:75">&nbsp;</div>
                        </td>
                        <%}} %>
                      </tr>
                      
                      <% }}
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
					<%if(true){ %>
                      <tr class="datagrid"> 
                        <td width="4%" align="center">  
                          <INPUT TYPE="hidden" name="id" value="<%=Helper.correctNull((String)g1.get(0))%>">
                          <INPUT TYPE="hidden" name="type" value="<%=Helper.correctNull((String)g1.get(2))%>">
                          <%=Helper.correctNull((String)g1.get(3))%>&nbsp; 
                        </td>
                        <td width="28%"> 
                          <%=Helper.correctNull((String)g1.get(1))%>
                        </td>
                         <%if(!yearval[0].equalsIgnoreCase("")){ %>
                        <td width="15%" align="center"> 
                          <div align="right" style="width:75"><%=colval1%></div>
                        </td>
                         <%} if(!yearval[1].equalsIgnoreCase("")){ %>
                        <td width="15%" align="center"> 
                          <div align="right" style="width:75"><%=colval2%></div>
                        </td>
                         <%} if(!yearval[2].equalsIgnoreCase("")){ %>
                        <td width="15%" align="center"> 
                          <div align="right" style="width:75"><%=colval3%></div>
                        </td>
                         <%} if(!yearval[3].equalsIgnoreCase("")){ %>
                       <td width="15%" align="center"> 
                          <div align="right" style="width:75"><%=colval4%></div>
                        </td>
                         <%} if(!yearval[4].equalsIgnoreCase("")){ %>
                        <td width="15%" align="center"> 
                          <div align="right" style="width:75"><%=colval5%></div>
                        </td>
                        <%} %>
                      </tr>
                      <%}}}%>
                    </table></td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <br>
</form>
</body>
</html>
