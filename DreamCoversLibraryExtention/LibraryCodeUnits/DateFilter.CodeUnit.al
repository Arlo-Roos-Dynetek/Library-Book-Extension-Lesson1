/// <summary>
/// Codeunit Filter With Dates (ID 50127).
/// </summary>
codeunit 50127 "Filter With Dates"
{
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


}