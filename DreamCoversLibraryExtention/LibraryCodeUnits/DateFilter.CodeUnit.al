codeunit 50127 "Filter With Dates"
{


    procedure FilterDates(var filterRecord: Record Library)
    var
        StartDate, EndDate : Date;

    begin
        StartDate := CalcDate('<-2y>', Today());
        EndDate := System.Today;
        filterRecord.SetFilter(filterRecord."Publication Date", '%1..9%', StartDate, EndDate);

    end;

    var
        myInt: Integer;
}