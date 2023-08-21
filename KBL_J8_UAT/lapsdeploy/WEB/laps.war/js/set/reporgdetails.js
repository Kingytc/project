function runrep()
{
	var param = setParam();
	var outf =document.forms[0].hidOpFields.value;
	var dbf =document.forms[0].hidSelFields.value;	 
	var lev =document.forms[0].bnklevel.value;
	var code =document.forms[0].hidOrgCode.value;
	var dt =document.forms[0].txtDate.value;

	if (param !="")
	{
		window.open(path+"action/runorgdetails.jsp?hidBeanId=setupreport&hidBeanMethod=getData&hidMethod=getSubLevels&txtDate="+dt+"&bnklevel="+lev+"&hidOrgCode="+code+"&hidOpFields="+outf+"&hidSelFields="+dbf,"Prod","scrollbars=Yes,toolbars=No,menubar=no ,width=750 , height=550,top=10,left=10");
	}
		
	
}

function save()
{
	var purl="";
	var title = "SaveReport";
	var prop = "scrollbars=no,width=350,height=320";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 320) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	
	var usrid =userid;
	var beanid ="repData";
	var action="Insert";
	var source="/action/orgdetrep.jsp";
	var repname=document.forms[0].repname.value;
	
	var param = setParam();
	if (param !="")
	{
		purl =path+"action/savereport.jsp?BeanId="+beanid+"&Action="+action;
		purl +="&Source="+source+"&repname="+repname+"&param="+param;
		window.open(purl,title,prop);
	}
}

function setParam()
{
	var opfields="";
	var dbfields="";
	var orgcode="";
	var orgname="";
	var count=0;
	param="";
	
	if(document.forms[0].sellevel.selectedIndex != 0 && document.forms[0].rpselect1.selectedIndex != -1 ) 
	{
		
	for (i=0;i<document.forms[0].rpselect2.length;i++)
        {
			if (document.forms[0].rpselect2.options[i].selected == true)
			{
				count++;
			}
        }
		if(count < 6)
		{
			for(i=0;i<6;i++)
			{
				document.forms[0].rpselect2.options[i].selected = true;
			}
		}

	orgcode =document.forms[0].rpselect1.options[document.forms[0].rpselect1.selectedIndex].value;
   
    param =orgcode+";";
	
	
		for(x=0;x<document.forms[0].rpselect2.length;x++)
		{
			if (document.forms[0].rpselect2[x].selected)
			{
				count++;
				opfields =opfields +document.forms[0].rpselect2.options[x].value+",";
				dbfields =dbfields +document.forms[0].rpselect2.options[x].text+",";
							
			}
		}
		if (count > 0)
		{
			dbfields= dbfields.substring(0,dbfields.length-1);
			opfields= opfields.substring(0,opfields.length-1);
		}
	
	param +=opfields+";";
	param +=dbfields;

	document.forms[0].hidParam.value=param;
	document.forms[0].bnklevel.value =orgcode.substring(0,1);	
	document.forms[0].hidOrgCode.value =orgcode.substring(orgcode.indexOf("-")+1,orgcode.length);	
	document.forms[0].hidOpFields.value =opfields;	
	document.forms[0].hidSelFields.value =dbfields;	
	}
	else if(document.forms[0].sellevel.selectedIndex == 0)
	{
		ShowAlert('111',"Organisation Level");
		document.forms[0].sellevel.focus();
		return false;
	}
	else if(document.forms[0].rpselect1.selectedIndex == -1)
	{
		ShowAlert('111','Organisation');
		document.forms[0].rpselect1.focus();
		return false;
	}
	
	return param;
}

function browse()
{
	var user=userid;
	var purl="";
	var title = "BrowseReport";
	var prop = "scrollbars=no,width=400,height=300";	
	var xpos = (screen.width - 400) / 2;
	var ypos = (screen.height - 320) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	purl =path+"action/browsereport.jsp?BeanId= repData&userid="+user+"&method=getProfileNames&repname=Organisation Report";
	window.open(purl,title,prop);
}

function resetValues()
{
	document.forms[0].sellevel.options[0].selected =true;
	document.forms[0].rpselect1.length =0;

}
function closeWindow()
{
	if (ConfirmMsg("100"))
	{
	document.forms[0].action=path+"action/setuprepnav.jsp";
	document.forms[0].submit();
	}
}


function selectValues()
{
	bnkname = document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].value;
    var curr = rights.substring(6,1);
	var child =rights.substring(7,1);
	var other =rights.substring(8,1);
	document.all.ifrm.src=path+"action/iframeorgrep.jsp?hidBeanMethod=getData&hidMethod=getListValues&hidBeanId=setupreport&bnklevel="+bnkname;
}

