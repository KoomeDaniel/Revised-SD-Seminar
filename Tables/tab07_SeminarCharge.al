table 50107 "CSD seminar Charge"
{
    Caption = 'seminar Charge';
    DataClassification = ToBeClassified;
    LookupPageId = "CSD Seminar Charge";

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "CSD Registration Header";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; Type; Option)
        {
            Caption = 'Type';
            OptionMembers = Resource,"G/L Account";
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if Type = xRec.Type then
                    exit;
                Description := '';
            end;
        }
        field(4; "No."; code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            TableRelation = if
                (Type = const(Resource)) Resource where(Type = const(Person), Blocked = const(false))
            else
            if (Type = const("G/L Account")) "G/L Account" where(Blocked = const(false), "Direct Posting" = const(false));
            trigger OnValidate()
            begin
                case Type of
                    Type::Resource:
                        begin
                            Resource.Get("No.");
                            Resource.TestField(Blocked, false);
                            Resource.TestField(Type, Resource.Type::Person);
                            Resource.TestField("Gen. Prod. Posting Group");
                            Description := Resource.Name;
                            "Gen. Prod. Posting Group" := Resource."Gen. Prod. Posting Group";
                            "VAT Prod. Posting Group" := Resource."VAT Prod. Posting Group";
                            "Unit of Measure Code" := Resource."Base Unit of Measure";
                            "Unit Price" := Resource."Unit Cost";
                        end;
                    Type::"G/L Account":
                        begin
                            GLAccount.Get("No.");
                            GLAccount.CheckGLAcc();
                            GLAccount.TestField("Direct Posting", true);
                            Description := GLAccount.Name;
                            "Gen. Prod. Posting Group" := GLAccount."Gen. Prod. Posting Group";
                            "VAT Prod. Posting Group" := GLAccount."VAT Prod. Posting Group";

                        end;
                end;
            end;
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(6; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            trigger OnValidate()
            begin
                "Total Price" := Round("Unit Price" * Quantity, 0.01)
            end;
        }
        field(7; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            DataClassification = ToBeClassified;
            MinValue = 0.0;
            AutoFormatType = 2;
            trigger OnValidate()
            begin
                "Total Price" := Round("Unit Price" * Quantity, 0.01);
            end;
        }
        field(8; "Total Price"; Decimal)
        {
            Caption = 'Total Price';
            DataClassification = ToBeClassified;
            Editable = false;
            AutoFormatType = 2;
        }
        field(9; "To Invoice"; Boolean)
        {
            Caption = 'To Invoice';
            DataClassification = ToBeClassified;
            InitValue = true;
        }
        field(10; "Bill-to Customer No."; code[20])
        {
            Caption = 'Bill-to Customer No.';
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(11; "Unit of Measure Code"; code[10])
        {
            Caption = 'Unit of Measure Code';
            DataClassification = ToBeClassified;
            TableRelation = if
                (Type = const(Resource)) "Resource Unit of Measure".Code where("Resource No." = field("No."))
            else
            "Unit of Measure".Code;

            trigger OnValidate()
            var
                ResourceUofM: Record "Resource Unit of Measure";
            begin
                case Type of
                    Type::Resource:
                        begin
                            Resource.Get("No.");
                            if "Unit of Measure Code" = '' then begin
                                "Unit of Measure Code" := Resource."Base Unit of Measure";
                            end;
                            ResourceUofM.Get("No.", "Unit of Measure Code");
                            "QTY. per Unit of Measure" := ResourceUofM."Qty. per Unit of Measure";
                            "Total Price" := Round(Resource."Unit Price" * "QTY. per Unit of Measure");
                        end;
                    Type::"G/L Account":
                        begin
                            "QTY. per Unit of Measure" := 1;
                        end;
                end;
                if CurrFieldNo = FieldNo("Unit of Measure Code") then begin
                    Validate("Unit Price");
                end;
            end;
        }
        field(12; "Gen. Prod. Posting Group"; code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Product Posting Group";
        }
        field(13; "VAT Prod. Posting Group"; code[20])
        {
            Caption = 'VAT Prod. Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = "VAT Product Posting Group";
        }
        field(14; "QTY. per Unit of Measure"; Decimal)
        {
            Caption = 'QTY. per Unit of Measure';
            DataClassification = ToBeClassified;
        }
        field(15; Registered; Boolean)
        {
            Caption = 'Registered';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        Resource: Record Resource;
        GLAccount: Record "G/L Account";

    trigger OnDelete()
    begin
        TestField(Registered, false);
    end;
}