table 50104 "Csd Seminar Comment Line"
{
    Caption = 'Seminar Comment Line';
    LookupPageId = "CSD Seminar comment list";
    DrillDownPageId = "CSD Seminar comment list";

    fields
    {
        field(10; "Table Name"; option)
        {
            Caption = 'Table Name';
            OptionMembers = "Seminar","Seminar Registration","Posted Seminar Registration";
            OptionCaption = 'Seminar,Seminar Registration ,Posted Seminar Registration';
        }
        field(20; "Document Line No."; Integer)
        {
            caption = 'Document Line No.';
        }
        field(30; "No."; Code[20])
        {
            caption = 'No.';
            TableRelation = if ("Table Name" = const("Seminar")) "CSD SEMINAR";
        }
        field(40; "Line No."; Integer)
        {
            caption = 'Line No.';
        }
        field(50; Date; Date)
        {
            caption = 'Date';
        }
        field(60; Code; Code[10])
        {

            caption = 'Code';
        }
        field(70; Comment; Text[80])
        {
            caption = 'Comment';
        }

    }

    keys
    {
        Key(PK; "Table Name", "Document Line No.", "No.", "Line No.")
        {
            Clustered = true;
        }
    }


}