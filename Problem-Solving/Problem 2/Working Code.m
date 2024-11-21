## Pivoted Data

let
    Source = Excel.CurrentWorkbook(){[Name="Table1"]}[Content],
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Academic Year", type text}, {"Cohort Term", type text}, {"Program Length (SEM)", type text}, {"MCU Code", type text}, {"APS Code", type text}, {"Program Code", type text}, {"Program Description", type text}, {"Campus", type text}, {"Applied", type any}, {"Offers Sent", type any}, {"Offers Confirmed", type any}, {"Max Seats", type any}, {"Waitlist", type any}, {"Total Start", Int64.Type}, {"DOM Start", Int64.Type}, {"INT Start", Int64.Type}, {"SEM1_Total", Int64.Type}, {"SEM1_Total Lost", Int64.Type}, {"SEM1_Total Retention", Percentage.Type}, {"SEM1_DOM", Int64.Type}, {"SEM1_DOM Lost", Int64.Type}, {"SEM1_DOM Retention", Percentage.Type}, {"SEM1_INT", Int64.Type}, {"SEM1_INT Lost", Int64.Type}, {"SEM1_INT Retention", Percentage.Type}, {"SEM2_Total", Int64.Type}, {"SEM2_Total Lost", Int64.Type}, {"SEM2_Total Retention", type any}, {"SEM2_DOM", Int64.Type}, {"SEM2_DOM Lost", Int64.Type}, {"SEM2_DOM Retention", type any}, {"SEM2_INT", Int64.Type}, {"SEM2_INT Lost", Int64.Type}, {"SEM2_INT Retention", type any}, {"SEM3_Total", Int64.Type}, {"SEM3_Total Lost", Int64.Type}, {"SEM3_Total Retention", type any}, {"SEM3_DOM", Int64.Type}, {"SEM3_DOM Lost", Int64.Type}, {"SEM3_DOM Retention", type any}, {"SEM3_INT", Int64.Type}, {"SEM3_INT Lost", Int64.Type}, {"SEM3_INT Retention", type any}, {"SEM4_Total", Int64.Type}, {"SEM4_Total Lost", Int64.Type}, {"SEM4_Total Retention", type any}, {"SEM4_DOM", Int64.Type}, {"SEM4_DOM Lost", Int64.Type}, {"SEM4_DOM Retention", type any}, {"SEM4_INT", Int64.Type}, {"SEM4_INT Lost", Int64.Type}, {"SEM4_INT Retention", type any}, {"SEM5_Total", Int64.Type}, {"SEM5_Total Lost", Int64.Type}, {"SEM5_Total Retention", type number}, {"SEM5_DOM", Int64.Type}, {"SEM5_DOM Lost", Int64.Type}, {"SEM5_DOM Retention", type any}, {"SEM5_INT", Int64.Type}, {"SEM5_INT Lost", Int64.Type}, {"SEM5_INT Retention", type any}, {"SEM6_Total", Int64.Type}, {"SEM6_Total Lost", Int64.Type}, {"SEM6_Total Retention", type any}, {"SEM6_DOM", Int64.Type}, {"SEM6_DOM Lost", Int64.Type}, {"SEM6_DOM Retention", type any}, {"SEM6_INT", Int64.Type}, {"SEM6_INT Lost", Int64.Type}, {"SEM6_INT Retention", type any}}),
    #"Filtered Rows" = Table.SelectRows(#"Changed Type", each ([Cohort Term] = "201308" or [Cohort Term] = "201408" or [Cohort Term] = "201508" or [Cohort Term] = "201608" or [Cohort Term] = "201708" or [Cohort Term] = "201808" or [Cohort Term] = "201908" or [Cohort Term] = "202008" or [Cohort Term] = "202108" or [Cohort Term] = "202208" or [Cohort Term] = "202308")),
    #"Removed Columns1" = Table.RemoveColumns(#"Filtered Rows",{"Program Length (SEM)", "APS Code", "Academic Year"}),
    #"Grouped Rows" = Table.Group(#"Removed Columns1", {"Program Code", "Program Description", "Campus", "Total Start", "Cohort Term"}, {{"Count", each List.Sum([Total Start]), type nullable number}}),
    #"Removed Columns2" = Table.RemoveColumns(#"Grouped Rows",{"Count"}),
    #"Pivoted Column" = Table.Pivot(#"Removed Columns2", List.Distinct(#"Removed Columns2"[#"Cohort Term"]), "Cohort Term", "Total Start", List.Sum),
    #"Renamed Columns" = Table.RenameColumns(#"Pivoted Column", {
    {"201308", "201308 Total Start"}, 
    {"201408", "201408 Total Start"},
    {"201508", "201508 Total Start"},
    {"201608", "201608 Total Start"},
    {"201708", "201708 Total Start"},
    {"201808", "201808 Total Start"},
    {"201908", "201908 Total Start"},
    {"202008", "202008 Total Start"},
    {"202108", "202108 Total Start"},
    {"202208", "202208 Total Start"},
    {"202308", "202308 Total Start"}
}),
#"Added 201308 YOY Change" = Table.AddColumn(#"Renamed Columns", "201308 YOY Change", each 0),
#"Added 201408 YOY Change" = Table.AddColumn(#"Added 201308 YOY Change", "201408 YOY Change", each if [#"201408 Total Start"] = null or [#"201308 Total Start"] = null then null else [#"201408 Total Start"] - [#"201308 Total Start"]),
#"Added 201508 YOY Change" = Table.AddColumn(#"Added 201408 YOY Change", "201508 YOY Change", each if [#"201508 Total Start"] = null or [#"201408 Total Start"] = null then null else [#"201508 Total Start"] - [#"201408 Total Start"]),
#"Added 201608 YOY Change" = Table.AddColumn(#"Added 201508 YOY Change", "201608 YOY Change", each if [#"201608 Total Start"] = null or [#"201508 Total Start"] = null then null else [#"201608 Total Start"] - [#"201508 Total Start"]),
#"Added 201708 YOY Change" = Table.AddColumn(#"Added 201608 YOY Change", "201708 YOY Change", each if [#"201708 Total Start"] = null or [#"201608 Total Start"] = null then null else [#"201708 Total Start"] - [#"201608 Total Start"]),
#"Added 201808 YOY Change" = Table.AddColumn(#"Added 201708 YOY Change", "201808 YOY Change", each if [#"201808 Total Start"] = null or [#"201708 Total Start"] = null then null else [#"201808 Total Start"] - [#"201708 Total Start"]),
#"Added 201908 YOY Change" = Table.AddColumn(#"Added 201808 YOY Change", "201908 YOY Change", each if [#"201908 Total Start"] = null or [#"201808 Total Start"] = null then null else [#"201908 Total Start"] - [#"201808 Total Start"]),
#"Added 202008 YOY Change" = Table.AddColumn(#"Added 201908 YOY Change", "202008 YOY Change", each if [#"202008 Total Start"] = null or [#"201908 Total Start"] = null then null else [#"202008 Total Start"] - [#"201908 Total Start"]),
#"Added 202108 YOY Change" = Table.AddColumn(#"Added 202008 YOY Change", "202108 YOY Change", each if [#"202108 Total Start"] = null or [#"202008 Total Start"] = null then null else [#"202108 Total Start"] - [#"202008 Total Start"]),
#"Added 202208 YOY Change" = Table.AddColumn(#"Added 202108 YOY Change", "202208 YOY Change", each if [#"202208 Total Start"] = null or [#"202108 Total Start"] = null then null else [#"202208 Total Start"] - [#"202108 Total Start"]),
#"Added 202308 YOY Change" = Table.AddColumn(#"Added 202208 YOY Change", "202308 YOY Change", each if [#"202308 Total Start"] = null or [#"202208 Total Start"] = null then null else [#"202308 Total Start"] - [#"202208 Total Start"]),
#"New Reordered Columns" = Table.ReorderColumns(#"Added 202308 YOY Change", {
    "Program Code", 
    "Program Description", 
    "Campus", 
    "201308 Total Start", 
    "201308 YOY Change", 
    "201408 Total Start", 
    "201408 YOY Change",
    "201508 Total Start", 
    "201508 YOY Change",
    "201608 Total Start", 
    "201608 YOY Change",
    "201708 Total Start", 
    "201708 YOY Change",
    "201808 Total Start", 
    "201808 YOY Change",
    "201908 Total Start", 
    "201908 YOY Change",
    "202008 Total Start", 
    "202008 YOY Change",
    "202108 Total Start", 
    "202108 YOY Change",
    "202208 Total Start", 
    "202208 YOY Change",
    "202308 Total Start", 
    "202308 YOY Change"
}),
#"Replaced Value" = Table.ReplaceValue(#"New Reordered Columns", null, "--", Replacer.ReplaceValue, {"201308 Total Start", "201308 YOY Change", "201408 Total Start", "201408 YOY Change", "201508 Total Start", "201508 YOY Change", "201608 Total Start", "201608 YOY Change", "201708 Total Start", "201708 YOY Change", "201808 Total Start", "201808 YOY Change", "201908 Total Start", "201908 YOY Change", "202008 Total Start", "202008 YOY Change", "202108 Total Start", "202108 YOY Change", "202208 Total Start", "202208 YOY Change", "202308 Total Start", "202308 YOY Change"})
in
    #"Replaced Value"

## Real Declining 

let
    Source = #"Pivoted Data",

    // Reemplazar '--' con null
    #"Replaced Value" = Table.ReplaceValue(Source, "--", null, Replacer.ReplaceValue, {"201308 Total Start", "201308 YOY Change", "201408 Total Start", "201408 YOY Change", "201508 Total Start", "201508 YOY Change", "201608 Total Start", "201608 YOY Change", "201708 Total Start", "201708 YOY Change", "201808 Total Start", "201808 YOY Change", "201908 Total Start", "201908 YOY Change", "202008 Total Start", "202008 YOY Change", "202108 Total Start", "202108 YOY Change", "202208 Total Start", "202208 YOY Change", "202308 Total Start", "202308 YOY Change"}),

    // Cambiar tipos de columnas
    #"Changed Type" = Table.TransformColumnTypes(#"Replaced Value",{{"201308 YOY Change", type number}, {"201408 YOY Change", type number}, {"201508 YOY Change", type number}, {"201608 YOY Change", type number}, {"201708 YOY Change", type number}, {"201808 YOY Change", type number}, {"201908 YOY Change", type number}, {"202008 YOY Change", type number}, {"202108 YOY Change", type number}, {"202208 YOY Change", type number}, {"202308 YOY Change", type number}}),

    // Reemplazar null con 0 en las columnas YOY Change
    #"Replaced Nulls" = Table.ReplaceValue(#"Changed Type", null, 0, Replacer.ReplaceValue, {"201308 YOY Change", "201408 YOY Change", "201508 YOY Change", "201608 YOY Change", "201708 YOY Change", "201808 YOY Change", "201908 YOY Change", "202008 YOY Change", "202108 YOY Change", "202208 YOY Change", "202308 YOY Change"}),

    // Calcular YOY AVG Decline
    #"Added Custom1" = Table.AddColumn(#"Replaced Nulls", "2013-2023 YOY AVG Decline", each Number.Round(List.Average(List.Select({[201308 YOY Change], [201408 YOY Change], [201508 YOY Change], [201608 YOY Change], [201708 YOY Change], [201808 YOY Change], [201908 YOY Change], [202008 YOY Change], [202108 YOY Change], [202208 YOY Change], [202308 YOY Change]}, each _ < 0)), 1)),

    // Calcular YOY AVG Change
    #"Added Custom2" = Table.AddColumn(#"Added Custom1", "2013-2023 YOY AVG Change", each Number.Round(List.Average({[201308 YOY Change], [201408 YOY Change], [201508 YOY Change], [201608 YOY Change], [201708 YOY Change], [201808 YOY Change], [201908 YOY Change], [202008 YOY Change], [202108 YOY Change], [202208 YOY Change], [202308 YOY Change]}), 1)),

    // Filtrar los códigos en la columna 'Program Code'
    FilteredTable = Table.SelectRows(#"Added Custom2", each not List.Contains({"0378", "0132/0185", "0148/0178", "0342", "0321", "0311", "0613", "0294", "0386", "0315/0316", "0331", "0255", "0179", "0312", "0230", "0268", "0381", "0229", "0284", "0351", "0123/0190", "0265", "0345", "0219", "0222", "0319", "0630/0620", "0399", "0304", "0171/0671", "0684", "0137", "0520", "0511", "0168/0183", "0177", "0194", "0207", "0329", "0169", "0191", "0627", "0629", "0631"}, [Program Code])),

    // Reordenar columnas
    #"Reordered Columns" = Table.ReorderColumns(FilteredTable,{"Program Code", "Program Description", "Campus", "2013-2023 YOY AVG Decline", "2013-2023 YOY AVG Change", "201308 Total Start", "201308 YOY Change", "201408 Total Start", "201408 YOY Change", "201508 Total Start", "201508 YOY Change", "201608 Total Start", "201608 YOY Change", "201708 Total Start", "201708 YOY Change", "201808 Total Start", "201808 YOY Change", "201908 Total Start", "201908 YOY Change", "202008 Total Start", "202008 YOY Change", "202108 Total Start", "202108 YOY Change", "202208 Total Start", "202208 YOY Change", "202308 Total Start", "202308 YOY Change"}),

    // Reemplazar null con 0 en la columna 2013-2023 YOY AVG Decline
    #"Replaced Nulls in Decline" = Table.ReplaceValue(#"Reordered Columns", null, 0, Replacer.ReplaceValue, {"2013-2023 YOY AVG Decline"}),

    // Ordenar filas por la columna 2013-2023 YOY AVG Decline
    #"Sorted Rows" = Table.Sort(#"Replaced Nulls in Decline",{{"2013-2023 YOY AVG Decline", Order.Ascending}})
in
    #"Sorted Rows"

## Fixed Decline

let
    Source = #"Pivoted Data",

    // Reemplazar '--' con null
    #"Replaced Value" = Table.ReplaceValue(Source, "--", null, Replacer.ReplaceValue, {"201308 Total Start", "201308 YOY Change", "201408 Total Start", "201408 YOY Change", "201508 Total Start", "201508 YOY Change", "201608 Total Start", "201608 YOY Change", "201708 Total Start", "201708 YOY Change", "201808 Total Start", "201808 YOY Change", "201908 Total Start", "201908 YOY Change", "202008 Total Start", "202008 YOY Change", "202108 Total Start", "202108 YOY Change", "202208 Total Start", "202208 YOY Change", "202308 Total Start", "202308 YOY Change"}),

    // Cambiar tipos de columnas
    #"Changed Type" = Table.TransformColumnTypes(#"Replaced Value",{{"201308 YOY Change", type number}, {"201408 YOY Change", type number}, {"201508 YOY Change", type number}, {"201608 YOY Change", type number}, {"201708 YOY Change", type number}, {"201808 YOY Change", type number}, {"201908 YOY Change", type number}, {"202008 YOY Change", type number}, {"202108 YOY Change", type number}, {"202208 YOY Change", type number}, {"202308 YOY Change", type number}}),

    // Reemplazar null con 0 en las columnas YOY Change
    #"Replaced Nulls" = Table.ReplaceValue(#"Changed Type", null, 0, Replacer.ReplaceValue, {"201308 YOY Change", "201408 YOY Change", "201508 YOY Change", "201608 YOY Change", "201708 YOY Change", "201808 YOY Change", "201908 YOY Change", "202008 YOY Change", "202108 YOY Change", "202208 YOY Change", "202308 YOY Change"}),

    // Calcular YOY AVG Decline
    #"Added Custom1" = Table.AddColumn(#"Changed Type", "2013-2023 YOY AVG Decline", each List.Sum(List.Select({[201308 YOY Change], [201408 YOY Change], [201508 YOY Change], [201608 YOY Change], [201708 YOY Change], [201808 YOY Change], [201908 YOY Change], [202008 YOY Change], [202108 YOY Change], [202208 YOY Change], [202308 YOY Change]}, each _ < 0)) / 10),

    // Calcular YOY AVG Change
    #"Added Custom2" = Table.AddColumn(#"Added Custom1", "2013-2023 YOY AVG Change", each List.Sum({[201308 YOY Change], [201408 YOY Change], [201508 YOY Change], [201608 YOY Change], [201708 YOY Change], [201808 YOY Change], [201908 YOY Change], [202008 YOY Change], [202108 YOY Change], [202208 YOY Change], [202308 YOY Change]}) / 10),
    
    FilteredTable = Table.SelectRows(#"Added Custom2", each not List.Contains({"0378", "0132/0185", "0148/0178", "0342", "0321", "0311", "0613", "0294", "0386", "0315/0316", "0331", "0255", "0179", "0312", "0230", "0268", "0381", "0229", "0284", "0351", "0123/0190", "0265", "0345", "0219", "0222", "0319", "0630/0620", "0399", "0304", "0171/0671", "0684", "0137", "0520", "0511", "0168/0183", "0177", "0194", "0207", "0329", "0169", "0191", "0627", "0629", "0631"}, [Program Code])),

    // Reordenar columnas
    #"Reordered Columns" = Table.ReorderColumns(FilteredTable,{"Program Code", "Program Description", "Campus", "2013-2023 YOY AVG Decline", "2013-2023 YOY AVG Change", "201308 Total Start", "201308 YOY Change", "201408 Total Start", "201408 YOY Change", "201508 Total Start", "201508 YOY Change", "201608 Total Start", "201608 YOY Change", "201708 Total Start", "201708 YOY Change", "201808 Total Start", "201808 YOY Change", "201908 Total Start", "201908 YOY Change", "202008 Total Start", "202008 YOY Change", "202108 Total Start", "202108 YOY Change", "202208 Total Start", "202208 YOY Change", "202308 Total Start", "202308 YOY Change"}),

    // Reemplazar null con 0 en la columna 2013-2023 YOY AVG Decline
    #"Replaced Nulls in Decline" = Table.ReplaceValue(#"Reordered Columns", null, 0, Replacer.ReplaceValue, {"2013-2023 YOY AVG Decline"}),

    // Ordenar filas por la columna 2013-2023 YOY AVG Decline
    #"Sorted Rows" = Table.Sort(#"Replaced Nulls in Decline",{{"2013-2023 YOY AVG Decline", Order.Ascending}})
in
    #"Sorted Rows"

## Higher and Lower AVG Decline (Variable Divisor)

## **Higher**
let
    Source = Var_Neg_Avg_Decline,
    #"Filtered Rows" = Table.SelectRows(Source, each ([Campus] = "TB")),
    // Reemplazar '--' con null (si aún no se ha hecho)
    #"Replaced Value" = Table.ReplaceValue(#"Filtered Rows", "--", null, Replacer.ReplaceValue, {"2013-2023 YOY AVG Decline"}),

    // Filtrar valores null en la columna de declive
    #"Filtered Non-Nulls" = Table.SelectRows(#"Replaced Value", each [#"2013-2023 YOY AVG Decline"] <> null),

    // Ordenar filas en orden ascendente por la columna de declive
    #"Sorted Rows" = Table.Sort(#"Filtered Non-Nulls", {{"2013-2023 YOY AVG Decline", Order.Ascending}}),

    // Seleccionar los primeros 10 registros
    #"Top 10" = Table.FirstN(#"Sorted Rows", 10)
in
    #"Top 10"

## **Lower**

let
    Source = Var_Neg_Avg_Decline,
    #"Filtered Rows" = Table.SelectRows(Source, each ([Campus] = "TB")),
    
    // Reemplazar '--' con null (si aún no se ha hecho)
    #"Replaced Value" = Table.ReplaceValue(#"Filtered Rows", "--", null, Replacer.ReplaceValue, {"2013-2023 YOY AVG Decline"}),

    // Filtrar valores null en la columna de declive
    #"Filtered Non-Nulls" = Table.SelectRows(#"Replaced Value", each [#"2013-2023 YOY AVG Decline"] <> null),

    // Ordenar filas en orden ascendente por la columna de declive (para tener los valores negativos más bajos primero)
    #"Sorted Rows" = Table.Sort(#"Filtered Non-Nulls", {{"2013-2023 YOY AVG Decline", Order.Descending}}),

    // Filtrar solo los valores negativos
    #"Filtered Negatives" = Table.SelectRows(#"Sorted Rows", each [#"2013-2023 YOY AVG Decline"] < 0),

    // Seleccionar los primeros 10 registros
    #"Top 10 Negatives" = Table.FirstN(#"Filtered Negatives", 10)
in
    #"Top 10 Negatives"

## Higher and Lower AVG Decline (Fixed Divisor)

## **Higher**

let
    Source = Fixed_10Yr_Decline,
    #"Filtered Rows" = Table.SelectRows(Source, each ([Campus] = "TB")),
    // Reemplazar '--' con null (si aún no se ha hecho)
    #"Replaced Value" = Table.ReplaceValue(#"Filtered Rows", "--", null, Replacer.ReplaceValue, {"2013-2023 YOY AVG Decline"}),

    // Filtrar valores null en la columna de declive
    #"Filtered Non-Nulls" = Table.SelectRows(#"Replaced Value", each [#"2013-2023 YOY AVG Decline"] <> null),

    // Ordenar filas en orden ascendente por la columna de declive
    #"Sorted Rows" = Table.Sort(#"Filtered Non-Nulls", {{"2013-2023 YOY AVG Decline", Order.Ascending}}),

    // Seleccionar los primeros 10 registros
    #"Top 10" = Table.FirstN(#"Sorted Rows", 10)
in
    #"Top 10"

## **Lower**

let
    Source = Fixed_10Yr_Decline,
    #"Filtered Rows" = Table.SelectRows(Source, each ([Campus] = "TB")),
    
    // Reemplazar '--' con null (si aún no se ha hecho)
    #"Replaced Value" = Table.ReplaceValue(#"Filtered Rows", "--", null, Replacer.ReplaceValue, {"2013-2023 YOY AVG Decline"}),

    // Filtrar valores null en la columna de declive
    #"Filtered Non-Nulls" = Table.SelectRows(#"Replaced Value", each [#"2013-2023 YOY AVG Decline"] <> null),

    // Ordenar filas en orden ascendente por la columna de declive (para tener los valores negativos más bajos primero)
    #"Sorted Rows" = Table.Sort(#"Filtered Non-Nulls", {{"2013-2023 YOY AVG Decline", Order.Descending}}),

    // Filtrar solo los valores negativos
    #"Filtered Negatives" = Table.SelectRows(#"Sorted Rows", each [#"2013-2023 YOY AVG Decline"] < 0),

    // Seleccionar los primeros 10 registros
    #"Top 10 Negatives" = Table.FirstN(#"Filtered Negatives", 10)
in
    #"Top 10 Negatives"
