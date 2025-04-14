/// <summary>
/// Page Add Books (ID 50125).
/// </summary>
page 50125 "Add Books"
{
    // this page is used to display the fields that the user will use to enter the data of the book they want to add.
    // this page is also used to call the relevant procedures.


    PageType = Card;
    ApplicationArea = All;
    Caption = 'Add Book';
    SourceTable = Library;
    UsageCategory = Tasks;
    // CardPageID = "Book Info";

    layout
    {
        area(Content)
        {
            group("List of Books")
            {


                field(Title; Rec.Title)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field(Author; Rec.Author)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field(Rented; Rec.Rented)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field(Series; Rec.Series)
                {
                    ApplicationArea = All;
                }
                field(Genre; Rec.Genre)
                {
                    ApplicationArea = All;
                    // trigger OnValidate()
                    // begin
                    //    "Genre List".AsInteger(); 
                    // end;

                }
                field(Publisher; Rec.Publisher)
                {
                    ApplicationArea = All;
                }
                field("Book Price"; Rec."Book Price")
                {
                    ApplicationArea = All;
                }
                field("Publication Date"; Rec."Publication Date")
                {
                    ApplicationArea = All;
                }
                field(Pages; Rec.Pages)
                {
                    ApplicationArea = All;
                }
                field(Prequel; Rec.Prequel)
                {
                    ApplicationArea = All;
                }
                field(Sequel; Rec.Sequel)
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Amount Rented"; Rec."Amount Rented")
                {
                    ApplicationArea = All;
                }

            }

        }

    }

    actions
    {
        area(processing)
        {
            action(Save)
            {
                Caption = 'Save';
                ApplicationArea = All;
                Image = Action;
                trigger OnAction()
                var
                    Save: Codeunit "Library Functionality";
                begin

                    Save.save(Rec);
                    //   Error('Book could not be Saved');
                end;


            }

            action("Upload Image")

            {

                ApplicationArea = All;
                Promoted = true;
                Image = Import;
                Caption = 'Upload Image';
                trigger OnAction()
                var
                    ImageInStream: InStream;
                    FilePath: Text;
                begin
                    if not UploadIntoStream('Upload Image', '', '', FilePath, ImageInStream) then
                        exit;

                    Rec."Book Cover".ImportStream(ImageInStream, '');

                end;

            }
        }
    }
}