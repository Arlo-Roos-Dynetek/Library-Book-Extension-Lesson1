page 50301 "Library Page Setup"
{

    PageType = Card;
    SourceTable = "Library table Setup";
    Caption = 'Change Fine';
    InsertAllowed = false;
    DeleteAllowed = false;
    UsageCategory = Administration;


    layout
    {
        area(content)
        {
            group("Changeble fields")
            {
                field(Fines; Rec.Fines)
                {
                    trigger OnValidate()
                    var
                      
                    begin
                        Rec.Modify(true);
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.InsertIfNotExists();
    end;

}
