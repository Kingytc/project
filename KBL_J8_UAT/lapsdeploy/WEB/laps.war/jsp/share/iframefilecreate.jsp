<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
<%

String strMethod=request.getParameter("hidMethod");

ArrayList vecVal=null;
ArrayList vecR = null;
ArrayList vecTemp=null;
String vecDate="";
String x=null;
String strgraphname=request.getParameter("hidgraphname");
String strgraphcode=request.getParameter("hidgraphcode");
String strgraphtype=request.getParameter("hidgraphtype");
String strContent="";
boolean boolpending=true;
boolean boolapproved=true;
boolean boolapproved1=true;
boolean boolrejected=true;
int i=0;
double statno=0.0;
double statno1=0.0;
double statno2=0.0;
if(strMethod.equals("getRepDetails"))
{
vecVal =(ArrayList)hshValues.get("vecValues");

vecDate=(String)hshValues.get("txtDate");

if(strgraphcode.equalsIgnoreCase("A"))
{	
	String status=null;
	String statusno="";
	String statustype="";
	vecR = new ArrayList();
	vecTemp=new ArrayList();
	for(i=0;i<vecVal.size();i++)
	{vecR  =(ArrayList)vecVal.get(i);
	 vecTemp.add(vecR.get(1));
	}
	boolpending=vecTemp.contains("OP");
	boolapproved=vecTemp.contains("PA");
	boolapproved1=vecTemp.contains("CA");
	boolrejected=vecTemp.contains("PR");
	if(boolpending==false)
	{	 statusno=statusno+"0"+"&";
		 statustype=statustype+"Pending"+"&";
		 statno=statno+0;
	}
	if(boolapproved==false && boolapproved1==false)
	{
		statusno=statusno+"0"+"&";
		 statustype=statustype+"Approved"+"&";
 		 statno=statno+0;
	}
	
	if(boolrejected==false)
	{	 statusno=statusno+"0"+"&";
		 statustype=statustype+"Rejected"+"&";
 		 statno=statno+0;
	}
	
	int appcount =0;
	int cnt=0;

	for(i=0;i<vecVal.size();i++)
	{ 	 vecR = new ArrayList();
		 vecR  =(ArrayList)vecVal.get(i);
		 status=(String)vecR.get(1);
		 x=(String)vecR.get(0);
		 
		if(status.equalsIgnoreCase("OP"))
		{
		 statusno=statusno+(String)vecR.get(0)+"&";
		 statustype=statustype+"Pending"+"&";
		 statno=statno+Integer.parseInt((String)vecR.get(0));
		
		}
		if(status.substring(1,2).equals("A"))
		{
			if(status.equalsIgnoreCase("PA"))
			{
				appcount =appcount+ Integer.parseInt((String)vecR.get(0));
			}
			if(status.equalsIgnoreCase("CA"))
			{
				appcount =appcount+ Integer.parseInt((String)vecR.get(0));
			}
		 cnt=cnt+1;
		 
		}
		if(status.equalsIgnoreCase("PR"))
		{
		 statusno=statusno+(String)vecR.get(0)+"&";
		 statustype=statustype+"Rejected"+"&";
		 statno=statno+Integer.parseInt((String)vecR.get(0));
		}
		
	}
	if (cnt >0)
	{
	 statusno=statusno+appcount+"&";
	 statustype=statustype+"Approved"+"&";
	}
	strContent="3&"+statusno+statustype+"No. Of Applications&"+strgraphtype+"&"+strgraphname+".grh";
	
}

else if(strgraphcode.equalsIgnoreCase("P"))
{	
	String totval="";
	String orgname="";
	String totnoorg="";
	String temptotval="";
	String temporgname="";
	String organisations="";
	String []org=null;
	String temp="";
	String formby="";
	boolean boolorg=true;
	statno=0;
	totnoorg=(String)hshValues.get("strnooforg");
	organisations=request.getParameter("hidorgname");
	temp=request.getParameter("hidby");
	
	if(temp.equalsIgnoreCase("V"))
	{formby="Values in Rs.";
	}
	else if(temp.equalsIgnoreCase("N"))
	{formby="No of Applications";
	}

	StringTokenizer st=new StringTokenizer(organisations,",");
	i=0;
	org=new String[st.countTokens()];
	while(st.hasMoreTokens())
	{	org[i]=st.nextToken();
	
		i++;
	}

	vecR = new ArrayList();
	vecTemp=new ArrayList();
	for(i=0;i<vecVal.size();i++)
	{vecR  =(ArrayList)vecVal.get(i);
	 vecTemp.add(vecR.get(1));
	}
	


	for(i=0;i<vecVal.size();i++)
	{ 	 vecR = new ArrayList();
		 vecR  =(ArrayList)vecVal.get(i);
		
		 temptotval=(String)vecR.get(0);
		
		 statno2 =  Double.parseDouble((String)vecR.get(0));
         statno1 = statno1 + statno2;
		 //statno2=statno2+statno1.floatValue();
		
		 temporgname=(String)vecR.get(1);
		 totval=totval+temptotval+"&";
		 orgname=orgname+temporgname+"&";


	}
	
	for(i=0;i<org.length;i++)
	{	boolorg=vecTemp.contains(org[i]);
		if(boolorg==false)
		{
		 totval=totval+"0"+"&";
		 orgname=orgname+org[i]+"&";
		
		}
	}

	strContent=totnoorg+"&"+totval+orgname+formby+"&"+strgraphtype+"&"+strgraphname+".grh";
	
}
else if(strgraphcode.equalsIgnoreCase("D"))
{

String totval="";
String orgname="";
String totnoorg="";
String temptotval="";
String temporgname="";
String organisations="";
String []org=null;
String temp="";
String formby="";
boolean boolorg=true;
statno=0;
totnoorg=(String)hshValues.get("strnooforg");

organisations=request.getParameter("hidorgname");
temp=request.getParameter("hidby");

if(temp.equalsIgnoreCase("V"))
{formby="Values in Rs.";
}
else if(temp.equalsIgnoreCase("N"))
{formby="No of Delinquent Loans";
}
StringTokenizer st=new StringTokenizer(organisations,",");
i=0;
org=new String[st.countTokens()];
while(st.hasMoreTokens())
{	org[i]=st.nextToken();

	i++;
}

vecR = new ArrayList();
vecTemp=new ArrayList();
for(i=0;i<vecVal.size();i++)
{vecR  =(ArrayList)vecVal.get(i);
 vecTemp.add(vecR.get(1));
}




for(i=0;i<vecVal.size();i++)
{ 	 vecR = new ArrayList();
	 vecR  =(ArrayList)vecVal.get(i);
	 
	 temptotval=(String)vecR.get(0);
	 
	 statno1 =  Double.parseDouble((String)vecR.get(0));
	 statno2 = statno2 + statno1;
	 temporgname=(String)vecR.get(1);
	  totval=totval+temptotval+"&";
		 orgname=orgname+temporgname+"&";
	// totval=temptotval+"&";
	 //orgname=temporgname+"&";
}



for(i=0;i<org.length;i++)
{	boolorg=vecTemp.contains(org[i]);
	if(boolorg==false)
	{
	 totval=totval+"0"+"&";
	 orgname=orgname+org[i]+"&";
	}
}

strContent=totnoorg+"&"+totval+orgname+formby+"&"+"bar"+"&"+strgraphname+".grh";



}

}
%>
<HTML>
<HEAD>
<TITLE> New Document </TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
</HEAD>
<script>
var path ="<%=ApplicationParams.getAppUrl()%>";
function onloading()
{	if("<%=strgraphcode%>"=="A")
	{	if("<%=statno%>"=="0"&&"<%=strMethod%>"=="getRepDetails")
		{
			alert("No Data Found");
		}
		else if("<%=strMethod%>"=="getRepDetails")
		{
			document.forms[0].action=path+"controllerservlet";
			document.forms[0].hidBeanId.value="graphicalreports";
			document.forms[0].hidBeanMethod.value="getData";
			document.forms[0].hidMethod.value="getCreateFile";
			document.forms[0].hidgraphname.value="<%=strgraphname%>";
			document.forms[0].hidgraphtype.value="<%=strgraphtype%>";
			document.forms[0].hidfilecontent.value="<%=strContent%>";
			document.forms[0].hidSourceUrl.value="/action/iframeshowgraph.jsp";
			document.forms[0].submit();
			<%=strMethod%>="";
		}
	}
	else if("<%=strgraphcode%>"=="P")
	{
		if("<%=statno1%>"==0 &&"<%=strMethod%>"=="getRepDetails")
			{	alert("No Data Found");
			}
		else if("<%=strMethod%>"=="getRepDetails")
		{	document.forms[0].action=path+"controllerservlet";
			document.forms[0].hidBeanId.value="graphicalreports";
			document.forms[0].hidBeanMethod.value="getData";
			document.forms[0].hidMethod.value="getCreateFile";
			document.forms[0].hidgraphname.value="<%=strgraphname%>";
			document.forms[0].hidgraphtype.value="<%=strgraphtype%>";
			document.forms[0].hidfilecontent.value="<%=strContent%>";
			document.forms[0].hidSourceUrl.value="/action/iframeshowgraph.jsp";
			document.forms[0].submit();
			<%=strMethod%>="";
		}
	 }
	else if("<%=strgraphcode%>"=="D")
	{
		if("<%=statno2%>"==0 &&"<%=strMethod%>"=="getRepDetails")
			{	alert("No Data Found");
			}
		else if("<%=strMethod%>"=="getRepDetails")
		{	document.forms[0].action=path+"controllerservlet";
			document.forms[0].hidBeanId.value="graphicalreports";
			document.forms[0].hidBeanMethod.value="getData";
			document.forms[0].hidMethod.value="getCreateFile";
			document.forms[0].hidgraphname.value="<%=strgraphname%>";
			document.forms[0].hidgraphtype.value="<%=strgraphtype%>";
			document.forms[0].hidfilecontent.value="<%=strContent%>";
			document.forms[0].hidSourceUrl.value="/action/iframeshowgraph.jsp";
			document.forms[0].submit();
			<%=strMethod%>="";
		}
	 }
 }
</script>
<BODY onload="onloading()" method="post">
<form name="frmfilecreate">

<input type="hidden" name="hidBeanId">
<input type="hidden" name="hidBeanMethod">
<input type="hidden" name="hidMethod">
<input type="hidden" name="hidSourceUrl">
<input type="hidden" name="hidgraphname">
<input type="hidden" name="hidgraphtype">
<input type="hidden" name="hidfilecontent">

</form>
</BODY>
</HTML>
