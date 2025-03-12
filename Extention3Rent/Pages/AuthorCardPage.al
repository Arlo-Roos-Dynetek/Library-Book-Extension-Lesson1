page 50303 "Author Card Page"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Author;
    
    layout
    {
        area(Content)
        {
            group("Personal Info")
            {
                field("Author ID"; Rec."Author ID")
                {
                    ToolTip = 'Specifies the value of the Author ID field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field("Open Library ID"; Rec."Open Library ID")
                {
                    ToolTip = 'Specifies the value of the Open Library ID field.', Comment = '%';
                }
                field("Personal Name"; Rec."Personal Name")
                {
                    ToolTip = 'Specifies the value of the Personal Name field.', Comment = '%';
                }
                
            }
            group(Dates)
            {
                field("Birth Date"; Rec."Birth Date")
                {
                    ToolTip = 'Specifies the value of the Birth Date field.', Comment = '%';
                }
                field("Death Date"; Rec."Death Date")
                {
                    ToolTip = 'Specifies the value of the Death Date field.', Comment = '%';
                }
            }
            group("Other Info")
            {
                field("Top Work"; Rec."Top Work")
                {
                    ToolTip = 'Specifies the value of the Top Work field.', Comment = '%';
                }
                field("Work Count"; Rec."Work Count")
                {
                    ToolTip = 'Specifies the value of the Work Count field.', Comment = '%';
                }
                 field(Bio; Rec.Bio)
                {
                    ToolTip = 'Specifies the value of the Biography field.', Comment = '%';
                }
            }
        }
    }
}