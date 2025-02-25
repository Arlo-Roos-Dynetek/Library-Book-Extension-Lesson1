table 50330 "Library Dashboard"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "ID"; Code[8])
        {
            DataClassification = ToBeClassified;
            Caption = 'ID';
        }
        field(2; "Total Rented"; Integer)
        {

            Caption = 'Total Rented';
            FieldClass = FlowField;
            CalcFormula = count(Library where(Rented = const(true),
                                              Author = field("Author Filter"),
                                              Genre = field("Genre Filter"),
                                              "Date Added" = field("Added Date"),
                                              "Publication Date" = field("Publishing Date")));


        }

        field(10; "Total Mild"; Integer)
        {

            Caption = 'Total Mild';
            FieldClass = FlowField;
            CalcFormula = count(Library where(Status = const("Status Levels"::Mild),
                                              Author = field("Author Filter"),
                                              Genre = field("Genre Filter"),
                                              "Date Added" = field("Added Date"),
                                              "Publication Date" = field("Publishing Date")));

        }
        field(20; "Total Medium"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Library where(Status = const("Status Levels"::Medium),
                                              Author = field("Author Filter"),
                                              Genre = field("Genre Filter"),
                                              "Date Added" = field("Added Date"),
                                              "Publication Date" = field("Publishing Date")));

            Editable = false;
            Caption = 'Total Medium';
        }
        field(30; "Total High"; Integer)
        {

            Caption = 'Total High';
            FieldClass = FlowField;
            CalcFormula = count(Library where(Status = const("Status Levels"::High),
                                              Author = field("Author Filter"),
                                              Genre = field("Genre Filter"),
                                              "Date Added" = field("Added Date"),
                                              "Publication Date" = field("Publishing Date")));

            Editable = false;
        }
        field(40; "Total Extreme"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Library where(Status = const("Status Levels"::Extreme),
                                              Author = field("Author Filter"),
                                              Genre = field("Genre Filter"),
                                              "Date Added" = field("Added Date"),
                                              "Publication Date" = field("Publishing Date")));

            Editable = false;
            Caption = 'Total Extreme';
        }

        field(50; "Total Books Avaliable"; Integer)
        {

            Caption = 'Total Books Avaliable';
            FieldClass = FlowField;
            CalcFormula = count(Library where(Rented = const(false),
                                              Author = field("Author Filter"),
                                              Genre = field("Genre Filter"),
                                              "Date Added" = field("Added Date"),
                                              "Publication Date" = field("Publishing Date")));

            Editable = false;
        }
        field(60; "Author Filter"; Text[50])
        {
            Caption = 'Author';
            ToolTip = 'Filter by Author.';
            FieldClass = FlowFilter;
        }
        field(70; "Genre Filter"; Enum "Genre List")
        {
            Caption = 'Genre';
            ToolTip = 'Filter by Genre';
            FieldClass = FlowFilter;
        }
        field(80; "Publishing Date"; Date)
        {
            Caption = 'Publishing Date';
            ToolTip = 'Filter by publishing date';
            FieldClass = FlowFilter;
        }
        field(90; "Added Date"; Date)
        {
            Caption = 'Added Date';
            ToolTip = 'Filter by the date the book was added';
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(Key1; ID)
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