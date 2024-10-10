table 50140 "CSD Seminar Cue"
{
    Caption = 'Seminar Cue';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Primary Key';
        }
        field(2; Planned; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("CSD Registration Header" where(Status = const(Planning)));
        }
        field(3; Registered; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("CSD Registration Header" where(Status = const(Registration)));
        }
        field(4; Closed; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("CSD Registration Header" where(Status = const(Closed)));
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}