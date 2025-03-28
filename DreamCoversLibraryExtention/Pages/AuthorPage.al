page 50101 "Author Page"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Author;
    CardPageId = "Author Card Page";
    // Editable = false;
    layout
    {
        area(Content)
        {
            repeater(Details)
            {

                field("Author ID"; Rec."Author ID")
                {
                    Caption = 'Author ID';
                    ToolTip = 'Specifies the value of the Author ID field.', Comment = '%';
                }
                field(Bio; Rec.Bio)
                {
                    Caption = 'Bio';
                    ToolTip = 'Specifies the value of the Biography field.', Comment = '%';
                    // MultiLine = true;
                }
                field("Birth Date"; Rec."Birth Date")
                {
                    Caption = 'Birth Date';
                    ToolTip = 'Specifies the value of the Birth Date field.', Comment = '%';
                }
                field("Death Date"; Rec."Death Date")
                {
                    Caption = 'Death Date';
                    ToolTip = 'Specifies the value of the Death Date field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {

                    Caption = 'Name';
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field("Open Library ID"; Rec."Open Library ID")
                {
                    Caption = 'Open Library ID';
                    ToolTip = 'Specifies the value of the Open Library ID field.', Comment = '%';
                }
                field("Personal Name"; Rec."Personal Name")
                {
                    Caption = 'Personal Name';
                    ToolTip = 'Specifies the value of the Personal Name field.', Comment = '%';
                }
                field("Top Work"; Rec."Top Work")
                {
                    Caption = 'Top Work';
                    ToolTip = 'Specifies the value of the Top Work field.', Comment = '%';
                }
                field("Work Count"; Rec."Work Count")
                {
                    Caption = 'Work Count';
                    ToolTip = 'Specifies the value of the Work Coun field.', Comment = '%';
                }
            }

        }

    }

}