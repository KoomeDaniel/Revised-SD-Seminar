tableextension 50100 "CSD ResourceExt" extends Resource
{
    // This defines a table extension for the "Resource" table, with the ID 50100 and name "CSD ResourceExt".

    fields
    {
        modify("Profit %")
        {
            trigger OnAfterValidate()//Validation typically occurs when a user enters or changes the value of the field and then moves to another field or saves the record.
            begin
                Rec.TestField("Unit Cost");// If the “Unit Cost” field is empty or zero, an error will be raised, and the user will be prompted to enter a valid value.
            end;
        }
        // This modifies the existing field "Profit %" and adds a validation trigger that ensures
        // the "Unit Cost" field is filled (i.e., not blank or zero) after the user modifies "Profit %".

        field(50101; "CSD Resource Type"; Option)
        {
            caption = 'Resource Type';
            OptionMembers = "Internal","External";// This defines the possible values for the option field. In this case, the field can have either "Interal" or "External" as its value.
            OptionCaption = 'Internal,External';//This sets the display captions for the option members. These are the values that users will see in the dropdown list for this field. 
        }
        // Adds a new field "CSD Resource Type" (ID 50101) with an option type, where the user can select either
        // "Internal" or "External". The captions for these options are also provided.

        field(50102; "CSD Maximum Participants"; Integer)
        {
            Caption = 'Maximum Participants';
        }
        // Adds a new integer field "CSD Maximum Participants" (ID 50102), with a caption for display purposes.

        field(50103; "CSD Quantity per Day"; Decimal)
        {
            Caption = 'Quantity per Day';
        }
        // Adds a new decimal field "CSD Quantity per Day" (ID 50103), with a caption for display purposes.
    }

    keys
    {
        // Add changes to keys here
        // This section can be used to modify or add new keys (indexes) for the table.
    }

    fieldgroups
    {
        // Add changes to field groups here
        // Field groups are used for faster display in lookups. This section can be used to define them.
    }

    var
        myInt: Integer;
    // A variable "myInt" of type Integer is declared. It might be used in the table extension logic later.
}
