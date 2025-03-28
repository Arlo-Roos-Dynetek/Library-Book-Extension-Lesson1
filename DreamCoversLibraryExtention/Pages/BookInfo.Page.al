page 50121 "Book Info"
{

    // this page is used to display the fields that the user will allow the user to spectate the data of that given book.
    // this page is also used to call the relevant procedures.

    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = Library;

    layout
    {
        area(Content)
        {
            group("General")
            {

                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                }
                field(Author; Rec.Author)
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Author Card Page";
                }
                field(Rented; Rec.Rented)
                {
                    ApplicationArea = All;
                }
                field(Series; Rec.Series)
                {
                    ApplicationArea = All;
                }
                field(Genre; Rec.Genre)
                {
                    ApplicationArea = All;
                }
                field("Book Price"; Rec."Book Price")
                {
                    ApplicationArea = All;
                }
            }
            group("Details")
            {
                field(Publisher; Rec.Publisher)
                {
                    ApplicationArea = All;
                }

                field("Publication Date"; Rec."Publication Date")
                {
                    ApplicationArea = All;
                }
                field(Pages; Rec.Pages)
                {
                    ApplicationArea = All;
                }
                field(Prequel; Rec.Prequel)
                {
                    ApplicationArea = All;
                }
                field(Sequel; Rec.Sequel)
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Date Rented"; Rec."Date Rented")
                {
                    ApplicationArea = All;
                }
                field("Date Added"; Rec."Date Added")
                {
                    ApplicationArea = All;
                }
            }
            part("Author Details"; "Author Part")
            {
                SubPageLink = "Author ID" = field("Author Filter");
            }
        }

    }
    trigger OnAfterGetRecord()
    var
        LinkTable: Record "Link Table";
        FilterText: Text;
    begin
        FilterText := '';
        LinkTable.SetFilter(BookID, Rec."Book ID");

        if LinkTable.FindSet() then begin
            FilterText += LinkTable.AuthorID;
            LinkTable.Next();
            repeat
                FilterText += '|' + LinkTable.AuthorID;
            until LinkTable.Next() = 0;

            if FilterText <> Rec."Author Filter" then
                Rec.SetFilter("Author Filter", filterText);
        end;

    end;


}