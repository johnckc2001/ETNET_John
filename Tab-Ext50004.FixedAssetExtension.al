tableextension 50004 "Fixed Asset Extension" extends "Fixed Asset"
{
    fields
    {
        field(50000; "Inventory Item No."; Code[20])
        {
            Caption = 'Inventory Item No.';
            DataClassification = ToBeClassified;
            TableRelation = Item;
        }
    }
}
