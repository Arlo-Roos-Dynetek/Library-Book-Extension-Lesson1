codeunit 50301 "Save Temp File"
{

    procedure SaveBook(LibTemp: Record Library)
    var
        Library: Record Library;
        ListOfBooks: Page "List Of Books";
    begin
        Library.Init();
        Library.Validate(Title, LibTemp.Title);
        library.Validate("Book ID", LibTemp."Book ID");
        Library.Validate(Description, LibTemp.Description);
        Library.Validate("Publication Date", LibTemp."Publication Date");
       // Library.Validate(Author, LibTemp.Author);
        Library.Validate("Date Added",Today);

        Library.Insert(true);
        ListOfBooks.Update();
    end;

    var
        myInt: Integer;
}