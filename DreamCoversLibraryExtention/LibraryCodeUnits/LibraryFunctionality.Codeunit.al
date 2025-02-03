/// <summary>
/// Codeunit All Actions (ID 50140).
/// </summary>
codeunit 50140 "Library Functionality"
{
    trigger OnRun()
    begin

    end;
    /// <summary>
    /// Navigate_AddSequel.
    /// </summary>
    /// <param name="savedRec">Record Library.</param>
    /// This procedure is used to add a sequel to an already existing boom in the Library table.
    /// It also automatically fills in the Author, Prequel , and Series fields.
    procedure Navigate_AddSequel(savedRec: Record Library)
    var
        tempRec: Record Library temporary;

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
            save(TempRec);
        end;

    end;

    // This procedure is used to filter between the current date and the date that the user enters.

    /// <summary>
    /// FilterDates.
    /// </summary>
    /// <param name="Library">VAR Record Library.</param>
    procedure FilterDates(var Library: Record Library)
    var
        StartDate, EndDate : Date;

    begin
        StartDate := CalcDate('<-2y>', Today());
        EndDate := System.Today;
        Library.SetFilter(Library."Publication Date", '%1..9%', StartDate, EndDate);

    end;


    




    // this procedure only saves the new record to the library.
    /// <summary>
    /// save.
    /// </summary>
    /// <param name="Book">Temporary Record Library.</param>
    procedure save(Book: Record Library temporary)
    var
        Lib: Record Library;
    begin
        Lib.Init();
        Lib := Book;
        Lib.Insert(true);
    end;
}