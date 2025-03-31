codeunit 50301 "Save Temp File"
{

    procedure SaveBook(LibTemp: Record Library;var Display: Boolean): Boolean
    var
        Library: Record Library;
        ListOfBooks: Page "List Of Books";
        SearchBookAPI: Codeunit "Search Book Api";
        BookExist: Label 'Book already exists.';
        LibrarytableSetup: Record "Library table Setup";
        LinkTable: Record "Link Table";

    begin

        Library.Init();

        Library.Validate(Title, LibTemp.Title);
        library.Validate("Open Library ID", LibTemp."Open Library ID");
        Library.Validate(Description, LibTemp.Description);
        Library.Validate("Date Created", LibTemp."Date Created");
        Library.Validate("Date Added", Today);
        Library.Validate("Author ID", LibTemp."Author ID");
        Library.Insert(true);
        // Library.Get(LibTemp."Open Library ID");
        SearchBookAPI.InsertAuthors(LibTemp."Author ID", LibTemp."Open Library ID", Library."Book ID", LinkTable, LibTemp, Display);
        SaveAuthorDetailsToBook(LibTemp, Library, SearchBookAPI);
        Library.Modify(true);
        ListOfBooks.Update();
        exit(Display);
    end;

    procedure SaveAuthorDetailsToBook(var LibTemp: Record Library; var Library: Record Library; var SearchBookAPI: Codeunit "Search Book Api")
    begin
        Library.Validate(Author, LibTemp.Author);
        Library.Validate("Cover ID", LibTemp."Cover ID");
        SearchBookAPI.GetDescription(Library);
        if Library."Cover ID" <> '' then
            SearchBookAPI.GetBookCover(Library);
    end;
}