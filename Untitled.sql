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

-- 7. invoice_totals.sql
SELECT
e.FirstName || ' ' || e.LastName EmployeeName,
c.FirstName || ' ' || c.LastName CustomerName,
c.Country CustomerCountry,
i.Total
FROM Invoice i 
JOIN Customer c on i.CustomerId = c.CustomerId
JOIN Employee e on c.SupportRepId = e.EmployeeId
ORDER BY CustomerName;

-- 8. total_invoices_{year}.sql
SELECT
SUBSTR(i.InvoiceDate, 1, 4) Year,
COUNT(*) NumberOfInvoices
from Invoice i
where Year = '2009' or Year = '2011'
GROUP BY Year;

-- 9. total_sales_{year}.sql
SELECT
SUBSTR(i.InvoiceDate, 1, 4) Year,
COUNT(*) NumberOfInvoices,
SUM(i.Total) TotalSales
from Invoice i
where Year = '2009' or Year = '2011'
GROUP BY Year;

-- 10. invoice_37_line_item_count.sql
SELECT
il.InvoiceId,
COUNT(il.InvoiceId) LineItems
from InvoiceLine il
where il.InvoiceId = 37
GROUP BY il.InvoiceId;

-- 11. line_items_per_invoice.sql
SELECT
il.InvoiceId,
COUNT(il.InvoiceId) LineItems
from InvoiceLine il
GROUP BY il.InvoiceId;

-- 12. line_item_track.sql
Select
il.*,
t.Name TrackName
from InvoiceLine il 
JOIN Track t on t.TrackId = il.TrackId;

-- 13. line_item_track_artist.sql
SELECT
il.*,
t.Name TrackName,
a.Name ArtistName
from InvoiceLine il 
JOIN Track t on t.TrackId = il.TrackId
JOIN Album on Album.AlbumId = t.AlbumId
JOIN Artist a on a.ArtistId = Album.ArtistId;

-- 14. country_invoices.sql
SELECT
i.BillingCountry Country,
COUNT(i.BillingCountry) Invoices
from Invoice i
GROUP BY i.BillingCountry;

-- 15. playlists_track_count.sql
SELECT
pl.Name Playlist,
COUNT(pl.Name) NumberOfTracks
from PlaylistTrack pt 
Join Playlist pl on pl.PlaylistId = pt.PlaylistId
GROUP BY pl.Name;

-- 16. tracks_no_id.sql
SELECT
t.Name TrackName,
a.Title AlbumTitle,
mt.Name MediaType,
g.Name Genre,
t.Composer,
t.Milliseconds,
t.Bytes,
t.UnitPrice
from Track t 
JOIN Album a on a.AlbumId = t.AlbumId
JOIN MediaType mt on mt.MediaTypeId = t.MediaTypeId
JOIN Genre g on g.GenreId = t.GenreId
GROUP By AlbumTitle;

-- 17. invoices_line_item_count.sql
SELECT
i.*,
COUNT(il.InvoiceId) LineItems
from InvoiceLine il
JOIN Invoice i on i.InvoiceId = il.InvoiceId
GROUP BY il.InvoiceId;

-- 18. sales_agent_total_sales.sql
SELECT
e.FirstName || ' ' || e.LastName as EmployeeName,
COUNT(*) TotalSales,
sum(i.Total) InvoiceTotal
FROM Invoice i 
JOIN Customer c on i.CustomerId = c.CustomerId
JOIN Employee e on c.SupportRepId = e.EmployeeId
GROUP BY EmployeeName;

-- 19. top_2009_agent.sql
Select 
EmployeeName,
TotalSales,
MAX(InvoiceTotal) TotalSales
FROM (
SELECT
e.FirstName || ' ' || e.LastName as EmployeeName,
COUNT(*) TotalSales,
sum(i.Total) InvoiceTotal
FROM Invoice i 
JOIN Customer c on i.CustomerId = c.CustomerId
JOIN Employee e on c.SupportRepId = e.EmployeeId
Where i.InvoiceId IN (
SELECT
i.InvoiceId
from Invoice i
where SUBSTR(i.InvoiceDate, 1, 4) = '2009'
)
GROUP BY EmployeeName);

-- 20. top_agent.sql
Select 
EmployeeName,
TotalSales,
MAX(InvoiceTotal) TotalSales
FROM (
SELECT
e.FirstName || ' ' || e.LastName as EmployeeName,
COUNT(*) TotalSales,
sum(i.Total) InvoiceTotal
FROM Invoice i 
JOIN Customer c on i.CustomerId = c.CustomerId
JOIN Employee e on c.SupportRepId = e.EmployeeId
GROUP BY EmployeeName);

-- 21. sales_agent_customer_count.sql
SELECT
e.FirstName || ' ' || e.LastName as EmployeeName,
Count(*) NumberOfCustomers
FROM Customer c 
JOIN Employee e on e.EmployeeId = c.SupportRepId
GROUP BY EmployeeName;

-- 22. sales_per_country.sql
SELECT
i.BillingCountry Country,
COUNT(*) TotalSales,
sum(i.Total) InvoiceTotal
FROM Invoice i 
GROUP BY Country;

-- 23. top_country.sql
SELECT 
Country,
MAX(InvoiceTotal) InvoiceTotal
FROM (
SELECT
i.BillingCountry Country,
COUNT(*) TotalSales,
sum(i.Total) InvoiceTotal
FROM Invoice i 
GROUP BY Country
);

-- 24. top_2013_track.sql
SELECT
Track,
MAX(TotalPurchased) TotalPurchased
From (
SELECT 
t.Name Track,
COUNT(*) TotalPurchased
FROM InvoiceLine il
JOIN Track t on t.TrackId = il.TrackId
JOIN Invoice i where i.InvoiceId IN (
SELECT
i.InvoiceId
from Invoice i
where SUBSTR(i.InvoiceDate, 1, 4) = '2013'
) 
GROUP BY Track);

-- 25. top_5_tracks.sql
SELECT
Track,
TotalPurchased
From (
SELECT 
t.Name Track,
COUNT(*) TotalPurchased
FROM InvoiceLine il
JOIN Track t on t.TrackId = il.TrackId
GROUP BY Track);














