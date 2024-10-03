tableextension 50101 "CSD SourceCode Setup Ext" extends "Source Code Setup"
{
    fields
    {
        field(50100; "CSD Seminar"; code[10])
        {
            Caption = 'Seminar';
            TableRelation = "Source Code";
            DataClassification = ToBeClassified;
        }
    }
}
