# For this task, I created the 'Source' table from the original dataset, which serves as a connection table. 
# Then, I referenced it to create two separate tables: 'Single_Courses' and 'Xlist_Courses'.

# Note: In the original work, I applied several steps before this code, such as:
# - Correcting instructor names.
# - Verifying enrollment data.
# - Cross-checking cross-listed courses with the data provided by Cognos.
#
# Occasionally, I encountered:
# - Social or preferred names (e.g., Pat, Sue, Barb, etc.) that differed from the legal names in the system.
# - Mistyped course entries.

## Source Table
let
    // Load the source data
    Source = Excel.CurrentWorkbook(){[Name="Table1"]}[Content],

    // Change column types for consistency
    #"Changed Type" = Table.TransformColumnTypes(Source, {{"First Name", type text}, {"Last Name", type text}, {"Course", type text}}),

    // Ensure there is exactly one space between letters and numbers in the "Course" column
    #"Fixed Course Format" = Table.TransformColumns(
        #"Changed Type",
        {{"Course", each Text.Trim(Text.Replace(_, "  ", " "))}} // Replace multiple spaces with a single one
    ),

    // Insert a single space between letters and numbers, if missing
    #"Standardized Course Format" = Table.TransformColumns(
        #"Fixed Course Format",
        {{"Course", each Text.Insert(_, Text.Length(Text.Select(_, {"A".."Z"})), " "), type text}}
    )
in
    #"Standardized Course Format"

## Single_Courses Table
let
    // Load the source data
    Source = Source,

    // Change the type of the CRN column to ensure it's processed as text
    #"Changed Type" = Table.TransformColumnTypes(Source, {{"CRN", type text}, {"First Name", type text}, {"Last Name", type text}}),
    #"Filtered Rows" = Table.SelectRows(#"Changed Type", each ([#"Cross-list"] = "")),

    // Add columns for 3-digit and 4-digit prefixes based on the CRN column
    #"Added 3 Digit Prefix" = Table.AddColumn(#"Filtered Rows", "Prefix_3_Digits", each Text.Start([CRN], 3), type text),
    #"Added 4 Digit Prefix" = Table.AddColumn(#"Added 3 Digit Prefix", "Prefix_4_Digits", each Text.Start([CRN], 4), type text),

    // Count the occurrences of each 4-digit prefix
    #"Grouped by 4 Digit Prefix" = Table.Group(#"Added 4 Digit Prefix", {"Prefix_4_Digits"}, {{"Count_4", each Table.RowCount(_), Int64.Type}}),

    // Merge the prefix counts back into the main table
    #"Merged 4 Digit Counts" = Table.NestedJoin(#"Added 4 Digit Prefix", "Prefix_4_Digits", #"Grouped by 4 Digit Prefix", "Prefix_4_Digits", "Count4Table", JoinKind.LeftOuter),
    #"Expanded 4 Digit Counts" = Table.ExpandTableColumn(#"Merged 4 Digit Counts", "Count4Table", {"Count_4"}),

    // Assign the grouping prefix: prioritize the 4-digit prefix if it has at least 2 occurrences; otherwise, use the 3-digit prefix
    #"Added Group Prefix" = Table.AddColumn(#"Expanded 4 Digit Counts", "Group_Prefix", each if [Count_4] >= 2 then [Prefix_4_Digits] else [Prefix_3_Digits], type text),

    // Assign a unique marker for each group
    #"Added Group Marker" = Table.AddIndexColumn(Table.Distinct(Table.SelectColumns(#"Added Group Prefix", {"Group_Prefix"})), "Group_Marker", 1, 1, Int64.Type),
    #"Merged Group Marker" = Table.NestedJoin(#"Added Group Prefix", "Group_Prefix", #"Added Group Marker", "Group_Prefix", "GroupTable", JoinKind.LeftOuter),
    #"Expanded Group Marker" = Table.ExpandTableColumn(#"Merged Group Marker", "GroupTable", {"Group_Marker"}),

    // Add a column "Temporary ID" by combining CRN, First Name, and Last Name
    #"Added Temporary ID" = Table.AddColumn(#"Expanded Group Marker", "Temporary ID", each [CRN] & " " & [First Name] & " " & [Last Name], type text),

    // Sort the table by Group_Prefix and CRN in ascending order
    #"Sorted Table" = Table.Sort(#"Added Temporary ID", {{"Group_Prefix", Order.Ascending}, {"CRN", Order.Ascending}}),

    // Remove unnecessary columns for a cleaner output
    #"Cleaned Table" = Table.RemoveColumns(#"Sorted Table", {"Cross-list", "Count_4", "Group_Prefix"})
in
    #"Cleaned Table"

## Xlist_Courses Table
let
    // Load the source data
    Source = Source,

    // Rename the "Cross-list" column to "XList"
    #"Renamed Columns" = Table.RenameColumns(Source, {{"Cross-list", "XList"}}),

    // Filter rows where "XList" is not null
    #"Filtered Rows" = Table.SelectRows(#"Renamed Columns", each ([XList] <> null and [XList] <> "")),

    // Change the type of the necessary columns
    #"Changed Type" = Table.TransformColumnTypes(#"Filtered Rows", {
        {"Course", type text}, {"Section", type text}, {"XList", type text}, 
        {"First Name", type text}, {"Last Name", type text}
    }),

    // Create the "Temporary ID" column by combining Course, Section, XList, First Name, and Last Name
    #"Added Temporary ID" = Table.AddColumn(#"Changed Type", "Temporary ID", 
        each [Course] & " " & [Section] & " " & [XList] & " " & [First Name] & " " & [Last Name], type text)
in
    #"Added Temporary ID"
