function mainChngcolor(btnid,x)
{
var x=x;
var i;

if(x==0)
{

	for(i=0;i<=31;i++)
	{
		document.all.btnid.style.color="#CC0000";
	}
}
else if(x==1)
{
	for(i=0;i<=31;i++)
	{
		document.all.btnid.style.color="black";
	}
}
}