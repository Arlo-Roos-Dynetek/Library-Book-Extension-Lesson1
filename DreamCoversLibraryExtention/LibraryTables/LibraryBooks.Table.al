table 50120 Library
{
    DataClassification = CustomerContent;
    TableType = Normal;

    fields
    {
        field(12; BookID; Integer)
        {
            Caption = 'Book ID';
            DataClassification = CustomerContent;
            AutoIncrement  = true;

        }
        field(1; Title; Text[400])
        {
            Caption = 'Title';
            DataClassification = CustomerContent;

        }

        field(2; Author; Text[200])
        {
            Caption = 'Author';
            DataClassification = CustomerContent;

        }

        field(3; Rented; Boolean)
        {
            Caption = 'Rented';
            DataClassification = CustomerContent;

        }

        field(4; Series; Text[100])
        {
            Caption = 'Series';
            DataClassification = CustomerContent;

        }

        field(5; Genre; Text[50])
        {
            Caption = 'Genre';
            DataClassification = CustomerContent;

        }

        field(6; Publisher; Text[150])
        {
            Caption = 'Publisher';
            DataClassification = CustomerContent;

        }

        field(7; "Book Price"; Decimal)
        {
            Caption = 'Book Price';
            DataClassification = AccountData;

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

        }

        field(10; Prequel; Text[100])
        {
            Caption = 'Prequel';
            DataClassification = CustomerContent;

        }

        field(11; Sequel; Text[100])
        {
            Caption = 'Sequel';
            DataClassification = CustomerContent;

        }

        field(13; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            DataClassification = CustomerContent;

        }
        field(14; "Amount Rented"; Integer)
        {
            Caption = 'Amount Rented';
            DataClassification = CustomerContent;

        }
    }

    keys
    {
        key(PrimaryKey; BookID)
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

    var
        myInt: Integer;
        Genre: Text;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    //var
       // LiBrary: Record Library
    begin

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

}