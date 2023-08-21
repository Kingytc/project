<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ page import="java.util.*,java.text.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<% request.setAttribute("_cache_refresh", "true"); %>
<laps:handleerror/>
<%
String strValuesIn	= "(Rs. in  "+Helper.correctNull((String)hshValues.get("strValuesIn"))+")";
java.text.NumberFormat nft= java.text.NumberFormat.getInstance();
nft= java.text.NumberFormat.getInstance();
nft.setGroupingUsed(false);
nft.setMaximumFractionDigits(2);
nft.setMinimumFractionDigits(2);
HashMap hshRecord =new HashMap();
HashMap hshRecord1 =new HashMap();
HashMap hshRecord2 =new HashMap();
ArrayList AL=new ArrayList();
if(hshValues!=null)
	hshRecord1=(HashMap)hshValues.get(request.getParameter("pagevalue"));
	hshRecord2=(HashMap)hshValues.get(request.getParameter("pagevalue1"));
	//out.println((request.getParameter("pagevalue")));
	//hshRecord.putAll(hshRecord1);
		//out.println(hshValues.get(request.getParameter("pagevalue")));//out.println();
if(Helper.correctNull(request.getParameter("pagevalue")).equalsIgnoreCase("hshReqValues3") || 
		Helper.correctNull(request.getParameter("pagevalue")).equalsIgnoreCase("hshReqValues2") || 
	Helper.correctNull(request.getParameter("pagevalue")).equalsIgnoreCase("hshReqValues1") ||  Helper.correctNull(request.getParameter("pagevalue")).equalsIgnoreCase("hshReqValues")||Helper.correctNull(request.getParameter("pagevalue")).equalsIgnoreCase("hshReqValues4") || Helper.correctNull(request.getParameter("pagevalue")).equalsIgnoreCase("hshReqValues_PROP")||Helper.correctNull(request.getParameter("pagevalue")).equalsIgnoreCase("hshReqValues3"))
	
{
	  String bgclr="";
	  //hshRecord=(HashMap)hshValues.get(request.getParameter("hshReqValues5"));
	 // hshRecord.putAll(hshRecord2);
	// ArrayList	r1 = (ArrayList)hshRecord1.get("labeldetails");
	//out.println("r1=="+r1);
	
	  //hshRecord.put("vecid1",hshRecord2.get("vecid1"));
	  //hshRecord.put("vecid2",hshRecord2.get("vecid2"));
	 // hshRecord.put("vecid3",hshRecord2.get("vecid3"));
	 // hshRecord.put("vecid4",hshRecord2.get("vecid4"));
	 // hshRecord.put("year1",hshRecord2.get("year1"));
	 // hshRecord.put("year2",hshRecord2.get("year2"));
	//  hshRecord.put("year3",hshRecord2.get("year3"));
	  //hshRecord.put("year4",hshRecord2.get("year4"));
	  hshRecord.putAll(hshRecord1);
	  
	  
	  //hshRecord.putAll(hshRecord2);
	   // out.println("//=======hshRecord1 values==========="+hshRecord1);
	  //  out.println("//=======hshRecord2 values==========="+hshRecord2);
	 // out.println("//=======hshRecord values==========="+hshRecord);
		//out.println("=======hshRecord1 values==========="+hshRecord1);
		  
	  int p=0,sizeyear=0,from=0,to=0,vecModSize  =0,sizeyearval=5,sizeyearval1=5;
	   String temp="",totcount="",upto="",pageval="",strCurModule="";
	  
	   String loanmodule = Helper.correctNull((String)hshRecord.get("loanmodule"));
		totcount = Helper.correctNull((String)hshRecord.get("totalyear"));
		upto = Helper.correctNull((String)hshRecord.get("upto"));
		pageval=Helper.correctNull((String)hshRecord.get("page"));
		strCurModule = pageval;
		
		ArrayList g1= new ArrayList();
		ArrayList g2= new ArrayList();
		ArrayList g3= new ArrayList();
		ArrayList g4= new ArrayList();
		g2=(ArrayList) hshRecord.get("yearvalue");
		//out.println("yearvalue from g2"+g2);
		g3  = (ArrayList) hshRecord.get("value");
		//out.println("values from g3"+g3);
		ArrayList	vecModule = (ArrayList)hshRecord.get("tabdetails");
		//out.println("tabdetials from vecmodule"+vecModule);
		boolean flag=false;
		if(vecModule!=null)
		vecModSize = vecModule.size();
		//out.println("vecmodule size"+vecModSize);
		if (g2.size() != 0)
		 {
			flag=true;
			 sizeyear=g2.size();
			// out.println("sizeyear=g2.size();(sizeyear)======="+sizeyear);
			 sizeyearval=sizeyear/2;
			// out.println("sizeyearval=sizeyear/2(sizeyearval)====="+sizeyearval);
			 sizeyearval1=sizeyearval;
			 //out.println("sizeyearval1=sizeyearval;(sizeyearval1)===="+sizeyearval1);
		 }
		String yearval[] = new String[sizeyearval];
		//out.println("yearval in array===="+yearval);
		String comboselect[] = new String[sizeyearval];
		//out.println("comboselect in array===="+comboselect[0]);
		
		int intSection_count=0;
		int intQuotient = (sizeyearval / 5);
		//out.println("intQuotient========="+intQuotient);
		int intRemainder = (sizeyearval % 5);
		//out.println("intRemainder========="+intRemainder);
		if(sizeyearval > 5)
		{
			if(intRemainder == 0){
				intSection_count = intQuotient;
			//out.println("intSection_count{if}========="+intSection_count);
			}
			else{
				intSection_count = intQuotient + 1;
				//out.println("intSection_count{else}========="+intSection_count);
			}
		}
		else
		{
			intSection_count = 1;
			//out.println("intSection_count{2nd else }========="+intSection_count);
		}
		int y = 0,n=0;
		 	if (g2.size() != 0)
		 	{
			 sizeyear=g2.size();
			  
			for (int k=0;k<=g2.size()-1;k++)
			{
		
				if ((k % 2 ) == 0)
					{
						temp=Helper.correctNull((String)g2.get(k));
						//out.println("temp for date========="+k+" value "+temp);
						yearval[y]=temp;
						y =y+1;
						//out.println("//y value "+y+"//");
						
					}
				else if ((k % 2) == 1)
					{
						temp=Helper.correctNull((String)g2.get(k));
						//out.println("temp for name========="+k+" value "+temp);
							if (temp.trim().equalsIgnoreCase("fin_audit"))
							{
								//out.println("before assigning========="+k+" value "+temp);
								temp = "Audited";
								//out.println("after assigning========="+k+" value "+temp);
							}
							else if (temp .trim().equalsIgnoreCase("fin_unaudit"))
							{
								//out.println("before assigning========="+k+" value "+temp);
								temp = "Unaudited";
								//out.println("after assigning========="+k+" value "+temp);
							}
							else if (temp.trim().equalsIgnoreCase("fin_estimated"))
							{
								temp = "Estimated";
							}
							else if (temp.trim().equalsIgnoreCase("fin_projection"))
							{
							temp = "Projection";
							}
						
						comboselect[n]=temp;
						n = n+1;
						//out.println("//n value "+n+"//");
					}	 		
			}
			
			for (int d = 0 ; d < sizeyearval ; d++)
			 {
				//out.println("//sizeyearval=========="+sizeyearval);
				//out.println("//comboselect=========="+comboselect[d]);
				if (comboselect[d] == null)
				 {
				comboselect[d] = "";
				
				 }
				//out.println("//yearval=========="+yearval[d]);
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
				 //out.println("//comboselect in else condition=========="+comboselect[p]);
				comboselect[p]= "";		
				yearval[p]= "";
				// out.println("//yearval in else condition=========="+yearval[p]);
			 }
		 }
		 %>
		 
		 <%
		 int q=0,t=0;
		// out.println("//intSection_count before loop=========="+intSection_count);
		 for(int s=0;s<intSection_count;s++)
			{ 
			 //out.println("//intSection_count=========="+intSection_count);
			 //out.println("//s vslue =========="+s);
			if(s==0)
			{
				p=0;t=5;
			if(sizeyearval<5)
				//out.println("[sizeyearval value is=========="+sizeyearval+"]");
				t=sizeyearval;
			//out.println("[inside if condtion t value is=========="+t+"]");
			}
			if (g2.size() >0){
		 %>
                    <table width="100%" border="1" cellspacing="0" cellpadding="3" align="center">
                 <tr>
                 <td align="center" rowspan="5"><b>Particulars</b></td>
                 <td align="center" colspan="2"><b>Existing Units</b></td>
                 <td align="center" colspan="2"><b>Greenfield Units</b></td>
                 </tr>
                 
                  <tr>
                 <td align="center" colspan="2"><b>[Past Financials (latest audited)]</b></td>
                 <td align="center" colspan="2"><b>[Projected Financials (1st full year of operations)]</b></td>
                 </tr>
                 
                    <tr>
                     <td align="center" colspan="5"><b><%=loanmodule %></b>
                    </td>
                    </tr>
                        
                      <tr> 
                        
                        <%for(q=p;q<t;q++)
                        	{
                        	if(!yearval[q].equalsIgnoreCase(""))
                        	{
                        		%>
                        		
                        		 <td width="15%" align="center"> <b><%=yearval[q]%></b>&nbsp;</td>
                        		<%
                        	}
                        	}%>
                      </tr>
                      <tr> 
                        
                          <%for(q=p;q<t;q++)
                        	{
	                        	if(!comboselect[q].trim().equalsIgnoreCase("")) {
	                        	%>
		                        	
		                        		
		                        		 <td width="15%" align="center"> <%=comboselect[q]%>&nbsp;</td>
		                        		<%
		                        	
	                        	}}%>
                      </tr>
                      <%
					  ArrayList v = (ArrayList) hshRecord.get("labeldetails");
                      ArrayList v0 = (ArrayList) hshRecord1.get("labeldetails");
                      ArrayList v1 = (ArrayList) hshRecord2.get("labeldetails");
                      
                      //out.println("v========"+v);
                      //out.println("v0========"+v0);
                      //out.println("v1========"+v1);
                      
                      
                      //out.println("[labeldetails value is=========="+v+"]");
                      
                      
                      ArrayList vecRow=new ArrayList();
                      ArrayList vecId=new ArrayList();
                      
                      ArrayList vecRow1=new ArrayList();
                      ArrayList vecId1=new ArrayList();
                      
                      
                     // out.println("[sizeyearval1 value is=========="+sizeyearval1+"]");
                     
                     
                      for(int k=1;k<=sizeyearval1;k++)
                      {
                    	  //out.println("[vecRow value inside for loop is"+k+"=========="+v+"]");
                    	  
                    	  
                    	  vecRow=(ArrayList) hshRecord.get("year"+k);
                    	  
                    	  vecRow1=(ArrayList) hshRecord2.get("year"+k);//new 2
                    	  
                      }
                    //  out.println("[vecRow1 value from h2 is=========="+vecRow1+"]");
                      //out.println("[vecRow1 value from h2 is=========="+vecRow1+"]");
                      
                      
						String finval="",colval1="";
						String colval2="",colval3="",colval4="",colval5="",strtype="",strtype1="";
						int vecsize=0,count=1,yearsize=0,finsize=0,finsize1=0,startsize=0,vecsize1=0,yearsize1=0;
						String colid="",rowid="",colid1="",rowid1="";
							if(v!=null)
							{
								vecsize =v.size();
								 //out.println("[vecsize i if condition value is=========="+vecsize+"]");
							}
							
							if(v1!=null)//new
							{
								vecsize1 =v1.size();
								// out.println("[vecsize i if condition value is=========="+vecsize+"]");
							}
							
							
							
							if (vecRow != null)
							{
								yearsize = vecRow.size();
								//out.println("[yearsize i if condition value is=========="+vecRow.size()+"]");
							}
							
							if (vecRow1 != null)
							{
								yearsize1 = vecRow1.size();
								//out.println("[yearsize1 in if condition value is=========="+yearsize1+"]");
							}
							
							
							
							
							
							if (yearsize == vecsize)
							{
								finsize = vecsize;
								//out.println("if two condition same [finsize  if condition value is=========="+finsize+"]");
							}
							else if(yearsize < vecsize)
							{
								finsize = yearsize;
								//out.println("[finsize i if condition value is=========="+finsize+"]");
							}
							
							
							if (yearsize1 == vecsize1)
							{
								finsize1 = vecsize1;
								//out.println("if two condition same [finsize1  if condition value is=========="+finsize1+"]");
							}
							else if(yearsize1 < vecsize1)
							{
								finsize1 = yearsize1;
								//out.println("[finsize1 in if condition value is=========="+finsize1+"]");
							}
							
							
							
							
							
							
							
							
							
				for(int l=0;l<finsize;l++)
				{
					
					g1 = (ArrayList)v.get(l);
					
					System.out.println("[g1 value  value is"+l+"=========="+g1+"]");
					
					colid = Helper.correctNull((String)g1.get(0));
					//out.println("[colid value  value is"+l+"=========="+colid+"]");
					colid=colid.trim();
					
					System.out.println("[colid value from h1"+l+" "+colid+"]");
					//System.out.println(l);
					
					String temp1[]={"520","580","583","632","579"};
					
					//out.println("colid from h1====="+colid);
					
					for(int m=0;m<=temp1.length-1;m++)
					{
						
						
						//System.out.println("//////////////////////inside my for loop"+colid+"strtype value is//////////////"+temp1[m]);
						
						if(colid.equalsIgnoreCase(temp1[m]))
						{
							//System.out.println("//////////////////////inside my if condition"+colid+"strtype value is//////////////"+temp1[m]);
												
						
					strtype=Helper.correctNull((String)g1.get(2));
					
					
					
					%>
                     
                     <%if(!strtype.equalsIgnoreCase("HE")) { %>
					
					
                     
                      <tr> 
                        <td width="32%" align="left">  
                          <%if(strtype.equalsIgnoreCase("C")){ %>
                          <b><%=Helper.correctNull((String)g1.get(1))%>&nbsp;</b>
                          <%}else{ %>
                          <%=Helper.correctNull((String)g1.get(1))%>&nbsp;
                          <%} %> 
                          
                          
                          
                        </td>
                        
                         <% for(q=p;q<t;q++)
                         {
                          	  vecRow=(ArrayList) hshRecord.get("year"+(q+1));
                          	  vecId=(ArrayList) hshRecord.get("vecid"+(q+1));
                            
       						//out.println("=====vecId====from h==="+vecId);
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
                            <%}%>
                      <%}
       					 else{%>
       					  <td  width="15%" align="right">0.00&nbsp;</td>
       					<% }
       					 }%>
                         </tr>
                    	 <%}else{%>
                    		 <tr> 
                        <td  align="left" colspan="<%=t+1 %>">  
                         <B> <%=Helper.correctNull((String)g1.get(1))%>&nbsp; </B>
                        </td>
                        </tr>
                    	<% }	}
			}
			}
						 %>
						 
						
						
												 
						 
						 
					<%	 
						 for(int l=0;l<finsize1;l++)
						 {
					
					g4 = (ArrayList)v1.get(l);
					
					System.out.println("[g4 value is"+l+"=========="+g4+"]");
					
					colid1 = Helper.correctNull((String)g4.get(0));
					
					System.out.println("[colid1 value from h2"+l+" "+colid1+"]");
					
					//out.println("colid from h2====="+colid1);
					
					colid1=colid1.trim();
					
					//System.out.println("//////////////////////outside my for loop strtype value is//////////////"+colid);
					//System.out.println(l);
					
					String temp2[]={"520","580","583","632","579","513","515","516","521"};
					
					for(int m=0;m<temp2.length;m++)
					{
						
						
						//System.out.println("//////////////////////inside my for loop"+colid+"strtype value is//////////////"+temp1[m]);
						
						if(colid1.equalsIgnoreCase(temp2[m]))
						{
							//System.out.println("//////////////////////inside my if condition"+colid+"strtype value is//////////////"+temp1[m]);
												
						
					strtype1=Helper.correctNull((String)g4.get(2));
					
					//out.println("[strtype1 value  value is"+l+"=========="+strtype1+"]");
					
					%>
                     
                     <%if(!strtype1.equalsIgnoreCase("HE")) { %>
					
					
                     
                      <tr> 
                        <td width="32%" align="left">  
                          <%if(strtype1.equalsIgnoreCase("C")){ %>
                          <b><%=Helper.correctNull((String)g4.get(1))%>&nbsp;</b>
                          <%}else{ %>
                          <%=Helper.correctNull((String)g4.get(1))%>&nbsp;
                          <%} %> 
                          
                          
                          
                        </td>
                        
                         <% for(q=p;q<t;q++)
                         {
                          	  vecRow1=(ArrayList) hshRecord2.get("year"+(q+1));
                          	  vecId1=(ArrayList) hshRecord2.get("vecid"+(q+1));
                        		
                          	  //out.println("////vecRow1 from h2=============="+vecRow1);
                          	//out.println("////vecId1 from h2 =============="+vecId1);
       					
       					 if (vecRow1 != null && vecId1 != null)
       						{
       							rowid1=Helper.correctDouble((String)vecId.get(l));
       							String colval="";
       							rowid1=rowid1.trim();
       							if (rowid1.equals(colid1))
       							{
       								//out.println("rowid1 inside if condition==="+rowid1);
       								colval=nft.format(Double.parseDouble(Helper.correctDouble((String)vecRow1.get(l))));
       							}
       							else
       							{
       								colval = "0.00";
       							}
                         if(!strtype1.equalsIgnoreCase("HE")){ 
                         %>
                         <%if(!yearval[q].equalsIgnoreCase("")){%>
                        <td  width="15%" align="right"><%=colval%></td><%} %>
                            <%}%>
                      <%}
       					 else{%>
       					  <td  width="15%" align="right">0.00&nbsp;</td>
       					<% }
       					 }%>
                         </tr>
                    	 <%}else{%>
                    		 <tr> 
                        <td  align="left" colspan="<%=t+1 %>">  
                         <B> <%=Helper.correctNull((String)g4.get(1))%>&nbsp; </B>
                        </td>
                        </tr>
                    	<% }	}
			}
			}
						 %>
						 
						 
						 
						 
						 
						 
						 
						 
						 
						 
						 
						 
						 
						 
						 
						 
						 
						 
						 
						 
						 
						 
						 
						 <%
						 if(flag){
						 startsize = finsize ;
						 System.out.println("flag=="+startsize);
						 System.out.println("startsize=="+startsize);
						 System.out.println("finsize=="+finsize);
						 if(yearsize < vecsize)
						 {
							 for(int l=startsize;l<vecsize;l++)
								{									
								g1 = (ArrayList)v.get(l);
								
								strtype=Helper.correctNull((String)g1.get(2));%>
								<tr> 
                        <td width="32%" align="left">  
                          
                          
                           <%if(strtype.equalsIgnoreCase("HE")){ %>
                          
                         <B> <%=Helper.correctNull((String)g1.get(1))%>&nbsp; </B>
                          
                          <%} else { %>
                          <%=Helper.correctNull((String)g1.get(1))%>&nbsp; 
                          
                          <%} %>
                          
                          
                          
                        </td>
                        
                         <% for(q=p;q<t;q++)
                         {
                          	  vecRow=(ArrayList) hshRecord.get("year"+(q+1));
                          	  vecId=(ArrayList) hshRecord.get("vecid"+(q+1));
                            
       					
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
								
								<%}
						 }}
						 %>
                    
                    <%}else{ %>
                    <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center">
                      <tr> 
                        <td style="border: none;">Nil 
                        </td>
                        </tr>
                    </table>
                    </table>
                    </td></tr></table>
                    
                    <%} %>
                    <br>
<%
sizeyearval=sizeyearval-5;
p=p+5;
if(sizeyearval>5)
{
	t=t+5;
}
else
{
	t=t+sizeyearval;
}
}
		 }
 %>