codeunit 50300 "Search Book Api"
{
    trigger OnRun()
    begin

    end;

    procedure SearchBooks(SearchBook: Text; var TempLibrary: Record Library)
    var
        AATJSONHelper: Codeunit "AAT JSON Helper";

        SearchQuery, Token : Text;
        ResponseObject: JsonObject;
        LinesArray: JsonArray;
        LinesToken: JsonToken;
        Counter, Counter2 : Integer;
        DataObject: JsonObject;
        Year: Integer;
        FirstDayOfYear: Date;
        DataArray: array[10] of Text;
    begin
        SearchQuery := '?title=' + SearchBook.Replace(' ', '+');
        SendGetRequest(AATJSONHelper, ResponseObject, SearchQuery,'API00001');
        Counter := 0;
        Counter2 := 0;
        TempLibrary.DeleteAll();
        if AATJSONHelper.GetJsonArray(ResponseObject, 'docs', LinesArray) then
            foreach LinesToken in LinesArray do begin
                if Counter < 2 then begin

                    DataObject := LinesToken.AsObject();
                    TempLibrary.Init();
                    // TempLibrary.Validate("Book ID", Format(Counter));
                    TempLibrary.Validate(Title, AATJSONHelper.GetJsonTokenAsValue(DataObject, 'title').AsText());

                    year := AATJSONHelper.GetJsonTokenAsValue(DataObject, 'first_publish_year').AsInteger();
                    FirstDayOfYear := DMY2Date(1, 1, year);
                    TempLibrary.Validate("Publication Date", firstDayOfYear);


                    // foreach Token in DataObject do begin
                    //     // Convert each value to text and store it in the array
                    //     DataArray[Counter2] := Token.AsValue().AsText();
                    //     Counter2 += 1;

                    //     // Break if array is full
                    //     if Counter2 > ArrayLen(DataArray) then
                    //         break;
                    // end;


                    // TempLibrary.Validate(Author, AATJSONHelper.GetJsonTokenAsValue(DataObject, 'author_name').as());
                    TempLibrary.Validate("Book ID", AATJSONHelper.GetJsonTokenAsValue(DataObject, 'cover_i').AsCode());
                    TempLibrary.Validate(Description, AATJSONHelper.GetJsonTokenAsValue(DataObject, 'ia_collection_s').AsText());
                    TempLibrary.Insert(true);
                    Counter += 1;
                end
                else
                    exit;

            end;

        //             year := AATJSONHelper.GetJsonTokenAsValue(DataObject, 'first_publish_year').AsInteger();
        // TempLibrary.Validate("Publication Date", AATJSONHelper.GetJsonTokenAsValue(DataObject, 'first_publish_year').AsDate() + "/01/01");

        // if not AATRestHelper.Send() then begin
        //     if AATRestHelper.IsTransmitIssue() then
        //         Error('Failed to send Request. Check URL and try again.');


        // end;
    end;

    internal procedure SendGetRequest(var AATJSONHelper: Codeunit "AAT JSON Helper"; var ResponseObject: JsonObject; var SearchQuery: Text;ApiNo:Text)
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

    var
        myInt: Integer;
}