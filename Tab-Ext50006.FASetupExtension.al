tableextension 50006 "FA Setup Extension" extends "FA Setup"
{
    fields
    {
        field(50000; "Item Journal Batch"; Code[20])
        {
            Caption = 'Item Journal Batch';
            DataClassification = ToBeClassified;
            TableRelation = "Item Journal Batch".Name where("Journal Template Name" = filter('ITEM'));
        }
        field(50001; "Default Location"; Code[20])
        {
            Caption = 'Default Location';
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
    }
}
