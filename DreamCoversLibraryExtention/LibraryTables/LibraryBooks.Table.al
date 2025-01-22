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
        field(12; "Book ID"; Integer)
        {
            Caption = 'Book ID';
            DataClassification = CustomerContent;
            AutoIncrement = true;

        }
        field(1; Title; Text[400])
        {
            Caption = 'Title';
            DataClassification = CustomerContent;
            InitValue = 'None';
        }

        field(2; Author; Text[200])
        {
            Caption = 'Author';
            DataClassification = CustomerContent;
            InitValue = 'None';
        }

        field(3; Rented; Boolean)
        {
            Caption = 'Rented';
            DataClassification = CustomerContent;
            InitValue = false;
        }

        field(4; Series; Text[100])
        {
            Caption = 'Series';
            DataClassification = CustomerContent;
            InitValue = 'None';
        }

        field(5; Genre; Text[50])
        {
            Caption = 'Genre';
            DataClassification = CustomerContent;
            InitValue = 'None';
        }

        field(6; Publisher; Text[150])
        {
            Caption = 'Publisher';
            DataClassification = CustomerContent;
            InitValue = 'None';
        }

        field(7; "Book Price"; Decimal)
        {
            Caption = 'Book Price';
            DataClassification = AccountData;
            InitValue = 0;
        }

        field(8; "Publication Date"; Date)
        {
            Caption = 'Publication Date';
            DataClassification = CustomerContent;
        }

        field(9; Pages; Integer)
        {
            Caption = 'Pages';
            DataClassification = CustomerContent;
            InitValue = 0;
        }

        field(10; Prequel; Text[100])
        {
            Caption = 'Prequel';
            DataClassification = CustomerContent;
            InitValue = 'None';
        }

        field(11; Sequel; Text[100])
        {
            Caption = 'Sequel';
            DataClassification = CustomerContent;
            InitValue = 'None';
        }

        field(13; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No." = field("Customer ID")));

        }
        field(15; "Customer ID"; Code[20])
        {
            Caption = 'Customer ID';
            // DataClassification = CustomerContent;
            //FieldClass =FlowField;
            TableRelation = Customer."No.";

        }
        field(14; "Amount Rented"; Integer)
        {
            Caption = 'Amount Rented';
            DataClassification = CustomerContent;
            InitValue = 0;
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
    begin

    end;

    trigger OnModify()
    //var
    // LiBrary: Record Library
    begin
        CurrDate := Today;
        //    if Rec.Prequel <> xRec.Prequel then
        //    begin
        //     LiBrary.SetRange(BookID,Rec.PrequelID);
        //     LiBrary.FindFirst();
        //     LiBrary.Sequel := Rec.BookID;
        //    end;
    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    var
        Customer: Record Customer;
        CurrDate: Date;
}