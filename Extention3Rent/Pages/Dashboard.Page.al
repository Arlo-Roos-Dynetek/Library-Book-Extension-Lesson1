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
                        if AuthorFilter <> '' then begin
                            Rec.SetFilter("Author Filter", '@*' + AuthorFilter + '*');
                            CurrPage.Update();
                        end;

                    end;
                }
                field("Genre Filter"; GenreFilter)
                {
                    trigger OnValidate()
                    begin
                        if GenreFilter <> Enum::"Genre List"::" " then
                            Rec.SetFilter("Genre Filter", '%1', GenreFilter);
                        CurrPage.Update();
                    end;
                }
                field("Publishing Date"; PublishingDate)
                {
                    trigger OnValidate()
                    begin
                        if PublishingDate <> '' then begin
                            Rec.SetFilter("Publishing Date", PublishingDate);
                            PublishingDate := Rec.GetFilter("Publishing Date");
                            CurrPage.Update();
                        end;

                    end;

                }
                field("Added Date"; AddedDate)
                {

                    trigger OnValidate()
                    begin
                        if AddedDate <> '' then begin
                            Rec.SetFilter("Added Date", AddedDate);
                            AddedDate := Rec.GetFilter("Added Date");
                            CurrPage.Update();
                        end;

                    end;
                }
            }
            group("Total Books")
            {
                field("Total Books Avaliable"; Rec."Total Books Avaliable")
                {
                    DrillDownPageId = "List Of Books";
                }
                field("Total books Rented"; Rec."Total Rented")
                {
                    DrillDownPageId = "List Of Books";
                }
            }
            group("Overdue Level Details")
            {

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