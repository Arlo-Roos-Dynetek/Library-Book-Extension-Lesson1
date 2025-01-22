/// <summary>
/// Codeunit SequelCode (ID 50128).
/// </summary>
codeunit 50128 SequelCode
{
    // THis Procedure is used to add a new book to an already existing series of books.
    // It also saves the new book as the sequel to the already existing book.
    // lastly it saves the already existing book as the prequel of the new book.

    /// <summary>
    /// Navigate_AddSequel.
    /// </summary>
    /// <param name="savedRec">Record Library.</param>
    procedure Navigate_AddSequel(savedRec: Record Library)
    var
        tempRec: Record Library temporary;
        SaveSequel: Codeunit "Save Sequel";
    begin
        tempRec.Init();
        tempRec.Validate(Author, savedRec.Author);
        tempRec.Validate(Prequel, savedRec.Title);
        tempRec.Validate(Series, savedRec.Series);

        //tempRec.Prequel := savedRec.Title;
        //tempRec.Series := savedRec.Series;
        tempRec.Insert(true);
        if Page.RunModal(Page::"Sequel", tempRec) = Action::LookupOK then begin
            savedRec.Validate(Sequel, tempRec.Title);
            savedRec.Modify(true);
            SaveSequel.SaveSequel(TempRec);
        end;

    end;
}


