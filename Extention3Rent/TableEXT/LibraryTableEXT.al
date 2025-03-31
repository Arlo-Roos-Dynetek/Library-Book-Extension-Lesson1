tableextension 50305 LibraryEXT extends Library
{

    fields
    {
        field(40; Status; Enum "Status Levels")
        {
            Caption = 'Current Status';
            ToolTip = 'This shows the current status of the book.';
        }
        field(50; "Allow Rent"; Boolean)
        {
            Caption = 'Allow to rent';
            ToolTip = 'This shows if the customer is allowed to rent a book.';
        }
        field(60; "Weeks Overdue"; Integer)
        {
            Caption = 'Weeks Overdue';
            ToolTip = 'This shows the amount of weeks the book is overdue';
        }
        field(70; "Amount Rented month"; Integer)
        {
            Caption = 'Amount rented monthly';
            ToolTip = 'This field shows if the book was rented or returned.';

        }
        field(80; "Monthly Rank"; Integer)
        {
            Caption = 'Monthly Rank';
            ToolTip = 'This field shows the monthly rank of the book.';

        }
        field(90; "Description"; Blob)
        {
            Caption = 'Description';
            ToolTip = 'This field shows the description of the book.';

        }
        field(100; "Date Created"; Date)
        {
            Caption = 'Date Created';
            ToolTip = 'This field shows the date the book was created.';

        }
        field(110; "Open Library ID"; Code[100])
        {
            Caption = 'Open Library ID';
            ToolTip = 'This field shows the Open Library ID of the book';

        }
        field(120; "Author ID"; Code[1000])
        {
            Caption = 'Author ID';
            ToolTip = 'This field shows the Author ID of the book';

        }




    }

    fieldgroups
    {
        addlast(Brick; Author, Title, "Book Cover", Rented, "Customer Name") { }
    }
}