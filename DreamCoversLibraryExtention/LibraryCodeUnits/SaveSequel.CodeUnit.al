/// <summary>
/// Codeunit Save Sequel (ID 50129).
/// </summary>
codeunit 50129 "Save Sequel"
{
// this procedure only saves the new record to the library.
    /// <summary>
    /// SaveSequel.
    /// </summary>
    /// <param name="Sequel">Temporary Record Library.</param>
    procedure SaveSequel(Sequel: Record Library temporary)//TODO Kan gemerge word met save book
    var
        recordNew, recordOld : Record Library;

    begin
        recordNew.Init();
        recordNew := Sequel;
        recordNew.Insert(true);

    end;
}