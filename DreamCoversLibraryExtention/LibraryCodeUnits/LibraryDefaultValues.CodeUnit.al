codeunit 50120 LibraryDefaultValues
{
    trigger OnRun()
    begin
        InsertBook(1, 'The Great Gatsby', 'F. Scott Fitzgerald', false, 'None', 'Classic', 'Scribner', 10.99, DMY2Date(10, 4, 1925), 180, '', '', '');
        InsertBook(2, 'To Kill a Mockingbird', 'Harper Lee', false, 'None', 'Fiction', 'J.B. Lippincott & Co.', 7.99, DMY2Date(11, 7, 1960), 281, '', '', '');
    end;

  local procedure InsertBook(BookID: Integer; Title: Text[400]; Author: Text[200]; Rented: Boolean; Series: Text[100]; Genre: Text[50]; Publisher: Text[150];
                               BookPrice: Decimal; PublicationDate: Date; Pages: Integer; Prequel: Text[100]; Sequel: Text[100]; "Customer Name": Text[100])
    BookRec: Record Library;
    begin
        BookRec.Init();
        BookRec.BookID := BookID;
        BookRec."Title" := Title;
        BookRec."Author" := Author;
        BookRec."Rented" := Rented;
        BookRec."Series" := Series;
        BookRec."Genre" := Genre;
        BookRec."Publisher" := Publisher;
        BookRec."Book Price" := BookPrice;
        BookRec."Publication Date" := PublicationDate;
        BookRec."Pages" := Pages;
        BookRec."Prequel" := Prequel;
        BookRec."Sequel" := Sequel;
        BookRec."Customer Name" := "Customer Name";
        BookRec.Insert();
    end;

    var
        myInt: Integer;
}