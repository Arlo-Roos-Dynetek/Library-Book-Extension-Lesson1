codeunit 50127 "Filter With Dates"
{


    procedure FilterDates(var Library: Record Library)
    var
        StartDate, EndDate : Date;

    begin
        StartDate := CalcDate('<-2y>', Today());
        EndDate := System.Today;
        Library.SetFilter(Library."Publication Date", '%1..9%', StartDate, EndDate);

    end;


}