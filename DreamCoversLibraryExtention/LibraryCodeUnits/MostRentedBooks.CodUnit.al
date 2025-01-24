/// <summary>
/// Codeunit Most Rented (ID 50121).
/// </summary>
codeunit 50121 "Most Rented"
{
    // this Procedure is used to order the library according to the amount rented field.
    // it then orders it according to descending order.
    // then it goes to the first record.
    // now it runs through the first three records to find the top three most rented records.
    local procedure FindTop3RentedBooks()
    var
        Library: Record Library;
        Title: Text;
        count: Integer;
    begin
        Library.SetCurrentKey("Amount Rented");
        Library.Ascending(false);
        Library.FindFirst();
        Title := 'Most rented books:';
        for count := 1 to 3 do begin
            Title := Title + '\• ' + Library.Title + ' : ' + Format(Library."Amount Rented");
            Library.Next();
        end;
        Message('Most rented books:' + Title);
    end;


    trigger OnRun()
    var
    // title1, title2, title3 : Text[100];
    // book: Record Library;
    // counter, maxRented, medRented, minRented, AmountOfRecords : Integer;
    begin
        FindTop3RentedBooks();

        // counter := 0;//TODO sit init in n procedure
        // maxRented := 0;
        // medRented := 0;
        // minRented := 0;
        // title1 := '';
        // title2 := '';
        // title3 := '';
        // AmountOfRecords := book.Count;
        // if book.FindFirst() then begin
        //     repeat
        //         if maxRented < book."Amount Rented" then begin
        //             maxRented := book."Amount Rented";
        //             title3 := title2;
        //             title2 := title1;
        //             title1 := book.Title;
        //         end
        //         else if medRented < book."Amount Rented" then begin
        //             medRented := book."Amount Rented";
        //             title3 := title2;
        //             title2 := book.Title;
        //         end
        //         else if minRented < book."Amount Rented" then begin
        //             minRented := book."Amount Rented";
        //             title3 := book.Title;
        //         end;

        //         book.Next(+1);
        //         counter := counter + 1;
        //     until counter = AmountOfRecords;
        // end;

        // Message('Most rented books:' + '\•' + title1 + '\•' + title2 + '\•' + title3);

    end;



}