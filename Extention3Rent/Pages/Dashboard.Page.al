page 50330 "Dashboard Page"
{
    PageType = Card;
    ApplicationArea = All;
    // UsageCategory = Administration;
    SourceTable = "Library Dashboard";

    layout
    {
        area(Content)
        {
            group("Filter By:")
            {
                field("Author Filter"; AuthorFilter)
                {

                    trigger OnValidate()
                    begin
                        Rec.SetFilter("Author Filter", '@*' + AuthorFilter + '*');
                        CurrPage.Update();
                    end;
                }
                field("Genre Filter"; GenreFilter)
                {
                    trigger OnValidate()
                    begin
                        Rec.SetFilter("Genre Filter", '%1', GenreFilter);
                        CurrPage.Update();
                    end;
                }
                field("Publishing Date"; PublishingDate)
                {
                    trigger OnValidate()
                    begin
                        Rec.SetFilter("Publishing Date", PublishingDate);
                        CurrPage.Update();
                    end;

                }
                field("Added Date"; AddedDate)
                {

                    trigger OnValidate()
                    begin
                        Rec.SetFilter("Added Date", AddedDate);
                        CurrPage.Update();
                    end;
                }
            }
            group("Details")
            {
                field("Total Books Avaliable"; Rec."Total Books Avaliable")
                {
                    DrillDownPageId = "List Of Books";
                }
                field("Total Rented"; Rec."Total Rented")
                {
                    DrillDownPageId = "List Of Books";
                }
                field("Total Mild"; Rec."Total Mild")
                {
                    DrillDownPageId = "List Of Books";
                }
                field("Total Medium"; Rec."Total Medium")
                {
                    DrillDownPageId = "List Of Books";
                }
                field("Total High"; Rec."Total High")
                {
                    DrillDownPageId = "List Of Books";
                }
                field("Total Extreme"; Rec."Total Extreme")
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
    end;

    var
        AuthorFilter, PublishingDate, AddedDate : Text[250];
        GenreFilter: Enum "Genre List";
}