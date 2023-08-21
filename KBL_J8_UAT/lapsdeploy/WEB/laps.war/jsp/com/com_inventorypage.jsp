<%@include file="../share/directives.jsp"%>
<%
HashMap hshRecord = new HashMap();

	hshRecord=(HashMap)hshValues.get(request.getParameter("pagevalue"));
	String strPageFrom="";
	String strClassName="";
	strPageFrom = (String)(request.getParameter("pagefrom"));
	if(strPageFrom.equalsIgnoreCase("financial")) strClassName="datagrid";
	else strClassName="";
	
	ArrayList vecid1 = (ArrayList)hshRecord.get("vecid1");
  	ArrayList vecid2 = (ArrayList)hshRecord.get("vecid2");
  	ArrayList vecid3 = (ArrayList)hshRecord.get("vecid3");
  	ArrayList vecid4 = (ArrayList)hshRecord.get("vecid4");
  	ArrayList vecid5 = (ArrayList)hshRecord.get("vecid5");
 	String bgclr="";
  	int p=0,sizeyear=0,from=0,to=0,vecModSize  =0;
   	String temp="",totcount="",upto="",pageval="",strCurModule="",identity="",strpagetype="";
	totcount = Helper.correctNull((String)hshRecord.get("totalyear"));
	upto = Helper.correctNull((String)hshRecord.get("upto"));
	pageval=Helper.correctNull((String)hshRecord.get("page"));
	identity=Helper.correctNull((String)hshRecord.get("identity"));	
	strpagetype=Helper.correctNull((String)hshRecord.get("strPage"));	
	strCurModule = pageval;
	ArrayList g1= new ArrayList();
	ArrayList g2= new ArrayList();
	ArrayList g3= new ArrayList();
	ArrayList year1= new ArrayList();
	ArrayList year2= new ArrayList();
	ArrayList year3= new ArrayList();
	ArrayList year4= new ArrayList();
	ArrayList year5= new ArrayList();
	g2=(ArrayList) hshRecord.get("yearvalue");
	g3  = (ArrayList) hshRecord.get("value");
	year1 = (ArrayList) hshRecord.get("year1");
	year2 = (ArrayList) hshRecord.get("year2");
	year3 = (ArrayList) hshRecord.get("year3");
	year4 = (ArrayList) hshRecord.get("year4");
	year5 = (ArrayList) hshRecord.get("year5");
	ArrayList	vecModule = (ArrayList)hshRecord.get("tabdetails");
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
	String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
	if(strcmaindex.equalsIgnoreCase(""))
		{
		strcmaindex=Helper.correctNull((String)hshRecord.get("cma"));
		}%>
<html>
<head>
<Script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
</script>
</head>

  
						
                        <tr> <td colspan="7" class="<%=strClassName%>"><b>INVENTORY NORMS</b></td></tr>   
                      <%
					    ArrayList v = (ArrayList) hshRecord.get("labeldetails");

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
                      <tr> 
                        <td width="4%" align="center" class="<%=strClassName%>"> 
                          <INPUT TYPE="hidden" name="id" value="<%=Helper.correctNull((String)g1.get(0))%>">
                          <INPUT TYPE="hidden" name="type" value="<%=Helper.correctNull((String)g1.get(2))%>">
                          <%=Helper.correctNull((String)g1.get(3))%>&nbsp;		  
						  </td>
						  <%if(strtype.equalsIgnoreCase("HE")){
                      		 %>
                      		  <td width="26%" colspan="7" class="<%=strClassName%>"><B><%=Helper.correctNull((String)g1.get(1))%></B></td>
                        
                        <%    }
						  else
						  {
							  %>
							 <td width="26%" class="<%=strClassName%>"> <%=Helper.correctNull((String)g1.get(1))%></td>
							  <%
						  }
                        	// For Bank model cma no: 2,First year ratio is made 0.00
                        	// Modified by: Muralidharan
                        	// Date: 04/01/2008                        	
                        	String cma_no=Helper.correctNull((String)hshRecord.get("cma_no"));
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
                        	if(!strtype.equalsIgnoreCase("HE")){
                        		
                        		if (!yearval[0].equalsIgnoreCase("")) {
                            if(cma_no.equalsIgnoreCase("2") && flag==1)
                           {
                           %>
                        <td width="14%" align="right" class="<%=strClassName%>">0.00</td>
                       <%}else{%>
                       <td width="14%" align="right" class="<%=strClassName%>"><%=colval1%></td>
                       <%}}else{%>
                                <td width="14%" align="right" class="<%=strClassName%>">0.00</td>
                                <%}if (!yearval[1].equalsIgnoreCase("")) {%>							
                        <td width="14%" align="right" class="<%=strClassName%>"><%=colval2%></td>
                        <%}else{%>
                        <td width="14%" align="right" class="<%=strClassName%>">0.00</td>
                        <%}if (!yearval[2].equalsIgnoreCase("")) { %>								
                        <td width="14%" align="right" class="<%=strClassName%>"><%=colval3%></td>  
                        <%}else{%>
                        <td width="14%" align="right" class="<%=strClassName%>">0.00</td>
                        <%}if (!yearval[3].equalsIgnoreCase("")) { %>                      		
                        <td width="14%" align="right" class="<%=strClassName%>"><%=colval4%></td>
                        <%}else{%>
                        <td width="14%" align="right" class="<%=strClassName%>">0.00</td>
                        <%}if (!yearval[4].equalsIgnoreCase("")) { %>
                         <td width="14%" align="right" class="<%=strClassName%>"><%=colval5%></td>  
                         <%}else{%>
                         <td width="14%" align="right" class="<%=strClassName%>">0.00</td>
                         <%} %>                     
                      </tr>
                      <%}
				}%>
                  
     
