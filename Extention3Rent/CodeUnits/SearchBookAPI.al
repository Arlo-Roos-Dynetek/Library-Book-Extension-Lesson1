codeunit 50300 "Search Book Api"
{
    trigger OnRun()
    begin

    end;

    procedure SearchBooks(SearchBook: Text; var TempLibrary: Record Library)
    var
        AATJSONHelper: Codeunit "AAT JSON Helper";

        SearchQuery, SearchQuery2, blankString : Text;
        ResponseObject, ResponseObject2 : JsonObject;
        LinesArray, LinesArray2 : JsonArray;
        LinesToken, JsonToken : JsonToken;
        DataObject, DataObject2 : JsonObject;
        DataArray: array[10] of Text;
    begin
        SearchQuery := '?title=' + SearchBook.Replace(' ', '+') + '&page=1&limit=10';

        SendGetRequest(AATJSONHelper, ResponseObject, SearchQuery, 'API00001');


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

                SearchQuery2 := TempLibrary."Open Library ID" + '.json';
                SendGetRequest(AATJSONHelper, ResponseObject2, SearchQuery2, 'API00002');

                if ResponseObject2.Get('description', JsonToken) then
                    if JsonToken.IsObject then begin
                        AATJSONHelper.GetJsonObject(ResponseObject2, 'description', DataObject2);
                        TempLibrary.Validate(Description, AATJSONHelper.GetJsonTokenAsValue(DataObject2, 'value').AsText());
                    end
                    else
                        TempLibrary.Validate(Description, AATJSONHelper.GetJsonTokenAsValue(ResponseObject2, 'description').AsText());

                AATJSONHelper.GetJsonObject(ResponseObject2, 'created', DataObject2);
                TempLibrary.Validate("Date Created", DT2Date(AATJSONHelper.GetJsonTokenAsValue(DataObject2, 'value').AsDateTime()));
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

    internal procedure SendGetRequest(var AATJSONHelper: Codeunit "AAT JSON Helper"; var ResponseObject: JsonObject; var SearchQuery: Text; ApiNo: Text)
    var
        AATRestHelper: Codeunit "AAT REST Helper";
    begin
        AATRestHelper.LoadAPIConfig(ApiNo);
        AATRestHelper.Initialize('GET', AATRestHelper.GetAPIConfigBaseEndpoint() + SearchQuery);
        AATRestHelper.SetContentType('application/json');
        AATRestHelper.Send();

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

    begin

        SearchQuery := '/' + AuthorID + '.json';
        SendGetRequest(AATJSONHelper, DataObject, SearchQuery, 'API00004');

        if Author.Get(AATJSONHelper.GetJsonTokenAsValue(DataObject, 'name').AsText()) then begin
            Message(AuthorExist);
            exit;
        end;
        if DataObject.Get('personal_name', JsonToken) then
            Author.Validate("Personal Name", AATJSONHelper.GetJsonTokenAsValue(DataObject, 'personal_name').AsText());
        if DataObject.Get('name', JsonToken) then
            Author.Validate(Name, AATJSONHelper.GetJsonTokenAsValue(DataObject, 'name').AsText());

        // if DataObject.Get('bio', JsonToken) then
        //     Author.Validate(Bio, AATJSONHelper.GetJsonTokenAsValue(DataObject, 'bio').AsText());


 if ResponseObject.Get('bio', JsonToken) then
                    if JsonToken.IsObject then begin
                        AATJSONHelper.GetJsonObject(ResponseObject, 'bio', DataObject);
                        Author.Validate(Bio, AATJSONHelper.GetJsonTokenAsValue(DataObject, 'value').AsText());
                    end
                    else
                        Author.Validate(Bio, AATJSONHelper.GetJsonTokenAsValue(ResponseObject, 'bio').AsText());

        SearchQuery := '?q=' + Author.Name.Replace(' ', '+');
        SendGetRequest(AATJSONHelper, ResponseObject, SearchQuery, 'API00003');

        if AATJSONHelper.GetJsonArray(ResponseObject, 'docs', LinesArray) then begin
            foreach LinesToken in LinesArray do begin
                DataObject := LinesToken.AsObject();
                if AuthorID = AATJSONHelper.GetJsonTokenAsValue(DataObject, 'key').AsText() then begin

                    Author.Validate("Author ID", AuthorID);
                    Author.Validate("Open Library ID", OpenLibraryID);


                    if DataObject.Get('birth_date', JsonToken) then
                        Author.Validate("Birth Date", AATJSONHelper.GetJsonTokenAsValue(DataObject, 'birth_date').AsText());
                    if DataObject.Get('death_date', JsonToken) then
                        Author.Validate("Death Date", AATJSONHelper.GetJsonTokenAsValue(DataObject, 'death_date').AsText());
                    if DataObject.Get('top_work', JsonToken) then
                        Author.Validate("Top Work", AATJSONHelper.GetJsonTokenAsValue(DataObject, 'top_work').AsText());
                    if DataObject.Get('work_count', JsonToken) then
                        Author.Validate("Work Count", AATJSONHelper.GetJsonTokenAsValue(DataObject, 'work_count').AsText());
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