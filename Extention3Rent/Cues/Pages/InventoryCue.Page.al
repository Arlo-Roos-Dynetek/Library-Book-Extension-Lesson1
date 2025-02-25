page 50331 "Library Inventory Page"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Library Inventory Cue";
    
    layout
    {
        area(Content)
        {
            cuegroup("Library Inventory")
            {
                field("Books recently added";Rec."Books recently added")
                {
                    DrillDownPageId = "List Of Books";
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
        Rec.CalcFields("Books recently added");
    end;
    
}