codeunit 50232 "Clear Filters"
{

    procedure ClearFilter(var Library: Record Library)
    begin
        Library.Reset();
        
    end;

}