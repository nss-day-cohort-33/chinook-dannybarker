-- 1. non_usa_customers.sql
SELECT 
c.FirstName || ' ' || c.LastName as CustomerName,
c.CustomerId,
c.Country
FROM Customer c
WHERE c.Country != 'USA';

-- 2. brazil_customers.sql
SELECT * FROM Customer c
WHERE c.Country = 'Brazil';

-- 3. brazil_customers_invoices.sql
SELECT
c.FirstName || ' ' || c.LastName as CustomerName,
i.InvoiceId,
i.InvoiceDate,
i.BillingCountry
from Invoice i 
Join Customer c on i.CustomerId = c.CustomerId and c.Country = 'Brazil';

-- 4. sales_agents.sql
SELECT * FROM Employee e
WHERE e.Title = 'Sales Support Agent';

-- 5. unique_invoice_countries.sql
SELECT DISTINCT
BillingCountry
from Invoice;

-- 6. sales_agent_invoices.sql
SELECT
e.FirstName || ' ' || e.LastName as EmployeeName,
i.*
FROM Invoice i 
JOIN Customer c on i.CustomerId = c.CustomerId
JOIN Employee e on c.SupportRepId = e.EmployeeId and e.Title = 'Sales Support Agent'
ORDER BY EmployeeName;

