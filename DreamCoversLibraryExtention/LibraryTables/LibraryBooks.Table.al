/// <summary>
/// Table Library (ID 50120).
/// </summary>
table 50120 Library
{
    // this is the code that creates the table that allows the user to store records.
    DataClassification = CustomerContent;
    Access = Public;


    fields
    {
        field(12; "Book ID"; Code[20])
        {
            Caption = 'Book ID';
            DataClassification = CustomerContent;
            //AutoIncrement = true;
            ToolTip = 'This is the ID of the Book.';
        }
        field(1; Title; Text[400])
        {
            Caption = 'Title';
            DataClassification = CustomerContent;
            ToolTip = 'This is the Title of the Book.';
        }

        field(2; Author; Text[200])
        {
            Caption = 'Author';
            DataClassification = CustomerContent;
            ToolTip = 'This is the Author of the Book.';
        }

        field(3; Rented; Boolean)
        {
            Caption = 'Rented';
            DataClassification = CustomerContent;
            ToolTip = 'This is to indicate if the Book has been rented.';

        }

        field(4; Series; Text[100])
        {
            Caption = 'Series';
            DataClassification = CustomerContent;
            ToolTip = 'This is the Series of the Book.';

        }

        field(5; Genre; Enum "Genre List")
        {
            Caption = 'Genre';
            DataClassification = CustomerContent;
            ToolTip = 'This is the Genre of the Book.';
        }

        field(6; Publisher; Text[150])
        {
            Caption = 'Publisher';
            DataClassification = CustomerContent;
            ToolTip = 'This is the Publisher of the Book.';
        }

        field(7; "Book Price"; Decimal)
        {
            Caption = 'Book Price';
            DataClassification = AccountData;
            InitValue = 0;
            ToolTip = 'This is the Price of the Book.';
        }

        field(8; "Publication Date"; Date)
        {
            Caption = 'Publication Date';
            DataClassification = CustomerContent;
            ToolTip = 'This is the Publication Date of the Book.';
        }

        field(9; Pages; Integer)
        {
            Caption = 'Pages';
            DataClassification = CustomerContent;
            InitValue = 0;
            ToolTip = 'This is the amount pages in the Book.';
        }

        field(10; Prequel; Text[100])
        {
            Caption = 'Prequel';
            DataClassification = CustomerContent;
            ToolTip = 'This is the Prequel of the Book.';

        }

        field(11; Sequel; Text[100])
        {
            Caption = 'Sequel';
            DataClassification = CustomerContent;
            ToolTip = 'This is the Sequel of the Book.';

        }

        field(13; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No." = field("Customer ID")));
            ToolTip = 'This is the Name of the Customer that rented the Book.';


        }
        field(15; "Customer ID"; Code[20])
        {
            Caption = 'Customer ID';
            TableRelation = Customer."No.";
            ToolTip = 'This is the ID of the customer that rented the Book.';
        }
        field(14; "Amount Rented"; Integer)
        {
            Caption = 'Amount Rented';
            DataClassification = CustomerContent;
            InitValue = 0;
            ToolTip = 'This is the amount to times the book has been rented.';
        }
        field(16; "Date Rented"; Date)
        {
            Caption = 'Date Rented';
            DataClassification = CustomerContent;
            ToolTip = 'This is the Date the book has been rented.';
        }
        field(17; "Date Returned"; Date)
        {
            Caption = 'Date Returned';
            DataClassification = CustomerContent;
            ToolTip = 'This is the Date the book has been returned.';
        }
    }

    keys
    {
        key(PrimaryKey; "Book ID")
        {
            Clustered = true;
        }

        key(SecondaryKey2; Title)
        {
            Clustered = false;
        }

        key(SecondaryKey3; Author)
        {
            Clustered = false;
        }

        key(SecondaryKey4; Rented)
        {
            Clustered = false;
        }

        key(SecondaryKey5; Series)
        {
            Clustered = false;
        }

        key(SecondaryKey6; Genre)
        {
            Clustered = false;
        }

        key(SecondaryKey7; Publisher)
        {
            Clustered = false;
        }

        key(SecondaryKey8; "Book Price")
        {
            Clustered = false;
        }

        key(SecondaryKey9; "Publication Date")
        {
            Clustered = false;
        }

        key(SecondaryKey10; Pages)
        {
            Clustered = false;
        }

        key(SecondaryKey11; Prequel)
        {
            Clustered = false;
        }
        key(SecondaryKey12; Sequel)
        {
            Clustered = false;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    trigger OnInsert()
    var
        "No. Series": Codeunit "No. Series";
        BookID: Code[20];
    begin
        BookID := "No. Series".GetNextNo('BID', WorkDate());
        rec.Validate("Book ID", BookID);
    end;

    trigger OnModify()
    var
        "Return Book": Codeunit "Library Functionality";
    begin
        /*if "Customer Name" = '' then begin
            Rented := false;
        end;*/

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    var
        Customer: Record Customer;

        "Genre List": Enum "Genre List";

}