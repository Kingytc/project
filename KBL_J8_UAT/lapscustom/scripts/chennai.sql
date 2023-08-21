alter table FAC_SECURITY_DETAILS rename to FAC_SECURITY_DETAILS_OLD;
select 'update FAC_SECURITY_DETAILS_OLD set COMAPP_ID='''||
com_demographics.demo_comappid ||''' where SEC_NO='''|| SEC_NO ||''';' from 
com_demographics, fac_security_master 
where com_demographics.demo_appno= fac_security_master.sec_appno
and com_demographics.demo_apptype='N';

insert into fac_security_details
(COMAPP_ID, SEC_NO, SEC_DESC_ID, SEC_DESC_DETAILS, SEC_DESC_VALUE, SEC_DESC_AS_ON_DATE,
SEC_DESC_MARGIN, SEC_TYPE) 
(select COMAPP_ID, SEC_NO, SEC_DESC_ID, SEC_DESC_DETAILS, SEC_DESC_VALUE, SEC_DESC_AS_ON_DATE,
SEC_DESC_MARGIN, SEC_TYPE from fac_security_details_old);

insert into com_appsecurityattched 
(facility_appno, facility_security, facility_headid, facility_id, facility_charge)
(select SEC_APPNO,SEC_NO,SEC_FACHEAD,SEC_FACID,SEC_NATURE_OF_CHARGE from fac_security_master );

create table com_appsecurityattched(
		 facility_appno varchar2(20) NOT NULL,
		 facility_name varchar2(80),
		 facility_security varchar2(10),
		 facility_charge varchar2(10),
		 facility_sno numeric(10,0),
                 facility_headid  numeric(10,0),
		 facility_id numeric(10,0));
               
create table setschemedocument(Scheme_ID numeric(10,0) NOT NULL,Scheme_RULENO numeric(10,0) NOT NULL,
                Scheme_DESC VARCHAR2(50),Document_CONTENT  LONG,Scheme_sector varchar2(10));
select 'noinwardno' as output from applications where app_status='op'
and app_no='5495840000009' 
and app_createdate<= (select min(appinwardreg.inward_createdon) from appinwardreg)

select * from fac_security_master_old
select * from FAC_SECURITY_DETAILS_OLD
 
select 'update FAC_SECURITY_DETAILS1 set sec_appno='''|| sec_appno ||''' where sec_no='''|| sec_no|| ''';' as sec
from fac_security_master1;
select 
'update fac_security_details1 set sec_desc_id='''|| stat_data_desc1 ||''' where sec_desc_id='''|| stat_data_sno ||''';' as update1 from static_data where stat_data_id='12';
alter table fac_security_details1 add sec_srlno varchar2(5);
alter table fac_security_master1 add(sec_srlno varchar2(5));
ALTER TABLE FAC_SECURITY_MASTER1 ADD SEC_FACSNO VARCHAR2(10);
alter table fac_security_details1 add(sec_tenor varchar2(5));

select
'update fac_security_master1 set sec_srlno='''|| sec_srlno||''' where sec_appno='''||sec_appno ||''' and sec_no='''|| sec_no||''';' as sec
from fac_security_details1;

DELETE fac_security_master1 WHERE sec_srlno IS NULL;

SELECT 'INSERT INTO fac_security_master1 (SEC_NO,sec_srlno,SEC_APPNO) VALUES('''||SEC_NO||''','''||sec_srlno||''','''|| sec_appno ||''');' AS SEL
FROM fac_security_details1
WHERE sec_srlno NOT IN (SELECT sec_srlno FROM fac_security_master1);

SELECT 
'UPDATE fac_security_master1 SET sec_fachead='''||a.sec_fachead||
''', SEC_FACID='''||a.sec_facid ||''', SEC_NATURE_OF_CHARGE='''||a.sec_nature_of_charge ||
''' WHERE SEC_APPNO='''||a.sec_appno ||
''' AND SEC_NO='''||A.sec_no || ''' AND sec_fachead IS  NULL; ' AS UPDATION
FROM fac_security_master1 A, fac_security_master1 B
WHERE a.sec_appno= b.sec_appno AND a.sec_no= b.sec_no
AND A.sec_sRlno= b.sec_sRlno AND a.sec_fachead IS NOT NULL ;

select 'update FAC_SECURITY_MASTER1 set SEC_facsno='''|| facilities.facility_sno||
''' where SEC_appno='''|| facilities.facility_appno||''' and sec_fachead=''' ||
facilities.facility_headid ||''' and SEC_facid  =''' || facilities.facility_id||''';' AS UDA
from FAC_SECURITY_MASTER1, facilities
where FAC_SECURITY_MASTER1.SEC_appno= facilities.facility_appno
and FAC_SECURITY_MASTER1.sec_fachead= facilities.facility_headid
and FAC_SECURITY_MASTER1.SEC_facid= facilities.facility_id;

alter table exec_collateraldetails add collateral_sno varchar2(5);
alter table fac_security_details1 add sec_valuersname varchar2(80); 
alter table fac_security_details1 add sec_insuranceamt number(14,2); 
alter table fac_security_details1 add sec_insexpirydate date; 
alter table fac_security_details1 add sec_remarks varchar2(4000);
ALTER TABLE FAC_SECURITY_DETAILS1  MODIFY ("SEC_DESC_DETAILS" VARCHAR2(4000 BYTE));

insert into fac_security_details1(sec_appno,
sec_desc_as_on_date, sec_desc_details , sec_desc_value, sec_valuersname, 
sec_insuranceamt, sec_insexpirydate, sec_remarks, sec_srlno, sec_no, sec_desc_id, sec_type) 
(select exec_collateraldetails.collateral_appno, exec_collateraldetails.collateral_valueddate,
exec_collateraldetails.collateral_description, exec_collateraldetails.collateral_value, 
exec_collateraldetails.collateral_valuer, exec_collateraldetails.collateral_insuranceamt,
exec_collateraldetails.collateral_ins_expirydate, exec_collateraldetails.collateral_remarks, 
exec_collateraldetails.collateral_sno, exec_collateraldetails.collateral_sno, 0, 'Collateral'
from exec_collateraldetails);


UPDATE APPLICATIONS
SET APP_VALUESIN = (SELECT PROP_VALUESIN from com_proposalin 
WHERE APPLICATIONS.APP_NO = COM_PROPOSALIN.prop_appno );

update APPLICATIONS set app_valuesin='A' where app_loantype='A';
update APPLICATIONS set app_valuesin='A' where app_loantype='P';
update APPLICATIONS set app_valuesin='A' where app_loantype='T';
update APPLICATIONS set app_valuesin='L' where app_loantype='c' and app_valuesin is null;


update com_demographics set demo_finstandard='7' where demo_appno in (select  facility_appno from facilities, applications
where facilities.facility_appno=applications.app_no and applications.app_loantype='T'
group by facility_appno
having sum(facility_proposed)>25000);


update com_demographics set demo_finstandard='8' where demo_appno in (select  facility_appno from facilities, applications
where facilities.facility_appno=applications.app_no and applications.app_loantype='T'
group by facility_appno
having sum(facility_proposed)<=25000);


update com_demographics set demo_finstandard='3' where demo_appno in
(select demo_appno from com_demographics, applications
where demo_appno=applications.app_no and applications.app_loantype='c'
and demo_comappid in (select comapp_id from comapplicant where comapp_indcode in 
(select ind_code from com_cma_master where cma_no='3')));

update com_demographics set demo_finstandard='4' where demo_appno in
(select demo_appno from com_demographics, applications
where demo_appno=applications.app_no and applications.app_loantype='c'
and demo_comappid in (select comapp_id from comapplicant where comapp_indcode in 
(select ind_code from com_cma_master where cma_no='4')));











select * from prd_sanction_limit where prd_code='781' and
sanction_limit <='1000000.0' and sanction_limit!=0 order by sanction_limit















select 'update applications set app_applnholder='''|| mail.mail_tousrid||''' where app_status=''op'' and app_applnholder is null and mailchkstatus=''Y'' and app_no='''||app_no||''';' 
from applications app, appmailbox mail
where 
app.mailchkstatus='Y'
and app.app_applnholder is null 
and app.app_status='op'
and app.app_no= mail.mail_appno
and mail.mail_date=(select max(mail_date) from appmailbox b 
where mail.mail_appno= b.mail_appno and mail.mail_type= b.mail_type
and b.mail_type='C') ;




select * from applications,users, groups, DISCRETEPOWERS
where discretepowers.disc_grpid(+)= groups.grouplimitslist
and groups.grp_id(+)= users.usr_grpid
and users.usr_id='admin'


select * from applications, groups, users, prd_sanction_limit
where 
prd_sanction_limit.sanc_groupid= groups.grp_id
and applications.app_prdcode= prd_sanction_limit.prd_code
and groups.grp_id= users.usr_grpid 
and users.usr_id=applications.app_applnholder
and applications.app_loantype in ('P','A')
and applications.app_status='op'
and applications.app_delflag='N'








---------------------------------------------------------------------------------




alter table exec_collateraldetails add collateral_sno varchar2(5);
alter table fac_security_details add sec_valuersname varchar2(80); 
alter table fac_security_details add sec_insuranceamt number(14,2); 
alter table fac_security_details add sec_insexpirydate date; 
alter table fac_security_details add sec_remarks varchar2(4000);
ALTER TABLE FAC_SECURITY_DETAILS  MODIFY (SEC_DESC_DETAILS VARCHAR2(4000 BYTE));
alter table fac_security_details add(sec_tenor varchar2(5));
alter table fac_security_details add sec_srlno varchar2(5);
ALTER TABLE FAC_SECURITY_DETAILS ADD SEC_APPNO VARCHAR2(20);
ALTER TABLE FAC_SECURITY_DETAILS ADD SEC_facsno number(4);
alter table fac_security_details add(sec_margin number(5,2));
alter table fac_security_details add(sec_charge number(3));
alter table fac_security_details add(sec_ownedby varchar2(1000));
alter table fac_security_details add(sec_legalopinion varchar2(2000));
alter table adv_collateralsecurity add(ADVCOL_SrlnO number(3));



select 'update FAC_SECURITY_DETAILS set sec_appno='''|| sec_appno ||''' , SEC_facsno='''|| sec_facsno||''' , sec_charge='''||sec_nature_of_charge||''' where sec_no='''|| sec_no|| ''';' as sec
from fac_security_master;

select 
'update fac_security_details set sec_desc_id='''|| stat_data_desc1 ||''' where sec_desc_id='''|| stat_data_sno ||''';' as update1 from static_data where stat_data_id='12';

ALTER TABLE FAC_SECURITY_MASTER 
ADD ("SEC_FACSNO" NUMBER(4, 0))
;
SELECT 'UPDATE FAC_SECURITY_MASTER SET SEC_FACSNO='''||facility_sno||''' WHERE sec_appno='''||facility_appno||''' AND sec_fachead='''||facility_headid||''' AND sec_facid='''||facility_id||''';'
FROM FACILITIES  ;

insert into fac_security_details1(sec_appno,
sec_desc_as_on_date, sec_desc_details , sec_desc_value, sec_valuersname, 
sec_insuranceamt, sec_insexpirydate, sec_remarks, sec_srlno, sec_no, sec_desc_id, sec_type) 
(select exec_collateraldetails.collateral_appno, exec_collateraldetails.collateral_valueddate,
exec_collateraldetails.collateral_description, exec_collateraldetails.collateral_value, 
exec_collateraldetails.collateral_valuer, exec_collateraldetails.collateral_insuranceamt,
exec_collateraldetails.collateral_ins_expirydate, exec_collateraldetails.collateral_remarks, 
exec_collateraldetails.collateral_sno, exec_collateraldetails.collateral_sno, 0, 'Collateral'
from exec_collateraldetails);

SELECT 'UPDATE FAC_SECURITY_DETAILS SET SEC_MARGIN='''||FACILITY_MARGIN||''' WHERE sec_appno='''||facility_appno||''' AND sec_facsno='''||facility_sno||''';'
FROM FACILITIES  ;

insert into fac_security_details(sec_appno,
sec_desc_details , sec_desc_value, sec_ownedby , sec_legalopinion , sec_remarks, sec_srlno, sec_no, sec_desc_id, sec_type) 
(select ADVCOL_APPNO, ADVCOL_DESCPROPERTY,
ADVCOL_MARKETVALUE, ADVCOL_PROPERTYOWNDED, 
ADVCOL_LEGALOPINION, ADVCOL_ENCUMBRANCE, 
ADVCOL_SrlnO, ADVCOL_SNO, 0, 'Collateral'
from ADV_COLLATERALSECURITY);

 