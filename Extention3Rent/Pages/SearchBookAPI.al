page 50300 "Book Search API"
{
    PageType = list;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Library";
    SourceTableTemporary = true;

    layout
    {
        area(Content)
        {
            group(Search)
            {

                field(SearchBook; SearchBook)
                {
                    Caption = 'Search book: ';
                    trigger OnValidate()
                    var
                        SearchBookApi: Codeunit "Search Book Api";
                    begin
                        if SearchBook <> '' then
                            SearchBookApi.SearchBooks(SearchBook, Rec)
                        else
                            Rec.DeleteAll();
                    end;
                }

            }
            repeater("Book Info")
            {
                Editable = false;
                field("Book ID"; Rec."Book ID")
                {

                }
                field(Title; Rec.Title)
                {
                    // DataClassification = ToBeClassified;
                }
                field("Publication Date"; Rec."Publication Date")
                {

                }
                field(Description; Rec.Description)
                {

                }
            }
        }

    }

    actions
    {
        area(Processing)
        {
            action("Save book")
            {

                trigger OnAction()
                var
                    SaveTempFile: Codeunit "Save Temp File";
                begin
                    CurrPage.SetSelectionFilter(Rec);
                    if Rec.FindSet() then
                        repeat
                            SaveTempFile.SaveBook(Rec);
                        until Rec.Next() = 0;
                    Rec.Reset();
                end;
            }
        }
    }

    var
        SearchBook: Text[200];
    // Description: Text[1000];
}