report 50101 "Seminar Reg. Participant List"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/SeminarRegParticipantList.rdl';
    Caption = 'Seminar Reg. Participant List';

    dataset
    {
        dataitem("Seminar Registration Header"; "CSD Registration Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Seminar No.";

            column(No; "No.")
            {
                IncludeCaption = true;
            }
            column(SeminarNo; "Seminar No.")
            {
                IncludeCaption = true;
            }
            column(SeminarName; "Seminar Name")
            {
                IncludeCaption = true;
            }
            column(StartingDate; "Starting Date")
            {
                IncludeCaption = true;
            }
            column(Duration; "Duration")
            {
                IncludeCaption = true;
            }
            column("InstructorName"; "Instructor Name")
            {
                IncludeCaption = true;
            }
            column(RoomName; "Room Name")
            {
                IncludeCaption = true;
            }
            dataitem("CSD Seminar Registration Line"; "CSD Seminar Registration Line")
            {
                DataItemTableView = sorting("Document No.", "Line No.");
                column(Bill_to_Customer_No_; "Bill-to Customer No.")
                {
                    IncludeCaption = true;
                }
                column(Participant_Contact_No_; "Participant Contact No.")
                {
                    IncludeCaption = true;
                }
                column(Participant_Name; "Participant Name")
                {
                    IncludeCaption = true;
                }
                dataitem("Company Information"; "Company Information")
                {
                    column(CompanyName; Name)
                    {
                        IncludeCaption = true;
                    }
                }
            }
        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(LayoutName)
                {
                }
            }
        }
    }

    labels
    {
        SeminarRegistrationHeaderCap = 'Seminar Registration List';
    }
    var
        myInt: Integer;
}