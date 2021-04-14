pageextension 50006 "Item Ledger Entry Extension" extends "Item Ledger Entries"
{
    layout
    {
        addafter("Entry No.")
        {
            field("Contract No."; "Contract No.")
            {
                ApplicationArea = all;
            }
            field("Service Item No."; "Service Item No.")
            {
                ApplicationArea = all;
            }
        }
    }
}
