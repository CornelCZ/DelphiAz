unit uEditPosFeatures;

(*
 * Unit contains form allowing user to view & edit the features enabled on a POS.
 *
 * Author: Hamish Martin, Edesix
 *)

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, DB;

type
  TEditPosFeaturesForm = class(TForm)
    FeatureListBox: TCheckListBox;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
  private
    // A dataset containing all the features which could be enabled on the currently
    // selected POS.  dataset has two columns: 'Feature Name' and
    // 'Whether User Selectable'
    featureList: TDataSet;
  public
    // Sets featureList and populates the list of POS features based on the currently
    // selected POS.
    procedure setupList;
    // Apply any changes made to the list back to the database.
    procedure applyChanges;
  end;

var
  EditPosFeaturesForm: TEditPosFeaturesForm;

implementation

uses uPdb;

{$R *.dfm}

{ TEditPosFeaturesForm }

// Populate the form based on the currently selected POS.
procedure TEditPosFeaturesForm.setupList;
var
  itemIndex: Integer;
  featName: string;
begin
  pdb.PosFeaturesTable.DisableControls;

  try
    // Get a list of features available for this type of POS.
    featureList := pdb.getFeaturesAvailableForPos(
      pdb.PosTableVersion.Value );

    // Clear the list, now add an item for each available feature
    FeatureListBox.Items.Clear;

    featureList.First;
    while not featureList.EOF do begin

      featName := featureList.FieldByName('Feature Name').AsString;

      if FeatureListBox.Items.IndexOf(featName) = -1 then begin // only add a feature once

        itemIndex := FeatureListBox.Items.Add( featName );

        // Only enable checkboxes for features which are optional.
        if featureList.FieldByName('Whether User Selectable').AsString = 'Y' then
          FeatureListBox.ItemEnabled[ itemIndex ] := not pdb.isMandatoryFeature( featName )
        else
          FeatureListBox.ItemEnabled[ itemIndex ] := false;

        // If the feature is optional, check the checkbox if the feature is currently
        // selected.  Non-optional features are always checked.
        if FeatureListBox.ItemEnabled[ itemIndex ] then
          FeatureListBox.Checked[ itemIndex ] := pdb.PosFeaturesTable.Locate(
            'Feature Name', featName, [] )
        else
          FeatureListBox.Checked[ itemIndex ] := true;

      end;

      featureList.Next;
    end;

  finally
    pdb.PosFeaturesTable.EnableControls;
  end;

end;

// Apply the list of features in the form onto the POS.
procedure TEditPosFeaturesForm.applyChanges;
var
  index: Integer;
  featureName: string;
begin
  pdb.PosFeaturesTable.DisableControls;
  try
    // First of all, remove features which appear in the table of features but which
    // aren't present and checked in our list.
    pdb.PosFeaturesTable.First;
    while not pdb.PosFeaturesTable.Eof do begin
      featureName := pdb.PosFeaturesTable.FieldByName('Feature Name').AsString;
      index := FeatureListBox.Items.IndexOf( featureName );

      if (index = -1) or (not FeatureListBox.Checked[index]) then
        pdb.PosFeaturesTable.Delete
      else
        pdb.PosFeaturesTable.Next;
    end;

    // Now look for items in our list which aren't present in the table and add them
    // to the table.
    for index := 0 to FeatureListBox.Items.Count - 1 do begin

      if FeatureListBox.Checked[ index ] then begin
        featureName := FeatureListBox.Items[ index ];

        if not pdb.PosFeaturesTable.Locate('Feature Name', featureName, []) then begin
          pdb.PosFeaturesTable.Insert;
          pdb.PosFeaturesTable['Feature Name'] := featureName;
          pdb.PosFeaturesTable.Post;
        end;

      end;
    end;

  finally
    pdb.PosFeaturesTable.EnableControls;
  end;

end;

end.
