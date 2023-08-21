<%@ page import="com.sai.laps.helper.*,java.util.*,java.text.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%
HashMap hshRecordNew = new HashMap();
java.text.NumberFormat nft= java.text.NumberFormat.getInstance();
nft= java.text.NumberFormat.getInstance();
nft.setGroupingUsed(false);
nft.setMaximumFractionDigits(2);
nft.setMinimumFractionDigits(2);
HashMap hshRecord=new HashMap();
hshRecord=(HashMap)hshValues.get(request.getParameter("pagevalue"));
String strPage=(String)hshRecord.get("strPage");
 	String bgclr="";
  	int p=0,sizeyear=5,from=0,to=0,vecModSize  =0;
   	String temp="",totcount="",upto="",pageval="",strCurModule="",identity="",strpagetype="";
   	if(hshRecord!=null)
   	{
	totcount = Helper.correctNull((String)hshRecord.get("totalyear"));
	upto = Helper.correctNull((String)hshRecord.get("upto"));
	pageval=Helper.correctNull((String)hshRecord.get("page"));
	identity=Helper.correctNull((String)hshRecord.get("identity"));	
	strpagetype=Helper.correctNull((String)hshRecord.get("strPage"));
   	}
	strCurModule = pageval;
	ArrayList g1= new ArrayList();
	ArrayList g2= new ArrayList();
	ArrayList g3= new ArrayList();

	if(hshRecord!=null)
	{
	g2=(ArrayList) hshRecord.get("yearvalue");
	g3  = (ArrayList) hshRecord.get("value");
	}
	ArrayList	vecModule=new ArrayList();
	ArrayList vecRow=new ArrayList();
    ArrayList vecId=new ArrayList();
	if(hshRecord!=null)
	{
	vecModule = (ArrayList)hshRecord.get("tabdetails");
	}
	
	if(vecModule!=null)
	{
		vecModSize = vecModule.size();
	}
	if(g2!=null && g2.size()> 0)
	{
		sizeyear=g2.size();
		sizeyear=sizeyear/2;
	}
	int intSection_count=0;
	int intQuotient = (sizeyear / 5);
	int intRemainder = (sizeyear % 5);
	if(sizeyear > 5)
	{
		if(intRemainder == 0)
			intSection_count = intQuotient;
		else
			intSection_count = intQuotient + 1;
	}
	else
	{
		intSection_count = 1;
	}
	String yearval[] = new String[sizeyear];
	String comboselect[] = new String[sizeyear];	
	int y = 0,n=0;
	 if (g2!=null && g2.size() > 0)
	 {
	for (int k=0;k<g2.size();k++)
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
		for (int d = 0 ; d < sizeyear ; d++)
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
			comboselect[p]= "";
			yearval[p]= "";
		 }
	 }

if(g2!=null && g2.size() != 0) {
	int q=0,t=0;
	 for(int s=0;s<intSection_count;s++)
		{ 
		if(s==0)
		{p=0;t=5;
		if(sizeyear<5)
			t=sizeyear;
		}
%>
<br>
 <div id="top">
             
                    <table width="95%" border="0" cellspacing="0" cellpadding="3" >
                      <tr> 
                        <td colspan="2" align="center">Particulars</td>
                        <%
                        for(int i=p;i<t;i++)
                        {
                  		if (!yearval[i].equalsIgnoreCase("")) {
                 		 %>
                        <td width="14%" align="center">&nbsp;</td>
                         <%}
                  		}%>
                      </tr>
                      <tr> 
                        <td colspan="2">&nbsp; </td>
                        <%
                        for(int i=p;i<t;i++)
                        {
                  	if (!yearval[i].equalsIgnoreCase("")) {
                  %>
                        <td width="14%" align="center"> 
                          <%=yearval[i]%>
                        </td>
                        <%} 
                        }%>
                      </tr>
                             <tr>  <td colspan="2">&nbsp; </td>
                             <%
                             for(int g=p;g<t;g++)
                            	 {
                            		if (!yearval[g].equalsIgnoreCase("")) {%>
                             <td width="14%" align="center"><%=comboselect[g] %></td>
                             <%}
                            		
                            		} %></tr> 
                            		
                          <%String strpage="hshnew"+strpagetype; 
                          hshRecordNew=(HashMap)hshValues.get(strpage);
                          %>  
                          <tr> <td colspan="<%=t+2 %>"><b>INVENTORY NORMS</b></td></tr>   
                      <%
                      ArrayList vecRow1=new ArrayList();
                      ArrayList vecId1=new ArrayList();
					    ArrayList v1 = (ArrayList) hshRecordNew.get("labeldetails");
						
                      for(int k=p;k<=t;k++)
                      {
                    	  vecRow1=(ArrayList) hshRecordNew.get("year"+k);
                      }
						String strtype="",selectdesc="";
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
                          <%=Helper.correctNull((String)g1.get(1))%>&nbsp; 
                        </td>
                        
                         <% for(int a=p;a<t;a++)
                         {
                          	  vecRow1=(ArrayList) hshRecordNew.get("year"+(a+1));
                          	  vecId1=(ArrayList) hshRecordNew.get("vecid"+(a+1));
                            
       					
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
                         <%if(!yearval[a].equalsIgnoreCase("")){%>
                        <td  width="15%" align="right"><%=colval%></td><%} %>
                            <%} %>
                      <%}
       					 else{%>
       					  <td  width="15%" align="right">0.00&nbsp;</td>
       					<% }
       					 }%>
                         </tr>
                    	 <%}
                     	else{%>
                    		 <tr> 
                       <td width="4%" align="center"> 
                          <%=Helper.correctNull((String)g1.get(3))%>&nbsp;		  
						  </td>
                        <td width="32%" align="left" colspan="<%=t+1 %>">  
                         <B> <%=Helper.correctNull((String)g1.get(1))%>&nbsp; </B>
                        </td>
                        </tr>
                    	<% }
						}%>
                          
                          		
						<tr> <td colspan="<%=t+2 %>"><b>MPBF CALCULATION</b></td></tr>     
                      <%
                      ArrayList v=new ArrayList();
                      if(hshRecord!=null)
                      {
					    v = (ArrayList) hshRecord.get("labeldetails");
                      }
                      for(int k=1;k<=t;k++)
                      {
                    	  vecRow=(ArrayList) hshRecord.get("year"+k);
                      }
						strtype="";selectdesc="";
						vecsize=0;count=1;yearsize=0;finsize=0;startsize=0;
						colid="";rowid="";
							if(v!=null)
							{
								vecsize =v.size();

							}
							if (vecRow != null)
							{
								yearsize = vecRow.size();
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
                        
                         <% for(int x=p;x<t;x++)
                         {
                          	  vecRow=(ArrayList) hshRecord.get("year"+(x+1));
                          	  vecId=(ArrayList) hshRecord.get("vecid"+(x+1));
                            
       					
       					 if (vecRow != null && vecId != null)
       						{
       							rowid=Helper.correctDouble((String)vecId.get(l));
       							String colval="";
       							rowid=rowid.trim();
       							if (rowid.equals(colid))
       							{
       								
       								colval=nft.format(Double.parseDouble(Helper.correctDouble((String)vecRow.get(l))));
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
                    	 <%}else{%>
                    		 <tr> 
                       <td width="4%" align="center"> 
                          <%=Helper.correctNull((String)g1.get(3))%>&nbsp;		  
						  </td>
                        <td width="32%" align="left" colspan="<%=t+1 %>">  
                         <B> <%=Helper.correctNull((String)g1.get(1))%>&nbsp; </B>
                        </td>
                        </tr>
                    	<% }
						}%>
                    </table>
                 </div>
            <%
            sizeyear=sizeyear-5;
            p=p+5;
            if(sizeyear>5)
            {
            	t=t+5;
            }
            else
            {
            	t=t+sizeyear;
            }
		}
		} else {%>
            <table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
           	<tr><td style="border: none;">Nil</td></tr>
            </table>
            <%} %>

<br>
