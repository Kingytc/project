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
if(hshValues!=null)
	hshRecord=(HashMap)hshValues.get(request.getParameter("pagevalue"));
if(Helper.correctNull(request.getParameter("pagevalue")).equalsIgnoreCase("hshReqValues3") || 
		Helper.correctNull(request.getParameter("pagevalue")).equalsIgnoreCase("hshReqValues2") || 
	Helper.correctNull(request.getParameter("pagevalue")).equalsIgnoreCase("hshReqValues1") ||  Helper.correctNull(request.getParameter("pagevalue")).equalsIgnoreCase("hshReqValues")||Helper.correctNull(request.getParameter("pagevalue")).equalsIgnoreCase("hshReqValues4") || Helper.correctNull(request.getParameter("pagevalue")).equalsIgnoreCase("hshReqValues_PROP")||Helper.correctNull(request.getParameter("pagevalue")).equalsIgnoreCase("hshReqValues3"))
	
{
	  String bgclr="";

	  int p=0,sizeyear=0,from=0,to=0,vecModSize  =0,sizeyearval=5,sizeyearval1=5;
	   String temp="",totcount="",upto="",pageval="",strCurModule="";
	  
		totcount = Helper.correctNull((String)hshRecord.get("totalyear"));
		upto = Helper.correctNull((String)hshRecord.get("upto"));
		pageval=Helper.correctNull((String)hshRecord.get("page"));
		strCurModule = pageval;
		
		ArrayList g1= new ArrayList();
		ArrayList g2= new ArrayList();
		ArrayList g3= new ArrayList();
		g2=(ArrayList) hshRecord.get("yearvalue");
		g3  = (ArrayList) hshRecord.get("value");
		ArrayList	vecModule = (ArrayList)hshRecord.get("tabdetails");
		boolean flag=false;
		if(vecModule!=null)
		vecModSize = vecModule.size();
		if (g2.size() != 0)
		 {
			flag=true;
			 sizeyear=g2.size();
			 sizeyearval=sizeyear/2;
			 sizeyearval1=sizeyearval;
		 }
		String yearval[] = new String[sizeyearval];
		String comboselect[] = new String[sizeyearval];
		
		int intSection_count=0;
		int intQuotient = (sizeyearval / 5);
		int intRemainder = (sizeyearval % 5);
		if(sizeyearval > 5)
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
							if (temp.trim().equalsIgnoreCase("fin_audit"))
							{
								temp = "Audited";
							}
							else if (temp .trim().equalsIgnoreCase("fin_unaudit"))
							{
								temp = "Unaudited";
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
					}	 		
			}
			
			for (int d = 0 ; d < sizeyearval ; d++)
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
		 %>
		 
		 <%
		 int q=0,t=0;
		 for(int s=0;s<intSection_count;s++)
			{ 
			if(s==0)
			{p=0;t=5;
			if(sizeyearval<5)
				t=sizeyearval;
			}
			if (g2.size() >0){
		 %>
                    <table width="100%" border="1" cellspacing="0" cellpadding="3" align="center">
                      <tr> 
                        <td align="center"><b></b><b>Particulars</b> 
                        </td>
                        
                        
                         <%for(q=p;q<t;q++)
                        	{
                        	if(!yearval[q].equalsIgnoreCase(""))
                        	{
                        		%>
                        		
                        		 <td width="15%" align="center"> &nbsp;</td>
                        		<%
                        	}
                        	}%>
                      </tr>
                      <tr> 
                        <td >&nbsp; </td>
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
                        <td >&nbsp; </td>
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
                      ArrayList vecRow=new ArrayList();
                      ArrayList vecId=new ArrayList();
                      for(int k=1;k<=sizeyearval1;k++)
                      {
                    	  vecRow=(ArrayList) hshRecord.get("year"+k);
                      }
		
						String finval="",colval1="";
						String colval2="",colval3="",colval4="",colval5="",strtype="";
						int vecsize=0,count=1,yearsize=0,finsize=0,startsize=0;
						String colid="",rowid="";
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
					
						
					strtype=Helper.correctNull((String)g1.get(2));%>
                     
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
						 %>
						 
						 <%
						 if(flag){
						 startsize = finsize ;
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
                    </table>
                    <%}else{ %>
                    <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center">
                      <tr> 
                        <td style="border: none;">Nil 
                        </td>
                        </tr>
                    </table>
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