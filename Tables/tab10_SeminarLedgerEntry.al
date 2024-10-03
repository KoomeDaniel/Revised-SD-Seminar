table 50110 "CSD Seminar Ledger Entry"
{
    Caption = 'Seminar Ledger Entry';
    DataClassification = ToBeClassified;
    // LookupPageId = ad_SeminarLedgerEntries;
    // DrillDownPageId = ad_SeminarLedgerEntries;


    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(2; "From Entry No."; Integer)
        {
            Caption = 'From Entry No.';
            DataClassification = CustomerContent;
        }
        field(3; "To Entry No."; Integer)
        {
            Caption = 'To Entry No.';
            DataClassification = CustomerContent;
        }
        field(4; "Seminar No."; Code[20])
        {
            Caption = 'Seminar No.';
            DataClassification = CustomerContent;
        }
        field(5; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(6; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = CustomerContent;
        }
        field(7; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            OptionMembers = "Posting Accounts","Total Accounts",Formula,"Set Base For Percent","Cost Type","Cost Type Total","Cash Flow Entry Accounts","Cash Flow Total Accounts","Account Category";
            DataClassification = CustomerContent;
        }
        field(8; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(9; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(10; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            DataClassification = CustomerContent;
        }
        field(11; "Charge Type"; Option)
        {
            Caption = 'Charge Type';
            OptionMembers = "Posting Accounts","Total Accounts",Formula,"Set Base For Percent","Cost Type","Cost Type Total","Cash Flow Entry Accounts","Cash Flow Total Accounts","Account Category";
            DataClassification = CustomerContent;
        }
        field(12; Type; Option)
        {
            Caption = 'Type';
            OptionMembers = Resource,"G/L Account";
            DataClassification = CustomerContent;
        }
        field(13; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
        }
        field(14; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            DataClassification = CustomerContent;
        }
        field(15; "Total Price"; Decimal)
        {
            Caption = 'Total Price';
            DataClassification = CustomerContent;
        }
        field(16; "Participant Contact No."; Code[20])
        {
            Caption = 'Participant Contact No.';
            DataClassification = CustomerContent;
        }
        field(17; "Participant Name"; Text[100])
        {
            Caption = 'Partcipant Name';
            DataClassification = CustomerContent;
        }
        field(18; Chargeable; Boolean)
        {
            Caption = 'Chargeable';
            DataClassification = CustomerContent;
        }
        field(19; "Room Resource No."; Code[20])
        {
            Caption = 'Room Resource No.';
            DataClassification = CustomerContent;
        }
        field(20; "Instructor Resource No."; Code[20])
        {
            Caption = 'Instructor Resource No.';
            DataClassification = CustomerContent;
        }
        field(21; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = CustomerContent;
        }
        field(22; "Seminar Registration No."; Code[20])
        {
            Caption = 'Seminar Registration No.';
            DataClassification = CustomerContent;
        }
        field(23; "Res. Ledger Entry No."; Integer)
        {
            Caption = 'Res. Ledger Entry No.';
            DataClassification = CustomerContent;
        }
        field(24; "Source Type"; Option)
        {
            Caption = 'Source Type';
            OptionMembers = "Posting Accounts","Total Accounts",Formula,"Set Base For Percent","Cost Type","Cost Type Total","Cash Flow Entry Accounts","Cash Flow Total Accounts","Account Category";
            DataClassification = CustomerContent;
        }
        field(25; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            DataClassification = CustomerContent;
        }
        field(26; "Journal Batch Name"; Code[20])
        {
            Caption = 'Journal Batch Name';
            DataClassification = CustomerContent;
        }
        field(27; "Source Code"; Code[20])
        {
            Caption = 'Source Code';
            DataClassification = CustomerContent;
        }
        field(28; "Reason Code"; Code[20])
        {
            Caption = 'Reason Code';
            DataClassification = CustomerContent;
        }
        field(29; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
        }
        field(30; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            TableRelation = User."User Name" WHERE("User Name" = FIELD("User ID"));
            ValidateTableRelation = false;
            trigger OnLookup()
            var
                UserMgt: Codeunit "User Management";
            begin
                UserMgt.DisplayUserInformationBySID("User ID");//LookupUserID("User ID");
            end;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(Index01; "Document No.", "Posting Date") { }
    }

}