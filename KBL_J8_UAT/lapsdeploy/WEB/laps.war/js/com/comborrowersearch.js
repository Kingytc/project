function doSearch()
{
	var area1="";
	var area2="";
	var area3="";
	var area4="";
	var area5="";
	if (document.forms[0].cat[3].checked){
	if(orglevel == "C")
	{	
		area2 = document.forms[0].hidarea2.value;
		if(area2=="")
		{
			alert("Select a Region");
			return;
		}
		area3=document.forms[0].hidarea3.value;
		if(area3=="")
		{
			alert("Select a CLPU");
			return;
		}
		area4=document.forms[0].hidarea4.value;
		if(area4=="")
		{
			alert("Select a Branch");
			return;
		}
	}
	else if(orglevel == "R")
	{
		area3=document.forms[0].hidarea3.value;
		if(area3=="")
		{
			alert("Select a CLPU");
			return;
		}
		area4=document.forms[0].hidarea4.value;
		if(area4=="")
		{
			alert("Select a Branch");
			return;
		}
	}
	else if(orglevel == "D")
	{
		area4=document.forms[0].hidarea4.value;
		if(area4=="")
		{
			alert("Select a Branch");
			return;
		}
	}
	else if(orglevel == "A")
	{
		area4=level;
		if(area4=="")
		{
			alert("Select a Branch");
			return;
		}
	}
	}
	scode="";
	if(document.forms[0].cat[0].checked)
	{
		cat=1;
	}
	else if (document.forms[0].cat[1].checked)
	{
		cat=2;
	}
	else if (document.forms[0].cat[2].checked)
	{
		cat=3;
	}
	else if (document.forms[0].cat[3].checked)
	{
		cat=4;
	}
	else
	{
		alert("Select a search criteria to search");
		return;
	}
	
	hid_rowcount=document.forms[0].hid_rowcount.value;
	
	if(hid_rowcount=="")
	{
		hid_rowcount=0;
	}
	
	var txtval=document.forms[0].bow_name.value;
	var txtlen=txtval.length;

	if (cat==4)
	{
		if(txtval == "")
		{
			ShowAlert('121','Borrower Name');
			document.forms[0].bow_name.value="";
			document.forms[0].bow_name.focus();
			return false;
		}
		 if(txtlen<=2)
		 {
			 alert("Enter atleast 3 characters");
		     document.forms[0].bow_name.focus();
		     return;
	 	 }
	}
	else if(cat==3 && txtval=="")
	{
		ShowAlert('121','Proposal No.');
	     document.forms[0].bow_name.focus();
	     return;
	}
	else if(cat==2 && txtval=="")
	{
		ShowAlert('121','CBS Customer ID');
	     document.forms[0].bow_name.focus();
	     return;
	}
	else if(cat==1 && txtval=="")
	{
		ShowAlert('121','Application No');
	     document.forms[0].bow_name.focus();
	     return;
	}
	
    noofrows = document.forms[0].txt_noofrows.value;
    bow_name =  document.forms[0].bow_name.value;
    hidPageType = document.forms[0].hidPageType.value;
    hidPage=document.forms[0].hidPage.value;
	select_cat="";
	document.all.result.src=appURL+"action/comborrowerresult.jsp?hidBeanGetMethod=getBorrowerDetails&area1="+area1+"&scode="+scode+"&cat="+cat+"&select_cat="+select_cat+"&bow_name="+bow_name+"&area2="+area2+"&area3="+area3+"&area4="+area4+"&area5="+area5+"&hidPageType="+hidPageType+"&hid_rowcount="+hid_rowcount+"&noofrows="+noofrows+"&hidPage="+hidPage+"&varstrSessionModuleType="+varstrSessionModuleType;	
}