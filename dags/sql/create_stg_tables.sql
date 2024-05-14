CREATE TABLE IF NOT EXISTS stg_export (
    "Year" TEXT,
    "Month" TEXT,
    "CPC" TEXT,
    "HS Code" TEXT,
    "HS Description" TEXT,
    "Destination" TEXT,
    "Quantity" TEXT,
    "Unit" TEXT,
    "Gross Wt. (Kg)" TEXT,
    "Net Wt. (Kg)" TEXT,
    "FOB Value (ETB)" TEXT,
    "FOB Value (USD)" TEXT,
    "Total tax (ETB)" TEXT,
    "Total tax (USD)" TEXT
);


CREATE TABLE IF NOT EXISTS stg_import (
    "Year" TEXT,
    "Month" TEXT,
    "CPC text" TEXT,
    "HS Code text" TEXT,
    "HS Description" TEXT,
    "Country (Origin)" TEXT,
    "Country (Consignment)" TEXT,
    "Quantity" TEXT,
    "Unit" TEXT,
    "Gross Wt. (Kg)" TEXT,
    "Net Wt. (Kg)" TEXT,
    "CIF Value (ETB)" TEXT,
    "CIF Value (USD)" TEXT,
    "Total tax (ETB)" TEXT,
    "Total tax (USD)" TEXT
);
