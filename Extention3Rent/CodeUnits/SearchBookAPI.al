codeunit 50300 "Search Book Api"
{


    procedure SearchBooks(SearchBook: Text; var TempLibrary: Record Library)
    var
        AATJSONHelper: Codeunit "AAT JSON Helper";

        SearchQuery, SearchQuery2, blankString : Text;
        ResponseObject, ResponseObject2 : JsonObject;
        LinesArray, LinesArray2 : JsonArray;
        LinesToken, JsonToken : JsonToken;
        DataObject, DataObject2 : JsonObject;
        DataArray: array[10] of Text;
        LibrarytableSetup: Record "Library table Setup";
    begin
        LibrarytableSetup.Get();
        SearchQuery := '/search.json?title=' + SearchBook.Replace(' ', '+') + '&page=1&limit=10';

        SendGetRequest(AATJSONHelper, ResponseObject, SearchQuery, LibrarytableSetup."API No.", 'Search Book');


        TempLibrary.DeleteAll();
        if AATJSONHelper.GetJsonArray(ResponseObject, 'docs', LinesArray) then
            foreach LinesToken in LinesArray do begin

                DataObject := LinesToken.AsObject();

                TempLibrary.Init();
                TempLibrary.Validate(Title, AATJSONHelper.GetJsonTokenAsValue(DataObject, 'title').AsText());
                TempLibrary.Validate("Open Library ID", AATJSONHelper.GetJsonTokenAsValue(DataObject, 'key').AsCode());

                if AATJSONHelper.GetJsonArray(DataObject, 'author_key', LinesArray2) then begin
                    ExtractAuthorID(blankString, LinesArray2);
                end;
                TempLibrary.Validate("Author ID", blankString);

                blankString := '';
                if AATJSONHelper.GetJsonArray(DataObject, 'author_name', LinesArray2) then begin
                    ExtractAuthorID(blankString, LinesArray2);
                end;
                TempLibrary.Validate(Author, blankString);

                SearchQuery2 := TempLibrary."Open Library ID" + '.json';
                SendGetRequest(AATJSONHelper, ResponseObject2, SearchQuery2, LibrarytableSetup."API No.", 'Search Book Description');

                if ResponseObject2.Get('description', JsonToken) then
                    if JsonToken.IsObject then begin
                        // AATJSONHelper.GetJsonObject(ResponseObject2, 'description', DataObject2);
                        DataObject2 := JsonToken.AsObject();
                        // TempLibrary.Validate(Description, AATJSONHelper.GetJsonTokenAsValue(DataObject2, 'value').AsText());
                        TempLibrary.Validate(Description, AATJSONHelper.SelectJsonValueAsText('$.value', false));
                    end else
                        TempLibrary.Validate(Description, AATJSONHelper.SelectJsonValueAsText('$.description', false));
                // TempLibrary.Validate(Description, AATJSONHelper.GetJsonTokenAsValue(ResponseObject2, 'description').AsText());


                // AATJSONHelper.GetJsonObject(ResponseObject2, 'created', DataObject2);
                // TempLibrary.Validate("Date Created", DT2Date(AATJSONHelper.GetJsonTokenAsValue(DataObject2, 'value').AsDateTime()));
                TempLibrary.Validate("Date Created", DT2Date(AATJSONHelper.SelectJsonValueAsDateTime('$.created.value', false)));
                TempLibrary.Insert(true);
            end
    end;

    procedure InsertAuthors(BlankString: Text; OpenLibraryID: Code[1000])
    var
        Author: Record Author;
        CodeArray: List of [Text];
        Item: Text;
        SuccessMessage: Label 'Successfully saved Book and Author.';
        FailedMessage: Label 'Failed to save Book Author.';

    begin
        CodeArray := BlankString.Split(',');
        foreach Item in CodeArray do begin
            if not Author.Get(Item) then begin
                Author.Init();
                Author.Validate("Author ID", Item);
                GetAuthorDetails(Item, OpenLibraryID, Author);
                Author.Insert(true);

            end
            else begin
                Message(FailedMessage);
                exit;
            end;


        end;
        Message(SuccessMessage);
    end;

    internal procedure SendGetRequest(var AATJSONHelper: Codeunit "AAT JSON Helper"; var ResponseObject: JsonObject; var SearchQuery: Text; ApiNo: Text; TypeOfSearch: Text)
    var
        AATRestHelper: Codeunit "AAT REST Helper";
        ReferenceID: Text[2000];
    begin
        AATRestHelper.LoadAPIConfig(ApiNo);
        AATRestHelper.Initialize('GET', AATRestHelper.GetAPIConfigBaseEndpoint() + SearchQuery);
        AATRestHelper.SetContentType('application/json');
        ReferenceID := TypeOfSearch + '/' + SearchQuery;
        AATRestHelper.Send(ReferenceID);

        AATJSONHelper.InitializeJsonObjectFromText(AATRestHelper.GetResponseContentAsText());
        ResponseObject := AATJSONHelper.GetJsonObject();
    end;

    local procedure GetAuthorDetails(AuthorID: Code[100]; OpenLibraryID: Code[100]; var Author: Record Author)
    var
        AATJSONHelper: Codeunit "AAT JSON Helper";
        ResponseObject, DataObject : JsonObject;
        SearchQuery, InputStringBirth, InputStringDeath : Text[100];
        // Author: Record Author;
        IsConverted: Boolean;
        JsonToken, LinesToken : JsonToken;
        LinesArray: JsonArray;
        AuthorExist: Label 'Author already exists';
        LibrarytableSetup: Record "Library table Setup";

    begin
        LibrarytableSetup.Get();
        SearchQuery := '/authors/' + AuthorID + '.json';
        SendGetRequest(AATJSONHelper, DataObject, SearchQuery, LibrarytableSetup."API No.", 'Author Personal Details');

        if Author.Get(AATJSONHelper.GetJsonTokenAsValue(DataObject, 'name').AsText()) then begin
            Message(AuthorExist);
            exit;
        end;
        // if DataObject.Get('personal_name', JsonToken) then
        // Author.Validate("Personal Name", AATJSONHelper.GetJsonTokenAsValue(DataObject, 'personal_name').AsText());
        Author.Validate("Personal Name", AATJSONHelper.SelectJsonValueAsText('$.personal_name', false));

        // if DataObject.Get('name', JsonToken) then
        //     Author.Validate(Name, AATJSONHelper.GetJsonTokenAsValue(DataObject, 'name').AsText());
        Author.Validate(Name, AATJSONHelper.SelectJsonValueAsText('$.name', false));

        // if DataObject.Get('bio', JsonToken) then
        //     Author.Validate(Bio, AATJSONHelper.GetJsonTokenAsValue(DataObject, 'bio').AsText());


        if ResponseObject.Get('bio', JsonToken) then
            if JsonToken.IsObject then begin
                // AATJSONHelper.GetJsonObject(ResponseObject, 'bio', DataObject);
                DataObject := JsonToken.AsObject();
                Author.Validate(Bio, AATJSONHelper.GetJsonTokenAsValue(DataObject, 'value').AsText());
            end
            else
                Author.Validate(Bio, AATJSONHelper.GetJsonTokenAsValue(ResponseObject, 'bio').AsText());

        SearchQuery := '/authors.json?q=' + Author.Name.Replace(' ', '+');
        SendGetRequest(AATJSONHelper, ResponseObject, SearchQuery, LibrarytableSetup."API No.", 'Author Extra Details');

        if AATJSONHelper.GetJsonArray(ResponseObject, 'docs', LinesArray) then begin
            foreach LinesToken in LinesArray do begin
                DataObject := LinesToken.AsObject();
                if AuthorID = AATJSONHelper.GetJsonTokenAsValue(DataObject, 'key').AsText() then begin

                    Author.Validate("Author ID", AuthorID);
                    Author.Validate("Open Library ID", OpenLibraryID);


                    // if DataObject.Get('birth_date', JsonToken) then
                    //     Author.Validate("Birth Date", AATJSONHelper.GetJsonTokenAsValue(DataObject, 'birth_date').AsText());
                    Author.Validate("Birth Date", AATJSONHelper.SelectJsonValueAsText('$.birth_date', false));

                    // if DataObject.Get('death_date', JsonToken) then
                    //     Author.Validate("Death Date", AATJSONHelper.GetJsonTokenAsValue(DataObject, 'death_date').AsText());
                    Author.Validate("Death Date", AATJSONHelper.SelectJsonValueAsText('$.death_date', false));
                    // if DataObject.Get('top_work', JsonToken) then
                    //     Author.Validate("Top Work", AATJSONHelper.GetJsonTokenAsValue(DataObject, 'top_work').AsText());
                    Author.Validate("Top Work", AATJSONHelper.SelectJsonValueAsText('$.top_work', false));
                    // if DataObject.Get('work_count', JsonToken) then
                    //     Author.Validate("Work Count", AATJSONHelper.GetJsonTokenAsValue(DataObject, 'work_count').AsText());
                    Author.Validate("Work Count", AATJSONHelper.SelectJsonValueAsText('$.work_count', false));
                end;
            end;
        end;
    end;

    local procedure ExtractAuthorID(var blankString: Text; var LinesArray2: JsonArray)
    var
        IsFirst: Boolean;
        LinesToken2: JsonToken;
    begin
        IsFirst := true;
        blankString := '';
        foreach LinesToken2 in LinesArray2 do begin
            if IsFirst <> true then
                blankString += ',' + LinesToken2.AsValue().AsText()
            else begin
                blankString += LinesToken2.AsValue().AsText();
                IsFirst := false;
            end;
        end;
    end;

}