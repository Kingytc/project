

@Author: Abdul Jaleel 
@Since: 27-Oct-2010

alter table appinwardreg add INWARD_PROPTYPE VARCHAR2(2);
========================================================================

@Author: Abdul Jaleel 
@Since: 27-Oct-2010


alter table adv_auditobservations add adv_inwardno varchar2(20);
========================================================================


@Author: Abdul Jaleel 
@Since: 27-Oct-2010


alter table comapproc add comapp_inwardno varchar2(20);
========================================================================


@Author: Abdul Jaleel 
@Since: 01-Nov-2010

alter table prd_repaycapacity add(repay_credit number(5,2));
========================================================================

@Author: Abdul Jaleel 
@Since: 02-Nov-2010

alter table loandetails add loan_copsociety varchar2(2);
========================================================================

@Author: Abdul Jaleel 
@Since: 02-Nov-2010

alter table adv_meanscapital add adv_ratecheck varchar2(3)
========================================================================

@Author: Abdul Jaleel 
@Since: 08-Nov-2010

create table com_breakupofnoncurrent (com_appno varchar2(20),break_slno number(10),
break_field1 varchar2(30),break_year2 varchar2(10),
break_year3  varchar2(10),break_year4  varchar2(10),break_year5  varchar2(10), 
break_year6  varchar2(10), break_year7  varchar2(10))
========================================================================

@Author: Abdul Jaleel 
@Since: 23-Nov-2010

alter table applications add app_legalcomp varchar2(3);
========================================================================
 
@Author: Abdul Jaleel 
@Since: 24-Nov-2010

ALTER TABLE PER_INSURANCE 
MODIFY ("INSU_AGENCYNAME" VARCHAR2(100 BYTE))
;

========================================================================

@Author: Abdul Jaleel 
@Since: 07-Dec-2010

 ALTER TABLE ADV_TERMDEPOSITS 
MODIFY ("TERMDEPOSITS_SNO" NUMBER(6));

========================================================================

========================================================================

@Author: Abdul Jaleel 
@Since: 13-Dec-2010

ALTER TABLE NPA_GENERALINFO ADD NPAGEN_PROFITABILITY VARCHAR2(100)

========================================================================

@Author: Sureshkumar Ganapathy 
@Since: 14-Feb-2011

alter table appraisalsanction add appraisal_flag varchar2(2);
update appraisalsanction set appraisal_flag='N';

select 'update appraisalsanction set appraisal_flag=''N'' where APPSANC_APPNO='''||app_no||''';' from applications where lower(app_status) not in ('op');

========================================================================



create index perapplicant_name on perapplicant(
upper(perapp_fname),
perapp_branchcode,
perapp_istaff);

alter table PERAPPLICANT parallel 8;

alter table APPMAILBOX parallel 8;
========================================================================

@Author: Abdul Jaleel 
@Since: 23-fEB-2011

 create table applegalcompdetails (appno varchar2(15),alc_sno number(10),
 alc_userid varchar2(10),alc_username varchar2(30),
alc_designation varchar2(50));

========================================================================

