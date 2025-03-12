/// <summary>
/// Page Library Page Setup (ID 50301).
/// </summary>
page 50301 "Library Page Setup"
{

    PageType = Card;
    SourceTable = "Library table Setup";
    Caption = 'Change Fine';
    InsertAllowed = false;
    DeleteAllowed = false;
    UsageCategory = Administration;
    ApplicationArea = All;


    layout
    {
        area(content)
        {
            group("Changeble fields")
            {
                field(Fines; Rec.HighFines)
                {
                    Caption = 'High Fine Amount';
                    ToolTip = 'This field allows you to change the the fine amount for "High Status" books that are overdue.';
                    trigger OnValidate()
                    var

                    begin
                        Rec.Modify(true);
                    end;
                }
                field(ExtremeFines; Rec.ExtremeFines)
                {
                    Caption = 'Extreme Fine Amount';
                    ToolTip = 'This field allows you to change the the fine amount for "Extreme Status" books that are overdue.';
                    trigger OnValidate()
                    var

                    begin
                        Rec.Modify(true);
                    end;
                }
                field("API No.";Rec."API No.")
                {
                  
                //   trigger OnValidate()
                //     var

                //     begin
                //         Rec.Modify(true);
                //     end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.InsertIfNotExists();
    end;

}
