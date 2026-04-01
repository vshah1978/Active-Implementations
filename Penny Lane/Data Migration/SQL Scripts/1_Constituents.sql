---------------------------------------------------------------------------------------
-------------- Individuals
---------------------------------------------------------------------------------------
Select
    c.Email as [__migration_Migration ID]
    , 'Individual' as [Constituent type]
    , c.[First Name] as [Name: First]
    , c.[Last Name] as [Name: Last]
    , CONCAT_WS(' ', c.[First Name], c.[Last Name]) as [Name: Full]
    , case 
	    when c.[Accepts Marketing] = 'FALSE' then 'yes' 
	    else 'no'
    end as [Do Not Contact?]
    , c.Email as [Contact: email]
   
    ,  ISNULL(dbo.FormatPhone(c.[Billing Phone Number]),'') as [Contact: Cell Phone]
    ,  ISNULL(Case
        When c.[Shipping Phone Number] <> c.[Billing Phone Number] Then 
         dbo.FormatPhone(c.[Shipping Phone Number])
     End,'') as [Contact: Work phone]
    
    , CONCAT_WS(', ', c.[Billing Address 1], c.[Billing Address 2], c.[Billing City], c.[Billing Province/State], c.[Billing Zip], 
      c.[Billing Country]) as [Contact: Address 1 (text)]
    , 'Penny Lane the Ultimate Beatles Museum' as [Museum]
    --, c.ACTIVE_STATUS
from dbo.[Square Space Export Contacts] c
where c.[First Name] is not null or c.[Last Name] is not null
order by c.[First Name]
