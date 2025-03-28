pageextension 50300 "Book Card Page EXT" extends "Book Info"
{
    layout
    {
        addafter("Date Added")
        {
            field(Description; DescriptionData)
            {
                Caption = 'Description';
                ToolTip = 'This field gives you more information regarding the contents of the book.';
                ApplicationArea = All;

                MultiLine = true;

            }

        }
    }

    actions
    {
        // Add changes to page actions here
    }

    trigger OnAfterGetRecord()
    var
        InStream: InStream;
    begin
        Rec.CalcFields(Description);
        if rec.Description.HasValue then begin
            Rec.Description.CreateInStream(InStream);
            InStream.ReadText(DescriptionData)
        end;

    end;

    var
        DescriptionData: Text;
}