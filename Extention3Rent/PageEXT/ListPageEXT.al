pageextension 50304 "List Page extention " extends "List Of Books"
{
    layout
    {
        addbefore(Genre)
        {
            field(Status; Rec.Status)
            {
                Caption = 'Current Status';
                ToolTip = 'This is the current status for the book.';
                trigger OnValidate()
                var
                    myInt: Integer;
                    "Rent Functionality": Codeunit "Rent Functionality";
                begin
                    "Rent Functionality".AssignCustomerLevel();
                end;
            }
            field("Weeks Overdue"; Rec."Weeks Overdue")
            {
                Caption = 'Weeks Overdue';
                ToolTip = 'This is the current Weeks overdue for the book.';
            }

        }
    }

    actions
    {
        addafter("Add Book")
        {
            action("Overdue Books")
            {
                Image = Filter;
                trigger OnAction()
                var
                    "Rent Functionality": Codeunit "Rent Functionality";
                begin
                    "Rent Functionality".ShowAllOverdueBooks(Rec);
                end;
            }
        }


    }

}