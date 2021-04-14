tableextension 50007 "Item Ledger Entry Extension" extends "Item Ledger Entry"
{
    fields
    {
        field(50000; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
        }
        field(50001; "Service Item No."; Code[20])
        {
            Caption = 'Service Item No.';
            DataClassification = ToBeClassified;
        }
    }
}
