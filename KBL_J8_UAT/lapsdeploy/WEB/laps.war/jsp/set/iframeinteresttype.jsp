<%@include file="../share/directives.jsp"%>
<%
ArrayList arrRow=(ArrayList)hshValues.get("arrRow");
ArrayList arrCol=new ArrayList();
int intsize=0;
if(arrRow!=null)
	intsize=arrRow.size();
%>
<html>
<head>
<title>Untitled Document</title>

<script type="text/javascript">
var varModType="<%=Helper.correctNull((String)hshValues.get("strModType"))%>";
var varFacType="<%=Helper.correctNull((String)hshValues.get("strFacType"))%>";
var strIntType="<%=Helper.correctNull((String)hshValues.get("strIntType"))%>";
function loadValues()
{	
	<%if(arrRow!=null && intsize>0)
	{
		for(int i=0;i<intsize;i++)
		{
			arrCol=(ArrayList)arrRow.get(i);%>
			if(varModType=="AGR" || varModType=="CORP")
			{
				if(varFacType=="facility")
				{
					<%if(i==0){%>
						parent.frames.document.forms[0].sel_interesttype.length ="<%=intsize+1%>";
						parent.frames.document.forms[0].sel_interesttype.options[0].text="<----select---->";
						parent.frames.document.forms[0].sel_interesttype.options[0].value="";
					<%}%>
					parent.frames.document.forms[0].sel_interesttype.options[<%=i+1%>].text="<%=Helper.correctNull((String)arrCol.get(1))%>";
					parent.frames.document.forms[0].sel_interesttype.options[<%=i+1%>].value="<%=Helper.correctNull((String)arrCol.get(0))%>";
				}
				else
				{
					<%if(i==0){%>
						parent.frames.document.forms[0].sel_sub_interesttype.length ="<%=arrRow.size()+1%>";
						parent.frames.document.forms[0].sel_sub_interesttype.options[0].text="<----select---->";
						parent.frames.document.forms[0].sel_sub_interesttype.options[0].value="";
					<%}%>
					parent.frames.document.forms[0].sel_sub_interesttype.options[<%=i+1%>].text="<%=Helper.correctNull((String)arrCol.get(1))%>";
					parent.frames.document.forms[0].sel_sub_interesttype.options[<%=i+1%>].value="<%=Helper.correctNull((String)arrCol.get(0))%>";
				}
			}
			else
			{
				<%if(i==0){%>
					parent.frames.document.forms[0].sel_interesttype.length ="<%=arrRow.size()+1%>";
					parent.frames.document.forms[0].sel_interesttype.options[0].text="<----select---->";
					parent.frames.document.forms[0].sel_interesttype.options[0].value="";
				<%}%>
				parent.frames.document.forms[0].sel_interesttype.options[<%=i+1%>].text="<%=Helper.correctNull((String)arrCol.get(1))%>";
				parent.frames.document.forms[0].sel_interesttype.options[<%=i+1%>].value="<%=Helper.correctNull((String)arrCol.get(0))%>";
			}
		<%}
		
		if(intsize==1)
		{%>
		if(varModType=="AGR" || varModType=="CORP")
		{
			if(varFacType=="facility")
			{
				parent.frames.document.forms[0].sel_interesttype.options[1].selected=true;
			}
			else
			{
				parent.frames.document.forms[0].sel_sub_interesttype.options[1].selected=true;
			}
			
		}
		else
		{
			parent.frames.document.forms[0].sel_interesttype.options[1].selected=true;
		}
			
		<%}
	}
	else
	{%>
	
	if(varModType=="AGR" || varModType=="CORP")
	{
		if(varFacType=="facility")
		{
			parent.frames.document.forms[0].sel_interesttype.length =1;
			parent.frames.document.forms[0].sel_interesttype.options[0].text="<----select---->";
			parent.frames.document.forms[0].sel_interesttype.options[0].value="";
		}
		else
		{
			parent.frames.document.forms[0].sel_sub_interesttype.length =1;
			parent.frames.document.forms[0].sel_sub_interesttype.options[0].text="<----select---->";
			parent.frames.document.forms[0].sel_sub_interesttype.options[0].value="";
		}
	}
	else
	{
		parent.frames.document.forms[0].sel_interesttype.length =1;
		parent.frames.document.forms[0].sel_interesttype.options[0].text="<----select---->";
		parent.frames.document.forms[0].sel_interesttype.options[0].value="";
	}
	
	<%}%>

	if(varModType=="AGR" || varModType=="CORP")
	{
		
		if(varFacType=="facility")
		{
			if(strIntType!="")
			{
				parent.frames.document.forms[0].sel_interesttype.value=strIntType;
			}

		}
		else
		{
			if(strIntType!="")
			{
				parent.frames.document.forms[0].sel_sub_interesttype.value=strIntType;
			}
		}

		parent.frames.loadROIFields(varFacType);
	}
	else
	{
		if(strIntType!="")
		{
			parent.frames.document.forms[0].sel_interesttype.value=strIntType;
		}
		parent.frames.loadROIFields();
	}
}

</script>
</head>

<body bgcolor="#E4E2ED" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="appfrm" method="post">
</form>
</body>
</html>
