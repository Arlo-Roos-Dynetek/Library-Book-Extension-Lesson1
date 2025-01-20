codeunit 50121 "Most Rented"
{
    trigger OnRun()
    var
        title1, title2, title3 : Text[100];
        book: Record Library;
        counter, maxRented, medRented, minRented, AmountOfRecords : Integer;
    begin
        counter := 0;//TODO sit init in n procedure
        maxRented := 0;
        medRented := 0;
        minRented := 0;
        title1 := '';
        title2 := '';
        title3 := '';
        AmountOfRecords := book.Count;
        if book.FindFirst() then begin
            repeat
                if maxRented < book."Amount Rented" then begin
                    maxRented := book."Amount Rented";
                    title3 := title2;
                    title2 := title1;
                    title1 := book.Title;
                end
                else if medRented < book."Amount Rented" then begin
                    medRented := book."Amount Rented";
                    title3 := title2;
                    title2 := book.Title;
                end
                else if minRented < book."Amount Rented" then begin
                    minRented := book."Amount Rented";
                    title3 := book.Title;
                end;

                book.Next(+1);
                counter := counter + 1;
            until counter = AmountOfRecords;
        end;

        Message('Most rented books:' + '\•' + title1 + '\•' + title2 + '\•' + title3);
    end;

}