DECLARE @t TABLE
(
EmployeeID INT,
Certs VARCHAR(8000)
)
INSERT @t VALUES (1,'B.E.,MCA, MCDBA, PGDCA'), (2,'M.Com.,B.Sc.'), (3,'M.Sc.,M.Tech.')

-- XML
SELECT EmployeeID,CAST('<XMLRoot><RowData>' + REPLACE(Certs,',','</RowData><RowData>') + '</RowData></XMLRoot>' AS XML) AS x
FROM   @t

-- complete query
SELECT EmployeeID,
LTRIM(RTRIM(m.n.value('.[1]','varchar(8000)'))) AS Certs
FROM
(
SELECT EmployeeID,CAST('<XMLRoot><RowData>' + REPLACE(Certs,',','</RowData><RowData>') + '</RowData></XMLRoot>' AS XML) AS x
FROM   @t
)t
CROSS APPLY x.nodes('/XMLRoot/RowData')m(n)