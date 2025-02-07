table 50310 "Book Log Table"
{


    fields
    {
        field(2; LogID; Code[20])
        {
            Caption = 'Log ID';
            ToolTip = 'This represents the id of the Book log';
        }
        field(10; "Customer Name"; Text[50])
        {
            Caption = 'Customer Name';
            ToolTip = 'This shows the name of the customer that rented the book.';
        }
        field(20; "Book Title"; Text[50])
        {

            Caption = 'Book Name';
            ToolTip = 'This field shows what the Title of the book is.';
        }
        field(30; "Date Rented"; Date)
        {
            Caption = 'Date Rented';
            ToolTip = 'This field shows when the book was rented';
        }
        field(40; "Date Returned"; Date)
        {
            Caption = 'Date Returned';
            ToolTip = 'THis field show when the book was returned.';
        }
        field(50; "Rent Duration"; Integer)
        {
            Caption = 'Rent Duration';
            ToolTip = 'This field represents the duration tha the book was rented.';
        }
        field(60; Action; Text[10])
        {
            // Caption = 'Action';
            ToolTip = 'This field shows if the book was rented or returned.';

        }
        
        field(70; "Amount Rented month";Integer)
        {
            // Caption = 'Action';
            ToolTip = 'This field shows if the book was rented or returned.';

        }

    }

    keys
    {
        key("PrimaryKey"; LogID)
        {
          Clustered = true;
        }
    }


    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    var
        "No. Series": Codeunit "No. Series";
        LogID: Code[20];
    begin
        LogID := "No. Series".GetNextNo('LID', WorkDate());
        rec.Validate(LogID, LogID);
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