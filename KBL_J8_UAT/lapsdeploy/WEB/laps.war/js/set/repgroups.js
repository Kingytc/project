function doRunReport()
{
	var param = setParam();
	var outf =document.forms[0].hidOpFields.value;
	var dbf =document.forms[0].hidSelFields.value;	 
	var code =document.forms[0].hidGrpName.value;
	var dt =document.forms[0].txtDate.value;
	if (param !="")
	{
		window.open(path+"action/rungroupsrep.jsp?hidBeanId=repgroup&hidBeanMethod=getData&hidMethod=getRepDetails&hidGrpName="+code+"&txtDate="+dt+"&hidOpFields="+outf+"&hidSelFields="+dbf,"Prod","scrollbars=Yes,toolbars=No,menubar=no ,width=750 , height=550,top=10,left=10");
	}
		
	
}

function doSave()
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
	var source="/action/repsupuser.jsp";
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
	var org="";
	var count=0;
	param="";
	
	if(document.forms[0].rpselect1.selectedIndex != -1 ) 
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
			for(i=0;i<2;i++)
			{
				document.forms[0].rpselect2.options[i].selected = true;
			}
		}
		count =0;
		document.forms[0].rpselect2.options[1].selected = true;
	   	for(x=0;x<document.forms[0].rpselect1.length;x++)
		{
			if (document.forms[0].rpselect1[x].selected)
			{
				count++;
				var c = document.forms[0].rpselect1.options[x].value;
				org =org +c+",";
			}
		}
		if (count > 0)
		{
			org= org.substring(0,org.length-1);
		}
		param += org+";";
		count=0;
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

	document.forms[0].hidparam.value=param;
	document.forms[0].hidGrpName.value =org;	
	document.forms[0].hidOpFields.value =opfields;	
	document.forms[0].hidSelFields.value =dbfields;	
	}
	else if(document.forms[0].rpselect1.selectedIndex == -1)
	{
		ShowAlert("111","Group Name[s]");
		document.forms[0].rpselect1.focus();
		return false;
	}
	
	return param;
}

function doReset()
{
	document.forms[0].reset();
}


function doClose()
{
	if (ConfirmMsg("100"))
	{
	document.forms[0].action=path+"jsp/set/setuprepnav.jsp";
	document.forms[0].submit();
	}
}


