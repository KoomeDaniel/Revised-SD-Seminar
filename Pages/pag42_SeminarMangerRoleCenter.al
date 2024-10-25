page 50142 "Seminar Manager Role Center"
{
    PageType = RoleCenter;
    Caption = 'Seminar Manager';

    layout
    {
        area(RoleCenter)
        {
            group(Column1)
            {
                part(Activities; "CSD Seminar Manager Activities")
                {
                }
                part(MySeminars; "CSD My Seminar")
                {
                }
            }
            group(column2)
            {
                part(MyCustomers; "My Customers")
                {
                }
                systempart(MyNotifications; MyNotes)
                {
                }
                part(ReportInbox; "Report Inbox Part")
                {
                }
            }
        }
    }

    actions
    {


        area(Embedding)
        {

            action(SeminarRegistrations)
            {
                Caption = 'Seminar Registrations';
                Image = List;
                RunObject = page "CSD Posted Seminar RegList";
                ToolTip = 'Create seminar registrations';
            }
            action(Seminars)
            {
                Caption = 'Seminars';
                Image = List;
                RunObject = page "CSD Seminar List";
                ToolTip = 'View all seminars';
            }
            action(Instructors)
            {
                Caption = 'Instructors';
                RunObject = page "Resource List";
                RunPageLink = Type = CONST(Person);
                ToolTip = 'view all resources registeres as persons';
            }
            action(Rooms)
            {
                Caption = 'Rooms';
                RunObject = page "Resource List";
                RunPageLink = Type = CONST(Machine);
                ToolTip = 'View all resources registered as Machines';
            }
            action("sales Invoices")
            {
                Caption = 'Sales Invoices';
                RunObject = page "Sales Invoice List";
                ToolTip = 'Revert the financial transactions involved when your customers want to cancel a purchase';
            }
            action(Customers)
            {
                Caption = 'Customers';
                Image = Customer;
                RunObject = page "Customer List";
                ToolTip = 'View or edit detailed information for the customers that you trade with';
            }

        }
        area(Sections)
        {
            group(Seminar)
            {
                Caption = 'Seminar';
                ToolTip = 'View and edit seminar information';
                action("Seminar Setup")
                {
                    Caption = 'Seminar Setup';
                    ToolTip = 'View and edit seminar setup information';
                    Image = Setup;
                    RunObject = page "CSD Seminar Setup";
                }
                action("Source Code Setup")
                {
                    Caption = 'Source Code Setup';
                    ToolTip = 'View and edit Seminar Source Code Setup information';
                    Image = Setup;
                    RunObject = page "Source Code Setup";
                }
                action("Seminar List")
                {
                    Caption = 'Seminar List';
                    Image = ListPage;
                    RunObject = page "CSD Seminar List";
                    ToolTip = 'Open the list of seminars';
                }
                action("Seminar Charges")
                {
                    Caption = 'Seminar Charges';
                    Image = Cost;
                    RunObject = page "CSD Seminar Charge";
                    ToolTip = 'Open the list of seminar charges';
                }
                action("My Seminars")
                {
                    Caption = 'My Seminars';
                    Image = List;
                    RunObject = page "CSD My Seminar";
                    ToolTip = 'Open the Available seminars';
                }
                action("Seminar Comments")
                {
                    Caption = 'Seminar comment';
                    ToolTip = 'View and edit list of comments on seminars';
                    Image = Comment;
                    RunObject = page "CSD Seminar comment list";
                }

                action("Seminar Ledger Entries")
                {
                    Caption = 'Seminar Ledger Entries';
                    Image = LedgerEntries;
                    ToolTip = 'View the ledger entries for seminars';
                    RunObject = page "CSD Ledger Entries";
                }


            }
            group(Resources)
            {
                Caption = 'Resources';
                ToolTip = 'view and edit available resources(instructors and rooms)';
                action(Instructor)
                {
                    Caption = 'Instructors';
                    ToolTip = 'View and edit instructor information';
                    Image = Employee;
                    RunObject = page "Resource List";
                    RunPageLink = Type = CONST(Person);
                }
                action(Room)
                {
                    Caption = 'Rooms';
                    ToolTip = 'View and edit room information';
                    Image = Resource;
                    RunObject = page "Resource List";
                    RunPageLink = Type = CONST(Machine);
                }
            }
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                ToolTip = 'View history for sales,shipments, and Inventory.';
                Image = FiledPosted;

                action("Posted Seminar Registrations")
                {
                    Caption = 'Posted Seminar Registrations';
                    Image = Timesheet;
                    RunObject = page "CSD Posted Seminar RegList";
                    ToolTip = 'Open the list of posted Registrations';
                }


                action("Posted Sales Invoices")
                {
                    Caption = 'Posted Sales Invoices';
                    Image = PostedOrder;
                    ToolTip = 'Open the list of posted sales invoices';
                    RunObject = Page "Posted Sales Invoices";
                }
                action("Posted Sales Credit Memos")
                {
                    Caption = 'Posted Sales Credit Memos';
                    Image = PostedOrder;
                    ToolTip = 'Open the list of posted sales credit memos';
                    RunObject = Page "Posted Sales Credit Memos";
                }
                action("Registers")
                {
                    Caption = 'Seminar Registers';
                    ToolTip = 'Open the list of Seminar Registers';
                    RunObject = Page "CSD Seminar Registers";
                    Image = PostedShipment;
                }
            }
            group("Seminar Reports")
            {
                Caption = 'Seminar Reports';
                ToolTip = 'View reports for seminar registrations and sales';
                action("Seminar Registration Report")
                {
                    Caption = 'Seminar Registration Report';
                    Image = Report;
                    RunObject = report "Seminar Reg. Participant List";
                    ToolTip = 'Open the Seminar Registration Report Selection';
                }
                action("Create Seminar Invoices")
                {
                    Caption = 'Create Seminar Invoices';
                    Image = Invoice;
                    RunObject = report "Create Seminar Invoices";
                    ToolTip = 'Create invoices for seminar registrations';
                }

            }

        }
        area(Creation)
        {
            action(NewSeminarRegistration)
            {
                Caption = 'New Seminar Registration';
                Image = NewTimesheet;
                RunObject = page "CSD Seminar Registration";
                RunPageMode = Create;
            }
            action(NewSalesInvoice)
            {
                Caption = 'Sales Invoice';
                Image = NewSalesInvoice;
                RunObject = page "Sales Invoice";
                RunPageMode = Create;
            }
        }
        area(processing)
        {
            action(CreateInvoices)
            {
                Caption = 'Create Invoices';
                Image = CreateJobSalesInvoice;
                RunObject = report "Create Contract Invoices";
            }
            action(Navigate)
            {
                Caption = 'Navigate';
                Image = Navigate;
                RunObject = page "Navigate";
                RunPageMode = Edit;
            }
        }
    }


}
profile "Seminar Administrator"
{
    Caption = 'Seminar Administrator';
    RoleCenter = "Seminar Manager Role Center";
}
