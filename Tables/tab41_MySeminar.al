table 50141 "CSD My Seminar"
{
    Caption = 'My Seminar';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "User ID"; Code[50])
        {
            Caption = 'User ID';
            TableRelation = User;
            DataClassification = ToBeClassified;
        }
        field(2; "Seminar No"; Code[50])
        {
            Caption = 'Seminar No';
            TableRelation = "CSD Seminar";
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "User ID", "Seminar No")
        {
            Clustered = true;
        }
    }
}