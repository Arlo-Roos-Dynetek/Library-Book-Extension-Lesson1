/// <summary>
/// Codeunit Save Books (ID 50126).
/// </summary>
codeunit 50126 "Save Books"
{
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