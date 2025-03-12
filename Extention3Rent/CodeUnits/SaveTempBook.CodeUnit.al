codeunit 50301 "Save Temp File"
{

    procedure SaveBook(LibTemp: Record Library)
    var
        Library: Record Library;
        ListOfBooks: Page "List Of Books";
        SearchBookAPI: Codeunit "Search Book Api";
        BookExist: Label 'Book already exists.';

    begin

        // Library.SetCurrentKey(Title);

        // if Library.Get(LibTemp.Title) then begin
        //     Message('3');
        //     Message(BookExist);
        //     exit;
        // end;

        Library.Init();
        Library.Validate(Title, LibTemp.Title);
        library.Validate("Open Library ID", LibTemp."Open Library ID");
        Library.Validate(Description, LibTemp.Description);
        Library.Validate("Date Created", LibTemp."Date Created");
        Library.Validate("Date Added", Today);
        Library.Validate("Author ID", LibTemp."Author ID");
        SearchBookAPI.InsertAuthors(LibTemp."Author ID", LibTemp."Open Library ID");
        Library.Validate(Author, LibTemp.Author);

        Library.Insert(true);
        ListOfBooks.Update();
    end;



    var
        myInt: Integer;
}