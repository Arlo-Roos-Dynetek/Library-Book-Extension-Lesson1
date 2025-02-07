codeunit 50312 "Rank books"
{
    TableNo = "Job Queue Entry";
    trigger OnRun()
    begin

    end;

    local procedure AmountRented()
    var
        Library: Record Library;
        BookLogTable: Record "Book Log Table";
    begin
        if Library.FindSet() then
            repeat begin
                BookLogTable.SetFilter("Book Title", Library.Title);
                BookLogTable.SetRange("Date Rented", CalcDate('<-1M>', Today), Today);
                if BookLogTable.FindSet() then begin
                    Library.Validate("Amount Rented month", BookLogTable.Count);
                end
                else
                    Library.Validate("Amount Rented month", 0);
                Library.Modify()
            end until Library.Next() = 0;
    end;

    local procedure AssignRanking()
    var
        myInt: Integer;
    begin

    end;
}