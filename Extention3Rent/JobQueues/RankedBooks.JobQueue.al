codeunit 50312 "Rank books"
{
    TableNo = "Job Queue Entry";
    trigger OnRun()
    begin
        AmountRented();
        AssignRanking();
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
                Library.Modify();
            end until Library.Next() = 0;
    end;

    local procedure AssignRanking()
    var
        Library: Record Library;
        BookLogTable: Record "Book Log Table";
        RankCounter: Integer;
    begin
        Library.SetCurrentKey("Amount Rented month");
        Library.Ascending(false);
        RankCounter := 1;
        if Library.FindSet() then
            repeat
                Library.Validate("Monthly Rank", RankCounter);
                library.Modify();
                RankCounter += 1;

            until Library.Next() = 0;
    end;
}