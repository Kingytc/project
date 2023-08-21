
function calculate()
{
	// initialise calculated fields to zero
	for(var i=0;i<parent.frames.document.forms[0].txt_target_noofaccounts_calculated.length;i++)
	{
		parent.frames.document.forms[0].txt_target_noofaccounts_calculated[i].value=0;
		parent.frames.document.forms[0].txt_target_amount_calculated[i].value=0.0;
		parent.frames.document.forms[0].txt_sanctioned_noofaccounts_calculated[i].value=0;
		parent.frames.document.forms[0].txt_sanctioned_amount_calculated[i].value=0.0;
		parent.frames.document.forms[0].txt_outstanding_noofaccounts_calculated[i].value=0;
		parent.frames.document.forms[0].txt_outstanding_amount_calculated[i].value=0.0;
	}
	
	// Agriculture
	for(var i=3;i<5;i++)
	{
		parent.frames.document.forms[0].txt_target_noofaccounts_calculated[0].value= eval(parent.frames.document.forms[0].txt_target_noofaccounts_calculated[0].value)+eval(parent.frames.document.forms[0].txt_target_noofaccounts[i].value);
		parent.frames.document.forms[0].txt_target_amount_calculated[0].value= eval(parent.frames.document.forms[0].txt_target_amount_calculated[0].value)+eval(parent.frames.document.forms[0].txt_target_amount[i].value);
		parent.frames.document.forms[0].txt_sanctioned_noofaccounts_calculated[0].value= eval(parent.frames.document.forms[0].txt_sanctioned_noofaccounts_calculated[0].value)+eval(parent.frames.document.forms[0].txt_sanctioned_noofaccounts[i].value);
		parent.frames.document.forms[0].txt_sanctioned_amount_calculated[0].value= eval(parent.frames.document.forms[0].txt_sanctioned_amount_calculated[0].value)+eval(parent.frames.document.forms[0].txt_sanctioned_amount[i].value);
		parent.frames.document.forms[0].txt_outstanding_noofaccounts_calculated[0].value= eval(parent.frames.document.forms[0].txt_outstanding_noofaccounts_calculated[0].value)+eval(parent.frames.document.forms[0].txt_outstanding_noofaccounts[i].value);
		parent.frames.document.forms[0].txt_outstanding_amount_calculated[0].value=eval( parent.frames.document.forms[0].txt_outstanding_amount_calculated[0].value)+eval(parent.frames.document.forms[0].txt_outstanding_amount[i].value);
	}
	
	//MSME Enterprises
	for(var i=5;i<7;i++)
	{
		parent.frames.document.forms[0].txt_target_noofaccounts_calculated[1].value= eval(parent.frames.document.forms[0].txt_target_noofaccounts_calculated[1].value)+eval(parent.frames.document.forms[0].txt_target_noofaccounts[i].value);
		parent.frames.document.forms[0].txt_target_amount_calculated[1].value= eval(parent.frames.document.forms[0].txt_target_amount_calculated[1].value)+eval(parent.frames.document.forms[0].txt_target_amount[i].value);
		parent.frames.document.forms[0].txt_sanctioned_noofaccounts_calculated[1].value= eval(parent.frames.document.forms[0].txt_sanctioned_noofaccounts_calculated[1].value)+eval(parent.frames.document.forms[0].txt_sanctioned_noofaccounts[i].value);
		parent.frames.document.forms[0].txt_sanctioned_amount_calculated[1].value= eval(parent.frames.document.forms[0].txt_sanctioned_amount_calculated[1].value)+eval(parent.frames.document.forms[0].txt_sanctioned_amount[i].value);
		parent.frames.document.forms[0].txt_outstanding_noofaccounts_calculated[1].value= eval(parent.frames.document.forms[0].txt_outstanding_noofaccounts_calculated[1].value)+eval(parent.frames.document.forms[0].txt_outstanding_noofaccounts[i].value);
		parent.frames.document.forms[0].txt_outstanding_amount_calculated[1].value=eval( parent.frames.document.forms[0].txt_outstanding_amount_calculated[1].value)+eval(parent.frames.document.forms[0].txt_outstanding_amount[i].value);
	}
		
	// MSME Manufacturing
	for(var i=7;i<10;i++)
	{
		parent.frames.document.forms[0].txt_target_noofaccounts_calculated[2].value= eval(parent.frames.document.forms[0].txt_target_noofaccounts_calculated[2].value)+eval(parent.frames.document.forms[0].txt_target_noofaccounts[i].value);
		parent.frames.document.forms[0].txt_target_amount_calculated[2].value= eval(parent.frames.document.forms[0].txt_target_amount_calculated[2].value)+eval(parent.frames.document.forms[0].txt_target_amount[i].value);
		parent.frames.document.forms[0].txt_sanctioned_noofaccounts_calculated[2].value= eval(parent.frames.document.forms[0].txt_sanctioned_noofaccounts_calculated[2].value)+eval(parent.frames.document.forms[0].txt_sanctioned_noofaccounts[i].value);
		parent.frames.document.forms[0].txt_sanctioned_amount_calculated[2].value= eval(parent.frames.document.forms[0].txt_sanctioned_amount_calculated[2].value)+eval(parent.frames.document.forms[0].txt_sanctioned_amount[i].value);
		parent.frames.document.forms[0].txt_outstanding_noofaccounts_calculated[2].value= eval(parent.frames.document.forms[0].txt_outstanding_noofaccounts_calculated[2].value)+eval(parent.frames.document.forms[0].txt_outstanding_noofaccounts[i].value);
		parent.frames.document.forms[0].txt_outstanding_amount_calculated[2].value=eval( parent.frames.document.forms[0].txt_outstanding_amount_calculated[2].value)+eval(parent.frames.document.forms[0].txt_outstanding_amount[i].value);
	}
		
	// MSME Services - Micro
	for(var i=10;i<15;i++)
	{
		parent.frames.document.forms[0].txt_target_noofaccounts_calculated[3].value= eval(parent.frames.document.forms[0].txt_target_noofaccounts_calculated[3].value)+eval(parent.frames.document.forms[0].txt_target_noofaccounts[i].value);
		parent.frames.document.forms[0].txt_target_amount_calculated[3].value= eval(parent.frames.document.forms[0].txt_target_amount_calculated[3].value)+eval(parent.frames.document.forms[0].txt_target_amount[i].value);
		parent.frames.document.forms[0].txt_sanctioned_noofaccounts_calculated[3].value= eval(parent.frames.document.forms[0].txt_sanctioned_noofaccounts_calculated[3].value)+eval(parent.frames.document.forms[0].txt_sanctioned_noofaccounts[i].value);
		parent.frames.document.forms[0].txt_sanctioned_amount_calculated[3].value= eval(parent.frames.document.forms[0].txt_sanctioned_amount_calculated[3].value)+eval(parent.frames.document.forms[0].txt_sanctioned_amount[i].value);
		parent.frames.document.forms[0].txt_outstanding_noofaccounts_calculated[3].value= eval(parent.frames.document.forms[0].txt_outstanding_noofaccounts_calculated[3].value)+eval(parent.frames.document.forms[0].txt_outstanding_noofaccounts[i].value);
		parent.frames.document.forms[0].txt_outstanding_amount_calculated[3].value=eval( parent.frames.document.forms[0].txt_outstanding_amount_calculated[3].value)+eval(parent.frames.document.forms[0].txt_outstanding_amount[i].value);
	}
		
	// MSME Services - Small
	for(var i=15;i<20;i++)
	{
		parent.frames.document.forms[0].txt_target_noofaccounts_calculated[4].value= eval(parent.frames.document.forms[0].txt_target_noofaccounts_calculated[4].value)+eval(parent.frames.document.forms[0].txt_target_noofaccounts[i].value);
		parent.frames.document.forms[0].txt_target_amount_calculated[4].value= eval(parent.frames.document.forms[0].txt_target_amount_calculated[4].value)+eval(parent.frames.document.forms[0].txt_target_amount[i].value);
		parent.frames.document.forms[0].txt_sanctioned_noofaccounts_calculated[4].value= eval(parent.frames.document.forms[0].txt_sanctioned_noofaccounts_calculated[4].value)+eval(parent.frames.document.forms[0].txt_sanctioned_noofaccounts[i].value);
		parent.frames.document.forms[0].txt_sanctioned_amount_calculated[4].value= eval(parent.frames.document.forms[0].txt_sanctioned_amount_calculated[4].value)+eval(parent.frames.document.forms[0].txt_sanctioned_amount[i].value);
		parent.frames.document.forms[0].txt_outstanding_noofaccounts_calculated[4].value= eval(parent.frames.document.forms[0].txt_outstanding_noofaccounts_calculated[4].value)+eval(parent.frames.document.forms[0].txt_outstanding_noofaccounts[i].value);
		parent.frames.document.forms[0].txt_outstanding_amount_calculated[4].value=eval( parent.frames.document.forms[0].txt_outstanding_amount_calculated[4].value)+eval(parent.frames.document.forms[0].txt_outstanding_amount[i].value);
	}
		
	// Union Education
	for(var i=26;i<28;i++)
	{
		parent.frames.document.forms[0].txt_target_noofaccounts_calculated[5].value= eval(parent.frames.document.forms[0].txt_target_noofaccounts_calculated[5].value)+eval(parent.frames.document.forms[0].txt_target_noofaccounts[i].value);
		parent.frames.document.forms[0].txt_target_amount_calculated[5].value= eval(parent.frames.document.forms[0].txt_target_amount_calculated[5].value)+eval(parent.frames.document.forms[0].txt_target_amount[i].value);
		parent.frames.document.forms[0].txt_sanctioned_noofaccounts_calculated[5].value= eval(parent.frames.document.forms[0].txt_sanctioned_noofaccounts_calculated[5].value)+eval(parent.frames.document.forms[0].txt_sanctioned_noofaccounts[i].value);
		parent.frames.document.forms[0].txt_sanctioned_amount_calculated[5].value= eval(parent.frames.document.forms[0].txt_sanctioned_amount_calculated[5].value)+eval(parent.frames.document.forms[0].txt_sanctioned_amount[i].value);
		parent.frames.document.forms[0].txt_outstanding_noofaccounts_calculated[5].value= eval(parent.frames.document.forms[0].txt_outstanding_noofaccounts_calculated[5].value)+eval(parent.frames.document.forms[0].txt_outstanding_noofaccounts[i].value);
		parent.frames.document.forms[0].txt_outstanding_amount_calculated[5].value=eval( parent.frames.document.forms[0].txt_outstanding_amount_calculated[5].value)+eval(parent.frames.document.forms[0].txt_outstanding_amount[i].value);
	}
	
	// Union Home
	for(var i=28;i<30;i++)
	{
		parent.frames.document.forms[0].txt_target_noofaccounts_calculated[6].value= eval(parent.frames.document.forms[0].txt_target_noofaccounts_calculated[6].value)+eval(parent.frames.document.forms[0].txt_target_noofaccounts[i].value);
		parent.frames.document.forms[0].txt_target_amount_calculated[6].value= eval(parent.frames.document.forms[0].txt_target_amount_calculated[6].value)+eval(parent.frames.document.forms[0].txt_target_amount[i].value);
		parent.frames.document.forms[0].txt_sanctioned_noofaccounts_calculated[6].value= eval(parent.frames.document.forms[0].txt_sanctioned_noofaccounts_calculated[6].value)+eval(parent.frames.document.forms[0].txt_sanctioned_noofaccounts[i].value);
		parent.frames.document.forms[0].txt_sanctioned_amount_calculated[6].value= eval(parent.frames.document.forms[0].txt_sanctioned_amount_calculated[6].value)+eval(parent.frames.document.forms[0].txt_sanctioned_amount[i].value);
		parent.frames.document.forms[0].txt_outstanding_noofaccounts_calculated[6].value= eval(parent.frames.document.forms[0].txt_outstanding_noofaccounts_calculated[6].value)+eval(parent.frames.document.forms[0].txt_outstanding_noofaccounts[i].value);
		parent.frames.document.forms[0].txt_outstanding_amount_calculated[6].value=eval( parent.frames.document.forms[0].txt_outstanding_amount_calculated[6].value)+eval(parent.frames.document.forms[0].txt_outstanding_amount[i].value);
	}
	
	// Total Of Priority Sector
	var str_target=new Array();
	var str_calculated=new Array();
	str_target=[7,8,9,20,21,22,23,24,25,30];
	str_calculated=[0,3,4,5,6];
	for(var i=0;i<str_target.length;i++)
	 { 
		parent.frames.document.forms[0].txt_target_noofaccounts_calculated[7].value= eval(parent.frames.document.forms[0].txt_target_noofaccounts_calculated[7].value)+eval(parent.frames.document.forms[0].txt_target_noofaccounts[str_target[i]].value);
		parent.frames.document.forms[0].txt_target_amount_calculated[7].value= eval(parent.frames.document.forms[0].txt_target_amount_calculated[7].value)+eval(parent.frames.document.forms[0].txt_target_amount[str_target[i]].value);
		parent.frames.document.forms[0].txt_sanctioned_noofaccounts_calculated[7].value= eval(parent.frames.document.forms[0].txt_sanctioned_noofaccounts_calculated[7].value)+eval(parent.frames.document.forms[0].txt_sanctioned_noofaccounts[str_target[i]].value);
		parent.frames.document.forms[0].txt_sanctioned_amount_calculated[7].value= eval(parent.frames.document.forms[0].txt_sanctioned_amount_calculated[7].value)+eval(parent.frames.document.forms[0].txt_sanctioned_amount[str_target[i]].value);
		parent.frames.document.forms[0].txt_outstanding_noofaccounts_calculated[7].value= eval(parent.frames.document.forms[0].txt_outstanding_noofaccounts_calculated[7].value)+eval(parent.frames.document.forms[0].txt_outstanding_noofaccounts[str_target[i]].value);
		parent.frames.document.forms[0].txt_outstanding_amount_calculated[7].value=eval( parent.frames.document.forms[0].txt_outstanding_amount_calculated[7].value)+eval(parent.frames.document.forms[0].txt_outstanding_amount[str_target[i]].value);
	 }
	 for(var i=0;i<5;i++)
	{
		parent.frames.document.forms[0].txt_target_noofaccounts_calculated[7].value= eval(parent.frames.document.forms[0].txt_target_noofaccounts_calculated[7].value)+eval(parent.frames.document.forms[0].txt_target_noofaccounts_calculated[str_calculated[i]].value);
		parent.frames.document.forms[0].txt_target_amount_calculated[7].value= eval(parent.frames.document.forms[0].txt_target_amount_calculated[7].value)+eval(parent.frames.document.forms[0].txt_target_amount_calculated[str_calculated[i]].value);
		parent.frames.document.forms[0].txt_sanctioned_noofaccounts_calculated[7].value= eval(parent.frames.document.forms[0].txt_sanctioned_noofaccounts_calculated[7].value)+eval(parent.frames.document.forms[0].txt_sanctioned_noofaccounts_calculated[str_calculated[i]].value);
		parent.frames.document.forms[0].txt_sanctioned_amount_calculated[7].value= eval(parent.frames.document.forms[0].txt_sanctioned_amount_calculated[7].value)+eval(parent.frames.document.forms[0].txt_sanctioned_amount_calculated[str_calculated[i]].value);
		parent.frames.document.forms[0].txt_outstanding_noofaccounts_calculated[7].value= eval(parent.frames.document.forms[0].txt_outstanding_noofaccounts_calculated[7].value)+eval(parent.frames.document.forms[0].txt_outstanding_noofaccounts_calculated[str_calculated[i]].value);
		parent.frames.document.forms[0].txt_outstanding_amount_calculated[7].value=eval( parent.frames.document.forms[0].txt_outstanding_amount_calculated[7].value)+eval( parent.frames.document.forms[0].txt_outstanding_amount_calculated[str_calculated[i]].value); 
	} 
	
	// Union Comfort
	for(var i=33;i<35;i++)
	{
		parent.frames.document.forms[0].txt_target_noofaccounts_calculated[8].value= eval(parent.frames.document.forms[0].txt_target_noofaccounts_calculated[8].value)+eval(parent.frames.document.forms[0].txt_target_noofaccounts[i].value);
		parent.frames.document.forms[0].txt_target_amount_calculated[8].value= eval(parent.frames.document.forms[0].txt_target_amount_calculated[8].value)+eval(parent.frames.document.forms[0].txt_target_amount[i].value);
		parent.frames.document.forms[0].txt_sanctioned_noofaccounts_calculated[8].value= eval(parent.frames.document.forms[0].txt_sanctioned_noofaccounts_calculated[8].value)+eval(parent.frames.document.forms[0].txt_sanctioned_noofaccounts[i].value);
		parent.frames.document.forms[0].txt_sanctioned_amount_calculated[8].value= eval(parent.frames.document.forms[0].txt_sanctioned_amount_calculated[8].value)+eval(parent.frames.document.forms[0].txt_sanctioned_amount[i].value);
		parent.frames.document.forms[0].txt_outstanding_noofaccounts_calculated[8].value= eval(parent.frames.document.forms[0].txt_outstanding_noofaccounts_calculated[8].value)+eval(parent.frames.document.forms[0].txt_outstanding_noofaccounts[i].value);
		parent.frames.document.forms[0].txt_outstanding_amount_calculated[8].value=eval( parent.frames.document.forms[0].txt_outstanding_amount_calculated[8].value)+eval(parent.frames.document.forms[0].txt_outstanding_amount[i].value);
	}
	
	// NPA as on end of period
	var str_add=new Array();
	var str_subtract=new Array();
	str_add=[64,68];
	str_subtract=[65,66,67];
	for(var i=0;i<2;i++)
	{ 
		parent.frames.document.forms[0].txt_target_noofaccounts_calculated[9].value= eval(parent.frames.document.forms[0].txt_target_noofaccounts_calculated[9].value)+eval(parent.frames.document.forms[0].txt_target_noofaccounts[str_add[i]].value);
		parent.frames.document.forms[0].txt_target_amount_calculated[9].value= eval(parent.frames.document.forms[0].txt_target_amount_calculated[9].value)+eval(parent.frames.document.forms[0].txt_target_amount[str_add[i]].value);
		parent.frames.document.forms[0].txt_sanctioned_noofaccounts_calculated[9].value= eval(parent.frames.document.forms[0].txt_sanctioned_noofaccounts_calculated[9].value)+eval(parent.frames.document.forms[0].txt_sanctioned_noofaccounts[str_add[i]].value);
		parent.frames.document.forms[0].txt_sanctioned_amount_calculated[9].value= eval(parent.frames.document.forms[0].txt_sanctioned_amount_calculated[9].value)+eval(parent.frames.document.forms[0].txt_sanctioned_amount[str_add[i]].value);
		parent.frames.document.forms[0].txt_outstanding_noofaccounts_calculated[9].value= eval(parent.frames.document.forms[0].txt_outstanding_noofaccounts_calculated[9].value)+eval(parent.frames.document.forms[0].txt_outstanding_noofaccounts[str_add[i]].value);
		parent.frames.document.forms[0].txt_outstanding_amount_calculated[9].value=eval( parent.frames.document.forms[0].txt_outstanding_amount_calculated[9].value)+eval(parent.frames.document.forms[0].txt_outstanding_amount[str_add[i]].value);
	}
	for(var i=0;i<3;i++)
	{
		parent.frames.document.forms[0].txt_target_noofaccounts_calculated[9].value= eval(parent.frames.document.forms[0].txt_target_noofaccounts_calculated[9].value)-eval(parent.frames.document.forms[0].txt_target_noofaccounts[str_subtract[i]].value);
		parent.frames.document.forms[0].txt_target_amount_calculated[9].value= eval(parent.frames.document.forms[0].txt_target_amount_calculated[9].value)-eval(parent.frames.document.forms[0].txt_target_amount[str_subtract[i]].value);
		parent.frames.document.forms[0].txt_sanctioned_noofaccounts_calculated[9].value= eval(parent.frames.document.forms[0].txt_sanctioned_noofaccounts_calculated[9].value)-eval(parent.frames.document.forms[0].txt_sanctioned_noofaccounts[str_subtract[i]].value);
		parent.frames.document.forms[0].txt_sanctioned_amount_calculated[9].value= eval(parent.frames.document.forms[0].txt_sanctioned_amount_calculated[9].value)-eval(parent.frames.document.forms[0].txt_sanctioned_amount[str_subtract[i]].value);
		parent.frames.document.forms[0].txt_outstanding_noofaccounts_calculated[9].value= eval(parent.frames.document.forms[0].txt_outstanding_noofaccounts_calculated[9].value)-eval(parent.frames.document.forms[0].txt_outstanding_noofaccounts[str_subtract[i]].value);
		parent.frames.document.forms[0].txt_outstanding_amount_calculated[9].value=eval( parent.frames.document.forms[0].txt_outstanding_amount_calculated[9].value)-eval(parent.frames.document.forms[0].txt_outstanding_amount[str_subtract[i]].value);
	} 
	
	// roundtxt
	for(var i=0;i<parent.frames.document.forms[0].txt_target_noofaccounts_calculated.length;i++)
	{
		roundtxt(parent.frames.document.forms[0].txt_target_amount_calculated[i]);
		roundtxt(parent.frames.document.forms[0].txt_sanctioned_amount_calculated[i]);
		roundtxt(parent.frames.document.forms[0].txt_outstanding_amount_calculated[i]);
	}
}

function roundall()
{
	// roundtxt
	for(var i=0;i<parent.frames.document.forms[0].txt_target_amount.length;i++)
	{
		roundtxt(parent.frames.document.forms[0].txt_target_amount[i]);
		roundtxt(parent.frames.document.forms[0].txt_sanctioned_amount[i]);
		roundtxt(parent.frames.document.forms[0].txt_outstanding_amount[i]);
	}
}