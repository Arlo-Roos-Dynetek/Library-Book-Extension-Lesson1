/// <summary>
/// Page Grouped Book Info (ID 50201).
/// </summary>
page 50201 "Grouped Book Info"
{
    // this page displays the grouped information about the books as well as the fields that allow ths user to add filters.
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = Library;

    layout
    {
        area(Content)
        {
            group("Filter Fields")
            {
                field("Published Date Start"; Date1)
                {
                    ToolTip = 'This is the date from which you want to start searching from, or if you can only search for a book on a specific date.';
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        System.Clear(Date2);
                        "Filter Procedures".FilterWithOneDate(Date1, Rec);
                        CurrPage.Update();
                    end;
                }
                field("Published Date End"; Date2)
                {
                    ApplicationArea = all;
                    ToolTip = 'This field is used when searching within a range of dates.';
                    trigger OnValidate()
                    var

                        "Filter Procedures": Codeunit "Filter Procedures";
                    begin
                        "Filter Procedures".FilterBetweenTwoDates(Date1, Date2, Rec);
                        CurrPage.Update();
                    end;
                }
                field("Minimum Price"; PriceMin)
                {
                    ApplicationArea = all;
                    ToolTip = 'This field can be used used to search price based on a single value or it can be used with Price Max Filed to search for a range.';
                    trigger OnValidate()
                    begin
                        PriceMax := 0;
                        "Filter Procedures".FilterSinglePrice(PriceMin, Rec);
                        CurrPage.Update();
                    end;
                }
                field("Maximum Price"; PriceMax)
                {
                    ToolTip = 'This field is used when searching within a range of prices.';
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        "Filter Procedures".FilterPriceRange(PriceMin, PriceMax, Rec);
                        CurrPage.Update();
                    end;
                }
                field("Amount of Times Rented"; AmountRented)
                {
                    ToolTip = 'THis field is used to search how many times a book has been searched';
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        Rec.SetFilter("Amount Rented", AmountRented);
                        // "Filter Procedures".FilterByAmountOfTimesRented(AmountRented, Rec);
                        CurrPage.Update();
                    end;
                }
                field("Topic for text filter"; "Search by text Enum")
                {
                    Caption = 'Search by: ';
                    ToolTip = 'This drop down list provides you with the options to choose from';
                    ApplicationArea = all;
                }
                field("Search by Text"; TextSearch)
                {
                    ToolTip = 'This field allows you to type what you want to search.';
                    Caption = 'Search: ';
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        "Filter Procedures".FilterByText(TextSearch, "Search by text Enum", Rec);
                        CurrPage.Update();
                    end;
                }
                field(GenreFilter; "Genre List")
                {
                    Caption = 'Filter according to genre';

                    ApplicationArea = all;
                    trigger OnValidate()
                    var
                        GenreText: Text;
                    begin
                        "Filter Procedures".FilterByGenre("Genre List", Rec);
                        CurrPage.Update();
                    end;

                }
            }

            repeater("Grouped Info")
            {
                Editable = false;
                field("Book ID"; Rec."Book ID")
                {
                    ApplicationArea = All;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                }

                field(Author; Rec.Author)
                {
                    ApplicationArea = All;
                }
                field(Genre; Rec.Genre)
                {
                    ApplicationArea = All;
                }
                field(Rented; Rec.Rented)
                {
                    ApplicationArea = All;
                }
                field("Amount Rented"; Rec."Amount Rented")
                {
                    ApplicationArea = All;
                }
                field("Date Rented"; Rec."Date Rented")
                {
                    ApplicationArea = All;

                }
                field("Date Returned"; Rec."Date Returned")
                {
                    ApplicationArea = All;

                }
                field("Book Price"; Rec."Book Price")
                {
                    ApplicationArea = All;
                }
                field(Pages; Rec.Pages)
                {
                    ApplicationArea = All;
                }
                field(Sequel; Rec.Sequel)
                {
                    ApplicationArea = All;
                }
                field(Prequel; Rec.Prequel)
                {
                    ApplicationArea = All;
                }
                field(Series; Rec.Series)
                {
                    ApplicationArea = All;
                }
                field(Publisher; Rec.Publisher)
                {
                    ApplicationArea = All;
                }
                field("Publication Date"; Rec."Publication Date")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Customer ID"; Rec."Customer ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Clear All Filters")
            {
                Image = ClearFilter;
                trigger OnAction()
                var
                    "Clear Filters": Codeunit "Clear Filters";
                begin
                    "Clear Filters".ClearFilter(Rec);
                    System.Clear(Date1);
                    System.Clear(Date2);
                    System.Clear(PriceMax);
                    System.Clear(PriceMin);
                    System.Clear(TextSearch);
                    System.Clear(AmountRented);
                    System.Clear("Genre List");
                    System.Clear("Search by text Enum");
                    CurrPage.Update();
                end;
            }
        }
    }

    var
        Date1, Date2 : Date;
        PriceMin, PriceMax : Decimal;
        AmountRented: Text;
        TextSearch, Topic : Text[40];
        "Filter Procedures": Codeunit "Filter Procedures";
        "Search by text Enum": Enum "DropDown Enum";
        "Genre List": Enum "Genre List";


}