/// <summary>
/// Codeunit Filter Procedures (ID 50200).
/// </summary>
codeunit 50200 "Filter Procedures"
{
    // this code unit contains all the logic for the filtering that is done on the "Grouped information page".
    /// <summary>
    /// FilterBetweenTwoDates.
    /// </summary>
    /// <param name="DateStart">Date.</param>
    /// <param name="DateFinished">Date.</param>
    /// <param name="Library">VAR Record Library.</param>
    /// This procedure filters between a range of dates.
    procedure FilterBetweenTwoDates(DateStart: Date; DateFinished: Date; var Library: Record Library)
    var
        DateErrorMessage: Text;
    begin
        DateErrorMessage := 'Please make sure that all the Date Field are filled in.';
        if (DateStart <> 0D) and (DateFinished <> 0D) then begin
            Library.SetFilter(Library."Publication Date", '%1..%2', DateStart, DateFinished)
        end
        else
            Message(DateErrorMessage);
    end;

    /// <summary>
    /// FilterWithOneDate.
    /// </summary>
    /// <param name="DateStart">Date.</param>
    /// <param name="Library">VAR Record Library.</param>
    /// This procedure filters using only one date.
    procedure FilterWithOneDate(DateStart: Date; var Library: Record Library)
    var
        DateErrorMessage: Text;
    begin
        DateErrorMessage := 'Please make sure that the Date Start Field is filled in.';
        if DateStart <> 0D then begin
            Library.SetFilter(Library."Publication Date", '%1', DateStart);
        end
        else
            Message(DateErrorMessage);
    end;

    /// <summary>
    /// FilterPriceRange.
    /// </summary>
    /// <param name="PriceMin">Decimal.</param>
    /// <param name="PriceMax">Decimal.</param>
    /// <param name="Library">VAR Record Library.</param>
    /// This value filters between a range of price values.
    procedure FilterPriceRange(PriceMin: Decimal; PriceMax: Decimal; var Library: Record Library)
    var
        PriceErrorMessage: Text;
    begin
        PriceErrorMessage := 'Please make sure that you have filled in both the Price Max and Price Min fields./ Also make sure that the smallest value is in the "minimum" field and the biggest number is in the "maximum" field.';
        if (PriceMin >= 0) and (PriceMax > PriceMin) then begin
            Library.SetFilter(Library."Book Price", '%1..%2', PriceMin, PriceMax);
        end
        else
            Message(PriceErrorMessage);
    end;

    /// <summary>
    /// FilterSinglePrice.
    /// </summary>
    /// <param name="PriceMin">Decimal.</param>
    /// <param name="Library">VAR Record Library.</param>
    /// This procedure Filters based ona single price value.
    procedure FilterSinglePrice(PriceMin: Decimal; var Library: Record Library)
    var
        PriceErrorMessage: Text;
    begin
        PriceErrorMessage := 'Please make sure that you have filled in the Price Min fields.';
        if (PriceMin >= 0) then begin
            Library.SetFilter(Library."Book Price", '%1', PriceMin);
        end
        else
            Message(PriceErrorMessage);
    end;

    /// <summary>
    /// FilterByAmountOfTimesRented.
    /// </summary>
    /// <param name="AmountRented">Integer.</param>
    /// <param name="Library">VAR Record Library.</param>
    /// This procedure filters according to the amount of times the book has been rented
    procedure FilterByAmountOfTimesRented(AmountRented: Integer; var Library: Record Library)
    var
        RentedErrorMessage: Text;
    begin
        RentedErrorMessage := 'Please fill in a valid Rented Amount.';

        if AmountRented >= 0 then begin
            Library.SetFilter(Library."Amount Rented", '%1', AmountRented);
        end
        else
            Message(RentedErrorMessage);
    end;

    /// <summary>
    /// FilterByText.
    /// </summary>
    /// <param name="WordSearch">Text.</param>
    /// <param name="TopicToSearchBy">Enum "DropDown Enum".</param>
    /// <param name="Library">VAR Record Library.</param>
    /// This procedure is used to determine which topic has been chosen and than it also uses the input received from the used to set a filter
    /// based on what the user has inputted.
    procedure FilterByText(WordSearch: Text; TopicToSearchBy: Enum "DropDown Enum"; var Library: Record Library)
    var
        WordSearchError, GenreName, FilterWord, GenreErrorMessage : Text;
        "Genre List": Enum "Genre List";
        GenreCollection: List of [Text];
        MoreTThanOne: Boolean;
    begin
        WordSearchError := 'Please make sure that both the Topic field and the Search By Text field has been filled in.';
        if WordSearch <> '' then begin
            case TopicToSearchBy of
                TopicToSearchBy::Title:
                    Library.SetFilter(Library.Title, '%1', '@*' + WordSearch + '*');

                TopicToSearchBy::Author:
                    Library.SetFilter(Library.Author, '%1', '@*' + WordSearch + '*');

                TopicToSearchBy::Publisher:
                    Library.SetFilter(Library.Publisher, '%1', '@*' + WordSearch + '*');

                TopicToSearchBy::Genre:
                    begin
                        GenreErrorMessage := 'Genre not Found.';
                        FilterWord := '';
                        MoreTThanOne := false;
                        GenreCollection := "Genre List".Names;
                        foreach GenreName in GenreCollection do begin
                            if GenreName.ToLower().Contains(WordSearch.ToLower()) then begin
                                if MoreTThanOne = true then begin
                                    FilterWord := FilterWord + '|' + GenreName;
                                end
                                else begin
                                    MoreTThanOne := true;
                                    FilterWord := GenreName;
                                end;
                            end;
                        end;
                        if FilterWord <> '' then
                            Library.SetFilter(Genre, FilterWord)
                        else
                            Message(GenreErrorMessage);
                    end;

                else
                    Message('No records Found matching your searching details :(');
            end;
        end
        else
            Message(WordSearchError);


    end;

    /// <summary>
    /// FilterByGenre.
    /// </summary>
    /// <param name="Genre List">Enum "Genre List".</param>
    /// <param name="Library">VAR Record Library.</param>
    /// This procedure is used to filter the table by "Genre".
    
    [TryFunction]
    procedure FilterByGenre("Genre List": Enum "Genre List"; var Library: Record Library)
    var

    begin
        Library.SetFilter(Genre, Format("Genre List"));
    end;

    var
        "Genre List": Enum "Genre List";
}