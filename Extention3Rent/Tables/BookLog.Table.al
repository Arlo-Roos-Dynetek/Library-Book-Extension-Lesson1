table 50310 "Book Log Table"
{


    fields
    {
        field(1; "Customer ID"; Integer)
        {
            Caption = 'Customer ID';
            ToolTip = 'This represents the id of the customer';
        }
        field(10; "Customer Name"; Integer)
        {
            Caption = 'Customer Name';
            ToolTip = 'This shows the name of the customer that rented the book.';
        }
        field(20; "Book Title"; Integer)
        {

            Caption = 'Book Name';
            ToolTip = 'This field shows what the Title of the book is.';
        }
        field(30; "Date Rented"; Integer)
        {
            Caption = 'Date Rented';
            ToolTip = 'This field shows when the book was rented';
        }
        field(40; "Date Returned"; Integer)
        {
            Caption = 'Date Returned';
            ToolTip = 'THis field show when the book was returned.';
        }
        field(50; "Rent Duration"; Integer)
        {
            Caption = 'Rent Duration';
            ToolTip = 'This field represents the duration tha the book was rented.';
        }
        field(60; Action; Integer)
        {
            Caption = 'Action';
            ToolTip = 'This field shows if the book was rented or returned.';

        }
    }



    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}