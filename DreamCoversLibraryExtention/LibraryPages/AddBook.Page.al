page 50125 "Add Books"
{
    PageType = Card;
    ApplicationArea = All;
    Caption = 'Add Book';
    SourceTable = Library;
    UsageCategory = Documents;
     CardPageID = "Book Info";

    layout
    {
        area(Content)
        {
            group("List of Books")
            {
                

                field(Title; Rec.Title)
                {
                    Editable = true;

                }
                field(Author; Rec.Author)
                {
                    Editable = true;
                }
                field(Rented; Rec.Rented)
                {
                    Editable = true;
                }
                field(Series; Rec.Series)
                {
                    ApplicationArea = All;
                }
                field(Genre; Rec.Genre)
                {
                    ApplicationArea = All;
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
                    Save: Codeunit  "Save Books";
                begin
                    Save.save(Rec);
                end;

      } 
    } 
   }

    var
        myInt: Integer;
}