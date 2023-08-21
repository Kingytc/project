<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request"></jsp:useBean>

<%
ArrayList year1= new ArrayList();
ArrayList year2= new ArrayList();
ArrayList year3= new ArrayList();
ArrayList year4= new ArrayList();
ArrayList year5= new ArrayList();

year1 = (ArrayList) hshValues.get("year1");
year2 = (ArrayList) hshValues.get("year2");
year3 = (ArrayList) hshValues.get("year3");
year4 = (ArrayList) hshValues.get("year4");
year5 = (ArrayList) hshValues.get("year5");
String strAsLibFlag="";
if(hshValues!=null)
{
	strAsLibFlag=Helper.correctNull((String)hshValues.get("strTallyFlag"));
}


%>
<%
String y1="",y2="",y3="",y4="",y5="",y6="";
String y="";
String adds="&";

if (year1 != null)
{
for(int i=0;i<year1.size();i++)
{
	y1= y1+year1.get(i).toString()+",";
}
}
if(year2!=null)
{
	for(int i=0;i<year2.size();i++)
	{
		y2= y2+year2.get(i).toString()+",";
	}
}
if(year3!=null)
{
	for(int i=0;i<year3.size();i++)
	{
		y3= y3+year3.get(i).toString()+",";
	}
}
if(year4!=null)
{
	for(int i=0;i<year4.size();i++)
	{
		y4= y4+year4.get(i).toString()+",";
	}
}
if(year5!=null)
{
	for(int i=0;i<year5.size();i++)
	{
		y5= y5+year5.get(i).toString()+",";
	}
}
y6 = "@"+strAsLibFlag+"@";
y=y1+adds+y2+adds+y3+adds+y4+adds+y5;
%>
<%=y+y6%>
