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
                ToolTip = 'view all resources registeres as persons';
            }
            action(Rooms)
            {
                Caption = 'Rooms';
                RunObject = page "Resource List";
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
                // RunObject=report "CSD Create Seminar Invoices";
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
