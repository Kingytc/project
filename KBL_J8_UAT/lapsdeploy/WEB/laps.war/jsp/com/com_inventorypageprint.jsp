<%@include file="../share/directives.jsp"%>
<%
java.text.NumberFormat nft= java.text.NumberFormat.getInstance();
nft= java.text.NumberFormat.getInstance();
nft.setGroupingUsed(false);
nft.setMaximumFractionDigits(2);
nft.setMinimumFractionDigits(2);
HashMap hshRecordNew = new HashMap();

	hshRecordNew=(HashMap)hshValues.get(request.getParameter("pagevalue"));
	String strPageFrom="";
	String strClassName="";
	strPageFrom = (String)(request.getParameter("pagefrom"));
	if(strPageFrom.equalsIgnoreCase("financial")) strClassName="datagrid";
	else strClassName="";
	
 	String bgclr="";
  	int p=0,sizeyear=5,from=0,to=0,vecModSize  =0;
   	String temp="",totcount="",upto="",pageval="",strCurModule="",identity="",strpagetype="";
	totcount = Helper.correctNull((String)hshRecordNew.get("totalyear"));
	upto = Helper.correctNull((String)hshRecordNew.get("upto"));
	pageval=Helper.correctNull((String)hshRecordNew.get("page"));
	identity=Helper.correctNull((String)hshRecordNew.get("identity"));	
	strpagetype=Helper.correctNull((String)hshRecordNew.get("strPage"));	
	strCurModule = pageval;
	ArrayList g1= new ArrayList();
	ArrayList g2= new ArrayList();
	ArrayList g3= new ArrayList();
	g2=(ArrayList) hshRecordNew.get("yearvalue");
	g3  = (ArrayList) hshRecordNew.get("value");
	ArrayList	vecModule = (ArrayList)hshRecordNew.get("tabdetails");
	if(vecModule!=null)
	{
		vecModSize = vecModule.size();
	}
	if(g2!=null && g2.size()> 0)
	{
		sizeyear=g2.size();
		sizeyear=sizeyear/2;
	}
	String yearval[] = new String[sizeyear];
	String comboselect[] = new String[sizeyear];	
	int y = 0,n=0;	
	 if (g2!=null && g2.size() > 0)
	 {
	for (int k=0;k< g2.size();k++)
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
		for (int d = 0 ; d < sizeyear ; d++)
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
	%>
<html>
<head>
<Script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
</script>
</head>

  
						
                        <tr> <td colspan="<%=g2.size() %>" class="<%=strClassName%>"><b>INVENTORY NORMS</b></td></tr>   
                      <%
                      ArrayList vecRow1=new ArrayList();
                      ArrayList vecId1=new ArrayList();
					    ArrayList v1 = (ArrayList) hshRecordNew.get("labeldetails");
						
                      for(int k=1;k<=sizeyear;k++)
                      {
                    	  vecRow1=(ArrayList) hshRecordNew.get("year"+k);
                      }
						String colval1="";
						String colval2="",colval3="",colval4="",colval5="",strtype="",selectdesc="";
						int vecsize=0,count=1,yearsize=0,finsize=0,startsize=0;
						String colid="",rowid="";
							if(v1!=null)
							{
								vecsize =v1.size();

							}
							if (vecRow1 != null)
							{
								yearsize = vecRow1.size();
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
					g1 = (ArrayList)v1.get(l);
					colid = Helper.correctNull((String)g1.get(0));
					colid=colid.trim();
					
						
					strtype=Helper.correctNull((String)g1.get(2));
					%>
                     
                     <%if(!strtype.equalsIgnoreCase("HE")) { %>
					
					
                     
                      <tr> 
                       <td width="4%" align="center"> 
                          <%=Helper.correctNull((String)g1.get(3))%>&nbsp;		  
						  </td>
                        <td width="32%" align="left">  
                          
                          
                           <%if(strtype.equalsIgnoreCase("HE")){ %>
                          
                         <B> <%=Helper.correctNull((String)g1.get(1))%>&nbsp; </B>
                          
                          <%} else { %>
                          <%=Helper.correctNull((String)g1.get(1))%>&nbsp; 
                          
                          <%} %>
                          
                          
                          
                        </td>
                        
                         <% for(int q=0;q<sizeyear;q++)
                         {
                          	  vecRow1=(ArrayList) hshRecordNew.get("year"+(q+1));
                          	  vecId1=(ArrayList) hshRecordNew.get("vecId1"+(q+1));
                            
       					
       					 if (vecRow1 != null && vecId1 != null)
       						{
       							rowid=Helper.correctDouble((String)vecId1.get(l));
       							String colval="";
       							rowid=rowid.trim();
       							if (rowid.equals(colid))
       							{
       								
       								colval=nft.format(Double.parseDouble(Helper.correctDouble((String)vecRow1.get(l))));
       							}
       							else
       							{
       								colval = "0.00";
       							}
                         if(!strtype.equalsIgnoreCase("HE")){ 
                         %>
                         <%if(!yearval[q].equalsIgnoreCase("")){%>
                        <td  width="15%" align="right"><%=colval%></td><%} %>
                            <%} else { %>
                         <%if(!yearval[q].equalsIgnoreCase("")){%>
                        <td  width="15%" align="right">&nbsp;</td><%} %>
                           <%} %>
                      <%}
       					 else{%>
       					  <td  width="15%" align="right">0.00&nbsp;</td>
       					<% }
       					 }%>
                         </tr>
                    	 <%}
						}%>
                  
     
