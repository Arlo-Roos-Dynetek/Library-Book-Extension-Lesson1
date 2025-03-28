page 50300 "Book Search API"
{
    PageType = list;
    ApplicationArea = All;
    UsageCategory = Lists;
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
                    ToolTip = 'This textbox is used to type in the title ot part of the title of the book.';
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
                    Visible = false;
                }
                field(Title; Rec.Title)
                {

                }
                field(Author; Rec.Author)
                {

                }
                field("Book Cover"; Rec."Book Cover")
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
                Image = Save;
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
            action("View Authors")
            {
                Image=View;
                trigger OnAction()
                var
                    AuthorPage: Page "Author Page";
                begin
                    AuthorPage.Run();
                end;
            }
        }
    }

    var
        SearchBook: Text[200];
}