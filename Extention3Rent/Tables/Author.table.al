table 50300 Author
{
    DataClassification = CustomerContent;


    fields
    {
        field(1; "Author ID"; Code[1000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Author ID';
            ToolTip = 'This is the ID  for the author.';
        }
        field(2; "Open Library ID"; Code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Open Library ID';
            ToolTip = '';
        }
        field(10; "Birth Date"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Birth Date';
            ToolTip = 'This is the date the author was born on.';

        }
        field(20; "Death Date"; Text[50])
        {
            Caption = 'Death Date';
            DataClassification = ToBeClassified;
            ToolTip = 'This is the date the author died.';
        }
        field(30; "Bio"; Text[2048])
        {
            Caption = 'Biography';
            DataClassification = ToBeClassified;
            ToolTip = 'This is the Biography of the author.';
        }
        field(40; "Personal Name"; Text[150])
        {
            Caption = 'Personal Name';
            DataClassification = ToBeClassified;
            ToolTip = 'THis is the authors personal name.';
        }
        field(50; "Name"; Text[100])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
            ToolTip = 'This is the general name of the author.';
        }
        field(60; "Work Count"; Text[100])
        {
            Caption = 'Work Coun';
            DataClassification = ToBeClassified;
            ToolTip = '';
        }
        field(70; "Top Work"; Text[100])
        {
            Caption = 'Top Work';
            DataClassification = ToBeClassified;
            ToolTip = 'This is his best work.';
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