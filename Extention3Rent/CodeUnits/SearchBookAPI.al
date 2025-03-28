codeunit 50300 "Search Book Api"
{


    procedure SearchBooks(SearchBook: Text; var TempLibrary: Record Library)
    var
        AATJSONHelper: Codeunit "AAT JSON Helper";

        SearchQueryForBookSearch, blankString : Text;
        ResponseObject: JsonObject;
        LinesArray, ExtractedArray : JsonArray;
        LinesToken, JsonToken : JsonToken;
        DataObject: JsonObject;
        DataArray: array[10] of Text;
        LibrarytableSetup: Record "Library table Setup";
        SearchBookCover: Text[1000];
        InStream: Instream;
    begin
        LibrarytableSetup.Get();
        SearchQueryForBookSearch := '/search.json?title=' + SearchBook.Replace(' ', '+') + '&page=1&limit=50';

        SendGetRequest(AATJSONHelper, ResponseObject, SearchQueryForBookSearch, LibrarytableSetup."API No.", 'Search Book');


        TempLibrary.DeleteAll();
        if AATJSONHelper.GetJsonArray(ResponseObject, 'docs', LinesArray) then
            foreach LinesToken in LinesArray do begin

                DataObject := LinesToken.AsObject();

                TempLibrary.Init();
                // TempLibrary.Validate(Title, AATJSONHelper.SelectJsonValueAsText('$.title',false));
                // TempLibrary.Validate("Open Library ID", AATJSONHelper.SelectJsonValueAsText('$.key', false));
                TempLibrary.Validate(Title, AATJSONHelper.GetJsonTokenAsValue(DataObject, 'title').AsText());
                TempLibrary.Validate("Open Library ID", AATJSONHelper.GetJsonTokenAsValue(DataObject, 'key').AsCode());

                if DataObject.Get('cover_edition_key', JsonToken) then
                    TempLibrary.Validate("Cover ID", AATJSONHelper.GetJsonTokenAsValue(DataObject, 'cover_edition_key').AsText());
                // TempLibrary.Validate("Cover ID", AATJSONHelper.SelectJsonValueAsText('$.cover_edition_key', false));

                if AATJSONHelper.GetJsonArray(DataObject, 'author_key', ExtractedArray) then begin
                    ExtractFromArray(blankString, ExtractedArray);
                end;
                TempLibrary.Validate("Author ID", blankString);

                blankString := '';
                if AATJSONHelper.GetJsonArray(DataObject, 'author_name', ExtractedArray) then begin
                    ExtractFromArray(blankString, ExtractedArray);
                end;
                TempLibrary.Validate(Author, blankString);

                TempLibrary.Insert(true);
            end
    end;

    procedure InsertAuthors(BlankString: Text; OpenLibraryID: Code[1000]; BookID: Code[20]; var LinkTable: Record "Link Table"; var LibTemp: Record Library)
    var
        Author: Record Author;
        CodeArray: List of [Text];
        Item: Text;

    begin
        CodeArray := BlankString.Split(',');
        foreach Item in CodeArray do begin
            if not Author.Get(Item) then begin
                Author.Init();
                LinkTable.Init();
                Author.Validate("Author ID", Item);
                LinkTable.Validate(AuthorID, Item);
                LinkTable.Validate(BookID, BookID);


                GetAuthorDetails(Item, OpenLibraryID, Author);
                GetAuthorImage(Author);
                LinkTable.Insert(true);
                Author.Insert(true);


            end
            else begin

                LinkTable.Init();
                Author.Validate("Author ID", Item);
                LinkTable.Validate(AuthorID, Item);
                LinkTable.Validate(BookID, BookID);
                LinkTable.Insert(true);
                GetAuthorDetails(Item, OpenLibraryID, Author);
                Message(FailedMessage);
                exit;
            end;


        end;
        Message(SuccessMessage);

        // Library.Validate(Author, LibTemp.Author);
        // Library.Validate("Cover ID", LibTemp."Cover ID");
        // SearchBookAPI.GetDescription(Library);
        // if Library."Cover ID" <> '' then
        //     SearchBookAPI.GetBookCover(Library);
    end;

    internal procedure SendGetRequest(var AATJSONHelper: Codeunit "AAT JSON Helper"; var ResponseObject: JsonObject; var SearchQuery: Text; ApiNo: Text; TypeOfSearch: Text)
    var
        AATRestHelper: Codeunit "AAT REST Helper";
        ReferenceID: Text[2000];
        StatusMessage: Text;
    begin
        AATRestHelper.LoadAPIConfig(ApiNo);
        AATRestHelper.Initialize('GET', AATRestHelper.GetAPIConfigBaseEndpoint() + SearchQuery);
        AATRestHelper.SetContentType('application/json');
        ReferenceID := TypeOfSearch + '/' + SearchQuery;
        if not AATRESTHelper.Send(ReferenceID) then begin
            if AATRESTHelper.IsTransmitIssue() then
                Error('%1', GetLastErrorText());

            StatusMessage := StrSubstNo('%1, %2, %3', AATRESTHelper.GetHttpStatusCode(), AATRESTHelper.GetResponseContentAsText(), AATRESTHelper.GetResponseReasonPhrase());
            Error(StatusMessage);
            exit;
        end;
        AATJSONHelper.InitializeJsonObjectFromText(AATRestHelper.GetResponseContentAsText());
        ResponseObject := AATJSONHelper.GetJsonObject();
    end;

    local procedure GetAuthorDetails(AuthorID: Code[100]; OpenLibraryID: Code[100]; var Author: Record Author)
    var
        AATJSONHelper: Codeunit "AAT JSON Helper";
        ResponseObject, DataObject : JsonObject;
        SearchQuery, InputStringBirth, InputStringDeath : Text[100];
        IsConverted: Boolean;
        JsonToken, LinesToken : JsonToken;
        LinesArray: JsonArray;
        AuthorExist: Label 'Author already exists';
        LibrarytableSetup: Record "Library table Setup";
        OutStream: OutStream;

    begin
        LibrarytableSetup.Get();
        SearchQuery := '/authors/' + AuthorID + '.json';
        SendGetRequest(AATJSONHelper, DataObject, SearchQuery, LibrarytableSetup."API No.", 'Author Personal Details');

        if Author.Get(AATJSONHelper.GetJsonTokenAsValue(DataObject, 'name').AsText()) then begin
            Message(AuthorExist);
            exit;
        end;
        if DataObject.Get('personal_name', JsonToken) then
            Author.Validate("Personal Name", AATJSONHelper.SelectJsonValueAsText('$.personal_name', false));
        // Author.Validate("Personal Name", AATJSONHelper.GetJsonTokenAsValue(DataObject, 'personal_name').AsText());

        if DataObject.Get('name', JsonToken) then
            Author.Validate(Name, AATJSONHelper.SelectJsonValueAsText('$.name', false));
        // Author.Validate(Name, AATJSONHelper.GetJsonTokenAsValue(DataObject, 'name').AsText());


        Author.Bio.CreateOutStream(OutStream);
        if DataObject.Get('bio', JsonToken) then
            if JsonToken.IsObject then begin
                // AATJSONHelper.GetJsonObject(ResponseObject, 'bio', DataObject);
                // DataObject := JsonToken.AsObject();
                // Author.Validate(Bio, AATJSONHelper.GetJsonTokenAsValue(DataObject, 'value').AsText());
                Outstream.WriteText(AATJSONHelper.SelectJsonValueAsText('$.bio.value', false));

            end
            else
                Outstream.WriteText(AATJSONHelper.SelectJsonValueAsText('$.bio', false));
        // Author.Validate(Bio, AATJSONHelper.SelectJsonValueAsText('$.bio', false));
        // Author.Validate(Bio, AATJSONHelper.GetJsonTokenAsValue(ResponseObject, 'bio').AsText());

        SearchQuery := '/search/authors.json?q=' + Author.Name.Replace(' ', '+');
        SendGetRequest(AATJSONHelper, ResponseObject, SearchQuery, LibrarytableSetup."API No.", 'Author Extra Details');

        if AATJSONHelper.GetJsonArray(ResponseObject, 'docs', LinesArray) then begin
            foreach LinesToken in LinesArray do begin
                DataObject := LinesToken.AsObject();
                if AuthorID = AATJSONHelper.GetJsonTokenAsValue(DataObject, 'key').AsText() then begin

                    Author.Validate("Author ID", AuthorID);
                    Author.Validate("Open Library ID", OpenLibraryID);


                    // Author.Validate("Birth Date", AATJSONHelper.GetJsonTokenAsValue(DataObject, 'birth_date').AsText());
                    Author.Validate("Birth Date", AATJSONHelper.SelectJsonValueAsText('$.birth_date', false));

                    if DataObject.Get('death_date', JsonToken) then
                        Author.Validate("Death Date", AATJSONHelper.GetJsonTokenAsValue(DataObject, 'death_date').AsText());
                    // Author.Validate("Death Date", AATJSONHelper.SelectJsonValueAsText('$.death_date', false));
                    if DataObject.Get('top_work', JsonToken) then
                        Author.Validate("Top Work", AATJSONHelper.GetJsonTokenAsValue(DataObject, 'top_work').AsText());
                    // Author.Validate("Top Work", AATJSONHelper.SelectJsonValueAsText('$.top_work', false));
                    if DataObject.Get('work_count', JsonToken) then
                        Author.Validate("Work Count", AATJSONHelper.GetJsonTokenAsValue(DataObject, 'work_count').AsText());
                    // Author.Validate("Work Count", AATJSONHelper.SelectJsonValueAsText('$.work_count', false));
                end;
            end;
        end;
    end;

    local procedure ExtractFromArray(var blankString: Text; var ExtractedArray: JsonArray)
    var
        IsFirst: Boolean;
        LinesToken: JsonToken;
    begin
        IsFirst := true;
        blankString := '';
        foreach LinesToken in ExtractedArray do begin
            if IsFirst <> true then
                blankString += ',' + LinesToken.AsValue().AsText()
            else begin
                blankString += LinesToken.AsValue().AsText();
                IsFirst := false;
            end;
        end;
    end;

    local procedure GetImage(var InStream: InStream; var SearchBookCover: Text)
    var
        AATRestHelper: Codeunit "AAT REST Helper";
        HttpClient: HttpClient;
        httpResonseMessage: HttpResponseMessage;
        ErrorMessage: Label 'Failed to download Image';
    begin
        AATRestHelper.LoadAPIConfig('API00005');
        HttpClient.Get(AATRestHelper.GetAPIConfigBaseEndpoint() + SearchBookCover, httpResonseMessage);
        if httpResonseMessage.IsSuccessStatusCode then
            httpResonseMessage.Content.ReadAs(InStream)
        else
            Message(ErrorMessage);
    end;

    procedure GetBookCover(var TempLibrary: Record Library)
    var
        InStream: InStream;
        SearchBookCover: Text;
    begin
        SearchBookCover := '/b/olid/' + TempLibrary."Cover ID" + '.jpg';
        GetImage(InStream, SearchBookCover);

        TempLibrary."Book Cover".ImportStream(InStream, '');
    end;

    local procedure GetAuthorImage(var Author: Record Author)
    var
        SearchAuthorImage: Text[500];
        InStream: Instream;
    begin

        SearchAuthorImage := '/a/olid/' + Author."Author ID" + '.jpg';
        GetImage(InStream, SearchAuthorImage);

        Author.Image.ImportStream(InStream, '');
    end;

    procedure GetDescription(var Library: Record Library)
    var
        AATJSONHelper: Codeunit "AAT JSON Helper";
        SearchQueryForBookDescriptionSearch: Text;
        ResponseObject2: JsonObject;
        DataObject2: JsonObject;
        JsonToken: JsonToken;
        LibrarytableSetup: Record "Library table Setup";
        Outstream: OutStream;

    begin
        LibrarytableSetup.Get();
        SearchQueryForBookDescriptionSearch := Library."Open Library ID" + '.json';
        SendGetRequest(AATJSONHelper, ResponseObject2, SearchQueryForBookDescriptionSearch, LibrarytableSetup."API No.", 'Search Book Description');
        Library.Description.CreateOutStream(Outstream);
        if ResponseObject2.Get('description', JsonToken) then
            if JsonToken.IsObject then begin
                // //AATJSONHelper.GetJsonObject(ResponseObject2, 'description', DataObject2);
                DataObject2 := JsonToken.AsObject();
                // //TempLibrary.Validate(Description, AATJSONHelper.GetJsonTokenAsValue(DataObject2, 'value').AsText());
                // Library.Validate(Description, AATJSONHelper.SelectJsonValueAsText('$.value', false));
                Outstream.WriteText(AATJSONHelper.SelectJsonValueAsText('$.value', false));
            end else
                Outstream.WriteText(AATJSONHelper.SelectJsonValueAsText('$.description', false));
        // Library.Validate(Description, AATJSONHelper.SelectJsonValueAsText('$.description', false));
        // //TempLibrary.Validate(Description, AATJSONHelper.GetJsonTokenAsValue(ResponseObject2, 'description').AsText());


        // AATJSONHelper.GetJsonObject(ResponseObject2, 'created', DataObject2);
        // TempLibrary.Validate("Date Created", DT2Date(AATJSONHelper.GetJsonTokenAsValue(DataObject2, 'value').AsDateTime()));
        Library.Validate("Date Created", DT2Date(AATJSONHelper.SelectJsonValueAsDateTime('$.created.value', false)));

    end;

    var
        SuccessMessage: Label 'Successfully saved Book and Author.';
        FailedMessage: Label 'Failed to save Book Author.';

}