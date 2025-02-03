codeunit 50232 "Clear Filters"
{
// This procedure clears all the filters
    procedure ClearFilter(var Library: Record Library)
    begin
        Library.Reset();
        
    end;

}