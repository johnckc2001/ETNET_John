tableextension 50005 "Item Journal Line Extension" extends "Item Journal Line"
{
    fields
    {
        field(50000; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
            TableRelation = "Sales Header"."No.";
        }
        field(50001; "Service Item No."; Code[20])
        {
            Caption = 'Service Item No.';
            DataClassification = ToBeClassified;
            TableRelation = Item;
        }
    }
}
